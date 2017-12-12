#INCLUDE "PROTHEUS.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Fa330Vld  ºAutor  ³Elton C.            º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de Entrada na validação da compensação da NCC	      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fa330Vld()

Local aArea := GetArea()
Local lRet	:= .T.

//Validação na compensação do titulo (ncc) referente o Price Protection
lRet := VldRNCCPP(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_TIPO, aTitulos)

RestArea(aArea)
Return lRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldRNCCPP  ºAutor  ³Elton C.            º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para efetuar a validação da compensação,   º±±
±±º          ³no momento da baixa.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldRNCCPP(cPrefixo, cNum, cParcela, cTipo, aTitMark)

Local aArea 		:= GetArea()
Local lRet			:= .T.
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local nX			:= 0
Local cVlTitAux		:= ""
Local nVlTitAux		:= 0

Default cPrefixo	:= "" 
Default cNum		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""
Default aTitMark  	:=  {}//Titulos marcados e não marcados


cQuery := " SELECT PZ5_CLIENT, PZ5_LOJA, PZ5_PREFIX, PZ5_TITULO, PZ5_PARCEL, PZ5_CODPP, PZ5_CODPUB, "
cQuery += " PZD_CODPP, PZD_CLIENT, PZD_LOJA, PZD_TPREP "+CRLF
cQuery += " FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF
  
cQuery += " INNER JOIN "+RetSqlName("PZD")+" PZD "+CRLF
cQuery += " ON PZD.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery += " AND PZD.PZD_CODPP = PZ5.PZ5_CODPP "+CRLF
cQuery += " AND PZD.PZD_CLIENT = PZ5.PZ5_CLIENT "+CRLF
cQuery += " AND PZD.PZD_LOJA = PZ5.PZ5_LOJA "+CRLF
  
cQuery += " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "   AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery += "   AND PZ5.PZ5_PREFIX = '"+cPrefixo +"' "+CRLF
cQuery += "   AND PZ5.PZ5_TITULO = '"+cNum+"' "+CRLF
cQuery += "   AND PZ5.PZ5_PARCEL = '"+cParcela+"' "+CRLF
cQuery += "   AND PZ5.PZ5_TIPO = '"+cTipo+"' "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->(DbGoTop())
If (cArqTmp)->(!Eof())
    
    //Verifica se o repasse é em produto                                                 
    //Se o repasse for em produto, então o valor so poderá ser utilizado para notas fiscais que tem, produtos do Publisher
	If Alltrim((cArqTmp)->PZD_TPREP) == "2"           

		For nX := 1 To Len(aTitMark)
			
			//Verifica se o titulo esta marcado
			If aTitMark[nX][8]             
				//Converte o valor caracter em valor numerico
				cVlTitAux := ""
				nVlTitAux := 0
				cVlTitAux := Alltrim(STRTRAN(aTitMark[nX][7],'.',''))
				cVlTitAux := Alltrim(STRTRAN(cVlTitAux,',','.'))
				nVlTitAux := Val(cVlTitAux)
								
				//Chama a rotina para verificar se existe produtos do publisher a ser utilizado na NCC
			 	lRet := VldPubNF(aTitMark[nX][2], aTitMark[nX][1], (cArqTmp)->PZ5_CLIENT, (cArqTmp)->PZ5_LOJA, nVlTitAux, (cArqTmp)->PZ5_CODPUB )
			EndIf			
			
			//Verifica se a NCC não foi validada, para retornar .F. a rotina principal
			If !lRet
				Exit
				Return lRet	
			EndIf
	 	Next
	 	
	Else 
		//Se o repasse for em credito, o mesmo poderá se rusado para qualquer nota fiscal
    	lRet := .T.
	EndIf
	
EndIf


(cArqTmp)->(DbCloseArea())         

                        
RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldRNCCPP  ºAutor  ³Elton C.            º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para efetuar a validação da compensação,   º±±
±±º          ³no momento da baixa.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldPubNF(cDoc, cSerie, cClient, cLoja, nValRep, cCodPub )

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cDPubAux	:= ""

Default cDoc	:= "" 
Default cSerie	:= "" 
Default cClient	:= "" 
Default cLoja	:= "" 
Default nValRep	:= 0 
Default cCodPub := ""
                  

cQuery    := "  SELECT D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, SUM(D2_TOTAL) D2_TOTAL, B1_ITEMCC, B1_PUBLISH, CTD_ITEM, CTD_DESC01 "+CRLF
cQuery    += " FROM "+RetSqlName("SD2")+" SD2 " +CRLF
  
cQuery    += "   INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery    += "   ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += "   AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery    += "   AND SB1.B1_COD = SD2.D2_COD "+CRLF
cQuery    += "   AND SB1.B1_ITEMCC = '"+cCodPub+"' "+CRLF
  
cQuery    += "   INNER JOIN "+RetSqlName("CTD")+" CTD "+CRLF
cQuery    += "   ON CTD.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += "   AND CTD.CTD_FILIAL = '"+xFilial("CTD")+"' "+CRLF
cQuery    += "   AND CTD.CTD_ITEM =  SB1.B1_ITEMCC "+CRLF
    
cQuery    += "   WHERE SD2.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += "   AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
cQuery    += "   AND SD2.D2_DOC = '"+cDoc+"' "+CRLF
cQuery    += "   AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF
cQuery    += "   AND SD2.D2_CLIENTE = '"+cClient+"' "+CRLF
cQuery    += "   AND SD2.D2_LOJA = '"+cLoja+"' "+CRLF

cQuery    += " GROUP BY D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, B1_ITEMCC, B1_PUBLISH, CTD_ITEM, CTD_DESC01 "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	If (cArqTmp)->D2_TOTAL < nValRep
		lRet	:= .F.
		Aviso("VLDCOMPENS", "A soma do(s) valor(es) do(s) produto(s) do Publisher: "+Alltrim((cArqTmp)->B1_PUBLISH)+;
								" para nota fiscal: "+Alltrim((cArqTmp)->D2_DOC)+"/"+Alltrim((cArqTmp)->D2_SERIE)+;
								" é menor que o valor de repasse. O valor de repasse para este titulo "+CRLF+;
								" não poderá ultrapassar: "+Alltrim(Transform((cArqTmp)->D2_TOTAL ,"@E 999,999,999,999.99"))+".",{"Ok"},2)
								
	Else 
		lRet	:= .T.
    EndIf
Else
    DbSelectArea("CTD")
    DbSetOrder(1)
    If CTD->(DbSeek(xFilial("CTD") + cCodPub) )
		cDPubAux := Alltrim(CTD->CTD_DESC01)
	EndIf                    
	
	lRet	:= .F.
	Aviso("VLDCOMPENS", "Não é possível compensar o Titulo: "+Alltrim(cDoc)+". O cliente optou pelo repasse em produto. "+CRLF+;
							"Sendo assim, a NCC só poderá ser utilizada para os títulos que contém os "+CRLF+;
							"produtos do Publisher: "+cCodPub+"-"+Alltrim(cDPubAux)+" na Nota Fiscal.",{"Ok"},2)	
	
	
EndIf


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet