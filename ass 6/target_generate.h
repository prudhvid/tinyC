#ifndef _TARGET_GEN_H
#define _TARGET_GEN_H
#include "ass5_12CS10037_translator.h"
char outs[1002020];int outIndex=0;
const string 
	EaX="%eax",A_EaX="(%eax)",
	EbX="%ebx",A_EbX="(%ebx)",
	EcX="%ecx",A_EcX="(%ecx)",
	EdX="%edx",A_EdX="(%edx)",
	EBP="%ebp",ESP="%esp",
	AL="%al",BL="%bl",

	PUSHL="pushl",POPL="popl",PUSHB="pushb",POPB="popb",


	ADDB="addb",ADDL="addl",
	SUBB="subb",SUBL="subl",
	MOVL="movl",MOVB="movb",MOVZBL="movzbl",MOVSBL="movsbl",
	MUL="imull",
	DIV="idivl",CLTD="cltd",
	INCL="incl",DECL="decl",INCB="incb",DECB="decb",

	LEAL="leal",LEAB="leab",


	CALL="call",LEAVE="leave",RET="ret",
	
	
	CMP="cmp",
	JE="je",JNE="jne",JL="jl",JLE="jle",JG="jg",JGE="jge",
	JMP="jmp",JZ="jz",JNZ="jnz",
	SETE="sete",SETNE="setne",SETL="setl",SETLE="setle",SETG="setg",SETGE="setge",
	TEST="test"
	;

inline const string getLabelName(int no)
{
	char w[10];
	sprintf(w, ".L%d",no);
	return string(w);
}

inline const string getStringLabelName(int no)
{
	char w[10];
	sprintf(w, ".string%d",no);
	return string(w);
}



//pushl eax 
//popl ebx
inline void emit(const string x,const string y)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t%s\n",x.c_str(),y.c_str() );
}
//pushl (x)
inline void emit(const string x,Fields* f)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t%d(%s)\n",x.c_str(),f->actOffset,EBP.c_str());
}

//addl $32,eax
inline void emit(const string x,int i,const string y)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t$%d,%s\n",x.c_str(),i,y.c_str() );
}
//add $32,$56(X)
inline void emit(const string x,int i,Fields* f)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t$%d,%d(%s)\n",x.c_str(),i,f->actOffset,EBP.c_str());
}

//addl %eax,%eax
inline void emit(const string x,const string y,const string z)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t%s,%s\n",x.c_str(),y.c_str(),z.c_str() );
}

//addl $32(%eax),%eax
inline void emit(const string x,int i,const string y,const string z)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t%d(%s),%s\n",x.c_str(),i,y.c_str(),z.c_str() );
}
//addl $32(X),%eax
inline void emit(const string x,Fields* f,const string z)
{
	if(f->isStringConst)
		outIndex+=sprintf(outIndex+outs,"\t%s\t$%s,%s\n",x.c_str(),
				getStringLabelName(f->stringLabel).c_str(),z.c_str());

	else if(!f->isConst)
		outIndex+= sprintf(outs+outIndex,"\t%s\t%d(%s),%s\n",x.c_str(),f->actOffset,EBP.c_str(),z.c_str() );
	else{
		int t=f->type[0].first,val;
		if(t==charT)
			val=f->val.charVal;
		else
			val=f->val.intVal;
		outIndex+= sprintf(outs+outIndex,"\t%s\t$%d,%s\n",x.c_str(),val,z.c_str() );
	}
		
}

//addl %eax,$32(%eax)
inline void emit(const string x,const string y,int i,const string z)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t%s,%d(%s)\n",x.c_str(),y.c_str(),i,z.c_str() );
}
//addl %eax,$32(%eax)
inline void emit(const string x,const string y,Fields* f)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\t%s,%d(%s)\n",x.c_str(),y.c_str(),f->actOffset,EBP.c_str() );
}
inline void emit(const string s)
{
	outIndex+= sprintf(outs+outIndex,"\t%s\n",s.c_str() );
}
//labels:
inline void emitLabel(const string s)
{
	outIndex+= sprintf(outs+outIndex,"%s:\n",s.c_str() );
}
inline void emitStringLabel(const string &labelName,const string & strdat)
{
	emitLabel(labelName);
	outIndex+= sprintf(outs+outIndex,"\t.string\t\"%s\"\n",strdat.c_str() );
}


#endif