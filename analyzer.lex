%{
#include <iostream>
#include <string>
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
	int val = 0;
	char * ptr = yytext + 2;
	while(*ptr != '\0'){
		val = val*8;
		if (*ptr >= '0' && *ptr <= '9') val += (*ptr) - '0';
		else if (*ptr >= 'A' && *ptr <= 'F') val += (*ptr) - 'A' + 10;
		else val += (*ptr) - 'a' + 10;
	}
	yylval = val;
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

"boolean" { return TOKEN_BOOLEANTYPE;}

"void" { return TOKEN_VOIDTYPE;}

"break" { return TOKEN_BREAKSTMT;}

"callout" { return TOKEN_CALLOUT;}

"class" { return TOKEN_CLASS;}

"continue" { return TOKEN_CONTINUESTMT;}                              

"int" { return TOKEN_INTTYPE;}

"string" { return TOKEN_STRINGTYPE;}

"char" { return TOKEN_CHARTYPE;}

"main" { return TOKEN_MAINFUNC;}

"for" { return TOKEN_LOOP;}

"return" { return TOKEN_RETURN;}

"if" { return TOKEN_IFCONDITION;}

"else" { return TOKEN_ELSECONDITION;}

"true" { return TOKEN_BOOLEANCONST;}

"false" { return TOKEN_BOOLEANCONST;}

"Program" { return TOKEN_PROGRAMCLASS;}



[-]?([1-9][0-9]*|0) {
	temp = atoll(yytext);
	if (temp <= 2147483647 && temp >= -2147483648){
		yylval = temp;
		return TOKEN_DECIMALCONST;
	}
	else {
		std::cout << "[" << line << "]ERROR: Decimal constant " << yytext << " out of range." << std::endl;
	}
}

"+" { yylval.str = new std::string(yytext); return TOKEN_ARITHMATICOP_1;}

"-" { yylval.str = new std::string(yytext); return TOKEN_ARITHMATICOP_1;}

"/" { yylval.str = new std::string(yytext); return TOKEN_ARITHMATICOP_2;}

"*" { yylval.str = new std::string(yytext); return TOKEN_ARITHMATICOP_2;}

"%" { yylval.str = new std::string(yytext); return TOKEN_ARITHMATICOP_2;}

"&&" { yylval.str = new std::string(yytext); return TOKEN_CONDITIONOP;}

"||" { yylval.str = new std::string(yytext); return TOKEN_CONDITIONOP;}

"=<" { yylval.str = new std::string(yytext); return TOKEN_RELATIONOP;}

"<" { yylval.str = new std::string(yytext); return TOKEN_RELATIONOP;}

">" { yylval.str = new std::string(yytext); return TOKEN_RELATIONOP;}

"=" { yylval.str = new std::string(yytext); return TOKEN_ASSIGNOP;}

"+=" { yylval.str = new std::string(yytext); return TOKEN_ASSIGNOP;}

"-=" { yylval.str = new std::string(yytext); return TOKEN_ASSIGNOP;}

"!" { yylval.str = new std::string(yytext); return TOKEN_LOGICOP;}

"=>" { yylval.str = new std::string(yytext); return TOKEN_RELATIONOP;}

"==" { yylval.str = new std::string(yytext); return TOKEN_RELATIONOP;}

"!=" { yylval.str = new std::string(yytext); return TOKEN_RELATIONOP;}

"(" { return TOKEN_LP;}

")" { return TOKEN_RP;}

"{" { return TOKEN_LCB;}

"}" { return TOKEN_RCB;}
					

"[" { return TOKEN_LB;}

"]" { return TOKEN_RB;}
					
";" { return TOKEN_SEMICOLON;}

"," { return TOKEN_COMMA;}

\"([^\\\"\']|\\[\\\'\"abfnrtv])*\" { return TOKEN_STRINGCONST;}

\'([^\\\']|\\[abfnrtv\\\"\'])\' { return TOKEN_CHARCONST;}

[A-Za-z_][A-Za-z0-9_]* { yylval.str = new std::string(yytext); return TOKEN_ID;}

[0-9!@$%^&]+[a-zA-Z|_|-]+   {
	std::cout <<"[" << line << "]ERROR: Wrong id definition " << yytext << std::endl;
}

\'([^\\\']|\\[abfnrtv\\\"\']){2,}\' {
	std::cout << "[" << line << "]ERROR: Invalid char constant " << yytext << std::endl;
}

. { }

%%




