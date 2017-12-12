#Include "PROTHEUS.CH "
Static nConectWM:=-12


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF02 �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Efetua a conex�o com o banco de dados, e retorna o nome     ���
���          �do arquivo com a tabela tempor�ria.                  		  ���
���          �Semelhante ao DbUseArea()				               		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF02(cQuery,cTipo,cMensagem)

Local aArea 		:= GetArea()
Local nConecAtual 	:= 0
Local nConection    := 0
Local cAliasQry     := GetNextAlias()//Alias de retorno
Local cConectStr	:= U_MyNewSX6("NC_NBCABWM","","C","Nome do Banco e ambiente. Exemplo:  'MSSQL7/WebManager'","MSSQL/WebManager","",.F. )
Local cServer		:= U_MyNewSX6("NC_IPSRVWM","","C","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.217 ","192.168.0.202","",.F. )
Local nPortConect	:= U_MyNewSX6("NC_PORTWM","","N","Porta de acesso p/ comunica��o com o banco de dados. Exemplo: 7890","","",.F. )

Default cQuery		:= ""       
Default cTipo		:="1"
Default cMensagem :=""
cMensagem:=""

nConecAtual := AdvConnection()

If nConectWM<=0
	nConection:=TcLink(cConectStr ,  cServer , nPortConect  )
	nConectWM:=nConection
Else
	nConection:=nConectWM
EndIf	

If nConection < 0	
	If !IsBlind()
		Aviso("Aten��o","Nao foi poss�vel estabelecer conexao com o banco SQL do WEB MANAGER",{"Ok"},2)
	EndIf	
	cAliasQry := ""
	Return cAliasQry
Else
	TcSetConn( nConection )
EndIf

If cTipo=="1"
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)
ElseIf cTipo=="2"
	If TcSQLExec(cQuery) <> 0
		cMensagem:=TCSQLError()
	EndIf
EndIf

TCSetConn(nConecAtual) // Restaura conexao antiga
RestArea(aArea)
Return cAliasQry


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGetBWM �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna as os dados da conex�o com a tabela informada.      ���
���          �Rotina semelhante ao RetSqlName()                   		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGetBWM(cTabWM)
Local cTabRet		:= ""
Local cInfConect	:= U_MyNewSX6("NC_INFBCWM",;
									"",;
									"C",;
									"Informa��es da conex�o coma base de dados do Web Manager",;
									"Informa��es da conex�o coma base de dados do Web Manager",;
									"Informa��es da conex�o coma base de dados do Web Manager",;
									.F. )
Default cTabWM 		:= ""

If !Empty(cTabWM)//Verifica se o nome da tabela foi preenchido
	cTabRet := AllTrim(cInfConect) + cTabWM	
ElseIf !IsBlind()//Apresenta a mensagem de erro se n�o for Job
	Aviso("Erro","Nome da tabela n�o informado",{"Ok"},2)
EndIf

Return cTabRet
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGEFORI �Autor  �Microsiga           � Data � 07/04/15     ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna a empresa e filial origem de acordo com o CNPJ	  ���
���          �informado												  	  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGEFORI(cCnpj, cLoja)
Local aArea 		:= GetArea()
Local aAreaSM0 		:=SM0->(GetArea())
Local aRet			:= {}
Local aEmpFilAux    := {}

Default cCnpj := ""
Default cLoja := ""

DbSelectArea("ZX5")
DbSetOrder(1)	

DbSelectArea("SM0")
DbSetOrder(1)


If !Empty(cLoja)	

	If ZX5->(MsSeek(xFilial("ZX5")+"00006" + cLoja ) )
	
		aEmpFilAux := Separa(Alltrim(ZX5->ZX5_DESCRI),";")
		If Len(aEmpFilAux) >= 2
			aRet := {aEmpFilAux[1], aEmpFilAux[2], "", "", Posicione("XX8",2,PADR(aEmpFilAux[1], 12 )+aEmpFilAux[2],"XX8_DESCRI") }//[Empresa,Filial,Nome Empresa, Nome Comercial]		                       
		EndIf
	EndIf
	/*Else
		SM0->(DbGoTop())
		While SM0->(!Eof())
			
			If Alltrim(SM0->M0_CGC) == Alltrim(cCnpj)
				aRet := {SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_NOME, SM0->M0_NOMECOM, Posicione("XX8",2,PADR(SM0->M0_CODIGO, 12 )+SM0->M0_CODFIL,"XX8_DESCRI") }//[Empresa,Filial,Nome Empresa, Nome Comercial]
				Exit
			EndIf
			
			SM0->(DbSkip())
		EndDo
	EndIf
Else

	SM0->(DbGoTop())
	While SM0->(!Eof())
		
		If Alltrim(SM0->M0_CGC) == Alltrim(cCnpj)
			aRet := {SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_NOME, SM0->M0_NOMECOM, Posicione("XX8",2,PADR(SM0->M0_CODIGO, 12 )+SM0->M0_CODFIL,"XX8_DESCRI") }//[Empresa,Filial,Nome Empresa, Nome Comercial]
			Exit
		EndIf
		
		SM0->(DbSkip())
	EndDo
	*/
EndIf

RestArea(aAreaSM0)
RestArea(aArea)
Return aRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGCNPJSP �Autor  �Microsiga           � Data � 07/04/15    ���
�������������������������������������������������������������������������͹��
���Desc.     �Retira pontua��o do CNPJ									  ���
���          �														  	  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGCNPJSP(cCNPJ)

Local aArea := GetArea()
Local cRet	:= ""

Default cCNPJ := ""

cRet := STRTRAN(cCNPJ,".","")
cRet := STRTRAN(cRet,"/","")
cRet := STRTRAN(cRet,"-","")

RestArea(aArea)
Return cRet             


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIFW2VEND �Autor  �Microsiga 	      � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de vendedor									      ���
���          �															  ���
���		     �														      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                     
User Function NCIFW2VEND(cCodVendWM, cNome, cArm)

Local aArea 	:= GetArea()
Local aRet		:= {,}
Local nX		:= 0
Local cCodVAux	:= ""
Local aCompAux	:= {}
Local cCompCod	:= Alltrim(U_MyNewSX6("NC_CDVENWM",;
										"03UZ|40PX",;
										"C",;
										"Complemento do codigo do vendedor Web Manager",;
										"Complemento do codigo do vendedor Web Manager",;
										"Complemento do codigo do vendedor Web Manager",;
										.F. ))
	

Default cCodVendWM	:= "" 
Default cNome		:= "" 
Default cArm		:= "" 

//Verifica o codigo do vendedor 
aCompAux := Separa(cCompCod, "|")
For nX := 1 To Len(aCompAux)
	If Alltrim(cEmpAnt) $ Alltrim(aCompAux[nX]) 
		cCodVAux := SubStr(Alltrim(aCompAux[nX]),3,4) + StrZero( Val(Alltrim(cCodVendWM)), 4 ) 
		Exit
	EndIf
Next

If !Empty(cCodVAux)
	
	DbSelectArea("SA3")
	DbSetOrder(1)
	If !SA3->(MsSeek(xFilial("SA3") + cCodVAux))
	
		Reclock("SA3",.T.)
		SA3->A3_COD		 := cCodVAux
		SA3->A3_NOME    := cNome               
		SA3->A3_LOCPAD  := cArm
		SA3->(MsUnLock())
		/*aAdd(aVendedor,{"A3_COD"	,cCodVAux							,Nil })
		aAdd(aVendedor,{"A3_NOME"	,Padr(cNome,TamSx3("A3_NOME")[1]) 	,Nil })
		aAdd(aVendedor,{"A3_LOCPAD"	,Padr(cArm,TamSx3("A3_LOCPAD")[1]) 	,Nil })
		
		cMsgProc := RunGerVend(aVendedor, 3)*/		
		
		//aRet := {cCodVAux, cMsgProc}
		aRet := {cCodVAux, ""}
	Else
		aRet := {cCodVAux, ""}
	EndIf
EndIf

RestArea(aArea)
Return aRet                



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunGerTit �Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a gera��o de titulos							      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RunGerVend(aVend, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F. 

Default aVend := {} 
Default nOpc	:= 3//Inclus�o

//Inicio da transa��o
Begin Transaction

//Verifica se os dados foram informados
If (Len(aVend) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| MATA040(x,y)}, aVend, nOpc)

	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa��o
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados n�o informados"
EndIf

//Finalisa a transa��o
End Transaction

RestArea(aArea)
Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldTpTWm �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o do tipo de titulo 								  ���
���          �		  													  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VldTpTWm(cTipoTit)

Local aArea := GetArea()
Local lRet	:= .F. 

Default cTipoTit := ""

DbSelectArea("SX5")
DbSetOrder(1)
If SX5->(DbSeek(xFilial("SX5")+"05"+cTipoTit))
	lRet	:= .T. 
Else
	Aviso("Aten��o","Tipo do titulo n�o encontrado",{"Ok"},2)
EndIf

RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGLogWM �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava o log de processamento da integra��o				  ���
���          �		  													  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGLogWM(cEmpOri, cFilOri, cRotin, cDescRot, cProcess, dDtProcess, cOper )

Local aArea 	:= GetArea()    
Local cModo		:= ""
Local cAliasPZK	:= GetNextAlias()
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))

									

Default cEmpOri		:= "" 
Default cFilOri		:= "" 
Default cRotin		:= "" 
Default cDescRot	:= "" 
Default cProcess	:= "" 
Default dDtProcess	:= CTOD('') 
Default cOper		:= "I"

//Abre a tabela PZK na empresa origem
EmpOpenFile(cAliasPZK,"PZK",1,.T.,cEmpAux,@cModo)

DbSelectArea(cAliasPZK)
DbSetOrder(2)          

If (cAliasPZK)->(MsSeek(xFilial("PZK",cEmpAux) +DTOS(dDtProcess)+ cEmpOri + cFilOri + cRotin ))              
	
	If !Empty(cOper) .And. Upper(cOper) == "F"
		Reclock(cAliasPZK,.F.)
		(cAliasPZK)->PZK_HORFIN := Time()
		(cAliasPZK)->PZK_STATUS := "1"//Ok
		(cAliasPZK)->(MsUnLock())
	Else                  
		Reclock(cAliasPZK,.F.)
		(cAliasPZK)->PZK_STATUS := "2"//N�o finalizado
		(cAliasPZK)->(MsUnLock())
	EndIf
Else
	Reclock(cAliasPZK,.T.)
	(cAliasPZK)->PZK_EMPORI	:= cEmpOri
	(cAliasPZK)->PZK_FILORI := cFilOri
	(cAliasPZK)->PZK_NOMFIL := Posicione("XX8",2,PADR(cEmpOri, 12 )+cFilOri,"XX8_DESCRI")
	(cAliasPZK)->PZK_ROTINA := cRotin
	(cAliasPZK)->PZK_DESC   := cDescRot
	(cAliasPZK)->PZK_PROCES := cProcess
	(cAliasPZK)->PZK_DATA   := dDtProcess
	(cAliasPZK)->PZK_HORINI := Time()
	(cAliasPZK)->PZK_STATUS := "2"//N�o finalizado
	(cAliasPZK)->(MsUnLock())
EndIf

RestArea(aArea)
Return                           

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF02  �Autor  �Microsiga           � Data �  09/26/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function DBWebManager()
Local oConect
Local cConectStr	:= U_MyNewSX6("NC_NBCABWM","","C","Nome do Banco e ambiente. Exemplo:  'MSSQL7/WebManager'","MSSQL/WebManager","",.F. )
Local cServer		:= U_MyNewSX6("NC_IPSRVWM","","C","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.217 ","192.168.0.202","",.F. )
Local nPortConect	:= U_MyNewSX6("NC_PORTWM","","N","Porta de acesso p/ comunica��o com o banco de dados. Exemplo: 7890","","",.F. )

oConect:=FWDBAccess():New( cConectStr, cServer,nPortConect )

Return oConect




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWMEXLJ �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe exce��o de empresa e filial para a loja  ���
���          �selecionada.												  ���
���          �Retorna array de 2 posi��es								  ���
���          �array[1]= Indica se existe Exce��o cadastrada				  ���
���          �array[2]= Retorna o array com os dados da empresa.		  ���
���          �Obs. Se o array[1] == .T. e array[2] vazio, o processamento ���
���          �n�o deve seguir para essa loja na data informada			  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWMEXLJ(cLoja, dDtMov)

Local aArea 	:= GetArea()
Local aDadosAux := {}
Local aRet		:=  {.F.,{}}

Default cLoja	:= ""
Default dDtMov 	:= CTOD('')

DbSelectArea("ZX5")
DbSetOrder(1)	

DbSelectArea("SM0")
DbSetOrder(1)


If !Empty(cLoja)	
	If ZX5->(MsSeek(xFilial("ZX5")+"00007" + cLoja ) )
		aRet := {.T.,{}}	    
		
		While ZX5->(!Eof()) .And. Alltrim(ZX5->ZX5_CHAVE) == Alltrim(cLoja)
			aDadosAux := Separa(Alltrim(ZX5->ZX5_DESCRI),";")					
			                                                                                        
			//Verifica se existe data de inicio e fim da vigencia. Essa regra ser� prioridade na pesquisa
			If (Len(aDadosAux) >= 4) .And. !Empty(aDadosAux[4]) .And. (dDtMov >= StoD(aDadosAux[3])) .And. (dDtMov <= StoD(aDadosAux[4]))
				aRet := {.T.,{aDadosAux[1], aDadosAux[2], "", "", Posicione("XX8",2,PADR(aDadosAux[1], 12 )+aDadosAux[2],"XX8_DESCRI") }}
				Exit
				
			ElseIf (Len(aDadosAux) >= 4) .And. (dDtMov >= StoD(aDadosAux[3])) .And. Empty(aDadosAux[4])//Verifica o ultimo registro sem a data de final preenchida
				aRet := {.T.,{aDadosAux[1], aDadosAux[2], "", "", Posicione("XX8",2,PADR(aDadosAux[1], 12 )+aDadosAux[2],"XX8_DESCRI") }}
			Else 
				//Retorna o array vazio sen�o encontrou 
				aRet := {.T.,{}}
			EndIf	
			
			ZX5->(DbSkip())
		EndDo
	EndIf
EndIf


RestArea(aArea)
Return aRet
              

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCNoCEsp �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retira caracter especiais do conteudo					      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCNoCEsp(cDados)

Local cDadosAux := ""

cDadosAux := cDados

cDadosAux := StrTran(cDadosAux,"'",".")
cDadosAux := StrTran(cDadosAux,'"',"")
cDadosAux := StrTran(cDadosAux,"�","c")
cDadosAux := StrTran(cDadosAux,"�","C")
cDadosAux := StrTran(cDadosAux,"ç","C")
cDadosAux := StrTran(cDadosAux,"á","A")
cDadosAux := StrTran(cDadosAux,"í","I")
cDadosAux := StrTran(cDadosAux,"ã","A")
cDadosAux := StrTran(cDadosAux,"é","E")
cDadosAux := StrTran(cDadosAux,"�","a")
cDadosAux := StrTran(cDadosAux,"�","a")
cDadosAux := StrTran(cDadosAux,"�","a")
cDadosAux := StrTran(cDadosAux,"�","a")
cDadosAux := StrTran(cDadosAux,"�","a")
cDadosAux := StrTran(cDadosAux,"�","A")
cDadosAux := StrTran(cDadosAux,"�","A")
cDadosAux := StrTran(cDadosAux,"�","A")
cDadosAux := StrTran(cDadosAux,"�","A")
cDadosAux := StrTran(cDadosAux,"�","A")
cDadosAux := StrTran(cDadosAux,"�","e")
cDadosAux := StrTran(cDadosAux,"�","e")
cDadosAux := StrTran(cDadosAux,"�","e")
cDadosAux := StrTran(cDadosAux,"�","e")
cDadosAux := StrTran(cDadosAux,"�","E")
cDadosAux := StrTran(cDadosAux,"�","E")
cDadosAux := StrTran(cDadosAux,"�","E")
cDadosAux := StrTran(cDadosAux,"�","E")
cDadosAux := StrTran(cDadosAux,"�","i")
cDadosAux := StrTran(cDadosAux,"�","i")
cDadosAux := StrTran(cDadosAux,"�","i")
cDadosAux := StrTran(cDadosAux,"�","i")
cDadosAux := StrTran(cDadosAux,"�","I")
cDadosAux := StrTran(cDadosAux,"�","I")
cDadosAux := StrTran(cDadosAux,"�","I")
cDadosAux := StrTran(cDadosAux,"�","O")
cDadosAux := StrTran(cDadosAux,"�","O")
cDadosAux := StrTran(cDadosAux,"�","O")
cDadosAux := StrTran(cDadosAux,"�","O")
cDadosAux := StrTran(cDadosAux,"�","o")
cDadosAux := StrTran(cDadosAux,"�","o")
cDadosAux := StrTran(cDadosAux,"�","o")
cDadosAux := StrTran(cDadosAux,"�","o")
cDadosAux := StrTran(cDadosAux,"�","o")
cDadosAux := StrTran(cDadosAux,"�","O")
cDadosAux := StrTran(cDadosAux,"�","u")
cDadosAux := StrTran(cDadosAux,"�","u")
cDadosAux := StrTran(cDadosAux,"�","u")
cDadosAux := StrTran(cDadosAux,"�","u")
cDadosAux := StrTran(cDadosAux,"�","U")
cDadosAux := StrTran(cDadosAux,"�","U")
cDadosAux := StrTran(cDadosAux,"�","U")
cDadosAux := StrTran(cDadosAux,"�","U")

cDadosAux := FwNoAccent(cDadosAux)
cDadosAux := UPPER(cDadosAux)

Return cDadosAux
                

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCCadPrd �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia e-mail para cadastrar produto na Store e Proximo      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCCadPrd(cCodProd)

Default cCodProd := ""

StartJob( "U_NCWM2MCP",GetEnvServer(), .F., {cCodProd})   

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWM2MCP �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia e-mail para cadastrar produto na Store e Proximo      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWM2MCP(aCodProd)

Local aArea 	:= {}
Local cMailDest := ""
Local cMailCpy 	:= ""
Local cAssunto	:= "Cadastro de produto NC Store e Proximo"
Local cMsg		:= ""
Local cCodProd	:= ""

Default aCodProd := {}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv("01","03")

aArea 		:= GetArea()
cMailDest 	:= U_MyNewSX6("NC_MAIPRWM","","C","E-mail para cadastro de produto do Web Manager","","",.F. )
cMailCpy 	:= U_MyNewSX6("NC_MACPRWM","","C","E-mail em copia para cadastro de produto do Web Manager","","",.F. )

If Len(aCodProd) > 0
	cCodProd := aCodProd[1]
EndIf	

If !Empty(cCodProd)
	cMsg := " Prezados (a),"+CRLF+CRLF
	cMsg += " Por gentileza, realizar o cadastro do(s) produto(s) abaixo: "+CRLF+cCodProd+CRLF+CRLF
	cMsg += " E-mail autom�tico, favor n�o responder."+CRLF+CRLF

	U_ENVIAEMAIL(cMailDest, cMailCpy, , cAssunto, cMsg, {})
EndIf

RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCCXCARD �Autor  �Microsiga 	          � Data � 07/04/15 ���
�������������������������������������������������������������������������͹��
���Desc.     �Efetua a conex�o com o banco de dados do C.CARD e retorna   ���
���          �a tabela tempor�ria.                  		  					 ���
���          �Semelhante ao DbUseArea()				               		 ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCCXCARD(cQuery,cTipo,cMensagem)

Local aArea 		:= GetArea()
Local nConecAtual	:= 0
Local nConection 	:= 0
Local cAliasQry  	:= GetNextAlias()//Alias de retorno
Local cConectStr	:= U_MyNewSX6("NC_NBCABCC","","C","Nome do Banco e ambiente. Exemplo:  'MSSQL/DATAMACE'","MSSQL/DATAMACE","",.F. )
Local cServer		:= U_MyNewSX6("NC_IPSRVCC","","C","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.218 ","192.168.0.218","",.F. )
Local nPortConect	:= U_MyNewSX6("NC_PORTCC","","N","Porta de acesso p/ comunica��o com o banco de dados. Exemplo: 7899","7899","",.F. )

Default cQuery		:= ""       
Default cTipo			:="1"
Default cMensagem 	:=""
cMensagem:=""

nConecAtual := AdvConnection()

If nConectWM<=0
	nConection	:=TcLink(cConectStr, cServer, nPortConect  )
	nConectWM	:=nConection
Else
	nConection	:=nConectWM
EndIf	

If nConection < 0	
	If !IsBlind()
		Aviso("Aten��o","Nao foi poss�vel estabelecer conexao com o banco SQL do C.CARD",{"Ok"},2)
	EndIf	
	cAliasQry := ""
	Return cAliasQry
Else
	TcSetConn( nConection )
EndIf

If cTipo=="1"
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)
ElseIf cTipo=="2"
	If TcSQLExec(cQuery) <> 0
		cMensagem:=TCSQLError()
	EndIf
EndIf

TCSetConn(nConecAtual) // Restaura conexao antiga
RestArea(aArea)
Return cAliasQry