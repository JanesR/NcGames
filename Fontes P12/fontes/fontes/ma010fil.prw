#include "rwmake.ch"

User Function MA010FIL
/*
Ponto de entrada para validar Nome do usu�rio para poder visualizar todos os produtos ou somente os n�o bloqueados para venda  
Para adicionar novos usu�rios no par�metro, adicionar o nome no par�metro MV_BLQPROD separado por /
*/

cFiltro := ""
aArea    := GetArea()

If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_BLQPROD")))
	cFiltro := "SB1->B1_BLQVEND <> '1'"
endif


RestArea(aArea)
Return cFiltro 