%{
# include <stdio.h>
# include <stdlib.h>
# include "calcH.h"
%}

%union {
    struct ast *a;
    double d;
}

/* declaracao de tokens */
%token <s> NAME
%token <s> CONTENT
%token <s> CLASS
%token <s> PACKAGE
%token <s> AUTHOR
%token EOL

%type <a> exp factor term

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

itemsNumeredList: ITEMSNUMEREDLIST {fprintf(archivef,"\n1.");}
| ITEMSNUMEREDLIST {fprintf(archivef,"\n1.");} itemsNumeredList
| lists
;

itemsList: BEGITEMSL itemsLItems ENDITEMSL
;

itemsLItems: ITEMSNUMEREDLIST {fprintf(archivef,"\n*.");}
| ITEMSNUMEREDLIST itemsLItems
| lists
;

name	:	WORD {fprintf(archivef,"%s",$1); }

%%