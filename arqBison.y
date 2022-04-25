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
%token <s> NOME
%token <s> CONTEUDO
%token <s> CLASSE
%token <s> PACOTE
%token <s> AUTOR
%token EOL

%type <a> exp factor term

%%
documentoLatex: configuracao identificacao principal
;

configuracao: CLASSE PACOTE
| CLASSE
;

identificacao: TITULO AUTOR
| TITULO
;

principal: inicio corpoLista fim
;

inicio: \begin{document}
;

fim: \end{document}
;

corpoLista: capitulo secao subsecao corpoLista
| corpo
;

capitulo: \chapter{NOME} corpo capitulo
| corpo
;

secao: \section{NOME} corpo secao
| corpo
;

subsecao: \subsection{NOME} corpo subsecao
| corpo
;

corpo: texto
| texto corpo
| textoEstilo corpo
| listas corpo
;

texto: \paragraph{CONTEUDO}
;

textoEstilo: \bf{CONTEUDO}
| \underline{CONTEUDO}
| \it{CONTEUDO}
;

listas: listaNumerada
| listaItens
;

listaNumerada: \begin{enumerate} itensLNumerada \end{enumerate}
;

itensLNumerada: \item{CONTEUDO}
| \item{CONTEUDO} itensLNumerada
| listas
;

listaItens: \begin{itemize} itensLItens \end{itemize}
;

itensLItens: \item{CONTEUDO}
| \item{CONTEUDO} itensLItens
| listas
;

%%