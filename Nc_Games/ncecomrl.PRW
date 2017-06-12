#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNcEcomRL  บAutor  ณLucas Felipe        บ Data ณ  04/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NcEcomRL()

Local oReport

Private cAliasQry := GetNextAlias()
Private cAliasZC6	:= GetNextAlias()

oReport := ReportDef()
oReport:PrintDialog()


If Select(cAliasQry)>0
	(cAliasQry)->(DbCloseArea())
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณLucas Felipe        บ Data ณ  23/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportDef()

Local oReport
Local oCabEcom
Local oItemEcom
Local cTitulo		:= "Relat๓rio de pend๊ncias Ecommerce"
Local cRelDesc		:= ""

AjustaSx1()
Pergunte("ECOMRL1",.T.)

oReport := TReport():New("ECOMRL1",cTitulo,"ECOMRL1", {|oReport| ReportPrint(oReport)},cRelDesc)

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)


oCabEcom := TRSection():New(oReport,"Pedidos",{"ZC5","ZC6","SA1"},/*{Array com as ordens do relat๓rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCabEcom:SetTotalInLine(.F.)

If MV_PAR05 == 1 //ECOMMERCE B2B
	TRCell():New(oCabEcom,"ZC5_NUM"		,cAliasQry,"PV B2B"				,PesqPict("ZC5","ZC5_NUM")		,TamSx3("ZC5_NUM")	 [1] ,/*lPixel*/,/*{|| cVend }*/ )
ElseIf MV_PAR05 == 2 //ECOMMERCE B2
	TRCell():New(oCabEcom,"ZC5_PVVTEX"	,cAliasQry,"PV B2C"				,PesqPict("ZC5","ZC5_PVVTEX")	,TamSx3("ZC5_PVVTEX") [1] ,/*lPixel*/,/*{|| cVend }*/ )
Else
	TRCell():New(oCabEcom,"ZC5_NUM"		,cAliasQry,"PV B2B"				,PesqPict("ZC5","ZC5_NUM")		,TamSx3("ZC5_NUM")	 [1] ,/*lPixel*/,/*{|| cVend }*/ )
	TRCell():New(oCabEcom,"ZC5_PVVTEX"	,cAliasQry,"PV B2C"				,PesqPict("ZC5","ZC5_PVVTEX")	,TamSx3("ZC5_PVVTEX")	 [1] ,/*lPixel*/,/*{|| cVend }*/ )
EndIf
TRCell():New(oCabEcom,"ZC5_NUMPV"	,cAliasQry,RetTitle("ZC5_NUMPV")	,PesqPict("ZC5","ZC5_NUMPV")	,TamSx3("ZC5_NUMPV") [1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"EMISSAO" 	,cAliasQry,RetTitle("C5_EMISSAO")	,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"ZC5_CLIENT"	,cAliasQry,RetTitle("ZC5_CLIENT")	,PesqPict("ZC5","ZC5_CLIENT")	,TamSx3("ZC5_CLIENT")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"ZC5_LOJA"	,cAliasQry,RetTitle("ZC5_LOJA")		,PesqPict("ZC5","ZC5_LOJA")		,TamSx3("ZC5_LOJA")	 [1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"A1_NREDUZ"	,cAliasQry,RetTitle("A1_NREDUZ")	,PesqPict("ZC5","A1_NREDUZ")	,TamSx3("A1_NREDUZ") [1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"ZC5_STATUS"	,cAliasQry,RetTitle("ZC5_STATUS")	,PesqPict("ZC5","ZC5_STATUS")	,TamSx3("ZC5_STATUS")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"ZC5_TOTAL"	,cAliasQry,RetTitle("ZC5_TOTAL")	,PesqPict("ZC5","ZC5_TOTAL")	,TamSx3("ZC5_TOTAL") [1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"ZC5_FRETE"	,cAliasQry,RetTitle("ZC5_FRETE")	,PesqPict("ZC5","ZC5_FRETE")	,TamSx3("ZC5_FRETE") [1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oCabEcom,"PREVEND"		,cAliasQry,"Pr้ Venda?"				,"@!"									,3			     ,/*lPixel*/,/*{|| cVend }*/ )

//TRPosition():New(oCabEcom,"ZC5",1,{|| xFilial("ZC5") + Alltrim(Str(ZC5->ZC5_NUM)) })

//ณ Alinhamento a direita as colunas de valor
oCabEcom:Cell("ZC5_TOTAL"):SetHeaderAlign("RIGHT")
oCabEcom:Cell("ZC5_FRETE"):SetHeaderAlign("RIGHT")


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ										SEวรO 2								ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//oSection := TRSection():New(oReport,'Clientes',{'SA1'},{'Codigo','Nome'}*/,.T.,.T.)
oItemEcom := TRSection():New(oReport,"Itens",{"ZC5","ZC6","SB1"},/*{Array com as ordens do relat๓rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oItemEcom:SetTotalInLine(.F.)

If MV_PAR05 == 1 //ECOMMERCE B2B
	TRCell():New(oItemEcom,"NUM"		,cAliasZC6,"Pedido"				,PesqPict("ZC6","ZC6_NUM")		,TamSx3("ZC6_NUM")	  [1])
ElseIf MV_PAR05 == 2 //ECOMMERCE B2
	TRCell():New(oCabEcom,"NUMVTEX"		,cAliasQry,"PV B2C"				,PesqPict("ZC6","ZC6_PVVTEX")	,TamSx3("ZC6_PVVTEX") [1])
Else
	TRCell():New(oItemEcom,"NUM"		,cAliasZC6,"Pedido"				,PesqPict("ZC6","ZC6_NUM")		,TamSx3("ZC6_NUM")	  [1])
	TRCell():New(oCabEcom,"NUMVTEX"		,cAliasQry,"PV B2C"				,PesqPict("ZC6","ZC6_PVVTEX")	,TamSx3("ZC6_PVVTEX") [1])
EndIf
TRCell():New(oItemEcom,"ITEM"		,cAliasZC6,"Item"					,PesqPict("ZC6","ZC6_ITEM")	,TamSx3("ZC6_ITEM")	[1])
TRCell():New(oItemEcom,"PRODUTO"	,cAliasZC6,"Produto"				,PesqPict("ZC6","ZC6_PRODUT")	,TamSx3("ZC6_PRODUT")[1])
TRCell():New(oItemEcom,"DESCRI"	,cAliasZC6,"Descri็ใo"			,PesqPict("SB1","B1_XDESC")	,TamSx3("B1_XDESC")	[1])
TRCell():New(oItemEcom,"QTDVEN"	,cAliasZC6,"Qtd Vendida"		,PesqPict("ZC6","ZC6_QTDVEN")	,TamSx3("ZC6_QTDVEN")[1])
TRCell():New(oItemEcom,"VLRUNI"	,cAliasZC6,"Vlr Unit."			,PesqPict("ZC6","ZC6_VLRUNI")	,TamSx3("ZC6_VLRUNI")[1])
TRCell():New(oItemEcom,"VLRTOT"	,cAliasZC6,"Vlr Total"			,PesqPict("ZC6","ZC6_VLRTOT")	,TamSx3("ZC6_VLRTOT")[1])
TRCell():New(oItemEcom,"QTDRES"	,cAliasZC6,"Qtd Reservada"		,PesqPict("ZC6","ZC6_QTDRES")	,TamSx3("ZC6_QTDRES")[1])
TRCell():New(oItemEcom,"QTDNRES"	,cAliasZC6,"Qtd Nใo Reservada",PesqPict("ZC6","ZC6_QTDRES")	,TamSx3("ZC6_QTDRES")[1])

//TRPosition():New(oItemEcom,"ZC6",1,{|| xFilial("ZC6") + ZC6->ZC6_ITEM })

//ณ Alinhamento a direita as colunas de valor
oItemEcom:Cell("QTDVEN"):SetHeaderAlign("RIGHT")
oItemEcom:Cell("VLRUNI"):SetHeaderAlign("RIGHT")
oItemEcom:Cell("VLRTOT"):SetHeaderAlign("RIGHT")
oItemEcom:Cell("QTDRES"):SetHeaderAlign("RIGHT")

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint  บAutor  ณLucas Felipe     บ Data ณ  23/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportPrint(oReport)

Local oCabEcom  	:= oReport:Section(1)
Local oItemEcom 	:= oReport:Section(2)

Local cQryZC5  		:= ""
Local cQryZC6		:= ""

Local cFilZC5		:= xFilial("ZC5")

Local lPreVend		:= mv_par03 == 1


cQryZC5 := ""
cQryZC5 += " SELECT ZC5.ZC5_NUM, "+CRLF
cQryZC5 += "		ZC5.ZC5_PVVTEX, "+CRLF
cQryZC5 += "		ZC5.ZC5_NUMPV, "+CRLF
cQryZC5 += "		SubStr(C5_EMISSAO,7,2)||'/'||SubStr(C5_EMISSAO,5,2)||'/'||SubStr(C5_EMISSAO,1,4) EMISSAO, "+CRLF
cQryZC5 += "		ZC5.ZC5_CLIENT, "+CRLF
cQryZC5 += "		ZC5.ZC5_LOJA, "+CRLF
cQryZC5 += "		SA1.A1_NREDUZ, "+CRLF
cQryZC5 += "		ZC5.ZC5_STATUS, "+CRLF
cQryZC5 += "		ZC5.ZC5_TOTAL, "+CRLF
cQryZC5 += "		ZC5.ZC5_FRETE, "+CRLF
cQryZC5 += "		CASE WHEN ZC5.ZC5_PREVEN = ' ' THEN 'NรO' ELSE 'SIM' END PREVEND"+CRLF
cQryZC5 += " FROM "+RetSQLName("ZC5")+" ZC5 "+CRLF
cQryZC5 += " LEFT OUTER JOIN "+RetSQLName("SC5")+" SC5"+CRLF
cQryZC5 += " 	ON SC5.C5_FILIAL = '"+cFilZC5+"'"+CRLF
cQryZC5 += " 	AND SC5.C5_NUM = ZC5.ZC5_NUMPV"+CRLF
cQryZC5 += " 	AND SC5.C5_CLIENTE = ZC5.ZC5_CLIENT"+CRLF
cQryZC5 += " 	AND SC5.C5_LOJACLI = ZC5.ZC5_LOJA"+CRLF
cQryZC5 += " LEFT OUTER JOIN "+RetSQLName("SA1")+" SA1 "+CRLF
cQryZC5 += "	ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQryZC5 += "	AND SA1.A1_COD = ZC5.ZC5_CLIENT "+CRLF
cQryZC5 += "	AND SA1.A1_LOJA = ZC5.ZC5_LOJA "+CRLF
cQryZC5 += " WHERE ZC5.ZC5_FILIAL = '"+cFilZC5+"' "+CRLF
cQryZC5 += " AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
cQryZC5 += " AND ZC5.ZC5_FLAG = ' ' "+CRLF
//cQryZC5 += " AND ZC5.ZC5_PAGTO = '2' "+CRLF //removido para que todos os pedidos apare็am
cQryZC5 += " AND ZC5.ZC5_STATUS NOT IN ('90','96') "+CRLF //Alterar para Parametro.
cQryZC5 += " AND SC5.C5_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' "+CRLF //Alterar para Parametro.
If lPreVend
	cQryZC5 += " AND ZC5.ZC5_PREVEN = 'S' "+CRLF
EndIf
If mv_par04 == 1
	cQryZC5 += " AND ZC5.ZC5_NOTA <> ' '"+CRLF
ElseIf mv_par04 == 2
	cQryZC5 += " AND ZC5.ZC5_NOTA = ' '"+CRLF
EndIf
If mv_par05 == 1
	cQryZC5 += " AND ZC5.ZC5_NUM <> 0 "+CRLF
   	cQryZC5 += " AND ZC5.ZC5_PVVTEX = ' '"+CRLF
ElseIf mv_par05 == 2
	cQryZC5 += " AND ZC5.ZC5_NUM = 0 "+CRLF
	cQryZC5 += " AND ZC5.ZC5_PVVTEX <> ' '"+CRLF
EndIf

cQryZC5 := ChangeQuery(cQryZC5)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryZC5),cAliasQry,.T.,.T.)

oReport:SetMeter((cAliasQry)->(LastRec()))
dbSelectArea(cAliasQry)

//oCabEcom:Init()
oReport:ThinLine()

While !(oReport:Cancel()) .And. !((cAliasQry)->(Eof()))
	
	oCabEcom:Init()
	oCabEcom:PrintLine()
	
	cPedB2B := Alltrim(Str((cAliasQry)->ZC5_NUM))
	cPedB2C := Alltrim((cAliasQry)->ZC5_PVVTEX)
	
	cQryZC6 := ""
	cQryZC6 += " SELECT ZC6.ZC6_NUM NUM, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_PVVTEX NUMVTEX, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_ITEM ITEM, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_PRODUT PRODUTO, "+CRLF
	cQryZC6 += " 		B1_XDESC DESCRI, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_QTDVEN QTDVEN, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_VLRUNI VLRUNI, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_VLRTOT VLRTOT, "+CRLF
	cQryZC6 += " 		ZC6.ZC6_QTDRES QTDRES, "+CRLF
	cQryZC6 += " 		ZC6_QTDVEN - ZC6_QTDRES QTDNRES "+CRLF
	cQryZC6 += " FROM "+RetSqlName("ZC6")+" ZC6 "+CRLF
	cQryZC6 += " LEFT OUTER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
	cQryZC6 += " 	ON SB1.D_E_L_E_T_ = ' ' "+CRLF
	cQryZC6 += " 	AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
	cQryZC6 += " WHERE ZC6.ZC6_FILIAL = '"+cFilZC5+"' "+CRLF
	cQryZC6 += " AND ZC6.D_E_L_E_T_ = ' ' "+CRLF
	cQryZC6 += " AND ZC6.ZC6_NUM = '"+ cPedB2B +"' "
	cQryZC6 += " AND ZC6.ZC6_PVVTEX = '"+ cPedB2C +"' "
	
	cQryZC6 := ChangeQuery(cQryZC6)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryZC6),cAliasZC6,.T.,.T.)
	
	DbSelectArea(cAliasZC6)
	
	
	oReport:ThinLine()
	
	While (cAliasZC6)->( !Eof())
		
		oItemEcom:Init()
		oItemEcom:PrintLine()
		DbSelectArea(cAliasZC6)
		(cAliasZC6)->(dbskip())
		
	Enddo
	
	oItemEcom:Finish()
	(cAliasZC6)->(DbCloseArea())
	oReport:SkipLine()
	oReport:SkipLine()
	
	oCabEcom:Finish()
	DbSelectArea(cAliasQry)
	(cAliasQry)->(dbskip())
	
Enddo

oReport:IncMeter()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOMRL  บAutor  ณLucas Felipe        บ Data ณ  23/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function AjustaSx1()
Local aArea := GetArea()

PutSx1("ECOMRL1","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("ECOMRL1","02","Data at้" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1("ECOMRL1","03","S๓ Pr้ venda?","","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Sim","Sim","Sim","Nใo","Nใo","Nใo","","","","","","","","","","")
PutSx1("ECOMRL1","04","Faturado?","","","mv_ch4","N",1,0,1,"C","","","","","mv_par04","Sim","Sim","Sim","Nใo","Nใo","Nใo","Todos","Todos","Todos","","","","","","","")
PutSx1("ECOMRL1","05","Canal?","","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Ecommerce B2B","Ecommerce B2B","Ecommerce B2B","Ecommerce B2C","Ecommerce B2C","Ecommerce B2C","Todos","Todos","Todos","","","","","","","")

RestArea(aArea)

Return


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณREFERENCIAS UTILIZADASณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//
// http://tdn.totvs.com/pages/releaseview.action?pageId=30605476
//
