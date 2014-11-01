#ifndef _TARGET_GEN_H
#define _TARGET_GEN_H
#include "ass5_12CS10037_translator.h"
char outs[1002020];
const string 
	EaX="%eax",A_EaX="(%eax)",
	EbX="%ebx",A_EbX="(%ebx)",
	EcX="%ecx",A_EcX="(%ecx)",
	EdX="%edx",A_EdX="(%edx)",
	EBP="%ebp",ESP="%esp",
	AL="%al",

	PUSHL="pushl",POPL="popl",PUSHB="pushb",POPB="popb",


	ADDB="addb",ADDL="addl",
	SUBB="subb",SUBL="subl",
	MOVL="movl",MOVB="movb",MOVZBL="movzbl",MOVSBL="movsbl",
	MUL="imull",
	DIV="idivl",CLTD="cltd",
	INC="inc",DEC="dec",

	LEAL="leal",LEAB="leab",


	CALL="call",LEAVE="leave",RET="ret",
	
	
	CMP="cmp",
	JE="je",JNE="jne",JL="jl",JLE="jle",JG="jg",JGE="jge",
	JMP="jmp",JZ="jz",JNZ="jnz",
	SETE="sete",SETNE="setne",SETL="setl",SETLE="setle",SETG="setg",SETGE="setge",
	TEST="test"
	;


//pushl eax 
//popl ebx
inline void emit(string x,string y)
{
	sprintf(outs,"%s\t%s\n",x.c_str(),y.c_str() );
}
//pushl (x)
inline void emit(string x,Fields* f)
{
	sprintf(outs,"%s\t%d(%s)\n",x.c_str(),f->actOffset,EBP.c_str());
}

//addl $32,eax
inline void emit(string x,int i,string y)
{
	sprintf(outs,"%s\t$%d,%s\n",x.c_str(),i,y.c_str() );
}
//add $32,$56(X)
inline void emit(string x,int i,Fields* f)
{
	sprintf(outs,"%s\t$%d,%d(%s)\n",x.c_str(),i,f->actOffset,EBP.c_str());
}

//addl %eax,%eax
inline void emit(string x,string y,string z)
{
	sprintf(outs,"%s\t%s,%s\n",x.c_str(),y.c_str(),z.c_str() );
}

//addl $32(%eax),%eax
inline void emit(string x,int i,string y,string z)
{
	sprintf(outs,"%s\t%d(%s),%s\n",x.c_str(),i,y.c_str(),z.c_str() );
}
//addl $32(X),%eax
inline void emit(string x,Fields* f,string z)
{
	if(!f->isConst)
		sprintf(outs,"%s\t%d(%s),%s\n",x.c_str(),f->actOffset,EBP.c_str(),z.c_str() );
	else{
		int t=f->type[0].first,val;
		if(t==charT)
			val=f->val.charVal;
		else
			val=f->val.intVal;
		sprintf(outs,"%s\t$%d,%s\n",x.c_str(),val,z.c_str() );
	}
		
}

//addl %eax,$32(%eax)
inline void emit(string x,string y,int i,string z)
{
	sprintf(outs,"%s\t%s,%d(%s)\n",x.c_str(),y.c_str(),i,z.c_str() );
}
//addl %eax,$32(%eax)
inline void emit(string x,string y,Fields* f)
{
	sprintf(outs,"%s\t%s,%d(%s)\n",x.c_str(),y.c_str(),f->actOffset,EBP.c_str() );
}
inline void emit(string s)
{
	sprintf(outs,"%s\n",s.c_str() );
}
//labels:
inline void emitLabel(string s)
{
	sprintf(outs,"%s:\n",s.c_str() );
}

inline string getLabelName(int no)
{
	char w[10];
	sprintf(w, ".L%d",no);
	return string(w);
}

#endif