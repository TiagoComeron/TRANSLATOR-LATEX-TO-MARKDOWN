all: msgola	arqBison.exe arqFlex.exe lex.yy.exe gcc.exe
	@echo	Fechando o programa 
msgola: 
	@echo	---------------------------------------------------------------
	@echo	Trabalho 1 Compiladores - LATEX to Markdown
	@echo	---------------------------------------------------------------
arqBison.exe: arqBison.y
	bison	-d	arqBison.y
	@echo	Flex compilado
	@echo	------------------------------------------------------------------
arqFlex.exe: arqFlex.l
	flex	arqFlex.l
	@echo	Flex compilado
	@echo	------------------------------------------------------------------
lex.yy.exe: lex.yy.c
	gcc	lex.yy.c
	@echo	Flex C compilado
	@echo	------------------------------------------------------------------