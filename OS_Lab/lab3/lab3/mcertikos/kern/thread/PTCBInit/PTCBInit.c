#include <lib/gcc.h>
#include <lib/x86.h>
#include <lib/debug.h>
#include <thread/PTCBIntro/export.h>
#include "import.h"

/**
 * Initializes the TCB for all NUM_IDS threads with the state TSTATE_DEAD,
 * and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
    // TODO: define your local variables here.

    paging_init(mbi_addr);

    // TODO
}

/**
 * Initialize the TCB for a new thread.
 * 
 * @param child_id The ID of the new thread
 * @param parent_id The parent thread ID
 * @return 0 on success, non-zero on failure
 */
int thread_init(unsigned int child_id, unsigned int parent_id) {
    // Check if IDs are valid
    if (child_id >= NUM_THREADS || parent_id >= NUM_THREADS) {
        return -1;
    }
    
    // Initialize the child thread's TCB
    TCB[child_id].status = TSTATE_CREATED;
    TCB[child_id].parent_id = parent_id;
    TCB[child_id].stack_addr = 0;  // Will be set later
    TCB[child_id].context_struct = 0;  // Will be set later
    
    return 0;
}
