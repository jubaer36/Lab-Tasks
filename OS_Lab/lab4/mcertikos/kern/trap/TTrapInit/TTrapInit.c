#include <lib/trap.h>
#include <lib/debug.h>
#include <lib/string.h>
#include <dev/intr.h>
#include "import.h"

#define KERN_INFO_CPU(str, idx) \
    if (idx == 0) KERN_INFO("[BSP KERN] " str); \
    else KERN_INFO("[AP%d KERN] " str, idx);

int inited = FALSE;

trap_cb_t TRAP_HANDLER[NUM_CPUS][256];

void trap_init_array(void)
{
    KERN_ASSERT(inited == FALSE);
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
    inited = TRUE;
}

void trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
    KERN_ASSERT(0 <= trapno && trapno < 256);
    KERN_ASSERT(cb != NULL);

    TRAP_HANDLER[cpu_idx][trapno] = cb;
}

void trap_init(unsigned int cpu_idx)
{
    if (cpu_idx == 0) {
        trap_init_array();
    }

    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);

    // Register all trap handlers
    set_trap_handler(INT_DIVIDE, handle_divide);
    set_trap_handler(INT_DEBUG, handle_debug);
    set_trap_handler(INT_NMI, handle_nmi);
    set_trap_handler(INT_BREAK, handle_break);
    set_trap_handler(INT_OVERFLOW, handle_overflow);
    set_trap_handler(INT_BOUNDS, handle_bounds);
    set_trap_handler(INT_INVALID_OP, handle_invalid_op);
    set_trap_handler(INT_DEVICE, handle_device);
    set_trap_handler(INT_DOUBLE_FAULT, handle_double_fault);
    set_trap_handler(INT_INVALID_TSS, handle_invalid_tss);
    set_trap_handler(INT_SEG_NOT_PRESENT, handle_seg_not_present);
    set_trap_handler(INT_STACK, handle_stack);
    set_trap_handler(INT_GP_FAULT, handle_gp_fault);
    set_trap_handler(INT_PAGE_FAULT, handle_page_fault);
    set_trap_handler(INT_FP_ERROR, handle_fp_error);
    set_trap_handler(INT_ALIGN_CHECK, handle_align_check);
    set_trap_handler(INT_MACHINE_CHECK, handle_machine_check);
    set_trap_handler(INT_SIMD_ERROR, handle_simd_error);
    set_trap_handler(INT_SYSCALL, handle_syscall);

    KERN_INFO_CPU("Done.\n", cpu_idx);
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);

    /* enable interrupts */
    intr_enable(IRQ_TIMER, cpu_idx);
    intr_enable(IRQ_KBD, cpu_idx);
    intr_enable(IRQ_SERIAL13, cpu_idx);

    KERN_INFO_CPU("Done.\n", cpu_idx);
}
