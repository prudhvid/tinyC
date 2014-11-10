	.file	"ass5_12CS10037_test.c"
	.text
	.globl	printf
	.type	printf, @function
printf:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	prints
	movl	%eax, %ebx
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	printi
	addl	%ebx, %eax
	addl	$20, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	printf, .-printf
	.globl	printf2
	.type	printf2, @function
printf2:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	prints
	movl	%eax, %ebx
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	printi
	addl	%eax, %ebx
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	printi
	addl	%ebx, %eax
	addl	$20, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	printf2, .-printf2
	.globl	strlen
	.type	strlen, @function
strlen:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L6
.L7:
	addl	$1, -4(%ebp)
.L6:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L7
	movl	-4(%ebp), %eax
	leave
	ret
	.size	strlen, .-strlen
	.globl	determinant
	.type	determinant, @function
determinant:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$1736, %esp
	movl	$0, -1716(%ebp)
	cmpl	$2, 12(%ebp)
	jne	.L10
	movl	$0, -1716(%ebp)
	movl	8(%ebp), %eax
	addl	$80, %eax
	movl	4(%eax), %edx
	movl	8(%ebp), %eax
	addl	$160, %eax
	movl	8(%eax), %eax
	imull	%eax, %edx
	movl	8(%ebp), %eax
	addl	$80, %eax
	movl	8(%eax), %ecx
	movl	8(%ebp), %eax
	addl	$160, %eax
	movl	4(%eax), %eax
	imull	%ecx, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -1716(%ebp)
	movl	-1716(%ebp), %eax
	jmp	.L23
.L10:
	movl	$1, -1712(%ebp)
	jmp	.L12
.L20:
	movl	$1, -1696(%ebp)
	movl	$1, -1692(%ebp)
	movl	$1, -1708(%ebp)
	jmp	.L13
.L17:
	movl	$1, -1704(%ebp)
	jmp	.L14
.L16:
	cmpl	$1, -1708(%ebp)
	je	.L15
	movl	-1704(%ebp), %eax
	cmpl	-1712(%ebp), %eax
	je	.L15
	movl	-1708(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-1704(%ebp), %eax
	movl	(%edx,%eax,4), %ecx
	movl	-1696(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	-1692(%ebp), %edx
	addl	%edx, %eax
	movl	%ecx, -1608(%ebp,%eax,4)
	addl	$1, -1692(%ebp)
	movl	12(%ebp), %eax
	subl	$1, %eax
	cmpl	-1692(%ebp), %eax
	jge	.L15
	addl	$1, -1696(%ebp)
	movl	$1, -1692(%ebp)
.L15:
	addl	$1, -1704(%ebp)
.L14:
	movl	-1704(%ebp), %eax
	cmpl	12(%ebp), %eax
	jle	.L16
	addl	$1, -1708(%ebp)
.L13:
	movl	-1708(%ebp), %eax
	cmpl	12(%ebp), %eax
	jle	.L17
	movl	$1, -1700(%ebp)
	movl	$1, -1720(%ebp)
	jmp	.L18
.L19:
	negl	-1720(%ebp)
	addl	$1, -1700(%ebp)
.L18:
	movl	-1712(%ebp), %eax
	addl	$1, %eax
	cmpl	-1700(%ebp), %eax
	jge	.L19
	movl	12(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 4(%esp)
	leal	-1608(%ebp), %eax
	movl	%eax, (%esp)
	call	determinant
	imull	-1720(%ebp), %eax
	movl	%eax, %edx
	movl	-1712(%ebp), %eax
	movl	%edx, -1688(%ebp,%eax,4)
	addl	$1, -1712(%ebp)
.L12:
	movl	-1712(%ebp), %eax
	cmpl	12(%ebp), %eax
	jle	.L20
	movl	$1, -1712(%ebp)
	movl	$0, -1716(%ebp)
	jmp	.L21
.L22:
	movl	8(%ebp), %eax
	leal	80(%eax), %edx
	movl	-1712(%ebp), %eax
	movl	(%edx,%eax,4), %edx
	movl	-1712(%ebp), %eax
	movl	-1688(%ebp,%eax,4), %eax
	imull	%edx, %eax
	addl	%eax, -1716(%ebp)
	addl	$1, -1712(%ebp)
.L21:
	movl	-1712(%ebp), %eax
	cmpl	12(%ebp), %eax
	jle	.L22
	movl	-1716(%ebp), %eax
.L23:
	leave
	ret
	.size	determinant, .-determinant
	.globl	adn
	.type	adn, @function
adn:
	pushl	%ebp
	movl	%esp, %ebp
	popl	%ebp
	ret
	.size	adn, .-adn
	.section	.rodata
.LC0:
	.string	"\n\nEnter order of matrix : "
	.align 4
.LC1:
	.string	"\nEnter the elements of matrix\n"
.LC2:
	.string	"a["
.LC3:
	.string	"]["
.LC4:
	.string	"] "
	.align 4
.LC5:
	.string	"\n\n---------- Matrix A is --------------\n"
.LC6:
	.string	"\n"
.LC7:
	.string	"\t"
.LC8:
	.string	"\n \n"
	.align 4
.LC9:
	.string	"\n Determinant of Matrix A is  "
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$1632, %esp
	movl	$.LC0, (%esp)
	call	prints
	leal	16(%esp), %eax
	movl	%eax, (%esp)
	call	readi
	movl	$.LC1, (%esp)
	call	prints
	movl	$1, 20(%esp)
	jmp	.L26
.L29:
	movl	$1, 24(%esp)
	jmp	.L27
.L28:
	movl	20(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	movl	24(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$.LC4, (%esp)
	call	prints
	leal	32(%esp), %ecx
	movl	20(%esp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	24(%esp), %edx
	addl	%edx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	movl	%eax, (%esp)
	call	readi
	addl	$1, 24(%esp)
.L27:
	movl	16(%esp), %eax
	cmpl	%eax, 24(%esp)
	jle	.L28
	addl	$1, 20(%esp)
.L26:
	movl	16(%esp), %eax
	cmpl	%eax, 20(%esp)
	jle	.L29
	movl	$.LC5, (%esp)
	call	prints
	movl	$1, 20(%esp)
	jmp	.L30
.L33:
	movl	$.LC6, (%esp)
	call	prints
	movl	$1, 24(%esp)
	jmp	.L31
.L32:
	movl	20(%esp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	24(%esp), %edx
	addl	%edx, %eax
	movl	32(%esp,%eax,4), %eax
	movl	%eax, 4(%esp)
	movl	$.LC7, (%esp)
	call	printf
	movl	$.LC7, (%esp)
	call	prints
	addl	$1, 24(%esp)
.L31:
	movl	16(%esp), %eax
	cmpl	%eax, 24(%esp)
	jle	.L32
	addl	$1, 20(%esp)
.L30:
	movl	16(%esp), %eax
	cmpl	%eax, 20(%esp)
	jle	.L33
	movl	$.LC8, (%esp)
	call	prints
	movl	16(%esp), %eax
	movl	%eax, 4(%esp)
	leal	32(%esp), %eax
	movl	%eax, (%esp)
	call	determinant
	movl	%eax, 28(%esp)
	movl	28(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC9, (%esp)
	call	printf
	movl	$.LC6, (%esp)
	call	prints
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.1-2ubuntu1~12.04) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
