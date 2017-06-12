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

User Function RETDRE(CNATUREZA,DINI)

NRet := 0
//NRet1 := 0
//NRet2 := 0
ASE5 := GETAREA()

_NTT := 0
_NQTD := 0

cQry:="SELECT SUM(E5_VALOR) NVALFAT "
cQry+="FROM "+RetSqlName("SE5")+" WHERE D_E_L_E_T_=' ' "
cQry+="AND E5_RECPAG= 'R'  " 
cQry+="AND E5_BANCO<> ' '  "
cQry+="AND SUBSTR(E5_DATA,1,6) = '" + LEFT(DTOS(DINI),6)  + "'  "
cQry+="AND E5_NATUREZ = '"+CNATUREZA+"' "
cQry+="AND E5_SITUACA = ' '"


DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NVALFAT", "N", 17, 2 )
NRet := Pega->NVALFAT
Pega->(DbCloseArea())

/*
cQry:="SELECT SUM(E5_VALOR) NVALFAT "
cQry+="FROM "+RetSqlName("SE5")+" WHERE D_E_L_E_T_=' ' "
cQry+="AND E5_RECPAG= 'R'  "
cQry+="AND E5_BANCO<> ' '  "
cQry+="AND SUBSTR(E5_DATA,1,6) = '" + LEFT(DTOS(DINI),6)  + "'  "
cQry+="AND E5_NATUREZ = '"+CNATUREZA+"' "
cQry+="AND E5_SITUACA = ' '"

DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NVALFAT", "N", 17, 2 )
NRet2 := Pega->NVALFAT

Pega->(DbCloseArea())

IF NRet1>NRet2
	NRet:=NRet1-NRet2
ELSE
	NRet:=NRet2-NRet1
ENDIF
*/

RESTAREA(ASE5)
Return nRet