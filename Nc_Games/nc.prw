#INCLUDE "PROTHEUS.CH"
#include "topconn.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 � NC    	� Autor � Marcelo C. Fernandes Data � 28.07.2011   ��
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna conteudo do campo informado                        ���
�������������������������������������������������������������������������Ĵ��
��� Uso		 � Gpea210  												  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������/*/
USER FUNCTION NC(cAlias,cChave,nOrdem,cCpoRet) 
Local cRet     
Local nOldOrdem := SRV->( IndexOrd())
Local cOldAlias := Alias()

cRet := Posicione(cAlias,nOrdem,cChave,cCpoRet) 

If cAlias == "SRV"  
	dbSelectArea("SRV")
	SRV->(DbSetOrder(nOrdem))
	cArqChave := SRV->(IndexKey())
	While SRV->(!eof()) .and. cChave == &(cArqChave)
		cRet := &(cCpoRet)
		Exit
	EndDo	
	SRV->(DbSetOrder(nOldOrdem))
	dbSelectArea(cOldAlias)
EndIf

Return(cRet)