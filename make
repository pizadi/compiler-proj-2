bison -d analyzer.y
flex analyzer.lex
g++ analyzer.tab.c lex.yy.c -o analyzer.out
