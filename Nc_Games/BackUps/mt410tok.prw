#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"   

/*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
t//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
//ฑฑบPrograma  ณMT410TOK()บ Autor ณ RAFAEL AUGUSTO     บ Data ณ  11-05-10   บฑฑ
//ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
//ฑฑบDescricao ณ 							                                บฑฑ
//ฑฑบ          ณ                                                            บฑฑ
//ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//ฑฑบUso       ณ AP10 NC GAMES                                              บฑฑ
//ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MT410TOK
Local lRet 		:= .F.
Local _lRet    := .F.
Local lAut410	:=  IsBlind()
Local nOpcX 	:= paramixb[1]
Local lTdOk		:= .T.
Local nli 		:= 0
Local cTpOper	:= ""
Local nPOper	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TPOPER'} )
Local cOpPaC	:= ""
Local cCodTransp  := ""
Local nLinhaAtu	:=n

//Public	aItensG002	:= {} //array para utiliza็ใo no programa NCGA002

If !Empty(M->C5_YPEDPAI) .And. !U_PR700TOK()
	Return .F.
EndIf

If !U_VerLibMargem()
	Return .F.
EndIf

If M->C5_VEND1 <> "VN9900" .And. !lAut410 // Vendedor Star Computer ้ excessใo para cแlculo do frete. Aceita o valor digitado sempre. Quando o pedido ้ inserido via rotina automแtica, nใo entra na rotina
	_lRet := P201CalcFrt(_lRet)       // Executa valida็๕es referente ao frete NOVO - PROJETO 2
	lRet  := _lRet
Else
	lRet := .T.
EndIf

//If !lAut410
lRet := U_VALIDTOPER(lRet)
lRet := VLDBLQPROD(lRet)
//Grava o tipo de opera็ใo para o PAC
If lRet

	For nX := 1 To Len(aCols)
	   
		n:=nX
		If !GDDeleted(nX) .and. Empty(cTpOper)
			cTpOper	:= aCols[nX,nPOper]
		EndIf
		
		If !U_GdCheckKey({"C6_PRODUTO"},4,,"Produto Duplicado")
			lRet:=.F.
			Exit
		EndIf	
		
		
	Next nX
	
	n:=nLinhaAtu
	
	If lRet
		lRet := u_GetOpPAC(Alltrim(M->C5_TIPO),Alltrim(cTpOper),Alltrim(M->C5_XECOMER),M->C5_XCODENT,@cOpPaC)
	EndIf	
	
	M->C5_XOPPAC := cOpPaC
	
	
	
EndIf
//EndIf

If (INCLUI .or. ALTERA) .and. lRet
	If !lAut410 .And. M->C5_XSTAPED<>"00"
		lRet	:= u_CalcCOND(lRet)
	EndIf
	//estorno da SZ7
	M->C5_CODBL:= ""
	aAreaAtu	:= getarea()
	DBselectArea("SZ7")
	DBSetOrder(1)
	If DBSeek(xFilial("SZ7")+M->C5_NUM)
		While SZ7->(!eof()) .and. SZ7->Z7_NUM = M->C5_NUM
			Reclock("SZ7")
			DBDELETE()
			MsUnlock()
			DBSelectArea("SZ7")
			DBSkip()
		End
	EndIf
	Restarea(aAreaAtu)
EndIf

If !lAut410
	IF lRet
		U_GRVCPYRESD()
	ENDIF
EndIf


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Projeto VPC e Verba - 23/11/12                                                                                 //
// DBM / Skynet                                                                                                   //
// Hermes Ferreira                                                                                                //
// ษ realizado o rateio do Percentual do VPC entre os itens do pedido de venda para gerar o desconto do pedido    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If !lAut410
	
	lTdOk := lRet
	// Caso o Cliente jแ utilize este P.E, colocar este trecho no final da Fun็ใo. Ap๓s fazer todas as valida็๕es do clientes, e for true deve
	// carregar a variavel lTdOk, e deixar executar essa customiza็ใo
	If lTdOk
		If nOpcX == 3 .or. nOpcX == 4
			//If SC5->C5_YUSAVER <> '1'
			//Processa( {|| U_DisVPCC6(nOpcX)}, "Consultando se existe VPC para esse cliente...")
			//EndIf
		EndIf
	EndIf
EndIf


If lRet
	//separa็ใo de mํdia e software
	
	If ExistBlock("NCGA002")
		SaveInter()
		lRet	:= ExecBlock("NCGA002",.F.,.F.)
		RestInter()
	EndIf
	
EndIf

//Verifica se o pedido e E-commerce
If Upper(Alltrim(M->C5_XECOMER)) == 'C'
	
	//Busca o codigo da transportadora de acordo com forma d entrega do CIASHOP
	cCodTransp := GetTransP(M->C5_XCODENT)
	
	//Verifica se encontrou a transportadora
	If Empty(cCodTransp)
		
		//Se nใo encotnrar transportadra o pedido nใo poderแ ser gerado
		lRet := .F.
		
		//Verifica se ้ job
		If !IsBlind()
			Aviso("Transportadora","Pedido E-commerce sem defini็ใo de transportadora para a forma de entrega: "+M->C5_XCODENT,{"Ok"},2)
		Else
			HELP("",1,"Transportadora",,"Pedido E-commerce sem defini็ใo de transportadora para a forma de entrega: "+M->C5_XCODENT,4,2)
		EndIf
		
	Else
		//Atualiza o codigo da transportadora
		M->C5_TRANSP := cCodTransp
	EndIf

Else 

lRet:= U_P124ValCP(lRet) 
	
EndIf


Return(lRet)

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFUNCAO COM AS VALIDACOES DO FRETEณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/
Static Function Calcfrt(lRet)
dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial()+M->C5_CLIENTE+M->C5_LOJACLI)

_NAOPAGA := SA1->A1_FRETE

IF ALTERA
	IF M->C5_MODORIG <> M->C5_MODAL
		U_MOTALTERACAO()
		U_VERIFICMODAL()
		lRet := .T.
	Else
		lRet := .T.
	ENDIF
ELSE
	IF _NAOPAGA == "2" .and. M->C5_GEROFRE <> "1" .AND. M->C5_FATURPV == "1"
		U_FRETENPAGO()
		lRet := .T.
	ElseIF M->C5_GEROFRE <> "1" .and. _NAOPAGA == "1" .AND. M->C5_FATURPV == "1"
		U_CALCFRETE()
		Alert('FRETE CALCULA AUTOMATICO!')
		lRet := .T.
	ELSE
		lRet := .T.
	ENDIF
ENDIF

Return(lret)

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ  FUNCAO COM AS NOVAS (PII) VALIDACOES DO FRETE        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/
Static Function P201CalcFrt(_lRet)
U_P202CALCFRETE()
//Alert("Frete Calculado Automaticamente - PII")
_lRet := .T.
Return(_lret)

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVALIDA TIPO DE OPERACAO NO PEDIDOณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/
User Function VALIDTOPER(lRret)
Local _l,_J
aToper:={}
cErros:=""
lRet := lRret

_nPOSOPER:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TPOPER'} )

For _l := 1 To Len(aCols)
	if !GDDeleted(_l)
		cOpera := aCols[_l,_nPOSOPER]
		AADD(aToper,cOpera)
	endif
Next _l

For _J := 1 To Len(aToper)
	cValida:= aToper[_j]
	If aToper[1]<>cValida
		cErros+= ALLTRIM(STR(_j))+", "
	End If
Next _J

If !Empty(cErros)
	Alert('As Linhas: ' +cErros+' estใo diferentes do primeiro tipo de opera็ใo!' )
	lret := .f.
End If

Return(lRet)


/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVALIDA PRODUTOS BLOQUEADOS PARA VENDAณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/
STATIC FUNCTION VLDBLQPROD(lRret)
Local _l
lRet := lRret
_nPOSCODPRO:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
_nPOSDESCRI:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_DESCRI'} )
_nPOSTES	  := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
aBlqProd:={}


For _l := 1 To Len(aCols)
	if !GDDeleted(_l)
		cPRODUTO	:= aCols[_l,_nPOSCODPRO]
		cDESCRI	:= aCols[_l,_nPOSDESCRI]
		cTES		:= aCols[_l,_nPOSTES]
		cDUPLIC	:= Posicione("SF4",1,XFILIAL("SF4")+cTES,"F4_DUPLIC")                 //GETADVFVAL("SF4","F4_DUPLIC",XFILIAL("SF4")+cTES,1,"")
		cBLQ 		:= Posicione("SB1",1,XFILIAL("SB1")+PADR(cPRODUTO,15),"B1_BLQVEND")  //GETADVFVAL("SB1","B1_BLQVEND",XFILIAL("SB1")+PADR(cPRODUTO,15),1,"")
		//Verifica se o produto tem bloqueio de vendas e se o TES gera duplicata
		IF cBLQ == "1" .AND. cDUPLIC =="S" .and. !(ALLTRIM(M->C5_YORIGEM) == "SIMULAR")
			AADD(aBlqProd,{cPRODUTO,cDESCRI})
			lRet	:= .F.
		ENDIF
	endif
Next _l

//Apresenta mensagem para pedidos que nใo sใo de E-commerce
If Alltrim(M->C5_XECOMER) != "C"
	If Len(aBlqProd) > 0
		@ 001,001 To 300,400 Dialog oDlgLib Title "Produtos Bloqueados para venda - Pedido: " + M->C5_NUM
		@ 005,005 LISTBOX oItems Fields Title PADR("Produto",20),PADR("Descri็ใo",40) SIZE 195,120 PIXEL
		
		oItems:SetArray(aBlqProd)
		oItems:bLine := { || {aBlqProd[oItems:nAt,01],;
		aBlqProd[oItems:nAt,02]}}
		
		@ 135,150 BMPBUTTON TYPE 01 ACTION Close( oDlgLib )
		Activate Dialog oDlgLib Centered
	ENDIF
EndIf

RETURN(lRet)
/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFUNวรO COMPLEMENTAR PARA FAZER A GRAVAวรO QUE O PEDIDO TEVE O RESIDUO ELIMINADO
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/
USER FUNCTION GRVCPYRESD

aAREAPEDSC5	:= SC5->(GetArea())
aAREAPEDSC6	:= SC6->(GetArea())
aAREAPEDSB2 := SB2->(GetArea())
aAREAPEDSA1 := SA1->(GetArea())
cORIGRES	:= M->C5_ORIGRES
cNotaCpy	 := ""
cSerieCpy := ""
//alert(funname())
IF INCLUI .AND. !EMPTY(cORIGRES)
	
	DbSelectArea("SC6")
	DbSetOrder(1)
	If DbSeek(XFILIAL("SC6")+cORIGRES)
		Do While !EOF() .AND. XFILIAL("SC6")+cORIGRES == SC6->C6_FILIAL+SC6->C6_NUM
			dbSelectArea("SF4")
			dbSetOrder(1)
			MsSeek(xFilial("SF4")+SC6->C6_TES)
			
			dbSelectArea("SC5")
			dbSetOrder(1)
			MsSeek(xFilial("SC5")+SC6->C6_NUM)
			
			If SC6->C6_QTDVEN > SC6->C6_QTDENT
				dbSelectArea("SC9")
				dbSetOrder(1)
				MsSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM)
				While ( !Eof() .And.C9_FILIAL == xFilial("SC9") .And.;
					C9_PEDIDO == SC6->C6_NUM .And.;
					C9_ITEM == SC6->C6_ITEM)
					If ( C9_BLCRED != '10' .And. C9_BLEST != '10' .And.;
						C9_PRODUTO == SC6->C6_PRODUTO)
						SC9->(A460Estorna())
					EndIf
					dbSelectArea("SC9")
					dbSkip()
				EndDo
				If ( SF4->F4_ESTOQUE=="S" )
					dbSelectArea("SB2")
					dbSetOrder(1)
					MsSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL)
					RecLock("SB2")
					SB2->B2_QPEDVEN -= Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0)
					SB2->B2_QPEDVE2 -= ConvUM(SB2->B2_COD, Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0), 0, 2)
					If ( SC6->C6_OP$"01#03#05" )
						SB2->B2_QEMPN  -= SC6->C6_QTDVEN
						SB2->B2_QEMPN2 -= ConvUM(SB2->B2_COD, SC6->C6_QTDVEN, 0, 2)
					Endif
					MsUnLock()
				EndIf
				If ( SF4->F4_DUPLIC=="S" .And. !SC5->C5_TIPO$'DB' )
					dbSelectArea("SA1")
					dbSetOrder(1)
					MsSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA)
					RecLock("SA1")
					nMCusto		:= If(SA1->A1_MOEDALC > 0, SA1->A1_MOEDALC, Val(GetMv("MV_MCUSTO")))
					SA1->A1_SALPED -= xMoeda(Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0)*SC6->C6_PRCVEN,SC5->C5_MOEDA,nMCusto,SC5->C5_EMISSAO)
					MsUnLock()
				EndIf
				
				IF !EMPTY(SC6->C6_NOTA)
					cNotaCpy	 := SC6->C6_NOTA
					cSerieCpy := SC6->C6_SERIE
				EndIf
				RecLock("SC6",.F.)
				SC6->C6_BLQ	:= "R"
				MsUnLock()
			EndIf
			DbSelectArea("SC6")
			DbSkip()
		EndDo
	EndIf
	
	DbSelectArea("SC5")
	DbSetorder(1)
	If DbSeek(XFILIAL("SC5")+cORIGRES)
		RECLOCK("SC5",.F.)
		SC5->C5_LIBEROK := "S"
		SC5->C5_PEDRES	:= M->C5_NUM
		//SC5->C5_NOTA	:= cNotaCpy
		//SC5->C5_SERIE	:= cSerieCpy
		SC5->C5_NOTA := Repl("X",Len(SC5->C5_NOTA))
		MSUNLOCK()
	EndIf
EndIf
RESTAREA(aAREAPEDSC5)
RESTAREA(aAREAPEDSC6)
RESTAREA(aAREAPEDSB2)
RESTAREA(aAREAPEDSA1)

RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT410TOK  บAutor  ณMicrosiga           บ Data ณ  02/24/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VerLibMargem()
Local nli
Local lLibWMS		 := IsInCallStack("U_INTPEDVEN")//Verifica se foi chamado pela integracao do WMS
Local clAlias		 := GetNextAlias()
Local nPosQtLib1	 := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_QTDLIB'} )
Local nPosQtLib2	 := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_QTDLIB2'} )
Local _lRet			 := .T.
Local nMargemPai   	 := 0
Local lAprovadoPai 	 := .F.
Local cCanal		 := M->C5_YCANAL
Local cProdExce	 	 := Alltrim(U_MyNewSX6("NCG_000049","PES2014;PES2014;PES2014","C","Codigo do Produtos de Exce็ใo","Codigo do Produtos de Exce็ใo","Codigo do Produtos de Exce็ใo",.F. ))
Local cProdExc1		 := Alltrim(U_MyNewSX6("NCG_000050","","C","Produto Exce็ใo Adicional ao NCG_000049 ","Produto Exce็ใo Adicional ao NCG_000049","",.F. )   )
Local cCanalExce	 := Alltrim(U_MyNewSX6("NCG_000040","999998","C","Codigo do Canal de Exce็ใo","Codigo do Canal de Exce็ใo","Codigo do Canal de Exce็ใo",.F. ))
Local cProd1Exc		 := Alltrim(U_MyNewSX6("NCG_000051","","C","Produto Exce็ใo ","Produto Exce็ใo  ","Produto Exce็ใo  ",.F. ))
Local cCanal1Exc	 := Alltrim(U_MyNewSX6("NCG_000048","999997","C","Codigo do Canal de Exce็ใo","Codigo do Canal de Exce็ใo","Codigo do Canal de Exce็ใo",.F. ))
Local nReAprova		 := Alltrim(U_MyNewSX6("NCG_000052","1","N","Valor maximo para altera็ใo no Mrg"," "," ",.F. ))
Local lAprovado
Local nMargem

If !lLibWMS
	U_PR107VAL()
EndIf

If !PvCtrMargem() //Verifica se o pedido controla Margem
	
	M->C5_YBLQPAL := " "
	M->C5_YSTATUS := "01"
	M->C5_YAPROV  :="Pedido sem controle de Margem"
	M->C5_YULTMAR :=M->C5_YMAPROV
	//endif
Else
	
	If !Empty(M->C5_YPEDPAI)
		nMargemPai:=U_PR700MarPVPAi(M->C5_YPEDPAI) //Retornar a margem aprovada do Pedido Pai
	EndIf
	
	If nMargemPai<>0 .And.  M->C5_YMAPROV>=nMargemPai
		lAprovadoPai:=.T.
		M->C5_YSTATUS := "01"
		M->C5_YBLQPAL := " "
		M->C5_YAPROV  :="Aprovado Margem do PV Pai-"+AllTrim ( TransForm(nMargemPai,AvSx3("C5_YPERLIQ",6)  ) )
		M->C5_YULTMAR :=M->C5_YMAPROV
	Endif
	
	nReAprova := SuperGetMv("NCG_000052",.f.,"0.5")
	
	If !lAprovadoPai .And.(M->C5_YULTMAR==0 .Or.  Abs(Round(M->C5_YULTMAR,2)-Round(M->C5_YPERLIQ,2))< nReAprova ) //Margem reaprova็ใo
		
		If Select("__P09New_")>0
			__P09New->(DbCloseArea())
		EndIf
		
		
		For nInd:=1 To Len(aCols)
			
			If GdDeleted( nInd , aHeader , aCols )
				Loop
			EndIf
			
			cProdExce := cProdExce + ";" + cProdExc1
			If AllTrim(GdFieldGet("C6_PRODUTO",nInd))$cProdExce
				cCanal:=cCanalExce
				Exit
			ElseIf AllTrim(GdFieldGet("C6_PRODUTO",nInd))$cProd1Exc
				cCanal:=cCanal1Exc
				Exit
			EndIf
		Next
		U_QRYALC104("__P09New_",0,"2",cCanal)
		lAprovado:=M->C5_YPERLIQ>=__P09New_->P09_RENFIN
		__P09New_->(DbCloseArea())
		nMargem		:=M->C5_YPERLIQ
		lAprovPromo :=.F.
		
		U_PvCrtAprov(@lAprovado,@nMargem,@lAprovPromo)//Verfica se hแ Margem Promocional/Normal
		If !lAprovPromo
			U_QRYALC104(clAlias,M->C5_YPERLIQ,"2",cCanal)
			M->C5_YAPROV  :=""
			
			(clAlias)->(DbGoTop())
			
			If !(clALias)->(Eof()) .Or. lAprovado
				
				If M->C5_YPERLIQ>(clAlias)->P09_RENFIN .Or. lAprovado
					M->C5_YBLQPAL := " "
					M->C5_YSTATUS := "01"
					M->C5_YAPROV  :="Aprovado pela Margem"
					M->C5_YULTMAR :=M->C5_YPERLIQ
				ElseIf Altera
					If M->C5_YBLQPAL <> "B" // Tratamento em caso de c๓pia de pedido
						M->C5_YBLQPAL := "T"
						M->C5_YSTATUS := "02"
						M->C5_YAPROV  :="Pedido sujeito a aprova็ใo"
					EndIf
				ElseIf Inclui
					M->C5_YBLQPAL := "T"
					M->C5_YSTATUS := "02"
					M->C5_YAPROV  :="Pedido sujeito a aprova็ใo"
				EndIf
			Else
				M->C5_YSTATUS := "01"
				M->C5_YBLQPAL := " "
				M->C5_YAPROV  :="Aprovado por falta de cadastro de al็ada"   //"Aprovado sem restri็ใo de Margem"
				M->C5_YULTMAR :=M->C5_YPERLIQ
			EndIf
			
			If Select(clAlias) > 0
				(clAlias)->(dbCloseArea())
			EndIf
		EndIf
	EndIf
EndIf
Return _lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT410TOK  บAutor  ณMicrosiga           บ Data ณ  03/21/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PvCtrMargem()
Local nInd
Local lDuplic
Local lRetorno

For nInd:=1 To Len(aCols)
	
	If GdDeleted( nInd , aHeader , aCols )
		Loop
	EndIf
	
	lDuplic:=AvalTes( GdFieldGet("C6_TES",nInd) ,/*cEstoq*/,"S")
	Exit
Next


lRetorno:= M->C5_TIPO$"N" .And. lDuplic


Return lRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT410TOK  บAutor  ณMicrosiga           บ Data ณ  11/07/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PvCrtAprov(lAprovado,nMargem,lAprovPromo)
Local nFirstAprov:=0

If Select("__P09New_")>0
	__P09New_->(DbCloseArea())
EndIf
U_QRYALC104("__P09New_",0,"2",M->C5_YCANAL)
nFirstAprov:=__P09New_->P09_RENFIN
__P09New_->(DbCloseArea())


If M->C5_YPERPRO <>0
	
	nMargem:=M->C5_YPERPRO
	
	If ( lAprovPromo:=(M->C5_YPERNOR==0) )
		M->C5_YSTATUS := "01"
		M->C5_YBLQPAL := " "
		M->C5_YAPROV  :="Aprovado - Pedido Promocional"
		M->C5_YULTMAR :=nMargem
		
	Else
		nMargem:=M->C5_YPERNOR
	EndIf
EndIf

lAprovado:=(nMargem>=nFirstAprov)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetOpPAC บAutor  ณMicrosiga           บ Data ณ  02/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function GetOpPAC(cTipoPed,cTpOper,cEcommer,cXCodent,cOpPaC)

Local aArea	:= GetArea()
Local aAreaZZR	:= ZZR->(GetArea())
Local lRet	:= .T.

cOpPaC	:= replicate("9",tamsx3("C5_XOPPAC")[1])
ZZR->(DbSetOrder(1))
If ZZR->(DbSeek(xFilial("ZZR")+cTpOper+cTipoPed+cEcommer+cXCodent))
	cOpPaC	:= ZZR->ZZR_CODWMS
EndIf

RestArea(aAreaZZR)
RestArea(aArea)

Return lRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetTransP  บAutor  ณMicrosiga 	        บ Data ณ  09/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a transportadora de acordo com o Codigo do CIASHOP  บฑฑ
ฑฑบ          ณ						                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTransP(cCodCia)

Local aArea 	:= GetArea()
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()
Local cRet		:= ""

Default cCodCia := ""

If !Empty(cCodCia)
	
	cQuery   := " SELECT A4_COD FROM "+RetSqlName("SA4")+" SA4 "+CRLF
	cQuery   += " WHERE SA4.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += " AND SA4.A4_FILIAL = '"+xFilial("SA4")+"' "+CRLF
	cQuery   += " AND SA4.A4_ZCODCIA = '"+Alltrim(cCodCia)+"'  "+CRLF
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)
	
	If (cArqTmp)->(!Eof())
		
		cRet := (cArqTmp)->A4_COD
		
	EndIf
	
	
	(cArqTmp)->(DbCloseArea())
EndIf

RestArea(aArea)
Return cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT410TOK  บAutor  ณMicrosiga           บ Data ณ  09/29/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function M410Cond(lret)

Local cAliasAtu := GetArea()
Local cAliasSA1	:= SA1->(GetArea())
Local cCondPag	:= Alltrim(U_MyNewSX6("NCG_000069","618;029","C","Condi็๕es de Pagto. validas para clientes com limite de Credito 0"," "," ",.F. ))

SA1->(DbSetOrder(1))//A1_FILIAL+A1_COD+A1_LOJA
SA1->(DbSeek(xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI))

If SA1->A1_LC <= 0
	If !(M->C5_CONDPAG $ cCondPag)
		MsgAlert("Condi็ใo de Pagamento invalida para situa็ใo do cliente, inserir as condi็๕es "+cCondPag+" para prosseguir","CP_Invalida")
		lret := .F.
	EndIf
EndIf

RestArea(cAliasSA1)
RestArea(cAliasAtu)

Return (lret)
