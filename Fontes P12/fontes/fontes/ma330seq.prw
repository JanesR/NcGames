#INCLUDE "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA330SEQ  �Autor  �Microsiga           � Data �  07/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MA330SEQ

Local cOrdem := ParamIXB[1] //-- Ordem informada pelo recalculo
Local cAlias := ParamIXB[2] //-- Nome da tabela pertencente ao registro processado

If cOrdem == "500" .and. cAlias == "SD1"
	cOrdem := "201"
EndIf

Return cOrdem