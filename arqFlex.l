%option noyywrap nodefault yylineno
%{
    #include<string.h>
    int linhas = 0, qtdTags = 0;
%}

TAG         \<(.)*\>
WHITESPACE  [\ \t]
LINHA       [\n]
lett1       [a-z]+
lett2       [A-Z]+
word        [A-Z][a-z]+

%%

"\\title{"(.)*/"}" { 
    printf("aaaaaa: %.*s\n", strlen(yytext)-7, yytext+7);
    char subtext[255];
    memcpy(subtext,&yytext[7],strlen(yytext)-6);
    return TITULO;
    }
"\\author{"(.)*/"}" {  }
{TAG}        { qtdTags++; printf("Tag: %s\n", yytext); }
{LINHA}      { linhas++; }
{WHITESPACE} ;
.            ;

%%
int main( int nArgs, char* szArgs[] ){
    yylex();
    return 0;
}