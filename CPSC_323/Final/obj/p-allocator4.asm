
obj/p-allocator4.full:     file format elf64-x86-64


Disassembly of section .text:

00000000001c0000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  1c0000:	55                   	push   %rbp
  1c0001:	48 89 e5             	mov    %rsp,%rbp
  1c0004:	41 54                	push   %r12
  1c0006:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  1c0007:	cd 31                	int    $0x31
  1c0009:	89 c7                	mov    %eax,%edi
  1c000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  1c000d:	e8 dd 02 00 00       	callq  1c02ef <srand>
    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  1c0012:	b8 b7 30 1c 00       	mov    $0x1c30b7,%eax
  1c0017:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c001d:	48 89 05 84 20 00 00 	mov    %rax,0x2084(%rip)        # 1c20a8 <heap_top>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sys_sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1c0024:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0029:	48 89 c7             	mov    %rax,%rdi
  1c002c:	cd 3a                	int    $0x3a
  1c002e:	48 89 05 cb 1f 00 00 	mov    %rax,0x1fcb(%rip)        # 1c2000 <result.1424>
    
    // sbrk(0) should return current program break without changing it.
    void * ptr = sys_sbrk(0);
    if(ptr == (void *)-1){
  1c0035:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1c0039:	74 1d                	je     1c0058 <process_main+0x58>
	panic("SBRK unimplemented!");
    }
    assert(ptr == heap_top);
  1c003b:	48 39 05 66 20 00 00 	cmp    %rax,0x2066(%rip)        # 1c20a8 <heap_top>
  1c0042:	74 23                	je     1c0067 <process_main+0x67>
  1c0044:	ba 04 0e 1c 00       	mov    $0x1c0e04,%edx
  1c0049:	be 1a 00 00 00       	mov    $0x1a,%esi
  1c004e:	bf 14 0e 1c 00       	mov    $0x1c0e14,%edi
  1c0053:	e8 69 0d 00 00       	callq  1c0dc1 <assert_fail>
	panic("SBRK unimplemented!");
  1c0058:	bf f0 0d 1c 00       	mov    $0x1c0df0,%edi
  1c005d:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0062:	e8 8c 0c 00 00       	callq  1c0cf3 <panic>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  1c0067:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  1c006a:	48 83 e8 01          	sub    $0x1,%rax
  1c006e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  1c0074:	48 89 05 35 20 00 00 	mov    %rax,0x2035(%rip)        # 1c20b0 <stack_bottom>
  1c007b:	41 bc 00 10 00 00    	mov    $0x1000,%r12d
  1c0081:	eb 02                	jmp    1c0085 <process_main+0x85>
    asm volatile ("int %0" : /* no result */
  1c0083:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  1c0085:	e8 2b 02 00 00       	callq  1c02b5 <rand>
  1c008a:	89 c2                	mov    %eax,%edx
  1c008c:	48 98                	cltq   
  1c008e:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
  1c0095:	48 c1 f8 25          	sar    $0x25,%rax
  1c0099:	89 d1                	mov    %edx,%ecx
  1c009b:	c1 f9 1f             	sar    $0x1f,%ecx
  1c009e:	29 c8                	sub    %ecx,%eax
  1c00a0:	6b c0 64             	imul   $0x64,%eax,%eax
  1c00a3:	29 c2                	sub    %eax,%edx
  1c00a5:	39 da                	cmp    %ebx,%edx
  1c00a7:	7d da                	jge    1c0083 <process_main+0x83>
            if(heap_top == stack_bottom)
  1c00a9:	48 8b 05 00 20 00 00 	mov    0x2000(%rip),%rax        # 1c20b0 <stack_bottom>
  1c00b0:	48 39 05 f1 1f 00 00 	cmp    %rax,0x1ff1(%rip)        # 1c20a8 <heap_top>
  1c00b7:	74 2a                	je     1c00e3 <process_main+0xe3>
    asm volatile ("int %1" :  "=a" (result)
  1c00b9:	4c 89 e7             	mov    %r12,%rdi
  1c00bc:	cd 3a                	int    $0x3a
  1c00be:	48 89 05 3b 1f 00 00 	mov    %rax,0x1f3b(%rip)        # 1c2000 <result.1424>
                break;
            void * ret = sys_sbrk(PAGESIZE);
            if(ret == (void *) -1)
  1c00c5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1c00c9:	74 18                	je     1c00e3 <process_main+0xe3>
                break;
            *heap_top = p;      /* check we have write access to new page */
  1c00cb:	48 8b 15 d6 1f 00 00 	mov    0x1fd6(%rip),%rdx        # 1c20a8 <heap_top>
  1c00d2:	88 1a                	mov    %bl,(%rdx)
            heap_top = (uint8_t *)ret + PAGESIZE;
  1c00d4:	48 05 00 10 00 00    	add    $0x1000,%rax
  1c00da:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 1c20a8 <heap_top>
  1c00e1:	eb a0                	jmp    1c0083 <process_main+0x83>
    asm volatile ("int %0" : /* no result */
  1c00e3:	cd 32                	int    $0x32
  1c00e5:	eb fc                	jmp    1c00e3 <process_main+0xe3>

00000000001c00e7 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1c00e7:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1c00ea:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  1c00f1:	00 
  1c00f2:	72 08                	jb     1c00fc <console_putc+0x15>
        cp->cursor = console;
  1c00f4:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  1c00fb:	00 
    }
    if (c == '\n') {
  1c00fc:	40 80 fe 0a          	cmp    $0xa,%sil
  1c0100:	74 17                	je     1c0119 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  1c0102:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1c0106:	48 8d 50 02          	lea    0x2(%rax),%rdx
  1c010a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1c010e:	40 0f b6 f6          	movzbl %sil,%esi
  1c0112:	44 09 c6             	or     %r8d,%esi
  1c0115:	66 89 30             	mov    %si,(%rax)
    }
}
  1c0118:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  1c0119:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  1c011d:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  1c0124:	48 89 f1             	mov    %rsi,%rcx
  1c0127:	48 d1 f9             	sar    %rcx
  1c012a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1c0131:	66 66 66 
  1c0134:	48 89 c8             	mov    %rcx,%rax
  1c0137:	48 f7 ea             	imul   %rdx
  1c013a:	48 c1 fa 05          	sar    $0x5,%rdx
  1c013e:	48 c1 fe 3f          	sar    $0x3f,%rsi
  1c0142:	48 29 f2             	sub    %rsi,%rdx
  1c0145:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  1c0149:	48 c1 e0 04          	shl    $0x4,%rax
  1c014d:	89 ca                	mov    %ecx,%edx
  1c014f:	29 c2                	sub    %eax,%edx
  1c0151:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1c0153:	44 89 c6             	mov    %r8d,%esi
  1c0156:	83 ce 20             	or     $0x20,%esi
  1c0159:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  1c015d:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  1c0161:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  1c0165:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  1c0168:	83 c0 01             	add    $0x1,%eax
  1c016b:	83 f8 50             	cmp    $0x50,%eax
  1c016e:	75 e9                	jne    1c0159 <console_putc+0x72>
  1c0170:	c3                   	retq   

00000000001c0171 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1c0171:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1c0175:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1c0179:	73 0b                	jae    1c0186 <string_putc+0x15>
        *sp->s++ = c;
  1c017b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1c017f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1c0183:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1c0186:	c3                   	retq   

00000000001c0187 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1c0187:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c018a:	48 85 d2             	test   %rdx,%rdx
  1c018d:	74 17                	je     1c01a6 <memcpy+0x1f>
  1c018f:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1c0194:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1c0199:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1c019d:	48 83 c1 01          	add    $0x1,%rcx
  1c01a1:	48 39 d1             	cmp    %rdx,%rcx
  1c01a4:	75 ee                	jne    1c0194 <memcpy+0xd>
}
  1c01a6:	c3                   	retq   

00000000001c01a7 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1c01a7:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1c01aa:	48 39 fe             	cmp    %rdi,%rsi
  1c01ad:	72 1d                	jb     1c01cc <memmove+0x25>
        while (n-- > 0) {
  1c01af:	b9 00 00 00 00       	mov    $0x0,%ecx
  1c01b4:	48 85 d2             	test   %rdx,%rdx
  1c01b7:	74 12                	je     1c01cb <memmove+0x24>
            *d++ = *s++;
  1c01b9:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1c01bd:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1c01c1:	48 83 c1 01          	add    $0x1,%rcx
  1c01c5:	48 39 ca             	cmp    %rcx,%rdx
  1c01c8:	75 ef                	jne    1c01b9 <memmove+0x12>
}
  1c01ca:	c3                   	retq   
  1c01cb:	c3                   	retq   
    if (s < d && s + n > d) {
  1c01cc:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1c01d0:	48 39 cf             	cmp    %rcx,%rdi
  1c01d3:	73 da                	jae    1c01af <memmove+0x8>
        while (n-- > 0) {
  1c01d5:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1c01d9:	48 85 d2             	test   %rdx,%rdx
  1c01dc:	74 ec                	je     1c01ca <memmove+0x23>
            *--d = *--s;
  1c01de:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1c01e2:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1c01e5:	48 83 e9 01          	sub    $0x1,%rcx
  1c01e9:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1c01ed:	75 ef                	jne    1c01de <memmove+0x37>
  1c01ef:	c3                   	retq   

00000000001c01f0 <memset>:
void* memset(void* v, int c, size_t n) {
  1c01f0:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c01f3:	48 85 d2             	test   %rdx,%rdx
  1c01f6:	74 13                	je     1c020b <memset+0x1b>
  1c01f8:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  1c01fc:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  1c01ff:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1c0202:	48 83 c2 01          	add    $0x1,%rdx
  1c0206:	48 39 d1             	cmp    %rdx,%rcx
  1c0209:	75 f4                	jne    1c01ff <memset+0xf>
}
  1c020b:	c3                   	retq   

00000000001c020c <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  1c020c:	80 3f 00             	cmpb   $0x0,(%rdi)
  1c020f:	74 10                	je     1c0221 <strlen+0x15>
  1c0211:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  1c0216:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  1c021a:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1c021e:	75 f6                	jne    1c0216 <strlen+0xa>
  1c0220:	c3                   	retq   
  1c0221:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1c0226:	c3                   	retq   

00000000001c0227 <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c0227:	b8 00 00 00 00       	mov    $0x0,%eax
  1c022c:	48 85 f6             	test   %rsi,%rsi
  1c022f:	74 10                	je     1c0241 <strnlen+0x1a>
  1c0231:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1c0235:	74 09                	je     1c0240 <strnlen+0x19>
        ++n;
  1c0237:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c023b:	48 39 c6             	cmp    %rax,%rsi
  1c023e:	75 f1                	jne    1c0231 <strnlen+0xa>
}
  1c0240:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1c0241:	48 89 f0             	mov    %rsi,%rax
  1c0244:	c3                   	retq   

00000000001c0245 <strcpy>:
char* strcpy(char* dst, const char* src) {
  1c0245:	48 89 f8             	mov    %rdi,%rax
  1c0248:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1c024d:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1c0251:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1c0254:	48 83 c2 01          	add    $0x1,%rdx
  1c0258:	84 c9                	test   %cl,%cl
  1c025a:	75 f1                	jne    1c024d <strcpy+0x8>
}
  1c025c:	c3                   	retq   

00000000001c025d <strcmp>:
    while (*a && *b && *a == *b) {
  1c025d:	0f b6 17             	movzbl (%rdi),%edx
  1c0260:	84 d2                	test   %dl,%dl
  1c0262:	74 1a                	je     1c027e <strcmp+0x21>
  1c0264:	0f b6 06             	movzbl (%rsi),%eax
  1c0267:	38 d0                	cmp    %dl,%al
  1c0269:	75 13                	jne    1c027e <strcmp+0x21>
  1c026b:	84 c0                	test   %al,%al
  1c026d:	74 0f                	je     1c027e <strcmp+0x21>
        ++a, ++b;
  1c026f:	48 83 c7 01          	add    $0x1,%rdi
  1c0273:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1c0277:	0f b6 17             	movzbl (%rdi),%edx
  1c027a:	84 d2                	test   %dl,%dl
  1c027c:	75 e6                	jne    1c0264 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1c027e:	0f b6 0e             	movzbl (%rsi),%ecx
  1c0281:	38 ca                	cmp    %cl,%dl
  1c0283:	0f 97 c0             	seta   %al
  1c0286:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1c0289:	83 d8 00             	sbb    $0x0,%eax
}
  1c028c:	c3                   	retq   

00000000001c028d <strchr>:
    while (*s && *s != (char) c) {
  1c028d:	0f b6 07             	movzbl (%rdi),%eax
  1c0290:	84 c0                	test   %al,%al
  1c0292:	74 10                	je     1c02a4 <strchr+0x17>
  1c0294:	40 38 f0             	cmp    %sil,%al
  1c0297:	74 18                	je     1c02b1 <strchr+0x24>
        ++s;
  1c0299:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1c029d:	0f b6 07             	movzbl (%rdi),%eax
  1c02a0:	84 c0                	test   %al,%al
  1c02a2:	75 f0                	jne    1c0294 <strchr+0x7>
        return NULL;
  1c02a4:	40 84 f6             	test   %sil,%sil
  1c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  1c02ac:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1c02b0:	c3                   	retq   
  1c02b1:	48 89 f8             	mov    %rdi,%rax
  1c02b4:	c3                   	retq   

00000000001c02b5 <rand>:
    if (!rand_seed_set) {
  1c02b5:	83 3d 50 1d 00 00 00 	cmpl   $0x0,0x1d50(%rip)        # 1c200c <rand_seed_set>
  1c02bc:	74 1b                	je     1c02d9 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1c02be:	69 05 40 1d 00 00 0d 	imul   $0x19660d,0x1d40(%rip),%eax        # 1c2008 <rand_seed>
  1c02c5:	66 19 00 
  1c02c8:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1c02cd:	89 05 35 1d 00 00    	mov    %eax,0x1d35(%rip)        # 1c2008 <rand_seed>
    return rand_seed & RAND_MAX;
  1c02d3:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1c02d8:	c3                   	retq   
    rand_seed = seed;
  1c02d9:	c7 05 25 1d 00 00 9e 	movl   $0x30d4879e,0x1d25(%rip)        # 1c2008 <rand_seed>
  1c02e0:	87 d4 30 
    rand_seed_set = 1;
  1c02e3:	c7 05 1f 1d 00 00 01 	movl   $0x1,0x1d1f(%rip)        # 1c200c <rand_seed_set>
  1c02ea:	00 00 00 
}
  1c02ed:	eb cf                	jmp    1c02be <rand+0x9>

00000000001c02ef <srand>:
    rand_seed = seed;
  1c02ef:	89 3d 13 1d 00 00    	mov    %edi,0x1d13(%rip)        # 1c2008 <rand_seed>
    rand_seed_set = 1;
  1c02f5:	c7 05 0d 1d 00 00 01 	movl   $0x1,0x1d0d(%rip)        # 1c200c <rand_seed_set>
  1c02fc:	00 00 00 
}
  1c02ff:	c3                   	retq   

00000000001c0300 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1c0300:	55                   	push   %rbp
  1c0301:	48 89 e5             	mov    %rsp,%rbp
  1c0304:	41 57                	push   %r15
  1c0306:	41 56                	push   %r14
  1c0308:	41 55                	push   %r13
  1c030a:	41 54                	push   %r12
  1c030c:	53                   	push   %rbx
  1c030d:	48 83 ec 58          	sub    $0x58,%rsp
  1c0311:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  1c0315:	0f b6 02             	movzbl (%rdx),%eax
  1c0318:	84 c0                	test   %al,%al
  1c031a:	0f 84 ba 06 00 00    	je     1c09da <printer_vprintf+0x6da>
  1c0320:	49 89 fe             	mov    %rdi,%r14
  1c0323:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1c0326:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  1c032d:	41 89 f7             	mov    %esi,%r15d
  1c0330:	e9 a5 04 00 00       	jmpq   1c07da <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  1c0335:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1c033a:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1c0340:	45 84 e4             	test   %r12b,%r12b
  1c0343:	0f 84 85 06 00 00    	je     1c09ce <printer_vprintf+0x6ce>
        int flags = 0;
  1c0349:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1c034f:	41 0f be f4          	movsbl %r12b,%esi
  1c0353:	bf 21 10 1c 00       	mov    $0x1c1021,%edi
  1c0358:	e8 30 ff ff ff       	callq  1c028d <strchr>
  1c035d:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1c0360:	48 85 c0             	test   %rax,%rax
  1c0363:	74 55                	je     1c03ba <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  1c0365:	48 81 e9 21 10 1c 00 	sub    $0x1c1021,%rcx
  1c036c:	b8 01 00 00 00       	mov    $0x1,%eax
  1c0371:	d3 e0                	shl    %cl,%eax
  1c0373:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1c0376:	48 83 c3 01          	add    $0x1,%rbx
  1c037a:	44 0f b6 23          	movzbl (%rbx),%r12d
  1c037e:	45 84 e4             	test   %r12b,%r12b
  1c0381:	75 cc                	jne    1c034f <printer_vprintf+0x4f>
  1c0383:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1c0387:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1c038d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1c0394:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1c0397:	0f 84 a9 00 00 00    	je     1c0446 <printer_vprintf+0x146>
        int length = 0;
  1c039d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1c03a2:	0f b6 13             	movzbl (%rbx),%edx
  1c03a5:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1c03a8:	3c 37                	cmp    $0x37,%al
  1c03aa:	0f 87 c5 04 00 00    	ja     1c0875 <printer_vprintf+0x575>
  1c03b0:	0f b6 c0             	movzbl %al,%eax
  1c03b3:	ff 24 c5 30 0e 1c 00 	jmpq   *0x1c0e30(,%rax,8)
  1c03ba:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  1c03be:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1c03c3:	3c 08                	cmp    $0x8,%al
  1c03c5:	77 2f                	ja     1c03f6 <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c03c7:	0f b6 03             	movzbl (%rbx),%eax
  1c03ca:	8d 50 d0             	lea    -0x30(%rax),%edx
  1c03cd:	80 fa 09             	cmp    $0x9,%dl
  1c03d0:	77 5e                	ja     1c0430 <printer_vprintf+0x130>
  1c03d2:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1c03d8:	48 83 c3 01          	add    $0x1,%rbx
  1c03dc:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1c03e1:	0f be c0             	movsbl %al,%eax
  1c03e4:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c03e9:	0f b6 03             	movzbl (%rbx),%eax
  1c03ec:	8d 50 d0             	lea    -0x30(%rax),%edx
  1c03ef:	80 fa 09             	cmp    $0x9,%dl
  1c03f2:	76 e4                	jbe    1c03d8 <printer_vprintf+0xd8>
  1c03f4:	eb 97                	jmp    1c038d <printer_vprintf+0x8d>
        } else if (*format == '*') {
  1c03f6:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1c03fa:	75 3f                	jne    1c043b <printer_vprintf+0x13b>
            width = va_arg(val, int);
  1c03fc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0400:	8b 01                	mov    (%rcx),%eax
  1c0402:	83 f8 2f             	cmp    $0x2f,%eax
  1c0405:	77 17                	ja     1c041e <printer_vprintf+0x11e>
  1c0407:	89 c2                	mov    %eax,%edx
  1c0409:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c040d:	83 c0 08             	add    $0x8,%eax
  1c0410:	89 01                	mov    %eax,(%rcx)
  1c0412:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  1c0415:	48 83 c3 01          	add    $0x1,%rbx
  1c0419:	e9 6f ff ff ff       	jmpq   1c038d <printer_vprintf+0x8d>
            width = va_arg(val, int);
  1c041e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0422:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c0426:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c042a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c042e:	eb e2                	jmp    1c0412 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1c0430:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1c0436:	e9 52 ff ff ff       	jmpq   1c038d <printer_vprintf+0x8d>
        int width = -1;
  1c043b:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1c0441:	e9 47 ff ff ff       	jmpq   1c038d <printer_vprintf+0x8d>
            ++format;
  1c0446:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1c044a:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1c044e:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1c0451:	80 f9 09             	cmp    $0x9,%cl
  1c0454:	76 13                	jbe    1c0469 <printer_vprintf+0x169>
            } else if (*format == '*') {
  1c0456:	3c 2a                	cmp    $0x2a,%al
  1c0458:	74 32                	je     1c048c <printer_vprintf+0x18c>
            ++format;
  1c045a:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1c045d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1c0464:	e9 34 ff ff ff       	jmpq   1c039d <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c0469:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  1c046e:	48 83 c2 01          	add    $0x1,%rdx
  1c0472:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  1c0475:	0f be c0             	movsbl %al,%eax
  1c0478:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1c047c:	0f b6 02             	movzbl (%rdx),%eax
  1c047f:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1c0482:	80 f9 09             	cmp    $0x9,%cl
  1c0485:	76 e7                	jbe    1c046e <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  1c0487:	48 89 d3             	mov    %rdx,%rbx
  1c048a:	eb 1c                	jmp    1c04a8 <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  1c048c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0490:	8b 07                	mov    (%rdi),%eax
  1c0492:	83 f8 2f             	cmp    $0x2f,%eax
  1c0495:	77 23                	ja     1c04ba <printer_vprintf+0x1ba>
  1c0497:	89 c2                	mov    %eax,%edx
  1c0499:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c049d:	83 c0 08             	add    $0x8,%eax
  1c04a0:	89 07                	mov    %eax,(%rdi)
  1c04a2:	8b 32                	mov    (%rdx),%esi
                ++format;
  1c04a4:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1c04a8:	85 f6                	test   %esi,%esi
  1c04aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1c04af:	0f 48 f0             	cmovs  %eax,%esi
  1c04b2:	89 75 9c             	mov    %esi,-0x64(%rbp)
  1c04b5:	e9 e3 fe ff ff       	jmpq   1c039d <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  1c04ba:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c04be:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c04c2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c04c6:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c04ca:	eb d6                	jmp    1c04a2 <printer_vprintf+0x1a2>
        switch (*format) {
  1c04cc:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1c04d1:	e9 f1 00 00 00       	jmpq   1c05c7 <printer_vprintf+0x2c7>
            ++format;
  1c04d6:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1c04da:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  1c04dd:	e9 c0 fe ff ff       	jmpq   1c03a2 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1c04e2:	85 c9                	test   %ecx,%ecx
  1c04e4:	74 55                	je     1c053b <printer_vprintf+0x23b>
  1c04e6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c04ea:	8b 01                	mov    (%rcx),%eax
  1c04ec:	83 f8 2f             	cmp    $0x2f,%eax
  1c04ef:	77 38                	ja     1c0529 <printer_vprintf+0x229>
  1c04f1:	89 c2                	mov    %eax,%edx
  1c04f3:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c04f7:	83 c0 08             	add    $0x8,%eax
  1c04fa:	89 01                	mov    %eax,(%rcx)
  1c04fc:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1c04ff:	48 89 d0             	mov    %rdx,%rax
  1c0502:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  1c0506:	49 89 d0             	mov    %rdx,%r8
  1c0509:	49 f7 d8             	neg    %r8
  1c050c:	25 80 00 00 00       	and    $0x80,%eax
  1c0511:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1c0515:	0b 45 a8             	or     -0x58(%rbp),%eax
  1c0518:	83 c8 60             	or     $0x60,%eax
  1c051b:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1c051e:	41 bc 30 10 1c 00    	mov    $0x1c1030,%r12d
            break;
  1c0524:	e9 35 01 00 00       	jmpq   1c065e <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1c0529:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c052d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c0531:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c0535:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c0539:	eb c1                	jmp    1c04fc <printer_vprintf+0x1fc>
  1c053b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c053f:	8b 07                	mov    (%rdi),%eax
  1c0541:	83 f8 2f             	cmp    $0x2f,%eax
  1c0544:	77 10                	ja     1c0556 <printer_vprintf+0x256>
  1c0546:	89 c2                	mov    %eax,%edx
  1c0548:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c054c:	83 c0 08             	add    $0x8,%eax
  1c054f:	89 07                	mov    %eax,(%rdi)
  1c0551:	48 63 12             	movslq (%rdx),%rdx
  1c0554:	eb a9                	jmp    1c04ff <printer_vprintf+0x1ff>
  1c0556:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c055a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c055e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c0562:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c0566:	eb e9                	jmp    1c0551 <printer_vprintf+0x251>
        int base = 10;
  1c0568:	be 0a 00 00 00       	mov    $0xa,%esi
  1c056d:	eb 58                	jmp    1c05c7 <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1c056f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0573:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c0577:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c057b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c057f:	eb 60                	jmp    1c05e1 <printer_vprintf+0x2e1>
  1c0581:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0585:	8b 01                	mov    (%rcx),%eax
  1c0587:	83 f8 2f             	cmp    $0x2f,%eax
  1c058a:	77 10                	ja     1c059c <printer_vprintf+0x29c>
  1c058c:	89 c2                	mov    %eax,%edx
  1c058e:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c0592:	83 c0 08             	add    $0x8,%eax
  1c0595:	89 01                	mov    %eax,(%rcx)
  1c0597:	44 8b 02             	mov    (%rdx),%r8d
  1c059a:	eb 48                	jmp    1c05e4 <printer_vprintf+0x2e4>
  1c059c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c05a0:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c05a4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c05a8:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c05ac:	eb e9                	jmp    1c0597 <printer_vprintf+0x297>
  1c05ae:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1c05b1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1c05b8:	bf 10 10 1c 00       	mov    $0x1c1010,%edi
  1c05bd:	e9 e6 02 00 00       	jmpq   1c08a8 <printer_vprintf+0x5a8>
            base = 16;
  1c05c2:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1c05c7:	85 c9                	test   %ecx,%ecx
  1c05c9:	74 b6                	je     1c0581 <printer_vprintf+0x281>
  1c05cb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c05cf:	8b 07                	mov    (%rdi),%eax
  1c05d1:	83 f8 2f             	cmp    $0x2f,%eax
  1c05d4:	77 99                	ja     1c056f <printer_vprintf+0x26f>
  1c05d6:	89 c2                	mov    %eax,%edx
  1c05d8:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c05dc:	83 c0 08             	add    $0x8,%eax
  1c05df:	89 07                	mov    %eax,(%rdi)
  1c05e1:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1c05e4:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1c05e8:	85 f6                	test   %esi,%esi
  1c05ea:	79 c2                	jns    1c05ae <printer_vprintf+0x2ae>
        base = -base;
  1c05ec:	41 89 f1             	mov    %esi,%r9d
  1c05ef:	f7 de                	neg    %esi
  1c05f1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1c05f8:	bf f0 0f 1c 00       	mov    $0x1c0ff0,%edi
  1c05fd:	e9 a6 02 00 00       	jmpq   1c08a8 <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  1c0602:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0606:	8b 07                	mov    (%rdi),%eax
  1c0608:	83 f8 2f             	cmp    $0x2f,%eax
  1c060b:	77 1c                	ja     1c0629 <printer_vprintf+0x329>
  1c060d:	89 c2                	mov    %eax,%edx
  1c060f:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c0613:	83 c0 08             	add    $0x8,%eax
  1c0616:	89 07                	mov    %eax,(%rdi)
  1c0618:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  1c061b:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1c0622:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1c0627:	eb c3                	jmp    1c05ec <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  1c0629:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c062d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c0631:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c0635:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c0639:	eb dd                	jmp    1c0618 <printer_vprintf+0x318>
            data = va_arg(val, char*);
  1c063b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c063f:	8b 01                	mov    (%rcx),%eax
  1c0641:	83 f8 2f             	cmp    $0x2f,%eax
  1c0644:	0f 87 a9 01 00 00    	ja     1c07f3 <printer_vprintf+0x4f3>
  1c064a:	89 c2                	mov    %eax,%edx
  1c064c:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c0650:	83 c0 08             	add    $0x8,%eax
  1c0653:	89 01                	mov    %eax,(%rcx)
  1c0655:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1c0658:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1c065e:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c0661:	83 e0 20             	and    $0x20,%eax
  1c0664:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1c0667:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1c066d:	0f 85 25 02 00 00    	jne    1c0898 <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1c0673:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c0676:	89 45 88             	mov    %eax,-0x78(%rbp)
  1c0679:	83 e0 60             	and    $0x60,%eax
  1c067c:	83 f8 60             	cmp    $0x60,%eax
  1c067f:	0f 84 58 02 00 00    	je     1c08dd <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1c0685:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c0688:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1c068b:	48 c7 45 a0 30 10 1c 	movq   $0x1c1030,-0x60(%rbp)
  1c0692:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1c0693:	83 f8 21             	cmp    $0x21,%eax
  1c0696:	0f 84 7d 02 00 00    	je     1c0919 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1c069c:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1c069f:	89 c8                	mov    %ecx,%eax
  1c06a1:	f7 d0                	not    %eax
  1c06a3:	c1 e8 1f             	shr    $0x1f,%eax
  1c06a6:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1c06a9:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1c06ad:	0f 85 a2 02 00 00    	jne    1c0955 <printer_vprintf+0x655>
  1c06b3:	84 c0                	test   %al,%al
  1c06b5:	0f 84 9a 02 00 00    	je     1c0955 <printer_vprintf+0x655>
            len = strnlen(data, precision);
  1c06bb:	48 63 f1             	movslq %ecx,%rsi
  1c06be:	4c 89 e7             	mov    %r12,%rdi
  1c06c1:	e8 61 fb ff ff       	callq  1c0227 <strnlen>
  1c06c6:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1c06c9:	8b 45 88             	mov    -0x78(%rbp),%eax
  1c06cc:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1c06cf:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1c06d6:	83 f8 22             	cmp    $0x22,%eax
  1c06d9:	0f 84 ae 02 00 00    	je     1c098d <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  1c06df:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1c06e3:	e8 24 fb ff ff       	callq  1c020c <strlen>
  1c06e8:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1c06eb:	03 55 98             	add    -0x68(%rbp),%edx
  1c06ee:	41 29 d5             	sub    %edx,%r13d
  1c06f1:	44 89 ea             	mov    %r13d,%edx
  1c06f4:	29 c2                	sub    %eax,%edx
  1c06f6:	89 55 8c             	mov    %edx,-0x74(%rbp)
  1c06f9:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c06fc:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  1c0700:	75 2d                	jne    1c072f <printer_vprintf+0x42f>
  1c0702:	85 d2                	test   %edx,%edx
  1c0704:	7e 29                	jle    1c072f <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  1c0706:	44 89 fa             	mov    %r15d,%edx
  1c0709:	be 20 00 00 00       	mov    $0x20,%esi
  1c070e:	4c 89 f7             	mov    %r14,%rdi
  1c0711:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1c0714:	41 83 ed 01          	sub    $0x1,%r13d
  1c0718:	45 85 ed             	test   %r13d,%r13d
  1c071b:	7f e9                	jg     1c0706 <printer_vprintf+0x406>
  1c071d:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1c0720:	85 ff                	test   %edi,%edi
  1c0722:	b8 01 00 00 00       	mov    $0x1,%eax
  1c0727:	0f 4f c7             	cmovg  %edi,%eax
  1c072a:	29 c7                	sub    %eax,%edi
  1c072c:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1c072f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  1c0733:	0f b6 01             	movzbl (%rcx),%eax
  1c0736:	84 c0                	test   %al,%al
  1c0738:	74 22                	je     1c075c <printer_vprintf+0x45c>
  1c073a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1c073e:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  1c0741:	0f b6 f0             	movzbl %al,%esi
  1c0744:	44 89 fa             	mov    %r15d,%edx
  1c0747:	4c 89 f7             	mov    %r14,%rdi
  1c074a:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  1c074d:	48 83 c3 01          	add    $0x1,%rbx
  1c0751:	0f b6 03             	movzbl (%rbx),%eax
  1c0754:	84 c0                	test   %al,%al
  1c0756:	75 e9                	jne    1c0741 <printer_vprintf+0x441>
  1c0758:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1c075c:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1c075f:	85 c0                	test   %eax,%eax
  1c0761:	7e 1d                	jle    1c0780 <printer_vprintf+0x480>
  1c0763:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1c0767:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1c0769:	44 89 fa             	mov    %r15d,%edx
  1c076c:	be 30 00 00 00       	mov    $0x30,%esi
  1c0771:	4c 89 f7             	mov    %r14,%rdi
  1c0774:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  1c0777:	83 eb 01             	sub    $0x1,%ebx
  1c077a:	75 ed                	jne    1c0769 <printer_vprintf+0x469>
  1c077c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1c0780:	8b 45 98             	mov    -0x68(%rbp),%eax
  1c0783:	85 c0                	test   %eax,%eax
  1c0785:	7e 2a                	jle    1c07b1 <printer_vprintf+0x4b1>
  1c0787:	8d 40 ff             	lea    -0x1(%rax),%eax
  1c078a:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  1c078f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1c0793:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1c0796:	41 0f b6 34 24       	movzbl (%r12),%esi
  1c079b:	44 89 fa             	mov    %r15d,%edx
  1c079e:	4c 89 f7             	mov    %r14,%rdi
  1c07a1:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1c07a4:	49 83 c4 01          	add    $0x1,%r12
  1c07a8:	49 39 dc             	cmp    %rbx,%r12
  1c07ab:	75 e9                	jne    1c0796 <printer_vprintf+0x496>
  1c07ad:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1c07b1:	45 85 ed             	test   %r13d,%r13d
  1c07b4:	7e 14                	jle    1c07ca <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  1c07b6:	44 89 fa             	mov    %r15d,%edx
  1c07b9:	be 20 00 00 00       	mov    $0x20,%esi
  1c07be:	4c 89 f7             	mov    %r14,%rdi
  1c07c1:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1c07c4:	41 83 ed 01          	sub    $0x1,%r13d
  1c07c8:	75 ec                	jne    1c07b6 <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  1c07ca:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1c07ce:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1c07d2:	84 c0                	test   %al,%al
  1c07d4:	0f 84 00 02 00 00    	je     1c09da <printer_vprintf+0x6da>
        if (*format != '%') {
  1c07da:	3c 25                	cmp    $0x25,%al
  1c07dc:	0f 84 53 fb ff ff    	je     1c0335 <printer_vprintf+0x35>
            p->putc(p, *format, color);
  1c07e2:	0f b6 f0             	movzbl %al,%esi
  1c07e5:	44 89 fa             	mov    %r15d,%edx
  1c07e8:	4c 89 f7             	mov    %r14,%rdi
  1c07eb:	41 ff 16             	callq  *(%r14)
            continue;
  1c07ee:	4c 89 e3             	mov    %r12,%rbx
  1c07f1:	eb d7                	jmp    1c07ca <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  1c07f3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c07f7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c07fb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c07ff:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c0803:	e9 4d fe ff ff       	jmpq   1c0655 <printer_vprintf+0x355>
            color = va_arg(val, int);
  1c0808:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c080c:	8b 07                	mov    (%rdi),%eax
  1c080e:	83 f8 2f             	cmp    $0x2f,%eax
  1c0811:	77 10                	ja     1c0823 <printer_vprintf+0x523>
  1c0813:	89 c2                	mov    %eax,%edx
  1c0815:	48 03 57 10          	add    0x10(%rdi),%rdx
  1c0819:	83 c0 08             	add    $0x8,%eax
  1c081c:	89 07                	mov    %eax,(%rdi)
  1c081e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1c0821:	eb a7                	jmp    1c07ca <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  1c0823:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0827:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1c082b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c082f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1c0833:	eb e9                	jmp    1c081e <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  1c0835:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1c0839:	8b 01                	mov    (%rcx),%eax
  1c083b:	83 f8 2f             	cmp    $0x2f,%eax
  1c083e:	77 23                	ja     1c0863 <printer_vprintf+0x563>
  1c0840:	89 c2                	mov    %eax,%edx
  1c0842:	48 03 51 10          	add    0x10(%rcx),%rdx
  1c0846:	83 c0 08             	add    $0x8,%eax
  1c0849:	89 01                	mov    %eax,(%rcx)
  1c084b:	8b 02                	mov    (%rdx),%eax
  1c084d:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1c0850:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1c0854:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1c0858:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1c085e:	e9 fb fd ff ff       	jmpq   1c065e <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  1c0863:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1c0867:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1c086b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1c086f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1c0873:	eb d6                	jmp    1c084b <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  1c0875:	84 d2                	test   %dl,%dl
  1c0877:	0f 85 3b 01 00 00    	jne    1c09b8 <printer_vprintf+0x6b8>
  1c087d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1c0881:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1c0885:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1c0889:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1c088d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1c0893:	e9 c6 fd ff ff       	jmpq   1c065e <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  1c0898:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1c089e:	bf 10 10 1c 00       	mov    $0x1c1010,%edi
        if (flags & FLAG_NUMERIC) {
  1c08a3:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1c08a8:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1c08ac:	4c 89 c1             	mov    %r8,%rcx
  1c08af:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1c08b3:	48 63 f6             	movslq %esi,%rsi
  1c08b6:	49 83 ec 01          	sub    $0x1,%r12
  1c08ba:	48 89 c8             	mov    %rcx,%rax
  1c08bd:	ba 00 00 00 00       	mov    $0x0,%edx
  1c08c2:	48 f7 f6             	div    %rsi
  1c08c5:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1c08c9:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1c08cd:	48 89 ca             	mov    %rcx,%rdx
  1c08d0:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1c08d3:	48 39 d6             	cmp    %rdx,%rsi
  1c08d6:	76 de                	jbe    1c08b6 <printer_vprintf+0x5b6>
  1c08d8:	e9 96 fd ff ff       	jmpq   1c0673 <printer_vprintf+0x373>
                prefix = "-";
  1c08dd:	48 c7 45 a0 27 0e 1c 	movq   $0x1c0e27,-0x60(%rbp)
  1c08e4:	00 
            if (flags & FLAG_NEGATIVE) {
  1c08e5:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1c08e8:	a8 80                	test   $0x80,%al
  1c08ea:	0f 85 ac fd ff ff    	jne    1c069c <printer_vprintf+0x39c>
                prefix = "+";
  1c08f0:	48 c7 45 a0 25 0e 1c 	movq   $0x1c0e25,-0x60(%rbp)
  1c08f7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1c08f8:	a8 10                	test   $0x10,%al
  1c08fa:	0f 85 9c fd ff ff    	jne    1c069c <printer_vprintf+0x39c>
                prefix = " ";
  1c0900:	a8 08                	test   $0x8,%al
  1c0902:	ba 30 10 1c 00       	mov    $0x1c1030,%edx
  1c0907:	b8 2d 10 1c 00       	mov    $0x1c102d,%eax
  1c090c:	48 0f 44 c2          	cmove  %rdx,%rax
  1c0910:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1c0914:	e9 83 fd ff ff       	jmpq   1c069c <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  1c0919:	41 8d 41 10          	lea    0x10(%r9),%eax
  1c091d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1c0922:	0f 85 74 fd ff ff    	jne    1c069c <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  1c0928:	4d 85 c0             	test   %r8,%r8
  1c092b:	75 0d                	jne    1c093a <printer_vprintf+0x63a>
  1c092d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1c0934:	0f 84 62 fd ff ff    	je     1c069c <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  1c093a:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1c093e:	ba 22 0e 1c 00       	mov    $0x1c0e22,%edx
  1c0943:	b8 29 0e 1c 00       	mov    $0x1c0e29,%eax
  1c0948:	48 0f 44 c2          	cmove  %rdx,%rax
  1c094c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1c0950:	e9 47 fd ff ff       	jmpq   1c069c <printer_vprintf+0x39c>
            len = strlen(data);
  1c0955:	4c 89 e7             	mov    %r12,%rdi
  1c0958:	e8 af f8 ff ff       	callq  1c020c <strlen>
  1c095d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1c0960:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1c0964:	0f 84 5f fd ff ff    	je     1c06c9 <printer_vprintf+0x3c9>
  1c096a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1c096e:	0f 84 55 fd ff ff    	je     1c06c9 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  1c0974:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1c0977:	89 fa                	mov    %edi,%edx
  1c0979:	29 c2                	sub    %eax,%edx
  1c097b:	39 c7                	cmp    %eax,%edi
  1c097d:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0982:	0f 4e d0             	cmovle %eax,%edx
  1c0985:	89 55 9c             	mov    %edx,-0x64(%rbp)
  1c0988:	e9 52 fd ff ff       	jmpq   1c06df <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  1c098d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1c0991:	e8 76 f8 ff ff       	callq  1c020c <strlen>
  1c0996:	8b 7d 98             	mov    -0x68(%rbp),%edi
  1c0999:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1c099c:	44 89 e9             	mov    %r13d,%ecx
  1c099f:	29 f9                	sub    %edi,%ecx
  1c09a1:	29 c1                	sub    %eax,%ecx
  1c09a3:	89 c8                	mov    %ecx,%eax
  1c09a5:	44 39 ea             	cmp    %r13d,%edx
  1c09a8:	b9 00 00 00 00       	mov    $0x0,%ecx
  1c09ad:	0f 4d c1             	cmovge %ecx,%eax
  1c09b0:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1c09b3:	e9 27 fd ff ff       	jmpq   1c06df <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  1c09b8:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1c09bb:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1c09bf:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1c09c3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1c09c9:	e9 90 fc ff ff       	jmpq   1c065e <printer_vprintf+0x35e>
        int flags = 0;
  1c09ce:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1c09d5:	e9 ad f9 ff ff       	jmpq   1c0387 <printer_vprintf+0x87>
}
  1c09da:	48 83 c4 58          	add    $0x58,%rsp
  1c09de:	5b                   	pop    %rbx
  1c09df:	41 5c                	pop    %r12
  1c09e1:	41 5d                	pop    %r13
  1c09e3:	41 5e                	pop    %r14
  1c09e5:	41 5f                	pop    %r15
  1c09e7:	5d                   	pop    %rbp
  1c09e8:	c3                   	retq   

00000000001c09e9 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1c09e9:	55                   	push   %rbp
  1c09ea:	48 89 e5             	mov    %rsp,%rbp
  1c09ed:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  1c09f1:	48 c7 45 f0 e7 00 1c 	movq   $0x1c00e7,-0x10(%rbp)
  1c09f8:	00 
        cpos = 0;
  1c09f9:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1c09ff:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0a04:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  1c0a07:	48 63 ff             	movslq %edi,%rdi
  1c0a0a:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  1c0a11:	00 
  1c0a12:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1c0a16:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  1c0a1a:	e8 e1 f8 ff ff       	callq  1c0300 <printer_vprintf>
    return cp.cursor - console;
  1c0a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1c0a23:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1c0a29:	48 d1 f8             	sar    %rax
}
  1c0a2c:	c9                   	leaveq 
  1c0a2d:	c3                   	retq   

00000000001c0a2e <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1c0a2e:	55                   	push   %rbp
  1c0a2f:	48 89 e5             	mov    %rsp,%rbp
  1c0a32:	48 83 ec 50          	sub    $0x50,%rsp
  1c0a36:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c0a3a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c0a3e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1c0a42:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1c0a49:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c0a4d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c0a51:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c0a55:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1c0a59:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c0a5d:	e8 87 ff ff ff       	callq  1c09e9 <console_vprintf>
}
  1c0a62:	c9                   	leaveq 
  1c0a63:	c3                   	retq   

00000000001c0a64 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1c0a64:	55                   	push   %rbp
  1c0a65:	48 89 e5             	mov    %rsp,%rbp
  1c0a68:	53                   	push   %rbx
  1c0a69:	48 83 ec 28          	sub    $0x28,%rsp
  1c0a6d:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1c0a70:	48 c7 45 d8 71 01 1c 	movq   $0x1c0171,-0x28(%rbp)
  1c0a77:	00 
    sp.s = s;
  1c0a78:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  1c0a7c:	48 85 f6             	test   %rsi,%rsi
  1c0a7f:	75 0e                	jne    1c0a8f <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  1c0a81:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c0a85:	48 29 d8             	sub    %rbx,%rax
}
  1c0a88:	48 83 c4 28          	add    $0x28,%rsp
  1c0a8c:	5b                   	pop    %rbx
  1c0a8d:	5d                   	pop    %rbp
  1c0a8e:	c3                   	retq   
        sp.end = s + size - 1;
  1c0a8f:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  1c0a94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1c0a98:	be 00 00 00 00       	mov    $0x0,%esi
  1c0a9d:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  1c0aa1:	e8 5a f8 ff ff       	callq  1c0300 <printer_vprintf>
        *sp.s = 0;
  1c0aa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1c0aaa:	c6 00 00             	movb   $0x0,(%rax)
  1c0aad:	eb d2                	jmp    1c0a81 <vsnprintf+0x1d>

00000000001c0aaf <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1c0aaf:	55                   	push   %rbp
  1c0ab0:	48 89 e5             	mov    %rsp,%rbp
  1c0ab3:	48 83 ec 50          	sub    $0x50,%rsp
  1c0ab7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c0abb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c0abf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  1c0ac3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1c0aca:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c0ace:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1c0ad2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1c0ad6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  1c0ada:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c0ade:	e8 81 ff ff ff       	callq  1c0a64 <vsnprintf>
    va_end(val);
    return n;
}
  1c0ae3:	c9                   	leaveq 
  1c0ae4:	c3                   	retq   

00000000001c0ae5 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c0ae5:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  1c0aea:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  1c0aef:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  1c0af4:	48 83 c0 02          	add    $0x2,%rax
  1c0af8:	48 39 d0             	cmp    %rdx,%rax
  1c0afb:	75 f2                	jne    1c0aef <console_clear+0xa>
    }
    cursorpos = 0;
  1c0afd:	c7 05 f5 84 ef ff 00 	movl   $0x0,-0x107b0b(%rip)        # b8ffc <cursorpos>
  1c0b04:	00 00 00 
}
  1c0b07:	c3                   	retq   

00000000001c0b08 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1c0b08:	55                   	push   %rbp
  1c0b09:	48 89 e5             	mov    %rsp,%rbp
  1c0b0c:	48 83 ec 50          	sub    $0x50,%rsp
  1c0b10:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1c0b14:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1c0b18:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1c0b1c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  1c0b20:	b8 00 07 00 00       	mov    $0x700,%eax
    if (colorid < 0) {
  1c0b25:	85 ff                	test   %edi,%edi
  1c0b27:	78 2e                	js     1c0b57 <app_printf+0x4f>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  1c0b29:	48 63 ff             	movslq %edi,%rdi
  1c0b2c:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  1c0b33:	cc cc cc 
  1c0b36:	48 89 f8             	mov    %rdi,%rax
  1c0b39:	48 f7 e2             	mul    %rdx
  1c0b3c:	48 89 d0             	mov    %rdx,%rax
  1c0b3f:	48 c1 e8 02          	shr    $0x2,%rax
  1c0b43:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1c0b47:	48 01 c2             	add    %rax,%rdx
  1c0b4a:	48 29 d7             	sub    %rdx,%rdi
  1c0b4d:	0f b6 87 60 10 1c 00 	movzbl 0x1c1060(%rdi),%eax
  1c0b54:	c1 e0 08             	shl    $0x8,%eax
    }

    va_list val;
    va_start(val, format);
  1c0b57:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1c0b5e:	48 8d 4d 10          	lea    0x10(%rbp),%rcx
  1c0b62:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  1c0b66:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  1c0b6a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1c0b6e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1c0b72:	48 89 f2             	mov    %rsi,%rdx
  1c0b75:	89 c6                	mov    %eax,%esi
  1c0b77:	8b 3d 7f 84 ef ff    	mov    -0x107b81(%rip),%edi        # b8ffc <cursorpos>
  1c0b7d:	e8 67 fe ff ff       	callq  1c09e9 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1c0b82:	3d 30 07 00 00       	cmp    $0x730,%eax
  1c0b87:	ba 00 00 00 00       	mov    $0x0,%edx
  1c0b8c:	0f 4d c2             	cmovge %edx,%eax
  1c0b8f:	89 05 67 84 ef ff    	mov    %eax,-0x107b99(%rip)        # b8ffc <cursorpos>
    }
}
  1c0b95:	c9                   	leaveq 
  1c0b96:	c3                   	retq   

00000000001c0b97 <read_line>:
    return result;
}

// read_line
// str should be at least max_chars + 1 byte
int read_line(char * str, int max_chars){
  1c0b97:	55                   	push   %rbp
  1c0b98:	48 89 e5             	mov    %rsp,%rbp
  1c0b9b:	41 56                	push   %r14
  1c0b9d:	41 55                	push   %r13
  1c0b9f:	41 54                	push   %r12
  1c0ba1:	53                   	push   %rbx
  1c0ba2:	49 89 fd             	mov    %rdi,%r13
  1c0ba5:	89 f3                	mov    %esi,%ebx
    static char cache[128];
    static int index = 0;
    static int length = 0;

    if(max_chars == 0){
  1c0ba7:	85 f6                	test   %esi,%esi
  1c0ba9:	0f 84 8b 00 00 00    	je     1c0c3a <read_line+0xa3>
        str[max_chars] = '\0';
        return 0;
    }
    str[max_chars + 1] = '\0';
  1c0baf:	4c 63 f6             	movslq %esi,%r14
  1c0bb2:	42 c6 44 37 01 00    	movb   $0x0,0x1(%rdi,%r14,1)

    if(index < length){
  1c0bb8:	8b 3d e6 14 00 00    	mov    0x14e6(%rip),%edi        # 1c20a4 <index.1465>
  1c0bbe:	8b 15 dc 14 00 00    	mov    0x14dc(%rip),%edx        # 1c20a0 <length.1466>
  1c0bc4:	39 d7                	cmp    %edx,%edi
  1c0bc6:	0f 8d f0 00 00 00    	jge    1c0cbc <read_line+0x125>
        // some cache left
        int i = 0;
        for(i = index;
                i < length && (i - index + 1 < max_chars);
  1c0bcc:	83 fe 01             	cmp    $0x1,%esi
  1c0bcf:	7e 3b                	jle    1c0c0c <read_line+0x75>
  1c0bd1:	4c 63 cf             	movslq %edi,%r9
  1c0bd4:	8d 46 fe             	lea    -0x2(%rsi),%eax
  1c0bd7:	4d 8d 44 01 01       	lea    0x1(%r9,%rax,1),%r8
  1c0bdc:	8d 42 ff             	lea    -0x1(%rdx),%eax
  1c0bdf:	29 f8                	sub    %edi,%eax
  1c0be1:	4c 01 c8             	add    %r9,%rax
  1c0be4:	4c 89 c9             	mov    %r9,%rcx
  1c0be7:	be 01 00 00 00       	mov    $0x1,%esi
  1c0bec:	29 fe                	sub    %edi,%esi
  1c0bee:	41 89 cc             	mov    %ecx,%r12d
  1c0bf1:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
                i++){
            if(cache[i] == '\n'){
  1c0bf5:	80 b9 20 20 1c 00 0a 	cmpb   $0xa,0x1c2020(%rcx)
  1c0bfc:	74 4a                	je     1c0c48 <read_line+0xb1>
        for(i = index;
  1c0bfe:	48 39 c1             	cmp    %rax,%rcx
  1c0c01:	74 09                	je     1c0c0c <read_line+0x75>
  1c0c03:	48 83 c1 01          	add    $0x1,%rcx
                i < length && (i - index + 1 < max_chars);
  1c0c07:	4c 39 c1             	cmp    %r8,%rcx
  1c0c0a:	75 e2                	jne    1c0bee <read_line+0x57>
                int len = i - index + 1;
                index = i + 1;
                return len;
            }
        }
        if(max_chars <= length - index + 1){
  1c0c0c:	29 fa                	sub    %edi,%edx
  1c0c0e:	8d 42 01             	lea    0x1(%rdx),%eax
  1c0c11:	39 d8                	cmp    %ebx,%eax
  1c0c13:	7c 67                	jl     1c0c7c <read_line+0xe5>
            // copy max_chars - 1 bytes and return
            memcpy(str, cache + index, max_chars);
  1c0c15:	48 63 f7             	movslq %edi,%rsi
  1c0c18:	48 81 c6 20 20 1c 00 	add    $0x1c2020,%rsi
  1c0c1f:	4c 89 f2             	mov    %r14,%rdx
  1c0c22:	4c 89 ef             	mov    %r13,%rdi
  1c0c25:	e8 5d f5 ff ff       	callq  1c0187 <memcpy>
            str[max_chars] = '\0';
  1c0c2a:	43 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%r14,1)
            //app_printf(1, "[%d, %d]-> %sxx", index, index + max_chars - 1, str);
            index += max_chars;
  1c0c30:	01 1d 6e 14 00 00    	add    %ebx,0x146e(%rip)        # 1c20a4 <index.1465>
            return max_chars;
  1c0c36:	89 d8                	mov    %ebx,%eax
  1c0c38:	eb 05                	jmp    1c0c3f <read_line+0xa8>
        str[max_chars] = '\0';
  1c0c3a:	c6 07 00             	movb   $0x0,(%rdi)
        return 0;
  1c0c3d:	89 f0                	mov    %esi,%eax
            return 0;
        }
        return read_line(str, max_chars);
    }
    return 0;
}
  1c0c3f:	5b                   	pop    %rbx
  1c0c40:	41 5c                	pop    %r12
  1c0c42:	41 5d                	pop    %r13
  1c0c44:	41 5e                	pop    %r14
  1c0c46:	5d                   	pop    %rbp
  1c0c47:	c3                   	retq   
                memcpy(str, cache + index, i - index + 1);
  1c0c48:	49 63 d2             	movslq %r10d,%rdx
  1c0c4b:	49 8d b1 20 20 1c 00 	lea    0x1c2020(%r9),%rsi
  1c0c52:	4c 89 ef             	mov    %r13,%rdi
  1c0c55:	e8 2d f5 ff ff       	callq  1c0187 <memcpy>
                str[i-index+1] = '\0';
  1c0c5a:	44 89 e3             	mov    %r12d,%ebx
  1c0c5d:	2b 1d 41 14 00 00    	sub    0x1441(%rip),%ebx        # 1c20a4 <index.1465>
  1c0c63:	48 63 c3             	movslq %ebx,%rax
  1c0c66:	41 c6 44 05 01 00    	movb   $0x0,0x1(%r13,%rax,1)
                int len = i - index + 1;
  1c0c6c:	8d 43 01             	lea    0x1(%rbx),%eax
                index = i + 1;
  1c0c6f:	41 83 c4 01          	add    $0x1,%r12d
  1c0c73:	44 89 25 2a 14 00 00 	mov    %r12d,0x142a(%rip)        # 1c20a4 <index.1465>
                return len;
  1c0c7a:	eb c3                	jmp    1c0c3f <read_line+0xa8>
            memcpy(str, cache + index, length - index);
  1c0c7c:	48 63 d2             	movslq %edx,%rdx
  1c0c7f:	48 63 f7             	movslq %edi,%rsi
  1c0c82:	48 81 c6 20 20 1c 00 	add    $0x1c2020,%rsi
  1c0c89:	4c 89 ef             	mov    %r13,%rdi
  1c0c8c:	e8 f6 f4 ff ff       	callq  1c0187 <memcpy>
            str += length - index;
  1c0c91:	8b 05 09 14 00 00    	mov    0x1409(%rip),%eax        # 1c20a0 <length.1466>
  1c0c97:	41 89 c4             	mov    %eax,%r12d
  1c0c9a:	44 2b 25 03 14 00 00 	sub    0x1403(%rip),%r12d        # 1c20a4 <index.1465>
            index = length;
  1c0ca1:	89 05 fd 13 00 00    	mov    %eax,0x13fd(%rip)        # 1c20a4 <index.1465>
            max_chars -= length - index;
  1c0ca7:	44 29 e3             	sub    %r12d,%ebx
  1c0caa:	89 de                	mov    %ebx,%esi
            str += length - index;
  1c0cac:	49 63 fc             	movslq %r12d,%rdi
  1c0caf:	4c 01 ef             	add    %r13,%rdi
            len += read_line(str, max_chars);
  1c0cb2:	e8 e0 fe ff ff       	callq  1c0b97 <read_line>
  1c0cb7:	44 01 e0             	add    %r12d,%eax
            return len;
  1c0cba:	eb 83                	jmp    1c0c3f <read_line+0xa8>
        index = 0;
  1c0cbc:	c7 05 de 13 00 00 00 	movl   $0x0,0x13de(%rip)        # 1c20a4 <index.1465>
  1c0cc3:	00 00 00 
    asm volatile ("int %1" : "=a" (result)
  1c0cc6:	bf 20 20 1c 00       	mov    $0x1c2020,%edi
  1c0ccb:	cd 37                	int    $0x37
        length = sys_read_serial(cache);
  1c0ccd:	89 05 cd 13 00 00    	mov    %eax,0x13cd(%rip)        # 1c20a0 <length.1466>
        if(length <= 0){
  1c0cd3:	85 c0                	test   %eax,%eax
  1c0cd5:	7f 0f                	jg     1c0ce6 <read_line+0x14f>
            str[0] = '\0';
  1c0cd7:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
            return 0;
  1c0cdc:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0ce1:	e9 59 ff ff ff       	jmpq   1c0c3f <read_line+0xa8>
        return read_line(str, max_chars);
  1c0ce6:	4c 89 ef             	mov    %r13,%rdi
  1c0ce9:	e8 a9 fe ff ff       	callq  1c0b97 <read_line>
  1c0cee:	e9 4c ff ff ff       	jmpq   1c0c3f <read_line+0xa8>

00000000001c0cf3 <panic>:

// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  1c0cf3:	55                   	push   %rbp
  1c0cf4:	48 89 e5             	mov    %rsp,%rbp
  1c0cf7:	53                   	push   %rbx
  1c0cf8:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  1c0cff:	48 89 fb             	mov    %rdi,%rbx
  1c0d02:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  1c0d06:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  1c0d0a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  1c0d0e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  1c0d12:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  1c0d16:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1c0d1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1c0d21:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1c0d25:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1c0d29:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1c0d2d:	ba 07 00 00 00       	mov    $0x7,%edx
  1c0d32:	be 27 10 1c 00       	mov    $0x1c1027,%esi
  1c0d37:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1c0d3e:	e8 44 f4 ff ff       	callq  1c0187 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1c0d43:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1c0d47:	48 89 da             	mov    %rbx,%rdx
  1c0d4a:	be 99 00 00 00       	mov    $0x99,%esi
  1c0d4f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1c0d56:	e8 09 fd ff ff       	callq  1c0a64 <vsnprintf>
  1c0d5b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1c0d5e:	85 d2                	test   %edx,%edx
  1c0d60:	7e 0f                	jle    1c0d71 <panic+0x7e>
  1c0d62:	83 c0 06             	add    $0x6,%eax
  1c0d65:	48 98                	cltq   
  1c0d67:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1c0d6e:	0a 
  1c0d6f:	75 2a                	jne    1c0d9b <panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1c0d71:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1c0d78:	48 89 d9             	mov    %rbx,%rcx
  1c0d7b:	ba 31 10 1c 00       	mov    $0x1c1031,%edx
  1c0d80:	be 00 c0 00 00       	mov    $0xc000,%esi
  1c0d85:	bf 30 07 00 00       	mov    $0x730,%edi
  1c0d8a:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0d8f:	e8 9a fc ff ff       	callq  1c0a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  1c0d94:	48 89 df             	mov    %rbx,%rdi
  1c0d97:	cd 30                	int    $0x30
 loop: goto loop;
  1c0d99:	eb fe                	jmp    1c0d99 <panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  1c0d9b:	48 63 c2             	movslq %edx,%rax
  1c0d9e:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1c0da4:	0f 94 c2             	sete   %dl
  1c0da7:	0f b6 d2             	movzbl %dl,%edx
  1c0daa:	48 29 d0             	sub    %rdx,%rax
  1c0dad:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1c0db4:	ff 
  1c0db5:	be 2f 10 1c 00       	mov    $0x1c102f,%esi
  1c0dba:	e8 86 f4 ff ff       	callq  1c0245 <strcpy>
  1c0dbf:	eb b0                	jmp    1c0d71 <panic+0x7e>

00000000001c0dc1 <assert_fail>:
    sys_panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1c0dc1:	55                   	push   %rbp
  1c0dc2:	48 89 e5             	mov    %rsp,%rbp
  1c0dc5:	48 89 f9             	mov    %rdi,%rcx
  1c0dc8:	41 89 f0             	mov    %esi,%r8d
  1c0dcb:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1c0dce:	ba 38 10 1c 00       	mov    $0x1c1038,%edx
  1c0dd3:	be 00 c0 00 00       	mov    $0xc000,%esi
  1c0dd8:	bf 30 07 00 00       	mov    $0x730,%edi
  1c0ddd:	b8 00 00 00 00       	mov    $0x0,%eax
  1c0de2:	e8 47 fc ff ff       	callq  1c0a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  1c0de7:	bf 00 00 00 00       	mov    $0x0,%edi
  1c0dec:	cd 30                	int    $0x30
 loop: goto loop;
  1c0dee:	eb fe                	jmp    1c0dee <assert_fail+0x2d>
