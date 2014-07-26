	.file	"assignment.c"
	.section	.rodata
	.align 4
.LC0:
	.string	"Enter the order of the square matrix: "
.LC1:
	.string	"%d"
	.align 4
.LC2:
	.string	"Enter the matrix in row-major order:"
.LC3:
	.string	"The input matrix is:"
.LC4:
	.string	"%d "
.LC5:
	.string	"In cs order:"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$1632, %esp
	movl	$.LC0, (%esp)
	call	printf
	leal	1620(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	scanf
	movl	$.LC2, (%esp)
	call	puts
	movl	$0, 1624(%esp)
	jmp	.L2
.L5:
	movl	$0, 1628(%esp)
	jmp	.L3
.L4:
	leal	20(%esp), %ecx
	movl	1624(%esp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	1628(%esp), %eax
	sall	$2, %eax
	addl	%ecx, %eax
	movl	%eax, 4(%esp)
	movl	$.LC1, (%esp)
	call	scanf
	addl	$1, 1628(%esp)
.L3:
	movl	1620(%esp), %eax
	cmpl	%eax, 1628(%esp)
	setl	%al
	testb	%al, %al
	jne	.L4
	addl	$1, 1624(%esp)
.L2:
	movl	1620(%esp), %eax
	cmpl	%eax, 1624(%esp)
	setl	%al
	testb	%al, %al
	jne	.L5
	movl	$.LC3, (%esp)
	call	puts
	movl	$0, 1624(%esp)
	jmp	.L6
.L9:
	movl	$0, 1628(%esp)
	jmp	.L7
.L8:
	movl	1624(%esp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	1628(%esp), %eax
	movl	20(%esp,%eax,4), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	addl	$1, 1628(%esp)
.L7:
	movl	1620(%esp), %eax
	cmpl	%eax, 1628(%esp)
	setl	%al
	testb	%al, %al
	jne	.L8
	movl	$10, (%esp)
	call	putchar
	addl	$1, 1624(%esp)
.L6:
	movl	1620(%esp), %eax
	cmpl	%eax, 1624(%esp)
	setl	%al
	testb	%al, %al
	jne	.L9
	movl	$.LC5, (%esp)
	call	puts
	movl	1620(%esp), %eax
	leal	20(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_Z2csiPA20_i
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
.LC6:
	.string	"%d\n"
	.text
	.globl	_Z2csiPA20_i
	.type	_Z2csiPA20_i, @function
_Z2csiPA20_i:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	cmpl	$0, 8(%ebp)
	jne	.L11
	movl	$10, (%esp)
	call	putchar
	jmp	.L10
.L11:
	cmpl	$1, 8(%ebp)
	jne	.L13
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.LC6, (%esp)
	call	printf
	jmp	.L10
.L13:
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	movl	12(%ebp), %eax
	addl	$80, %eax
	leal	4(%eax), %edx
	movl	8(%ebp), %eax
	subl	$2, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_Z2csiPA20_i
.L10:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	_Z2csiPA20_i, .-_Z2csiPA20_i
	.globl	_Z2poiPA20_iii
	.type	_Z2poiPA20_iii, @function
_Z2poiPA20_iii:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	16(%ebp), %eax
	cmpl	$2, %eax
	je	.L17
	cmpl	$2, %eax
	jg	.L20
	cmpl	$1, %eax
	je	.L16
	jmp	.L14
.L20:
	cmpl	$3, %eax
	je	.L18
	cmpl	$4, %eax
	je	.L19
	jmp	.L14
.L16:
	movl	8(%ebp), %eax
	subl	$1, %eax
	cmpl	20(%ebp), %eax
	jne	.L21
	movl	$0, 12(%esp)
	movl	$2, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	jmp	.L14
.L21:
	movl	12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	jmp	.L14
.L17:
	movl	8(%ebp), %eax
	subl	$1, %eax
	cmpl	20(%ebp), %eax
	jne	.L23
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$3, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	jmp	.L14
.L23:
	movl	20(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	addl	12(%ebp), %eax
	movl	8(%ebp), %edx
	subl	$1, %edx
	movl	(%eax,%edx,4), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$2, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	jmp	.L14
.L18:
	cmpl	$0, 20(%ebp)
	jne	.L25
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	jmp	.L14
.L25:
	movl	8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	addl	12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$3, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	jmp	.L14
.L19:
	cmpl	$0, 20(%ebp)
	je	.L28
.L27:
	movl	20(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$.LC4, (%esp)
	call	printf
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_Z2poiPA20_iii
	nop
	jmp	.L14
.L28:
	nop
.L14:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	_Z2poiPA20_iii, .-_Z2poiPA20_iii
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
