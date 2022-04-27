%option noinput nounput
%option noyywrap
%{
#include "arqBison.tab.h"
#include <stdio.h>
#include <string.h>
int num;

%}


word [a-zA-Z0-9]+
simbolo [" "|","|"."|":"|";"]

%%

"{"                     {printf(" %s ", yytext); return yytext[0]; }
"}"                     {printf(" %s ", yytext); return yytext[0]; }
"\\usepackage{NOME}" 	{printf(" %s ", yytext); return PACOTE; }
"\\documentclass{report}" 		{printf(" %s ", yytext); return CLASSE; }
"\\title" 				{printf(" %s ", yytext); return TITULO; }
"\\author" 				{printf(" %s ", yytext); return AUTOR; }
"\\begin{document}" 	{printf(" %s ", yytext); return DOCINI; }
"\\end{document}"  		{printf(" %s ", yytext); return DOCFIM; }
"\\chapter"		  		{printf(" %s ", yytext); return CAPITULO; }
"\\section"		  		{printf(" %s ", yytext); return SECAO; }
"\\subsection"		  	{printf(" %s ", yytext); return SUBSECAO; }
"\\paragraph" 			{printf(" %s ", yytext); return PARAGRAFO; }
"\\begin{enumerate}"    {printf(" %s ", yytext); num = 1; return LISTANUMINI; }
"\\end{enumerate}"      {printf(" %s ", yytext); num = 2; return LISTANUMFIM; }
"\\item" 				{printf(" %s ", yytext); if(num == 1) return(LNUMITENS); else return(LITENS); }
"\\begin{itemsize}"     {printf(" %s ", yytext); num = 0; return LITENSINI; }
"\\end{itemsize}"		{printf(" %s ", yytext); num = 2; return LITENSFIM; }
"\\bf"					{printf(" %s ", yytext); return BOLDFACE; }
"\\it"					{printf(" %s ", yytext); return ITALICS; }
"\\underline"			{printf(" %s ", yytext); return UNDERLINE; }

({word}|{simbolo})+	    {printf(" aga %s ", yytext);;yylval.arr = strdup(yytext); return WORD;}
\n {}
[ \t] {}


%%