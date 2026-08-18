%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.tab.h"

int token_line = 1;      
static int last_line = 1;  


static char *trim(char *s)
{
    char *end;
    while (*s == ' ' || *s == '\t' || *s == '\r') s++;
    end = s + strlen(s) - 1;
    while (end >= s && (*end == ' ' || *end == '\t' || *end == '\r')) *end-- = '\0';
    return s;
}
%}

%option noyywrap
%option yylineno

%x VAL

ID      [A-Za-z_][A-Za-z0-9_.\-]*

%%

[ \t\r]+                 { }

\n                       { token_line = yylineno - 1; last_line = 1; return NEWLINE; }

"["                      { token_line = yylineno; last_line = 0; return LBRACKET; }
"]"                      { token_line = yylineno; last_line = 0; return RBRACKET; }
"="                      { token_line = yylineno; last_line = 0; BEGIN(VAL); return EQUALS; }

{ID}                     { token_line = yylineno; last_line = 0;
                           yylval.str = strdup(yytext); return IDENT; }

.                        { token_line = yylineno; last_line = 0;
                           return JUNK; }       

<VAL>[^\n]+              { char *v = trim(yytext);
                           BEGIN(INITIAL);
                           if (*v == '\0') break;     
                           token_line = yylineno; last_line = 0;
                           yylval.str = strdup(v); return VALUE; }

<VAL>\n                  { BEGIN(INITIAL);
                           token_line = yylineno - 1; last_line = 1; return NEWLINE; }

<<EOF>>                  { if (!last_line) {       
                               last_line = 1;
                               token_line = yylineno;
                               return NEWLINE;
                           }
                           yyterminate(); }

%%
