	.file	"ass5_12CS10037_test.c"
	.text
	.globl	add
	.type	add, @function
add:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	12(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	12(%ebp), %eax
	movl	8(%ebp), %edx
	addl	%edx, %eax
	leave
	ret
	.size	add, .-add
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$5, 20(%esp)
	movl	$199, 24(%esp)
	movl	20(%esp), %eax
	imull	24(%esp), %eax
	subl	$905, %eax
	movl	%eax, 28(%esp)
	leal	20(%esp), %eax
	movl	%eax, (%esp)
	call	readi
	movl	$40, 4(%esp)
	movl	$20, (%esp)
	call	printi2
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.1-2ubuntu1~12.04) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
