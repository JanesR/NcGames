#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCVBXCOD	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro da importa��o da verba vs cod de movimenta��o	  ���
���          �	                                      					  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCVBXCOD()             

Local aArea := GetArea()
Private cCadastro := "Amarra��o Cod VB  VS Verba "

AxCadastro("PX9", cCadastro)	

RestArea(aArea)
Return        


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCVBXCOD	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro da importa��o da verba vs cod de movimenta��o	  ���
���          �	                                      					  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VldCodVb(cVerba, cCod)

Local aArea := GetArea()
Local lRet  := .T.

Default cVerba	:= ""
Default cCod	:= ""

DbSelectArea("PX9")
DbSetOrder(1)   
If PX9->(DbSeek(xFilial("PX9") + cVerba + cCod ))
	lRet  := .F.
	Aviso("Amarr. ja existe", "A amarra��o da Verba VS C�digo j� existe.", {"Ok"},2)
EndIf

RestArea(aArea)
Return lRet                                                                    



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GetDescVb�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna a descri��o da verba								  ���
���          �	                                      					  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GetDescVb(cCodVerba)

Local aArea := GetArea()
Local cRet	:= ""

Default cCodVerba := ""

DbSelectArea("SRV")
DbSetOrder(1)
If SRV->(DbSeek(xFilial("SRV") + cCodVerba))
	cRet := SRV->RV_DESC
EndiF

RestArea(aArea)
Return cRet
