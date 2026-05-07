%{
    #include <stdio.h>
    #include <stdlib.h>

    FILE *yyin, *yyout;
    
    int total = 0;
    int keywords = 0;
    int identifiers = 0;
    int int_constants = 0;
    int float_constants = 0;
    int char_constants = 0;
    int string_constants = 0;
    int arithmetic_operators = 0;
    int increment_decrement_operators = 0;
    int relational_operators = 0;
    int logical_operators = 0;
    int bitwise_operators = 0;
    int operators = 0;
    int delimiters = 0;
%}

DIGIT       [0-9]
LETTER      [A-Za-z_]
ID          {LETTER}({LETTER}|{DIGIT})*
INT         {DIGIT}+
FLOAT       {DIGIT}+"."{DIGIT}+
CHAR        \'[^\']\'
STRING      \"[^\",%:=]*\"

%%
"include"|"int"|"float"|"if"|"else"|"print"|"while"|"for"|"return"|"main"|"yyin"|"yyout"|"yylex"|"fopen"|"fclose"|"fprintf" {
    fprintf(yyout, "<KEYWORD, %s>\n", yytext);
    keywords++;
    total++;
}

{FLOAT} {
    fprintf(yyout, "<FLOAT_CONSTANT, %s>\n", yytext);
    float_constants++;
    total++;
}
{INT} {
    fprintf(yyout, "<INTEGER_CONSTANT, %s>\n", yytext);
    int_constants++;
    total++;
}
{CHAR} {
    fprintf(yyout, "<CHARACTER_CONSTANT, %s>\n", yytext);
    char_constants++;
    total++;
}
{STRING} {
    fprintf(yyout, "<STRING_CONSTANT, %s>\n", yytext);
    string_constants++;
    total++;
}
{ID} {
    fprintf(yyout, "<IDENTIFIER, %s>\n", yytext);
    identifiers++;
    total++;

}
"++"|"--" {
    fprintf(yyout, "<INCREMENT_DECREMENT_OPERATOR, %s>\n", yytext);
    increment_decrement_operators++;
    operators++;
    total++;
}
"+"|"-"|"*"|"/"|"=" {
    fprintf(yyout, "<ARITHMETIC_OPERATOR, %s>\n", yytext);
    arithmetic_operators++;
    operators++;
    total++;
}

"=="|"!="|"<="|">="|"<"|">" {
    fprintf(yyout, "<RELATIONAL_OPERATOR, %s>\n", yytext);
    relational_operators++;
    operators++;
    total++;
}
"&&"|"||" {
    fprintf(yyout, "<LOGICAL_OPERATOR, %s>\n", yytext);
    logical_operators++;
    operators++;
    total++;
}
"&"|"|"|"^"|"~"|"<<"|">>" {
    fprintf(yyout, "<BITWISE_OPERATOR, %s>\n", yytext);
    bitwise_operators++;
    operators++;
    total++;
}
"("|")"|"{"|"}"|"["|"]"|";"|","|"%"|"%%" {
    fprintf(yyout, "<DELIMITER, %s>\n", yytext);
    delimiters++;
    total++;
}

[ \t\n]+ {
}

%%
int main(){
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    yylex();

    fprintf(yyout, "\nTotal Tokens: %d\n", total);
    fprintf(yyout, "Keywords: %d\n", keywords);
    fprintf(yyout, "Identifiers: %d\n", identifiers);
    fprintf(yyout, "Total Constants: %d\n", int_constants + float_constants + char_constants + string_constants);
    fprintf(yyout, "Integer Constants: %d\n", int_constants);
    fprintf(yyout, "Float Constants: %d\n", float_constants);
    fprintf(yyout, "Character Constants: %d\n", char_constants);
    fprintf(yyout, "String Constants: %d\n", string_constants);
    fprintf(yyout, "Total Operators: %d\n", operators);
    fprintf(yyout, "Arithmetic Operators: %d\n", arithmetic_operators);
    fprintf(yyout, "Increment/Decrement Operators: %d\n", increment_decrement_operators);
    fprintf(yyout, "Relational Operators: %d\n", relational_operators);
    fprintf(yyout, "Logical Operators: %d\n", logical_operators);
    fprintf(yyout, "Bitwise Operators: %d\n", bitwise_operators);
    fprintf(yyout, "Delimiters: %d\n", delimiters);

    fclose(yyin);
    fclose(yyout);

    return 0;
}