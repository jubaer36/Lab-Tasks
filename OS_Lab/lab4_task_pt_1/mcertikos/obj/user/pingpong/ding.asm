
obj/user/pingpong/ding:     file format elf32-i386


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
4000000d:	53                   	push   %ebx
4000000e:	e8 04 01 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
40000013:	81 c3 e1 3f 00 00    	add    $0x3fe1,%ebx
40000019:	51                   	push   %ecx
    printf("ding started.\n");
4000001a:	83 ec 0c             	sub    $0xc,%esp
4000001d:	8d 83 48 e0 ff ff    	lea    -0x1fb8(%ebx),%eax
40000023:	50                   	push   %eax
40000024:	e8 57 02 00 00       	call   40000280 <printf>
    return 0;
}
40000029:	83 c4 10             	add    $0x10,%esp
4000002c:	8d 65 f8             	lea    -0x8(%ebp),%esp
4000002f:	31 c0                	xor    %eax,%eax
40000031:	59                   	pop    %ecx
40000032:	5b                   	pop    %ebx
40000033:	5d                   	pop    %ebp
40000034:	8d 61 fc             	lea    -0x4(%ecx),%esp
40000037:	c3                   	ret

40000038 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000038:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
4000003e:	75 04                	jne    40000044 <args_exist>

40000040 <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
40000040:	6a 00                	push   $0x0
	pushl	$0
40000042:	6a 00                	push   $0x0

40000044 <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
40000044:	e8 b7 ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000049:	50                   	push   %eax

4000004a <spin>:
spin:
	jmp	spin
4000004a:	eb fe                	jmp    4000004a <spin>
4000004c:	66 90                	xchg   %ax,%ax
4000004e:	66 90                	xchg   %ax,%ax

40000050 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000050:	53                   	push   %ebx
40000051:	e8 c1 00 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
40000056:	81 c3 9e 3f 00 00    	add    $0x3f9e,%ebx
4000005c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000005f:	ff 74 24 18          	push   0x18(%esp)
40000063:	ff 74 24 18          	push   0x18(%esp)
40000067:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
4000006d:	50                   	push   %eax
4000006e:	e8 0d 02 00 00       	call   40000280 <printf>
    vcprintf(fmt, ap);
40000073:	58                   	pop    %eax
40000074:	5a                   	pop    %edx
40000075:	8d 44 24 24          	lea    0x24(%esp),%eax
40000079:	50                   	push   %eax
4000007a:	ff 74 24 24          	push   0x24(%esp)
4000007e:	e8 9d 01 00 00       	call   40000220 <vcprintf>
    va_end(ap);
}
40000083:	83 c4 18             	add    $0x18,%esp
40000086:	5b                   	pop    %ebx
40000087:	c3                   	ret
40000088:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000008f:	00 

40000090 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
40000090:	53                   	push   %ebx
40000091:	e8 81 00 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
40000096:	81 c3 5e 3f 00 00    	add    $0x3f5e,%ebx
4000009c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
4000009f:	ff 74 24 18          	push   0x18(%esp)
400000a3:	ff 74 24 18          	push   0x18(%esp)
400000a7:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
400000ad:	50                   	push   %eax
400000ae:	e8 cd 01 00 00       	call   40000280 <printf>
    vcprintf(fmt, ap);
400000b3:	58                   	pop    %eax
400000b4:	5a                   	pop    %edx
400000b5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000b9:	50                   	push   %eax
400000ba:	ff 74 24 24          	push   0x24(%esp)
400000be:	e8 5d 01 00 00       	call   40000220 <vcprintf>
    va_end(ap);
}
400000c3:	83 c4 18             	add    $0x18,%esp
400000c6:	5b                   	pop    %ebx
400000c7:	c3                   	ret
400000c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400000cf:	00 

400000d0 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
400000d0:	53                   	push   %ebx
400000d1:	e8 41 00 00 00       	call   40000117 <__x86.get_pc_thunk.bx>
400000d6:	81 c3 1e 3f 00 00    	add    $0x3f1e,%ebx
400000dc:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
400000df:	ff 74 24 18          	push   0x18(%esp)
400000e3:	ff 74 24 18          	push   0x18(%esp)
400000e7:	8d 83 24 e0 ff ff    	lea    -0x1fdc(%ebx),%eax
400000ed:	50                   	push   %eax
400000ee:	e8 8d 01 00 00       	call   40000280 <printf>
    vcprintf(fmt, ap);
400000f3:	58                   	pop    %eax
400000f4:	5a                   	pop    %edx
400000f5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000f9:	50                   	push   %eax
400000fa:	ff 74 24 24          	push   0x24(%esp)
400000fe:	e8 1d 01 00 00       	call   40000220 <vcprintf>
40000103:	83 c4 10             	add    $0x10,%esp
40000106:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000010d:	00 
4000010e:	66 90                	xchg   %ax,%ax
    va_end(ap);

    while (1)
        yield();
40000110:	e8 3b 09 00 00       	call   40000a50 <yield>
    while (1)
40000115:	eb f9                	jmp    40000110 <panic+0x40>

40000117 <__x86.get_pc_thunk.bx>:
40000117:	8b 1c 24             	mov    (%esp),%ebx
4000011a:	c3                   	ret
4000011b:	66 90                	xchg   %ax,%ax
4000011d:	66 90                	xchg   %ax,%ax
4000011f:	90                   	nop

40000120 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
40000120:	55                   	push   %ebp
40000121:	57                   	push   %edi
40000122:	56                   	push   %esi
40000123:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
40000124:	8b 44 24 14          	mov    0x14(%esp),%eax
40000128:	0f b6 00             	movzbl (%eax),%eax
4000012b:	3c 2b                	cmp    $0x2b,%al
4000012d:	0f 84 8d 00 00 00    	je     400001c0 <atoi+0xa0>
        loc++;
    else if (buf[loc] == '-') {
40000133:	3c 2d                	cmp    $0x2d,%al
40000135:	74 59                	je     40000190 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000137:	8d 50 d0             	lea    -0x30(%eax),%edx
4000013a:	80 fa 09             	cmp    $0x9,%dl
4000013d:	77 71                	ja     400001b0 <atoi+0x90>
    int negative = 0;
4000013f:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000141:	31 f6                	xor    %esi,%esi
        loc++;
40000143:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000145:	31 c9                	xor    %ecx,%ecx
40000147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000014e:	00 
4000014f:	90                   	nop
        acc = acc * 10 + (buf[loc] - '0');
40000150:	83 e8 30             	sub    $0x30,%eax
40000153:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000156:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000159:	0f be c0             	movsbl %al,%eax
4000015c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000015f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000163:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000167:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000016a:	89 eb                	mov    %ebp,%ebx
4000016c:	80 fb 09             	cmp    $0x9,%bl
4000016f:	76 df                	jbe    40000150 <atoi+0x30>
    }
    if (numstart == loc) {
40000171:	39 f2                	cmp    %esi,%edx
40000173:	74 3b                	je     400001b0 <atoi+0x90>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
40000175:	89 c8                	mov    %ecx,%eax
40000177:	f7 d8                	neg    %eax
40000179:	85 ff                	test   %edi,%edi
4000017b:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
4000017e:	8b 44 24 18          	mov    0x18(%esp),%eax
40000182:	89 08                	mov    %ecx,(%eax)
    return loc;
}
40000184:	89 d0                	mov    %edx,%eax
40000186:	5b                   	pop    %ebx
40000187:	5e                   	pop    %esi
40000188:	5f                   	pop    %edi
40000189:	5d                   	pop    %ebp
4000018a:	c3                   	ret
4000018b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000190:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
40000194:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
40000199:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000019e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001a2:	8d 50 d0             	lea    -0x30(%eax),%edx
400001a5:	80 fa 09             	cmp    $0x9,%dl
400001a8:	76 99                	jbe    40000143 <atoi+0x23>
400001aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
400001b0:	31 d2                	xor    %edx,%edx
}
400001b2:	5b                   	pop    %ebx
400001b3:	89 d0                	mov    %edx,%eax
400001b5:	5e                   	pop    %esi
400001b6:	5f                   	pop    %edi
400001b7:	5d                   	pop    %ebp
400001b8:	c3                   	ret
400001b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001c0:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
400001c4:	31 ff                	xor    %edi,%edi
        loc++;
400001c6:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001cb:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001cf:	8d 50 d0             	lea    -0x30(%eax),%edx
400001d2:	80 fa 09             	cmp    $0x9,%dl
400001d5:	0f 86 68 ff ff ff    	jbe    40000143 <atoi+0x23>
        return 0;
400001db:	31 d2                	xor    %edx,%edx
400001dd:	eb d3                	jmp    400001b2 <atoi+0x92>
400001df:	90                   	nop

400001e0 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
400001e0:	53                   	push   %ebx
400001e1:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
400001e5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400001ea:	8b 02                	mov    (%edx),%eax
400001ec:	8d 48 01             	lea    0x1(%eax),%ecx
400001ef:	89 0a                	mov    %ecx,(%edx)
400001f1:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
400001f5:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
400001fb:	75 14                	jne    40000211 <putch+0x31>
        b->buf[b->idx] = 0;
400001fd:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
40000204:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
40000207:	31 c0                	xor    %eax,%eax
40000209:	cd 30                	int    $0x30
        b->idx = 0;
4000020b:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
40000211:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
40000215:	5b                   	pop    %ebx
40000216:	c3                   	ret
40000217:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000021e:	00 
4000021f:	90                   	nop

40000220 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
40000220:	53                   	push   %ebx
40000221:	e8 f1 fe ff ff       	call   40000117 <__x86.get_pc_thunk.bx>
40000226:	81 c3 ce 3d 00 00    	add    $0x3dce,%ebx
4000022c:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000232:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000239:	00 
    b.cnt = 0;
4000023a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000241:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000242:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000249:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000250:	8d 44 24 10          	lea    0x10(%esp),%eax
40000254:	50                   	push   %eax
40000255:	8d 83 ec c1 ff ff    	lea    -0x3e14(%ebx),%eax
4000025b:	50                   	push   %eax
4000025c:	e8 3f 01 00 00       	call   400003a0 <vprintfmt>

    b.buf[b.idx] = 0;
40000261:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000265:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000269:	31 c0                	xor    %eax,%eax
4000026b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000270:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
40000272:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000276:	81 c4 28 02 00 00    	add    $0x228,%esp
4000027c:	5b                   	pop    %ebx
4000027d:	c3                   	ret
4000027e:	66 90                	xchg   %ax,%ax

40000280 <printf>:

int printf(const char *fmt, ...)
{
40000280:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
40000283:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000287:	50                   	push   %eax
40000288:	ff 74 24 1c          	push   0x1c(%esp)
4000028c:	e8 8f ff ff ff       	call   40000220 <vcprintf>
    va_end(ap);

    return cnt;
}
40000291:	83 c4 1c             	add    $0x1c,%esp
40000294:	c3                   	ret
40000295:	66 90                	xchg   %ax,%ax
40000297:	66 90                	xchg   %ax,%ax
40000299:	66 90                	xchg   %ax,%ax
4000029b:	66 90                	xchg   %ax,%ax
4000029d:	66 90                	xchg   %ax,%ax
4000029f:	90                   	nop

400002a0 <printnum>:
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
400002a0:	e8 86 07 00 00       	call   40000a2b <__x86.get_pc_thunk.cx>
400002a5:	81 c1 4f 3d 00 00    	add    $0x3d4f,%ecx
{
400002ab:	55                   	push   %ebp
400002ac:	57                   	push   %edi
400002ad:	89 d7                	mov    %edx,%edi
400002af:	56                   	push   %esi
400002b0:	89 c6                	mov    %eax,%esi
400002b2:	53                   	push   %ebx
400002b3:	83 ec 2c             	sub    $0x2c,%esp
400002b6:	8b 44 24 40          	mov    0x40(%esp),%eax
400002ba:	8b 54 24 44          	mov    0x44(%esp),%edx
400002be:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    if (num >= base) {
400002c2:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
400002c9:	00 
{
400002ca:	8b 6c 24 50          	mov    0x50(%esp),%ebp
400002ce:	89 44 24 08          	mov    %eax,0x8(%esp)
400002d2:	8b 44 24 48          	mov    0x48(%esp),%eax
400002d6:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002da:	8b 54 24 4c          	mov    0x4c(%esp),%edx
    if (num >= base) {
400002de:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400002e2:	39 44 24 08          	cmp    %eax,0x8(%esp)
400002e6:	89 44 24 10          	mov    %eax,0x10(%esp)
400002ea:	1b 4c 24 14          	sbb    0x14(%esp),%ecx
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
400002ee:	8d 5a ff             	lea    -0x1(%edx),%ebx
    if (num >= base) {
400002f1:	73 55                	jae    40000348 <printnum+0xa8>
        while (--width > 0)
400002f3:	83 fa 01             	cmp    $0x1,%edx
400002f6:	7e 17                	jle    4000030f <printnum+0x6f>
400002f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400002ff:	00 
            putch(padc, putdat);
40000300:	83 ec 08             	sub    $0x8,%esp
40000303:	57                   	push   %edi
40000304:	55                   	push   %ebp
40000305:	ff d6                	call   *%esi
        while (--width > 0)
40000307:	83 c4 10             	add    $0x10,%esp
4000030a:	83 eb 01             	sub    $0x1,%ebx
4000030d:	75 f1                	jne    40000300 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
4000030f:	89 7c 24 44          	mov    %edi,0x44(%esp)
40000313:	ff 74 24 14          	push   0x14(%esp)
40000317:	ff 74 24 14          	push   0x14(%esp)
4000031b:	ff 74 24 14          	push   0x14(%esp)
4000031f:	ff 74 24 14          	push   0x14(%esp)
40000323:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
40000327:	e8 b4 0d 00 00       	call   400010e0 <__umoddi3>
4000032c:	0f be 84 03 30 e0 ff 	movsbl -0x1fd0(%ebx,%eax,1),%eax
40000333:	ff 
40000334:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000338:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000033b:	89 f0                	mov    %esi,%eax
}
4000033d:	5b                   	pop    %ebx
4000033e:	5e                   	pop    %esi
4000033f:	5f                   	pop    %edi
40000340:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000341:	ff e0                	jmp    *%eax
40000343:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000348:	83 ec 0c             	sub    $0xc,%esp
4000034b:	55                   	push   %ebp
4000034c:	53                   	push   %ebx
4000034d:	50                   	push   %eax
4000034e:	83 ec 08             	sub    $0x8,%esp
40000351:	ff 74 24 34          	push   0x34(%esp)
40000355:	ff 74 24 34          	push   0x34(%esp)
40000359:	ff 74 24 34          	push   0x34(%esp)
4000035d:	ff 74 24 34          	push   0x34(%esp)
40000361:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000365:	e8 46 0c 00 00       	call   40000fb0 <__udivdi3>
4000036a:	83 c4 18             	add    $0x18,%esp
4000036d:	52                   	push   %edx
4000036e:	89 fa                	mov    %edi,%edx
40000370:	50                   	push   %eax
40000371:	89 f0                	mov    %esi,%eax
40000373:	e8 28 ff ff ff       	call   400002a0 <printnum>
40000378:	83 c4 20             	add    $0x20,%esp
4000037b:	eb 92                	jmp    4000030f <printnum+0x6f>
4000037d:	8d 76 00             	lea    0x0(%esi),%esi

40000380 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
40000380:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
40000384:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
40000388:	8b 10                	mov    (%eax),%edx
4000038a:	3b 50 04             	cmp    0x4(%eax),%edx
4000038d:	73 0b                	jae    4000039a <sprintputch+0x1a>
        *b->buf++ = ch;
4000038f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000392:	89 08                	mov    %ecx,(%eax)
40000394:	8b 44 24 04          	mov    0x4(%esp),%eax
40000398:	88 02                	mov    %al,(%edx)
}
4000039a:	c3                   	ret
4000039b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

400003a0 <vprintfmt>:
{
400003a0:	e8 7e 06 00 00       	call   40000a23 <__x86.get_pc_thunk.ax>
400003a5:	05 4f 3c 00 00       	add    $0x3c4f,%eax
400003aa:	55                   	push   %ebp
400003ab:	57                   	push   %edi
400003ac:	56                   	push   %esi
400003ad:	53                   	push   %ebx
400003ae:	83 ec 2c             	sub    $0x2c,%esp
400003b1:	8b 74 24 40          	mov    0x40(%esp),%esi
400003b5:	8b 7c 24 44          	mov    0x44(%esp),%edi
400003b9:	89 44 24 0c          	mov    %eax,0xc(%esp)
400003bd:	8b 6c 24 48          	mov    0x48(%esp),%ebp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003c1:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
400003c5:	8d 5d 01             	lea    0x1(%ebp),%ebx
400003c8:	83 f8 25             	cmp    $0x25,%eax
400003cb:	75 19                	jne    400003e6 <vprintfmt+0x46>
400003cd:	eb 29                	jmp    400003f8 <vprintfmt+0x58>
400003cf:	90                   	nop
            putch(ch, putdat);
400003d0:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003d3:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
400003d6:	57                   	push   %edi
400003d7:	50                   	push   %eax
400003d8:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003da:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003de:	83 c4 10             	add    $0x10,%esp
400003e1:	83 f8 25             	cmp    $0x25,%eax
400003e4:	74 12                	je     400003f8 <vprintfmt+0x58>
            if (ch == '\0')
400003e6:	85 c0                	test   %eax,%eax
400003e8:	75 e6                	jne    400003d0 <vprintfmt+0x30>
}
400003ea:	83 c4 2c             	add    $0x2c,%esp
400003ed:	5b                   	pop    %ebx
400003ee:	5e                   	pop    %esi
400003ef:	5f                   	pop    %edi
400003f0:	5d                   	pop    %ebp
400003f1:	c3                   	ret
400003f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
400003f8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
400003fd:	c6 44 24 10 20       	movb   $0x20,0x10(%esp)
        altflag = 0;
40000402:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        width = -1;
40000409:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000410:	ff 
        lflag = 0;
40000411:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000418:	00 
40000419:	89 54 24 14          	mov    %edx,0x14(%esp)
4000041d:	89 74 24 40          	mov    %esi,0x40(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000421:	0f b6 0b             	movzbl (%ebx),%ecx
40000424:	8d 6b 01             	lea    0x1(%ebx),%ebp
40000427:	8d 41 dd             	lea    -0x23(%ecx),%eax
4000042a:	3c 55                	cmp    $0x55,%al
4000042c:	77 12                	ja     40000440 <.L21>
4000042e:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000432:	0f b6 c0             	movzbl %al,%eax
40000435:	8b b4 82 58 e0 ff ff 	mov    -0x1fa8(%edx,%eax,4),%esi
4000043c:	01 d6                	add    %edx,%esi
4000043e:	ff e6                	jmp    *%esi

40000440 <.L21>:
            putch('%', putdat);
40000440:	8b 74 24 40          	mov    0x40(%esp),%esi
40000444:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
40000447:	89 dd                	mov    %ebx,%ebp
            putch('%', putdat);
40000449:	57                   	push   %edi
4000044a:	6a 25                	push   $0x25
4000044c:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
4000044e:	83 c4 10             	add    $0x10,%esp
40000451:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
40000455:	0f 84 66 ff ff ff    	je     400003c1 <vprintfmt+0x21>
4000045b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000460:	83 ed 01             	sub    $0x1,%ebp
40000463:	80 7d ff 25          	cmpb   $0x25,-0x1(%ebp)
40000467:	75 f7                	jne    40000460 <.L21+0x20>
40000469:	e9 53 ff ff ff       	jmp    400003c1 <vprintfmt+0x21>
4000046e:	66 90                	xchg   %ax,%ax

40000470 <.L31>:
                ch = *fmt;
40000470:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
40000474:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
40000477:	89 eb                	mov    %ebp,%ebx
                precision = precision * 10 + ch - '0';
40000479:	89 54 24 14          	mov    %edx,0x14(%esp)
                if (ch < '0' || ch > '9')
4000047d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000480:	83 f9 09             	cmp    $0x9,%ecx
40000483:	77 28                	ja     400004ad <.L31+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
40000485:	8b 74 24 40          	mov    0x40(%esp),%esi
40000489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
40000490:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
40000493:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000496:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
4000049a:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
4000049d:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004a0:	83 f9 09             	cmp    $0x9,%ecx
400004a3:	76 eb                	jbe    40000490 <.L31+0x20>
400004a5:	89 54 24 14          	mov    %edx,0x14(%esp)
400004a9:	89 74 24 40          	mov    %esi,0x40(%esp)
            if (width < 0)
400004ad:	8b 74 24 08          	mov    0x8(%esp),%esi
400004b1:	85 f6                	test   %esi,%esi
400004b3:	0f 89 68 ff ff ff    	jns    40000421 <vprintfmt+0x81>
                width = precision, precision = -1;
400004b9:	8b 44 24 14          	mov    0x14(%esp),%eax
400004bd:	c7 44 24 14 ff ff ff 	movl   $0xffffffff,0x14(%esp)
400004c4:	ff 
400004c5:	89 44 24 08          	mov    %eax,0x8(%esp)
400004c9:	e9 53 ff ff ff       	jmp    40000421 <vprintfmt+0x81>

400004ce <.L35>:
            altflag = 1;
400004ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400004d5:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
400004d7:	e9 45 ff ff ff       	jmp    40000421 <vprintfmt+0x81>

400004dc <.L34>:
            putch(ch, putdat);
400004dc:	8b 74 24 40          	mov    0x40(%esp),%esi
400004e0:	83 ec 08             	sub    $0x8,%esp
400004e3:	57                   	push   %edi
400004e4:	6a 25                	push   $0x25
400004e6:	ff d6                	call   *%esi
            break;
400004e8:	83 c4 10             	add    $0x10,%esp
400004eb:	e9 d1 fe ff ff       	jmp    400003c1 <vprintfmt+0x21>

400004f0 <.L33>:
            precision = va_arg(ap, int);
400004f0:	8b 44 24 4c          	mov    0x4c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
400004f4:	89 eb                	mov    %ebp,%ebx
            precision = va_arg(ap, int);
400004f6:	8b 00                	mov    (%eax),%eax
400004f8:	89 44 24 14          	mov    %eax,0x14(%esp)
400004fc:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000500:	83 c0 04             	add    $0x4,%eax
40000503:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto process_precision;
40000507:	eb a4                	jmp    400004ad <.L31+0x3d>

40000509 <.L32>:
            if (width < 0)
40000509:	8b 4c 24 08          	mov    0x8(%esp),%ecx
4000050d:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
4000050f:	89 eb                	mov    %ebp,%ebx
            if (width < 0)
40000511:	85 c9                	test   %ecx,%ecx
40000513:	0f 49 c1             	cmovns %ecx,%eax
40000516:	89 44 24 08          	mov    %eax,0x8(%esp)
            goto reswitch;
4000051a:	e9 02 ff ff ff       	jmp    40000421 <vprintfmt+0x81>

4000051f <.L30>:
            putch(va_arg(ap, int), putdat);
4000051f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000523:	8b 74 24 40          	mov    0x40(%esp),%esi
40000527:	83 ec 08             	sub    $0x8,%esp
4000052a:	57                   	push   %edi
4000052b:	8d 58 04             	lea    0x4(%eax),%ebx
4000052e:	8b 44 24 58          	mov    0x58(%esp),%eax
40000532:	ff 30                	push   (%eax)
40000534:	ff d6                	call   *%esi
            break;
40000536:	83 c4 10             	add    $0x10,%esp
            putch(va_arg(ap, int), putdat);
40000539:	89 5c 24 4c          	mov    %ebx,0x4c(%esp)
            break;
4000053d:	e9 7f fe ff ff       	jmp    400003c1 <vprintfmt+0x21>

40000542 <.L24>:
    if (lflag >= 2)
40000542:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
40000547:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000054b:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
4000054f:	0f 8f d8 01 00 00    	jg     4000072d <.L25+0xe0>
        return va_arg(*ap, unsigned long);
40000555:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
40000559:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000055c:	31 db                	xor    %ebx,%ebx
4000055e:	ba 0a 00 00 00       	mov    $0xa,%edx
40000563:	8b 09                	mov    (%ecx),%ecx
40000565:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printnum(putch, putdat, num, base, width, padc);
40000570:	83 ec 0c             	sub    $0xc,%esp
40000573:	0f be 44 24 1c       	movsbl 0x1c(%esp),%eax
40000578:	50                   	push   %eax
40000579:	89 f0                	mov    %esi,%eax
4000057b:	ff 74 24 18          	push   0x18(%esp)
4000057f:	52                   	push   %edx
40000580:	89 fa                	mov    %edi,%edx
40000582:	53                   	push   %ebx
40000583:	51                   	push   %ecx
40000584:	e8 17 fd ff ff       	call   400002a0 <printnum>
            break;
40000589:	83 c4 20             	add    $0x20,%esp
4000058c:	e9 30 fe ff ff       	jmp    400003c1 <vprintfmt+0x21>

40000591 <.L26>:
            putch('0', putdat);
40000591:	8b 74 24 40          	mov    0x40(%esp),%esi
40000595:	83 ec 08             	sub    $0x8,%esp
40000598:	57                   	push   %edi
40000599:	6a 30                	push   $0x30
4000059b:	ff d6                	call   *%esi
            putch('x', putdat);
4000059d:	59                   	pop    %ecx
4000059e:	5b                   	pop    %ebx
4000059f:	57                   	push   %edi
400005a0:	6a 78                	push   $0x78
            num = (unsigned long long)
400005a2:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
400005a4:	ff d6                	call   *%esi
            num = (unsigned long long)
400005a6:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            goto number;
400005aa:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
400005af:	8b 08                	mov    (%eax),%ecx
            goto number;
400005b1:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
400005b4:	83 c0 04             	add    $0x4,%eax
400005b7:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto number;
400005bb:	eb b3                	jmp    40000570 <.L24+0x2e>

400005bd <.L22>:
    if (lflag >= 2)
400005bd:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
400005c2:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
400005c6:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
400005ca:	0f 8f 6e 01 00 00    	jg     4000073e <.L25+0xf1>
        return va_arg(*ap, unsigned long);
400005d0:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
400005d4:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
400005d7:	31 db                	xor    %ebx,%ebx
400005d9:	ba 10 00 00 00       	mov    $0x10,%edx
400005de:	8b 09                	mov    (%ecx),%ecx
400005e0:	89 44 24 4c          	mov    %eax,0x4c(%esp)
400005e4:	eb 8a                	jmp    40000570 <.L24+0x2e>

400005e6 <.L29>:
    if (lflag >= 2)
400005e6:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
400005eb:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, long long);
400005ef:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
400005f3:	0f 8f 5b 01 00 00    	jg     40000754 <.L25+0x107>
        return va_arg(*ap, long);
400005f9:	8b 00                	mov    (%eax),%eax
400005fb:	89 c3                	mov    %eax,%ebx
400005fd:	89 c1                	mov    %eax,%ecx
400005ff:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000603:	c1 fb 1f             	sar    $0x1f,%ebx
40000606:	83 c0 04             	add    $0x4,%eax
40000609:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            if ((long long) num < 0) {
4000060d:	85 db                	test   %ebx,%ebx
4000060f:	0f 88 68 01 00 00    	js     4000077d <.L19+0xc>
        return va_arg(*ap, unsigned long long);
40000615:	ba 0a 00 00 00       	mov    $0xa,%edx
4000061a:	e9 51 ff ff ff       	jmp    40000570 <.L24+0x2e>

4000061f <.L28>:
            lflag++;
4000061f:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000624:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
40000626:	e9 f6 fd ff ff       	jmp    40000421 <vprintfmt+0x81>

4000062b <.L27>:
            putch('X', putdat);
4000062b:	8b 74 24 40          	mov    0x40(%esp),%esi
4000062f:	83 ec 08             	sub    $0x8,%esp
40000632:	57                   	push   %edi
40000633:	6a 58                	push   $0x58
40000635:	ff d6                	call   *%esi
            putch('X', putdat);
40000637:	58                   	pop    %eax
40000638:	5a                   	pop    %edx
40000639:	57                   	push   %edi
4000063a:	6a 58                	push   $0x58
4000063c:	ff d6                	call   *%esi
            putch('X', putdat);
4000063e:	59                   	pop    %ecx
4000063f:	5b                   	pop    %ebx
40000640:	57                   	push   %edi
40000641:	6a 58                	push   $0x58
40000643:	ff d6                	call   *%esi
            break;
40000645:	83 c4 10             	add    $0x10,%esp
40000648:	e9 74 fd ff ff       	jmp    400003c1 <vprintfmt+0x21>

4000064d <.L25>:
            if ((p = va_arg(ap, char *)) == NULL)
4000064d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
            if (width > 0 && padc != '-')
40000651:	8b 4c 24 08          	mov    0x8(%esp),%ecx
            if ((p = va_arg(ap, char *)) == NULL)
40000655:	8b 54 24 14          	mov    0x14(%esp),%edx
40000659:	8b 74 24 40          	mov    0x40(%esp),%esi
4000065d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
40000660:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
40000665:	89 44 24 14          	mov    %eax,0x14(%esp)
40000669:	8b 44 24 4c          	mov    0x4c(%esp),%eax
4000066d:	8b 18                	mov    (%eax),%ebx
            if (width > 0 && padc != '-')
4000066f:	0f 95 c0             	setne  %al
40000672:	85 c9                	test   %ecx,%ecx
40000674:	0f 9f c1             	setg   %cl
            if ((p = va_arg(ap, char *)) == NULL)
40000677:	89 5c 24 18          	mov    %ebx,0x18(%esp)
            if (width > 0 && padc != '-')
4000067b:	21 c8                	and    %ecx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
4000067d:	85 db                	test   %ebx,%ebx
4000067f:	0f 84 21 01 00 00    	je     400007a6 <.L19+0x35>
            if (width > 0 && padc != '-')
40000685:	84 c0                	test   %al,%al
40000687:	0f 85 48 01 00 00    	jne    400007d5 <.L19+0x64>
                 (ch = *p++) != '\0' && (precision < 0
4000068d:	89 d8                	mov    %ebx,%eax
4000068f:	8d 5b 01             	lea    0x1(%ebx),%ebx
40000692:	0f be 08             	movsbl (%eax),%ecx
40000695:	89 c8                	mov    %ecx,%eax
40000697:	85 c9                	test   %ecx,%ecx
40000699:	74 64                	je     400006ff <.L25+0xb2>
4000069b:	89 74 24 40          	mov    %esi,0x40(%esp)
4000069f:	89 d6                	mov    %edx,%esi
400006a1:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400006a5:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400006a9:	eb 2a                	jmp    400006d5 <.L25+0x88>
400006ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
400006b0:	83 e8 20             	sub    $0x20,%eax
400006b3:	83 f8 5e             	cmp    $0x5e,%eax
400006b6:	76 2d                	jbe    400006e5 <.L25+0x98>
                    putch('?', putdat);
400006b8:	83 ec 08             	sub    $0x8,%esp
400006bb:	57                   	push   %edi
400006bc:	6a 3f                	push   $0x3f
400006be:	ff 54 24 50          	call   *0x50(%esp)
400006c2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
400006c5:	0f be 03             	movsbl (%ebx),%eax
400006c8:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
400006cb:	83 ed 01             	sub    $0x1,%ebp
                 (ch = *p++) != '\0' && (precision < 0
400006ce:	0f be c8             	movsbl %al,%ecx
400006d1:	85 c9                	test   %ecx,%ecx
400006d3:	74 1e                	je     400006f3 <.L25+0xa6>
400006d5:	85 f6                	test   %esi,%esi
400006d7:	78 05                	js     400006de <.L25+0x91>
                                         || --precision >= 0); width--)
400006d9:	83 ee 01             	sub    $0x1,%esi
400006dc:	72 15                	jb     400006f3 <.L25+0xa6>
                if (altflag && (ch < ' ' || ch > '~'))
400006de:	8b 14 24             	mov    (%esp),%edx
400006e1:	85 d2                	test   %edx,%edx
400006e3:	75 cb                	jne    400006b0 <.L25+0x63>
                    putch(ch, putdat);
400006e5:	83 ec 08             	sub    $0x8,%esp
400006e8:	57                   	push   %edi
400006e9:	51                   	push   %ecx
400006ea:	ff 54 24 50          	call   *0x50(%esp)
400006ee:	83 c4 10             	add    $0x10,%esp
400006f1:	eb d2                	jmp    400006c5 <.L25+0x78>
400006f3:	89 6c 24 08          	mov    %ebp,0x8(%esp)
400006f7:	8b 74 24 40          	mov    0x40(%esp),%esi
400006fb:	8b 6c 24 48          	mov    0x48(%esp),%ebp
            for (; width > 0; width--)
400006ff:	8b 44 24 08          	mov    0x8(%esp),%eax
40000703:	85 c0                	test   %eax,%eax
40000705:	7e 19                	jle    40000720 <.L25+0xd3>
40000707:	89 c3                	mov    %eax,%ebx
40000709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
40000710:	83 ec 08             	sub    $0x8,%esp
40000713:	57                   	push   %edi
40000714:	6a 20                	push   $0x20
40000716:	ff d6                	call   *%esi
            for (; width > 0; width--)
40000718:	83 c4 10             	add    $0x10,%esp
4000071b:	83 eb 01             	sub    $0x1,%ebx
4000071e:	75 f0                	jne    40000710 <.L25+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000720:	8b 44 24 14          	mov    0x14(%esp),%eax
40000724:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000728:	e9 94 fc ff ff       	jmp    400003c1 <vprintfmt+0x21>
        return va_arg(*ap, unsigned long long);
4000072d:	8b 08                	mov    (%eax),%ecx
4000072f:	8b 58 04             	mov    0x4(%eax),%ebx
40000732:	83 c0 08             	add    $0x8,%eax
40000735:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000739:	e9 d7 fe ff ff       	jmp    40000615 <.L29+0x2f>
4000073e:	8b 08                	mov    (%eax),%ecx
40000740:	8b 58 04             	mov    0x4(%eax),%ebx
40000743:	83 c0 08             	add    $0x8,%eax
40000746:	ba 10 00 00 00       	mov    $0x10,%edx
4000074b:	89 44 24 4c          	mov    %eax,0x4c(%esp)
4000074f:	e9 1c fe ff ff       	jmp    40000570 <.L24+0x2e>
        return va_arg(*ap, long long);
40000754:	8b 08                	mov    (%eax),%ecx
40000756:	8b 58 04             	mov    0x4(%eax),%ebx
40000759:	83 c0 08             	add    $0x8,%eax
4000075c:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000760:	e9 a8 fe ff ff       	jmp    4000060d <.L29+0x27>

40000765 <.L63>:
        switch (ch = *(unsigned char *) fmt++) {
40000765:	c6 44 24 10 30       	movb   $0x30,0x10(%esp)
4000076a:	89 eb                	mov    %ebp,%ebx
4000076c:	e9 b0 fc ff ff       	jmp    40000421 <vprintfmt+0x81>

40000771 <.L19>:
            padc = '-';
40000771:	c6 44 24 10 2d       	movb   $0x2d,0x10(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000776:	89 eb                	mov    %ebp,%ebx
40000778:	e9 a4 fc ff ff       	jmp    40000421 <vprintfmt+0x81>
4000077d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
                putch('-', putdat);
40000781:	83 ec 08             	sub    $0x8,%esp
                num = -(long long) num;
40000784:	31 db                	xor    %ebx,%ebx
40000786:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
4000078a:	57                   	push   %edi
4000078b:	6a 2d                	push   $0x2d
4000078d:	ff d6                	call   *%esi
                num = -(long long) num;
4000078f:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000793:	ba 0a 00 00 00       	mov    $0xa,%edx
40000798:	f7 d9                	neg    %ecx
4000079a:	1b 5c 24 14          	sbb    0x14(%esp),%ebx
4000079e:	83 c4 10             	add    $0x10,%esp
400007a1:	e9 ca fd ff ff       	jmp    40000570 <.L24+0x2e>
            if (width > 0 && padc != '-')
400007a6:	84 c0                	test   %al,%al
400007a8:	0f 85 99 00 00 00    	jne    40000847 <.L19+0xd6>
                 (ch = *p++) != '\0' && (precision < 0
400007ae:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400007b2:	89 74 24 40          	mov    %esi,0x40(%esp)
400007b6:	b9 28 00 00 00       	mov    $0x28,%ecx
400007bb:	89 d6                	mov    %edx,%esi
400007bd:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400007c1:	b8 28 00 00 00       	mov    $0x28,%eax
400007c6:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400007ca:	8d 9b 42 e0 ff ff    	lea    -0x1fbe(%ebx),%ebx
400007d0:	e9 00 ff ff ff       	jmp    400006d5 <.L25+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
400007d5:	83 ec 08             	sub    $0x8,%esp
400007d8:	52                   	push   %edx
400007d9:	89 54 24 28          	mov    %edx,0x28(%esp)
400007dd:	ff 74 24 24          	push   0x24(%esp)
400007e1:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
400007e5:	e8 26 03 00 00       	call   40000b10 <strnlen>
400007ea:	29 44 24 18          	sub    %eax,0x18(%esp)
400007ee:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400007f2:	83 c4 10             	add    $0x10,%esp
400007f5:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400007f9:	85 c9                	test   %ecx,%ecx
400007fb:	0f 8e 99 00 00 00    	jle    4000089a <.L19+0x129>
                    putch(padc, putdat);
40000801:	0f be 5c 24 10       	movsbl 0x10(%esp),%ebx
40000806:	89 54 24 10          	mov    %edx,0x10(%esp)
4000080a:	89 6c 24 48          	mov    %ebp,0x48(%esp)
4000080e:	8b 6c 24 08          	mov    0x8(%esp),%ebp
40000812:	83 ec 08             	sub    $0x8,%esp
40000815:	57                   	push   %edi
40000816:	53                   	push   %ebx
40000817:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000819:	83 c4 10             	add    $0x10,%esp
4000081c:	83 ed 01             	sub    $0x1,%ebp
4000081f:	75 f1                	jne    40000812 <.L19+0xa1>
                 (ch = *p++) != '\0' && (precision < 0
40000821:	8b 44 24 18          	mov    0x18(%esp),%eax
40000825:	8b 54 24 10          	mov    0x10(%esp),%edx
40000829:	89 6c 24 08          	mov    %ebp,0x8(%esp)
4000082d:	8b 6c 24 48          	mov    0x48(%esp),%ebp
40000831:	8d 58 01             	lea    0x1(%eax),%ebx
40000834:	0f be 00             	movsbl (%eax),%eax
40000837:	0f be c8             	movsbl %al,%ecx
4000083a:	85 c9                	test   %ecx,%ecx
4000083c:	0f 85 59 fe ff ff    	jne    4000069b <.L25+0x4e>
40000842:	e9 d9 fe ff ff       	jmp    40000720 <.L25+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000847:	83 ec 08             	sub    $0x8,%esp
4000084a:	52                   	push   %edx
4000084b:	8b 5c 24 18          	mov    0x18(%esp),%ebx
4000084f:	8d 8b 41 e0 ff ff    	lea    -0x1fbf(%ebx),%ecx
40000855:	89 54 24 28          	mov    %edx,0x28(%esp)
40000859:	51                   	push   %ecx
4000085a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000085e:	e8 ad 02 00 00       	call   40000b10 <strnlen>
40000863:	29 44 24 18          	sub    %eax,0x18(%esp)
40000867:	8b 44 24 18          	mov    0x18(%esp),%eax
4000086b:	83 c4 10             	add    $0x10,%esp
4000086e:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000872:	85 c0                	test   %eax,%eax
40000874:	7f 8b                	jg     40000801 <.L19+0x90>
                 (ch = *p++) != '\0' && (precision < 0
40000876:	b9 28 00 00 00       	mov    $0x28,%ecx
4000087b:	b8 28 00 00 00       	mov    $0x28,%eax
40000880:	8b 5c 24 18          	mov    0x18(%esp),%ebx
40000884:	89 74 24 40          	mov    %esi,0x40(%esp)
40000888:	89 d6                	mov    %edx,%esi
4000088a:	89 6c 24 48          	mov    %ebp,0x48(%esp)
4000088e:	8b 6c 24 08          	mov    0x8(%esp),%ebp
40000892:	83 c3 01             	add    $0x1,%ebx
40000895:	e9 3b fe ff ff       	jmp    400006d5 <.L25+0x88>
4000089a:	8b 44 24 18          	mov    0x18(%esp),%eax
4000089e:	0f be 08             	movsbl (%eax),%ecx
400008a1:	89 c8                	mov    %ecx,%eax
400008a3:	85 c9                	test   %ecx,%ecx
400008a5:	75 d9                	jne    40000880 <.L19+0x10f>
400008a7:	e9 74 fe ff ff       	jmp    40000720 <.L25+0xd3>
400008ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400008b0 <printfmt>:
{
400008b0:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
400008b3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400008b7:	50                   	push   %eax
400008b8:	ff 74 24 1c          	push   0x1c(%esp)
400008bc:	ff 74 24 1c          	push   0x1c(%esp)
400008c0:	ff 74 24 1c          	push   0x1c(%esp)
400008c4:	e8 d7 fa ff ff       	call   400003a0 <vprintfmt>
}
400008c9:	83 c4 1c             	add    $0x1c,%esp
400008cc:	c3                   	ret
400008cd:	8d 76 00             	lea    0x0(%esi),%esi

400008d0 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008d0:	e8 4e 01 00 00       	call   40000a23 <__x86.get_pc_thunk.ax>
400008d5:	05 1f 37 00 00       	add    $0x371f,%eax
{
400008da:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008dd:	8b 54 24 20          	mov    0x20(%esp),%edx
400008e1:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
400008e8:	ff 
400008e9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400008f0:	00 
400008f1:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400008f5:	ff 74 24 28          	push   0x28(%esp)
400008f9:	ff 74 24 28          	push   0x28(%esp)
400008fd:	8d 80 8c c3 ff ff    	lea    -0x3c74(%eax),%eax
40000903:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000907:	52                   	push   %edx
40000908:	50                   	push   %eax
40000909:	e8 92 fa ff ff       	call   400003a0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
4000090e:	8b 44 24 14          	mov    0x14(%esp),%eax
40000912:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000915:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000919:	83 c4 2c             	add    $0x2c,%esp
4000091c:	c3                   	ret
4000091d:	8d 76 00             	lea    0x0(%esi),%esi

40000920 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000920:	e8 fe 00 00 00       	call   40000a23 <__x86.get_pc_thunk.ax>
40000925:	05 cf 36 00 00       	add    $0x36cf,%eax
{
4000092a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000092d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000931:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000938:	ff 
40000939:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000940:	00 
40000941:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000945:	8d 54 24 28          	lea    0x28(%esp),%edx
40000949:	52                   	push   %edx
4000094a:	ff 74 24 28          	push   0x28(%esp)
4000094e:	8d 80 8c c3 ff ff    	lea    -0x3c74(%eax),%eax
40000954:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000958:	52                   	push   %edx
40000959:	50                   	push   %eax
4000095a:	e8 41 fa ff ff       	call   400003a0 <vprintfmt>
    *b.buf = '\0';
4000095f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000963:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000966:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000096a:	83 c4 2c             	add    $0x2c,%esp
4000096d:	c3                   	ret
4000096e:	66 90                	xchg   %ax,%ax

40000970 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000970:	e8 b2 00 00 00       	call   40000a27 <__x86.get_pc_thunk.dx>
40000975:	81 c2 7f 36 00 00    	add    $0x367f,%edx
{
4000097b:	83 ec 1c             	sub    $0x1c,%esp
4000097e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000982:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000986:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
4000098d:	00 
4000098e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000992:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000996:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
4000099a:	ff 74 24 2c          	push   0x2c(%esp)
4000099e:	ff 74 24 2c          	push   0x2c(%esp)
400009a2:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009a6:	50                   	push   %eax
400009a7:	8d 82 8c c3 ff ff    	lea    -0x3c74(%edx),%eax
400009ad:	50                   	push   %eax
400009ae:	e8 ed f9 ff ff       	call   400003a0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009b3:	8b 44 24 14          	mov    0x14(%esp),%eax
400009b7:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009ba:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009be:	83 c4 2c             	add    $0x2c,%esp
400009c1:	c3                   	ret
400009c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400009c9:	00 
400009ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

400009d0 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400009d0:	e8 52 00 00 00       	call   40000a27 <__x86.get_pc_thunk.dx>
400009d5:	81 c2 1f 36 00 00    	add    $0x361f,%edx
{
400009db:	83 ec 1c             	sub    $0x1c,%esp
400009de:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009e2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
400009e6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009ed:	00 
400009ee:	89 44 24 04          	mov    %eax,0x4(%esp)
400009f2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
400009f6:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009fa:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400009fe:	50                   	push   %eax
400009ff:	ff 74 24 2c          	push   0x2c(%esp)
40000a03:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a07:	50                   	push   %eax
40000a08:	8d 82 8c c3 ff ff    	lea    -0x3c74(%edx),%eax
40000a0e:	50                   	push   %eax
40000a0f:	e8 8c f9 ff ff       	call   400003a0 <vprintfmt>
    *b.buf = '\0';
40000a14:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a18:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000a1b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a1f:	83 c4 2c             	add    $0x2c,%esp
40000a22:	c3                   	ret

40000a23 <__x86.get_pc_thunk.ax>:
40000a23:	8b 04 24             	mov    (%esp),%eax
40000a26:	c3                   	ret

40000a27 <__x86.get_pc_thunk.dx>:
40000a27:	8b 14 24             	mov    (%esp),%edx
40000a2a:	c3                   	ret

40000a2b <__x86.get_pc_thunk.cx>:
40000a2b:	8b 0c 24             	mov    (%esp),%ecx
40000a2e:	c3                   	ret
40000a2f:	90                   	nop

40000a30 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a30:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a31:	b8 01 00 00 00       	mov    $0x1,%eax
40000a36:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a3a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a3e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a40:	85 c0                	test   %eax,%eax
40000a42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a47:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a4a:	5b                   	pop    %ebx
40000a4b:	c3                   	ret
40000a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a50 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a50:	b8 02 00 00 00       	mov    $0x2,%eax
40000a55:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a57:	c3                   	ret
40000a58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a5f:	00 

40000a60 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000a60:	b8 03 00 00 00       	mov    $0x3,%eax
40000a65:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000a67:	c3                   	ret
40000a68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a6f:	00 

40000a70 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000a70:	b8 04 00 00 00       	mov    $0x4,%eax
40000a75:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000a77:	c3                   	ret
40000a78:	66 90                	xchg   %ax,%ax
40000a7a:	66 90                	xchg   %ax,%ax
40000a7c:	66 90                	xchg   %ax,%ax
40000a7e:	66 90                	xchg   %ax,%ax

40000a80 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000a80:	8b 44 24 04          	mov    0x4(%esp),%eax
40000a84:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000a8a:	c3                   	ret
40000a8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000a90 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000a90:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000a94:	b8 01 00 00 00       	mov    $0x1,%eax
40000a99:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000a9c:	85 c0                	test   %eax,%eax
40000a9e:	74 13                	je     40000ab3 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000aa0:	b9 01 00 00 00       	mov    $0x1,%ecx
40000aa5:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000aa8:	f3 90                	pause
    asm volatile ("lock; xchgl %0, %1"
40000aaa:	89 c8                	mov    %ecx,%eax
40000aac:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000aaf:	85 c0                	test   %eax,%eax
40000ab1:	75 f5                	jne    40000aa8 <spinlock_acquire+0x18>
}
40000ab3:	c3                   	ret
40000ab4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000abb:	00 
40000abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000ac0 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000ac0:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000ac4:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000ac6:	84 c0                	test   %al,%al
40000ac8:	74 05                	je     40000acf <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000aca:	31 c0                	xor    %eax,%eax
40000acc:	f0 87 02             	lock xchg %eax,(%edx)
}
40000acf:	c3                   	ret

40000ad0 <spinlock_holding>:
    return *lk;
40000ad0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000ad4:	8b 00                	mov    (%eax),%eax
}
40000ad6:	c3                   	ret
40000ad7:	66 90                	xchg   %ax,%ax
40000ad9:	66 90                	xchg   %ax,%ax
40000adb:	66 90                	xchg   %ax,%ax
40000add:	66 90                	xchg   %ax,%ax
40000adf:	90                   	nop

40000ae0 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000ae0:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000ae4:	31 c0                	xor    %eax,%eax
40000ae6:	80 3a 00             	cmpb   $0x0,(%edx)
40000ae9:	74 15                	je     40000b00 <strlen+0x20>
40000aeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        n++;
40000af0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000af3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000af7:	75 f7                	jne    40000af0 <strlen+0x10>
40000af9:	c3                   	ret
40000afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000b00:	c3                   	ret
40000b01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b08:	00 
40000b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b10 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000b10:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b14:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b18:	31 c0                	xor    %eax,%eax
40000b1a:	85 d2                	test   %edx,%edx
40000b1c:	75 09                	jne    40000b27 <strnlen+0x17>
40000b1e:	c3                   	ret
40000b1f:	90                   	nop
        n++;
40000b20:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b23:	39 c2                	cmp    %eax,%edx
40000b25:	74 09                	je     40000b30 <strnlen+0x20>
40000b27:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000b2b:	75 f3                	jne    40000b20 <strnlen+0x10>
40000b2d:	c3                   	ret
40000b2e:	66 90                	xchg   %ax,%ax
    return n;
}
40000b30:	c3                   	ret
40000b31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b38:	00 
40000b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b40 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b40:	53                   	push   %ebx
40000b41:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b45:	31 c0                	xor    %eax,%eax
{
40000b47:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ((*dst++ = *src++) != '\0')
40000b50:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b54:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b57:	83 c0 01             	add    $0x1,%eax
40000b5a:	84 d2                	test   %dl,%dl
40000b5c:	75 f2                	jne    40000b50 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b5e:	89 c8                	mov    %ecx,%eax
40000b60:	5b                   	pop    %ebx
40000b61:	c3                   	ret
40000b62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b69:	00 
40000b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000b70 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000b70:	56                   	push   %esi
40000b71:	53                   	push   %ebx
40000b72:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000b76:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000b7a:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000b7e:	85 db                	test   %ebx,%ebx
40000b80:	74 21                	je     40000ba3 <strncpy+0x33>
40000b82:	01 f3                	add    %esi,%ebx
40000b84:	89 f0                	mov    %esi,%eax
40000b86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b8d:	00 
40000b8e:	66 90                	xchg   %ax,%ax
        *dst++ = *src;
40000b90:	0f b6 0a             	movzbl (%edx),%ecx
40000b93:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000b96:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000b99:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000b9c:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000b9f:	39 c3                	cmp    %eax,%ebx
40000ba1:	75 ed                	jne    40000b90 <strncpy+0x20>
    }
    return ret;
}
40000ba3:	89 f0                	mov    %esi,%eax
40000ba5:	5b                   	pop    %ebx
40000ba6:	5e                   	pop    %esi
40000ba7:	c3                   	ret
40000ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000baf:	00 

40000bb0 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000bb0:	56                   	push   %esi
40000bb1:	53                   	push   %ebx
40000bb2:	8b 44 24 14          	mov    0x14(%esp),%eax
40000bb6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000bba:	8b 4c 24 10          	mov    0x10(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000bbe:	85 c0                	test   %eax,%eax
40000bc0:	74 29                	je     40000beb <strlcpy+0x3b>
        while (--size > 0 && *src != '\0')
40000bc2:	89 f2                	mov    %esi,%edx
40000bc4:	83 e8 01             	sub    $0x1,%eax
40000bc7:	74 1f                	je     40000be8 <strlcpy+0x38>
40000bc9:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
40000bcc:	eb 0f                	jmp    40000bdd <strlcpy+0x2d>
40000bce:	66 90                	xchg   %ax,%ax
            *dst++ = *src++;
40000bd0:	83 c2 01             	add    $0x1,%edx
40000bd3:	83 c1 01             	add    $0x1,%ecx
40000bd6:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000bd9:	39 da                	cmp    %ebx,%edx
40000bdb:	74 07                	je     40000be4 <strlcpy+0x34>
40000bdd:	0f b6 01             	movzbl (%ecx),%eax
40000be0:	84 c0                	test   %al,%al
40000be2:	75 ec                	jne    40000bd0 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000be4:	89 d0                	mov    %edx,%eax
40000be6:	29 f0                	sub    %esi,%eax
        *dst = '\0';
40000be8:	c6 02 00             	movb   $0x0,(%edx)
}
40000beb:	5b                   	pop    %ebx
40000bec:	5e                   	pop    %esi
40000bed:	c3                   	ret
40000bee:	66 90                	xchg   %ax,%ax

40000bf0 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000bf0:	53                   	push   %ebx
40000bf1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bf5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000bf9:	0f b6 02             	movzbl (%edx),%eax
40000bfc:	84 c0                	test   %al,%al
40000bfe:	75 18                	jne    40000c18 <strcmp+0x28>
40000c00:	eb 30                	jmp    40000c32 <strcmp+0x42>
40000c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c08:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000c0c:	83 c2 01             	add    $0x1,%edx
40000c0f:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000c12:	84 c0                	test   %al,%al
40000c14:	74 12                	je     40000c28 <strcmp+0x38>
40000c16:	89 d9                	mov    %ebx,%ecx
40000c18:	0f b6 19             	movzbl (%ecx),%ebx
40000c1b:	38 c3                	cmp    %al,%bl
40000c1d:	74 e9                	je     40000c08 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c1f:	29 d8                	sub    %ebx,%eax
}
40000c21:	5b                   	pop    %ebx
40000c22:	c3                   	ret
40000c23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c28:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000c2c:	31 c0                	xor    %eax,%eax
40000c2e:	29 d8                	sub    %ebx,%eax
}
40000c30:	5b                   	pop    %ebx
40000c31:	c3                   	ret
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c32:	0f b6 19             	movzbl (%ecx),%ebx
40000c35:	31 c0                	xor    %eax,%eax
40000c37:	eb e6                	jmp    40000c1f <strcmp+0x2f>
40000c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c40 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c40:	53                   	push   %ebx
40000c41:	8b 54 24 10          	mov    0x10(%esp),%edx
40000c45:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c49:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (n > 0 && *p && *p == *q)
40000c4d:	85 d2                	test   %edx,%edx
40000c4f:	75 16                	jne    40000c67 <strncmp+0x27>
40000c51:	eb 2d                	jmp    40000c80 <strncmp+0x40>
40000c53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c58:	3a 19                	cmp    (%ecx),%bl
40000c5a:	75 12                	jne    40000c6e <strncmp+0x2e>
        n--, p++, q++;
40000c5c:	83 c0 01             	add    $0x1,%eax
40000c5f:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000c62:	83 ea 01             	sub    $0x1,%edx
40000c65:	74 19                	je     40000c80 <strncmp+0x40>
40000c67:	0f b6 18             	movzbl (%eax),%ebx
40000c6a:	84 db                	test   %bl,%bl
40000c6c:	75 ea                	jne    40000c58 <strncmp+0x18>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c6e:	0f b6 00             	movzbl (%eax),%eax
40000c71:	0f b6 11             	movzbl (%ecx),%edx
}
40000c74:	5b                   	pop    %ebx
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c75:	29 d0                	sub    %edx,%eax
}
40000c77:	c3                   	ret
40000c78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c7f:	00 
        return 0;
40000c80:	31 c0                	xor    %eax,%eax
}
40000c82:	5b                   	pop    %ebx
40000c83:	c3                   	ret
40000c84:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c8b:	00 
40000c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000c90 <strchr>:

char *strchr(const char *s, char c)
{
40000c90:	8b 44 24 04          	mov    0x4(%esp),%eax
40000c94:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000c99:	0f b6 10             	movzbl (%eax),%edx
40000c9c:	84 d2                	test   %dl,%dl
40000c9e:	75 13                	jne    40000cb3 <strchr+0x23>
40000ca0:	eb 1e                	jmp    40000cc0 <strchr+0x30>
40000ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ca8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cac:	83 c0 01             	add    $0x1,%eax
40000caf:	84 d2                	test   %dl,%dl
40000cb1:	74 0d                	je     40000cc0 <strchr+0x30>
        if (*s == c)
40000cb3:	38 d1                	cmp    %dl,%cl
40000cb5:	75 f1                	jne    40000ca8 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000cb7:	c3                   	ret
40000cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cbf:	00 
    return 0;
40000cc0:	31 c0                	xor    %eax,%eax
}
40000cc2:	c3                   	ret
40000cc3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cca:	00 
40000ccb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000cd0 <strfind>:

char *strfind(const char *s, char c)
{
40000cd0:	53                   	push   %ebx
40000cd1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000cd5:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000cd9:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000cdc:	38 d3                	cmp    %dl,%bl
40000cde:	74 1f                	je     40000cff <strfind+0x2f>
40000ce0:	89 d1                	mov    %edx,%ecx
40000ce2:	84 db                	test   %bl,%bl
40000ce4:	75 0e                	jne    40000cf4 <strfind+0x24>
40000ce6:	eb 17                	jmp    40000cff <strfind+0x2f>
40000ce8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cef:	00 
40000cf0:	84 d2                	test   %dl,%dl
40000cf2:	74 0b                	je     40000cff <strfind+0x2f>
    for (; *s; s++)
40000cf4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cf8:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000cfb:	38 ca                	cmp    %cl,%dl
40000cfd:	75 f1                	jne    40000cf0 <strfind+0x20>
            break;
    return (char *) s;
}
40000cff:	5b                   	pop    %ebx
40000d00:	c3                   	ret
40000d01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d08:	00 
40000d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000d10 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000d10:	55                   	push   %ebp
40000d11:	57                   	push   %edi
40000d12:	56                   	push   %esi
40000d13:	53                   	push   %ebx
40000d14:	8b 54 24 14          	mov    0x14(%esp),%edx
40000d18:	8b 74 24 18          	mov    0x18(%esp),%esi
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000d1c:	0f b6 02             	movzbl (%edx),%eax
40000d1f:	3c 20                	cmp    $0x20,%al
40000d21:	75 10                	jne    40000d33 <strtol+0x23>
40000d23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d28:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d2c:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d2f:	3c 20                	cmp    $0x20,%al
40000d31:	74 f5                	je     40000d28 <strtol+0x18>
40000d33:	3c 09                	cmp    $0x9,%al
40000d35:	74 f1                	je     40000d28 <strtol+0x18>

    // plus/minus sign
    if (*s == '+')
40000d37:	3c 2b                	cmp    $0x2b,%al
40000d39:	0f 84 b1 00 00 00    	je     40000df0 <strtol+0xe0>
    int neg = 0;
40000d3f:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d41:	3c 2d                	cmp    $0x2d,%al
40000d43:	0f 84 97 00 00 00    	je     40000de0 <strtol+0xd0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d49:	0f b6 02             	movzbl (%edx),%eax
40000d4c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000d53:	ff 
40000d54:	75 1d                	jne    40000d73 <strtol+0x63>
40000d56:	3c 30                	cmp    $0x30,%al
40000d58:	0f 84 a2 00 00 00    	je     40000e00 <strtol+0xf0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d5e:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
40000d63:	19 c0                	sbb    %eax,%eax
40000d65:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000d69:	83 64 24 1c fa       	andl   $0xfffffffa,0x1c(%esp)
40000d6e:	83 44 24 1c 10       	addl   $0x10,0x1c(%esp)
40000d73:	31 c9                	xor    %ecx,%ecx
40000d75:	eb 1c                	jmp    40000d93 <strtol+0x83>
40000d77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d7e:	00 
40000d7f:	90                   	nop
    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
40000d80:	83 e8 30             	sub    $0x30,%eax
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000d83:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000d87:	7d 2a                	jge    40000db3 <strtol+0xa3>
            break;
        s++, val = (val * base) + dig;
40000d89:	0f af 4c 24 1c       	imul   0x1c(%esp),%ecx
40000d8e:	83 c2 01             	add    $0x1,%edx
40000d91:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000d93:	0f be 02             	movsbl (%edx),%eax
40000d96:	8d 68 d0             	lea    -0x30(%eax),%ebp
40000d99:	89 eb                	mov    %ebp,%ebx
40000d9b:	80 fb 09             	cmp    $0x9,%bl
40000d9e:	76 e0                	jbe    40000d80 <strtol+0x70>
        else if (*s >= 'a' && *s <= 'z')
40000da0:	8d 68 9f             	lea    -0x61(%eax),%ebp
40000da3:	89 eb                	mov    %ebp,%ebx
40000da5:	80 fb 19             	cmp    $0x19,%bl
40000da8:	77 26                	ja     40000dd0 <strtol+0xc0>
            dig = *s - 'a' + 10;
40000daa:	83 e8 57             	sub    $0x57,%eax
        if (dig >= base)
40000dad:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000db1:	7c d6                	jl     40000d89 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000db3:	85 f6                	test   %esi,%esi
40000db5:	74 02                	je     40000db9 <strtol+0xa9>
        *endptr = (char *) s;
40000db7:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000db9:	89 c8                	mov    %ecx,%eax
}
40000dbb:	5b                   	pop    %ebx
40000dbc:	5e                   	pop    %esi
    return (neg ? -val : val);
40000dbd:	f7 d8                	neg    %eax
40000dbf:	85 ff                	test   %edi,%edi
}
40000dc1:	5f                   	pop    %edi
40000dc2:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000dc3:	0f 45 c8             	cmovne %eax,%ecx
}
40000dc6:	89 c8                	mov    %ecx,%eax
40000dc8:	c3                   	ret
40000dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000dd0:	8d 68 bf             	lea    -0x41(%eax),%ebp
40000dd3:	89 eb                	mov    %ebp,%ebx
40000dd5:	80 fb 19             	cmp    $0x19,%bl
40000dd8:	77 d9                	ja     40000db3 <strtol+0xa3>
            dig = *s - 'A' + 10;
40000dda:	83 e8 37             	sub    $0x37,%eax
40000ddd:	eb a4                	jmp    40000d83 <strtol+0x73>
40000ddf:	90                   	nop
        s++, neg = 1;
40000de0:	83 c2 01             	add    $0x1,%edx
40000de3:	bf 01 00 00 00       	mov    $0x1,%edi
40000de8:	e9 5c ff ff ff       	jmp    40000d49 <strtol+0x39>
40000ded:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000df0:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000df3:	31 ff                	xor    %edi,%edi
40000df5:	e9 4f ff ff ff       	jmp    40000d49 <strtol+0x39>
40000dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000e00:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000e04:	74 25                	je     40000e2b <strtol+0x11b>
    else if (base == 0 && s[0] == '0')
40000e06:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000e0a:	85 c0                	test   %eax,%eax
40000e0c:	74 0d                	je     40000e1b <strtol+0x10b>
40000e0e:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e15:	00 
40000e16:	e9 58 ff ff ff       	jmp    40000d73 <strtol+0x63>
        s++, base = 8;
40000e1b:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000e22:	00 
40000e23:	83 c2 01             	add    $0x1,%edx
40000e26:	e9 48 ff ff ff       	jmp    40000d73 <strtol+0x63>
        s += 2, base = 16;
40000e2b:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e32:	00 
40000e33:	83 c2 02             	add    $0x2,%edx
40000e36:	e9 38 ff ff ff       	jmp    40000d73 <strtol+0x63>
40000e3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000e40 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e40:	57                   	push   %edi
40000e41:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000e45:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000e49:	85 c9                	test   %ecx,%ecx
40000e4b:	74 19                	je     40000e66 <memset+0x26>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e4d:	89 f8                	mov    %edi,%eax
40000e4f:	09 c8                	or     %ecx,%eax
40000e51:	a8 03                	test   $0x3,%al
40000e53:	75 1b                	jne    40000e70 <memset+0x30>
        c &= 0xFF;
40000e55:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e5a:	c1 e9 02             	shr    $0x2,%ecx
40000e5d:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
        asm volatile ("cld; rep stosl\n"
40000e63:	fc                   	cld
40000e64:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e66:	89 f8                	mov    %edi,%eax
40000e68:	5f                   	pop    %edi
40000e69:	c3                   	ret
40000e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000e70:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e74:	fc                   	cld
40000e75:	f3 aa                	rep stos %al,%es:(%edi)
}
40000e77:	89 f8                	mov    %edi,%eax
40000e79:	5f                   	pop    %edi
40000e7a:	c3                   	ret
40000e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000e80 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000e80:	57                   	push   %edi
40000e81:	56                   	push   %esi
40000e82:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e86:	8b 74 24 10          	mov    0x10(%esp),%esi
40000e8a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000e8e:	39 c6                	cmp    %eax,%esi
40000e90:	73 26                	jae    40000eb8 <memmove+0x38>
40000e92:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000e95:	39 d0                	cmp    %edx,%eax
40000e97:	73 1f                	jae    40000eb8 <memmove+0x38>
        s += n;
        d += n;
40000e99:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000e9c:	89 fe                	mov    %edi,%esi
40000e9e:	09 ce                	or     %ecx,%esi
40000ea0:	09 d6                	or     %edx,%esi
40000ea2:	83 e6 03             	and    $0x3,%esi
40000ea5:	74 39                	je     40000ee0 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000ea7:	83 ef 01             	sub    $0x1,%edi
40000eaa:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000ead:	fd                   	std
40000eae:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000eb0:	fc                   	cld
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000eb1:	5e                   	pop    %esi
40000eb2:	5f                   	pop    %edi
40000eb3:	c3                   	ret
40000eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000eb8:	89 c2                	mov    %eax,%edx
40000eba:	09 ca                	or     %ecx,%edx
40000ebc:	09 f2                	or     %esi,%edx
40000ebe:	83 e2 03             	and    $0x3,%edx
40000ec1:	74 0d                	je     40000ed0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000ec3:	89 c7                	mov    %eax,%edi
40000ec5:	fc                   	cld
40000ec6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000ec8:	5e                   	pop    %esi
40000ec9:	5f                   	pop    %edi
40000eca:	c3                   	ret
40000ecb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                          :: "D" (d), "S" (s), "c" (n / 4)
40000ed0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000ed3:	89 c7                	mov    %eax,%edi
40000ed5:	fc                   	cld
40000ed6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000ed8:	eb ee                	jmp    40000ec8 <memmove+0x48>
40000eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000ee0:	83 ef 04             	sub    $0x4,%edi
40000ee3:	8d 72 fc             	lea    -0x4(%edx),%esi
40000ee6:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000ee9:	fd                   	std
40000eea:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000eec:	eb c2                	jmp    40000eb0 <memmove+0x30>
40000eee:	66 90                	xchg   %ax,%ax

40000ef0 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000ef0:	eb 8e                	jmp    40000e80 <memmove>
40000ef2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000ef9:	00 
40000efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000f00 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000f00:	56                   	push   %esi
40000f01:	53                   	push   %ebx
40000f02:	8b 74 24 14          	mov    0x14(%esp),%esi
40000f06:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000f0a:	8b 54 24 10          	mov    0x10(%esp),%edx
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000f0e:	85 f6                	test   %esi,%esi
40000f10:	74 2e                	je     40000f40 <memcmp+0x40>
40000f12:	01 c6                	add    %eax,%esi
40000f14:	eb 14                	jmp    40000f2a <memcmp+0x2a>
40000f16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f1d:	00 
40000f1e:	66 90                	xchg   %ax,%ax
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000f20:	83 c0 01             	add    $0x1,%eax
40000f23:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000f26:	39 f0                	cmp    %esi,%eax
40000f28:	74 16                	je     40000f40 <memcmp+0x40>
        if (*s1 != *s2)
40000f2a:	0f b6 08             	movzbl (%eax),%ecx
40000f2d:	0f b6 1a             	movzbl (%edx),%ebx
40000f30:	38 d9                	cmp    %bl,%cl
40000f32:	74 ec                	je     40000f20 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f34:	0f b6 c1             	movzbl %cl,%eax
40000f37:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f39:	5b                   	pop    %ebx
40000f3a:	5e                   	pop    %esi
40000f3b:	c3                   	ret
40000f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f40:	31 c0                	xor    %eax,%eax
}
40000f42:	5b                   	pop    %ebx
40000f43:	5e                   	pop    %esi
40000f44:	c3                   	ret
40000f45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f4c:	00 
40000f4d:	8d 76 00             	lea    0x0(%esi),%esi

40000f50 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f50:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f54:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f58:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f5a:	39 d0                	cmp    %edx,%eax
40000f5c:	73 1a                	jae    40000f78 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f5e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f63:	eb 0a                	jmp    40000f6f <memchr+0x1f>
40000f65:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f68:	83 c0 01             	add    $0x1,%eax
40000f6b:	39 c2                	cmp    %eax,%edx
40000f6d:	74 09                	je     40000f78 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f6f:	38 08                	cmp    %cl,(%eax)
40000f71:	75 f5                	jne    40000f68 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000f73:	c3                   	ret
40000f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000f78:	31 c0                	xor    %eax,%eax
}
40000f7a:	c3                   	ret
40000f7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000f80 <memzero>:

void *memzero(void *v, size_t n)
{
40000f80:	57                   	push   %edi
40000f81:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000f85:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000f89:	85 c9                	test   %ecx,%ecx
40000f8b:	74 0f                	je     40000f9c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000f8d:	89 f8                	mov    %edi,%eax
40000f8f:	09 c8                	or     %ecx,%eax
40000f91:	83 e0 03             	and    $0x3,%eax
40000f94:	75 0a                	jne    40000fa0 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000f96:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000f99:	fc                   	cld
40000f9a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000f9c:	89 f8                	mov    %edi,%eax
40000f9e:	5f                   	pop    %edi
40000f9f:	c3                   	ret
        asm volatile ("cld; rep stosb\n"
40000fa0:	31 c0                	xor    %eax,%eax
40000fa2:	fc                   	cld
40000fa3:	f3 aa                	rep stos %al,%es:(%edi)
}
40000fa5:	89 f8                	mov    %edi,%eax
40000fa7:	5f                   	pop    %edi
40000fa8:	c3                   	ret
40000fa9:	66 90                	xchg   %ax,%ax
40000fab:	66 90                	xchg   %ax,%ax
40000fad:	66 90                	xchg   %ax,%ax
40000faf:	90                   	nop

40000fb0 <__udivdi3>:
40000fb0:	f3 0f 1e fb          	endbr32
40000fb4:	55                   	push   %ebp
40000fb5:	89 e5                	mov    %esp,%ebp
40000fb7:	57                   	push   %edi
40000fb8:	56                   	push   %esi
40000fb9:	53                   	push   %ebx
40000fba:	83 ec 1c             	sub    $0x1c,%esp
40000fbd:	8b 7d 08             	mov    0x8(%ebp),%edi
40000fc0:	8b 45 14             	mov    0x14(%ebp),%eax
40000fc3:	8b 75 0c             	mov    0xc(%ebp),%esi
40000fc6:	8b 5d 10             	mov    0x10(%ebp),%ebx
40000fc9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
40000fcc:	85 c0                	test   %eax,%eax
40000fce:	75 20                	jne    40000ff0 <__udivdi3+0x40>
40000fd0:	39 de                	cmp    %ebx,%esi
40000fd2:	73 54                	jae    40001028 <__udivdi3+0x78>
40000fd4:	89 f8                	mov    %edi,%eax
40000fd6:	31 ff                	xor    %edi,%edi
40000fd8:	89 f2                	mov    %esi,%edx
40000fda:	f7 f3                	div    %ebx
40000fdc:	89 fa                	mov    %edi,%edx
40000fde:	83 c4 1c             	add    $0x1c,%esp
40000fe1:	5b                   	pop    %ebx
40000fe2:	5e                   	pop    %esi
40000fe3:	5f                   	pop    %edi
40000fe4:	5d                   	pop    %ebp
40000fe5:	c3                   	ret
40000fe6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000fed:	00 
40000fee:	66 90                	xchg   %ax,%ax
40000ff0:	39 c6                	cmp    %eax,%esi
40000ff2:	73 14                	jae    40001008 <__udivdi3+0x58>
40000ff4:	31 ff                	xor    %edi,%edi
40000ff6:	31 c0                	xor    %eax,%eax
40000ff8:	89 fa                	mov    %edi,%edx
40000ffa:	83 c4 1c             	add    $0x1c,%esp
40000ffd:	5b                   	pop    %ebx
40000ffe:	5e                   	pop    %esi
40000fff:	5f                   	pop    %edi
40001000:	5d                   	pop    %ebp
40001001:	c3                   	ret
40001002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001008:	0f bd f8             	bsr    %eax,%edi
4000100b:	83 f7 1f             	xor    $0x1f,%edi
4000100e:	75 48                	jne    40001058 <__udivdi3+0xa8>
40001010:	39 f0                	cmp    %esi,%eax
40001012:	72 07                	jb     4000101b <__udivdi3+0x6b>
40001014:	31 c0                	xor    %eax,%eax
40001016:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
40001019:	72 dd                	jb     40000ff8 <__udivdi3+0x48>
4000101b:	b8 01 00 00 00       	mov    $0x1,%eax
40001020:	eb d6                	jmp    40000ff8 <__udivdi3+0x48>
40001022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001028:	89 d9                	mov    %ebx,%ecx
4000102a:	85 db                	test   %ebx,%ebx
4000102c:	75 0b                	jne    40001039 <__udivdi3+0x89>
4000102e:	b8 01 00 00 00       	mov    $0x1,%eax
40001033:	31 d2                	xor    %edx,%edx
40001035:	f7 f3                	div    %ebx
40001037:	89 c1                	mov    %eax,%ecx
40001039:	31 d2                	xor    %edx,%edx
4000103b:	89 f0                	mov    %esi,%eax
4000103d:	f7 f1                	div    %ecx
4000103f:	89 c6                	mov    %eax,%esi
40001041:	8b 45 e4             	mov    -0x1c(%ebp),%eax
40001044:	89 f7                	mov    %esi,%edi
40001046:	f7 f1                	div    %ecx
40001048:	89 fa                	mov    %edi,%edx
4000104a:	83 c4 1c             	add    $0x1c,%esp
4000104d:	5b                   	pop    %ebx
4000104e:	5e                   	pop    %esi
4000104f:	5f                   	pop    %edi
40001050:	5d                   	pop    %ebp
40001051:	c3                   	ret
40001052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001058:	89 f9                	mov    %edi,%ecx
4000105a:	ba 20 00 00 00       	mov    $0x20,%edx
4000105f:	29 fa                	sub    %edi,%edx
40001061:	d3 e0                	shl    %cl,%eax
40001063:	89 45 e0             	mov    %eax,-0x20(%ebp)
40001066:	89 d1                	mov    %edx,%ecx
40001068:	89 d8                	mov    %ebx,%eax
4000106a:	d3 e8                	shr    %cl,%eax
4000106c:	89 c1                	mov    %eax,%ecx
4000106e:	8b 45 e0             	mov    -0x20(%ebp),%eax
40001071:	09 c1                	or     %eax,%ecx
40001073:	89 f0                	mov    %esi,%eax
40001075:	89 4d e0             	mov    %ecx,-0x20(%ebp)
40001078:	89 f9                	mov    %edi,%ecx
4000107a:	d3 e3                	shl    %cl,%ebx
4000107c:	89 d1                	mov    %edx,%ecx
4000107e:	d3 e8                	shr    %cl,%eax
40001080:	89 5d dc             	mov    %ebx,-0x24(%ebp)
40001083:	89 f9                	mov    %edi,%ecx
40001085:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
40001088:	d3 e6                	shl    %cl,%esi
4000108a:	89 d1                	mov    %edx,%ecx
4000108c:	d3 eb                	shr    %cl,%ebx
4000108e:	09 f3                	or     %esi,%ebx
40001090:	89 c6                	mov    %eax,%esi
40001092:	89 f2                	mov    %esi,%edx
40001094:	89 d8                	mov    %ebx,%eax
40001096:	f7 75 e0             	divl   -0x20(%ebp)
40001099:	89 d6                	mov    %edx,%esi
4000109b:	89 c3                	mov    %eax,%ebx
4000109d:	f7 65 dc             	mull   -0x24(%ebp)
400010a0:	89 55 e0             	mov    %edx,-0x20(%ebp)
400010a3:	39 d6                	cmp    %edx,%esi
400010a5:	72 21                	jb     400010c8 <__udivdi3+0x118>
400010a7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
400010aa:	89 f9                	mov    %edi,%ecx
400010ac:	d3 e2                	shl    %cl,%edx
400010ae:	39 c2                	cmp    %eax,%edx
400010b0:	73 07                	jae    400010b9 <__udivdi3+0x109>
400010b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
400010b5:	39 d6                	cmp    %edx,%esi
400010b7:	74 0f                	je     400010c8 <__udivdi3+0x118>
400010b9:	89 d8                	mov    %ebx,%eax
400010bb:	31 ff                	xor    %edi,%edi
400010bd:	e9 36 ff ff ff       	jmp    40000ff8 <__udivdi3+0x48>
400010c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400010c8:	8d 43 ff             	lea    -0x1(%ebx),%eax
400010cb:	31 ff                	xor    %edi,%edi
400010cd:	e9 26 ff ff ff       	jmp    40000ff8 <__udivdi3+0x48>
400010d2:	66 90                	xchg   %ax,%ax
400010d4:	66 90                	xchg   %ax,%ax
400010d6:	66 90                	xchg   %ax,%ax
400010d8:	66 90                	xchg   %ax,%ax
400010da:	66 90                	xchg   %ax,%ax
400010dc:	66 90                	xchg   %ax,%ax
400010de:	66 90                	xchg   %ax,%ax

400010e0 <__umoddi3>:
400010e0:	f3 0f 1e fb          	endbr32
400010e4:	55                   	push   %ebp
400010e5:	89 e5                	mov    %esp,%ebp
400010e7:	57                   	push   %edi
400010e8:	56                   	push   %esi
400010e9:	53                   	push   %ebx
400010ea:	83 ec 2c             	sub    $0x2c,%esp
400010ed:	8b 5d 0c             	mov    0xc(%ebp),%ebx
400010f0:	8b 45 14             	mov    0x14(%ebp),%eax
400010f3:	8b 75 08             	mov    0x8(%ebp),%esi
400010f6:	8b 7d 10             	mov    0x10(%ebp),%edi
400010f9:	89 da                	mov    %ebx,%edx
400010fb:	85 c0                	test   %eax,%eax
400010fd:	75 19                	jne    40001118 <__umoddi3+0x38>
400010ff:	39 fb                	cmp    %edi,%ebx
40001101:	73 5d                	jae    40001160 <__umoddi3+0x80>
40001103:	89 f0                	mov    %esi,%eax
40001105:	f7 f7                	div    %edi
40001107:	89 d0                	mov    %edx,%eax
40001109:	31 d2                	xor    %edx,%edx
4000110b:	83 c4 2c             	add    $0x2c,%esp
4000110e:	5b                   	pop    %ebx
4000110f:	5e                   	pop    %esi
40001110:	5f                   	pop    %edi
40001111:	5d                   	pop    %ebp
40001112:	c3                   	ret
40001113:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40001118:	89 75 e0             	mov    %esi,-0x20(%ebp)
4000111b:	39 c3                	cmp    %eax,%ebx
4000111d:	73 11                	jae    40001130 <__umoddi3+0x50>
4000111f:	89 f0                	mov    %esi,%eax
40001121:	83 c4 2c             	add    $0x2c,%esp
40001124:	5b                   	pop    %ebx
40001125:	5e                   	pop    %esi
40001126:	5f                   	pop    %edi
40001127:	5d                   	pop    %ebp
40001128:	c3                   	ret
40001129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001130:	0f bd c8             	bsr    %eax,%ecx
40001133:	83 f1 1f             	xor    $0x1f,%ecx
40001136:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
40001139:	75 45                	jne    40001180 <__umoddi3+0xa0>
4000113b:	39 d8                	cmp    %ebx,%eax
4000113d:	0f 82 d5 00 00 00    	jb     40001218 <__umoddi3+0x138>
40001143:	39 fe                	cmp    %edi,%esi
40001145:	0f 83 cd 00 00 00    	jae    40001218 <__umoddi3+0x138>
4000114b:	8b 45 e0             	mov    -0x20(%ebp),%eax
4000114e:	83 c4 2c             	add    $0x2c,%esp
40001151:	5b                   	pop    %ebx
40001152:	5e                   	pop    %esi
40001153:	5f                   	pop    %edi
40001154:	5d                   	pop    %ebp
40001155:	c3                   	ret
40001156:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000115d:	00 
4000115e:	66 90                	xchg   %ax,%ax
40001160:	89 f9                	mov    %edi,%ecx
40001162:	85 ff                	test   %edi,%edi
40001164:	75 0b                	jne    40001171 <__umoddi3+0x91>
40001166:	b8 01 00 00 00       	mov    $0x1,%eax
4000116b:	31 d2                	xor    %edx,%edx
4000116d:	f7 f7                	div    %edi
4000116f:	89 c1                	mov    %eax,%ecx
40001171:	89 d8                	mov    %ebx,%eax
40001173:	31 d2                	xor    %edx,%edx
40001175:	f7 f1                	div    %ecx
40001177:	89 f0                	mov    %esi,%eax
40001179:	f7 f1                	div    %ecx
4000117b:	eb 8a                	jmp    40001107 <__umoddi3+0x27>
4000117d:	8d 76 00             	lea    0x0(%esi),%esi
40001180:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
40001183:	ba 20 00 00 00       	mov    $0x20,%edx
40001188:	29 ca                	sub    %ecx,%edx
4000118a:	d3 e0                	shl    %cl,%eax
4000118c:	89 45 dc             	mov    %eax,-0x24(%ebp)
4000118f:	89 d1                	mov    %edx,%ecx
40001191:	89 f8                	mov    %edi,%eax
40001193:	d3 e8                	shr    %cl,%eax
40001195:	89 55 e0             	mov    %edx,-0x20(%ebp)
40001198:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
4000119c:	89 c2                	mov    %eax,%edx
4000119e:	8b 45 dc             	mov    -0x24(%ebp),%eax
400011a1:	d3 e7                	shl    %cl,%edi
400011a3:	09 c2                	or     %eax,%edx
400011a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
400011a8:	89 7d d8             	mov    %edi,-0x28(%ebp)
400011ab:	89 f7                	mov    %esi,%edi
400011ad:	89 55 dc             	mov    %edx,-0x24(%ebp)
400011b0:	89 da                	mov    %ebx,%edx
400011b2:	89 c1                	mov    %eax,%ecx
400011b4:	d3 ea                	shr    %cl,%edx
400011b6:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011ba:	d3 e3                	shl    %cl,%ebx
400011bc:	89 c1                	mov    %eax,%ecx
400011be:	d3 ef                	shr    %cl,%edi
400011c0:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011c4:	89 f8                	mov    %edi,%eax
400011c6:	d3 e6                	shl    %cl,%esi
400011c8:	09 d8                	or     %ebx,%eax
400011ca:	f7 75 dc             	divl   -0x24(%ebp)
400011cd:	89 d3                	mov    %edx,%ebx
400011cf:	89 75 d4             	mov    %esi,-0x2c(%ebp)
400011d2:	89 f7                	mov    %esi,%edi
400011d4:	f7 65 d8             	mull   -0x28(%ebp)
400011d7:	89 c6                	mov    %eax,%esi
400011d9:	89 d1                	mov    %edx,%ecx
400011db:	39 d3                	cmp    %edx,%ebx
400011dd:	72 06                	jb     400011e5 <__umoddi3+0x105>
400011df:	75 0e                	jne    400011ef <__umoddi3+0x10f>
400011e1:	39 c7                	cmp    %eax,%edi
400011e3:	73 0a                	jae    400011ef <__umoddi3+0x10f>
400011e5:	2b 45 d8             	sub    -0x28(%ebp),%eax
400011e8:	1b 55 dc             	sbb    -0x24(%ebp),%edx
400011eb:	89 d1                	mov    %edx,%ecx
400011ed:	89 c6                	mov    %eax,%esi
400011ef:	8b 45 d4             	mov    -0x2c(%ebp),%eax
400011f2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
400011f5:	29 f0                	sub    %esi,%eax
400011f7:	19 cb                	sbb    %ecx,%ebx
400011f9:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
400011fd:	89 da                	mov    %ebx,%edx
400011ff:	d3 e2                	shl    %cl,%edx
40001201:	89 f9                	mov    %edi,%ecx
40001203:	d3 e8                	shr    %cl,%eax
40001205:	d3 eb                	shr    %cl,%ebx
40001207:	09 d0                	or     %edx,%eax
40001209:	89 da                	mov    %ebx,%edx
4000120b:	83 c4 2c             	add    $0x2c,%esp
4000120e:	5b                   	pop    %ebx
4000120f:	5e                   	pop    %esi
40001210:	5f                   	pop    %edi
40001211:	5d                   	pop    %ebp
40001212:	c3                   	ret
40001213:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40001218:	89 da                	mov    %ebx,%edx
4000121a:	29 fe                	sub    %edi,%esi
4000121c:	19 c2                	sbb    %eax,%edx
4000121e:	89 75 e0             	mov    %esi,-0x20(%ebp)
40001221:	e9 25 ff ff ff       	jmp    4000114b <__umoddi3+0x6b>
