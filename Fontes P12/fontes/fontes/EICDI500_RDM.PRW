#INCLUDE "protheus.ch"


User Function EICDI500()


Local cParam := ParamIxb


If Alltrim(cParam) == "FINAL_OPCAO" 




	
	If !IsBlind() //Rotina executada apenas para processos visuais. Não utilizado em caso de schedule (Job)
	    
		
		//Verifica se o numero da DI foi preenchido no desembaraço
		If !Empty(SW6->W6_DI_NUM)
						
			If Aviso("Numero da DI Preenchido", "O número da DI foi preenchido, deseja excluir os títulos do tipo PRE de n.º "+SW6->W6_NUMDUP+".",;
						 {"Sim","Não"}) == 1
						 
						 
			    //Chama a rotina para excluir os titulos do tipo PRE
				ExcTitPag(SW6->W6_NUMDUP, "EIC", "PRE")
				
			EndIf
	    EndIf
	EndIf
	

EndIf

Return                                       


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ExcTitPag  º Autor ³ Elton C.			 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para excluir os titulos a pagar do tipo PREº±±
±±º          ³					  						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                 
Static Function ExcTitPag(cNumTit, cPrefixo, cTipo)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local lContinua	:= .T.

Default cNumTit		:= "" 
Default cPrefixo	:= "" 
Default cTipo		:= ""
                         
cQuery := " SELECT R_E_C_N_O_ RECNOSE2 FROM "+RetSqlName("SE2")+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND E2_FILIAL = '"+xFilial("SE2")+"' "+CRLF
cQuery += " AND E2_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery += " AND E2_NUM = '"+cNumTit+"' "+CRLF
cQuery += " AND E2_TIPO = '"+cTipo+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)                        


DbSelectArea("SE2")
DbSetOrder(1)

//Nao utilizado Execauto, devido o processo inicial não utilizar
//deixando de gravar dados necessários para utilização do Execauto.
//Obs. Ratificando que os titulos do tipo PRE é temporario
(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
	SE2->(DbGoTo((cArqTmp)->RECNOSE2))
	
	If RecLock("SE2",.F.)
		SE2->(DbDelete())
	Else
		lContinua := .F.
	EndIf
	SE2->(MsUnLock())
		
	(cArqTmp)->(DbSkip())
EndDo

If lContinua
	Aviso("OKEXCTITPAG", "Titulo(s) "+cNumTit+" do tipo PRE excluido com sucesso...",{"Ok"},2)
Else
	Aviso("ERREXCTITPAG", "Erro na tentativa de excluir o Titulo(s) "+cNumTit+" do tipo PRE.",{"Ok"},2)
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


