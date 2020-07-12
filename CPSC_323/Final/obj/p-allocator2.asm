
obj/p-allocator2.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000140000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  140000:	55                   	push   %rbp
  140001:	48 89 e5             	mov    %rsp,%rbp
  140004:	41 54                	push   %r12
  140006:	53                   	push   %rbx

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  140007:	cd 31                	int    $0x31
  140009:	89 c7                	mov    %eax,%edi
  14000b:	89 c3                	mov    %eax,%ebx
    pid_t p = sys_getpid();
    srand(p);
  14000d:	e8 dd 02 00 00       	callq  1402ef <srand>
    // The heap starts on the page right after the 'end' symbol,
    // whose address is the first address not allocated to process code
    // or data.
    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  140012:	b8 b7 30 14 00       	mov    $0x1430b7,%eax
  140017:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  14001d:	48 89 05 84 20 00 00 	mov    %rax,0x2084(%rip)        # 1420a8 <heap_top>
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sys_sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  140024:	b8 00 00 00 00       	mov    $0x0,%eax
  140029:	48 89 c7             	mov    %rax,%rdi
  14002c:	cd 3a                	int    $0x3a
  14002e:	48 89 05 cb 1f 00 00 	mov    %rax,0x1fcb(%rip)        # 142000 <result.1424>
    
    // sbrk(0) should return current program break without changing it.
    void * ptr = sys_sbrk(0);
    if(ptr == (void *)-1){
  140035:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  140039:	74 1d                	je     140058 <process_main+0x58>
	panic("SBRK unimplemented!");
    }
    assert(ptr == heap_top);
  14003b:	48 39 05 66 20 00 00 	cmp    %rax,0x2066(%rip)        # 1420a8 <heap_top>
  140042:	74 23                	je     140067 <process_main+0x67>
  140044:	ba 04 0e 14 00       	mov    $0x140e04,%edx
  140049:	be 1a 00 00 00       	mov    $0x1a,%esi
  14004e:	bf 14 0e 14 00       	mov    $0x140e14,%edi
  140053:	e8 69 0d 00 00       	callq  140dc1 <assert_fail>
	panic("SBRK unimplemented!");
  140058:	bf f0 0d 14 00       	mov    $0x140df0,%edi
  14005d:	b8 00 00 00 00       	mov    $0x0,%eax
  140062:	e8 8c 0c 00 00       	callq  140cf3 <panic>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  140067:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  14006a:	48 83 e8 01          	sub    $0x1,%rax
  14006e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  140074:	48 89 05 35 20 00 00 	mov    %rax,0x2035(%rip)        # 1420b0 <stack_bottom>
  14007b:	41 bc 00 10 00 00    	mov    $0x1000,%r12d
  140081:	eb 02                	jmp    140085 <process_main+0x85>
    asm volatile ("int %0" : /* no result */
  140083:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
        if ((rand() % ALLOC_SLOWDOWN) < p) {
  140085:	e8 2b 02 00 00       	callq  1402b5 <rand>
  14008a:	89 c2                	mov    %eax,%edx
  14008c:	48 98                	cltq   
  14008e:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
  140095:	48 c1 f8 25          	sar    $0x25,%rax
  140099:	89 d1                	mov    %edx,%ecx
  14009b:	c1 f9 1f             	sar    $0x1f,%ecx
  14009e:	29 c8                	sub    %ecx,%eax
  1400a0:	6b c0 64             	imul   $0x64,%eax,%eax
  1400a3:	29 c2                	sub    %eax,%edx
  1400a5:	39 da                	cmp    %ebx,%edx
  1400a7:	7d da                	jge    140083 <process_main+0x83>
            if(heap_top == stack_bottom)
  1400a9:	48 8b 05 00 20 00 00 	mov    0x2000(%rip),%rax        # 1420b0 <stack_bottom>
  1400b0:	48 39 05 f1 1f 00 00 	cmp    %rax,0x1ff1(%rip)        # 1420a8 <heap_top>
  1400b7:	74 2a                	je     1400e3 <process_main+0xe3>
    asm volatile ("int %1" :  "=a" (result)
  1400b9:	4c 89 e7             	mov    %r12,%rdi
  1400bc:	cd 3a                	int    $0x3a
  1400be:	48 89 05 3b 1f 00 00 	mov    %rax,0x1f3b(%rip)        # 142000 <result.1424>
                break;
            void * ret = sys_sbrk(PAGESIZE);
            if(ret == (void *) -1)
  1400c5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1400c9:	74 18                	je     1400e3 <process_main+0xe3>
                break;
            *heap_top = p;      /* check we have write access to new page */
  1400cb:	48 8b 15 d6 1f 00 00 	mov    0x1fd6(%rip),%rdx        # 1420a8 <heap_top>
  1400d2:	88 1a                	mov    %bl,(%rdx)
            heap_top = (uint8_t *)ret + PAGESIZE;
  1400d4:	48 05 00 10 00 00    	add    $0x1000,%rax
  1400da:	48 89 05 c7 1f 00 00 	mov    %rax,0x1fc7(%rip)        # 1420a8 <heap_top>
  1400e1:	eb a0                	jmp    140083 <process_main+0x83>
    asm volatile ("int %0" : /* no result */
  1400e3:	cd 32                	int    $0x32
  1400e5:	eb fc                	jmp    1400e3 <process_main+0xe3>

00000000001400e7 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1400e7:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1400ea:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  1400f1:	00 
  1400f2:	72 08                	jb     1400fc <console_putc+0x15>
        cp->cursor = console;
  1400f4:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  1400fb:	00 
    }
    if (c == '\n') {
  1400fc:	40 80 fe 0a          	cmp    $0xa,%sil
  140100:	74 17                	je     140119 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  140102:	48 8b 47 08          	mov    0x8(%rdi),%rax
  140106:	48 8d 50 02          	lea    0x2(%rax),%rdx
  14010a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  14010e:	40 0f b6 f6          	movzbl %sil,%esi
  140112:	44 09 c6             	or     %r8d,%esi
  140115:	66 89 30             	mov    %si,(%rax)
    }
}
  140118:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  140119:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  14011d:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  140124:	48 89 f1             	mov    %rsi,%rcx
  140127:	48 d1 f9             	sar    %rcx
  14012a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  140131:	66 66 66 
  140134:	48 89 c8             	mov    %rcx,%rax
  140137:	48 f7 ea             	imul   %rdx
  14013a:	48 c1 fa 05          	sar    $0x5,%rdx
  14013e:	48 c1 fe 3f          	sar    $0x3f,%rsi
  140142:	48 29 f2             	sub    %rsi,%rdx
  140145:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  140149:	48 c1 e0 04          	shl    $0x4,%rax
  14014d:	89 ca                	mov    %ecx,%edx
  14014f:	29 c2                	sub    %eax,%edx
  140151:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  140153:	44 89 c6             	mov    %r8d,%esi
  140156:	83 ce 20             	or     $0x20,%esi
  140159:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  14015d:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  140161:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  140165:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  140168:	83 c0 01             	add    $0x1,%eax
  14016b:	83 f8 50             	cmp    $0x50,%eax
  14016e:	75 e9                	jne    140159 <console_putc+0x72>
  140170:	c3                   	retq   

0000000000140171 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  140171:	48 8b 47 08          	mov    0x8(%rdi),%rax
  140175:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  140179:	73 0b                	jae    140186 <string_putc+0x15>
        *sp->s++ = c;
  14017b:	48 8d 50 01          	lea    0x1(%rax),%rdx
  14017f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  140183:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  140186:	c3                   	retq   

0000000000140187 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  140187:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  14018a:	48 85 d2             	test   %rdx,%rdx
  14018d:	74 17                	je     1401a6 <memcpy+0x1f>
  14018f:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  140194:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  140199:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  14019d:	48 83 c1 01          	add    $0x1,%rcx
  1401a1:	48 39 d1             	cmp    %rdx,%rcx
  1401a4:	75 ee                	jne    140194 <memcpy+0xd>
}
  1401a6:	c3                   	retq   

00000000001401a7 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1401a7:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1401aa:	48 39 fe             	cmp    %rdi,%rsi
  1401ad:	72 1d                	jb     1401cc <memmove+0x25>
        while (n-- > 0) {
  1401af:	b9 00 00 00 00       	mov    $0x0,%ecx
  1401b4:	48 85 d2             	test   %rdx,%rdx
  1401b7:	74 12                	je     1401cb <memmove+0x24>
            *d++ = *s++;
  1401b9:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1401bd:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1401c1:	48 83 c1 01          	add    $0x1,%rcx
  1401c5:	48 39 ca             	cmp    %rcx,%rdx
  1401c8:	75 ef                	jne    1401b9 <memmove+0x12>
}
  1401ca:	c3                   	retq   
  1401cb:	c3                   	retq   
    if (s < d && s + n > d) {
  1401cc:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1401d0:	48 39 cf             	cmp    %rcx,%rdi
  1401d3:	73 da                	jae    1401af <memmove+0x8>
        while (n-- > 0) {
  1401d5:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1401d9:	48 85 d2             	test   %rdx,%rdx
  1401dc:	74 ec                	je     1401ca <memmove+0x23>
            *--d = *--s;
  1401de:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1401e2:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1401e5:	48 83 e9 01          	sub    $0x1,%rcx
  1401e9:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1401ed:	75 ef                	jne    1401de <memmove+0x37>
  1401ef:	c3                   	retq   

00000000001401f0 <memset>:
void* memset(void* v, int c, size_t n) {
  1401f0:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1401f3:	48 85 d2             	test   %rdx,%rdx
  1401f6:	74 13                	je     14020b <memset+0x1b>
  1401f8:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  1401fc:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  1401ff:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  140202:	48 83 c2 01          	add    $0x1,%rdx
  140206:	48 39 d1             	cmp    %rdx,%rcx
  140209:	75 f4                	jne    1401ff <memset+0xf>
}
  14020b:	c3                   	retq   

000000000014020c <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  14020c:	80 3f 00             	cmpb   $0x0,(%rdi)
  14020f:	74 10                	je     140221 <strlen+0x15>
  140211:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  140216:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  14021a:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  14021e:	75 f6                	jne    140216 <strlen+0xa>
  140220:	c3                   	retq   
  140221:	b8 00 00 00 00       	mov    $0x0,%eax
}
  140226:	c3                   	retq   

0000000000140227 <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  140227:	b8 00 00 00 00       	mov    $0x0,%eax
  14022c:	48 85 f6             	test   %rsi,%rsi
  14022f:	74 10                	je     140241 <strnlen+0x1a>
  140231:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  140235:	74 09                	je     140240 <strnlen+0x19>
        ++n;
  140237:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  14023b:	48 39 c6             	cmp    %rax,%rsi
  14023e:	75 f1                	jne    140231 <strnlen+0xa>
}
  140240:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  140241:	48 89 f0             	mov    %rsi,%rax
  140244:	c3                   	retq   

0000000000140245 <strcpy>:
char* strcpy(char* dst, const char* src) {
  140245:	48 89 f8             	mov    %rdi,%rax
  140248:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  14024d:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  140251:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  140254:	48 83 c2 01          	add    $0x1,%rdx
  140258:	84 c9                	test   %cl,%cl
  14025a:	75 f1                	jne    14024d <strcpy+0x8>
}
  14025c:	c3                   	retq   

000000000014025d <strcmp>:
    while (*a && *b && *a == *b) {
  14025d:	0f b6 17             	movzbl (%rdi),%edx
  140260:	84 d2                	test   %dl,%dl
  140262:	74 1a                	je     14027e <strcmp+0x21>
  140264:	0f b6 06             	movzbl (%rsi),%eax
  140267:	38 d0                	cmp    %dl,%al
  140269:	75 13                	jne    14027e <strcmp+0x21>
  14026b:	84 c0                	test   %al,%al
  14026d:	74 0f                	je     14027e <strcmp+0x21>
        ++a, ++b;
  14026f:	48 83 c7 01          	add    $0x1,%rdi
  140273:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  140277:	0f b6 17             	movzbl (%rdi),%edx
  14027a:	84 d2                	test   %dl,%dl
  14027c:	75 e6                	jne    140264 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  14027e:	0f b6 0e             	movzbl (%rsi),%ecx
  140281:	38 ca                	cmp    %cl,%dl
  140283:	0f 97 c0             	seta   %al
  140286:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  140289:	83 d8 00             	sbb    $0x0,%eax
}
  14028c:	c3                   	retq   

000000000014028d <strchr>:
    while (*s && *s != (char) c) {
  14028d:	0f b6 07             	movzbl (%rdi),%eax
  140290:	84 c0                	test   %al,%al
  140292:	74 10                	je     1402a4 <strchr+0x17>
  140294:	40 38 f0             	cmp    %sil,%al
  140297:	74 18                	je     1402b1 <strchr+0x24>
        ++s;
  140299:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  14029d:	0f b6 07             	movzbl (%rdi),%eax
  1402a0:	84 c0                	test   %al,%al
  1402a2:	75 f0                	jne    140294 <strchr+0x7>
        return NULL;
  1402a4:	40 84 f6             	test   %sil,%sil
  1402a7:	b8 00 00 00 00       	mov    $0x0,%eax
  1402ac:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1402b0:	c3                   	retq   
  1402b1:	48 89 f8             	mov    %rdi,%rax
  1402b4:	c3                   	retq   

00000000001402b5 <rand>:
    if (!rand_seed_set) {
  1402b5:	83 3d 50 1d 00 00 00 	cmpl   $0x0,0x1d50(%rip)        # 14200c <rand_seed_set>
  1402bc:	74 1b                	je     1402d9 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1402be:	69 05 40 1d 00 00 0d 	imul   $0x19660d,0x1d40(%rip),%eax        # 142008 <rand_seed>
  1402c5:	66 19 00 
  1402c8:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1402cd:	89 05 35 1d 00 00    	mov    %eax,0x1d35(%rip)        # 142008 <rand_seed>
    return rand_seed & RAND_MAX;
  1402d3:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1402d8:	c3                   	retq   
    rand_seed = seed;
  1402d9:	c7 05 25 1d 00 00 9e 	movl   $0x30d4879e,0x1d25(%rip)        # 142008 <rand_seed>
  1402e0:	87 d4 30 
    rand_seed_set = 1;
  1402e3:	c7 05 1f 1d 00 00 01 	movl   $0x1,0x1d1f(%rip)        # 14200c <rand_seed_set>
  1402ea:	00 00 00 
}
  1402ed:	eb cf                	jmp    1402be <rand+0x9>

00000000001402ef <srand>:
    rand_seed = seed;
  1402ef:	89 3d 13 1d 00 00    	mov    %edi,0x1d13(%rip)        # 142008 <rand_seed>
    rand_seed_set = 1;
  1402f5:	c7 05 0d 1d 00 00 01 	movl   $0x1,0x1d0d(%rip)        # 14200c <rand_seed_set>
  1402fc:	00 00 00 
}
  1402ff:	c3                   	retq   

0000000000140300 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  140300:	55                   	push   %rbp
  140301:	48 89 e5             	mov    %rsp,%rbp
  140304:	41 57                	push   %r15
  140306:	41 56                	push   %r14
  140308:	41 55                	push   %r13
  14030a:	41 54                	push   %r12
  14030c:	53                   	push   %rbx
  14030d:	48 83 ec 58          	sub    $0x58,%rsp
  140311:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  140315:	0f b6 02             	movzbl (%rdx),%eax
  140318:	84 c0                	test   %al,%al
  14031a:	0f 84 ba 06 00 00    	je     1409da <printer_vprintf+0x6da>
  140320:	49 89 fe             	mov    %rdi,%r14
  140323:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  140326:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  14032d:	41 89 f7             	mov    %esi,%r15d
  140330:	e9 a5 04 00 00       	jmpq   1407da <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  140335:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  14033a:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  140340:	45 84 e4             	test   %r12b,%r12b
  140343:	0f 84 85 06 00 00    	je     1409ce <printer_vprintf+0x6ce>
        int flags = 0;
  140349:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  14034f:	41 0f be f4          	movsbl %r12b,%esi
  140353:	bf 21 10 14 00       	mov    $0x141021,%edi
  140358:	e8 30 ff ff ff       	callq  14028d <strchr>
  14035d:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  140360:	48 85 c0             	test   %rax,%rax
  140363:	74 55                	je     1403ba <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  140365:	48 81 e9 21 10 14 00 	sub    $0x141021,%rcx
  14036c:	b8 01 00 00 00       	mov    $0x1,%eax
  140371:	d3 e0                	shl    %cl,%eax
  140373:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  140376:	48 83 c3 01          	add    $0x1,%rbx
  14037a:	44 0f b6 23          	movzbl (%rbx),%r12d
  14037e:	45 84 e4             	test   %r12b,%r12b
  140381:	75 cc                	jne    14034f <printer_vprintf+0x4f>
  140383:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  140387:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  14038d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  140394:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  140397:	0f 84 a9 00 00 00    	je     140446 <printer_vprintf+0x146>
        int length = 0;
  14039d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1403a2:	0f b6 13             	movzbl (%rbx),%edx
  1403a5:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1403a8:	3c 37                	cmp    $0x37,%al
  1403aa:	0f 87 c5 04 00 00    	ja     140875 <printer_vprintf+0x575>
  1403b0:	0f b6 c0             	movzbl %al,%eax
  1403b3:	ff 24 c5 30 0e 14 00 	jmpq   *0x140e30(,%rax,8)
  1403ba:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  1403be:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1403c3:	3c 08                	cmp    $0x8,%al
  1403c5:	77 2f                	ja     1403f6 <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1403c7:	0f b6 03             	movzbl (%rbx),%eax
  1403ca:	8d 50 d0             	lea    -0x30(%rax),%edx
  1403cd:	80 fa 09             	cmp    $0x9,%dl
  1403d0:	77 5e                	ja     140430 <printer_vprintf+0x130>
  1403d2:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1403d8:	48 83 c3 01          	add    $0x1,%rbx
  1403dc:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1403e1:	0f be c0             	movsbl %al,%eax
  1403e4:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1403e9:	0f b6 03             	movzbl (%rbx),%eax
  1403ec:	8d 50 d0             	lea    -0x30(%rax),%edx
  1403ef:	80 fa 09             	cmp    $0x9,%dl
  1403f2:	76 e4                	jbe    1403d8 <printer_vprintf+0xd8>
  1403f4:	eb 97                	jmp    14038d <printer_vprintf+0x8d>
        } else if (*format == '*') {
  1403f6:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1403fa:	75 3f                	jne    14043b <printer_vprintf+0x13b>
            width = va_arg(val, int);
  1403fc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140400:	8b 01                	mov    (%rcx),%eax
  140402:	83 f8 2f             	cmp    $0x2f,%eax
  140405:	77 17                	ja     14041e <printer_vprintf+0x11e>
  140407:	89 c2                	mov    %eax,%edx
  140409:	48 03 51 10          	add    0x10(%rcx),%rdx
  14040d:	83 c0 08             	add    $0x8,%eax
  140410:	89 01                	mov    %eax,(%rcx)
  140412:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  140415:	48 83 c3 01          	add    $0x1,%rbx
  140419:	e9 6f ff ff ff       	jmpq   14038d <printer_vprintf+0x8d>
            width = va_arg(val, int);
  14041e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140422:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  140426:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14042a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  14042e:	eb e2                	jmp    140412 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  140430:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  140436:	e9 52 ff ff ff       	jmpq   14038d <printer_vprintf+0x8d>
        int width = -1;
  14043b:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  140441:	e9 47 ff ff ff       	jmpq   14038d <printer_vprintf+0x8d>
            ++format;
  140446:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  14044a:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  14044e:	8d 48 d0             	lea    -0x30(%rax),%ecx
  140451:	80 f9 09             	cmp    $0x9,%cl
  140454:	76 13                	jbe    140469 <printer_vprintf+0x169>
            } else if (*format == '*') {
  140456:	3c 2a                	cmp    $0x2a,%al
  140458:	74 32                	je     14048c <printer_vprintf+0x18c>
            ++format;
  14045a:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  14045d:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  140464:	e9 34 ff ff ff       	jmpq   14039d <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  140469:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  14046e:	48 83 c2 01          	add    $0x1,%rdx
  140472:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  140475:	0f be c0             	movsbl %al,%eax
  140478:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  14047c:	0f b6 02             	movzbl (%rdx),%eax
  14047f:	8d 48 d0             	lea    -0x30(%rax),%ecx
  140482:	80 f9 09             	cmp    $0x9,%cl
  140485:	76 e7                	jbe    14046e <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  140487:	48 89 d3             	mov    %rdx,%rbx
  14048a:	eb 1c                	jmp    1404a8 <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  14048c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140490:	8b 07                	mov    (%rdi),%eax
  140492:	83 f8 2f             	cmp    $0x2f,%eax
  140495:	77 23                	ja     1404ba <printer_vprintf+0x1ba>
  140497:	89 c2                	mov    %eax,%edx
  140499:	48 03 57 10          	add    0x10(%rdi),%rdx
  14049d:	83 c0 08             	add    $0x8,%eax
  1404a0:	89 07                	mov    %eax,(%rdi)
  1404a2:	8b 32                	mov    (%rdx),%esi
                ++format;
  1404a4:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1404a8:	85 f6                	test   %esi,%esi
  1404aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1404af:	0f 48 f0             	cmovs  %eax,%esi
  1404b2:	89 75 9c             	mov    %esi,-0x64(%rbp)
  1404b5:	e9 e3 fe ff ff       	jmpq   14039d <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  1404ba:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1404be:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1404c2:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1404c6:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1404ca:	eb d6                	jmp    1404a2 <printer_vprintf+0x1a2>
        switch (*format) {
  1404cc:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1404d1:	e9 f1 00 00 00       	jmpq   1405c7 <printer_vprintf+0x2c7>
            ++format;
  1404d6:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1404da:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  1404dd:	e9 c0 fe ff ff       	jmpq   1403a2 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1404e2:	85 c9                	test   %ecx,%ecx
  1404e4:	74 55                	je     14053b <printer_vprintf+0x23b>
  1404e6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1404ea:	8b 01                	mov    (%rcx),%eax
  1404ec:	83 f8 2f             	cmp    $0x2f,%eax
  1404ef:	77 38                	ja     140529 <printer_vprintf+0x229>
  1404f1:	89 c2                	mov    %eax,%edx
  1404f3:	48 03 51 10          	add    0x10(%rcx),%rdx
  1404f7:	83 c0 08             	add    $0x8,%eax
  1404fa:	89 01                	mov    %eax,(%rcx)
  1404fc:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1404ff:	48 89 d0             	mov    %rdx,%rax
  140502:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  140506:	49 89 d0             	mov    %rdx,%r8
  140509:	49 f7 d8             	neg    %r8
  14050c:	25 80 00 00 00       	and    $0x80,%eax
  140511:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  140515:	0b 45 a8             	or     -0x58(%rbp),%eax
  140518:	83 c8 60             	or     $0x60,%eax
  14051b:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  14051e:	41 bc 30 10 14 00    	mov    $0x141030,%r12d
            break;
  140524:	e9 35 01 00 00       	jmpq   14065e <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  140529:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  14052d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  140531:	48 8d 42 08          	lea    0x8(%rdx),%rax
  140535:	48 89 47 08          	mov    %rax,0x8(%rdi)
  140539:	eb c1                	jmp    1404fc <printer_vprintf+0x1fc>
  14053b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  14053f:	8b 07                	mov    (%rdi),%eax
  140541:	83 f8 2f             	cmp    $0x2f,%eax
  140544:	77 10                	ja     140556 <printer_vprintf+0x256>
  140546:	89 c2                	mov    %eax,%edx
  140548:	48 03 57 10          	add    0x10(%rdi),%rdx
  14054c:	83 c0 08             	add    $0x8,%eax
  14054f:	89 07                	mov    %eax,(%rdi)
  140551:	48 63 12             	movslq (%rdx),%rdx
  140554:	eb a9                	jmp    1404ff <printer_vprintf+0x1ff>
  140556:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  14055a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  14055e:	48 8d 42 08          	lea    0x8(%rdx),%rax
  140562:	48 89 41 08          	mov    %rax,0x8(%rcx)
  140566:	eb e9                	jmp    140551 <printer_vprintf+0x251>
        int base = 10;
  140568:	be 0a 00 00 00       	mov    $0xa,%esi
  14056d:	eb 58                	jmp    1405c7 <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  14056f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140573:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  140577:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14057b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  14057f:	eb 60                	jmp    1405e1 <printer_vprintf+0x2e1>
  140581:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140585:	8b 01                	mov    (%rcx),%eax
  140587:	83 f8 2f             	cmp    $0x2f,%eax
  14058a:	77 10                	ja     14059c <printer_vprintf+0x29c>
  14058c:	89 c2                	mov    %eax,%edx
  14058e:	48 03 51 10          	add    0x10(%rcx),%rdx
  140592:	83 c0 08             	add    $0x8,%eax
  140595:	89 01                	mov    %eax,(%rcx)
  140597:	44 8b 02             	mov    (%rdx),%r8d
  14059a:	eb 48                	jmp    1405e4 <printer_vprintf+0x2e4>
  14059c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1405a0:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1405a4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1405a8:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1405ac:	eb e9                	jmp    140597 <printer_vprintf+0x297>
  1405ae:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1405b1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1405b8:	bf 10 10 14 00       	mov    $0x141010,%edi
  1405bd:	e9 e6 02 00 00       	jmpq   1408a8 <printer_vprintf+0x5a8>
            base = 16;
  1405c2:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1405c7:	85 c9                	test   %ecx,%ecx
  1405c9:	74 b6                	je     140581 <printer_vprintf+0x281>
  1405cb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1405cf:	8b 07                	mov    (%rdi),%eax
  1405d1:	83 f8 2f             	cmp    $0x2f,%eax
  1405d4:	77 99                	ja     14056f <printer_vprintf+0x26f>
  1405d6:	89 c2                	mov    %eax,%edx
  1405d8:	48 03 57 10          	add    0x10(%rdi),%rdx
  1405dc:	83 c0 08             	add    $0x8,%eax
  1405df:	89 07                	mov    %eax,(%rdi)
  1405e1:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1405e4:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1405e8:	85 f6                	test   %esi,%esi
  1405ea:	79 c2                	jns    1405ae <printer_vprintf+0x2ae>
        base = -base;
  1405ec:	41 89 f1             	mov    %esi,%r9d
  1405ef:	f7 de                	neg    %esi
  1405f1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  1405f8:	bf f0 0f 14 00       	mov    $0x140ff0,%edi
  1405fd:	e9 a6 02 00 00       	jmpq   1408a8 <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  140602:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140606:	8b 07                	mov    (%rdi),%eax
  140608:	83 f8 2f             	cmp    $0x2f,%eax
  14060b:	77 1c                	ja     140629 <printer_vprintf+0x329>
  14060d:	89 c2                	mov    %eax,%edx
  14060f:	48 03 57 10          	add    0x10(%rdi),%rdx
  140613:	83 c0 08             	add    $0x8,%eax
  140616:	89 07                	mov    %eax,(%rdi)
  140618:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  14061b:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  140622:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  140627:	eb c3                	jmp    1405ec <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  140629:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  14062d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  140631:	48 8d 42 08          	lea    0x8(%rdx),%rax
  140635:	48 89 41 08          	mov    %rax,0x8(%rcx)
  140639:	eb dd                	jmp    140618 <printer_vprintf+0x318>
            data = va_arg(val, char*);
  14063b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  14063f:	8b 01                	mov    (%rcx),%eax
  140641:	83 f8 2f             	cmp    $0x2f,%eax
  140644:	0f 87 a9 01 00 00    	ja     1407f3 <printer_vprintf+0x4f3>
  14064a:	89 c2                	mov    %eax,%edx
  14064c:	48 03 51 10          	add    0x10(%rcx),%rdx
  140650:	83 c0 08             	add    $0x8,%eax
  140653:	89 01                	mov    %eax,(%rcx)
  140655:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  140658:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  14065e:	8b 45 a8             	mov    -0x58(%rbp),%eax
  140661:	83 e0 20             	and    $0x20,%eax
  140664:	89 45 8c             	mov    %eax,-0x74(%rbp)
  140667:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  14066d:	0f 85 25 02 00 00    	jne    140898 <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  140673:	8b 45 a8             	mov    -0x58(%rbp),%eax
  140676:	89 45 88             	mov    %eax,-0x78(%rbp)
  140679:	83 e0 60             	and    $0x60,%eax
  14067c:	83 f8 60             	cmp    $0x60,%eax
  14067f:	0f 84 58 02 00 00    	je     1408dd <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  140685:	8b 45 a8             	mov    -0x58(%rbp),%eax
  140688:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  14068b:	48 c7 45 a0 30 10 14 	movq   $0x141030,-0x60(%rbp)
  140692:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  140693:	83 f8 21             	cmp    $0x21,%eax
  140696:	0f 84 7d 02 00 00    	je     140919 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  14069c:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  14069f:	89 c8                	mov    %ecx,%eax
  1406a1:	f7 d0                	not    %eax
  1406a3:	c1 e8 1f             	shr    $0x1f,%eax
  1406a6:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1406a9:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1406ad:	0f 85 a2 02 00 00    	jne    140955 <printer_vprintf+0x655>
  1406b3:	84 c0                	test   %al,%al
  1406b5:	0f 84 9a 02 00 00    	je     140955 <printer_vprintf+0x655>
            len = strnlen(data, precision);
  1406bb:	48 63 f1             	movslq %ecx,%rsi
  1406be:	4c 89 e7             	mov    %r12,%rdi
  1406c1:	e8 61 fb ff ff       	callq  140227 <strnlen>
  1406c6:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1406c9:	8b 45 88             	mov    -0x78(%rbp),%eax
  1406cc:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1406cf:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1406d6:	83 f8 22             	cmp    $0x22,%eax
  1406d9:	0f 84 ae 02 00 00    	je     14098d <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  1406df:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1406e3:	e8 24 fb ff ff       	callq  14020c <strlen>
  1406e8:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1406eb:	03 55 98             	add    -0x68(%rbp),%edx
  1406ee:	41 29 d5             	sub    %edx,%r13d
  1406f1:	44 89 ea             	mov    %r13d,%edx
  1406f4:	29 c2                	sub    %eax,%edx
  1406f6:	89 55 8c             	mov    %edx,-0x74(%rbp)
  1406f9:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  1406fc:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  140700:	75 2d                	jne    14072f <printer_vprintf+0x42f>
  140702:	85 d2                	test   %edx,%edx
  140704:	7e 29                	jle    14072f <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  140706:	44 89 fa             	mov    %r15d,%edx
  140709:	be 20 00 00 00       	mov    $0x20,%esi
  14070e:	4c 89 f7             	mov    %r14,%rdi
  140711:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  140714:	41 83 ed 01          	sub    $0x1,%r13d
  140718:	45 85 ed             	test   %r13d,%r13d
  14071b:	7f e9                	jg     140706 <printer_vprintf+0x406>
  14071d:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  140720:	85 ff                	test   %edi,%edi
  140722:	b8 01 00 00 00       	mov    $0x1,%eax
  140727:	0f 4f c7             	cmovg  %edi,%eax
  14072a:	29 c7                	sub    %eax,%edi
  14072c:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  14072f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  140733:	0f b6 01             	movzbl (%rcx),%eax
  140736:	84 c0                	test   %al,%al
  140738:	74 22                	je     14075c <printer_vprintf+0x45c>
  14073a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  14073e:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  140741:	0f b6 f0             	movzbl %al,%esi
  140744:	44 89 fa             	mov    %r15d,%edx
  140747:	4c 89 f7             	mov    %r14,%rdi
  14074a:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  14074d:	48 83 c3 01          	add    $0x1,%rbx
  140751:	0f b6 03             	movzbl (%rbx),%eax
  140754:	84 c0                	test   %al,%al
  140756:	75 e9                	jne    140741 <printer_vprintf+0x441>
  140758:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  14075c:	8b 45 9c             	mov    -0x64(%rbp),%eax
  14075f:	85 c0                	test   %eax,%eax
  140761:	7e 1d                	jle    140780 <printer_vprintf+0x480>
  140763:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  140767:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  140769:	44 89 fa             	mov    %r15d,%edx
  14076c:	be 30 00 00 00       	mov    $0x30,%esi
  140771:	4c 89 f7             	mov    %r14,%rdi
  140774:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  140777:	83 eb 01             	sub    $0x1,%ebx
  14077a:	75 ed                	jne    140769 <printer_vprintf+0x469>
  14077c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  140780:	8b 45 98             	mov    -0x68(%rbp),%eax
  140783:	85 c0                	test   %eax,%eax
  140785:	7e 2a                	jle    1407b1 <printer_vprintf+0x4b1>
  140787:	8d 40 ff             	lea    -0x1(%rax),%eax
  14078a:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  14078f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  140793:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  140796:	41 0f b6 34 24       	movzbl (%r12),%esi
  14079b:	44 89 fa             	mov    %r15d,%edx
  14079e:	4c 89 f7             	mov    %r14,%rdi
  1407a1:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  1407a4:	49 83 c4 01          	add    $0x1,%r12
  1407a8:	49 39 dc             	cmp    %rbx,%r12
  1407ab:	75 e9                	jne    140796 <printer_vprintf+0x496>
  1407ad:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1407b1:	45 85 ed             	test   %r13d,%r13d
  1407b4:	7e 14                	jle    1407ca <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  1407b6:	44 89 fa             	mov    %r15d,%edx
  1407b9:	be 20 00 00 00       	mov    $0x20,%esi
  1407be:	4c 89 f7             	mov    %r14,%rdi
  1407c1:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  1407c4:	41 83 ed 01          	sub    $0x1,%r13d
  1407c8:	75 ec                	jne    1407b6 <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  1407ca:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1407ce:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1407d2:	84 c0                	test   %al,%al
  1407d4:	0f 84 00 02 00 00    	je     1409da <printer_vprintf+0x6da>
        if (*format != '%') {
  1407da:	3c 25                	cmp    $0x25,%al
  1407dc:	0f 84 53 fb ff ff    	je     140335 <printer_vprintf+0x35>
            p->putc(p, *format, color);
  1407e2:	0f b6 f0             	movzbl %al,%esi
  1407e5:	44 89 fa             	mov    %r15d,%edx
  1407e8:	4c 89 f7             	mov    %r14,%rdi
  1407eb:	41 ff 16             	callq  *(%r14)
            continue;
  1407ee:	4c 89 e3             	mov    %r12,%rbx
  1407f1:	eb d7                	jmp    1407ca <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  1407f3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1407f7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1407fb:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1407ff:	48 89 47 08          	mov    %rax,0x8(%rdi)
  140803:	e9 4d fe ff ff       	jmpq   140655 <printer_vprintf+0x355>
            color = va_arg(val, int);
  140808:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  14080c:	8b 07                	mov    (%rdi),%eax
  14080e:	83 f8 2f             	cmp    $0x2f,%eax
  140811:	77 10                	ja     140823 <printer_vprintf+0x523>
  140813:	89 c2                	mov    %eax,%edx
  140815:	48 03 57 10          	add    0x10(%rdi),%rdx
  140819:	83 c0 08             	add    $0x8,%eax
  14081c:	89 07                	mov    %eax,(%rdi)
  14081e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  140821:	eb a7                	jmp    1407ca <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  140823:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140827:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  14082b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14082f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  140833:	eb e9                	jmp    14081e <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  140835:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  140839:	8b 01                	mov    (%rcx),%eax
  14083b:	83 f8 2f             	cmp    $0x2f,%eax
  14083e:	77 23                	ja     140863 <printer_vprintf+0x563>
  140840:	89 c2                	mov    %eax,%edx
  140842:	48 03 51 10          	add    0x10(%rcx),%rdx
  140846:	83 c0 08             	add    $0x8,%eax
  140849:	89 01                	mov    %eax,(%rcx)
  14084b:	8b 02                	mov    (%rdx),%eax
  14084d:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  140850:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  140854:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  140858:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  14085e:	e9 fb fd ff ff       	jmpq   14065e <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  140863:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  140867:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  14086b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  14086f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  140873:	eb d6                	jmp    14084b <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  140875:	84 d2                	test   %dl,%dl
  140877:	0f 85 3b 01 00 00    	jne    1409b8 <printer_vprintf+0x6b8>
  14087d:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  140881:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  140885:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  140889:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  14088d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  140893:	e9 c6 fd ff ff       	jmpq   14065e <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  140898:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  14089e:	bf 10 10 14 00       	mov    $0x141010,%edi
        if (flags & FLAG_NUMERIC) {
  1408a3:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1408a8:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1408ac:	4c 89 c1             	mov    %r8,%rcx
  1408af:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1408b3:	48 63 f6             	movslq %esi,%rsi
  1408b6:	49 83 ec 01          	sub    $0x1,%r12
  1408ba:	48 89 c8             	mov    %rcx,%rax
  1408bd:	ba 00 00 00 00       	mov    $0x0,%edx
  1408c2:	48 f7 f6             	div    %rsi
  1408c5:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1408c9:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1408cd:	48 89 ca             	mov    %rcx,%rdx
  1408d0:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1408d3:	48 39 d6             	cmp    %rdx,%rsi
  1408d6:	76 de                	jbe    1408b6 <printer_vprintf+0x5b6>
  1408d8:	e9 96 fd ff ff       	jmpq   140673 <printer_vprintf+0x373>
                prefix = "-";
  1408dd:	48 c7 45 a0 27 0e 14 	movq   $0x140e27,-0x60(%rbp)
  1408e4:	00 
            if (flags & FLAG_NEGATIVE) {
  1408e5:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1408e8:	a8 80                	test   $0x80,%al
  1408ea:	0f 85 ac fd ff ff    	jne    14069c <printer_vprintf+0x39c>
                prefix = "+";
  1408f0:	48 c7 45 a0 25 0e 14 	movq   $0x140e25,-0x60(%rbp)
  1408f7:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1408f8:	a8 10                	test   $0x10,%al
  1408fa:	0f 85 9c fd ff ff    	jne    14069c <printer_vprintf+0x39c>
                prefix = " ";
  140900:	a8 08                	test   $0x8,%al
  140902:	ba 30 10 14 00       	mov    $0x141030,%edx
  140907:	b8 2d 10 14 00       	mov    $0x14102d,%eax
  14090c:	48 0f 44 c2          	cmove  %rdx,%rax
  140910:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  140914:	e9 83 fd ff ff       	jmpq   14069c <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  140919:	41 8d 41 10          	lea    0x10(%r9),%eax
  14091d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  140922:	0f 85 74 fd ff ff    	jne    14069c <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  140928:	4d 85 c0             	test   %r8,%r8
  14092b:	75 0d                	jne    14093a <printer_vprintf+0x63a>
  14092d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  140934:	0f 84 62 fd ff ff    	je     14069c <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  14093a:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  14093e:	ba 22 0e 14 00       	mov    $0x140e22,%edx
  140943:	b8 29 0e 14 00       	mov    $0x140e29,%eax
  140948:	48 0f 44 c2          	cmove  %rdx,%rax
  14094c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  140950:	e9 47 fd ff ff       	jmpq   14069c <printer_vprintf+0x39c>
            len = strlen(data);
  140955:	4c 89 e7             	mov    %r12,%rdi
  140958:	e8 af f8 ff ff       	callq  14020c <strlen>
  14095d:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  140960:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  140964:	0f 84 5f fd ff ff    	je     1406c9 <printer_vprintf+0x3c9>
  14096a:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  14096e:	0f 84 55 fd ff ff    	je     1406c9 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  140974:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  140977:	89 fa                	mov    %edi,%edx
  140979:	29 c2                	sub    %eax,%edx
  14097b:	39 c7                	cmp    %eax,%edi
  14097d:	b8 00 00 00 00       	mov    $0x0,%eax
  140982:	0f 4e d0             	cmovle %eax,%edx
  140985:	89 55 9c             	mov    %edx,-0x64(%rbp)
  140988:	e9 52 fd ff ff       	jmpq   1406df <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  14098d:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  140991:	e8 76 f8 ff ff       	callq  14020c <strlen>
  140996:	8b 7d 98             	mov    -0x68(%rbp),%edi
  140999:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  14099c:	44 89 e9             	mov    %r13d,%ecx
  14099f:	29 f9                	sub    %edi,%ecx
  1409a1:	29 c1                	sub    %eax,%ecx
  1409a3:	89 c8                	mov    %ecx,%eax
  1409a5:	44 39 ea             	cmp    %r13d,%edx
  1409a8:	b9 00 00 00 00       	mov    $0x0,%ecx
  1409ad:	0f 4d c1             	cmovge %ecx,%eax
  1409b0:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1409b3:	e9 27 fd ff ff       	jmpq   1406df <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  1409b8:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1409bb:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1409bf:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1409c3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1409c9:	e9 90 fc ff ff       	jmpq   14065e <printer_vprintf+0x35e>
        int flags = 0;
  1409ce:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1409d5:	e9 ad f9 ff ff       	jmpq   140387 <printer_vprintf+0x87>
}
  1409da:	48 83 c4 58          	add    $0x58,%rsp
  1409de:	5b                   	pop    %rbx
  1409df:	41 5c                	pop    %r12
  1409e1:	41 5d                	pop    %r13
  1409e3:	41 5e                	pop    %r14
  1409e5:	41 5f                	pop    %r15
  1409e7:	5d                   	pop    %rbp
  1409e8:	c3                   	retq   

00000000001409e9 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1409e9:	55                   	push   %rbp
  1409ea:	48 89 e5             	mov    %rsp,%rbp
  1409ed:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  1409f1:	48 c7 45 f0 e7 00 14 	movq   $0x1400e7,-0x10(%rbp)
  1409f8:	00 
        cpos = 0;
  1409f9:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  1409ff:	b8 00 00 00 00       	mov    $0x0,%eax
  140a04:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  140a07:	48 63 ff             	movslq %edi,%rdi
  140a0a:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  140a11:	00 
  140a12:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  140a16:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  140a1a:	e8 e1 f8 ff ff       	callq  140300 <printer_vprintf>
    return cp.cursor - console;
  140a1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  140a23:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  140a29:	48 d1 f8             	sar    %rax
}
  140a2c:	c9                   	leaveq 
  140a2d:	c3                   	retq   

0000000000140a2e <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  140a2e:	55                   	push   %rbp
  140a2f:	48 89 e5             	mov    %rsp,%rbp
  140a32:	48 83 ec 50          	sub    $0x50,%rsp
  140a36:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  140a3a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  140a3e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  140a42:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  140a49:	48 8d 45 10          	lea    0x10(%rbp),%rax
  140a4d:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  140a51:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  140a55:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  140a59:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  140a5d:	e8 87 ff ff ff       	callq  1409e9 <console_vprintf>
}
  140a62:	c9                   	leaveq 
  140a63:	c3                   	retq   

0000000000140a64 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  140a64:	55                   	push   %rbp
  140a65:	48 89 e5             	mov    %rsp,%rbp
  140a68:	53                   	push   %rbx
  140a69:	48 83 ec 28          	sub    $0x28,%rsp
  140a6d:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  140a70:	48 c7 45 d8 71 01 14 	movq   $0x140171,-0x28(%rbp)
  140a77:	00 
    sp.s = s;
  140a78:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  140a7c:	48 85 f6             	test   %rsi,%rsi
  140a7f:	75 0e                	jne    140a8f <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  140a81:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  140a85:	48 29 d8             	sub    %rbx,%rax
}
  140a88:	48 83 c4 28          	add    $0x28,%rsp
  140a8c:	5b                   	pop    %rbx
  140a8d:	5d                   	pop    %rbp
  140a8e:	c3                   	retq   
        sp.end = s + size - 1;
  140a8f:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  140a94:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  140a98:	be 00 00 00 00       	mov    $0x0,%esi
  140a9d:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  140aa1:	e8 5a f8 ff ff       	callq  140300 <printer_vprintf>
        *sp.s = 0;
  140aa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  140aaa:	c6 00 00             	movb   $0x0,(%rax)
  140aad:	eb d2                	jmp    140a81 <vsnprintf+0x1d>

0000000000140aaf <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  140aaf:	55                   	push   %rbp
  140ab0:	48 89 e5             	mov    %rsp,%rbp
  140ab3:	48 83 ec 50          	sub    $0x50,%rsp
  140ab7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  140abb:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  140abf:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  140ac3:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  140aca:	48 8d 45 10          	lea    0x10(%rbp),%rax
  140ace:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  140ad2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  140ad6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  140ada:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  140ade:	e8 81 ff ff ff       	callq  140a64 <vsnprintf>
    va_end(val);
    return n;
}
  140ae3:	c9                   	leaveq 
  140ae4:	c3                   	retq   

0000000000140ae5 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  140ae5:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  140aea:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  140aef:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  140af4:	48 83 c0 02          	add    $0x2,%rax
  140af8:	48 39 d0             	cmp    %rdx,%rax
  140afb:	75 f2                	jne    140aef <console_clear+0xa>
    }
    cursorpos = 0;
  140afd:	c7 05 f5 84 f7 ff 00 	movl   $0x0,-0x87b0b(%rip)        # b8ffc <cursorpos>
  140b04:	00 00 00 
}
  140b07:	c3                   	retq   

0000000000140b08 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  140b08:	55                   	push   %rbp
  140b09:	48 89 e5             	mov    %rsp,%rbp
  140b0c:	48 83 ec 50          	sub    $0x50,%rsp
  140b10:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  140b14:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  140b18:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  140b1c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  140b20:	b8 00 07 00 00       	mov    $0x700,%eax
    if (colorid < 0) {
  140b25:	85 ff                	test   %edi,%edi
  140b27:	78 2e                	js     140b57 <app_printf+0x4f>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  140b29:	48 63 ff             	movslq %edi,%rdi
  140b2c:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  140b33:	cc cc cc 
  140b36:	48 89 f8             	mov    %rdi,%rax
  140b39:	48 f7 e2             	mul    %rdx
  140b3c:	48 89 d0             	mov    %rdx,%rax
  140b3f:	48 c1 e8 02          	shr    $0x2,%rax
  140b43:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  140b47:	48 01 c2             	add    %rax,%rdx
  140b4a:	48 29 d7             	sub    %rdx,%rdi
  140b4d:	0f b6 87 60 10 14 00 	movzbl 0x141060(%rdi),%eax
  140b54:	c1 e0 08             	shl    $0x8,%eax
    }

    va_list val;
    va_start(val, format);
  140b57:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  140b5e:	48 8d 4d 10          	lea    0x10(%rbp),%rcx
  140b62:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  140b66:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  140b6a:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  140b6e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  140b72:	48 89 f2             	mov    %rsi,%rdx
  140b75:	89 c6                	mov    %eax,%esi
  140b77:	8b 3d 7f 84 f7 ff    	mov    -0x87b81(%rip),%edi        # b8ffc <cursorpos>
  140b7d:	e8 67 fe ff ff       	callq  1409e9 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  140b82:	3d 30 07 00 00       	cmp    $0x730,%eax
  140b87:	ba 00 00 00 00       	mov    $0x0,%edx
  140b8c:	0f 4d c2             	cmovge %edx,%eax
  140b8f:	89 05 67 84 f7 ff    	mov    %eax,-0x87b99(%rip)        # b8ffc <cursorpos>
    }
}
  140b95:	c9                   	leaveq 
  140b96:	c3                   	retq   

0000000000140b97 <read_line>:
    return result;
}

// read_line
// str should be at least max_chars + 1 byte
int read_line(char * str, int max_chars){
  140b97:	55                   	push   %rbp
  140b98:	48 89 e5             	mov    %rsp,%rbp
  140b9b:	41 56                	push   %r14
  140b9d:	41 55                	push   %r13
  140b9f:	41 54                	push   %r12
  140ba1:	53                   	push   %rbx
  140ba2:	49 89 fd             	mov    %rdi,%r13
  140ba5:	89 f3                	mov    %esi,%ebx
    static char cache[128];
    static int index = 0;
    static int length = 0;

    if(max_chars == 0){
  140ba7:	85 f6                	test   %esi,%esi
  140ba9:	0f 84 8b 00 00 00    	je     140c3a <read_line+0xa3>
        str[max_chars] = '\0';
        return 0;
    }
    str[max_chars + 1] = '\0';
  140baf:	4c 63 f6             	movslq %esi,%r14
  140bb2:	42 c6 44 37 01 00    	movb   $0x0,0x1(%rdi,%r14,1)

    if(index < length){
  140bb8:	8b 3d e6 14 00 00    	mov    0x14e6(%rip),%edi        # 1420a4 <index.1465>
  140bbe:	8b 15 dc 14 00 00    	mov    0x14dc(%rip),%edx        # 1420a0 <length.1466>
  140bc4:	39 d7                	cmp    %edx,%edi
  140bc6:	0f 8d f0 00 00 00    	jge    140cbc <read_line+0x125>
        // some cache left
        int i = 0;
        for(i = index;
                i < length && (i - index + 1 < max_chars);
  140bcc:	83 fe 01             	cmp    $0x1,%esi
  140bcf:	7e 3b                	jle    140c0c <read_line+0x75>
  140bd1:	4c 63 cf             	movslq %edi,%r9
  140bd4:	8d 46 fe             	lea    -0x2(%rsi),%eax
  140bd7:	4d 8d 44 01 01       	lea    0x1(%r9,%rax,1),%r8
  140bdc:	8d 42 ff             	lea    -0x1(%rdx),%eax
  140bdf:	29 f8                	sub    %edi,%eax
  140be1:	4c 01 c8             	add    %r9,%rax
  140be4:	4c 89 c9             	mov    %r9,%rcx
  140be7:	be 01 00 00 00       	mov    $0x1,%esi
  140bec:	29 fe                	sub    %edi,%esi
  140bee:	41 89 cc             	mov    %ecx,%r12d
  140bf1:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
                i++){
            if(cache[i] == '\n'){
  140bf5:	80 b9 20 20 14 00 0a 	cmpb   $0xa,0x142020(%rcx)
  140bfc:	74 4a                	je     140c48 <read_line+0xb1>
        for(i = index;
  140bfe:	48 39 c1             	cmp    %rax,%rcx
  140c01:	74 09                	je     140c0c <read_line+0x75>
  140c03:	48 83 c1 01          	add    $0x1,%rcx
                i < length && (i - index + 1 < max_chars);
  140c07:	4c 39 c1             	cmp    %r8,%rcx
  140c0a:	75 e2                	jne    140bee <read_line+0x57>
                int len = i - index + 1;
                index = i + 1;
                return len;
            }
        }
        if(max_chars <= length - index + 1){
  140c0c:	29 fa                	sub    %edi,%edx
  140c0e:	8d 42 01             	lea    0x1(%rdx),%eax
  140c11:	39 d8                	cmp    %ebx,%eax
  140c13:	7c 67                	jl     140c7c <read_line+0xe5>
            // copy max_chars - 1 bytes and return
            memcpy(str, cache + index, max_chars);
  140c15:	48 63 f7             	movslq %edi,%rsi
  140c18:	48 81 c6 20 20 14 00 	add    $0x142020,%rsi
  140c1f:	4c 89 f2             	mov    %r14,%rdx
  140c22:	4c 89 ef             	mov    %r13,%rdi
  140c25:	e8 5d f5 ff ff       	callq  140187 <memcpy>
            str[max_chars] = '\0';
  140c2a:	43 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%r14,1)
            //app_printf(1, "[%d, %d]-> %sxx", index, index + max_chars - 1, str);
            index += max_chars;
  140c30:	01 1d 6e 14 00 00    	add    %ebx,0x146e(%rip)        # 1420a4 <index.1465>
            return max_chars;
  140c36:	89 d8                	mov    %ebx,%eax
  140c38:	eb 05                	jmp    140c3f <read_line+0xa8>
        str[max_chars] = '\0';
  140c3a:	c6 07 00             	movb   $0x0,(%rdi)
        return 0;
  140c3d:	89 f0                	mov    %esi,%eax
            return 0;
        }
        return read_line(str, max_chars);
    }
    return 0;
}
  140c3f:	5b                   	pop    %rbx
  140c40:	41 5c                	pop    %r12
  140c42:	41 5d                	pop    %r13
  140c44:	41 5e                	pop    %r14
  140c46:	5d                   	pop    %rbp
  140c47:	c3                   	retq   
                memcpy(str, cache + index, i - index + 1);
  140c48:	49 63 d2             	movslq %r10d,%rdx
  140c4b:	49 8d b1 20 20 14 00 	lea    0x142020(%r9),%rsi
  140c52:	4c 89 ef             	mov    %r13,%rdi
  140c55:	e8 2d f5 ff ff       	callq  140187 <memcpy>
                str[i-index+1] = '\0';
  140c5a:	44 89 e3             	mov    %r12d,%ebx
  140c5d:	2b 1d 41 14 00 00    	sub    0x1441(%rip),%ebx        # 1420a4 <index.1465>
  140c63:	48 63 c3             	movslq %ebx,%rax
  140c66:	41 c6 44 05 01 00    	movb   $0x0,0x1(%r13,%rax,1)
                int len = i - index + 1;
  140c6c:	8d 43 01             	lea    0x1(%rbx),%eax
                index = i + 1;
  140c6f:	41 83 c4 01          	add    $0x1,%r12d
  140c73:	44 89 25 2a 14 00 00 	mov    %r12d,0x142a(%rip)        # 1420a4 <index.1465>
                return len;
  140c7a:	eb c3                	jmp    140c3f <read_line+0xa8>
            memcpy(str, cache + index, length - index);
  140c7c:	48 63 d2             	movslq %edx,%rdx
  140c7f:	48 63 f7             	movslq %edi,%rsi
  140c82:	48 81 c6 20 20 14 00 	add    $0x142020,%rsi
  140c89:	4c 89 ef             	mov    %r13,%rdi
  140c8c:	e8 f6 f4 ff ff       	callq  140187 <memcpy>
            str += length - index;
  140c91:	8b 05 09 14 00 00    	mov    0x1409(%rip),%eax        # 1420a0 <length.1466>
  140c97:	41 89 c4             	mov    %eax,%r12d
  140c9a:	44 2b 25 03 14 00 00 	sub    0x1403(%rip),%r12d        # 1420a4 <index.1465>
            index = length;
  140ca1:	89 05 fd 13 00 00    	mov    %eax,0x13fd(%rip)        # 1420a4 <index.1465>
            max_chars -= length - index;
  140ca7:	44 29 e3             	sub    %r12d,%ebx
  140caa:	89 de                	mov    %ebx,%esi
            str += length - index;
  140cac:	49 63 fc             	movslq %r12d,%rdi
  140caf:	4c 01 ef             	add    %r13,%rdi
            len += read_line(str, max_chars);
  140cb2:	e8 e0 fe ff ff       	callq  140b97 <read_line>
  140cb7:	44 01 e0             	add    %r12d,%eax
            return len;
  140cba:	eb 83                	jmp    140c3f <read_line+0xa8>
        index = 0;
  140cbc:	c7 05 de 13 00 00 00 	movl   $0x0,0x13de(%rip)        # 1420a4 <index.1465>
  140cc3:	00 00 00 
    asm volatile ("int %1" : "=a" (result)
  140cc6:	bf 20 20 14 00       	mov    $0x142020,%edi
  140ccb:	cd 37                	int    $0x37
        length = sys_read_serial(cache);
  140ccd:	89 05 cd 13 00 00    	mov    %eax,0x13cd(%rip)        # 1420a0 <length.1466>
        if(length <= 0){
  140cd3:	85 c0                	test   %eax,%eax
  140cd5:	7f 0f                	jg     140ce6 <read_line+0x14f>
            str[0] = '\0';
  140cd7:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
            return 0;
  140cdc:	b8 00 00 00 00       	mov    $0x0,%eax
  140ce1:	e9 59 ff ff ff       	jmpq   140c3f <read_line+0xa8>
        return read_line(str, max_chars);
  140ce6:	4c 89 ef             	mov    %r13,%rdi
  140ce9:	e8 a9 fe ff ff       	callq  140b97 <read_line>
  140cee:	e9 4c ff ff ff       	jmpq   140c3f <read_line+0xa8>

0000000000140cf3 <panic>:

// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  140cf3:	55                   	push   %rbp
  140cf4:	48 89 e5             	mov    %rsp,%rbp
  140cf7:	53                   	push   %rbx
  140cf8:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  140cff:	48 89 fb             	mov    %rdi,%rbx
  140d02:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  140d06:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  140d0a:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  140d0e:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  140d12:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  140d16:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  140d1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  140d21:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  140d25:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  140d29:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  140d2d:	ba 07 00 00 00       	mov    $0x7,%edx
  140d32:	be 27 10 14 00       	mov    $0x141027,%esi
  140d37:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  140d3e:	e8 44 f4 ff ff       	callq  140187 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  140d43:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  140d47:	48 89 da             	mov    %rbx,%rdx
  140d4a:	be 99 00 00 00       	mov    $0x99,%esi
  140d4f:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  140d56:	e8 09 fd ff ff       	callq  140a64 <vsnprintf>
  140d5b:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  140d5e:	85 d2                	test   %edx,%edx
  140d60:	7e 0f                	jle    140d71 <panic+0x7e>
  140d62:	83 c0 06             	add    $0x6,%eax
  140d65:	48 98                	cltq   
  140d67:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  140d6e:	0a 
  140d6f:	75 2a                	jne    140d9b <panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  140d71:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  140d78:	48 89 d9             	mov    %rbx,%rcx
  140d7b:	ba 31 10 14 00       	mov    $0x141031,%edx
  140d80:	be 00 c0 00 00       	mov    $0xc000,%esi
  140d85:	bf 30 07 00 00       	mov    $0x730,%edi
  140d8a:	b8 00 00 00 00       	mov    $0x0,%eax
  140d8f:	e8 9a fc ff ff       	callq  140a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  140d94:	48 89 df             	mov    %rbx,%rdi
  140d97:	cd 30                	int    $0x30
 loop: goto loop;
  140d99:	eb fe                	jmp    140d99 <panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  140d9b:	48 63 c2             	movslq %edx,%rax
  140d9e:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  140da4:	0f 94 c2             	sete   %dl
  140da7:	0f b6 d2             	movzbl %dl,%edx
  140daa:	48 29 d0             	sub    %rdx,%rax
  140dad:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  140db4:	ff 
  140db5:	be 2f 10 14 00       	mov    $0x14102f,%esi
  140dba:	e8 86 f4 ff ff       	callq  140245 <strcpy>
  140dbf:	eb b0                	jmp    140d71 <panic+0x7e>

0000000000140dc1 <assert_fail>:
    sys_panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  140dc1:	55                   	push   %rbp
  140dc2:	48 89 e5             	mov    %rsp,%rbp
  140dc5:	48 89 f9             	mov    %rdi,%rcx
  140dc8:	41 89 f0             	mov    %esi,%r8d
  140dcb:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  140dce:	ba 38 10 14 00       	mov    $0x141038,%edx
  140dd3:	be 00 c0 00 00       	mov    $0xc000,%esi
  140dd8:	bf 30 07 00 00       	mov    $0x730,%edi
  140ddd:	b8 00 00 00 00       	mov    $0x0,%eax
  140de2:	e8 47 fc ff ff       	callq  140a2e <console_printf>
    asm volatile ("int %0"  : /* no result */
  140de7:	bf 00 00 00 00       	mov    $0x0,%edi
  140dec:	cd 30                	int    $0x30
 loop: goto loop;
  140dee:	eb fe                	jmp    140dee <assert_fail+0x2d>
