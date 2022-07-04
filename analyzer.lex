%{
	#include <iostream>
	#include <string>
	#include <string.h>
	#include <cstdlib>
	#include "analyzer.tab.h"
	#define YY_NO_UNPUT
	long long int temp;
	long long int line = 1;

	

%}

%option noyywrap


%%
\/\/.* { return TOKEN_COMMENT;}

0x[0-9a-fA-F]{1,8} {
	int temp;
	sscanf(yytext, "%x", &temp);
	return TOKEN_HEX;
}

0x0*[1-9A-Fa-f][0-9A-Fa-f]{9,} {
	std::cout << "[" << line << "]ERROR: Hexadecimal constant " << yytext << " out of range." << std::endl;
}

\n {
	line += 1;
}

\t* {}

[ ]* {}

"boolean" { yylval.str = strdup(yytext); return TOKEN_BOOLEANTYPE;}

"void" { yylval.str = strdup(yytext); return TOKEN_VOIDTYPE;}

"break" { yylval.str = strdup(yytext); return TOKEN_BREAKSTMT;}

"callout" { yylval.str = strdup(yytext); return TOKEN_CALLOUT;}

"class" { yylval.str = strdup(yytext); return TOKEN_CLASS;}

"continue" { yylval.str = strdup(yytext); return TOKEN_CONTINUESTMT;}                              

"int" { yylval.str = strdup(yytext); return TOKEN_INTTYPE;}

"string" { yylval.str = strdup(yytext); return TOKEN_STRINGTYPE;}

"char" { yylval.str = strdup(yytext); return TOKEN_CHARTYPE;}

"main" { yylval.str = strdup(yytext); return TOKEN_MAINFUNC;}

"for" { yylval.str = strdup(yytext); return TOKEN_LOOP;}

"return" { yylval.str = strdup(yytext); return TOKEN_RETURN;}

"if" { yylval.str = strdup(yytext); return TOKEN_IFCONDITION;}

"else" { yylval.str = strdup(yytext); return TOKEN_ELSECONDITION;}

"true" { yylval.str = strdup(yytext); return TOKEN_BOOLEANCONST;}

"false" { yylval.str = strdup(yytext); return TOKEN_BOOLEANCONST;}

"Program" { yylval.str = strdup(yytext); return TOKEN_PROGRAMCLASS;}



[-]?([1-9][0-9]*|0) {
	temp = atoll(yytext);
	if (temp <= 2147483647 && temp >= -2147483648){
		yylval.ival = atoi(yytext);
	}
	else {
		std::cout << "[" << line << "]ERROR: Decimal constant " << yytext << " out of range." << std::endl;
	}
	return TOKEN_DECIMALCONST;
}

"+" { yylval.str = strdup(yytext); return TOKEN_ARITHMATICOP_1;}

"-" { yylval.str = strdup(yytext); return TOKEN_ARITHMATICOP_1;}

"/" { yylval.str = strdup(yytext); return TOKEN_ARITHMATICOP_2;}

"*" { yylval.str = strdup(yytext); return TOKEN_ARITHMATICOP_2;}

"%" { yylval.str = strdup(yytext); return TOKEN_ARITHMATICOP_2;}

"&&" { yylval.str = strdup(yytext); return TOKEN_CONDITIONOP;}

"||" { yylval.str = strdup(yytext); return TOKEN_CONDITIONOP;}

"=<" { yylval.str = strdup(yytext); return TOKEN_RELATIONOP;}

"<" { yylval.str = strdup(yytext); return TOKEN_RELATIONOP;}

">" { yylval.str = strdup(yytext); return TOKEN_RELATIONOP;}

"=" { yylval.str = strdup(yytext); return TOKEN_ASSIGNOP;}

"+=" { yylval.str = strdup(yytext); return TOKEN_ASSIGNOP;}

"-=" { yylval.str = strdup(yytext); return TOKEN_ASSIGNOP;}

"!" { yylval.str = strdup(yytext); return TOKEN_LOGICOP;}

"=>" { yylval.str = strdup(yytext); return TOKEN_RELATIONOP;}

"==" { yylval.str = strdup(yytext); return TOKEN_RELATIONOP;}

"!=" { yylval.str = strdup(yytext); return TOKEN_RELATIONOP;}

"(" { yylval.str = strdup(yytext); return TOKEN_LP;}

")" { yylval.str = strdup(yytext); return TOKEN_RP;}

"{" { yylval.str = strdup(yytext); return TOKEN_LCB;}

"}" { yylval.str = strdup(yytext); return TOKEN_RCB;}
					

"[" { yylval.str = strdup(yytext); return TOKEN_LB;}

"]" { yylval.str = strdup(yytext); return TOKEN_RB;}
					
";" { yylval.str = strdup(yytext); return TOKEN_SEMICOLON;}

"," { yylval.str = strdup(yytext); return TOKEN_COMMA;}

\"([^\\\"\']|\\[\\\'\"abfnrtv])*\" { yylval.str = strdup(yytext); return TOKEN_STRINGCONST;}

\'([^\\\']|\\[abfnrtv\\\"\'])\' { yylval.str = strdup(yytext); return TOKEN_CHARCONST;}

[A-Za-z_][A-Za-z0-9_]* { yylval.str = strdup(yytext); return TOKEN_ID;}

[0-9!@$%^&]+[a-zA-Z|_|-]+   {
	std::cout <<"[" << line << "]ERROR: Wrong id definition " << yytext << std::endl;
}

\'([^\\\']|\\[abfnrtv\\\"\']){2,}\' {
	std::cout << "[" << line << "]ERROR: Invalid char constant " << yytext << std::endl;
}

. { }

%%




