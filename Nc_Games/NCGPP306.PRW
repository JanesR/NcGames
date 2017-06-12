#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ                                              
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPP306	ºAutor  ³Elton C.			 º Data ³  05/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para o repasse de crédito ao cliente		  º±±
±±º          ³             												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPP306()

Local aArea 		:=	GetArea()
Local aCliCred	    := {}
Local nX			:= 0
Local cMsgNcc		:= ""
Local cMsgLogNCC	:= "" 
Local cCodUser		:= Alltrim(RetCodUsr())
Local cUserAut		:= U_MyNewSX6("NC_UREPNCC",;
									" ",;
									"C",;
									"Usuário autorizado a gerar NCC em caso de repasse do Price Protection ao cliente.",;
									"Usuário autorizado a gerar NCC em caso de repasse do Price Protection ao cliente.",;
									"Usuário autorizado a gerar NCC em caso de repasse do Price Protection ao cliente.",;
									.F. )


If !(cCodUser $ cUserAut)
	
	Aviso("Permissão de usuário","Usuário não autorizado. "+CRLF+"Entre em contato com o administrador. (NC_UREPNCC)",{"Ok"},2)
    Return      
    
ElseIf Empty(PZE->PZE_DTEFET)
	
	Aviso("VLDREPA-1","Opção inválida. O documento não está efetivado, verifique se o crédito foi disponibilizado pelo Publisher.",{"Ok"},2)
	
ElseIf !VldRepCli(PZE->PZE_CODVP)
	
	Aviso("VLDREPA-2","Opção inválida. Não existe cliente para efetuar repasse.",{"Ok"},2)
	
Else
	//Chama a rotina para selecionar os clientes que receberão o credito
	aCliCred := SelCliNCC(PZE->PZE_CODVP)
	
	//Verifica se algum cliente foi selecionado
	If Len(aCliCred) > 0
		
			If Aviso("Atenção","Deseja gerar NCC para os clientes selecionados ?",{"Sim","Não"},2) == 1
				//Chama a rotina para gerar ncc
				Processa({|| RunGerNCC(aCliCred) })
			EndIf
    Else
	 	Aviso("NONCC", "Não existe NCC a ser gerada e/ou nenhum cliente selecionado", {"Ok"}, 2)
	EndIf
	
EndIF



RestArea(aArea)
Return               

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³RunGerNCC  º Autor ³ Elton C.		 º Data ³  04/09/13   	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina de processamento para geração da NCC				  º±±
±±º          ³					  						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunGerNCC(aCliCred)

Local aArea 	:= GetArea()
Local cMsgNcc   := ""

Default aCliCred := {}

cMsgNcc := ""

ProcRegua(Len(aCliCred))

//Gera as NCC´s para os cliente selecionados na rotina anterior "SelCliNCC"
For nX	:= 1 To Len(aCliCred)
	
	IncProc("Processando...")
		
	If !Empty(aCliCred[nX][1]) .And. !Empty(aCliCred[nX][2])
		//Chama a rotina para gravar a NCC
		cMsgNcc += GerNCC(PZE->PZE_CODVP, aCliCred[nX][1], aCliCred[nX][2])
	EndIf
	
Next

Aviso("Log de Processamento",cMsgNcc,{"Ok"},3)

RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GerNCC	  º Autor ³ Elton C.		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina automatica para gerar a NCC no modulo financeiro	  º±±
±±º          ³					  						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GerNCC(cCodVP, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local aTitulo	:= {}                       
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local cNumTit	:= ""
Local cRet		:= ""
Local cPrefixo  := U_MyNewSX6("NC_PREFIVP",;
									"VP",;
									"C",;
									"Prefixo utilizado na criação da NCC do Verba Publisher",;
									"Prefixo utilizado na criação da NCC do Verba Publisher",;
									"Prefixo utilizado na criação da NCC do Verba Publisher",;
									.F. )

Local cNaturez  := U_MyNewSX6("NC_NATURVP",;
									"12211",;
									"C",;
									"Natureza da NCC de Verba Publisher",;
									"Natureza da NCC de Verba Publisher",;
									"Natureza da NCC de Verba Publisher",;
									.F. )
                    	
Local cHistNCC  := U_MyNewSX6("NC_HNCCVP",;
									"VP",;
									"C",;
									"Historico NCC Verba Publisher",;
									"Historico NCC Verba Publisher",;
									"Historico NCC Verba Publisher",;
									.F. )  

Default cCodVP		:= "" 
Default cCodCli		:= "" 
Default cLoja 		:= ""

//Verifica se o codigo do cliente e loja estão preenchidos
If (!Empty(cCodCli)) .And. (!Empty(cLoja)) .And. (!Empty(cCodVP))
	
	//Query para buscar os dados utilizado no Verba Publisher.
	//Esses dados serão utilizado para geração da NCC
	cQuery := " SELECT PZF_CLIENT, PZF_LOJA, SUM(PZF_VALOR) PZF_VALOR , A1_NOME FROM "+RetSqlName("PZF")+" PZF "+CRLF
	
	cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
	cQuery += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
	cQuery += " AND SA1.A1_COD = PZF.PZF_CLIENT "+CRLF
	cQuery += " AND SA1.A1_LOJA = PZF.PZF_LOJA "+CRLF
	
	cQuery += "  WHERE PZF.PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
	cQuery += "  AND PZF.PZF_CODVP = '"+cCodVP+"' "+CRLF
	cQuery += "  AND PZF.PZF_CLIENT = '"+cCodCli+"' "+CRLF
	cQuery += "  AND PZF.PZF_LOJA = '"+cLoja+"' "+CRLF
	cQuery += "  AND PZF.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += "  GROUP BY PZF_CLIENT, PZF_LOJA, A1_NOME "+CRLF
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
	
	(cArqTmp)->(DbGoTop())
	
	If (cArqTmp)->(!Eof())
				
		cNumTit := GetSXENum("SE1","E1_NUM")
		
		//Preenchiemnto do titulo (ncc)
		AADD(aTitulo,	{"E1_PREFIXO"	,cPrefixo				,Nil})
		AADD(aTitulo,	{"E1_NUM"		,cNumTit				,Nil})
		AADD(aTitulo,	{"E1_TIPO"		,"NCC"					,Nil})
		AADD(aTitulo,	{"E1_CLIENTE"	,(cArqTmp)->PZF_CLIENT	,Nil})
		AADD(aTitulo,	{"E1_LOJA"	    ,(cArqTmp)->PZF_LOJA	,Nil})
		AADD(aTitulo,	{"E1_NOMCLI"	,(cArqTmp)->A1_NOME		,Nil})
		AADD(aTitulo,	{"E1_NATUREZ"	,cNaturez				,Nil})
		AADD(aTitulo,	{"E1_EMISSAO" 	,dDataBase		 		,Nil})
		AADD(aTitulo,	{"E1_VENCTO" 	,dDataBase		  		,Nil})
		AADD(aTitulo,	{"E1_VENCREA" 	,dDataBase		  		,Nil})
		AADD(aTitulo,	{"E1_VALOR"		,(cArqTmp)->PZF_VALOR	,Nil})
		AADD(aTitulo,	{"E1_VLRREAL"	,(cArqTmp)->PZF_VALOR	,Nil})
		AADD(aTitulo,	{"E1_LA"		,"S"					,Nil})
		AADD(aTitulo,	{"E1_HIST"		,UPPER(cHistNCC)+ "- (Cod.Doc: "+cCodVP+")" ,Nil})
		AADD(aTitulo,	{"E1_ORIGEM"	,"U_NCGPP306"			,Nil})
		
		
		//Chama a rotina automatica para gerar a NCC
		cRet := ExecGerNCC(aTitulo, 3 )
		
		//Verifica se ocorreu algum erro na geração da NCC
		If Empty(cRet)
			//Confirma o valor reservado para o titulo
			ConfirmSX8()                                        
			
			//Grava os dados da NCC X VP			
			If GrvCtRep(cCodVP, cPrefixo, cNumTit, " ", "NCC")			
			
				cRet := "NCC criada com sucesso -Cod.VP: "+cCodVP+"|Titulo: "+cNumTit+" |Prefixo: "+cPrefixo+" |Parcela:  |Tipo: NCC "+CRLF+CRLF
			Else                                                                                                                  
				cRet := "Erro na criação da NCC - Cod.VP: "+cCodVP+"  |Titulo: "+cNumTit+" |Prefixo: "+cPrefixo+" |Parcela:  |Tipo: NCC "+CRLF
				cRet += " Não foi possivel efetuar amarração VP x NCC "+CRLF+CRLF
			EndIf
	   	Else
			Aviso("ERRNCC-3","Erro ao tentar criar NCC para o cliente "+cCodCli+"/"+cLoja+;
						" no documento de Verba Publisher de n.º: "+cCodVP+CRLF+CRLF+cRet,{"Ok"},3)
			RollBackSx8()
		EndIf
		
	Else
		Aviso("ERRNCC-2","Nenhum item encontrado para o cliente "+cCodCli+"/"+cLoja+" no documento de Verba Publisher de n.º: "+cCodVP,{"Ok"},2)
	EndIf
	
	
	(cArqTmp)->(DbCloseArea())
Else
	Aviso("ERRNCC-1","Erro ao gerar NCC. Itens obrigatórios não preenchidos: "+CRLF+"Cliente: "+cCodCli+CRLF+" Loja: "+cLoja+CRLF+" Cod.VP: "+cCodVP,{"Ok"},3)
EndIf

RestArea(aArea)
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ExecGerNCC  º Autor ³ Elton C.		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina automatica para gerar a NCC no modulo financeiro	  º±±
±±º          ³					  						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                 
Static Function ExecGerNCC(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclusão

Begin Transaction
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, nOpc)
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Os dados informados estão incorretos. Verifique o preenchimento do mesmo."
EndIf

End Transaction

RestArea(aArea)
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GrvCtRep  º Autor ³ Elton C.		 º Data ³  04/09/13	      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Grava os dados do controle de repasse (NCC X VP)			  º±±
±±º          ³					  						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GrvCtRep(cCodVP, cPrefixo, cTitulo, cParcela, cTipo)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cNumSeq	:= GetSXENum("PZ5","PZ5_NUMSEQ")
Local lRet		:= .T.

Default cCodVP 		:= "" 
Default cPrefixo	:= "" 
Default cTitulo		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

cQuery    := " SELECT PZE_PPPUB, PZE_PUBLIS, PZE_CODVP, E1_CLIENTE, E1_LOJA, A1_NOME, "+CRLF
cQuery    += "       SUM(PZF_VALOR) PZF_VALOR, E1_PREFIXO, "+CRLF
cQuery    += " 		E1_NUM, E1_TIPO, E1_PARCELA, P0C_PUBLIS  FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery    += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery    += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF
cQuery    += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZE")+" PZE "+CRLF
cQuery    += " ON PZE.PZE_FILIAL = '"+xFilial("PZE")+"' " +CRLF
cQuery    += " AND PZE.PZE_CODVP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZE.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZF")+" PZF "+CRLF
cQuery    += " ON PZF.PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
cQuery    += " AND PZF.PZF_CLIENT = SE1.E1_CLIENTE "+CRLF
cQuery    += " AND PZF.PZF_LOJA = SE1.E1_LOJA "+CRLF
cQuery    += " AND PZF.PZF_CODVP = PZE.PZE_CODVP "+CRLF
cQuery    += " AND PZF.D_E_L_E_T_ = ' ' "+CRLF

cQuery +=   " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery +=   " ON P0C.D_E_L_E_T_ = ' ' "+CRLF
cQuery +=   " AND P0C.P0C_FILIAL = '"+xFilial("P0C")+"' "+CRLF
cQuery +=   " AND P0C.P0C_PPPUB = PZE.PZE_PPPUB "+CRLF

cQuery    += " WHERE SE1.D_E_L_E_T_ = ' '  "+CRLF
cQuery    += " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery    += " AND SE1.E1_NUM = '"+cTitulo+"' "+CRLF
cQuery    += " AND SE1.E1_PARCELA = '"+cParcela+"' " +CRLF
cQuery    += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery    += " GROUP BY PZE_PPPUB, PZE_PUBLIS, PZE_CODVP, E1_CLIENTE, E1_LOJA, A1_NOME, E1_PREFIXO, E1_NUM, E1_TIPO, E1_PARCELA, P0C_PUBLIS "

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("PZ5")
DbSetOrder(1)

(cArqTmp)->(DbGoTop())
If (cArqTmp)->(!Eof())

	PZ5->(RECLOCK("PZ5",.T.)	)
	PZ5->PZ5_FILIAL := xFilial("PZ5")
	PZ5->PZ5_NUMSEQ := cNumSeq
	PZ5->PZ5_PPPUB	:= (cArqTmp)->PZE_PPPUB
	PZ5->PZ5_CODPUB	:= (cArqTmp)->P0C_PUBLIS
	PZ5->PZ5_DPUBLI	:= (cArqTmp)->PZE_PUBLIS
	PZ5->PZ5_CODPP	:= (cArqTmp)->PZE_CODVP
	PZ5->PZ5_CLIENT	:= (cArqTmp)->E1_CLIENTE
	PZ5->PZ5_LOJA	:= (cArqTmp)->E1_LOJA
	//PZ5->PZ5_NOMCLI	:= (cArqTmp)->A1_NOME
	PZ5->PZ5_VALPP	:= (cArqTmp)->PZF_VALOR
	PZ5->PZ5_VALNCC	:= (cArqTmp)->PZF_VALOR
	PZ5->PZ5_VALUSA	:= 0
	PZ5->PZ5_VALSLD	:= (cArqTmp)->PZF_VALOR
	PZ5->PZ5_PREFIX	:= (cArqTmp)->E1_PREFIXO
	PZ5->PZ5_TITULO	:= (cArqTmp)->E1_NUM
	PZ5->PZ5_PARCEL	:= (cArqTmp)->E1_PARCELA
	PZ5->PZ5_TIPO 	:= (cArqTmp)->E1_TIPO        
	PZ5->PZ5_TIPOPC := "1"//Credito
	PZ5->PZ5_VERBPU	:= "1"//Verba Publisher
	PZ5->PZ5_DTEMIS	:= MsDate()
	PZ5->PZ5_USER	:= cUserName
	PZ5->PZ5_DTUALT	:= MsDate()
	PZ5->PZ5_TIME	:= Time()
	PZ5->PZ5_STATUS	:= "1"//Não Aplicado
	PZ5->(MsUnLock())
                                                        
Else                  

	lRet := .F.
	Aviso("NOGRV","Não existe dados a serem gravados na tabela PZ5-Controle de Repasse",{"Ok"},2)

EndIf


(cArqTmp)->(DbCloseArea())
ConfirmSX8()

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldRepCli	ºAutor  ³Elton C.			 º Data ³  05/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se existe repasse para algum cliente				  º±±
±±º          ³             												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldRepCli(cCodVP)

Local aArea 	:= GetArea()
Local lRet 		:= .T. 
Local cArqTmp   := GetNextAlias()    
Local cQuery 	:= ""
Local cCliente		:= U_MyNewSX6("NC_CMVGCLI",;
									"000001",;
									"C",;
									"Código do cliente NC Games",;
									"Código do cliente NC Games",;
									"Código do cliente NC Games",;
									.F. )
									
Local cLojaCli		:= U_MyNewSX6("NC_CMVGLJ",;
									"01",;
									"C",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									.F. )


Default cCodVP := ""

cQuery 	:= " SELECT * FROM "+RetSqlName("PZF")+CRLF

cQuery 	+= " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery 	+= " AND PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
cQuery 	+= " AND PZF_CODVP = '"+cCodVP+"' "+CRLF 
cQuery 	+= " AND ((PZF_CLIENT || PZF_LOJA) != '"+cCliente+cLojaCli+"' ) "

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(Eof())                  
	lRet 		:= .F.                     
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SelCliNCC	ºAutor  ³Elton C.			 º Data ³  05/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Seleciona os clientes listados no documento do VP			  º±±
±±º          ³             												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SelCliNCC(cCodVP)
Local aArea := GetArea()
Local aRet	:= {}
Local olMark		:= Nil
Local clSql			:= ""
Local clAlias		:= GetNextAlias()
Local clAliasB		:= GetNextAlias()
Local clTmp			:= CriaTrab(Nil,.F.)
Local alColuns		:= {}
Local _oDlg			:= Nil
Local llOk			:= .F.
Local clPesq 		:= Space(30)
Local clResult		:= ""   
Local cCliente		:= U_MyNewSX6("NC_CMVGCLI",;
									"000001",;
									"C",;
									"Código do cliente NC Games",;
									"Código do cliente NC Games",;
									"Código do cliente NC Games",;
									.F. )
									
Local cLojaCli		:= U_MyNewSX6("NC_CMVGLJ",;
									"01",;
									"C",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									.F. )
									

Private cMarca  := GetMark()  // Essa variável não pode ter outro nome

Default cCodVP := ""

AADD(alColuns,{"OK"			,,""			,""})
aAdd(alColuns,{"PZF_CODVP" 	,,"Cod. VP" 	,""})
aAdd(alColuns,{"PZF_CLIENT" ,,"Cod. Cliente",""})
aAdd(alColuns,{"PZF_LOJA" 	,,"Loja"		,""})
aAdd(alColuns,{"PZF_NOME" 	,,"Nome"		,""})
aAdd(alColuns,{"PZF_VALOR"	,,"Valor Repasse","@E 999,999,999,999.99"})


clSql := " SELECT '  ' OK, PZF_CODVP, PZF_CLIENT, PZF_LOJA, PZF_NOME, SUM(PZF_VALOR) PZF_VALOR FROM "+RetSqlName("PZF")+" PZF "+CRLF

clSql += " INNER JOIN "+RetSqlName("PZE")+" PZE "+CRLF
clSql += " ON PZE.PZE_FILIAL = '"+xFilial("PZE")+"' "+CRLF
clSql += " AND PZE.PZE_CODVP = PZF.PZF_CODVP "+CRLF
clSql += " AND PZE.PZE_DTEFET != ' ' " +CRLF
clSql += " AND PZE.D_E_L_E_T_ = ' ' "+CRLF

clSql += " WHERE PZF.PZF_FILIAL = '"+xFilial("PZF")+"' "+CRLF
clSql += " AND PZF.PZF_CODVP = '"+cCodVP+"' "+CRLF
clSql += " AND NOT EXISTS (SELECT * FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF
clSql += "                   WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
clSql += "                   AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
clSql += "                   AND PZ5.PZ5_CODPP = PZF.PZF_CODVP "+CRLF
clSql += "                   AND (PZ5.PZ5_CLIENT = PZF.PZF_CLIENT AND PZ5.PZ5_LOJA = PZF.PZF_LOJA) "+CRLF
clSql += "                   ) "+CRLF
clSql += " AND 	PZF.D_E_L_E_T_ = ' ' "+CRLF
clSql += " 	GROUP BY PZF_CODVP, PZF_CLIENT, PZF_LOJA, PZF_NOME "+CRLF

clSql := ChangeQuery(clSql)
                                            
DbUseArea(.T.,"TOPCONN",TCGENQRY(,,clSql),clAliasB, .F., .T.)

DbSelectArea(clAliasB)                  

Copy To &clTmp

(clAliasB)->(DbCloseArea())

DbUseArea(.T.,,clTmp,clAlias,.T.,.F.)

(clAlias)->(DbGoTop())

If (clAlias)->(!Eof())
	
	DEFINE MSDIALOG _oDlg TITLE "Seleção de Clientes (Sem NCC Gerada)" FROM 001,001 TO 385,700 PIXEL of oMainWnd
	
	@ 15, 07 COMBOBOX oComb VAR clResult ITEMS {"1-Codigo","2-Descrição"} SIZE 53, 38 OF _oDlg PIXEL
	@ 15, 60 MSGET clPesq SIZE	80, 9 OF _oDlg PIXEL
	@ 15, 140 BUTTON "Pesquisar" SIZE 030,011 ACTION {|| GetPesq(Iif(Alltrim(SUBSTRING(clResult,1,1)) == "1","PZF_CLIENT","A1_NOME"),clAlias ,clPesq), olMark:OBROWSE:Refresh()} PIXEL OF _oDlg
	
	olMark := MsSelect():New(clAlias,"OK","",alColuns,.T.,@cMarca,{030,006,175,345},,,_oDlg)
	
	olMark:OBROWSE:LCANALLMARK := .T.
	
	olMark:OBROWSE:BALLMARK := {|| MarkTodos(clAlias)}
	
	EnchoiceBar(_oDlg, {||llOk := .T., _oDlg:End() },{|| _oDlg:End() },,)
	
	ACTIVATE MSDIALOG _oDlg CENTERED
	
	If llOk
		
		DbSelectArea(clAlias)
		
		(clAlias)->(DbGotop())
		
		//Preenche od itens selecionados
		While (clAlias)->(!Eof())
			
			If Empty( (clAlias)->OK )
				Aadd(aRet, {(clAlias)->PZF_CLIENT, (clAlias)->PZF_LOJA, (clAlias)->PZF_NOME} )
			EndIf
			
			(clAlias)->(DbSkip())
		EndDo
		
	EndIf
	
Else
	aRet := {}
EndIf

//Fecha a area após a seleção
(clAlias)->(DbCloseArea())

RestArea(aArea)
Return aRet


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³MarkTodos| Marca/Desmarca todos os itens da msselect                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³18.110.11³ Elton C.				                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParâmetros  ³ExpC1 - Nome do grupo de perguntas                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºObservações ³                                                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function MarkTodos(clAlias)
	Local nlRecno 	:= (clAlias)->(Recno())
	Local nlCont    := 0
	
    (clAlias)->(DbGoTop())
    While (clAlias)->(!Eof())
		nlCont++
		
		If (clAlias)->(RecLock(clAlias,.F.))
  			
  			If (clAlias)->OK == cMarca
  				(clAlias)->OK := Space(2)
			Else
				(clAlias)->OK := cMarca
			EndIf
			(clAlias)->(MsUnlock())
		EndIf
		
		
		(clAlias)->(DbSkip())
	EndDo

	(clAlias)->(DbGoTo(nlRecno))
	
Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetPesq	   	   ³ Autor ³Elton C.        ³ Data ³18.10.11  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Posiciona no item pesquisado				 				  ³±±
±±³			 ³															  ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetPesq(cCampo, clAlias, cPesq)

Local nRet 	:= 1
Local nCont	:= 0

Default cCampo 	:= ""
Default clAlias	:= ""
Default cPesq	:= ""

(clAlias)->(DbGoTop())
If !Empty(cPesq)
	While (clAlias)->(!EOF())
		
		++nCont
		
		If UPPER(Alltrim(cPesq)) $ UPPER(Alltrim((clAlias)->&cCampo))
			nRet := nCont
			Exit
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
EndIf

Return nRet     
                           


