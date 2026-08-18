%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
#include "config.tab.h"
%}

int line = 1;



%option noyywrap

%%

[ \t\r]+                ;
\n                       ;

[0-9]+ {
    yylval.sval = strdup(yytext);
    return NUMBER;
}

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.sval = strdup(yytext);
    return ID;
}

"+"     return '+';
"-"     return '-';
"*"     return '*';
"/"     return '/';
"%"     return '%';
"="     return '=';
";"     return ';';
"("     return '(';
")"     return ')';

.       return yytext[0];

%%
