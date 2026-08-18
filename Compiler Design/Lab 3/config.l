%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.tab.h"

int tok_line = 1;        /* line number of the token just returned  */
static int last_was_nl = 1;  /* did the previous token end a line?  */

/* remove leading/trailing blanks from a value string */
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
/* start condition VAL: everything after '=' is read as one raw value */
%x VAL

ID      [A-Za-z_][A-Za-z0-9_.\-]*

%%

[ \t\r]+                 { /* skip blanks */ }
("#"|";")[^\n]*          { /* skip comment lines */ }

\n                       { tok_line = yylineno - 1; last_was_nl = 1; return NEWLINE; }

"["                      { tok_line = yylineno; last_was_nl = 0; return LBRACKET; }
"]"                      { tok_line = yylineno; last_was_nl = 0; return RBRACKET; }
"="                      { tok_line = yylineno; last_was_nl = 0; BEGIN(VAL); return EQUALS; }

{ID}                     { tok_line = yylineno; last_was_nl = 0;
                           yylval.str = strdup(yytext); return IDENT; }

.                        { tok_line = yylineno; last_was_nl = 0;
                           return JUNK; }        /* illegal char -> syntax error */

<VAL>[^\n]+              { char *v = trim(yytext);
                           BEGIN(INITIAL);
                           if (*v == '\0') break;      /* "key=" -> value missing */
                           tok_line = yylineno; last_was_nl = 0;
                           yylval.str = strdup(v); return VALUE; }

<VAL>\n                  { BEGIN(INITIAL);
                           tok_line = yylineno - 1; last_was_nl = 1; return NEWLINE; }

<<EOF>>                  { if (!last_was_nl) {        /* file without final newline */
                               last_was_nl = 1;
                               tok_line = yylineno;
                               return NEWLINE;
                           }
                           yyterminate(); }

%%
