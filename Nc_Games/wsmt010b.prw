#INCLUDE "Protheus.ch"

User Function WSMT010B()

	Local nTipo		:=PARAMIXB[1]
	Local cFiltro	:=""

	cFiltro	:= "B1_BLQVEND <> '1'"
	cFiltro	+= " AND B1_TIPO = 'PA'"
	cFiltro += " AND B1_MSBLQL = '2'"

Return cFiltro