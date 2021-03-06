#INCLUDE "protheus.ch"


User Function EICDI500()


Local cParam := ParamIxb


If Alltrim(cParam) == "FINAL_OPCAO" 




	
	If !IsBlind() //Rotina executada apenas para processos visuais. N�o utilizado em caso de schedule (Job)
	    
		
		//Verifica se o numero da DI foi preenchido no desembara�o
		If !Empty(SW6->W6_DI_NUM)
						
			If Aviso("Numero da DI Preenchido", "O n�mero da DI foi preenchido, deseja excluir os t�tulos do tipo PRE de n.� "+SW6->W6_NUMDUP+".",;
						 {"Sim","N�o"}) == 1
						 
						 
			    //Chama a rotina para excluir os titulos do tipo PRE
				ExcTitPag(SW6->W6_NUMDUP, "EIC", "PRE")
				
			EndIf
	    EndIf
	EndIf
	

EndIf

Return                                       


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ExcTitPag  � Autor � Elton C.			 � Data �  04/09/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina utilizada para excluir os titulos a pagar do tipo PRE���
���          �					  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
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

//Nao utilizado Execauto, devido o processo inicial n�o utilizar
//deixando de gravar dados necess�rios para utiliza��o do Execauto.
//Obs. Ratificando que os titulos do tipo PRE � temporario
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


