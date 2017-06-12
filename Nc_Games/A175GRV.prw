#INCLUDE "PROTHEUS.CH"



/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A175GRV ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ponto de entrada utilizada após a baixa do CQ			  ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function A175GRV()

Local aArea 	:= GetArea()
Local cNumCQ	:= SD7->D7_NUMERO

//Chama a rotina para gravar o custo medio gerencial na baixa do CQ, nas tabelas SD3
BxCqCMG(cNumCQ)


RestArea(aArea)
Return       


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³BxCqCMG		 ³ Autor ³ELTON SANTANA		³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Efetua o calculo do custo medio gerencial BR e PP na baixa ³±±
±±³			 ³ do CQ     									  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function BxCqCMG(cNumDoc)

Local aArea 	:= GetArea() 
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aCMG		:= {0,0}
Local nPerc		:= 0

Default cNumDoc := ""

cQuery := " SELECT R_E_C_N_O_ RECNOSD3 FROM "+RetSqlName("SD3")+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND D3_FILIAL = '"+xFilial("SD3")+"' "+CRLF
cQuery += " AND D3_DOC = '"+cNumDoc+"' "+CRLF
cQuery += " AND D3_YFBXCQ != 'S' "+CRLF
cQuery += " ORDER BY D3_DOC, D3_COD "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("SD3")
DbSetOrder(1)
aCMG 	:= {0,0}
While (cArqTmp)->(!Eof())
	
	DbGoTo((cArqTmp)->RECNOSD3 )
	If "RE" $ SD3->D3_CF
		
		nPerc		:= 0
		
		//Verifica o percentual utilizado no CMG BR no documento de entrada
		nPerc		:= GetPBxCQ(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_DOC, SD3->D3_IDENT, SD3->D3_NUMSEQ, SD3->D3_QUANT, SD3->D3_CUSTO1)
		
		//Verifica se existe percentua a ser aplicado
		If nPerc != 0
			
			//Grava o CMG no documento de origem (Saida)
			Reclock("SD3", .F.)
			SD3->D3_YCMGBR	:= SD3->D3_CUSTO1 + ( (SD3->D3_CUSTO1 * nPerc ) / 100)
			SD3->D3_YFBXCQ	:= 'S'
			
			//Verifica se existe price protection para este produto
			If u_VldPP(SD3->D3_COD, SD3->D3_EMISSAO)
				SD3->D3_YCUSGER := SD3->D3_YCMGBR
			Else
				SD3->D3_YCUSGER := 0
			EndIf
			
			SD3->(MsUnLock())
			
			//Atualiza o custo gerencial origem
			u_GrvCMGB2(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_YCUSGER, SD3->D3_YCMGBR, .T.)
			
		Else//Não existe percentual aplicado, sendo assim, o cmg br deverá ser o mesmo que o contábil
			
			//Grava o CMG no documento de origem (Saida)
			Reclock("SD3", .F.)
			SD3->D3_YCMGBR	:= SD3->D3_CUSTO1
			SD3->D3_YFBXCQ	:= 'S'
			
			//Verifica se existe price protection para este produto
			If u_VldPP(SD3->D3_COD, SD3->D3_EMISSAO)
				SD3->D3_YCUSGER := SD3->D3_CUSTO1
			Else
				SD3->D3_YCUSGER := 0
			EndIf
			
			SD3->(MsUnLock())
			
			//Atualiza o custo gerencial origem
			u_GrvCMGB2(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_YCUSGER, SD3->D3_YCMGBR, .T.)
			
		EndIf
	ElseIf "DE" $ SD3->D3_CF
		
		nPerc := 0
		
		//Verifica o percentual aplicado no documento origem
		nPerc := GetSd3Ent(SD3->D3_COD, SD3->D3_DOC, DTOS(SD3->D3_EMISSAO), SD3->D3_NUMSEQ, SD3->D3_IDENT)
		
		//Verifica se existe percentual a ser aplicado
		If nPerc != 0
			
			//Grava o CMGBR e CMGPP com o mesmo valor do documento origem
			Reclock("SD3", .F.)
			SD3->D3_YCMGBR	:= SD3->D3_CUSTO1 + ( (SD3->D3_CUSTO1 * nPerc ) / 100)
			SD3->D3_YFBXCQ	:= 'S'
			
			//Verifica se existe price protection para este produto
			If u_VldPP(SD3->D3_COD, SD3->D3_EMISSAO)
				SD3->D3_YCUSGER := SD3->D3_YCMGBR
			Else
				SD3->D3_YCUSGER := 0
			EndIf
			
			SD3->(MsUnLock())
			
			//Atualiza o custo gerencial destino
			u_GrvCMGB2(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_YCUSGER, SD3->D3_YCMGBR)
			
		Else
			
			//Grava o CMG no documento de origem (Saida)
			Reclock("SD3", .F.)
			SD3->D3_YCMGBR	:= SD3->D3_CUSTO1
			SD3->D3_YFBXCQ	:= 'S'

			//Verifica se existe price protection para este produto
			If u_VldPP(SD3->D3_COD, SD3->D3_EMISSAO)
				SD3->D3_YCUSGER := SD3->D3_CUSTO1
			Else
				SD3->D3_YCUSGER := 0
			EndIf
			
			SD3->(MsUnLock())
			
			//Atualiza o custo gerencial origem
			u_GrvCMGB2(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_YCUSGER, SD3->D3_YCMGBR, .T.)
			
			
		EndIf
		
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return                                                            




/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GetPBxCQ ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o percentual do CMG BR na baixa do CQ	 	      ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetPBxCQ(cCodProd, cLocal, cDoc, cIdent, cNumSeq, nQuant, nCust)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd3	:= GetNextAlias()
Local nRet			:= 0

Default cCodProd	:= "" 
Default cLocal		:= "" 
Default cDoc		:= "" 
Default cIdent		:= ""                         
Default cNumSeq		:= ""
Default nQuant		:= 0                 
Default nCust		:= 0


cQuery := " SELECT D7_PRODUTO, D7_NUMSEQ, D7_NUMERO, D7_TIPO, D7_QTDE, D7_SALDO, D7_SEQ, "+CRLF
cQuery += " D1_TIPO, D1_DOC, D1_SERIE, D1_COD, D1_QUANT, D1_FORNECE, D1_LOJA, D1_CUSTO, D1_YCMGBR, D1_YCUSGER, D1_TES, "+CRLF
cQuery += " D3_EMISSAO, D3_DOC, D3_LOCAL, D3_TM, D3_CF, D3_SEQCALC, D3_IDENT, "+CRLF
cQuery += " D3_NUMSEQ, D3_QUANT, D3_CUSTO1, D3_YCUSGER, D3_YCMGBR  FROM "+RetSqlName("SD7")+" SD7 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SD1")+" SD1 "+CRLF
cQuery += " ON SD1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SD1.D1_FILIAL = SD7.D7_FILIAL "+CRLF
cQuery += " AND SD1.D1_COD = SD7.D7_PRODUTO "+CRLF
cQuery += " AND SD1.D1_DOC = SD7.D7_DOC "+CRLF
cQuery += " AND SD1.D1_LOCAL = SD7.D7_LOCAL "+CRLF
cQuery += " AND SD1.D1_SERIE = SD7.D7_SERIE "+CRLF
cQuery += " AND SD1.D1_FORNECE = SD7.D7_FORNECE "+CRLF
cQuery += " AND SD1.D1_LOJA = SD7.D7_LOJA "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SD3")+" SD3 "+CRLF
cQuery += " ON SD3.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SD3.D3_DOC = SD7.D7_NUMERO "+CRLF
cQuery += " AND SD3.D3_LOCAL = SD7.D7_LOCAL "+CRLF
cQuery += " AND SD3.D3_COD = SD7.D7_PRODUTO "+CRLF
cQuery += " AND SD3.D3_IDENT = '"+cIdent+"' "+CRLF
cQuery += " AND SD3.D3_NUMSEQ = '"+cNumSeq+"' "+CRLF
cQuery += " AND SD3.D3_CUSTO1 = '"+Alltrim(Str(nCust))+"' "+CRLF

cQuery += " WHERE SD7.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SD7.D7_FILIAL = '"+xFilial("SD7")+"' "+CRLF
cQuery += " AND SD7.D7_NUMERO = '"+cDoc+"'  "+CRLF
cQuery += " AND ((SD7.D7_NUMSEQ = '"+cIdent+"') OR (SD7.D7_NUMSEQ = '"+cNumSeq+"')) "+CRLF
cQuery += " AND SD7.D7_PRODUTO = '"+cCodProd+"' "+CRLF
cQuery += " AND SD7.D7_LOCAL = '"+cLocal+"' "+CRLF
cQuery += " AND SD7.D7_QTDE = '"+Alltrim(Str(nQuant))+"' "+CRLF

cQuery += " ORDER BY D7_SEQ "+CRLF

cQuery := ChangeQuery(cQuery)
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd3 , .F., .T.)

(cArqTmpSd3)->(DbGoTop())
If (cArqTmpSd3)->(!Eof())
	
	DbSelectArea("SF4")
	DbSetOrder(1)
	If !Empty((cArqTmpSd3)->D1_TES) .And. SF4->(DbSeek(xFilial("SF4") + (cArqTmpSd3)->D1_TES))
	                                          
		//Verifica o percentual utilizado na baixa do CQ
		If Alltrim(SF4->F4_YTIPONF) $ "1|2|5"
			nRet := (((cArqTmpSd3)->D1_YCMGBR * 100) / (cArqTmpSd3)->D1_CUSTO) - 100
			
		Else
			nRet := 0
		EndIf
		
	EndIf
	
Else
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet

                                 
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GetSd3Ent ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o custo da transferencia na entrada		 	      ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetSd3Ent(cCodProd, cDoc, cEmissao, cNumSeq, cIdent)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd3	:= GetNextAlias()
Local nRet			:= 0

Default cCodProd	:= "" 
Default cDoc		:= "" 
Default cEmissao	:= ""                  
Default cIdent		:= ""
Default cNumSeq		:= ""

cQuery := " SELECT D3_YCMGBR, D3_CUSTO1 FROM "+RetSqlName("SD3")+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "      +CRLF
cQuery += "  AND D3_FILIAL = '"+xFilial("SD3")+"' "+CRLF
cQuery += "  AND D3_COD = '"+cCodProd+"' "+CRLF
cQuery += "  AND D3_DOC = '"+cDoc+"' "+CRLF
cQuery += "  AND D3_NUMSEQ = '"+cNumSeq+"' "+CRLF
cQuery += "  AND D3_IDENT = '"+cIdent+"' "+CRLF
cQuery += "  AND D3_EMISSAO = '"+cEmissao+"' "+CRLF
cQuery += "  AND SUBSTR(D3_CF,1,2) = 'RE' "+CRLF
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd3 , .F., .T.)

(cArqTmpSd3)->(DbGoTop())
If (cArqTmpSd3)->(!Eof())
	If (cArqTmpSd3)->D3_YCMGBR == 0
		nRet := 0	
	Else
		nRet := (((cArqTmpSd3)->D3_YCMGBR * 100) / (cArqTmpSd3)->D3_CUSTO1) - 100
	EndIf              
Else            
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet


