Static aUltResult
Static aDescEsca


#include "Protheus.ch"
#DEFINE MAXGETDAD 4096
#DEFINE MAXSAVERESULT 4096

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³MaRgrDesc ³ Autor ³Eduardo Riera          ³ Data ³15.05.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina de avaliacao da regra de desconto para os modulos    ³±±
±±³          ³que possuem pedido de venda                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Produto                                              ³±±
±±³          ³ExpC2: Cliente                                              ³±±
±±³          ³ExpC3: Loja                                                 ³±±
±±³          ³ExpC4: Tabela                                               ³±±
±±³          ³ExpN5: Faixa de desconto                                    ³±±
±±³          ³ExpC6: Condicao de Pagamento                                ³±±
±±³          ³ExpC7: Forma de Pagamento                                   ³±±
±±³          ³ExpN8: Tipo de Desconto                                     ³±±
±±³          ³       1 - Desconto por Item                                ³±±
±±³          ³       2 - Desconto por Total                               ³±±
±±³          ³ExpA8: Array contendo a seguinte estrutura :                ³±±
±±³          ³       [n][1] : Codigo do produto                           ³±±
±±³          ³       [n][2] : Grupo  do produto                           ³±±
±±³          ³       [n][3] : Quantidade                                  ³±±
±±³          ³       Devem ser passados tods os produtos e as suas Qtdes. ³±±
±±³          ³       para ocalculo de descontos escalaveis.               ³±±
±±³          ³ExpA9: Array contendo as regras que NAO devem ser considera-³±±
±±³          ³       das.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpN1: Percentual de Desconto da Regra                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Esta rotina tem como objetivo avaliar a regra de descontos  ³±±
±±³          ³conforme os parametros da rotina                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Materiais/Distribuicao/Logistica                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Atualizacoes sofridas desde a Construcao Inicial.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Programador  ³ Data   ³ BOPS ³  Motivo da Alteracao                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Norbert Waage ³30/05/07³125797³Inclusao do campo ACO_CFAIXA na ordena- ³±±
±±³              ³        ³      ³cao da query. Em determinadas situacoes ³±±
±±³              ³        ³      ³o maior valor de desconto ficava por ul-³±±
±±³              ³        ³      ³timo no resultado da query(Somente TOP).³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function P_MaRgr(cProduto,cCliente,cLoja,cTabPreco,nFaixa,cCondPg,cFormPg,nTipo,aProds,aExc)

Static nRegPrior
Static aPesq

Local aArea     := GetArea()
Local aComp		:= {}
Local aCodReg   := {}
Local cPesq     := ""
Local cCampo    := ""
Local cCaracter := ""
Local cSeek     := ""
Local cCompara  := ""
Local cQuery    := ""
Local cKeySql   := ""
Local cAliasQry := ""
Local cRegrAtu	:= ""
Local nDesconto := 0
Local nX        := 0
Local nY        := 0
Local nZ        := 0
Local nW        := 0
Local lValido   := .F.
Local nOrdIndex := 0
Local nQuantTot := 0
Local lExistCpo := ACO->(FieldPos("ACO_GRPVEN")) > 0
Local aDescontos:= {}
Local cPeso	    :=	""
Local lExistEsca:=	(ACO->(FieldPos('ACO_ESCALA'))*ACO->(FieldPos('ACO_LOTE')) > 0).And.	GetNewPar("MV_DESCLOT",.F.)
Local nDescs	:=	0
Local cCnt		:=	""
Local aCpos		:=	{}
Local nCntFor	:=	1

If !ExistBlock("FT080RDES")
	If ACO->(Reccount()) > 0
		If Type("nStack")=="U"
			PRIVATE nStack := 1
			PRIVATE cUltRegra := ""
		Else
			nStack++
		EndIf

		DEFAULT cProduto  := Space(Len(SB1->B1_COD))
		DEFAULT cCliente  := Space(Len(SA1->A1_COD))
		DEFAULT cLoja     := Space(Len(SA1->A1_LOJA))
		DEFAULT cTabPreco := Space(Len(DA0->DA0_CODTAB))
		DEFAULT cCondPg   := Space(Len(DA0->DA0_CONDPG))
		DEFAULT cFormPg   := Space(Len(ACO->ACO_FORMPG))
		DEFAULT nFaixa    := 0
		DEFAULT nTipo     := 1
		DEFAULT nRegPrior := GetMV("MV_REGDPRI")
		DEFAULT aUltResult:= {}
		DEFAULT aPesq     := {}
		nX := aScan(aUltResult,{|x| (nTipo == 2 .Or. SubStr(x[1],1,Len(cProduto)) == cProduto) .And.;
			x[2] == cCliente .And.;
			x[3] == cLoja .And.;
			x[4] == cTabPreco .And.;
			x[5] == nFaixa .And.;
			x[6] == cCondPg .And.;
			x[7] == cFormPg .And.;
			x[8] == nTipo .And.;
			x[12]== cFilAnt})

		DbSelectArea("ACO")
		DbSetOrder(1)

		If nX == 0  .Or. Ascan(aExc,aUltResult[nX][10]) > 0 .Or.;
				(!Empty(aUltResult[nX][10]) .And. MsSeek(xFilial("ACO")+aUltResult[nX][10]) .And. !FtIsDataOk("ACO") )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verificar a ordem de pesquisa da Regra de Desconto                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("ACO")
			dbSetOrder(nRegPrior)
			If Empty(aPesq)
				cPesq := IndexKey()
				nY := Len(cPesq)+1
				For nX := 1 To nY
					cCaracter := SubStr(cPesq,nX,1)
					If ( cCaracter == "+" .Or. nX == nY )
						aadd(aPesq,AllTrim(cCampo))
						cCampo := ""
					Else
						cCampo += cCaracter
					EndIf
				Next nX			
			EndIf
			nY := Len(aPesq)			
			For nX := 1 To nY
				Do Case
				Case Len(aPesq)<nX

				Case aPesq[nX] == "ACO_CODCLI"
					aadd(aComp,cCliente)
					cKeySql += "+"+aPesq[nX]
				Case aPesq[nX] == "ACO_LOJA"
					aadd(aComp,cLoja)
					cKeySql += "+"+aPesq[nX]
				Case aPesq[nX] == "ACO_FILIAL"
					aadd(aComp,xFilial("ACO"))
					cKeySql += "+"+aPesq[nX]
				Case aPesq[nX] == "ACO_CODTAB"
					aadd(aComp,cTabPreco)
					cKeySql += "+"+aPesq[nX]
				Case aPesq[nX] == "ACO_CONDPG"
					aadd(aComp,cCondPg)
					cKeySql += "+"+aPesq[nX]
				Case aPesq[nX] == "ACO_FORMPG"
					aadd(aComp,cFormPg)
					cKeySql += "+"+aPesq[nX]
				OtherWise
					aPesq := aDel(aPesq,nX)
					aPesq := aSize(aPesq,Len(aPesq)-1)
					nX--
					nY--
				EndCase
			Next nX
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Retira os campos da ordem para encontrar os descontos genericos         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nX := nY To 2 STEP -1
				#IFDEF TOP
					cAliasQry := "MARGRDESC"

					cQuery := "SELECT ACO.ACO_PERDES "
					cQuery += "DESCONTO , ACO_CODREG"				
					If lExistEsca
						cQuery += ", ACO_ESCALA"				
					EndIf
					If lExistCpo
						cQuery += ", ACO_GRPVEN"				
					EndIf
					If ACO->(FieldPos("ACO_DATDE")) * ACO->(FieldPos("ACO_DATATE")) * ACO->(FieldPos("ACO_HORADE")) * ;
							ACO->(FieldPos("ACO_HORATE")) * ACO->(FieldPos("ACO_TPHORA"))  > 0
						cQuery	+=	",ACO_DATDE,ACO_DATATE,ACO_HORADE,ACO_HORATE,ACO_TPHORA " 	
						aCpos	:=	{ {'ACO_DATDE',"D",8,0},{'ACO_DATATE',"D",8,0}}
					EndIf
					cQuery += "FROM "+RetSqlName("ACO")+" ACO "
					If nTipo == 1
						cQuery += ", " + RetSqlName("ACP")+" ACP "
					EndIf
					cQuery += "WHERE ACO.ACO_FILIAL='"+xFilial("ACO")+"' AND "
					cQuery += "(ACO.ACO_CODCLI='"+Space(Len(SA1->A1_COD))+"' OR ACO.ACO_CODCLI='"+cCliente+"') AND "
					cQuery += "(ACO.ACO_LOJA='"+Space(Len(SA1->A1_LOJA))+"' OR ACO.ACO_LOJA='"+cLoja+"') AND "
					cQuery += "(ACO.ACO_CODTAB='"+Space(Len(DA0->DA0_CODTAB))+"' OR ACO.ACO_CODTAB = '"+cTabPreco+"') AND "
					cQuery += "(ACO.ACO_CONDPG='"+Space(Len(DA0->DA0_CONDPG))+"' OR ACO.ACO_CONDPG='"+cCondPg+"') AND "
					cQuery += "(ACO.ACO_FORMPG='"+Space(Len(ACO->ACO_FORMPG))+"' OR ACO.ACO_FORMPG='"+cFormPg+"') AND "
					cQuery += "ACO.D_E_L_E_T_=' ' AND "
					If nTipo == 2
						If !lExistEsca
							cQuery += " ACO.ACO_PERDES > 0 AND "
						EndIf
						cQuery += "ACO.ACO_FAIXA<="+Alltrim(StrZero(nFaixa,18,2))+" "
					Else
						cQuery += "ACP.ACP_FILIAL='"+xFilial("ACP")+"' AND "
						cQuery += "ACP.ACP_CODREG=ACO.ACO_CODREG AND "
						cQuery += "(ACP.ACP_CODPRO='"+Space(Len(SB1->B1_COD))+"' OR ACP.ACP_CODPRO='"+cProduto+"') AND "
						cQuery += "ACP.ACP_FAIXA>="+Alltrim(StrZero(nFaixa,18,2))+" AND "
						cQuery += "ACP.D_E_L_E_T_=' ' "
					EndIf
					cQuery += "ORDER BY "+StrTran(SubStr(cKeySql,2),"+"," DESC,") + ",ACO_CFAIXA"
					cQuery := ChangeQuery(cQuery)

					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)
					For nCntFor := 1 To Len(aCpos)
						TcSetField(cAliasQry,aCpos[nCntFor][1],aCpos[nCntFor][2],aCpos[nCntFor][3],aCpos[nCntFor][4])
					Next nCntFor
					While !Eof()
						If FtIsDataOk("ACO","MARGRDESC") .And. Ascan(aExc,(cAliasQry)->ACO_CODREG) == 0
							cPeso	:=	If(lExistCpo, FtIsGrpOk((cAliasQry)->ACO_GRPVEN,SA1->A1_GRPVEN),"00")
							If !Empty(cPeso)
								If nTipo == 1 .Or. (nTipo == 2 .And. lExistEsca .And. (cAliasQry)->ACO_ESCALA == '1')
									If Ascan(aCodReg,{|x| x[1]==(cAliasQry)->ACO_CODREG}) == 0
										Aadd(aCodReg,{(cAliasQry)->ACO_CODREG,cPeso,IIf(lExistEsca,(cAliasQry)->ACO_ESCALA,"")})
									EndIf                                        
								Else	                                                      
									nDesconto := If(MARGRDESC->DESCONTO==0,-1,MARGRDESC->DESCONTO)
									If nDesconto > 0
										cUltRegra	:=	ACO->ACO_CODREG
									EndIf
									AAdd(aDescontos,{cPeso,StrZero(999-Len(aDescontos),3),nDesconto,(cAliasQry)->ACO_CODREG,(cAliasQry)->ACO_CODREG})
								EndIf
								If nDesconto <> 0 .And. !lExistCpo .And. nTipo == 2
									cUltRegra	:=	(cAliasQry)->ACO_CODREG
									Exit
								EndIf
							Endif	
						EndIf
						dbSkip()
					EndDo

					dbSelectArea("MARGRDESC")
					dbCloseArea()
					dbSelectArea("ACO")
					Exit

				#ELSE
					cSeek    := ""
					cCompara := ""
					For nZ := 2 To nX
						cCompara += "+"+aPesq[nZ]
						cSeek += aComp[nZ]
					Next nZ
					cCompara := SubStr(cCompara,2)
					If cSeek <> ""
						If !Empty(cSeek)
							nW++
						EndIf
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Efetua a pesquisa do desconto                                           ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						dbSelectArea("ACO")
						//Ordem setada acima
						MsSeek(xFilial("ACO")+cSeek,.T.)
						While !Eof() .And. xFilial("ACO") == ACO->ACO_FILIAL .And. cSeek == &cCompara
							cPeso	:=	 If(lExistCpo, FtIsGrpOk(ACO->ACO_GRPVEN,SA1->A1_GRPVEN) ,"00")
							If FtIsDataOk("ACO") .And. !Empty(cPeso) .And. Ascan(aExc,ACO->ACO_CODREG) == 0
								lValido := .T.
								For nZ := 2 To nY
									If FieldGet(FieldPos(aPesq[nZ])) <> aComp[nZ] .And. !Empty(FieldGet(FieldPos(aPesq[nZ])))
										lValido := .F.
									EndIf
								Next nX
								If lValido
									If nTipo == 1 .Or. (nTipo == 2 .And. lExistEsca .And. ACO->ACO_ESCALA == '1')
										If Ascan(aCodReg,{|x| x[1] == ACO->ACO_CODREG}) == 0
											Aadd(aCodReg,{ACO->ACO_CODREG,cPeso,IIf(lExistEsca,ACO->ACO_ESCALA,"")})
										EndIf
									Else
										IF nFaixa >= ACO->ACO_FAIXA
											nDesconto := If(ACO->ACO_PERDES==0,-1,ACO->ACO_PERDES)
											If nDesconto > 0
												cUltRegra	:=	ACO->ACO_CODREG
											EndIf
											AAdd(aDescontos,{cPeso,StrZero(999-Len(aDescontos),3),nDesconto,ACO->ACO_CODREG,ACO->ACO_CODREG})
										EndIf
									EndIf
								Else
									If ( nDesconto <> 0 .And. nTipo == 2 ) .And.!lExistCpo
										Exit
									EndIf
								EndIf
								If lValido .And. nTipo == 2    .And. !lExistCpo
									If nFaixa >= ACO->ACO_FAIXA
										cUltRegra	:=	ACO->ACO_CODREG
										Exit
									EndIf
								EndIf
							EndIf
							dbSelectArea("ACO")
							dbSkip()
						EndDo
						If ( nDesconto <> 0 .And. nTipo == 2 ).And.!lExistCpo
							Exit
						EndIf
					EndIf
				#EndIf
			Next nX
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³A ordem para escolher os descontos sera determinada pelo peso do grupo  ³
			//³de vendas mas a ordem em que foi achado                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lExistCpo .And. Len(aDescontos) > 0
				aSort(aDescontos,,,{|x,y| x[1]+x[2] > y[1]+y[2] })
				nDesconto	:=	If(aDescontos[1][3] == 0,-1,aDescontos[1][3])
				If nDesconto > 0
					cUltRegra	:=	If(aDescontos[1][3] == 0,cUltRegra,aDescontos[1][4])
				EndIf
				aDescontos	:=	{}
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Pesquisa o Desconto por Item                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( nTipo == 1 .And. !Empty(aCodReg) )
				For nX := 1 To Len(aCodReg)
					dbSelectArea("SB1")
					dbSetOrder(1)
					MsSeek(xFilial("SB1")+cProduto)
					dbSelectArea("ACP")
					dbSetOrder(2)
					If MsSeek(xFilial("ACP")+aCodReg[nX][1]+Space(Len(SB1->B1_GRUPO))+cProduto)
						While ( !Eof() .And. ACP->ACP_CODREG == aCodReg[nX][1] .And.;
								ACP->ACP_GRUPO == Space(Len(SB1->B1_GRUPO)) .And.;
								SubStr(ACP->ACP_CODPRO,1,Len(cProduto)) == cProduto )
							If nFaixa <= ACP->ACP_FAIXA
								nDesconto := If(ACP->ACP_PERDES==0,-1,ACP->ACP_PERDES)
								If nDesconto <> 0 .And.!lExistCpo
									Exit
								Else
									AAdd(aDescontos, {aCodReg[nX][2],StrZero(999-Len(aDescontos),3),nDesconto,aCodReg[nX][2],aCodReg[nX][1]} )
								EndIf
							EndIf
							dbSelectArea("ACP")
							dbSkip()
						EndDo
						If nDesconto <> 0.And.!lExistCpo
							cUltRegra	:=	ACO->ACO_CODREG
							Exit
						EndIf
					EndIf
					dbSelectArea("ACP")
					dbSetOrder(2)
					If MsSeek(xFilial("ACP")+aCodReg[nX][1]+SB1->B1_GRUPO)
						While ( !Eof() .And. ACP->ACP_CODREG == aCodReg[nX][1] .And.;
								ACP->ACP_GRUPO == SB1->B1_GRUPO .And.;
								ACP->ACP_CODPRO == Space(Len(SB1->B1_COD)) )
								If nFaixa <= ACP->ACP_FAIXA
									nDesconto := If(ACP->ACP_PERDES==0,-1,ACP->ACP_PERDES)
									If nDesconto <> 0 .And. !lExistCpo
										Exit
									Else
										AAdd(aDescontos, {aCodReg[nX][2],StrZero(999-Len(aDescontos),3),nDesconto,aCodReg[nX][2],aCodReg[nX][1]} )
									EndIf
								EndIf
							dbSelectArea("ACP")
							dbSkip()
						EndDo
						If nDesconto <> 0.And.!lExistCpo
							cUltRegra	:=	aCodReg[nX][2]
							Exit
						EndIf
					EndIf
				Next nX
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³A ordem para escolher os descontos sera determinada pelo peso do grupo  ³
				//³de vendas mas a ordem em que foi achado                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lExistCpo .And. Len(aDescontos) > 0
					aSort(aDescontos,,,{|x,y| x[1]+x[2] > y[1]+y[2] })
					nDesconto	:=	If(aDescontos[1][3] == 0,-1,aDescontos[1][3])
					If nDesconto > 0
						cUltRegra	:=	If(aDescontos[1][3] == 0,cUltRegra,aDescontos[1][4])
						cRegrAtu	:= aDescontos[1][5]
					EndIf
					aDescontos	:=	{}
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Pesquisa o desconto por total para o desconto escalavel                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ElseIf (nTipo == 2 .And. !Empty(aCodReg) )
				For nX := 1 To Len(aCodReg)	
					If lExistEsca.And. aCodReg[nX][3] == "1"
						DbSelectArea("ACO")
						nOrdIndex:=IndexOrd()
						DbSetOrder(1)
						MsSeek(xFilial("ACO")+aCodReg[nX])
						DbSetOrder(nOrdIndex)					
						dbSelectArea("ACP")
						dbSetOrder(2)
						If MsSeek(xFilial("ACP")+aCodReg[nX])
							cPeso	:=	If(lExistCpo, FtIsGrpOk(ACO->ACO_GRPVEN,SA1->A1_GRPVEN),"00")
							nQuantTot	:=	0
							While ( !Eof() .And. ACP->ACP_CODREG == aCodReg[nX] ).And. FtIsDataOk("ACO") .And. !Empty(cPeso)
								nPosProd	:=	If(Empty(ACP->ACP_CODPRO), Ascan(aProds,{|x| ACP->ACP_GRUPO == X[2]}), Ascan(aProds,{|x| ACP->ACP_CODPRO == X[1]}) )
								If nPosProd > 0
									nQuantTot	+=	aProds[nPosProd][3]
								EndIf
								dbSelectArea("ACP")
								dbSkip()
							EndDo
							If nQuantTot >= ACO->ACO_LOTE
								nDesconto	:=	ACO->ACO_PERDES
								cCnt	:=	'2'
								While ACO->(FieldPos('ACO_LOTE'+cCnt)) > 0  .And. ;
										nQuantTot >= ACO->(FieldGet(FieldPos('ACO_LOTE'+cCnt))) .And. ;
										ACO->(FieldGet(FieldPos('ACO_LOTE'+cCnt)))  > 0
									nDesconto	:=	ACO->(FieldGet(FieldPos('ACO_PERDE'+cCnt)))
									cCnt	:=	SOMA1(cCnt)
								EndDo
								AAdd(aDescontos, {cPeso,StrZero(999-Len(aDescontos),3),nDesconto,ACO->ACO_CODREG,ACO->ACO_CODREG} )
							Else
								nDesconto	:=	0
							EndIf
							If nDesconto <> 0.And.!lExistCpo
								cUltRegra	:=	ACO->ACO_CODREG
								Exit
							EndIf
						EndIf
					EndIf
				Next nX
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³A ordem para escolher os descontos sera determinada pelo peso do grupo  ³
				//³de vendas mas a ordem em que foi achado                                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lExistCpo .And. Len(aDescontos) > 0
					aSort(aDescontos,,,{|x,y| x[1]+x[2] > y[1]+y[2] })
					nDesconto	:=	If(aDescontos[1][3] == 0,-1,aDescontos[1][3])
					If nDesconto > 0
						cUltRegra	:=	If(aDescontos[1][3] == 0,cUltRegra,aDescontos[1][4])
					EndIf
				EndIf	
				aDescontos	:=	{}
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Determina para cada produto ou grupo a % de desconto                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				ACP->(MsSeek(xFilial()+cUltRegra))
				While ACP->ACP_CODREG == cUltRegra .And. !ACP->(EOF())
					nDescs	:=	0
					If Empty(ACP->ACP_CODPRO)
						While  (nDescs   := Ascan(aProds,{|x| x[2] == ACP->ACP_GRUPO },nDescs+1  ) ) > 0
							aProds[nDescs][4] := nDesconto
							aProds[nDescs][5] := .F.
						EndDo
					Else
						While  (nDescs   := Ascan(aProds,{|x| x[1] == ACP->ACP_CODPRO},nDescs+1  ) ) > 0
							aProds[nDescs][4] := nDesconto
						EndDo
					EndIf
					ACP->(DbSkip())
				EndDo
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Retira o primeiro campo da chave e continua a busca recursiva           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( nDesconto == 0 )
				For nX := nY-nW+1 To nY
					Do Case
					Case aPesq[nX] == "ACO_CODCLI"
						cCliente := Nil
					Case aPesq[nX] == "ACO_LOJA"
						cLoja := Nil
					Case aPesq[nX] == "ACO_CODTAB"
						cTabPreco := Nil
					Case aPesq[nX] == "ACO_CONDPG"
						cCondPg := Nil
					Case aPesq[nX] == "ACO_FORMPG"
						cFormPg := Nil
					EndCase
					aRetRegr	:= u_P_MaRgr(cProduto,cCliente,cLoja,cTabPreco,nFaixa,cCondPg,cFormPg,nTipo,aProds,aExc)
					nDesconto := aRetRegr[1,1]
//					nDesconto := u_P_MaRgr(cProduto,cCliente,cLoja,cTabPreco,nFaixa,cCondPg,cFormPg,nTipo,aProds,aExc)
					If nDesconto <> 0
						Exit
					EndIf
				Next nX
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Guarda os ultimos resultados                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aadd(aUltResult,{cProduto,cCliente,cLoja,cTabPreco,nFaixa,cCondPg,cFormPg,nTipo,nDesconto,cUltRegra,aClone(aProds),cFilAnt})
			If Len(aUltResult) > MAXSAVERESULT
				aUltResult := aDel(aUltResult,1)
				aUltResult := aSize(aUltResult,MAXSAVERESULT)
			EndIf
		Else
			nDesconto	:= aUltResult[nX][09]
			aProds		:=	aClone(aUltResult[nX][11])
			If nDesconto > 0
				cUltRegra	:=	aUltResult[nX][10]
			EndIf
		EndIf
		RestArea(aArea)
		If nStack == 1
			nDesconto := Max(0,nDesconto)
		Else
			nStack--
		EndIf
	EndIf
Else
	nDesconto := ExecBlock("FT080RDES",.F.,.F.,{cProduto,cCliente,cLoja,cTabPreco,nFaixa,cCondPg,cFormPg,nTipo,aProds,aExc})
EndIf
                  
/*If nDesconto > 0
 cRegrAtu	:= acodreg[len(acodreg),1]
Else
 cRegrAtu	:= " "
EndIf*/
aRetRegr	:= {}
aadd(aRetRegr,{nDesconto,cRegrAtu})

Return(aRetRegr)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FtRegraDesc³ Autor ³Eduardo Riera          ³ Data ³15.05.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gatilho para atualizacao do desconto no pedido de venda     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1: Tipo de Desconto                                     ³±±
±±³          ³       1 - Desconto de Item de PV                           ³±±
±±³          ³       2 - Desconto de Item de Orcamento                    ³±±
±±³          ³       3 - Desconto de Cabecalho de PV                      ³±±
±±³          ³       4 - Desconto de Cabecalho de Orcamento               ³±±
±±³          ³ExpN2: Total dos Valores da Mercadoria sem Desconto         ³±±
±±³          ³ExpN3: Variavel de desconto de cabecalho a ser atualizada   ³±±
±±³          ³ExpA4: Array contendo as regras que NAO devem ser considera-³±±
±±³          ³       das.                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpN1: Percentual de Desconto da Regra                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Esta rotina tem como objetivo atualizar o campo C6_DESCONT  ³±±
±±³          ³de acordo com o pedido de venda                             ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³  Usado nos campos C6_PRODUTO e C6_QTDVEN                   ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Materiais/Distribuicao/Logistica                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function p_FtRegraD(nTipo,nTotDoc,nDescCab,aRegrasExc)

Local aArea     := GetArea()
Local aAreaTmp  := {}
Local aProds	:= {}
Local nDesconto := 0
Local cRegrAtu  := ""
Local nPosProd  := 0
Local nPQtdVen  := 0
Local nPosGrp   := 0
Local nPosQtd   := 0
Local nPPrcVen  := 0
Local nPPrUnit  := 0
Local nPValor   := 0
Local nPDescont := 0
Local nDesc		:= 0
Local nCnt		:= 0
Local nX        := 0
Local nPContrat := 0
Local cCampo    := ReadVar()
Local cProduto  := ""
Local lDescEsca	:=	GetNewPar("MV_DESCLOT",.F.)

DEFAULT nTipo   := 1
DEFAULT nTotDoc := 0
DEFAULT nDescCab:= 0
DEFAULT aRegrasExc:={}
Do Case
Case nTipo == 1 .And. M->C5_TIPO=="N"
	If ACO->(MsSeek(xFilial("ACO")))
		aDescEsca := If(aDescEsca <> Nil .And. Len(aDescEsca) < Len(aCols),Nil,aDescEsca)
		nPosProd  := Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_PRODUTO"})
		nPQtdVen  := Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_QTDVEN"})
		nPContrat := Ascan(aHeader,{|x| AllTrim(x[2]) == "C6_CONTRAT"})
		cProduto  := aCols[n][nPosProd]
		If MatGrdPrrf(cProduto)
			MatGrdPrrf(@cProduto,.T.)
		EndIf
		If aCols[n,nPQtdVen]>0 .And. (nPContrat==0 .Or. Empty(aCols[n,nPContrat]) )
			aRetRegr  := u_P_MaRgr(cProduto,M->C5_CLIENTE,M->C5_LOJACLI,M->C5_TABELA,aCols[n,nPQtdVen],M->C5_CONDPAG,,1,,aRegrasExc)
			nDesconto := aRetRegr[1,1]
			cRegrAtu  := aRetRegr[1,2]
//			nDesconto := u_P_MaRgr(cProduto,M->C5_CLIENTE,M->C5_LOJACLI,M->C5_TABELA,aCols[n,nPQtdVen],M->C5_CONDPAG,,1,,aRegrasExc)
		EndIf
		If lDescEsca .And. aDescEsca <> Nil .And. aDescEsca[n] > 0
			nTot	:=	100 - nDesconto
			nTot	-=	nTot * aDescEsca[n] /100
			nDesconto	:=	100 - nTot
		EndIf
	Else
		nPDescont := Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_DESCONT"})
		If nPDescont <> 0
			nDesconto := aCols[N][nPDescont]
		EndIf
	EndIf
Case nTipo == 2
	If ACO->(MsSeek(xFilial("ACO")))
		aDescEsca := If(aDescEsca <> Nil .And. Len(aDescEsca) < TMP1->(Reccount()),Nil,aDescEsca)
		If TMP1->CK_QTDVEN > 0 .And. Empty(TMP1->CK_CONTRAT)
			aRetRegr  := u_P_MaRgr(TMP1->CK_PRODUTO,M->CJ_CLIENTE,M->CJ_LOJA,M->CJ_TABELA,TMP1->CK_QTDVEN,M->CJ_CONDPAG,,1,,aRegrasExc)
			nDesconto := aRetRegr[1,1]
			cRegrAtu  := aRetRegr[1,2]

//			nDesconto := u_P_MaRgr(TMP1->CK_PRODUTO,M->CJ_CLIENTE,M->CJ_LOJA,M->CJ_TABELA,TMP1->CK_QTDVEN,M->CJ_CONDPAG,,1,,aRegrasExc)
		EndIf
		If lDescEsca .And. aDescEsca <> Nil .And. aDescEsca[TMP1->(Recno())] > 0
			nTot	:=	100 - nDesconto
			nTot	-=	nTot * aDescEsca[TMP1->(Recno())] /100
			nDesconto	:=	100 - nTot
		EndIf
		M->CK_DESCONT := nDesconto
		A415Descon()
	Else
		nDesconto := TMP1->CK_DESCONT
	EndIf
Case nTipo == 3 .And. M->C5_TIPO=="N" .And. nTotDoc > 0
	If ACO->(MsSeek(xFilial("ACO")))
		nPosProd  	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_PRODUTO"})
		nPosQtd  	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_QTDVEN"})
		cProduto  := aCols[n][nPosProd]
		If MatGrdPrrf(cProduto)
			cProduto := MatGrdPrrf(@cProduto,.T.)
		EndIf
		aDescEsca	:=	Array(Len(aCols)+1)		
		aFill(aDescEsca,0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcular o total de produtos suas quantidades para calcular o desconto escalable³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lDescEsca
			For nX	:=	1	To	Len(aCols)
				If (Len(aCols[nX]) == Len(aHeader)+1) .And. !aCols[nX][Len(aCols[nX])]
					nPos	:=	Ascan(aProds,{|x| x[1] == aCols[nX][nPosProd]})
					If nPos > 0
						aProds[nPos][3] += aCols[nX][nPosQtd]
					Else
						AAdd(aProds,{aCols[nX][nPosProd],Posicione('SB1',1,xFilial('SB1')+aCols[nX][nPosProd],"B1_GRUPO"),aCols[nX][nPosQtd],0,.T.})
					EndIf
				EndIf
			Next
		EndIf
		aRetRegr  := u_P_MaRgr(cProduto,M->C5_CLIENTE,M->C5_LOJACLI,M->C5_TABELA,nTotDoc,M->C5_CONDPAG,,2,aProds,aRegrasExc)
		nDesconto := aRetRegr[1,1]
		cRegrAtu  := aRetRegr[1,2]
//		nDesconto := u_P_MaRgr(cProduto,M->C5_CLIENTE,M->C5_LOJACLI,M->C5_TABELA,nTotDoc,M->C5_CONDPAG,,2,aProds,aRegrasExc)
		If nDescCab <> nDesconto
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se houve desconto escalavel, aplicar ele a cada um dos ³
			//³produtos que fazem parte da regra.                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lDescEsca .Or. ACO->(FIELDPOS('ACO_ESCALA')) == 0 .Or. Posicione('ACO',1,xFilial('ACO')+cUltRegra,'ACO_ESCALA') <> '1'
				nDescCab  := nDesconto
			Else
				//Distribui no array dos descontos escalaveis os descontos
				For nX := 1 To Len(aProds)
					If aProds[nX][5]
						nCnt	:=	Ascan(aCols,{|x| x[nPosProd] == aProds[nX][1]})
						While nCnt > 0
							aDescEsca[nCnt]	:=	aProds[nX][4]
							nCnt	:=	Ascan(aCols,{|x| x[nPosProd] == aProds[nX][1]},nCnt+1)
						EndDo
					Else
						nCnt	:=	Ascan(aCols,{|x| x[nPosProd] == aProds[nX][2]})
						While nCnt > 0
							aDescEsca[nCnt]	:=	aProds[nX][4]
							nCnt	:=	Ascan(aCols,{|x| Posicione('SB1',1,xFilial('SB1')+x[nPosProd],"B1_GRUPO") == aProds[nX][2]},nCnt+1)
						EndDo
					EndIf
				Next
			EndIf
			a410Recalc(.T.)
			lRefresh	:=	.T.
		EndIf
	EndIf
Case nTipo == 4 .And. nTotDoc > 0
	If ACO->(MsSeek(xFilial("ACO")))
		aDescEsca	:=	Array(TMP1->(Reccount())+1)
		aFill(aDescEsca,0)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcular o total de produtos suas quantidades para calcular o desconto escalable³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lDescEsca
			aAreaTmp	:=	TMP1->(GetArea())
			TMP1->(DbGoTop())
			While !TMP1->(EOF())
				If TMP1->(FieldPos('CK_FLAG')) > 0 .And. !TMP1->CK_FLAG
					nPos	:=	Ascan(aProds,{|x| x[1] == TMP1->CK_PRODUTO})
					If nPos > 0
						aProds[nPos][3] += TMP1->CK_QTDVEN
					Else
						AAdd(aProds,{TMP1->CK_PRODUTO,Posicione('SB1',1,xFilial('SB1')+TMP1->CK_PRODUTO,"B1_GRUPO"),TMP1->CK_QTDVEN,0,.T.})
					EndIf
				EndIf
				TMP1->(DbSkip())
			EndDo
			RestArea(aAreaTmp)
		EndIf
		aRetRegr  := u_P_MaRgr(TMP1->CK_PRODUTO,M->CJ_CLIENTE,M->CJ_LOJA,M->CJ_TABELA,nTotDoc,M->CJ_CONDPAG,,2,aProds,aRegrasExc)
		nDesconto := aRetRegr[1,1]
		cRegrAtu  := aRetRegr[1,2]

//		nDesconto := u_P_MaRgr(TMP1->CK_PRODUTO,M->CJ_CLIENTE,M->CJ_LOJA,M->CJ_TABELA,nTotDoc,M->CJ_CONDPAG,,2,aProds,aRegrasExc)
		If nDescCab <> nDesconto
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se houve desconto escalavel, aplicar ele a cada um dos ³
			//³produtos que fazem parte da regra.                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lDescEsca .Or. ACO->(FIELDPOS('ACO_ESCALA')) == 0 .Or. Posicione('ACO',1,xFilial('ACO')+cUltRegra,'ACO_ESCALA') <> '1'
				nDescCab  := nDesconto
			Else
				//Distribui no array dos descontos escalaveis os descontos
				aAreaTmp	:=	TMP1->(GetArea())
				TMP1->(DbGoTop())
				While !TMP1->(EOF())
					nCnt	:=	Ascan(aProds,{|x| x[5] .And. TMP1->CK_PRODUTO==x[1]})
					If nCnt > 0 .And. aProds[nCnt][4] > 0
						aDescEsca[TMP1->(Recno())]	:=	aProds[nCnt][4]
					Else
						nCnt	:=	Ascan(aProds,{|x| !x[5] .And. Posicione('SB1',1,xFilial('SB1')+TMP1->CK_PRODUTO,"B1_GRUPO")==x[2]})
						If nCnt > 0 .And. aProds[nCnt][4] > 0
							aDescEsca[TMP1->(Recno())]	:=	aProds[nCnt][4]
						EndIf
					EndIf
					TMP1->(DbSkip())
				EndDo
				RestArea(aAreaTmp)
			EndIf
			A415DesCab(.T.,.F.,.T.)
		EndIf
	EndIf
EndCase
RestArea(aArea)

If nDesconto > 0
// cRegrAtu	:= cRegrAtu
Else
 cRegrAtu	:= " "
EndIf


aRetRegra	:= {}
aadd(aRetRegra,{nDesconto,cRegrAtu})

Return(aRetRegra)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GAT_MARGR   ºAutor  ³Microsiga           º Data ³  02/03/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function GAT_MARGR

_aArea	:= GetArea()

nPosProd	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRODUTO'})
nPosRegDes := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_REGDESC'})
nPosPRegDe := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PREGDES'})

aReg	:= U_p_FtRegraD(1)

aCols[n,nPosRegDes]	:= aReg[1,2]
aCols[n,nPosPRegDe]	:= aReg[1,1]


RestArea(_aArea)

Return aReg[1,1]




Return