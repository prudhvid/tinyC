#include "myl.h"
#define BUF 20
#define ERR 1
#define OK 0
#include "stdio.h"
void asmprint(char* buff,int bytes)
{
	__asm__ __volatile__ (
		"movl $4, %%eax \n\t"
		"movl $1, %%ebx \n\t"
		"int $128 \n\t"
		:
		:"c"(buff), "d"(bytes)
	) ;
}
int asmread(char* buff,int count)
{
	int readBytes=1;
	while(readBytes==1){
	__asm__ __volatile__ (
		"movl $3, %%eax \n\t"
		"movl $1, %%ebx \n\t"
		"int $128 \n\t"
		"movl %%eax,%0"
		:"=r"(readBytes)
		:"c"(buff), "d"(count)
	) ;}
	buff[readBytes]='\0';
	return readBytes-1;
}
int prints(char *word)
{
	int len=0;
	while(word[len]!='\0')len++;
	asmprint(word,len);
	return len;
}

int printi(int n)
{
	int len=0;
	char buffer[BUF];
	int neg=0;
	if(n==0){
		prints("0");
		return 1;
	}
		
	if(n<0){
		n*=-1;
		neg=1;
	}

	int rev=0,rem;
	while(n!=0){
		rem=n%10;
		n=n/10;
		buffer[len++]=rem+'0';
		rev=rev*10+rem;
	}
	if(neg)
		buffer[len++]='-';
	int i=0;
	for ( ; i < len/2; ++i){
		char t=buffer[i];
		buffer[i]=buffer[len-i-1];
		buffer[len-i-1]=t;
	}

	buffer[len]='\0';
	asmprint(buffer, len);

	return len;
}

int readi(int* eP)
{
	char buffer[BUF];
	int bytes=asmread(buffer, BUF);
	int num=0;
	if(bytes<=0)
		return ERR;
	int i,neg=0;
	if(buffer[0]=='-')
		neg=1;
	for (i=((neg==1) ?1:0); i < bytes; ++i){
		if( buffer[i]>='0'&&buffer[i]<='9')
			num=num*10+(buffer[i]-'0');
		else {
			if(neg)
				num*=-1;
			*eP=num;
			return ERR;
		}
			
	}
	if(neg)
		num*=-1;
	*eP=num;
	return OK;
}

int readf(float* eP)
{
	char buffer[BUF];
	int bytes=asmread(buffer,BUF);
	int i;
	int n,neg=0;
	float res,tens=1;

	if(buffer[0]=='-')
		neg=1;
	for ( i=((neg==1) ?1:0); i < bytes&&buffer[i]!='.'; ++i){
		if( buffer[i]>='0'&&buffer[i]<='9')
			n=n*10+(buffer[i]-'0');
		else {
			if(neg)
				n*=-1;
			*eP=n;
			return ERR;
		}
			
	}
	res=n;n=0;
	for ( ++i; i < bytes; ++i){
		if( buffer[i]>='0'&&buffer[i]<='9')
			n=(buffer[i]-'0');
		else {
			res+=n/tens;
			if(neg)
				res*=-1;
			*eP=res;
			return ERR;
		}
			
		tens*=10;
		res+=n/tens;
	}

	if(neg)
		res*=-1;

	*eP=res;
	return OK;
}

int printd(float f)
{
	float x=f-0;
	int printLen=0;
	char buffer[BUF];
	if(x<0)
		x*=-1;
	if(x<0.0000001)
	{
		buffer[0]='0';
		asmprint(buffer, 1);
		return 1;
	}


	int PRECISION=6;
	int num=(int)f;
	if(num==0)
		printLen+=prints("-");
	printLen+=printi(num);
		
	f=f-num;
	
	printLen+=prints(".");
	
	while(PRECISION--)
	{
		f*=10;
		num=(int)f;
		f-=num;
		if(num<0)
			num*=-1;
		printi(num);
		printLen++;
	}
	
	return printLen;
}


