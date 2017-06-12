#include "rwmake.ch"

User Function MA010FIL
/*
Ponto de entrada para validar Nome do usuário para poder visualizar todos os produtos ou somente os não bloqueados para venda  
Para adicionar novos usuários no parâmetro, adicionar o nome no parâmetro MV_BLQPROD separado por /
*/

cFiltro := ""
aArea    := GetArea()

If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_BLQPROD")))
	cFiltro := "SB1->B1_BLQVEND <> '1'"
endif


RestArea(aArea)
Return cFiltro 