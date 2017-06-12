#include "protheus.ch"

// FUNCIONA COM A VALIDACAO DE USUARIO X3_VLDUSER == u_ValidTab() NO CAMPO:
// - C5_TABELA

User Function ValidTab

LOCAL nPosNfOri	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_NFORI'} )
LOCAL nPosItOri	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_ITEMORI'} )
LOCAL nPosSrOri	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_SERIORI'} )

lRet 	:= .T.
nLin	:= 0

FOR F:= 1 TO LEN(ACOLS)
	if !empty(ACOLS[F,nPosNfOri])
		Return .T.
	Endif
		nLin ++
NEXT F

// tratamento para inclusao (primeira linha em branco)
IF LEN(ACOLS) == 1 .AND. EMPTY(ACOLS[1,2]) //.AND. INCLUI
	nLin	:= 0
ENDIF

IF nLin > 0
	ALERT("Nao permitido alterar a Tabela de preços apos a digitacao ou importacao de itens")
	lRet 	:= .F.
ENDIF


Return lRet
