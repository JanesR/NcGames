#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � INVPROC  � Autor � Erich Buttner      � Data �  02/11/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Chamada em relat�rio personalizavel NC Games.              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function INVPROC (cProc, nVlr)

PUBLIC INV:= " " 

cQuery := " SELECT * FROM SWB010
cQuery += " WHERE WB_HAWB = '"+cProc+"' "
cQuery += " AND WB_FOBMOE = TO_NUMBER('"+ALLTRIM(STR(nVlr))+"') "
cQuery += " AND D_E_L_E_T_ <> '*' "

cQuery := ChangeQuery(cQuery)

//�������������������������������Ŀ
//� Fecha Alias se estiver em Uso �
//���������������������������������
If Select("TRINV") >0
	dbSelectArea("TRINV")
	dbCloseArea()
Endif

TCQUERY cQuery New Alias "TRINV"
dbSelectArea("TRINV")

dbGoTop()

INV:= TRINV->WB_INVOICE

RETURN INV

