#INCLUDE "rwmake.ch"
#INCLUDE "PROTHEUS.CH"
Static aItensG002:={}

//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³NCGA002   º Autor ³                    º Data ³  03/09/13   º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³Programa para realizar o split automático dos itens mídia e º±±
//±±º          ³software no pedido de vendas.                               º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ NC GAMES  - MT410TOK                                       º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

User Function NCGA002()
Local aArea		:= Getarea()
Local aAreaSX6	:= SX6->(Getarea())
Local cFilMDSW	:=	U_MyNewSX6(	"NCG_100002",;
								"05",;
								"C",;
								"Filiais que realizam o tratamento de mídia e software",;
								"Filiais que realizam o tratamento de mídia e software",;
								"Filiais que realizam o tratamento de mídia e software",;
								.F. )

								
If CFILANT $ cFilMDSW .and. SC5->C5_TIPO == "N"
//Processa o split de mídia e software somente para as filiais contidas no parâmetro NCG_100002
	Processa({|| U_GA002Split() },"Processando separação de mídia e software...")

	If Type('oGetDad:oBrowse')<>"U"
		oGetDad:oBrowse:Refresh()
	Endif

EndIf

RestArea(aAreaSX6)
RestArea(aArea)

Return .T.


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processamento do split dos itens³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
User Function GA002Split()

Local nUsado    := Len(aHeader)
Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRODUTO"})
Local nPTES     := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_TES"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_QTDVEN"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ITEM"})
Local nPosPrTab	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRCTAB'} )
Local nPosPrUnit:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRUNIT'} )
Local nPosPrcVen:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRCVEN'} )
Local nPosValor	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_VALOR'} )
Local nPos2		:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_CLASFIS'} )
Local nPosTES	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_TES'} )
Local nPosCF	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_CF'} )
Local nPosDSC	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_DESCRI'} )
Local nALM      := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_LOCAL'} )
Local nPOS3     := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_UM'} )
Local nPOS4     := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_SEGUM'} )
Local nPOS5     := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_UNSVEN'} )
Local nPOSOPER  := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_OPER'} )
Local nPOSOPER2 := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_TPOPER'} )
Local nPosYMIDP := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_YMIDPAI'} )
Local nPosItOrig := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_YITORIG'} )
Local nPosPrMDSO := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_YPRMDSO'} )
Local cProd 	:= ""
Local cProdMD	:= ""
Local cCodMD	:= ""
Local cItem		:= "00"
Local n			:= len(aCols)
Local aG2Cols	:= aClone(aCols)
Local nVlrMDSW	:=	U_MyNewSX6(	"NCG_100005",;
								"6",;
								"N",;
								"Preço da mídia (se for maior que 0 será o valor do parâmetro. Se igual a 0 será o valor do preço na tabela de preços)",;
								"Preço da mídia (se for maior que 0 será o valor do parâmetro. Se igual a 0 será o valor do preço na tabela de preços)",;
								"Preço da mídia (se for maior que 0 será o valor do parâmetro. Se igual a 0 será o valor do preço na tabela de preços)",;
								.F. )

Private cPedido		:= M->C5_NUM
Private cTabela		:= M->C5_TABELA
Private nDesc1		:= M->C5_DESC1
Private aErros		:= {}
Private aDadosCfo	:= {}
Private aItens		:= {}

ProcRegua(len(aCols)) // Numero de registros a processar

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif
nZ:= 0

If M->C5_TIPO == "D"
	Return	
EndIf

For nx:=1 to len(aCols)

	If !GDDeleted(nx)
	
		If !U_M001IsSoftware( aCols[nx,nPProduto] ) //Verifica se o produto não é software
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Incrementa a regua                                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		  	IncProc("Verificando: " + aCols[nx,nPProduto] )
            //copia a linha do aCols
			aG002Col	:= aClone(aCols[nx])

			cProd	:= aCols[nx,nPProduto]
			nQtdVen	:= aCols[nx,nPQtdven]
			nPrcVen	:= aCols[nx,nPosPrcVen]
			cOper2	:= aCols[nx,nPOSOPER2]
			cTES	:= MaTesInt(2,cOper2,M->C5_CLIENT,M->C5_LOJAENT,If(M->C5_TIPO$'DB',"F","C"),cProd,"C6_TES")
			nPrcTab	:= aCols[nx,nPosPrTab]
            nFatorDsc:= 1-(nPrcVen/nPrcTab)
            cItemOrig:=GdFieldGet( "C6_ITEM", nX)
            nVlrMSDO :=	nPrcVen
            
			cCodMD	:= getadvfval("SB5","B5_YCODMS", xFilial("SB1")+aCols[nx,nPProduto],1,"")
			AADD(aItens , aG002Col )			
			nZ++

			cItem	:= Soma1(cItem)
	        cItePai	:= cItem
			aItens[Len(aItens),nPItem]		:= cItem
			aItens[Len(aItens),nPProduto]	:= cProd
			aItens[Len(aItens),nPosPrcVen]	:= nPrcVen
			aItens[Len(aItens),nPOSOPER]	:= cOper2
			aItens[Len(aItens),nPosTES]		:= cTES
			aItens[Len(aItens),nPosItOrig]	:= cItemOrig
			
						
			If !Empty(cCodMD)

				Aadd(aItens, Array( nUsado+1 ) )
				nZ++
				For nW := 1 To nUsado
					If (aHeader[nW,2] == "C6_REC_WT")					
						aItens[nZ,nW] :=0
					ElseIf (aHeader[nW,2] == "C6_ALI_WT")
						aItens[nZ,nW] :="SC6"
					Else
						aItens[nZ,nW] := CriaVar(aHeader[nW,2],.T.)
					EndIf						
				Next nW                                 				
				aItens[Len(aItens),Len(aHeader)+1]		:= .F.
				
				cItem	:= Soma1(cItem)
			
				aItens[Len(aItens),nPItem]		:= cItem

				cTES	  := MaTesInt(2,cOper2,M->C5_CLIENT,M->C5_LOJAENT,If(M->C5_TIPO$'DB',"F","C"),cCodMD,"C6_TES")
				//Grava o relacionamento entre os itens
				aItens[Len(aItens)-1,nPosYMIDP]	:= "MD"+cItem
				aItens[Len(aItens),nPosYMIDP]	:= "SW"+cItePai

				aItens[Len(aItens),nPProduto]	:= cCodMD
				aItens[Len(aItens),nPOSOPER]	:= cOper2
				aItens[Len(aItens),nPOSOPER2]	:= cOper2
				aItens[Len(aItens),nPosTES]		:= cTES

				DBSELECTAREA("SF4")
				DBSETORDER(1)
				DBSEEK(XFILIAL("SF4")+ cTES,.T.)
			
				DBSELECTAREA("SB1")
				DBSETORDER(1)
				DBSEEK(XFILIAL("SB1")+cCodMD,.T.)

				//Preenchimento do CFOP e Situação tributária*****************************
	 			Aadd(aDadosCfo,{"OPERNF","S"})
			 	Aadd(aDadosCfo,{"TPCLIFOR",M->C5_TIPOCLI})					
	 			Aadd(aDadosCfo,{"UFDEST",Iif(M->C5_TIPO $ "DB",SA2->A2_EST,SA1->A1_EST)})
			 	Aadd(aDadosCfo,{"INSCR" ,If(M->C5_TIPO$"DB",SA2->A2_INSCR,SA1->A1_INSCR)})
				aItens[Len(aItens),nPosCF] := MaFisCfo(,SF4->F4_CF,aDadosCfo)
				aItens[Len(aItens),nPos2]	:= Substr(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB
				//************************************************************************
				If nVlrMDSW == 0
					nPrcven   := U_VLDTAB(cTabela,cCodMD,"B",SB1->B1_TIPO)
				Else
					nPrcven   := nVlrMDSW
				EndIf
				nPrUnVd	  := round(nPrcven-(nPrcven*nFatorDsc),2)

				aItens[Len(aItens),nPos2]  		:= Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB
				aItens[Len(aItens),nALM]  		:= SB1->B1_LOCPAD
				aItens[Len(aItens),nPosDSC] 	:= SB1->B1_XDESC
				aItens[Len(aItens),nPOS3]   	:= SB1->B1_UM
				aItens[Len(aItens),nPOS4]   	:= SB1->B1_SEGUM
				aItens[Len(aItens),nPosPrTab]	:= aCols[nx,nPosPrTab]-nPrcven
				aItens[Len(aItens),nPosPrUnit]	:= aCols[nx,nPosPrUnit]-nPrUnVd
				aItens[Len(aItens),nPosPrcVen]	:= aCols[nx,nPosPrcVen]-nPrUnVd
				aItens[Len(aItens),nPQtdVen]	:= nQtdVen
				aItens[Len(aItens),nPosValor]	:= (aCols[nx,nPosPrcVen]-nPrUnVd)*nQtdVen
				aItens[Len(aItens),nPosItOrig]	:= ""
				aItens[Len(aItens),nPosPrMDSO]	:= nVlrMSDO

				//Subtrai o preço da mídia
				aItens[Len(aItens)-1,nPosYMIDP]		:= "MD"+cItem
				aItens[Len(aItens)-1,nPosPrcVen]	:= nPrUnVd
				aItens[Len(aItens)-1,nPosPrTab]		:= nPrcven
				aItens[Len(aItens)-1,nPosPrUnit]	:= nPrUnVd
				aItens[Len(aItens)-1,nPosValor]		:= nPrUnVd*nQtdVen
				aItens[Len(aItens)-1,nPosItOrig]	:= cItemOrig
				aItens[Len(aItens)-1,nPosPrMDSO]	:= nVlrMSDO				
				
				
				

			EndIf
		Else
			aG002Col	:= aClone(aCols[nx])
			AADD(aItens , aG002Col )			
		EndIf
	EndIf
Next nx

aItensG002	:= aClone(aItens)

If Altera
	DbSelectArea("SC6")
	DbSetOrder(1)
	If DbSeek(xFilial("SC6")+cPedido,.T.)
		While SC6->(!eof()) .and. xFilial("SC6")+cPedido == SC6->(C6_FILIAL+C6_NUM)
			//estorna liberação de todos os itens do pedido*************************************************************************************************
			SC6->(RecLock("SC6"))
			MaAvalSC6("SC6",2,"SC5",.F./*lLiber*/,.F./*lTransf*/,/*@lLiberOk*/,.T./*@lResidOk*/,.F./*@lFaturOk*/,Nil,0/*@nVlrCred*/,Nil,Nil,1/*nMoedaOri*/)
			SC6->(msunlock())
			//**********************************************************************************************************************************************
			nPosIt	:= aScan(aItensG002,{|x| x[nPItem] == SC6->C6_ITEM })
			If !nPosIt > 0
				RecLock("SC6",.F.)
				dbDelete()
				MsUnLock()
			EndIf
			SC6->(dbskip())
		End
	EndIf
EndIf

Return


User Function A002RetaCols()
Return aItensG002


User Function A002IniaCols()
aItensG002:={}
Return 