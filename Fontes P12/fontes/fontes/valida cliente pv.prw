#include "protheus.ch"

// FUNCIONA COM A VALIDACAO DE USUARIO X3_VLDUSER == U_VALCLI() NOS CAMPOS:
// - C5_CLIENTE
// - C5_TIPOCLI
// - C5_LOJACLI

Function u_ValCli(COPIA)
Local aAreaAtu:=GetArea()
Local aAreaSA1:=SA1->(GetArea())

lRet 	:= .T.
nLin	:= 0

FOR F:= 1 TO LEN(ACOLS)
	//IF 	!aCOLS[F][Len(aHeader)+1]  //GDDELETED
		nLin ++
	//ENDIF
NEXT F

// tratamento para inclusao (primeira linha em branco)
IF LEN(ACOLS) == 1 .AND. EMPTY(ACOLS[1,2]) //.AND. INCLUI
	nLin	:= 0
ENDIF

IF nLin > 0
	IF ALLTRIM(COPIA) == "1"
		LRET := .T.
	ELSE
		ALERT("Nao permitido alterar CLIENTE ou TIPO CLIENTE apos a digitacao ou importacao de itens")
		lRet 	:= .F.
	ENDIF
ENDIF



RestArea(aAreaSA1)
RestArea(aAreaAtu)
Return lRet
