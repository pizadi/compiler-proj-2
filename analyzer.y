%{
	#include <stdio.h> 
	#include <iostream>
	#include <math.h> 
	#include <string.h>


	extern int yylex();
	extern int yyparse();
	extern FILE *yyin;
	void yyerror(const char *s);
	int mode = 0;

%}

%union {
	char * str;
	int ival;
}




// token definitions
%token <str> TOKEN_COMMENT
%token <ival> TOKEN_HEX
%token <str> TOKEN_WHITESPACE
%token <str> TOKEN_BOOLEANTYPE
%token <str> TOKEN_BREAKSTMT
%token <str> TOKEN_CALLOUT
%token <str> TOKEN_CLASS
%token <str> TOKEN_CONTINUESTMT
%token <str> TOKEN_INTTYPE
%token <str> TOKEN_STRINGTYPE
%token <str> TOKEN_CHARTYPE
%token <str> TOKEN_VOIDTYPE
%token <str> TOKEN_MAINFUNC
%token <str> TOKEN_LOOP
%token <str> TOKEN_RETURN
%token <str> TOKEN_IFCONDITION
%token <str> TOKEN_ELSECONDITION
%token <str> TOKEN_BOOLEANCONST
%token <str> TOKEN_PROGRAMCLASS
%token <ival> TOKEN_DECIMALCONST
%token <str> TOKEN_ARITHMATICOP_1
%token <str> TOKEN_ARITHMATICOP_2
%token <str> TOKEN_CONDITIONOP
%token <str> TOKEN_RELATIONOP
%token <str> TOKEN_ASSIGNOP
%token <str> TOKEN_LOGICOP
%token <str> TOKEN_LP
%token <str> TOKEN_RP
%token <str> TOKEN_LCB
%token <str> TOKEN_RCB
%token <str> TOKEN_LB
%token <str> TOKEN_RB
%token <str> TOKEN_SEMICOLON
%token <str> TOKEN_COMMA
%token <str> TOKEN_STRINGCONST
%token <str> TOKEN_CHARCONST
%token <str> TOKEN_ID

// type definitions
%type <str> program
%type <str> decl_r
%type <str> method_decl
%type <str> arg_decl_p
%type <str> arg_decl_r
%type <str> arg_decl
%type <str> field_decl
%type <str> var_decl
%type <str> var_decl_p
%type <str> var_decl_r
%type <str> var_decl_c
%type <str> block_r
%type <str> block
%type <str> line_r
%type <str> statement
%type <str> methodtype
%type <str> datatype
%type <str> lval
%type <str> arg_p
%type <str> arg_r
%type <str> callout_arg_p
%type <str> callout_arg_r
%type <str> arg
%type <str> expr
%type <str> prod
%type <str> atm
%type <str> ind
%type <str> method_call
%type <str> method_name
%type <str> id
%type <str> int_literal
%type <str> if_block
%type <str> if_block_r
%type <str> for_block
%type <str> char_literal
// token types


%%

program : TOKEN_CLASS TOKEN_PROGRAMCLASS TOKEN_LCB decl_r TOKEN_RCB {
printf("<program> %s %s %s %s %s", mode?"TOKEN_CLASS ":$1, mode?"TOKEN_PROGRAMCLASS ":$2, mode?"TOKEN_LCB ":$3, $4, mode?"TOKEN_RCB ":$5);};

decl_r : method_decl decl_r {$$ = strdup(""); sprintf($$, "<decl_r> %s %s", $1, $2);}
| field_decl decl_r {$$ = strdup(""); sprintf($$, "<decl_r> %s %s", $1, $2);}
| /*empty*/ {$$ = strdup(""); sprintf($$, "<decl_r>");};

method_decl : methodtype id TOKEN_LP arg_decl_p TOKEN_RP block_r field_decl decl_r {$$ = strdup(""); sprintf($$, "<method_decl> %s %s %s %s %s %s", $1, $2, mode?"TOKEN_LP":$3, $4, mode?"TOKEN_RP":$5, $6);};

arg_decl_p : arg_decl arg_decl_r {$$ = strdup(""); sprintf($$, "<arg_decl_p> %s %s", $1, $2);}
| /*empty*/ {$$ = strdup(""); sprintf($$, "<arg_decl_p>");};

arg_decl_r : TOKEN_COMMA arg_decl arg_decl_r {$$ = strdup(""); sprintf($$, "<arg_decl_r> %s %s %s", mode?"TOKEN_COMMA":$1, $2, $3);}
| /*empty*/ {$$ = strdup(""); sprintf($$, "<arg_decl_r>");};

arg_decl : datatype id {$$ = strdup(""); sprintf($$, "<arg_decl> %s %s", $1, $2);};

field_decl : datatype var_decl_p TOKEN_SEMICOLON {$$ = strdup(""); sprintf($$, "<field_decl> %s %s %s", $1, $2, mode?"TOKEN_SEMICOLON":$3);};

var_decl_p : var_decl_c var_decl_r {$$ = strdup(""); sprintf($$, "<var_decl_p> %s %s %s", $1, $2);};

var_decl_r : TOKEN_COMMA var_decl_c var_decl_r {$$ = strdup(""); sprintf($$, "<decl_r> %s %s %s", mode?"TOKEN_COMMA":$1, $2, $3);}
| /*empty*/ {$$ = strdup(""); sprintf($$, "<var_decl_r>");};

var_decl_c : TOKEN_ID ind {$$ = strdup(""); sprintf($$, "<var_decl_c> %s %s", mode?"TOKEN_ID":$1, $2);};

var_decl : TOKEN_ID {$$ = strdup(""); sprintf($$, "<var_decl> %s", $1);}
| TOKEN_ID TOKEN_LB int_literal TOKEN_RB {$$ = strdup(""); sprintf($$, "<var_decl> %s %s %s %s", mode?"TOKEN_ID":$1, mode?"TOKEN_LB":$2, $3, mode?"TOKEN_RB":$4);};

block_r : block block_r {$$ = strdup(""); sprintf($$, "<block_r> %s %s", $1, $2);}
| block {$$ = strdup(""); sprintf($$, "<block_r> %s", $1);};

block : TOKEN_LCB line_r TOKEN_RCB {$$ = strdup(""); sprintf($$, "<block> %s %s %s", mode?"TOKEN_LCB":$1, $2, mode?"TOKEN_RCB":$3);};

line_r : statement line_r {$$ = strdup(""); sprintf($$, "<line_r> %s %s", $1, $2);}
| var_decl line_r {$$ = strdup(""); sprintf($$, "<line_r> %s %s", $1, $2);}
| /*empty*/ {$$ = strdup(""); sprintf($$, "<line_r>");};

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

datatype : TOKEN_INTTYPE {$$ = strdup(""); sprintf($$, "<datatype> %s", mode?"TOKEN_INTTYPE":$1);}
| TOKEN_STRINGTYPE {$$ = strdup(""); sprintf($$, "<datatype> %s", mode?"TOKEN_STRINGTYPE":$1);}
| TOKEN_CHARTYPE {$$ = strdup(""); sprintf($$, "<datatype> %s", mode?"TOKEN_CHARTYPE":$1);};

lval : TOKEN_ID {$$ = strdup(""); sprintf($$, "<lval> %s", mode?"TOKEN_ID":$1);}
| TOKEN_ID ind {$$ = strdup(""); sprintf($$, "<lval> %s %s", mode?"TOKEN_ID":$1, $2);};

arg_p : arg arg_r {$$ = strdup(""); sprintf($$, "<arg_p> %s %s", $1, $2);}
| /*empty*/ {$$ = strdup(""); sprintf($$, "<arg_p>");};

arg_r : TOKEN_COMMA arg arg_r {$$ = strdup(""); sprintf($$, "<arg_r> %s %s", mode?"TOKEN_COMMA":$1, $2);}
| arg {$$ = strdup(""); sprintf($$, "<arg_r> %s", $1);};

arg : expr {}
| TOKEN_STRINGCONST {};

expr : prod TOKEN_ARITHMATICOP_1 expr {}
| prod {};

prod : atm TOKEN_ARITHMATICOP_2 prod {}
| TOKEN_LOGICOP prod {}
| atm {};

atm : TOKEN_ID ind {$$ = strdup(""); sprintf($$, "<atm> %s %s", mode?"TOKEN_ID":$1, $2);}
| char_literal {$$ = strdup(""); sprintf($$, "<atm> %s", $1);}
| int_literal {$$ = strdup(""); sprintf($$, "<atm> %s", $1);}
| TOKEN_LP expr TOKEN_RP {$$ = strdup(""); sprintf($$, "<atm> %s %s %s", mode?"TOKEN_LP":$1, $2, mode?"TOKEN_RP":$3);};

ind : TOKEN_LB expr TOKEN_RB {$$ = strdup(""); sprintf($$, "<ind> %s %s %s", mode?"TOKEN_LB":$1, $2, mode?"TOKEN_RB":$3);}
| /*empty*/ {$$ = strdup("<ind>");};

method_call : method_name TOKEN_LP arg_p TOKEN_RP {$$ = strdup(""); sprintf($$, "<method_call> %s %s %s %s", $1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_RP":$4);};
| TOKEN_CALLOUT TOKEN_LP callout_arg_p TOKEN_RP {$$ = strdup(""); sprintf($$, "<method_call> %s %s %s %s", mode?"TOKEN_CALLOUT":$1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_RP":$4);};

callout_arg_p : TOKEN_STRINGCONST arg_r {$$ = strdup(""); sprintf($$, "<callout_arg_p> %s %s", mode?"TOKEN_STRINGCONST":$1, $2);};

method_name : id {$$ = strdup(""); sprintf($$, "<method_name> %s", $1);};

id : TOKEN_ID {$$ = strdup(""); sprintf($$, "<id> %s", mode?"TOKEN_ID":$1);}
| TOKEN_MAINFUNC {$$ = strdup(""); sprintf($$, "<id> %s", mode?"TOKEN_MAINFUNC":$1);};

int_literal : TOKEN_DECIMALCONST {
	$$ = strdup("");
	if (mode) sprintf($$, "<int_literal> TOKEN_DECIMALCONST");
	else sprintf($$, "<int_literal> %d", $1);
}
| TOKEN_HEX {
	$$ = strdup("");
	if (mode) sprintf($$, "<int_literal> TOKEN_DECIMALCONST");
	else sprintf($$, "<int_literal> %x", $1);
};

if_block : TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block {}
| TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block TOKEN_ELSECONDITION if_block_r {};

if_block_r : if_block {}
| block {};

for_block : TOKEN_LOOP TOKEN_LP statement TOKEN_COMMA expr TOKEN_RP block {};

char_literal : TOKEN_CHARCONST {
	$$ = strdup("");
	if (mode) sprintf($$, "<char_literal> TOKEN_CHARCONST");
	else sprintf($$, "<char_literal> %s", $1);
};

%%

int main(int argc, char ** argv) {
	if (argc > 1) mode = atoi(argv[1]); 
	FILE *myfile = fopen("in.expr", "r");
	if (!myfile) {
		printf("Failed to open in.expr.\n");
	return -1;
	}
	yyin = myfile;
	yyparse();
}

void yyerror(char const * message){
	std::cout << message << std::endl;
}
