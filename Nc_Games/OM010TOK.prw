#INCLUDE "PROTHEUS.CH"
Static cUserAut	:=Alltrim(U_MyNewSX6("TAB_NCG001","000307;000086;000334","C","Usu�rio autorizado a alterar tabela de pre�os","","",.F. )   )
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �OM010TOK  �Autor  �Microsiga           � Data �  07/15/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function OM010TOK()
Local aAreaAtu	:=GetArea()
Local aAreaDA1	:=DA1->(GetArea())
Local lRetorno	:=.T.
Local oModel	:=FwModelActive()
Local oView		:=oModel:GetModel("DA1DETAIL")
Local cMensagem:=""
Local nInd
Local nContar	:=0
Local ENTER		:=Chr(13)+Chr(10)
Local lFound	

DA1->(DbSetOrder(2))//DA1_FILIAL+DA1_CODTAB+DA1_CODPRO+DA1_INDLOT+DA1_ITEM

If !__cUserId$cUserAut
	
	For nInd := 1 To oView:Length()
		
		oView:GoLine( nInd )
		
		lFound:=DA1->(MsSeek(xFilial("DA1")+oView:GetValue("DA1_CODPRO")+oView:GetValue("DA1_CODTAB")+oView:GetValue("DA1_ITEM")) )

		If oView:IsInserted() .Or. !lFound
			Loop
		EndIf
		
		If oView:IsDeleted()
			cMensagem+="Item "+oView:GetValue("DA1_ITEM")+" exclus�o  n�o permitida."+ENTER
			oView:UnDeleteLine()
			nContar++
		EndIf		
		
	Next
	
	
	If nContar>0
		Aviso(ProcName(0)+" Linha:"+AllTrim(Str(ProcLine())),IIf(nContar==1,"Manuten��o n�o permitida","Manuten��es n�o permitidas")+ENTER+ENTER+cMensagem,{"Ok"},3)
		lRetorno:=.F.
	EndIf
		
EndIf

//For nInd := 1 To oView:Length()
//	If oView:GetValue("DA1_PRCVEN") == 0
//		MsgAlert("O campo Pre�o de venda deve ser maior que R$ 0,00","Prc_Vazio")
//		lRetorno:=.F.
//	EndIf
//Next
   


RestArea(aAreaDA1)
RestArea(aAreaAtu)
Return lRetorno



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �OM010TOK  �Autor  �Microsiga           � Data �  08/14/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function OMSAVALID(cCampo)
Local aAreaAtu	:=GetArea()
Local aAreaDA1	:=DA1->(GetArea())
Local lRetorno:=.T.
Local oModel	:=FwModelActive()
Local oView		:=oModel:GetModel("DA1DETAIL")
Local cMensagem:=""

If !__cUserId$cUserAut

	If cCampo=="DA1_PRCVEN" .Or. cCampo=="DA1_CODPRO"
		DA1->(DbSetOrder(3))//DA1_FILIAL+DA1_CODTAB+DA1_ITEM
		oView:GoLine( oView:GetLine() )
		If DA1->(MsSeek(xFilial("DA1")+oView:GetValue("DA1_CODTAB")+oView:GetValue("DA1_ITEM")) ) 
		                      
		
			If cCampo=="DA1_PRCVEN" .And.  DA1->DA1_PRCVEN<>M->DA1_PRCVEN
				cMensagem+="Item "+oView:GetValue("DA1_ITEM")+" altera�ao de pre�o n�o permitida."			
			EndIf
			
			
			If cCampo=="DA1_CODPRO" .And.   DA1->DA1_CODPRO<>M->DA1_CODPRO
				cMensagem+="Item "+oView:GetValue("DA1_ITEM")+" altera�ao de c�digo n�o permitida."			
			EndIf

		
			Aviso(ProcName(0)+" Linha:"+AllTrim(Str(ProcLine())),"Manuten��o n�o permitida"+CRLF+CRLF+cMensagem,{"Ok"},3)
			lRetorno:=.F.
		EndIf
		RestArea(aAreaDA1)
	EndIf		


EndIf

RestArea(aAreaAtu)
Return  lRetorno