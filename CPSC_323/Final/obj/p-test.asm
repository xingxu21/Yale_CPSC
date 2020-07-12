
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <fib>:

int fib(int n){
    if(n == 0)
        return 1;
    if(n == 1)
        return 1;
  100000:	b8 01 00 00 00       	mov    $0x1,%eax
    if(n == 1)
  100005:	83 ff 01             	cmp    $0x1,%edi
  100008:	77 01                	ja     10000b <fib+0xb>
    return fib(n-1) + fib(n-2);
}
  10000a:	c3                   	retq   
int fib(int n){
  10000b:	55                   	push   %rbp
  10000c:	48 89 e5             	mov    %rsp,%rbp
  10000f:	41 54                	push   %r12
  100011:	53                   	push   %rbx
  100012:	89 fb                	mov    %edi,%ebx
    return fib(n-1) + fib(n-2);
  100014:	8d 7f ff             	lea    -0x1(%rdi),%edi
  100017:	e8 e4 ff ff ff       	callq  100000 <fib>
  10001c:	41 89 c4             	mov    %eax,%r12d
  10001f:	8d 7b fe             	lea    -0x2(%rbx),%edi
  100022:	e8 d9 ff ff ff       	callq  100000 <fib>
  100027:	44 01 e0             	add    %r12d,%eax
}
  10002a:	5b                   	pop    %rbx
  10002b:	41 5c                	pop    %r12
  10002d:	5d                   	pop    %rbp
  10002e:	c3                   	retq   

000000000010002f <isnum>:

int isnum(char c){
    return c >= '0' && c <= '9';
  10002f:	83 ef 30             	sub    $0x30,%edi
  100032:	40 80 ff 09          	cmp    $0x9,%dil
  100036:	0f 96 c0             	setbe  %al
  100039:	0f b6 c0             	movzbl %al,%eax
}
  10003c:	c3                   	retq   

000000000010003d <isspace>:

int isspace(char c){
    return c == ' ' || c == '\n' || c == '\t' || c == '\f' || c == '\v' || c == '\r';
  10003d:	b8 01 00 00 00       	mov    $0x1,%eax
  100042:	40 80 ff 20          	cmp    $0x20,%dil
  100046:	74 0d                	je     100055 <isspace+0x18>
  100048:	83 ef 09             	sub    $0x9,%edi
  10004b:	40 80 ff 04          	cmp    $0x4,%dil
  10004f:	0f 96 c0             	setbe  %al
  100052:	0f b6 c0             	movzbl %al,%eax
}
  100055:	c3                   	retq   

0000000000100056 <process_main>:

void process_main(void) {
  100056:	55                   	push   %rbp
  100057:	48 89 e5             	mov    %rsp,%rbp
  10005a:	41 57                	push   %r15
  10005c:	41 56                	push   %r14
  10005e:	41 55                	push   %r13
  100060:	41 54                	push   %r12
  100062:	53                   	push   %rbx
  100063:	48 83 ec 38          	sub    $0x38,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100067:	cd 31                	int    $0x31

// sys_mem_tog
// toggles kernels printing of memory space for process if pid is its processID
// if pid == 0, toggles state globally (preference to global over local)
static inline void sys_mem_tog(pid_t p) {
    asm volatile ("int %0" : /* no result */
  100069:	bf 00 00 00 00       	mov    $0x0,%edi
  10006e:	cd 38                	int    $0x38
    pid_t p = sys_getpid();
    //clear console and toggle memory function off
    sys_mem_tog(0);
    console_clear();
  100070:	e8 47 0b 00 00       	callq  100bbc <console_clear>
    // lets write a simple function
    // get input from serial
    char input[33] = {0};
  100075:	48 c7 45 af 00 00 00 	movq   $0x0,-0x51(%rbp)
  10007c:	00 
  10007d:	48 c7 45 b7 00 00 00 	movq   $0x0,-0x49(%rbp)
  100084:	00 
  100085:	48 c7 45 bf 00 00 00 	movq   $0x0,-0x41(%rbp)
  10008c:	00 
  10008d:	48 c7 45 c7 00 00 00 	movq   $0x0,-0x39(%rbp)
  100094:	00 
  100095:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
    read_line(input, 32);
  100099:	be 20 00 00 00       	mov    $0x20,%esi
  10009e:	48 8d 7d af          	lea    -0x51(%rbp),%rdi
  1000a2:	e8 e1 0b 00 00       	callq  100c88 <read_line>
    app_printf(0, "input: %s\n", input);
  1000a7:	48 8d 55 af          	lea    -0x51(%rbp),%rdx
  1000ab:	be f0 0e 10 00       	mov    $0x100ef0,%esi
  1000b0:	bf 00 00 00 00       	mov    $0x0,%edi
  1000b5:	b8 00 00 00 00       	mov    $0x0,%eax
  1000ba:	e8 3a 0b 00 00       	callq  100bf9 <app_printf>
    int mode = 0;
    int num = 0;

    for(uint64_t i = 0; i < sizeof(input) ; i++){
  1000bf:	4c 8d 65 af          	lea    -0x51(%rbp),%r12
  1000c3:	4c 8d 7d d0          	lea    -0x30(%rbp),%r15
    int num = 0;
  1000c7:	bb 00 00 00 00       	mov    $0x0,%ebx
    int mode = 0;
  1000cc:	41 be 00 00 00 00    	mov    $0x0,%r14d
        if(mode == 0 && isspace(input[i]))
            continue;
        mode = 1;
  1000d2:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  1000d8:	eb 22                	jmp    1000fc <process_main+0xa6>
        if(mode == 1 && !isnum(input[i]))
  1000da:	41 0f b6 04 24       	movzbl (%r12),%eax
  1000df:	0f be d0             	movsbl %al,%edx
    return c >= '0' && c <= '9';
  1000e2:	83 e8 30             	sub    $0x30,%eax
        if(mode == 1 && !isnum(input[i]))
  1000e5:	3c 09                	cmp    $0x9,%al
  1000e7:	77 28                	ja     100111 <process_main+0xbb>
            break;
        num = num * 10 + (input[i] - '0');
  1000e9:	8d 04 9b             	lea    (%rbx,%rbx,4),%eax
  1000ec:	8d 5c 42 d0          	lea    -0x30(%rdx,%rax,2),%ebx
        mode = 1;
  1000f0:	45 89 ee             	mov    %r13d,%r14d
    for(uint64_t i = 0; i < sizeof(input) ; i++){
  1000f3:	49 83 c4 01          	add    $0x1,%r12
  1000f7:	4d 39 fc             	cmp    %r15,%r12
  1000fa:	74 15                	je     100111 <process_main+0xbb>
        if(mode == 0 && isspace(input[i]))
  1000fc:	45 85 f6             	test   %r14d,%r14d
  1000ff:	75 d9                	jne    1000da <process_main+0x84>
  100101:	41 0f be 3c 24       	movsbl (%r12),%edi
  100106:	e8 32 ff ff ff       	callq  10003d <isspace>
  10010b:	85 c0                	test   %eax,%eax
  10010d:	74 cb                	je     1000da <process_main+0x84>
  10010f:	eb e2                	jmp    1000f3 <process_main+0x9d>
    }
    if(num == 0)
  100111:	85 db                	test   %ebx,%ebx
  100113:	74 44                	je     100159 <process_main+0x103>
        num = 5;


    app_printf(0, "Start of fib function with %d nums\n", num);
  100115:	89 da                	mov    %ebx,%edx
  100117:	be 18 0f 10 00       	mov    $0x100f18,%esi
  10011c:	bf 00 00 00 00       	mov    $0x0,%edi
  100121:	b8 00 00 00 00       	mov    $0x0,%eax
  100126:	e8 ce 0a 00 00       	callq  100bf9 <app_printf>
    int * str = malloc(sizeof(int) * num);
  10012b:	48 63 fb             	movslq %ebx,%rdi
  10012e:	48 c1 e7 02          	shl    $0x2,%rdi
  100132:	e8 a8 0a 00 00       	callq  100bdf <malloc>
  100137:	49 89 c4             	mov    %rax,%r12
    assert(str != NULL);
  10013a:	48 85 c0             	test   %rax,%rax
  10013d:	74 06                	je     100145 <process_main+0xef>
    for(int i = 0 ; i < num; i++){
  10013f:	85 db                	test   %ebx,%ebx
  100141:	7f 46                	jg     100189 <process_main+0x133>
  100143:	eb 75                	jmp    1001ba <process_main+0x164>
    assert(str != NULL);
  100145:	ba fb 0e 10 00       	mov    $0x100efb,%edx
  10014a:	be 38 00 00 00       	mov    $0x38,%esi
  10014f:	bf 07 0f 10 00       	mov    $0x100f07,%edi
  100154:	e8 59 0d 00 00       	callq  100eb2 <assert_fail>
    app_printf(0, "Start of fib function with %d nums\n", num);
  100159:	ba 05 00 00 00       	mov    $0x5,%edx
  10015e:	be 18 0f 10 00       	mov    $0x100f18,%esi
  100163:	bf 00 00 00 00       	mov    $0x0,%edi
  100168:	b8 00 00 00 00       	mov    $0x0,%eax
  10016d:	e8 87 0a 00 00       	callq  100bf9 <app_printf>
    int * str = malloc(sizeof(int) * num);
  100172:	bf 14 00 00 00       	mov    $0x14,%edi
  100177:	e8 63 0a 00 00       	callq  100bdf <malloc>
  10017c:	49 89 c4             	mov    %rax,%r12
    assert(str != NULL);
  10017f:	48 85 c0             	test   %rax,%rax
  100182:	74 c1                	je     100145 <process_main+0xef>
        num = 5;
  100184:	bb 05 00 00 00       	mov    $0x5,%ebx
  100189:	41 bd 00 00 00 00    	mov    $0x0,%r13d
        str[i] = fib(i);
  10018f:	44 89 ef             	mov    %r13d,%edi
  100192:	e8 69 fe ff ff       	callq  100000 <fib>
  100197:	89 c2                	mov    %eax,%edx
  100199:	43 89 04 ac          	mov    %eax,(%r12,%r13,4)
        app_printf(0, "%d ", str[i]);
  10019d:	be 10 0f 10 00       	mov    $0x100f10,%esi
  1001a2:	bf 00 00 00 00       	mov    $0x0,%edi
  1001a7:	b8 00 00 00 00       	mov    $0x0,%eax
  1001ac:	e8 48 0a 00 00       	callq  100bf9 <app_printf>
    for(int i = 0 ; i < num; i++){
  1001b1:	49 83 c5 01          	add    $0x1,%r13
  1001b5:	44 39 eb             	cmp    %r13d,%ebx
  1001b8:	7f d5                	jg     10018f <process_main+0x139>
    asm volatile ("int %0" : /* no result */
  1001ba:	cd 32                	int    $0x32
  1001bc:	eb fc                	jmp    1001ba <process_main+0x164>

00000000001001be <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1001be:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1001c1:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  1001c8:	00 
  1001c9:	72 08                	jb     1001d3 <console_putc+0x15>
        cp->cursor = console;
  1001cb:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  1001d2:	00 
    }
    if (c == '\n') {
  1001d3:	40 80 fe 0a          	cmp    $0xa,%sil
  1001d7:	74 17                	je     1001f0 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  1001d9:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1001dd:	48 8d 50 02          	lea    0x2(%rax),%rdx
  1001e1:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1001e5:	40 0f b6 f6          	movzbl %sil,%esi
  1001e9:	44 09 c6             	or     %r8d,%esi
  1001ec:	66 89 30             	mov    %si,(%rax)
    }
}
  1001ef:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1001f0:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  1001f4:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  1001fb:	48 89 f1             	mov    %rsi,%rcx
  1001fe:	48 d1 f9             	sar    %rcx
  100201:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100208:	66 66 66 
  10020b:	48 89 c8             	mov    %rcx,%rax
  10020e:	48 f7 ea             	imul   %rdx
  100211:	48 c1 fa 05          	sar    $0x5,%rdx
  100215:	48 c1 fe 3f          	sar    $0x3f,%rsi
  100219:	48 29 f2             	sub    %rsi,%rdx
  10021c:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  100220:	48 c1 e0 04          	shl    $0x4,%rax
  100224:	89 ca                	mov    %ecx,%edx
  100226:	29 c2                	sub    %eax,%edx
  100228:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  10022a:	44 89 c6             	mov    %r8d,%esi
  10022d:	83 ce 20             	or     $0x20,%esi
  100230:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  100234:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  100238:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  10023c:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  10023f:	83 c0 01             	add    $0x1,%eax
  100242:	83 f8 50             	cmp    $0x50,%eax
  100245:	75 e9                	jne    100230 <console_putc+0x72>
  100247:	c3                   	retq   

0000000000100248 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  100248:	48 8b 47 08          	mov    0x8(%rdi),%rax
  10024c:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  100250:	73 0b                	jae    10025d <string_putc+0x15>
        *sp->s++ = c;
  100252:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100256:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  10025a:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  10025d:	c3                   	retq   

000000000010025e <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  10025e:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100261:	48 85 d2             	test   %rdx,%rdx
  100264:	74 17                	je     10027d <memcpy+0x1f>
  100266:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10026b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100270:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100274:	48 83 c1 01          	add    $0x1,%rcx
  100278:	48 39 d1             	cmp    %rdx,%rcx
  10027b:	75 ee                	jne    10026b <memcpy+0xd>
}
  10027d:	c3                   	retq   

000000000010027e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10027e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100281:	48 39 fe             	cmp    %rdi,%rsi
  100284:	72 1d                	jb     1002a3 <memmove+0x25>
        while (n-- > 0) {
  100286:	b9 00 00 00 00       	mov    $0x0,%ecx
  10028b:	48 85 d2             	test   %rdx,%rdx
  10028e:	74 12                	je     1002a2 <memmove+0x24>
            *d++ = *s++;
  100290:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100294:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100298:	48 83 c1 01          	add    $0x1,%rcx
  10029c:	48 39 ca             	cmp    %rcx,%rdx
  10029f:	75 ef                	jne    100290 <memmove+0x12>
}
  1002a1:	c3                   	retq   
  1002a2:	c3                   	retq   
    if (s < d && s + n > d) {
  1002a3:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1002a7:	48 39 cf             	cmp    %rcx,%rdi
  1002aa:	73 da                	jae    100286 <memmove+0x8>
        while (n-- > 0) {
  1002ac:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1002b0:	48 85 d2             	test   %rdx,%rdx
  1002b3:	74 ec                	je     1002a1 <memmove+0x23>
            *--d = *--s;
  1002b5:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1002b9:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1002bc:	48 83 e9 01          	sub    $0x1,%rcx
  1002c0:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1002c4:	75 ef                	jne    1002b5 <memmove+0x37>
  1002c6:	c3                   	retq   

00000000001002c7 <memset>:
void* memset(void* v, int c, size_t n) {
  1002c7:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1002ca:	48 85 d2             	test   %rdx,%rdx
  1002cd:	74 13                	je     1002e2 <memset+0x1b>
  1002cf:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  1002d3:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  1002d6:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1002d9:	48 83 c2 01          	add    $0x1,%rdx
  1002dd:	48 39 d1             	cmp    %rdx,%rcx
  1002e0:	75 f4                	jne    1002d6 <memset+0xf>
}
  1002e2:	c3                   	retq   

00000000001002e3 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  1002e3:	80 3f 00             	cmpb   $0x0,(%rdi)
  1002e6:	74 10                	je     1002f8 <strlen+0x15>
  1002e8:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1002ed:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1002f1:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1002f5:	75 f6                	jne    1002ed <strlen+0xa>
  1002f7:	c3                   	retq   
  1002f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1002fd:	c3                   	retq   

00000000001002fe <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1002fe:	b8 00 00 00 00       	mov    $0x0,%eax
  100303:	48 85 f6             	test   %rsi,%rsi
  100306:	74 10                	je     100318 <strnlen+0x1a>
  100308:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  10030c:	74 09                	je     100317 <strnlen+0x19>
        ++n;
  10030e:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100312:	48 39 c6             	cmp    %rax,%rsi
  100315:	75 f1                	jne    100308 <strnlen+0xa>
}
  100317:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100318:	48 89 f0             	mov    %rsi,%rax
  10031b:	c3                   	retq   

000000000010031c <strcpy>:
char* strcpy(char* dst, const char* src) {
  10031c:	48 89 f8             	mov    %rdi,%rax
  10031f:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  100324:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  100328:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  10032b:	48 83 c2 01          	add    $0x1,%rdx
  10032f:	84 c9                	test   %cl,%cl
  100331:	75 f1                	jne    100324 <strcpy+0x8>
}
  100333:	c3                   	retq   

0000000000100334 <strcmp>:
    while (*a && *b && *a == *b) {
  100334:	0f b6 17             	movzbl (%rdi),%edx
  100337:	84 d2                	test   %dl,%dl
  100339:	74 1a                	je     100355 <strcmp+0x21>
  10033b:	0f b6 06             	movzbl (%rsi),%eax
  10033e:	38 d0                	cmp    %dl,%al
  100340:	75 13                	jne    100355 <strcmp+0x21>
  100342:	84 c0                	test   %al,%al
  100344:	74 0f                	je     100355 <strcmp+0x21>
        ++a, ++b;
  100346:	48 83 c7 01          	add    $0x1,%rdi
  10034a:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  10034e:	0f b6 17             	movzbl (%rdi),%edx
  100351:	84 d2                	test   %dl,%dl
  100353:	75 e6                	jne    10033b <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100355:	0f b6 0e             	movzbl (%rsi),%ecx
  100358:	38 ca                	cmp    %cl,%dl
  10035a:	0f 97 c0             	seta   %al
  10035d:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100360:	83 d8 00             	sbb    $0x0,%eax
}
  100363:	c3                   	retq   

0000000000100364 <strchr>:
    while (*s && *s != (char) c) {
  100364:	0f b6 07             	movzbl (%rdi),%eax
  100367:	84 c0                	test   %al,%al
  100369:	74 10                	je     10037b <strchr+0x17>
  10036b:	40 38 f0             	cmp    %sil,%al
  10036e:	74 18                	je     100388 <strchr+0x24>
        ++s;
  100370:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100374:	0f b6 07             	movzbl (%rdi),%eax
  100377:	84 c0                	test   %al,%al
  100379:	75 f0                	jne    10036b <strchr+0x7>
        return NULL;
  10037b:	40 84 f6             	test   %sil,%sil
  10037e:	b8 00 00 00 00       	mov    $0x0,%eax
  100383:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100387:	c3                   	retq   
  100388:	48 89 f8             	mov    %rdi,%rax
  10038b:	c3                   	retq   

000000000010038c <rand>:
    if (!rand_seed_set) {
  10038c:	83 3d 71 1c 00 00 00 	cmpl   $0x0,0x1c71(%rip)        # 102004 <rand_seed_set>
  100393:	74 1b                	je     1003b0 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100395:	69 05 61 1c 00 00 0d 	imul   $0x19660d,0x1c61(%rip),%eax        # 102000 <rand_seed>
  10039c:	66 19 00 
  10039f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1003a4:	89 05 56 1c 00 00    	mov    %eax,0x1c56(%rip)        # 102000 <rand_seed>
    return rand_seed & RAND_MAX;
  1003aa:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1003af:	c3                   	retq   
    rand_seed = seed;
  1003b0:	c7 05 46 1c 00 00 9e 	movl   $0x30d4879e,0x1c46(%rip)        # 102000 <rand_seed>
  1003b7:	87 d4 30 
    rand_seed_set = 1;
  1003ba:	c7 05 40 1c 00 00 01 	movl   $0x1,0x1c40(%rip)        # 102004 <rand_seed_set>
  1003c1:	00 00 00 
}
  1003c4:	eb cf                	jmp    100395 <rand+0x9>

00000000001003c6 <srand>:
    rand_seed = seed;
  1003c6:	89 3d 34 1c 00 00    	mov    %edi,0x1c34(%rip)        # 102000 <rand_seed>
    rand_seed_set = 1;
  1003cc:	c7 05 2e 1c 00 00 01 	movl   $0x1,0x1c2e(%rip)        # 102004 <rand_seed_set>
  1003d3:	00 00 00 
}
  1003d6:	c3                   	retq   

00000000001003d7 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1003d7:	55                   	push   %rbp
  1003d8:	48 89 e5             	mov    %rsp,%rbp
  1003db:	41 57                	push   %r15
  1003dd:	41 56                	push   %r14
  1003df:	41 55                	push   %r13
  1003e1:	41 54                	push   %r12
  1003e3:	53                   	push   %rbx
  1003e4:	48 83 ec 58          	sub    $0x58,%rsp
  1003e8:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1003ec:	0f b6 02             	movzbl (%rdx),%eax
  1003ef:	84 c0                	test   %al,%al
  1003f1:	0f 84 ba 06 00 00    	je     100ab1 <printer_vprintf+0x6da>
  1003f7:	49 89 fe             	mov    %rdi,%r14
  1003fa:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1003fd:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  100404:	41 89 f7             	mov    %esi,%r15d
  100407:	e9 a5 04 00 00       	jmpq   1008b1 <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  10040c:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  100411:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100417:	45 84 e4             	test   %r12b,%r12b
  10041a:	0f 84 85 06 00 00    	je     100aa5 <printer_vprintf+0x6ce>
        int flags = 0;
  100420:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  100426:	41 0f be f4          	movsbl %r12b,%esi
  10042a:	bf 41 11 10 00       	mov    $0x101141,%edi
  10042f:	e8 30 ff ff ff       	callq  100364 <strchr>
  100434:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  100437:	48 85 c0             	test   %rax,%rax
  10043a:	74 55                	je     100491 <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  10043c:	48 81 e9 41 11 10 00 	sub    $0x101141,%rcx
  100443:	b8 01 00 00 00       	mov    $0x1,%eax
  100448:	d3 e0                	shl    %cl,%eax
  10044a:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  10044d:	48 83 c3 01          	add    $0x1,%rbx
  100451:	44 0f b6 23          	movzbl (%rbx),%r12d
  100455:	45 84 e4             	test   %r12b,%r12b
  100458:	75 cc                	jne    100426 <printer_vprintf+0x4f>
  10045a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  10045e:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  100464:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  10046b:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  10046e:	0f 84 a9 00 00 00    	je     10051d <printer_vprintf+0x146>
        int length = 0;
  100474:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100479:	0f b6 13             	movzbl (%rbx),%edx
  10047c:	8d 42 bd             	lea    -0x43(%rdx),%eax
  10047f:	3c 37                	cmp    $0x37,%al
  100481:	0f 87 c5 04 00 00    	ja     10094c <printer_vprintf+0x575>
  100487:	0f b6 c0             	movzbl %al,%eax
  10048a:	ff 24 c5 50 0f 10 00 	jmpq   *0x100f50(,%rax,8)
  100491:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  100495:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  10049a:	3c 08                	cmp    $0x8,%al
  10049c:	77 2f                	ja     1004cd <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10049e:	0f b6 03             	movzbl (%rbx),%eax
  1004a1:	8d 50 d0             	lea    -0x30(%rax),%edx
  1004a4:	80 fa 09             	cmp    $0x9,%dl
  1004a7:	77 5e                	ja     100507 <printer_vprintf+0x130>
  1004a9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1004af:	48 83 c3 01          	add    $0x1,%rbx
  1004b3:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1004b8:	0f be c0             	movsbl %al,%eax
  1004bb:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1004c0:	0f b6 03             	movzbl (%rbx),%eax
  1004c3:	8d 50 d0             	lea    -0x30(%rax),%edx
  1004c6:	80 fa 09             	cmp    $0x9,%dl
  1004c9:	76 e4                	jbe    1004af <printer_vprintf+0xd8>
  1004cb:	eb 97                	jmp    100464 <printer_vprintf+0x8d>
        } else if (*format == '*') {
  1004cd:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1004d1:	75 3f                	jne    100512 <printer_vprintf+0x13b>
            width = va_arg(val, int);
  1004d3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004d7:	8b 01                	mov    (%rcx),%eax
  1004d9:	83 f8 2f             	cmp    $0x2f,%eax
  1004dc:	77 17                	ja     1004f5 <printer_vprintf+0x11e>
  1004de:	89 c2                	mov    %eax,%edx
  1004e0:	48 03 51 10          	add    0x10(%rcx),%rdx
  1004e4:	83 c0 08             	add    $0x8,%eax
  1004e7:	89 01                	mov    %eax,(%rcx)
  1004e9:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1004ec:	48 83 c3 01          	add    $0x1,%rbx
  1004f0:	e9 6f ff ff ff       	jmpq   100464 <printer_vprintf+0x8d>
            width = va_arg(val, int);
  1004f5:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004f9:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004fd:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100501:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100505:	eb e2                	jmp    1004e9 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100507:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  10050d:	e9 52 ff ff ff       	jmpq   100464 <printer_vprintf+0x8d>
        int width = -1;
  100512:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100518:	e9 47 ff ff ff       	jmpq   100464 <printer_vprintf+0x8d>
            ++format;
  10051d:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  100521:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100525:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100528:	80 f9 09             	cmp    $0x9,%cl
  10052b:	76 13                	jbe    100540 <printer_vprintf+0x169>
            } else if (*format == '*') {
  10052d:	3c 2a                	cmp    $0x2a,%al
  10052f:	74 32                	je     100563 <printer_vprintf+0x18c>
            ++format;
  100531:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  100534:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  10053b:	e9 34 ff ff ff       	jmpq   100474 <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100540:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  100545:	48 83 c2 01          	add    $0x1,%rdx
  100549:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  10054c:	0f be c0             	movsbl %al,%eax
  10054f:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100553:	0f b6 02             	movzbl (%rdx),%eax
  100556:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100559:	80 f9 09             	cmp    $0x9,%cl
  10055c:	76 e7                	jbe    100545 <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  10055e:	48 89 d3             	mov    %rdx,%rbx
  100561:	eb 1c                	jmp    10057f <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  100563:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100567:	8b 07                	mov    (%rdi),%eax
  100569:	83 f8 2f             	cmp    $0x2f,%eax
  10056c:	77 23                	ja     100591 <printer_vprintf+0x1ba>
  10056e:	89 c2                	mov    %eax,%edx
  100570:	48 03 57 10          	add    0x10(%rdi),%rdx
  100574:	83 c0 08             	add    $0x8,%eax
  100577:	89 07                	mov    %eax,(%rdi)
  100579:	8b 32                	mov    (%rdx),%esi
                ++format;
  10057b:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  10057f:	85 f6                	test   %esi,%esi
  100581:	b8 00 00 00 00       	mov    $0x0,%eax
  100586:	0f 48 f0             	cmovs  %eax,%esi
  100589:	89 75 9c             	mov    %esi,-0x64(%rbp)
  10058c:	e9 e3 fe ff ff       	jmpq   100474 <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  100591:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100595:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100599:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10059d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005a1:	eb d6                	jmp    100579 <printer_vprintf+0x1a2>
        switch (*format) {
  1005a3:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005a8:	e9 f1 00 00 00       	jmpq   10069e <printer_vprintf+0x2c7>
            ++format;
  1005ad:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1005b1:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  1005b4:	e9 c0 fe ff ff       	jmpq   100479 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1005b9:	85 c9                	test   %ecx,%ecx
  1005bb:	74 55                	je     100612 <printer_vprintf+0x23b>
  1005bd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c1:	8b 01                	mov    (%rcx),%eax
  1005c3:	83 f8 2f             	cmp    $0x2f,%eax
  1005c6:	77 38                	ja     100600 <printer_vprintf+0x229>
  1005c8:	89 c2                	mov    %eax,%edx
  1005ca:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005ce:	83 c0 08             	add    $0x8,%eax
  1005d1:	89 01                	mov    %eax,(%rcx)
  1005d3:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1005d6:	48 89 d0             	mov    %rdx,%rax
  1005d9:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  1005dd:	49 89 d0             	mov    %rdx,%r8
  1005e0:	49 f7 d8             	neg    %r8
  1005e3:	25 80 00 00 00       	and    $0x80,%eax
  1005e8:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1005ec:	0b 45 a8             	or     -0x58(%rbp),%eax
  1005ef:	83 c8 60             	or     $0x60,%eax
  1005f2:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1005f5:	41 bc fa 0e 10 00    	mov    $0x100efa,%r12d
            break;
  1005fb:	e9 35 01 00 00       	jmpq   100735 <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100600:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100604:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100608:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10060c:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100610:	eb c1                	jmp    1005d3 <printer_vprintf+0x1fc>
  100612:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100616:	8b 07                	mov    (%rdi),%eax
  100618:	83 f8 2f             	cmp    $0x2f,%eax
  10061b:	77 10                	ja     10062d <printer_vprintf+0x256>
  10061d:	89 c2                	mov    %eax,%edx
  10061f:	48 03 57 10          	add    0x10(%rdi),%rdx
  100623:	83 c0 08             	add    $0x8,%eax
  100626:	89 07                	mov    %eax,(%rdi)
  100628:	48 63 12             	movslq (%rdx),%rdx
  10062b:	eb a9                	jmp    1005d6 <printer_vprintf+0x1ff>
  10062d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100631:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100635:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100639:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10063d:	eb e9                	jmp    100628 <printer_vprintf+0x251>
        int base = 10;
  10063f:	be 0a 00 00 00       	mov    $0xa,%esi
  100644:	eb 58                	jmp    10069e <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100646:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10064a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10064e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100652:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100656:	eb 60                	jmp    1006b8 <printer_vprintf+0x2e1>
  100658:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10065c:	8b 01                	mov    (%rcx),%eax
  10065e:	83 f8 2f             	cmp    $0x2f,%eax
  100661:	77 10                	ja     100673 <printer_vprintf+0x29c>
  100663:	89 c2                	mov    %eax,%edx
  100665:	48 03 51 10          	add    0x10(%rcx),%rdx
  100669:	83 c0 08             	add    $0x8,%eax
  10066c:	89 01                	mov    %eax,(%rcx)
  10066e:	44 8b 02             	mov    (%rdx),%r8d
  100671:	eb 48                	jmp    1006bb <printer_vprintf+0x2e4>
  100673:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100677:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10067b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10067f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100683:	eb e9                	jmp    10066e <printer_vprintf+0x297>
  100685:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100688:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10068f:	bf 30 11 10 00       	mov    $0x101130,%edi
  100694:	e9 e6 02 00 00       	jmpq   10097f <printer_vprintf+0x5a8>
            base = 16;
  100699:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10069e:	85 c9                	test   %ecx,%ecx
  1006a0:	74 b6                	je     100658 <printer_vprintf+0x281>
  1006a2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1006a6:	8b 07                	mov    (%rdi),%eax
  1006a8:	83 f8 2f             	cmp    $0x2f,%eax
  1006ab:	77 99                	ja     100646 <printer_vprintf+0x26f>
  1006ad:	89 c2                	mov    %eax,%edx
  1006af:	48 03 57 10          	add    0x10(%rdi),%rdx
  1006b3:	83 c0 08             	add    $0x8,%eax
  1006b6:	89 07                	mov    %eax,(%rdi)
  1006b8:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1006bb:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1006bf:	85 f6                	test   %esi,%esi
  1006c1:	79 c2                	jns    100685 <printer_vprintf+0x2ae>
        base = -base;
  1006c3:	41 89 f1             	mov    %esi,%r9d
  1006c6:	f7 de                	neg    %esi
  1006c8:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1006cf:	bf 10 11 10 00       	mov    $0x101110,%edi
  1006d4:	e9 a6 02 00 00       	jmpq   10097f <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  1006d9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1006dd:	8b 07                	mov    (%rdi),%eax
  1006df:	83 f8 2f             	cmp    $0x2f,%eax
  1006e2:	77 1c                	ja     100700 <printer_vprintf+0x329>
  1006e4:	89 c2                	mov    %eax,%edx
  1006e6:	48 03 57 10          	add    0x10(%rdi),%rdx
  1006ea:	83 c0 08             	add    $0x8,%eax
  1006ed:	89 07                	mov    %eax,(%rdi)
  1006ef:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1006f2:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1006f9:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1006fe:	eb c3                	jmp    1006c3 <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  100700:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100704:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100708:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10070c:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100710:	eb dd                	jmp    1006ef <printer_vprintf+0x318>
            data = va_arg(val, char*);
  100712:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100716:	8b 01                	mov    (%rcx),%eax
  100718:	83 f8 2f             	cmp    $0x2f,%eax
  10071b:	0f 87 a9 01 00 00    	ja     1008ca <printer_vprintf+0x4f3>
  100721:	89 c2                	mov    %eax,%edx
  100723:	48 03 51 10          	add    0x10(%rcx),%rdx
  100727:	83 c0 08             	add    $0x8,%eax
  10072a:	89 01                	mov    %eax,(%rcx)
  10072c:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  10072f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  100735:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100738:	83 e0 20             	and    $0x20,%eax
  10073b:	89 45 8c             	mov    %eax,-0x74(%rbp)
  10073e:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  100744:	0f 85 25 02 00 00    	jne    10096f <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10074a:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10074d:	89 45 88             	mov    %eax,-0x78(%rbp)
  100750:	83 e0 60             	and    $0x60,%eax
  100753:	83 f8 60             	cmp    $0x60,%eax
  100756:	0f 84 58 02 00 00    	je     1009b4 <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10075c:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10075f:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  100762:	48 c7 45 a0 fa 0e 10 	movq   $0x100efa,-0x60(%rbp)
  100769:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10076a:	83 f8 21             	cmp    $0x21,%eax
  10076d:	0f 84 7d 02 00 00    	je     1009f0 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  100773:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  100776:	89 c8                	mov    %ecx,%eax
  100778:	f7 d0                	not    %eax
  10077a:	c1 e8 1f             	shr    $0x1f,%eax
  10077d:	89 45 84             	mov    %eax,-0x7c(%rbp)
  100780:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100784:	0f 85 a2 02 00 00    	jne    100a2c <printer_vprintf+0x655>
  10078a:	84 c0                	test   %al,%al
  10078c:	0f 84 9a 02 00 00    	je     100a2c <printer_vprintf+0x655>
            len = strnlen(data, precision);
  100792:	48 63 f1             	movslq %ecx,%rsi
  100795:	4c 89 e7             	mov    %r12,%rdi
  100798:	e8 61 fb ff ff       	callq  1002fe <strnlen>
  10079d:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1007a0:	8b 45 88             	mov    -0x78(%rbp),%eax
  1007a3:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1007a6:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1007ad:	83 f8 22             	cmp    $0x22,%eax
  1007b0:	0f 84 ae 02 00 00    	je     100a64 <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  1007b6:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1007ba:	e8 24 fb ff ff       	callq  1002e3 <strlen>
  1007bf:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1007c2:	03 55 98             	add    -0x68(%rbp),%edx
  1007c5:	41 29 d5             	sub    %edx,%r13d
  1007c8:	44 89 ea             	mov    %r13d,%edx
  1007cb:	29 c2                	sub    %eax,%edx
  1007cd:	89 55 8c             	mov    %edx,-0x74(%rbp)
  1007d0:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1007d3:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  1007d7:	75 2d                	jne    100806 <printer_vprintf+0x42f>
  1007d9:	85 d2                	test   %edx,%edx
  1007db:	7e 29                	jle    100806 <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  1007dd:	44 89 fa             	mov    %r15d,%edx
  1007e0:	be 20 00 00 00       	mov    $0x20,%esi
  1007e5:	4c 89 f7             	mov    %r14,%rdi
  1007e8:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1007eb:	41 83 ed 01          	sub    $0x1,%r13d
  1007ef:	45 85 ed             	test   %r13d,%r13d
  1007f2:	7f e9                	jg     1007dd <printer_vprintf+0x406>
  1007f4:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1007f7:	85 ff                	test   %edi,%edi
  1007f9:	b8 01 00 00 00       	mov    $0x1,%eax
  1007fe:	0f 4f c7             	cmovg  %edi,%eax
  100801:	29 c7                	sub    %eax,%edi
  100803:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100806:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  10080a:	0f b6 01             	movzbl (%rcx),%eax
  10080d:	84 c0                	test   %al,%al
  10080f:	74 22                	je     100833 <printer_vprintf+0x45c>
  100811:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100815:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  100818:	0f b6 f0             	movzbl %al,%esi
  10081b:	44 89 fa             	mov    %r15d,%edx
  10081e:	4c 89 f7             	mov    %r14,%rdi
  100821:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  100824:	48 83 c3 01          	add    $0x1,%rbx
  100828:	0f b6 03             	movzbl (%rbx),%eax
  10082b:	84 c0                	test   %al,%al
  10082d:	75 e9                	jne    100818 <printer_vprintf+0x441>
  10082f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  100833:	8b 45 9c             	mov    -0x64(%rbp),%eax
  100836:	85 c0                	test   %eax,%eax
  100838:	7e 1d                	jle    100857 <printer_vprintf+0x480>
  10083a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10083e:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  100840:	44 89 fa             	mov    %r15d,%edx
  100843:	be 30 00 00 00       	mov    $0x30,%esi
  100848:	4c 89 f7             	mov    %r14,%rdi
  10084b:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  10084e:	83 eb 01             	sub    $0x1,%ebx
  100851:	75 ed                	jne    100840 <printer_vprintf+0x469>
  100853:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100857:	8b 45 98             	mov    -0x68(%rbp),%eax
  10085a:	85 c0                	test   %eax,%eax
  10085c:	7e 2a                	jle    100888 <printer_vprintf+0x4b1>
  10085e:	8d 40 ff             	lea    -0x1(%rax),%eax
  100861:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  100866:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10086a:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  10086d:	41 0f b6 34 24       	movzbl (%r12),%esi
  100872:	44 89 fa             	mov    %r15d,%edx
  100875:	4c 89 f7             	mov    %r14,%rdi
  100878:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  10087b:	49 83 c4 01          	add    $0x1,%r12
  10087f:	49 39 dc             	cmp    %rbx,%r12
  100882:	75 e9                	jne    10086d <printer_vprintf+0x496>
  100884:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100888:	45 85 ed             	test   %r13d,%r13d
  10088b:	7e 14                	jle    1008a1 <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  10088d:	44 89 fa             	mov    %r15d,%edx
  100890:	be 20 00 00 00       	mov    $0x20,%esi
  100895:	4c 89 f7             	mov    %r14,%rdi
  100898:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  10089b:	41 83 ed 01          	sub    $0x1,%r13d
  10089f:	75 ec                	jne    10088d <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  1008a1:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1008a5:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1008a9:	84 c0                	test   %al,%al
  1008ab:	0f 84 00 02 00 00    	je     100ab1 <printer_vprintf+0x6da>
        if (*format != '%') {
  1008b1:	3c 25                	cmp    $0x25,%al
  1008b3:	0f 84 53 fb ff ff    	je     10040c <printer_vprintf+0x35>
            p->putc(p, *format, color);
  1008b9:	0f b6 f0             	movzbl %al,%esi
  1008bc:	44 89 fa             	mov    %r15d,%edx
  1008bf:	4c 89 f7             	mov    %r14,%rdi
  1008c2:	41 ff 16             	callq  *(%r14)
            continue;
  1008c5:	4c 89 e3             	mov    %r12,%rbx
  1008c8:	eb d7                	jmp    1008a1 <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  1008ca:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1008ce:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1008d2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1008d6:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1008da:	e9 4d fe ff ff       	jmpq   10072c <printer_vprintf+0x355>
            color = va_arg(val, int);
  1008df:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1008e3:	8b 07                	mov    (%rdi),%eax
  1008e5:	83 f8 2f             	cmp    $0x2f,%eax
  1008e8:	77 10                	ja     1008fa <printer_vprintf+0x523>
  1008ea:	89 c2                	mov    %eax,%edx
  1008ec:	48 03 57 10          	add    0x10(%rdi),%rdx
  1008f0:	83 c0 08             	add    $0x8,%eax
  1008f3:	89 07                	mov    %eax,(%rdi)
  1008f5:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1008f8:	eb a7                	jmp    1008a1 <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  1008fa:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1008fe:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100902:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100906:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10090a:	eb e9                	jmp    1008f5 <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  10090c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100910:	8b 01                	mov    (%rcx),%eax
  100912:	83 f8 2f             	cmp    $0x2f,%eax
  100915:	77 23                	ja     10093a <printer_vprintf+0x563>
  100917:	89 c2                	mov    %eax,%edx
  100919:	48 03 51 10          	add    0x10(%rcx),%rdx
  10091d:	83 c0 08             	add    $0x8,%eax
  100920:	89 01                	mov    %eax,(%rcx)
  100922:	8b 02                	mov    (%rdx),%eax
  100924:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100927:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10092b:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10092f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  100935:	e9 fb fd ff ff       	jmpq   100735 <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  10093a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10093e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100942:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100946:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10094a:	eb d6                	jmp    100922 <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  10094c:	84 d2                	test   %dl,%dl
  10094e:	0f 85 3b 01 00 00    	jne    100a8f <printer_vprintf+0x6b8>
  100954:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100958:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  10095c:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100960:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100964:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  10096a:	e9 c6 fd ff ff       	jmpq   100735 <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  10096f:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  100975:	bf 30 11 10 00       	mov    $0x101130,%edi
        if (flags & FLAG_NUMERIC) {
  10097a:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  10097f:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  100983:	4c 89 c1             	mov    %r8,%rcx
  100986:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  10098a:	48 63 f6             	movslq %esi,%rsi
  10098d:	49 83 ec 01          	sub    $0x1,%r12
  100991:	48 89 c8             	mov    %rcx,%rax
  100994:	ba 00 00 00 00       	mov    $0x0,%edx
  100999:	48 f7 f6             	div    %rsi
  10099c:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1009a0:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1009a4:	48 89 ca             	mov    %rcx,%rdx
  1009a7:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1009aa:	48 39 d6             	cmp    %rdx,%rsi
  1009ad:	76 de                	jbe    10098d <printer_vprintf+0x5b6>
  1009af:	e9 96 fd ff ff       	jmpq   10074a <printer_vprintf+0x373>
                prefix = "-";
  1009b4:	48 c7 45 a0 41 0f 10 	movq   $0x100f41,-0x60(%rbp)
  1009bb:	00 
            if (flags & FLAG_NEGATIVE) {
  1009bc:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1009bf:	a8 80                	test   $0x80,%al
  1009c1:	0f 85 ac fd ff ff    	jne    100773 <printer_vprintf+0x39c>
                prefix = "+";
  1009c7:	48 c7 45 a0 3f 0f 10 	movq   $0x100f3f,-0x60(%rbp)
  1009ce:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1009cf:	a8 10                	test   $0x10,%al
  1009d1:	0f 85 9c fd ff ff    	jne    100773 <printer_vprintf+0x39c>
                prefix = " ";
  1009d7:	a8 08                	test   $0x8,%al
  1009d9:	ba fa 0e 10 00       	mov    $0x100efa,%edx
  1009de:	b8 4d 11 10 00       	mov    $0x10114d,%eax
  1009e3:	48 0f 44 c2          	cmove  %rdx,%rax
  1009e7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1009eb:	e9 83 fd ff ff       	jmpq   100773 <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  1009f0:	41 8d 41 10          	lea    0x10(%r9),%eax
  1009f4:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1009f9:	0f 85 74 fd ff ff    	jne    100773 <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  1009ff:	4d 85 c0             	test   %r8,%r8
  100a02:	75 0d                	jne    100a11 <printer_vprintf+0x63a>
  100a04:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100a0b:	0f 84 62 fd ff ff    	je     100773 <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  100a11:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  100a15:	ba 3c 0f 10 00       	mov    $0x100f3c,%edx
  100a1a:	b8 43 0f 10 00       	mov    $0x100f43,%eax
  100a1f:	48 0f 44 c2          	cmove  %rdx,%rax
  100a23:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100a27:	e9 47 fd ff ff       	jmpq   100773 <printer_vprintf+0x39c>
            len = strlen(data);
  100a2c:	4c 89 e7             	mov    %r12,%rdi
  100a2f:	e8 af f8 ff ff       	callq  1002e3 <strlen>
  100a34:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100a37:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100a3b:	0f 84 5f fd ff ff    	je     1007a0 <printer_vprintf+0x3c9>
  100a41:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  100a45:	0f 84 55 fd ff ff    	je     1007a0 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  100a4b:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100a4e:	89 fa                	mov    %edi,%edx
  100a50:	29 c2                	sub    %eax,%edx
  100a52:	39 c7                	cmp    %eax,%edi
  100a54:	b8 00 00 00 00       	mov    $0x0,%eax
  100a59:	0f 4e d0             	cmovle %eax,%edx
  100a5c:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100a5f:	e9 52 fd ff ff       	jmpq   1007b6 <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  100a64:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100a68:	e8 76 f8 ff ff       	callq  1002e3 <strlen>
  100a6d:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100a70:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  100a73:	44 89 e9             	mov    %r13d,%ecx
  100a76:	29 f9                	sub    %edi,%ecx
  100a78:	29 c1                	sub    %eax,%ecx
  100a7a:	89 c8                	mov    %ecx,%eax
  100a7c:	44 39 ea             	cmp    %r13d,%edx
  100a7f:	b9 00 00 00 00       	mov    $0x0,%ecx
  100a84:	0f 4d c1             	cmovge %ecx,%eax
  100a87:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100a8a:	e9 27 fd ff ff       	jmpq   1007b6 <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  100a8f:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100a92:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100a96:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100a9a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100aa0:	e9 90 fc ff ff       	jmpq   100735 <printer_vprintf+0x35e>
        int flags = 0;
  100aa5:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100aac:	e9 ad f9 ff ff       	jmpq   10045e <printer_vprintf+0x87>
}
  100ab1:	48 83 c4 58          	add    $0x58,%rsp
  100ab5:	5b                   	pop    %rbx
  100ab6:	41 5c                	pop    %r12
  100ab8:	41 5d                	pop    %r13
  100aba:	41 5e                	pop    %r14
  100abc:	41 5f                	pop    %r15
  100abe:	5d                   	pop    %rbp
  100abf:	c3                   	retq   

0000000000100ac0 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100ac0:	55                   	push   %rbp
  100ac1:	48 89 e5             	mov    %rsp,%rbp
  100ac4:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100ac8:	48 c7 45 f0 be 01 10 	movq   $0x1001be,-0x10(%rbp)
  100acf:	00 
        cpos = 0;
  100ad0:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100ad6:	b8 00 00 00 00       	mov    $0x0,%eax
  100adb:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100ade:	48 63 ff             	movslq %edi,%rdi
  100ae1:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100ae8:	00 
  100ae9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100aed:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100af1:	e8 e1 f8 ff ff       	callq  1003d7 <printer_vprintf>
    return cp.cursor - console;
  100af6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100afa:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100b00:	48 d1 f8             	sar    %rax
}
  100b03:	c9                   	leaveq 
  100b04:	c3                   	retq   

0000000000100b05 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100b05:	55                   	push   %rbp
  100b06:	48 89 e5             	mov    %rsp,%rbp
  100b09:	48 83 ec 50          	sub    $0x50,%rsp
  100b0d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b11:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b15:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100b19:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100b20:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b24:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b28:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b2c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100b30:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b34:	e8 87 ff ff ff       	callq  100ac0 <console_vprintf>
}
  100b39:	c9                   	leaveq 
  100b3a:	c3                   	retq   

0000000000100b3b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100b3b:	55                   	push   %rbp
  100b3c:	48 89 e5             	mov    %rsp,%rbp
  100b3f:	53                   	push   %rbx
  100b40:	48 83 ec 28          	sub    $0x28,%rsp
  100b44:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100b47:	48 c7 45 d8 48 02 10 	movq   $0x100248,-0x28(%rbp)
  100b4e:	00 
    sp.s = s;
  100b4f:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100b53:	48 85 f6             	test   %rsi,%rsi
  100b56:	75 0e                	jne    100b66 <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100b58:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100b5c:	48 29 d8             	sub    %rbx,%rax
}
  100b5f:	48 83 c4 28          	add    $0x28,%rsp
  100b63:	5b                   	pop    %rbx
  100b64:	5d                   	pop    %rbp
  100b65:	c3                   	retq   
        sp.end = s + size - 1;
  100b66:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100b6b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100b6f:	be 00 00 00 00       	mov    $0x0,%esi
  100b74:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100b78:	e8 5a f8 ff ff       	callq  1003d7 <printer_vprintf>
        *sp.s = 0;
  100b7d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100b81:	c6 00 00             	movb   $0x0,(%rax)
  100b84:	eb d2                	jmp    100b58 <vsnprintf+0x1d>

0000000000100b86 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100b86:	55                   	push   %rbp
  100b87:	48 89 e5             	mov    %rsp,%rbp
  100b8a:	48 83 ec 50          	sub    $0x50,%rsp
  100b8e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b92:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b96:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100b9a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100ba1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100ba5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ba9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100bad:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100bb1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100bb5:	e8 81 ff ff ff       	callq  100b3b <vsnprintf>
    va_end(val);
    return n;
}
  100bba:	c9                   	leaveq 
  100bbb:	c3                   	retq   

0000000000100bbc <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100bbc:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100bc1:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100bc6:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100bcb:	48 83 c0 02          	add    $0x2,%rax
  100bcf:	48 39 d0             	cmp    %rdx,%rax
  100bd2:	75 f2                	jne    100bc6 <console_clear+0xa>
    }
    cursorpos = 0;
  100bd4:	c7 05 1e 84 fb ff 00 	movl   $0x0,-0x47be2(%rip)        # b8ffc <cursorpos>
  100bdb:	00 00 00 
}
  100bde:	c3                   	retq   

0000000000100bdf <malloc>:

// TODO: Implement these functions

void * malloc(uint64_t sz){
    return NULL;
}
  100bdf:	b8 00 00 00 00       	mov    $0x0,%eax
  100be4:	c3                   	retq   

0000000000100be5 <calloc>:

void * calloc(uint64_t num, uint64_t sz){
    return NULL;
}
  100be5:	b8 00 00 00 00       	mov    $0x0,%eax
  100bea:	c3                   	retq   

0000000000100beb <free>:

void free(void * ptr){

}
  100beb:	c3                   	retq   

0000000000100bec <realloc>:

void * realloc(void * ptr, uint64_t sz){
    return NULL;
}
  100bec:	b8 00 00 00 00       	mov    $0x0,%eax
  100bf1:	c3                   	retq   

0000000000100bf2 <defrag>:

void defrag(){

}
  100bf2:	c3                   	retq   

0000000000100bf3 <heap_info>:

int heap_info(heap_info_struct * info){

    return -1;
}
  100bf3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100bf8:	c3                   	retq   

0000000000100bf9 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100bf9:	55                   	push   %rbp
  100bfa:	48 89 e5             	mov    %rsp,%rbp
  100bfd:	48 83 ec 50          	sub    $0x50,%rsp
  100c01:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100c05:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100c09:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100c0d:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100c11:	b8 00 07 00 00       	mov    $0x700,%eax
    if (colorid < 0) {
  100c16:	85 ff                	test   %edi,%edi
  100c18:	78 2e                	js     100c48 <app_printf+0x4f>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100c1a:	48 63 ff             	movslq %edi,%rdi
  100c1d:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100c24:	cc cc cc 
  100c27:	48 89 f8             	mov    %rdi,%rax
  100c2a:	48 f7 e2             	mul    %rdx
  100c2d:	48 89 d0             	mov    %rdx,%rax
  100c30:	48 c1 e8 02          	shr    $0x2,%rax
  100c34:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100c38:	48 01 c2             	add    %rax,%rdx
  100c3b:	48 29 d7             	sub    %rdx,%rdi
  100c3e:	0f b6 87 80 11 10 00 	movzbl 0x101180(%rdi),%eax
  100c45:	c1 e0 08             	shl    $0x8,%eax
    }

    va_list val;
    va_start(val, format);
  100c48:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100c4f:	48 8d 4d 10          	lea    0x10(%rbp),%rcx
  100c53:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  100c57:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  100c5b:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100c5f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100c63:	48 89 f2             	mov    %rsi,%rdx
  100c66:	89 c6                	mov    %eax,%esi
  100c68:	8b 3d 8e 83 fb ff    	mov    -0x47c72(%rip),%edi        # b8ffc <cursorpos>
  100c6e:	e8 4d fe ff ff       	callq  100ac0 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100c73:	3d 30 07 00 00       	cmp    $0x730,%eax
  100c78:	ba 00 00 00 00       	mov    $0x0,%edx
  100c7d:	0f 4d c2             	cmovge %edx,%eax
  100c80:	89 05 76 83 fb ff    	mov    %eax,-0x47c8a(%rip)        # b8ffc <cursorpos>
    }
}
  100c86:	c9                   	leaveq 
  100c87:	c3                   	retq   

0000000000100c88 <read_line>:
    return result;
}

// read_line
// str should be at least max_chars + 1 byte
int read_line(char * str, int max_chars){
  100c88:	55                   	push   %rbp
  100c89:	48 89 e5             	mov    %rsp,%rbp
  100c8c:	41 56                	push   %r14
  100c8e:	41 55                	push   %r13
  100c90:	41 54                	push   %r12
  100c92:	53                   	push   %rbx
  100c93:	49 89 fd             	mov    %rdi,%r13
  100c96:	89 f3                	mov    %esi,%ebx
    static char cache[128];
    static int index = 0;
    static int length = 0;

    if(max_chars == 0){
  100c98:	85 f6                	test   %esi,%esi
  100c9a:	0f 84 8b 00 00 00    	je     100d2b <read_line+0xa3>
        str[max_chars] = '\0';
        return 0;
    }
    str[max_chars + 1] = '\0';
  100ca0:	4c 63 f6             	movslq %esi,%r14
  100ca3:	42 c6 44 37 01 00    	movb   $0x0,0x1(%rdi,%r14,1)

    if(index < length){
  100ca9:	8b 3d f5 13 00 00    	mov    0x13f5(%rip),%edi        # 1020a4 <index.1465>
  100caf:	8b 15 eb 13 00 00    	mov    0x13eb(%rip),%edx        # 1020a0 <length.1466>
  100cb5:	39 d7                	cmp    %edx,%edi
  100cb7:	0f 8d f0 00 00 00    	jge    100dad <read_line+0x125>
        // some cache left
        int i = 0;
        for(i = index;
                i < length && (i - index + 1 < max_chars);
  100cbd:	83 fe 01             	cmp    $0x1,%esi
  100cc0:	7e 3b                	jle    100cfd <read_line+0x75>
  100cc2:	4c 63 cf             	movslq %edi,%r9
  100cc5:	8d 46 fe             	lea    -0x2(%rsi),%eax
  100cc8:	4d 8d 44 01 01       	lea    0x1(%r9,%rax,1),%r8
  100ccd:	8d 42 ff             	lea    -0x1(%rdx),%eax
  100cd0:	29 f8                	sub    %edi,%eax
  100cd2:	4c 01 c8             	add    %r9,%rax
  100cd5:	4c 89 c9             	mov    %r9,%rcx
  100cd8:	be 01 00 00 00       	mov    $0x1,%esi
  100cdd:	29 fe                	sub    %edi,%esi
  100cdf:	41 89 cc             	mov    %ecx,%r12d
  100ce2:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
                i++){
            if(cache[i] == '\n'){
  100ce6:	80 b9 20 20 10 00 0a 	cmpb   $0xa,0x102020(%rcx)
  100ced:	74 4a                	je     100d39 <read_line+0xb1>
        for(i = index;
  100cef:	48 39 c1             	cmp    %rax,%rcx
  100cf2:	74 09                	je     100cfd <read_line+0x75>
  100cf4:	48 83 c1 01          	add    $0x1,%rcx
                i < length && (i - index + 1 < max_chars);
  100cf8:	4c 39 c1             	cmp    %r8,%rcx
  100cfb:	75 e2                	jne    100cdf <read_line+0x57>
                int len = i - index + 1;
                index = i + 1;
                return len;
            }
        }
        if(max_chars <= length - index + 1){
  100cfd:	29 fa                	sub    %edi,%edx
  100cff:	8d 42 01             	lea    0x1(%rdx),%eax
  100d02:	39 d8                	cmp    %ebx,%eax
  100d04:	7c 67                	jl     100d6d <read_line+0xe5>
            // copy max_chars - 1 bytes and return
            memcpy(str, cache + index, max_chars);
  100d06:	48 63 f7             	movslq %edi,%rsi
  100d09:	48 81 c6 20 20 10 00 	add    $0x102020,%rsi
  100d10:	4c 89 f2             	mov    %r14,%rdx
  100d13:	4c 89 ef             	mov    %r13,%rdi
  100d16:	e8 43 f5 ff ff       	callq  10025e <memcpy>
            str[max_chars] = '\0';
  100d1b:	43 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%r14,1)
            //app_printf(1, "[%d, %d]-> %sxx", index, index + max_chars - 1, str);
            index += max_chars;
  100d21:	01 1d 7d 13 00 00    	add    %ebx,0x137d(%rip)        # 1020a4 <index.1465>
            return max_chars;
  100d27:	89 d8                	mov    %ebx,%eax
  100d29:	eb 05                	jmp    100d30 <read_line+0xa8>
        str[max_chars] = '\0';
  100d2b:	c6 07 00             	movb   $0x0,(%rdi)
        return 0;
  100d2e:	89 f0                	mov    %esi,%eax
            return 0;
        }
        return read_line(str, max_chars);
    }
    return 0;
}
  100d30:	5b                   	pop    %rbx
  100d31:	41 5c                	pop    %r12
  100d33:	41 5d                	pop    %r13
  100d35:	41 5e                	pop    %r14
  100d37:	5d                   	pop    %rbp
  100d38:	c3                   	retq   
                memcpy(str, cache + index, i - index + 1);
  100d39:	49 63 d2             	movslq %r10d,%rdx
  100d3c:	49 8d b1 20 20 10 00 	lea    0x102020(%r9),%rsi
  100d43:	4c 89 ef             	mov    %r13,%rdi
  100d46:	e8 13 f5 ff ff       	callq  10025e <memcpy>
                str[i-index+1] = '\0';
  100d4b:	44 89 e3             	mov    %r12d,%ebx
  100d4e:	2b 1d 50 13 00 00    	sub    0x1350(%rip),%ebx        # 1020a4 <index.1465>
  100d54:	48 63 c3             	movslq %ebx,%rax
  100d57:	41 c6 44 05 01 00    	movb   $0x0,0x1(%r13,%rax,1)
                int len = i - index + 1;
  100d5d:	8d 43 01             	lea    0x1(%rbx),%eax
                index = i + 1;
  100d60:	41 83 c4 01          	add    $0x1,%r12d
  100d64:	44 89 25 39 13 00 00 	mov    %r12d,0x1339(%rip)        # 1020a4 <index.1465>
                return len;
  100d6b:	eb c3                	jmp    100d30 <read_line+0xa8>
            memcpy(str, cache + index, length - index);
  100d6d:	48 63 d2             	movslq %edx,%rdx
  100d70:	48 63 f7             	movslq %edi,%rsi
  100d73:	48 81 c6 20 20 10 00 	add    $0x102020,%rsi
  100d7a:	4c 89 ef             	mov    %r13,%rdi
  100d7d:	e8 dc f4 ff ff       	callq  10025e <memcpy>
            str += length - index;
  100d82:	8b 05 18 13 00 00    	mov    0x1318(%rip),%eax        # 1020a0 <length.1466>
  100d88:	41 89 c4             	mov    %eax,%r12d
  100d8b:	44 2b 25 12 13 00 00 	sub    0x1312(%rip),%r12d        # 1020a4 <index.1465>
            index = length;
  100d92:	89 05 0c 13 00 00    	mov    %eax,0x130c(%rip)        # 1020a4 <index.1465>
            max_chars -= length - index;
  100d98:	44 29 e3             	sub    %r12d,%ebx
  100d9b:	89 de                	mov    %ebx,%esi
            str += length - index;
  100d9d:	49 63 fc             	movslq %r12d,%rdi
  100da0:	4c 01 ef             	add    %r13,%rdi
            len += read_line(str, max_chars);
  100da3:	e8 e0 fe ff ff       	callq  100c88 <read_line>
  100da8:	44 01 e0             	add    %r12d,%eax
            return len;
  100dab:	eb 83                	jmp    100d30 <read_line+0xa8>
        index = 0;
  100dad:	c7 05 ed 12 00 00 00 	movl   $0x0,0x12ed(%rip)        # 1020a4 <index.1465>
  100db4:	00 00 00 
    asm volatile ("int %1" : "=a" (result)
  100db7:	bf 20 20 10 00       	mov    $0x102020,%edi
  100dbc:	cd 37                	int    $0x37
        length = sys_read_serial(cache);
  100dbe:	89 05 dc 12 00 00    	mov    %eax,0x12dc(%rip)        # 1020a0 <length.1466>
        if(length <= 0){
  100dc4:	85 c0                	test   %eax,%eax
  100dc6:	7f 0f                	jg     100dd7 <read_line+0x14f>
            str[0] = '\0';
  100dc8:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
            return 0;
  100dcd:	b8 00 00 00 00       	mov    $0x0,%eax
  100dd2:	e9 59 ff ff ff       	jmpq   100d30 <read_line+0xa8>
        return read_line(str, max_chars);
  100dd7:	4c 89 ef             	mov    %r13,%rdi
  100dda:	e8 a9 fe ff ff       	callq  100c88 <read_line>
  100ddf:	e9 4c ff ff ff       	jmpq   100d30 <read_line+0xa8>

0000000000100de4 <panic>:

// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100de4:	55                   	push   %rbp
  100de5:	48 89 e5             	mov    %rsp,%rbp
  100de8:	53                   	push   %rbx
  100de9:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100df0:	48 89 fb             	mov    %rdi,%rbx
  100df3:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100df7:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100dfb:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100dff:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100e03:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100e07:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100e0e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100e12:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100e16:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100e1a:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100e1e:	ba 07 00 00 00       	mov    $0x7,%edx
  100e23:	be 47 11 10 00       	mov    $0x101147,%esi
  100e28:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100e2f:	e8 2a f4 ff ff       	callq  10025e <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100e34:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100e38:	48 89 da             	mov    %rbx,%rdx
  100e3b:	be 99 00 00 00       	mov    $0x99,%esi
  100e40:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100e47:	e8 ef fc ff ff       	callq  100b3b <vsnprintf>
  100e4c:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100e4f:	85 d2                	test   %edx,%edx
  100e51:	7e 0f                	jle    100e62 <panic+0x7e>
  100e53:	83 c0 06             	add    $0x6,%eax
  100e56:	48 98                	cltq   
  100e58:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100e5f:	0a 
  100e60:	75 2a                	jne    100e8c <panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100e62:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100e69:	48 89 d9             	mov    %rbx,%rcx
  100e6c:	ba 4f 11 10 00       	mov    $0x10114f,%edx
  100e71:	be 00 c0 00 00       	mov    $0xc000,%esi
  100e76:	bf 30 07 00 00       	mov    $0x730,%edi
  100e7b:	b8 00 00 00 00       	mov    $0x0,%eax
  100e80:	e8 80 fc ff ff       	callq  100b05 <console_printf>
    asm volatile ("int %0"  : /* no result */
  100e85:	48 89 df             	mov    %rbx,%rdi
  100e88:	cd 30                	int    $0x30
 loop: goto loop;
  100e8a:	eb fe                	jmp    100e8a <panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100e8c:	48 63 c2             	movslq %edx,%rax
  100e8f:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100e95:	0f 94 c2             	sete   %dl
  100e98:	0f b6 d2             	movzbl %dl,%edx
  100e9b:	48 29 d0             	sub    %rdx,%rax
  100e9e:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100ea5:	ff 
  100ea6:	be f9 0e 10 00       	mov    $0x100ef9,%esi
  100eab:	e8 6c f4 ff ff       	callq  10031c <strcpy>
  100eb0:	eb b0                	jmp    100e62 <panic+0x7e>

0000000000100eb2 <assert_fail>:
    sys_panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100eb2:	55                   	push   %rbp
  100eb3:	48 89 e5             	mov    %rsp,%rbp
  100eb6:	48 89 f9             	mov    %rdi,%rcx
  100eb9:	41 89 f0             	mov    %esi,%r8d
  100ebc:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100ebf:	ba 58 11 10 00       	mov    $0x101158,%edx
  100ec4:	be 00 c0 00 00       	mov    $0xc000,%esi
  100ec9:	bf 30 07 00 00       	mov    $0x730,%edi
  100ece:	b8 00 00 00 00       	mov    $0x0,%eax
  100ed3:	e8 2d fc ff ff       	callq  100b05 <console_printf>
    asm volatile ("int %0"  : /* no result */
  100ed8:	bf 00 00 00 00       	mov    $0x0,%edi
  100edd:	cd 30                	int    $0x30
 loop: goto loop;
  100edf:	eb fe                	jmp    100edf <assert_fail+0x2d>
