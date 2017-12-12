#INCLUDE "PROTHEUS.CH"



/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �MT261TDOK � Autor �ELTON SANTANA		    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ponto de entrada utilizado ap�s a grava��o da trasnferencia���
���			 � 						  			  						  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MT261TDOK()

Local aArea := GetArea()

//Chama a rotina para gravar o custo medio gerencial
//CmgD3(SD3->D3_DOC)
TrCmgD3(SD3->D3_DOC)

RestArea(aArea)
Return 



/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �TrCmgD3 � Autor �ELTON SANTANA		    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Efetua o calculo do custo medio gerencial de acordo com    ���
���			 � o CMG atual									  			  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function TrCmgD3(cNumDoc)

Local aArea 	:= GetArea() 
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aCMG		:= {0,0}
Local nCustAux  := 0

Default cNumDoc := ""

cQuery := " SELECT R_E_C_N_O_ RECNOSD3 FROM "+RetSqlName("SD3")+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND D3_FILIAL = '"+xFilial("SD3")+"' "+CRLF
cQuery += " AND D3_DOC = '"+cNumDoc+"' "+CRLF
cQuery += " ORDER BY D3_DOC, D3_COD "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("SD3")
DbSetOrder(1)
aCMG 	:= {0,0}
While (cArqTmp)->(!Eof())
    
    DbGoTo((cArqTmp)->RECNOSD3 ) 
	If "RE" $ SD3->D3_CF
		
		//Recupera o CMG atual do documento origem
		aCMG := GetCMGB2(SD3->D3_COD, SD3->D3_LOCAL)	
	    
	    If Len(aCMG) >= 2
			//Grava o CMG no documento de origem (Saida)
			Reclock("SD3", .F.)
			SD3->D3_YCMGBR	:= (aCMG[1] * SD3->D3_QUANT)
			
			//Verifica se existe price protection para este produto
			If u_VldPP(SD3->D3_COD, SD3->D3_EMISSAO)
				SD3->D3_YCUSGER := (aCMG[2] * SD3->D3_QUANT)
			Else
				SD3->D3_YCUSGER := 0
			EndIf

			SD3->(MsUnLock())
        
        	//Atualiza o custo gerencial origem
			u_GrvCMGB2(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_YCUSGER, SD3->D3_YCMGBR, .T.)
		EndIf                               
		
	ElseIf "DE" $ SD3->D3_CF
		
		nCustAux := 0
		nCustAux := GetSd3Ent(SD3->D3_COD, SD3->D3_DOC, DTOS(SD3->D3_EMISSAO), SD3->D3_NUMSEQ, SD3->D3_IDENT)
		
		//Grava o CMGBR e CMGPP com o mesmo valor do documento origem
		Reclock("SD3", .F.)
		SD3->D3_YCMGBR	:= nCustAux
		
		//Verifica se existe price protection para este produto
		If u_VldPP(SD3->D3_COD, SD3->D3_EMISSAO)                       
			SD3->D3_YCUSGER := nCustAux
		Else
			SD3->D3_YCUSGER := 0
		EndIf
		
		SD3->(MsUnLock())
		
		//Atualiza o custo gerencial destino
		u_GrvCMGB2(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_YCUSGER, SD3->D3_YCMGBR)
        
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return                                                            
 
/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � GetCMGB2 � Autor �ELTON SANTANA		    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna o custo medio gerencial atual da tabela SB2	 	  ���
���			 � 					  										  ���
���			 � 															  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function GetCMGB2(cCod, cLocal)

Local aArea 	:= GetArea()
Local aRet		:= {0,0}

Default cCod	:= "" 
Default cLocal	:= "" 

DbSelectArea("SB2")
DbSetOrder(1)                       
If !Empty(cCod) .And. !Empty(cLocal)
	If SB2->(DbSeek(xFilial("SB2") + PADR(cCod, TAMSX3("B2_COD")[1]) + PADR(cLocal, TAMSX3("B2_LOCAL")[1])   ))
		aRet := {SB2->B2_YCMGBR, SB2->B2_YCMVG}
	Else
		aRet := {0,0}
	EndIf
Else
	aRet := {0,0}
EndIf

RestArea(aArea)
Return aRet


/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
�?��Fun��o    �GetSd3Ent � Autor �ELTON SANTANA		    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna o custo da transferencia na entrada		 	      ���
���			 � 												  			  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
		nRet := (cArqTmpSd3)->D3_CUSTO1	
	Else
		nRet := (cArqTmpSd3)->D3_YCMGBR
	EndIf              
Else            
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet