
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 57                	push   %r15
  2c0006:	41 56                	push   %r14
  2c0008:	41 55                	push   %r13
  2c000a:	41 54                	push   %r12
  2c000c:	53                   	push   %rbx
  2c000d:	48 83 ec 38          	sub    $0x38,%rsp

// sys_getpid
//    Return current process ID.
static inline pid_t sys_getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c0011:	cd 31                	int    $0x31
  2c0013:	41 89 c6             	mov    %eax,%r14d
  2c0016:	89 45 a8             	mov    %eax,-0x58(%rbp)
    
    pid_t p = sys_getpid();
    srand(p);
  2c0019:	89 c7                	mov    %eax,%edi
  2c001b:	e8 04 04 00 00       	callq  2c0424 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c0020:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0025:	e8 13 0c 00 00       	callq  2c0c3d <malloc>
    
    assert(array != NULL);
  2c002a:	48 85 c0             	test   %rax,%rax
  2c002d:	0f 84 c4 00 00 00    	je     2c00f7 <process_main+0xf7>
  2c0033:	48 89 c7             	mov    %rax,%rdi
    assert((uintptr_t)array % 8 == 0);
  2c0036:	83 e0 07             	and    $0x7,%eax
  2c0039:	0f 85 cc 00 00 00    	jne    2c010b <process_main+0x10b>
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c003f:	89 04 87             	mov    %eax,(%rdi,%rax,4)
    for(int  i = 0 ; i < 10; i++){
  2c0042:	48 83 c0 01          	add    $0x1,%rax
  2c0046:	48 83 f8 0a          	cmp    $0xa,%rax
  2c004a:	75 f3                	jne    2c003f <process_main+0x3f>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c004c:	be 50 00 00 00       	mov    $0x50,%esi
  2c0051:	e8 f4 0b 00 00       	callq  2c0c4a <realloc>
  2c0056:	49 89 c4             	mov    %rax,%r12
    
    assert(array != NULL);
  2c0059:	48 85 c0             	test   %rax,%rax
  2c005c:	0f 84 bd 00 00 00    	je     2c011f <process_main+0x11f>
    assert((uintptr_t)array % 8 == 0);
  2c0062:	49 89 c5             	mov    %rax,%r13
  2c0065:	41 83 e5 07          	and    $0x7,%r13d
  2c0069:	4c 89 e8             	mov    %r13,%rax
  2c006c:	0f 85 c1 00 00 00    	jne    2c0133 <process_main+0x133>

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c0072:	41 39 04 84          	cmp    %eax,(%r12,%rax,4)
  2c0076:	0f 85 cb 00 00 00    	jne    2c0147 <process_main+0x147>
    for(int i = 0 ; i < 10 ; i++){
  2c007c:	48 83 c0 01          	add    $0x1,%rax
  2c0080:	48 83 f8 0a          	cmp    $0xa,%rax
  2c0084:	75 ec                	jne    2c0072 <process_main+0x72>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c0086:	be 04 00 00 00       	mov    $0x4,%esi
  2c008b:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0090:	e8 ae 0b 00 00       	callq  2c0c43 <calloc>
  2c0095:	49 89 c7             	mov    %rax,%r15

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c0098:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c009c:	8b 18                	mov    (%rax),%ebx
  2c009e:	85 db                	test   %ebx,%ebx
  2c00a0:	0f 85 b5 00 00 00    	jne    2c015b <process_main+0x15b>
    for(int i = 0 ; i < 30; i++){
  2c00a6:	48 83 c0 04          	add    $0x4,%rax
  2c00aa:	48 39 d0             	cmp    %rdx,%rax
  2c00ad:	75 ed                	jne    2c009c <process_main+0x9c>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c00af:	48 8d 7d b0          	lea    -0x50(%rbp),%rdi
  2c00b3:	e8 99 0b 00 00       	callq  2c0c51 <heap_info>
  2c00b8:	85 c0                	test   %eax,%eax
  2c00ba:	0f 85 af 00 00 00    	jne    2c016f <process_main+0x16f>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00c0:	8b 4d b0             	mov    -0x50(%rbp),%ecx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00c3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
  2c00c7:	b8 01 00 00 00       	mov    $0x1,%eax
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00cc:	39 c1                	cmp    %eax,%ecx
  2c00ce:	0f 8e af 00 00 00    	jle    2c0183 <process_main+0x183>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00d4:	48 8b 34 c2          	mov    (%rdx,%rax,8),%rsi
  2c00d8:	48 83 c0 01          	add    $0x1,%rax
  2c00dc:	48 3b 74 c2 f0       	cmp    -0x10(%rdx,%rax,8),%rsi
  2c00e1:	7c e9                	jl     2c00cc <process_main+0xcc>
  2c00e3:	ba a8 0f 2c 00       	mov    $0x2c0fa8,%edx
  2c00e8:	be 2f 00 00 00       	mov    $0x2f,%esi
  2c00ed:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c00f2:	e8 19 0e 00 00       	callq  2c0f10 <assert_fail>
    assert(array != NULL);
  2c00f7:	ba 40 0f 2c 00       	mov    $0x2c0f40,%edx
  2c00fc:	be 10 00 00 00       	mov    $0x10,%esi
  2c0101:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c0106:	e8 05 0e 00 00       	callq  2c0f10 <assert_fail>
    assert((uintptr_t)array % 8 == 0);
  2c010b:	ba 5d 0f 2c 00       	mov    $0x2c0f5d,%edx
  2c0110:	be 11 00 00 00       	mov    $0x11,%esi
  2c0115:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c011a:	e8 f1 0d 00 00       	callq  2c0f10 <assert_fail>
    assert(array != NULL);
  2c011f:	ba 40 0f 2c 00       	mov    $0x2c0f40,%edx
  2c0124:	be 1b 00 00 00       	mov    $0x1b,%esi
  2c0129:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c012e:	e8 dd 0d 00 00       	callq  2c0f10 <assert_fail>
    assert((uintptr_t)array % 8 == 0);
  2c0133:	ba 5d 0f 2c 00       	mov    $0x2c0f5d,%edx
  2c0138:	be 1c 00 00 00       	mov    $0x1c,%esi
  2c013d:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c0142:	e8 c9 0d 00 00       	callq  2c0f10 <assert_fail>
	assert(array[i] == i);
  2c0147:	ba 77 0f 2c 00       	mov    $0x2c0f77,%edx
  2c014c:	be 20 00 00 00       	mov    $0x20,%esi
  2c0151:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c0156:	e8 b5 0d 00 00       	callq  2c0f10 <assert_fail>
	assert(array2[i] == 0);
  2c015b:	ba 85 0f 2c 00       	mov    $0x2c0f85,%edx
  2c0160:	be 28 00 00 00       	mov    $0x28,%esi
  2c0165:	bf 4e 0f 2c 00       	mov    $0x2c0f4e,%edi
  2c016a:	e8 a1 0d 00 00       	callq  2c0f10 <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c016f:	be 94 0f 2c 00       	mov    $0x2c0f94,%esi
  2c0174:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0179:	b8 00 00 00 00       	mov    $0x0,%eax
  2c017e:	e8 d4 0a 00 00       	callq  2c0c57 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0183:	4c 89 e7             	mov    %r12,%rdi
  2c0186:	e8 be 0a 00 00       	callq  2c0c49 <free>
    free(array2);
  2c018b:	4c 89 ff             	mov    %r15,%rdi
  2c018e:	e8 b6 0a 00 00       	callq  2c0c49 <free>
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c0193:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c0195:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0199:	89 c0                	mov    %eax,%eax
  2c019b:	48 09 c2             	or     %rax,%rdx
  2c019e:	49 89 d4             	mov    %rdx,%r12
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c01a1:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c01a6:	e8 92 0a 00 00       	callq  2c0c3d <malloc>
  2c01ab:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c01ae:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c01b0:	48 c1 e2 20          	shl    $0x20,%rdx
  2c01b4:	89 c0                	mov    %eax,%eax
  2c01b6:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c01b9:	48 89 d0             	mov    %rdx,%rax
  2c01bc:	4c 29 e0             	sub    %r12,%rax
  2c01bf:	49 01 c5             	add    %rax,%r13
	if(ptr == NULL)
  2c01c2:	48 85 c9             	test   %rcx,%rcx
  2c01c5:	74 0a                	je     2c01d1 <process_main+0x1d1>
	    break;
	total_pages++;
  2c01c7:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c01ca:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c01cd:	89 01                	mov    %eax,(%rcx)
    while (1) {
  2c01cf:	eb c2                	jmp    2c0193 <process_main+0x193>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %.2f\n", total_time, (double)total_time/total_pages);
  2c01d1:	48 83 ec 08          	sub    $0x8,%rsp
  2c01d5:	4c 89 6d a8          	mov    %r13,-0x58(%rbp)
  2c01d9:	df 6d a8             	fildll -0x58(%rbp)
  2c01dc:	4d 85 ed             	test   %r13,%r13
  2c01df:	78 33                	js     2c0214 <process_main+0x214>
  2c01e1:	dd 5d a8             	fstpl  -0x58(%rbp)
  2c01e4:	dd 45 a8             	fldl   -0x58(%rbp)
  2c01e7:	89 5d a8             	mov    %ebx,-0x58(%rbp)
  2c01ea:	db 45 a8             	fildl  -0x58(%rbp)
  2c01ed:	de f9                	fdivrp %st,%st(1)
  2c01ef:	48 8d 64 24 f8       	lea    -0x8(%rsp),%rsp
  2c01f4:	dd 1c 24             	fstpl  (%rsp)
  2c01f7:	4c 89 ea             	mov    %r13,%rdx
  2c01fa:	be d8 0f 2c 00       	mov    $0x2c0fd8,%esi
  2c01ff:	44 89 f7             	mov    %r14d,%edi
  2c0202:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0207:	e8 4b 0a 00 00       	callq  2c0c57 <app_printf>
  2c020c:	48 83 c4 10          	add    $0x10,%rsp

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void sys_yield(void) {
    asm volatile ("int %0" : /* no result */
  2c0210:	cd 32                	int    $0x32
  2c0212:	eb fc                	jmp    2c0210 <process_main+0x210>
  2c0214:	d8 05 f2 0d 00 00    	fadds  0xdf2(%rip)        # 2c100c <assert_fail+0xfc>
  2c021a:	eb c5                	jmp    2c01e1 <process_main+0x1e1>

00000000002c021c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c021c:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c021f:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
  2c0226:	00 
  2c0227:	72 08                	jb     2c0231 <console_putc+0x15>
        cp->cursor = console;
  2c0229:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
  2c0230:	00 
    }
    if (c == '\n') {
  2c0231:	40 80 fe 0a          	cmp    $0xa,%sil
  2c0235:	74 17                	je     2c024e <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  2c0237:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c023b:	48 8d 50 02          	lea    0x2(%rax),%rdx
  2c023f:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  2c0243:	40 0f b6 f6          	movzbl %sil,%esi
  2c0247:	44 09 c6             	or     %r8d,%esi
  2c024a:	66 89 30             	mov    %si,(%rax)
    }
}
  2c024d:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
  2c024e:	48 8b 77 08          	mov    0x8(%rdi),%rsi
  2c0252:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
  2c0259:	48 89 f1             	mov    %rsi,%rcx
  2c025c:	48 d1 f9             	sar    %rcx
  2c025f:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c0266:	66 66 66 
  2c0269:	48 89 c8             	mov    %rcx,%rax
  2c026c:	48 f7 ea             	imul   %rdx
  2c026f:	48 c1 fa 05          	sar    $0x5,%rdx
  2c0273:	48 c1 fe 3f          	sar    $0x3f,%rsi
  2c0277:	48 29 f2             	sub    %rsi,%rdx
  2c027a:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
  2c027e:	48 c1 e0 04          	shl    $0x4,%rax
  2c0282:	89 ca                	mov    %ecx,%edx
  2c0284:	29 c2                	sub    %eax,%edx
  2c0286:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
  2c0288:	44 89 c6             	mov    %r8d,%esi
  2c028b:	83 ce 20             	or     $0x20,%esi
  2c028e:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
  2c0292:	4c 8d 41 02          	lea    0x2(%rcx),%r8
  2c0296:	4c 89 47 08          	mov    %r8,0x8(%rdi)
  2c029a:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
  2c029d:	83 c0 01             	add    $0x1,%eax
  2c02a0:	83 f8 50             	cmp    $0x50,%eax
  2c02a3:	75 e9                	jne    2c028e <console_putc+0x72>
  2c02a5:	c3                   	retq   

00000000002c02a6 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  2c02a6:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c02aa:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  2c02ae:	73 0b                	jae    2c02bb <string_putc+0x15>
        *sp->s++ = c;
  2c02b0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c02b4:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  2c02b8:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  2c02bb:	c3                   	retq   

00000000002c02bc <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  2c02bc:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c02bf:	48 85 d2             	test   %rdx,%rdx
  2c02c2:	74 17                	je     2c02db <memcpy+0x1f>
  2c02c4:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  2c02c9:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  2c02ce:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c02d2:	48 83 c1 01          	add    $0x1,%rcx
  2c02d6:	48 39 d1             	cmp    %rdx,%rcx
  2c02d9:	75 ee                	jne    2c02c9 <memcpy+0xd>
}
  2c02db:	c3                   	retq   

00000000002c02dc <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  2c02dc:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  2c02df:	48 39 fe             	cmp    %rdi,%rsi
  2c02e2:	72 1d                	jb     2c0301 <memmove+0x25>
        while (n-- > 0) {
  2c02e4:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c02e9:	48 85 d2             	test   %rdx,%rdx
  2c02ec:	74 12                	je     2c0300 <memmove+0x24>
            *d++ = *s++;
  2c02ee:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  2c02f2:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  2c02f6:	48 83 c1 01          	add    $0x1,%rcx
  2c02fa:	48 39 ca             	cmp    %rcx,%rdx
  2c02fd:	75 ef                	jne    2c02ee <memmove+0x12>
}
  2c02ff:	c3                   	retq   
  2c0300:	c3                   	retq   
    if (s < d && s + n > d) {
  2c0301:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  2c0305:	48 39 cf             	cmp    %rcx,%rdi
  2c0308:	73 da                	jae    2c02e4 <memmove+0x8>
        while (n-- > 0) {
  2c030a:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  2c030e:	48 85 d2             	test   %rdx,%rdx
  2c0311:	74 ec                	je     2c02ff <memmove+0x23>
            *--d = *--s;
  2c0313:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  2c0317:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  2c031a:	48 83 e9 01          	sub    $0x1,%rcx
  2c031e:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  2c0322:	75 ef                	jne    2c0313 <memmove+0x37>
  2c0324:	c3                   	retq   

00000000002c0325 <memset>:
void* memset(void* v, int c, size_t n) {
  2c0325:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0328:	48 85 d2             	test   %rdx,%rdx
  2c032b:	74 13                	je     2c0340 <memset+0x1b>
  2c032d:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
  2c0331:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
  2c0334:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0337:	48 83 c2 01          	add    $0x1,%rdx
  2c033b:	48 39 d1             	cmp    %rdx,%rcx
  2c033e:	75 f4                	jne    2c0334 <memset+0xf>
}
  2c0340:	c3                   	retq   

00000000002c0341 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  2c0341:	80 3f 00             	cmpb   $0x0,(%rdi)
  2c0344:	74 10                	je     2c0356 <strlen+0x15>
  2c0346:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  2c034b:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  2c034f:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  2c0353:	75 f6                	jne    2c034b <strlen+0xa>
  2c0355:	c3                   	retq   
  2c0356:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c035b:	c3                   	retq   

00000000002c035c <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c035c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0361:	48 85 f6             	test   %rsi,%rsi
  2c0364:	74 10                	je     2c0376 <strnlen+0x1a>
  2c0366:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  2c036a:	74 09                	je     2c0375 <strnlen+0x19>
        ++n;
  2c036c:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0370:	48 39 c6             	cmp    %rax,%rsi
  2c0373:	75 f1                	jne    2c0366 <strnlen+0xa>
}
  2c0375:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0376:	48 89 f0             	mov    %rsi,%rax
  2c0379:	c3                   	retq   

00000000002c037a <strcpy>:
char* strcpy(char* dst, const char* src) {
  2c037a:	48 89 f8             	mov    %rdi,%rax
  2c037d:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  2c0382:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  2c0386:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  2c0389:	48 83 c2 01          	add    $0x1,%rdx
  2c038d:	84 c9                	test   %cl,%cl
  2c038f:	75 f1                	jne    2c0382 <strcpy+0x8>
}
  2c0391:	c3                   	retq   

00000000002c0392 <strcmp>:
    while (*a && *b && *a == *b) {
  2c0392:	0f b6 17             	movzbl (%rdi),%edx
  2c0395:	84 d2                	test   %dl,%dl
  2c0397:	74 1a                	je     2c03b3 <strcmp+0x21>
  2c0399:	0f b6 06             	movzbl (%rsi),%eax
  2c039c:	38 d0                	cmp    %dl,%al
  2c039e:	75 13                	jne    2c03b3 <strcmp+0x21>
  2c03a0:	84 c0                	test   %al,%al
  2c03a2:	74 0f                	je     2c03b3 <strcmp+0x21>
        ++a, ++b;
  2c03a4:	48 83 c7 01          	add    $0x1,%rdi
  2c03a8:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  2c03ac:	0f b6 17             	movzbl (%rdi),%edx
  2c03af:	84 d2                	test   %dl,%dl
  2c03b1:	75 e6                	jne    2c0399 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  2c03b3:	0f b6 0e             	movzbl (%rsi),%ecx
  2c03b6:	38 ca                	cmp    %cl,%dl
  2c03b8:	0f 97 c0             	seta   %al
  2c03bb:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  2c03be:	83 d8 00             	sbb    $0x0,%eax
}
  2c03c1:	c3                   	retq   

00000000002c03c2 <strchr>:
    while (*s && *s != (char) c) {
  2c03c2:	0f b6 07             	movzbl (%rdi),%eax
  2c03c5:	84 c0                	test   %al,%al
  2c03c7:	74 10                	je     2c03d9 <strchr+0x17>
  2c03c9:	40 38 f0             	cmp    %sil,%al
  2c03cc:	74 18                	je     2c03e6 <strchr+0x24>
        ++s;
  2c03ce:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  2c03d2:	0f b6 07             	movzbl (%rdi),%eax
  2c03d5:	84 c0                	test   %al,%al
  2c03d7:	75 f0                	jne    2c03c9 <strchr+0x7>
        return NULL;
  2c03d9:	40 84 f6             	test   %sil,%sil
  2c03dc:	b8 00 00 00 00       	mov    $0x0,%eax
  2c03e1:	48 0f 44 c7          	cmove  %rdi,%rax
}
  2c03e5:	c3                   	retq   
  2c03e6:	48 89 f8             	mov    %rdi,%rax
  2c03e9:	c3                   	retq   

00000000002c03ea <rand>:
    if (!rand_seed_set) {
  2c03ea:	83 3d 13 1c 00 00 00 	cmpl   $0x0,0x1c13(%rip)        # 2c2004 <rand_seed_set>
  2c03f1:	74 1b                	je     2c040e <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c03f3:	69 05 03 1c 00 00 0d 	imul   $0x19660d,0x1c03(%rip),%eax        # 2c2000 <rand_seed>
  2c03fa:	66 19 00 
  2c03fd:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0402:	89 05 f8 1b 00 00    	mov    %eax,0x1bf8(%rip)        # 2c2000 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0408:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c040d:	c3                   	retq   
    rand_seed = seed;
  2c040e:	c7 05 e8 1b 00 00 9e 	movl   $0x30d4879e,0x1be8(%rip)        # 2c2000 <rand_seed>
  2c0415:	87 d4 30 
    rand_seed_set = 1;
  2c0418:	c7 05 e2 1b 00 00 01 	movl   $0x1,0x1be2(%rip)        # 2c2004 <rand_seed_set>
  2c041f:	00 00 00 
}
  2c0422:	eb cf                	jmp    2c03f3 <rand+0x9>

00000000002c0424 <srand>:
    rand_seed = seed;
  2c0424:	89 3d d6 1b 00 00    	mov    %edi,0x1bd6(%rip)        # 2c2000 <rand_seed>
    rand_seed_set = 1;
  2c042a:	c7 05 d0 1b 00 00 01 	movl   $0x1,0x1bd0(%rip)        # 2c2004 <rand_seed_set>
  2c0431:	00 00 00 
}
  2c0434:	c3                   	retq   

00000000002c0435 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0435:	55                   	push   %rbp
  2c0436:	48 89 e5             	mov    %rsp,%rbp
  2c0439:	41 57                	push   %r15
  2c043b:	41 56                	push   %r14
  2c043d:	41 55                	push   %r13
  2c043f:	41 54                	push   %r12
  2c0441:	53                   	push   %rbx
  2c0442:	48 83 ec 58          	sub    $0x58,%rsp
  2c0446:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  2c044a:	0f b6 02             	movzbl (%rdx),%eax
  2c044d:	84 c0                	test   %al,%al
  2c044f:	0f 84 ba 06 00 00    	je     2c0b0f <printer_vprintf+0x6da>
  2c0455:	49 89 fe             	mov    %rdi,%r14
  2c0458:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  2c045b:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
  2c0462:	41 89 f7             	mov    %esi,%r15d
  2c0465:	e9 a5 04 00 00       	jmpq   2c090f <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
  2c046a:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  2c046f:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  2c0475:	45 84 e4             	test   %r12b,%r12b
  2c0478:	0f 84 85 06 00 00    	je     2c0b03 <printer_vprintf+0x6ce>
        int flags = 0;
  2c047e:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  2c0484:	41 0f be f4          	movsbl %r12b,%esi
  2c0488:	bf 11 12 2c 00       	mov    $0x2c1211,%edi
  2c048d:	e8 30 ff ff ff       	callq  2c03c2 <strchr>
  2c0492:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  2c0495:	48 85 c0             	test   %rax,%rax
  2c0498:	74 55                	je     2c04ef <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
  2c049a:	48 81 e9 11 12 2c 00 	sub    $0x2c1211,%rcx
  2c04a1:	b8 01 00 00 00       	mov    $0x1,%eax
  2c04a6:	d3 e0                	shl    %cl,%eax
  2c04a8:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  2c04ab:	48 83 c3 01          	add    $0x1,%rbx
  2c04af:	44 0f b6 23          	movzbl (%rbx),%r12d
  2c04b3:	45 84 e4             	test   %r12b,%r12b
  2c04b6:	75 cc                	jne    2c0484 <printer_vprintf+0x4f>
  2c04b8:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  2c04bc:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  2c04c2:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  2c04c9:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  2c04cc:	0f 84 a9 00 00 00    	je     2c057b <printer_vprintf+0x146>
        int length = 0;
  2c04d2:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  2c04d7:	0f b6 13             	movzbl (%rbx),%edx
  2c04da:	8d 42 bd             	lea    -0x43(%rdx),%eax
  2c04dd:	3c 37                	cmp    $0x37,%al
  2c04df:	0f 87 c5 04 00 00    	ja     2c09aa <printer_vprintf+0x575>
  2c04e5:	0f b6 c0             	movzbl %al,%eax
  2c04e8:	ff 24 c5 20 10 2c 00 	jmpq   *0x2c1020(,%rax,8)
  2c04ef:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c04f3:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  2c04f8:	3c 08                	cmp    $0x8,%al
  2c04fa:	77 2f                	ja     2c052b <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c04fc:	0f b6 03             	movzbl (%rbx),%eax
  2c04ff:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c0502:	80 fa 09             	cmp    $0x9,%dl
  2c0505:	77 5e                	ja     2c0565 <printer_vprintf+0x130>
  2c0507:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  2c050d:	48 83 c3 01          	add    $0x1,%rbx
  2c0511:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  2c0516:	0f be c0             	movsbl %al,%eax
  2c0519:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c051e:	0f b6 03             	movzbl (%rbx),%eax
  2c0521:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c0524:	80 fa 09             	cmp    $0x9,%dl
  2c0527:	76 e4                	jbe    2c050d <printer_vprintf+0xd8>
  2c0529:	eb 97                	jmp    2c04c2 <printer_vprintf+0x8d>
        } else if (*format == '*') {
  2c052b:	41 80 fc 2a          	cmp    $0x2a,%r12b
  2c052f:	75 3f                	jne    2c0570 <printer_vprintf+0x13b>
            width = va_arg(val, int);
  2c0531:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0535:	8b 01                	mov    (%rcx),%eax
  2c0537:	83 f8 2f             	cmp    $0x2f,%eax
  2c053a:	77 17                	ja     2c0553 <printer_vprintf+0x11e>
  2c053c:	89 c2                	mov    %eax,%edx
  2c053e:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c0542:	83 c0 08             	add    $0x8,%eax
  2c0545:	89 01                	mov    %eax,(%rcx)
  2c0547:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  2c054a:	48 83 c3 01          	add    $0x1,%rbx
  2c054e:	e9 6f ff ff ff       	jmpq   2c04c2 <printer_vprintf+0x8d>
            width = va_arg(val, int);
  2c0553:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0557:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c055b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c055f:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0563:	eb e2                	jmp    2c0547 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0565:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c056b:	e9 52 ff ff ff       	jmpq   2c04c2 <printer_vprintf+0x8d>
        int width = -1;
  2c0570:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  2c0576:	e9 47 ff ff ff       	jmpq   2c04c2 <printer_vprintf+0x8d>
            ++format;
  2c057b:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  2c057f:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c0583:	8d 48 d0             	lea    -0x30(%rax),%ecx
  2c0586:	80 f9 09             	cmp    $0x9,%cl
  2c0589:	76 13                	jbe    2c059e <printer_vprintf+0x169>
            } else if (*format == '*') {
  2c058b:	3c 2a                	cmp    $0x2a,%al
  2c058d:	74 32                	je     2c05c1 <printer_vprintf+0x18c>
            ++format;
  2c058f:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  2c0592:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  2c0599:	e9 34 ff ff ff       	jmpq   2c04d2 <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c059e:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
  2c05a3:	48 83 c2 01          	add    $0x1,%rdx
  2c05a7:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
  2c05aa:	0f be c0             	movsbl %al,%eax
  2c05ad:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c05b1:	0f b6 02             	movzbl (%rdx),%eax
  2c05b4:	8d 48 d0             	lea    -0x30(%rax),%ecx
  2c05b7:	80 f9 09             	cmp    $0x9,%cl
  2c05ba:	76 e7                	jbe    2c05a3 <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
  2c05bc:	48 89 d3             	mov    %rdx,%rbx
  2c05bf:	eb 1c                	jmp    2c05dd <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
  2c05c1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05c5:	8b 07                	mov    (%rdi),%eax
  2c05c7:	83 f8 2f             	cmp    $0x2f,%eax
  2c05ca:	77 23                	ja     2c05ef <printer_vprintf+0x1ba>
  2c05cc:	89 c2                	mov    %eax,%edx
  2c05ce:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c05d2:	83 c0 08             	add    $0x8,%eax
  2c05d5:	89 07                	mov    %eax,(%rdi)
  2c05d7:	8b 32                	mov    (%rdx),%esi
                ++format;
  2c05d9:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  2c05dd:	85 f6                	test   %esi,%esi
  2c05df:	b8 00 00 00 00       	mov    $0x0,%eax
  2c05e4:	0f 48 f0             	cmovs  %eax,%esi
  2c05e7:	89 75 9c             	mov    %esi,-0x64(%rbp)
  2c05ea:	e9 e3 fe ff ff       	jmpq   2c04d2 <printer_vprintf+0x9d>
                precision = va_arg(val, int);
  2c05ef:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c05f3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c05f7:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05fb:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c05ff:	eb d6                	jmp    2c05d7 <printer_vprintf+0x1a2>
        switch (*format) {
  2c0601:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c0606:	e9 f1 00 00 00       	jmpq   2c06fc <printer_vprintf+0x2c7>
            ++format;
  2c060b:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  2c060f:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
  2c0612:	e9 c0 fe ff ff       	jmpq   2c04d7 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0617:	85 c9                	test   %ecx,%ecx
  2c0619:	74 55                	je     2c0670 <printer_vprintf+0x23b>
  2c061b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c061f:	8b 01                	mov    (%rcx),%eax
  2c0621:	83 f8 2f             	cmp    $0x2f,%eax
  2c0624:	77 38                	ja     2c065e <printer_vprintf+0x229>
  2c0626:	89 c2                	mov    %eax,%edx
  2c0628:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c062c:	83 c0 08             	add    $0x8,%eax
  2c062f:	89 01                	mov    %eax,(%rcx)
  2c0631:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0634:	48 89 d0             	mov    %rdx,%rax
  2c0637:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  2c063b:	49 89 d0             	mov    %rdx,%r8
  2c063e:	49 f7 d8             	neg    %r8
  2c0641:	25 80 00 00 00       	and    $0x80,%eax
  2c0646:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c064a:	0b 45 a8             	or     -0x58(%rbp),%eax
  2c064d:	83 c8 60             	or     $0x60,%eax
  2c0650:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  2c0653:	41 bc a5 0f 2c 00    	mov    $0x2c0fa5,%r12d
            break;
  2c0659:	e9 35 01 00 00       	jmpq   2c0793 <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c065e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0662:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0666:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c066a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c066e:	eb c1                	jmp    2c0631 <printer_vprintf+0x1fc>
  2c0670:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0674:	8b 07                	mov    (%rdi),%eax
  2c0676:	83 f8 2f             	cmp    $0x2f,%eax
  2c0679:	77 10                	ja     2c068b <printer_vprintf+0x256>
  2c067b:	89 c2                	mov    %eax,%edx
  2c067d:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0681:	83 c0 08             	add    $0x8,%eax
  2c0684:	89 07                	mov    %eax,(%rdi)
  2c0686:	48 63 12             	movslq (%rdx),%rdx
  2c0689:	eb a9                	jmp    2c0634 <printer_vprintf+0x1ff>
  2c068b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c068f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0693:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c0697:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c069b:	eb e9                	jmp    2c0686 <printer_vprintf+0x251>
        int base = 10;
  2c069d:	be 0a 00 00 00       	mov    $0xa,%esi
  2c06a2:	eb 58                	jmp    2c06fc <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c06a4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06a8:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c06ac:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c06b0:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c06b4:	eb 60                	jmp    2c0716 <printer_vprintf+0x2e1>
  2c06b6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06ba:	8b 01                	mov    (%rcx),%eax
  2c06bc:	83 f8 2f             	cmp    $0x2f,%eax
  2c06bf:	77 10                	ja     2c06d1 <printer_vprintf+0x29c>
  2c06c1:	89 c2                	mov    %eax,%edx
  2c06c3:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c06c7:	83 c0 08             	add    $0x8,%eax
  2c06ca:	89 01                	mov    %eax,(%rcx)
  2c06cc:	44 8b 02             	mov    (%rdx),%r8d
  2c06cf:	eb 48                	jmp    2c0719 <printer_vprintf+0x2e4>
  2c06d1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c06d5:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c06d9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c06dd:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c06e1:	eb e9                	jmp    2c06cc <printer_vprintf+0x297>
  2c06e3:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  2c06e6:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  2c06ed:	bf 00 12 2c 00       	mov    $0x2c1200,%edi
  2c06f2:	e9 e6 02 00 00       	jmpq   2c09dd <printer_vprintf+0x5a8>
            base = 16;
  2c06f7:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c06fc:	85 c9                	test   %ecx,%ecx
  2c06fe:	74 b6                	je     2c06b6 <printer_vprintf+0x281>
  2c0700:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0704:	8b 07                	mov    (%rdi),%eax
  2c0706:	83 f8 2f             	cmp    $0x2f,%eax
  2c0709:	77 99                	ja     2c06a4 <printer_vprintf+0x26f>
  2c070b:	89 c2                	mov    %eax,%edx
  2c070d:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0711:	83 c0 08             	add    $0x8,%eax
  2c0714:	89 07                	mov    %eax,(%rdi)
  2c0716:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  2c0719:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  2c071d:	85 f6                	test   %esi,%esi
  2c071f:	79 c2                	jns    2c06e3 <printer_vprintf+0x2ae>
        base = -base;
  2c0721:	41 89 f1             	mov    %esi,%r9d
  2c0724:	f7 de                	neg    %esi
  2c0726:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  2c072d:	bf e0 11 2c 00       	mov    $0x2c11e0,%edi
  2c0732:	e9 a6 02 00 00       	jmpq   2c09dd <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
  2c0737:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c073b:	8b 07                	mov    (%rdi),%eax
  2c073d:	83 f8 2f             	cmp    $0x2f,%eax
  2c0740:	77 1c                	ja     2c075e <printer_vprintf+0x329>
  2c0742:	89 c2                	mov    %eax,%edx
  2c0744:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0748:	83 c0 08             	add    $0x8,%eax
  2c074b:	89 07                	mov    %eax,(%rdi)
  2c074d:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c0750:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  2c0757:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c075c:	eb c3                	jmp    2c0721 <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
  2c075e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0762:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0766:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c076a:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c076e:	eb dd                	jmp    2c074d <printer_vprintf+0x318>
            data = va_arg(val, char*);
  2c0770:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0774:	8b 01                	mov    (%rcx),%eax
  2c0776:	83 f8 2f             	cmp    $0x2f,%eax
  2c0779:	0f 87 a9 01 00 00    	ja     2c0928 <printer_vprintf+0x4f3>
  2c077f:	89 c2                	mov    %eax,%edx
  2c0781:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c0785:	83 c0 08             	add    $0x8,%eax
  2c0788:	89 01                	mov    %eax,(%rcx)
  2c078a:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  2c078d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  2c0793:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0796:	83 e0 20             	and    $0x20,%eax
  2c0799:	89 45 8c             	mov    %eax,-0x74(%rbp)
  2c079c:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  2c07a2:	0f 85 25 02 00 00    	jne    2c09cd <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c07a8:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c07ab:	89 45 88             	mov    %eax,-0x78(%rbp)
  2c07ae:	83 e0 60             	and    $0x60,%eax
  2c07b1:	83 f8 60             	cmp    $0x60,%eax
  2c07b4:	0f 84 58 02 00 00    	je     2c0a12 <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c07ba:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c07bd:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  2c07c0:	48 c7 45 a0 a5 0f 2c 	movq   $0x2c0fa5,-0x60(%rbp)
  2c07c7:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c07c8:	83 f8 21             	cmp    $0x21,%eax
  2c07cb:	0f 84 7d 02 00 00    	je     2c0a4e <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c07d1:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  2c07d4:	89 c8                	mov    %ecx,%eax
  2c07d6:	f7 d0                	not    %eax
  2c07d8:	c1 e8 1f             	shr    $0x1f,%eax
  2c07db:	89 45 84             	mov    %eax,-0x7c(%rbp)
  2c07de:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c07e2:	0f 85 a2 02 00 00    	jne    2c0a8a <printer_vprintf+0x655>
  2c07e8:	84 c0                	test   %al,%al
  2c07ea:	0f 84 9a 02 00 00    	je     2c0a8a <printer_vprintf+0x655>
            len = strnlen(data, precision);
  2c07f0:	48 63 f1             	movslq %ecx,%rsi
  2c07f3:	4c 89 e7             	mov    %r12,%rdi
  2c07f6:	e8 61 fb ff ff       	callq  2c035c <strnlen>
  2c07fb:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c07fe:	8b 45 88             	mov    -0x78(%rbp),%eax
  2c0801:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  2c0804:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c080b:	83 f8 22             	cmp    $0x22,%eax
  2c080e:	0f 84 ae 02 00 00    	je     2c0ac2 <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
  2c0814:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0818:	e8 24 fb ff ff       	callq  2c0341 <strlen>
  2c081d:	8b 55 9c             	mov    -0x64(%rbp),%edx
  2c0820:	03 55 98             	add    -0x68(%rbp),%edx
  2c0823:	41 29 d5             	sub    %edx,%r13d
  2c0826:	44 89 ea             	mov    %r13d,%edx
  2c0829:	29 c2                	sub    %eax,%edx
  2c082b:	89 55 8c             	mov    %edx,-0x74(%rbp)
  2c082e:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c0831:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  2c0835:	75 2d                	jne    2c0864 <printer_vprintf+0x42f>
  2c0837:	85 d2                	test   %edx,%edx
  2c0839:	7e 29                	jle    2c0864 <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
  2c083b:	44 89 fa             	mov    %r15d,%edx
  2c083e:	be 20 00 00 00       	mov    $0x20,%esi
  2c0843:	4c 89 f7             	mov    %r14,%rdi
  2c0846:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c0849:	41 83 ed 01          	sub    $0x1,%r13d
  2c084d:	45 85 ed             	test   %r13d,%r13d
  2c0850:	7f e9                	jg     2c083b <printer_vprintf+0x406>
  2c0852:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  2c0855:	85 ff                	test   %edi,%edi
  2c0857:	b8 01 00 00 00       	mov    $0x1,%eax
  2c085c:	0f 4f c7             	cmovg  %edi,%eax
  2c085f:	29 c7                	sub    %eax,%edi
  2c0861:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  2c0864:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
  2c0868:	0f b6 01             	movzbl (%rcx),%eax
  2c086b:	84 c0                	test   %al,%al
  2c086d:	74 22                	je     2c0891 <printer_vprintf+0x45c>
  2c086f:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c0873:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
  2c0876:	0f b6 f0             	movzbl %al,%esi
  2c0879:	44 89 fa             	mov    %r15d,%edx
  2c087c:	4c 89 f7             	mov    %r14,%rdi
  2c087f:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
  2c0882:	48 83 c3 01          	add    $0x1,%rbx
  2c0886:	0f b6 03             	movzbl (%rbx),%eax
  2c0889:	84 c0                	test   %al,%al
  2c088b:	75 e9                	jne    2c0876 <printer_vprintf+0x441>
  2c088d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  2c0891:	8b 45 9c             	mov    -0x64(%rbp),%eax
  2c0894:	85 c0                	test   %eax,%eax
  2c0896:	7e 1d                	jle    2c08b5 <printer_vprintf+0x480>
  2c0898:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c089c:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  2c089e:	44 89 fa             	mov    %r15d,%edx
  2c08a1:	be 30 00 00 00       	mov    $0x30,%esi
  2c08a6:	4c 89 f7             	mov    %r14,%rdi
  2c08a9:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
  2c08ac:	83 eb 01             	sub    $0x1,%ebx
  2c08af:	75 ed                	jne    2c089e <printer_vprintf+0x469>
  2c08b1:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  2c08b5:	8b 45 98             	mov    -0x68(%rbp),%eax
  2c08b8:	85 c0                	test   %eax,%eax
  2c08ba:	7e 2a                	jle    2c08e6 <printer_vprintf+0x4b1>
  2c08bc:	8d 40 ff             	lea    -0x1(%rax),%eax
  2c08bf:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
  2c08c4:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c08c8:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  2c08cb:	41 0f b6 34 24       	movzbl (%r12),%esi
  2c08d0:	44 89 fa             	mov    %r15d,%edx
  2c08d3:	4c 89 f7             	mov    %r14,%rdi
  2c08d6:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
  2c08d9:	49 83 c4 01          	add    $0x1,%r12
  2c08dd:	49 39 dc             	cmp    %rbx,%r12
  2c08e0:	75 e9                	jne    2c08cb <printer_vprintf+0x496>
  2c08e2:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  2c08e6:	45 85 ed             	test   %r13d,%r13d
  2c08e9:	7e 14                	jle    2c08ff <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
  2c08eb:	44 89 fa             	mov    %r15d,%edx
  2c08ee:	be 20 00 00 00       	mov    $0x20,%esi
  2c08f3:	4c 89 f7             	mov    %r14,%rdi
  2c08f6:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
  2c08f9:	41 83 ed 01          	sub    $0x1,%r13d
  2c08fd:	75 ec                	jne    2c08eb <printer_vprintf+0x4b6>
    for (; *format; ++format) {
  2c08ff:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  2c0903:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c0907:	84 c0                	test   %al,%al
  2c0909:	0f 84 00 02 00 00    	je     2c0b0f <printer_vprintf+0x6da>
        if (*format != '%') {
  2c090f:	3c 25                	cmp    $0x25,%al
  2c0911:	0f 84 53 fb ff ff    	je     2c046a <printer_vprintf+0x35>
            p->putc(p, *format, color);
  2c0917:	0f b6 f0             	movzbl %al,%esi
  2c091a:	44 89 fa             	mov    %r15d,%edx
  2c091d:	4c 89 f7             	mov    %r14,%rdi
  2c0920:	41 ff 16             	callq  *(%r14)
            continue;
  2c0923:	4c 89 e3             	mov    %r12,%rbx
  2c0926:	eb d7                	jmp    2c08ff <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
  2c0928:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c092c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0930:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c0934:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0938:	e9 4d fe ff ff       	jmpq   2c078a <printer_vprintf+0x355>
            color = va_arg(val, int);
  2c093d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0941:	8b 07                	mov    (%rdi),%eax
  2c0943:	83 f8 2f             	cmp    $0x2f,%eax
  2c0946:	77 10                	ja     2c0958 <printer_vprintf+0x523>
  2c0948:	89 c2                	mov    %eax,%edx
  2c094a:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c094e:	83 c0 08             	add    $0x8,%eax
  2c0951:	89 07                	mov    %eax,(%rdi)
  2c0953:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  2c0956:	eb a7                	jmp    2c08ff <printer_vprintf+0x4ca>
            color = va_arg(val, int);
  2c0958:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c095c:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0960:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c0964:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c0968:	eb e9                	jmp    2c0953 <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
  2c096a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c096e:	8b 01                	mov    (%rcx),%eax
  2c0970:	83 f8 2f             	cmp    $0x2f,%eax
  2c0973:	77 23                	ja     2c0998 <printer_vprintf+0x563>
  2c0975:	89 c2                	mov    %eax,%edx
  2c0977:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c097b:	83 c0 08             	add    $0x8,%eax
  2c097e:	89 01                	mov    %eax,(%rcx)
  2c0980:	8b 02                	mov    (%rdx),%eax
  2c0982:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  2c0985:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c0989:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c098d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  2c0993:	e9 fb fd ff ff       	jmpq   2c0793 <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
  2c0998:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c099c:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c09a0:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c09a4:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c09a8:	eb d6                	jmp    2c0980 <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
  2c09aa:	84 d2                	test   %dl,%dl
  2c09ac:	0f 85 3b 01 00 00    	jne    2c0aed <printer_vprintf+0x6b8>
  2c09b2:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  2c09b6:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  2c09ba:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  2c09be:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c09c2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c09c8:	e9 c6 fd ff ff       	jmpq   2c0793 <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
  2c09cd:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  2c09d3:	bf 00 12 2c 00       	mov    $0x2c1200,%edi
        if (flags & FLAG_NUMERIC) {
  2c09d8:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  2c09dd:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  2c09e1:	4c 89 c1             	mov    %r8,%rcx
  2c09e4:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  2c09e8:	48 63 f6             	movslq %esi,%rsi
  2c09eb:	49 83 ec 01          	sub    $0x1,%r12
  2c09ef:	48 89 c8             	mov    %rcx,%rax
  2c09f2:	ba 00 00 00 00       	mov    $0x0,%edx
  2c09f7:	48 f7 f6             	div    %rsi
  2c09fa:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  2c09fe:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  2c0a02:	48 89 ca             	mov    %rcx,%rdx
  2c0a05:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  2c0a08:	48 39 d6             	cmp    %rdx,%rsi
  2c0a0b:	76 de                	jbe    2c09eb <printer_vprintf+0x5b6>
  2c0a0d:	e9 96 fd ff ff       	jmpq   2c07a8 <printer_vprintf+0x373>
                prefix = "-";
  2c0a12:	48 c7 45 a0 15 10 2c 	movq   $0x2c1015,-0x60(%rbp)
  2c0a19:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0a1a:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0a1d:	a8 80                	test   $0x80,%al
  2c0a1f:	0f 85 ac fd ff ff    	jne    2c07d1 <printer_vprintf+0x39c>
                prefix = "+";
  2c0a25:	48 c7 45 a0 13 10 2c 	movq   $0x2c1013,-0x60(%rbp)
  2c0a2c:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0a2d:	a8 10                	test   $0x10,%al
  2c0a2f:	0f 85 9c fd ff ff    	jne    2c07d1 <printer_vprintf+0x39c>
                prefix = " ";
  2c0a35:	a8 08                	test   $0x8,%al
  2c0a37:	ba a5 0f 2c 00       	mov    $0x2c0fa5,%edx
  2c0a3c:	b8 1d 12 2c 00       	mov    $0x2c121d,%eax
  2c0a41:	48 0f 44 c2          	cmove  %rdx,%rax
  2c0a45:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c0a49:	e9 83 fd ff ff       	jmpq   2c07d1 <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
  2c0a4e:	41 8d 41 10          	lea    0x10(%r9),%eax
  2c0a52:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  2c0a57:	0f 85 74 fd ff ff    	jne    2c07d1 <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
  2c0a5d:	4d 85 c0             	test   %r8,%r8
  2c0a60:	75 0d                	jne    2c0a6f <printer_vprintf+0x63a>
  2c0a62:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  2c0a69:	0f 84 62 fd ff ff    	je     2c07d1 <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
  2c0a6f:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  2c0a73:	ba 10 10 2c 00       	mov    $0x2c1010,%edx
  2c0a78:	b8 17 10 2c 00       	mov    $0x2c1017,%eax
  2c0a7d:	48 0f 44 c2          	cmove  %rdx,%rax
  2c0a81:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c0a85:	e9 47 fd ff ff       	jmpq   2c07d1 <printer_vprintf+0x39c>
            len = strlen(data);
  2c0a8a:	4c 89 e7             	mov    %r12,%rdi
  2c0a8d:	e8 af f8 ff ff       	callq  2c0341 <strlen>
  2c0a92:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c0a95:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c0a99:	0f 84 5f fd ff ff    	je     2c07fe <printer_vprintf+0x3c9>
  2c0a9f:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  2c0aa3:	0f 84 55 fd ff ff    	je     2c07fe <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
  2c0aa9:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  2c0aac:	89 fa                	mov    %edi,%edx
  2c0aae:	29 c2                	sub    %eax,%edx
  2c0ab0:	39 c7                	cmp    %eax,%edi
  2c0ab2:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0ab7:	0f 4e d0             	cmovle %eax,%edx
  2c0aba:	89 55 9c             	mov    %edx,-0x64(%rbp)
  2c0abd:	e9 52 fd ff ff       	jmpq   2c0814 <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
  2c0ac2:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0ac6:	e8 76 f8 ff ff       	callq  2c0341 <strlen>
  2c0acb:	8b 7d 98             	mov    -0x68(%rbp),%edi
  2c0ace:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  2c0ad1:	44 89 e9             	mov    %r13d,%ecx
  2c0ad4:	29 f9                	sub    %edi,%ecx
  2c0ad6:	29 c1                	sub    %eax,%ecx
  2c0ad8:	89 c8                	mov    %ecx,%eax
  2c0ada:	44 39 ea             	cmp    %r13d,%edx
  2c0add:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c0ae2:	0f 4d c1             	cmovge %ecx,%eax
  2c0ae5:	89 45 9c             	mov    %eax,-0x64(%rbp)
  2c0ae8:	e9 27 fd ff ff       	jmpq   2c0814 <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
  2c0aed:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  2c0af0:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c0af4:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c0af8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0afe:	e9 90 fc ff ff       	jmpq   2c0793 <printer_vprintf+0x35e>
        int flags = 0;
  2c0b03:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  2c0b0a:	e9 ad f9 ff ff       	jmpq   2c04bc <printer_vprintf+0x87>
}
  2c0b0f:	48 83 c4 58          	add    $0x58,%rsp
  2c0b13:	5b                   	pop    %rbx
  2c0b14:	41 5c                	pop    %r12
  2c0b16:	41 5d                	pop    %r13
  2c0b18:	41 5e                	pop    %r14
  2c0b1a:	41 5f                	pop    %r15
  2c0b1c:	5d                   	pop    %rbp
  2c0b1d:	c3                   	retq   

00000000002c0b1e <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c0b1e:	55                   	push   %rbp
  2c0b1f:	48 89 e5             	mov    %rsp,%rbp
  2c0b22:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  2c0b26:	48 c7 45 f0 1c 02 2c 	movq   $0x2c021c,-0x10(%rbp)
  2c0b2d:	00 
        cpos = 0;
  2c0b2e:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  2c0b34:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0b39:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  2c0b3c:	48 63 ff             	movslq %edi,%rdi
  2c0b3f:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  2c0b46:	00 
  2c0b47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c0b4b:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  2c0b4f:	e8 e1 f8 ff ff       	callq  2c0435 <printer_vprintf>
    return cp.cursor - console;
  2c0b54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b58:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c0b5e:	48 d1 f8             	sar    %rax
}
  2c0b61:	c9                   	leaveq 
  2c0b62:	c3                   	retq   

00000000002c0b63 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  2c0b63:	55                   	push   %rbp
  2c0b64:	48 89 e5             	mov    %rsp,%rbp
  2c0b67:	48 83 ec 50          	sub    $0x50,%rsp
  2c0b6b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0b6f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0b73:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  2c0b77:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0b7e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0b82:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0b86:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0b8a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c0b8e:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0b92:	e8 87 ff ff ff       	callq  2c0b1e <console_vprintf>
}
  2c0b97:	c9                   	leaveq 
  2c0b98:	c3                   	retq   

00000000002c0b99 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c0b99:	55                   	push   %rbp
  2c0b9a:	48 89 e5             	mov    %rsp,%rbp
  2c0b9d:	53                   	push   %rbx
  2c0b9e:	48 83 ec 28          	sub    $0x28,%rsp
  2c0ba2:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  2c0ba5:	48 c7 45 d8 a6 02 2c 	movq   $0x2c02a6,-0x28(%rbp)
  2c0bac:	00 
    sp.s = s;
  2c0bad:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  2c0bb1:	48 85 f6             	test   %rsi,%rsi
  2c0bb4:	75 0e                	jne    2c0bc4 <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  2c0bb6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0bba:	48 29 d8             	sub    %rbx,%rax
}
  2c0bbd:	48 83 c4 28          	add    $0x28,%rsp
  2c0bc1:	5b                   	pop    %rbx
  2c0bc2:	5d                   	pop    %rbp
  2c0bc3:	c3                   	retq   
        sp.end = s + size - 1;
  2c0bc4:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  2c0bc9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c0bcd:	be 00 00 00 00       	mov    $0x0,%esi
  2c0bd2:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  2c0bd6:	e8 5a f8 ff ff       	callq  2c0435 <printer_vprintf>
        *sp.s = 0;
  2c0bdb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0bdf:	c6 00 00             	movb   $0x0,(%rax)
  2c0be2:	eb d2                	jmp    2c0bb6 <vsnprintf+0x1d>

00000000002c0be4 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c0be4:	55                   	push   %rbp
  2c0be5:	48 89 e5             	mov    %rsp,%rbp
  2c0be8:	48 83 ec 50          	sub    $0x50,%rsp
  2c0bec:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0bf0:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0bf4:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c0bf8:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0bff:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0c03:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0c07:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0c0b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c0c0f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0c13:	e8 81 ff ff ff       	callq  2c0b99 <vsnprintf>
    va_end(val);
    return n;
}
  2c0c18:	c9                   	leaveq 
  2c0c19:	c3                   	retq   

00000000002c0c1a <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0c1a:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  2c0c1f:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  2c0c24:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0c29:	48 83 c0 02          	add    $0x2,%rax
  2c0c2d:	48 39 d0             	cmp    %rdx,%rax
  2c0c30:	75 f2                	jne    2c0c24 <console_clear+0xa>
    }
    cursorpos = 0;
  2c0c32:	c7 05 c0 83 df ff 00 	movl   $0x0,-0x207c40(%rip)        # b8ffc <cursorpos>
  2c0c39:	00 00 00 
}
  2c0c3c:	c3                   	retq   

00000000002c0c3d <malloc>:

// TODO: Implement these functions

void * malloc(uint64_t sz){
    return NULL;
}
  2c0c3d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0c42:	c3                   	retq   

00000000002c0c43 <calloc>:

void * calloc(uint64_t num, uint64_t sz){
    return NULL;
}
  2c0c43:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0c48:	c3                   	retq   

00000000002c0c49 <free>:

void free(void * ptr){

}
  2c0c49:	c3                   	retq   

00000000002c0c4a <realloc>:

void * realloc(void * ptr, uint64_t sz){
    return NULL;
}
  2c0c4a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0c4f:	c3                   	retq   

00000000002c0c50 <defrag>:

void defrag(){

}
  2c0c50:	c3                   	retq   

00000000002c0c51 <heap_info>:

int heap_info(heap_info_struct * info){

    return -1;
}
  2c0c51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c0c56:	c3                   	retq   

00000000002c0c57 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0c57:	55                   	push   %rbp
  2c0c58:	48 89 e5             	mov    %rsp,%rbp
  2c0c5b:	48 83 ec 50          	sub    $0x50,%rsp
  2c0c5f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c0c63:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0c67:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0c6b:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c0c6f:	b8 00 07 00 00       	mov    $0x700,%eax
    if (colorid < 0) {
  2c0c74:	85 ff                	test   %edi,%edi
  2c0c76:	78 2e                	js     2c0ca6 <app_printf+0x4f>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c0c78:	48 63 ff             	movslq %edi,%rdi
  2c0c7b:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c0c82:	cc cc cc 
  2c0c85:	48 89 f8             	mov    %rdi,%rax
  2c0c88:	48 f7 e2             	mul    %rdx
  2c0c8b:	48 89 d0             	mov    %rdx,%rax
  2c0c8e:	48 c1 e8 02          	shr    $0x2,%rax
  2c0c92:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c0c96:	48 01 c2             	add    %rax,%rdx
  2c0c99:	48 29 d7             	sub    %rdx,%rdi
  2c0c9c:	0f b6 87 50 12 2c 00 	movzbl 0x2c1250(%rdi),%eax
  2c0ca3:	c1 e0 08             	shl    $0x8,%eax
    }

    va_list val;
    va_start(val, format);
  2c0ca6:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c0cad:	48 8d 4d 10          	lea    0x10(%rbp),%rcx
  2c0cb1:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  2c0cb5:	48 8d 4d d0          	lea    -0x30(%rbp),%rcx
  2c0cb9:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c0cbd:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0cc1:	48 89 f2             	mov    %rsi,%rdx
  2c0cc4:	89 c6                	mov    %eax,%esi
  2c0cc6:	8b 3d 30 83 df ff    	mov    -0x207cd0(%rip),%edi        # b8ffc <cursorpos>
  2c0ccc:	e8 4d fe ff ff       	callq  2c0b1e <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c0cd1:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0cd6:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0cdb:	0f 4d c2             	cmovge %edx,%eax
  2c0cde:	89 05 18 83 df ff    	mov    %eax,-0x207ce8(%rip)        # b8ffc <cursorpos>
    }
}
  2c0ce4:	c9                   	leaveq 
  2c0ce5:	c3                   	retq   

00000000002c0ce6 <read_line>:
    return result;
}

// read_line
// str should be at least max_chars + 1 byte
int read_line(char * str, int max_chars){
  2c0ce6:	55                   	push   %rbp
  2c0ce7:	48 89 e5             	mov    %rsp,%rbp
  2c0cea:	41 56                	push   %r14
  2c0cec:	41 55                	push   %r13
  2c0cee:	41 54                	push   %r12
  2c0cf0:	53                   	push   %rbx
  2c0cf1:	49 89 fd             	mov    %rdi,%r13
  2c0cf4:	89 f3                	mov    %esi,%ebx
    static char cache[128];
    static int index = 0;
    static int length = 0;

    if(max_chars == 0){
  2c0cf6:	85 f6                	test   %esi,%esi
  2c0cf8:	0f 84 8b 00 00 00    	je     2c0d89 <read_line+0xa3>
        str[max_chars] = '\0';
        return 0;
    }
    str[max_chars + 1] = '\0';
  2c0cfe:	4c 63 f6             	movslq %esi,%r14
  2c0d01:	42 c6 44 37 01 00    	movb   $0x0,0x1(%rdi,%r14,1)

    if(index < length){
  2c0d07:	8b 3d 97 13 00 00    	mov    0x1397(%rip),%edi        # 2c20a4 <index.1465>
  2c0d0d:	8b 15 8d 13 00 00    	mov    0x138d(%rip),%edx        # 2c20a0 <length.1466>
  2c0d13:	39 d7                	cmp    %edx,%edi
  2c0d15:	0f 8d f0 00 00 00    	jge    2c0e0b <read_line+0x125>
        // some cache left
        int i = 0;
        for(i = index;
                i < length && (i - index + 1 < max_chars);
  2c0d1b:	83 fe 01             	cmp    $0x1,%esi
  2c0d1e:	7e 3b                	jle    2c0d5b <read_line+0x75>
  2c0d20:	4c 63 cf             	movslq %edi,%r9
  2c0d23:	8d 46 fe             	lea    -0x2(%rsi),%eax
  2c0d26:	4d 8d 44 01 01       	lea    0x1(%r9,%rax,1),%r8
  2c0d2b:	8d 42 ff             	lea    -0x1(%rdx),%eax
  2c0d2e:	29 f8                	sub    %edi,%eax
  2c0d30:	4c 01 c8             	add    %r9,%rax
  2c0d33:	4c 89 c9             	mov    %r9,%rcx
  2c0d36:	be 01 00 00 00       	mov    $0x1,%esi
  2c0d3b:	29 fe                	sub    %edi,%esi
  2c0d3d:	41 89 cc             	mov    %ecx,%r12d
  2c0d40:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
                i++){
            if(cache[i] == '\n'){
  2c0d44:	80 b9 20 20 2c 00 0a 	cmpb   $0xa,0x2c2020(%rcx)
  2c0d4b:	74 4a                	je     2c0d97 <read_line+0xb1>
        for(i = index;
  2c0d4d:	48 39 c1             	cmp    %rax,%rcx
  2c0d50:	74 09                	je     2c0d5b <read_line+0x75>
  2c0d52:	48 83 c1 01          	add    $0x1,%rcx
                i < length && (i - index + 1 < max_chars);
  2c0d56:	4c 39 c1             	cmp    %r8,%rcx
  2c0d59:	75 e2                	jne    2c0d3d <read_line+0x57>
                int len = i - index + 1;
                index = i + 1;
                return len;
            }
        }
        if(max_chars <= length - index + 1){
  2c0d5b:	29 fa                	sub    %edi,%edx
  2c0d5d:	8d 42 01             	lea    0x1(%rdx),%eax
  2c0d60:	39 d8                	cmp    %ebx,%eax
  2c0d62:	7c 67                	jl     2c0dcb <read_line+0xe5>
            // copy max_chars - 1 bytes and return
            memcpy(str, cache + index, max_chars);
  2c0d64:	48 63 f7             	movslq %edi,%rsi
  2c0d67:	48 81 c6 20 20 2c 00 	add    $0x2c2020,%rsi
  2c0d6e:	4c 89 f2             	mov    %r14,%rdx
  2c0d71:	4c 89 ef             	mov    %r13,%rdi
  2c0d74:	e8 43 f5 ff ff       	callq  2c02bc <memcpy>
            str[max_chars] = '\0';
  2c0d79:	43 c6 44 35 00 00    	movb   $0x0,0x0(%r13,%r14,1)
            //app_printf(1, "[%d, %d]-> %sxx", index, index + max_chars - 1, str);
            index += max_chars;
  2c0d7f:	01 1d 1f 13 00 00    	add    %ebx,0x131f(%rip)        # 2c20a4 <index.1465>
            return max_chars;
  2c0d85:	89 d8                	mov    %ebx,%eax
  2c0d87:	eb 05                	jmp    2c0d8e <read_line+0xa8>
        str[max_chars] = '\0';
  2c0d89:	c6 07 00             	movb   $0x0,(%rdi)
        return 0;
  2c0d8c:	89 f0                	mov    %esi,%eax
            return 0;
        }
        return read_line(str, max_chars);
    }
    return 0;
}
  2c0d8e:	5b                   	pop    %rbx
  2c0d8f:	41 5c                	pop    %r12
  2c0d91:	41 5d                	pop    %r13
  2c0d93:	41 5e                	pop    %r14
  2c0d95:	5d                   	pop    %rbp
  2c0d96:	c3                   	retq   
                memcpy(str, cache + index, i - index + 1);
  2c0d97:	49 63 d2             	movslq %r10d,%rdx
  2c0d9a:	49 8d b1 20 20 2c 00 	lea    0x2c2020(%r9),%rsi
  2c0da1:	4c 89 ef             	mov    %r13,%rdi
  2c0da4:	e8 13 f5 ff ff       	callq  2c02bc <memcpy>
                str[i-index+1] = '\0';
  2c0da9:	44 89 e3             	mov    %r12d,%ebx
  2c0dac:	2b 1d f2 12 00 00    	sub    0x12f2(%rip),%ebx        # 2c20a4 <index.1465>
  2c0db2:	48 63 c3             	movslq %ebx,%rax
  2c0db5:	41 c6 44 05 01 00    	movb   $0x0,0x1(%r13,%rax,1)
                int len = i - index + 1;
  2c0dbb:	8d 43 01             	lea    0x1(%rbx),%eax
                index = i + 1;
  2c0dbe:	41 83 c4 01          	add    $0x1,%r12d
  2c0dc2:	44 89 25 db 12 00 00 	mov    %r12d,0x12db(%rip)        # 2c20a4 <index.1465>
                return len;
  2c0dc9:	eb c3                	jmp    2c0d8e <read_line+0xa8>
            memcpy(str, cache + index, length - index);
  2c0dcb:	48 63 d2             	movslq %edx,%rdx
  2c0dce:	48 63 f7             	movslq %edi,%rsi
  2c0dd1:	48 81 c6 20 20 2c 00 	add    $0x2c2020,%rsi
  2c0dd8:	4c 89 ef             	mov    %r13,%rdi
  2c0ddb:	e8 dc f4 ff ff       	callq  2c02bc <memcpy>
            str += length - index;
  2c0de0:	8b 05 ba 12 00 00    	mov    0x12ba(%rip),%eax        # 2c20a0 <length.1466>
  2c0de6:	41 89 c4             	mov    %eax,%r12d
  2c0de9:	44 2b 25 b4 12 00 00 	sub    0x12b4(%rip),%r12d        # 2c20a4 <index.1465>
            index = length;
  2c0df0:	89 05 ae 12 00 00    	mov    %eax,0x12ae(%rip)        # 2c20a4 <index.1465>
            max_chars -= length - index;
  2c0df6:	44 29 e3             	sub    %r12d,%ebx
  2c0df9:	89 de                	mov    %ebx,%esi
            str += length - index;
  2c0dfb:	49 63 fc             	movslq %r12d,%rdi
  2c0dfe:	4c 01 ef             	add    %r13,%rdi
            len += read_line(str, max_chars);
  2c0e01:	e8 e0 fe ff ff       	callq  2c0ce6 <read_line>
  2c0e06:	44 01 e0             	add    %r12d,%eax
            return len;
  2c0e09:	eb 83                	jmp    2c0d8e <read_line+0xa8>
        index = 0;
  2c0e0b:	c7 05 8f 12 00 00 00 	movl   $0x0,0x128f(%rip)        # 2c20a4 <index.1465>
  2c0e12:	00 00 00 
    asm volatile ("int %1" : "=a" (result)
  2c0e15:	bf 20 20 2c 00       	mov    $0x2c2020,%edi
  2c0e1a:	cd 37                	int    $0x37
        length = sys_read_serial(cache);
  2c0e1c:	89 05 7e 12 00 00    	mov    %eax,0x127e(%rip)        # 2c20a0 <length.1466>
        if(length <= 0){
  2c0e22:	85 c0                	test   %eax,%eax
  2c0e24:	7f 0f                	jg     2c0e35 <read_line+0x14f>
            str[0] = '\0';
  2c0e26:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
            return 0;
  2c0e2b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0e30:	e9 59 ff ff ff       	jmpq   2c0d8e <read_line+0xa8>
        return read_line(str, max_chars);
  2c0e35:	4c 89 ef             	mov    %r13,%rdi
  2c0e38:	e8 a9 fe ff ff       	callq  2c0ce6 <read_line>
  2c0e3d:	e9 4c ff ff ff       	jmpq   2c0d8e <read_line+0xa8>

00000000002c0e42 <panic>:

// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  2c0e42:	55                   	push   %rbp
  2c0e43:	48 89 e5             	mov    %rsp,%rbp
  2c0e46:	53                   	push   %rbx
  2c0e47:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c0e4e:	48 89 fb             	mov    %rdi,%rbx
  2c0e51:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0e55:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0e59:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c0e5d:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c0e61:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0e65:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c0e6c:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0e70:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0e74:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0e78:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c0e7c:	ba 07 00 00 00       	mov    $0x7,%edx
  2c0e81:	be 17 12 2c 00       	mov    $0x2c1217,%esi
  2c0e86:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c0e8d:	e8 2a f4 ff ff       	callq  2c02bc <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0e92:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0e96:	48 89 da             	mov    %rbx,%rdx
  2c0e99:	be 99 00 00 00       	mov    $0x99,%esi
  2c0e9e:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0ea5:	e8 ef fc ff ff       	callq  2c0b99 <vsnprintf>
  2c0eaa:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c0ead:	85 d2                	test   %edx,%edx
  2c0eaf:	7e 0f                	jle    2c0ec0 <panic+0x7e>
  2c0eb1:	83 c0 06             	add    $0x6,%eax
  2c0eb4:	48 98                	cltq   
  2c0eb6:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c0ebd:	0a 
  2c0ebe:	75 2a                	jne    2c0eea <panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c0ec0:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0ec7:	48 89 d9             	mov    %rbx,%rcx
  2c0eca:	ba 1f 12 2c 00       	mov    $0x2c121f,%edx
  2c0ecf:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0ed4:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0ed9:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0ede:	e8 80 fc ff ff       	callq  2c0b63 <console_printf>
}

// sys_panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) sys_panic(const char* msg) {
    asm volatile ("int %0"  : /* no result */
  2c0ee3:	48 89 df             	mov    %rbx,%rdi
  2c0ee6:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c0ee8:	eb fe                	jmp    2c0ee8 <panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c0eea:	48 63 c2             	movslq %edx,%rax
  2c0eed:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c0ef3:	0f 94 c2             	sete   %dl
  2c0ef6:	0f b6 d2             	movzbl %dl,%edx
  2c0ef9:	48 29 d0             	sub    %rdx,%rax
  2c0efc:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c0f03:	ff 
  2c0f04:	be a4 0f 2c 00       	mov    $0x2c0fa4,%esi
  2c0f09:	e8 6c f4 ff ff       	callq  2c037a <strcpy>
  2c0f0e:	eb b0                	jmp    2c0ec0 <panic+0x7e>

00000000002c0f10 <assert_fail>:
    sys_panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c0f10:	55                   	push   %rbp
  2c0f11:	48 89 e5             	mov    %rsp,%rbp
  2c0f14:	48 89 f9             	mov    %rdi,%rcx
  2c0f17:	41 89 f0             	mov    %esi,%r8d
  2c0f1a:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c0f1d:	ba 28 12 2c 00       	mov    $0x2c1228,%edx
  2c0f22:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c0f27:	bf 30 07 00 00       	mov    $0x730,%edi
  2c0f2c:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0f31:	e8 2d fc ff ff       	callq  2c0b63 <console_printf>
    asm volatile ("int %0"  : /* no result */
  2c0f36:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0f3b:	cd 30                	int    $0x30
 loop: goto loop;
  2c0f3d:	eb fe                	jmp    2c0f3d <assert_fail+0x2d>
