
obj/p-allocator3.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000180000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  180000:	55                   	push   %rbp
  180001:	48 89 e5             	mov    %rsp,%rbp
  180004:	41 54                	push   %r12
  180006:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  180007:	cd 31                	int    $0x31
  180009:	89 c7                	mov    %eax,%edi
  18000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  18000d:	e8 dd 02 00 00       	callq  1802ef <srand>
    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  180012:	b8 b7 30 18 00       	mov    $0x1830b7,%eax
  180017:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  18001d:	48 89 05 84 20 00 00 	mov    %rax,0x2084(%rip)        # 1820a8 <heap_top>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sys_sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  180024:	b8 00 00 00 00       	mov    $0x0,%eax
  180029:	48 89 c7             	mov    %rax,%rdi
  18002c:	cd 3a                	int    $0x3a
  18002e:	48 89 05 cb 1f 00 00 	mov    %rax,0x1fcb(%rip)        # 182000 <result.1424>
    
    // sbrk(0) should return current program break without changing it.
    void * ptr = sys_sbrk(0);
    if(ptr == (void *)-1){
  180035:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  180039:	74 1d                	je     180058 <process_main+0x58>
	panic("SBRK unimplemented!");
    }
    assert(ptr == heap_top);
  18003b:	48 39 05 66 20 00 00 	cmp    %rax,0x2066(%rip)        # 1820a8 <heap_top>
  180042:	74 23                	je     180067 <process_main+0x67>
  180044:	ba 04 0e 18 00       	mov    $0x180e04,%edx
  180049:	be 1a 00 00 00       	mov    $0x1a,%esi
  18004e:	bf 14 0e 18 00       	mov    $0x180e14,%edi
  180053:	e8 69 0d 00 00       	callq  180dc1 <assert_fail>
	panic("SBRK unimplemented!");
  180058:	bf f0 0d 18 00       	mov    $0x180df0,%edi
  18005d:	b8 00 00 00 00       	mov    $0x0,%eax
  180062:	e8 8c 0c 00 00       	callq  180cf3 <panic>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  180067:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  18006a:	48 83 e8 01          	sub    $0x1,%rax
  18006e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  180074:	48 89 05 35 20 00 00 	mov    %rax,0x2035(%rip)        # 1820b0 <stack_bottom>
  18007b:	41 bc 00 10 00 00    	mov    $0x1000,%r12d
  180081:	eb 02                	jmp    180085 <process_main+0x85>
    asm volatile ("int %0" : /* no result */
  180083:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  180085:	e8 2b 02 00 00       	callq  1802b5 <rand>
  18008a:	89 c2                	mov    %eax,%edx
  18008c:	48 98                	cltq   
  18008e:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
  180095:	48 c1 f8 25          	sar    $0x25,%rax
  180099:	89 d1                	mov    %edx,%ecx
  18009b:	c1 f9 1f             	sar    $0x1f,%ecx
  18009e:	29 c8                	sub    %ecx,%eax
  1800a0:	6b c0 64             	imul   $0x64,%eax,%eax
  1800a3:	29 c2                	sub    %eax,%edx
  1800a5:	39 da                	cmp    %ebx,%edx
  1800a7:	7d da                	jge    180083 <process_main+0x83>
            if(heap_top == stack_bottom)
  1800a9:	48 8b 05 00 20 00 00 	mov    0x2000(%rip),%rax        # 1820b0 <stack_bottom>
  1800b0:	48 39 05 f1 1f 00 00 	cmp    %rax,0x1ff1(%rip)        # 1820a8 <heap_top>
  1800b7:	74 2a                	je     1800e3 <process_main+0xe3>
    asm volatile ("int %1" :  "=a" (result)
  1800b9:	4c 89 e7             	mov    %r12,%rdi
  1800bc:	cd 3a                	int    $0x3a
  1800be:	48 89 05 3b 1f 00 00 	mov    %rax,0x1f3b(%rip)        # 182000 <result.1424>
                break;
            void * ret = sys_sbrk(PAGESIZE);
            if(ret == (void *) -1)
  1800c5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1800c9:	74 18                	je     1800e3 <process_main+0xe3>
                break;
            *heap_top = p;      /* check we have write access to new page */
  1800cb:	48 8b 15 d6 1f 00 00 	mov    0x1fd6(%rip),%rdx        # 1820a8 <heap_top>
  1800d2:	88 1a                	mov    %bl,(%rdx)
            heap_top = (uint8_t *)ret + PAGESIZE;
  1800d4:	48 05 00 10 00 00    	add    $0x1000,%rax
  1800da:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 1820a8 <heap_top>
  1800e1:	eb a0                	jmp    180083 <process_main+0x83>
    asm volatile ("int %0" : /* no result */
  1800e3:	cd 32                	int    $0x32
  1800e5:	eb fc                	jmp    1800e3 <process_main+0xe3>

00000000001800e7 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1800e7:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1800ea:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  1800f1:	00 
  1800f2:	72 08                	jb     1800fc <console_putc+0x15>
        cp->cursor = console;
  1800f4:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  1800fb:	00 
    }
    if (c == '\n') {
  1800fc:	40 80 fe 0a          	cmp    $0xa,%sil
  180100:	74 17                	je     180119 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  180102:	48 8b 47 08          	mov    0x8(%rdi),%rax
  180106:	48 8d 50 02          	lea    0x2(%rax),%rdx
  18010a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  18010e:	40 0f b6 f6          	movzbl %sil,%esi
  180112:	44 09 c6             	or     %r8d,%esi
  180115:	66 89 30             	mov    %si,(%rax)
    }
}
  180118:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  180119:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  18011d:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  180124:	48 89 f1             	mov    %rsi,%rcx
  180127:	48 d1 f9             	sar    %rcx
  18012a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  180131:	66 66 66 
  180134:	48 89 c8             	mov    %rcx,%rax
  180137:	48 f7 ea             	imul   %rdx
  18013a:	48 c1 fa 05          	sar    $0x5,%rdx
  18013e:	48 c1 fe 3f          	sar    $0x3f,%rsi
  180142:	48 29 f2             	sub    %rsi,%rdx
  180145:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  180149:	48 c1 e0 04          	shl    $0x4,%rax
  18014d:	89 ca                	mov    %ecx,%edx
  18014f:	29 c2                	sub    %eax,%edx
  180151:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  180153:	44 89 c6             	mov    %r8d,%esi
  180156:	83 ce 20             	or     $0x20,%esi
  180159:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  18015d:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  180161:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  180165:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  180168:	83 c0 01             	add    $0x1,%eax
  18016b:	83 f8 50             	cmp    $0x50,%eax
  18016e:	75 e9                	jne    180159 <console_putc+0x72>
  180170:	c3                   	retq   

0000000000180171 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  180171:	48 8b 47 08          	mov    0x8(%rdi),%rax
  180175:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  180179:	73 0b                	jae    180186 <string_putc+0x15>
        *sp->s++ = c;
  18017b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  18017f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  180183:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  180186:	c3                   	retq   

0000000000180187 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  180187:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  18018a:	48 85 d2             	test   %rdx,%rdx
  18018d:	74 17                	je     1801a6 <memcpy+0x1f>
  18018f:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  180194:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  180199:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  18019d:	48 83 c1 01          	add    $0x1,%rcx
  1801a1:	48 39 d1             	cmp    %rdx,%rcx
  1801a4:	75 ee                	jne    180194 <memcpy+0xd>
}
  1801a6:	c3                   	retq   

00000000001801a7 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1801a7:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1801aa:	48 39 fe             	cmp    %rdi,%rsi
  1801ad:	72 1d                	jb     1801cc <memmove+0x25>
        while (n-- > 0) {
  1801af:	b9 00 00 00 00       	mov    $0x0,%ecx
  1801b4:	48 85 d2             	test   %rdx,%rdx
  1801b7:	74 12                	je     1801cb <memmove+0x24>
            *d++ = *s++;
  1801b9:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1801bd:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1801c1:	48 83 c1 01          	add    $0x1,%rcx
  1801c5:	48 39 ca             	cmp    %rcx,%rdx
  1801c8:	75 ef                	jne    1801b9 <memmove+0x12>
}
  1801ca:	c3                   	retq   
  1801cb:	c3                   	retq   
    if (s < d && s + n > d) {
  1801cc:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1801d0:	48 39 cf             	cmp    %rcx,%rdi
  1801d3:	73 da                	jae    1801af <memmove+0x8>
        while (n-- > 0) {
  1801d5:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1801d9:	48 85 d2             	test   %rdx,%rdx
  1801dc:	74 ec                	je     1801ca <memmove+0x23>
            *--d = *--s;
  1801de:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1801e2:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1801e5:	48 83 e9 01          	sub    $0x1,%rcx
  1801e9:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1801ed:	75 ef                	jne    1801de <memmove+0x37>
  1801ef:	c3                   	retq   

00000000001801f0 <memset>:
void* memset(void* v, int c, size_t n) {
  1801f0:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1801f3:	48 85 d2             	test   %rdx,%rdx
  1801f6:	74 13                	je     18020b <memset+0x1b>
  1801f8:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  1801fc:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  1801ff:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  180202:	48 83 c2 01          	add    $0x1,%rdx
  180206:	48 39 d1             	cmp    %rdx,%rcx
  180209:	75 f4                	jne    1801ff <memset+0xf>
}
  18020b:	c3                   	retq   

000000000018020c <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  18020c:	80 3f 00             	cmpb   $0x0,(%rdi)
  18020f:	74 10                	je     180221 <strlen+0x15>
  180211:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  180216:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  18021a:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  18021e:	75 f6                	jne    180216 <strlen+0xa>
  180220:	c3                   	retq   
  180221:	b8 00 00 00 00       	mov    $0x0,%eax
}
  180226:	c3                   	retq   

0000000000180227 <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  180227:	b8 00 00 00 00       	mov    $0x0,%eax
  18022c:	48 85 f6             	test   %rsi,%rsi
  18022f:	74 10                	je     180241 <strnlen+0x1a>
  180231:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  180235:	74 09                	je     180240 <strnlen+0x19>
        ++n;
  180237:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  18023b:	48 39 c6             	cmp    %rax,%rsi
  18023e:	75 f1                	jne    180231 <strnlen+0xa>
}
  180240:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  180241:	48 89 f0             	mov    %rsi,%rax
  180244:	c3                   	retq   

0000000000180245 <strcpy>:
char* strcpy(char* dst, const char* src) {
  180245:	48 89 f8             	mov    %rdi,%rax
  180248:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  18024d:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  180251:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  180254:	48 83 c2 01          	add    $0x1,%rdx
  180258:	84 c9                	test   %cl,%cl
  18025a:	75 f1                	jne    18024d <strcpy+0x8>
}
  18025c:	c3                   	retq   

000000000018025d <strcmp>:
    while (*a && *b && *a == *b) {
  18025d:	0f b6 17             	movzbl (%rdi),%edx
  180260:	84 d2                	test   %dl,%dl
  180262:	74 1a                	je     18027e <strcmp+0x21>
  180264:	0f b6 06             	movzbl (%rsi),%eax
  180267:	38 d0                	cmp    %dl,%al
  180269:	75 13                	jne    18027e <strcmp+0x21>
  18026b:	84 c0                	test   %al,%al
  18026d:	74 0f                	je     18027e <strcmp+0x21>
        ++a, ++b;
  18026f:	48 83 c7 01          	add    $0x1,%rdi
  180273:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  180277:	0f b6 17             	movzbl (%rdi),%edx
  18027a:	84 d2                	test   %dl,%dl
  18027c:	75 e6                	jne    180264 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  18027e:	0f b6 0e             	movzbl (%rsi),%ecx
  180281:	38 ca                	cmp    %cl,%dl
  180283:	0f 97 c0             	seta   %al
  180286:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  180289:	83 d8 00             	sbb    $0x0,%eax
}
  18028c:	c3                   	retq   

000000000018028d <strchr>:
    while (*s && *s != (char) c) {
  18028d:	0f b6 07             	movzbl (%rdi),%eax
  180290:	84 c0                	test   %al,%al
  180292:	74 10                	je     1802a4 <strchr+0x17>
  180294:	40 38 f0             	cmp    %sil,%al
  180297:	74 18                	je     1802b1 <strchr+0x24>
        ++s;
  180299:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  18029d:	0f b6 07             	movzbl (%rdi),%eax
  1802a0:	84 c0                	test   %al,%al
  1802a2:	75 f0                	jne    180294 <strchr+0x7>
        return NULL;
  1802a4:	40 84 f6             	test   %sil,%sil
  1802a7:	b8 00 00 00 00       	mov    $0x0,%eax
  1802ac:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1802b0:	c3                   	retq   
  1802b1:	48 89 f8             	mov    %rdi,%rax
  1802b4:	c3                   	retq   

00000000001802b5 <rand>:
    if (!rand_seed_set) {
  1802b5:	83 3d 50 1d 00 00 00 	cmpl   $0x0,0x1d50(%rip)        # 18200c <rand_seed_set>
  1802bc:	74 1b                	je     1802d9 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1802be:	69 05 40 1d 00 00 0d 	imul   $0x19660d,0x1d40(%rip),%eax        # 182008 <rand_seed>
  1802c5:	66 19 00 
  1802c8:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1802cd:	89 05 35 1d 00 00    	mov    %eax,0x1d35(%rip)        # 182008 <rand_seed>
    return rand_seed & RAND_MAX;
  1802d3:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1802d8:	c3                   	retq   
    rand_seed = seed;
  1802d9:	c7 05 25 1d 00 00 9e 	movl   $0x30d4879e,0x1d25(%rip)        # 182008 <rand_seed>
  1802e0:	87 d4 30 
    rand_seed_set = 1;
  1802e3:	c7 05 1f 1d 00 00 01 	movl   $0x1,0x1d1f(%rip)        # 18200c <rand_seed_set>
  1802ea:	00 00 00 
}
  1802ed:	eb cf                	jmp    1802be <rand+0x9>

00000000001802ef <srand>:
    rand_seed = seed;
  1802ef:	89 3d 13 1d 00 00    	mov    %edi,0x1d13(%rip)        # 182008 <rand_seed>
    rand_seed_set = 1;
  1802f5:	c7 05 0d 1d 00 00 01 	movl   $0x1,0x1d0d(%rip)        # 18200c <rand_seed_set>
  1802fc:	00 00 00 
}
  1802ff:	c3                   	retq   

0000000000180300 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  180300:	55                   	push   %rbp
  180301:	48 89 e5             	mov    %rsp,%rbp
  180304:	41 57                	push   %r15
  180306:	41 56                	push   %r14
  180308:	41 55                	push   %r13
  18030a:	41 54                	push   %r12
  18030c:	53                   	push   %rbx
  18030d:	48 83 ec 58          	sub    $0x58,%rsp
  180311:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  180315:	0f b6 02             	movzbl (%rdx),%eax
  180318:	84 c0                	test   %al,%al
  18031a:	0f 84 ba 06 00 00    	je     1809da <printer_vprintf+0x6da>
  180320:	49 89 fe             	mov    %rdi,%r14
  180323:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  180326:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  18032d:	41 89 f7             	mov    %esi,%r15d
  180330:	e9 a5 04 00 00       	jmpq   1807da <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  180335:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  18033a:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  180340:	45 84 e4             	test   %r12b,%r12b
  180343:	0f 84 85 06 00 00    	je     1809ce <printer_vprintf+0x6ce>
        int flags = 0;
  180349:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  18034f:	41 0f be f4          	movsbl %r12b,%esi
  180353:	bf 21 10 18 00       	mov    $0x181021,%edi
  180358:	e8 30 ff ff ff       	callq  18028d <strchr>
  18035d:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  180360:	48 85 c0             	test   %rax,%rax
  180363:	74 55                	je     1803ba <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  180365:	48 81 e9 21 10 18 00 	sub    $0x181021,%rcx
  18036c:	b8 01 00 00 00       	mov    $0x1,%eax
  180371:	d3 e0                	shl    %cl,%eax
  180373:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  180376:	48 83 c3 01          	add    $0x1,%rbx
  18037a:	44 0f b6 23          	movzbl (%rbx),%r12d
  18037e:	45 84 e4             	test   %r12b,%r12b
  180381:	75 cc                	jne    18034f <printer_vprintf+0x4f>
  180383:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  180387:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  18038d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  180394:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  180397:	0f 84 a9 00 00 00    	je     180446 <printer_vprintf+0x146>
        int length = 0;
  18039d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1803a2:	0f b6 13             	movzbl (%rbx),%edx
  1803a5:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1803a8:	3c 37                	cmp    $0x37,%al
  1803aa:	0f 87 c5 04 00 00    	ja     180875 <printer_vprintf+0x575>
  1803b0:	0f b6 c0             	movzbl %al,%eax
  1803b3:	ff 24 c5 30 0e 18 00 	jmpq   *0x180e30(,%rax,8)
  1803ba:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  1803be:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1803c3:	3c 08                	cmp    $0x8,%al
  1803c5:	77 2f                	ja     1803f6 <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1803c7:	0f b6 03             	movzbl (%rbx),%eax
  1803ca:	8d 50 d0             	lea    -0x30(%rax),%edx
  1803cd:	80 fa 09             	cmp    $0x9,%dl
  1803d0:	77 5e                	ja     180430 <printer_vprintf+0x130>
  1803d2:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1803d8:	48 83 c3 01          	add    $0x1,%rbx
  1803dc:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1803e1:	0f be c0             	movsbl %al,%eax
  1803e4:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1803e9:	0f b6 03             	movzbl (%rbx),%eax
  1803ec:	8d 50 d0             	lea    -0x30(%rax),%edx
  1803ef:	80 fa 09             	cmp    $0x9,%dl
  1803f2:	76 e4                	jbe    1803d8 <printer_vprintf+0xd8>
  1803f4:	eb 97                	jmp    18038d <printer_vprintf+0x8d>
        } else if (*format == '*') {
  1803f6:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1803fa:	75 3f                	jne    18043b <printer_vprintf+0x13b>
            width = va_arg(val, int);
  1803fc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180400:	8b 01                	mov    (%rcx),%eax
  180402:	83 f8 2f             	cmp    $0x2f,%eax
  180405:	77 17                	ja     18041e <printer_vprintf+0x11e>
  180407:	89 c2                	mov    %eax,%edx
  180409:	48 03 51 10          	add    0x10(%rcx),%rdx
  18040d:	83 c0 08             	add    $0x8,%eax
  180410:	89 01                	mov    %eax,(%rcx)
  180412:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  180415:	48 83 c3 01          	add    $0x1,%rbx
  180419:	e9 6f ff ff ff       	jmpq   18038d <printer_vprintf+0x8d>
            width = va_arg(val, int);
  18041e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180422:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  180426:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18042a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  18042e:	eb e2                	jmp    180412 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  180430:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  180436:	e9 52 ff ff ff       	jmpq   18038d <printer_vprintf+0x8d>
        int width = -1;
  18043b:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  180441:	e9 47 ff ff ff       	jmpq   18038d <printer_vprintf+0x8d>
            ++format;
  180446:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  18044a:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  18044e:	8d 48 d0             	lea    -0x30(%rax),%ecx
  180451:	80 f9 09             	cmp    $0x9,%cl
  180454:	76 13                	jbe    180469 <printer_vprintf+0x169>
            } else if (*format == '*') {
  180456:	3c 2a                	cmp    $0x2a,%al
  180458:	74 32                	je     18048c <printer_vprintf+0x18c>
            ++format;
  18045a:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  18045d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  180464:	e9 34 ff ff ff       	jmpq   18039d <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  180469:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  18046e:	48 83 c2 01          	add    $0x1,%rdx
  180472:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  180475:	0f be c0             	movsbl %al,%eax
  180478:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  18047c:	0f b6 02             	movzbl (%rdx),%eax
  18047f:	8d 48 d0             	lea    -0x30(%rax),%ecx
  180482:	80 f9 09             	cmp    $0x9,%cl
  180485:	76 e7                	jbe    18046e <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  180487:	48 89 d3             	mov    %rdx,%rbx
  18048a:	eb 1c                	jmp    1804a8 <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  18048c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180490:	8b 07                	mov    (%rdi),%eax
  180492:	83 f8 2f             	cmp    $0x2f,%eax
  180495:	77 23                	ja     1804ba <printer_vprintf+0x1ba>
  180497:	89 c2                	mov    %eax,%edx
  180499:	48 03 57 10          	add    0x10(%rdi),%rdx
  18049d:	83 c0 08             	add    $0x8,%eax
  1804a0:	89 07                	mov    %eax,(%rdi)
  1804a2:	8b 32                	mov    (%rdx),%esi
                ++format;
  1804a4:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1804a8:	85 f6                	test   %esi,%esi
  1804aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1804af:	0f 48 f0             	cmovs  %eax,%esi
  1804b2:	89 75 9c             	mov    %esi,-0x64(%rbp)
  1804b5:	e9 e3 fe ff ff       	jmpq   18039d <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  1804ba:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1804be:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1804c2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1804c6:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1804ca:	eb d6                	jmp    1804a2 <printer_vprintf+0x1a2>
        switch (*format) {
  1804cc:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1804d1:	e9 f1 00 00 00       	jmpq   1805c7 <printer_vprintf+0x2c7>
            ++format;
  1804d6:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1804da:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  1804dd:	e9 c0 fe ff ff       	jmpq   1803a2 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1804e2:	85 c9                	test   %ecx,%ecx
  1804e4:	74 55                	je     18053b <printer_vprintf+0x23b>
  1804e6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1804ea:	8b 01                	mov    (%rcx),%eax
  1804ec:	83 f8 2f             	cmp    $0x2f,%eax
  1804ef:	77 38                	ja     180529 <printer_vprintf+0x229>
  1804f1:	89 c2                	mov    %eax,%edx
  1804f3:	48 03 51 10          	add    0x10(%rcx),%rdx
  1804f7:	83 c0 08             	add    $0x8,%eax
  1804fa:	89 01                	mov    %eax,(%rcx)
  1804fc:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1804ff:	48 89 d0             	mov    %rdx,%rax
  180502:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  180506:	49 89 d0             	mov    %rdx,%r8
  180509:	49 f7 d8             	neg    %r8
  18050c:	25 80 00 00 00       	and    $0x80,%eax
  180511:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  180515:	0b 45 a8             	or     -0x58(%rbp),%eax
  180518:	83 c8 60             	or     $0x60,%eax
  18051b:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  18051e:	41 bc 30 10 18 00    	mov    $0x181030,%r12d
            break;
  180524:	e9 35 01 00 00       	jmpq   18065e <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  180529:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  18052d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  180531:	48 8d 42 08          	lea    0x8(%rdx),%rax
  180535:	48 89 47 08          	mov    %rax,0x8(%rdi)
  180539:	eb c1                	jmp    1804fc <printer_vprintf+0x1fc>
  18053b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  18053f:	8b 07                	mov    (%rdi),%eax
  180541:	83 f8 2f             	cmp    $0x2f,%eax
  180544:	77 10                	ja     180556 <printer_vprintf+0x256>
  180546:	89 c2                	mov    %eax,%edx
  180548:	48 03 57 10          	add    0x10(%rdi),%rdx
  18054c:	83 c0 08             	add    $0x8,%eax
  18054f:	89 07                	mov    %eax,(%rdi)
  180551:	48 63 12             	movslq (%rdx),%rdx
  180554:	eb a9                	jmp    1804ff <printer_vprintf+0x1ff>
  180556:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  18055a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  18055e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  180562:	48 89 41 08          	mov    %rax,0x8(%rcx)
  180566:	eb e9                	jmp    180551 <printer_vprintf+0x251>
        int base = 10;
  180568:	be 0a 00 00 00       	mov    $0xa,%esi
  18056d:	eb 58                	jmp    1805c7 <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  18056f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180573:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  180577:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18057b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  18057f:	eb 60                	jmp    1805e1 <printer_vprintf+0x2e1>
  180581:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180585:	8b 01                	mov    (%rcx),%eax
  180587:	83 f8 2f             	cmp    $0x2f,%eax
  18058a:	77 10                	ja     18059c <printer_vprintf+0x29c>
  18058c:	89 c2                	mov    %eax,%edx
  18058e:	48 03 51 10          	add    0x10(%rcx),%rdx
  180592:	83 c0 08             	add    $0x8,%eax
  180595:	89 01                	mov    %eax,(%rcx)
  180597:	44 8b 02             	mov    (%rdx),%r8d
  18059a:	eb 48                	jmp    1805e4 <printer_vprintf+0x2e4>
  18059c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1805a0:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1805a4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1805a8:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1805ac:	eb e9                	jmp    180597 <printer_vprintf+0x297>
  1805ae:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1805b1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1805b8:	bf 10 10 18 00       	mov    $0x181010,%edi
  1805bd:	e9 e6 02 00 00       	jmpq   1808a8 <printer_vprintf+0x5a8>
            base = 16;
  1805c2:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1805c7:	85 c9                	test   %ecx,%ecx
  1805c9:	74 b6                	je     180581 <printer_vprintf+0x281>
  1805cb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1805cf:	8b 07                	mov    (%rdi),%eax
  1805d1:	83 f8 2f             	cmp    $0x2f,%eax
  1805d4:	77 99                	ja     18056f <printer_vprintf+0x26f>
  1805d6:	89 c2                	mov    %eax,%edx
  1805d8:	48 03 57 10          	add    0x10(%rdi),%rdx
  1805dc:	83 c0 08             	add    $0x8,%eax
  1805df:	89 07                	mov    %eax,(%rdi)
  1805e1:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1805e4:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1805e8:	85 f6                	test   %esi,%esi
  1805ea:	79 c2                	jns    1805ae <printer_vprintf+0x2ae>
        base = -base;
  1805ec:	41 89 f1             	mov    %esi,%r9d
  1805ef:	f7 de                	neg    %esi
  1805f1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1805f8:	bf f0 0f 18 00       	mov    $0x180ff0,%edi
  1805fd:	e9 a6 02 00 00       	jmpq   1808a8 <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  180602:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180606:	8b 07                	mov    (%rdi),%eax
  180608:	83 f8 2f             	cmp    $0x2f,%eax
  18060b:	77 1c                	ja     180629 <printer_vprintf+0x329>
  18060d:	89 c2                	mov    %eax,%edx
  18060f:	48 03 57 10          	add    0x10(%rdi),%rdx
  180613:	83 c0 08             	add    $0x8,%eax
  180616:	89 07                	mov    %eax,(%rdi)
  180618:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  18061b:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  180622:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  180627:	eb c3                	jmp    1805ec <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  180629:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  18062d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  180631:	48 8d 42 08          	lea    0x8(%rdx),%rax
  180635:	48 89 41 08          	mov    %rax,0x8(%rcx)
  180639:	eb dd                	jmp    180618 <printer_vprintf+0x318>
            data = va_arg(val, char*);
  18063b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  18063f:	8b 01                	mov    (%rcx),%eax
  180641:	83 f8 2f             	cmp    $0x2f,%eax
  180644:	0f 87 a9 01 00 00    	ja     1807f3 <printer_vprintf+0x4f3>
  18064a:	89 c2                	mov    %eax,%edx
  18064c:	48 03 51 10          	add    0x10(%rcx),%rdx
  180650:	83 c0 08             	add    $0x8,%eax
  180653:	89 01                	mov    %eax,(%rcx)
  180655:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  180658:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  18065e:	8b 45 a8             	mov    -0x58(%rbp),%eax
  180661:	83 e0 20             	and    $0x20,%eax
  180664:	89 45 8c             	mov    %eax,-0x74(%rbp)
  180667:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  18066d:	0f 85 25 02 00 00    	jne    180898 <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  180673:	8b 45 a8             	mov    -0x58(%rbp),%eax
  180676:	89 45 88             	mov    %eax,-0x78(%rbp)
  180679:	83 e0 60             	and    $0x60,%eax
  18067c:	83 f8 60             	cmp    $0x60,%eax
  18067f:	0f 84 58 02 00 00    	je     1808dd <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  180685:	8b 45 a8             	mov    -0x58(%rbp),%eax
  180688:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  18068b:	48 c7 45 a0 30 10 18 	movq   $0x181030,-0x60(%rbp)
  180692:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  180693:	83 f8 21             	cmp    $0x21,%eax
  180696:	0f 84 7d 02 00 00    	je     180919 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  18069c:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  18069f:	89 c8                	mov    %ecx,%eax
  1806a1:	f7 d0                	not    %eax
  1806a3:	c1 e8 1f             	shr    $0x1f,%eax
  1806a6:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1806a9:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1806ad:	0f 85 a2 02 00 00    	jne    180955 <printer_vprintf+0x655>
  1806b3:	84 c0                	test   %al,%al
  1806b5:	0f 84 9a 02 00 00    	je     180955 <printer_vprintf+0x655>
            len = strnlen(data, precision);
  1806bb:	48 63 f1             	movslq %ecx,%rsi
  1806be:	4c 89 e7             	mov    %r12,%rdi
  1806c1:	e8 61 fb ff ff       	callq  180227 <strnlen>
  1806c6:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1806c9:	8b 45 88             	mov    -0x78(%rbp),%eax
  1806cc:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1806cf:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1806d6:	83 f8 22             	cmp    $0x22,%eax
  1806d9:	0f 84 ae 02 00 00    	je     18098d <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  1806df:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1806e3:	e8 24 fb ff ff       	callq  18020c <strlen>
  1806e8:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1806eb:	03 55 98             	add    -0x68(%rbp),%edx
  1806ee:	41 29 d5             	sub    %edx,%r13d
  1806f1:	44 89 ea             	mov    %r13d,%edx
  1806f4:	29 c2                	sub    %eax,%edx
  1806f6:	89 55 8c             	mov    %edx,-0x74(%rbp)
  1806f9:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1806fc:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  180700:	75 2d                	jne    18072f <printer_vprintf+0x42f>
  180702:	85 d2                	test   %edx,%edx
  180704:	7e 29                	jle    18072f <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  180706:	44 89 fa             	mov    %r15d,%edx
  180709:	be 20 00 00 00       	mov    $0x20,%esi
  18070e:	4c 89 f7             	mov    %r14,%rdi
  180711:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  180714:	41 83 ed 01          	sub    $0x1,%r13d
  180718:	45 85 ed             	test   %r13d,%r13d
  18071b:	7f e9                	jg     180706 <printer_vprintf+0x406>
  18071d:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  180720:	85 ff                	test   %edi,%edi
  180722:	b8 01 00 00 00       	mov    $0x1,%eax
  180727:	0f 4f c7             	cmovg  %edi,%eax
  18072a:	29 c7                	sub    %eax,%edi
  18072c:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  18072f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  180733:	0f b6 01             	movzbl (%rcx),%eax
  180736:	84 c0                	test   %al,%al
  180738:	74 22                	je     18075c <printer_vprintf+0x45c>
  18073a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  18073e:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  180741:	0f b6 f0             	movzbl %al,%esi
  180744:	44 89 fa             	mov    %r15d,%edx
  180747:	4c 89 f7             	mov    %r14,%rdi
  18074a:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  18074d:	48 83 c3 01          	add    $0x1,%rbx
  180751:	0f b6 03             	movzbl (%rbx),%eax
  180754:	84 c0                	test   %al,%al
  180756:	75 e9                	jne    180741 <printer_vprintf+0x441>
  180758:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  18075c:	8b 45 9c             	mov    -0x64(%rbp),%eax
  18075f:	85 c0                	test   %eax,%eax
  180761:	7e 1d                	jle    180780 <printer_vprintf+0x480>
  180763:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  180767:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  180769:	44 89 fa             	mov    %r15d,%edx
  18076c:	be 30 00 00 00       	mov    $0x30,%esi
  180771:	4c 89 f7             	mov    %r14,%rdi
  180774:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  180777:	83 eb 01             	sub    $0x1,%ebx
  18077a:	75 ed                	jne    180769 <printer_vprintf+0x469>
  18077c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  180780:	8b 45 98             	mov    -0x68(%rbp),%eax
  180783:	85 c0                	test   %eax,%eax
  180785:	7e 2a                	jle    1807b1 <printer_vprintf+0x4b1>
  180787:	8d 40 ff             	lea    -0x1(%rax),%eax
  18078a:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  18078f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  180793:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  180796:	41 0f b6 34 24       	movzbl (%r12),%esi
  18079b:	44 89 fa             	mov    %r15d,%edx
  18079e:	4c 89 f7             	mov    %r14,%rdi
  1807a1:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1807a4:	49 83 c4 01          	add    $0x1,%r12
  1807a8:	49 39 dc             	cmp    %rbx,%r12
  1807ab:	75 e9                	jne    180796 <printer_vprintf+0x496>
  1807ad:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1807b1:	45 85 ed             	test   %r13d,%r13d
  1807b4:	7e 14                	jle    1807ca <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  1807b6:	44 89 fa             	mov    %r15d,%edx
  1807b9:	be 20 00 00 00       	mov    $0x20,%esi
  1807be:	4c 89 f7             	mov    %r14,%rdi
  1807c1:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1807c4:	41 83 ed 01          	sub    $0x1,%r13d
  1807c8:	75 ec                	jne    1807b6 <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  1807ca:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1807ce:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1807d2:	84 c0                	test   %al,%al
  1807d4:	0f 84 00 02 00 00    	je     1809da <printer_vprintf+0x6da>
        if (*format != '%') {
  1807da:	3c 25                	cmp    $0x25,%al
  1807dc:	0f 84 53 fb ff ff    	je     180335 <printer_vprintf+0x35>
            p->putc(p, *format, color);
  1807e2:	0f b6 f0             	movzbl %al,%esi
  1807e5:	44 89 fa             	mov    %r15d,%edx
  1807e8:	4c 89 f7             	mov    %r14,%rdi
  1807eb:	41 ff 16             	callq  *(%r14)
            continue;
  1807ee:	4c 89 e3             	mov    %r12,%rbx
  1807f1:	eb d7                	jmp    1807ca <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  1807f3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1807f7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1807fb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1807ff:	48 89 47 08          	mov    %rax,0x8(%rdi)
  180803:	e9 4d fe ff ff       	jmpq   180655 <printer_vprintf+0x355>
            color = va_arg(val, int);
  180808:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  18080c:	8b 07                	mov    (%rdi),%eax
  18080e:	83 f8 2f             	cmp    $0x2f,%eax
  180811:	77 10                	ja     180823 <printer_vprintf+0x523>
  180813:	89 c2                	mov    %eax,%edx
  180815:	48 03 57 10          	add    0x10(%rdi),%rdx
  180819:	83 c0 08             	add    $0x8,%eax
  18081c:	89 07                	mov    %eax,(%rdi)
  18081e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  180821:	eb a7                	jmp    1807ca <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  180823:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180827:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  18082b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18082f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  180833:	eb e9                	jmp    18081e <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  180835:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  180839:	8b 01                	mov    (%rcx),%eax
  18083b:	83 f8 2f             	cmp    $0x2f,%eax
  18083e:	77 23                	ja     180863 <printer_vprintf+0x563>
  180840:	89 c2                	mov    %eax,%edx
  180842:	48 03 51 10          	add    0x10(%rcx),%rdx
  180846:	83 c0 08             	add    $0x8,%eax
  180849:	89 01                	mov    %eax,(%rcx)
  18084b:	8b 02                	mov    (%rdx),%eax
  18084d:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  180850:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  180854:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  180858:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  18085e:	e9 fb fd ff ff       	jmpq   18065e <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  180863:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  180867:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  18086b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  18086f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  180873:	eb d6                	jmp    18084b <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  180875:	84 d2                	test   %dl,%dl
  180877:	0f 85 3b 01 00 00    	jne    1809b8 <printer_vprintf+0x6b8>
  18087d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  180881:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  180885:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  180889:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  18088d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  180893:	e9 c6 fd ff ff       	jmpq   18065e <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  180898:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  18089e:	bf 10 10 18 00       	mov    $0x181010,%edi
        if (flags & FLAG_NUMERIC) {
  1808a3:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1808a8:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1808ac:	4c 89 c1             	mov    %r8,%rcx
  1808af:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1808b3:	48 63 f6             	movslq %esi,%rsi
  1808b6:	49 83 ec 01          	sub    $0x1,%r12
  1808ba:	48 89 c8             	mov    %rcx,%rax
  1808bd:	ba 00 00 00 00       	mov    $0x0,%edx
  1808c2:	48 f7 f6             	div    %rsi
  1808c5:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1808c9:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1808cd:	48 89 ca             	mov    %rcx,%rdx
  1808d0:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1808d3:	48 39 d6             	cmp    %rdx,%rsi
  1808d6:	76 de                	jbe    1808b6 <printer_vprintf+0x5b6>
  1808d8:	e9 96 fd ff ff       	jmpq   180673 <printer_vprintf+0x373>
                prefix = "-";
  1808dd:	48 c7 45 a0 27 0e 18 	movq   $0x180e27,-0x60(%rbp)
  1808e4:	00 
            if (flags & FLAG_NEGATIVE) {
  1808e5:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1808e8:	a8 80                	test   $0x80,%al
  1808ea:	0f 85 ac fd ff ff    	jne    18069c <printer_vprintf+0x39c>
                prefix = "+";
  1808f0:	48 c7 45 a0 25 0e 18 	movq   $0x180e25,-0x60(%rbp)
  1808f7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1808f8:	a8 10                	test   $0x10,%al
  1808fa:	0f 85 9c fd ff ff    	jne    18069c <printer_vprintf+0x39c>
                prefix = " ";
  180900:	a8 08                	test   $0x8,%al
  180902:	ba 30 10 18 00       	mov    $0x181030,%edx
  180907:	b8 2d 10 18 00       	mov    $0x18102d,%eax
  18090c:	48 0f 44 c2          	cmove  %rdx,%rax
  180910:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  180914:	e9 83 fd ff ff       	jmpq   18069c <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  180919:	41 8d 41 10          	lea    0x10(%r9),%eax
  18091d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  180922:	0f 85 74 fd ff ff    	jne    18069c <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  180928:	4d 85 c0             	test   %r8,%r8
  18092b:	75 0d                	jne    18093a <printer_vprintf+0x63a>
  18092d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  180934:	0f 84 62 fd ff ff    	je     18069c <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  18093a:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  18093e:	ba 22 0e 18 00       	mov    $0x180e22,%edx
  180943:	b8 29 0e 18 00       	mov    $0x180e29,%eax
  180948:	48 0f 44 c2          	cmove  %rdx,%rax
  18094c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  180950:	e9 47 fd ff ff       	jmpq   18069c <printer_vprintf+0x39c>
            len = strlen(data);
  180955:	4c 89 e7             	mov    %r12,%rdi
  180958:	e8 af f8 ff ff       	callq  18020c <strlen>
  18095d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  180960:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  180964:	0f 84 5f fd ff ff    	je     1806c9 <printer_vprintf+0x3c9>
  18096a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  18096e:	0f 84 55 fd ff ff    	je     1806c9 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  180974:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  180977:	89 fa                	mov    %edi,%edx
  180979:	29 c2                	sub    %eax,%edx
  18097b:	39 c7                	cmp    %eax,%edi
  18097d:	b8 00 00 00 00       	mov    $0x0,%eax
  180982:	0f 4e d0             	cmovle %eax,%edx
  180985:	89 55 9c             	mov    %edx,-0x64(%rbp)
  180988:	e9 52 fd ff ff       	jmpq   1806df <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  18098d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  180991:	e8 76 f8 ff ff       	callq  18020c <strlen>
  180996:	8b 7d 98             	mov    -0x68(%rbp),%edi
  180999:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  18099c:	44 89 e9             	mov    %r13d,%ecx
  18099f:	29 f9                	sub    %edi,%ecx
  1809a1:	29 c1                	sub    %eax,%ecx
  1809a3:	89 c8                	mov    %ecx,%eax
  1809a5:	44 39 ea             	cmp    %r13d,%edx
  1809a8:	b9 00 00 00 00       	mov    $0x0,%ecx
  1809ad:	0f 4d c1             	cmovge %ecx,%eax
  1809b0:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1809b3:	e9 27 fd ff ff       	jmpq   1806df <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  1809b8:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1809bb:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1809bf:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1809c3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1809c9:	e9 90 fc ff ff       	jmpq   18065e <printer_vprintf+0x35e>
        int flags = 0;
  1809ce:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1809d5:	e9 ad f9 ff ff       	jmpq   180387 <printer_vprintf+0x87>
}
  1809da:	48 83 c4 58          	add    $0x58,%rsp
  1809de:	5b                   	pop    %rbx
  1809df:	41 5c                	pop    %r12
  1809e1:	41 5d                	pop    %r13
  1809e3:	41 5e                	pop    %r14
  1809e5:	41 5f                	pop    %r15
  1809e7:	5d                   	pop    %rbp
  1809e8:	c3                   	retq   

00000000001809e9 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1809e9:	55                   	push   %rbp
  1809ea:	48 89 e5             	mov    %rsp,%rbp
  1809ed:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  1809f1:	48 c7 45 f0 e7 00 18 	movq   $0x1800e7,-0x10(%rbp)
  1809f8:	00 
        cpos = 0;
  1809f9:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1809ff:	b8 00 00 00 00       	mov    $0x0,%eax
  180a04:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  180a07:	48 63 ff             	movslq %edi,%rdi
  180a0a:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  180a11:	00 
  180a12:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  180a16:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  180a1a:	e8 e1 f8 ff ff       	callq  180300 <printer_vprintf>
    return cp.cursor - console;
  180a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  180a23:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  180a29:	48 d1 f8             	sar    %rax
}
  180a2c:	c9                   	leaveq 
  180a2d:	c3                   	retq   

0000000000180a2e <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  180a2e:	55                   	push   %rbp
  180a2f:	48 89 e5             	mov    %rsp,%rbp
  180a32:	48 83 ec 50          	sub    $0x50,%rsp
  180a36:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  180a3a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  180a3e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  180a42:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  180a49:	48 8d 45 10          	lea    0x10(%rbp),%rax
  180a4d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  180a51:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  180a55:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  180a59:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  180a5d:	e8 87 ff ff ff       	callq  1809e9 <console_vprintf>
}
  180a62:	c9                   	leaveq 
  180a63:	c3                   	retq   

0000000000180a64 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  180a64:	55                   	push   %rbp
  180a65:	48 89 e5             	mov    %rsp,%rbp
  180a68:	53                   	push   %rbx
  180a69:	48 83 ec 28          	sub    $0x28,%rsp
  180a6d:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  180a70:	48 c7 45 d8 71 01 18 	movq   $0x180171,-0x28(%rbp)
  180a77:	00 
    sp.s = s;
  180a78:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  180a7c:	48 85 f6             	test   %rsi,%rsi
  180a7f:	75 0e                	jne    180a8f <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  180a81:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  180a85:	48 29 d8             	sub    %rbx,%rax
}
  180a88:	48 83 c4 28          	add    $0x28,%rsp
  180a8c:	5b                   	pop    %rbx
  180a8d:	5d                   	pop    %rbp
  180a8e:	c3                   	retq   
        sp.end = s + size - 1;
  180a8f:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  180a94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  180a98:	be 00 00 00 00       	mov    $0x0,%esi
  180a9d:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  180aa1:	e8 5a f8 ff ff       	callq  180300 <printer_vprintf>
        *sp.s = 0;
  180aa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  180aaa:	c6 00 00             	movb   $0x0,(%rax)
  180aad:	eb d2                	jmp    180a81 <vsnprintf+0x1d>

0000000000180aaf <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  180aaf:	55                   	push   %rbp
  180ab0:	48 89 e5             	mov    %rsp,%rbp
  180ab3:	48 83 ec 50          	sub    $0x50,%rsp
  180ab7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  180abb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  180abf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  180ac3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  180aca:	48 8d 45 10          	lea    0x10(%rbp),%rax
  180ace:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  180ad2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  180ad6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  180ada:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  180ade:	e8 81 ff ff ff       	callq  180a64 <vsnprintf>
    va_end(val);
    return n;
}
  180ae3:	c9                   	leaveq 
  180ae4:	c3                   	retq   

0000000000180ae5 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  180ae5:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  180aea:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  180aef:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  180af4:	48 83 c0 02          	add    $0x2,%rax
  180af8:	48 39 d0             	cmp    %rdx,%rax
  180afb:	75 f2                	jne    180aef <console_clear+0xa>
    }
    cursorpos = 0;
  180afd:	c7 05 f5 84 f3 ff 00 	movl   $0x0,-0xc7b0b(%rip)        # b8ffc <cursorpos>
  180b04:	00 00 00 
}
  180b07:	c3                   	retq   

0000000000180b08 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  180b08:	55                   	push   %rbp
  180b09:	48 89 e5             	mov    %rsp,%rbp
  180b0c:	48 83 ec 50          	sub    $0x50,%rsp
  180b10:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  180b14:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  180b18:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  180b1c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  180b20:	b8 00 07 00 00       	mov    $0x700,%eax
    if (colorid < 0) {
  180b25:	85 ff                	test   %edi,%edi
  180b27:	78 2e                	js     180b57 <app_printf+0x4f>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  180b29:	48 63 ff             	movslq %edi,%rdi
  180b2c:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  180b33:	cc cc cc 
  180b36:	48 89 f8             	mov    %rdi,%rax
  180b39:	48 f7 e2             	mul    %rdx
  180b3c:	48 89 d0             	mov    %rdx,%rax
  180b3f:	48 c1 e8 02          	shr    $0x2,%rax
  180b43:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  180b47:	48 01 c2             	add    %rax,%rdx
  180b4a:	48 29 d7             	sub    %rdx,%rdi
  180b4d:	0f b6 87 60 10 18 00 	movzbl 0x181060(%rdi),%eax
  180b54:	c1 e0 08             	shl    $0x8,%eax
    }

    va_list val;
    va_start(val, format);
  180b57:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  180b5e:	48 8d 4d 10          	lea    0x10(%rbp),%rcx
  180b62:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  180b66:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  180b6a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  180b6e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  180b72:	48 89 f2             	mov    %rsi,%rdx
  180b75:	89 c6                	mov    %eax,%esi
  180b77:	8b 3d 7f 84 f3 ff    	mov    -0xc7b81(%rip),%edi        # b8ffc <cursorpos>
  180b7d:	e8 67 fe ff ff       	callq  1809e9 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  180b82:	3d 30 07 00 00       	cmp    $0x730,%eax
  180b87:	ba 00 00 00 00       	mov    $0x0,%edx
  180b8c:	0f 4d c2             	cmovge %edx,%eax
  180b8f:	89 05 67 84 f3 ff    	mov    %eax,-0xc7b99(%rip)        # b8ffc <cursorpos>
    }
}
  180b95:	c9                   	leaveq 
  180b96:	c3                   	retq   

0000000000180b97 <read_line>:
    return result;
}

// read_line
// str should be at least max_chars + 1 byte
int read_line(char * str, int max_chars){
  180b97:	55                   	push   %rbp
  180b98:	48 89 e5             	mov    %rsp,%rbp
  180b9b:	41 56                	push   %r14
  180b9d:	41 55                	push   %r13
  180b9f:	41 54                	push   %r12
  180ba1:	53                   	push   %rbx
  180ba2:	49 89 fd             	mov    %rdi,%r13
  180ba5:	89 f3                	mov    %esi,%ebx
    static char cache[128];
    static int index = 0;
    static int length = 0;

    if(max_chars == 0){
  180ba7:	85 f6                	test   %esi,%esi
  180ba9:	0f 84 8b 00 00 00    	je     180c3a <read_line+0xa3>
        str[max_chars] = '\0';
        return 0;
    }
    str[max_chars + 1] = '\0';
  180baf:	4c 63 f6             	movslq %esi,%r14
  180bb2:	42 c6 44 37 01 00    	movb   $0x0,0x1(%rdi,%r14,1)

    if(index < length){
  180bb8:	8b 3d e6 14 00 00    	mov    0x14e6(%rip),%edi        # 1820a4 <index.1465>
  180bbe:	8b 15 dc 14 00 00    	mov    0x14dc(%rip),%edx        # 1820a0 <length.1466>
  180bc4:	39 d7                	cmp    %edx,%edi
  180bc6:	0f 8d f0 00 00 00    	jge    180cbc <read_line+0x125>
        // some cache left
        int i = 0;
        for(i = index;
                i < length && (i - index + 1 < max_chars);
  180bcc:	83 fe 01             	cmp    $0x1,%esi
  180bcf:	7e 3b                	jle    180c0c <read_line+0x75>
  180bd1:	4c 63 cf             	movslq %edi,%r9
  180bd4:	8d 46 fe             	lea    -0x2(%rsi),%eax
  180bd7:	4d 8d 44 01 01       	lea    0x1(%r9,%rax,1),%r8
  180bdc:	8d 42 ff             	lea    -0x1(%rdx),%eax
  180bdf:	29 f8                	sub    %edi,%eax
  180be1:	4c 01 c8             	add    %r9,%rax
  180be4:	4c 89 c9             	mov    %r9,%rcx
  180be7:	be 01 00 00 00       	mov    $0x1,%esi
  180bec:	29 fe                	sub    %edi,%esi
  180bee:	41 89 cc             	mov    %ecx,%r12d
  180bf1:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
                i++){
            if(cache[i] == '\n'){
  180bf5:	80 b9 20 20 18 00 0a 	cmpb   $0xa,0x182020(%rcx)
  180bfc:	74 4a                	je     180c48 <read_line+0xb1>
        for(i = index;
  180bfe:	48 39 c1             	cmp    %rax,%rcx
  180c01:	74 09                	je     180c0c <read_line+0x75>
  180c03:	48 83 c1 01          	add    $0x1,%rcx
                i < length && (i - index + 1 < max_chars);
  180c07:	4c 39 c1             	cmp    %r8,%rcx
  180c0a:	75 e2                	jne    180bee <read_line+0x57>
                int len = i - index + 1;
                index = i + 1;
                return len;
            }
        }
        if(max_chars <= length - index + 1){
  180c0c:	29 fa                	sub    %edi,%edx
  180c0e:	8d 42 01             	lea    0x1(%rdx),%eax
  180c11:	39 d8                	cmp    %ebx,%eax
  180c13:	7c 67                	jl     180c7c <read_line+0xe5>
            // copy max_chars - 1 bytes and return
            memcpy(str, cache + index, max_chars);
  180c15:	48 63 f7             	movslq %edi,%rsi
  180c18:	48 81 c6 20 20 18 00 	add    $0x182020,%rsi
  180c1f:	4c 89 f2             	mov    %r14,%rdx
  180c22:	4c 89 ef             	mov    %r13,%rdi
  180c25:	e8 5d f5 ff ff       	callq  180187 <memcpy>
            str[max_chars] = '\0';
  180c2a:	43 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%r14,1)
            //app_printf(1, "[%d, %d]-> %sxx", index, index + max_chars - 1, str);
            index += max_chars;
  180c30:	01 1d 6e 14 00 00    	add    %ebx,0x146e(%rip)        # 1820a4 <index.1465>
            return max_chars;
  180c36:	89 d8                	mov    %ebx,%eax
  180c38:	eb 05                	jmp    180c3f <read_line+0xa8>
        str[max_chars] = '\0';
  180c3a:	c6 07 00             	movb   $0x0,(%rdi)
        return 0;
  180c3d:	89 f0                	mov    %esi,%eax
            return 0;
        }
        return read_line(str, max_chars);
    }
    return 0;
}
  180c3f:	5b                   	pop    %rbx
  180c40:	41 5c                	pop    %r12
  180c42:	41 5d                	pop    %r13
  180c44:	41 5e                	pop    %r14
  180c46:	5d                   	pop    %rbp
  180c47:	c3                   	retq   
                memcpy(str, cache + index, i - index + 1);
  180c48:	49 63 d2             	movslq %r10d,%rdx
  180c4b:	49 8d b1 20 20 18 00 	lea    0x182020(%r9),%rsi
  180c52:	4c 89 ef             	mov    %r13,%rdi
  180c55:	e8 2d f5 ff ff       	callq  180187 <memcpy>
                str[i-index+1] = '\0';
  180c5a:	44 89 e3             	mov    %r12d,%ebx
  180c5d:	2b 1d 41 14 00 00    	sub    0x1441(%rip),%ebx        # 1820a4 <index.1465>
  180c63:	48 63 c3             	movslq %ebx,%rax
  180c66:	41 c6 44 05 01 00    	movb   $0x0,0x1(%r13,%rax,1)
                int len = i - index + 1;
  180c6c:	8d 43 01             	lea    0x1(%rbx),%eax
                index = i + 1;
  180c6f:	41 83 c4 01          	add    $0x1,%r12d
  180c73:	44 89 25 2a 14 00 00 	mov    %r12d,0x142a(%rip)        # 1820a4 <index.1465>
                return len;
  180c7a:	eb c3                	jmp    180c3f <read_line+0xa8>
            memcpy(str, cache + index, length - index);
  180c7c:	48 63 d2             	movslq %edx,%rdx
  180c7f:	48 63 f7             	movslq %edi,%rsi
  180c82:	48 81 c6 20 20 18 00 	add    $0x182020,%rsi
  180c89:	4c 89 ef             	mov    %r13,%rdi
  180c8c:	e8 f6 f4 ff ff       	callq  180187 <memcpy>
            str += length - index;
  180c91:	8b 05 09 14 00 00    	mov    0x1409(%rip),%eax        # 1820a0 <length.1466>
  180c97:	41 89 c4             	mov    %eax,%r12d
  180c9a:	44 2b 25 03 14 00 00 	sub    0x1403(%rip),%r12d        # 1820a4 <index.1465>
            index = length;
  180ca1:	89 05 fd 13 00 00    	mov    %eax,0x13fd(%rip)        # 1820a4 <index.1465>
            max_chars -= length - index;
  180ca7:	44 29 e3             	sub    %r12d,%ebx
  180caa:	89 de                	mov    %ebx,%esi
            str += length - index;
  180cac:	49 63 fc             	movslq %r12d,%rdi
  180caf:	4c 01 ef             	add    %r13,%rdi
            len += read_line(str, max_chars);
  180cb2:	e8 e0 fe ff ff       	callq  180b97 <read_line>
  180cb7:	44 01 e0             	add    %r12d,%eax
            return len;
  180cba:	eb 83                	jmp    180c3f <read_line+0xa8>
        index = 0;
  180cbc:	c7 05 de 13 00 00 00 	movl   $0x0,0x13de(%rip)        # 1820a4 <index.1465>
  180cc3:	00 00 00 
    asm volatile ("int %1" : "=a" (result)
  180cc6:	bf 20 20 18 00       	mov    $0x182020,%edi
  180ccb:	cd 37                	int    $0x37
        length = sys_read_serial(cache);
  180ccd:	89 05 cd 13 00 00    	mov    %eax,0x13cd(%rip)        # 1820a0 <length.1466>
        if(length <= 0){
  180cd3:	85 c0                	test   %eax,%eax
  180cd5:	7f 0f                	jg     180ce6 <read_line+0x14f>
            str[0] = '\0';
  180cd7:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
            return 0;
  180cdc:	b8 00 00 00 00       	mov    $0x0,%eax
  180ce1:	e9 59 ff ff ff       	jmpq   180c3f <read_line+0xa8>
        return read_line(str, max_chars);
  180ce6:	4c 89 ef             	mov    %r13,%rdi
  180ce9:	e8 a9 fe ff ff       	callq  180b97 <read_line>
  180cee:	e9 4c ff ff ff       	jmpq   180c3f <read_line+0xa8>

0000000000180cf3 <panic>:

// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  180cf3:	55                   	push   %rbp
  180cf4:	48 89 e5             	mov    %rsp,%rbp
  180cf7:	53                   	push   %rbx
  180cf8:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  180cff:	48 89 fb             	mov    %rdi,%rbx
  180d02:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  180d06:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  180d0a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  180d0e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  180d12:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  180d16:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  180d1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  180d21:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  180d25:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  180d29:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  180d2d:	ba 07 00 00 00       	mov    $0x7,%edx
  180d32:	be 27 10 18 00       	mov    $0x181027,%esi
  180d37:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  180d3e:	e8 44 f4 ff ff       	callq  180187 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  180d43:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  180d47:	48 89 da             	mov    %rbx,%rdx
  180d4a:	be 99 00 00 00       	mov    $0x99,%esi
  180d4f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  180d56:	e8 09 fd ff ff       	callq  180a64 <vsnprintf>
  180d5b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  180d5e:	85 d2                	test   %edx,%edx
  180d60:	7e 0f                	jle    180d71 <panic+0x7e>
  180d62:	83 c0 06             	add    $0x6,%eax
  180d65:	48 98                	cltq   
  180d67:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  180d6e:	0a 
  180d6f:	75 2a                	jne    180d9b <panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  180d71:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  180d78:	48 89 d9             	mov    %rbx,%rcx
  180d7b:	ba 31 10 18 00       	mov    $0x181031,%edx
  180d80:	be 00 c0 00 00       	mov    $0xc000,%esi
  180d85:	bf 30 07 00 00       	mov    $0x730,%edi
  180d8a:	b8 00 00 00 00       	mov    $0x0,%eax
  180d8f:	e8 9a fc ff ff       	callq  180a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  180d94:	48 89 df             	mov    %rbx,%rdi
  180d97:	cd 30                	int    $0x30
 loop: goto loop;
  180d99:	eb fe                	jmp    180d99 <panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  180d9b:	48 63 c2             	movslq %edx,%rax
  180d9e:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  180da4:	0f 94 c2             	sete   %dl
  180da7:	0f b6 d2             	movzbl %dl,%edx
  180daa:	48 29 d0             	sub    %rdx,%rax
  180dad:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  180db4:	ff 
  180db5:	be 2f 10 18 00       	mov    $0x18102f,%esi
  180dba:	e8 86 f4 ff ff       	callq  180245 <strcpy>
  180dbf:	eb b0                	jmp    180d71 <panic+0x7e>

0000000000180dc1 <assert_fail>:
    sys_panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  180dc1:	55                   	push   %rbp
  180dc2:	48 89 e5             	mov    %rsp,%rbp
  180dc5:	48 89 f9             	mov    %rdi,%rcx
  180dc8:	41 89 f0             	mov    %esi,%r8d
  180dcb:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  180dce:	ba 38 10 18 00       	mov    $0x181038,%edx
  180dd3:	be 00 c0 00 00       	mov    $0xc000,%esi
  180dd8:	bf 30 07 00 00       	mov    $0x730,%edi
  180ddd:	b8 00 00 00 00       	mov    $0x0,%eax
  180de2:	e8 47 fc ff ff       	callq  180a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  180de7:	bf 00 00 00 00       	mov    $0x0,%edi
  180dec:	cd 30                	int    $0x30
 loop: goto loop;
  180dee:	eb fe                	jmp    180dee <assert_fail+0x2d>
