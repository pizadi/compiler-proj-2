%{
  #include <stdio.h>
  long long int temp;
  long long int line = 1;
  %option noyywrap
%}


%%
\/\/.* {
	printf("TOKEN_COMMENT %s \n", yytext);
}

0x[0-9a-fA-F]{1,8} {
	printf("Token_Hex %s\n", yytext);
}

0x0*[1-9A-Fa-f][0-9A-Fa-f]{9,} {
	printf("[%d]ERROR: Hexadecimal constant %s out of range\n", line, yytext);
}

\n {
	printf("TOKEN_WHITESPACE [newline]\n");
	line += 1;
}

\t* {
	printf("TOKEN_WHITESPACE [tab]\n");
}

[ ]* {
	printf("TOKEN_WHITESPACE [space]\n");
}

"boolean" {
	printf("TOKEN_BOOLEANTYPE boolean\n");
}

"break" {
	printf("TOKEN_BREAKSTMT break\n");
}

"callout" {
	printf("TOKEN_CALLOUT callout\n");
}

"class" {
	printf("TOKEN_CLASS class\n");
}

"continue" { 
	printf("TOKEN_CONTINUESTMT continue\n");
}                              

"int" {
	printf("TOKEN_INTTYPE int\n");
}

"string" {
	printf("TOKEN_STRINGTYPE string\n");
}

"char" {
	printf("TOKEN_CHARTYPE char\n");
}

"void" {
	printf("TOKEN_VOIDTYPE void\n");
}

"main" {
	printf("TOKEN_MAINFUNC main\n");
}

"for" {
	printf("TOKEN_LOOP for\n");
}

"return" {
	printf("TOKEN_RETURN return\n");
}

"if" {
	printf("TOKEN_IFCONDITION if\n");
}

"else" {
	printf("TOKEN_ELSECONDITION else\n");
}

"true" {
	printf("TOKEN_BOOLEANCONST true\n");
}

"false" {
	printf("TOKEN_BOOLEANCONST false\n");
}

"Program" {
	printf("TOKEN_PROGRAMCLASS program\n");
}



[-]?([1-9][0-9]*|0) {
	sscanf(yytext, "%lld", &temp);
	if (temp <= 2147483647 && temp >= -2147483648){
		printf("TOKEN_DECIMALCONST %lld\n", temp);
	}
	else {
		printf("[%d]ERROR: Decimal constant %lld out of range.\n", line, temp);
	}
}

"+" {
	printf("TOKEN_ARITHMATICOP +\n");
}

"-" {
	printf("TOKEN_ARITHMATICOP -\n");
}

"/" {
	printf("TOKEN_ARITHMATICOP /\n");
}

"*" {
	printf("TOKEN_ARITHMATICOP *\n");
}

"%" {
	printf("TOKEN_ARITHMATICOP /\n");
}

"&&" {
	printf("TOKEN_CONDITIONOP &&\n");
}

"||" {
	printf("TOKEN_CONDITIONOP ||\n");
}

"=<" {
	printf("TOKEN_RELATIONOP =<\n");
}

"<" {
	printf("TOKEN_RELATIONOP <\n");
}

">" {
	printf("TOKEN_RELATIONOP >\n");
}

"=" {
	printf("TOKEN_ASSIGNOP =\n");
}

"+=" {
	printf("TOKEN_ASSIGNOP =\n");
}

"-=" {
	printf("TOKEN_ASSIGNOP =\n");
}

"!" {
	printf("TOKEN_LOGICOP =\n");
}

"=>" {
	printf("TOKEN_RELATIONOP =>\n");
}
"==" {
	printf("TOKEN_RELATIONOP ==\n");
}
"!=" {
	printf("TOKEN_RELATIONOP =!\n");
}

"(" {
	printf("TOKEN_LP \(\n");
}

")" {
	printf("TOKEN_RP )\n");
}

"{" {
	printf("TOKEN_LCB 	{\n");
}

"}" {
	printf("TOKEN_RCB }\n");
}
					

"[" {
	printf("TOKEN_LB [\n");
}

"]" {
	printf("TOKEN_RB ]\n");
}
					
";" {
	printf("TOKEN_SEMICOLON ;\n");
}

"," {
	printf("TOKEN_COMMA ,\n");
}

\"([^\\\"\']|\\[\\\'\"abfnrtv])*\" {
	printf("TOKEN_STRINGCONST %s\n", yytext);
}

\'([^\\\']|\\[abfnrtv\\\"\'])\' {
	printf("TOKEN_CHARCONST %s\n", yytext);
}

[A-Za-z_][A-Za-z0-9_]* {
	printf("TOKEN_ID %s\n", yytext);
}

[0-9!@$%^&]+[a-zA-Z|_|-]+   {
	printf("[%d]ERROR: Wrong id definition %s\n", line, yytext);
}

\'([^\\\']|\\[abfnrtv\\\"\']){2,}\' {
	printf("[%d]ERROR: Invalid char constant %s\n", line, yytext);
}

%%

int yywrap() {}


