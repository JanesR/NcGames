#INCLUDE "RWMAKE.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RETDRE    �Autor  �Rogerio             � Data �  06/23/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Programa para gerar planilha com despesas e receita por     ���
���          �natureza financeira, trabalha e conjunto com planilha       ���
���			 �excel de nome "Resultado Financeiro L�quido".				  ���
�������������������������������������������������������������������������͹��
���Uso       � PROTHEUS 10												  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function RETDRE1(CNATUREZA,DINI)

NRet1 := 0
ASE5 := GETAREA()

_NTT := 0
_NQTD := 0

cQry:="SELECT SUM(E5_VALOR) NVALFAT1 "
cQry+="FROM "+RetSqlName("SE5")+" WHERE D_E_L_E_T_=' ' "
cQry+="AND E5_RECPAG= 'P'  " 
cQry+="AND E5_BANCO<> ' '  "
cQry+="AND SUBSTR(E5_DATA,1,6) = '" + LEFT(DTOS(DINI),6)  + "'  "
cQry+="AND E5_NATUREZ = '"+CNATUREZA+"' "
cQry+="AND E5_SITUACA = ' '"

DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NVALFAT1", "N", 17, 2 )
NRet1 := Pega->NVALFAT1
Pega->(DbCloseArea())

RESTAREA(ASE5)
Return nRet1