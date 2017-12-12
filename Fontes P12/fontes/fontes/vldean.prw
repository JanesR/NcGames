#INCLUDE "rwmake.ch"
#include "Protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �VLDEAN    � Autor � Rodrigo Okamoto       � Data � 02/02/12 ���
�������������������������������������������������������������������������Ĵ��
���          � Valida o digito verificador do c�digo de barras            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/            
User Function VldEAN(cCODBAR)
          
//Passa somente se o c�digo tiver o formato EAN 8, EAN 12, EAN 13, DUN 14
If !strzero(len(alltrim(cCODBAR)),2) $ "08/12/13/14"
	ALERT("C�digo de Barras n�o � formato EAN v�lido!!!")
	nRet	:= .F.
	Return nRet
EndIF

cResult := EanDigito(substr(cCODBAR,1,len(alltrim(cCODBAR))-1))
cDig 	:= right(alltrim(cCODBAR),1)

If cResult == cDig 
//	ALERT("C�digo de barras inserido!")
	nRet	:= .T.
Else
	ALERT("C�digo de Barras n�o � formato EAN v�lido!!!")
	nRet	:= .F.
EndIf


Return nRet




/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �Rel_VLDEAN    � Autor � Rodrigo Okamoto       � Data � 02/02/12 ���
�������������������������������������������������������������������������Ĵ��
���          � Valida o digito verificador do c�digo de barras            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Diferente apenas para rodar o relat�rio sem as mensagens   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Rel_VldEAN(cCODBAR)
          
//Passa somente se o c�digo tiver o formato EAN 8, EAN 12, EAN 13, DUN 14
If !strzero(len(alltrim(cCODBAR)),2) $ "08/12/13/14"
	nRet	:= .F.
	Return nRet
EndIF

cResult := EanDigito(substr(cCODBAR,1,len(alltrim(cCODBAR))-1))
cDig 	:= right(alltrim(cCODBAR),1)

If cResult == cDig 
//	ALERT("C�digo de barras inserido!")
	nRet	:= .T.
Else
//	ALERT("C�digo de Barras n�o � formato EAN v�lido!!!")
	nRet	:= .F.
EndIf


Return nRet
