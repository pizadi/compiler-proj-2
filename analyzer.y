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
%type expr_r
%type expr
%type prod
%type atm
%type method_call
%type method_name
%type id
%type int_literal


%%

program : TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB decl_r TOKEN_RCB {};

decl_r : method_decl decl_r {}
	| method_decl decl_r {}
	| /*empty*/ {};

method_decl : methodtype id TOKEN_LP expr_r TOKEN_RP block_r {};

field_decl : datatype decl_r TOKEN_SEMICOLON {};

decl_r : var_decl TOKEN_COMMA decl_r {}
	| var_decl {};

var_decl : TOKEN_ID {}
	| TOKEN_ID TOKEN_LB int_literal TOKEN_INT {};

block_r : block block_r {}
	| block {};

block : TOKEN_LCB line_r TOKEN_RCB {};

line_r : statement line_r {}
	| var_decl line_r {}
	| /*empty*/ {};

statement : 
%%

int main(int, char**) {
	for (int i = 0; i < 26; i++) alloc[i] = 0;
	
  FILE *myfile = fopen("in.expr", "r");
  if (!myfile) {
    printf("Failed to open in.expr.\n");
    return -1;
  }
  yyin = myfile;
  yyparse();
}
