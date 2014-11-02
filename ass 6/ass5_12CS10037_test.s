	.file	"ass5_12CS10037_test.c"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	%gs:20, %eax
	movl	%eax, 28(%esp)
	xorl	%eax, %eax
	movb	$32, 23(%esp)
	movb	$0, 24(%esp)
	movl	$200, 16(%esp)
	movl	$456, 16(%esp)
	movl	$100, 12(%esp)
	jmp	.L2
.L3:
	addl	$1, 12(%esp)
.L2:
	movl	12(%esp), %eax
	cmpl	16(%esp), %eax
	jle	.L3
	movl	$0, %eax
	movl	28(%esp), %edx
	xorl	%gs:20, %edx
	je	.L5
	call	__stack_chk_fail
.L5:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.1-2ubuntu1~12.04) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
