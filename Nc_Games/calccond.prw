#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AVALCOND º Autor ³ Rodrigo Okamoto    º Data ³  20/01/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para verificacao da parcela do pedido na confirmaçãoº±±
±±º          ³ do pedido de venda.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function AVALCOND(lparc)

Private lparc	:= lparc

lparc	:= Processa({|| u_CalcCOND(lparc) },"Verificando pedido...")


Return(lparc)

//CALCULA O PEDIDO PARA AVALIAR CONDIÇÃO DE PAGAMENTO E VALOR DAS PARCELAS

User Function CalcCOND(lparc)


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
Local nPQtdLib  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDLIB"})
Local nRecOri   := 0
lparc	:= lparc
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
cVend1	    := M->C5_VEND1
cGrpRep 	:= GETADVFVAL("SA3","A3_GRPREP",XFILIAL("SA3")+cVend1,1,"")  
nVlMin	:= getadvfval("ACA","ACA_PEDMIN",XFILIAL("ACA")+cGrpRep,1,0)

IF !M->C5_TIPO = "N" // se o pedido for diferente de normal, não fará a validação
	RETURN(lparc)
ELSE
	cFunc	:= getadvfval("SA1","A1_SATIV1",XFILIAL("SA1")+cCliente+cLoja,1,"")
	IF cFunc == "000061" //se o cliente for funcionário, não fará a validação da parcela
		RETURN(lparc)
	ENDIF
ENDIF

//Calcula o valor da despesa por item
nC5TOTAL	:= 0
nC5TOTLB	:= 0
//aCols[I][nPQtdLib]
FOR I:=1 TO LEN(ACOLS)
	If !GDDeleted(I)
		nC5TOTAL	+= aCols[I][nPTotal]
		nC5TOTLB	+= aCols[I][nPPrcVen]*aCols[I][nPQtdLib]
	EndIf
NEXT

If nC5TOTLB > 0 //considera somente os liberados
	nFtFrete	:= nFrete/nC5TOTLB
	nFtSegur	:= nSeguro/nC5TOTLB
	nFtDespe	:= nDespesa/nC5TOTLB
else
	nFtFrete	:= nFrete/nC5Total
	nFtSegur	:= nSeguro/nC5Total
	nFtDespe	:= nDespesa/nC5Total
endif

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
			If nC5TOTLB > 0 //considera somente os liberados
				
				nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],aCols[nX][nPPrcVen]*aCols[nX][nPQtdLib])
				nPrcLista := aCols[nX][nPPrUnit]
				If ( nPrcLista == 0 )
					nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],aCols[nX][nPPrcVen]*aCols[nX][nPQtdLib])
				EndIf
				nAcresFin := A410Arred(aCols[nX][nPPrcVen]*M->C5_ACRSFIN/100,"D2_PRCVEN")
				nValMerc  += A410Arred(aCols[nX][nPQtdLib]*nAcresFin,"D2_TOTAL")
				nDesconto := a410Arred(nPrcLista*aCols[nX][nPQtdLib],"D2_DESCON")-nValMerc
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
				aCols[nX][nPQtdLib],;  	// 3-Quantidade ( Obrigatorio )
				nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
				nDesconto,; 	// 5-Valor do Desconto ( Opcional )
				"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
				"",;				// 7-Serie da NF Original ( Devolucao/Benef )
				nRecOri,;					// 8-RecNo da NF Original no arq SD1/SD2
				(aCols[nX][nPPrcVen]*aCols[nX][nPQtdLib])*nFtFrete,;					// 9-Valor do Frete do Item ( Opcional )
				(aCols[nX][nPPrcVen]*aCols[nX][nPQtdLib])*nFtSegur,;					// 10-Valor da Despesa do item ( Opcional )
				(aCols[nX][nPPrcVen]*aCols[nX][nPQtdLib])*nFtDespe,;					// 11-Valor do Seguro do item ( Opcional )
				0,;					// 12-Valor do Frete Autonomo ( Opcional )
				nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
				0,;					// 14-Valor da Embalagem ( Opiconal )
				,;					//
				,;					//
				Iif(nPItem>0,aCols[nX,nPItem],""))
			Else
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
			Endif
		Endif
	Next nX
EndIf

aDupl := Condicao(MaFisRet(,"NF_BASEDUP"),M->C5_CONDPAG,MaFisRet(,"NF_VALIPI"),dDatabase,MaFisRet(,"NF_VALSOL"),,,)


nVlTotal:= 0
dbSelectarea("SE4")
dbSetOrder(1)
MsSeek(xFilial("SE4")+M->C5_CONDPAG)
If !(SE4->E4_TIPO=="9")
	For nx:= 1 to len(aDupl)
		nVlTotal += aDupl[nx,2]
		If aDupl[nx,2] < nVlMin
			lparc := .F.
		Endif
	Next
Endif

MaFisEnd()
MaFisRestore()

RestArea(_aArea)
If !lparc .and. nC5TOTLB == 0
	HELP(" ",1,"PARCMIN01")
	lparc	:= .T.
ElseIf !lparc .and. nC5TOTLB > 0 //considera somente os liberados
	alert("Pedido com liberação não poderá ser confirmado. Parcela mínima não foi atingida!")
ElseIf nVlTotal > supergetmv("MV_VLMAXPV",.T.,80000)
	alert("Pedido com valor superior ao máximo permitido!!!"+CHR(13)+"Valor do pedido: "+transform(nVlTotal,"@E 999,999,999.99")+CHR(13)+"Valor permitido: "+transform(supergetmv("MV_VLMAXPV",.T.,80000),"@E 999,999,999.99"))
	lparc	:= .F.
Endif


Return(lparc)

