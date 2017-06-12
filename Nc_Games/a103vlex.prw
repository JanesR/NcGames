#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"

User Function A103VLEX()

	//REALIZA A EXCLUSÃO DOS REGISTROS DA P0A
	DBSelectArea("P0A")
	If len(_aRecno) > 1  
	
		For nI:= 1 to len(_aRecno)
		
			P0A->(DBGoTO(_aRecno[nI]))
			IF RecLock("P0A",.F.)
				P0A->(DBDelete())	
				P0A->(MsUnlock())
			EndIF 
			
		Next nI
	EndIF
	
	//REALIZA A ATUALIZAÇÃO DO STATUS DA TABELA DE CANCELAMENTO
	If !Empty(_cQuery)
		If TcSqlExec(_cQuery) >= 0
			TcSqlExec("COMMIT")
		Else
			Aviso("ERRO",TCSQLError() + " - " + _cQuery, {"Ok"})	
		EndIf
	EndIf
	
Return()
