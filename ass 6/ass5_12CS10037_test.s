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
	.globl	min
	.type	min, @function
min:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	cmpl	%eax, 12(%ebp)
	cmovle	12(%ebp), %eax
	popl	%ebp
	ret
	.size	min, .-min
	.globl	Minimum
	.type	Minimum, @function
Minimum:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	min
	movl	16(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	min
	leave
	ret
	.size	Minimum, .-Minimum
	.globl	EditDistanceDP
	.type	EditDistanceDP, @function
EditDistanceDP:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$40060, %esp
	movl	$0, -40032(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
	addl	$1, %eax
	movl	%eax, -40028(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	strlen
	addl	$1, %eax
	movl	%eax, -40024(%ebp)
	leal	-40004(%ebp), %eax
	movl	%eax, -40020(%ebp)
	movl	$0, -40040(%ebp)
	jmp	.L12
.L15:
	movl	$0, -40036(%ebp)
	jmp	.L13
.L14:
	movl	-40040(%ebp), %eax
	imull	-40024(%ebp), %eax
	movl	%eax, %edx
	movl	-40036(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%edx, %eax
	movl	$-1, (%eax)
	addl	$1, -40036(%ebp)
.L13:
	movl	-40036(%ebp), %eax
	cmpl	-40024(%ebp), %eax
	jl	.L14
	addl	$1, -40040(%ebp)
.L12:
	movl	-40040(%ebp), %eax
	cmpl	-40028(%ebp), %eax
	jl	.L15
	movl	$0, -40040(%ebp)
	jmp	.L16
.L17:
	movl	-40040(%ebp), %eax
	imull	-40024(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%eax, %edx
	movl	-40040(%ebp), %eax
	movl	%eax, (%edx)
	addl	$1, -40040(%ebp)
.L16:
	movl	-40040(%ebp), %eax
	cmpl	-40028(%ebp), %eax
	jl	.L17
	movl	$0, -40036(%ebp)
	jmp	.L18
.L19:
	movl	-40036(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%eax, %edx
	movl	-40036(%ebp), %eax
	movl	%eax, (%edx)
	addl	$1, -40036(%ebp)
.L18:
	movl	-40036(%ebp), %eax
	cmpl	-40024(%ebp), %eax
	jl	.L19
	movl	$1, -40040(%ebp)
	jmp	.L20
.L23:
	movl	$1, -40036(%ebp)
	jmp	.L21
.L22:
	movl	-40040(%ebp), %eax
	imull	-40024(%ebp), %eax
	movl	%eax, %edx
	movl	-40036(%ebp), %eax
	addl	%edx, %eax
	addl	$1073741823, %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, -40016(%ebp)
	addl	$1, -40016(%ebp)
	movl	-40040(%ebp), %eax
	subl	$1, %eax
	imull	-40024(%ebp), %eax
	movl	%eax, %edx
	movl	-40036(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, -40012(%ebp)
	addl	$1, -40012(%ebp)
	movl	-40040(%ebp), %eax
	subl	$1, %eax
	imull	-40024(%ebp), %eax
	movl	%eax, %edx
	movl	-40036(%ebp), %eax
	addl	%edx, %eax
	addl	$1073741823, %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, -40008(%ebp)
	movl	-40040(%ebp), %eax
	leal	-1(%eax), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %edx
	movl	-40036(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	12(%ebp), %eax
	addl	%ecx, %eax
	movzbl	(%eax), %eax
	cmpb	%al, %dl
	setne	%al
	movzbl	%al, %eax
	addl	%eax, -40008(%ebp)
	movl	-40040(%ebp), %eax
	imull	-40024(%ebp), %eax
	movl	%eax, %edx
	movl	-40036(%ebp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-40008(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-40012(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-40016(%ebp), %eax
	movl	%eax, (%esp)
	call	Minimum
	movl	%eax, (%ebx)
	addl	$1, -40036(%ebp)
.L21:
	movl	-40036(%ebp), %eax
	cmpl	-40024(%ebp), %eax
	jl	.L22
	addl	$1, -40040(%ebp)
.L20:
	movl	-40040(%ebp), %eax
	cmpl	-40028(%ebp), %eax
	jl	.L23
	movl	-40028(%ebp), %eax
	imull	-40024(%ebp), %eax
	addl	$1073741823, %eax
	leal	0(,%eax,4), %edx
	movl	-40020(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, -40032(%ebp)
	movl	-40032(%ebp), %eax
	addl	$40060, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	EditDistanceDP, .-EditDistanceDP
	.globl	EditDistanceRecursion
	.type	EditDistanceRecursion, @function
EditDistanceRecursion:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	cmpl	$0, 16(%ebp)
	jne	.L26
	cmpl	$0, 20(%ebp)
	jne	.L26
	movl	$0, %eax
	jmp	.L27
.L26:
	cmpl	$0, 16(%ebp)
	jne	.L28
	movl	20(%ebp), %eax
	jmp	.L27
.L28:
	cmpl	$0, 20(%ebp)
	jne	.L29
	movl	16(%ebp), %eax
	jmp	.L27
.L29:
	movl	16(%ebp), %eax
	leal	-1(%eax), %edx
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	%edx, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	EditDistanceRecursion
	addl	$1, %eax
	movl	%eax, -20(%ebp)
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	EditDistanceRecursion
	addl	$1, %eax
	movl	%eax, -16(%ebp)
	movl	20(%ebp), %eax
	leal	-1(%eax), %edx
	movl	16(%ebp), %eax
	subl	$1, %eax
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	EditDistanceRecursion
	movl	16(%ebp), %edx
	leal	-1(%edx), %ecx
	movl	8(%ebp), %edx
	addl	%ecx, %edx
	movzbl	(%edx), %ecx
	movl	20(%ebp), %edx
	leal	-1(%edx), %ebx
	movl	12(%ebp), %edx
	addl	%ebx, %edx
	movzbl	(%edx), %edx
	cmpb	%dl, %cl
	setne	%dl
	movzbl	%dl, %edx
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	Minimum
.L27:
	addl	$36, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	EditDistanceRecursion, .-EditDistanceRecursion
	.section	.rodata
.LC0:
	.string	"hello"
.LC1:
	.string	"world"
	.align 4
.LC2:
	.string	"Minimum edits required to convert %s into %s is %d\n"
	.align 4
.LC3:
	.string	"Minimum edits required to convert %s into %s is %d by recursion\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	andl	$-16, %esp
	subl	$32, %esp
	movl	$.LC0, 24(%esp)
	movl	$.LC1, 28(%esp)
	movl	28(%esp), %eax
	movl	%eax, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	EditDistanceDP
	movl	%eax, 4(%esp)
	movl	$.LC2, (%esp)
	call	printf
	movl	28(%esp), %eax
	movl	%eax, (%esp)
	call	strlen
	movl	%eax, %ebx
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	strlen
	movl	%ebx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	28(%esp), %eax
	movl	%eax, 4(%esp)
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	EditDistanceRecursion
	movl	%eax, 4(%esp)
	movl	$.LC3, (%esp)
	call	printf
	movl	$0, %eax
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.1-2ubuntu1~12.04) 4.8.1"
	.section	.note.GNU-stack,"",@progbits
