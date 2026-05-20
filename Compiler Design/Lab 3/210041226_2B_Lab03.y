%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex();
%}

%union {
    double dval;
}

%token <dval> NUMBER
%type  <dval> expr term factor primary

%%

input:
      input line
    |
    ;

line:
      '\n'
    | expr '\n'
        {
            printf("Result = %g\n", $1);
        }
    ;

expr:
      expr '+' term
        {
            $$ = $1 + $3;
        }
    | expr '-' term
        {
            $$ = $1 - $3;
        }
    | term
        {
            $$ = $1;
        }
    ;

term:
      term '*' factor
        {
            $$ = $1 * $3;
        }
    | term '/' factor
        {
            if ($3 == 0) {
                yyerror("Division by zero");
                $$ = 0;
            } else {
                $$ = $1 / $3;
            }
        }
    | factor
        {
            $$ = $1;
        }
    ;

factor:
      factor '^' primary
        {
            $$ = pow($1, $3);
        }
    | primary
        {
            $$ = $1;
        }
    ;

primary:
      '(' expr ')'
        {
            $$ = $2;
        }
    | '-' primary
        {
            $$ = -$2;
        }
    | NUMBER
        {
            $$ = $1;
        }
    ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error\n");
}

int main()
{
    printf("Enter Expression:\n");
    yyparse();
    return 0;
}
