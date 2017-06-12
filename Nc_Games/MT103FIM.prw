#INCLUDE "Protheus.ch"
        	


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MT103FIM ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ponto de entrada utilizada após a gravação da nota fiscal  ³±±
±±³			 ³ de entrada									  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MT103FIM()

Local aArea := GetArea()
Local nOpc	:= PARAMIXB[2]


//Tratamento para E-commerce
If UPPER(Alltrim(SF1->F1_TIPO)) == "D" .And. (nOpc == 1)
	U_NCAtuDev(SF1->F1_DOC, SF1->F1_SERIE, SF1->F1_FORNECE, SF1->F1_LOJA)	
EndIf
RestArea(aArea)
Return 


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GrvCMG ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina utilizada para calcular e gravar o custo medio 	  ³±±
±±³			 ³ gerencial nos documentos de entrada						  ³±±
±±³			 ³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GrvCMG(cDoc, cSerie, cFornec, cLoja)

Local aArea 		:= GetArea()
Local aCMG			:= {}
Local cQuerySD1		:= "" 
Local cArqTmpSD1	:= GetNextAlias()
Local nCustAux		:= 0
Local aCustCMGDev	:= {0,0}	

Default cDoc	:= "" 
Default cSerie	:= "" 
Default cFornec	:= "" 
Default cLoja	:= ""

//Query para buscar os itens do documento de entrada SD1, com TES que movimenta estoque
cQuerySD1 := " SELECT SD1.R_E_C_N_O_ RECNOSD1 FROM "+RetSqlName("SD1")+" SD1 "+CRLF

cQuerySD1 += " INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cQuerySD1 += " ON SF4.D_E_L_E_T_ = ' ' "+CRLF
cQuerySD1 += " AND SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cQuerySD1 += " AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cQuerySD1 += " AND SF4.F4_ESTOQUE = 'S' "+CRLF

cQuerySD1 += " WHERE SD1.D_E_L_E_T_ = ' ' "+CRLF
cQuerySD1 += " AND SD1.D1_FILIAL = '"+xFilial("SD1")+"' "+CRLF
cQuerySD1 += " AND SD1.D1_DOC = '"+cDoc+"' "+CRLF
cQuerySD1 += " AND SD1.D1_SERIE = '"+cSerie+"' "+CRLF
cQuerySD1 += " AND SD1.D1_FORNECE = '"+cFornec+"' "+CRLF
cQuerySD1 += " AND SD1.D1_LOJA = '"+cLoja+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuerySD1), cArqTmpSD1 , .F., .T.)


DbSelectArea("SD1")
DbSetOrder(1)           
(cArqTmpSD1)->(DbGoTop())
While (cArqTmpSD1)->(!Eof())
	
	//Posiciona no item do documento de entrada
	DbGoTo((cArqTmpSD1)->RECNOSD1 )
	
	//Verifica se a nota fiscal e de devolução para buscar o custo utilizado na saída
	If Alltrim(SD1->D1_TIPO) == "D"
		aCustCMGDev := {0,0}
		
		//Verifica o custo gerencial BR e PP utilizado na saida
		aCustCMGDev := GetCGBRDev(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_NFORI, SD1->D1_SERIORI)
		
		If Len(aCustCMGDev) >= 2
			
			RecLock("SD1",.F.)
			
			//Verifica se o custo gerencia BR da saida é maior que 0, senão será utilizado o custo contabil
			If aCustCMGDev[1] != 0
				SD1->D1_YCMGBR	:= aCustCMGDev[1] * SD1->D1_QUANT//Custo gerencial BR
			Else
				SD1->D1_YCMGBR	:= SD1->D1_CUSTO//Custo gerencial BR
			EndIf
			
			
			//Verifica se existe price protection. Se existir o mesmo receberá o valor do CUSTO BR
			If u_VldPP(SD1->D1_COD, SD1->D1_EMISSAO) .And. (Alltrim(SD1->D1_TIPO) != "D")
				
				//Verifica se o custo PP e diferente de 0, senão será utilizado o valor do CMG BR
				If aCustCMGDev[2] != 0
					SD1->D1_YCUSGER := aCustCMGDev[2] * SD1->D1_QUANT//Custo Gerencial PP
				Else
					SD1->D1_YCUSGER := SD1->D1_YCMGBR
				EndIf
				
			EndIf
			
			
			
			//Chama a rotina para atualizar o saldo atual do Custo BR e PP
			U_GrvCMGB2(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_YCUSGER, SD1->D1_YCMGBR)
			
			
			
			
			SD1->(MsUnLock())
			
		EndIf
		
	Else
		
		
		
		//Verifica se o custo gerencial brasil foi preenchido. Se não foi, o mesmo receberá o valor do custo contabil
		If (SD1->D1_YPERCBR == 0)
			RecLock("SD1",.F.)
			SD1->D1_YCMGBR	:= SD1->D1_CUSTO//Custo gerencial BR
			SD1->(MsUnLock())
			
			
		Else
			
			DbSelectArea("SF4")
			DbSetOrder(1)
			If SF4->(DbSeek(xFilial("SF4") + SD1->D1_TES))
				
				//Verifica se é o produto é midia (Calcula o CMG BR)
				If (Alltrim(SF4->F4_YTIPONF) == "1")
					
					nCustAux := 0
					
					//Verifica o valor de compra do produto com o percentual aplicado
					nCustAux := GetVlComp(SD1->D1_DOC, SD1->D1_SERIE, SD1->D1_FORNECE, SD1->D1_LOJA, SD1->D1_COD, SD1->D1_ITEM, SD1->D1_YPERCBR, SD1->D1_TES)
					
					If nCustAux != 0
						RecLock("SD1",.F.)
						SD1->D1_YCMGBR	:= nCustAux//Custo gerencial BR
						SD1->(MsUnLock())
					Else
						RecLock("SD1",.F.)
						SD1->D1_YCMGBR	:= SD1->D1_CUSTO + ( (SD1->D1_CUSTO * SD1->D1_YPERCBR) / 100 ) //Custo gerencial BR
						SD1->(MsUnLock())
					EndIf
					
					
				ElseIf (Alltrim(SF4->F4_YTIPONF) $ "2|5")//CMG BR referente ao software ou outro com percentual
					
					RecLock("SD1",.F.)
					SD1->D1_YCMGBR	:= SD1->D1_CUSTO + ( (SD1->D1_CUSTO * SD1->D1_YPERCBR) / 100 )
					SD1->(MsUnLock())
					
					
				Else
					RecLock("SD1",.F.)
					SD1->D1_YCMGBR	:= SD1->D1_CUSTO//Custo gerencial BR
					SD1->(MsUnLock())
				EndIf
				
				
			EndIf
			
		EndIf
		
		
		//Verifica se existe price protection. Se existir o mesmo receberá o valor do CUSTO BR
		If u_VldPP(SD1->D1_COD, SD1->D1_EMISSAO) .And. (Alltrim(SD1->D1_TIPO) != "D")
			RecLock("SD1",.F.)
			SD1->D1_YCUSGER := SD1->D1_YCMGBR//aCMG[3]//Custo Gerencial PP
			SD1->(MsUnLock())
		EndIf
		
		
		
		//Chama a rotina para atualizar o saldo atual do Custo BR e PP
		U_GrvCMGB2(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_YCUSGER, SD1->D1_YCMGBR)
		
		
	EndIf
	(cArqTmpSD1)->(DbSkip())
EndDo

(cArqTmpSD1)->(DbCloseArea())
RestArea(aArea)
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GrvCMGB2 ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava o custo medio gerencial na tabela SB2			 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                            
User Function GrvCMGB2(cCod, cLocal, nCMG, nCMGBR, lSaida)

Local aArea 	:= GetArea()
Local nCMGAtu	:= 0
Local nCMGAux   := 0
Local nCMGAtuBR	:= 0
Local nCMGAuxBR := 0


Default cCod	:= "" 
Default cLocal	:= "" 
Default nCMG	:= 0            
Default nCMGBR	:= 0 
Default lSaida	:= .F.

DbSelectArea("SB2")
DbSetOrder(1)
If SB2->(DbSeek(xFilial("SB2") + PADR(cCod, TAMSX3("B2_COD")[1]) + PADR(cLocal, TAMSX3("B2_LOCAL")[1])   ))
	
	//Verifica se a atualização vem de um documento de saida
	If lSaida
		//Atualiza o total do CMG BR e CMG PP
		RecLock("SB2",.F.)
		SB2->B2_YTCMGBR := ( SB2->B2_YCMGBR * SB2->B2_QATU)		
		//SB2->B2_YTCMG := ( SB2->B2_YCMVG * SB2->B2_QATU)
		SB2->(MsUnLock())


	Else//Atualização de documento de entrada                                                  
		
        //Calculo referente o CMG BR
		nCMGAtuBR	:= SB2->B2_YTCMGBR
		nCMGAuxBR	:= ((nCMGAtuBR + nCMGBR) / SB2->B2_QATU)
		                            
		
		//Calculo referente o CMG pp
		nCMGAtu	:= SB2->B2_YTCMG
		nCMGAux	:= ((nCMGAtu + nCMG) / SB2->B2_QATU)
		                                      
		RecLock("SB2",.F.)

		SB2->B2_YCMGBR	:= nCMGAuxBR		
		SB2->B2_YTCMGBR := (nCMGAuxBR  * SB2->B2_QATU)
		//SB2->B2_YCMVG 	:= nCMGAux
		//SB2->B2_YTCMG 	:= (nCMGAux * SB2->B2_QATU)
		SB2->(MsUnLock())
	EndIf
EndIf


RestArea(aArea)
Return


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ VldPP	 ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina utilizada para verificar se existe price para o	  ³±±
±±³			 ³ produto na data de saida e/ou entrada. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VldPP(cCodProd, dDataEmis)

Local aArea 	:= GetArea()
Local cQueryPP  := ""
Local cArqPP	:= GetNextAlias()
Local lRet		:= .F.

Default cCodProd	:= "" 
Default dDataEmis	:= CTOD('')                 	


//Query utilizada para verificar se o Price Protection foi aplicado para este produto de acordo com o codigo e data de emissão da NF
cQueryPP := " SELECT P05_CODPP, P05_DTAPLI, P05_DTEFET, P05_CODPRO, P06_LOCAL, P06_QUANT, P06_VLUNIT FROM "+RetSqlName("P05")+" P05 "+CRLF

cQueryPP += " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQueryPP += " ON P06.P06_FILIAL = '"+xFilial("P06")+"' "
cQueryPP += " AND P06_CODPRO = '"+cCodProd+"' "+CRLF
cQueryPP += " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQueryPP += " AND P06.P06_LOCAL != ' ' "+CRLF
cQueryPP += " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQueryPP += " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "
cQueryPP += " AND P05.P05_DTAPLI <= '"+dtos(dDataEmis)+"' "+CRLF
cQueryPP += " AND P05.P05_DTEFET != ' ' "+CRLF
cQueryPP += " AND P05.D_E_L_E_T_ = ' ' "+CRLF
cQueryPP += " ORDER BY P05_CODPP, P06_LOCAL "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQueryPP), cArqPP , .F., .T.)

(cArqPP)->(DbGoTop())

If (cArqPP)->(!eof())
	lRet := .T.
EndIf

(cArqPP)->(DbCloseArea())

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetCtParamºAutor  ³Elton C.		     º Data ³  03/13/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o conteudo do parametro e ou cria o parametro       º±±
±±º          ³caso não exista                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                              	          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCtParam( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)
lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
RecLock( "SX6", lRecLock )
FieldPut( FieldPos( "X6_VAR" ), cMvPar )
FieldPut( FieldPos( "X6_TIPO" ), cTipo )
FieldPut( FieldPos( "X6_PROPRI" ), "U" )
If !Empty( cDescP )
	FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
	FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
	FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
EndIf
If !Empty( cDescS )
	FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
	FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
	FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
EndIf
If !Empty( cDescE )
	FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
	FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
	FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
EndIf
If lRecLock .Or. lAlter
	FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
	FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
	FieldPut( FieldPos( "X6_CONTENG" ), xValor )
EndIf

MsUnlock()

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn)

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
Static Function GetVlComp(cDoc, cSerie, cFornece, cLoja, cCodProd, cItem, nPerc, cTes)

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
Default cItem		:= "" // Item
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
cQuery	+= "  AND SD1.D1_ITEM = '"+cItem+"' "+CRLF
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
			nAux :=  (cAliasTmp)->D1_CUSTO + nAux 

			//Retorna o valor do CMG BR
			nRet := nAux
			
			
		ElseIf (Alltrim((cAliasTmp)->F4_YTIPONF) $ "2|5")//Calculo do Valor do Software/outros
			
			nAux := 0                                               

			//Custo do software, aplicando o percentual
			nAux := (cAliasTmp)->D1_CUSTO + ( ((cAliasTmp)->D1_CUSTO * nPerc) / 100 ) 
			
			//Retorna o valor do CMG BR			
			nRet := nAux 

		Else//Custo contabil para os demais tipos
			
			nRet := (cAliasTmp)->D1_CUSTO + ( ((cAliasTmp)->D1_CUSTO * nPerc) / 100 ) 
		EndIf
	
	
	Else//Se não tem percentual, então retornará o valor do custo contábil                                          
		
		nRet := (cAliasTmp)->D1_CUSTO
	EndIf   

Else
	nRet := 0
EndIf

//Fecha o alias utilizado na busca
(cAliasTmp)->(DbCloseArea())

RestArea(aArea)
Return nRet  






/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GetCGBRDev ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o custo gerencial de devolução br		 	      ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetCGBRDev(cCodProd, cArm, cDoc, cSerie)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd2	:= GetNextAlias()
Local aRet			:= {}//[1]CMG BR, [2]CMG PP

Default cCodProd	:= "" 
Default cArm		:= "" 
Default cDoc		:= "" 
Default cSerie		:= ""

cQuery := " SELECT D2_QUANT, D2_YCMVG, D2_YCMGBR, D2_CUSTO1 FROM "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery += " WHERE SD2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " 	AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "	+CRLF
cQuery += " 	AND SD2.D2_COD = '"+cCodProd+"' "+CRLF
cQuery += " 	AND SD2.D2_DOC = '"+cDoc+"' "+CRLF
cQuery += " 	AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd2 , .F., .T.)

(cArqTmpSd2)->(DbGoTop())
If (cArqTmpSd2)->(!Eof())
	
	 
	//Preenche o valor referente o CMG BR
	If (cArqTmpSd2)->D2_YCMGBR == 0
		Aadd(aRet, (cArqTmpSd2)->D2_CUSTO1 / (cArqTmpSd2)->D2_QUANT )
	Else
		Aadd(aRet, (cArqTmpSd2)->D2_YCMGBR  / (cArqTmpSd2)->D2_QUANT )
	EndIf                            
	
	
	//Preenche o valor referente o PP
	If (cArqTmpSd2)->D2_YCMVG != 0
		Aadd(aRet, (cArqTmpSd2)->D2_YCMVG / (cArqTmpSd2)->D2_QUANT	)
	Else
		If (cArqTmpSd2)->D2_YCMGBR == 0
			Aadd(aRet, (cArqTmpSd2)->D2_CUSTO1 / (cArqTmpSd2)->D2_QUANT)
		Else
			Aadd(aRet, (cArqTmpSd2)->D2_YCMGBR  / (cArqTmpSd2)->D2_QUANT)
		EndIf
	EndIf
	
EndIf

If Len(aRet) < 2
	aRet := {0,0}
EndIf


(cArqTmpSd2)->(DbCloseArea())

RestArea(aArea)
Return aRet

