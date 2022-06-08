%{
#include <stdio.h> 
#include <math.h> 


extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);


%}

// token definitions
%token TOKEN_COMMENT
%token TOKEN_HEX
%token TOKEN_WHITESPACE
%token TOKEN_BOOLEANTYPE
%token TOKEN_BREAKSTMT
%token TOKEN_CALLOUT
%token TOKEN_CLASS
%token TOKEN_CONTINUESTMT
%token TOKEN_INTTYPE
%token TOKEN_STRINGTYPE
%token TOKEN_CHARTYPE
%token TOKEN_VOIDTYPE
%token TOKEN_MAINFUNC
%token TOKEN_LOOP
%token TOKEN_RETURN
%token TOKEN_IFCONDITION
%token TOKEN_ELSECONDITION
%token TOKEN_BOOLEANCONST
%token TOKEN_PROGRAMCLASS
%token TOKEN_DECIMALCONST
%token TOKEN_ARITHMATICOP_1
%token TOKEN_ARITHMATICOP_2
%token TOKEN_CONDITIONOP
%token TOKEN_RELATIONOP
%token TOKEN_ASSIGNOP
%token TOKEN_LOGICOP
%token TOKEN_LP
%token TOKEN_RP
%token TOKEN_LCB
%token TOKEN_RCB
%token TOKEN_LB
%token TOKEN_RB
%token TOKEN_SEMICOLON
%token TOKEN_COMMA
%token TOKEN_STRINGCONST
%token TOKEN_CHARCONST
%token TOKEN_ID

// type definitions
%type program
%type decl_r
%type method_decl
%type arg_decl_r
%type arg_decl
%type field_decl
%type decl_r
%type var_decl
%type block_r
%type block
%type line_r
%type statement
%type methodtype
%type datatype
%type lval
%type arg_r
%type callout_arg_r
%type arg
%type expr
%type prod
%type atm
%type ind
%type method_call
%type method_name
%type id
%type int_literal
%type if_block
%type if_block_r
%type for_block

%%

program : TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB decl_r TOKEN_RCB {};

decl_r : method_decl decl_r {}
	| field_decl decl_r {}
	| /*empty*/ {};

method_decl : methodtype id TOKEN_LP arg_decl_r TOKEN_RP block_r {};

arg_decl_r : arg_decl TOKEN_COMMA arg_decl_r {}
	| arg_decl {};

arg_decl : datatype id {};

field_decl : datatype decl_r TOKEN_SEMICOLON {};

decl_r : var_decl TOKEN_COMMA decl_r {}
	| var_decl {};

var_decl : TOKEN_ID {}
	| TOKEN_ID TOKEN_LB int_literal TOKEN_RB {};

block_r : block block_r {}
	| block {};

block : TOKEN_LCB line_r TOKEN_RCB {};

line_r : statement line_r {}
	| var_decl line_r {}
	| /*empty*/ {};

statement : lval TOKEN_ASSIGNOP expr TOKEN_SEMICOLON {};
	| method_call TOKEN_SEMICOLON {}
	| if_block {}
	| for_block {}
	| TOKEN_RETURN expr TOKEN_SEMICOLON {}
	| TOKEN_BREAKSTMT TOKEN_SEMICOLON {}
	| TOKEN_CONTINUESTMT TOKEN_SEMICOLON {}
	| block {};

methodtype : datatype {}
	| TOKEN_VOIDTYPE {};

datatype : TOKEN_INTTYPE {}
	| TOKEN_STRINGTYPE {}
	| TOKEN_CHARTYPE {};

lval : TOKEN_ID {}
	| TOKEN_ID TOKEN_LB expr TOKEN_RB {};

arg_r : arg TOKEN_COMMA arg_r {}
	| arg {};

arg : expr {}
	| TOKEN_STRINGCONST {};

expr : prod TOKEN_ARITHMATICOP_1 expr {}
	| prod {};

prod : atm TOKEN_ARITHMATICOP_2 prod {}
	| TOKEN_LOGICOP prod {}
	| atm {};

atm : TOKEN_ID ind {}
	| TOKEN_CHARCONST {}
	| int_literal {}
	| TOKEN_LP expr TOKEN_RP {};

ind : TOKEN_LB expr TOKEN_RB {};

method_call : method_name TOKEN_LP arg_r TOKEN_RP {};
	| TOKEN_CALLOUT TOKEN_LP callout_arg_r TOKEN_RP {};

callout_arg_r : TOKEN_STRINGCONST {}
	| TOKEN_STRINGCONST TOKEN_COMMA arg_r {};

method_name : id {};

id : TOKEN_ID {}
| TOKEN_MAINFUNC;

int_literal : TOKEN_DECIMALCONST {}
	| TOKEN_HEX {};

if_block : TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block {}
	| TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block TOKEN_ELSECONDITION if_block_r {};

if_block_r : if_block {}
	| block {};

for_block : TOKEN_LOOP TOKEN_LP statement TOKEN_COMMA expr TOKEN_RP block {};

%%

int main(int, char**) {
	
  FILE *myfile = fopen("in.expr", "r");
  if (!myfile) {
    printf("Failed to open in.expr.\n");
    return -1;
  }
  yyin = myfile;
  yyparse();
}
