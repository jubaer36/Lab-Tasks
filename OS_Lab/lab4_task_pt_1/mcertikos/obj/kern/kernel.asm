
obj/kern/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <pmmap_init.cold>:
  100000:	80 7c 24 2f 00       	cmpb   $0x0,0x2f(%esp)
  100005:	8b 7c 24 20          	mov    0x20(%esp),%edi
  100009:	74 06                	je     100011 <pmmap_init.cold+0x11>
  10000b:	89 bd 84 76 02 00    	mov    %edi,0x27684(%ebp)
    int sublist_nr;

    /*
     * Step 1: Merge overlapped entries in pmmap_list.
     */
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100011:	80 7c 24 14 00       	cmpb   $0x0,0x14(%esp)
  100016:	74 0a                	je     100022 <pmmap_init.cold+0x22>
  100018:	c7 85 88 76 02 00 80 	movl   $0x80,0x27688(%ebp)
  10001f:	00 00 00 
        KERN_PANIC("More than 128 E820 entries.\n");
  100022:	50                   	push   %eax
  100023:	8d 85 2e 81 ff ff    	lea    -0x7ed2(%ebp),%eax
  100029:	89 eb                	mov    %ebp,%ebx
  10002b:	50                   	push   %eax
  10002c:	8d 85 4b 81 ff ff    	lea    -0x7eb5(%ebp),%eax
  100032:	6a 3c                	push   $0x3c
  100034:	50                   	push   %eax
  100035:	e8 26 41 00 00       	call   104160 <debug_panic>
    free_slot->start = start;
  10003a:	31 d2                	xor    %edx,%edx
  10003c:	89 15 00 00 00 00    	mov    %edx,0x0
  100042:	0f 0b                	ud2
  100044:	66 90                	xchg   %ax,%ax
  100046:	66 90                	xchg   %ax,%ax
  100048:	66 90                	xchg   %ax,%ax
  10004a:	66 90                	xchg   %ax,%ax
  10004c:	66 90                	xchg   %ax,%ax
  10004e:	66 90                	xchg   %ax,%ax

00100050 <video_init>:
    unsigned pos;

    /* Get a pointer to the memory-mapped text display buffer. */
    cp = (uint16_t *) CGA_BUF;
    was = *cp;
    *cp = (uint16_t) 0xA55A;
  100050:	b9 5a a5 ff ff       	mov    $0xffffa55a,%ecx
{
  100055:	57                   	push   %edi
  100056:	56                   	push   %esi
  100057:	53                   	push   %ebx
    was = *cp;
  100058:	0f b7 15 00 80 0b 00 	movzwl 0xb8000,%edx
    *cp = (uint16_t) 0xA55A;
  10005f:	e8 3e 03 00 00       	call   1003a2 <__x86.get_pc_thunk.bx>
  100064:	81 c3 90 0f 01 00    	add    $0x10f90,%ebx
  10006a:	66 89 0d 00 80 0b 00 	mov    %cx,0xb8000
    if (*cp != 0xA55A) {
  100071:	0f b7 05 00 80 0b 00 	movzwl 0xb8000,%eax
  100078:	66 3d 5a a5          	cmp    $0xa55a,%ax
  10007c:	0f 84 96 00 00 00    	je     100118 <video_init+0xc8>
        cp = (uint16_t *) MONO_BUF;
        addr_6845 = MONO_BASE;
        dprintf("addr_6845:%x\n", addr_6845);
  100082:	83 ec 08             	sub    $0x8,%esp
  100085:	8d 83 0c 80 ff ff    	lea    -0x7ff4(%ebx),%eax
        cp = (uint16_t *) MONO_BUF;
  10008b:	bf 00 00 0b 00       	mov    $0xb0000,%edi
        addr_6845 = MONO_BASE;
  100090:	c7 83 18 70 02 00 b4 	movl   $0x3b4,0x27018(%ebx)
  100097:	03 00 00 
        dprintf("addr_6845:%x\n", addr_6845);
  10009a:	68 b4 03 00 00       	push   $0x3b4
  10009f:	50                   	push   %eax
  1000a0:	e8 2b 43 00 00       	call   1043d0 <dprintf>
  1000a5:	83 c4 10             	add    $0x10,%esp
        addr_6845 = CGA_BASE;
        dprintf("addr_6845:%x\n", addr_6845);
    }

    /* Extract cursor location */
    outb(addr_6845, 14);
  1000a8:	83 ec 08             	sub    $0x8,%esp
  1000ab:	6a 0e                	push   $0xe
  1000ad:	ff b3 18 70 02 00    	push   0x27018(%ebx)
  1000b3:	e8 c8 4e 00 00       	call   104f80 <outb>
    pos = inb(addr_6845 + 1) << 8;
  1000b8:	8b 83 18 70 02 00    	mov    0x27018(%ebx),%eax
  1000be:	83 c0 01             	add    $0x1,%eax
  1000c1:	89 04 24             	mov    %eax,(%esp)
  1000c4:	e8 87 4e 00 00       	call   104f50 <inb>
  1000c9:	0f b6 f0             	movzbl %al,%esi
    outb(addr_6845, 15);
  1000cc:	58                   	pop    %eax
  1000cd:	5a                   	pop    %edx
  1000ce:	6a 0f                	push   $0xf
  1000d0:	ff b3 18 70 02 00    	push   0x27018(%ebx)
    pos = inb(addr_6845 + 1) << 8;
  1000d6:	c1 e6 08             	shl    $0x8,%esi
    outb(addr_6845, 15);
  1000d9:	e8 a2 4e 00 00       	call   104f80 <outb>
    pos |= inb(addr_6845 + 1);
  1000de:	8b 83 18 70 02 00    	mov    0x27018(%ebx),%eax
  1000e4:	83 c0 01             	add    $0x1,%eax
  1000e7:	89 04 24             	mov    %eax,(%esp)
  1000ea:	e8 61 4e 00 00       	call   104f50 <inb>

    terminal.crt_buf = (uint16_t *) cp;
    terminal.crt_pos = pos;
    terminal.active_console = 0;
}
  1000ef:	83 c4 10             	add    $0x10,%esp
    terminal.crt_buf = (uint16_t *) cp;
  1000f2:	89 bb 0c 70 02 00    	mov    %edi,0x2700c(%ebx)
    terminal.active_console = 0;
  1000f8:	c7 83 14 70 02 00 00 	movl   $0x0,0x27014(%ebx)
  1000ff:	00 00 00 
    pos |= inb(addr_6845 + 1);
  100102:	0f b6 c0             	movzbl %al,%eax
  100105:	09 f0                	or     %esi,%eax
    terminal.crt_pos = pos;
  100107:	66 89 83 10 70 02 00 	mov    %ax,0x27010(%ebx)
}
  10010e:	5b                   	pop    %ebx
  10010f:	5e                   	pop    %esi
  100110:	5f                   	pop    %edi
  100111:	c3                   	ret
  100112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        dprintf("addr_6845:%x\n", addr_6845);
  100118:	83 ec 08             	sub    $0x8,%esp
  10011b:	8d 83 0c 80 ff ff    	lea    -0x7ff4(%ebx),%eax
    cp = (uint16_t *) CGA_BUF;
  100121:	bf 00 80 0b 00       	mov    $0xb8000,%edi
        *cp = was;
  100126:	66 89 15 00 80 0b 00 	mov    %dx,0xb8000
        dprintf("addr_6845:%x\n", addr_6845);
  10012d:	68 d4 03 00 00       	push   $0x3d4
  100132:	50                   	push   %eax
        addr_6845 = CGA_BASE;
  100133:	c7 83 18 70 02 00 d4 	movl   $0x3d4,0x27018(%ebx)
  10013a:	03 00 00 
        dprintf("addr_6845:%x\n", addr_6845);
  10013d:	e8 8e 42 00 00       	call   1043d0 <dprintf>
  100142:	83 c4 10             	add    $0x10,%esp
  100145:	e9 5e ff ff ff       	jmp    1000a8 <video_init+0x58>
  10014a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100150 <video_putc>:

void video_putc(int c)
{
  100150:	56                   	push   %esi
  100151:	53                   	push   %ebx
  100152:	e8 4b 02 00 00       	call   1003a2 <__x86.get_pc_thunk.bx>
  100157:	81 c3 9d 0e 01 00    	add    $0x10e9d,%ebx
  10015d:	83 ec 04             	sub    $0x4,%esp
  100160:	8b 54 24 10          	mov    0x10(%esp),%edx
    // if no attribute given, then use black on white
    if (!(c & ~0xFF))
        c |= 0x0700;
  100164:	89 d0                	mov    %edx,%eax
  100166:	80 cc 07             	or     $0x7,%ah
  100169:	81 fa 00 01 00 00    	cmp    $0x100,%edx
  10016f:	0f 42 d0             	cmovb  %eax,%edx

    switch (c & 0xff) {
  100172:	0f b6 c2             	movzbl %dl,%eax
  100175:	83 f8 0a             	cmp    $0xa,%eax
  100178:	0f 84 9c 01 00 00    	je     10031a <video_putc+0x1ca>
  10017e:	0f 8f 4c 01 00 00    	jg     1002d0 <video_putc+0x180>
  100184:	83 f8 08             	cmp    $0x8,%eax
  100187:	0f 84 ae 00 00 00    	je     10023b <video_putc+0xeb>
  10018d:	83 f8 09             	cmp    $0x9,%eax
  100190:	0f 85 64 01 00 00    	jne    1002fa <video_putc+0x1aa>
        /* fallthru */
    case '\r':
        terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
        break;
    case '\t':
        video_putc(' ');
  100196:	83 ec 0c             	sub    $0xc,%esp
  100199:	6a 20                	push   $0x20
  10019b:	e8 b0 ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001a0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001a7:	e8 a4 ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001ac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001b3:	e8 98 ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001b8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001bf:	e8 8c ff ff ff       	call   100150 <video_putc>
        video_putc(' ');
  1001c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1001cb:	e8 80 ff ff ff       	call   100150 <video_putc>
    default:
        terminal.crt_buf[terminal.crt_pos++] = c;  /* write the character */
        break;
    }

    if (terminal.crt_pos >= CRT_SIZE) {
  1001d0:	0f b7 83 10 70 02 00 	movzwl 0x27010(%ebx),%eax
        break;
  1001d7:	83 c4 10             	add    $0x10,%esp
    if (terminal.crt_pos >= CRT_SIZE) {
  1001da:	66 3d cf 07          	cmp    $0x7cf,%ax
  1001de:	0f 87 8c 00 00 00    	ja     100270 <video_putc+0x120>
            terminal.crt_buf[i] = 0x0700 | ' ';
        terminal.crt_pos -= CRT_COLS;
    }

    /* move that little blinky thing */
    outb(addr_6845, 14);
  1001e4:	83 ec 08             	sub    $0x8,%esp
  1001e7:	6a 0e                	push   $0xe
  1001e9:	ff b3 18 70 02 00    	push   0x27018(%ebx)
  1001ef:	e8 8c 4d 00 00       	call   104f80 <outb>
    outb(addr_6845 + 1, terminal.crt_pos >> 8);
  1001f4:	58                   	pop    %eax
  1001f5:	0f b6 83 11 70 02 00 	movzbl 0x27011(%ebx),%eax
  1001fc:	5a                   	pop    %edx
  1001fd:	50                   	push   %eax
  1001fe:	8b 83 18 70 02 00    	mov    0x27018(%ebx),%eax
  100204:	83 c0 01             	add    $0x1,%eax
  100207:	50                   	push   %eax
  100208:	e8 73 4d 00 00       	call   104f80 <outb>
    outb(addr_6845, 15);
  10020d:	59                   	pop    %ecx
  10020e:	5e                   	pop    %esi
  10020f:	6a 0f                	push   $0xf
  100211:	ff b3 18 70 02 00    	push   0x27018(%ebx)
  100217:	e8 64 4d 00 00       	call   104f80 <outb>
    outb(addr_6845 + 1, terminal.crt_pos);
  10021c:	58                   	pop    %eax
  10021d:	0f b6 83 10 70 02 00 	movzbl 0x27010(%ebx),%eax
  100224:	5a                   	pop    %edx
  100225:	50                   	push   %eax
  100226:	8b 83 18 70 02 00    	mov    0x27018(%ebx),%eax
  10022c:	83 c0 01             	add    $0x1,%eax
  10022f:	50                   	push   %eax
  100230:	e8 4b 4d 00 00       	call   104f80 <outb>
}
  100235:	83 c4 14             	add    $0x14,%esp
  100238:	5b                   	pop    %ebx
  100239:	5e                   	pop    %esi
  10023a:	c3                   	ret
        if (terminal.crt_pos > 0) {
  10023b:	0f b7 83 10 70 02 00 	movzwl 0x27010(%ebx),%eax
  100242:	66 85 c0             	test   %ax,%ax
  100245:	74 9d                	je     1001e4 <video_putc+0x94>
            terminal.crt_pos--;
  100247:	83 e8 01             	sub    $0x1,%eax
            terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  10024a:	8b 8b 0c 70 02 00    	mov    0x2700c(%ebx),%ecx
  100250:	30 d2                	xor    %dl,%dl
  100252:	0f b7 f0             	movzwl %ax,%esi
  100255:	83 ca 20             	or     $0x20,%edx
            terminal.crt_pos--;
  100258:	66 89 83 10 70 02 00 	mov    %ax,0x27010(%ebx)
            terminal.crt_buf[terminal.crt_pos] = (c & ~0xff) | ' ';
  10025f:	66 89 14 71          	mov    %dx,(%ecx,%esi,2)
    if (terminal.crt_pos >= CRT_SIZE) {
  100263:	66 3d cf 07          	cmp    $0x7cf,%ax
  100267:	0f 86 77 ff ff ff    	jbe    1001e4 <video_putc+0x94>
  10026d:	8d 76 00             	lea    0x0(%esi),%esi
        memmove(terminal.crt_buf, terminal.crt_buf + CRT_COLS,
  100270:	8b 83 0c 70 02 00    	mov    0x2700c(%ebx),%eax
  100276:	83 ec 04             	sub    $0x4,%esp
  100279:	68 00 0f 00 00       	push   $0xf00
  10027e:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  100284:	52                   	push   %edx
  100285:	50                   	push   %eax
  100286:	e8 05 3c 00 00       	call   103e90 <memmove>
            terminal.crt_buf[i] = 0x0700 | ' ';
  10028b:	8b 93 0c 70 02 00    	mov    0x2700c(%ebx),%edx
  100291:	83 c4 10             	add    $0x10,%esp
  100294:	8d 82 00 0f 00 00    	lea    0xf00(%edx),%eax
  10029a:	81 c2 a0 0f 00 00    	add    $0xfa0,%edx
  1002a0:	b9 20 07 00 00       	mov    $0x720,%ecx
  1002a5:	be 20 07 00 00       	mov    $0x720,%esi
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1002aa:	83 c0 04             	add    $0x4,%eax
            terminal.crt_buf[i] = 0x0700 | ' ';
  1002ad:	66 89 48 fc          	mov    %cx,-0x4(%eax)
  1002b1:	66 89 70 fe          	mov    %si,-0x2(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i++)
  1002b5:	39 c2                	cmp    %eax,%edx
  1002b7:	75 e7                	jne    1002a0 <video_putc+0x150>
        terminal.crt_pos -= CRT_COLS;
  1002b9:	66 83 ab 10 70 02 00 	subw   $0x50,0x27010(%ebx)
  1002c0:	50 
  1002c1:	e9 1e ff ff ff       	jmp    1001e4 <video_putc+0x94>
  1002c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1002cd:	00 
  1002ce:	66 90                	xchg   %ax,%ax
    switch (c & 0xff) {
  1002d0:	83 f8 0d             	cmp    $0xd,%eax
  1002d3:	75 25                	jne    1002fa <video_putc+0x1aa>
        if (terminal.crt_pos > 0) {
  1002d5:	0f b7 83 10 70 02 00 	movzwl 0x27010(%ebx),%eax
        terminal.crt_pos -= (terminal.crt_pos % CRT_COLS);
  1002dc:	0f b7 c0             	movzwl %ax,%eax
  1002df:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1002e5:	c1 e8 16             	shr    $0x16,%eax
  1002e8:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1002eb:	c1 e0 04             	shl    $0x4,%eax
  1002ee:	66 89 83 10 70 02 00 	mov    %ax,0x27010(%ebx)
        break;
  1002f5:	e9 e0 fe ff ff       	jmp    1001da <video_putc+0x8a>
        terminal.crt_buf[terminal.crt_pos++] = c;  /* write the character */
  1002fa:	0f b7 8b 10 70 02 00 	movzwl 0x27010(%ebx),%ecx
  100301:	8b b3 0c 70 02 00    	mov    0x2700c(%ebx),%esi
  100307:	8d 41 01             	lea    0x1(%ecx),%eax
  10030a:	66 89 14 4e          	mov    %dx,(%esi,%ecx,2)
  10030e:	66 89 83 10 70 02 00 	mov    %ax,0x27010(%ebx)
        break;
  100315:	e9 c0 fe ff ff       	jmp    1001da <video_putc+0x8a>
        terminal.crt_pos += CRT_COLS;
  10031a:	0f b7 83 10 70 02 00 	movzwl 0x27010(%ebx),%eax
  100321:	83 c0 50             	add    $0x50,%eax
  100324:	eb b6                	jmp    1002dc <video_putc+0x18c>
  100326:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10032d:	00 
  10032e:	66 90                	xchg   %ax,%ax

00100330 <video_set_cursor>:

void video_set_cursor(int x, int y)
{
    terminal.crt_pos = x * CRT_COLS + y;
  100330:	e8 69 00 00 00       	call   10039e <__x86.get_pc_thunk.dx>
  100335:	81 c2 bf 0c 01 00    	add    $0x10cbf,%edx
{
  10033b:	8b 44 24 04          	mov    0x4(%esp),%eax
    terminal.crt_pos = x * CRT_COLS + y;
  10033f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100342:	c1 e0 04             	shl    $0x4,%eax
  100345:	66 03 44 24 08       	add    0x8(%esp),%ax
  10034a:	66 89 82 10 70 02 00 	mov    %ax,0x27010(%edx)
}
  100351:	c3                   	ret
  100352:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100359:	00 
  10035a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100360 <video_clear_screen>:

void video_clear_screen()
{
    int i;
    for (i = 0; i < CRT_SIZE; i++) {
  100360:	e8 35 00 00 00       	call   10039a <__x86.get_pc_thunk.ax>
  100365:	05 8f 0c 01 00       	add    $0x10c8f,%eax
  10036a:	8b 80 0c 70 02 00    	mov    0x2700c(%eax),%eax
  100370:	8d 90 a0 0f 00 00    	lea    0xfa0(%eax),%edx
  100376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10037d:	00 
  10037e:	66 90                	xchg   %ax,%ax
        terminal.crt_buf[i] = ' ';
  100380:	b9 20 00 00 00       	mov    $0x20,%ecx
    for (i = 0; i < CRT_SIZE; i++) {
  100385:	83 c0 04             	add    $0x4,%eax
        terminal.crt_buf[i] = ' ';
  100388:	66 89 48 fc          	mov    %cx,-0x4(%eax)
  10038c:	b9 20 00 00 00       	mov    $0x20,%ecx
  100391:	66 89 48 fe          	mov    %cx,-0x2(%eax)
    for (i = 0; i < CRT_SIZE; i++) {
  100395:	39 d0                	cmp    %edx,%eax
  100397:	75 e7                	jne    100380 <video_clear_screen+0x20>
    }
}
  100399:	c3                   	ret

0010039a <__x86.get_pc_thunk.ax>:
  10039a:	8b 04 24             	mov    (%esp),%eax
  10039d:	c3                   	ret

0010039e <__x86.get_pc_thunk.dx>:
  10039e:	8b 14 24             	mov    (%esp),%edx
  1003a1:	c3                   	ret

001003a2 <__x86.get_pc_thunk.bx>:
  1003a2:	8b 1c 24             	mov    (%esp),%ebx
  1003a5:	c3                   	ret
  1003a6:	66 90                	xchg   %ax,%ax
  1003a8:	66 90                	xchg   %ax,%ax
  1003aa:	66 90                	xchg   %ax,%ax
  1003ac:	66 90                	xchg   %ax,%ax
  1003ae:	66 90                	xchg   %ax,%ax

001003b0 <cons_init>:
    char buf[CONSOLE_BUFFER_SIZE];
    uint32_t rpos, wpos;
} cons;

void cons_init()
{
  1003b0:	53                   	push   %ebx
  1003b1:	e8 ec ff ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1003b6:	81 c3 3e 0c 01 00    	add    $0x10c3e,%ebx
  1003bc:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&console_lock); // intializing the console lock
  1003bf:	8d 83 34 72 02 00    	lea    0x27234(%ebx),%eax
  1003c5:	50                   	push   %eax
  1003c6:	e8 35 54 00 00       	call   105800 <spinlock_init>

    memset(&cons, 0x0, sizeof(cons));
  1003cb:	83 c4 0c             	add    $0xc,%esp
  1003ce:	8d 83 2c 70 02 00    	lea    0x2702c(%ebx),%eax
  1003d4:	68 08 02 00 00       	push   $0x208
  1003d9:	6a 00                	push   $0x0
  1003db:	50                   	push   %eax
  1003dc:	e8 6f 3a 00 00       	call   103e50 <memset>
    serial_init();
  1003e1:	e8 aa 04 00 00       	call   100890 <serial_init>
    video_init();
  1003e6:	e8 65 fc ff ff       	call   100050 <video_init>
}
  1003eb:	83 c4 18             	add    $0x18,%esp
  1003ee:	5b                   	pop    %ebx
  1003ef:	c3                   	ret

001003f0 <cons_intr>:

void cons_intr(int (*proc)(void))
{
  1003f0:	55                   	push   %ebp
  1003f1:	57                   	push   %edi
  1003f2:	56                   	push   %esi


    while ((c = (*proc)()) != -1) {
        if (c == 0)
            continue;
        cons.buf[cons.wpos++] = c;
  1003f3:	8d 35 2c 70 02 00    	lea    0x2702c,%esi
{
  1003f9:	53                   	push   %ebx
  1003fa:	e8 a3 ff ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1003ff:	81 c3 f5 0b 01 00    	add    $0x10bf5,%ebx
  100405:	83 ec 28             	sub    $0x28,%esp
  100408:	8b 7c 24 3c          	mov    0x3c(%esp),%edi
    spinlock_acquire(&console_lock);
  10040c:	8d 83 34 72 02 00    	lea    0x27234(%ebx),%eax
        cons.buf[cons.wpos++] = c;
  100412:	8d 2c 33             	lea    (%ebx,%esi,1),%ebp
    spinlock_acquire(&console_lock);
  100415:	89 44 24 18          	mov    %eax,0x18(%esp)
  100419:	50                   	push   %eax
  10041a:	e8 71 54 00 00       	call   105890 <spinlock_acquire>
    while ((c = (*proc)()) != -1) {
  10041f:	83 c4 10             	add    $0x10,%esp
  100422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100428:	ff d7                	call   *%edi
  10042a:	83 f8 ff             	cmp    $0xffffffff,%eax
  10042d:	74 33                	je     100462 <cons_intr+0x72>
        if (c == 0)
  10042f:	85 c0                	test   %eax,%eax
  100431:	74 f5                	je     100428 <cons_intr+0x38>
        cons.buf[cons.wpos++] = c;
  100433:	8b 8c 33 04 02 00 00 	mov    0x204(%ebx,%esi,1),%ecx
  10043a:	8d 51 01             	lea    0x1(%ecx),%edx
  10043d:	88 44 0d 00          	mov    %al,0x0(%ebp,%ecx,1)
  100441:	89 94 33 04 02 00 00 	mov    %edx,0x204(%ebx,%esi,1)
        if (cons.wpos == CONSOLE_BUFFER_SIZE)
  100448:	81 fa 00 02 00 00    	cmp    $0x200,%edx
  10044e:	75 d8                	jne    100428 <cons_intr+0x38>
            cons.wpos = 0;
  100450:	c7 84 1e 04 02 00 00 	movl   $0x0,0x204(%esi,%ebx,1)
  100457:	00 00 00 00 
    while ((c = (*proc)()) != -1) {
  10045b:	ff d7                	call   *%edi
  10045d:	83 f8 ff             	cmp    $0xffffffff,%eax
  100460:	75 cd                	jne    10042f <cons_intr+0x3f>
    }
    spinlock_release(&console_lock);
  100462:	83 ec 0c             	sub    $0xc,%esp
  100465:	ff 74 24 18          	push   0x18(%esp)
  100469:	e8 a2 54 00 00       	call   105910 <spinlock_release>

}
  10046e:	83 c4 2c             	add    $0x2c,%esp
  100471:	5b                   	pop    %ebx
  100472:	5e                   	pop    %esi
  100473:	5f                   	pop    %edi
  100474:	5d                   	pop    %ebp
  100475:	c3                   	ret
  100476:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10047d:	00 
  10047e:	66 90                	xchg   %ax,%ax

00100480 <cons_getc>:

char cons_getc(void)
{
  100480:	57                   	push   %edi
  100481:	56                   	push   %esi
  100482:	53                   	push   %ebx
  100483:	e8 1a ff ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100488:	81 c3 6c 0b 01 00    	add    $0x10b6c,%ebx

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).

    spinlock_acquire(&console_lock);
  10048e:	83 ec 0c             	sub    $0xc,%esp
  100491:	8d b3 34 72 02 00    	lea    0x27234(%ebx),%esi
  100497:	56                   	push   %esi
  100498:	e8 f3 53 00 00       	call   105890 <spinlock_acquire>

    serial_intr();
  10049d:	e8 ee 02 00 00       	call   100790 <serial_intr>
    keyboard_intr();
  1004a2:	e8 59 06 00 00       	call   100b00 <keyboard_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1004a7:	8b 83 2c 72 02 00    	mov    0x2722c(%ebx),%eax
  1004ad:	83 c4 10             	add    $0x10,%esp
  1004b0:	3b 83 30 72 02 00    	cmp    0x27230(%ebx),%eax
  1004b6:	74 38                	je     1004f0 <cons_getc+0x70>
        c = cons.buf[cons.rpos++];
  1004b8:	0f b6 bc 03 2c 70 02 	movzbl 0x2702c(%ebx,%eax,1),%edi
  1004bf:	00 
        if (cons.rpos == CONSOLE_BUFFER_SIZE)
            cons.rpos = 0;
  1004c0:	3d ff 01 00 00       	cmp    $0x1ff,%eax
        c = cons.buf[cons.rpos++];
  1004c5:	8d 50 01             	lea    0x1(%eax),%edx
            cons.rpos = 0;
  1004c8:	b8 00 00 00 00       	mov    $0x0,%eax
  1004cd:	0f 44 d0             	cmove  %eax,%edx
        spinlock_release(&console_lock);
  1004d0:	83 ec 0c             	sub    $0xc,%esp
  1004d3:	56                   	push   %esi
  1004d4:	89 93 2c 72 02 00    	mov    %edx,0x2722c(%ebx)
  1004da:	e8 31 54 00 00       	call   105910 <spinlock_release>
        return c;
  1004df:	83 c4 10             	add    $0x10,%esp
    }
    spinlock_release(&console_lock);

    return 0;
}
  1004e2:	89 f8                	mov    %edi,%eax
  1004e4:	5b                   	pop    %ebx
  1004e5:	5e                   	pop    %esi
  1004e6:	5f                   	pop    %edi
  1004e7:	c3                   	ret
  1004e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1004ef:	00 
    spinlock_release(&console_lock);
  1004f0:	83 ec 0c             	sub    $0xc,%esp
    return 0;
  1004f3:	31 ff                	xor    %edi,%edi
    spinlock_release(&console_lock);
  1004f5:	56                   	push   %esi
  1004f6:	e8 15 54 00 00       	call   105910 <spinlock_release>
    return 0;
  1004fb:	83 c4 10             	add    $0x10,%esp
}
  1004fe:	89 f8                	mov    %edi,%eax
  100500:	5b                   	pop    %ebx
  100501:	5e                   	pop    %esi
  100502:	5f                   	pop    %edi
  100503:	c3                   	ret
  100504:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10050b:	00 
  10050c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100510 <cons_putc>:

void cons_putc(char c)
{
  100510:	57                   	push   %edi
  100511:	56                   	push   %esi
  100512:	53                   	push   %ebx
  100513:	8b 74 24 10          	mov    0x10(%esp),%esi
  100517:	e8 86 fe ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10051c:	81 c3 d8 0a 01 00    	add    $0x10ad8,%ebx
    spinlock_acquire(&console_lock);
  100522:	83 ec 0c             	sub    $0xc,%esp
  100525:	8d bb 34 72 02 00    	lea    0x27234(%ebx),%edi
  10052b:	57                   	push   %edi
  10052c:	e8 5f 53 00 00       	call   105890 <spinlock_acquire>
    serial_putc(c);
  100531:	89 f0                	mov    %esi,%eax
  100533:	0f be f0             	movsbl %al,%esi
  100536:	89 34 24             	mov    %esi,(%esp)
  100539:	e8 92 02 00 00       	call   1007d0 <serial_putc>
    video_putc(c);
  10053e:	89 34 24             	mov    %esi,(%esp)
  100541:	e8 0a fc ff ff       	call   100150 <video_putc>
    spinlock_release(&console_lock);
  100546:	89 3c 24             	mov    %edi,(%esp)
  100549:	e8 c2 53 00 00       	call   105910 <spinlock_release>

}
  10054e:	83 c4 10             	add    $0x10,%esp
  100551:	5b                   	pop    %ebx
  100552:	5e                   	pop    %esi
  100553:	5f                   	pop    %edi
  100554:	c3                   	ret
  100555:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10055c:	00 
  10055d:	8d 76 00             	lea    0x0(%esi),%esi

00100560 <getchar>:

char getchar(void)
{
  100560:	83 ec 0c             	sub    $0xc,%esp
    char c;

    while ((c = cons_getc()) == 0)
  100563:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  100568:	e8 13 ff ff ff       	call   100480 <cons_getc>
  10056d:	84 c0                	test   %al,%al
  10056f:	74 f7                	je     100568 <getchar+0x8>
        /* do nothing */ ;
    return c;
}
  100571:	83 c4 0c             	add    $0xc,%esp
  100574:	c3                   	ret
  100575:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10057c:	00 
  10057d:	8d 76 00             	lea    0x0(%esi),%esi

00100580 <putchar>:

void putchar(char c)
{
  100580:	57                   	push   %edi
  100581:	56                   	push   %esi
  100582:	53                   	push   %ebx
  100583:	8b 74 24 10          	mov    0x10(%esp),%esi
    spinlock_acquire(&console_lock);
  100587:	e8 16 fe ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10058c:	81 c3 68 0a 01 00    	add    $0x10a68,%ebx
  100592:	83 ec 0c             	sub    $0xc,%esp
  100595:	8d bb 34 72 02 00    	lea    0x27234(%ebx),%edi
  10059b:	57                   	push   %edi
  10059c:	e8 ef 52 00 00       	call   105890 <spinlock_acquire>
    serial_putc(c);
  1005a1:	89 f0                	mov    %esi,%eax
  1005a3:	0f be f0             	movsbl %al,%esi
  1005a6:	89 34 24             	mov    %esi,(%esp)
  1005a9:	e8 22 02 00 00       	call   1007d0 <serial_putc>
    video_putc(c);
  1005ae:	89 34 24             	mov    %esi,(%esp)
  1005b1:	e8 9a fb ff ff       	call   100150 <video_putc>
    spinlock_release(&console_lock);
  1005b6:	89 3c 24             	mov    %edi,(%esp)
  1005b9:	e8 52 53 00 00       	call   105910 <spinlock_release>
    cons_putc(c);
}
  1005be:	83 c4 10             	add    $0x10,%esp
  1005c1:	5b                   	pop    %ebx
  1005c2:	5e                   	pop    %esi
  1005c3:	5f                   	pop    %edi
  1005c4:	c3                   	ret
  1005c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1005cc:	00 
  1005cd:	8d 76 00             	lea    0x0(%esi),%esi

001005d0 <readline>:

char *readline(const char *prompt)
{
  1005d0:	55                   	push   %ebp
  1005d1:	57                   	push   %edi
  1005d2:	56                   	push   %esi
  1005d3:	53                   	push   %ebx
  1005d4:	e8 c9 fd ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1005d9:	81 c3 1b 0a 01 00    	add    $0x10a1b,%ebx
  1005df:	83 ec 1c             	sub    $0x1c,%esp
  1005e2:	8b 44 24 30          	mov    0x30(%esp),%eax
    int i;
    char c;

    if (prompt != NULL)
  1005e6:	85 c0                	test   %eax,%eax
  1005e8:	74 13                	je     1005fd <readline+0x2d>
        dprintf("%s", prompt);
  1005ea:	83 ec 08             	sub    $0x8,%esp
  1005ed:	50                   	push   %eax
  1005ee:	8d 83 aa 85 ff ff    	lea    -0x7a56(%ebx),%eax
  1005f4:	50                   	push   %eax
  1005f5:	e8 d6 3d 00 00       	call   1043d0 <dprintf>
  1005fa:	83 c4 10             	add    $0x10,%esp
        } else if ((c == '\b' || c == '\x7f') && i > 0) {
            putchar('\b');
            i--;
        } else if (c >= ' ' && i < BUFLEN - 1) {
            putchar(c);
            linebuf[i++] = c;
  1005fd:	8d 83 4c 72 02 00    	lea    0x2724c(%ebx),%eax
  100603:	31 f6                	xor    %esi,%esi
  100605:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while ((c = cons_getc()) == 0)
  100610:	e8 6b fe ff ff       	call   100480 <cons_getc>
  100615:	84 c0                	test   %al,%al
  100617:	74 f7                	je     100610 <readline+0x40>
        if (c < 0) {
  100619:	0f 88 f3 00 00 00    	js     100712 <readline+0x142>
        } else if ((c == '\b' || c == '\x7f') && i > 0) {
  10061f:	3c 08                	cmp    $0x8,%al
  100621:	0f 94 c2             	sete   %dl
  100624:	3c 7f                	cmp    $0x7f,%al
  100626:	0f 94 c1             	sete   %cl
  100629:	08 ca                	or     %cl,%dl
  10062b:	74 08                	je     100635 <readline+0x65>
  10062d:	85 f6                	test   %esi,%esi
  10062f:	0f 8f a3 00 00 00    	jg     1006d8 <readline+0x108>
        } else if (c >= ' ' && i < BUFLEN - 1) {
  100635:	3c 1f                	cmp    $0x1f,%al
  100637:	7e 4f                	jle    100688 <readline+0xb8>
  100639:	81 fe fe 03 00 00    	cmp    $0x3fe,%esi
  10063f:	7f 47                	jg     100688 <readline+0xb8>
  100641:	88 44 24 0b          	mov    %al,0xb(%esp)
    spinlock_acquire(&console_lock);
  100645:	8d ab 34 72 02 00    	lea    0x27234(%ebx),%ebp
  10064b:	83 ec 0c             	sub    $0xc,%esp
  10064e:	55                   	push   %ebp
  10064f:	e8 3c 52 00 00       	call   105890 <spinlock_acquire>
    serial_putc(c);
  100654:	0f be 7c 24 1b       	movsbl 0x1b(%esp),%edi
  100659:	89 3c 24             	mov    %edi,(%esp)
  10065c:	e8 6f 01 00 00       	call   1007d0 <serial_putc>
    video_putc(c);
  100661:	89 3c 24             	mov    %edi,(%esp)
  100664:	e8 e7 fa ff ff       	call   100150 <video_putc>
    spinlock_release(&console_lock);
  100669:	89 2c 24             	mov    %ebp,(%esp)
  10066c:	e8 9f 52 00 00       	call   105910 <spinlock_release>
            linebuf[i++] = c;
  100671:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  100675:	0f b6 44 24 1b       	movzbl 0x1b(%esp),%eax
  10067a:	83 c4 10             	add    $0x10,%esp
  10067d:	88 04 37             	mov    %al,(%edi,%esi,1)
  100680:	83 c6 01             	add    $0x1,%esi
  100683:	eb 8b                	jmp    100610 <readline+0x40>
  100685:	8d 76 00             	lea    0x0(%esi),%esi
        } else if (c == '\n' || c == '\r') {
  100688:	3c 0a                	cmp    $0xa,%al
  10068a:	74 04                	je     100690 <readline+0xc0>
  10068c:	3c 0d                	cmp    $0xd,%al
  10068e:	75 80                	jne    100610 <readline+0x40>
    spinlock_acquire(&console_lock);
  100690:	83 ec 0c             	sub    $0xc,%esp
  100693:	8d bb 34 72 02 00    	lea    0x27234(%ebx),%edi
  100699:	57                   	push   %edi
  10069a:	e8 f1 51 00 00       	call   105890 <spinlock_acquire>
    serial_putc(c);
  10069f:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1006a6:	e8 25 01 00 00       	call   1007d0 <serial_putc>
    video_putc(c);
  1006ab:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1006b2:	e8 99 fa ff ff       	call   100150 <video_putc>
    spinlock_release(&console_lock);
  1006b7:	89 3c 24             	mov    %edi,(%esp)
  1006ba:	e8 51 52 00 00       	call   105910 <spinlock_release>
            putchar('\n');
            linebuf[i] = 0;
  1006bf:	8d 83 4c 72 02 00    	lea    0x2724c(%ebx),%eax
            return linebuf;
  1006c5:	83 c4 10             	add    $0x10,%esp
            linebuf[i] = 0;
  1006c8:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
        }
    }
}
  1006cc:	83 c4 1c             	add    $0x1c,%esp
  1006cf:	5b                   	pop    %ebx
  1006d0:	5e                   	pop    %esi
  1006d1:	5f                   	pop    %edi
  1006d2:	5d                   	pop    %ebp
  1006d3:	c3                   	ret
  1006d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    spinlock_acquire(&console_lock);
  1006d8:	83 ec 0c             	sub    $0xc,%esp
  1006db:	8d ab 34 72 02 00    	lea    0x27234(%ebx),%ebp
            i--;
  1006e1:	83 ee 01             	sub    $0x1,%esi
    spinlock_acquire(&console_lock);
  1006e4:	55                   	push   %ebp
  1006e5:	e8 a6 51 00 00       	call   105890 <spinlock_acquire>
    serial_putc(c);
  1006ea:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1006f1:	e8 da 00 00 00       	call   1007d0 <serial_putc>
    video_putc(c);
  1006f6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1006fd:	e8 4e fa ff ff       	call   100150 <video_putc>
    spinlock_release(&console_lock);
  100702:	89 2c 24             	mov    %ebp,(%esp)
  100705:	e8 06 52 00 00       	call   105910 <spinlock_release>
            i--;
  10070a:	83 c4 10             	add    $0x10,%esp
  10070d:	e9 fe fe ff ff       	jmp    100610 <readline+0x40>
            dprintf("read error: %e\n", c);
  100712:	83 ec 08             	sub    $0x8,%esp
  100715:	0f be c0             	movsbl %al,%eax
  100718:	50                   	push   %eax
  100719:	8d 83 1a 80 ff ff    	lea    -0x7fe6(%ebx),%eax
  10071f:	50                   	push   %eax
  100720:	e8 ab 3c 00 00       	call   1043d0 <dprintf>
            return NULL;
  100725:	83 c4 10             	add    $0x10,%esp
  100728:	31 c0                	xor    %eax,%eax
}
  10072a:	83 c4 1c             	add    $0x1c,%esp
  10072d:	5b                   	pop    %ebx
  10072e:	5e                   	pop    %esi
  10072f:	5f                   	pop    %edi
  100730:	5d                   	pop    %ebp
  100731:	c3                   	ret
  100732:	66 90                	xchg   %ax,%ax
  100734:	66 90                	xchg   %ax,%ax
  100736:	66 90                	xchg   %ax,%ax
  100738:	66 90                	xchg   %ax,%ax
  10073a:	66 90                	xchg   %ax,%ax
  10073c:	66 90                	xchg   %ax,%ax
  10073e:	66 90                	xchg   %ax,%ax

00100740 <serial_proc_data>:
    inb(0x84);
    inb(0x84);
}

static int serial_proc_data(void)
{
  100740:	53                   	push   %ebx
  100741:	e8 5c fc ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100746:	81 c3 ae 08 01 00    	add    $0x108ae,%ebx
  10074c:	83 ec 14             	sub    $0x14,%esp
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA))
  10074f:	68 fd 03 00 00       	push   $0x3fd
  100754:	e8 f7 47 00 00       	call   104f50 <inb>
  100759:	83 c4 10             	add    $0x10,%esp
  10075c:	a8 01                	test   $0x1,%al
  10075e:	74 20                	je     100780 <serial_proc_data+0x40>
        return -1;
    return inb(COM1 + COM_RX);
  100760:	83 ec 0c             	sub    $0xc,%esp
  100763:	68 f8 03 00 00       	push   $0x3f8
  100768:	e8 e3 47 00 00       	call   104f50 <inb>
  10076d:	83 c4 10             	add    $0x10,%esp
  100770:	0f b6 c0             	movzbl %al,%eax
}
  100773:	83 c4 08             	add    $0x8,%esp
  100776:	5b                   	pop    %ebx
  100777:	c3                   	ret
  100778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10077f:	00 
        return -1;
  100780:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100785:	eb ec                	jmp    100773 <serial_proc_data+0x33>
  100787:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10078e:	00 
  10078f:	90                   	nop

00100790 <serial_intr>:

void serial_intr(void)
{
  100790:	53                   	push   %ebx
  100791:	e8 0c fc ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100796:	81 c3 5e 08 01 00    	add    $0x1085e,%ebx
  10079c:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists)
  10079f:	80 bb 4c 76 02 00 00 	cmpb   $0x0,0x2764c(%ebx)
  1007a6:	75 08                	jne    1007b0 <serial_intr+0x20>
        cons_intr(serial_proc_data);
}
  1007a8:	83 c4 08             	add    $0x8,%esp
  1007ab:	5b                   	pop    %ebx
  1007ac:	c3                   	ret
  1007ad:	8d 76 00             	lea    0x0(%esi),%esi
        cons_intr(serial_proc_data);
  1007b0:	83 ec 0c             	sub    $0xc,%esp
  1007b3:	8d 83 4c f7 fe ff    	lea    -0x108b4(%ebx),%eax
  1007b9:	50                   	push   %eax
  1007ba:	e8 31 fc ff ff       	call   1003f0 <cons_intr>
}
  1007bf:	83 c4 10             	add    $0x10,%esp
  1007c2:	83 c4 08             	add    $0x8,%esp
  1007c5:	5b                   	pop    %ebx
  1007c6:	c3                   	ret
  1007c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1007ce:	00 
  1007cf:	90                   	nop

001007d0 <serial_putc>:
    } else
        return 0;
}

void serial_putc(char c)
{
  1007d0:	57                   	push   %edi
  1007d1:	56                   	push   %esi
    if (!serial_exists)
        return;

    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  1007d2:	31 f6                	xor    %esi,%esi
{
  1007d4:	53                   	push   %ebx
  1007d5:	8b 7c 24 10          	mov    0x10(%esp),%edi
  1007d9:	e8 c4 fb ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1007de:	81 c3 16 08 01 00    	add    $0x10816,%ebx
    if (!serial_exists)
  1007e4:	80 bb 4c 76 02 00 00 	cmpb   $0x0,0x2764c(%ebx)
  1007eb:	75 42                	jne    10082f <serial_putc+0x5f>
  1007ed:	eb 6e                	jmp    10085d <serial_putc+0x8d>
  1007ef:	90                   	nop
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  1007f0:	81 fe 00 32 00 00    	cmp    $0x3200,%esi
  1007f6:	74 4b                	je     100843 <serial_putc+0x73>
    inb(0x84);
  1007f8:	83 ec 0c             	sub    $0xc,%esp
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  1007fb:	83 c6 01             	add    $0x1,%esi
    inb(0x84);
  1007fe:	68 84 00 00 00       	push   $0x84
  100803:	e8 48 47 00 00       	call   104f50 <inb>
    inb(0x84);
  100808:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  10080f:	e8 3c 47 00 00       	call   104f50 <inb>
    inb(0x84);
  100814:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  10081b:	e8 30 47 00 00       	call   104f50 <inb>
    inb(0x84);
  100820:	c7 04 24 84 00 00 00 	movl   $0x84,(%esp)
  100827:	e8 24 47 00 00       	call   104f50 <inb>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i++)
  10082c:	83 c4 10             	add    $0x10,%esp
  10082f:	83 ec 0c             	sub    $0xc,%esp
  100832:	68 fd 03 00 00       	push   $0x3fd
  100837:	e8 14 47 00 00       	call   104f50 <inb>
  10083c:	83 c4 10             	add    $0x10,%esp
  10083f:	a8 20                	test   $0x20,%al
  100841:	74 ad                	je     1007f0 <serial_putc+0x20>
    if (c == nl) {
  100843:	89 f8                	mov    %edi,%eax
  100845:	3c 0a                	cmp    $0xa,%al
  100847:	74 1f                	je     100868 <serial_putc+0x98>
        delay();

    if (!serial_reformatnewline(c, COM1 + COM_TX))
        outb(COM1 + COM_TX, c);
  100849:	83 ec 08             	sub    $0x8,%esp
  10084c:	0f b6 f8             	movzbl %al,%edi
  10084f:	57                   	push   %edi
  100850:	68 f8 03 00 00       	push   $0x3f8
  100855:	e8 26 47 00 00       	call   104f80 <outb>
  10085a:	83 c4 10             	add    $0x10,%esp
}
  10085d:	5b                   	pop    %ebx
  10085e:	5e                   	pop    %esi
  10085f:	5f                   	pop    %edi
  100860:	c3                   	ret
  100861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        outb(p, cr);
  100868:	83 ec 08             	sub    $0x8,%esp
  10086b:	6a 0d                	push   $0xd
  10086d:	68 f8 03 00 00       	push   $0x3f8
  100872:	e8 09 47 00 00       	call   104f80 <outb>
        outb(p, nl);
  100877:	58                   	pop    %eax
  100878:	5a                   	pop    %edx
  100879:	6a 0a                	push   $0xa
  10087b:	68 f8 03 00 00       	push   $0x3f8
  100880:	e8 fb 46 00 00       	call   104f80 <outb>
  100885:	83 c4 10             	add    $0x10,%esp
}
  100888:	5b                   	pop    %ebx
  100889:	5e                   	pop    %esi
  10088a:	5f                   	pop    %edi
  10088b:	c3                   	ret
  10088c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00100890 <serial_init>:

void serial_init(void)
{
  100890:	53                   	push   %ebx
  100891:	e8 0c fb ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100896:	81 c3 5e 07 01 00    	add    $0x1075e,%ebx
  10089c:	83 ec 10             	sub    $0x10,%esp
    /* turn off interrupt */
    outb(COM1 + COM_IER, 0);
  10089f:	6a 00                	push   $0x0
  1008a1:	68 f9 03 00 00       	push   $0x3f9
  1008a6:	e8 d5 46 00 00       	call   104f80 <outb>

    /* set DLAB */
    outb(COM1 + COM_LCR, COM_LCR_DLAB);
  1008ab:	58                   	pop    %eax
  1008ac:	5a                   	pop    %edx
  1008ad:	68 80 00 00 00       	push   $0x80
  1008b2:	68 fb 03 00 00       	push   $0x3fb
  1008b7:	e8 c4 46 00 00       	call   104f80 <outb>

    /* set baud rate */
    outb(COM1 + COM_DLL, 0x0001 & 0xff);
  1008bc:	59                   	pop    %ecx
  1008bd:	58                   	pop    %eax
  1008be:	6a 01                	push   $0x1
  1008c0:	68 f8 03 00 00       	push   $0x3f8
  1008c5:	e8 b6 46 00 00       	call   104f80 <outb>
    outb(COM1 + COM_DLM, 0x0001 >> 8);
  1008ca:	58                   	pop    %eax
  1008cb:	5a                   	pop    %edx
  1008cc:	6a 00                	push   $0x0
  1008ce:	68 f9 03 00 00       	push   $0x3f9
  1008d3:	e8 a8 46 00 00       	call   104f80 <outb>

    /* Set the line status. */
    outb(COM1 + COM_LCR, COM_LCR_WLEN8 & ~COM_LCR_DLAB);
  1008d8:	59                   	pop    %ecx
  1008d9:	58                   	pop    %eax
  1008da:	6a 03                	push   $0x3
  1008dc:	68 fb 03 00 00       	push   $0x3fb
  1008e1:	e8 9a 46 00 00       	call   104f80 <outb>

    /* Enable the FIFO. */
    outb(COM1 + COM_FCR, 0xc7);
  1008e6:	58                   	pop    %eax
  1008e7:	5a                   	pop    %edx
  1008e8:	68 c7 00 00 00       	push   $0xc7
  1008ed:	68 fa 03 00 00       	push   $0x3fa
  1008f2:	e8 89 46 00 00       	call   104f80 <outb>

    /* Turn on DTR, RTS, and OUT2. */
    outb(COM1 + COM_MCR, 0x0b);
  1008f7:	59                   	pop    %ecx
  1008f8:	58                   	pop    %eax
  1008f9:	6a 0b                	push   $0xb
  1008fb:	68 fc 03 00 00       	push   $0x3fc
  100900:	e8 7b 46 00 00       	call   104f80 <outb>

    // Clear any preexisting overrun indications and interrupts
    // Serial COM1 doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100905:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
  10090c:	e8 3f 46 00 00       	call   104f50 <inb>
    (void) inb(COM1 + COM_IIR);
  100911:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100918:	3c ff                	cmp    $0xff,%al
  10091a:	0f 95 83 4c 76 02 00 	setne  0x2764c(%ebx)
    (void) inb(COM1 + COM_IIR);
  100921:	e8 2a 46 00 00       	call   104f50 <inb>
    (void) inb(COM1 + COM_RX);
  100926:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
  10092d:	e8 1e 46 00 00       	call   104f50 <inb>
}
  100932:	83 c4 18             	add    $0x18,%esp
  100935:	5b                   	pop    %ebx
  100936:	c3                   	ret
  100937:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10093e:	00 
  10093f:	90                   	nop

00100940 <serial_intenable>:

void serial_intenable(void)
{
  100940:	53                   	push   %ebx
  100941:	e8 5c fa ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100946:	81 c3 ae 06 01 00    	add    $0x106ae,%ebx
  10094c:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  10094f:	80 bb 4c 76 02 00 00 	cmpb   $0x0,0x2764c(%ebx)
  100956:	75 08                	jne    100960 <serial_intenable+0x20>
        outb(COM1 + COM_IER, 1);
        serial_intr();
    }
}
  100958:	83 c4 08             	add    $0x8,%esp
  10095b:	5b                   	pop    %ebx
  10095c:	c3                   	ret
  10095d:	8d 76 00             	lea    0x0(%esi),%esi
        outb(COM1 + COM_IER, 1);
  100960:	83 ec 08             	sub    $0x8,%esp
  100963:	6a 01                	push   $0x1
  100965:	68 f9 03 00 00       	push   $0x3f9
  10096a:	e8 11 46 00 00       	call   104f80 <outb>
    if (serial_exists)
  10096f:	83 c4 10             	add    $0x10,%esp
  100972:	80 bb 4c 76 02 00 00 	cmpb   $0x0,0x2764c(%ebx)
  100979:	74 dd                	je     100958 <serial_intenable+0x18>
        cons_intr(serial_proc_data);
  10097b:	83 ec 0c             	sub    $0xc,%esp
  10097e:	8d 83 4c f7 fe ff    	lea    -0x108b4(%ebx),%eax
  100984:	50                   	push   %eax
  100985:	e8 66 fa ff ff       	call   1003f0 <cons_intr>
}
  10098a:	83 c4 10             	add    $0x10,%esp
}
  10098d:	83 c4 08             	add    $0x8,%esp
  100990:	5b                   	pop    %ebx
  100991:	c3                   	ret
  100992:	66 90                	xchg   %ax,%ax
  100994:	66 90                	xchg   %ax,%ax
  100996:	66 90                	xchg   %ax,%ax
  100998:	66 90                	xchg   %ax,%ax
  10099a:	66 90                	xchg   %ax,%ax
  10099c:	66 90                	xchg   %ax,%ax
  10099e:	66 90                	xchg   %ax,%ax

001009a0 <kbd_proc_data>:
/*
 * Get data from the keyboard. If we finish a character, return it. Else 0.
 * Return -1 if no data.
 */
static int kbd_proc_data(void)
{
  1009a0:	56                   	push   %esi
  1009a1:	53                   	push   %ebx
  1009a2:	e8 fb f9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1009a7:	81 c3 4d 06 01 00    	add    $0x1064d,%ebx
  1009ad:	83 ec 10             	sub    $0x10,%esp
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0)
  1009b0:	6a 64                	push   $0x64
  1009b2:	e8 99 45 00 00       	call   104f50 <inb>
  1009b7:	83 c4 10             	add    $0x10,%esp
  1009ba:	a8 01                	test   $0x1,%al
  1009bc:	0f 84 26 01 00 00    	je     100ae8 <kbd_proc_data+0x148>
        return -1;

    data = inb(KBDATAP);
  1009c2:	83 ec 0c             	sub    $0xc,%esp
  1009c5:	6a 60                	push   $0x60
  1009c7:	e8 84 45 00 00       	call   104f50 <inb>

    if (data == 0xE0) {
  1009cc:	83 c4 10             	add    $0x10,%esp
  1009cf:	3c e0                	cmp    $0xe0,%al
  1009d1:	0f 84 89 00 00 00    	je     100a60 <kbd_proc_data+0xc0>
        // E0 escape character
        shift |= E0ESC;
  1009d7:	8b 8b 50 76 02 00    	mov    0x27650(%ebx),%ecx
        return 0;
    } else if (data & 0x80) {
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1009dd:	89 ca                	mov    %ecx,%edx
  1009df:	83 e2 40             	and    $0x40,%edx
    } else if (data & 0x80) {
  1009e2:	84 c0                	test   %al,%al
  1009e4:	0f 88 8e 00 00 00    	js     100a78 <kbd_proc_data+0xd8>
        shift &= ~(shiftcode[data] | E0ESC);
        return 0;
    } else if (shift & E0ESC) {
  1009ea:	85 d2                	test   %edx,%edx
  1009ec:	74 06                	je     1009f4 <kbd_proc_data+0x54>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  1009ee:	83 c8 80             	or     $0xffffff80,%eax
        shift &= ~E0ESC;
  1009f1:	83 e1 bf             	and    $0xffffffbf,%ecx
    }

    shift |= shiftcode[data];
  1009f4:	0f b6 c0             	movzbl %al,%eax
  1009f7:	0f b6 94 03 cc 88 ff 	movzbl -0x7734(%ebx,%eax,1),%edx
  1009fe:	ff 
  1009ff:	09 ca                	or     %ecx,%edx
    shift ^= togglecode[data];
  100a01:	0f b6 8c 03 cc 87 ff 	movzbl -0x7834(%ebx,%eax,1),%ecx
  100a08:	ff 
  100a09:	31 ca                	xor    %ecx,%edx

    c = charcode[shift & (CTL | SHIFT)][data];
  100a0b:	89 d1                	mov    %edx,%ecx
    shift ^= togglecode[data];
  100a0d:	89 93 50 76 02 00    	mov    %edx,0x27650(%ebx)
    c = charcode[shift & (CTL | SHIFT)][data];
  100a13:	83 e1 03             	and    $0x3,%ecx
  100a16:	8b 8c 8b d8 ff ff ff 	mov    -0x28(%ebx,%ecx,4),%ecx
  100a1d:	0f b6 34 01          	movzbl (%ecx,%eax,1),%esi
    if (shift & CAPSLOCK) {
  100a21:	f6 c2 08             	test   $0x8,%dl
  100a24:	75 22                	jne    100a48 <kbd_proc_data+0xa8>
        else if ('A' <= c && c <= 'Z')
            c += 'a' - 'A';
    }
    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  100a26:	f7 d2                	not    %edx
  100a28:	83 e2 06             	and    $0x6,%edx
  100a2b:	75 0c                	jne    100a39 <kbd_proc_data+0x99>
  100a2d:	81 fe e9 00 00 00    	cmp    $0xe9,%esi
  100a33:	0f 84 87 00 00 00    	je     100ac0 <kbd_proc_data+0x120>
        dprintf("Rebooting!\n");
        outb(0x92, 0x3);  // courtesy of Chris Frost
    }

    return c;
}
  100a39:	83 c4 04             	add    $0x4,%esp
  100a3c:	89 f0                	mov    %esi,%eax
  100a3e:	5b                   	pop    %ebx
  100a3f:	5e                   	pop    %esi
  100a40:	c3                   	ret
  100a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if ('a' <= c && c <= 'z')
  100a48:	8d 46 9f             	lea    -0x61(%esi),%eax
  100a4b:	83 f8 19             	cmp    $0x19,%eax
  100a4e:	77 58                	ja     100aa8 <kbd_proc_data+0x108>
            c += 'A' - 'a';
  100a50:	83 ee 20             	sub    $0x20,%esi
}
  100a53:	83 c4 04             	add    $0x4,%esp
  100a56:	89 f0                	mov    %esi,%eax
  100a58:	5b                   	pop    %ebx
  100a59:	5e                   	pop    %esi
  100a5a:	c3                   	ret
  100a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        shift |= E0ESC;
  100a60:	83 8b 50 76 02 00 40 	orl    $0x40,0x27650(%ebx)
        return 0;
  100a67:	31 f6                	xor    %esi,%esi
}
  100a69:	83 c4 04             	add    $0x4,%esp
  100a6c:	89 f0                	mov    %esi,%eax
  100a6e:	5b                   	pop    %ebx
  100a6f:	5e                   	pop    %esi
  100a70:	c3                   	ret
  100a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        data = (shift & E0ESC ? data : data & 0x7F);
  100a78:	89 c6                	mov    %eax,%esi
  100a7a:	83 e6 7f             	and    $0x7f,%esi
  100a7d:	85 d2                	test   %edx,%edx
  100a7f:	0f 44 c6             	cmove  %esi,%eax
        return 0;
  100a82:	31 f6                	xor    %esi,%esi
        shift &= ~(shiftcode[data] | E0ESC);
  100a84:	0f b6 c0             	movzbl %al,%eax
  100a87:	0f b6 84 03 cc 88 ff 	movzbl -0x7734(%ebx,%eax,1),%eax
  100a8e:	ff 
  100a8f:	83 c8 40             	or     $0x40,%eax
  100a92:	0f b6 c0             	movzbl %al,%eax
  100a95:	f7 d0                	not    %eax
  100a97:	21 c8                	and    %ecx,%eax
  100a99:	89 83 50 76 02 00    	mov    %eax,0x27650(%ebx)
        return 0;
  100a9f:	eb c8                	jmp    100a69 <kbd_proc_data+0xc9>
  100aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if ('A' <= c && c <= 'Z')
  100aa8:	8d 4e bf             	lea    -0x41(%esi),%ecx
            c += 'a' - 'A';
  100aab:	8d 46 20             	lea    0x20(%esi),%eax
  100aae:	83 f9 1a             	cmp    $0x1a,%ecx
  100ab1:	0f 42 f0             	cmovb  %eax,%esi
  100ab4:	e9 6d ff ff ff       	jmp    100a26 <kbd_proc_data+0x86>
  100ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        dprintf("Rebooting!\n");
  100ac0:	83 ec 0c             	sub    $0xc,%esp
  100ac3:	8d 83 2a 80 ff ff    	lea    -0x7fd6(%ebx),%eax
  100ac9:	50                   	push   %eax
  100aca:	e8 01 39 00 00       	call   1043d0 <dprintf>
        outb(0x92, 0x3);  // courtesy of Chris Frost
  100acf:	58                   	pop    %eax
  100ad0:	5a                   	pop    %edx
  100ad1:	6a 03                	push   $0x3
  100ad3:	68 92 00 00 00       	push   $0x92
  100ad8:	e8 a3 44 00 00       	call   104f80 <outb>
  100add:	83 c4 10             	add    $0x10,%esp
  100ae0:	e9 54 ff ff ff       	jmp    100a39 <kbd_proc_data+0x99>
  100ae5:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
  100ae8:	be ff ff ff ff       	mov    $0xffffffff,%esi
  100aed:	e9 47 ff ff ff       	jmp    100a39 <kbd_proc_data+0x99>
  100af2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100af9:	00 
  100afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100b00 <keyboard_intr>:

void keyboard_intr(void)
{
  100b00:	53                   	push   %ebx
  100b01:	e8 9c f8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100b06:	81 c3 ee 04 01 00    	add    $0x104ee,%ebx
  100b0c:	83 ec 14             	sub    $0x14,%esp
    cons_intr(kbd_proc_data);
  100b0f:	8d 83 ac f9 fe ff    	lea    -0x10654(%ebx),%eax
  100b15:	50                   	push   %eax
  100b16:	e8 d5 f8 ff ff       	call   1003f0 <cons_intr>
}
  100b1b:	83 c4 18             	add    $0x18,%esp
  100b1e:	5b                   	pop    %ebx
  100b1f:	c3                   	ret

00100b20 <devinit>:
#include "tsc.h"

void intr_init(void);

void devinit(uintptr_t mbi_addr)
{
  100b20:	56                   	push   %esi
  100b21:	53                   	push   %ebx
  100b22:	e8 7b f8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100b27:	81 c3 cd 04 01 00    	add    $0x104cd,%ebx
  100b2d:	83 ec 10             	sub    $0x10,%esp
  100b30:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    seg_init(0);
  100b34:	6a 00                	push   $0x0
  100b36:	e8 e5 3e 00 00       	call   104a20 <seg_init>

    enable_sse();
  100b3b:	e8 c0 42 00 00       	call   104e00 <enable_sse>

    cons_init();
  100b40:	e8 6b f8 ff ff       	call   1003b0 <cons_init>

    debug_init();
  100b45:	e8 56 35 00 00       	call   1040a0 <debug_init>
    KERN_INFO("[BSP KERN] cons initialized.\n");
  100b4a:	8d 83 36 80 ff ff    	lea    -0x7fca(%ebx),%eax
  100b50:	89 04 24             	mov    %eax,(%esp)
  100b53:	e8 68 35 00 00       	call   1040c0 <debug_info>
    KERN_INFO("[BSP KERN] devinit mbi_addr: %d\n", mbi_addr);
  100b58:	58                   	pop    %eax
  100b59:	8d 83 cc 89 ff ff    	lea    -0x7634(%ebx),%eax
  100b5f:	5a                   	pop    %edx
  100b60:	56                   	push   %esi
  100b61:	50                   	push   %eax
  100b62:	e8 59 35 00 00       	call   1040c0 <debug_info>

    /* pcpu init codes */
    pcpu_init();
  100b67:	e8 b4 51 00 00       	call   105d20 <pcpu_init>
    KERN_INFO("[BSP KERN] PCPU initialized\n");
  100b6c:	8d 83 54 80 ff ff    	lea    -0x7fac(%ebx),%eax
  100b72:	89 04 24             	mov    %eax,(%esp)
  100b75:	e8 46 35 00 00       	call   1040c0 <debug_info>

    tsc_init();
  100b7a:	e8 c1 11 00 00       	call   101d40 <tsc_init>
    KERN_INFO("[BSP KERN] TSC initialized\n");
  100b7f:	8d 83 71 80 ff ff    	lea    -0x7f8f(%ebx),%eax
  100b85:	89 04 24             	mov    %eax,(%esp)
  100b88:	e8 33 35 00 00       	call   1040c0 <debug_info>

    intr_init();
  100b8d:	e8 ee 06 00 00       	call   101280 <intr_init>
    KERN_INFO("[BSP KERN] INTR initialized\n");
  100b92:	8d 83 8d 80 ff ff    	lea    -0x7f73(%ebx),%eax
  100b98:	89 04 24             	mov    %eax,(%esp)
  100b9b:	e8 20 35 00 00       	call   1040c0 <debug_info>

    trap_init(0);
  100ba0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100ba7:	e8 34 75 00 00       	call   1080e0 <trap_init>

    pmmap_init(mbi_addr);
  100bac:	89 34 24             	mov    %esi,(%esp)
  100baf:	e8 3c 01 00 00       	call   100cf0 <pmmap_init>
}
  100bb4:	83 c4 14             	add    $0x14,%esp
  100bb7:	5b                   	pop    %ebx
  100bb8:	5e                   	pop    %esi
  100bb9:	c3                   	ret
  100bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00100bc0 <devinit_ap>:

void devinit_ap(void)
{
  100bc0:	56                   	push   %esi
  100bc1:	53                   	push   %ebx
  100bc2:	e8 db f7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  100bc7:	81 c3 2d 04 01 00    	add    $0x1042d,%ebx
  100bcd:	83 ec 04             	sub    $0x4,%esp
    /* Figure out the current (booting) kernel stack) */
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  100bd0:	e8 5b 41 00 00       	call   104d30 <read_esp>

    KERN_ASSERT(ks != NULL);
  100bd5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  100bda:	89 c6                	mov    %eax,%esi
  100bdc:	74 6a                	je     100c48 <devinit_ap+0x88>
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100bde:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  100be4:	8d 50 ff             	lea    -0x1(%eax),%edx
  100be7:	83 fa 06             	cmp    $0x6,%edx
  100bea:	0f 87 89 00 00 00    	ja     100c79 <devinit_ap+0xb9>

    /* kernel stack for this cpu initialized */
    seg_init(ks->cpu_idx);
  100bf0:	83 ec 0c             	sub    $0xc,%esp
  100bf3:	50                   	push   %eax
  100bf4:	e8 27 3e 00 00       	call   104a20 <seg_init>

    pcpu_init();
  100bf9:	e8 22 51 00 00       	call   105d20 <pcpu_init>
    KERN_INFO("[AP%d KERN] PCPU initialized\n", ks->cpu_idx);
  100bfe:	58                   	pop    %eax
  100bff:	8d 83 e5 80 ff ff    	lea    -0x7f1b(%ebx),%eax
  100c05:	5a                   	pop    %edx
  100c06:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100c0c:	50                   	push   %eax
  100c0d:	e8 ae 34 00 00       	call   1040c0 <debug_info>

    intr_init();
  100c12:	e8 69 06 00 00       	call   101280 <intr_init>
    KERN_INFO("[AP%d KERN] INTR initialized.\n", ks->cpu_idx);
  100c17:	59                   	pop    %ecx
  100c18:	58                   	pop    %eax
  100c19:	8d 83 14 8a ff ff    	lea    -0x75ec(%ebx),%eax
  100c1f:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100c25:	50                   	push   %eax
  100c26:	e8 95 34 00 00       	call   1040c0 <debug_info>

    trap_init(ks->cpu_idx);
  100c2b:	58                   	pop    %eax
  100c2c:	ff b6 1c 01 00 00    	push   0x11c(%esi)
  100c32:	e8 a9 74 00 00       	call   1080e0 <trap_init>

    paging_init_ap();
  100c37:	e8 84 61 00 00       	call   106dc0 <paging_init_ap>
}
  100c3c:	83 c4 14             	add    $0x14,%esp
  100c3f:	5b                   	pop    %ebx
  100c40:	5e                   	pop    %esi
  100c41:	c3                   	ret
  100c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(ks != NULL);
  100c48:	8d 83 aa 80 ff ff    	lea    -0x7f56(%ebx),%eax
  100c4e:	50                   	push   %eax
  100c4f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  100c55:	50                   	push   %eax
  100c56:	8d 83 d2 80 ff ff    	lea    -0x7f2e(%ebx),%eax
  100c5c:	6a 31                	push   $0x31
  100c5e:	50                   	push   %eax
  100c5f:	e8 fc 34 00 00       	call   104160 <debug_panic>
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100c64:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
    KERN_ASSERT(ks != NULL);
  100c6a:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(1 <= ks->cpu_idx && ks->cpu_idx < 8);
  100c6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  100c70:	83 fa 06             	cmp    $0x6,%edx
  100c73:	0f 86 77 ff ff ff    	jbe    100bf0 <devinit_ap+0x30>
  100c79:	8d 83 f0 89 ff ff    	lea    -0x7610(%ebx),%eax
  100c7f:	50                   	push   %eax
  100c80:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  100c86:	50                   	push   %eax
  100c87:	8d 83 d2 80 ff ff    	lea    -0x7f2e(%ebx),%eax
  100c8d:	6a 32                	push   $0x32
  100c8f:	50                   	push   %eax
  100c90:	e8 cb 34 00 00       	call   104160 <debug_panic>
    seg_init(ks->cpu_idx);
  100c95:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  100c9b:	83 c4 10             	add    $0x10,%esp
  100c9e:	e9 4d ff ff ff       	jmp    100bf0 <devinit_ap+0x30>
  100ca3:	66 90                	xchg   %ax,%ax
  100ca5:	66 90                	xchg   %ax,%ax
  100ca7:	66 90                	xchg   %ax,%ax
  100ca9:	66 90                	xchg   %ax,%ax
  100cab:	66 90                	xchg   %ax,%ax
  100cad:	66 90                	xchg   %ax,%ax
  100caf:	90                   	nop

00100cb0 <pmmap_alloc_slot>:
    if (unlikely(pmmap_slots_next_free == 128))
  100cb0:	e8 e9 f6 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  100cb5:	81 c2 3f 03 01 00    	add    $0x1033f,%edx
  100cbb:	8b 82 88 76 02 00    	mov    0x27688(%edx),%eax
  100cc1:	3d 80 00 00 00       	cmp    $0x80,%eax
  100cc6:	74 18                	je     100ce0 <pmmap_alloc_slot+0x30>
    return &pmmap_slots[pmmap_slots_next_free++];
  100cc8:	8d 48 01             	lea    0x1(%eax),%ecx
  100ccb:	8d 04 80             	lea    (%eax,%eax,4),%eax
  100cce:	89 8a 88 76 02 00    	mov    %ecx,0x27688(%edx)
  100cd4:	8d 84 82 8c 76 02 00 	lea    0x2768c(%edx,%eax,4),%eax
  100cdb:	c3                   	ret
  100cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return NULL;
  100ce0:	31 c0                	xor    %eax,%eax
}
  100ce2:	c3                   	ret
  100ce3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100cea:	00 
  100ceb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00100cf0 <pmmap_init>:
                  (slot->type == MEM_NVS) ? "ACPI NVS" : "unknown");
    }
}

void pmmap_init(uintptr_t mbi_addr)
{
  100cf0:	55                   	push   %ebp
  100cf1:	e8 83 05 00 00       	call   101279 <__x86.get_pc_thunk.bp>
  100cf6:	81 c5 fe 02 01 00    	add    $0x102fe,%ebp
  100cfc:	57                   	push   %edi
  100cfd:	56                   	push   %esi
  100cfe:	53                   	push   %ebx
  100cff:	83 ec 58             	sub    $0x58,%esp
    KERN_INFO("\n");
  100d02:	8d 85 59 85 ff ff    	lea    -0x7aa7(%ebp),%eax
{
  100d08:	8b 74 24 6c          	mov    0x6c(%esp),%esi
    KERN_INFO("\n");
  100d0c:	89 eb                	mov    %ebp,%ebx
  100d0e:	50                   	push   %eax
  100d0f:	e8 ac 33 00 00       	call   1040c0 <debug_info>

    mboot_info_t *mbi = (mboot_info_t *) mbi_addr;
    mboot_mmap_t *p = (mboot_mmap_t *) mbi->mmap_addr;
  100d14:	8b 46 30             	mov    0x30(%esi),%eax
    SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);

    /*
     * Copy memory map information from multiboot information mbi to pmmap.
     */
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100d17:	8b 76 2c             	mov    0x2c(%esi),%esi
    SLIST_INIT(&pmmap_list);
  100d1a:	c7 85 84 76 02 00 00 	movl   $0x0,0x27684(%ebp)
  100d21:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_USABLE]);
  100d24:	c7 85 74 76 02 00 00 	movl   $0x0,0x27674(%ebp)
  100d2b:	00 00 00 
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100d2e:	89 74 24 34          	mov    %esi,0x34(%esp)
  100d32:	83 c4 10             	add    $0x10,%esp
    SLIST_INIT(&pmmap_sublist[PMMAP_RESV]);
  100d35:	c7 85 78 76 02 00 00 	movl   $0x0,0x27678(%ebp)
  100d3c:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_ACPI]);
  100d3f:	c7 85 7c 76 02 00 00 	movl   $0x0,0x2767c(%ebp)
  100d46:	00 00 00 
    SLIST_INIT(&pmmap_sublist[PMMAP_NVS]);
  100d49:	c7 85 80 76 02 00 00 	movl   $0x0,0x27680(%ebp)
  100d50:	00 00 00 
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100d53:	85 f6                	test   %esi,%esi
  100d55:	0f 84 4f 03 00 00    	je     1010aa <pmmap_init+0x3ba>
  100d5b:	ba e8 ff ff ff       	mov    $0xffffffe8,%edx
  100d60:	8d 58 18             	lea    0x18(%eax),%ebx
  100d63:	31 ff                	xor    %edi,%edi
  100d65:	c6 44 24 2f 00       	movb   $0x0,0x2f(%esp)
  100d6a:	29 c2                	sub    %eax,%edx
  100d6c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  100d70:	8b b5 88 76 02 00    	mov    0x27688(%ebp),%esi
  100d76:	c6 44 24 14 00       	movb   $0x0,0x14(%esp)
  100d7b:	89 54 24 28          	mov    %edx,0x28(%esp)
  100d7f:	89 7c 24 20          	mov    %edi,0x20(%esp)
  100d83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        uintptr_t start, end;
        uint32_t type;

        if (p->base_addr_high != 0)  /* ignore address above 4G */
  100d88:	8b 78 08             	mov    0x8(%eax),%edi
  100d8b:	85 ff                	test   %edi,%edi
  100d8d:	0f 85 c5 00 00 00    	jne    100e58 <pmmap_init+0x168>
            goto next;
        else
            start = p->base_addr_low;

        if (p->length_high != 0 || p->length_low >= 0xffffffff - start)
  100d93:	8b 58 10             	mov    0x10(%eax),%ebx
            start = p->base_addr_low;
  100d96:	8b 50 04             	mov    0x4(%eax),%edx
            end = 0xffffffff;
  100d99:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
        if (p->length_high != 0 || p->length_low >= 0xffffffff - start)
  100d9e:	85 db                	test   %ebx,%ebx
  100da0:	75 0f                	jne    100db1 <pmmap_init+0xc1>
        else
            end = start + p->length_low;
  100da2:	8b 78 0c             	mov    0xc(%eax),%edi
  100da5:	89 d3                	mov    %edx,%ebx
  100da7:	f7 d3                	not    %ebx
  100da9:	01 d7                	add    %edx,%edi
  100dab:	39 58 0c             	cmp    %ebx,0xc(%eax)
  100dae:	0f 42 cf             	cmovb  %edi,%ecx

        type = p->type;
  100db1:	8b 40 14             	mov    0x14(%eax),%eax
  100db4:	89 44 24 10          	mov    %eax,0x10(%esp)
    if (unlikely(pmmap_slots_next_free == 128))
  100db8:	81 fe 80 00 00 00    	cmp    $0x80,%esi
  100dbe:	0f 84 3c f2 ff ff    	je     100000 <pmmap_init.cold>
    return &pmmap_slots[pmmap_slots_next_free++];
  100dc4:	8d 46 01             	lea    0x1(%esi),%eax
  100dc7:	8d 1c b5 00 00 00 00 	lea    0x0(,%esi,4),%ebx
  100dce:	89 44 24 14          	mov    %eax,0x14(%esp)
  100dd2:	8d 04 33             	lea    (%ebx,%esi,1),%eax
  100dd5:	c1 e0 02             	shl    $0x2,%eax
  100dd8:	8d bc 05 8c 76 02 00 	lea    0x2768c(%ebp,%eax,1),%edi
    free_slot->end = end;
  100ddf:	8d 84 05 8c 76 02 00 	lea    0x2768c(%ebp,%eax,1),%eax
  100de6:	89 48 04             	mov    %ecx,0x4(%eax)
    free_slot->type = type;
  100de9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
    return &pmmap_slots[pmmap_slots_next_free++];
  100ded:	89 7c 24 18          	mov    %edi,0x18(%esp)
    free_slot->type = type;
  100df1:	89 48 08             	mov    %ecx,0x8(%eax)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100df4:	8b 44 24 20          	mov    0x20(%esp),%eax
    free_slot->start = start;
  100df8:	89 17                	mov    %edx,(%edi)
    free_slot->end = end;
  100dfa:	8d 3d 8c 76 02 00    	lea    0x2768c,%edi
  100e00:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e04:	85 c0                	test   %eax,%eax
  100e06:	74 25                	je     100e2d <pmmap_init+0x13d>
    last_slot = NULL;
  100e08:	31 ff                	xor    %edi,%edi
  100e0a:	eb 13                	jmp    100e1f <pmmap_init+0x12f>
  100e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100e10:	8b 48 0c             	mov    0xc(%eax),%ecx
  100e13:	89 c7                	mov    %eax,%edi
  100e15:	85 c9                	test   %ecx,%ecx
  100e17:	0f 84 33 02 00 00    	je     101050 <pmmap_init+0x360>
  100e1d:	89 c8                	mov    %ecx,%eax
        if (start < slot->start)
  100e1f:	3b 10                	cmp    (%eax),%edx
  100e21:	73 ed                	jae    100e10 <pmmap_init+0x120>
    if (last_slot == NULL) {
  100e23:	89 f8                	mov    %edi,%eax
  100e25:	85 ff                	test   %edi,%edi
  100e27:	0f 85 23 02 00 00    	jne    101050 <pmmap_init+0x360>
        SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100e2d:	01 f3                	add    %esi,%ebx
  100e2f:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  100e33:	c6 44 24 2f 01       	movb   $0x1,0x2f(%esp)
  100e38:	8d 44 9d 00          	lea    0x0(%ebp,%ebx,4),%eax
  100e3c:	8b 5c 24 20          	mov    0x20(%esp),%ebx
  100e40:	89 5c 06 0c          	mov    %ebx,0xc(%esi,%eax,1)
  100e44:	8b 44 24 18          	mov    0x18(%esp),%eax
    return &pmmap_slots[pmmap_slots_next_free++];
  100e48:	8b 74 24 14          	mov    0x14(%esp),%esi
  100e4c:	c6 44 24 14 01       	movb   $0x1,0x14(%esp)
        SLIST_INSERT_HEAD(&pmmap_list, free_slot, next);
  100e51:	89 44 24 20          	mov    %eax,0x20(%esp)
  100e55:	8d 76 00             	lea    0x0(%esi),%esi

        pmmap_insert(start, end, type);

      next:
        p = (mboot_mmap_t *) (((uint32_t) p) + sizeof(mboot_mmap_t) /* p->size */);
  100e58:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100e5c:	8b 7c 24 28          	mov    0x28(%esp),%edi
        p = (mboot_mmap_t *) (((uint32_t) p) + sizeof(mboot_mmap_t) /* p->size */);
  100e60:	89 d8                	mov    %ebx,%eax
    while ((uintptr_t) p - (uintptr_t) mbi->mmap_addr < mbi->mmap_length) {
  100e62:	83 c3 18             	add    $0x18,%ebx
  100e65:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  100e68:	8b 7c 24 24          	mov    0x24(%esp),%edi
  100e6c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  100e70:	39 fa                	cmp    %edi,%edx
  100e72:	0f 82 10 ff ff ff    	jb     100d88 <pmmap_init+0x98>
  100e78:	80 7c 24 2f 00       	cmpb   $0x0,0x2f(%esp)
  100e7d:	8b 7c 24 20          	mov    0x20(%esp),%edi
  100e81:	0f 84 52 02 00 00    	je     1010d9 <pmmap_init+0x3e9>
  100e87:	80 7c 24 14 00       	cmpb   $0x0,0x14(%esp)
  100e8c:	89 bd 84 76 02 00    	mov    %edi,0x27684(%ebp)
  100e92:	74 06                	je     100e9a <pmmap_init+0x1aa>
  100e94:	89 b5 88 76 02 00    	mov    %esi,0x27688(%ebp)
    struct pmmap *last_slot[4] = { NULL, NULL, NULL, NULL };
  100e9a:	c7 44 24 30 00 00 00 	movl   $0x0,0x30(%esp)
  100ea1:	00 
  100ea2:	c7 44 24 34 00 00 00 	movl   $0x0,0x34(%esp)
  100ea9:	00 
  100eaa:	c7 44 24 38 00 00 00 	movl   $0x0,0x38(%esp)
  100eb1:	00 
  100eb2:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%esp)
  100eb9:	00 
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100eba:	85 ff                	test   %edi,%edi
  100ebc:	0f 84 e8 01 00 00    	je     1010aa <pmmap_init+0x3ba>
        if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100ec2:	8b 47 0c             	mov    0xc(%edi),%eax
  100ec5:	85 c0                	test   %eax,%eax
  100ec7:	74 29                	je     100ef2 <pmmap_init+0x202>
  100ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (slot->start <= next_slot->start &&
  100ed0:	8b 10                	mov    (%eax),%edx
  100ed2:	3b 17                	cmp    (%edi),%edx
  100ed4:	72 13                	jb     100ee9 <pmmap_init+0x1f9>
            slot->end >= next_slot->start &&
  100ed6:	8b 4f 04             	mov    0x4(%edi),%ecx
        if (slot->start <= next_slot->start &&
  100ed9:	39 d1                	cmp    %edx,%ecx
  100edb:	72 0c                	jb     100ee9 <pmmap_init+0x1f9>
            slot->end >= next_slot->start &&
  100edd:	8b 70 08             	mov    0x8(%eax),%esi
  100ee0:	39 77 08             	cmp    %esi,0x8(%edi)
  100ee3:	0f 84 36 01 00 00    	je     10101f <pmmap_init+0x32f>
  100ee9:	89 c7                	mov    %eax,%edi
        if ((next_slot = SLIST_NEXT(slot, next)) == NULL)
  100eeb:	8b 47 0c             	mov    0xc(%edi),%eax
  100eee:	85 c0                	test   %eax,%eax
  100ef0:	75 de                	jne    100ed0 <pmmap_init+0x1e0>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100ef2:	8b b5 84 76 02 00    	mov    0x27684(%ebp),%esi
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100ef8:	8d bd 74 76 02 00    	lea    0x27674(%ebp),%edi
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100efe:	85 f6                	test   %esi,%esi
  100f00:	75 2a                	jne    100f2c <pmmap_init+0x23c>
  100f02:	e9 a3 01 00 00       	jmp    1010aa <pmmap_init+0x3ba>
  100f07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  100f0e:	00 
  100f0f:	90                   	nop
        if (last_slot[sublist_nr] != NULL)
  100f10:	8b 54 84 30          	mov    0x30(%esp,%eax,4),%edx
  100f14:	85 d2                	test   %edx,%edx
  100f16:	74 4d                	je     100f65 <pmmap_init+0x275>
            SLIST_INSERT_AFTER(last_slot[sublist_nr], slot, type_next);
  100f18:	8b 4a 10             	mov    0x10(%edx),%ecx
        last_slot[sublist_nr] = slot;
  100f1b:	89 74 84 30          	mov    %esi,0x30(%esp,%eax,4)
            SLIST_INSERT_AFTER(last_slot[sublist_nr], slot, type_next);
  100f1f:	89 4e 10             	mov    %ecx,0x10(%esi)
  100f22:	89 72 10             	mov    %esi,0x10(%edx)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f25:	8b 76 0c             	mov    0xc(%esi),%esi
  100f28:	85 f6                	test   %esi,%esi
  100f2a:	74 4d                	je     100f79 <pmmap_init+0x289>
        sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100f2c:	8b 46 08             	mov    0x8(%esi),%eax
  100f2f:	83 e8 01             	sub    $0x1,%eax
  100f32:	83 f8 03             	cmp    $0x3,%eax
  100f35:	76 d9                	jbe    100f10 <pmmap_init+0x220>
        KERN_ASSERT(sublist_nr != -1);
  100f37:	8d 85 5c 81 ff ff    	lea    -0x7ea4(%ebp),%eax
  100f3d:	89 eb                	mov    %ebp,%ebx
  100f3f:	50                   	push   %eax
  100f40:	8d 85 b5 80 ff ff    	lea    -0x7f4b(%ebp),%eax
  100f46:	50                   	push   %eax
  100f47:	8d 85 4b 81 ff ff    	lea    -0x7eb5(%ebp),%eax
  100f4d:	6a 6b                	push   $0x6b
  100f4f:	50                   	push   %eax
  100f50:	e8 0b 32 00 00       	call   104160 <debug_panic>
  100f55:	83 c4 10             	add    $0x10,%esp
        sublist_nr = PMMAP_SUBLIST_NR(slot->type);
  100f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        if (last_slot[sublist_nr] != NULL)
  100f5d:	8b 54 84 30          	mov    0x30(%esp,%eax,4),%edx
  100f61:	85 d2                	test   %edx,%edx
  100f63:	75 b3                	jne    100f18 <pmmap_init+0x228>
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100f65:	8b 14 87             	mov    (%edi,%eax,4),%edx
        last_slot[sublist_nr] = slot;
  100f68:	89 74 84 30          	mov    %esi,0x30(%esp,%eax,4)
            SLIST_INSERT_HEAD(&pmmap_sublist[sublist_nr], slot, type_next);
  100f6c:	89 34 87             	mov    %esi,(%edi,%eax,4)
  100f6f:	89 56 10             	mov    %edx,0x10(%esi)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f72:	8b 76 0c             	mov    0xc(%esi),%esi
  100f75:	85 f6                	test   %esi,%esi
  100f77:	75 b3                	jne    100f2c <pmmap_init+0x23c>
    if (last_slot[PMMAP_USABLE] != NULL)
  100f79:	8b 44 24 30          	mov    0x30(%esp),%eax
  100f7d:	85 c0                	test   %eax,%eax
  100f7f:	74 09                	je     100f8a <pmmap_init+0x29a>
        max_usable_memory = last_slot[PMMAP_USABLE]->end;
  100f81:	8b 40 04             	mov    0x4(%eax),%eax
  100f84:	89 85 70 76 02 00    	mov    %eax,0x27670(%ebp)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100f8a:	8b b5 84 76 02 00    	mov    0x27684(%ebp),%esi
  100f90:	85 f6                	test   %esi,%esi
  100f92:	0f 84 12 01 00 00    	je     1010aa <pmmap_init+0x3ba>
        KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  100f98:	8d 85 1b 81 ff ff    	lea    -0x7ee5(%ebp),%eax
  100f9e:	8d bd 34 8a ff ff    	lea    -0x75cc(%ebp),%edi
  100fa4:	89 44 24 10          	mov    %eax,0x10(%esp)
  100fa8:	8d 85 25 81 ff ff    	lea    -0x7edb(%ebp),%eax
  100fae:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100fb2:	eb 4d                	jmp    101001 <pmmap_init+0x311>
  100fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  100fb8:	8d 95 0b 81 ff ff    	lea    -0x7ef5(%ebp),%edx
  100fbe:	83 f8 01             	cmp    $0x1,%eax
  100fc1:	74 12                	je     100fd5 <pmmap_init+0x2e5>
  100fc3:	83 f8 02             	cmp    $0x2,%eax
  100fc6:	8d 95 03 81 ff ff    	lea    -0x7efd(%ebp),%edx
  100fcc:	8d 85 12 81 ff ff    	lea    -0x7eee(%ebp),%eax
  100fd2:	0f 44 d0             	cmove  %eax,%edx
  100fd5:	8b 0e                	mov    (%esi),%ecx
  100fd7:	8b 46 04             	mov    0x4(%esi),%eax
  100fda:	39 c1                	cmp    %eax,%ecx
  100fdc:	74 0a                	je     100fe8 <pmmap_init+0x2f8>
  100fde:	31 db                	xor    %ebx,%ebx
  100fe0:	83 f8 ff             	cmp    $0xffffffff,%eax
  100fe3:	0f 95 c3             	setne  %bl
  100fe6:	29 d8                	sub    %ebx,%eax
  100fe8:	52                   	push   %edx
  100fe9:	89 eb                	mov    %ebp,%ebx
  100feb:	50                   	push   %eax
  100fec:	51                   	push   %ecx
  100fed:	57                   	push   %edi
  100fee:	e8 cd 30 00 00       	call   1040c0 <debug_info>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  100ff3:	8b 76 0c             	mov    0xc(%esi),%esi
  100ff6:	83 c4 10             	add    $0x10,%esp
  100ff9:	85 f6                	test   %esi,%esi
  100ffb:	0f 84 7f 00 00 00    	je     101080 <pmmap_init+0x390>
        KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  101001:	8b 46 08             	mov    0x8(%esi),%eax
  101004:	83 f8 03             	cmp    $0x3,%eax
  101007:	0f 84 c3 00 00 00    	je     1010d0 <pmmap_init+0x3e0>
  10100d:	76 a9                	jbe    100fb8 <pmmap_init+0x2c8>
  10100f:	83 f8 04             	cmp    $0x4,%eax
  101012:	8d 95 03 81 ff ff    	lea    -0x7efd(%ebp),%edx
  101018:	0f 44 54 24 0c       	cmove  0xc(%esp),%edx
  10101d:	eb b6                	jmp    100fd5 <pmmap_init+0x2e5>
            slot->end = max(slot->end, next_slot->end);
  10101f:	83 ec 08             	sub    $0x8,%esp
  101022:	ff 70 04             	push   0x4(%eax)
  101025:	89 eb                	mov    %ebp,%ebx
  101027:	51                   	push   %ecx
  101028:	e8 a3 3c 00 00       	call   104cd0 <max>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10102d:	83 c4 10             	add    $0x10,%esp
            slot->end = max(slot->end, next_slot->end);
  101030:	89 47 04             	mov    %eax,0x4(%edi)
            SLIST_REMOVE_AFTER(slot, next);
  101033:	8b 47 0c             	mov    0xc(%edi),%eax
  101036:	8b 40 0c             	mov    0xc(%eax),%eax
  101039:	89 47 0c             	mov    %eax,0xc(%edi)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10103c:	85 c0                	test   %eax,%eax
  10103e:	0f 84 ae fe ff ff    	je     100ef2 <pmmap_init+0x202>
  101044:	89 c7                	mov    %eax,%edi
  101046:	e9 a0 fe ff ff       	jmp    100eeb <pmmap_init+0x1fb>
  10104b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        SLIST_INSERT_AFTER(last_slot, free_slot, next);
  101050:	8b 48 0c             	mov    0xc(%eax),%ecx
  101053:	01 f3                	add    %esi,%ebx
  101055:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  101059:	8d 54 9d 00          	lea    0x0(%ebp,%ebx,4),%edx
  10105d:	89 4c 16 0c          	mov    %ecx,0xc(%esi,%edx,1)
  101061:	8b 74 24 18          	mov    0x18(%esp),%esi
  101065:	89 70 0c             	mov    %esi,0xc(%eax)
    return &pmmap_slots[pmmap_slots_next_free++];
  101068:	8b 74 24 14          	mov    0x14(%esp),%esi
        SLIST_INSERT_AFTER(last_slot, free_slot, next);
  10106c:	c6 44 24 14 01       	movb   $0x1,0x14(%esp)
  101071:	e9 e2 fd ff ff       	jmp    100e58 <pmmap_init+0x168>
  101076:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10107d:	00 
  10107e:	66 90                	xchg   %ax,%ax
    pmmap_merge();
    pmmap_dump();

    /* count the number of pmmap entries */
    struct pmmap *slot;
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101080:	8b 95 84 76 02 00    	mov    0x27684(%ebp),%edx
  101086:	85 d2                	test   %edx,%edx
  101088:	74 20                	je     1010aa <pmmap_init+0x3ba>
  10108a:	8b 85 6c 76 02 00    	mov    0x2766c(%ebp),%eax
  101090:	83 c0 01             	add    $0x1,%eax
  101093:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  101098:	8b 52 0c             	mov    0xc(%edx),%edx
  10109b:	89 c1                	mov    %eax,%ecx
  10109d:	83 c0 01             	add    $0x1,%eax
  1010a0:	85 d2                	test   %edx,%edx
  1010a2:	75 f4                	jne    101098 <pmmap_init+0x3a8>
  1010a4:	89 8d 6c 76 02 00    	mov    %ecx,0x2766c(%ebp)
        pmmap_nentries++;
    }

    /* Calculate the maximum page number */
    mem_npages = rounddown(max_usable_memory, PAGESIZE) / PAGESIZE;
  1010aa:	83 ec 08             	sub    $0x8,%esp
  1010ad:	89 eb                	mov    %ebp,%ebx
  1010af:	68 00 10 00 00       	push   $0x1000
  1010b4:	ff b5 70 76 02 00    	push   0x27670(%ebp)
  1010ba:	e8 31 3c 00 00       	call   104cf0 <rounddown>
}
  1010bf:	83 c4 5c             	add    $0x5c,%esp
  1010c2:	5b                   	pop    %ebx
  1010c3:	5e                   	pop    %esi
  1010c4:	5f                   	pop    %edi
  1010c5:	5d                   	pop    %ebp
  1010c6:	c3                   	ret
  1010c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1010ce:	00 
  1010cf:	90                   	nop
        KERN_INFO("BIOS-e820: 0x%08x - 0x%08x (%s)\n",
  1010d0:	8b 54 24 10          	mov    0x10(%esp),%edx
  1010d4:	e9 fc fe ff ff       	jmp    100fd5 <pmmap_init+0x2e5>
  1010d9:	80 7c 24 14 00       	cmpb   $0x0,0x14(%esp)
  1010de:	74 ca                	je     1010aa <pmmap_init+0x3ba>
  1010e0:	89 b5 88 76 02 00    	mov    %esi,0x27688(%ebp)
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1010e6:	eb c2                	jmp    1010aa <pmmap_init+0x3ba>
  1010e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1010ef:	00 

001010f0 <get_size>:

int get_size(void)
{
    return pmmap_nentries;
  1010f0:	e8 a5 f2 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  1010f5:	05 ff fe 00 00       	add    $0xfeff,%eax
  1010fa:	8b 80 6c 76 02 00    	mov    0x2766c(%eax),%eax
}
  101100:	c3                   	ret
  101101:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  101108:	00 
  101109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101110 <get_mms>:

uint32_t get_mms(int idx)
{
  101110:	53                   	push   %ebx
  101111:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  101115:	e8 88 f2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10111a:	81 c3 da fe 00 00    	add    $0xfeda,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  101120:	8b 83 84 76 02 00    	mov    0x27684(%ebx),%eax
  101126:	85 c0                	test   %eax,%eax
  101128:	74 1c                	je     101146 <get_mms+0x36>
    int i = 0;
  10112a:	31 d2                	xor    %edx,%edx
        if (i == idx)
  10112c:	85 c9                	test   %ecx,%ecx
  10112e:	75 0c                	jne    10113c <get_mms+0x2c>
  101130:	eb 1e                	jmp    101150 <get_mms+0x40>
  101132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101138:	39 d1                	cmp    %edx,%ecx
  10113a:	74 14                	je     101150 <get_mms+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10113c:	8b 40 0c             	mov    0xc(%eax),%eax
            break;
        i++;
  10113f:	83 c2 01             	add    $0x1,%edx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101142:	85 c0                	test   %eax,%eax
  101144:	75 f2                	jne    101138 <get_mms+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  101146:	31 c9                	xor    %ecx,%ecx

    return slot->start;
}
  101148:	89 c8                	mov    %ecx,%eax
  10114a:	5b                   	pop    %ebx
  10114b:	c3                   	ret
  10114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  101150:	31 c9                	xor    %ecx,%ecx
    if (slot == NULL || i == pmmap_nentries)
  101152:	39 93 6c 76 02 00    	cmp    %edx,0x2766c(%ebx)
  101158:	74 ee                	je     101148 <get_mms+0x38>
    return slot->start;
  10115a:	8b 08                	mov    (%eax),%ecx
}
  10115c:	5b                   	pop    %ebx
  10115d:	89 c8                	mov    %ecx,%eax
  10115f:	c3                   	ret

00101160 <get_mml>:

uint32_t get_mml(int idx)
{
  101160:	53                   	push   %ebx
  101161:	8b 44 24 08          	mov    0x8(%esp),%eax
  101165:	e8 38 f2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10116a:	81 c3 8a fe 00 00    	add    $0xfe8a,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  101170:	8b 93 84 76 02 00    	mov    0x27684(%ebx),%edx
  101176:	85 d2                	test   %edx,%edx
  101178:	74 1c                	je     101196 <get_mml+0x36>
    int i = 0;
  10117a:	31 c9                	xor    %ecx,%ecx
        if (i == idx)
  10117c:	85 c0                	test   %eax,%eax
  10117e:	75 0c                	jne    10118c <get_mml+0x2c>
  101180:	eb 1e                	jmp    1011a0 <get_mml+0x40>
  101182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101188:	39 c8                	cmp    %ecx,%eax
  10118a:	74 14                	je     1011a0 <get_mml+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  10118c:	8b 52 0c             	mov    0xc(%edx),%edx
            break;
        i++;
  10118f:	83 c1 01             	add    $0x1,%ecx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  101192:	85 d2                	test   %edx,%edx
  101194:	75 f2                	jne    101188 <get_mml+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  101196:	31 c0                	xor    %eax,%eax

    return slot->end - slot->start;
}
  101198:	5b                   	pop    %ebx
  101199:	c3                   	ret
  10119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
  1011a0:	31 c0                	xor    %eax,%eax
    if (slot == NULL || i == pmmap_nentries)
  1011a2:	39 8b 6c 76 02 00    	cmp    %ecx,0x2766c(%ebx)
  1011a8:	74 ee                	je     101198 <get_mml+0x38>
    return slot->end - slot->start;
  1011aa:	8b 42 04             	mov    0x4(%edx),%eax
}
  1011ad:	5b                   	pop    %ebx
    return slot->end - slot->start;
  1011ae:	2b 02                	sub    (%edx),%eax
}
  1011b0:	c3                   	ret
  1011b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1011b8:	00 
  1011b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001011c0 <is_usable>:

int is_usable(int idx)
{
  1011c0:	53                   	push   %ebx
  1011c1:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1011c5:	e8 d8 f1 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1011ca:	81 c3 2a fe 00 00    	add    $0xfe2a,%ebx
    int i = 0;
    struct pmmap *slot = NULL;

    SLIST_FOREACH(slot, &pmmap_list, next) {
  1011d0:	8b 83 84 76 02 00    	mov    0x27684(%ebx),%eax
  1011d6:	85 c0                	test   %eax,%eax
  1011d8:	74 1c                	je     1011f6 <is_usable+0x36>
    int i = 0;
  1011da:	31 d2                	xor    %edx,%edx
        if (i == idx)
  1011dc:	85 c9                	test   %ecx,%ecx
  1011de:	75 0c                	jne    1011ec <is_usable+0x2c>
  1011e0:	eb 1e                	jmp    101200 <is_usable+0x40>
  1011e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1011e8:	39 d1                	cmp    %edx,%ecx
  1011ea:	74 14                	je     101200 <is_usable+0x40>
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1011ec:	8b 40 0c             	mov    0xc(%eax),%eax
            break;
        i++;
  1011ef:	83 c2 01             	add    $0x1,%edx
    SLIST_FOREACH(slot, &pmmap_list, next) {
  1011f2:	85 c0                	test   %eax,%eax
  1011f4:	75 f2                	jne    1011e8 <is_usable+0x28>
    }

    if (slot == NULL || i == pmmap_nentries)
        return 0;
  1011f6:	31 c9                	xor    %ecx,%ecx

    return slot->type == MEM_RAM;
}
  1011f8:	89 c8                	mov    %ecx,%eax
  1011fa:	5b                   	pop    %ebx
  1011fb:	c3                   	ret
  1011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  101200:	31 c9                	xor    %ecx,%ecx
    if (slot == NULL || i == pmmap_nentries)
  101202:	39 93 6c 76 02 00    	cmp    %edx,0x2766c(%ebx)
  101208:	74 ee                	je     1011f8 <is_usable+0x38>
    return slot->type == MEM_RAM;
  10120a:	31 c9                	xor    %ecx,%ecx
  10120c:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
}
  101210:	5b                   	pop    %ebx
    return slot->type == MEM_RAM;
  101211:	0f 94 c1             	sete   %cl
}
  101214:	89 c8                	mov    %ecx,%eax
  101216:	c3                   	ret
  101217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10121e:	00 
  10121f:	90                   	nop

00101220 <set_cr3>:

void set_cr3(unsigned int **pdir)
{
  101220:	53                   	push   %ebx
  101221:	e8 7c f1 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101226:	81 c3 ce fd 00 00    	add    $0xfdce,%ebx
  10122c:	83 ec 14             	sub    $0x14,%esp
    lcr3((uint32_t) pdir);
  10122f:	ff 74 24 1c          	push   0x1c(%esp)
  101233:	e8 e8 3c 00 00       	call   104f20 <lcr3>
}
  101238:	83 c4 18             	add    $0x18,%esp
  10123b:	5b                   	pop    %ebx
  10123c:	c3                   	ret
  10123d:	8d 76 00             	lea    0x0(%esi),%esi

00101240 <enable_paging>:

void enable_paging(void)
{
  101240:	53                   	push   %ebx
  101241:	e8 5c f1 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101246:	81 c3 ae fd 00 00    	add    $0xfdae,%ebx
  10124c:	83 ec 08             	sub    $0x8,%esp
    /* enable global pages (Sec 4.10.2.4, Intel ASDM Vol3) */
    uint32_t cr4 = rcr4();
  10124f:	e8 ec 3c 00 00       	call   104f40 <rcr4>
    cr4 |= CR4_PGE;
    lcr4(cr4);
  101254:	83 ec 0c             	sub    $0xc,%esp
    cr4 |= CR4_PGE;
  101257:	0c 80                	or     $0x80,%al
    lcr4(cr4);
  101259:	50                   	push   %eax
  10125a:	e8 d1 3c 00 00       	call   104f30 <lcr4>

    /* turn on paging */
    uint32_t cr0 = rcr0();
  10125f:	e8 9c 3c 00 00       	call   104f00 <rcr0>
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_MP;
    cr0 &= ~(CR0_EM | CR0_TS);
  101264:	83 e0 f3             	and    $0xfffffff3,%eax
  101267:	0d 23 00 05 80       	or     $0x80050023,%eax
    lcr0(cr0);
  10126c:	89 04 24             	mov    %eax,(%esp)
  10126f:	e8 7c 3c 00 00       	call   104ef0 <lcr0>
}
  101274:	83 c4 18             	add    $0x18,%esp
  101277:	5b                   	pop    %ebx
  101278:	c3                   	ret

00101279 <__x86.get_pc_thunk.bp>:
  101279:	8b 2c 24             	mov    (%esp),%ebp
  10127c:	c3                   	ret
  10127d:	66 90                	xchg   %ax,%ax
  10127f:	90                   	nop

00101280 <intr_init>:
{
    asm volatile ("lidt %0" :: "m" (idt_pd));
}

void intr_init(void)
{
  101280:	55                   	push   %ebp
  101281:	57                   	push   %edi
  101282:	56                   	push   %esi
  101283:	53                   	push   %ebx
  101284:	e8 19 f1 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101289:	81 c3 6b fd 00 00    	add    $0xfd6b,%ebx
  10128f:	83 ec 38             	sub    $0x38,%esp
    uint32_t dummy, edx;

    cpuid(0x00000001, &dummy, &dummy, &dummy, &edx);
  101292:	8d 44 24 28          	lea    0x28(%esp),%eax
  101296:	50                   	push   %eax
  101297:	8d 44 24 28          	lea    0x28(%esp),%eax
  10129b:	50                   	push   %eax
  10129c:	50                   	push   %eax
  10129d:	50                   	push   %eax
  10129e:	6a 01                	push   $0x1
  1012a0:	e8 7b 3b 00 00       	call   104e20 <cpuid>
    using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  1012a5:	8b 44 24 3c          	mov    0x3c(%esp),%eax
    KERN_ASSERT(using_apic == TRUE);
  1012a9:	83 c4 20             	add    $0x20,%esp
    using_apic = (edx & CPUID_FEATURE_APIC) ? TRUE : FALSE;
  1012ac:	c1 e8 09             	shr    $0x9,%eax
  1012af:	83 e0 01             	and    $0x1,%eax
  1012b2:	88 83 8c 88 02 00    	mov    %al,0x2888c(%ebx)
    KERN_ASSERT(using_apic == TRUE);
  1012b8:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  1012bf:	3c 01                	cmp    $0x1,%al
  1012c1:	74 1f                	je     1012e2 <intr_init+0x62>
  1012c3:	8d 83 6d 81 ff ff    	lea    -0x7e93(%ebx),%eax
  1012c9:	50                   	push   %eax
  1012ca:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1012d0:	50                   	push   %eax
  1012d1:	8d 83 80 81 ff ff    	lea    -0x7e80(%ebx),%eax
  1012d7:	6a 63                	push   $0x63
  1012d9:	50                   	push   %eax
  1012da:	e8 81 2e 00 00       	call   104160 <debug_panic>
  1012df:	83 c4 10             	add    $0x10,%esp

    if (pcpu_onboot())
  1012e2:	e8 99 28 00 00       	call   103b80 <pcpu_onboot>
  1012e7:	84 c0                	test   %al,%al
  1012e9:	75 25                	jne    101310 <intr_init+0x90>
            intr_init_idt();
        }
    }

    /* all processors */
    if (using_apic)
  1012eb:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  1012f2:	84 c0                	test   %al,%al
  1012f4:	0f 85 56 05 00 00    	jne    101850 <intr_init+0x5d0>
    asm volatile ("lidt %0" :: "m" (idt_pd));
  1012fa:	0f 01 9b 0c 03 00 00 	lidtl  0x30c(%ebx)
    {
        lapic_init();
    }
    intr_install_idt();
}
  101301:	83 c4 2c             	add    $0x2c,%esp
  101304:	5b                   	pop    %ebx
  101305:	5e                   	pop    %esi
  101306:	5f                   	pop    %edi
  101307:	5d                   	pop    %ebp
  101308:	c3                   	ret
  101309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pic_init();
  101310:	e8 5b 07 00 00       	call   101a70 <pic_init>
        if (using_apic)
  101315:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  10131c:	84 c0                	test   %al,%al
  10131e:	74 cb                	je     1012eb <intr_init+0x6b>
            ioapic_init();
  101320:	e8 8b 18 00 00       	call   102bb0 <ioapic_init>
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101325:	c7 c0 ce 22 10 00    	mov    $0x1022ce,%eax
  10132b:	8d 35 8c 80 02 00    	lea    0x2808c,%esi
  101331:	8d 8b 8c 80 02 00    	lea    0x2808c(%ebx),%ecx
  101337:	89 c2                	mov    %eax,%edx
  101339:	89 44 24 08          	mov    %eax,0x8(%esp)
  10133d:	89 c7                	mov    %eax,%edi
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  10133f:	31 c0                	xor    %eax,%eax
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101341:	c1 ea 10             	shr    $0x10,%edx
  101344:	89 54 24 0c          	mov    %edx,0xc(%esp)
  101348:	89 d5                	mov    %edx,%ebp
  10134a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101350:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  101357:	66 89 3c c1          	mov    %di,(%ecx,%eax,8)
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  10135b:	83 c0 01             	add    $0x1,%eax
        SETGATE(idt[i], 0, CPU_GDT_KCODE, &Xdefault, 0);
  10135e:	c7 84 13 8e 80 02 00 	movl   $0x8e000008,0x2808e(%ebx,%edx,1)
  101365:	08 00 00 8e 
  101369:	01 da                	add    %ebx,%edx
  10136b:	66 89 6c 16 06       	mov    %bp,0x6(%esi,%edx,1)
    for (i = 0; i < sizeof(idt) / sizeof(idt[0]); i++)
  101370:	3d 00 01 00 00       	cmp    $0x100,%eax
  101375:	75 d9                	jne    101350 <intr_init+0xd0>
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  101377:	c7 c0 c0 21 10 00    	mov    $0x1021c0,%eax
  10137d:	8b 54 24 0c          	mov    0xc(%esp),%edx
  101381:	c7 83 8e 80 02 00 08 	movl   $0x8e000008,0x2808e(%ebx)
  101388:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  10138b:	b9 08 00 00 00       	mov    $0x8,%ecx
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  101390:	c7 83 96 80 02 00 08 	movl   $0x8e000008,0x28096(%ebx)
  101397:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  10139a:	be 00 8e ff ff       	mov    $0xffff8e00,%esi
    SETGATE(idt[T_DIVIDE],                  0, CPU_GDT_KCODE, &Xdivide,         0);
  10139f:	66 89 83 8c 80 02 00 	mov    %ax,0x2808c(%ebx)
  1013a6:	c1 e8 10             	shr    $0x10,%eax
  1013a9:	66 89 83 92 80 02 00 	mov    %ax,0x28092(%ebx)
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  1013b0:	c7 c0 ca 21 10 00    	mov    $0x1021ca,%eax
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  1013b6:	c7 83 9e 80 02 00 08 	movl   $0x8e000008,0x2809e(%ebx)
  1013bd:	00 00 8e 
    SETGATE(idt[T_DEBUG],                   0, CPU_GDT_KCODE, &Xdebug,          0);
  1013c0:	66 89 83 94 80 02 00 	mov    %ax,0x28094(%ebx)
  1013c7:	c1 e8 10             	shr    $0x10,%eax
  1013ca:	66 89 83 9a 80 02 00 	mov    %ax,0x2809a(%ebx)
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  1013d1:	c7 c0 d4 21 10 00    	mov    $0x1021d4,%eax
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  1013d7:	c7 83 a6 80 02 00 08 	movl   $0xee000008,0x280a6(%ebx)
  1013de:	00 00 ee 
    SETGATE(idt[T_NMI],                     0, CPU_GDT_KCODE, &Xnmi,            0);
  1013e1:	66 89 83 9c 80 02 00 	mov    %ax,0x2809c(%ebx)
  1013e8:	c1 e8 10             	shr    $0x10,%eax
  1013eb:	66 89 83 a2 80 02 00 	mov    %ax,0x280a2(%ebx)
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  1013f2:	c7 c0 de 21 10 00    	mov    $0x1021de,%eax
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  1013f8:	c7 83 ae 80 02 00 08 	movl   $0xee000008,0x280ae(%ebx)
  1013ff:	00 00 ee 
    SETGATE(idt[T_BRKPT],                   0, CPU_GDT_KCODE, &Xbrkpt,          3);
  101402:	66 89 83 a4 80 02 00 	mov    %ax,0x280a4(%ebx)
  101409:	c1 e8 10             	shr    $0x10,%eax
  10140c:	66 89 83 aa 80 02 00 	mov    %ax,0x280aa(%ebx)
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  101413:	c7 c0 e8 21 10 00    	mov    $0x1021e8,%eax
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  101419:	c7 83 b6 80 02 00 08 	movl   $0x8e000008,0x280b6(%ebx)
  101420:	00 00 8e 
    SETGATE(idt[T_OFLOW],                   0, CPU_GDT_KCODE, &Xoflow,          3);
  101423:	66 89 83 ac 80 02 00 	mov    %ax,0x280ac(%ebx)
  10142a:	c1 e8 10             	shr    $0x10,%eax
  10142d:	66 89 83 b2 80 02 00 	mov    %ax,0x280b2(%ebx)
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  101434:	c7 c0 f2 21 10 00    	mov    $0x1021f2,%eax
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  10143a:	c7 83 be 80 02 00 08 	movl   $0x8e000008,0x280be(%ebx)
  101441:	00 00 8e 
    SETGATE(idt[T_BOUND],                   0, CPU_GDT_KCODE, &Xbound,          0);
  101444:	66 89 83 b4 80 02 00 	mov    %ax,0x280b4(%ebx)
  10144b:	c1 e8 10             	shr    $0x10,%eax
  10144e:	66 89 83 ba 80 02 00 	mov    %ax,0x280ba(%ebx)
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  101455:	c7 c0 fc 21 10 00    	mov    $0x1021fc,%eax
    SETGATE(idt[T_DEVICE],                  0, CPU_GDT_KCODE, &Xdevice,         0);
  10145b:	c7 83 c6 80 02 00 08 	movl   $0x8e000008,0x280c6(%ebx)
  101462:	00 00 8e 
    SETGATE(idt[T_ILLOP],                   0, CPU_GDT_KCODE, &Xillop,          0);
  101465:	66 89 83 bc 80 02 00 	mov    %ax,0x280bc(%ebx)
  10146c:	c1 e8 10             	shr    $0x10,%eax
  10146f:	66 89 83 c2 80 02 00 	mov    %ax,0x280c2(%ebx)
    SETGATE(idt[T_DEVICE],                  0, CPU_GDT_KCODE, &Xdevice,         0);
  101476:	c7 c0 06 22 10 00    	mov    $0x102206,%eax
  10147c:	66 89 83 c4 80 02 00 	mov    %ax,0x280c4(%ebx)
  101483:	c1 e8 10             	shr    $0x10,%eax
  101486:	66 89 83 ca 80 02 00 	mov    %ax,0x280ca(%ebx)
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  10148d:	c7 c0 10 22 10 00    	mov    $0x102210,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101493:	66 89 8b 0e 81 02 00 	mov    %cx,0x2810e(%ebx)
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  10149a:	66 89 83 cc 80 02 00 	mov    %ax,0x280cc(%ebx)
  1014a1:	c1 e8 10             	shr    $0x10,%eax
  1014a4:	66 89 83 d2 80 02 00 	mov    %ax,0x280d2(%ebx)
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1014ab:	c7 c0 22 22 10 00    	mov    $0x102222,%eax
    SETGATE(idt[T_DBLFLT],                  0, CPU_GDT_KCODE, &Xdblflt,         0);
  1014b1:	c7 83 ce 80 02 00 08 	movl   $0x8e000008,0x280ce(%ebx)
  1014b8:	00 00 8e 
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1014bb:	66 89 83 dc 80 02 00 	mov    %ax,0x280dc(%ebx)
  1014c2:	c1 e8 10             	shr    $0x10,%eax
  1014c5:	66 89 83 e2 80 02 00 	mov    %ax,0x280e2(%ebx)
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  1014cc:	c7 c0 2a 22 10 00    	mov    $0x10222a,%eax
    SETGATE(idt[T_TSS],                     0, CPU_GDT_KCODE, &Xtss,            0);
  1014d2:	c7 83 de 80 02 00 08 	movl   $0x8e000008,0x280de(%ebx)
  1014d9:	00 00 8e 
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  1014dc:	66 89 83 e4 80 02 00 	mov    %ax,0x280e4(%ebx)
  1014e3:	c1 e8 10             	shr    $0x10,%eax
  1014e6:	66 89 83 ea 80 02 00 	mov    %ax,0x280ea(%ebx)
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  1014ed:	c7 c0 32 22 10 00    	mov    $0x102232,%eax
    SETGATE(idt[T_SEGNP],                   0, CPU_GDT_KCODE, &Xsegnp,          0);
  1014f3:	c7 83 e6 80 02 00 08 	movl   $0x8e000008,0x280e6(%ebx)
  1014fa:	00 00 8e 
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  1014fd:	66 89 83 ec 80 02 00 	mov    %ax,0x280ec(%ebx)
  101504:	c1 e8 10             	shr    $0x10,%eax
  101507:	66 89 83 f2 80 02 00 	mov    %ax,0x280f2(%ebx)
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10150e:	c7 c0 3a 22 10 00    	mov    $0x10223a,%eax
    SETGATE(idt[T_STACK],                   0, CPU_GDT_KCODE, &Xstack,          0);
  101514:	c7 83 ee 80 02 00 08 	movl   $0x8e000008,0x280ee(%ebx)
  10151b:	00 00 8e 
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  10151e:	66 89 83 f4 80 02 00 	mov    %ax,0x280f4(%ebx)
  101525:	c1 e8 10             	shr    $0x10,%eax
  101528:	66 89 83 fa 80 02 00 	mov    %ax,0x280fa(%ebx)
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  10152f:	c7 c0 42 22 10 00    	mov    $0x102242,%eax
    SETGATE(idt[T_GPFLT],                   0, CPU_GDT_KCODE, &Xgpflt,          0);
  101535:	c7 83 f6 80 02 00 08 	movl   $0x8e000008,0x280f6(%ebx)
  10153c:	00 00 8e 
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  10153f:	66 89 83 fc 80 02 00 	mov    %ax,0x280fc(%ebx)
  101546:	c1 e8 10             	shr    $0x10,%eax
  101549:	66 89 83 02 81 02 00 	mov    %ax,0x28102(%ebx)
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101550:	c7 c0 54 22 10 00    	mov    $0x102254,%eax
    SETGATE(idt[T_PGFLT],                   0, CPU_GDT_KCODE, &Xpgflt,          0);
  101556:	c7 83 fe 80 02 00 08 	movl   $0x8e000008,0x280fe(%ebx)
  10155d:	00 00 8e 
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101560:	66 89 83 0c 81 02 00 	mov    %ax,0x2810c(%ebx)
  101567:	c1 e8 10             	shr    $0x10,%eax
  10156a:	66 89 83 12 81 02 00 	mov    %ax,0x28112(%ebx)
    SETGATE(idt[T_ALIGN],                   0, CPU_GDT_KCODE, &Xalign,          0);
  101571:	c7 c0 5e 22 10 00    	mov    $0x10225e,%eax
    SETGATE(idt[T_FPERR],                   0, CPU_GDT_KCODE, &Xfperr,          0);
  101577:	66 89 b3 10 81 02 00 	mov    %si,0x28110(%ebx)
    SETGATE(idt[T_ALIGN],                   0, CPU_GDT_KCODE, &Xalign,          0);
  10157e:	66 89 83 14 81 02 00 	mov    %ax,0x28114(%ebx)
  101585:	c1 e8 10             	shr    $0x10,%eax
  101588:	c7 83 16 81 02 00 08 	movl   $0x8e000008,0x28116(%ebx)
  10158f:	00 00 8e 
  101592:	66 89 83 1a 81 02 00 	mov    %ax,0x2811a(%ebx)
    SETGATE(idt[T_MCHK],                    0, CPU_GDT_KCODE, &Xmchk,           0);
  101599:	c7 c0 62 22 10 00    	mov    $0x102262,%eax
  10159f:	c7 83 1e 81 02 00 08 	movl   $0x8e000008,0x2811e(%ebx)
  1015a6:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1015a9:	c7 c1 80 22 10 00    	mov    $0x102280,%ecx
    SETGATE(idt[T_MCHK],                    0, CPU_GDT_KCODE, &Xmchk,           0);
  1015af:	66 89 83 1c 81 02 00 	mov    %ax,0x2811c(%ebx)
  1015b6:	c1 e8 10             	shr    $0x10,%eax
  1015b9:	66 89 83 22 81 02 00 	mov    %ax,0x28122(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  1015c0:	c7 c0 68 22 10 00    	mov    $0x102268,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1015c6:	66 89 8b ac 81 02 00 	mov    %cx,0x281ac(%ebx)
  1015cd:	c1 e9 10             	shr    $0x10,%ecx
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  1015d0:	66 89 83 8c 81 02 00 	mov    %ax,0x2818c(%ebx)
  1015d7:	c1 e8 10             	shr    $0x10,%eax
  1015da:	66 89 83 92 81 02 00 	mov    %ax,0x28192(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  1015e1:	c7 c0 6e 22 10 00    	mov    $0x10226e,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  1015e7:	66 89 8b b2 81 02 00 	mov    %cx,0x281b2(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  1015ee:	66 89 83 94 81 02 00 	mov    %ax,0x28194(%ebx)
  1015f5:	c1 e8 10             	shr    $0x10,%eax
  1015f8:	66 89 83 9a 81 02 00 	mov    %ax,0x2819a(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  1015ff:	c7 c0 74 22 10 00    	mov    $0x102274,%eax
    SETGATE(idt[T_IRQ0 + IRQ_TIMER],        0, CPU_GDT_KCODE, &Xirq_timer,      0);
  101605:	c7 83 8e 81 02 00 08 	movl   $0x8e000008,0x2818e(%ebx)
  10160c:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  10160f:	66 89 83 9c 81 02 00 	mov    %ax,0x2819c(%ebx)
  101616:	c1 e8 10             	shr    $0x10,%eax
  101619:	66 89 83 a2 81 02 00 	mov    %ax,0x281a2(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101620:	c7 c0 7a 22 10 00    	mov    $0x10227a,%eax
    SETGATE(idt[T_IRQ0 + IRQ_KBD],          0, CPU_GDT_KCODE, &Xirq_kbd,        0);
  101626:	c7 83 96 81 02 00 08 	movl   $0x8e000008,0x28196(%ebx)
  10162d:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101630:	66 89 83 a4 81 02 00 	mov    %ax,0x281a4(%ebx)
  101637:	c1 e8 10             	shr    $0x10,%eax
  10163a:	66 89 83 aa 81 02 00 	mov    %ax,0x281aa(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  101641:	8b 83 ae 81 02 00    	mov    0x281ae(%ebx),%eax
    SETGATE(idt[T_IRQ0 + IRQ_SLAVE],        0, CPU_GDT_KCODE, &Xirq_slave,      0);
  101647:	c7 83 9e 81 02 00 08 	movl   $0x8e000008,0x2819e(%ebx)
  10164e:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL24],     0, CPU_GDT_KCODE, &Xirq_serial2,    0);
  101651:	c7 83 a6 81 02 00 08 	movl   $0x8e000008,0x281a6(%ebx)
  101658:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  10165b:	25 00 00 e0 ff       	and    $0xffe00000,%eax
    SETGATE(idt[T_IRQ0 + IRQ_LPT2],         0, CPU_GDT_KCODE, &Xirq_lpt,        0);
  101660:	c7 83 b6 81 02 00 08 	movl   $0x8e000008,0x281b6(%ebx)
  101667:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_SERIAL13],     0, CPU_GDT_KCODE, &Xirq_serial1,    0);
  10166a:	83 c8 08             	or     $0x8,%eax
  10166d:	89 83 ae 81 02 00    	mov    %eax,0x281ae(%ebx)
  101673:	0f b7 83 b0 81 02 00 	movzwl 0x281b0(%ebx),%eax
  10167a:	83 e0 1f             	and    $0x1f,%eax
  10167d:	66 0d 00 8e          	or     $0x8e00,%ax
  101681:	66 89 83 b0 81 02 00 	mov    %ax,0x281b0(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_LPT2],         0, CPU_GDT_KCODE, &Xirq_lpt,        0);
  101688:	c7 c0 86 22 10 00    	mov    $0x102286,%eax
  10168e:	66 89 83 b4 81 02 00 	mov    %ax,0x281b4(%ebx)
  101695:	c1 e8 10             	shr    $0x10,%eax
  101698:	66 89 83 ba 81 02 00 	mov    %ax,0x281ba(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  10169f:	c7 c0 8c 22 10 00    	mov    $0x10228c,%eax
  1016a5:	66 89 83 bc 81 02 00 	mov    %ax,0x281bc(%ebx)
  1016ac:	c1 e8 10             	shr    $0x10,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1016af:	c7 c1 aa 22 10 00    	mov    $0x1022aa,%ecx
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1016b5:	66 89 83 c2 81 02 00 	mov    %ax,0x281c2(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  1016bc:	c7 c0 92 22 10 00    	mov    $0x102292,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  1016c2:	66 89 8b e4 81 02 00 	mov    %cx,0x281e4(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  1016c9:	66 89 83 c4 81 02 00 	mov    %ax,0x281c4(%ebx)
  1016d0:	c1 e8 10             	shr    $0x10,%eax
  1016d3:	66 89 83 ca 81 02 00 	mov    %ax,0x281ca(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  1016da:	c7 c0 98 22 10 00    	mov    $0x102298,%eax
    SETGATE(idt[T_IRQ0 + IRQ_FLOPPY],       0, CPU_GDT_KCODE, &Xirq_floppy,     0);
  1016e0:	c7 83 be 81 02 00 08 	movl   $0x8e000008,0x281be(%ebx)
  1016e7:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  1016ea:	66 89 83 cc 81 02 00 	mov    %ax,0x281cc(%ebx)
  1016f1:	c1 e8 10             	shr    $0x10,%eax
  1016f4:	66 89 83 d2 81 02 00 	mov    %ax,0x281d2(%ebx)
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  1016fb:	c7 c0 9e 22 10 00    	mov    $0x10229e,%eax
    SETGATE(idt[T_IRQ0 + IRQ_SPURIOUS],     0, CPU_GDT_KCODE, &Xirq_spurious,   0);
  101701:	c7 83 c6 81 02 00 08 	movl   $0x8e000008,0x281c6(%ebx)
  101708:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  10170b:	66 89 83 d4 81 02 00 	mov    %ax,0x281d4(%ebx)
  101712:	c1 e8 10             	shr    $0x10,%eax
  101715:	66 89 83 da 81 02 00 	mov    %ax,0x281da(%ebx)
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10171c:	c7 c0 a4 22 10 00    	mov    $0x1022a4,%eax
    SETGATE(idt[T_IRQ0 + IRQ_RTC],          0, CPU_GDT_KCODE, &Xirq_rtc,        0);
  101722:	c7 83 ce 81 02 00 08 	movl   $0x8e000008,0x281ce(%ebx)
  101729:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10172c:	66 89 83 dc 81 02 00 	mov    %ax,0x281dc(%ebx)
  101733:	c1 e8 10             	shr    $0x10,%eax
  101736:	66 89 83 e2 81 02 00 	mov    %ax,0x281e2(%ebx)
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  10173d:	8b 83 e6 81 02 00    	mov    0x281e6(%ebx),%eax
    SETGATE(idt[T_IRQ0 + 9],                0, CPU_GDT_KCODE, &Xirq9,           0);
  101743:	c7 83 d6 81 02 00 08 	movl   $0x8e000008,0x281d6(%ebx)
  10174a:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 10],               0, CPU_GDT_KCODE, &Xirq10,          0);
  10174d:	c7 83 de 81 02 00 08 	movl   $0x8e000008,0x281de(%ebx)
  101754:	00 00 8e 
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  101757:	25 00 00 00 ff       	and    $0xff000000,%eax
  10175c:	c1 e9 10             	shr    $0x10,%ecx
  10175f:	83 c8 08             	or     $0x8,%eax
  101762:	66 89 8b ea 81 02 00 	mov    %cx,0x281ea(%ebx)
  101769:	89 83 e6 81 02 00    	mov    %eax,0x281e6(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  10176f:	c7 c0 b0 22 10 00    	mov    $0x1022b0,%eax
    SETGATE(idt[T_IRQ0 + 11],               0, CPU_GDT_KCODE, &Xirq11,          0);
  101775:	c6 83 e9 81 02 00 8e 	movb   $0x8e,0x281e9(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  10177c:	66 89 83 ec 81 02 00 	mov    %ax,0x281ec(%ebx)
  101783:	c1 e8 10             	shr    $0x10,%eax
  101786:	66 89 83 f2 81 02 00 	mov    %ax,0x281f2(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_COPROCESSOR],  0, CPU_GDT_KCODE, &Xirq_coproc,     0);
  10178d:	c7 c0 b6 22 10 00    	mov    $0x1022b6,%eax
    SETGATE(idt[T_IRQ0 + IRQ_MOUSE],        0, CPU_GDT_KCODE, &Xirq_mouse,      0);
  101793:	c7 83 ee 81 02 00 08 	movl   $0x8e000008,0x281ee(%ebx)
  10179a:	00 00 8e 
    SETGATE(idt[T_IRQ0 + IRQ_COPROCESSOR],  0, CPU_GDT_KCODE, &Xirq_coproc,     0);
  10179d:	66 89 83 f4 81 02 00 	mov    %ax,0x281f4(%ebx)
  1017a4:	c1 e8 10             	shr    $0x10,%eax
  1017a7:	c7 83 f6 81 02 00 08 	movl   $0x8e000008,0x281f6(%ebx)
  1017ae:	00 00 8e 
  1017b1:	66 89 83 fa 81 02 00 	mov    %ax,0x281fa(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_IDE1],         0, CPU_GDT_KCODE, &Xirq_ide1,       0);
  1017b8:	c7 c0 bc 22 10 00    	mov    $0x1022bc,%eax
  1017be:	c7 83 fe 81 02 00 08 	movl   $0x8e000008,0x281fe(%ebx)
  1017c5:	00 00 8e 
  1017c8:	66 89 83 fc 81 02 00 	mov    %ax,0x281fc(%ebx)
  1017cf:	c1 e8 10             	shr    $0x10,%eax
  1017d2:	66 89 83 02 82 02 00 	mov    %ax,0x28202(%ebx)
    SETGATE(idt[T_IRQ0 + IRQ_IDE2],         0, CPU_GDT_KCODE, &Xirq_ide2,       0);
  1017d9:	c7 c0 c2 22 10 00    	mov    $0x1022c2,%eax
  1017df:	c7 83 06 82 02 00 08 	movl   $0x8e000008,0x28206(%ebx)
  1017e6:	00 00 8e 
  1017e9:	66 89 83 04 82 02 00 	mov    %ax,0x28204(%ebx)
  1017f0:	c1 e8 10             	shr    $0x10,%eax
  1017f3:	66 89 83 0a 82 02 00 	mov    %ax,0x2820a(%ebx)
    SETGATE(idt[T_SYSCALL], 0, CPU_GDT_KCODE, &Xsyscall, 3);
  1017fa:	c7 c0 c8 22 10 00    	mov    $0x1022c8,%eax
  101800:	c7 83 0e 82 02 00 08 	movl   $0xee000008,0x2820e(%ebx)
  101807:	00 00 ee 
  10180a:	66 89 83 0c 82 02 00 	mov    %ax,0x2820c(%ebx)
  101811:	c1 e8 10             	shr    $0x10,%eax
  101814:	66 89 83 12 82 02 00 	mov    %ax,0x28212(%ebx)
    SETGATE(idt[T_DEFAULT], 0, CPU_GDT_KCODE, &Xdefault, 0);
  10181b:	0f b7 44 24 08       	movzwl 0x8(%esp),%eax
  101820:	c7 83 7e 88 02 00 08 	movl   $0x8e000008,0x2887e(%ebx)
  101827:	00 00 8e 
  10182a:	66 89 83 7c 88 02 00 	mov    %ax,0x2887c(%ebx)
    if (using_apic)
  101831:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
    SETGATE(idt[T_DEFAULT], 0, CPU_GDT_KCODE, &Xdefault, 0);
  101838:	66 89 93 82 88 02 00 	mov    %dx,0x28882(%ebx)
    if (using_apic)
  10183f:	84 c0                	test   %al,%al
  101841:	0f 84 b3 fa ff ff    	je     1012fa <intr_init+0x7a>
  101847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10184e:	00 
  10184f:	90                   	nop
        lapic_init();
  101850:	e8 fb 0d 00 00       	call   102650 <lapic_init>
  101855:	e9 a0 fa ff ff       	jmp    1012fa <intr_init+0x7a>
  10185a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101860 <intr_enable>:

void intr_enable(uint8_t irq, int cpunum)
{
  101860:	57                   	push   %edi
  101861:	56                   	push   %esi
  101862:	53                   	push   %ebx
  101863:	8b 7c 24 14          	mov    0x14(%esp),%edi
  101867:	e8 36 eb ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10186c:	81 c3 88 f7 00 00    	add    $0xf788,%ebx
  101872:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(cpunum == 0xff || (0 <= cpunum && cpunum < pcpu_ncpu()));
  101876:	81 ff ff 00 00 00    	cmp    $0xff,%edi
  10187c:	74 62                	je     1018e0 <intr_enable+0x80>
  10187e:	85 ff                	test   %edi,%edi
  101880:	78 0d                	js     10188f <intr_enable+0x2f>
  101882:	e8 b9 22 00 00       	call   103b40 <pcpu_ncpu>
  101887:	39 c7                	cmp    %eax,%edi
  101889:	0f 82 81 00 00 00    	jb     101910 <intr_enable+0xb0>
  10188f:	8d 83 58 8a ff ff    	lea    -0x75a8(%ebx),%eax
  101895:	50                   	push   %eax
  101896:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  10189c:	50                   	push   %eax
  10189d:	8d 83 80 81 ff ff    	lea    -0x7e80(%ebx),%eax
  1018a3:	6a 7a                	push   $0x7a
  1018a5:	50                   	push   %eax
  1018a6:	e8 b5 28 00 00       	call   104160 <debug_panic>

    if (irq >= 24)
  1018ab:	89 f0                	mov    %esi,%eax
  1018ad:	83 c4 10             	add    $0x10,%esp
  1018b0:	3c 17                	cmp    $0x17,%al
  1018b2:	77 22                	ja     1018d6 <intr_enable+0x76>
        return;

    if (using_apic == TRUE) {
  1018b4:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  1018bb:	3c 01                	cmp    $0x1,%al
  1018bd:	74 62                	je     101921 <intr_enable+0xc1>
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
    } else {
        KERN_ASSERT(irq < 16);
  1018bf:	89 f0                	mov    %esi,%eax
  1018c1:	3c 0f                	cmp    $0xf,%al
  1018c3:	77 73                	ja     101938 <intr_enable+0xd8>
        pic_enable(irq);
  1018c5:	89 f0                	mov    %esi,%eax
  1018c7:	83 ec 0c             	sub    $0xc,%esp
  1018ca:	0f b6 f0             	movzbl %al,%esi
  1018cd:	56                   	push   %esi
  1018ce:	e8 dd 02 00 00       	call   101bb0 <pic_enable>
  1018d3:	83 c4 10             	add    $0x10,%esp
    }
}
  1018d6:	5b                   	pop    %ebx
  1018d7:	5e                   	pop    %esi
  1018d8:	5f                   	pop    %edi
  1018d9:	c3                   	ret
  1018da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (irq >= 24)
  1018e0:	89 f0                	mov    %esi,%eax
  1018e2:	3c 17                	cmp    $0x17,%al
  1018e4:	77 f0                	ja     1018d6 <intr_enable+0x76>
    if (using_apic == TRUE) {
  1018e6:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  1018ed:	3c 01                	cmp    $0x1,%al
  1018ef:	75 ce                	jne    1018bf <intr_enable+0x5f>
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  1018f1:	89 f0                	mov    %esi,%eax
  1018f3:	6a 00                	push   $0x0
  1018f5:	0f b6 f0             	movzbl %al,%esi
  1018f8:	6a 00                	push   $0x0
  1018fa:	57                   	push   %edi
  1018fb:	56                   	push   %esi
  1018fc:	e8 ff 13 00 00       	call   102d00 <ioapic_enable>
  101901:	83 c4 10             	add    $0x10,%esp
}
  101904:	5b                   	pop    %ebx
  101905:	5e                   	pop    %esi
  101906:	5f                   	pop    %edi
  101907:	c3                   	ret
  101908:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10190f:	00 
    if (irq >= 24)
  101910:	89 f0                	mov    %esi,%eax
  101912:	3c 17                	cmp    $0x17,%al
  101914:	77 c0                	ja     1018d6 <intr_enable+0x76>
    if (using_apic == TRUE) {
  101916:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  10191d:	3c 01                	cmp    $0x1,%al
  10191f:	75 9e                	jne    1018bf <intr_enable+0x5f>
        ioapic_enable(irq, (cpunum == 0xff) ?  0xff : pcpu_cpu_lapicid(cpunum), 0, 0);
  101921:	83 ec 0c             	sub    $0xc,%esp
  101924:	57                   	push   %edi
  101925:	e8 a6 22 00 00       	call   103bd0 <pcpu_cpu_lapicid>
  10192a:	83 c4 10             	add    $0x10,%esp
  10192d:	0f b6 f8             	movzbl %al,%edi
  101930:	eb bf                	jmp    1018f1 <intr_enable+0x91>
  101932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_ASSERT(irq < 16);
  101938:	8d 83 90 81 ff ff    	lea    -0x7e70(%ebx),%eax
  10193e:	50                   	push   %eax
  10193f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  101945:	50                   	push   %eax
  101946:	8d 83 80 81 ff ff    	lea    -0x7e80(%ebx),%eax
  10194c:	68 82 00 00 00       	push   $0x82
  101951:	50                   	push   %eax
  101952:	e8 09 28 00 00       	call   104160 <debug_panic>
  101957:	83 c4 10             	add    $0x10,%esp
  10195a:	e9 66 ff ff ff       	jmp    1018c5 <intr_enable+0x65>
  10195f:	90                   	nop

00101960 <intr_enable_lapicid>:

void intr_enable_lapicid(uint8_t irq, int lapic_id)
{
  101960:	56                   	push   %esi
  101961:	53                   	push   %ebx
  101962:	e8 3b ea ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101967:	81 c3 8d f6 00 00    	add    $0xf68d,%ebx
  10196d:	83 ec 04             	sub    $0x4,%esp
  101970:	8b 44 24 10          	mov    0x10(%esp),%eax
    if (irq > 24)
  101974:	3c 18                	cmp    $0x18,%al
  101976:	77 1f                	ja     101997 <intr_enable_lapicid+0x37>
        return;

    if (using_apic == TRUE) {
  101978:	0f b6 93 8c 88 02 00 	movzbl 0x2888c(%ebx),%edx
        ioapic_enable(irq, (lapic_id == 0xff) ?  0xff : lapic_id, 0, 0);
  10197f:	0f b6 f0             	movzbl %al,%esi
    if (using_apic == TRUE) {
  101982:	80 fa 01             	cmp    $0x1,%dl
  101985:	74 41                	je     1019c8 <intr_enable_lapicid+0x68>
    } else {
        KERN_ASSERT(irq < 16);
  101987:	3c 0f                	cmp    $0xf,%al
  101989:	77 15                	ja     1019a0 <intr_enable_lapicid+0x40>
        pic_enable(irq);
  10198b:	83 ec 0c             	sub    $0xc,%esp
  10198e:	56                   	push   %esi
  10198f:	e8 1c 02 00 00       	call   101bb0 <pic_enable>
  101994:	83 c4 10             	add    $0x10,%esp
    }
}
  101997:	83 c4 04             	add    $0x4,%esp
  10199a:	5b                   	pop    %ebx
  10199b:	5e                   	pop    %esi
  10199c:	c3                   	ret
  10199d:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_ASSERT(irq < 16);
  1019a0:	8d 83 90 81 ff ff    	lea    -0x7e70(%ebx),%eax
  1019a6:	50                   	push   %eax
  1019a7:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1019ad:	50                   	push   %eax
  1019ae:	8d 83 80 81 ff ff    	lea    -0x7e80(%ebx),%eax
  1019b4:	68 8f 00 00 00       	push   $0x8f
  1019b9:	50                   	push   %eax
  1019ba:	e8 a1 27 00 00       	call   104160 <debug_panic>
  1019bf:	83 c4 10             	add    $0x10,%esp
  1019c2:	eb c7                	jmp    10198b <intr_enable_lapicid+0x2b>
  1019c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ioapic_enable(irq, (lapic_id == 0xff) ?  0xff : lapic_id, 0, 0);
  1019c8:	6a 00                	push   $0x0
  1019ca:	6a 00                	push   $0x0
  1019cc:	0f b6 44 24 1c       	movzbl 0x1c(%esp),%eax
  1019d1:	50                   	push   %eax
  1019d2:	56                   	push   %esi
  1019d3:	e8 28 13 00 00       	call   102d00 <ioapic_enable>
  1019d8:	83 c4 10             	add    $0x10,%esp
}
  1019db:	83 c4 04             	add    $0x4,%esp
  1019de:	5b                   	pop    %ebx
  1019df:	5e                   	pop    %esi
  1019e0:	c3                   	ret
  1019e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1019e8:	00 
  1019e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001019f0 <intr_eoi>:

void intr_eoi(void)
{
  1019f0:	53                   	push   %ebx
  1019f1:	e8 ac e9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1019f6:	81 c3 fe f5 00 00    	add    $0xf5fe,%ebx
  1019fc:	83 ec 08             	sub    $0x8,%esp
    if (using_apic == TRUE)
  1019ff:	0f b6 83 8c 88 02 00 	movzbl 0x2888c(%ebx),%eax
  101a06:	3c 01                	cmp    $0x1,%al
  101a08:	74 0e                	je     101a18 <intr_eoi+0x28>
        lapic_eoi();
    else
        pic_eoi();
  101a0a:	e8 f1 01 00 00       	call   101c00 <pic_eoi>
}
  101a0f:	83 c4 08             	add    $0x8,%esp
  101a12:	5b                   	pop    %ebx
  101a13:	c3                   	ret
  101a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        lapic_eoi();
  101a18:	e8 23 0f 00 00       	call   102940 <lapic_eoi>
}
  101a1d:	83 c4 08             	add    $0x8,%esp
  101a20:	5b                   	pop    %ebx
  101a21:	c3                   	ret
  101a22:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  101a29:	00 
  101a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101a30 <intr_local_enable>:

void intr_local_enable(void)
{
  101a30:	53                   	push   %ebx
  101a31:	e8 6c e9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101a36:	81 c3 be f5 00 00    	add    $0xf5be,%ebx
  101a3c:	83 ec 08             	sub    $0x8,%esp
    sti();
  101a3f:	e8 2c 33 00 00       	call   104d70 <sti>
}
  101a44:	83 c4 08             	add    $0x8,%esp
  101a47:	5b                   	pop    %ebx
  101a48:	c3                   	ret
  101a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101a50 <intr_local_disable>:

void intr_local_disable(void)
{
  101a50:	53                   	push   %ebx
  101a51:	e8 4c e9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101a56:	81 c3 9e f5 00 00    	add    $0xf59e,%ebx
  101a5c:	83 ec 08             	sub    $0x8,%esp
    cli();
  101a5f:	e8 fc 32 00 00       	call   104d60 <cli>
}
  101a64:	83 c4 08             	add    $0x8,%esp
  101a67:	5b                   	pop    %ebx
  101a68:	c3                   	ret
  101a69:	66 90                	xchg   %ax,%ax
  101a6b:	66 90                	xchg   %ax,%ax
  101a6d:	66 90                	xchg   %ax,%ax
  101a6f:	90                   	nop

00101a70 <pic_init>:
static uint16_t irqmask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool pic_inited = FALSE;

/* Initialize the 8259A interrupt controllers. */
void pic_init(void)
{
  101a70:	53                   	push   %ebx
  101a71:	e8 2c e9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101a76:	81 c3 7e f5 00 00    	add    $0xf57e,%ebx
  101a7c:	83 ec 08             	sub    $0x8,%esp
    if (pic_inited == TRUE)  // only do once on bootstrap CPU
  101a7f:	80 bb 8d 88 02 00 01 	cmpb   $0x1,0x2888d(%ebx)
  101a86:	0f 84 df 00 00 00    	je     101b6b <pic_init+0xfb>
        return;
    pic_inited = TRUE;

    /* mask all interrupts */
    outb(IO_PIC1 + 1, 0xff);
  101a8c:	83 ec 08             	sub    $0x8,%esp
    pic_inited = TRUE;
  101a8f:	c6 83 8d 88 02 00 01 	movb   $0x1,0x2888d(%ebx)
    outb(IO_PIC1 + 1, 0xff);
  101a96:	68 ff 00 00 00       	push   $0xff
  101a9b:	6a 21                	push   $0x21
  101a9d:	e8 de 34 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, 0xff);
  101aa2:	58                   	pop    %eax
  101aa3:	5a                   	pop    %edx
  101aa4:	68 ff 00 00 00       	push   $0xff
  101aa9:	68 a1 00 00 00       	push   $0xa1
  101aae:	e8 cd 34 00 00       	call   104f80 <outb>

    // ICW1:  0001g0hi
    //    g:  0 = edge triggering, 1 = level triggering
    //    h:  0 = cascaded PICs, 1 = master only
    //    i:  0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  101ab3:	59                   	pop    %ecx
  101ab4:	58                   	pop    %eax
  101ab5:	6a 11                	push   $0x11
  101ab7:	6a 20                	push   $0x20
  101ab9:	e8 c2 34 00 00       	call   104f80 <outb>

    // ICW2:  Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  101abe:	58                   	pop    %eax
  101abf:	5a                   	pop    %edx
  101ac0:	6a 20                	push   $0x20
  101ac2:	6a 21                	push   $0x21
  101ac4:	e8 b7 34 00 00       	call   104f80 <outb>

    // ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
    //        3-bit No of IR line at which slave connects to master (slave PIC).
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  101ac9:	59                   	pop    %ecx
  101aca:	58                   	pop    %eax
  101acb:	6a 04                	push   $0x4
  101acd:	6a 21                	push   $0x21
  101acf:	e8 ac 34 00 00       	call   104f80 <outb>
    //    m:  0 = slave PIC, 1 = master PIC
    //        (ignored when b is 0, as the master/slave role
    //        can be hardwired).
    //    a:  1 = Automatic EOI mode
    //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x1);
  101ad4:	58                   	pop    %eax
  101ad5:	5a                   	pop    %edx
  101ad6:	6a 01                	push   $0x1
  101ad8:	6a 21                	push   $0x21
  101ada:	e8 a1 34 00 00       	call   104f80 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  101adf:	59                   	pop    %ecx
  101ae0:	58                   	pop    %eax
  101ae1:	6a 11                	push   $0x11
  101ae3:	68 a0 00 00 00       	push   $0xa0
  101ae8:	e8 93 34 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  101aed:	58                   	pop    %eax
  101aee:	5a                   	pop    %edx
  101aef:	6a 28                	push   $0x28
  101af1:	68 a1 00 00 00       	push   $0xa1
  101af6:	e8 85 34 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  101afb:	59                   	pop    %ecx
  101afc:	58                   	pop    %eax
  101afd:	6a 02                	push   $0x2
  101aff:	68 a1 00 00 00       	push   $0xa1
  101b04:	e8 77 34 00 00       	call   104f80 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x01);        // ICW4
  101b09:	58                   	pop    %eax
  101b0a:	5a                   	pop    %edx
  101b0b:	6a 01                	push   $0x1
  101b0d:	68 a1 00 00 00       	push   $0xa1
  101b12:	e8 69 34 00 00       	call   104f80 <outb>

    // OCW3:  0ef01prs
    //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p:  0 = no polling, 1 = polling mode
    //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  /* clear specific mask */
  101b17:	59                   	pop    %ecx
  101b18:	58                   	pop    %eax
  101b19:	6a 68                	push   $0x68
  101b1b:	6a 20                	push   $0x20
  101b1d:	e8 5e 34 00 00       	call   104f80 <outb>
    outb(IO_PIC1, 0x0a);  /* read IRR by default */
  101b22:	58                   	pop    %eax
  101b23:	5a                   	pop    %edx
  101b24:	6a 0a                	push   $0xa
  101b26:	6a 20                	push   $0x20
  101b28:	e8 53 34 00 00       	call   104f80 <outb>

    outb(IO_PIC2, 0x68);  /* OCW3 */
  101b2d:	59                   	pop    %ecx
  101b2e:	58                   	pop    %eax
  101b2f:	6a 68                	push   $0x68
  101b31:	68 a0 00 00 00       	push   $0xa0
  101b36:	e8 45 34 00 00       	call   104f80 <outb>
    outb(IO_PIC2, 0x0a);  /* OCW3 */
  101b3b:	58                   	pop    %eax
  101b3c:	5a                   	pop    %edx
  101b3d:	6a 0a                	push   $0xa
  101b3f:	68 a0 00 00 00       	push   $0xa0
  101b44:	e8 37 34 00 00       	call   104f80 <outb>

    // mask all interrupts
    outb(IO_PIC1 + 1, 0xFF);
  101b49:	59                   	pop    %ecx
  101b4a:	58                   	pop    %eax
  101b4b:	68 ff 00 00 00       	push   $0xff
  101b50:	6a 21                	push   $0x21
  101b52:	e8 29 34 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, 0xFF);
  101b57:	58                   	pop    %eax
  101b58:	5a                   	pop    %edx
  101b59:	68 ff 00 00 00       	push   $0xff
  101b5e:	68 a1 00 00 00       	push   $0xa1
  101b63:	e8 18 34 00 00       	call   104f80 <outb>
  101b68:	83 c4 10             	add    $0x10,%esp
}
  101b6b:	83 c4 08             	add    $0x8,%esp
  101b6e:	5b                   	pop    %ebx
  101b6f:	c3                   	ret

00101b70 <pic_setmask>:

void pic_setmask(uint16_t mask)
{
  101b70:	56                   	push   %esi
  101b71:	53                   	push   %ebx
  101b72:	e8 2b e8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101b77:	81 c3 7d f4 00 00    	add    $0xf47d,%ebx
  101b7d:	83 ec 0c             	sub    $0xc,%esp
  101b80:	8b 74 24 18          	mov    0x18(%esp),%esi
    irqmask = mask;
    outb(IO_PIC1 + 1, (char) mask);
  101b84:	89 f0                	mov    %esi,%eax
  101b86:	0f b6 c0             	movzbl %al,%eax
    irqmask = mask;
  101b89:	66 89 b3 12 03 00 00 	mov    %si,0x312(%ebx)
    outb(IO_PIC1 + 1, (char) mask);
  101b90:	50                   	push   %eax
  101b91:	6a 21                	push   $0x21
  101b93:	e8 e8 33 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101b98:	58                   	pop    %eax
  101b99:	89 f0                	mov    %esi,%eax
  101b9b:	5a                   	pop    %edx
  101b9c:	0f b6 f4             	movzbl %ah,%esi
  101b9f:	56                   	push   %esi
  101ba0:	68 a1 00 00 00       	push   $0xa1
  101ba5:	e8 d6 33 00 00       	call   104f80 <outb>
}
  101baa:	83 c4 14             	add    $0x14,%esp
  101bad:	5b                   	pop    %ebx
  101bae:	5e                   	pop    %esi
  101baf:	c3                   	ret

00101bb0 <pic_enable>:

void pic_enable(int irq)
{
  101bb0:	56                   	push   %esi
  101bb1:	53                   	push   %ebx
  101bb2:	e8 eb e7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101bb7:	81 c3 3d f4 00 00    	add    $0xf43d,%ebx
  101bbd:	83 ec 0c             	sub    $0xc,%esp
    pic_setmask(irqmask & ~(1 << irq));
  101bc0:	8b 44 24 18          	mov    0x18(%esp),%eax
  101bc4:	0f b7 b3 12 03 00 00 	movzwl 0x312(%ebx),%esi
  101bcb:	0f b3 c6             	btr    %eax,%esi
    outb(IO_PIC1 + 1, (char) mask);
  101bce:	89 f0                	mov    %esi,%eax
    irqmask = mask;
  101bd0:	66 89 b3 12 03 00 00 	mov    %si,0x312(%ebx)
    outb(IO_PIC1 + 1, (char) mask);
  101bd7:	0f b6 c0             	movzbl %al,%eax
  101bda:	50                   	push   %eax
  101bdb:	6a 21                	push   $0x21
  101bdd:	e8 9e 33 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, (char) (mask >> 8));
  101be2:	58                   	pop    %eax
  101be3:	89 f0                	mov    %esi,%eax
  101be5:	5a                   	pop    %edx
  101be6:	0f b6 f4             	movzbl %ah,%esi
  101be9:	56                   	push   %esi
  101bea:	68 a1 00 00 00       	push   $0xa1
  101bef:	e8 8c 33 00 00       	call   104f80 <outb>
}
  101bf4:	83 c4 14             	add    $0x14,%esp
  101bf7:	5b                   	pop    %ebx
  101bf8:	5e                   	pop    %esi
  101bf9:	c3                   	ret
  101bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00101c00 <pic_eoi>:

void pic_eoi(void)
{
  101c00:	53                   	push   %ebx
  101c01:	e8 9c e7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101c06:	81 c3 ee f3 00 00    	add    $0xf3ee,%ebx
  101c0c:	83 ec 10             	sub    $0x10,%esp
    // OCW2: rse00xxx
    //   r: rotate
    //   s: specific
    //   e: end-of-interrupt
    // xxx: specific interrupt line
    outb(IO_PIC1, 0x20);
  101c0f:	6a 20                	push   $0x20
  101c11:	6a 20                	push   $0x20
  101c13:	e8 68 33 00 00       	call   104f80 <outb>
    outb(IO_PIC2, 0x20);
  101c18:	58                   	pop    %eax
  101c19:	5a                   	pop    %edx
  101c1a:	6a 20                	push   $0x20
  101c1c:	68 a0 00 00 00       	push   $0xa0
  101c21:	e8 5a 33 00 00       	call   104f80 <outb>
}
  101c26:	83 c4 18             	add    $0x18,%esp
  101c29:	5b                   	pop    %ebx
  101c2a:	c3                   	ret
  101c2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00101c30 <pic_reset>:

void pic_reset(void)
{
  101c30:	53                   	push   %ebx
  101c31:	e8 6c e7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101c36:	81 c3 be f3 00 00    	add    $0xf3be,%ebx
  101c3c:	83 ec 10             	sub    $0x10,%esp
    // mask all interrupts
    outb(IO_PIC1 + 1, 0x00);
  101c3f:	6a 00                	push   $0x0
  101c41:	6a 21                	push   $0x21
  101c43:	e8 38 33 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, 0x00);
  101c48:	58                   	pop    %eax
  101c49:	5a                   	pop    %edx
  101c4a:	6a 00                	push   $0x0
  101c4c:	68 a1 00 00 00       	push   $0xa1
  101c51:	e8 2a 33 00 00       	call   104f80 <outb>

    // ICW1:  0001g0hi
    //    g:  0 = edge triggering, 1 = level triggering
    //    h:  0 = cascaded PICs, 1 = master only
    //    i:  0 = no ICW4, 1 = ICW4 required
    outb(IO_PIC1, 0x11);
  101c56:	59                   	pop    %ecx
  101c57:	58                   	pop    %eax
  101c58:	6a 11                	push   $0x11
  101c5a:	6a 20                	push   $0x20
  101c5c:	e8 1f 33 00 00       	call   104f80 <outb>

    // ICW2:  Vector offset
    outb(IO_PIC1 + 1, T_IRQ0);
  101c61:	58                   	pop    %eax
  101c62:	5a                   	pop    %edx
  101c63:	6a 20                	push   $0x20
  101c65:	6a 21                	push   $0x21
  101c67:	e8 14 33 00 00       	call   104f80 <outb>

    // ICW3:  bit mask of IR lines connected to slave PICs (master PIC),
    //        3-bit No of IR line at which slave connects to master(slave PIC).
    outb(IO_PIC1 + 1, 1 << IRQ_SLAVE);
  101c6c:	59                   	pop    %ecx
  101c6d:	58                   	pop    %eax
  101c6e:	6a 04                	push   $0x4
  101c70:	6a 21                	push   $0x21
  101c72:	e8 09 33 00 00       	call   104f80 <outb>
    //    m:  0 = slave PIC, 1 = master PIC
    //        (ignored when b is 0, as the master/slave role
    //        can be hardwired).
    //    a:  1 = Automatic EOI mode
    //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
    outb(IO_PIC1 + 1, 0x3);
  101c77:	58                   	pop    %eax
  101c78:	5a                   	pop    %edx
  101c79:	6a 03                	push   $0x3
  101c7b:	6a 21                	push   $0x21
  101c7d:	e8 fe 32 00 00       	call   104f80 <outb>

    // Set up slave (8259A-2)
    outb(IO_PIC2, 0x11);            // ICW1
  101c82:	59                   	pop    %ecx
  101c83:	58                   	pop    %eax
  101c84:	6a 11                	push   $0x11
  101c86:	68 a0 00 00 00       	push   $0xa0
  101c8b:	e8 f0 32 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, T_IRQ0 + 8);  // ICW2
  101c90:	58                   	pop    %eax
  101c91:	5a                   	pop    %edx
  101c92:	6a 28                	push   $0x28
  101c94:	68 a1 00 00 00       	push   $0xa1
  101c99:	e8 e2 32 00 00       	call   104f80 <outb>
    outb(IO_PIC2 + 1, IRQ_SLAVE);   // ICW3
  101c9e:	59                   	pop    %ecx
  101c9f:	58                   	pop    %eax
  101ca0:	6a 02                	push   $0x2
  101ca2:	68 a1 00 00 00       	push   $0xa1
  101ca7:	e8 d4 32 00 00       	call   104f80 <outb>
    // NB Automatic EOI mode doesn't tend to work on the slave.
    // Linux source code says it's "to be investigated".
    outb(IO_PIC2 + 1, 0x01);        // ICW4
  101cac:	58                   	pop    %eax
  101cad:	5a                   	pop    %edx
  101cae:	6a 01                	push   $0x1
  101cb0:	68 a1 00 00 00       	push   $0xa1
  101cb5:	e8 c6 32 00 00       	call   104f80 <outb>

    // OCW3:  0ef01prs
    //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
    //    p:  0 = no polling, 1 = polling mode
    //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
    outb(IO_PIC1, 0x68);  /* clear specific mask */
  101cba:	59                   	pop    %ecx
  101cbb:	58                   	pop    %eax
  101cbc:	6a 68                	push   $0x68
  101cbe:	6a 20                	push   $0x20
  101cc0:	e8 bb 32 00 00       	call   104f80 <outb>
    outb(IO_PIC1, 0x0a);  /* read IRR by default */
  101cc5:	58                   	pop    %eax
  101cc6:	5a                   	pop    %edx
  101cc7:	6a 0a                	push   $0xa
  101cc9:	6a 20                	push   $0x20
  101ccb:	e8 b0 32 00 00       	call   104f80 <outb>

    outb(IO_PIC2, 0x68);  /* OCW3 */
  101cd0:	59                   	pop    %ecx
  101cd1:	58                   	pop    %eax
  101cd2:	6a 68                	push   $0x68
  101cd4:	68 a0 00 00 00       	push   $0xa0
  101cd9:	e8 a2 32 00 00       	call   104f80 <outb>
    outb(IO_PIC2, 0x0a);  /* OCW3 */
  101cde:	58                   	pop    %eax
  101cdf:	5a                   	pop    %edx
  101ce0:	6a 0a                	push   $0xa
  101ce2:	68 a0 00 00 00       	push   $0xa0
  101ce7:	e8 94 32 00 00       	call   104f80 <outb>
}
  101cec:	83 c4 18             	add    $0x18,%esp
  101cef:	5b                   	pop    %ebx
  101cf0:	c3                   	ret
  101cf1:	66 90                	xchg   %ax,%ax
  101cf3:	66 90                	xchg   %ax,%ax
  101cf5:	66 90                	xchg   %ax,%ax
  101cf7:	66 90                	xchg   %ax,%ax
  101cf9:	66 90                	xchg   %ax,%ax
  101cfb:	66 90                	xchg   %ax,%ax
  101cfd:	66 90                	xchg   %ax,%ax
  101cff:	90                   	nop

00101d00 <timer_hw_init>:
#define TIMER_16BIT   0x30  /* r/w counter 16 bits, LSB first */

// Initialize the programmable interval timer.

void timer_hw_init(void)
{
  101d00:	53                   	push   %ebx
  101d01:	e8 9c e6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101d06:	81 c3 ee f2 00 00    	add    $0xf2ee,%ebx
  101d0c:	83 ec 10             	sub    $0x10,%esp
    outb(PIT_CONTROL, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  101d0f:	6a 34                	push   $0x34
  101d11:	6a 43                	push   $0x43
  101d13:	e8 68 32 00 00       	call   104f80 <outb>
    outb(PIT_CHANNEL0, LOW8(LATCH));
  101d18:	58                   	pop    %eax
  101d19:	5a                   	pop    %edx
  101d1a:	68 9c 00 00 00       	push   $0x9c
  101d1f:	6a 40                	push   $0x40
  101d21:	e8 5a 32 00 00       	call   104f80 <outb>
    outb(PIT_CHANNEL0, HIGH8(LATCH));
  101d26:	59                   	pop    %ecx
  101d27:	58                   	pop    %eax
  101d28:	6a 2e                	push   $0x2e
  101d2a:	6a 40                	push   $0x40
  101d2c:	e8 4f 32 00 00       	call   104f80 <outb>
}
  101d31:	83 c4 18             	add    $0x18,%esp
  101d34:	5b                   	pop    %ebx
  101d35:	c3                   	ret
  101d36:	66 90                	xchg   %ax,%ax
  101d38:	66 90                	xchg   %ax,%ax
  101d3a:	66 90                	xchg   %ax,%ax
  101d3c:	66 90                	xchg   %ax,%ax
  101d3e:	66 90                	xchg   %ax,%ax

00101d40 <tsc_init>:
    delta = t2 - t1;
    return delta / ms;
}

int tsc_init(void)
{
  101d40:	55                   	push   %ebp
  101d41:	57                   	push   %edi
  101d42:	56                   	push   %esi
  101d43:	53                   	push   %ebx
  101d44:	e8 59 e6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  101d49:	81 c3 ab f2 00 00    	add    $0xf2ab,%ebx
  101d4f:	83 ec 4c             	sub    $0x4c,%esp
    uint64_t ret;
    int i;

    timer_hw_init();
  101d52:	e8 a9 ff ff ff       	call   101d00 <timer_hw_init>

    tsc_per_ms = 0;
  101d57:	c7 83 94 88 02 00 00 	movl   $0x0,0x28894(%ebx)
  101d5e:	00 00 00 
  101d61:	c7 83 98 88 02 00 00 	movl   $0x0,0x28898(%ebx)
  101d68:	00 00 00 

    if (detect_kvm())
  101d6b:	e8 c0 1e 00 00       	call   103c30 <detect_kvm>
  101d70:	85 c0                	test   %eax,%eax
  101d72:	0f 85 c6 02 00 00    	jne    10203e <tsc_init+0x2fe>
  101d78:	8d 83 b4 8a ff ff    	lea    -0x754c(%ebx),%eax

    /*
     * XXX: If TSC calibration fails frequently, try to increase the
     *      upper bound of loop condition, e.g. alternating 3 to 10.
     */
    for (i = 0; i < 10; i++) {
  101d7e:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  101d85:	00 
  101d86:	89 44 24 38          	mov    %eax,0x38(%esp)
  101d8a:	8d 83 99 81 ff ff    	lea    -0x7e67(%ebx),%eax
  101d90:	89 44 24 2c          	mov    %eax,0x2c(%esp)
        ret = tsc_calibrate(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
        if (ret != ~(uint64_t) 0x0)
            break;
        KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i + 1);
  101d94:	8d 83 c1 81 ff ff    	lea    -0x7e3f(%ebx),%eax
  101d9a:	89 44 24 3c          	mov    %eax,0x3c(%esp)
  101d9e:	89 5c 24 14          	mov    %ebx,0x14(%esp)
  101da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101da8:	83 ec 0c             	sub    $0xc,%esp
  101dab:	6a 61                	push   $0x61
  101dad:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  101db1:	e8 9a 31 00 00       	call   104f50 <inb>
  101db6:	5e                   	pop    %esi
  101db7:	5f                   	pop    %edi
    tscmin = ~(uint64_t) 0x0;
  101db8:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  101dbd:	25 fc 00 00 00       	and    $0xfc,%eax
  101dc2:	83 c8 01             	or     $0x1,%eax
  101dc5:	50                   	push   %eax
  101dc6:	6a 61                	push   $0x61
  101dc8:	e8 b3 31 00 00       	call   104f80 <outb>
    outb(0x43, 0xb0);
  101dcd:	5d                   	pop    %ebp
  101dce:	58                   	pop    %eax
  101dcf:	68 b0 00 00 00       	push   $0xb0
  101dd4:	6a 43                	push   $0x43
    pitcnt = 0;
  101dd6:	31 ed                	xor    %ebp,%ebp
    outb(0x43, 0xb0);
  101dd8:	e8 a3 31 00 00       	call   104f80 <outb>
    outb(0x42, latch & 0xff);
  101ddd:	58                   	pop    %eax
  101dde:	5a                   	pop    %edx
  101ddf:	68 9b 00 00 00       	push   $0x9b
  101de4:	6a 42                	push   $0x42
  101de6:	e8 95 31 00 00       	call   104f80 <outb>
    outb(0x42, latch >> 8);
  101deb:	59                   	pop    %ecx
  101dec:	5e                   	pop    %esi
  101ded:	6a 2e                	push   $0x2e
  101def:	6a 42                	push   $0x42
    tscmin = ~(uint64_t) 0x0;
  101df1:	be ff ff ff ff       	mov    $0xffffffff,%esi
    outb(0x42, latch >> 8);
  101df6:	e8 85 31 00 00       	call   104f80 <outb>
    tsc = t1 = t2 = rdtsc();
  101dfb:	e8 f0 2f 00 00       	call   104df0 <rdtsc>
  101e00:	89 44 24 40          	mov    %eax,0x40(%esp)
  101e04:	89 54 24 44          	mov    %edx,0x44(%esp)
    while ((inb(0x61) & 0x20) == 0) {
  101e08:	83 c4 10             	add    $0x10,%esp
    tsc = t1 = t2 = rdtsc();
  101e0b:	89 44 24 18          	mov    %eax,0x18(%esp)
  101e0f:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    tscmax = 0;
  101e13:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101e1a:	00 
  101e1b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  101e22:	00 
    while ((inb(0x61) & 0x20) == 0) {
  101e23:	eb 63                	jmp    101e88 <tsc_init+0x148>
  101e25:	8d 76 00             	lea    0x0(%esi),%esi
        t2 = rdtsc();
  101e28:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  101e2c:	e8 bf 2f 00 00       	call   104df0 <rdtsc>
        delta = t2 - tsc;
  101e31:	89 c1                	mov    %eax,%ecx
  101e33:	89 d3                	mov    %edx,%ebx
  101e35:	2b 4c 24 18          	sub    0x18(%esp),%ecx
  101e39:	1b 5c 24 1c          	sbb    0x1c(%esp),%ebx
  101e3d:	89 44 24 20          	mov    %eax,0x20(%esp)
        if (delta < tscmin)
  101e41:	39 f1                	cmp    %esi,%ecx
  101e43:	89 d8                	mov    %ebx,%eax
  101e45:	19 f8                	sbb    %edi,%eax
        delta = t2 - tsc;
  101e47:	89 54 24 24          	mov    %edx,0x24(%esp)
        if (delta > tscmax)
  101e4b:	8b 44 24 08          	mov    0x8(%esp),%eax
  101e4f:	8b 54 24 0c          	mov    0xc(%esp),%edx
        if (delta < tscmin)
  101e53:	0f 42 f1             	cmovb  %ecx,%esi
  101e56:	0f 42 fb             	cmovb  %ebx,%edi
        if (delta > tscmax)
  101e59:	39 c8                	cmp    %ecx,%eax
  101e5b:	89 d0                	mov    %edx,%eax
        tsc = t2;
  101e5d:	8b 54 24 24          	mov    0x24(%esp),%edx
        if (delta > tscmax)
  101e61:	19 d8                	sbb    %ebx,%eax
  101e63:	8b 44 24 08          	mov    0x8(%esp),%eax
        tsc = t2;
  101e67:	89 54 24 1c          	mov    %edx,0x1c(%esp)
        if (delta > tscmax)
  101e6b:	0f 42 c1             	cmovb  %ecx,%eax
  101e6e:	89 44 24 08          	mov    %eax,0x8(%esp)
  101e72:	89 d8                	mov    %ebx,%eax
  101e74:	0f 43 44 24 0c       	cmovae 0xc(%esp),%eax
        pitcnt++;
  101e79:	83 c5 01             	add    $0x1,%ebp
        if (delta > tscmax)
  101e7c:	89 44 24 0c          	mov    %eax,0xc(%esp)
        tsc = t2;
  101e80:	8b 44 24 20          	mov    0x20(%esp),%eax
  101e84:	89 44 24 18          	mov    %eax,0x18(%esp)
    while ((inb(0x61) & 0x20) == 0) {
  101e88:	83 ec 0c             	sub    $0xc,%esp
  101e8b:	6a 61                	push   $0x61
  101e8d:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  101e91:	e8 ba 30 00 00       	call   104f50 <inb>
  101e96:	83 c4 10             	add    $0x10,%esp
  101e99:	a8 20                	test   $0x20,%al
  101e9b:	74 8b                	je     101e28 <tsc_init+0xe8>
    KERN_DEBUG("pitcnt=%u, tscmin=%llu, tscmax=%llu\n",
  101e9d:	ff 74 24 0c          	push   0xc(%esp)
  101ea1:	ff 74 24 0c          	push   0xc(%esp)
  101ea5:	57                   	push   %edi
  101ea6:	56                   	push   %esi
  101ea7:	55                   	push   %ebp
  101ea8:	ff 74 24 4c          	push   0x4c(%esp)
  101eac:	6a 39                	push   $0x39
  101eae:	ff 74 24 48          	push   0x48(%esp)
  101eb2:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  101eb6:	e8 45 22 00 00       	call   104100 <debug_normal>
    if (pitcnt < loopmin || tscmax > 10 * tscmin)
  101ebb:	83 c4 20             	add    $0x20,%esp
  101ebe:	81 fd e7 03 00 00    	cmp    $0x3e7,%ebp
  101ec4:	0f 8e f6 00 00 00    	jle    101fc0 <tsc_init+0x280>
  101eca:	89 f0                	mov    %esi,%eax
  101ecc:	89 fa                	mov    %edi,%edx
  101ece:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  101ed2:	c1 e0 02             	shl    $0x2,%eax
  101ed5:	0f a4 f2 02          	shld   $0x2,%esi,%edx
  101ed9:	01 f0                	add    %esi,%eax
  101edb:	11 fa                	adc    %edi,%edx
  101edd:	8b 7c 24 08          	mov    0x8(%esp),%edi
  101ee1:	0f a4 c2 01          	shld   $0x1,%eax,%edx
  101ee5:	01 c0                	add    %eax,%eax
  101ee7:	39 f8                	cmp    %edi,%eax
  101ee9:	89 d0                	mov    %edx,%eax
  101eeb:	19 e8                	sbb    %ebp,%eax
  101eed:	0f 82 cd 00 00 00    	jb     101fc0 <tsc_init+0x280>
    delta = t2 - t1;
  101ef3:	8b 74 24 18          	mov    0x18(%esp),%esi
  101ef7:	2b 74 24 30          	sub    0x30(%esp),%esi
    return delta / ms;
  101efb:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    delta = t2 - t1;
  101f00:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
    return delta / ms;
  101f04:	89 f5                	mov    %esi,%ebp
    delta = t2 - t1;
  101f06:	1b 7c 24 34          	sbb    0x34(%esp),%edi
    return delta / ms;
  101f0a:	01 fd                	add    %edi,%ebp
  101f0c:	83 d5 00             	adc    $0x0,%ebp
  101f0f:	89 e8                	mov    %ebp,%eax
  101f11:	f7 e1                	mul    %ecx
  101f13:	89 d0                	mov    %edx,%eax
  101f15:	83 e2 fc             	and    $0xfffffffc,%edx
  101f18:	c1 e8 02             	shr    $0x2,%eax
  101f1b:	01 c2                	add    %eax,%edx
  101f1d:	29 d5                	sub    %edx,%ebp
  101f1f:	29 ee                	sub    %ebp,%esi
  101f21:	83 df 00             	sbb    $0x0,%edi
  101f24:	89 74 24 08          	mov    %esi,0x8(%esp)
  101f28:	69 44 24 08 cc cc cc 	imul   $0xcccccccc,0x8(%esp),%eax
  101f2f:	cc 

        timer_hw_init();
        return 1;
    } else {
        tsc_per_ms = ret;
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101f30:	83 ec 10             	sub    $0x10,%esp
    return delta / ms;
  101f33:	89 fa                	mov    %edi,%edx
  101f35:	69 ff cd cc cc cc    	imul   $0xcccccccd,%edi,%edi
  101f3b:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  101f3f:	01 c7                	add    %eax,%edi
  101f41:	8b 44 24 18          	mov    0x18(%esp),%eax
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101f45:	6a 00                	push   $0x0
  101f47:	68 e8 03 00 00       	push   $0x3e8
    return delta / ms;
  101f4c:	f7 e1                	mul    %ecx
  101f4e:	01 fa                	add    %edi,%edx
  101f50:	0f ac d0 01          	shrd   $0x1,%edx,%eax
  101f54:	d1 ea                	shr    $1,%edx
        tsc_per_ms = ret;
  101f56:	89 83 94 88 02 00    	mov    %eax,0x28894(%ebx)
  101f5c:	89 93 98 88 02 00    	mov    %edx,0x28898(%ebx)
        KERN_DEBUG("TSC freq = %u.%03u MHz.\n",tsc_per_ms / 1000, tsc_per_ms % 1000);
  101f62:	8b 83 94 88 02 00    	mov    0x28894(%ebx),%eax
  101f68:	8b 93 98 88 02 00    	mov    0x28898(%ebx),%edx
  101f6e:	8b b3 94 88 02 00    	mov    0x28894(%ebx),%esi
  101f74:	8b bb 98 88 02 00    	mov    0x28898(%ebx),%edi
  101f7a:	52                   	push   %edx
  101f7b:	50                   	push   %eax
  101f7c:	e8 af 65 00 00       	call   108530 <__umoddi3>
  101f81:	83 c4 1c             	add    $0x1c,%esp
  101f84:	52                   	push   %edx
  101f85:	50                   	push   %eax
  101f86:	83 ec 04             	sub    $0x4,%esp
  101f89:	6a 00                	push   $0x0
  101f8b:	68 e8 03 00 00       	push   $0x3e8
  101f90:	57                   	push   %edi
  101f91:	56                   	push   %esi
  101f92:	e8 69 64 00 00       	call   108400 <__udivdi3>
  101f97:	83 c4 14             	add    $0x14,%esp
  101f9a:	52                   	push   %edx
  101f9b:	50                   	push   %eax
  101f9c:	8d 83 a8 81 ff ff    	lea    -0x7e58(%ebx),%eax
  101fa2:	50                   	push   %eax
  101fa3:	6a 68                	push   $0x68
  101fa5:	ff 74 24 48          	push   0x48(%esp)
  101fa9:	e8 52 21 00 00       	call   104100 <debug_normal>

        timer_hw_init();
  101fae:	83 c4 20             	add    $0x20,%esp
  101fb1:	e8 4a fd ff ff       	call   101d00 <timer_hw_init>
        return 0;
    }
}
  101fb6:	83 c4 4c             	add    $0x4c,%esp
		return (0);
  101fb9:	31 c0                	xor    %eax,%eax
}
  101fbb:	5b                   	pop    %ebx
  101fbc:	5e                   	pop    %esi
  101fbd:	5f                   	pop    %edi
  101fbe:	5d                   	pop    %ebp
  101fbf:	c3                   	ret
        KERN_DEBUG("[%d] Retry to calibrate TSC.\n", i + 1);
  101fc0:	83 44 24 28 01       	addl   $0x1,0x28(%esp)
  101fc5:	8b 7c 24 28          	mov    0x28(%esp),%edi
  101fc9:	57                   	push   %edi
  101fca:	ff 74 24 40          	push   0x40(%esp)
  101fce:	6a 5c                	push   $0x5c
  101fd0:	ff 74 24 38          	push   0x38(%esp)
  101fd4:	8b 5c 24 24          	mov    0x24(%esp),%ebx
  101fd8:	e8 23 21 00 00       	call   104100 <debug_normal>
    for (i = 0; i < 10; i++) {
  101fdd:	83 c4 10             	add    $0x10,%esp
  101fe0:	83 ff 0a             	cmp    $0xa,%edi
  101fe3:	0f 85 bf fd ff ff    	jne    101da8 <tsc_init+0x68>
        KERN_DEBUG("TSC calibration failed.\n");
  101fe9:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  101fed:	83 ec 04             	sub    $0x4,%esp
  101ff0:	8d 83 df 81 ff ff    	lea    -0x7e21(%ebx),%eax
  101ff6:	50                   	push   %eax
  101ff7:	6a 60                	push   $0x60
  101ff9:	8b 7c 24 38          	mov    0x38(%esp),%edi
  101ffd:	57                   	push   %edi
  101ffe:	e8 fd 20 00 00       	call   104100 <debug_normal>
        KERN_DEBUG("Assume TSC freq = 1 GHz.\n");
  102003:	83 c4 0c             	add    $0xc,%esp
  102006:	8d 83 f8 81 ff ff    	lea    -0x7e08(%ebx),%eax
  10200c:	50                   	push   %eax
  10200d:	6a 61                	push   $0x61
  10200f:	57                   	push   %edi
  102010:	e8 eb 20 00 00       	call   104100 <debug_normal>
        tsc_per_ms = 1000000;
  102015:	c7 83 94 88 02 00 40 	movl   $0xf4240,0x28894(%ebx)
  10201c:	42 0f 00 
  10201f:	c7 83 98 88 02 00 00 	movl   $0x0,0x28898(%ebx)
  102026:	00 00 00 
        timer_hw_init();
  102029:	e8 d2 fc ff ff       	call   101d00 <timer_hw_init>
        return 1;
  10202e:	83 c4 10             	add    $0x10,%esp
  102031:	b8 01 00 00 00       	mov    $0x1,%eax
}
  102036:	83 c4 4c             	add    $0x4c,%esp
  102039:	5b                   	pop    %ebx
  10203a:	5e                   	pop    %esi
  10203b:	5f                   	pop    %edi
  10203c:	5d                   	pop    %ebp
  10203d:	c3                   	ret
		tsc_per_ms = kvm_get_tsc_hz() / 1000llu;
  10203e:	e8 2d 1d 00 00       	call   103d70 <kvm_get_tsc_hz>
  102043:	6a 00                	push   $0x0
  102045:	68 e8 03 00 00       	push   $0x3e8
  10204a:	52                   	push   %edx
  10204b:	50                   	push   %eax
  10204c:	e8 af 63 00 00       	call   108400 <__udivdi3>
		KERN_INFO ("TSC read from KVM: %u.%03u MHz.\n",
  102051:	6a 00                	push   $0x0
		tsc_per_ms = kvm_get_tsc_hz() / 1000llu;
  102053:	89 83 94 88 02 00    	mov    %eax,0x28894(%ebx)
  102059:	89 93 98 88 02 00    	mov    %edx,0x28898(%ebx)
		KERN_INFO ("TSC read from KVM: %u.%03u MHz.\n",
  10205f:	8b 83 94 88 02 00    	mov    0x28894(%ebx),%eax
  102065:	8b 93 98 88 02 00    	mov    0x28898(%ebx),%edx
  10206b:	68 e8 03 00 00       	push   $0x3e8
  102070:	8b b3 94 88 02 00    	mov    0x28894(%ebx),%esi
  102076:	8b bb 98 88 02 00    	mov    0x28898(%ebx),%edi
  10207c:	52                   	push   %edx
  10207d:	50                   	push   %eax
  10207e:	e8 ad 64 00 00       	call   108530 <__umoddi3>
  102083:	83 c4 14             	add    $0x14,%esp
  102086:	52                   	push   %edx
  102087:	50                   	push   %eax
  102088:	83 ec 0c             	sub    $0xc,%esp
  10208b:	6a 00                	push   $0x0
  10208d:	68 e8 03 00 00       	push   $0x3e8
  102092:	57                   	push   %edi
  102093:	56                   	push   %esi
  102094:	e8 67 63 00 00       	call   108400 <__udivdi3>
  102099:	83 c4 1c             	add    $0x1c,%esp
  10209c:	52                   	push   %edx
  10209d:	50                   	push   %eax
  10209e:	8d 83 90 8a ff ff    	lea    -0x7570(%ebx),%eax
  1020a4:	50                   	push   %eax
  1020a5:	e8 16 20 00 00       	call   1040c0 <debug_info>
		return (0);
  1020aa:	83 c4 20             	add    $0x20,%esp
  1020ad:	e9 04 ff ff ff       	jmp    101fb6 <tsc_init+0x276>
  1020b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1020b9:	00 
  1020ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001020c0 <delay>:

/*
 * Wait for ms millisecond.
 */
void delay(uint32_t ms)
{
  1020c0:	55                   	push   %ebp
  1020c1:	e8 b3 f1 ff ff       	call   101279 <__x86.get_pc_thunk.bp>
  1020c6:	81 c5 2e ef 00 00    	add    $0xef2e,%ebp
  1020cc:	57                   	push   %edi
  1020cd:	56                   	push   %esi
  1020ce:	53                   	push   %ebx
  1020cf:	83 ec 1c             	sub    $0x1c,%esp
  1020d2:	8b 44 24 30          	mov    0x30(%esp),%eax
    volatile uint64_t ticks = tsc_per_ms * ms;
  1020d6:	8b b5 94 88 02 00    	mov    0x28894(%ebp),%esi
    volatile uint64_t start = rdtsc();
  1020dc:	89 eb                	mov    %ebp,%ebx
    volatile uint64_t ticks = tsc_per_ms * ms;
  1020de:	8b 8d 98 88 02 00    	mov    0x28898(%ebp),%ecx
  1020e4:	0f af c8             	imul   %eax,%ecx
  1020e7:	f7 e6                	mul    %esi
  1020e9:	01 ca                	add    %ecx,%edx
  1020eb:	89 04 24             	mov    %eax,(%esp)
  1020ee:	89 54 24 04          	mov    %edx,0x4(%esp)
    volatile uint64_t start = rdtsc();
  1020f2:	e8 f9 2c 00 00       	call   104df0 <rdtsc>
  1020f7:	89 44 24 08          	mov    %eax,0x8(%esp)
  1020fb:	89 54 24 0c          	mov    %edx,0xc(%esp)
    while (rdtsc() < start + ticks);
  1020ff:	90                   	nop
  102100:	89 eb                	mov    %ebp,%ebx
  102102:	e8 e9 2c 00 00       	call   104df0 <rdtsc>
  102107:	89 c3                	mov    %eax,%ebx
  102109:	89 d1                	mov    %edx,%ecx
  10210b:	8b 44 24 08          	mov    0x8(%esp),%eax
  10210f:	8b 54 24 0c          	mov    0xc(%esp),%edx
  102113:	8b 34 24             	mov    (%esp),%esi
  102116:	8b 7c 24 04          	mov    0x4(%esp),%edi
  10211a:	01 f0                	add    %esi,%eax
  10211c:	11 fa                	adc    %edi,%edx
  10211e:	39 c3                	cmp    %eax,%ebx
  102120:	19 d1                	sbb    %edx,%ecx
  102122:	72 dc                	jb     102100 <delay+0x40>
}
  102124:	83 c4 1c             	add    $0x1c,%esp
  102127:	5b                   	pop    %ebx
  102128:	5e                   	pop    %esi
  102129:	5f                   	pop    %edi
  10212a:	5d                   	pop    %ebp
  10212b:	c3                   	ret
  10212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102130 <udelay>:

/*
 * Wait for us microsecond.
 */
void udelay(uint32_t us)
{
  102130:	55                   	push   %ebp
  102131:	e8 43 f1 ff ff       	call   101279 <__x86.get_pc_thunk.bp>
  102136:	81 c5 be ee 00 00    	add    $0xeebe,%ebp
  10213c:	57                   	push   %edi
  10213d:	56                   	push   %esi
  10213e:	53                   	push   %ebx
  10213f:	83 ec 1c             	sub    $0x1c,%esp
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  102142:	8b 85 94 88 02 00    	mov    0x28894(%ebp),%eax
  102148:	8b 95 98 88 02 00    	mov    0x28898(%ebp),%edx
  10214e:	89 eb                	mov    %ebp,%ebx
{
  102150:	8b 74 24 30          	mov    0x30(%esp),%esi
    volatile uint64_t ticks = tsc_per_ms / 1000 * us;
  102154:	6a 00                	push   $0x0
  102156:	68 e8 03 00 00       	push   $0x3e8
  10215b:	52                   	push   %edx
  10215c:	50                   	push   %eax
  10215d:	e8 9e 62 00 00       	call   108400 <__udivdi3>
  102162:	83 c4 10             	add    $0x10,%esp
  102165:	89 d1                	mov    %edx,%ecx
  102167:	f7 e6                	mul    %esi
  102169:	0f af ce             	imul   %esi,%ecx
  10216c:	89 04 24             	mov    %eax,(%esp)
  10216f:	01 ca                	add    %ecx,%edx
  102171:	89 54 24 04          	mov    %edx,0x4(%esp)
    volatile uint64_t start = rdtsc();
  102175:	e8 76 2c 00 00       	call   104df0 <rdtsc>
  10217a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10217e:	89 54 24 0c          	mov    %edx,0xc(%esp)
    while (rdtsc() < start + ticks);
  102182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102188:	89 eb                	mov    %ebp,%ebx
  10218a:	e8 61 2c 00 00       	call   104df0 <rdtsc>
  10218f:	89 c3                	mov    %eax,%ebx
  102191:	89 d1                	mov    %edx,%ecx
  102193:	8b 44 24 08          	mov    0x8(%esp),%eax
  102197:	8b 54 24 0c          	mov    0xc(%esp),%edx
  10219b:	8b 34 24             	mov    (%esp),%esi
  10219e:	8b 7c 24 04          	mov    0x4(%esp),%edi
  1021a2:	01 f0                	add    %esi,%eax
  1021a4:	11 fa                	adc    %edi,%edx
  1021a6:	39 c3                	cmp    %eax,%ebx
  1021a8:	19 d1                	sbb    %edx,%ecx
  1021aa:	72 dc                	jb     102188 <udelay+0x58>
}
  1021ac:	83 c4 1c             	add    $0x1c,%esp
  1021af:	5b                   	pop    %ebx
  1021b0:	5e                   	pop    %esi
  1021b1:	5f                   	pop    %edi
  1021b2:	5d                   	pop    %ebp
  1021b3:	c3                   	ret
  1021b4:	66 90                	xchg   %ax,%ax
  1021b6:	66 90                	xchg   %ax,%ax
  1021b8:	66 90                	xchg   %ax,%ax
  1021ba:	66 90                	xchg   %ax,%ax
  1021bc:	66 90                	xchg   %ax,%ax
  1021be:	66 90                	xchg   %ax,%ax

001021c0 <Xdivide>:
	jmp	_alltraps

.text

/* exceptions  */
TRAPHANDLER_NOEC(Xdivide,	T_DIVIDE)
  1021c0:	6a 00                	push   $0x0
  1021c2:	6a 00                	push   $0x0
  1021c4:	e9 17 01 00 00       	jmp    1022e0 <_alltraps>
  1021c9:	90                   	nop

001021ca <Xdebug>:
TRAPHANDLER_NOEC(Xdebug,	T_DEBUG)
  1021ca:	6a 00                	push   $0x0
  1021cc:	6a 01                	push   $0x1
  1021ce:	e9 0d 01 00 00       	jmp    1022e0 <_alltraps>
  1021d3:	90                   	nop

001021d4 <Xnmi>:
TRAPHANDLER_NOEC(Xnmi,		T_NMI)
  1021d4:	6a 00                	push   $0x0
  1021d6:	6a 02                	push   $0x2
  1021d8:	e9 03 01 00 00       	jmp    1022e0 <_alltraps>
  1021dd:	90                   	nop

001021de <Xbrkpt>:
TRAPHANDLER_NOEC(Xbrkpt,	T_BRKPT)
  1021de:	6a 00                	push   $0x0
  1021e0:	6a 03                	push   $0x3
  1021e2:	e9 f9 00 00 00       	jmp    1022e0 <_alltraps>
  1021e7:	90                   	nop

001021e8 <Xoflow>:
TRAPHANDLER_NOEC(Xoflow,	T_OFLOW)
  1021e8:	6a 00                	push   $0x0
  1021ea:	6a 04                	push   $0x4
  1021ec:	e9 ef 00 00 00       	jmp    1022e0 <_alltraps>
  1021f1:	90                   	nop

001021f2 <Xbound>:
TRAPHANDLER_NOEC(Xbound,	T_BOUND)
  1021f2:	6a 00                	push   $0x0
  1021f4:	6a 05                	push   $0x5
  1021f6:	e9 e5 00 00 00       	jmp    1022e0 <_alltraps>
  1021fb:	90                   	nop

001021fc <Xillop>:
TRAPHANDLER_NOEC(Xillop,	T_ILLOP)
  1021fc:	6a 00                	push   $0x0
  1021fe:	6a 06                	push   $0x6
  102200:	e9 db 00 00 00       	jmp    1022e0 <_alltraps>
  102205:	90                   	nop

00102206 <Xdevice>:
TRAPHANDLER_NOEC(Xdevice,	T_DEVICE)
  102206:	6a 00                	push   $0x0
  102208:	6a 07                	push   $0x7
  10220a:	e9 d1 00 00 00       	jmp    1022e0 <_alltraps>
  10220f:	90                   	nop

00102210 <Xdblflt>:
TRAPHANDLER     (Xdblflt,	T_DBLFLT)
  102210:	6a 08                	push   $0x8
  102212:	e9 c9 00 00 00       	jmp    1022e0 <_alltraps>
  102217:	90                   	nop

00102218 <Xcoproc>:
TRAPHANDLER_NOEC(Xcoproc,	T_COPROC)
  102218:	6a 00                	push   $0x0
  10221a:	6a 09                	push   $0x9
  10221c:	e9 bf 00 00 00       	jmp    1022e0 <_alltraps>
  102221:	90                   	nop

00102222 <Xtss>:
TRAPHANDLER     (Xtss,		T_TSS)
  102222:	6a 0a                	push   $0xa
  102224:	e9 b7 00 00 00       	jmp    1022e0 <_alltraps>
  102229:	90                   	nop

0010222a <Xsegnp>:
TRAPHANDLER     (Xsegnp,	T_SEGNP)
  10222a:	6a 0b                	push   $0xb
  10222c:	e9 af 00 00 00       	jmp    1022e0 <_alltraps>
  102231:	90                   	nop

00102232 <Xstack>:
TRAPHANDLER     (Xstack,	T_STACK)
  102232:	6a 0c                	push   $0xc
  102234:	e9 a7 00 00 00       	jmp    1022e0 <_alltraps>
  102239:	90                   	nop

0010223a <Xgpflt>:
TRAPHANDLER     (Xgpflt,	T_GPFLT)
  10223a:	6a 0d                	push   $0xd
  10223c:	e9 9f 00 00 00       	jmp    1022e0 <_alltraps>
  102241:	90                   	nop

00102242 <Xpgflt>:
TRAPHANDLER     (Xpgflt,	T_PGFLT)
  102242:	6a 0e                	push   $0xe
  102244:	e9 97 00 00 00       	jmp    1022e0 <_alltraps>
  102249:	90                   	nop

0010224a <Xres>:
TRAPHANDLER_NOEC(Xres,		T_RES)
  10224a:	6a 00                	push   $0x0
  10224c:	6a 0f                	push   $0xf
  10224e:	e9 8d 00 00 00       	jmp    1022e0 <_alltraps>
  102253:	90                   	nop

00102254 <Xfperr>:
TRAPHANDLER_NOEC(Xfperr,	T_FPERR)
  102254:	6a 00                	push   $0x0
  102256:	6a 10                	push   $0x10
  102258:	e9 83 00 00 00       	jmp    1022e0 <_alltraps>
  10225d:	90                   	nop

0010225e <Xalign>:
TRAPHANDLER     (Xalign,	T_ALIGN)
  10225e:	6a 11                	push   $0x11
  102260:	eb 7e                	jmp    1022e0 <_alltraps>

00102262 <Xmchk>:
TRAPHANDLER_NOEC(Xmchk,		T_MCHK)
  102262:	6a 00                	push   $0x0
  102264:	6a 12                	push   $0x12
  102266:	eb 78                	jmp    1022e0 <_alltraps>

00102268 <Xirq_timer>:

/* ISA interrupts  */
TRAPHANDLER_NOEC(Xirq_timer,	T_IRQ0 + IRQ_TIMER)
  102268:	6a 00                	push   $0x0
  10226a:	6a 20                	push   $0x20
  10226c:	eb 72                	jmp    1022e0 <_alltraps>

0010226e <Xirq_kbd>:
TRAPHANDLER_NOEC(Xirq_kbd,	T_IRQ0 + IRQ_KBD)
  10226e:	6a 00                	push   $0x0
  102270:	6a 21                	push   $0x21
  102272:	eb 6c                	jmp    1022e0 <_alltraps>

00102274 <Xirq_slave>:
TRAPHANDLER_NOEC(Xirq_slave,	T_IRQ0 + IRQ_SLAVE)
  102274:	6a 00                	push   $0x0
  102276:	6a 22                	push   $0x22
  102278:	eb 66                	jmp    1022e0 <_alltraps>

0010227a <Xirq_serial2>:
TRAPHANDLER_NOEC(Xirq_serial2,	T_IRQ0 + IRQ_SERIAL24)
  10227a:	6a 00                	push   $0x0
  10227c:	6a 23                	push   $0x23
  10227e:	eb 60                	jmp    1022e0 <_alltraps>

00102280 <Xirq_serial1>:
TRAPHANDLER_NOEC(Xirq_serial1,	T_IRQ0 + IRQ_SERIAL13)
  102280:	6a 00                	push   $0x0
  102282:	6a 24                	push   $0x24
  102284:	eb 5a                	jmp    1022e0 <_alltraps>

00102286 <Xirq_lpt>:
TRAPHANDLER_NOEC(Xirq_lpt,	T_IRQ0 + IRQ_LPT2)
  102286:	6a 00                	push   $0x0
  102288:	6a 25                	push   $0x25
  10228a:	eb 54                	jmp    1022e0 <_alltraps>

0010228c <Xirq_floppy>:
TRAPHANDLER_NOEC(Xirq_floppy,	T_IRQ0 + IRQ_FLOPPY)
  10228c:	6a 00                	push   $0x0
  10228e:	6a 26                	push   $0x26
  102290:	eb 4e                	jmp    1022e0 <_alltraps>

00102292 <Xirq_spurious>:
TRAPHANDLER_NOEC(Xirq_spurious,	T_IRQ0 + IRQ_SPURIOUS)
  102292:	6a 00                	push   $0x0
  102294:	6a 27                	push   $0x27
  102296:	eb 48                	jmp    1022e0 <_alltraps>

00102298 <Xirq_rtc>:
TRAPHANDLER_NOEC(Xirq_rtc,	T_IRQ0 + IRQ_RTC)
  102298:	6a 00                	push   $0x0
  10229a:	6a 28                	push   $0x28
  10229c:	eb 42                	jmp    1022e0 <_alltraps>

0010229e <Xirq9>:
TRAPHANDLER_NOEC(Xirq9,		T_IRQ0 + 9)
  10229e:	6a 00                	push   $0x0
  1022a0:	6a 29                	push   $0x29
  1022a2:	eb 3c                	jmp    1022e0 <_alltraps>

001022a4 <Xirq10>:
TRAPHANDLER_NOEC(Xirq10,	T_IRQ0 + 10)
  1022a4:	6a 00                	push   $0x0
  1022a6:	6a 2a                	push   $0x2a
  1022a8:	eb 36                	jmp    1022e0 <_alltraps>

001022aa <Xirq11>:
TRAPHANDLER_NOEC(Xirq11,	T_IRQ0 + 11)
  1022aa:	6a 00                	push   $0x0
  1022ac:	6a 2b                	push   $0x2b
  1022ae:	eb 30                	jmp    1022e0 <_alltraps>

001022b0 <Xirq_mouse>:
TRAPHANDLER_NOEC(Xirq_mouse,	T_IRQ0 + IRQ_MOUSE)
  1022b0:	6a 00                	push   $0x0
  1022b2:	6a 2c                	push   $0x2c
  1022b4:	eb 2a                	jmp    1022e0 <_alltraps>

001022b6 <Xirq_coproc>:
TRAPHANDLER_NOEC(Xirq_coproc,	T_IRQ0 + IRQ_COPROCESSOR)
  1022b6:	6a 00                	push   $0x0
  1022b8:	6a 2d                	push   $0x2d
  1022ba:	eb 24                	jmp    1022e0 <_alltraps>

001022bc <Xirq_ide1>:
TRAPHANDLER_NOEC(Xirq_ide1,	T_IRQ0 + IRQ_IDE1)
  1022bc:	6a 00                	push   $0x0
  1022be:	6a 2e                	push   $0x2e
  1022c0:	eb 1e                	jmp    1022e0 <_alltraps>

001022c2 <Xirq_ide2>:
TRAPHANDLER_NOEC(Xirq_ide2,	T_IRQ0 + IRQ_IDE2)
  1022c2:	6a 00                	push   $0x0
  1022c4:	6a 2f                	push   $0x2f
  1022c6:	eb 18                	jmp    1022e0 <_alltraps>

001022c8 <Xsyscall>:

/* syscall */
TRAPHANDLER_NOEC(Xsyscall,	T_SYSCALL)
  1022c8:	6a 00                	push   $0x0
  1022ca:	6a 30                	push   $0x30
  1022cc:	eb 12                	jmp    1022e0 <_alltraps>

001022ce <Xdefault>:

/* default ? */
TRAPHANDLER     (Xdefault,	T_DEFAULT)
  1022ce:	68 fe 00 00 00       	push   $0xfe
  1022d3:	eb 0b                	jmp    1022e0 <_alltraps>
  1022d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1022dc:	00 
  1022dd:	8d 76 00             	lea    0x0(%esi),%esi

001022e0 <_alltraps>:

	.globl _alltraps
	.type _alltraps, @function
	.p2align 4, 0x90	/* 16-byte alignment, nop filled */
_alltraps:
	cli			# make sure there is no nested trap
  1022e0:	fa                   	cli
	cld
  1022e1:	fc                   	cld

	pushl	%ds		# build context
  1022e2:	1e                   	push   %ds
	pushl	%es
  1022e3:	06                   	push   %es
	pushal
  1022e4:	60                   	pusha

	movl	$CPU_GDT_KDATA, %eax	# load kernel's data segment
  1022e5:	b8 10 00 00 00       	mov    $0x10,%eax
	movw	%ax, %ds
  1022ea:	8e d8                	mov    %eax,%ds
	movw	%ax, %es
  1022ec:	8e c0                	mov    %eax,%es

	pushl	%esp		# pass pointer to this trapframe
  1022ee:	54                   	push   %esp

	call	trap		# and call trap (does not return)
  1022ef:	e8 dc 5b 00 00       	call   107ed0 <trap>

1:	hlt			# should never get here; just spin...
  1022f4:	f4                   	hlt
  1022f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1022fc:	00 
  1022fd:	8d 76 00             	lea    0x0(%esi),%esi

00102300 <trap_return>:
//
	.globl trap_return
	.type trap_return, @function
	.p2align 4, 0x90	/* 16-byte alignment, nop filled */
trap_return:
	movl	4(%esp), %esp	// reset stack pointer to point to trap frame
  102300:	8b 64 24 04          	mov    0x4(%esp),%esp
	popal			// restore general-purpose registers except esp
  102304:	61                   	popa
	popl	%es		// restore data segment registers
  102305:	07                   	pop    %es
	popl	%ds
  102306:	1f                   	pop    %ds
	addl	$8, %esp	// skip tf_trapno and tf_errcode
  102307:	83 c4 08             	add    $0x8,%esp
	iret			// return from trap handler
  10230a:	cf                   	iret
  10230b:	66 90                	xchg   %ax,%ax
  10230d:	66 90                	xchg   %ax,%ax
  10230f:	90                   	nop

00102310 <acpi_probe_rsdp>:

    return NULL;
}

acpi_rsdp_t *acpi_probe_rsdp(void)
{
  102310:	57                   	push   %edi
  102311:	56                   	push   %esi
  102312:	53                   	push   %ebx
    uint8_t *bda;
    uint32_t p;
    acpi_rsdp_t *rsdp;

    bda = (uint8_t *) 0x400;
    if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  102313:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  10231a:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  102321:	c1 e0 08             	shl    $0x8,%eax
  102324:	09 d0                	or     %edx,%eax
  102326:	c1 e0 04             	shl    $0x4,%eax
  102329:	74 4d                	je     102378 <acpi_probe_rsdp+0x68>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  10232b:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
    e = addr + length;
  102331:	8d 88 00 04 00 00    	lea    0x400(%eax),%ecx
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  102337:	74 16                	je     10234f <acpi_probe_rsdp+0x3f>
  102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (p = addr; p < e; p += 16) {
  102340:	83 c0 10             	add    $0x10,%eax
  102343:	39 c8                	cmp    %ecx,%eax
  102345:	73 31                	jae    102378 <acpi_probe_rsdp+0x68>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  102347:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  10234d:	75 f1                	jne    102340 <acpi_probe_rsdp+0x30>
  10234f:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  102356:	75 e8                	jne    102340 <acpi_probe_rsdp+0x30>
  102358:	89 c2                	mov    %eax,%edx
    sum = 0;
  10235a:	31 db                	xor    %ebx,%ebx
  10235c:	8d 70 24             	lea    0x24(%eax),%esi
  10235f:	90                   	nop
        sum += addr[i];
  102360:	0f b6 3a             	movzbl (%edx),%edi
    for (i = 0; i < len; i++) {
  102363:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  102366:	01 fb                	add    %edi,%ebx
    for (i = 0; i < len; i++) {
  102368:	39 f2                	cmp    %esi,%edx
  10236a:	75 f4                	jne    102360 <acpi_probe_rsdp+0x50>
            *(uint32_t *) (p + 4) == ACPI_RSDP_SIG2 &&
  10236c:	84 db                	test   %bl,%bl
  10236e:	75 d0                	jne    102340 <acpi_probe_rsdp+0x30>
        if ((rsdp = acpi_probe_rsdp_aux((uint8_t *) p, 1024)))
            return rsdp;
    }

    return acpi_probe_rsdp_aux((uint8_t *) 0xE0000, 0x1FFFF);
}
  102370:	5b                   	pop    %ebx
  102371:	5e                   	pop    %esi
  102372:	5f                   	pop    %edi
  102373:	c3                   	ret
  102374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102378:	b8 00 00 0e 00       	mov    $0xe0000,%eax
  10237d:	eb 0b                	jmp    10238a <acpi_probe_rsdp+0x7a>
  10237f:	90                   	nop
    for (p = addr; p < e; p += 16) {
  102380:	83 c0 10             	add    $0x10,%eax
  102383:	3d 00 00 10 00       	cmp    $0x100000,%eax
  102388:	74 38                	je     1023c2 <acpi_probe_rsdp+0xb2>
        if (*(uint32_t *) p == ACPI_RSDP_SIG1 &&
  10238a:	81 38 52 53 44 20    	cmpl   $0x20445352,(%eax)
  102390:	75 ee                	jne    102380 <acpi_probe_rsdp+0x70>
  102392:	81 78 04 50 54 52 20 	cmpl   $0x20525450,0x4(%eax)
  102399:	75 e5                	jne    102380 <acpi_probe_rsdp+0x70>
  10239b:	89 c2                	mov    %eax,%edx
    sum = 0;
  10239d:	31 c9                	xor    %ecx,%ecx
  10239f:	8d 70 24             	lea    0x24(%eax),%esi
  1023a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sum += addr[i];
  1023a8:	0f b6 1a             	movzbl (%edx),%ebx
    for (i = 0; i < len; i++) {
  1023ab:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  1023ae:	01 d9                	add    %ebx,%ecx
    for (i = 0; i < len; i++) {
  1023b0:	39 d6                	cmp    %edx,%esi
  1023b2:	75 f4                	jne    1023a8 <acpi_probe_rsdp+0x98>
            *(uint32_t *) (p + 4) == ACPI_RSDP_SIG2 &&
  1023b4:	84 c9                	test   %cl,%cl
  1023b6:	74 b8                	je     102370 <acpi_probe_rsdp+0x60>
    for (p = addr; p < e; p += 16) {
  1023b8:	83 c0 10             	add    $0x10,%eax
  1023bb:	3d 00 00 10 00       	cmp    $0x100000,%eax
  1023c0:	75 c8                	jne    10238a <acpi_probe_rsdp+0x7a>
}
  1023c2:	5b                   	pop    %ebx
    return NULL;
  1023c3:	31 c0                	xor    %eax,%eax
}
  1023c5:	5e                   	pop    %esi
  1023c6:	5f                   	pop    %edi
  1023c7:	c3                   	ret
  1023c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1023cf:	00 

001023d0 <acpi_probe_rsdt>:

acpi_rsdt_t *acpi_probe_rsdt(acpi_rsdp_t *rsdp)
{
  1023d0:	56                   	push   %esi
  1023d1:	53                   	push   %ebx
  1023d2:	e8 cb df ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1023d7:	81 c3 1d ec 00 00    	add    $0xec1d,%ebx
  1023dd:	83 ec 04             	sub    $0x4,%esp
  1023e0:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(rsdp != NULL);
  1023e4:	85 f6                	test   %esi,%esi
  1023e6:	74 50                	je     102438 <acpi_probe_rsdt+0x68>

    acpi_rsdt_t *rsdt = (acpi_rsdt_t *) (rsdp->rsdt_addr);
  1023e8:	8b 5e 10             	mov    0x10(%esi),%ebx
  1023eb:	89 d8                	mov    %ebx,%eax
    if (rsdt == NULL)
  1023ed:	85 db                	test   %ebx,%ebx
  1023ef:	74 2a                	je     10241b <acpi_probe_rsdt+0x4b>
        return NULL;
    if (rsdt->sig == ACPI_RSDT_SIG && sum((uint8_t *) rsdt, rsdt->length) == 0) {
  1023f1:	81 3b 52 53 44 54    	cmpl   $0x54445352,(%ebx)
  1023f7:	75 2f                	jne    102428 <acpi_probe_rsdt+0x58>
  1023f9:	8b 73 04             	mov    0x4(%ebx),%esi
    for (i = 0; i < len; i++) {
  1023fc:	85 f6                	test   %esi,%esi
  1023fe:	7e 1b                	jle    10241b <acpi_probe_rsdt+0x4b>
  102400:	01 de                	add    %ebx,%esi
    sum = 0;
  102402:	31 d2                	xor    %edx,%edx
  102404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102408:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++) {
  10240b:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  10240e:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++) {
  102410:	39 c6                	cmp    %eax,%esi
  102412:	75 f4                	jne    102408 <acpi_probe_rsdt+0x38>
        return NULL;
  102414:	31 c0                	xor    %eax,%eax
  102416:	84 d2                	test   %dl,%dl
  102418:	0f 45 d8             	cmovne %eax,%ebx
        return rsdt;
    }

    return NULL;
}
  10241b:	83 c4 04             	add    $0x4,%esp
  10241e:	89 d8                	mov    %ebx,%eax
  102420:	5b                   	pop    %ebx
  102421:	5e                   	pop    %esi
  102422:	c3                   	ret
  102423:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        return NULL;
  102428:	31 db                	xor    %ebx,%ebx
}
  10242a:	83 c4 04             	add    $0x4,%esp
  10242d:	89 d8                	mov    %ebx,%eax
  10242f:	5b                   	pop    %ebx
  102430:	5e                   	pop    %esi
  102431:	c3                   	ret
  102432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(rsdp != NULL);
  102438:	8d 83 12 82 ff ff    	lea    -0x7dee(%ebx),%eax
  10243e:	50                   	push   %eax
  10243f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  102445:	50                   	push   %eax
  102446:	8d 83 1f 82 ff ff    	lea    -0x7de1(%ebx),%eax
  10244c:	6a 33                	push   $0x33
  10244e:	50                   	push   %eax
  10244f:	e8 0c 1d 00 00       	call   104160 <debug_panic>
  102454:	83 c4 10             	add    $0x10,%esp
  102457:	eb 8f                	jmp    1023e8 <acpi_probe_rsdt+0x18>
  102459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102460 <acpi_probe_rsdt_ent>:

acpi_sdt_hdr_t *acpi_probe_rsdt_ent(acpi_rsdt_t *rsdt, const uint32_t sig)
{
  102460:	55                   	push   %ebp
  102461:	57                   	push   %edi
  102462:	56                   	push   %esi
  102463:	53                   	push   %ebx
  102464:	e8 39 df ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102469:	81 c3 8b eb 00 00    	add    $0xeb8b,%ebx
  10246f:	83 ec 1c             	sub    $0x1c,%esp
  102472:	8b 7c 24 30          	mov    0x30(%esp),%edi
    KERN_ASSERT(rsdt != NULL);
  102476:	85 ff                	test   %edi,%edi
  102478:	74 62                	je     1024dc <acpi_probe_rsdt_ent+0x7c>

    uint8_t *p = (uint8_t *) &rsdt->ent[0];
  10247a:	8d 57 24             	lea    0x24(%edi),%edx
    uint8_t *e = (uint8_t *) rsdt + rsdt->length;
  10247d:	03 7f 04             	add    0x4(%edi),%edi

    int i;
    for (i = 0; p < e; i++) {
  102480:	39 fa                	cmp    %edi,%edx
  102482:	73 4c                	jae    1024d0 <acpi_probe_rsdt_ent+0x70>
  102484:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  102488:	eb 0d                	jmp    102497 <acpi_probe_rsdt_ent+0x37>
  10248a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102490:	83 c2 04             	add    $0x4,%edx
  102493:	39 fa                	cmp    %edi,%edx
  102495:	73 39                	jae    1024d0 <acpi_probe_rsdt_ent+0x70>
        acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *) (rsdt->ent[i]);
  102497:	8b 02                	mov    (%edx),%eax
  102499:	89 c5                	mov    %eax,%ebp
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  10249b:	39 18                	cmp    %ebx,(%eax)
  10249d:	75 f1                	jne    102490 <acpi_probe_rsdt_ent+0x30>
  10249f:	8b 70 04             	mov    0x4(%eax),%esi
    for (i = 0; i < len; i++) {
  1024a2:	85 f6                	test   %esi,%esi
  1024a4:	7e 1e                	jle    1024c4 <acpi_probe_rsdt_ent+0x64>
    sum = 0;
  1024a6:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1024aa:	01 c6                	add    %eax,%esi
  1024ac:	31 c9                	xor    %ecx,%ecx
  1024ae:	66 90                	xchg   %ax,%ax
        sum += addr[i];
  1024b0:	0f b6 38             	movzbl (%eax),%edi
    for (i = 0; i < len; i++) {
  1024b3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1024b6:	01 f9                	add    %edi,%ecx
    for (i = 0; i < len; i++) {
  1024b8:	39 c6                	cmp    %eax,%esi
  1024ba:	75 f4                	jne    1024b0 <acpi_probe_rsdt_ent+0x50>
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1024bc:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  1024c0:	84 c9                	test   %cl,%cl
  1024c2:	75 cc                	jne    102490 <acpi_probe_rsdt_ent+0x30>
        }
        p = (uint8_t *) &rsdt->ent[i + 1];
    }

    return NULL;
}
  1024c4:	83 c4 1c             	add    $0x1c,%esp
  1024c7:	89 e8                	mov    %ebp,%eax
  1024c9:	5b                   	pop    %ebx
  1024ca:	5e                   	pop    %esi
  1024cb:	5f                   	pop    %edi
  1024cc:	5d                   	pop    %ebp
  1024cd:	c3                   	ret
  1024ce:	66 90                	xchg   %ax,%ax
  1024d0:	83 c4 1c             	add    $0x1c,%esp
    return NULL;
  1024d3:	31 ed                	xor    %ebp,%ebp
}
  1024d5:	5b                   	pop    %ebx
  1024d6:	89 e8                	mov    %ebp,%eax
  1024d8:	5e                   	pop    %esi
  1024d9:	5f                   	pop    %edi
  1024da:	5d                   	pop    %ebp
  1024db:	c3                   	ret
    KERN_ASSERT(rsdt != NULL);
  1024dc:	8d 83 2f 82 ff ff    	lea    -0x7dd1(%ebx),%eax
  1024e2:	50                   	push   %eax
  1024e3:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1024e9:	50                   	push   %eax
  1024ea:	8d 83 1f 82 ff ff    	lea    -0x7de1(%ebx),%eax
  1024f0:	6a 41                	push   $0x41
  1024f2:	50                   	push   %eax
  1024f3:	e8 68 1c 00 00       	call   104160 <debug_panic>
  1024f8:	83 c4 10             	add    $0x10,%esp
  1024fb:	e9 7a ff ff ff       	jmp    10247a <acpi_probe_rsdt_ent+0x1a>

00102500 <acpi_probe_xsdt>:

acpi_xsdt_t *acpi_probe_xsdt(acpi_rsdp_t *rsdp)
{
  102500:	56                   	push   %esi
  102501:	53                   	push   %ebx
  102502:	e8 9b de ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102507:	81 c3 ed ea 00 00    	add    $0xeaed,%ebx
  10250d:	83 ec 04             	sub    $0x4,%esp
  102510:	8b 74 24 10          	mov    0x10(%esp),%esi
    KERN_ASSERT(rsdp != NULL);
  102514:	85 f6                	test   %esi,%esi
  102516:	74 50                	je     102568 <acpi_probe_xsdt+0x68>

    acpi_xsdt_t *xsdt = (acpi_xsdt_t *) (uintptr_t) rsdp->xsdt_addr;
  102518:	8b 5e 18             	mov    0x18(%esi),%ebx
  10251b:	89 d8                	mov    %ebx,%eax
    if (xsdt == NULL)
  10251d:	85 db                	test   %ebx,%ebx
  10251f:	74 2a                	je     10254b <acpi_probe_xsdt+0x4b>
        return NULL;
    if (xsdt->sig == ACPI_XSDT_SIG && sum((uint8_t *) xsdt, xsdt->length) == 0) {
  102521:	81 3b 58 53 44 54    	cmpl   $0x54445358,(%ebx)
  102527:	75 2f                	jne    102558 <acpi_probe_xsdt+0x58>
  102529:	8b 73 04             	mov    0x4(%ebx),%esi
    for (i = 0; i < len; i++) {
  10252c:	85 f6                	test   %esi,%esi
  10252e:	7e 1b                	jle    10254b <acpi_probe_xsdt+0x4b>
  102530:	01 de                	add    %ebx,%esi
    sum = 0;
  102532:	31 d2                	xor    %edx,%edx
  102534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sum += addr[i];
  102538:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++) {
  10253b:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  10253e:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++) {
  102540:	39 c6                	cmp    %eax,%esi
  102542:	75 f4                	jne    102538 <acpi_probe_xsdt+0x38>
        return NULL;
  102544:	31 c0                	xor    %eax,%eax
  102546:	84 d2                	test   %dl,%dl
  102548:	0f 45 d8             	cmovne %eax,%ebx
        return xsdt;
    }

    return NULL;
}
  10254b:	83 c4 04             	add    $0x4,%esp
  10254e:	89 d8                	mov    %ebx,%eax
  102550:	5b                   	pop    %ebx
  102551:	5e                   	pop    %esi
  102552:	c3                   	ret
  102553:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        return NULL;
  102558:	31 db                	xor    %ebx,%ebx
}
  10255a:	83 c4 04             	add    $0x4,%esp
  10255d:	89 d8                	mov    %ebx,%eax
  10255f:	5b                   	pop    %ebx
  102560:	5e                   	pop    %esi
  102561:	c3                   	ret
  102562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(rsdp != NULL);
  102568:	8d 83 12 82 ff ff    	lea    -0x7dee(%ebx),%eax
  10256e:	50                   	push   %eax
  10256f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  102575:	50                   	push   %eax
  102576:	8d 83 1f 82 ff ff    	lea    -0x7de1(%ebx),%eax
  10257c:	6a 54                	push   $0x54
  10257e:	50                   	push   %eax
  10257f:	e8 dc 1b 00 00       	call   104160 <debug_panic>
  102584:	83 c4 10             	add    $0x10,%esp
  102587:	eb 8f                	jmp    102518 <acpi_probe_xsdt+0x18>
  102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102590 <acpi_probe_xsdt_ent>:

acpi_sdt_hdr_t *acpi_probe_xsdt_ent(acpi_xsdt_t *xsdt, const uint32_t sig)
{
  102590:	55                   	push   %ebp
  102591:	57                   	push   %edi
  102592:	56                   	push   %esi
  102593:	53                   	push   %ebx
  102594:	e8 09 de ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102599:	81 c3 5b ea 00 00    	add    $0xea5b,%ebx
  10259f:	83 ec 1c             	sub    $0x1c,%esp
  1025a2:	8b 7c 24 30          	mov    0x30(%esp),%edi
    KERN_ASSERT(xsdt != NULL);
  1025a6:	85 ff                	test   %edi,%edi
  1025a8:	74 62                	je     10260c <acpi_probe_xsdt_ent+0x7c>

    uint8_t *p = (uint8_t *) &xsdt->ent[0];
  1025aa:	8d 57 24             	lea    0x24(%edi),%edx
    uint8_t *e = (uint8_t *) xsdt + xsdt->length;
  1025ad:	03 7f 04             	add    0x4(%edi),%edi

    int i;
    for (i = 0; p < e; i++) {
  1025b0:	39 fa                	cmp    %edi,%edx
  1025b2:	73 4c                	jae    102600 <acpi_probe_xsdt_ent+0x70>
  1025b4:	8b 5c 24 34          	mov    0x34(%esp),%ebx
  1025b8:	eb 0d                	jmp    1025c7 <acpi_probe_xsdt_ent+0x37>
  1025ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1025c0:	83 c2 08             	add    $0x8,%edx
  1025c3:	39 fa                	cmp    %edi,%edx
  1025c5:	73 39                	jae    102600 <acpi_probe_xsdt_ent+0x70>
        acpi_sdt_hdr_t *hdr = (acpi_sdt_hdr_t *) (uintptr_t) xsdt->ent[i];
  1025c7:	8b 02                	mov    (%edx),%eax
  1025c9:	89 c5                	mov    %eax,%ebp
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1025cb:	39 18                	cmp    %ebx,(%eax)
  1025cd:	75 f1                	jne    1025c0 <acpi_probe_xsdt_ent+0x30>
  1025cf:	8b 70 04             	mov    0x4(%eax),%esi
    for (i = 0; i < len; i++) {
  1025d2:	85 f6                	test   %esi,%esi
  1025d4:	7e 1e                	jle    1025f4 <acpi_probe_xsdt_ent+0x64>
    sum = 0;
  1025d6:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  1025da:	01 c6                	add    %eax,%esi
  1025dc:	31 c9                	xor    %ecx,%ecx
  1025de:	66 90                	xchg   %ax,%ax
        sum += addr[i];
  1025e0:	0f b6 38             	movzbl (%eax),%edi
    for (i = 0; i < len; i++) {
  1025e3:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  1025e6:	01 f9                	add    %edi,%ecx
    for (i = 0; i < len; i++) {
  1025e8:	39 c6                	cmp    %eax,%esi
  1025ea:	75 f4                	jne    1025e0 <acpi_probe_xsdt_ent+0x50>
        if (hdr->sig == sig && sum((uint8_t *) hdr, hdr->length) == 0) {
  1025ec:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  1025f0:	84 c9                	test   %cl,%cl
  1025f2:	75 cc                	jne    1025c0 <acpi_probe_xsdt_ent+0x30>
        }
        p = (uint8_t *) &xsdt->ent[i + 1];
    }

    return NULL;
}
  1025f4:	83 c4 1c             	add    $0x1c,%esp
  1025f7:	89 e8                	mov    %ebp,%eax
  1025f9:	5b                   	pop    %ebx
  1025fa:	5e                   	pop    %esi
  1025fb:	5f                   	pop    %edi
  1025fc:	5d                   	pop    %ebp
  1025fd:	c3                   	ret
  1025fe:	66 90                	xchg   %ax,%ax
  102600:	83 c4 1c             	add    $0x1c,%esp
    return NULL;
  102603:	31 ed                	xor    %ebp,%ebp
}
  102605:	5b                   	pop    %ebx
  102606:	89 e8                	mov    %ebp,%eax
  102608:	5e                   	pop    %esi
  102609:	5f                   	pop    %edi
  10260a:	5d                   	pop    %ebp
  10260b:	c3                   	ret
    KERN_ASSERT(xsdt != NULL);
  10260c:	8d 83 3c 82 ff ff    	lea    -0x7dc4(%ebx),%eax
  102612:	50                   	push   %eax
  102613:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  102619:	50                   	push   %eax
  10261a:	8d 83 1f 82 ff ff    	lea    -0x7de1(%ebx),%eax
  102620:	6a 62                	push   $0x62
  102622:	50                   	push   %eax
  102623:	e8 38 1b 00 00       	call   104160 <debug_panic>
  102628:	83 c4 10             	add    $0x10,%esp
  10262b:	e9 7a ff ff ff       	jmp    1025aa <acpi_probe_xsdt_ent+0x1a>

00102630 <lapic_register>:
{
}

void lapic_register(uintptr_t lapic_addr)
{
    lapic = (lapic_t *) lapic_addr;
  102630:	e8 65 dd ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  102635:	05 bf e9 00 00       	add    $0xe9bf,%eax
  10263a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10263e:	89 90 9c 88 02 00    	mov    %edx,0x2889c(%eax)
}
  102644:	c3                   	ret
  102645:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10264c:	00 
  10264d:	8d 76 00             	lea    0x0(%esi),%esi

00102650 <lapic_init>:

/*
 * Initialize local APIC.
 */
void lapic_init()
{
  102650:	55                   	push   %ebp
  102651:	57                   	push   %edi
  102652:	56                   	push   %esi
  102653:	53                   	push   %ebx
  102654:	e8 49 dd ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102659:	81 c3 9b e9 00 00    	add    $0xe99b,%ebx
  10265f:	83 ec 2c             	sub    $0x2c,%esp
    if (!lapic)
  102662:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
  102668:	8d 93 52 82 ff ff    	lea    -0x7dae(%ebx),%edx
  10266e:	89 54 24 10          	mov    %edx,0x10(%esp)
  102672:	85 c0                	test   %eax,%eax
  102674:	0f 84 9b 02 00 00    	je     102915 <lapic_init+0x2c5>
    lapic[index] = value;
  10267a:	c7 80 f0 00 00 00 27 	movl   $0x127,0xf0(%eax)
  102681:	01 00 00 
    lapic[LAPIC_ID];
  102684:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102687:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  10268e:	00 00 00 
    lapic[LAPIC_ID];
  102691:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102694:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  10269b:	00 02 00 
    lapic[LAPIC_ID];
  10269e:	8b 50 20             	mov    0x20(%eax),%edx
    int i;
    for (i = 0; i < 5; i++) {
        lapic_ticks_per_ms = lapic_calibrate_timer(CAL_LATCH, CAL_MS, CAL_PIT_LOOPS);
        if (lapic_ticks_per_ms != ~(uint32_t) 0x0)
            break;
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1026a1:	8d 93 dc 8a ff ff    	lea    -0x7524(%ebx),%edx
    for (i = 0; i < 5; i++) {
  1026a7:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1026ae:	00 
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1026af:	89 54 24 1c          	mov    %edx,0x1c(%esp)
    lapic[index] = value;
  1026b3:	c7 80 80 03 00 00 ff 	movl   $0xffffffff,0x380(%eax)
  1026ba:	ff ff ff 
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1026bd:	83 ec 0c             	sub    $0xc,%esp
    lapic[LAPIC_ID];
  1026c0:	8b 40 20             	mov    0x20(%eax),%eax
    outb(0x61, (inb(0x61) & ~0x02) | 0x01);
  1026c3:	6a 61                	push   $0x61
  1026c5:	e8 86 28 00 00       	call   104f50 <inb>
  1026ca:	5a                   	pop    %edx
  1026cb:	59                   	pop    %ecx
  1026cc:	25 fc 00 00 00       	and    $0xfc,%eax
  1026d1:	83 c8 01             	or     $0x1,%eax
  1026d4:	50                   	push   %eax
  1026d5:	6a 61                	push   $0x61
  1026d7:	e8 a4 28 00 00       	call   104f80 <outb>
    outb(0x43, 0xb0);
  1026dc:	5e                   	pop    %esi
  1026dd:	5f                   	pop    %edi
  1026de:	68 b0 00 00 00       	push   $0xb0
  1026e3:	6a 43                	push   $0x43
    timermin = ~(uint32_t) 0x0;
  1026e5:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    outb(0x43, 0xb0);
  1026ea:	e8 91 28 00 00       	call   104f80 <outb>
    outb(0x42, latch & 0xff);
  1026ef:	5d                   	pop    %ebp
  1026f0:	58                   	pop    %eax
  1026f1:	68 9b 00 00 00       	push   $0x9b
  1026f6:	6a 42                	push   $0x42
    timermax = 0;
  1026f8:	31 ed                	xor    %ebp,%ebp
    outb(0x42, latch & 0xff);
  1026fa:	e8 81 28 00 00       	call   104f80 <outb>
    outb(0x42, latch >> 8);
  1026ff:	58                   	pop    %eax
  102700:	5a                   	pop    %edx
  102701:	6a 2e                	push   $0x2e
  102703:	6a 42                	push   $0x42
  102705:	e8 76 28 00 00       	call   104f80 <outb>
    return lapic[index];
  10270a:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
    while ((inb(0x61) & 0x20) == 0) {
  102710:	83 c4 10             	add    $0x10,%esp
    pitcnt = 0;
  102713:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10271a:	00 
    return lapic[index];
  10271b:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
    while ((inb(0x61) & 0x20) == 0) {
  102721:	89 44 24 18          	mov    %eax,0x18(%esp)
    timer = timer1 = timer2 = lapic_read(LAPIC_TCCR);
  102725:	89 c6                	mov    %eax,%esi
  102727:	89 e8                	mov    %ebp,%eax
  102729:	89 fd                	mov    %edi,%ebp
  10272b:	89 c7                	mov    %eax,%edi
    while ((inb(0x61) & 0x20) == 0) {
  10272d:	eb 20                	jmp    10274f <lapic_init+0xff>
  10272f:	90                   	nop
    return lapic[index];
  102730:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
  102736:	8b 80 90 03 00 00    	mov    0x390(%eax),%eax
        delta = timer - timer2;
  10273c:	29 c6                	sub    %eax,%esi
        if (delta < timermin)
  10273e:	39 f5                	cmp    %esi,%ebp
  102740:	0f 47 ee             	cmova  %esi,%ebp
        if (delta > timermax)
  102743:	39 f7                	cmp    %esi,%edi
  102745:	0f 42 fe             	cmovb  %esi,%edi
        pitcnt++;
  102748:	83 44 24 0c 01       	addl   $0x1,0xc(%esp)
        timer = timer2;
  10274d:	89 c6                	mov    %eax,%esi
    while ((inb(0x61) & 0x20) == 0) {
  10274f:	83 ec 0c             	sub    $0xc,%esp
  102752:	6a 61                	push   $0x61
  102754:	e8 f7 27 00 00       	call   104f50 <inb>
  102759:	83 c4 10             	add    $0x10,%esp
  10275c:	a8 20                	test   $0x20,%al
  10275e:	74 d0                	je     102730 <lapic_init+0xe0>
    if (pitcnt < loopmin || timermax > 10 * timermin)
  102760:	81 7c 24 0c e7 03 00 	cmpl   $0x3e7,0xc(%esp)
  102767:	00 
  102768:	89 fa                	mov    %edi,%edx
  10276a:	8b 44 24 18          	mov    0x18(%esp),%eax
  10276e:	89 ef                	mov    %ebp,%edi
  102770:	0f 8e 3a 01 00 00    	jle    1028b0 <lapic_init+0x260>
  102776:	8d 0c bf             	lea    (%edi,%edi,4),%ecx
  102779:	01 c9                	add    %ecx,%ecx
  10277b:	39 d1                	cmp    %edx,%ecx
  10277d:	0f 82 2d 01 00 00    	jb     1028b0 <lapic_init+0x260>
    delta = timer1 - timer2;
  102783:	29 f0                	sub    %esi,%eax
    return delta / ms;
  102785:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    if (lapic_ticks_per_ms == ~(uint32_t) 0x0) {
        KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
        KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
        lapic_ticks_per_ms = 500000;
    } else
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  10278a:	83 ec 0c             	sub    $0xc,%esp
    return delta / ms;
  10278d:	f7 e2                	mul    %edx
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  10278f:	b8 e8 03 00 00       	mov    $0x3e8,%eax
    return delta / ms;
  102794:	c1 ea 03             	shr    $0x3,%edx
  102797:	89 d6                	mov    %edx,%esi
        KERN_DEBUG("LAPIC timer freq = %llu Hz.\n",
  102799:	f7 e2                	mul    %edx
  10279b:	52                   	push   %edx
  10279c:	50                   	push   %eax
  10279d:	8d 83 63 82 ff ff    	lea    -0x7d9d(%ebx),%eax
  1027a3:	50                   	push   %eax
  1027a4:	6a 7d                	push   $0x7d
  1027a6:	ff 74 24 2c          	push   0x2c(%esp)
  1027aa:	e8 51 19 00 00       	call   104100 <debug_normal>
                   (uint64_t) lapic_ticks_per_ms * 1000);

    uint32_t ticr = lapic_ticks_per_ms * 1000 / LAPIC_TIMER_INTR_FREQ;
  1027af:	69 d6 e8 03 00 00    	imul   $0x3e8,%esi,%edx
  1027b5:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
  1027ba:	83 c4 20             	add    $0x20,%esp
  1027bd:	f7 e2                	mul    %edx
  1027bf:	c1 ea 06             	shr    $0x6,%edx
  1027c2:	89 d6                	mov    %edx,%esi
    KERN_DEBUG("Set LAPIC TICR = %x.\n", ticr);
  1027c4:	8d 83 80 82 ff ff    	lea    -0x7d80(%ebx),%eax
  1027ca:	56                   	push   %esi
  1027cb:	50                   	push   %eax
  1027cc:	68 81 00 00 00       	push   $0x81
  1027d1:	ff 74 24 1c          	push   0x1c(%esp)
  1027d5:	e8 26 19 00 00       	call   104100 <debug_normal>
    lapic[index] = value;
  1027da:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
    lapic_write(LAPIC_LINT0, LAPIC_LINT_MASKED);
    lapic_write(LAPIC_LINT1, LAPIC_LINT_MASKED);

    // Disable performance counter overflow interrupts
    // on machines that provide that interrupt entry.
    if (((lapic_read(LAPIC_VER) >> 16) & 0xFF) >= 4)
  1027e0:	83 c4 10             	add    $0x10,%esp
    lapic[index] = value;
  1027e3:	89 b0 80 03 00 00    	mov    %esi,0x380(%eax)
    lapic[LAPIC_ID];
  1027e9:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1027ec:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  1027f3:	00 01 00 
    lapic[LAPIC_ID];
  1027f6:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  1027f9:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  102800:	00 01 00 
    lapic[LAPIC_ID];
  102803:	8b 50 20             	mov    0x20(%eax),%edx
    return lapic[index];
  102806:	8b 50 30             	mov    0x30(%eax),%edx
    if (((lapic_read(LAPIC_VER) >> 16) & 0xFF) >= 4)
  102809:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
  10280f:	74 0d                	je     10281e <lapic_init+0x1ce>
    lapic[index] = value;
  102811:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  102818:	00 01 00 
    lapic[LAPIC_ID];
  10281b:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10281e:	c7 80 e0 00 00 00 00 	movl   $0xf0000000,0xe0(%eax)
  102825:	00 00 f0 
    lapic[LAPIC_ID];
  102828:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10282b:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%eax)
  102832:	00 00 00 
    lapic[LAPIC_ID];
  102835:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102838:	c7 80 70 03 00 00 32 	movl   $0x32,0x370(%eax)
  10283f:	00 00 00 
    lapic[LAPIC_ID];
  102842:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102845:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  10284c:	00 00 00 
    lapic[LAPIC_ID];
  10284f:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102852:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  102859:	00 00 00 
    lapic[LAPIC_ID];
  10285c:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10285f:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  102866:	00 00 00 
    lapic[LAPIC_ID];
  102869:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  10286c:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  102873:	00 00 00 
    lapic[LAPIC_ID];
  102876:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102879:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  102880:	85 08 00 
    lapic[LAPIC_ID];
  102883:	8b 50 20             	mov    0x20(%eax),%edx

    // Send an Init Level De-Assert to synchronise arbitration ID's.
    lapic_write(LAPIC_ICRHI, 0);
    lapic_write(LAPIC_ICRLO,
                LAPIC_ICRLO_BCAST | LAPIC_ICRLO_INIT | LAPIC_ICRLO_LEVEL);
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS);
  102886:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10288d:	00 
  10288e:	66 90                	xchg   %ax,%ax
    return lapic[index];
  102890:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS);
  102896:	80 e6 10             	and    $0x10,%dh
  102899:	75 f5                	jne    102890 <lapic_init+0x240>
    lapic[index] = value;
  10289b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  1028a2:	00 00 00 
    lapic[LAPIC_ID];
  1028a5:	8b 40 20             	mov    0x20(%eax),%eax

    // Enable interrupts on the APIC (but not on the processor).
    lapic_write(LAPIC_TPR, 0);
}
  1028a8:	83 c4 2c             	add    $0x2c,%esp
  1028ab:	5b                   	pop    %ebx
  1028ac:	5e                   	pop    %esi
  1028ad:	5f                   	pop    %edi
  1028ae:	5d                   	pop    %ebp
  1028af:	c3                   	ret
        KERN_DEBUG("[%d] Retry to calibrate internal timer of LAPIC.\n", i);
  1028b0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1028b4:	57                   	push   %edi
  1028b5:	ff 74 24 20          	push   0x20(%esp)
  1028b9:	6a 75                	push   $0x75
  1028bb:	ff 74 24 1c          	push   0x1c(%esp)
  1028bf:	e8 3c 18 00 00       	call   104100 <debug_normal>
    for (i = 0; i < 5; i++) {
  1028c4:	89 f8                	mov    %edi,%eax
  1028c6:	83 c0 01             	add    $0x1,%eax
  1028c9:	89 44 24 24          	mov    %eax,0x24(%esp)
  1028cd:	83 c4 10             	add    $0x10,%esp
  1028d0:	83 f8 05             	cmp    $0x5,%eax
  1028d3:	74 0b                	je     1028e0 <lapic_init+0x290>
    lapic[index] = value;
  1028d5:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
  1028db:	e9 d3 fd ff ff       	jmp    1026b3 <lapic_init+0x63>
        KERN_WARN("Failed to calibrate internal timer of LAPIC.\n");
  1028e0:	83 ec 04             	sub    $0x4,%esp
  1028e3:	8d 83 10 8b ff ff    	lea    -0x74f0(%ebx),%eax
  1028e9:	be 20 a1 07 00       	mov    $0x7a120,%esi
  1028ee:	50                   	push   %eax
  1028ef:	6a 79                	push   $0x79
  1028f1:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  1028f5:	57                   	push   %edi
  1028f6:	e8 75 19 00 00       	call   104270 <debug_warn>
        KERN_DEBUG("Assume LAPIC timer freq = 0.5 GHz.\n");
  1028fb:	83 c4 0c             	add    $0xc,%esp
  1028fe:	8d 83 40 8b ff ff    	lea    -0x74c0(%ebx),%eax
  102904:	50                   	push   %eax
  102905:	6a 7a                	push   $0x7a
  102907:	57                   	push   %edi
  102908:	e8 f3 17 00 00       	call   104100 <debug_normal>
        lapic_ticks_per_ms = 500000;
  10290d:	83 c4 10             	add    $0x10,%esp
  102910:	e9 af fe ff ff       	jmp    1027c4 <lapic_init+0x174>
        KERN_PANIC("NO LAPIC");
  102915:	83 ec 04             	sub    $0x4,%esp
  102918:	8d 83 49 82 ff ff    	lea    -0x7db7(%ebx),%eax
  10291e:	50                   	push   %eax
  10291f:	6a 62                	push   $0x62
  102921:	ff 74 24 1c          	push   0x1c(%esp)
  102925:	e8 36 18 00 00       	call   104160 <debug_panic>
    lapic[index] = value;
  10292a:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
  102930:	83 c4 10             	add    $0x10,%esp
  102933:	e9 42 fd ff ff       	jmp    10267a <lapic_init+0x2a>
  102938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10293f:	00 

00102940 <lapic_eoi>:
/*
 * Acknowledge the end of interrupts.
 */
void lapic_eoi(void)
{
    if (lapic)
  102940:	e8 55 da ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  102945:	05 af e6 00 00       	add    $0xe6af,%eax
  10294a:	8b 80 9c 88 02 00    	mov    0x2889c(%eax),%eax
  102950:	85 c0                	test   %eax,%eax
  102952:	74 0d                	je     102961 <lapic_eoi+0x21>
    lapic[index] = value;
  102954:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  10295b:	00 00 00 
    lapic[LAPIC_ID];
  10295e:	8b 40 20             	mov    0x20(%eax),%eax
        lapic_write(LAPIC_EOI, 0);
}
  102961:	c3                   	ret
  102962:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102969:	00 
  10296a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102970 <lapic_startcpu>:
/*
 * Start additional processor running bootstrap code at addr.
 * See Appendix B of MultiProcessor Specification.
 */
void lapic_startcpu(lapicid_t apicid, uintptr_t addr)
{
  102970:	57                   	push   %edi
  102971:	56                   	push   %esi
  102972:	53                   	push   %ebx
  102973:	8b 74 24 14          	mov    0x14(%esp),%esi
  102977:	e8 26 da ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10297c:	81 c3 78 e6 00 00    	add    $0xe678,%ebx
  102982:	8b 7c 24 10          	mov    0x10(%esp),%edi
    uint16_t *wrv;

    // "The BSP must initialize CMOS shutdown code to 0AH
    // and the warm reset vector (DWORD based at 40:67) to point at
    // the AP startup code prior to the [universal startup algorithm]."
    outb(IO_RTC, 0xF);                      // offset 0xF is shutdown code
  102986:	83 ec 08             	sub    $0x8,%esp
    lapic[index] = value;
  102989:	c1 e7 18             	shl    $0x18,%edi
    outb(IO_RTC, 0xF);                      // offset 0xF is shutdown code
  10298c:	6a 0f                	push   $0xf
  10298e:	6a 70                	push   $0x70
  102990:	e8 eb 25 00 00       	call   104f80 <outb>
    outb(IO_RTC + 1, 0x0A);
  102995:	58                   	pop    %eax
  102996:	5a                   	pop    %edx
  102997:	6a 0a                	push   $0xa
  102999:	6a 71                	push   $0x71
  10299b:	e8 e0 25 00 00       	call   104f80 <outb>
    wrv = (uint16_t *) (0x40 << 4 | 0x67);  // Warm reset vector
    wrv[0] = 0;
    wrv[1] = addr >> 4;
  1029a0:	89 f0                	mov    %esi,%eax
    // when it is in the halted state due to an INIT. So the second
    // should be ignored, but it is part of the official Intel algorithm.
    // Bochs complains about the second one. Too bad for Bochs.
    for (i = 0; i < 2; i++) {
        lapic_write(LAPIC_ICRHI, apicid << 24);
        lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr >> 12));
  1029a2:	c1 ee 0c             	shr    $0xc,%esi
        microdelay(200);
    }
}
  1029a5:	83 c4 10             	add    $0x10,%esp
    wrv[1] = addr >> 4;
  1029a8:	c1 e8 04             	shr    $0x4,%eax
        lapic_write(LAPIC_ICRLO, LAPIC_ICRLO_STARTUP | (addr >> 12));
  1029ab:	81 ce 00 06 00 00    	or     $0x600,%esi
    wrv[0] = 0;
  1029b1:	31 c9                	xor    %ecx,%ecx
    wrv[1] = addr >> 4;
  1029b3:	66 a3 69 04 00 00    	mov    %ax,0x469
    lapic[index] = value;
  1029b9:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
    wrv[0] = 0;
  1029bf:	66 89 0d 67 04 00 00 	mov    %cx,0x467
    lapic[index] = value;
  1029c6:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  1029cc:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1029cf:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
  1029d6:	c5 00 00 
    lapic[LAPIC_ID];
  1029d9:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1029dc:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
  1029e3:	85 00 00 
    lapic[LAPIC_ID];
  1029e6:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1029e9:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  1029ef:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1029f2:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
    lapic[LAPIC_ID];
  1029f8:	8b 48 20             	mov    0x20(%eax),%ecx
    lapic[index] = value;
  1029fb:	89 b8 10 03 00 00    	mov    %edi,0x310(%eax)
    lapic[LAPIC_ID];
  102a01:	8b 50 20             	mov    0x20(%eax),%edx
    lapic[index] = value;
  102a04:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
}
  102a0a:	5b                   	pop    %ebx
    lapic[LAPIC_ID];
  102a0b:	8b 40 20             	mov    0x20(%eax),%eax
}
  102a0e:	5e                   	pop    %esi
  102a0f:	5f                   	pop    %edi
  102a10:	c3                   	ret
  102a11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102a18:	00 
  102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102a20 <lapic_read_debug>:
    return lapic[index];
  102a20:	e8 75 d9 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  102a25:	05 cf e5 00 00       	add    $0xe5cf,%eax
  102a2a:	8b 54 24 04          	mov    0x4(%esp),%edx
  102a2e:	8b 80 9c 88 02 00    	mov    0x2889c(%eax),%eax
  102a34:	8d 04 90             	lea    (%eax,%edx,4),%eax
  102a37:	8b 00                	mov    (%eax),%eax

uint32_t lapic_read_debug(int index)
{
    return lapic_read(index);
}
  102a39:	c3                   	ret
  102a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102a40 <lapic_send_ipi>:
/*
 * Send an IPI.
 */
void lapic_send_ipi(lapicid_t apicid, uint8_t vector,
                    uint32_t deliver_mode, uint32_t shorthand_mode)
{
  102a40:	55                   	push   %ebp
  102a41:	57                   	push   %edi
  102a42:	56                   	push   %esi
  102a43:	53                   	push   %ebx
  102a44:	e8 59 d9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102a49:	81 c3 ab e5 00 00    	add    $0xe5ab,%ebx
  102a4f:	83 ec 0c             	sub    $0xc,%esp
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102a52:	8b 44 24 28          	mov    0x28(%esp),%eax
{
  102a56:	8b 6c 24 20          	mov    0x20(%esp),%ebp
  102a5a:	8b 74 24 24          	mov    0x24(%esp),%esi
  102a5e:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102a62:	2d 00 05 00 00       	sub    $0x500,%eax
  102a67:	a9 ff fe ff ff       	test   $0xfffffeff,%eax
  102a6c:	74 5a                	je     102ac8 <lapic_send_ipi+0x88>
                deliver_mode != LAPIC_ICRLO_STARTUP);
    KERN_ASSERT(vector >= T_IPI0);
  102a6e:	89 f0                	mov    %esi,%eax
  102a70:	3c 3e                	cmp    $0x3e,%al
  102a72:	77 11                	ja     102a85 <lapic_send_ipi+0x45>
  102a74:	eb 7a                	jmp    102af0 <lapic_send_ipi+0xb0>
  102a76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102a7d:	00 
  102a7e:	66 90                	xchg   %ax,%ax

    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
        pause();
  102a80:	e8 2b 23 00 00       	call   104db0 <pause>
    return lapic[index];
  102a85:	8b 83 9c 88 02 00    	mov    0x2889c(%ebx),%eax
  102a8b:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
    while (lapic_read(LAPIC_ICRLO) & LAPIC_ICRLO_DELIVS)
  102a91:	80 e6 10             	and    $0x10,%dh
  102a94:	75 ea                	jne    102a80 <lapic_send_ipi+0x40>

    if (shorthand_mode == LAPIC_ICRLO_NOBCAST)
  102a96:	85 ff                	test   %edi,%edi
  102a98:	75 0c                	jne    102aa6 <lapic_send_ipi+0x66>
    lapic[index] = value;
  102a9a:	c1 e5 18             	shl    $0x18,%ebp
  102a9d:	89 a8 10 03 00 00    	mov    %ebp,0x310(%eax)
    lapic[LAPIC_ID];
  102aa3:	8b 50 20             	mov    0x20(%eax),%edx
        lapic_write(LAPIC_ICRHI,
                    (apicid << LAPIC_ICRHI_DEST_SHIFT) & LAPIC_ICRHI_DEST_MASK);

    lapic_write(LAPIC_ICRLO,
                shorthand_mode |  /* LAPIC_ICRLO_LEVEL | */
                deliver_mode | (vector & LAPIC_ICRLO_VECTOR));
  102aa6:	89 f1                	mov    %esi,%ecx
  102aa8:	0f b6 f1             	movzbl %cl,%esi
  102aab:	09 fe                	or     %edi,%esi
  102aad:	0b 74 24 28          	or     0x28(%esp),%esi
    lapic[index] = value;
  102ab1:	89 b0 00 03 00 00    	mov    %esi,0x300(%eax)
    lapic[LAPIC_ID];
  102ab7:	8b 40 20             	mov    0x20(%eax),%eax
}
  102aba:	83 c4 0c             	add    $0xc,%esp
  102abd:	5b                   	pop    %ebx
  102abe:	5e                   	pop    %esi
  102abf:	5f                   	pop    %edi
  102ac0:	5d                   	pop    %ebp
  102ac1:	c3                   	ret
  102ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102ac8:	8d 83 64 8b ff ff    	lea    -0x749c(%ebx),%eax
  102ace:	50                   	push   %eax
  102acf:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  102ad5:	50                   	push   %eax
  102ad6:	8d 83 52 82 ff ff    	lea    -0x7dae(%ebx),%eax
  102adc:	68 e4 00 00 00       	push   $0xe4
  102ae1:	50                   	push   %eax
  102ae2:	e8 79 16 00 00       	call   104160 <debug_panic>
    KERN_ASSERT(vector >= T_IPI0);
  102ae7:	89 f0                	mov    %esi,%eax
    KERN_ASSERT(deliver_mode != LAPIC_ICRLO_INIT &&
  102ae9:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(vector >= T_IPI0);
  102aec:	3c 3e                	cmp    $0x3e,%al
  102aee:	77 95                	ja     102a85 <lapic_send_ipi+0x45>
  102af0:	8d 83 96 82 ff ff    	lea    -0x7d6a(%ebx),%eax
  102af6:	50                   	push   %eax
  102af7:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  102afd:	50                   	push   %eax
  102afe:	8d 83 52 82 ff ff    	lea    -0x7dae(%ebx),%eax
  102b04:	68 e6 00 00 00       	push   $0xe6
  102b09:	50                   	push   %eax
  102b0a:	e8 51 16 00 00       	call   104160 <debug_panic>
  102b0f:	83 c4 10             	add    $0x10,%esp
    return lapic[index];
  102b12:	e9 6e ff ff ff       	jmp    102a85 <lapic_send_ipi+0x45>
  102b17:	66 90                	xchg   %ax,%ax
  102b19:	66 90                	xchg   %ax,%ax
  102b1b:	66 90                	xchg   %ax,%ax
  102b1d:	66 90                	xchg   %ax,%ax
  102b1f:	90                   	nop

00102b20 <ioapic_register>:
    base->reg = reg;
    base->data = data;
}

void ioapic_register(uintptr_t addr, lapicid_t id, int g)
{
  102b20:	53                   	push   %ebx
  102b21:	e8 7c d8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102b26:	81 c3 ce e4 00 00    	add    $0xe4ce,%ebx
  102b2c:	83 ec 08             	sub    $0x8,%esp
  102b2f:	8b 54 24 14          	mov    0x14(%esp),%edx
    if (ioapic_num >= MAX_IOAPIC) {
  102b33:	8b 83 ac 88 02 00    	mov    0x288ac(%ebx),%eax
  102b39:	83 f8 0f             	cmp    $0xf,%eax
  102b3c:	7f 4a                	jg     102b88 <ioapic_register+0x68>
        KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n", MAX_IOAPIC);
        return;
    }

    ioapics[ioapic_num] = (ioapic_t *) addr;
  102b3e:	8b 83 ac 88 02 00    	mov    0x288ac(%ebx),%eax
  102b44:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  102b48:	89 8c 83 2c 89 02 00 	mov    %ecx,0x2892c(%ebx,%eax,4)
    ioapicid[ioapic_num] = id;
  102b4f:	8b 83 ac 88 02 00    	mov    0x288ac(%ebx),%eax
    gsi[ioapic_num] = g;
  102b55:	8b 4c 24 18          	mov    0x18(%esp),%ecx
    ioapicid[ioapic_num] = id;
  102b59:	88 94 03 0c 89 02 00 	mov    %dl,0x2890c(%ebx,%eax,1)
    gsi[ioapic_num] = g;
  102b60:	8b 93 ac 88 02 00    	mov    0x288ac(%ebx),%edx
  102b66:	8d 83 cc 88 02 00    	lea    0x288cc(%ebx),%eax
  102b6c:	89 0c 90             	mov    %ecx,(%eax,%edx,4)

    ioapic_num++;
  102b6f:	8b 83 ac 88 02 00    	mov    0x288ac(%ebx),%eax
  102b75:	83 c0 01             	add    $0x1,%eax
  102b78:	89 83 ac 88 02 00    	mov    %eax,0x288ac(%ebx)
}
  102b7e:	83 c4 08             	add    $0x8,%esp
  102b81:	5b                   	pop    %ebx
  102b82:	c3                   	ret
  102b83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        KERN_WARN("CertiKOS cannot manipulate more than %d IOAPICs.\n", MAX_IOAPIC);
  102b88:	8d 83 ac 8b ff ff    	lea    -0x7454(%ebx),%eax
  102b8e:	6a 10                	push   $0x10
  102b90:	50                   	push   %eax
  102b91:	8d 83 a7 82 ff ff    	lea    -0x7d59(%ebx),%eax
  102b97:	6a 1f                	push   $0x1f
  102b99:	50                   	push   %eax
  102b9a:	e8 d1 16 00 00       	call   104270 <debug_warn>
        return;
  102b9f:	83 c4 10             	add    $0x10,%esp
}
  102ba2:	83 c4 08             	add    $0x8,%esp
  102ba5:	5b                   	pop    %ebx
  102ba6:	c3                   	ret
  102ba7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102bae:	00 
  102baf:	90                   	nop

00102bb0 <ioapic_init>:

void ioapic_init(void)
{
    int i;
    for (i = 0; i < ioapic_num; i++) {
  102bb0:	e8 ae 02 00 00       	call   102e63 <__x86.get_pc_thunk.cx>
  102bb5:	81 c1 3f e4 00 00    	add    $0xe43f,%ecx
{
  102bbb:	55                   	push   %ebp
  102bbc:	57                   	push   %edi
  102bbd:	56                   	push   %esi
  102bbe:	53                   	push   %ebx
  102bbf:	83 ec 1c             	sub    $0x1c,%esp
    for (i = 0; i < ioapic_num; i++) {
  102bc2:	8b 81 ac 88 02 00    	mov    0x288ac(%ecx),%eax
  102bc8:	89 0c 24             	mov    %ecx,(%esp)
  102bcb:	85 c0                	test   %eax,%eax
  102bcd:	0f 8e ec 00 00 00    	jle    102cbf <ioapic_init+0x10f>
  102bd3:	89 c8                	mov    %ecx,%eax
  102bd5:	31 ff                	xor    %edi,%edi
  102bd7:	8d 89 0c 89 02 00    	lea    0x2890c(%ecx),%ecx
        volatile ioapic_t *ioapic = ioapics[i];
        KERN_ASSERT(ioapic != NULL);
  102bdd:	8d 98 b9 82 ff ff    	lea    -0x7d47(%eax),%ebx
  102be3:	8d 80 b5 80 ff ff    	lea    -0x7f4b(%eax),%eax
  102be9:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  102bed:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        volatile ioapic_t *ioapic = ioapics[i];
  102bf8:	8b 04 24             	mov    (%esp),%eax
  102bfb:	8b b4 b8 2c 89 02 00 	mov    0x2892c(%eax,%edi,4),%esi
        KERN_ASSERT(ioapic != NULL);
  102c02:	85 f6                	test   %esi,%esi
  102c04:	0f 84 c6 00 00 00    	je     102cd0 <ioapic_init+0x120>
    base->reg = reg;
  102c0a:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
    return base->data;
  102c10:	8b 46 10             	mov    0x10(%esi),%eax

        lapicid_t id = ioapic_read(ioapic, IOAPIC_ID) >> 24;
        if (id == 0) {
  102c13:	c1 e8 18             	shr    $0x18,%eax
  102c16:	75 14                	jne    102c2c <ioapic_init+0x7c>
            // I/O APIC ID not initialized yet - have to do it ourselves.
            ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  102c18:	0f b6 04 39          	movzbl (%ecx,%edi,1),%eax
    base->reg = reg;
  102c1c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
            ioapic_write(ioapic, IOAPIC_ID, ioapicid[i] << 24);
  102c22:	c1 e0 18             	shl    $0x18,%eax
    base->data = data;
  102c25:	89 46 10             	mov    %eax,0x10(%esi)
            id = ioapicid[i];
  102c28:	0f b6 04 39          	movzbl (%ecx,%edi,1),%eax
        }

        if (id != ioapicid[i])
  102c2c:	0f b6 14 39          	movzbl (%ecx,%edi,1),%edx
  102c30:	38 c2                	cmp    %al,%dl
  102c32:	74 30                	je     102c64 <ioapic_init+0xb4>
            KERN_WARN("ioapic_init: id %d != ioapicid %d\n", id, ioapicid[i]);
  102c34:	0f b6 14 39          	movzbl (%ecx,%edi,1),%edx
  102c38:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  102c3c:	0f b6 c0             	movzbl %al,%eax
  102c3f:	83 ec 0c             	sub    $0xc,%esp
  102c42:	52                   	push   %edx
  102c43:	50                   	push   %eax
  102c44:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  102c48:	8d 83 e0 8b ff ff    	lea    -0x7420(%ebx),%eax
  102c4e:	50                   	push   %eax
  102c4f:	8d 83 a7 82 ff ff    	lea    -0x7d59(%ebx),%eax
  102c55:	6a 39                	push   $0x39
  102c57:	50                   	push   %eax
  102c58:	e8 13 16 00 00       	call   104270 <debug_warn>
  102c5d:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  102c61:	83 c4 20             	add    $0x20,%esp
    base->reg = reg;
  102c64:	c7 06 01 00 00 00    	movl   $0x1,(%esi)
    return base->data;
  102c6a:	8b 6e 10             	mov    0x10(%esi),%ebp
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;

        // Mark all interrupts edge-triggered, active high, disabled,
        // and not routed to any CPUs.
        int j;
        for (j = 0; j <= maxintr; j++) {
  102c6d:	89 7c 24 04          	mov    %edi,0x4(%esp)
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102c71:	c1 ed 10             	shr    $0x10,%ebp
  102c74:	89 e8                	mov    %ebp,%eax
  102c76:	0f b6 e8             	movzbl %al,%ebp
        for (j = 0; j <= maxintr; j++) {
  102c79:	31 c0                	xor    %eax,%eax
  102c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            ioapic_write(ioapic, IOAPIC_TABLE + 2 * j,
  102c80:	8d 14 00             	lea    (%eax,%eax,1),%edx
  102c83:	8d 58 20             	lea    0x20(%eax),%ebx
        for (j = 0; j <= maxintr; j++) {
  102c86:	83 c0 01             	add    $0x1,%eax
  102c89:	8d 7a 10             	lea    0x10(%edx),%edi
  102c8c:	81 cb 00 00 01 00    	or     $0x10000,%ebx
    base->reg = reg;
  102c92:	83 c2 11             	add    $0x11,%edx
  102c95:	89 3e                	mov    %edi,(%esi)
    base->data = data;
  102c97:	89 5e 10             	mov    %ebx,0x10(%esi)
    base->reg = reg;
  102c9a:	89 16                	mov    %edx,(%esi)
    base->data = data;
  102c9c:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
        for (j = 0; j <= maxintr; j++) {
  102ca3:	39 c5                	cmp    %eax,%ebp
  102ca5:	7d d9                	jge    102c80 <ioapic_init+0xd0>
    for (i = 0; i < ioapic_num; i++) {
  102ca7:	8b 04 24             	mov    (%esp),%eax
  102caa:	8b 7c 24 04          	mov    0x4(%esp),%edi
  102cae:	8b 80 ac 88 02 00    	mov    0x288ac(%eax),%eax
  102cb4:	83 c7 01             	add    $0x1,%edi
  102cb7:	39 f8                	cmp    %edi,%eax
  102cb9:	0f 8f 39 ff ff ff    	jg     102bf8 <ioapic_init+0x48>
                         IOAPIC_INT_DISABLED | (T_IRQ0 + j));
            ioapic_write(ioapic, IOAPIC_TABLE + 2 * j + 1, 0);
        }
    }
}
  102cbf:	83 c4 1c             	add    $0x1c,%esp
  102cc2:	5b                   	pop    %ebx
  102cc3:	5e                   	pop    %esi
  102cc4:	5f                   	pop    %edi
  102cc5:	5d                   	pop    %ebp
  102cc6:	c3                   	ret
  102cc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102cce:	00 
  102ccf:	90                   	nop
  102cd0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
        KERN_ASSERT(ioapic != NULL);
  102cd4:	ff 74 24 08          	push   0x8(%esp)
  102cd8:	ff 74 24 10          	push   0x10(%esp)
  102cdc:	6a 2f                	push   $0x2f
  102cde:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  102ce2:	8d 83 a7 82 ff ff    	lea    -0x7d59(%ebx),%eax
  102ce8:	50                   	push   %eax
  102ce9:	e8 72 14 00 00       	call   104160 <debug_panic>
  102cee:	83 c4 10             	add    $0x10,%esp
  102cf1:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  102cf5:	e9 10 ff ff ff       	jmp    102c0a <ioapic_init+0x5a>
  102cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102d00 <ioapic_enable>:

void ioapic_enable(uint8_t irq, lapicid_t apicid, bool trigger_mode, bool polarity)
{
  102d00:	55                   	push   %ebp
  102d01:	57                   	push   %edi
  102d02:	56                   	push   %esi
  102d03:	53                   	push   %ebx
  102d04:	e8 99 d6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102d09:	81 c3 eb e2 00 00    	add    $0xe2eb,%ebx
  102d0f:	83 ec 2c             	sub    $0x2c,%esp
  102d12:	8b 44 24 44          	mov    0x44(%esp),%eax
  102d16:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  102d1a:	8b 7c 24 4c          	mov    0x4c(%esp),%edi
  102d1e:	89 44 24 10          	mov    %eax,0x10(%esp)
  102d22:	8b 44 24 48          	mov    0x48(%esp),%eax
  102d26:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  102d2a:	89 44 24 14          	mov    %eax,0x14(%esp)
    // Mark interrupt edge-triggered, active high,
    // enabled, and routed to the given APIC ID,
    int i;
    for (i = 0; i < ioapic_num; i++) {
  102d2e:	8b 83 ac 88 02 00    	mov    0x288ac(%ebx),%eax
  102d34:	85 c0                	test   %eax,%eax
  102d36:	0f 8e dc 00 00 00    	jle    102e18 <ioapic_enable+0x118>
            break;
        }
    }

    if (i == ioapic_num)
        KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102d3c:	0f b6 c9             	movzbl %cl,%ecx
  102d3f:	89 7c 24 18          	mov    %edi,0x18(%esp)
    for (i = 0; i < ioapic_num; i++) {
  102d43:	31 c0                	xor    %eax,%eax
  102d45:	8d b3 cc 88 02 00    	lea    0x288cc(%ebx),%esi
  102d4b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  102d4f:	90                   	nop
        ioapic_t *ioapic = ioapics[i];
  102d50:	8b 94 83 2c 89 02 00 	mov    0x2892c(%ebx,%eax,4),%edx
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102d57:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    base->reg = reg;
  102d5b:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    return base->data;
  102d61:	8b 7a 10             	mov    0x10(%edx),%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102d64:	8b 2c 86             	mov    (%esi,%eax,4),%ebp
  102d67:	39 cd                	cmp    %ecx,%ebp
  102d69:	7f 15                	jg     102d80 <ioapic_enable+0x80>
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102d6b:	c1 ef 10             	shr    $0x10,%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102d6e:	8b 2c 86             	mov    (%esi,%eax,4),%ebp
        int maxintr = (ioapic_read(ioapic, IOAPIC_VER) >> 16) & 0xFF;
  102d71:	89 f9                	mov    %edi,%ecx
  102d73:	0f b6 f9             	movzbl %cl,%edi
        if (irq >= gsi[i] && irq <= gsi[i] + maxintr) {
  102d76:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  102d7a:	01 ef                	add    %ebp,%edi
  102d7c:	39 cf                	cmp    %ecx,%edi
  102d7e:	7d 20                	jge    102da0 <ioapic_enable+0xa0>
    for (i = 0; i < ioapic_num; i++) {
  102d80:	8b 93 ac 88 02 00    	mov    0x288ac(%ebx),%edx
  102d86:	83 c0 01             	add    $0x1,%eax
  102d89:	39 c2                	cmp    %eax,%edx
  102d8b:	7f c3                	jg     102d50 <ioapic_enable+0x50>
    if (i == ioapic_num)
  102d8d:	8b 93 ac 88 02 00    	mov    0x288ac(%ebx),%edx
  102d93:	39 c2                	cmp    %eax,%edx
  102d95:	74 5b                	je     102df2 <ioapic_enable+0xf2>
}
  102d97:	83 c4 2c             	add    $0x2c,%esp
  102d9a:	5b                   	pop    %ebx
  102d9b:	5e                   	pop    %esi
  102d9c:	5f                   	pop    %edi
  102d9d:	5d                   	pop    %ebp
  102d9e:	c3                   	ret
  102d9f:	90                   	nop
                         ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102da0:	8b 7c 24 18          	mov    0x18(%esp),%edi
  102da4:	0f b6 6c 24 14       	movzbl 0x14(%esp),%ebp
  102da9:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102dad:	89 fa                	mov    %edi,%edx
  102daf:	c1 e5 0f             	shl    $0xf,%ebp
  102db2:	0f b6 fa             	movzbl %dl,%edi
                         IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102db5:	89 ca                	mov    %ecx,%edx
                         ((trigger_mode << 15) | (polarity << 13) | (T_IRQ0 + irq)));
  102db7:	c1 e7 0d             	shl    $0xd,%edi
  102dba:	09 ef                	or     %ebp,%edi
  102dbc:	8d 69 20             	lea    0x20(%ecx),%ebp
  102dbf:	09 fd                	or     %edi,%ebp
                         IOAPIC_TABLE + 2 * (irq - gsi[i]),
  102dc1:	8b 3c 86             	mov    (%esi,%eax,4),%edi
  102dc4:	29 fa                	sub    %edi,%edx
            ioapic_write(ioapic,
  102dc6:	8d 7c 12 10          	lea    0x10(%edx,%edx,1),%edi
    base->reg = reg;
  102dca:	8b 54 24 0c          	mov    0xc(%esp),%edx
  102dce:	89 3a                	mov    %edi,(%edx)
            ioapic_write(ioapic,
  102dd0:	8b 7c 24 10          	mov    0x10(%esp),%edi
    base->data = data;
  102dd4:	89 6a 10             	mov    %ebp,0x10(%edx)
                         IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102dd7:	8b 34 86             	mov    (%esi,%eax,4),%esi
            ioapic_write(ioapic,
  102dda:	c1 e7 18             	shl    $0x18,%edi
                         IOAPIC_TABLE + 2 * (irq - gsi[i]) + 1,
  102ddd:	29 f1                	sub    %esi,%ecx
            ioapic_write(ioapic,
  102ddf:	8d 4c 09 11          	lea    0x11(%ecx,%ecx,1),%ecx
    base->reg = reg;
  102de3:	89 0a                	mov    %ecx,(%edx)
    base->data = data;
  102de5:	89 7a 10             	mov    %edi,0x10(%edx)
    if (i == ioapic_num)
  102de8:	8b 93 ac 88 02 00    	mov    0x288ac(%ebx),%edx
  102dee:	39 c2                	cmp    %eax,%edx
  102df0:	75 a5                	jne    102d97 <ioapic_enable+0x97>
        KERN_PANIC("Cannot enable IRQ %d on IOAPIC.\n", irq);
  102df2:	0f b6 44 24 1c       	movzbl 0x1c(%esp),%eax
  102df7:	50                   	push   %eax
  102df8:	8d 83 04 8c ff ff    	lea    -0x73fc(%ebx),%eax
  102dfe:	50                   	push   %eax
  102dff:	8d 83 a7 82 ff ff    	lea    -0x7d59(%ebx),%eax
  102e05:	6a 5d                	push   $0x5d
  102e07:	50                   	push   %eax
  102e08:	e8 53 13 00 00       	call   104160 <debug_panic>
  102e0d:	83 c4 10             	add    $0x10,%esp
}
  102e10:	83 c4 2c             	add    $0x2c,%esp
  102e13:	5b                   	pop    %ebx
  102e14:	5e                   	pop    %esi
  102e15:	5f                   	pop    %edi
  102e16:	5d                   	pop    %ebp
  102e17:	c3                   	ret
    for (i = 0; i < ioapic_num; i++) {
  102e18:	31 c0                	xor    %eax,%eax
  102e1a:	e9 6e ff ff ff       	jmp    102d8d <ioapic_enable+0x8d>
  102e1f:	90                   	nop

00102e20 <ioapic_number>:

int ioapic_number(void)
{
    return ioapic_num;
  102e20:	e8 75 d5 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  102e25:	05 cf e1 00 00       	add    $0xe1cf,%eax
  102e2a:	8b 80 ac 88 02 00    	mov    0x288ac(%eax),%eax
}
  102e30:	c3                   	ret
  102e31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102e38:	00 
  102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102e40 <ioapic_get>:

ioapic_t *ioapic_get(uint32_t idx)
{
    if (idx >= ioapic_num)
  102e40:	e8 55 d5 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  102e45:	05 af e1 00 00       	add    $0xe1af,%eax
{
  102e4a:	8b 54 24 04          	mov    0x4(%esp),%edx
    if (idx >= ioapic_num)
  102e4e:	8b 88 ac 88 02 00    	mov    0x288ac(%eax),%ecx
  102e54:	39 ca                	cmp    %ecx,%edx
  102e56:	73 08                	jae    102e60 <ioapic_get+0x20>
        return NULL;
    return ioapics[idx];
  102e58:	8b 84 90 2c 89 02 00 	mov    0x2892c(%eax,%edx,4),%eax
  102e5f:	c3                   	ret
        return NULL;
  102e60:	31 c0                	xor    %eax,%eax
}
  102e62:	c3                   	ret

00102e63 <__x86.get_pc_thunk.cx>:
  102e63:	8b 0c 24             	mov    (%esp),%ecx
  102e66:	c3                   	ret
  102e67:	66 90                	xchg   %ax,%ax
  102e69:	66 90                	xchg   %ax,%ax
  102e6b:	66 90                	xchg   %ax,%ax
  102e6d:	66 90                	xchg   %ax,%ax
  102e6f:	90                   	nop

00102e70 <mpsearch1>:
    return sum;
}

/* Look for an MP structure in the len bytes at addr. */
static struct mp *mpsearch1(uint8_t *addr, int len)
{
  102e70:	55                   	push   %ebp
    uint8_t *e, *p;

    e = addr + len;
  102e71:	8d 2c 10             	lea    (%eax,%edx,1),%ebp
{
  102e74:	57                   	push   %edi
  102e75:	56                   	push   %esi
  102e76:	e8 aa 0d 00 00       	call   103c25 <__x86.get_pc_thunk.si>
  102e7b:	81 c6 79 e1 00 00    	add    $0xe179,%esi
  102e81:	53                   	push   %ebx
  102e82:	83 ec 1c             	sub    $0x1c,%esp
  102e85:	89 74 24 0c          	mov    %esi,0xc(%esp)
    for (p = addr; p < e; p += sizeof(struct mp))
  102e89:	39 e8                	cmp    %ebp,%eax
  102e8b:	73 5b                	jae    102ee8 <mpsearch1+0x78>
  102e8d:	89 c7                	mov    %eax,%edi
  102e8f:	8d b6 c8 82 ff ff    	lea    -0x7d38(%esi),%esi
  102e95:	eb 0f                	jmp    102ea6 <mpsearch1+0x36>
  102e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102e9e:	00 
  102e9f:	90                   	nop
  102ea0:	89 df                	mov    %ebx,%edi
  102ea2:	39 eb                	cmp    %ebp,%ebx
  102ea4:	73 42                	jae    102ee8 <mpsearch1+0x78>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102ea6:	83 ec 04             	sub    $0x4,%esp
  102ea9:	6a 04                	push   $0x4
  102eab:	56                   	push   %esi
  102eac:	57                   	push   %edi
  102ead:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  102eb1:	e8 9a 11 00 00       	call   104050 <memcmp>
  102eb6:	83 c4 10             	add    $0x10,%esp
  102eb9:	8d 5f 10             	lea    0x10(%edi),%ebx
  102ebc:	85 c0                	test   %eax,%eax
  102ebe:	75 e0                	jne    102ea0 <mpsearch1+0x30>
  102ec0:	89 fa                	mov    %edi,%edx
  102ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        sum += addr[i];
  102ec8:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < len; i++)
  102ecb:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  102ece:	01 c8                	add    %ecx,%eax
    for (i = 0; i < len; i++)
  102ed0:	39 da                	cmp    %ebx,%edx
  102ed2:	75 f4                	jne    102ec8 <mpsearch1+0x58>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102ed4:	84 c0                	test   %al,%al
  102ed6:	75 c8                	jne    102ea0 <mpsearch1+0x30>
            return (struct mp *) p;
    return 0;
}
  102ed8:	83 c4 1c             	add    $0x1c,%esp
            return (struct mp *) p;
  102edb:	89 f8                	mov    %edi,%eax
}
  102edd:	5b                   	pop    %ebx
  102ede:	5e                   	pop    %esi
  102edf:	5f                   	pop    %edi
  102ee0:	5d                   	pop    %ebp
  102ee1:	c3                   	ret
  102ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102ee8:	83 c4 1c             	add    $0x1c,%esp
    return 0;
  102eeb:	31 c0                	xor    %eax,%eax
}
  102eed:	5b                   	pop    %ebx
  102eee:	5e                   	pop    %esi
  102eef:	5f                   	pop    %edi
  102ef0:	5d                   	pop    %ebp
  102ef1:	c3                   	ret
  102ef2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102ef9:	00 
  102efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00102f00 <pcpu_mp_init>:

/*
 * Multiple processors initialization method using ACPI
 */
bool pcpu_mp_init(void)
{
  102f00:	55                   	push   %ebp
  102f01:	57                   	push   %edi
  102f02:	56                   	push   %esi
  102f03:	53                   	push   %ebx
  102f04:	e8 99 d4 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  102f09:	81 c3 eb e0 00 00    	add    $0xe0eb,%ebx
  102f0f:	83 ec 2c             	sub    $0x2c,%esp
    acpi_xsdt_t *xsdt;
    acpi_madt_t *madt;
    uint32_t ap_idx = 1;
    bool found_bsp = FALSE;

    if (mp_inited == TRUE)
  102f12:	80 bb 6d 89 02 00 01 	cmpb   $0x1,0x2896d(%ebx)
  102f19:	0f 84 92 01 00 00    	je     1030b1 <pcpu_mp_init+0x1b1>
        return TRUE;

    KERN_INFO("\n");
  102f1f:	83 ec 0c             	sub    $0xc,%esp
  102f22:	8d 83 59 85 ff ff    	lea    -0x7aa7(%ebx),%eax
  102f28:	50                   	push   %eax
  102f29:	e8 92 11 00 00       	call   1040c0 <debug_info>

    if ((rsdp = acpi_probe_rsdp()) == NULL) {
  102f2e:	e8 dd f3 ff ff       	call   102310 <acpi_probe_rsdp>
  102f33:	83 c4 10             	add    $0x10,%esp
  102f36:	89 c6                	mov    %eax,%esi
  102f38:	85 c0                	test   %eax,%eax
  102f3a:	0f 84 50 02 00 00    	je     103190 <pcpu_mp_init+0x290>
        KERN_DEBUG("Not found RSDP.\n");
        goto fallback;
    }

    xsdt = NULL;
    if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  102f40:	83 ec 0c             	sub    $0xc,%esp
  102f43:	50                   	push   %eax
  102f44:	e8 b7 f5 ff ff       	call   102500 <acpi_probe_xsdt>
  102f49:	83 c4 10             	add    $0x10,%esp
  102f4c:	85 c0                	test   %eax,%eax
  102f4e:	0f 84 dc 01 00 00    	je     103130 <pcpu_mp_init+0x230>
        goto fallback;
    }

    if ((madt =
         (xsdt != NULL) ?
         (acpi_madt_t *) acpi_probe_xsdt_ent(xsdt, ACPI_MADT_SIG) :
  102f54:	83 ec 08             	sub    $0x8,%esp
  102f57:	68 41 50 49 43       	push   $0x43495041
  102f5c:	50                   	push   %eax
  102f5d:	e8 2e f6 ff ff       	call   102590 <acpi_probe_xsdt_ent>
  102f62:	83 c4 10             	add    $0x10,%esp
  102f65:	89 c7                	mov    %eax,%edi
    if ((madt =
  102f67:	85 ff                	test   %edi,%edi
  102f69:	0f 84 61 04 00 00    	je     1033d0 <pcpu_mp_init+0x4d0>
        KERN_DEBUG("Not found MADT.\n");
        goto fallback;
    }

    ismp = TRUE;
    lapic_register(madt->lapic_addr);
  102f6f:	83 ec 0c             	sub    $0xc,%esp
  102f72:	ff 77 24             	push   0x24(%edi)
    ncpu = 0;

    p = (uint8_t *) madt->ent;
  102f75:	8d 6f 2c             	lea    0x2c(%edi),%ebp
    ismp = TRUE;
  102f78:	c6 83 6c 89 02 00 01 	movb   $0x1,0x2896c(%ebx)
    lapic_register(madt->lapic_addr);
  102f7f:	e8 ac f6 ff ff       	call   102630 <lapic_register>
    e = (uint8_t *) madt + madt->length;
  102f84:	8b 77 04             	mov    0x4(%edi),%esi

    while (p < e) {
  102f87:	83 c4 10             	add    $0x10,%esp
    ncpu = 0;
  102f8a:	c7 83 70 89 02 00 00 	movl   $0x0,0x28970(%ebx)
  102f91:	00 00 00 
    e = (uint8_t *) madt + madt->length;
  102f94:	01 fe                	add    %edi,%esi
    while (p < e) {
  102f96:	39 f5                	cmp    %esi,%ebp
  102f98:	0f 83 e6 00 00 00    	jae    103084 <pcpu_mp_init+0x184>

            if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
                break;
            }

            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102f9e:	8d 83 02 83 ff ff    	lea    -0x7cfe(%ebx),%eax
    bool found_bsp = FALSE;
  102fa4:	31 c9                	xor    %ecx,%ecx

            ioapic_register(ioapic_ent->ioapic_addr, ioapic_ent->ioapic_id,
                            ioapic_ent->gsi);
            break;
        default:
            KERN_INFO("\tUnhandled ACPI entry (type=%x)\n", hdr->type);
  102fa6:	89 7c 24 18          	mov    %edi,0x18(%esp)
  102faa:	89 ef                	mov    %ebp,%edi
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  102fac:	89 44 24 14          	mov    %eax,0x14(%esp)
            KERN_INFO("\tUnhandled ACPI entry (type=%x)\n", hdr->type);
  102fb0:	8d 83 6c 8c ff ff    	lea    -0x7394(%ebx),%eax
  102fb6:	89 cd                	mov    %ecx,%ebp
    uint32_t ap_idx = 1;
  102fb8:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
  102fbf:	00 
            KERN_INFO("\tUnhandled ACPI entry (type=%x)\n", hdr->type);
  102fc0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102fc4:	eb 30                	jmp    102ff6 <pcpu_mp_init+0xf6>
  102fc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  102fcd:	00 
  102fce:	66 90                	xchg   %ax,%ax
        switch (hdr->type) {
  102fd0:	3c 01                	cmp    $0x1,%al
  102fd2:	0f 84 e8 00 00 00    	je     1030c0 <pcpu_mp_init+0x1c0>
            KERN_INFO("\tUnhandled ACPI entry (type=%x)\n", hdr->type);
  102fd8:	83 ec 08             	sub    $0x8,%esp
  102fdb:	50                   	push   %eax
  102fdc:	ff 74 24 18          	push   0x18(%esp)
  102fe0:	e8 db 10 00 00       	call   1040c0 <debug_info>
            break;
  102fe5:	83 c4 10             	add    $0x10,%esp
        }

        p += hdr->length;
  102fe8:	0f b6 47 01          	movzbl 0x1(%edi),%eax
  102fec:	01 c7                	add    %eax,%edi
    while (p < e) {
  102fee:	39 f7                	cmp    %esi,%edi
  102ff0:	0f 83 8a 00 00 00    	jae    103080 <pcpu_mp_init+0x180>
        switch (hdr->type) {
  102ff6:	0f b6 07             	movzbl (%edi),%eax
  102ff9:	84 c0                	test   %al,%al
  102ffb:	75 d3                	jne    102fd0 <pcpu_mp_init+0xd0>
            if (!(lapic_ent->flags & ACPI_APIC_ENABLED)) {
  102ffd:	f6 47 04 01          	testb  $0x1,0x4(%edi)
  103001:	74 e5                	je     102fe8 <pcpu_mp_init+0xe8>
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, lapic_ent->lapic_id);
  103003:	0f b6 47 03          	movzbl 0x3(%edi),%eax
  103007:	83 ec 04             	sub    $0x4,%esp
  10300a:	50                   	push   %eax
  10300b:	ff b3 70 89 02 00    	push   0x28970(%ebx)
  103011:	ff 74 24 20          	push   0x20(%esp)
  103015:	e8 a6 10 00 00       	call   1040c0 <debug_info>
            if (!found_bsp) {
  10301a:	89 e8                	mov    %ebp,%eax
  10301c:	83 c4 10             	add    $0x10,%esp
  10301f:	84 c0                	test   %al,%al
  103021:	0f 84 d1 00 00 00    	je     1030f8 <pcpu_mp_init+0x1f8>
                KERN_INFO("AP\n");
  103027:	83 ec 0c             	sub    $0xc,%esp
  10302a:	8d 83 1e 83 ff ff    	lea    -0x7ce2(%ebx),%eax
  103030:	50                   	push   %eax
  103031:	e8 8a 10 00 00       	call   1040c0 <debug_info>
    if (idx >= NUM_CPUS)
  103036:	8b 44 24 20          	mov    0x20(%esp),%eax
  10303a:	83 c4 10             	add    $0x10,%esp
  10303d:	83 f8 07             	cmp    $0x7,%eax
  103040:	77 1b                	ja     10305d <pcpu_mp_init+0x15d>
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103042:	83 ec 0c             	sub    $0xc,%esp
                pcpu_mp_init_cpu(ap_idx, lapic_ent->lapic_id, FALSE);
  103045:	0f b6 6f 03          	movzbl 0x3(%edi),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103049:	50                   	push   %eax
  10304a:	e8 91 2c 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    info->lapicid = lapic_id;
  10304f:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  103051:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  103054:	0f b6 e9             	movzbl %cl,%ebp
    info->bsp = is_bsp;
  103057:	c6 40 04 00          	movb   $0x0,0x4(%eax)
    info->lapicid = lapic_id;
  10305b:	89 28                	mov    %ebp,(%eax)
                ap_idx++;
  10305d:	83 44 24 10 01       	addl   $0x1,0x10(%esp)
        p += hdr->length;
  103062:	0f b6 47 01          	movzbl 0x1(%edi),%eax
            ncpu++;
  103066:	83 83 70 89 02 00 01 	addl   $0x1,0x28970(%ebx)
            break;
  10306d:	bd 01 00 00 00       	mov    $0x1,%ebp
        p += hdr->length;
  103072:	01 c7                	add    %eax,%edi
    while (p < e) {
  103074:	39 f7                	cmp    %esi,%edi
  103076:	0f 82 7a ff ff ff    	jb     102ff6 <pcpu_mp_init+0xf6>
  10307c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103080:	8b 7c 24 18          	mov    0x18(%esp),%edi
    /*
     * Force NMI and 8259 signals to APIC when PIC mode
     * is not implemented.
     *
     */
    if ((madt->flags & APIC_MADT_PCAT_COMPAT) == 0) {
  103084:	f6 47 28 01          	testb  $0x1,0x28(%edi)
  103088:	0f 84 d2 00 00 00    	je     103160 <pcpu_mp_init+0x260>
    }

    /*
     * Copy AP boot code to 0x8000.
     */
    memmove((uint8_t *) 0x8000,
  10308e:	83 ec 04             	sub    $0x4,%esp
  103091:	ff b3 e8 ff ff ff    	push   -0x18(%ebx)
  103097:	ff b3 fc ff ff ff    	push   -0x4(%ebx)
  10309d:	68 00 80 00 00       	push   $0x8000
  1030a2:	e8 e9 0d 00 00       	call   103e90 <memmove>
            _binary___obj_kern_init_boot_ap_start,
            (size_t) _binary___obj_kern_init_boot_ap_size);

    mp_inited = TRUE;
  1030a7:	c6 83 6d 89 02 00 01 	movb   $0x1,0x2896d(%ebx)
    return TRUE;
  1030ae:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
        ncpu = 1;
        return FALSE;
    } else
        return TRUE;
}
  1030b1:	83 c4 2c             	add    $0x2c,%esp
        return TRUE;
  1030b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  1030b9:	5b                   	pop    %ebx
  1030ba:	5e                   	pop    %esi
  1030bb:	5f                   	pop    %edi
  1030bc:	5d                   	pop    %ebp
  1030bd:	c3                   	ret
  1030be:	66 90                	xchg   %ax,%ax
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  1030c0:	83 ec 04             	sub    $0x4,%esp
  1030c3:	ff 77 04             	push   0x4(%edi)
  1030c6:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  1030ca:	50                   	push   %eax
  1030cb:	8d 83 48 8c ff ff    	lea    -0x73b8(%ebx),%eax
  1030d1:	50                   	push   %eax
  1030d2:	e8 e9 0f 00 00       	call   1040c0 <debug_info>
            ioapic_register(ioapic_ent->ioapic_addr, ioapic_ent->ioapic_id,
  1030d7:	83 c4 0c             	add    $0xc,%esp
  1030da:	ff 77 08             	push   0x8(%edi)
  1030dd:	0f b6 47 02          	movzbl 0x2(%edi),%eax
  1030e1:	50                   	push   %eax
  1030e2:	ff 77 04             	push   0x4(%edi)
  1030e5:	e8 36 fa ff ff       	call   102b20 <ioapic_register>
            break;
  1030ea:	83 c4 10             	add    $0x10,%esp
  1030ed:	e9 f6 fe ff ff       	jmp    102fe8 <pcpu_mp_init+0xe8>
  1030f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                KERN_INFO("BSP\n");
  1030f8:	83 ec 0c             	sub    $0xc,%esp
  1030fb:	8d 83 19 83 ff ff    	lea    -0x7ce7(%ebx),%eax
  103101:	50                   	push   %eax
  103102:	e8 b9 0f 00 00       	call   1040c0 <debug_info>
                pcpu_mp_init_cpu(0, lapic_ent->lapic_id, TRUE);
  103107:	0f b6 6f 03          	movzbl 0x3(%edi),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  10310b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103112:	e8 c9 2b 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    info->bsp = is_bsp;
  103117:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  10311a:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  10311c:	c6 40 04 01          	movb   $0x1,0x4(%eax)
    info->lapicid = lapic_id;
  103120:	0f b6 e9             	movzbl %cl,%ebp
  103123:	89 28                	mov    %ebp,(%eax)
    info->bsp = is_bsp;
  103125:	e9 38 ff ff ff       	jmp    103062 <pcpu_mp_init+0x162>
  10312a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        (rsdt = acpi_probe_rsdt(rsdp)) == NULL) {
  103130:	83 ec 0c             	sub    $0xc,%esp
  103133:	56                   	push   %esi
  103134:	e8 97 f2 ff ff       	call   1023d0 <acpi_probe_rsdt>
    if ((xsdt = acpi_probe_xsdt(rsdp)) == NULL &&
  103139:	83 c4 10             	add    $0x10,%esp
  10313c:	85 c0                	test   %eax,%eax
  10313e:	0f 84 d3 03 00 00    	je     103517 <pcpu_mp_init+0x617>
         (acpi_madt_t *) acpi_probe_rsdt_ent(rsdt, ACPI_MADT_SIG)) == NULL) {
  103144:	83 ec 08             	sub    $0x8,%esp
  103147:	68 41 50 49 43       	push   $0x43495041
  10314c:	50                   	push   %eax
  10314d:	e8 0e f3 ff ff       	call   102460 <acpi_probe_rsdt_ent>
  103152:	83 c4 10             	add    $0x10,%esp
  103155:	89 c7                	mov    %eax,%edi
  103157:	e9 0b fe ff ff       	jmp    102f67 <pcpu_mp_init+0x67>
  10315c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        outb(0x22, 0x70);
  103160:	83 ec 08             	sub    $0x8,%esp
  103163:	6a 70                	push   $0x70
  103165:	6a 22                	push   $0x22
  103167:	e8 14 1e 00 00       	call   104f80 <outb>
        outb(0x23, inb(0x23) | 1);
  10316c:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  103173:	e8 d8 1d 00 00       	call   104f50 <inb>
  103178:	5e                   	pop    %esi
  103179:	5f                   	pop    %edi
  10317a:	83 c8 01             	or     $0x1,%eax
  10317d:	0f b6 c0             	movzbl %al,%eax
  103180:	50                   	push   %eax
  103181:	6a 23                	push   $0x23
  103183:	e8 f8 1d 00 00       	call   104f80 <outb>
  103188:	83 c4 10             	add    $0x10,%esp
  10318b:	e9 fe fe ff ff       	jmp    10308e <pcpu_mp_init+0x18e>
        KERN_DEBUG("Not found RSDP.\n");
  103190:	83 ec 04             	sub    $0x4,%esp
  103193:	8d 83 cd 82 ff ff    	lea    -0x7d33(%ebx),%eax
  103199:	50                   	push   %eax
  10319a:	68 4f 01 00 00       	push   $0x14f
        KERN_DEBUG("Not found MADT.\n");
  10319f:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  1031a5:	89 44 24 18          	mov    %eax,0x18(%esp)
  1031a9:	50                   	push   %eax
  1031aa:	e8 51 0f 00 00       	call   104100 <debug_normal>
        goto fallback;
  1031af:	83 c4 10             	add    $0x10,%esp
    KERN_DEBUG("Use the fallback multiprocessor initialization.\n");
  1031b2:	8d 83 90 8c ff ff    	lea    -0x7370(%ebx),%eax
  1031b8:	83 ec 04             	sub    $0x4,%esp
  1031bb:	50                   	push   %eax
  1031bc:	68 ac 01 00 00       	push   $0x1ac
  1031c1:	ff 74 24 18          	push   0x18(%esp)
  1031c5:	e8 36 0f 00 00       	call   104100 <debug_normal>
    if (mp_inited == TRUE)
  1031ca:	83 c4 10             	add    $0x10,%esp
  1031cd:	80 bb 6d 89 02 00 01 	cmpb   $0x1,0x2896d(%ebx)
  1031d4:	0f 84 d7 fe ff ff    	je     1030b1 <pcpu_mp_init+0x1b1>
    if ((p = ((bda[0x0F] << 8) | bda[0x0E]) << 4)) {
  1031da:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  1031e1:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  1031e8:	c1 e0 08             	shl    $0x8,%eax
  1031eb:	09 d0                	or     %edx,%eax
  1031ed:	c1 e0 04             	shl    $0x4,%eax
  1031f0:	75 1b                	jne    10320d <pcpu_mp_init+0x30d>
        p = ((bda[0x14] << 8) | bda[0x13]) * 1024;
  1031f2:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  1031f9:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  103200:	c1 e0 08             	shl    $0x8,%eax
  103203:	09 d0                	or     %edx,%eax
  103205:	c1 e0 0a             	shl    $0xa,%eax
        if ((mp = mpsearch1((uint8_t *) p - 1024, 1024)))
  103208:	2d 00 04 00 00       	sub    $0x400,%eax
        if ((mp = mpsearch1((uint8_t *) p, 1024)))
  10320d:	ba 00 04 00 00       	mov    $0x400,%edx
  103212:	e8 59 fc ff ff       	call   102e70 <mpsearch1>
  103217:	89 c7                	mov    %eax,%edi
  103219:	85 c0                	test   %eax,%eax
  10321b:	0f 84 3f 02 00 00    	je     103460 <pcpu_mp_init+0x560>
    if ((mp = mpsearch()) == 0 || mp->physaddr == 0)
  103221:	8b 77 04             	mov    0x4(%edi),%esi
  103224:	85 f6                	test   %esi,%esi
  103226:	0f 84 f4 00 00 00    	je     103320 <pcpu_mp_init+0x420>
    if (memcmp(conf, "PCMP", 4) != 0)
  10322c:	83 ec 04             	sub    $0x4,%esp
  10322f:	8d 83 22 83 ff ff    	lea    -0x7cde(%ebx),%eax
  103235:	6a 04                	push   $0x4
  103237:	50                   	push   %eax
  103238:	56                   	push   %esi
  103239:	e8 12 0e 00 00       	call   104050 <memcmp>
  10323e:	83 c4 10             	add    $0x10,%esp
  103241:	89 c2                	mov    %eax,%edx
  103243:	85 c0                	test   %eax,%eax
  103245:	0f 85 d5 00 00 00    	jne    103320 <pcpu_mp_init+0x420>
    if (conf->version != 1 && conf->version != 4)
  10324b:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  10324f:	3c 01                	cmp    $0x1,%al
  103251:	74 08                	je     10325b <pcpu_mp_init+0x35b>
  103253:	3c 04                	cmp    $0x4,%al
  103255:	0f 85 c5 00 00 00    	jne    103320 <pcpu_mp_init+0x420>
    if (sum((uint8_t *) conf, conf->length) != 0)
  10325b:	0f b7 6e 04          	movzwl 0x4(%esi),%ebp
    for (i = 0; i < len; i++)
  10325f:	66 85 ed             	test   %bp,%bp
  103262:	74 20                	je     103284 <pcpu_mp_init+0x384>
  103264:	89 f0                	mov    %esi,%eax
  103266:	01 f5                	add    %esi,%ebp
  103268:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10326f:	00 
        sum += addr[i];
  103270:	0f b6 08             	movzbl (%eax),%ecx
    for (i = 0; i < len; i++)
  103273:	83 c0 01             	add    $0x1,%eax
        sum += addr[i];
  103276:	01 ca                	add    %ecx,%edx
    for (i = 0; i < len; i++)
  103278:	39 e8                	cmp    %ebp,%eax
  10327a:	75 f4                	jne    103270 <pcpu_mp_init+0x370>
    if (sum((uint8_t *) conf, conf->length) != 0)
  10327c:	84 d2                	test   %dl,%dl
  10327e:	0f 85 9c 00 00 00    	jne    103320 <pcpu_mp_init+0x420>
    lapic_register((uintptr_t) conf->lapicaddr);
  103284:	83 ec 0c             	sub    $0xc,%esp
  103287:	ff 76 24             	push   0x24(%esi)
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  10328a:	8d 6e 2c             	lea    0x2c(%esi),%ebp
    ismp = 1;
  10328d:	c6 83 6c 89 02 00 01 	movb   $0x1,0x2896c(%ebx)
    ncpu = 0;
  103294:	c7 83 70 89 02 00 00 	movl   $0x0,0x28970(%ebx)
  10329b:	00 00 00 
    lapic_register((uintptr_t) conf->lapicaddr);
  10329e:	e8 8d f3 ff ff       	call   102630 <lapic_register>
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1032a3:	0f b7 46 04          	movzwl 0x4(%esi),%eax
  1032a7:	83 c4 10             	add    $0x10,%esp
    uint32_t ap_idx = 1;
  1032aa:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  1032b1:	00 
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1032b2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  1032b5:	8d 83 48 8c ff ff    	lea    -0x73b8(%ebx),%eax
  1032bb:	89 44 24 10          	mov    %eax,0x10(%esp)
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  1032bf:	8d 83 c4 8c ff ff    	lea    -0x733c(%ebx),%eax
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1032c5:	39 cd                	cmp    %ecx,%ebp
  1032c7:	0f 83 c7 00 00 00    	jae    103394 <pcpu_mp_init+0x494>
  1032cd:	89 7c 24 18          	mov    %edi,0x18(%esp)
  1032d1:	89 ce                	mov    %ecx,%esi
  1032d3:	89 44 24 14          	mov    %eax,0x14(%esp)
  1032d7:	eb 1a                	jmp    1032f3 <pcpu_mp_init+0x3f3>
  1032d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        switch (*p) {
  1032e0:	84 d2                	test   %dl,%dl
  1032e2:	0f 84 90 00 00 00    	je     103378 <pcpu_mp_init+0x478>
            p += 8;
  1032e8:	83 c5 08             	add    $0x8,%ebp
    for (p = (uint8_t *) (conf + 1), e = (uint8_t *) conf + conf->length; p < e;) {
  1032eb:	39 f5                	cmp    %esi,%ebp
  1032ed:	0f 83 9d 00 00 00    	jae    103390 <pcpu_mp_init+0x490>
        switch (*p) {
  1032f3:	0f b6 55 00          	movzbl 0x0(%ebp),%edx
  1032f7:	80 fa 02             	cmp    $0x2,%dl
  1032fa:	74 44                	je     103340 <pcpu_mp_init+0x440>
  1032fc:	76 e2                	jbe    1032e0 <pcpu_mp_init+0x3e0>
  1032fe:	8d 4a fd             	lea    -0x3(%edx),%ecx
  103301:	80 f9 01             	cmp    $0x1,%cl
  103304:	76 e2                	jbe    1032e8 <pcpu_mp_init+0x3e8>
            KERN_WARN("mpinit: unknown config type %x\n", *p);
  103306:	52                   	push   %edx
  103307:	ff 74 24 18          	push   0x18(%esp)
  10330b:	68 28 01 00 00       	push   $0x128
  103310:	ff 74 24 18          	push   0x18(%esp)
  103314:	e8 57 0f 00 00       	call   104270 <debug_warn>
  103319:	83 c4 10             	add    $0x10,%esp
  10331c:	eb cd                	jmp    1032eb <pcpu_mp_init+0x3eb>
  10331e:	66 90                	xchg   %ax,%ax
        ismp = 0;
  103320:	c6 83 6c 89 02 00 00 	movb   $0x0,0x2896c(%ebx)
        return FALSE;
  103327:	31 c0                	xor    %eax,%eax
        ncpu = 1;
  103329:	c7 83 70 89 02 00 01 	movl   $0x1,0x28970(%ebx)
  103330:	00 00 00 
}
  103333:	83 c4 2c             	add    $0x2c,%esp
  103336:	5b                   	pop    %ebx
  103337:	5e                   	pop    %esi
  103338:	5f                   	pop    %edi
  103339:	5d                   	pop    %ebp
  10333a:	c3                   	ret
  10333b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  103340:	83 ec 04             	sub    $0x4,%esp
  103343:	ff 75 04             	push   0x4(%ebp)
  103346:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
            p += sizeof(struct mpioapic);
  10334a:	8d 7d 08             	lea    0x8(%ebp),%edi
            KERN_INFO("\tIOAPIC: APIC id = %x, base = %x\n",
  10334d:	52                   	push   %edx
  10334e:	ff 74 24 1c          	push   0x1c(%esp)
  103352:	e8 69 0d 00 00       	call   1040c0 <debug_info>
            ioapic_register((uintptr_t) mpio->addr, mpio->apicno, 0);
  103357:	83 c4 0c             	add    $0xc,%esp
  10335a:	6a 00                	push   $0x0
  10335c:	0f b6 55 01          	movzbl 0x1(%ebp),%edx
  103360:	52                   	push   %edx
  103361:	ff 75 04             	push   0x4(%ebp)
            p += sizeof(struct mpioapic);
  103364:	89 fd                	mov    %edi,%ebp
            ioapic_register((uintptr_t) mpio->addr, mpio->apicno, 0);
  103366:	e8 b5 f7 ff ff       	call   102b20 <ioapic_register>
            continue;
  10336b:	83 c4 10             	add    $0x10,%esp
  10336e:	e9 78 ff ff ff       	jmp    1032eb <pcpu_mp_init+0x3eb>
  103373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            p += sizeof(struct mpproc);
  103378:	8d 7d 14             	lea    0x14(%ebp),%edi
            if (!(proc->flags & MPENAB))
  10337b:	f6 45 03 01          	testb  $0x1,0x3(%ebp)
  10337f:	75 67                	jne    1033e8 <pcpu_mp_init+0x4e8>
            p += sizeof(struct mpproc);
  103381:	89 fd                	mov    %edi,%ebp
  103383:	e9 63 ff ff ff       	jmp    1032eb <pcpu_mp_init+0x3eb>
  103388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10338f:	00 
  103390:	8b 7c 24 18          	mov    0x18(%esp),%edi
    if (mp->imcrp) {
  103394:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
  103398:	0f 85 49 01 00 00    	jne    1034e7 <pcpu_mp_init+0x5e7>
    memcpy((uint8_t *) 0x8000,
  10339e:	83 ec 04             	sub    $0x4,%esp
  1033a1:	ff b3 e8 ff ff ff    	push   -0x18(%ebx)
  1033a7:	ff b3 fc ff ff ff    	push   -0x4(%ebx)
  1033ad:	68 00 80 00 00       	push   $0x8000
  1033b2:	e8 49 0b 00 00       	call   103f00 <memcpy>
    mp_inited = TRUE;
  1033b7:	c6 83 6d 89 02 00 01 	movb   $0x1,0x2896d(%ebx)
  1033be:	83 c4 10             	add    $0x10,%esp
  1033c1:	e9 eb fc ff ff       	jmp    1030b1 <pcpu_mp_init+0x1b1>
  1033c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1033cd:	00 
  1033ce:	66 90                	xchg   %ax,%ax
        KERN_DEBUG("Not found MADT.\n");
  1033d0:	83 ec 04             	sub    $0x4,%esp
  1033d3:	8d 83 f1 82 ff ff    	lea    -0x7d0f(%ebx),%eax
  1033d9:	50                   	push   %eax
  1033da:	68 5e 01 00 00       	push   $0x15e
  1033df:	e9 bb fd ff ff       	jmp    10319f <pcpu_mp_init+0x29f>
  1033e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            KERN_INFO("\tCPU%d: APIC id = %x, ", ncpu, proc->apicid);
  1033e8:	0f b6 4d 01          	movzbl 0x1(%ebp),%ecx
  1033ec:	83 ec 04             	sub    $0x4,%esp
  1033ef:	51                   	push   %ecx
  1033f0:	8d 8b 02 83 ff ff    	lea    -0x7cfe(%ebx),%ecx
  1033f6:	ff b3 70 89 02 00    	push   0x28970(%ebx)
  1033fc:	51                   	push   %ecx
  1033fd:	e8 be 0c 00 00       	call   1040c0 <debug_info>
            if (proc->flags & MPBOOT) {
  103402:	83 c4 10             	add    $0x10,%esp
  103405:	f6 45 03 02          	testb  $0x2,0x3(%ebp)
  103409:	0f 85 a6 00 00 00    	jne    1034b5 <pcpu_mp_init+0x5b5>
                KERN_INFO("AP.\n");
  10340f:	83 ec 0c             	sub    $0xc,%esp
  103412:	8d 8b 2d 83 ff ff    	lea    -0x7cd3(%ebx),%ecx
  103418:	51                   	push   %ecx
  103419:	e8 a2 0c 00 00       	call   1040c0 <debug_info>
    if (idx >= NUM_CPUS)
  10341e:	8b 44 24 2c          	mov    0x2c(%esp),%eax
  103422:	83 c4 10             	add    $0x10,%esp
  103425:	83 f8 07             	cmp    $0x7,%eax
  103428:	77 1b                	ja     103445 <pcpu_mp_init+0x545>
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  10342a:	83 ec 0c             	sub    $0xc,%esp
                pcpu_mp_init_cpu(ap_idx, proc->apicid, FALSE);
  10342d:	0f b6 6d 01          	movzbl 0x1(%ebp),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  103431:	50                   	push   %eax
  103432:	e8 a9 28 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    info->lapicid = lapic_id;
  103437:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  103439:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  10343c:	0f b6 d1             	movzbl %cl,%edx
    info->bsp = is_bsp;
  10343f:	c6 40 04 00          	movb   $0x0,0x4(%eax)
    info->lapicid = lapic_id;
  103443:	89 10                	mov    %edx,(%eax)
                ap_idx++;
  103445:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
            ncpu++;
  10344a:	83 83 70 89 02 00 01 	addl   $0x1,0x28970(%ebx)
            p += sizeof(struct mpproc);
  103451:	89 fd                	mov    %edi,%ebp
            continue;
  103453:	e9 93 fe ff ff       	jmp    1032eb <pcpu_mp_init+0x3eb>
  103458:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10345f:	00 
            break;
  103460:	bf 00 00 0f 00       	mov    $0xf0000,%edi
  103465:	8d b3 c8 82 ff ff    	lea    -0x7d38(%ebx),%esi
  10346b:	eb 11                	jmp    10347e <pcpu_mp_init+0x57e>
  10346d:	8d 76 00             	lea    0x0(%esi),%esi
    for (p = addr; p < e; p += sizeof(struct mp))
  103470:	89 ef                	mov    %ebp,%edi
  103472:	81 fd 00 00 10 00    	cmp    $0x100000,%ebp
  103478:	0f 84 a2 fe ff ff    	je     103320 <pcpu_mp_init+0x420>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  10347e:	83 ec 04             	sub    $0x4,%esp
  103481:	8d 6f 10             	lea    0x10(%edi),%ebp
  103484:	6a 04                	push   $0x4
  103486:	56                   	push   %esi
  103487:	57                   	push   %edi
  103488:	e8 c3 0b 00 00       	call   104050 <memcmp>
  10348d:	83 c4 10             	add    $0x10,%esp
  103490:	85 c0                	test   %eax,%eax
  103492:	75 dc                	jne    103470 <pcpu_mp_init+0x570>
  103494:	89 fa                	mov    %edi,%edx
  103496:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10349d:	00 
  10349e:	66 90                	xchg   %ax,%ax
        sum += addr[i];
  1034a0:	0f b6 0a             	movzbl (%edx),%ecx
    for (i = 0; i < len; i++)
  1034a3:	83 c2 01             	add    $0x1,%edx
        sum += addr[i];
  1034a6:	01 c8                	add    %ecx,%eax
    for (i = 0; i < len; i++)
  1034a8:	39 ea                	cmp    %ebp,%edx
  1034aa:	75 f4                	jne    1034a0 <pcpu_mp_init+0x5a0>
        if (memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  1034ac:	84 c0                	test   %al,%al
  1034ae:	75 c0                	jne    103470 <pcpu_mp_init+0x570>
  1034b0:	e9 6c fd ff ff       	jmp    103221 <pcpu_mp_init+0x321>
                KERN_INFO("BSP.\n");
  1034b5:	83 ec 0c             	sub    $0xc,%esp
  1034b8:	8d 8b 27 83 ff ff    	lea    -0x7cd9(%ebx),%ecx
  1034be:	51                   	push   %ecx
  1034bf:	e8 fc 0b 00 00       	call   1040c0 <debug_info>
                pcpu_mp_init_cpu(0, proc->apicid, TRUE);
  1034c4:	0f b6 6d 01          	movzbl 0x1(%ebp),%ebp
    struct pcpuinfo *info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(idx);
  1034c8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1034cf:	e8 0c 28 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    info->bsp = is_bsp;
  1034d4:	83 c4 10             	add    $0x10,%esp
    info->lapicid = lapic_id;
  1034d7:	89 e9                	mov    %ebp,%ecx
    info->bsp = is_bsp;
  1034d9:	c6 40 04 01          	movb   $0x1,0x4(%eax)
    info->lapicid = lapic_id;
  1034dd:	0f b6 d1             	movzbl %cl,%edx
  1034e0:	89 10                	mov    %edx,(%eax)
    info->bsp = is_bsp;
  1034e2:	e9 63 ff ff ff       	jmp    10344a <pcpu_mp_init+0x54a>
        outb(0x22, 0x70);
  1034e7:	83 ec 08             	sub    $0x8,%esp
  1034ea:	6a 70                	push   $0x70
  1034ec:	6a 22                	push   $0x22
  1034ee:	e8 8d 1a 00 00       	call   104f80 <outb>
        outb(0x23, inb(0x23) | 1);
  1034f3:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
  1034fa:	e8 51 1a 00 00       	call   104f50 <inb>
  1034ff:	5a                   	pop    %edx
  103500:	59                   	pop    %ecx
  103501:	83 c8 01             	or     $0x1,%eax
  103504:	0f b6 c0             	movzbl %al,%eax
  103507:	50                   	push   %eax
  103508:	6a 23                	push   $0x23
  10350a:	e8 71 1a 00 00       	call   104f80 <outb>
  10350f:	83 c4 10             	add    $0x10,%esp
  103512:	e9 87 fe ff ff       	jmp    10339e <pcpu_mp_init+0x49e>
        KERN_DEBUG("Not found either RSDT or XSDT.\n");
  103517:	83 ec 04             	sub    $0x4,%esp
  10351a:	8d 83 28 8c ff ff    	lea    -0x73d8(%ebx),%eax
  103520:	50                   	push   %eax
  103521:	68 56 01 00 00       	push   $0x156
  103526:	e9 74 fc ff ff       	jmp    10319f <pcpu_mp_init+0x29f>
  10352b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00103530 <pcpu_boot_ap>:

int pcpu_boot_ap(uint32_t cpu_idx, void (*f)(void), uintptr_t stack_addr)
{
  103530:	57                   	push   %edi
  103531:	56                   	push   %esi
  103532:	53                   	push   %ebx
  103533:	8b 74 24 10          	mov    0x10(%esp),%esi
  103537:	e8 66 ce ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10353c:	81 c3 b8 da 00 00    	add    $0xdab8,%ebx
  103542:	8b 7c 24 14          	mov    0x14(%esp),%edi
    KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  103546:	85 f6                	test   %esi,%esi
  103548:	74 6e                	je     1035b8 <pcpu_boot_ap+0x88>
  10354a:	3b b3 70 89 02 00    	cmp    0x28970(%ebx),%esi
  103550:	73 66                	jae    1035b8 <pcpu_boot_ap+0x88>
    KERN_ASSERT(get_pcpu_inited_info(cpu_idx) == TRUE);
  103552:	83 ec 0c             	sub    $0xc,%esp
  103555:	56                   	push   %esi
  103556:	e8 a5 27 00 00       	call   105d00 <get_pcpu_inited_info>
  10355b:	83 c4 10             	add    $0x10,%esp
  10355e:	3c 01                	cmp    $0x1,%al
  103560:	74 22                	je     103584 <pcpu_boot_ap+0x54>
  103562:	8d 83 0c 8d ff ff    	lea    -0x72f4(%ebx),%eax
  103568:	50                   	push   %eax
  103569:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  10356f:	50                   	push   %eax
  103570:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  103576:	68 b8 01 00 00       	push   $0x1b8
  10357b:	50                   	push   %eax
  10357c:	e8 df 0b 00 00       	call   104160 <debug_panic>
  103581:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(f != NULL);
  103584:	85 ff                	test   %edi,%edi
  103586:	0f 84 54 01 00 00    	je     1036e0 <pcpu_boot_ap+0x1b0>
    return ismp;
}

bool pcpu_onboot(void)
{
    int cpu_idx = get_pcpu_idx();
  10358c:	e8 0f 26 00 00       	call   105ba0 <get_pcpu_idx>
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103591:	83 ec 0c             	sub    $0xc,%esp
  103594:	50                   	push   %eax
  103595:	e8 46 27 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  10359a:	83 c4 10             	add    $0x10,%esp
  10359d:	80 bb 6d 89 02 00 01 	cmpb   $0x1,0x2896d(%ebx)
  1035a4:	75 3a                	jne    1035e0 <pcpu_boot_ap+0xb0>
    if (pcpu_onboot() == FALSE)
  1035a6:	80 78 04 00          	cmpb   $0x0,0x4(%eax)
  1035aa:	75 3d                	jne    1035e9 <pcpu_boot_ap+0xb9>
}
  1035ac:	5b                   	pop    %ebx
        return 1;
  1035ad:	b8 01 00 00 00       	mov    $0x1,%eax
}
  1035b2:	5e                   	pop    %esi
  1035b3:	5f                   	pop    %edi
  1035b4:	c3                   	ret
  1035b5:	8d 76 00             	lea    0x0(%esi),%esi
    KERN_ASSERT(cpu_idx > 0 && cpu_idx < pcpu_ncpu());
  1035b8:	8d 83 e4 8c ff ff    	lea    -0x731c(%ebx),%eax
  1035be:	50                   	push   %eax
  1035bf:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1035c5:	50                   	push   %eax
  1035c6:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  1035cc:	68 b7 01 00 00       	push   $0x1b7
  1035d1:	50                   	push   %eax
  1035d2:	e8 89 0b 00 00       	call   104160 <debug_panic>
  1035d7:	83 c4 10             	add    $0x10,%esp
  1035da:	e9 73 ff ff ff       	jmp    103552 <pcpu_boot_ap+0x22>
  1035df:	90                   	nop
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  1035e0:	e8 bb 25 00 00       	call   105ba0 <get_pcpu_idx>
    if (pcpu_onboot() == FALSE)
  1035e5:	85 c0                	test   %eax,%eax
  1035e7:	75 c3                	jne    1035ac <pcpu_boot_ap+0x7c>
    if (get_pcpu_boot_info(cpu_idx) == TRUE)
  1035e9:	83 ec 0c             	sub    $0xc,%esp
  1035ec:	56                   	push   %esi
  1035ed:	e8 5e 26 00 00       	call   105c50 <get_pcpu_boot_info>
  1035f2:	83 c4 10             	add    $0x10,%esp
  1035f5:	3c 01                	cmp    $0x1,%al
  1035f7:	74 7c                	je     103675 <pcpu_boot_ap+0x145>
    *(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  1035f9:	8b 44 24 18          	mov    0x18(%esp),%eax
}

lapicid_t pcpu_cpu_lapicid(int cpu_idx)
{
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  1035fd:	83 ec 0c             	sub    $0xc,%esp
    *(uintptr_t *) (boot - 8) = (uintptr_t) f;
  103600:	89 3d f8 7f 00 00    	mov    %edi,0x7ff8
    *(uintptr_t *) (boot - 4) = stack_addr + PAGE_SIZE;
  103606:	05 00 10 00 00       	add    $0x1000,%eax
  10360b:	a3 fc 7f 00 00       	mov    %eax,0x7ffc
    *(uintptr_t *) (boot - 12) = (uintptr_t) kern_init_ap;
  103610:	c7 c0 20 60 10 00    	mov    $0x106020,%eax
  103616:	a3 f4 7f 00 00       	mov    %eax,0x7ff4
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  10361b:	56                   	push   %esi
  10361c:	e8 bf 26 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103621:	83 c4 10             	add    $0x10,%esp
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103624:	89 c7                	mov    %eax,%edi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103626:	85 f6                	test   %esi,%esi
  103628:	0f 88 82 00 00 00    	js     1036b0 <pcpu_boot_ap+0x180>
  10362e:	3b b3 70 89 02 00    	cmp    0x28970(%ebx),%esi
  103634:	73 7a                	jae    1036b0 <pcpu_boot_ap+0x180>
    lapic_startcpu(pcpu_cpu_lapicid(cpu_idx), (uintptr_t) boot);
  103636:	83 ec 08             	sub    $0x8,%esp
  103639:	68 00 80 00 00       	push   $0x8000
  10363e:	0f b6 07             	movzbl (%edi),%eax
  103641:	50                   	push   %eax
  103642:	e8 29 f3 ff ff       	call   102970 <lapic_startcpu>
    while (get_pcpu_boot_info(cpu_idx) == FALSE)
  103647:	83 c4 10             	add    $0x10,%esp
  10364a:	eb 09                	jmp    103655 <pcpu_boot_ap+0x125>
  10364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pause();
  103650:	e8 5b 17 00 00       	call   104db0 <pause>
    while (get_pcpu_boot_info(cpu_idx) == FALSE)
  103655:	83 ec 0c             	sub    $0xc,%esp
  103658:	56                   	push   %esi
  103659:	e8 f2 25 00 00       	call   105c50 <get_pcpu_boot_info>
  10365e:	83 c4 10             	add    $0x10,%esp
  103661:	84 c0                	test   %al,%al
  103663:	74 eb                	je     103650 <pcpu_boot_ap+0x120>
    KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  103665:	83 ec 0c             	sub    $0xc,%esp
  103668:	56                   	push   %esi
  103669:	e8 e2 25 00 00       	call   105c50 <get_pcpu_boot_info>
  10366e:	83 c4 10             	add    $0x10,%esp
  103671:	3c 01                	cmp    $0x1,%al
  103673:	75 0b                	jne    103680 <pcpu_boot_ap+0x150>
        return 0;
  103675:	31 c0                	xor    %eax,%eax
}
  103677:	5b                   	pop    %ebx
  103678:	5e                   	pop    %esi
  103679:	5f                   	pop    %edi
  10367a:	c3                   	ret
  10367b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(get_pcpu_boot_info(cpu_idx) == TRUE);
  103680:	8d 83 54 8d ff ff    	lea    -0x72ac(%ebx),%eax
  103686:	50                   	push   %eax
  103687:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  10368d:	50                   	push   %eax
  10368e:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  103694:	68 cd 01 00 00       	push   $0x1cd
  103699:	50                   	push   %eax
  10369a:	e8 c1 0a 00 00       	call   104160 <debug_panic>
  10369f:	83 c4 10             	add    $0x10,%esp
        return 0;
  1036a2:	31 c0                	xor    %eax,%eax
  1036a4:	eb d1                	jmp    103677 <pcpu_boot_ap+0x147>
  1036a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1036ad:	00 
  1036ae:	66 90                	xchg   %ax,%ax
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  1036b0:	8d 83 34 8d ff ff    	lea    -0x72cc(%ebx),%eax
  1036b6:	50                   	push   %eax
  1036b7:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1036bd:	50                   	push   %eax
  1036be:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  1036c4:	68 ea 01 00 00       	push   $0x1ea
  1036c9:	50                   	push   %eax
  1036ca:	e8 91 0a 00 00       	call   104160 <debug_panic>
  1036cf:	83 c4 10             	add    $0x10,%esp
  1036d2:	e9 5f ff ff ff       	jmp    103636 <pcpu_boot_ap+0x106>
  1036d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1036de:	00 
  1036df:	90                   	nop
    KERN_ASSERT(f != NULL);
  1036e0:	8d 83 32 83 ff ff    	lea    -0x7cce(%ebx),%eax
  1036e6:	50                   	push   %eax
  1036e7:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1036ed:	50                   	push   %eax
  1036ee:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  1036f4:	68 b9 01 00 00       	push   $0x1b9
  1036f9:	50                   	push   %eax
  1036fa:	e8 61 0a 00 00       	call   104160 <debug_panic>
  1036ff:	83 c4 10             	add    $0x10,%esp
  103702:	e9 85 fe ff ff       	jmp    10358c <pcpu_boot_ap+0x5c>
  103707:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10370e:	00 
  10370f:	90                   	nop

00103710 <pcpu_init_cpu>:
{
  103710:	55                   	push   %ebp
  103711:	e8 63 db ff ff       	call   101279 <__x86.get_pc_thunk.bp>
  103716:	81 c5 de d8 00 00    	add    $0xd8de,%ebp
  10371c:	57                   	push   %edi
  10371d:	56                   	push   %esi
  10371e:	53                   	push   %ebx
  10371f:	83 ec 4c             	sub    $0x4c,%esp
    int cpu_idx = get_pcpu_idx();
  103722:	89 eb                	mov    %ebp,%ebx
  103724:	e8 77 24 00 00       	call   105ba0 <get_pcpu_idx>
    struct pcpuinfo *cpuinfo = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103729:	83 ec 0c             	sub    $0xc,%esp
  10372c:	50                   	push   %eax
  10372d:	e8 ae 25 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  103732:	8d 7c 24 3c          	lea    0x3c(%esp),%edi
  103736:	8d 4c 24 34          	lea    0x34(%esp),%ecx
  10373a:	8d 5c 24 38          	lea    0x38(%esp),%ebx
    struct pcpuinfo *cpuinfo = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  10373e:	89 c6                	mov    %eax,%esi
    uint32_t *regs[4] = { &eax, &ebx, &ecx, &edx };
  103740:	8d 44 24 30          	lea    0x30(%esp),%eax
  103744:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  103748:	89 44 24 10          	mov    %eax,0x10(%esp)
  10374c:	89 44 24 40          	mov    %eax,0x40(%esp)
  103750:	89 4c 24 44          	mov    %ecx,0x44(%esp)
  103754:	89 5c 24 18          	mov    %ebx,0x18(%esp)
  103758:	89 5c 24 48          	mov    %ebx,0x48(%esp)
  10375c:	89 7c 24 4c          	mov    %edi,0x4c(%esp)
    cpuid(0x0, &eax, &ebx, &ecx, &edx);
  103760:	89 3c 24             	mov    %edi,(%esp)
  103763:	53                   	push   %ebx
  103764:	89 eb                	mov    %ebp,%ebx
  103766:	51                   	push   %ecx
  103767:	50                   	push   %eax
  103768:	6a 00                	push   $0x0
  10376a:	e8 b1 16 00 00       	call   104e20 <cpuid>
    cpuinfo->cpuid_high = eax;
  10376f:	8b 44 24 40          	mov    0x40(%esp),%eax
    cpuinfo->vendor[12] = '\0';
  103773:	c6 46 18 00          	movb   $0x0,0x18(%esi)
    cpuinfo->cpuid_high = eax;
  103777:	89 46 08             	mov    %eax,0x8(%esi)
    ((uint32_t *) cpuinfo->vendor)[0] = ebx;
  10377a:	8b 44 24 44          	mov    0x44(%esp),%eax
  10377e:	89 46 0c             	mov    %eax,0xc(%esi)
    ((uint32_t *) cpuinfo->vendor)[1] = edx;
  103781:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  103785:	89 46 10             	mov    %eax,0x10(%esi)
    ((uint32_t *) cpuinfo->vendor)[2] = ecx;
  103788:	8b 44 24 48          	mov    0x48(%esp),%eax
  10378c:	89 46 14             	mov    %eax,0x14(%esi)
    if (strncmp(cpuinfo->vendor, "GenuineIntel", 20) == 0)
  10378f:	8d 46 0c             	lea    0xc(%esi),%eax
  103792:	89 44 24 30          	mov    %eax,0x30(%esp)
  103796:	89 c1                	mov    %eax,%ecx
  103798:	83 c4 1c             	add    $0x1c,%esp
  10379b:	8d 85 71 83 ff ff    	lea    -0x7c8f(%ebp),%eax
  1037a1:	6a 14                	push   $0x14
  1037a3:	50                   	push   %eax
  1037a4:	51                   	push   %ecx
  1037a5:	e8 66 07 00 00       	call   103f10 <strncmp>
  1037aa:	83 c4 10             	add    $0x10,%esp
  1037ad:	89 c2                	mov    %eax,%edx
  1037af:	b8 01 00 00 00       	mov    $0x1,%eax
  1037b4:	85 d2                	test   %edx,%edx
  1037b6:	0f 85 f4 02 00 00    	jne    103ab0 <pcpu_init_cpu+0x3a0>
    cpuid(0x1, &eax, &ebx, &ecx, &edx);
  1037bc:	83 ec 0c             	sub    $0xc,%esp
        cpuinfo->cpu_vendor = INTEL;
  1037bf:	89 46 20             	mov    %eax,0x20(%esi)
    cpuid(0x1, &eax, &ebx, &ecx, &edx);
  1037c2:	89 eb                	mov    %ebp,%ebx
  1037c4:	57                   	push   %edi
  1037c5:	ff 74 24 18          	push   0x18(%esp)
  1037c9:	ff 74 24 18          	push   0x18(%esp)
  1037cd:	ff 74 24 18          	push   0x18(%esp)
  1037d1:	6a 01                	push   $0x1
  1037d3:	e8 48 16 00 00       	call   104e20 <cpuid>
    cpuinfo->family = (eax >> 8) & 0xf;
  1037d8:	8b 44 24 40          	mov    0x40(%esp),%eax
  1037dc:	89 c2                	mov    %eax,%edx
  1037de:	c1 ea 08             	shr    $0x8,%edx
  1037e1:	83 e2 0f             	and    $0xf,%edx
  1037e4:	88 56 24             	mov    %dl,0x24(%esi)
    cpuinfo->model = (eax >> 4) & 0xf;
  1037e7:	89 c2                	mov    %eax,%edx
  1037e9:	c0 ea 04             	shr    $0x4,%dl
  1037ec:	88 56 25             	mov    %dl,0x25(%esi)
    cpuinfo->step = eax & 0xf;
  1037ef:	89 c2                	mov    %eax,%edx
  1037f1:	83 e2 0f             	and    $0xf,%edx
  1037f4:	88 56 26             	mov    %dl,0x26(%esi)
    cpuinfo->ext_family = (eax >> 20) & 0xff;
  1037f7:	89 c2                	mov    %eax,%edx
    cpuinfo->ext_model = (eax >> 16) & 0xff;
  1037f9:	c1 e8 10             	shr    $0x10,%eax
  1037fc:	88 46 28             	mov    %al,0x28(%esi)
    cpuinfo->brand_idx = ebx & 0xff;
  1037ff:	8b 44 24 44          	mov    0x44(%esp),%eax
    cpuinfo->ext_family = (eax >> 20) & 0xff;
  103803:	c1 ea 14             	shr    $0x14,%edx
  103806:	88 56 27             	mov    %dl,0x27(%esi)
    cpuinfo->brand_idx = ebx & 0xff;
  103809:	89 46 29             	mov    %eax,0x29(%esi)
    cpuinfo->feature1 = ecx;
  10380c:	8b 44 24 48          	mov    0x48(%esp),%eax
  103810:	89 46 30             	mov    %eax,0x30(%esi)
    cpuinfo->feature2 = edx;
  103813:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    switch (cpuinfo->cpu_vendor) {
  103817:	83 c4 20             	add    $0x20,%esp
    cpuinfo->feature2 = edx;
  10381a:	89 46 34             	mov    %eax,0x34(%esi)
    switch (cpuinfo->cpu_vendor) {
  10381d:	8b 46 20             	mov    0x20(%esi),%eax
  103820:	83 f8 01             	cmp    $0x1,%eax
  103823:	0f 84 6f 01 00 00    	je     103998 <pcpu_init_cpu+0x288>
  103829:	83 f8 02             	cmp    $0x2,%eax
  10382c:	0f 85 4e 01 00 00    	jne    103980 <pcpu_init_cpu+0x270>
        cpuid(0x80000005, &eax, &ebx, &ecx, &edx);
  103832:	83 ec 0c             	sub    $0xc,%esp
  103835:	57                   	push   %edi
  103836:	ff 74 24 18          	push   0x18(%esp)
  10383a:	ff 74 24 18          	push   0x18(%esp)
  10383e:	ff 74 24 18          	push   0x18(%esp)
  103842:	68 05 00 00 80       	push   $0x80000005
  103847:	e8 d4 15 00 00       	call   104e20 <cpuid>
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  10384c:	8b 44 24 48          	mov    0x48(%esp),%eax
        break;
  103850:	83 c4 20             	add    $0x20,%esp
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103853:	89 c2                	mov    %eax,%edx
        cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  103855:	25 ff 00 00 00       	and    $0xff,%eax
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  10385a:	c1 ea 18             	shr    $0x18,%edx
        cpuinfo->l1_cache_line_size = (ecx & 0x000000ff);
  10385d:	89 46 3c             	mov    %eax,0x3c(%esi)
        cpuinfo->l1_cache_size = (ecx & 0xff000000) >> 24;
  103860:	89 56 38             	mov    %edx,0x38(%esi)
    cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
  103863:	83 ec 0c             	sub    $0xc,%esp
  103866:	89 eb                	mov    %ebp,%ebx
  103868:	57                   	push   %edi
  103869:	ff 74 24 18          	push   0x18(%esp)
  10386d:	ff 74 24 18          	push   0x18(%esp)
  103871:	ff 74 24 18          	push   0x18(%esp)
  103875:	68 00 00 00 80       	push   $0x80000000
  10387a:	e8 a1 15 00 00       	call   104e20 <cpuid>
    cpuinfo->cpuid_exthigh = eax;
  10387f:	8b 44 24 40          	mov    0x40(%esp),%eax
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  103883:	83 c4 20             	add    $0x20,%esp
    cpuinfo->cpuid_exthigh = eax;
  103886:	89 46 40             	mov    %eax,0x40(%esi)
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  103889:	e8 12 23 00 00       	call   105ba0 <get_pcpu_idx>
    KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10388e:	8b 56 30             	mov    0x30(%esi),%edx
  103891:	8d 8d 3c 83 ff ff    	lea    -0x7cc4(%ebp),%ecx
  103897:	8b 7e 38             	mov    0x38(%esi),%edi
    pcpu_print_cpuinfo(get_pcpu_idx(), cpuinfo);
  10389a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    KERN_INFO("CPU%d: %s, FAMILY %d(%d), MODEL %d(%d), STEP %d, "
  10389e:	8d 85 5a 85 ff ff    	lea    -0x7aa6(%ebp),%eax
  1038a4:	f7 c2 00 00 80 00    	test   $0x800000,%edx
  1038aa:	89 3c 24             	mov    %edi,(%esp)
  1038ad:	0f 44 c8             	cmove  %eax,%ecx
  1038b0:	f7 c2 00 00 10 00    	test   $0x100000,%edx
  1038b6:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  1038ba:	8d 8d 45 83 ff ff    	lea    -0x7cbb(%ebp),%ecx
  1038c0:	89 cf                	mov    %ecx,%edi
  1038c2:	8d 8d 4d 83 ff ff    	lea    -0x7cb3(%ebp),%ecx
  1038c8:	0f 44 f8             	cmove  %eax,%edi
  1038cb:	f7 c2 00 00 08 00    	test   $0x80000,%edx
  1038d1:	0f 44 c8             	cmove  %eax,%ecx
  1038d4:	f6 c6 02             	test   $0x2,%dh
  1038d7:	89 7c 24 14          	mov    %edi,0x14(%esp)
  1038db:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1038df:	8d 8d 55 83 ff ff    	lea    -0x7cab(%ebp),%ecx
  1038e5:	89 cb                	mov    %ecx,%ebx
  1038e7:	8d 8d 5d 83 ff ff    	lea    -0x7ca3(%ebp),%ecx
  1038ed:	0f 44 d8             	cmove  %eax,%ebx
  1038f0:	89 cf                	mov    %ecx,%edi
  1038f2:	8b 4e 34             	mov    0x34(%esi),%ecx
  1038f5:	f6 c2 01             	test   $0x1,%dl
  1038f8:	0f 44 f8             	cmove  %eax,%edi
  1038fb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  1038ff:	f7 c1 00 00 00 04    	test   $0x4000000,%ecx
  103905:	8d 9d 64 83 ff ff    	lea    -0x7c9c(%ebp),%ebx
  10390b:	0f 44 d8             	cmove  %eax,%ebx
  10390e:	f7 c1 00 00 00 02    	test   $0x2000000,%ecx
  103914:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103918:	8d 9d 6b 83 ff ff    	lea    -0x7c95(%ebp),%ebx
  10391e:	0f 45 c3             	cmovne %ebx,%eax
  103921:	83 ec 04             	sub    $0x4,%esp
  103924:	ff 76 3c             	push   0x3c(%esi)
  103927:	89 eb                	mov    %ebp,%ebx
  103929:	ff 74 24 08          	push   0x8(%esp)
  10392d:	ff 74 24 24          	push   0x24(%esp)
  103931:	ff 74 24 24          	push   0x24(%esp)
  103935:	ff 74 24 20          	push   0x20(%esp)
  103939:	ff 74 24 20          	push   0x20(%esp)
  10393d:	57                   	push   %edi
  10393e:	ff 74 24 24          	push   0x24(%esp)
  103942:	50                   	push   %eax
  103943:	51                   	push   %ecx
  103944:	52                   	push   %edx
  103945:	0f b6 46 26          	movzbl 0x26(%esi),%eax
  103949:	50                   	push   %eax
  10394a:	0f b6 46 28          	movzbl 0x28(%esi),%eax
  10394e:	50                   	push   %eax
  10394f:	0f b6 46 25          	movzbl 0x25(%esi),%eax
  103953:	50                   	push   %eax
  103954:	0f b6 46 27          	movzbl 0x27(%esi),%eax
  103958:	50                   	push   %eax
  103959:	0f b6 46 24          	movzbl 0x24(%esi),%eax
  10395d:	50                   	push   %eax
  10395e:	8d 85 78 8d ff ff    	lea    -0x7288(%ebp),%eax
  103964:	ff 74 24 54          	push   0x54(%esp)
  103968:	ff 74 24 64          	push   0x64(%esp)
  10396c:	50                   	push   %eax
  10396d:	e8 4e 07 00 00       	call   1040c0 <debug_info>
}
  103972:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  103978:	5b                   	pop    %ebx
  103979:	5e                   	pop    %esi
  10397a:	5f                   	pop    %edi
  10397b:	5d                   	pop    %ebp
  10397c:	c3                   	ret
  10397d:	8d 76 00             	lea    0x0(%esi),%esi
        cpuinfo->l1_cache_size = 0;
  103980:	c7 46 38 00 00 00 00 	movl   $0x0,0x38(%esi)
        cpuinfo->l1_cache_line_size = 0;
  103987:	c7 46 3c 00 00 00 00 	movl   $0x0,0x3c(%esi)
        break;
  10398e:	e9 d0 fe ff ff       	jmp    103863 <pcpu_init_cpu+0x153>
  103993:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  103998:	83 ec 0c             	sub    $0xc,%esp
  10399b:	57                   	push   %edi
  10399c:	ff 74 24 18          	push   0x18(%esp)
  1039a0:	ff 74 24 18          	push   0x18(%esp)
  1039a4:	ff 74 24 18          	push   0x18(%esp)
  1039a8:	6a 02                	push   $0x2
  1039aa:	e8 71 14 00 00       	call   104e20 <cpuid>
        i = eax & 0x000000ff;
  1039af:	0f b6 44 24 40       	movzbl 0x40(%esp),%eax
        while (i--)
  1039b4:	83 c4 20             	add    $0x20,%esp
  1039b7:	85 c0                	test   %eax,%eax
  1039b9:	74 32                	je     1039ed <pcpu_init_cpu+0x2dd>
  1039bb:	89 74 24 0c          	mov    %esi,0xc(%esp)
  1039bf:	89 c6                	mov    %eax,%esi
  1039c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            cpuid(0x00000002, &eax, &ebx, &ecx, &edx);
  1039c8:	83 ec 0c             	sub    $0xc,%esp
  1039cb:	89 eb                	mov    %ebp,%ebx
  1039cd:	57                   	push   %edi
  1039ce:	ff 74 24 18          	push   0x18(%esp)
  1039d2:	ff 74 24 18          	push   0x18(%esp)
  1039d6:	ff 74 24 18          	push   0x18(%esp)
  1039da:	6a 02                	push   $0x2
  1039dc:	e8 3f 14 00 00       	call   104e20 <cpuid>
        while (i--)
  1039e1:	83 c4 20             	add    $0x20,%esp
  1039e4:	83 ee 01             	sub    $0x1,%esi
  1039e7:	75 df                	jne    1039c8 <pcpu_init_cpu+0x2b8>
  1039e9:	8b 74 24 0c          	mov    0xc(%esp),%esi
        for (i = 0; i < 4; i++) {
  1039ed:	8d 44 24 30          	lea    0x30(%esp),%eax
  1039f1:	89 7c 24 18          	mov    %edi,0x18(%esp)
  1039f5:	8d 8d 4c 92 ff ff    	lea    -0x6db4(%ebp),%ecx
  1039fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1039ff:	8d 44 24 40          	lea    0x40(%esp),%eax
  103a03:	89 44 24 14          	mov    %eax,0x14(%esp)
            for (j = 0; j < 4; j++) {
  103a07:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103a0b:	8b 00                	mov    (%eax),%eax
  103a0d:	8d 78 04             	lea    0x4(%eax),%edi
                cpuinfo->l1_cache_size = intel_cache_info[desc[j]][0];
  103a10:	0f b6 10             	movzbl (%eax),%edx
            for (j = 0; j < 4; j++) {
  103a13:	83 c0 01             	add    $0x1,%eax
                cpuinfo->l1_cache_size = intel_cache_info[desc[j]][0];
  103a16:	8b 14 d1             	mov    (%ecx,%edx,8),%edx
  103a19:	89 56 38             	mov    %edx,0x38(%esi)
                cpuinfo->l1_cache_line_size = intel_cache_info[desc[j]][1];
  103a1c:	0f b6 58 ff          	movzbl -0x1(%eax),%ebx
  103a20:	8b 5c d9 04          	mov    0x4(%ecx,%ebx,8),%ebx
  103a24:	89 5e 3c             	mov    %ebx,0x3c(%esi)
            for (j = 0; j < 4; j++) {
  103a27:	39 f8                	cmp    %edi,%eax
  103a29:	75 e5                	jne    103a10 <pcpu_init_cpu+0x300>
        for (i = 0; i < 4; i++) {
  103a2b:	83 44 24 0c 04       	addl   $0x4,0xc(%esp)
  103a30:	8b 7c 24 14          	mov    0x14(%esp),%edi
  103a34:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103a38:	39 f8                	cmp    %edi,%eax
  103a3a:	75 cb                	jne    103a07 <pcpu_init_cpu+0x2f7>
        if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103a3c:	8b 7c 24 18          	mov    0x18(%esp),%edi
  103a40:	85 d2                	test   %edx,%edx
  103a42:	0f 85 98 00 00 00    	jne    103ae0 <pcpu_init_cpu+0x3d0>
  103a48:	31 d2                	xor    %edx,%edx
  103a4a:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103a4e:	89 d6                	mov    %edx,%esi
            cpuid_subleaf(0x00000004, i, &eax, &ebx, &ecx, &edx);
  103a50:	83 ec 08             	sub    $0x8,%esp
  103a53:	89 eb                	mov    %ebp,%ebx
  103a55:	57                   	push   %edi
  103a56:	ff 74 24 14          	push   0x14(%esp)
  103a5a:	ff 74 24 14          	push   0x14(%esp)
  103a5e:	ff 74 24 14          	push   0x14(%esp)
  103a62:	56                   	push   %esi
  103a63:	6a 04                	push   $0x4
  103a65:	e8 f6 13 00 00       	call   104e60 <cpuid_subleaf>
            if ((eax & 0xf) == 1 && ((eax & 0xe0) >> 5) == 1)
  103a6a:	8b 44 24 40          	mov    0x40(%esp),%eax
  103a6e:	83 c4 20             	add    $0x20,%esp
  103a71:	25 ef 00 00 00       	and    $0xef,%eax
  103a76:	83 f8 21             	cmp    $0x21,%eax
  103a79:	74 72                	je     103aed <pcpu_init_cpu+0x3dd>
        for (i = 0; i < 3; i++) {
  103a7b:	83 c6 01             	add    $0x1,%esi
  103a7e:	83 fe 03             	cmp    $0x3,%esi
  103a81:	75 cd                	jne    103a50 <pcpu_init_cpu+0x340>
  103a83:	8b 74 24 0c          	mov    0xc(%esp),%esi
            KERN_WARN("Cannot determine L1 cache size.\n");
  103a87:	8d 85 e8 8d ff ff    	lea    -0x7218(%ebp),%eax
  103a8d:	83 ec 04             	sub    $0x4,%esp
  103a90:	50                   	push   %eax
  103a91:	8d 85 de 82 ff ff    	lea    -0x7d22(%ebp),%eax
  103a97:	6a 7c                	push   $0x7c
  103a99:	50                   	push   %eax
  103a9a:	e8 d1 07 00 00       	call   104270 <debug_warn>
            break;
  103a9f:	83 c4 10             	add    $0x10,%esp
  103aa2:	e9 bc fd ff ff       	jmp    103863 <pcpu_init_cpu+0x153>
  103aa7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103aae:	00 
  103aaf:	90                   	nop
    else if (strncmp(cpuinfo->vendor, "AuthenticAMD", 20) == 0)
  103ab0:	83 ec 04             	sub    $0x4,%esp
  103ab3:	8d 85 7e 83 ff ff    	lea    -0x7c82(%ebp),%eax
  103ab9:	6a 14                	push   $0x14
  103abb:	50                   	push   %eax
  103abc:	ff 74 24 1c          	push   0x1c(%esp)
  103ac0:	e8 4b 04 00 00       	call   103f10 <strncmp>
  103ac5:	83 c4 10             	add    $0x10,%esp
  103ac8:	85 c0                	test   %eax,%eax
  103aca:	0f 94 c0             	sete   %al
  103acd:	0f b6 c0             	movzbl %al,%eax
  103ad0:	01 c0                	add    %eax,%eax
  103ad2:	e9 e5 fc ff ff       	jmp    1037bc <pcpu_init_cpu+0xac>
  103ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103ade:	00 
  103adf:	90                   	nop
        if (cpuinfo->l1_cache_size && cpuinfo->l1_cache_line_size)
  103ae0:	85 db                	test   %ebx,%ebx
  103ae2:	0f 85 7b fd ff ff    	jne    103863 <pcpu_init_cpu+0x153>
  103ae8:	e9 5b ff ff ff       	jmp    103a48 <pcpu_init_cpu+0x338>
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103aed:	8b 5c 24 24          	mov    0x24(%esp),%ebx
            (ecx + 1) /                         /* sets */
  103af1:	8b 54 24 28          	mov    0x28(%esp),%edx
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103af5:	8b 74 24 0c          	mov    0xc(%esp),%esi
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103af9:	89 d8                	mov    %ebx,%eax
            (ecx + 1) /                         /* sets */
  103afb:	83 c2 01             	add    $0x1,%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103afe:	25 ff 0f 00 00       	and    $0xfff,%eax
  103b03:	8d 48 01             	lea    0x1(%eax),%ecx
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103b06:	89 d8                	mov    %ebx,%eax
            (((ebx & 0x003ff000) >> 12) + 1) *  /* partitions */
  103b08:	c1 eb 0c             	shr    $0xc,%ebx
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103b0b:	c1 e8 16             	shr    $0x16,%eax
        cpuinfo->l1_cache_line_size = ((ebx & 0x00000fff)) + 1;
  103b0e:	89 4e 3c             	mov    %ecx,0x3c(%esi)
            (((ebx & 0xffc00000) >> 22) + 1) *  /* ways */
  103b11:	83 c0 01             	add    $0x1,%eax
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103b14:	0f af c1             	imul   %ecx,%eax
  103b17:	0f af c2             	imul   %edx,%eax
            (((ebx & 0x003ff000) >> 12) + 1) *  /* partitions */
  103b1a:	89 da                	mov    %ebx,%edx
  103b1c:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  103b22:	83 c2 01             	add    $0x1,%edx
            (((ebx & 0x00000fff)) + 1) *        /* line size */
  103b25:	0f af c2             	imul   %edx,%eax
            (ecx + 1) /                         /* sets */
  103b28:	c1 e8 0a             	shr    $0xa,%eax
  103b2b:	89 46 38             	mov    %eax,0x38(%esi)
        break;
  103b2e:	e9 30 fd ff ff       	jmp    103863 <pcpu_init_cpu+0x153>
  103b33:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103b3a:	00 
  103b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00103b40 <pcpu_ncpu>:
    return ncpu;
  103b40:	e8 55 c8 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  103b45:	05 af d4 00 00       	add    $0xd4af,%eax
  103b4a:	8b 80 70 89 02 00    	mov    0x28970(%eax),%eax
}
  103b50:	c3                   	ret
  103b51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103b58:	00 
  103b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103b60 <pcpu_is_smp>:
    return ismp;
  103b60:	e8 35 c8 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  103b65:	05 8f d4 00 00       	add    $0xd48f,%eax
  103b6a:	0f b6 80 6c 89 02 00 	movzbl 0x2896c(%eax),%eax
}
  103b71:	c3                   	ret
  103b72:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103b79:	00 
  103b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103b80 <pcpu_onboot>:
{
  103b80:	53                   	push   %ebx
  103b81:	e8 1c c8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  103b86:	81 c3 6e d4 00 00    	add    $0xd46e,%ebx
  103b8c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_pcpu_idx();
  103b8f:	e8 0c 20 00 00       	call   105ba0 <get_pcpu_idx>
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103b94:	83 ec 0c             	sub    $0xc,%esp
  103b97:	50                   	push   %eax
  103b98:	e8 43 21 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103b9d:	83 c4 10             	add    $0x10,%esp
  103ba0:	80 bb 6d 89 02 00 01 	cmpb   $0x1,0x2896d(%ebx)
  103ba7:	75 0f                	jne    103bb8 <pcpu_onboot+0x38>
  103ba9:	0f b6 40 04          	movzbl 0x4(%eax),%eax
}
  103bad:	83 c4 08             	add    $0x8,%esp
  103bb0:	5b                   	pop    %ebx
  103bb1:	c3                   	ret
  103bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return (mp_inited == TRUE) ? arch_info->bsp : (get_pcpu_idx() == 0);
  103bb8:	e8 e3 1f 00 00       	call   105ba0 <get_pcpu_idx>
  103bbd:	85 c0                	test   %eax,%eax
  103bbf:	0f 94 c0             	sete   %al
}
  103bc2:	83 c4 08             	add    $0x8,%esp
  103bc5:	5b                   	pop    %ebx
  103bc6:	c3                   	ret
  103bc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103bce:	00 
  103bcf:	90                   	nop

00103bd0 <pcpu_cpu_lapicid>:
{
  103bd0:	57                   	push   %edi
  103bd1:	56                   	push   %esi
  103bd2:	53                   	push   %ebx
  103bd3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  103bd7:	e8 c6 c7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  103bdc:	81 c3 18 d4 00 00    	add    $0xd418,%ebx
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103be2:	83 ec 0c             	sub    $0xc,%esp
  103be5:	57                   	push   %edi
  103be6:	e8 f5 20 00 00       	call   105ce0 <get_pcpu_arch_info_pointer>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103beb:	83 c4 10             	add    $0x10,%esp
    struct pcpuinfo *arch_info = (struct pcpuinfo *) get_pcpu_arch_info_pointer(cpu_idx);
  103bee:	89 c6                	mov    %eax,%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < ncpu);
  103bf0:	85 ff                	test   %edi,%edi
  103bf2:	78 08                	js     103bfc <pcpu_cpu_lapicid+0x2c>
  103bf4:	3b bb 70 89 02 00    	cmp    0x28970(%ebx),%edi
  103bfa:	72 22                	jb     103c1e <pcpu_cpu_lapicid+0x4e>
  103bfc:	8d 83 34 8d ff ff    	lea    -0x72cc(%ebx),%eax
  103c02:	50                   	push   %eax
  103c03:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  103c09:	50                   	push   %eax
  103c0a:	8d 83 de 82 ff ff    	lea    -0x7d22(%ebx),%eax
  103c10:	68 ea 01 00 00       	push   $0x1ea
  103c15:	50                   	push   %eax
  103c16:	e8 45 05 00 00       	call   104160 <debug_panic>
  103c1b:	83 c4 10             	add    $0x10,%esp
    return arch_info->lapicid;
  103c1e:	0f b6 06             	movzbl (%esi),%eax
}
  103c21:	5b                   	pop    %ebx
  103c22:	5e                   	pop    %esi
  103c23:	5f                   	pop    %edi
  103c24:	c3                   	ret

00103c25 <__x86.get_pc_thunk.si>:
  103c25:	8b 34 24             	mov    (%esp),%esi
  103c28:	c3                   	ret
  103c29:	66 90                	xchg   %ax,%ax
  103c2b:	66 90                	xchg   %ax,%ax
  103c2d:	66 90                	xchg   %ax,%ax
  103c2f:	90                   	nop

00103c30 <detect_kvm>:
}

#define CPUID_FEATURE_HYPERVISOR	(1<<31) /* Running on a hypervisor */

int detect_kvm(void)
{
  103c30:	57                   	push   %edi
	__asm __volatile("cpuid"
  103c31:	b8 01 00 00 00       	mov    $0x1,%eax
  103c36:	31 c9                	xor    %ecx,%ecx
{
  103c38:	56                   	push   %esi
  103c39:	e8 e7 ff ff ff       	call   103c25 <__x86.get_pc_thunk.si>
  103c3e:	81 c6 b6 d3 00 00    	add    $0xd3b6,%esi
  103c44:	53                   	push   %ebx
  103c45:	83 ec 10             	sub    $0x10,%esp
	__asm __volatile("cpuid"
  103c48:	0f a2                	cpuid
	uint32_t eax;

	if (cpu_has (CPUID_FEATURE_HYPERVISOR))
  103c4a:	83 e2 01             	and    $0x1,%edx
  103c4d:	75 11                	jne    103c60 <detect_kvm+0x30>
		{
			return 1;
		}
	}
	return 0;
}
  103c4f:	83 c4 10             	add    $0x10,%esp
	return 0;
  103c52:	31 c0                	xor    %eax,%eax
}
  103c54:	5b                   	pop    %ebx
  103c55:	5e                   	pop    %esi
  103c56:	5f                   	pop    %edi
  103c57:	c3                   	ret
  103c58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103c5f:	00 
		cpuid (CPUID_KVM_SIGNATURE, &eax, &hyper_vendor_id[0],
  103c60:	83 ec 0c             	sub    $0xc,%esp
  103c63:	89 f3                	mov    %esi,%ebx
  103c65:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c69:	8d 7c 24 10          	lea    0x10(%esp),%edi
  103c6d:	50                   	push   %eax
  103c6e:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c72:	50                   	push   %eax
  103c73:	57                   	push   %edi
  103c74:	8d 44 24 18          	lea    0x18(%esp),%eax
  103c78:	50                   	push   %eax
  103c79:	68 00 00 00 40       	push   $0x40000000
  103c7e:	e8 9d 11 00 00       	call   104e20 <cpuid>
		if (!strncmp ("KVMKVMKVM", (const char *) hyper_vendor_id, 9))
  103c83:	83 c4 1c             	add    $0x1c,%esp
  103c86:	8d 86 8b 83 ff ff    	lea    -0x7c75(%esi),%eax
  103c8c:	6a 09                	push   $0x9
  103c8e:	57                   	push   %edi
  103c8f:	50                   	push   %eax
  103c90:	e8 7b 02 00 00       	call   103f10 <strncmp>
  103c95:	83 c4 10             	add    $0x10,%esp
  103c98:	85 c0                	test   %eax,%eax
  103c9a:	75 b3                	jne    103c4f <detect_kvm+0x1f>
}
  103c9c:	83 c4 10             	add    $0x10,%esp
			return 1;
  103c9f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  103ca4:	5b                   	pop    %ebx
  103ca5:	5e                   	pop    %esi
  103ca6:	5f                   	pop    %edi
  103ca7:	c3                   	ret
  103ca8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103caf:	00 

00103cb0 <kvm_has_feature>:

int
kvm_has_feature(uint32_t feature)
{
  103cb0:	53                   	push   %ebx
  103cb1:	e8 ec c6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  103cb6:	81 c3 3e d3 00 00    	add    $0xd33e,%ebx
  103cbc:	83 ec 24             	sub    $0x24,%esp
	uint32_t eax, ebx, ecx, edx;
	eax = 0; edx = 0;
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103cbf:	8d 44 24 18          	lea    0x18(%esp),%eax
	eax = 0; edx = 0;
  103cc3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  103cca:	00 
  103ccb:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  103cd2:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103cd3:	50                   	push   %eax
  103cd4:	8d 44 24 18          	lea    0x18(%esp),%eax
  103cd8:	50                   	push   %eax
  103cd9:	8d 44 24 18          	lea    0x18(%esp),%eax
  103cdd:	50                   	push   %eax
  103cde:	8d 44 24 18          	lea    0x18(%esp),%eax
  103ce2:	50                   	push   %eax
  103ce3:	68 01 00 00 40       	push   $0x40000001
  103ce8:	e8 33 11 00 00       	call   104e20 <cpuid>

	return ((eax & feature) != 0 ? 1 : 0);
  103ced:	8b 44 24 40          	mov    0x40(%esp),%eax
  103cf1:	23 44 24 20          	and    0x20(%esp),%eax
  103cf5:	85 c0                	test   %eax,%eax
  103cf7:	0f 95 c0             	setne  %al
}
  103cfa:	83 c4 38             	add    $0x38,%esp
	return ((eax & feature) != 0 ? 1 : 0);
  103cfd:	0f b6 c0             	movzbl %al,%eax
}
  103d00:	5b                   	pop    %ebx
  103d01:	c3                   	ret
  103d02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103d09:	00 
  103d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103d10 <kvm_enable_feature>:

int
kvm_enable_feature(uint32_t feature)
{
  103d10:	53                   	push   %ebx
	uint32_t eax, ebx, ecx, edx;
	eax = 1 << feature; edx = 0;
  103d11:	b8 01 00 00 00       	mov    $0x1,%eax
  103d16:	e8 87 c6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  103d1b:	81 c3 d9 d2 00 00    	add    $0xd2d9,%ebx
{
  103d21:	83 ec 24             	sub    $0x24,%esp
	eax = 1 << feature; edx = 0;
  103d24:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
  103d28:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  103d2f:	00 
  103d30:	d3 e0                	shl    %cl,%eax
  103d32:	89 44 24 0c          	mov    %eax,0xc(%esp)
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103d36:	8d 44 24 18          	lea    0x18(%esp),%eax
  103d3a:	50                   	push   %eax
  103d3b:	8d 44 24 18          	lea    0x18(%esp),%eax
  103d3f:	50                   	push   %eax
  103d40:	8d 44 24 18          	lea    0x18(%esp),%eax
  103d44:	50                   	push   %eax
  103d45:	8d 44 24 18          	lea    0x18(%esp),%eax
  103d49:	50                   	push   %eax
  103d4a:	68 01 00 00 40       	push   $0x40000001
  103d4f:	e8 cc 10 00 00       	call   104e20 <cpuid>

	return (ebx == 0 ? 1 : 0);
  103d54:	8b 54 24 24          	mov    0x24(%esp),%edx
  103d58:	31 c0                	xor    %eax,%eax
  103d5a:	85 d2                	test   %edx,%edx
  103d5c:	0f 94 c0             	sete   %al
}
  103d5f:	83 c4 38             	add    $0x38,%esp
  103d62:	5b                   	pop    %ebx
  103d63:	c3                   	ret
  103d64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103d6b:	00 
  103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103d70 <kvm_get_tsc_hz>:

uint64_t
kvm_get_tsc_hz(void)
{
  103d70:	55                   	push   %ebp
  103d71:	57                   	push   %edi
  103d72:	56                   	push   %esi
  103d73:	53                   	push   %ebx
  103d74:	e8 29 c6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  103d79:	81 c3 7b d2 00 00    	add    $0xd27b,%ebx
  103d7f:	83 ec 38             	sub    $0x38,%esp
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103d82:	8d 44 24 28          	lea    0x28(%esp),%eax
	eax = 0; edx = 0;
  103d86:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  103d8d:	00 
  103d8e:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  103d95:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103d96:	50                   	push   %eax
  103d97:	8d 6c 24 28          	lea    0x28(%esp),%ebp
  103d9b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  103d9f:	55                   	push   %ebp
  103da0:	8d 7c 24 28          	lea    0x28(%esp),%edi
  103da4:	57                   	push   %edi
  103da5:	8d 74 24 28          	lea    0x28(%esp),%esi
  103da9:	56                   	push   %esi
  103daa:	68 01 00 00 40       	push   $0x40000001
  103daf:	e8 6c 10 00 00       	call   104e20 <cpuid>
	uint64_t tsc_hz = 0llu;
	uint32_t msr_sys_time;

	if (kvm_has_feature(KVM_FEATURE_CLOCKSOURCE2))
  103db4:	83 c4 20             	add    $0x20,%esp
  103db7:	f6 44 24 10 03       	testb  $0x3,0x10(%esp)
  103dbc:	75 42                	jne    103e00 <kvm_get_tsc_hz+0x90>
	eax = 0; edx = 0;
  103dbe:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  103dc5:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103dc6:	83 ec 0c             	sub    $0xc,%esp
	eax = 0; edx = 0;
  103dc9:	c7 44 24 28 00 00 00 	movl   $0x0,0x28(%esp)
  103dd0:	00 
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103dd1:	8b 44 24 18          	mov    0x18(%esp),%eax
  103dd5:	50                   	push   %eax
  103dd6:	55                   	push   %ebp
  103dd7:	57                   	push   %edi
	{
		msr_sys_time = MSR_KVM_SYSTEM_TIME;
	}
	else
	{
		return (0llu);
  103dd8:	31 ff                	xor    %edi,%edi
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103dda:	56                   	push   %esi
		return (0llu);
  103ddb:	31 f6                	xor    %esi,%esi
	cpuid(CPUID_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
  103ddd:	68 01 00 00 40       	push   $0x40000001
  103de2:	e8 39 10 00 00       	call   104e20 <cpuid>
	return ((eax & feature) != 0 ? 1 : 0);
  103de7:	83 c4 20             	add    $0x20,%esp

	/* disable update */
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));

	return tsc_hz;
}
  103dea:	89 f0                	mov    %esi,%eax
  103dec:	89 fa                	mov    %edi,%edx
  103dee:	83 c4 2c             	add    $0x2c,%esp
  103df1:	5b                   	pop    %ebx
  103df2:	5e                   	pop    %esi
  103df3:	5f                   	pop    %edi
  103df4:	5d                   	pop    %ebp
  103df5:	c3                   	ret
  103df6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103dfd:	00 
  103dfe:	66 90                	xchg   %ax,%ax
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock) | 0x1llu);
  103e00:	8d ab 8c 89 02 00    	lea    0x2898c(%ebx),%ebp
  103e06:	83 ec 04             	sub    $0x4,%esp
  103e09:	31 d2                	xor    %edx,%edx
	tsc_hz = (uint64_t) pvclock.tsc_to_system_mul;
  103e0b:	31 ff                	xor    %edi,%edi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock) | 0x1llu);
  103e0d:	89 e8                	mov    %ebp,%eax
  103e0f:	52                   	push   %edx
  103e10:	83 c8 01             	or     $0x1,%eax
  103e13:	50                   	push   %eax
  103e14:	68 01 4d 56 4b       	push   $0x4b564d01
  103e19:	e8 72 0f 00 00       	call   104d90 <wrmsr>
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));
  103e1e:	83 c4 0c             	add    $0xc,%esp
  103e21:	31 d2                	xor    %edx,%edx
	tsc_hz = (uint64_t) pvclock.tsc_to_system_mul;
  103e23:	8b b3 a4 89 02 00    	mov    0x289a4(%ebx),%esi
	wrmsr(msr_sys_time, (uint64_t) ((uint32_t) &pvclock));
  103e29:	52                   	push   %edx
  103e2a:	55                   	push   %ebp
  103e2b:	68 01 4d 56 4b       	push   $0x4b564d01
  103e30:	e8 5b 0f 00 00       	call   104d90 <wrmsr>
	return tsc_hz;
  103e35:	83 c4 10             	add    $0x10,%esp
}
  103e38:	89 f0                	mov    %esi,%eax
  103e3a:	89 fa                	mov    %edi,%edx
  103e3c:	83 c4 2c             	add    $0x2c,%esp
  103e3f:	5b                   	pop    %ebx
  103e40:	5e                   	pop    %esi
  103e41:	5f                   	pop    %edi
  103e42:	5d                   	pop    %ebp
  103e43:	c3                   	ret
  103e44:	66 90                	xchg   %ax,%ax
  103e46:	66 90                	xchg   %ax,%ax
  103e48:	66 90                	xchg   %ax,%ax
  103e4a:	66 90                	xchg   %ax,%ax
  103e4c:	66 90                	xchg   %ax,%ax
  103e4e:	66 90                	xchg   %ax,%ax

00103e50 <memset>:
#include "string.h"
#include "types.h"

void *memset(void *v, int c, size_t n)
{
  103e50:	57                   	push   %edi
  103e51:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  103e55:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
  103e59:	85 c9                	test   %ecx,%ecx
  103e5b:	74 19                	je     103e76 <memset+0x26>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
  103e5d:	89 f8                	mov    %edi,%eax
  103e5f:	09 c8                	or     %ecx,%eax
  103e61:	a8 03                	test   $0x3,%al
  103e63:	75 1b                	jne    103e80 <memset+0x30>
        c &= 0xFF;
  103e65:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
  103e6a:	c1 e9 02             	shr    $0x2,%ecx
  103e6d:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
        asm volatile ("cld; rep stosl\n"
  103e73:	fc                   	cld
  103e74:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
  103e76:	89 f8                	mov    %edi,%eax
  103e78:	5f                   	pop    %edi
  103e79:	c3                   	ret
  103e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
  103e80:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103e84:	fc                   	cld
  103e85:	f3 aa                	rep stos %al,%es:(%edi)
}
  103e87:	89 f8                	mov    %edi,%eax
  103e89:	5f                   	pop    %edi
  103e8a:	c3                   	ret
  103e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00103e90 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
  103e90:	57                   	push   %edi
  103e91:	56                   	push   %esi
  103e92:	8b 44 24 0c          	mov    0xc(%esp),%eax
  103e96:	8b 74 24 10          	mov    0x10(%esp),%esi
  103e9a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
  103e9e:	39 c6                	cmp    %eax,%esi
  103ea0:	73 26                	jae    103ec8 <memmove+0x38>
  103ea2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
  103ea5:	39 d0                	cmp    %edx,%eax
  103ea7:	73 1f                	jae    103ec8 <memmove+0x38>
        s += n;
        d += n;
  103ea9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
  103eac:	89 fe                	mov    %edi,%esi
  103eae:	09 ce                	or     %ecx,%esi
  103eb0:	09 d6                	or     %edx,%esi
  103eb2:	83 e6 03             	and    $0x3,%esi
  103eb5:	74 39                	je     103ef0 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
  103eb7:	83 ef 01             	sub    $0x1,%edi
  103eba:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
  103ebd:	fd                   	std
  103ebe:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
  103ec0:	fc                   	cld
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
  103ec1:	5e                   	pop    %esi
  103ec2:	5f                   	pop    %edi
  103ec3:	c3                   	ret
  103ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
  103ec8:	89 c2                	mov    %eax,%edx
  103eca:	09 ca                	or     %ecx,%edx
  103ecc:	09 f2                	or     %esi,%edx
  103ece:	83 e2 03             	and    $0x3,%edx
  103ed1:	74 0d                	je     103ee0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
  103ed3:	89 c7                	mov    %eax,%edi
  103ed5:	fc                   	cld
  103ed6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
  103ed8:	5e                   	pop    %esi
  103ed9:	5f                   	pop    %edi
  103eda:	c3                   	ret
  103edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                          :: "D" (d), "S" (s), "c" (n / 4)
  103ee0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
  103ee3:	89 c7                	mov    %eax,%edi
  103ee5:	fc                   	cld
  103ee6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103ee8:	eb ee                	jmp    103ed8 <memmove+0x48>
  103eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
  103ef0:	83 ef 04             	sub    $0x4,%edi
  103ef3:	8d 72 fc             	lea    -0x4(%edx),%esi
  103ef6:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
  103ef9:	fd                   	std
  103efa:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103efc:	eb c2                	jmp    103ec0 <memmove+0x30>
  103efe:	66 90                	xchg   %ax,%ax

00103f00 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
  103f00:	eb 8e                	jmp    103e90 <memmove>
  103f02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103f09:	00 
  103f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103f10 <strncmp>:
}

int strncmp(const char *p, const char *q, size_t n)
{
  103f10:	53                   	push   %ebx
  103f11:	8b 54 24 10          	mov    0x10(%esp),%edx
  103f15:	8b 44 24 08          	mov    0x8(%esp),%eax
  103f19:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (n > 0 && *p && *p == *q)
  103f1d:	85 d2                	test   %edx,%edx
  103f1f:	75 16                	jne    103f37 <strncmp+0x27>
  103f21:	eb 2d                	jmp    103f50 <strncmp+0x40>
  103f23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  103f28:	3a 19                	cmp    (%ecx),%bl
  103f2a:	75 12                	jne    103f3e <strncmp+0x2e>
        n--, p++, q++;
  103f2c:	83 c0 01             	add    $0x1,%eax
  103f2f:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
  103f32:	83 ea 01             	sub    $0x1,%edx
  103f35:	74 19                	je     103f50 <strncmp+0x40>
  103f37:	0f b6 18             	movzbl (%eax),%ebx
  103f3a:	84 db                	test   %bl,%bl
  103f3c:	75 ea                	jne    103f28 <strncmp+0x18>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
  103f3e:	0f b6 00             	movzbl (%eax),%eax
  103f41:	0f b6 11             	movzbl (%ecx),%edx
}
  103f44:	5b                   	pop    %ebx
        return (int) ((unsigned char) *p - (unsigned char) *q);
  103f45:	29 d0                	sub    %edx,%eax
}
  103f47:	c3                   	ret
  103f48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103f4f:	00 
        return 0;
  103f50:	31 c0                	xor    %eax,%eax
}
  103f52:	5b                   	pop    %ebx
  103f53:	c3                   	ret
  103f54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103f5b:	00 
  103f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103f60 <strnlen>:

int strnlen(const char *s, size_t size)
{
  103f60:	8b 54 24 08          	mov    0x8(%esp),%edx
  103f64:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103f68:	31 c0                	xor    %eax,%eax
  103f6a:	85 d2                	test   %edx,%edx
  103f6c:	75 09                	jne    103f77 <strnlen+0x17>
  103f6e:	c3                   	ret
  103f6f:	90                   	nop
        n++;
  103f70:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
  103f73:	39 c2                	cmp    %eax,%edx
  103f75:	74 09                	je     103f80 <strnlen+0x20>
  103f77:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  103f7b:	75 f3                	jne    103f70 <strnlen+0x10>
  103f7d:	c3                   	ret
  103f7e:	66 90                	xchg   %ax,%ax
    return n;
}
  103f80:	c3                   	ret
  103f81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  103f88:	00 
  103f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103f90 <strcmp>:

int strcmp(const char *p, const char *q)
{
  103f90:	53                   	push   %ebx
  103f91:	8b 54 24 08          	mov    0x8(%esp),%edx
  103f95:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
  103f99:	0f b6 02             	movzbl (%edx),%eax
  103f9c:	84 c0                	test   %al,%al
  103f9e:	75 18                	jne    103fb8 <strcmp+0x28>
  103fa0:	eb 30                	jmp    103fd2 <strcmp+0x42>
  103fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103fa8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
  103fac:	83 c2 01             	add    $0x1,%edx
  103faf:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
  103fb2:	84 c0                	test   %al,%al
  103fb4:	74 12                	je     103fc8 <strcmp+0x38>
  103fb6:	89 d9                	mov    %ebx,%ecx
  103fb8:	0f b6 19             	movzbl (%ecx),%ebx
  103fbb:	38 c3                	cmp    %al,%bl
  103fbd:	74 e9                	je     103fa8 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
  103fbf:	29 d8                	sub    %ebx,%eax
}
  103fc1:	5b                   	pop    %ebx
  103fc2:	c3                   	ret
  103fc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return (int) ((unsigned char) *p - (unsigned char) *q);
  103fc8:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  103fcc:	31 c0                	xor    %eax,%eax
  103fce:	29 d8                	sub    %ebx,%eax
}
  103fd0:	5b                   	pop    %ebx
  103fd1:	c3                   	ret
    return (int) ((unsigned char) *p - (unsigned char) *q);
  103fd2:	0f b6 19             	movzbl (%ecx),%ebx
  103fd5:	31 c0                	xor    %eax,%eax
  103fd7:	eb e6                	jmp    103fbf <strcmp+0x2f>
  103fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103fe0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *strchr(const char *s, char c)
{
  103fe0:	8b 44 24 04          	mov    0x4(%esp),%eax
  103fe4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
  103fe9:	0f b6 10             	movzbl (%eax),%edx
  103fec:	84 d2                	test   %dl,%dl
  103fee:	75 13                	jne    104003 <strchr+0x23>
  103ff0:	eb 1e                	jmp    104010 <strchr+0x30>
  103ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103ff8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
  103ffc:	83 c0 01             	add    $0x1,%eax
  103fff:	84 d2                	test   %dl,%dl
  104001:	74 0d                	je     104010 <strchr+0x30>
        if (*s == c)
  104003:	38 d1                	cmp    %dl,%cl
  104005:	75 f1                	jne    103ff8 <strchr+0x18>
            return (char *) s;
    return 0;
}
  104007:	c3                   	ret
  104008:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10400f:	00 
    return 0;
  104010:	31 c0                	xor    %eax,%eax
}
  104012:	c3                   	ret
  104013:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10401a:	00 
  10401b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104020 <memzero>:

void *memzero(void *v, size_t n)
{
  104020:	57                   	push   %edi
  104021:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  104025:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
  104029:	85 c9                	test   %ecx,%ecx
  10402b:	74 0f                	je     10403c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
  10402d:	89 f8                	mov    %edi,%eax
  10402f:	09 c8                	or     %ecx,%eax
  104031:	83 e0 03             	and    $0x3,%eax
  104034:	75 0a                	jne    104040 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
  104036:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
  104039:	fc                   	cld
  10403a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
  10403c:	89 f8                	mov    %edi,%eax
  10403e:	5f                   	pop    %edi
  10403f:	c3                   	ret
        asm volatile ("cld; rep stosb\n"
  104040:	31 c0                	xor    %eax,%eax
  104042:	fc                   	cld
  104043:	f3 aa                	rep stos %al,%es:(%edi)
}
  104045:	89 f8                	mov    %edi,%eax
  104047:	5f                   	pop    %edi
  104048:	c3                   	ret
  104049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104050 <memcmp>:

int memcmp(const void *v1, const void *v2, size_t n)
{
  104050:	56                   	push   %esi
  104051:	53                   	push   %ebx
  104052:	8b 74 24 14          	mov    0x14(%esp),%esi
  104056:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10405a:	8b 54 24 10          	mov    0x10(%esp),%edx
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
  10405e:	85 f6                	test   %esi,%esi
  104060:	74 2e                	je     104090 <memcmp+0x40>
  104062:	01 c6                	add    %eax,%esi
  104064:	eb 14                	jmp    10407a <memcmp+0x2a>
  104066:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10406d:	00 
  10406e:	66 90                	xchg   %ax,%ax
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
  104070:	83 c0 01             	add    $0x1,%eax
  104073:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
  104076:	39 f0                	cmp    %esi,%eax
  104078:	74 16                	je     104090 <memcmp+0x40>
        if (*s1 != *s2)
  10407a:	0f b6 08             	movzbl (%eax),%ecx
  10407d:	0f b6 1a             	movzbl (%edx),%ebx
  104080:	38 d9                	cmp    %bl,%cl
  104082:	74 ec                	je     104070 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
  104084:	0f b6 c1             	movzbl %cl,%eax
  104087:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
  104089:	5b                   	pop    %ebx
  10408a:	5e                   	pop    %esi
  10408b:	c3                   	ret
  10408c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  104090:	31 c0                	xor    %eax,%eax
}
  104092:	5b                   	pop    %ebx
  104093:	5e                   	pop    %esi
  104094:	c3                   	ret
  104095:	66 90                	xchg   %ax,%ax
  104097:	66 90                	xchg   %ax,%ax
  104099:	66 90                	xchg   %ax,%ax
  10409b:	66 90                	xchg   %ax,%ax
  10409d:	66 90                	xchg   %ax,%ax
  10409f:	90                   	nop

001040a0 <debug_init>:
#include <lib/types.h>
#include <lib/spinlock.h>
spinlock_t dprintf_lock;

void debug_init(void)
{
  1040a0:	53                   	push   %ebx
  1040a1:	e8 fc c2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1040a6:	81 c3 4e cf 00 00    	add    $0xcf4e,%ebx
  1040ac:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&dprintf_lock);
  1040af:	8d 83 ac 89 02 00    	lea    0x289ac(%ebx),%eax
  1040b5:	50                   	push   %eax
  1040b6:	e8 45 17 00 00       	call   105800 <spinlock_init>
}
  1040bb:	83 c4 18             	add    $0x18,%esp
  1040be:	5b                   	pop    %ebx
  1040bf:	c3                   	ret

001040c0 <debug_info>:

extern int vdprintf(const char *fmt, va_list ap);

void debug_info(const char *fmt, ...)
{
  1040c0:	56                   	push   %esi
  1040c1:	53                   	push   %ebx
  1040c2:	e8 db c2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1040c7:	81 c3 2d cf 00 00    	add    $0xcf2d,%ebx
  1040cd:	83 ec 10             	sub    $0x10,%esp
#ifdef DEBUG_MSG
    spinlock_acquire(&dprintf_lock);
  1040d0:	8d b3 ac 89 02 00    	lea    0x289ac(%ebx),%esi
  1040d6:	56                   	push   %esi
  1040d7:	e8 b4 17 00 00       	call   105890 <spinlock_acquire>

    va_list ap;
    va_start(ap, fmt);
  1040dc:	8d 44 24 24          	lea    0x24(%esp),%eax
    vdprintf(fmt, ap);
  1040e0:	5a                   	pop    %edx
  1040e1:	59                   	pop    %ecx
  1040e2:	50                   	push   %eax
  1040e3:	ff 74 24 1c          	push   0x1c(%esp)
  1040e7:	e8 54 02 00 00       	call   104340 <vdprintf>
    va_end(ap);
    spinlock_release(&dprintf_lock);
  1040ec:	89 34 24             	mov    %esi,(%esp)
  1040ef:	e8 1c 18 00 00       	call   105910 <spinlock_release>

#endif
}
  1040f4:	83 c4 14             	add    $0x14,%esp
  1040f7:	5b                   	pop    %ebx
  1040f8:	5e                   	pop    %esi
  1040f9:	c3                   	ret
  1040fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104100 <debug_normal>:

#ifdef DEBUG_MSG

void debug_normal(const char *file, int line, const char *fmt, ...)
{
  104100:	56                   	push   %esi
  104101:	53                   	push   %ebx
  104102:	e8 9b c2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104107:	81 c3 ed ce 00 00    	add    $0xceed,%ebx
  10410d:	83 ec 10             	sub    $0x10,%esp
    spinlock_acquire(&dprintf_lock);
  104110:	8d b3 ac 89 02 00    	lea    0x289ac(%ebx),%esi
  104116:	56                   	push   %esi
  104117:	e8 74 17 00 00       	call   105890 <spinlock_acquire>
    dprintf("[D] %s:%d: ", file, line);
  10411c:	83 c4 0c             	add    $0xc,%esp
  10411f:	8d 83 95 83 ff ff    	lea    -0x7c6b(%ebx),%eax
  104125:	ff 74 24 18          	push   0x18(%esp)
  104129:	ff 74 24 18          	push   0x18(%esp)
  10412d:	50                   	push   %eax
  10412e:	e8 9d 02 00 00       	call   1043d0 <dprintf>

    va_list ap;
    va_start(ap, fmt);
  104133:	8d 44 24 2c          	lea    0x2c(%esp),%eax
    vdprintf(fmt, ap);
  104137:	5a                   	pop    %edx
  104138:	59                   	pop    %ecx
  104139:	50                   	push   %eax
  10413a:	ff 74 24 24          	push   0x24(%esp)
  10413e:	e8 fd 01 00 00       	call   104340 <vdprintf>
    va_end(ap);
    spinlock_release(&dprintf_lock);
  104143:	89 34 24             	mov    %esi,(%esp)
  104146:	e8 c5 17 00 00       	call   105910 <spinlock_release>
}
  10414b:	83 c4 14             	add    $0x14,%esp
  10414e:	5b                   	pop    %ebx
  10414f:	5e                   	pop    %esi
  104150:	c3                   	ret
  104151:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104158:	00 
  104159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104160 <debug_panic>:
    for (; i < DEBUG_TRACEFRAMES; i++)
        eips[i] = 0;
}

gcc_noinline void debug_panic(const char *file, int line, const char *fmt, ...)
{
  104160:	55                   	push   %ebp
  104161:	57                   	push   %edi
  104162:	56                   	push   %esi
  104163:	53                   	push   %ebx
  104164:	e8 39 c2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104169:	81 c3 8b ce 00 00    	add    $0xce8b,%ebx
  10416f:	83 ec 58             	sub    $0x58,%esp
    int i;
    uintptr_t eips[DEBUG_TRACEFRAMES];
    va_list ap;

    spinlock_acquire(&dprintf_lock);
  104172:	8d 83 ac 89 02 00    	lea    0x289ac(%ebx),%eax
  104178:	89 44 24 18          	mov    %eax,0x18(%esp)
  10417c:	50                   	push   %eax
  10417d:	e8 0e 17 00 00       	call   105890 <spinlock_acquire>

    dprintf("[P] %s:%d: ", file, line);
  104182:	83 c4 0c             	add    $0xc,%esp
  104185:	8d 83 a1 83 ff ff    	lea    -0x7c5f(%ebx),%eax
  10418b:	ff 74 24 68          	push   0x68(%esp)
  10418f:	ff 74 24 68          	push   0x68(%esp)
  104193:	50                   	push   %eax
  104194:	e8 37 02 00 00       	call   1043d0 <dprintf>

    va_start(ap, fmt);
  104199:	8d 44 24 7c          	lea    0x7c(%esp),%eax
    vdprintf(fmt, ap);
  10419d:	5a                   	pop    %edx
  10419e:	59                   	pop    %ecx
  10419f:	50                   	push   %eax
  1041a0:	ff 74 24 74          	push   0x74(%esp)
  1041a4:	e8 97 01 00 00       	call   104340 <vdprintf>
    va_end(ap);

    debug_trace(read_ebp(), eips);
  1041a9:	e8 92 0b 00 00       	call   104d40 <read_ebp>
    for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  1041ae:	83 c4 10             	add    $0x10,%esp
  1041b1:	31 c9                	xor    %ecx,%ecx
  1041b3:	8d 54 24 18          	lea    0x18(%esp),%edx
  1041b7:	85 c0                	test   %eax,%eax
  1041b9:	74 1e                	je     1041d9 <debug_panic+0x79>
  1041bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        eips[i] = frame[1];              /* saved %eip */
  1041c0:	8b 70 04             	mov    0x4(%eax),%esi
        frame = (uintptr_t *) frame[0];  /* saved %ebp */
  1041c3:	8b 00                	mov    (%eax),%eax
        eips[i] = frame[1];              /* saved %eip */
  1041c5:	89 34 8a             	mov    %esi,(%edx,%ecx,4)
    for (i = 0; i < DEBUG_TRACEFRAMES && frame; i++) {
  1041c8:	83 c1 01             	add    $0x1,%ecx
  1041cb:	83 f9 09             	cmp    $0x9,%ecx
  1041ce:	7f 04                	jg     1041d4 <debug_panic+0x74>
  1041d0:	85 c0                	test   %eax,%eax
  1041d2:	75 ec                	jne    1041c0 <debug_panic+0x60>
    for (; i < DEBUG_TRACEFRAMES; i++)
  1041d4:	83 f9 0a             	cmp    $0xa,%ecx
  1041d7:	74 3b                	je     104214 <debug_panic+0xb4>
  1041d9:	8d 04 8a             	lea    (%edx,%ecx,4),%eax
  1041dc:	8d 4c 24 40          	lea    0x40(%esp),%ecx
  1041e0:	89 ce                	mov    %ecx,%esi
  1041e2:	29 c6                	sub    %eax,%esi
  1041e4:	83 e6 04             	and    $0x4,%esi
  1041e7:	74 17                	je     104200 <debug_panic+0xa0>
        eips[i] = 0;
  1041e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for (; i < DEBUG_TRACEFRAMES; i++)
  1041ef:	8d 7c 24 40          	lea    0x40(%esp),%edi
  1041f3:	83 c0 04             	add    $0x4,%eax
  1041f6:	39 f8                	cmp    %edi,%eax
  1041f8:	74 1a                	je     104214 <debug_panic+0xb4>
  1041fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        eips[i] = 0;
  104200:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for (; i < DEBUG_TRACEFRAMES; i++)
  104206:	83 c0 08             	add    $0x8,%eax
        eips[i] = 0;
  104209:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
    for (; i < DEBUG_TRACEFRAMES; i++)
  104210:	39 c8                	cmp    %ecx,%eax
  104212:	75 ec                	jne    104200 <debug_panic+0xa0>
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  104214:	89 d5                	mov    %edx,%ebp
  104216:	8d 7c 24 40          	lea    0x40(%esp),%edi
        dprintf("\tfrom 0x%08x\n", eips[i]);
  10421a:	8d b3 ad 83 ff ff    	lea    -0x7c53(%ebx),%esi
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  104220:	8b 45 00             	mov    0x0(%ebp),%eax
  104223:	85 c0                	test   %eax,%eax
  104225:	74 14                	je     10423b <debug_panic+0xdb>
        dprintf("\tfrom 0x%08x\n", eips[i]);
  104227:	83 ec 08             	sub    $0x8,%esp
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  10422a:	83 c5 04             	add    $0x4,%ebp
        dprintf("\tfrom 0x%08x\n", eips[i]);
  10422d:	50                   	push   %eax
  10422e:	56                   	push   %esi
  10422f:	e8 9c 01 00 00       	call   1043d0 <dprintf>
    for (i = 0; i < DEBUG_TRACEFRAMES && eips[i] != 0; i++)
  104234:	83 c4 10             	add    $0x10,%esp
  104237:	39 ef                	cmp    %ebp,%edi
  104239:	75 e5                	jne    104220 <debug_panic+0xc0>

    dprintf("Kernel Panic !!!\n");
  10423b:	83 ec 0c             	sub    $0xc,%esp
  10423e:	8d 83 bb 83 ff ff    	lea    -0x7c45(%ebx),%eax
  104244:	50                   	push   %eax
  104245:	e8 86 01 00 00       	call   1043d0 <dprintf>
    spinlock_release(&dprintf_lock);
  10424a:	58                   	pop    %eax
  10424b:	ff 74 24 18          	push   0x18(%esp)
  10424f:	e8 bc 16 00 00       	call   105910 <spinlock_release>

    halt();
  104254:	e8 47 0b 00 00       	call   104da0 <halt>
}
  104259:	83 c4 5c             	add    $0x5c,%esp
  10425c:	5b                   	pop    %ebx
  10425d:	5e                   	pop    %esi
  10425e:	5f                   	pop    %edi
  10425f:	5d                   	pop    %ebp
  104260:	c3                   	ret
  104261:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104268:	00 
  104269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104270 <debug_warn>:

void debug_warn(const char *file, int line, const char *fmt, ...)
{
  104270:	56                   	push   %esi
  104271:	53                   	push   %ebx
  104272:	e8 2b c1 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104277:	81 c3 7d cd 00 00    	add    $0xcd7d,%ebx
  10427d:	83 ec 10             	sub    $0x10,%esp
    spinlock_acquire(&dprintf_lock);
  104280:	8d b3 ac 89 02 00    	lea    0x289ac(%ebx),%esi
  104286:	56                   	push   %esi
  104287:	e8 04 16 00 00       	call   105890 <spinlock_acquire>

    dprintf("[W] %s:%d: ", file, line);
  10428c:	83 c4 0c             	add    $0xc,%esp
  10428f:	8d 83 cd 83 ff ff    	lea    -0x7c33(%ebx),%eax
  104295:	ff 74 24 18          	push   0x18(%esp)
  104299:	ff 74 24 18          	push   0x18(%esp)
  10429d:	50                   	push   %eax
  10429e:	e8 2d 01 00 00       	call   1043d0 <dprintf>

    va_list ap;
    va_start(ap, fmt);
  1042a3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
    vdprintf(fmt, ap);
  1042a7:	5a                   	pop    %edx
  1042a8:	59                   	pop    %ecx
  1042a9:	50                   	push   %eax
  1042aa:	ff 74 24 24          	push   0x24(%esp)
  1042ae:	e8 8d 00 00 00       	call   104340 <vdprintf>
    va_end(ap);
    spinlock_release(&dprintf_lock);
  1042b3:	89 34 24             	mov    %esi,(%esp)
  1042b6:	e8 55 16 00 00       	call   105910 <spinlock_release>
}
  1042bb:	83 c4 14             	add    $0x14,%esp
  1042be:	5b                   	pop    %ebx
  1042bf:	5e                   	pop    %esi
  1042c0:	c3                   	ret
  1042c1:	66 90                	xchg   %ax,%ax
  1042c3:	66 90                	xchg   %ax,%ax
  1042c5:	66 90                	xchg   %ax,%ax
  1042c7:	66 90                	xchg   %ax,%ax
  1042c9:	66 90                	xchg   %ax,%ax
  1042cb:	66 90                	xchg   %ax,%ax
  1042cd:	66 90                	xchg   %ax,%ax
  1042cf:	90                   	nop

001042d0 <putch>:
        str += 1;
    }
}

static void putch(int ch, struct dprintbuf *b)
{
  1042d0:	57                   	push   %edi
  1042d1:	56                   	push   %esi
  1042d2:	53                   	push   %ebx
  1042d3:	8b 74 24 14          	mov    0x14(%esp),%esi
  1042d7:	e8 c6 c0 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1042dc:	81 c3 18 cd 00 00    	add    $0xcd18,%ebx
    b->buf[b->idx++] = ch;
  1042e2:	8b 54 24 10          	mov    0x10(%esp),%edx
  1042e6:	8b 0e                	mov    (%esi),%ecx
  1042e8:	8d 41 01             	lea    0x1(%ecx),%eax
  1042eb:	89 06                	mov    %eax,(%esi)
  1042ed:	88 54 0e 08          	mov    %dl,0x8(%esi,%ecx,1)
    if (b->idx == CONSOLE_BUFFER_SIZE - 1) {
  1042f1:	3d ff 01 00 00       	cmp    $0x1ff,%eax
  1042f6:	74 08                	je     104300 <putch+0x30>
        b->buf[b->idx] = 0;
        cputs(b->buf);
        b->idx = 0;
    }
    b->cnt++;
  1042f8:	83 46 04 01          	addl   $0x1,0x4(%esi)
}
  1042fc:	5b                   	pop    %ebx
  1042fd:	5e                   	pop    %esi
  1042fe:	5f                   	pop    %edi
  1042ff:	c3                   	ret
    while (*str) {
  104300:	0f be 46 08          	movsbl 0x8(%esi),%eax
        b->buf[b->idx] = 0;
  104304:	c6 86 07 02 00 00 00 	movb   $0x0,0x207(%esi)
        cputs(b->buf);
  10430b:	8d 7e 08             	lea    0x8(%esi),%edi
    while (*str) {
  10430e:	84 c0                	test   %al,%al
  104310:	74 1c                	je     10432e <putch+0x5e>
  104312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cons_putc(*str);
  104318:	83 ec 0c             	sub    $0xc,%esp
        str += 1;
  10431b:	83 c7 01             	add    $0x1,%edi
        cons_putc(*str);
  10431e:	50                   	push   %eax
  10431f:	e8 ec c1 ff ff       	call   100510 <cons_putc>
    while (*str) {
  104324:	0f be 07             	movsbl (%edi),%eax
  104327:	83 c4 10             	add    $0x10,%esp
  10432a:	84 c0                	test   %al,%al
  10432c:	75 ea                	jne    104318 <putch+0x48>
    b->cnt++;
  10432e:	83 46 04 01          	addl   $0x1,0x4(%esi)
        b->idx = 0;
  104332:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
}
  104338:	5b                   	pop    %ebx
  104339:	5e                   	pop    %esi
  10433a:	5f                   	pop    %edi
  10433b:	c3                   	ret
  10433c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104340 <vdprintf>:

int vdprintf(const char *fmt, va_list ap)
{
  104340:	56                   	push   %esi
  104341:	53                   	push   %ebx
  104342:	e8 5b c0 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104347:	81 c3 ad cc 00 00    	add    $0xccad,%ebx
  10434d:	81 ec 14 02 00 00    	sub    $0x214,%esp
    struct dprintbuf b;

    b.idx = 0;
  104353:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10435a:	00 
    b.cnt = 0;
  10435b:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  104362:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
  104363:	ff b4 24 24 02 00 00 	push   0x224(%esp)
  10436a:	ff b4 24 24 02 00 00 	push   0x224(%esp)
  104371:	8d 44 24 10          	lea    0x10(%esp),%eax
  104375:	50                   	push   %eax
  104376:	8d 83 dc 32 ff ff    	lea    -0xcd24(%ebx),%eax
  10437c:	50                   	push   %eax
  10437d:	e8 4e 01 00 00       	call   1044d0 <vprintfmt>

    b.buf[b.idx] = 0;
  104382:	8b 44 24 18          	mov    0x18(%esp),%eax
  104386:	c6 44 04 20 00       	movb   $0x0,0x20(%esp,%eax,1)
    while (*str) {
  10438b:	0f be 44 24 20       	movsbl 0x20(%esp),%eax
  104390:	83 c4 10             	add    $0x10,%esp
  104393:	84 c0                	test   %al,%al
  104395:	74 1f                	je     1043b6 <vdprintf+0x76>
  104397:	8d 74 24 10          	lea    0x10(%esp),%esi
  10439b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        cons_putc(*str);
  1043a0:	83 ec 0c             	sub    $0xc,%esp
        str += 1;
  1043a3:	83 c6 01             	add    $0x1,%esi
        cons_putc(*str);
  1043a6:	50                   	push   %eax
  1043a7:	e8 64 c1 ff ff       	call   100510 <cons_putc>
    while (*str) {
  1043ac:	0f be 06             	movsbl (%esi),%eax
  1043af:	83 c4 10             	add    $0x10,%esp
  1043b2:	84 c0                	test   %al,%al
  1043b4:	75 ea                	jne    1043a0 <vdprintf+0x60>
    cputs(b.buf);

    return b.cnt;
}
  1043b6:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1043ba:	81 c4 14 02 00 00    	add    $0x214,%esp
  1043c0:	5b                   	pop    %ebx
  1043c1:	5e                   	pop    %esi
  1043c2:	c3                   	ret
  1043c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1043ca:	00 
  1043cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

001043d0 <dprintf>:

int dprintf(const char *fmt, ...)
{
  1043d0:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
  1043d3:	8d 44 24 14          	lea    0x14(%esp),%eax
    cnt = vdprintf(fmt, ap);
  1043d7:	83 ec 08             	sub    $0x8,%esp
  1043da:	50                   	push   %eax
  1043db:	ff 74 24 1c          	push   0x1c(%esp)
  1043df:	e8 5c ff ff ff       	call   104340 <vdprintf>
    va_end(ap);

    return cnt;
}
  1043e4:	83 c4 1c             	add    $0x1c,%esp
  1043e7:	c3                   	ret
  1043e8:	66 90                	xchg   %ax,%ax
  1043ea:	66 90                	xchg   %ax,%ax
  1043ec:	66 90                	xchg   %ax,%ax
  1043ee:	66 90                	xchg   %ax,%ax

001043f0 <printnum>:
 */
static void printnum(putch_t putch, void *putdat, unsigned long long num,
                     unsigned base, int width, int padc)
{
    /* first recursively print all preceding (more significant) digits */
    if (num >= base) {
  1043f0:	e8 6e ea ff ff       	call   102e63 <__x86.get_pc_thunk.cx>
  1043f5:	81 c1 ff cb 00 00    	add    $0xcbff,%ecx
{
  1043fb:	55                   	push   %ebp
  1043fc:	57                   	push   %edi
  1043fd:	89 d7                	mov    %edx,%edi
  1043ff:	56                   	push   %esi
  104400:	89 c6                	mov    %eax,%esi
  104402:	53                   	push   %ebx
  104403:	83 ec 2c             	sub    $0x2c,%esp
  104406:	8b 44 24 40          	mov    0x40(%esp),%eax
  10440a:	8b 54 24 44          	mov    0x44(%esp),%edx
  10440e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    if (num >= base) {
  104412:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  104419:	00 
{
  10441a:	8b 6c 24 50          	mov    0x50(%esp),%ebp
  10441e:	89 44 24 08          	mov    %eax,0x8(%esp)
  104422:	8b 44 24 48          	mov    0x48(%esp),%eax
  104426:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10442a:	8b 54 24 4c          	mov    0x4c(%esp),%edx
    if (num >= base) {
  10442e:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
  104432:	39 44 24 08          	cmp    %eax,0x8(%esp)
  104436:	89 44 24 10          	mov    %eax,0x10(%esp)
  10443a:	1b 4c 24 14          	sbb    0x14(%esp),%ecx
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        /* print any needed pad characters before first digit */
        while (--width > 0)
  10443e:	8d 5a ff             	lea    -0x1(%edx),%ebx
    if (num >= base) {
  104441:	73 55                	jae    104498 <printnum+0xa8>
        while (--width > 0)
  104443:	83 fa 01             	cmp    $0x1,%edx
  104446:	7e 17                	jle    10445f <printnum+0x6f>
  104448:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10444f:	00 
            putch(padc, putdat);
  104450:	83 ec 08             	sub    $0x8,%esp
  104453:	57                   	push   %edi
  104454:	55                   	push   %ebp
  104455:	ff d6                	call   *%esi
        while (--width > 0)
  104457:	83 c4 10             	add    $0x10,%esp
  10445a:	83 eb 01             	sub    $0x1,%ebx
  10445d:	75 f1                	jne    104450 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
  10445f:	89 7c 24 44          	mov    %edi,0x44(%esp)
  104463:	ff 74 24 14          	push   0x14(%esp)
  104467:	ff 74 24 14          	push   0x14(%esp)
  10446b:	ff 74 24 14          	push   0x14(%esp)
  10446f:	ff 74 24 14          	push   0x14(%esp)
  104473:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
  104477:	e8 b4 40 00 00       	call   108530 <__umoddi3>
  10447c:	0f be 84 03 d9 83 ff 	movsbl -0x7c27(%ebx,%eax,1),%eax
  104483:	ff 
  104484:	89 44 24 50          	mov    %eax,0x50(%esp)
}
  104488:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
  10448b:	89 f0                	mov    %esi,%eax
}
  10448d:	5b                   	pop    %ebx
  10448e:	5e                   	pop    %esi
  10448f:	5f                   	pop    %edi
  104490:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
  104491:	ff e0                	jmp    *%eax
  104493:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printnum(putch, putdat, num / base, base, width - 1, padc);
  104498:	83 ec 0c             	sub    $0xc,%esp
  10449b:	55                   	push   %ebp
  10449c:	53                   	push   %ebx
  10449d:	50                   	push   %eax
  10449e:	83 ec 08             	sub    $0x8,%esp
  1044a1:	ff 74 24 34          	push   0x34(%esp)
  1044a5:	ff 74 24 34          	push   0x34(%esp)
  1044a9:	ff 74 24 34          	push   0x34(%esp)
  1044ad:	ff 74 24 34          	push   0x34(%esp)
  1044b1:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
  1044b5:	e8 46 3f 00 00       	call   108400 <__udivdi3>
  1044ba:	83 c4 18             	add    $0x18,%esp
  1044bd:	52                   	push   %edx
  1044be:	89 fa                	mov    %edi,%edx
  1044c0:	50                   	push   %eax
  1044c1:	89 f0                	mov    %esi,%eax
  1044c3:	e8 28 ff ff ff       	call   1043f0 <printnum>
  1044c8:	83 c4 20             	add    $0x20,%esp
  1044cb:	eb 92                	jmp    10445f <printnum+0x6f>
  1044cd:	8d 76 00             	lea    0x0(%esi),%esi

001044d0 <vprintfmt>:
    else
        return va_arg(*ap, int);
}

void vprintfmt(putch_t putch, void *putdat, const char *fmt, va_list ap)
{
  1044d0:	e8 c5 be ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  1044d5:	05 1f cb 00 00       	add    $0xcb1f,%eax
  1044da:	55                   	push   %ebp
  1044db:	57                   	push   %edi
  1044dc:	56                   	push   %esi
  1044dd:	53                   	push   %ebx
  1044de:	83 ec 2c             	sub    $0x2c,%esp
  1044e1:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  1044e5:	8b 7c 24 44          	mov    0x44(%esp),%edi
  1044e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
    unsigned long long num;
    int base, lflag, width, precision, altflag;
    char padc;

    while (1) {
        while ((ch = *(unsigned char *) fmt++) != '%') {
  1044ed:	8b 44 24 48          	mov    0x48(%esp),%eax
  1044f1:	8d 58 01             	lea    0x1(%eax),%ebx
  1044f4:	0f b6 00             	movzbl (%eax),%eax
  1044f7:	83 f8 25             	cmp    $0x25,%eax
  1044fa:	75 1a                	jne    104516 <vprintfmt+0x46>
  1044fc:	eb 2a                	jmp    104528 <vprintfmt+0x58>
  1044fe:	66 90                	xchg   %ax,%ax
            if (ch == '\0')
                return;
            putch(ch, putdat);
  104500:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
  104503:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
  104506:	57                   	push   %edi
  104507:	50                   	push   %eax
  104508:	ff d5                	call   *%ebp
        while ((ch = *(unsigned char *) fmt++) != '%') {
  10450a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
  10450e:	83 c4 10             	add    $0x10,%esp
  104511:	83 f8 25             	cmp    $0x25,%eax
  104514:	74 12                	je     104528 <vprintfmt+0x58>
            if (ch == '\0')
  104516:	85 c0                	test   %eax,%eax
  104518:	75 e6                	jne    104500 <vprintfmt+0x30>
            for (fmt--; fmt[-1] != '%'; fmt--)
                /* do nothing */ ;
            break;
        }
    }
}
  10451a:	83 c4 2c             	add    $0x2c,%esp
  10451d:	5b                   	pop    %ebx
  10451e:	5e                   	pop    %esi
  10451f:	5f                   	pop    %edi
  104520:	5d                   	pop    %ebp
  104521:	c3                   	ret
  104522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
  104528:	be ff ff ff ff       	mov    $0xffffffff,%esi
        padc = ' ';
  10452d:	c6 44 24 10 20       	movb   $0x20,0x10(%esp)
        width = -1;
  104532:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        altflag = 0;
  104537:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10453e:	00 
        lflag = 0;
  10453f:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  104546:	00 
  104547:	89 74 24 14          	mov    %esi,0x14(%esp)
  10454b:	89 7c 24 44          	mov    %edi,0x44(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  10454f:	0f b6 0b             	movzbl (%ebx),%ecx
  104552:	8d 43 01             	lea    0x1(%ebx),%eax
  104555:	89 44 24 48          	mov    %eax,0x48(%esp)
  104559:	8d 41 dd             	lea    -0x23(%ecx),%eax
  10455c:	3c 55                	cmp    $0x55,%al
  10455e:	77 18                	ja     104578 <.L19>
  104560:	8b 74 24 0c          	mov    0xc(%esp),%esi
  104564:	0f b6 c0             	movzbl %al,%eax
  104567:	8b bc 86 44 9a ff ff 	mov    -0x65bc(%esi,%eax,4),%edi
  10456e:	01 f7                	add    %esi,%edi
  104570:	ff e7                	jmp    *%edi
  104572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104578 <.L19>:
            putch('%', putdat);
  104578:	8b 7c 24 44          	mov    0x44(%esp),%edi
  10457c:	83 ec 08             	sub    $0x8,%esp
  10457f:	57                   	push   %edi
  104580:	6a 25                	push   $0x25
  104582:	ff d5                	call   *%ebp
            for (fmt--; fmt[-1] != '%'; fmt--)
  104584:	83 c4 10             	add    $0x10,%esp
  104587:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
  10458b:	89 5c 24 48          	mov    %ebx,0x48(%esp)
  10458f:	0f 84 58 ff ff ff    	je     1044ed <vprintfmt+0x1d>
  104595:	89 d8                	mov    %ebx,%eax
  104597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10459e:	00 
  10459f:	90                   	nop
  1045a0:	83 e8 01             	sub    $0x1,%eax
  1045a3:	80 78 ff 25          	cmpb   $0x25,-0x1(%eax)
  1045a7:	75 f7                	jne    1045a0 <.L19+0x28>
  1045a9:	89 44 24 48          	mov    %eax,0x48(%esp)
  1045ad:	e9 3b ff ff ff       	jmp    1044ed <vprintfmt+0x1d>
  1045b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001045b8 <.L28>:
                ch = *fmt;
  1045b8:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
  1045bc:	8d 71 d0             	lea    -0x30(%ecx),%esi
        switch (ch = *(unsigned char *) fmt++) {
  1045bf:	8b 5c 24 48          	mov    0x48(%esp),%ebx
                precision = precision * 10 + ch - '0';
  1045c3:	89 74 24 14          	mov    %esi,0x14(%esp)
                if (ch < '0' || ch > '9')
  1045c7:	8d 48 d0             	lea    -0x30(%eax),%ecx
  1045ca:	83 f9 09             	cmp    $0x9,%ecx
  1045cd:	77 26                	ja     1045f5 <.L28+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
  1045cf:	8b 7c 24 44          	mov    0x44(%esp),%edi
  1045d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                precision = precision * 10 + ch - '0';
  1045d8:	8d 0c b6             	lea    (%esi,%esi,4),%ecx
            for (precision = 0;; ++fmt) {
  1045db:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
  1045de:	8d 74 48 d0          	lea    -0x30(%eax,%ecx,2),%esi
                ch = *fmt;
  1045e2:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
  1045e5:	8d 48 d0             	lea    -0x30(%eax),%ecx
  1045e8:	83 f9 09             	cmp    $0x9,%ecx
  1045eb:	76 eb                	jbe    1045d8 <.L28+0x20>
  1045ed:	89 74 24 14          	mov    %esi,0x14(%esp)
  1045f1:	89 7c 24 44          	mov    %edi,0x44(%esp)
            if (width < 0)
  1045f5:	85 d2                	test   %edx,%edx
  1045f7:	0f 89 52 ff ff ff    	jns    10454f <vprintfmt+0x7f>
                width = precision, precision = -1;
  1045fd:	8b 54 24 14          	mov    0x14(%esp),%edx
  104601:	c7 44 24 14 ff ff ff 	movl   $0xffffffff,0x14(%esp)
  104608:	ff 
  104609:	e9 41 ff ff ff       	jmp    10454f <vprintfmt+0x7f>

0010460e <.L24>:
            putch('0', putdat);
  10460e:	8b 7c 24 44          	mov    0x44(%esp),%edi
  104612:	89 54 24 08          	mov    %edx,0x8(%esp)
  104616:	83 ec 08             	sub    $0x8,%esp
  104619:	57                   	push   %edi
  10461a:	6a 30                	push   $0x30
  10461c:	ff d5                	call   *%ebp
            putch('x', putdat);
  10461e:	5b                   	pop    %ebx
  10461f:	5e                   	pop    %esi
  104620:	57                   	push   %edi
  104621:	6a 78                	push   $0x78
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104623:	31 f6                	xor    %esi,%esi
            putch('x', putdat);
  104625:	ff d5                	call   *%ebp
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104627:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            goto number;
  10462b:	8b 54 24 18          	mov    0x18(%esp),%edx
  10462f:	b9 10 00 00 00       	mov    $0x10,%ecx
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104634:	8b 18                	mov    (%eax),%ebx
            goto number;
  104636:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long) (uintptr_t) va_arg(ap, void *);
  104639:	83 c0 04             	add    $0x4,%eax
  10463c:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            printnum(putch, putdat, num, base, width, padc);
  104640:	83 ec 0c             	sub    $0xc,%esp
  104643:	0f be 44 24 1c       	movsbl 0x1c(%esp),%eax
  104648:	50                   	push   %eax
  104649:	89 e8                	mov    %ebp,%eax
  10464b:	52                   	push   %edx
  10464c:	89 fa                	mov    %edi,%edx
  10464e:	51                   	push   %ecx
  10464f:	56                   	push   %esi
  104650:	53                   	push   %ebx
  104651:	e8 9a fd ff ff       	call   1043f0 <printnum>
            break;
  104656:	83 c4 20             	add    $0x20,%esp
  104659:	e9 8f fe ff ff       	jmp    1044ed <vprintfmt+0x1d>

0010465e <.L32>:
            altflag = 1;
  10465e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  104665:	00 
        switch (ch = *(unsigned char *) fmt++) {
  104666:	8b 5c 24 48          	mov    0x48(%esp),%ebx
            goto reswitch;
  10466a:	e9 e0 fe ff ff       	jmp    10454f <vprintfmt+0x7f>

0010466f <.L31>:
            putch(ch, putdat);
  10466f:	8b 7c 24 44          	mov    0x44(%esp),%edi
  104673:	83 ec 08             	sub    $0x8,%esp
  104676:	57                   	push   %edi
  104677:	6a 25                	push   $0x25
  104679:	ff d5                	call   *%ebp
            break;
  10467b:	83 c4 10             	add    $0x10,%esp
  10467e:	e9 6a fe ff ff       	jmp    1044ed <vprintfmt+0x1d>

00104683 <.L30>:
            precision = va_arg(ap, int);
  104683:	8b 44 24 4c          	mov    0x4c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
  104687:	8b 5c 24 48          	mov    0x48(%esp),%ebx
            precision = va_arg(ap, int);
  10468b:	8b 00                	mov    (%eax),%eax
  10468d:	89 44 24 14          	mov    %eax,0x14(%esp)
  104691:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  104695:	83 c0 04             	add    $0x4,%eax
  104698:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto process_precision;
  10469c:	e9 54 ff ff ff       	jmp    1045f5 <.L28+0x3d>

001046a1 <.L29>:
            if (width < 0)
  1046a1:	31 c0                	xor    %eax,%eax
  1046a3:	85 d2                	test   %edx,%edx
        switch (ch = *(unsigned char *) fmt++) {
  1046a5:	8b 5c 24 48          	mov    0x48(%esp),%ebx
            if (width < 0)
  1046a9:	0f 48 d0             	cmovs  %eax,%edx
            goto reswitch;
  1046ac:	e9 9e fe ff ff       	jmp    10454f <vprintfmt+0x7f>

001046b1 <.L23>:
            if ((p = va_arg(ap, char *)) == NULL)
  1046b1:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  1046b5:	8b 74 24 14          	mov    0x14(%esp),%esi
  1046b9:	8b 7c 24 44          	mov    0x44(%esp),%edi
  1046bd:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
  1046c0:	85 d2                	test   %edx,%edx
            if ((p = va_arg(ap, char *)) == NULL)
  1046c2:	89 44 24 14          	mov    %eax,0x14(%esp)
  1046c6:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  1046ca:	8b 18                	mov    (%eax),%ebx
            if (width > 0 && padc != '-')
  1046cc:	0f 9f c0             	setg   %al
  1046cf:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%esp)
  1046d4:	0f 95 c1             	setne  %cl
            if ((p = va_arg(ap, char *)) == NULL)
  1046d7:	89 5c 24 18          	mov    %ebx,0x18(%esp)
            if (width > 0 && padc != '-')
  1046db:	21 c8                	and    %ecx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
  1046dd:	85 db                	test   %ebx,%ebx
  1046df:	0f 84 c8 01 00 00    	je     1048ad <.L17+0xe>
            if (width > 0 && padc != '-')
  1046e5:	84 c0                	test   %al,%al
  1046e7:	0f 85 eb 01 00 00    	jne    1048d8 <.L17+0x39>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  1046ed:	89 d8                	mov    %ebx,%eax
  1046ef:	8d 5b 01             	lea    0x1(%ebx),%ebx
  1046f2:	0f be 08             	movsbl (%eax),%ecx
  1046f5:	89 c8                	mov    %ecx,%eax
  1046f7:	85 c9                	test   %ecx,%ecx
  1046f9:	0f 84 19 01 00 00    	je     104818 <.L25+0x14>
  1046ff:	89 7c 24 44          	mov    %edi,0x44(%esp)
  104703:	89 f7                	mov    %esi,%edi
  104705:	89 de                	mov    %ebx,%esi
  104707:	89 d3                	mov    %edx,%ebx
  104709:	eb 2f                	jmp    10473a <.L23+0x89>
  10470b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
  104710:	83 e8 20             	sub    $0x20,%eax
  104713:	83 f8 5e             	cmp    $0x5e,%eax
  104716:	76 37                	jbe    10474f <.L23+0x9e>
                    putch('?', putdat);
  104718:	83 ec 08             	sub    $0x8,%esp
  10471b:	ff 74 24 4c          	push   0x4c(%esp)
  10471f:	6a 3f                	push   $0x3f
  104721:	ff d5                	call   *%ebp
  104723:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104726:	0f be 06             	movsbl (%esi),%eax
  104729:	83 c6 01             	add    $0x1,%esi
                 width--)
  10472c:	83 eb 01             	sub    $0x1,%ebx
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  10472f:	0f be c8             	movsbl %al,%ecx
  104732:	85 c9                	test   %ecx,%ecx
  104734:	0f 84 d8 00 00 00    	je     104812 <.L25+0xe>
  10473a:	85 ff                	test   %edi,%edi
  10473c:	78 09                	js     104747 <.L23+0x96>
  10473e:	83 ef 01             	sub    $0x1,%edi
  104741:	0f 82 cb 00 00 00    	jb     104812 <.L25+0xe>
                if (altflag && (ch < ' ' || ch > '~'))
  104747:	8b 54 24 08          	mov    0x8(%esp),%edx
  10474b:	85 d2                	test   %edx,%edx
  10474d:	75 c1                	jne    104710 <.L23+0x5f>
                    putch(ch, putdat);
  10474f:	83 ec 08             	sub    $0x8,%esp
  104752:	ff 74 24 4c          	push   0x4c(%esp)
  104756:	51                   	push   %ecx
  104757:	ff d5                	call   *%ebp
  104759:	83 c4 10             	add    $0x10,%esp
  10475c:	eb c8                	jmp    104726 <.L23+0x75>

0010475e <.L22>:
    if (lflag >= 2)
  10475e:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  104763:	8b 7c 24 44          	mov    0x44(%esp),%edi
        return va_arg(*ap, unsigned long long);
  104767:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
  10476b:	0f 8f cc 00 00 00    	jg     10483d <.L25+0x39>
        return va_arg(*ap, unsigned long);
  104771:	8b 74 24 4c          	mov    0x4c(%esp),%esi
            precision = va_arg(ap, int);
  104775:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
  104778:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10477d:	8b 1e                	mov    (%esi),%ebx
  10477f:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  104783:	31 f6                	xor    %esi,%esi
  104785:	e9 b6 fe ff ff       	jmp    104640 <.L24+0x32>

0010478a <.L20>:
    if (lflag >= 2)
  10478a:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  10478f:	8b 7c 24 44          	mov    0x44(%esp),%edi
        return va_arg(*ap, unsigned long long);
  104793:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
  104797:	0f 8f ae 00 00 00    	jg     10484b <.L25+0x47>
        return va_arg(*ap, unsigned long);
  10479d:	8b 74 24 4c          	mov    0x4c(%esp),%esi
            precision = va_arg(ap, int);
  1047a1:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
  1047a4:	b9 10 00 00 00       	mov    $0x10,%ecx
  1047a9:	8b 1e                	mov    (%esi),%ebx
  1047ab:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  1047af:	31 f6                	xor    %esi,%esi
  1047b1:	e9 8a fe ff ff       	jmp    104640 <.L24+0x32>

001047b6 <.L27>:
            putch(va_arg(ap, int), putdat);
  1047b6:	8b 44 24 4c          	mov    0x4c(%esp),%eax
  1047ba:	8b 7c 24 44          	mov    0x44(%esp),%edi
  1047be:	83 ec 08             	sub    $0x8,%esp
  1047c1:	57                   	push   %edi
  1047c2:	8d 58 04             	lea    0x4(%eax),%ebx
  1047c5:	8b 44 24 58          	mov    0x58(%esp),%eax
  1047c9:	ff 30                	push   (%eax)
  1047cb:	ff d5                	call   *%ebp
            break;
  1047cd:	83 c4 10             	add    $0x10,%esp
            putch(va_arg(ap, int), putdat);
  1047d0:	89 5c 24 4c          	mov    %ebx,0x4c(%esp)
            break;
  1047d4:	e9 14 fd ff ff       	jmp    1044ed <vprintfmt+0x1d>

001047d9 <.L26>:
        return va_arg(*ap, long long);
  1047d9:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
  1047dd:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  1047e2:	8b 7c 24 44          	mov    0x44(%esp),%edi
        return va_arg(*ap, long long);
  1047e6:	8b 18                	mov    (%eax),%ebx
    if (lflag >= 2)
  1047e8:	7f 77                	jg     104861 <.L25+0x5d>
        return va_arg(*ap, long);
  1047ea:	83 c0 04             	add    $0x4,%eax
  1047ed:	89 de                	mov    %ebx,%esi
  1047ef:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  1047f3:	c1 fe 1f             	sar    $0x1f,%esi
            if ((long long) num < 0) {
  1047f6:	85 f6                	test   %esi,%esi
  1047f8:	78 73                	js     10486d <.L25+0x69>
        return va_arg(*ap, unsigned long long);
  1047fa:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1047ff:	e9 3c fe ff ff       	jmp    104640 <.L24+0x32>

00104804 <.L25>:
            lflag++;
  104804:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  104809:	8b 5c 24 48          	mov    0x48(%esp),%ebx
            goto reswitch;
  10480d:	e9 3d fd ff ff       	jmp    10454f <vprintfmt+0x7f>
  104812:	8b 7c 24 44          	mov    0x44(%esp),%edi
  104816:	89 da                	mov    %ebx,%edx
            for (; width > 0; width--)
  104818:	85 d2                	test   %edx,%edx
  10481a:	7e 14                	jle    104830 <.L25+0x2c>
  10481c:	89 d3                	mov    %edx,%ebx
  10481e:	66 90                	xchg   %ax,%ax
                putch(' ', putdat);
  104820:	83 ec 08             	sub    $0x8,%esp
  104823:	57                   	push   %edi
  104824:	6a 20                	push   $0x20
  104826:	ff d5                	call   *%ebp
            for (; width > 0; width--)
  104828:	83 c4 10             	add    $0x10,%esp
  10482b:	83 eb 01             	sub    $0x1,%ebx
  10482e:	75 f0                	jne    104820 <.L25+0x1c>
            if ((p = va_arg(ap, char *)) == NULL)
  104830:	8b 44 24 14          	mov    0x14(%esp),%eax
  104834:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  104838:	e9 b0 fc ff ff       	jmp    1044ed <vprintfmt+0x1d>
        return va_arg(*ap, unsigned long long);
  10483d:	8b 18                	mov    (%eax),%ebx
  10483f:	8b 70 04             	mov    0x4(%eax),%esi
  104842:	83 c0 08             	add    $0x8,%eax
  104845:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  104849:	eb af                	jmp    1047fa <.L26+0x21>
  10484b:	8b 18                	mov    (%eax),%ebx
  10484d:	8b 70 04             	mov    0x4(%eax),%esi
  104850:	83 c0 08             	add    $0x8,%eax
  104853:	b9 10 00 00 00       	mov    $0x10,%ecx
  104858:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  10485c:	e9 df fd ff ff       	jmp    104640 <.L24+0x32>
        return va_arg(*ap, long long);
  104861:	8b 70 04             	mov    0x4(%eax),%esi
  104864:	83 c0 08             	add    $0x8,%eax
  104867:	89 44 24 4c          	mov    %eax,0x4c(%esp)
  10486b:	eb 89                	jmp    1047f6 <.L26+0x1d>
  10486d:	89 54 24 08          	mov    %edx,0x8(%esp)
                putch('-', putdat);
  104871:	83 ec 08             	sub    $0x8,%esp
  104874:	57                   	push   %edi
  104875:	6a 2d                	push   $0x2d
  104877:	ff d5                	call   *%ebp
                num = -(long long) num;
  104879:	f7 db                	neg    %ebx
  10487b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  104880:	83 d6 00             	adc    $0x0,%esi
  104883:	8b 54 24 18          	mov    0x18(%esp),%edx
  104887:	83 c4 10             	add    $0x10,%esp
  10488a:	f7 de                	neg    %esi
  10488c:	e9 af fd ff ff       	jmp    104640 <.L24+0x32>

00104891 <.L60>:
        switch (ch = *(unsigned char *) fmt++) {
  104891:	c6 44 24 10 30       	movb   $0x30,0x10(%esp)
  104896:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  10489a:	e9 b0 fc ff ff       	jmp    10454f <vprintfmt+0x7f>

0010489f <.L17>:
            padc = '-';
  10489f:	c6 44 24 10 2d       	movb   $0x2d,0x10(%esp)
        switch (ch = *(unsigned char *) fmt++) {
  1048a4:	8b 5c 24 48          	mov    0x48(%esp),%ebx
  1048a8:	e9 a2 fc ff ff       	jmp    10454f <vprintfmt+0x7f>
            if (width > 0 && padc != '-')
  1048ad:	84 c0                	test   %al,%al
  1048af:	0f 85 83 00 00 00    	jne    104938 <.L17+0x99>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  1048b5:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1048b9:	89 7c 24 44          	mov    %edi,0x44(%esp)
  1048bd:	b9 28 00 00 00       	mov    $0x28,%ecx
  1048c2:	89 f7                	mov    %esi,%edi
  1048c4:	8d 98 eb 83 ff ff    	lea    -0x7c15(%eax),%ebx
  1048ca:	b8 28 00 00 00       	mov    $0x28,%eax
  1048cf:	89 de                	mov    %ebx,%esi
  1048d1:	89 d3                	mov    %edx,%ebx
  1048d3:	e9 62 fe ff ff       	jmp    10473a <.L23+0x89>
  1048d8:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
  1048dc:	83 ec 08             	sub    $0x8,%esp
  1048df:	56                   	push   %esi
  1048e0:	ff 74 24 24          	push   0x24(%esp)
  1048e4:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
  1048e8:	e8 73 f6 ff ff       	call   103f60 <strnlen>
  1048ed:	8b 54 24 2c          	mov    0x2c(%esp),%edx
  1048f1:	83 c4 10             	add    $0x10,%esp
  1048f4:	29 c2                	sub    %eax,%edx
  1048f6:	85 d2                	test   %edx,%edx
  1048f8:	0f 8e 83 00 00 00    	jle    104981 <.L17+0xe2>
                    putch(padc, putdat);
  1048fe:	0f be 5c 24 10       	movsbl 0x10(%esp),%ebx
  104903:	89 74 24 10          	mov    %esi,0x10(%esp)
  104907:	89 d6                	mov    %edx,%esi
  104909:	83 ec 08             	sub    $0x8,%esp
  10490c:	57                   	push   %edi
  10490d:	53                   	push   %ebx
  10490e:	ff d5                	call   *%ebp
                for (width -= strnlen(p, precision); width > 0; width--)
  104910:	83 c4 10             	add    $0x10,%esp
  104913:	83 ee 01             	sub    $0x1,%esi
  104916:	75 f1                	jne    104909 <.L17+0x6a>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104918:	8b 44 24 18          	mov    0x18(%esp),%eax
  10491c:	89 f2                	mov    %esi,%edx
  10491e:	8b 74 24 10          	mov    0x10(%esp),%esi
  104922:	8d 58 01             	lea    0x1(%eax),%ebx
  104925:	0f be 00             	movsbl (%eax),%eax
  104928:	0f be c8             	movsbl %al,%ecx
  10492b:	85 c9                	test   %ecx,%ecx
  10492d:	0f 85 cc fd ff ff    	jne    1046ff <.L23+0x4e>
  104933:	e9 f8 fe ff ff       	jmp    104830 <.L25+0x2c>
  104938:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                for (width -= strnlen(p, precision); width > 0; width--)
  10493c:	83 ec 08             	sub    $0x8,%esp
  10493f:	56                   	push   %esi
  104940:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  104944:	8d 8b ea 83 ff ff    	lea    -0x7c16(%ebx),%ecx
  10494a:	51                   	push   %ecx
  10494b:	89 4c 24 28          	mov    %ecx,0x28(%esp)
  10494f:	e8 0c f6 ff ff       	call   103f60 <strnlen>
  104954:	8b 54 24 2c          	mov    0x2c(%esp),%edx
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104958:	b9 28 00 00 00       	mov    $0x28,%ecx
                for (width -= strnlen(p, precision); width > 0; width--)
  10495d:	83 c4 10             	add    $0x10,%esp
  104960:	29 c2                	sub    %eax,%edx
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  104962:	b8 28 00 00 00       	mov    $0x28,%eax
                for (width -= strnlen(p, precision); width > 0; width--)
  104967:	85 d2                	test   %edx,%edx
  104969:	7f 93                	jg     1048fe <.L17+0x5f>
                 (ch = *p++) != '\0' && (precision < 0 || --precision >= 0);
  10496b:	8b 5c 24 18          	mov    0x18(%esp),%ebx
  10496f:	89 7c 24 44          	mov    %edi,0x44(%esp)
  104973:	89 f7                	mov    %esi,%edi
  104975:	83 c3 01             	add    $0x1,%ebx
  104978:	89 de                	mov    %ebx,%esi
  10497a:	89 d3                	mov    %edx,%ebx
  10497c:	e9 b9 fd ff ff       	jmp    10473a <.L23+0x89>
  104981:	8b 44 24 18          	mov    0x18(%esp),%eax
  104985:	0f be 08             	movsbl (%eax),%ecx
  104988:	89 c8                	mov    %ecx,%eax
  10498a:	85 c9                	test   %ecx,%ecx
  10498c:	75 dd                	jne    10496b <.L17+0xcc>
  10498e:	e9 9d fe ff ff       	jmp    104830 <.L25+0x2c>
  104993:	66 90                	xchg   %ax,%ax
  104995:	66 90                	xchg   %ax,%ax
  104997:	66 90                	xchg   %ax,%ax
  104999:	66 90                	xchg   %ax,%ax
  10499b:	66 90                	xchg   %ax,%ax
  10499d:	66 90                	xchg   %ax,%ax
  10499f:	90                   	nop

001049a0 <kstack_switch>:
#include "seg.h"

#define offsetof(type, member) __builtin_offsetof(type, member)

void kstack_switch(uint32_t pid)
{
  1049a0:	56                   	push   %esi
  1049a1:	53                   	push   %ebx
  1049a2:	e8 fb b9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1049a7:	81 c3 4d c6 00 00    	add    $0xc64d,%ebx
  1049ad:	83 ec 04             	sub    $0x4,%esp
    int cpu_idx = get_pcpu_idx();
  1049b0:	e8 eb 11 00 00       	call   105ba0 <get_pcpu_idx>
    struct kstack *ks = (struct kstack *) get_pcpu_kstack_pointer(cpu_idx);
  1049b5:	83 ec 0c             	sub    $0xc,%esp
  1049b8:	50                   	push   %eax
  1049b9:	e8 42 12 00 00       	call   105c00 <get_pcpu_kstack_pointer>

    /*
     * Switch to the new TSS.
     */
    ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  1049be:	8b 74 24 20          	mov    0x20(%esp),%esi
  1049c2:	c7 c1 00 a0 13 00    	mov    $0x13a000,%ecx
  1049c8:	8d 56 01             	lea    0x1(%esi),%edx
  1049cb:	c1 e2 0c             	shl    $0xc,%edx
  1049ce:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
    ks->gdt[CPU_GDT_TSS >> 3] =
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  1049d1:	8d 94 0a 30 f0 ff ff 	lea    -0xfd0(%edx,%ecx,1),%edx
    ks->gdt[CPU_GDT_TSS >> 3] =
  1049d8:	b9 eb 00 00 00       	mov    $0xeb,%ecx
    ks->tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  1049dd:	89 70 34             	mov    %esi,0x34(%eax)
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
  1049e0:	be 10 00 00 00       	mov    $0x10,%esi
    ks->gdt[CPU_GDT_TSS >> 3] =
  1049e5:	66 89 48 28          	mov    %cx,0x28(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  1049e9:	89 d1                	mov    %edx,%ecx
    ks->tss.ts_ss0 = CPU_GDT_KDATA;
  1049eb:	66 89 70 38          	mov    %si,0x38(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  1049ef:	c1 e9 10             	shr    $0x10,%ecx
    ks->gdt[CPU_GDT_TSS >> 3] =
  1049f2:	be 89 40 00 00       	mov    $0x4089,%esi
  1049f7:	66 89 50 2a          	mov    %dx,0x2a(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  1049fb:	c1 ea 18             	shr    $0x18,%edx
    ks->gdt[CPU_GDT_TSS >> 3] =
  1049fe:	66 89 70 2d          	mov    %si,0x2d(%eax)
  104a02:	88 48 2c             	mov    %cl,0x2c(%eax)
  104a05:	88 50 2f             	mov    %dl,0x2f(%eax)
    ks->gdt[CPU_GDT_TSS >> 3].sd_s = 0;
    ltr(CPU_GDT_TSS);
  104a08:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  104a0f:	e8 cc 04 00 00       	call   104ee0 <ltr>
}
  104a14:	83 c4 14             	add    $0x14,%esp
  104a17:	5b                   	pop    %ebx
  104a18:	5e                   	pop    %esi
  104a19:	c3                   	ret
  104a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104a20 <seg_init>:

void seg_init(int cpu_idx)
{
  104a20:	55                   	push   %ebp
  104a21:	57                   	push   %edi
  104a22:	56                   	push   %esi
  104a23:	53                   	push   %ebx
  104a24:	e8 79 b9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104a29:	81 c3 cb c5 00 00    	add    $0xc5cb,%ebx
  104a2f:	83 ec 1c             	sub    $0x1c,%esp
  104a32:	8b 7c 24 30          	mov    0x30(%esp),%edi
    /* clear BSS */
    if (cpu_idx == 0) {
  104a36:	85 ff                	test   %edi,%edi
  104a38:	0f 84 0a 01 00 00    	je     104b48 <seg_init+0x128>
  104a3e:	c7 c6 00 a0 17 00    	mov    $0x17a000,%esi
        memzero(edata, ((uint8_t *) &bsp_kstack[0]) - edata);
        memzero(((uint8_t *) &bsp_kstack[0]) + 4096, end - ((uint8_t *) &bsp_kstack[0]) - 4096);
    }

    /* setup GDT */
    bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104a44:	89 fa                	mov    %edi,%edx
  104a46:	8d 4f 01             	lea    0x1(%edi),%ecx
  104a49:	c1 e2 0c             	shl    $0xc,%edx
  104a4c:	c1 e1 0c             	shl    $0xc,%ecx
  104a4f:	8d 04 16             	lea    (%esi,%edx,1),%eax
    /* 0x20: user data */
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
        SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

    /* setup TSS */
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  104a52:	8d 2c 0e             	lea    (%esi,%ecx,1),%ebp
    bsp_kstack[cpu_idx].gdt[0] = SEGDESC_NULL;
  104a55:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  104a5b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  104a62:	c7 44 16 08 ff ff 00 	movl   $0xffff,0x8(%esi,%edx,1)
  104a69:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  104a6a:	c7 44 16 10 ff ff 00 	movl   $0xffff,0x10(%esi,%edx,1)
  104a71:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104a72:	c7 44 16 18 ff ff 00 	movl   $0xffff,0x18(%esi,%edx,1)
  104a79:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  104a7a:	c7 44 16 20 ff ff 00 	movl   $0xffff,0x20(%esi,%edx,1)
  104a81:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KCODE >> 3] =
  104a82:	c7 44 16 0c 00 9a cf 	movl   $0xcf9a00,0xc(%esi,%edx,1)
  104a89:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_KDATA >> 3] =
  104a8a:	c7 44 16 14 00 92 cf 	movl   $0xcf9200,0x14(%esi,%edx,1)
  104a91:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UCODE >> 3] =
  104a92:	c7 44 16 1c 00 fa cf 	movl   $0xcffa00,0x1c(%esi,%edx,1)
  104a99:	00 
    bsp_kstack[cpu_idx].tss.ts_esp0 = (uint32_t) bsp_kstack[cpu_idx].kstack_hi;
  104a9a:	89 68 34             	mov    %ebp,0x34(%eax)
    bsp_kstack[cpu_idx].tss.ts_ss0 = CPU_GDT_KDATA;
  104a9d:	bd 10 00 00 00       	mov    $0x10,%ebp
  104aa2:	66 89 68 38          	mov    %bp,0x38(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104aa6:	8d ac 0e 30 f0 ff ff 	lea    -0xfd0(%esi,%ecx,1),%ebp
    bsp_kstack[cpu_idx].gdt[CPU_GDT_UDATA >> 3] =
  104aad:	c7 44 16 24 00 f2 cf 	movl   $0xcff200,0x24(%esi,%edx,1)
  104ab4:	00 
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104ab5:	ba eb 00 00 00       	mov    $0xeb,%edx
  104aba:	66 89 50 28          	mov    %dx,0x28(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104abe:	89 ea                	mov    %ebp,%edx
  104ac0:	c1 ea 10             	shr    $0x10,%edx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104ac3:	66 89 68 2a          	mov    %bp,0x2a(%eax)
  104ac7:	88 50 2c             	mov    %dl,0x2c(%eax)
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104aca:	89 ea                	mov    %ebp,%edx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104acc:	bd 89 40 00 00       	mov    $0x4089,%ebp
        SEGDESC16(STS_T32A, (uint32_t) &bsp_kstack[cpu_idx].tss, sizeof(tss_t) - 1, 0);
  104ad1:	c1 ea 18             	shr    $0x18,%edx
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3] =
  104ad4:	66 89 68 2d          	mov    %bp,0x2d(%eax)
  104ad8:	88 50 2f             	mov    %dl,0x2f(%eax)
    bsp_kstack[cpu_idx].gdt[CPU_GDT_TSS >> 3].sd_s = 0;

    /* other fields */
    /* Set the KSTACK_MAGIC value when we initialize the kstack */
    bsp_kstack[cpu_idx].magic = KSTACK_MAGIC;
  104adb:	c7 80 20 01 00 00 32 	movl   $0x98765432,0x120(%eax)
  104ae2:	54 76 98 

    pseudodesc_t gdt_desc = {
  104ae5:	b8 2f 00 00 00       	mov    $0x2f,%eax
  104aea:	66 89 44 24 0a       	mov    %ax,0xa(%esp)
        .pd_lim   = sizeof(bsp_kstack[cpu_idx].gdt) - 1,
        .pd_base  = (uint32_t) bsp_kstack[cpu_idx].gdt
  104aef:	8d 84 0e 00 f0 ff ff 	lea    -0x1000(%esi,%ecx,1),%eax
  104af6:	89 44 24 0c          	mov    %eax,0xc(%esp)
    };
    asm volatile ("lgdt %0" :: "m" (gdt_desc));
  104afa:	0f 01 54 24 0a       	lgdtl  0xa(%esp)
    asm volatile ("movw %%ax,%%gs" :: "a" (CPU_GDT_KDATA));
  104aff:	b8 10 00 00 00       	mov    $0x10,%eax
  104b04:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax,%%fs" :: "a" (CPU_GDT_KDATA));
  104b06:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax,%%es" :: "a" (CPU_GDT_KDATA));
  104b08:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax,%%ds" :: "a" (CPU_GDT_KDATA));
  104b0a:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax,%%ss" :: "a" (CPU_GDT_KDATA));
  104b0c:	8e d0                	mov    %eax,%ss
    /* reload %cs */
    asm volatile ("ljmp %0,$1f\n 1:\n" :: "i" (CPU_GDT_KCODE));
  104b0e:	ea 15 4b 10 00 08 00 	ljmp   $0x8,$0x104b15

    /*
     * Load a null LDT.
     */
    lldt(0);
  104b15:	83 ec 0c             	sub    $0xc,%esp
  104b18:	6a 00                	push   $0x0
  104b1a:	e8 31 02 00 00       	call   104d50 <lldt>

    /*
     * Load the bootstrap TSS.
     */
    ltr(CPU_GDT_TSS);
  104b1f:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  104b26:	e8 b5 03 00 00       	call   104ee0 <ltr>

    /*
     * Load IDT.
     */
    extern pseudodesc_t idt_pd;
    asm volatile ("lidt %0" :: "m" (idt_pd));
  104b2b:	c7 c0 00 13 11 00    	mov    $0x111300,%eax
  104b31:	0f 01 18             	lidtl  (%eax)

    /*
     * Initialize all TSS structures for processes.
     */
    if (cpu_idx == 0) {
  104b34:	83 c4 10             	add    $0x10,%esp
  104b37:	85 ff                	test   %edi,%edi
  104b39:	74 55                	je     104b90 <seg_init+0x170>
        memzero(&bsp_kstack[1], sizeof(struct kstack) * 7);
        memzero(proc_kstack, sizeof(struct kstack) * 64);
    }
}
  104b3b:	83 c4 1c             	add    $0x1c,%esp
  104b3e:	5b                   	pop    %ebx
  104b3f:	5e                   	pop    %esi
  104b40:	5f                   	pop    %edi
  104b41:	5d                   	pop    %ebp
  104b42:	c3                   	ret
  104b43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        memzero(edata, ((uint8_t *) &bsp_kstack[0]) - edata);
  104b48:	c7 c6 00 a0 17 00    	mov    $0x17a000,%esi
  104b4e:	c7 c0 9e 79 13 00    	mov    $0x13799e,%eax
  104b54:	83 ec 08             	sub    $0x8,%esp
  104b57:	89 f2                	mov    %esi,%edx
  104b59:	29 c2                	sub    %eax,%edx
  104b5b:	52                   	push   %edx
  104b5c:	50                   	push   %eax
  104b5d:	e8 be f4 ff ff       	call   104020 <memzero>
        memzero(((uint8_t *) &bsp_kstack[0]) + 4096, end - ((uint8_t *) &bsp_kstack[0]) - 4096);
  104b62:	58                   	pop    %eax
  104b63:	c7 c0 e4 6d e0 00    	mov    $0xe06de4,%eax
  104b69:	5a                   	pop    %edx
  104b6a:	29 f0                	sub    %esi,%eax
  104b6c:	2d 00 10 00 00       	sub    $0x1000,%eax
  104b71:	50                   	push   %eax
  104b72:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
  104b78:	50                   	push   %eax
  104b79:	e8 a2 f4 ff ff       	call   104020 <memzero>
  104b7e:	83 c4 10             	add    $0x10,%esp
  104b81:	e9 be fe ff ff       	jmp    104a44 <seg_init+0x24>
  104b86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104b8d:	00 
  104b8e:	66 90                	xchg   %ax,%ax
        memzero(&bsp_kstack[1], sizeof(struct kstack) * 7);
  104b90:	83 ec 08             	sub    $0x8,%esp
  104b93:	8d 86 00 10 00 00    	lea    0x1000(%esi),%eax
  104b99:	68 00 70 00 00       	push   $0x7000
  104b9e:	50                   	push   %eax
  104b9f:	e8 7c f4 ff ff       	call   104020 <memzero>
        memzero(proc_kstack, sizeof(struct kstack) * 64);
  104ba4:	58                   	pop    %eax
  104ba5:	5a                   	pop    %edx
  104ba6:	68 00 00 04 00       	push   $0x40000
  104bab:	ff b3 f4 ff ff ff    	push   -0xc(%ebx)
  104bb1:	e8 6a f4 ff ff       	call   104020 <memzero>
  104bb6:	83 c4 10             	add    $0x10,%esp
}
  104bb9:	83 c4 1c             	add    $0x1c,%esp
  104bbc:	5b                   	pop    %ebx
  104bbd:	5e                   	pop    %esi
  104bbe:	5f                   	pop    %edi
  104bbf:	5d                   	pop    %ebp
  104bc0:	c3                   	ret
  104bc1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104bc8:	00 
  104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104bd0 <seg_init_proc>:

/* initialize the kernel stack for each process */
void seg_init_proc(int cpu_idx, int pid)
{
  104bd0:	55                   	push   %ebp
        SEGDESC32(STA_W, 0x00000000, 0xffffffff, 3);

    /* setup TSS */
    proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
    proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
    proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104bd1:	ba 68 00 00 00       	mov    $0x68,%edx
{
  104bd6:	57                   	push   %edi
  104bd7:	56                   	push   %esi
  104bd8:	53                   	push   %ebx
  104bd9:	e8 c4 b7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104bde:	81 c3 16 c4 00 00    	add    $0xc416,%ebx
  104be4:	83 ec 14             	sub    $0x14,%esp
  104be7:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
    proc_kstack[pid].gdt[0] = SEGDESC_NULL;
  104beb:	89 e8                	mov    %ebp,%eax
  104bed:	83 c5 01             	add    $0x1,%ebp
  104bf0:	c7 c7 00 a0 13 00    	mov    $0x13a000,%edi
  104bf6:	c1 e0 0c             	shl    $0xc,%eax
  104bf9:	c1 e5 0c             	shl    $0xc,%ebp
  104bfc:	8d 34 07             	lea    (%edi,%eax,1),%esi
  104bff:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  104c05:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
    proc_kstack[pid].gdt[CPU_GDT_KCODE >> 3] =
  104c0c:	c7 44 07 08 ff ff 00 	movl   $0xffff,0x8(%edi,%eax,1)
  104c13:	00 
  104c14:	c7 44 38 0c 00 9a cf 	movl   $0xcf9a00,0xc(%eax,%edi,1)
  104c1b:	00 
    proc_kstack[pid].gdt[CPU_GDT_KDATA >> 3] =
  104c1c:	c7 44 07 10 ff ff 00 	movl   $0xffff,0x10(%edi,%eax,1)
  104c23:	00 
  104c24:	c7 44 38 14 00 92 cf 	movl   $0xcf9200,0x14(%eax,%edi,1)
  104c2b:	00 
    proc_kstack[pid].gdt[CPU_GDT_UCODE >> 3] =
  104c2c:	c7 44 07 18 ff ff 00 	movl   $0xffff,0x18(%edi,%eax,1)
  104c33:	00 
  104c34:	c7 44 38 1c 00 fa cf 	movl   $0xcffa00,0x1c(%eax,%edi,1)
  104c3b:	00 
    proc_kstack[pid].gdt[CPU_GDT_UDATA >> 3] =
  104c3c:	c7 44 07 20 ff ff 00 	movl   $0xffff,0x20(%edi,%eax,1)
  104c43:	00 
  104c44:	c7 44 38 24 00 f2 cf 	movl   $0xcff200,0x24(%eax,%edi,1)
  104c4b:	00 
    proc_kstack[pid].tss.ts_esp0 = (uint32_t) proc_kstack[pid].kstack_hi;
  104c4c:	8d 44 3d 00          	lea    0x0(%ebp,%edi,1),%eax
  104c50:	89 46 34             	mov    %eax,0x34(%esi)
    proc_kstack[pid].tss.ts_ss0 = CPU_GDT_KDATA;
  104c53:	b8 10 00 00 00       	mov    $0x10,%eax
  104c58:	66 89 46 38          	mov    %ax,0x38(%esi)
    memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  104c5c:	8d 84 2f 98 f0 ff ff 	lea    -0xf68(%edi,%ebp,1),%eax
    proc_kstack[pid].tss.ts_iomb = offsetof(tss_t, ts_iopm);
  104c63:	66 89 96 96 00 00 00 	mov    %dx,0x96(%esi)
    memzero (proc_kstack[pid].tss.ts_iopm, sizeof(uint8_t) * 128);
  104c6a:	68 80 00 00 00       	push   $0x80
  104c6f:	50                   	push   %eax
  104c70:	e8 ab f3 ff ff       	call   104020 <memzero>
    proc_kstack[pid].tss.ts_iopm[128] = 0xff;

    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104c75:	bb 89 40 00 00       	mov    $0x4089,%ebx
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104c7a:	8d 84 2f 30 f0 ff ff 	lea    -0xfd0(%edi,%ebp,1),%eax
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104c81:	b9 eb 00 00 00       	mov    $0xeb,%ecx
  104c86:	66 89 46 2a          	mov    %ax,0x2a(%esi)
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104c8a:	89 c2                	mov    %eax,%edx
  104c8c:	c1 e8 18             	shr    $0x18,%eax
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104c8f:	88 46 2f             	mov    %al,0x2f(%esi)
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3].sd_s = 0;

    /* other fields */
    proc_kstack[pid].magic = KSTACK_MAGIC;
    proc_kstack[pid].cpu_idx = cpu_idx;
  104c92:	8b 44 24 30          	mov    0x30(%esp),%eax
        SEGDESC16(STS_T32A, (uint32_t) &proc_kstack[pid].tss, sizeof(tss_t) - 1, 0);
  104c96:	c1 ea 10             	shr    $0x10,%edx
    proc_kstack[pid].tss.ts_iopm[128] = 0xff;
  104c99:	c6 86 18 01 00 00 ff 	movb   $0xff,0x118(%esi)
    proc_kstack[pid].gdt[CPU_GDT_TSS >> 3] =
  104ca0:	66 89 4e 28          	mov    %cx,0x28(%esi)
  104ca4:	88 56 2c             	mov    %dl,0x2c(%esi)
  104ca7:	66 89 5e 2d          	mov    %bx,0x2d(%esi)
    proc_kstack[pid].magic = KSTACK_MAGIC;
  104cab:	c7 86 20 01 00 00 32 	movl   $0x98765432,0x120(%esi)
  104cb2:	54 76 98 
    proc_kstack[pid].cpu_idx = cpu_idx;
  104cb5:	89 86 1c 01 00 00    	mov    %eax,0x11c(%esi)
}
  104cbb:	83 c4 1c             	add    $0x1c,%esp
  104cbe:	5b                   	pop    %ebx
  104cbf:	5e                   	pop    %esi
  104cc0:	5f                   	pop    %edi
  104cc1:	5d                   	pop    %ebp
  104cc2:	c3                   	ret
  104cc3:	66 90                	xchg   %ax,%ax
  104cc5:	66 90                	xchg   %ax,%ax
  104cc7:	66 90                	xchg   %ax,%ax
  104cc9:	66 90                	xchg   %ax,%ax
  104ccb:	66 90                	xchg   %ax,%ax
  104ccd:	66 90                	xchg   %ax,%ax
  104ccf:	90                   	nop

00104cd0 <max>:
#include "types.h"

uint32_t max(uint32_t a, uint32_t b)
{
  104cd0:	8b 44 24 08          	mov    0x8(%esp),%eax
    return (a > b) ? a : b;
  104cd4:	8b 54 24 04          	mov    0x4(%esp),%edx
  104cd8:	39 d0                	cmp    %edx,%eax
  104cda:	0f 42 c2             	cmovb  %edx,%eax
}
  104cdd:	c3                   	ret
  104cde:	66 90                	xchg   %ax,%ax

00104ce0 <min>:

uint32_t min(uint32_t a, uint32_t b)
{
  104ce0:	8b 44 24 08          	mov    0x8(%esp),%eax
    return (a < b) ? a : b;
  104ce4:	8b 54 24 04          	mov    0x4(%esp),%edx
  104ce8:	39 d0                	cmp    %edx,%eax
  104cea:	0f 47 c2             	cmova  %edx,%eax
}
  104ced:	c3                   	ret
  104cee:	66 90                	xchg   %ax,%ax

00104cf0 <rounddown>:

uint32_t rounddown(uint32_t a, uint32_t n)
{
  104cf0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    return a - a % n;
  104cf4:	31 d2                	xor    %edx,%edx
  104cf6:	89 c8                	mov    %ecx,%eax
  104cf8:	f7 74 24 08          	divl   0x8(%esp)
  104cfc:	89 c8                	mov    %ecx,%eax
  104cfe:	29 d0                	sub    %edx,%eax
}
  104d00:	c3                   	ret
  104d01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104d08:	00 
  104d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104d10 <roundup>:

uint32_t roundup(uint32_t a, uint32_t n)
{
  104d10:	53                   	push   %ebx
  104d11:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
    return a - a % n;
  104d15:	31 d2                	xor    %edx,%edx
    return rounddown(a + n - 1, n);
  104d17:	8d 4b ff             	lea    -0x1(%ebx),%ecx
  104d1a:	03 4c 24 08          	add    0x8(%esp),%ecx
    return a - a % n;
  104d1e:	89 c8                	mov    %ecx,%eax
  104d20:	f7 f3                	div    %ebx
  104d22:	89 c8                	mov    %ecx,%eax
}
  104d24:	5b                   	pop    %ebx
    return a - a % n;
  104d25:	29 d0                	sub    %edx,%eax
}
  104d27:	c3                   	ret
  104d28:	66 90                	xchg   %ax,%ax
  104d2a:	66 90                	xchg   %ax,%ax
  104d2c:	66 90                	xchg   %ax,%ax
  104d2e:	66 90                	xchg   %ax,%ax

00104d30 <read_esp>:
#include "x86.h"

gcc_inline uintptr_t read_esp(void)
{
    uint32_t esp;
    __asm __volatile ("movl %%esp,%0" : "=rm" (esp));
  104d30:	89 e0                	mov    %esp,%eax
    return esp;
}
  104d32:	c3                   	ret
  104d33:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104d3a:	00 
  104d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104d40 <read_ebp>:

gcc_inline uint32_t read_ebp(void)
{
    uint32_t ebp;
    __asm __volatile ("movl %%ebp,%0" : "=rm" (ebp));
  104d40:	89 e8                	mov    %ebp,%eax
    return ebp;
}
  104d42:	c3                   	ret
  104d43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104d4a:	00 
  104d4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104d50 <lldt>:

gcc_inline void lldt(uint16_t sel)
{
    __asm __volatile ("lldt %0" :: "r" (sel));
  104d50:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  104d55:	0f 00 d0             	lldt   %eax
}
  104d58:	c3                   	ret
  104d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104d60 <cli>:

gcc_inline void cli(void)
{
    __asm __volatile ("cli" ::: "memory");
  104d60:	fa                   	cli
}
  104d61:	c3                   	ret
  104d62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104d69:	00 
  104d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104d70 <sti>:

gcc_inline void sti(void)
{
    __asm __volatile ("sti; nop");
  104d70:	fb                   	sti
  104d71:	90                   	nop
}
  104d72:	c3                   	ret
  104d73:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104d7a:	00 
  104d7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104d80 <rdmsr>:

gcc_inline uint64_t rdmsr(uint32_t msr)
{
    uint64_t rv;
    __asm __volatile ("rdmsr"
  104d80:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104d84:	0f 32                	rdmsr
                      : "=A" (rv)
                      : "c" (msr));
    return rv;
}
  104d86:	c3                   	ret
  104d87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104d8e:	00 
  104d8f:	90                   	nop

00104d90 <wrmsr>:

gcc_inline void wrmsr(uint32_t msr, uint64_t newval)
{
    __asm __volatile ("wrmsr" :: "A" (newval), "c" (msr));
  104d90:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  104d94:	8b 44 24 08          	mov    0x8(%esp),%eax
  104d98:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104d9c:	0f 30                	wrmsr
}
  104d9e:	c3                   	ret
  104d9f:	90                   	nop

00104da0 <halt>:

gcc_inline void halt(void)
{
    __asm __volatile ("hlt");
  104da0:	f4                   	hlt
}
  104da1:	c3                   	ret
  104da2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104da9:	00 
  104daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104db0 <pause>:

gcc_inline void pause(void)
{
    __asm __volatile ("pause" ::: "memory");
  104db0:	f3 90                	pause
}
  104db2:	c3                   	ret
  104db3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104dba:	00 
  104dbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104dc0 <xchg>:

gcc_inline uint32_t xchg(volatile uint32_t *addr, uint32_t newval)
{
  104dc0:	8b 54 24 04          	mov    0x4(%esp),%edx
    uint32_t result;

    __asm __volatile ("lock; xchgl %0, %1"
  104dc4:	8b 44 24 08          	mov    0x8(%esp),%eax
  104dc8:	f0 87 02             	lock xchg %eax,(%edx)
                      : "+m" (*addr), "=a" (result)
                      : "1" (newval)
                      : "cc");

    return result;
}
  104dcb:	c3                   	ret
  104dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104dd0 <cmpxchg>:

gcc_inline uint32_t cmpxchg(volatile uint32_t *addr, uint32_t oldval, uint32_t newval)
{
  104dd0:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    uint32_t result;

    __asm __volatile ("lock; cmpxchgl %2, %0"
  104dd4:	8b 44 24 08          	mov    0x8(%esp),%eax
  104dd8:	8b 54 24 0c          	mov    0xc(%esp),%edx
  104ddc:	f0 0f b1 11          	lock cmpxchg %edx,(%ecx)
                      : "+m" (*addr), "=a" (result)
                      : "r" (newval), "a" (oldval)
                      : "memory", "cc");

    return result;
}
  104de0:	c3                   	ret
  104de1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104de8:	00 
  104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104df0 <rdtsc>:

gcc_inline uint64_t rdtsc(void)
{
    uint64_t rv;

    __asm __volatile ("rdtsc" : "=A" (rv));
  104df0:	0f 31                	rdtsc
    return (rv);
}
  104df2:	c3                   	ret
  104df3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104dfa:	00 
  104dfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104e00 <enable_sse>:
}

gcc_inline uint32_t rcr4(void)
{
    uint32_t cr4;
    __asm __volatile ("movl %%cr4,%0" : "=r" (cr4));
  104e00:	0f 20 e0             	mov    %cr4,%eax
    FENCE();
  104e03:	0f ae f0             	mfence
    cr4 = rcr4() | CR4_OSFXSR | CR4_OSXMMEXCPT;
  104e06:	80 cc 06             	or     $0x6,%ah
    __asm __volatile ("movl %0,%%cr4" :: "r" (val));
  104e09:	0f 22 e0             	mov    %eax,%cr4
    __asm __volatile ("movl %%cr0,%0" : "=r" (val));
  104e0c:	0f 20 c0             	mov    %cr0,%eax
    FENCE();
  104e0f:	0f ae f0             	mfence
}
  104e12:	c3                   	ret
  104e13:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104e1a:	00 
  104e1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104e20 <cpuid>:
{
  104e20:	55                   	push   %ebp
  104e21:	57                   	push   %edi
  104e22:	56                   	push   %esi
  104e23:	53                   	push   %ebx
  104e24:	8b 44 24 14          	mov    0x14(%esp),%eax
  104e28:	8b 74 24 18          	mov    0x18(%esp),%esi
  104e2c:	8b 7c 24 1c          	mov    0x1c(%esp),%edi
  104e30:	8b 6c 24 20          	mov    0x20(%esp),%ebp
    __asm __volatile ("cpuid"
  104e34:	0f a2                	cpuid
    if (eaxp)
  104e36:	85 f6                	test   %esi,%esi
  104e38:	74 02                	je     104e3c <cpuid+0x1c>
        *eaxp = eax;
  104e3a:	89 06                	mov    %eax,(%esi)
    if (ebxp)
  104e3c:	85 ff                	test   %edi,%edi
  104e3e:	74 02                	je     104e42 <cpuid+0x22>
        *ebxp = ebx;
  104e40:	89 1f                	mov    %ebx,(%edi)
    if (ecxp)
  104e42:	85 ed                	test   %ebp,%ebp
  104e44:	74 03                	je     104e49 <cpuid+0x29>
        *ecxp = ecx;
  104e46:	89 4d 00             	mov    %ecx,0x0(%ebp)
    if (edxp)
  104e49:	8b 44 24 24          	mov    0x24(%esp),%eax
  104e4d:	85 c0                	test   %eax,%eax
  104e4f:	74 06                	je     104e57 <cpuid+0x37>
        *edxp = edx;
  104e51:	8b 44 24 24          	mov    0x24(%esp),%eax
  104e55:	89 10                	mov    %edx,(%eax)
}
  104e57:	5b                   	pop    %ebx
  104e58:	5e                   	pop    %esi
  104e59:	5f                   	pop    %edi
  104e5a:	5d                   	pop    %ebp
  104e5b:	c3                   	ret
  104e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104e60 <cpuid_subleaf>:
{
  104e60:	55                   	push   %ebp
  104e61:	57                   	push   %edi
  104e62:	56                   	push   %esi
  104e63:	53                   	push   %ebx
  104e64:	8b 74 24 1c          	mov    0x1c(%esp),%esi
  104e68:	8b 7c 24 20          	mov    0x20(%esp),%edi
  104e6c:	8b 6c 24 24          	mov    0x24(%esp),%ebp
    asm volatile ("cpuid"
  104e70:	8b 44 24 14          	mov    0x14(%esp),%eax
  104e74:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  104e78:	0f a2                	cpuid
    if (eaxp)
  104e7a:	85 f6                	test   %esi,%esi
  104e7c:	74 02                	je     104e80 <cpuid_subleaf+0x20>
        *eaxp = eax;
  104e7e:	89 06                	mov    %eax,(%esi)
    if (ebxp)
  104e80:	85 ff                	test   %edi,%edi
  104e82:	74 02                	je     104e86 <cpuid_subleaf+0x26>
        *ebxp = ebx;
  104e84:	89 1f                	mov    %ebx,(%edi)
    if (ecxp)
  104e86:	85 ed                	test   %ebp,%ebp
  104e88:	74 03                	je     104e8d <cpuid_subleaf+0x2d>
        *ecxp = ecx;
  104e8a:	89 4d 00             	mov    %ecx,0x0(%ebp)
    if (edxp)
  104e8d:	8b 44 24 28          	mov    0x28(%esp),%eax
  104e91:	85 c0                	test   %eax,%eax
  104e93:	74 06                	je     104e9b <cpuid_subleaf+0x3b>
        *edxp = edx;
  104e95:	8b 44 24 28          	mov    0x28(%esp),%eax
  104e99:	89 10                	mov    %edx,(%eax)
}
  104e9b:	5b                   	pop    %ebx
  104e9c:	5e                   	pop    %esi
  104e9d:	5f                   	pop    %edi
  104e9e:	5d                   	pop    %ebp
  104e9f:	c3                   	ret

00104ea0 <rcr3>:
    __asm __volatile ("movl %%cr3,%0" : "=r" (val));
  104ea0:	0f 20 d8             	mov    %cr3,%eax
}
  104ea3:	c3                   	ret
  104ea4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104eab:	00 
  104eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104eb0 <outl>:
    __asm __volatile ("outl %0,%w1" :: "a" (data), "d" (port));
  104eb0:	8b 54 24 04          	mov    0x4(%esp),%edx
  104eb4:	8b 44 24 08          	mov    0x8(%esp),%eax
  104eb8:	ef                   	out    %eax,(%dx)
}
  104eb9:	c3                   	ret
  104eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104ec0 <inl>:
    __asm __volatile ("inl %w1,%0" : "=a" (data) : "d" (port));
  104ec0:	8b 54 24 04          	mov    0x4(%esp),%edx
  104ec4:	ed                   	in     (%dx),%eax
}
  104ec5:	c3                   	ret
  104ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104ecd:	00 
  104ece:	66 90                	xchg   %ax,%ax

00104ed0 <smp_wmb>:
}
  104ed0:	c3                   	ret
  104ed1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104ed8:	00 
  104ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104ee0 <ltr>:
    __asm __volatile ("ltr %0" :: "r" (sel));
  104ee0:	0f b7 44 24 04       	movzwl 0x4(%esp),%eax
  104ee5:	0f 00 d8             	ltr    %eax
}
  104ee8:	c3                   	ret
  104ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104ef0 <lcr0>:
    __asm __volatile ("movl %0,%%cr0" :: "r" (val));
  104ef0:	8b 44 24 04          	mov    0x4(%esp),%eax
  104ef4:	0f 22 c0             	mov    %eax,%cr0
}
  104ef7:	c3                   	ret
  104ef8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104eff:	00 

00104f00 <rcr0>:
    __asm __volatile ("movl %%cr0,%0" : "=r" (val));
  104f00:	0f 20 c0             	mov    %cr0,%eax
}
  104f03:	c3                   	ret
  104f04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f0b:	00 
  104f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104f10 <rcr2>:
    __asm __volatile ("movl %%cr2,%0" : "=r" (val));
  104f10:	0f 20 d0             	mov    %cr2,%eax
}
  104f13:	c3                   	ret
  104f14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f1b:	00 
  104f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104f20 <lcr3>:
    __asm __volatile ("movl %0,%%cr3" :: "r" (val));
  104f20:	8b 44 24 04          	mov    0x4(%esp),%eax
  104f24:	0f 22 d8             	mov    %eax,%cr3
}
  104f27:	c3                   	ret
  104f28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f2f:	00 

00104f30 <lcr4>:
    __asm __volatile ("movl %0,%%cr4" :: "r" (val));
  104f30:	8b 44 24 04          	mov    0x4(%esp),%eax
  104f34:	0f 22 e0             	mov    %eax,%cr4
}
  104f37:	c3                   	ret
  104f38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f3f:	00 

00104f40 <rcr4>:
    __asm __volatile ("movl %%cr4,%0" : "=r" (cr4));
  104f40:	0f 20 e0             	mov    %cr4,%eax
    return cr4;
}
  104f43:	c3                   	ret
  104f44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f4b:	00 
  104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00104f50 <inb>:

gcc_inline uint8_t inb(int port)
{
    uint8_t data;
    __asm __volatile ("inb %w1,%0"
  104f50:	8b 54 24 04          	mov    0x4(%esp),%edx
  104f54:	ec                   	in     (%dx),%al
                      : "=a" (data)
                      : "d" (port));
    return data;
}
  104f55:	c3                   	ret
  104f56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f5d:	00 
  104f5e:	66 90                	xchg   %ax,%ax

00104f60 <insl>:

gcc_inline void insl(int port, void *addr, int cnt)
{
  104f60:	57                   	push   %edi
    __asm __volatile ("cld\n\trepne\n\tinsl"
  104f61:	8b 7c 24 0c          	mov    0xc(%esp),%edi
  104f65:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104f69:	8b 54 24 08          	mov    0x8(%esp),%edx
  104f6d:	fc                   	cld
  104f6e:	f2 6d                	repnz insl (%dx),%es:(%edi)
                      : "=D" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "memory", "cc");
}
  104f70:	5f                   	pop    %edi
  104f71:	c3                   	ret
  104f72:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  104f79:	00 
  104f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104f80 <outb>:

gcc_inline void outb(int port, uint8_t data)
{
    __asm __volatile ("outb %0,%w1" :: "a" (data), "d" (port));
  104f80:	8b 54 24 04          	mov    0x4(%esp),%edx
  104f84:	0f b6 44 24 08       	movzbl 0x8(%esp),%eax
  104f89:	ee                   	out    %al,(%dx)
}
  104f8a:	c3                   	ret
  104f8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00104f90 <outsw>:

gcc_inline void outsw(int port, const void *addr, int cnt)
{
  104f90:	56                   	push   %esi
    __asm __volatile ("cld\n\trepne\n\toutsw"
  104f91:	8b 74 24 0c          	mov    0xc(%esp),%esi
  104f95:	8b 4c 24 10          	mov    0x10(%esp),%ecx
  104f99:	8b 54 24 08          	mov    0x8(%esp),%edx
  104f9d:	fc                   	cld
  104f9e:	f2 66 6f             	repnz outsw %ds:(%esi),(%dx)
                      : "=S" (addr), "=c" (cnt)
                      : "d" (port), "0" (addr), "1" (cnt)
                      : "cc");
}
  104fa1:	5e                   	pop    %esi
  104fa2:	c3                   	ret
  104fa3:	66 90                	xchg   %ax,%ax
  104fa5:	66 90                	xchg   %ax,%ax
  104fa7:	66 90                	xchg   %ax,%ax
  104fa9:	66 90                	xchg   %ax,%ax
  104fab:	66 90                	xchg   %ax,%ax
  104fad:	66 90                	xchg   %ax,%ax
  104faf:	90                   	nop

00104fb0 <mon_help>:

#define NCOMMANDS (sizeof(commands) / sizeof(commands[0]))

/***** Implementations of basic kernel monitor commands *****/
int mon_help(int argc, char **argv, struct Trapframe *tf)
{
  104fb0:	56                   	push   %esi
  104fb1:	53                   	push   %ebx
  104fb2:	e8 eb b3 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  104fb7:	81 c3 3d c0 00 00    	add    $0xc03d,%ebx
  104fbd:	83 ec 08             	sub    $0x8,%esp
    int i;

    for (i = 0; i < NCOMMANDS; i++)
        dprintf("%s - %s\n", commands[i].name, commands[i].desc);
  104fc0:	8d 83 f1 83 ff ff    	lea    -0x7c0f(%ebx),%eax
  104fc6:	8d b3 14 84 ff ff    	lea    -0x7bec(%ebx),%esi
  104fcc:	50                   	push   %eax
  104fcd:	8d 83 0f 84 ff ff    	lea    -0x7bf1(%ebx),%eax
  104fd3:	50                   	push   %eax
  104fd4:	56                   	push   %esi
  104fd5:	e8 f6 f3 ff ff       	call   1043d0 <dprintf>
  104fda:	83 c4 0c             	add    $0xc,%esp
  104fdd:	8d 83 0c 8e ff ff    	lea    -0x71f4(%ebx),%eax
  104fe3:	50                   	push   %eax
  104fe4:	8d 83 1d 84 ff ff    	lea    -0x7be3(%ebx),%eax
  104fea:	50                   	push   %eax
  104feb:	56                   	push   %esi
  104fec:	e8 df f3 ff ff       	call   1043d0 <dprintf>
    return 0;
}
  104ff1:	83 c4 14             	add    $0x14,%esp
  104ff4:	31 c0                	xor    %eax,%eax
  104ff6:	5b                   	pop    %ebx
  104ff7:	5e                   	pop    %esi
  104ff8:	c3                   	ret
  104ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105000 <mon_kerninfo>:

int mon_kerninfo(int argc, char **argv, struct Trapframe *tf)
{
  105000:	57                   	push   %edi
  105001:	56                   	push   %esi
  105002:	53                   	push   %ebx
  105003:	e8 9a b3 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105008:	81 c3 ec bf 00 00    	add    $0xbfec,%ebx
    extern uint8_t start[], etext[], edata[], end[];

    dprintf("Special kernel symbols:\n");
  10500e:	83 ec 0c             	sub    $0xc,%esp
  105011:	8d 83 26 84 ff ff    	lea    -0x7bda(%ebx),%eax
  105017:	50                   	push   %eax
  105018:	e8 b3 f3 ff ff       	call   1043d0 <dprintf>
    dprintf("  start  %08x\n", start);
  10501d:	c7 c7 50 60 10 00    	mov    $0x106050,%edi
  105023:	58                   	pop    %eax
  105024:	8d 83 3f 84 ff ff    	lea    -0x7bc1(%ebx),%eax
  10502a:	5a                   	pop    %edx
  10502b:	57                   	push   %edi
  10502c:	50                   	push   %eax
  10502d:	e8 9e f3 ff ff       	call   1043d0 <dprintf>
    dprintf("  etext  %08x\n", etext);
  105032:	8d 83 4e 84 ff ff    	lea    -0x7bb2(%ebx),%eax
  105038:	59                   	pop    %ecx
  105039:	5e                   	pop    %esi
  10503a:	ff b3 f8 ff ff ff    	push   -0x8(%ebx)
  105040:	50                   	push   %eax
  105041:	e8 8a f3 ff ff       	call   1043d0 <dprintf>
    dprintf("  edata  %08x\n", edata);
  105046:	58                   	pop    %eax
  105047:	8d 83 5d 84 ff ff    	lea    -0x7ba3(%ebx),%eax
  10504d:	5a                   	pop    %edx
  10504e:	ff b3 f0 ff ff ff    	push   -0x10(%ebx)
  105054:	50                   	push   %eax
  105055:	e8 76 f3 ff ff       	call   1043d0 <dprintf>
    dprintf("  end    %08x\n", end);
  10505a:	59                   	pop    %ecx
  10505b:	5e                   	pop    %esi
  10505c:	8d 83 6c 84 ff ff    	lea    -0x7b94(%ebx),%eax
  105062:	c7 c6 e4 6d e0 00    	mov    $0xe06de4,%esi
  105068:	56                   	push   %esi
    dprintf("Kernel executable memory footprint: %dKB\n",
            ROUNDUP(end - start, 1024) / 1024);
  105069:	29 fe                	sub    %edi,%esi
    dprintf("  end    %08x\n", end);
  10506b:	50                   	push   %eax
  10506c:	e8 5f f3 ff ff       	call   1043d0 <dprintf>
            ROUNDUP(end - start, 1024) / 1024);
  105071:	8d 86 ff 03 00 00    	lea    0x3ff(%esi),%eax
    dprintf("Kernel executable memory footprint: %dKB\n",
  105077:	5f                   	pop    %edi
  105078:	5a                   	pop    %edx
            ROUNDUP(end - start, 1024) / 1024);
  105079:	89 c1                	mov    %eax,%ecx
  10507b:	c1 f9 1f             	sar    $0x1f,%ecx
  10507e:	c1 e9 16             	shr    $0x16,%ecx
  105081:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  105084:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  10508a:	29 ca                	sub    %ecx,%edx
  10508c:	29 d0                	sub    %edx,%eax
    dprintf("Kernel executable memory footprint: %dKB\n",
  10508e:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  105094:	0f 48 c2             	cmovs  %edx,%eax
  105097:	c1 f8 0a             	sar    $0xa,%eax
  10509a:	50                   	push   %eax
  10509b:	8d 83 34 8e ff ff    	lea    -0x71cc(%ebx),%eax
  1050a1:	50                   	push   %eax
  1050a2:	e8 29 f3 ff ff       	call   1043d0 <dprintf>
    return 0;
  1050a7:	83 c4 10             	add    $0x10,%esp
}
  1050aa:	31 c0                	xor    %eax,%eax
  1050ac:	5b                   	pop    %ebx
  1050ad:	5e                   	pop    %esi
  1050ae:	5f                   	pop    %edi
  1050af:	c3                   	ret

001050b0 <monitor>:
    dprintf("Unknown command '%s'\n", argv[0]);
    return 0;
}

void monitor(struct Trapframe *tf)
{
  1050b0:	55                   	push   %ebp
  1050b1:	57                   	push   %edi
  1050b2:	56                   	push   %esi
  1050b3:	53                   	push   %ebx
  1050b4:	e8 e9 b2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1050b9:	81 c3 3b bf 00 00    	add    $0xbf3b,%ebx
  1050bf:	83 ec 68             	sub    $0x68,%esp
    char *buf;

    dprintf("\n****************************************\n\n");
  1050c2:	8d b3 60 8e ff ff    	lea    -0x71a0(%ebx),%esi
  1050c8:	8d ab 7b 84 ff ff    	lea    -0x7b85(%ebx),%ebp
  1050ce:	56                   	push   %esi
        while (*buf && strchr(WHITESPACE, *buf))
  1050cf:	8d bb 7f 84 ff ff    	lea    -0x7b81(%ebx),%edi
    dprintf("\n****************************************\n\n");
  1050d5:	e8 f6 f2 ff ff       	call   1043d0 <dprintf>
    dprintf("Welcome to the mCertiKOS kernel monitor!\n");
  1050da:	8d 83 8c 8e ff ff    	lea    -0x7174(%ebx),%eax
  1050e0:	89 04 24             	mov    %eax,(%esp)
  1050e3:	e8 e8 f2 ff ff       	call   1043d0 <dprintf>
    dprintf("\n****************************************\n\n");
  1050e8:	89 34 24             	mov    %esi,(%esp)
  1050eb:	e8 e0 f2 ff ff       	call   1043d0 <dprintf>
    dprintf("Type 'help' for a list of commands.\n");
  1050f0:	8d 83 b8 8e ff ff    	lea    -0x7148(%ebx),%eax
  1050f6:	89 04 24             	mov    %eax,(%esp)
  1050f9:	e8 d2 f2 ff ff       	call   1043d0 <dprintf>
  1050fe:	83 c4 10             	add    $0x10,%esp
  105101:	8d 83 0f 84 ff ff    	lea    -0x7bf1(%ebx),%eax
  105107:	89 44 24 08          	mov    %eax,0x8(%esp)
  10510b:	8d 44 24 10          	lea    0x10(%esp),%eax
  10510f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

    while (1) {
        buf = (char *) readline("$> ");
  105118:	83 ec 0c             	sub    $0xc,%esp
  10511b:	55                   	push   %ebp
  10511c:	e8 af b4 ff ff       	call   1005d0 <readline>
        if (buf != NULL)
  105121:	83 c4 10             	add    $0x10,%esp
        buf = (char *) readline("$> ");
  105124:	89 c6                	mov    %eax,%esi
        if (buf != NULL)
  105126:	85 c0                	test   %eax,%eax
  105128:	74 ee                	je     105118 <monitor+0x68>
    argv[argc] = 0;
  10512a:	89 2c 24             	mov    %ebp,(%esp)
    argc = 0;
  10512d:	31 d2                	xor    %edx,%edx
    argv[argc] = 0;
  10512f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  105136:	00 
  105137:	0f be 00             	movsbl (%eax),%eax
  10513a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        while (*buf && strchr(WHITESPACE, *buf))
  105140:	84 c0                	test   %al,%al
  105142:	75 6c                	jne    1051b0 <monitor+0x100>
    if (argc == 0)
  105144:	85 d2                	test   %edx,%edx
    argv[argc] = 0;
  105146:	8b 2c 24             	mov    (%esp),%ebp
  105149:	c7 44 94 10 00 00 00 	movl   $0x0,0x10(%esp,%edx,4)
  105150:	00 
    if (argc == 0)
  105151:	89 14 24             	mov    %edx,(%esp)
  105154:	74 c2                	je     105118 <monitor+0x68>
        if (strcmp(argv[0], commands[i].name) == 0)
  105156:	83 ec 08             	sub    $0x8,%esp
  105159:	ff 74 24 10          	push   0x10(%esp)
  10515d:	ff 74 24 1c          	push   0x1c(%esp)
  105161:	e8 2a ee ff ff       	call   103f90 <strcmp>
  105166:	83 c4 10             	add    $0x10,%esp
  105169:	8b 14 24             	mov    (%esp),%edx
  10516c:	85 c0                	test   %eax,%eax
  10516e:	0f 84 cd 00 00 00    	je     105241 <monitor+0x191>
  105174:	83 ec 08             	sub    $0x8,%esp
  105177:	8d 83 1d 84 ff ff    	lea    -0x7be3(%ebx),%eax
  10517d:	50                   	push   %eax
  10517e:	ff 74 24 1c          	push   0x1c(%esp)
  105182:	e8 09 ee ff ff       	call   103f90 <strcmp>
  105187:	83 c4 10             	add    $0x10,%esp
  10518a:	8b 14 24             	mov    (%esp),%edx
  10518d:	85 c0                	test   %eax,%eax
  10518f:	0f 84 d3 00 00 00    	je     105268 <monitor+0x1b8>
    dprintf("Unknown command '%s'\n", argv[0]);
  105195:	83 ec 08             	sub    $0x8,%esp
  105198:	8d 83 a1 84 ff ff    	lea    -0x7b5f(%ebx),%eax
  10519e:	ff 74 24 18          	push   0x18(%esp)
  1051a2:	50                   	push   %eax
  1051a3:	e8 28 f2 ff ff       	call   1043d0 <dprintf>
    return 0;
  1051a8:	83 c4 10             	add    $0x10,%esp
  1051ab:	e9 68 ff ff ff       	jmp    105118 <monitor+0x68>
  1051b0:	89 54 24 04          	mov    %edx,0x4(%esp)
        while (*buf && strchr(WHITESPACE, *buf))
  1051b4:	83 ec 08             	sub    $0x8,%esp
  1051b7:	50                   	push   %eax
  1051b8:	57                   	push   %edi
  1051b9:	e8 22 ee ff ff       	call   103fe0 <strchr>
  1051be:	83 c4 10             	add    $0x10,%esp
  1051c1:	8b 54 24 04          	mov    0x4(%esp),%edx
  1051c5:	85 c0                	test   %eax,%eax
  1051c7:	74 17                	je     1051e0 <monitor+0x130>
            *buf++ = 0;
  1051c9:	8d 46 01             	lea    0x1(%esi),%eax
  1051cc:	c6 06 00             	movb   $0x0,(%esi)
  1051cf:	89 d5                	mov    %edx,%ebp
  1051d1:	89 c6                	mov    %eax,%esi
  1051d3:	0f be 06             	movsbl (%esi),%eax
  1051d6:	89 ea                	mov    %ebp,%edx
  1051d8:	e9 63 ff ff ff       	jmp    105140 <monitor+0x90>
  1051dd:	8d 76 00             	lea    0x0(%esi),%esi
        if (*buf == 0)
  1051e0:	80 3e 00             	cmpb   $0x0,(%esi)
  1051e3:	0f 84 5b ff ff ff    	je     105144 <monitor+0x94>
        if (argc == MAXARGS - 1) {
  1051e9:	83 fa 0f             	cmp    $0xf,%edx
  1051ec:	74 37                	je     105225 <monitor+0x175>
        argv[argc++] = buf;
  1051ee:	89 74 94 10          	mov    %esi,0x10(%esp,%edx,4)
        while (*buf && !strchr(WHITESPACE, *buf))
  1051f2:	0f be 06             	movsbl (%esi),%eax
        argv[argc++] = buf;
  1051f5:	8d 6a 01             	lea    0x1(%edx),%ebp
        while (*buf && !strchr(WHITESPACE, *buf))
  1051f8:	0f be d0             	movsbl %al,%edx
  1051fb:	84 c0                	test   %al,%al
  1051fd:	74 d7                	je     1051d6 <monitor+0x126>
  1051ff:	90                   	nop
  105200:	83 ec 08             	sub    $0x8,%esp
  105203:	52                   	push   %edx
  105204:	57                   	push   %edi
  105205:	e8 d6 ed ff ff       	call   103fe0 <strchr>
  10520a:	83 c4 10             	add    $0x10,%esp
  10520d:	85 c0                	test   %eax,%eax
  10520f:	75 c2                	jne    1051d3 <monitor+0x123>
  105211:	0f be 56 01          	movsbl 0x1(%esi),%edx
            buf++;
  105215:	83 c6 01             	add    $0x1,%esi
        while (*buf && !strchr(WHITESPACE, *buf))
  105218:	84 d2                	test   %dl,%dl
  10521a:	75 e4                	jne    105200 <monitor+0x150>
  10521c:	31 c0                	xor    %eax,%eax
            *buf++ = 0;
  10521e:	89 ea                	mov    %ebp,%edx
  105220:	e9 1b ff ff ff       	jmp    105140 <monitor+0x90>
            dprintf("Too many arguments (max %d)\n", MAXARGS);
  105225:	8b 2c 24             	mov    (%esp),%ebp
  105228:	8d 83 84 84 ff ff    	lea    -0x7b7c(%ebx),%eax
  10522e:	83 ec 08             	sub    $0x8,%esp
  105231:	6a 10                	push   $0x10
  105233:	50                   	push   %eax
  105234:	e8 97 f1 ff ff       	call   1043d0 <dprintf>
            return 0;
  105239:	83 c4 10             	add    $0x10,%esp
  10523c:	e9 d7 fe ff ff       	jmp    105118 <monitor+0x68>
        if (strcmp(argv[0], commands[i].name) == 0)
  105241:	8d 83 bc 3f ff ff    	lea    -0xc044(%ebx),%eax
            return commands[i].func(argc, argv, tf);
  105247:	83 ec 04             	sub    $0x4,%esp
  10524a:	ff 74 24 74          	push   0x74(%esp)
  10524e:	ff 74 24 14          	push   0x14(%esp)
  105252:	52                   	push   %edx
  105253:	ff d0                	call   *%eax
            if (runcmd(buf, tf) < 0)
  105255:	83 c4 10             	add    $0x10,%esp
  105258:	85 c0                	test   %eax,%eax
  10525a:	0f 89 b8 fe ff ff    	jns    105118 <monitor+0x68>
                break;
    }
}
  105260:	83 c4 5c             	add    $0x5c,%esp
  105263:	5b                   	pop    %ebx
  105264:	5e                   	pop    %esi
  105265:	5f                   	pop    %edi
  105266:	5d                   	pop    %ebp
  105267:	c3                   	ret
        if (strcmp(argv[0], commands[i].name) == 0)
  105268:	8d 83 0c 40 ff ff    	lea    -0xbff4(%ebx),%eax
  10526e:	eb d7                	jmp    105247 <monitor+0x197>

00105270 <pt_copyin>:
extern unsigned int get_ptbl_entry_by_va(unsigned int pid,
                                         unsigned int vaddr);

size_t pt_copyin(uint32_t pmap_id, uintptr_t uva, void *kva, size_t len)
{
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  105270:	e8 25 b1 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  105275:	05 7f bd 00 00       	add    $0xbd7f,%eax
{
  10527a:	55                   	push   %ebp
        return 0;
  10527b:	31 c9                	xor    %ecx,%ecx
{
  10527d:	57                   	push   %edi
  10527e:	56                   	push   %esi
  10527f:	53                   	push   %ebx
  105280:	83 ec 1c             	sub    $0x1c,%esp
  105283:	8b 7c 24 34          	mov    0x34(%esp),%edi
  105287:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
  10528b:	89 44 24 04          	mov    %eax,0x4(%esp)
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  10528f:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  105295:	0f 86 b9 00 00 00    	jbe    105354 <pt_copyin+0xe4>
  10529b:	8d 04 2f             	lea    (%edi,%ebp,1),%eax
  10529e:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1052a3:	0f 87 ab 00 00 00    	ja     105354 <pt_copyin+0xe4>

    if ((uintptr_t) kva + len > VM_USERHI)
  1052a9:	8b 44 24 38          	mov    0x38(%esp),%eax
  1052ad:	01 e8                	add    %ebp,%eax
  1052af:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1052b4:	0f 87 9a 00 00 00    	ja     105354 <pt_copyin+0xe4>
        return 0;

    size_t copied = 0;

    while (len) {
  1052ba:	85 ed                	test   %ebp,%ebp
  1052bc:	0f 84 92 00 00 00    	je     105354 <pt_copyin+0xe4>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
        }

        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1052c2:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1052c6:	8b 74 24 38          	mov    0x38(%esp),%esi
  1052ca:	eb 45                	jmp    105311 <pt_copyin+0xa1>
  1052cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1052d0:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1052d2:	ba 00 10 00 00       	mov    $0x1000,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1052d7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1052dc:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1052e2:	29 ca                	sub    %ecx,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1052e4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1052e6:	39 ea                	cmp    %ebp,%edx
  1052e8:	0f 47 d5             	cmova  %ebp,%edx
            len : PAGESIZE - uva_pa % PAGESIZE;

        memcpy(kva, (void *) uva_pa, size);
  1052eb:	83 ec 04             	sub    $0x4,%esp
  1052ee:	52                   	push   %edx
  1052ef:	89 54 24 10          	mov    %edx,0x10(%esp)
  1052f3:	50                   	push   %eax
  1052f4:	56                   	push   %esi
  1052f5:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1052f9:	e8 02 ec ff ff       	call   103f00 <memcpy>

        len -= size;
        uva += size;
  1052fe:	8b 54 24 18          	mov    0x18(%esp),%edx
        kva += size;
        copied += size;
  105302:	01 54 24 1c          	add    %edx,0x1c(%esp)
    while (len) {
  105306:	83 c4 10             	add    $0x10,%esp
        uva += size;
  105309:	01 d7                	add    %edx,%edi
        kva += size;
  10530b:	01 d6                	add    %edx,%esi
    while (len) {
  10530d:	29 d5                	sub    %edx,%ebp
  10530f:	74 3f                	je     105350 <pt_copyin+0xe0>
        uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  105311:	83 ec 08             	sub    $0x8,%esp
  105314:	57                   	push   %edi
  105315:	ff 74 24 3c          	push   0x3c(%esp)
  105319:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  10531d:	e8 0e 16 00 00       	call   106930 <get_ptbl_entry_by_va>
        if ((uva_pa & PTE_P) == 0) {
  105322:	83 c4 10             	add    $0x10,%esp
  105325:	a8 01                	test   $0x1,%al
  105327:	75 a7                	jne    1052d0 <pt_copyin+0x60>
            alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  105329:	83 ec 04             	sub    $0x4,%esp
  10532c:	6a 07                	push   $0x7
  10532e:	57                   	push   %edi
  10532f:	ff 74 24 3c          	push   0x3c(%esp)
  105333:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  105337:	e8 a4 1a 00 00       	call   106de0 <alloc_page>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  10533c:	58                   	pop    %eax
  10533d:	5a                   	pop    %edx
  10533e:	57                   	push   %edi
  10533f:	ff 74 24 3c          	push   0x3c(%esp)
  105343:	e8 e8 15 00 00       	call   106930 <get_ptbl_entry_by_va>
  105348:	83 c4 10             	add    $0x10,%esp
  10534b:	eb 83                	jmp    1052d0 <pt_copyin+0x60>
  10534d:	8d 76 00             	lea    0x0(%esi),%esi
  105350:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    }

    return copied;
}
  105354:	83 c4 1c             	add    $0x1c,%esp
  105357:	89 c8                	mov    %ecx,%eax
  105359:	5b                   	pop    %ebx
  10535a:	5e                   	pop    %esi
  10535b:	5f                   	pop    %edi
  10535c:	5d                   	pop    %ebp
  10535d:	c3                   	ret
  10535e:	66 90                	xchg   %ax,%ax

00105360 <pt_copyout>:

size_t pt_copyout(void *kva, uint32_t pmap_id, uintptr_t uva, size_t len)
{
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  105360:	e8 35 b0 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  105365:	05 8f bc 00 00       	add    $0xbc8f,%eax
{
  10536a:	55                   	push   %ebp
        return 0;
  10536b:	31 c9                	xor    %ecx,%ecx
{
  10536d:	57                   	push   %edi
  10536e:	56                   	push   %esi
  10536f:	53                   	push   %ebx
  105370:	83 ec 1c             	sub    $0x1c,%esp
  105373:	8b 7c 24 38          	mov    0x38(%esp),%edi
  105377:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
  10537b:	89 44 24 04          	mov    %eax,0x4(%esp)
    if (!(VM_USERLO <= uva && uva + len <= VM_USERHI))
  10537f:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  105385:	0f 86 b9 00 00 00    	jbe    105444 <pt_copyout+0xe4>
  10538b:	8d 04 2f             	lea    (%edi,%ebp,1),%eax
  10538e:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  105393:	0f 87 ab 00 00 00    	ja     105444 <pt_copyout+0xe4>

    if ((uintptr_t) kva + len > VM_USERHI)
  105399:	8b 44 24 30          	mov    0x30(%esp),%eax
  10539d:	01 e8                	add    %ebp,%eax
  10539f:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
  1053a4:	0f 87 9a 00 00 00    	ja     105444 <pt_copyout+0xe4>
        return 0;

    size_t copied = 0;

    while (len) {
  1053aa:	85 ed                	test   %ebp,%ebp
  1053ac:	0f 84 92 00 00 00    	je     105444 <pt_copyout+0xe4>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
        }

        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);

        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1053b2:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1053b6:	8b 74 24 30          	mov    0x30(%esp),%esi
  1053ba:	eb 45                	jmp    105401 <pt_copyout+0xa1>
  1053bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1053c0:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1053c2:	ba 00 10 00 00       	mov    $0x1000,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1053c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1053cc:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1053d2:	29 ca                	sub    %ecx,%edx
        uva_pa = (uva_pa & 0xfffff000) + (uva % PAGESIZE);
  1053d4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - uva_pa % PAGESIZE) ?
  1053d6:	39 ea                	cmp    %ebp,%edx
  1053d8:	0f 47 d5             	cmova  %ebp,%edx
            len : PAGESIZE - uva_pa % PAGESIZE;

        memcpy((void *) uva_pa, kva, size);
  1053db:	83 ec 04             	sub    $0x4,%esp
  1053de:	52                   	push   %edx
  1053df:	89 54 24 10          	mov    %edx,0x10(%esp)
  1053e3:	56                   	push   %esi
  1053e4:	50                   	push   %eax
  1053e5:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  1053e9:	e8 12 eb ff ff       	call   103f00 <memcpy>

        len -= size;
        uva += size;
  1053ee:	8b 54 24 18          	mov    0x18(%esp),%edx
        kva += size;
        copied += size;
  1053f2:	01 54 24 1c          	add    %edx,0x1c(%esp)
    while (len) {
  1053f6:	83 c4 10             	add    $0x10,%esp
        uva += size;
  1053f9:	01 d7                	add    %edx,%edi
        kva += size;
  1053fb:	01 d6                	add    %edx,%esi
    while (len) {
  1053fd:	29 d5                	sub    %edx,%ebp
  1053ff:	74 3f                	je     105440 <pt_copyout+0xe0>
        uintptr_t uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  105401:	83 ec 08             	sub    $0x8,%esp
  105404:	57                   	push   %edi
  105405:	ff 74 24 40          	push   0x40(%esp)
  105409:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  10540d:	e8 1e 15 00 00       	call   106930 <get_ptbl_entry_by_va>
        if ((uva_pa & PTE_P) == 0) {
  105412:	83 c4 10             	add    $0x10,%esp
  105415:	a8 01                	test   $0x1,%al
  105417:	75 a7                	jne    1053c0 <pt_copyout+0x60>
            alloc_page(pmap_id, uva, PTE_P | PTE_U | PTE_W);
  105419:	83 ec 04             	sub    $0x4,%esp
  10541c:	6a 07                	push   $0x7
  10541e:	57                   	push   %edi
  10541f:	ff 74 24 40          	push   0x40(%esp)
  105423:	8b 5c 24 14          	mov    0x14(%esp),%ebx
  105427:	e8 b4 19 00 00       	call   106de0 <alloc_page>
            uva_pa = get_ptbl_entry_by_va(pmap_id, uva);
  10542c:	58                   	pop    %eax
  10542d:	5a                   	pop    %edx
  10542e:	57                   	push   %edi
  10542f:	ff 74 24 40          	push   0x40(%esp)
  105433:	e8 f8 14 00 00       	call   106930 <get_ptbl_entry_by_va>
  105438:	83 c4 10             	add    $0x10,%esp
  10543b:	eb 83                	jmp    1053c0 <pt_copyout+0x60>
  10543d:	8d 76 00             	lea    0x0(%esi),%esi
  105440:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    }

    return copied;
}
  105444:	83 c4 1c             	add    $0x1c,%esp
  105447:	89 c8                	mov    %ecx,%eax
  105449:	5b                   	pop    %ebx
  10544a:	5e                   	pop    %esi
  10544b:	5f                   	pop    %edi
  10544c:	5d                   	pop    %ebp
  10544d:	c3                   	ret
  10544e:	66 90                	xchg   %ax,%ax

00105450 <pt_memset>:

size_t pt_memset(uint32_t pmap_id, uintptr_t va, char c, size_t len)
{
  105450:	55                   	push   %ebp
  105451:	57                   	push   %edi
  105452:	56                   	push   %esi
  105453:	53                   	push   %ebx
  105454:	e8 49 af ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105459:	81 c3 9b bb 00 00    	add    $0xbb9b,%ebx
  10545f:	83 ec 1c             	sub    $0x1c,%esp
  105462:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  105466:	8b 7c 24 34          	mov    0x34(%esp),%edi
  10546a:	8b 44 24 38          	mov    0x38(%esp),%eax
    size_t set = 0;

    while (len) {
  10546e:	85 f6                	test   %esi,%esi
  105470:	0f 84 8a 00 00 00    	je     105500 <pt_memset+0xb0>
        pa = (pa & 0xfffff000) + (va % PAGESIZE);

        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
            len : PAGESIZE - pa % PAGESIZE;

        memset((void *) pa, c, size);
  105476:	0f be c0             	movsbl %al,%eax
    size_t set = 0;
  105479:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105480:	00 
        memset((void *) pa, c, size);
  105481:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105485:	eb 41                	jmp    1054c8 <pt_memset+0x78>
  105487:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10548e:	00 
  10548f:	90                   	nop
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105490:	89 f9                	mov    %edi,%ecx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  105492:	ba 00 10 00 00       	mov    $0x1000,%edx
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  105497:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10549c:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  1054a2:	29 ca                	sub    %ecx,%edx
        pa = (pa & 0xfffff000) + (va % PAGESIZE);
  1054a4:	09 c8                	or     %ecx,%eax
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  1054a6:	39 f2                	cmp    %esi,%edx
  1054a8:	0f 47 d6             	cmova  %esi,%edx
        memset((void *) pa, c, size);
  1054ab:	83 ec 04             	sub    $0x4,%esp
  1054ae:	52                   	push   %edx
        size_t size = (len < PAGESIZE - pa % PAGESIZE) ?
  1054af:	89 d5                	mov    %edx,%ebp
        memset((void *) pa, c, size);
  1054b1:	ff 74 24 14          	push   0x14(%esp)

        len -= size;
        va += size;
  1054b5:	01 ef                	add    %ebp,%edi
        memset((void *) pa, c, size);
  1054b7:	50                   	push   %eax
  1054b8:	e8 93 e9 ff ff       	call   103e50 <memset>
        set += size;
  1054bd:	01 6c 24 18          	add    %ebp,0x18(%esp)
    while (len) {
  1054c1:	83 c4 10             	add    $0x10,%esp
  1054c4:	29 ee                	sub    %ebp,%esi
  1054c6:	74 40                	je     105508 <pt_memset+0xb8>
        uintptr_t pa = get_ptbl_entry_by_va(pmap_id, va);
  1054c8:	83 ec 08             	sub    $0x8,%esp
  1054cb:	57                   	push   %edi
  1054cc:	ff 74 24 3c          	push   0x3c(%esp)
  1054d0:	e8 5b 14 00 00       	call   106930 <get_ptbl_entry_by_va>
        if ((pa & PTE_P) == 0) {
  1054d5:	83 c4 10             	add    $0x10,%esp
  1054d8:	a8 01                	test   $0x1,%al
  1054da:	75 b4                	jne    105490 <pt_memset+0x40>
            alloc_page(pmap_id, va, PTE_P | PTE_U | PTE_W);
  1054dc:	83 ec 04             	sub    $0x4,%esp
  1054df:	6a 07                	push   $0x7
  1054e1:	57                   	push   %edi
  1054e2:	ff 74 24 3c          	push   0x3c(%esp)
  1054e6:	e8 f5 18 00 00       	call   106de0 <alloc_page>
            pa = get_ptbl_entry_by_va(pmap_id, va);
  1054eb:	58                   	pop    %eax
  1054ec:	5a                   	pop    %edx
  1054ed:	57                   	push   %edi
  1054ee:	ff 74 24 3c          	push   0x3c(%esp)
  1054f2:	e8 39 14 00 00       	call   106930 <get_ptbl_entry_by_va>
  1054f7:	83 c4 10             	add    $0x10,%esp
  1054fa:	eb 94                	jmp    105490 <pt_memset+0x40>
  1054fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    size_t set = 0;
  105500:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  105507:	00 
    }

    return set;
}
  105508:	8b 44 24 08          	mov    0x8(%esp),%eax
  10550c:	83 c4 1c             	add    $0x1c,%esp
  10550f:	5b                   	pop    %ebx
  105510:	5e                   	pop    %esi
  105511:	5f                   	pop    %edi
  105512:	5d                   	pop    %ebp
  105513:	c3                   	ret
  105514:	66 90                	xchg   %ax,%ax
  105516:	66 90                	xchg   %ax,%ax
  105518:	66 90                	xchg   %ax,%ax
  10551a:	66 90                	xchg   %ax,%ax
  10551c:	66 90                	xchg   %ax,%ax
  10551e:	66 90                	xchg   %ax,%ax

00105520 <elf_load>:

/*
 * Load elf execution file exe to the virtual address space pmap.
 */
void elf_load(void *exe_ptr, int pid)
{
  105520:	55                   	push   %ebp
  105521:	57                   	push   %edi
  105522:	56                   	push   %esi
  105523:	53                   	push   %ebx
  105524:	e8 79 ae ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105529:	81 c3 cb ba 00 00    	add    $0xbacb,%ebx
  10552f:	83 ec 2c             	sub    $0x2c,%esp
    char *strtab __attribute__((unused));
    uintptr_t exe = (uintptr_t) exe_ptr;

    eh = (elfhdr *) exe;

    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105532:	8b 44 24 40          	mov    0x40(%esp),%eax
{
  105536:	8b 6c 24 44          	mov    0x44(%esp),%ebp
    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  10553a:	81 38 7f 45 4c 46    	cmpl   $0x464c457f,(%eax)
  105540:	74 1f                	je     105561 <elf_load+0x41>
  105542:	8d 83 b7 84 ff ff    	lea    -0x7b49(%ebx),%eax
  105548:	50                   	push   %eax
  105549:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  10554f:	50                   	push   %eax
  105550:	8d 83 d0 84 ff ff    	lea    -0x7b30(%ebx),%eax
  105556:	6a 1e                	push   $0x1e
  105558:	50                   	push   %eax
  105559:	e8 02 ec ff ff       	call   104160 <debug_panic>
  10555e:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  105561:	8b 44 24 40          	mov    0x40(%esp),%eax
  105565:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  105569:	66 85 c0             	test   %ax,%ax
  10556c:	0f 84 b6 01 00 00    	je     105728 <elf_load+0x208>

    sh = (sechdr *) ((uintptr_t) eh + eh->e_shoff);
    esh = sh + eh->e_shnum;

    strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
    KERN_ASSERT(sh[eh->e_shstrndx].sh_type == ELF_SHT_STRTAB);
  105572:	8b 4c 24 40          	mov    0x40(%esp),%ecx
  105576:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105579:	8d 04 c1             	lea    (%ecx,%eax,8),%eax
  10557c:	03 41 20             	add    0x20(%ecx),%eax
  10557f:	83 78 04 03          	cmpl   $0x3,0x4(%eax)
  105583:	74 1f                	je     1055a4 <elf_load+0x84>
  105585:	8d 83 00 8f ff ff    	lea    -0x7100(%ebx),%eax
  10558b:	50                   	push   %eax
  10558c:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  105592:	50                   	push   %eax
  105593:	8d 83 d0 84 ff ff    	lea    -0x7b30(%ebx),%eax
  105599:	6a 25                	push   $0x25
  10559b:	50                   	push   %eax
  10559c:	e8 bf eb ff ff       	call   104160 <debug_panic>
  1055a1:	83 c4 10             	add    $0x10,%esp

    ph = (proghdr *) ((uintptr_t) eh + eh->e_phoff);
  1055a4:	8b 44 24 40          	mov    0x40(%esp),%eax
  1055a8:	8b 50 1c             	mov    0x1c(%eax),%edx
  1055ab:	01 c2                	add    %eax,%edx
    eph = ph + eh->e_phnum;
  1055ad:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  1055b1:	c1 e0 05             	shl    $0x5,%eax
  1055b4:	8d 0c 02             	lea    (%edx,%eax,1),%ecx

    for (; ph < eph; ph++) {
  1055b7:	39 ca                	cmp    %ecx,%edx
  1055b9:	0f 83 5c 01 00 00    	jae    10571b <elf_load+0x1fb>
  1055bf:	89 4c 24 18          	mov    %ecx,0x18(%esp)
  1055c3:	eb 12                	jmp    1055d7 <elf_load+0xb7>
  1055c5:	8d 76 00             	lea    0x0(%esi),%esi
  1055c8:	8b 44 24 18          	mov    0x18(%esp),%eax
  1055cc:	83 c2 20             	add    $0x20,%edx
  1055cf:	39 c2                	cmp    %eax,%edx
  1055d1:	0f 83 44 01 00 00    	jae    10571b <elf_load+0x1fb>
        uintptr_t fa;
        uint32_t va, zva, eva, perm;

        if (ph->p_type != ELF_PROG_LOAD)
  1055d7:	83 3a 01             	cmpl   $0x1,(%edx)
  1055da:	75 ec                	jne    1055c8 <elf_load+0xa8>
            continue;

        fa = (uintptr_t) eh + rounddown(ph->p_offset, PAGESIZE);
  1055dc:	83 ec 08             	sub    $0x8,%esp
  1055df:	68 00 10 00 00       	push   $0x1000
  1055e4:	ff 72 04             	push   0x4(%edx)
  1055e7:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  1055eb:	e8 00 f7 ff ff       	call   104cf0 <rounddown>
  1055f0:	03 44 24 50          	add    0x50(%esp),%eax
        va = rounddown(ph->p_va, PAGESIZE);
  1055f4:	5f                   	pop    %edi
        fa = (uintptr_t) eh + rounddown(ph->p_offset, PAGESIZE);
  1055f5:	89 c6                	mov    %eax,%esi
        va = rounddown(ph->p_va, PAGESIZE);
  1055f7:	58                   	pop    %eax
  1055f8:	68 00 10 00 00       	push   $0x1000
  1055fd:	8b 54 24 18          	mov    0x18(%esp),%edx
  105601:	ff 72 08             	push   0x8(%edx)
  105604:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  105608:	e8 e3 f6 ff ff       	call   104cf0 <rounddown>
        zva = ph->p_va + ph->p_filesz;
  10560d:	8b 54 24 1c          	mov    0x1c(%esp),%edx
        va = rounddown(ph->p_va, PAGESIZE);
  105611:	89 c7                	mov    %eax,%edi
        zva = ph->p_va + ph->p_filesz;
  105613:	8b 4a 10             	mov    0x10(%edx),%ecx
  105616:	8b 42 08             	mov    0x8(%edx),%eax
  105619:	01 c1                	add    %eax,%ecx
  10561b:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
        eva = roundup(ph->p_va + ph->p_memsz, PAGESIZE);
  10561f:	83 c4 08             	add    $0x8,%esp
  105622:	68 00 10 00 00       	push   $0x1000
  105627:	03 42 14             	add    0x14(%edx),%eax
  10562a:	89 54 24 20          	mov    %edx,0x20(%esp)
  10562e:	50                   	push   %eax
  10562f:	e8 dc f6 ff ff       	call   104d10 <roundup>

        perm = PTE_U | PTE_P;
        if (ph->p_flags & ELF_PROG_FLAG_WRITE)
  105634:	8b 54 24 24          	mov    0x24(%esp),%edx
        eva = roundup(ph->p_va + ph->p_memsz, PAGESIZE);
  105638:	89 44 24 20          	mov    %eax,0x20(%esp)
        if (ph->p_flags & ELF_PROG_FLAG_WRITE)
  10563c:	83 c4 10             	add    $0x10,%esp
  10563f:	8b 42 18             	mov    0x18(%edx),%eax
  105642:	83 e0 02             	and    $0x2,%eax
        perm = PTE_U | PTE_P;
  105645:	83 f8 01             	cmp    $0x1,%eax
            perm |= PTE_W;

        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  105648:	8b 44 24 10          	mov    0x10(%esp),%eax
        perm = PTE_U | PTE_P;
  10564c:	19 c9                	sbb    %ecx,%ecx
  10564e:	83 e1 fe             	and    $0xfffffffe,%ecx
  105651:	83 c1 07             	add    $0x7,%ecx
        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  105654:	39 c7                	cmp    %eax,%edi
  105656:	0f 83 6c ff ff ff    	jae    1055c8 <elf_load+0xa8>
  10565c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  105660:	89 4c 24 14          	mov    %ecx,0x14(%esp)
  105664:	eb 42                	jmp    1056a8 <elf_load+0x188>
  105666:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10566d:	00 
  10566e:	66 90                	xchg   %ax,%ax
            alloc_page(pid, va, perm);

            if (va < rounddown(zva, PAGESIZE)) {
                /* copy a complete page */
                pt_copyout((void *) fa, pid, va, PAGESIZE);
            } else if (va < zva && ph->p_filesz) {
  105670:	8b 44 24 0c          	mov    0xc(%esp),%eax
  105674:	39 c7                	cmp    %eax,%edi
  105676:	73 0b                	jae    105683 <elf_load+0x163>
  105678:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  10567c:	8b 40 10             	mov    0x10(%eax),%eax
  10567f:	85 c0                	test   %eax,%eax
  105681:	75 5d                	jne    1056e0 <elf_load+0x1c0>
                /* copy a partial page */
                pt_memset(pid, va, 0, PAGESIZE);
                pt_copyout((void *) fa, pid, va, zva - va);
            } else {
                /* zero a page */
                pt_memset(pid, va, 0, PAGESIZE);
  105683:	68 00 10 00 00       	push   $0x1000
  105688:	6a 00                	push   $0x0
  10568a:	57                   	push   %edi
  10568b:	55                   	push   %ebp
  10568c:	e8 bf fd ff ff       	call   105450 <pt_memset>
  105691:	83 c4 10             	add    $0x10,%esp
        for (; va < eva; va += PAGESIZE, fa += PAGESIZE) {
  105694:	8b 44 24 10          	mov    0x10(%esp),%eax
  105698:	81 c7 00 10 00 00    	add    $0x1000,%edi
  10569e:	81 c6 00 10 00 00    	add    $0x1000,%esi
  1056a4:	39 c7                	cmp    %eax,%edi
  1056a6:	73 60                	jae    105708 <elf_load+0x1e8>
            alloc_page(pid, va, perm);
  1056a8:	83 ec 04             	sub    $0x4,%esp
  1056ab:	ff 74 24 18          	push   0x18(%esp)
  1056af:	57                   	push   %edi
  1056b0:	55                   	push   %ebp
  1056b1:	e8 2a 17 00 00       	call   106de0 <alloc_page>
            if (va < rounddown(zva, PAGESIZE)) {
  1056b6:	5a                   	pop    %edx
  1056b7:	59                   	pop    %ecx
  1056b8:	68 00 10 00 00       	push   $0x1000
  1056bd:	ff 74 24 18          	push   0x18(%esp)
  1056c1:	e8 2a f6 ff ff       	call   104cf0 <rounddown>
  1056c6:	83 c4 10             	add    $0x10,%esp
  1056c9:	39 c7                	cmp    %eax,%edi
  1056cb:	73 a3                	jae    105670 <elf_load+0x150>
                pt_copyout((void *) fa, pid, va, PAGESIZE);
  1056cd:	68 00 10 00 00       	push   $0x1000
  1056d2:	57                   	push   %edi
  1056d3:	55                   	push   %ebp
  1056d4:	56                   	push   %esi
  1056d5:	e8 86 fc ff ff       	call   105360 <pt_copyout>
  1056da:	83 c4 10             	add    $0x10,%esp
  1056dd:	eb b5                	jmp    105694 <elf_load+0x174>
  1056df:	90                   	nop
                pt_memset(pid, va, 0, PAGESIZE);
  1056e0:	68 00 10 00 00       	push   $0x1000
  1056e5:	6a 00                	push   $0x0
  1056e7:	57                   	push   %edi
  1056e8:	55                   	push   %ebp
  1056e9:	e8 62 fd ff ff       	call   105450 <pt_memset>
                pt_copyout((void *) fa, pid, va, zva - va);
  1056ee:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1056f2:	29 f8                	sub    %edi,%eax
  1056f4:	50                   	push   %eax
  1056f5:	57                   	push   %edi
  1056f6:	55                   	push   %ebp
  1056f7:	56                   	push   %esi
  1056f8:	e8 63 fc ff ff       	call   105360 <pt_copyout>
  1056fd:	83 c4 20             	add    $0x20,%esp
  105700:	eb 92                	jmp    105694 <elf_load+0x174>
  105702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105708:	8b 54 24 1c          	mov    0x1c(%esp),%edx
    for (; ph < eph; ph++) {
  10570c:	8b 44 24 18          	mov    0x18(%esp),%eax
  105710:	83 c2 20             	add    $0x20,%edx
  105713:	39 c2                	cmp    %eax,%edx
  105715:	0f 82 bc fe ff ff    	jb     1055d7 <elf_load+0xb7>
            }
        }
    }
}
  10571b:	83 c4 2c             	add    $0x2c,%esp
  10571e:	5b                   	pop    %ebx
  10571f:	5e                   	pop    %esi
  105720:	5f                   	pop    %edi
  105721:	5d                   	pop    %ebp
  105722:	c3                   	ret
  105723:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(eh->e_shstrndx != ELF_SHN_UNDEF);
  105728:	8d 83 e0 8e ff ff    	lea    -0x7120(%ebx),%eax
  10572e:	50                   	push   %eax
  10572f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  105735:	50                   	push   %eax
  105736:	8d 83 d0 84 ff ff    	lea    -0x7b30(%ebx),%eax
  10573c:	6a 1f                	push   $0x1f
  10573e:	50                   	push   %eax
  10573f:	e8 1c ea ff ff       	call   104160 <debug_panic>
    strtab = (char *) (exe + sh[eh->e_shstrndx].sh_offset);
  105744:	8b 44 24 50          	mov    0x50(%esp),%eax
  105748:	83 c4 10             	add    $0x10,%esp
  10574b:	0f b7 40 32          	movzwl 0x32(%eax),%eax
  10574f:	e9 1e fe ff ff       	jmp    105572 <elf_load+0x52>
  105754:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10575b:	00 
  10575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105760 <elf_entry>:

uintptr_t elf_entry(void *exe_ptr)
{
  105760:	56                   	push   %esi
  105761:	53                   	push   %ebx
  105762:	e8 3b ac ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105767:	81 c3 8d b8 00 00    	add    $0xb88d,%ebx
  10576d:	83 ec 04             	sub    $0x4,%esp
  105770:	8b 74 24 10          	mov    0x10(%esp),%esi
    uintptr_t exe = (uintptr_t) exe_ptr;
    elfhdr *eh = (elfhdr *) exe;
    KERN_ASSERT(eh->e_magic == ELF_MAGIC);
  105774:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10577a:	74 1f                	je     10579b <elf_entry+0x3b>
  10577c:	8d 83 b7 84 ff ff    	lea    -0x7b49(%ebx),%eax
  105782:	50                   	push   %eax
  105783:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  105789:	50                   	push   %eax
  10578a:	8d 83 d0 84 ff ff    	lea    -0x7b30(%ebx),%eax
  105790:	6a 50                	push   $0x50
  105792:	50                   	push   %eax
  105793:	e8 c8 e9 ff ff       	call   104160 <debug_panic>
  105798:	83 c4 10             	add    $0x10,%esp
    return (uintptr_t) eh->e_entry;
  10579b:	8b 46 18             	mov    0x18(%esi),%eax
}
  10579e:	83 c4 04             	add    $0x4,%esp
  1057a1:	5b                   	pop    %ebx
  1057a2:	5e                   	pop    %esi
  1057a3:	c3                   	ret
  1057a4:	66 90                	xchg   %ax,%ax
  1057a6:	66 90                	xchg   %ax,%ax
  1057a8:	66 90                	xchg   %ax,%ax
  1057aa:	66 90                	xchg   %ax,%ax
  1057ac:	66 90                	xchg   %ax,%ax
  1057ae:	66 90                	xchg   %ax,%ax

001057b0 <get_kstack_pointer>:

struct kstack bsp_kstack[NUM_CPUS];
struct kstack proc_kstack[NUM_IDS];

uintptr_t *get_kstack_pointer(void)
{
  1057b0:	53                   	push   %ebx
  1057b1:	e8 ec ab ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1057b6:	81 c3 3e b8 00 00    	add    $0xb83e,%ebx
  1057bc:	83 ec 08             	sub    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1057bf:	e8 6c f5 ff ff       	call   104d30 <read_esp>
}
  1057c4:	83 c4 08             	add    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1057c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
  1057cc:	5b                   	pop    %ebx
  1057cd:	c3                   	ret
  1057ce:	66 90                	xchg   %ax,%ax

001057d0 <get_kstack_cpu_idx>:

int get_kstack_cpu_idx(void)
{
  1057d0:	53                   	push   %ebx
  1057d1:	e8 cc ab ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1057d6:	81 c3 1e b8 00 00    	add    $0xb81e,%ebx
  1057dc:	83 ec 08             	sub    $0x8,%esp
    return (uintptr_t *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1057df:	e8 4c f5 ff ff       	call   104d30 <read_esp>
  1057e4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    struct kstack *ks = (struct kstack *) get_kstack_pointer();
    return ks->cpu_idx;
  1057e9:	8b 80 1c 01 00 00    	mov    0x11c(%eax),%eax
}
  1057ef:	83 c4 08             	add    $0x8,%esp
  1057f2:	5b                   	pop    %ebx
  1057f3:	c3                   	ret
  1057f4:	66 90                	xchg   %ax,%ax
  1057f6:	66 90                	xchg   %ax,%ax
  1057f8:	66 90                	xchg   %ax,%ax
  1057fa:	66 90                	xchg   %ax,%ax
  1057fc:	66 90                	xchg   %ax,%ax
  1057fe:	66 90                	xchg   %ax,%ax

00105800 <spinlock_init>:
#include "spinlock.h"

extern volatile uint64_t tsc_per_ms;

void gcc_inline spinlock_init(spinlock_t *lk)
{
  105800:	8b 44 24 04          	mov    0x4(%esp),%eax
    lk->lock_holder = NUM_CPUS + 1;
  105804:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
    lk->lock = 0;
  10580a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
  105811:	c3                   	ret
  105812:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105819:	00 
  10581a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105820 <spinlock_holding>:

bool gcc_inline spinlock_holding(spinlock_t *lk)
{
  105820:	57                   	push   %edi
  105821:	31 c0                	xor    %eax,%eax
  105823:	56                   	push   %esi
  105824:	53                   	push   %ebx
  105825:	8b 74 24 10          	mov    0x10(%esp),%esi
  105829:	e8 74 ab ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10582e:	81 c3 c6 b7 00 00    	add    $0xb7c6,%ebx
    if (!lk->lock)
  105834:	8b 56 04             	mov    0x4(%esi),%edx
  105837:	85 d2                	test   %edx,%edx
  105839:	75 05                	jne    105840 <spinlock_holding+0x20>
        return FALSE;

    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
    return lk->lock_holder == kstack->cpu_idx;
}
  10583b:	5b                   	pop    %ebx
  10583c:	5e                   	pop    %esi
  10583d:	5f                   	pop    %edi
  10583e:	c3                   	ret
  10583f:	90                   	nop
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105840:	e8 eb f4 ff ff       	call   104d30 <read_esp>
  105845:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  10584a:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105851:	54 76 98 
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105854:	89 c7                	mov    %eax,%edi
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105856:	74 1f                	je     105877 <spinlock_holding+0x57>
  105858:	8d 83 df 84 ff ff    	lea    -0x7b21(%ebx),%eax
  10585e:	50                   	push   %eax
  10585f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  105865:	50                   	push   %eax
  105866:	8d 83 fd 84 ff ff    	lea    -0x7b03(%ebx),%eax
  10586c:	6a 16                	push   $0x16
  10586e:	50                   	push   %eax
  10586f:	e8 ec e8 ff ff       	call   104160 <debug_panic>
  105874:	83 c4 10             	add    $0x10,%esp
    return lk->lock_holder == kstack->cpu_idx;
  105877:	8b 87 1c 01 00 00    	mov    0x11c(%edi),%eax
  10587d:	39 06                	cmp    %eax,(%esi)
}
  10587f:	5b                   	pop    %ebx
    return lk->lock_holder == kstack->cpu_idx;
  105880:	0f 94 c0             	sete   %al
}
  105883:	5e                   	pop    %esi
  105884:	5f                   	pop    %edi
  105885:	c3                   	ret
  105886:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10588d:	00 
  10588e:	66 90                	xchg   %ax,%ax

00105890 <spinlock_acquire>:

    return spinlock_try_acquire_A(lk);
}
#else   /* DEBUG_LOCKHOLDING */
void gcc_inline spinlock_acquire(spinlock_t *lk)
{
  105890:	57                   	push   %edi
  105891:	56                   	push   %esi
  105892:	53                   	push   %ebx
  105893:	8b 7c 24 10          	mov    0x10(%esp),%edi
    while (xchg(&lk->lock, 1) != 0)
  105897:	e8 06 ab ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10589c:	81 c3 58 b7 00 00    	add    $0xb758,%ebx
  1058a2:	8d 77 04             	lea    0x4(%edi),%esi
  1058a5:	eb 0e                	jmp    1058b5 <spinlock_acquire+0x25>
  1058a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1058ae:	00 
  1058af:	90                   	nop
        pause();
  1058b0:	e8 fb f4 ff ff       	call   104db0 <pause>
    while (xchg(&lk->lock, 1) != 0)
  1058b5:	83 ec 08             	sub    $0x8,%esp
  1058b8:	6a 01                	push   $0x1
  1058ba:	56                   	push   %esi
  1058bb:	e8 00 f5 ff ff       	call   104dc0 <xchg>
  1058c0:	83 c4 10             	add    $0x10,%esp
  1058c3:	85 c0                	test   %eax,%eax
  1058c5:	75 e9                	jne    1058b0 <spinlock_acquire+0x20>
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1058c7:	e8 64 f4 ff ff       	call   104d30 <read_esp>
  1058cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1058d1:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  1058d8:	54 76 98 
    struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  1058db:	89 c6                	mov    %eax,%esi
    KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1058dd:	74 1f                	je     1058fe <spinlock_acquire+0x6e>
  1058df:	8d 83 df 84 ff ff    	lea    -0x7b21(%ebx),%eax
  1058e5:	50                   	push   %eax
  1058e6:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1058ec:	50                   	push   %eax
  1058ed:	8d 83 fd 84 ff ff    	lea    -0x7b03(%ebx),%eax
  1058f3:	6a 2f                	push   $0x2f
  1058f5:	50                   	push   %eax
  1058f6:	e8 65 e8 ff ff       	call   104160 <debug_panic>
  1058fb:	83 c4 10             	add    $0x10,%esp
    lk->lock_holder = kstack->cpu_idx;
  1058fe:	8b 86 1c 01 00 00    	mov    0x11c(%esi),%eax
  105904:	89 07                	mov    %eax,(%edi)
    spinlock_acquire_A(lk);
}
  105906:	5b                   	pop    %ebx
  105907:	5e                   	pop    %esi
  105908:	5f                   	pop    %edi
  105909:	c3                   	ret
  10590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105910 <spinlock_release>:

void gcc_inline spinlock_release(spinlock_t *lk)
{
  105910:	53                   	push   %ebx
  105911:	e8 8c aa ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105916:	81 c3 de b6 00 00    	add    $0xb6de,%ebx
  10591c:	83 ec 10             	sub    $0x10,%esp
  10591f:	8b 44 24 18          	mov    0x18(%esp),%eax
    lk->lock_holder = NUM_CPUS + 1;
  105923:	c7 00 09 00 00 00    	movl   $0x9,(%eax)
    xchg(&lk->lock, 0);
  105929:	83 c0 04             	add    $0x4,%eax
  10592c:	6a 00                	push   $0x0
  10592e:	50                   	push   %eax
  10592f:	e8 8c f4 ff ff       	call   104dc0 <xchg>
    spinlock_release_A(lk);
}
  105934:	83 c4 18             	add    $0x18,%esp
  105937:	5b                   	pop    %ebx
  105938:	c3                   	ret
  105939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105940 <spinlock_try_acquire>:

int gcc_inline spinlock_try_acquire(spinlock_t *lk)
{
  105940:	55                   	push   %ebp
  105941:	57                   	push   %edi
  105942:	56                   	push   %esi
  105943:	53                   	push   %ebx
  105944:	e8 59 aa ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105949:	81 c3 ab b6 00 00    	add    $0xb6ab,%ebx
  10594f:	83 ec 14             	sub    $0x14,%esp
  105952:	8b 7c 24 28          	mov    0x28(%esp),%edi
    uint32_t old_val = xchg(&lk->lock, 1);
  105956:	6a 01                	push   $0x1
  105958:	8d 47 04             	lea    0x4(%edi),%eax
  10595b:	50                   	push   %eax
  10595c:	e8 5f f4 ff ff       	call   104dc0 <xchg>
    if (old_val == 0) {
  105961:	83 c4 10             	add    $0x10,%esp
    uint32_t old_val = xchg(&lk->lock, 1);
  105964:	89 c6                	mov    %eax,%esi
    if (old_val == 0) {
  105966:	85 c0                	test   %eax,%eax
  105968:	74 0e                	je     105978 <spinlock_try_acquire+0x38>
    return spinlock_try_acquire_A(lk);
}
  10596a:	83 c4 0c             	add    $0xc,%esp
  10596d:	89 f0                	mov    %esi,%eax
  10596f:	5b                   	pop    %ebx
  105970:	5e                   	pop    %esi
  105971:	5f                   	pop    %edi
  105972:	5d                   	pop    %ebp
  105973:	c3                   	ret
  105974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105978:	e8 b3 f3 ff ff       	call   104d30 <read_esp>
  10597d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  105982:	81 b8 20 01 00 00 32 	cmpl   $0x98765432,0x120(%eax)
  105989:	54 76 98 
        struct kstack *kstack = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  10598c:	89 c5                	mov    %eax,%ebp
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  10598e:	75 18                	jne    1059a8 <spinlock_try_acquire+0x68>
        lk->lock_holder = kstack->cpu_idx;
  105990:	8b 85 1c 01 00 00    	mov    0x11c(%ebp),%eax
  105996:	89 07                	mov    %eax,(%edi)
}
  105998:	83 c4 0c             	add    $0xc,%esp
  10599b:	89 f0                	mov    %esi,%eax
  10599d:	5b                   	pop    %ebx
  10599e:	5e                   	pop    %esi
  10599f:	5f                   	pop    %edi
  1059a0:	5d                   	pop    %ebp
  1059a1:	c3                   	ret
  1059a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1059a8:	8d 83 df 84 ff ff    	lea    -0x7b21(%ebx),%eax
  1059ae:	50                   	push   %eax
  1059af:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1059b5:	50                   	push   %eax
  1059b6:	8d 83 fd 84 ff ff    	lea    -0x7b03(%ebx),%eax
  1059bc:	6a 39                	push   $0x39
  1059be:	50                   	push   %eax
  1059bf:	e8 9c e7 ff ff       	call   104160 <debug_panic>
        lk->lock_holder = kstack->cpu_idx;
  1059c4:	8b 85 1c 01 00 00    	mov    0x11c(%ebp),%eax
        KERN_ASSERT(kstack->magic == KSTACK_MAGIC);
  1059ca:	83 c4 10             	add    $0x10,%esp
        lk->lock_holder = kstack->cpu_idx;
  1059cd:	89 07                	mov    %eax,(%edi)
  1059cf:	eb c7                	jmp    105998 <spinlock_try_acquire+0x58>
  1059d1:	66 90                	xchg   %ax,%ax
  1059d3:	66 90                	xchg   %ax,%ax
  1059d5:	66 90                	xchg   %ax,%ax
  1059d7:	66 90                	xchg   %ax,%ax
  1059d9:	66 90                	xchg   %ax,%ax
  1059db:	66 90                	xchg   %ax,%ax
  1059dd:	66 90                	xchg   %ax,%ax
  1059df:	90                   	nop

001059e0 <reentrantlock_init>:
#include "reentrant_lock.h"

#define UNLOCKED    0xFFFFFFFF

void reentrantlock_init(reentrantlock *lk)
{
  1059e0:	8b 44 24 04          	mov    0x4(%esp),%eax
    lk->lock = UNLOCKED;
  1059e4:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    lk->count = 0u;
  1059ea:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
}
  1059f1:	c3                   	ret
  1059f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1059f9:	00 
  1059fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00105a00 <reentrantlock_holding>:

bool reentrantlock_holding(reentrantlock *lk)
{
    if (lk->count > 0u)
  105a00:	8b 44 24 04          	mov    0x4(%esp),%eax
  105a04:	8b 40 04             	mov    0x4(%eax),%eax
  105a07:	85 c0                	test   %eax,%eax
  105a09:	0f 95 c0             	setne  %al
        return TRUE;
    else
        return FALSE;
}
  105a0c:	c3                   	ret
  105a0d:	8d 76 00             	lea    0x0(%esi),%esi

00105a10 <reentrantlock_acquire>:

void reentrantlock_acquire(reentrantlock *lk)
{
  105a10:	57                   	push   %edi
  105a11:	56                   	push   %esi
  105a12:	53                   	push   %ebx
  105a13:	8b 7c 24 10          	mov    0x10(%esp),%edi
  105a17:	e8 86 a9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105a1c:	81 c3 d8 b5 00 00    	add    $0xb5d8,%ebx
    uint32_t cpuid = get_kstack_cpu_idx();
  105a22:	e8 a9 fd ff ff       	call   1057d0 <get_kstack_cpu_idx>
  105a27:	89 c6                	mov    %eax,%esi
  105a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uint32_t lv;

    do {
        lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  105a30:	83 ec 04             	sub    $0x4,%esp
  105a33:	56                   	push   %esi
  105a34:	6a ff                	push   $0xffffffff
  105a36:	57                   	push   %edi
  105a37:	e8 94 f3 ff ff       	call   104dd0 <cmpxchg>
    } while (lv != cpuid && lv != UNLOCKED);
  105a3c:	83 c4 10             	add    $0x10,%esp
  105a3f:	39 c6                	cmp    %eax,%esi
  105a41:	74 05                	je     105a48 <reentrantlock_acquire+0x38>
  105a43:	83 f8 ff             	cmp    $0xffffffff,%eax
  105a46:	75 e8                	jne    105a30 <reentrantlock_acquire+0x20>
    lk->count++;
  105a48:	8b 47 04             	mov    0x4(%edi),%eax
  105a4b:	83 c0 01             	add    $0x1,%eax
  105a4e:	89 47 04             	mov    %eax,0x4(%edi)
}
  105a51:	5b                   	pop    %ebx
  105a52:	5e                   	pop    %esi
  105a53:	5f                   	pop    %edi
  105a54:	c3                   	ret
  105a55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105a5c:	00 
  105a5d:	8d 76 00             	lea    0x0(%esi),%esi

00105a60 <reentrantlock_try_acquire>:

int reentrantlock_try_acquire(reentrantlock *lk)
{
  105a60:	57                   	push   %edi
  105a61:	56                   	push   %esi
  105a62:	53                   	push   %ebx
  105a63:	8b 7c 24 10          	mov    0x10(%esp),%edi
  105a67:	e8 36 a9 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105a6c:	81 c3 88 b5 00 00    	add    $0xb588,%ebx
    uint32_t cpuid = get_kstack_cpu_idx();
  105a72:	e8 59 fd ff ff       	call   1057d0 <get_kstack_cpu_idx>
    uint32_t lv;

    lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  105a77:	83 ec 04             	sub    $0x4,%esp
  105a7a:	50                   	push   %eax
    uint32_t cpuid = get_kstack_cpu_idx();
  105a7b:	89 c6                	mov    %eax,%esi
    lv = cmpxchg(&lk->lock, UNLOCKED, cpuid);
  105a7d:	6a ff                	push   $0xffffffff
  105a7f:	57                   	push   %edi
  105a80:	e8 4b f3 ff ff       	call   104dd0 <cmpxchg>

    if (lv == cpuid || lv == UNLOCKED) {
  105a85:	83 c4 10             	add    $0x10,%esp
  105a88:	39 c6                	cmp    %eax,%esi
  105a8a:	74 14                	je     105aa0 <reentrantlock_try_acquire+0x40>
        lk->count++;
        return 1;
    } else
        return 0;
  105a8c:	31 d2                	xor    %edx,%edx
    if (lv == cpuid || lv == UNLOCKED) {
  105a8e:	83 f8 ff             	cmp    $0xffffffff,%eax
  105a91:	74 0d                	je     105aa0 <reentrantlock_try_acquire+0x40>
}
  105a93:	5b                   	pop    %ebx
  105a94:	89 d0                	mov    %edx,%eax
  105a96:	5e                   	pop    %esi
  105a97:	5f                   	pop    %edi
  105a98:	c3                   	ret
  105a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        lk->count++;
  105aa0:	8b 47 04             	mov    0x4(%edi),%eax
        return 1;
  105aa3:	ba 01 00 00 00       	mov    $0x1,%edx
        lk->count++;
  105aa8:	83 c0 01             	add    $0x1,%eax
  105aab:	89 47 04             	mov    %eax,0x4(%edi)
}
  105aae:	89 d0                	mov    %edx,%eax
  105ab0:	5b                   	pop    %ebx
  105ab1:	5e                   	pop    %esi
  105ab2:	5f                   	pop    %edi
  105ab3:	c3                   	ret
  105ab4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105abb:	00 
  105abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105ac0 <reentrantlock_release>:

void reentrantlock_release(reentrantlock *lk)
{
  105ac0:	53                   	push   %ebx
  105ac1:	e8 dc a8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105ac6:	81 c3 2e b5 00 00    	add    $0xb52e,%ebx
  105acc:	83 ec 08             	sub    $0x8,%esp
  105acf:	8b 44 24 10          	mov    0x10(%esp),%eax
    lk->count--;
  105ad3:	8b 50 04             	mov    0x4(%eax),%edx
  105ad6:	83 ea 01             	sub    $0x1,%edx
  105ad9:	89 50 04             	mov    %edx,0x4(%eax)
    if (lk->count == 0u) {
  105adc:	8b 50 04             	mov    0x4(%eax),%edx
  105adf:	85 d2                	test   %edx,%edx
  105ae1:	74 0d                	je     105af0 <reentrantlock_release+0x30>
        xchg(&lk->lock, UNLOCKED);
    }
}
  105ae3:	83 c4 08             	add    $0x8,%esp
  105ae6:	5b                   	pop    %ebx
  105ae7:	c3                   	ret
  105ae8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105aef:	00 
        xchg(&lk->lock, UNLOCKED);
  105af0:	83 ec 08             	sub    $0x8,%esp
  105af3:	6a ff                	push   $0xffffffff
  105af5:	50                   	push   %eax
  105af6:	e8 c5 f2 ff ff       	call   104dc0 <xchg>
  105afb:	83 c4 10             	add    $0x10,%esp
}
  105afe:	83 c4 08             	add    $0x8,%esp
  105b01:	5b                   	pop    %ebx
  105b02:	c3                   	ret
  105b03:	66 90                	xchg   %ax,%ax
  105b05:	66 90                	xchg   %ax,%ax
  105b07:	66 90                	xchg   %ax,%ax
  105b09:	66 90                	xchg   %ax,%ax
  105b0b:	66 90                	xchg   %ax,%ax
  105b0d:	66 90                	xchg   %ax,%ax
  105b0f:	90                   	nop

00105b10 <pcpu_set_zero>:
struct pcpu pcpu[NUM_CPUS];

extern int get_kstack_cpu_idx(void);

void pcpu_set_zero()
{
  105b10:	53                   	push   %ebx
  105b11:	e8 8c a8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105b16:	81 c3 de b4 00 00    	add    $0xb4de,%ebx
  105b1c:	83 ec 10             	sub    $0x10,%esp
    memzero(pcpu, sizeof(struct pcpu) * NUM_CPUS);
  105b1f:	68 80 02 00 00       	push   $0x280
  105b24:	8d 83 0c 10 07 00    	lea    0x7100c(%ebx),%eax
  105b2a:	50                   	push   %eax
  105b2b:	e8 f0 e4 ff ff       	call   104020 <memzero>
}
  105b30:	83 c4 18             	add    $0x18,%esp
  105b33:	5b                   	pop    %ebx
  105b34:	c3                   	ret
  105b35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105b3c:	00 
  105b3d:	8d 76 00             	lea    0x0(%esi),%esi

00105b40 <pcpu_fields_init>:

void pcpu_fields_init(int cpu_idx)
{
    pcpu[cpu_idx].inited = TRUE;
  105b40:	e8 1e d3 ff ff       	call   102e63 <__x86.get_pc_thunk.cx>
  105b45:	81 c1 af b4 00 00    	add    $0xb4af,%ecx
{
  105b4b:	8b 54 24 04          	mov    0x4(%esp),%edx
    pcpu[cpu_idx].inited = TRUE;
  105b4f:	8d 04 92             	lea    (%edx,%edx,4),%eax
  105b52:	c1 e0 04             	shl    $0x4,%eax
  105b55:	c6 84 01 0c 10 07 00 	movb   $0x1,0x7100c(%ecx,%eax,1)
  105b5c:	01 
    pcpu[cpu_idx].cpu_idx = cpu_idx;
  105b5d:	89 94 01 58 10 07 00 	mov    %edx,0x71058(%ecx,%eax,1)
}
  105b64:	c3                   	ret
  105b65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105b6c:	00 
  105b6d:	8d 76 00             	lea    0x0(%esi),%esi

00105b70 <pcpu_cur>:

struct pcpu *pcpu_cur(void)
{
  105b70:	53                   	push   %ebx
  105b71:	e8 2c a8 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105b76:	81 c3 7e b4 00 00    	add    $0xb47e,%ebx
  105b7c:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_kstack_cpu_idx();
  105b7f:	e8 4c fc ff ff       	call   1057d0 <get_kstack_cpu_idx>
    return &pcpu[cpu_idx];
}
  105b84:	83 c4 08             	add    $0x8,%esp
    return &pcpu[cpu_idx];
  105b87:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105b8a:	c1 e0 04             	shl    $0x4,%eax
  105b8d:	8d 84 03 0c 10 07 00 	lea    0x7100c(%ebx,%eax,1),%eax
}
  105b94:	5b                   	pop    %ebx
  105b95:	c3                   	ret
  105b96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105b9d:	00 
  105b9e:	66 90                	xchg   %ax,%ax

00105ba0 <get_pcpu_idx>:

int get_pcpu_idx(void)
{
  105ba0:	53                   	push   %ebx
  105ba1:	e8 fc a7 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105ba6:	81 c3 4e b4 00 00    	add    $0xb44e,%ebx
  105bac:	83 ec 08             	sub    $0x8,%esp
    int cpu_idx = get_kstack_cpu_idx();
  105baf:	e8 1c fc ff ff       	call   1057d0 <get_kstack_cpu_idx>
    return pcpu_cur()->cpu_idx;
  105bb4:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105bb7:	c1 e0 04             	shl    $0x4,%eax
  105bba:	8b 84 03 58 10 07 00 	mov    0x71058(%ebx,%eax,1),%eax
}
  105bc1:	83 c4 08             	add    $0x8,%esp
  105bc4:	5b                   	pop    %ebx
  105bc5:	c3                   	ret
  105bc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105bcd:	00 
  105bce:	66 90                	xchg   %ax,%ax

00105bd0 <set_pcpu_idx>:

void set_pcpu_idx(int index, int cpu_idx)
{
    pcpu[index].cpu_idx = cpu_idx;
  105bd0:	e8 c9 a7 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105bd5:	81 c2 1f b4 00 00    	add    $0xb41f,%edx
{
  105bdb:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[index].cpu_idx = cpu_idx;
  105bdf:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  105be3:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105be6:	c1 e0 04             	shl    $0x4,%eax
  105be9:	89 8c 02 58 10 07 00 	mov    %ecx,0x71058(%edx,%eax,1)
}
  105bf0:	c3                   	ret
  105bf1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105bf8:	00 
  105bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105c00 <get_pcpu_kstack_pointer>:

uintptr_t *get_pcpu_kstack_pointer(int cpu_idx)
{
    return pcpu[cpu_idx].kstack;
  105c00:	e8 99 a7 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105c05:	81 c2 ef b3 00 00    	add    $0xb3ef,%edx
{
  105c0b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].kstack;
  105c0f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c12:	c1 e0 04             	shl    $0x4,%eax
  105c15:	8b 84 02 10 10 07 00 	mov    0x71010(%edx,%eax,1),%eax
}
  105c1c:	c3                   	ret
  105c1d:	8d 76 00             	lea    0x0(%esi),%esi

00105c20 <set_pcpu_kstack_pointer>:

void set_pcpu_kstack_pointer(int cpu_idx, uintptr_t *ks)
{
    pcpu[cpu_idx].kstack = ks;
  105c20:	e8 79 a7 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105c25:	81 c2 cf b3 00 00    	add    $0xb3cf,%edx
{
  105c2b:	8b 44 24 04          	mov    0x4(%esp),%eax
    pcpu[cpu_idx].kstack = ks;
  105c2f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  105c33:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c36:	c1 e0 04             	shl    $0x4,%eax
  105c39:	89 8c 02 10 10 07 00 	mov    %ecx,0x71010(%edx,%eax,1)
}
  105c40:	c3                   	ret
  105c41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105c48:	00 
  105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105c50 <get_pcpu_boot_info>:

volatile bool get_pcpu_boot_info(int cpu_idx)
{
    return pcpu[cpu_idx].booted;
  105c50:	e8 49 a7 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105c55:	81 c2 9f b3 00 00    	add    $0xb39f,%edx
{
  105c5b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].booted;
  105c5f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105c62:	c1 e0 04             	shl    $0x4,%eax
  105c65:	8d 84 02 0c 10 07 00 	lea    0x7100c(%edx,%eax,1),%eax
  105c6c:	0f b6 40 01          	movzbl 0x1(%eax),%eax
}
  105c70:	c3                   	ret
  105c71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105c78:	00 
  105c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105c80 <set_pcpu_boot_info>:

void set_pcpu_boot_info(int cpu_idx, volatile bool boot_info)
{
    pcpu[cpu_idx].booted = boot_info;
  105c80:	e8 de d1 ff ff       	call   102e63 <__x86.get_pc_thunk.cx>
  105c85:	81 c1 6f b3 00 00    	add    $0xb36f,%ecx
{
  105c8b:	83 ec 04             	sub    $0x4,%esp
  105c8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  105c92:	8b 54 24 0c          	mov    0xc(%esp),%edx
    pcpu[cpu_idx].booted = boot_info;
  105c96:	8d 04 80             	lea    (%eax,%eax,4),%eax
{
  105c99:	88 14 24             	mov    %dl,(%esp)
    pcpu[cpu_idx].booted = boot_info;
  105c9c:	0f b6 14 24          	movzbl (%esp),%edx
  105ca0:	c1 e0 04             	shl    $0x4,%eax
  105ca3:	8d 84 01 0c 10 07 00 	lea    0x7100c(%ecx,%eax,1),%eax
  105caa:	88 50 01             	mov    %dl,0x1(%eax)
}
  105cad:	83 c4 04             	add    $0x4,%esp
  105cb0:	c3                   	ret
  105cb1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105cb8:	00 
  105cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00105cc0 <get_pcpu_cpu_vendor>:

cpu_vendor get_pcpu_cpu_vendor(int cpu_idx)
{
    return pcpu[cpu_idx].arch_info.cpu_vendor;
  105cc0:	e8 d9 a6 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105cc5:	81 c2 2f b3 00 00    	add    $0xb32f,%edx
{
  105ccb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].arch_info.cpu_vendor;
  105ccf:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105cd2:	c1 e0 04             	shl    $0x4,%eax
  105cd5:	8b 84 02 34 10 07 00 	mov    0x71034(%edx,%eax,1),%eax
}
  105cdc:	c3                   	ret
  105cdd:	8d 76 00             	lea    0x0(%esi),%esi

00105ce0 <get_pcpu_arch_info_pointer>:

uintptr_t *get_pcpu_arch_info_pointer(int cpu_idx)
{
    return (uintptr_t *) &pcpu[cpu_idx].arch_info;
  105ce0:	e8 b9 a6 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105ce5:	81 c2 0f b3 00 00    	add    $0xb30f,%edx
{
  105ceb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return (uintptr_t *) &pcpu[cpu_idx].arch_info;
  105cef:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105cf2:	c1 e0 04             	shl    $0x4,%eax
  105cf5:	8d 84 02 14 10 07 00 	lea    0x71014(%edx,%eax,1),%eax
}
  105cfc:	c3                   	ret
  105cfd:	8d 76 00             	lea    0x0(%esi),%esi

00105d00 <get_pcpu_inited_info>:

bool get_pcpu_inited_info(int cpu_idx)
{
    return pcpu[cpu_idx].inited;
  105d00:	e8 99 a6 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  105d05:	81 c2 ef b2 00 00    	add    $0xb2ef,%edx
{
  105d0b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return pcpu[cpu_idx].inited;
  105d0f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  105d12:	c1 e0 04             	shl    $0x4,%eax
  105d15:	0f b6 84 02 0c 10 07 	movzbl 0x7100c(%edx,%eax,1),%eax
  105d1c:	00 
}
  105d1d:	c3                   	ret
  105d1e:	66 90                	xchg   %ax,%ax

00105d20 <pcpu_init>:
#include "import.h"

static bool pcpu_inited = FALSE;

void pcpu_init(void)
{
  105d20:	55                   	push   %ebp
  105d21:	57                   	push   %edi
  105d22:	56                   	push   %esi
  105d23:	53                   	push   %ebx
  105d24:	e8 79 a6 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105d29:	81 c3 cb b2 00 00    	add    $0xb2cb,%ebx
  105d2f:	83 ec 0c             	sub    $0xc,%esp
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105d32:	e8 f9 ef ff ff       	call   104d30 <read_esp>
  105d37:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    int cpu_idx = ks->cpu_idx;
  105d3c:	8b b8 1c 01 00 00    	mov    0x11c(%eax),%edi
    struct kstack *ks = (struct kstack *) ROUNDDOWN(read_esp(), KSTACK_SIZE);
  105d42:	89 c5                	mov    %eax,%ebp
    int i;

    if (cpu_idx == 0) {
  105d44:	85 ff                	test   %edi,%edi
  105d46:	75 33                	jne    105d7b <pcpu_init+0x5b>
        if (pcpu_inited == TRUE)
  105d48:	80 bb 8c 12 07 00 01 	cmpb   $0x1,0x7128c(%ebx)
  105d4f:	74 4f                	je     105da0 <pcpu_init+0x80>
            return;

        pcpu_set_zero();
  105d51:	e8 ba fd ff ff       	call   105b10 <pcpu_set_zero>

        /* Probe SMP. */
        pcpu_mp_init();

        for (i = 0; i < NUM_CPUS; i++) {
  105d56:	31 f6                	xor    %esi,%esi
        pcpu_mp_init();
  105d58:	e8 a3 d1 ff ff       	call   102f00 <pcpu_mp_init>
        for (i = 0; i < NUM_CPUS; i++) {
  105d5d:	8d 76 00             	lea    0x0(%esi),%esi
            pcpu_fields_init(i);
  105d60:	83 ec 0c             	sub    $0xc,%esp
  105d63:	56                   	push   %esi
        for (i = 0; i < NUM_CPUS; i++) {
  105d64:	83 c6 01             	add    $0x1,%esi
            pcpu_fields_init(i);
  105d67:	e8 d4 fd ff ff       	call   105b40 <pcpu_fields_init>
        for (i = 0; i < NUM_CPUS; i++) {
  105d6c:	83 c4 10             	add    $0x10,%esp
  105d6f:	83 fe 08             	cmp    $0x8,%esi
  105d72:	75 ec                	jne    105d60 <pcpu_init+0x40>
        }

        pcpu_inited = TRUE;
  105d74:	c6 83 8c 12 07 00 01 	movb   $0x1,0x7128c(%ebx)
    }

    set_pcpu_idx(cpu_idx, cpu_idx);
  105d7b:	83 ec 08             	sub    $0x8,%esp
  105d7e:	57                   	push   %edi
  105d7f:	57                   	push   %edi
  105d80:	e8 4b fe ff ff       	call   105bd0 <set_pcpu_idx>
    set_pcpu_kstack_pointer(cpu_idx, (uintptr_t *) ks);
  105d85:	58                   	pop    %eax
  105d86:	5a                   	pop    %edx
  105d87:	55                   	push   %ebp
  105d88:	57                   	push   %edi
  105d89:	e8 92 fe ff ff       	call   105c20 <set_pcpu_kstack_pointer>
    set_pcpu_boot_info(cpu_idx, TRUE);
  105d8e:	59                   	pop    %ecx
  105d8f:	5e                   	pop    %esi
  105d90:	6a 01                	push   $0x1
  105d92:	57                   	push   %edi
  105d93:	e8 e8 fe ff ff       	call   105c80 <set_pcpu_boot_info>
    pcpu_init_cpu();
  105d98:	e8 73 d9 ff ff       	call   103710 <pcpu_init_cpu>
  105d9d:	83 c4 10             	add    $0x10,%esp
}
  105da0:	83 c4 0c             	add    $0xc,%esp
  105da3:	5b                   	pop    %ebx
  105da4:	5e                   	pop    %esi
  105da5:	5f                   	pop    %edi
  105da6:	5d                   	pop    %ebp
  105da7:	c3                   	ret
  105da8:	66 90                	xchg   %ax,%ax
  105daa:	66 90                	xchg   %ax,%ax
  105dac:	66 90                	xchg   %ax,%ax
  105dae:	66 90                	xchg   %ax,%ax

00105db0 <kern_main_ap>:
    dprintf("\nTest complete. Please Use Ctrl-a x to exit qemu.");
#endif
}

static void kern_main_ap(void)
{
  105db0:	55                   	push   %ebp
  105db1:	57                   	push   %edi
  105db2:	56                   	push   %esi
  105db3:	53                   	push   %ebx
  105db4:	e8 e9 a5 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105db9:	81 c3 3b b2 00 00    	add    $0xb23b,%ebx
  105dbf:	83 ec 0c             	sub    $0xc,%esp
    unsigned int pid, pid2;
    int cpu_idx = get_pcpu_idx();
  105dc2:	e8 d9 fd ff ff       	call   105ba0 <get_pcpu_idx>

    set_pcpu_boot_info(cpu_idx, TRUE);
  105dc7:	83 ec 08             	sub    $0x8,%esp
  105dca:	6a 01                	push   $0x1
    int cpu_idx = get_pcpu_idx();
  105dcc:	89 c6                	mov    %eax,%esi
    set_pcpu_boot_info(cpu_idx, TRUE);
  105dce:	50                   	push   %eax
  105dcf:	e8 ac fe ff ff       	call   105c80 <set_pcpu_boot_info>

    while (all_ready == FALSE);
  105dd4:	83 c4 10             	add    $0x10,%esp
  105dd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105dde:	00 
  105ddf:	90                   	nop
  105de0:	8b 83 90 12 07 00    	mov    0x71290(%ebx),%eax
  105de6:	85 c0                	test   %eax,%eax
  105de8:	74 f6                	je     105de0 <kern_main_ap+0x30>

    KERN_INFO("[AP%d KERN] kernel_main_ap\n", cpu_idx);
  105dea:	83 ec 08             	sub    $0x8,%esp
  105ded:	8d 83 11 85 ff ff    	lea    -0x7aef(%ebx),%eax
  105df3:	56                   	push   %esi
  105df4:	50                   	push   %eax
  105df5:	e8 c6 e2 ff ff       	call   1040c0 <debug_info>

    cpu_booted++;
  105dfa:	8b 83 94 12 07 00    	mov    0x71294(%ebx),%eax

#ifndef TEST
    if (cpu_idx == 1) {
  105e00:	83 c4 10             	add    $0x10,%esp
    cpu_booted++;
  105e03:	83 c0 01             	add    $0x1,%eax
  105e06:	89 83 94 12 07 00    	mov    %eax,0x71294(%ebx)
    if (cpu_idx == 1) {
  105e0c:	83 fe 01             	cmp    $0x1,%esi
  105e0f:	0f 84 c3 00 00 00    	je     105ed8 <kern_main_ap+0x128>
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
        pid2 = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
        proc_create(_binary___obj_user_idle_idle_start, 1000);
    }
    else if (cpu_idx == 2) {
  105e15:	83 fe 02             	cmp    $0x2,%esi
  105e18:	74 0e                	je     105e28 <kern_main_ap+0x78>
    set_curid(pid);
    kctx_switch(0, pid);

    KERN_PANIC("kern_main_ap() should never reach here.\n");
#endif
}
  105e1a:	83 c4 0c             	add    $0xc,%esp
  105e1d:	5b                   	pop    %ebx
  105e1e:	5e                   	pop    %esi
  105e1f:	5f                   	pop    %edi
  105e20:	5d                   	pop    %ebp
  105e21:	c3                   	ret
  105e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pid = proc_create(_binary___obj_user_pingpong_pong_start, 1000);
  105e28:	c7 c5 3e 46 12 00    	mov    $0x12463e,%ebp
  105e2e:	83 ec 08             	sub    $0x8,%esp
  105e31:	68 e8 03 00 00       	push   $0x3e8
  105e36:	55                   	push   %ebp
  105e37:	e8 04 18 00 00       	call   107640 <proc_create>
        KERN_INFO("CPU%d: process pong1 %d is created.\n", cpu_idx, pid);
  105e3c:	83 c4 0c             	add    $0xc,%esp
  105e3f:	50                   	push   %eax
        pid = proc_create(_binary___obj_user_pingpong_pong_start, 1000);
  105e40:	89 c7                	mov    %eax,%edi
        KERN_INFO("CPU%d: process pong1 %d is created.\n", cpu_idx, pid);
  105e42:	8d 83 80 8f ff ff    	lea    -0x7080(%ebx),%eax
  105e48:	6a 02                	push   $0x2
  105e4a:	50                   	push   %eax
  105e4b:	e8 70 e2 ff ff       	call   1040c0 <debug_info>
        pid2 = proc_create(_binary___obj_user_pingpong_pong_start, 1000);
  105e50:	58                   	pop    %eax
  105e51:	5a                   	pop    %edx
  105e52:	68 e8 03 00 00       	push   $0x3e8
  105e57:	55                   	push   %ebp
  105e58:	e8 e3 17 00 00       	call   107640 <proc_create>
        KERN_INFO("CPU%d: process pong2 %d is created.\n", cpu_idx, pid2);
  105e5d:	83 c4 0c             	add    $0xc,%esp
  105e60:	50                   	push   %eax
  105e61:	8d 83 a8 8f ff ff    	lea    -0x7058(%ebx),%eax
  105e67:	6a 02                	push   $0x2
  105e69:	50                   	push   %eax
    tqueue_remove(NUM_IDS + cpu_idx, pid);
  105e6a:	83 c6 40             	add    $0x40,%esi
        KERN_INFO("CPU%d: process pong2 %d is created.\n", cpu_idx, pid2);
  105e6d:	e8 4e e2 ff ff       	call   1040c0 <debug_info>
        proc_create(_binary___obj_user_idle_idle_start, 1000);
  105e72:	58                   	pop    %eax
  105e73:	5a                   	pop    %edx
  105e74:	68 e8 03 00 00       	push   $0x3e8
  105e79:	ff b3 ec ff ff ff    	push   -0x14(%ebx)
  105e7f:	e8 bc 17 00 00       	call   107640 <proc_create>
  105e84:	83 c4 10             	add    $0x10,%esp
    tqueue_remove(NUM_IDS + cpu_idx, pid);
  105e87:	83 ec 08             	sub    $0x8,%esp
  105e8a:	57                   	push   %edi
  105e8b:	56                   	push   %esi
  105e8c:	e8 9f 14 00 00       	call   107330 <tqueue_remove>
    tcb_set_state(pid, TSTATE_RUN);
  105e91:	59                   	pop    %ecx
  105e92:	5e                   	pop    %esi
  105e93:	6a 01                	push   $0x1
  105e95:	57                   	push   %edi
  105e96:	e8 25 11 00 00       	call   106fc0 <tcb_set_state>
    set_curid(pid);
  105e9b:	89 3c 24             	mov    %edi,(%esp)
  105e9e:	e8 9d 15 00 00       	call   107440 <set_curid>
    kctx_switch(0, pid);
  105ea3:	5d                   	pop    %ebp
  105ea4:	58                   	pop    %eax
  105ea5:	57                   	push   %edi
  105ea6:	6a 00                	push   $0x0
  105ea8:	e8 f3 0f 00 00       	call   106ea0 <kctx_switch>
    KERN_PANIC("kern_main_ap() should never reach here.\n");
  105ead:	83 c4 0c             	add    $0xc,%esp
  105eb0:	8d 83 d0 8f ff ff    	lea    -0x7030(%ebx),%eax
  105eb6:	50                   	push   %eax
  105eb7:	8d 83 2d 85 ff ff    	lea    -0x7ad3(%ebx),%eax
  105ebd:	68 81 00 00 00       	push   $0x81
  105ec2:	50                   	push   %eax
  105ec3:	e8 98 e2 ff ff       	call   104160 <debug_panic>
  105ec8:	83 c4 10             	add    $0x10,%esp
}
  105ecb:	83 c4 0c             	add    $0xc,%esp
  105ece:	5b                   	pop    %ebx
  105ecf:	5e                   	pop    %esi
  105ed0:	5f                   	pop    %edi
  105ed1:	5d                   	pop    %ebp
  105ed2:	c3                   	ret
  105ed3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        pid = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
  105ed8:	c7 c5 1a ac 11 00    	mov    $0x11ac1a,%ebp
  105ede:	83 ec 08             	sub    $0x8,%esp
  105ee1:	68 e8 03 00 00       	push   $0x3e8
  105ee6:	55                   	push   %ebp
  105ee7:	e8 54 17 00 00       	call   107640 <proc_create>
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
  105eec:	83 c4 0c             	add    $0xc,%esp
  105eef:	50                   	push   %eax
        pid = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
  105ef0:	89 c7                	mov    %eax,%edi
        KERN_INFO("CPU%d: process ping1 %d is created.\n", cpu_idx, pid);
  105ef2:	8d 83 30 8f ff ff    	lea    -0x70d0(%ebx),%eax
  105ef8:	6a 01                	push   $0x1
  105efa:	50                   	push   %eax
  105efb:	e8 c0 e1 ff ff       	call   1040c0 <debug_info>
        pid2 = proc_create(_binary___obj_user_pingpong_ping_start, 1000);
  105f00:	59                   	pop    %ecx
  105f01:	58                   	pop    %eax
  105f02:	68 e8 03 00 00       	push   $0x3e8
  105f07:	55                   	push   %ebp
  105f08:	e8 33 17 00 00       	call   107640 <proc_create>
        KERN_INFO("CPU%d: process ping2 %d is created.\n", cpu_idx, pid2);
  105f0d:	83 c4 0c             	add    $0xc,%esp
  105f10:	50                   	push   %eax
  105f11:	8d 83 58 8f ff ff    	lea    -0x70a8(%ebx),%eax
  105f17:	6a 01                	push   $0x1
  105f19:	e9 4b ff ff ff       	jmp    105e69 <kern_main_ap+0xb9>
  105f1e:	66 90                	xchg   %ax,%ax

00105f20 <kern_init>:

void kern_init(uintptr_t mbi_addr)
{
  105f20:	55                   	push   %ebp
  105f21:	57                   	push   %edi
  105f22:	56                   	push   %esi
    for (i = 1; i < pcpu_ncpu(); i++) {
  105f23:	be 01 00 00 00       	mov    $0x1,%esi
{
  105f28:	53                   	push   %ebx
  105f29:	e8 74 a4 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  105f2e:	81 c3 c6 b0 00 00    	add    $0xb0c6,%ebx
  105f34:	83 ec 28             	sub    $0x28,%esp
    thread_init(mbi_addr);
  105f37:	ff 74 24 3c          	push   0x3c(%esp)
  105f3b:	e8 30 15 00 00       	call   107470 <thread_init>
    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  105f40:	8d 83 fc 8f ff ff    	lea    -0x7004(%ebx),%eax
        KERN_INFO("[BSP KERN] Boot CPU %d .... \n", i);
  105f46:	8d ab 5b 85 ff ff    	lea    -0x7aa5(%ebx),%ebp
    KERN_INFO("[BSP KERN] Kernel initialized.\n");
  105f4c:	89 04 24             	mov    %eax,(%esp)
  105f4f:	e8 6c e1 ff ff       	call   1040c0 <debug_info>
    KERN_INFO("[BSP KERN] In kernel main.\n\n");
  105f54:	8d 83 3e 85 ff ff    	lea    -0x7ac2(%ebx),%eax
  105f5a:	89 04 24             	mov    %eax,(%esp)
  105f5d:	e8 5e e1 ff ff       	call   1040c0 <debug_info>
    KERN_INFO("[BSP KERN] Number of CPUs in this system: %d. \n", pcpu_ncpu());
  105f62:	e8 d9 db ff ff       	call   103b40 <pcpu_ncpu>
  105f67:	5a                   	pop    %edx
  105f68:	59                   	pop    %ecx
  105f69:	50                   	push   %eax
  105f6a:	8d 83 1c 90 ff ff    	lea    -0x6fe4(%ebx),%eax
  105f70:	50                   	push   %eax
  105f71:	e8 4a e1 ff ff       	call   1040c0 <debug_info>
    int cpu_idx = get_pcpu_idx();
  105f76:	e8 25 fc ff ff       	call   105ba0 <get_pcpu_idx>
    all_ready = FALSE;
  105f7b:	c7 c0 00 a0 17 00    	mov    $0x17a000,%eax
    for (i = 1; i < pcpu_ncpu(); i++) {
  105f81:	83 c4 10             	add    $0x10,%esp
    all_ready = FALSE;
  105f84:	c7 83 90 12 07 00 00 	movl   $0x0,0x71290(%ebx)
  105f8b:	00 00 00 
    for (i = 1; i < pcpu_ncpu(); i++) {
  105f8e:	8d b8 00 10 00 00    	lea    0x1000(%eax),%edi
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &bsp_kstack[i]);
  105f94:	8d 83 bc 4d ff ff    	lea    -0xb244(%ebx),%eax
  105f9a:	89 44 24 0c          	mov    %eax,0xc(%esp)
    for (i = 1; i < pcpu_ncpu(); i++) {
  105f9e:	e8 9d db ff ff       	call   103b40 <pcpu_ncpu>
  105fa3:	39 c6                	cmp    %eax,%esi
  105fa5:	73 65                	jae    10600c <kern_init+0xec>
  105fa7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  105fae:	00 
  105faf:	90                   	nop
        KERN_INFO("[BSP KERN] Boot CPU %d .... \n", i);
  105fb0:	83 ec 08             	sub    $0x8,%esp
  105fb3:	56                   	push   %esi
  105fb4:	55                   	push   %ebp
  105fb5:	e8 06 e1 ff ff       	call   1040c0 <debug_info>
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &bsp_kstack[i]);
  105fba:	83 c4 0c             	add    $0xc,%esp
        bsp_kstack[i].cpu_idx = i;
  105fbd:	89 b7 1c 01 00 00    	mov    %esi,0x11c(%edi)
        pcpu_boot_ap(i, kern_main_ap, (uintptr_t) &bsp_kstack[i]);
  105fc3:	57                   	push   %edi
  105fc4:	ff 74 24 14          	push   0x14(%esp)
  105fc8:	56                   	push   %esi
  105fc9:	e8 62 d5 ff ff       	call   103530 <pcpu_boot_ap>
        while (get_pcpu_boot_info(i) == FALSE);
  105fce:	83 c4 10             	add    $0x10,%esp
  105fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105fd8:	83 ec 0c             	sub    $0xc,%esp
  105fdb:	56                   	push   %esi
  105fdc:	e8 6f fc ff ff       	call   105c50 <get_pcpu_boot_info>
  105fe1:	83 c4 10             	add    $0x10,%esp
  105fe4:	84 c0                	test   %al,%al
  105fe6:	74 f0                	je     105fd8 <kern_init+0xb8>
        KERN_INFO("[BSP KERN] done.\n");
  105fe8:	83 ec 0c             	sub    $0xc,%esp
  105feb:	8d 83 79 85 ff ff    	lea    -0x7a87(%ebx),%eax
    for (i = 1; i < pcpu_ncpu(); i++) {
  105ff1:	83 c6 01             	add    $0x1,%esi
  105ff4:	81 c7 00 10 00 00    	add    $0x1000,%edi
        KERN_INFO("[BSP KERN] done.\n");
  105ffa:	50                   	push   %eax
  105ffb:	e8 c0 e0 ff ff       	call   1040c0 <debug_info>
    for (i = 1; i < pcpu_ncpu(); i++) {
  106000:	83 c4 10             	add    $0x10,%esp
  106003:	e8 38 db ff ff       	call   103b40 <pcpu_ncpu>
  106008:	39 c6                	cmp    %eax,%esi
  10600a:	72 a4                	jb     105fb0 <kern_init+0x90>
    all_ready = TRUE;
  10600c:	c7 83 90 12 07 00 01 	movl   $0x1,0x71290(%ebx)
  106013:	00 00 00 
    kern_main();
}
  106016:	83 c4 1c             	add    $0x1c,%esp
  106019:	5b                   	pop    %ebx
  10601a:	5e                   	pop    %esi
  10601b:	5f                   	pop    %edi
  10601c:	5d                   	pop    %ebp
  10601d:	c3                   	ret
  10601e:	66 90                	xchg   %ax,%ax

00106020 <kern_init_ap>:

void kern_init_ap(void (*f)(void))
{
  106020:	56                   	push   %esi
  106021:	53                   	push   %ebx
  106022:	e8 7b a3 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106027:	81 c3 cd af 00 00    	add    $0xafcd,%ebx
  10602d:	83 ec 04             	sub    $0x4,%esp
  106030:	8b 74 24 10          	mov    0x10(%esp),%esi
    devinit_ap();
  106034:	e8 87 ab ff ff       	call   100bc0 <devinit_ap>
    f();
}
  106039:	83 c4 04             	add    $0x4,%esp
    f();
  10603c:	89 f0                	mov    %esi,%eax
}
  10603e:	5b                   	pop    %ebx
  10603f:	5e                   	pop    %esi
    f();
  106040:	ff e0                	jmp    *%eax
  106042:	66 90                	xchg   %ax,%ax
  106044:	02 b0 ad 1b 03 00    	add    0x31bad(%eax),%dh
  10604a:	00 00                	add    %al,(%eax)
  10604c:	fb                   	sti
  10604d:	4f                   	dec    %edi
  10604e:	52                   	push   %edx
  10604f:	e4                   	.byte 0xe4

00106050 <start>:
	.long CHECKSUM

	/* this is the entry of the kernel */
	.globl start
start:
	cli
  106050:	fa                   	cli

	/* check whether the bootloader provide multiboot information */
	cmpl	$MULTIBOOT_BOOTLOADER_MAGIC, %eax
  106051:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
	jne	spin
  106056:	75 27                	jne    10607f <spin>
	movl	%ebx, multiboot_ptr
  106058:	89 1d 80 60 10 00    	mov    %ebx,0x106080

	/* tell BIOS to warmboot next time */
	movw	$0x1234, 0x472
  10605e:	66 c7 05 72 04 00 00 	movw   $0x1234,0x472
  106065:	34 12 

	/* clear EFLAGS */
	pushl	$0x2
  106067:	6a 02                	push   $0x2
	popfl
  106069:	9d                   	popf

	/* prepare the kernel stack */
	movl	$0x0, %ebp
  10606a:	bd 00 00 00 00       	mov    $0x0,%ebp
	movl	$(bsp_kstack + 4096), %esp
  10606f:	bc 00 b0 17 00       	mov    $0x17b000,%esp

	/* jump to the C code */
	push	multiboot_ptr
  106074:	ff 35 80 60 10 00    	push   0x106080
	call	kern_init
  10607a:	e8 a1 fe ff ff       	call   105f20 <kern_init>

0010607f <spin>:

	/* should not be here */
spin:
	hlt
  10607f:	f4                   	hlt

00106080 <multiboot_ptr>:
  106080:	00 00                	add    %al,(%eax)
  106082:	00 00                	add    %al,(%eax)
  106084:	66 90                	xchg   %ax,%ax
  106086:	66 90                	xchg   %ax,%ax
  106088:	66 90                	xchg   %ax,%ax
  10608a:	66 90                	xchg   %ax,%ax
  10608c:	66 90                	xchg   %ax,%ax
  10608e:	66 90                	xchg   %ax,%ax

00106090 <mem_spinlock_init>:
 * So it may have up to 2^20 physical pages,
 * with the page size being 4KB.
 */
static struct ATStruct AT[1 << 20];

void mem_spinlock_init(void) {
  106090:	53                   	push   %ebx
  106091:	e8 0c a3 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106096:	81 c3 5e af 00 00    	add    $0xaf5e,%ebx
  10609c:	83 ec 14             	sub    $0x14,%esp
    spinlock_init(&mem_lk);
  10609f:	8d 83 b0 12 87 00    	lea    0x8712b0(%ebx),%eax
  1060a5:	50                   	push   %eax
  1060a6:	e8 55 f7 ff ff       	call   105800 <spinlock_init>
}
  1060ab:	83 c4 18             	add    $0x18,%esp
  1060ae:	5b                   	pop    %ebx
  1060af:	c3                   	ret

001060b0 <mem_lock>:

void mem_lock(void) {
  1060b0:	53                   	push   %ebx
  1060b1:	e8 ec a2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1060b6:	81 c3 3e af 00 00    	add    $0xaf3e,%ebx
  1060bc:	83 ec 14             	sub    $0x14,%esp
    spinlock_acquire(&mem_lk);
  1060bf:	8d 83 b0 12 87 00    	lea    0x8712b0(%ebx),%eax
  1060c5:	50                   	push   %eax
  1060c6:	e8 c5 f7 ff ff       	call   105890 <spinlock_acquire>
}
  1060cb:	83 c4 18             	add    $0x18,%esp
  1060ce:	5b                   	pop    %ebx
  1060cf:	c3                   	ret

001060d0 <mem_unlock>:

void mem_unlock(void) {
  1060d0:	53                   	push   %ebx
  1060d1:	e8 cc a2 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1060d6:	81 c3 1e af 00 00    	add    $0xaf1e,%ebx
  1060dc:	83 ec 14             	sub    $0x14,%esp
    spinlock_release(&mem_lk);
  1060df:	8d 83 b0 12 87 00    	lea    0x8712b0(%ebx),%eax
  1060e5:	50                   	push   %eax
  1060e6:	e8 25 f8 ff ff       	call   105910 <spinlock_release>
}
  1060eb:	83 c4 18             	add    $0x18,%esp
  1060ee:	5b                   	pop    %ebx
  1060ef:	c3                   	ret

001060f0 <get_nps>:

// The getter function for NUM_PAGES.
unsigned int get_nps(void)
{
    return NUM_PAGES;
  1060f0:	e8 a5 a2 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  1060f5:	05 ff ae 00 00       	add    $0xaeff,%eax
  1060fa:	8b 80 ac 12 87 00    	mov    0x8712ac(%eax),%eax
}
  106100:	c3                   	ret
  106101:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106108:	00 
  106109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106110 <set_nps>:

// The setter function for NUM_PAGES.
void set_nps(unsigned int nps)
{
    NUM_PAGES = nps;
  106110:	e8 85 a2 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  106115:	05 df ae 00 00       	add    $0xaedf,%eax
  10611a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10611e:	89 90 ac 12 87 00    	mov    %edx,0x8712ac(%eax)
}
  106124:	c3                   	ret
  106125:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10612c:	00 
  10612d:	8d 76 00             	lea    0x0(%esi),%esi

00106130 <at_is_norm>:
        perm = 1;
    } else {
        perm = 0;
    }

    return perm;
  106130:	e8 65 a2 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  106135:	05 bf ae 00 00       	add    $0xaebf,%eax
    if (perm > 1) {
  10613a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10613e:	83 bc d0 ac 12 07 00 	cmpl   $0x1,0x712ac(%eax,%edx,8)
  106145:	01 
  106146:	0f 97 c0             	seta   %al
  106149:	0f b6 c0             	movzbl %al,%eax
}
  10614c:	c3                   	ret
  10614d:	8d 76 00             	lea    0x0(%esi),%esi

00106150 <at_set_perm>:
 * Sets the permission of the page with given index.
 * It also marks the page as unallocated.
 */
void at_set_perm(unsigned int page_index, unsigned int perm)
{
    AT[page_index].perm = perm;
  106150:	e8 45 a2 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  106155:	05 9f ae 00 00       	add    $0xae9f,%eax
{
  10615a:	8b 54 24 04          	mov    0x4(%esp),%edx
    AT[page_index].perm = perm;
  10615e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    AT[page_index].allocated = 0;
  106162:	c7 84 d0 b0 12 07 00 	movl   $0x0,0x712b0(%eax,%edx,8)
  106169:	00 00 00 00 
    AT[page_index].perm = perm;
  10616d:	89 8c d0 ac 12 07 00 	mov    %ecx,0x712ac(%eax,%edx,8)
}
  106174:	c3                   	ret
  106175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10617c:	00 
  10617d:	8d 76 00             	lea    0x0(%esi),%esi

00106180 <at_is_allocated>:
    allocated = AT[page_index].allocated;
    if (allocated > 0) {
        allocated = 1;
    }

    return allocated;
  106180:	e8 15 a2 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  106185:	05 6f ae 00 00       	add    $0xae6f,%eax
    if (allocated > 0) {
  10618a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10618e:	8b 84 d0 b0 12 07 00 	mov    0x712b0(%eax,%edx,8),%eax
  106195:	85 c0                	test   %eax,%eax
  106197:	0f 95 c0             	setne  %al
  10619a:	0f b6 c0             	movzbl %al,%eax
}
  10619d:	c3                   	ret
  10619e:	66 90                	xchg   %ax,%ax

001061a0 <at_set_allocated>:
 * The setter function for the physical page allocation flag.
 * Set the flag of the page with given index to the given value.
 */
void at_set_allocated(unsigned int page_index, unsigned int allocated)
{
    AT[page_index].allocated = allocated;
  1061a0:	e8 f5 a1 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  1061a5:	05 4f ae 00 00       	add    $0xae4f,%eax
  1061aa:	8b 54 24 04          	mov    0x4(%esp),%edx
  1061ae:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  1061b2:	89 8c d0 b0 12 07 00 	mov    %ecx,0x712b0(%eax,%edx,8)
}
  1061b9:	c3                   	ret
  1061ba:	66 90                	xchg   %ax,%ax
  1061bc:	66 90                	xchg   %ax,%ax
  1061be:	66 90                	xchg   %ax,%ax

001061c0 <pmem_init>:
 *    based on the information available in the physical memory map table.
 *    Review import.h in the current directory for the list of available
 *    getter and setter functions.
 */
void pmem_init(unsigned int mbi_addr)
{
  1061c0:	55                   	push   %ebp
  1061c1:	57                   	push   %edi
  1061c2:	56                   	push   %esi
  1061c3:	53                   	push   %ebx
  1061c4:	e8 d9 a1 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1061c9:	81 c3 2b ae 00 00    	add    $0xae2b,%ebx
  1061cf:	83 ec 38             	sub    $0x38,%esp
    unsigned int pg_idx, pmmap_size, cur_addr, highest_addr;
    unsigned int entry_idx, flag, isnorm, start, len;

    // Calls the lower layer initialization primitive.
    // The parameter mbi_addr should not be used in the further code.
    devinit(mbi_addr);
  1061d2:	ff 74 24 4c          	push   0x4c(%esp)
  1061d6:	e8 45 a9 ff ff       	call   100b20 <devinit>
    mem_spinlock_init();
  1061db:	e8 b0 fe ff ff       	call   106090 <mem_spinlock_init>
     * Hint: Think of it as the highest address in the ranges of the memory map table,
     *       divided by the page size.
     */
    nps = 0;
    entry_idx = 0;
    pmmap_size = get_size();
  1061e0:	e8 0b af ff ff       	call   1010f0 <get_size>
    while (entry_idx < pmmap_size) {
  1061e5:	83 c4 10             	add    $0x10,%esp
  1061e8:	85 c0                	test   %eax,%eax
  1061ea:	0f 84 63 01 00 00    	je     106353 <pmem_init+0x193>
    nps = 0;
  1061f0:	89 44 24 08          	mov    %eax,0x8(%esp)
    entry_idx = 0;
  1061f4:	31 ff                	xor    %edi,%edi
    nps = 0;
  1061f6:	31 f6                	xor    %esi,%esi
  1061f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1061ff:	00 
        cur_addr = get_mms(entry_idx) + get_mml(entry_idx);
  106200:	83 ec 0c             	sub    $0xc,%esp
  106203:	57                   	push   %edi
  106204:	e8 07 af ff ff       	call   101110 <get_mms>
  106209:	89 3c 24             	mov    %edi,(%esp)
  10620c:	89 c5                	mov    %eax,%ebp
  10620e:	e8 4d af ff ff       	call   101160 <get_mml>
        if (nps < cur_addr) {
  106213:	89 fa                	mov    %edi,%edx
            nps = cur_addr;
        }
        entry_idx++;
  106215:	8d 7f 01             	lea    0x1(%edi),%edi
        cur_addr = get_mms(entry_idx) + get_mml(entry_idx);
  106218:	01 e8                	add    %ebp,%eax
        if (nps < cur_addr) {
  10621a:	39 c6                	cmp    %eax,%esi
  10621c:	0f 42 f0             	cmovb  %eax,%esi
    while (entry_idx < pmmap_size) {
  10621f:	83 c4 10             	add    $0x10,%esp
  106222:	39 7c 24 08          	cmp    %edi,0x8(%esp)
  106226:	75 d8                	jne    106200 <pmem_init+0x40>
  106228:	89 f5                	mov    %esi,%ebp
  10622a:	89 54 24 08          	mov    %edx,0x8(%esp)
    }

    nps = ROUNDDOWN(nps, PAGESIZE) / PAGESIZE;
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  10622e:	83 ec 0c             	sub    $0xc,%esp
    nps = ROUNDDOWN(nps, PAGESIZE) / PAGESIZE;
  106231:	c1 ed 0c             	shr    $0xc,%ebp
  106234:	89 6c 24 20          	mov    %ebp,0x20(%esp)
  106238:	89 ee                	mov    %ebp,%esi
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  10623a:	55                   	push   %ebp
     *    Otherwise, it should be set to 0. Note that the ranges in the memory map are
     *    not aligned by pages, so it may be possible that for some pages, only some of
     *    the addresses are in a usable range. Currently, we do not utilize partial pages,
     *    so in that case, you should consider those pages as unavailable.
     */
    pg_idx = 0;
  10623b:	31 ed                	xor    %ebp,%ebp
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  10623d:	e8 ce fe ff ff       	call   106110 <set_nps>
    while (pg_idx < nps) {
  106242:	83 c4 10             	add    $0x10,%esp
  106245:	85 f6                	test   %esi,%esi
  106247:	0f 84 ca 00 00 00    	je     106317 <pmem_init+0x157>
  10624d:	8b 54 24 08          	mov    0x8(%esp),%edx
  106251:	89 e9                	mov    %ebp,%ecx
  106253:	89 54 24 0c          	mov    %edx,0xc(%esp)
  106257:	eb 2d                	jmp    106286 <pmem_init+0xc6>
  106259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  106260:	89 4c 24 08          	mov    %ecx,0x8(%esp)
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
            at_set_perm(pg_idx, 1);
  106264:	83 ec 08             	sub    $0x8,%esp
  106267:	6a 01                	push   $0x1
  106269:	52                   	push   %edx
  10626a:	e8 e1 fe ff ff       	call   106150 <at_set_perm>
  10626f:	8b 4c 24 18          	mov    0x18(%esp),%ecx
  106273:	83 c4 10             	add    $0x10,%esp
    while (pg_idx < nps) {
  106276:	81 c5 00 10 00 00    	add    $0x1000,%ebp
  10627c:	39 4c 24 14          	cmp    %ecx,0x14(%esp)
  106280:	0f 84 91 00 00 00    	je     106317 <pmem_init+0x157>
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
  106286:	89 ca                	mov    %ecx,%edx
                at_set_perm(pg_idx, 2);
            } else {
                at_set_perm(pg_idx, 0);
            }
        }
        pg_idx++;
  106288:	83 c1 01             	add    $0x1,%ecx
        if (pg_idx < VM_USERLO_PI || VM_USERHI_PI <= pg_idx) {
  10628b:	8d 82 00 00 fc ff    	lea    -0x40000(%edx),%eax
  106291:	3d ff ff 0a 00       	cmp    $0xaffff,%eax
  106296:	77 c8                	ja     106260 <pmem_init+0xa0>
  106298:	89 c8                	mov    %ecx,%eax
  10629a:	89 54 24 18          	mov    %edx,0x18(%esp)
            entry_idx = 0;
  10629e:	31 f6                	xor    %esi,%esi
  1062a0:	c1 e0 0c             	shl    $0xc,%eax
  1062a3:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
  1062a7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1062ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                isnorm = is_usable(entry_idx);
  1062b0:	83 ec 0c             	sub    $0xc,%esp
  1062b3:	56                   	push   %esi
  1062b4:	e8 07 af ff ff       	call   1011c0 <is_usable>
                start = get_mms(entry_idx);
  1062b9:	89 34 24             	mov    %esi,(%esp)
                isnorm = is_usable(entry_idx);
  1062bc:	89 44 24 18          	mov    %eax,0x18(%esp)
                start = get_mms(entry_idx);
  1062c0:	e8 4b ae ff ff       	call   101110 <get_mms>
                len = get_mml(entry_idx);
  1062c5:	89 34 24             	mov    %esi,(%esp)
                start = get_mms(entry_idx);
  1062c8:	89 c7                	mov    %eax,%edi
                len = get_mml(entry_idx);
  1062ca:	e8 91 ae ff ff       	call   101160 <get_mml>
                if (start <= pg_idx * PAGESIZE && (pg_idx + 1) * PAGESIZE <= start + len) {
  1062cf:	83 c4 10             	add    $0x10,%esp
  1062d2:	39 fd                	cmp    %edi,%ebp
  1062d4:	72 4a                	jb     106320 <pmem_init+0x160>
  1062d6:	8d 14 07             	lea    (%edi,%eax,1),%edx
  1062d9:	8b 44 24 10          	mov    0x10(%esp),%eax
  1062dd:	39 c2                	cmp    %eax,%edx
  1062df:	72 3f                	jb     106320 <pmem_init+0x160>
            if (flag && isnorm) {
  1062e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1062e5:	8b 54 24 18          	mov    0x18(%esp),%edx
  1062e9:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  1062ed:	85 c0                	test   %eax,%eax
  1062ef:	74 47                	je     106338 <pmem_init+0x178>
  1062f1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                at_set_perm(pg_idx, 2);
  1062f5:	83 ec 08             	sub    $0x8,%esp
    while (pg_idx < nps) {
  1062f8:	81 c5 00 10 00 00    	add    $0x1000,%ebp
                at_set_perm(pg_idx, 2);
  1062fe:	6a 02                	push   $0x2
  106300:	52                   	push   %edx
  106301:	e8 4a fe ff ff       	call   106150 <at_set_perm>
  106306:	83 c4 10             	add    $0x10,%esp
  106309:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    while (pg_idx < nps) {
  10630d:	39 4c 24 14          	cmp    %ecx,0x14(%esp)
  106311:	0f 85 6f ff ff ff    	jne    106286 <pmem_init+0xc6>
    }
}
  106317:	83 c4 2c             	add    $0x2c,%esp
  10631a:	5b                   	pop    %ebx
  10631b:	5e                   	pop    %esi
  10631c:	5f                   	pop    %edi
  10631d:	5d                   	pop    %ebp
  10631e:	c3                   	ret
  10631f:	90                   	nop
                entry_idx++;
  106320:	8d 46 01             	lea    0x1(%esi),%eax
            while (entry_idx < pmmap_size && !flag) {
  106323:	39 74 24 0c          	cmp    %esi,0xc(%esp)
  106327:	74 07                	je     106330 <pmem_init+0x170>
  106329:	89 c6                	mov    %eax,%esi
  10632b:	eb 83                	jmp    1062b0 <pmem_init+0xf0>
  10632d:	8d 76 00             	lea    0x0(%esi),%esi
  106330:	8b 54 24 18          	mov    0x18(%esp),%edx
  106334:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  106338:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                at_set_perm(pg_idx, 0);
  10633c:	83 ec 08             	sub    $0x8,%esp
  10633f:	6a 00                	push   $0x0
  106341:	52                   	push   %edx
  106342:	e8 09 fe ff ff       	call   106150 <at_set_perm>
  106347:	83 c4 10             	add    $0x10,%esp
  10634a:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  10634e:	e9 23 ff ff ff       	jmp    106276 <pmem_init+0xb6>
    set_nps(nps);  // Setting the value computed above to NUM_PAGES.
  106353:	83 ec 0c             	sub    $0xc,%esp
  106356:	6a 00                	push   $0x0
  106358:	e8 b3 fd ff ff       	call   106110 <set_nps>
  10635d:	83 c4 10             	add    $0x10,%esp
}
  106360:	83 c4 2c             	add    $0x2c,%esp
  106363:	5b                   	pop    %ebx
  106364:	5e                   	pop    %esi
  106365:	5f                   	pop    %edi
  106366:	5d                   	pop    %ebp
  106367:	c3                   	ret
  106368:	66 90                	xchg   %ax,%ax
  10636a:	66 90                	xchg   %ax,%ax
  10636c:	66 90                	xchg   %ax,%ax
  10636e:	66 90                	xchg   %ax,%ax

00106370 <palloc>:
 *    return 0.
 * 2. Optimize the code using memoization so that you do not have to
 *    scan the allocation table from scratch every time.
 */
unsigned int palloc()
{
  106370:	55                   	push   %ebp
  106371:	57                   	push   %edi
  106372:	56                   	push   %esi
  106373:	53                   	push   %ebx
  106374:	e8 29 a0 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106379:	81 c3 7b ac 00 00    	add    $0xac7b,%ebx
  10637f:	83 ec 0c             	sub    $0xc,%esp
    unsigned int nps;
    unsigned int palloc_index;
    unsigned int palloc_free_index;
    bool first;

    mem_lock();
  106382:	e8 29 fd ff ff       	call   1060b0 <mem_lock>

    nps = get_nps();
  106387:	e8 64 fd ff ff       	call   1060f0 <get_nps>
    palloc_index = last_palloc_index;
  10638c:	8b ab 14 03 00 00    	mov    0x314(%ebx),%ebp
    nps = get_nps();
  106392:	89 c7                	mov    %eax,%edi
    palloc_index = last_palloc_index;
  106394:	89 c6                	mov    %eax,%esi
  106396:	eb 0c                	jmp    1063a4 <palloc+0x34>
  106398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10639f:	00 
    palloc_free_index = nps;
    first = TRUE;

    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  1063a0:	39 fe                	cmp    %edi,%esi
  1063a2:	75 64                	jne    106408 <palloc+0x98>
        first = FALSE;
        if (at_is_norm(palloc_index) && !at_is_allocated(palloc_index)) {
  1063a4:	83 ec 0c             	sub    $0xc,%esp
  1063a7:	55                   	push   %ebp
  1063a8:	e8 83 fd ff ff       	call   106130 <at_is_norm>
  1063ad:	83 c4 10             	add    $0x10,%esp
  1063b0:	85 c0                	test   %eax,%eax
  1063b2:	75 3c                	jne    1063f0 <palloc+0x80>
            palloc_free_index = palloc_index;
        }
        palloc_index++;
  1063b4:	83 c5 01             	add    $0x1,%ebp
        if (palloc_index >= VM_USERHI_PI) {
            palloc_index = VM_USERLO_PI;
  1063b7:	b8 00 00 04 00       	mov    $0x40000,%eax
  1063bc:	81 fd 00 00 0f 00    	cmp    $0xf0000,%ebp
  1063c2:	0f 43 e8             	cmovae %eax,%ebp
    while ((palloc_index != last_palloc_index || first) && palloc_free_index == nps) {
  1063c5:	3b ab 14 03 00 00    	cmp    0x314(%ebx),%ebp
  1063cb:	75 d3                	jne    1063a0 <palloc+0x30>
        }
    }

    if (palloc_free_index == nps) {
  1063cd:	39 fe                	cmp    %edi,%esi
  1063cf:	75 37                	jne    106408 <palloc+0x98>
  1063d1:	b8 00 00 04 00       	mov    $0x40000,%eax
        palloc_free_index = 0;
  1063d6:	31 f6                	xor    %esi,%esi
        last_palloc_index = VM_USERLO_PI;
  1063d8:	89 83 14 03 00 00    	mov    %eax,0x314(%ebx)
    } else {
        at_set_allocated(palloc_free_index, 1);
        last_palloc_index = palloc_free_index;
    }

    mem_unlock();
  1063de:	e8 ed fc ff ff       	call   1060d0 <mem_unlock>

    return palloc_free_index;
}
  1063e3:	83 c4 0c             	add    $0xc,%esp
  1063e6:	89 f0                	mov    %esi,%eax
  1063e8:	5b                   	pop    %ebx
  1063e9:	5e                   	pop    %esi
  1063ea:	5f                   	pop    %edi
  1063eb:	5d                   	pop    %ebp
  1063ec:	c3                   	ret
  1063ed:	8d 76 00             	lea    0x0(%esi),%esi
        if (at_is_norm(palloc_index) && !at_is_allocated(palloc_index)) {
  1063f0:	83 ec 0c             	sub    $0xc,%esp
  1063f3:	55                   	push   %ebp
  1063f4:	e8 87 fd ff ff       	call   106180 <at_is_allocated>
  1063f9:	83 c4 10             	add    $0x10,%esp
            palloc_free_index = palloc_index;
  1063fc:	85 c0                	test   %eax,%eax
  1063fe:	0f 44 f5             	cmove  %ebp,%esi
  106401:	eb b1                	jmp    1063b4 <palloc+0x44>
  106403:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        at_set_allocated(palloc_free_index, 1);
  106408:	83 ec 08             	sub    $0x8,%esp
  10640b:	6a 01                	push   $0x1
  10640d:	56                   	push   %esi
  10640e:	e8 8d fd ff ff       	call   1061a0 <at_set_allocated>
  106413:	83 c4 10             	add    $0x10,%esp
  106416:	89 f0                	mov    %esi,%eax
  106418:	eb be                	jmp    1063d8 <palloc+0x68>
  10641a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106420 <pfree>:
 * in the allocation table.
 *
 * Hint: Simple.
 */
void pfree(unsigned int pfree_index)
{
  106420:	53                   	push   %ebx
  106421:	e8 7c 9f ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106426:	81 c3 ce ab 00 00    	add    $0xabce,%ebx
  10642c:	83 ec 08             	sub    $0x8,%esp
    mem_lock();
  10642f:	e8 7c fc ff ff       	call   1060b0 <mem_lock>
    at_set_allocated(pfree_index, 0);
  106434:	83 ec 08             	sub    $0x8,%esp
  106437:	6a 00                	push   $0x0
  106439:	ff 74 24 1c          	push   0x1c(%esp)
  10643d:	e8 5e fd ff ff       	call   1061a0 <at_set_allocated>
    mem_unlock();
  106442:	e8 89 fc ff ff       	call   1060d0 <mem_unlock>
}
  106447:	83 c4 18             	add    $0x18,%esp
  10644a:	5b                   	pop    %ebx
  10644b:	c3                   	ret
  10644c:	66 90                	xchg   %ax,%ax
  10644e:	66 90                	xchg   %ax,%ax

00106450 <container_init>:
/**
 * Initializes the container data for the root process (the one with index 0).
 * The root process is the one that gets spawned first by the kernel.
 */
void container_init(unsigned int mbi_addr)
{
  106450:	55                   	push   %ebp
  106451:	57                   	push   %edi
  106452:	56                   	push   %esi
  106453:	53                   	push   %ebx
  106454:	e8 49 9f ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106459:	81 c3 9b ab 00 00    	add    $0xab9b,%ebx
  10645f:	83 ec 18             	sub    $0x18,%esp
    unsigned int real_quota;
    unsigned int nps, idx;

    pmem_init(mbi_addr);
  106462:	ff 74 24 2c          	push   0x2c(%esp)
  106466:	e8 55 fd ff ff       	call   1061c0 <pmem_init>
    /**
     * Compute the available quota and store it into the variable real_quota.
     * It should be the number of the unallocated pages with the normal permission
     * in the physical memory allocation table.
     */
    nps = get_nps();
  10646b:	e8 80 fc ff ff       	call   1060f0 <get_nps>
    idx = 1;
    while (idx < nps) {
  106470:	83 c4 10             	add    $0x10,%esp
  106473:	83 f8 01             	cmp    $0x1,%eax
  106476:	0f 86 b7 00 00 00    	jbe    106533 <container_init+0xe3>
  10647c:	89 c6                	mov    %eax,%esi
    idx = 1;
  10647e:	bd 01 00 00 00       	mov    $0x1,%ebp
    real_quota = 0;
  106483:	31 ff                	xor    %edi,%edi
  106485:	eb 10                	jmp    106497 <container_init+0x47>
  106487:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10648e:	00 
  10648f:	90                   	nop
        if (at_is_norm(idx) && !at_is_allocated(idx)) {
            real_quota++;
        }
        idx++;
  106490:	83 c5 01             	add    $0x1,%ebp
    while (idx < nps) {
  106493:	39 ee                	cmp    %ebp,%esi
  106495:	74 29                	je     1064c0 <container_init+0x70>
        if (at_is_norm(idx) && !at_is_allocated(idx)) {
  106497:	83 ec 0c             	sub    $0xc,%esp
  10649a:	55                   	push   %ebp
  10649b:	e8 90 fc ff ff       	call   106130 <at_is_norm>
  1064a0:	83 c4 10             	add    $0x10,%esp
  1064a3:	85 c0                	test   %eax,%eax
  1064a5:	74 e9                	je     106490 <container_init+0x40>
  1064a7:	83 ec 0c             	sub    $0xc,%esp
  1064aa:	55                   	push   %ebp
  1064ab:	e8 d0 fc ff ff       	call   106180 <at_is_allocated>
  1064b0:	83 c4 10             	add    $0x10,%esp
            real_quota++;
  1064b3:	83 f8 01             	cmp    $0x1,%eax
  1064b6:	83 d7 00             	adc    $0x0,%edi
        idx++;
  1064b9:	83 c5 01             	add    $0x1,%ebp
    while (idx < nps) {
  1064bc:	39 ee                	cmp    %ebp,%esi
  1064be:	75 d7                	jne    106497 <container_init+0x47>
    }

    KERN_DEBUG("\nreal quota: %d\n\n", real_quota);

    CONTAINER[0].quota = real_quota;
  1064c0:	89 fe                	mov    %edi,%esi
    KERN_DEBUG("\nreal quota: %d\n\n", real_quota);
  1064c2:	8d 83 8b 85 ff ff    	lea    -0x7a75(%ebx),%eax
  1064c8:	57                   	push   %edi
  1064c9:	50                   	push   %eax
  1064ca:	8d 83 4c 90 ff ff    	lea    -0x6fb4(%ebx),%eax
  1064d0:	6a 2c                	push   $0x2c
  1064d2:	50                   	push   %eax
  1064d3:	e8 28 dc ff ff       	call   104100 <debug_normal>
    CONTAINER[0].quota = real_quota;
  1064d8:	89 b3 cc 14 87 00    	mov    %esi,0x8714cc(%ebx)
    CONTAINER[0].usage = 0;
  1064de:	83 c4 10             	add    $0x10,%esp
  1064e1:	8d b3 cc 12 87 00    	lea    0x8712cc(%ebx),%esi
  1064e7:	c7 83 d0 14 87 00 00 	movl   $0x0,0x8714d0(%ebx)
  1064ee:	00 00 00 
    CONTAINER[0].parent = 0;
  1064f1:	8d be 00 02 00 00    	lea    0x200(%esi),%edi
  1064f7:	c7 83 d4 14 87 00 00 	movl   $0x0,0x8714d4(%ebx)
  1064fe:	00 00 00 
    CONTAINER[0].nchildren = 0;
  106501:	c7 83 d8 14 87 00 00 	movl   $0x0,0x8714d8(%ebx)
  106508:	00 00 00 
    CONTAINER[0].used = 1;
  10650b:	c7 83 dc 14 87 00 01 	movl   $0x1,0x8714dc(%ebx)
  106512:	00 00 00 

    for (idx = 0; idx < NUM_IDS; idx++) {
  106515:	8d 76 00             	lea    0x0(%esi),%esi
        spinlock_init(&container_lks[idx]);
  106518:	83 ec 0c             	sub    $0xc,%esp
  10651b:	56                   	push   %esi
    for (idx = 0; idx < NUM_IDS; idx++) {
  10651c:	83 c6 08             	add    $0x8,%esi
        spinlock_init(&container_lks[idx]);
  10651f:	e8 dc f2 ff ff       	call   105800 <spinlock_init>
    for (idx = 0; idx < NUM_IDS; idx++) {
  106524:	83 c4 10             	add    $0x10,%esp
  106527:	39 fe                	cmp    %edi,%esi
  106529:	75 ed                	jne    106518 <container_init+0xc8>
    }
}
  10652b:	83 c4 0c             	add    $0xc,%esp
  10652e:	5b                   	pop    %ebx
  10652f:	5e                   	pop    %esi
  106530:	5f                   	pop    %edi
  106531:	5d                   	pop    %ebp
  106532:	c3                   	ret
    while (idx < nps) {
  106533:	31 f6                	xor    %esi,%esi
    real_quota = 0;
  106535:	31 ff                	xor    %edi,%edi
  106537:	eb 89                	jmp    1064c2 <container_init+0x72>
  106539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106540 <container_get_parent>:

// Get the id of parent process of process # [id].
unsigned int container_get_parent(unsigned int id)
{
    return CONTAINER[id].parent;
  106540:	e8 59 9e ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106545:	81 c2 af aa 00 00    	add    $0xaaaf,%edx
{
  10654b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].parent;
  10654f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106552:	8b 84 82 d4 14 87 00 	mov    0x8714d4(%edx,%eax,4),%eax
}
  106559:	c3                   	ret
  10655a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106560 <container_get_nchildren>:

// Get the number of children of process # [id].
unsigned int container_get_nchildren(unsigned int id)
{
    return CONTAINER[id].nchildren;
  106560:	e8 39 9e ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106565:	81 c2 8f aa 00 00    	add    $0xaa8f,%edx
{
  10656b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].nchildren;
  10656f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106572:	8b 84 82 d8 14 87 00 	mov    0x8714d8(%edx,%eax,4),%eax
}
  106579:	c3                   	ret
  10657a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106580 <container_get_quota>:

// Get the maximum memory quota of process # [id].
unsigned int container_get_quota(unsigned int id)
{
    return CONTAINER[id].quota;
  106580:	e8 19 9e ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106585:	81 c2 6f aa 00 00    	add    $0xaa6f,%edx
{
  10658b:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].quota;
  10658f:	8d 04 80             	lea    (%eax,%eax,4),%eax
  106592:	8b 84 82 cc 14 87 00 	mov    0x8714cc(%edx,%eax,4),%eax
}
  106599:	c3                   	ret
  10659a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001065a0 <container_get_usage>:

// Get the current memory usage of process # [id].
unsigned int container_get_usage(unsigned int id)
{
    return CONTAINER[id].usage;
  1065a0:	e8 f9 9d ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  1065a5:	81 c2 4f aa 00 00    	add    $0xaa4f,%edx
{
  1065ab:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].usage;
  1065af:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1065b2:	8b 84 82 d0 14 87 00 	mov    0x8714d0(%edx,%eax,4),%eax
}
  1065b9:	c3                   	ret
  1065ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001065c0 <container_can_consume>:

// Determines whether the process # [id] can consume an extra
// [n] pages of memory. If so, returns 1, otherwise, returns 0.
unsigned int container_can_consume(unsigned int id, unsigned int n)
{
    return CONTAINER[id].usage + n <= CONTAINER[id].quota;
  1065c0:	e8 9e c8 ff ff       	call   102e63 <__x86.get_pc_thunk.cx>
  1065c5:	81 c1 2f aa 00 00    	add    $0xaa2f,%ecx
{
  1065cb:	8b 44 24 04          	mov    0x4(%esp),%eax
    return CONTAINER[id].usage + n <= CONTAINER[id].quota;
  1065cf:	8d 04 80             	lea    (%eax,%eax,4),%eax
  1065d2:	c1 e0 02             	shl    $0x2,%eax
  1065d5:	8b 94 01 d0 14 87 00 	mov    0x8714d0(%ecx,%eax,1),%edx
  1065dc:	03 54 24 08          	add    0x8(%esp),%edx
  1065e0:	39 94 01 cc 14 87 00 	cmp    %edx,0x8714cc(%ecx,%eax,1)
  1065e7:	0f 93 c0             	setae  %al
  1065ea:	0f b6 c0             	movzbl %al,%eax
}
  1065ed:	c3                   	ret
  1065ee:	66 90                	xchg   %ax,%ax

001065f0 <container_split>:
 * You can assume it is safe to allocate [quota] pages
 * (the check is already done outside before calling this function).
 * Returns the container index for the new child process.
 */
unsigned int container_split(unsigned int id, unsigned int quota)
{
  1065f0:	55                   	push   %ebp
  1065f1:	57                   	push   %edi
  1065f2:	56                   	push   %esi
  1065f3:	53                   	push   %ebx
  1065f4:	e8 a9 9d ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1065f9:	81 c3 fb a9 00 00    	add    $0xa9fb,%ebx
  1065ff:	83 ec 28             	sub    $0x28,%esp
  106602:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    unsigned int child, nc;

    spinlock_acquire(&container_lks[id]);

    nc = CONTAINER[id].nchildren;
    child = id * MAX_CHILDREN + 1 + nc;  // container index for the child process
  106606:	8d 7c 76 01          	lea    0x1(%esi,%esi,2),%edi
    spinlock_acquire(&container_lks[id]);
  10660a:	8d ac f3 cc 12 87 00 	lea    0x8712cc(%ebx,%esi,8),%ebp
  106611:	55                   	push   %ebp
  106612:	e8 79 f2 ff ff       	call   105890 <spinlock_acquire>
    nc = CONTAINER[id].nchildren;
  106617:	8d 04 b6             	lea    (%esi,%esi,4),%eax

    if (NUM_IDS <= child) {
  10661a:	83 c4 10             	add    $0x10,%esp
    nc = CONTAINER[id].nchildren;
  10661d:	8d 84 83 cc 14 87 00 	lea    0x8714cc(%ebx,%eax,4),%eax
    child = id * MAX_CHILDREN + 1 + nc;  // container index for the child process
  106624:	03 78 0c             	add    0xc(%eax),%edi
    if (NUM_IDS <= child) {
  106627:	83 ff 3f             	cmp    $0x3f,%edi
  10662a:	77 54                	ja     106680 <container_split+0x90>
    }

    /**
     * Update the container structure of both parent and child process appropriately.
     */
    CONTAINER[child].used = 1;
  10662c:	8d 14 bf             	lea    (%edi,%edi,4),%edx
    CONTAINER[child].nchildren = 0;

    CONTAINER[id].usage += quota;
    CONTAINER[id].nchildren++;

    spinlock_release(&container_lks[id]);
  10662f:	83 ec 0c             	sub    $0xc,%esp
    CONTAINER[child].used = 1;
  106632:	c1 e2 02             	shl    $0x2,%edx
  106635:	8d 8c 13 cc 14 87 00 	lea    0x8714cc(%ebx,%edx,1),%ecx
  10663c:	89 54 24 18          	mov    %edx,0x18(%esp)
    CONTAINER[child].quota = quota;
  106640:	8b 54 24 40          	mov    0x40(%esp),%edx
    CONTAINER[child].usage = 0;
  106644:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
    CONTAINER[child].parent = id;
  10664b:	89 71 08             	mov    %esi,0x8(%ecx)
    CONTAINER[child].nchildren = 0;
  10664e:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
    CONTAINER[child].used = 1;
  106655:	c7 41 10 01 00 00 00 	movl   $0x1,0x10(%ecx)
    CONTAINER[child].quota = quota;
  10665c:	89 11                	mov    %edx,(%ecx)
    CONTAINER[id].usage += quota;
  10665e:	8b 4c 24 40          	mov    0x40(%esp),%ecx
    CONTAINER[id].nchildren++;
  106662:	83 40 0c 01          	addl   $0x1,0xc(%eax)
    CONTAINER[id].usage += quota;
  106666:	01 48 04             	add    %ecx,0x4(%eax)
    spinlock_release(&container_lks[id]);
  106669:	55                   	push   %ebp
  10666a:	e8 a1 f2 ff ff       	call   105910 <spinlock_release>

    return child;
  10666f:	83 c4 10             	add    $0x10,%esp
}
  106672:	89 f8                	mov    %edi,%eax
  106674:	83 c4 1c             	add    $0x1c,%esp
  106677:	5b                   	pop    %ebx
  106678:	5e                   	pop    %esi
  106679:	5f                   	pop    %edi
  10667a:	5d                   	pop    %ebp
  10667b:	c3                   	ret
  10667c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  106680:	83 c4 1c             	add    $0x1c,%esp
        return NUM_IDS;
  106683:	bf 40 00 00 00       	mov    $0x40,%edi
}
  106688:	5b                   	pop    %ebx
  106689:	89 f8                	mov    %edi,%eax
  10668b:	5e                   	pop    %esi
  10668c:	5f                   	pop    %edi
  10668d:	5d                   	pop    %ebp
  10668e:	c3                   	ret
  10668f:	90                   	nop

00106690 <container_alloc>:
 * Allocates one more page for process # [id], given that this will not exceed the quota.
 * The container structure should be updated accordingly after the allocation.
 * Returns the page index of the allocated page, or 0 in the case of failure.
 */
unsigned int container_alloc(unsigned int id)
{
  106690:	57                   	push   %edi
  106691:	56                   	push   %esi
  106692:	53                   	push   %ebx
  106693:	8b 74 24 10          	mov    0x10(%esp),%esi
  106697:	e8 06 9d ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  10669c:	81 c3 58 a9 00 00    	add    $0xa958,%ebx
    unsigned int page_index = 0;

    spinlock_acquire(&container_lks[id]);
  1066a2:	83 ec 0c             	sub    $0xc,%esp
  1066a5:	8d bc f3 cc 12 87 00 	lea    0x8712cc(%ebx,%esi,8),%edi
  1066ac:	57                   	push   %edi
  1066ad:	e8 de f1 ff ff       	call   105890 <spinlock_acquire>

    if (CONTAINER[id].usage + 1 <= CONTAINER[id].quota) {
  1066b2:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  1066b5:	83 c4 10             	add    $0x10,%esp
  1066b8:	31 f6                	xor    %esi,%esi
  1066ba:	c1 e0 02             	shl    $0x2,%eax
  1066bd:	8d 8c 03 cc 14 87 00 	lea    0x8714cc(%ebx,%eax,1),%ecx
  1066c4:	8b 51 04             	mov    0x4(%ecx),%edx
  1066c7:	3b 94 03 cc 14 87 00 	cmp    0x8714cc(%ebx,%eax,1),%edx
  1066ce:	7c 18                	jl     1066e8 <container_alloc+0x58>
        CONTAINER[id].usage++;
        page_index = palloc();
    }

    spinlock_release(&container_lks[id]);
  1066d0:	83 ec 0c             	sub    $0xc,%esp
  1066d3:	57                   	push   %edi
  1066d4:	e8 37 f2 ff ff       	call   105910 <spinlock_release>

    return page_index;
  1066d9:	83 c4 10             	add    $0x10,%esp
}
  1066dc:	89 f0                	mov    %esi,%eax
  1066de:	5b                   	pop    %ebx
  1066df:	5e                   	pop    %esi
  1066e0:	5f                   	pop    %edi
  1066e1:	c3                   	ret
  1066e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        CONTAINER[id].usage++;
  1066e8:	83 c2 01             	add    $0x1,%edx
  1066eb:	89 51 04             	mov    %edx,0x4(%ecx)
        page_index = palloc();
  1066ee:	e8 7d fc ff ff       	call   106370 <palloc>
  1066f3:	89 c6                	mov    %eax,%esi
  1066f5:	eb d9                	jmp    1066d0 <container_alloc+0x40>
  1066f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1066fe:	00 
  1066ff:	90                   	nop

00106700 <container_free>:

// Frees the physical page and reduces the usage by 1.
void container_free(unsigned int id, unsigned int page_index)
{
  106700:	55                   	push   %ebp
  106701:	57                   	push   %edi
  106702:	56                   	push   %esi
  106703:	53                   	push   %ebx
  106704:	e8 99 9c ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106709:	81 c3 eb a8 00 00    	add    $0xa8eb,%ebx
  10670f:	83 ec 18             	sub    $0x18,%esp
  106712:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  106716:	8b 7c 24 30          	mov    0x30(%esp),%edi
    spinlock_acquire(&container_lks[id]);
  10671a:	8d ac f3 cc 12 87 00 	lea    0x8712cc(%ebx,%esi,8),%ebp
  106721:	55                   	push   %ebp
  106722:	e8 69 f1 ff ff       	call   105890 <spinlock_acquire>

    if (at_is_allocated(page_index)) {
  106727:	89 3c 24             	mov    %edi,(%esp)
  10672a:	e8 51 fa ff ff       	call   106180 <at_is_allocated>
  10672f:	83 c4 10             	add    $0x10,%esp
  106732:	85 c0                	test   %eax,%eax
  106734:	75 1a                	jne    106750 <container_free+0x50>
        if (CONTAINER[id].usage > 0) {
            CONTAINER[id].usage--;
        }
    }

    spinlock_release(&container_lks[id]);
  106736:	83 ec 0c             	sub    $0xc,%esp
  106739:	55                   	push   %ebp
  10673a:	e8 d1 f1 ff ff       	call   105910 <spinlock_release>
}
  10673f:	83 c4 1c             	add    $0x1c,%esp
  106742:	5b                   	pop    %ebx
  106743:	5e                   	pop    %esi
  106744:	5f                   	pop    %edi
  106745:	5d                   	pop    %ebp
  106746:	c3                   	ret
  106747:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10674e:	00 
  10674f:	90                   	nop
        pfree(page_index);
  106750:	83 ec 0c             	sub    $0xc,%esp
  106753:	57                   	push   %edi
  106754:	e8 c7 fc ff ff       	call   106420 <pfree>
        if (CONTAINER[id].usage > 0) {
  106759:	8d 04 b6             	lea    (%esi,%esi,4),%eax
  10675c:	83 c4 10             	add    $0x10,%esp
  10675f:	8d 94 83 cc 14 87 00 	lea    0x8714cc(%ebx,%eax,4),%edx
  106766:	8b 42 04             	mov    0x4(%edx),%eax
  106769:	85 c0                	test   %eax,%eax
  10676b:	7e c9                	jle    106736 <container_free+0x36>
            CONTAINER[id].usage--;
  10676d:	83 e8 01             	sub    $0x1,%eax
  106770:	89 42 04             	mov    %eax,0x4(%edx)
  106773:	eb c1                	jmp    106736 <container_free+0x36>
  106775:	66 90                	xchg   %ax,%ax
  106777:	66 90                	xchg   %ax,%ax
  106779:	66 90                	xchg   %ax,%ax
  10677b:	66 90                	xchg   %ax,%ax
  10677d:	66 90                	xchg   %ax,%ax
  10677f:	90                   	nop

00106780 <set_pdir_base>:
 */
unsigned int IDPTbl[1024][1024] gcc_aligned(PAGESIZE);

// Sets the CR3 register with the start address of the page structure for process # [index].
void set_pdir_base(unsigned int index)
{
  106780:	53                   	push   %ebx
  106781:	e8 1c 9c ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106786:	81 c3 6e a8 00 00    	add    $0xa86e,%ebx
  10678c:	83 ec 14             	sub    $0x14,%esp
    set_cr3(PDirPool[index]);
  10678f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106793:	c1 e0 0c             	shl    $0xc,%eax
  106796:	8d 84 03 0c 20 c7 00 	lea    0xc7200c(%ebx,%eax,1),%eax
  10679d:	50                   	push   %eax
  10679e:	e8 7d aa ff ff       	call   101220 <set_cr3>
}
  1067a3:	83 c4 18             	add    $0x18,%esp
  1067a6:	5b                   	pop    %ebx
  1067a7:	c3                   	ret
  1067a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1067af:	00 

001067b0 <get_pdir_entry>:

// Returns the page directory entry # [pde_index] of the process # [proc_index].
// This can be used to test whether the page directory entry is mapped.
unsigned int get_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    return (unsigned int) PDirPool[proc_index][pde_index];
  1067b0:	e8 e9 9b ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  1067b5:	81 c2 3f a8 00 00    	add    $0xa83f,%edx
  1067bb:	8b 44 24 04          	mov    0x4(%esp),%eax
  1067bf:	c1 e0 0a             	shl    $0xa,%eax
  1067c2:	03 44 24 08          	add    0x8(%esp),%eax
  1067c6:	8b 84 82 0c 20 c7 00 	mov    0xc7200c(%edx,%eax,4),%eax
}
  1067cd:	c3                   	ret
  1067ce:	66 90                	xchg   %ax,%ax

001067d0 <set_pdir_entry>:
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
void set_pdir_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int page_index)
{
    unsigned int addr = page_index << 12;
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  1067d0:	e8 8e c6 ff ff       	call   102e63 <__x86.get_pc_thunk.cx>
  1067d5:	81 c1 1f a8 00 00    	add    $0xa81f,%ecx
    unsigned int addr = page_index << 12;
  1067db:	8b 54 24 0c          	mov    0xc(%esp),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  1067df:	8b 44 24 04          	mov    0x4(%esp),%eax
    unsigned int addr = page_index << 12;
  1067e3:	c1 e2 0c             	shl    $0xc,%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  1067e6:	c1 e0 0a             	shl    $0xa,%eax
  1067e9:	03 44 24 08          	add    0x8(%esp),%eax
  1067ed:	83 ca 07             	or     $0x7,%edx
  1067f0:	89 94 81 0c 20 c7 00 	mov    %edx,0xc7200c(%ecx,%eax,4)
}
  1067f7:	c3                   	ret
  1067f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1067ff:	00 

00106800 <set_pdir_entry_identity>:
// with the initial address of page directory # [pde_index] in IDPTbl.
// You should also set the permissions PTE_P, PTE_W, and PTE_U.
// This will be used to map a page directory entry to an identity page table.
void set_pdir_entry_identity(unsigned int proc_index, unsigned int pde_index)
{
    unsigned int addr = (unsigned int) IDPTbl[pde_index];
  106800:	e8 5e c6 ff ff       	call   102e63 <__x86.get_pc_thunk.cx>
  106805:	81 c1 ef a7 00 00    	add    $0xa7ef,%ecx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  10680b:	8b 44 24 04          	mov    0x4(%esp),%eax
{
  10680f:	8b 54 24 08          	mov    0x8(%esp),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106813:	c1 e0 0a             	shl    $0xa,%eax
  106816:	01 d0                	add    %edx,%eax
    unsigned int addr = (unsigned int) IDPTbl[pde_index];
  106818:	c1 e2 0c             	shl    $0xc,%edx
  10681b:	8d 94 11 0c 20 87 00 	lea    0x87200c(%ecx,%edx,1),%edx
    PDirPool[proc_index][pde_index] = (unsigned int *) (addr | PT_PERM_PTU);
  106822:	83 ca 07             	or     $0x7,%edx
  106825:	89 94 81 0c 20 c7 00 	mov    %edx,0xc7200c(%ecx,%eax,4)
}
  10682c:	c3                   	ret
  10682d:	8d 76 00             	lea    0x0(%esi),%esi

00106830 <rmv_pdir_entry>:

// Removes the specified page directory entry (sets the page directory entry to 0).
// Don't forget to cast the value to (unsigned int *).
void rmv_pdir_entry(unsigned int proc_index, unsigned int pde_index)
{
    PDirPool[proc_index][pde_index] = (unsigned int *) 0;
  106830:	e8 69 9b ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106835:	81 c2 bf a7 00 00    	add    $0xa7bf,%edx
  10683b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10683f:	c1 e0 0a             	shl    $0xa,%eax
  106842:	03 44 24 08          	add    0x8(%esp),%eax
  106846:	c7 84 82 0c 20 c7 00 	movl   $0x0,0xc7200c(%edx,%eax,4)
  10684d:	00 00 00 00 
}
  106851:	c3                   	ret
  106852:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106859:	00 
  10685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106860 <get_ptbl_entry>:
// Do not forget that the permission info is also stored in the page directory entries.
unsigned int get_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                            unsigned int pte_index)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    return pt[pte_index];
  106860:	e8 39 9b ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106865:	81 c2 8f a7 00 00    	add    $0xa78f,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  10686b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10686f:	c1 e0 0a             	shl    $0xa,%eax
  106872:	03 44 24 08          	add    0x8(%esp),%eax
  106876:	8b 84 82 0c 20 c7 00 	mov    0xc7200c(%edx,%eax,4),%eax
    return pt[pte_index];
  10687d:	8b 54 24 0c          	mov    0xc(%esp),%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106881:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    return pt[pte_index];
  106886:	8b 04 90             	mov    (%eax,%edx,4),%eax
}
  106889:	c3                   	ret
  10688a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106890 <set_ptbl_entry>:
void set_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index, unsigned int page_index,
                    unsigned int perm)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    pt[pte_index] = (page_index << 12) | perm;
  106890:	e8 09 9b ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106895:	81 c2 5f a7 00 00    	add    $0xa75f,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  10689b:	8b 44 24 04          	mov    0x4(%esp),%eax
    pt[pte_index] = (page_index << 12) | perm;
  10689f:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  1068a3:	c1 e0 0a             	shl    $0xa,%eax
  1068a6:	03 44 24 08          	add    0x8(%esp),%eax
  1068aa:	8b 94 82 0c 20 c7 00 	mov    0xc7200c(%edx,%eax,4),%edx
    pt[pte_index] = (page_index << 12) | perm;
  1068b1:	8b 44 24 10          	mov    0x10(%esp),%eax
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  1068b5:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
    pt[pte_index] = (page_index << 12) | perm;
  1068bb:	c1 e0 0c             	shl    $0xc,%eax
  1068be:	0b 44 24 14          	or     0x14(%esp),%eax
  1068c2:	89 04 8a             	mov    %eax,(%edx,%ecx,4)
}
  1068c5:	c3                   	ret
  1068c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1068cd:	00 
  1068ce:	66 90                	xchg   %ax,%ax

001068d0 <set_ptbl_entry_identity>:

// Sets up the specified page table entry in IDPTbl as the identity map.
// You should also set the given permission.
void set_ptbl_entry_identity(unsigned int pde_index, unsigned int pte_index,
                             unsigned int perm)
{
  1068d0:	53                   	push   %ebx
  1068d1:	8b 54 24 08          	mov    0x8(%esp),%edx
  1068d5:	e8 c8 9a ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1068da:	81 c3 1a a7 00 00    	add    $0xa71a,%ebx
  1068e0:	8b 44 24 0c          	mov    0xc(%esp),%eax
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
    IDPTbl[pde_index][pte_index] = addr | perm;
  1068e4:	89 d1                	mov    %edx,%ecx
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
  1068e6:	c1 e2 16             	shl    $0x16,%edx
    IDPTbl[pde_index][pte_index] = addr | perm;
  1068e9:	c1 e1 0a             	shl    $0xa,%ecx
  1068ec:	01 c1                	add    %eax,%ecx
    unsigned int addr = (pde_index << 22) | (pte_index << 12);
  1068ee:	c1 e0 0c             	shl    $0xc,%eax
    IDPTbl[pde_index][pte_index] = addr | perm;
  1068f1:	0b 44 24 10          	or     0x10(%esp),%eax
  1068f5:	09 d0                	or     %edx,%eax
  1068f7:	89 84 8b 0c 20 87 00 	mov    %eax,0x87200c(%ebx,%ecx,4)
}
  1068fe:	5b                   	pop    %ebx
  1068ff:	c3                   	ret

00106900 <rmv_ptbl_entry>:
// Sets the specified page table entry to 0.
void rmv_ptbl_entry(unsigned int proc_index, unsigned int pde_index,
                    unsigned int pte_index)
{
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
    pt[pte_index] = 0;
  106900:	e8 99 9a ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106905:	81 c2 ef a6 00 00    	add    $0xa6ef,%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  10690b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10690f:	c1 e0 0a             	shl    $0xa,%eax
  106912:	03 44 24 08          	add    0x8(%esp),%eax
  106916:	8b 84 82 0c 20 c7 00 	mov    0xc7200c(%edx,%eax,4),%eax
    pt[pte_index] = 0;
  10691d:	8b 54 24 0c          	mov    0xc(%esp),%edx
    unsigned int *pt = (unsigned int *) ADDR_MASK(PDirPool[proc_index][pde_index]);
  106921:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    pt[pte_index] = 0;
  106926:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
}
  10692d:	c3                   	ret
  10692e:	66 90                	xchg   %ax,%ax

00106930 <get_ptbl_entry_by_va>:
 * Returns the page table entry corresponding to the virtual address,
 * according to the page structure of process # [proc_index].
 * Returns 0 if the mapping does not exist.
 */
unsigned int get_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106930:	55                   	push   %ebp
  106931:	57                   	push   %edi
  106932:	56                   	push   %esi
  106933:	53                   	push   %ebx
  106934:	e8 69 9a ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106939:	81 c3 bb a6 00 00    	add    $0xa6bb,%ebx
  10693f:	83 ec 14             	sub    $0x14,%esp
  106942:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  106946:	8b 7c 24 28          	mov    0x28(%esp),%edi
    unsigned int pde_index = PDE_ADDR(vaddr);
  10694a:	89 f5                	mov    %esi,%ebp
  10694c:	c1 ed 16             	shr    $0x16,%ebp
    if (get_pdir_entry(proc_index, pde_index) != 0) {
  10694f:	55                   	push   %ebp
  106950:	57                   	push   %edi
  106951:	e8 5a fe ff ff       	call   1067b0 <get_pdir_entry>
  106956:	83 c4 10             	add    $0x10,%esp
  106959:	85 c0                	test   %eax,%eax
  10695b:	75 0b                	jne    106968 <get_ptbl_entry_by_va+0x38>
        return get_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
    } else {
        return 0;
    }
}
  10695d:	83 c4 0c             	add    $0xc,%esp
  106960:	5b                   	pop    %ebx
  106961:	5e                   	pop    %esi
  106962:	5f                   	pop    %edi
  106963:	5d                   	pop    %ebp
  106964:	c3                   	ret
  106965:	8d 76 00             	lea    0x0(%esi),%esi
        return get_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
  106968:	c1 ee 0c             	shr    $0xc,%esi
  10696b:	83 ec 04             	sub    $0x4,%esp
  10696e:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
  106974:	56                   	push   %esi
  106975:	55                   	push   %ebp
  106976:	57                   	push   %edi
  106977:	e8 e4 fe ff ff       	call   106860 <get_ptbl_entry>
  10697c:	83 c4 10             	add    $0x10,%esp
}
  10697f:	83 c4 0c             	add    $0xc,%esp
  106982:	5b                   	pop    %ebx
  106983:	5e                   	pop    %esi
  106984:	5f                   	pop    %edi
  106985:	5d                   	pop    %ebp
  106986:	c3                   	ret
  106987:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10698e:	00 
  10698f:	90                   	nop

00106990 <get_pdir_entry_by_va>:

// Returns the page directory entry corresponding to the given virtual address.
unsigned int get_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106990:	53                   	push   %ebx
  106991:	e8 0c 9a ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106996:	81 c3 5e a6 00 00    	add    $0xa65e,%ebx
  10699c:	83 ec 10             	sub    $0x10,%esp
    return get_pdir_entry(proc_index, PDE_ADDR(vaddr));
  10699f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  1069a3:	c1 e8 16             	shr    $0x16,%eax
  1069a6:	50                   	push   %eax
  1069a7:	ff 74 24 1c          	push   0x1c(%esp)
  1069ab:	e8 00 fe ff ff       	call   1067b0 <get_pdir_entry>
}
  1069b0:	83 c4 18             	add    $0x18,%esp
  1069b3:	5b                   	pop    %ebx
  1069b4:	c3                   	ret
  1069b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1069bc:	00 
  1069bd:	8d 76 00             	lea    0x0(%esi),%esi

001069c0 <rmv_ptbl_entry_by_va>:

// Removes the page table entry for the given virtual address.
void rmv_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  1069c0:	55                   	push   %ebp
  1069c1:	57                   	push   %edi
  1069c2:	56                   	push   %esi
  1069c3:	53                   	push   %ebx
  1069c4:	e8 d9 99 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1069c9:	81 c3 2b a6 00 00    	add    $0xa62b,%ebx
  1069cf:	83 ec 14             	sub    $0x14,%esp
  1069d2:	8b 74 24 2c          	mov    0x2c(%esp),%esi
  1069d6:	8b 7c 24 28          	mov    0x28(%esp),%edi
    unsigned int pde_index = PDE_ADDR(vaddr);
  1069da:	89 f5                	mov    %esi,%ebp
  1069dc:	c1 ed 16             	shr    $0x16,%ebp
    if (get_pdir_entry(proc_index, pde_index) != 0) {
  1069df:	55                   	push   %ebp
  1069e0:	57                   	push   %edi
  1069e1:	e8 ca fd ff ff       	call   1067b0 <get_pdir_entry>
  1069e6:	83 c4 10             	add    $0x10,%esp
  1069e9:	85 c0                	test   %eax,%eax
  1069eb:	75 0b                	jne    1069f8 <rmv_ptbl_entry_by_va+0x38>
        rmv_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
    }
}
  1069ed:	83 c4 0c             	add    $0xc,%esp
  1069f0:	5b                   	pop    %ebx
  1069f1:	5e                   	pop    %esi
  1069f2:	5f                   	pop    %edi
  1069f3:	5d                   	pop    %ebp
  1069f4:	c3                   	ret
  1069f5:	8d 76 00             	lea    0x0(%esi),%esi
        rmv_ptbl_entry(proc_index, pde_index, PTE_ADDR(vaddr));
  1069f8:	c1 ee 0c             	shr    $0xc,%esi
  1069fb:	83 ec 04             	sub    $0x4,%esp
  1069fe:	81 e6 ff 03 00 00    	and    $0x3ff,%esi
  106a04:	56                   	push   %esi
  106a05:	55                   	push   %ebp
  106a06:	57                   	push   %edi
  106a07:	e8 f4 fe ff ff       	call   106900 <rmv_ptbl_entry>
  106a0c:	83 c4 10             	add    $0x10,%esp
}
  106a0f:	83 c4 0c             	add    $0xc,%esp
  106a12:	5b                   	pop    %ebx
  106a13:	5e                   	pop    %esi
  106a14:	5f                   	pop    %edi
  106a15:	5d                   	pop    %ebp
  106a16:	c3                   	ret
  106a17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106a1e:	00 
  106a1f:	90                   	nop

00106a20 <rmv_pdir_entry_by_va>:

// Removes the page directory entry for the given virtual address.
void rmv_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr)
{
  106a20:	53                   	push   %ebx
  106a21:	e8 7c 99 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106a26:	81 c3 ce a5 00 00    	add    $0xa5ce,%ebx
  106a2c:	83 ec 10             	sub    $0x10,%esp
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106a2f:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106a33:	c1 e8 16             	shr    $0x16,%eax
  106a36:	50                   	push   %eax
  106a37:	ff 74 24 1c          	push   0x1c(%esp)
  106a3b:	e8 f0 fd ff ff       	call   106830 <rmv_pdir_entry>
}
  106a40:	83 c4 18             	add    $0x18,%esp
  106a43:	5b                   	pop    %ebx
  106a44:	c3                   	ret
  106a45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106a4c:	00 
  106a4d:	8d 76 00             	lea    0x0(%esi),%esi

00106a50 <set_ptbl_entry_by_va>:

// Maps the virtual address [vaddr] to the physical page # [page_index] with permission [perm].
// You do not need to worry about the page directory entry. just map the page table entry.
void set_ptbl_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index, unsigned int perm)
{
  106a50:	53                   	push   %ebx
  106a51:	e8 4c 99 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106a56:	81 c3 9e a5 00 00    	add    $0xa59e,%ebx
  106a5c:	83 ec 14             	sub    $0x14,%esp
  106a5f:	8b 44 24 20          	mov    0x20(%esp),%eax
    set_ptbl_entry(proc_index, PDE_ADDR(vaddr), PTE_ADDR(vaddr), page_index, perm);
  106a63:	ff 74 24 28          	push   0x28(%esp)
  106a67:	ff 74 24 28          	push   0x28(%esp)
  106a6b:	89 c2                	mov    %eax,%edx
  106a6d:	c1 e8 16             	shr    $0x16,%eax
  106a70:	c1 ea 0c             	shr    $0xc,%edx
  106a73:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
  106a79:	52                   	push   %edx
  106a7a:	50                   	push   %eax
  106a7b:	ff 74 24 2c          	push   0x2c(%esp)
  106a7f:	e8 0c fe ff ff       	call   106890 <set_ptbl_entry>
}
  106a84:	83 c4 28             	add    $0x28,%esp
  106a87:	5b                   	pop    %ebx
  106a88:	c3                   	ret
  106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106a90 <set_pdir_entry_by_va>:

// Registers the mapping from [vaddr] to physical page # [page_index] in the page directory.
void set_pdir_entry_by_va(unsigned int proc_index, unsigned int vaddr,
                          unsigned int page_index)
{
  106a90:	53                   	push   %ebx
  106a91:	e8 0c 99 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106a96:	81 c3 5e a5 00 00    	add    $0xa55e,%ebx
  106a9c:	83 ec 0c             	sub    $0xc,%esp
    set_pdir_entry(proc_index, PDE_ADDR(vaddr), page_index);
  106a9f:	ff 74 24 1c          	push   0x1c(%esp)
  106aa3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106aa7:	c1 e8 16             	shr    $0x16,%eax
  106aaa:	50                   	push   %eax
  106aab:	ff 74 24 1c          	push   0x1c(%esp)
  106aaf:	e8 1c fd ff ff       	call   1067d0 <set_pdir_entry>
}
  106ab4:	83 c4 18             	add    $0x18,%esp
  106ab7:	5b                   	pop    %ebx
  106ab8:	c3                   	ret
  106ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00106ac0 <idptbl_init>:

// Initializes the identity page table.
// The permission for the kernel memory should be PTE_P, PTE_W, and PTE_G,
// While the permission for the rest should be PTE_P and PTE_W.
void idptbl_init(unsigned int mbi_addr)
{
  106ac0:	55                   	push   %ebp
    unsigned int pde_index, pte_index, perm;
    container_init(mbi_addr);

    // Set up IDPTbl
    for (pde_index = 0; pde_index < 1024; pde_index++) {
  106ac1:	31 ed                	xor    %ebp,%ebp
{
  106ac3:	57                   	push   %edi
  106ac4:	56                   	push   %esi
  106ac5:	53                   	push   %ebx
  106ac6:	e8 d7 98 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106acb:	81 c3 29 a5 00 00    	add    $0xa529,%ebx
  106ad1:	83 ec 18             	sub    $0x18,%esp
    container_init(mbi_addr);
  106ad4:	ff 74 24 2c          	push   0x2c(%esp)
  106ad8:	e8 73 f9 ff ff       	call   106450 <container_init>
  106add:	83 c4 10             	add    $0x10,%esp
        if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106ae0:	8d 85 00 ff ff ff    	lea    -0x100(%ebp),%eax
            // kernel mapping
            perm = PTE_P | PTE_W | PTE_G;
  106ae6:	3d c0 02 00 00       	cmp    $0x2c0,%eax
  106aeb:	19 ff                	sbb    %edi,%edi
        } else {
            // normal memory
            perm = PTE_P | PTE_W;
        }

        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106aed:	31 f6                	xor    %esi,%esi
            perm = PTE_P | PTE_W | PTE_G;
  106aef:	81 e7 00 ff ff ff    	and    $0xffffff00,%edi
  106af5:	81 c7 03 01 00 00    	add    $0x103,%edi
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            set_ptbl_entry_identity(pde_index, pte_index, perm);
  106b00:	83 ec 04             	sub    $0x4,%esp
  106b03:	57                   	push   %edi
  106b04:	56                   	push   %esi
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106b05:	83 c6 01             	add    $0x1,%esi
            set_ptbl_entry_identity(pde_index, pte_index, perm);
  106b08:	55                   	push   %ebp
  106b09:	e8 c2 fd ff ff       	call   1068d0 <set_ptbl_entry_identity>
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106b0e:	83 c4 10             	add    $0x10,%esp
  106b11:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106b17:	75 e7                	jne    106b00 <idptbl_init+0x40>
    for (pde_index = 0; pde_index < 1024; pde_index++) {
  106b19:	83 c5 01             	add    $0x1,%ebp
  106b1c:	81 fd 00 04 00 00    	cmp    $0x400,%ebp
  106b22:	75 bc                	jne    106ae0 <idptbl_init+0x20>
        }
    }
}
  106b24:	83 c4 0c             	add    $0xc,%esp
  106b27:	5b                   	pop    %ebx
  106b28:	5e                   	pop    %esi
  106b29:	5f                   	pop    %edi
  106b2a:	5d                   	pop    %ebp
  106b2b:	c3                   	ret
  106b2c:	66 90                	xchg   %ax,%ax
  106b2e:	66 90                	xchg   %ax,%ax

00106b30 <pdir_init>:
 * For each process from id 0 to NUM_IDS - 1,
 * set up the page directory entries so that the kernel portion of the map is
 * the identity map, and the rest of the page directories are unmapped.
 */
void pdir_init(unsigned int mbi_addr)
{
  106b30:	57                   	push   %edi
    unsigned int proc_index, pde_index;
    idptbl_init(mbi_addr);

    for (proc_index = 0; proc_index < NUM_IDS; proc_index++) {
  106b31:	31 ff                	xor    %edi,%edi
{
  106b33:	56                   	push   %esi
  106b34:	53                   	push   %ebx
  106b35:	e8 68 98 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106b3a:	81 c3 ba a4 00 00    	add    $0xa4ba,%ebx
    idptbl_init(mbi_addr);
  106b40:	83 ec 0c             	sub    $0xc,%esp
  106b43:	ff 74 24 1c          	push   0x1c(%esp)
  106b47:	e8 74 ff ff ff       	call   106ac0 <idptbl_init>
  106b4c:	83 c4 10             	add    $0x10,%esp
  106b4f:	90                   	nop
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106b50:	31 f6                	xor    %esi,%esi
  106b52:	eb 14                	jmp    106b68 <pdir_init+0x38>
  106b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
                set_pdir_entry_identity(proc_index, pde_index);
            } else {
                rmv_pdir_entry(proc_index, pde_index);
  106b58:	83 ec 08             	sub    $0x8,%esp
  106b5b:	56                   	push   %esi
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106b5c:	83 c6 01             	add    $0x1,%esi
                rmv_pdir_entry(proc_index, pde_index);
  106b5f:	57                   	push   %edi
  106b60:	e8 cb fc ff ff       	call   106830 <rmv_pdir_entry>
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106b65:	83 c4 10             	add    $0x10,%esp
            if ((pde_index < VM_USERLO_PDE) || (VM_USERHI_PDE <= pde_index)) {
  106b68:	8d 86 00 ff ff ff    	lea    -0x100(%esi),%eax
  106b6e:	3d bf 02 00 00       	cmp    $0x2bf,%eax
  106b73:	76 e3                	jbe    106b58 <pdir_init+0x28>
                set_pdir_entry_identity(proc_index, pde_index);
  106b75:	50                   	push   %eax
  106b76:	50                   	push   %eax
  106b77:	56                   	push   %esi
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106b78:	83 c6 01             	add    $0x1,%esi
                set_pdir_entry_identity(proc_index, pde_index);
  106b7b:	57                   	push   %edi
  106b7c:	e8 7f fc ff ff       	call   106800 <set_pdir_entry_identity>
        for (pde_index = 0; pde_index < 1024; pde_index++) {
  106b81:	83 c4 10             	add    $0x10,%esp
  106b84:	81 fe 00 04 00 00    	cmp    $0x400,%esi
  106b8a:	75 dc                	jne    106b68 <pdir_init+0x38>
    for (proc_index = 0; proc_index < NUM_IDS; proc_index++) {
  106b8c:	83 c7 01             	add    $0x1,%edi
  106b8f:	83 ff 40             	cmp    $0x40,%edi
  106b92:	75 bc                	jne    106b50 <pdir_init+0x20>
            }
        }
    }
}
  106b94:	5b                   	pop    %ebx
  106b95:	5e                   	pop    %esi
  106b96:	5f                   	pop    %edi
  106b97:	c3                   	ret
  106b98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106b9f:	00 

00106ba0 <alloc_ptbl>:
 * and clears (set to 0) all page table entries for this newly mapped page table.
 * It returns the page index of the newly allocated physical page.
 * In the case when there's no physical page available, it returns 0.
 */
unsigned int alloc_ptbl(unsigned int proc_index, unsigned int vaddr)
{
  106ba0:	55                   	push   %ebp
  106ba1:	57                   	push   %edi
  106ba2:	56                   	push   %esi
  106ba3:	53                   	push   %ebx
  106ba4:	e8 f9 97 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106ba9:	81 c3 4b a4 00 00    	add    $0xa44b,%ebx
  106baf:	83 ec 28             	sub    $0x28,%esp
  106bb2:	8b 74 24 3c          	mov    0x3c(%esp),%esi
    unsigned int page_index = container_alloc(proc_index);
  106bb6:	56                   	push   %esi
  106bb7:	e8 d4 fa ff ff       	call   106690 <container_alloc>
  106bbc:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    unsigned int pde_index = PDE_ADDR(vaddr);
    unsigned int pte_index;

    if (page_index == 0) {
  106bc0:	83 c4 10             	add    $0x10,%esp
  106bc3:	85 c0                	test   %eax,%eax
  106bc5:	75 0c                	jne    106bd3 <alloc_ptbl+0x33>
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
        }

        return page_index;
    }
}
  106bc7:	8b 44 24 0c          	mov    0xc(%esp),%eax
  106bcb:	83 c4 1c             	add    $0x1c,%esp
  106bce:	5b                   	pop    %ebx
  106bcf:	5e                   	pop    %esi
  106bd0:	5f                   	pop    %edi
  106bd1:	5d                   	pop    %ebp
  106bd2:	c3                   	ret
    unsigned int pde_index = PDE_ADDR(vaddr);
  106bd3:	8b 7c 24 34          	mov    0x34(%esp),%edi
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  106bd7:	83 ec 04             	sub    $0x4,%esp
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106bda:	31 ed                	xor    %ebp,%ebp
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  106bdc:	50                   	push   %eax
  106bdd:	ff 74 24 3c          	push   0x3c(%esp)
    unsigned int pde_index = PDE_ADDR(vaddr);
  106be1:	c1 ef 16             	shr    $0x16,%edi
        set_pdir_entry_by_va(proc_index, vaddr, page_index);
  106be4:	56                   	push   %esi
  106be5:	e8 a6 fe ff ff       	call   106a90 <set_pdir_entry_by_va>
  106bea:	83 c4 10             	add    $0x10,%esp
  106bed:	8d 76 00             	lea    0x0(%esi),%esi
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
  106bf0:	83 ec 04             	sub    $0x4,%esp
  106bf3:	55                   	push   %ebp
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106bf4:	83 c5 01             	add    $0x1,%ebp
            rmv_ptbl_entry(proc_index, pde_index, pte_index);
  106bf7:	57                   	push   %edi
  106bf8:	56                   	push   %esi
  106bf9:	e8 02 fd ff ff       	call   106900 <rmv_ptbl_entry>
        for (pte_index = 0; pte_index < 1024; pte_index++) {
  106bfe:	83 c4 10             	add    $0x10,%esp
  106c01:	81 fd 00 04 00 00    	cmp    $0x400,%ebp
  106c07:	75 e7                	jne    106bf0 <alloc_ptbl+0x50>
}
  106c09:	8b 44 24 0c          	mov    0xc(%esp),%eax
  106c0d:	83 c4 1c             	add    $0x1c,%esp
  106c10:	5b                   	pop    %ebx
  106c11:	5e                   	pop    %esi
  106c12:	5f                   	pop    %edi
  106c13:	5d                   	pop    %ebp
  106c14:	c3                   	ret
  106c15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106c1c:	00 
  106c1d:	8d 76 00             	lea    0x0(%esi),%esi

00106c20 <free_ptbl>:

// Reverse operation of alloc_ptbl.
// Removes corresponding the page directory entry,
// and frees the page for the page table entries (with container_free).
void free_ptbl(unsigned int proc_index, unsigned int vaddr)
{
  106c20:	55                   	push   %ebp
  106c21:	57                   	push   %edi
  106c22:	56                   	push   %esi
  106c23:	53                   	push   %ebx
  106c24:	e8 79 97 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106c29:	81 c3 cb a3 00 00    	add    $0xa3cb,%ebx
  106c2f:	83 ec 14             	sub    $0x14,%esp
  106c32:	8b 6c 24 28          	mov    0x28(%esp),%ebp
  106c36:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  106c3a:	57                   	push   %edi

    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106c3b:	c1 ef 16             	shr    $0x16,%edi
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  106c3e:	55                   	push   %ebp
  106c3f:	e8 4c fd ff ff       	call   106990 <get_pdir_entry_by_va>
  106c44:	89 c6                	mov    %eax,%esi
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106c46:	58                   	pop    %eax
  106c47:	5a                   	pop    %edx
  106c48:	57                   	push   %edi
  106c49:	55                   	push   %ebp
    unsigned int page_index = get_pdir_entry_by_va(proc_index, vaddr) >> 12;
  106c4a:	c1 ee 0c             	shr    $0xc,%esi
    rmv_pdir_entry(proc_index, PDE_ADDR(vaddr));
  106c4d:	e8 de fb ff ff       	call   106830 <rmv_pdir_entry>
    container_free(proc_index, page_index);
  106c52:	59                   	pop    %ecx
  106c53:	5f                   	pop    %edi
  106c54:	56                   	push   %esi
  106c55:	55                   	push   %ebp
  106c56:	e8 a5 fa ff ff       	call   106700 <container_free>
}
  106c5b:	83 c4 1c             	add    $0x1c,%esp
  106c5e:	5b                   	pop    %ebx
  106c5f:	5e                   	pop    %esi
  106c60:	5f                   	pop    %edi
  106c61:	5d                   	pop    %ebp
  106c62:	c3                   	ret
  106c63:	66 90                	xchg   %ax,%ax
  106c65:	66 90                	xchg   %ax,%ax
  106c67:	66 90                	xchg   %ax,%ax
  106c69:	66 90                	xchg   %ax,%ax
  106c6b:	66 90                	xchg   %ax,%ax
  106c6d:	66 90                	xchg   %ax,%ax
  106c6f:	90                   	nop

00106c70 <pdir_init_kern>:
/**
 * Sets the entire page map for process 0 as the identity map.
 * Note that part of the task is already completed by pdir_init.
 */
void pdir_init_kern(unsigned int mbi_addr)
{
  106c70:	56                   	push   %esi
    unsigned int pde_index;

    pdir_init(mbi_addr);

    // Set identity map for user PDEs
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  106c71:	be 00 01 00 00       	mov    $0x100,%esi
{
  106c76:	53                   	push   %ebx
  106c77:	e8 26 97 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106c7c:	81 c3 78 a3 00 00    	add    $0xa378,%ebx
  106c82:	83 ec 10             	sub    $0x10,%esp
    pdir_init(mbi_addr);
  106c85:	ff 74 24 1c          	push   0x1c(%esp)
  106c89:	e8 a2 fe ff ff       	call   106b30 <pdir_init>
  106c8e:	83 c4 10             	add    $0x10,%esp
  106c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        set_pdir_entry_identity(0, pde_index);
  106c98:	83 ec 08             	sub    $0x8,%esp
  106c9b:	56                   	push   %esi
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  106c9c:	83 c6 01             	add    $0x1,%esi
        set_pdir_entry_identity(0, pde_index);
  106c9f:	6a 00                	push   $0x0
  106ca1:	e8 5a fb ff ff       	call   106800 <set_pdir_entry_identity>
    for (pde_index = VM_USERLO_PDE; pde_index < VM_USERHI_PDE; pde_index++) {
  106ca6:	83 c4 10             	add    $0x10,%esp
  106ca9:	81 fe c0 03 00 00    	cmp    $0x3c0,%esi
  106caf:	75 e7                	jne    106c98 <pdir_init_kern+0x28>
    }
}
  106cb1:	83 c4 04             	add    $0x4,%esp
  106cb4:	5b                   	pop    %ebx
  106cb5:	5e                   	pop    %esi
  106cb6:	c3                   	ret
  106cb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106cbe:	00 
  106cbf:	90                   	nop

00106cc0 <map_page>:
 * otherwise, it returns the physical page index registered in the page directory,
 * (the return value of get_pdir_entry_by_va or alloc_ptbl).
 */
unsigned int map_page(unsigned int proc_index, unsigned int vaddr,
                      unsigned int page_index, unsigned int perm)
{
  106cc0:	55                   	push   %ebp
  106cc1:	57                   	push   %edi
  106cc2:	56                   	push   %esi
  106cc3:	53                   	push   %ebx
  106cc4:	e8 d9 96 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106cc9:	81 c3 2b a3 00 00    	add    $0xa32b,%ebx
  106ccf:	83 ec 14             	sub    $0x14,%esp
  106cd2:	8b 7c 24 28          	mov    0x28(%esp),%edi
  106cd6:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
    unsigned int pde_entry = get_pdir_entry_by_va(proc_index, vaddr);
  106cda:	55                   	push   %ebp
  106cdb:	57                   	push   %edi
  106cdc:	e8 af fc ff ff       	call   106990 <get_pdir_entry_by_va>
    unsigned int pde_page_index = pde_entry >> 12;

    if (pde_entry == 0) {
  106ce1:	83 c4 10             	add    $0x10,%esp
  106ce4:	85 c0                	test   %eax,%eax
  106ce6:	74 28                	je     106d10 <map_page+0x50>
    unsigned int pde_page_index = pde_entry >> 12;
  106ce8:	c1 e8 0c             	shr    $0xc,%eax
  106ceb:	89 c6                	mov    %eax,%esi
        if (pde_page_index == 0) {
            return MagicNumber;
        }
    }

    set_ptbl_entry_by_va(proc_index, vaddr, page_index, perm);
  106ced:	ff 74 24 2c          	push   0x2c(%esp)
  106cf1:	ff 74 24 2c          	push   0x2c(%esp)
  106cf5:	55                   	push   %ebp
  106cf6:	57                   	push   %edi
  106cf7:	e8 54 fd ff ff       	call   106a50 <set_ptbl_entry_by_va>
    return pde_page_index;
  106cfc:	83 c4 10             	add    $0x10,%esp
}
  106cff:	89 f0                	mov    %esi,%eax
  106d01:	83 c4 0c             	add    $0xc,%esp
  106d04:	5b                   	pop    %ebx
  106d05:	5e                   	pop    %esi
  106d06:	5f                   	pop    %edi
  106d07:	5d                   	pop    %ebp
  106d08:	c3                   	ret
  106d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pde_page_index = alloc_ptbl(proc_index, vaddr);
  106d10:	83 ec 08             	sub    $0x8,%esp
  106d13:	55                   	push   %ebp
  106d14:	57                   	push   %edi
  106d15:	e8 86 fe ff ff       	call   106ba0 <alloc_ptbl>
        if (pde_page_index == 0) {
  106d1a:	83 c4 10             	add    $0x10,%esp
        pde_page_index = alloc_ptbl(proc_index, vaddr);
  106d1d:	89 c6                	mov    %eax,%esi
        if (pde_page_index == 0) {
  106d1f:	85 c0                	test   %eax,%eax
  106d21:	75 ca                	jne    106ced <map_page+0x2d>
}
  106d23:	83 c4 0c             	add    $0xc,%esp
            return MagicNumber;
  106d26:	be 01 00 10 00       	mov    $0x100001,%esi
}
  106d2b:	5b                   	pop    %ebx
  106d2c:	89 f0                	mov    %esi,%eax
  106d2e:	5e                   	pop    %esi
  106d2f:	5f                   	pop    %edi
  106d30:	5d                   	pop    %ebp
  106d31:	c3                   	ret
  106d32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106d39:	00 
  106d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106d40 <unmap_page>:
 * Nothing should be done if the mapping no longer exists.
 * You do not need to unmap the page table from the page directory.
 * It should return the corresponding page table entry.
 */
unsigned int unmap_page(unsigned int proc_index, unsigned int vaddr)
{
  106d40:	55                   	push   %ebp
  106d41:	57                   	push   %edi
  106d42:	53                   	push   %ebx
  106d43:	e8 5a 96 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106d48:	81 c3 ac a2 00 00    	add    $0xa2ac,%ebx
  106d4e:	83 ec 18             	sub    $0x18,%esp
  106d51:	8b 7c 24 28          	mov    0x28(%esp),%edi
  106d55:	8b 6c 24 2c          	mov    0x2c(%esp),%ebp
    unsigned int pte_entry = get_ptbl_entry_by_va(proc_index, vaddr);
  106d59:	55                   	push   %ebp
  106d5a:	57                   	push   %edi
  106d5b:	e8 d0 fb ff ff       	call   106930 <get_ptbl_entry_by_va>
    if (pte_entry != 0) {
  106d60:	83 c4 10             	add    $0x10,%esp
  106d63:	85 c0                	test   %eax,%eax
  106d65:	75 09                	jne    106d70 <unmap_page+0x30>
        rmv_ptbl_entry_by_va(proc_index, vaddr);
    }
    return pte_entry;
}
  106d67:	83 c4 10             	add    $0x10,%esp
  106d6a:	5b                   	pop    %ebx
  106d6b:	5f                   	pop    %edi
  106d6c:	5d                   	pop    %ebp
  106d6d:	c3                   	ret
  106d6e:	66 90                	xchg   %ax,%ax
  106d70:	89 44 24 0c          	mov    %eax,0xc(%esp)
        rmv_ptbl_entry_by_va(proc_index, vaddr);
  106d74:	83 ec 08             	sub    $0x8,%esp
  106d77:	55                   	push   %ebp
  106d78:	57                   	push   %edi
  106d79:	e8 42 fc ff ff       	call   1069c0 <rmv_ptbl_entry_by_va>
  106d7e:	83 c4 10             	add    $0x10,%esp
  106d81:	8b 44 24 0c          	mov    0xc(%esp),%eax
}
  106d85:	83 c4 10             	add    $0x10,%esp
  106d88:	5b                   	pop    %ebx
  106d89:	5f                   	pop    %edi
  106d8a:	5d                   	pop    %ebp
  106d8b:	c3                   	ret
  106d8c:	66 90                	xchg   %ax,%ax
  106d8e:	66 90                	xchg   %ax,%ax

00106d90 <paging_init>:
/**
 * Initializes the page structures, moves to the kernel page structure (0),
 * and turns on the paging.
 */
void paging_init(unsigned int mbi_addr)
{
  106d90:	53                   	push   %ebx
  106d91:	e8 0c 96 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106d96:	81 c3 5e a2 00 00    	add    $0xa25e,%ebx
  106d9c:	83 ec 14             	sub    $0x14,%esp
    pdir_init_kern(mbi_addr);
  106d9f:	ff 74 24 1c          	push   0x1c(%esp)
  106da3:	e8 c8 fe ff ff       	call   106c70 <pdir_init_kern>
    set_pdir_base(0);
  106da8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  106daf:	e8 cc f9 ff ff       	call   106780 <set_pdir_base>
    enable_paging();
  106db4:	e8 87 a4 ff ff       	call   101240 <enable_paging>
}
  106db9:	83 c4 18             	add    $0x18,%esp
  106dbc:	5b                   	pop    %ebx
  106dbd:	c3                   	ret
  106dbe:	66 90                	xchg   %ax,%ax

00106dc0 <paging_init_ap>:

void paging_init_ap(void)
{
  106dc0:	53                   	push   %ebx
  106dc1:	e8 dc 95 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106dc6:	81 c3 2e a2 00 00    	add    $0xa22e,%ebx
  106dcc:	83 ec 14             	sub    $0x14,%esp
    set_pdir_base(0);
  106dcf:	6a 00                	push   $0x0
  106dd1:	e8 aa f9 ff ff       	call   106780 <set_pdir_base>
    enable_paging();
  106dd6:	e8 65 a4 ff ff       	call   101240 <enable_paging>
}
  106ddb:	83 c4 18             	add    $0x18,%esp
  106dde:	5b                   	pop    %ebx
  106ddf:	c3                   	ret

00106de0 <alloc_page>:
 * return value from map_page.
 * In the case of error, it should return the constant MagicNumber.
 */
unsigned int alloc_page(unsigned int proc_index, unsigned int vaddr,
                        unsigned int perm)
{
  106de0:	56                   	push   %esi
  106de1:	53                   	push   %ebx
  106de2:	e8 bb 95 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106de7:	81 c3 0d a2 00 00    	add    $0xa20d,%ebx
  106ded:	83 ec 10             	sub    $0x10,%esp
  106df0:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    unsigned int page_index = container_alloc(proc_index);
  106df4:	56                   	push   %esi
  106df5:	e8 96 f8 ff ff       	call   106690 <container_alloc>
    if (page_index != 0) {
  106dfa:	83 c4 10             	add    $0x10,%esp
  106dfd:	ba 01 00 10 00       	mov    $0x100001,%edx
  106e02:	85 c0                	test   %eax,%eax
  106e04:	74 14                	je     106e1a <alloc_page+0x3a>
        return map_page(proc_index, vaddr, page_index, perm);
  106e06:	ff 74 24 18          	push   0x18(%esp)
  106e0a:	50                   	push   %eax
  106e0b:	ff 74 24 1c          	push   0x1c(%esp)
  106e0f:	56                   	push   %esi
  106e10:	e8 ab fe ff ff       	call   106cc0 <map_page>
  106e15:	83 c4 10             	add    $0x10,%esp
  106e18:	89 c2                	mov    %eax,%edx
    } else {
        return MagicNumber;
    }
}
  106e1a:	83 c4 04             	add    $0x4,%esp
  106e1d:	89 d0                	mov    %edx,%eax
  106e1f:	5b                   	pop    %ebx
  106e20:	5e                   	pop    %esi
  106e21:	c3                   	ret
  106e22:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106e29:	00 
  106e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106e30 <alloc_mem_quota>:

/**
 * Designate some memory quota for the next child process.
 */
unsigned int alloc_mem_quota(unsigned int id, unsigned int quota)
{
  106e30:	53                   	push   %ebx
  106e31:	e8 6c 95 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106e36:	81 c3 be a1 00 00    	add    $0xa1be,%ebx
  106e3c:	83 ec 10             	sub    $0x10,%esp
    unsigned int child;
    child = container_split(id, quota);
  106e3f:	ff 74 24 1c          	push   0x1c(%esp)
  106e43:	ff 74 24 1c          	push   0x1c(%esp)
  106e47:	e8 a4 f7 ff ff       	call   1065f0 <container_split>
    return child;
}
  106e4c:	83 c4 18             	add    $0x18,%esp
  106e4f:	5b                   	pop    %ebx
  106e50:	c3                   	ret
  106e51:	66 90                	xchg   %ax,%ax
  106e53:	66 90                	xchg   %ax,%ax
  106e55:	66 90                	xchg   %ax,%ax
  106e57:	66 90                	xchg   %ax,%ax
  106e59:	66 90                	xchg   %ax,%ax
  106e5b:	66 90                	xchg   %ax,%ax
  106e5d:	66 90                	xchg   %ax,%ax
  106e5f:	90                   	nop

00106e60 <kctx_set_esp>:
// Memory to save the NUM_IDS kernel thread states.
struct kctx kctx_pool[NUM_IDS];

void kctx_set_esp(unsigned int pid, void *esp)
{
    kctx_pool[pid].esp = esp;
  106e60:	e8 39 95 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106e65:	81 c2 8f a1 00 00    	add    $0xa18f,%edx
{
  106e6b:	8b 44 24 04          	mov    0x4(%esp),%eax
    kctx_pool[pid].esp = esp;
  106e6f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106e73:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106e76:	89 8c c2 0c 20 cb 00 	mov    %ecx,0xcb200c(%edx,%eax,8)
}
  106e7d:	c3                   	ret
  106e7e:	66 90                	xchg   %ax,%ax

00106e80 <kctx_set_eip>:

void kctx_set_eip(unsigned int pid, void *eip)
{
    kctx_pool[pid].eip = eip;
  106e80:	e8 19 95 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106e85:	81 c2 6f a1 00 00    	add    $0xa16f,%edx
{
  106e8b:	8b 44 24 04          	mov    0x4(%esp),%eax
    kctx_pool[pid].eip = eip;
  106e8f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106e93:	8d 04 40             	lea    (%eax,%eax,2),%eax
  106e96:	89 8c c2 20 20 cb 00 	mov    %ecx,0xcb2020(%edx,%eax,8)
}
  106e9d:	c3                   	ret
  106e9e:	66 90                	xchg   %ax,%ax

00106ea0 <kctx_switch>:
/**
 * Saves the states for thread # [from_pid] and restores the states
 * for thread # [to_pid].
 */
void kctx_switch(unsigned int from_pid, unsigned int to_pid)
{
  106ea0:	53                   	push   %ebx
  106ea1:	e8 fc 94 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106ea6:	81 c3 4e a1 00 00    	add    $0xa14e,%ebx
  106eac:	83 ec 10             	sub    $0x10,%esp
  106eaf:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  106eb3:	8b 54 24 18          	mov    0x18(%esp),%edx
    cswitch(&kctx_pool[from_pid], &kctx_pool[to_pid]);
  106eb7:	8d 0c 40             	lea    (%eax,%eax,2),%ecx
  106eba:	8d 14 52             	lea    (%edx,%edx,2),%edx
  106ebd:	8d 83 0c 20 cb 00    	lea    0xcb200c(%ebx),%eax
  106ec3:	8d 0c c8             	lea    (%eax,%ecx,8),%ecx
  106ec6:	8d 04 d0             	lea    (%eax,%edx,8),%eax
  106ec9:	51                   	push   %ecx
  106eca:	50                   	push   %eax
  106ecb:	e8 05 00 00 00       	call   106ed5 <cswitch>
}
  106ed0:	83 c4 18             	add    $0x18,%esp
  106ed3:	5b                   	pop    %ebx
  106ed4:	c3                   	ret

00106ed5 <cswitch>:
/*
 * void cswitch(struct kctx *from, struct kctx *to);
 */
	.globl cswitch
cswitch:
	movl	4(%esp), %eax	/* %eax <- from */
  106ed5:	8b 44 24 04          	mov    0x4(%esp),%eax
	movl	8(%esp), %edx	/* %edx <- to */
  106ed9:	8b 54 24 08          	mov    0x8(%esp),%edx

	/* save the old kernel context */
	movl	0(%esp), %ecx
  106edd:	8b 0c 24             	mov    (%esp),%ecx
	movl	%ecx, 20(%eax)
  106ee0:	89 48 14             	mov    %ecx,0x14(%eax)
	movl	%ebp, 16(%eax)
  106ee3:	89 68 10             	mov    %ebp,0x10(%eax)
	movl	%ebx, 12(%eax)
  106ee6:	89 58 0c             	mov    %ebx,0xc(%eax)
	movl	%esi, 8(%eax)
  106ee9:	89 70 08             	mov    %esi,0x8(%eax)
	movl	%edi, 4(%eax)
  106eec:	89 78 04             	mov    %edi,0x4(%eax)
	movl	%esp, 0(%eax)
  106eef:	89 20                	mov    %esp,(%eax)

	/* load the new kernel context */
	movl	0(%edx), %esp
  106ef1:	8b 22                	mov    (%edx),%esp
	movl	4(%edx), %edi
  106ef3:	8b 7a 04             	mov    0x4(%edx),%edi
	movl	8(%edx), %esi
  106ef6:	8b 72 08             	mov    0x8(%edx),%esi
	movl	12(%edx), %ebx
  106ef9:	8b 5a 0c             	mov    0xc(%edx),%ebx
	movl	16(%edx), %ebp
  106efc:	8b 6a 10             	mov    0x10(%edx),%ebp
	movl	20(%edx), %ecx
  106eff:	8b 4a 14             	mov    0x14(%edx),%ecx
	movl	%ecx, 0(%esp)
  106f02:	89 0c 24             	mov    %ecx,(%esp)

	xor	%eax, %eax
  106f05:	31 c0                	xor    %eax,%eax
	ret
  106f07:	c3                   	ret
  106f08:	66 90                	xchg   %ax,%ax
  106f0a:	66 90                	xchg   %ax,%ax
  106f0c:	66 90                	xchg   %ax,%ax
  106f0e:	66 90                	xchg   %ax,%ax

00106f10 <kctx_new>:
 * Don't forget the stack is going down from high address to low.
 * We do not care about the rest of states when a new thread starts.
 * The function returns the child thread (process) id.
 */
unsigned int kctx_new(void *entry, unsigned int id, unsigned int quota)
{
  106f10:	55                   	push   %ebp
  106f11:	57                   	push   %edi
  106f12:	56                   	push   %esi
    unsigned int pid = NUM_IDS;
  106f13:	be 40 00 00 00       	mov    $0x40,%esi
{
  106f18:	53                   	push   %ebx
  106f19:	e8 84 94 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  106f1e:	81 c3 d6 a0 00 00    	add    $0xa0d6,%ebx
  106f24:	83 ec 14             	sub    $0x14,%esp
  106f27:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  106f2b:	8b 6c 24 30          	mov    0x30(%esp),%ebp

    if (container_can_consume(id, quota)) {
  106f2f:	55                   	push   %ebp
  106f30:	57                   	push   %edi
  106f31:	e8 8a f6 ff ff       	call   1065c0 <container_can_consume>
  106f36:	83 c4 10             	add    $0x10,%esp
  106f39:	85 c0                	test   %eax,%eax
  106f3b:	75 13                	jne    106f50 <kctx_new+0x40>
            kctx_set_eip(pid, entry);
        }
    }

    return pid;
}
  106f3d:	83 c4 0c             	add    $0xc,%esp
  106f40:	89 f0                	mov    %esi,%eax
  106f42:	5b                   	pop    %ebx
  106f43:	5e                   	pop    %esi
  106f44:	5f                   	pop    %edi
  106f45:	5d                   	pop    %ebp
  106f46:	c3                   	ret
  106f47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  106f4e:	00 
  106f4f:	90                   	nop
        pid = alloc_mem_quota(id, quota);
  106f50:	83 ec 08             	sub    $0x8,%esp
  106f53:	55                   	push   %ebp
  106f54:	57                   	push   %edi
  106f55:	e8 d6 fe ff ff       	call   106e30 <alloc_mem_quota>
        if (pid != NUM_IDS) {
  106f5a:	83 c4 10             	add    $0x10,%esp
        pid = alloc_mem_quota(id, quota);
  106f5d:	89 c6                	mov    %eax,%esi
        if (pid != NUM_IDS) {
  106f5f:	83 f8 40             	cmp    $0x40,%eax
  106f62:	74 d9                	je     106f3d <kctx_new+0x2d>
            kctx_set_esp(pid, proc_kstack[pid].kstack_hi);
  106f64:	8d 40 01             	lea    0x1(%eax),%eax
  106f67:	83 ec 08             	sub    $0x8,%esp
  106f6a:	c1 e0 0c             	shl    $0xc,%eax
  106f6d:	81 c0 00 a0 13 00    	add    $0x13a000,%eax
  106f73:	50                   	push   %eax
  106f74:	56                   	push   %esi
  106f75:	e8 e6 fe ff ff       	call   106e60 <kctx_set_esp>
            kctx_set_eip(pid, entry);
  106f7a:	58                   	pop    %eax
  106f7b:	5a                   	pop    %edx
  106f7c:	ff 74 24 28          	push   0x28(%esp)
  106f80:	56                   	push   %esi
  106f81:	e8 fa fe ff ff       	call   106e80 <kctx_set_eip>
  106f86:	83 c4 10             	add    $0x10,%esp
}
  106f89:	89 f0                	mov    %esi,%eax
  106f8b:	83 c4 0c             	add    $0xc,%esp
  106f8e:	5b                   	pop    %ebx
  106f8f:	5e                   	pop    %esi
  106f90:	5f                   	pop    %edi
  106f91:	5d                   	pop    %ebp
  106f92:	c3                   	ret
  106f93:	66 90                	xchg   %ax,%ax
  106f95:	66 90                	xchg   %ax,%ax
  106f97:	66 90                	xchg   %ax,%ax
  106f99:	66 90                	xchg   %ax,%ax
  106f9b:	66 90                	xchg   %ax,%ax
  106f9d:	66 90                	xchg   %ax,%ax
  106f9f:	90                   	nop

00106fa0 <tcb_get_state>:

struct TCB TCBPool[NUM_IDS];

unsigned int tcb_get_state(unsigned int pid)
{
    return TCBPool[pid].state;
  106fa0:	e8 f9 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106fa5:	81 c2 4f a0 00 00    	add    $0xa04f,%edx
  106fab:	8b 44 24 04          	mov    0x4(%esp),%eax
  106faf:	c1 e0 04             	shl    $0x4,%eax
  106fb2:	8b 84 02 0c 26 cb 00 	mov    0xcb260c(%edx,%eax,1),%eax
}
  106fb9:	c3                   	ret
  106fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00106fc0 <tcb_set_state>:

void tcb_set_state(unsigned int pid, unsigned int state)
{
    TCBPool[pid].state = state;
  106fc0:	e8 d9 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106fc5:	81 c2 2f a0 00 00    	add    $0xa02f,%edx
  106fcb:	8b 44 24 04          	mov    0x4(%esp),%eax
  106fcf:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  106fd3:	c1 e0 04             	shl    $0x4,%eax
  106fd6:	89 8c 02 0c 26 cb 00 	mov    %ecx,0xcb260c(%edx,%eax,1)
}
  106fdd:	c3                   	ret
  106fde:	66 90                	xchg   %ax,%ax

00106fe0 <tcb_get_cpu>:

unsigned int tcb_get_cpu(unsigned int pid)
{
    return TCBPool[pid].cpuid;
  106fe0:	e8 b9 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  106fe5:	81 c2 0f a0 00 00    	add    $0xa00f,%edx
  106feb:	8b 44 24 04          	mov    0x4(%esp),%eax
  106fef:	c1 e0 04             	shl    $0x4,%eax
  106ff2:	8b 84 02 10 26 cb 00 	mov    0xcb2610(%edx,%eax,1),%eax
}
  106ff9:	c3                   	ret
  106ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107000 <tcb_set_cpu>:

void tcb_set_cpu(unsigned int pid, unsigned int cpu)
{
    TCBPool[pid].cpuid = cpu;
  107000:	e8 99 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  107005:	81 c2 ef 9f 00 00    	add    $0x9fef,%edx
  10700b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10700f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107013:	c1 e0 04             	shl    $0x4,%eax
  107016:	89 8c 02 10 26 cb 00 	mov    %ecx,0xcb2610(%edx,%eax,1)
}
  10701d:	c3                   	ret
  10701e:	66 90                	xchg   %ax,%ax

00107020 <tcb_get_prev>:

unsigned int tcb_get_prev(unsigned int pid)
{
    return TCBPool[pid].prev;
  107020:	e8 79 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  107025:	81 c2 cf 9f 00 00    	add    $0x9fcf,%edx
  10702b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10702f:	c1 e0 04             	shl    $0x4,%eax
  107032:	8b 84 02 14 26 cb 00 	mov    0xcb2614(%edx,%eax,1),%eax
}
  107039:	c3                   	ret
  10703a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107040 <tcb_set_prev>:

void tcb_set_prev(unsigned int pid, unsigned int prev_pid)
{
    TCBPool[pid].prev = prev_pid;
  107040:	e8 59 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  107045:	81 c2 af 9f 00 00    	add    $0x9faf,%edx
  10704b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10704f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107053:	c1 e0 04             	shl    $0x4,%eax
  107056:	89 8c 02 14 26 cb 00 	mov    %ecx,0xcb2614(%edx,%eax,1)
}
  10705d:	c3                   	ret
  10705e:	66 90                	xchg   %ax,%ax

00107060 <tcb_get_next>:

unsigned int tcb_get_next(unsigned int pid)
{
    return TCBPool[pid].next;
  107060:	e8 39 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  107065:	81 c2 8f 9f 00 00    	add    $0x9f8f,%edx
  10706b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10706f:	c1 e0 04             	shl    $0x4,%eax
  107072:	8b 84 02 18 26 cb 00 	mov    0xcb2618(%edx,%eax,1),%eax
}
  107079:	c3                   	ret
  10707a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107080 <tcb_set_next>:

void tcb_set_next(unsigned int pid, unsigned int next_pid)
{
    TCBPool[pid].next = next_pid;
  107080:	e8 19 93 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  107085:	81 c2 6f 9f 00 00    	add    $0x9f6f,%edx
  10708b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10708f:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107093:	c1 e0 04             	shl    $0x4,%eax
  107096:	89 8c 02 18 26 cb 00 	mov    %ecx,0xcb2618(%edx,%eax,1)
}
  10709d:	c3                   	ret
  10709e:	66 90                	xchg   %ax,%ax

001070a0 <tcb_init_at_id>:

void tcb_init_at_id(unsigned int pid)
{
    TCBPool[pid].state = TSTATE_DEAD;
  1070a0:	e8 f9 92 ff ff       	call   10039e <__x86.get_pc_thunk.dx>
  1070a5:	81 c2 4f 9f 00 00    	add    $0x9f4f,%edx
  1070ab:	8b 44 24 04          	mov    0x4(%esp),%eax
  1070af:	c1 e0 04             	shl    $0x4,%eax
  1070b2:	c7 84 02 0c 26 cb 00 	movl   $0x3,0xcb260c(%edx,%eax,1)
  1070b9:	03 00 00 00 
    TCBPool[pid].cpuid = NUM_CPUS;
  1070bd:	8d 84 02 0c 26 cb 00 	lea    0xcb260c(%edx,%eax,1),%eax
  1070c4:	c7 40 04 08 00 00 00 	movl   $0x8,0x4(%eax)
    TCBPool[pid].prev = NUM_IDS;
  1070cb:	c7 40 08 40 00 00 00 	movl   $0x40,0x8(%eax)
    TCBPool[pid].next = NUM_IDS;
  1070d2:	c7 40 0c 40 00 00 00 	movl   $0x40,0xc(%eax)
}
  1070d9:	c3                   	ret
  1070da:	66 90                	xchg   %ax,%ax
  1070dc:	66 90                	xchg   %ax,%ax
  1070de:	66 90                	xchg   %ax,%ax

001070e0 <tcb_init>:
/**
 * Initializes the TCB for all NUM_IDS threads with the state TSTATE_DEAD,
 * and with two indices being NUM_IDS (which represents NULL).
 */
void tcb_init(unsigned int mbi_addr)
{
  1070e0:	56                   	push   %esi
    unsigned int pid = 0;
  1070e1:	31 f6                	xor    %esi,%esi
{
  1070e3:	53                   	push   %ebx
  1070e4:	e8 b9 92 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1070e9:	81 c3 0b 9f 00 00    	add    $0x9f0b,%ebx
  1070ef:	83 ec 10             	sub    $0x10,%esp
    paging_init(mbi_addr);
  1070f2:	ff 74 24 1c          	push   0x1c(%esp)
  1070f6:	e8 95 fc ff ff       	call   106d90 <paging_init>
  1070fb:	83 c4 10             	add    $0x10,%esp
  1070fe:	66 90                	xchg   %ax,%ax

    while (pid < NUM_IDS) {
        tcb_init_at_id(pid);
  107100:	83 ec 0c             	sub    $0xc,%esp
  107103:	56                   	push   %esi
        pid++;
  107104:	83 c6 01             	add    $0x1,%esi
        tcb_init_at_id(pid);
  107107:	e8 94 ff ff ff       	call   1070a0 <tcb_init_at_id>
    while (pid < NUM_IDS) {
  10710c:	83 c4 10             	add    $0x10,%esp
  10710f:	83 fe 40             	cmp    $0x40,%esi
  107112:	75 ec                	jne    107100 <tcb_init+0x20>
    }
}
  107114:	83 c4 04             	add    $0x4,%esp
  107117:	5b                   	pop    %ebx
  107118:	5e                   	pop    %esi
  107119:	c3                   	ret
  10711a:	66 90                	xchg   %ax,%ax
  10711c:	66 90                	xchg   %ax,%ax
  10711e:	66 90                	xchg   %ax,%ax

00107120 <tqueue_get_head>:
 */
struct TQueue TQueuePool[NUM_IDS + NUM_CPUS];

unsigned int tqueue_get_head(unsigned int chid)
{
    return TQueuePool[chid].head;
  107120:	e8 75 92 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  107125:	05 cf 9e 00 00       	add    $0x9ecf,%eax
  10712a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10712e:	8b 84 d0 2c 2a cb 00 	mov    0xcb2a2c(%eax,%edx,8),%eax
}
  107135:	c3                   	ret
  107136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10713d:	00 
  10713e:	66 90                	xchg   %ax,%ax

00107140 <tqueue_set_head>:

void tqueue_set_head(unsigned int chid, unsigned int head)
{
    TQueuePool[chid].head = head;
  107140:	e8 55 92 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  107145:	05 af 9e 00 00       	add    $0x9eaf,%eax
  10714a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10714e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107152:	89 8c d0 2c 2a cb 00 	mov    %ecx,0xcb2a2c(%eax,%edx,8)
}
  107159:	c3                   	ret
  10715a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107160 <tqueue_get_tail>:

unsigned int tqueue_get_tail(unsigned int chid)
{
    return TQueuePool[chid].tail;
  107160:	e8 35 92 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  107165:	05 8f 9e 00 00       	add    $0x9e8f,%eax
  10716a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10716e:	8b 84 d0 30 2a cb 00 	mov    0xcb2a30(%eax,%edx,8),%eax
}
  107175:	c3                   	ret
  107176:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10717d:	00 
  10717e:	66 90                	xchg   %ax,%ax

00107180 <tqueue_set_tail>:

void tqueue_set_tail(unsigned int chid, unsigned int tail)
{
    TQueuePool[chid].tail = tail;
  107180:	e8 15 92 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  107185:	05 6f 9e 00 00       	add    $0x9e6f,%eax
  10718a:	8b 54 24 04          	mov    0x4(%esp),%edx
  10718e:	8b 4c 24 08          	mov    0x8(%esp),%ecx
  107192:	89 8c d0 30 2a cb 00 	mov    %ecx,0xcb2a30(%eax,%edx,8)
}
  107199:	c3                   	ret
  10719a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001071a0 <tqueue_init_at_id>:

void tqueue_init_at_id(unsigned int chid)
{
    TQueuePool[chid].head = NUM_IDS;
  1071a0:	e8 f5 91 ff ff       	call   10039a <__x86.get_pc_thunk.ax>
  1071a5:	05 4f 9e 00 00       	add    $0x9e4f,%eax
{
  1071aa:	8b 54 24 04          	mov    0x4(%esp),%edx
    TQueuePool[chid].head = NUM_IDS;
  1071ae:	c7 84 d0 2c 2a cb 00 	movl   $0x40,0xcb2a2c(%eax,%edx,8)
  1071b5:	40 00 00 00 
    TQueuePool[chid].tail = NUM_IDS;
  1071b9:	c7 84 d0 30 2a cb 00 	movl   $0x40,0xcb2a30(%eax,%edx,8)
  1071c0:	40 00 00 00 
}
  1071c4:	c3                   	ret
  1071c5:	66 90                	xchg   %ax,%ax
  1071c7:	66 90                	xchg   %ax,%ax
  1071c9:	66 90                	xchg   %ax,%ax
  1071cb:	66 90                	xchg   %ax,%ax
  1071cd:	66 90                	xchg   %ax,%ax
  1071cf:	90                   	nop

001071d0 <tqueue_init>:

/**
 * Initializes all the thread queues with tqueue_init_at_id.
 */
void tqueue_init(unsigned int mbi_addr)
{
  1071d0:	56                   	push   %esi
    unsigned int cpu_idx, chid;
    tcb_init(mbi_addr);

    chid = 0;
  1071d1:	31 f6                	xor    %esi,%esi
{
  1071d3:	53                   	push   %ebx
  1071d4:	e8 c9 91 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1071d9:	81 c3 1b 9e 00 00    	add    $0x9e1b,%ebx
  1071df:	83 ec 10             	sub    $0x10,%esp
    tcb_init(mbi_addr);
  1071e2:	ff 74 24 1c          	push   0x1c(%esp)
  1071e6:	e8 f5 fe ff ff       	call   1070e0 <tcb_init>
  1071eb:	83 c4 10             	add    $0x10,%esp
  1071ee:	66 90                	xchg   %ax,%ax
    while (chid < NUM_IDS + NUM_CPUS) {
        tqueue_init_at_id(chid);
  1071f0:	83 ec 0c             	sub    $0xc,%esp
  1071f3:	56                   	push   %esi
        chid++;
  1071f4:	83 c6 01             	add    $0x1,%esi
        tqueue_init_at_id(chid);
  1071f7:	e8 a4 ff ff ff       	call   1071a0 <tqueue_init_at_id>
    while (chid < NUM_IDS + NUM_CPUS) {
  1071fc:	83 c4 10             	add    $0x10,%esp
  1071ff:	83 fe 48             	cmp    $0x48,%esi
  107202:	75 ec                	jne    1071f0 <tqueue_init+0x20>
    }
}
  107204:	83 c4 04             	add    $0x4,%esp
  107207:	5b                   	pop    %ebx
  107208:	5e                   	pop    %esi
  107209:	c3                   	ret
  10720a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107210 <tqueue_enqueue>:
 * Recall that the doubly linked list is index based.
 * So you only need to insert the index.
 * Hint: there are multiple cases in this function.
 */
void tqueue_enqueue(unsigned int chid, unsigned int pid)
{
  107210:	55                   	push   %ebp
  107211:	57                   	push   %edi
  107212:	56                   	push   %esi
  107213:	53                   	push   %ebx
  107214:	e8 89 91 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107219:	81 c3 db 9d 00 00    	add    $0x9ddb,%ebx
  10721f:	83 ec 18             	sub    $0x18,%esp
  107222:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
  107226:	8b 74 24 30          	mov    0x30(%esp),%esi
    unsigned int tail = tqueue_get_tail(chid);
  10722a:	57                   	push   %edi
  10722b:	e8 30 ff ff ff       	call   107160 <tqueue_get_tail>

    if (tail == NUM_IDS) {
  107230:	83 c4 10             	add    $0x10,%esp
  107233:	83 f8 40             	cmp    $0x40,%eax
  107236:	74 38                	je     107270 <tqueue_enqueue+0x60>
        tcb_set_prev(pid, NUM_IDS);
        tcb_set_next(pid, NUM_IDS);
        tqueue_set_head(chid, pid);
        tqueue_set_tail(chid, pid);
    } else {
        tcb_set_next(tail, pid);
  107238:	83 ec 08             	sub    $0x8,%esp
  10723b:	89 c5                	mov    %eax,%ebp
  10723d:	56                   	push   %esi
  10723e:	50                   	push   %eax
  10723f:	e8 3c fe ff ff       	call   107080 <tcb_set_next>
        tcb_set_prev(pid, tail);
  107244:	59                   	pop    %ecx
  107245:	58                   	pop    %eax
  107246:	55                   	push   %ebp
  107247:	56                   	push   %esi
  107248:	e8 f3 fd ff ff       	call   107040 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  10724d:	58                   	pop    %eax
  10724e:	5a                   	pop    %edx
  10724f:	6a 40                	push   $0x40
  107251:	56                   	push   %esi
  107252:	e8 29 fe ff ff       	call   107080 <tcb_set_next>
        tqueue_set_tail(chid, pid);
  107257:	58                   	pop    %eax
  107258:	5a                   	pop    %edx
  107259:	56                   	push   %esi
  10725a:	57                   	push   %edi
  10725b:	e8 20 ff ff ff       	call   107180 <tqueue_set_tail>
  107260:	83 c4 10             	add    $0x10,%esp
    }
}
  107263:	83 c4 0c             	add    $0xc,%esp
  107266:	5b                   	pop    %ebx
  107267:	5e                   	pop    %esi
  107268:	5f                   	pop    %edi
  107269:	5d                   	pop    %ebp
  10726a:	c3                   	ret
  10726b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        tcb_set_prev(pid, NUM_IDS);
  107270:	83 ec 08             	sub    $0x8,%esp
  107273:	6a 40                	push   $0x40
  107275:	56                   	push   %esi
  107276:	e8 c5 fd ff ff       	call   107040 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  10727b:	59                   	pop    %ecx
  10727c:	5d                   	pop    %ebp
  10727d:	6a 40                	push   $0x40
  10727f:	56                   	push   %esi
  107280:	e8 fb fd ff ff       	call   107080 <tcb_set_next>
        tqueue_set_head(chid, pid);
  107285:	58                   	pop    %eax
  107286:	5a                   	pop    %edx
  107287:	56                   	push   %esi
  107288:	57                   	push   %edi
  107289:	e8 b2 fe ff ff       	call   107140 <tqueue_set_head>
        tqueue_set_tail(chid, pid);
  10728e:	eb c7                	jmp    107257 <tqueue_enqueue+0x47>

00107290 <tqueue_dequeue>:
 * Reverse action of tqueue_enqueue, i.e. pops a TCB from the head of the specified queue.
 * It returns the popped thread's id, or NUM_IDS if the queue is empty.
 * Hint: there are multiple cases in this function.
 */
unsigned int tqueue_dequeue(unsigned int chid)
{
  107290:	55                   	push   %ebp
  107291:	57                   	push   %edi
  107292:	56                   	push   %esi
  107293:	53                   	push   %ebx
  107294:	e8 09 91 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107299:	81 c3 5b 9d 00 00    	add    $0x9d5b,%ebx
  10729f:	83 ec 18             	sub    $0x18,%esp
  1072a2:	8b 7c 24 2c          	mov    0x2c(%esp),%edi
    unsigned int head, next, pid;

    pid = NUM_IDS;
    head = tqueue_get_head(chid);
  1072a6:	57                   	push   %edi
  1072a7:	e8 74 fe ff ff       	call   107120 <tqueue_get_head>

    if (head != NUM_IDS) {
  1072ac:	83 c4 10             	add    $0x10,%esp
    head = tqueue_get_head(chid);
  1072af:	89 c6                	mov    %eax,%esi
    if (head != NUM_IDS) {
  1072b1:	83 f8 40             	cmp    $0x40,%eax
  1072b4:	74 42                	je     1072f8 <tqueue_dequeue+0x68>
        pid = head;
        next = tcb_get_next(head);
  1072b6:	83 ec 0c             	sub    $0xc,%esp
  1072b9:	50                   	push   %eax
  1072ba:	e8 a1 fd ff ff       	call   107060 <tcb_get_next>

        if (next == NUM_IDS) {
  1072bf:	83 c4 10             	add    $0x10,%esp
        next = tcb_get_next(head);
  1072c2:	89 c5                	mov    %eax,%ebp
        if (next == NUM_IDS) {
  1072c4:	83 f8 40             	cmp    $0x40,%eax
  1072c7:	74 3f                	je     107308 <tqueue_dequeue+0x78>
            tqueue_set_head(chid, NUM_IDS);
            tqueue_set_tail(chid, NUM_IDS);
        } else {
            tcb_set_prev(next, NUM_IDS);
  1072c9:	83 ec 08             	sub    $0x8,%esp
  1072cc:	6a 40                	push   $0x40
  1072ce:	50                   	push   %eax
  1072cf:	e8 6c fd ff ff       	call   107040 <tcb_set_prev>
            tqueue_set_head(chid, next);
  1072d4:	59                   	pop    %ecx
  1072d5:	58                   	pop    %eax
  1072d6:	55                   	push   %ebp
  1072d7:	57                   	push   %edi
  1072d8:	e8 63 fe ff ff       	call   107140 <tqueue_set_head>
  1072dd:	83 c4 10             	add    $0x10,%esp
        }
        tcb_set_prev(pid, NUM_IDS);
  1072e0:	83 ec 08             	sub    $0x8,%esp
  1072e3:	6a 40                	push   $0x40
  1072e5:	56                   	push   %esi
  1072e6:	e8 55 fd ff ff       	call   107040 <tcb_set_prev>
        tcb_set_next(pid, NUM_IDS);
  1072eb:	58                   	pop    %eax
  1072ec:	5a                   	pop    %edx
  1072ed:	6a 40                	push   $0x40
  1072ef:	56                   	push   %esi
  1072f0:	e8 8b fd ff ff       	call   107080 <tcb_set_next>
  1072f5:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  1072f8:	83 c4 0c             	add    $0xc,%esp
  1072fb:	89 f0                	mov    %esi,%eax
  1072fd:	5b                   	pop    %ebx
  1072fe:	5e                   	pop    %esi
  1072ff:	5f                   	pop    %edi
  107300:	5d                   	pop    %ebp
  107301:	c3                   	ret
  107302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            tqueue_set_head(chid, NUM_IDS);
  107308:	83 ec 08             	sub    $0x8,%esp
  10730b:	6a 40                	push   $0x40
  10730d:	57                   	push   %edi
  10730e:	e8 2d fe ff ff       	call   107140 <tqueue_set_head>
            tqueue_set_tail(chid, NUM_IDS);
  107313:	58                   	pop    %eax
  107314:	5a                   	pop    %edx
  107315:	6a 40                	push   $0x40
  107317:	57                   	push   %edi
  107318:	e8 63 fe ff ff       	call   107180 <tqueue_set_tail>
  10731d:	83 c4 10             	add    $0x10,%esp
  107320:	eb be                	jmp    1072e0 <tqueue_dequeue+0x50>
  107322:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  107329:	00 
  10732a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107330 <tqueue_remove>:
/**
 * Removes the TCB #pid from the queue #chid.
 * Hint: there are many cases in this function.
 */
void tqueue_remove(unsigned int chid, unsigned int pid)
{
  107330:	55                   	push   %ebp
  107331:	57                   	push   %edi
  107332:	56                   	push   %esi
  107333:	53                   	push   %ebx
  107334:	e8 69 90 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107339:	81 c3 bb 9c 00 00    	add    $0x9cbb,%ebx
  10733f:	83 ec 18             	sub    $0x18,%esp
  107342:	8b 7c 24 30          	mov    0x30(%esp),%edi
    unsigned int prev, next;

    prev = tcb_get_prev(pid);
  107346:	57                   	push   %edi
  107347:	e8 d4 fc ff ff       	call   107020 <tcb_get_prev>
    next = tcb_get_next(pid);
  10734c:	89 3c 24             	mov    %edi,(%esp)
    prev = tcb_get_prev(pid);
  10734f:	89 c5                	mov    %eax,%ebp
    next = tcb_get_next(pid);
  107351:	e8 0a fd ff ff       	call   107060 <tcb_get_next>

    if (prev == NUM_IDS) {
  107356:	83 c4 10             	add    $0x10,%esp
    next = tcb_get_next(pid);
  107359:	89 c6                	mov    %eax,%esi
    if (prev == NUM_IDS) {
  10735b:	83 fd 40             	cmp    $0x40,%ebp
  10735e:	74 50                	je     1073b0 <tqueue_remove+0x80>
        } else {
            tcb_set_prev(next, NUM_IDS);
            tqueue_set_head(chid, next);
        }
    } else {
        if (next == NUM_IDS) {
  107360:	83 f8 40             	cmp    $0x40,%eax
  107363:	74 73                	je     1073d8 <tqueue_remove+0xa8>
            tcb_set_next(prev, NUM_IDS);
            tqueue_set_tail(chid, prev);
        } else {
            if (prev != next)
  107365:	39 c5                	cmp    %eax,%ebp
  107367:	75 2f                	jne    107398 <tqueue_remove+0x68>
                tcb_set_next(prev, next);
            tcb_set_prev(next, prev);
  107369:	83 ec 08             	sub    $0x8,%esp
  10736c:	55                   	push   %ebp
  10736d:	56                   	push   %esi
  10736e:	e8 cd fc ff ff       	call   107040 <tcb_set_prev>
  107373:	83 c4 10             	add    $0x10,%esp
        }
    }
    tcb_set_prev(pid, NUM_IDS);
  107376:	83 ec 08             	sub    $0x8,%esp
  107379:	6a 40                	push   $0x40
  10737b:	57                   	push   %edi
  10737c:	e8 bf fc ff ff       	call   107040 <tcb_set_prev>
    tcb_set_next(pid, NUM_IDS);
  107381:	58                   	pop    %eax
  107382:	5a                   	pop    %edx
  107383:	6a 40                	push   $0x40
  107385:	57                   	push   %edi
  107386:	e8 f5 fc ff ff       	call   107080 <tcb_set_next>
}
  10738b:	83 c4 1c             	add    $0x1c,%esp
  10738e:	5b                   	pop    %ebx
  10738f:	5e                   	pop    %esi
  107390:	5f                   	pop    %edi
  107391:	5d                   	pop    %ebp
  107392:	c3                   	ret
  107393:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                tcb_set_next(prev, next);
  107398:	83 ec 08             	sub    $0x8,%esp
  10739b:	50                   	push   %eax
  10739c:	55                   	push   %ebp
  10739d:	e8 de fc ff ff       	call   107080 <tcb_set_next>
  1073a2:	83 c4 10             	add    $0x10,%esp
  1073a5:	eb c2                	jmp    107369 <tqueue_remove+0x39>
  1073a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1073ae:	00 
  1073af:	90                   	nop
        if (next == NUM_IDS) {
  1073b0:	83 f8 40             	cmp    $0x40,%eax
  1073b3:	74 43                	je     1073f8 <tqueue_remove+0xc8>
            tcb_set_prev(next, NUM_IDS);
  1073b5:	83 ec 08             	sub    $0x8,%esp
  1073b8:	6a 40                	push   $0x40
  1073ba:	50                   	push   %eax
  1073bb:	e8 80 fc ff ff       	call   107040 <tcb_set_prev>
            tqueue_set_head(chid, next);
  1073c0:	5d                   	pop    %ebp
  1073c1:	58                   	pop    %eax
  1073c2:	56                   	push   %esi
  1073c3:	ff 74 24 2c          	push   0x2c(%esp)
  1073c7:	e8 74 fd ff ff       	call   107140 <tqueue_set_head>
  1073cc:	83 c4 10             	add    $0x10,%esp
  1073cf:	eb a5                	jmp    107376 <tqueue_remove+0x46>
  1073d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            tcb_set_next(prev, NUM_IDS);
  1073d8:	83 ec 08             	sub    $0x8,%esp
  1073db:	6a 40                	push   $0x40
  1073dd:	55                   	push   %ebp
  1073de:	e8 9d fc ff ff       	call   107080 <tcb_set_next>
            tqueue_set_tail(chid, prev);
  1073e3:	59                   	pop    %ecx
  1073e4:	5e                   	pop    %esi
  1073e5:	55                   	push   %ebp
  1073e6:	ff 74 24 2c          	push   0x2c(%esp)
  1073ea:	e8 91 fd ff ff       	call   107180 <tqueue_set_tail>
  1073ef:	83 c4 10             	add    $0x10,%esp
  1073f2:	eb 82                	jmp    107376 <tqueue_remove+0x46>
  1073f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            tqueue_set_head(chid, NUM_IDS);
  1073f8:	83 ec 08             	sub    $0x8,%esp
  1073fb:	6a 40                	push   $0x40
  1073fd:	ff 74 24 2c          	push   0x2c(%esp)
  107401:	e8 3a fd ff ff       	call   107140 <tqueue_set_head>
            tqueue_set_tail(chid, NUM_IDS);
  107406:	58                   	pop    %eax
  107407:	5a                   	pop    %edx
  107408:	6a 40                	push   $0x40
  10740a:	ff 74 24 2c          	push   0x2c(%esp)
  10740e:	e8 6d fd ff ff       	call   107180 <tqueue_set_tail>
  107413:	83 c4 10             	add    $0x10,%esp
  107416:	e9 5b ff ff ff       	jmp    107376 <tqueue_remove+0x46>
  10741b:	66 90                	xchg   %ax,%ax
  10741d:	66 90                	xchg   %ax,%ax
  10741f:	90                   	nop

00107420 <get_curid>:
#include <pcpu/PCPUIntro/export.h>

unsigned int CURID[NUM_CPUS];

unsigned int get_curid(void)
{
  107420:	53                   	push   %ebx
  107421:	e8 7c 8f ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107426:	81 c3 ce 9b 00 00    	add    $0x9bce,%ebx
  10742c:	83 ec 08             	sub    $0x8,%esp
    return CURID[get_pcpu_idx()];
  10742f:	e8 6c e7 ff ff       	call   105ba0 <get_pcpu_idx>
  107434:	8b 84 83 6c 2c cb 00 	mov    0xcb2c6c(%ebx,%eax,4),%eax
}
  10743b:	83 c4 08             	add    $0x8,%esp
  10743e:	5b                   	pop    %ebx
  10743f:	c3                   	ret

00107440 <set_curid>:

void set_curid(unsigned int curid)
{
  107440:	53                   	push   %ebx
  107441:	e8 5c 8f ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107446:	81 c3 ae 9b 00 00    	add    $0x9bae,%ebx
  10744c:	83 ec 08             	sub    $0x8,%esp
    CURID[get_pcpu_idx()] = curid;
  10744f:	e8 4c e7 ff ff       	call   105ba0 <get_pcpu_idx>
  107454:	8b 54 24 10          	mov    0x10(%esp),%edx
  107458:	89 94 83 6c 2c cb 00 	mov    %edx,0xcb2c6c(%ebx,%eax,4)
}
  10745f:	83 c4 08             	add    $0x8,%esp
  107462:	5b                   	pop    %ebx
  107463:	c3                   	ret
  107464:	66 90                	xchg   %ax,%ax
  107466:	66 90                	xchg   %ax,%ax
  107468:	66 90                	xchg   %ax,%ax
  10746a:	66 90                	xchg   %ax,%ax
  10746c:	66 90                	xchg   %ax,%ax
  10746e:	66 90                	xchg   %ax,%ax

00107470 <thread_init>:

#include "import.h"

spinlock_t tqueue_lock[NUM_CPUS];
void thread_init(unsigned int mbi_addr)
{
  107470:	57                   	push   %edi
  107471:	56                   	push   %esi
  107472:	53                   	push   %ebx
  107473:	e8 2a 8f ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107478:	81 c3 7c 9b 00 00    	add    $0x9b7c,%ebx
  10747e:	8d b3 8c 2c cb 00    	lea    0xcb2c8c(%ebx),%esi
  107484:	8d 7e 40             	lea    0x40(%esi),%edi
  107487:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10748e:	00 
  10748f:	90                   	nop
    int i;
    for(i = 0; i < NUM_CPUS; i++){
        spinlock_init(&tqueue_lock[i]);
  107490:	83 ec 0c             	sub    $0xc,%esp
  107493:	56                   	push   %esi
    for(i = 0; i < NUM_CPUS; i++){
  107494:	83 c6 08             	add    $0x8,%esi
        spinlock_init(&tqueue_lock[i]);
  107497:	e8 64 e3 ff ff       	call   105800 <spinlock_init>
    for(i = 0; i < NUM_CPUS; i++){
  10749c:	83 c4 10             	add    $0x10,%esp
  10749f:	39 fe                	cmp    %edi,%esi
  1074a1:	75 ed                	jne    107490 <thread_init+0x20>
    }
    tqueue_init(mbi_addr);
  1074a3:	83 ec 0c             	sub    $0xc,%esp
  1074a6:	ff 74 24 1c          	push   0x1c(%esp)
  1074aa:	e8 21 fd ff ff       	call   1071d0 <tqueue_init>
    set_curid(0);
  1074af:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1074b6:	e8 85 ff ff ff       	call   107440 <set_curid>
    tcb_set_state(0, TSTATE_RUN);
  1074bb:	58                   	pop    %eax
  1074bc:	5a                   	pop    %edx
  1074bd:	6a 01                	push   $0x1
  1074bf:	6a 00                	push   $0x0
  1074c1:	e8 fa fa ff ff       	call   106fc0 <tcb_set_state>
}
  1074c6:	83 c4 10             	add    $0x10,%esp
  1074c9:	5b                   	pop    %ebx
  1074ca:	5e                   	pop    %esi
  1074cb:	5f                   	pop    %edi
  1074cc:	c3                   	ret
  1074cd:	8d 76 00             	lea    0x0(%esi),%esi

001074d0 <thread_spawn>:
 * Allocates a new child thread context, sets the state of the new child thread
 * to ready, and pushes it to the ready queue.
 * It returns the child thread id.
 */
unsigned int thread_spawn(void *entry, unsigned int id, unsigned int quota)
{
  1074d0:	57                   	push   %edi
  1074d1:	56                   	push   %esi
  1074d2:	53                   	push   %ebx
  1074d3:	e8 ca 8e ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1074d8:	81 c3 1c 9b 00 00    	add    $0x9b1c,%ebx
    unsigned int pid;

    spinlock_acquire(&tqueue_lock[get_pcpu_idx()]);
  1074de:	e8 bd e6 ff ff       	call   105ba0 <get_pcpu_idx>
  1074e3:	8d bb 8c 2c cb 00    	lea    0xcb2c8c(%ebx),%edi
  1074e9:	83 ec 0c             	sub    $0xc,%esp
  1074ec:	8d 04 c7             	lea    (%edi,%eax,8),%eax
  1074ef:	50                   	push   %eax
  1074f0:	e8 9b e3 ff ff       	call   105890 <spinlock_acquire>
    pid = kctx_new(entry, id, quota);
  1074f5:	83 c4 0c             	add    $0xc,%esp
  1074f8:	ff 74 24 1c          	push   0x1c(%esp)
  1074fc:	ff 74 24 1c          	push   0x1c(%esp)
  107500:	ff 74 24 1c          	push   0x1c(%esp)
  107504:	e8 07 fa ff ff       	call   106f10 <kctx_new>
  107509:	89 c6                	mov    %eax,%esi
    tcb_set_state(pid, TSTATE_READY);
  10750b:	58                   	pop    %eax
  10750c:	5a                   	pop    %edx
  10750d:	6a 00                	push   $0x0
  10750f:	56                   	push   %esi
  107510:	e8 ab fa ff ff       	call   106fc0 <tcb_set_state>
        
    tqueue_enqueue(NUM_IDS, pid);
  107515:	59                   	pop    %ecx
  107516:	58                   	pop    %eax
  107517:	56                   	push   %esi
  107518:	6a 40                	push   $0x40
  10751a:	e8 f1 fc ff ff       	call   107210 <tqueue_enqueue>
        spinlock_release(&tqueue_lock[get_pcpu_idx()]);
  10751f:	e8 7c e6 ff ff       	call   105ba0 <get_pcpu_idx>
  107524:	8d 04 c7             	lea    (%edi,%eax,8),%eax
  107527:	89 04 24             	mov    %eax,(%esp)
  10752a:	e8 e1 e3 ff ff       	call   105910 <spinlock_release>

    return pid;
  10752f:	83 c4 10             	add    $0x10,%esp
}
  107532:	89 f0                	mov    %esi,%eax
  107534:	5b                   	pop    %ebx
  107535:	5e                   	pop    %esi
  107536:	5f                   	pop    %edi
  107537:	c3                   	ret
  107538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10753f:	00 

00107540 <thread_yield>:
 * current thread id, and switch to the new kernel context.
 * Hint: If you are the only thread that is ready to run,
 * do you need to switch to yourself?
 */
void thread_yield(void)
{
  107540:	55                   	push   %ebp
  107541:	57                   	push   %edi
  107542:	56                   	push   %esi
  107543:	53                   	push   %ebx
  107544:	e8 59 8e ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107549:	81 c3 ab 9a 00 00    	add    $0x9aab,%ebx
  10754f:	83 ec 0c             	sub    $0xc,%esp
    unsigned int new_cur_pid;
    unsigned int old_cur_pid = get_curid();
  107552:	e8 c9 fe ff ff       	call   107420 <get_curid>
  107557:	89 c6                	mov    %eax,%esi
    unsigned int cpu_idx = get_pcpu_idx();
  107559:	e8 42 e6 ff ff       	call   105ba0 <get_pcpu_idx>

    int spinlock_status = spinlock_try_acquire(&tqueue_lock[cpu_idx]);
  10755e:	83 ec 0c             	sub    $0xc,%esp
  107561:	8d bc c3 8c 2c cb 00 	lea    0xcb2c8c(%ebx,%eax,8),%edi
  107568:	57                   	push   %edi
  107569:	e8 d2 e3 ff ff       	call   105940 <spinlock_try_acquire>

    if (spinlock_status == 1) return;
  10756e:	83 c4 10             	add    $0x10,%esp
  107571:	83 f8 01             	cmp    $0x1,%eax
  107574:	74 4f                	je     1075c5 <thread_yield+0x85>


    tcb_set_state(old_cur_pid, TSTATE_READY);
  107576:	83 ec 08             	sub    $0x8,%esp
  107579:	6a 00                	push   $0x0
  10757b:	56                   	push   %esi
  10757c:	e8 3f fa ff ff       	call   106fc0 <tcb_set_state>
    tqueue_enqueue(NUM_IDS + get_pcpu_idx(), old_cur_pid);
  107581:	e8 1a e6 ff ff       	call   105ba0 <get_pcpu_idx>
  107586:	5a                   	pop    %edx
  107587:	59                   	pop    %ecx
  107588:	56                   	push   %esi
  107589:	83 c0 40             	add    $0x40,%eax
  10758c:	50                   	push   %eax
  10758d:	e8 7e fc ff ff       	call   107210 <tqueue_enqueue>


    new_cur_pid = tqueue_dequeue(NUM_IDS + get_pcpu_idx());
  107592:	e8 09 e6 ff ff       	call   105ba0 <get_pcpu_idx>
  107597:	83 c0 40             	add    $0x40,%eax
  10759a:	89 04 24             	mov    %eax,(%esp)
  10759d:	e8 ee fc ff ff       	call   107290 <tqueue_dequeue>
  1075a2:	89 c5                	mov    %eax,%ebp
    tcb_set_state(new_cur_pid, TSTATE_RUN);
  1075a4:	58                   	pop    %eax
  1075a5:	5a                   	pop    %edx
  1075a6:	6a 01                	push   $0x1
  1075a8:	55                   	push   %ebp
  1075a9:	e8 12 fa ff ff       	call   106fc0 <tcb_set_state>
    set_curid(new_cur_pid);
  1075ae:	89 2c 24             	mov    %ebp,(%esp)
  1075b1:	e8 8a fe ff ff       	call   107440 <set_curid>

    spinlock_release(&tqueue_lock[cpu_idx]);
  1075b6:	89 3c 24             	mov    %edi,(%esp)
  1075b9:	e8 52 e3 ff ff       	call   105910 <spinlock_release>


    if (old_cur_pid != new_cur_pid) {
  1075be:	83 c4 10             	add    $0x10,%esp
  1075c1:	39 ee                	cmp    %ebp,%esi
  1075c3:	75 0b                	jne    1075d0 <thread_yield+0x90>

        kctx_switch(old_cur_pid, new_cur_pid);
    }

}
  1075c5:	83 c4 0c             	add    $0xc,%esp
  1075c8:	5b                   	pop    %ebx
  1075c9:	5e                   	pop    %esi
  1075ca:	5f                   	pop    %edi
  1075cb:	5d                   	pop    %ebp
  1075cc:	c3                   	ret
  1075cd:	8d 76 00             	lea    0x0(%esi),%esi
        kctx_switch(old_cur_pid, new_cur_pid);
  1075d0:	83 ec 08             	sub    $0x8,%esp
  1075d3:	55                   	push   %ebp
  1075d4:	56                   	push   %esi
  1075d5:	e8 c6 f8 ff ff       	call   106ea0 <kctx_switch>
  1075da:	83 c4 10             	add    $0x10,%esp
}
  1075dd:	83 c4 0c             	add    $0xc,%esp
  1075e0:	5b                   	pop    %ebx
  1075e1:	5e                   	pop    %esi
  1075e2:	5f                   	pop    %edi
  1075e3:	5d                   	pop    %ebp
  1075e4:	c3                   	ret
  1075e5:	66 90                	xchg   %ax,%ax
  1075e7:	66 90                	xchg   %ax,%ax
  1075e9:	66 90                	xchg   %ax,%ax
  1075eb:	66 90                	xchg   %ax,%ax
  1075ed:	66 90                	xchg   %ax,%ax
  1075ef:	90                   	nop

001075f0 <proc_start_user>:
extern tf_t uctx_pool[NUM_IDS];

extern unsigned int last_active[NUM_CPUS];

void proc_start_user(void)
{
  1075f0:	57                   	push   %edi
  1075f1:	56                   	push   %esi
  1075f2:	53                   	push   %ebx
  1075f3:	e8 aa 8d ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1075f8:	81 c3 fc 99 00 00    	add    $0x99fc,%ebx
    unsigned int cur_pid = get_curid();
  1075fe:	e8 1d fe ff ff       	call   107420 <get_curid>
  107603:	89 c6                	mov    %eax,%esi
    unsigned int cpu_idx = get_pcpu_idx();
  107605:	e8 96 e5 ff ff       	call   105ba0 <get_pcpu_idx>

    kstack_switch(cur_pid);
  10760a:	83 ec 0c             	sub    $0xc,%esp
  10760d:	56                   	push   %esi
    unsigned int cpu_idx = get_pcpu_idx();
  10760e:	89 c7                	mov    %eax,%edi
    kstack_switch(cur_pid);
  107610:	e8 8b d3 ff ff       	call   1049a0 <kstack_switch>
    set_pdir_base(cur_pid);
  107615:	89 34 24             	mov    %esi,(%esp)
  107618:	e8 63 f1 ff ff       	call   106780 <set_pdir_base>
    last_active[cpu_idx] = cur_pid;
  10761d:	c7 c0 c0 4d e0 00    	mov    $0xe04dc0,%eax
  107623:	89 34 b8             	mov    %esi,(%eax,%edi,4)

    trap_return((void *) &uctx_pool[cur_pid]);
  107626:	6b f6 44             	imul   $0x44,%esi,%esi
  107629:	81 c6 c0 3c dc 00    	add    $0xdc3cc0,%esi
  10762f:	89 34 24             	mov    %esi,(%esp)
  107632:	e8 c9 ac ff ff       	call   102300 <trap_return>
}
  107637:	83 c4 10             	add    $0x10,%esp
  10763a:	5b                   	pop    %ebx
  10763b:	5e                   	pop    %esi
  10763c:	5f                   	pop    %edi
  10763d:	c3                   	ret
  10763e:	66 90                	xchg   %ax,%ax

00107640 <proc_create>:

unsigned int proc_create(void *elf_addr, unsigned int quota)
{
  107640:	57                   	push   %edi
  107641:	56                   	push   %esi
  107642:	53                   	push   %ebx
  107643:	e8 5a 8d ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107648:	81 c3 ac 99 00 00    	add    $0x99ac,%ebx
    unsigned int pid, id;

    id = get_curid();
  10764e:	e8 cd fd ff ff       	call   107420 <get_curid>
    pid = thread_spawn((void *) proc_start_user, id, quota);
  107653:	83 ec 04             	sub    $0x4,%esp
  107656:	ff 74 24 18          	push   0x18(%esp)
  10765a:	50                   	push   %eax
  10765b:	8d 83 fc 65 ff ff    	lea    -0x9a04(%ebx),%eax
  107661:	50                   	push   %eax
  107662:	e8 69 fe ff ff       	call   1074d0 <thread_spawn>

    if (pid != NUM_IDS) {
  107667:	83 c4 10             	add    $0x10,%esp
    pid = thread_spawn((void *) proc_start_user, id, quota);
  10766a:	89 c6                	mov    %eax,%esi
    if (pid != NUM_IDS) {
  10766c:	83 f8 40             	cmp    $0x40,%eax
  10766f:	74 66                	je     1076d7 <proc_create+0x97>
        elf_load(elf_addr, pid);
  107671:	83 ec 08             	sub    $0x8,%esp

        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107674:	6b fe 44             	imul   $0x44,%esi,%edi
        elf_load(elf_addr, pid);
  107677:	50                   	push   %eax
  107678:	ff 74 24 1c          	push   0x1c(%esp)
  10767c:	e8 9f de ff ff       	call   105520 <elf_load>
        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107681:	81 c7 c0 3c dc 00    	add    $0xdc3cc0,%edi
  107687:	b8 23 00 00 00       	mov    $0x23,%eax
        uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  10768c:	ba 23 00 00 00       	mov    $0x23,%edx
        uctx_pool[pid].es = CPU_GDT_UDATA | 3;
  107691:	66 89 47 20          	mov    %ax,0x20(%edi)
        uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  107695:	b9 1b 00 00 00       	mov    $0x1b,%ecx
        uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  10769a:	b8 23 00 00 00       	mov    $0x23,%eax
        uctx_pool[pid].ds = CPU_GDT_UDATA | 3;
  10769f:	66 89 57 24          	mov    %dx,0x24(%edi)
        uctx_pool[pid].cs = CPU_GDT_UCODE | 3;
  1076a3:	66 89 4f 34          	mov    %cx,0x34(%edi)
        uctx_pool[pid].ss = CPU_GDT_UDATA | 3;
  1076a7:	66 89 47 40          	mov    %ax,0x40(%edi)
        uctx_pool[pid].esp = VM_USERHI;
  1076ab:	c7 47 3c 00 00 00 f0 	movl   $0xf0000000,0x3c(%edi)
        uctx_pool[pid].eflags = FL_IF;
  1076b2:	c7 47 38 00 02 00 00 	movl   $0x200,0x38(%edi)
        uctx_pool[pid].eip = elf_entry(elf_addr);
  1076b9:	58                   	pop    %eax
  1076ba:	ff 74 24 1c          	push   0x1c(%esp)
  1076be:	e8 9d e0 ff ff       	call   105760 <elf_entry>
  1076c3:	89 47 30             	mov    %eax,0x30(%edi)

        seg_init_proc(get_pcpu_idx(), pid);
  1076c6:	e8 d5 e4 ff ff       	call   105ba0 <get_pcpu_idx>
  1076cb:	5a                   	pop    %edx
  1076cc:	59                   	pop    %ecx
  1076cd:	56                   	push   %esi
  1076ce:	50                   	push   %eax
  1076cf:	e8 fc d4 ff ff       	call   104bd0 <seg_init_proc>
  1076d4:	83 c4 10             	add    $0x10,%esp
    }

    return pid;
}
  1076d7:	89 f0                	mov    %esi,%eax
  1076d9:	5b                   	pop    %ebx
  1076da:	5e                   	pop    %esi
  1076db:	5f                   	pop    %edi
  1076dc:	c3                   	ret
  1076dd:	66 90                	xchg   %ax,%ax
  1076df:	90                   	nop

001076e0 <syscall_get_arg1>:
 * Retrieves the system call arguments from uctx_pool that get
 * passed in from the current running process' system call.
 */
unsigned int syscall_get_arg1(tf_t *tf)
{
    return tf->regs.eax;
  1076e0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1076e4:	8b 40 1c             	mov    0x1c(%eax),%eax
}
  1076e7:	c3                   	ret
  1076e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1076ef:	00 

001076f0 <syscall_get_arg2>:

unsigned int syscall_get_arg2(tf_t *tf)
{
    return tf->regs.ebx;
  1076f0:	8b 44 24 04          	mov    0x4(%esp),%eax
  1076f4:	8b 40 10             	mov    0x10(%eax),%eax
}
  1076f7:	c3                   	ret
  1076f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1076ff:	00 

00107700 <syscall_get_arg3>:

unsigned int syscall_get_arg3(tf_t *tf)
{
    return tf->regs.ecx;
  107700:	8b 44 24 04          	mov    0x4(%esp),%eax
  107704:	8b 40 18             	mov    0x18(%eax),%eax
}
  107707:	c3                   	ret
  107708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10770f:	00 

00107710 <syscall_get_arg4>:

unsigned int syscall_get_arg4(tf_t *tf)
{
    return tf->regs.edx;
  107710:	8b 44 24 04          	mov    0x4(%esp),%eax
  107714:	8b 40 14             	mov    0x14(%eax),%eax
}
  107717:	c3                   	ret
  107718:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10771f:	00 

00107720 <syscall_get_arg5>:

unsigned int syscall_get_arg5(tf_t *tf)
{
    return tf->regs.esi;
  107720:	8b 44 24 04          	mov    0x4(%esp),%eax
  107724:	8b 40 04             	mov    0x4(%eax),%eax
}
  107727:	c3                   	ret
  107728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10772f:	00 

00107730 <syscall_get_arg6>:

unsigned int syscall_get_arg6(tf_t *tf)
{
    return tf->regs.edi;
  107730:	8b 44 24 04          	mov    0x4(%esp),%eax
  107734:	8b 00                	mov    (%eax),%eax
}
  107736:	c3                   	ret
  107737:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10773e:	00 
  10773f:	90                   	nop

00107740 <syscall_set_errno>:
 * Sets the error number in uctx_pool that gets passed
 * to the current running process when we return to it.
 */
void syscall_set_errno(tf_t *tf, unsigned int errno)
{
    tf->regs.eax = errno;
  107740:	8b 44 24 04          	mov    0x4(%esp),%eax
  107744:	8b 54 24 08          	mov    0x8(%esp),%edx
  107748:	89 50 1c             	mov    %edx,0x1c(%eax)
}
  10774b:	c3                   	ret
  10774c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107750 <syscall_set_retval1>:
 * Sets the return values in uctx_pool that get passed
 * to the current running process when we return to it.
 */
void syscall_set_retval1(tf_t *tf, unsigned int retval)
{
    tf->regs.ebx = retval;
  107750:	8b 44 24 04          	mov    0x4(%esp),%eax
  107754:	8b 54 24 08          	mov    0x8(%esp),%edx
  107758:	89 50 10             	mov    %edx,0x10(%eax)
}
  10775b:	c3                   	ret
  10775c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107760 <syscall_set_retval2>:

void syscall_set_retval2(tf_t *tf, unsigned int retval)
{
    tf->regs.ecx = retval;
  107760:	8b 44 24 04          	mov    0x4(%esp),%eax
  107764:	8b 54 24 08          	mov    0x8(%esp),%edx
  107768:	89 50 18             	mov    %edx,0x18(%eax)
}
  10776b:	c3                   	ret
  10776c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107770 <syscall_set_retval3>:

void syscall_set_retval3(tf_t *tf, unsigned int retval)
{
    tf->regs.edx = retval;
  107770:	8b 44 24 04          	mov    0x4(%esp),%eax
  107774:	8b 54 24 08          	mov    0x8(%esp),%edx
  107778:	89 50 14             	mov    %edx,0x14(%eax)
}
  10777b:	c3                   	ret
  10777c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107780 <syscall_set_retval4>:

void syscall_set_retval4(tf_t *tf, unsigned int retval)
{
    tf->regs.esi = retval;
  107780:	8b 44 24 04          	mov    0x4(%esp),%eax
  107784:	8b 54 24 08          	mov    0x8(%esp),%edx
  107788:	89 50 04             	mov    %edx,0x4(%eax)
}
  10778b:	c3                   	ret
  10778c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107790 <syscall_set_retval5>:

void syscall_set_retval5(tf_t *tf, unsigned int retval)
{
    tf->regs.edi = retval;
  107790:	8b 44 24 04          	mov    0x4(%esp),%eax
  107794:	8b 54 24 08          	mov    0x8(%esp),%edx
  107798:	89 10                	mov    %edx,(%eax)
}
  10779a:	c3                   	ret
  10779b:	66 90                	xchg   %ax,%ax
  10779d:	66 90                	xchg   %ax,%ax
  10779f:	90                   	nop

001077a0 <sys_puts>:
/**
 * Copies a string from user into buffer and prints it to the screen.
 * This is called by the user level "printf" library as a system call.
 */
void sys_puts(tf_t *tf)
{
  1077a0:	55                   	push   %ebp
  1077a1:	57                   	push   %edi
  1077a2:	56                   	push   %esi
  1077a3:	53                   	push   %ebx
  1077a4:	e8 f9 8b ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1077a9:	81 c3 4b 98 00 00    	add    $0x984b,%ebx
  1077af:	83 ec 2c             	sub    $0x2c,%esp
  1077b2:	8b 74 24 40          	mov    0x40(%esp),%esi
    unsigned int cur_pid;
    unsigned int str_uva, str_len;
    unsigned int remain, cur_pos, nbytes;

    cur_pid = get_curid();
  1077b6:	e8 65 fc ff ff       	call   107420 <get_curid>
    str_uva = syscall_get_arg2(tf);
  1077bb:	83 ec 0c             	sub    $0xc,%esp
    cur_pid = get_curid();
  1077be:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    str_uva = syscall_get_arg2(tf);
  1077c2:	56                   	push   %esi
  1077c3:	e8 28 ff ff ff       	call   1076f0 <syscall_get_arg2>
    str_len = syscall_get_arg3(tf);
  1077c8:	89 34 24             	mov    %esi,(%esp)
    str_uva = syscall_get_arg2(tf);
  1077cb:	89 c7                	mov    %eax,%edi
    str_len = syscall_get_arg3(tf);
  1077cd:	e8 2e ff ff ff       	call   107700 <syscall_get_arg3>

    if (!(VM_USERLO <= str_uva && str_uva + str_len <= VM_USERHI)) {
  1077d2:	83 c4 10             	add    $0x10,%esp
  1077d5:	81 ff ff ff ff 3f    	cmp    $0x3fffffff,%edi
  1077db:	0f 86 df 00 00 00    	jbe    1078c0 <sys_puts+0x120>
  1077e1:	8d 14 07             	lea    (%edi,%eax,1),%edx
  1077e4:	89 c5                	mov    %eax,%ebp
  1077e6:	81 fa 00 00 00 f0    	cmp    $0xf0000000,%edx
  1077ec:	0f 87 ce 00 00 00    	ja     1078c0 <sys_puts+0x120>
    }

    remain = str_len;
    cur_pos = str_uva;

    while (remain) {
  1077f2:	85 c0                	test   %eax,%eax
  1077f4:	0f 84 aa 00 00 00    	je     1078a4 <sys_puts+0x104>
        if (remain < PAGESIZE - 1)
            nbytes = remain;
        else
            nbytes = PAGESIZE - 1;

        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  1077fa:	8b 44 24 10          	mov    0x10(%esp),%eax
  1077fe:	8d 8b cc 3d cb 00    	lea    0xcb3dcc(%ebx),%ecx
            syscall_set_errno(tf, E_MEM);
            return;
        }

        sys_buf[cur_pid][nbytes] = '\0';
        KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);
  107804:	89 74 24 40          	mov    %esi,0x40(%esp)
  107808:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  10780c:	c1 e0 0c             	shl    $0xc,%eax
  10780f:	89 44 24 14          	mov    %eax,0x14(%esp)
  107813:	01 c8                	add    %ecx,%eax
  107815:	89 44 24 08          	mov    %eax,0x8(%esp)
        KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);
  107819:	8d 83 9d 85 ff ff    	lea    -0x7a63(%ebx),%eax
  10781f:	89 44 24 18          	mov    %eax,0x18(%esp)
  107823:	eb 30                	jmp    107855 <sys_puts+0xb5>
  107825:	8d 76 00             	lea    0x0(%esi),%esi
        sys_buf[cur_pid][nbytes] = '\0';
  107828:	8b 44 24 14          	mov    0x14(%esp),%eax
  10782c:	8b 54 24 1c          	mov    0x1c(%esp),%edx

        remain -= nbytes;
        cur_pos += nbytes;
  107830:	01 f7                	add    %esi,%edi
        sys_buf[cur_pid][nbytes] = '\0';
  107832:	01 f0                	add    %esi,%eax
  107834:	c6 04 02 00          	movb   $0x0,(%edx,%eax,1)
        KERN_INFO("From cpu %d: %s", get_pcpu_idx(), sys_buf[cur_pid]);
  107838:	e8 63 e3 ff ff       	call   105ba0 <get_pcpu_idx>
  10783d:	83 ec 04             	sub    $0x4,%esp
  107840:	ff 74 24 0c          	push   0xc(%esp)
  107844:	50                   	push   %eax
  107845:	ff 74 24 24          	push   0x24(%esp)
  107849:	e8 72 c8 ff ff       	call   1040c0 <debug_info>
    while (remain) {
  10784e:	83 c4 10             	add    $0x10,%esp
  107851:	29 f5                	sub    %esi,%ebp
  107853:	74 4b                	je     1078a0 <sys_puts+0x100>
        if (remain < PAGESIZE - 1)
  107855:	b9 ff 0f 00 00       	mov    $0xfff,%ecx
  10785a:	39 cd                	cmp    %ecx,%ebp
  10785c:	0f 46 cd             	cmovbe %ebp,%ecx
        if (pt_copyin(cur_pid, cur_pos, sys_buf[cur_pid], nbytes) != nbytes) {
  10785f:	51                   	push   %ecx
  107860:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  107864:	ff 74 24 0c          	push   0xc(%esp)
  107868:	57                   	push   %edi
  107869:	ff 74 24 1c          	push   0x1c(%esp)
  10786d:	e8 fe d9 ff ff       	call   105270 <pt_copyin>
  107872:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
  107876:	83 c4 10             	add    $0x10,%esp
  107879:	89 c6                	mov    %eax,%esi
  10787b:	39 c8                	cmp    %ecx,%eax
  10787d:	74 a9                	je     107828 <sys_puts+0x88>
            syscall_set_errno(tf, E_MEM);
  10787f:	8b 74 24 40          	mov    0x40(%esp),%esi
  107883:	83 ec 08             	sub    $0x8,%esp
  107886:	6a 01                	push   $0x1
  107888:	56                   	push   %esi
  107889:	e8 b2 fe ff ff       	call   107740 <syscall_set_errno>
            return;
  10788e:	83 c4 10             	add    $0x10,%esp
    }

    syscall_set_errno(tf, E_SUCC);
}
  107891:	83 c4 2c             	add    $0x2c,%esp
  107894:	5b                   	pop    %ebx
  107895:	5e                   	pop    %esi
  107896:	5f                   	pop    %edi
  107897:	5d                   	pop    %ebp
  107898:	c3                   	ret
  107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1078a0:	8b 74 24 40          	mov    0x40(%esp),%esi
    syscall_set_errno(tf, E_SUCC);
  1078a4:	83 ec 08             	sub    $0x8,%esp
  1078a7:	6a 00                	push   $0x0
  1078a9:	56                   	push   %esi
  1078aa:	e8 91 fe ff ff       	call   107740 <syscall_set_errno>
  1078af:	83 c4 10             	add    $0x10,%esp
}
  1078b2:	83 c4 2c             	add    $0x2c,%esp
  1078b5:	5b                   	pop    %ebx
  1078b6:	5e                   	pop    %esi
  1078b7:	5f                   	pop    %edi
  1078b8:	5d                   	pop    %ebp
  1078b9:	c3                   	ret
  1078ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        syscall_set_errno(tf, E_INVAL_ADDR);
  1078c0:	83 ec 08             	sub    $0x8,%esp
  1078c3:	6a 04                	push   $0x4
  1078c5:	56                   	push   %esi
  1078c6:	e8 75 fe ff ff       	call   107740 <syscall_set_errno>
        return;
  1078cb:	83 c4 10             	add    $0x10,%esp
}
  1078ce:	83 c4 2c             	add    $0x2c,%esp
  1078d1:	5b                   	pop    %ebx
  1078d2:	5e                   	pop    %esi
  1078d3:	5f                   	pop    %edi
  1078d4:	5d                   	pop    %ebp
  1078d5:	c3                   	ret
  1078d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1078dd:	00 
  1078de:	66 90                	xchg   %ax,%ax

001078e0 <sys_spawn>:
 * NUM_IDS with the error number E_INVAL_PID. The same error case apply
 * when the proc_create fails.
 * Otherwise, you should mark it as successful, and return the new child process id.
 */
void sys_spawn(tf_t *tf)
{
  1078e0:	57                   	push   %edi
  1078e1:	56                   	push   %esi
  1078e2:	53                   	push   %ebx
  1078e3:	8b 7c 24 10          	mov    0x10(%esp),%edi
  1078e7:	e8 b6 8a ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1078ec:	81 c3 08 97 00 00    	add    $0x9708,%ebx
    unsigned int new_pid;
    unsigned int elf_id, quota;
    void *elf_addr;

    elf_id = syscall_get_arg2(tf);
  1078f2:	83 ec 0c             	sub    $0xc,%esp
  1078f5:	57                   	push   %edi
  1078f6:	e8 f5 fd ff ff       	call   1076f0 <syscall_get_arg2>
    quota = syscall_get_arg3(tf);
  1078fb:	89 3c 24             	mov    %edi,(%esp)
    elf_id = syscall_get_arg2(tf);
  1078fe:	89 c6                	mov    %eax,%esi
    quota = syscall_get_arg3(tf);
  107900:	e8 fb fd ff ff       	call   107700 <syscall_get_arg3>

    switch (elf_id) {
  107905:	83 c4 10             	add    $0x10,%esp
  107908:	83 fe 02             	cmp    $0x2,%esi
  10790b:	74 73                	je     107980 <sys_spawn+0xa0>
  10790d:	83 fe 03             	cmp    $0x3,%esi
  107910:	74 3e                	je     107950 <sys_spawn+0x70>
  107912:	83 fe 01             	cmp    $0x1,%esi
  107915:	75 49                	jne    107960 <sys_spawn+0x80>
    case 1:
        elf_addr = _binary___obj_user_pingpong_ping_start;
  107917:	c7 c2 1a ac 11 00    	mov    $0x11ac1a,%edx
        syscall_set_errno(tf, E_INVAL_PID);
        syscall_set_retval1(tf, NUM_IDS);
        return;
    }

    new_pid = proc_create(elf_addr, quota);
  10791d:	83 ec 08             	sub    $0x8,%esp
  107920:	50                   	push   %eax
  107921:	52                   	push   %edx
  107922:	e8 19 fd ff ff       	call   107640 <proc_create>

    if (new_pid == NUM_IDS) {
  107927:	83 c4 10             	add    $0x10,%esp
    new_pid = proc_create(elf_addr, quota);
  10792a:	89 c6                	mov    %eax,%esi
    if (new_pid == NUM_IDS) {
  10792c:	83 f8 40             	cmp    $0x40,%eax
  10792f:	74 2f                	je     107960 <sys_spawn+0x80>
        syscall_set_errno(tf, E_INVAL_PID);
        syscall_set_retval1(tf, NUM_IDS);
    } else {
        syscall_set_errno(tf, E_SUCC);
  107931:	83 ec 08             	sub    $0x8,%esp
  107934:	6a 00                	push   $0x0
  107936:	57                   	push   %edi
  107937:	e8 04 fe ff ff       	call   107740 <syscall_set_errno>
        syscall_set_retval1(tf, new_pid);
  10793c:	58                   	pop    %eax
  10793d:	5a                   	pop    %edx
  10793e:	56                   	push   %esi
  10793f:	57                   	push   %edi
  107940:	e8 0b fe ff ff       	call   107750 <syscall_set_retval1>
  107945:	83 c4 10             	add    $0x10,%esp
    }
}
  107948:	5b                   	pop    %ebx
  107949:	5e                   	pop    %esi
  10794a:	5f                   	pop    %edi
  10794b:	c3                   	ret
  10794c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        elf_addr = _binary___obj_user_pingpong_ding_start;
  107950:	c7 c2 3e e0 12 00    	mov    $0x12e03e,%edx
  107956:	eb c5                	jmp    10791d <sys_spawn+0x3d>
  107958:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10795f:	00 
        syscall_set_errno(tf, E_INVAL_PID);
  107960:	83 ec 08             	sub    $0x8,%esp
  107963:	6a 05                	push   $0x5
  107965:	57                   	push   %edi
  107966:	e8 d5 fd ff ff       	call   107740 <syscall_set_errno>
        syscall_set_retval1(tf, NUM_IDS);
  10796b:	59                   	pop    %ecx
  10796c:	5e                   	pop    %esi
  10796d:	6a 40                	push   $0x40
  10796f:	57                   	push   %edi
  107970:	e8 db fd ff ff       	call   107750 <syscall_set_retval1>
  107975:	83 c4 10             	add    $0x10,%esp
}
  107978:	5b                   	pop    %ebx
  107979:	5e                   	pop    %esi
  10797a:	5f                   	pop    %edi
  10797b:	c3                   	ret
  10797c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch (elf_id) {
  107980:	c7 c2 3e 46 12 00    	mov    $0x12463e,%edx
  107986:	eb 95                	jmp    10791d <sys_spawn+0x3d>
  107988:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10798f:	00 

00107990 <sys_yield>:
 * The user level library function sys_yield (defined in user/include/syscall.h)
 * does not take any argument and does not have any return values.
 * Do not forget to set the error number as E_SUCC.
 */
void sys_yield(tf_t *tf)
{
  107990:	53                   	push   %ebx
  107991:	e8 0c 8a ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107996:	81 c3 5e 96 00 00    	add    $0x965e,%ebx
  10799c:	83 ec 08             	sub    $0x8,%esp
    thread_yield();
  10799f:	e8 9c fb ff ff       	call   107540 <thread_yield>
    syscall_set_errno(tf, E_SUCC);
  1079a4:	83 ec 08             	sub    $0x8,%esp
  1079a7:	6a 00                	push   $0x0
  1079a9:	ff 74 24 1c          	push   0x1c(%esp)
  1079ad:	e8 8e fd ff ff       	call   107740 <syscall_set_errno>
}
  1079b2:	83 c4 18             	add    $0x18,%esp
  1079b5:	5b                   	pop    %ebx
  1079b6:	c3                   	ret
  1079b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1079be:	00 
  1079bf:	90                   	nop

001079c0 <sys_produce>:

void sys_produce(tf_t *tf)
{
  1079c0:	55                   	push   %ebp
  1079c1:	57                   	push   %edi
  1079c2:	56                   	push   %esi
    unsigned int i;
    for (i = 0; i < 5; i++) {
  1079c3:	31 f6                	xor    %esi,%esi
{
  1079c5:	53                   	push   %ebx
  1079c6:	e8 d7 89 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1079cb:	81 c3 29 96 00 00    	add    $0x9629,%ebx
  1079d1:	83 ec 1c             	sub    $0x1c,%esp
  1079d4:	8d 83 ad 85 ff ff    	lea    -0x7a53(%ebx),%eax
  1079da:	8d ab 70 90 ff ff    	lea    -0x6f90(%ebx),%ebp
  1079e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1079e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  1079e8:	e8 33 fa ff ff       	call   107420 <get_curid>
  1079ed:	89 c7                	mov    %eax,%edi
  1079ef:	e8 ac e1 ff ff       	call   105ba0 <get_pcpu_idx>
  1079f4:	83 ec 08             	sub    $0x8,%esp
  1079f7:	56                   	push   %esi
    for (i = 0; i < 5; i++) {
  1079f8:	83 c6 01             	add    $0x1,%esi
        KERN_DEBUG("CPU %d: Process %d: Produced %d\n", get_pcpu_idx(), get_curid(), i);
  1079fb:	57                   	push   %edi
  1079fc:	50                   	push   %eax
  1079fd:	55                   	push   %ebp
  1079fe:	68 83 00 00 00       	push   $0x83
  107a03:	ff 74 24 28          	push   0x28(%esp)
  107a07:	e8 f4 c6 ff ff       	call   104100 <debug_normal>
    for (i = 0; i < 5; i++) {
  107a0c:	83 c4 20             	add    $0x20,%esp
  107a0f:	83 fe 05             	cmp    $0x5,%esi
  107a12:	75 d4                	jne    1079e8 <sys_produce+0x28>
    }
    syscall_set_errno(tf, E_SUCC);
  107a14:	83 ec 08             	sub    $0x8,%esp
  107a17:	6a 00                	push   $0x0
  107a19:	ff 74 24 3c          	push   0x3c(%esp)
  107a1d:	e8 1e fd ff ff       	call   107740 <syscall_set_errno>
}
  107a22:	83 c4 2c             	add    $0x2c,%esp
  107a25:	5b                   	pop    %ebx
  107a26:	5e                   	pop    %esi
  107a27:	5f                   	pop    %edi
  107a28:	5d                   	pop    %ebp
  107a29:	c3                   	ret
  107a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107a30 <sys_consume>:

void sys_consume(tf_t *tf)
{
  107a30:	55                   	push   %ebp
  107a31:	57                   	push   %edi
  107a32:	56                   	push   %esi
    unsigned int i;
    for (i = 0; i < 5; i++) {
  107a33:	31 f6                	xor    %esi,%esi
{
  107a35:	53                   	push   %ebx
  107a36:	e8 67 89 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107a3b:	81 c3 b9 95 00 00    	add    $0x95b9,%ebx
  107a41:	83 ec 1c             	sub    $0x1c,%esp
  107a44:	8d 83 ad 85 ff ff    	lea    -0x7a53(%ebx),%eax
  107a4a:	8d ab 94 90 ff ff    	lea    -0x6f6c(%ebx),%ebp
  107a50:	89 44 24 0c          	mov    %eax,0xc(%esp)
  107a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  107a58:	e8 c3 f9 ff ff       	call   107420 <get_curid>
  107a5d:	89 c7                	mov    %eax,%edi
  107a5f:	e8 3c e1 ff ff       	call   105ba0 <get_pcpu_idx>
  107a64:	83 ec 08             	sub    $0x8,%esp
  107a67:	56                   	push   %esi
    for (i = 0; i < 5; i++) {
  107a68:	83 c6 01             	add    $0x1,%esi
        KERN_DEBUG("CPU %d: Process %d: Consumed %d\n", get_pcpu_idx(), get_curid(), i);
  107a6b:	57                   	push   %edi
  107a6c:	50                   	push   %eax
  107a6d:	55                   	push   %ebp
  107a6e:	68 8c 00 00 00       	push   $0x8c
  107a73:	ff 74 24 28          	push   0x28(%esp)
  107a77:	e8 84 c6 ff ff       	call   104100 <debug_normal>
    for (i = 0; i < 5; i++) {
  107a7c:	83 c4 20             	add    $0x20,%esp
  107a7f:	83 fe 05             	cmp    $0x5,%esi
  107a82:	75 d4                	jne    107a58 <sys_consume+0x28>
    }
    syscall_set_errno(tf, E_SUCC);
  107a84:	83 ec 08             	sub    $0x8,%esp
  107a87:	6a 00                	push   $0x0
  107a89:	ff 74 24 3c          	push   0x3c(%esp)
  107a8d:	e8 ae fc ff ff       	call   107740 <syscall_set_errno>
}
  107a92:	83 c4 2c             	add    $0x2c,%esp
  107a95:	5b                   	pop    %ebx
  107a96:	5e                   	pop    %esi
  107a97:	5f                   	pop    %edi
  107a98:	5d                   	pop    %ebp
  107a99:	c3                   	ret
  107a9a:	66 90                	xchg   %ax,%ax
  107a9c:	66 90                	xchg   %ax,%ax
  107a9e:	66 90                	xchg   %ax,%ax

00107aa0 <syscall_dispatch>:
#include <pcpu/PCPUIntro/export.h>

#include "import.h"

void syscall_dispatch(tf_t *tf)
{
  107aa0:	56                   	push   %esi
  107aa1:	53                   	push   %ebx
  107aa2:	e8 fb 88 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107aa7:	81 c3 4d 95 00 00    	add    $0x954d,%ebx
  107aad:	83 ec 10             	sub    $0x10,%esp
  107ab0:	8b 74 24 1c          	mov    0x1c(%esp),%esi
    unsigned int nr;

    nr = syscall_get_arg1(tf);
  107ab4:	56                   	push   %esi
  107ab5:	e8 26 fc ff ff       	call   1076e0 <syscall_get_arg1>

    switch (nr) {
  107aba:	83 c4 10             	add    $0x10,%esp
  107abd:	83 f8 04             	cmp    $0x4,%eax
  107ac0:	0f 87 84 00 00 00    	ja     107b4a <.L6+0x12>
  107ac6:	8b 94 83 9c 9b ff ff 	mov    -0x6464(%ebx,%eax,4),%edx
  107acd:	01 da                	add    %ebx,%edx
  107acf:	ff e2                	jmp    *%edx
  107ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00107ad8 <.L5>:
         *   None.
         */
        sys_yield(tf);
        break;
    case SYS_produce:
        sys_produce(tf);
  107ad8:	83 ec 0c             	sub    $0xc,%esp
  107adb:	56                   	push   %esi
  107adc:	e8 df fe ff ff       	call   1079c0 <sys_produce>
        break;
  107ae1:	83 c4 10             	add    $0x10,%esp
        sys_consume(tf);
        break;
    default:
        syscall_set_errno(tf, E_INVAL_CALLNR);
    }
}
  107ae4:	83 c4 04             	add    $0x4,%esp
  107ae7:	5b                   	pop    %ebx
  107ae8:	5e                   	pop    %esi
  107ae9:	c3                   	ret
  107aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107af0 <.L3>:
        sys_consume(tf);
  107af0:	83 ec 0c             	sub    $0xc,%esp
  107af3:	56                   	push   %esi
  107af4:	e8 37 ff ff ff       	call   107a30 <sys_consume>
        break;
  107af9:	83 c4 10             	add    $0x10,%esp
}
  107afc:	83 c4 04             	add    $0x4,%esp
  107aff:	5b                   	pop    %ebx
  107b00:	5e                   	pop    %esi
  107b01:	c3                   	ret
  107b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107b08 <.L8>:
        sys_puts(tf);
  107b08:	83 ec 0c             	sub    $0xc,%esp
  107b0b:	56                   	push   %esi
  107b0c:	e8 8f fc ff ff       	call   1077a0 <sys_puts>
        break;
  107b11:	83 c4 10             	add    $0x10,%esp
}
  107b14:	83 c4 04             	add    $0x4,%esp
  107b17:	5b                   	pop    %ebx
  107b18:	5e                   	pop    %esi
  107b19:	c3                   	ret
  107b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107b20 <.L7>:
        sys_spawn(tf);
  107b20:	83 ec 0c             	sub    $0xc,%esp
  107b23:	56                   	push   %esi
  107b24:	e8 b7 fd ff ff       	call   1078e0 <sys_spawn>
        break;
  107b29:	83 c4 10             	add    $0x10,%esp
}
  107b2c:	83 c4 04             	add    $0x4,%esp
  107b2f:	5b                   	pop    %ebx
  107b30:	5e                   	pop    %esi
  107b31:	c3                   	ret
  107b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107b38 <.L6>:
        sys_yield(tf);
  107b38:	83 ec 0c             	sub    $0xc,%esp
  107b3b:	56                   	push   %esi
  107b3c:	e8 4f fe ff ff       	call   107990 <sys_yield>
        break;
  107b41:	83 c4 10             	add    $0x10,%esp
}
  107b44:	83 c4 04             	add    $0x4,%esp
  107b47:	5b                   	pop    %ebx
  107b48:	5e                   	pop    %esi
  107b49:	c3                   	ret
        syscall_set_errno(tf, E_INVAL_CALLNR);
  107b4a:	83 ec 08             	sub    $0x8,%esp
  107b4d:	6a 03                	push   $0x3
  107b4f:	56                   	push   %esi
  107b50:	e8 eb fb ff ff       	call   107740 <syscall_set_errno>
  107b55:	83 c4 10             	add    $0x10,%esp
}
  107b58:	83 c4 04             	add    $0x4,%esp
  107b5b:	5b                   	pop    %ebx
  107b5c:	5e                   	pop    %esi
  107b5d:	c3                   	ret
  107b5e:	66 90                	xchg   %ax,%ax

00107b60 <trap_dump>:
#include <thread/PThread/export.h>

#include "import.h"

static void trap_dump(tf_t *tf)
{
  107b60:	55                   	push   %ebp
  107b61:	57                   	push   %edi
  107b62:	56                   	push   %esi
  107b63:	53                   	push   %ebx
  107b64:	e8 39 88 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107b69:	81 c3 8b 94 00 00    	add    $0x948b,%ebx
  107b6f:	83 ec 0c             	sub    $0xc,%esp
    if (tf == NULL)
  107b72:	85 c0                	test   %eax,%eax
  107b74:	0f 84 c0 01 00 00    	je     107d3a <trap_dump+0x1da>
  107b7a:	89 c6                	mov    %eax,%esi
        return;

    uintptr_t base = (uintptr_t) tf;

    KERN_DEBUG("trapframe at %x\n", base);
  107b7c:	8d bb b8 90 ff ff    	lea    -0x6f48(%ebx),%edi
  107b82:	50                   	push   %eax
  107b83:	8d 83 cb 85 ff ff    	lea    -0x7a35(%ebx),%eax
  107b89:	50                   	push   %eax
    KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
    KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
    KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  107b8a:	8d ab 1e 86 ff ff    	lea    -0x79e2(%ebx),%ebp
    KERN_DEBUG("trapframe at %x\n", base);
  107b90:	6a 16                	push   $0x16
  107b92:	57                   	push   %edi
  107b93:	e8 68 c5 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tedi:   \t\t%08x\n", &tf->regs.edi, tf->regs.edi);
  107b98:	58                   	pop    %eax
  107b99:	8d 83 dc 85 ff ff    	lea    -0x7a24(%ebx),%eax
  107b9f:	ff 36                	push   (%esi)
  107ba1:	56                   	push   %esi
  107ba2:	50                   	push   %eax
  107ba3:	6a 17                	push   $0x17
  107ba5:	57                   	push   %edi
  107ba6:	e8 55 c5 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tesi:   \t\t%08x\n", &tf->regs.esi, tf->regs.esi);
  107bab:	83 c4 14             	add    $0x14,%esp
  107bae:	8d 46 04             	lea    0x4(%esi),%eax
  107bb1:	ff 76 04             	push   0x4(%esi)
  107bb4:	50                   	push   %eax
  107bb5:	8d 83 f2 85 ff ff    	lea    -0x7a0e(%ebx),%eax
  107bbb:	50                   	push   %eax
  107bbc:	6a 18                	push   $0x18
  107bbe:	57                   	push   %edi
  107bbf:	e8 3c c5 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tebp:   \t\t%08x\n", &tf->regs.ebp, tf->regs.ebp);
  107bc4:	83 c4 14             	add    $0x14,%esp
  107bc7:	8d 46 08             	lea    0x8(%esi),%eax
  107bca:	ff 76 08             	push   0x8(%esi)
  107bcd:	50                   	push   %eax
  107bce:	8d 83 08 86 ff ff    	lea    -0x79f8(%ebx),%eax
  107bd4:	50                   	push   %eax
  107bd5:	6a 19                	push   $0x19
  107bd7:	57                   	push   %edi
  107bd8:	e8 23 c5 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->regs.oesp, tf->regs.oesp);
  107bdd:	83 c4 14             	add    $0x14,%esp
  107be0:	8d 46 0c             	lea    0xc(%esi),%eax
  107be3:	ff 76 0c             	push   0xc(%esi)
  107be6:	50                   	push   %eax
  107be7:	55                   	push   %ebp
  107be8:	6a 1a                	push   $0x1a
  107bea:	57                   	push   %edi
  107beb:	e8 10 c5 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tebx:   \t\t%08x\n", &tf->regs.ebx, tf->regs.ebx);
  107bf0:	83 c4 14             	add    $0x14,%esp
  107bf3:	8d 46 10             	lea    0x10(%esi),%eax
  107bf6:	ff 76 10             	push   0x10(%esi)
  107bf9:	50                   	push   %eax
  107bfa:	8d 83 34 86 ff ff    	lea    -0x79cc(%ebx),%eax
  107c00:	50                   	push   %eax
  107c01:	6a 1b                	push   $0x1b
  107c03:	57                   	push   %edi
  107c04:	e8 f7 c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tedx:   \t\t%08x\n", &tf->regs.edx, tf->regs.edx);
  107c09:	83 c4 14             	add    $0x14,%esp
  107c0c:	8d 46 14             	lea    0x14(%esi),%eax
  107c0f:	ff 76 14             	push   0x14(%esi)
  107c12:	50                   	push   %eax
  107c13:	8d 83 4a 86 ff ff    	lea    -0x79b6(%ebx),%eax
  107c19:	50                   	push   %eax
  107c1a:	6a 1c                	push   $0x1c
  107c1c:	57                   	push   %edi
  107c1d:	e8 de c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tecx:   \t\t%08x\n", &tf->regs.ecx, tf->regs.ecx);
  107c22:	83 c4 14             	add    $0x14,%esp
  107c25:	8d 46 18             	lea    0x18(%esi),%eax
  107c28:	ff 76 18             	push   0x18(%esi)
  107c2b:	50                   	push   %eax
  107c2c:	8d 83 60 86 ff ff    	lea    -0x79a0(%ebx),%eax
  107c32:	50                   	push   %eax
  107c33:	6a 1d                	push   $0x1d
  107c35:	57                   	push   %edi
  107c36:	e8 c5 c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\teax:   \t\t%08x\n", &tf->regs.eax, tf->regs.eax);
  107c3b:	83 c4 14             	add    $0x14,%esp
  107c3e:	8d 46 1c             	lea    0x1c(%esi),%eax
  107c41:	ff 76 1c             	push   0x1c(%esi)
  107c44:	50                   	push   %eax
  107c45:	8d 83 76 86 ff ff    	lea    -0x798a(%ebx),%eax
  107c4b:	50                   	push   %eax
  107c4c:	6a 1e                	push   $0x1e
  107c4e:	57                   	push   %edi
  107c4f:	e8 ac c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tes:    \t\t%08x\n", &tf->es, tf->es);
  107c54:	0f b7 46 20          	movzwl 0x20(%esi),%eax
  107c58:	83 c4 14             	add    $0x14,%esp
  107c5b:	50                   	push   %eax
  107c5c:	8d 46 20             	lea    0x20(%esi),%eax
  107c5f:	50                   	push   %eax
  107c60:	8d 83 8c 86 ff ff    	lea    -0x7974(%ebx),%eax
  107c66:	50                   	push   %eax
  107c67:	6a 1f                	push   $0x1f
  107c69:	57                   	push   %edi
  107c6a:	e8 91 c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tds:    \t\t%08x\n", &tf->ds, tf->ds);
  107c6f:	0f b7 46 24          	movzwl 0x24(%esi),%eax
  107c73:	83 c4 14             	add    $0x14,%esp
  107c76:	50                   	push   %eax
  107c77:	8d 46 24             	lea    0x24(%esi),%eax
  107c7a:	50                   	push   %eax
  107c7b:	8d 83 a2 86 ff ff    	lea    -0x795e(%ebx),%eax
  107c81:	50                   	push   %eax
  107c82:	6a 20                	push   $0x20
  107c84:	57                   	push   %edi
  107c85:	e8 76 c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\ttrapno:\t\t%08x\n", &tf->trapno, tf->trapno);
  107c8a:	83 c4 14             	add    $0x14,%esp
  107c8d:	8d 46 28             	lea    0x28(%esi),%eax
  107c90:	ff 76 28             	push   0x28(%esi)
  107c93:	50                   	push   %eax
  107c94:	8d 83 b8 86 ff ff    	lea    -0x7948(%ebx),%eax
  107c9a:	50                   	push   %eax
  107c9b:	6a 21                	push   $0x21
  107c9d:	57                   	push   %edi
  107c9e:	e8 5d c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\terr:   \t\t%08x\n", &tf->err, tf->err);
  107ca3:	83 c4 14             	add    $0x14,%esp
  107ca6:	8d 46 2c             	lea    0x2c(%esi),%eax
  107ca9:	ff 76 2c             	push   0x2c(%esi)
  107cac:	50                   	push   %eax
  107cad:	8d 83 ce 86 ff ff    	lea    -0x7932(%ebx),%eax
  107cb3:	50                   	push   %eax
  107cb4:	6a 22                	push   $0x22
  107cb6:	57                   	push   %edi
  107cb7:	e8 44 c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\teip:   \t\t%08x\n", &tf->eip, tf->eip);
  107cbc:	83 c4 14             	add    $0x14,%esp
  107cbf:	8d 46 30             	lea    0x30(%esi),%eax
  107cc2:	ff 76 30             	push   0x30(%esi)
  107cc5:	50                   	push   %eax
  107cc6:	8d 83 e4 86 ff ff    	lea    -0x791c(%ebx),%eax
  107ccc:	50                   	push   %eax
  107ccd:	6a 23                	push   $0x23
  107ccf:	57                   	push   %edi
  107cd0:	e8 2b c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tcs:    \t\t%08x\n", &tf->cs, tf->cs);
  107cd5:	0f b7 46 34          	movzwl 0x34(%esi),%eax
  107cd9:	83 c4 14             	add    $0x14,%esp
  107cdc:	50                   	push   %eax
  107cdd:	8d 46 34             	lea    0x34(%esi),%eax
  107ce0:	50                   	push   %eax
  107ce1:	8d 83 fa 86 ff ff    	lea    -0x7906(%ebx),%eax
  107ce7:	50                   	push   %eax
  107ce8:	6a 24                	push   $0x24
  107cea:	57                   	push   %edi
  107ceb:	e8 10 c4 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\teflags:\t\t%08x\n", &tf->eflags, tf->eflags);
  107cf0:	83 c4 14             	add    $0x14,%esp
  107cf3:	8d 46 38             	lea    0x38(%esi),%eax
  107cf6:	ff 76 38             	push   0x38(%esi)
  107cf9:	50                   	push   %eax
  107cfa:	8d 83 10 87 ff ff    	lea    -0x78f0(%ebx),%eax
  107d00:	50                   	push   %eax
  107d01:	6a 25                	push   $0x25
  107d03:	57                   	push   %edi
  107d04:	e8 f7 c3 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tesp:   \t\t%08x\n", &tf->esp, tf->esp);
  107d09:	83 c4 14             	add    $0x14,%esp
  107d0c:	8d 46 3c             	lea    0x3c(%esi),%eax
  107d0f:	ff 76 3c             	push   0x3c(%esi)
  107d12:	50                   	push   %eax
  107d13:	55                   	push   %ebp
  107d14:	6a 26                	push   $0x26
  107d16:	57                   	push   %edi
  107d17:	e8 e4 c3 ff ff       	call   104100 <debug_normal>
    KERN_DEBUG("\t%08x:\tss:    \t\t%08x\n", &tf->ss, tf->ss);
  107d1c:	0f b7 46 40          	movzwl 0x40(%esi),%eax
  107d20:	83 c4 14             	add    $0x14,%esp
  107d23:	83 c6 40             	add    $0x40,%esi
  107d26:	50                   	push   %eax
  107d27:	8d 83 26 87 ff ff    	lea    -0x78da(%ebx),%eax
  107d2d:	56                   	push   %esi
  107d2e:	50                   	push   %eax
  107d2f:	6a 27                	push   $0x27
  107d31:	57                   	push   %edi
  107d32:	e8 c9 c3 ff ff       	call   104100 <debug_normal>
  107d37:	83 c4 20             	add    $0x20,%esp
}
  107d3a:	83 c4 0c             	add    $0xc,%esp
  107d3d:	5b                   	pop    %ebx
  107d3e:	5e                   	pop    %esi
  107d3f:	5f                   	pop    %edi
  107d40:	5d                   	pop    %ebp
  107d41:	c3                   	ret
  107d42:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  107d49:	00 
  107d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00107d50 <default_exception_handler>:

void default_exception_handler(tf_t *tf)
{
  107d50:	56                   	push   %esi
  107d51:	53                   	push   %ebx
  107d52:	e8 4b 86 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107d57:	81 c3 9d 92 00 00    	add    $0x929d,%ebx
  107d5d:	83 ec 04             	sub    $0x4,%esp
  107d60:	8b 74 24 10          	mov    0x10(%esp),%esi
    unsigned int cur_pid;

    cur_pid = get_curid();
  107d64:	e8 b7 f6 ff ff       	call   107420 <get_curid>
    trap_dump(tf);
  107d69:	89 f0                	mov    %esi,%eax
  107d6b:	e8 f0 fd ff ff       	call   107b60 <trap_dump>

    KERN_PANIC("Trap %d @ 0x%08x.\n", tf->trapno, tf->eip);
  107d70:	83 ec 0c             	sub    $0xc,%esp
  107d73:	8d 83 3c 87 ff ff    	lea    -0x78c4(%ebx),%eax
  107d79:	ff 76 30             	push   0x30(%esi)
  107d7c:	ff 76 28             	push   0x28(%esi)
  107d7f:	50                   	push   %eax
  107d80:	8d 83 b8 90 ff ff    	lea    -0x6f48(%ebx),%eax
  107d86:	6a 31                	push   $0x31
  107d88:	50                   	push   %eax
  107d89:	e8 d2 c3 ff ff       	call   104160 <debug_panic>
}
  107d8e:	83 c4 24             	add    $0x24,%esp
  107d91:	5b                   	pop    %ebx
  107d92:	5e                   	pop    %esi
  107d93:	c3                   	ret
  107d94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  107d9b:	00 
  107d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00107da0 <pgflt_handler>:

void pgflt_handler(tf_t *tf)
{
  107da0:	55                   	push   %ebp
  107da1:	57                   	push   %edi
  107da2:	56                   	push   %esi
  107da3:	53                   	push   %ebx
  107da4:	e8 f9 85 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107da9:	81 c3 4b 92 00 00    	add    $0x924b,%ebx
  107daf:	83 ec 0c             	sub    $0xc,%esp
    unsigned int cur_pid;
    unsigned int errno;
    unsigned int fault_va;

    cur_pid = get_curid();
  107db2:	e8 69 f6 ff ff       	call   107420 <get_curid>
  107db7:	89 c6                	mov    %eax,%esi
    errno = tf->err;
  107db9:	8b 44 24 20          	mov    0x20(%esp),%eax
  107dbd:	8b 78 2c             	mov    0x2c(%eax),%edi
    fault_va = rcr2();
  107dc0:	e8 4b d1 ff ff       	call   104f10 <rcr2>
  107dc5:	89 c5                	mov    %eax,%ebp

    // Uncomment this line to see information about the page fault
    // KERN_DEBUG("Page fault: VA 0x%08x, errno 0x%08x, process %d, EIP 0x%08x.\n",
    //            fault_va, errno, cur_pid, uctx_pool[cur_pid].eip);

    if (errno & PFE_PR) {
  107dc7:	f7 c7 01 00 00 00    	test   $0x1,%edi
  107dcd:	75 21                	jne    107df0 <pgflt_handler+0x50>
        KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n",
                   fault_va, errno);
        return;
    }

    if (alloc_page(cur_pid, fault_va, PTE_W | PTE_U | PTE_P) == MagicNumber) {
  107dcf:	83 ec 04             	sub    $0x4,%esp
  107dd2:	6a 07                	push   $0x7
  107dd4:	50                   	push   %eax
  107dd5:	56                   	push   %esi
  107dd6:	e8 05 f0 ff ff       	call   106de0 <alloc_page>
  107ddb:	83 c4 10             	add    $0x10,%esp
  107dde:	3d 01 00 10 00       	cmp    $0x100001,%eax
  107de3:	74 33                	je     107e18 <pgflt_handler+0x78>
        KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n",
                   fault_va, errno);
    }
}
  107de5:	83 c4 0c             	add    $0xc,%esp
  107de8:	5b                   	pop    %ebx
  107de9:	5e                   	pop    %esi
  107dea:	5f                   	pop    %edi
  107deb:	5d                   	pop    %ebp
  107dec:	c3                   	ret
  107ded:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_PANIC("Permission denied: va = 0x%08x, errno = 0x%08x.\n",
  107df0:	83 ec 0c             	sub    $0xc,%esp
  107df3:	57                   	push   %edi
  107df4:	50                   	push   %eax
  107df5:	8d 83 e0 90 ff ff    	lea    -0x6f20(%ebx),%eax
  107dfb:	50                   	push   %eax
  107dfc:	8d 83 b8 90 ff ff    	lea    -0x6f48(%ebx),%eax
  107e02:	6a 43                	push   $0x43
  107e04:	50                   	push   %eax
  107e05:	e8 56 c3 ff ff       	call   104160 <debug_panic>
        return;
  107e0a:	83 c4 20             	add    $0x20,%esp
}
  107e0d:	83 c4 0c             	add    $0xc,%esp
  107e10:	5b                   	pop    %ebx
  107e11:	5e                   	pop    %esi
  107e12:	5f                   	pop    %edi
  107e13:	5d                   	pop    %ebp
  107e14:	c3                   	ret
  107e15:	8d 76 00             	lea    0x0(%esi),%esi
        KERN_PANIC("Page allocation failed: va = 0x%08x, errno = 0x%08x.\n",
  107e18:	83 ec 0c             	sub    $0xc,%esp
  107e1b:	8d 83 14 91 ff ff    	lea    -0x6eec(%ebx),%eax
  107e21:	57                   	push   %edi
  107e22:	55                   	push   %ebp
  107e23:	50                   	push   %eax
  107e24:	8d 83 b8 90 ff ff    	lea    -0x6f48(%ebx),%eax
  107e2a:	6a 49                	push   $0x49
  107e2c:	50                   	push   %eax
  107e2d:	e8 2e c3 ff ff       	call   104160 <debug_panic>
  107e32:	83 c4 20             	add    $0x20,%esp
}
  107e35:	83 c4 0c             	add    $0xc,%esp
  107e38:	5b                   	pop    %ebx
  107e39:	5e                   	pop    %esi
  107e3a:	5f                   	pop    %edi
  107e3b:	5d                   	pop    %ebp
  107e3c:	c3                   	ret
  107e3d:	8d 76 00             	lea    0x0(%esi),%esi

00107e40 <exception_handler>:
/**
 * We currently only handle the page fault exception.
 * All other exceptions should be routed to the default exception handler.
 */
void exception_handler(tf_t *tf)
{
  107e40:	56                   	push   %esi
  107e41:	53                   	push   %ebx
  107e42:	e8 5b 85 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107e47:	81 c3 ad 91 00 00    	add    $0x91ad,%ebx
  107e4d:	83 ec 04             	sub    $0x4,%esp
  107e50:	8b 74 24 10          	mov    0x10(%esp),%esi
    if (tf->trapno == T_PGFLT)
  107e54:	83 7e 28 0e          	cmpl   $0xe,0x28(%esi)
  107e58:	74 36                	je     107e90 <exception_handler+0x50>
    cur_pid = get_curid();
  107e5a:	e8 c1 f5 ff ff       	call   107420 <get_curid>
    trap_dump(tf);
  107e5f:	89 f0                	mov    %esi,%eax
  107e61:	e8 fa fc ff ff       	call   107b60 <trap_dump>
    KERN_PANIC("Trap %d @ 0x%08x.\n", tf->trapno, tf->eip);
  107e66:	83 ec 0c             	sub    $0xc,%esp
  107e69:	8d 83 3c 87 ff ff    	lea    -0x78c4(%ebx),%eax
  107e6f:	ff 76 30             	push   0x30(%esi)
  107e72:	ff 76 28             	push   0x28(%esi)
  107e75:	50                   	push   %eax
  107e76:	8d 83 b8 90 ff ff    	lea    -0x6f48(%ebx),%eax
  107e7c:	6a 31                	push   $0x31
  107e7e:	50                   	push   %eax
  107e7f:	e8 dc c2 ff ff       	call   104160 <debug_panic>
        pgflt_handler(tf);
    else
        default_exception_handler(tf);
}
  107e84:	83 c4 24             	add    $0x24,%esp
  107e87:	5b                   	pop    %ebx
  107e88:	5e                   	pop    %esi
  107e89:	c3                   	ret
  107e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pgflt_handler(tf);
  107e90:	89 74 24 10          	mov    %esi,0x10(%esp)
}
  107e94:	83 c4 04             	add    $0x4,%esp
  107e97:	5b                   	pop    %ebx
  107e98:	5e                   	pop    %esi
        pgflt_handler(tf);
  107e99:	e9 02 ff ff ff       	jmp    107da0 <pgflt_handler>
  107e9e:	66 90                	xchg   %ax,%ax

00107ea0 <interrupt_handler>:
/**
 * Any interrupt request other than the spurious or timer should be
 * routed to the default interrupt handler.
 */
void interrupt_handler(tf_t *tf)
{
  107ea0:	53                   	push   %ebx
  107ea1:	e8 fc 84 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107ea6:	81 c3 4e 91 00 00    	add    $0x914e,%ebx
  107eac:	83 ec 08             	sub    $0x8,%esp
    switch (tf->trapno) {
  107eaf:	8b 44 24 10          	mov    0x10(%esp),%eax
  107eb3:	83 78 28 27          	cmpl   $0x27,0x28(%eax)
  107eb7:	74 05                	je     107ebe <interrupt_handler+0x1e>
    intr_eoi();
  107eb9:	e8 32 9b ff ff       	call   1019f0 <intr_eoi>
        timer_intr_handler();
        break;
    default:
        default_intr_handler();
    }
}
  107ebe:	83 c4 08             	add    $0x8,%esp
  107ec1:	5b                   	pop    %ebx
  107ec2:	c3                   	ret
  107ec3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  107eca:	00 
  107ecb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00107ed0 <trap>:

unsigned int last_active[NUM_CPUS];

void trap(tf_t *tf)
{
  107ed0:	55                   	push   %ebp
  107ed1:	57                   	push   %edi
  107ed2:	56                   	push   %esi
  107ed3:	53                   	push   %ebx
  107ed4:	e8 c9 84 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107ed9:	81 c3 1b 91 00 00    	add    $0x911b,%ebx
  107edf:	83 ec 1c             	sub    $0x1c,%esp
    unsigned int cur_pid = get_curid();
  107ee2:	e8 39 f5 ff ff       	call   107420 <get_curid>
    unsigned int cpu_idx = get_pcpu_idx();
    trap_cb_t handler;

    unsigned int last_pid = last_active[cpu_idx];
  107ee7:	8d ab cc 3d cf 00    	lea    0xcf3dcc(%ebx),%ebp
    unsigned int cur_pid = get_curid();
  107eed:	89 44 24 0c          	mov    %eax,0xc(%esp)
    unsigned int cpu_idx = get_pcpu_idx();
  107ef1:	e8 aa dc ff ff       	call   105ba0 <get_pcpu_idx>
    unsigned int last_pid = last_active[cpu_idx];
  107ef6:	8b 7c 85 00          	mov    0x0(%ebp,%eax,4),%edi
    unsigned int cpu_idx = get_pcpu_idx();
  107efa:	89 c6                	mov    %eax,%esi

    if (last_pid != 0)
  107efc:	85 ff                	test   %edi,%edi
  107efe:	75 48                	jne    107f48 <trap+0x78>
    {
        set_pdir_base(0);  // switch to the kernel's page table
        last_active[cpu_idx] = 0;
    }

    handler = TRAP_HANDLER[get_pcpu_idx()][tf->trapno];
  107f00:	e8 9b dc ff ff       	call   105ba0 <get_pcpu_idx>
  107f05:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  107f09:	c1 e0 08             	shl    $0x8,%eax
  107f0c:	8b 51 28             	mov    0x28(%ecx),%edx
  107f0f:	c7 c1 e0 4d e0 00    	mov    $0xe04de0,%ecx
  107f15:	01 d0                	add    %edx,%eax
  107f17:	8b 04 81             	mov    (%ecx,%eax,4),%eax

    if (handler) {
  107f1a:	85 c0                	test   %eax,%eax
  107f1c:	74 62                	je     107f80 <trap+0xb0>
        handler(tf);
  107f1e:	83 ec 0c             	sub    $0xc,%esp
  107f21:	ff 74 24 3c          	push   0x3c(%esp)
  107f25:	ff d0                	call   *%eax
  107f27:	83 c4 10             	add    $0x10,%esp
    } else {
        KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x.\n",
                  tf->trapno, cur_pid, tf->eip);
    }
    
    if (last_pid != 0)
  107f2a:	85 ff                	test   %edi,%edi
  107f2c:	75 32                	jne    107f60 <trap+0x90>
        kstack_switch(cur_pid);
        set_pdir_base(cur_pid);
        last_active[cpu_idx] = last_pid;
    }

    trap_return((void *) tf);
  107f2e:	83 ec 0c             	sub    $0xc,%esp
  107f31:	ff 74 24 3c          	push   0x3c(%esp)
  107f35:	e8 c6 a3 ff ff       	call   102300 <trap_return>
}
  107f3a:	83 c4 2c             	add    $0x2c,%esp
  107f3d:	5b                   	pop    %ebx
  107f3e:	5e                   	pop    %esi
  107f3f:	5f                   	pop    %edi
  107f40:	5d                   	pop    %ebp
  107f41:	c3                   	ret
  107f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        set_pdir_base(0);  // switch to the kernel's page table
  107f48:	83 ec 0c             	sub    $0xc,%esp
  107f4b:	6a 00                	push   $0x0
  107f4d:	e8 2e e8 ff ff       	call   106780 <set_pdir_base>
        last_active[cpu_idx] = 0;
  107f52:	c7 44 b5 00 00 00 00 	movl   $0x0,0x0(%ebp,%esi,4)
  107f59:	00 
  107f5a:	83 c4 10             	add    $0x10,%esp
  107f5d:	eb a1                	jmp    107f00 <trap+0x30>
  107f5f:	90                   	nop
        kstack_switch(cur_pid);
  107f60:	83 ec 0c             	sub    $0xc,%esp
  107f63:	ff 74 24 18          	push   0x18(%esp)
  107f67:	e8 34 ca ff ff       	call   1049a0 <kstack_switch>
        set_pdir_base(cur_pid);
  107f6c:	58                   	pop    %eax
  107f6d:	ff 74 24 18          	push   0x18(%esp)
  107f71:	e8 0a e8 ff ff       	call   106780 <set_pdir_base>
        last_active[cpu_idx] = last_pid;
  107f76:	89 7c b5 00          	mov    %edi,0x0(%ebp,%esi,4)
  107f7a:	83 c4 10             	add    $0x10,%esp
  107f7d:	eb af                	jmp    107f2e <trap+0x5e>
  107f7f:	90                   	nop
        KERN_WARN("No handler for user trap 0x%x, process %d, eip 0x%08x.\n",
  107f80:	83 ec 08             	sub    $0x8,%esp
  107f83:	8b 44 24 38          	mov    0x38(%esp),%eax
  107f87:	ff 70 30             	push   0x30(%eax)
  107f8a:	8d 83 4c 91 ff ff    	lea    -0x6eb4(%ebx),%eax
  107f90:	ff 74 24 18          	push   0x18(%esp)
  107f94:	52                   	push   %edx
  107f95:	50                   	push   %eax
  107f96:	8d 83 b8 90 ff ff    	lea    -0x6f48(%ebx),%eax
  107f9c:	68 92 00 00 00       	push   $0x92
  107fa1:	50                   	push   %eax
  107fa2:	e8 c9 c2 ff ff       	call   104270 <debug_warn>
  107fa7:	83 c4 20             	add    $0x20,%esp
  107faa:	e9 7b ff ff ff       	jmp    107f2a <trap+0x5a>
  107faf:	90                   	nop

00107fb0 <trap_init_array>:
int inited = FALSE;

trap_cb_t TRAP_HANDLER[NUM_CPUS][256];

void trap_init_array(void)
{
  107fb0:	53                   	push   %ebx
  107fb1:	e8 ec 83 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  107fb6:	81 c3 3e 90 00 00    	add    $0x903e,%ebx
  107fbc:	83 ec 08             	sub    $0x8,%esp
    KERN_ASSERT(inited == FALSE);
  107fbf:	8b 83 ec 5d cf 00    	mov    0xcf5dec(%ebx),%eax
  107fc5:	85 c0                	test   %eax,%eax
  107fc7:	75 27                	jne    107ff0 <trap_init_array+0x40>
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  107fc9:	83 ec 08             	sub    $0x8,%esp
  107fcc:	8d 83 ec 3d cf 00    	lea    0xcf3dec(%ebx),%eax
  107fd2:	68 00 20 00 00       	push   $0x2000
  107fd7:	50                   	push   %eax
  107fd8:	e8 43 c0 ff ff       	call   104020 <memzero>
    inited = TRUE;
  107fdd:	c7 83 ec 5d cf 00 01 	movl   $0x1,0xcf5dec(%ebx)
  107fe4:	00 00 00 
}
  107fe7:	83 c4 18             	add    $0x18,%esp
  107fea:	5b                   	pop    %ebx
  107feb:	c3                   	ret
  107fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(inited == FALSE);
  107ff0:	8d 83 4f 87 ff ff    	lea    -0x78b1(%ebx),%eax
  107ff6:	50                   	push   %eax
  107ff7:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  107ffd:	50                   	push   %eax
  107ffe:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  108004:	6a 11                	push   $0x11
  108006:	50                   	push   %eax
  108007:	e8 54 c1 ff ff       	call   104160 <debug_panic>
  10800c:	83 c4 10             	add    $0x10,%esp
  10800f:	eb b8                	jmp    107fc9 <trap_init_array+0x19>
  108011:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  108018:	00 
  108019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00108020 <trap_handler_register>:

void trap_handler_register(int cpu_idx, int trapno, trap_cb_t cb)
{
  108020:	55                   	push   %ebp
  108021:	57                   	push   %edi
  108022:	56                   	push   %esi
  108023:	53                   	push   %ebx
  108024:	e8 79 83 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  108029:	81 c3 cb 8f 00 00    	add    $0x8fcb,%ebx
  10802f:	83 ec 0c             	sub    $0xc,%esp
  108032:	8b 74 24 20          	mov    0x20(%esp),%esi
  108036:	8b 6c 24 24          	mov    0x24(%esp),%ebp
  10803a:	8b 7c 24 28          	mov    0x28(%esp),%edi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  10803e:	83 fe 07             	cmp    $0x7,%esi
  108041:	77 25                	ja     108068 <trap_handler_register+0x48>
    KERN_ASSERT(0 <= trapno && trapno < 256);
  108043:	81 fd ff 00 00 00    	cmp    $0xff,%ebp
  108049:	77 44                	ja     10808f <trap_handler_register+0x6f>
    KERN_ASSERT(cb != NULL);
  10804b:	85 ff                	test   %edi,%edi
  10804d:	74 63                	je     1080b2 <trap_handler_register+0x92>

    TRAP_HANDLER[cpu_idx][trapno] = cb;
  10804f:	c1 e6 08             	shl    $0x8,%esi
  108052:	01 ee                	add    %ebp,%esi
  108054:	89 bc b3 ec 3d cf 00 	mov    %edi,0xcf3dec(%ebx,%esi,4)
}
  10805b:	83 c4 0c             	add    $0xc,%esp
  10805e:	5b                   	pop    %ebx
  10805f:	5e                   	pop    %esi
  108060:	5f                   	pop    %edi
  108061:	5d                   	pop    %ebp
  108062:	c3                   	ret
  108063:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108068:	8d 83 5f 87 ff ff    	lea    -0x78a1(%ebx),%eax
  10806e:	50                   	push   %eax
  10806f:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  108075:	50                   	push   %eax
  108076:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  10807c:	6a 18                	push   $0x18
  10807e:	50                   	push   %eax
  10807f:	e8 dc c0 ff ff       	call   104160 <debug_panic>
  108084:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(0 <= trapno && trapno < 256);
  108087:	81 fd ff 00 00 00    	cmp    $0xff,%ebp
  10808d:	76 bc                	jbe    10804b <trap_handler_register+0x2b>
  10808f:	8d 83 7b 87 ff ff    	lea    -0x7885(%ebx),%eax
  108095:	50                   	push   %eax
  108096:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  10809c:	50                   	push   %eax
  10809d:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  1080a3:	6a 19                	push   $0x19
  1080a5:	50                   	push   %eax
  1080a6:	e8 b5 c0 ff ff       	call   104160 <debug_panic>
  1080ab:	83 c4 10             	add    $0x10,%esp
    KERN_ASSERT(cb != NULL);
  1080ae:	85 ff                	test   %edi,%edi
  1080b0:	75 9d                	jne    10804f <trap_handler_register+0x2f>
  1080b2:	8d 83 97 87 ff ff    	lea    -0x7869(%ebx),%eax
  1080b8:	50                   	push   %eax
  1080b9:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1080bf:	50                   	push   %eax
  1080c0:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  1080c6:	6a 1a                	push   $0x1a
  1080c8:	50                   	push   %eax
  1080c9:	e8 92 c0 ff ff       	call   104160 <debug_panic>
  1080ce:	83 c4 10             	add    $0x10,%esp
  1080d1:	e9 79 ff ff ff       	jmp    10804f <trap_handler_register+0x2f>
  1080d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1080dd:	00 
  1080de:	66 90                	xchg   %ax,%ax

001080e0 <trap_init>:

void trap_init(unsigned int cpu_idx)
{
  1080e0:	55                   	push   %ebp
  1080e1:	57                   	push   %edi
  1080e2:	56                   	push   %esi
  1080e3:	53                   	push   %ebx
  1080e4:	e8 b9 82 ff ff       	call   1003a2 <__x86.get_pc_thunk.bx>
  1080e9:	81 c3 0b 8f 00 00    	add    $0x8f0b,%ebx
  1080ef:	83 ec 2c             	sub    $0x2c,%esp
  1080f2:	8b 6c 24 40          	mov    0x40(%esp),%ebp
    if (cpu_idx == 0) {
  1080f6:	85 ed                	test   %ebp,%ebp
  1080f8:	0f 84 c2 01 00 00    	je     1082c0 <trap_init+0x1e0>
        trap_init_array();
    }

    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  1080fe:	83 ec 08             	sub    $0x8,%esp
  108101:	8d 83 a4 91 ff ff    	lea    -0x6e5c(%ebx),%eax
  108107:	55                   	push   %ebp
  108108:	50                   	push   %eax
  108109:	e8 b2 bf ff ff       	call   1040c0 <debug_info>
  10810e:	83 c4 10             	add    $0x10,%esp
  108111:	8d 83 ec 3d cf 00    	lea    0xcf3dec(%ebx),%eax
  108117:	89 44 24 14          	mov    %eax,0x14(%esp)
  10811b:	8b 7c 24 14          	mov    0x14(%esp),%edi
  10811f:	89 ea                	mov    %ebp,%edx
  108121:	c1 e2 0a             	shl    $0xa,%edx
  108124:	8d 04 3a             	lea    (%edx,%edi,1),%eax
  108127:	8d 8c 3a 80 00 00 00 	lea    0x80(%edx,%edi,1),%ecx
  10812e:	c7 c7 40 7e 10 00    	mov    $0x107e40,%edi
  108134:	89 44 24 18          	mov    %eax,0x18(%esp)
  108138:	89 c6                	mov    %eax,%esi
  10813a:	eb 0d                	jmp    108149 <trap_init+0x69>
  10813c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108140:	89 3e                	mov    %edi,(%esi)
    // TODO: for CPU # [cpu_idx], register appropriate trap handler for each trap number,
    // with trap_handler_register function defined above.


    // exceptions (0- 31)
    for(int i = 0; i < 32; i++){
  108142:	83 c6 04             	add    $0x4,%esi
  108145:	39 ce                	cmp    %ecx,%esi
  108147:	74 5f                	je     1081a8 <trap_init+0xc8>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108149:	83 fd 07             	cmp    $0x7,%ebp
  10814c:	76 f2                	jbe    108140 <trap_init+0x60>
  10814e:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  108154:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  108158:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10815c:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  108162:	89 44 24 10          	mov    %eax,0x10(%esp)
  108166:	8d 83 5f 87 ff ff    	lea    -0x78a1(%ebx),%eax
  10816c:	89 44 24 08          	mov    %eax,0x8(%esp)
  108170:	89 6c 24 40          	mov    %ebp,0x40(%esp)
  108174:	89 cd                	mov    %ecx,%ebp
  108176:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10817d:	00 
  10817e:	66 90                	xchg   %ax,%ax
  108180:	ff 74 24 08          	push   0x8(%esp)
    for(int i = 0; i < 32; i++){
  108184:	83 c6 04             	add    $0x4,%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108187:	ff 74 24 10          	push   0x10(%esp)
  10818b:	6a 18                	push   $0x18
  10818d:	ff 74 24 1c          	push   0x1c(%esp)
  108191:	e8 ca bf ff ff       	call   104160 <debug_panic>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108196:	89 7e fc             	mov    %edi,-0x4(%esi)
    for(int i = 0; i < 32; i++){
  108199:	83 c4 10             	add    $0x10,%esp
  10819c:	39 ee                	cmp    %ebp,%esi
  10819e:	75 e0                	jne    108180 <trap_init+0xa0>
  1081a0:	8b 54 24 1c          	mov    0x1c(%esp),%edx
  1081a4:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  1081a8:	8b 44 24 14          	mov    0x14(%esp),%eax
  1081ac:	8d b4 02 80 00 00 00 	lea    0x80(%edx,%eax,1),%esi
  1081b3:	8d 8c 02 a4 00 00 00 	lea    0xa4(%edx,%eax,1),%ecx
  1081ba:	c7 c0 a0 7e 10 00    	mov    $0x107ea0,%eax
  1081c0:	eb 0f                	jmp    1081d1 <trap_init+0xf1>
  1081c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  1081c8:	89 06                	mov    %eax,(%esi)
        trap_handler_register(cpu_idx, i, &exception_handler);
    }
    // interrupts (32-41)
    for(int i = T_IRQ0; i < 9 + T_IRQ0; i++){
  1081ca:	83 c6 04             	add    $0x4,%esi
  1081cd:	39 ce                	cmp    %ecx,%esi
  1081cf:	74 50                	je     108221 <trap_init+0x141>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  1081d1:	83 fd 07             	cmp    $0x7,%ebp
  1081d4:	76 f2                	jbe    1081c8 <trap_init+0xe8>
  1081d6:	8d 93 b5 80 ff ff    	lea    -0x7f4b(%ebx),%edx
  1081dc:	8d bb 5f 87 ff ff    	lea    -0x78a1(%ebx),%edi
  1081e2:	89 6c 24 40          	mov    %ebp,0x40(%esp)
  1081e6:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1081ea:	8d 93 84 91 ff ff    	lea    -0x6e7c(%ebx),%edx
  1081f0:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1081f4:	89 d5                	mov    %edx,%ebp
  1081f6:	89 cf                	mov    %ecx,%edi
  1081f8:	89 44 24 10          	mov    %eax,0x10(%esp)
    for(int i = T_IRQ0; i < 9 + T_IRQ0; i++){
  1081fc:	83 c6 04             	add    $0x4,%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  1081ff:	ff 74 24 08          	push   0x8(%esp)
  108203:	ff 74 24 10          	push   0x10(%esp)
  108207:	6a 18                	push   $0x18
  108209:	55                   	push   %ebp
  10820a:	e8 51 bf ff ff       	call   104160 <debug_panic>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  10820f:	8b 44 24 20          	mov    0x20(%esp),%eax
    for(int i = T_IRQ0; i < 9 + T_IRQ0; i++){
  108213:	83 c4 10             	add    $0x10,%esp
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108216:	89 46 fc             	mov    %eax,-0x4(%esi)
    for(int i = T_IRQ0; i < 9 + T_IRQ0; i++){
  108219:	39 fe                	cmp    %edi,%esi
  10821b:	75 db                	jne    1081f8 <trap_init+0x118>
  10821d:	8b 6c 24 40          	mov    0x40(%esp),%ebp
        trap_handler_register(cpu_idx, i, &interrupt_handler);
    }
    // 44 - 47
    for(int i = T_IRQ0 + 12; i < T_IRQ0 + 16; i++){
  108221:	8b 54 24 18          	mov    0x18(%esp),%edx
  108225:	be 2c 00 00 00       	mov    $0x2c,%esi
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  10822a:	83 fd 07             	cmp    $0x7,%ebp
  10822d:	0f 87 59 01 00 00    	ja     10838c <trap_init+0x2ac>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108233:	89 04 b2             	mov    %eax,(%edx,%esi,4)
    for(int i = T_IRQ0 + 12; i < T_IRQ0 + 16; i++){
  108236:	83 c6 01             	add    $0x1,%esi
  108239:	83 fe 30             	cmp    $0x30,%esi
  10823c:	75 ec                	jne    10822a <trap_init+0x14a>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  10823e:	83 fd 07             	cmp    $0x7,%ebp
  108241:	0f 87 bf 00 00 00    	ja     108306 <trap_init+0x226>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108247:	c7 c2 a0 7a 10 00    	mov    $0x107aa0,%edx
  10824d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
  108251:	89 e8                	mov    %ebp,%eax
  108253:	c1 e0 0a             	shl    $0xa,%eax
  108256:	89 94 08 c0 00 00 00 	mov    %edx,0xc0(%eax,%ecx,1)
        trap_handler_register(cpu_idx, i, &interrupt_handler);
    }
    // System call 48
    trap_handler_register(cpu_idx, T_SYSCALL, &syscall_dispatch);
   
    KERN_INFO_CPU("Done.\n", cpu_idx);
  10825d:	85 ed                	test   %ebp,%ebp
  10825f:	0f 85 d6 00 00 00    	jne    10833b <trap_init+0x25b>
  108265:	83 ec 0c             	sub    $0xc,%esp
  108268:	8d b3 a2 87 ff ff    	lea    -0x785e(%ebx),%esi
  10826e:	56                   	push   %esi
  10826f:	e8 4c be ff ff       	call   1040c0 <debug_info>
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);
  108274:	8d 83 f4 91 ff ff    	lea    -0x6e0c(%ebx),%eax
  10827a:	89 04 24             	mov    %eax,(%esp)
  10827d:	e8 3e be ff ff       	call   1040c0 <debug_info>

    /* enable interrupts */
    intr_enable(IRQ_TIMER, cpu_idx);
  108282:	59                   	pop    %ecx
  108283:	5f                   	pop    %edi
  108284:	6a 00                	push   $0x0
  108286:	6a 00                	push   $0x0
  108288:	e8 d3 95 ff ff       	call   101860 <intr_enable>
    intr_enable(IRQ_KBD, cpu_idx);
  10828d:	5d                   	pop    %ebp
  10828e:	58                   	pop    %eax
  10828f:	6a 00                	push   $0x0
  108291:	6a 01                	push   $0x1
  108293:	e8 c8 95 ff ff       	call   101860 <intr_enable>
    intr_enable(IRQ_SERIAL13, cpu_idx);
  108298:	58                   	pop    %eax
  108299:	5a                   	pop    %edx
  10829a:	6a 00                	push   $0x0
  10829c:	6a 04                	push   $0x4
  10829e:	e8 bd 95 ff ff       	call   101860 <intr_enable>

    KERN_INFO_CPU("Done.\n", cpu_idx);
  1082a3:	89 34 24             	mov    %esi,(%esp)
  1082a6:	e8 15 be ff ff       	call   1040c0 <debug_info>
  1082ab:	83 c4 10             	add    $0x10,%esp
}
  1082ae:	83 c4 2c             	add    $0x2c,%esp
  1082b1:	5b                   	pop    %ebx
  1082b2:	5e                   	pop    %esi
  1082b3:	5f                   	pop    %edi
  1082b4:	5d                   	pop    %ebp
  1082b5:	c3                   	ret
  1082b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1082bd:	00 
  1082be:	66 90                	xchg   %ax,%ax
    KERN_ASSERT(inited == FALSE);
  1082c0:	8b 8b ec 5d cf 00    	mov    0xcf5dec(%ebx),%ecx
  1082c6:	85 c9                	test   %ecx,%ecx
  1082c8:	0f 85 0a 01 00 00    	jne    1083d8 <trap_init+0x2f8>
    memzero(&TRAP_HANDLER, sizeof(trap_cb_t) * 8 * 256);
  1082ce:	83 ec 08             	sub    $0x8,%esp
  1082d1:	8d 83 ec 3d cf 00    	lea    0xcf3dec(%ebx),%eax
  1082d7:	68 00 20 00 00       	push   $0x2000
  1082dc:	89 44 24 20          	mov    %eax,0x20(%esp)
  1082e0:	50                   	push   %eax
  1082e1:	e8 3a bd ff ff       	call   104020 <memzero>
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  1082e6:	8d 83 cc 91 ff ff    	lea    -0x6e34(%ebx),%eax
    inited = TRUE;
  1082ec:	c7 83 ec 5d cf 00 01 	movl   $0x1,0xcf5dec(%ebx)
  1082f3:	00 00 00 
    KERN_INFO_CPU("Register trap handlers...\n", cpu_idx);
  1082f6:	89 04 24             	mov    %eax,(%esp)
  1082f9:	e8 c2 bd ff ff       	call   1040c0 <debug_info>
  1082fe:	83 c4 10             	add    $0x10,%esp
  108301:	e9 15 fe ff ff       	jmp    10811b <trap_init+0x3b>
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  108306:	8d 83 5f 87 ff ff    	lea    -0x78a1(%ebx),%eax
  10830c:	50                   	push   %eax
  10830d:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  108313:	50                   	push   %eax
  108314:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  10831a:	6a 18                	push   $0x18
  10831c:	50                   	push   %eax
  10831d:	e8 3e be ff ff       	call   104160 <debug_panic>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  108322:	8b 4c 24 24          	mov    0x24(%esp),%ecx
  108326:	c7 c2 a0 7a 10 00    	mov    $0x107aa0,%edx
  10832c:	89 e8                	mov    %ebp,%eax
  10832e:	c1 e0 0a             	shl    $0xa,%eax
  108331:	83 c4 10             	add    $0x10,%esp
  108334:	89 94 08 c0 00 00 00 	mov    %edx,0xc0(%eax,%ecx,1)
    KERN_INFO_CPU("Done.\n", cpu_idx);
  10833b:	83 ec 08             	sub    $0x8,%esp
  10833e:	8d b3 b4 87 ff ff    	lea    -0x784c(%ebx),%esi
  108344:	55                   	push   %ebp
  108345:	56                   	push   %esi
  108346:	e8 75 bd ff ff       	call   1040c0 <debug_info>
    KERN_INFO_CPU("Enabling interrupts...\n", cpu_idx);
  10834b:	58                   	pop    %eax
  10834c:	8d 83 18 92 ff ff    	lea    -0x6de8(%ebx),%eax
  108352:	5a                   	pop    %edx
  108353:	55                   	push   %ebp
  108354:	50                   	push   %eax
  108355:	e8 66 bd ff ff       	call   1040c0 <debug_info>
    intr_enable(IRQ_TIMER, cpu_idx);
  10835a:	59                   	pop    %ecx
  10835b:	5f                   	pop    %edi
  10835c:	55                   	push   %ebp
  10835d:	6a 00                	push   $0x0
  10835f:	e8 fc 94 ff ff       	call   101860 <intr_enable>
    intr_enable(IRQ_KBD, cpu_idx);
  108364:	58                   	pop    %eax
  108365:	5a                   	pop    %edx
  108366:	55                   	push   %ebp
  108367:	6a 01                	push   $0x1
  108369:	e8 f2 94 ff ff       	call   101860 <intr_enable>
    intr_enable(IRQ_SERIAL13, cpu_idx);
  10836e:	59                   	pop    %ecx
  10836f:	5f                   	pop    %edi
  108370:	55                   	push   %ebp
  108371:	6a 04                	push   $0x4
  108373:	e8 e8 94 ff ff       	call   101860 <intr_enable>
    KERN_INFO_CPU("Done.\n", cpu_idx);
  108378:	58                   	pop    %eax
  108379:	5a                   	pop    %edx
  10837a:	55                   	push   %ebp
  10837b:	56                   	push   %esi
  10837c:	e8 3f bd ff ff       	call   1040c0 <debug_info>
  108381:	83 c4 10             	add    $0x10,%esp
}
  108384:	83 c4 2c             	add    $0x2c,%esp
  108387:	5b                   	pop    %ebx
  108388:	5e                   	pop    %esi
  108389:	5f                   	pop    %edi
  10838a:	5d                   	pop    %ebp
  10838b:	c3                   	ret
  10838c:	8d 8b 5f 87 ff ff    	lea    -0x78a1(%ebx),%ecx
  108392:	8d 93 84 91 ff ff    	lea    -0x6e7c(%ebx),%edx
  108398:	89 6c 24 40          	mov    %ebp,0x40(%esp)
  10839c:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1083a0:	8d bb b5 80 ff ff    	lea    -0x7f4b(%ebx),%edi
  1083a6:	89 d5                	mov    %edx,%ebp
  1083a8:	89 44 24 0c          	mov    %eax,0xc(%esp)
    KERN_ASSERT(0 <= cpu_idx && cpu_idx < 8);
  1083ac:	ff 74 24 08          	push   0x8(%esp)
  1083b0:	57                   	push   %edi
  1083b1:	6a 18                	push   $0x18
  1083b3:	55                   	push   %ebp
  1083b4:	e8 a7 bd ff ff       	call   104160 <debug_panic>
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  1083b9:	8b 54 24 28          	mov    0x28(%esp),%edx
  1083bd:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    for(int i = T_IRQ0 + 12; i < T_IRQ0 + 16; i++){
  1083c1:	83 c4 10             	add    $0x10,%esp
    TRAP_HANDLER[cpu_idx][trapno] = cb;
  1083c4:	89 04 b2             	mov    %eax,(%edx,%esi,4)
    for(int i = T_IRQ0 + 12; i < T_IRQ0 + 16; i++){
  1083c7:	83 c6 01             	add    $0x1,%esi
  1083ca:	83 fe 30             	cmp    $0x30,%esi
  1083cd:	75 d9                	jne    1083a8 <trap_init+0x2c8>
  1083cf:	8b 6c 24 40          	mov    0x40(%esp),%ebp
  1083d3:	e9 66 fe ff ff       	jmp    10823e <trap_init+0x15e>
    KERN_ASSERT(inited == FALSE);
  1083d8:	8d 83 4f 87 ff ff    	lea    -0x78b1(%ebx),%eax
  1083de:	50                   	push   %eax
  1083df:	8d 83 b5 80 ff ff    	lea    -0x7f4b(%ebx),%eax
  1083e5:	50                   	push   %eax
  1083e6:	8d 83 84 91 ff ff    	lea    -0x6e7c(%ebx),%eax
  1083ec:	6a 11                	push   $0x11
  1083ee:	50                   	push   %eax
  1083ef:	e8 6c bd ff ff       	call   104160 <debug_panic>
  1083f4:	83 c4 10             	add    $0x10,%esp
  1083f7:	e9 d2 fe ff ff       	jmp    1082ce <trap_init+0x1ee>
  1083fc:	66 90                	xchg   %ax,%ax
  1083fe:	66 90                	xchg   %ax,%ax

00108400 <__udivdi3>:
  108400:	f3 0f 1e fb          	endbr32
  108404:	55                   	push   %ebp
  108405:	89 e5                	mov    %esp,%ebp
  108407:	57                   	push   %edi
  108408:	56                   	push   %esi
  108409:	53                   	push   %ebx
  10840a:	83 ec 1c             	sub    $0x1c,%esp
  10840d:	8b 7d 08             	mov    0x8(%ebp),%edi
  108410:	8b 45 14             	mov    0x14(%ebp),%eax
  108413:	8b 75 0c             	mov    0xc(%ebp),%esi
  108416:	8b 5d 10             	mov    0x10(%ebp),%ebx
  108419:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  10841c:	85 c0                	test   %eax,%eax
  10841e:	75 20                	jne    108440 <__udivdi3+0x40>
  108420:	39 de                	cmp    %ebx,%esi
  108422:	73 54                	jae    108478 <__udivdi3+0x78>
  108424:	89 f8                	mov    %edi,%eax
  108426:	31 ff                	xor    %edi,%edi
  108428:	89 f2                	mov    %esi,%edx
  10842a:	f7 f3                	div    %ebx
  10842c:	89 fa                	mov    %edi,%edx
  10842e:	83 c4 1c             	add    $0x1c,%esp
  108431:	5b                   	pop    %ebx
  108432:	5e                   	pop    %esi
  108433:	5f                   	pop    %edi
  108434:	5d                   	pop    %ebp
  108435:	c3                   	ret
  108436:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  10843d:	00 
  10843e:	66 90                	xchg   %ax,%ax
  108440:	39 c6                	cmp    %eax,%esi
  108442:	73 14                	jae    108458 <__udivdi3+0x58>
  108444:	31 ff                	xor    %edi,%edi
  108446:	31 c0                	xor    %eax,%eax
  108448:	89 fa                	mov    %edi,%edx
  10844a:	83 c4 1c             	add    $0x1c,%esp
  10844d:	5b                   	pop    %ebx
  10844e:	5e                   	pop    %esi
  10844f:	5f                   	pop    %edi
  108450:	5d                   	pop    %ebp
  108451:	c3                   	ret
  108452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  108458:	0f bd f8             	bsr    %eax,%edi
  10845b:	83 f7 1f             	xor    $0x1f,%edi
  10845e:	75 48                	jne    1084a8 <__udivdi3+0xa8>
  108460:	39 f0                	cmp    %esi,%eax
  108462:	72 07                	jb     10846b <__udivdi3+0x6b>
  108464:	31 c0                	xor    %eax,%eax
  108466:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  108469:	72 dd                	jb     108448 <__udivdi3+0x48>
  10846b:	b8 01 00 00 00       	mov    $0x1,%eax
  108470:	eb d6                	jmp    108448 <__udivdi3+0x48>
  108472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  108478:	89 d9                	mov    %ebx,%ecx
  10847a:	85 db                	test   %ebx,%ebx
  10847c:	75 0b                	jne    108489 <__udivdi3+0x89>
  10847e:	b8 01 00 00 00       	mov    $0x1,%eax
  108483:	31 d2                	xor    %edx,%edx
  108485:	f7 f3                	div    %ebx
  108487:	89 c1                	mov    %eax,%ecx
  108489:	31 d2                	xor    %edx,%edx
  10848b:	89 f0                	mov    %esi,%eax
  10848d:	f7 f1                	div    %ecx
  10848f:	89 c6                	mov    %eax,%esi
  108491:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  108494:	89 f7                	mov    %esi,%edi
  108496:	f7 f1                	div    %ecx
  108498:	89 fa                	mov    %edi,%edx
  10849a:	83 c4 1c             	add    $0x1c,%esp
  10849d:	5b                   	pop    %ebx
  10849e:	5e                   	pop    %esi
  10849f:	5f                   	pop    %edi
  1084a0:	5d                   	pop    %ebp
  1084a1:	c3                   	ret
  1084a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1084a8:	89 f9                	mov    %edi,%ecx
  1084aa:	ba 20 00 00 00       	mov    $0x20,%edx
  1084af:	29 fa                	sub    %edi,%edx
  1084b1:	d3 e0                	shl    %cl,%eax
  1084b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1084b6:	89 d1                	mov    %edx,%ecx
  1084b8:	89 d8                	mov    %ebx,%eax
  1084ba:	d3 e8                	shr    %cl,%eax
  1084bc:	89 c1                	mov    %eax,%ecx
  1084be:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1084c1:	09 c1                	or     %eax,%ecx
  1084c3:	89 f0                	mov    %esi,%eax
  1084c5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  1084c8:	89 f9                	mov    %edi,%ecx
  1084ca:	d3 e3                	shl    %cl,%ebx
  1084cc:	89 d1                	mov    %edx,%ecx
  1084ce:	d3 e8                	shr    %cl,%eax
  1084d0:	89 5d dc             	mov    %ebx,-0x24(%ebp)
  1084d3:	89 f9                	mov    %edi,%ecx
  1084d5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  1084d8:	d3 e6                	shl    %cl,%esi
  1084da:	89 d1                	mov    %edx,%ecx
  1084dc:	d3 eb                	shr    %cl,%ebx
  1084de:	09 f3                	or     %esi,%ebx
  1084e0:	89 c6                	mov    %eax,%esi
  1084e2:	89 f2                	mov    %esi,%edx
  1084e4:	89 d8                	mov    %ebx,%eax
  1084e6:	f7 75 e0             	divl   -0x20(%ebp)
  1084e9:	89 d6                	mov    %edx,%esi
  1084eb:	89 c3                	mov    %eax,%ebx
  1084ed:	f7 65 dc             	mull   -0x24(%ebp)
  1084f0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  1084f3:	39 d6                	cmp    %edx,%esi
  1084f5:	72 21                	jb     108518 <__udivdi3+0x118>
  1084f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1084fa:	89 f9                	mov    %edi,%ecx
  1084fc:	d3 e2                	shl    %cl,%edx
  1084fe:	39 c2                	cmp    %eax,%edx
  108500:	73 07                	jae    108509 <__udivdi3+0x109>
  108502:	8b 55 e0             	mov    -0x20(%ebp),%edx
  108505:	39 d6                	cmp    %edx,%esi
  108507:	74 0f                	je     108518 <__udivdi3+0x118>
  108509:	89 d8                	mov    %ebx,%eax
  10850b:	31 ff                	xor    %edi,%edi
  10850d:	e9 36 ff ff ff       	jmp    108448 <__udivdi3+0x48>
  108512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  108518:	8d 43 ff             	lea    -0x1(%ebx),%eax
  10851b:	31 ff                	xor    %edi,%edi
  10851d:	e9 26 ff ff ff       	jmp    108448 <__udivdi3+0x48>
  108522:	66 90                	xchg   %ax,%ax
  108524:	66 90                	xchg   %ax,%ax
  108526:	66 90                	xchg   %ax,%ax
  108528:	66 90                	xchg   %ax,%ax
  10852a:	66 90                	xchg   %ax,%ax
  10852c:	66 90                	xchg   %ax,%ax
  10852e:	66 90                	xchg   %ax,%ax

00108530 <__umoddi3>:
  108530:	f3 0f 1e fb          	endbr32
  108534:	55                   	push   %ebp
  108535:	89 e5                	mov    %esp,%ebp
  108537:	57                   	push   %edi
  108538:	56                   	push   %esi
  108539:	53                   	push   %ebx
  10853a:	83 ec 2c             	sub    $0x2c,%esp
  10853d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  108540:	8b 45 14             	mov    0x14(%ebp),%eax
  108543:	8b 75 08             	mov    0x8(%ebp),%esi
  108546:	8b 7d 10             	mov    0x10(%ebp),%edi
  108549:	89 da                	mov    %ebx,%edx
  10854b:	85 c0                	test   %eax,%eax
  10854d:	75 19                	jne    108568 <__umoddi3+0x38>
  10854f:	39 fb                	cmp    %edi,%ebx
  108551:	73 5d                	jae    1085b0 <__umoddi3+0x80>
  108553:	89 f0                	mov    %esi,%eax
  108555:	f7 f7                	div    %edi
  108557:	89 d0                	mov    %edx,%eax
  108559:	31 d2                	xor    %edx,%edx
  10855b:	83 c4 2c             	add    $0x2c,%esp
  10855e:	5b                   	pop    %ebx
  10855f:	5e                   	pop    %esi
  108560:	5f                   	pop    %edi
  108561:	5d                   	pop    %ebp
  108562:	c3                   	ret
  108563:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  108568:	89 75 e0             	mov    %esi,-0x20(%ebp)
  10856b:	39 c3                	cmp    %eax,%ebx
  10856d:	73 11                	jae    108580 <__umoddi3+0x50>
  10856f:	89 f0                	mov    %esi,%eax
  108571:	83 c4 2c             	add    $0x2c,%esp
  108574:	5b                   	pop    %ebx
  108575:	5e                   	pop    %esi
  108576:	5f                   	pop    %edi
  108577:	5d                   	pop    %ebp
  108578:	c3                   	ret
  108579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  108580:	0f bd c8             	bsr    %eax,%ecx
  108583:	83 f1 1f             	xor    $0x1f,%ecx
  108586:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  108589:	75 45                	jne    1085d0 <__umoddi3+0xa0>
  10858b:	39 d8                	cmp    %ebx,%eax
  10858d:	0f 82 d5 00 00 00    	jb     108668 <__umoddi3+0x138>
  108593:	39 fe                	cmp    %edi,%esi
  108595:	0f 83 cd 00 00 00    	jae    108668 <__umoddi3+0x138>
  10859b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10859e:	83 c4 2c             	add    $0x2c,%esp
  1085a1:	5b                   	pop    %ebx
  1085a2:	5e                   	pop    %esi
  1085a3:	5f                   	pop    %edi
  1085a4:	5d                   	pop    %ebp
  1085a5:	c3                   	ret
  1085a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  1085ad:	00 
  1085ae:	66 90                	xchg   %ax,%ax
  1085b0:	89 f9                	mov    %edi,%ecx
  1085b2:	85 ff                	test   %edi,%edi
  1085b4:	75 0b                	jne    1085c1 <__umoddi3+0x91>
  1085b6:	b8 01 00 00 00       	mov    $0x1,%eax
  1085bb:	31 d2                	xor    %edx,%edx
  1085bd:	f7 f7                	div    %edi
  1085bf:	89 c1                	mov    %eax,%ecx
  1085c1:	89 d8                	mov    %ebx,%eax
  1085c3:	31 d2                	xor    %edx,%edx
  1085c5:	f7 f1                	div    %ecx
  1085c7:	89 f0                	mov    %esi,%eax
  1085c9:	f7 f1                	div    %ecx
  1085cb:	eb 8a                	jmp    108557 <__umoddi3+0x27>
  1085cd:	8d 76 00             	lea    0x0(%esi),%esi
  1085d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  1085d3:	ba 20 00 00 00       	mov    $0x20,%edx
  1085d8:	29 ca                	sub    %ecx,%edx
  1085da:	d3 e0                	shl    %cl,%eax
  1085dc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1085df:	89 d1                	mov    %edx,%ecx
  1085e1:	89 f8                	mov    %edi,%eax
  1085e3:	d3 e8                	shr    %cl,%eax
  1085e5:	89 55 e0             	mov    %edx,-0x20(%ebp)
  1085e8:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
  1085ec:	89 c2                	mov    %eax,%edx
  1085ee:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1085f1:	d3 e7                	shl    %cl,%edi
  1085f3:	09 c2                	or     %eax,%edx
  1085f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1085f8:	89 7d d8             	mov    %edi,-0x28(%ebp)
  1085fb:	89 f7                	mov    %esi,%edi
  1085fd:	89 55 dc             	mov    %edx,-0x24(%ebp)
  108600:	89 da                	mov    %ebx,%edx
  108602:	89 c1                	mov    %eax,%ecx
  108604:	d3 ea                	shr    %cl,%edx
  108606:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
  10860a:	d3 e3                	shl    %cl,%ebx
  10860c:	89 c1                	mov    %eax,%ecx
  10860e:	d3 ef                	shr    %cl,%edi
  108610:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
  108614:	89 f8                	mov    %edi,%eax
  108616:	d3 e6                	shl    %cl,%esi
  108618:	09 d8                	or     %ebx,%eax
  10861a:	f7 75 dc             	divl   -0x24(%ebp)
  10861d:	89 d3                	mov    %edx,%ebx
  10861f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
  108622:	89 f7                	mov    %esi,%edi
  108624:	f7 65 d8             	mull   -0x28(%ebp)
  108627:	89 c6                	mov    %eax,%esi
  108629:	89 d1                	mov    %edx,%ecx
  10862b:	39 d3                	cmp    %edx,%ebx
  10862d:	72 06                	jb     108635 <__umoddi3+0x105>
  10862f:	75 0e                	jne    10863f <__umoddi3+0x10f>
  108631:	39 c7                	cmp    %eax,%edi
  108633:	73 0a                	jae    10863f <__umoddi3+0x10f>
  108635:	2b 45 d8             	sub    -0x28(%ebp),%eax
  108638:	1b 55 dc             	sbb    -0x24(%ebp),%edx
  10863b:	89 d1                	mov    %edx,%ecx
  10863d:	89 c6                	mov    %eax,%esi
  10863f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  108642:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  108645:	29 f0                	sub    %esi,%eax
  108647:	19 cb                	sbb    %ecx,%ebx
  108649:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
  10864d:	89 da                	mov    %ebx,%edx
  10864f:	d3 e2                	shl    %cl,%edx
  108651:	89 f9                	mov    %edi,%ecx
  108653:	d3 e8                	shr    %cl,%eax
  108655:	d3 eb                	shr    %cl,%ebx
  108657:	09 d0                	or     %edx,%eax
  108659:	89 da                	mov    %ebx,%edx
  10865b:	83 c4 2c             	add    $0x2c,%esp
  10865e:	5b                   	pop    %ebx
  10865f:	5e                   	pop    %esi
  108660:	5f                   	pop    %edi
  108661:	5d                   	pop    %ebp
  108662:	c3                   	ret
  108663:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  108668:	89 da                	mov    %ebx,%edx
  10866a:	29 fe                	sub    %edi,%esi
  10866c:	19 c2                	sbb    %eax,%edx
  10866e:	89 75 e0             	mov    %esi,-0x20(%ebp)
  108671:	e9 25 ff ff ff       	jmp    10859b <__umoddi3+0x6b>
