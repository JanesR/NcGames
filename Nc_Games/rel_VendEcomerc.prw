#Include 'Protheus.ch'
#DEFINE CRLF Chr(13) + Chr(10)

user function relpedEcom()

Local aArea := GetArea()
Local cPerg := "relEcom"

ajustaSX1()

if Pergunte(cPerg,.t.)

	geraRel(MV_PAR01, MV_PAR02, MV_PAR03)

EndIf
RestArea(aArea)
return


Static Function geraRel( ano, mes ,canal)

Local aArea := GetArea()
Local cQuery01 := ""
Local aCab := {}
Local aItens :={}
Local cAno := ano
Local cMes := mes
Local cCanal := canal

	aCab := GeraCab()
	aItens := GeraItens(cAno, cMes,cCanal)
	
	gravaRel(aCab, aItens)

RestArea(aArea)
return

Static Function GeraCab()

Local aArea:=GetArea()
Local axCab :={}

	aadd(axCab, {"Filial","C",02,0})
	aadd(axCab, {"Canal","C",15,0})
	aadd(axCab, {"Desc Canal","C",20,0})
	aadd(axCab, {"Emissao Pedido","D",08,0})
	aadd(axCab, {"Cod. Vendedor","C",02,0})
	aadd(axCab, {"Vendedor", "C", 02,0})
	aadd(axCab, {"Pedido", "C", 06,0})
	aadd(axCab, {"Pedido E-commerce", "C", 50,0})
	aadd(axCab, {"Nota","C",06,0})
	aadd(axCab, {"Dt Emissao NF","D",08,0})
	aadd(axCab, {"Valor NF","C",10,2})
	aadd(axCab, {"Valor Mercadoria","C",10,2})
	aadd(axCab, {"Dt. Lib","D",08,0})
	aadd(axCab, {"Dt. Separacao","D",08,0})
	aadd(axCab, {"Dt. Saida","D",08,0})
	aadd(axCab, {"Dt. Entrega","D",08,0})
	aadd(axCab, {"Tipo pagamento","C",10,0})
	aadd(axCab, {" ","C",20,0})


RestArea(aArea)
Return axCab

Static Function GeraItens(ano, mes, canal)
Local aArea:= GetArea()
Local aItens:={}
Local cQuery1:=""
Local cAliasQr1:=GetNextAlias()

cQuery1:= "SELECT " + CRLF
cQuery1+= "       DISTINCT SC5.C5_FILIAL AS FILIAL, " + CRLF
cQuery1+= "       SC5.C5_YCANAL CODCANAL," + CRLF
cQuery1+= "       SC5.C5_YDCANAL AS DCanal," + CRLF
cQuery1+= "       sc5.c5_emissao as EMIPED," + CRLF
cQuery1+= "       SA3.A3_COD AS CODVEND," + CRLF
cQuery1+= "       SA3.A3_NREDUZ AS NVEND," + CRLF
cQuery1+= "       SC5.C5_NUM AS PEDIDO," + CRLF
cQuery1+= "       (CASE WHEN SC5.C5_YPVECOM = ' ' THEN SC5.C5_PEDCLI ELSE SC5.C5_YPVECOM END) PVECOM," + CRLF
cQuery1+= "       SF2.F2_DOC AS NNF," + CRLF
cQuery1+= "       SF2.F2_EMISSAO AS DTNF," + CRLF
cQuery1+= "       SF2.F2_VALFAT VLNF," + CRLF
cQuery1+= "       SF2.F2_VALMERC VLMR," + CRLF
cQuery1+= "       TO_CHAR(docsaida.DT_ADD,'YYYYMMDD') DTLIB," + CRLF
cQuery1+= "       TO_CHAR(DOCSEP.DT_HOR_INICIO_SEPARACAO,'YYYYMMDD') DTSEP," + CRLF
cQuery1+= "       CASE WHEN SZ1.Z1_DTSAIDA = ' ' THEN '' ELSE SZ1.Z1_DTSAIDA END AS DTSAIDA," + CRLF
cQuery1+= "       CASE WHEN sz1.Z1_DTENTRE = ' ' THEN '' ELSE SZ1.Z1_DTENTRE END AS DTENT," + CRLF
cQuery1+= "       DECODE(TRIM(ZC5.ZC5_COND),'CC','CARTAO','BOL','BOLETO',' ') AS TPPAG" + CRLF
cQuery1+= "FROM "+RetSqlName("SC5")+" SC5" + CRLF
cQuery1+= "LEFT JOIN "+RetSqlName("SA3")+" SA3 ON SC5.C5_VEND1 = SA3.A3_COD" + CRLF
cQuery1+= "LEFT JOIN "+RetSqlName("SF2")+" SF2 ON SC5.C5_FILIAL = SF2.F2_FILIAL" + CRLF
cQuery1+= "AND SC5.C5_NOTA = SF2.F2_DOC" + CRLF
cQuery1+= "LEFT JOIN wms.tb_wmsinterf_doc_saida docsaida" + CRLF 
cQuery1+= "  ON SC5.C5_NUM = docsaida.dpcs_num_documento" + CRLF
cQuery1+= "LEFT JOIN WMS.VIW_DOC_SEPARACAO_ERP DOCSEP" + CRLF 
cQuery1+= "  ON SC5.C5_FILIAL||SC5.C5_NUM = DOCSEP.DOCUMENTO_ERP" + CRLF
cQuery1+= "LEFT JOIN "+RetSqlName("SZ1")+" SZ1" + CRLF 
cQuery1+= "  ON SC5.C5_NUM = SZ1.Z1_PEDIDO" + CRLF
cQuery1+= "LEFT JOIN "+RetSqlName("ZC5")+" ZC5" + CRLF
cQuery1+= "  ON sc5.c5_num = ZC5.ZC5_NUMPV" + CRLF
cQuery1+= "WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'" + CRLF
cQuery1+= "  AND SC5.D_E_L_E_T_ = ' '" + CRLF
cQuery1+= "  AND SA3.D_E_L_E_T_ = ' '" + CRLF
cQuery1+= "  AND SF2.D_E_L_E_T_ = ' '" + CRLF
cQuery1+= "" + CRLF  

	IF(canal == 1)
	cQuery1+= "  AND SC5.C5_YCANAL in( '990000')" + CRLF
	ElseIf(canal == 2)
	cQuery1+= "  AND SC5.C5_YCANAL in( '990001')" + CRLF
	Else
	cQuery1+= "  AND SC5.C5_YCANAL in( '990000','990001')" + CRLF
	EndIF

cQuery1+= "" + CRLF  
cQuery1+= "  AND SUBSTR( SC5.C5_EMISSAO,1,6) = trim('"+ str(ano) + strzero(mes,2) +"')" + CRLF 
cQuery1+= "  order by 3" + CRLF


MsgRun( "Coletando os dados......","Coleta de Dados",{|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),cAliasQr1,.T.,.T.)} )

Do While(cAliasQr1)->(!Eof())

	AADD(aItens,{;    
		(cAliasQr1)->FILIAL,;
		(cAliasQr1)->CODCANAL,;
		(cAliasQr1)->DCanal,;
		Stod((cAliasQr1)->EMIPED),;
		(cAliasQr1)->CODVEND,;
		(cAliasQr1)->NVEND,;
		(cAliasQr1)->PEDIDO,;
		(cAliasQr1)->PVECOM,;
		(cAliasQr1)->NNF,;
		StoD((cAliasQr1)->DTNF),;
		(cAliasQr1)->VLNF,;
		(cAliasQr1)->VLMR,;
		StoD((cAliasQr1)->DTLIB),;
		StoD((cAliasQr1)->DTSEP),;
		StoD((cAliasQr1)->DTSAIDA),;
		StoD((cAliasQr1)->DTENT),;
		(cAliasQr1)->TPPAG,;
		"",;
		})
	DbSkip()		
EndDo

DbCloseArea(cAliasQr1)

RestArea(aArea)
Return aItens


Static Function gravaRel(aCab, aItens)

	If !EMPTY(aItens)
		MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCab,aItens}})})
	Else
		Alert("Nenhum dado encontrado!")
	EndIf

return


Static Function ajustaSX1()
Local aArea := GetArea()
Local aHelpP	:= {}


Aadd( aHelpP, "Ano" )
PutSx1("relEcom","01","Ano?    "  ,"Ano?     ","Ano?     ","mv_ch1","N",4,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}


Aadd( aHelpP, "Mês:" )
PutSx1("relEcom","02","Mês?    "  ,"Mês?     ","Mês?     ","mv_ch2","N",2,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}


Aadd( aHelpP, "Empresa:" )
PutSx1("relEcom","03","Canal?    "  ,"Canal?     ","Canal?     ","mv_ch3","N",1,0,0,"C","","","","","mv_par03","B2B","B2B","B2B","B2C","B2C","B2C","Ambas","Ambas","Ambas","","","","","","","","",aHelpP)
aHelpP	:= {}


RestArea(aArea)
Return

