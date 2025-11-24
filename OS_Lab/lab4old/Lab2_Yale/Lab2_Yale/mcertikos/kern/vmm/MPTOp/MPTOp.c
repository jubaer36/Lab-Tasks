#include <lib/x86.h>

#include "import.h"

#define VA_PDIR_MASK 0xFFC00000 //Gets the page directory index (first 10 bits)
#define VA_PTBL_MASK 0x3FF000 //Covers bits 16-21 ot get page table index
#define VM_USERLO  0x40000000
#define VM_USERHI  0xF0000000
#define PT_PERM_PWG (PTE_P | PTE_W | PTE_G) // Present, write, global
#define PT_PERM_PW (PTE_P | PTE_W) // Not global

/*
VA Structure:
    |   31-22    |   21-12     |    11-0      |
    |  PDE Index |  PTE Index  |   Offset     |

*/


/**
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index = (vaddr & VA_PDIR_MASK) >> 22;
    unsigned int pte_index = (vaddr & VA_PTBL_MASK) >> 12;

    unsigned int pde = get_pdir_entry(proc_index, pde_index);
    // check the present bit of page directory entry
    if ((pde & PTE_P) == 0) {
        return 0;
    }
    unsigned int pte = get_ptbl_entry(proc_index, pde_index, pte_index);
    //check the present bit of page table entry
    if ((pte & PTE_P) == 0) {
        return 0;
    }
    return pte;
}

// Returns the page directory entry corresponding to the given virtual address.
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index = (vaddr & VA_PDIR_MASK) >> 22;
    unsigned int pde = get_pdir_entry(proc_index, pde_index);
    return pde;
}

// Removes the page table entry for the given virtual address.
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index = (vaddr & VA_PDIR_MASK) >> 22;
    unsigned int pte_index = (vaddr & VA_PTBL_MASK) >> 12;

    unsigned int pde = get_pdir_entry(proc_index, pde_index);
    // check the present bit of page directory entry
    if ((pde & PTE_P) == 0) {
    // the page directory entry is not valid for address translation
        return;
    }
    rmv_ptbl_entry(proc_index, pde_index, pte_index);

    //removes the page table entry associated with a specified virtual address for a given process
}

// Removes the page directory entry for the given virtual address.
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
    unsigned int pde_index = (vaddr & VA_PDIR_MASK) >> 22;
    rmv_pdir_entry(proc_index, pde_index);
    //removes the page directory entry corresponding to a given virtual address for a specific process 
    //by calculating the page directory entry index from the virtual address
}

// Maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm].
// You do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index, unsigned int perm)
{
    unsigned int pde_index = (vaddr & VA_PDIR_MASK) >> 22;
    unsigned int pte_index = (vaddr & VA_PTBL_MASK) >> 12;
    set_ptbl_entry(proc_index, pde_index, pte_index, page_index, perm);
    
    //sets a page table entry for a specific virtual address by extracting 
    //the page directory and page table indices from the virtual address
    //then calls the set_ptbl_entry function to map the virtual address to a physical page with the given permissions
}

// Registers the mapping from [vaddr] to physical page # [page_index] in the page directory.
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index)
{
    unsigned int pde_index = (vaddr & VA_PDIR_MASK) >> 22;
    set_pdir_entry(proc_index, pde_index, page_index);

    //sets a page directory entry for a specific virtual address
    //by extracting the page directory index from the virtual address, and then calls the set_pdir_entry

}

// Initializes the identity page table.
// The permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// While the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_addr)
{
    container_init(mbi_addr);

    unsigned int addr;
    for (addr = 0; addr < 0xFFFFF000; addr += PAGESIZE) {
        unsigned int pde_index = (addr & VA_PDIR_MASK) >> 22;
        unsigned int pte_index = (addr & VA_PTBL_MASK) >> 12;
        if (addr < VM_USERLO || addr >= VM_USERHI) {
            //kernel pages
            set_ptbl_entry_identity(pde_index, pte_index, PT_PERM_PWG);
        }
        else {
            //not kernel pages
            set_ptbl_entry_identity(pde_index, pte_index, PT_PERM_PW);
        }
        //kernel is global but other pages are not
    }
}