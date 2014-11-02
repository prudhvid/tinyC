#include "ass5_12CS10037_translator.h"
#include "target_generate.h"

#include "y.tab.h"

extern int yylex();
extern int yyparse();
extern char* yytext;
SymbolTable* _GLOBST=new SymbolTable();
extern int line_number;
extern SymbolTable* st;
const int NO_LABEL=-100;

using namespace quad;
void yyerror(char* s)
{
  printf("%s at line_number %d\n",s,line_number);
}
int labelNo=0;
extern std::vector<Quad> quadArray;
int labelArray[10000]={NO_LABEL};
int paramESPoffset=0;




SymbolTable* currst;







int recursiveRemove(int index)
{
	if(quadArray[index].op!=QGOTO)
	{
		return index;
	}
	// printf("changed a goto!!! of %d\n",index);
	return quadArray[index].gotoIndex=recursiveRemove(quadArray[index].gotoIndex);
}
void removeGotoNLabel()
{
	// for (int i = 0; i < quadArray.size(); ++i){
	// 	// printf("%d\n",quadArray[i].op );
	// 	if(quadArray[i].op<=QGOTO&&quadArray[i].op!=0)
	// 		recursiveRemove(i);
	// }
	
	for (int i = 0; i < quadArray.size(); ++i){
		if(quadArray[i].op==QGOTO&& quadArray[i].gotoIndex==i+1)
			quadArray[i].op=QPASS;
	}

	for (int i = 0; i < quadArray.size(); ++i){
		if(quadArray[i].op<=QGOTO&&quadArray[i].op!=0){
			
			if(labelArray[quadArray[i].gotoIndex]==NO_LABEL){
				labelArray[quadArray[i].gotoIndex]=labelNo++;
			}
				
		}
	}

	// for (int i = 0; i < quadArray.size(); ++i){
	// 	Quad&q=quadArray[i];
	// 	if(q.op!=QPARAM&&q.op!=QRETURN&&q.op!=QFUNC
	// 		&&q.op!=QFUNCEND&&q.op!=QPASS&&q.op!=QCALL){


	// 		if(q.res!=NULL&&currst->isTemp(q.res)){
	// 			bool qpassF=true;
	// 			For(j, i+1, quadArray.size()){

	// 				Quad&q2=quadArray[j];
	// 				int boolVal;
	// 				if(q2.op==QPARAM||q.op==QRETURN||q.op==QFUNC)
	// 					boolVal=(strcmp(q2.res,q.res)==0)?1:0;
	// 				else if(q2.arg1==NULL&&q2.arg2==NULL)
	// 					continue;
	// 				else if(q2.arg2==NULL)
	// 					boolVal=(strcmp(q.res, q2.arg1)==0)?1:0;
	// 				else if(q.arg1==NULL)
	// 					boolVal=(strcmp(q.res, q2.arg2)==0)?1:0;
	// 				else
	// 					boolVal=(strcmp(q.res, q2.arg2)==0)||(strcmp(q.res, q2.arg1)==0);

	// 				if(boolVal){
	// 					qpassF=false;
	// 					break;
	// 				}
	// 			}
	// 			if(qpassF)
	// 				q.op=QPASS;
	// 		}
	// 	}
			
	// }
	

}




void convOp(const Quad& q)
{
	Fields* res,*arg;
	res=currst->search(q.res);
	arg=currst->search(q.arg1);
	if(q.op==QCHAR2INT){
		if(arg->isConst){
			emit(MOVB, arg->val.intVal,AL);
		}
		else
			emit(MOVB,arg,AL);
		emit(MOVSBL,AL,res);
	}
	else if(q.op==QINT2CHAR){
		if(arg->isConst){
			emit(MOVL, arg->val.intVal,EaX);
		}
		else
			emit(MOVL,arg,EaX);
		emit(MOVB, AL,res);	
	}
	else
		throw "such a type conv not supported";
}

void functionStart(const Quad& q)
{
	/*
	pushl	%ebp	
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	*/
	emitLabel(q.res);
	emit(PUSHL,EBP);
	emit(MOVL,ESP,EBP);
	if(currst->localOff-currst->stackOffset<0)
		emit(ADDL,currst->localOff-currst->stackOffset,ESP);
	paramESPoffset=0;
}


void functionEnd(const Quad &q)
{
	emit(LEAVE);
	emit(RET);
}






void assignmentOpe(const Quad& q)
{
	Fields* res,*arg;
	res=currst->search(q.res);
	if(!res)
		throw "unexpected symbol in quads";

	if(res->isConst)
	{
	return;}

	arg=currst->search(q.arg1);

	if(arg->type[0].first==arrayT&&res->type[0].first==pointerT)
	{
		emit(LEAL,arg,EaX);
		emit(MOVL,EaX,res);
	}
	else
	{
		int s=getSize(res->type);

		string mov,reg;
		mov=(s==1)?MOVB:MOVL;
		reg=(s==1)?AL:EaX;
		if(arg->isConst)
		{
			emit(mov,arg->val.intVal,res);
		}
		else{
			emit(mov,arg,reg);
			emit(mov,reg,res);
		}
	}
		
}


void binaryOp(const Quad& q)
{
	Fields* res,*arg1,*arg2;
	res=currst->search(q.res);
	arg1=currst->search(q.arg1);
	arg2=currst->search(q.arg2);
	
	int op=q.op;
	switch(op)
	{
		case '%':
		case '/':
		{
			emit(MOVL,arg1,EaX);
			emit(MOVL,arg2,EbX);
			emit(CLTD);
			emit(DIV,EbX);
			string reg=(q.op=='%')?EdX:EaX;
			emit(MOVL,reg,res);
			
		}
		break;

		case '+':
		case '-':
		case '*':
		{
			
			if(arg2==NULL){
				if(op=='+'&&strcmp(q.arg2,"1" )==0){
					emit(INCL,arg1);
				}
				else if(op=='-'&&strcmp(q.arg2,"1" )==0){
					emit(DECL,arg1);
				}
				else if(op=='*')
				{
					emit(MOVL,arg1,EaX);
					emit(MUL,atoi(q.arg2),EaX);
					emit(MOVL,EaX,res);
				}
				else
					throw "gone again!!";

			}
			else{
				if(arg1->type[0].first==arrayT)
					emit(LEAL,arg1,EaX);
				else
					emit(MOVL,arg1,EaX);
				emit(MOVL,arg2,EbX);
				string oper=(op=='+')?ADDL:((op=='-')?SUBL:MUL);
				emit(oper,EbX,EaX);
				emit(MOVL,EaX,res);
			}
			
		}
		break;

		case '>':
		case QGE_OP:
		case '<':
		case QLE_OP:
		case QEQ_OP:
		case QNE_OP:
		{
			emit(MOVL,arg1,EaX);
			emit(MOVL,arg2,EbX);
			emit(CMP,EbX,EaX);
			string oper;
			switch(op)
			{
				case '>':
					oper=SETG;
					break;
				case '<':
					oper=SETL;
					break;
				case QGE_OP:
					oper=SETGE;
					break;
				case QLE_OP:
					oper=SETLE;
					break;
				case QEQ_OP:
					oper=SETE;
					break;
				case QNE_OP:
					oper=SETNE;
					break;
			}
			emit(oper,AL);
			emit(MOVZBL,AL,EaX);
			emit(MOVL,EaX,res);
		}
		break;

		case QRENOTE:
		case QRELIFEQ:
		case QRELIFGT:
		case QRELIFGTE:
		case QRELIFLT:
		case QRELIFLTE:
		{
			emit(MOVL,arg1,EaX);
			if(arg2!=NULL)
				emit(MOVL,arg2,EbX);
			else
				emit(MOVL,atoi(q.arg2),EbX);
			emit(CMP,EbX,EaX);
			string oper;
			switch(op)
			{
				case QRELIFGT:
					oper=JG;
					break;
				case QRELIFLT:
					oper=JL;
					break;
				case QRELIFGTE:
					oper=JGE;
					break;
				case QRELIFLTE:
					oper=JLE;
					break;
				case QRELIFEQ:
					oper=JE;
					break;
				case QRENOTE:
					oper=JNE;
					break;
			}

			emit(oper,getLabelName(labelArray[q.gotoIndex]));
		}
		break;



		case QCALL:
		{
			emit(CALL,q.arg1);
			paramESPoffset=0;
			int s=getSize(res->type);
			if(s==0)
				break;
			//stroing the return value in res
			string reg=(s==1)?AL:EaX;
			string op=(s==1)?MOVB:MOVL;
			emit(op,reg,res);
		}
		break;
		case QARRDEREF:
		{
			//res[arg1]=arg2
			int s=getSize(currst->search(q.res)->type);
			string reg=(s==1)?AL:EaX;
			string reg2=(s==1)?BL:EbX;
			string op=(s==1)?MOVB:MOVL;
			string addop=(s==1)?ADDB:ADDL;
			if(res->type[0].first!=pointerT)
				emit(LEAL,res,EaX);
			else
				emit(MOVL,res,EaX);

			emit(ADDL,arg1,EaX);

			emit(op,arg2,reg2);
			emit(op,reg2,0,EaX);
		}
		break;
		case QARRVAL:
		{
			//res=arg1[arg2]
			int s=getSize(currst->search(q.res)->type);
			string reg=(s==1)?AL:EaX;
			string reg2=(s==1)?BL:EbX;
			string op=(s==1)?MOVB:MOVL;
			string addop=(s==1)?ADDB:ADDL;
			if(arg1->type[0].first!=pointerT)
				emit(LEAL,arg1,EaX);
			else
				emit(MOVL,arg1,EaX);
			emit(ADDL,arg2,EaX);
			emit(op,0,EaX,reg2);
			emit(op,reg2,res);
			
		}
		break;
	}
}

void unaryOp(const Quad&q)
{
	// Quad q1=q;
	// Quad::emit(q1);
	Fields *res,*arg;
	if(q.op!=QRETURN_NULL&&q.op!=QFUNCEND&&q.op!=QGOTO)
		res=currst->search(q.res);
	if(q.op!=QRETURN_NULL&&q.op!=QFUNCEND&&q.op!=QRETURN
		&&q.op!=QPARAM&&q.op!=QFUNC&&q.op!=QGOTO)
		arg=currst->search(q.arg1);
	int op=q.op;

	switch(op)
	{
		case QGOTO:
			emit(JMP,getLabelName(labelArray[q.gotoIndex]));
		break;
		case QFUNC:
			functionStart(q);
		break;
		case QFUNCEND:
			functionEnd(q);
		break;

		case QRETURN:
		{
			Fields *res=currst->search(q.res);
			int s=getSize(res->type);
			string reg=(s==1)?AL:EaX;
			string op=(s==1)?MOVB:MOVL;
			emit(op,res,EaX);
			functionEnd(q);
		}

			break;
		case QRETURN_NULL:
			functionEnd(q);
		break;

		case QINT2CHAR:
		case QCHAR2INT:
			convOp(q);
			break;

		case QPARAM:
		{	
			if(res->type[0].first==arrayT&&res->type[0].first!=pointerT){
				emit(LEAL,res,EaX);
				emit(MOVL,EaX,paramESPoffset,ESP);
				paramESPoffset+=4;
			}
			else{
				int s=getSize(res->type);
				string reg=(s==1)?AL:EaX;
				string op=(s==1)?MOVB:MOVL;

				emit(op,res,reg);
				emit(op,reg,paramESPoffset,ESP);
				paramESPoffset+=(s==1)?1:4;
			}
		}
		break;

		case QADDR:
		{
			emit(LEAL,arg,EaX);
			emit(MOVL,EaX,res);
		}
		break;

		case QPOINTER:
		{
			//a=*b
			int s=getSize(res->type);
			string reg=(s==1)?AL:EaX;
			string op=(s==1)?MOVB:MOVL;
			emit(op,arg,reg);
			emit(op,0,reg,reg);
			emit(op,reg,res);
		}
		break;

		case QPOINTERDER:
		{
			int s=getSize(arg->type);
			string reg=(s==1)?AL:EaX;
			string op=(s==1)?MOVB:MOVL;
			string reg2=(s==1)?BL:EbX;
			emit(op,arg,reg);
			emit(op,res,reg2);
			emit(op,reg,0,reg2);
			
		}
		break;
	}
}





void globalsEmit(string filename)
{

	/*
	.file	"sum.c"
	.text
	.globl	add
	.type	add, @function
	*/
	char word[40];
	sprintf(word, "\"%s\"",filename.c_str());
	emit(".file", word);
	emit(".text");
	for (int i = 0; i < _GLOBST->table.size(); ++i){
		emit(".globl", _GLOBST->table[i].name.c_str());
		emit(".type", _GLOBST->table[i].name.c_str(),"@function");
	}
}








int main(int argc, char const *argv[])
{	

	freopen("ass5_12CS10037_test.c", "r", stdin);
	// freopen("stat_test_output","w",stdout);
	FILE *fp= fopen("out.s", "w");
	int token;
	std::string s;
	try{
		yyparse();  
	}
	catch(const char* p)
	{
		printf("\nERROR: %s on line_number %d\n",p,line_number+1 );
		st->print();
	}
	for (int i = 0; i < quadArray.size(); ++i){
		/* code */
		Quad &q=quadArray[i];
		printf("%3d:",i );
		Quad::emit(q);
	}
	_GLOBST->print();
	globalsEmit("ass5_12CS10037_test.c");
	for (int i = 0; i < quadArray.size(); ++i){
		labelArray[i]=NO_LABEL;
	}
	removeGotoNLabel();
	for (int i = 0; i < quadArray.size(); ++i){
		/* code */
		Quad &q=quadArray[i];
		printf("%3d:",i );
		Quad::emit(q);
	}
	
	try{

		for (int i = 0; i < quadArray.size(); ++i){
		// printf("\t");

		Quad &q=quadArray[i];
		if(labelArray[i]!=NO_LABEL){
			emitLabel(getLabelName(labelArray[i]));
		}
		if(q.op==QPASS)
			continue;
		if(q.op==QFUNC){
			currst=_GLOBST->lookup(q.res)->nestedTable;
		}
		if(q.arg2!=NULL&&q.arg1!=NULL){
			binaryOp(q);
		}
		else if(q.arg2==NULL&&q.op!=0){
			unaryOp(q);
		}
		else
			assignmentOpe(q);
		}
	}
	catch(const char* s){
		printf("%s\n",s );
	}
	fprintf(fp, "%s\n", outs);	
	fclose(fp);
	return 0;
}