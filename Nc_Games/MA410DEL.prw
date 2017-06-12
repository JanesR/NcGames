

//Executado em conjunto com o PE M410ALOK
User Function MA410DEL()
	
	//REALIZA A EXCLUSÃO DOS REGISTROS DA P0A
	DBSelectArea("P0A")
	If len(_aRecnoC5) > 1  
	
		For nI:= 1 to len(_aRecnoC5)
		
			P0A->(DBGoTO(_aRecnoC5[nI]))
			IF RecLock("P0A",.F.)
				P0A->(DBDelete())	
				P0A->(MsUnlock())
			EndIF 
			
		Next nI
	EndIF
	
	//REALIZA A ATUALIZAÇÃO DO STATUS DA TABELA DE CANCELAMENTO
	If !Empty(_clQueryC5)
		If TcSqlExec(_clQueryC5) >= 0
			llRet := .T.
			TcSqlExec("COMMIT")
		Else
			llRet := .F.
			Aviso("ERRO",TCSQLError() + " - " + _clQueryC5, {"Ok"})	
		EndIf
	EndIf
		
Return()
