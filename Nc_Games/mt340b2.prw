#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

Static lExecutado:=.F.

User Function MT340B2()         
Local lExecLog:=IsIncallStack("A003Exec") .Or. IsIncallStack("A004Exec")

If lExecLog .And. !lExecutado

	If IsIncallStack("A003Exec")
		U_A003LOG()                                
	Else
		U_A004LOG()
	EndIf	           
		
	lExecutado:=.T.
EndIf


/*Private _aArea := GetArea()

_cQUERY := " SELECT B2_COD CODPRO FROM SB2010 "   // SEQUENCIAINTEGRACAO
_cQUERY += " WHERE B2_DTINV <> ' ' AND D_E_L_E_T_<>'*' "
_cQuery := ChangeQuery(_cQuery)

If Select("TRB10") > 0
	dbSelectArea("TRB10")
	dbCloseArea()
EndIf

TCQUERY _cQuery New Alias "TRB10"

dbSelectArea("TRB10")

WHILE TRB10->(!EOF()) 

	DBSELECTAREA("SB2")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SB2")+ALLTRIM(TRB10->CODPRO))

	RecLock("SB2",.F.)
		SB2->B2_DTINV   := CTOD("  /  /    ")
		SB2->B2_DINVFIM := CTOD("  /  /    ")
		SB2->B2_DINVENT := CTOD("  /  /    ")
	MsUnLock()
	
	TRB10->(DBSKIP())

ENDDO

RestArea(_aArea)*/
Return