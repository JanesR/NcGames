#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"

Static lJaZerado:=.F.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  12/14/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPR107()
Local aAreaSC5:=SC5->(GetArea())

A410Altera("SC5",SC5->(Recno()),4)
RestArea(aAreaSC5)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  12/14/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107VAL()
Local aAreaAtu	:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local aAreaSA3	:= SA3->(GetArea())
Local aAreaSE4	:= SE4->(GetArea())
Local lRetorno 	:= .T.
Local aDados
Local clAlias	:= GetNextAlias()
Local lLibWMS	:= IsInCallStack("U_INTPEDVEN")//Verifica se foi chamado pela integracao do WMS
Local lGrvNota	:= (IsInCallStack("U_PR170NOTA").Or.IsInCallStack("U_PR170BNOT"))  //Verifica se foi chamado pela Gravaçcao da Margem na Nota Fiscal
Local lPV_EDI	:= IsInCallStack("U_KZNCG11")//Pedidos de Venda originario do EDI
Local lPV_Portal:= IsInCallStack("PUTSALESORDER")//Pedidos de Venda originario do Portal
Local lPvSimul	:= IsInCallStack("U_PR107PVSIMUL")
Local lTabPromo	:= IsInCallStack("PR107HTMPROMO")
Local cFilMDSW	:= U_MyNewSX6("NCG_100002",;
"05",;
"C",;
"Filiais que realizam o tratamento de m¡dia e software",;
"Filiais que realizam o tratamento de m¡dia e software",;
"Filiais que realizam o tratamento de m¡dia e software",;
.F. )
Local lSplit:= (cFilAnt $ cFilMDSW .and. M->C5_TIPO == "N")


U_NCGPR708()
Return



Private lTemCelular	:=PR107CELU()
Private lCpoTran	:=SC5->(FieldPos("C5_YPFRTRA"))>0

If IsInCallStack("J001PV")
	Return lRetorno
EndIf

If lPV_EDI .Or. lPV_Portal
	M->C5_XSTAPED:="15"
EndIf


If lPvSimul
	M->C5_YORIGEM:="SIMULAR"
EndIf

If !( lLibWMS .Or. lGrvNota .Or. lTabPromo )
	
	If (M->C5_TIPO $ "B/D") .Or. !(INCLUI .Or. ALTERA)
		Return lRetorno
	EndIf
	
	If __ReadVar=="M->C5_YCONDPG"
		SE4->(DbSetOrder(1))
		SE4->(DbSeek(xFilial("SE4")+M->C5_YCONDPG))
		M->C5_YDESFIN:=(SE4->E4_YDESCFI)
		Return .T.
	ElseIf  __ReadVar=="M->C5_YTIPACO"  .And. Empty(M->C5_YACORDO)
		Return .T.
	EndIf
	
	
	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+M->C5_CLIENT+M->C5_LOJACLI))
	
	
	If !lTemCelular .And. Empty(M->C5_YPERTRA)
		M->C5_YPERTRA:=SA1->A1_YTRDMKT//Trade Market
	EndIf
	
	If !lTemCelular .And. Empty(M->C5_YPERMKT)
		M->C5_YPERMKT:=SA1->A1_YDESMKT//Mkt Instituc
	EndIf
	
	
	SE4->(DbSeek(xFilial("SE4")+M->C5_CONDPAG))
	M->C5_YCONDPG:=M->C5_CONDPAG
	M->C5_YDESFIN:=SE4->E4_YDESCFI
	
	If !lTemCelular
		If Empty(M->C5_YACORDO)  .And. ( M->C5_XSTAPED<>"00" .Or. lPvSimul)
			U_SQLVPCCTS(clAlias, M->C5_CLIENT, M->C5_LOJACLI, M->C5_EMISSAO,"1",.T.,.F.,.T.)
			P01->(DbSetOrder(1))
			Do While (clAlias)->(!Eof())
				P01->(DbSeek( xFilial("P01")+(clAlias)->(P01_CODIGO+P01_VERSAO)   ))
				M->C5_YPANUAL:=P01->P01_VPCANU
				If P01->P01_TPCAD =="1"  .And. P01->P01_REPASS=="1"
					M->C5_YACORDO :=P01->P01_TOTPER
					M->C5_YTIPACO :=P01->P01_TPFAT
					M->C5_YVPCCR :=P01->P01_CODIGO
					M->C5_YVPCCRV:=P01->P01_VERSAO
					M->C5_YDVPCCR:=P01->P01_DESC
					Exit
				EndIf
				(clAlias)->(DbSkip())
			EndDo
			(clAlias)->(DbCloseArea())
		Endif
	EndIf
	M->C5_YPVPCCR:=M->C5_YACORDO
	
	If Empty(M->C5_YVERBA) .And. (M->C5_XSTAPED<>"00".Or. lPvSimul)
		U_SQLVPCCTS(clAlias, M->C5_CLIENT, M->C5_LOJACLI, M->C5_EMISSAO,"2",.T.,.F.,.T.)
		P01->(DbSetOrder(1))
		Do While (clAlias)->(!Eof())
			P01->(DbSeek( xFilial("P01")+(clAlias)->(P01_CODIGO+P01_VERSAO)   ))
			If P01->P01_FILPED=xFilial("SC5")  .And. P01->P01_PEDVEN==M->C5_NUM
				M->C5_YVERBA :=P01->P01_TOTVAL
				M->C5_YVECRCO:=P01->P01_CODIGO
				M->C5_YVECRVE:=P01->P01_VERSAO
				M->C5_YDVECR :=P01->P01_DESC
				Exit
			EndIf
			(clAlias)->(DbSkip())
		EndDo
		(clAlias)->(DbCloseArea())
	EndIf
	M->C5_YVVECR:=M->C5_YVERBA
	
	
	M->C5_YCOMISS :=M->C5_COMIS1//Comiss Repres
EndIf

If lPV_EDI  .And.  M->C5_CLIENTE$ Alltrim(SuperGetMv("NCG_000041",.t.,""))
	
	M->C5_YDESC2  	:=0
	
	If !lTemCelular
		aVPC := U_PERDESCVPC(M->C5_CLIENTE,M->C5_LOJACLI,DtoS(M->C5_EMISSAO),M->C5_YCODVPC,M->C5_YVERVPC,3)
	EndIf
	
	If Len(aVPC) > 0
		M->C5_YCODVPC	:= aVPC[1]
		M->C5_YVERVPC	:= aVPC[2]
		//M->C5_DESC2  	:= aVPC[3]
		M->C5_YDVPCPV   :=Posicione("P01",1,xFilial("P01")+M->(C5_YCODVPC+C5_YVERVPC),"P01_DESC")
		Eval ( MemVarBlock("C5_DESC2"),aVPC[3])
		M->C5_YDESC2  	:=aVPC[3]
	EndIf
EndIf
Processa( {|| PR107Simul(lLibWMS,lPV_EDI,lPvSimul,lSplit,lGrvNota,lTabPromo) })

RestArea(aAreaSA1)
RestArea(aAreaSA3)
RestArea(aAreaSE4)
RestArea(aAreaAtu)
Return lRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  12/15/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR107Simul(lLibWMS,lPV_EDI,lPvSimul,lSplit,lGrvNota,lTabPromo)
Local lGravaPromo:=IsInCallStack("U_PR170GrvPromo")
Local nTotalPV :=0
Local nQtdVen  :=0
Local aTransp:={"",""}
Local nInd
Local cProduto
Local cArmazem
Local nPosComiss:=GdFieldPos('C6_YVLCOMI')
Local nValIPI:=0
Local nValSOL:=0
Local nValICM:=0
Local nValPIS:=0
Local nValCOF:=0
Local nAliqIPI:=0
Local nAliqSOL:=0
Local nAliqICM:=0
Local nAliqPIS:=0
Local nAliqCOF:=0
Local nPrcVen
Local nCusto
Local nContar:=0
Local nTotLinha
Local nCustBoleto:= GetMV("NCG_000029",NIL,5)
Local aItemOrig:={}
Local nQuantPV:=0
Local nFator
Local nContLinha:=0
Local nPosVcpAnual:=GdFieldPos('C6_YVANUAL')
Local cProdEsp 	:= SuperGetMv("NCG_000049",.t.,"")
Local cProdEsp1	:= Alltrim(U_MyNewSX6("NCG_000050","","C","Produto Exceção Adicional ao NCG_000049 ","Produto Exceção Adicional ao NCG_000049","",.F. )   )
Local cProd1Esp	:= Alltrim(U_MyNewSX6("NCG_000051","","C","Produto Exceção ","Produto Exceção  ","Produto Exceção  ",.F. )   )
Local lProdExc
Local lProd1Ex
Local cGerarPV	:= Alltrim(U_MyNewSX6(	"NCG_100000","S"		,"C","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz",.F. ))
Local cFilPV	:= Alltrim(U_MyNewSX6(	"NCG_100001","04;05"	,"C","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia",.F. ))
Local cFilDest	:= Alltrim(U_MyNewSX6(	"NCG_100003","03"	   ,"C","Filial Destino PV Transferencia","Filial Destino PV Transferencia","Filial Destino PV Transferencia",.F. ))
Local cFilSB2	:=xFilial("SB2")
Local lVendaVista:=IsInCallStack("U_NC110Mail")

Local nAliqLim		:= Alltrim(U_MyNewSX6("NCG_000076",1.1,"n","Aliquota de ICMS para Filial 06(liminar) ","","",.F. ))  //Liminar de ICMS Espirito Santo(Compete)

If cGerarPV=="S"  .And. (cFilAnt$cFilPV)
	cFilSB2:=cFilDest
EndIf
SA4->(dbSetOrder(1))
If SA4->(dbSeek(xFilial("SA4")+Iif(lGrvNota,SF2->F2_TRANSP,M->C5_TRANSP)))
	aTransp[01] := SA4->A4_EST
	aTransp[02] := Iif(SA4->(FieldPos("A4_TPTRANS")) > 0,SA4->A4_TPTRANS,"")
Endif

If !lGrvNota
	MaFisSave()
	
	MaFisIni(Iif(Empty(M->C5_CLIENT),M->C5_CLIENTE,M->C5_CLIENT),;	// 1-Codigo Cliente/Fornecedor
	M->C5_LOJAENT,;	   												// 2-Loja do Cliente/Fornecedor
	IIf(M->C5_TIPO$'DB',"F","C"),;									// 3-C:Cliente , F:Fornecedor
	M->C5_TIPO,;			   										// 4-Tipo da NF
	M->C5_TIPOCLI,;	   												// 5-Tipo do Cliente/Fornecedor
	Nil,;
	Nil,;
	Nil,;
	Nil,;
	"MATA461")
EndIf

SB2->(DbSetOrder(1)) //B2_FILIAL+B2_COD+B2_LOCAL

If lSplit
	aColsAtu:=aClone(aCols)
	U_A002IniaCols()
	U_GA002Split()
	aCols:=U_A002RetaCols()
EndIf

nTotLinha:=Len(aCols)
ProcRegua(nTotLinha*2)

For nInd:=1 To nTotLinha
	
	If lLibWMS
		IncProc("Verificando Margem após Liberaçao")
	Else
		IncProc("Simulando...")
	Endif
	
	If GdDeleted( nInd)
		Loop
	Endif
	
	nQuantPV:=GdFieldGet( "C6_QTDVEN", nInd)
	lSoftware:=U_M001IsSoftware( GdFieldGet("C6_PRODUTO", nInd) )
	
	If !lSoftware .Or. !lGrvNota
		
		SB2->(DbSeek(cFilSB2+GdFieldGet("C6_PRODUTO", nInd)+GdFieldGet("C6_LOCAL", nInd)     )  )
		GdFieldPut('C6_YESTOQU',SB2->(B2_QATU-B2_RESERVA),nInd)
	EndIf
	
	
	If !lSoftware .And. AVALTES(GdFieldGet("C6_TES",nInd),,'N')
		Loop
	EndIf
	
	If !Empty(GdFieldGet( "C6_PRODUTO", nInd))
		nContLinha++
	EndIf
	
	
	If lLibWMS .Or. lGrvNota
		nQuantPV:= GdFieldGet( "C6_YQTDLIB", nInd)
	EndIf
	
	If lPV_EDI
		R107PVEDI(nInd,nQuantPV)
	EndIf
	
	cProdEsp	:= cProdEsp + ";" + cProdEsp1
	lProdExc	:= AllTrim(GdFieldGet('C6_PRODUTO',nInd))$cProdEsp
	lProd1Ex	:= AllTrim(GdFieldGet('C6_PRODUTO',nInd))$cProd1Esp
	
	If lPvSimul .Or. GdFieldGet('C6_YESTOQU',nInd)>0 .Or. lProdExc .Or. lprod1Ex .Or. lGrvNota
		nTotalPV+= nQuantPV*GdFieldGet(Iif(lSplit,"C6_YPRMDSO","C6_PRCVEN"), nInd)
		nQtdVen	+= nQuantPV
	EndIf
	
	
	AADD(aItemOrig,{GdFieldGet( "C6_ITEM", nInd),++nContar,GdFieldGet( "C6_YMIDPAI", nInd),GdFieldGet( "C6_YITORIG", nInd) }  )
	
	If !lGrvNota
		MaFisAdd(GdFieldGet("C6_PRODUTO", nInd),;   	// 1-Codigo do Produto ( Obrigatorio )
		GdFieldGet("C6_TES", nInd),;	   				// 2-Codigo do TES ( Opcional )
		nQuantPV,;  									// 3-Quantidade ( Obrigatorio )
		GdFieldGet( "C6_PRCVEN", nInd),;		  		// 4-Preco Unitario ( Obrigatorio )
		0,; 											// 5-Valor do Desconto ( Opcional )
		"",;	   										// 6-Numero da NF Original ( Devolucao/Benef )
		"",;											// 7-Serie da NF Original ( Devolucao/Benef )
		"",;											// 8-RecNo da NF Original no arq SD1/SD2
		0,;												// 9-Valor do Frete do Item ( Opcional )
		0,;												// 10-Valor da Despesa do item ( Opcional )
		0,;												// 11-Valor do Seguro do item ( Opcional )
		0,;												// 12-Valor do Frete Autonomo ( Opcional )
		nQuantPV*GdFieldGet( "C6_PRCVEN", nInd),;		// 13-Valor da Mercadoria ( Obrigatorio )
		0,;												// 14-Valor da Embalagem ( Opiconal )
		,;												//
		,;												//
		GdFieldGet("C6_ITEM", nInd))
	EndIf
Next


If nContLinha==0
	
	If !lGrvNota
		MaFisRestore()
	EndIf
	Return
EndIf

If lSplit
	aColsSplit:=aClone(aCols)
	aCols:=aClone(aColsAtu)
EndIf

nTotLinha:=Len(aCols)
ProcRegua(nTotLinha*2)

nTotDesc:=0
If !lGrvNota .And. M->C5_DESCONT > 0
	MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nTotDesc+M->C5_DESCONT),/*nItem*/,/*lNoCabec*/,/*nItemNao*/,GetNewPar("MV_TPDPIND","1")=="2" )
EndIf

nTotDesp	:= 0
nCustoTot	:= 0
nTotC5Brut	:= 0
nTotBrut	:= 0
nTotImp		:= 0
nTotCMV		:= 0
nTotAux		:= 0
nValDesconto:= 0
nTotVlrOver	:= 0

aVencimento := Condicao(nTotalPV,IIf(lGrvNota,SF2->F2_COND,M->C5_YCONDPG),,dDataBase)
If !lLibWMS
	M->C5_YDESPES:=Len(aVencimento)*nCustBoleto
EndIf


If !lTabPromo
	If ValType(aVencimento)=="A" .And. Len(aVencimento)>0
		nSoma:=0
		For nInd:=1 To Len(aVencimento)
			nSoma+=( aVencimento[nInd,1] -dDataBase )
		Next
		
		nFator:=M->C5_YDESFIN/30
		
		M->C5_YDESFIN:= nFator*(nSoma/Len(aVencimento) )
	Else
		M->C5_YDESFIN:=0
	EndIf
EndIf

SA1->(dbSetOrder(1))
SA1->(dbSeek(xFilial("SA1")+M->C5_CLIENT+M->C5_LOJACLI)	)

If lGrvNota
	M->C5_YVLRIPI:=0
	M->C5_YVLRICR:=0
	M->C5_YVLRICM:=0
	M->C5_YVLRPIS:=0
	M->C5_YVLRCOF:=0
	M->C5_YVLRFIN:=0
Else
	M->C5_YPGFRET:=0
	M->C5_YVLRSEG:=0
	M->C5_YPFRETE:=0
	M->C5_YPSEGUR:=0
	M->C5_YVLRIPI:=0
	M->C5_YVLRICR:=0
	M->C5_YVLRICM:=0
	M->C5_YVLRPIS:=0
	M->C5_YVLRCOF:=0
	M->C5_YVLRFIN:=0
EndIf


If !lGrvNota .And. (nTotalPV>=GetNewPar("MV_VLMAXFR",0) .Or. !SA1->A1_FRETE=="1")
	U_P202CALCFRETE(.F.)
	If INCLUI .OR. lTabPromo
		M->C5_YPGFRET:=(M->C5_FREORTO-M->C5_SEGUROR)
		M->C5_YVLRSEG:=M->C5_SEGUROR
	EndIf
EndIf

If lCpoTran .And. cGerarPV=="S"  .And. (cFilAnt$cFilPV)
	PR107FrTrans(nTotalPV)//Calcula Frete Transferencia
EndIf


M->C5_YTOTLIQ:=0
M->C5_YPERLIQ:=0
M->C5_YVLRIPI:=0
M->C5_YVLRICR:=0
M->C5_YVLRICM:=0
M->C5_YVLRPIS:=0
M->C5_YVLRCOF:=0
M->C5_YVLRFIN:=0
M->C5_YMKTINS:=0
M->C5_YTRAMKT:=0
M->C5_YVLRCOM:=0
M->C5_YVLVPC :=0
M->C5_YVLVPCP:=0
M->C5_YVANUAL:=0



For nInd:=1 To nTotLinha
	
	If lLibWMS
		IncProc("Verificando Margem após Liberaçao")
	Else
		IncProc("Simulando...")
	Endif
	
	If GdDeleted( nInd)
		Loop
	Endif
	
	lSoftware:=U_M001IsSoftware( GdFieldGet("C6_PRODUTO", nInd) )
	
	If  !lSoftware .And.  AVALTES(GdFieldGet("C6_TES",nInd),,'N')
		Loop
	EndIf
	
	If !lSoftware
		SB2->(DbSeek(cFilSB2+GdFieldGet("C6_PRODUTO", nInd)+GdFieldGet("C6_LOCAL", nInd)     )  )
		GdFieldPut('C6_YESTOQU',SB2->(B2_QATU-B2_RESERVA),nInd)
		GdFieldPut('C6_YHCONSU', "Filial "+cFilSB2+":"+DTOC(dDataBase)+"-"+Time()  ,nInd)
	Else
		GdFieldPut('C6_YHCONSU', "Software",nInd)
	EndIf
	
	
	cProduto	:=GdFieldGet("C6_PRODUTO", nInd)
	cArmazem	:=GdFieldGet("C6_LOCAL", nInd)
	cItem		:=GdFieldGet("C6_ITEM", nInd)
	
	If Empty(cProduto)
		Loop
	Endif
	
	nQtdVen	:= GdFieldGet( "C6_QTDVEN", nInd)
	
	If lLibWMS .Or. lGrvNota
		nQtdVen:= GdFieldGet( "C6_YQTDLIB", nInd)
	EndIf
	
	cProdSCusto:=cProduto
	If  lSoftware
		cProdSCusto:=U_M001GetMidia( cProduto )
	EndIf
	cTipoCMV:=""
	
	nCusto	:= U_GetCMVGer(cProdSCusto,cArmazem,@cTipoCMV,lGrvNota)
	
	GdFieldPut('C6_YTPCMVO',cTipoCMV,nInd)
	GdFieldPut('C6_YCMVORI',nCusto,nInd)
	
	If M->C5_XSTAPED=="00" .And. GdFieldGet('C6_YSTPCMV',nInd)=="S" .And. GdFieldGet('C6_YCMVUNI',nInd)<nCusto .And. cTipoCMV<>"P" //Custo Previsto
		nCusto:=GdFieldGet('C6_YCMVUNI',nInd)
		cTipoCMV:="S"
	EndIf
	
	//If lSplit .And. (nVlrMDSO:=GdFieldGet('C6_YPRMDSO',nInd)) >0
	//	nCusto*=GdFieldGet( "C6_PRCVEN", nInd)/nVlrMDSO
	//EndIf
	
	If !lSoftware .And. AVALTES(GdFieldGet("C6_TES",nInd),,'N')
		nCusto	:=1
		cTipoCMV:="C"
	EndIf
	
	If lGrvNota
		nValIPI:=GdFieldGet('C6_YVLRIPI',nInd)
		nValSOL:=GdFieldGet('C6_YVLRICR',nInd)
		nValICM:=GdFieldGet('C6_YVLRICM',nInd)
		nValPIS:=GdFieldGet('C6_YVLRPIS',nInd)
		nValCOF:=GdFieldGet('C6_YVLRCOF',nInd)
	Else
		nValIPI:=0
		nValSOL:=0
		nValICM:=0
		nValPIS:=0
		nValCOF:=0
	EndIf
	
	nAliqIPI:=0
	nAliqSOL:=0
	nAliqICM:=0
	nAliqPIS:=0
	nAliqCOF:=0
	
	lTemSoft:= !Empty ( U_M001GetSoftware( cProduto ) )
	
	If !lGrvNota
		If lSoftware .Or. nQtdVen>0 //Situacao apos a liberacao do WMS
			
			If lSplit
				nAscan:=Ascan(aItemOrig,{|a| a[4] ==GdFieldGet( "C6_ITEM", nInd)})  //Busca o item Original
			Else
				nAscan:=Ascan(aItemOrig,{|a| a[1] ==GdFieldGet( "C6_ITEM", nInd)})
			EndIf
			
			nMafisInd   :=  aItemOrig[nAscan,2]
			If MaFisFound("IT",nMafisInd)
				aBaseICMSST :=U_NCGPR001(   nMafisInd  )
				nValSOL  	:= aBaseICMSST[2]
				nAliqSOL	:= (nValSOL/aBaseICMSST[1])*100
			EndIf
			//nValSOL  	:= MaFisRet( nMafisInd, "IT_VALSOL" )
			//nAliqSOL	:= nValSOL/MaFisRet(nMafisInd,"IT_BASESOL")*100
			
			nValIPI  	:= MaFisRet(nMafisInd,"IT_VALIPI")
			nAliqIPI  	:= nValIPI/MaFisRet(nMafisInd,"IT_BASEIPI")*100
			
			nValICM  	:= MaFisRet(nMafisInd,"IT_VALICM")
			nAliqICM  	:= nValICM/MaFisRet(nMafisInd,"IT_BASEICM")*100
			
			nValPIS  	:= MaFisRet(nMafisInd,"IT_VALPS2")
			nAliqPIS  	:= nValPIS/MaFisRet(nMafisInd,"IT_BASEPS2")*100
			
			
			nValCOF  	:= MaFisRet(nMafisInd,"IT_VALCF2")
			nAliqCOF  	:= nValCOF/MaFisRet(nMafisInd,"IT_BASECF2")*100
		EndIf
		
		
		If lSplit .And. lTemSoft  //Busca impostos do Software
			PR7SoftImp(aItemOrig,nMafisInd,@nValSOL,@nAliqSOL,@nValIPI,@nAliqIPI,@nValICM,@nAliqICM,@nValPIS,@nAliqPIS,@nValCOF,@nAliqCOF)
		EndIf
	EndIf
	nPrcTab		:= GdFieldGet( "C6_PRCTAB", nInd)
	nPrcVen  	:= GdFieldGet( "C6_PRCVEN", nInd)
	
	
	nTotItem	:= nPrcVen*nQtdVen
	nTotItemTab := nPrcTab*nQtdVen
	
	nValFret	:= (M->C5_YPGFRET  / nTotalPV)  * nTotItem
	nValSeg    	:= (M->C5_YVLRSEG  / nTotalPV) * nTotItem
	
	If lCpoTran
		nValFretTra	:= (M->C5_YVFRTRA  / nTotalPV)  * nTotItem
		nValSegTran := (M->C5_YVSETRA  / nTotalPV) * nTotItem
	EndIf
	
	nC6_YVLRDES	:= (M->C5_YDESPES/ nTotalPV) * nTotItem
	
	nValFret2	:= (M->C5_FRETE  / nTotalPV)  * nTotItem
	nValSeg2   	:= (M->C5_SEGURO  / nTotalPV) * nTotItem
	
	
	nValDesp2	:= (M->C5_DESPESA/ nTotalPV) * nTotItem
	nValVerbPV	:= (M->C5_DESCONT / nTotalPV)  * nTotItem
	
	nUnitDesc:=(nTotItemTab-nTotItem)+nValVerbPV
	
	nTotBruto	:=(nPrcTab*nQtdVen)+nValFret2+nValSeg2+nValDesp2+nValIPI+nValSOL//+nValVerbPV
	
	//Liminar de ICMS Espirito Santo(Compete)
	If !(Empty(nAliqLim)) .And. xFilial("SC5") == '06'
		nValICM	:= (nTotItem / 100) * nAliqLim
	EndIf
	nTotLiqui	:=nTotBruto-nValPIS-nValCOF-nValICM-nValIPI-nValFret2-nValSeg2-nValSOL-nValDesp2
	
	nValComis	:=M->C5_YCOMISS*(nTotBruto-nUnitDesc)/100
	nValMKT    	:=M->C5_YPERMKT*(nTotBruto-nUnitDesc)/100
	nValTrade	:=M->C5_YPERTRA*(nTotBruto-nUnitDesc)/100
	
	nValVPC 	:= M->C5_YACORDO*(IIf( M->C5_YTIPACO=="1",nTotBruto,nTotLiqui)-nUnitDesc) /100
	nValVPCAnual:=M->C5_YPANUAL*(IIf( M->C5_YTIPACO=="1",nTotBruto,nTotLiqui)-nUnitDesc) /100
	
	nValVerba	:= (M->C5_YVERBA  / nTotalPV)  * nTotItem
	
	nValDespFin	:=M->C5_YDESFIN*( (nTotBruto-nUnitDesc) )  /100
	
	nUnitDesp:=nValVPC+nValVerba+nValFret+nValSeg+nValMKT+nValTrade+nValDespFin+nValComis+nC6_YVLRDES+nValVPCAnual+nValFretTra+nValSegTran
	nUnitImp :=nValIPI+nValSOL+nValICM+nValPIS+nValCOF
	
	If nCusto ==0
		nCusto 	:= 0//nPrcVen
		cTipoCMV:=""
	EndIf
	
	If lPV_EDI
		nValDesc:=Abs((nPrcTab*nQtdVen)-(nQtdVen*nPrcVen)	) - GdFieldGet('C6_YVALVPC',nInd)
		GdFieldPut('C6_YVLRDCO',  nValDesc  ,nInd)
	EndIf
	
	nUnitCusto:=nCusto*nQtdVen
	
	GdFieldPut('C6_YVLRIPI',nValIPI,nInd)
	GdFieldPut('C6_YVLRICR',nValSOL,nInd)
	GdFieldPut('C6_YVLRICM',nValICM,nInd)
	GdFieldPut('C6_YVLRPIS',nValPIS,nInd)
	GdFieldPut('C6_YVLRCOF',nValCOF,nInd)
	
	
	GdFieldPut('C6_YALQIPI'	,nAliqIPI,nInd)
	GdFieldPut('C6_YALQICR' ,nAliqSOL,nInd)
	GdFieldPut('C6_YALQICM'	,nAliqICM,nInd)
	GdFieldPut('C6_YALQPIS'	,nAliqPIS,nInd)
	GdFieldPut('C6_YALQCOF'	,nAliqCOF,nInd)
	
	
	GdFieldPut('C6_YVLRACO',nValVPC,nInd)
	GdFieldPut('C6_YVLRVER',nValVerba,nInd)
	GdFieldPut('C6_YVLRFRE',nValFret,nInd)
	
	GdFieldPut('C6_YVLRSEG',nValSeg,nInd)
	
	GdFieldPut('C6_YSTPCMV',cTipoCMV,nInd)
	
	GdFieldPut('C6_YVERBPV',nValVerbPV,nInd)
	
	GdFieldPut('C6_YCMVUNI',nCusto,nInd)
	GdFieldPut('C6_YCMVTOT',nCusto*nQtdVen,nInd)
	
	GdFieldPut('C6_YVLRMKT',nValMKT,nInd)
	GdFieldPut('C6_YVLRTRA',nValTrade,nInd)
	GdFieldPut('C6_YVLRDFI',nValDespFin,nInd)
	GdFieldPut('C6_YVLRLIQ',nTotBruto-nUnitDesc-nUnitDesp-nUnitImp,nInd)
	GdFieldPut('C6_YVLRDES',nC6_YVLRDES,nInd)
	
	GdFieldPut('C6_YTOTLIQ', (nTotBruto-nUnitDesc-nUnitDesp-nUnitImp-nUnitCusto),nInd)
	
	nMargLiq:=(nTotBruto-nUnitDesc-nUnitDesp-nUnitImp)-(nCusto*nQtdVen)
	
	GdFieldPut('C6_YMKPLIQ',nMargLiq,nInd)
	nPerLiq:=(nMargLiq/nTotBruto)*100
	nPerLiq:=round(nPerLiq,2)
	GdFieldPut('C6_YPERLIQ',nPerLiq,nInd) //GdFieldPut('C6_YPERLIQ',(nMargLiq/nTotBruto)*100,nInd)
	
	
	GdFieldPut('C6_YMKPBRU',(nTotBruto-nUnitDesc-nUnitImp)-(nCusto*nQtdVen),nInd)
	GdFieldPut('C6_PERBRUT',((nTotBruto-nUnitDesc-nUnitImp)-(nCusto*nQtdVen))/nTotBruto*100,nInd)
	
	aCols[nInd,nPosVcpAnual]:= nValVPCAnual
	aCols[nInd,nPosComiss]:= nValComis
	
	If GdFieldGet('C6_YESTOQU',nInd)>0 .Or. lPvSimul .Or. lProdExc .Or. lProd1Ex .Or. lGrvNota
		M->C5_YVLRIPI+= nValIPI
		M->C5_YVLRICR+= nValSOL
		M->C5_YVLRICM+= nValICM
		M->C5_YVLRPIS+= nValPIS
		M->C5_YVLRCOF+= nValCOF
		M->C5_YVLRFIN+= nValDespFin
		M->C5_YMKTINS+= nValMKT
		M->C5_YTRAMKT+= nValTrade
		M->C5_YVLRCOM+= nValComis
		M->C5_YVLVPC += nValVPC
		M->C5_YVLVPCP+= GdFieldGet('C6_YVALVPC',nInd)
		M->C5_YVANUAL+=GdFieldGet('C6_YVANUAL',nInd)
		
		nValDesconto+=nUnitDesc
		nTotDesp	+=nUnitDesp
		nCustoTot	+=nUnitCusto
		nTotC5Brut	+=nTotBruto
		nTotImp		+=nUnitImp
		nTotCMV     +=nCusto*nQtdVen
		nTotVlrOver	+=GdFieldGet("C6_YVLOVER", nInd) *nQtdVen
	EndIf
	
Next

If !lGrvNota
	MaFisRestore()
EndIf

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif

M->C5_YPERVER:=(M->C5_YVERBA/(nTotC5Brut+nTotVlrOver))*100



M->C5_YTOTCUS:=nCustoTot
M->C5_YVLRLIQ:=(nTotC5Brut-nValDesconto-nTotDesp-nTotImp)//-M->C5_DESCONT
M->C5_YTOTLIQ:=M->C5_YVLRLIQ-nCustoTot

M->C5_YPERLIQ:=(M->C5_YTOTLIQ/ (nTotC5Brut) )*100
M->C5_YLIBC9:=lLibWMS

M->C5_YTOTBRU:=nTotC5Brut//-nTotImp-M->C5_FRETE-M->C5_SEGURO-M->C5_DESPESA
//M->C5_YMARGBR:=M->C5_YTOTBRU-(nTotCMV)

M->C5_YLUCRBR:=nTotC5Brut-nTotImp-nValDesconto-M->C5_YTOTCUS//-M->C5_DESCONT
M->C5_YPERRBR:=(M->C5_YLUCRBR/nTotC5Brut)*100


If Type('oGetPV')=="O"  .And. !lGravaPromo .And. !lVendaVista
	oGetPV:Refresh()
EndIf




Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  12/14/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GetCMVGer(cProduto,cArmazem,cTipoCMV,lGrvNota)

Local aAreaAtu	:= GetArea()
Local aAreaSB1	:= SB1->(GetArea() )
Local aAreaSB2	:= SB2->(GetArea() )

Local nCustUnit := 0
Local cGerarPV	:= Alltrim(U_MyNewSX6(	"NCG_100000","S"		,"C","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz",.F. ))
Local cFilPV	:= Alltrim(U_MyNewSX6(	"NCG_100001","04;05"	,"C","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia",.F. ))
Local cFilDest	:= Alltrim(U_MyNewSX6(	"NCG_100003","03"	   ,"C","Filial Destino PV Transferencia","Filial Destino PV Transferencia","Filial Destino PV Transferencia",.F. ))
Local cFilSB2	:= xFilial("SB2")
Local dDtSB9 	:= ""

Default lGrvNota:= .F.


If cGerarPV=="S"  .And. (cFilAnt$cFilPV)
	cFilSB2:=cFilDest
EndIf

SB2->(DbSetOrder(1))
If nCustUnit==0 .And. SB2->(DbSeek(cFilSB2+cProduto+cArmazem )  )
	If SB2->B2_YCMVG>0
		nCustUnit:= SB2->B2_YCMVG
		cTipoCMV :="G"
	ElseIf SB2->B2_YCMGBR > 0 .And. nCustUnit == 0
		nCustUnit:= SB2->B2_YCMGBR
		cTipoCMV :="B"
	ElseIf nCustUnit == 0
		nCustUnit:= SB2->B2_CM1
		cTipoCMV :="C"
	EndIf
EndIf

If lGrvNota
	dDtSB9:= DtoS(Lastday(U_P107Dtb()))
	SB9->(DbSetOrder(1))
	If SB9->(DbSeek(xFilial("SB9")+cProduto+cArmazem+dDtSB9) )
		nCustUnit := 0
		If SB9->B9_YCMVG>0
			nCustUnit:= SB9->B9_YCMVG
			cTipoCMV :="G"
		ElseIf SB9->B9_YCMGBR > 0 .And. nCustUnit == 0
			nCustUnit:= SB9->B9_YCMGBR
			cTipoCMV :="B"
		ElseIf nCustUnit == 0
			nCustUnit:= SB9->B9_CM1
			cTipoCMV :="C"
		EndIf
	EndIf
EndIf

If nCustUnit==0
	SB1->(DbSetOrder(1))
	If SB1->(DbSeek(xFilial("SB1")+cProduto)) .And. SB1->(FieldPos("B1_YCUSTPR"))>0 .And. SB1->B1_YCUSTPR>0
		nCustUnit:=SB1->B1_YCUSTPR
		cTipoCMV:="P"
	EndIf
EndIf


RestArea(aAreaSB1)
RestArea(aAreaSB2)
RestArea(aAreaAtu)
Return nCustUnit


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  12/19/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107Folder(nFldDst)

If nFldDst==4 //Orcamento em Negociacao
	oGetDad:lActive:=.F.
	Processa( {|| U_PR107VAL()	})
Else
	oGetDad:lActive:=.T.
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  01/03/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107Margem()

Processa({|| PR107MontHTML() })

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  01/04/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PR107MontHTML()
Local aAreaAtu	:=GetArea()
Local aAreaSC6	:=SC6->(GetArea())
Local oDlg
Local cPath		:="\MARGEMLIQ\"
Local cHtml		:="TELA_ANALISE.html"
Local oHtml
Local cNomeArq 	:= CriaTrab(,.f.) + ".htm"
Local cPathTemp  := GETTEMPPATH()
Local aFiguras	:={"NCGAMES2013_despesas.jpg","NCGAMES2013_green-status.png","NCGAMES2013_red-status.png","NCGAMES2013_yellow-status.png"}
Local lWf103	:=IsInCallStack("U_WF103PV")
Local nInd
Local lTemPromo:=U_PR107TemPromo(SC5->C5_NUM)

If lTemPromo
	cHtml		:="TELA_ANALISE_PROMO.html"
EndIf


oHtml:=TWFHTML():New(Alltrim(cPath) + Alltrim(cHtml))

U_PR107Contru(oHtml,SC5->C5_NUM,.F.)

cNomeArq := Alltrim(cPath) + cNomeArq
cNomeArq := StrTran(cNomeArq,'\\','\')
oHtml:SaveFile( Alltrim(cNomeArq) )	// Grava o HTML temporario

cNomeHtml:="PV"+SC5->C5_NUM+StrTran(Time(),":","")+Dtos(Date())

If __CopyFile(cNomeArq,cPathTemp+cNomeHtml)
	
	For nInd:=1 To Len(aFiguras)
		
		If File(  cPathTemp+aFiguras[nInd] )
			Loop
		EndIf
		__CopyFile(cPath+aFiguras[nInd] ,cPathTemp+ aFiguras[nInd] )
		
	Next
	Define MsDialog oDlg Title "Analise:"+SC5->C5_NUM FROM oMainWnd:nTop,oMainWnd:nLeft TO oMainWnd:nBottom,oMainWnd:nRight*0.98 Of oMainWnd PIXEL
	nWidth:= oDlg:nWidth/2
	nHeight:=(oDlg:nHeight/2)-10
	
	
	oTIBrowser:= TIBrowser():New(0,0,nWidth,nHeight,cPathTemp+cNomeHtml,oDlg )
	//oTIBrowser:= TIBrowser():New(0,0,oDlg:nWidth,oDlg:nHeight,cPathTemp+cNomeHtml,oDlg )
	
	tButton():New(10,10	,  "Fechar"  	,oDlg,{|| oDlg:End()	},32,12,,,,.T.)
	If lWf103
		tButton():New(10,50	,  "Aprovar"  	,oDlg,{||u_103AprPos(), oDlg:End() },32,12,,,,.T.)
	EndIf
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
Else
	MsgStop("Ocorreu um erro ao gravar o arquivo.Contate o administrador do sistema")
EndIf

Ferase(cNomeArq)
RestArea(aAreaAtu)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  02/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107RatDesc(nLinha,nVlrDesc,lRecalcular,lUnica)
Local nInd:=1
Local nDesc1:=1
Local nDesc2:=1
Local lLibWMS:=IsInCallStack("U_INTPEDVEN")//Verifica se foi chamado pela integracao do WMS

Default lUnica:=.F.
Default nLinha:=Len(aCols)
Default lRecalcular:=.T.
Default nVlrDesc:=M->C5_DESC2


If nVlrDesc==0
	Return
EndIf

If M->C5_DESC1>0
	nDesc1:=(  100-M->C5_DESC1  )/100
EndIf


For nInd:=1 To nLinha
	
	If GdDeleted( nInd)
		Loop
	Endif
	
	If lUnica .And. nInd<>nLinha
		Loop
	EndIf
	
	nQtdVen:=GdFieldGet( "C6_QTDVEN", nInd)
	
	If lLibWMS //GdFieldGet( "C6_YQTDLIB", nInd)>0
		nQtdVen:=GdFieldGet( "C6_YQTDLIB", nInd)
	EndIf
	
	aCols[nInd,GdFieldPos('C6_YVALVPC') ]:=A410Arred(( GdFieldGet("C6_PRCTAB", nInd)+GdFieldGet("C6_YVLOVER", nInd)  )*nDesc1*nQtdVen*nVlrDesc/100,"C6_VALOR")
	aCols[nInd,GdFieldPos('C6_YVLRDCO')] :=A410Arred(( GdFieldGet("C6_PRCTAB", nInd)+GdFieldGet("C6_YVLOVER", nInd)  )*nQtdVen*M->C5_DESC1/100,"C6_VALOR")
	
	aCols[nInd,GdFieldPos('C6_YPERVPC') ]:=nVlrDesc
	If GdFieldGet("C6_YVLOVER",nInd) >0
		lRecalcular:=.F.
	EndIf
	
Next

If Type('oGetDad:oBrowse')<>"U"
	
	If lRecalcular
		a410Recalc(.T.)
	EndIf
	
	oGetDad:oBrowse:Refresh()
	Ma410Rodap()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  02/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR107Gat( cCampo )
Local xRetorno:=&(__ReadVar)
Local nVlrVenda:=0
Local aColsAux:={}
Local nPosValDesc:=GdFieldPos("C6_VALDESC")
Local nPosPerDesc:=GdFieldPos("C6_DESCONT")
Local nPPrUnit  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
Local lPV_Portal:=IsInCallStack("PUTSALESORDER")
Local lPV_EDI	:=IsInCallStack("U_KZNCG11")//Pedidos de Venda originario do EDI
Local lTemPromo:=.F.


If lPV_Portal .And. Empty(M->C5_TRANSP)
	M->C5_TRANSP:= Posicione("SA1",1,xFilial("SA1")+M->(C5_CLIENTE+C5_LOJACLI),"A1_TRANSP" )
EndIf

Default cCampo:=__ReadVar

If __ReadVar$"M->C5_DESC1*M->C5_DESC2"
	U_PR107Over(.F.)
	U_PR107RatDesc()
ElseIf __ReadVar$"M->C6_DESCONT*"
	GdFieldPut("C6_DESCONT", M->C6_DESCONT  ,n)
	U_PR107Over(.F.,.T.)
ElseIf __ReadVar$"M->C6_PRODUTO*M->C6_QTDVEN"
	
	If !lPV_EDI
		GdFieldPut("C6_PRCVEN", A410Arred(A410Arred(GdFieldGet( "C6_PRCTAB", n)*(1+ GdFieldGet("C6_YPEOVER")/100 ),"C6_PRCVEN")*PR07GetDesc("D"),"C6_VALOR")  ,n)
		PR107ExecVal('C6_PRCVEN')
	EndIf
	
	U_PR107RatDesc(n,,,.T.)
	nVlrPrc:=A410Arred(GdFieldGet( "C6_PRCVEN", n) ,"C6_VALOR" )
	GdFieldPut("C6_PRCVEN", nVlrPrc)
	PR107ExecVal('C6_PRCVEN')
	
	
	If !lJaZerado
		For nInd:=1 To Len(aCols)
			GdFieldPut("C6_YQTDLIB",0,nInd)
		Next
		lJaZerado:=.T.
	EndIf
ElseIf __ReadVar$"M->C6_YVLOVER"
	nVlrOver:=A410Arred( GdFieldGet( "C6_PRCTAB", n)+M->C6_YVLOVER	*PR07GetDesc("D"),"C6_VALOR")
	GdFieldPut("C6_PRCVEN", nVlrOver  ,n)
	GdFieldPut("C6_YPEOVER", (A410Arred( ((nVlrOver	/ GdFieldGet( "C6_PRCTAB", n))-1)*100,,"C6_TOTAL")) ,n)
	PR107ExecVal('C6_PRCVEN')
ElseIf __ReadVar$"M->C6_YPEOVER"
	
	nVlrVenda:=A410Arred(A410Arred(GdFieldGet( "C6_PRCTAB", n)*(1+ M->C6_YPEOVER/100 ),"C6_PRCVEN")*PR07GetDesc("D"),"C6_VALOR")
	GdFieldPut("C6_PRCVEN",nVlrVenda ,n)
	GdFieldPut("C6_YVLOVER", GdFieldGet( "C6_PRCTAB", n) *M->C6_YPEOVER/100 ,n)
	
	If (nValDesc:=A410Arred(aCols[n][nPPrUnit]*aCols[n][nPQtdVen],"C6_VALDESC")-A410Arred(aCols[n][nPPrcVen]*aCols[n][nPQtdVen],"C6_VALDESC")	)>0
		GdFieldPut("C6_VALDESC", nValDesc  ,n)
	EndIf
	aColsAux:=aClone(aCols[n])
	PR107ExecVal('C6_PRCVEN')
	aCols[n,nPosValDesc]:=aColsAux[nPosValDesc]
	aCols[n,nPosPerDesc]:=aColsAux[nPosPerDesc]
Endif


If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
	Ma410Rodap()
Endif

Return xRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  02/03/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107When( cCampo )
Local xVlrCpo		:=&(__ReadVar)
Local lSimulacao	:=M->C5_XSTAPED == "00" .Or. M->C5_XSTAPED == "05"
Local lRetorno		:=.T.
Local lPvSimul		:=IsInCallStack("U_PR107PVSIMUL")  //Verifica se foi chamado pela Sumulação
Local lPvEcommer	:= M->C5_XECOMER == "C"

Default cCampo:=__ReadVar

Do Case
	Case cCampo=="M->C6_PRCVEN"
		lRetorno:=PR107Preco()
	Case cCampo=="M->C6_VALDESC"
		lRetorno:=lPvSimul .Or. lPvEcommer
	Case cCampo=="M->C5_YPGFRET"
		lRetorno:=.F.
	Case cCampo=="M->C5_YVLRSEG"
		lRetorno:=.F.
	Case cCampo$"M->C5_YACORDO*M->C5_YTIPACO"
		lRetorno:=Iif(lPvSimul,.F.,lSimulacao)
	Case cCampo=="M->C5_YPERVER"
		lRetorno:=Iif(lPvSimul,.F.,lSimulacao)
	Case cCampo=="M->C5_DESC2"
		lRetorno:=Iif(lPvSimul,.F.,lSimulacao)
	Case cCampo=="M->C5_DESCONT"
		lRetorno:=Iif(lPvSimul,.F.,lSimulacao)
	Case cCampo=="M->C5_YUSAVER"
		lRetorno:=Iif(lPvSimul,.F.,!lSimulacao)
	Case cCampo=="M->C5_YPERLIQ"
		lRetorno:=.F.
	Case cCampo=="M->C5_YPERTRA"
		lRetorno:=.F.
EndCase

Return lRetorno




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  02/22/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107LibPermitida(lPosicionar,cNumPedido)
Local lReturn 	:=.T.
Local aAreaAtu	:=GetArea()
Local aAreaSC5	:=SC5->(GetArea())
Local aAreaSA1	:=SA1->(GetArea())
Local cStNotLib :=Alltrim(U_MyNewSX6("NCG_000107","00*05*20*35*40","C","Status que nao permite liberacao","","",.F. ))
Local lPedidoSite	:=Iif(SC5->C5_XECOMER=="C",.T.,.F.)//IsInCallStack("U_NCECOM08")
Default lPosicionar:=.T.

If lPosicionar
	SC5->(DbSetOrder(1)) //C5_FILIAL+C5_NUM
	If !SC5->(DbSeek(xFilial("SC5")+cNumPedido))
		MsgStop("Pedido "+cNumPedido+" não encontrado")
		lReturn:=.F.
	EndIf
EndIf

If lReturn .And. SC5->C5_XSTAPED $ cStNotLib
	MsgStop("Pedido "+cNumPedido+" esta com Situacao  SF "+SC5->C5_XSTAPED+"-"+Posicione("SX5",1,xFilial("SX5")+"Z6"+SC5->C5_XSTAPED,"X5_DESCRI")+".Liberação não permitida")
	lReturn:=.F.
EndIf

If lReturn .And. !SC5->C5_YSTATUS $ "01*06"
	MsgStop("Pedido "+cNumPedido+" esta com Mrg. Status "+SC5->C5_YSTATUS+". Liberação não permitida")
	lReturn:=.F.
EndIf


If lReturn .And. !lPedidoSite
	
	SA1->(DbSetOrder(1))
	If SA1->(MsSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)) .And. SA1->A1_YBLQFIN=="1"
		MsgStop("Cliente com bloqueio financeiro ( Campo "+AllTrim( AvSx3("A1_YBLQFIN",5) )+" Pasta "+AllTrim( AvSx3("A1_YBLQFIN",15) )+" no cadastro de cliente), liberação não permitida.","Nc Games")
		lReturn:=.F.
	EndIf         
	RestArea(aAreaSA1)
	
EndIf


RestArea(aAreaSC5)
RestArea(aAreaAtu)
Return lReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  02/22/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107AltPermitida(lPosicionar,cNumPedido)
Local lReturn 	:=.T.
Local aAreaAtu	:=GetArea()
Local aAreaSC5	:=SC5->(GetArea())
Default lPosicionar:=.T.

If lPosicionar
	SC5->(DbSetOrder(1)) //C5_FILIAL+C5_NUM
	If !SC5->(DbSeek(xFilial("SC5")+cNumPedido))
		MsgStop("Pedido "+cNumPedido+" não encontrado")
		lReturn:=.F.
	EndIf
EndIf

If lReturn .And. SC5->C5_YLIBC9 .And. !MsgNoYes("Atenção, o pedido "+cNumPedido+" ja passou por uma liberação e uma aprovação,caso você confirme a alteração do pedido, obrigatóriamente o pedido deverá ser aprovado novamente. Deseja continuar a alteração?")
	lReturn:=.F.
EndIf


If lReturn .And. SC5->C5_YSTATUS $ "03"
	MsgStop("Pedido "+cNumPedido+" esta com Mrg. Status "+SC5->C5_YSTATUS+". Alteração não permitida")
	lReturn:=.F.
EndIf


RestArea(aAreaSC5)
RestArea(aAreaAtu)
Return lReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  03/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R107PVEDI(nLinha,nQuantPV)
Local nDesconVPC
Local nVlrDif
Default nLinha:=n


If GdFieldGet( "C6_PRUNIT", nLinha)>GdFieldGet("C6_PRCVEN", nLinha)
	GdFieldPut("C6_PRCVEN",GdFieldGet("C6_PRUNIT", nLinha),nLinha)
EndIf
If GdFieldGet( "C6_PRCTAB", nLinha)<GdFieldGet("C6_PRCVEN", nLinha)
	GdFieldPut('C6_YPTABOR',GdFieldGet( "C6_PRCTAB", nLinha),nLinha)
	GdFieldPut('C6_PRCTAB',GdFieldGet("C6_PRCVEN", nLinha),nLinha)
EndIf

If GdFieldGet( "C6_PRUNIT", nLinha)<>GdFieldGet("C6_PRCTAB", nLinha)
	GdFieldPut('C6_PRUNIT',GdFieldGet("C6_PRCTAB", nLinha),nLinha)
EndIf

nDesconVPC:=(M->C5_YDESC2*GdFieldGet( "C6_PRCTAB", nLinha))/100
If ((nVlrDif:=  GdFieldGet("C6_PRCVEN", nLinha)-GdFieldGet( "C6_PRUNIT", nLinha))<0 )
	nVlrDif:=Abs(nVlrDif)
	If nVlrDif<nDesconVPC
		GdFieldPut('C6_YVALVPC',0,nLinha)
	Else
		U_PR107RatDesc(nLinha,M->C5_YDESC2,.F.,.T.)
	EndIf
	GdFieldPut('C6_VALDESC',	IIf(nVlrDif<nDesconVPC,nVlrDif,nDesconVPC)*nQuantPV ,nLinha)
EndIf

If M->C5_DESC2>0
	U_PR107RatDesc(nLinha,M->C5_DESC2,.T.,.T.)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  03/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR107ExecVal(cCampo,nLinha)
Local aAreaAtu:=GetArea()
Local aDadosAtu			:={__READVAR,&(__READVAR)}

Local cValid:=""
Local lValidPadrao:=.F.
Local nLenX3CAMPO		:= Len(SX3->X3_CAMPO)

Default nLinha:=n

__READVAR := "M->" + cCampo
&(__READVAR) := GdFieldGet(cCampo,nLinha)

SX3->(DbSetOrder(2))
If SX3->(DbSeek(cCampo))
	
	If !Empty( SX3->X3_VALID)
		cValid:=AllTrim(SX3->X3_VALID)
		lValidPadrao:=.T.
	EndIf
	
	If !Empty(SX3->X3_VLDUSER)
		cValid+=Iif( lValidPadrao,".And.","") +AllTrim(SX3->X3_VLDUSER)
	EndIf
	
	If Empty(cValid)
		cValid:=".T."
	EndIf
	
	bBlockValid:=&("{||"+cValid+"}")
	Eval(bBlockValid)
	
	If ExistTrigger(PadR( cCampo,nLenX3CAMPO)  )
		RunTrigger(2,n,nil,,PadR( cCampo,nLenX3CAMPO))
	EndIf
	
	
EndIf

__READVAR := aDadosAtu[1]
&(__READVAR) := aDadosAtu[2]

RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  04/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR107Over(lShowPerg,lUnica)
Local cMvPar01	:= mv_par01
Local cPerg	  	:= Padr("PR107OVER",Len(SX1->X1_GRUPO))
Local cReadVar	:= __READVAR
Local nPerOver	:= 0
Local nInicio	:= 1
Local nLinhaAtu	:= n
Local nTotLinha	:= Len(aCols)

Default lShowPerg:=.T.
Default lUnica	:=.F.

U_PR708Over(lShowPerg,lUnica)
Return

If lUnica
	nTotLinha:=n
	nInicio	:=n
EndIf



If lShowPerg
	PutSX1(cPerg, "01", "Aplicar % OverPrice ", "", "", "mv_ch1", "N", 5, 2, 0, "G", "Positivo()", "", "", "", "mv_par01", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	If  !Pergunte(cPerg)
		Return
	EndIF
	nPerOver:=mv_par01
	M->C6_YPEOVER:=nPerOver
	
EndIf

__READVAR :="M->C6_YPEOVER"


For nInd:=nInicio To nTotLinha
	
	If !lShowPerg
		M->C6_YPEOVER:=GdFieldGet("C6_YPEOVER",nInd)
	EndIf
	
	GdFieldPut('C6_YPEOVER',nPerOver,nInd)
	n:=nInd
	U_PR107Gat( "M->C6_YPEOVER" )
Next


mv_par01 := cMvPar01
__READVAR:= cReadVar
n:=nLinhaAtu

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
	Ma410Rodap()
Endif




Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  04/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR07GetDesc(cParam)
Local nFator:=1

If cParam=="D"//Desconto
	nFator:=( (100-M->C5_DESC1)/100 ) *( (100-M->C5_DESC2)/100 ) *( (100- GdFieldGet("C6_DESCONT") )/100 )
Else //Acrescimo
	
EndIf

Return nFator

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  04/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR107Preco()
Local lRetorno:=.T.
If M->C5_TIPO=='N'
	If Empty(GdFieldGet("C6_TPOPER"))
		lRetorno:=.F.
	ElseIf ( !Empty(GdFieldGet("C6_TPOPER")) .Or. !Empty(GdFieldGet("C6_OPER")) )   .AND.AVALTES(GdFieldGet("C6_TES"),,'S') .AND. Posicione("SB1",1,xFilial("SB1")+GdFieldGet("C6_PRODUTO"),"B1_TIPO")=="PA"
		lRetorno:=.F.
	EndIf
EndIf
Return lRetorno



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PR107sVpc  ºAutor ³Lucas Felipe        º Data ³  08/13/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR107sVpc()
Local cPerg	  :=Padr("PR107SVPC",Len(SX1->X1_GRUPO))



If M->C5_XSTAPED=="00"
	
	PutSX1(cPerg, "01", "Aplicar Verba no Pedido", "", "", "mv_ch1", "N", 12, 2, 0, "G", "Positivo()", "", "", "", "mv_par01", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	PutSX1(cPerg, "02", "Aplicar Verba Financeiro", "", "", "mv_ch2", "N", 12, 2, 0, "G", "Positivo()", "", "", "", "mv_par02", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	If  !Pergunte(cPerg)
		Return
	EndIF
	
	M->C5_DESCONT	:= mv_par01
	M->C5_YVERBA	:= mv_par02
	
	U_PR107VAL()
	
else
	Alert("Só é possivel utilizar está opção quando o pedido for do tipo Simulação(Situação SF = 00)")
	
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  08/13/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107PVSIMUL()
Local aAreaSC5:=SC5->(GetArea())

MATA410()

RestArea(aAreaSC5)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  09/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR7SoftImp(aDados,nItem,nValSOL,nAliqSOL,nValIPI,nAliqIPI,nValICM,nAliqICM,nValPIS,nAliqPIS,nValCOF,nAliqCOF)
Local cItemSW	  :="SW"+aDados[nItem,1]

nAscan:=Ascan(aDados,{|a| AllTrim(a[3]) ==cItemSW } )

nMafisInd   :=  aDados[ nAscan ,2]
nAliqSOL:=0
nAliqIPI:=0
nAliqICM:=0
nAliqPIS:=0
nAliqCOF:=0
nValSOL+=MaFisRet(nMafisInd, "IT_VALSOL" )
nValIPI+=MaFisRet(nMafisInd,"IT_VALIPI")
nValICM+=MaFisRet(nMafisInd,"IT_VALICM")
nValPIS+=MaFisRet(nMafisInd,"IT_VALPS2")
nValCOF+=MaFisRet(nMafisInd,"IT_VALCF2")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  10/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR107TabPreco(cCodCli,cLoja,cProduto)
Local aAreaAtu	:=GetArea()
Local aAreaSA1	:=SA1->(GetArea())
Local nPrcVen:=0
Local lTemPromo:=.F.

Default cProduto:=""


If Empty(cProduto)
	If  __ReadVar=="M->C6_PRODUTO"
		cProduto:=M->C6_PRODUTO
	Else
		cProduto:=GdFieldGet("C6_PRODUTO")
	EndIf
EndIf


SA1->(DbSetOrder(1))
If SA1->(DbSeek(xFilial("SA1")+cCodCli+cLoja))
	nPrcVen:=A410Arred( MaTabPrVen(SA1->A1_TABELA	,cProduto,1,cCodCli,cLoja) ,"C6_VALOR")
EndIf

U_PR707Preco(cCodCli,cLoja,cProduto,@nPrcVen,@lTemPromo)

RestArea(aAreaSA1)
RestArea(aAreaAtu)


Return nPrcVen

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  10/11/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                     	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR107FrTrans(nTotalPV)


M->C5_YPFRTRA:=SuperGetMV("NCG_000046",.t.,1.0)	// Para efeito de testes por enquanto o mesmo
M->C5_YPSETRA:=SuperGetMV("NCG_000047",.t.,0.5)	// Para efeito de testes


M->C5_YVFRTRA:=nTotalPV*M->C5_YPFRTRA/100
M->C5_YVSETRA:=nTotalPV*M->C5_YPSETRA/100

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  10/29/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR170GrvPromo()
Local nInd
Local bSeekFor
Local bGravaC5
Local nMargem:=M->C5_YPERLIQ
Local lAprovado
Local lGrvNota	:= (IsInCallStack("U_PR170NOTA").Or.IsInCallStack("U_PR170BNOT"))

For nInd:=1 To 2   // Fazer a simulacao uma vez com promoçao e outra sem promocao
	
	RegToMemory("SC5",.F.,.F.)
	If nInd==1
		bSeekFor	:={|| C6_YPROMO=="S"  }
		bGravaC5	:={|| SC5->C5_YPERPRO:=M->C5_YPERLIQ}
	Else
		bSeekFor:={|| !C6_YPROMO=="S"  }
		bGravaC5	:={|| SC5->C5_YPERNOR:=M->C5_YPERLIQ}
	EndIf
	
	aCols:={}
	aHeader:={}
	
	SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM }, bSeekFor , /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
	
	If !Empty(GdFieldGet("C6_PRODUTO",1))
		If lGrvNota
			U_PR107VAL() //Simulador Margem Liquida
		Else
			U_NCGPR708()
		EndIf
		SC5->(RecLock("SC5",.F.))
		Eval(bGravaC5)
		SC5->(MsUnLock())
	Endif
Next

U_PvCrtAprov(lAprovado,nMargem)

SC5->(RecLock("SC5",.F.))
SC5->C5_YMAPROV:=nMargem
SC5->(MsUnLock())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107  ºAutor  ³Microsiga           º Data ³  12/16/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PR107CELU()
Local aAreaAtu	:=GetArea()
Local aAreaSB1	:=GetArea()
Local nTotLinha	:=Len(aCols)
Local nInd
Local lTemCelular:=.F.
Local cNCMCel	:=Alltrim(U_MyNewSX6("NCG_NCMCEL","84713019*85171231","C","NCM de Celular","NCM de Celular","NCM de Celular",.F. ))


SB1->(DbSetOrder(1))
For nInd:=1 To nTotLinha
	
	If GdDeleted( nInd)
		Loop
	Endif
	
	If !SB1->(DbSeek(xFilial("SB1") + GdFieldGet("C6_PRODUTO", nInd) ))
		Loop
	EndIf
	
	If AllTrim(SB1->B1_POSIPI)$cNCMCel
		lTemCelular:=.T.
		Exit
	EndIf
	
Next

If lTemCelular
	M->C5_YPERTRA:=0
	M->C5_YPERMKT:=0
	M->C5_YACORDO:=0
	M->C5_YDESC2 :=0
	M->C5_YPANUAL:=0
EndIf



RestArea(aAreaSB1)
RestArea(aAreaAtu)

Return lTemCelular
