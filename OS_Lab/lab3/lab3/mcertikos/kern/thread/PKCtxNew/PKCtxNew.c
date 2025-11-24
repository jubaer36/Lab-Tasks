#include <lib/gcc.h>
#include <lib/x86.h>
#include <lib/debug.h>
#include <thread/PTCBIntro/export.h>
#include "import.h"

/**
 * Allocate and initialize a new execution context
 * 
 * @param id Thread ID
 * @param handler Function pointer to thread's entry point
 * @param stack_addr Stack address for the new thread
 * @return 0 on success, non-zero on failure
 */
int kctx_new(unsigned int id, void (*handler)(void), unsigned int stack_addr) {
    // Check if ID is valid
    if (id >= NUM_THREADS) {
        return -1;
    }
    
    // Allocate a context structure
    struct context *ctx = alloc_context();
    if (!ctx) {
        return -1;
    }
    
    // Configure initial register values for the new context
    ctx->eip = (unsigned int)handler;  // Set instruction pointer to handler
    ctx->esp = stack_addr;             // Set stack pointer
    ctx->ebp = stack_addr;             // Set base pointer
    
    // Zero out general purpose registers
    ctx->eax = 0;
    ctx->ebx = 0;
    ctx->ecx = 0;
    ctx->edx = 0;
    ctx->esi = 0;
    ctx->edi = 0;
    
    // Save context pointer in TCB
    TCB[id].context_struct = (unsigned int)ctx;
    TCB[id].stack_addr = stack_addr;
    
    return 0;
}
