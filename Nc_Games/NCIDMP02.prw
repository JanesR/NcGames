#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "protheus.ch"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIDMP02  �Autor  �Microsiga           � Data �  26/01/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cadastro de/para das filiais do datamace                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIDMP02()

Local aArea := GetArea()

	Local cNomAlias := "PZW" 
	
	chkFile(cNomAlias)
	dbSelectArea(cNomAlias)
	//indices
	dbSetOrder(1)
	axCadastro(cNomAlias, "Cadastro De/Para filiais Datamace x Protheus")

RestArea(aArea)	
return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIDM2VL  �Autor  �Microsiga           � Data �  26/01/2016 ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o do cadastro					                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIDM2VL(cFilDM, cFilProt)

Local aArea 	:= GetArea()
Local lRet		:= .T.

Default cFilDM	:= "" 
Default cFilProt	:= ""

DbSelectArea("PZW")
DbSetOrder(1)
If PZW->(DbSeek(xFilial("PZW") + PADR(cFilDM,TAMSX3("PZW_FILDM")[1]) + PADR(cFilProt,TAMSX3("PZW_FILPRT")[1])   ))
	lRet := .F.
	Aviso("NCIDMP02-Valida��o","Chave j� utilizada "+cFilDM+" (Filial Datamace) e "+cFilProt+" (Filial Protheus)",{"Ok"},2)
EndIf



RestArea(aArea)
Return lRet