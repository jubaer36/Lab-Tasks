%{
/* config.y - Syntax validator for INI configuration files */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SEC   64
#define MAX_KEY   64
#define NAME_LEN  64

typedef struct {
    char name[NAME_LEN];
    int  line;
    char key[MAX_KEY][NAME_LEN];
    char val[MAX_KEY][128];
    int  nkeys;
} Section;

static Section sec[MAX_SEC];
static int nsec = 0;         /* number of sections seen        */
static int cur  = -1;        /* index of the section being read */
static int errors = 0;
static int stmt_line = 1;    /* line where the current statement starts */

extern int  yylex(void);
extern int  yylineno;
extern int  tok_line;
extern FILE *yyin;
void yyerror(const char *msg);

/* ---- semantic helpers -------------------------------------------------- */

static const char *type_of(const char *v)
{
    const char *p = v;
    int digits = 0, dots = 0;

    if (!strcasecmp(v, "true") || !strcasecmp(v, "false") ||
        !strcasecmp(v, "yes")  || !strcasecmp(v, "no")    ||
        !strcasecmp(v, "on")   || !strcasecmp(v, "off"))
        return "BOOLEAN";

    if (*p == '+' || *p == '-') p++;
    for (; *p; p++) {
        if (*p >= '0' && *p <= '9') digits++;
        else if (*p == '.')         dots++;
        else                        return "STRING";
    }
    if (digits == 0)  return "STRING";
    if (dots == 0)    return "INTEGER";
    if (dots == 1)    return "FLOAT";
    return "STRING";
}

static void semantic_error(int line, const char *fmt, const char *a)
{
    fprintf(stderr, "Line %d: semantic error: ", line);
    fprintf(stderr, fmt, a);
    fprintf(stderr, "\n");
    errors++;
}

static void new_section(const char *name, int line)
{
    int i;
    for (i = 0; i < nsec; i++)
        if (!strcmp(sec[i].name, name)) {
            semantic_error(line, "duplicate section [%s] "
                                 "(already defined earlier)", name);
            cur = i;                 /* keep going: merge into the old one */
            return;
        }
    if (nsec == MAX_SEC) {
        semantic_error(line, "too many sections at [%s]", name);
        return;
    }
    strncpy(sec[nsec].name, name, NAME_LEN - 1);
    sec[nsec].line  = line;
    sec[nsec].nkeys = 0;
    cur = nsec++;
}

static void new_key(const char *key, const char *value, int line)
{
    int i;
    if (cur < 0) {
        semantic_error(line, "key '%s' appears before any [section] header", key);
        return;
    }
    for (i = 0; i < sec[cur].nkeys; i++)
        if (!strcmp(sec[cur].key[i], key)) {
            fprintf(stderr, "Line %d: semantic error: duplicate key '%s' "
                            "in section [%s]\n", line, key, sec[cur].name);
            errors++;
            return;
        }
    if (sec[cur].nkeys == MAX_KEY) {
        semantic_error(line, "too many keys at '%s'", key);
        return;
    }
    i = sec[cur].nkeys++;
    strncpy(sec[cur].key[i], key,   NAME_LEN - 1);
    strncpy(sec[cur].val[i], value, 127);
}
%}

%define parse.error verbose

%union {
    char *str;
}

%token <str> IDENT    "identifier"
%token <str> VALUE    "value"
%token       LBRACKET "["
%token       RBRACKET "]"
%token       EQUALS   "="
%token       NEWLINE  "end of line"
%token       JUNK     "illegal character"

%%

file
    : /* empty */
    | file line
    ;

line
    : NEWLINE                                   /* blank line */
    | section
    | pair
    | error NEWLINE      { yyerrok; }           /* skip the bad line, keep going */
    ;

section
    : LBRACKET { stmt_line = tok_line; } IDENT RBRACKET NEWLINE
      {
          new_section($3, stmt_line);
          free($3);
      }
    ;

pair
    : IDENT { stmt_line = tok_line; } EQUALS VALUE NEWLINE
      {
          new_key($1, $4, stmt_line);
          printf("  %-12s = %-18s (%s)\n", $1, $4, type_of($4));
          free($1); free($4);
      }
    ;

%%

void yyerror(const char *msg)
{
    fprintf(stderr, "Line %d: %s\n", tok_line, msg);
    errors++;
}

int main(int argc, char **argv)
{
    int i, j;

    setvbuf(stdout, NULL, _IONBF, 0);   /* keep errors and output in order */

    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) { perror(argv[1]); return 2; }
    }

    printf("=== Parsing entries ===\n");
    yyparse();

    printf("\n=== Symbol table ===\n");
    for (i = 0; i < nsec; i++) {
        printf("[%s]  (line %d, %d keys)\n", sec[i].name, sec[i].line, sec[i].nkeys);
        for (j = 0; j < sec[i].nkeys; j++)
            printf("    %-12s = %-18s %s\n",
                   sec[i].key[j], sec[i].val[j], type_of(sec[i].val[j]));
    }

    printf("\n=== Result ===\n");
    if (errors == 0)
        printf("Valid configuration file: %d section(s), no errors.\n", nsec);
    else
        printf("Invalid configuration file: %d error(s) found.\n", errors);

    if (yyin && yyin != stdin) fclose(yyin);
    return errors ? 1 : 0;
}
