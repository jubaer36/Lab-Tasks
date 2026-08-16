%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
void yyerror(const char *s);

FILE *out;
%}

%union {
    char *sval;
}

%token HTML_OPEN HTML_CLOSE
%token HEAD_OPEN HEAD_CLOSE
%token TITLE_OPEN TITLE_CLOSE
%token BODY_OPEN BODY_CLOSE
%token H1_OPEN H1_CLOSE
%token H2_OPEN H2_CLOSE
%token P_OPEN P_CLOSE
%token DIV_OPEN DIV_CLOSE
%token B_OPEN B_CLOSE
%token I_OPEN I_CLOSE
%token <sval> TEXT_CONTENT

%%

document:
      html_document { fprintf(out, "HTML document is structurally valid.\n"); }
    ;

html_document:
      HTML_OPEN head_section body_section HTML_CLOSE
    ;

head_section:
      HEAD_OPEN title_section HEAD_CLOSE
    ;

title_section:
      TITLE_OPEN TEXT_CONTENT TITLE_CLOSE
    ;

body_section:
      BODY_OPEN content BODY_CLOSE
    ;

content:
      content content_item
    | /* empty */
    ;

content_item:
      TEXT_CONTENT
    | heading
    | paragraph
    | div
    | bold
    | italic
    ;

heading:
      H1_OPEN content H1_CLOSE
    | H2_OPEN content H2_CLOSE
    ;

paragraph:
      P_OPEN content P_CLOSE
    ;

div:
      DIV_OPEN content DIV_CLOSE
    ;

bold:
      B_OPEN content B_CLOSE
    ;

italic:
      I_OPEN content I_CLOSE
    ;

%%

void yyerror(const char *s)
{
    fprintf(out, "Syntax Error: %s near line %d (token: \"%s\").\n", s, yylineno, yytext);
}

int main(int argc, char **argv)
{
    FILE *fp = fopen(argc > 1 ? argv[1] : "input.html", "r");
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
