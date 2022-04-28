all: msgola	arqBison.exe arqFlex.exe lex.yy.exe gcc.exe
	@echo	Fechando o programa 
msgola: 
	@echo	---------------------------------------------------------------
	@echo	Trabalho 1 Compiladores - LATEX to Markdown
	@echo	---------------------------------------------------------------
arqBison.exe: arqBison.y
	bison	-d	arqBison.y
	@echo	Bison compilado
	@echo	------------------------------------------------------------------
arqFlex.exe: arqFlex.l
	flex	arqFlex.l
	@echo	Flex compilado
	@echo	------------------------------------------------------------------
lex.yy.exe: lex.yy.c
	gcc	arqBison.tab.c lex.yy.c
	@echo	C compilado
	@echo	------------------------------------------------------------------