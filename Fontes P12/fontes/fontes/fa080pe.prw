#include "rwmake.ch"

User Function fa080pe()

Local cPrefixo := SE2->E2_PREFIXO
Local nNum    	:= SE2->E2_NUM
Local cF6num	:= ALLTRIM(SE2->E2_PREFIXO) + ALLTRIM(SE2->E2_NUM)
Local cAutent	:= SPACE(10)
Local cFornece	:= SE2->E2_FORNECE
Local cLoja		:= SE2->E2_LOJA
Local cEst
Local nNumero
Local cFilial	:= SE2->E2_FILORIG


IF SE2->E2_PREFIXO == "ICM"
	
	@ 100,001 To 240,250 Dialog oDlg Title "Autenticação Bancária" 	// 100,001 To 340,350
	@ 003,008 To 065,120											// 003,010 To 110,167
	@ 013,014 Say OemToAnsi("Informe o codigo da Autenticação Bancária")
	@ 025,014 Get cAutent Size C(048),C(008) Picture "@E 999999999"
	@ 045,085 BmpButton Type 01 Action Close(oDlg)					// @ 097,130
	Activate Dialog oDlg Centered
			
	TcSqlExec("UPDATE SF6010 SET F6_AUTENT = '" +cAutent+ "' WHERE F6_NUMERO = '" +cF6num+ "' AND F6_FILIAL = '" +SE2->E2_FILORIG+ "' ")
	TCSQLEXEC("COMMIT")
	
ELSE
	
	RETURN()
	
ENDIF

RETURN()