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
	.globl	strlen
	.type	strlen, @function
strlen:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L4
.L5:
	addl	$1, -4(%ebp)
.L4:
	movl	-4(%ebp), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L5
	movl	-4(%ebp), %eax
	leave
	ret
	.size	strlen, .-strlen
	.section	.rodata
.LC0:
	.string	"\n Player "
.LC1:
	.string	" : "
.LC2:
	.string	" "
	.align 4
.LC3:
	.string	"Space is already taken, please try again"
.LC4:
	.string	"Winner was "
.LC5:
	.string	" Good job.\n"
	.align 4
.LC6:
	.string	"No winner this round. Try again."
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	andl	$-16, %esp
	subl	$64, %esp
	movl	$0, 20(%esp)
	movl	$0, 24(%esp)
	movl	$0, 32(%esp)
	movl	$0, 16(%esp)
	movl	$0, 36(%esp)
	movl	$0, 40(%esp)
	movl	$0, 28(%esp)
	movl	$113, 44(%esp)
	jmp	.L8
.L24:
	movl	$0, 20(%esp)
	jmp	.L9
.L12:
	movl	$0, 24(%esp)
	jmp	.L10
.L11:
	movl	20(%esp), %eax
	sall	$2, %eax
	leal	64(%esp), %ebx
	leal	(%ebx,%eax), %edx
	movl	24(%esp), %eax
	addl	%edx, %eax
	subl	$16, %eax
	movb	$0, (%eax)
	addl	$1, 24(%esp)
.L10:
	cmpl	$3, 24(%esp)
	jle	.L11
	addl	$1, 20(%esp)
.L9:
	cmpl	$3, 20(%esp)
	jle	.L12
	movl	$0, 20(%esp)
	jmp	.L13
.L22:
	leal	48(%esp), %eax
	movl	%eax, (%esp)
	call	print_grid
	movl	20(%esp), %eax
	cltd
	shrl	$31, %edx
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	addl	$1, %eax
	movl	%eax, 32(%esp)
	cmpl	$1, 32(%esp)
	jne	.L14
	movl	32(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	$.LC1, (%esp)
	call	prints
	movl	$88, (%esp)
	call	printc
	movl	$.LC2, (%esp)
	call	prints
	jmp	.L15
.L14:
	cmpl	$2, 32(%esp)
	jne	.L15
	movl	32(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	$.LC1, (%esp)
	call	prints
	movl	$48, (%esp)
	call	printc
	movl	$.LC2, (%esp)
	call	prints
.L15:
	leal	16(%esp), %eax
	movl	%eax, (%esp)
	call	readi
	movl	16(%esp), %eax
	subl	$1, %eax
	movl	%eax, 16(%esp)
	movl	16(%esp), %eax
	cltd
	shrl	$30, %edx
	addl	%edx, %eax
	andl	$3, %eax
	subl	%edx, %eax
	movl	%eax, 40(%esp)
	movl	16(%esp), %eax
	subl	40(%esp), %eax
	movl	%eax, 16(%esp)
	movl	16(%esp), %eax
	leal	3(%eax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$2, %eax
	movl	%eax, 36(%esp)
	movl	16(%esp), %eax
	testl	%eax, %eax
	js	.L16
	movl	16(%esp), %eax
	cmpl	$16, %eax
	jg	.L16
	movl	36(%esp), %eax
	sall	$2, %eax
	leal	64(%esp), %esi
	leal	(%esi,%eax), %edx
	movl	40(%esp), %eax
	addl	%edx, %eax
	subl	$16, %eax
	movzbl	(%eax), %eax
	cmpb	$88, %al
	je	.L16
	movl	36(%esp), %eax
	sall	$2, %eax
	leal	64(%esp), %edi
	leal	(%edi,%eax), %edx
	movl	40(%esp), %eax
	addl	%edx, %eax
	subl	$16, %eax
	movzbl	(%eax), %eax
	cmpb	$79, %al
	jne	.L17
.L16:
	movl	$.LC3, (%esp)
	call	prints
	subl	$1, 20(%esp)
	jmp	.L18
.L17:
	cmpl	$1, 32(%esp)
	jne	.L19
	movl	$88, %eax
	jmp	.L20
.L19:
	movl	$79, %eax
.L20:
	movl	36(%esp), %edx
	sall	$2, %edx
	leal	64(%esp), %ecx
	addl	%edx, %ecx
	movl	40(%esp), %edx
	addl	%ecx, %edx
	subl	$16, %edx
	movb	%al, (%edx)
.L18:
	leal	48(%esp), %eax
	movl	%eax, (%esp)
	call	didwin
	movl	%eax, 28(%esp)
	addl	$1, 20(%esp)
.L13:
	cmpl	$15, 20(%esp)
	jg	.L21
	cmpl	$0, 28(%esp)
	je	.L22
.L21:
	cmpl	$0, 28(%esp)
	je	.L23
	movl	$.LC4, (%esp)
	call	prints
	movl	28(%esp), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	printc
	movl	$.LC5, (%esp)
	call	prints
	jmp	.L8
.L23:
	movl	$.LC6, (%esp)
	call	prints
.L8:
	cmpl	$0, 28(%esp)
	je	.L24
	movl	$0, %eax
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	main, .-main
	.section	.rodata
.LC7:
	.string	"\n\n"
.LC8:
	.string	"|"
.LC9:
	.string	"\n-------------------\n"
	.text
	.globl	print_grid
	.type	print_grid, @function
print_grid:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	$.LC7, (%esp)
	call	prints
	movl	$0, -16(%ebp)
	jmp	.L27
.L34:
	movl	$0, -12(%ebp)
	jmp	.L28
.L32:
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L29
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-12(%ebp), %eax
	addl	$1, %eax
	addl	%edx, %eax
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	movl	$.LC2, (%esp)
	call	prints
	jmp	.L30
.L29:
	movl	$32, (%esp)
	call	printc
	movl	-16(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	printc
	movl	$32, (%esp)
	call	printc
.L30:
	cmpl	$4, -12(%ebp)
	je	.L31
	movl	$.LC8, (%esp)
	call	prints
.L31:
	addl	$1, -12(%ebp)
.L28:
	cmpl	$3, -12(%ebp)
	jle	.L32
	cmpl	$4, -16(%ebp)
	je	.L33
	movl	$.LC9, (%esp)
	call	prints
.L33:
	addl	$1, -16(%ebp)
.L27:
	cmpl	$3, -16(%ebp)
	jle	.L34
	leave
	ret
	.size	print_grid, .-print_grid
	.globl	didwin
	.type	didwin, @function
didwin:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movb	$0, -9(%ebp)
	movl	$0, -8(%ebp)
	jmp	.L36
.L41:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, -10(%ebp)
	movl	$0, -4(%ebp)
	jmp	.L37
.L39:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-4(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	-10(%ebp), %al
	je	.L38
	movb	$0, -10(%ebp)
.L38:
	addl	$1, -4(%ebp)
.L37:
	cmpl	$3, -4(%ebp)
	jle	.L39
	cmpb	$0, -10(%ebp)
	je	.L40
	movzbl	-10(%ebp), %eax
	movb	%al, -9(%ebp)
.L40:
	addl	$1, -8(%ebp)
.L36:
	cmpl	$3, -8(%ebp)
	jle	.L41
	movl	$0, -8(%ebp)
	jmp	.L42
.L47:
	movl	8(%ebp), %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movb	%al, -10(%ebp)
	movl	$0, -4(%ebp)
	jmp	.L43
.L45:
	movl	-4(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	-10(%ebp), %al
	je	.L44
	movb	$0, -10(%ebp)
.L44:
	addl	$1, -4(%ebp)
.L43:
	cmpl	$3, -4(%ebp)
	jle	.L45
	cmpb	$0, -10(%ebp)
	je	.L46
	movzbl	-10(%ebp), %eax
	movb	%al, -9(%ebp)
.L46:
	addl	$1, -8(%ebp)
.L42:
	cmpl	$3, -8(%ebp)
	jle	.L47
	movl	8(%ebp), %eax
	movzbl	(%eax), %eax
	movb	%al, -10(%ebp)
	movl	$0, -8(%ebp)
	jmp	.L48
.L50:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	-8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	cmpb	-10(%ebp), %al
	je	.L49
	movb	$0, -10(%ebp)
.L49:
	addl	$1, -8(%ebp)
.L48:
	cmpl	$3, -8(%ebp)
	jle	.L50
	cmpb	$0, -10(%ebp)
	je	.L51
	movzbl	-10(%ebp), %eax
	movb	%al, -9(%ebp)
.L51:
	movl	8(%ebp), %eax
	movzbl	3(%eax), %eax
	movb	%al, -10(%ebp)
	movl	$0, -8(%ebp)
	jmp	.L52
.L54:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%eax, %edx
	movl	$3, %eax
	subl	-8(%ebp), %eax
	movzbl	(%edx,%eax), %eax
	cmpb	-10(%ebp), %al
	je	.L53
	movb	$0, -10(%ebp)
.L53:
	addl	$1, -8(%ebp)
.L52:
	cmpl	$3, -8(%ebp)
	jle	.L54
	cmpb	$0, -10(%ebp)
	je	.L55
	movzbl	-10(%ebp), %eax
	movb	%al, -9(%ebp)
.L55:
	movsbl	-9(%ebp), %eax
	leave
	ret
	.size	didwin, .-didwin
	.ident	"GCC: (Ubuntu 4.8.1-2ubuntu1~12.04) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
