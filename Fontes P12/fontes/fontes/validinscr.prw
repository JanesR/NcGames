#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � VALIDIE  �Autor  �Erich Buttner		 � Data � 20/12/10    ���
�������������������������������������������������������������������������͹��
���Descricao � Tratamento da inscri��o estadual 			              ���
�������������������������������������������������������������������������͹��
���Alteracoes� Erich Buttner em 20/12/10                                  ���
���          � - Tratamento da inscri��o estadual    					  ���
���          � 														      ���
���          � 															  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VALIDIE(_INSCR, cPessoa)

                      
IF ALLTRIM(_INSCR) <> "ISENTO"
   IF cPessoa == 'F'
   		Alert (" A inscri��o Estadual n�o Necessita de Pontua��o (.,-/) "+CHR(13)+"Ou deve Estar preenchido ISENTO")
		_INSCR:= "ISENTO"
    ELSE
    	IF ALLTRIM(_INSCR) == "ISENT".OR.ALLTRIM(_INSCR) == "ISENTA"
    		Alert (" A inscri��o Estadual n�o Necessita de Pontua��o (.,-/) "+CHR(13)+"Ou deve Estar preenchido ISENTO")
	    	_INSCR:= "ISENTO"
	    ELSE
    		Alert (" A inscri��o Estadual n�o Necessita de Pontua��o (.,-/) "+CHR(13)+"Ou deve Estar preenchido ISENTO")
			_INSCR:= ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN(_INSCR,".",""),"-",""),"/",""),",","")) 
	    ENDIF
	ENDIF
EndIf

		
Return (_INSCR)

