
obj/p-allocator.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 54                	push   %r12
  100006:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100007:	cd 31                	int    $0x31
  100009:	89 c7                	mov    %eax,%edi
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  10000d:	e8 dd 02 00 00       	callq  1002ef <srand>
    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100012:	b8 b7 30 10 00       	mov    $0x1030b7,%eax
  100017:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001d:	48 89 05 84 20 00 00 	mov    %rax,0x2084(%rip)        # 1020a8 <heap_top>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sys_sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100024:	b8 00 00 00 00       	mov    $0x0,%eax
  100029:	48 89 c7             	mov    %rax,%rdi
  10002c:	cd 3a                	int    $0x3a
  10002e:	48 89 05 cb 1f 00 00 	mov    %rax,0x1fcb(%rip)        # 102000 <result.1424>
    
    // sbrk(0) should return current program break without changing it.
    void * ptr = sys_sbrk(0);
    if(ptr == (void *)-1){
  100035:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  100039:	74 1d                	je     100058 <process_main+0x58>
	panic("SBRK unimplemented!");
    }
    assert(ptr == heap_top);
  10003b:	48 39 05 66 20 00 00 	cmp    %rax,0x2066(%rip)        # 1020a8 <heap_top>
  100042:	74 23                	je     100067 <process_main+0x67>
  100044:	ba 04 0e 10 00       	mov    $0x100e04,%edx
  100049:	be 1a 00 00 00       	mov    $0x1a,%esi
  10004e:	bf 14 0e 10 00       	mov    $0x100e14,%edi
  100053:	e8 69 0d 00 00       	callq  100dc1 <assert_fail>
	panic("SBRK unimplemented!");
  100058:	bf f0 0d 10 00       	mov    $0x100df0,%edi
  10005d:	b8 00 00 00 00       	mov    $0x0,%eax
  100062:	e8 8c 0c 00 00       	callq  100cf3 <panic>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100067:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10006a:	48 83 e8 01          	sub    $0x1,%rax
  10006e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100074:	48 89 05 35 20 00 00 	mov    %rax,0x2035(%rip)        # 1020b0 <stack_bottom>
  10007b:	41 bc 00 10 00 00    	mov    $0x1000,%r12d
  100081:	eb 02                	jmp    100085 <process_main+0x85>
    asm volatile ("int %0" : /* no result */
  100083:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  100085:	e8 2b 02 00 00       	callq  1002b5 <rand>
  10008a:	89 c2                	mov    %eax,%edx
  10008c:	48 98                	cltq   
  10008e:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
  100095:	48 c1 f8 25          	sar    $0x25,%rax
  100099:	89 d1                	mov    %edx,%ecx
  10009b:	c1 f9 1f             	sar    $0x1f,%ecx
  10009e:	29 c8                	sub    %ecx,%eax
  1000a0:	6b c0 64             	imul   $0x64,%eax,%eax
  1000a3:	29 c2                	sub    %eax,%edx
  1000a5:	39 da                	cmp    %ebx,%edx
  1000a7:	7d da                	jge    100083 <process_main+0x83>
            if(heap_top == stack_bottom)
  1000a9:	48 8b 05 00 20 00 00 	mov    0x2000(%rip),%rax        # 1020b0 <stack_bottom>
  1000b0:	48 39 05 f1 1f 00 00 	cmp    %rax,0x1ff1(%rip)        # 1020a8 <heap_top>
  1000b7:	74 2a                	je     1000e3 <process_main+0xe3>
    asm volatile ("int %1" :  "=a" (result)
  1000b9:	4c 89 e7             	mov    %r12,%rdi
  1000bc:	cd 3a                	int    $0x3a
  1000be:	48 89 05 3b 1f 00 00 	mov    %rax,0x1f3b(%rip)        # 102000 <result.1424>
                break;
            void * ret = sys_sbrk(PAGESIZE);
            if(ret == (void *) -1)
  1000c5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1000c9:	74 18                	je     1000e3 <process_main+0xe3>
                break;
            *heap_top = p;      /* check we have write access to new page */
  1000cb:	48 8b 15 d6 1f 00 00 	mov    0x1fd6(%rip),%rdx        # 1020a8 <heap_top>
  1000d2:	88 1a                	mov    %bl,(%rdx)
            heap_top = (uint8_t *)ret + PAGESIZE;
  1000d4:	48 05 00 10 00 00    	add    $0x1000,%rax
  1000da:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 1020a8 <heap_top>
  1000e1:	eb a0                	jmp    100083 <process_main+0x83>
    asm volatile ("int %0" : /* no result */
  1000e3:	cd 32                	int    $0x32
  1000e5:	eb fc                	jmp    1000e3 <process_main+0xe3>

00000000001000e7 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1000e7:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1000ea:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  1000f1:	00 
  1000f2:	72 08                	jb     1000fc <console_putc+0x15>
        cp->cursor = console;
  1000f4:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  1000fb:	00 
    }
    if (c == '\n') {
  1000fc:	40 80 fe 0a          	cmp    $0xa,%sil
  100100:	74 17                	je     100119 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100102:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100106:	48 8d 50 02          	lea    0x2(%rax),%rdx
  10010a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  10010e:	40 0f b6 f6          	movzbl %sil,%esi
  100112:	44 09 c6             	or     %r8d,%esi
  100115:	66 89 30             	mov    %si,(%rax)
    }
}
  100118:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  100119:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  10011d:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  100124:	48 89 f1             	mov    %rsi,%rcx
  100127:	48 d1 f9             	sar    %rcx
  10012a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100131:	66 66 66 
  100134:	48 89 c8             	mov    %rcx,%rax
  100137:	48 f7 ea             	imul   %rdx
  10013a:	48 c1 fa 05          	sar    $0x5,%rdx
  10013e:	48 c1 fe 3f          	sar    $0x3f,%rsi
  100142:	48 29 f2             	sub    %rsi,%rdx
  100145:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  100149:	48 c1 e0 04          	shl    $0x4,%rax
  10014d:	89 ca                	mov    %ecx,%edx
  10014f:	29 c2                	sub    %eax,%edx
  100151:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  100153:	44 89 c6             	mov    %r8d,%esi
  100156:	83 ce 20             	or     $0x20,%esi
  100159:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  10015d:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  100161:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  100165:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  100168:	83 c0 01             	add    $0x1,%eax
  10016b:	83 f8 50             	cmp    $0x50,%eax
  10016e:	75 e9                	jne    100159 <console_putc+0x72>
  100170:	c3                   	retq   

0000000000100171 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  100171:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100175:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  100179:	73 0b                	jae    100186 <string_putc+0x15>
        *sp->s++ = c;
  10017b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10017f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  100183:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  100186:	c3                   	retq   

0000000000100187 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  100187:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10018a:	48 85 d2             	test   %rdx,%rdx
  10018d:	74 17                	je     1001a6 <memcpy+0x1f>
  10018f:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  100194:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  100199:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10019d:	48 83 c1 01          	add    $0x1,%rcx
  1001a1:	48 39 d1             	cmp    %rdx,%rcx
  1001a4:	75 ee                	jne    100194 <memcpy+0xd>
}
  1001a6:	c3                   	retq   

00000000001001a7 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1001a7:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1001aa:	48 39 fe             	cmp    %rdi,%rsi
  1001ad:	72 1d                	jb     1001cc <memmove+0x25>
        while (n-- > 0) {
  1001af:	b9 00 00 00 00       	mov    $0x0,%ecx
  1001b4:	48 85 d2             	test   %rdx,%rdx
  1001b7:	74 12                	je     1001cb <memmove+0x24>
            *d++ = *s++;
  1001b9:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1001bd:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1001c1:	48 83 c1 01          	add    $0x1,%rcx
  1001c5:	48 39 ca             	cmp    %rcx,%rdx
  1001c8:	75 ef                	jne    1001b9 <memmove+0x12>
}
  1001ca:	c3                   	retq   
  1001cb:	c3                   	retq   
    if (s < d && s + n > d) {
  1001cc:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1001d0:	48 39 cf             	cmp    %rcx,%rdi
  1001d3:	73 da                	jae    1001af <memmove+0x8>
        while (n-- > 0) {
  1001d5:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1001d9:	48 85 d2             	test   %rdx,%rdx
  1001dc:	74 ec                	je     1001ca <memmove+0x23>
            *--d = *--s;
  1001de:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1001e2:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1001e5:	48 83 e9 01          	sub    $0x1,%rcx
  1001e9:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1001ed:	75 ef                	jne    1001de <memmove+0x37>
  1001ef:	c3                   	retq   

00000000001001f0 <memset>:
void* memset(void* v, int c, size_t n) {
  1001f0:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001f3:	48 85 d2             	test   %rdx,%rdx
  1001f6:	74 13                	je     10020b <memset+0x1b>
  1001f8:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  1001fc:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  1001ff:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100202:	48 83 c2 01          	add    $0x1,%rdx
  100206:	48 39 d1             	cmp    %rdx,%rcx
  100209:	75 f4                	jne    1001ff <memset+0xf>
}
  10020b:	c3                   	retq   

000000000010020c <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  10020c:	80 3f 00             	cmpb   $0x0,(%rdi)
  10020f:	74 10                	je     100221 <strlen+0x15>
  100211:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  100216:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  10021a:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  10021e:	75 f6                	jne    100216 <strlen+0xa>
  100220:	c3                   	retq   
  100221:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100226:	c3                   	retq   

0000000000100227 <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100227:	b8 00 00 00 00       	mov    $0x0,%eax
  10022c:	48 85 f6             	test   %rsi,%rsi
  10022f:	74 10                	je     100241 <strnlen+0x1a>
  100231:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100235:	74 09                	je     100240 <strnlen+0x19>
        ++n;
  100237:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10023b:	48 39 c6             	cmp    %rax,%rsi
  10023e:	75 f1                	jne    100231 <strnlen+0xa>
}
  100240:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100241:	48 89 f0             	mov    %rsi,%rax
  100244:	c3                   	retq   

0000000000100245 <strcpy>:
char* strcpy(char* dst, const char* src) {
  100245:	48 89 f8             	mov    %rdi,%rax
  100248:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  10024d:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  100251:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  100254:	48 83 c2 01          	add    $0x1,%rdx
  100258:	84 c9                	test   %cl,%cl
  10025a:	75 f1                	jne    10024d <strcpy+0x8>
}
  10025c:	c3                   	retq   

000000000010025d <strcmp>:
    while (*a && *b && *a == *b) {
  10025d:	0f b6 17             	movzbl (%rdi),%edx
  100260:	84 d2                	test   %dl,%dl
  100262:	74 1a                	je     10027e <strcmp+0x21>
  100264:	0f b6 06             	movzbl (%rsi),%eax
  100267:	38 d0                	cmp    %dl,%al
  100269:	75 13                	jne    10027e <strcmp+0x21>
  10026b:	84 c0                	test   %al,%al
  10026d:	74 0f                	je     10027e <strcmp+0x21>
        ++a, ++b;
  10026f:	48 83 c7 01          	add    $0x1,%rdi
  100273:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100277:	0f b6 17             	movzbl (%rdi),%edx
  10027a:	84 d2                	test   %dl,%dl
  10027c:	75 e6                	jne    100264 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  10027e:	0f b6 0e             	movzbl (%rsi),%ecx
  100281:	38 ca                	cmp    %cl,%dl
  100283:	0f 97 c0             	seta   %al
  100286:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100289:	83 d8 00             	sbb    $0x0,%eax
}
  10028c:	c3                   	retq   

000000000010028d <strchr>:
    while (*s && *s != (char) c) {
  10028d:	0f b6 07             	movzbl (%rdi),%eax
  100290:	84 c0                	test   %al,%al
  100292:	74 10                	je     1002a4 <strchr+0x17>
  100294:	40 38 f0             	cmp    %sil,%al
  100297:	74 18                	je     1002b1 <strchr+0x24>
        ++s;
  100299:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  10029d:	0f b6 07             	movzbl (%rdi),%eax
  1002a0:	84 c0                	test   %al,%al
  1002a2:	75 f0                	jne    100294 <strchr+0x7>
        return NULL;
  1002a4:	40 84 f6             	test   %sil,%sil
  1002a7:	b8 00 00 00 00       	mov    $0x0,%eax
  1002ac:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1002b0:	c3                   	retq   
  1002b1:	48 89 f8             	mov    %rdi,%rax
  1002b4:	c3                   	retq   

00000000001002b5 <rand>:
    if (!rand_seed_set) {
  1002b5:	83 3d 50 1d 00 00 00 	cmpl   $0x0,0x1d50(%rip)        # 10200c <rand_seed_set>
  1002bc:	74 1b                	je     1002d9 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1002be:	69 05 40 1d 00 00 0d 	imul   $0x19660d,0x1d40(%rip),%eax        # 102008 <rand_seed>
  1002c5:	66 19 00 
  1002c8:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1002cd:	89 05 35 1d 00 00    	mov    %eax,0x1d35(%rip)        # 102008 <rand_seed>
    return rand_seed & RAND_MAX;
  1002d3:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1002d8:	c3                   	retq   
    rand_seed = seed;
  1002d9:	c7 05 25 1d 00 00 9e 	movl   $0x30d4879e,0x1d25(%rip)        # 102008 <rand_seed>
  1002e0:	87 d4 30 
    rand_seed_set = 1;
  1002e3:	c7 05 1f 1d 00 00 01 	movl   $0x1,0x1d1f(%rip)        # 10200c <rand_seed_set>
  1002ea:	00 00 00 
}
  1002ed:	eb cf                	jmp    1002be <rand+0x9>

00000000001002ef <srand>:
    rand_seed = seed;
  1002ef:	89 3d 13 1d 00 00    	mov    %edi,0x1d13(%rip)        # 102008 <rand_seed>
    rand_seed_set = 1;
  1002f5:	c7 05 0d 1d 00 00 01 	movl   $0x1,0x1d0d(%rip)        # 10200c <rand_seed_set>
  1002fc:	00 00 00 
}
  1002ff:	c3                   	retq   

0000000000100300 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100300:	55                   	push   %rbp
  100301:	48 89 e5             	mov    %rsp,%rbp
  100304:	41 57                	push   %r15
  100306:	41 56                	push   %r14
  100308:	41 55                	push   %r13
  10030a:	41 54                	push   %r12
  10030c:	53                   	push   %rbx
  10030d:	48 83 ec 58          	sub    $0x58,%rsp
  100311:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  100315:	0f b6 02             	movzbl (%rdx),%eax
  100318:	84 c0                	test   %al,%al
  10031a:	0f 84 ba 06 00 00    	je     1009da <printer_vprintf+0x6da>
  100320:	49 89 fe             	mov    %rdi,%r14
  100323:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  100326:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  10032d:	41 89 f7             	mov    %esi,%r15d
  100330:	e9 a5 04 00 00       	jmpq   1007da <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  100335:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  10033a:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100340:	45 84 e4             	test   %r12b,%r12b
  100343:	0f 84 85 06 00 00    	je     1009ce <printer_vprintf+0x6ce>
        int flags = 0;
  100349:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  10034f:	41 0f be f4          	movsbl %r12b,%esi
  100353:	bf 21 10 10 00       	mov    $0x101021,%edi
  100358:	e8 30 ff ff ff       	callq  10028d <strchr>
  10035d:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  100360:	48 85 c0             	test   %rax,%rax
  100363:	74 55                	je     1003ba <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  100365:	48 81 e9 21 10 10 00 	sub    $0x101021,%rcx
  10036c:	b8 01 00 00 00       	mov    $0x1,%eax
  100371:	d3 e0                	shl    %cl,%eax
  100373:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  100376:	48 83 c3 01          	add    $0x1,%rbx
  10037a:	44 0f b6 23          	movzbl (%rbx),%r12d
  10037e:	45 84 e4             	test   %r12b,%r12b
  100381:	75 cc                	jne    10034f <printer_vprintf+0x4f>
  100383:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100387:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  10038d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100394:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100397:	0f 84 a9 00 00 00    	je     100446 <printer_vprintf+0x146>
        int length = 0;
  10039d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1003a2:	0f b6 13             	movzbl (%rbx),%edx
  1003a5:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1003a8:	3c 37                	cmp    $0x37,%al
  1003aa:	0f 87 c5 04 00 00    	ja     100875 <printer_vprintf+0x575>
  1003b0:	0f b6 c0             	movzbl %al,%eax
  1003b3:	ff 24 c5 30 0e 10 00 	jmpq   *0x100e30(,%rax,8)
  1003ba:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  1003be:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1003c3:	3c 08                	cmp    $0x8,%al
  1003c5:	77 2f                	ja     1003f6 <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003c7:	0f b6 03             	movzbl (%rbx),%eax
  1003ca:	8d 50 d0             	lea    -0x30(%rax),%edx
  1003cd:	80 fa 09             	cmp    $0x9,%dl
  1003d0:	77 5e                	ja     100430 <printer_vprintf+0x130>
  1003d2:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1003d8:	48 83 c3 01          	add    $0x1,%rbx
  1003dc:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1003e1:	0f be c0             	movsbl %al,%eax
  1003e4:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003e9:	0f b6 03             	movzbl (%rbx),%eax
  1003ec:	8d 50 d0             	lea    -0x30(%rax),%edx
  1003ef:	80 fa 09             	cmp    $0x9,%dl
  1003f2:	76 e4                	jbe    1003d8 <printer_vprintf+0xd8>
  1003f4:	eb 97                	jmp    10038d <printer_vprintf+0x8d>
        } else if (*format == '*') {
  1003f6:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1003fa:	75 3f                	jne    10043b <printer_vprintf+0x13b>
            width = va_arg(val, int);
  1003fc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100400:	8b 01                	mov    (%rcx),%eax
  100402:	83 f8 2f             	cmp    $0x2f,%eax
  100405:	77 17                	ja     10041e <printer_vprintf+0x11e>
  100407:	89 c2                	mov    %eax,%edx
  100409:	48 03 51 10          	add    0x10(%rcx),%rdx
  10040d:	83 c0 08             	add    $0x8,%eax
  100410:	89 01                	mov    %eax,(%rcx)
  100412:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100415:	48 83 c3 01          	add    $0x1,%rbx
  100419:	e9 6f ff ff ff       	jmpq   10038d <printer_vprintf+0x8d>
            width = va_arg(val, int);
  10041e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100422:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100426:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10042a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10042e:	eb e2                	jmp    100412 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100430:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  100436:	e9 52 ff ff ff       	jmpq   10038d <printer_vprintf+0x8d>
        int width = -1;
  10043b:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100441:	e9 47 ff ff ff       	jmpq   10038d <printer_vprintf+0x8d>
            ++format;
  100446:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  10044a:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  10044e:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100451:	80 f9 09             	cmp    $0x9,%cl
  100454:	76 13                	jbe    100469 <printer_vprintf+0x169>
            } else if (*format == '*') {
  100456:	3c 2a                	cmp    $0x2a,%al
  100458:	74 32                	je     10048c <printer_vprintf+0x18c>
            ++format;
  10045a:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  10045d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  100464:	e9 34 ff ff ff       	jmpq   10039d <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100469:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  10046e:	48 83 c2 01          	add    $0x1,%rdx
  100472:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  100475:	0f be c0             	movsbl %al,%eax
  100478:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10047c:	0f b6 02             	movzbl (%rdx),%eax
  10047f:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100482:	80 f9 09             	cmp    $0x9,%cl
  100485:	76 e7                	jbe    10046e <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  100487:	48 89 d3             	mov    %rdx,%rbx
  10048a:	eb 1c                	jmp    1004a8 <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  10048c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100490:	8b 07                	mov    (%rdi),%eax
  100492:	83 f8 2f             	cmp    $0x2f,%eax
  100495:	77 23                	ja     1004ba <printer_vprintf+0x1ba>
  100497:	89 c2                	mov    %eax,%edx
  100499:	48 03 57 10          	add    0x10(%rdi),%rdx
  10049d:	83 c0 08             	add    $0x8,%eax
  1004a0:	89 07                	mov    %eax,(%rdi)
  1004a2:	8b 32                	mov    (%rdx),%esi
                ++format;
  1004a4:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1004a8:	85 f6                	test   %esi,%esi
  1004aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1004af:	0f 48 f0             	cmovs  %eax,%esi
  1004b2:	89 75 9c             	mov    %esi,-0x64(%rbp)
  1004b5:	e9 e3 fe ff ff       	jmpq   10039d <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  1004ba:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004be:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004c2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004c6:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004ca:	eb d6                	jmp    1004a2 <printer_vprintf+0x1a2>
        switch (*format) {
  1004cc:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1004d1:	e9 f1 00 00 00       	jmpq   1005c7 <printer_vprintf+0x2c7>
            ++format;
  1004d6:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1004da:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  1004dd:	e9 c0 fe ff ff       	jmpq   1003a2 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004e2:	85 c9                	test   %ecx,%ecx
  1004e4:	74 55                	je     10053b <printer_vprintf+0x23b>
  1004e6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004ea:	8b 01                	mov    (%rcx),%eax
  1004ec:	83 f8 2f             	cmp    $0x2f,%eax
  1004ef:	77 38                	ja     100529 <printer_vprintf+0x229>
  1004f1:	89 c2                	mov    %eax,%edx
  1004f3:	48 03 51 10          	add    0x10(%rcx),%rdx
  1004f7:	83 c0 08             	add    $0x8,%eax
  1004fa:	89 01                	mov    %eax,(%rcx)
  1004fc:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1004ff:	48 89 d0             	mov    %rdx,%rax
  100502:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100506:	49 89 d0             	mov    %rdx,%r8
  100509:	49 f7 d8             	neg    %r8
  10050c:	25 80 00 00 00       	and    $0x80,%eax
  100511:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100515:	0b 45 a8             	or     -0x58(%rbp),%eax
  100518:	83 c8 60             	or     $0x60,%eax
  10051b:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  10051e:	41 bc 30 10 10 00    	mov    $0x101030,%r12d
            break;
  100524:	e9 35 01 00 00       	jmpq   10065e <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100529:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10052d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100531:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100535:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100539:	eb c1                	jmp    1004fc <printer_vprintf+0x1fc>
  10053b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10053f:	8b 07                	mov    (%rdi),%eax
  100541:	83 f8 2f             	cmp    $0x2f,%eax
  100544:	77 10                	ja     100556 <printer_vprintf+0x256>
  100546:	89 c2                	mov    %eax,%edx
  100548:	48 03 57 10          	add    0x10(%rdi),%rdx
  10054c:	83 c0 08             	add    $0x8,%eax
  10054f:	89 07                	mov    %eax,(%rdi)
  100551:	48 63 12             	movslq (%rdx),%rdx
  100554:	eb a9                	jmp    1004ff <printer_vprintf+0x1ff>
  100556:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10055a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10055e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100562:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100566:	eb e9                	jmp    100551 <printer_vprintf+0x251>
        int base = 10;
  100568:	be 0a 00 00 00       	mov    $0xa,%esi
  10056d:	eb 58                	jmp    1005c7 <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10056f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100573:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100577:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10057b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10057f:	eb 60                	jmp    1005e1 <printer_vprintf+0x2e1>
  100581:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100585:	8b 01                	mov    (%rcx),%eax
  100587:	83 f8 2f             	cmp    $0x2f,%eax
  10058a:	77 10                	ja     10059c <printer_vprintf+0x29c>
  10058c:	89 c2                	mov    %eax,%edx
  10058e:	48 03 51 10          	add    0x10(%rcx),%rdx
  100592:	83 c0 08             	add    $0x8,%eax
  100595:	89 01                	mov    %eax,(%rcx)
  100597:	44 8b 02             	mov    (%rdx),%r8d
  10059a:	eb 48                	jmp    1005e4 <printer_vprintf+0x2e4>
  10059c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005a0:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1005a4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005a8:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1005ac:	eb e9                	jmp    100597 <printer_vprintf+0x297>
  1005ae:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1005b1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1005b8:	bf 10 10 10 00       	mov    $0x101010,%edi
  1005bd:	e9 e6 02 00 00       	jmpq   1008a8 <printer_vprintf+0x5a8>
            base = 16;
  1005c2:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005c7:	85 c9                	test   %ecx,%ecx
  1005c9:	74 b6                	je     100581 <printer_vprintf+0x281>
  1005cb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005cf:	8b 07                	mov    (%rdi),%eax
  1005d1:	83 f8 2f             	cmp    $0x2f,%eax
  1005d4:	77 99                	ja     10056f <printer_vprintf+0x26f>
  1005d6:	89 c2                	mov    %eax,%edx
  1005d8:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005dc:	83 c0 08             	add    $0x8,%eax
  1005df:	89 07                	mov    %eax,(%rdi)
  1005e1:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1005e4:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1005e8:	85 f6                	test   %esi,%esi
  1005ea:	79 c2                	jns    1005ae <printer_vprintf+0x2ae>
        base = -base;
  1005ec:	41 89 f1             	mov    %esi,%r9d
  1005ef:	f7 de                	neg    %esi
  1005f1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1005f8:	bf f0 0f 10 00       	mov    $0x100ff0,%edi
  1005fd:	e9 a6 02 00 00       	jmpq   1008a8 <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  100602:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100606:	8b 07                	mov    (%rdi),%eax
  100608:	83 f8 2f             	cmp    $0x2f,%eax
  10060b:	77 1c                	ja     100629 <printer_vprintf+0x329>
  10060d:	89 c2                	mov    %eax,%edx
  10060f:	48 03 57 10          	add    0x10(%rdi),%rdx
  100613:	83 c0 08             	add    $0x8,%eax
  100616:	89 07                	mov    %eax,(%rdi)
  100618:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10061b:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  100622:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100627:	eb c3                	jmp    1005ec <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  100629:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10062d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100631:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100635:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100639:	eb dd                	jmp    100618 <printer_vprintf+0x318>
            data = va_arg(val, char*);
  10063b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10063f:	8b 01                	mov    (%rcx),%eax
  100641:	83 f8 2f             	cmp    $0x2f,%eax
  100644:	0f 87 a9 01 00 00    	ja     1007f3 <printer_vprintf+0x4f3>
  10064a:	89 c2                	mov    %eax,%edx
  10064c:	48 03 51 10          	add    0x10(%rcx),%rdx
  100650:	83 c0 08             	add    $0x8,%eax
  100653:	89 01                	mov    %eax,(%rcx)
  100655:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  100658:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  10065e:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100661:	83 e0 20             	and    $0x20,%eax
  100664:	89 45 8c             	mov    %eax,-0x74(%rbp)
  100667:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  10066d:	0f 85 25 02 00 00    	jne    100898 <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  100673:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100676:	89 45 88             	mov    %eax,-0x78(%rbp)
  100679:	83 e0 60             	and    $0x60,%eax
  10067c:	83 f8 60             	cmp    $0x60,%eax
  10067f:	0f 84 58 02 00 00    	je     1008dd <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100685:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100688:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  10068b:	48 c7 45 a0 30 10 10 	movq   $0x101030,-0x60(%rbp)
  100692:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100693:	83 f8 21             	cmp    $0x21,%eax
  100696:	0f 84 7d 02 00 00    	je     100919 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10069c:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  10069f:	89 c8                	mov    %ecx,%eax
  1006a1:	f7 d0                	not    %eax
  1006a3:	c1 e8 1f             	shr    $0x1f,%eax
  1006a6:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1006a9:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1006ad:	0f 85 a2 02 00 00    	jne    100955 <printer_vprintf+0x655>
  1006b3:	84 c0                	test   %al,%al
  1006b5:	0f 84 9a 02 00 00    	je     100955 <printer_vprintf+0x655>
            len = strnlen(data, precision);
  1006bb:	48 63 f1             	movslq %ecx,%rsi
  1006be:	4c 89 e7             	mov    %r12,%rdi
  1006c1:	e8 61 fb ff ff       	callq  100227 <strnlen>
  1006c6:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1006c9:	8b 45 88             	mov    -0x78(%rbp),%eax
  1006cc:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1006cf:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1006d6:	83 f8 22             	cmp    $0x22,%eax
  1006d9:	0f 84 ae 02 00 00    	je     10098d <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  1006df:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006e3:	e8 24 fb ff ff       	callq  10020c <strlen>
  1006e8:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1006eb:	03 55 98             	add    -0x68(%rbp),%edx
  1006ee:	41 29 d5             	sub    %edx,%r13d
  1006f1:	44 89 ea             	mov    %r13d,%edx
  1006f4:	29 c2                	sub    %eax,%edx
  1006f6:	89 55 8c             	mov    %edx,-0x74(%rbp)
  1006f9:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1006fc:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100700:	75 2d                	jne    10072f <printer_vprintf+0x42f>
  100702:	85 d2                	test   %edx,%edx
  100704:	7e 29                	jle    10072f <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  100706:	44 89 fa             	mov    %r15d,%edx
  100709:	be 20 00 00 00       	mov    $0x20,%esi
  10070e:	4c 89 f7             	mov    %r14,%rdi
  100711:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100714:	41 83 ed 01          	sub    $0x1,%r13d
  100718:	45 85 ed             	test   %r13d,%r13d
  10071b:	7f e9                	jg     100706 <printer_vprintf+0x406>
  10071d:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100720:	85 ff                	test   %edi,%edi
  100722:	b8 01 00 00 00       	mov    $0x1,%eax
  100727:	0f 4f c7             	cmovg  %edi,%eax
  10072a:	29 c7                	sub    %eax,%edi
  10072c:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  10072f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  100733:	0f b6 01             	movzbl (%rcx),%eax
  100736:	84 c0                	test   %al,%al
  100738:	74 22                	je     10075c <printer_vprintf+0x45c>
  10073a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10073e:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  100741:	0f b6 f0             	movzbl %al,%esi
  100744:	44 89 fa             	mov    %r15d,%edx
  100747:	4c 89 f7             	mov    %r14,%rdi
  10074a:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  10074d:	48 83 c3 01          	add    $0x1,%rbx
  100751:	0f b6 03             	movzbl (%rbx),%eax
  100754:	84 c0                	test   %al,%al
  100756:	75 e9                	jne    100741 <printer_vprintf+0x441>
  100758:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  10075c:	8b 45 9c             	mov    -0x64(%rbp),%eax
  10075f:	85 c0                	test   %eax,%eax
  100761:	7e 1d                	jle    100780 <printer_vprintf+0x480>
  100763:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100767:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  100769:	44 89 fa             	mov    %r15d,%edx
  10076c:	be 30 00 00 00       	mov    $0x30,%esi
  100771:	4c 89 f7             	mov    %r14,%rdi
  100774:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  100777:	83 eb 01             	sub    $0x1,%ebx
  10077a:	75 ed                	jne    100769 <printer_vprintf+0x469>
  10077c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100780:	8b 45 98             	mov    -0x68(%rbp),%eax
  100783:	85 c0                	test   %eax,%eax
  100785:	7e 2a                	jle    1007b1 <printer_vprintf+0x4b1>
  100787:	8d 40 ff             	lea    -0x1(%rax),%eax
  10078a:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  10078f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100793:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100796:	41 0f b6 34 24       	movzbl (%r12),%esi
  10079b:	44 89 fa             	mov    %r15d,%edx
  10079e:	4c 89 f7             	mov    %r14,%rdi
  1007a1:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1007a4:	49 83 c4 01          	add    $0x1,%r12
  1007a8:	49 39 dc             	cmp    %rbx,%r12
  1007ab:	75 e9                	jne    100796 <printer_vprintf+0x496>
  1007ad:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1007b1:	45 85 ed             	test   %r13d,%r13d
  1007b4:	7e 14                	jle    1007ca <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  1007b6:	44 89 fa             	mov    %r15d,%edx
  1007b9:	be 20 00 00 00       	mov    $0x20,%esi
  1007be:	4c 89 f7             	mov    %r14,%rdi
  1007c1:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1007c4:	41 83 ed 01          	sub    $0x1,%r13d
  1007c8:	75 ec                	jne    1007b6 <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  1007ca:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1007ce:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1007d2:	84 c0                	test   %al,%al
  1007d4:	0f 84 00 02 00 00    	je     1009da <printer_vprintf+0x6da>
        if (*format != '%') {
  1007da:	3c 25                	cmp    $0x25,%al
  1007dc:	0f 84 53 fb ff ff    	je     100335 <printer_vprintf+0x35>
            p->putc(p, *format, color);
  1007e2:	0f b6 f0             	movzbl %al,%esi
  1007e5:	44 89 fa             	mov    %r15d,%edx
  1007e8:	4c 89 f7             	mov    %r14,%rdi
  1007eb:	41 ff 16             	callq  *(%r14)
            continue;
  1007ee:	4c 89 e3             	mov    %r12,%rbx
  1007f1:	eb d7                	jmp    1007ca <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  1007f3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007f7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007fb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ff:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100803:	e9 4d fe ff ff       	jmpq   100655 <printer_vprintf+0x355>
            color = va_arg(val, int);
  100808:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10080c:	8b 07                	mov    (%rdi),%eax
  10080e:	83 f8 2f             	cmp    $0x2f,%eax
  100811:	77 10                	ja     100823 <printer_vprintf+0x523>
  100813:	89 c2                	mov    %eax,%edx
  100815:	48 03 57 10          	add    0x10(%rdi),%rdx
  100819:	83 c0 08             	add    $0x8,%eax
  10081c:	89 07                	mov    %eax,(%rdi)
  10081e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100821:	eb a7                	jmp    1007ca <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  100823:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100827:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10082b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10082f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100833:	eb e9                	jmp    10081e <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  100835:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100839:	8b 01                	mov    (%rcx),%eax
  10083b:	83 f8 2f             	cmp    $0x2f,%eax
  10083e:	77 23                	ja     100863 <printer_vprintf+0x563>
  100840:	89 c2                	mov    %eax,%edx
  100842:	48 03 51 10          	add    0x10(%rcx),%rdx
  100846:	83 c0 08             	add    $0x8,%eax
  100849:	89 01                	mov    %eax,(%rcx)
  10084b:	8b 02                	mov    (%rdx),%eax
  10084d:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100850:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100854:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100858:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  10085e:	e9 fb fd ff ff       	jmpq   10065e <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  100863:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100867:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10086b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10086f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100873:	eb d6                	jmp    10084b <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  100875:	84 d2                	test   %dl,%dl
  100877:	0f 85 3b 01 00 00    	jne    1009b8 <printer_vprintf+0x6b8>
  10087d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100881:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100885:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100889:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10088d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100893:	e9 c6 fd ff ff       	jmpq   10065e <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  100898:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10089e:	bf 10 10 10 00       	mov    $0x101010,%edi
        if (flags & FLAG_NUMERIC) {
  1008a3:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1008a8:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1008ac:	4c 89 c1             	mov    %r8,%rcx
  1008af:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1008b3:	48 63 f6             	movslq %esi,%rsi
  1008b6:	49 83 ec 01          	sub    $0x1,%r12
  1008ba:	48 89 c8             	mov    %rcx,%rax
  1008bd:	ba 00 00 00 00       	mov    $0x0,%edx
  1008c2:	48 f7 f6             	div    %rsi
  1008c5:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1008c9:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1008cd:	48 89 ca             	mov    %rcx,%rdx
  1008d0:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1008d3:	48 39 d6             	cmp    %rdx,%rsi
  1008d6:	76 de                	jbe    1008b6 <printer_vprintf+0x5b6>
  1008d8:	e9 96 fd ff ff       	jmpq   100673 <printer_vprintf+0x373>
                prefix = "-";
  1008dd:	48 c7 45 a0 27 0e 10 	movq   $0x100e27,-0x60(%rbp)
  1008e4:	00 
            if (flags & FLAG_NEGATIVE) {
  1008e5:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1008e8:	a8 80                	test   $0x80,%al
  1008ea:	0f 85 ac fd ff ff    	jne    10069c <printer_vprintf+0x39c>
                prefix = "+";
  1008f0:	48 c7 45 a0 25 0e 10 	movq   $0x100e25,-0x60(%rbp)
  1008f7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1008f8:	a8 10                	test   $0x10,%al
  1008fa:	0f 85 9c fd ff ff    	jne    10069c <printer_vprintf+0x39c>
                prefix = " ";
  100900:	a8 08                	test   $0x8,%al
  100902:	ba 30 10 10 00       	mov    $0x101030,%edx
  100907:	b8 2d 10 10 00       	mov    $0x10102d,%eax
  10090c:	48 0f 44 c2          	cmove  %rdx,%rax
  100910:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100914:	e9 83 fd ff ff       	jmpq   10069c <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  100919:	41 8d 41 10          	lea    0x10(%r9),%eax
  10091d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100922:	0f 85 74 fd ff ff    	jne    10069c <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  100928:	4d 85 c0             	test   %r8,%r8
  10092b:	75 0d                	jne    10093a <printer_vprintf+0x63a>
  10092d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100934:	0f 84 62 fd ff ff    	je     10069c <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  10093a:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  10093e:	ba 22 0e 10 00       	mov    $0x100e22,%edx
  100943:	b8 29 0e 10 00       	mov    $0x100e29,%eax
  100948:	48 0f 44 c2          	cmove  %rdx,%rax
  10094c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100950:	e9 47 fd ff ff       	jmpq   10069c <printer_vprintf+0x39c>
            len = strlen(data);
  100955:	4c 89 e7             	mov    %r12,%rdi
  100958:	e8 af f8 ff ff       	callq  10020c <strlen>
  10095d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100960:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100964:	0f 84 5f fd ff ff    	je     1006c9 <printer_vprintf+0x3c9>
  10096a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  10096e:	0f 84 55 fd ff ff    	je     1006c9 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  100974:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100977:	89 fa                	mov    %edi,%edx
  100979:	29 c2                	sub    %eax,%edx
  10097b:	39 c7                	cmp    %eax,%edi
  10097d:	b8 00 00 00 00       	mov    $0x0,%eax
  100982:	0f 4e d0             	cmovle %eax,%edx
  100985:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100988:	e9 52 fd ff ff       	jmpq   1006df <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  10098d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100991:	e8 76 f8 ff ff       	callq  10020c <strlen>
  100996:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100999:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  10099c:	44 89 e9             	mov    %r13d,%ecx
  10099f:	29 f9                	sub    %edi,%ecx
  1009a1:	29 c1                	sub    %eax,%ecx
  1009a3:	89 c8                	mov    %ecx,%eax
  1009a5:	44 39 ea             	cmp    %r13d,%edx
  1009a8:	b9 00 00 00 00       	mov    $0x0,%ecx
  1009ad:	0f 4d c1             	cmovge %ecx,%eax
  1009b0:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1009b3:	e9 27 fd ff ff       	jmpq   1006df <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  1009b8:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1009bb:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1009bf:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1009c3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1009c9:	e9 90 fc ff ff       	jmpq   10065e <printer_vprintf+0x35e>
        int flags = 0;
  1009ce:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1009d5:	e9 ad f9 ff ff       	jmpq   100387 <printer_vprintf+0x87>
}
  1009da:	48 83 c4 58          	add    $0x58,%rsp
  1009de:	5b                   	pop    %rbx
  1009df:	41 5c                	pop    %r12
  1009e1:	41 5d                	pop    %r13
  1009e3:	41 5e                	pop    %r14
  1009e5:	41 5f                	pop    %r15
  1009e7:	5d                   	pop    %rbp
  1009e8:	c3                   	retq   

00000000001009e9 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1009e9:	55                   	push   %rbp
  1009ea:	48 89 e5             	mov    %rsp,%rbp
  1009ed:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  1009f1:	48 c7 45 f0 e7 00 10 	movq   $0x1000e7,-0x10(%rbp)
  1009f8:	00 
        cpos = 0;
  1009f9:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1009ff:	b8 00 00 00 00       	mov    $0x0,%eax
  100a04:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a07:	48 63 ff             	movslq %edi,%rdi
  100a0a:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a11:	00 
  100a12:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a16:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a1a:	e8 e1 f8 ff ff       	callq  100300 <printer_vprintf>
    return cp.cursor - console;
  100a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a23:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a29:	48 d1 f8             	sar    %rax
}
  100a2c:	c9                   	leaveq 
  100a2d:	c3                   	retq   

0000000000100a2e <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a2e:	55                   	push   %rbp
  100a2f:	48 89 e5             	mov    %rsp,%rbp
  100a32:	48 83 ec 50          	sub    $0x50,%rsp
  100a36:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a3a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a3e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100a42:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a49:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a4d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a51:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a55:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100a59:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a5d:	e8 87 ff ff ff       	callq  1009e9 <console_vprintf>
}
  100a62:	c9                   	leaveq 
  100a63:	c3                   	retq   

0000000000100a64 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100a64:	55                   	push   %rbp
  100a65:	48 89 e5             	mov    %rsp,%rbp
  100a68:	53                   	push   %rbx
  100a69:	48 83 ec 28          	sub    $0x28,%rsp
  100a6d:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100a70:	48 c7 45 d8 71 01 10 	movq   $0x100171,-0x28(%rbp)
  100a77:	00 
    sp.s = s;
  100a78:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100a7c:	48 85 f6             	test   %rsi,%rsi
  100a7f:	75 0e                	jne    100a8f <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100a81:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a85:	48 29 d8             	sub    %rbx,%rax
}
  100a88:	48 83 c4 28          	add    $0x28,%rsp
  100a8c:	5b                   	pop    %rbx
  100a8d:	5d                   	pop    %rbp
  100a8e:	c3                   	retq   
        sp.end = s + size - 1;
  100a8f:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a98:	be 00 00 00 00       	mov    $0x0,%esi
  100a9d:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100aa1:	e8 5a f8 ff ff       	callq  100300 <printer_vprintf>
        *sp.s = 0;
  100aa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100aaa:	c6 00 00             	movb   $0x0,(%rax)
  100aad:	eb d2                	jmp    100a81 <vsnprintf+0x1d>

0000000000100aaf <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100aaf:	55                   	push   %rbp
  100ab0:	48 89 e5             	mov    %rsp,%rbp
  100ab3:	48 83 ec 50          	sub    $0x50,%rsp
  100ab7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100abb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100abf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100ac3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100aca:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100ace:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ad2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100ad6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100ada:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100ade:	e8 81 ff ff ff       	callq  100a64 <vsnprintf>
    va_end(val);
    return n;
}
  100ae3:	c9                   	leaveq 
  100ae4:	c3                   	retq   

0000000000100ae5 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100ae5:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100aea:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100aef:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100af4:	48 83 c0 02          	add    $0x2,%rax
  100af8:	48 39 d0             	cmp    %rdx,%rax
  100afb:	75 f2                	jne    100aef <console_clear+0xa>
    }
    cursorpos = 0;
  100afd:	c7 05 f5 84 fb ff 00 	movl   $0x0,-0x47b0b(%rip)        # b8ffc <cursorpos>
  100b04:	00 00 00 
}
  100b07:	c3                   	retq   

0000000000100b08 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100b08:	55                   	push   %rbp
  100b09:	48 89 e5             	mov    %rsp,%rbp
  100b0c:	48 83 ec 50          	sub    $0x50,%rsp
  100b10:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100b14:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b18:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b1c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100b20:	b8 00 07 00 00       	mov    $0x700,%eax
    if (colorid < 0) {
  100b25:	85 ff                	test   %edi,%edi
  100b27:	78 2e                	js     100b57 <app_printf+0x4f>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100b29:	48 63 ff             	movslq %edi,%rdi
  100b2c:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100b33:	cc cc cc 
  100b36:	48 89 f8             	mov    %rdi,%rax
  100b39:	48 f7 e2             	mul    %rdx
  100b3c:	48 89 d0             	mov    %rdx,%rax
  100b3f:	48 c1 e8 02          	shr    $0x2,%rax
  100b43:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100b47:	48 01 c2             	add    %rax,%rdx
  100b4a:	48 29 d7             	sub    %rdx,%rdi
  100b4d:	0f b6 87 60 10 10 00 	movzbl 0x101060(%rdi),%eax
  100b54:	c1 e0 08             	shl    $0x8,%eax
    }

    va_list val;
    va_start(val, format);
  100b57:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100b5e:	48 8d 4d 10          	lea    0x10(%rbp),%rcx
  100b62:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  100b66:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  100b6a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100b6e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b72:	48 89 f2             	mov    %rsi,%rdx
  100b75:	89 c6                	mov    %eax,%esi
  100b77:	8b 3d 7f 84 fb ff    	mov    -0x47b81(%rip),%edi        # b8ffc <cursorpos>
  100b7d:	e8 67 fe ff ff       	callq  1009e9 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100b82:	3d 30 07 00 00       	cmp    $0x730,%eax
  100b87:	ba 00 00 00 00       	mov    $0x0,%edx
  100b8c:	0f 4d c2             	cmovge %edx,%eax
  100b8f:	89 05 67 84 fb ff    	mov    %eax,-0x47b99(%rip)        # b8ffc <cursorpos>
    }
}
  100b95:	c9                   	leaveq 
  100b96:	c3                   	retq   

0000000000100b97 <read_line>:
    return result;
}

// read_line
// str should be at least max_chars + 1 byte
int read_line(char * str, int max_chars){
  100b97:	55                   	push   %rbp
  100b98:	48 89 e5             	mov    %rsp,%rbp
  100b9b:	41 56                	push   %r14
  100b9d:	41 55                	push   %r13
  100b9f:	41 54                	push   %r12
  100ba1:	53                   	push   %rbx
  100ba2:	49 89 fd             	mov    %rdi,%r13
  100ba5:	89 f3                	mov    %esi,%ebx
    static char cache[128];
    static int index = 0;
    static int length = 0;

    if(max_chars == 0){
  100ba7:	85 f6                	test   %esi,%esi
  100ba9:	0f 84 8b 00 00 00    	je     100c3a <read_line+0xa3>
        str[max_chars] = '\0';
        return 0;
    }
    str[max_chars + 1] = '\0';
  100baf:	4c 63 f6             	movslq %esi,%r14
  100bb2:	42 c6 44 37 01 00    	movb   $0x0,0x1(%rdi,%r14,1)

    if(index < length){
  100bb8:	8b 3d e6 14 00 00    	mov    0x14e6(%rip),%edi        # 1020a4 <index.1465>
  100bbe:	8b 15 dc 14 00 00    	mov    0x14dc(%rip),%edx        # 1020a0 <length.1466>
  100bc4:	39 d7                	cmp    %edx,%edi
  100bc6:	0f 8d f0 00 00 00    	jge    100cbc <read_line+0x125>
        // some cache left
        int i = 0;
        for(i = index;
                i < length && (i - index + 1 < max_chars);
  100bcc:	83 fe 01             	cmp    $0x1,%esi
  100bcf:	7e 3b                	jle    100c0c <read_line+0x75>
  100bd1:	4c 63 cf             	movslq %edi,%r9
  100bd4:	8d 46 fe             	lea    -0x2(%rsi),%eax
  100bd7:	4d 8d 44 01 01       	lea    0x1(%r9,%rax,1),%r8
  100bdc:	8d 42 ff             	lea    -0x1(%rdx),%eax
  100bdf:	29 f8                	sub    %edi,%eax
  100be1:	4c 01 c8             	add    %r9,%rax
  100be4:	4c 89 c9             	mov    %r9,%rcx
  100be7:	be 01 00 00 00       	mov    $0x1,%esi
  100bec:	29 fe                	sub    %edi,%esi
  100bee:	41 89 cc             	mov    %ecx,%r12d
  100bf1:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
                i++){
            if(cache[i] == '\n'){
  100bf5:	80 b9 20 20 10 00 0a 	cmpb   $0xa,0x102020(%rcx)
  100bfc:	74 4a                	je     100c48 <read_line+0xb1>
        for(i = index;
  100bfe:	48 39 c1             	cmp    %rax,%rcx
  100c01:	74 09                	je     100c0c <read_line+0x75>
  100c03:	48 83 c1 01          	add    $0x1,%rcx
                i < length && (i - index + 1 < max_chars);
  100c07:	4c 39 c1             	cmp    %r8,%rcx
  100c0a:	75 e2                	jne    100bee <read_line+0x57>
                int len = i - index + 1;
                index = i + 1;
                return len;
            }
        }
        if(max_chars <= length - index + 1){
  100c0c:	29 fa                	sub    %edi,%edx
  100c0e:	8d 42 01             	lea    0x1(%rdx),%eax
  100c11:	39 d8                	cmp    %ebx,%eax
  100c13:	7c 67                	jl     100c7c <read_line+0xe5>
            // copy max_chars - 1 bytes and return
            memcpy(str, cache + index, max_chars);
  100c15:	48 63 f7             	movslq %edi,%rsi
  100c18:	48 81 c6 20 20 10 00 	add    $0x102020,%rsi
  100c1f:	4c 89 f2             	mov    %r14,%rdx
  100c22:	4c 89 ef             	mov    %r13,%rdi
  100c25:	e8 5d f5 ff ff       	callq  100187 <memcpy>
            str[max_chars] = '\0';
  100c2a:	43 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%r14,1)
            //app_printf(1, "[%d, %d]-> %sxx", index, index + max_chars - 1, str);
            index += max_chars;
  100c30:	01 1d 6e 14 00 00    	add    %ebx,0x146e(%rip)        # 1020a4 <index.1465>
            return max_chars;
  100c36:	89 d8                	mov    %ebx,%eax
  100c38:	eb 05                	jmp    100c3f <read_line+0xa8>
        str[max_chars] = '\0';
  100c3a:	c6 07 00             	movb   $0x0,(%rdi)
        return 0;
  100c3d:	89 f0                	mov    %esi,%eax
            return 0;
        }
        return read_line(str, max_chars);
    }
    return 0;
}
  100c3f:	5b                   	pop    %rbx
  100c40:	41 5c                	pop    %r12
  100c42:	41 5d                	pop    %r13
  100c44:	41 5e                	pop    %r14
  100c46:	5d                   	pop    %rbp
  100c47:	c3                   	retq   
                memcpy(str, cache + index, i - index + 1);
  100c48:	49 63 d2             	movslq %r10d,%rdx
  100c4b:	49 8d b1 20 20 10 00 	lea    0x102020(%r9),%rsi
  100c52:	4c 89 ef             	mov    %r13,%rdi
  100c55:	e8 2d f5 ff ff       	callq  100187 <memcpy>
                str[i-index+1] = '\0';
  100c5a:	44 89 e3             	mov    %r12d,%ebx
  100c5d:	2b 1d 41 14 00 00    	sub    0x1441(%rip),%ebx        # 1020a4 <index.1465>
  100c63:	48 63 c3             	movslq %ebx,%rax
  100c66:	41 c6 44 05 01 00    	movb   $0x0,0x1(%r13,%rax,1)
                int len = i - index + 1;
  100c6c:	8d 43 01             	lea    0x1(%rbx),%eax
                index = i + 1;
  100c6f:	41 83 c4 01          	add    $0x1,%r12d
  100c73:	44 89 25 2a 14 00 00 	mov    %r12d,0x142a(%rip)        # 1020a4 <index.1465>
                return len;
  100c7a:	eb c3                	jmp    100c3f <read_line+0xa8>
            memcpy(str, cache + index, length - index);
  100c7c:	48 63 d2             	movslq %edx,%rdx
  100c7f:	48 63 f7             	movslq %edi,%rsi
  100c82:	48 81 c6 20 20 10 00 	add    $0x102020,%rsi
  100c89:	4c 89 ef             	mov    %r13,%rdi
  100c8c:	e8 f6 f4 ff ff       	callq  100187 <memcpy>
            str += length - index;
  100c91:	8b 05 09 14 00 00    	mov    0x1409(%rip),%eax        # 1020a0 <length.1466>
  100c97:	41 89 c4             	mov    %eax,%r12d
  100c9a:	44 2b 25 03 14 00 00 	sub    0x1403(%rip),%r12d        # 1020a4 <index.1465>
            index = length;
  100ca1:	89 05 fd 13 00 00    	mov    %eax,0x13fd(%rip)        # 1020a4 <index.1465>
            max_chars -= length - index;
  100ca7:	44 29 e3             	sub    %r12d,%ebx
  100caa:	89 de                	mov    %ebx,%esi
            str += length - index;
  100cac:	49 63 fc             	movslq %r12d,%rdi
  100caf:	4c 01 ef             	add    %r13,%rdi
            len += read_line(str, max_chars);
  100cb2:	e8 e0 fe ff ff       	callq  100b97 <read_line>
  100cb7:	44 01 e0             	add    %r12d,%eax
            return len;
  100cba:	eb 83                	jmp    100c3f <read_line+0xa8>
        index = 0;
  100cbc:	c7 05 de 13 00 00 00 	movl   $0x0,0x13de(%rip)        # 1020a4 <index.1465>
  100cc3:	00 00 00 
    asm volatile ("int %1" : "=a" (result)
  100cc6:	bf 20 20 10 00       	mov    $0x102020,%edi
  100ccb:	cd 37                	int    $0x37
        length = sys_read_serial(cache);
  100ccd:	89 05 cd 13 00 00    	mov    %eax,0x13cd(%rip)        # 1020a0 <length.1466>
        if(length <= 0){
  100cd3:	85 c0                	test   %eax,%eax
  100cd5:	7f 0f                	jg     100ce6 <read_line+0x14f>
            str[0] = '\0';
  100cd7:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
            return 0;
  100cdc:	b8 00 00 00 00       	mov    $0x0,%eax
  100ce1:	e9 59 ff ff ff       	jmpq   100c3f <read_line+0xa8>
        return read_line(str, max_chars);
  100ce6:	4c 89 ef             	mov    %r13,%rdi
  100ce9:	e8 a9 fe ff ff       	callq  100b97 <read_line>
  100cee:	e9 4c ff ff ff       	jmpq   100c3f <read_line+0xa8>

0000000000100cf3 <panic>:

// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100cf3:	55                   	push   %rbp
  100cf4:	48 89 e5             	mov    %rsp,%rbp
  100cf7:	53                   	push   %rbx
  100cf8:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100cff:	48 89 fb             	mov    %rdi,%rbx
  100d02:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100d06:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100d0a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100d0e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100d12:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100d16:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100d1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100d21:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100d25:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100d29:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100d2d:	ba 07 00 00 00       	mov    $0x7,%edx
  100d32:	be 27 10 10 00       	mov    $0x101027,%esi
  100d37:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100d3e:	e8 44 f4 ff ff       	callq  100187 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100d43:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100d47:	48 89 da             	mov    %rbx,%rdx
  100d4a:	be 99 00 00 00       	mov    $0x99,%esi
  100d4f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100d56:	e8 09 fd ff ff       	callq  100a64 <vsnprintf>
  100d5b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100d5e:	85 d2                	test   %edx,%edx
  100d60:	7e 0f                	jle    100d71 <panic+0x7e>
  100d62:	83 c0 06             	add    $0x6,%eax
  100d65:	48 98                	cltq   
  100d67:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100d6e:	0a 
  100d6f:	75 2a                	jne    100d9b <panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100d71:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  100d78:	48 89 d9             	mov    %rbx,%rcx
  100d7b:	ba 31 10 10 00       	mov    $0x101031,%edx
  100d80:	be 00 c0 00 00       	mov    $0xc000,%esi
  100d85:	bf 30 07 00 00       	mov    $0x730,%edi
  100d8a:	b8 00 00 00 00       	mov    $0x0,%eax
  100d8f:	e8 9a fc ff ff       	callq  100a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  100d94:	48 89 df             	mov    %rbx,%rdi
  100d97:	cd 30                	int    $0x30
 loop: goto loop;
  100d99:	eb fe                	jmp    100d99 <panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100d9b:	48 63 c2             	movslq %edx,%rax
  100d9e:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100da4:	0f 94 c2             	sete   %dl
  100da7:	0f b6 d2             	movzbl %dl,%edx
  100daa:	48 29 d0             	sub    %rdx,%rax
  100dad:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100db4:	ff 
  100db5:	be 2f 10 10 00       	mov    $0x10102f,%esi
  100dba:	e8 86 f4 ff ff       	callq  100245 <strcpy>
  100dbf:	eb b0                	jmp    100d71 <panic+0x7e>

0000000000100dc1 <assert_fail>:
    sys_panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100dc1:	55                   	push   %rbp
  100dc2:	48 89 e5             	mov    %rsp,%rbp
  100dc5:	48 89 f9             	mov    %rdi,%rcx
  100dc8:	41 89 f0             	mov    %esi,%r8d
  100dcb:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100dce:	ba 38 10 10 00       	mov    $0x101038,%edx
  100dd3:	be 00 c0 00 00       	mov    $0xc000,%esi
  100dd8:	bf 30 07 00 00       	mov    $0x730,%edi
  100ddd:	b8 00 00 00 00       	mov    $0x0,%eax
  100de2:	e8 47 fc ff ff       	callq  100a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  100de7:	bf 00 00 00 00       	mov    $0x0,%edi
  100dec:	cd 30                	int    $0x30
 loop: goto loop;
  100dee:	eb fe                	jmp    100dee <assert_fail+0x2d>
