%{
# include <stdio.h>
# include <stdlib.h>

int yydebug = 1;
FILE *archivef;
int yylex();
void yyerror(const char *s);

%}

%union {
    char*	arr;
}

/* declaracao de tokens */
%token <s> NAME
%token <s> TITLE
%token <s> CLASS
%token <s> PACKAGE
%token <s> AUTHOR
%token <s> BEGINNING
%token <s> END
%token <s> CHAPTER
%token <s> SECTION
%token <s> SUBSECTION
%token <s> PARAGRAPH
%token <s> BEGNUMLIST
%token <s> ENDNUMLIST
%token <s> ITEMSNUMEREDLIST
%token <s> ITEMSL
%token <s> BEGITEMSL
%token <s> ENDITEMSL
%token <s> BOLDFACE
%token <s> ITALICS
%token <s> UNDERLINE
%token <s> ITEMLISTIN
%token <arr> WORD
%token EOL

%start documentLatex

%%

documentLatex: configuration identification principal
;

configuration: CLASS PACKAGE
| CLASS
;

identification: TITLE {fprintf(archivef,"\n# ");} '{' name '}' AUTHOR {fprintf(archivef,"\n# ");} '{' name '}'
| TITLE {fprintf(archivef,"\n# ");} '{' name '}'
;

principal: beginning listBody end
;

beginning: BEGINNING
;

end: END
;

listBody: chapter section subsection listBody
| body
;

chapter: CHAPTER {fprintf(archivef,"\n## ");} '{' name '}' body chapter
| CHAPTER {fprintf(archivef,"\n## ");} '{' name '}'
| body
;

section: SECTION {fprintf(archivef,"\n### ");} '{' name '}' body section
| body
;

subsection: SUBSECTION {fprintf(archivef,"\n#### ");} '{' name '}' body subsection
| body
;

body: text
| text body
| textStyle body
| lists body
|
;

text: PARAGRAPH {fprintf(archivef,"\n\n");} '{' name '}'
;

textStyle: BOLDFACE {fprintf(archivef,"\n**");} '{' name '}' {fprintf(archivef,"**");}
| UNDERLINE {fprintf(archivef,"\n");} '{' name '}'
| ITALICS {fprintf(archivef,"\n_");} '{' name '}' {fprintf(archivef,"_");}
;

lists: numeredList
| itemsList
;

numeredList: BEGNUMLIST itemsNumeredList ENDNUMLIST
;

itemsNumeredList: ITEMSNUMEREDLIST {fprintf(archivef,"\n1. ");} '{' name '}' itemsNumeredList itemsNumeredList
| ITEMSNUMEREDLIST {fprintf(archivef,"\n1. ");} '{' name '}'
| ITEMLISTIN {fprintf(archivef,"\n\t1. ");} '{' name '}' itemsNumeredList
| ITEMLISTIN {fprintf(archivef,"\n\t1. ");} '{' name '}'
|
| lists
;

itemsList: BEGITEMSL itemsLItems ENDITEMSL
;

itemsLItems: ITEMSL {fprintf(archivef,"\n* ");} '{' name '}' itemsLItems itemsLItems
| ITEMSL {fprintf(archivef,"\n* ");} '{' name '}' 
| ITEMLISTIN {fprintf(archivef,"\n\t* ");} '{' name '}' itemsLItems
| ITEMLISTIN {fprintf(archivef,"\n\t* ");} '{' name '}'
|
| lists
;

name	:	WORD {fprintf(archivef,"%s",$1); }

%%

extern FILE *yyin;

int main(int argc, char *argv[]){
	yydebug=1;
  archivef = fopen("result.md","w+");
  if(argc>1)
{
  FILE *file;
  file=fopen(argv[1],"r");
  if(!file)
  {
    fprintf(archivef,"ERROR");
  }
  yyin=file;
}
	yyparse();
	}

void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }