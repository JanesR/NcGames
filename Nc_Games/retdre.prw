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