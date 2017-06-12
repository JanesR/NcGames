#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

User Function J001TST()
cAcao:="GRAVA_PEDIDO_DESTINO"
//cAcao:="ESTORNA_LIBERACAO_DESTINO"

//StartJob("U_NCGJ001", GetEnvServer(), .F. , {"01", "03", "ESTORNA_LIBERACAO_DESTINO", .T.} )
U_NCGJ001( {"01", "03", cAcao, .T.})
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/26/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function J001Job()
Local aAcao:={"GRAVA_PEDIDO_DESTINO","ESTORNA_LIBERACAO_DESTINO","GRAVA_WMS_PEDIDO"}
Local nInd


For nInd:=1 To Len(aAcao)
	U_NCGJ001( {"01", "03", aAcao[nInd], .T.})
Next

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGJ001(aDados)
Local nRecSM0
Local nHDL
Local aAreaAtu

Default aDados:={"01","03","",.T.}  //aDados:={"Empresa","Filial","Acao",lJob}

//ErrorBlock( { |oErro| J001Error(oErro) } )

If Empty(aDados[3])
	Return
EndIf

If !Semaforo(.T.,@nHDL,aDados[3])
	Return()
EndIf

If aDados[4]
	RpcSetEnv(aDados[1],aDados[2])
EndIf

aAreaAtu	:=GetArea()
nRecSM0 	:=SM0->(Recno())


J001GRAVA(aDados[3])

Semaforo(.F.,@nHDL,aDados[3])
SM0->(DbGoTo(nRecSM0))
cFilAnt:=SM0->M0_CODFIL


If aDados[3]=="GRAVA_PEDIDO_DESTINO"
	StartJob("U_NCGJ001", GetEnvServer(), .F. , {cEmpAnt, cFilAnt, "GRAVA_WMS_PEDIDO", .T.} )
EndIf


RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/07/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function J001GRAVA(cAcao)
Local cQuery	:=""
Local clAlias	:=GetNextAlias()
Local aItemLib	:={}
Local aCabec 	:= {}
Local aItens 	:= {}
Local cProdSoft
Local cItemSoftPV
Local cMvTES	:=Alltrim(U_MyNewSX6(	"NCG_100004","998"	   ,"C","TES do Pedido de Transferencia","TES do Pedido de Transferencia","TES do Pedido de Transferencia",.F. ))
Local cMvTESSoft:=Alltrim(U_MyNewSX6(	"NCG_100009","997"	   ,"C","TES do Software no Pedido de Transferencia","TES do Software no Pedido de Transferencia","TES do Software no Pedido de Transferencia",.F. ))
Local cClientePV:=Alltrim(U_MyNewSX6(	"NCG_100006","000001"   ,"C","Cliente do Pedido de Transferencia","Cliente do Pedido de Transferencia","Cliente do Pedido de Transferencia",.F. ))
Local cLojaPV	:=Alltrim(U_MyNewSX6(	"NCG_100007","28"	   ,"C","Loja do Cliente do Pedido de Transferencia","Loja do Cliente do Pedido de Transferencia","Loja do Cliente do Pedido de Transferencia",.F. ))
Local cCondPV	:=Alltrim(U_MyNewSX6(	"NCG_100008","175"	   ,"C","Condicao de pagamento do Pedido de Transferencia","Condicao de pagamento do Pedido de Transferencia","Condicao de pagamento do Pedido de Transferencia",.F. ))
Local cFilMDSW	:=Alltrim(U_MyNewSX6(	"NCG_100002","05","C","Filiais que realizam o tratamento de mํdia e software","Filiais que realizam o tratamento de mํdia e software","Filiais que realizam o tratamento de mํdia e software",.F. ))
Local lSplit
Local nInd
Local lSemEstoque


Private lMsErroAuto := .F.


If cAcao=="GRAVA_PEDIDO_DESTINO"
	
	
	cQuery:=" Select R_E_C_N_O_ RecPZ1 "
	cQuery+=" From "+RetSqlName("PZ1")+" PZ1 "
	cQuery+=" Where	PZ1.PZ1_FILIAL='"+xFilial("PZ1")+"'"
	cQuery+=" And PZ1.PZ1_PVORIG<>' '"
	cQuery+=" And PZ1.PZ1_PVDEST=' '"
	cQuery+=" And PZ1.PZ1_EXCLUI<>'S'"
	cQuery+=" And PZ1.D_E_L_E_T_=' '"
	cQuery+=" Order By PZ1.PZ1_FILORI "
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
	SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	
	Do While (clAlias)->(!Eof())
		PZ1->(DbGoTo( (clAlias)->RecPZ1 ))
		
		U_J001PosSM0( PZ1->PZ1_FILORI )
		cFilSC5:=xFilial("SC5")
		cFilSC6:=xFilial("SC6")
		
		If !SC5->( DbSeek(cFilSC5+ PZ1->PZ1_PVORIG ))
			(clAlias)->(DbSkip());Loop
		EndIf
		nRecSC5:=SC5->(Recno())
		
		If !SC6->( DbSeek(cFilSC6+ SC5->C5_NUM ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		lSemEstoque:=.F.
		Begin Transaction
		J001PV(cAcao,@lSemEstoque)
		End Transaction
		If lSemEstoque
			U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,cAcao,"Produto(s) no Pedido de Venda sem Estoque",.T.)
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
ElseIf cAcao=="ESTORNA_LIBERACAO_DESTINO"
	
	cQuery:=" Select R_E_C_N_O_ RecPZ1 "
	cQuery+=" From "+RetSqlName("PZ1")+" PZ1 "
	cQuery+=" Where	PZ1.PZ1_FILIAL='"+xFilial("PZ1")+"'"
	cQuery+=" And PZ1.PZ1_EXCLUI='S'"
	cQuery+=" And PZ1.PZ1_DTEXCL=' '"
	cQuery+=" And PZ1.D_E_L_E_T_=' '"
	cQuery+=" Order By PZ1.PZ1_FILORI "
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
	SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
	
	Do While (clAlias)->(!Eof())
		
		PZ1->(DbGoTo( (clAlias)->RecPZ1 ))
		
		U_J001PosSM0( PZ1->PZ1_FILDEST )
		cFilSC5:=xFilial("SC5")
		cFilSC6:=xFilial("SC6")
		cFilSC9:=xFilial("SC9")
		
		If !SC5->( DbSeek(cFilSC5+ PZ1->PZ1_PVDEST ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		If !SC6->( DbSeek(cFilSC6+ SC5->C5_NUM ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		SC9->( DbSeek(cFilSC9+ SC5->C5_NUM ))
		Do While SC9->(!Eof() )  .And. SC9->(C9_FILIAL+C9_PEDIDO == cFilSC9+ SC5->C5_NUM )
			//If ( SC9->C9_BLCRED <> "10"  .And. SC9->C9_BLEST <> "10" .And. SC9->C9_BLCRED <> "ZZ"  .And. SC9->C9_BLEST <> "ZZ" .And. SC9->C9_BLWMS <> "02" )
			SC9->(a460Estorna(.T.))
			//EndIf
			SC9->(dbSkip())
		EndDo
		
		aCabec := {}
		aItens := {}
		
		aadd(aCabec,{"C5_NUM"   	,SC5->C5_NUM,Nil})
		aadd(aCabec,{"C5_TIPO" 	  	,SC5->C5_TIPO,Nil})
		aadd(aCabec,{"C5_XSTAPED" 	,SC5->C5_XSTAPED,Nil})
		
		aadd(aCabec,{"C5_CLIENTE"	,SC5->C5_CLIENTE,Nil})
		aadd(aCabec,{"C5_LOJACLI"	,SC5->C5_LOJACLI,Nil})
		aadd(aCabec,{"C5_LOJAENT"	,SC5->C5_LOJAENT,Nil})
		aadd(aCabec,{"C5_CONDPAG"	,SC5->C5_CONDPAG,Nil})
		
		
		Do While SC6->(!Eof() ) .And. SC6->( C6_FILIAL+C6_NUM==cFilSC6+ SC5->C5_NUM )
			aLinha := {}
			aadd(aLinha,{"C6_ITEM"		,SC6->C6_ITEM,Nil})
			aadd(aLinha,{"C6_PRODUTO"	,SC6->C6_PRODUTO,Nil})
			aadd(aLinha,{"C6_QTDVEN"	,SC6->C6_QTDVEN,Nil})
			aadd(aLinha,{"C6_PRCVEN"	,SC6->C6_PRCVEN,Nil})
			aadd(aLinha,{"C6_PRUNIT"	,SC6->C6_PRUNIT,Nil})
			aadd(aLinha,{"C6_VALOR"		,SC6->C6_VALOR,Nil})
			aadd(aLinha,{"C6_TES"		,SC6->C6_TES,Nil})
			aadd(aItens,aLinha)
			SC6->(DbSkip())
		EndDo
		
		U_J001PosSM0( PZ1->PZ1_FILDES)
		lMsErroAuto := .F.
		MATA410(aCabec,aItens,5)
		cMsg :="Tarefa Executada com Sucesso"
		If lMsErroAuto
			cMsg := MemoRead(NomeAutoLog())
		Else
			PZ1->(DbGoTo( (clAlias)->RecPZ1 ))
			
			If PZ1->PZ1_EXCLPV=="S"
				U_J001PosSM0( PZ1->PZ1_FILORI)
				If SC5->( DbSeek(xFilial("SC5")+ PZ1->PZ1_PVORIG ))
					SC9->( DbSeek(xFilial("SC9")+ SC5->C5_NUM ))
					Do While SC9->(!Eof() )  .And. SC9->(C9_FILIAL+C9_PEDIDO == xFilial("SC9")+ SC5->C5_NUM )
						//If ( SC9->C9_BLCRED <> "10"  .And. SC9->C9_BLEST <> "10" .And. SC9->C9_BLCRED <> "ZZ"  .And. SC9->C9_BLEST <> "ZZ" .And. SC9->C9_BLWMS <> "02" )
						SC9->(	a460Estorna(.T.))
						//EndIf
						SC9->(dbSkip())
					EndDo
				EndIf
			EndIf
			
			PZ1->(RecLock("PZ1",.F.))
			PZ1->PZ1_DTEXCL:=MsDate()
			PZ1->(MsUnLock())
			
		EndIf
		U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,cAcao,cMsg,lMsErroAuto)
		(clAlias)->(DbSkip())
	EndDo
ElseIf cAcao=="GRAVA_WMS_PEDIDO"
	
	cQuery:=" Select R_E_C_N_O_ RecPZ1 "
	cQuery+=" From "+RetSqlName("PZ1")+" PZ1 "
	cQuery+=" Where	PZ1.PZ1_FILIAL='"+xFilial("PZ1")+"'"
	cQuery+=" And PZ1.PZ1_PVORIG<>' '"
	cQuery+=" And PZ1.PZ1_PVDEST<>' '"
	cQuery+=" And PZ1.PZ1_DTWMS =' '"
	cQuery+=" And PZ1.PZ1_EXCLUI<>'S'"
	cQuery+=" And PZ1.D_E_L_E_T_=' '"
	cQuery+=" Order By PZ1.PZ1_FILORI "
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	
	SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
	SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
	
	
	Do While (clAlias)->(!Eof())
		
		PZ1->(DbGoTo( (clAlias)->RecPZ1 ))
		
		U_J001PosSM0( PZ1->PZ1_FILDEST )
		cFilSC5:=xFilial("SC5")
		cFilSC6:=xFilial("SC6")
		cFilSC9:=xFilial("SC9")
		
		If !SC5->( DbSeek(cFilSC5+ PZ1->PZ1_PVDEST ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		If !SC6->( DbSeek(cFilSC6+ SC5->C5_NUM ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		If !SC9->( DbSeek(cFilSC9+ SC5->C5_NUM ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		U_MT450FIM(SC5->C5_NUM)
		
		lBloqWMS:=.F.
		SC9->( DbSeek(cFilSC9+ SC5->C5_NUM ))
		Do While SC9->(!Eof() )  .And. SC9->(C9_FILIAL+C9_PEDIDO == cFilSC9+ SC5->C5_NUM )
			If SC9->C9_BLWMS=="02"
				lBloqWMS:=.T.
				Exit
			EndIf
			SC9->(dbSkip())
		EndDo
		If lBloqWMS
			PZ1->(DbGoTo( (clAlias)->RecPZ1 ))
			PZ1->(RecLock("PZ1",.F.))
			PZ1->PZ1_DTWMS:=MsDate()
			PZ1->(MsUnLock())
		EndIf
		
		cMsg :="Tarefa executada com Sucesso"
		U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,cAcao,"",!lBloqWMS)
		
		
		(clAlias)->(DbSkip())
	EndDo
	
	
EndIf

If Select(clAlias)>0
	(clAlias)->(DbCloseArea())
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+".LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function J001PosSM0(cSM0Fil)
SM0->(DbSetOrder(1))
SM0->(DbSeek(cEmpAnt+cSM0Fil))
cFilAnt:=SM0->M0_CODFIL
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/17/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function J001EstSoft(cPedido,cProdSoft,cItemSoftPV,lEstorna)
Local aAreaAtu:=GetArea()
Local aAreaSC9:=SC9->(GetArea())
Local cChaveSC9:=xFilial("SC9")+cPedido+cItemSoftPV

SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC9->(DbSeek(cChaveSC9) )
Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO+C9_ITEM)==cChaveSC9
	If cProdSoft==SC9->C9_PRODUTO
		If lEstorna
			SC9->(a460Estorna(.T.))
		Else
			SC9->(RecLock("SC9",.F.))
			SC9->C9_BLEST:="02"
			SC9->(MsUnLock())
		EndIf
		Exit
	EndIf
	SC9->(DbSkip())
EndDo

RestArea(aAreaSC9)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/26/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function J001PV(cAcao,lSemEstoque)
Local aCabec 	:= {}
Local aItens 	:= {}
Local cProdSoft
Local cItemSoftPV
Local cMvTES	:=Alltrim(U_MyNewSX6(	"NCG_100004","998"	   ,"C","TES do Pedido de Transferencia","TES do Pedido de Transferencia","TES do Pedido de Transferencia",.F. ))
Local cMvTESSoft:=Alltrim(U_MyNewSX6(	"NCG_100009","997"	   ,"C","TES do Software no Pedido de Transferencia","TES do Software no Pedido de Transferencia","TES do Software no Pedido de Transferencia",.F. ))
Local cClientePV:=Alltrim(U_MyNewSX6(	"NCG_100006","000001"   ,"C","Cliente do Pedido de Transferencia","Cliente do Pedido de Transferencia","Cliente do Pedido de Transferencia",.F. ))
Local cLojaPV	:=Alltrim(U_MyNewSX6(	"NCG_100007","28"	   ,"C","Loja do Cliente do Pedido de Transferencia","Loja do Cliente do Pedido de Transferencia","Loja do Cliente do Pedido de Transferencia",.F. ))
Local cCondPV	:=Alltrim(U_MyNewSX6(	"NCG_100008","175"	   ,"C","Condicao de pagamento do Pedido de Transferencia","Condicao de pagamento do Pedido de Transferencia","Condicao de pagamento do Pedido de Transferencia",.F. ))
Local cFilMDSW	:=Alltrim(U_MyNewSX6(	"NCG_100002","05","C","Filiais que realizam o tratamento de mํdia e software","Filiais que realizam o tratamento de mํdia e software","Filiais que realizam o tratamento de mํdia e software",.F. ))
Local lSplit
Local aCpoSC5   :=SC5->(DbStruct())
Local aCpoSC6   :=SC6->(DbStruct())
Local aCamposC6:={}
Local nInd

Private lMsErroAuto := .F.

U_J001PosSM0( PZ1->PZ1_FILDES)
cDoc := GetSxeNum("SC5","C5_NUM")
RollBAckSx8()

aCabec := {}
aItens := {}

aadd(aCabec,{"C5_NUM"   	,cDoc,Nil})
aadd(aCabec,{"C5_TIPO" 	  	,"N",Nil})
aadd(aCabec,{"C5_XSTAPED" 	,"15",Nil})

aadd(aCabec,{"C5_CLIENTE"	,cClientePV,Nil})
aadd(aCabec,{"C5_LOJACLI"	,cLojaPV,Nil})
aadd(aCabec,{"C5_CONDPAG"	,cCondPV,Nil})

aadd(aCabec,{"C5_YTRANS"	,"1",Nil})
aadd(aCabec,{"C5_YCHCROS"	,SC5->(cFilSC5+C5_NUM),Nil})

For nInd:=1 To Len(aCpoSC6)
	If !Left( aCpoSC6[nInd,1],4)=="C6_Y"
		Loop
	EndIf
	AAdd(aCamposC6,aCpoSC6[nInd,1] )
Next


/*For nInd:=1 To Len(aCpoSC5)
	If !Left( aCpoSC5[nInd,1],4)=="C5_Y" .Or. AllTrim(aCpoSC5[nInd,1])$"C5_YCHCROS*C5_YTRANS"
		Loop
	EndIf

	aadd(aCabec,{aCpoSC5[nInd,1],SC5->(  FieldGet(FieldPos( aCpoSC5[nInd,1])  )),Nil } )
Next
*/
lSplit	:= (PZ1->PZ1_FILORI $ cFilMDSW )
Do While SC6->(!Eof() ) .And. SC6->( C6_FILIAL+C6_NUM==cFilSC6+ SC5->C5_NUM )
	aLinha := {}
	
	cProdSCusto:=SC6->C6_PRODUTO
	
	If (lSoftWare:=U_M001IsSoftware(SC6->C6_PRODUTO))
		cProdSCusto:=U_M001GetMidia( SC6->C6_PRODUTO )
	EndIf
	
	nPrcVen:=1
	If SB2->(DbSeek(xFilial("SB2")+cProdSCusto+SC6->C6_LOCAL))
		nPrcVen:=SB2->B2_CM1
	EndIf
	
	J001ICMS(@nPrcVen,SC6->C6_PRODUTO)
	
	If lSplit .And. (nVlrMDSO:=SC6->C6_YPRMDSO) >0
		nPrcVen*=SC6->C6_PRCVEN/nVlrMDSO
	EndIf
	
	nPrcVen:=A410Arred(nPrcVen,"C6_VALOR")
	
	aadd(aLinha,{"C6_ITEM"		,SC6->C6_ITEM,Nil})
	aadd(aLinha,{"C6_PRODUTO"	,SC6->C6_PRODUTO,  })
	aadd(aLinha,{"C6_QTDVEN"	,SC6->C6_QTDVEN,Nil})
	aadd(aLinha,{"C6_LOCAL"		,SC6->C6_LOCAL,Nil})	
	aadd(aLinha,{"C6_PRCVEN"	,nPrcVen,Nil})
	aadd(aLinha,{"C6_PRUNIT"	,nPrcVen,Nil})
	aadd(aLinha,{"C6_OPER"		,"F",Nil})
	aadd(aLinha,{"C6_TES"		,Iif(lSoftWare,cMvTESSoft,cMvTES),Nil})
	aadd(aLinha,{"C6_YMIDPAI"	,SC6->C6_YMIDPAI,Nil})
	
	//For nInd:=1 To Len(aCamposC6)		
	  	//aadd(aLinha,{aCamposC6[nInd],SC6->(  FieldGet(FieldPos( aCamposC6[nInd])  )),Nil } )
	//Next
	
	aadd(aItens,aLinha)
	SC6->(DbSkip())
EndDo

U_J001PosSM0( PZ1->PZ1_FILDES)
lMsErroAuto := .F.

MATA410(aCabec,aItens,3)

cMsg :="Tarefa executada com Sucesso"
If lMsErroAuto
	cMsg := MemoRead(NomeAutoLog())
Else
	SC5->(MaLiberOk( {C5_NUM} ))
	SC5->(RecLock("SC5",.F.))
	SC5->C5_LIBEROK:= "S"
	SC5->C5_BLQ	   :=""
	SC5->(MsUnLock())
	SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM ))
	aItemLib:={}
	lTemSC9:=.F.
	aSoftEst:={}
	Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==xFilial("SC6")+SC5->C5_NUM
		lCredito:=.T.
		lEstoque:=.T.
		If MaLibDoFat(SC6->(Recno()),SC6->C6_QTDVEN,lCredito,@lEstoque,.F.,.T.,.T.)>0
			If lEstoque
				SC9->(AADD(aItemLib,{C9_QTDLIB,C9_ITEM,C9_SEQUEN,C9_PRODUTO}  ))
				lTemSC9:=.T.
			Else
				SC6->(AADD(aItemLib,{0,C6_ITEM,"00",C6_PRODUTO}  ))
				If Left(SC6->C6_YMIDPAI,2)=="MD" .And. !Empty(	cProdSoft	:=U_M001GetSoftware( SC6->C6_PRODUTO ) )
					cItemSoftPV :=Trim(Substr(SC6->C6_YMIDPAI,3))
					AADD(aSoftEst,{cItemSoftPV,cProdSoft}  )
					SC9->(a460Estorna(.T.))
				EndIf
				
			EndIf
		EndIf
		SC6->(DbSkip())
	EndDo
	
	If !lTemSC9
		lSemEstoque:=.T.
		DisarmTransaction()
		Break
	EndIf
	
	SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
	cChaveSC9:=xFilial("SC9")+SC5->C5_NUM
	SC9->(DbSeek(cChaveSC9) )
	Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==cChaveSC9
		If  (Ascan(aSoftEst,{|a| a[1]==SC9->C9_ITEM .And. a[2]==SC9->C9_PRODUTO  }))>0
			SC9->(a460Estorna(.T.))
		EndIf
		SC9->(DbSkip())
	EndDo
	
	PZ1->(RecLock("PZ1",.F.))
	PZ1->PZ1_PVDEST:=SC5->C5_NUM
	PZ1->PZ1_CLIDES:=SC5->C5_CLIENTE
	PZ1->PZ1_LJDEST:=SC5->C5_LOJACLI
	PZ1->(MsUnLock())
	
	SC5->(DbGoTo( nRecSC5 ))
	SC5->(RecLock("SC5",.F.))
	SC5->C5_YCHCROS:=PZ1->(PZ1_FILDES+PZ1_PVDEST)
	SC5->(MsUnLock())
	
	U_J001PosSM0( PZ1->PZ1_FILORI )
	SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
	
	For nInd:=1 To Len(aItemLib)
		
		cChaveSC9:=xFilial("SC9")+PZ1->PZ1_PVORIG+aItemLib[nInd,2]
		If !SC9->(DbSeek(cChaveSC9) )
			Loop
		EndIf
		
		Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO+C9_ITEM)==cChaveSC9
			If aItemLib[nInd,4]	==SC9->C9_PRODUTO
				SC9->(RecLock("SC9",.F.))
				If aItemLib[nInd,1]>0
					SC9->C9_QTDLIB:=aItemLib[nInd,1]
				Else
					If SC6->(DbSeek(xFilial("SC6")+SC9->(C9_PEDIDO+C9_ITEM+C9_PRODUTO) )) .And. Left(SC6->C6_YMIDPAI,2)=="MD"
						cProdSoft	:=U_M001GetSoftware( SC9->C9_PRODUTO )
						cItemSoftPV :=Trim(Substr(SC6->C6_YMIDPAI,3))
					EndIf
					If SC9->(a460Estorna(.T.)) .And. !Empty(cProdSoft) .And. !Empty(cItemSoftPV)
						J001EstSoft(SC9->C9_PEDIDO,cProdSoft,cItemSoftPV,.T.) //Estorna o Software Correspondente
					EndIf
				EndIf
			EndIf
			SC9->(MsUnLock())
			SC9->(DbSkip())
		EndDo
	Next
	
	U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,cAcao,cMsg,lMsErroAuto)
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/28/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function J001ICMS(nValor,cProduto)
Local cOrigem:=Posicione("SB1",1,xFilial("SB1")+cProduto,"B1_ORIGEM")
Local nIcms:=12

If cOrigem$ "1/2/3"
	nIcms:=4
EndIf                                      

//nValor:= nValor*((100-nIcms)/100) //alterado em 13/03/2014
nValor:= nValor/(1-(nIcms/100))

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGJ001   บAutor  ณMicrosiga           บ Data ณ  09/27/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function J001Error(oErro)
U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,"",oErro:ErrorStack,.T.)

Return
