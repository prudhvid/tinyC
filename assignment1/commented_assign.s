	.file	"assignment.c" #file 
	.section	.rodata    #read only data
	.align 4

#labelling all the string data of printf ,scanf statements
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
	
	.cfi_startproc 				#.cfi_startproc is used at the beginning of each 
								#function that should have an entry in .eh_frame.


	pushl	%ebp 				#save the contents of ebp in stack
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp 			#store the current stack pointer as %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp 			#arranging it to follow the base order
	subl	$1632, %esp 		#total space for data 20*20*4= 1600 bytes
								#space for n,i,j accounts 12 bytes

	
	
	movl	$.LC0, (%esp) 		#storing parameter '.LC0' in stack and calling printf function
	call	printf				#calling printf to print "Enter the order.... "



	#Steps to call scanf 
	#parameter '&n' to be found out and then call scanf
	leal	1620(%esp), %eax 	#store the address of variable n in %eax
	movl	%eax, 4(%esp) 		#store %eax in stack (arg 2)
	movl	$.LC1, (%esp) 		#store the address of .LC1 in stack (arg 1)
	call	scanf 				#call scanf


	#call printf again with string "Enter the matrix in row-wise...."
	movl	$.LC2, (%esp)  		#storing the address of string in stack
	call	puts				#call puts function


	#intialize variable i->0 and jump to branch L2
	movl	$0, 1624(%esp) 
	jmp	.L2
.L5:
	#initailzaing j to 0
	movl	$0, 1628(%esp) #1628(%esp)=j
	jmp	.L3
.L4:
	#branch for scanf("%d", &data[i][j]);
	leal	20(%esp), %ecx 		#get address if array data in %ecx
	movl	1624(%esp), %edx 	# move i to %edx
	movl	%edx, %eax  		#eax=i
	sall	$2, %eax 			#eax=i*4
	addl	%edx, %eax 			#eax=i*5
	sall	$2, %eax 			#eax=i*20
	addl	1628(%esp), %eax 	#eax=i*20+j
	sall	$2, %eax 			#eax=4(20*i+j)
	addl	%ecx, %eax 			#eax=data+4(20*i+j) i.e &data[i][j]
	movl	%eax, 4(%esp) 		#arg 2
	movl	$.LC1, (%esp) 		#arg 1
	call	scanf
	addl	$1, 1628(%esp) 		#j++
.L3:
	#conditional branch j<n
	movl	1620(%esp), %eax 	#eax=n
	cmpl	%eax, 1628(%esp) 	#i<n
	setl	%al
	testb	%al, %al
	jne	.L4
	
	addl	$1, 1624(%esp) 		#i++
.L2:
	#branch to check i<n
	movl	1620(%esp), %eax 	#get %eax <- n
	cmpl	%eax, 1624(%esp) 	#i<n
	setl	%al 
	testb	%al, %al
	jne	.L5

	#end of for loop braching


	# printf("The input matrix is:\n");
	movl	$.LC3, (%esp)
	call	puts

	#Second for loop
	#initalize i->0
	movl	$0, 1624(%esp)
	jmp	.L6
.L9:
	#initalize j to 0
	movl	$0, 1628(%esp)
	jmp	.L7
.L8:
	#branch for printf("%d ", data[i][j]);
	movl	1624(%esp), %edx 		#edx=i
	movl	%edx, %eax 				#eax=i
	sall	$2, %eax 				#eax=4*i
	addl	%edx, %eax 				#eax=5*i
	sall	$2, %eax 				#eax=20*i
	addl	1628(%esp), %eax 		#eax=20i+j
	movl	20(%esp,%eax,4), %eax 	#eax=data+ 4*(20i+j) i.e &data[i][j]
	movl	%eax, 4(%esp) 			#arg 2
	movl	$.LC4, (%esp) 			#arg 1
	call	printf 					#printf call

	#incrment j
	addl	$1, 1628(%esp)
.L7:
	#conditional branch for j<n
	movl	1620(%esp), %eax 	 	#eax=n
	cmpl	%eax, 1628(%esp) 		#j<n
	setl	%al
	testb	%al, %al
	jne	.L8

	#call function putchar with argument '\n'
	movl	$10, (%esp) 			#'\n' in ASCII is 10
	call	putchar

	#increment i
	addl	$1, 1624(%esp) 			#i++
.L6:
	#branch for checking i<n
	movl	1620(%esp), %eax 		#eax=i
	cmpl	%eax, 1624(%esp) 		#i=n
	setl	%al
	testb	%al, %al
	jne	.L9
	#end of second for loop





	#for printf("In cs order:\n");
	movl	$.LC5, (%esp)
	call	puts


	#block to call cs function
	movl	1620(%esp), %eax 		#store n in %eax
	leal	20(%esp), %edx 			#store address of data in %edx
	movl	%edx, 4(%esp) 			# arg 2 in stack
	movl	%eax, (%esp) 			#arg 1 in stack
	call	_Z2csiPA20_i 			#call cs fucntion
	movl	$0, %eax 				#return 0
	
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc 					#ending the function eh_frame
.LFE0:
	.size	main, .-main
	.section	.rodata 			#read-only data
.LC6:
	.string	"%d\n"
	.text
	.globl	_Z2csiPA20_i
	.type	_Z2csiPA20_i, @function


#cs function i.e.
#void cs(int n, int data[][ORD])
_Z2csiPA20_i:
.LFB1:
	.cfi_startproc				#.cfi_startproc is used at the beginning of each 
	pushl	%ebp				#store ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp  			#space reserved in stack for locals and arguments
	cmpl	$0, 8(%ebp) 		#n==0 8(%ebp)-->n
	jne	.L11

	#for calling putchar('\n')
	movl	$10, (%esp)		 	#move '\n' to stack and call the function
	call	putchar
	jmp	.L10
.L11:
	#branch for if(n==1){...}
	cmpl	$1, 8(%ebp) #n==1
	jne	.L13

	
	#and call printf
	movl	12(%ebp), %eax 		#and 
	movl	(%eax), %eax
	movl	%eax, 4(%esp)		#arg 2 as data that came from argument
	movl	$.LC6, (%esp)		#set arg 1 as "%d\n" in %esp
	call	printf
	jmp	.L10
.L13:
	#  po(n, data, 1, 0);   
	movl	$0, 12(%esp) 		#arg 4 <-- 0
	movl	$1, 8(%esp) 		#arg 3 <-- 1
	movl	12(%ebp), %eax 		#address of data--> %eax
	movl	%eax, 4(%esp) 		#arg 2<-- address of data
	movl	8(%ebp), %eax 		#store n in %eax
	movl	%eax, (%esp) 		#arg 1 <-- n
	call	_Z2poiPA20_iii 		#call function po


	#cs(n-2, (int (*)[ORD])(&data[1][1])); 
	movl	12(%ebp), %eax  	#address of data--> %eax
	addl	$80, %eax 			#&data[1][0]-->%eax
	leal	4(%eax), %edx 		#&data[1][1]-->%edx
	movl	8(%ebp), %eax 		#n-->%eax
	subl	$2, %eax 			#n=n-2
	movl	%edx, 4(%esp) 		#arg 2 as &data[1][1] to stack
	movl	%eax, (%esp) 		#arg 1 as n-2
	call	_Z2csiPA20_i 		#call the same function cs



.L10:
	#exitiing cs
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc


.LFE1:
	.size	_Z2csiPA20_i, .-_Z2csiPA20_i
	.globl	_Z2poiPA20_iii
	.type	_Z2poiPA20_iii, @function






#function po(int n, int data[][ORD], int type, int ind)
_Z2poiPA20_iii:
.LFB2:
	.cfi_startproc 
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp 			#move stack for holding memory


	movl	16(%ebp), %eax 		#16(%ebp)-->type so %eax=type
	cmpl	$2, %eax 			#type==2  i.e case 2
	je	.L17 
	cmpl	$2, %eax 			#type==2
	jg	.L20		 			#if type>2 jmp to .L20

	cmpl	$1, %eax 			#case 1
	je	.L16

				#exit out of switch case
	jmp	.L14
.L20:
								#check for case 3 and case 4
	cmpl	$3, %eax 			#case 3
	je	.L18
	cmpl	$4, %eax 			#case 4
	je	.L19

								#exit out of switch
	jmp	.L14
.L16:
	#case 1
	movl	8(%ebp), %eax 			#get n into %eax
	subl	$1, %eax 				#%eax=n-1
	cmpl	20(%ebp), %eax 			#ind==n-1
	jne	.L21

	#call po(n,data,2,0)
	movl	$0, 12(%esp) 			#arg 4
	movl	$2, 8(%esp) 			#arg 3
	movl	12(%ebp), %eax 			#data in %eax
	movl	%eax, 4(%esp) 			#arg 2 as data
	movl	8(%ebp), %eax 			#par 1 i.e n in %eax
	movl	%eax, (%esp)			#arg 1 as n
	call	_Z2poiPA20_iii
	jmp	.L14
.L21:
	#else  part in case 1


	#printf("%d ", data[0][ind]);
	movl	12(%ebp), %eax 			#data --> eax
	movl	20(%ebp), %edx 			#ind --> edx
	movl	(%eax,%edx,4), %eax 	#%eax= *(data+4*ind)
	movl	%eax, 4(%esp) 			#arg 2 as data[0][ind]
	movl	$.LC4, (%esp)			#arg 1 as "%d"
	call	printf

	# po(n, data, 1, ind+1);
	movl	20(%ebp), %eax 			#ind -> eax
	addl	$1, %eax 				#eax=ind+1
	movl	%eax, 12(%esp)			#data as arg 2
	movl	$1, 8(%esp) 			#1 as arg 3
	movl	12(%ebp), %eax 
	movl	%eax, 4(%esp) 			#data in arg 1
	movl	8(%ebp), %eax 			#get n
	movl	%eax, (%esp) 			#n in arg0
	call	_Z2poiPA20_iii 			#call function
	jmp	.L14
.L17:
	#case 2

	#if(ind == n-1)
	movl	8(%ebp), %eax 			#n-->eax
	subl	$1, %eax 				#eax=eax-1
	cmpl	20(%ebp), %eax 			#if ind==n-1
	jne	.L23

	#po(n, data, 3, n-1);
	movl	8(%ebp), %eax 			#eax=n
	subl	$1, %eax 				#eax=n-1
	movl	%eax, 12(%esp) 			#n-1 i.e eax as arg4 
	movl	$3, 8(%esp) 			#3 in arg-3
	movl	12(%ebp), %eax 			#eax=data
	movl	%eax, 4(%esp) 			#data in arg2
	movl	8(%ebp), %eax 			#n 
	movl	%eax, (%esp) 			#arg1 as n
	call	_Z2poiPA20_iii 			#call po
	jmp	.L14
.L23:
	#else of case 2

	#printf("%d ", data[ind][n-1]);
	movl	20(%ebp), %edx 			#edx=ind
	movl	%edx, %eax 				#eax=ind
	sall	$2, %eax 				#eax=4*ind
	addl	%edx, %eax 				#eax=5*ind
	sall	$4, %eax 				#eax=80*ind
	addl	12(%ebp), %eax 			#eax=type
	movl	8(%ebp), %edx 			#edx=n
	subl	$1, %edx 				#edx=n-1
	movl	(%eax,%edx,4), %eax 	#eax=data[i][j]
	movl	%eax, 4(%esp) 			#arg2
	movl	$.LC4, (%esp) 			#arg 1
	call	printf


	#po(n, data, 2, ind+1);
	movl	20(%ebp), %eax 			#ind
	addl	$1, %eax 				#ind+1
	movl	%eax, 12(%esp) 			#arg 4
	movl	$2, 8(%esp) 			#2 in arg3
	movl	12(%ebp), %eax 			#data
	movl	%eax, 4(%esp) 			#arg2 as data
	movl	8(%ebp), %eax 			#n
	movl	%eax, (%esp) 			#arg1
	call	_Z2poiPA20_iii
	jmp	.L14
.L18:
	#case 3
	# if(ind == 0)
	cmpl	$0, 20(%ebp)
	jne	.L25

	# po(n, data, 4, n-1);
	movl	8(%ebp), %eax 			#eax=n
	subl	$1, %eax 				#eax=n-1
	movl	%eax, 12(%esp) 			#arg4 =n-1
	movl	$4, 8(%esp) 			#arg3 =4
	movl	12(%ebp), %eax 			#eax=data
	movl	%eax, 4(%esp) 			#arg2= data
	movl	8(%ebp), %eax 			#eax=n
	movl	%eax, (%esp) 			#arg1 =n
	call	_Z2poiPA20_iii 			#call po
	jmp	.L14
.L25:
	#else of case 3

	#printf("%d ", data[n-1][ind]);
	movl	8(%ebp), %eax   		#eax=n
	leal	-1(%eax), %edx 			#edx=n-1
	movl	%edx, %eax 				#eax=n-1
	sall	$2, %eax 				#4(n-1)
	addl	%edx, %eax 				#5(n-1)
	sall	$4, %eax 				#80(n-1)
	addl	12(%ebp), %eax 			#data+80(n-1)
	movl	20(%ebp), %edx 			#data+80(n-1)+ind
	movl	(%eax,%edx,4), %eax 	#eax=data[ind][n-1]
	movl	%eax, 4(%esp) 			#arg2 as data[ind][n-1]
	movl	$.LC4, (%esp) 			#arg1 as "%d"
	call	printf

	#po(n, data, 2, ind-1);
	movl	20(%ebp), %eax 			#eax=ind
	subl	$1, %eax 				#eax=ind-1
	movl	%eax, 12(%esp) 			#arg4 as ind-1
	movl	$3, 8(%esp) 			#arg3 =2
	movl	12(%ebp), %eax			#eax=data
	movl	%eax, 4(%esp) 			#arg2=data
	movl	8(%ebp), %eax 			#eax=n
	movl	%eax, (%esp) 			#arg1=n
	call	_Z2poiPA20_iii
	jmp	.L14
.L19:
	#case 4
	cmpl	$0, 20(%ebp)
	je	.L28
.L27:
	#else of case 4
	#printf("%d ", data[ind][0]);
	movl	20(%ebp), %edx 			#edx=ind
	movl	%edx, %eax 				#eax=ind
	sall	$2, %eax 				#eax=ind*4
	addl	%edx, %eax 				#eax=ind*5
	sall	$4, %eax 				#eax=ind*80
	addl	12(%ebp), %eax 			#eax=data+80*ind
	movl	(%eax), %eax 			#eax=data[ind][0]
	movl	%eax, 4(%esp) 			#arg2
	movl	$.LC4, (%esp) 			#arg1
	call	printf

	#po(n, data, 4, ind-1);
	movl	20(%ebp), %eax 			#eax=ind
	subl	$1, %eax 				#eax=ind-1
	movl	%eax, 12(%esp) 			#arg4 =ind-1
	movl	$4, 8(%esp) 			#arg3=4
	movl	12(%ebp), %eax			#eax=data
	movl	%eax, 4(%esp)			#arg2=data
	movl	8(%ebp), %eax			#eax=n
	movl	%eax, (%esp)			#arg1=n
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
