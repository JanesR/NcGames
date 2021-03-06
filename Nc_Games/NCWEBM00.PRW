#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"


Class ApiWebManager

	Data cParametros
	Data cToken
	Data cResponse
	Data cUrl
	Data cUser
	Data cPassword
	Data lSemAcento
	Data lUpperCase
	Data cBody

	Method New()
	Method NextCodigo()	
	Method AddProd()
	Method GetProd()		
	Method Reset()	
	
End Class       


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOMIT  �Autor  �Microsiga           � Data �  12/04/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method New() Class ApiWebManager
	Self:cParametros	:= ""
	Self:cToken 		:= ""
   Self:cUrl			:= ""
   Self:cUser			:=""
   Self:cPassword		:=""
   Self:cBody			:= ""
   Self:lSemAcento	:= .F.
   Self:lUpperCase	:= .F.
Return Self

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOMIT  �Autor  �Microsiga           � Data �  02/19/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method Reset() Class ApiWebManager
	___ApiWebManager____New()
Return Self
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOMIT  �Autor  �Microsiga           � Data �  12/04/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method NextCodigo() Class ApiWebManager
Local cUrl 			:= "http://www.wm10.com.br/uzgames_matriz/Protheus/proximo_cod.asp"+Self:cParametros
Local cToken		:= Self:cToken
Local nTimeOut 	:= 120 
Local aHeadStr 	:= {}
Local cParms 		:= ""
Local cBody  		:= ""
Local cHeaderRet 	:= ""

Self:cResponse :=""
AAdd(aHeadStr ,cToken)
AAdd(aHeadStr ,'Content-Type: text/html; charset=iso-8859-1')

Self:cResponse:=HTTPQuote( cUrl, "GET", cParms, cBody, nTimeOut, aHeadStr, @cHeaderRet )

If ValType(Self:cResponse)=="C"

	Self:cResponse:=DecodeUTF8(Self:cResponse)
	
	If Self:lUpperCase
		Self:cResponse:=Upper(Self:cResponse)
	EndIf	

	If Self:lSemAcento
		Self:cResponse:=NoAcento(AnsiToOem(Self:cResponse))
	EndIf	
	
EndIf	



Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOMIT  �Autor  �Microsiga           � Data �  12/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method AddProd() Class ApiWebManager
Local cUrl 			:= Alltrim(U_MyNewSX6("WM_NCG0002","http://www.wm10.com.br/uzgames_matriz/Protheus/integracao_produto.asp","C","Http da Integra��o","","",.F. ))+Self:cParametros
Local cHeaderRet 	:= ""
Local nTimeOut 	:= 120 
Local aHeadStr 	:= {}
Local cParms 		:= ""
Local cBody  		:= ""
Local cHeaderRet 	:= ""

Self:cResponse :=""


Self:cResponse:=HTTPQuote( cUrl, "POST", cParms, cBody, nTimeOut, aHeadStr, @cHeaderRet )

If Self:lUpperCase
	Self:cResponse:=Upper(Self:cResponse)
EndIf	

If Self:lSemAcento
	Self:cResponse:=NoAcento(AnsiToOem(Self:cResponse))
EndIf	

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWEBM00  �Autor  �Microsiga           � Data �  03/26/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method GetProd() Class ApiWebManager
Local cUrl 			:= "http://www.wm10.com.br/uzgames_matriz/Protheus/consulta_prod_ean_tipo.asp"+Self:cParametros
Local cToken		:= Self:cToken
Local nTimeOut 	:= 120 
Local aHeadStr 	:= {}
Local cParms 		:= ""
Local cBody  		:= ""
Local cHeaderRet 	:= ""

Self:cResponse :=""
AAdd(aHeadStr ,cToken)
AAdd(aHeadStr ,'Content-Type: text/html; charset=iso-8859-1')

Self:cResponse:=HTTPQuote( cUrl, "GET", cParms, cBody, nTimeOut, aHeadStr, @cHeaderRet )

If ValType(Self:cResponse)=="C"

	Self:cResponse:=DecodeUTF8(Self:cResponse)
	
	If Self:lUpperCase
		Self:cResponse:=Upper(Self:cResponse)
	EndIf	

	If Self:lSemAcento
		Self:cResponse:=NoAcento(AnsiToOem(Self:cResponse))
	EndIf	
	
EndIf	



Return
