%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

extern FILE *yyin;
extern char *yytext;

FILE *out;

int yylex(void);
void yyerror(const char *s);

typedef struct Symbol
{
    char name[50];
    double value;
    int type;
    struct Symbol *next;
} Symbol;

Symbol *head = NULL;

Symbol* createSymbol(char *name, double value, int type)
{
    Symbol *n = (Symbol*)malloc(sizeof(Symbol));
    strcpy(n->name, name);
    n->value = value;
    n->type = type;
    n->next = NULL;
    return n;
}

Symbol* findSymbol(char *name)
{
    Symbol *t = head;
    while (t)
    {
        if (strcmp(t->name, name) == 0)
            return t;
        t = t->next;
    }
    return NULL;
}

void setSymbol(char *name, double value)
{
    Symbol *s = findSymbol(name);
    int type = (floor(value) == value) ? 0 : 1;

    if (!s)
    {
        Symbol *n = createSymbol(name, value, type);
        n->next = head;
        head = n;
    }
    else
    {
        s->value = value;
        s->type = type;
    }
}

double getSymbolValue(char *name, int *found)
{
    Symbol *s = findSymbol(name);
    if (!s)
    {
        *found = 0;
        return 0;
    }
    *found = 1;
    return s->value;
}

void saveSymbols()
{
    FILE *fp = fopen("symbols.txt", "w");
    Symbol *t = head;
    while (t)
    {
        fprintf(fp, "%s %lf %d\n", t->name, t->value, t->type);
        t = t->next;
    }
    fclose(fp);
}

void loadSymbols()
{
    FILE *fp = fopen("symbols.txt", "r");
    if (!fp) return;

    char name[50];
    double value;
    int type;

    while (fscanf(fp, "%s %lf %d", name, &value, &type) == 3)
    {
        Symbol *n = createSymbol(name, value, type);
        n->next = head;
        head = n;
    }

    fclose(fp);
}
%}

%union {
    double dval;
    char *sval;
}

%token <dval> INTEGER DOUBLE
%token <sval> IDENTIFIER

%type <dval> expr term factor primary

%left '+' '-'
%left '*' '/'
%right '^'
%right UMINUS

%%

input:
        input line
    |
    ;

line:
        '\n'
    | statement '\n'
    | statement ';'
    | statement
    ;

statement:
        IDENTIFIER '=' expr
            {
                setSymbol($1, $3);
                fprintf(out, "%s = %g\n", $1, $3);
            }
    | expr
            {
                fprintf(out, "Result = %g\n", $1);
            }
    ;

expr:
    expr '+' term    { $$ = $1 + $3; }
    | expr '-' term  { $$ = $1 - $3; }
    | term           { $$ = $1; }
    ;

term:
    term '*' factor { $$ = $1 * $3; }
    | term '/' factor
        {
            if ($3 == 0)
            {
                fprintf(out, "Division by zero\n");
                $$ = 0;
            }
            else $$ = $1 / $3;
        }
    | factor { $$ = $1; }
    ;

factor:
    primary '^' factor { $$ = pow($1, $3); }
    | primary { $$ = $1; }
    ;

primary:
    '(' expr ')' { $$ = $2; }
    | INTEGER { $$ = $1; }
    | DOUBLE { $$ = $1; }
    | IDENTIFIER
        {
            int f;
            $$ = getSymbolValue($1, &f);
            if (!f)
            {
                fprintf(out, "Warning: %s not defined\n", $1);
                $$ = 0;
            }
        }
    ;

%%

void yyerror(const char *s)
{
    fprintf(out, "Syntax Error: %s near %s\n", s, yytext);
}

int main()
{
    FILE *fp = fopen("input.txt", "r");
    out = fopen("output.txt", "w");

    if (!fp || !out)
        return 1;

    yyin = fp;

    loadSymbols();
    yyparse();
    saveSymbols();

    fclose(fp);
    fclose(out);
    return 0;
}
