#include <lib/gcc.h>
#include <lib/x86.h>
#include <lib/debug.h>

#include "import.h"

#define PT_PERM_UP  0
#define PT_PERM_PTU (PTE_P | PTE_W | PTE_U)
//PTE_P: Page present
//PTE_W: Write permission
//PTE_U: User Access

/**
 * Page directory pool for NUM_IDS processes.
 * mCertiKOS maintains one page structure for each process.
 * Each PDirPool[index] represents the page directory of the page structure
 * for the process # [index].
 * In mCertiKOS, we statically allocate page directories, and maintain the second
 * level page tables dynamically.
 * The unsigned int * type is meant to suggest that the contents of the array
 * are pointers to page tables. In reality they are actually page directory
 * entries, which are essentially pointers plus permission bits. The functions
 * in this layer will require casting between integers and pointers anyway and
 * in fact any 32-bit type is fine, so feel free to change it if it makes more
 * sense to you with a different type.
 */
unsigned int *PDirPool[NUM_IDS][1024] gcc_aligned(PAGESIZE); 
// ->Page Directory Pool
// ->(PAGESIZE) alligns memory to a multiple of its size (gcc_specific attribute)


/**
 * In mCertiKOS, we use identity page table mappings for the kernel memory.
 * IDPTbl is an array of statically allocated identity page tables that will be
 * reused for all the kernel memory.
 * That is, in every page directory, the entries that fall into the range of
 * addresses reserved for the kernel will point to an entry in IDPTbl.
 */
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);
// ->Identity Page Table
// ->Kernel can have direct mappings where virtual address = physical address

// Sets the CR3 register with the start address of the page structure for process # [index].
void set_pdir_base(unsigned int index)
{
    set_cr3(PDirPool[index]);
    //cr3 registers are control registers
    //set_cr3 -> mboot.c (calls lcr3)
    //lcr3 -> inline assembly code block, moves a value from a register to cr4
    //In this case the register is the pdir currently active process
}

// Returns the page directory entry # [pde_index] of the process # [proc_index].
// This can be used to test whether the page directory entry is mapped.
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    return (unsigned int)PDirPool[proc_index][pde_index];
}

// Sets the specified page directory entry with the start address of physical
// page # [page_index].
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int page_index)
{
    unsigned int value = (page_index << 12) | PT_PERM_PTU; 
    PDirPool[proc_index][pde_index] = (unsigned int *)value;
    //4KB = 2^12
    //It takes 12 bits to address any byte within a single page
    //As a resutl the last 12 bits are 0s in a 32bit system
    //Page 0: 0000 0000 0000 0000 0000 0000 0000 0000
    //Page 1: 0000 0000 0000 0000 0001 0000 0000 0000
    //Page 2: 0000 0000 0000 0000 0010 0000 0000 0000
    //Shifting page_index by 12 finds the physical memory address which
    //can be placed in place

}

// Sets the page directory entry # [pde_index] for the process # [proc_index]
// with the initial address of page directory # [pde_index] in IDPTbl.
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
// This will be used to map a page directory entry to an identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{
    unsigned int value = (unsigned int)IDPTbl[pde_index];
    value |= PT_PERM_PTU;
    PDirPool[proc_index][pde_index] = (unsigned int *)value;

    //Configuring the page directory entry for a specific process to point ot am identity page table
    //Columns: Page Table Entries
    //Rows: Page Directory
    /*
        +-----------------+-----------------+-----------------+ ... (up to 1024 columns)
        |  Page Directory 0|  Page Directory 0|  Page Directory 0|
        +-----------------+-----------------+-----------------+
        | Entry 0         | Entry 1         | Entry 2         | ... 
        | Entry 3         | Entry 4         | Entry 5         | ...
        | ...             | ...             | ...             | ...
        +-----------------+-----------------+-----------------+
        |  Page Directory 1|  Page Directory 1|  Page Directory 1|
        +-----------------+-----------------+-----------------+
        | Entry 0         | Entry 1         | Entry 2         | ...
        | Entry 3         | Entry 4         | Entry 5         | ...
        | ...             | ...             | ...             | ...
        +-----------------+-----------------+-----------------+
        | ...             | ...             | ...             | ...
        +-----------------+-----------------+-----------------+
    */
   //We first get the starting address of the entry in the IDPT
   //We bitwise OR it with the permission bits
   //We set this to the PDirPool


}

// Removes the specified page directory entry (sets the page directory entry to 0).
// Don't forget to cast the value to (unsigned int *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    PDirPool[proc_index][pde_index] = (unsigned int *)0x00000000;
    //To ensure that it is a pointer
}

// Returns the specified page table entry.
// Do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                            unsigned int pte_index)
{
    unsigned int pte_addr = (unsigned int )PDirPool[proc_index][pde_index];
    pte_addr &= 0xfffff000; //remove perm bits
    //1111 1111 1111 1111 1111 0000 0000 0000
    pte_addr += pte_index << 2;//
    return *(unsigned int *)pte_addr;

    //Retrieves a page table for a process
    //&operation clears the last 12 bits
    //Each entry in the table is 4 bytes so we multiply by 4 to get the specific address
    //*(unsigned int*) dereferances the calcualted addresses so we find the value stored there
    //We casted to (unsigned int *) first so that the compiler treats it as an adress
    //we *the address to find its contents
}

// Sets the specified page table entry with the start address of physical page # [page_index]
// You should also set the given permission.
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index, unsigned int page_index,
                    unsigned int perm)
{
    unsigned int* pte;
    unsigned int pte_addr =  (unsigned int )PDirPool[proc_index][pde_index];
    pte_addr &= 0xfffff000;//rmove perm bits
    pte_addr += pte_index << 2;

    pte = (unsigned int *)pte_addr;
    *pte &= 0x00000000;
    *pte = page_index << 12; 
    *pte |= (perm & 0x00000fff); //Give user access permission only
}

// Sets up the specified page table entry in IDPTbl as the identity map.
// You should also set the given permission.
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index,
                             unsigned int perm)
{
    IDPTbl[pde_index][pte_index] = ((pde_index << 10) + pte_index) << 12;
    IDPTbl[pde_index][pte_index] |= perm;

    //<<10 shifts to the 1024 format -> remember we would multiply by 4 for page pool directory
    //then the page index is added
    //then permission is added
}

// Sets the specified page table entry to 0.
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index)
{
    unsigned int * pte;
    unsigned int pte_addr = (unsigned int)PDirPool[proc_index][pde_index];
    pte_addr &= 0xfffff000;//remove perm bits
    pte_addr += pte_index << 2;
    pte = (unsigned int *)pte_addr;
    *pte &= 0x00000000;

    //PDirPool has permission bits which must be removed 
    //Now we can multiply by 4 for the actual address
    //Typecast to unsigned int pointer to point to the specific address
    //Set value in that address to 0
}