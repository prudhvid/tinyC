	.file	"ass5_12CS10037_test.c"
	.text
	.globl	prints
	.type	prints,@function
	.globl	printi
	.type	printi,@function
	.globl	readi
	.type	readi,@function
	.globl	printi2
	.type	printi2,@function
	.globl	main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp,%ebp
	addl	$-480,%esp
	movl	$0,-408(%ebp)
.L2:
	movl	-408(%ebp),%eax
	movl	$100,%ebx
	cmp	%ebx,%eax
	jl	.L0
	jmp	.L1
.L3:
	movl	-408(%ebp),%eax
	movl	%eax,-424(%ebp)
	incl	-408(%ebp)
	jmp	.L2
.L0:
	movl	-408(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-432(%ebp)
	leal	-404(%ebp),%eax
	addl	-432(%ebp),%eax
	movl	0(%eax),%ebx
	movl	%ebx,-436(%ebp)
	leal	-404(%ebp),%eax
	addl	-432(%ebp),%eax
	movl	-408(%ebp),%ebx
	movl	%ebx,0(%eax)
	jmp	.L3
.L1:
	leal	-404(%ebp),%eax
	movl	%eax,-440(%ebp)
	movl	$0,-408(%ebp)
.L6:
	movl	-408(%ebp),%eax
	movl	$99,%ebx
	cmp	%ebx,%eax
	jl	.L4
	jmp	.L5
.L7:
	movl	-408(%ebp),%eax
	movl	%eax,-456(%ebp)
	incl	-408(%ebp)
	jmp	.L6
.L4:
	movl	-408(%ebp),%eax
	imull	$4,%eax
	movl	%eax,-464(%ebp)
	leal	-440(%ebp),%eax
	addl	-464(%ebp),%eax
	movl	0(%eax),%ebx
	movl	%ebx,-468(%ebp)
	movl	-468(%ebp),%eax
	movl	%eax,0(%esp)
	movl	-408(%ebp),%eax
	movl	%eax,4(%esp)
	call	printi2
	movl	%eax,-472(%ebp)
	jmp	.L7
.L5:
	movl	$0,%eax
	leave
	ret
	leave
	ret

