#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA050INC  � Autor � Rafael Augusto     � Data �  08/12/2010 ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de Entrada para validar a ALtera�ao de um titulo no  ���
���          � contas a pagar, somente ser� liberado a inclusao para      ���
���          � para usuarios que estejam dentro do parametro.             ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 R1.3 - NC GAMES - Supertech Consulting LTDA.		  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function FA050ALT 

Local lRet := .F.

If ALLTRIM(UPPER(cUsername)) $ (ALLTRIM(UPPER(GETMV("MV_INC_PAG"))))
	lRet := .T.
Else
	If (M->E2_TIPO <> "PA")
		lRet := .F.
		ALERT("Usuario sem acesso para incluir esse tipo de titulo, favor consultar o Administrador do sistema ")
	Else
		lRet := .T.
	EndIf
EndIf
Return lRet
