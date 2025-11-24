#include <lib/gcc.h>
#include <lib/x86.h>
#include <lib/debug.h>
#include <thread/PTCBIntro/export.h>
#include "import.h"

// Current running thread ID
static unsigned int current_thread = 0;

void thread_init(unsigned int mbi_addr)
{
    tqueue_init(mbi_addr);
    set_curid(0);
    tcb_set_state(0, TSTATE_RUN);
}

/**
 * Allocates a new child thread context, sets the state of the new child thread
 * to ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
    // TODO
    return 0;
}

/**
 * Yield to the next thread in the ready queue.
 * You should set the currently running thread state as ready,
 * and push it back to the ready queue.
 * Then set the state of the popped thread as running, set the
 * current thread id, and switch to the new kernel context.
 * Hint: If you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
    // TODO
}

/**
 * Create a new thread
 * 
 * @param parent_id The parent thread ID
 * @param handler Function pointer to thread's entry point
 * @return The new thread ID or -1 on failure
 */
int thread_create(unsigned int parent_id, void (*handler)(void)) {
    // Find an available TCB slot
    int child_id = -1;
    for (unsigned int i = 0; i < NUM_THREADS; i++) {
        if (TCB[i].status == TSTATE_UNUSED) {
            child_id = i;
            break;
        }
    }
    
    // No available TCB found
    if (child_id == -1) {
        return -1;
    }
    
    // Initialize the TCB for the new thread
    if (thread_init(child_id, parent_id) != 0) {
        return -1;
    }
    
    // Allocate stack for the new thread
    unsigned int stack_addr = alloc_stack();
    if (stack_addr == 0) {
        TCB[child_id].status = TSTATE_UNUSED;
        return -1;
    }
    
    // Create execution context for the new thread
    if (kctx_new(child_id, handler, stack_addr) != 0) {
        free_stack(stack_addr);
        TCB[child_id].status = TSTATE_UNUSED;
        return -1;
    }
    
    // Mark thread as ready to run
    TCB[child_id].status = TSTATE_READY;
    
    return child_id;
}

/**
 * Switch to another thread
 * 
 * @param target_id The thread ID to switch to
 * @return 0 on success, non-zero on failure
 */
int thread_switch(unsigned int target_id) {
    // Check if target ID is valid
    if (target_id >= NUM_THREADS || TCB[target_id].status != TSTATE_READY) {
        return -1;
    }
    
    // Save current thread's context
    unsigned int prev_id = current_thread;
    
    // Update thread states
    TCB[prev_id].status = TSTATE_READY;
    TCB[target_id].status = TSTATE_RUNNING;
    current_thread = target_id;
    
    // Perform context switch
    switch_context((struct context *)TCB[prev_id].context_struct, 
                   (struct context *)TCB[target_id].context_struct);
    
    return 0;
}

/**
 * Get the current thread ID
 * 
 * @return Current thread ID
 */
unsigned int thread_get_current(void) {
    return current_thread;
}
