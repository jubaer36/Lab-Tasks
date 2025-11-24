
obj/user/idle/idle:     file format elf32-i386


Disassembly of section .text:

40000000 <main>:
#include <syscall.h>
#include <x86.h>

int main(int argc, char **argv)
{
    while (1) {}
40000000:	eb fe                	jmp    40000000 <main>

40000002 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000002:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000008:	75 04                	jne    4000000e <args_exist>

4000000a <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
4000000a:	6a 00                	push   $0x0
	pushl	$0
4000000c:	6a 00                	push   $0x0

4000000e <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
4000000e:	e8 ed ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000013:	50                   	push   %eax

40000014 <spin>:
spin:
	jmp	spin
40000014:	eb fe                	jmp    40000014 <spin>
40000016:	66 90                	xchg   %ax,%ax
40000018:	66 90                	xchg   %ax,%ax
4000001a:	66 90                	xchg   %ax,%ax
4000001c:	66 90                	xchg   %ax,%ax
4000001e:	66 90                	xchg   %ax,%ax

40000020 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000020:	53                   	push   %ebx
40000021:	e8 c1 00 00 00       	call   400000e7 <__x86.get_pc_thunk.bx>
40000026:	81 c3 ce 3f 00 00    	add    $0x3fce,%ebx
4000002c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000002f:	ff 74 24 18          	push   0x18(%esp)
40000033:	ff 74 24 18          	push   0x18(%esp)
40000037:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
4000003d:	50                   	push   %eax
4000003e:	e8 0d 02 00 00       	call   40000250 <printf>
    vcprintf(fmt, ap);
40000043:	58                   	pop    %eax
40000044:	5a                   	pop    %edx
40000045:	8d 44 24 24          	lea    0x24(%esp),%eax
40000049:	50                   	push   %eax
4000004a:	ff 74 24 24          	push   0x24(%esp)
4000004e:	e8 9d 01 00 00       	call   400001f0 <vcprintf>
    va_end(ap);
}
40000053:	83 c4 18             	add    $0x18,%esp
40000056:	5b                   	pop    %ebx
40000057:	c3                   	ret
40000058:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000005f:	00 

40000060 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
40000060:	53                   	push   %ebx
40000061:	e8 81 00 00 00       	call   400000e7 <__x86.get_pc_thunk.bx>
40000066:	81 c3 8e 3f 00 00    	add    $0x3f8e,%ebx
4000006c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
4000006f:	ff 74 24 18          	push   0x18(%esp)
40000073:	ff 74 24 18          	push   0x18(%esp)
40000077:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
4000007d:	50                   	push   %eax
4000007e:	e8 cd 01 00 00       	call   40000250 <printf>
    vcprintf(fmt, ap);
40000083:	58                   	pop    %eax
40000084:	5a                   	pop    %edx
40000085:	8d 44 24 24          	lea    0x24(%esp),%eax
40000089:	50                   	push   %eax
4000008a:	ff 74 24 24          	push   0x24(%esp)
4000008e:	e8 5d 01 00 00       	call   400001f0 <vcprintf>
    va_end(ap);
}
40000093:	83 c4 18             	add    $0x18,%esp
40000096:	5b                   	pop    %ebx
40000097:	c3                   	ret
40000098:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000009f:	00 

400000a0 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
400000a0:	53                   	push   %ebx
400000a1:	e8 41 00 00 00       	call   400000e7 <__x86.get_pc_thunk.bx>
400000a6:	81 c3 4e 3f 00 00    	add    $0x3f4e,%ebx
400000ac:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
400000af:	ff 74 24 18          	push   0x18(%esp)
400000b3:	ff 74 24 18          	push   0x18(%esp)
400000b7:	8d 83 24 e0 ff ff    	lea    -0x1fdc(%ebx),%eax
400000bd:	50                   	push   %eax
400000be:	e8 8d 01 00 00       	call   40000250 <printf>
    vcprintf(fmt, ap);
400000c3:	58                   	pop    %eax
400000c4:	5a                   	pop    %edx
400000c5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000c9:	50                   	push   %eax
400000ca:	ff 74 24 24          	push   0x24(%esp)
400000ce:	e8 1d 01 00 00       	call   400001f0 <vcprintf>
400000d3:	83 c4 10             	add    $0x10,%esp
400000d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400000dd:	00 
400000de:	66 90                	xchg   %ax,%ax
    va_end(ap);

    while (1)
        yield();
400000e0:	e8 3b 09 00 00       	call   40000a20 <yield>
    while (1)
400000e5:	eb f9                	jmp    400000e0 <panic+0x40>

400000e7 <__x86.get_pc_thunk.bx>:
400000e7:	8b 1c 24             	mov    (%esp),%ebx
400000ea:	c3                   	ret
400000eb:	66 90                	xchg   %ax,%ax
400000ed:	66 90                	xchg   %ax,%ax
400000ef:	90                   	nop

400000f0 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
400000f0:	55                   	push   %ebp
400000f1:	57                   	push   %edi
400000f2:	56                   	push   %esi
400000f3:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
400000f4:	8b 44 24 14          	mov    0x14(%esp),%eax
400000f8:	0f b6 00             	movzbl (%eax),%eax
400000fb:	3c 2b                	cmp    $0x2b,%al
400000fd:	0f 84 8d 00 00 00    	je     40000190 <atoi+0xa0>
        loc++;
    else if (buf[loc] == '-') {
40000103:	3c 2d                	cmp    $0x2d,%al
40000105:	74 59                	je     40000160 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000107:	8d 50 d0             	lea    -0x30(%eax),%edx
4000010a:	80 fa 09             	cmp    $0x9,%dl
4000010d:	77 71                	ja     40000180 <atoi+0x90>
    int negative = 0;
4000010f:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000111:	31 f6                	xor    %esi,%esi
        loc++;
40000113:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000115:	31 c9                	xor    %ecx,%ecx
40000117:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000011e:	00 
4000011f:	90                   	nop
        acc = acc * 10 + (buf[loc] - '0');
40000120:	83 e8 30             	sub    $0x30,%eax
40000123:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000126:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000129:	0f be c0             	movsbl %al,%eax
4000012c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000012f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000133:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000137:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000013a:	89 eb                	mov    %ebp,%ebx
4000013c:	80 fb 09             	cmp    $0x9,%bl
4000013f:	76 df                	jbe    40000120 <atoi+0x30>
    }
    if (numstart == loc) {
40000141:	39 f2                	cmp    %esi,%edx
40000143:	74 3b                	je     40000180 <atoi+0x90>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
40000145:	89 c8                	mov    %ecx,%eax
40000147:	f7 d8                	neg    %eax
40000149:	85 ff                	test   %edi,%edi
4000014b:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
4000014e:	8b 44 24 18          	mov    0x18(%esp),%eax
40000152:	89 08                	mov    %ecx,(%eax)
    return loc;
}
40000154:	89 d0                	mov    %edx,%eax
40000156:	5b                   	pop    %ebx
40000157:	5e                   	pop    %esi
40000158:	5f                   	pop    %edi
40000159:	5d                   	pop    %ebp
4000015a:	c3                   	ret
4000015b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000160:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
40000164:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
40000169:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000016e:	0f b6 40 01          	movzbl 0x1(%eax),%eax
40000172:	8d 50 d0             	lea    -0x30(%eax),%edx
40000175:	80 fa 09             	cmp    $0x9,%dl
40000178:	76 99                	jbe    40000113 <atoi+0x23>
4000017a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
40000180:	31 d2                	xor    %edx,%edx
}
40000182:	5b                   	pop    %ebx
40000183:	89 d0                	mov    %edx,%eax
40000185:	5e                   	pop    %esi
40000186:	5f                   	pop    %edi
40000187:	5d                   	pop    %ebp
40000188:	c3                   	ret
40000189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000190:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
40000194:	31 ff                	xor    %edi,%edi
        loc++;
40000196:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000019b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
4000019f:	8d 50 d0             	lea    -0x30(%eax),%edx
400001a2:	80 fa 09             	cmp    $0x9,%dl
400001a5:	0f 86 68 ff ff ff    	jbe    40000113 <atoi+0x23>
        return 0;
400001ab:	31 d2                	xor    %edx,%edx
400001ad:	eb d3                	jmp    40000182 <atoi+0x92>
400001af:	90                   	nop

400001b0 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
400001b0:	53                   	push   %ebx
400001b1:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
400001b5:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
400001ba:	8b 02                	mov    (%edx),%eax
400001bc:	8d 48 01             	lea    0x1(%eax),%ecx
400001bf:	89 0a                	mov    %ecx,(%edx)
400001c1:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
400001c5:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
400001cb:	75 14                	jne    400001e1 <putch+0x31>
        b->buf[b->idx] = 0;
400001cd:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
400001d4:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
400001d7:	31 c0                	xor    %eax,%eax
400001d9:	cd 30                	int    $0x30
        b->idx = 0;
400001db:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
400001e1:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
400001e5:	5b                   	pop    %ebx
400001e6:	c3                   	ret
400001e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400001ee:	00 
400001ef:	90                   	nop

400001f0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
400001f0:	53                   	push   %ebx
400001f1:	e8 f1 fe ff ff       	call   400000e7 <__x86.get_pc_thunk.bx>
400001f6:	81 c3 fe 3d 00 00    	add    $0x3dfe,%ebx
400001fc:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000202:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000209:	00 
    b.cnt = 0;
4000020a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000211:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000212:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000219:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000220:	8d 44 24 10          	lea    0x10(%esp),%eax
40000224:	50                   	push   %eax
40000225:	8d 83 bc c1 ff ff    	lea    -0x3e44(%ebx),%eax
4000022b:	50                   	push   %eax
4000022c:	e8 3f 01 00 00       	call   40000370 <vprintfmt>

    b.buf[b.idx] = 0;
40000231:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000235:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000239:	31 c0                	xor    %eax,%eax
4000023b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
40000240:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
40000242:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000246:	81 c4 28 02 00 00    	add    $0x228,%esp
4000024c:	5b                   	pop    %ebx
4000024d:	c3                   	ret
4000024e:	66 90                	xchg   %ax,%ax

40000250 <printf>:

int printf(const char *fmt, ...)
{
40000250:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
40000253:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000257:	50                   	push   %eax
40000258:	ff 74 24 1c          	push   0x1c(%esp)
4000025c:	e8 8f ff ff ff       	call   400001f0 <vcprintf>
    va_end(ap);

    return cnt;
}
40000261:	83 c4 1c             	add    $0x1c,%esp
40000264:	c3                   	ret
40000265:	66 90                	xchg   %ax,%ax
40000267:	66 90                	xchg   %ax,%ax
40000269:	66 90                	xchg   %ax,%ax
4000026b:	66 90                	xchg   %ax,%ax
4000026d:	66 90                	xchg   %ax,%ax
4000026f:	90                   	nop

40000270 <printnum>:
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
40000270:	e8 86 07 00 00       	call   400009fb <__x86.get_pc_thunk.cx>
40000275:	81 c1 7f 3d 00 00    	add    $0x3d7f,%ecx
{
4000027b:	55                   	push   %ebp
4000027c:	57                   	push   %edi
4000027d:	89 d7                	mov    %edx,%edi
4000027f:	56                   	push   %esi
40000280:	89 c6                	mov    %eax,%esi
40000282:	53                   	push   %ebx
40000283:	83 ec 2c             	sub    $0x2c,%esp
40000286:	8b 44 24 40          	mov    0x40(%esp),%eax
4000028a:	8b 54 24 44          	mov    0x44(%esp),%edx
4000028e:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    if (num >= base) {
40000292:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
40000299:	00 
{
4000029a:	8b 6c 24 50          	mov    0x50(%esp),%ebp
4000029e:	89 44 24 08          	mov    %eax,0x8(%esp)
400002a2:	8b 44 24 48          	mov    0x48(%esp),%eax
400002a6:	89 54 24 0c          	mov    %edx,0xc(%esp)
400002aa:	8b 54 24 4c          	mov    0x4c(%esp),%edx
    if (num >= base) {
400002ae:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
400002b2:	39 44 24 08          	cmp    %eax,0x8(%esp)
400002b6:	89 44 24 10          	mov    %eax,0x10(%esp)
400002ba:	1b 4c 24 14          	sbb    0x14(%esp),%ecx
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
400002be:	8d 5a ff             	lea    -0x1(%edx),%ebx
    if (num >= base) {
400002c1:	73 55                	jae    40000318 <printnum+0xa8>
        while (--width > 0)
400002c3:	83 fa 01             	cmp    $0x1,%edx
400002c6:	7e 17                	jle    400002df <printnum+0x6f>
400002c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400002cf:	00 
            putch(padc, putdat);
400002d0:	83 ec 08             	sub    $0x8,%esp
400002d3:	57                   	push   %edi
400002d4:	55                   	push   %ebp
400002d5:	ff d6                	call   *%esi
        while (--width > 0)
400002d7:	83 c4 10             	add    $0x10,%esp
400002da:	83 eb 01             	sub    $0x1,%ebx
400002dd:	75 f1                	jne    400002d0 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
400002df:	89 7c 24 44          	mov    %edi,0x44(%esp)
400002e3:	ff 74 24 14          	push   0x14(%esp)
400002e7:	ff 74 24 14          	push   0x14(%esp)
400002eb:	ff 74 24 14          	push   0x14(%esp)
400002ef:	ff 74 24 14          	push   0x14(%esp)
400002f3:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
400002f7:	e8 b4 0d 00 00       	call   400010b0 <__umoddi3>
400002fc:	0f be 84 03 30 e0 ff 	movsbl -0x1fd0(%ebx,%eax,1),%eax
40000303:	ff 
40000304:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000308:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000030b:	89 f0                	mov    %esi,%eax
}
4000030d:	5b                   	pop    %ebx
4000030e:	5e                   	pop    %esi
4000030f:	5f                   	pop    %edi
40000310:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000311:	ff e0                	jmp    *%eax
40000313:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000318:	83 ec 0c             	sub    $0xc,%esp
4000031b:	55                   	push   %ebp
4000031c:	53                   	push   %ebx
4000031d:	50                   	push   %eax
4000031e:	83 ec 08             	sub    $0x8,%esp
40000321:	ff 74 24 34          	push   0x34(%esp)
40000325:	ff 74 24 34          	push   0x34(%esp)
40000329:	ff 74 24 34          	push   0x34(%esp)
4000032d:	ff 74 24 34          	push   0x34(%esp)
40000331:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000335:	e8 46 0c 00 00       	call   40000f80 <__udivdi3>
4000033a:	83 c4 18             	add    $0x18,%esp
4000033d:	52                   	push   %edx
4000033e:	89 fa                	mov    %edi,%edx
40000340:	50                   	push   %eax
40000341:	89 f0                	mov    %esi,%eax
40000343:	e8 28 ff ff ff       	call   40000270 <printnum>
40000348:	83 c4 20             	add    $0x20,%esp
4000034b:	eb 92                	jmp    400002df <printnum+0x6f>
4000034d:	8d 76 00             	lea    0x0(%esi),%esi

40000350 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
40000350:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
40000354:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
40000358:	8b 10                	mov    (%eax),%edx
4000035a:	3b 50 04             	cmp    0x4(%eax),%edx
4000035d:	73 0b                	jae    4000036a <sprintputch+0x1a>
        *b->buf++ = ch;
4000035f:	8d 4a 01             	lea    0x1(%edx),%ecx
40000362:	89 08                	mov    %ecx,(%eax)
40000364:	8b 44 24 04          	mov    0x4(%esp),%eax
40000368:	88 02                	mov    %al,(%edx)
}
4000036a:	c3                   	ret
4000036b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000370 <vprintfmt>:
{
40000370:	e8 7e 06 00 00       	call   400009f3 <__x86.get_pc_thunk.ax>
40000375:	05 7f 3c 00 00       	add    $0x3c7f,%eax
4000037a:	55                   	push   %ebp
4000037b:	57                   	push   %edi
4000037c:	56                   	push   %esi
4000037d:	53                   	push   %ebx
4000037e:	83 ec 2c             	sub    $0x2c,%esp
40000381:	8b 74 24 40          	mov    0x40(%esp),%esi
40000385:	8b 7c 24 44          	mov    0x44(%esp),%edi
40000389:	89 44 24 0c          	mov    %eax,0xc(%esp)
4000038d:	8b 6c 24 48          	mov    0x48(%esp),%ebp
        while ((ch = *(unsigned char *) fmt++) != '%') {
40000391:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
40000395:	8d 5d 01             	lea    0x1(%ebp),%ebx
40000398:	83 f8 25             	cmp    $0x25,%eax
4000039b:	75 19                	jne    400003b6 <vprintfmt+0x46>
4000039d:	eb 29                	jmp    400003c8 <vprintfmt+0x58>
4000039f:	90                   	nop
            putch(ch, putdat);
400003a0:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003a3:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
400003a6:	57                   	push   %edi
400003a7:	50                   	push   %eax
400003a8:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003aa:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
400003ae:	83 c4 10             	add    $0x10,%esp
400003b1:	83 f8 25             	cmp    $0x25,%eax
400003b4:	74 12                	je     400003c8 <vprintfmt+0x58>
            if (ch == '\0')
400003b6:	85 c0                	test   %eax,%eax
400003b8:	75 e6                	jne    400003a0 <vprintfmt+0x30>
}
400003ba:	83 c4 2c             	add    $0x2c,%esp
400003bd:	5b                   	pop    %ebx
400003be:	5e                   	pop    %esi
400003bf:	5f                   	pop    %edi
400003c0:	5d                   	pop    %ebp
400003c1:	c3                   	ret
400003c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
400003c8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
400003cd:	c6 44 24 10 20       	movb   $0x20,0x10(%esp)
        altflag = 0;
400003d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        width = -1;
400003d9:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
400003e0:	ff 
        lflag = 0;
400003e1:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
400003e8:	00 
400003e9:	89 54 24 14          	mov    %edx,0x14(%esp)
400003ed:	89 74 24 40          	mov    %esi,0x40(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400003f1:	0f b6 0b             	movzbl (%ebx),%ecx
400003f4:	8d 6b 01             	lea    0x1(%ebx),%ebp
400003f7:	8d 41 dd             	lea    -0x23(%ecx),%eax
400003fa:	3c 55                	cmp    $0x55,%al
400003fc:	77 12                	ja     40000410 <.L21>
400003fe:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000402:	0f b6 c0             	movzbl %al,%eax
40000405:	8b b4 82 48 e0 ff ff 	mov    -0x1fb8(%edx,%eax,4),%esi
4000040c:	01 d6                	add    %edx,%esi
4000040e:	ff e6                	jmp    *%esi

40000410 <.L21>:
            putch('%', putdat);
40000410:	8b 74 24 40          	mov    0x40(%esp),%esi
40000414:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
40000417:	89 dd                	mov    %ebx,%ebp
            putch('%', putdat);
40000419:	57                   	push   %edi
4000041a:	6a 25                	push   $0x25
4000041c:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
4000041e:	83 c4 10             	add    $0x10,%esp
40000421:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
40000425:	0f 84 66 ff ff ff    	je     40000391 <vprintfmt+0x21>
4000042b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000430:	83 ed 01             	sub    $0x1,%ebp
40000433:	80 7d ff 25          	cmpb   $0x25,-0x1(%ebp)
40000437:	75 f7                	jne    40000430 <.L21+0x20>
40000439:	e9 53 ff ff ff       	jmp    40000391 <vprintfmt+0x21>
4000043e:	66 90                	xchg   %ax,%ax

40000440 <.L31>:
                ch = *fmt;
40000440:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
40000444:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
40000447:	89 eb                	mov    %ebp,%ebx
                precision = precision * 10 + ch - '0';
40000449:	89 54 24 14          	mov    %edx,0x14(%esp)
                if (ch < '0' || ch > '9')
4000044d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000450:	83 f9 09             	cmp    $0x9,%ecx
40000453:	77 28                	ja     4000047d <.L31+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
40000455:	8b 74 24 40          	mov    0x40(%esp),%esi
40000459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
40000460:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
40000463:	8d 14 92             	lea    (%edx,%edx,4),%edx
40000466:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
4000046a:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
4000046d:	8d 48 d0             	lea    -0x30(%eax),%ecx
40000470:	83 f9 09             	cmp    $0x9,%ecx
40000473:	76 eb                	jbe    40000460 <.L31+0x20>
40000475:	89 54 24 14          	mov    %edx,0x14(%esp)
40000479:	89 74 24 40          	mov    %esi,0x40(%esp)
            if (width < 0)
4000047d:	8b 74 24 08          	mov    0x8(%esp),%esi
40000481:	85 f6                	test   %esi,%esi
40000483:	0f 89 68 ff ff ff    	jns    400003f1 <vprintfmt+0x81>
                width = precision, precision = -1;
40000489:	8b 44 24 14          	mov    0x14(%esp),%eax
4000048d:	c7 44 24 14 ff ff ff 	movl   $0xffffffff,0x14(%esp)
40000494:	ff 
40000495:	89 44 24 08          	mov    %eax,0x8(%esp)
40000499:	e9 53 ff ff ff       	jmp    400003f1 <vprintfmt+0x81>

4000049e <.L35>:
            altflag = 1;
4000049e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400004a5:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
400004a7:	e9 45 ff ff ff       	jmp    400003f1 <vprintfmt+0x81>

400004ac <.L34>:
            putch(ch, putdat);
400004ac:	8b 74 24 40          	mov    0x40(%esp),%esi
400004b0:	83 ec 08             	sub    $0x8,%esp
400004b3:	57                   	push   %edi
400004b4:	6a 25                	push   $0x25
400004b6:	ff d6                	call   *%esi
            break;
400004b8:	83 c4 10             	add    $0x10,%esp
400004bb:	e9 d1 fe ff ff       	jmp    40000391 <vprintfmt+0x21>

400004c0 <.L33>:
            precision = va_arg(ap, int);
400004c0:	8b 44 24 4c          	mov    0x4c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
400004c4:	89 eb                	mov    %ebp,%ebx
            precision = va_arg(ap, int);
400004c6:	8b 00                	mov    (%eax),%eax
400004c8:	89 44 24 14          	mov    %eax,0x14(%esp)
400004cc:	8b 44 24 4c          	mov    0x4c(%esp),%eax
400004d0:	83 c0 04             	add    $0x4,%eax
400004d3:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto process_precision;
400004d7:	eb a4                	jmp    4000047d <.L31+0x3d>

400004d9 <.L32>:
            if (width < 0)
400004d9:	8b 4c 24 08          	mov    0x8(%esp),%ecx
400004dd:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
400004df:	89 eb                	mov    %ebp,%ebx
            if (width < 0)
400004e1:	85 c9                	test   %ecx,%ecx
400004e3:	0f 49 c1             	cmovns %ecx,%eax
400004e6:	89 44 24 08          	mov    %eax,0x8(%esp)
            goto reswitch;
400004ea:	e9 02 ff ff ff       	jmp    400003f1 <vprintfmt+0x81>

400004ef <.L30>:
            putch(va_arg(ap, int), putdat);
400004ef:	8b 44 24 4c          	mov    0x4c(%esp),%eax
400004f3:	8b 74 24 40          	mov    0x40(%esp),%esi
400004f7:	83 ec 08             	sub    $0x8,%esp
400004fa:	57                   	push   %edi
400004fb:	8d 58 04             	lea    0x4(%eax),%ebx
400004fe:	8b 44 24 58          	mov    0x58(%esp),%eax
40000502:	ff 30                	push   (%eax)
40000504:	ff d6                	call   *%esi
            break;
40000506:	83 c4 10             	add    $0x10,%esp
            putch(va_arg(ap, int), putdat);
40000509:	89 5c 24 4c          	mov    %ebx,0x4c(%esp)
            break;
4000050d:	e9 7f fe ff ff       	jmp    40000391 <vprintfmt+0x21>

40000512 <.L24>:
    if (lflag >= 2)
40000512:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
40000517:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000051b:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
4000051f:	0f 8f d8 01 00 00    	jg     400006fd <.L25+0xe0>
        return va_arg(*ap, unsigned long);
40000525:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
40000529:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000052c:	31 db                	xor    %ebx,%ebx
4000052e:	ba 0a 00 00 00       	mov    $0xa,%edx
40000533:	8b 09                	mov    (%ecx),%ecx
40000535:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printnum(putch, putdat, num, base, width, padc);
40000540:	83 ec 0c             	sub    $0xc,%esp
40000543:	0f be 44 24 1c       	movsbl 0x1c(%esp),%eax
40000548:	50                   	push   %eax
40000549:	89 f0                	mov    %esi,%eax
4000054b:	ff 74 24 18          	push   0x18(%esp)
4000054f:	52                   	push   %edx
40000550:	89 fa                	mov    %edi,%edx
40000552:	53                   	push   %ebx
40000553:	51                   	push   %ecx
40000554:	e8 17 fd ff ff       	call   40000270 <printnum>
            break;
40000559:	83 c4 20             	add    $0x20,%esp
4000055c:	e9 30 fe ff ff       	jmp    40000391 <vprintfmt+0x21>

40000561 <.L26>:
            putch('0', putdat);
40000561:	8b 74 24 40          	mov    0x40(%esp),%esi
40000565:	83 ec 08             	sub    $0x8,%esp
40000568:	57                   	push   %edi
40000569:	6a 30                	push   $0x30
4000056b:	ff d6                	call   *%esi
            putch('x', putdat);
4000056d:	59                   	pop    %ecx
4000056e:	5b                   	pop    %ebx
4000056f:	57                   	push   %edi
40000570:	6a 78                	push   $0x78
            num = (unsigned long long)
40000572:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
40000574:	ff d6                	call   *%esi
            num = (unsigned long long)
40000576:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            goto number;
4000057a:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
4000057f:	8b 08                	mov    (%eax),%ecx
            goto number;
40000581:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
40000584:	83 c0 04             	add    $0x4,%eax
40000587:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto number;
4000058b:	eb b3                	jmp    40000540 <.L24+0x2e>

4000058d <.L22>:
    if (lflag >= 2)
4000058d:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
40000592:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
40000596:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
4000059a:	0f 8f 6e 01 00 00    	jg     4000070e <.L25+0xf1>
        return va_arg(*ap, unsigned long);
400005a0:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
400005a4:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
400005a7:	31 db                	xor    %ebx,%ebx
400005a9:	ba 10 00 00 00       	mov    $0x10,%edx
400005ae:	8b 09                	mov    (%ecx),%ecx
400005b0:	89 44 24 4c          	mov    %eax,0x4c(%esp)
400005b4:	eb 8a                	jmp    40000540 <.L24+0x2e>

400005b6 <.L29>:
    if (lflag >= 2)
400005b6:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
400005bb:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, long long);
400005bf:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
400005c3:	0f 8f 5b 01 00 00    	jg     40000724 <.L25+0x107>
        return va_arg(*ap, long);
400005c9:	8b 00                	mov    (%eax),%eax
400005cb:	89 c3                	mov    %eax,%ebx
400005cd:	89 c1                	mov    %eax,%ecx
400005cf:	8b 44 24 4c          	mov    0x4c(%esp),%eax
400005d3:	c1 fb 1f             	sar    $0x1f,%ebx
400005d6:	83 c0 04             	add    $0x4,%eax
400005d9:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            if ((long long) num < 0) {
400005dd:	85 db                	test   %ebx,%ebx
400005df:	0f 88 68 01 00 00    	js     4000074d <.L19+0xc>
        return va_arg(*ap, unsigned long long);
400005e5:	ba 0a 00 00 00       	mov    $0xa,%edx
400005ea:	e9 51 ff ff ff       	jmp    40000540 <.L24+0x2e>

400005ef <.L28>:
            lflag++;
400005ef:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400005f4:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
400005f6:	e9 f6 fd ff ff       	jmp    400003f1 <vprintfmt+0x81>

400005fb <.L27>:
            putch('X', putdat);
400005fb:	8b 74 24 40          	mov    0x40(%esp),%esi
400005ff:	83 ec 08             	sub    $0x8,%esp
40000602:	57                   	push   %edi
40000603:	6a 58                	push   $0x58
40000605:	ff d6                	call   *%esi
            putch('X', putdat);
40000607:	58                   	pop    %eax
40000608:	5a                   	pop    %edx
40000609:	57                   	push   %edi
4000060a:	6a 58                	push   $0x58
4000060c:	ff d6                	call   *%esi
            putch('X', putdat);
4000060e:	59                   	pop    %ecx
4000060f:	5b                   	pop    %ebx
40000610:	57                   	push   %edi
40000611:	6a 58                	push   $0x58
40000613:	ff d6                	call   *%esi
            break;
40000615:	83 c4 10             	add    $0x10,%esp
40000618:	e9 74 fd ff ff       	jmp    40000391 <vprintfmt+0x21>

4000061d <.L25>:
            if ((p = va_arg(ap, char *)) == NULL)
4000061d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
            if (width > 0 && padc != '-')
40000621:	8b 4c 24 08          	mov    0x8(%esp),%ecx
            if ((p = va_arg(ap, char *)) == NULL)
40000625:	8b 54 24 14          	mov    0x14(%esp),%edx
40000629:	8b 74 24 40          	mov    0x40(%esp),%esi
4000062d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
40000630:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
40000635:	89 44 24 14          	mov    %eax,0x14(%esp)
40000639:	8b 44 24 4c          	mov    0x4c(%esp),%eax
4000063d:	8b 18                	mov    (%eax),%ebx
            if (width > 0 && padc != '-')
4000063f:	0f 95 c0             	setne  %al
40000642:	85 c9                	test   %ecx,%ecx
40000644:	0f 9f c1             	setg   %cl
            if ((p = va_arg(ap, char *)) == NULL)
40000647:	89 5c 24 18          	mov    %ebx,0x18(%esp)
            if (width > 0 && padc != '-')
4000064b:	21 c8                	and    %ecx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
4000064d:	85 db                	test   %ebx,%ebx
4000064f:	0f 84 21 01 00 00    	je     40000776 <.L19+0x35>
            if (width > 0 && padc != '-')
40000655:	84 c0                	test   %al,%al
40000657:	0f 85 48 01 00 00    	jne    400007a5 <.L19+0x64>
                 (ch = *p++) != '\0' && (precision < 0
4000065d:	89 d8                	mov    %ebx,%eax
4000065f:	8d 5b 01             	lea    0x1(%ebx),%ebx
40000662:	0f be 08             	movsbl (%eax),%ecx
40000665:	89 c8                	mov    %ecx,%eax
40000667:	85 c9                	test   %ecx,%ecx
40000669:	74 64                	je     400006cf <.L25+0xb2>
4000066b:	89 74 24 40          	mov    %esi,0x40(%esp)
4000066f:	89 d6                	mov    %edx,%esi
40000671:	89 6c 24 48          	mov    %ebp,0x48(%esp)
40000675:	8b 6c 24 08          	mov    0x8(%esp),%ebp
40000679:	eb 2a                	jmp    400006a5 <.L25+0x88>
4000067b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
40000680:	83 e8 20             	sub    $0x20,%eax
40000683:	83 f8 5e             	cmp    $0x5e,%eax
40000686:	76 2d                	jbe    400006b5 <.L25+0x98>
                    putch('?', putdat);
40000688:	83 ec 08             	sub    $0x8,%esp
4000068b:	57                   	push   %edi
4000068c:	6a 3f                	push   $0x3f
4000068e:	ff 54 24 50          	call   *0x50(%esp)
40000692:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
40000695:	0f be 03             	movsbl (%ebx),%eax
40000698:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
4000069b:	83 ed 01             	sub    $0x1,%ebp
                 (ch = *p++) != '\0' && (precision < 0
4000069e:	0f be c8             	movsbl %al,%ecx
400006a1:	85 c9                	test   %ecx,%ecx
400006a3:	74 1e                	je     400006c3 <.L25+0xa6>
400006a5:	85 f6                	test   %esi,%esi
400006a7:	78 05                	js     400006ae <.L25+0x91>
                                         || --precision >= 0); width--)
400006a9:	83 ee 01             	sub    $0x1,%esi
400006ac:	72 15                	jb     400006c3 <.L25+0xa6>
                if (altflag && (ch < ' ' || ch > '~'))
400006ae:	8b 14 24             	mov    (%esp),%edx
400006b1:	85 d2                	test   %edx,%edx
400006b3:	75 cb                	jne    40000680 <.L25+0x63>
                    putch(ch, putdat);
400006b5:	83 ec 08             	sub    $0x8,%esp
400006b8:	57                   	push   %edi
400006b9:	51                   	push   %ecx
400006ba:	ff 54 24 50          	call   *0x50(%esp)
400006be:	83 c4 10             	add    $0x10,%esp
400006c1:	eb d2                	jmp    40000695 <.L25+0x78>
400006c3:	89 6c 24 08          	mov    %ebp,0x8(%esp)
400006c7:	8b 74 24 40          	mov    0x40(%esp),%esi
400006cb:	8b 6c 24 48          	mov    0x48(%esp),%ebp
            for (; width > 0; width--)
400006cf:	8b 44 24 08          	mov    0x8(%esp),%eax
400006d3:	85 c0                	test   %eax,%eax
400006d5:	7e 19                	jle    400006f0 <.L25+0xd3>
400006d7:	89 c3                	mov    %eax,%ebx
400006d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
400006e0:	83 ec 08             	sub    $0x8,%esp
400006e3:	57                   	push   %edi
400006e4:	6a 20                	push   $0x20
400006e6:	ff d6                	call   *%esi
            for (; width > 0; width--)
400006e8:	83 c4 10             	add    $0x10,%esp
400006eb:	83 eb 01             	sub    $0x1,%ebx
400006ee:	75 f0                	jne    400006e0 <.L25+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
400006f0:	8b 44 24 14          	mov    0x14(%esp),%eax
400006f4:	89 44 24 4c          	mov    %eax,0x4c(%esp)
400006f8:	e9 94 fc ff ff       	jmp    40000391 <vprintfmt+0x21>
        return va_arg(*ap, unsigned long long);
400006fd:	8b 08                	mov    (%eax),%ecx
400006ff:	8b 58 04             	mov    0x4(%eax),%ebx
40000702:	83 c0 08             	add    $0x8,%eax
40000705:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000709:	e9 d7 fe ff ff       	jmp    400005e5 <.L29+0x2f>
4000070e:	8b 08                	mov    (%eax),%ecx
40000710:	8b 58 04             	mov    0x4(%eax),%ebx
40000713:	83 c0 08             	add    $0x8,%eax
40000716:	ba 10 00 00 00       	mov    $0x10,%edx
4000071b:	89 44 24 4c          	mov    %eax,0x4c(%esp)
4000071f:	e9 1c fe ff ff       	jmp    40000540 <.L24+0x2e>
        return va_arg(*ap, long long);
40000724:	8b 08                	mov    (%eax),%ecx
40000726:	8b 58 04             	mov    0x4(%eax),%ebx
40000729:	83 c0 08             	add    $0x8,%eax
4000072c:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000730:	e9 a8 fe ff ff       	jmp    400005dd <.L29+0x27>

40000735 <.L63>:
        switch (ch = *(unsigned char *) fmt++) {
40000735:	c6 44 24 10 30       	movb   $0x30,0x10(%esp)
4000073a:	89 eb                	mov    %ebp,%ebx
4000073c:	e9 b0 fc ff ff       	jmp    400003f1 <vprintfmt+0x81>

40000741 <.L19>:
            padc = '-';
40000741:	c6 44 24 10 2d       	movb   $0x2d,0x10(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000746:	89 eb                	mov    %ebp,%ebx
40000748:	e9 a4 fc ff ff       	jmp    400003f1 <vprintfmt+0x81>
4000074d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
                putch('-', putdat);
40000751:	83 ec 08             	sub    $0x8,%esp
                num = -(long long) num;
40000754:	31 db                	xor    %ebx,%ebx
40000756:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
4000075a:	57                   	push   %edi
4000075b:	6a 2d                	push   $0x2d
4000075d:	ff d6                	call   *%esi
                num = -(long long) num;
4000075f:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000763:	ba 0a 00 00 00       	mov    $0xa,%edx
40000768:	f7 d9                	neg    %ecx
4000076a:	1b 5c 24 14          	sbb    0x14(%esp),%ebx
4000076e:	83 c4 10             	add    $0x10,%esp
40000771:	e9 ca fd ff ff       	jmp    40000540 <.L24+0x2e>
            if (width > 0 && padc != '-')
40000776:	84 c0                	test   %al,%al
40000778:	0f 85 99 00 00 00    	jne    40000817 <.L19+0xd6>
                 (ch = *p++) != '\0' && (precision < 0
4000077e:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000782:	89 74 24 40          	mov    %esi,0x40(%esp)
40000786:	b9 28 00 00 00       	mov    $0x28,%ecx
4000078b:	89 d6                	mov    %edx,%esi
4000078d:	89 6c 24 48          	mov    %ebp,0x48(%esp)
40000791:	b8 28 00 00 00       	mov    $0x28,%eax
40000796:	8b 6c 24 08          	mov    0x8(%esp),%ebp
4000079a:	8d 9b 42 e0 ff ff    	lea    -0x1fbe(%ebx),%ebx
400007a0:	e9 00 ff ff ff       	jmp    400006a5 <.L25+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
400007a5:	83 ec 08             	sub    $0x8,%esp
400007a8:	52                   	push   %edx
400007a9:	89 54 24 28          	mov    %edx,0x28(%esp)
400007ad:	ff 74 24 24          	push   0x24(%esp)
400007b1:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
400007b5:	e8 26 03 00 00       	call   40000ae0 <strnlen>
400007ba:	29 44 24 18          	sub    %eax,0x18(%esp)
400007be:	8b 4c 24 18          	mov    0x18(%esp),%ecx
400007c2:	83 c4 10             	add    $0x10,%esp
400007c5:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400007c9:	85 c9                	test   %ecx,%ecx
400007cb:	0f 8e 99 00 00 00    	jle    4000086a <.L19+0x129>
                    putch(padc, putdat);
400007d1:	0f be 5c 24 10       	movsbl 0x10(%esp),%ebx
400007d6:	89 54 24 10          	mov    %edx,0x10(%esp)
400007da:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400007de:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400007e2:	83 ec 08             	sub    $0x8,%esp
400007e5:	57                   	push   %edi
400007e6:	53                   	push   %ebx
400007e7:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
400007e9:	83 c4 10             	add    $0x10,%esp
400007ec:	83 ed 01             	sub    $0x1,%ebp
400007ef:	75 f1                	jne    400007e2 <.L19+0xa1>
                 (ch = *p++) != '\0' && (precision < 0
400007f1:	8b 44 24 18          	mov    0x18(%esp),%eax
400007f5:	8b 54 24 10          	mov    0x10(%esp),%edx
400007f9:	89 6c 24 08          	mov    %ebp,0x8(%esp)
400007fd:	8b 6c 24 48          	mov    0x48(%esp),%ebp
40000801:	8d 58 01             	lea    0x1(%eax),%ebx
40000804:	0f be 00             	movsbl (%eax),%eax
40000807:	0f be c8             	movsbl %al,%ecx
4000080a:	85 c9                	test   %ecx,%ecx
4000080c:	0f 85 59 fe ff ff    	jne    4000066b <.L25+0x4e>
40000812:	e9 d9 fe ff ff       	jmp    400006f0 <.L25+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000817:	83 ec 08             	sub    $0x8,%esp
4000081a:	52                   	push   %edx
4000081b:	8b 5c 24 18          	mov    0x18(%esp),%ebx
4000081f:	8d 8b 41 e0 ff ff    	lea    -0x1fbf(%ebx),%ecx
40000825:	89 54 24 28          	mov    %edx,0x28(%esp)
40000829:	51                   	push   %ecx
4000082a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000082e:	e8 ad 02 00 00       	call   40000ae0 <strnlen>
40000833:	29 44 24 18          	sub    %eax,0x18(%esp)
40000837:	8b 44 24 18          	mov    0x18(%esp),%eax
4000083b:	83 c4 10             	add    $0x10,%esp
4000083e:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000842:	85 c0                	test   %eax,%eax
40000844:	7f 8b                	jg     400007d1 <.L19+0x90>
                 (ch = *p++) != '\0' && (precision < 0
40000846:	b9 28 00 00 00       	mov    $0x28,%ecx
4000084b:	b8 28 00 00 00       	mov    $0x28,%eax
40000850:	8b 5c 24 18          	mov    0x18(%esp),%ebx
40000854:	89 74 24 40          	mov    %esi,0x40(%esp)
40000858:	89 d6                	mov    %edx,%esi
4000085a:	89 6c 24 48          	mov    %ebp,0x48(%esp)
4000085e:	8b 6c 24 08          	mov    0x8(%esp),%ebp
40000862:	83 c3 01             	add    $0x1,%ebx
40000865:	e9 3b fe ff ff       	jmp    400006a5 <.L25+0x88>
4000086a:	8b 44 24 18          	mov    0x18(%esp),%eax
4000086e:	0f be 08             	movsbl (%eax),%ecx
40000871:	89 c8                	mov    %ecx,%eax
40000873:	85 c9                	test   %ecx,%ecx
40000875:	75 d9                	jne    40000850 <.L19+0x10f>
40000877:	e9 74 fe ff ff       	jmp    400006f0 <.L25+0xd3>
4000087c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000880 <printfmt>:
{
40000880:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
40000883:	8d 44 24 1c          	lea    0x1c(%esp),%eax
40000887:	50                   	push   %eax
40000888:	ff 74 24 1c          	push   0x1c(%esp)
4000088c:	ff 74 24 1c          	push   0x1c(%esp)
40000890:	ff 74 24 1c          	push   0x1c(%esp)
40000894:	e8 d7 fa ff ff       	call   40000370 <vprintfmt>
}
40000899:	83 c4 1c             	add    $0x1c,%esp
4000089c:	c3                   	ret
4000089d:	8d 76 00             	lea    0x0(%esi),%esi

400008a0 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008a0:	e8 4e 01 00 00       	call   400009f3 <__x86.get_pc_thunk.ax>
400008a5:	05 4f 37 00 00       	add    $0x374f,%eax
{
400008aa:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008ad:	8b 54 24 20          	mov    0x20(%esp),%edx
400008b1:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
400008b8:	ff 
400008b9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400008c0:	00 
400008c1:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400008c5:	ff 74 24 28          	push   0x28(%esp)
400008c9:	ff 74 24 28          	push   0x28(%esp)
400008cd:	8d 80 5c c3 ff ff    	lea    -0x3ca4(%eax),%eax
400008d3:	8d 54 24 0c          	lea    0xc(%esp),%edx
400008d7:	52                   	push   %edx
400008d8:	50                   	push   %eax
400008d9:	e8 92 fa ff ff       	call   40000370 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400008de:	8b 44 24 14          	mov    0x14(%esp),%eax
400008e2:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400008e5:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400008e9:	83 c4 2c             	add    $0x2c,%esp
400008ec:	c3                   	ret
400008ed:	8d 76 00             	lea    0x0(%esi),%esi

400008f0 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400008f0:	e8 fe 00 00 00       	call   400009f3 <__x86.get_pc_thunk.ax>
400008f5:	05 ff 36 00 00       	add    $0x36ff,%eax
{
400008fa:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
400008fd:	8b 54 24 20          	mov    0x20(%esp),%edx
40000901:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000908:	ff 
40000909:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000910:	00 
40000911:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000915:	8d 54 24 28          	lea    0x28(%esp),%edx
40000919:	52                   	push   %edx
4000091a:	ff 74 24 28          	push   0x28(%esp)
4000091e:	8d 80 5c c3 ff ff    	lea    -0x3ca4(%eax),%eax
40000924:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000928:	52                   	push   %edx
40000929:	50                   	push   %eax
4000092a:	e8 41 fa ff ff       	call   40000370 <vprintfmt>
    *b.buf = '\0';
4000092f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000933:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000936:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000093a:	83 c4 2c             	add    $0x2c,%esp
4000093d:	c3                   	ret
4000093e:	66 90                	xchg   %ax,%ax

40000940 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000940:	e8 b2 00 00 00       	call   400009f7 <__x86.get_pc_thunk.dx>
40000945:	81 c2 af 36 00 00    	add    $0x36af,%edx
{
4000094b:	83 ec 1c             	sub    $0x1c,%esp
4000094e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000952:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000956:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
4000095d:	00 
4000095e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000962:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000966:	89 44 24 08          	mov    %eax,0x8(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
4000096a:	ff 74 24 2c          	push   0x2c(%esp)
4000096e:	ff 74 24 2c          	push   0x2c(%esp)
40000972:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000976:	50                   	push   %eax
40000977:	8d 82 5c c3 ff ff    	lea    -0x3ca4(%edx),%eax
4000097d:	50                   	push   %eax
4000097e:	e8 ed f9 ff ff       	call   40000370 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
40000983:	8b 44 24 14          	mov    0x14(%esp),%eax
40000987:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
4000098a:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000098e:	83 c4 2c             	add    $0x2c,%esp
40000991:	c3                   	ret
40000992:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000999:	00 
4000099a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

400009a0 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
400009a0:	e8 52 00 00 00       	call   400009f7 <__x86.get_pc_thunk.dx>
400009a5:	81 c2 4f 36 00 00    	add    $0x364f,%edx
{
400009ab:	83 ec 1c             	sub    $0x1c,%esp
400009ae:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009b2:	8b 4c 24 24          	mov    0x24(%esp),%ecx
400009b6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
400009bd:	00 
400009be:	89 44 24 04          	mov    %eax,0x4(%esp)
400009c2:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
400009c6:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009ca:	8d 44 24 2c          	lea    0x2c(%esp),%eax
400009ce:	50                   	push   %eax
400009cf:	ff 74 24 2c          	push   0x2c(%esp)
400009d3:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009d7:	50                   	push   %eax
400009d8:	8d 82 5c c3 ff ff    	lea    -0x3ca4(%edx),%eax
400009de:	50                   	push   %eax
400009df:	e8 8c f9 ff ff       	call   40000370 <vprintfmt>
    *b.buf = '\0';
400009e4:	8b 44 24 14          	mov    0x14(%esp),%eax
400009e8:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
400009eb:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009ef:	83 c4 2c             	add    $0x2c,%esp
400009f2:	c3                   	ret

400009f3 <__x86.get_pc_thunk.ax>:
400009f3:	8b 04 24             	mov    (%esp),%eax
400009f6:	c3                   	ret

400009f7 <__x86.get_pc_thunk.dx>:
400009f7:	8b 14 24             	mov    (%esp),%edx
400009fa:	c3                   	ret

400009fb <__x86.get_pc_thunk.cx>:
400009fb:	8b 0c 24             	mov    (%esp),%ecx
400009fe:	c3                   	ret
400009ff:	90                   	nop

40000a00 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a00:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a01:	b8 01 00 00 00       	mov    $0x1,%eax
40000a06:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a0a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a0e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a10:	85 c0                	test   %eax,%eax
40000a12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a17:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a1a:	5b                   	pop    %ebx
40000a1b:	c3                   	ret
40000a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a20 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a20:	b8 02 00 00 00       	mov    $0x2,%eax
40000a25:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a27:	c3                   	ret
40000a28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a2f:	00 

40000a30 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000a30:	b8 03 00 00 00       	mov    $0x3,%eax
40000a35:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000a37:	c3                   	ret
40000a38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a3f:	00 

40000a40 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000a40:	b8 04 00 00 00       	mov    $0x4,%eax
40000a45:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000a47:	c3                   	ret
40000a48:	66 90                	xchg   %ax,%ax
40000a4a:	66 90                	xchg   %ax,%ax
40000a4c:	66 90                	xchg   %ax,%ax
40000a4e:	66 90                	xchg   %ax,%ax

40000a50 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000a50:	8b 44 24 04          	mov    0x4(%esp),%eax
40000a54:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000a5a:	c3                   	ret
40000a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000a60 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000a60:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000a64:	b8 01 00 00 00       	mov    $0x1,%eax
40000a69:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000a6c:	85 c0                	test   %eax,%eax
40000a6e:	74 13                	je     40000a83 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000a70:	b9 01 00 00 00       	mov    $0x1,%ecx
40000a75:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000a78:	f3 90                	pause
    asm volatile ("lock; xchgl %0, %1"
40000a7a:	89 c8                	mov    %ecx,%eax
40000a7c:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000a7f:	85 c0                	test   %eax,%eax
40000a81:	75 f5                	jne    40000a78 <spinlock_acquire+0x18>
}
40000a83:	c3                   	ret
40000a84:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a8b:	00 
40000a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a90 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000a90:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000a94:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000a96:	84 c0                	test   %al,%al
40000a98:	74 05                	je     40000a9f <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000a9a:	31 c0                	xor    %eax,%eax
40000a9c:	f0 87 02             	lock xchg %eax,(%edx)
}
40000a9f:	c3                   	ret

40000aa0 <spinlock_holding>:
    return *lk;
40000aa0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000aa4:	8b 00                	mov    (%eax),%eax
}
40000aa6:	c3                   	ret
40000aa7:	66 90                	xchg   %ax,%ax
40000aa9:	66 90                	xchg   %ax,%ax
40000aab:	66 90                	xchg   %ax,%ax
40000aad:	66 90                	xchg   %ax,%ax
40000aaf:	90                   	nop

40000ab0 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000ab0:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000ab4:	31 c0                	xor    %eax,%eax
40000ab6:	80 3a 00             	cmpb   $0x0,(%edx)
40000ab9:	74 15                	je     40000ad0 <strlen+0x20>
40000abb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        n++;
40000ac0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000ac3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000ac7:	75 f7                	jne    40000ac0 <strlen+0x10>
40000ac9:	c3                   	ret
40000aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000ad0:	c3                   	ret
40000ad1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000ad8:	00 
40000ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000ae0 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000ae0:	8b 54 24 08          	mov    0x8(%esp),%edx
40000ae4:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000ae8:	31 c0                	xor    %eax,%eax
40000aea:	85 d2                	test   %edx,%edx
40000aec:	75 09                	jne    40000af7 <strnlen+0x17>
40000aee:	c3                   	ret
40000aef:	90                   	nop
        n++;
40000af0:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000af3:	39 c2                	cmp    %eax,%edx
40000af5:	74 09                	je     40000b00 <strnlen+0x20>
40000af7:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000afb:	75 f3                	jne    40000af0 <strnlen+0x10>
40000afd:	c3                   	ret
40000afe:	66 90                	xchg   %ax,%ax
    return n;
}
40000b00:	c3                   	ret
40000b01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b08:	00 
40000b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b10 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b10:	53                   	push   %ebx
40000b11:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b15:	31 c0                	xor    %eax,%eax
{
40000b17:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ((*dst++ = *src++) != '\0')
40000b20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b27:	83 c0 01             	add    $0x1,%eax
40000b2a:	84 d2                	test   %dl,%dl
40000b2c:	75 f2                	jne    40000b20 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b2e:	89 c8                	mov    %ecx,%eax
40000b30:	5b                   	pop    %ebx
40000b31:	c3                   	ret
40000b32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b39:	00 
40000b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000b40 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000b40:	56                   	push   %esi
40000b41:	53                   	push   %ebx
40000b42:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000b46:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000b4a:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000b4e:	85 db                	test   %ebx,%ebx
40000b50:	74 21                	je     40000b73 <strncpy+0x33>
40000b52:	01 f3                	add    %esi,%ebx
40000b54:	89 f0                	mov    %esi,%eax
40000b56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b5d:	00 
40000b5e:	66 90                	xchg   %ax,%ax
        *dst++ = *src;
40000b60:	0f b6 0a             	movzbl (%edx),%ecx
40000b63:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000b66:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000b69:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000b6c:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000b6f:	39 c3                	cmp    %eax,%ebx
40000b71:	75 ed                	jne    40000b60 <strncpy+0x20>
    }
    return ret;
}
40000b73:	89 f0                	mov    %esi,%eax
40000b75:	5b                   	pop    %ebx
40000b76:	5e                   	pop    %esi
40000b77:	c3                   	ret
40000b78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b7f:	00 

40000b80 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000b80:	56                   	push   %esi
40000b81:	53                   	push   %ebx
40000b82:	8b 44 24 14          	mov    0x14(%esp),%eax
40000b86:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000b8a:	8b 4c 24 10          	mov    0x10(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000b8e:	85 c0                	test   %eax,%eax
40000b90:	74 29                	je     40000bbb <strlcpy+0x3b>
        while (--size > 0 && *src != '\0')
40000b92:	89 f2                	mov    %esi,%edx
40000b94:	83 e8 01             	sub    $0x1,%eax
40000b97:	74 1f                	je     40000bb8 <strlcpy+0x38>
40000b99:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
40000b9c:	eb 0f                	jmp    40000bad <strlcpy+0x2d>
40000b9e:	66 90                	xchg   %ax,%ax
            *dst++ = *src++;
40000ba0:	83 c2 01             	add    $0x1,%edx
40000ba3:	83 c1 01             	add    $0x1,%ecx
40000ba6:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000ba9:	39 da                	cmp    %ebx,%edx
40000bab:	74 07                	je     40000bb4 <strlcpy+0x34>
40000bad:	0f b6 01             	movzbl (%ecx),%eax
40000bb0:	84 c0                	test   %al,%al
40000bb2:	75 ec                	jne    40000ba0 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000bb4:	89 d0                	mov    %edx,%eax
40000bb6:	29 f0                	sub    %esi,%eax
        *dst = '\0';
40000bb8:	c6 02 00             	movb   $0x0,(%edx)
}
40000bbb:	5b                   	pop    %ebx
40000bbc:	5e                   	pop    %esi
40000bbd:	c3                   	ret
40000bbe:	66 90                	xchg   %ax,%ax

40000bc0 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000bc0:	53                   	push   %ebx
40000bc1:	8b 54 24 08          	mov    0x8(%esp),%edx
40000bc5:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000bc9:	0f b6 02             	movzbl (%edx),%eax
40000bcc:	84 c0                	test   %al,%al
40000bce:	75 18                	jne    40000be8 <strcmp+0x28>
40000bd0:	eb 30                	jmp    40000c02 <strcmp+0x42>
40000bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000bd8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000bdc:	83 c2 01             	add    $0x1,%edx
40000bdf:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000be2:	84 c0                	test   %al,%al
40000be4:	74 12                	je     40000bf8 <strcmp+0x38>
40000be6:	89 d9                	mov    %ebx,%ecx
40000be8:	0f b6 19             	movzbl (%ecx),%ebx
40000beb:	38 c3                	cmp    %al,%bl
40000bed:	74 e9                	je     40000bd8 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000bef:	29 d8                	sub    %ebx,%eax
}
40000bf1:	5b                   	pop    %ebx
40000bf2:	c3                   	ret
40000bf3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000bf8:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000bfc:	31 c0                	xor    %eax,%eax
40000bfe:	29 d8                	sub    %ebx,%eax
}
40000c00:	5b                   	pop    %ebx
40000c01:	c3                   	ret
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c02:	0f b6 19             	movzbl (%ecx),%ebx
40000c05:	31 c0                	xor    %eax,%eax
40000c07:	eb e6                	jmp    40000bef <strcmp+0x2f>
40000c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c10 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c10:	53                   	push   %ebx
40000c11:	8b 54 24 10          	mov    0x10(%esp),%edx
40000c15:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c19:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (n > 0 && *p && *p == *q)
40000c1d:	85 d2                	test   %edx,%edx
40000c1f:	75 16                	jne    40000c37 <strncmp+0x27>
40000c21:	eb 2d                	jmp    40000c50 <strncmp+0x40>
40000c23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c28:	3a 19                	cmp    (%ecx),%bl
40000c2a:	75 12                	jne    40000c3e <strncmp+0x2e>
        n--, p++, q++;
40000c2c:	83 c0 01             	add    $0x1,%eax
40000c2f:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000c32:	83 ea 01             	sub    $0x1,%edx
40000c35:	74 19                	je     40000c50 <strncmp+0x40>
40000c37:	0f b6 18             	movzbl (%eax),%ebx
40000c3a:	84 db                	test   %bl,%bl
40000c3c:	75 ea                	jne    40000c28 <strncmp+0x18>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c3e:	0f b6 00             	movzbl (%eax),%eax
40000c41:	0f b6 11             	movzbl (%ecx),%edx
}
40000c44:	5b                   	pop    %ebx
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c45:	29 d0                	sub    %edx,%eax
}
40000c47:	c3                   	ret
40000c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c4f:	00 
        return 0;
40000c50:	31 c0                	xor    %eax,%eax
}
40000c52:	5b                   	pop    %ebx
40000c53:	c3                   	ret
40000c54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c5b:	00 
40000c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000c60 <strchr>:

char *strchr(const char *s, char c)
{
40000c60:	8b 44 24 04          	mov    0x4(%esp),%eax
40000c64:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000c69:	0f b6 10             	movzbl (%eax),%edx
40000c6c:	84 d2                	test   %dl,%dl
40000c6e:	75 13                	jne    40000c83 <strchr+0x23>
40000c70:	eb 1e                	jmp    40000c90 <strchr+0x30>
40000c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c78:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000c7c:	83 c0 01             	add    $0x1,%eax
40000c7f:	84 d2                	test   %dl,%dl
40000c81:	74 0d                	je     40000c90 <strchr+0x30>
        if (*s == c)
40000c83:	38 d1                	cmp    %dl,%cl
40000c85:	75 f1                	jne    40000c78 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000c87:	c3                   	ret
40000c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c8f:	00 
    return 0;
40000c90:	31 c0                	xor    %eax,%eax
}
40000c92:	c3                   	ret
40000c93:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c9a:	00 
40000c9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000ca0 <strfind>:

char *strfind(const char *s, char c)
{
40000ca0:	53                   	push   %ebx
40000ca1:	8b 44 24 08          	mov    0x8(%esp),%eax
40000ca5:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000ca9:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000cac:	38 d3                	cmp    %dl,%bl
40000cae:	74 1f                	je     40000ccf <strfind+0x2f>
40000cb0:	89 d1                	mov    %edx,%ecx
40000cb2:	84 db                	test   %bl,%bl
40000cb4:	75 0e                	jne    40000cc4 <strfind+0x24>
40000cb6:	eb 17                	jmp    40000ccf <strfind+0x2f>
40000cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cbf:	00 
40000cc0:	84 d2                	test   %dl,%dl
40000cc2:	74 0b                	je     40000ccf <strfind+0x2f>
    for (; *s; s++)
40000cc4:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cc8:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000ccb:	38 ca                	cmp    %cl,%dl
40000ccd:	75 f1                	jne    40000cc0 <strfind+0x20>
            break;
    return (char *) s;
}
40000ccf:	5b                   	pop    %ebx
40000cd0:	c3                   	ret
40000cd1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cd8:	00 
40000cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000ce0 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000ce0:	55                   	push   %ebp
40000ce1:	57                   	push   %edi
40000ce2:	56                   	push   %esi
40000ce3:	53                   	push   %ebx
40000ce4:	8b 54 24 14          	mov    0x14(%esp),%edx
40000ce8:	8b 74 24 18          	mov    0x18(%esp),%esi
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000cec:	0f b6 02             	movzbl (%edx),%eax
40000cef:	3c 20                	cmp    $0x20,%al
40000cf1:	75 10                	jne    40000d03 <strtol+0x23>
40000cf3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cf8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000cfc:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000cff:	3c 20                	cmp    $0x20,%al
40000d01:	74 f5                	je     40000cf8 <strtol+0x18>
40000d03:	3c 09                	cmp    $0x9,%al
40000d05:	74 f1                	je     40000cf8 <strtol+0x18>

    // plus/minus sign
    if (*s == '+')
40000d07:	3c 2b                	cmp    $0x2b,%al
40000d09:	0f 84 b1 00 00 00    	je     40000dc0 <strtol+0xe0>
    int neg = 0;
40000d0f:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d11:	3c 2d                	cmp    $0x2d,%al
40000d13:	0f 84 97 00 00 00    	je     40000db0 <strtol+0xd0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d19:	0f b6 02             	movzbl (%edx),%eax
40000d1c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000d23:	ff 
40000d24:	75 1d                	jne    40000d43 <strtol+0x63>
40000d26:	3c 30                	cmp    $0x30,%al
40000d28:	0f 84 a2 00 00 00    	je     40000dd0 <strtol+0xf0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d2e:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
40000d33:	19 c0                	sbb    %eax,%eax
40000d35:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000d39:	83 64 24 1c fa       	andl   $0xfffffffa,0x1c(%esp)
40000d3e:	83 44 24 1c 10       	addl   $0x10,0x1c(%esp)
40000d43:	31 c9                	xor    %ecx,%ecx
40000d45:	eb 1c                	jmp    40000d63 <strtol+0x83>
40000d47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d4e:	00 
40000d4f:	90                   	nop
    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
40000d50:	83 e8 30             	sub    $0x30,%eax
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000d53:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000d57:	7d 2a                	jge    40000d83 <strtol+0xa3>
            break;
        s++, val = (val * base) + dig;
40000d59:	0f af 4c 24 1c       	imul   0x1c(%esp),%ecx
40000d5e:	83 c2 01             	add    $0x1,%edx
40000d61:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000d63:	0f be 02             	movsbl (%edx),%eax
40000d66:	8d 68 d0             	lea    -0x30(%eax),%ebp
40000d69:	89 eb                	mov    %ebp,%ebx
40000d6b:	80 fb 09             	cmp    $0x9,%bl
40000d6e:	76 e0                	jbe    40000d50 <strtol+0x70>
        else if (*s >= 'a' && *s <= 'z')
40000d70:	8d 68 9f             	lea    -0x61(%eax),%ebp
40000d73:	89 eb                	mov    %ebp,%ebx
40000d75:	80 fb 19             	cmp    $0x19,%bl
40000d78:	77 26                	ja     40000da0 <strtol+0xc0>
            dig = *s - 'a' + 10;
40000d7a:	83 e8 57             	sub    $0x57,%eax
        if (dig >= base)
40000d7d:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000d81:	7c d6                	jl     40000d59 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000d83:	85 f6                	test   %esi,%esi
40000d85:	74 02                	je     40000d89 <strtol+0xa9>
        *endptr = (char *) s;
40000d87:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000d89:	89 c8                	mov    %ecx,%eax
}
40000d8b:	5b                   	pop    %ebx
40000d8c:	5e                   	pop    %esi
    return (neg ? -val : val);
40000d8d:	f7 d8                	neg    %eax
40000d8f:	85 ff                	test   %edi,%edi
}
40000d91:	5f                   	pop    %edi
40000d92:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000d93:	0f 45 c8             	cmovne %eax,%ecx
}
40000d96:	89 c8                	mov    %ecx,%eax
40000d98:	c3                   	ret
40000d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000da0:	8d 68 bf             	lea    -0x41(%eax),%ebp
40000da3:	89 eb                	mov    %ebp,%ebx
40000da5:	80 fb 19             	cmp    $0x19,%bl
40000da8:	77 d9                	ja     40000d83 <strtol+0xa3>
            dig = *s - 'A' + 10;
40000daa:	83 e8 37             	sub    $0x37,%eax
40000dad:	eb a4                	jmp    40000d53 <strtol+0x73>
40000daf:	90                   	nop
        s++, neg = 1;
40000db0:	83 c2 01             	add    $0x1,%edx
40000db3:	bf 01 00 00 00       	mov    $0x1,%edi
40000db8:	e9 5c ff ff ff       	jmp    40000d19 <strtol+0x39>
40000dbd:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000dc0:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000dc3:	31 ff                	xor    %edi,%edi
40000dc5:	e9 4f ff ff ff       	jmp    40000d19 <strtol+0x39>
40000dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000dd0:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000dd4:	74 25                	je     40000dfb <strtol+0x11b>
    else if (base == 0 && s[0] == '0')
40000dd6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000dda:	85 c0                	test   %eax,%eax
40000ddc:	74 0d                	je     40000deb <strtol+0x10b>
40000dde:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000de5:	00 
40000de6:	e9 58 ff ff ff       	jmp    40000d43 <strtol+0x63>
        s++, base = 8;
40000deb:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000df2:	00 
40000df3:	83 c2 01             	add    $0x1,%edx
40000df6:	e9 48 ff ff ff       	jmp    40000d43 <strtol+0x63>
        s += 2, base = 16;
40000dfb:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e02:	00 
40000e03:	83 c2 02             	add    $0x2,%edx
40000e06:	e9 38 ff ff ff       	jmp    40000d43 <strtol+0x63>
40000e0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000e10 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e10:	57                   	push   %edi
40000e11:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000e15:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000e19:	85 c9                	test   %ecx,%ecx
40000e1b:	74 19                	je     40000e36 <memset+0x26>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e1d:	89 f8                	mov    %edi,%eax
40000e1f:	09 c8                	or     %ecx,%eax
40000e21:	a8 03                	test   $0x3,%al
40000e23:	75 1b                	jne    40000e40 <memset+0x30>
        c &= 0xFF;
40000e25:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e2a:	c1 e9 02             	shr    $0x2,%ecx
40000e2d:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
        asm volatile ("cld; rep stosl\n"
40000e33:	fc                   	cld
40000e34:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e36:	89 f8                	mov    %edi,%eax
40000e38:	5f                   	pop    %edi
40000e39:	c3                   	ret
40000e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000e40:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e44:	fc                   	cld
40000e45:	f3 aa                	rep stos %al,%es:(%edi)
}
40000e47:	89 f8                	mov    %edi,%eax
40000e49:	5f                   	pop    %edi
40000e4a:	c3                   	ret
40000e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000e50 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000e50:	57                   	push   %edi
40000e51:	56                   	push   %esi
40000e52:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000e56:	8b 74 24 10          	mov    0x10(%esp),%esi
40000e5a:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000e5e:	39 c6                	cmp    %eax,%esi
40000e60:	73 26                	jae    40000e88 <memmove+0x38>
40000e62:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000e65:	39 d0                	cmp    %edx,%eax
40000e67:	73 1f                	jae    40000e88 <memmove+0x38>
        s += n;
        d += n;
40000e69:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000e6c:	89 fe                	mov    %edi,%esi
40000e6e:	09 ce                	or     %ecx,%esi
40000e70:	09 d6                	or     %edx,%esi
40000e72:	83 e6 03             	and    $0x3,%esi
40000e75:	74 39                	je     40000eb0 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000e77:	83 ef 01             	sub    $0x1,%edi
40000e7a:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000e7d:	fd                   	std
40000e7e:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000e80:	fc                   	cld
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000e81:	5e                   	pop    %esi
40000e82:	5f                   	pop    %edi
40000e83:	c3                   	ret
40000e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000e88:	89 c2                	mov    %eax,%edx
40000e8a:	09 ca                	or     %ecx,%edx
40000e8c:	09 f2                	or     %esi,%edx
40000e8e:	83 e2 03             	and    $0x3,%edx
40000e91:	74 0d                	je     40000ea0 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000e93:	89 c7                	mov    %eax,%edi
40000e95:	fc                   	cld
40000e96:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000e98:	5e                   	pop    %esi
40000e99:	5f                   	pop    %edi
40000e9a:	c3                   	ret
40000e9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                          :: "D" (d), "S" (s), "c" (n / 4)
40000ea0:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000ea3:	89 c7                	mov    %eax,%edi
40000ea5:	fc                   	cld
40000ea6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000ea8:	eb ee                	jmp    40000e98 <memmove+0x48>
40000eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000eb0:	83 ef 04             	sub    $0x4,%edi
40000eb3:	8d 72 fc             	lea    -0x4(%edx),%esi
40000eb6:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000eb9:	fd                   	std
40000eba:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000ebc:	eb c2                	jmp    40000e80 <memmove+0x30>
40000ebe:	66 90                	xchg   %ax,%ax

40000ec0 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000ec0:	eb 8e                	jmp    40000e50 <memmove>
40000ec2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000ec9:	00 
40000eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000ed0 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000ed0:	56                   	push   %esi
40000ed1:	53                   	push   %ebx
40000ed2:	8b 74 24 14          	mov    0x14(%esp),%esi
40000ed6:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000eda:	8b 54 24 10          	mov    0x10(%esp),%edx
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000ede:	85 f6                	test   %esi,%esi
40000ee0:	74 2e                	je     40000f10 <memcmp+0x40>
40000ee2:	01 c6                	add    %eax,%esi
40000ee4:	eb 14                	jmp    40000efa <memcmp+0x2a>
40000ee6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000eed:	00 
40000eee:	66 90                	xchg   %ax,%ax
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000ef0:	83 c0 01             	add    $0x1,%eax
40000ef3:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000ef6:	39 f0                	cmp    %esi,%eax
40000ef8:	74 16                	je     40000f10 <memcmp+0x40>
        if (*s1 != *s2)
40000efa:	0f b6 08             	movzbl (%eax),%ecx
40000efd:	0f b6 1a             	movzbl (%edx),%ebx
40000f00:	38 d9                	cmp    %bl,%cl
40000f02:	74 ec                	je     40000ef0 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f04:	0f b6 c1             	movzbl %cl,%eax
40000f07:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f09:	5b                   	pop    %ebx
40000f0a:	5e                   	pop    %esi
40000f0b:	c3                   	ret
40000f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f10:	31 c0                	xor    %eax,%eax
}
40000f12:	5b                   	pop    %ebx
40000f13:	5e                   	pop    %esi
40000f14:	c3                   	ret
40000f15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f1c:	00 
40000f1d:	8d 76 00             	lea    0x0(%esi),%esi

40000f20 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f20:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f24:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f28:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f2a:	39 d0                	cmp    %edx,%eax
40000f2c:	73 1a                	jae    40000f48 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f2e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f33:	eb 0a                	jmp    40000f3f <memchr+0x1f>
40000f35:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f38:	83 c0 01             	add    $0x1,%eax
40000f3b:	39 c2                	cmp    %eax,%edx
40000f3d:	74 09                	je     40000f48 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f3f:	38 08                	cmp    %cl,(%eax)
40000f41:	75 f5                	jne    40000f38 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000f43:	c3                   	ret
40000f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000f48:	31 c0                	xor    %eax,%eax
}
40000f4a:	c3                   	ret
40000f4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000f50 <memzero>:

void *memzero(void *v, size_t n)
{
40000f50:	57                   	push   %edi
40000f51:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000f55:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000f59:	85 c9                	test   %ecx,%ecx
40000f5b:	74 0f                	je     40000f6c <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000f5d:	89 f8                	mov    %edi,%eax
40000f5f:	09 c8                	or     %ecx,%eax
40000f61:	83 e0 03             	and    $0x3,%eax
40000f64:	75 0a                	jne    40000f70 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000f66:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000f69:	fc                   	cld
40000f6a:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000f6c:	89 f8                	mov    %edi,%eax
40000f6e:	5f                   	pop    %edi
40000f6f:	c3                   	ret
        asm volatile ("cld; rep stosb\n"
40000f70:	31 c0                	xor    %eax,%eax
40000f72:	fc                   	cld
40000f73:	f3 aa                	rep stos %al,%es:(%edi)
}
40000f75:	89 f8                	mov    %edi,%eax
40000f77:	5f                   	pop    %edi
40000f78:	c3                   	ret
40000f79:	66 90                	xchg   %ax,%ax
40000f7b:	66 90                	xchg   %ax,%ax
40000f7d:	66 90                	xchg   %ax,%ax
40000f7f:	90                   	nop

40000f80 <__udivdi3>:
40000f80:	f3 0f 1e fb          	endbr32
40000f84:	55                   	push   %ebp
40000f85:	89 e5                	mov    %esp,%ebp
40000f87:	57                   	push   %edi
40000f88:	56                   	push   %esi
40000f89:	53                   	push   %ebx
40000f8a:	83 ec 1c             	sub    $0x1c,%esp
40000f8d:	8b 7d 08             	mov    0x8(%ebp),%edi
40000f90:	8b 45 14             	mov    0x14(%ebp),%eax
40000f93:	8b 75 0c             	mov    0xc(%ebp),%esi
40000f96:	8b 5d 10             	mov    0x10(%ebp),%ebx
40000f99:	89 7d e4             	mov    %edi,-0x1c(%ebp)
40000f9c:	85 c0                	test   %eax,%eax
40000f9e:	75 20                	jne    40000fc0 <__udivdi3+0x40>
40000fa0:	39 de                	cmp    %ebx,%esi
40000fa2:	73 54                	jae    40000ff8 <__udivdi3+0x78>
40000fa4:	89 f8                	mov    %edi,%eax
40000fa6:	31 ff                	xor    %edi,%edi
40000fa8:	89 f2                	mov    %esi,%edx
40000faa:	f7 f3                	div    %ebx
40000fac:	89 fa                	mov    %edi,%edx
40000fae:	83 c4 1c             	add    $0x1c,%esp
40000fb1:	5b                   	pop    %ebx
40000fb2:	5e                   	pop    %esi
40000fb3:	5f                   	pop    %edi
40000fb4:	5d                   	pop    %ebp
40000fb5:	c3                   	ret
40000fb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000fbd:	00 
40000fbe:	66 90                	xchg   %ax,%ax
40000fc0:	39 c6                	cmp    %eax,%esi
40000fc2:	73 14                	jae    40000fd8 <__udivdi3+0x58>
40000fc4:	31 ff                	xor    %edi,%edi
40000fc6:	31 c0                	xor    %eax,%eax
40000fc8:	89 fa                	mov    %edi,%edx
40000fca:	83 c4 1c             	add    $0x1c,%esp
40000fcd:	5b                   	pop    %ebx
40000fce:	5e                   	pop    %esi
40000fcf:	5f                   	pop    %edi
40000fd0:	5d                   	pop    %ebp
40000fd1:	c3                   	ret
40000fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000fd8:	0f bd f8             	bsr    %eax,%edi
40000fdb:	83 f7 1f             	xor    $0x1f,%edi
40000fde:	75 48                	jne    40001028 <__udivdi3+0xa8>
40000fe0:	39 f0                	cmp    %esi,%eax
40000fe2:	72 07                	jb     40000feb <__udivdi3+0x6b>
40000fe4:	31 c0                	xor    %eax,%eax
40000fe6:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
40000fe9:	72 dd                	jb     40000fc8 <__udivdi3+0x48>
40000feb:	b8 01 00 00 00       	mov    $0x1,%eax
40000ff0:	eb d6                	jmp    40000fc8 <__udivdi3+0x48>
40000ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000ff8:	89 d9                	mov    %ebx,%ecx
40000ffa:	85 db                	test   %ebx,%ebx
40000ffc:	75 0b                	jne    40001009 <__udivdi3+0x89>
40000ffe:	b8 01 00 00 00       	mov    $0x1,%eax
40001003:	31 d2                	xor    %edx,%edx
40001005:	f7 f3                	div    %ebx
40001007:	89 c1                	mov    %eax,%ecx
40001009:	31 d2                	xor    %edx,%edx
4000100b:	89 f0                	mov    %esi,%eax
4000100d:	f7 f1                	div    %ecx
4000100f:	89 c6                	mov    %eax,%esi
40001011:	8b 45 e4             	mov    -0x1c(%ebp),%eax
40001014:	89 f7                	mov    %esi,%edi
40001016:	f7 f1                	div    %ecx
40001018:	89 fa                	mov    %edi,%edx
4000101a:	83 c4 1c             	add    $0x1c,%esp
4000101d:	5b                   	pop    %ebx
4000101e:	5e                   	pop    %esi
4000101f:	5f                   	pop    %edi
40001020:	5d                   	pop    %ebp
40001021:	c3                   	ret
40001022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001028:	89 f9                	mov    %edi,%ecx
4000102a:	ba 20 00 00 00       	mov    $0x20,%edx
4000102f:	29 fa                	sub    %edi,%edx
40001031:	d3 e0                	shl    %cl,%eax
40001033:	89 45 e0             	mov    %eax,-0x20(%ebp)
40001036:	89 d1                	mov    %edx,%ecx
40001038:	89 d8                	mov    %ebx,%eax
4000103a:	d3 e8                	shr    %cl,%eax
4000103c:	89 c1                	mov    %eax,%ecx
4000103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
40001041:	09 c1                	or     %eax,%ecx
40001043:	89 f0                	mov    %esi,%eax
40001045:	89 4d e0             	mov    %ecx,-0x20(%ebp)
40001048:	89 f9                	mov    %edi,%ecx
4000104a:	d3 e3                	shl    %cl,%ebx
4000104c:	89 d1                	mov    %edx,%ecx
4000104e:	d3 e8                	shr    %cl,%eax
40001050:	89 5d dc             	mov    %ebx,-0x24(%ebp)
40001053:	89 f9                	mov    %edi,%ecx
40001055:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
40001058:	d3 e6                	shl    %cl,%esi
4000105a:	89 d1                	mov    %edx,%ecx
4000105c:	d3 eb                	shr    %cl,%ebx
4000105e:	09 f3                	or     %esi,%ebx
40001060:	89 c6                	mov    %eax,%esi
40001062:	89 f2                	mov    %esi,%edx
40001064:	89 d8                	mov    %ebx,%eax
40001066:	f7 75 e0             	divl   -0x20(%ebp)
40001069:	89 d6                	mov    %edx,%esi
4000106b:	89 c3                	mov    %eax,%ebx
4000106d:	f7 65 dc             	mull   -0x24(%ebp)
40001070:	89 55 e0             	mov    %edx,-0x20(%ebp)
40001073:	39 d6                	cmp    %edx,%esi
40001075:	72 21                	jb     40001098 <__udivdi3+0x118>
40001077:	8b 55 e4             	mov    -0x1c(%ebp),%edx
4000107a:	89 f9                	mov    %edi,%ecx
4000107c:	d3 e2                	shl    %cl,%edx
4000107e:	39 c2                	cmp    %eax,%edx
40001080:	73 07                	jae    40001089 <__udivdi3+0x109>
40001082:	8b 55 e0             	mov    -0x20(%ebp),%edx
40001085:	39 d6                	cmp    %edx,%esi
40001087:	74 0f                	je     40001098 <__udivdi3+0x118>
40001089:	89 d8                	mov    %ebx,%eax
4000108b:	31 ff                	xor    %edi,%edi
4000108d:	e9 36 ff ff ff       	jmp    40000fc8 <__udivdi3+0x48>
40001092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001098:	8d 43 ff             	lea    -0x1(%ebx),%eax
4000109b:	31 ff                	xor    %edi,%edi
4000109d:	e9 26 ff ff ff       	jmp    40000fc8 <__udivdi3+0x48>
400010a2:	66 90                	xchg   %ax,%ax
400010a4:	66 90                	xchg   %ax,%ax
400010a6:	66 90                	xchg   %ax,%ax
400010a8:	66 90                	xchg   %ax,%ax
400010aa:	66 90                	xchg   %ax,%ax
400010ac:	66 90                	xchg   %ax,%ax
400010ae:	66 90                	xchg   %ax,%ax

400010b0 <__umoddi3>:
400010b0:	f3 0f 1e fb          	endbr32
400010b4:	55                   	push   %ebp
400010b5:	89 e5                	mov    %esp,%ebp
400010b7:	57                   	push   %edi
400010b8:	56                   	push   %esi
400010b9:	53                   	push   %ebx
400010ba:	83 ec 2c             	sub    $0x2c,%esp
400010bd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
400010c0:	8b 45 14             	mov    0x14(%ebp),%eax
400010c3:	8b 75 08             	mov    0x8(%ebp),%esi
400010c6:	8b 7d 10             	mov    0x10(%ebp),%edi
400010c9:	89 da                	mov    %ebx,%edx
400010cb:	85 c0                	test   %eax,%eax
400010cd:	75 19                	jne    400010e8 <__umoddi3+0x38>
400010cf:	39 fb                	cmp    %edi,%ebx
400010d1:	73 5d                	jae    40001130 <__umoddi3+0x80>
400010d3:	89 f0                	mov    %esi,%eax
400010d5:	f7 f7                	div    %edi
400010d7:	89 d0                	mov    %edx,%eax
400010d9:	31 d2                	xor    %edx,%edx
400010db:	83 c4 2c             	add    $0x2c,%esp
400010de:	5b                   	pop    %ebx
400010df:	5e                   	pop    %esi
400010e0:	5f                   	pop    %edi
400010e1:	5d                   	pop    %ebp
400010e2:	c3                   	ret
400010e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
400010e8:	89 75 e0             	mov    %esi,-0x20(%ebp)
400010eb:	39 c3                	cmp    %eax,%ebx
400010ed:	73 11                	jae    40001100 <__umoddi3+0x50>
400010ef:	89 f0                	mov    %esi,%eax
400010f1:	83 c4 2c             	add    $0x2c,%esp
400010f4:	5b                   	pop    %ebx
400010f5:	5e                   	pop    %esi
400010f6:	5f                   	pop    %edi
400010f7:	5d                   	pop    %ebp
400010f8:	c3                   	ret
400010f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001100:	0f bd c8             	bsr    %eax,%ecx
40001103:	83 f1 1f             	xor    $0x1f,%ecx
40001106:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
40001109:	75 45                	jne    40001150 <__umoddi3+0xa0>
4000110b:	39 d8                	cmp    %ebx,%eax
4000110d:	0f 82 d5 00 00 00    	jb     400011e8 <__umoddi3+0x138>
40001113:	39 fe                	cmp    %edi,%esi
40001115:	0f 83 cd 00 00 00    	jae    400011e8 <__umoddi3+0x138>
4000111b:	8b 45 e0             	mov    -0x20(%ebp),%eax
4000111e:	83 c4 2c             	add    $0x2c,%esp
40001121:	5b                   	pop    %ebx
40001122:	5e                   	pop    %esi
40001123:	5f                   	pop    %edi
40001124:	5d                   	pop    %ebp
40001125:	c3                   	ret
40001126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000112d:	00 
4000112e:	66 90                	xchg   %ax,%ax
40001130:	89 f9                	mov    %edi,%ecx
40001132:	85 ff                	test   %edi,%edi
40001134:	75 0b                	jne    40001141 <__umoddi3+0x91>
40001136:	b8 01 00 00 00       	mov    $0x1,%eax
4000113b:	31 d2                	xor    %edx,%edx
4000113d:	f7 f7                	div    %edi
4000113f:	89 c1                	mov    %eax,%ecx
40001141:	89 d8                	mov    %ebx,%eax
40001143:	31 d2                	xor    %edx,%edx
40001145:	f7 f1                	div    %ecx
40001147:	89 f0                	mov    %esi,%eax
40001149:	f7 f1                	div    %ecx
4000114b:	eb 8a                	jmp    400010d7 <__umoddi3+0x27>
4000114d:	8d 76 00             	lea    0x0(%esi),%esi
40001150:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
40001153:	ba 20 00 00 00       	mov    $0x20,%edx
40001158:	29 ca                	sub    %ecx,%edx
4000115a:	d3 e0                	shl    %cl,%eax
4000115c:	89 45 dc             	mov    %eax,-0x24(%ebp)
4000115f:	89 d1                	mov    %edx,%ecx
40001161:	89 f8                	mov    %edi,%eax
40001163:	d3 e8                	shr    %cl,%eax
40001165:	89 55 e0             	mov    %edx,-0x20(%ebp)
40001168:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
4000116c:	89 c2                	mov    %eax,%edx
4000116e:	8b 45 dc             	mov    -0x24(%ebp),%eax
40001171:	d3 e7                	shl    %cl,%edi
40001173:	09 c2                	or     %eax,%edx
40001175:	8b 45 e0             	mov    -0x20(%ebp),%eax
40001178:	89 7d d8             	mov    %edi,-0x28(%ebp)
4000117b:	89 f7                	mov    %esi,%edi
4000117d:	89 55 dc             	mov    %edx,-0x24(%ebp)
40001180:	89 da                	mov    %ebx,%edx
40001182:	89 c1                	mov    %eax,%ecx
40001184:	d3 ea                	shr    %cl,%edx
40001186:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
4000118a:	d3 e3                	shl    %cl,%ebx
4000118c:	89 c1                	mov    %eax,%ecx
4000118e:	d3 ef                	shr    %cl,%edi
40001190:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
40001194:	89 f8                	mov    %edi,%eax
40001196:	d3 e6                	shl    %cl,%esi
40001198:	09 d8                	or     %ebx,%eax
4000119a:	f7 75 dc             	divl   -0x24(%ebp)
4000119d:	89 d3                	mov    %edx,%ebx
4000119f:	89 75 d4             	mov    %esi,-0x2c(%ebp)
400011a2:	89 f7                	mov    %esi,%edi
400011a4:	f7 65 d8             	mull   -0x28(%ebp)
400011a7:	89 c6                	mov    %eax,%esi
400011a9:	89 d1                	mov    %edx,%ecx
400011ab:	39 d3                	cmp    %edx,%ebx
400011ad:	72 06                	jb     400011b5 <__umoddi3+0x105>
400011af:	75 0e                	jne    400011bf <__umoddi3+0x10f>
400011b1:	39 c7                	cmp    %eax,%edi
400011b3:	73 0a                	jae    400011bf <__umoddi3+0x10f>
400011b5:	2b 45 d8             	sub    -0x28(%ebp),%eax
400011b8:	1b 55 dc             	sbb    -0x24(%ebp),%edx
400011bb:	89 d1                	mov    %edx,%ecx
400011bd:	89 c6                	mov    %eax,%esi
400011bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
400011c2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
400011c5:	29 f0                	sub    %esi,%eax
400011c7:	19 cb                	sbb    %ecx,%ebx
400011c9:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
400011cd:	89 da                	mov    %ebx,%edx
400011cf:	d3 e2                	shl    %cl,%edx
400011d1:	89 f9                	mov    %edi,%ecx
400011d3:	d3 e8                	shr    %cl,%eax
400011d5:	d3 eb                	shr    %cl,%ebx
400011d7:	09 d0                	or     %edx,%eax
400011d9:	89 da                	mov    %ebx,%edx
400011db:	83 c4 2c             	add    $0x2c,%esp
400011de:	5b                   	pop    %ebx
400011df:	5e                   	pop    %esi
400011e0:	5f                   	pop    %edi
400011e1:	5d                   	pop    %ebp
400011e2:	c3                   	ret
400011e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
400011e8:	89 da                	mov    %ebx,%edx
400011ea:	29 fe                	sub    %edi,%esi
400011ec:	19 c2                	sbb    %eax,%edx
400011ee:	89 75 e0             	mov    %esi,-0x20(%ebp)
400011f1:	e9 25 ff ff ff       	jmp    4000111b <__umoddi3+0x6b>
