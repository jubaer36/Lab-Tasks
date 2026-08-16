%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
extern FILE *yyin;
extern int yylineno;

FILE *out;
int tempCount = 0;

char* newTemp()
{
    char *buf = malloc(16);
    sprintf(buf, "T%d", ++tempCount);
    return buf;
}

void emit(const char *op, const char *dest, const char *op1, const char *op2)
{
    fprintf(out, "%s %s, %s, %s\n", op, dest, op1, op2);
}
%}

%union {
    char *sval;
}

%token <sval> ID NUMBER
%type  <sval> Expr Term Factor

%left '+' '-'
%left '*' '/' '%'

%%

Program:
      StmtList
    ;

StmtList:
      StmtList Stmt
    | Stmt
    ;

Stmt:
      ID '=' Expr ';'
        {
            fprintf(out, "MOV %s, %s\n", $1, $3);
        }
    ;

Expr:
      Expr '+' Term  { $$ = newTemp(); emit("ADD", $$, $1, $3); }
    | Expr '-' Term  { $$ = newTemp(); emit("SUB", $$, $1, $3); }
    | Term           { $$ = $1; }
    ;

Term:
      Term '*' Factor { $$ = newTemp(); emit("MUL", $$, $1, $3); }
    | Term '/' Factor { $$ = newTemp(); emit("DIV", $$, $1, $3); }
    | Term '%' Factor { $$ = newTemp(); emit("MOD", $$, $1, $3); }
    | Factor           { $$ = $1; }
    ;

Factor:
      '(' Expr ')' { $$ = $2; }
    | ID           { $$ = $1; }
    | NUMBER       { $$ = $1; }
    ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main(int argc, char **argv)
{
    FILE *fp = fopen(argc > 1 ? argv[1] : "input.txt", "r");
    out = fopen("output.txt", "w");

    if (!fp || !out)
    {
        fprintf(stderr, "Error: could not open input/output file.\n");
        return 1;
    }

    yyin = fp;
    yyparse();

    fclose(fp);
    fclose(out);
    return 0;
}
