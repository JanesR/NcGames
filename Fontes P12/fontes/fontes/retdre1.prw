#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRETDRE    บAutor  ณRogerio             บ Data ณ  06/23/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPrograma para gerar planilha com despesas e receita por     บฑฑ
ฑฑบ          ณnatureza financeira, trabalha e conjunto com planilha       บฑฑ
ฑฑบ			 ณexcel de nome "Resultado Financeiro Lํquido".				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 10												  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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