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
	printf("<program> %s %s %s %s %s\n", mode?"TOKEN_CLASS ":$1, mode?"TOKEN_PROGRAMCLASS ":$2, mode?"TOKEN_LCB ":$3, $4, mode?"TOKEN_RCB ":$5);
};

decl_r : method_decl decl_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+11);
	sprintf($$, "<decl_r> %s %s", $1, $2);
	free($1);
	free($2);
}
| field_decl decl_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+11);
	sprintf($$, "<decl_r> %s %s", $1, $2);
	free($1);
	free($2);
}
| /*empty*/ {
	$$ = (char*) malloc(9);
	sprintf($$, "<decl_r>");
};

method_decl : methodtype id TOKEN_LP arg_decl_p TOKEN_RP block_r field_decl decl_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+strlen($4)+strlen($6)+37);
	sprintf($$, "<method_decl> %s %s %s %s %s %s", $1, $2, mode?"TOKEN_LP":$3, $4, mode?"TOKEN_RP":$5, $6);
	free($1);
	free($2);
	free($3);
	free($4);
	free($5);
	free($6);
};

arg_decl_p : arg_decl arg_decl_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+15);
	sprintf($$, "<arg_decl_p> %s %s", $1, $2);
	free($1);
	free($2);
}
| /*empty*/ {
	$$ = (char*) malloc(13);
	sprintf($$, "<arg_decl_p>");
};

arg_decl_r : TOKEN_COMMA arg_decl arg_decl_r {
	$$ = (char*) malloc(strlen($2) + strlen($3) + 27);
	sprintf($$, "<arg_decl_r> %s %s %s", mode?"TOKEN_COMMA":$1, $2, $3);
	free($1);
	free($2);
	free($3);
}
| /*empty*/ {
	$$ = (char*) malloc(13);
	sprintf($$, "<arg_decl_r>");
};

arg_decl : datatype id {
	$$ = (char*) malloc(strlen($1)+strlen($2)+13);
	sprintf($$, "<arg_decl> %s %s", $1, $2);
	free($1);
	free($2);
};

field_decl : datatype var_decl_p TOKEN_SEMICOLON {
	$$ = (char*) malloc(strlen($1)+strlen($2)+31);
	sprintf($$, "<field_decl> %s %s %s", $1, $2, mode?"TOKEN_SEMICOLON":$3);
	free($1);
	free($2);
	free($3);
};

var_decl_p : var_decl_c var_decl_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+15);
	sprintf($$, "<var_decl_p> %s %s", $1, $2);
};

var_decl_r : TOKEN_COMMA var_decl_c var_decl_r {
	$$ = (char*) malloc(strlen($2)+strlen($3)+12);
	sprintf($$, "<var_decl_r> %s %s %s", mode?"TOKEN_COMMA":$1, $2, $3);
	free($1);
	free($2);
	free($3);
}
| /*empty*/ {
	$$ = (char*) malloc(13);
	sprintf($$, "<var_decl_r>");
};

var_decl_c : TOKEN_ID ind {
	$$ = (char*) malloc(strlen($1)+strlen($2)+23);
	sprintf($$, "<var_decl_c> %s %s", mode?"TOKEN_ID":$1, $2);
	free($1);
	free($2);
};

var_decl : TOKEN_ID {
	$$ = (char*) malloc(strlen($1)+12);
	sprintf($$, "<var_decl> %s", $1);
	free($1);
}
| TOKEN_ID TOKEN_LB int_literal TOKEN_RB {
	$$ = (char*) malloc(strlen($1)+strlen($3)+39);
	sprintf($$, "<var_decl> %s %s %s %s", mode?"TOKEN_ID":$1, mode?"TOKEN_LB":$2, $3, mode?"TOKEN_RB":$4);
	free($1);
	free($2);
	free($3);
	free($4);
};

block_r : block block_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+11);
	sprintf($$, "<block_r> %s %s", $1, $2);
	free($1);
	free($2);
}
| block {
	$$ = (char*) malloc(strlen($1)+10);
	sprintf($$, "<block_r> %s", $1);
	free($1);
};

block : TOKEN_LCB line_r TOKEN_RCB {
	$$ = (char*) malloc(strlen($2)+29);
	sprintf($$, "<block> %s %s %s", mode?"TOKEN_LCB":$1, $2, mode?"TOKEN_RCB":$3);
	free($1);
	free($2);
	free($3);
};

line_r : statement line_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+11);
	sprintf($$, "<line_r> %s %s", $1, $2);
	free($1);
	free($2);
}
| var_decl line_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+11);
	sprintf($$, "<line_r> %s %s", $1, $2);
	free($1);
	free($2);
}
| /*empty*/ {
	$$ = (char*) malloc(9);
	sprintf($$, "<line_r>");
};

statement : lval TOKEN_ASSIGNOP expr TOKEN_SEMICOLON {
	$$ = (char*) malloc(strlen($1)+strlen($3)+45);
	sprintf($$, "<statement> %s %s %s %s", $1, mode?"TOKEN_ASSIGNOP":$2, $3, mode?"TOKEN_SEMICOLON":$4);
	free($1);
	free($2);
	free($3);
	free($4);
}
| method_call TOKEN_SEMICOLON {
	$$ = (char*) malloc(strlen($1)+31);
	sprintf($$, "<statement> %s %s", $1, mode?"TOKEN_SEMICOLON":$2);
	free($1);
	free($2);
}
| if_block {
	$$ = (char*) malloc(strlen($1)+13);
	sprintf($$, "<statement> %s", $1);
	free($1);
}
| for_block {
	$$ = (char*) malloc(strlen($1)+13);
	sprintf($$, "<statement> %s", $1);
	free($1);
}
| TOKEN_RETURN expr TOKEN_SEMICOLON {
	$$ = (char*) malloc(strlen($2)+40);
	sprintf($$, "<statement> %s %s %s",mode?"TOKEN_RETURN":$1, $2,mode?"TOKEN_SEMICOLON":$3);
	free($1);
	free($2);
	free($3);
}
| TOKEN_BREAKSTMT TOKEN_SEMICOLON {
	$$ = (char*) malloc(43);
	sprintf($$, "<statement> %s %s",mode?"TOKEN_BREAKSTMT":$1, mode?"TOKEN_SEMICOLON":$2);
	free($1);
	free($2);
}
| TOKEN_CONTINUESTMT TOKEN_SEMICOLON {
	$$ = (char*) malloc(46);
	sprintf($$, "<statement> %s %s",mode?"TOKEN_CONTINUESTMT":$1, mode?"TOKEN_SEMICOLON":$2);
	free($1);
	free($2);
}
| block {
	$$ = (char*) malloc(strlen($1)+13);
	sprintf($$, "<statement> %s", $1);
	free($1);
};

methodtype : datatype {
	$$ = (char*) malloc(strlen($1)+14);
	sprintf($$, "<methodtype> %s", $1);
	free($1);
}
| TOKEN_VOIDTYPE {
	$$ = (char*) malloc(28);
	sprintf($$, "<methodtype> %s",mode?"TOKEN_VOIDTYPE":$1);
	free($1);
};

datatype : TOKEN_INTTYPE {
	$$ = (char*) malloc(25);
	sprintf($$, "<datatype> %s", mode?"TOKEN_INTTYPE":$1);
	free($1);
}
| TOKEN_STRINGTYPE {
	$$ = (char*) malloc(28);
	sprintf($$, "<datatype> %s", mode?"TOKEN_STRINGTYPE":$1);
	free($1);
}
| TOKEN_CHARTYPE {
	$$ = (char*) malloc(26);
	sprintf($$, "<datatype> %s", mode?"TOKEN_CHARTYPE":$1);
	free($1);
};

lval : TOKEN_ID {
	$$ = (char*) malloc(strlen($1)+16);
	sprintf($$, "<lval> %s", mode?"TOKEN_ID":$1);
	free($1);
}
| TOKEN_ID ind {
	$$ = (char*) malloc(strlen($1)+strlen($2)+17);
	sprintf($$, "<lval> %s %s", mode?"TOKEN_ID":$1, $2);
	free($1);
	free($2);
};

arg_p : arg arg_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+10);
	sprintf($$, "<arg_p> %s %s", $1, $2);
	free($1);
	free($2);
}
| /*empty*/ {
	$$ = (char*) malloc(8);
	sprintf($$, "<arg_p>");
};

arg_r : TOKEN_COMMA arg arg_r {
	$$ = (char*) malloc(strlen($2)+21);
	sprintf($$, "<arg_r> %s %s", mode?"TOKEN_COMMA":$1, $2);
	free($1);
	free($2);
}
| arg {
	$$ = (char*) malloc(strlen($1)+9);
	sprintf($$, "<arg_r> %s", $1);
	free($1);
};

arg : expr {
	$$ = (char*) malloc(strlen($1)+7);
	sprintf($$, "<arg> %s", $1);
	free($1);
}
| TOKEN_STRINGCONST {
	$$ = (char*) malloc(strlen($1)+24);
	sprintf($$, "<arg> %s",mode?"TOKEN_STRINGCONST":$1);
	free($1);
};

expr : prod TOKEN_ARITHMATICOP_1 expr {
	$$ = (char*) malloc(strlen($1)+strlen($3)+30);
	sprintf($$, "<expr> %s %s %s", $1,mode?"TOKEN_ARITHMATICOP_1":$2, $3);
	free($1);
	free($2);
	free($3);
}
| prod {
	$$ = (char*) malloc(strlen($1)+8);
	sprintf($$, "<expr> %s", $1);
	free($1);
};

prod : atm TOKEN_ARITHMATICOP_2 prod {
	$$ = (char*) malloc(strlen($1)+strlen($3)+30);
	sprintf($$, "<prod> %s %s %s", $1, mode?"TOKEN_ARITHMATICOP_2":$2, $3);
	free($1);
	free($2);
	free($3);
}
| TOKEN_LOGICOP prod {
	$$ = (char*) malloc(strlen($2)+22);
	sprintf($$, "<prod> %s %s",mode?"TOKEN_LOGICOP":$1, $2);
	free($1);
	free($2);
}
| atm {
	$$ = (char*) malloc(strlen($1)+8);
	sprintf($$, "<prod> %s", $1);
	free($1);
};

atm : TOKEN_ID ind {
	$$ = (char*) malloc(strlen($1)+strlen($2)+16);
	sprintf($$, "<atm> %s %s", mode?"TOKEN_ID":$1, $2);
	free($1);
	free($2);
}
| char_literal {
	$$ = (char*) malloc(strlen($1)+7);
	sprintf($$, "<atm> %s", $1);
	free($1);
}
| int_literal {
	$$ = (char*) malloc(strlen($1)+7);
	sprintf($$, "<atm> %s", $1);
	free($1);
}
| TOKEN_LP expr TOKEN_RP {
	$$ = (char*) malloc(strlen($2)+23);
	sprintf($$, "<atm> %s %s %s", mode?"TOKEN_LP":$1, $2, mode?"TOKEN_RP":$3);
	free($1);
	free($2);
	free($3);
};

ind : TOKEN_LB expr TOKEN_RB {
	$$ = (char*) malloc(strlen($2)+25);
	sprintf($$, "<ind> %s %s %s", mode?"TOKEN_LB":$1, $2, mode?"TOKEN_RB":$3);
	free($1);
	free($2);
	free($3);
}
| /*empty*/ {
	$$ = (char*) malloc(6);
	sprintf($$, "<ind>");
};

method_call : method_name TOKEN_LP arg_p TOKEN_RP {
	$$ = (char*) malloc(strlen($1)+strlen($3)+34);
	sprintf($$, "<method_call> %s %s %s %s", $1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_RP":$4);
	free($1);
	free($2);
	free($3);
	free($4);
}
| TOKEN_CALLOUT TOKEN_LP callout_arg_p TOKEN_RP {
	$$ = (char*) malloc(strlen($3)+47);
	sprintf($$, "<method_call> %s %s %s %s", mode?"TOKEN_CALLOUT":$1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_RP":$4);
	free($1);
	free($2);
	free($3);
	free($4);
};

callout_arg_p : TOKEN_STRINGCONST arg_r {
	$$ = (char*) malloc(strlen($1)+strlen($2)+35);
	sprintf($$, "<callout_arg_p> %s %s", mode?"TOKEN_STRINGCONST":$1, $2);
	free($1);
	free($2);
};

method_name : id {
	$$ = (char*) malloc(strlen($1)+15);
	sprintf($$, "<method_name> %s", $1);
	free($1);
};

id : TOKEN_ID {
	$$ = (char*) malloc(strlen($1)+14);
	sprintf($$, "<id> %s", mode?"TOKEN_ID":$1);
	free($1);
}
| TOKEN_MAINFUNC {
	$$ = (char*) malloc(20);
	sprintf($$, "<id> %s", mode?"TOKEN_MAINFUNC":$1);
	free($1);
};

int_literal : TOKEN_DECIMALCONST {
	$$ = (char*) malloc(33);
	if (mode) sprintf($$, "<int_literal> TOKEN_DECIMALCONST");
	else sprintf($$, "<int_literal> %d", $1);
}
| TOKEN_HEX {
	$$ = (char*) malloc(25);
	if (mode) sprintf($$, "<int_literal> TOKEN_HEX");
	else sprintf($$, "<int_literal> %x", $1);
};

if_block : TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block {
	$$ = (char*) malloc(strlen($3)+strlen($5)+49);
	sprintf($$, "<if_block> %s %s %s %s %s", mode?"TOKEN_IFCONDITION":$1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_RP":$4, $5);
	free($1);
	free($2);
	free($3);
	free($4);
	free($5);
}
| TOKEN_IFCONDITION TOKEN_LP expr TOKEN_RP block TOKEN_ELSECONDITION if_block_r {
	$$ = (char*) malloc(strlen($3)+strlen($5)+strlen($7)+70);
	sprintf($$, "<if_block> %s %s %s %s %s %s %s", mode?"TOKEN_IFCONDITION":$1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_RP":$4, $5, mode?"TOKEN_ELSECONDITION":$6, $7);
	free($1);
	free($2);
	free($3);
	free($4);
	free($5);
	free($6);
	free($7);
};

if_block_r : if_block {
	$$ = (char*) malloc(strlen($1)+14);
	sprintf($$, "<if_block_r> %s", $1);
	free($1);
}
| block {
	$$ = (char*) malloc(strlen($1)+14);
	sprintf($$, "<if_block_r> %s", $1);
	free($1);
};

for_block : TOKEN_LOOP TOKEN_LP statement TOKEN_COMMA expr TOKEN_RP block {
	$$ = (char*) malloc(strlen($3)+strlen($5)+strlen($7)+53);
	sprintf($$, "<if_block> %s %s %s %s %s %s %s", mode?"TOKEN_LOOP":$1, mode?"TOKEN_LP":$2, $3, mode?"TOKEN_COMMA":$4, $5, mode?"TOKEN_RP":$6, $7);
	free($1);
	free($2);
	free($3);
	free($4);
	free($5);
	free($6);
	free($7);
};

char_literal : TOKEN_CHARCONST {
	$$ = (char*) malloc(32);
	if (mode) sprintf($$, "<char_literal> TOKEN_CHARCONST");
	else sprintf($$, "<char_literal> %s", $1);
	free($1);
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
