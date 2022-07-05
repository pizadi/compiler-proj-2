/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_ANALYZER_TAB_H_INCLUDED
# define YY_YY_ANALYZER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOKEN_COMMENT = 258,
    TOKEN_HEX = 259,
    TOKEN_WHITESPACE = 260,
    TOKEN_BOOLEANTYPE = 261,
    TOKEN_BREAKSTMT = 262,
    TOKEN_CALLOUT = 263,
    TOKEN_CLASS = 264,
    TOKEN_CONTINUESTMT = 265,
    TOKEN_INTTYPE = 266,
    TOKEN_STRINGTYPE = 267,
    TOKEN_CHARTYPE = 268,
    TOKEN_VOIDTYPE = 269,
    TOKEN_MAINFUNC = 270,
    TOKEN_LOOP = 271,
    TOKEN_RETURN = 272,
    TOKEN_IFCONDITION = 273,
    TOKEN_ELSECONDITION = 274,
    TOKEN_BOOLEANCONST = 275,
    TOKEN_PROGRAMCLASS = 276,
    TOKEN_DECIMALCONST = 277,
    TOKEN_ARITHMATICOP_1 = 278,
    TOKEN_ARITHMATICOP_2 = 279,
    TOKEN_CONDITIONOP = 280,
    TOKEN_RELATIONOP = 281,
    TOKEN_ASSIGNOP = 282,
    TOKEN_LOGICOP = 283,
    TOKEN_LP = 284,
    TOKEN_RP = 285,
    TOKEN_LCB = 286,
    TOKEN_RCB = 287,
    TOKEN_LB = 288,
    TOKEN_RB = 289,
    TOKEN_SEMICOLON = 290,
    TOKEN_COMMA = 291,
    TOKEN_STRINGCONST = 292,
    TOKEN_CHARCONST = 293,
    TOKEN_ID = 294
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 16 "analyzer.y"

	char * str;
	int ival;

#line 102 "analyzer.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_ANALYZER_TAB_H_INCLUDED  */
