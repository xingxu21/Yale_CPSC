
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	pushq  $0x0
        popfq
   4000c:	9d                   	popfq  
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmpq   40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	pushq  $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	pushq  $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	pushq  $0x0
        pushq $32
   40038:	6a 20                	pushq  $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	pushq  $0x0
        pushq $48
   4003e:	6a 30                	pushq  $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	pushq  $0x0
        pushq $49
   40044:	6a 31                	pushq  $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	pushq  $0x0
        pushq $50
   4004a:	6a 32                	pushq  $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	pushq  $0x0
        pushq $51
   40050:	6a 33                	pushq  $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	pushq  $0x0
        pushq $52
   40056:	6a 34                	pushq  $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	pushq  $0x0
        pushq $53
   4005c:	6a 35                	pushq  $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	pushq  $0x0
        pushq $54
   40062:	6a 36                	pushq  $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	pushq  $0x0
        pushq $55
   40068:	6a 37                	pushq  $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	pushq  $0x0
        pushq $56
   4006e:	6a 38                	pushq  $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	pushq  $0x0
        pushq $57
   40074:	6a 39                	pushq  $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	pushq  $0x0
        pushq $58
   4007a:	6a 3a                	pushq  $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	pushq  $0x0
        pushq $59
   40080:	6a 3b                	pushq  $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	pushq  $0x0
        pushq $60
   40086:	6a 3c                	pushq  $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	pushq  $0x0
        pushq $61
   4008c:	6a 3d                	pushq  $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	pushq  $0x0
        pushq $62
   40092:	6a 3e                	pushq  $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	pushq  $0x0
        pushq $63
   40098:	6a 3f                	pushq  $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	pushq  $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	pushq  %gs
        pushq %fs
   400a2:	0f a0                	pushq  %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 6e 05 00 00       	callq  40631 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	popq   %fs
        popq %gs
   400df:	0f a9                	popq   %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 f5 12 00 00       	callq  4146d <hardware_init>
    pageinfo_init();
   40178:	e8 23 09 00 00       	callq  40aa0 <pageinfo_init>
    console_clear();
   4017d:	e8 d3 36 00 00       	callq  43855 <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 b5 17 00 00       	callq  41941 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 20 90 05 00       	mov    $0x59020,%edi
   4019b:	e8 c0 2d 00 00       	callq  42f60 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 20 90 05 00 	lea    0x59020(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 26                	je     40220 <kernel+0xb9>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be e6 43 04 00       	mov    $0x443e6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 c2 2d 00 00       	callq  42fcd <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 11                	jne    40220 <kernel+0xb9>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 75 00 00 00       	callq  40293 <process_setup>
   4021e:	eb 69                	jmp    40289 <kernel+0x122>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40220:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40225:	74 26                	je     4024d <kernel+0xe6>
   40227:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022b:	be ed 43 04 00       	mov    $0x443ed,%esi
   40230:	48 89 c7             	mov    %rax,%rdi
   40233:	e8 95 2d 00 00       	callq  42fcd <strcmp>
   40238:	85 c0                	test   %eax,%eax
   4023a:	75 11                	jne    4024d <kernel+0xe6>
        process_setup(1, 5);
   4023c:	be 05 00 00 00       	mov    $0x5,%esi
   40241:	bf 01 00 00 00       	mov    $0x1,%edi
   40246:	e8 48 00 00 00       	callq  40293 <process_setup>
   4024b:	eb 3c                	jmp    40289 <kernel+0x122>
    } else if (command && strcmp(command, "test") == 0){
   4024d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40252:	74 26                	je     4027a <kernel+0x113>
   40254:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40258:	be f8 43 04 00       	mov    $0x443f8,%esi
   4025d:	48 89 c7             	mov    %rax,%rdi
   40260:	e8 68 2d 00 00       	callq  42fcd <strcmp>
   40265:	85 c0                	test   %eax,%eax
   40267:	75 11                	jne    4027a <kernel+0x113>
        process_setup(1, 6);
   40269:	be 06 00 00 00       	mov    $0x6,%esi
   4026e:	bf 01 00 00 00       	mov    $0x1,%edi
   40273:	e8 1b 00 00 00       	callq  40293 <process_setup>
   40278:	eb 0f                	jmp    40289 <kernel+0x122>
    } else {
	process_setup(1, 0);
   4027a:	be 00 00 00 00       	mov    $0x0,%esi
   4027f:	bf 01 00 00 00       	mov    $0x1,%edi
   40284:	e8 0a 00 00 00       	callq  40293 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   40289:	bf 10 91 05 00       	mov    $0x59110,%edi
   4028e:	e8 7c 07 00 00       	callq  40a0f <run>

0000000000040293 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40293:	55                   	push   %rbp
   40294:	48 89 e5             	mov    %rsp,%rbp
   40297:	48 83 ec 10          	sub    $0x10,%rsp
   4029b:	89 7d fc             	mov    %edi,-0x4(%rbp)
   4029e:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402a4:	48 63 d0             	movslq %eax,%rdx
   402a7:	48 89 d0             	mov    %rdx,%rax
   402aa:	48 c1 e0 04          	shl    $0x4,%rax
   402ae:	48 29 d0             	sub    %rdx,%rax
   402b1:	48 c1 e0 04          	shl    $0x4,%rax
   402b5:	48 05 20 90 05 00    	add    $0x59020,%rax
   402bb:	be 00 00 00 00       	mov    $0x0,%esi
   402c0:	48 89 c7             	mov    %rax,%rdi
   402c3:	e8 d0 1f 00 00       	callq  42298 <process_init>

    assert(process_config_tables(pid) == 0);
   402c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402cb:	89 c7                	mov    %eax,%edi
   402cd:	e8 a1 39 00 00       	callq  43c73 <process_config_tables>
   402d2:	85 c0                	test   %eax,%eax
   402d4:	74 14                	je     402ea <process_setup+0x57>
   402d6:	ba 00 44 04 00       	mov    $0x44400,%edx
   402db:	be 6b 00 00 00       	mov    $0x6b,%esi
   402e0:	bf 20 44 04 00       	mov    $0x44420,%edi
   402e5:	e8 ec 27 00 00       	callq  42ad6 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   402ea:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402ed:	48 63 d0             	movslq %eax,%rdx
   402f0:	48 89 d0             	mov    %rdx,%rax
   402f3:	48 c1 e0 04          	shl    $0x4,%rax
   402f7:	48 29 d0             	sub    %rdx,%rax
   402fa:	48 c1 e0 04          	shl    $0x4,%rax
   402fe:	48 8d 90 20 90 05 00 	lea    0x59020(%rax),%rdx
   40305:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40308:	89 c6                	mov    %eax,%esi
   4030a:	48 89 d7             	mov    %rdx,%rdi
   4030d:	e8 af 3c 00 00       	callq  43fc1 <process_load>
   40312:	85 c0                	test   %eax,%eax
   40314:	79 14                	jns    4032a <process_setup+0x97>
   40316:	ba 30 44 04 00       	mov    $0x44430,%edx
   4031b:	be 6e 00 00 00       	mov    $0x6e,%esi
   40320:	bf 20 44 04 00       	mov    $0x44420,%edi
   40325:	e8 ac 27 00 00       	callq  42ad6 <assert_fail>

    process_setup_stack(&processes[pid]);
   4032a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4032d:	48 63 d0             	movslq %eax,%rdx
   40330:	48 89 d0             	mov    %rdx,%rax
   40333:	48 c1 e0 04          	shl    $0x4,%rax
   40337:	48 29 d0             	sub    %rdx,%rax
   4033a:	48 c1 e0 04          	shl    $0x4,%rax
   4033e:	48 05 20 90 05 00    	add    $0x59020,%rax
   40344:	48 89 c7             	mov    %rax,%rdi
   40347:	e8 ad 3c 00 00       	callq  43ff9 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4034c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4034f:	48 63 d0             	movslq %eax,%rdx
   40352:	48 89 d0             	mov    %rdx,%rax
   40355:	48 c1 e0 04          	shl    $0x4,%rax
   40359:	48 29 d0             	sub    %rdx,%rax
   4035c:	48 c1 e0 04          	shl    $0x4,%rax
   40360:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   40366:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   4036c:	90                   	nop
   4036d:	c9                   	leaveq 
   4036e:	c3                   	retq   

000000000004036f <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   4036f:	55                   	push   %rbp
   40370:	48 89 e5             	mov    %rsp,%rbp
   40373:	48 83 ec 10          	sub    $0x10,%rsp
   40377:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4037b:	89 f0                	mov    %esi,%eax
   4037d:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40380:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40384:	25 ff 0f 00 00       	and    $0xfff,%eax
   40389:	48 85 c0             	test   %rax,%rax
   4038c:	75 20                	jne    403ae <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   4038e:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40395:	00 
   40396:	77 16                	ja     403ae <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   40398:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4039c:	48 c1 e8 0c          	shr    $0xc,%rax
   403a0:	48 98                	cltq   
   403a2:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   403a9:	00 
   403aa:	84 c0                	test   %al,%al
   403ac:	74 07                	je     403b5 <assign_physical_page+0x46>
        return -1;
   403ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403b3:	eb 2c                	jmp    403e1 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403b9:	48 c1 e8 0c          	shr    $0xc,%rax
   403bd:	48 98                	cltq   
   403bf:	c6 84 00 41 9f 05 00 	movb   $0x1,0x59f41(%rax,%rax,1)
   403c6:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   403c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403cb:	48 c1 e8 0c          	shr    $0xc,%rax
   403cf:	48 98                	cltq   
   403d1:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   403d5:	88 94 00 40 9f 05 00 	mov    %dl,0x59f40(%rax,%rax,1)
        return 0;
   403dc:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   403e1:	c9                   	leaveq 
   403e2:	c3                   	retq   

00000000000403e3 <syscall_fork>:


pid_t syscall_fork() {
   403e3:	55                   	push   %rbp
   403e4:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   403e7:	48 8b 05 32 9b 01 00 	mov    0x19b32(%rip),%rax        # 59f20 <current>
   403ee:	48 89 c7             	mov    %rax,%rdi
   403f1:	e8 b6 3c 00 00       	callq  440ac <process_fork>
}
   403f6:	5d                   	pop    %rbp
   403f7:	c3                   	retq   

00000000000403f8 <syscall_exit>:


void syscall_exit() {
   403f8:	55                   	push   %rbp
   403f9:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   403fc:	48 8b 05 1d 9b 01 00 	mov    0x19b1d(%rip),%rax        # 59f20 <current>
   40403:	8b 00                	mov    (%rax),%eax
   40405:	89 c7                	mov    %eax,%edi
   40407:	e8 85 35 00 00       	callq  43991 <process_free>
}
   4040c:	90                   	nop
   4040d:	5d                   	pop    %rbp
   4040e:	c3                   	retq   

000000000004040f <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   4040f:	55                   	push   %rbp
   40410:	48 89 e5             	mov    %rsp,%rbp
   40413:	48 83 ec 10          	sub    $0x10,%rsp
   40417:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4041b:	48 8b 05 fe 9a 01 00 	mov    0x19afe(%rip),%rax        # 59f20 <current>
   40422:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40426:	48 89 d6             	mov    %rdx,%rsi
   40429:	48 89 c7             	mov    %rax,%rdi
   4042c:	e8 0d 3f 00 00       	callq  4433e <process_page_alloc>
}
   40431:	c9                   	leaveq 
   40432:	c3                   	retq   

0000000000040433 <syscall_read_serial>:


int syscall_read_serial(proc * p) {
   40433:	55                   	push   %rbp
   40434:	48 89 e5             	mov    %rsp,%rbp
   40437:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
   4043e:	48 89 bd 48 ff ff ff 	mov    %rdi,-0xb8(%rbp)
    uintptr_t addr = p->p_registers.reg_rdi;
   40445:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
   4044c:	48 8b 40 48          	mov    0x48(%rax),%rax
   40450:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    vamapping map = virtual_memory_lookup(p->p_pagetable, addr);
   40454:	48 8b 85 48 ff ff ff 	mov    -0xb8(%rbp),%rax
   4045b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40462:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40466:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4046a:	48 89 ce             	mov    %rcx,%rsi
   4046d:	48 89 c7             	mov    %rax,%rdi
   40470:	e8 36 1a 00 00       	callq  41eab <virtual_memory_lookup>
    char str[128];
    for(int  i = 0 ; i < 128 ; i++){
   40475:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4047c:	eb 56                	jmp    404d4 <syscall_read_serial+0xa1>
	int ret = 0;
   4047e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
	while((ret = scan_port(str + i)) == 0);
   40485:	90                   	nop
   40486:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40489:	48 98                	cltq   
   4048b:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
   40492:	48 01 d0             	add    %rdx,%rax
   40495:	48 89 c7             	mov    %rax,%rdi
   40498:	e8 6f 22 00 00       	callq  4270c <scan_port>
   4049d:	89 45 ec             	mov    %eax,-0x14(%rbp)
   404a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   404a4:	74 e0                	je     40486 <syscall_read_serial+0x53>
	if(ret == -1){
   404a6:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   404aa:	75 24                	jne    404d0 <syscall_read_serial+0x9d>
	    memcpy((void *)map.pa, str, i);
   404ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   404af:	48 63 d0             	movslq %eax,%rdx
   404b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404b6:	48 89 c1             	mov    %rax,%rcx
   404b9:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   404c0:	48 89 c6             	mov    %rax,%rsi
   404c3:	48 89 cf             	mov    %rcx,%rdi
   404c6:	e8 2c 2a 00 00       	callq  42ef7 <memcpy>
	    return i;
   404cb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   404ce:	eb 2d                	jmp    404fd <syscall_read_serial+0xca>
    for(int  i = 0 ; i < 128 ; i++){
   404d0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   404d4:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   404d8:	7e a4                	jle    4047e <syscall_read_serial+0x4b>
	}
    }
    memcpy((void *)map.pa, str, 128);
   404da:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404de:	48 89 c1             	mov    %rax,%rcx
   404e1:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
   404e8:	ba 80 00 00 00       	mov    $0x80,%edx
   404ed:	48 89 c6             	mov    %rax,%rsi
   404f0:	48 89 cf             	mov    %rcx,%rdi
   404f3:	e8 ff 29 00 00       	callq  42ef7 <memcpy>
    return 128;
   404f8:	b8 80 00 00 00       	mov    $0x80,%eax
}
   404fd:	c9                   	leaveq 
   404fe:	c3                   	retq   

00000000000404ff <syscall_mapping>:

void syscall_mapping(proc* p){
   404ff:	55                   	push   %rbp
   40500:	48 89 e5             	mov    %rsp,%rbp
   40503:	48 83 ec 70          	sub    $0x70,%rsp
   40507:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   4050b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4050f:	48 8b 40 48          	mov    0x48(%rax),%rax
   40513:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40517:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4051b:	48 8b 40 40          	mov    0x40(%rax),%rax
   4051f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40523:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40527:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4052e:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40532:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40536:	48 89 ce             	mov    %rcx,%rsi
   40539:	48 89 c7             	mov    %rax,%rdi
   4053c:	e8 6a 19 00 00       	callq  41eab <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   40541:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40544:	48 98                	cltq   
   40546:	83 e0 06             	and    $0x6,%eax
   40549:	48 83 f8 06          	cmp    $0x6,%rax
   4054d:	75 73                	jne    405c2 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   4054f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40553:	48 83 c0 17          	add    $0x17,%rax
   40557:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   4055b:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4055f:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40566:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   4056a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4056e:	48 89 ce             	mov    %rcx,%rsi
   40571:	48 89 c7             	mov    %rax,%rdi
   40574:	e8 32 19 00 00       	callq  41eab <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40579:	8b 45 c8             	mov    -0x38(%rbp),%eax
   4057c:	48 98                	cltq   
   4057e:	83 e0 03             	and    $0x3,%eax
   40581:	48 83 f8 03          	cmp    $0x3,%rax
   40585:	75 3e                	jne    405c5 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   40587:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4058b:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40592:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40596:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4059a:	48 89 ce             	mov    %rcx,%rsi
   4059d:	48 89 c7             	mov    %rax,%rdi
   405a0:	e8 06 19 00 00       	callq  41eab <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   405a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   405a9:	48 89 c1             	mov    %rax,%rcx
   405ac:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   405b0:	ba 18 00 00 00       	mov    $0x18,%edx
   405b5:	48 89 c6             	mov    %rax,%rsi
   405b8:	48 89 cf             	mov    %rcx,%rdi
   405bb:	e8 37 29 00 00       	callq  42ef7 <memcpy>
   405c0:	eb 04                	jmp    405c6 <syscall_mapping+0xc7>
	return;
   405c2:	90                   	nop
   405c3:	eb 01                	jmp    405c6 <syscall_mapping+0xc7>
	return;
   405c5:	90                   	nop
}
   405c6:	c9                   	leaveq 
   405c7:	c3                   	retq   

00000000000405c8 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   405c8:	55                   	push   %rbp
   405c9:	48 89 e5             	mov    %rsp,%rbp
   405cc:	48 83 ec 18          	sub    $0x18,%rsp
   405d0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   405d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405d8:	48 8b 40 48          	mov    0x48(%rax),%rax
   405dc:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   405df:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405e3:	75 14                	jne    405f9 <syscall_mem_tog+0x31>
	disp_global = !disp_global;
   405e5:	0f b6 05 14 5a 00 00 	movzbl 0x5a14(%rip),%eax        # 46000 <start_data>
   405ec:	84 c0                	test   %al,%al
   405ee:	0f 94 c0             	sete   %al
   405f1:	88 05 09 5a 00 00    	mov    %al,0x5a09(%rip)        # 46000 <start_data>
   405f7:	eb 36                	jmp    4062f <syscall_mem_tog+0x67>
    }
    else {
	if(p < 0 || p > NPROC || p != process->p_pid)
   405f9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   405fd:	78 2f                	js     4062e <syscall_mem_tog+0x66>
   405ff:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   40603:	7f 29                	jg     4062e <syscall_mem_tog+0x66>
   40605:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40609:	8b 00                	mov    (%rax),%eax
   4060b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4060e:	75 1e                	jne    4062e <syscall_mem_tog+0x66>
	    return;
	process->display_status = !(process->display_status);
   40610:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40614:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   4061b:	84 c0                	test   %al,%al
   4061d:	0f 94 c0             	sete   %al
   40620:	89 c2                	mov    %eax,%edx
   40622:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40626:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   4062c:	eb 01                	jmp    4062f <syscall_mem_tog+0x67>
	    return;
   4062e:	90                   	nop
    }
}
   4062f:	c9                   	leaveq 
   40630:	c3                   	retq   

0000000000040631 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40631:	55                   	push   %rbp
   40632:	48 89 e5             	mov    %rsp,%rbp
   40635:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
   4063c:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40643:	48 8b 05 d6 98 01 00 	mov    0x198d6(%rip),%rax        # 59f20 <current>
   4064a:	48 8b 95 18 ff ff ff 	mov    -0xe8(%rbp),%rdx
   40651:	48 83 c0 18          	add    $0x18,%rax
   40655:	48 89 d6             	mov    %rdx,%rsi
   40658:	ba 18 00 00 00       	mov    $0x18,%edx
   4065d:	48 89 c7             	mov    %rax,%rdi
   40660:	48 89 d1             	mov    %rdx,%rcx
   40663:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40666:	48 8b 05 d3 9c 01 00 	mov    0x19cd3(%rip),%rax        # 5a340 <kernel_pagetable>
   4066d:	48 89 c7             	mov    %rax,%rdi
   40670:	e8 2d 19 00 00       	callq  41fa2 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40675:	8b 05 81 89 07 00    	mov    0x78981(%rip),%eax        # b8ffc <cursorpos>
   4067b:	89 c7                	mov    %eax,%edi
   4067d:	e8 e0 1c 00 00       	callq  42362 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT 
   40682:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   40689:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40690:	48 83 f8 0e          	cmp    $0xe,%rax
   40694:	74 14                	je     406aa <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   40696:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   4069d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406a4:	48 83 f8 0d          	cmp    $0xd,%rax
   406a8:	75 16                	jne    406c0 <exception+0x8f>
	    || (reg->reg_err & PFERR_USER)) {
   406aa:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   406b1:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406b8:	83 e0 04             	and    $0x4,%eax
   406bb:	48 85 c0             	test   %rax,%rax
   406be:	74 1a                	je     406da <exception+0xa9>
	check_virtual_memory();
   406c0:	e8 72 07 00 00       	callq  40e37 <check_virtual_memory>
	if(disp_global){
   406c5:	0f b6 05 34 59 00 00 	movzbl 0x5934(%rip),%eax        # 46000 <start_data>
   406cc:	84 c0                	test   %al,%al
   406ce:	74 0a                	je     406da <exception+0xa9>
	    memshow_physical();
   406d0:	e8 da 08 00 00       	callq  40faf <memshow_physical>
	    memshow_virtual_animate();
   406d5:	e8 fe 0b 00 00       	callq  412d8 <memshow_virtual_animate>
	}
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   406da:	e8 eb 21 00 00       	callq  428ca <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   406df:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   406e6:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406ed:	48 83 e8 0e          	sub    $0xe,%rax
   406f1:	48 83 f8 2c          	cmp    $0x2c,%rax
   406f5:	0f 87 63 02 00 00    	ja     4095e <exception+0x32d>
   406fb:	48 8b 04 c5 f0 44 04 	mov    0x444f0(,%rax,8),%rax
   40702:	00 
   40703:	ff e0                	jmpq   *%rax
    case INT_SYS_PANIC:
	{
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40705:	48 8b 05 14 98 01 00 	mov    0x19814(%rip),%rax        # 59f20 <current>
   4070c:	48 8b 40 48          	mov    0x48(%rax),%rax
   40710:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		if((void *)addr == NULL)
   40714:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   40719:	75 0f                	jne    4072a <exception+0xf9>
		    panic(NULL);
   4071b:	bf 00 00 00 00       	mov    $0x0,%edi
   40720:	b8 00 00 00 00       	mov    $0x0,%eax
   40725:	e8 cc 22 00 00       	callq  429f6 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   4072a:	48 8b 05 ef 97 01 00 	mov    0x197ef(%rip),%rax        # 59f20 <current>
   40731:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40738:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   4073c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40740:	48 89 ce             	mov    %rcx,%rsi
   40743:	48 89 c7             	mov    %rax,%rdi
   40746:	e8 60 17 00 00       	callq  41eab <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   4074b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4074f:	48 89 c1             	mov    %rax,%rcx
   40752:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
   40759:	ba a0 00 00 00       	mov    $0xa0,%edx
   4075e:	48 89 ce             	mov    %rcx,%rsi
   40761:	48 89 c7             	mov    %rax,%rdi
   40764:	e8 8e 27 00 00       	callq  42ef7 <memcpy>
		panic(msg);
   40769:	48 8d 85 20 ff ff ff 	lea    -0xe0(%rbp),%rax
   40770:	48 89 c7             	mov    %rax,%rdi
   40773:	b8 00 00 00 00       	mov    $0x0,%eax
   40778:	e8 79 22 00 00       	callq  429f6 <panic>
	    panic(NULL);
	    break;                  // will not be reached
	}
    case INT_SYS_GETPID:
	{
	    current->p_registers.reg_rax = current->p_pid;
   4077d:	48 8b 05 9c 97 01 00 	mov    0x1979c(%rip),%rax        # 59f20 <current>
   40784:	8b 10                	mov    (%rax),%edx
   40786:	48 8b 05 93 97 01 00 	mov    0x19793(%rip),%rax        # 59f20 <current>
   4078d:	48 63 d2             	movslq %edx,%rdx
   40790:	48 89 50 18          	mov    %rdx,0x18(%rax)
	    break;
   40794:	e9 d5 01 00 00       	jmpq   4096e <exception+0x33d>
	}
    case INT_SYS_FORK:
	{
	    current->p_registers.reg_rax = syscall_fork();
   40799:	b8 00 00 00 00       	mov    $0x0,%eax
   4079e:	e8 40 fc ff ff       	callq  403e3 <syscall_fork>
   407a3:	89 c2                	mov    %eax,%edx
   407a5:	48 8b 05 74 97 01 00 	mov    0x19774(%rip),%rax        # 59f20 <current>
   407ac:	48 63 d2             	movslq %edx,%rdx
   407af:	48 89 50 18          	mov    %rdx,0x18(%rax)
	    break;
   407b3:	e9 b6 01 00 00       	jmpq   4096e <exception+0x33d>
	}
    case INT_SYS_MAPPING:
        {
	    syscall_mapping(current);
   407b8:	48 8b 05 61 97 01 00 	mov    0x19761(%rip),%rax        # 59f20 <current>
   407bf:	48 89 c7             	mov    %rax,%rdi
   407c2:	e8 38 fd ff ff       	callq  404ff <syscall_mapping>
            break;
   407c7:	e9 a2 01 00 00       	jmpq   4096e <exception+0x33d>
        }

    case INT_SYS_EXIT:
	{
	    syscall_exit();
   407cc:	b8 00 00 00 00       	mov    $0x0,%eax
   407d1:	e8 22 fc ff ff       	callq  403f8 <syscall_exit>
	    schedule();
   407d6:	e8 bc 01 00 00       	callq  40997 <schedule>
	    break;
   407db:	e9 8e 01 00 00       	jmpq   4096e <exception+0x33d>
	}

    case INT_SYS_YIELD:
	{
	    schedule();
   407e0:	e8 b2 01 00 00       	callq  40997 <schedule>
	    break;                  /* will not be reached */
   407e5:	e9 84 01 00 00       	jmpq   4096e <exception+0x33d>
	}

    case INT_SYS_BRK:
	{
	    /* TODO */
	    current->p_registers.reg_rax = (uint64_t)-1;
   407ea:	48 8b 05 2f 97 01 00 	mov    0x1972f(%rip),%rax        # 59f20 <current>
   407f1:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   407f8:	ff 
	    break;
   407f9:	e9 70 01 00 00       	jmpq   4096e <exception+0x33d>
	}

    case INT_SYS_SBRK:
	{
	    /* TODO */
	    current->p_registers.reg_rax = (uintptr_t)-1;
   407fe:	48 8b 05 1b 97 01 00 	mov    0x1971b(%rip),%rax        # 59f20 <current>
   40805:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   4080c:	ff 
	    break;
   4080d:	e9 5c 01 00 00       	jmpq   4096e <exception+0x33d>
	}

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   40812:	48 8b 05 07 97 01 00 	mov    0x19707(%rip),%rax        # 59f20 <current>
   40819:	48 89 c7             	mov    %rax,%rdi
   4081c:	e8 a7 fd ff ff       	callq  405c8 <syscall_mem_tog>
	    break;
   40821:	e9 48 01 00 00       	jmpq   4096e <exception+0x33d>
	}

    case INT_SYS_READ_SERIAL:
	{
	    current->p_registers.reg_rax = syscall_read_serial(current);
   40826:	48 8b 05 f3 96 01 00 	mov    0x196f3(%rip),%rax        # 59f20 <current>
   4082d:	48 89 c7             	mov    %rax,%rdi
   40830:	e8 fe fb ff ff       	callq  40433 <syscall_read_serial>
   40835:	89 c2                	mov    %eax,%edx
   40837:	48 8b 05 e2 96 01 00 	mov    0x196e2(%rip),%rax        # 59f20 <current>
   4083e:	48 63 d2             	movslq %edx,%rdx
   40841:	48 89 50 18          	mov    %rdx,0x18(%rax)
	    break;
   40845:	e9 24 01 00 00       	jmpq   4096e <exception+0x33d>
	}

    case INT_TIMER:
	{
	    ++ticks;
   4084a:	8b 05 b0 07 01 00    	mov    0x107b0(%rip),%eax        # 51000 <ticks>
   40850:	83 c0 01             	add    $0x1,%eax
   40853:	89 05 a7 07 01 00    	mov    %eax,0x107a7(%rip)        # 51000 <ticks>
	    schedule();
   40859:	e8 39 01 00 00       	callq  40997 <schedule>
	    break;                  /* will not be reached */
   4085e:	e9 0b 01 00 00       	jmpq   4096e <exception+0x33d>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40863:	0f 20 d0             	mov    %cr2,%rax
   40866:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    return val;
   4086a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
	}

    case INT_PAGEFAULT: 
	{
	    // Analyze faulting address and access type.
	    uintptr_t addr = rcr2();
   4086e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
	    const char* operation = reg->reg_err & PFERR_WRITE
   40872:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   40879:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40880:	83 e0 02             	and    $0x2,%eax
		? "write" : "read";
   40883:	48 85 c0             	test   %rax,%rax
   40886:	74 07                	je     4088f <exception+0x25e>
   40888:	b8 63 44 04 00       	mov    $0x44463,%eax
   4088d:	eb 05                	jmp    40894 <exception+0x263>
   4088f:	b8 69 44 04 00       	mov    $0x44469,%eax
	    const char* operation = reg->reg_err & PFERR_WRITE
   40894:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
	    const char* problem = reg->reg_err & PFERR_PRESENT
   40898:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   4089f:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408a6:	83 e0 01             	and    $0x1,%eax
		? "protection problem" : "missing page";
   408a9:	48 85 c0             	test   %rax,%rax
   408ac:	74 07                	je     408b5 <exception+0x284>
   408ae:	b8 6e 44 04 00       	mov    $0x4446e,%eax
   408b3:	eb 05                	jmp    408ba <exception+0x289>
   408b5:	b8 81 44 04 00       	mov    $0x44481,%eax
	    const char* problem = reg->reg_err & PFERR_PRESENT
   408ba:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

	    if (!(reg->reg_err & PFERR_USER)) {
   408be:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   408c5:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   408cc:	83 e0 04             	and    $0x4,%eax
   408cf:	48 85 c0             	test   %rax,%rax
   408d2:	75 2f                	jne    40903 <exception+0x2d2>
		panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   408d4:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   408db:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   408e2:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   408e6:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   408ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   408ee:	49 89 f0             	mov    %rsi,%r8
   408f1:	48 89 c6             	mov    %rax,%rsi
   408f4:	bf 90 44 04 00       	mov    $0x44490,%edi
   408f9:	b8 00 00 00 00       	mov    $0x0,%eax
   408fe:	e8 f3 20 00 00       	callq  429f6 <panic>
			addr, operation, problem, reg->reg_rip);
	    }
	    console_printf(CPOS(24, 0), 0x0C00,
   40903:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
   4090a:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
		    "Process %d page fault for %p (%s %s, rip=%p)!\n",
		    current->p_pid, addr, operation, problem, reg->reg_rip);
   40911:	48 8b 05 08 96 01 00 	mov    0x19608(%rip),%rax        # 59f20 <current>
	    console_printf(CPOS(24, 0), 0x0C00,
   40918:	8b 00                	mov    (%rax),%eax
   4091a:	48 8b 75 e8          	mov    -0x18(%rbp),%rsi
   4091e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
   40922:	52                   	push   %rdx
   40923:	ff 75 e0             	pushq  -0x20(%rbp)
   40926:	49 89 f1             	mov    %rsi,%r9
   40929:	49 89 c8             	mov    %rcx,%r8
   4092c:	89 c1                	mov    %eax,%ecx
   4092e:	ba c0 44 04 00       	mov    $0x444c0,%edx
   40933:	be 00 0c 00 00       	mov    $0xc00,%esi
   40938:	bf 80 07 00 00       	mov    $0x780,%edi
   4093d:	b8 00 00 00 00       	mov    $0x0,%eax
   40942:	e8 57 2e 00 00       	callq  4379e <console_printf>
   40947:	48 83 c4 10          	add    $0x10,%rsp
	    current->p_state = P_BROKEN;
   4094b:	48 8b 05 ce 95 01 00 	mov    0x195ce(%rip),%rax        # 59f20 <current>
   40952:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40959:	00 00 00 
	    break;
   4095c:	eb 10                	jmp    4096e <exception+0x33d>
	}

    default:
	default_exception(current);
   4095e:	48 8b 05 bb 95 01 00 	mov    0x195bb(%rip),%rax        # 59f20 <current>
   40965:	48 89 c7             	mov    %rax,%rdi
   40968:	e8 99 21 00 00       	callq  42b06 <default_exception>
        break;                  /* will not be reached */
   4096d:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4096e:	48 8b 05 ab 95 01 00 	mov    0x195ab(%rip),%rax        # 59f20 <current>
   40975:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   4097b:	83 f8 01             	cmp    $0x1,%eax
   4097e:	75 0f                	jne    4098f <exception+0x35e>
        run(current);
   40980:	48 8b 05 99 95 01 00 	mov    0x19599(%rip),%rax        # 59f20 <current>
   40987:	48 89 c7             	mov    %rax,%rdi
   4098a:	e8 80 00 00 00       	callq  40a0f <run>
    } else {
        schedule();
   4098f:	e8 03 00 00 00       	callq  40997 <schedule>
    }
}
   40994:	90                   	nop
   40995:	c9                   	leaveq 
   40996:	c3                   	retq   

0000000000040997 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40997:	55                   	push   %rbp
   40998:	48 89 e5             	mov    %rsp,%rbp
   4099b:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4099f:	48 8b 05 7a 95 01 00 	mov    0x1957a(%rip),%rax        # 59f20 <current>
   409a6:	8b 00                	mov    (%rax),%eax
   409a8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   409ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409ae:	8d 50 01             	lea    0x1(%rax),%edx
   409b1:	89 d0                	mov    %edx,%eax
   409b3:	c1 f8 1f             	sar    $0x1f,%eax
   409b6:	c1 e8 1c             	shr    $0x1c,%eax
   409b9:	01 c2                	add    %eax,%edx
   409bb:	83 e2 0f             	and    $0xf,%edx
   409be:	29 c2                	sub    %eax,%edx
   409c0:	89 d0                	mov    %edx,%eax
   409c2:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   409c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409c8:	48 63 d0             	movslq %eax,%rdx
   409cb:	48 89 d0             	mov    %rdx,%rax
   409ce:	48 c1 e0 04          	shl    $0x4,%rax
   409d2:	48 29 d0             	sub    %rdx,%rax
   409d5:	48 c1 e0 04          	shl    $0x4,%rax
   409d9:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   409df:	8b 00                	mov    (%rax),%eax
   409e1:	83 f8 01             	cmp    $0x1,%eax
   409e4:	75 22                	jne    40a08 <schedule+0x71>
            run(&processes[pid]);
   409e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   409e9:	48 63 d0             	movslq %eax,%rdx
   409ec:	48 89 d0             	mov    %rdx,%rax
   409ef:	48 c1 e0 04          	shl    $0x4,%rax
   409f3:	48 29 d0             	sub    %rdx,%rax
   409f6:	48 c1 e0 04          	shl    $0x4,%rax
   409fa:	48 05 20 90 05 00    	add    $0x59020,%rax
   40a00:	48 89 c7             	mov    %rax,%rdi
   40a03:	e8 07 00 00 00       	callq  40a0f <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40a08:	e8 bd 1e 00 00       	callq  428ca <check_keyboard>
        pid = (pid + 1) % NPROC;
   40a0d:	eb 9c                	jmp    409ab <schedule+0x14>

0000000000040a0f <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40a0f:	55                   	push   %rbp
   40a10:	48 89 e5             	mov    %rsp,%rbp
   40a13:	48 83 ec 10          	sub    $0x10,%rsp
   40a17:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40a1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a1f:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40a25:	83 f8 01             	cmp    $0x1,%eax
   40a28:	74 14                	je     40a3e <run+0x2f>
   40a2a:	ba 58 46 04 00       	mov    $0x44658,%edx
   40a2f:	be 7b 01 00 00       	mov    $0x17b,%esi
   40a34:	bf 20 44 04 00       	mov    $0x44420,%edi
   40a39:	e8 98 20 00 00       	callq  42ad6 <assert_fail>
    current = p;
   40a3e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a42:	48 89 05 d7 94 01 00 	mov    %rax,0x194d7(%rip)        # 59f20 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40a49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a4d:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40a4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a53:	8b 00                	mov    (%rax),%eax
   40a55:	83 c0 02             	add    $0x2,%eax
   40a58:	48 98                	cltq   
   40a5a:	0f b7 84 00 c0 43 04 	movzwl 0x443c0(%rax,%rax,1),%eax
   40a61:	00 
    console_printf(CPOS(24, 79),
   40a62:	0f b7 c0             	movzwl %ax,%eax
   40a65:	89 d1                	mov    %edx,%ecx
   40a67:	ba 71 46 04 00       	mov    $0x44671,%edx
   40a6c:	89 c6                	mov    %eax,%esi
   40a6e:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40a73:	b8 00 00 00 00       	mov    $0x0,%eax
   40a78:	e8 21 2d 00 00       	callq  4379e <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40a7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a81:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a88:	48 89 c7             	mov    %rax,%rdi
   40a8b:	e8 12 15 00 00       	callq  41fa2 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40a94:	48 83 c0 18          	add    $0x18,%rax
   40a98:	48 89 c7             	mov    %rax,%rdi
   40a9b:	e8 23 f6 ff ff       	callq  400c3 <exception_return>

0000000000040aa0 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40aa0:	55                   	push   %rbp
   40aa1:	48 89 e5             	mov    %rsp,%rbp
   40aa4:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40aa8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40aaf:	00 
   40ab0:	e9 81 00 00 00       	jmpq   40b36 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40ab5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ab9:	48 89 c7             	mov    %rax,%rdi
   40abc:	e8 12 16 00 00       	callq  420d3 <physical_memory_isreserved>
   40ac1:	85 c0                	test   %eax,%eax
   40ac3:	74 09                	je     40ace <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40ac5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40acc:	eb 2f                	jmp    40afd <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40ace:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40ad5:	00 
   40ad6:	76 0b                	jbe    40ae3 <pageinfo_init+0x43>
   40ad8:	b8 48 a3 05 00       	mov    $0x5a348,%eax
   40add:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40ae1:	72 0a                	jb     40aed <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40ae3:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40aea:	00 
   40aeb:	75 09                	jne    40af6 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40aed:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40af4:	eb 07                	jmp    40afd <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40af6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40afd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b01:	48 c1 e8 0c          	shr    $0xc,%rax
   40b05:	89 c1                	mov    %eax,%ecx
   40b07:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40b0a:	89 c2                	mov    %eax,%edx
   40b0c:	48 63 c1             	movslq %ecx,%rax
   40b0f:	88 94 00 40 9f 05 00 	mov    %dl,0x59f40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40b16:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40b1a:	0f 95 c2             	setne  %dl
   40b1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40b21:	48 c1 e8 0c          	shr    $0xc,%rax
   40b25:	48 98                	cltq   
   40b27:	88 94 00 41 9f 05 00 	mov    %dl,0x59f41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40b2e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40b35:	00 
   40b36:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40b3d:	00 
   40b3e:	0f 86 71 ff ff ff    	jbe    40ab5 <pageinfo_init+0x15>
    }
}
   40b44:	90                   	nop
   40b45:	90                   	nop
   40b46:	c9                   	leaveq 
   40b47:	c3                   	retq   

0000000000040b48 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40b48:	55                   	push   %rbp
   40b49:	48 89 e5             	mov    %rsp,%rbp
   40b4c:	48 83 ec 50          	sub    $0x50,%rsp
   40b50:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40b54:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b58:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40b5e:	48 89 c2             	mov    %rax,%rdx
   40b61:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40b65:	48 39 c2             	cmp    %rax,%rdx
   40b68:	74 14                	je     40b7e <check_page_table_mappings+0x36>
   40b6a:	ba 78 46 04 00       	mov    $0x44678,%edx
   40b6f:	be a9 01 00 00       	mov    $0x1a9,%esi
   40b74:	bf 20 44 04 00       	mov    $0x44420,%edi
   40b79:	e8 58 1f 00 00       	callq  42ad6 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40b7e:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40b85:	00 
   40b86:	e9 9a 00 00 00       	jmpq   40c25 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40b8b:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40b8f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40b93:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40b97:	48 89 ce             	mov    %rcx,%rsi
   40b9a:	48 89 c7             	mov    %rax,%rdi
   40b9d:	e8 09 13 00 00       	callq  41eab <virtual_memory_lookup>
        if (vam.pa != va) {
   40ba2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ba6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40baa:	74 27                	je     40bd3 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40bac:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40bb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40bb4:	49 89 d0             	mov    %rdx,%r8
   40bb7:	48 89 c1             	mov    %rax,%rcx
   40bba:	ba 97 46 04 00       	mov    $0x44697,%edx
   40bbf:	be 00 c0 00 00       	mov    $0xc000,%esi
   40bc4:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40bc9:	b8 00 00 00 00       	mov    $0x0,%eax
   40bce:	e8 cb 2b 00 00       	callq  4379e <console_printf>
        }
        assert(vam.pa == va);
   40bd3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40bd7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bdb:	74 14                	je     40bf1 <check_page_table_mappings+0xa9>
   40bdd:	ba a1 46 04 00       	mov    $0x446a1,%edx
   40be2:	be b2 01 00 00       	mov    $0x1b2,%esi
   40be7:	bf 20 44 04 00       	mov    $0x44420,%edi
   40bec:	e8 e5 1e 00 00       	callq  42ad6 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40bf1:	b8 00 60 04 00       	mov    $0x46000,%eax
   40bf6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40bfa:	72 21                	jb     40c1d <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40bfc:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40bff:	48 98                	cltq   
   40c01:	83 e0 02             	and    $0x2,%eax
   40c04:	48 85 c0             	test   %rax,%rax
   40c07:	75 14                	jne    40c1d <check_page_table_mappings+0xd5>
   40c09:	ba ae 46 04 00       	mov    $0x446ae,%edx
   40c0e:	be b4 01 00 00       	mov    $0x1b4,%esi
   40c13:	bf 20 44 04 00       	mov    $0x44420,%edi
   40c18:	e8 b9 1e 00 00       	callq  42ad6 <assert_fail>
         va += PAGESIZE) {
   40c1d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40c24:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40c25:	b8 48 a3 05 00       	mov    $0x5a348,%eax
   40c2a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40c2e:	0f 82 57 ff ff ff    	jb     40b8b <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40c34:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40c3b:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40c3c:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40c40:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40c44:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40c48:	48 89 ce             	mov    %rcx,%rsi
   40c4b:	48 89 c7             	mov    %rax,%rdi
   40c4e:	e8 58 12 00 00       	callq  41eab <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40c53:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40c57:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40c5b:	74 14                	je     40c71 <check_page_table_mappings+0x129>
   40c5d:	ba bf 46 04 00       	mov    $0x446bf,%edx
   40c62:	be bb 01 00 00       	mov    $0x1bb,%esi
   40c67:	bf 20 44 04 00       	mov    $0x44420,%edi
   40c6c:	e8 65 1e 00 00       	callq  42ad6 <assert_fail>
    assert(vam.perm & PTE_W);
   40c71:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40c74:	48 98                	cltq   
   40c76:	83 e0 02             	and    $0x2,%eax
   40c79:	48 85 c0             	test   %rax,%rax
   40c7c:	75 14                	jne    40c92 <check_page_table_mappings+0x14a>
   40c7e:	ba ae 46 04 00       	mov    $0x446ae,%edx
   40c83:	be bc 01 00 00       	mov    $0x1bc,%esi
   40c88:	bf 20 44 04 00       	mov    $0x44420,%edi
   40c8d:	e8 44 1e 00 00       	callq  42ad6 <assert_fail>
}
   40c92:	90                   	nop
   40c93:	c9                   	leaveq 
   40c94:	c3                   	retq   

0000000000040c95 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40c95:	55                   	push   %rbp
   40c96:	48 89 e5             	mov    %rsp,%rbp
   40c99:	48 83 ec 20          	sub    $0x20,%rsp
   40c9d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ca1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40ca4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40ca7:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40caa:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40cb1:	48 8b 05 88 96 01 00 	mov    0x19688(%rip),%rax        # 5a340 <kernel_pagetable>
   40cb8:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40cbc:	75 67                	jne    40d25 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40cbe:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40cc5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40ccc:	eb 51                	jmp    40d1f <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40cce:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cd1:	48 63 d0             	movslq %eax,%rdx
   40cd4:	48 89 d0             	mov    %rdx,%rax
   40cd7:	48 c1 e0 04          	shl    $0x4,%rax
   40cdb:	48 29 d0             	sub    %rdx,%rax
   40cde:	48 c1 e0 04          	shl    $0x4,%rax
   40ce2:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   40ce8:	8b 00                	mov    (%rax),%eax
   40cea:	85 c0                	test   %eax,%eax
   40cec:	74 2d                	je     40d1b <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40cee:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40cf1:	48 63 d0             	movslq %eax,%rdx
   40cf4:	48 89 d0             	mov    %rdx,%rax
   40cf7:	48 c1 e0 04          	shl    $0x4,%rax
   40cfb:	48 29 d0             	sub    %rdx,%rax
   40cfe:	48 c1 e0 04          	shl    $0x4,%rax
   40d02:	48 05 00 91 05 00    	add    $0x59100,%rax
   40d08:	48 8b 10             	mov    (%rax),%rdx
   40d0b:	48 8b 05 2e 96 01 00 	mov    0x1962e(%rip),%rax        # 5a340 <kernel_pagetable>
   40d12:	48 39 c2             	cmp    %rax,%rdx
   40d15:	75 04                	jne    40d1b <check_page_table_ownership+0x86>
                ++expected_refcount;
   40d17:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40d1b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40d1f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40d23:	7e a9                	jle    40cce <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40d25:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40d28:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d2f:	be 00 00 00 00       	mov    $0x0,%esi
   40d34:	48 89 c7             	mov    %rax,%rdi
   40d37:	e8 03 00 00 00       	callq  40d3f <check_page_table_ownership_level>
}
   40d3c:	90                   	nop
   40d3d:	c9                   	leaveq 
   40d3e:	c3                   	retq   

0000000000040d3f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40d3f:	55                   	push   %rbp
   40d40:	48 89 e5             	mov    %rsp,%rbp
   40d43:	48 83 ec 30          	sub    $0x30,%rsp
   40d47:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40d4b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40d4e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40d51:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40d54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d58:	48 c1 e8 0c          	shr    $0xc,%rax
   40d5c:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40d61:	7e 14                	jle    40d77 <check_page_table_ownership_level+0x38>
   40d63:	ba d0 46 04 00       	mov    $0x446d0,%edx
   40d68:	be d9 01 00 00       	mov    $0x1d9,%esi
   40d6d:	bf 20 44 04 00       	mov    $0x44420,%edi
   40d72:	e8 5f 1d 00 00       	callq  42ad6 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40d77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40d7b:	48 c1 e8 0c          	shr    $0xc,%rax
   40d7f:	48 98                	cltq   
   40d81:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   40d88:	00 
   40d89:	0f be c0             	movsbl %al,%eax
   40d8c:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40d8f:	74 14                	je     40da5 <check_page_table_ownership_level+0x66>
   40d91:	ba e8 46 04 00       	mov    $0x446e8,%edx
   40d96:	be da 01 00 00       	mov    $0x1da,%esi
   40d9b:	bf 20 44 04 00       	mov    $0x44420,%edi
   40da0:	e8 31 1d 00 00       	callq  42ad6 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40da5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40da9:	48 c1 e8 0c          	shr    $0xc,%rax
   40dad:	48 98                	cltq   
   40daf:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   40db6:	00 
   40db7:	0f be c0             	movsbl %al,%eax
   40dba:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40dbd:	74 14                	je     40dd3 <check_page_table_ownership_level+0x94>
   40dbf:	ba 10 47 04 00       	mov    $0x44710,%edx
   40dc4:	be db 01 00 00       	mov    $0x1db,%esi
   40dc9:	bf 20 44 04 00       	mov    $0x44420,%edi
   40dce:	e8 03 1d 00 00       	callq  42ad6 <assert_fail>
    if (level < 3) {
   40dd3:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40dd7:	7f 5b                	jg     40e34 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40dd9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40de0:	eb 49                	jmp    40e2b <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40de2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40de6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40de9:	48 63 d2             	movslq %edx,%rdx
   40dec:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40df0:	48 85 c0             	test   %rax,%rax
   40df3:	74 32                	je     40e27 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40df5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40df9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40dfc:	48 63 d2             	movslq %edx,%rdx
   40dff:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40e03:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40e09:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40e0d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40e10:	8d 70 01             	lea    0x1(%rax),%esi
   40e13:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40e16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40e1a:	b9 01 00 00 00       	mov    $0x1,%ecx
   40e1f:	48 89 c7             	mov    %rax,%rdi
   40e22:	e8 18 ff ff ff       	callq  40d3f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40e27:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40e2b:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40e32:	7e ae                	jle    40de2 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40e34:	90                   	nop
   40e35:	c9                   	leaveq 
   40e36:	c3                   	retq   

0000000000040e37 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40e37:	55                   	push   %rbp
   40e38:	48 89 e5             	mov    %rsp,%rbp
   40e3b:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40e3f:	8b 05 b3 82 01 00    	mov    0x182b3(%rip),%eax        # 590f8 <processes+0xd8>
   40e45:	85 c0                	test   %eax,%eax
   40e47:	74 14                	je     40e5d <check_virtual_memory+0x26>
   40e49:	ba 40 47 04 00       	mov    $0x44740,%edx
   40e4e:	be ee 01 00 00       	mov    $0x1ee,%esi
   40e53:	bf 20 44 04 00       	mov    $0x44420,%edi
   40e58:	e8 79 1c 00 00       	callq  42ad6 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40e5d:	48 8b 05 dc 94 01 00 	mov    0x194dc(%rip),%rax        # 5a340 <kernel_pagetable>
   40e64:	48 89 c7             	mov    %rax,%rdi
   40e67:	e8 dc fc ff ff       	callq  40b48 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40e6c:	48 8b 05 cd 94 01 00 	mov    0x194cd(%rip),%rax        # 5a340 <kernel_pagetable>
   40e73:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40e78:	48 89 c7             	mov    %rax,%rdi
   40e7b:	e8 15 fe ff ff       	callq  40c95 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40e80:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40e87:	e9 9c 00 00 00       	jmpq   40f28 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   40e8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e8f:	48 63 d0             	movslq %eax,%rdx
   40e92:	48 89 d0             	mov    %rdx,%rax
   40e95:	48 c1 e0 04          	shl    $0x4,%rax
   40e99:	48 29 d0             	sub    %rdx,%rax
   40e9c:	48 c1 e0 04          	shl    $0x4,%rax
   40ea0:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   40ea6:	8b 00                	mov    (%rax),%eax
   40ea8:	85 c0                	test   %eax,%eax
   40eaa:	74 78                	je     40f24 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40eac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40eaf:	48 63 d0             	movslq %eax,%rdx
   40eb2:	48 89 d0             	mov    %rdx,%rax
   40eb5:	48 c1 e0 04          	shl    $0x4,%rax
   40eb9:	48 29 d0             	sub    %rdx,%rax
   40ebc:	48 c1 e0 04          	shl    $0x4,%rax
   40ec0:	48 05 00 91 05 00    	add    $0x59100,%rax
   40ec6:	48 8b 10             	mov    (%rax),%rdx
   40ec9:	48 8b 05 70 94 01 00 	mov    0x19470(%rip),%rax        # 5a340 <kernel_pagetable>
   40ed0:	48 39 c2             	cmp    %rax,%rdx
   40ed3:	74 4f                	je     40f24 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   40ed5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ed8:	48 63 d0             	movslq %eax,%rdx
   40edb:	48 89 d0             	mov    %rdx,%rax
   40ede:	48 c1 e0 04          	shl    $0x4,%rax
   40ee2:	48 29 d0             	sub    %rdx,%rax
   40ee5:	48 c1 e0 04          	shl    $0x4,%rax
   40ee9:	48 05 00 91 05 00    	add    $0x59100,%rax
   40eef:	48 8b 00             	mov    (%rax),%rax
   40ef2:	48 89 c7             	mov    %rax,%rdi
   40ef5:	e8 4e fc ff ff       	callq  40b48 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40efa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40efd:	48 63 d0             	movslq %eax,%rdx
   40f00:	48 89 d0             	mov    %rdx,%rax
   40f03:	48 c1 e0 04          	shl    $0x4,%rax
   40f07:	48 29 d0             	sub    %rdx,%rax
   40f0a:	48 c1 e0 04          	shl    $0x4,%rax
   40f0e:	48 05 00 91 05 00    	add    $0x59100,%rax
   40f14:	48 8b 00             	mov    (%rax),%rax
   40f17:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f1a:	89 d6                	mov    %edx,%esi
   40f1c:	48 89 c7             	mov    %rax,%rdi
   40f1f:	e8 71 fd ff ff       	callq  40c95 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40f24:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40f28:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40f2c:	0f 8e 5a ff ff ff    	jle    40e8c <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f32:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40f39:	eb 67                	jmp    40fa2 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40f3b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f3e:	48 98                	cltq   
   40f40:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   40f47:	00 
   40f48:	84 c0                	test   %al,%al
   40f4a:	7e 52                	jle    40f9e <check_virtual_memory+0x167>
   40f4c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f4f:	48 98                	cltq   
   40f51:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   40f58:	00 
   40f59:	84 c0                	test   %al,%al
   40f5b:	78 41                	js     40f9e <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40f5d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40f60:	48 98                	cltq   
   40f62:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   40f69:	00 
   40f6a:	0f be c0             	movsbl %al,%eax
   40f6d:	48 63 d0             	movslq %eax,%rdx
   40f70:	48 89 d0             	mov    %rdx,%rax
   40f73:	48 c1 e0 04          	shl    $0x4,%rax
   40f77:	48 29 d0             	sub    %rdx,%rax
   40f7a:	48 c1 e0 04          	shl    $0x4,%rax
   40f7e:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   40f84:	8b 00                	mov    (%rax),%eax
   40f86:	85 c0                	test   %eax,%eax
   40f88:	75 14                	jne    40f9e <check_virtual_memory+0x167>
   40f8a:	ba 60 47 04 00       	mov    $0x44760,%edx
   40f8f:	be 05 02 00 00       	mov    $0x205,%esi
   40f94:	bf 20 44 04 00       	mov    $0x44420,%edi
   40f99:	e8 38 1b 00 00       	callq  42ad6 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40f9e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40fa2:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40fa9:	7e 90                	jle    40f3b <check_virtual_memory+0x104>
        }
    }
}
   40fab:	90                   	nop
   40fac:	90                   	nop
   40fad:	c9                   	leaveq 
   40fae:	c3                   	retq   

0000000000040faf <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   40faf:	55                   	push   %rbp
   40fb0:	48 89 e5             	mov    %rsp,%rbp
   40fb3:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40fb7:	ba 90 47 04 00       	mov    $0x44790,%edx
   40fbc:	be 00 0f 00 00       	mov    $0xf00,%esi
   40fc1:	bf 20 00 00 00       	mov    $0x20,%edi
   40fc6:	b8 00 00 00 00       	mov    $0x0,%eax
   40fcb:	e8 ce 27 00 00       	callq  4379e <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40fd0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40fd7:	e9 f2 00 00 00       	jmpq   410ce <memshow_physical+0x11f>
        if (pn % 64 == 0) {
   40fdc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fdf:	83 e0 3f             	and    $0x3f,%eax
   40fe2:	85 c0                	test   %eax,%eax
   40fe4:	75 3c                	jne    41022 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40fe6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40fe9:	c1 e0 0c             	shl    $0xc,%eax
   40fec:	89 c1                	mov    %eax,%ecx
   40fee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40ff1:	8d 50 3f             	lea    0x3f(%rax),%edx
   40ff4:	85 c0                	test   %eax,%eax
   40ff6:	0f 48 c2             	cmovs  %edx,%eax
   40ff9:	c1 f8 06             	sar    $0x6,%eax
   40ffc:	8d 50 01             	lea    0x1(%rax),%edx
   40fff:	89 d0                	mov    %edx,%eax
   41001:	c1 e0 02             	shl    $0x2,%eax
   41004:	01 d0                	add    %edx,%eax
   41006:	c1 e0 04             	shl    $0x4,%eax
   41009:	83 c0 03             	add    $0x3,%eax
   4100c:	ba a0 47 04 00       	mov    $0x447a0,%edx
   41011:	be 00 0f 00 00       	mov    $0xf00,%esi
   41016:	89 c7                	mov    %eax,%edi
   41018:	b8 00 00 00 00       	mov    $0x0,%eax
   4101d:	e8 7c 27 00 00       	callq  4379e <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41022:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41025:	48 98                	cltq   
   41027:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   4102e:	00 
   4102f:	0f be c0             	movsbl %al,%eax
   41032:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41035:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41038:	48 98                	cltq   
   4103a:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   41041:	00 
   41042:	84 c0                	test   %al,%al
   41044:	75 07                	jne    4104d <memshow_physical+0x9e>
            owner = PO_FREE;
   41046:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4104d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41050:	83 c0 02             	add    $0x2,%eax
   41053:	48 98                	cltq   
   41055:	0f b7 84 00 c0 43 04 	movzwl 0x443c0(%rax,%rax,1),%eax
   4105c:	00 
   4105d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41061:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41064:	48 98                	cltq   
   41066:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   4106d:	00 
   4106e:	3c 01                	cmp    $0x1,%al
   41070:	7e 1a                	jle    4108c <memshow_physical+0xdd>
   41072:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41077:	48 c1 e8 0c          	shr    $0xc,%rax
   4107b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4107e:	74 0c                	je     4108c <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41080:	b8 53 00 00 00       	mov    $0x53,%eax
   41085:	80 cc 0f             	or     $0xf,%ah
   41088:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4108c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4108f:	8d 50 3f             	lea    0x3f(%rax),%edx
   41092:	85 c0                	test   %eax,%eax
   41094:	0f 48 c2             	cmovs  %edx,%eax
   41097:	c1 f8 06             	sar    $0x6,%eax
   4109a:	8d 50 01             	lea    0x1(%rax),%edx
   4109d:	89 d0                	mov    %edx,%eax
   4109f:	c1 e0 02             	shl    $0x2,%eax
   410a2:	01 d0                	add    %edx,%eax
   410a4:	c1 e0 04             	shl    $0x4,%eax
   410a7:	89 c1                	mov    %eax,%ecx
   410a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410ac:	99                   	cltd   
   410ad:	c1 ea 1a             	shr    $0x1a,%edx
   410b0:	01 d0                	add    %edx,%eax
   410b2:	83 e0 3f             	and    $0x3f,%eax
   410b5:	29 d0                	sub    %edx,%eax
   410b7:	83 c0 0c             	add    $0xc,%eax
   410ba:	01 c8                	add    %ecx,%eax
   410bc:	48 98                	cltq   
   410be:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   410c2:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   410c9:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   410ca:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   410ce:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   410d5:	0f 8e 01 ff ff ff    	jle    40fdc <memshow_physical+0x2d>
    }
}
   410db:	90                   	nop
   410dc:	90                   	nop
   410dd:	c9                   	leaveq 
   410de:	c3                   	retq   

00000000000410df <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   410df:	55                   	push   %rbp
   410e0:	48 89 e5             	mov    %rsp,%rbp
   410e3:	48 83 ec 40          	sub    $0x40,%rsp
   410e7:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   410eb:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   410ef:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   410f3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   410f9:	48 89 c2             	mov    %rax,%rdx
   410fc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41100:	48 39 c2             	cmp    %rax,%rdx
   41103:	74 14                	je     41119 <memshow_virtual+0x3a>
   41105:	ba a8 47 04 00       	mov    $0x447a8,%edx
   4110a:	be 36 02 00 00       	mov    $0x236,%esi
   4110f:	bf 20 44 04 00       	mov    $0x44420,%edi
   41114:	e8 bd 19 00 00       	callq  42ad6 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41119:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4111d:	48 89 c1             	mov    %rax,%rcx
   41120:	ba d5 47 04 00       	mov    $0x447d5,%edx
   41125:	be 00 0f 00 00       	mov    $0xf00,%esi
   4112a:	bf 3a 03 00 00       	mov    $0x33a,%edi
   4112f:	b8 00 00 00 00       	mov    $0x0,%eax
   41134:	e8 65 26 00 00       	callq  4379e <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41139:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41140:	00 
   41141:	e9 80 01 00 00       	jmpq   412c6 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41146:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4114a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4114e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41152:	48 89 ce             	mov    %rcx,%rsi
   41155:	48 89 c7             	mov    %rax,%rdi
   41158:	e8 4e 0d 00 00       	callq  41eab <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4115d:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41160:	85 c0                	test   %eax,%eax
   41162:	79 0b                	jns    4116f <memshow_virtual+0x90>
            color = ' ';
   41164:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4116a:	e9 d7 00 00 00       	jmpq   41246 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   4116f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41173:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41179:	76 14                	jbe    4118f <memshow_virtual+0xb0>
   4117b:	ba f2 47 04 00       	mov    $0x447f2,%edx
   41180:	be 3f 02 00 00       	mov    $0x23f,%esi
   41185:	bf 20 44 04 00       	mov    $0x44420,%edi
   4118a:	e8 47 19 00 00       	callq  42ad6 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   4118f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41192:	48 98                	cltq   
   41194:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   4119b:	00 
   4119c:	0f be c0             	movsbl %al,%eax
   4119f:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   411a2:	8b 45 d0             	mov    -0x30(%rbp),%eax
   411a5:	48 98                	cltq   
   411a7:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   411ae:	00 
   411af:	84 c0                	test   %al,%al
   411b1:	75 07                	jne    411ba <memshow_virtual+0xdb>
                owner = PO_FREE;
   411b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   411ba:	8b 45 f0             	mov    -0x10(%rbp),%eax
   411bd:	83 c0 02             	add    $0x2,%eax
   411c0:	48 98                	cltq   
   411c2:	0f b7 84 00 c0 43 04 	movzwl 0x443c0(%rax,%rax,1),%eax
   411c9:	00 
   411ca:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   411ce:	8b 45 e0             	mov    -0x20(%rbp),%eax
   411d1:	48 98                	cltq   
   411d3:	83 e0 04             	and    $0x4,%eax
   411d6:	48 85 c0             	test   %rax,%rax
   411d9:	74 27                	je     41202 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411db:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411df:	c1 e0 04             	shl    $0x4,%eax
   411e2:	66 25 00 f0          	and    $0xf000,%ax
   411e6:	89 c2                	mov    %eax,%edx
   411e8:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411ec:	c1 f8 04             	sar    $0x4,%eax
   411ef:	66 25 00 0f          	and    $0xf00,%ax
   411f3:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   411f5:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   411f9:	0f b6 c0             	movzbl %al,%eax
   411fc:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   411fe:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41202:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41205:	48 98                	cltq   
   41207:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   4120e:	00 
   4120f:	3c 01                	cmp    $0x1,%al
   41211:	7e 33                	jle    41246 <memshow_virtual+0x167>
   41213:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41218:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4121c:	74 28                	je     41246 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   4121e:	b8 53 00 00 00       	mov    $0x53,%eax
   41223:	89 c2                	mov    %eax,%edx
   41225:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41229:	66 25 00 f0          	and    $0xf000,%ax
   4122d:	09 d0                	or     %edx,%eax
   4122f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41233:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41236:	48 98                	cltq   
   41238:	83 e0 04             	and    $0x4,%eax
   4123b:	48 85 c0             	test   %rax,%rax
   4123e:	75 06                	jne    41246 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41240:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4124a:	48 c1 e8 0c          	shr    $0xc,%rax
   4124e:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41251:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41254:	83 e0 3f             	and    $0x3f,%eax
   41257:	85 c0                	test   %eax,%eax
   41259:	75 34                	jne    4128f <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4125b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4125e:	c1 e8 06             	shr    $0x6,%eax
   41261:	89 c2                	mov    %eax,%edx
   41263:	89 d0                	mov    %edx,%eax
   41265:	c1 e0 02             	shl    $0x2,%eax
   41268:	01 d0                	add    %edx,%eax
   4126a:	c1 e0 04             	shl    $0x4,%eax
   4126d:	05 73 03 00 00       	add    $0x373,%eax
   41272:	89 c7                	mov    %eax,%edi
   41274:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41278:	48 89 c1             	mov    %rax,%rcx
   4127b:	ba a0 47 04 00       	mov    $0x447a0,%edx
   41280:	be 00 0f 00 00       	mov    $0xf00,%esi
   41285:	b8 00 00 00 00       	mov    $0x0,%eax
   4128a:	e8 0f 25 00 00       	callq  4379e <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   4128f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41292:	c1 e8 06             	shr    $0x6,%eax
   41295:	89 c2                	mov    %eax,%edx
   41297:	89 d0                	mov    %edx,%eax
   41299:	c1 e0 02             	shl    $0x2,%eax
   4129c:	01 d0                	add    %edx,%eax
   4129e:	c1 e0 04             	shl    $0x4,%eax
   412a1:	89 c2                	mov    %eax,%edx
   412a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   412a6:	83 e0 3f             	and    $0x3f,%eax
   412a9:	01 d0                	add    %edx,%eax
   412ab:	05 7c 03 00 00       	add    $0x37c,%eax
   412b0:	89 c2                	mov    %eax,%edx
   412b2:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   412b6:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   412bd:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   412be:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   412c5:	00 
   412c6:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   412cd:	00 
   412ce:	0f 86 72 fe ff ff    	jbe    41146 <memshow_virtual+0x67>
    }
}
   412d4:	90                   	nop
   412d5:	90                   	nop
   412d6:	c9                   	leaveq 
   412d7:	c3                   	retq   

00000000000412d8 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   412d8:	55                   	push   %rbp
   412d9:	48 89 e5             	mov    %rsp,%rbp
   412dc:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   412e0:	8b 05 1e fd 00 00    	mov    0xfd1e(%rip),%eax        # 51004 <last_ticks.1693>
   412e6:	85 c0                	test   %eax,%eax
   412e8:	74 15                	je     412ff <memshow_virtual_animate+0x27>
   412ea:	8b 15 10 fd 00 00    	mov    0xfd10(%rip),%edx        # 51000 <ticks>
   412f0:	8b 05 0e fd 00 00    	mov    0xfd0e(%rip),%eax        # 51004 <last_ticks.1693>
   412f6:	29 c2                	sub    %eax,%edx
   412f8:	89 d0                	mov    %edx,%eax
   412fa:	83 f8 31             	cmp    $0x31,%eax
   412fd:	76 2c                	jbe    4132b <memshow_virtual_animate+0x53>
        last_ticks = ticks;
   412ff:	8b 05 fb fc 00 00    	mov    0xfcfb(%rip),%eax        # 51000 <ticks>
   41305:	89 05 f9 fc 00 00    	mov    %eax,0xfcf9(%rip)        # 51004 <last_ticks.1693>
        ++showing;
   4130b:	8b 05 f3 4c 00 00    	mov    0x4cf3(%rip),%eax        # 46004 <showing.1694>
   41311:	83 c0 01             	add    $0x1,%eax
   41314:	89 05 ea 4c 00 00    	mov    %eax,0x4cea(%rip)        # 46004 <showing.1694>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4131a:	eb 0f                	jmp    4132b <memshow_virtual_animate+0x53>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   4131c:	8b 05 e2 4c 00 00    	mov    0x4ce2(%rip),%eax        # 46004 <showing.1694>
   41322:	83 c0 01             	add    $0x1,%eax
   41325:	89 05 d9 4c 00 00    	mov    %eax,0x4cd9(%rip)        # 46004 <showing.1694>
    while (showing <= 2*NPROC
   4132b:	8b 05 d3 4c 00 00    	mov    0x4cd3(%rip),%eax        # 46004 <showing.1694>
   41331:	83 f8 20             	cmp    $0x20,%eax
   41334:	7f 2e                	jg     41364 <memshow_virtual_animate+0x8c>
           && processes[showing % NPROC].p_state == P_FREE) {
   41336:	8b 05 c8 4c 00 00    	mov    0x4cc8(%rip),%eax        # 46004 <showing.1694>
   4133c:	99                   	cltd   
   4133d:	c1 ea 1c             	shr    $0x1c,%edx
   41340:	01 d0                	add    %edx,%eax
   41342:	83 e0 0f             	and    $0xf,%eax
   41345:	29 d0                	sub    %edx,%eax
   41347:	48 63 d0             	movslq %eax,%rdx
   4134a:	48 89 d0             	mov    %rdx,%rax
   4134d:	48 c1 e0 04          	shl    $0x4,%rax
   41351:	48 29 d0             	sub    %rdx,%rax
   41354:	48 c1 e0 04          	shl    $0x4,%rax
   41358:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   4135e:	8b 00                	mov    (%rax),%eax
   41360:	85 c0                	test   %eax,%eax
   41362:	74 b8                	je     4131c <memshow_virtual_animate+0x44>
    }
    showing = showing % NPROC;
   41364:	8b 05 9a 4c 00 00    	mov    0x4c9a(%rip),%eax        # 46004 <showing.1694>
   4136a:	99                   	cltd   
   4136b:	c1 ea 1c             	shr    $0x1c,%edx
   4136e:	01 d0                	add    %edx,%eax
   41370:	83 e0 0f             	and    $0xf,%eax
   41373:	29 d0                	sub    %edx,%eax
   41375:	89 05 89 4c 00 00    	mov    %eax,0x4c89(%rip)        # 46004 <showing.1694>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4137b:	8b 05 83 4c 00 00    	mov    0x4c83(%rip),%eax        # 46004 <showing.1694>
   41381:	48 63 d0             	movslq %eax,%rdx
   41384:	48 89 d0             	mov    %rdx,%rax
   41387:	48 c1 e0 04          	shl    $0x4,%rax
   4138b:	48 29 d0             	sub    %rdx,%rax
   4138e:	48 c1 e0 04          	shl    $0x4,%rax
   41392:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   41398:	8b 00                	mov    (%rax),%eax
   4139a:	85 c0                	test   %eax,%eax
   4139c:	74 76                	je     41414 <memshow_virtual_animate+0x13c>
   4139e:	8b 05 60 4c 00 00    	mov    0x4c60(%rip),%eax        # 46004 <showing.1694>
   413a4:	48 63 d0             	movslq %eax,%rdx
   413a7:	48 89 d0             	mov    %rdx,%rax
   413aa:	48 c1 e0 04          	shl    $0x4,%rax
   413ae:	48 29 d0             	sub    %rdx,%rax
   413b1:	48 c1 e0 04          	shl    $0x4,%rax
   413b5:	48 05 08 91 05 00    	add    $0x59108,%rax
   413bb:	0f b6 00             	movzbl (%rax),%eax
   413be:	84 c0                	test   %al,%al
   413c0:	74 52                	je     41414 <memshow_virtual_animate+0x13c>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   413c2:	8b 15 3c 4c 00 00    	mov    0x4c3c(%rip),%edx        # 46004 <showing.1694>
   413c8:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   413cc:	89 d1                	mov    %edx,%ecx
   413ce:	ba 0c 48 04 00       	mov    $0x4480c,%edx
   413d3:	be 04 00 00 00       	mov    $0x4,%esi
   413d8:	48 89 c7             	mov    %rax,%rdi
   413db:	b8 00 00 00 00       	mov    $0x0,%eax
   413e0:	e8 3a 24 00 00       	callq  4381f <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   413e5:	8b 05 19 4c 00 00    	mov    0x4c19(%rip),%eax        # 46004 <showing.1694>
   413eb:	48 63 d0             	movslq %eax,%rdx
   413ee:	48 89 d0             	mov    %rdx,%rax
   413f1:	48 c1 e0 04          	shl    $0x4,%rax
   413f5:	48 29 d0             	sub    %rdx,%rax
   413f8:	48 c1 e0 04          	shl    $0x4,%rax
   413fc:	48 05 00 91 05 00    	add    $0x59100,%rax
   41402:	48 8b 00             	mov    (%rax),%rax
   41405:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41409:	48 89 d6             	mov    %rdx,%rsi
   4140c:	48 89 c7             	mov    %rax,%rdi
   4140f:	e8 cb fc ff ff       	callq  410df <memshow_virtual>
    }
}
   41414:	90                   	nop
   41415:	c9                   	leaveq 
   41416:	c3                   	retq   

0000000000041417 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   41417:	55                   	push   %rbp
   41418:	48 89 e5             	mov    %rsp,%rbp
   4141b:	48 83 ec 10          	sub    $0x10,%rsp
   4141f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41423:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   41426:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4142a:	78 06                	js     41432 <pageindex+0x1b>
   4142c:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   41430:	7e 14                	jle    41446 <pageindex+0x2f>
   41432:	ba 20 48 04 00       	mov    $0x44820,%edx
   41437:	be 1e 00 00 00       	mov    $0x1e,%esi
   4143c:	bf 39 48 04 00       	mov    $0x44839,%edi
   41441:	e8 90 16 00 00       	callq  42ad6 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   41446:	b8 03 00 00 00       	mov    $0x3,%eax
   4144b:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4144e:	89 c2                	mov    %eax,%edx
   41450:	89 d0                	mov    %edx,%eax
   41452:	c1 e0 03             	shl    $0x3,%eax
   41455:	01 d0                	add    %edx,%eax
   41457:	83 c0 0c             	add    $0xc,%eax
   4145a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4145e:	89 c1                	mov    %eax,%ecx
   41460:	48 d3 ea             	shr    %cl,%rdx
   41463:	48 89 d0             	mov    %rdx,%rax
   41466:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4146b:	c9                   	leaveq 
   4146c:	c3                   	retq   

000000000004146d <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
static void virtual_memory_init(void);

void hardware_init(void) {
   4146d:	55                   	push   %rbp
   4146e:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41471:	e8 4f 01 00 00       	callq  415c5 <segments_init>
    interrupt_init();
   41476:	e8 b8 03 00 00       	callq  41833 <interrupt_init>
    virtual_memory_init();
   4147b:	e8 8d 05 00 00       	callq  41a0d <virtual_memory_init>
}
   41480:	90                   	nop
   41481:	5d                   	pop    %rbp
   41482:	c3                   	retq   

0000000000041483 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41483:	55                   	push   %rbp
   41484:	48 89 e5             	mov    %rsp,%rbp
   41487:	48 83 ec 18          	sub    $0x18,%rsp
   4148b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4148f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41493:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41496:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41499:	48 98                	cltq   
   4149b:	48 c1 e0 2d          	shl    $0x2d,%rax
   4149f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   414a3:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   414aa:	90 00 00 
   414ad:	48 09 c2             	or     %rax,%rdx
    *segment = type
   414b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414b4:	48 89 10             	mov    %rdx,(%rax)
}
   414b7:	90                   	nop
   414b8:	c9                   	leaveq 
   414b9:	c3                   	retq   

00000000000414ba <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   414ba:	55                   	push   %rbp
   414bb:	48 89 e5             	mov    %rsp,%rbp
   414be:	48 83 ec 28          	sub    $0x28,%rsp
   414c2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   414c6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   414ca:	89 55 ec             	mov    %edx,-0x14(%rbp)
   414cd:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   414d1:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   414d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414d9:	48 c1 e0 10          	shl    $0x10,%rax
   414dd:	48 89 c2             	mov    %rax,%rdx
   414e0:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   414e7:	00 00 00 
   414ea:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   414ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   414f1:	48 c1 e0 20          	shl    $0x20,%rax
   414f5:	48 89 c1             	mov    %rax,%rcx
   414f8:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   414ff:	00 00 ff 
   41502:	48 21 c8             	and    %rcx,%rax
   41505:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41508:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4150c:	48 83 e8 01          	sub    $0x1,%rax
   41510:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41513:	48 09 d0             	or     %rdx,%rax
        | type
   41516:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   4151a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4151d:	48 63 d2             	movslq %edx,%rdx
   41520:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41524:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41527:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4152e:	80 00 00 
   41531:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41534:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41538:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   4153b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4153f:	48 83 c0 08          	add    $0x8,%rax
   41543:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41547:	48 c1 ea 20          	shr    $0x20,%rdx
   4154b:	48 89 10             	mov    %rdx,(%rax)
}
   4154e:	90                   	nop
   4154f:	c9                   	leaveq 
   41550:	c3                   	retq   

0000000000041551 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41551:	55                   	push   %rbp
   41552:	48 89 e5             	mov    %rsp,%rbp
   41555:	48 83 ec 20          	sub    $0x20,%rsp
   41559:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4155d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41561:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41564:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41568:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4156c:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4156f:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41573:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41576:	48 63 d2             	movslq %edx,%rdx
   41579:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4157d:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41580:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41584:	48 c1 e0 20          	shl    $0x20,%rax
   41588:	48 89 c1             	mov    %rax,%rcx
   4158b:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41592:	00 ff ff 
   41595:	48 21 c8             	and    %rcx,%rax
   41598:	48 09 c2             	or     %rax,%rdx
   4159b:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   415a2:	80 00 00 
   415a5:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   415a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415ac:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   415af:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   415b3:	48 c1 e8 20          	shr    $0x20,%rax
   415b7:	48 89 c2             	mov    %rax,%rdx
   415ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   415be:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   415c2:	90                   	nop
   415c3:	c9                   	leaveq 
   415c4:	c3                   	retq   

00000000000415c5 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   415c5:	55                   	push   %rbp
   415c6:	48 89 e5             	mov    %rsp,%rbp
   415c9:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   415cd:	48 c7 05 28 0a 01 00 	movq   $0x0,0x10a28(%rip)        # 52000 <segments>
   415d4:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   415d8:	ba 00 00 00 00       	mov    $0x0,%edx
   415dd:	48 be 00 00 00 00 00 	movabs $0x20080000000000,%rsi
   415e4:	08 20 00 
   415e7:	bf 08 20 05 00       	mov    $0x52008,%edi
   415ec:	e8 92 fe ff ff       	callq  41483 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   415f1:	ba 03 00 00 00       	mov    $0x3,%edx
   415f6:	48 be 00 00 00 00 00 	movabs $0x20080000000000,%rsi
   415fd:	08 20 00 
   41600:	bf 10 20 05 00       	mov    $0x52010,%edi
   41605:	e8 79 fe ff ff       	callq  41483 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4160a:	ba 00 00 00 00       	mov    $0x0,%edx
   4160f:	48 be 00 00 00 00 00 	movabs $0x20000000000,%rsi
   41616:	02 00 00 
   41619:	bf 18 20 05 00       	mov    $0x52018,%edi
   4161e:	e8 60 fe ff ff       	callq  41483 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41623:	ba 03 00 00 00       	mov    $0x3,%edx
   41628:	48 be 00 00 00 00 00 	movabs $0x20000000000,%rsi
   4162f:	02 00 00 
   41632:	bf 20 20 05 00       	mov    $0x52020,%edi
   41637:	e8 47 fe ff ff       	callq  41483 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   4163c:	b8 40 30 05 00       	mov    $0x53040,%eax
   41641:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41647:	48 89 c1             	mov    %rax,%rcx
   4164a:	ba 00 00 00 00       	mov    $0x0,%edx
   4164f:	48 be 00 00 00 00 00 	movabs $0x90000000000,%rsi
   41656:	09 00 00 
   41659:	bf 28 20 05 00       	mov    $0x52028,%edi
   4165e:	e8 57 fe ff ff       	callq  414ba <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41663:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41669:	b8 00 20 05 00       	mov    $0x52000,%eax
   4166e:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41672:	ba 60 00 00 00       	mov    $0x60,%edx
   41677:	be 00 00 00 00       	mov    $0x0,%esi
   4167c:	bf 40 30 05 00       	mov    $0x53040,%edi
   41681:	e8 da 18 00 00       	callq  42f60 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41686:	48 c7 05 b3 19 01 00 	movq   $0x80000,0x119b3(%rip)        # 53044 <kernel_task_descriptor+0x4>
   4168d:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41691:	ba 00 10 00 00       	mov    $0x1000,%edx
   41696:	be 00 00 00 00       	mov    $0x0,%esi
   4169b:	bf 40 20 05 00       	mov    $0x52040,%edi
   416a0:	e8 bb 18 00 00       	callq  42f60 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   416a5:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   416ac:	eb 30                	jmp    416de <segments_init+0x119>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   416ae:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   416b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   416b6:	48 c1 e0 04          	shl    $0x4,%rax
   416ba:	48 05 40 20 05 00    	add    $0x52040,%rax
   416c0:	48 89 d1             	mov    %rdx,%rcx
   416c3:	ba 00 00 00 00       	mov    $0x0,%edx
   416c8:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   416cf:	0e 00 00 
   416d2:	48 89 c7             	mov    %rax,%rdi
   416d5:	e8 77 fe ff ff       	callq  41551 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   416da:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   416de:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   416e5:	76 c7                	jbe    416ae <segments_init+0xe9>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   416e7:	b8 36 00 04 00       	mov    $0x40036,%eax
   416ec:	48 89 c1             	mov    %rax,%rcx
   416ef:	ba 00 00 00 00       	mov    $0x0,%edx
   416f4:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   416fb:	0e 00 00 
   416fe:	bf 40 22 05 00       	mov    $0x52240,%edi
   41703:	e8 49 fe ff ff       	callq  41551 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41708:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4170d:	48 89 c1             	mov    %rax,%rcx
   41710:	ba 00 00 00 00       	mov    $0x0,%edx
   41715:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4171c:	0e 00 00 
   4171f:	bf 10 21 05 00       	mov    $0x52110,%edi
   41724:	e8 28 fe ff ff       	callq  41551 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41729:	b8 32 00 04 00       	mov    $0x40032,%eax
   4172e:	48 89 c1             	mov    %rax,%rcx
   41731:	ba 00 00 00 00       	mov    $0x0,%edx
   41736:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4173d:	0e 00 00 
   41740:	bf 20 21 05 00       	mov    $0x52120,%edi
   41745:	e8 07 fe ff ff       	callq  41551 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4174a:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41751:	eb 3e                	jmp    41791 <segments_init+0x1cc>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41753:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41756:	83 e8 30             	sub    $0x30,%eax
   41759:	89 c0                	mov    %eax,%eax
   4175b:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41762:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41763:	48 89 c2             	mov    %rax,%rdx
   41766:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41769:	48 c1 e0 04          	shl    $0x4,%rax
   4176d:	48 05 40 20 05 00    	add    $0x52040,%rax
   41773:	48 89 d1             	mov    %rdx,%rcx
   41776:	ba 03 00 00 00       	mov    $0x3,%edx
   4177b:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41782:	0e 00 00 
   41785:	48 89 c7             	mov    %rax,%rdi
   41788:	e8 c4 fd ff ff       	callq  41551 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4178d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41791:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41795:	76 bc                	jbe    41753 <segments_init+0x18e>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41797:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   4179d:	b8 40 20 05 00       	mov    $0x52040,%eax
   417a2:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   417a6:	b8 28 00 00 00       	mov    $0x28,%eax
   417ab:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   417af:	0f 00 d8             	ltr    %ax
   417b2:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   417b6:	0f 20 c0             	mov    %cr0,%rax
   417b9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   417bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   417c1:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   417c4:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   417cb:	8b 45 f4             	mov    -0xc(%rbp),%eax
   417ce:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   417d1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   417d4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   417d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   417dc:	0f 22 c0             	mov    %rax,%cr0
}
   417df:	90                   	nop
    lcr0(cr0);
}
   417e0:	90                   	nop
   417e1:	c9                   	leaveq 
   417e2:	c3                   	retq   

00000000000417e3 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   417e3:	55                   	push   %rbp
   417e4:	48 89 e5             	mov    %rsp,%rbp
   417e7:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   417eb:	0f b7 05 ae 18 01 00 	movzwl 0x118ae(%rip),%eax        # 530a0 <interrupts_enabled>
   417f2:	f7 d0                	not    %eax
   417f4:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   417f8:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   417fc:	0f b6 c0             	movzbl %al,%eax
   417ff:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41806:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41809:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4180d:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41810:	ee                   	out    %al,(%dx)
}
   41811:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41812:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41816:	66 c1 e8 08          	shr    $0x8,%ax
   4181a:	0f b6 c0             	movzbl %al,%eax
   4181d:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41824:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41827:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4182b:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4182e:	ee                   	out    %al,(%dx)
}
   4182f:	90                   	nop
}
   41830:	90                   	nop
   41831:	c9                   	leaveq 
   41832:	c3                   	retq   

0000000000041833 <interrupt_init>:

void interrupt_init(void) {
   41833:	55                   	push   %rbp
   41834:	48 89 e5             	mov    %rsp,%rbp
   41837:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   4183b:	66 c7 05 5c 18 01 00 	movw   $0x0,0x1185c(%rip)        # 530a0 <interrupts_enabled>
   41842:	00 00 
    interrupt_mask();
   41844:	e8 9a ff ff ff       	callq  417e3 <interrupt_mask>
   41849:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41850:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41854:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41858:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4185b:	ee                   	out    %al,(%dx)
}
   4185c:	90                   	nop
   4185d:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41864:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41868:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4186c:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4186f:	ee                   	out    %al,(%dx)
}
   41870:	90                   	nop
   41871:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41878:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4187c:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41880:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41883:	ee                   	out    %al,(%dx)
}
   41884:	90                   	nop
   41885:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4188c:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41890:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41894:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41897:	ee                   	out    %al,(%dx)
}
   41898:	90                   	nop
   41899:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   418a0:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418a4:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   418a8:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   418ab:	ee                   	out    %al,(%dx)
}
   418ac:	90                   	nop
   418ad:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   418b4:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418b8:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   418bc:	8b 55 cc             	mov    -0x34(%rbp),%edx
   418bf:	ee                   	out    %al,(%dx)
}
   418c0:	90                   	nop
   418c1:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   418c8:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418cc:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   418d0:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   418d3:	ee                   	out    %al,(%dx)
}
   418d4:	90                   	nop
   418d5:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   418dc:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418e0:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   418e4:	8b 55 dc             	mov    -0x24(%rbp),%edx
   418e7:	ee                   	out    %al,(%dx)
}
   418e8:	90                   	nop
   418e9:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   418f0:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   418f4:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   418f8:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   418fb:	ee                   	out    %al,(%dx)
}
   418fc:	90                   	nop
   418fd:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41904:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41908:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4190c:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4190f:	ee                   	out    %al,(%dx)
}
   41910:	90                   	nop
   41911:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41918:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4191c:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41920:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41923:	ee                   	out    %al,(%dx)
}
   41924:	90                   	nop
   41925:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   4192c:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41930:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41934:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41937:	ee                   	out    %al,(%dx)
}
   41938:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41939:	e8 a5 fe ff ff       	callq  417e3 <interrupt_mask>
}
   4193e:	90                   	nop
   4193f:	c9                   	leaveq 
   41940:	c3                   	retq   

0000000000041941 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41941:	55                   	push   %rbp
   41942:	48 89 e5             	mov    %rsp,%rbp
   41945:	48 83 ec 28          	sub    $0x28,%rsp
   41949:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4194c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41950:	0f 8e 9e 00 00 00    	jle    419f4 <timer_init+0xb3>
   41956:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   4195d:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41961:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41965:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41968:	ee                   	out    %al,(%dx)
}
   41969:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4196a:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4196d:	89 c2                	mov    %eax,%edx
   4196f:	c1 ea 1f             	shr    $0x1f,%edx
   41972:	01 d0                	add    %edx,%eax
   41974:	d1 f8                	sar    %eax
   41976:	05 de 34 12 00       	add    $0x1234de,%eax
   4197b:	99                   	cltd   
   4197c:	f7 7d dc             	idivl  -0x24(%rbp)
   4197f:	89 c2                	mov    %eax,%edx
   41981:	89 d0                	mov    %edx,%eax
   41983:	c1 f8 1f             	sar    $0x1f,%eax
   41986:	c1 e8 18             	shr    $0x18,%eax
   41989:	01 c2                	add    %eax,%edx
   4198b:	0f b6 d2             	movzbl %dl,%edx
   4198e:	29 c2                	sub    %eax,%edx
   41990:	89 d0                	mov    %edx,%eax
   41992:	0f b6 c0             	movzbl %al,%eax
   41995:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   4199c:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4199f:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   419a3:	8b 55 f4             	mov    -0xc(%rbp),%edx
   419a6:	ee                   	out    %al,(%dx)
}
   419a7:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   419a8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   419ab:	89 c2                	mov    %eax,%edx
   419ad:	c1 ea 1f             	shr    $0x1f,%edx
   419b0:	01 d0                	add    %edx,%eax
   419b2:	d1 f8                	sar    %eax
   419b4:	05 de 34 12 00       	add    $0x1234de,%eax
   419b9:	99                   	cltd   
   419ba:	f7 7d dc             	idivl  -0x24(%rbp)
   419bd:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   419c3:	85 c0                	test   %eax,%eax
   419c5:	0f 48 c2             	cmovs  %edx,%eax
   419c8:	c1 f8 08             	sar    $0x8,%eax
   419cb:	0f b6 c0             	movzbl %al,%eax
   419ce:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   419d5:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419d8:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   419dc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   419df:	ee                   	out    %al,(%dx)
}
   419e0:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   419e1:	0f b7 05 b8 16 01 00 	movzwl 0x116b8(%rip),%eax        # 530a0 <interrupts_enabled>
   419e8:	83 c8 01             	or     $0x1,%eax
   419eb:	66 89 05 ae 16 01 00 	mov    %ax,0x116ae(%rip)        # 530a0 <interrupts_enabled>
   419f2:	eb 11                	jmp    41a05 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   419f4:	0f b7 05 a5 16 01 00 	movzwl 0x116a5(%rip),%eax        # 530a0 <interrupts_enabled>
   419fb:	83 e0 fe             	and    $0xfffffffe,%eax
   419fe:	66 89 05 9b 16 01 00 	mov    %ax,0x1169b(%rip)        # 530a0 <interrupts_enabled>
    }
    interrupt_mask();
   41a05:	e8 d9 fd ff ff       	callq  417e3 <interrupt_mask>
}
   41a0a:	90                   	nop
   41a0b:	c9                   	leaveq 
   41a0c:	c3                   	retq   

0000000000041a0d <virtual_memory_init>:
//    `kernel_pagetable`.

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;

void virtual_memory_init(void) {
   41a0d:	55                   	push   %rbp
   41a0e:	48 89 e5             	mov    %rsp,%rbp
   41a11:	48 83 ec 10          	sub    $0x10,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   41a15:	48 c7 05 20 89 01 00 	movq   $0x54000,0x18920(%rip)        # 5a340 <kernel_pagetable>
   41a1c:	00 40 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   41a20:	ba 00 50 00 00       	mov    $0x5000,%edx
   41a25:	be 00 00 00 00       	mov    $0x0,%esi
   41a2a:	bf 00 40 05 00       	mov    $0x54000,%edi
   41a2f:	e8 2c 15 00 00       	callq  42f60 <memset>
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   41a34:	b8 00 50 05 00       	mov    $0x55000,%eax
   41a39:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   41a3d:	48 89 05 bc 25 01 00 	mov    %rax,0x125bc(%rip)        # 54000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   41a44:	b8 00 60 05 00       	mov    $0x56000,%eax
   41a49:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   41a4d:	48 89 05 ac 35 01 00 	mov    %rax,0x135ac(%rip)        # 55000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   41a54:	b8 00 70 05 00       	mov    $0x57000,%eax
   41a59:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   41a5d:	48 89 05 9c 45 01 00 	mov    %rax,0x1459c(%rip)        # 56000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   41a64:	b8 00 80 05 00       	mov    $0x58000,%eax
   41a69:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   41a6d:	48 89 05 94 45 01 00 	mov    %rax,0x14594(%rip)        # 56008 <kernel_pagetables+0x2008>

    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   41a74:	48 8b 05 c5 88 01 00 	mov    0x188c5(%rip),%rax        # 5a340 <kernel_pagetable>
   41a7b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   41a81:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   41a87:	b9 00 00 20 00       	mov    $0x200000,%ecx
   41a8c:	ba 00 00 00 00       	mov    $0x0,%edx
   41a91:	be 00 00 00 00       	mov    $0x0,%esi
   41a96:	48 89 c7             	mov    %rax,%rdi
   41a99:	e8 16 00 00 00       	callq  41ab4 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U, NULL);

    lcr3((uintptr_t) kernel_pagetable);
   41a9e:	48 8b 05 9b 88 01 00 	mov    0x1889b(%rip),%rax        # 5a340 <kernel_pagetable>
   41aa5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   41aa9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41aad:	0f 22 d8             	mov    %rax,%cr3
}
   41ab0:	90                   	nop
}
   41ab1:	90                   	nop
   41ab2:	c9                   	leaveq 
   41ab3:	c3                   	retq   

0000000000041ab4 <virtual_memory_map>:
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm, x86_64_pagetable* (*allocator)(void));

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm,
                       x86_64_pagetable* (*allocator)(void)) {
   41ab4:	55                   	push   %rbp
   41ab5:	48 89 e5             	mov    %rsp,%rbp
   41ab8:	53                   	push   %rbx
   41ab9:	48 83 ec 58          	sub    $0x58,%rsp
   41abd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41ac1:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   41ac5:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   41ac9:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   41acd:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)
   41ad1:	4c 89 4d a0          	mov    %r9,-0x60(%rbp)
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   41ad5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41ad9:	25 ff 0f 00 00       	and    $0xfff,%eax
   41ade:	48 85 c0             	test   %rax,%rax
   41ae1:	74 14                	je     41af7 <virtual_memory_map+0x43>
   41ae3:	ba 42 48 04 00       	mov    $0x44842,%edx
   41ae8:	be 3b 01 00 00       	mov    $0x13b,%esi
   41aed:	bf 55 48 04 00       	mov    $0x44855,%edi
   41af2:	e8 df 0f 00 00       	callq  42ad6 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   41af7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41afb:	25 ff 0f 00 00       	and    $0xfff,%eax
   41b00:	48 85 c0             	test   %rax,%rax
   41b03:	74 14                	je     41b19 <virtual_memory_map+0x65>
   41b05:	ba 62 48 04 00       	mov    $0x44862,%edx
   41b0a:	be 3c 01 00 00       	mov    $0x13c,%esi
   41b0f:	bf 55 48 04 00       	mov    $0x44855,%edi
   41b14:	e8 bd 0f 00 00       	callq  42ad6 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   41b19:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   41b1d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41b21:	48 01 d0             	add    %rdx,%rax
   41b24:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   41b28:	76 24                	jbe    41b4e <virtual_memory_map+0x9a>
   41b2a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   41b2e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41b32:	48 01 d0             	add    %rdx,%rax
   41b35:	48 85 c0             	test   %rax,%rax
   41b38:	74 14                	je     41b4e <virtual_memory_map+0x9a>
   41b3a:	ba 75 48 04 00       	mov    $0x44875,%edx
   41b3f:	be 3d 01 00 00       	mov    $0x13d,%esi
   41b44:	bf 55 48 04 00       	mov    $0x44855,%edi
   41b49:	e8 88 0f 00 00       	callq  42ad6 <assert_fail>
    if (perm & PTE_P) {
   41b4e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41b51:	48 98                	cltq   
   41b53:	83 e0 01             	and    $0x1,%eax
   41b56:	48 85 c0             	test   %rax,%rax
   41b59:	74 6e                	je     41bc9 <virtual_memory_map+0x115>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   41b5b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41b5f:	25 ff 0f 00 00       	and    $0xfff,%eax
   41b64:	48 85 c0             	test   %rax,%rax
   41b67:	74 14                	je     41b7d <virtual_memory_map+0xc9>
   41b69:	ba 93 48 04 00       	mov    $0x44893,%edx
   41b6e:	be 3f 01 00 00       	mov    $0x13f,%esi
   41b73:	bf 55 48 04 00       	mov    $0x44855,%edi
   41b78:	e8 59 0f 00 00       	callq  42ad6 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   41b7d:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41b81:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41b85:	48 01 d0             	add    %rdx,%rax
   41b88:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   41b8c:	76 14                	jbe    41ba2 <virtual_memory_map+0xee>
   41b8e:	ba a6 48 04 00       	mov    $0x448a6,%edx
   41b93:	be 40 01 00 00       	mov    $0x140,%esi
   41b98:	bf 55 48 04 00       	mov    $0x44855,%edi
   41b9d:	e8 34 0f 00 00       	callq  42ad6 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   41ba2:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41ba6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41baa:	48 01 d0             	add    %rdx,%rax
   41bad:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   41bb3:	76 14                	jbe    41bc9 <virtual_memory_map+0x115>
   41bb5:	ba b4 48 04 00       	mov    $0x448b4,%edx
   41bba:	be 41 01 00 00       	mov    $0x141,%esi
   41bbf:	bf 55 48 04 00       	mov    $0x44855,%edi
   41bc4:	e8 0d 0f 00 00       	callq  42ad6 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense
   41bc9:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   41bcd:	78 09                	js     41bd8 <virtual_memory_map+0x124>
   41bcf:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   41bd6:	7e 14                	jle    41bec <virtual_memory_map+0x138>
   41bd8:	ba d0 48 04 00       	mov    $0x448d0,%edx
   41bdd:	be 43 01 00 00       	mov    $0x143,%esi
   41be2:	bf 55 48 04 00       	mov    $0x44855,%edi
   41be7:	e8 ea 0e 00 00       	callq  42ad6 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   41bec:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41bf0:	25 ff 0f 00 00       	and    $0xfff,%eax
   41bf5:	48 85 c0             	test   %rax,%rax
   41bf8:	74 14                	je     41c0e <virtual_memory_map+0x15a>
   41bfa:	ba f0 48 04 00       	mov    $0x448f0,%edx
   41bff:	be 44 01 00 00       	mov    $0x144,%esi
   41c04:	bf 55 48 04 00       	mov    $0x44855,%edi
   41c09:	e8 c8 0e 00 00       	callq  42ad6 <assert_fail>

    int last_index123 = -1;
   41c0e:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   41c15:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   41c1c:	00 
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   41c1d:	e9 ce 00 00 00       	jmpq   41cf0 <virtual_memory_map+0x23c>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   41c22:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41c26:	48 c1 e8 15          	shr    $0x15,%rax
   41c2a:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   41c2d:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c30:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   41c33:	74 21                	je     41c56 <virtual_memory_map+0x1a2>
            l4pagetable = lookup_l4pagetable(pagetable, va, perm, allocator);
   41c35:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   41c39:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41c3c:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   41c40:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41c44:	48 89 c7             	mov    %rax,%rdi
   41c47:	e8 bb 00 00 00       	callq  41d07 <lookup_l4pagetable>
   41c4c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   41c50:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41c53:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) {
   41c56:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41c59:	48 98                	cltq   
   41c5b:	83 e0 01             	and    $0x1,%eax
   41c5e:	48 85 c0             	test   %rax,%rax
   41c61:	74 34                	je     41c97 <virtual_memory_map+0x1e3>
   41c63:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41c68:	74 2d                	je     41c97 <virtual_memory_map+0x1e3>
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   41c6a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41c6d:	48 63 d8             	movslq %eax,%rbx
   41c70:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41c74:	be 03 00 00 00       	mov    $0x3,%esi
   41c79:	48 89 c7             	mov    %rax,%rdi
   41c7c:	e8 96 f7 ff ff       	callq  41417 <pageindex>
   41c81:	89 c2                	mov    %eax,%edx
   41c83:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   41c87:	48 89 d9             	mov    %rbx,%rcx
   41c8a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41c8e:	48 63 d2             	movslq %edx,%rdx
   41c91:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   41c95:	eb 41                	jmp    41cd8 <virtual_memory_map+0x224>
        } else if (l4pagetable) {
   41c97:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41c9c:	74 26                	je     41cc4 <virtual_memory_map+0x210>
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   41c9e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41ca2:	be 03 00 00 00       	mov    $0x3,%esi
   41ca7:	48 89 c7             	mov    %rax,%rdi
   41caa:	e8 68 f7 ff ff       	callq  41417 <pageindex>
   41caf:	89 c2                	mov    %eax,%edx
   41cb1:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41cb4:	48 63 c8             	movslq %eax,%rcx
   41cb7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41cbb:	48 63 d2             	movslq %edx,%rdx
   41cbe:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   41cc2:	eb 14                	jmp    41cd8 <virtual_memory_map+0x224>
        } else if (perm & PTE_P) {
   41cc4:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41cc7:	48 98                	cltq   
   41cc9:	83 e0 01             	and    $0x1,%eax
   41ccc:	48 85 c0             	test   %rax,%rax
   41ccf:	74 07                	je     41cd8 <virtual_memory_map+0x224>
            return -1;
   41cd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41cd6:	eb 28                	jmp    41d00 <virtual_memory_map+0x24c>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   41cd8:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   41cdf:	00 
   41ce0:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   41ce7:	00 
   41ce8:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   41cef:	00 
   41cf0:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   41cf5:	0f 85 27 ff ff ff    	jne    41c22 <virtual_memory_map+0x16e>
        }
    }
    return 0;
   41cfb:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41d00:	48 83 c4 58          	add    $0x58,%rsp
   41d04:	5b                   	pop    %rbx
   41d05:	5d                   	pop    %rbp
   41d06:	c3                   	retq   

0000000000041d07 <lookup_l4pagetable>:

static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm, x86_64_pagetable* (*allocator)(void)) {
   41d07:	55                   	push   %rbp
   41d08:	48 89 e5             	mov    %rsp,%rbp
   41d0b:	48 83 ec 40          	sub    $0x40,%rsp
   41d0f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   41d13:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   41d17:	89 55 cc             	mov    %edx,-0x34(%rbp)
   41d1a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    x86_64_pagetable* pt = pagetable;
   41d1e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41d22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   41d26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41d2d:	e9 69 01 00 00       	jmpq   41e9b <lookup_l4pagetable+0x194>
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   41d32:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d35:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   41d39:	89 d6                	mov    %edx,%esi
   41d3b:	48 89 c7             	mov    %rax,%rdi
   41d3e:	e8 d4 f6 ff ff       	callq  41417 <pageindex>
   41d43:	89 c2                	mov    %eax,%edx
   41d45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d49:	48 63 d2             	movslq %edx,%rdx
   41d4c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41d50:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (!(pe & PTE_P)) {
   41d54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41d58:	83 e0 01             	and    $0x1,%eax
   41d5b:	48 85 c0             	test   %rax,%rax
   41d5e:	0f 85 a5 00 00 00    	jne    41e09 <lookup_l4pagetable+0x102>
            // allocate a new page table page if required
            if (!(perm & PTE_P) || !allocator) {
   41d64:	8b 45 cc             	mov    -0x34(%rbp),%eax
   41d67:	48 98                	cltq   
   41d69:	83 e0 01             	and    $0x1,%eax
   41d6c:	48 85 c0             	test   %rax,%rax
   41d6f:	74 07                	je     41d78 <lookup_l4pagetable+0x71>
   41d71:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   41d76:	75 0a                	jne    41d82 <lookup_l4pagetable+0x7b>
                return NULL;
   41d78:	b8 00 00 00 00       	mov    $0x0,%eax
   41d7d:	e9 27 01 00 00       	jmpq   41ea9 <lookup_l4pagetable+0x1a2>
            }
            x86_64_pagetable* new_pt = allocator();
   41d82:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41d86:	ff d0                	callq  *%rax
   41d88:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (!new_pt) {
   41d8c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41d91:	75 0a                	jne    41d9d <lookup_l4pagetable+0x96>
                return NULL;
   41d93:	b8 00 00 00 00       	mov    $0x0,%eax
   41d98:	e9 0c 01 00 00       	jmpq   41ea9 <lookup_l4pagetable+0x1a2>
            }
            assert((uintptr_t) new_pt % PAGESIZE == 0);
   41d9d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41da1:	25 ff 0f 00 00       	and    $0xfff,%eax
   41da6:	48 85 c0             	test   %rax,%rax
   41da9:	74 14                	je     41dbf <lookup_l4pagetable+0xb8>
   41dab:	ba 18 49 04 00       	mov    $0x44918,%edx
   41db0:	be 67 01 00 00       	mov    $0x167,%esi
   41db5:	bf 55 48 04 00       	mov    $0x44855,%edi
   41dba:	e8 17 0d 00 00       	callq  42ad6 <assert_fail>
            pt->entry[PAGEINDEX(va, i)] = pe =
                PTE_ADDR(new_pt) | PTE_P | PTE_W | PTE_U;
   41dbf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41dc3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
            pt->entry[PAGEINDEX(va, i)] = pe =
   41dc9:	48 83 c8 07          	or     $0x7,%rax
   41dcd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   41dd1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dd4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   41dd8:	89 d6                	mov    %edx,%esi
   41dda:	48 89 c7             	mov    %rax,%rdi
   41ddd:	e8 35 f6 ff ff       	callq  41417 <pageindex>
   41de2:	89 c2                	mov    %eax,%edx
   41de4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41de8:	48 63 d2             	movslq %edx,%rdx
   41deb:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   41def:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
            memset(new_pt, 0, PAGESIZE);
   41df3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41df7:	ba 00 10 00 00       	mov    $0x1000,%edx
   41dfc:	be 00 00 00 00       	mov    $0x0,%esi
   41e01:	48 89 c7             	mov    %rax,%rdi
   41e04:	e8 57 11 00 00       	callq  42f60 <memset>
        }

        // sanity-check page entry
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   41e09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e0d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41e13:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41e19:	76 14                	jbe    41e2f <lookup_l4pagetable+0x128>
   41e1b:	ba 40 49 04 00       	mov    $0x44940,%edx
   41e20:	be 6e 01 00 00       	mov    $0x16e,%esi
   41e25:	bf 55 48 04 00       	mov    $0x44855,%edi
   41e2a:	e8 a7 0c 00 00       	callq  42ad6 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   41e2f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   41e32:	48 98                	cltq   
   41e34:	83 e0 02             	and    $0x2,%eax
   41e37:	48 85 c0             	test   %rax,%rax
   41e3a:	74 20                	je     41e5c <lookup_l4pagetable+0x155>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   41e3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e40:	83 e0 02             	and    $0x2,%eax
   41e43:	48 85 c0             	test   %rax,%rax
   41e46:	75 14                	jne    41e5c <lookup_l4pagetable+0x155>
   41e48:	ba 60 49 04 00       	mov    $0x44960,%edx
   41e4d:	be 70 01 00 00       	mov    $0x170,%esi
   41e52:	bf 55 48 04 00       	mov    $0x44855,%edi
   41e57:	e8 7a 0c 00 00       	callq  42ad6 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   41e5c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   41e5f:	48 98                	cltq   
   41e61:	83 e0 04             	and    $0x4,%eax
   41e64:	48 85 c0             	test   %rax,%rax
   41e67:	74 20                	je     41e89 <lookup_l4pagetable+0x182>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   41e69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e6d:	83 e0 04             	and    $0x4,%eax
   41e70:	48 85 c0             	test   %rax,%rax
   41e73:	75 14                	jne    41e89 <lookup_l4pagetable+0x182>
   41e75:	ba 6b 49 04 00       	mov    $0x4496b,%edx
   41e7a:	be 73 01 00 00       	mov    $0x173,%esi
   41e7f:	bf 55 48 04 00       	mov    $0x44855,%edi
   41e84:	e8 4d 0c 00 00       	callq  42ad6 <assert_fail>
        }

        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   41e89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e8d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41e93:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   41e97:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41e9b:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   41e9f:	0f 8e 8d fe ff ff    	jle    41d32 <lookup_l4pagetable+0x2b>
    }
    return pt;
   41ea5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   41ea9:	c9                   	leaveq 
   41eaa:	c3                   	retq   

0000000000041eab <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   41eab:	55                   	push   %rbp
   41eac:	48 89 e5             	mov    %rsp,%rbp
   41eaf:	48 83 ec 50          	sub    $0x50,%rsp
   41eb3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41eb7:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   41ebb:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   41ebf:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41ec3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   41ec7:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   41ece:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   41ecf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   41ed6:	eb 41                	jmp    41f19 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   41ed8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41edb:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41edf:	89 d6                	mov    %edx,%esi
   41ee1:	48 89 c7             	mov    %rax,%rdi
   41ee4:	e8 2e f5 ff ff       	callq  41417 <pageindex>
   41ee9:	89 c2                	mov    %eax,%edx
   41eeb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eef:	48 63 d2             	movslq %edx,%rdx
   41ef2:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41ef6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41efa:	83 e2 06             	and    $0x6,%edx
   41efd:	48 f7 d2             	not    %rdx
   41f00:	48 21 d0             	and    %rdx,%rax
   41f03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   41f07:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41f0b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41f11:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   41f15:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   41f19:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   41f1d:	7f 0c                	jg     41f2b <virtual_memory_lookup+0x80>
   41f1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41f23:	83 e0 01             	and    $0x1,%eax
   41f26:	48 85 c0             	test   %rax,%rax
   41f29:	75 ad                	jne    41ed8 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   41f2b:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   41f32:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   41f39:	ff 
   41f3a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   41f41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41f45:	83 e0 01             	and    $0x1,%eax
   41f48:	48 85 c0             	test   %rax,%rax
   41f4b:	74 34                	je     41f81 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   41f4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41f51:	48 c1 e8 0c          	shr    $0xc,%rax
   41f55:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   41f58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41f5c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41f62:	48 89 c2             	mov    %rax,%rdx
   41f65:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41f69:	25 ff 0f 00 00       	and    $0xfff,%eax
   41f6e:	48 09 d0             	or     %rdx,%rax
   41f71:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   41f75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41f79:	25 ff 0f 00 00       	and    $0xfff,%eax
   41f7e:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   41f81:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41f85:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   41f89:	48 89 10             	mov    %rdx,(%rax)
   41f8c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   41f90:	48 89 50 08          	mov    %rdx,0x8(%rax)
   41f94:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41f98:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   41f9c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41fa0:	c9                   	leaveq 
   41fa1:	c3                   	retq   

0000000000041fa2 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   41fa2:	55                   	push   %rbp
   41fa3:	48 89 e5             	mov    %rsp,%rbp
   41fa6:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   41faa:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   41fae:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   41fb2:	25 ff 0f 00 00       	and    $0xfff,%eax
   41fb7:	48 85 c0             	test   %rax,%rax
   41fba:	74 14                	je     41fd0 <set_pagetable+0x2e>
   41fbc:	ba 76 49 04 00       	mov    $0x44976,%edx
   41fc1:	be 97 01 00 00       	mov    $0x197,%esi
   41fc6:	bf 55 48 04 00       	mov    $0x44855,%edi
   41fcb:	e8 06 0b 00 00       	callq  42ad6 <assert_fail>
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   41fd0:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41fd5:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   41fd9:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   41fdd:	48 89 ce             	mov    %rcx,%rsi
   41fe0:	48 89 c7             	mov    %rax,%rdi
   41fe3:	e8 c3 fe ff ff       	callq  41eab <virtual_memory_lookup>
   41fe8:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   41fec:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41ff1:	48 39 d0             	cmp    %rdx,%rax
   41ff4:	74 14                	je     4200a <set_pagetable+0x68>
   41ff6:	ba 98 49 04 00       	mov    $0x44998,%edx
   41ffb:	be 98 01 00 00       	mov    $0x198,%esi
   42000:	bf 55 48 04 00       	mov    $0x44855,%edi
   42005:	e8 cc 0a 00 00       	callq  42ad6 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   4200a:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   4200e:	48 8b 0d 2b 83 01 00 	mov    0x1832b(%rip),%rcx        # 5a340 <kernel_pagetable>
   42015:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42019:	48 89 ce             	mov    %rcx,%rsi
   4201c:	48 89 c7             	mov    %rax,%rdi
   4201f:	e8 87 fe ff ff       	callq  41eab <virtual_memory_lookup>
   42024:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42028:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4202c:	48 39 c2             	cmp    %rax,%rdx
   4202f:	74 14                	je     42045 <set_pagetable+0xa3>
   42031:	ba 00 4a 04 00       	mov    $0x44a00,%edx
   42036:	be 9a 01 00 00       	mov    $0x19a,%esi
   4203b:	bf 55 48 04 00       	mov    $0x44855,%edi
   42040:	e8 91 0a 00 00       	callq  42ad6 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42045:	48 8b 05 f4 82 01 00 	mov    0x182f4(%rip),%rax        # 5a340 <kernel_pagetable>
   4204c:	48 89 c2             	mov    %rax,%rdx
   4204f:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42053:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42057:	48 89 ce             	mov    %rcx,%rsi
   4205a:	48 89 c7             	mov    %rax,%rdi
   4205d:	e8 49 fe ff ff       	callq  41eab <virtual_memory_lookup>
   42062:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42066:	48 8b 15 d3 82 01 00 	mov    0x182d3(%rip),%rdx        # 5a340 <kernel_pagetable>
   4206d:	48 39 d0             	cmp    %rdx,%rax
   42070:	74 14                	je     42086 <set_pagetable+0xe4>
   42072:	ba 60 4a 04 00       	mov    $0x44a60,%edx
   42077:	be 9c 01 00 00       	mov    $0x19c,%esi
   4207c:	bf 55 48 04 00       	mov    $0x44855,%edi
   42081:	e8 50 0a 00 00       	callq  42ad6 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42086:	ba b4 1a 04 00       	mov    $0x41ab4,%edx
   4208b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4208f:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42093:	48 89 ce             	mov    %rcx,%rsi
   42096:	48 89 c7             	mov    %rax,%rdi
   42099:	e8 0d fe ff ff       	callq  41eab <virtual_memory_lookup>
   4209e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   420a2:	ba b4 1a 04 00       	mov    $0x41ab4,%edx
   420a7:	48 39 d0             	cmp    %rdx,%rax
   420aa:	74 14                	je     420c0 <set_pagetable+0x11e>
   420ac:	ba c8 4a 04 00       	mov    $0x44ac8,%edx
   420b1:	be 9e 01 00 00       	mov    $0x19e,%esi
   420b6:	bf 55 48 04 00       	mov    $0x44855,%edi
   420bb:	e8 16 0a 00 00       	callq  42ad6 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   420c0:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   420c4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   420c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420cc:	0f 22 d8             	mov    %rax,%cr3
}
   420cf:	90                   	nop
}
   420d0:	90                   	nop
   420d1:	c9                   	leaveq 
   420d2:	c3                   	retq   

00000000000420d3 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   420d3:	55                   	push   %rbp
   420d4:	48 89 e5             	mov    %rsp,%rbp
   420d7:	48 83 ec 08          	sub    $0x8,%rsp
   420db:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   420df:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   420e4:	74 14                	je     420fa <physical_memory_isreserved+0x27>
   420e6:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   420ed:	00 
   420ee:	76 11                	jbe    42101 <physical_memory_isreserved+0x2e>
   420f0:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   420f7:	00 
   420f8:	77 07                	ja     42101 <physical_memory_isreserved+0x2e>
   420fa:	b8 01 00 00 00       	mov    $0x1,%eax
   420ff:	eb 05                	jmp    42106 <physical_memory_isreserved+0x33>
   42101:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42106:	c9                   	leaveq 
   42107:	c3                   	retq   

0000000000042108 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   42108:	55                   	push   %rbp
   42109:	48 89 e5             	mov    %rsp,%rbp
   4210c:	48 83 ec 10          	sub    $0x10,%rsp
   42110:	89 7d fc             	mov    %edi,-0x4(%rbp)
   42113:	89 75 f8             	mov    %esi,-0x8(%rbp)
   42116:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   42119:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4211c:	c1 e0 10             	shl    $0x10,%eax
   4211f:	89 c2                	mov    %eax,%edx
   42121:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42124:	c1 e0 0b             	shl    $0xb,%eax
   42127:	09 c2                	or     %eax,%edx
   42129:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4212c:	c1 e0 08             	shl    $0x8,%eax
   4212f:	09 d0                	or     %edx,%eax
}
   42131:	c9                   	leaveq 
   42132:	c3                   	retq   

0000000000042133 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42133:	55                   	push   %rbp
   42134:	48 89 e5             	mov    %rsp,%rbp
   42137:	48 83 ec 18          	sub    $0x18,%rsp
   4213b:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4213e:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   42141:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42144:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42147:	09 d0                	or     %edx,%eax
   42149:	0d 00 00 00 80       	or     $0x80000000,%eax
   4214e:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42155:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42158:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4215b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4215e:	ef                   	out    %eax,(%dx)
}
   4215f:	90                   	nop
   42160:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42167:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4216a:	89 c2                	mov    %eax,%edx
   4216c:	ed                   	in     (%dx),%eax
   4216d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   42170:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42173:	c9                   	leaveq 
   42174:	c3                   	retq   

0000000000042175 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42175:	55                   	push   %rbp
   42176:	48 89 e5             	mov    %rsp,%rbp
   42179:	48 83 ec 28          	sub    $0x28,%rsp
   4217d:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42180:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42183:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4218a:	eb 73                	jmp    421ff <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   4218c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42193:	eb 60                	jmp    421f5 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42195:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   4219c:	eb 4a                	jmp    421e8 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4219e:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421a1:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   421a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421a7:	89 ce                	mov    %ecx,%esi
   421a9:	89 c7                	mov    %eax,%edi
   421ab:	e8 58 ff ff ff       	callq  42108 <pci_make_configaddr>
   421b0:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   421b3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421b6:	be 00 00 00 00       	mov    $0x0,%esi
   421bb:	89 c7                	mov    %eax,%edi
   421bd:	e8 71 ff ff ff       	callq  42133 <pci_config_readl>
   421c2:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   421c5:	8b 45 d8             	mov    -0x28(%rbp),%eax
   421c8:	c1 e0 10             	shl    $0x10,%eax
   421cb:	0b 45 dc             	or     -0x24(%rbp),%eax
   421ce:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   421d1:	75 05                	jne    421d8 <pci_find_device+0x63>
                    return configaddr;
   421d3:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421d6:	eb 35                	jmp    4220d <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   421d8:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   421dc:	75 06                	jne    421e4 <pci_find_device+0x6f>
   421de:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   421e2:	74 0c                	je     421f0 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   421e4:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   421e8:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   421ec:	75 b0                	jne    4219e <pci_find_device+0x29>
   421ee:	eb 01                	jmp    421f1 <pci_find_device+0x7c>
                    break;
   421f0:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   421f1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   421f5:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   421f9:	75 9a                	jne    42195 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   421fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   421ff:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   42206:	75 84                	jne    4218c <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   42208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   4220d:	c9                   	leaveq 
   4220e:	c3                   	retq   

000000000004220f <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   4220f:	55                   	push   %rbp
   42210:	48 89 e5             	mov    %rsp,%rbp
   42213:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   42217:	be 13 71 00 00       	mov    $0x7113,%esi
   4221c:	bf 86 80 00 00       	mov    $0x8086,%edi
   42221:	e8 4f ff ff ff       	callq  42175 <pci_find_device>
   42226:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42229:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4222d:	78 30                	js     4225f <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4222f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42232:	be 40 00 00 00       	mov    $0x40,%esi
   42237:	89 c7                	mov    %eax,%edi
   42239:	e8 f5 fe ff ff       	callq  42133 <pci_config_readl>
   4223e:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42243:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42246:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42249:	83 c0 04             	add    $0x4,%eax
   4224c:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4224f:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42255:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42259:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4225c:	66 ef                	out    %ax,(%dx)
}
   4225e:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4225f:	ba 2e 4b 04 00       	mov    $0x44b2e,%edx
   42264:	be 00 c0 00 00       	mov    $0xc000,%esi
   42269:	bf 80 07 00 00       	mov    $0x780,%edi
   4226e:	b8 00 00 00 00       	mov    $0x0,%eax
   42273:	e8 26 15 00 00       	callq  4379e <console_printf>
 spinloop: goto spinloop;
   42278:	eb fe                	jmp    42278 <poweroff+0x69>

000000000004227a <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   4227a:	55                   	push   %rbp
   4227b:	48 89 e5             	mov    %rsp,%rbp
   4227e:	48 83 ec 10          	sub    $0x10,%rsp
   42282:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42289:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4228d:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42291:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42294:	ee                   	out    %al,(%dx)
}
   42295:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42296:	eb fe                	jmp    42296 <reboot+0x1c>

0000000000042298 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42298:	55                   	push   %rbp
   42299:	48 89 e5             	mov    %rsp,%rbp
   4229c:	48 83 ec 10          	sub    $0x10,%rsp
   422a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   422a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   422a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422ab:	48 83 c0 18          	add    $0x18,%rax
   422af:	ba c0 00 00 00       	mov    $0xc0,%edx
   422b4:	be 00 00 00 00       	mov    $0x0,%esi
   422b9:	48 89 c7             	mov    %rax,%rdi
   422bc:	e8 9f 0c 00 00       	callq  42f60 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   422c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422c5:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   422cc:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   422ce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422d2:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   422d9:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   422dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422e1:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   422e8:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   422ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422f0:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   422f7:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   422f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   422fd:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   42304:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   42308:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4230b:	83 e0 01             	and    $0x1,%eax
   4230e:	85 c0                	test   %eax,%eax
   42310:	74 1c                	je     4232e <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   42312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42316:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   4231d:	80 cc 30             	or     $0x30,%ah
   42320:	48 89 c2             	mov    %rax,%rdx
   42323:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42327:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4232e:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42331:	83 e0 02             	and    $0x2,%eax
   42334:	85 c0                	test   %eax,%eax
   42336:	74 1c                	je     42354 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42338:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4233c:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   42343:	80 e4 fd             	and    $0xfd,%ah
   42346:	48 89 c2             	mov    %rax,%rdx
   42349:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4234d:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   42354:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42358:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   4235f:	90                   	nop
   42360:	c9                   	leaveq 
   42361:	c3                   	retq   

0000000000042362 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42362:	55                   	push   %rbp
   42363:	48 89 e5             	mov    %rsp,%rbp
   42366:	48 83 ec 28          	sub    $0x28,%rsp
   4236a:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4236d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42371:	78 09                	js     4237c <console_show_cursor+0x1a>
   42373:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4237a:	7e 07                	jle    42383 <console_show_cursor+0x21>
        cpos = 0;
   4237c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42383:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4238a:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4238e:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42392:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42395:	ee                   	out    %al,(%dx)
}
   42396:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42397:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4239a:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   423a0:	85 c0                	test   %eax,%eax
   423a2:	0f 48 c2             	cmovs  %edx,%eax
   423a5:	c1 f8 08             	sar    $0x8,%eax
   423a8:	0f b6 c0             	movzbl %al,%eax
   423ab:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   423b2:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423b5:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   423b9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   423bc:	ee                   	out    %al,(%dx)
}
   423bd:	90                   	nop
   423be:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   423c5:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423c9:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   423cd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   423d0:	ee                   	out    %al,(%dx)
}
   423d1:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   423d2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   423d5:	99                   	cltd   
   423d6:	c1 ea 18             	shr    $0x18,%edx
   423d9:	01 d0                	add    %edx,%eax
   423db:	0f b6 c0             	movzbl %al,%eax
   423de:	29 d0                	sub    %edx,%eax
   423e0:	0f b6 c0             	movzbl %al,%eax
   423e3:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   423ea:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   423ed:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   423f1:	8b 55 fc             	mov    -0x4(%rbp),%edx
   423f4:	ee                   	out    %al,(%dx)
}
   423f5:	90                   	nop
}
   423f6:	90                   	nop
   423f7:	c9                   	leaveq 
   423f8:	c3                   	retq   

00000000000423f9 <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   423f9:	55                   	push   %rbp
   423fa:	48 89 e5             	mov    %rsp,%rbp
   423fd:	48 83 ec 20          	sub    $0x20,%rsp
   42401:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42408:	8b 45 f0             	mov    -0x10(%rbp),%eax
   4240b:	89 c2                	mov    %eax,%edx
   4240d:	ec                   	in     (%dx),%al
   4240e:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42411:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   42415:	0f b6 c0             	movzbl %al,%eax
   42418:	83 e0 01             	and    $0x1,%eax
   4241b:	85 c0                	test   %eax,%eax
   4241d:	75 0a                	jne    42429 <keyboard_readc+0x30>
        return -1;
   4241f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42424:	e9 e5 01 00 00       	jmpq   4260e <keyboard_readc+0x215>
   42429:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42430:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42433:	89 c2                	mov    %eax,%edx
   42435:	ec                   	in     (%dx),%al
   42436:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   42439:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4243d:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42440:	0f b6 05 b9 6b 01 00 	movzbl 0x16bb9(%rip),%eax        # 59000 <last_escape.1676>
   42447:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4244a:	c6 05 af 6b 01 00 00 	movb   $0x0,0x16baf(%rip)        # 59000 <last_escape.1676>

    if (data == 0xE0) {         // mode shift
   42451:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42455:	75 11                	jne    42468 <keyboard_readc+0x6f>
        last_escape = 0x80;
   42457:	c6 05 a2 6b 01 00 80 	movb   $0x80,0x16ba2(%rip)        # 59000 <last_escape.1676>
        return 0;
   4245e:	b8 00 00 00 00       	mov    $0x0,%eax
   42463:	e9 a6 01 00 00       	jmpq   4260e <keyboard_readc+0x215>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   42468:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4246c:	84 c0                	test   %al,%al
   4246e:	79 5e                	jns    424ce <keyboard_readc+0xd5>
        int ch = keymap[(data & 0x7F) | escape];
   42470:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42474:	83 e0 7f             	and    $0x7f,%eax
   42477:	89 c2                	mov    %eax,%edx
   42479:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4247d:	09 d0                	or     %edx,%eax
   4247f:	48 98                	cltq   
   42481:	0f b6 80 60 4b 04 00 	movzbl 0x44b60(%rax),%eax
   42488:	0f b6 c0             	movzbl %al,%eax
   4248b:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   4248e:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42495:	7e 2d                	jle    424c4 <keyboard_readc+0xcb>
   42497:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   4249e:	7f 24                	jg     424c4 <keyboard_readc+0xcb>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   424a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424a3:	2d fa 00 00 00       	sub    $0xfa,%eax
   424a8:	ba 01 00 00 00       	mov    $0x1,%edx
   424ad:	89 c1                	mov    %eax,%ecx
   424af:	d3 e2                	shl    %cl,%edx
   424b1:	89 d0                	mov    %edx,%eax
   424b3:	f7 d0                	not    %eax
   424b5:	0f b6 15 45 6b 01 00 	movzbl 0x16b45(%rip),%edx        # 59001 <modifiers.1675>
   424bc:	21 d0                	and    %edx,%eax
   424be:	88 05 3d 6b 01 00    	mov    %al,0x16b3d(%rip)        # 59001 <modifiers.1675>
        }
        return 0;
   424c4:	b8 00 00 00 00       	mov    $0x0,%eax
   424c9:	e9 40 01 00 00       	jmpq   4260e <keyboard_readc+0x215>
    }

    int ch = (unsigned char) keymap[data | escape];
   424ce:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   424d2:	0a 45 fa             	or     -0x6(%rbp),%al
   424d5:	0f b6 c0             	movzbl %al,%eax
   424d8:	48 98                	cltq   
   424da:	0f b6 80 60 4b 04 00 	movzbl 0x44b60(%rax),%eax
   424e1:	0f b6 c0             	movzbl %al,%eax
   424e4:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   424e7:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   424eb:	7e 57                	jle    42544 <keyboard_readc+0x14b>
   424ed:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   424f1:	7f 51                	jg     42544 <keyboard_readc+0x14b>
        if (modifiers & MOD_CONTROL) {
   424f3:	0f b6 05 07 6b 01 00 	movzbl 0x16b07(%rip),%eax        # 59001 <modifiers.1675>
   424fa:	0f b6 c0             	movzbl %al,%eax
   424fd:	83 e0 02             	and    $0x2,%eax
   42500:	85 c0                	test   %eax,%eax
   42502:	74 09                	je     4250d <keyboard_readc+0x114>
            ch -= 0x60;
   42504:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42508:	e9 fd 00 00 00       	jmpq   4260a <keyboard_readc+0x211>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   4250d:	0f b6 05 ed 6a 01 00 	movzbl 0x16aed(%rip),%eax        # 59001 <modifiers.1675>
   42514:	0f b6 c0             	movzbl %al,%eax
   42517:	83 e0 01             	and    $0x1,%eax
   4251a:	85 c0                	test   %eax,%eax
   4251c:	0f 94 c2             	sete   %dl
   4251f:	0f b6 05 db 6a 01 00 	movzbl 0x16adb(%rip),%eax        # 59001 <modifiers.1675>
   42526:	0f b6 c0             	movzbl %al,%eax
   42529:	83 e0 08             	and    $0x8,%eax
   4252c:	85 c0                	test   %eax,%eax
   4252e:	0f 94 c0             	sete   %al
   42531:	31 d0                	xor    %edx,%eax
   42533:	84 c0                	test   %al,%al
   42535:	0f 84 cf 00 00 00    	je     4260a <keyboard_readc+0x211>
            ch -= 0x20;
   4253b:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4253f:	e9 c6 00 00 00       	jmpq   4260a <keyboard_readc+0x211>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42544:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4254b:	7e 30                	jle    4257d <keyboard_readc+0x184>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   4254d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42550:	2d fa 00 00 00       	sub    $0xfa,%eax
   42555:	ba 01 00 00 00       	mov    $0x1,%edx
   4255a:	89 c1                	mov    %eax,%ecx
   4255c:	d3 e2                	shl    %cl,%edx
   4255e:	89 d0                	mov    %edx,%eax
   42560:	89 c2                	mov    %eax,%edx
   42562:	0f b6 05 98 6a 01 00 	movzbl 0x16a98(%rip),%eax        # 59001 <modifiers.1675>
   42569:	31 d0                	xor    %edx,%eax
   4256b:	88 05 90 6a 01 00    	mov    %al,0x16a90(%rip)        # 59001 <modifiers.1675>
        ch = 0;
   42571:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42578:	e9 8e 00 00 00       	jmpq   4260b <keyboard_readc+0x212>
    } else if (ch >= KEY_SHIFT) {
   4257d:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42584:	7e 2d                	jle    425b3 <keyboard_readc+0x1ba>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42586:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42589:	2d fa 00 00 00       	sub    $0xfa,%eax
   4258e:	ba 01 00 00 00       	mov    $0x1,%edx
   42593:	89 c1                	mov    %eax,%ecx
   42595:	d3 e2                	shl    %cl,%edx
   42597:	89 d0                	mov    %edx,%eax
   42599:	89 c2                	mov    %eax,%edx
   4259b:	0f b6 05 5f 6a 01 00 	movzbl 0x16a5f(%rip),%eax        # 59001 <modifiers.1675>
   425a2:	09 d0                	or     %edx,%eax
   425a4:	88 05 57 6a 01 00    	mov    %al,0x16a57(%rip)        # 59001 <modifiers.1675>
        ch = 0;
   425aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   425b1:	eb 58                	jmp    4260b <keyboard_readc+0x212>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   425b3:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   425b7:	7e 31                	jle    425ea <keyboard_readc+0x1f1>
   425b9:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   425c0:	7f 28                	jg     425ea <keyboard_readc+0x1f1>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   425c2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   425c5:	8d 50 80             	lea    -0x80(%rax),%edx
   425c8:	0f b6 05 32 6a 01 00 	movzbl 0x16a32(%rip),%eax        # 59001 <modifiers.1675>
   425cf:	0f b6 c0             	movzbl %al,%eax
   425d2:	83 e0 03             	and    $0x3,%eax
   425d5:	48 98                	cltq   
   425d7:	48 63 d2             	movslq %edx,%rdx
   425da:	0f b6 84 90 60 4c 04 	movzbl 0x44c60(%rax,%rdx,4),%eax
   425e1:	00 
   425e2:	0f b6 c0             	movzbl %al,%eax
   425e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
   425e8:	eb 21                	jmp    4260b <keyboard_readc+0x212>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   425ea:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   425ee:	7f 1b                	jg     4260b <keyboard_readc+0x212>
   425f0:	0f b6 05 0a 6a 01 00 	movzbl 0x16a0a(%rip),%eax        # 59001 <modifiers.1675>
   425f7:	0f b6 c0             	movzbl %al,%eax
   425fa:	83 e0 02             	and    $0x2,%eax
   425fd:	85 c0                	test   %eax,%eax
   425ff:	74 0a                	je     4260b <keyboard_readc+0x212>
        ch = 0;
   42601:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42608:	eb 01                	jmp    4260b <keyboard_readc+0x212>
        if (modifiers & MOD_CONTROL) {
   4260a:	90                   	nop
    }

    return ch;
   4260b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   4260e:	c9                   	leaveq 
   4260f:	c3                   	retq   

0000000000042610 <delay>:


#define IO_SERIAL_PORT_DATA     0x3f8
#define IO_SERIAL_PORT_STATUS   0x3f9

static void delay(void) {
   42610:	55                   	push   %rbp
   42611:	48 89 e5             	mov    %rsp,%rbp
   42614:	48 83 ec 20          	sub    $0x20,%rsp
   42618:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4261f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42622:	89 c2                	mov    %eax,%edx
   42624:	ec                   	in     (%dx),%al
   42625:	88 45 e3             	mov    %al,-0x1d(%rbp)
   42628:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   4262f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42632:	89 c2                	mov    %eax,%edx
   42634:	ec                   	in     (%dx),%al
   42635:	88 45 eb             	mov    %al,-0x15(%rbp)
   42638:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   4263f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42642:	89 c2                	mov    %eax,%edx
   42644:	ec                   	in     (%dx),%al
   42645:	88 45 f3             	mov    %al,-0xd(%rbp)
   42648:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   4264f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42652:	89 c2                	mov    %eax,%edx
   42654:	ec                   	in     (%dx),%al
   42655:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   42658:	90                   	nop
   42659:	c9                   	leaveq 
   4265a:	c3                   	retq   

000000000004265b <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4265b:	55                   	push   %rbp
   4265c:	48 89 e5             	mov    %rsp,%rbp
   4265f:	48 83 ec 40          	sub    $0x40,%rsp
   42663:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42667:	89 f0                	mov    %esi,%eax
   42669:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4266c:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   4266f:	8b 05 8f 69 01 00    	mov    0x1698f(%rip),%eax        # 59004 <initialized.1689>
   42675:	85 c0                	test   %eax,%eax
   42677:	75 1e                	jne    42697 <parallel_port_putc+0x3c>
   42679:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42680:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42684:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   42688:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4268b:	ee                   	out    %al,(%dx)
}
   4268c:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   4268d:	c7 05 6d 69 01 00 01 	movl   $0x1,0x1696d(%rip)        # 59004 <initialized.1689>
   42694:	00 00 00 
    }

    for (int i = 0;
   42697:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4269e:	eb 09                	jmp    426a9 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   426a0:	e8 6b ff ff ff       	callq  42610 <delay>
         ++i) {
   426a5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    for (int i = 0;
   426a9:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   426b0:	7f 18                	jg     426ca <parallel_port_putc+0x6f>
   426b2:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   426b9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426bc:	89 c2                	mov    %eax,%edx
   426be:	ec                   	in     (%dx),%al
   426bf:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   426c2:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   426c6:	84 c0                	test   %al,%al
   426c8:	79 d6                	jns    426a0 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   426ca:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   426ce:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   426d5:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426d8:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   426dc:	8b 55 d8             	mov    -0x28(%rbp),%edx
   426df:	ee                   	out    %al,(%dx)
}
   426e0:	90                   	nop
   426e1:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   426e8:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   426ec:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   426f0:	8b 55 e0             	mov    -0x20(%rbp),%edx
   426f3:	ee                   	out    %al,(%dx)
}
   426f4:	90                   	nop
   426f5:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   426fc:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42700:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42704:	8b 55 e8             	mov    -0x18(%rbp),%edx
   42707:	ee                   	out    %al,(%dx)
}
   42708:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42709:	90                   	nop
   4270a:	c9                   	leaveq 
   4270b:	c3                   	retq   

000000000004270c <scan_port>:
#define INIT 0
#define CHAR 1
#define END  2

// Very flimsy serial input
int scan_port(char * c){
   4270c:	55                   	push   %rbp
   4270d:	48 89 e5             	mov    %rsp,%rbp
   42710:	48 83 ec 18          	sub    $0x18,%rsp
   42714:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   42718:	c7 45 fc f8 03 00 00 	movl   $0x3f8,-0x4(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4271f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42722:	89 c2                	mov    %eax,%edx
   42724:	ec                   	in     (%dx),%al
   42725:	88 45 fb             	mov    %al,-0x5(%rbp)
    return data;
   42728:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
    static int status = INIT;
    *c = inb(IO_SERIAL_PORT_DATA);
   4272c:	89 c2                	mov    %eax,%edx
   4272e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42732:	88 10                	mov    %dl,(%rax)
    if(status == INIT && *c){
   42734:	8b 05 ce 68 01 00    	mov    0x168ce(%rip),%eax        # 59008 <status.1697>
   4273a:	85 c0                	test   %eax,%eax
   4273c:	75 15                	jne    42753 <scan_port+0x47>
   4273e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42742:	0f b6 00             	movzbl (%rax),%eax
   42745:	84 c0                	test   %al,%al
   42747:	74 0a                	je     42753 <scan_port+0x47>
        status = CHAR;
   42749:	c7 05 b5 68 01 00 01 	movl   $0x1,0x168b5(%rip)        # 59008 <status.1697>
   42750:	00 00 00 
    }
    if(status == INIT)
   42753:	8b 05 af 68 01 00    	mov    0x168af(%rip),%eax        # 59008 <status.1697>
   42759:	85 c0                	test   %eax,%eax
   4275b:	75 07                	jne    42764 <scan_port+0x58>
        return 0;
   4275d:	b8 00 00 00 00       	mov    $0x0,%eax
   42762:	eb 33                	jmp    42797 <scan_port+0x8b>
    if(status == CHAR){
   42764:	8b 05 9e 68 01 00    	mov    0x1689e(%rip),%eax        # 59008 <status.1697>
   4276a:	83 f8 01             	cmp    $0x1,%eax
   4276d:	75 23                	jne    42792 <scan_port+0x86>
        if(*c == '\0'){
   4276f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42773:	0f b6 00             	movzbl (%rax),%eax
   42776:	84 c0                	test   %al,%al
   42778:	75 11                	jne    4278b <scan_port+0x7f>
            status = END;
   4277a:	c7 05 84 68 01 00 02 	movl   $0x2,0x16884(%rip)        # 59008 <status.1697>
   42781:	00 00 00 
            return -1;
   42784:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42789:	eb 0c                	jmp    42797 <scan_port+0x8b>
        }
        return 1;
   4278b:	b8 01 00 00 00       	mov    $0x1,%eax
   42790:	eb 05                	jmp    42797 <scan_port+0x8b>
    }
    return -1;
   42792:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   42797:	c9                   	leaveq 
   42798:	c3                   	retq   

0000000000042799 <log_vprintf>:


void log_vprintf(const char* format, va_list val) {
   42799:	55                   	push   %rbp
   4279a:	48 89 e5             	mov    %rsp,%rbp
   4279d:	48 83 ec 20          	sub    $0x20,%rsp
   427a1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   427a5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   427a9:	48 c7 45 f8 5b 26 04 	movq   $0x4265b,-0x8(%rbp)
   427b0:	00 
    printer_vprintf(&p, 0, format, val);
   427b1:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   427b5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   427b9:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   427bd:	be 00 00 00 00       	mov    $0x0,%esi
   427c2:	48 89 c7             	mov    %rax,%rdi
   427c5:	e8 a6 08 00 00       	callq  43070 <printer_vprintf>
}
   427ca:	90                   	nop
   427cb:	c9                   	leaveq 
   427cc:	c3                   	retq   

00000000000427cd <log_printf>:

void log_printf(const char* format, ...) {
   427cd:	55                   	push   %rbp
   427ce:	48 89 e5             	mov    %rsp,%rbp
   427d1:	48 83 ec 60          	sub    $0x60,%rsp
   427d5:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   427d9:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   427dd:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   427e1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   427e5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   427e9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   427ed:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   427f4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   427f8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   427fc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42800:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   42804:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   42808:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4280c:	48 89 d6             	mov    %rdx,%rsi
   4280f:	48 89 c7             	mov    %rax,%rdi
   42812:	e8 82 ff ff ff       	callq  42799 <log_vprintf>
    va_end(val);
}
   42817:	90                   	nop
   42818:	c9                   	leaveq 
   42819:	c3                   	retq   

000000000004281a <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   4281a:	55                   	push   %rbp
   4281b:	48 89 e5             	mov    %rsp,%rbp
   4281e:	48 83 ec 40          	sub    $0x40,%rsp
   42822:	89 7d dc             	mov    %edi,-0x24(%rbp)
   42825:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42828:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   4282c:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42830:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   42834:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42838:	48 8b 0a             	mov    (%rdx),%rcx
   4283b:	48 89 08             	mov    %rcx,(%rax)
   4283e:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42842:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42846:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   4284a:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   4284e:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42852:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42856:	48 89 d6             	mov    %rdx,%rsi
   42859:	48 89 c7             	mov    %rax,%rdi
   4285c:	e8 38 ff ff ff       	callq  42799 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42861:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42865:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42869:	8b 75 d8             	mov    -0x28(%rbp),%esi
   4286c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4286f:	89 c7                	mov    %eax,%edi
   42871:	e8 e3 0e 00 00       	callq  43759 <console_vprintf>
}
   42876:	c9                   	leaveq 
   42877:	c3                   	retq   

0000000000042878 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42878:	55                   	push   %rbp
   42879:	48 89 e5             	mov    %rsp,%rbp
   4287c:	48 83 ec 60          	sub    $0x60,%rsp
   42880:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42883:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42886:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   4288a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4288e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42892:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42896:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4289d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   428a1:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   428a5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   428a9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   428ad:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   428b1:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   428b5:	8b 75 a8             	mov    -0x58(%rbp),%esi
   428b8:	8b 45 ac             	mov    -0x54(%rbp),%eax
   428bb:	89 c7                	mov    %eax,%edi
   428bd:	e8 58 ff ff ff       	callq  4281a <error_vprintf>
   428c2:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   428c5:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   428c8:	c9                   	leaveq 
   428c9:	c3                   	retq   

00000000000428ca <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   428ca:	55                   	push   %rbp
   428cb:	48 89 e5             	mov    %rsp,%rbp
   428ce:	53                   	push   %rbx
   428cf:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   428d3:	e8 21 fb ff ff       	callq  423f9 <keyboard_readc>
   428d8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't') {
   428db:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   428df:	74 16                	je     428f7 <check_keyboard+0x2d>
   428e1:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   428e5:	74 10                	je     428f7 <check_keyboard+0x2d>
   428e7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   428eb:	74 0a                	je     428f7 <check_keyboard+0x2d>
   428ed:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   428f1:	0f 85 d9 00 00 00    	jne    429d0 <check_keyboard+0x106>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   428f7:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   428fe:	00 
        memset(pt, 0, PAGESIZE * 3);
   428ff:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42903:	ba 00 30 00 00       	mov    $0x3000,%edx
   42908:	be 00 00 00 00       	mov    $0x0,%esi
   4290d:	48 89 c7             	mov    %rax,%rdi
   42910:	e8 4b 06 00 00       	callq  42f60 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42915:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42919:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42920:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42924:	48 05 00 10 00 00    	add    $0x1000,%rax
   4292a:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42931:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42935:	48 05 00 20 00 00    	add    $0x2000,%rax
   4293b:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42942:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42946:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4294a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4294e:	0f 22 d8             	mov    %rax,%cr3
}
   42951:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42952:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42959:	48 c7 45 e8 b8 4c 04 	movq   $0x44cb8,-0x18(%rbp)
   42960:	00 
        if (c == 'a') {
   42961:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42965:	75 0a                	jne    42971 <check_keyboard+0xa7>
            argument = "allocator";
   42967:	48 c7 45 e8 bf 4c 04 	movq   $0x44cbf,-0x18(%rbp)
   4296e:	00 
   4296f:	eb 1e                	jmp    4298f <check_keyboard+0xc5>
        } else if (c == 'c') {
   42971:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42975:	75 0a                	jne    42981 <check_keyboard+0xb7>
            argument = "alloctests";
   42977:	48 c7 45 e8 c9 4c 04 	movq   $0x44cc9,-0x18(%rbp)
   4297e:	00 
   4297f:	eb 0e                	jmp    4298f <check_keyboard+0xc5>
        } else if(c == 't'){
   42981:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42985:	75 08                	jne    4298f <check_keyboard+0xc5>
            argument = "test";
   42987:	48 c7 45 e8 d4 4c 04 	movq   $0x44cd4,-0x18(%rbp)
   4298e:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4298f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42993:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42997:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4299c:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   429a0:	76 14                	jbe    429b6 <check_keyboard+0xec>
   429a2:	ba d9 4c 04 00       	mov    $0x44cd9,%edx
   429a7:	be 11 03 00 00       	mov    $0x311,%esi
   429ac:	bf 55 48 04 00       	mov    $0x44855,%edi
   429b1:	e8 20 01 00 00       	callq  42ad6 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   429b6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   429ba:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   429bd:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   429c1:	48 89 c3             	mov    %rax,%rbx
   429c4:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   429c9:	e9 32 d6 ff ff       	jmpq   40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't') {
   429ce:	eb 11                	jmp    429e1 <check_keyboard+0x117>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   429d0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   429d4:	74 06                	je     429dc <check_keyboard+0x112>
   429d6:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   429da:	75 05                	jne    429e1 <check_keyboard+0x117>
        poweroff();
   429dc:	e8 2e f8 ff ff       	callq  4220f <poweroff>
    }
    return c;
   429e1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   429e4:	48 83 c4 48          	add    $0x48,%rsp
   429e8:	5b                   	pop    %rbx
   429e9:	5d                   	pop    %rbp
   429ea:	c3                   	retq   

00000000000429eb <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   429eb:	55                   	push   %rbp
   429ec:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   429ef:	e8 d6 fe ff ff       	callq  428ca <check_keyboard>
   429f4:	eb f9                	jmp    429ef <fail+0x4>

00000000000429f6 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   429f6:	55                   	push   %rbp
   429f7:	48 89 e5             	mov    %rsp,%rbp
   429fa:	48 83 ec 60          	sub    $0x60,%rsp
   429fe:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42a02:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42a06:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42a0a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42a0e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42a12:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42a16:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42a1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42a21:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42a25:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42a29:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42a2d:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42a32:	0f 84 80 00 00 00    	je     42ab8 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42a38:	ba f5 4c 04 00       	mov    $0x44cf5,%edx
   42a3d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42a42:	bf 30 07 00 00       	mov    $0x730,%edi
   42a47:	b8 00 00 00 00       	mov    $0x0,%eax
   42a4c:	e8 27 fe ff ff       	callq  42878 <error_printf>
   42a51:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42a54:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42a58:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42a5c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42a5f:	be 00 c0 00 00       	mov    $0xc000,%esi
   42a64:	89 c7                	mov    %eax,%edi
   42a66:	e8 af fd ff ff       	callq  4281a <error_vprintf>
   42a6b:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42a6e:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42a71:	48 63 c1             	movslq %ecx,%rax
   42a74:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42a7b:	48 c1 e8 20          	shr    $0x20,%rax
   42a7f:	89 c2                	mov    %eax,%edx
   42a81:	c1 fa 05             	sar    $0x5,%edx
   42a84:	89 c8                	mov    %ecx,%eax
   42a86:	c1 f8 1f             	sar    $0x1f,%eax
   42a89:	29 c2                	sub    %eax,%edx
   42a8b:	89 d0                	mov    %edx,%eax
   42a8d:	c1 e0 02             	shl    $0x2,%eax
   42a90:	01 d0                	add    %edx,%eax
   42a92:	c1 e0 04             	shl    $0x4,%eax
   42a95:	29 c1                	sub    %eax,%ecx
   42a97:	89 ca                	mov    %ecx,%edx
   42a99:	85 d2                	test   %edx,%edx
   42a9b:	74 34                	je     42ad1 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42a9d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42aa0:	ba fd 4c 04 00       	mov    $0x44cfd,%edx
   42aa5:	be 00 c0 00 00       	mov    $0xc000,%esi
   42aaa:	89 c7                	mov    %eax,%edi
   42aac:	b8 00 00 00 00       	mov    $0x0,%eax
   42ab1:	e8 c2 fd ff ff       	callq  42878 <error_printf>
   42ab6:	eb 19                	jmp    42ad1 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42ab8:	ba ff 4c 04 00       	mov    $0x44cff,%edx
   42abd:	be 00 c0 00 00       	mov    $0xc000,%esi
   42ac2:	bf 30 07 00 00       	mov    $0x730,%edi
   42ac7:	b8 00 00 00 00       	mov    $0x0,%eax
   42acc:	e8 a7 fd ff ff       	callq  42878 <error_printf>
    }

    va_end(val);
    fail();
   42ad1:	e8 15 ff ff ff       	callq  429eb <fail>

0000000000042ad6 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42ad6:	55                   	push   %rbp
   42ad7:	48 89 e5             	mov    %rsp,%rbp
   42ada:	48 83 ec 20          	sub    $0x20,%rsp
   42ade:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42ae2:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42ae5:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42ae9:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42aed:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42af0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42af4:	48 89 c6             	mov    %rax,%rsi
   42af7:	bf 05 4d 04 00       	mov    $0x44d05,%edi
   42afc:	b8 00 00 00 00       	mov    $0x0,%eax
   42b01:	e8 f0 fe ff ff       	callq  429f6 <panic>

0000000000042b06 <default_exception>:
}

void default_exception(proc* p){
   42b06:	55                   	push   %rbp
   42b07:	48 89 e5             	mov    %rsp,%rbp
   42b0a:	48 83 ec 20          	sub    $0x20,%rsp
   42b0e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42b12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b16:	48 83 c0 18          	add    $0x18,%rax
   42b1a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42b1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b22:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42b29:	48 89 c6             	mov    %rax,%rsi
   42b2c:	bf 23 4d 04 00       	mov    $0x44d23,%edi
   42b31:	b8 00 00 00 00       	mov    $0x0,%eax
   42b36:	e8 bb fe ff ff       	callq  429f6 <panic>

0000000000042b3b <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42b3b:	55                   	push   %rbp
   42b3c:	48 89 e5             	mov    %rsp,%rbp
   42b3f:	48 83 ec 40          	sub    $0x40,%rsp
   42b43:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b47:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42b4a:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42b4e:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42b55:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42b59:	78 08                	js     42b63 <program_load+0x28>
   42b5b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b5e:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42b61:	7c 14                	jl     42b77 <program_load+0x3c>
   42b63:	ba 40 4d 04 00       	mov    $0x44d40,%edx
   42b68:	be 38 00 00 00       	mov    $0x38,%esi
   42b6d:	bf 70 4d 04 00       	mov    $0x44d70,%edi
   42b72:	e8 5f ff ff ff       	callq  42ad6 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42b77:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42b7a:	48 98                	cltq   
   42b7c:	48 c1 e0 04          	shl    $0x4,%rax
   42b80:	48 05 20 60 04 00    	add    $0x46020,%rax
   42b86:	48 8b 00             	mov    (%rax),%rax
   42b89:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42b8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42b91:	8b 00                	mov    (%rax),%eax
   42b93:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42b98:	74 14                	je     42bae <program_load+0x73>
   42b9a:	ba 7b 4d 04 00       	mov    $0x44d7b,%edx
   42b9f:	be 3a 00 00 00       	mov    $0x3a,%esi
   42ba4:	bf 70 4d 04 00       	mov    $0x44d70,%edi
   42ba9:	e8 28 ff ff ff       	callq  42ad6 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42bae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bb2:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42bb6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42bba:	48 01 d0             	add    %rdx,%rax
   42bbd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42bc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42bc8:	e9 94 00 00 00       	jmpq   42c61 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42bcd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bd0:	48 63 d0             	movslq %eax,%rdx
   42bd3:	48 89 d0             	mov    %rdx,%rax
   42bd6:	48 c1 e0 03          	shl    $0x3,%rax
   42bda:	48 29 d0             	sub    %rdx,%rax
   42bdd:	48 c1 e0 03          	shl    $0x3,%rax
   42be1:	48 89 c2             	mov    %rax,%rdx
   42be4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be8:	48 01 d0             	add    %rdx,%rax
   42beb:	8b 00                	mov    (%rax),%eax
   42bed:	83 f8 01             	cmp    $0x1,%eax
   42bf0:	75 6b                	jne    42c5d <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42bf2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42bf5:	48 63 d0             	movslq %eax,%rdx
   42bf8:	48 89 d0             	mov    %rdx,%rax
   42bfb:	48 c1 e0 03          	shl    $0x3,%rax
   42bff:	48 29 d0             	sub    %rdx,%rax
   42c02:	48 c1 e0 03          	shl    $0x3,%rax
   42c06:	48 89 c2             	mov    %rax,%rdx
   42c09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c0d:	48 01 d0             	add    %rdx,%rax
   42c10:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42c14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c18:	48 01 d0             	add    %rdx,%rax
   42c1b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42c1f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42c22:	48 63 d0             	movslq %eax,%rdx
   42c25:	48 89 d0             	mov    %rdx,%rax
   42c28:	48 c1 e0 03          	shl    $0x3,%rax
   42c2c:	48 29 d0             	sub    %rdx,%rax
   42c2f:	48 c1 e0 03          	shl    $0x3,%rax
   42c33:	48 89 c2             	mov    %rax,%rdx
   42c36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c3a:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42c3e:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42c42:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42c46:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c4a:	48 89 c7             	mov    %rax,%rdi
   42c4d:	e8 3d 00 00 00       	callq  42c8f <program_load_segment>
   42c52:	85 c0                	test   %eax,%eax
   42c54:	79 07                	jns    42c5d <program_load+0x122>
                return -1;
   42c56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42c5b:	eb 30                	jmp    42c8d <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42c5d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42c61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c65:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42c69:	0f b7 c0             	movzwl %ax,%eax
   42c6c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42c6f:	0f 8c 58 ff ff ff    	jl     42bcd <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c79:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42c7d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42c81:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42c88:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42c8d:	c9                   	leaveq 
   42c8e:	c3                   	retq   

0000000000042c8f <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42c8f:	55                   	push   %rbp
   42c90:	48 89 e5             	mov    %rsp,%rbp
   42c93:	48 83 ec 70          	sub    $0x70,%rsp
   42c97:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42c9b:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42c9f:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42ca3:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ca7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42cab:	48 8b 40 10          	mov    0x10(%rax),%rax
   42caf:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42cb3:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42cb7:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42cbb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cbf:	48 01 d0             	add    %rdx,%rax
   42cc2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42cc6:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42cca:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42cce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42cd2:	48 01 d0             	add    %rdx,%rax
   42cd5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42cd9:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42ce0:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ce1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ce5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ce9:	e9 83 00 00 00       	jmpq   42d71 <program_load_segment+0xe2>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42cee:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42cf2:	8b 00                	mov    (%rax),%eax
   42cf4:	89 c7                	mov    %eax,%edi
   42cf6:	e8 7d 0b 00 00       	callq  43878 <palloc>
   42cfb:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42cff:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   42d04:	74 31                	je     42d37 <program_load_segment+0xa8>
   42d06:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42d0a:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42d11:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42d15:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d19:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42d1d:	49 89 c9             	mov    %rcx,%r9
   42d20:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42d26:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42d2b:	48 89 c7             	mov    %rax,%rdi
   42d2e:	e8 81 ed ff ff       	callq  41ab4 <virtual_memory_map>
   42d33:	85 c0                	test   %eax,%eax
   42d35:	79 32                	jns    42d69 <program_load_segment+0xda>
                                            PTE_W | PTE_P | PTE_U, allocator) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42d37:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42d3b:	8b 00                	mov    (%rax),%eax
   42d3d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d41:	49 89 d0             	mov    %rdx,%r8
   42d44:	89 c1                	mov    %eax,%ecx
   42d46:	ba 98 4d 04 00       	mov    $0x44d98,%edx
   42d4b:	be 00 c0 00 00       	mov    $0xc000,%esi
   42d50:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42d55:	b8 00 00 00 00       	mov    $0x0,%eax
   42d5a:	e8 3f 0a 00 00       	callq  4379e <console_printf>
                "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42d5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42d64:	e9 ec 00 00 00       	jmpq   42e55 <program_load_segment+0x1c6>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42d69:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42d70:	00 
   42d71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42d75:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42d79:	0f 82 6f ff ff ff    	jb     42cee <program_load_segment+0x5f>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42d7f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42d83:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42d8a:	48 89 c7             	mov    %rax,%rdi
   42d8d:	e8 10 f2 ff ff       	callq  41fa2 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42d92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42d96:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42d9a:	48 89 c2             	mov    %rax,%rdx
   42d9d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42da1:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42da5:	48 89 ce             	mov    %rcx,%rsi
   42da8:	48 89 c7             	mov    %rax,%rdi
   42dab:	e8 47 01 00 00       	callq  42ef7 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42db0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42db4:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42db8:	48 89 c2             	mov    %rax,%rdx
   42dbb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42dbf:	be 00 00 00 00       	mov    $0x0,%esi
   42dc4:	48 89 c7             	mov    %rax,%rdi
   42dc7:	e8 94 01 00 00       	callq  42f60 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42dcc:	48 8b 05 6d 75 01 00 	mov    0x1756d(%rip),%rax        # 5a340 <kernel_pagetable>
   42dd3:	48 89 c7             	mov    %rax,%rdi
   42dd6:	e8 c7 f1 ff ff       	callq  41fa2 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42ddb:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ddf:	8b 40 04             	mov    0x4(%rax),%eax
   42de2:	83 e0 02             	and    $0x2,%eax
   42de5:	85 c0                	test   %eax,%eax
   42de7:	75 67                	jne    42e50 <program_load_segment+0x1c1>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42de9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ded:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42df1:	eb 53                	jmp    42e46 <program_load_segment+0x1b7>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42df3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42df7:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42dfe:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   42e02:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42e06:	48 89 ce             	mov    %rcx,%rsi
   42e09:	48 89 c7             	mov    %rax,%rdi
   42e0c:	e8 9a f0 ff ff       	callq  41eab <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   42e11:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42e15:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42e19:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42e20:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42e24:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   42e28:	49 89 c9             	mov    %rcx,%r9
   42e2b:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   42e31:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42e36:	48 89 c7             	mov    %rax,%rdi
   42e39:	e8 76 ec ff ff       	callq  41ab4 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42e3e:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   42e45:	00 
   42e46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e4a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42e4e:	72 a3                	jb     42df3 <program_load_segment+0x164>
                                        PTE_P | PTE_U, allocator);
        }
    }

    return 0;
   42e50:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e55:	c9                   	leaveq 
   42e56:	c3                   	retq   

0000000000042e57 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   42e57:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42e5a:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
   42e61:	00 
   42e62:	72 08                	jb     42e6c <console_putc+0x15>
        cp->cursor = console;
   42e64:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
   42e6b:	00 
    }
    if (c == '\n') {
   42e6c:	40 80 fe 0a          	cmp    $0xa,%sil
   42e70:	74 17                	je     42e89 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   42e72:	48 8b 47 08          	mov    0x8(%rdi),%rax
   42e76:	48 8d 50 02          	lea    0x2(%rax),%rdx
   42e7a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   42e7e:	40 0f b6 f6          	movzbl %sil,%esi
   42e82:	44 09 c6             	or     %r8d,%esi
   42e85:	66 89 30             	mov    %si,(%rax)
    }
}
   42e88:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
   42e89:	48 8b 77 08          	mov    0x8(%rdi),%rsi
   42e8d:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
   42e94:	48 89 f1             	mov    %rsi,%rcx
   42e97:	48 d1 f9             	sar    %rcx
   42e9a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   42ea1:	66 66 66 
   42ea4:	48 89 c8             	mov    %rcx,%rax
   42ea7:	48 f7 ea             	imul   %rdx
   42eaa:	48 c1 fa 05          	sar    $0x5,%rdx
   42eae:	48 c1 fe 3f          	sar    $0x3f,%rsi
   42eb2:	48 29 f2             	sub    %rsi,%rdx
   42eb5:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   42eb9:	48 c1 e0 04          	shl    $0x4,%rax
   42ebd:	89 ca                	mov    %ecx,%edx
   42ebf:	29 c2                	sub    %eax,%edx
   42ec1:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
   42ec3:	44 89 c6             	mov    %r8d,%esi
   42ec6:	83 ce 20             	or     $0x20,%esi
   42ec9:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
   42ecd:	4c 8d 41 02          	lea    0x2(%rcx),%r8
   42ed1:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   42ed5:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
   42ed8:	83 c0 01             	add    $0x1,%eax
   42edb:	83 f8 50             	cmp    $0x50,%eax
   42ede:	75 e9                	jne    42ec9 <console_putc+0x72>
   42ee0:	c3                   	retq   

0000000000042ee1 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   42ee1:	48 8b 47 08          	mov    0x8(%rdi),%rax
   42ee5:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   42ee9:	73 0b                	jae    42ef6 <string_putc+0x15>
        *sp->s++ = c;
   42eeb:	48 8d 50 01          	lea    0x1(%rax),%rdx
   42eef:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   42ef3:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   42ef6:	c3                   	retq   

0000000000042ef7 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   42ef7:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42efa:	48 85 d2             	test   %rdx,%rdx
   42efd:	74 17                	je     42f16 <memcpy+0x1f>
   42eff:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   42f04:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   42f09:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42f0d:	48 83 c1 01          	add    $0x1,%rcx
   42f11:	48 39 d1             	cmp    %rdx,%rcx
   42f14:	75 ee                	jne    42f04 <memcpy+0xd>
}
   42f16:	c3                   	retq   

0000000000042f17 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   42f17:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   42f1a:	48 39 fe             	cmp    %rdi,%rsi
   42f1d:	72 1d                	jb     42f3c <memmove+0x25>
        while (n-- > 0) {
   42f1f:	b9 00 00 00 00       	mov    $0x0,%ecx
   42f24:	48 85 d2             	test   %rdx,%rdx
   42f27:	74 12                	je     42f3b <memmove+0x24>
            *d++ = *s++;
   42f29:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   42f2d:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   42f31:	48 83 c1 01          	add    $0x1,%rcx
   42f35:	48 39 ca             	cmp    %rcx,%rdx
   42f38:	75 ef                	jne    42f29 <memmove+0x12>
}
   42f3a:	c3                   	retq   
   42f3b:	c3                   	retq   
    if (s < d && s + n > d) {
   42f3c:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   42f40:	48 39 cf             	cmp    %rcx,%rdi
   42f43:	73 da                	jae    42f1f <memmove+0x8>
        while (n-- > 0) {
   42f45:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   42f49:	48 85 d2             	test   %rdx,%rdx
   42f4c:	74 ec                	je     42f3a <memmove+0x23>
            *--d = *--s;
   42f4e:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   42f52:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   42f55:	48 83 e9 01          	sub    $0x1,%rcx
   42f59:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   42f5d:	75 ef                	jne    42f4e <memmove+0x37>
   42f5f:	c3                   	retq   

0000000000042f60 <memset>:
void* memset(void* v, int c, size_t n) {
   42f60:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42f63:	48 85 d2             	test   %rdx,%rdx
   42f66:	74 13                	je     42f7b <memset+0x1b>
   42f68:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
   42f6c:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
   42f6f:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42f72:	48 83 c2 01          	add    $0x1,%rdx
   42f76:	48 39 d1             	cmp    %rdx,%rcx
   42f79:	75 f4                	jne    42f6f <memset+0xf>
}
   42f7b:	c3                   	retq   

0000000000042f7c <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   42f7c:	80 3f 00             	cmpb   $0x0,(%rdi)
   42f7f:	74 10                	je     42f91 <strlen+0x15>
   42f81:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   42f86:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   42f8a:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   42f8e:	75 f6                	jne    42f86 <strlen+0xa>
   42f90:	c3                   	retq   
   42f91:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42f96:	c3                   	retq   

0000000000042f97 <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42f97:	b8 00 00 00 00       	mov    $0x0,%eax
   42f9c:	48 85 f6             	test   %rsi,%rsi
   42f9f:	74 10                	je     42fb1 <strnlen+0x1a>
   42fa1:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   42fa5:	74 09                	je     42fb0 <strnlen+0x19>
        ++n;
   42fa7:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42fab:	48 39 c6             	cmp    %rax,%rsi
   42fae:	75 f1                	jne    42fa1 <strnlen+0xa>
}
   42fb0:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42fb1:	48 89 f0             	mov    %rsi,%rax
   42fb4:	c3                   	retq   

0000000000042fb5 <strcpy>:
char* strcpy(char* dst, const char* src) {
   42fb5:	48 89 f8             	mov    %rdi,%rax
   42fb8:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   42fbd:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   42fc1:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   42fc4:	48 83 c2 01          	add    $0x1,%rdx
   42fc8:	84 c9                	test   %cl,%cl
   42fca:	75 f1                	jne    42fbd <strcpy+0x8>
}
   42fcc:	c3                   	retq   

0000000000042fcd <strcmp>:
    while (*a && *b && *a == *b) {
   42fcd:	0f b6 17             	movzbl (%rdi),%edx
   42fd0:	84 d2                	test   %dl,%dl
   42fd2:	74 1a                	je     42fee <strcmp+0x21>
   42fd4:	0f b6 06             	movzbl (%rsi),%eax
   42fd7:	38 d0                	cmp    %dl,%al
   42fd9:	75 13                	jne    42fee <strcmp+0x21>
   42fdb:	84 c0                	test   %al,%al
   42fdd:	74 0f                	je     42fee <strcmp+0x21>
        ++a, ++b;
   42fdf:	48 83 c7 01          	add    $0x1,%rdi
   42fe3:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   42fe7:	0f b6 17             	movzbl (%rdi),%edx
   42fea:	84 d2                	test   %dl,%dl
   42fec:	75 e6                	jne    42fd4 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   42fee:	0f b6 0e             	movzbl (%rsi),%ecx
   42ff1:	38 ca                	cmp    %cl,%dl
   42ff3:	0f 97 c0             	seta   %al
   42ff6:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   42ff9:	83 d8 00             	sbb    $0x0,%eax
}
   42ffc:	c3                   	retq   

0000000000042ffd <strchr>:
    while (*s && *s != (char) c) {
   42ffd:	0f b6 07             	movzbl (%rdi),%eax
   43000:	84 c0                	test   %al,%al
   43002:	74 10                	je     43014 <strchr+0x17>
   43004:	40 38 f0             	cmp    %sil,%al
   43007:	74 18                	je     43021 <strchr+0x24>
        ++s;
   43009:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   4300d:	0f b6 07             	movzbl (%rdi),%eax
   43010:	84 c0                	test   %al,%al
   43012:	75 f0                	jne    43004 <strchr+0x7>
        return NULL;
   43014:	40 84 f6             	test   %sil,%sil
   43017:	b8 00 00 00 00       	mov    $0x0,%eax
   4301c:	48 0f 44 c7          	cmove  %rdi,%rax
}
   43020:	c3                   	retq   
   43021:	48 89 f8             	mov    %rdi,%rax
   43024:	c3                   	retq   

0000000000043025 <rand>:
    if (!rand_seed_set) {
   43025:	83 3d e4 5f 01 00 00 	cmpl   $0x0,0x15fe4(%rip)        # 59010 <rand_seed_set>
   4302c:	74 1b                	je     43049 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   4302e:	69 05 d4 5f 01 00 0d 	imul   $0x19660d,0x15fd4(%rip),%eax        # 5900c <rand_seed>
   43035:	66 19 00 
   43038:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   4303d:	89 05 c9 5f 01 00    	mov    %eax,0x15fc9(%rip)        # 5900c <rand_seed>
    return rand_seed & RAND_MAX;
   43043:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43048:	c3                   	retq   
    rand_seed = seed;
   43049:	c7 05 b9 5f 01 00 9e 	movl   $0x30d4879e,0x15fb9(%rip)        # 5900c <rand_seed>
   43050:	87 d4 30 
    rand_seed_set = 1;
   43053:	c7 05 b3 5f 01 00 01 	movl   $0x1,0x15fb3(%rip)        # 59010 <rand_seed_set>
   4305a:	00 00 00 
}
   4305d:	eb cf                	jmp    4302e <rand+0x9>

000000000004305f <srand>:
    rand_seed = seed;
   4305f:	89 3d a7 5f 01 00    	mov    %edi,0x15fa7(%rip)        # 5900c <rand_seed>
    rand_seed_set = 1;
   43065:	c7 05 a1 5f 01 00 01 	movl   $0x1,0x15fa1(%rip)        # 59010 <rand_seed_set>
   4306c:	00 00 00 
}
   4306f:	c3                   	retq   

0000000000043070 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43070:	55                   	push   %rbp
   43071:	48 89 e5             	mov    %rsp,%rbp
   43074:	41 57                	push   %r15
   43076:	41 56                	push   %r14
   43078:	41 55                	push   %r13
   4307a:	41 54                	push   %r12
   4307c:	53                   	push   %rbx
   4307d:	48 83 ec 58          	sub    $0x58,%rsp
   43081:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   43085:	0f b6 02             	movzbl (%rdx),%eax
   43088:	84 c0                	test   %al,%al
   4308a:	0f 84 ba 06 00 00    	je     4374a <printer_vprintf+0x6da>
   43090:	49 89 fe             	mov    %rdi,%r14
   43093:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   43096:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
   4309d:	41 89 f7             	mov    %esi,%r15d
   430a0:	e9 a5 04 00 00       	jmpq   4354a <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
   430a5:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   430aa:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   430b0:	45 84 e4             	test   %r12b,%r12b
   430b3:	0f 84 85 06 00 00    	je     4373e <printer_vprintf+0x6ce>
        int flags = 0;
   430b9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   430bf:	41 0f be f4          	movsbl %r12b,%esi
   430c3:	bf d1 4f 04 00       	mov    $0x44fd1,%edi
   430c8:	e8 30 ff ff ff       	callq  42ffd <strchr>
   430cd:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   430d0:	48 85 c0             	test   %rax,%rax
   430d3:	74 55                	je     4312a <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
   430d5:	48 81 e9 d1 4f 04 00 	sub    $0x44fd1,%rcx
   430dc:	b8 01 00 00 00       	mov    $0x1,%eax
   430e1:	d3 e0                	shl    %cl,%eax
   430e3:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   430e6:	48 83 c3 01          	add    $0x1,%rbx
   430ea:	44 0f b6 23          	movzbl (%rbx),%r12d
   430ee:	45 84 e4             	test   %r12b,%r12b
   430f1:	75 cc                	jne    430bf <printer_vprintf+0x4f>
   430f3:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   430f7:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   430fd:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   43104:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   43107:	0f 84 a9 00 00 00    	je     431b6 <printer_vprintf+0x146>
        int length = 0;
   4310d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   43112:	0f b6 13             	movzbl (%rbx),%edx
   43115:	8d 42 bd             	lea    -0x43(%rdx),%eax
   43118:	3c 37                	cmp    $0x37,%al
   4311a:	0f 87 c5 04 00 00    	ja     435e5 <printer_vprintf+0x575>
   43120:	0f b6 c0             	movzbl %al,%eax
   43123:	ff 24 c5 e0 4d 04 00 	jmpq   *0x44de0(,%rax,8)
   4312a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
   4312e:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   43133:	3c 08                	cmp    $0x8,%al
   43135:	77 2f                	ja     43166 <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43137:	0f b6 03             	movzbl (%rbx),%eax
   4313a:	8d 50 d0             	lea    -0x30(%rax),%edx
   4313d:	80 fa 09             	cmp    $0x9,%dl
   43140:	77 5e                	ja     431a0 <printer_vprintf+0x130>
   43142:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   43148:	48 83 c3 01          	add    $0x1,%rbx
   4314c:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   43151:	0f be c0             	movsbl %al,%eax
   43154:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43159:	0f b6 03             	movzbl (%rbx),%eax
   4315c:	8d 50 d0             	lea    -0x30(%rax),%edx
   4315f:	80 fa 09             	cmp    $0x9,%dl
   43162:	76 e4                	jbe    43148 <printer_vprintf+0xd8>
   43164:	eb 97                	jmp    430fd <printer_vprintf+0x8d>
        } else if (*format == '*') {
   43166:	41 80 fc 2a          	cmp    $0x2a,%r12b
   4316a:	75 3f                	jne    431ab <printer_vprintf+0x13b>
            width = va_arg(val, int);
   4316c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43170:	8b 01                	mov    (%rcx),%eax
   43172:	83 f8 2f             	cmp    $0x2f,%eax
   43175:	77 17                	ja     4318e <printer_vprintf+0x11e>
   43177:	89 c2                	mov    %eax,%edx
   43179:	48 03 51 10          	add    0x10(%rcx),%rdx
   4317d:	83 c0 08             	add    $0x8,%eax
   43180:	89 01                	mov    %eax,(%rcx)
   43182:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   43185:	48 83 c3 01          	add    $0x1,%rbx
   43189:	e9 6f ff ff ff       	jmpq   430fd <printer_vprintf+0x8d>
            width = va_arg(val, int);
   4318e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43192:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43196:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4319a:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4319e:	eb e2                	jmp    43182 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   431a0:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   431a6:	e9 52 ff ff ff       	jmpq   430fd <printer_vprintf+0x8d>
        int width = -1;
   431ab:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   431b1:	e9 47 ff ff ff       	jmpq   430fd <printer_vprintf+0x8d>
            ++format;
   431b6:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   431ba:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   431be:	8d 48 d0             	lea    -0x30(%rax),%ecx
   431c1:	80 f9 09             	cmp    $0x9,%cl
   431c4:	76 13                	jbe    431d9 <printer_vprintf+0x169>
            } else if (*format == '*') {
   431c6:	3c 2a                	cmp    $0x2a,%al
   431c8:	74 32                	je     431fc <printer_vprintf+0x18c>
            ++format;
   431ca:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   431cd:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   431d4:	e9 34 ff ff ff       	jmpq   4310d <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   431d9:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
   431de:	48 83 c2 01          	add    $0x1,%rdx
   431e2:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
   431e5:	0f be c0             	movsbl %al,%eax
   431e8:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   431ec:	0f b6 02             	movzbl (%rdx),%eax
   431ef:	8d 48 d0             	lea    -0x30(%rax),%ecx
   431f2:	80 f9 09             	cmp    $0x9,%cl
   431f5:	76 e7                	jbe    431de <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
   431f7:	48 89 d3             	mov    %rdx,%rbx
   431fa:	eb 1c                	jmp    43218 <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
   431fc:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43200:	8b 07                	mov    (%rdi),%eax
   43202:	83 f8 2f             	cmp    $0x2f,%eax
   43205:	77 23                	ja     4322a <printer_vprintf+0x1ba>
   43207:	89 c2                	mov    %eax,%edx
   43209:	48 03 57 10          	add    0x10(%rdi),%rdx
   4320d:	83 c0 08             	add    $0x8,%eax
   43210:	89 07                	mov    %eax,(%rdi)
   43212:	8b 32                	mov    (%rdx),%esi
                ++format;
   43214:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   43218:	85 f6                	test   %esi,%esi
   4321a:	b8 00 00 00 00       	mov    $0x0,%eax
   4321f:	0f 48 f0             	cmovs  %eax,%esi
   43222:	89 75 9c             	mov    %esi,-0x64(%rbp)
   43225:	e9 e3 fe ff ff       	jmpq   4310d <printer_vprintf+0x9d>
                precision = va_arg(val, int);
   4322a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4322e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43232:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43236:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4323a:	eb d6                	jmp    43212 <printer_vprintf+0x1a2>
        switch (*format) {
   4323c:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43241:	e9 f1 00 00 00       	jmpq   43337 <printer_vprintf+0x2c7>
            ++format;
   43246:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   4324a:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
   4324d:	e9 c0 fe ff ff       	jmpq   43112 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43252:	85 c9                	test   %ecx,%ecx
   43254:	74 55                	je     432ab <printer_vprintf+0x23b>
   43256:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4325a:	8b 01                	mov    (%rcx),%eax
   4325c:	83 f8 2f             	cmp    $0x2f,%eax
   4325f:	77 38                	ja     43299 <printer_vprintf+0x229>
   43261:	89 c2                	mov    %eax,%edx
   43263:	48 03 51 10          	add    0x10(%rcx),%rdx
   43267:	83 c0 08             	add    $0x8,%eax
   4326a:	89 01                	mov    %eax,(%rcx)
   4326c:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4326f:	48 89 d0             	mov    %rdx,%rax
   43272:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   43276:	49 89 d0             	mov    %rdx,%r8
   43279:	49 f7 d8             	neg    %r8
   4327c:	25 80 00 00 00       	and    $0x80,%eax
   43281:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43285:	0b 45 a8             	or     -0x58(%rbp),%eax
   43288:	83 c8 60             	or     $0x60,%eax
   4328b:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   4328e:	41 bc d3 4d 04 00    	mov    $0x44dd3,%r12d
            break;
   43294:	e9 35 01 00 00       	jmpq   433ce <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43299:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4329d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   432a1:	48 8d 42 08          	lea    0x8(%rdx),%rax
   432a5:	48 89 47 08          	mov    %rax,0x8(%rdi)
   432a9:	eb c1                	jmp    4326c <printer_vprintf+0x1fc>
   432ab:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   432af:	8b 07                	mov    (%rdi),%eax
   432b1:	83 f8 2f             	cmp    $0x2f,%eax
   432b4:	77 10                	ja     432c6 <printer_vprintf+0x256>
   432b6:	89 c2                	mov    %eax,%edx
   432b8:	48 03 57 10          	add    0x10(%rdi),%rdx
   432bc:	83 c0 08             	add    $0x8,%eax
   432bf:	89 07                	mov    %eax,(%rdi)
   432c1:	48 63 12             	movslq (%rdx),%rdx
   432c4:	eb a9                	jmp    4326f <printer_vprintf+0x1ff>
   432c6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   432ca:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   432ce:	48 8d 42 08          	lea    0x8(%rdx),%rax
   432d2:	48 89 41 08          	mov    %rax,0x8(%rcx)
   432d6:	eb e9                	jmp    432c1 <printer_vprintf+0x251>
        int base = 10;
   432d8:	be 0a 00 00 00       	mov    $0xa,%esi
   432dd:	eb 58                	jmp    43337 <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   432df:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   432e3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   432e7:	48 8d 42 08          	lea    0x8(%rdx),%rax
   432eb:	48 89 41 08          	mov    %rax,0x8(%rcx)
   432ef:	eb 60                	jmp    43351 <printer_vprintf+0x2e1>
   432f1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   432f5:	8b 01                	mov    (%rcx),%eax
   432f7:	83 f8 2f             	cmp    $0x2f,%eax
   432fa:	77 10                	ja     4330c <printer_vprintf+0x29c>
   432fc:	89 c2                	mov    %eax,%edx
   432fe:	48 03 51 10          	add    0x10(%rcx),%rdx
   43302:	83 c0 08             	add    $0x8,%eax
   43305:	89 01                	mov    %eax,(%rcx)
   43307:	44 8b 02             	mov    (%rdx),%r8d
   4330a:	eb 48                	jmp    43354 <printer_vprintf+0x2e4>
   4330c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43310:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43314:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43318:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4331c:	eb e9                	jmp    43307 <printer_vprintf+0x297>
   4331e:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43321:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   43328:	bf c0 4f 04 00       	mov    $0x44fc0,%edi
   4332d:	e9 e6 02 00 00       	jmpq   43618 <printer_vprintf+0x5a8>
            base = 16;
   43332:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43337:	85 c9                	test   %ecx,%ecx
   43339:	74 b6                	je     432f1 <printer_vprintf+0x281>
   4333b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4333f:	8b 07                	mov    (%rdi),%eax
   43341:	83 f8 2f             	cmp    $0x2f,%eax
   43344:	77 99                	ja     432df <printer_vprintf+0x26f>
   43346:	89 c2                	mov    %eax,%edx
   43348:	48 03 57 10          	add    0x10(%rdi),%rdx
   4334c:	83 c0 08             	add    $0x8,%eax
   4334f:	89 07                	mov    %eax,(%rdi)
   43351:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43354:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43358:	85 f6                	test   %esi,%esi
   4335a:	79 c2                	jns    4331e <printer_vprintf+0x2ae>
        base = -base;
   4335c:	41 89 f1             	mov    %esi,%r9d
   4335f:	f7 de                	neg    %esi
   43361:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43368:	bf a0 4f 04 00       	mov    $0x44fa0,%edi
   4336d:	e9 a6 02 00 00       	jmpq   43618 <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
   43372:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43376:	8b 07                	mov    (%rdi),%eax
   43378:	83 f8 2f             	cmp    $0x2f,%eax
   4337b:	77 1c                	ja     43399 <printer_vprintf+0x329>
   4337d:	89 c2                	mov    %eax,%edx
   4337f:	48 03 57 10          	add    0x10(%rdi),%rdx
   43383:	83 c0 08             	add    $0x8,%eax
   43386:	89 07                	mov    %eax,(%rdi)
   43388:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4338b:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   43392:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43397:	eb c3                	jmp    4335c <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
   43399:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4339d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   433a1:	48 8d 42 08          	lea    0x8(%rdx),%rax
   433a5:	48 89 41 08          	mov    %rax,0x8(%rcx)
   433a9:	eb dd                	jmp    43388 <printer_vprintf+0x318>
            data = va_arg(val, char*);
   433ab:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   433af:	8b 01                	mov    (%rcx),%eax
   433b1:	83 f8 2f             	cmp    $0x2f,%eax
   433b4:	0f 87 a9 01 00 00    	ja     43563 <printer_vprintf+0x4f3>
   433ba:	89 c2                	mov    %eax,%edx
   433bc:	48 03 51 10          	add    0x10(%rcx),%rdx
   433c0:	83 c0 08             	add    $0x8,%eax
   433c3:	89 01                	mov    %eax,(%rcx)
   433c5:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   433c8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   433ce:	8b 45 a8             	mov    -0x58(%rbp),%eax
   433d1:	83 e0 20             	and    $0x20,%eax
   433d4:	89 45 8c             	mov    %eax,-0x74(%rbp)
   433d7:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   433dd:	0f 85 25 02 00 00    	jne    43608 <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   433e3:	8b 45 a8             	mov    -0x58(%rbp),%eax
   433e6:	89 45 88             	mov    %eax,-0x78(%rbp)
   433e9:	83 e0 60             	and    $0x60,%eax
   433ec:	83 f8 60             	cmp    $0x60,%eax
   433ef:	0f 84 58 02 00 00    	je     4364d <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   433f5:	8b 45 a8             	mov    -0x58(%rbp),%eax
   433f8:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   433fb:	48 c7 45 a0 d3 4d 04 	movq   $0x44dd3,-0x60(%rbp)
   43402:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43403:	83 f8 21             	cmp    $0x21,%eax
   43406:	0f 84 7d 02 00 00    	je     43689 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   4340c:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   4340f:	89 c8                	mov    %ecx,%eax
   43411:	f7 d0                	not    %eax
   43413:	c1 e8 1f             	shr    $0x1f,%eax
   43416:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43419:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   4341d:	0f 85 a2 02 00 00    	jne    436c5 <printer_vprintf+0x655>
   43423:	84 c0                	test   %al,%al
   43425:	0f 84 9a 02 00 00    	je     436c5 <printer_vprintf+0x655>
            len = strnlen(data, precision);
   4342b:	48 63 f1             	movslq %ecx,%rsi
   4342e:	4c 89 e7             	mov    %r12,%rdi
   43431:	e8 61 fb ff ff       	callq  42f97 <strnlen>
   43436:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43439:	8b 45 88             	mov    -0x78(%rbp),%eax
   4343c:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   4343f:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43446:	83 f8 22             	cmp    $0x22,%eax
   43449:	0f 84 ae 02 00 00    	je     436fd <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
   4344f:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43453:	e8 24 fb ff ff       	callq  42f7c <strlen>
   43458:	8b 55 9c             	mov    -0x64(%rbp),%edx
   4345b:	03 55 98             	add    -0x68(%rbp),%edx
   4345e:	41 29 d5             	sub    %edx,%r13d
   43461:	44 89 ea             	mov    %r13d,%edx
   43464:	29 c2                	sub    %eax,%edx
   43466:	89 55 8c             	mov    %edx,-0x74(%rbp)
   43469:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4346c:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   43470:	75 2d                	jne    4349f <printer_vprintf+0x42f>
   43472:	85 d2                	test   %edx,%edx
   43474:	7e 29                	jle    4349f <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
   43476:	44 89 fa             	mov    %r15d,%edx
   43479:	be 20 00 00 00       	mov    $0x20,%esi
   4347e:	4c 89 f7             	mov    %r14,%rdi
   43481:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43484:	41 83 ed 01          	sub    $0x1,%r13d
   43488:	45 85 ed             	test   %r13d,%r13d
   4348b:	7f e9                	jg     43476 <printer_vprintf+0x406>
   4348d:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   43490:	85 ff                	test   %edi,%edi
   43492:	b8 01 00 00 00       	mov    $0x1,%eax
   43497:	0f 4f c7             	cmovg  %edi,%eax
   4349a:	29 c7                	sub    %eax,%edi
   4349c:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   4349f:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   434a3:	0f b6 01             	movzbl (%rcx),%eax
   434a6:	84 c0                	test   %al,%al
   434a8:	74 22                	je     434cc <printer_vprintf+0x45c>
   434aa:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   434ae:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
   434b1:	0f b6 f0             	movzbl %al,%esi
   434b4:	44 89 fa             	mov    %r15d,%edx
   434b7:	4c 89 f7             	mov    %r14,%rdi
   434ba:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
   434bd:	48 83 c3 01          	add    $0x1,%rbx
   434c1:	0f b6 03             	movzbl (%rbx),%eax
   434c4:	84 c0                	test   %al,%al
   434c6:	75 e9                	jne    434b1 <printer_vprintf+0x441>
   434c8:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   434cc:	8b 45 9c             	mov    -0x64(%rbp),%eax
   434cf:	85 c0                	test   %eax,%eax
   434d1:	7e 1d                	jle    434f0 <printer_vprintf+0x480>
   434d3:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   434d7:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   434d9:	44 89 fa             	mov    %r15d,%edx
   434dc:	be 30 00 00 00       	mov    $0x30,%esi
   434e1:	4c 89 f7             	mov    %r14,%rdi
   434e4:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
   434e7:	83 eb 01             	sub    $0x1,%ebx
   434ea:	75 ed                	jne    434d9 <printer_vprintf+0x469>
   434ec:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   434f0:	8b 45 98             	mov    -0x68(%rbp),%eax
   434f3:	85 c0                	test   %eax,%eax
   434f5:	7e 2a                	jle    43521 <printer_vprintf+0x4b1>
   434f7:	8d 40 ff             	lea    -0x1(%rax),%eax
   434fa:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
   434ff:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43503:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43506:	41 0f b6 34 24       	movzbl (%r12),%esi
   4350b:	44 89 fa             	mov    %r15d,%edx
   4350e:	4c 89 f7             	mov    %r14,%rdi
   43511:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
   43514:	49 83 c4 01          	add    $0x1,%r12
   43518:	49 39 dc             	cmp    %rbx,%r12
   4351b:	75 e9                	jne    43506 <printer_vprintf+0x496>
   4351d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43521:	45 85 ed             	test   %r13d,%r13d
   43524:	7e 14                	jle    4353a <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
   43526:	44 89 fa             	mov    %r15d,%edx
   43529:	be 20 00 00 00       	mov    $0x20,%esi
   4352e:	4c 89 f7             	mov    %r14,%rdi
   43531:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
   43534:	41 83 ed 01          	sub    $0x1,%r13d
   43538:	75 ec                	jne    43526 <printer_vprintf+0x4b6>
    for (; *format; ++format) {
   4353a:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   4353e:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43542:	84 c0                	test   %al,%al
   43544:	0f 84 00 02 00 00    	je     4374a <printer_vprintf+0x6da>
        if (*format != '%') {
   4354a:	3c 25                	cmp    $0x25,%al
   4354c:	0f 84 53 fb ff ff    	je     430a5 <printer_vprintf+0x35>
            p->putc(p, *format, color);
   43552:	0f b6 f0             	movzbl %al,%esi
   43555:	44 89 fa             	mov    %r15d,%edx
   43558:	4c 89 f7             	mov    %r14,%rdi
   4355b:	41 ff 16             	callq  *(%r14)
            continue;
   4355e:	4c 89 e3             	mov    %r12,%rbx
   43561:	eb d7                	jmp    4353a <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
   43563:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43567:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   4356b:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4356f:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43573:	e9 4d fe ff ff       	jmpq   433c5 <printer_vprintf+0x355>
            color = va_arg(val, int);
   43578:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4357c:	8b 07                	mov    (%rdi),%eax
   4357e:	83 f8 2f             	cmp    $0x2f,%eax
   43581:	77 10                	ja     43593 <printer_vprintf+0x523>
   43583:	89 c2                	mov    %eax,%edx
   43585:	48 03 57 10          	add    0x10(%rdi),%rdx
   43589:	83 c0 08             	add    $0x8,%eax
   4358c:	89 07                	mov    %eax,(%rdi)
   4358e:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   43591:	eb a7                	jmp    4353a <printer_vprintf+0x4ca>
            color = va_arg(val, int);
   43593:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43597:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4359b:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4359f:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435a3:	eb e9                	jmp    4358e <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
   435a5:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435a9:	8b 01                	mov    (%rcx),%eax
   435ab:	83 f8 2f             	cmp    $0x2f,%eax
   435ae:	77 23                	ja     435d3 <printer_vprintf+0x563>
   435b0:	89 c2                	mov    %eax,%edx
   435b2:	48 03 51 10          	add    0x10(%rcx),%rdx
   435b6:	83 c0 08             	add    $0x8,%eax
   435b9:	89 01                	mov    %eax,(%rcx)
   435bb:	8b 02                	mov    (%rdx),%eax
   435bd:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   435c0:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   435c4:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   435c8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   435ce:	e9 fb fd ff ff       	jmpq   433ce <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
   435d3:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   435d7:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   435db:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435df:	48 89 47 08          	mov    %rax,0x8(%rdi)
   435e3:	eb d6                	jmp    435bb <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
   435e5:	84 d2                	test   %dl,%dl
   435e7:	0f 85 3b 01 00 00    	jne    43728 <printer_vprintf+0x6b8>
   435ed:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   435f1:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   435f5:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   435f9:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   435fd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43603:	e9 c6 fd ff ff       	jmpq   433ce <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
   43608:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   4360e:	bf c0 4f 04 00       	mov    $0x44fc0,%edi
        if (flags & FLAG_NUMERIC) {
   43613:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   43618:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   4361c:	4c 89 c1             	mov    %r8,%rcx
   4361f:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   43623:	48 63 f6             	movslq %esi,%rsi
   43626:	49 83 ec 01          	sub    $0x1,%r12
   4362a:	48 89 c8             	mov    %rcx,%rax
   4362d:	ba 00 00 00 00       	mov    $0x0,%edx
   43632:	48 f7 f6             	div    %rsi
   43635:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   43639:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   4363d:	48 89 ca             	mov    %rcx,%rdx
   43640:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   43643:	48 39 d6             	cmp    %rdx,%rsi
   43646:	76 de                	jbe    43626 <printer_vprintf+0x5b6>
   43648:	e9 96 fd ff ff       	jmpq   433e3 <printer_vprintf+0x373>
                prefix = "-";
   4364d:	48 c7 45 a0 d6 4d 04 	movq   $0x44dd6,-0x60(%rbp)
   43654:	00 
            if (flags & FLAG_NEGATIVE) {
   43655:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43658:	a8 80                	test   $0x80,%al
   4365a:	0f 85 ac fd ff ff    	jne    4340c <printer_vprintf+0x39c>
                prefix = "+";
   43660:	48 c7 45 a0 d4 4d 04 	movq   $0x44dd4,-0x60(%rbp)
   43667:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43668:	a8 10                	test   $0x10,%al
   4366a:	0f 85 9c fd ff ff    	jne    4340c <printer_vprintf+0x39c>
                prefix = " ";
   43670:	a8 08                	test   $0x8,%al
   43672:	ba d3 4d 04 00       	mov    $0x44dd3,%edx
   43677:	b8 d2 4d 04 00       	mov    $0x44dd2,%eax
   4367c:	48 0f 44 c2          	cmove  %rdx,%rax
   43680:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43684:	e9 83 fd ff ff       	jmpq   4340c <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
   43689:	41 8d 41 10          	lea    0x10(%r9),%eax
   4368d:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   43692:	0f 85 74 fd ff ff    	jne    4340c <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
   43698:	4d 85 c0             	test   %r8,%r8
   4369b:	75 0d                	jne    436aa <printer_vprintf+0x63a>
   4369d:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   436a4:	0f 84 62 fd ff ff    	je     4340c <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
   436aa:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   436ae:	ba cf 4d 04 00       	mov    $0x44dcf,%edx
   436b3:	b8 d8 4d 04 00       	mov    $0x44dd8,%eax
   436b8:	48 0f 44 c2          	cmove  %rdx,%rax
   436bc:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   436c0:	e9 47 fd ff ff       	jmpq   4340c <printer_vprintf+0x39c>
            len = strlen(data);
   436c5:	4c 89 e7             	mov    %r12,%rdi
   436c8:	e8 af f8 ff ff       	callq  42f7c <strlen>
   436cd:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   436d0:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   436d4:	0f 84 5f fd ff ff    	je     43439 <printer_vprintf+0x3c9>
   436da:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   436de:	0f 84 55 fd ff ff    	je     43439 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
   436e4:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   436e7:	89 fa                	mov    %edi,%edx
   436e9:	29 c2                	sub    %eax,%edx
   436eb:	39 c7                	cmp    %eax,%edi
   436ed:	b8 00 00 00 00       	mov    $0x0,%eax
   436f2:	0f 4e d0             	cmovle %eax,%edx
   436f5:	89 55 9c             	mov    %edx,-0x64(%rbp)
   436f8:	e9 52 fd ff ff       	jmpq   4344f <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
   436fd:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43701:	e8 76 f8 ff ff       	callq  42f7c <strlen>
   43706:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43709:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   4370c:	44 89 e9             	mov    %r13d,%ecx
   4370f:	29 f9                	sub    %edi,%ecx
   43711:	29 c1                	sub    %eax,%ecx
   43713:	89 c8                	mov    %ecx,%eax
   43715:	44 39 ea             	cmp    %r13d,%edx
   43718:	b9 00 00 00 00       	mov    $0x0,%ecx
   4371d:	0f 4d c1             	cmovge %ecx,%eax
   43720:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43723:	e9 27 fd ff ff       	jmpq   4344f <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
   43728:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   4372b:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   4372f:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43733:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43739:	e9 90 fc ff ff       	jmpq   433ce <printer_vprintf+0x35e>
        int flags = 0;
   4373e:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   43745:	e9 ad f9 ff ff       	jmpq   430f7 <printer_vprintf+0x87>
}
   4374a:	48 83 c4 58          	add    $0x58,%rsp
   4374e:	5b                   	pop    %rbx
   4374f:	41 5c                	pop    %r12
   43751:	41 5d                	pop    %r13
   43753:	41 5e                	pop    %r14
   43755:	41 5f                	pop    %r15
   43757:	5d                   	pop    %rbp
   43758:	c3                   	retq   

0000000000043759 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43759:	55                   	push   %rbp
   4375a:	48 89 e5             	mov    %rsp,%rbp
   4375d:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   43761:	48 c7 45 f0 57 2e 04 	movq   $0x42e57,-0x10(%rbp)
   43768:	00 
        cpos = 0;
   43769:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   4376f:	b8 00 00 00 00       	mov    $0x0,%eax
   43774:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   43777:	48 63 ff             	movslq %edi,%rdi
   4377a:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   43781:	00 
   43782:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   43786:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   4378a:	e8 e1 f8 ff ff       	callq  43070 <printer_vprintf>
    return cp.cursor - console;
   4378f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43793:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43799:	48 d1 f8             	sar    %rax
}
   4379c:	c9                   	leaveq 
   4379d:	c3                   	retq   

000000000004379e <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   4379e:	55                   	push   %rbp
   4379f:	48 89 e5             	mov    %rsp,%rbp
   437a2:	48 83 ec 50          	sub    $0x50,%rsp
   437a6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   437aa:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   437ae:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   437b2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   437b9:	48 8d 45 10          	lea    0x10(%rbp),%rax
   437bd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   437c1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   437c5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   437c9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   437cd:	e8 87 ff ff ff       	callq  43759 <console_vprintf>
}
   437d2:	c9                   	leaveq 
   437d3:	c3                   	retq   

00000000000437d4 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   437d4:	55                   	push   %rbp
   437d5:	48 89 e5             	mov    %rsp,%rbp
   437d8:	53                   	push   %rbx
   437d9:	48 83 ec 28          	sub    $0x28,%rsp
   437dd:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   437e0:	48 c7 45 d8 e1 2e 04 	movq   $0x42ee1,-0x28(%rbp)
   437e7:	00 
    sp.s = s;
   437e8:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   437ec:	48 85 f6             	test   %rsi,%rsi
   437ef:	75 0e                	jne    437ff <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   437f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437f5:	48 29 d8             	sub    %rbx,%rax
}
   437f8:	48 83 c4 28          	add    $0x28,%rsp
   437fc:	5b                   	pop    %rbx
   437fd:	5d                   	pop    %rbp
   437fe:	c3                   	retq   
        sp.end = s + size - 1;
   437ff:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43804:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43808:	be 00 00 00 00       	mov    $0x0,%esi
   4380d:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43811:	e8 5a f8 ff ff       	callq  43070 <printer_vprintf>
        *sp.s = 0;
   43816:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4381a:	c6 00 00             	movb   $0x0,(%rax)
   4381d:	eb d2                	jmp    437f1 <vsnprintf+0x1d>

000000000004381f <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   4381f:	55                   	push   %rbp
   43820:	48 89 e5             	mov    %rsp,%rbp
   43823:	48 83 ec 50          	sub    $0x50,%rsp
   43827:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4382b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4382f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43833:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   4383a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4383e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43842:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43846:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   4384a:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4384e:	e8 81 ff ff ff       	callq  437d4 <vsnprintf>
    va_end(val);
    return n;
}
   43853:	c9                   	leaveq 
   43854:	c3                   	retq   

0000000000043855 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43855:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4385a:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   4385f:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43864:	48 83 c0 02          	add    $0x2,%rax
   43868:	48 39 d0             	cmp    %rdx,%rax
   4386b:	75 f2                	jne    4385f <console_clear+0xa>
    }
    cursorpos = 0;
   4386d:	c7 05 85 57 07 00 00 	movl   $0x0,0x75785(%rip)        # b8ffc <cursorpos>
   43874:	00 00 00 
}
   43877:	c3                   	retq   

0000000000043878 <palloc>:
   43878:	55                   	push   %rbp
   43879:	48 89 e5             	mov    %rsp,%rbp
   4387c:	48 83 ec 20          	sub    $0x20,%rsp
   43880:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43883:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   4388a:	00 
   4388b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4388f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43893:	e9 95 00 00 00       	jmpq   4392d <palloc+0xb5>
   43898:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4389c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   438a0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   438a7:	00 
   438a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438ac:	48 c1 e8 0c          	shr    $0xc,%rax
   438b0:	48 98                	cltq   
   438b2:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   438b9:	00 
   438ba:	84 c0                	test   %al,%al
   438bc:	75 6f                	jne    4392d <palloc+0xb5>
   438be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438c2:	48 c1 e8 0c          	shr    $0xc,%rax
   438c6:	48 98                	cltq   
   438c8:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   438cf:	00 
   438d0:	84 c0                	test   %al,%al
   438d2:	75 59                	jne    4392d <palloc+0xb5>
   438d4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438d8:	48 c1 e8 0c          	shr    $0xc,%rax
   438dc:	89 c2                	mov    %eax,%edx
   438de:	48 63 c2             	movslq %edx,%rax
   438e1:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   438e8:	00 
   438e9:	83 c0 01             	add    $0x1,%eax
   438ec:	89 c1                	mov    %eax,%ecx
   438ee:	48 63 c2             	movslq %edx,%rax
   438f1:	88 8c 00 41 9f 05 00 	mov    %cl,0x59f41(%rax,%rax,1)
   438f8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   438fc:	48 c1 e8 0c          	shr    $0xc,%rax
   43900:	89 c1                	mov    %eax,%ecx
   43902:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43905:	89 c2                	mov    %eax,%edx
   43907:	48 63 c1             	movslq %ecx,%rax
   4390a:	88 94 00 40 9f 05 00 	mov    %dl,0x59f40(%rax,%rax,1)
   43911:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43915:	ba 00 10 00 00       	mov    $0x1000,%edx
   4391a:	be cc 00 00 00       	mov    $0xcc,%esi
   4391f:	48 89 c7             	mov    %rax,%rdi
   43922:	e8 39 f6 ff ff       	callq  42f60 <memset>
   43927:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4392b:	eb 2c                	jmp    43959 <palloc+0xe1>
   4392d:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43934:	00 
   43935:	0f 86 5d ff ff ff    	jbe    43898 <palloc+0x20>
   4393b:	ba d8 4f 04 00       	mov    $0x44fd8,%edx
   43940:	be 00 0c 00 00       	mov    $0xc00,%esi
   43945:	bf 80 07 00 00       	mov    $0x780,%edi
   4394a:	b8 00 00 00 00       	mov    $0x0,%eax
   4394f:	e8 4a fe ff ff       	callq  4379e <console_printf>
   43954:	b8 00 00 00 00       	mov    $0x0,%eax
   43959:	c9                   	leaveq 
   4395a:	c3                   	retq   

000000000004395b <palloc_target>:
   4395b:	55                   	push   %rbp
   4395c:	48 89 e5             	mov    %rsp,%rbp
   4395f:	48 8b 05 b2 56 01 00 	mov    0x156b2(%rip),%rax        # 59018 <palloc_target_proc>
   43966:	48 85 c0             	test   %rax,%rax
   43969:	75 14                	jne    4397f <palloc_target+0x24>
   4396b:	ba f1 4f 04 00       	mov    $0x44ff1,%edx
   43970:	be 27 00 00 00       	mov    $0x27,%esi
   43975:	bf 0c 50 04 00       	mov    $0x4500c,%edi
   4397a:	e8 57 f1 ff ff       	callq  42ad6 <assert_fail>
   4397f:	48 8b 05 92 56 01 00 	mov    0x15692(%rip),%rax        # 59018 <palloc_target_proc>
   43986:	8b 00                	mov    (%rax),%eax
   43988:	89 c7                	mov    %eax,%edi
   4398a:	e8 e9 fe ff ff       	callq  43878 <palloc>
   4398f:	5d                   	pop    %rbp
   43990:	c3                   	retq   

0000000000043991 <process_free>:
   43991:	55                   	push   %rbp
   43992:	48 89 e5             	mov    %rsp,%rbp
   43995:	48 83 ec 60          	sub    $0x60,%rsp
   43999:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4399c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4399f:	48 63 d0             	movslq %eax,%rdx
   439a2:	48 89 d0             	mov    %rdx,%rax
   439a5:	48 c1 e0 04          	shl    $0x4,%rax
   439a9:	48 29 d0             	sub    %rdx,%rax
   439ac:	48 c1 e0 04          	shl    $0x4,%rax
   439b0:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   439b6:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   439bc:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   439c3:	00 
   439c4:	e9 ad 00 00 00       	jmpq   43a76 <process_free+0xe5>
   439c9:	8b 45 ac             	mov    -0x54(%rbp),%eax
   439cc:	48 63 d0             	movslq %eax,%rdx
   439cf:	48 89 d0             	mov    %rdx,%rax
   439d2:	48 c1 e0 04          	shl    $0x4,%rax
   439d6:	48 29 d0             	sub    %rdx,%rax
   439d9:	48 c1 e0 04          	shl    $0x4,%rax
   439dd:	48 05 00 91 05 00    	add    $0x59100,%rax
   439e3:	48 8b 08             	mov    (%rax),%rcx
   439e6:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   439ea:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   439ee:	48 89 ce             	mov    %rcx,%rsi
   439f1:	48 89 c7             	mov    %rax,%rdi
   439f4:	e8 b2 e4 ff ff       	callq  41eab <virtual_memory_lookup>
   439f9:	8b 45 c8             	mov    -0x38(%rbp),%eax
   439fc:	48 98                	cltq   
   439fe:	83 e0 01             	and    $0x1,%eax
   43a01:	48 85 c0             	test   %rax,%rax
   43a04:	74 68                	je     43a6e <process_free+0xdd>
   43a06:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43a09:	48 63 d0             	movslq %eax,%rdx
   43a0c:	0f b6 94 12 41 9f 05 	movzbl 0x59f41(%rdx,%rdx,1),%edx
   43a13:	00 
   43a14:	83 ea 01             	sub    $0x1,%edx
   43a17:	48 98                	cltq   
   43a19:	88 94 00 41 9f 05 00 	mov    %dl,0x59f41(%rax,%rax,1)
   43a20:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43a23:	48 98                	cltq   
   43a25:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   43a2c:	00 
   43a2d:	84 c0                	test   %al,%al
   43a2f:	75 0f                	jne    43a40 <process_free+0xaf>
   43a31:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43a34:	48 98                	cltq   
   43a36:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43a3d:	00 
   43a3e:	eb 2e                	jmp    43a6e <process_free+0xdd>
   43a40:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43a43:	48 98                	cltq   
   43a45:	0f b6 84 00 40 9f 05 	movzbl 0x59f40(%rax,%rax,1),%eax
   43a4c:	00 
   43a4d:	0f be c0             	movsbl %al,%eax
   43a50:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43a53:	75 19                	jne    43a6e <process_free+0xdd>
   43a55:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43a59:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43a5c:	48 89 c6             	mov    %rax,%rsi
   43a5f:	bf 18 50 04 00       	mov    $0x45018,%edi
   43a64:	b8 00 00 00 00       	mov    $0x0,%eax
   43a69:	e8 5f ed ff ff       	callq  427cd <log_printf>
   43a6e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43a75:	00 
   43a76:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43a7d:	00 
   43a7e:	0f 86 45 ff ff ff    	jbe    439c9 <process_free+0x38>
   43a84:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43a87:	48 63 d0             	movslq %eax,%rdx
   43a8a:	48 89 d0             	mov    %rdx,%rax
   43a8d:	48 c1 e0 04          	shl    $0x4,%rax
   43a91:	48 29 d0             	sub    %rdx,%rax
   43a94:	48 c1 e0 04          	shl    $0x4,%rax
   43a98:	48 05 00 91 05 00    	add    $0x59100,%rax
   43a9e:	48 8b 00             	mov    (%rax),%rax
   43aa1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43aa5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43aa9:	48 8b 00             	mov    (%rax),%rax
   43aac:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43ab2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43ab6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43aba:	48 8b 00             	mov    (%rax),%rax
   43abd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43ac3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43ac7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43acb:	48 8b 00             	mov    (%rax),%rax
   43ace:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43ad4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43ad8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43adc:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ae0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43ae6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43aea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43aee:	48 c1 e8 0c          	shr    $0xc,%rax
   43af2:	48 98                	cltq   
   43af4:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   43afb:	00 
   43afc:	3c 01                	cmp    $0x1,%al
   43afe:	74 14                	je     43b14 <process_free+0x183>
   43b00:	ba 50 50 04 00       	mov    $0x45050,%edx
   43b05:	be 4f 00 00 00       	mov    $0x4f,%esi
   43b0a:	bf 0c 50 04 00       	mov    $0x4500c,%edi
   43b0f:	e8 c2 ef ff ff       	callq  42ad6 <assert_fail>
   43b14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b18:	48 c1 e8 0c          	shr    $0xc,%rax
   43b1c:	48 98                	cltq   
   43b1e:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43b25:	00 
   43b26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b2a:	48 c1 e8 0c          	shr    $0xc,%rax
   43b2e:	48 98                	cltq   
   43b30:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43b37:	00 
   43b38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b3c:	48 c1 e8 0c          	shr    $0xc,%rax
   43b40:	48 98                	cltq   
   43b42:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   43b49:	00 
   43b4a:	3c 01                	cmp    $0x1,%al
   43b4c:	74 14                	je     43b62 <process_free+0x1d1>
   43b4e:	ba 78 50 04 00       	mov    $0x45078,%edx
   43b53:	be 52 00 00 00       	mov    $0x52,%esi
   43b58:	bf 0c 50 04 00       	mov    $0x4500c,%edi
   43b5d:	e8 74 ef ff ff       	callq  42ad6 <assert_fail>
   43b62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b66:	48 c1 e8 0c          	shr    $0xc,%rax
   43b6a:	48 98                	cltq   
   43b6c:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43b73:	00 
   43b74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43b78:	48 c1 e8 0c          	shr    $0xc,%rax
   43b7c:	48 98                	cltq   
   43b7e:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43b85:	00 
   43b86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43b8a:	48 c1 e8 0c          	shr    $0xc,%rax
   43b8e:	48 98                	cltq   
   43b90:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   43b97:	00 
   43b98:	3c 01                	cmp    $0x1,%al
   43b9a:	74 14                	je     43bb0 <process_free+0x21f>
   43b9c:	ba a0 50 04 00       	mov    $0x450a0,%edx
   43ba1:	be 55 00 00 00       	mov    $0x55,%esi
   43ba6:	bf 0c 50 04 00       	mov    $0x4500c,%edi
   43bab:	e8 26 ef ff ff       	callq  42ad6 <assert_fail>
   43bb0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bb4:	48 c1 e8 0c          	shr    $0xc,%rax
   43bb8:	48 98                	cltq   
   43bba:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43bc1:	00 
   43bc2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43bc6:	48 c1 e8 0c          	shr    $0xc,%rax
   43bca:	48 98                	cltq   
   43bcc:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43bd3:	00 
   43bd4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43bd8:	48 c1 e8 0c          	shr    $0xc,%rax
   43bdc:	48 98                	cltq   
   43bde:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   43be5:	00 
   43be6:	3c 01                	cmp    $0x1,%al
   43be8:	74 14                	je     43bfe <process_free+0x26d>
   43bea:	ba c8 50 04 00       	mov    $0x450c8,%edx
   43bef:	be 58 00 00 00       	mov    $0x58,%esi
   43bf4:	bf 0c 50 04 00       	mov    $0x4500c,%edi
   43bf9:	e8 d8 ee ff ff       	callq  42ad6 <assert_fail>
   43bfe:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c02:	48 c1 e8 0c          	shr    $0xc,%rax
   43c06:	48 98                	cltq   
   43c08:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43c0f:	00 
   43c10:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43c14:	48 c1 e8 0c          	shr    $0xc,%rax
   43c18:	48 98                	cltq   
   43c1a:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43c21:	00 
   43c22:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43c26:	48 c1 e8 0c          	shr    $0xc,%rax
   43c2a:	48 98                	cltq   
   43c2c:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   43c33:	00 
   43c34:	3c 01                	cmp    $0x1,%al
   43c36:	74 14                	je     43c4c <process_free+0x2bb>
   43c38:	ba f0 50 04 00       	mov    $0x450f0,%edx
   43c3d:	be 5b 00 00 00       	mov    $0x5b,%esi
   43c42:	bf 0c 50 04 00       	mov    $0x4500c,%edi
   43c47:	e8 8a ee ff ff       	callq  42ad6 <assert_fail>
   43c4c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43c50:	48 c1 e8 0c          	shr    $0xc,%rax
   43c54:	48 98                	cltq   
   43c56:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43c5d:	00 
   43c5e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43c62:	48 c1 e8 0c          	shr    $0xc,%rax
   43c66:	48 98                	cltq   
   43c68:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43c6f:	00 
   43c70:	90                   	nop
   43c71:	c9                   	leaveq 
   43c72:	c3                   	retq   

0000000000043c73 <process_config_tables>:
   43c73:	55                   	push   %rbp
   43c74:	48 89 e5             	mov    %rsp,%rbp
   43c77:	48 83 ec 40          	sub    $0x40,%rsp
   43c7b:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43c7e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43c81:	89 c7                	mov    %eax,%edi
   43c83:	e8 f0 fb ff ff       	callq  43878 <palloc>
   43c88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c8c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43c8f:	89 c7                	mov    %eax,%edi
   43c91:	e8 e2 fb ff ff       	callq  43878 <palloc>
   43c96:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c9a:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43c9d:	89 c7                	mov    %eax,%edi
   43c9f:	e8 d4 fb ff ff       	callq  43878 <palloc>
   43ca4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43ca8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43cab:	89 c7                	mov    %eax,%edi
   43cad:	e8 c6 fb ff ff       	callq  43878 <palloc>
   43cb2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43cb6:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43cb9:	89 c7                	mov    %eax,%edi
   43cbb:	e8 b8 fb ff ff       	callq  43878 <palloc>
   43cc0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43cc4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43cc9:	74 20                	je     43ceb <process_config_tables+0x78>
   43ccb:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43cd0:	74 19                	je     43ceb <process_config_tables+0x78>
   43cd2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43cd7:	74 12                	je     43ceb <process_config_tables+0x78>
   43cd9:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43cde:	74 0b                	je     43ceb <process_config_tables+0x78>
   43ce0:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43ce5:	0f 85 e1 00 00 00    	jne    43dcc <process_config_tables+0x159>
   43ceb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43cf0:	74 24                	je     43d16 <process_config_tables+0xa3>
   43cf2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cf6:	48 c1 e8 0c          	shr    $0xc,%rax
   43cfa:	48 98                	cltq   
   43cfc:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43d03:	00 
   43d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d08:	48 c1 e8 0c          	shr    $0xc,%rax
   43d0c:	48 98                	cltq   
   43d0e:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43d15:	00 
   43d16:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43d1b:	74 24                	je     43d41 <process_config_tables+0xce>
   43d1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d21:	48 c1 e8 0c          	shr    $0xc,%rax
   43d25:	48 98                	cltq   
   43d27:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43d2e:	00 
   43d2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d33:	48 c1 e8 0c          	shr    $0xc,%rax
   43d37:	48 98                	cltq   
   43d39:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43d40:	00 
   43d41:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43d46:	74 24                	je     43d6c <process_config_tables+0xf9>
   43d48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d4c:	48 c1 e8 0c          	shr    $0xc,%rax
   43d50:	48 98                	cltq   
   43d52:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43d59:	00 
   43d5a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d5e:	48 c1 e8 0c          	shr    $0xc,%rax
   43d62:	48 98                	cltq   
   43d64:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43d6b:	00 
   43d6c:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43d71:	74 24                	je     43d97 <process_config_tables+0x124>
   43d73:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d77:	48 c1 e8 0c          	shr    $0xc,%rax
   43d7b:	48 98                	cltq   
   43d7d:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43d84:	00 
   43d85:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d89:	48 c1 e8 0c          	shr    $0xc,%rax
   43d8d:	48 98                	cltq   
   43d8f:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43d96:	00 
   43d97:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d9c:	74 24                	je     43dc2 <process_config_tables+0x14f>
   43d9e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43da2:	48 c1 e8 0c          	shr    $0xc,%rax
   43da6:	48 98                	cltq   
   43da8:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43daf:	00 
   43db0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43db4:	48 c1 e8 0c          	shr    $0xc,%rax
   43db8:	48 98                	cltq   
   43dba:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43dc1:	00 
   43dc2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43dc7:	e9 f3 01 00 00       	jmpq   43fbf <process_config_tables+0x34c>
   43dcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dd0:	ba 00 10 00 00       	mov    $0x1000,%edx
   43dd5:	be 00 00 00 00       	mov    $0x0,%esi
   43dda:	48 89 c7             	mov    %rax,%rdi
   43ddd:	e8 7e f1 ff ff       	callq  42f60 <memset>
   43de2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43de6:	ba 00 10 00 00       	mov    $0x1000,%edx
   43deb:	be 00 00 00 00       	mov    $0x0,%esi
   43df0:	48 89 c7             	mov    %rax,%rdi
   43df3:	e8 68 f1 ff ff       	callq  42f60 <memset>
   43df8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43dfc:	ba 00 10 00 00       	mov    $0x1000,%edx
   43e01:	be 00 00 00 00       	mov    $0x0,%esi
   43e06:	48 89 c7             	mov    %rax,%rdi
   43e09:	e8 52 f1 ff ff       	callq  42f60 <memset>
   43e0e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e12:	ba 00 10 00 00       	mov    $0x1000,%edx
   43e17:	be 00 00 00 00       	mov    $0x0,%esi
   43e1c:	48 89 c7             	mov    %rax,%rdi
   43e1f:	e8 3c f1 ff ff       	callq  42f60 <memset>
   43e24:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e28:	ba 00 10 00 00       	mov    $0x1000,%edx
   43e2d:	be 00 00 00 00       	mov    $0x0,%esi
   43e32:	48 89 c7             	mov    %rax,%rdi
   43e35:	e8 26 f1 ff ff       	callq  42f60 <memset>
   43e3a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e3e:	48 83 c8 07          	or     $0x7,%rax
   43e42:	48 89 c2             	mov    %rax,%rdx
   43e45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e49:	48 89 10             	mov    %rdx,(%rax)
   43e4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e50:	48 83 c8 07          	or     $0x7,%rax
   43e54:	48 89 c2             	mov    %rax,%rdx
   43e57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e5b:	48 89 10             	mov    %rdx,(%rax)
   43e5e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43e62:	48 83 c8 07          	or     $0x7,%rax
   43e66:	48 89 c2             	mov    %rax,%rdx
   43e69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e6d:	48 89 10             	mov    %rdx,(%rax)
   43e70:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e74:	48 83 c8 07          	or     $0x7,%rax
   43e78:	48 89 c2             	mov    %rax,%rdx
   43e7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e7f:	48 89 50 08          	mov    %rdx,0x8(%rax)
   43e83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e87:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43e8d:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   43e93:	b9 00 00 10 00       	mov    $0x100000,%ecx
   43e98:	ba 00 00 00 00       	mov    $0x0,%edx
   43e9d:	be 00 00 00 00       	mov    $0x0,%esi
   43ea2:	48 89 c7             	mov    %rax,%rdi
   43ea5:	e8 0a dc ff ff       	callq  41ab4 <virtual_memory_map>
   43eaa:	85 c0                	test   %eax,%eax
   43eac:	75 2f                	jne    43edd <process_config_tables+0x26a>
   43eae:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   43eb3:	be 00 80 0b 00       	mov    $0xb8000,%esi
   43eb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ebc:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43ec2:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43ec8:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43ecd:	48 89 c7             	mov    %rax,%rdi
   43ed0:	e8 df db ff ff       	callq  41ab4 <virtual_memory_map>
   43ed5:	85 c0                	test   %eax,%eax
   43ed7:	0f 84 bb 00 00 00    	je     43f98 <process_config_tables+0x325>
   43edd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ee1:	48 c1 e8 0c          	shr    $0xc,%rax
   43ee5:	48 98                	cltq   
   43ee7:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43eee:	00 
   43eef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ef3:	48 c1 e8 0c          	shr    $0xc,%rax
   43ef7:	48 98                	cltq   
   43ef9:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43f00:	00 
   43f01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f05:	48 c1 e8 0c          	shr    $0xc,%rax
   43f09:	48 98                	cltq   
   43f0b:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43f12:	00 
   43f13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f17:	48 c1 e8 0c          	shr    $0xc,%rax
   43f1b:	48 98                	cltq   
   43f1d:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43f24:	00 
   43f25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f29:	48 c1 e8 0c          	shr    $0xc,%rax
   43f2d:	48 98                	cltq   
   43f2f:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43f36:	00 
   43f37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f3b:	48 c1 e8 0c          	shr    $0xc,%rax
   43f3f:	48 98                	cltq   
   43f41:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43f48:	00 
   43f49:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f4d:	48 c1 e8 0c          	shr    $0xc,%rax
   43f51:	48 98                	cltq   
   43f53:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43f5a:	00 
   43f5b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f5f:	48 c1 e8 0c          	shr    $0xc,%rax
   43f63:	48 98                	cltq   
   43f65:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43f6c:	00 
   43f6d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f71:	48 c1 e8 0c          	shr    $0xc,%rax
   43f75:	48 98                	cltq   
   43f77:	c6 84 00 40 9f 05 00 	movb   $0x0,0x59f40(%rax,%rax,1)
   43f7e:	00 
   43f7f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43f83:	48 c1 e8 0c          	shr    $0xc,%rax
   43f87:	48 98                	cltq   
   43f89:	c6 84 00 41 9f 05 00 	movb   $0x0,0x59f41(%rax,%rax,1)
   43f90:	00 
   43f91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43f96:	eb 27                	jmp    43fbf <process_config_tables+0x34c>
   43f98:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43f9b:	48 63 d0             	movslq %eax,%rdx
   43f9e:	48 89 d0             	mov    %rdx,%rax
   43fa1:	48 c1 e0 04          	shl    $0x4,%rax
   43fa5:	48 29 d0             	sub    %rdx,%rax
   43fa8:	48 c1 e0 04          	shl    $0x4,%rax
   43fac:	48 8d 90 00 91 05 00 	lea    0x59100(%rax),%rdx
   43fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fb7:	48 89 02             	mov    %rax,(%rdx)
   43fba:	b8 00 00 00 00       	mov    $0x0,%eax
   43fbf:	c9                   	leaveq 
   43fc0:	c3                   	retq   

0000000000043fc1 <process_load>:
   43fc1:	55                   	push   %rbp
   43fc2:	48 89 e5             	mov    %rsp,%rbp
   43fc5:	48 83 ec 20          	sub    $0x20,%rsp
   43fc9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43fcd:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43fd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fd4:	48 89 05 3d 50 01 00 	mov    %rax,0x1503d(%rip)        # 59018 <palloc_target_proc>
   43fdb:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43fde:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fe2:	ba 5b 39 04 00       	mov    $0x4395b,%edx
   43fe7:	89 ce                	mov    %ecx,%esi
   43fe9:	48 89 c7             	mov    %rax,%rdi
   43fec:	e8 4a eb ff ff       	callq  42b3b <program_load>
   43ff1:	89 45 fc             	mov    %eax,-0x4(%rbp)
   43ff4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43ff7:	c9                   	leaveq 
   43ff8:	c3                   	retq   

0000000000043ff9 <process_setup_stack>:
   43ff9:	55                   	push   %rbp
   43ffa:	48 89 e5             	mov    %rsp,%rbp
   43ffd:	48 83 ec 20          	sub    $0x20,%rsp
   44001:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44005:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44009:	8b 00                	mov    (%rax),%eax
   4400b:	89 c7                	mov    %eax,%edi
   4400d:	e8 66 f8 ff ff       	callq  43878 <palloc>
   44012:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44016:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4401a:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   44021:	00 00 30 00 
   44025:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44029:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   44030:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44034:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   4403a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44040:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44045:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   4404a:	48 89 c7             	mov    %rax,%rdi
   4404d:	e8 62 da ff ff       	callq  41ab4 <virtual_memory_map>
   44052:	90                   	nop
   44053:	c9                   	leaveq 
   44054:	c3                   	retq   

0000000000044055 <find_free_pid>:
   44055:	55                   	push   %rbp
   44056:	48 89 e5             	mov    %rsp,%rbp
   44059:	48 83 ec 10          	sub    $0x10,%rsp
   4405d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44064:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   4406b:	eb 24                	jmp    44091 <find_free_pid+0x3c>
   4406d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44070:	48 63 d0             	movslq %eax,%rdx
   44073:	48 89 d0             	mov    %rdx,%rax
   44076:	48 c1 e0 04          	shl    $0x4,%rax
   4407a:	48 29 d0             	sub    %rdx,%rax
   4407d:	48 c1 e0 04          	shl    $0x4,%rax
   44081:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   44087:	8b 00                	mov    (%rax),%eax
   44089:	85 c0                	test   %eax,%eax
   4408b:	74 0c                	je     44099 <find_free_pid+0x44>
   4408d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44091:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   44095:	7e d6                	jle    4406d <find_free_pid+0x18>
   44097:	eb 01                	jmp    4409a <find_free_pid+0x45>
   44099:	90                   	nop
   4409a:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4409e:	74 05                	je     440a5 <find_free_pid+0x50>
   440a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
   440a3:	eb 05                	jmp    440aa <find_free_pid+0x55>
   440a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   440aa:	c9                   	leaveq 
   440ab:	c3                   	retq   

00000000000440ac <process_fork>:
   440ac:	55                   	push   %rbp
   440ad:	48 89 e5             	mov    %rsp,%rbp
   440b0:	48 83 ec 40          	sub    $0x40,%rsp
   440b4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   440b8:	b8 00 00 00 00       	mov    $0x0,%eax
   440bd:	e8 93 ff ff ff       	callq  44055 <find_free_pid>
   440c2:	89 45 f4             	mov    %eax,-0xc(%rbp)
   440c5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   440c9:	75 0a                	jne    440d5 <process_fork+0x29>
   440cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   440d0:	e9 67 02 00 00       	jmpq   4433c <process_fork+0x290>
   440d5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   440d8:	48 63 d0             	movslq %eax,%rdx
   440db:	48 89 d0             	mov    %rdx,%rax
   440de:	48 c1 e0 04          	shl    $0x4,%rax
   440e2:	48 29 d0             	sub    %rdx,%rax
   440e5:	48 c1 e0 04          	shl    $0x4,%rax
   440e9:	48 05 20 90 05 00    	add    $0x59020,%rax
   440ef:	be 00 00 00 00       	mov    $0x0,%esi
   440f4:	48 89 c7             	mov    %rax,%rdi
   440f7:	e8 9c e1 ff ff       	callq  42298 <process_init>
   440fc:	8b 45 f4             	mov    -0xc(%rbp),%eax
   440ff:	89 c7                	mov    %eax,%edi
   44101:	e8 6d fb ff ff       	callq  43c73 <process_config_tables>
   44106:	83 f8 ff             	cmp    $0xffffffff,%eax
   44109:	75 0a                	jne    44115 <process_fork+0x69>
   4410b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44110:	e9 27 02 00 00       	jmpq   4433c <process_fork+0x290>
   44115:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4411c:	00 
   4411d:	e9 79 01 00 00       	jmpq   4429b <process_fork+0x1ef>
   44122:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44126:	8b 00                	mov    (%rax),%eax
   44128:	48 63 d0             	movslq %eax,%rdx
   4412b:	48 89 d0             	mov    %rdx,%rax
   4412e:	48 c1 e0 04          	shl    $0x4,%rax
   44132:	48 29 d0             	sub    %rdx,%rax
   44135:	48 c1 e0 04          	shl    $0x4,%rax
   44139:	48 05 00 91 05 00    	add    $0x59100,%rax
   4413f:	48 8b 08             	mov    (%rax),%rcx
   44142:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44146:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4414a:	48 89 ce             	mov    %rcx,%rsi
   4414d:	48 89 c7             	mov    %rax,%rdi
   44150:	e8 56 dd ff ff       	callq  41eab <virtual_memory_lookup>
   44155:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44158:	48 98                	cltq   
   4415a:	83 e0 07             	and    $0x7,%eax
   4415d:	48 83 f8 07          	cmp    $0x7,%rax
   44161:	0f 85 a1 00 00 00    	jne    44208 <process_fork+0x15c>
   44167:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4416a:	89 c7                	mov    %eax,%edi
   4416c:	e8 07 f7 ff ff       	callq  43878 <palloc>
   44171:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   44175:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4417a:	75 14                	jne    44190 <process_fork+0xe4>
   4417c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4417f:	89 c7                	mov    %eax,%edi
   44181:	e8 0b f8 ff ff       	callq  43991 <process_free>
   44186:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4418b:	e9 ac 01 00 00       	jmpq   4433c <process_fork+0x290>
   44190:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44194:	48 89 c1             	mov    %rax,%rcx
   44197:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4419b:	ba 00 10 00 00       	mov    $0x1000,%edx
   441a0:	48 89 ce             	mov    %rcx,%rsi
   441a3:	48 89 c7             	mov    %rax,%rdi
   441a6:	e8 4c ed ff ff       	callq  42ef7 <memcpy>
   441ab:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   441af:	8b 45 f4             	mov    -0xc(%rbp),%eax
   441b2:	48 63 d0             	movslq %eax,%rdx
   441b5:	48 89 d0             	mov    %rdx,%rax
   441b8:	48 c1 e0 04          	shl    $0x4,%rax
   441bc:	48 29 d0             	sub    %rdx,%rax
   441bf:	48 c1 e0 04          	shl    $0x4,%rax
   441c3:	48 05 00 91 05 00    	add    $0x59100,%rax
   441c9:	48 8b 00             	mov    (%rax),%rax
   441cc:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   441d0:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   441d6:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   441dc:	b9 00 10 00 00       	mov    $0x1000,%ecx
   441e1:	48 89 fa             	mov    %rdi,%rdx
   441e4:	48 89 c7             	mov    %rax,%rdi
   441e7:	e8 c8 d8 ff ff       	callq  41ab4 <virtual_memory_map>
   441ec:	85 c0                	test   %eax,%eax
   441ee:	0f 84 9f 00 00 00    	je     44293 <process_fork+0x1e7>
   441f4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   441f7:	89 c7                	mov    %eax,%edi
   441f9:	e8 93 f7 ff ff       	callq  43991 <process_free>
   441fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44203:	e9 34 01 00 00       	jmpq   4433c <process_fork+0x290>
   44208:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4420b:	48 98                	cltq   
   4420d:	83 e0 05             	and    $0x5,%eax
   44210:	48 83 f8 05          	cmp    $0x5,%rax
   44214:	75 7d                	jne    44293 <process_fork+0x1e7>
   44216:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   4421a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4421d:	48 63 d0             	movslq %eax,%rdx
   44220:	48 89 d0             	mov    %rdx,%rax
   44223:	48 c1 e0 04          	shl    $0x4,%rax
   44227:	48 29 d0             	sub    %rdx,%rax
   4422a:	48 c1 e0 04          	shl    $0x4,%rax
   4422e:	48 05 00 91 05 00    	add    $0x59100,%rax
   44234:	48 8b 00             	mov    (%rax),%rax
   44237:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4423b:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44241:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   44247:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4424c:	48 89 fa             	mov    %rdi,%rdx
   4424f:	48 89 c7             	mov    %rax,%rdi
   44252:	e8 5d d8 ff ff       	callq  41ab4 <virtual_memory_map>
   44257:	85 c0                	test   %eax,%eax
   44259:	74 14                	je     4426f <process_fork+0x1c3>
   4425b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4425e:	89 c7                	mov    %eax,%edi
   44260:	e8 2c f7 ff ff       	callq  43991 <process_free>
   44265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4426a:	e9 cd 00 00 00       	jmpq   4433c <process_fork+0x290>
   4426f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44273:	48 c1 e8 0c          	shr    $0xc,%rax
   44277:	89 c2                	mov    %eax,%edx
   44279:	48 63 c2             	movslq %edx,%rax
   4427c:	0f b6 84 00 41 9f 05 	movzbl 0x59f41(%rax,%rax,1),%eax
   44283:	00 
   44284:	83 c0 01             	add    $0x1,%eax
   44287:	89 c1                	mov    %eax,%ecx
   44289:	48 63 c2             	movslq %edx,%rax
   4428c:	88 8c 00 41 9f 05 00 	mov    %cl,0x59f41(%rax,%rax,1)
   44293:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4429a:	00 
   4429b:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   442a2:	00 
   442a3:	0f 86 79 fe ff ff    	jbe    44122 <process_fork+0x76>
   442a9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   442ad:	8b 08                	mov    (%rax),%ecx
   442af:	8b 45 f4             	mov    -0xc(%rbp),%eax
   442b2:	48 63 d0             	movslq %eax,%rdx
   442b5:	48 89 d0             	mov    %rdx,%rax
   442b8:	48 c1 e0 04          	shl    $0x4,%rax
   442bc:	48 29 d0             	sub    %rdx,%rax
   442bf:	48 c1 e0 04          	shl    $0x4,%rax
   442c3:	48 8d b0 30 90 05 00 	lea    0x59030(%rax),%rsi
   442ca:	48 63 d1             	movslq %ecx,%rdx
   442cd:	48 89 d0             	mov    %rdx,%rax
   442d0:	48 c1 e0 04          	shl    $0x4,%rax
   442d4:	48 29 d0             	sub    %rdx,%rax
   442d7:	48 c1 e0 04          	shl    $0x4,%rax
   442db:	48 8d 90 30 90 05 00 	lea    0x59030(%rax),%rdx
   442e2:	48 8d 46 08          	lea    0x8(%rsi),%rax
   442e6:	48 83 c2 08          	add    $0x8,%rdx
   442ea:	b9 18 00 00 00       	mov    $0x18,%ecx
   442ef:	48 89 c7             	mov    %rax,%rdi
   442f2:	48 89 d6             	mov    %rdx,%rsi
   442f5:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   442f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   442fb:	48 63 d0             	movslq %eax,%rdx
   442fe:	48 89 d0             	mov    %rdx,%rax
   44301:	48 c1 e0 04          	shl    $0x4,%rax
   44305:	48 29 d0             	sub    %rdx,%rax
   44308:	48 c1 e0 04          	shl    $0x4,%rax
   4430c:	48 05 38 90 05 00    	add    $0x59038,%rax
   44312:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   44319:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4431c:	48 63 d0             	movslq %eax,%rdx
   4431f:	48 89 d0             	mov    %rdx,%rax
   44322:	48 c1 e0 04          	shl    $0x4,%rax
   44326:	48 29 d0             	sub    %rdx,%rax
   44329:	48 c1 e0 04          	shl    $0x4,%rax
   4432d:	48 05 f8 90 05 00    	add    $0x590f8,%rax
   44333:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   44339:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4433c:	c9                   	leaveq 
   4433d:	c3                   	retq   

000000000004433e <process_page_alloc>:
   4433e:	55                   	push   %rbp
   4433f:	48 89 e5             	mov    %rsp,%rbp
   44342:	48 83 ec 20          	sub    $0x20,%rsp
   44346:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4434a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   4434e:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   44355:	00 
   44356:	77 07                	ja     4435f <process_page_alloc+0x21>
   44358:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4435d:	eb 4b                	jmp    443aa <process_page_alloc+0x6c>
   4435f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44363:	8b 00                	mov    (%rax),%eax
   44365:	89 c7                	mov    %eax,%edi
   44367:	e8 0c f5 ff ff       	callq  43878 <palloc>
   4436c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44370:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   44375:	74 2e                	je     443a5 <process_page_alloc+0x67>
   44377:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4437b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4437f:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   44386:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   4438a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44390:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44396:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4439b:	48 89 c7             	mov    %rax,%rdi
   4439e:	e8 11 d7 ff ff       	callq  41ab4 <virtual_memory_map>
   443a3:	eb 05                	jmp    443aa <process_page_alloc+0x6c>
   443a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   443aa:	c9                   	leaveq 
   443ab:	c3                   	retq   
