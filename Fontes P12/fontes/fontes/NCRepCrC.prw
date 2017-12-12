#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"

/*
����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCRepCrC	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para o repasse de cr�dito ao cliente		  ���
���          �             												  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCRepCrC()

Local aArea 		:=	GetArea()
Local aCliCred	    := {}
Local nX			:= 0
Local cMsgNcc		:= ""
Local cMsgLogNCC	:= "" 
Local cCodUser		:= Alltrim(RetCodUsr())
Local cUserAut		:= U_MyNewSX6("NC_UREPNCC",;
									" ",;
									"C",;
									"Usu�rio autorizado a gerar NCC em caso de repasse do Price Protection ao cliente.",;
									"Usu�rio autorizado a gerar NCC em caso de repasse do Price Protection ao cliente.",;
									"Usu�rio autorizado a gerar NCC em caso de repasse do Price Protection ao cliente.",;
									.F. )


If !(cCodUser $ cUserAut)
	
	Aviso("Permiss�o de usu�rio","Usu�rio n�o autorizado. "+CRLF+"Entre em contato com o administrador. (NC_UREPNCC)",{"Ok"},2)
    Return      
    
ElseIf Empty(PZC->PZC_DTEFET)
	
	Aviso("VLDREPA-1","Op��o inv�lida. O documento n�o est� efetivado, verifique se o cr�dito foi disponibilizado pelo Publisher.",{"Ok"},2)
	
ElseIf !VldRepCli(PZC->PZC_CODPP)
	
	Aviso("VLDREPA-2","Op��o inv�lida. N�o existe cliente para efetuar repasse.",{"Ok"},2)
	
Else
	//Chama a rotina para selecionar os clientes que receber�o o credito
	aCliCred := SelCliNCC(PZC->PZC_CODPP)
	
	//Verifica se algum cliente foi selecionado
	If Len(aCliCred) > 0
		
			If Aviso("Aten��o","Deseja gerar NCC para os clientes selecionados ?",{"Sim","N�o"},2) == 1
				//Chama a rotina para gerar ncc
				Processa({|| RunGerNCC(aCliCred) })
			EndIf
    Else
	 	Aviso("NONCC", "N�o existe NCC a ser gerada e/ou nenhum cliente selecionado", {"Ok"}, 2)
	EndIf
	
EndIF



RestArea(aArea)
Return               

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �RunGerNCC  � Autor � Elton C.		 � Data �  04/09/13   	  ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina de processamento para gera��o da NCC				  ���
���          �					  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function RunGerNCC(aCliCred)

Local aArea 	:= GetArea()
Local cMsgNcc   := ""

Default aCliCred := {}

cMsgNcc := ""

ProcRegua(Len(aCliCred))

//Gera as NCC�s para os cliente selecionados na rotina anterior "SelCliNCC"
For nX	:= 1 To Len(aCliCred)
	
	IncProc("Processando...")
		
	If !Empty(aCliCred[nX][1]) .And. !Empty(aCliCred[nX][2])
		//Chama a rotina para gravar a NCC
		cMsgNcc += GerNCC(PZC->PZC_CODPP, aCliCred[nX][1], aCliCred[nX][2])
	EndIf
	
Next

Aviso("Log de Processamento",cMsgNcc,{"Ok"},3)

RestArea(aArea)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GerNCC	  � Autor � Elton C.		 � Data �  04/09/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina automatica para gerar a NCC no modulo financeiro	  ���
���          �					  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function GerNCC(cCodPP, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local aTitulo	:= {}                       
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local cNumTit	:= ""
Local cRet		:= ""
Local cPrefixo  := U_MyNewSX6("NC_PREFIPP",;
									"PP",;
									"C",;
									"Prefixo utilizado na cria��o da NCC do Price Protection",;
									"Prefixo utilizado na cria��o da NCC do Price Protection",;
									"Prefixo utilizado na cria��o da NCC do Price Protection",;
									.F. )

Local cNaturez  := U_MyNewSX6("NC_NATURPP",;
									"15111",;
									"C",;
									"Natureza da NCC de Price Protection",;
									"Natureza da NCC de Price Protection",;
									"Natureza da NCC de Price Protection",;
									.F. )
                    	
Local cHistNCC  := U_MyNewSX6("NC_HNCCPP",;
									"PP",;
									"C",;
									"Historico NCC Price Protection",;
									"Historico NCC Price Protection",;
									"Historico NCC Price Protection",;
									.F. )  

Default cCodPP		:= "" 
Default cCodCli		:= "" 
Default cLoja 		:= ""

//Verifica se o codigo do cliente e loja est�o preenchidos
If (!Empty(cCodCli)) .And. (!Empty(cLoja)) .And. (!Empty(cCodPP))
	
	//Query para buscar os dados utilizado no Price Protection.
	//Esses dados ser�o utilizado para gera��o da NCC
	cQuery := " SELECT PZD_CLIENT, PZD_LOJA, SUM(PZD_TOTREP) PZD_TOTREP , A1_NOME, PZC_PPPUB FROM "+RetSqlName("PZD")+" PZD "+CRLF
	
	cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
	cQuery += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
	cQuery += " AND SA1.A1_COD = PZD.PZD_CLIENT "+CRLF
	cQuery += " AND SA1.A1_LOJA = PZD.PZD_LOJA "+CRLF
   
	cQuery += " LEFT OUTER JOIN "+RetSqlName("PZC")+" PZC "+CRLF
	cQuery += " ON PZC.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND PZC.PZC_FILIAL = '"+xFilial("PZC")+"' "+CRLF
	cQuery += " AND PZC.PZC_CODPP = PZD.PZD_CODPP "+CRLF
	
	cQuery += "  WHERE PZD.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += "  AND PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
	cQuery += "  AND PZD.PZD_CODPP = '"+cCodPP+"' "+CRLF
	cQuery += "  AND PZD.PZD_CLIENT = '"+cCodCli+"' "+CRLF
	cQuery += "  AND PZD.PZD_LOJA = '"+cLoja+"' "+CRLF
	cQuery += "  GROUP BY PZD_CLIENT, PZD_LOJA, A1_NOME, PZC_PPPUB "+CRLF
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
	
	(cArqTmp)->(DbGoTop())
	
	If (cArqTmp)->(!Eof())
				
		cNumTit := GetSXENum("SE1","E1_NUM")
		
		//Preenchiemnto do titulo (ncc)
		AADD(aTitulo,	{"E1_PREFIXO"	,cPrefixo				,Nil})
		AADD(aTitulo,	{"E1_NUM"		,cNumTit				,Nil})
		AADD(aTitulo,	{"E1_TIPO"		,"NCC"					,Nil})
		AADD(aTitulo,	{"E1_CLIENTE"	,(cArqTmp)->PZD_CLIENT	,Nil})
		AADD(aTitulo,	{"E1_LOJA"	    ,(cArqTmp)->PZD_LOJA	,Nil})
		AADD(aTitulo,	{"E1_NOMCLI"	,(cArqTmp)->A1_NOME		,Nil})
		AADD(aTitulo,	{"E1_NATUREZ"	,cNaturez				,Nil})
		AADD(aTitulo,	{"E1_EMISSAO" 	,dDataBase		 		,Nil})
		AADD(aTitulo,	{"E1_VENCTO" 	,dDataBase		  		,Nil})
		AADD(aTitulo,	{"E1_VENCREA" 	,dDataBase		  		,Nil})
		AADD(aTitulo,	{"E1_VALOR"		,(cArqTmp)->PZD_TOTREP	,Nil})
		AADD(aTitulo,	{"E1_VLRREAL"	,(cArqTmp)->PZD_TOTREP	,Nil})
		AADD(aTitulo,	{"E1_LA"		,"S"					,Nil})
		AADD(aTitulo,	{"E1_HIST"		,UPPER(cHistNCC)+ " - (Doc: "+cCodPP+" - "+AllTrim((cArqTmp)->PZC_PPPUB)+")" ,Nil})
		AADD(aTitulo,	{"E1_ORIGEM"	,"U_NCGPP303"			,Nil})
		
		
		//Chama a rotina automatica para gerar a NCC
		cRet := ExecGerNCC(aTitulo, 3 )
		
		//Verifica se ocorreu algum erro na gera��o da NCC
		If Empty(cRet)
			//Confirma o valor reservado para o titulo
			ConfirmSX8()                                        
			
			//Grava os dados da NCC X PP			
			If GrvCtRep(cCodPP, cPrefixo, cNumTit, " ", "NCC")			
			
				cRet := "NCC criada com sucesso -Cod.PP: "+cCodPP+"|Titulo: "+cNumTit+" |Prefixo: "+cPrefixo+" |Parcela:  |Tipo: NCC "+CRLF+CRLF
			Else                                                                                                                  
				cRet := "Erro na cria��o da NCC - Cod.PP: "+cCodPP+"  |Titulo: "+cNumTit+" |Prefixo: "+cPrefixo+" |Parcela:  |Tipo: NCC "+CRLF
				cRet += " N�o foi possivel efetuar amarra��o PP x NCC "+CRLF+CRLF
			EndIf
	   	Else
			Aviso("ERRNCC-3","Erro ao tentar criar NCC para o cliente "+cCodCli+"/"+cLoja+;
						" no documento de Price Protection de n.�: "+cCodPP+CRLF+CRLF+cRet,{"Ok"},3)
			RollBackSx8()
		EndIf
		
	Else
		Aviso("ERRNCC-2","Nenhum item encontrado para o cliente "+cCodCli+"/"+cLoja+" no documento de Price Protection de n.�: "+cCodPP,{"Ok"},2)
	EndIf
	
	
	(cArqTmp)->(DbCloseArea())
Else
	Aviso("ERRNCC-1","Erro ao gerar NCC. Itens obrigat�rios n�o preenchidos: "+CRLF+"Cliente: "+cCodCli+CRLF+" Loja: "+cLoja+CRLF+" Cod.PP: "+cCodPP,{"Ok"},3)
EndIf

RestArea(aArea)
Return cRet

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ExecGerNCC  � Autor � Elton C.		 � Data �  04/09/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina automatica para gerar a NCC no modulo financeiro	  ���
���          �					  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/                                                                 
Static Function ExecGerNCC(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclus�o

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
	cRet := "Os dados informados est�o incorretos. Verifique o preenchimento do mesmo."
EndIf

End Transaction

RestArea(aArea)
Return cRet

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GrvCtRep  � Autor � Elton C.		 � Data �  04/09/13	      ���
�������������������������������������������������������������������������͹��
���Descricao �Grava os dados do controle de repasse (NCC X PP)			  ���
���          �					  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function GrvCtRep(cCodPP, cPrefixo, cTitulo, cParcela, cTipo)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cNumSeq	:= GetSXENum("PZ5","PZ5_NUMSEQ")
Local lRet		:= .T.

Default cCodPP 		:= "" 
Default cPrefixo	:= "" 
Default cTitulo		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

cQuery    := " SELECT PZC_PPPUB, PZC_PUBLIS, PZC_CODPP, E1_CLIENTE, E1_LOJA, A1_NOME, "+CRLF
cQuery    += "       SUM(PZD_TOTREP) PZD_TOTREP, SUM(PZD_TOTPUB) PZD_TOTPUB, PZD_TPREP, E1_PREFIXO, "+CRLF
cQuery    += " 		E1_NUM, E1_TIPO, E1_PARCELA, P0C_PUBLIS  FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery    += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery    += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF
cQuery    += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZC")+" PZC "+CRLF
cQuery    += " ON PZC.PZC_FILIAL = '"+xFilial("PZC")+"' " +CRLF
cQuery    += " AND PZC.PZC_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZC.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " ON PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery    += " AND PZD.PZD_CLIENT = SE1.E1_CLIENTE "+CRLF
cQuery    += " AND PZD.PZD_LOJA = SE1.E1_LOJA "+CRLF
cQuery    += " AND PZD.PZD_CODPP = PZC.PZC_CODPP "+CRLF
cQuery    += " AND PZD.D_E_L_E_T_ = ' ' "+CRLF

cQuery +=   " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery +=   " ON P0C.D_E_L_E_T_ = ' ' "+CRLF
cQuery +=   " AND P0C.P0C_FILIAL = '"+xFilial("P0C")+"' "+CRLF
cQuery +=   " AND P0C.P0C_PPPUB = PZC.PZC_PPPUB "+CRLF

cQuery    += " WHERE SE1.D_E_L_E_T_ = ' '  "+CRLF
cQuery    += " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery    += " AND SE1.E1_NUM = '"+cTitulo+"' "+CRLF
cQuery    += " AND SE1.E1_PARCELA = '"+cParcela+"' " +CRLF
cQuery    += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery    += " GROUP BY PZC_PPPUB, PZC_PUBLIS, PZC_CODPP, E1_CLIENTE, E1_LOJA, A1_NOME, PZD_TPREP, E1_PREFIXO, E1_NUM, E1_TIPO, E1_PARCELA, P0C_PUBLIS "

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("PZ5")
DbSetOrder(1)

(cArqTmp)->(DbGoTop())
If (cArqTmp)->(!Eof())

	PZ5->(RECLOCK("PZ5",.T.)	)
	PZ5->PZ5_FILIAL := xFilial("PZ5")
	PZ5->PZ5_NUMSEQ := cNumSeq
	PZ5->PZ5_PPPUB	:= (cArqTmp)->PZC_PPPUB
	PZ5->PZ5_CODPUB	:= (cArqTmp)->P0C_PUBLIS
	PZ5->PZ5_DPUBLI	:= (cArqTmp)->PZC_PUBLIS
	PZ5->PZ5_CODPP	:= (cArqTmp)->PZC_CODPP
	PZ5->PZ5_CLIENT	:= (cArqTmp)->E1_CLIENTE
	PZ5->PZ5_LOJA	:= (cArqTmp)->E1_LOJA
	//PZ5->PZ5_NOMCLI	:= (cArqTmp)->A1_NOME
	PZ5->PZ5_VALPP	:= (cArqTmp)->PZD_TOTPUB
	PZ5->PZ5_VALNCC	:= (cArqTmp)->PZD_TOTREP
	PZ5->PZ5_VALUSA	:= 0
	PZ5->PZ5_VALSLD	:= (cArqTmp)->PZD_TOTREP
	PZ5->PZ5_PREFIX	:= (cArqTmp)->E1_PREFIXO
	PZ5->PZ5_TITULO	:= (cArqTmp)->E1_NUM
	PZ5->PZ5_PARCEL	:= (cArqTmp)->E1_PARCELA
	PZ5->PZ5_TIPO 	:= (cArqTmp)->E1_TIPO        
	PZ5->PZ5_TIPOPC := (cArqTmp)->PZD_TPREP
	PZ5->PZ5_VERBPU	:= "2"
	PZ5->PZ5_DTEMIS	:= MsDate()
	PZ5->PZ5_USER	:= cUserName
	PZ5->PZ5_DTUALT	:= MsDate()
	PZ5->PZ5_TIME	:= Time()
	PZ5->PZ5_STATUS	:= "1"//N�o Aplicado
	PZ5->(MsUnLock())
                                                        
Else                  

	lRet := .F.
	Aviso("NOGRV","N�o existe dados a serem gravados na tabela PZ5-Controle de Repasse",{"Ok"},2)

EndIf


(cArqTmp)->(DbCloseArea())
ConfirmSX8()

RestArea(aArea)
Return lRet

/*
����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldRepCli	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe repasse para algum cliente				  ���
���          �             												  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldRepCli(cCodPP)

Local aArea 	:= GetArea()
Local lRet 		:= .T. 
Local cArqTmp   := GetNextAlias()    
Local cQuery 	:= ""
Local cCliente		:= U_MyNewSX6("NC_CMVGCLI",;
									"000001",;
									"C",;
									"C�digo do cliente NC Games",;
									"C�digo do cliente NC Games",;
									"C�digo do cliente NC Games",;
									.F. )
									
Local cLojaCli		:= U_MyNewSX6("NC_CMVGLJ",;
									"01",;
									"C",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									.F. )


Default cCodPP := ""

cQuery 	:= " SELECT * FROM "+RetSqlName("PZD")+CRLF

cQuery 	+= " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery 	+= " AND PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery 	+= " AND PZD_CODPP = '"+cCodPP+"' "+CRLF 
cQuery 	+= " AND ((PZD_CLIENT || PZD_LOJA) != '"+cCliente+cLojaCli+"' ) "

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
����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SelCliNCC	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Seleciona os clientes listados no documento do PP			  ���
���          �             												  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SelCliNCC(cCodPP)
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
									"C�digo do cliente NC Games",;
									"C�digo do cliente NC Games",;
									"C�digo do cliente NC Games",;
									.F. )
									
Local cLojaCli		:= U_MyNewSX6("NC_CMVGLJ",;
									"01",;
									"C",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									.F. )
									

Private cMarca  := GetMark()  // Essa vari�vel n�o pode ter outro nome

Default cCodPP := ""

AADD(alColuns,{"OK"			,,""			,""})
aAdd(alColuns,{"PZD_CODPP" 	,,"Cod. PP" 		,""})
aAdd(alColuns,{"PZD_CLIENT" ,,"Cod. Cliente",""})
aAdd(alColuns,{"PZD_LOJA" 	,,"Loja"		,""})
aAdd(alColuns,{"PZD_NOME" 	,,"Nome"		,""})
aAdd(alColuns,{"PZD_TOTREP"	,,"Valor Repasse","@E 999,999,999,999.99"})


clSql := " SELECT '  ' OK, PZD_CODPP, PZD_CLIENT, PZD_LOJA, PZD_NOME, SUM(PZD_TOTREP) PZD_TOTREP FROM "+RetSqlName("PZD")+" PZD "+CRLF

clSql += " INNER JOIN "+RetSqlName("PZC")+" PZC "+CRLF
clSql += " ON PZC.PZC_FILIAL = '"+xFilial("PZC")+"' "+CRLF
clSql += " AND PZC.PZC_CODPP = PZD.PZD_CODPP "+CRLF
clSql += " AND PZC.PZC_DTEFET != ' ' " +CRLF
clSql += " AND PZC.D_E_L_E_T_ = ' ' "+CRLF

clSql += " WHERE PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
clSql += " AND PZD.PZD_CODPP = '"+cCodPP+"' "+CRLF
clSql += " AND NOT EXISTS (SELECT * FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF
clSql += "                   WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
clSql += "                   AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
clSql += "                   AND PZ5.PZ5_CODPP = PZD.PZD_CODPP "+CRLF
clSql += "                   AND (PZ5.PZ5_CLIENT = PZD.PZD_CLIENT AND PZ5.PZ5_LOJA = PZD.PZD_LOJA) "+CRLF
clSql += "                   ) "+CRLF
clSql += " AND 	PZD.D_E_L_E_T_ = ' ' "+CRLF
clSql += " 	GROUP BY PZD_CODPP, PZD_CLIENT, PZD_LOJA, PZD_NOME "+CRLF

clSql := ChangeQuery(clSql)
                                            
DbUseArea(.T.,"TOPCONN",TCGENQRY(,,clSql),clAliasB, .F., .T.)

DbSelectArea(clAliasB)                  

Copy To &clTmp

(clAliasB)->(DbCloseArea())

DbUseArea(.T.,,clTmp,clAlias,.T.,.F.)

(clAlias)->(DbGoTop())

If (clAlias)->(!Eof())
	
	DEFINE MSDIALOG _oDlg TITLE "Sele��o de Clientes (Sem NCC Gerada)" FROM 001,001 TO 385,700 PIXEL of oMainWnd
	
	@ 15, 07 COMBOBOX oComb VAR clResult ITEMS {"1-Codigo","2-Descri��o"} SIZE 53, 38 OF _oDlg PIXEL
	@ 15, 60 MSGET clPesq SIZE	80, 9 OF _oDlg PIXEL
	@ 15, 140 BUTTON "Pesquisar" SIZE 030,011 ACTION {|| GetPesq(Iif(Alltrim(SUBSTRING(clResult,1,1)) == "1","PZD_CLIENT","A1_NOME"),clAlias ,clPesq), olMark:OBROWSE:Refresh()} PIXEL OF _oDlg
	
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
				Aadd(aRet, {(clAlias)->PZD_CLIENT, (clAlias)->PZD_LOJA, (clAlias)->PZD_NOME} )
			EndIf
			
			(clAlias)->(DbSkip())
		EndDo
		
	EndIf
	
Else
	aRet := {}
EndIf

//Fecha a area ap�s a sele��o
(clAlias)->(DbCloseArea())

RestArea(aArea)
Return aRet


/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������͹��
���Programa    �MarkTodos| Marca/Desmarca todos os itens da msselect                      ���
�����������������������������������������������������������������������������������������͹��
���Autor       �18.110.11� Elton C.				                                          ���
�����������������������������������������������������������������������������������������͹��
���Par�metros  �ExpC1 - Nome do grupo de perguntas                                        ���
�����������������������������������������������������������������������������������������͹��
���Observa��es �                                                                          ���
�����������������������������������������������������������������������������������������͹��
�������������������������������������������������������������������������������������������*/

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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �GetPesq	   	   � Autor �Elton C.        � Data �18.10.11  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Posiciona no item pesquisado				 				  ���
���			 �															  ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
