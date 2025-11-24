
obj/user/pingpong/ping:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <proc.h>
#include <stdio.h>
#include <syscall.h>

int main(int argc, char **argv)
{
40000000:	8d 4c 24 04          	lea    0x4(%esp),%ecx
40000004:	83 e4 f0             	and    $0xfffffff0,%esp
40000007:	ff 71 fc             	push   -0x4(%ecx)
4000000a:	55                   	push   %ebp
4000000b:	89 e5                	mov    %esp,%ebp
4000000d:	56                   	push   %esi
    unsigned int i;
    printf("ping started.\n");
4000000e:	be 0a 00 00 00       	mov    $0xa,%esi
{
40000013:	53                   	push   %ebx
40000014:	e8 3e 01 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
40000019:	81 c3 db 3f 00 00    	add    $0x3fdb,%ebx
4000001f:	51                   	push   %ecx
40000020:	83 ec 18             	sub    $0x18,%esp
    printf("ping started.\n");
40000023:	8d 83 48 e0 ff ff    	lea    -0x1fb8(%ebx),%eax
40000029:	50                   	push   %eax
4000002a:	e8 91 02 00 00       	call   400002c0 <printf>
4000002f:	83 c4 10             	add    $0x10,%esp
40000032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    // fast producing
    for (i = 0; i < 10; i++)
        produce();
40000038:	e8 63 0a 00 00       	call   40000aa0 <produce>
    for (i = 0; i < 10; i++)
4000003d:	83 ee 01             	sub    $0x1,%esi
40000040:	75 f6                	jne    40000038 <main+0x38>

    // slow producing
    for (i = 0; i < 40; i++) {
        if (i % 4 == 0)
40000042:	f7 c6 03 00 00 00    	test   $0x3,%esi
40000048:	74 16                	je     40000060 <main+0x60>
4000004a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for (i = 0; i < 40; i++) {
40000050:	83 c6 01             	add    $0x1,%esi
40000053:	83 fe 28             	cmp    $0x28,%esi
40000056:	74 15                	je     4000006d <main+0x6d>
        if (i % 4 == 0)
40000058:	f7 c6 03 00 00 00    	test   $0x3,%esi
4000005e:	75 f0                	jne    40000050 <main+0x50>
            produce();
40000060:	e8 3b 0a 00 00       	call   40000aa0 <produce>
    for (i = 0; i < 40; i++) {
40000065:	83 c6 01             	add    $0x1,%esi
40000068:	83 fe 28             	cmp    $0x28,%esi
4000006b:	75 eb                	jne    40000058 <main+0x58>
    }

    return 0;
}
4000006d:	8d 65 f4             	lea    -0xc(%ebp),%esp
40000070:	31 c0                	xor    %eax,%eax
40000072:	59                   	pop    %ecx
40000073:	5b                   	pop    %ebx
40000074:	5e                   	pop    %esi
40000075:	5d                   	pop    %ebp
40000076:	8d 61 fc             	lea    -0x4(%ecx),%esp
40000079:	c3                   	ret

4000007a <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
4000007a:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000080:	75 04                	jne    40000086 <args_exist>

40000082 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000082:	6a 00                	push   $0x0
	pushl	$0
40000084:	6a 00                	push   $0x0

40000086 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
40000086:	e8 75 ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
4000008b:	50                   	push   %eax

4000008c <spin>:
spin:
	jmp	spin
4000008c:	eb fe                	jmp    4000008c <spin>
4000008e:	66 90                	xchg   %ax,%ax

40000090 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000090:	53                   	push   %ebx
40000091:	e8 c1 00 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
40000096:	81 c3 5e 3f 00 00    	add    $0x3f5e,%ebx
4000009c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000009f:	ff 74 24 18          	push   0x18(%esp)
400000a3:	ff 74 24 18          	push   0x18(%esp)
400000a7:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
400000ad:	50                   	push   %eax
400000ae:	e8 0d 02 00 00       	call   400002c0 <printf>
    vcprintf(fmt, ap);
400000b3:	58                   	pop    %eax
400000b4:	5a                   	pop    %edx
400000b5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000b9:	50                   	push   %eax
400000ba:	ff 74 24 24          	push   0x24(%esp)
400000be:	e8 9d 01 00 00       	call   40000260 <vcprintf>
    va_end(ap);
}
400000c3:	83 c4 18             	add    $0x18,%esp
400000c6:	5b                   	pop    %ebx
400000c7:	c3                   	ret
400000c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400000cf:	00 

400000d0 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
400000d0:	53                   	push   %ebx
400000d1:	e8 81 00 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
400000d6:	81 c3 1e 3f 00 00    	add    $0x3f1e,%ebx
400000dc:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
400000df:	ff 74 24 18          	push   0x18(%esp)
400000e3:	ff 74 24 18          	push   0x18(%esp)
400000e7:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
400000ed:	50                   	push   %eax
400000ee:	e8 cd 01 00 00       	call   400002c0 <printf>
    vcprintf(fmt, ap);
400000f3:	58                   	pop    %eax
400000f4:	5a                   	pop    %edx
400000f5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000f9:	50                   	push   %eax
400000fa:	ff 74 24 24          	push   0x24(%esp)
400000fe:	e8 5d 01 00 00       	call   40000260 <vcprintf>
    va_end(ap);
}
40000103:	83 c4 18             	add    $0x18,%esp
40000106:	5b                   	pop    %ebx
40000107:	c3                   	ret
40000108:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000010f:	00 

40000110 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
40000110:	53                   	push   %ebx
40000111:	e8 41 00 00 00       	call   40000157 <__x86.get_pc_thunk.bx>
40000116:	81 c3 de 3e 00 00    	add    $0x3ede,%ebx
4000011c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
4000011f:	ff 74 24 18          	push   0x18(%esp)
40000123:	ff 74 24 18          	push   0x18(%esp)
40000127:	8d 83 24 e0 ff ff    	lea    -0x1fdc(%ebx),%eax
4000012d:	50                   	push   %eax
4000012e:	e8 8d 01 00 00       	call   400002c0 <printf>
    vcprintf(fmt, ap);
40000133:	58                   	pop    %eax
40000134:	5a                   	pop    %edx
40000135:	8d 44 24 24          	lea    0x24(%esp),%eax
40000139:	50                   	push   %eax
4000013a:	ff 74 24 24          	push   0x24(%esp)
4000013e:	e8 1d 01 00 00       	call   40000260 <vcprintf>
40000143:	83 c4 10             	add    $0x10,%esp
40000146:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000014d:	00 
4000014e:	66 90                	xchg   %ax,%ax
    va_end(ap);

    while (1)
        yield();
40000150:	e8 3b 09 00 00       	call   40000a90 <yield>
    while (1)
40000155:	eb f9                	jmp    40000150 <panic+0x40>

40000157 <__x86.get_pc_thunk.bx>:
40000157:	8b 1c 24             	mov    (%esp),%ebx
4000015a:	c3                   	ret
4000015b:	66 90                	xchg   %ax,%ax
4000015d:	66 90                	xchg   %ax,%ax
4000015f:	90                   	nop

40000160 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
40000160:	55                   	push   %ebp
40000161:	57                   	push   %edi
40000162:	56                   	push   %esi
40000163:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
40000164:	8b 44 24 14          	mov    0x14(%esp),%eax
40000168:	0f b6 00             	movzbl (%eax),%eax
4000016b:	3c 2b                	cmp    $0x2b,%al
4000016d:	0f 84 8d 00 00 00    	je     40000200 <atoi+0xa0>
        loc++;
    else if (buf[loc] == '-') {
40000173:	3c 2d                	cmp    $0x2d,%al
40000175:	74 59                	je     400001d0 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000177:	8d 50 d0             	lea    -0x30(%eax),%edx
4000017a:	80 fa 09             	cmp    $0x9,%dl
4000017d:	77 71                	ja     400001f0 <atoi+0x90>
    int negative = 0;
4000017f:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000181:	31 f6                	xor    %esi,%esi
        loc++;
40000183:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000185:	31 c9                	xor    %ecx,%ecx
40000187:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000018e:	00 
4000018f:	90                   	nop
        acc = acc * 10 + (buf[loc] - '0');
40000190:	83 e8 30             	sub    $0x30,%eax
40000193:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000196:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000199:	0f be c0             	movsbl %al,%eax
4000019c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000019f:	8b 44 24 14          	mov    0x14(%esp),%eax
400001a3:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
400001a7:	8d 68 d0             	lea    -0x30(%eax),%ebp
400001aa:	89 eb                	mov    %ebp,%ebx
400001ac:	80 fb 09             	cmp    $0x9,%bl
400001af:	76 df                	jbe    40000190 <atoi+0x30>
    }
    if (numstart == loc) {
400001b1:	39 f2                	cmp    %esi,%edx
400001b3:	74 3b                	je     400001f0 <atoi+0x90>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
400001b5:	89 c8                	mov    %ecx,%eax
400001b7:	f7 d8                	neg    %eax
400001b9:	85 ff                	test   %edi,%edi
400001bb:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
400001be:	8b 44 24 18          	mov    0x18(%esp),%eax
400001c2:	89 08                	mov    %ecx,(%eax)
    return loc;
}
400001c4:	89 d0                	mov    %edx,%eax
400001c6:	5b                   	pop    %ebx
400001c7:	5e                   	pop    %esi
400001c8:	5f                   	pop    %edi
400001c9:	5d                   	pop    %ebp
400001ca:	c3                   	ret
400001cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001d0:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
400001d4:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
400001d9:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001de:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001e2:	8d 50 d0             	lea    -0x30(%eax),%edx
400001e5:	80 fa 09             	cmp    $0x9,%dl
400001e8:	76 99                	jbe    40000183 <atoi+0x23>
400001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
400001f0:	31 d2                	xor    %edx,%edx
}
400001f2:	5b                   	pop    %ebx
400001f3:	89 d0                	mov    %edx,%eax
400001f5:	5e                   	pop    %esi
400001f6:	5f                   	pop    %edi
400001f7:	5d                   	pop    %ebp
400001f8:	c3                   	ret
400001f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000200:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
40000204:	31 ff                	xor    %edi,%edi
        loc++;
40000206:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000020b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
4000020f:	8d 50 d0             	lea    -0x30(%eax),%edx
40000212:	80 fa 09             	cmp    $0x9,%dl
40000215:	0f 86 68 ff ff ff    	jbe    40000183 <atoi+0x23>
        return 0;
4000021b:	31 d2                	xor    %edx,%edx
4000021d:	eb d3                	jmp    400001f2 <atoi+0x92>
4000021f:	90                   	nop

40000220 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
40000220:	53                   	push   %ebx
40000221:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
40000225:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000022a:	8b 02                	mov    (%edx),%eax
4000022c:	8d 48 01             	lea    0x1(%eax),%ecx
4000022f:	89 0a                	mov    %ecx,(%edx)
40000231:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
40000235:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
4000023b:	75 14                	jne    40000251 <putch+0x31>
        b->buf[b->idx] = 0;
4000023d:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
40000244:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
40000247:	31 c0                	xor    %eax,%eax
40000249:	cd 30                	int    $0x30
        b->idx = 0;
4000024b:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
40000251:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
40000255:	5b                   	pop    %ebx
40000256:	c3                   	ret
40000257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000025e:	00 
4000025f:	90                   	nop

40000260 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
40000260:	53                   	push   %ebx
40000261:	e8 f1 fe ff ff       	call   40000157 <__x86.get_pc_thunk.bx>
40000266:	81 c3 8e 3d 00 00    	add    $0x3d8e,%ebx
4000026c:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000272:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000279:	00 
    b.cnt = 0;
4000027a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000281:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000282:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000289:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000290:	8d 44 24 10          	lea    0x10(%esp),%eax
40000294:	50                   	push   %eax
40000295:	8d 83 2c c2 ff ff    	lea    -0x3dd4(%ebx),%eax
4000029b:	50                   	push   %eax
4000029c:	e8 3f 01 00 00       	call   400003e0 <vprintfmt>

    b.buf[b.idx] = 0;
400002a1:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400002a5:	8d 5c 24 20          	lea    0x20(%esp),%ebx
400002a9:	31 c0                	xor    %eax,%eax
400002ab:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
400002b0:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
400002b2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400002b6:	81 c4 28 02 00 00    	add    $0x228,%esp
400002bc:	5b                   	pop    %ebx
400002bd:	c3                   	ret
400002be:	66 90                	xchg   %ax,%ax

400002c0 <printf>:

int printf(const char *fmt, ...)
{
400002c0:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
400002c3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400002c7:	50                   	push   %eax
400002c8:	ff 74 24 1c          	push   0x1c(%esp)
400002cc:	e8 8f ff ff ff       	call   40000260 <vcprintf>
    va_end(ap);

    return cnt;
}
400002d1:	83 c4 1c             	add    $0x1c,%esp
400002d4:	c3                   	ret
400002d5:	66 90                	xchg   %ax,%ax
400002d7:	66 90                	xchg   %ax,%ax
400002d9:	66 90                	xchg   %ax,%ax
400002db:	66 90                	xchg   %ax,%ax
400002dd:	66 90                	xchg   %ax,%ax
400002df:	90                   	nop

400002e0 <printnum>:
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
400002e0:	e8 86 07 00 00       	call   40000a6b <__x86.get_pc_thunk.cx>
400002e5:	81 c1 0f 3d 00 00    	add    $0x3d0f,%ecx
{
400002eb:	55                   	push   %ebp
400002ec:	57                   	push   %edi
400002ed:	89 d7                	mov    %edx,%edi
400002ef:	56                   	push   %esi
400002f0:	89 c6                	mov    %eax,%esi
400002f2:	53                   	push   %ebx
400002f3:	83 ec 2c             	sub    $0x2c,%esp
400002f6:	8b 44 24 40          	mov    0x40(%esp),%eax
400002fa:	8b 54 24 44          	mov    0x44(%esp),%edx
400002fe:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    if (num >= base) {
40000302:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
40000309:	00 
{
4000030a:	8b 6c 24 50          	mov    0x50(%esp),%ebp
4000030e:	89 44 24 08          	mov    %eax,0x8(%esp)
40000312:	8b 44 24 48          	mov    0x48(%esp),%eax
40000316:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000031a:	8b 54 24 4c          	mov    0x4c(%esp),%edx
    if (num >= base) {
4000031e:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000322:	39 44 24 08          	cmp    %eax,0x8(%esp)
40000326:	89 44 24 10          	mov    %eax,0x10(%esp)
4000032a:	1b 4c 24 14          	sbb    0x14(%esp),%ecx
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
4000032e:	8d 5a ff             	lea    -0x1(%edx),%ebx
    if (num >= base) {
40000331:	73 55                	jae    40000388 <printnum+0xa8>
        while (--width > 0)
40000333:	83 fa 01             	cmp    $0x1,%edx
40000336:	7e 17                	jle    4000034f <printnum+0x6f>
40000338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000033f:	00 
            putch(padc, putdat);
40000340:	83 ec 08             	sub    $0x8,%esp
40000343:	57                   	push   %edi
40000344:	55                   	push   %ebp
40000345:	ff d6                	call   *%esi
        while (--width > 0)
40000347:	83 c4 10             	add    $0x10,%esp
4000034a:	83 eb 01             	sub    $0x1,%ebx
4000034d:	75 f1                	jne    40000340 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
4000034f:	89 7c 24 44          	mov    %edi,0x44(%esp)
40000353:	ff 74 24 14          	push   0x14(%esp)
40000357:	ff 74 24 14          	push   0x14(%esp)
4000035b:	ff 74 24 14          	push   0x14(%esp)
4000035f:	ff 74 24 14          	push   0x14(%esp)
40000363:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
40000367:	e8 b4 0d 00 00       	call   40001120 <__umoddi3>
4000036c:	0f be 84 03 30 e0 ff 	movsbl -0x1fd0(%ebx,%eax,1),%eax
40000373:	ff 
40000374:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000378:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000037b:	89 f0                	mov    %esi,%eax
}
4000037d:	5b                   	pop    %ebx
4000037e:	5e                   	pop    %esi
4000037f:	5f                   	pop    %edi
40000380:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000381:	ff e0                	jmp    *%eax
40000383:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000388:	83 ec 0c             	sub    $0xc,%esp
4000038b:	55                   	push   %ebp
4000038c:	53                   	push   %ebx
4000038d:	50                   	push   %eax
4000038e:	83 ec 08             	sub    $0x8,%esp
40000391:	ff 74 24 34          	push   0x34(%esp)
40000395:	ff 74 24 34          	push   0x34(%esp)
40000399:	ff 74 24 34          	push   0x34(%esp)
4000039d:	ff 74 24 34          	push   0x34(%esp)
400003a1:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
400003a5:	e8 46 0c 00 00       	call   40000ff0 <__udivdi3>
400003aa:	83 c4 18             	add    $0x18,%esp
400003ad:	52                   	push   %edx
400003ae:	89 fa                	mov    %edi,%edx
400003b0:	50                   	push   %eax
400003b1:	89 f0                	mov    %esi,%eax
400003b3:	e8 28 ff ff ff       	call   400002e0 <printnum>
400003b8:	83 c4 20             	add    $0x20,%esp
400003bb:	eb 92                	jmp    4000034f <printnum+0x6f>
400003bd:	8d 76 00             	lea    0x0(%esi),%esi

400003c0 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
400003c0:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
400003c4:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
400003c8:	8b 10                	mov    (%eax),%edx
400003ca:	3b 50 04             	cmp    0x4(%eax),%edx
400003cd:	73 0b                	jae    400003da <sprintputch+0x1a>
        *b->buf++ = ch;
400003cf:	8d 4a 01             	lea    0x1(%edx),%ecx
400003d2:	89 08                	mov    %ecx,(%eax)
400003d4:	8b 44 24 04          	mov    0x4(%esp),%eax
400003d8:	88 02                	mov    %al,(%edx)
}
400003da:	c3                   	ret
400003db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

400003e0 <vprintfmt>:
{
400003e0:	e8 7e 06 00 00       	call   40000a63 <__x86.get_pc_thunk.ax>
400003e5:	05 0f 3c 00 00       	add    $0x3c0f,%eax
400003ea:	55                   	push   %ebp
400003eb:	57                   	push   %edi
400003ec:	56                   	push   %esi
400003ed:	53                   	push   %ebx
400003ee:	83 ec 2c             	sub    $0x2c,%esp
400003f1:	8b 74 24 40          	mov    0x40(%esp),%esi
400003f5:	8b 7c 24 44          	mov    0x44(%esp),%edi
400003f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
400003fd:	8b 6c 24 48          	mov    0x48(%esp),%ebp
        while ((ch = *(unsigned char *) fmt++) != '%') {
40000401:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
40000405:	8d 5d 01             	lea    0x1(%ebp),%ebx
40000408:	83 f8 25             	cmp    $0x25,%eax
4000040b:	75 19                	jne    40000426 <vprintfmt+0x46>
4000040d:	eb 29                	jmp    40000438 <vprintfmt+0x58>
4000040f:	90                   	nop
            putch(ch, putdat);
40000410:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
40000413:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
40000416:	57                   	push   %edi
40000417:	50                   	push   %eax
40000418:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
4000041a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
4000041e:	83 c4 10             	add    $0x10,%esp
40000421:	83 f8 25             	cmp    $0x25,%eax
40000424:	74 12                	je     40000438 <vprintfmt+0x58>
            if (ch == '\0')
40000426:	85 c0                	test   %eax,%eax
40000428:	75 e6                	jne    40000410 <vprintfmt+0x30>
}
4000042a:	83 c4 2c             	add    $0x2c,%esp
4000042d:	5b                   	pop    %ebx
4000042e:	5e                   	pop    %esi
4000042f:	5f                   	pop    %edi
40000430:	5d                   	pop    %ebp
40000431:	c3                   	ret
40000432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
40000438:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
4000043d:	c6 44 24 10 20       	movb   $0x20,0x10(%esp)
        altflag = 0;
40000442:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        width = -1;
40000449:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000450:	ff 
        lflag = 0;
40000451:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000458:	00 
40000459:	89 54 24 14          	mov    %edx,0x14(%esp)
4000045d:	89 74 24 40          	mov    %esi,0x40(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000461:	0f b6 0b             	movzbl (%ebx),%ecx
40000464:	8d 6b 01             	lea    0x1(%ebx),%ebp
40000467:	8d 41 dd             	lea    -0x23(%ecx),%eax
4000046a:	3c 55                	cmp    $0x55,%al
4000046c:	77 12                	ja     40000480 <.L21>
4000046e:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000472:	0f b6 c0             	movzbl %al,%eax
40000475:	8b b4 82 58 e0 ff ff 	mov    -0x1fa8(%edx,%eax,4),%esi
4000047c:	01 d6                	add    %edx,%esi
4000047e:	ff e6                	jmp    *%esi

40000480 <.L21>:
            putch('%', putdat);
40000480:	8b 74 24 40          	mov    0x40(%esp),%esi
40000484:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
40000487:	89 dd                	mov    %ebx,%ebp
            putch('%', putdat);
40000489:	57                   	push   %edi
4000048a:	6a 25                	push   $0x25
4000048c:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
4000048e:	83 c4 10             	add    $0x10,%esp
40000491:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
40000495:	0f 84 66 ff ff ff    	je     40000401 <vprintfmt+0x21>
4000049b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
400004a0:	83 ed 01             	sub    $0x1,%ebp
400004a3:	80 7d ff 25          	cmpb   $0x25,-0x1(%ebp)
400004a7:	75 f7                	jne    400004a0 <.L21+0x20>
400004a9:	e9 53 ff ff ff       	jmp    40000401 <vprintfmt+0x21>
400004ae:	66 90                	xchg   %ax,%ax

400004b0 <.L31>:
                ch = *fmt;
400004b0:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
400004b4:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
400004b7:	89 eb                	mov    %ebp,%ebx
                precision = precision * 10 + ch - '0';
400004b9:	89 54 24 14          	mov    %edx,0x14(%esp)
                if (ch < '0' || ch > '9')
400004bd:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004c0:	83 f9 09             	cmp    $0x9,%ecx
400004c3:	77 28                	ja     400004ed <.L31+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
400004c5:	8b 74 24 40          	mov    0x40(%esp),%esi
400004c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
400004d0:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
400004d3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004d6:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
400004da:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
400004dd:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004e0:	83 f9 09             	cmp    $0x9,%ecx
400004e3:	76 eb                	jbe    400004d0 <.L31+0x20>
400004e5:	89 54 24 14          	mov    %edx,0x14(%esp)
400004e9:	89 74 24 40          	mov    %esi,0x40(%esp)
            if (width < 0)
400004ed:	8b 74 24 08          	mov    0x8(%esp),%esi
400004f1:	85 f6                	test   %esi,%esi
400004f3:	0f 89 68 ff ff ff    	jns    40000461 <vprintfmt+0x81>
                width = precision, precision = -1;
400004f9:	8b 44 24 14          	mov    0x14(%esp),%eax
400004fd:	c7 44 24 14 ff ff ff 	movl   $0xffffffff,0x14(%esp)
40000504:	ff 
40000505:	89 44 24 08          	mov    %eax,0x8(%esp)
40000509:	e9 53 ff ff ff       	jmp    40000461 <vprintfmt+0x81>

4000050e <.L35>:
            altflag = 1;
4000050e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000515:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
40000517:	e9 45 ff ff ff       	jmp    40000461 <vprintfmt+0x81>

4000051c <.L34>:
            putch(ch, putdat);
4000051c:	8b 74 24 40          	mov    0x40(%esp),%esi
40000520:	83 ec 08             	sub    $0x8,%esp
40000523:	57                   	push   %edi
40000524:	6a 25                	push   $0x25
40000526:	ff d6                	call   *%esi
            break;
40000528:	83 c4 10             	add    $0x10,%esp
4000052b:	e9 d1 fe ff ff       	jmp    40000401 <vprintfmt+0x21>

40000530 <.L33>:
            precision = va_arg(ap, int);
40000530:	8b 44 24 4c          	mov    0x4c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
40000534:	89 eb                	mov    %ebp,%ebx
            precision = va_arg(ap, int);
40000536:	8b 00                	mov    (%eax),%eax
40000538:	89 44 24 14          	mov    %eax,0x14(%esp)
4000053c:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000540:	83 c0 04             	add    $0x4,%eax
40000543:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto process_precision;
40000547:	eb a4                	jmp    400004ed <.L31+0x3d>

40000549 <.L32>:
            if (width < 0)
40000549:	8b 4c 24 08          	mov    0x8(%esp),%ecx
4000054d:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
4000054f:	89 eb                	mov    %ebp,%ebx
            if (width < 0)
40000551:	85 c9                	test   %ecx,%ecx
40000553:	0f 49 c1             	cmovns %ecx,%eax
40000556:	89 44 24 08          	mov    %eax,0x8(%esp)
            goto reswitch;
4000055a:	e9 02 ff ff ff       	jmp    40000461 <vprintfmt+0x81>

4000055f <.L30>:
            putch(va_arg(ap, int), putdat);
4000055f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000563:	8b 74 24 40          	mov    0x40(%esp),%esi
40000567:	83 ec 08             	sub    $0x8,%esp
4000056a:	57                   	push   %edi
4000056b:	8d 58 04             	lea    0x4(%eax),%ebx
4000056e:	8b 44 24 58          	mov    0x58(%esp),%eax
40000572:	ff 30                	push   (%eax)
40000574:	ff d6                	call   *%esi
            break;
40000576:	83 c4 10             	add    $0x10,%esp
            putch(va_arg(ap, int), putdat);
40000579:	89 5c 24 4c          	mov    %ebx,0x4c(%esp)
            break;
4000057d:	e9 7f fe ff ff       	jmp    40000401 <vprintfmt+0x21>

40000582 <.L24>:
    if (lflag >= 2)
40000582:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
40000587:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000058b:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
4000058f:	0f 8f d8 01 00 00    	jg     4000076d <.L25+0xe0>
        return va_arg(*ap, unsigned long);
40000595:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
40000599:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000059c:	31 db                	xor    %ebx,%ebx
4000059e:	ba 0a 00 00 00       	mov    $0xa,%edx
400005a3:	8b 09                	mov    (%ecx),%ecx
400005a5:	89 44 24 4c          	mov    %eax,0x4c(%esp)
400005a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printnum(putch, putdat, num, base, width, padc);
400005b0:	83 ec 0c             	sub    $0xc,%esp
400005b3:	0f be 44 24 1c       	movsbl 0x1c(%esp),%eax
400005b8:	50                   	push   %eax
400005b9:	89 f0                	mov    %esi,%eax
400005bb:	ff 74 24 18          	push   0x18(%esp)
400005bf:	52                   	push   %edx
400005c0:	89 fa                	mov    %edi,%edx
400005c2:	53                   	push   %ebx
400005c3:	51                   	push   %ecx
400005c4:	e8 17 fd ff ff       	call   400002e0 <printnum>
            break;
400005c9:	83 c4 20             	add    $0x20,%esp
400005cc:	e9 30 fe ff ff       	jmp    40000401 <vprintfmt+0x21>

400005d1 <.L26>:
            putch('0', putdat);
400005d1:	8b 74 24 40          	mov    0x40(%esp),%esi
400005d5:	83 ec 08             	sub    $0x8,%esp
400005d8:	57                   	push   %edi
400005d9:	6a 30                	push   $0x30
400005db:	ff d6                	call   *%esi
            putch('x', putdat);
400005dd:	59                   	pop    %ecx
400005de:	5b                   	pop    %ebx
400005df:	57                   	push   %edi
400005e0:	6a 78                	push   $0x78
            num = (unsigned long long)
400005e2:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
400005e4:	ff d6                	call   *%esi
            num = (unsigned long long)
400005e6:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            goto number;
400005ea:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
400005ef:	8b 08                	mov    (%eax),%ecx
            goto number;
400005f1:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
400005f4:	83 c0 04             	add    $0x4,%eax
400005f7:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto number;
400005fb:	eb b3                	jmp    400005b0 <.L24+0x2e>

400005fd <.L22>:
    if (lflag >= 2)
400005fd:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
40000602:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
40000606:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
4000060a:	0f 8f 6e 01 00 00    	jg     4000077e <.L25+0xf1>
        return va_arg(*ap, unsigned long);
40000610:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
40000614:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
40000617:	31 db                	xor    %ebx,%ebx
40000619:	ba 10 00 00 00       	mov    $0x10,%edx
4000061e:	8b 09                	mov    (%ecx),%ecx
40000620:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000624:	eb 8a                	jmp    400005b0 <.L24+0x2e>

40000626 <.L29>:
    if (lflag >= 2)
40000626:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
4000062b:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, long long);
4000062f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
40000633:	0f 8f 5b 01 00 00    	jg     40000794 <.L25+0x107>
        return va_arg(*ap, long);
40000639:	8b 00                	mov    (%eax),%eax
4000063b:	89 c3                	mov    %eax,%ebx
4000063d:	89 c1                	mov    %eax,%ecx
4000063f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000643:	c1 fb 1f             	sar    $0x1f,%ebx
40000646:	83 c0 04             	add    $0x4,%eax
40000649:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            if ((long long) num < 0) {
4000064d:	85 db                	test   %ebx,%ebx
4000064f:	0f 88 68 01 00 00    	js     400007bd <.L19+0xc>
        return va_arg(*ap, unsigned long long);
40000655:	ba 0a 00 00 00       	mov    $0xa,%edx
4000065a:	e9 51 ff ff ff       	jmp    400005b0 <.L24+0x2e>

4000065f <.L28>:
            lflag++;
4000065f:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000664:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
40000666:	e9 f6 fd ff ff       	jmp    40000461 <vprintfmt+0x81>

4000066b <.L27>:
            putch('X', putdat);
4000066b:	8b 74 24 40          	mov    0x40(%esp),%esi
4000066f:	83 ec 08             	sub    $0x8,%esp
40000672:	57                   	push   %edi
40000673:	6a 58                	push   $0x58
40000675:	ff d6                	call   *%esi
            putch('X', putdat);
40000677:	58                   	pop    %eax
40000678:	5a                   	pop    %edx
40000679:	57                   	push   %edi
4000067a:	6a 58                	push   $0x58
4000067c:	ff d6                	call   *%esi
            putch('X', putdat);
4000067e:	59                   	pop    %ecx
4000067f:	5b                   	pop    %ebx
40000680:	57                   	push   %edi
40000681:	6a 58                	push   $0x58
40000683:	ff d6                	call   *%esi
            break;
40000685:	83 c4 10             	add    $0x10,%esp
40000688:	e9 74 fd ff ff       	jmp    40000401 <vprintfmt+0x21>

4000068d <.L25>:
            if ((p = va_arg(ap, char *)) == NULL)
4000068d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
            if (width > 0 && padc != '-')
40000691:	8b 4c 24 08          	mov    0x8(%esp),%ecx
            if ((p = va_arg(ap, char *)) == NULL)
40000695:	8b 54 24 14          	mov    0x14(%esp),%edx
40000699:	8b 74 24 40          	mov    0x40(%esp),%esi
4000069d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
400006a0:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
400006a5:	89 44 24 14          	mov    %eax,0x14(%esp)
400006a9:	8b 44 24 4c          	mov    0x4c(%esp),%eax
400006ad:	8b 18                	mov    (%eax),%ebx
            if (width > 0 && padc != '-')
400006af:	0f 95 c0             	setne  %al
400006b2:	85 c9                	test   %ecx,%ecx
400006b4:	0f 9f c1             	setg   %cl
            if ((p = va_arg(ap, char *)) == NULL)
400006b7:	89 5c 24 18          	mov    %ebx,0x18(%esp)
            if (width > 0 && padc != '-')
400006bb:	21 c8                	and    %ecx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
400006bd:	85 db                	test   %ebx,%ebx
400006bf:	0f 84 21 01 00 00    	je     400007e6 <.L19+0x35>
            if (width > 0 && padc != '-')
400006c5:	84 c0                	test   %al,%al
400006c7:	0f 85 48 01 00 00    	jne    40000815 <.L19+0x64>
                 (ch = *p++) != '\0' && (precision < 0
400006cd:	89 d8                	mov    %ebx,%eax
400006cf:	8d 5b 01             	lea    0x1(%ebx),%ebx
400006d2:	0f be 08             	movsbl (%eax),%ecx
400006d5:	89 c8                	mov    %ecx,%eax
400006d7:	85 c9                	test   %ecx,%ecx
400006d9:	74 64                	je     4000073f <.L25+0xb2>
400006db:	89 74 24 40          	mov    %esi,0x40(%esp)
400006df:	89 d6                	mov    %edx,%esi
400006e1:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400006e5:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400006e9:	eb 2a                	jmp    40000715 <.L25+0x88>
400006eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
400006f0:	83 e8 20             	sub    $0x20,%eax
400006f3:	83 f8 5e             	cmp    $0x5e,%eax
400006f6:	76 2d                	jbe    40000725 <.L25+0x98>
                    putch('?', putdat);
400006f8:	83 ec 08             	sub    $0x8,%esp
400006fb:	57                   	push   %edi
400006fc:	6a 3f                	push   $0x3f
400006fe:	ff 54 24 50          	call   *0x50(%esp)
40000702:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
40000705:	0f be 03             	movsbl (%ebx),%eax
40000708:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
4000070b:	83 ed 01             	sub    $0x1,%ebp
                 (ch = *p++) != '\0' && (precision < 0
4000070e:	0f be c8             	movsbl %al,%ecx
40000711:	85 c9                	test   %ecx,%ecx
40000713:	74 1e                	je     40000733 <.L25+0xa6>
40000715:	85 f6                	test   %esi,%esi
40000717:	78 05                	js     4000071e <.L25+0x91>
                                         || --precision >= 0); width--)
40000719:	83 ee 01             	sub    $0x1,%esi
4000071c:	72 15                	jb     40000733 <.L25+0xa6>
                if (altflag && (ch < ' ' || ch > '~'))
4000071e:	8b 14 24             	mov    (%esp),%edx
40000721:	85 d2                	test   %edx,%edx
40000723:	75 cb                	jne    400006f0 <.L25+0x63>
                    putch(ch, putdat);
40000725:	83 ec 08             	sub    $0x8,%esp
40000728:	57                   	push   %edi
40000729:	51                   	push   %ecx
4000072a:	ff 54 24 50          	call   *0x50(%esp)
4000072e:	83 c4 10             	add    $0x10,%esp
40000731:	eb d2                	jmp    40000705 <.L25+0x78>
40000733:	89 6c 24 08          	mov    %ebp,0x8(%esp)
40000737:	8b 74 24 40          	mov    0x40(%esp),%esi
4000073b:	8b 6c 24 48          	mov    0x48(%esp),%ebp
            for (; width > 0; width--)
4000073f:	8b 44 24 08          	mov    0x8(%esp),%eax
40000743:	85 c0                	test   %eax,%eax
40000745:	7e 19                	jle    40000760 <.L25+0xd3>
40000747:	89 c3                	mov    %eax,%ebx
40000749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
40000750:	83 ec 08             	sub    $0x8,%esp
40000753:	57                   	push   %edi
40000754:	6a 20                	push   $0x20
40000756:	ff d6                	call   *%esi
            for (; width > 0; width--)
40000758:	83 c4 10             	add    $0x10,%esp
4000075b:	83 eb 01             	sub    $0x1,%ebx
4000075e:	75 f0                	jne    40000750 <.L25+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000760:	8b 44 24 14          	mov    0x14(%esp),%eax
40000764:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000768:	e9 94 fc ff ff       	jmp    40000401 <vprintfmt+0x21>
        return va_arg(*ap, unsigned long long);
4000076d:	8b 08                	mov    (%eax),%ecx
4000076f:	8b 58 04             	mov    0x4(%eax),%ebx
40000772:	83 c0 08             	add    $0x8,%eax
40000775:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000779:	e9 d7 fe ff ff       	jmp    40000655 <.L29+0x2f>
4000077e:	8b 08                	mov    (%eax),%ecx
40000780:	8b 58 04             	mov    0x4(%eax),%ebx
40000783:	83 c0 08             	add    $0x8,%eax
40000786:	ba 10 00 00 00       	mov    $0x10,%edx
4000078b:	89 44 24 4c          	mov    %eax,0x4c(%esp)
4000078f:	e9 1c fe ff ff       	jmp    400005b0 <.L24+0x2e>
        return va_arg(*ap, long long);
40000794:	8b 08                	mov    (%eax),%ecx
40000796:	8b 58 04             	mov    0x4(%eax),%ebx
40000799:	83 c0 08             	add    $0x8,%eax
4000079c:	89 44 24 4c          	mov    %eax,0x4c(%esp)
400007a0:	e9 a8 fe ff ff       	jmp    4000064d <.L29+0x27>

400007a5 <.L63>:
        switch (ch = *(unsigned char *) fmt++) {
400007a5:	c6 44 24 10 30       	movb   $0x30,0x10(%esp)
400007aa:	89 eb                	mov    %ebp,%ebx
400007ac:	e9 b0 fc ff ff       	jmp    40000461 <vprintfmt+0x81>

400007b1 <.L19>:
            padc = '-';
400007b1:	c6 44 24 10 2d       	movb   $0x2d,0x10(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400007b6:	89 eb                	mov    %ebp,%ebx
400007b8:	e9 a4 fc ff ff       	jmp    40000461 <vprintfmt+0x81>
400007bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
                putch('-', putdat);
400007c1:	83 ec 08             	sub    $0x8,%esp
                num = -(long long) num;
400007c4:	31 db                	xor    %ebx,%ebx
400007c6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
400007ca:	57                   	push   %edi
400007cb:	6a 2d                	push   $0x2d
400007cd:	ff d6                	call   *%esi
                num = -(long long) num;
400007cf:	8b 4c 24 10          	mov    0x10(%esp),%ecx
400007d3:	ba 0a 00 00 00       	mov    $0xa,%edx
400007d8:	f7 d9                	neg    %ecx
400007da:	1b 5c 24 14          	sbb    0x14(%esp),%ebx
400007de:	83 c4 10             	add    $0x10,%esp
400007e1:	e9 ca fd ff ff       	jmp    400005b0 <.L24+0x2e>
            if (width > 0 && padc != '-')
400007e6:	84 c0                	test   %al,%al
400007e8:	0f 85 99 00 00 00    	jne    40000887 <.L19+0xd6>
                 (ch = *p++) != '\0' && (precision < 0
400007ee:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400007f2:	89 74 24 40          	mov    %esi,0x40(%esp)
400007f6:	b9 28 00 00 00       	mov    $0x28,%ecx
400007fb:	89 d6                	mov    %edx,%esi
400007fd:	89 6c 24 48          	mov    %ebp,0x48(%esp)
40000801:	b8 28 00 00 00       	mov    $0x28,%eax
40000806:	8b 6c 24 08          	mov    0x8(%esp),%ebp
4000080a:	8d 9b 42 e0 ff ff    	lea    -0x1fbe(%ebx),%ebx
40000810:	e9 00 ff ff ff       	jmp    40000715 <.L25+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
40000815:	83 ec 08             	sub    $0x8,%esp
40000818:	52                   	push   %edx
40000819:	89 54 24 28          	mov    %edx,0x28(%esp)
4000081d:	ff 74 24 24          	push   0x24(%esp)
40000821:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000825:	e8 26 03 00 00       	call   40000b50 <strnlen>
4000082a:	29 44 24 18          	sub    %eax,0x18(%esp)
4000082e:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000832:	83 c4 10             	add    $0x10,%esp
40000835:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000839:	85 c9                	test   %ecx,%ecx
4000083b:	0f 8e 99 00 00 00    	jle    400008da <.L19+0x129>
                    putch(padc, putdat);
40000841:	0f be 5c 24 10       	movsbl 0x10(%esp),%ebx
40000846:	89 54 24 10          	mov    %edx,0x10(%esp)
4000084a:	89 6c 24 48          	mov    %ebp,0x48(%esp)
4000084e:	8b 6c 24 08          	mov    0x8(%esp),%ebp
40000852:	83 ec 08             	sub    $0x8,%esp
40000855:	57                   	push   %edi
40000856:	53                   	push   %ebx
40000857:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000859:	83 c4 10             	add    $0x10,%esp
4000085c:	83 ed 01             	sub    $0x1,%ebp
4000085f:	75 f1                	jne    40000852 <.L19+0xa1>
                 (ch = *p++) != '\0' && (precision < 0
40000861:	8b 44 24 18          	mov    0x18(%esp),%eax
40000865:	8b 54 24 10          	mov    0x10(%esp),%edx
40000869:	89 6c 24 08          	mov    %ebp,0x8(%esp)
4000086d:	8b 6c 24 48          	mov    0x48(%esp),%ebp
40000871:	8d 58 01             	lea    0x1(%eax),%ebx
40000874:	0f be 00             	movsbl (%eax),%eax
40000877:	0f be c8             	movsbl %al,%ecx
4000087a:	85 c9                	test   %ecx,%ecx
4000087c:	0f 85 59 fe ff ff    	jne    400006db <.L25+0x4e>
40000882:	e9 d9 fe ff ff       	jmp    40000760 <.L25+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000887:	83 ec 08             	sub    $0x8,%esp
4000088a:	52                   	push   %edx
4000088b:	8b 5c 24 18          	mov    0x18(%esp),%ebx
4000088f:	8d 8b 41 e0 ff ff    	lea    -0x1fbf(%ebx),%ecx
40000895:	89 54 24 28          	mov    %edx,0x28(%esp)
40000899:	51                   	push   %ecx
4000089a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000089e:	e8 ad 02 00 00       	call   40000b50 <strnlen>
400008a3:	29 44 24 18          	sub    %eax,0x18(%esp)
400008a7:	8b 44 24 18          	mov    0x18(%esp),%eax
400008ab:	83 c4 10             	add    $0x10,%esp
400008ae:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400008b2:	85 c0                	test   %eax,%eax
400008b4:	7f 8b                	jg     40000841 <.L19+0x90>
                 (ch = *p++) != '\0' && (precision < 0
400008b6:	b9 28 00 00 00       	mov    $0x28,%ecx
400008bb:	b8 28 00 00 00       	mov    $0x28,%eax
400008c0:	8b 5c 24 18          	mov    0x18(%esp),%ebx
400008c4:	89 74 24 40          	mov    %esi,0x40(%esp)
400008c8:	89 d6                	mov    %edx,%esi
400008ca:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400008ce:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400008d2:	83 c3 01             	add    $0x1,%ebx
400008d5:	e9 3b fe ff ff       	jmp    40000715 <.L25+0x88>
400008da:	8b 44 24 18          	mov    0x18(%esp),%eax
400008de:	0f be 08             	movsbl (%eax),%ecx
400008e1:	89 c8                	mov    %ecx,%eax
400008e3:	85 c9                	test   %ecx,%ecx
400008e5:	75 d9                	jne    400008c0 <.L19+0x10f>
400008e7:	e9 74 fe ff ff       	jmp    40000760 <.L25+0xd3>
400008ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400008f0 <printfmt>:
{
400008f0:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
400008f3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400008f7:	50                   	push   %eax
400008f8:	ff 74 24 1c          	push   0x1c(%esp)
400008fc:	ff 74 24 1c          	push   0x1c(%esp)
40000900:	ff 74 24 1c          	push   0x1c(%esp)
40000904:	e8 d7 fa ff ff       	call   400003e0 <vprintfmt>
}
40000909:	83 c4 1c             	add    $0x1c,%esp
4000090c:	c3                   	ret
4000090d:	8d 76 00             	lea    0x0(%esi),%esi

40000910 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
40000910:	e8 4e 01 00 00       	call   40000a63 <__x86.get_pc_thunk.ax>
40000915:	05 df 36 00 00       	add    $0x36df,%eax
{
4000091a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000091d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000921:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000928:	ff 
40000929:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000930:	00 
40000931:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000935:	ff 74 24 28          	push   0x28(%esp)
40000939:	ff 74 24 28          	push   0x28(%esp)
4000093d:	8d 80 cc c3 ff ff    	lea    -0x3c34(%eax),%eax
40000943:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000947:	52                   	push   %edx
40000948:	50                   	push   %eax
40000949:	e8 92 fa ff ff       	call   400003e0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
4000094e:	8b 44 24 14          	mov    0x14(%esp),%eax
40000952:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000955:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000959:	83 c4 2c             	add    $0x2c,%esp
4000095c:	c3                   	ret
4000095d:	8d 76 00             	lea    0x0(%esi),%esi

40000960 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000960:	e8 fe 00 00 00       	call   40000a63 <__x86.get_pc_thunk.ax>
40000965:	05 8f 36 00 00       	add    $0x368f,%eax
{
4000096a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000096d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000971:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000978:	ff 
40000979:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000980:	00 
40000981:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000985:	8d 54 24 28          	lea    0x28(%esp),%edx
40000989:	52                   	push   %edx
4000098a:	ff 74 24 28          	push   0x28(%esp)
4000098e:	8d 80 cc c3 ff ff    	lea    -0x3c34(%eax),%eax
40000994:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000998:	52                   	push   %edx
40000999:	50                   	push   %eax
4000099a:	e8 41 fa ff ff       	call   400003e0 <vprintfmt>
    *b.buf = '\0';
4000099f:	8b 44 24 14          	mov    0x14(%esp),%eax
400009a3:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
400009a6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009aa:	83 c4 2c             	add    $0x2c,%esp
400009ad:	c3                   	ret
400009ae:	66 90                	xchg   %ax,%ax

400009b0 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009b0:	e8 b2 00 00 00       	call   40000a67 <__x86.get_pc_thunk.dx>
400009b5:	81 c2 3f 36 00 00    	add    $0x363f,%edx
{
400009bb:	83 ec 1c             	sub    $0x1c,%esp
400009be:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009c2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
400009c6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009cd:	00 
400009ce:	89 44 24 04          	mov    %eax,0x4(%esp)
400009d2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
400009d6:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009da:	ff 74 24 2c          	push   0x2c(%esp)
400009de:	ff 74 24 2c          	push   0x2c(%esp)
400009e2:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009e6:	50                   	push   %eax
400009e7:	8d 82 cc c3 ff ff    	lea    -0x3c34(%edx),%eax
400009ed:	50                   	push   %eax
400009ee:	e8 ed f9 ff ff       	call   400003e0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009f3:	8b 44 24 14          	mov    0x14(%esp),%eax
400009f7:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009fa:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009fe:	83 c4 2c             	add    $0x2c,%esp
40000a01:	c3                   	ret
40000a02:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a09:	00 
40000a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000a10 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000a10:	e8 52 00 00 00       	call   40000a67 <__x86.get_pc_thunk.dx>
40000a15:	81 c2 df 35 00 00    	add    $0x35df,%edx
{
40000a1b:	83 ec 1c             	sub    $0x1c,%esp
40000a1e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000a22:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000a26:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000a2d:	00 
40000a2e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000a32:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000a36:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000a3a:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000a3e:	50                   	push   %eax
40000a3f:	ff 74 24 2c          	push   0x2c(%esp)
40000a43:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a47:	50                   	push   %eax
40000a48:	8d 82 cc c3 ff ff    	lea    -0x3c34(%edx),%eax
40000a4e:	50                   	push   %eax
40000a4f:	e8 8c f9 ff ff       	call   400003e0 <vprintfmt>
    *b.buf = '\0';
40000a54:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a58:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000a5b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a5f:	83 c4 2c             	add    $0x2c,%esp
40000a62:	c3                   	ret

40000a63 <__x86.get_pc_thunk.ax>:
40000a63:	8b 04 24             	mov    (%esp),%eax
40000a66:	c3                   	ret

40000a67 <__x86.get_pc_thunk.dx>:
40000a67:	8b 14 24             	mov    (%esp),%edx
40000a6a:	c3                   	ret

40000a6b <__x86.get_pc_thunk.cx>:
40000a6b:	8b 0c 24             	mov    (%esp),%ecx
40000a6e:	c3                   	ret
40000a6f:	90                   	nop

40000a70 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a70:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a71:	b8 01 00 00 00       	mov    $0x1,%eax
40000a76:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a7a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a7e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a80:	85 c0                	test   %eax,%eax
40000a82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a87:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a8a:	5b                   	pop    %ebx
40000a8b:	c3                   	ret
40000a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a90 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a90:	b8 02 00 00 00       	mov    $0x2,%eax
40000a95:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a97:	c3                   	ret
40000a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a9f:	00 

40000aa0 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000aa0:	b8 03 00 00 00       	mov    $0x3,%eax
40000aa5:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000aa7:	c3                   	ret
40000aa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000aaf:	00 

40000ab0 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000ab0:	b8 04 00 00 00       	mov    $0x4,%eax
40000ab5:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000ab7:	c3                   	ret
40000ab8:	66 90                	xchg   %ax,%ax
40000aba:	66 90                	xchg   %ax,%ax
40000abc:	66 90                	xchg   %ax,%ax
40000abe:	66 90                	xchg   %ax,%ax

40000ac0 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000ac0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000ac4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000aca:	c3                   	ret
40000acb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000ad0 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000ad0:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000ad4:	b8 01 00 00 00       	mov    $0x1,%eax
40000ad9:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000adc:	85 c0                	test   %eax,%eax
40000ade:	74 13                	je     40000af3 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000ae0:	b9 01 00 00 00       	mov    $0x1,%ecx
40000ae5:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000ae8:	f3 90                	pause
    asm volatile ("lock; xchgl %0, %1"
40000aea:	89 c8                	mov    %ecx,%eax
40000aec:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000aef:	85 c0                	test   %eax,%eax
40000af1:	75 f5                	jne    40000ae8 <spinlock_acquire+0x18>
}
40000af3:	c3                   	ret
40000af4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000afb:	00 
40000afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000b00 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000b00:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000b04:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000b06:	84 c0                	test   %al,%al
40000b08:	74 05                	je     40000b0f <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000b0a:	31 c0                	xor    %eax,%eax
40000b0c:	f0 87 02             	lock xchg %eax,(%edx)
}
40000b0f:	c3                   	ret

40000b10 <spinlock_holding>:
    return *lk;
40000b10:	8b 44 24 04          	mov    0x4(%esp),%eax
40000b14:	8b 00                	mov    (%eax),%eax
}
40000b16:	c3                   	ret
40000b17:	66 90                	xchg   %ax,%ax
40000b19:	66 90                	xchg   %ax,%ax
40000b1b:	66 90                	xchg   %ax,%ax
40000b1d:	66 90                	xchg   %ax,%ax
40000b1f:	90                   	nop

40000b20 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000b20:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000b24:	31 c0                	xor    %eax,%eax
40000b26:	80 3a 00             	cmpb   $0x0,(%edx)
40000b29:	74 15                	je     40000b40 <strlen+0x20>
40000b2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        n++;
40000b30:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000b33:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000b37:	75 f7                	jne    40000b30 <strlen+0x10>
40000b39:	c3                   	ret
40000b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000b40:	c3                   	ret
40000b41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b48:	00 
40000b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b50 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000b50:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b54:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b58:	31 c0                	xor    %eax,%eax
40000b5a:	85 d2                	test   %edx,%edx
40000b5c:	75 09                	jne    40000b67 <strnlen+0x17>
40000b5e:	c3                   	ret
40000b5f:	90                   	nop
        n++;
40000b60:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b63:	39 c2                	cmp    %eax,%edx
40000b65:	74 09                	je     40000b70 <strnlen+0x20>
40000b67:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000b6b:	75 f3                	jne    40000b60 <strnlen+0x10>
40000b6d:	c3                   	ret
40000b6e:	66 90                	xchg   %ax,%ax
    return n;
}
40000b70:	c3                   	ret
40000b71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b78:	00 
40000b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b80 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b80:	53                   	push   %ebx
40000b81:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b85:	31 c0                	xor    %eax,%eax
{
40000b87:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ((*dst++ = *src++) != '\0')
40000b90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b97:	83 c0 01             	add    $0x1,%eax
40000b9a:	84 d2                	test   %dl,%dl
40000b9c:	75 f2                	jne    40000b90 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b9e:	89 c8                	mov    %ecx,%eax
40000ba0:	5b                   	pop    %ebx
40000ba1:	c3                   	ret
40000ba2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000ba9:	00 
40000baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000bb0 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000bb0:	56                   	push   %esi
40000bb1:	53                   	push   %ebx
40000bb2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000bb6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000bba:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000bbe:	85 db                	test   %ebx,%ebx
40000bc0:	74 21                	je     40000be3 <strncpy+0x33>
40000bc2:	01 f3                	add    %esi,%ebx
40000bc4:	89 f0                	mov    %esi,%eax
40000bc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000bcd:	00 
40000bce:	66 90                	xchg   %ax,%ax
        *dst++ = *src;
40000bd0:	0f b6 0a             	movzbl (%edx),%ecx
40000bd3:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000bd6:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000bd9:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000bdc:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000bdf:	39 c3                	cmp    %eax,%ebx
40000be1:	75 ed                	jne    40000bd0 <strncpy+0x20>
    }
    return ret;
}
40000be3:	89 f0                	mov    %esi,%eax
40000be5:	5b                   	pop    %ebx
40000be6:	5e                   	pop    %esi
40000be7:	c3                   	ret
40000be8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000bef:	00 

40000bf0 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000bf0:	56                   	push   %esi
40000bf1:	53                   	push   %ebx
40000bf2:	8b 44 24 14          	mov    0x14(%esp),%eax
40000bf6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000bfa:	8b 4c 24 10          	mov    0x10(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000bfe:	85 c0                	test   %eax,%eax
40000c00:	74 29                	je     40000c2b <strlcpy+0x3b>
        while (--size > 0 && *src != '\0')
40000c02:	89 f2                	mov    %esi,%edx
40000c04:	83 e8 01             	sub    $0x1,%eax
40000c07:	74 1f                	je     40000c28 <strlcpy+0x38>
40000c09:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
40000c0c:	eb 0f                	jmp    40000c1d <strlcpy+0x2d>
40000c0e:	66 90                	xchg   %ax,%ax
            *dst++ = *src++;
40000c10:	83 c2 01             	add    $0x1,%edx
40000c13:	83 c1 01             	add    $0x1,%ecx
40000c16:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000c19:	39 da                	cmp    %ebx,%edx
40000c1b:	74 07                	je     40000c24 <strlcpy+0x34>
40000c1d:	0f b6 01             	movzbl (%ecx),%eax
40000c20:	84 c0                	test   %al,%al
40000c22:	75 ec                	jne    40000c10 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000c24:	89 d0                	mov    %edx,%eax
40000c26:	29 f0                	sub    %esi,%eax
        *dst = '\0';
40000c28:	c6 02 00             	movb   $0x0,(%edx)
}
40000c2b:	5b                   	pop    %ebx
40000c2c:	5e                   	pop    %esi
40000c2d:	c3                   	ret
40000c2e:	66 90                	xchg   %ax,%ax

40000c30 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000c30:	53                   	push   %ebx
40000c31:	8b 54 24 08          	mov    0x8(%esp),%edx
40000c35:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000c39:	0f b6 02             	movzbl (%edx),%eax
40000c3c:	84 c0                	test   %al,%al
40000c3e:	75 18                	jne    40000c58 <strcmp+0x28>
40000c40:	eb 30                	jmp    40000c72 <strcmp+0x42>
40000c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c48:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000c4c:	83 c2 01             	add    $0x1,%edx
40000c4f:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000c52:	84 c0                	test   %al,%al
40000c54:	74 12                	je     40000c68 <strcmp+0x38>
40000c56:	89 d9                	mov    %ebx,%ecx
40000c58:	0f b6 19             	movzbl (%ecx),%ebx
40000c5b:	38 c3                	cmp    %al,%bl
40000c5d:	74 e9                	je     40000c48 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c5f:	29 d8                	sub    %ebx,%eax
}
40000c61:	5b                   	pop    %ebx
40000c62:	c3                   	ret
40000c63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c68:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000c6c:	31 c0                	xor    %eax,%eax
40000c6e:	29 d8                	sub    %ebx,%eax
}
40000c70:	5b                   	pop    %ebx
40000c71:	c3                   	ret
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c72:	0f b6 19             	movzbl (%ecx),%ebx
40000c75:	31 c0                	xor    %eax,%eax
40000c77:	eb e6                	jmp    40000c5f <strcmp+0x2f>
40000c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c80 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c80:	53                   	push   %ebx
40000c81:	8b 54 24 10          	mov    0x10(%esp),%edx
40000c85:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c89:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (n > 0 && *p && *p == *q)
40000c8d:	85 d2                	test   %edx,%edx
40000c8f:	75 16                	jne    40000ca7 <strncmp+0x27>
40000c91:	eb 2d                	jmp    40000cc0 <strncmp+0x40>
40000c93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c98:	3a 19                	cmp    (%ecx),%bl
40000c9a:	75 12                	jne    40000cae <strncmp+0x2e>
        n--, p++, q++;
40000c9c:	83 c0 01             	add    $0x1,%eax
40000c9f:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000ca2:	83 ea 01             	sub    $0x1,%edx
40000ca5:	74 19                	je     40000cc0 <strncmp+0x40>
40000ca7:	0f b6 18             	movzbl (%eax),%ebx
40000caa:	84 db                	test   %bl,%bl
40000cac:	75 ea                	jne    40000c98 <strncmp+0x18>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000cae:	0f b6 00             	movzbl (%eax),%eax
40000cb1:	0f b6 11             	movzbl (%ecx),%edx
}
40000cb4:	5b                   	pop    %ebx
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000cb5:	29 d0                	sub    %edx,%eax
}
40000cb7:	c3                   	ret
40000cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cbf:	00 
        return 0;
40000cc0:	31 c0                	xor    %eax,%eax
}
40000cc2:	5b                   	pop    %ebx
40000cc3:	c3                   	ret
40000cc4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000ccb:	00 
40000ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000cd0 <strchr>:

char *strchr(const char *s, char c)
{
40000cd0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000cd4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000cd9:	0f b6 10             	movzbl (%eax),%edx
40000cdc:	84 d2                	test   %dl,%dl
40000cde:	75 13                	jne    40000cf3 <strchr+0x23>
40000ce0:	eb 1e                	jmp    40000d00 <strchr+0x30>
40000ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ce8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cec:	83 c0 01             	add    $0x1,%eax
40000cef:	84 d2                	test   %dl,%dl
40000cf1:	74 0d                	je     40000d00 <strchr+0x30>
        if (*s == c)
40000cf3:	38 d1                	cmp    %dl,%cl
40000cf5:	75 f1                	jne    40000ce8 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000cf7:	c3                   	ret
40000cf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cff:	00 
    return 0;
40000d00:	31 c0                	xor    %eax,%eax
}
40000d02:	c3                   	ret
40000d03:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d0a:	00 
40000d0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000d10 <strfind>:

char *strfind(const char *s, char c)
{
40000d10:	53                   	push   %ebx
40000d11:	8b 44 24 08          	mov    0x8(%esp),%eax
40000d15:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000d19:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000d1c:	38 d3                	cmp    %dl,%bl
40000d1e:	74 1f                	je     40000d3f <strfind+0x2f>
40000d20:	89 d1                	mov    %edx,%ecx
40000d22:	84 db                	test   %bl,%bl
40000d24:	75 0e                	jne    40000d34 <strfind+0x24>
40000d26:	eb 17                	jmp    40000d3f <strfind+0x2f>
40000d28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d2f:	00 
40000d30:	84 d2                	test   %dl,%dl
40000d32:	74 0b                	je     40000d3f <strfind+0x2f>
    for (; *s; s++)
40000d34:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000d38:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000d3b:	38 ca                	cmp    %cl,%dl
40000d3d:	75 f1                	jne    40000d30 <strfind+0x20>
            break;
    return (char *) s;
}
40000d3f:	5b                   	pop    %ebx
40000d40:	c3                   	ret
40000d41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d48:	00 
40000d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000d50 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000d50:	55                   	push   %ebp
40000d51:	57                   	push   %edi
40000d52:	56                   	push   %esi
40000d53:	53                   	push   %ebx
40000d54:	8b 54 24 14          	mov    0x14(%esp),%edx
40000d58:	8b 74 24 18          	mov    0x18(%esp),%esi
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000d5c:	0f b6 02             	movzbl (%edx),%eax
40000d5f:	3c 20                	cmp    $0x20,%al
40000d61:	75 10                	jne    40000d73 <strtol+0x23>
40000d63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d68:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d6c:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d6f:	3c 20                	cmp    $0x20,%al
40000d71:	74 f5                	je     40000d68 <strtol+0x18>
40000d73:	3c 09                	cmp    $0x9,%al
40000d75:	74 f1                	je     40000d68 <strtol+0x18>

    // plus/minus sign
    if (*s == '+')
40000d77:	3c 2b                	cmp    $0x2b,%al
40000d79:	0f 84 b1 00 00 00    	je     40000e30 <strtol+0xe0>
    int neg = 0;
40000d7f:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d81:	3c 2d                	cmp    $0x2d,%al
40000d83:	0f 84 97 00 00 00    	je     40000e20 <strtol+0xd0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d89:	0f b6 02             	movzbl (%edx),%eax
40000d8c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000d93:	ff 
40000d94:	75 1d                	jne    40000db3 <strtol+0x63>
40000d96:	3c 30                	cmp    $0x30,%al
40000d98:	0f 84 a2 00 00 00    	je     40000e40 <strtol+0xf0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d9e:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
40000da3:	19 c0                	sbb    %eax,%eax
40000da5:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000da9:	83 64 24 1c fa       	andl   $0xfffffffa,0x1c(%esp)
40000dae:	83 44 24 1c 10       	addl   $0x10,0x1c(%esp)
40000db3:	31 c9                	xor    %ecx,%ecx
40000db5:	eb 1c                	jmp    40000dd3 <strtol+0x83>
40000db7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000dbe:	00 
40000dbf:	90                   	nop
    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
40000dc0:	83 e8 30             	sub    $0x30,%eax
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000dc3:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000dc7:	7d 2a                	jge    40000df3 <strtol+0xa3>
            break;
        s++, val = (val * base) + dig;
40000dc9:	0f af 4c 24 1c       	imul   0x1c(%esp),%ecx
40000dce:	83 c2 01             	add    $0x1,%edx
40000dd1:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000dd3:	0f be 02             	movsbl (%edx),%eax
40000dd6:	8d 68 d0             	lea    -0x30(%eax),%ebp
40000dd9:	89 eb                	mov    %ebp,%ebx
40000ddb:	80 fb 09             	cmp    $0x9,%bl
40000dde:	76 e0                	jbe    40000dc0 <strtol+0x70>
        else if (*s >= 'a' && *s <= 'z')
40000de0:	8d 68 9f             	lea    -0x61(%eax),%ebp
40000de3:	89 eb                	mov    %ebp,%ebx
40000de5:	80 fb 19             	cmp    $0x19,%bl
40000de8:	77 26                	ja     40000e10 <strtol+0xc0>
            dig = *s - 'a' + 10;
40000dea:	83 e8 57             	sub    $0x57,%eax
        if (dig >= base)
40000ded:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000df1:	7c d6                	jl     40000dc9 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000df3:	85 f6                	test   %esi,%esi
40000df5:	74 02                	je     40000df9 <strtol+0xa9>
        *endptr = (char *) s;
40000df7:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000df9:	89 c8                	mov    %ecx,%eax
}
40000dfb:	5b                   	pop    %ebx
40000dfc:	5e                   	pop    %esi
    return (neg ? -val : val);
40000dfd:	f7 d8                	neg    %eax
40000dff:	85 ff                	test   %edi,%edi
}
40000e01:	5f                   	pop    %edi
40000e02:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000e03:	0f 45 c8             	cmovne %eax,%ecx
}
40000e06:	89 c8                	mov    %ecx,%eax
40000e08:	c3                   	ret
40000e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000e10:	8d 68 bf             	lea    -0x41(%eax),%ebp
40000e13:	89 eb                	mov    %ebp,%ebx
40000e15:	80 fb 19             	cmp    $0x19,%bl
40000e18:	77 d9                	ja     40000df3 <strtol+0xa3>
            dig = *s - 'A' + 10;
40000e1a:	83 e8 37             	sub    $0x37,%eax
40000e1d:	eb a4                	jmp    40000dc3 <strtol+0x73>
40000e1f:	90                   	nop
        s++, neg = 1;
40000e20:	83 c2 01             	add    $0x1,%edx
40000e23:	bf 01 00 00 00       	mov    $0x1,%edi
40000e28:	e9 5c ff ff ff       	jmp    40000d89 <strtol+0x39>
40000e2d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000e30:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000e33:	31 ff                	xor    %edi,%edi
40000e35:	e9 4f ff ff ff       	jmp    40000d89 <strtol+0x39>
40000e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000e40:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000e44:	74 25                	je     40000e6b <strtol+0x11b>
    else if (base == 0 && s[0] == '0')
40000e46:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000e4a:	85 c0                	test   %eax,%eax
40000e4c:	74 0d                	je     40000e5b <strtol+0x10b>
40000e4e:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e55:	00 
40000e56:	e9 58 ff ff ff       	jmp    40000db3 <strtol+0x63>
        s++, base = 8;
40000e5b:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000e62:	00 
40000e63:	83 c2 01             	add    $0x1,%edx
40000e66:	e9 48 ff ff ff       	jmp    40000db3 <strtol+0x63>
        s += 2, base = 16;
40000e6b:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e72:	00 
40000e73:	83 c2 02             	add    $0x2,%edx
40000e76:	e9 38 ff ff ff       	jmp    40000db3 <strtol+0x63>
40000e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000e80 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e80:	57                   	push   %edi
40000e81:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000e85:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000e89:	85 c9                	test   %ecx,%ecx
40000e8b:	74 19                	je     40000ea6 <memset+0x26>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e8d:	89 f8                	mov    %edi,%eax
40000e8f:	09 c8                	or     %ecx,%eax
40000e91:	a8 03                	test   $0x3,%al
40000e93:	75 1b                	jne    40000eb0 <memset+0x30>
        c &= 0xFF;
40000e95:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e9a:	c1 e9 02             	shr    $0x2,%ecx
40000e9d:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
        asm volatile ("cld; rep stosl\n"
40000ea3:	fc                   	cld
40000ea4:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000ea6:	89 f8                	mov    %edi,%eax
40000ea8:	5f                   	pop    %edi
40000ea9:	c3                   	ret
40000eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000eb0:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000eb4:	fc                   	cld
40000eb5:	f3 aa                	rep stos %al,%es:(%edi)
}
40000eb7:	89 f8                	mov    %edi,%eax
40000eb9:	5f                   	pop    %edi
40000eba:	c3                   	ret
40000ebb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000ec0 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000ec0:	57                   	push   %edi
40000ec1:	56                   	push   %esi
40000ec2:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000ec6:	8b 74 24 10          	mov    0x10(%esp),%esi
40000eca:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000ece:	39 c6                	cmp    %eax,%esi
40000ed0:	73 26                	jae    40000ef8 <memmove+0x38>
40000ed2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000ed5:	39 d0                	cmp    %edx,%eax
40000ed7:	73 1f                	jae    40000ef8 <memmove+0x38>
        s += n;
        d += n;
40000ed9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000edc:	89 fe                	mov    %edi,%esi
40000ede:	09 ce                	or     %ecx,%esi
40000ee0:	09 d6                	or     %edx,%esi
40000ee2:	83 e6 03             	and    $0x3,%esi
40000ee5:	74 39                	je     40000f20 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000ee7:	83 ef 01             	sub    $0x1,%edi
40000eea:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000eed:	fd                   	std
40000eee:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000ef0:	fc                   	cld
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000ef1:	5e                   	pop    %esi
40000ef2:	5f                   	pop    %edi
40000ef3:	c3                   	ret
40000ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ef8:	89 c2                	mov    %eax,%edx
40000efa:	09 ca                	or     %ecx,%edx
40000efc:	09 f2                	or     %esi,%edx
40000efe:	83 e2 03             	and    $0x3,%edx
40000f01:	74 0d                	je     40000f10 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000f03:	89 c7                	mov    %eax,%edi
40000f05:	fc                   	cld
40000f06:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000f08:	5e                   	pop    %esi
40000f09:	5f                   	pop    %edi
40000f0a:	c3                   	ret
40000f0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                          :: "D" (d), "S" (s), "c" (n / 4)
40000f10:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000f13:	89 c7                	mov    %eax,%edi
40000f15:	fc                   	cld
40000f16:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f18:	eb ee                	jmp    40000f08 <memmove+0x48>
40000f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000f20:	83 ef 04             	sub    $0x4,%edi
40000f23:	8d 72 fc             	lea    -0x4(%edx),%esi
40000f26:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000f29:	fd                   	std
40000f2a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f2c:	eb c2                	jmp    40000ef0 <memmove+0x30>
40000f2e:	66 90                	xchg   %ax,%ax

40000f30 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000f30:	eb 8e                	jmp    40000ec0 <memmove>
40000f32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f39:	00 
40000f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000f40 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000f40:	56                   	push   %esi
40000f41:	53                   	push   %ebx
40000f42:	8b 74 24 14          	mov    0x14(%esp),%esi
40000f46:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000f4a:	8b 54 24 10          	mov    0x10(%esp),%edx
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000f4e:	85 f6                	test   %esi,%esi
40000f50:	74 2e                	je     40000f80 <memcmp+0x40>
40000f52:	01 c6                	add    %eax,%esi
40000f54:	eb 14                	jmp    40000f6a <memcmp+0x2a>
40000f56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f5d:	00 
40000f5e:	66 90                	xchg   %ax,%ax
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000f60:	83 c0 01             	add    $0x1,%eax
40000f63:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000f66:	39 f0                	cmp    %esi,%eax
40000f68:	74 16                	je     40000f80 <memcmp+0x40>
        if (*s1 != *s2)
40000f6a:	0f b6 08             	movzbl (%eax),%ecx
40000f6d:	0f b6 1a             	movzbl (%edx),%ebx
40000f70:	38 d9                	cmp    %bl,%cl
40000f72:	74 ec                	je     40000f60 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f74:	0f b6 c1             	movzbl %cl,%eax
40000f77:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f79:	5b                   	pop    %ebx
40000f7a:	5e                   	pop    %esi
40000f7b:	c3                   	ret
40000f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f80:	31 c0                	xor    %eax,%eax
}
40000f82:	5b                   	pop    %ebx
40000f83:	5e                   	pop    %esi
40000f84:	c3                   	ret
40000f85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f8c:	00 
40000f8d:	8d 76 00             	lea    0x0(%esi),%esi

40000f90 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f90:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f94:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f98:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f9a:	39 d0                	cmp    %edx,%eax
40000f9c:	73 1a                	jae    40000fb8 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f9e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000fa3:	eb 0a                	jmp    40000faf <memchr+0x1f>
40000fa5:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000fa8:	83 c0 01             	add    $0x1,%eax
40000fab:	39 c2                	cmp    %eax,%edx
40000fad:	74 09                	je     40000fb8 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000faf:	38 08                	cmp    %cl,(%eax)
40000fb1:	75 f5                	jne    40000fa8 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000fb3:	c3                   	ret
40000fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000fb8:	31 c0                	xor    %eax,%eax
}
40000fba:	c3                   	ret
40000fbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000fc0 <memzero>:

void *memzero(void *v, size_t n)
{
40000fc0:	57                   	push   %edi
40000fc1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000fc5:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000fc9:	85 c9                	test   %ecx,%ecx
40000fcb:	74 0f                	je     40000fdc <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000fcd:	89 f8                	mov    %edi,%eax
40000fcf:	09 c8                	or     %ecx,%eax
40000fd1:	83 e0 03             	and    $0x3,%eax
40000fd4:	75 0a                	jne    40000fe0 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000fd6:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000fd9:	fc                   	cld
40000fda:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000fdc:	89 f8                	mov    %edi,%eax
40000fde:	5f                   	pop    %edi
40000fdf:	c3                   	ret
        asm volatile ("cld; rep stosb\n"
40000fe0:	31 c0                	xor    %eax,%eax
40000fe2:	fc                   	cld
40000fe3:	f3 aa                	rep stos %al,%es:(%edi)
}
40000fe5:	89 f8                	mov    %edi,%eax
40000fe7:	5f                   	pop    %edi
40000fe8:	c3                   	ret
40000fe9:	66 90                	xchg   %ax,%ax
40000feb:	66 90                	xchg   %ax,%ax
40000fed:	66 90                	xchg   %ax,%ax
40000fef:	90                   	nop

40000ff0 <__udivdi3>:
40000ff0:	f3 0f 1e fb          	endbr32
40000ff4:	55                   	push   %ebp
40000ff5:	89 e5                	mov    %esp,%ebp
40000ff7:	57                   	push   %edi
40000ff8:	56                   	push   %esi
40000ff9:	53                   	push   %ebx
40000ffa:	83 ec 1c             	sub    $0x1c,%esp
40000ffd:	8b 7d 08             	mov    0x8(%ebp),%edi
40001000:	8b 45 14             	mov    0x14(%ebp),%eax
40001003:	8b 75 0c             	mov    0xc(%ebp),%esi
40001006:	8b 5d 10             	mov    0x10(%ebp),%ebx
40001009:	89 7d e4             	mov    %edi,-0x1c(%ebp)
4000100c:	85 c0                	test   %eax,%eax
4000100e:	75 20                	jne    40001030 <__udivdi3+0x40>
40001010:	39 de                	cmp    %ebx,%esi
40001012:	73 54                	jae    40001068 <__udivdi3+0x78>
40001014:	89 f8                	mov    %edi,%eax
40001016:	31 ff                	xor    %edi,%edi
40001018:	89 f2                	mov    %esi,%edx
4000101a:	f7 f3                	div    %ebx
4000101c:	89 fa                	mov    %edi,%edx
4000101e:	83 c4 1c             	add    $0x1c,%esp
40001021:	5b                   	pop    %ebx
40001022:	5e                   	pop    %esi
40001023:	5f                   	pop    %edi
40001024:	5d                   	pop    %ebp
40001025:	c3                   	ret
40001026:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000102d:	00 
4000102e:	66 90                	xchg   %ax,%ax
40001030:	39 c6                	cmp    %eax,%esi
40001032:	73 14                	jae    40001048 <__udivdi3+0x58>
40001034:	31 ff                	xor    %edi,%edi
40001036:	31 c0                	xor    %eax,%eax
40001038:	89 fa                	mov    %edi,%edx
4000103a:	83 c4 1c             	add    $0x1c,%esp
4000103d:	5b                   	pop    %ebx
4000103e:	5e                   	pop    %esi
4000103f:	5f                   	pop    %edi
40001040:	5d                   	pop    %ebp
40001041:	c3                   	ret
40001042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001048:	0f bd f8             	bsr    %eax,%edi
4000104b:	83 f7 1f             	xor    $0x1f,%edi
4000104e:	75 48                	jne    40001098 <__udivdi3+0xa8>
40001050:	39 f0                	cmp    %esi,%eax
40001052:	72 07                	jb     4000105b <__udivdi3+0x6b>
40001054:	31 c0                	xor    %eax,%eax
40001056:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
40001059:	72 dd                	jb     40001038 <__udivdi3+0x48>
4000105b:	b8 01 00 00 00       	mov    $0x1,%eax
40001060:	eb d6                	jmp    40001038 <__udivdi3+0x48>
40001062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001068:	89 d9                	mov    %ebx,%ecx
4000106a:	85 db                	test   %ebx,%ebx
4000106c:	75 0b                	jne    40001079 <__udivdi3+0x89>
4000106e:	b8 01 00 00 00       	mov    $0x1,%eax
40001073:	31 d2                	xor    %edx,%edx
40001075:	f7 f3                	div    %ebx
40001077:	89 c1                	mov    %eax,%ecx
40001079:	31 d2                	xor    %edx,%edx
4000107b:	89 f0                	mov    %esi,%eax
4000107d:	f7 f1                	div    %ecx
4000107f:	89 c6                	mov    %eax,%esi
40001081:	8b 45 e4             	mov    -0x1c(%ebp),%eax
40001084:	89 f7                	mov    %esi,%edi
40001086:	f7 f1                	div    %ecx
40001088:	89 fa                	mov    %edi,%edx
4000108a:	83 c4 1c             	add    $0x1c,%esp
4000108d:	5b                   	pop    %ebx
4000108e:	5e                   	pop    %esi
4000108f:	5f                   	pop    %edi
40001090:	5d                   	pop    %ebp
40001091:	c3                   	ret
40001092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001098:	89 f9                	mov    %edi,%ecx
4000109a:	ba 20 00 00 00       	mov    $0x20,%edx
4000109f:	29 fa                	sub    %edi,%edx
400010a1:	d3 e0                	shl    %cl,%eax
400010a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
400010a6:	89 d1                	mov    %edx,%ecx
400010a8:	89 d8                	mov    %ebx,%eax
400010aa:	d3 e8                	shr    %cl,%eax
400010ac:	89 c1                	mov    %eax,%ecx
400010ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
400010b1:	09 c1                	or     %eax,%ecx
400010b3:	89 f0                	mov    %esi,%eax
400010b5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
400010b8:	89 f9                	mov    %edi,%ecx
400010ba:	d3 e3                	shl    %cl,%ebx
400010bc:	89 d1                	mov    %edx,%ecx
400010be:	d3 e8                	shr    %cl,%eax
400010c0:	89 5d dc             	mov    %ebx,-0x24(%ebp)
400010c3:	89 f9                	mov    %edi,%ecx
400010c5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
400010c8:	d3 e6                	shl    %cl,%esi
400010ca:	89 d1                	mov    %edx,%ecx
400010cc:	d3 eb                	shr    %cl,%ebx
400010ce:	09 f3                	or     %esi,%ebx
400010d0:	89 c6                	mov    %eax,%esi
400010d2:	89 f2                	mov    %esi,%edx
400010d4:	89 d8                	mov    %ebx,%eax
400010d6:	f7 75 e0             	divl   -0x20(%ebp)
400010d9:	89 d6                	mov    %edx,%esi
400010db:	89 c3                	mov    %eax,%ebx
400010dd:	f7 65 dc             	mull   -0x24(%ebp)
400010e0:	89 55 e0             	mov    %edx,-0x20(%ebp)
400010e3:	39 d6                	cmp    %edx,%esi
400010e5:	72 21                	jb     40001108 <__udivdi3+0x118>
400010e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
400010ea:	89 f9                	mov    %edi,%ecx
400010ec:	d3 e2                	shl    %cl,%edx
400010ee:	39 c2                	cmp    %eax,%edx
400010f0:	73 07                	jae    400010f9 <__udivdi3+0x109>
400010f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
400010f5:	39 d6                	cmp    %edx,%esi
400010f7:	74 0f                	je     40001108 <__udivdi3+0x118>
400010f9:	89 d8                	mov    %ebx,%eax
400010fb:	31 ff                	xor    %edi,%edi
400010fd:	e9 36 ff ff ff       	jmp    40001038 <__udivdi3+0x48>
40001102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001108:	8d 43 ff             	lea    -0x1(%ebx),%eax
4000110b:	31 ff                	xor    %edi,%edi
4000110d:	e9 26 ff ff ff       	jmp    40001038 <__udivdi3+0x48>
40001112:	66 90                	xchg   %ax,%ax
40001114:	66 90                	xchg   %ax,%ax
40001116:	66 90                	xchg   %ax,%ax
40001118:	66 90                	xchg   %ax,%ax
4000111a:	66 90                	xchg   %ax,%ax
4000111c:	66 90                	xchg   %ax,%ax
4000111e:	66 90                	xchg   %ax,%ax

40001120 <__umoddi3>:
40001120:	f3 0f 1e fb          	endbr32
40001124:	55                   	push   %ebp
40001125:	89 e5                	mov    %esp,%ebp
40001127:	57                   	push   %edi
40001128:	56                   	push   %esi
40001129:	53                   	push   %ebx
4000112a:	83 ec 2c             	sub    $0x2c,%esp
4000112d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
40001130:	8b 45 14             	mov    0x14(%ebp),%eax
40001133:	8b 75 08             	mov    0x8(%ebp),%esi
40001136:	8b 7d 10             	mov    0x10(%ebp),%edi
40001139:	89 da                	mov    %ebx,%edx
4000113b:	85 c0                	test   %eax,%eax
4000113d:	75 19                	jne    40001158 <__umoddi3+0x38>
4000113f:	39 fb                	cmp    %edi,%ebx
40001141:	73 5d                	jae    400011a0 <__umoddi3+0x80>
40001143:	89 f0                	mov    %esi,%eax
40001145:	f7 f7                	div    %edi
40001147:	89 d0                	mov    %edx,%eax
40001149:	31 d2                	xor    %edx,%edx
4000114b:	83 c4 2c             	add    $0x2c,%esp
4000114e:	5b                   	pop    %ebx
4000114f:	5e                   	pop    %esi
40001150:	5f                   	pop    %edi
40001151:	5d                   	pop    %ebp
40001152:	c3                   	ret
40001153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40001158:	89 75 e0             	mov    %esi,-0x20(%ebp)
4000115b:	39 c3                	cmp    %eax,%ebx
4000115d:	73 11                	jae    40001170 <__umoddi3+0x50>
4000115f:	89 f0                	mov    %esi,%eax
40001161:	83 c4 2c             	add    $0x2c,%esp
40001164:	5b                   	pop    %ebx
40001165:	5e                   	pop    %esi
40001166:	5f                   	pop    %edi
40001167:	5d                   	pop    %ebp
40001168:	c3                   	ret
40001169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001170:	0f bd c8             	bsr    %eax,%ecx
40001173:	83 f1 1f             	xor    $0x1f,%ecx
40001176:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
40001179:	75 45                	jne    400011c0 <__umoddi3+0xa0>
4000117b:	39 d8                	cmp    %ebx,%eax
4000117d:	0f 82 d5 00 00 00    	jb     40001258 <__umoddi3+0x138>
40001183:	39 fe                	cmp    %edi,%esi
40001185:	0f 83 cd 00 00 00    	jae    40001258 <__umoddi3+0x138>
4000118b:	8b 45 e0             	mov    -0x20(%ebp),%eax
4000118e:	83 c4 2c             	add    $0x2c,%esp
40001191:	5b                   	pop    %ebx
40001192:	5e                   	pop    %esi
40001193:	5f                   	pop    %edi
40001194:	5d                   	pop    %ebp
40001195:	c3                   	ret
40001196:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000119d:	00 
4000119e:	66 90                	xchg   %ax,%ax
400011a0:	89 f9                	mov    %edi,%ecx
400011a2:	85 ff                	test   %edi,%edi
400011a4:	75 0b                	jne    400011b1 <__umoddi3+0x91>
400011a6:	b8 01 00 00 00       	mov    $0x1,%eax
400011ab:	31 d2                	xor    %edx,%edx
400011ad:	f7 f7                	div    %edi
400011af:	89 c1                	mov    %eax,%ecx
400011b1:	89 d8                	mov    %ebx,%eax
400011b3:	31 d2                	xor    %edx,%edx
400011b5:	f7 f1                	div    %ecx
400011b7:	89 f0                	mov    %esi,%eax
400011b9:	f7 f1                	div    %ecx
400011bb:	eb 8a                	jmp    40001147 <__umoddi3+0x27>
400011bd:	8d 76 00             	lea    0x0(%esi),%esi
400011c0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
400011c3:	ba 20 00 00 00       	mov    $0x20,%edx
400011c8:	29 ca                	sub    %ecx,%edx
400011ca:	d3 e0                	shl    %cl,%eax
400011cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
400011cf:	89 d1                	mov    %edx,%ecx
400011d1:	89 f8                	mov    %edi,%eax
400011d3:	d3 e8                	shr    %cl,%eax
400011d5:	89 55 e0             	mov    %edx,-0x20(%ebp)
400011d8:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011dc:	89 c2                	mov    %eax,%edx
400011de:	8b 45 dc             	mov    -0x24(%ebp),%eax
400011e1:	d3 e7                	shl    %cl,%edi
400011e3:	09 c2                	or     %eax,%edx
400011e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
400011e8:	89 7d d8             	mov    %edi,-0x28(%ebp)
400011eb:	89 f7                	mov    %esi,%edi
400011ed:	89 55 dc             	mov    %edx,-0x24(%ebp)
400011f0:	89 da                	mov    %ebx,%edx
400011f2:	89 c1                	mov    %eax,%ecx
400011f4:	d3 ea                	shr    %cl,%edx
400011f6:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011fa:	d3 e3                	shl    %cl,%ebx
400011fc:	89 c1                	mov    %eax,%ecx
400011fe:	d3 ef                	shr    %cl,%edi
40001200:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
40001204:	89 f8                	mov    %edi,%eax
40001206:	d3 e6                	shl    %cl,%esi
40001208:	09 d8                	or     %ebx,%eax
4000120a:	f7 75 dc             	divl   -0x24(%ebp)
4000120d:	89 d3                	mov    %edx,%ebx
4000120f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
40001212:	89 f7                	mov    %esi,%edi
40001214:	f7 65 d8             	mull   -0x28(%ebp)
40001217:	89 c6                	mov    %eax,%esi
40001219:	89 d1                	mov    %edx,%ecx
4000121b:	39 d3                	cmp    %edx,%ebx
4000121d:	72 06                	jb     40001225 <__umoddi3+0x105>
4000121f:	75 0e                	jne    4000122f <__umoddi3+0x10f>
40001221:	39 c7                	cmp    %eax,%edi
40001223:	73 0a                	jae    4000122f <__umoddi3+0x10f>
40001225:	2b 45 d8             	sub    -0x28(%ebp),%eax
40001228:	1b 55 dc             	sbb    -0x24(%ebp),%edx
4000122b:	89 d1                	mov    %edx,%ecx
4000122d:	89 c6                	mov    %eax,%esi
4000122f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
40001232:	8b 7d e4             	mov    -0x1c(%ebp),%edi
40001235:	29 f0                	sub    %esi,%eax
40001237:	19 cb                	sbb    %ecx,%ebx
40001239:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
4000123d:	89 da                	mov    %ebx,%edx
4000123f:	d3 e2                	shl    %cl,%edx
40001241:	89 f9                	mov    %edi,%ecx
40001243:	d3 e8                	shr    %cl,%eax
40001245:	d3 eb                	shr    %cl,%ebx
40001247:	09 d0                	or     %edx,%eax
40001249:	89 da                	mov    %ebx,%edx
4000124b:	83 c4 2c             	add    $0x2c,%esp
4000124e:	5b                   	pop    %ebx
4000124f:	5e                   	pop    %esi
40001250:	5f                   	pop    %edi
40001251:	5d                   	pop    %ebp
40001252:	c3                   	ret
40001253:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40001258:	89 da                	mov    %ebx,%edx
4000125a:	29 fe                	sub    %edi,%esi
4000125c:	19 c2                	sbb    %eax,%edx
4000125e:	89 75 e0             	mov    %esi,-0x20(%ebp)
40001261:	e9 25 ff ff ff       	jmp    4000118b <__umoddi3+0x6b>
