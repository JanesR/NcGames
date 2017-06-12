#INCLUDE "Protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UPDCMGBR	ºAutor  ³Elton C.		 	 º Data ³  05/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Atualiza o custo gerencial Brasil para os itens que não     º±±
±±º          ³contem o CMG BR     										  º±±
±±ÌÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATUALCBR()

Local aArea 	:= GetArea()
Local cQuerySB2 := ""
Local cQuerySD1 := ""
Local cQuerySD2 := ""
Local cQuerySD3 := ""


//Query para atualiza a coluna do custo brasil com o mesmo custo contabil
cQuerySD1 := " UPDATE "+RetSqlName("SD1")+" SET D1_YCMGBR = D1_CUSTO "+CRLF
cQuerySD1 += " WHERE D1_YCMGBR = '0' "+CRLF
cQuerySD1 += " AND D1_FILIAL = '"+xFilial("SD1")+"' "+CRLF
TCSQLExec(cQuerySD1)

cQuerySD2 := " UPDATE "+RetSqlName("SD2")+" SET D2_YCMGBR = D2_CUSTO1 "+CRLF
cQuerySD2 += " WHERE D2_YCMGBR = '0' "+CRLF
cQuerySD2 += " AND D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
TCSQLExec(cQuerySD2)

cQuerySD3 := " UPDATE "+RetSqlName("SD2")+" SET D3_YCMGBR = D3_CUSTO1 "+CRLF
cQuerySD3 += " WHERE D3_YCMGBR = '0' "+CRLF
cQuerySD3 += " AND D3_FILIAL = '"+xFilial("SD3")+"' "+CRLF
TCSQLExec(cQuerySD3)

cQuerySB2 := " UPDATE "+RetSqlName("SB2")+" SET B2_YCMGBR = B2_CM1, B2_YTCMGBR = (B2_QATU * B2_CM1) "+CRLF
cQuerySB2 += " WHERE B2_YCMGBR = '0' "+CRLF
cQuerySB2 += " AND B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
TCSQLExec(cQuerySB2)

RestArea(aArea)
Return 




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GCMGBRD1  ºAutor  ³Elton C.            º Data ³  01/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para preencher o Custo Medio Gerencial Brasil       º±±
±±º          ³de acordo com o percentual.			                      º±±
±±º          ³										                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GCMGBRD1(nCMGBR, nPercCMGBR)

Local aArea := GetArea()
Local nRet	:= 0

Default nCMGBR		 := 0                  
Default nPercCMGBR   := 0

//Efetua o calculo do CMG BR ao preencher o campo D1_VUNIT
nRet := nCMGBR + ( (nCMGBR * nPercCMGBR) / 100   )

RestArea(aArea)
Return nRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GVlPrdBR  ºAutor  ³Elton C.            º Data ³  01/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para retornar o valor de compra do produto,º±±
±±º          ³em caso da aplicação do percentual do custo BR.             º±±
±±º          ³O valor de compra será retirado do processo de importação   º±±
±±º          ³												              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GVlPrdBR(cDoc, cSerie, cFornece, cLoja, cCodProd, nPerc)

Local aArea 	:= GetArea()
Local nRet		:= 0

Default cDoc		:= "" //Nota Fiscal
Default cSerie		:= "" //Serie
Default cFornece	:= "" // Fornecedor
Default cLoja		:= "" //Loja
Default cCodProd	:= "" //Produto
Default nPerc		:= 0 //Percentual



If !Empty(GDFIELDGET("D1_TES"))

	DbSelectArea("SF4")
	DbSetOrder(1)
	If SF4->(DbSeek(xFilial("SF4") + GDFIELDGET("D1_TES")))
		
		
		If (Alltrim(SF4->F4_YTIPONF) == "1")//CMG BR referente a midia
			nRet := GetVlComp(cDoc, cSerie, cFornece, cLoja, cCodProd, nPerc, SF4->F4_CODIGO)

			If nRet == 0
				nRet := GDFIELDGET("D1_TOTAL") + ( (GDFIELDGET("D1_TOTAL") * nPerc) / 100 )			
			EndIf
		
		ElseIf (Alltrim(SF4->F4_YTIPONF) $ "2|5")//CMG BR referente ao software ou outro com percentual
			nRet := GDFIELDGET("D1_TOTAL") + ( (GDFIELDGET("D1_TOTAL") * nPerc) / 100 )
			
		Else//CMG BR referente as despesas
			nRet := GDFIELDGET("D1_TOTAL")
		EndIf
	EndIf
	
Else
	nRet := GDFIELDGET("D1_TOTAL") + ( (GDFIELDGET("D1_TOTAL") * nPerc) / 100 )
EndIf

RestArea(aArea)
Return nRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetVlComp  ºAutor  ³Elton C.          º Data ³  01/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o valor de compra do produto						  º±±
±±º          ³             												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetVlComp(cDoc, cSerie, cFornece, cLoja, cCodProd, nPerc, cTes)

Local aArea 	:= GetArea()
Local cQuery	:= "" 
Local cAliasTmp	:= GetNextAlias()
Local nRet		:= 0
Local nAux		:= 0

Default cDoc		:= "" //Nota Fiscal
Default cSerie		:= "" //Serie
Default cFornece	:= "" // Fornecedor
Default cLoja		:= "" //Loja
Default cCodProd	:= "" //Produto
Default nPerc		:= 0 //Percentual
Default cTes		:= ""

cQuery	:= " SELECT WN_FILIAL, WN_HAWB, WN_DOC, WN_SERIE, WN_PO_NUM, WN_ITEM, WN_PRODUTO, WN_QUANT, WN_VALOR, WN_CIF, WN_FOB_R, "+CRLF
cQuery	+= "         D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_QUANT, D1_CUSTO, D1_COD, D1_LOCAL, D1_TOTAL, "+CRLF
cQuery += "         F4_YTIPONF, "+CRLF
cQuery += "         B1_COD, B1_DESC, B1_MIDIA "+CRLF
cQuery	+= "          FROM "+RetSqlName("SD1")+" SD1 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SWN")+" SWN "+CRLF
cQuery	+= " ON SWN.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND SWN.WN_FILIAL = '"+xFilial("SWN")+"' "
//cQuery	+= " AND SWN.WN_HAWB = SD1.D1_CONHEC "
cQuery	+= " AND SWN.WN_DOC = SD1.D1_DOC "
cQuery	+= " AND SWN.WN_SERIE = SD1.D1_SERIE "
cQuery	+= " AND SWN.WN_FORNECE = SD1.D1_FORNECE "
cQuery	+= " AND SWN.WN_LOJA = SD1.D1_LOJA "
cQuery	+= " AND SWN.WN_ITEM = SD1.D1_ITEM "
cQuery	+= " AND SWN.WN_PRODUTO = SD1.D1_COD "


cQuery += " INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cQuery += " ON SF4.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cQuery += " AND SF4.F4_CODIGO = '"+cTes+"' "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery += " ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery += " AND SB1.B1_COD = SD1.D1_COD "+CRLF

        
cQuery	+= " WHERE SD1.D_E_L_E_T_ = ' '  "+CRLF
cQuery	+= "  AND SD1.D1_FILIAL = '"+xFilial("SD1")+"'  "+CRLF
cQuery	+= "  AND SD1.D1_DOC = '"+cDoc+"' "+CRLF
cQuery	+= "  AND SD1.D1_SERIE = '"+cSerie+"' "+CRLF
cQuery	+= "  AND SD1.D1_FORNECE = '"+cFornece+"' "+CRLF
cQuery	+= "  AND SD1.D1_LOJA = '"+cLoja+"' "+CRLF
cQuery	+= "  AND SD1.D1_COD = '"+cCodProd+"' "+CRLF
cQuery	+= "  AND SD1.D1_TIPO != 'D' "+CRLF
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasTmp, .F., .T.)

(cAliasTmp)->(DbGoTop())
//Verifica se encontrou registro
If (cAliasTmp)->(!eof())
	
	//Verifica se é aplicado o percentual
	If nPerc != 0
		
		
		If (Alltrim((cAliasTmp)->F4_YTIPONF) == "1")//Efetua o calculo do valor da midia (Valor de compra)
			nAux := 0                                                                                                           

			nAux := ((cAliasTmp)->WN_FOB_R * nPerc)  /100
			nAux :=  (cAliasTmp)->D1_TOTAL + nAux 

			//Retorna o valor do CMG BR
			nRet := nAux
			
			
		ElseIf (Alltrim((cAliasTmp)->F4_YTIPONF) $ "2|5")//Calculo do Valor do Software/outros
			
			nAux := 0                                               

			//Custo do software, aplicando o percentual
			nAux := (cAliasTmp)->D1_TOTAL + ( ((cAliasTmp)->D1_TOTAL * nPerc) / 100 ) 
			
			//Retorna o valor do CMG BR			
			nRet := nAux 

		Else//Custo contabil para os demais tipos
			
			nRet := (cAliasTmp)->D1_TOTAL + ( ((cAliasTmp)->D1_TOTAL * nPerc) / 100 ) 
		EndIf
	
	
	Else//Se não tem percentual, então retornará o valor do custo contábil                                          
		
		nRet := (cAliasTmp)->D1_TOTAL
	EndIf   

Else
	nRet := 0
EndIf

//Fecha o alias utilizado na busca
(cAliasTmp)->(DbCloseArea())

RestArea(aArea)
Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPCMGBR  ºAutor  ³Elton C.            º Data ³  01/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para preencher o percentual do Custo Medio          º±±
±±º          ³Gerencial Brasil						                      º±±
±±º          ³										                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPCMGBR(cCodProd, cTes)  

Local aArea := GetArea()
Local nRet	:= 0

Default cCodProd 	:= ""        
Default cTes		:= ""

If !Empty(cCodProd) .And. !Empty(cTes)
	
	
	//Verifica se a tes é de midai, software, ou outros que utilizam o CMG BR
	DbSelectArea("SF4")
	DbSetOrder(1)
	If SF4->(DbSeek(xFilial("SF4") + cTes ))
		
		If Alltrim(SF4->F4_YTIPONF) $ "1|2|5"
			
			DbSelectArea("SA2")
			DbSetOrder(1)
			If !Empty(cA100for)
				If SA2->(DbSeek(xFilial("SA2") + cA100for + cLoja)		)
					
					//Verifica se para este fornecedor é eftuado o calculo do CMG BR
					If Alltrim(SA2->A2_YCMGBR) == "1"
						
						DbSelectArea("SB5")
						DbSetOrder(1)
						If SB5->(DbSeek(xFilial("SB5") + cCodProd ))
							//Verifica se para este produto é efetuado o calculo do CMG BR
							If Alltrim(SB5->B5_YCMGBR) == "1"
								
								nRet := SB5->B5_YPERCBR
								
								//Se o percentual não foi preenchido no cadastro do complemento do produtos, então será utilizado
								//o percentual informado no cadastro de fornecedor
								If nRet == 0
									
									//Preenche o percentual de acordo com o informado no cadastro de fornecedor
									nRet := SA2->A2_YPERCBR
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndIf

RestArea(aArea)
Return nRet

