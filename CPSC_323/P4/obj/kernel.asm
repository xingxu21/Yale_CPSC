
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
   400be:	e8 16 04 00 00       	callq  404d9 <exception>

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
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 b4 10 00 00       	callq  4122c <hardware_init>
    pageinfo_init();
   40178:	e8 df 06 00 00       	callq  4085c <pageinfo_init>
    console_clear();
   4017d:	e8 3a 33 00 00       	callq  434bc <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 74 15 00 00       	callq  41700 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 80 0d 00 00       	mov    $0xd80,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 d0 04 00       	mov    $0x4d000,%edi
   4019b:	e8 27 2a 00 00       	callq  42bc7 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 58                	jmp    40201 <kernel+0x9a>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 01 c0             	add    %rax,%rax
   401b5:	48 01 d0             	add    %rdx,%rax
   401b8:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   401bf:	00 
   401c0:	48 01 d0             	add    %rdx,%rax
   401c3:	48 c1 e0 03          	shl    $0x3,%rax
   401c7:	48 8d 90 00 d0 04 00 	lea    0x4d000(%rax),%rdx
   401ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d1:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401d3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401d6:	48 63 d0             	movslq %eax,%rdx
   401d9:	48 89 d0             	mov    %rdx,%rax
   401dc:	48 01 c0             	add    %rax,%rax
   401df:	48 01 d0             	add    %rdx,%rax
   401e2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   401e9:	00 
   401ea:	48 01 d0             	add    %rdx,%rax
   401ed:	48 c1 e0 03          	shl    $0x3,%rax
   401f1:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   401f7:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401fd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40201:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40205:	7e a2                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "fork") == 0) {
   40207:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4020c:	74 26                	je     40234 <kernel+0xcd>
   4020e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40212:	be e0 34 04 00       	mov    $0x434e0,%esi
   40217:	48 89 c7             	mov    %rax,%rdi
   4021a:	e8 15 2a 00 00       	callq  42c34 <strcmp>
   4021f:	85 c0                	test   %eax,%eax
   40221:	75 11                	jne    40234 <kernel+0xcd>
        process_setup(1, 4);
   40223:	be 04 00 00 00       	mov    $0x4,%esi
   40228:	bf 01 00 00 00       	mov    $0x1,%edi
   4022d:	e8 5e 00 00 00       	callq  40290 <process_setup>
   40232:	eb 52                	jmp    40286 <kernel+0x11f>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40234:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40239:	74 26                	je     40261 <kernel+0xfa>
   4023b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4023f:	be e5 34 04 00       	mov    $0x434e5,%esi
   40244:	48 89 c7             	mov    %rax,%rdi
   40247:	e8 e8 29 00 00       	callq  42c34 <strcmp>
   4024c:	85 c0                	test   %eax,%eax
   4024e:	75 11                	jne    40261 <kernel+0xfa>
        process_setup(1, 5);
   40250:	be 05 00 00 00       	mov    $0x5,%esi
   40255:	bf 01 00 00 00       	mov    $0x1,%edi
   4025a:	e8 31 00 00 00       	callq  40290 <process_setup>
   4025f:	eb 25                	jmp    40286 <kernel+0x11f>
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   40261:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   40268:	eb 16                	jmp    40280 <kernel+0x119>
            process_setup(i, i - 1);
   4026a:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4026d:	8d 50 ff             	lea    -0x1(%rax),%edx
   40270:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40273:	89 d6                	mov    %edx,%esi
   40275:	89 c7                	mov    %eax,%edi
   40277:	e8 14 00 00 00       	callq  40290 <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   4027c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40280:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
   40284:	7e e4                	jle    4026a <kernel+0x103>
        }
    }

    // Switch to the first process using run()
    run(&processes[1]);
   40286:	bf d8 d0 04 00       	mov    $0x4d0d8,%edi
   4028b:	e8 6f 05 00 00       	callq  407ff <run>

0000000000040290 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   40290:	55                   	push   %rbp
   40291:	48 89 e5             	mov    %rsp,%rbp
   40294:	48 83 ec 20          	sub    $0x20,%rsp
   40298:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4029b:	89 75 e8             	mov    %esi,-0x18(%rbp)
    process_init(&processes[pid], 0);
   4029e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   402a1:	48 63 d0             	movslq %eax,%rdx
   402a4:	48 89 d0             	mov    %rdx,%rax
   402a7:	48 01 c0             	add    %rax,%rax
   402aa:	48 01 d0             	add    %rdx,%rax
   402ad:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   402b4:	00 
   402b5:	48 01 d0             	add    %rdx,%rax
   402b8:	48 c1 e0 03          	shl    $0x3,%rax
   402bc:	48 05 00 d0 04 00    	add    $0x4d000,%rax
   402c2:	be 00 00 00 00       	mov    $0x0,%esi
   402c7:	48 89 c7             	mov    %rax,%rdi
   402ca:	e8 88 1d 00 00       	callq  42057 <process_init>
    processes[pid].p_pagetable = kernel_pagetable;
   402cf:	48 8b 0d 42 5d 01 00 	mov    0x15d42(%rip),%rcx        # 56018 <kernel_pagetable>
   402d6:	8b 45 ec             	mov    -0x14(%rbp),%eax
   402d9:	48 63 d0             	movslq %eax,%rdx
   402dc:	48 89 d0             	mov    %rdx,%rax
   402df:	48 01 c0             	add    %rax,%rax
   402e2:	48 01 d0             	add    %rdx,%rax
   402e5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   402ec:	00 
   402ed:	48 01 d0             	add    %rdx,%rax
   402f0:	48 c1 e0 03          	shl    $0x3,%rax
   402f4:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   402fa:	48 89 08             	mov    %rcx,(%rax)
    ++pageinfo[PAGENUMBER(kernel_pagetable)].refcount;
   402fd:	48 8b 05 14 5d 01 00 	mov    0x15d14(%rip),%rax        # 56018 <kernel_pagetable>
   40304:	48 c1 e8 0c          	shr    $0xc,%rax
   40308:	89 c2                	mov    %eax,%edx
   4030a:	48 63 c2             	movslq %edx,%rax
   4030d:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   40314:	00 
   40315:	83 c0 01             	add    $0x1,%eax
   40318:	89 c1                	mov    %eax,%ecx
   4031a:	48 63 c2             	movslq %edx,%rax
   4031d:	88 8c 00 a1 dd 04 00 	mov    %cl,0x4dda1(%rax,%rax,1)
    int r = program_load(&processes[pid], program_number, NULL);
   40324:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40327:	48 63 d0             	movslq %eax,%rdx
   4032a:	48 89 d0             	mov    %rdx,%rax
   4032d:	48 01 c0             	add    %rax,%rax
   40330:	48 01 d0             	add    %rdx,%rax
   40333:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4033a:	00 
   4033b:	48 01 d0             	add    %rdx,%rax
   4033e:	48 c1 e0 03          	shl    $0x3,%rax
   40342:	48 8d 88 00 d0 04 00 	lea    0x4d000(%rax),%rcx
   40349:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4034c:	ba 00 00 00 00       	mov    $0x0,%edx
   40351:	89 c6                	mov    %eax,%esi
   40353:	48 89 cf             	mov    %rcx,%rdi
   40356:	e8 bc 24 00 00       	callq  42817 <program_load>
   4035b:	89 45 fc             	mov    %eax,-0x4(%rbp)
    assert(r >= 0);
   4035e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40362:	79 14                	jns    40378 <process_setup+0xe8>
   40364:	ba ee 34 04 00       	mov    $0x434ee,%edx
   40369:	be 79 00 00 00       	mov    $0x79,%esi
   4036e:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40373:	e8 6f 24 00 00       	callq  427e7 <assert_fail>
    processes[pid].p_registers.reg_rsp = PROC_START_ADDR + PROC_SIZE * pid;
   40378:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4037b:	83 c0 04             	add    $0x4,%eax
   4037e:	c1 e0 12             	shl    $0x12,%eax
   40381:	48 63 c8             	movslq %eax,%rcx
   40384:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40387:	48 63 d0             	movslq %eax,%rdx
   4038a:	48 89 d0             	mov    %rdx,%rax
   4038d:	48 01 c0             	add    %rax,%rax
   40390:	48 01 d0             	add    %rdx,%rax
   40393:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4039a:	00 
   4039b:	48 01 d0             	add    %rdx,%rax
   4039e:	48 c1 e0 03          	shl    $0x3,%rax
   403a2:	48 05 b8 d0 04 00    	add    $0x4d0b8,%rax
   403a8:	48 89 08             	mov    %rcx,(%rax)
    uintptr_t stack_page = processes[pid].p_registers.reg_rsp - PAGESIZE;
   403ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403ae:	48 63 d0             	movslq %eax,%rdx
   403b1:	48 89 d0             	mov    %rdx,%rax
   403b4:	48 01 c0             	add    %rax,%rax
   403b7:	48 01 d0             	add    %rdx,%rax
   403ba:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   403c1:	00 
   403c2:	48 01 d0             	add    %rdx,%rax
   403c5:	48 c1 e0 03          	shl    $0x3,%rax
   403c9:	48 05 b8 d0 04 00    	add    $0x4d0b8,%rax
   403cf:	48 8b 00             	mov    (%rax),%rax
   403d2:	48 2d 00 10 00 00    	sub    $0x1000,%rax
   403d8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assign_physical_page(stack_page, pid);
   403dc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403df:	0f be d0             	movsbl %al,%edx
   403e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   403e6:	89 d6                	mov    %edx,%esi
   403e8:	48 89 c7             	mov    %rax,%rdi
   403eb:	e8 75 00 00 00       	callq  40465 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, stack_page, stack_page,
   403f0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   403f3:	48 63 d0             	movslq %eax,%rdx
   403f6:	48 89 d0             	mov    %rdx,%rax
   403f9:	48 01 c0             	add    %rax,%rax
   403fc:	48 01 d0             	add    %rdx,%rax
   403ff:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40406:	00 
   40407:	48 01 d0             	add    %rdx,%rax
   4040a:	48 c1 e0 03          	shl    $0x3,%rax
   4040e:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   40414:	48 8b 00             	mov    (%rax),%rax
   40417:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4041b:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   4041f:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   40425:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4042b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40430:	48 89 c7             	mov    %rax,%rdi
   40433:	e8 3b 14 00 00       	callq  41873 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U, NULL);
    processes[pid].p_state = P_RUNNABLE;
   40438:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4043b:	48 63 d0             	movslq %eax,%rdx
   4043e:	48 89 d0             	mov    %rdx,%rax
   40441:	48 01 c0             	add    %rax,%rax
   40444:	48 01 d0             	add    %rdx,%rax
   40447:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4044e:	00 
   4044f:	48 01 d0             	add    %rdx,%rax
   40452:	48 c1 e0 03          	shl    $0x3,%rax
   40456:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   4045c:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   40462:	90                   	nop
   40463:	c9                   	leaveq 
   40464:	c3                   	retq   

0000000000040465 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   40465:	55                   	push   %rbp
   40466:	48 89 e5             	mov    %rsp,%rbp
   40469:	48 83 ec 10          	sub    $0x10,%rsp
   4046d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   40471:	89 f0                	mov    %esi,%eax
   40473:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   40476:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4047a:	25 ff 0f 00 00       	and    $0xfff,%eax
   4047f:	48 85 c0             	test   %rax,%rax
   40482:	75 20                	jne    404a4 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   40484:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4048b:	00 
   4048c:	77 16                	ja     404a4 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   4048e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40492:	48 c1 e8 0c          	shr    $0xc,%rax
   40496:	48 98                	cltq   
   40498:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   4049f:	00 
   404a0:	84 c0                	test   %al,%al
   404a2:	74 07                	je     404ab <assign_physical_page+0x46>
        return -1;
   404a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404a9:	eb 2c                	jmp    404d7 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   404ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404af:	48 c1 e8 0c          	shr    $0xc,%rax
   404b3:	48 98                	cltq   
   404b5:	c6 84 00 a1 dd 04 00 	movb   $0x1,0x4dda1(%rax,%rax,1)
   404bc:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   404bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   404c1:	48 c1 e8 0c          	shr    $0xc,%rax
   404c5:	48 98                	cltq   
   404c7:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   404cb:	88 94 00 a0 dd 04 00 	mov    %dl,0x4dda0(%rax,%rax,1)
        return 0;
   404d2:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   404d7:	c9                   	leaveq 
   404d8:	c3                   	retq   

00000000000404d9 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   404d9:	55                   	push   %rbp
   404da:	48 89 e5             	mov    %rsp,%rbp
   404dd:	48 83 ec 40          	sub    $0x40,%rsp
   404e1:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   404e5:	48 8b 05 24 5b 01 00 	mov    0x15b24(%rip),%rax        # 56010 <current>
   404ec:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   404f0:	48 83 c0 08          	add    $0x8,%rax
   404f4:	48 89 d6             	mov    %rdx,%rsi
   404f7:	ba 18 00 00 00       	mov    $0x18,%edx
   404fc:	48 89 c7             	mov    %rax,%rdi
   404ff:	48 89 d1             	mov    %rdx,%rcx
   40502:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   40505:	48 8b 05 0c 5b 01 00 	mov    0x15b0c(%rip),%rax        # 56018 <kernel_pagetable>
   4050c:	48 89 c7             	mov    %rax,%rdi
   4050f:	e8 4d 18 00 00       	callq  41d61 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   40514:	8b 05 e2 8a 07 00    	mov    0x78ae2(%rip),%eax        # b8ffc <cursorpos>
   4051a:	89 c7                	mov    %eax,%edi
   4051c:	e8 f5 1b 00 00       	callq  42116 <console_show_cursor>
    if (reg->reg_intno != INT_PAGEFAULT || (reg->reg_err & PFERR_USER)) {
   40521:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40525:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4052c:	48 83 f8 0e          	cmp    $0xe,%rax
   40530:	75 13                	jne    40545 <exception+0x6c>
   40532:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40536:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4053d:	83 e0 04             	and    $0x4,%eax
   40540:	48 85 c0             	test   %rax,%rax
   40543:	74 0f                	je     40554 <exception+0x7b>
        check_virtual_memory();
   40545:	e8 bd 06 00 00       	callq  40c07 <check_virtual_memory>
        memshow_physical();
   4054a:	e8 66 08 00 00       	callq  40db5 <memshow_physical>
        memshow_virtual_animate();
   4054f:	e8 49 0b 00 00       	callq  4109d <memshow_virtual_animate>
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40554:	e8 98 20 00 00       	callq  425f1 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40559:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4055d:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40564:	48 83 e8 0e          	sub    $0xe,%rax
   40568:	48 83 f8 25          	cmp    $0x25,%rax
   4056c:	0f 87 bb 01 00 00    	ja     4072d <exception+0x254>
   40572:	48 8b 04 c5 b0 35 04 	mov    0x435b0(,%rax,8),%rax
   40579:	00 
   4057a:	ff e0                	jmpq   *%rax

    case INT_SYS_PANIC:
        panic(NULL);
   4057c:	bf 00 00 00 00       	mov    $0x0,%edi
   40581:	b8 00 00 00 00       	mov    $0x0,%eax
   40586:	e8 7c 21 00 00       	callq  42707 <panic>
        break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   4058b:	48 8b 05 7e 5a 01 00 	mov    0x15a7e(%rip),%rax        # 56010 <current>
   40592:	8b 10                	mov    (%rax),%edx
   40594:	48 8b 05 75 5a 01 00 	mov    0x15a75(%rip),%rax        # 56010 <current>
   4059b:	48 63 d2             	movslq %edx,%rdx
   4059e:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   405a2:	e9 a3 01 00 00       	jmpq   4074a <exception+0x271>

    case INT_SYS_YIELD:
        schedule();
   405a7:	e8 c7 01 00 00       	callq  40773 <schedule>
        break;                  /* will not be reached */
   405ac:	e9 99 01 00 00       	jmpq   4074a <exception+0x271>

    case INT_SYS_PAGE_ALLOC: {
        uintptr_t addr = current->p_registers.reg_rdi;
   405b1:	48 8b 05 58 5a 01 00 	mov    0x15a58(%rip),%rax        # 56010 <current>
   405b8:	48 8b 40 38          	mov    0x38(%rax),%rax
   405bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        int r = assign_physical_page(addr, current->p_pid);
   405c0:	48 8b 05 49 5a 01 00 	mov    0x15a49(%rip),%rax        # 56010 <current>
   405c7:	8b 00                	mov    (%rax),%eax
   405c9:	0f be d0             	movsbl %al,%edx
   405cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405d0:	89 d6                	mov    %edx,%esi
   405d2:	48 89 c7             	mov    %rax,%rdi
   405d5:	e8 8b fe ff ff       	callq  40465 <assign_physical_page>
   405da:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (r >= 0) {
   405dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   405e1:	78 2f                	js     40612 <exception+0x139>
            virtual_memory_map(current->p_pagetable, addr, addr,
   405e3:	48 8b 05 26 5a 01 00 	mov    0x15a26(%rip),%rax        # 56010 <current>
   405ea:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   405f1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   405f5:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   405f9:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   405ff:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40605:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4060a:	48 89 c7             	mov    %rax,%rdi
   4060d:	e8 61 12 00 00       	callq  41873 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U, NULL);
        }
        current->p_registers.reg_rax = r;
   40612:	48 8b 05 f7 59 01 00 	mov    0x159f7(%rip),%rax        # 56010 <current>
   40619:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4061c:	48 63 d2             	movslq %edx,%rdx
   4061f:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40623:	e9 22 01 00 00       	jmpq   4074a <exception+0x271>
    }

    case INT_TIMER:
        ++ticks;
   40628:	8b 05 52 d7 00 00    	mov    0xd752(%rip),%eax        # 4dd80 <ticks>
   4062e:	83 c0 01             	add    $0x1,%eax
   40631:	89 05 49 d7 00 00    	mov    %eax,0xd749(%rip)        # 4dd80 <ticks>
        schedule();
   40637:	e8 37 01 00 00       	callq  40773 <schedule>
        break;                  /* will not be reached */
   4063c:	e9 09 01 00 00       	jmpq   4074a <exception+0x271>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40641:	0f 20 d0             	mov    %cr2,%rax
   40644:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    return val;
   40648:	48 8b 45 d0          	mov    -0x30(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   4064c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   40650:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40654:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4065b:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   4065e:	48 85 c0             	test   %rax,%rax
   40661:	74 07                	je     4066a <exception+0x191>
   40663:	b8 fe 34 04 00       	mov    $0x434fe,%eax
   40668:	eb 05                	jmp    4066f <exception+0x196>
   4066a:	b8 04 35 04 00       	mov    $0x43504,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   4066f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   40673:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40677:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4067e:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   40681:	48 85 c0             	test   %rax,%rax
   40684:	74 07                	je     4068d <exception+0x1b4>
   40686:	b8 09 35 04 00       	mov    $0x43509,%eax
   4068b:	eb 05                	jmp    40692 <exception+0x1b9>
   4068d:	b8 1c 35 04 00       	mov    $0x4351c,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   40692:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   40696:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4069a:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   406a1:	83 e0 04             	and    $0x4,%eax
   406a4:	48 85 c0             	test   %rax,%rax
   406a7:	75 2c                	jne    406d5 <exception+0x1fc>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   406a9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   406ad:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   406b4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   406b8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   406bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   406c0:	49 89 f0             	mov    %rsi,%r8
   406c3:	48 89 c6             	mov    %rax,%rsi
   406c6:	bf 30 35 04 00       	mov    $0x43530,%edi
   406cb:	b8 00 00 00 00       	mov    $0x0,%eax
   406d0:	e8 32 20 00 00       	callq  42707 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   406d5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   406d9:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   406e0:	48 8b 05 29 59 01 00 	mov    0x15929(%rip),%rax        # 56010 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   406e7:	8b 00                	mov    (%rax),%eax
   406e9:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   406ed:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   406f1:	52                   	push   %rdx
   406f2:	ff 75 d8             	pushq  -0x28(%rbp)
   406f5:	49 89 f1             	mov    %rsi,%r9
   406f8:	49 89 c8             	mov    %rcx,%r8
   406fb:	89 c1                	mov    %eax,%ecx
   406fd:	ba 60 35 04 00       	mov    $0x43560,%edx
   40702:	be 00 0c 00 00       	mov    $0xc00,%esi
   40707:	bf 80 07 00 00       	mov    $0x780,%edi
   4070c:	b8 00 00 00 00       	mov    $0x0,%eax
   40711:	e8 ef 2c 00 00       	callq  43405 <console_printf>
   40716:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   4071a:	48 8b 05 ef 58 01 00 	mov    0x158ef(%rip),%rax        # 56010 <current>
   40721:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   40728:	00 00 00 
        break;
   4072b:	eb 1d                	jmp    4074a <exception+0x271>
    }

    default:
        panic("Unexpected exception %d!\n", reg->reg_intno);
   4072d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40731:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40738:	48 89 c6             	mov    %rax,%rsi
   4073b:	bf 8f 35 04 00       	mov    $0x4358f,%edi
   40740:	b8 00 00 00 00       	mov    $0x0,%eax
   40745:	e8 bd 1f 00 00       	callq  42707 <panic>

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   4074a:	48 8b 05 bf 58 01 00 	mov    0x158bf(%rip),%rax        # 56010 <current>
   40751:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40757:	83 f8 01             	cmp    $0x1,%eax
   4075a:	75 0f                	jne    4076b <exception+0x292>
        run(current);
   4075c:	48 8b 05 ad 58 01 00 	mov    0x158ad(%rip),%rax        # 56010 <current>
   40763:	48 89 c7             	mov    %rax,%rdi
   40766:	e8 94 00 00 00       	callq  407ff <run>
    } else {
        schedule();
   4076b:	e8 03 00 00 00       	callq  40773 <schedule>
    }
}
   40770:	90                   	nop
   40771:	c9                   	leaveq 
   40772:	c3                   	retq   

0000000000040773 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40773:	55                   	push   %rbp
   40774:	48 89 e5             	mov    %rsp,%rbp
   40777:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   4077b:	48 8b 05 8e 58 01 00 	mov    0x1588e(%rip),%rax        # 56010 <current>
   40782:	8b 00                	mov    (%rax),%eax
   40784:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40787:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4078a:	8d 50 01             	lea    0x1(%rax),%edx
   4078d:	89 d0                	mov    %edx,%eax
   4078f:	c1 f8 1f             	sar    $0x1f,%eax
   40792:	c1 e8 1c             	shr    $0x1c,%eax
   40795:	01 c2                	add    %eax,%edx
   40797:	83 e2 0f             	and    $0xf,%edx
   4079a:	29 c2                	sub    %eax,%edx
   4079c:	89 d0                	mov    %edx,%eax
   4079e:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   407a1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407a4:	48 63 d0             	movslq %eax,%rdx
   407a7:	48 89 d0             	mov    %rdx,%rax
   407aa:	48 01 c0             	add    %rax,%rax
   407ad:	48 01 d0             	add    %rdx,%rax
   407b0:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   407b7:	00 
   407b8:	48 01 d0             	add    %rdx,%rax
   407bb:	48 c1 e0 03          	shl    $0x3,%rax
   407bf:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   407c5:	8b 00                	mov    (%rax),%eax
   407c7:	83 f8 01             	cmp    $0x1,%eax
   407ca:	75 2c                	jne    407f8 <schedule+0x85>
            run(&processes[pid]);
   407cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   407cf:	48 63 d0             	movslq %eax,%rdx
   407d2:	48 89 d0             	mov    %rdx,%rax
   407d5:	48 01 c0             	add    %rax,%rax
   407d8:	48 01 d0             	add    %rdx,%rax
   407db:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   407e2:	00 
   407e3:	48 01 d0             	add    %rdx,%rax
   407e6:	48 c1 e0 03          	shl    $0x3,%rax
   407ea:	48 05 00 d0 04 00    	add    $0x4d000,%rax
   407f0:	48 89 c7             	mov    %rax,%rdi
   407f3:	e8 07 00 00 00       	callq  407ff <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   407f8:	e8 f4 1d 00 00       	callq  425f1 <check_keyboard>
        pid = (pid + 1) % NPROC;
   407fd:	eb 88                	jmp    40787 <schedule+0x14>

00000000000407ff <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   407ff:	55                   	push   %rbp
   40800:	48 89 e5             	mov    %rsp,%rbp
   40803:	48 83 ec 10          	sub    $0x10,%rsp
   40807:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   4080b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4080f:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   40815:	83 f8 01             	cmp    $0x1,%eax
   40818:	74 14                	je     4082e <run+0x2f>
   4081a:	ba e0 36 04 00       	mov    $0x436e0,%edx
   4081f:	be 11 01 00 00       	mov    $0x111,%esi
   40824:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40829:	e8 b9 1f 00 00       	callq  427e7 <assert_fail>
    current = p;
   4082e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40832:	48 89 05 d7 57 01 00 	mov    %rax,0x157d7(%rip)        # 56010 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40839:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4083d:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40844:	48 89 c7             	mov    %rax,%rdi
   40847:	e8 15 15 00 00       	callq  41d61 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   4084c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40850:	48 83 c0 08          	add    $0x8,%rax
   40854:	48 89 c7             	mov    %rax,%rdi
   40857:	e8 67 f8 ff ff       	callq  400c3 <exception_return>

000000000004085c <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   4085c:	55                   	push   %rbp
   4085d:	48 89 e5             	mov    %rsp,%rbp
   40860:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40864:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   4086b:	00 
   4086c:	e9 81 00 00 00       	jmpq   408f2 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40871:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40875:	48 89 c7             	mov    %rax,%rdi
   40878:	e8 15 16 00 00       	callq  41e92 <physical_memory_isreserved>
   4087d:	85 c0                	test   %eax,%eax
   4087f:	74 09                	je     4088a <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40881:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40888:	eb 2f                	jmp    408b9 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   4088a:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40891:	00 
   40892:	76 0b                	jbe    4089f <pageinfo_init+0x43>
   40894:	b8 20 60 05 00       	mov    $0x56020,%eax
   40899:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4089d:	72 0a                	jb     408a9 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   4089f:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   408a6:	00 
   408a7:	75 09                	jne    408b2 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   408a9:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   408b0:	eb 07                	jmp    408b9 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   408b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   408b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   408bd:	48 c1 e8 0c          	shr    $0xc,%rax
   408c1:	89 c1                	mov    %eax,%ecx
   408c3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   408c6:	89 c2                	mov    %eax,%edx
   408c8:	48 63 c1             	movslq %ecx,%rax
   408cb:	88 94 00 a0 dd 04 00 	mov    %dl,0x4dda0(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   408d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   408d6:	0f 95 c2             	setne  %dl
   408d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   408dd:	48 c1 e8 0c          	shr    $0xc,%rax
   408e1:	48 98                	cltq   
   408e3:	88 94 00 a1 dd 04 00 	mov    %dl,0x4dda1(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   408ea:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   408f1:	00 
   408f2:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   408f9:	00 
   408fa:	0f 86 71 ff ff ff    	jbe    40871 <pageinfo_init+0x15>
    }
}
   40900:	90                   	nop
   40901:	90                   	nop
   40902:	c9                   	leaveq 
   40903:	c3                   	retq   

0000000000040904 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40904:	55                   	push   %rbp
   40905:	48 89 e5             	mov    %rsp,%rbp
   40908:	48 83 ec 50          	sub    $0x50,%rsp
   4090c:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40910:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40914:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4091a:	48 89 c2             	mov    %rax,%rdx
   4091d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40921:	48 39 c2             	cmp    %rax,%rdx
   40924:	74 14                	je     4093a <check_page_table_mappings+0x36>
   40926:	ba 00 37 04 00       	mov    $0x43700,%edx
   4092b:	be 3b 01 00 00       	mov    $0x13b,%esi
   40930:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40935:	e8 ad 1e 00 00       	callq  427e7 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4093a:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40941:	00 
   40942:	e9 9a 00 00 00       	jmpq   409e1 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40947:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   4094b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4094f:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40953:	48 89 ce             	mov    %rcx,%rsi
   40956:	48 89 c7             	mov    %rax,%rdi
   40959:	e8 0c 13 00 00       	callq  41c6a <virtual_memory_lookup>
        if (vam.pa != va) {
   4095e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40962:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40966:	74 27                	je     4098f <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40968:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4096c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40970:	49 89 d0             	mov    %rdx,%r8
   40973:	48 89 c1             	mov    %rax,%rcx
   40976:	ba 1f 37 04 00       	mov    $0x4371f,%edx
   4097b:	be 00 c0 00 00       	mov    $0xc000,%esi
   40980:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40985:	b8 00 00 00 00       	mov    $0x0,%eax
   4098a:	e8 76 2a 00 00       	callq  43405 <console_printf>
        }
        assert(vam.pa == va);
   4098f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40993:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40997:	74 14                	je     409ad <check_page_table_mappings+0xa9>
   40999:	ba 29 37 04 00       	mov    $0x43729,%edx
   4099e:	be 44 01 00 00       	mov    $0x144,%esi
   409a3:	bf f5 34 04 00       	mov    $0x434f5,%edi
   409a8:	e8 3a 1e 00 00       	callq  427e7 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   409ad:	b8 00 50 04 00       	mov    $0x45000,%eax
   409b2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   409b6:	72 21                	jb     409d9 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   409b8:	8b 45 d0             	mov    -0x30(%rbp),%eax
   409bb:	48 98                	cltq   
   409bd:	83 e0 02             	and    $0x2,%eax
   409c0:	48 85 c0             	test   %rax,%rax
   409c3:	75 14                	jne    409d9 <check_page_table_mappings+0xd5>
   409c5:	ba 36 37 04 00       	mov    $0x43736,%edx
   409ca:	be 46 01 00 00       	mov    $0x146,%esi
   409cf:	bf f5 34 04 00       	mov    $0x434f5,%edi
   409d4:	e8 0e 1e 00 00       	callq  427e7 <assert_fail>
         va += PAGESIZE) {
   409d9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   409e0:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   409e1:	b8 20 60 05 00       	mov    $0x56020,%eax
   409e6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   409ea:	0f 82 57 ff ff ff    	jb     40947 <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   409f0:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   409f7:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   409f8:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   409fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40a00:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40a04:	48 89 ce             	mov    %rcx,%rsi
   40a07:	48 89 c7             	mov    %rax,%rdi
   40a0a:	e8 5b 12 00 00       	callq  41c6a <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40a0f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40a13:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40a17:	74 14                	je     40a2d <check_page_table_mappings+0x129>
   40a19:	ba 47 37 04 00       	mov    $0x43747,%edx
   40a1e:	be 4d 01 00 00       	mov    $0x14d,%esi
   40a23:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40a28:	e8 ba 1d 00 00       	callq  427e7 <assert_fail>
    assert(vam.perm & PTE_W);
   40a2d:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40a30:	48 98                	cltq   
   40a32:	83 e0 02             	and    $0x2,%eax
   40a35:	48 85 c0             	test   %rax,%rax
   40a38:	75 14                	jne    40a4e <check_page_table_mappings+0x14a>
   40a3a:	ba 36 37 04 00       	mov    $0x43736,%edx
   40a3f:	be 4e 01 00 00       	mov    $0x14e,%esi
   40a44:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40a49:	e8 99 1d 00 00       	callq  427e7 <assert_fail>
}
   40a4e:	90                   	nop
   40a4f:	c9                   	leaveq 
   40a50:	c3                   	retq   

0000000000040a51 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40a51:	55                   	push   %rbp
   40a52:	48 89 e5             	mov    %rsp,%rbp
   40a55:	48 83 ec 20          	sub    $0x20,%rsp
   40a59:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40a5d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40a60:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40a63:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40a66:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40a6d:	48 8b 05 a4 55 01 00 	mov    0x155a4(%rip),%rax        # 56018 <kernel_pagetable>
   40a74:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40a78:	75 7b                	jne    40af5 <check_page_table_ownership+0xa4>
        owner = PO_KERNEL;
   40a7a:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40a81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40a88:	eb 65                	jmp    40aef <check_page_table_ownership+0x9e>
            if (processes[xpid].p_state != P_FREE
   40a8a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40a8d:	48 63 d0             	movslq %eax,%rdx
   40a90:	48 89 d0             	mov    %rdx,%rax
   40a93:	48 01 c0             	add    %rax,%rax
   40a96:	48 01 d0             	add    %rdx,%rax
   40a99:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40aa0:	00 
   40aa1:	48 01 d0             	add    %rdx,%rax
   40aa4:	48 c1 e0 03          	shl    $0x3,%rax
   40aa8:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   40aae:	8b 00                	mov    (%rax),%eax
   40ab0:	85 c0                	test   %eax,%eax
   40ab2:	74 37                	je     40aeb <check_page_table_ownership+0x9a>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40ab4:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ab7:	48 63 d0             	movslq %eax,%rdx
   40aba:	48 89 d0             	mov    %rdx,%rax
   40abd:	48 01 c0             	add    %rax,%rax
   40ac0:	48 01 d0             	add    %rdx,%rax
   40ac3:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40aca:	00 
   40acb:	48 01 d0             	add    %rdx,%rax
   40ace:	48 c1 e0 03          	shl    $0x3,%rax
   40ad2:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   40ad8:	48 8b 10             	mov    (%rax),%rdx
   40adb:	48 8b 05 36 55 01 00 	mov    0x15536(%rip),%rax        # 56018 <kernel_pagetable>
   40ae2:	48 39 c2             	cmp    %rax,%rdx
   40ae5:	75 04                	jne    40aeb <check_page_table_ownership+0x9a>
                ++expected_refcount;
   40ae7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40aeb:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40aef:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40af3:	7e 95                	jle    40a8a <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40af5:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40af8:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40afb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40aff:	be 00 00 00 00       	mov    $0x0,%esi
   40b04:	48 89 c7             	mov    %rax,%rdi
   40b07:	e8 03 00 00 00       	callq  40b0f <check_page_table_ownership_level>
}
   40b0c:	90                   	nop
   40b0d:	c9                   	leaveq 
   40b0e:	c3                   	retq   

0000000000040b0f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40b0f:	55                   	push   %rbp
   40b10:	48 89 e5             	mov    %rsp,%rbp
   40b13:	48 83 ec 30          	sub    $0x30,%rsp
   40b17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40b1b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40b1e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40b21:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40b24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b28:	48 c1 e8 0c          	shr    $0xc,%rax
   40b2c:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40b31:	7e 14                	jle    40b47 <check_page_table_ownership_level+0x38>
   40b33:	ba 58 37 04 00       	mov    $0x43758,%edx
   40b38:	be 6b 01 00 00       	mov    $0x16b,%esi
   40b3d:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40b42:	e8 a0 1c 00 00       	callq  427e7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40b47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b4b:	48 c1 e8 0c          	shr    $0xc,%rax
   40b4f:	48 98                	cltq   
   40b51:	0f b6 84 00 a0 dd 04 	movzbl 0x4dda0(%rax,%rax,1),%eax
   40b58:	00 
   40b59:	0f be c0             	movsbl %al,%eax
   40b5c:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40b5f:	74 14                	je     40b75 <check_page_table_ownership_level+0x66>
   40b61:	ba 70 37 04 00       	mov    $0x43770,%edx
   40b66:	be 6c 01 00 00       	mov    $0x16c,%esi
   40b6b:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40b70:	e8 72 1c 00 00       	callq  427e7 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40b75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b79:	48 c1 e8 0c          	shr    $0xc,%rax
   40b7d:	48 98                	cltq   
   40b7f:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   40b86:	00 
   40b87:	0f be c0             	movsbl %al,%eax
   40b8a:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40b8d:	74 14                	je     40ba3 <check_page_table_ownership_level+0x94>
   40b8f:	ba 98 37 04 00       	mov    $0x43798,%edx
   40b94:	be 6d 01 00 00       	mov    $0x16d,%esi
   40b99:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40b9e:	e8 44 1c 00 00       	callq  427e7 <assert_fail>
    if (level < 3) {
   40ba3:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40ba7:	7f 5b                	jg     40c04 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40ba9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40bb0:	eb 49                	jmp    40bfb <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40bb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40bb6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40bb9:	48 63 d2             	movslq %edx,%rdx
   40bbc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40bc0:	48 85 c0             	test   %rax,%rax
   40bc3:	74 32                	je     40bf7 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   40bc5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40bc9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40bcc:	48 63 d2             	movslq %edx,%rdx
   40bcf:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   40bd3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   40bd9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   40bdd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40be0:	8d 70 01             	lea    0x1(%rax),%esi
   40be3:	8b 55 e0             	mov    -0x20(%rbp),%edx
   40be6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   40bea:	b9 01 00 00 00       	mov    $0x1,%ecx
   40bef:	48 89 c7             	mov    %rax,%rdi
   40bf2:	e8 18 ff ff ff       	callq  40b0f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40bf7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40bfb:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40c02:	7e ae                	jle    40bb2 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   40c04:	90                   	nop
   40c05:	c9                   	leaveq 
   40c06:	c3                   	retq   

0000000000040c07 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   40c07:	55                   	push   %rbp
   40c08:	48 89 e5             	mov    %rsp,%rbp
   40c0b:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   40c0f:	8b 05 b3 c4 00 00    	mov    0xc4b3(%rip),%eax        # 4d0c8 <processes+0xc8>
   40c15:	85 c0                	test   %eax,%eax
   40c17:	74 14                	je     40c2d <check_virtual_memory+0x26>
   40c19:	ba c8 37 04 00       	mov    $0x437c8,%edx
   40c1e:	be 80 01 00 00       	mov    $0x180,%esi
   40c23:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40c28:	e8 ba 1b 00 00       	callq  427e7 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   40c2d:	48 8b 05 e4 53 01 00 	mov    0x153e4(%rip),%rax        # 56018 <kernel_pagetable>
   40c34:	48 89 c7             	mov    %rax,%rdi
   40c37:	e8 c8 fc ff ff       	callq  40904 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   40c3c:	48 8b 05 d5 53 01 00 	mov    0x153d5(%rip),%rax        # 56018 <kernel_pagetable>
   40c43:	be ff ff ff ff       	mov    $0xffffffff,%esi
   40c48:	48 89 c7             	mov    %rax,%rdi
   40c4b:	e8 01 fe ff ff       	callq  40a51 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   40c50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40c57:	e9 c8 00 00 00       	jmpq   40d24 <check_virtual_memory+0x11d>
        if (processes[pid].p_state != P_FREE
   40c5c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c5f:	48 63 d0             	movslq %eax,%rdx
   40c62:	48 89 d0             	mov    %rdx,%rax
   40c65:	48 01 c0             	add    %rax,%rax
   40c68:	48 01 d0             	add    %rdx,%rax
   40c6b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40c72:	00 
   40c73:	48 01 d0             	add    %rdx,%rax
   40c76:	48 c1 e0 03          	shl    $0x3,%rax
   40c7a:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   40c80:	8b 00                	mov    (%rax),%eax
   40c82:	85 c0                	test   %eax,%eax
   40c84:	0f 84 96 00 00 00    	je     40d20 <check_virtual_memory+0x119>
            && processes[pid].p_pagetable != kernel_pagetable) {
   40c8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c8d:	48 63 d0             	movslq %eax,%rdx
   40c90:	48 89 d0             	mov    %rdx,%rax
   40c93:	48 01 c0             	add    %rax,%rax
   40c96:	48 01 d0             	add    %rdx,%rax
   40c99:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40ca0:	00 
   40ca1:	48 01 d0             	add    %rdx,%rax
   40ca4:	48 c1 e0 03          	shl    $0x3,%rax
   40ca8:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   40cae:	48 8b 10             	mov    (%rax),%rdx
   40cb1:	48 8b 05 60 53 01 00 	mov    0x15360(%rip),%rax        # 56018 <kernel_pagetable>
   40cb8:	48 39 c2             	cmp    %rax,%rdx
   40cbb:	74 63                	je     40d20 <check_virtual_memory+0x119>
            check_page_table_mappings(processes[pid].p_pagetable);
   40cbd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cc0:	48 63 d0             	movslq %eax,%rdx
   40cc3:	48 89 d0             	mov    %rdx,%rax
   40cc6:	48 01 c0             	add    %rax,%rax
   40cc9:	48 01 d0             	add    %rdx,%rax
   40ccc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40cd3:	00 
   40cd4:	48 01 d0             	add    %rdx,%rax
   40cd7:	48 c1 e0 03          	shl    $0x3,%rax
   40cdb:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   40ce1:	48 8b 00             	mov    (%rax),%rax
   40ce4:	48 89 c7             	mov    %rax,%rdi
   40ce7:	e8 18 fc ff ff       	callq  40904 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   40cec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40cef:	48 63 d0             	movslq %eax,%rdx
   40cf2:	48 89 d0             	mov    %rdx,%rax
   40cf5:	48 01 c0             	add    %rax,%rax
   40cf8:	48 01 d0             	add    %rdx,%rax
   40cfb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40d02:	00 
   40d03:	48 01 d0             	add    %rdx,%rax
   40d06:	48 c1 e0 03          	shl    $0x3,%rax
   40d0a:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   40d10:	48 8b 00             	mov    (%rax),%rax
   40d13:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40d16:	89 d6                	mov    %edx,%esi
   40d18:	48 89 c7             	mov    %rax,%rdi
   40d1b:	e8 31 fd ff ff       	callq  40a51 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   40d20:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40d24:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   40d28:	0f 8e 2e ff ff ff    	jle    40c5c <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40d2e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40d35:	eb 71                	jmp    40da8 <check_virtual_memory+0x1a1>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   40d37:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d3a:	48 98                	cltq   
   40d3c:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   40d43:	00 
   40d44:	84 c0                	test   %al,%al
   40d46:	7e 5c                	jle    40da4 <check_virtual_memory+0x19d>
   40d48:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d4b:	48 98                	cltq   
   40d4d:	0f b6 84 00 a0 dd 04 	movzbl 0x4dda0(%rax,%rax,1),%eax
   40d54:	00 
   40d55:	84 c0                	test   %al,%al
   40d57:	78 4b                	js     40da4 <check_virtual_memory+0x19d>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   40d59:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40d5c:	48 98                	cltq   
   40d5e:	0f b6 84 00 a0 dd 04 	movzbl 0x4dda0(%rax,%rax,1),%eax
   40d65:	00 
   40d66:	0f be c0             	movsbl %al,%eax
   40d69:	48 63 d0             	movslq %eax,%rdx
   40d6c:	48 89 d0             	mov    %rdx,%rax
   40d6f:	48 01 c0             	add    %rax,%rax
   40d72:	48 01 d0             	add    %rdx,%rax
   40d75:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   40d7c:	00 
   40d7d:	48 01 d0             	add    %rdx,%rax
   40d80:	48 c1 e0 03          	shl    $0x3,%rax
   40d84:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   40d8a:	8b 00                	mov    (%rax),%eax
   40d8c:	85 c0                	test   %eax,%eax
   40d8e:	75 14                	jne    40da4 <check_virtual_memory+0x19d>
   40d90:	ba e8 37 04 00       	mov    $0x437e8,%edx
   40d95:	be 97 01 00 00       	mov    $0x197,%esi
   40d9a:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40d9f:	e8 43 1a 00 00       	callq  427e7 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40da4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40da8:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   40daf:	7e 86                	jle    40d37 <check_virtual_memory+0x130>
        }
    }
}
   40db1:	90                   	nop
   40db2:	90                   	nop
   40db3:	c9                   	leaveq 
   40db4:	c3                   	retq   

0000000000040db5 <memshow_physical>:
    '6' | 0x0C00, '7' | 0x0A00, '8' | 0x0900, '9' | 0x0E00,
    'A' | 0x0F00, 'B' | 0x0C00, 'C' | 0x0A00, 'D' | 0x0900,
    'E' | 0x0E00, 'F' | 0x0F00
};

void memshow_physical(void) {
   40db5:	55                   	push   %rbp
   40db6:	48 89 e5             	mov    %rsp,%rbp
   40db9:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   40dbd:	ba 44 38 04 00       	mov    $0x43844,%edx
   40dc2:	be 00 0f 00 00       	mov    $0xf00,%esi
   40dc7:	bf 20 00 00 00       	mov    $0x20,%edi
   40dcc:	b8 00 00 00 00       	mov    $0x0,%eax
   40dd1:	e8 2f 26 00 00       	callq  43405 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40dd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40ddd:	e9 de 00 00 00       	jmpq   40ec0 <memshow_physical+0x10b>
        if (pn % 64 == 0) {
   40de2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40de5:	83 e0 3f             	and    $0x3f,%eax
   40de8:	85 c0                	test   %eax,%eax
   40dea:	75 3c                	jne    40e28 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   40dec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40def:	c1 e0 0c             	shl    $0xc,%eax
   40df2:	89 c1                	mov    %eax,%ecx
   40df4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40df7:	8d 50 3f             	lea    0x3f(%rax),%edx
   40dfa:	85 c0                	test   %eax,%eax
   40dfc:	0f 48 c2             	cmovs  %edx,%eax
   40dff:	c1 f8 06             	sar    $0x6,%eax
   40e02:	8d 50 01             	lea    0x1(%rax),%edx
   40e05:	89 d0                	mov    %edx,%eax
   40e07:	c1 e0 02             	shl    $0x2,%eax
   40e0a:	01 d0                	add    %edx,%eax
   40e0c:	c1 e0 04             	shl    $0x4,%eax
   40e0f:	83 c0 03             	add    $0x3,%eax
   40e12:	ba 54 38 04 00       	mov    $0x43854,%edx
   40e17:	be 00 0f 00 00       	mov    $0xf00,%esi
   40e1c:	89 c7                	mov    %eax,%edi
   40e1e:	b8 00 00 00 00       	mov    $0x0,%eax
   40e23:	e8 dd 25 00 00       	callq  43405 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   40e28:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e2b:	48 98                	cltq   
   40e2d:	0f b6 84 00 a0 dd 04 	movzbl 0x4dda0(%rax,%rax,1),%eax
   40e34:	00 
   40e35:	0f be c0             	movsbl %al,%eax
   40e38:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   40e3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e3e:	48 98                	cltq   
   40e40:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   40e47:	00 
   40e48:	84 c0                	test   %al,%al
   40e4a:	75 07                	jne    40e53 <memshow_physical+0x9e>
            owner = PO_FREE;
   40e4c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   40e53:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40e56:	83 c0 02             	add    $0x2,%eax
   40e59:	48 98                	cltq   
   40e5b:	0f b7 84 00 20 38 04 	movzwl 0x43820(%rax,%rax,1),%eax
   40e62:	00 
   40e63:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1) {
   40e67:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e6a:	48 98                	cltq   
   40e6c:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   40e73:	00 
   40e74:	3c 01                	cmp    $0x1,%al
   40e76:	7e 06                	jle    40e7e <memshow_physical+0xc9>
            color &= 0x77FF;
   40e78:	66 81 65 f6 ff 77    	andw   $0x77ff,-0xa(%rbp)
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   40e7e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e81:	8d 50 3f             	lea    0x3f(%rax),%edx
   40e84:	85 c0                	test   %eax,%eax
   40e86:	0f 48 c2             	cmovs  %edx,%eax
   40e89:	c1 f8 06             	sar    $0x6,%eax
   40e8c:	8d 50 01             	lea    0x1(%rax),%edx
   40e8f:	89 d0                	mov    %edx,%eax
   40e91:	c1 e0 02             	shl    $0x2,%eax
   40e94:	01 d0                	add    %edx,%eax
   40e96:	c1 e0 04             	shl    $0x4,%eax
   40e99:	89 c1                	mov    %eax,%ecx
   40e9b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40e9e:	99                   	cltd   
   40e9f:	c1 ea 1a             	shr    $0x1a,%edx
   40ea2:	01 d0                	add    %edx,%eax
   40ea4:	83 e0 3f             	and    $0x3f,%eax
   40ea7:	29 d0                	sub    %edx,%eax
   40ea9:	83 c0 0c             	add    $0xc,%eax
   40eac:	01 c8                	add    %ecx,%eax
   40eae:	48 98                	cltq   
   40eb0:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   40eb4:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   40ebb:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   40ebc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40ec0:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   40ec7:	0f 8e 15 ff ff ff    	jle    40de2 <memshow_physical+0x2d>
    }
}
   40ecd:	90                   	nop
   40ece:	90                   	nop
   40ecf:	c9                   	leaveq 
   40ed0:	c3                   	retq   

0000000000040ed1 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   40ed1:	55                   	push   %rbp
   40ed2:	48 89 e5             	mov    %rsp,%rbp
   40ed5:	48 83 ec 40          	sub    $0x40,%rsp
   40ed9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   40edd:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   40ee1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ee5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40eeb:	48 89 c2             	mov    %rax,%rdx
   40eee:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40ef2:	48 39 c2             	cmp    %rax,%rdx
   40ef5:	74 14                	je     40f0b <memshow_virtual+0x3a>
   40ef7:	ba 60 38 04 00       	mov    $0x43860,%edx
   40efc:	be c3 01 00 00       	mov    $0x1c3,%esi
   40f01:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40f06:	e8 dc 18 00 00       	callq  427e7 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   40f0b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   40f0f:	48 89 c1             	mov    %rax,%rcx
   40f12:	ba 8d 38 04 00       	mov    $0x4388d,%edx
   40f17:	be 00 0f 00 00       	mov    $0xf00,%esi
   40f1c:	bf 3a 03 00 00       	mov    $0x33a,%edi
   40f21:	b8 00 00 00 00       	mov    $0x0,%eax
   40f26:	e8 da 24 00 00       	callq  43405 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   40f2b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40f32:	00 
   40f33:	e9 53 01 00 00       	jmpq   4108b <memshow_virtual+0x1ba>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   40f38:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40f3c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40f40:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   40f44:	48 89 ce             	mov    %rcx,%rsi
   40f47:	48 89 c7             	mov    %rax,%rdi
   40f4a:	e8 1b 0d 00 00       	callq  41c6a <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   40f4f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f52:	85 c0                	test   %eax,%eax
   40f54:	79 0b                	jns    40f61 <memshow_virtual+0x90>
            color = ' ';
   40f56:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   40f5c:	e9 aa 00 00 00       	jmpq   4100b <memshow_virtual+0x13a>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   40f61:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40f65:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   40f6b:	76 14                	jbe    40f81 <memshow_virtual+0xb0>
   40f6d:	ba aa 38 04 00       	mov    $0x438aa,%edx
   40f72:	be cc 01 00 00       	mov    $0x1cc,%esi
   40f77:	bf f5 34 04 00       	mov    $0x434f5,%edi
   40f7c:	e8 66 18 00 00       	callq  427e7 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   40f81:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f84:	48 98                	cltq   
   40f86:	0f b6 84 00 a0 dd 04 	movzbl 0x4dda0(%rax,%rax,1),%eax
   40f8d:	00 
   40f8e:	0f be c0             	movsbl %al,%eax
   40f91:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   40f94:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40f97:	48 98                	cltq   
   40f99:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   40fa0:	00 
   40fa1:	84 c0                	test   %al,%al
   40fa3:	75 07                	jne    40fac <memshow_virtual+0xdb>
                owner = PO_FREE;
   40fa5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   40fac:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40faf:	83 c0 02             	add    $0x2,%eax
   40fb2:	48 98                	cltq   
   40fb4:	0f b7 84 00 20 38 04 	movzwl 0x43820(%rax,%rax,1),%eax
   40fbb:	00 
   40fbc:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   40fc0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40fc3:	48 98                	cltq   
   40fc5:	83 e0 04             	and    $0x4,%eax
   40fc8:	48 85 c0             	test   %rax,%rax
   40fcb:	74 27                	je     40ff4 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   40fcd:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   40fd1:	c1 e0 04             	shl    $0x4,%eax
   40fd4:	66 25 00 f0          	and    $0xf000,%ax
   40fd8:	89 c2                	mov    %eax,%edx
   40fda:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   40fde:	c1 f8 04             	sar    $0x4,%eax
   40fe1:	66 25 00 0f          	and    $0xf00,%ax
   40fe5:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   40fe7:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   40feb:	0f b6 c0             	movzbl %al,%eax
   40fee:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   40ff0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1) {
   40ff4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40ff7:	48 98                	cltq   
   40ff9:	0f b6 84 00 a1 dd 04 	movzbl 0x4dda1(%rax,%rax,1),%eax
   41000:	00 
   41001:	3c 01                	cmp    $0x1,%al
   41003:	7e 06                	jle    4100b <memshow_virtual+0x13a>
                color &= 0x77FF;
   41005:	66 81 65 f6 ff 77    	andw   $0x77ff,-0xa(%rbp)
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4100b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4100f:	48 c1 e8 0c          	shr    $0xc,%rax
   41013:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41016:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41019:	83 e0 3f             	and    $0x3f,%eax
   4101c:	85 c0                	test   %eax,%eax
   4101e:	75 34                	jne    41054 <memshow_virtual+0x183>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41020:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41023:	c1 e8 06             	shr    $0x6,%eax
   41026:	89 c2                	mov    %eax,%edx
   41028:	89 d0                	mov    %edx,%eax
   4102a:	c1 e0 02             	shl    $0x2,%eax
   4102d:	01 d0                	add    %edx,%eax
   4102f:	c1 e0 04             	shl    $0x4,%eax
   41032:	05 73 03 00 00       	add    $0x373,%eax
   41037:	89 c7                	mov    %eax,%edi
   41039:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4103d:	48 89 c1             	mov    %rax,%rcx
   41040:	ba 54 38 04 00       	mov    $0x43854,%edx
   41045:	be 00 0f 00 00       	mov    $0xf00,%esi
   4104a:	b8 00 00 00 00       	mov    $0x0,%eax
   4104f:	e8 b1 23 00 00       	callq  43405 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41054:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41057:	c1 e8 06             	shr    $0x6,%eax
   4105a:	89 c2                	mov    %eax,%edx
   4105c:	89 d0                	mov    %edx,%eax
   4105e:	c1 e0 02             	shl    $0x2,%eax
   41061:	01 d0                	add    %edx,%eax
   41063:	c1 e0 04             	shl    $0x4,%eax
   41066:	89 c2                	mov    %eax,%edx
   41068:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4106b:	83 e0 3f             	and    $0x3f,%eax
   4106e:	01 d0                	add    %edx,%eax
   41070:	05 7c 03 00 00       	add    $0x37c,%eax
   41075:	89 c2                	mov    %eax,%edx
   41077:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4107b:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41082:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41083:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4108a:	00 
   4108b:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41092:	00 
   41093:	0f 86 9f fe ff ff    	jbe    40f38 <memshow_virtual+0x67>
    }
}
   41099:	90                   	nop
   4109a:	90                   	nop
   4109b:	c9                   	leaveq 
   4109c:	c3                   	retq   

000000000004109d <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   4109d:	55                   	push   %rbp
   4109e:	48 89 e5             	mov    %rsp,%rbp
   410a1:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   410a5:	8b 05 f5 d0 00 00    	mov    0xd0f5(%rip),%eax        # 4e1a0 <last_ticks.1630>
   410ab:	85 c0                	test   %eax,%eax
   410ad:	74 15                	je     410c4 <memshow_virtual_animate+0x27>
   410af:	8b 15 cb cc 00 00    	mov    0xcccb(%rip),%edx        # 4dd80 <ticks>
   410b5:	8b 05 e5 d0 00 00    	mov    0xd0e5(%rip),%eax        # 4e1a0 <last_ticks.1630>
   410bb:	29 c2                	sub    %eax,%edx
   410bd:	89 d0                	mov    %edx,%eax
   410bf:	83 f8 31             	cmp    $0x31,%eax
   410c2:	76 2c                	jbe    410f0 <memshow_virtual_animate+0x53>
        last_ticks = ticks;
   410c4:	8b 05 b6 cc 00 00    	mov    0xccb6(%rip),%eax        # 4dd80 <ticks>
   410ca:	89 05 d0 d0 00 00    	mov    %eax,0xd0d0(%rip)        # 4e1a0 <last_ticks.1630>
        ++showing;
   410d0:	8b 05 2a 3f 00 00    	mov    0x3f2a(%rip),%eax        # 45000 <start_data>
   410d6:	83 c0 01             	add    $0x1,%eax
   410d9:	89 05 21 3f 00 00    	mov    %eax,0x3f21(%rip)        # 45000 <start_data>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   410df:	eb 0f                	jmp    410f0 <memshow_virtual_animate+0x53>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   410e1:	8b 05 19 3f 00 00    	mov    0x3f19(%rip),%eax        # 45000 <start_data>
   410e7:	83 c0 01             	add    $0x1,%eax
   410ea:	89 05 10 3f 00 00    	mov    %eax,0x3f10(%rip)        # 45000 <start_data>
    while (showing <= 2*NPROC
   410f0:	8b 05 0a 3f 00 00    	mov    0x3f0a(%rip),%eax        # 45000 <start_data>
   410f6:	83 f8 20             	cmp    $0x20,%eax
   410f9:	7f 38                	jg     41133 <memshow_virtual_animate+0x96>
           && processes[showing % NPROC].p_state == P_FREE) {
   410fb:	8b 05 ff 3e 00 00    	mov    0x3eff(%rip),%eax        # 45000 <start_data>
   41101:	99                   	cltd   
   41102:	c1 ea 1c             	shr    $0x1c,%edx
   41105:	01 d0                	add    %edx,%eax
   41107:	83 e0 0f             	and    $0xf,%eax
   4110a:	29 d0                	sub    %edx,%eax
   4110c:	48 63 d0             	movslq %eax,%rdx
   4110f:	48 89 d0             	mov    %rdx,%rax
   41112:	48 01 c0             	add    %rax,%rax
   41115:	48 01 d0             	add    %rdx,%rax
   41118:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   4111f:	00 
   41120:	48 01 d0             	add    %rdx,%rax
   41123:	48 c1 e0 03          	shl    $0x3,%rax
   41127:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   4112d:	8b 00                	mov    (%rax),%eax
   4112f:	85 c0                	test   %eax,%eax
   41131:	74 ae                	je     410e1 <memshow_virtual_animate+0x44>
    }
    showing = showing % NPROC;
   41133:	8b 05 c7 3e 00 00    	mov    0x3ec7(%rip),%eax        # 45000 <start_data>
   41139:	99                   	cltd   
   4113a:	c1 ea 1c             	shr    $0x1c,%edx
   4113d:	01 d0                	add    %edx,%eax
   4113f:	83 e0 0f             	and    $0xf,%eax
   41142:	29 d0                	sub    %edx,%eax
   41144:	89 05 b6 3e 00 00    	mov    %eax,0x3eb6(%rip)        # 45000 <start_data>

    if (processes[showing].p_state != P_FREE) {
   4114a:	8b 05 b0 3e 00 00    	mov    0x3eb0(%rip),%eax        # 45000 <start_data>
   41150:	48 63 d0             	movslq %eax,%rdx
   41153:	48 89 d0             	mov    %rdx,%rax
   41156:	48 01 c0             	add    %rax,%rax
   41159:	48 01 d0             	add    %rdx,%rax
   4115c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   41163:	00 
   41164:	48 01 d0             	add    %rdx,%rax
   41167:	48 c1 e0 03          	shl    $0x3,%rax
   4116b:	48 05 c8 d0 04 00    	add    $0x4d0c8,%rax
   41171:	8b 00                	mov    (%rax),%eax
   41173:	85 c0                	test   %eax,%eax
   41175:	74 5c                	je     411d3 <memshow_virtual_animate+0x136>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41177:	8b 15 83 3e 00 00    	mov    0x3e83(%rip),%edx        # 45000 <start_data>
   4117d:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41181:	89 d1                	mov    %edx,%ecx
   41183:	ba c4 38 04 00       	mov    $0x438c4,%edx
   41188:	be 04 00 00 00       	mov    $0x4,%esi
   4118d:	48 89 c7             	mov    %rax,%rdi
   41190:	b8 00 00 00 00       	mov    $0x0,%eax
   41195:	e8 ec 22 00 00       	callq  43486 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   4119a:	8b 05 60 3e 00 00    	mov    0x3e60(%rip),%eax        # 45000 <start_data>
   411a0:	48 63 d0             	movslq %eax,%rdx
   411a3:	48 89 d0             	mov    %rdx,%rax
   411a6:	48 01 c0             	add    %rax,%rax
   411a9:	48 01 d0             	add    %rdx,%rax
   411ac:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
   411b3:	00 
   411b4:	48 01 d0             	add    %rdx,%rax
   411b7:	48 c1 e0 03          	shl    $0x3,%rax
   411bb:	48 05 d0 d0 04 00    	add    $0x4d0d0,%rax
   411c1:	48 8b 00             	mov    (%rax),%rax
   411c4:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   411c8:	48 89 d6             	mov    %rdx,%rsi
   411cb:	48 89 c7             	mov    %rax,%rdi
   411ce:	e8 fe fc ff ff       	callq  40ed1 <memshow_virtual>
    }
}
   411d3:	90                   	nop
   411d4:	c9                   	leaveq 
   411d5:	c3                   	retq   

00000000000411d6 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   411d6:	55                   	push   %rbp
   411d7:	48 89 e5             	mov    %rsp,%rbp
   411da:	48 83 ec 10          	sub    $0x10,%rsp
   411de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   411e2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   411e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   411e9:	78 06                	js     411f1 <pageindex+0x1b>
   411eb:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   411ef:	7e 14                	jle    41205 <pageindex+0x2f>
   411f1:	ba e0 38 04 00       	mov    $0x438e0,%edx
   411f6:	be 1e 00 00 00       	mov    $0x1e,%esi
   411fb:	bf f9 38 04 00       	mov    $0x438f9,%edi
   41200:	e8 e2 15 00 00       	callq  427e7 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   41205:	b8 03 00 00 00       	mov    $0x3,%eax
   4120a:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4120d:	89 c2                	mov    %eax,%edx
   4120f:	89 d0                	mov    %edx,%eax
   41211:	c1 e0 03             	shl    $0x3,%eax
   41214:	01 d0                	add    %edx,%eax
   41216:	83 c0 0c             	add    $0xc,%eax
   41219:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4121d:	89 c1                	mov    %eax,%ecx
   4121f:	48 d3 ea             	shr    %cl,%rdx
   41222:	48 89 d0             	mov    %rdx,%rax
   41225:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4122a:	c9                   	leaveq 
   4122b:	c3                   	retq   

000000000004122c <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
static void virtual_memory_init(void);

void hardware_init(void) {
   4122c:	55                   	push   %rbp
   4122d:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41230:	e8 4f 01 00 00       	callq  41384 <segments_init>
    interrupt_init();
   41235:	e8 b8 03 00 00       	callq  415f2 <interrupt_init>
    virtual_memory_init();
   4123a:	e8 8d 05 00 00       	callq  417cc <virtual_memory_init>
}
   4123f:	90                   	nop
   41240:	5d                   	pop    %rbp
   41241:	c3                   	retq   

0000000000041242 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41242:	55                   	push   %rbp
   41243:	48 89 e5             	mov    %rsp,%rbp
   41246:	48 83 ec 18          	sub    $0x18,%rsp
   4124a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4124e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41252:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41255:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41258:	48 98                	cltq   
   4125a:	48 c1 e0 2d          	shl    $0x2d,%rax
   4125e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41262:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41269:	90 00 00 
   4126c:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4126f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41273:	48 89 10             	mov    %rdx,(%rax)
}
   41276:	90                   	nop
   41277:	c9                   	leaveq 
   41278:	c3                   	retq   

0000000000041279 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41279:	55                   	push   %rbp
   4127a:	48 89 e5             	mov    %rsp,%rbp
   4127d:	48 83 ec 28          	sub    $0x28,%rsp
   41281:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41285:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41289:	89 55 ec             	mov    %edx,-0x14(%rbp)
   4128c:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41290:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41294:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41298:	48 c1 e0 10          	shl    $0x10,%rax
   4129c:	48 89 c2             	mov    %rax,%rdx
   4129f:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   412a6:	00 00 00 
   412a9:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   412ac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   412b0:	48 c1 e0 20          	shl    $0x20,%rax
   412b4:	48 89 c1             	mov    %rax,%rcx
   412b7:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   412be:	00 00 ff 
   412c1:	48 21 c8             	and    %rcx,%rax
   412c4:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   412c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   412cb:	48 83 e8 01          	sub    $0x1,%rax
   412cf:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   412d2:	48 09 d0             	or     %rdx,%rax
        | type
   412d5:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   412d9:	8b 55 ec             	mov    -0x14(%rbp),%edx
   412dc:	48 63 d2             	movslq %edx,%rdx
   412df:	48 c1 e2 2d          	shl    $0x2d,%rdx
   412e3:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   412e6:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   412ed:	80 00 00 
   412f0:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   412f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412f7:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   412fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   412fe:	48 83 c0 08          	add    $0x8,%rax
   41302:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41306:	48 c1 ea 20          	shr    $0x20,%rdx
   4130a:	48 89 10             	mov    %rdx,(%rax)
}
   4130d:	90                   	nop
   4130e:	c9                   	leaveq 
   4130f:	c3                   	retq   

0000000000041310 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41310:	55                   	push   %rbp
   41311:	48 89 e5             	mov    %rsp,%rbp
   41314:	48 83 ec 20          	sub    $0x20,%rsp
   41318:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4131c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41320:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41323:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41327:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4132b:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4132e:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41332:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41335:	48 63 d2             	movslq %edx,%rdx
   41338:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4133c:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4133f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41343:	48 c1 e0 20          	shl    $0x20,%rax
   41347:	48 89 c1             	mov    %rax,%rcx
   4134a:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41351:	00 ff ff 
   41354:	48 21 c8             	and    %rcx,%rax
   41357:	48 09 c2             	or     %rax,%rdx
   4135a:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41361:	80 00 00 
   41364:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41367:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4136b:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4136e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41372:	48 c1 e8 20          	shr    $0x20,%rax
   41376:	48 89 c2             	mov    %rax,%rdx
   41379:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4137d:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41381:	90                   	nop
   41382:	c9                   	leaveq 
   41383:	c3                   	retq   

0000000000041384 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41384:	55                   	push   %rbp
   41385:	48 89 e5             	mov    %rsp,%rbp
   41388:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4138c:	48 c7 05 69 dc 00 00 	movq   $0x0,0xdc69(%rip)        # 4f000 <segments>
   41393:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41397:	ba 00 00 00 00       	mov    $0x0,%edx
   4139c:	48 be 00 00 00 00 00 	movabs $0x20080000000000,%rsi
   413a3:	08 20 00 
   413a6:	bf 08 f0 04 00       	mov    $0x4f008,%edi
   413ab:	e8 92 fe ff ff       	callq  41242 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   413b0:	ba 03 00 00 00       	mov    $0x3,%edx
   413b5:	48 be 00 00 00 00 00 	movabs $0x20080000000000,%rsi
   413bc:	08 20 00 
   413bf:	bf 10 f0 04 00       	mov    $0x4f010,%edi
   413c4:	e8 79 fe ff ff       	callq  41242 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   413c9:	ba 00 00 00 00       	mov    $0x0,%edx
   413ce:	48 be 00 00 00 00 00 	movabs $0x20000000000,%rsi
   413d5:	02 00 00 
   413d8:	bf 18 f0 04 00       	mov    $0x4f018,%edi
   413dd:	e8 60 fe ff ff       	callq  41242 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   413e2:	ba 03 00 00 00       	mov    $0x3,%edx
   413e7:	48 be 00 00 00 00 00 	movabs $0x20000000000,%rsi
   413ee:	02 00 00 
   413f1:	bf 20 f0 04 00       	mov    $0x4f020,%edi
   413f6:	e8 47 fe ff ff       	callq  41242 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   413fb:	b8 40 00 05 00       	mov    $0x50040,%eax
   41400:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41406:	48 89 c1             	mov    %rax,%rcx
   41409:	ba 00 00 00 00       	mov    $0x0,%edx
   4140e:	48 be 00 00 00 00 00 	movabs $0x90000000000,%rsi
   41415:	09 00 00 
   41418:	bf 28 f0 04 00       	mov    $0x4f028,%edi
   4141d:	e8 57 fe ff ff       	callq  41279 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41422:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41428:	b8 00 f0 04 00       	mov    $0x4f000,%eax
   4142d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41431:	ba 60 00 00 00       	mov    $0x60,%edx
   41436:	be 00 00 00 00       	mov    $0x0,%esi
   4143b:	bf 40 00 05 00       	mov    $0x50040,%edi
   41440:	e8 82 17 00 00       	callq  42bc7 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41445:	48 c7 05 f4 eb 00 00 	movq   $0x80000,0xebf4(%rip)        # 50044 <kernel_task_descriptor+0x4>
   4144c:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41450:	ba 00 10 00 00       	mov    $0x1000,%edx
   41455:	be 00 00 00 00       	mov    $0x0,%esi
   4145a:	bf 40 f0 04 00       	mov    $0x4f040,%edi
   4145f:	e8 63 17 00 00       	callq  42bc7 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41464:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   4146b:	eb 30                	jmp    4149d <segments_init+0x119>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   4146d:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41472:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41475:	48 c1 e0 04          	shl    $0x4,%rax
   41479:	48 05 40 f0 04 00    	add    $0x4f040,%rax
   4147f:	48 89 d1             	mov    %rdx,%rcx
   41482:	ba 00 00 00 00       	mov    $0x0,%edx
   41487:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4148e:	0e 00 00 
   41491:	48 89 c7             	mov    %rax,%rdi
   41494:	e8 77 fe ff ff       	callq  41310 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41499:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4149d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   414a4:	76 c7                	jbe    4146d <segments_init+0xe9>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   414a6:	b8 36 00 04 00       	mov    $0x40036,%eax
   414ab:	48 89 c1             	mov    %rax,%rcx
   414ae:	ba 00 00 00 00       	mov    $0x0,%edx
   414b3:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   414ba:	0e 00 00 
   414bd:	bf 40 f2 04 00       	mov    $0x4f240,%edi
   414c2:	e8 49 fe ff ff       	callq  41310 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   414c7:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   414cc:	48 89 c1             	mov    %rax,%rcx
   414cf:	ba 00 00 00 00       	mov    $0x0,%edx
   414d4:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   414db:	0e 00 00 
   414de:	bf 10 f1 04 00       	mov    $0x4f110,%edi
   414e3:	e8 28 fe ff ff       	callq  41310 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   414e8:	b8 32 00 04 00       	mov    $0x40032,%eax
   414ed:	48 89 c1             	mov    %rax,%rcx
   414f0:	ba 00 00 00 00       	mov    $0x0,%edx
   414f5:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   414fc:	0e 00 00 
   414ff:	bf 20 f1 04 00       	mov    $0x4f120,%edi
   41504:	e8 07 fe ff ff       	callq  41310 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41509:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41510:	eb 3e                	jmp    41550 <segments_init+0x1cc>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41512:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41515:	83 e8 30             	sub    $0x30,%eax
   41518:	89 c0                	mov    %eax,%eax
   4151a:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41521:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41522:	48 89 c2             	mov    %rax,%rdx
   41525:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41528:	48 c1 e0 04          	shl    $0x4,%rax
   4152c:	48 05 40 f0 04 00    	add    $0x4f040,%rax
   41532:	48 89 d1             	mov    %rdx,%rcx
   41535:	ba 03 00 00 00       	mov    $0x3,%edx
   4153a:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41541:	0e 00 00 
   41544:	48 89 c7             	mov    %rax,%rdi
   41547:	e8 c4 fd ff ff       	callq  41310 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4154c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41550:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   41554:	76 bc                	jbe    41512 <segments_init+0x18e>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   41556:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   4155c:	b8 40 f0 04 00       	mov    $0x4f040,%eax
   41561:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   41565:	b8 28 00 00 00       	mov    $0x28,%eax
   4156a:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   4156e:	0f 00 d8             	ltr    %ax
   41571:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   41575:	0f 20 c0             	mov    %cr0,%rax
   41578:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   4157c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41580:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   41583:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4158a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4158d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   41590:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41593:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   41597:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4159b:	0f 22 c0             	mov    %rax,%cr0
}
   4159e:	90                   	nop
    lcr0(cr0);
}
   4159f:	90                   	nop
   415a0:	c9                   	leaveq 
   415a1:	c3                   	retq   

00000000000415a2 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   415a2:	55                   	push   %rbp
   415a3:	48 89 e5             	mov    %rsp,%rbp
   415a6:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   415aa:	0f b7 05 ef ea 00 00 	movzwl 0xeaef(%rip),%eax        # 500a0 <interrupts_enabled>
   415b1:	f7 d0                	not    %eax
   415b3:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   415b7:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   415bb:	0f b6 c0             	movzbl %al,%eax
   415be:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   415c5:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   415c8:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   415cc:	8b 55 f0             	mov    -0x10(%rbp),%edx
   415cf:	ee                   	out    %al,(%dx)
}
   415d0:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   415d1:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   415d5:	66 c1 e8 08          	shr    $0x8,%ax
   415d9:	0f b6 c0             	movzbl %al,%eax
   415dc:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   415e3:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   415e6:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   415ea:	8b 55 f8             	mov    -0x8(%rbp),%edx
   415ed:	ee                   	out    %al,(%dx)
}
   415ee:	90                   	nop
}
   415ef:	90                   	nop
   415f0:	c9                   	leaveq 
   415f1:	c3                   	retq   

00000000000415f2 <interrupt_init>:

void interrupt_init(void) {
   415f2:	55                   	push   %rbp
   415f3:	48 89 e5             	mov    %rsp,%rbp
   415f6:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   415fa:	66 c7 05 9d ea 00 00 	movw   $0x0,0xea9d(%rip)        # 500a0 <interrupts_enabled>
   41601:	00 00 
    interrupt_mask();
   41603:	e8 9a ff ff ff       	callq  415a2 <interrupt_mask>
   41608:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   4160f:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41613:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41617:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   4161a:	ee                   	out    %al,(%dx)
}
   4161b:	90                   	nop
   4161c:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41623:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41627:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4162b:	8b 55 ac             	mov    -0x54(%rbp),%edx
   4162e:	ee                   	out    %al,(%dx)
}
   4162f:	90                   	nop
   41630:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41637:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4163b:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   4163f:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41642:	ee                   	out    %al,(%dx)
}
   41643:	90                   	nop
   41644:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4164b:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4164f:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41653:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41656:	ee                   	out    %al,(%dx)
}
   41657:	90                   	nop
   41658:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   4165f:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41663:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41667:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4166a:	ee                   	out    %al,(%dx)
}
   4166b:	90                   	nop
   4166c:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41673:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41677:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4167b:	8b 55 cc             	mov    -0x34(%rbp),%edx
   4167e:	ee                   	out    %al,(%dx)
}
   4167f:	90                   	nop
   41680:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41687:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4168b:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   4168f:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41692:	ee                   	out    %al,(%dx)
}
   41693:	90                   	nop
   41694:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   4169b:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4169f:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   416a3:	8b 55 dc             	mov    -0x24(%rbp),%edx
   416a6:	ee                   	out    %al,(%dx)
}
   416a7:	90                   	nop
   416a8:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   416af:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   416b3:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   416b7:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   416ba:	ee                   	out    %al,(%dx)
}
   416bb:	90                   	nop
   416bc:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   416c3:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   416c7:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   416cb:	8b 55 ec             	mov    -0x14(%rbp),%edx
   416ce:	ee                   	out    %al,(%dx)
}
   416cf:	90                   	nop
   416d0:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   416d7:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   416db:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   416df:	8b 55 f4             	mov    -0xc(%rbp),%edx
   416e2:	ee                   	out    %al,(%dx)
}
   416e3:	90                   	nop
   416e4:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   416eb:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   416ef:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   416f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416f6:	ee                   	out    %al,(%dx)
}
   416f7:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   416f8:	e8 a5 fe ff ff       	callq  415a2 <interrupt_mask>
}
   416fd:	90                   	nop
   416fe:	c9                   	leaveq 
   416ff:	c3                   	retq   

0000000000041700 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41700:	55                   	push   %rbp
   41701:	48 89 e5             	mov    %rsp,%rbp
   41704:	48 83 ec 28          	sub    $0x28,%rsp
   41708:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   4170b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   4170f:	0f 8e 9e 00 00 00    	jle    417b3 <timer_init+0xb3>
   41715:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   4171c:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41720:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41724:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41727:	ee                   	out    %al,(%dx)
}
   41728:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41729:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4172c:	89 c2                	mov    %eax,%edx
   4172e:	c1 ea 1f             	shr    $0x1f,%edx
   41731:	01 d0                	add    %edx,%eax
   41733:	d1 f8                	sar    %eax
   41735:	05 de 34 12 00       	add    $0x1234de,%eax
   4173a:	99                   	cltd   
   4173b:	f7 7d dc             	idivl  -0x24(%rbp)
   4173e:	89 c2                	mov    %eax,%edx
   41740:	89 d0                	mov    %edx,%eax
   41742:	c1 f8 1f             	sar    $0x1f,%eax
   41745:	c1 e8 18             	shr    $0x18,%eax
   41748:	01 c2                	add    %eax,%edx
   4174a:	0f b6 d2             	movzbl %dl,%edx
   4174d:	29 c2                	sub    %eax,%edx
   4174f:	89 d0                	mov    %edx,%eax
   41751:	0f b6 c0             	movzbl %al,%eax
   41754:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   4175b:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4175e:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41762:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41765:	ee                   	out    %al,(%dx)
}
   41766:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41767:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4176a:	89 c2                	mov    %eax,%edx
   4176c:	c1 ea 1f             	shr    $0x1f,%edx
   4176f:	01 d0                	add    %edx,%eax
   41771:	d1 f8                	sar    %eax
   41773:	05 de 34 12 00       	add    $0x1234de,%eax
   41778:	99                   	cltd   
   41779:	f7 7d dc             	idivl  -0x24(%rbp)
   4177c:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41782:	85 c0                	test   %eax,%eax
   41784:	0f 48 c2             	cmovs  %edx,%eax
   41787:	c1 f8 08             	sar    $0x8,%eax
   4178a:	0f b6 c0             	movzbl %al,%eax
   4178d:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41794:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41797:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4179b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4179e:	ee                   	out    %al,(%dx)
}
   4179f:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   417a0:	0f b7 05 f9 e8 00 00 	movzwl 0xe8f9(%rip),%eax        # 500a0 <interrupts_enabled>
   417a7:	83 c8 01             	or     $0x1,%eax
   417aa:	66 89 05 ef e8 00 00 	mov    %ax,0xe8ef(%rip)        # 500a0 <interrupts_enabled>
   417b1:	eb 11                	jmp    417c4 <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   417b3:	0f b7 05 e6 e8 00 00 	movzwl 0xe8e6(%rip),%eax        # 500a0 <interrupts_enabled>
   417ba:	83 e0 fe             	and    $0xfffffffe,%eax
   417bd:	66 89 05 dc e8 00 00 	mov    %ax,0xe8dc(%rip)        # 500a0 <interrupts_enabled>
    }
    interrupt_mask();
   417c4:	e8 d9 fd ff ff       	callq  415a2 <interrupt_mask>
}
   417c9:	90                   	nop
   417ca:	c9                   	leaveq 
   417cb:	c3                   	retq   

00000000000417cc <virtual_memory_init>:
//    `kernel_pagetable`.

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;

void virtual_memory_init(void) {
   417cc:	55                   	push   %rbp
   417cd:	48 89 e5             	mov    %rsp,%rbp
   417d0:	48 83 ec 10          	sub    $0x10,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   417d4:	48 c7 05 39 48 01 00 	movq   $0x51000,0x14839(%rip)        # 56018 <kernel_pagetable>
   417db:	00 10 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   417df:	ba 00 50 00 00       	mov    $0x5000,%edx
   417e4:	be 00 00 00 00       	mov    $0x0,%esi
   417e9:	bf 00 10 05 00       	mov    $0x51000,%edi
   417ee:	e8 d4 13 00 00       	callq  42bc7 <memset>
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   417f3:	b8 00 20 05 00       	mov    $0x52000,%eax
   417f8:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   417fc:	48 89 05 fd f7 00 00 	mov    %rax,0xf7fd(%rip)        # 51000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   41803:	b8 00 30 05 00       	mov    $0x53000,%eax
   41808:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4180c:	48 89 05 ed 07 01 00 	mov    %rax,0x107ed(%rip)        # 52000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   41813:	b8 00 40 05 00       	mov    $0x54000,%eax
   41818:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4181c:	48 89 05 dd 17 01 00 	mov    %rax,0x117dd(%rip)        # 53000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   41823:	b8 00 50 05 00       	mov    $0x55000,%eax
   41828:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4182c:	48 89 05 d5 17 01 00 	mov    %rax,0x117d5(%rip)        # 53008 <kernel_pagetables+0x2008>

    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   41833:	48 8b 05 de 47 01 00 	mov    0x147de(%rip),%rax        # 56018 <kernel_pagetable>
   4183a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   41840:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   41846:	b9 00 00 20 00       	mov    $0x200000,%ecx
   4184b:	ba 00 00 00 00       	mov    $0x0,%edx
   41850:	be 00 00 00 00       	mov    $0x0,%esi
   41855:	48 89 c7             	mov    %rax,%rdi
   41858:	e8 16 00 00 00       	callq  41873 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U, NULL);

    lcr3((uintptr_t) kernel_pagetable);
   4185d:	48 8b 05 b4 47 01 00 	mov    0x147b4(%rip),%rax        # 56018 <kernel_pagetable>
   41864:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   41868:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4186c:	0f 22 d8             	mov    %rax,%cr3
}
   4186f:	90                   	nop
}
   41870:	90                   	nop
   41871:	c9                   	leaveq 
   41872:	c3                   	retq   

0000000000041873 <virtual_memory_map>:
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm, x86_64_pagetable* (*allocator)(void));

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm,
                       x86_64_pagetable* (*allocator)(void)) {
   41873:	55                   	push   %rbp
   41874:	48 89 e5             	mov    %rsp,%rbp
   41877:	53                   	push   %rbx
   41878:	48 83 ec 58          	sub    $0x58,%rsp
   4187c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41880:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   41884:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   41888:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   4188c:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)
   41890:	4c 89 4d a0          	mov    %r9,-0x60(%rbp)
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   41894:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41898:	25 ff 0f 00 00       	and    $0xfff,%eax
   4189d:	48 85 c0             	test   %rax,%rax
   418a0:	74 14                	je     418b6 <virtual_memory_map+0x43>
   418a2:	ba 02 39 04 00       	mov    $0x43902,%edx
   418a7:	be 3b 01 00 00       	mov    $0x13b,%esi
   418ac:	bf 15 39 04 00       	mov    $0x43915,%edi
   418b1:	e8 31 0f 00 00       	callq  427e7 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   418b6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   418ba:	25 ff 0f 00 00       	and    $0xfff,%eax
   418bf:	48 85 c0             	test   %rax,%rax
   418c2:	74 14                	je     418d8 <virtual_memory_map+0x65>
   418c4:	ba 22 39 04 00       	mov    $0x43922,%edx
   418c9:	be 3c 01 00 00       	mov    $0x13c,%esi
   418ce:	bf 15 39 04 00       	mov    $0x43915,%edi
   418d3:	e8 0f 0f 00 00       	callq  427e7 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   418d8:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   418dc:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   418e0:	48 01 d0             	add    %rdx,%rax
   418e3:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   418e7:	76 24                	jbe    4190d <virtual_memory_map+0x9a>
   418e9:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   418ed:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   418f1:	48 01 d0             	add    %rdx,%rax
   418f4:	48 85 c0             	test   %rax,%rax
   418f7:	74 14                	je     4190d <virtual_memory_map+0x9a>
   418f9:	ba 35 39 04 00       	mov    $0x43935,%edx
   418fe:	be 3d 01 00 00       	mov    $0x13d,%esi
   41903:	bf 15 39 04 00       	mov    $0x43915,%edi
   41908:	e8 da 0e 00 00       	callq  427e7 <assert_fail>
    if (perm & PTE_P) {
   4190d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41910:	48 98                	cltq   
   41912:	83 e0 01             	and    $0x1,%eax
   41915:	48 85 c0             	test   %rax,%rax
   41918:	74 6e                	je     41988 <virtual_memory_map+0x115>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   4191a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4191e:	25 ff 0f 00 00       	and    $0xfff,%eax
   41923:	48 85 c0             	test   %rax,%rax
   41926:	74 14                	je     4193c <virtual_memory_map+0xc9>
   41928:	ba 53 39 04 00       	mov    $0x43953,%edx
   4192d:	be 3f 01 00 00       	mov    $0x13f,%esi
   41932:	bf 15 39 04 00       	mov    $0x43915,%edi
   41937:	e8 ab 0e 00 00       	callq  427e7 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   4193c:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41940:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41944:	48 01 d0             	add    %rdx,%rax
   41947:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   4194b:	76 14                	jbe    41961 <virtual_memory_map+0xee>
   4194d:	ba 66 39 04 00       	mov    $0x43966,%edx
   41952:	be 40 01 00 00       	mov    $0x140,%esi
   41957:	bf 15 39 04 00       	mov    $0x43915,%edi
   4195c:	e8 86 0e 00 00       	callq  427e7 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   41961:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41965:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   41969:	48 01 d0             	add    %rdx,%rax
   4196c:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   41972:	76 14                	jbe    41988 <virtual_memory_map+0x115>
   41974:	ba 74 39 04 00       	mov    $0x43974,%edx
   41979:	be 41 01 00 00       	mov    $0x141,%esi
   4197e:	bf 15 39 04 00       	mov    $0x43915,%edi
   41983:	e8 5f 0e 00 00       	callq  427e7 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense
   41988:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   4198c:	78 09                	js     41997 <virtual_memory_map+0x124>
   4198e:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   41995:	7e 14                	jle    419ab <virtual_memory_map+0x138>
   41997:	ba 90 39 04 00       	mov    $0x43990,%edx
   4199c:	be 43 01 00 00       	mov    $0x143,%esi
   419a1:	bf 15 39 04 00       	mov    $0x43915,%edi
   419a6:	e8 3c 0e 00 00       	callq  427e7 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   419ab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   419af:	25 ff 0f 00 00       	and    $0xfff,%eax
   419b4:	48 85 c0             	test   %rax,%rax
   419b7:	74 14                	je     419cd <virtual_memory_map+0x15a>
   419b9:	ba b0 39 04 00       	mov    $0x439b0,%edx
   419be:	be 44 01 00 00       	mov    $0x144,%esi
   419c3:	bf 15 39 04 00       	mov    $0x43915,%edi
   419c8:	e8 1a 0e 00 00       	callq  427e7 <assert_fail>

    int last_index123 = -1;
   419cd:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   419d4:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   419db:	00 
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   419dc:	e9 ce 00 00 00       	jmpq   41aaf <virtual_memory_map+0x23c>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   419e1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   419e5:	48 c1 e8 15          	shr    $0x15,%rax
   419e9:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   419ec:	8b 45 dc             	mov    -0x24(%rbp),%eax
   419ef:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   419f2:	74 21                	je     41a15 <virtual_memory_map+0x1a2>
            l4pagetable = lookup_l4pagetable(pagetable, va, perm, allocator);
   419f4:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   419f8:	8b 55 ac             	mov    -0x54(%rbp),%edx
   419fb:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
   419ff:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41a03:	48 89 c7             	mov    %rax,%rdi
   41a06:	e8 bb 00 00 00       	callq  41ac6 <lookup_l4pagetable>
   41a0b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   41a0f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41a12:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) {
   41a15:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41a18:	48 98                	cltq   
   41a1a:	83 e0 01             	and    $0x1,%eax
   41a1d:	48 85 c0             	test   %rax,%rax
   41a20:	74 34                	je     41a56 <virtual_memory_map+0x1e3>
   41a22:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41a27:	74 2d                	je     41a56 <virtual_memory_map+0x1e3>
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   41a29:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41a2c:	48 63 d8             	movslq %eax,%rbx
   41a2f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41a33:	be 03 00 00 00       	mov    $0x3,%esi
   41a38:	48 89 c7             	mov    %rax,%rdi
   41a3b:	e8 96 f7 ff ff       	callq  411d6 <pageindex>
   41a40:	89 c2                	mov    %eax,%edx
   41a42:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   41a46:	48 89 d9             	mov    %rbx,%rcx
   41a49:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41a4d:	48 63 d2             	movslq %edx,%rdx
   41a50:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   41a54:	eb 41                	jmp    41a97 <virtual_memory_map+0x224>
        } else if (l4pagetable) {
   41a56:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41a5b:	74 26                	je     41a83 <virtual_memory_map+0x210>
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   41a5d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41a61:	be 03 00 00 00       	mov    $0x3,%esi
   41a66:	48 89 c7             	mov    %rax,%rdi
   41a69:	e8 68 f7 ff ff       	callq  411d6 <pageindex>
   41a6e:	89 c2                	mov    %eax,%edx
   41a70:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41a73:	48 63 c8             	movslq %eax,%rcx
   41a76:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41a7a:	48 63 d2             	movslq %edx,%rdx
   41a7d:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   41a81:	eb 14                	jmp    41a97 <virtual_memory_map+0x224>
        } else if (perm & PTE_P) {
   41a83:	8b 45 ac             	mov    -0x54(%rbp),%eax
   41a86:	48 98                	cltq   
   41a88:	83 e0 01             	and    $0x1,%eax
   41a8b:	48 85 c0             	test   %rax,%rax
   41a8e:	74 07                	je     41a97 <virtual_memory_map+0x224>
            return -1;
   41a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41a95:	eb 28                	jmp    41abf <virtual_memory_map+0x24c>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   41a97:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   41a9e:	00 
   41a9f:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   41aa6:	00 
   41aa7:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   41aae:	00 
   41aaf:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   41ab4:	0f 85 27 ff ff ff    	jne    419e1 <virtual_memory_map+0x16e>
        }
    }
    return 0;
   41aba:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41abf:	48 83 c4 58          	add    $0x58,%rsp
   41ac3:	5b                   	pop    %rbx
   41ac4:	5d                   	pop    %rbp
   41ac5:	c3                   	retq   

0000000000041ac6 <lookup_l4pagetable>:

static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm, x86_64_pagetable* (*allocator)(void)) {
   41ac6:	55                   	push   %rbp
   41ac7:	48 89 e5             	mov    %rsp,%rbp
   41aca:	48 83 ec 40          	sub    $0x40,%rsp
   41ace:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   41ad2:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   41ad6:	89 55 cc             	mov    %edx,-0x34(%rbp)
   41ad9:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    x86_64_pagetable* pt = pagetable;
   41add:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41ae1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   41ae5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41aec:	e9 69 01 00 00       	jmpq   41c5a <lookup_l4pagetable+0x194>
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   41af1:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41af4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   41af8:	89 d6                	mov    %edx,%esi
   41afa:	48 89 c7             	mov    %rax,%rdi
   41afd:	e8 d4 f6 ff ff       	callq  411d6 <pageindex>
   41b02:	89 c2                	mov    %eax,%edx
   41b04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b08:	48 63 d2             	movslq %edx,%rdx
   41b0b:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41b0f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        if (!(pe & PTE_P)) {
   41b13:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41b17:	83 e0 01             	and    $0x1,%eax
   41b1a:	48 85 c0             	test   %rax,%rax
   41b1d:	0f 85 a5 00 00 00    	jne    41bc8 <lookup_l4pagetable+0x102>
            // allocate a new page table page if required
            if (!(perm & PTE_P) || !allocator) {
   41b23:	8b 45 cc             	mov    -0x34(%rbp),%eax
   41b26:	48 98                	cltq   
   41b28:	83 e0 01             	and    $0x1,%eax
   41b2b:	48 85 c0             	test   %rax,%rax
   41b2e:	74 07                	je     41b37 <lookup_l4pagetable+0x71>
   41b30:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
   41b35:	75 0a                	jne    41b41 <lookup_l4pagetable+0x7b>
                return NULL;
   41b37:	b8 00 00 00 00       	mov    $0x0,%eax
   41b3c:	e9 27 01 00 00       	jmpq   41c68 <lookup_l4pagetable+0x1a2>
            }
            x86_64_pagetable* new_pt = allocator();
   41b41:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41b45:	ff d0                	callq  *%rax
   41b47:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (!new_pt) {
   41b4b:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   41b50:	75 0a                	jne    41b5c <lookup_l4pagetable+0x96>
                return NULL;
   41b52:	b8 00 00 00 00       	mov    $0x0,%eax
   41b57:	e9 0c 01 00 00       	jmpq   41c68 <lookup_l4pagetable+0x1a2>
            }
            assert((uintptr_t) new_pt % PAGESIZE == 0);
   41b5c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b60:	25 ff 0f 00 00       	and    $0xfff,%eax
   41b65:	48 85 c0             	test   %rax,%rax
   41b68:	74 14                	je     41b7e <lookup_l4pagetable+0xb8>
   41b6a:	ba d8 39 04 00       	mov    $0x439d8,%edx
   41b6f:	be 67 01 00 00       	mov    $0x167,%esi
   41b74:	bf 15 39 04 00       	mov    $0x43915,%edi
   41b79:	e8 69 0c 00 00       	callq  427e7 <assert_fail>
            pt->entry[PAGEINDEX(va, i)] = pe =
                PTE_ADDR(new_pt) | PTE_P | PTE_W | PTE_U;
   41b7e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41b82:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
            pt->entry[PAGEINDEX(va, i)] = pe =
   41b88:	48 83 c8 07          	or     $0x7,%rax
   41b8c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   41b90:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b93:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   41b97:	89 d6                	mov    %edx,%esi
   41b99:	48 89 c7             	mov    %rax,%rdi
   41b9c:	e8 35 f6 ff ff       	callq  411d6 <pageindex>
   41ba1:	89 c2                	mov    %eax,%edx
   41ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41ba7:	48 63 d2             	movslq %edx,%rdx
   41baa:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   41bae:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
            memset(new_pt, 0, PAGESIZE);
   41bb2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41bb6:	ba 00 10 00 00       	mov    $0x1000,%edx
   41bbb:	be 00 00 00 00       	mov    $0x0,%esi
   41bc0:	48 89 c7             	mov    %rax,%rdi
   41bc3:	e8 ff 0f 00 00       	callq  42bc7 <memset>
        }

        // sanity-check page entry
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   41bc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41bcc:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41bd2:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41bd8:	76 14                	jbe    41bee <lookup_l4pagetable+0x128>
   41bda:	ba 00 3a 04 00       	mov    $0x43a00,%edx
   41bdf:	be 6e 01 00 00       	mov    $0x16e,%esi
   41be4:	bf 15 39 04 00       	mov    $0x43915,%edi
   41be9:	e8 f9 0b 00 00       	callq  427e7 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   41bee:	8b 45 cc             	mov    -0x34(%rbp),%eax
   41bf1:	48 98                	cltq   
   41bf3:	83 e0 02             	and    $0x2,%eax
   41bf6:	48 85 c0             	test   %rax,%rax
   41bf9:	74 20                	je     41c1b <lookup_l4pagetable+0x155>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   41bfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41bff:	83 e0 02             	and    $0x2,%eax
   41c02:	48 85 c0             	test   %rax,%rax
   41c05:	75 14                	jne    41c1b <lookup_l4pagetable+0x155>
   41c07:	ba 20 3a 04 00       	mov    $0x43a20,%edx
   41c0c:	be 70 01 00 00       	mov    $0x170,%esi
   41c11:	bf 15 39 04 00       	mov    $0x43915,%edi
   41c16:	e8 cc 0b 00 00       	callq  427e7 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   41c1b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   41c1e:	48 98                	cltq   
   41c20:	83 e0 04             	and    $0x4,%eax
   41c23:	48 85 c0             	test   %rax,%rax
   41c26:	74 20                	je     41c48 <lookup_l4pagetable+0x182>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   41c28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c2c:	83 e0 04             	and    $0x4,%eax
   41c2f:	48 85 c0             	test   %rax,%rax
   41c32:	75 14                	jne    41c48 <lookup_l4pagetable+0x182>
   41c34:	ba 2b 3a 04 00       	mov    $0x43a2b,%edx
   41c39:	be 73 01 00 00       	mov    $0x173,%esi
   41c3e:	bf 15 39 04 00       	mov    $0x43915,%edi
   41c43:	e8 9f 0b 00 00       	callq  427e7 <assert_fail>
        }

        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   41c48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41c4c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41c52:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   41c56:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41c5a:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   41c5e:	0f 8e 8d fe ff ff    	jle    41af1 <lookup_l4pagetable+0x2b>
    }
    return pt;
   41c64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   41c68:	c9                   	leaveq 
   41c69:	c3                   	retq   

0000000000041c6a <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   41c6a:	55                   	push   %rbp
   41c6b:	48 89 e5             	mov    %rsp,%rbp
   41c6e:	48 83 ec 50          	sub    $0x50,%rsp
   41c72:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41c76:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   41c7a:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   41c7e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41c82:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   41c86:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   41c8d:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   41c8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   41c95:	eb 41                	jmp    41cd8 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   41c97:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c9a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41c9e:	89 d6                	mov    %edx,%esi
   41ca0:	48 89 c7             	mov    %rax,%rdi
   41ca3:	e8 2e f5 ff ff       	callq  411d6 <pageindex>
   41ca8:	89 c2                	mov    %eax,%edx
   41caa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41cae:	48 63 d2             	movslq %edx,%rdx
   41cb1:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41cb5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41cb9:	83 e2 06             	and    $0x6,%edx
   41cbc:	48 f7 d2             	not    %rdx
   41cbf:	48 21 d0             	and    %rdx,%rax
   41cc2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   41cc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41cca:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41cd0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   41cd4:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   41cd8:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   41cdc:	7f 0c                	jg     41cea <virtual_memory_lookup+0x80>
   41cde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41ce2:	83 e0 01             	and    $0x1,%eax
   41ce5:	48 85 c0             	test   %rax,%rax
   41ce8:	75 ad                	jne    41c97 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   41cea:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   41cf1:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   41cf8:	ff 
   41cf9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   41d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41d04:	83 e0 01             	and    $0x1,%eax
   41d07:	48 85 c0             	test   %rax,%rax
   41d0a:	74 34                	je     41d40 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   41d0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41d10:	48 c1 e8 0c          	shr    $0xc,%rax
   41d14:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   41d17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41d1b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41d21:	48 89 c2             	mov    %rax,%rdx
   41d24:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41d28:	25 ff 0f 00 00       	and    $0xfff,%eax
   41d2d:	48 09 d0             	or     %rdx,%rax
   41d30:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   41d34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   41d38:	25 ff 0f 00 00       	and    $0xfff,%eax
   41d3d:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   41d40:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41d44:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   41d48:	48 89 10             	mov    %rdx,(%rax)
   41d4b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   41d4f:	48 89 50 08          	mov    %rdx,0x8(%rax)
   41d53:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41d57:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   41d5b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41d5f:	c9                   	leaveq 
   41d60:	c3                   	retq   

0000000000041d61 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   41d61:	55                   	push   %rbp
   41d62:	48 89 e5             	mov    %rsp,%rbp
   41d65:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   41d69:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   41d6d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   41d71:	25 ff 0f 00 00       	and    $0xfff,%eax
   41d76:	48 85 c0             	test   %rax,%rax
   41d79:	74 14                	je     41d8f <set_pagetable+0x2e>
   41d7b:	ba 36 3a 04 00       	mov    $0x43a36,%edx
   41d80:	be 97 01 00 00       	mov    $0x197,%esi
   41d85:	bf 15 39 04 00       	mov    $0x43915,%edi
   41d8a:	e8 58 0a 00 00       	callq  427e7 <assert_fail>
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   41d8f:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41d94:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   41d98:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   41d9c:	48 89 ce             	mov    %rcx,%rsi
   41d9f:	48 89 c7             	mov    %rax,%rdi
   41da2:	e8 c3 fe ff ff       	callq  41c6a <virtual_memory_lookup>
   41da7:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   41dab:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41db0:	48 39 d0             	cmp    %rdx,%rax
   41db3:	74 14                	je     41dc9 <set_pagetable+0x68>
   41db5:	ba 58 3a 04 00       	mov    $0x43a58,%edx
   41dba:	be 98 01 00 00       	mov    $0x198,%esi
   41dbf:	bf 15 39 04 00       	mov    $0x43915,%edi
   41dc4:	e8 1e 0a 00 00       	callq  427e7 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   41dc9:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   41dcd:	48 8b 0d 44 42 01 00 	mov    0x14244(%rip),%rcx        # 56018 <kernel_pagetable>
   41dd4:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   41dd8:	48 89 ce             	mov    %rcx,%rsi
   41ddb:	48 89 c7             	mov    %rax,%rdi
   41dde:	e8 87 fe ff ff       	callq  41c6a <virtual_memory_lookup>
   41de3:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   41de7:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   41deb:	48 39 c2             	cmp    %rax,%rdx
   41dee:	74 14                	je     41e04 <set_pagetable+0xa3>
   41df0:	ba c0 3a 04 00       	mov    $0x43ac0,%edx
   41df5:	be 9a 01 00 00       	mov    $0x19a,%esi
   41dfa:	bf 15 39 04 00       	mov    $0x43915,%edi
   41dff:	e8 e3 09 00 00       	callq  427e7 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   41e04:	48 8b 05 0d 42 01 00 	mov    0x1420d(%rip),%rax        # 56018 <kernel_pagetable>
   41e0b:	48 89 c2             	mov    %rax,%rdx
   41e0e:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   41e12:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   41e16:	48 89 ce             	mov    %rcx,%rsi
   41e19:	48 89 c7             	mov    %rax,%rdi
   41e1c:	e8 49 fe ff ff       	callq  41c6a <virtual_memory_lookup>
   41e21:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   41e25:	48 8b 15 ec 41 01 00 	mov    0x141ec(%rip),%rdx        # 56018 <kernel_pagetable>
   41e2c:	48 39 d0             	cmp    %rdx,%rax
   41e2f:	74 14                	je     41e45 <set_pagetable+0xe4>
   41e31:	ba 20 3b 04 00       	mov    $0x43b20,%edx
   41e36:	be 9c 01 00 00       	mov    $0x19c,%esi
   41e3b:	bf 15 39 04 00       	mov    $0x43915,%edi
   41e40:	e8 a2 09 00 00       	callq  427e7 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   41e45:	ba 73 18 04 00       	mov    $0x41873,%edx
   41e4a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   41e4e:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   41e52:	48 89 ce             	mov    %rcx,%rsi
   41e55:	48 89 c7             	mov    %rax,%rdi
   41e58:	e8 0d fe ff ff       	callq  41c6a <virtual_memory_lookup>
   41e5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41e61:	ba 73 18 04 00       	mov    $0x41873,%edx
   41e66:	48 39 d0             	cmp    %rdx,%rax
   41e69:	74 14                	je     41e7f <set_pagetable+0x11e>
   41e6b:	ba 88 3b 04 00       	mov    $0x43b88,%edx
   41e70:	be 9e 01 00 00       	mov    $0x19e,%esi
   41e75:	bf 15 39 04 00       	mov    $0x43915,%edi
   41e7a:	e8 68 09 00 00       	callq  427e7 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   41e7f:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   41e83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   41e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e8b:	0f 22 d8             	mov    %rax,%cr3
}
   41e8e:	90                   	nop
}
   41e8f:	90                   	nop
   41e90:	c9                   	leaveq 
   41e91:	c3                   	retq   

0000000000041e92 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41e92:	55                   	push   %rbp
   41e93:	48 89 e5             	mov    %rsp,%rbp
   41e96:	48 83 ec 08          	sub    $0x8,%rsp
   41e9a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41e9e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41ea3:	74 14                	je     41eb9 <physical_memory_isreserved+0x27>
   41ea5:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41eac:	00 
   41ead:	76 11                	jbe    41ec0 <physical_memory_isreserved+0x2e>
   41eaf:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41eb6:	00 
   41eb7:	77 07                	ja     41ec0 <physical_memory_isreserved+0x2e>
   41eb9:	b8 01 00 00 00       	mov    $0x1,%eax
   41ebe:	eb 05                	jmp    41ec5 <physical_memory_isreserved+0x33>
   41ec0:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41ec5:	c9                   	leaveq 
   41ec6:	c3                   	retq   

0000000000041ec7 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41ec7:	55                   	push   %rbp
   41ec8:	48 89 e5             	mov    %rsp,%rbp
   41ecb:	48 83 ec 10          	sub    $0x10,%rsp
   41ecf:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41ed2:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41ed5:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41ed8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41edb:	c1 e0 10             	shl    $0x10,%eax
   41ede:	89 c2                	mov    %eax,%edx
   41ee0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ee3:	c1 e0 0b             	shl    $0xb,%eax
   41ee6:	09 c2                	or     %eax,%edx
   41ee8:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41eeb:	c1 e0 08             	shl    $0x8,%eax
   41eee:	09 d0                	or     %edx,%eax
}
   41ef0:	c9                   	leaveq 
   41ef1:	c3                   	retq   

0000000000041ef2 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41ef2:	55                   	push   %rbp
   41ef3:	48 89 e5             	mov    %rsp,%rbp
   41ef6:	48 83 ec 18          	sub    $0x18,%rsp
   41efa:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41efd:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41f00:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f03:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f06:	09 d0                	or     %edx,%eax
   41f08:	0d 00 00 00 80       	or     $0x80000000,%eax
   41f0d:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41f14:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41f17:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f1a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f1d:	ef                   	out    %eax,(%dx)
}
   41f1e:	90                   	nop
   41f1f:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41f26:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f29:	89 c2                	mov    %eax,%edx
   41f2b:	ed                   	in     (%dx),%eax
   41f2c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41f2f:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41f32:	c9                   	leaveq 
   41f33:	c3                   	retq   

0000000000041f34 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41f34:	55                   	push   %rbp
   41f35:	48 89 e5             	mov    %rsp,%rbp
   41f38:	48 83 ec 28          	sub    $0x28,%rsp
   41f3c:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41f3f:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41f42:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41f49:	eb 73                	jmp    41fbe <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41f4b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41f52:	eb 60                	jmp    41fb4 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41f54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41f5b:	eb 4a                	jmp    41fa7 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41f5d:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f60:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41f63:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f66:	89 ce                	mov    %ecx,%esi
   41f68:	89 c7                	mov    %eax,%edi
   41f6a:	e8 58 ff ff ff       	callq  41ec7 <pci_make_configaddr>
   41f6f:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41f72:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f75:	be 00 00 00 00       	mov    $0x0,%esi
   41f7a:	89 c7                	mov    %eax,%edi
   41f7c:	e8 71 ff ff ff       	callq  41ef2 <pci_config_readl>
   41f81:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41f84:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41f87:	c1 e0 10             	shl    $0x10,%eax
   41f8a:	0b 45 dc             	or     -0x24(%rbp),%eax
   41f8d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41f90:	75 05                	jne    41f97 <pci_find_device+0x63>
                    return configaddr;
   41f92:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f95:	eb 35                	jmp    41fcc <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41f97:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41f9b:	75 06                	jne    41fa3 <pci_find_device+0x6f>
   41f9d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41fa1:	74 0c                	je     41faf <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41fa3:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41fa7:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41fab:	75 b0                	jne    41f5d <pci_find_device+0x29>
   41fad:	eb 01                	jmp    41fb0 <pci_find_device+0x7c>
                    break;
   41faf:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41fb0:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41fb4:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41fb8:	75 9a                	jne    41f54 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41fba:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41fbe:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41fc5:	75 84                	jne    41f4b <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41fc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41fcc:	c9                   	leaveq 
   41fcd:	c3                   	retq   

0000000000041fce <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41fce:	55                   	push   %rbp
   41fcf:	48 89 e5             	mov    %rsp,%rbp
   41fd2:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41fd6:	be 13 71 00 00       	mov    $0x7113,%esi
   41fdb:	bf 86 80 00 00       	mov    $0x8086,%edi
   41fe0:	e8 4f ff ff ff       	callq  41f34 <pci_find_device>
   41fe5:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41fe8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41fec:	78 30                	js     4201e <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41fee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41ff1:	be 40 00 00 00       	mov    $0x40,%esi
   41ff6:	89 c7                	mov    %eax,%edi
   41ff8:	e8 f5 fe ff ff       	callq  41ef2 <pci_config_readl>
   41ffd:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42002:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42005:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42008:	83 c0 04             	add    $0x4,%eax
   4200b:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4200e:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42014:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42018:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4201b:	66 ef                	out    %ax,(%dx)
}
   4201d:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4201e:	ba ee 3b 04 00       	mov    $0x43bee,%edx
   42023:	be 00 c0 00 00       	mov    $0xc000,%esi
   42028:	bf 80 07 00 00       	mov    $0x780,%edi
   4202d:	b8 00 00 00 00       	mov    $0x0,%eax
   42032:	e8 ce 13 00 00       	callq  43405 <console_printf>
 spinloop: goto spinloop;
   42037:	eb fe                	jmp    42037 <poweroff+0x69>

0000000000042039 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42039:	55                   	push   %rbp
   4203a:	48 89 e5             	mov    %rsp,%rbp
   4203d:	48 83 ec 10          	sub    $0x10,%rsp
   42041:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42048:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4204c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42050:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42053:	ee                   	out    %al,(%dx)
}
   42054:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42055:	eb fe                	jmp    42055 <reboot+0x1c>

0000000000042057 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42057:	55                   	push   %rbp
   42058:	48 89 e5             	mov    %rsp,%rbp
   4205b:	48 83 ec 10          	sub    $0x10,%rsp
   4205f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42063:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42066:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4206a:	48 83 c0 08          	add    $0x8,%rax
   4206e:	ba c0 00 00 00       	mov    $0xc0,%edx
   42073:	be 00 00 00 00       	mov    $0x0,%esi
   42078:	48 89 c7             	mov    %rax,%rdi
   4207b:	e8 47 0b 00 00       	callq  42bc7 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   42080:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42084:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   4208b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   4208d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42091:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   42098:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   4209c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420a0:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   420a7:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   420ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420af:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   420b6:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   420b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420bc:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   420c3:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   420c7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420ca:	83 e0 01             	and    $0x1,%eax
   420cd:	85 c0                	test   %eax,%eax
   420cf:	74 1c                	je     420ed <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   420d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420d5:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   420dc:	80 cc 30             	or     $0x30,%ah
   420df:	48 89 c2             	mov    %rax,%rdx
   420e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420e6:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   420ed:	8b 45 f4             	mov    -0xc(%rbp),%eax
   420f0:	83 e0 02             	and    $0x2,%eax
   420f3:	85 c0                	test   %eax,%eax
   420f5:	74 1c                	je     42113 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   420f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   420fb:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42102:	80 e4 fd             	and    $0xfd,%ah
   42105:	48 89 c2             	mov    %rax,%rdx
   42108:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4210c:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42113:	90                   	nop
   42114:	c9                   	leaveq 
   42115:	c3                   	retq   

0000000000042116 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42116:	55                   	push   %rbp
   42117:	48 89 e5             	mov    %rsp,%rbp
   4211a:	48 83 ec 28          	sub    $0x28,%rsp
   4211e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42121:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42125:	78 09                	js     42130 <console_show_cursor+0x1a>
   42127:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4212e:	7e 07                	jle    42137 <console_show_cursor+0x21>
        cpos = 0;
   42130:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42137:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4213e:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42142:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42146:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42149:	ee                   	out    %al,(%dx)
}
   4214a:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   4214b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4214e:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42154:	85 c0                	test   %eax,%eax
   42156:	0f 48 c2             	cmovs  %edx,%eax
   42159:	c1 f8 08             	sar    $0x8,%eax
   4215c:	0f b6 c0             	movzbl %al,%eax
   4215f:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42166:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42169:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4216d:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42170:	ee                   	out    %al,(%dx)
}
   42171:	90                   	nop
   42172:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42179:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4217d:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42181:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42184:	ee                   	out    %al,(%dx)
}
   42185:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   42186:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42189:	99                   	cltd   
   4218a:	c1 ea 18             	shr    $0x18,%edx
   4218d:	01 d0                	add    %edx,%eax
   4218f:	0f b6 c0             	movzbl %al,%eax
   42192:	29 d0                	sub    %edx,%eax
   42194:	0f b6 c0             	movzbl %al,%eax
   42197:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   4219e:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421a1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421a5:	8b 55 fc             	mov    -0x4(%rbp),%edx
   421a8:	ee                   	out    %al,(%dx)
}
   421a9:	90                   	nop
}
   421aa:	90                   	nop
   421ab:	c9                   	leaveq 
   421ac:	c3                   	retq   

00000000000421ad <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   421ad:	55                   	push   %rbp
   421ae:	48 89 e5             	mov    %rsp,%rbp
   421b1:	48 83 ec 20          	sub    $0x20,%rsp
   421b5:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421bc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421bf:	89 c2                	mov    %eax,%edx
   421c1:	ec                   	in     (%dx),%al
   421c2:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421c5:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   421c9:	0f b6 c0             	movzbl %al,%eax
   421cc:	83 e0 01             	and    $0x1,%eax
   421cf:	85 c0                	test   %eax,%eax
   421d1:	75 0a                	jne    421dd <keyboard_readc+0x30>
        return -1;
   421d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   421d8:	e9 e5 01 00 00       	jmpq   423c2 <keyboard_readc+0x215>
   421dd:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421e4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   421e7:	89 c2                	mov    %eax,%edx
   421e9:	ec                   	in     (%dx),%al
   421ea:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   421ed:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   421f1:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   421f4:	0f b6 05 05 3e 01 00 	movzbl 0x13e05(%rip),%eax        # 56000 <last_escape.1641>
   421fb:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   421fe:	c6 05 fb 3d 01 00 00 	movb   $0x0,0x13dfb(%rip)        # 56000 <last_escape.1641>

    if (data == 0xE0) {         // mode shift
   42205:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42209:	75 11                	jne    4221c <keyboard_readc+0x6f>
        last_escape = 0x80;
   4220b:	c6 05 ee 3d 01 00 80 	movb   $0x80,0x13dee(%rip)        # 56000 <last_escape.1641>
        return 0;
   42212:	b8 00 00 00 00       	mov    $0x0,%eax
   42217:	e9 a6 01 00 00       	jmpq   423c2 <keyboard_readc+0x215>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4221c:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42220:	84 c0                	test   %al,%al
   42222:	79 5e                	jns    42282 <keyboard_readc+0xd5>
        int ch = keymap[(data & 0x7F) | escape];
   42224:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42228:	83 e0 7f             	and    $0x7f,%eax
   4222b:	89 c2                	mov    %eax,%edx
   4222d:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   42231:	09 d0                	or     %edx,%eax
   42233:	48 98                	cltq   
   42235:	0f b6 80 20 3c 04 00 	movzbl 0x43c20(%rax),%eax
   4223c:	0f b6 c0             	movzbl %al,%eax
   4223f:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42242:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42249:	7e 2d                	jle    42278 <keyboard_readc+0xcb>
   4224b:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42252:	7f 24                	jg     42278 <keyboard_readc+0xcb>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42254:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42257:	2d fa 00 00 00       	sub    $0xfa,%eax
   4225c:	ba 01 00 00 00       	mov    $0x1,%edx
   42261:	89 c1                	mov    %eax,%ecx
   42263:	d3 e2                	shl    %cl,%edx
   42265:	89 d0                	mov    %edx,%eax
   42267:	f7 d0                	not    %eax
   42269:	0f b6 15 91 3d 01 00 	movzbl 0x13d91(%rip),%edx        # 56001 <modifiers.1640>
   42270:	21 d0                	and    %edx,%eax
   42272:	88 05 89 3d 01 00    	mov    %al,0x13d89(%rip)        # 56001 <modifiers.1640>
        }
        return 0;
   42278:	b8 00 00 00 00       	mov    $0x0,%eax
   4227d:	e9 40 01 00 00       	jmpq   423c2 <keyboard_readc+0x215>
    }

    int ch = (unsigned char) keymap[data | escape];
   42282:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42286:	0a 45 fa             	or     -0x6(%rbp),%al
   42289:	0f b6 c0             	movzbl %al,%eax
   4228c:	48 98                	cltq   
   4228e:	0f b6 80 20 3c 04 00 	movzbl 0x43c20(%rax),%eax
   42295:	0f b6 c0             	movzbl %al,%eax
   42298:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4229b:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   4229f:	7e 57                	jle    422f8 <keyboard_readc+0x14b>
   422a1:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   422a5:	7f 51                	jg     422f8 <keyboard_readc+0x14b>
        if (modifiers & MOD_CONTROL) {
   422a7:	0f b6 05 53 3d 01 00 	movzbl 0x13d53(%rip),%eax        # 56001 <modifiers.1640>
   422ae:	0f b6 c0             	movzbl %al,%eax
   422b1:	83 e0 02             	and    $0x2,%eax
   422b4:	85 c0                	test   %eax,%eax
   422b6:	74 09                	je     422c1 <keyboard_readc+0x114>
            ch -= 0x60;
   422b8:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   422bc:	e9 fd 00 00 00       	jmpq   423be <keyboard_readc+0x211>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   422c1:	0f b6 05 39 3d 01 00 	movzbl 0x13d39(%rip),%eax        # 56001 <modifiers.1640>
   422c8:	0f b6 c0             	movzbl %al,%eax
   422cb:	83 e0 01             	and    $0x1,%eax
   422ce:	85 c0                	test   %eax,%eax
   422d0:	0f 94 c2             	sete   %dl
   422d3:	0f b6 05 27 3d 01 00 	movzbl 0x13d27(%rip),%eax        # 56001 <modifiers.1640>
   422da:	0f b6 c0             	movzbl %al,%eax
   422dd:	83 e0 08             	and    $0x8,%eax
   422e0:	85 c0                	test   %eax,%eax
   422e2:	0f 94 c0             	sete   %al
   422e5:	31 d0                	xor    %edx,%eax
   422e7:	84 c0                	test   %al,%al
   422e9:	0f 84 cf 00 00 00    	je     423be <keyboard_readc+0x211>
            ch -= 0x20;
   422ef:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   422f3:	e9 c6 00 00 00       	jmpq   423be <keyboard_readc+0x211>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   422f8:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   422ff:	7e 30                	jle    42331 <keyboard_readc+0x184>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42301:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42304:	2d fa 00 00 00       	sub    $0xfa,%eax
   42309:	ba 01 00 00 00       	mov    $0x1,%edx
   4230e:	89 c1                	mov    %eax,%ecx
   42310:	d3 e2                	shl    %cl,%edx
   42312:	89 d0                	mov    %edx,%eax
   42314:	89 c2                	mov    %eax,%edx
   42316:	0f b6 05 e4 3c 01 00 	movzbl 0x13ce4(%rip),%eax        # 56001 <modifiers.1640>
   4231d:	31 d0                	xor    %edx,%eax
   4231f:	88 05 dc 3c 01 00    	mov    %al,0x13cdc(%rip)        # 56001 <modifiers.1640>
        ch = 0;
   42325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4232c:	e9 8e 00 00 00       	jmpq   423bf <keyboard_readc+0x212>
    } else if (ch >= KEY_SHIFT) {
   42331:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42338:	7e 2d                	jle    42367 <keyboard_readc+0x1ba>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4233a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4233d:	2d fa 00 00 00       	sub    $0xfa,%eax
   42342:	ba 01 00 00 00       	mov    $0x1,%edx
   42347:	89 c1                	mov    %eax,%ecx
   42349:	d3 e2                	shl    %cl,%edx
   4234b:	89 d0                	mov    %edx,%eax
   4234d:	89 c2                	mov    %eax,%edx
   4234f:	0f b6 05 ab 3c 01 00 	movzbl 0x13cab(%rip),%eax        # 56001 <modifiers.1640>
   42356:	09 d0                	or     %edx,%eax
   42358:	88 05 a3 3c 01 00    	mov    %al,0x13ca3(%rip)        # 56001 <modifiers.1640>
        ch = 0;
   4235e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42365:	eb 58                	jmp    423bf <keyboard_readc+0x212>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42367:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4236b:	7e 31                	jle    4239e <keyboard_readc+0x1f1>
   4236d:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42374:	7f 28                	jg     4239e <keyboard_readc+0x1f1>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42376:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42379:	8d 50 80             	lea    -0x80(%rax),%edx
   4237c:	0f b6 05 7e 3c 01 00 	movzbl 0x13c7e(%rip),%eax        # 56001 <modifiers.1640>
   42383:	0f b6 c0             	movzbl %al,%eax
   42386:	83 e0 03             	and    $0x3,%eax
   42389:	48 98                	cltq   
   4238b:	48 63 d2             	movslq %edx,%rdx
   4238e:	0f b6 84 90 20 3d 04 	movzbl 0x43d20(%rax,%rdx,4),%eax
   42395:	00 
   42396:	0f b6 c0             	movzbl %al,%eax
   42399:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4239c:	eb 21                	jmp    423bf <keyboard_readc+0x212>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   4239e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   423a2:	7f 1b                	jg     423bf <keyboard_readc+0x212>
   423a4:	0f b6 05 56 3c 01 00 	movzbl 0x13c56(%rip),%eax        # 56001 <modifiers.1640>
   423ab:	0f b6 c0             	movzbl %al,%eax
   423ae:	83 e0 02             	and    $0x2,%eax
   423b1:	85 c0                	test   %eax,%eax
   423b3:	74 0a                	je     423bf <keyboard_readc+0x212>
        ch = 0;
   423b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   423bc:	eb 01                	jmp    423bf <keyboard_readc+0x212>
        if (modifiers & MOD_CONTROL) {
   423be:	90                   	nop
    }

    return ch;
   423bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   423c2:	c9                   	leaveq 
   423c3:	c3                   	retq   

00000000000423c4 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   423c4:	55                   	push   %rbp
   423c5:	48 89 e5             	mov    %rsp,%rbp
   423c8:	48 83 ec 20          	sub    $0x20,%rsp
   423cc:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   423d3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   423d6:	89 c2                	mov    %eax,%edx
   423d8:	ec                   	in     (%dx),%al
   423d9:	88 45 e3             	mov    %al,-0x1d(%rbp)
   423dc:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   423e3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   423e6:	89 c2                	mov    %eax,%edx
   423e8:	ec                   	in     (%dx),%al
   423e9:	88 45 eb             	mov    %al,-0x15(%rbp)
   423ec:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   423f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
   423f6:	89 c2                	mov    %eax,%edx
   423f8:	ec                   	in     (%dx),%al
   423f9:	88 45 f3             	mov    %al,-0xd(%rbp)
   423fc:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42403:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42406:	89 c2                	mov    %eax,%edx
   42408:	ec                   	in     (%dx),%al
   42409:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4240c:	90                   	nop
   4240d:	c9                   	leaveq 
   4240e:	c3                   	retq   

000000000004240f <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4240f:	55                   	push   %rbp
   42410:	48 89 e5             	mov    %rsp,%rbp
   42413:	48 83 ec 40          	sub    $0x40,%rsp
   42417:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4241b:	89 f0                	mov    %esi,%eax
   4241d:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42420:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42423:	8b 05 db 3b 01 00    	mov    0x13bdb(%rip),%eax        # 56004 <initialized.1654>
   42429:	85 c0                	test   %eax,%eax
   4242b:	75 1e                	jne    4244b <parallel_port_putc+0x3c>
   4242d:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42434:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42438:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4243c:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4243f:	ee                   	out    %al,(%dx)
}
   42440:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42441:	c7 05 b9 3b 01 00 01 	movl   $0x1,0x13bb9(%rip)        # 56004 <initialized.1654>
   42448:	00 00 00 
    }

    for (int i = 0;
   4244b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42452:	eb 09                	jmp    4245d <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42454:	e8 6b ff ff ff       	callq  423c4 <delay>
         ++i) {
   42459:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    for (int i = 0;
   4245d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42464:	7f 18                	jg     4247e <parallel_port_putc+0x6f>
   42466:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4246d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42470:	89 c2                	mov    %eax,%edx
   42472:	ec                   	in     (%dx),%al
   42473:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42476:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4247a:	84 c0                	test   %al,%al
   4247c:	79 d6                	jns    42454 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   4247e:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42482:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   42489:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4248c:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42490:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42493:	ee                   	out    %al,(%dx)
}
   42494:	90                   	nop
   42495:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4249c:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424a0:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   424a4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   424a7:	ee                   	out    %al,(%dx)
}
   424a8:	90                   	nop
   424a9:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   424b0:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   424b4:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   424b8:	8b 55 e8             	mov    -0x18(%rbp),%edx
   424bb:	ee                   	out    %al,(%dx)
}
   424bc:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   424bd:	90                   	nop
   424be:	c9                   	leaveq 
   424bf:	c3                   	retq   

00000000000424c0 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   424c0:	55                   	push   %rbp
   424c1:	48 89 e5             	mov    %rsp,%rbp
   424c4:	48 83 ec 20          	sub    $0x20,%rsp
   424c8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   424cc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   424d0:	48 c7 45 f8 0f 24 04 	movq   $0x4240f,-0x8(%rbp)
   424d7:	00 
    printer_vprintf(&p, 0, format, val);
   424d8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   424dc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   424e0:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   424e4:	be 00 00 00 00       	mov    $0x0,%esi
   424e9:	48 89 c7             	mov    %rax,%rdi
   424ec:	e8 e6 07 00 00       	callq  42cd7 <printer_vprintf>
}
   424f1:	90                   	nop
   424f2:	c9                   	leaveq 
   424f3:	c3                   	retq   

00000000000424f4 <log_printf>:

void log_printf(const char* format, ...) {
   424f4:	55                   	push   %rbp
   424f5:	48 89 e5             	mov    %rsp,%rbp
   424f8:	48 83 ec 60          	sub    $0x60,%rsp
   424fc:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42500:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42504:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42508:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4250c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42510:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42514:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4251b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4251f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42523:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42527:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4252b:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4252f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42533:	48 89 d6             	mov    %rdx,%rsi
   42536:	48 89 c7             	mov    %rax,%rdi
   42539:	e8 82 ff ff ff       	callq  424c0 <log_vprintf>
    va_end(val);
}
   4253e:	90                   	nop
   4253f:	c9                   	leaveq 
   42540:	c3                   	retq   

0000000000042541 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42541:	55                   	push   %rbp
   42542:	48 89 e5             	mov    %rsp,%rbp
   42545:	48 83 ec 40          	sub    $0x40,%rsp
   42549:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4254c:	89 75 d8             	mov    %esi,-0x28(%rbp)
   4254f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42553:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42557:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4255b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4255f:	48 8b 0a             	mov    (%rdx),%rcx
   42562:	48 89 08             	mov    %rcx,(%rax)
   42565:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42569:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4256d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42571:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42575:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42579:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4257d:	48 89 d6             	mov    %rdx,%rsi
   42580:	48 89 c7             	mov    %rax,%rdi
   42583:	e8 38 ff ff ff       	callq  424c0 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   42588:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4258c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42590:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42593:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42596:	89 c7                	mov    %eax,%edi
   42598:	e8 23 0e 00 00       	callq  433c0 <console_vprintf>
}
   4259d:	c9                   	leaveq 
   4259e:	c3                   	retq   

000000000004259f <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   4259f:	55                   	push   %rbp
   425a0:	48 89 e5             	mov    %rsp,%rbp
   425a3:	48 83 ec 60          	sub    $0x60,%rsp
   425a7:	89 7d ac             	mov    %edi,-0x54(%rbp)
   425aa:	89 75 a8             	mov    %esi,-0x58(%rbp)
   425ad:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   425b1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   425b5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   425b9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   425bd:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   425c4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   425c8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   425cc:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   425d0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   425d4:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   425d8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   425dc:	8b 75 a8             	mov    -0x58(%rbp),%esi
   425df:	8b 45 ac             	mov    -0x54(%rbp),%eax
   425e2:	89 c7                	mov    %eax,%edi
   425e4:	e8 58 ff ff ff       	callq  42541 <error_vprintf>
   425e9:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   425ec:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   425ef:	c9                   	leaveq 
   425f0:	c3                   	retq   

00000000000425f1 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   425f1:	55                   	push   %rbp
   425f2:	48 89 e5             	mov    %rsp,%rbp
   425f5:	53                   	push   %rbx
   425f6:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   425fa:	e8 ae fb ff ff       	callq  421ad <keyboard_readc>
   425ff:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e') {
   42602:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42606:	74 10                	je     42618 <check_keyboard+0x27>
   42608:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   4260c:	74 0a                	je     42618 <check_keyboard+0x27>
   4260e:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42612:	0f 85 c9 00 00 00    	jne    426e1 <check_keyboard+0xf0>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42618:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4261f:	00 
        memset(pt, 0, PAGESIZE * 3);
   42620:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42624:	ba 00 30 00 00       	mov    $0x3000,%edx
   42629:	be 00 00 00 00       	mov    $0x0,%esi
   4262e:	48 89 c7             	mov    %rax,%rdi
   42631:	e8 91 05 00 00       	callq  42bc7 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42636:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4263a:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42641:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42645:	48 05 00 10 00 00    	add    $0x1000,%rax
   4264b:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42652:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42656:	48 05 00 20 00 00    	add    $0x2000,%rax
   4265c:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42663:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42667:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4266b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4266f:	0f 22 d8             	mov    %rax,%cr3
}
   42672:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42673:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   4267a:	48 c7 45 e8 78 3d 04 	movq   $0x43d78,-0x18(%rbp)
   42681:	00 
        if (c == 'a') {
   42682:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42686:	75 0a                	jne    42692 <check_keyboard+0xa1>
            argument = "allocator";
   42688:	48 c7 45 e8 7d 3d 04 	movq   $0x43d7d,-0x18(%rbp)
   4268f:	00 
   42690:	eb 0e                	jmp    426a0 <check_keyboard+0xaf>
        } else if (c == 'e') {
   42692:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42696:	75 08                	jne    426a0 <check_keyboard+0xaf>
            argument = "forkexit";
   42698:	48 c7 45 e8 87 3d 04 	movq   $0x43d87,-0x18(%rbp)
   4269f:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   426a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426a4:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   426a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   426ad:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   426b1:	76 14                	jbe    426c7 <check_keyboard+0xd6>
   426b3:	ba 90 3d 04 00       	mov    $0x43d90,%edx
   426b8:	be f2 02 00 00       	mov    $0x2f2,%esi
   426bd:	bf 15 39 04 00       	mov    $0x43915,%edi
   426c2:	e8 20 01 00 00       	callq  427e7 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   426c7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   426cb:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   426ce:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   426d2:	48 89 c3             	mov    %rax,%rbx
   426d5:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   426da:	e9 21 d9 ff ff       	jmpq   40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e') {
   426df:	eb 11                	jmp    426f2 <check_keyboard+0x101>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   426e1:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   426e5:	74 06                	je     426ed <check_keyboard+0xfc>
   426e7:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   426eb:	75 05                	jne    426f2 <check_keyboard+0x101>
        poweroff();
   426ed:	e8 dc f8 ff ff       	callq  41fce <poweroff>
    }
    return c;
   426f2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   426f5:	48 83 c4 48          	add    $0x48,%rsp
   426f9:	5b                   	pop    %rbx
   426fa:	5d                   	pop    %rbp
   426fb:	c3                   	retq   

00000000000426fc <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   426fc:	55                   	push   %rbp
   426fd:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42700:	e8 ec fe ff ff       	callq  425f1 <check_keyboard>
   42705:	eb f9                	jmp    42700 <fail+0x4>

0000000000042707 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42707:	55                   	push   %rbp
   42708:	48 89 e5             	mov    %rsp,%rbp
   4270b:	48 83 ec 60          	sub    $0x60,%rsp
   4270f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42713:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42717:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   4271b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4271f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42723:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42727:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4272e:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42732:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42736:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4273a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4273e:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42743:	0f 84 80 00 00 00    	je     427c9 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42749:	ba ac 3d 04 00       	mov    $0x43dac,%edx
   4274e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42753:	bf 30 07 00 00       	mov    $0x730,%edi
   42758:	b8 00 00 00 00       	mov    $0x0,%eax
   4275d:	e8 3d fe ff ff       	callq  4259f <error_printf>
   42762:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42765:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42769:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4276d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42770:	be 00 c0 00 00       	mov    $0xc000,%esi
   42775:	89 c7                	mov    %eax,%edi
   42777:	e8 c5 fd ff ff       	callq  42541 <error_vprintf>
   4277c:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4277f:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42782:	48 63 c1             	movslq %ecx,%rax
   42785:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4278c:	48 c1 e8 20          	shr    $0x20,%rax
   42790:	89 c2                	mov    %eax,%edx
   42792:	c1 fa 05             	sar    $0x5,%edx
   42795:	89 c8                	mov    %ecx,%eax
   42797:	c1 f8 1f             	sar    $0x1f,%eax
   4279a:	29 c2                	sub    %eax,%edx
   4279c:	89 d0                	mov    %edx,%eax
   4279e:	c1 e0 02             	shl    $0x2,%eax
   427a1:	01 d0                	add    %edx,%eax
   427a3:	c1 e0 04             	shl    $0x4,%eax
   427a6:	29 c1                	sub    %eax,%ecx
   427a8:	89 ca                	mov    %ecx,%edx
   427aa:	85 d2                	test   %edx,%edx
   427ac:	74 34                	je     427e2 <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   427ae:	8b 45 cc             	mov    -0x34(%rbp),%eax
   427b1:	ba b4 3d 04 00       	mov    $0x43db4,%edx
   427b6:	be 00 c0 00 00       	mov    $0xc000,%esi
   427bb:	89 c7                	mov    %eax,%edi
   427bd:	b8 00 00 00 00       	mov    $0x0,%eax
   427c2:	e8 d8 fd ff ff       	callq  4259f <error_printf>
   427c7:	eb 19                	jmp    427e2 <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   427c9:	ba b6 3d 04 00       	mov    $0x43db6,%edx
   427ce:	be 00 c0 00 00       	mov    $0xc000,%esi
   427d3:	bf 30 07 00 00       	mov    $0x730,%edi
   427d8:	b8 00 00 00 00       	mov    $0x0,%eax
   427dd:	e8 bd fd ff ff       	callq  4259f <error_printf>
    }

    va_end(val);
    fail();
   427e2:	e8 15 ff ff ff       	callq  426fc <fail>

00000000000427e7 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   427e7:	55                   	push   %rbp
   427e8:	48 89 e5             	mov    %rsp,%rbp
   427eb:	48 83 ec 20          	sub    $0x20,%rsp
   427ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   427f3:	89 75 f4             	mov    %esi,-0xc(%rbp)
   427f6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   427fa:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   427fe:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42801:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42805:	48 89 c6             	mov    %rax,%rsi
   42808:	bf bc 3d 04 00       	mov    $0x43dbc,%edi
   4280d:	b8 00 00 00 00       	mov    $0x0,%eax
   42812:	e8 f0 fe ff ff       	callq  42707 <panic>

0000000000042817 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42817:	55                   	push   %rbp
   42818:	48 89 e5             	mov    %rsp,%rbp
   4281b:	48 83 ec 40          	sub    $0x40,%rsp
   4281f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42823:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42826:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   4282a:	c7 45 f8 06 00 00 00 	movl   $0x6,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42831:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42835:	78 08                	js     4283f <program_load+0x28>
   42837:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   4283a:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   4283d:	7c 14                	jl     42853 <program_load+0x3c>
   4283f:	ba e0 3d 04 00       	mov    $0x43de0,%edx
   42844:	be 34 00 00 00       	mov    $0x34,%esi
   42849:	bf 10 3e 04 00       	mov    $0x43e10,%edi
   4284e:	e8 94 ff ff ff       	callq  427e7 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42853:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42856:	48 98                	cltq   
   42858:	48 c1 e0 04          	shl    $0x4,%rax
   4285c:	48 05 20 50 04 00    	add    $0x45020,%rax
   42862:	48 8b 00             	mov    (%rax),%rax
   42865:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42869:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4286d:	8b 00                	mov    (%rax),%eax
   4286f:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42874:	74 14                	je     4288a <program_load+0x73>
   42876:	ba 1b 3e 04 00       	mov    $0x43e1b,%edx
   4287b:	be 36 00 00 00       	mov    $0x36,%esi
   42880:	bf 10 3e 04 00       	mov    $0x43e10,%edi
   42885:	e8 5d ff ff ff       	callq  427e7 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   4288a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4288e:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42892:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42896:	48 01 d0             	add    %rdx,%rax
   42899:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   4289d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   428a4:	e9 94 00 00 00       	jmpq   4293d <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   428a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428ac:	48 63 d0             	movslq %eax,%rdx
   428af:	48 89 d0             	mov    %rdx,%rax
   428b2:	48 c1 e0 03          	shl    $0x3,%rax
   428b6:	48 29 d0             	sub    %rdx,%rax
   428b9:	48 c1 e0 03          	shl    $0x3,%rax
   428bd:	48 89 c2             	mov    %rax,%rdx
   428c0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428c4:	48 01 d0             	add    %rdx,%rax
   428c7:	8b 00                	mov    (%rax),%eax
   428c9:	83 f8 01             	cmp    $0x1,%eax
   428cc:	75 6b                	jne    42939 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   428ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428d1:	48 63 d0             	movslq %eax,%rdx
   428d4:	48 89 d0             	mov    %rdx,%rax
   428d7:	48 c1 e0 03          	shl    $0x3,%rax
   428db:	48 29 d0             	sub    %rdx,%rax
   428de:	48 c1 e0 03          	shl    $0x3,%rax
   428e2:	48 89 c2             	mov    %rax,%rdx
   428e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   428e9:	48 01 d0             	add    %rdx,%rax
   428ec:	48 8b 50 08          	mov    0x8(%rax),%rdx
   428f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   428f4:	48 01 d0             	add    %rdx,%rax
   428f7:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   428fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   428fe:	48 63 d0             	movslq %eax,%rdx
   42901:	48 89 d0             	mov    %rdx,%rax
   42904:	48 c1 e0 03          	shl    $0x3,%rax
   42908:	48 29 d0             	sub    %rdx,%rax
   4290b:	48 c1 e0 03          	shl    $0x3,%rax
   4290f:	48 89 c2             	mov    %rax,%rdx
   42912:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42916:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   4291a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4291e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42922:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42926:	48 89 c7             	mov    %rax,%rdi
   42929:	e8 3d 00 00 00       	callq  4296b <program_load_segment>
   4292e:	85 c0                	test   %eax,%eax
   42930:	79 07                	jns    42939 <program_load+0x122>
                return -1;
   42932:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42937:	eb 30                	jmp    42969 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42939:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4293d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42941:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42945:	0f b7 c0             	movzwl %ax,%eax
   42948:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4294b:	0f 8c 58 ff ff ff    	jl     428a9 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42951:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42955:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42959:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4295d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   42964:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42969:	c9                   	leaveq 
   4296a:	c3                   	retq   

000000000004296b <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   4296b:	55                   	push   %rbp
   4296c:	48 89 e5             	mov    %rsp,%rbp
   4296f:	48 83 ec 40          	sub    $0x40,%rsp
   42973:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42977:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   4297b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   4297f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42983:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42987:	48 8b 40 10          	mov    0x10(%rax),%rax
   4298b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4298f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42993:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42997:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4299b:	48 01 d0             	add    %rdx,%rax
   4299e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   429a2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   429a6:	48 8b 50 28          	mov    0x28(%rax),%rdx
   429aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   429ae:	48 01 d0             	add    %rdx,%rax
   429b1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   429b5:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   429bc:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   429bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   429c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   429c5:	e9 83 00 00 00       	jmpq   42a4d <program_load_segment+0xe2>
        if (assign_physical_page(addr, p->p_pid) < 0
   429ca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429ce:	8b 00                	mov    (%rax),%eax
   429d0:	0f be d0             	movsbl %al,%edx
   429d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   429d7:	89 d6                	mov    %edx,%esi
   429d9:	48 89 c7             	mov    %rax,%rdi
   429dc:	e8 84 da ff ff       	callq  40465 <assign_physical_page>
   429e1:	85 c0                	test   %eax,%eax
   429e3:	78 31                	js     42a16 <program_load_segment+0xab>
            || virtual_memory_map(p->p_pagetable, addr, addr, PAGESIZE,
   429e5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   429e9:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   429f0:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   429f4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   429f8:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   429fc:	49 89 c9             	mov    %rcx,%r9
   429ff:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42a05:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42a0a:	48 89 c7             	mov    %rax,%rdi
   42a0d:	e8 61 ee ff ff       	callq  41873 <virtual_memory_map>
   42a12:	85 c0                	test   %eax,%eax
   42a14:	79 2f                	jns    42a45 <program_load_segment+0xda>
                                  PTE_P | PTE_W | PTE_U, allocator) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   42a16:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a1a:	8b 00                	mov    (%rax),%eax
   42a1c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42a20:	49 89 d0             	mov    %rdx,%r8
   42a23:	89 c1                	mov    %eax,%ecx
   42a25:	ba 38 3e 04 00       	mov    $0x43e38,%edx
   42a2a:	be 00 c0 00 00       	mov    $0xc000,%esi
   42a2f:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42a34:	b8 00 00 00 00       	mov    $0x0,%eax
   42a39:	e8 c7 09 00 00       	callq  43405 <console_printf>
            return -1;
   42a3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42a43:	eb 77                	jmp    42abc <program_load_segment+0x151>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42a45:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42a4c:	00 
   42a4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42a51:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   42a55:	0f 82 6f ff ff ff    	jb     429ca <program_load_segment+0x5f>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42a5b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a5f:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   42a66:	48 89 c7             	mov    %rax,%rdi
   42a69:	e8 f3 f2 ff ff       	callq  41d61 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42a6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a72:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
   42a76:	48 89 c2             	mov    %rax,%rdx
   42a79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42a7d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42a81:	48 89 ce             	mov    %rcx,%rsi
   42a84:	48 89 c7             	mov    %rax,%rdi
   42a87:	e8 d2 00 00 00       	callq  42b5e <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42a8c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a90:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42a94:	48 89 c2             	mov    %rax,%rdx
   42a97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42a9b:	be 00 00 00 00       	mov    $0x0,%esi
   42aa0:	48 89 c7             	mov    %rax,%rdi
   42aa3:	e8 1f 01 00 00       	callq  42bc7 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   42aa8:	48 8b 05 69 35 01 00 	mov    0x13569(%rip),%rax        # 56018 <kernel_pagetable>
   42aaf:	48 89 c7             	mov    %rax,%rdi
   42ab2:	e8 aa f2 ff ff       	callq  41d61 <set_pagetable>
    return 0;
   42ab7:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42abc:	c9                   	leaveq 
   42abd:	c3                   	retq   

0000000000042abe <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   42abe:	41 89 d0             	mov    %edx,%r8d
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   42ac1:	48 81 7f 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rdi)
   42ac8:	00 
   42ac9:	72 08                	jb     42ad3 <console_putc+0x15>
        cp->cursor = console;
   42acb:	48 c7 47 08 00 80 0b 	movq   $0xb8000,0x8(%rdi)
   42ad2:	00 
    }
    if (c == '\n') {
   42ad3:	40 80 fe 0a          	cmp    $0xa,%sil
   42ad7:	74 17                	je     42af0 <console_putc+0x32>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   42ad9:	48 8b 47 08          	mov    0x8(%rdi),%rax
   42add:	48 8d 50 02          	lea    0x2(%rax),%rdx
   42ae1:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   42ae5:	40 0f b6 f6          	movzbl %sil,%esi
   42ae9:	44 09 c6             	or     %r8d,%esi
   42aec:	66 89 30             	mov    %si,(%rax)
    }
}
   42aef:	c3                   	retq   
        int pos = (cp->cursor - console) % 80;
   42af0:	48 8b 77 08          	mov    0x8(%rdi),%rsi
   42af4:	48 81 ee 00 80 0b 00 	sub    $0xb8000,%rsi
   42afb:	48 89 f1             	mov    %rsi,%rcx
   42afe:	48 d1 f9             	sar    %rcx
   42b01:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   42b08:	66 66 66 
   42b0b:	48 89 c8             	mov    %rcx,%rax
   42b0e:	48 f7 ea             	imul   %rdx
   42b11:	48 c1 fa 05          	sar    $0x5,%rdx
   42b15:	48 c1 fe 3f          	sar    $0x3f,%rsi
   42b19:	48 29 f2             	sub    %rsi,%rdx
   42b1c:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
   42b20:	48 c1 e0 04          	shl    $0x4,%rax
   42b24:	89 ca                	mov    %ecx,%edx
   42b26:	29 c2                	sub    %eax,%edx
   42b28:	89 d0                	mov    %edx,%eax
            *cp->cursor++ = ' ' | color;
   42b2a:	44 89 c6             	mov    %r8d,%esi
   42b2d:	83 ce 20             	or     $0x20,%esi
   42b30:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
   42b34:	4c 8d 41 02          	lea    0x2(%rcx),%r8
   42b38:	4c 89 47 08          	mov    %r8,0x8(%rdi)
   42b3c:	66 89 31             	mov    %si,(%rcx)
        for (; pos != 80; pos++) {
   42b3f:	83 c0 01             	add    $0x1,%eax
   42b42:	83 f8 50             	cmp    $0x50,%eax
   42b45:	75 e9                	jne    42b30 <console_putc+0x72>
   42b47:	c3                   	retq   

0000000000042b48 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   42b48:	48 8b 47 08          	mov    0x8(%rdi),%rax
   42b4c:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   42b50:	73 0b                	jae    42b5d <string_putc+0x15>
        *sp->s++ = c;
   42b52:	48 8d 50 01          	lea    0x1(%rax),%rdx
   42b56:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   42b5a:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   42b5d:	c3                   	retq   

0000000000042b5e <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   42b5e:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42b61:	48 85 d2             	test   %rdx,%rdx
   42b64:	74 17                	je     42b7d <memcpy+0x1f>
   42b66:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   42b6b:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   42b70:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   42b74:	48 83 c1 01          	add    $0x1,%rcx
   42b78:	48 39 d1             	cmp    %rdx,%rcx
   42b7b:	75 ee                	jne    42b6b <memcpy+0xd>
}
   42b7d:	c3                   	retq   

0000000000042b7e <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   42b7e:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   42b81:	48 39 fe             	cmp    %rdi,%rsi
   42b84:	72 1d                	jb     42ba3 <memmove+0x25>
        while (n-- > 0) {
   42b86:	b9 00 00 00 00       	mov    $0x0,%ecx
   42b8b:	48 85 d2             	test   %rdx,%rdx
   42b8e:	74 12                	je     42ba2 <memmove+0x24>
            *d++ = *s++;
   42b90:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   42b94:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   42b98:	48 83 c1 01          	add    $0x1,%rcx
   42b9c:	48 39 ca             	cmp    %rcx,%rdx
   42b9f:	75 ef                	jne    42b90 <memmove+0x12>
}
   42ba1:	c3                   	retq   
   42ba2:	c3                   	retq   
    if (s < d && s + n > d) {
   42ba3:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   42ba7:	48 39 cf             	cmp    %rcx,%rdi
   42baa:	73 da                	jae    42b86 <memmove+0x8>
        while (n-- > 0) {
   42bac:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   42bb0:	48 85 d2             	test   %rdx,%rdx
   42bb3:	74 ec                	je     42ba1 <memmove+0x23>
            *--d = *--s;
   42bb5:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   42bb9:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   42bbc:	48 83 e9 01          	sub    $0x1,%rcx
   42bc0:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   42bc4:	75 ef                	jne    42bb5 <memmove+0x37>
   42bc6:	c3                   	retq   

0000000000042bc7 <memset>:
void* memset(void* v, int c, size_t n) {
   42bc7:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42bca:	48 85 d2             	test   %rdx,%rdx
   42bcd:	74 13                	je     42be2 <memset+0x1b>
   42bcf:	48 8d 0c 17          	lea    (%rdi,%rdx,1),%rcx
   42bd3:	48 89 fa             	mov    %rdi,%rdx
        *p = c;
   42bd6:	40 88 32             	mov    %sil,(%rdx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   42bd9:	48 83 c2 01          	add    $0x1,%rdx
   42bdd:	48 39 d1             	cmp    %rdx,%rcx
   42be0:	75 f4                	jne    42bd6 <memset+0xf>
}
   42be2:	c3                   	retq   

0000000000042be3 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   42be3:	80 3f 00             	cmpb   $0x0,(%rdi)
   42be6:	74 10                	je     42bf8 <strlen+0x15>
   42be8:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   42bed:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   42bf1:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   42bf5:	75 f6                	jne    42bed <strlen+0xa>
   42bf7:	c3                   	retq   
   42bf8:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42bfd:	c3                   	retq   

0000000000042bfe <strnlen>:
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42bfe:	b8 00 00 00 00       	mov    $0x0,%eax
   42c03:	48 85 f6             	test   %rsi,%rsi
   42c06:	74 10                	je     42c18 <strnlen+0x1a>
   42c08:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   42c0c:	74 09                	je     42c17 <strnlen+0x19>
        ++n;
   42c0e:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42c12:	48 39 c6             	cmp    %rax,%rsi
   42c15:	75 f1                	jne    42c08 <strnlen+0xa>
}
   42c17:	c3                   	retq   
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   42c18:	48 89 f0             	mov    %rsi,%rax
   42c1b:	c3                   	retq   

0000000000042c1c <strcpy>:
char* strcpy(char* dst, const char* src) {
   42c1c:	48 89 f8             	mov    %rdi,%rax
   42c1f:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   42c24:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   42c28:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   42c2b:	48 83 c2 01          	add    $0x1,%rdx
   42c2f:	84 c9                	test   %cl,%cl
   42c31:	75 f1                	jne    42c24 <strcpy+0x8>
}
   42c33:	c3                   	retq   

0000000000042c34 <strcmp>:
    while (*a && *b && *a == *b) {
   42c34:	0f b6 17             	movzbl (%rdi),%edx
   42c37:	84 d2                	test   %dl,%dl
   42c39:	74 1a                	je     42c55 <strcmp+0x21>
   42c3b:	0f b6 06             	movzbl (%rsi),%eax
   42c3e:	38 d0                	cmp    %dl,%al
   42c40:	75 13                	jne    42c55 <strcmp+0x21>
   42c42:	84 c0                	test   %al,%al
   42c44:	74 0f                	je     42c55 <strcmp+0x21>
        ++a, ++b;
   42c46:	48 83 c7 01          	add    $0x1,%rdi
   42c4a:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   42c4e:	0f b6 17             	movzbl (%rdi),%edx
   42c51:	84 d2                	test   %dl,%dl
   42c53:	75 e6                	jne    42c3b <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   42c55:	0f b6 0e             	movzbl (%rsi),%ecx
   42c58:	38 ca                	cmp    %cl,%dl
   42c5a:	0f 97 c0             	seta   %al
   42c5d:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   42c60:	83 d8 00             	sbb    $0x0,%eax
}
   42c63:	c3                   	retq   

0000000000042c64 <strchr>:
    while (*s && *s != (char) c) {
   42c64:	0f b6 07             	movzbl (%rdi),%eax
   42c67:	84 c0                	test   %al,%al
   42c69:	74 10                	je     42c7b <strchr+0x17>
   42c6b:	40 38 f0             	cmp    %sil,%al
   42c6e:	74 18                	je     42c88 <strchr+0x24>
        ++s;
   42c70:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   42c74:	0f b6 07             	movzbl (%rdi),%eax
   42c77:	84 c0                	test   %al,%al
   42c79:	75 f0                	jne    42c6b <strchr+0x7>
        return NULL;
   42c7b:	40 84 f6             	test   %sil,%sil
   42c7e:	b8 00 00 00 00       	mov    $0x0,%eax
   42c83:	48 0f 44 c7          	cmove  %rdi,%rax
}
   42c87:	c3                   	retq   
   42c88:	48 89 f8             	mov    %rdi,%rax
   42c8b:	c3                   	retq   

0000000000042c8c <rand>:
    if (!rand_seed_set) {
   42c8c:	83 3d 79 33 01 00 00 	cmpl   $0x0,0x13379(%rip)        # 5600c <rand_seed_set>
   42c93:	74 1b                	je     42cb0 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   42c95:	69 05 69 33 01 00 0d 	imul   $0x19660d,0x13369(%rip),%eax        # 56008 <rand_seed>
   42c9c:	66 19 00 
   42c9f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   42ca4:	89 05 5e 33 01 00    	mov    %eax,0x1335e(%rip)        # 56008 <rand_seed>
    return rand_seed & RAND_MAX;
   42caa:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   42caf:	c3                   	retq   
    rand_seed = seed;
   42cb0:	c7 05 4e 33 01 00 9e 	movl   $0x30d4879e,0x1334e(%rip)        # 56008 <rand_seed>
   42cb7:	87 d4 30 
    rand_seed_set = 1;
   42cba:	c7 05 48 33 01 00 01 	movl   $0x1,0x13348(%rip)        # 5600c <rand_seed_set>
   42cc1:	00 00 00 
}
   42cc4:	eb cf                	jmp    42c95 <rand+0x9>

0000000000042cc6 <srand>:
    rand_seed = seed;
   42cc6:	89 3d 3c 33 01 00    	mov    %edi,0x1333c(%rip)        # 56008 <rand_seed>
    rand_seed_set = 1;
   42ccc:	c7 05 36 33 01 00 01 	movl   $0x1,0x13336(%rip)        # 5600c <rand_seed_set>
   42cd3:	00 00 00 
}
   42cd6:	c3                   	retq   

0000000000042cd7 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   42cd7:	55                   	push   %rbp
   42cd8:	48 89 e5             	mov    %rsp,%rbp
   42cdb:	41 57                	push   %r15
   42cdd:	41 56                	push   %r14
   42cdf:	41 55                	push   %r13
   42ce1:	41 54                	push   %r12
   42ce3:	53                   	push   %rbx
   42ce4:	48 83 ec 58          	sub    $0x58,%rsp
   42ce8:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   42cec:	0f b6 02             	movzbl (%rdx),%eax
   42cef:	84 c0                	test   %al,%al
   42cf1:	0f 84 ba 06 00 00    	je     433b1 <printer_vprintf+0x6da>
   42cf7:	49 89 fe             	mov    %rdi,%r14
   42cfa:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   42cfd:	c7 45 80 01 00 00 00 	movl   $0x1,-0x80(%rbp)
   42d04:	41 89 f7             	mov    %esi,%r15d
   42d07:	e9 a5 04 00 00       	jmpq   431b1 <printer_vprintf+0x4da>
        for (++format; *format; ++format) {
   42d0c:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   42d11:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   42d17:	45 84 e4             	test   %r12b,%r12b
   42d1a:	0f 84 85 06 00 00    	je     433a5 <printer_vprintf+0x6ce>
        int flags = 0;
   42d20:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   42d26:	41 0f be f4          	movsbl %r12b,%esi
   42d2a:	bf 71 40 04 00       	mov    $0x44071,%edi
   42d2f:	e8 30 ff ff ff       	callq  42c64 <strchr>
   42d34:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   42d37:	48 85 c0             	test   %rax,%rax
   42d3a:	74 55                	je     42d91 <printer_vprintf+0xba>
                flags |= 1 << (flagc - flag_chars);
   42d3c:	48 81 e9 71 40 04 00 	sub    $0x44071,%rcx
   42d43:	b8 01 00 00 00       	mov    $0x1,%eax
   42d48:	d3 e0                	shl    %cl,%eax
   42d4a:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   42d4d:	48 83 c3 01          	add    $0x1,%rbx
   42d51:	44 0f b6 23          	movzbl (%rbx),%r12d
   42d55:	45 84 e4             	test   %r12b,%r12b
   42d58:	75 cc                	jne    42d26 <printer_vprintf+0x4f>
   42d5a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   42d5e:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   42d64:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   42d6b:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   42d6e:	0f 84 a9 00 00 00    	je     42e1d <printer_vprintf+0x146>
        int length = 0;
   42d74:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   42d79:	0f b6 13             	movzbl (%rbx),%edx
   42d7c:	8d 42 bd             	lea    -0x43(%rdx),%eax
   42d7f:	3c 37                	cmp    $0x37,%al
   42d81:	0f 87 c5 04 00 00    	ja     4324c <printer_vprintf+0x575>
   42d87:	0f b6 c0             	movzbl %al,%eax
   42d8a:	ff 24 c5 80 3e 04 00 	jmpq   *0x43e80(,%rax,8)
   42d91:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        if (*format >= '1' && *format <= '9') {
   42d95:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   42d9a:	3c 08                	cmp    $0x8,%al
   42d9c:	77 2f                	ja     42dcd <printer_vprintf+0xf6>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   42d9e:	0f b6 03             	movzbl (%rbx),%eax
   42da1:	8d 50 d0             	lea    -0x30(%rax),%edx
   42da4:	80 fa 09             	cmp    $0x9,%dl
   42da7:	77 5e                	ja     42e07 <printer_vprintf+0x130>
   42da9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   42daf:	48 83 c3 01          	add    $0x1,%rbx
   42db3:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   42db8:	0f be c0             	movsbl %al,%eax
   42dbb:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   42dc0:	0f b6 03             	movzbl (%rbx),%eax
   42dc3:	8d 50 d0             	lea    -0x30(%rax),%edx
   42dc6:	80 fa 09             	cmp    $0x9,%dl
   42dc9:	76 e4                	jbe    42daf <printer_vprintf+0xd8>
   42dcb:	eb 97                	jmp    42d64 <printer_vprintf+0x8d>
        } else if (*format == '*') {
   42dcd:	41 80 fc 2a          	cmp    $0x2a,%r12b
   42dd1:	75 3f                	jne    42e12 <printer_vprintf+0x13b>
            width = va_arg(val, int);
   42dd3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42dd7:	8b 01                	mov    (%rcx),%eax
   42dd9:	83 f8 2f             	cmp    $0x2f,%eax
   42ddc:	77 17                	ja     42df5 <printer_vprintf+0x11e>
   42dde:	89 c2                	mov    %eax,%edx
   42de0:	48 03 51 10          	add    0x10(%rcx),%rdx
   42de4:	83 c0 08             	add    $0x8,%eax
   42de7:	89 01                	mov    %eax,(%rcx)
   42de9:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   42dec:	48 83 c3 01          	add    $0x1,%rbx
   42df0:	e9 6f ff ff ff       	jmpq   42d64 <printer_vprintf+0x8d>
            width = va_arg(val, int);
   42df5:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42df9:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   42dfd:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42e01:	48 89 47 08          	mov    %rax,0x8(%rdi)
   42e05:	eb e2                	jmp    42de9 <printer_vprintf+0x112>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   42e07:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   42e0d:	e9 52 ff ff ff       	jmpq   42d64 <printer_vprintf+0x8d>
        int width = -1;
   42e12:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   42e18:	e9 47 ff ff ff       	jmpq   42d64 <printer_vprintf+0x8d>
            ++format;
   42e1d:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   42e21:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   42e25:	8d 48 d0             	lea    -0x30(%rax),%ecx
   42e28:	80 f9 09             	cmp    $0x9,%cl
   42e2b:	76 13                	jbe    42e40 <printer_vprintf+0x169>
            } else if (*format == '*') {
   42e2d:	3c 2a                	cmp    $0x2a,%al
   42e2f:	74 32                	je     42e63 <printer_vprintf+0x18c>
            ++format;
   42e31:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   42e34:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   42e3b:	e9 34 ff ff ff       	jmpq   42d74 <printer_vprintf+0x9d>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   42e40:	be 00 00 00 00       	mov    $0x0,%esi
                    precision = 10 * precision + *format++ - '0';
   42e45:	48 83 c2 01          	add    $0x1,%rdx
   42e49:	8d 0c b6             	lea    (%rsi,%rsi,4),%ecx
   42e4c:	0f be c0             	movsbl %al,%eax
   42e4f:	8d 74 48 d0          	lea    -0x30(%rax,%rcx,2),%esi
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   42e53:	0f b6 02             	movzbl (%rdx),%eax
   42e56:	8d 48 d0             	lea    -0x30(%rax),%ecx
   42e59:	80 f9 09             	cmp    $0x9,%cl
   42e5c:	76 e7                	jbe    42e45 <printer_vprintf+0x16e>
                    precision = 10 * precision + *format++ - '0';
   42e5e:	48 89 d3             	mov    %rdx,%rbx
   42e61:	eb 1c                	jmp    42e7f <printer_vprintf+0x1a8>
                precision = va_arg(val, int);
   42e63:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42e67:	8b 07                	mov    (%rdi),%eax
   42e69:	83 f8 2f             	cmp    $0x2f,%eax
   42e6c:	77 23                	ja     42e91 <printer_vprintf+0x1ba>
   42e6e:	89 c2                	mov    %eax,%edx
   42e70:	48 03 57 10          	add    0x10(%rdi),%rdx
   42e74:	83 c0 08             	add    $0x8,%eax
   42e77:	89 07                	mov    %eax,(%rdi)
   42e79:	8b 32                	mov    (%rdx),%esi
                ++format;
   42e7b:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   42e7f:	85 f6                	test   %esi,%esi
   42e81:	b8 00 00 00 00       	mov    $0x0,%eax
   42e86:	0f 48 f0             	cmovs  %eax,%esi
   42e89:	89 75 9c             	mov    %esi,-0x64(%rbp)
   42e8c:	e9 e3 fe ff ff       	jmpq   42d74 <printer_vprintf+0x9d>
                precision = va_arg(val, int);
   42e91:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42e95:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   42e99:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42e9d:	48 89 41 08          	mov    %rax,0x8(%rcx)
   42ea1:	eb d6                	jmp    42e79 <printer_vprintf+0x1a2>
        switch (*format) {
   42ea3:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   42ea8:	e9 f1 00 00 00       	jmpq   42f9e <printer_vprintf+0x2c7>
            ++format;
   42ead:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   42eb1:	8b 4d 80             	mov    -0x80(%rbp),%ecx
            goto again;
   42eb4:	e9 c0 fe ff ff       	jmpq   42d79 <printer_vprintf+0xa2>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   42eb9:	85 c9                	test   %ecx,%ecx
   42ebb:	74 55                	je     42f12 <printer_vprintf+0x23b>
   42ebd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42ec1:	8b 01                	mov    (%rcx),%eax
   42ec3:	83 f8 2f             	cmp    $0x2f,%eax
   42ec6:	77 38                	ja     42f00 <printer_vprintf+0x229>
   42ec8:	89 c2                	mov    %eax,%edx
   42eca:	48 03 51 10          	add    0x10(%rcx),%rdx
   42ece:	83 c0 08             	add    $0x8,%eax
   42ed1:	89 01                	mov    %eax,(%rcx)
   42ed3:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   42ed6:	48 89 d0             	mov    %rdx,%rax
   42ed9:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   42edd:	49 89 d0             	mov    %rdx,%r8
   42ee0:	49 f7 d8             	neg    %r8
   42ee3:	25 80 00 00 00       	and    $0x80,%eax
   42ee8:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   42eec:	0b 45 a8             	or     -0x58(%rbp),%eax
   42eef:	83 c8 60             	or     $0x60,%eax
   42ef2:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   42ef5:	41 bc 73 3e 04 00    	mov    $0x43e73,%r12d
            break;
   42efb:	e9 35 01 00 00       	jmpq   43035 <printer_vprintf+0x35e>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   42f00:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42f04:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   42f08:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42f0c:	48 89 47 08          	mov    %rax,0x8(%rdi)
   42f10:	eb c1                	jmp    42ed3 <printer_vprintf+0x1fc>
   42f12:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42f16:	8b 07                	mov    (%rdi),%eax
   42f18:	83 f8 2f             	cmp    $0x2f,%eax
   42f1b:	77 10                	ja     42f2d <printer_vprintf+0x256>
   42f1d:	89 c2                	mov    %eax,%edx
   42f1f:	48 03 57 10          	add    0x10(%rdi),%rdx
   42f23:	83 c0 08             	add    $0x8,%eax
   42f26:	89 07                	mov    %eax,(%rdi)
   42f28:	48 63 12             	movslq (%rdx),%rdx
   42f2b:	eb a9                	jmp    42ed6 <printer_vprintf+0x1ff>
   42f2d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42f31:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   42f35:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42f39:	48 89 41 08          	mov    %rax,0x8(%rcx)
   42f3d:	eb e9                	jmp    42f28 <printer_vprintf+0x251>
        int base = 10;
   42f3f:	be 0a 00 00 00       	mov    $0xa,%esi
   42f44:	eb 58                	jmp    42f9e <printer_vprintf+0x2c7>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   42f46:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42f4a:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   42f4e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42f52:	48 89 41 08          	mov    %rax,0x8(%rcx)
   42f56:	eb 60                	jmp    42fb8 <printer_vprintf+0x2e1>
   42f58:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   42f5c:	8b 01                	mov    (%rcx),%eax
   42f5e:	83 f8 2f             	cmp    $0x2f,%eax
   42f61:	77 10                	ja     42f73 <printer_vprintf+0x29c>
   42f63:	89 c2                	mov    %eax,%edx
   42f65:	48 03 51 10          	add    0x10(%rcx),%rdx
   42f69:	83 c0 08             	add    $0x8,%eax
   42f6c:	89 01                	mov    %eax,(%rcx)
   42f6e:	44 8b 02             	mov    (%rdx),%r8d
   42f71:	eb 48                	jmp    42fbb <printer_vprintf+0x2e4>
   42f73:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42f77:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   42f7b:	48 8d 42 08          	lea    0x8(%rdx),%rax
   42f7f:	48 89 47 08          	mov    %rax,0x8(%rdi)
   42f83:	eb e9                	jmp    42f6e <printer_vprintf+0x297>
   42f85:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   42f88:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   42f8f:	bf 60 40 04 00       	mov    $0x44060,%edi
   42f94:	e9 e6 02 00 00       	jmpq   4327f <printer_vprintf+0x5a8>
            base = 16;
   42f99:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   42f9e:	85 c9                	test   %ecx,%ecx
   42fa0:	74 b6                	je     42f58 <printer_vprintf+0x281>
   42fa2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42fa6:	8b 07                	mov    (%rdi),%eax
   42fa8:	83 f8 2f             	cmp    $0x2f,%eax
   42fab:	77 99                	ja     42f46 <printer_vprintf+0x26f>
   42fad:	89 c2                	mov    %eax,%edx
   42faf:	48 03 57 10          	add    0x10(%rdi),%rdx
   42fb3:	83 c0 08             	add    $0x8,%eax
   42fb6:	89 07                	mov    %eax,(%rdi)
   42fb8:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   42fbb:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   42fbf:	85 f6                	test   %esi,%esi
   42fc1:	79 c2                	jns    42f85 <printer_vprintf+0x2ae>
        base = -base;
   42fc3:	41 89 f1             	mov    %esi,%r9d
   42fc6:	f7 de                	neg    %esi
   42fc8:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   42fcf:	bf 40 40 04 00       	mov    $0x44040,%edi
   42fd4:	e9 a6 02 00 00       	jmpq   4327f <printer_vprintf+0x5a8>
            num = (uintptr_t) va_arg(val, void*);
   42fd9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   42fdd:	8b 07                	mov    (%rdi),%eax
   42fdf:	83 f8 2f             	cmp    $0x2f,%eax
   42fe2:	77 1c                	ja     43000 <printer_vprintf+0x329>
   42fe4:	89 c2                	mov    %eax,%edx
   42fe6:	48 03 57 10          	add    0x10(%rdi),%rdx
   42fea:	83 c0 08             	add    $0x8,%eax
   42fed:	89 07                	mov    %eax,(%rdi)
   42fef:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   42ff2:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   42ff9:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   42ffe:	eb c3                	jmp    42fc3 <printer_vprintf+0x2ec>
            num = (uintptr_t) va_arg(val, void*);
   43000:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43004:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43008:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4300c:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43010:	eb dd                	jmp    42fef <printer_vprintf+0x318>
            data = va_arg(val, char*);
   43012:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43016:	8b 01                	mov    (%rcx),%eax
   43018:	83 f8 2f             	cmp    $0x2f,%eax
   4301b:	0f 87 a9 01 00 00    	ja     431ca <printer_vprintf+0x4f3>
   43021:	89 c2                	mov    %eax,%edx
   43023:	48 03 51 10          	add    0x10(%rcx),%rdx
   43027:	83 c0 08             	add    $0x8,%eax
   4302a:	89 01                	mov    %eax,(%rcx)
   4302c:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   4302f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   43035:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43038:	83 e0 20             	and    $0x20,%eax
   4303b:	89 45 8c             	mov    %eax,-0x74(%rbp)
   4303e:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   43044:	0f 85 25 02 00 00    	jne    4326f <printer_vprintf+0x598>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   4304a:	8b 45 a8             	mov    -0x58(%rbp),%eax
   4304d:	89 45 88             	mov    %eax,-0x78(%rbp)
   43050:	83 e0 60             	and    $0x60,%eax
   43053:	83 f8 60             	cmp    $0x60,%eax
   43056:	0f 84 58 02 00 00    	je     432b4 <printer_vprintf+0x5dd>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4305c:	8b 45 a8             	mov    -0x58(%rbp),%eax
   4305f:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43062:	48 c7 45 a0 73 3e 04 	movq   $0x43e73,-0x60(%rbp)
   43069:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   4306a:	83 f8 21             	cmp    $0x21,%eax
   4306d:	0f 84 7d 02 00 00    	je     432f0 <printer_vprintf+0x619>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43073:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   43076:	89 c8                	mov    %ecx,%eax
   43078:	f7 d0                	not    %eax
   4307a:	c1 e8 1f             	shr    $0x1f,%eax
   4307d:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43080:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43084:	0f 85 a2 02 00 00    	jne    4332c <printer_vprintf+0x655>
   4308a:	84 c0                	test   %al,%al
   4308c:	0f 84 9a 02 00 00    	je     4332c <printer_vprintf+0x655>
            len = strnlen(data, precision);
   43092:	48 63 f1             	movslq %ecx,%rsi
   43095:	4c 89 e7             	mov    %r12,%rdi
   43098:	e8 61 fb ff ff       	callq  42bfe <strnlen>
   4309d:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   430a0:	8b 45 88             	mov    -0x78(%rbp),%eax
   430a3:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   430a6:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   430ad:	83 f8 22             	cmp    $0x22,%eax
   430b0:	0f 84 ae 02 00 00    	je     43364 <printer_vprintf+0x68d>
        width -= len + zeros + strlen(prefix);
   430b6:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   430ba:	e8 24 fb ff ff       	callq  42be3 <strlen>
   430bf:	8b 55 9c             	mov    -0x64(%rbp),%edx
   430c2:	03 55 98             	add    -0x68(%rbp),%edx
   430c5:	41 29 d5             	sub    %edx,%r13d
   430c8:	44 89 ea             	mov    %r13d,%edx
   430cb:	29 c2                	sub    %eax,%edx
   430cd:	89 55 8c             	mov    %edx,-0x74(%rbp)
   430d0:	41 89 d5             	mov    %edx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   430d3:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   430d7:	75 2d                	jne    43106 <printer_vprintf+0x42f>
   430d9:	85 d2                	test   %edx,%edx
   430db:	7e 29                	jle    43106 <printer_vprintf+0x42f>
            p->putc(p, ' ', color);
   430dd:	44 89 fa             	mov    %r15d,%edx
   430e0:	be 20 00 00 00       	mov    $0x20,%esi
   430e5:	4c 89 f7             	mov    %r14,%rdi
   430e8:	41 ff 16             	callq  *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   430eb:	41 83 ed 01          	sub    $0x1,%r13d
   430ef:	45 85 ed             	test   %r13d,%r13d
   430f2:	7f e9                	jg     430dd <printer_vprintf+0x406>
   430f4:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   430f7:	85 ff                	test   %edi,%edi
   430f9:	b8 01 00 00 00       	mov    $0x1,%eax
   430fe:	0f 4f c7             	cmovg  %edi,%eax
   43101:	29 c7                	sub    %eax,%edi
   43103:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   43106:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
   4310a:	0f b6 01             	movzbl (%rcx),%eax
   4310d:	84 c0                	test   %al,%al
   4310f:	74 22                	je     43133 <printer_vprintf+0x45c>
   43111:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43115:	48 89 cb             	mov    %rcx,%rbx
            p->putc(p, *prefix, color);
   43118:	0f b6 f0             	movzbl %al,%esi
   4311b:	44 89 fa             	mov    %r15d,%edx
   4311e:	4c 89 f7             	mov    %r14,%rdi
   43121:	41 ff 16             	callq  *(%r14)
        for (; *prefix; ++prefix) {
   43124:	48 83 c3 01          	add    $0x1,%rbx
   43128:	0f b6 03             	movzbl (%rbx),%eax
   4312b:	84 c0                	test   %al,%al
   4312d:	75 e9                	jne    43118 <printer_vprintf+0x441>
   4312f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43133:	8b 45 9c             	mov    -0x64(%rbp),%eax
   43136:	85 c0                	test   %eax,%eax
   43138:	7e 1d                	jle    43157 <printer_vprintf+0x480>
   4313a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4313e:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   43140:	44 89 fa             	mov    %r15d,%edx
   43143:	be 30 00 00 00       	mov    $0x30,%esi
   43148:	4c 89 f7             	mov    %r14,%rdi
   4314b:	41 ff 16             	callq  *(%r14)
        for (; zeros > 0; --zeros) {
   4314e:	83 eb 01             	sub    $0x1,%ebx
   43151:	75 ed                	jne    43140 <printer_vprintf+0x469>
   43153:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   43157:	8b 45 98             	mov    -0x68(%rbp),%eax
   4315a:	85 c0                	test   %eax,%eax
   4315c:	7e 2a                	jle    43188 <printer_vprintf+0x4b1>
   4315e:	8d 40 ff             	lea    -0x1(%rax),%eax
   43161:	49 8d 44 04 01       	lea    0x1(%r12,%rax,1),%rax
   43166:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4316a:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   4316d:	41 0f b6 34 24       	movzbl (%r12),%esi
   43172:	44 89 fa             	mov    %r15d,%edx
   43175:	4c 89 f7             	mov    %r14,%rdi
   43178:	41 ff 16             	callq  *(%r14)
        for (; len > 0; ++data, --len) {
   4317b:	49 83 c4 01          	add    $0x1,%r12
   4317f:	49 39 dc             	cmp    %rbx,%r12
   43182:	75 e9                	jne    4316d <printer_vprintf+0x496>
   43184:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43188:	45 85 ed             	test   %r13d,%r13d
   4318b:	7e 14                	jle    431a1 <printer_vprintf+0x4ca>
            p->putc(p, ' ', color);
   4318d:	44 89 fa             	mov    %r15d,%edx
   43190:	be 20 00 00 00       	mov    $0x20,%esi
   43195:	4c 89 f7             	mov    %r14,%rdi
   43198:	41 ff 16             	callq  *(%r14)
        for (; width > 0; --width) {
   4319b:	41 83 ed 01          	sub    $0x1,%r13d
   4319f:	75 ec                	jne    4318d <printer_vprintf+0x4b6>
    for (; *format; ++format) {
   431a1:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   431a5:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   431a9:	84 c0                	test   %al,%al
   431ab:	0f 84 00 02 00 00    	je     433b1 <printer_vprintf+0x6da>
        if (*format != '%') {
   431b1:	3c 25                	cmp    $0x25,%al
   431b3:	0f 84 53 fb ff ff    	je     42d0c <printer_vprintf+0x35>
            p->putc(p, *format, color);
   431b9:	0f b6 f0             	movzbl %al,%esi
   431bc:	44 89 fa             	mov    %r15d,%edx
   431bf:	4c 89 f7             	mov    %r14,%rdi
   431c2:	41 ff 16             	callq  *(%r14)
            continue;
   431c5:	4c 89 e3             	mov    %r12,%rbx
   431c8:	eb d7                	jmp    431a1 <printer_vprintf+0x4ca>
            data = va_arg(val, char*);
   431ca:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   431ce:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   431d2:	48 8d 42 08          	lea    0x8(%rdx),%rax
   431d6:	48 89 47 08          	mov    %rax,0x8(%rdi)
   431da:	e9 4d fe ff ff       	jmpq   4302c <printer_vprintf+0x355>
            color = va_arg(val, int);
   431df:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   431e3:	8b 07                	mov    (%rdi),%eax
   431e5:	83 f8 2f             	cmp    $0x2f,%eax
   431e8:	77 10                	ja     431fa <printer_vprintf+0x523>
   431ea:	89 c2                	mov    %eax,%edx
   431ec:	48 03 57 10          	add    0x10(%rdi),%rdx
   431f0:	83 c0 08             	add    $0x8,%eax
   431f3:	89 07                	mov    %eax,(%rdi)
   431f5:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   431f8:	eb a7                	jmp    431a1 <printer_vprintf+0x4ca>
            color = va_arg(val, int);
   431fa:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   431fe:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43202:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43206:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4320a:	eb e9                	jmp    431f5 <printer_vprintf+0x51e>
            numbuf[0] = va_arg(val, int);
   4320c:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43210:	8b 01                	mov    (%rcx),%eax
   43212:	83 f8 2f             	cmp    $0x2f,%eax
   43215:	77 23                	ja     4323a <printer_vprintf+0x563>
   43217:	89 c2                	mov    %eax,%edx
   43219:	48 03 51 10          	add    0x10(%rcx),%rdx
   4321d:	83 c0 08             	add    $0x8,%eax
   43220:	89 01                	mov    %eax,(%rcx)
   43222:	8b 02                	mov    (%rdx),%eax
   43224:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43227:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   4322b:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4322f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43235:	e9 fb fd ff ff       	jmpq   43035 <printer_vprintf+0x35e>
            numbuf[0] = va_arg(val, int);
   4323a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4323e:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43242:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43246:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4324a:	eb d6                	jmp    43222 <printer_vprintf+0x54b>
            numbuf[0] = (*format ? *format : '%');
   4324c:	84 d2                	test   %dl,%dl
   4324e:	0f 85 3b 01 00 00    	jne    4338f <printer_vprintf+0x6b8>
   43254:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   43258:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   4325c:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   43260:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43264:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4326a:	e9 c6 fd ff ff       	jmpq   43035 <printer_vprintf+0x35e>
        if (flags & FLAG_NUMERIC) {
   4326f:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   43275:	bf 60 40 04 00       	mov    $0x44060,%edi
        if (flags & FLAG_NUMERIC) {
   4327a:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   4327f:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   43283:	4c 89 c1             	mov    %r8,%rcx
   43286:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   4328a:	48 63 f6             	movslq %esi,%rsi
   4328d:	49 83 ec 01          	sub    $0x1,%r12
   43291:	48 89 c8             	mov    %rcx,%rax
   43294:	ba 00 00 00 00       	mov    $0x0,%edx
   43299:	48 f7 f6             	div    %rsi
   4329c:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   432a0:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   432a4:	48 89 ca             	mov    %rcx,%rdx
   432a7:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   432aa:	48 39 d6             	cmp    %rdx,%rsi
   432ad:	76 de                	jbe    4328d <printer_vprintf+0x5b6>
   432af:	e9 96 fd ff ff       	jmpq   4304a <printer_vprintf+0x373>
                prefix = "-";
   432b4:	48 c7 45 a0 76 3e 04 	movq   $0x43e76,-0x60(%rbp)
   432bb:	00 
            if (flags & FLAG_NEGATIVE) {
   432bc:	8b 45 a8             	mov    -0x58(%rbp),%eax
   432bf:	a8 80                	test   $0x80,%al
   432c1:	0f 85 ac fd ff ff    	jne    43073 <printer_vprintf+0x39c>
                prefix = "+";
   432c7:	48 c7 45 a0 74 3e 04 	movq   $0x43e74,-0x60(%rbp)
   432ce:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   432cf:	a8 10                	test   $0x10,%al
   432d1:	0f 85 9c fd ff ff    	jne    43073 <printer_vprintf+0x39c>
                prefix = " ";
   432d7:	a8 08                	test   $0x8,%al
   432d9:	ba 73 3e 04 00       	mov    $0x43e73,%edx
   432de:	b8 72 3e 04 00       	mov    $0x43e72,%eax
   432e3:	48 0f 44 c2          	cmove  %rdx,%rax
   432e7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   432eb:	e9 83 fd ff ff       	jmpq   43073 <printer_vprintf+0x39c>
                   && (base == 16 || base == -16)
   432f0:	41 8d 41 10          	lea    0x10(%r9),%eax
   432f4:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   432f9:	0f 85 74 fd ff ff    	jne    43073 <printer_vprintf+0x39c>
                   && (num || (flags & FLAG_ALT2))) {
   432ff:	4d 85 c0             	test   %r8,%r8
   43302:	75 0d                	jne    43311 <printer_vprintf+0x63a>
   43304:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   4330b:	0f 84 62 fd ff ff    	je     43073 <printer_vprintf+0x39c>
            prefix = (base == -16 ? "0x" : "0X");
   43311:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   43315:	ba 6f 3e 04 00       	mov    $0x43e6f,%edx
   4331a:	b8 78 3e 04 00       	mov    $0x43e78,%eax
   4331f:	48 0f 44 c2          	cmove  %rdx,%rax
   43323:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43327:	e9 47 fd ff ff       	jmpq   43073 <printer_vprintf+0x39c>
            len = strlen(data);
   4332c:	4c 89 e7             	mov    %r12,%rdi
   4332f:	e8 af f8 ff ff       	callq  42be3 <strlen>
   43334:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43337:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   4333b:	0f 84 5f fd ff ff    	je     430a0 <printer_vprintf+0x3c9>
   43341:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43345:	0f 84 55 fd ff ff    	je     430a0 <printer_vprintf+0x3c9>
            zeros = precision > len ? precision - len : 0;
   4334b:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   4334e:	89 fa                	mov    %edi,%edx
   43350:	29 c2                	sub    %eax,%edx
   43352:	39 c7                	cmp    %eax,%edi
   43354:	b8 00 00 00 00       	mov    $0x0,%eax
   43359:	0f 4e d0             	cmovle %eax,%edx
   4335c:	89 55 9c             	mov    %edx,-0x64(%rbp)
   4335f:	e9 52 fd ff ff       	jmpq   430b6 <printer_vprintf+0x3df>
                   && len + (int) strlen(prefix) < width) {
   43364:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43368:	e8 76 f8 ff ff       	callq  42be3 <strlen>
   4336d:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43370:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43373:	44 89 e9             	mov    %r13d,%ecx
   43376:	29 f9                	sub    %edi,%ecx
   43378:	29 c1                	sub    %eax,%ecx
   4337a:	89 c8                	mov    %ecx,%eax
   4337c:	44 39 ea             	cmp    %r13d,%edx
   4337f:	b9 00 00 00 00       	mov    $0x0,%ecx
   43384:	0f 4d c1             	cmovge %ecx,%eax
   43387:	89 45 9c             	mov    %eax,-0x64(%rbp)
   4338a:	e9 27 fd ff ff       	jmpq   430b6 <printer_vprintf+0x3df>
            numbuf[0] = (*format ? *format : '%');
   4338f:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43392:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43396:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4339a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   433a0:	e9 90 fc ff ff       	jmpq   43035 <printer_vprintf+0x35e>
        int flags = 0;
   433a5:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   433ac:	e9 ad f9 ff ff       	jmpq   42d5e <printer_vprintf+0x87>
}
   433b1:	48 83 c4 58          	add    $0x58,%rsp
   433b5:	5b                   	pop    %rbx
   433b6:	41 5c                	pop    %r12
   433b8:	41 5d                	pop    %r13
   433ba:	41 5e                	pop    %r14
   433bc:	41 5f                	pop    %r15
   433be:	5d                   	pop    %rbp
   433bf:	c3                   	retq   

00000000000433c0 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   433c0:	55                   	push   %rbp
   433c1:	48 89 e5             	mov    %rsp,%rbp
   433c4:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   433c8:	48 c7 45 f0 be 2a 04 	movq   $0x42abe,-0x10(%rbp)
   433cf:	00 
        cpos = 0;
   433d0:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   433d6:	b8 00 00 00 00       	mov    $0x0,%eax
   433db:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   433de:	48 63 ff             	movslq %edi,%rdi
   433e1:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   433e8:	00 
   433e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   433ed:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   433f1:	e8 e1 f8 ff ff       	callq  42cd7 <printer_vprintf>
    return cp.cursor - console;
   433f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   433fa:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   43400:	48 d1 f8             	sar    %rax
}
   43403:	c9                   	leaveq 
   43404:	c3                   	retq   

0000000000043405 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   43405:	55                   	push   %rbp
   43406:	48 89 e5             	mov    %rsp,%rbp
   43409:	48 83 ec 50          	sub    $0x50,%rsp
   4340d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43411:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43415:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   43419:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43420:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43424:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43428:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4342c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   43430:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43434:	e8 87 ff ff ff       	callq  433c0 <console_vprintf>
}
   43439:	c9                   	leaveq 
   4343a:	c3                   	retq   

000000000004343b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4343b:	55                   	push   %rbp
   4343c:	48 89 e5             	mov    %rsp,%rbp
   4343f:	53                   	push   %rbx
   43440:	48 83 ec 28          	sub    $0x28,%rsp
   43444:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   43447:	48 c7 45 d8 48 2b 04 	movq   $0x42b48,-0x28(%rbp)
   4344e:	00 
    sp.s = s;
   4344f:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   43453:	48 85 f6             	test   %rsi,%rsi
   43456:	75 0e                	jne    43466 <vsnprintf+0x2b>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   43458:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4345c:	48 29 d8             	sub    %rbx,%rax
}
   4345f:	48 83 c4 28          	add    $0x28,%rsp
   43463:	5b                   	pop    %rbx
   43464:	5d                   	pop    %rbp
   43465:	c3                   	retq   
        sp.end = s + size - 1;
   43466:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   4346b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   4346f:	be 00 00 00 00       	mov    $0x0,%esi
   43474:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43478:	e8 5a f8 ff ff       	callq  42cd7 <printer_vprintf>
        *sp.s = 0;
   4347d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43481:	c6 00 00             	movb   $0x0,(%rax)
   43484:	eb d2                	jmp    43458 <vsnprintf+0x1d>

0000000000043486 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43486:	55                   	push   %rbp
   43487:	48 89 e5             	mov    %rsp,%rbp
   4348a:	48 83 ec 50          	sub    $0x50,%rsp
   4348e:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43492:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43496:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4349a:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   434a1:	48 8d 45 10          	lea    0x10(%rbp),%rax
   434a5:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   434a9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   434ad:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   434b1:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   434b5:	e8 81 ff ff ff       	callq  4343b <vsnprintf>
    va_end(val);
    return n;
}
   434ba:	c9                   	leaveq 
   434bb:	c3                   	retq   

00000000000434bc <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   434bc:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   434c1:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   434c6:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   434cb:	48 83 c0 02          	add    $0x2,%rax
   434cf:	48 39 d0             	cmp    %rdx,%rax
   434d2:	75 f2                	jne    434c6 <console_clear+0xa>
    }
    cursorpos = 0;
   434d4:	c7 05 1e 5b 07 00 00 	movl   $0x0,0x75b1e(%rip)        # b8ffc <cursorpos>
   434db:	00 00 00 
}
   434de:	c3                   	retq   
