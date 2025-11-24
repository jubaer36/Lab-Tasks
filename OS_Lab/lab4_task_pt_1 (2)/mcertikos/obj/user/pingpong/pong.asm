
obj/user/pingpong/pong:     file format elf32-i386


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
    printf("pong started.\n");

    for (i = 0; i < 20; i++) {
4000000e:	31 f6                	xor    %esi,%esi
{
40000010:	53                   	push   %ebx
40000011:	e8 31 01 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
40000016:	81 c3 de 3f 00 00    	add    $0x3fde,%ebx
4000001c:	51                   	push   %ecx
4000001d:	83 ec 18             	sub    $0x18,%esp
    printf("pong started.\n");
40000020:	8d 83 48 e0 ff ff    	lea    -0x1fb8(%ebx),%eax
40000026:	50                   	push   %eax
40000027:	e8 84 02 00 00       	call   400002b0 <printf>
4000002c:	83 c4 10             	add    $0x10,%esp
4000002f:	eb 0f                	jmp    40000040 <main+0x40>
40000031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for (i = 0; i < 20; i++) {
40000038:	83 c6 01             	add    $0x1,%esi
4000003b:	83 fe 14             	cmp    $0x14,%esi
4000003e:	74 15                	je     40000055 <main+0x55>
        if (i % 2 == 0)
40000040:	f7 c6 01 00 00 00    	test   $0x1,%esi
40000046:	75 f0                	jne    40000038 <main+0x38>
            consume();
40000048:	e8 53 0a 00 00       	call   40000aa0 <consume>
    for (i = 0; i < 20; i++) {
4000004d:	83 c6 01             	add    $0x1,%esi
40000050:	83 fe 14             	cmp    $0x14,%esi
40000053:	75 eb                	jne    40000040 <main+0x40>
    }

    return 0;
}
40000055:	8d 65 f4             	lea    -0xc(%ebp),%esp
40000058:	31 c0                	xor    %eax,%eax
4000005a:	59                   	pop    %ecx
4000005b:	5b                   	pop    %ebx
4000005c:	5e                   	pop    %esi
4000005d:	5d                   	pop    %ebp
4000005e:	8d 61 fc             	lea    -0x4(%ecx),%esp
40000061:	c3                   	ret

40000062 <_start>:
_start:
	/*
	 * If there are arguments on the stack, then the current stack will not
	 * be aligned to a nice big power-of-two boundary.
	 */
	testl	$0x0fffffff, %esp
40000062:	f7 c4 ff ff ff 0f    	test   $0xfffffff,%esp
	jnz	args_exist
40000068:	75 04                	jne    4000006e <args_exist>

4000006a <noargs>:

noargs:
	/* If no arguments are on the stack, push two dummy zero. */
	pushl	$0
4000006a:	6a 00                	push   $0x0
	pushl	$0
4000006c:	6a 00                	push   $0x0

4000006e <args_exist>:

args_exist:
	/* Jump to the C part. */
	call	main
4000006e:	e8 8d ff ff ff       	call   40000000 <main>

	/* When returning, push the return value on the stack. */
	pushl	%eax
40000073:	50                   	push   %eax

40000074 <spin>:
spin:
	jmp	spin
40000074:	eb fe                	jmp    40000074 <spin>
40000076:	66 90                	xchg   %ax,%ax
40000078:	66 90                	xchg   %ax,%ax
4000007a:	66 90                	xchg   %ax,%ax
4000007c:	66 90                	xchg   %ax,%ax
4000007e:	66 90                	xchg   %ax,%ax

40000080 <debug>:
#include <proc.h>
#include <stdarg.h>
#include <stdio.h>

void debug(const char *file, int line, const char *fmt, ...)
{
40000080:	53                   	push   %ebx
40000081:	e8 c1 00 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
40000086:	81 c3 6e 3f 00 00    	add    $0x3f6e,%ebx
4000008c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[D] %s:%d: ", file, line);
4000008f:	ff 74 24 18          	push   0x18(%esp)
40000093:	ff 74 24 18          	push   0x18(%esp)
40000097:	8d 83 0c e0 ff ff    	lea    -0x1ff4(%ebx),%eax
4000009d:	50                   	push   %eax
4000009e:	e8 0d 02 00 00       	call   400002b0 <printf>
    vcprintf(fmt, ap);
400000a3:	58                   	pop    %eax
400000a4:	5a                   	pop    %edx
400000a5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000a9:	50                   	push   %eax
400000aa:	ff 74 24 24          	push   0x24(%esp)
400000ae:	e8 9d 01 00 00       	call   40000250 <vcprintf>
    va_end(ap);
}
400000b3:	83 c4 18             	add    $0x18,%esp
400000b6:	5b                   	pop    %ebx
400000b7:	c3                   	ret
400000b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400000bf:	00 

400000c0 <warn>:

void warn(const char *file, int line, const char *fmt, ...)
{
400000c0:	53                   	push   %ebx
400000c1:	e8 81 00 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
400000c6:	81 c3 2e 3f 00 00    	add    $0x3f2e,%ebx
400000cc:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[W] %s:%d: ", file, line);
400000cf:	ff 74 24 18          	push   0x18(%esp)
400000d3:	ff 74 24 18          	push   0x18(%esp)
400000d7:	8d 83 18 e0 ff ff    	lea    -0x1fe8(%ebx),%eax
400000dd:	50                   	push   %eax
400000de:	e8 cd 01 00 00       	call   400002b0 <printf>
    vcprintf(fmt, ap);
400000e3:	58                   	pop    %eax
400000e4:	5a                   	pop    %edx
400000e5:	8d 44 24 24          	lea    0x24(%esp),%eax
400000e9:	50                   	push   %eax
400000ea:	ff 74 24 24          	push   0x24(%esp)
400000ee:	e8 5d 01 00 00       	call   40000250 <vcprintf>
    va_end(ap);
}
400000f3:	83 c4 18             	add    $0x18,%esp
400000f6:	5b                   	pop    %ebx
400000f7:	c3                   	ret
400000f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400000ff:	00 

40000100 <panic>:

void panic(const char *file, int line, const char *fmt, ...)
{
40000100:	53                   	push   %ebx
40000101:	e8 41 00 00 00       	call   40000147 <__x86.get_pc_thunk.bx>
40000106:	81 c3 ee 3e 00 00    	add    $0x3eee,%ebx
4000010c:	83 ec 0c             	sub    $0xc,%esp
    va_list ap;
    va_start(ap, fmt);
    printf("[P] %s:%d: ", file, line);
4000010f:	ff 74 24 18          	push   0x18(%esp)
40000113:	ff 74 24 18          	push   0x18(%esp)
40000117:	8d 83 24 e0 ff ff    	lea    -0x1fdc(%ebx),%eax
4000011d:	50                   	push   %eax
4000011e:	e8 8d 01 00 00       	call   400002b0 <printf>
    vcprintf(fmt, ap);
40000123:	58                   	pop    %eax
40000124:	5a                   	pop    %edx
40000125:	8d 44 24 24          	lea    0x24(%esp),%eax
40000129:	50                   	push   %eax
4000012a:	ff 74 24 24          	push   0x24(%esp)
4000012e:	e8 1d 01 00 00       	call   40000250 <vcprintf>
40000133:	83 c4 10             	add    $0x10,%esp
40000136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000013d:	00 
4000013e:	66 90                	xchg   %ax,%ax
    va_end(ap);

    while (1)
        yield();
40000140:	e8 3b 09 00 00       	call   40000a80 <yield>
    while (1)
40000145:	eb f9                	jmp    40000140 <panic+0x40>

40000147 <__x86.get_pc_thunk.bx>:
40000147:	8b 1c 24             	mov    (%esp),%ebx
4000014a:	c3                   	ret
4000014b:	66 90                	xchg   %ax,%ax
4000014d:	66 90                	xchg   %ax,%ax
4000014f:	90                   	nop

40000150 <atoi>:
#include <stdlib.h>

int atoi(const char *buf, int *i)
{
40000150:	55                   	push   %ebp
40000151:	57                   	push   %edi
40000152:	56                   	push   %esi
40000153:	53                   	push   %ebx
    int loc = 0;
    int numstart = 0;
    int acc = 0;
    int negative = 0;
    if (buf[loc] == '+')
40000154:	8b 44 24 14          	mov    0x14(%esp),%eax
40000158:	0f b6 00             	movzbl (%eax),%eax
4000015b:	3c 2b                	cmp    $0x2b,%al
4000015d:	0f 84 8d 00 00 00    	je     400001f0 <atoi+0xa0>
        loc++;
    else if (buf[loc] == '-') {
40000163:	3c 2d                	cmp    $0x2d,%al
40000165:	74 59                	je     400001c0 <atoi+0x70>
        negative = 1;
        loc++;
    }
    numstart = loc;
    // no grab the numbers
    while ('0' <= buf[loc] && buf[loc] <= '9') {
40000167:	8d 50 d0             	lea    -0x30(%eax),%edx
4000016a:	80 fa 09             	cmp    $0x9,%dl
4000016d:	77 71                	ja     400001e0 <atoi+0x90>
    int negative = 0;
4000016f:	31 ff                	xor    %edi,%edi
    int loc = 0;
40000171:	31 f6                	xor    %esi,%esi
        loc++;
40000173:	89 f2                	mov    %esi,%edx
    int acc = 0;
40000175:	31 c9                	xor    %ecx,%ecx
40000177:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000017e:	00 
4000017f:	90                   	nop
        acc = acc * 10 + (buf[loc] - '0');
40000180:	83 e8 30             	sub    $0x30,%eax
40000183:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
        loc++;
40000186:	83 c2 01             	add    $0x1,%edx
        acc = acc * 10 + (buf[loc] - '0');
40000189:	0f be c0             	movsbl %al,%eax
4000018c:	8d 0c 48             	lea    (%eax,%ecx,2),%ecx
    while ('0' <= buf[loc] && buf[loc] <= '9') {
4000018f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000193:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
40000197:	8d 68 d0             	lea    -0x30(%eax),%ebp
4000019a:	89 eb                	mov    %ebp,%ebx
4000019c:	80 fb 09             	cmp    $0x9,%bl
4000019f:	76 df                	jbe    40000180 <atoi+0x30>
    }
    if (numstart == loc) {
400001a1:	39 f2                	cmp    %esi,%edx
400001a3:	74 3b                	je     400001e0 <atoi+0x90>
        // no numbers have actually been scanned
        return 0;
    }
    if (negative)
        acc = -acc;
400001a5:	89 c8                	mov    %ecx,%eax
400001a7:	f7 d8                	neg    %eax
400001a9:	85 ff                	test   %edi,%edi
400001ab:	0f 45 c8             	cmovne %eax,%ecx
    *i = acc;
400001ae:	8b 44 24 18          	mov    0x18(%esp),%eax
400001b2:	89 08                	mov    %ecx,(%eax)
    return loc;
}
400001b4:	89 d0                	mov    %edx,%eax
400001b6:	5b                   	pop    %ebx
400001b7:	5e                   	pop    %esi
400001b8:	5f                   	pop    %edi
400001b9:	5d                   	pop    %ebp
400001ba:	c3                   	ret
400001bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001c0:	8b 44 24 14          	mov    0x14(%esp),%eax
        negative = 1;
400001c4:	bf 01 00 00 00       	mov    $0x1,%edi
        loc++;
400001c9:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001ce:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001d2:	8d 50 d0             	lea    -0x30(%eax),%edx
400001d5:	80 fa 09             	cmp    $0x9,%dl
400001d8:	76 99                	jbe    40000173 <atoi+0x23>
400001da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 0;
400001e0:	31 d2                	xor    %edx,%edx
}
400001e2:	5b                   	pop    %ebx
400001e3:	89 d0                	mov    %edx,%eax
400001e5:	5e                   	pop    %esi
400001e6:	5f                   	pop    %edi
400001e7:	5d                   	pop    %ebp
400001e8:	c3                   	ret
400001e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001f0:	8b 44 24 14          	mov    0x14(%esp),%eax
    int negative = 0;
400001f4:	31 ff                	xor    %edi,%edi
        loc++;
400001f6:	be 01 00 00 00       	mov    $0x1,%esi
    while ('0' <= buf[loc] && buf[loc] <= '9') {
400001fb:	0f b6 40 01          	movzbl 0x1(%eax),%eax
400001ff:	8d 50 d0             	lea    -0x30(%eax),%edx
40000202:	80 fa 09             	cmp    $0x9,%dl
40000205:	0f 86 68 ff ff ff    	jbe    40000173 <atoi+0x23>
        return 0;
4000020b:	31 d2                	xor    %edx,%edx
4000020d:	eb d3                	jmp    400001e2 <atoi+0x92>
4000020f:	90                   	nop

40000210 <putch>:
    int cnt;            // total bytes printed so far
    char buf[MAX_BUF];
};

static void putch(int ch, struct printbuf *b)
{
40000210:	53                   	push   %ebx
40000211:	8b 54 24 0c          	mov    0xc(%esp),%edx
    b->buf[b->idx++] = ch;
40000215:	0f b6 5c 24 08       	movzbl 0x8(%esp),%ebx
4000021a:	8b 02                	mov    (%edx),%eax
4000021c:	8d 48 01             	lea    0x1(%eax),%ecx
4000021f:	89 0a                	mov    %ecx,(%edx)
40000221:	88 5c 02 08          	mov    %bl,0x8(%edx,%eax,1)
    if (b->idx == MAX_BUF - 1) {
40000225:	81 f9 ff 01 00 00    	cmp    $0x1ff,%ecx
4000022b:	75 14                	jne    40000241 <putch+0x31>
        b->buf[b->idx] = 0;
4000022d:	c6 82 07 02 00 00 00 	movb   $0x0,0x207(%edx)
        puts(b->buf, b->idx);
40000234:	8d 5a 08             	lea    0x8(%edx),%ebx
#include <types.h>
#include <x86.h>

static gcc_inline void sys_puts(const char *s, size_t len)
{
    asm volatile ("int %0"
40000237:	31 c0                	xor    %eax,%eax
40000239:	cd 30                	int    $0x30
        b->idx = 0;
4000023b:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    }
    b->cnt++;
40000241:	83 42 04 01          	addl   $0x1,0x4(%edx)
}
40000245:	5b                   	pop    %ebx
40000246:	c3                   	ret
40000247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000024e:	00 
4000024f:	90                   	nop

40000250 <vcprintf>:

int vcprintf(const char *fmt, va_list ap)
{
40000250:	53                   	push   %ebx
40000251:	e8 f1 fe ff ff       	call   40000147 <__x86.get_pc_thunk.bx>
40000256:	81 c3 9e 3d 00 00    	add    $0x3d9e,%ebx
4000025c:	81 ec 18 02 00 00    	sub    $0x218,%esp
    struct printbuf b;

    b.idx = 0;
40000262:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
40000269:	00 
    b.cnt = 0;
4000026a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000271:	00 
    vprintfmt((void *) putch, &b, fmt, ap);
40000272:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000279:	ff b4 24 24 02 00 00 	push   0x224(%esp)
40000280:	8d 44 24 10          	lea    0x10(%esp),%eax
40000284:	50                   	push   %eax
40000285:	8d 83 1c c2 ff ff    	lea    -0x3de4(%ebx),%eax
4000028b:	50                   	push   %eax
4000028c:	e8 3f 01 00 00       	call   400003d0 <vprintfmt>

    b.buf[b.idx] = 0;
40000291:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000295:	8d 5c 24 20          	lea    0x20(%esp),%ebx
40000299:	31 c0                	xor    %eax,%eax
4000029b:	c6 44 0c 20 00       	movb   $0x0,0x20(%esp,%ecx,1)
400002a0:	cd 30                	int    $0x30
    puts(b.buf, b.idx);

    return b.cnt;
}
400002a2:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400002a6:	81 c4 28 02 00 00    	add    $0x228,%esp
400002ac:	5b                   	pop    %ebx
400002ad:	c3                   	ret
400002ae:	66 90                	xchg   %ax,%ax

400002b0 <printf>:

int printf(const char *fmt, ...)
{
400002b0:	83 ec 14             	sub    $0x14,%esp
    va_list ap;
    int cnt;

    va_start(ap, fmt);
    cnt = vcprintf(fmt, ap);
400002b3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400002b7:	50                   	push   %eax
400002b8:	ff 74 24 1c          	push   0x1c(%esp)
400002bc:	e8 8f ff ff ff       	call   40000250 <vcprintf>
    va_end(ap);

    return cnt;
}
400002c1:	83 c4 1c             	add    $0x1c,%esp
400002c4:	c3                   	ret
400002c5:	66 90                	xchg   %ax,%ax
400002c7:	66 90                	xchg   %ax,%ax
400002c9:	66 90                	xchg   %ax,%ax
400002cb:	66 90                	xchg   %ax,%ax
400002cd:	66 90                	xchg   %ax,%ax
400002cf:	90                   	nop

400002d0 <printnum>:
static void
printnum(void (*putch)(int, void *), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
400002d0:	e8 86 07 00 00       	call   40000a5b <__x86.get_pc_thunk.cx>
400002d5:	81 c1 1f 3d 00 00    	add    $0x3d1f,%ecx
{
400002db:	55                   	push   %ebp
400002dc:	57                   	push   %edi
400002dd:	89 d7                	mov    %edx,%edi
400002df:	56                   	push   %esi
400002e0:	89 c6                	mov    %eax,%esi
400002e2:	53                   	push   %ebx
400002e3:	83 ec 2c             	sub    $0x2c,%esp
400002e6:	8b 44 24 40          	mov    0x40(%esp),%eax
400002ea:	8b 54 24 44          	mov    0x44(%esp),%edx
400002ee:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
    if (num >= base) {
400002f2:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
400002f9:	00 
{
400002fa:	8b 6c 24 50          	mov    0x50(%esp),%ebp
400002fe:	89 44 24 08          	mov    %eax,0x8(%esp)
40000302:	8b 44 24 48          	mov    0x48(%esp),%eax
40000306:	89 54 24 0c          	mov    %edx,0xc(%esp)
4000030a:	8b 54 24 4c          	mov    0x4c(%esp),%edx
    if (num >= base) {
4000030e:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000312:	39 44 24 08          	cmp    %eax,0x8(%esp)
40000316:	89 44 24 10          	mov    %eax,0x10(%esp)
4000031a:	1b 4c 24 14          	sbb    0x14(%esp),%ecx
        printnum(putch, putdat, num / base, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (--width > 0)
4000031e:	8d 5a ff             	lea    -0x1(%edx),%ebx
    if (num >= base) {
40000321:	73 55                	jae    40000378 <printnum+0xa8>
        while (--width > 0)
40000323:	83 fa 01             	cmp    $0x1,%edx
40000326:	7e 17                	jle    4000033f <printnum+0x6f>
40000328:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000032f:	00 
            putch(padc, putdat);
40000330:	83 ec 08             	sub    $0x8,%esp
40000333:	57                   	push   %edi
40000334:	55                   	push   %ebp
40000335:	ff d6                	call   *%esi
        while (--width > 0)
40000337:	83 c4 10             	add    $0x10,%esp
4000033a:	83 eb 01             	sub    $0x1,%ebx
4000033d:	75 f1                	jne    40000330 <printnum+0x60>
    }

    // then print this (the least significant) digit
    putch("0123456789abcdef"[num % base], putdat);
4000033f:	89 7c 24 44          	mov    %edi,0x44(%esp)
40000343:	ff 74 24 14          	push   0x14(%esp)
40000347:	ff 74 24 14          	push   0x14(%esp)
4000034b:	ff 74 24 14          	push   0x14(%esp)
4000034f:	ff 74 24 14          	push   0x14(%esp)
40000353:	8b 5c 24 2c          	mov    0x2c(%esp),%ebx
40000357:	e8 b4 0d 00 00       	call   40001110 <__umoddi3>
4000035c:	0f be 84 03 30 e0 ff 	movsbl -0x1fd0(%ebx,%eax,1),%eax
40000363:	ff 
40000364:	89 44 24 50          	mov    %eax,0x50(%esp)
}
40000368:	83 c4 3c             	add    $0x3c,%esp
    putch("0123456789abcdef"[num % base], putdat);
4000036b:	89 f0                	mov    %esi,%eax
}
4000036d:	5b                   	pop    %ebx
4000036e:	5e                   	pop    %esi
4000036f:	5f                   	pop    %edi
40000370:	5d                   	pop    %ebp
    putch("0123456789abcdef"[num % base], putdat);
40000371:	ff e0                	jmp    *%eax
40000373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        printnum(putch, putdat, num / base, base, width - 1, padc);
40000378:	83 ec 0c             	sub    $0xc,%esp
4000037b:	55                   	push   %ebp
4000037c:	53                   	push   %ebx
4000037d:	50                   	push   %eax
4000037e:	83 ec 08             	sub    $0x8,%esp
40000381:	ff 74 24 34          	push   0x34(%esp)
40000385:	ff 74 24 34          	push   0x34(%esp)
40000389:	ff 74 24 34          	push   0x34(%esp)
4000038d:	ff 74 24 34          	push   0x34(%esp)
40000391:	8b 5c 24 4c          	mov    0x4c(%esp),%ebx
40000395:	e8 46 0c 00 00       	call   40000fe0 <__udivdi3>
4000039a:	83 c4 18             	add    $0x18,%esp
4000039d:	52                   	push   %edx
4000039e:	89 fa                	mov    %edi,%edx
400003a0:	50                   	push   %eax
400003a1:	89 f0                	mov    %esi,%eax
400003a3:	e8 28 ff ff ff       	call   400002d0 <printnum>
400003a8:	83 c4 20             	add    $0x20,%esp
400003ab:	eb 92                	jmp    4000033f <printnum+0x6f>
400003ad:	8d 76 00             	lea    0x0(%esi),%esi

400003b0 <sprintputch>:
    char *ebuf;
    int cnt;
};

static void sprintputch(int ch, struct sprintbuf *b)
{
400003b0:	8b 44 24 08          	mov    0x8(%esp),%eax
    b->cnt++;
400003b4:	83 40 08 01          	addl   $0x1,0x8(%eax)
    if (b->buf < b->ebuf)
400003b8:	8b 10                	mov    (%eax),%edx
400003ba:	3b 50 04             	cmp    0x4(%eax),%edx
400003bd:	73 0b                	jae    400003ca <sprintputch+0x1a>
        *b->buf++ = ch;
400003bf:	8d 4a 01             	lea    0x1(%edx),%ecx
400003c2:	89 08                	mov    %ecx,(%eax)
400003c4:	8b 44 24 04          	mov    0x4(%esp),%eax
400003c8:	88 02                	mov    %al,(%edx)
}
400003ca:	c3                   	ret
400003cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

400003d0 <vprintfmt>:
{
400003d0:	e8 7e 06 00 00       	call   40000a53 <__x86.get_pc_thunk.ax>
400003d5:	05 1f 3c 00 00       	add    $0x3c1f,%eax
400003da:	55                   	push   %ebp
400003db:	57                   	push   %edi
400003dc:	56                   	push   %esi
400003dd:	53                   	push   %ebx
400003de:	83 ec 2c             	sub    $0x2c,%esp
400003e1:	8b 74 24 40          	mov    0x40(%esp),%esi
400003e5:	8b 7c 24 44          	mov    0x44(%esp),%edi
400003e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
400003ed:	8b 6c 24 48          	mov    0x48(%esp),%ebp
        while ((ch = *(unsigned char *) fmt++) != '%') {
400003f1:	0f b6 45 00          	movzbl 0x0(%ebp),%eax
400003f5:	8d 5d 01             	lea    0x1(%ebp),%ebx
400003f8:	83 f8 25             	cmp    $0x25,%eax
400003fb:	75 19                	jne    40000416 <vprintfmt+0x46>
400003fd:	eb 29                	jmp    40000428 <vprintfmt+0x58>
400003ff:	90                   	nop
            putch(ch, putdat);
40000400:	83 ec 08             	sub    $0x8,%esp
        while ((ch = *(unsigned char *) fmt++) != '%') {
40000403:	83 c3 01             	add    $0x1,%ebx
            putch(ch, putdat);
40000406:	57                   	push   %edi
40000407:	50                   	push   %eax
40000408:	ff d6                	call   *%esi
        while ((ch = *(unsigned char *) fmt++) != '%') {
4000040a:	0f b6 43 ff          	movzbl -0x1(%ebx),%eax
4000040e:	83 c4 10             	add    $0x10,%esp
40000411:	83 f8 25             	cmp    $0x25,%eax
40000414:	74 12                	je     40000428 <vprintfmt+0x58>
            if (ch == '\0')
40000416:	85 c0                	test   %eax,%eax
40000418:	75 e6                	jne    40000400 <vprintfmt+0x30>
}
4000041a:	83 c4 2c             	add    $0x2c,%esp
4000041d:	5b                   	pop    %ebx
4000041e:	5e                   	pop    %esi
4000041f:	5f                   	pop    %edi
40000420:	5d                   	pop    %ebp
40000421:	c3                   	ret
40000422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        precision = -1;
40000428:	ba ff ff ff ff       	mov    $0xffffffff,%edx
        padc = ' ';
4000042d:	c6 44 24 10 20       	movb   $0x20,0x10(%esp)
        altflag = 0;
40000432:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
        width = -1;
40000439:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000440:	ff 
        lflag = 0;
40000441:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
40000448:	00 
40000449:	89 54 24 14          	mov    %edx,0x14(%esp)
4000044d:	89 74 24 40          	mov    %esi,0x40(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000451:	0f b6 0b             	movzbl (%ebx),%ecx
40000454:	8d 6b 01             	lea    0x1(%ebx),%ebp
40000457:	8d 41 dd             	lea    -0x23(%ecx),%eax
4000045a:	3c 55                	cmp    $0x55,%al
4000045c:	77 12                	ja     40000470 <.L21>
4000045e:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000462:	0f b6 c0             	movzbl %al,%eax
40000465:	8b b4 82 58 e0 ff ff 	mov    -0x1fa8(%edx,%eax,4),%esi
4000046c:	01 d6                	add    %edx,%esi
4000046e:	ff e6                	jmp    *%esi

40000470 <.L21>:
            putch('%', putdat);
40000470:	8b 74 24 40          	mov    0x40(%esp),%esi
40000474:	83 ec 08             	sub    $0x8,%esp
            for (fmt--; fmt[-1] != '%'; fmt--)
40000477:	89 dd                	mov    %ebx,%ebp
            putch('%', putdat);
40000479:	57                   	push   %edi
4000047a:	6a 25                	push   $0x25
4000047c:	ff d6                	call   *%esi
            for (fmt--; fmt[-1] != '%'; fmt--)
4000047e:	83 c4 10             	add    $0x10,%esp
40000481:	80 7b ff 25          	cmpb   $0x25,-0x1(%ebx)
40000485:	0f 84 66 ff ff ff    	je     400003f1 <vprintfmt+0x21>
4000048b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000490:	83 ed 01             	sub    $0x1,%ebp
40000493:	80 7d ff 25          	cmpb   $0x25,-0x1(%ebp)
40000497:	75 f7                	jne    40000490 <.L21+0x20>
40000499:	e9 53 ff ff ff       	jmp    400003f1 <vprintfmt+0x21>
4000049e:	66 90                	xchg   %ax,%ax

400004a0 <.L31>:
                ch = *fmt;
400004a0:	0f be 43 01          	movsbl 0x1(%ebx),%eax
                precision = precision * 10 + ch - '0';
400004a4:	8d 51 d0             	lea    -0x30(%ecx),%edx
        switch (ch = *(unsigned char *) fmt++) {
400004a7:	89 eb                	mov    %ebp,%ebx
                precision = precision * 10 + ch - '0';
400004a9:	89 54 24 14          	mov    %edx,0x14(%esp)
                if (ch < '0' || ch > '9')
400004ad:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004b0:	83 f9 09             	cmp    $0x9,%ecx
400004b3:	77 28                	ja     400004dd <.L31+0x3d>
        switch (ch = *(unsigned char *) fmt++) {
400004b5:	8b 74 24 40          	mov    0x40(%esp),%esi
400004b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (precision = 0;; ++fmt) {
400004c0:	83 c3 01             	add    $0x1,%ebx
                precision = precision * 10 + ch - '0';
400004c3:	8d 14 92             	lea    (%edx,%edx,4),%edx
400004c6:	8d 54 50 d0          	lea    -0x30(%eax,%edx,2),%edx
                ch = *fmt;
400004ca:	0f be 03             	movsbl (%ebx),%eax
                if (ch < '0' || ch > '9')
400004cd:	8d 48 d0             	lea    -0x30(%eax),%ecx
400004d0:	83 f9 09             	cmp    $0x9,%ecx
400004d3:	76 eb                	jbe    400004c0 <.L31+0x20>
400004d5:	89 54 24 14          	mov    %edx,0x14(%esp)
400004d9:	89 74 24 40          	mov    %esi,0x40(%esp)
            if (width < 0)
400004dd:	8b 74 24 08          	mov    0x8(%esp),%esi
400004e1:	85 f6                	test   %esi,%esi
400004e3:	0f 89 68 ff ff ff    	jns    40000451 <vprintfmt+0x81>
                width = precision, precision = -1;
400004e9:	8b 44 24 14          	mov    0x14(%esp),%eax
400004ed:	c7 44 24 14 ff ff ff 	movl   $0xffffffff,0x14(%esp)
400004f4:	ff 
400004f5:	89 44 24 08          	mov    %eax,0x8(%esp)
400004f9:	e9 53 ff ff ff       	jmp    40000451 <vprintfmt+0x81>

400004fe <.L35>:
            altflag = 1;
400004fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000505:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
40000507:	e9 45 ff ff ff       	jmp    40000451 <vprintfmt+0x81>

4000050c <.L34>:
            putch(ch, putdat);
4000050c:	8b 74 24 40          	mov    0x40(%esp),%esi
40000510:	83 ec 08             	sub    $0x8,%esp
40000513:	57                   	push   %edi
40000514:	6a 25                	push   $0x25
40000516:	ff d6                	call   *%esi
            break;
40000518:	83 c4 10             	add    $0x10,%esp
4000051b:	e9 d1 fe ff ff       	jmp    400003f1 <vprintfmt+0x21>

40000520 <.L33>:
            precision = va_arg(ap, int);
40000520:	8b 44 24 4c          	mov    0x4c(%esp),%eax
        switch (ch = *(unsigned char *) fmt++) {
40000524:	89 eb                	mov    %ebp,%ebx
            precision = va_arg(ap, int);
40000526:	8b 00                	mov    (%eax),%eax
40000528:	89 44 24 14          	mov    %eax,0x14(%esp)
4000052c:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000530:	83 c0 04             	add    $0x4,%eax
40000533:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto process_precision;
40000537:	eb a4                	jmp    400004dd <.L31+0x3d>

40000539 <.L32>:
            if (width < 0)
40000539:	8b 4c 24 08          	mov    0x8(%esp),%ecx
4000053d:	31 c0                	xor    %eax,%eax
        switch (ch = *(unsigned char *) fmt++) {
4000053f:	89 eb                	mov    %ebp,%ebx
            if (width < 0)
40000541:	85 c9                	test   %ecx,%ecx
40000543:	0f 49 c1             	cmovns %ecx,%eax
40000546:	89 44 24 08          	mov    %eax,0x8(%esp)
            goto reswitch;
4000054a:	e9 02 ff ff ff       	jmp    40000451 <vprintfmt+0x81>

4000054f <.L30>:
            putch(va_arg(ap, int), putdat);
4000054f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000553:	8b 74 24 40          	mov    0x40(%esp),%esi
40000557:	83 ec 08             	sub    $0x8,%esp
4000055a:	57                   	push   %edi
4000055b:	8d 58 04             	lea    0x4(%eax),%ebx
4000055e:	8b 44 24 58          	mov    0x58(%esp),%eax
40000562:	ff 30                	push   (%eax)
40000564:	ff d6                	call   *%esi
            break;
40000566:	83 c4 10             	add    $0x10,%esp
            putch(va_arg(ap, int), putdat);
40000569:	89 5c 24 4c          	mov    %ebx,0x4c(%esp)
            break;
4000056d:	e9 7f fe ff ff       	jmp    400003f1 <vprintfmt+0x21>

40000572 <.L24>:
    if (lflag >= 2)
40000572:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
40000577:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
4000057b:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
4000057f:	0f 8f d8 01 00 00    	jg     4000075d <.L25+0xe0>
        return va_arg(*ap, unsigned long);
40000585:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
40000589:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
4000058c:	31 db                	xor    %ebx,%ebx
4000058e:	ba 0a 00 00 00       	mov    $0xa,%edx
40000593:	8b 09                	mov    (%ecx),%ecx
40000595:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            printnum(putch, putdat, num, base, width, padc);
400005a0:	83 ec 0c             	sub    $0xc,%esp
400005a3:	0f be 44 24 1c       	movsbl 0x1c(%esp),%eax
400005a8:	50                   	push   %eax
400005a9:	89 f0                	mov    %esi,%eax
400005ab:	ff 74 24 18          	push   0x18(%esp)
400005af:	52                   	push   %edx
400005b0:	89 fa                	mov    %edi,%edx
400005b2:	53                   	push   %ebx
400005b3:	51                   	push   %ecx
400005b4:	e8 17 fd ff ff       	call   400002d0 <printnum>
            break;
400005b9:	83 c4 20             	add    $0x20,%esp
400005bc:	e9 30 fe ff ff       	jmp    400003f1 <vprintfmt+0x21>

400005c1 <.L26>:
            putch('0', putdat);
400005c1:	8b 74 24 40          	mov    0x40(%esp),%esi
400005c5:	83 ec 08             	sub    $0x8,%esp
400005c8:	57                   	push   %edi
400005c9:	6a 30                	push   $0x30
400005cb:	ff d6                	call   *%esi
            putch('x', putdat);
400005cd:	59                   	pop    %ecx
400005ce:	5b                   	pop    %ebx
400005cf:	57                   	push   %edi
400005d0:	6a 78                	push   $0x78
            num = (unsigned long long)
400005d2:	31 db                	xor    %ebx,%ebx
            putch('x', putdat);
400005d4:	ff d6                	call   *%esi
            num = (unsigned long long)
400005d6:	8b 44 24 5c          	mov    0x5c(%esp),%eax
            goto number;
400005da:	ba 10 00 00 00       	mov    $0x10,%edx
            num = (unsigned long long)
400005df:	8b 08                	mov    (%eax),%ecx
            goto number;
400005e1:	83 c4 10             	add    $0x10,%esp
                (uintptr_t) va_arg(ap, void *);
400005e4:	83 c0 04             	add    $0x4,%eax
400005e7:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            goto number;
400005eb:	eb b3                	jmp    400005a0 <.L24+0x2e>

400005ed <.L22>:
    if (lflag >= 2)
400005ed:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
400005f2:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, unsigned long long);
400005f6:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
400005fa:	0f 8f 6e 01 00 00    	jg     4000076e <.L25+0xf1>
        return va_arg(*ap, unsigned long);
40000600:	8b 4c 24 4c          	mov    0x4c(%esp),%ecx
            precision = va_arg(ap, int);
40000604:	83 c0 04             	add    $0x4,%eax
        return va_arg(*ap, unsigned long);
40000607:	31 db                	xor    %ebx,%ebx
40000609:	ba 10 00 00 00       	mov    $0x10,%edx
4000060e:	8b 09                	mov    (%ecx),%ecx
40000610:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000614:	eb 8a                	jmp    400005a0 <.L24+0x2e>

40000616 <.L29>:
    if (lflag >= 2)
40000616:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
4000061b:	8b 74 24 40          	mov    0x40(%esp),%esi
        return va_arg(*ap, long long);
4000061f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
    if (lflag >= 2)
40000623:	0f 8f 5b 01 00 00    	jg     40000784 <.L25+0x107>
        return va_arg(*ap, long);
40000629:	8b 00                	mov    (%eax),%eax
4000062b:	89 c3                	mov    %eax,%ebx
4000062d:	89 c1                	mov    %eax,%ecx
4000062f:	8b 44 24 4c          	mov    0x4c(%esp),%eax
40000633:	c1 fb 1f             	sar    $0x1f,%ebx
40000636:	83 c0 04             	add    $0x4,%eax
40000639:	89 44 24 4c          	mov    %eax,0x4c(%esp)
            if ((long long) num < 0) {
4000063d:	85 db                	test   %ebx,%ebx
4000063f:	0f 88 68 01 00 00    	js     400007ad <.L19+0xc>
        return va_arg(*ap, unsigned long long);
40000645:	ba 0a 00 00 00       	mov    $0xa,%edx
4000064a:	e9 51 ff ff ff       	jmp    400005a0 <.L24+0x2e>

4000064f <.L28>:
            lflag++;
4000064f:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
        switch (ch = *(unsigned char *) fmt++) {
40000654:	89 eb                	mov    %ebp,%ebx
            goto reswitch;
40000656:	e9 f6 fd ff ff       	jmp    40000451 <vprintfmt+0x81>

4000065b <.L27>:
            putch('X', putdat);
4000065b:	8b 74 24 40          	mov    0x40(%esp),%esi
4000065f:	83 ec 08             	sub    $0x8,%esp
40000662:	57                   	push   %edi
40000663:	6a 58                	push   $0x58
40000665:	ff d6                	call   *%esi
            putch('X', putdat);
40000667:	58                   	pop    %eax
40000668:	5a                   	pop    %edx
40000669:	57                   	push   %edi
4000066a:	6a 58                	push   $0x58
4000066c:	ff d6                	call   *%esi
            putch('X', putdat);
4000066e:	59                   	pop    %ecx
4000066f:	5b                   	pop    %ebx
40000670:	57                   	push   %edi
40000671:	6a 58                	push   $0x58
40000673:	ff d6                	call   *%esi
            break;
40000675:	83 c4 10             	add    $0x10,%esp
40000678:	e9 74 fd ff ff       	jmp    400003f1 <vprintfmt+0x21>

4000067d <.L25>:
            if ((p = va_arg(ap, char *)) == NULL)
4000067d:	8b 44 24 4c          	mov    0x4c(%esp),%eax
            if (width > 0 && padc != '-')
40000681:	8b 4c 24 08          	mov    0x8(%esp),%ecx
            if ((p = va_arg(ap, char *)) == NULL)
40000685:	8b 54 24 14          	mov    0x14(%esp),%edx
40000689:	8b 74 24 40          	mov    0x40(%esp),%esi
4000068d:	83 c0 04             	add    $0x4,%eax
            if (width > 0 && padc != '-')
40000690:	80 7c 24 10 2d       	cmpb   $0x2d,0x10(%esp)
            if ((p = va_arg(ap, char *)) == NULL)
40000695:	89 44 24 14          	mov    %eax,0x14(%esp)
40000699:	8b 44 24 4c          	mov    0x4c(%esp),%eax
4000069d:	8b 18                	mov    (%eax),%ebx
            if (width > 0 && padc != '-')
4000069f:	0f 95 c0             	setne  %al
400006a2:	85 c9                	test   %ecx,%ecx
400006a4:	0f 9f c1             	setg   %cl
            if ((p = va_arg(ap, char *)) == NULL)
400006a7:	89 5c 24 18          	mov    %ebx,0x18(%esp)
            if (width > 0 && padc != '-')
400006ab:	21 c8                	and    %ecx,%eax
            if ((p = va_arg(ap, char *)) == NULL)
400006ad:	85 db                	test   %ebx,%ebx
400006af:	0f 84 21 01 00 00    	je     400007d6 <.L19+0x35>
            if (width > 0 && padc != '-')
400006b5:	84 c0                	test   %al,%al
400006b7:	0f 85 48 01 00 00    	jne    40000805 <.L19+0x64>
                 (ch = *p++) != '\0' && (precision < 0
400006bd:	89 d8                	mov    %ebx,%eax
400006bf:	8d 5b 01             	lea    0x1(%ebx),%ebx
400006c2:	0f be 08             	movsbl (%eax),%ecx
400006c5:	89 c8                	mov    %ecx,%eax
400006c7:	85 c9                	test   %ecx,%ecx
400006c9:	74 64                	je     4000072f <.L25+0xb2>
400006cb:	89 74 24 40          	mov    %esi,0x40(%esp)
400006cf:	89 d6                	mov    %edx,%esi
400006d1:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400006d5:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400006d9:	eb 2a                	jmp    40000705 <.L25+0x88>
400006db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                if (altflag && (ch < ' ' || ch > '~'))
400006e0:	83 e8 20             	sub    $0x20,%eax
400006e3:	83 f8 5e             	cmp    $0x5e,%eax
400006e6:	76 2d                	jbe    40000715 <.L25+0x98>
                    putch('?', putdat);
400006e8:	83 ec 08             	sub    $0x8,%esp
400006eb:	57                   	push   %edi
400006ec:	6a 3f                	push   $0x3f
400006ee:	ff 54 24 50          	call   *0x50(%esp)
400006f2:	83 c4 10             	add    $0x10,%esp
                 (ch = *p++) != '\0' && (precision < 0
400006f5:	0f be 03             	movsbl (%ebx),%eax
400006f8:	83 c3 01             	add    $0x1,%ebx
                                         || --precision >= 0); width--)
400006fb:	83 ed 01             	sub    $0x1,%ebp
                 (ch = *p++) != '\0' && (precision < 0
400006fe:	0f be c8             	movsbl %al,%ecx
40000701:	85 c9                	test   %ecx,%ecx
40000703:	74 1e                	je     40000723 <.L25+0xa6>
40000705:	85 f6                	test   %esi,%esi
40000707:	78 05                	js     4000070e <.L25+0x91>
                                         || --precision >= 0); width--)
40000709:	83 ee 01             	sub    $0x1,%esi
4000070c:	72 15                	jb     40000723 <.L25+0xa6>
                if (altflag && (ch < ' ' || ch > '~'))
4000070e:	8b 14 24             	mov    (%esp),%edx
40000711:	85 d2                	test   %edx,%edx
40000713:	75 cb                	jne    400006e0 <.L25+0x63>
                    putch(ch, putdat);
40000715:	83 ec 08             	sub    $0x8,%esp
40000718:	57                   	push   %edi
40000719:	51                   	push   %ecx
4000071a:	ff 54 24 50          	call   *0x50(%esp)
4000071e:	83 c4 10             	add    $0x10,%esp
40000721:	eb d2                	jmp    400006f5 <.L25+0x78>
40000723:	89 6c 24 08          	mov    %ebp,0x8(%esp)
40000727:	8b 74 24 40          	mov    0x40(%esp),%esi
4000072b:	8b 6c 24 48          	mov    0x48(%esp),%ebp
            for (; width > 0; width--)
4000072f:	8b 44 24 08          	mov    0x8(%esp),%eax
40000733:	85 c0                	test   %eax,%eax
40000735:	7e 19                	jle    40000750 <.L25+0xd3>
40000737:	89 c3                	mov    %eax,%ebx
40000739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                putch(' ', putdat);
40000740:	83 ec 08             	sub    $0x8,%esp
40000743:	57                   	push   %edi
40000744:	6a 20                	push   $0x20
40000746:	ff d6                	call   *%esi
            for (; width > 0; width--)
40000748:	83 c4 10             	add    $0x10,%esp
4000074b:	83 eb 01             	sub    $0x1,%ebx
4000074e:	75 f0                	jne    40000740 <.L25+0xc3>
            if ((p = va_arg(ap, char *)) == NULL)
40000750:	8b 44 24 14          	mov    0x14(%esp),%eax
40000754:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000758:	e9 94 fc ff ff       	jmp    400003f1 <vprintfmt+0x21>
        return va_arg(*ap, unsigned long long);
4000075d:	8b 08                	mov    (%eax),%ecx
4000075f:	8b 58 04             	mov    0x4(%eax),%ebx
40000762:	83 c0 08             	add    $0x8,%eax
40000765:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000769:	e9 d7 fe ff ff       	jmp    40000645 <.L29+0x2f>
4000076e:	8b 08                	mov    (%eax),%ecx
40000770:	8b 58 04             	mov    0x4(%eax),%ebx
40000773:	83 c0 08             	add    $0x8,%eax
40000776:	ba 10 00 00 00       	mov    $0x10,%edx
4000077b:	89 44 24 4c          	mov    %eax,0x4c(%esp)
4000077f:	e9 1c fe ff ff       	jmp    400005a0 <.L24+0x2e>
        return va_arg(*ap, long long);
40000784:	8b 08                	mov    (%eax),%ecx
40000786:	8b 58 04             	mov    0x4(%eax),%ebx
40000789:	83 c0 08             	add    $0x8,%eax
4000078c:	89 44 24 4c          	mov    %eax,0x4c(%esp)
40000790:	e9 a8 fe ff ff       	jmp    4000063d <.L29+0x27>

40000795 <.L63>:
        switch (ch = *(unsigned char *) fmt++) {
40000795:	c6 44 24 10 30       	movb   $0x30,0x10(%esp)
4000079a:	89 eb                	mov    %ebp,%ebx
4000079c:	e9 b0 fc ff ff       	jmp    40000451 <vprintfmt+0x81>

400007a1 <.L19>:
            padc = '-';
400007a1:	c6 44 24 10 2d       	movb   $0x2d,0x10(%esp)
        switch (ch = *(unsigned char *) fmt++) {
400007a6:	89 eb                	mov    %ebp,%ebx
400007a8:	e9 a4 fc ff ff       	jmp    40000451 <vprintfmt+0x81>
400007ad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
                putch('-', putdat);
400007b1:	83 ec 08             	sub    $0x8,%esp
                num = -(long long) num;
400007b4:	31 db                	xor    %ebx,%ebx
400007b6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
                putch('-', putdat);
400007ba:	57                   	push   %edi
400007bb:	6a 2d                	push   $0x2d
400007bd:	ff d6                	call   *%esi
                num = -(long long) num;
400007bf:	8b 4c 24 10          	mov    0x10(%esp),%ecx
400007c3:	ba 0a 00 00 00       	mov    $0xa,%edx
400007c8:	f7 d9                	neg    %ecx
400007ca:	1b 5c 24 14          	sbb    0x14(%esp),%ebx
400007ce:	83 c4 10             	add    $0x10,%esp
400007d1:	e9 ca fd ff ff       	jmp    400005a0 <.L24+0x2e>
            if (width > 0 && padc != '-')
400007d6:	84 c0                	test   %al,%al
400007d8:	0f 85 99 00 00 00    	jne    40000877 <.L19+0xd6>
                 (ch = *p++) != '\0' && (precision < 0
400007de:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
400007e2:	89 74 24 40          	mov    %esi,0x40(%esp)
400007e6:	b9 28 00 00 00       	mov    $0x28,%ecx
400007eb:	89 d6                	mov    %edx,%esi
400007ed:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400007f1:	b8 28 00 00 00       	mov    $0x28,%eax
400007f6:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400007fa:	8d 9b 42 e0 ff ff    	lea    -0x1fbe(%ebx),%ebx
40000800:	e9 00 ff ff ff       	jmp    40000705 <.L25+0x88>
                for (width -= strnlen(p, precision); width > 0; width--)
40000805:	83 ec 08             	sub    $0x8,%esp
40000808:	52                   	push   %edx
40000809:	89 54 24 28          	mov    %edx,0x28(%esp)
4000080d:	ff 74 24 24          	push   0x24(%esp)
40000811:	8b 5c 24 1c          	mov    0x1c(%esp),%ebx
40000815:	e8 26 03 00 00       	call   40000b40 <strnlen>
4000081a:	29 44 24 18          	sub    %eax,0x18(%esp)
4000081e:	8b 4c 24 18          	mov    0x18(%esp),%ecx
40000822:	83 c4 10             	add    $0x10,%esp
40000825:	8b 54 24 1c          	mov    0x1c(%esp),%edx
40000829:	85 c9                	test   %ecx,%ecx
4000082b:	0f 8e 99 00 00 00    	jle    400008ca <.L19+0x129>
                    putch(padc, putdat);
40000831:	0f be 5c 24 10       	movsbl 0x10(%esp),%ebx
40000836:	89 54 24 10          	mov    %edx,0x10(%esp)
4000083a:	89 6c 24 48          	mov    %ebp,0x48(%esp)
4000083e:	8b 6c 24 08          	mov    0x8(%esp),%ebp
40000842:	83 ec 08             	sub    $0x8,%esp
40000845:	57                   	push   %edi
40000846:	53                   	push   %ebx
40000847:	ff d6                	call   *%esi
                for (width -= strnlen(p, precision); width > 0; width--)
40000849:	83 c4 10             	add    $0x10,%esp
4000084c:	83 ed 01             	sub    $0x1,%ebp
4000084f:	75 f1                	jne    40000842 <.L19+0xa1>
                 (ch = *p++) != '\0' && (precision < 0
40000851:	8b 44 24 18          	mov    0x18(%esp),%eax
40000855:	8b 54 24 10          	mov    0x10(%esp),%edx
40000859:	89 6c 24 08          	mov    %ebp,0x8(%esp)
4000085d:	8b 6c 24 48          	mov    0x48(%esp),%ebp
40000861:	8d 58 01             	lea    0x1(%eax),%ebx
40000864:	0f be 00             	movsbl (%eax),%eax
40000867:	0f be c8             	movsbl %al,%ecx
4000086a:	85 c9                	test   %ecx,%ecx
4000086c:	0f 85 59 fe ff ff    	jne    400006cb <.L25+0x4e>
40000872:	e9 d9 fe ff ff       	jmp    40000750 <.L25+0xd3>
                for (width -= strnlen(p, precision); width > 0; width--)
40000877:	83 ec 08             	sub    $0x8,%esp
4000087a:	52                   	push   %edx
4000087b:	8b 5c 24 18          	mov    0x18(%esp),%ebx
4000087f:	8d 8b 41 e0 ff ff    	lea    -0x1fbf(%ebx),%ecx
40000885:	89 54 24 28          	mov    %edx,0x28(%esp)
40000889:	51                   	push   %ecx
4000088a:	89 4c 24 28          	mov    %ecx,0x28(%esp)
4000088e:	e8 ad 02 00 00       	call   40000b40 <strnlen>
40000893:	29 44 24 18          	sub    %eax,0x18(%esp)
40000897:	8b 44 24 18          	mov    0x18(%esp),%eax
4000089b:	83 c4 10             	add    $0x10,%esp
4000089e:	8b 54 24 1c          	mov    0x1c(%esp),%edx
400008a2:	85 c0                	test   %eax,%eax
400008a4:	7f 8b                	jg     40000831 <.L19+0x90>
                 (ch = *p++) != '\0' && (precision < 0
400008a6:	b9 28 00 00 00       	mov    $0x28,%ecx
400008ab:	b8 28 00 00 00       	mov    $0x28,%eax
400008b0:	8b 5c 24 18          	mov    0x18(%esp),%ebx
400008b4:	89 74 24 40          	mov    %esi,0x40(%esp)
400008b8:	89 d6                	mov    %edx,%esi
400008ba:	89 6c 24 48          	mov    %ebp,0x48(%esp)
400008be:	8b 6c 24 08          	mov    0x8(%esp),%ebp
400008c2:	83 c3 01             	add    $0x1,%ebx
400008c5:	e9 3b fe ff ff       	jmp    40000705 <.L25+0x88>
400008ca:	8b 44 24 18          	mov    0x18(%esp),%eax
400008ce:	0f be 08             	movsbl (%eax),%ecx
400008d1:	89 c8                	mov    %ecx,%eax
400008d3:	85 c9                	test   %ecx,%ecx
400008d5:	75 d9                	jne    400008b0 <.L19+0x10f>
400008d7:	e9 74 fe ff ff       	jmp    40000750 <.L25+0xd3>
400008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

400008e0 <printfmt>:
{
400008e0:	83 ec 0c             	sub    $0xc,%esp
    vprintfmt(putch, putdat, fmt, ap);
400008e3:	8d 44 24 1c          	lea    0x1c(%esp),%eax
400008e7:	50                   	push   %eax
400008e8:	ff 74 24 1c          	push   0x1c(%esp)
400008ec:	ff 74 24 1c          	push   0x1c(%esp)
400008f0:	ff 74 24 1c          	push   0x1c(%esp)
400008f4:	e8 d7 fa ff ff       	call   400003d0 <vprintfmt>
}
400008f9:	83 c4 1c             	add    $0x1c,%esp
400008fc:	c3                   	ret
400008fd:	8d 76 00             	lea    0x0(%esi),%esi

40000900 <vsprintf>:

int vsprintf(char *buf, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
40000900:	e8 4e 01 00 00       	call   40000a53 <__x86.get_pc_thunk.ax>
40000905:	05 ef 36 00 00       	add    $0x36ef,%eax
{
4000090a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000090d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000911:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000918:	ff 
40000919:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000920:	00 
40000921:	89 54 24 04          	mov    %edx,0x4(%esp)

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000925:	ff 74 24 28          	push   0x28(%esp)
40000929:	ff 74 24 28          	push   0x28(%esp)
4000092d:	8d 80 bc c3 ff ff    	lea    -0x3c44(%eax),%eax
40000933:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000937:	52                   	push   %edx
40000938:	50                   	push   %eax
40000939:	e8 92 fa ff ff       	call   400003d0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
4000093e:	8b 44 24 14          	mov    0x14(%esp),%eax
40000942:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
40000945:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000949:	83 c4 2c             	add    $0x2c,%esp
4000094c:	c3                   	ret
4000094d:	8d 76 00             	lea    0x0(%esi),%esi

40000950 <sprintf>:
int sprintf(char *buf, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000950:	e8 fe 00 00 00       	call   40000a53 <__x86.get_pc_thunk.ax>
40000955:	05 9f 36 00 00       	add    $0x369f,%eax
{
4000095a:	83 ec 1c             	sub    $0x1c,%esp
    struct sprintbuf b = { buf, (char *) (intptr_t) ~ 0, 0 };
4000095d:	8b 54 24 20          	mov    0x20(%esp),%edx
40000961:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
40000968:	ff 
40000969:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000970:	00 
40000971:	89 54 24 04          	mov    %edx,0x4(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000975:	8d 54 24 28          	lea    0x28(%esp),%edx
40000979:	52                   	push   %edx
4000097a:	ff 74 24 28          	push   0x28(%esp)
4000097e:	8d 80 bc c3 ff ff    	lea    -0x3c44(%eax),%eax
40000984:	8d 54 24 0c          	lea    0xc(%esp),%edx
40000988:	52                   	push   %edx
40000989:	50                   	push   %eax
4000098a:	e8 41 fa ff ff       	call   400003d0 <vprintfmt>
    *b.buf = '\0';
4000098f:	8b 44 24 14          	mov    0x14(%esp),%eax
40000993:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsprintf(buf, fmt, ap);
    va_end(ap);

    return rc;
}
40000996:	8b 44 24 1c          	mov    0x1c(%esp),%eax
4000099a:	83 c4 2c             	add    $0x2c,%esp
4000099d:	c3                   	ret
4000099e:	66 90                	xchg   %ax,%ax

400009a0 <vsnprintf>:

int vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    struct sprintbuf b = { buf, buf + n - 1, 0 };
400009a0:	e8 b2 00 00 00       	call   40000a57 <__x86.get_pc_thunk.dx>
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

    // print the string to the buffer
    vprintfmt((void *) sprintputch, &b, fmt, ap);
400009ca:	ff 74 24 2c          	push   0x2c(%esp)
400009ce:	ff 74 24 2c          	push   0x2c(%esp)
400009d2:	8d 44 24 0c          	lea    0xc(%esp),%eax
400009d6:	50                   	push   %eax
400009d7:	8d 82 bc c3 ff ff    	lea    -0x3c44(%edx),%eax
400009dd:	50                   	push   %eax
400009de:	e8 ed f9 ff ff       	call   400003d0 <vprintfmt>

    // null terminate the buffer
    *b.buf = '\0';
400009e3:	8b 44 24 14          	mov    0x14(%esp),%eax
400009e7:	c6 00 00             	movb   $0x0,(%eax)

    return b.cnt;
}
400009ea:	8b 44 24 1c          	mov    0x1c(%esp),%eax
400009ee:	83 c4 2c             	add    $0x2c,%esp
400009f1:	c3                   	ret
400009f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
400009f9:	00 
400009fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000a00 <snprintf>:
int snprintf(char *buf, int n, const char *fmt, ...)
{
    va_list ap;
    int rc;

    va_start(ap, fmt);
40000a00:	e8 52 00 00 00       	call   40000a57 <__x86.get_pc_thunk.dx>
40000a05:	81 c2 ef 35 00 00    	add    $0x35ef,%edx
{
40000a0b:	83 ec 1c             	sub    $0x1c,%esp
40000a0e:	8b 44 24 20          	mov    0x20(%esp),%eax
    struct sprintbuf b = { buf, buf + n - 1, 0 };
40000a12:	8b 4c 24 24          	mov    0x24(%esp),%ecx
40000a16:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
40000a1d:	00 
40000a1e:	89 44 24 04          	mov    %eax,0x4(%esp)
40000a22:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
40000a26:	89 44 24 08          	mov    %eax,0x8(%esp)
    vprintfmt((void *) sprintputch, &b, fmt, ap);
40000a2a:	8d 44 24 2c          	lea    0x2c(%esp),%eax
40000a2e:	50                   	push   %eax
40000a2f:	ff 74 24 2c          	push   0x2c(%esp)
40000a33:	8d 44 24 0c          	lea    0xc(%esp),%eax
40000a37:	50                   	push   %eax
40000a38:	8d 82 bc c3 ff ff    	lea    -0x3c44(%edx),%eax
40000a3e:	50                   	push   %eax
40000a3f:	e8 8c f9 ff ff       	call   400003d0 <vprintfmt>
    *b.buf = '\0';
40000a44:	8b 44 24 14          	mov    0x14(%esp),%eax
40000a48:	c6 00 00             	movb   $0x0,(%eax)
    rc = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    return rc;
}
40000a4b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000a4f:	83 c4 2c             	add    $0x2c,%esp
40000a52:	c3                   	ret

40000a53 <__x86.get_pc_thunk.ax>:
40000a53:	8b 04 24             	mov    (%esp),%eax
40000a56:	c3                   	ret

40000a57 <__x86.get_pc_thunk.dx>:
40000a57:	8b 14 24             	mov    (%esp),%edx
40000a5a:	c3                   	ret

40000a5b <__x86.get_pc_thunk.cx>:
40000a5b:	8b 0c 24             	mov    (%esp),%ecx
40000a5e:	c3                   	ret
40000a5f:	90                   	nop

40000a60 <spawn>:
#include <proc.h>
#include <syscall.h>
#include <types.h>

pid_t spawn(uintptr_t exec, unsigned int quota)
{
40000a60:	53                   	push   %ebx
static gcc_inline pid_t sys_spawn(unsigned int elf_id, unsigned int quota)
{
    int errno;
    pid_t pid;

    asm volatile ("int %2"
40000a61:	b8 01 00 00 00       	mov    $0x1,%eax
40000a66:	8b 5c 24 08          	mov    0x8(%esp),%ebx
40000a6a:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000a6e:	cd 30                	int    $0x30
                    "a" (SYS_spawn),
                    "b" (elf_id),
                    "c" (quota)
                  : "cc", "memory");

    return errno ? -1 : pid;
40000a70:	85 c0                	test   %eax,%eax
40000a72:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
40000a77:	0f 44 c3             	cmove  %ebx,%eax
    return sys_spawn(exec, quota);
}
40000a7a:	5b                   	pop    %ebx
40000a7b:	c3                   	ret
40000a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000a80 <yield>:
}

static gcc_inline void sys_yield(void)
{
    asm volatile ("int %0"
40000a80:	b8 02 00 00 00       	mov    $0x2,%eax
40000a85:	cd 30                	int    $0x30

void yield(void)
{
    sys_yield();
}
40000a87:	c3                   	ret
40000a88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a8f:	00 

40000a90 <produce>:
                  : "cc", "memory");
}

static gcc_inline void sys_produce(void)
{
    asm volatile ("int %0"
40000a90:	b8 03 00 00 00       	mov    $0x3,%eax
40000a95:	cd 30                	int    $0x30

void produce(void)
{
    sys_produce();
}
40000a97:	c3                   	ret
40000a98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000a9f:	00 

40000aa0 <consume>:
                  : "cc", "memory");
}

static gcc_inline void sys_consume(void)
{
    asm volatile ("int %0"
40000aa0:	b8 04 00 00 00       	mov    $0x4,%eax
40000aa5:	cd 30                	int    $0x30

void consume(void)
{
    sys_consume();
}
40000aa7:	c3                   	ret
40000aa8:	66 90                	xchg   %ax,%ax
40000aaa:	66 90                	xchg   %ax,%ax
40000aac:	66 90                	xchg   %ax,%ax
40000aae:	66 90                	xchg   %ax,%ax

40000ab0 <spinlock_init>:
    return result;
}

void spinlock_init(spinlock_t *lk)
{
    *lk = 0;
40000ab0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000ab4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
40000aba:	c3                   	ret
40000abb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000ac0 <spinlock_acquire>:

void spinlock_acquire(spinlock_t *lk)
{
40000ac0:	8b 54 24 04          	mov    0x4(%esp),%edx
    asm volatile ("lock; xchgl %0, %1"
40000ac4:	b8 01 00 00 00       	mov    $0x1,%eax
40000ac9:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000acc:	85 c0                	test   %eax,%eax
40000ace:	74 13                	je     40000ae3 <spinlock_acquire+0x23>
    asm volatile ("lock; xchgl %0, %1"
40000ad0:	b9 01 00 00 00       	mov    $0x1,%ecx
40000ad5:	8d 76 00             	lea    0x0(%esi),%esi
        asm volatile ("pause");
40000ad8:	f3 90                	pause
    asm volatile ("lock; xchgl %0, %1"
40000ada:	89 c8                	mov    %ecx,%eax
40000adc:	f0 87 02             	lock xchg %eax,(%edx)
    while (xchg(lk, 1) != 0)
40000adf:	85 c0                	test   %eax,%eax
40000ae1:	75 f5                	jne    40000ad8 <spinlock_acquire+0x18>
}
40000ae3:	c3                   	ret
40000ae4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000aeb:	00 
40000aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000af0 <spinlock_release>:

// Release the lock.
void spinlock_release(spinlock_t *lk)
{
40000af0:	8b 54 24 04          	mov    0x4(%esp),%edx
}

// Check whether this cpu is holding the lock.
bool spinlock_holding(spinlock_t *lk)
{
    return *lk;
40000af4:	8b 02                	mov    (%edx),%eax
    if (spinlock_holding(lk) == FALSE)
40000af6:	84 c0                	test   %al,%al
40000af8:	74 05                	je     40000aff <spinlock_release+0xf>
    asm volatile ("lock; xchgl %0, %1"
40000afa:	31 c0                	xor    %eax,%eax
40000afc:	f0 87 02             	lock xchg %eax,(%edx)
}
40000aff:	c3                   	ret

40000b00 <spinlock_holding>:
    return *lk;
40000b00:	8b 44 24 04          	mov    0x4(%esp),%eax
40000b04:	8b 00                	mov    (%eax),%eax
}
40000b06:	c3                   	ret
40000b07:	66 90                	xchg   %ax,%ax
40000b09:	66 90                	xchg   %ax,%ax
40000b0b:	66 90                	xchg   %ax,%ax
40000b0d:	66 90                	xchg   %ax,%ax
40000b0f:	90                   	nop

40000b10 <strlen>:
#include <string.h>
#include <types.h>

int strlen(const char *s)
{
40000b10:	8b 54 24 04          	mov    0x4(%esp),%edx
    int n;

    for (n = 0; *s != '\0'; s++)
40000b14:	31 c0                	xor    %eax,%eax
40000b16:	80 3a 00             	cmpb   $0x0,(%edx)
40000b19:	74 15                	je     40000b30 <strlen+0x20>
40000b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        n++;
40000b20:	83 c0 01             	add    $0x1,%eax
    for (n = 0; *s != '\0'; s++)
40000b23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
40000b27:	75 f7                	jne    40000b20 <strlen+0x10>
40000b29:	c3                   	ret
40000b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return n;
}
40000b30:	c3                   	ret
40000b31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b38:	00 
40000b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b40 <strnlen>:

int strnlen(const char *s, size_t size)
{
40000b40:	8b 54 24 08          	mov    0x8(%esp),%edx
40000b44:	8b 4c 24 04          	mov    0x4(%esp),%ecx
    int n;

    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b48:	31 c0                	xor    %eax,%eax
40000b4a:	85 d2                	test   %edx,%edx
40000b4c:	75 09                	jne    40000b57 <strnlen+0x17>
40000b4e:	c3                   	ret
40000b4f:	90                   	nop
        n++;
40000b50:	83 c0 01             	add    $0x1,%eax
    for (n = 0; size > 0 && *s != '\0'; s++, size--)
40000b53:	39 c2                	cmp    %eax,%edx
40000b55:	74 09                	je     40000b60 <strnlen+0x20>
40000b57:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
40000b5b:	75 f3                	jne    40000b50 <strnlen+0x10>
40000b5d:	c3                   	ret
40000b5e:	66 90                	xchg   %ax,%ax
    return n;
}
40000b60:	c3                   	ret
40000b61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b68:	00 
40000b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000b70 <strcpy>:

char *strcpy(char *dst, const char *src)
{
40000b70:	53                   	push   %ebx
40000b71:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    char *ret;

    ret = dst;
    while ((*dst++ = *src++) != '\0')
40000b75:	31 c0                	xor    %eax,%eax
{
40000b77:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
40000b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    while ((*dst++ = *src++) != '\0')
40000b80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
40000b84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
40000b87:	83 c0 01             	add    $0x1,%eax
40000b8a:	84 d2                	test   %dl,%dl
40000b8c:	75 f2                	jne    40000b80 <strcpy+0x10>
        /* do nothing */ ;
    return ret;
}
40000b8e:	89 c8                	mov    %ecx,%eax
40000b90:	5b                   	pop    %ebx
40000b91:	c3                   	ret
40000b92:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000b99:	00 
40000b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000ba0 <strncpy>:

char *strncpy(char *dst, const char *src, size_t size)
{
40000ba0:	56                   	push   %esi
40000ba1:	53                   	push   %ebx
40000ba2:	8b 5c 24 14          	mov    0x14(%esp),%ebx
40000ba6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000baa:	8b 54 24 10          	mov    0x10(%esp),%edx
    size_t i;
    char *ret;

    ret = dst;
    for (i = 0; i < size; i++) {
40000bae:	85 db                	test   %ebx,%ebx
40000bb0:	74 21                	je     40000bd3 <strncpy+0x33>
40000bb2:	01 f3                	add    %esi,%ebx
40000bb4:	89 f0                	mov    %esi,%eax
40000bb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000bbd:	00 
40000bbe:	66 90                	xchg   %ax,%ax
        *dst++ = *src;
40000bc0:	0f b6 0a             	movzbl (%edx),%ecx
40000bc3:	83 c0 01             	add    $0x1,%eax
        // If strlen(src) < size, null-pad 'dst' out to 'size' chars
        if (*src != '\0')
            src++;
40000bc6:	80 f9 01             	cmp    $0x1,%cl
        *dst++ = *src;
40000bc9:	88 48 ff             	mov    %cl,-0x1(%eax)
            src++;
40000bcc:	83 da ff             	sbb    $0xffffffff,%edx
    for (i = 0; i < size; i++) {
40000bcf:	39 c3                	cmp    %eax,%ebx
40000bd1:	75 ed                	jne    40000bc0 <strncpy+0x20>
    }
    return ret;
}
40000bd3:	89 f0                	mov    %esi,%eax
40000bd5:	5b                   	pop    %ebx
40000bd6:	5e                   	pop    %esi
40000bd7:	c3                   	ret
40000bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000bdf:	00 

40000be0 <strlcpy>:

size_t strlcpy(char *dst, const char *src, size_t size)
{
40000be0:	56                   	push   %esi
40000be1:	53                   	push   %ebx
40000be2:	8b 44 24 14          	mov    0x14(%esp),%eax
40000be6:	8b 74 24 0c          	mov    0xc(%esp),%esi
40000bea:	8b 4c 24 10          	mov    0x10(%esp),%ecx
    char *dst_in;

    dst_in = dst;
    if (size > 0) {
40000bee:	85 c0                	test   %eax,%eax
40000bf0:	74 29                	je     40000c1b <strlcpy+0x3b>
        while (--size > 0 && *src != '\0')
40000bf2:	89 f2                	mov    %esi,%edx
40000bf4:	83 e8 01             	sub    $0x1,%eax
40000bf7:	74 1f                	je     40000c18 <strlcpy+0x38>
40000bf9:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
40000bfc:	eb 0f                	jmp    40000c0d <strlcpy+0x2d>
40000bfe:	66 90                	xchg   %ax,%ax
            *dst++ = *src++;
40000c00:	83 c2 01             	add    $0x1,%edx
40000c03:	83 c1 01             	add    $0x1,%ecx
40000c06:	88 42 ff             	mov    %al,-0x1(%edx)
        while (--size > 0 && *src != '\0')
40000c09:	39 da                	cmp    %ebx,%edx
40000c0b:	74 07                	je     40000c14 <strlcpy+0x34>
40000c0d:	0f b6 01             	movzbl (%ecx),%eax
40000c10:	84 c0                	test   %al,%al
40000c12:	75 ec                	jne    40000c00 <strlcpy+0x20>
        *dst = '\0';
    }
    return dst - dst_in;
40000c14:	89 d0                	mov    %edx,%eax
40000c16:	29 f0                	sub    %esi,%eax
        *dst = '\0';
40000c18:	c6 02 00             	movb   $0x0,(%edx)
}
40000c1b:	5b                   	pop    %ebx
40000c1c:	5e                   	pop    %esi
40000c1d:	c3                   	ret
40000c1e:	66 90                	xchg   %ax,%ax

40000c20 <strcmp>:

int strcmp(const char *p, const char *q)
{
40000c20:	53                   	push   %ebx
40000c21:	8b 54 24 08          	mov    0x8(%esp),%edx
40000c25:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (*p && *p == *q)
40000c29:	0f b6 02             	movzbl (%edx),%eax
40000c2c:	84 c0                	test   %al,%al
40000c2e:	75 18                	jne    40000c48 <strcmp+0x28>
40000c30:	eb 30                	jmp    40000c62 <strcmp+0x42>
40000c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000c38:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        p++, q++;
40000c3c:	83 c2 01             	add    $0x1,%edx
40000c3f:	8d 59 01             	lea    0x1(%ecx),%ebx
    while (*p && *p == *q)
40000c42:	84 c0                	test   %al,%al
40000c44:	74 12                	je     40000c58 <strcmp+0x38>
40000c46:	89 d9                	mov    %ebx,%ecx
40000c48:	0f b6 19             	movzbl (%ecx),%ebx
40000c4b:	38 c3                	cmp    %al,%bl
40000c4d:	74 e9                	je     40000c38 <strcmp+0x18>
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c4f:	29 d8                	sub    %ebx,%eax
}
40000c51:	5b                   	pop    %ebx
40000c52:	c3                   	ret
40000c53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c58:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
40000c5c:	31 c0                	xor    %eax,%eax
40000c5e:	29 d8                	sub    %ebx,%eax
}
40000c60:	5b                   	pop    %ebx
40000c61:	c3                   	ret
    return (int) ((unsigned char) *p - (unsigned char) *q);
40000c62:	0f b6 19             	movzbl (%ecx),%ebx
40000c65:	31 c0                	xor    %eax,%eax
40000c67:	eb e6                	jmp    40000c4f <strcmp+0x2f>
40000c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000c70 <strncmp>:

int strncmp(const char *p, const char *q, size_t n)
{
40000c70:	53                   	push   %ebx
40000c71:	8b 54 24 10          	mov    0x10(%esp),%edx
40000c75:	8b 44 24 08          	mov    0x8(%esp),%eax
40000c79:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
    while (n > 0 && *p && *p == *q)
40000c7d:	85 d2                	test   %edx,%edx
40000c7f:	75 16                	jne    40000c97 <strncmp+0x27>
40000c81:	eb 2d                	jmp    40000cb0 <strncmp+0x40>
40000c83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000c88:	3a 19                	cmp    (%ecx),%bl
40000c8a:	75 12                	jne    40000c9e <strncmp+0x2e>
        n--, p++, q++;
40000c8c:	83 c0 01             	add    $0x1,%eax
40000c8f:	83 c1 01             	add    $0x1,%ecx
    while (n > 0 && *p && *p == *q)
40000c92:	83 ea 01             	sub    $0x1,%edx
40000c95:	74 19                	je     40000cb0 <strncmp+0x40>
40000c97:	0f b6 18             	movzbl (%eax),%ebx
40000c9a:	84 db                	test   %bl,%bl
40000c9c:	75 ea                	jne    40000c88 <strncmp+0x18>
    if (n == 0)
        return 0;
    else
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000c9e:	0f b6 00             	movzbl (%eax),%eax
40000ca1:	0f b6 11             	movzbl (%ecx),%edx
}
40000ca4:	5b                   	pop    %ebx
        return (int) ((unsigned char) *p - (unsigned char) *q);
40000ca5:	29 d0                	sub    %edx,%eax
}
40000ca7:	c3                   	ret
40000ca8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000caf:	00 
        return 0;
40000cb0:	31 c0                	xor    %eax,%eax
}
40000cb2:	5b                   	pop    %ebx
40000cb3:	c3                   	ret
40000cb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cbb:	00 
40000cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

40000cc0 <strchr>:

char *strchr(const char *s, char c)
{
40000cc0:	8b 44 24 04          	mov    0x4(%esp),%eax
40000cc4:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
    for (; *s; s++)
40000cc9:	0f b6 10             	movzbl (%eax),%edx
40000ccc:	84 d2                	test   %dl,%dl
40000cce:	75 13                	jne    40000ce3 <strchr+0x23>
40000cd0:	eb 1e                	jmp    40000cf0 <strchr+0x30>
40000cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40000cd8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000cdc:	83 c0 01             	add    $0x1,%eax
40000cdf:	84 d2                	test   %dl,%dl
40000ce1:	74 0d                	je     40000cf0 <strchr+0x30>
        if (*s == c)
40000ce3:	38 d1                	cmp    %dl,%cl
40000ce5:	75 f1                	jne    40000cd8 <strchr+0x18>
            return (char *) s;
    return 0;
}
40000ce7:	c3                   	ret
40000ce8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cef:	00 
    return 0;
40000cf0:	31 c0                	xor    %eax,%eax
}
40000cf2:	c3                   	ret
40000cf3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000cfa:	00 
40000cfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000d00 <strfind>:

char *strfind(const char *s, char c)
{
40000d00:	53                   	push   %ebx
40000d01:	8b 44 24 08          	mov    0x8(%esp),%eax
40000d05:	8b 54 24 0c          	mov    0xc(%esp),%edx
    for (; *s; s++)
40000d09:	0f b6 18             	movzbl (%eax),%ebx
        if (*s == c)
40000d0c:	38 d3                	cmp    %dl,%bl
40000d0e:	74 1f                	je     40000d2f <strfind+0x2f>
40000d10:	89 d1                	mov    %edx,%ecx
40000d12:	84 db                	test   %bl,%bl
40000d14:	75 0e                	jne    40000d24 <strfind+0x24>
40000d16:	eb 17                	jmp    40000d2f <strfind+0x2f>
40000d18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d1f:	00 
40000d20:	84 d2                	test   %dl,%dl
40000d22:	74 0b                	je     40000d2f <strfind+0x2f>
    for (; *s; s++)
40000d24:	0f b6 50 01          	movzbl 0x1(%eax),%edx
40000d28:	83 c0 01             	add    $0x1,%eax
        if (*s == c)
40000d2b:	38 ca                	cmp    %cl,%dl
40000d2d:	75 f1                	jne    40000d20 <strfind+0x20>
            break;
    return (char *) s;
}
40000d2f:	5b                   	pop    %ebx
40000d30:	c3                   	ret
40000d31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d38:	00 
40000d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

40000d40 <strtol>:

long strtol(const char *s, char **endptr, int base)
{
40000d40:	55                   	push   %ebp
40000d41:	57                   	push   %edi
40000d42:	56                   	push   %esi
40000d43:	53                   	push   %ebx
40000d44:	8b 54 24 14          	mov    0x14(%esp),%edx
40000d48:	8b 74 24 18          	mov    0x18(%esp),%esi
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t')
40000d4c:	0f b6 02             	movzbl (%edx),%eax
40000d4f:	3c 20                	cmp    $0x20,%al
40000d51:	75 10                	jne    40000d63 <strtol+0x23>
40000d53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40000d58:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        s++;
40000d5c:	83 c2 01             	add    $0x1,%edx
    while (*s == ' ' || *s == '\t')
40000d5f:	3c 20                	cmp    $0x20,%al
40000d61:	74 f5                	je     40000d58 <strtol+0x18>
40000d63:	3c 09                	cmp    $0x9,%al
40000d65:	74 f1                	je     40000d58 <strtol+0x18>

    // plus/minus sign
    if (*s == '+')
40000d67:	3c 2b                	cmp    $0x2b,%al
40000d69:	0f 84 b1 00 00 00    	je     40000e20 <strtol+0xe0>
    int neg = 0;
40000d6f:	31 ff                	xor    %edi,%edi
        s++;
    else if (*s == '-')
40000d71:	3c 2d                	cmp    $0x2d,%al
40000d73:	0f 84 97 00 00 00    	je     40000e10 <strtol+0xd0>
        s++, neg = 1;

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000d79:	0f b6 02             	movzbl (%edx),%eax
40000d7c:	f7 44 24 1c ef ff ff 	testl  $0xffffffef,0x1c(%esp)
40000d83:	ff 
40000d84:	75 1d                	jne    40000da3 <strtol+0x63>
40000d86:	3c 30                	cmp    $0x30,%al
40000d88:	0f 84 a2 00 00 00    	je     40000e30 <strtol+0xf0>
        s += 2, base = 16;
    else if (base == 0 && s[0] == '0')
40000d8e:	83 7c 24 1c 01       	cmpl   $0x1,0x1c(%esp)
40000d93:	19 c0                	sbb    %eax,%eax
40000d95:	89 44 24 1c          	mov    %eax,0x1c(%esp)
40000d99:	83 64 24 1c fa       	andl   $0xfffffffa,0x1c(%esp)
40000d9e:	83 44 24 1c 10       	addl   $0x10,0x1c(%esp)
40000da3:	31 c9                	xor    %ecx,%ecx
40000da5:	eb 1c                	jmp    40000dc3 <strtol+0x83>
40000da7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000dae:	00 
40000daf:	90                   	nop
    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9')
            dig = *s - '0';
40000db0:	83 e8 30             	sub    $0x30,%eax
            dig = *s - 'a' + 10;
        else if (*s >= 'A' && *s <= 'Z')
            dig = *s - 'A' + 10;
        else
            break;
        if (dig >= base)
40000db3:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000db7:	7d 2a                	jge    40000de3 <strtol+0xa3>
            break;
        s++, val = (val * base) + dig;
40000db9:	0f af 4c 24 1c       	imul   0x1c(%esp),%ecx
40000dbe:	83 c2 01             	add    $0x1,%edx
40000dc1:	01 c1                	add    %eax,%ecx
        if (*s >= '0' && *s <= '9')
40000dc3:	0f be 02             	movsbl (%edx),%eax
40000dc6:	8d 68 d0             	lea    -0x30(%eax),%ebp
40000dc9:	89 eb                	mov    %ebp,%ebx
40000dcb:	80 fb 09             	cmp    $0x9,%bl
40000dce:	76 e0                	jbe    40000db0 <strtol+0x70>
        else if (*s >= 'a' && *s <= 'z')
40000dd0:	8d 68 9f             	lea    -0x61(%eax),%ebp
40000dd3:	89 eb                	mov    %ebp,%ebx
40000dd5:	80 fb 19             	cmp    $0x19,%bl
40000dd8:	77 26                	ja     40000e00 <strtol+0xc0>
            dig = *s - 'a' + 10;
40000dda:	83 e8 57             	sub    $0x57,%eax
        if (dig >= base)
40000ddd:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
40000de1:	7c d6                	jl     40000db9 <strtol+0x79>
        // we don't properly detect overflow!
    }

    if (endptr)
40000de3:	85 f6                	test   %esi,%esi
40000de5:	74 02                	je     40000de9 <strtol+0xa9>
        *endptr = (char *) s;
40000de7:	89 16                	mov    %edx,(%esi)
    return (neg ? -val : val);
40000de9:	89 c8                	mov    %ecx,%eax
}
40000deb:	5b                   	pop    %ebx
40000dec:	5e                   	pop    %esi
    return (neg ? -val : val);
40000ded:	f7 d8                	neg    %eax
40000def:	85 ff                	test   %edi,%edi
}
40000df1:	5f                   	pop    %edi
40000df2:	5d                   	pop    %ebp
    return (neg ? -val : val);
40000df3:	0f 45 c8             	cmovne %eax,%ecx
}
40000df6:	89 c8                	mov    %ecx,%eax
40000df8:	c3                   	ret
40000df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        else if (*s >= 'A' && *s <= 'Z')
40000e00:	8d 68 bf             	lea    -0x41(%eax),%ebp
40000e03:	89 eb                	mov    %ebp,%ebx
40000e05:	80 fb 19             	cmp    $0x19,%bl
40000e08:	77 d9                	ja     40000de3 <strtol+0xa3>
            dig = *s - 'A' + 10;
40000e0a:	83 e8 37             	sub    $0x37,%eax
40000e0d:	eb a4                	jmp    40000db3 <strtol+0x73>
40000e0f:	90                   	nop
        s++, neg = 1;
40000e10:	83 c2 01             	add    $0x1,%edx
40000e13:	bf 01 00 00 00       	mov    $0x1,%edi
40000e18:	e9 5c ff ff ff       	jmp    40000d79 <strtol+0x39>
40000e1d:	8d 76 00             	lea    0x0(%esi),%esi
        s++;
40000e20:	83 c2 01             	add    $0x1,%edx
    int neg = 0;
40000e23:	31 ff                	xor    %edi,%edi
40000e25:	e9 4f ff ff ff       	jmp    40000d79 <strtol+0x39>
40000e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
40000e30:	80 7a 01 78          	cmpb   $0x78,0x1(%edx)
40000e34:	74 25                	je     40000e5b <strtol+0x11b>
    else if (base == 0 && s[0] == '0')
40000e36:	8b 44 24 1c          	mov    0x1c(%esp),%eax
40000e3a:	85 c0                	test   %eax,%eax
40000e3c:	74 0d                	je     40000e4b <strtol+0x10b>
40000e3e:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e45:	00 
40000e46:	e9 58 ff ff ff       	jmp    40000da3 <strtol+0x63>
        s++, base = 8;
40000e4b:	c7 44 24 1c 08 00 00 	movl   $0x8,0x1c(%esp)
40000e52:	00 
40000e53:	83 c2 01             	add    $0x1,%edx
40000e56:	e9 48 ff ff ff       	jmp    40000da3 <strtol+0x63>
        s += 2, base = 16;
40000e5b:	c7 44 24 1c 10 00 00 	movl   $0x10,0x1c(%esp)
40000e62:	00 
40000e63:	83 c2 02             	add    $0x2,%edx
40000e66:	e9 38 ff ff ff       	jmp    40000da3 <strtol+0x63>
40000e6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000e70 <memset>:

void *memset(void *v, int c, size_t n)
{
40000e70:	57                   	push   %edi
40000e71:	8b 4c 24 10          	mov    0x10(%esp),%ecx
40000e75:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000e79:	85 c9                	test   %ecx,%ecx
40000e7b:	74 19                	je     40000e96 <memset+0x26>
        return v;
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000e7d:	89 f8                	mov    %edi,%eax
40000e7f:	09 c8                	or     %ecx,%eax
40000e81:	a8 03                	test   $0x3,%al
40000e83:	75 1b                	jne    40000ea0 <memset+0x30>
        c &= 0xFF;
40000e85:	0f b6 44 24 0c       	movzbl 0xc(%esp),%eax
        c = (c << 24) | (c << 16) | (c << 8) | c;
        asm volatile ("cld; rep stosl\n"
                      :: "D" (v), "a" (c), "c" (n / 4)
40000e8a:	c1 e9 02             	shr    $0x2,%ecx
40000e8d:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
        asm volatile ("cld; rep stosl\n"
40000e93:	fc                   	cld
40000e94:	f3 ab                	rep stos %eax,%es:(%edi)
    } else
        asm volatile ("cld; rep stosb\n"
                      :: "D" (v), "a" (c), "c" (n)
                      : "cc", "memory");
    return v;
}
40000e96:	89 f8                	mov    %edi,%eax
40000e98:	5f                   	pop    %edi
40000e99:	c3                   	ret
40000e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        asm volatile ("cld; rep stosb\n"
40000ea0:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000ea4:	fc                   	cld
40000ea5:	f3 aa                	rep stos %al,%es:(%edi)
}
40000ea7:	89 f8                	mov    %edi,%eax
40000ea9:	5f                   	pop    %edi
40000eaa:	c3                   	ret
40000eab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000eb0 <memmove>:

void *memmove(void *dst, const void *src, size_t n)
{
40000eb0:	57                   	push   %edi
40000eb1:	56                   	push   %esi
40000eb2:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000eb6:	8b 74 24 10          	mov    0x10(%esp),%esi
40000eba:	8b 4c 24 14          	mov    0x14(%esp),%ecx
    const char *s;
    char *d;

    s = src;
    d = dst;
    if (s < d && s + n > d) {
40000ebe:	39 c6                	cmp    %eax,%esi
40000ec0:	73 26                	jae    40000ee8 <memmove+0x38>
40000ec2:	8d 14 0e             	lea    (%esi,%ecx,1),%edx
40000ec5:	39 d0                	cmp    %edx,%eax
40000ec7:	73 1f                	jae    40000ee8 <memmove+0x38>
        s += n;
        d += n;
40000ec9:	8d 3c 08             	lea    (%eax,%ecx,1),%edi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ecc:	89 fe                	mov    %edi,%esi
40000ece:	09 ce                	or     %ecx,%esi
40000ed0:	09 d6                	or     %edx,%esi
40000ed2:	83 e6 03             	and    $0x3,%esi
40000ed5:	74 39                	je     40000f10 <memmove+0x60>
            asm volatile ("std; rep movsl\n"
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
                          : "cc", "memory");
        else
            asm volatile ("std; rep movsb\n"
                          :: "D" (d - 1), "S" (s - 1), "c" (n)
40000ed7:	83 ef 01             	sub    $0x1,%edi
40000eda:	8d 72 ff             	lea    -0x1(%edx),%esi
            asm volatile ("std; rep movsb\n"
40000edd:	fd                   	std
40000ede:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
                          : "cc", "memory");
        // Some versions of GCC rely on DF being clear
        asm volatile ("cld" ::: "cc");
40000ee0:	fc                   	cld
            asm volatile ("cld; rep movsb\n"
                          :: "D" (d), "S" (s), "c" (n)
                          : "cc", "memory");
    }
    return dst;
}
40000ee1:	5e                   	pop    %esi
40000ee2:	5f                   	pop    %edi
40000ee3:	c3                   	ret
40000ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if ((int) s % 4 == 0 && (int) d % 4 == 0 && n % 4 == 0)
40000ee8:	89 c2                	mov    %eax,%edx
40000eea:	09 ca                	or     %ecx,%edx
40000eec:	09 f2                	or     %esi,%edx
40000eee:	83 e2 03             	and    $0x3,%edx
40000ef1:	74 0d                	je     40000f00 <memmove+0x50>
            asm volatile ("cld; rep movsb\n"
40000ef3:	89 c7                	mov    %eax,%edi
40000ef5:	fc                   	cld
40000ef6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
}
40000ef8:	5e                   	pop    %esi
40000ef9:	5f                   	pop    %edi
40000efa:	c3                   	ret
40000efb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
                          :: "D" (d), "S" (s), "c" (n / 4)
40000f00:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("cld; rep movsl\n"
40000f03:	89 c7                	mov    %eax,%edi
40000f05:	fc                   	cld
40000f06:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f08:	eb ee                	jmp    40000ef8 <memmove+0x48>
40000f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                          :: "D" (d - 4), "S" (s - 4), "c" (n / 4)
40000f10:	83 ef 04             	sub    $0x4,%edi
40000f13:	8d 72 fc             	lea    -0x4(%edx),%esi
40000f16:	c1 e9 02             	shr    $0x2,%ecx
            asm volatile ("std; rep movsl\n"
40000f19:	fd                   	std
40000f1a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
40000f1c:	eb c2                	jmp    40000ee0 <memmove+0x30>
40000f1e:	66 90                	xchg   %ax,%ax

40000f20 <memcpy>:

void *memcpy(void *dst, const void *src, size_t n)
{
    return memmove(dst, src, n);
40000f20:	eb 8e                	jmp    40000eb0 <memmove>
40000f22:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f29:	00 
40000f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

40000f30 <memcmp>:
}

int memcmp(const void *v1, const void *v2, size_t n)
{
40000f30:	56                   	push   %esi
40000f31:	53                   	push   %ebx
40000f32:	8b 74 24 14          	mov    0x14(%esp),%esi
40000f36:	8b 44 24 0c          	mov    0xc(%esp),%eax
40000f3a:	8b 54 24 10          	mov    0x10(%esp),%edx
    const uint8_t *s1 = (const uint8_t *) v1;
    const uint8_t *s2 = (const uint8_t *) v2;

    while (n-- > 0) {
40000f3e:	85 f6                	test   %esi,%esi
40000f40:	74 2e                	je     40000f70 <memcmp+0x40>
40000f42:	01 c6                	add    %eax,%esi
40000f44:	eb 14                	jmp    40000f5a <memcmp+0x2a>
40000f46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f4d:	00 
40000f4e:	66 90                	xchg   %ax,%ax
        if (*s1 != *s2)
            return (int) *s1 - (int) *s2;
        s1++, s2++;
40000f50:	83 c0 01             	add    $0x1,%eax
40000f53:	83 c2 01             	add    $0x1,%edx
    while (n-- > 0) {
40000f56:	39 f0                	cmp    %esi,%eax
40000f58:	74 16                	je     40000f70 <memcmp+0x40>
        if (*s1 != *s2)
40000f5a:	0f b6 08             	movzbl (%eax),%ecx
40000f5d:	0f b6 1a             	movzbl (%edx),%ebx
40000f60:	38 d9                	cmp    %bl,%cl
40000f62:	74 ec                	je     40000f50 <memcmp+0x20>
            return (int) *s1 - (int) *s2;
40000f64:	0f b6 c1             	movzbl %cl,%eax
40000f67:	29 d8                	sub    %ebx,%eax
    }

    return 0;
}
40000f69:	5b                   	pop    %ebx
40000f6a:	5e                   	pop    %esi
40000f6b:	c3                   	ret
40000f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
40000f70:	31 c0                	xor    %eax,%eax
}
40000f72:	5b                   	pop    %ebx
40000f73:	5e                   	pop    %esi
40000f74:	c3                   	ret
40000f75:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
40000f7c:	00 
40000f7d:	8d 76 00             	lea    0x0(%esi),%esi

40000f80 <memchr>:

void *memchr(const void *s, int c, size_t n)
{
40000f80:	8b 44 24 04          	mov    0x4(%esp),%eax
    const void *ends = (const char *) s + n;
40000f84:	8b 54 24 0c          	mov    0xc(%esp),%edx
40000f88:	01 c2                	add    %eax,%edx
    for (; s < ends; s++)
40000f8a:	39 d0                	cmp    %edx,%eax
40000f8c:	73 1a                	jae    40000fa8 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f8e:	0f b6 4c 24 08       	movzbl 0x8(%esp),%ecx
40000f93:	eb 0a                	jmp    40000f9f <memchr+0x1f>
40000f95:	8d 76 00             	lea    0x0(%esi),%esi
    for (; s < ends; s++)
40000f98:	83 c0 01             	add    $0x1,%eax
40000f9b:	39 c2                	cmp    %eax,%edx
40000f9d:	74 09                	je     40000fa8 <memchr+0x28>
        if (*(const unsigned char *) s == (unsigned char) c)
40000f9f:	38 08                	cmp    %cl,(%eax)
40000fa1:	75 f5                	jne    40000f98 <memchr+0x18>
            return (void *) s;
    return NULL;
}
40000fa3:	c3                   	ret
40000fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return NULL;
40000fa8:	31 c0                	xor    %eax,%eax
}
40000faa:	c3                   	ret
40000fab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

40000fb0 <memzero>:

void *memzero(void *v, size_t n)
{
40000fb0:	57                   	push   %edi
40000fb1:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
40000fb5:	8b 7c 24 08          	mov    0x8(%esp),%edi
    if (n == 0)
40000fb9:	85 c9                	test   %ecx,%ecx
40000fbb:	74 0f                	je     40000fcc <memzero+0x1c>
    if ((int) v % 4 == 0 && n % 4 == 0) {
40000fbd:	89 f8                	mov    %edi,%eax
40000fbf:	09 c8                	or     %ecx,%eax
40000fc1:	83 e0 03             	and    $0x3,%eax
40000fc4:	75 0a                	jne    40000fd0 <memzero+0x20>
                      :: "D" (v), "a" (c), "c" (n / 4)
40000fc6:	c1 e9 02             	shr    $0x2,%ecx
        asm volatile ("cld; rep stosl\n"
40000fc9:	fc                   	cld
40000fca:	f3 ab                	rep stos %eax,%es:(%edi)
    return memset(v, 0, n);
}
40000fcc:	89 f8                	mov    %edi,%eax
40000fce:	5f                   	pop    %edi
40000fcf:	c3                   	ret
        asm volatile ("cld; rep stosb\n"
40000fd0:	31 c0                	xor    %eax,%eax
40000fd2:	fc                   	cld
40000fd3:	f3 aa                	rep stos %al,%es:(%edi)
}
40000fd5:	89 f8                	mov    %edi,%eax
40000fd7:	5f                   	pop    %edi
40000fd8:	c3                   	ret
40000fd9:	66 90                	xchg   %ax,%ax
40000fdb:	66 90                	xchg   %ax,%ax
40000fdd:	66 90                	xchg   %ax,%ax
40000fdf:	90                   	nop

40000fe0 <__udivdi3>:
40000fe0:	f3 0f 1e fb          	endbr32
40000fe4:	55                   	push   %ebp
40000fe5:	89 e5                	mov    %esp,%ebp
40000fe7:	57                   	push   %edi
40000fe8:	56                   	push   %esi
40000fe9:	53                   	push   %ebx
40000fea:	83 ec 1c             	sub    $0x1c,%esp
40000fed:	8b 7d 08             	mov    0x8(%ebp),%edi
40000ff0:	8b 45 14             	mov    0x14(%ebp),%eax
40000ff3:	8b 75 0c             	mov    0xc(%ebp),%esi
40000ff6:	8b 5d 10             	mov    0x10(%ebp),%ebx
40000ff9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
40000ffc:	85 c0                	test   %eax,%eax
40000ffe:	75 20                	jne    40001020 <__udivdi3+0x40>
40001000:	39 de                	cmp    %ebx,%esi
40001002:	73 54                	jae    40001058 <__udivdi3+0x78>
40001004:	89 f8                	mov    %edi,%eax
40001006:	31 ff                	xor    %edi,%edi
40001008:	89 f2                	mov    %esi,%edx
4000100a:	f7 f3                	div    %ebx
4000100c:	89 fa                	mov    %edi,%edx
4000100e:	83 c4 1c             	add    $0x1c,%esp
40001011:	5b                   	pop    %ebx
40001012:	5e                   	pop    %esi
40001013:	5f                   	pop    %edi
40001014:	5d                   	pop    %ebp
40001015:	c3                   	ret
40001016:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000101d:	00 
4000101e:	66 90                	xchg   %ax,%ax
40001020:	39 c6                	cmp    %eax,%esi
40001022:	73 14                	jae    40001038 <__udivdi3+0x58>
40001024:	31 ff                	xor    %edi,%edi
40001026:	31 c0                	xor    %eax,%eax
40001028:	89 fa                	mov    %edi,%edx
4000102a:	83 c4 1c             	add    $0x1c,%esp
4000102d:	5b                   	pop    %ebx
4000102e:	5e                   	pop    %esi
4000102f:	5f                   	pop    %edi
40001030:	5d                   	pop    %ebp
40001031:	c3                   	ret
40001032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001038:	0f bd f8             	bsr    %eax,%edi
4000103b:	83 f7 1f             	xor    $0x1f,%edi
4000103e:	75 48                	jne    40001088 <__udivdi3+0xa8>
40001040:	39 f0                	cmp    %esi,%eax
40001042:	72 07                	jb     4000104b <__udivdi3+0x6b>
40001044:	31 c0                	xor    %eax,%eax
40001046:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
40001049:	72 dd                	jb     40001028 <__udivdi3+0x48>
4000104b:	b8 01 00 00 00       	mov    $0x1,%eax
40001050:	eb d6                	jmp    40001028 <__udivdi3+0x48>
40001052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001058:	89 d9                	mov    %ebx,%ecx
4000105a:	85 db                	test   %ebx,%ebx
4000105c:	75 0b                	jne    40001069 <__udivdi3+0x89>
4000105e:	b8 01 00 00 00       	mov    $0x1,%eax
40001063:	31 d2                	xor    %edx,%edx
40001065:	f7 f3                	div    %ebx
40001067:	89 c1                	mov    %eax,%ecx
40001069:	31 d2                	xor    %edx,%edx
4000106b:	89 f0                	mov    %esi,%eax
4000106d:	f7 f1                	div    %ecx
4000106f:	89 c6                	mov    %eax,%esi
40001071:	8b 45 e4             	mov    -0x1c(%ebp),%eax
40001074:	89 f7                	mov    %esi,%edi
40001076:	f7 f1                	div    %ecx
40001078:	89 fa                	mov    %edi,%edx
4000107a:	83 c4 1c             	add    $0x1c,%esp
4000107d:	5b                   	pop    %ebx
4000107e:	5e                   	pop    %esi
4000107f:	5f                   	pop    %edi
40001080:	5d                   	pop    %ebp
40001081:	c3                   	ret
40001082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
40001088:	89 f9                	mov    %edi,%ecx
4000108a:	ba 20 00 00 00       	mov    $0x20,%edx
4000108f:	29 fa                	sub    %edi,%edx
40001091:	d3 e0                	shl    %cl,%eax
40001093:	89 45 e0             	mov    %eax,-0x20(%ebp)
40001096:	89 d1                	mov    %edx,%ecx
40001098:	89 d8                	mov    %ebx,%eax
4000109a:	d3 e8                	shr    %cl,%eax
4000109c:	89 c1                	mov    %eax,%ecx
4000109e:	8b 45 e0             	mov    -0x20(%ebp),%eax
400010a1:	09 c1                	or     %eax,%ecx
400010a3:	89 f0                	mov    %esi,%eax
400010a5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
400010a8:	89 f9                	mov    %edi,%ecx
400010aa:	d3 e3                	shl    %cl,%ebx
400010ac:	89 d1                	mov    %edx,%ecx
400010ae:	d3 e8                	shr    %cl,%eax
400010b0:	89 5d dc             	mov    %ebx,-0x24(%ebp)
400010b3:	89 f9                	mov    %edi,%ecx
400010b5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
400010b8:	d3 e6                	shl    %cl,%esi
400010ba:	89 d1                	mov    %edx,%ecx
400010bc:	d3 eb                	shr    %cl,%ebx
400010be:	09 f3                	or     %esi,%ebx
400010c0:	89 c6                	mov    %eax,%esi
400010c2:	89 f2                	mov    %esi,%edx
400010c4:	89 d8                	mov    %ebx,%eax
400010c6:	f7 75 e0             	divl   -0x20(%ebp)
400010c9:	89 d6                	mov    %edx,%esi
400010cb:	89 c3                	mov    %eax,%ebx
400010cd:	f7 65 dc             	mull   -0x24(%ebp)
400010d0:	89 55 e0             	mov    %edx,-0x20(%ebp)
400010d3:	39 d6                	cmp    %edx,%esi
400010d5:	72 21                	jb     400010f8 <__udivdi3+0x118>
400010d7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
400010da:	89 f9                	mov    %edi,%ecx
400010dc:	d3 e2                	shl    %cl,%edx
400010de:	39 c2                	cmp    %eax,%edx
400010e0:	73 07                	jae    400010e9 <__udivdi3+0x109>
400010e2:	8b 55 e0             	mov    -0x20(%ebp),%edx
400010e5:	39 d6                	cmp    %edx,%esi
400010e7:	74 0f                	je     400010f8 <__udivdi3+0x118>
400010e9:	89 d8                	mov    %ebx,%eax
400010eb:	31 ff                	xor    %edi,%edi
400010ed:	e9 36 ff ff ff       	jmp    40001028 <__udivdi3+0x48>
400010f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
400010f8:	8d 43 ff             	lea    -0x1(%ebx),%eax
400010fb:	31 ff                	xor    %edi,%edi
400010fd:	e9 26 ff ff ff       	jmp    40001028 <__udivdi3+0x48>
40001102:	66 90                	xchg   %ax,%ax
40001104:	66 90                	xchg   %ax,%ax
40001106:	66 90                	xchg   %ax,%ax
40001108:	66 90                	xchg   %ax,%ax
4000110a:	66 90                	xchg   %ax,%ax
4000110c:	66 90                	xchg   %ax,%ax
4000110e:	66 90                	xchg   %ax,%ax

40001110 <__umoddi3>:
40001110:	f3 0f 1e fb          	endbr32
40001114:	55                   	push   %ebp
40001115:	89 e5                	mov    %esp,%ebp
40001117:	57                   	push   %edi
40001118:	56                   	push   %esi
40001119:	53                   	push   %ebx
4000111a:	83 ec 2c             	sub    $0x2c,%esp
4000111d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
40001120:	8b 45 14             	mov    0x14(%ebp),%eax
40001123:	8b 75 08             	mov    0x8(%ebp),%esi
40001126:	8b 7d 10             	mov    0x10(%ebp),%edi
40001129:	89 da                	mov    %ebx,%edx
4000112b:	85 c0                	test   %eax,%eax
4000112d:	75 19                	jne    40001148 <__umoddi3+0x38>
4000112f:	39 fb                	cmp    %edi,%ebx
40001131:	73 5d                	jae    40001190 <__umoddi3+0x80>
40001133:	89 f0                	mov    %esi,%eax
40001135:	f7 f7                	div    %edi
40001137:	89 d0                	mov    %edx,%eax
40001139:	31 d2                	xor    %edx,%edx
4000113b:	83 c4 2c             	add    $0x2c,%esp
4000113e:	5b                   	pop    %ebx
4000113f:	5e                   	pop    %esi
40001140:	5f                   	pop    %edi
40001141:	5d                   	pop    %ebp
40001142:	c3                   	ret
40001143:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40001148:	89 75 e0             	mov    %esi,-0x20(%ebp)
4000114b:	39 c3                	cmp    %eax,%ebx
4000114d:	73 11                	jae    40001160 <__umoddi3+0x50>
4000114f:	89 f0                	mov    %esi,%eax
40001151:	83 c4 2c             	add    $0x2c,%esp
40001154:	5b                   	pop    %ebx
40001155:	5e                   	pop    %esi
40001156:	5f                   	pop    %edi
40001157:	5d                   	pop    %ebp
40001158:	c3                   	ret
40001159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
40001160:	0f bd c8             	bsr    %eax,%ecx
40001163:	83 f1 1f             	xor    $0x1f,%ecx
40001166:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
40001169:	75 45                	jne    400011b0 <__umoddi3+0xa0>
4000116b:	39 d8                	cmp    %ebx,%eax
4000116d:	0f 82 d5 00 00 00    	jb     40001248 <__umoddi3+0x138>
40001173:	39 fe                	cmp    %edi,%esi
40001175:	0f 83 cd 00 00 00    	jae    40001248 <__umoddi3+0x138>
4000117b:	8b 45 e0             	mov    -0x20(%ebp),%eax
4000117e:	83 c4 2c             	add    $0x2c,%esp
40001181:	5b                   	pop    %ebx
40001182:	5e                   	pop    %esi
40001183:	5f                   	pop    %edi
40001184:	5d                   	pop    %ebp
40001185:	c3                   	ret
40001186:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
4000118d:	00 
4000118e:	66 90                	xchg   %ax,%ax
40001190:	89 f9                	mov    %edi,%ecx
40001192:	85 ff                	test   %edi,%edi
40001194:	75 0b                	jne    400011a1 <__umoddi3+0x91>
40001196:	b8 01 00 00 00       	mov    $0x1,%eax
4000119b:	31 d2                	xor    %edx,%edx
4000119d:	f7 f7                	div    %edi
4000119f:	89 c1                	mov    %eax,%ecx
400011a1:	89 d8                	mov    %ebx,%eax
400011a3:	31 d2                	xor    %edx,%edx
400011a5:	f7 f1                	div    %ecx
400011a7:	89 f0                	mov    %esi,%eax
400011a9:	f7 f1                	div    %ecx
400011ab:	eb 8a                	jmp    40001137 <__umoddi3+0x27>
400011ad:	8d 76 00             	lea    0x0(%esi),%esi
400011b0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
400011b3:	ba 20 00 00 00       	mov    $0x20,%edx
400011b8:	29 ca                	sub    %ecx,%edx
400011ba:	d3 e0                	shl    %cl,%eax
400011bc:	89 45 dc             	mov    %eax,-0x24(%ebp)
400011bf:	89 d1                	mov    %edx,%ecx
400011c1:	89 f8                	mov    %edi,%eax
400011c3:	d3 e8                	shr    %cl,%eax
400011c5:	89 55 e0             	mov    %edx,-0x20(%ebp)
400011c8:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011cc:	89 c2                	mov    %eax,%edx
400011ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
400011d1:	d3 e7                	shl    %cl,%edi
400011d3:	09 c2                	or     %eax,%edx
400011d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
400011d8:	89 7d d8             	mov    %edi,-0x28(%ebp)
400011db:	89 f7                	mov    %esi,%edi
400011dd:	89 55 dc             	mov    %edx,-0x24(%ebp)
400011e0:	89 da                	mov    %ebx,%edx
400011e2:	89 c1                	mov    %eax,%ecx
400011e4:	d3 ea                	shr    %cl,%edx
400011e6:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011ea:	d3 e3                	shl    %cl,%ebx
400011ec:	89 c1                	mov    %eax,%ecx
400011ee:	d3 ef                	shr    %cl,%edi
400011f0:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
400011f4:	89 f8                	mov    %edi,%eax
400011f6:	d3 e6                	shl    %cl,%esi
400011f8:	09 d8                	or     %ebx,%eax
400011fa:	f7 75 dc             	divl   -0x24(%ebp)
400011fd:	89 d3                	mov    %edx,%ebx
400011ff:	89 75 d4             	mov    %esi,-0x2c(%ebp)
40001202:	89 f7                	mov    %esi,%edi
40001204:	f7 65 d8             	mull   -0x28(%ebp)
40001207:	89 c6                	mov    %eax,%esi
40001209:	89 d1                	mov    %edx,%ecx
4000120b:	39 d3                	cmp    %edx,%ebx
4000120d:	72 06                	jb     40001215 <__umoddi3+0x105>
4000120f:	75 0e                	jne    4000121f <__umoddi3+0x10f>
40001211:	39 c7                	cmp    %eax,%edi
40001213:	73 0a                	jae    4000121f <__umoddi3+0x10f>
40001215:	2b 45 d8             	sub    -0x28(%ebp),%eax
40001218:	1b 55 dc             	sbb    -0x24(%ebp),%edx
4000121b:	89 d1                	mov    %edx,%ecx
4000121d:	89 c6                	mov    %eax,%esi
4000121f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
40001222:	8b 7d e4             	mov    -0x1c(%ebp),%edi
40001225:	29 f0                	sub    %esi,%eax
40001227:	19 cb                	sbb    %ecx,%ebx
40001229:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
4000122d:	89 da                	mov    %ebx,%edx
4000122f:	d3 e2                	shl    %cl,%edx
40001231:	89 f9                	mov    %edi,%ecx
40001233:	d3 e8                	shr    %cl,%eax
40001235:	d3 eb                	shr    %cl,%ebx
40001237:	09 d0                	or     %edx,%eax
40001239:	89 da                	mov    %ebx,%edx
4000123b:	83 c4 2c             	add    $0x2c,%esp
4000123e:	5b                   	pop    %ebx
4000123f:	5e                   	pop    %esi
40001240:	5f                   	pop    %edi
40001241:	5d                   	pop    %ebp
40001242:	c3                   	ret
40001243:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
40001248:	89 da                	mov    %ebx,%edx
4000124a:	29 fe                	sub    %edi,%esi
4000124c:	19 c2                	sbb    %eax,%edx
4000124e:	89 75 e0             	mov    %esi,-0x20(%ebp)
40001251:	e9 25 ff ff ff       	jmp    4000117b <__umoddi3+0x6b>
