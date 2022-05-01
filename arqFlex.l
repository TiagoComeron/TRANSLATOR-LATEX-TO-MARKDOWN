%option noinput nounput noyywrap
%{
#include "arqBison.tab.h"
#include <stdio.h>
#include <string.h>
int num = 0;
int auxList = 0;
%}

word [a-zA-Z0-9]+
simbol [" "|","|"."|":"|";"]

%%

"{"                         {printf(" %s ", yytext); return yytext[0]; }
"}"                         {printf(" %s ", yytext); return yytext[0]; }
"\\usepackage{NOME}" 	    {printf(" %s ", yytext); return PACKAGE; }
"\\documentclass{report}" 	{printf(" %s ", yytext); return CLASS; }
"\\title" 				    {printf(" %s ", yytext); return TITLE; }
"\\author" 				    {printf(" %s ", yytext); return AUTHOR; }
"\\begin{document}" 	    {printf(" %s ", yytext); return BEGINNING; }
"\\end{document}"  		    {printf(" %s ", yytext); return END; }
"\\chapter"		  		    {printf(" %s ", yytext); return CHAPTER; }
"\\section"		  		    {printf(" %s ", yytext); return SECTION; }
"\\subsection"		  	    {printf(" %s ", yytext); return SUBSECTION; }
"\\paragraph" 			    {printf(" %s ", yytext); return PARAGRAPH; }
"\\begin{enumerate}"        {printf(" %s ", yytext); num = 1; auxList++; return BEGNUMLIST; }
"\\end{enumerate}"          {printf(" %s ", yytext); num = 2; auxList--; return ENDNUMLIST; }
"\\begin{itemsize}"         {printf(" %s ", yytext); num = 3; auxList++; return BEGITEMSL; }
"\\end{itemsize}"		    {printf(" %s ", yytext); num = 4; auxList--; return ENDITEMSL; }
"\\item" { printf(" %s ", yytext); 
        if(num <= 2){
            if(auxList > 1) return(ITEMLISTIN);
            else return(ITEMSNUMEREDLIST); 
        } 
        else{
            if(auxList > 1) return(ITEMLISTIN);
            else return(ITEMSL); 
        }
    }
"\\bf"					    {printf(" %s ", yytext); return BOLDFACE; }
"\\it"					    {printf(" %s ", yytext); return ITALICS; }
"\\underline"			    {printf(" %s ", yytext); return UNDERLINE; }
({word}|{simbol})+	    {printf(" palavra %s ", yytext);;yylval.arr = strdup(yytext); return WORD;}
\n {}
[ \t] {}

%%