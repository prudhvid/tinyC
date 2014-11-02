	.file	"ass5_12CS10037_test.c"
	.text
	.globl	printArray
	.type	printArray, @function
printArray:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$0, -12(%ebp)
	movl	$0, -12(%ebp)
	jmp	.L2
.L3:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	$3, 4(%esp)
	movl	%eax, (%esp)
	call	printi2
	addl	$1, -12(%ebp)
.L2:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	.L3
	leave
	ret
	.size	printArray, .-printArray
	.section	.rodata
.LC0:
	.string	"hello"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$432, %esp
	leal	20(%esp), %eax
	movl	%eax, (%esp)
	call	readi
	movl	$0, 24(%esp)
	jmp	.L5
.L6:
	leal	32(%esp), %eax
	movl	24(%esp), %edx
	sall	$2, %edx
	addl	%edx, %eax
	movl	%eax, (%esp)
	call	readi
	movl	24(%esp), %eax
	movl	32(%esp,%eax,4), %ecx
	movl	$1717986919, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	$10, 4(%esp)
	movl	%eax, (%esp)
	call	printi2
	addl	$1, 24(%esp)
.L5:
	movl	20(%esp), %eax
	cmpl	%eax, 24(%esp)
	jl	.L6
	movl	$.LC0, 28(%esp)
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.1-2ubuntu1~12.04) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
