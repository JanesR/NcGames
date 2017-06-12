#include "rwmake.ch"
#include "COLORS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VERDSCMD º Autor ³ Rodrigo Okamoto    º Data ³  29/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para verificacao do desconto medio no pedido de     º±±
±±º          ³ de venda.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlteração ³ 02/11/12 - Almir Bandina - DBM System - Alteração referenteº±±
±±º          ³            ao ICMS-ST de produtos em mídia para o estado doº±±
±±º          ³            Paraná                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function VERDSCMD(lShowTela)
Local nRetorno
Private oVermelho   := LoadBitmap( GetResources(), "BR_VERMELHO" )
Private oAmarelo    := LoadBitmap( GetResources(), "BR_AMARELO" )
Private oVerde      := LoadBitmap( GetResources(), "BR_VERDE" )

lShowTela := If( lShowTela == nil, .T. , lShowTela )  //Default

Processa({|| nRetorno:=CalcDsc(lShowTela) },"Calculando descontos...")


Return nRetorno

//Calculando Descontos

Static Function CalcDsc(lShowTela)
Local nPLocal   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local nPTotal   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})
Local nPValDesc := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})
Local nPPrUnit  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local nPDtEntr  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ENTREG"})
Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local nPTES     := aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
Local nPNfOri   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_NFORI"})
Local nPSerOri  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_SERIORI"})
Local nPItemOri := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEMORI"})
Local nPIdentB6 := aScan(aHeader,{|x| AllTrim(x[2])=="C6_IDENTB6"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM"})
Local nPosDesc  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_DESCRI"})
Local nPosPrTab := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCTAB"})
Local nPosRegDes := aScan(aHeader,{|x| AllTrim(x[2])=="C6_REGDESC"})
Local nPosPRegDe := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PREGDES"})
Local nRecOri   := 0
Local I			:= 0
Local nY		:= 0
Local nX		:= 0
Local aRetorno	:= { 0, 0 }
Local nTotPV	:=0

_aArea	:= GetArea()

nTotPrcVen	:= 0
nTotValEst	:= 0
nTotPrTab	:= 0
nTotValIpi	:= 0
nTotPrTabR	:= 0
aDadosTMP	:= {}
cPedido		:= M->C5_NUM
cCliente	:= M->C5_CLIENTE
cLoja		:= M->C5_LOJACLI
nFrete		:= M->C5_FRETE
nSeguro		:= M->C5_SEGURO
nDespesa	:= M->C5_DESPESA

//Calcula o valor da despesa por item
nC5TOTAL	:= 0
FOR I:=1 TO LEN(ACOLS)
	If !GDDeleted(I)
		nC5TOTAL	+= aCols[I][nPTotal]
	EndIf
NEXT
nFtFrete	:= nFrete/nC5Total
nFtSegur	:= nSeguro/nC5Total
nFtDespe	:= nDespesa/nC5Total

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca referencias no SC6                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFisGet	:= {}
dbSelectArea("SX3")
dbSetOrder(1)
MsSeek("SC6")
While !Eof().And.X3_ARQUIVO=="SC6"
	cValid := UPPER(X3_VALID+X3_VLDUSER)
	If 'MAFISGET("'$cValid
		nPosIni 	:= AT('MAFISGET("',cValid)+10
		nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
		cReferencia := Substr(cValid,nPosIni,nLen)
		aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	If 'MAFISREF("'$cValid
		nPosIni		:= AT('MAFISREF("',cValid) + 10
		cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
		aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	dbSkip()
EndDo
aSort(aFisGet,,,{|x,y| x[3]<y[3]})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca referencias no SC5                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFisGetSC5	:= {}
dbSelectArea("SX3")
dbSetOrder(1)
MsSeek("SC5")
While !Eof().And.X3_ARQUIVO=="SC5"
	cValid := UPPER(X3_VALID+X3_VLDUSER)
	If 'MAFISGET("'$cValid
		nPosIni 	:= AT('MAFISGET("',cValid)+10
		nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
		cReferencia := Substr(cValid,nPosIni,nLen)
		aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	If 'MAFISREF("'$cValid
		nPosIni		:= AT('MAFISREF("',cValid) + 10
		cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
		aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	dbSkip()
EndDo
aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a funcao fiscal                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MaFisSave()
MaFisEnd()
MaFisIni(Iif(Empty(M->C5_CLIENT),M->C5_CLIENTE,M->C5_CLIENT),;// 1-Codigo Cliente/Fornecedor
M->C5_LOJAENT,;		// 2-Loja do Cliente/Fornecedor
IIf(M->C5_TIPO$'DB',"F","C"),;				// 3-C:Cliente , F:Fornecedor
M->C5_TIPO,;				// 4-Tipo da NF
M->C5_TIPOCLI,;		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA461")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC5         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aFisGetSC5) > 0
	dbSelectArea("SC5")
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&("M->"+Alltrim(aFisGetSC5[ny][2])))
			MaFisAlt(aFisGetSC5[ny][1],&("M->"+Alltrim(aFisGetSC5[ny][2])),,.F.)
		EndIf
	Next nY
Endif
If nPTotal > 0 .And. nPValDesc > 0 .And. nPPrUnit > 0 .And. nPProduto > 0 .And. nPQtdVen > 0 .And. nPTes > 0
	
	For nX := 1 To Len(aCols)
		if !GDDeleted(nX)
			cProduto := aCols[nX][nPProduto]
			If nPIdentB6 <> 0 .And. !Empty(aCols[nX][nPIdentB6])
				SD1->(dbSetOrder(4))
				If SD1->(MSSeek(xFilial("SD1")+aCols[nX][nPIdentB6]))
					nRecOri := SD1->(Recno())
				EndIf
			ElseIf nPNfOri > 0 .And. nPSerOri > 0 .And. nPItemOri > 0
				If !Empty(aCols[nX][nPNfOri]) .And. !Empty(aCols[nX][nPItemOri])
					SD1->(dbSetOrder(1))
					If SD1->(MSSeek(xFilial("SD1")+aCols[nX][nPNfOri]+aCols[nX][nPSerOri]+M->C5_CLIENTE+M->C5_LOJACLI+aCols[nX][nPProduto]+aCols[nX][nPItemOri]))
						nRecOri := SD1->(Recno())
					EndIf
				EndIf
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Calcula o preco de lista                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],aCols[nX][nPTotal])
			nPrcLista := aCols[nX][nPPrUnit]
			If ( nPrcLista == 0 )
				nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],aCols[nX][nPTotal])
			EndIf
			nAcresFin := A410Arred(aCols[nX][nPPrcVen]*M->C5_ACRSFIN/100,"D2_PRCVEN")
			nValMerc  += A410Arred(aCols[nX][nPQtdVen]*nAcresFin,"D2_TOTAL")
			nDesconto := a410Arred(nPrcLista*aCols[nX][nPQtdVen],"D2_DESCON")-nValMerc
			nDesconto := IIf(nDesconto==0,aCols[nX][nPValDesc],nDesconto)
			nDesconto := Max(0,nDesconto)
			nPrcLista += nAcresFin
			//Para os outros paises, este tratamento e feito no programas que calculam os impostos.
			If cPaisLoc=="BRA"
				nValMerc  += nDesconto
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Agrega os itens para a funcao fiscal         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			MaFisAdd(cProduto,;   	// 1-Codigo do Produto ( Obrigatorio )
			aCols[nX][nPTES],;	   	// 2-Codigo do TES ( Opcional )
			aCols[nX][nPQtdVen],;  	// 3-Quantidade ( Obrigatorio )
			nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
			nDesconto,; 	// 5-Valor do Desconto ( Opcional )
			"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
			"",;				// 7-Serie da NF Original ( Devolucao/Benef )
			nRecOri,;					// 8-RecNo da NF Original no arq SD1/SD2
			aCols[nX][nPTotal]*nFtFrete,;					// 9-Valor do Frete do Item ( Opcional )
			aCols[nX][nPTotal]*nFtSegur,;					// 10-Valor da Despesa do item ( Opcional )
			aCols[nX][nPTotal]*nFtDespe,;					// 11-Valor do Seguro do item ( Opcional )
			0,;					// 12-Valor do Frete Autonomo ( Opcional )
			nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
			0,;					// 14-Valor da Embalagem ( Opiconal )
			,;					//
			,;					//
			Iif(nPItem>0,aCols[nX,nPItem],""))
		endif
	Next nX
EndIf


IF M->C5_TIPO $"B/D"
	DBSELECTAREA("SA2")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA2")+M->(C5_CLIENTE+C5_LOJACLI))
	cUF		:= SA2->A2_EST
ELSE
	DBSELECTAREA("SA1")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA1")+M->(C5_CLIENTE+C5_LOJACLI))
	cUF		:= SA1->A1_EST
ENDIF

ProcRegua(LEN(ACOLS))

nItem := 0
FOR I:=1 TO LEN(ACOLS)
	if !GDDeleted(I)
		nItem	++
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SB1")+aCols[I,nPProduto])
		_cProduto 	:= aCols[I,nPProduto]
		_cTes			:= aCols[I,nPTES]
		_cIPISN		:= getadvfval("SF4","F4_IPI",XFILIAL("SF4")+_cTes,1,"")
		_nQtdVen		:= aCols[I,nPQtdVen]
		_cDescri		:= aCols[I,nPosDesc]
		nAlqIPI :=  MaFisRet(nItem,"IT_ALIQIPI")
		nValIPI := 	MaFisRet(nItem,"IT_VALIPI")
		
		//02/11/12 - Almir Bandina - DBM System - Tratamento ICMS-ST Diferenciado
		aRetorno	:= U_NCGPR001( nItem )
		MaFisAlt( "IT_BASESOL", aRetorno[1], nItem )
		MaFisAlt( "IT_VALSOL", aRetorno[2], nItem )
		//02/11/12
		nValST  := 	MaFisRet(nItem,"IT_VALSOL")
		
		IncProc("Produto : " + _cProduto + " Linha : " + strzero((I ),4))
		
		nPrTabReal	:= aCols[I,nPosPrTab]
		nPrcVend		:= aCols[I,nPPrcVen]*_nQtdVen // preco sem ipi
		_nPreco	:= nPrTabReal*_nQtdVen
		nPrcVdIp	:= nPrcVend+nValIPI // preco de venda com IPI
		
		nfatorit	:= nPrcVend/(nPrTabReal*_nQtdVen)
		nPDescit := IF(nfatorit==1,0,round(100*(1-nfatorit),2))
		nItFrete := aCols[I][nPTotal]*nFtFrete					// 9-Valor do Frete do Item ( Opcional )
		nItSegur := aCols[I][nPTotal]*nFtSegur					// 10-Valor da Despesa do item ( Opcional )
		nItDespe := aCols[I][nPTotal]*nFtDespe					// 11-Valor do Seguro do item ( Opcional )
		nValOutr	:= nItFrete+nItSegur+nItDespe // soma valor do frete + seguro + despesa
		
		//acumula os valores para comparacao do valor do desconto
		nTotPrTab	+= _nPreco  //preço tabela sem IPI
		nTotPrcVen	+= nPrcVend // preco sem ipi
		nTotValIpi	+= nValIpi
		nTotPrTabR	+= nPrTabReal*_nQtdVen
		
		aadd(aDadosTMP,{_cProduto, _cDescri, _nQtdVen, aCols[I,nPosPrTab],;
		aCols[I,nPPrcVen], nValST,(nValST/aCols[I,nPPrcVen])*100, nValIPI, aCols[I,nPPrUnit], -nPDescit,;
		nValOutr, aCols[I,nPPrcVen]+((nValST+nValIPI)/_nQtdVen), ROUND(_nQtdVen*aCols[I,nPPrcVen],2),;
		aCols[I,nPosRegDes],aCols[I,nPosPRegDe] })
		
	endif
	
NEXT

nfator	:= nTotPrcVen/nTotPrTabR //FATOR COM BASE NA TABELA DE PRECOS PADRAO
nPerDesc	:= IF(nfator==1,0,100*(1-nfator))
cPerDesc	:= Transform(nPerDesc,"@E 99.99")

If lShowTela
	
	@ 001,001 To 500,900 Dialog oDlgLib Title "Analise do Desconto - Pedido: " + M->C5_NUM
	@ 005,005 LISTBOX oItems Fields Title   	"",PADR("Produto",15),;
	'Descrição NC Games',;
	PADR('Qtd',14),;
	'Preço Tabela',;
	'Preço Venda',;
	'Vlr Subst Trib',;
	' ST % ',;        //Inserido pelo Janes R.
	PADR('Vlr IPI',14),;
	'Prc Lista',;
	'Dif Preço %',;
	'Regra Desc',;
	'% Regra Desc',;
	'Desp Acess',;
	'Vlr Unit c/ IPI + ST',;
	PADR('Vlr Total Merc',20) SIZE 440,155 PIXEL //ON CHANGE ""  ON DBLCLICK "" OF oDlgLib PIXEL
	oItems:SetArray(aDadosTMP)
	
	oItems:bLine := { || {If(!empty(aDadosTMP[oItems:nAt,13]),oAmarelo,IF(aDadosTMP[oItems:nAt,09]<0,oVermelho,oVerde)),;
	aDadosTMP[oItems:nAt,01] ,;
	aDadosTMP[oItems:nAt,02] ,;
	TRANSFORM(aDadosTMP[oItems:nAt,03],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,04],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,05],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,06],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,07],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,08],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,09],"@E 9,999,999.99") ,;
	aDadosTMP[oItems:nAt,13],;
	TRANSFORM(aDadosTMP[oItems:nAt,14],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,10],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,11],"@E 9,999,999.99") ,;
	TRANSFORM(aDadosTMP[oItems:nAt,12],"@E 9,999,999.99")}}
	
	If M->C5_MODAL <> "5"
		@ 170,014 Say OemToAnsi("Valor Venda Tabela ")
		@ 170,105 Say "R$ "+Transform(nTotPrTabR,"@E 9,999,999.99")
		@ 190,014 Say OemToAnsi("Valor Venda Mercadoria")
		@ 190,105 Say "R$ "+Transform(nTotPrcVen,"@E 9,999,999.99")
		@ 210,014 Say OemToAnsi("Valor IPI")
		@ 210,105 Say "R$ "+Transform(MaFisRet(,"NF_VALIPI"),"@E 9,999,999.99")
		@ 230,014 Say OemToAnsi("Valor Subst. Trib.")
		@ 230,105 Say "R$ "+Transform(MaFisRet(,"NF_VALSOL"),"@E 9,999,999.99")
		@ 170,154 Say OemToAnsi("Valor do desconto")
		@ 170,235 Say "R$ "+Transform(nTotPrTab-(nTotPrcVen),"@E 9,999,999.99")
		@ 190,154 Say OemToAnsi("Valor Frete + Seguro + Despesa")
		@ 190,235 Say "R$ "+Transform(nFrete+nSeguro+nDespesa,"@E 9,999,999.99")
		@ 210,154 Say OemToAnsi("Desconto Médio Calculado")
		@ 210,250 Say Transform(-nPerDesc,"@E 999.99")+" %"
		@ 230,154 Say "Total Pedido"
		@ 230,235 Say "R$ "+Transform(nTotPrcVen+MaFisRet(,"NF_VALIPI")+nFrete+nSeguro+MaFisRet(,"NF_VALSOL"),"@E 9,999,999.99")
	Else
		@ 170,014 Say OemToAnsi("Valor Venda Tabela ")
		@ 170,085 Say "R$ "+Transform(nTotPrTabR,"@E 9,999,999.99")
		@ 185,014 Say OemToAnsi("Valor Venda Mercadoria")
		@ 185,085 Say "R$ "+Transform(nTotPrcVen,"@E 9,999,999.99")
		@ 200,014 Say OemToAnsi("Valor IPI")
		@ 200,085 Say "R$ "+Transform(MaFisRet(,"NF_VALIPI"),"@E 9,999,999.99")
		@ 215,014 Say OemToAnsi("Valor Subst. Trib.")
		@ 215,085 Say "R$ "+Transform(MaFisRet(,"NF_VALSOL"),"@E 9,999,999.99")
		@ 230,014 Say "Modal de Frete"
		@ 230,085 Say "Pedido Com Frete Isento"
		@ 170,154 Say OemToAnsi("Valor do desconto")
		@ 170,235 Say "R$ "+Transform(nTotPrTab-(nTotPrcVen),"@E 9,999,999.99")
		@ 185,154 Say OemToAnsi("Valor Frete + Seguro + Despesa")
		@ 185,235 Say "R$ "+Transform(nFrete+nSeguro+nDespesa,"@E 9,999,999.99")
		@ 200,154 Say OemToAnsi("Desconto Médio Calculado")
		@ 200,250 Say Transform(-nPerDesc,"@E 999.99")+" %"
		@ 215,154 Say "Total Pedido"
		@ 215,235 Say "R$ "+Transform(nTotPrcVen+MaFisRet(,"NF_VALIPI")+nFrete+nSeguro+MaFisRet(,"NF_VALSOL"),"@E 9,999,999.99")
		@ 230,154 Say "Quem Isentou"
		@ 230,235 Say M->C5_ALTFRET
	EndIf
	@ 230,350 BMPBUTTON TYPE 01 ACTION ZeraDesc()
	@ 230,380 BMPBUTTON TYPE 02 ACTION Close( oDlgLib )
	Activate Dialog oDlgLib Centered
Else
	nTotPV:=nTotPrcVen+MaFisRet(,"NF_VALIPI")+nFrete+nSeguro+MaFisRet(,"NF_VALSOL")
EndIf
MaFisEnd()
MaFisRestore()

RestArea(_aArea)

Return nTotPV

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VERDSCMD  ºAutor  ³Microsiga           º Data ³  09/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//VERIFICAR PARAMETRO MV_NCUSRLB PARA OS USUARIOS AUTORIZADOS A ZERAR O DESCONTO NA NF
Static function ZeraDesc()

Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
Local nPPrUnit  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPrecoOrg := aScan(aHeader,{|x| AllTrim(x[2])=="C6_YPRCORI"})
Local nPrecoTab := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCTAB"})
Local nI		

Local cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Local cUsrName	:= AllTrim(cUsername)
Local cUserLib	:= Upper(SuperGetMv("MV_NCUSRLB",,"lfelipe"))
Local cFunName	:= AllTrim(FunName())

Close(oDlgLib)


If cFunName == "MATA410" .And. Altera .And. Upper(cUsrName) $ cUserLib
	
	If MsgYesNo("Deseja zerar o destaque do desconto no pedido?")
		
		For nI:=1 to Len(aCols)
			//aCols[nI,nPValDesc]:= 0
			//aCols[nI,nPDescont]:= 0
			//aCols[nI,nPrecoOrg]	:= aCols[nI,nPPrUnit]
		   	//aCols[nI,nPPrUnit]	:= aCols[nI,nPPrcVen] // preco sem ipi 
		   	GdfieldPut("C6_YPRCORI",GdFieldGet("C6_PRCTAB",nI),nI)
			GdfieldPut("C6_PRUNIT",GdFieldGet("C6_PRCVEN",nI),nI)
			//GdfieldPut("C6_PRCTAB",GdFieldGet("C6_PRCVEN",nI),nI) 
						
			GdfieldPut("C6_DESCONT",0,nI)
			GdfieldPut("C6_VALDESC",0,nI)
			
			GdfieldPut("C6_YZERDES","Z",nI)
			
		Next
		
		M->C5_DESC2 := 0 //Zerando Desconto do Cabeçalho
	EndIf
EndIf

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif

Return
