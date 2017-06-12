#INCLUDE "PROTHEUS.CH"


#DEFINE 	TAM_VALOR			20   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRelCRC  บAutor  ณElton C.            บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio para controle de repasse para cliente			  บฑฑ
ฑฑบ          ณ					                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCRelCRC()

Local aArea 	:= GetArea()
Local oReport
Local aParam 	:= {}
Local cArqTmp   := ""

Private nomeprog := "NCRelCRC"
Private cPerg := "NCGCRC"

CriaSX1(cPerg)
Pergunte(cPerg,.T.)

//Recebe o dados do arquivo temporario
cArqTmp 	:= GetDRel()
//Rotina de impressใo do relat๓rio
oReport := ReportDef(aParam)
oReport:PrintDialog()

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณElton C.            บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefinicao do objeto do relatorio personalizavel e das		  บฑฑ
ฑฑบ          ณsecoes que serao utilizadas                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(aParam)

Local oReport 
Local oSection1
Local oTotal1
Local oTotal2
Local oTotal3
Local oTotal4
Local oTotal5
Local oTotal6
Local oTotal7
Local oTotal8
Local oTotal9
Local oBreak1
Local oBreak2
Local oBreak3
Local aOrdem := {}


oReport:= TReport():New(nomeprog,"Price Protection - Controle de Repasse a Cliente ",;
							cPerg, {|oReport| ReportPrint(oReport)},"Relat๓rio controle de repasse ao cliente (Price Protection)")// 
oReport:SetLandscape(.T.)    
oreport:DisableOrientation()

oSection1 := TRSection():New(oReport,"Price Protection - Controle de Repasse a Cliente ",(cArqTmp)) //"Relacao de Pedidos de Compras"
oSection1 :SetHeaderPage()
oSection1:lReadOnly := .T. 
oSection1:SetTotalInLine(.T.)  
oBreak1:= TRBreak():New( oSection1, {|| (cArqTmp)->(A1_COD+A1_LOJA)}, "Total Cliente/Loja") 
oBreak2:= TRBreak():New( oSection1, {|| (cArqTmp)->A1_COD}, "Total Geral Cliente")
oBreak3:= TRBreak():New( oSection1, {|| (cArqTmp)->(Eof())}, "Total Geral")

//ados do relatorio
TRCell():New(oSection1,"CODCLI"		,(cArqTmp),"Cod.Cli.",/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"NOMCLI"		,(cArqTmp),"Nome",/*Picture*/,/*Tamanho*/100,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"DTCREDPUB"	,(cArqTmp),"Dt.Cred.Pub.",/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CODPP"		,(cArqTmp),"Cod.PP",/*Picture*/,/*Tamanho*/25,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"TPPP"		,(cArqTmp),"Tipo PP",/*Picture*/,/*Tamanho*/25,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CODPROD"	,(cArqTmp),"Cod.Produto",/*Picture*/,/*Tamanho*/45,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"DESCPROD"	,(cArqTmp),"Desc.Produto",/*Picture*/,/*Tamanho*/130,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"PUBLISHER"	,(cArqTmp),"Publisher",/*Picture*/,/*Tamanho*/50,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"TPREPASS"	,(cArqTmp),"Tp.Repasse",/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VLREPASSE"	,(cArqTmp),"Vlr.Repasse","@E 999,999,999.99",/*Tamanho*/50,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VLREPASSADO",(cArqTmp),"Vlr.Repassado","@E 999,999,999.99",/*Tamanho*/50,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"Saldo"		,(cArqTmp),"Vlr. Saldo","@E 999,999,999.99",/*Tamanho*/50,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"STATUS"		,(cArqTmp),"Status",/*Picture*/,/*Tamanho*/50,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)

//Total Cliente e Loja
oTotal1:= TRFunction():New(oSection1:Cell("VLREPASSE")	,/* cID */,"SUM",oBreak1,"Total Repasse"	,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal2:= TRFunction():New(oSection1:Cell("VLREPASSADO"),/* cID */,"SUM",oBreak1,"Total Repassado"	,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal3:= TRFunction():New(oSection1:Cell("Saldo")		,/* cID */,"SUM",oBreak1,"Total Saldo"		,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

//Total Cliente
oTotal4:= TRFunction():New(oSection1:Cell("VLREPASSE")	,/* cID */,"SUM",oBreak2,"Total Geral Repasse"	,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal5:= TRFunction():New(oSection1:Cell("VLREPASSADO"),/* cID */,"SUM",oBreak2,"Total Geral Repassado"	,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal6:= TRFunction():New(oSection1:Cell("Saldo")		,/* cID */,"SUM",oBreak2,"Total Geral Saldo"		,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)


//Total Geral
oTotal7:= TRFunction():New(oSection1:Cell("VLREPASSE")	,/* cID */,"SUM",oBreak3,"Total Geral"	,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal8:= TRFunction():New(oSection1:Cell("VLREPASSADO"),/* cID */,"SUM",oBreak3,"Total Geral"	,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal9:= TRFunction():New(oSection1:Cell("Saldo")		,/* cID */,"SUM",oBreak3,"Total Geral" ,"@E 999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)


Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor  ณElton C.          บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPreenchimento dos dados a ser impresso no relat๓rio		  บฑฑ
ฑฑบ          ณ                                 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)

Local aArea 	:= GetArea()
Local oSection1 := oReport:Section(1) 


Local cCodCliAux	:= ""
Local cLojaAux		:= ""
Local cQuery		:= ""

oSection1:Init()

//Verifica se existe dados no arquivo temporario
If (cArqTmp)->(!Eof())

	cCodCliAux  := (cArqTmp)->A1_COD
	cLojaAux	:= (cArqTmp)->A1_LOJA

	

	While (cArqTmp)->(!Eof())
		
		
		//Verifica se houve troca de cliente para efetuar a quebra
		If  (Alltrim((cArqTmp)->A1_COD) + Alltrim((cArqTmp)->A1_LOJA)) != (Alltrim(cCodCliAux)+Alltrim(cLojaAux)) 

			oReport:ThinLine()
		
			cCodCliAux  := (cArqTmp)->A1_COD
			cLojaAux	:= (cArqTmp)->A1_LOJA

		EndiF
		
		//Imprime os dados do repasse (Itens do relatorio)
		oSection1:Cell("CODCLI"):SetBlock({ || Alltrim((cArqTmp)->A1_COD)+"/"+Alltrim((cArqTmp)->A1_LOJA) })
		oSection1:Cell("NOMCLI"):SetBlock({ || Alltrim((cArqTmp)->A1_NREDUZ) })
		oSection1:Cell("DTCREDPUB"):SetBlock( { ||  DTOC(STOD((cArqTmp)->P05_DTEFET)) })
		oSection1:Cell("CODPP"):SetBlock( { || (cArqTmp)->PZ5_CODPP })
		
		If Alltrim((cArqTmp)->PZ5_VERBPU) == '1'
			oSection1:Cell("TPPP"):SetBlock( { || "Verba" })
		Else
			oSection1:Cell("TPPP"):SetBlock( { || "Produto" })		
		EndIf
		
		oSection1:Cell("CODPROD"):SetBlock( { ||  (cArqTmp)->P05_CODPRO })
		oSection1:Cell("DESCPROD"):SetBlock( { || (cArqTmp)->B1_XDESC })
		oSection1:Cell("PUBLISHER"):SetBlock( { ||  (cArqTmp)->P05_PUBLIS })
		
		If Alltrim((cArqTmp)->PZ5_TIPOPC) == '1'
			oSection1:Cell("TPREPASS"):SetBlock( { || "CREDITO" })
		Else
			oSection1:Cell("TPREPASS"):SetBlock( { || "PRODUTO" })		
		EndIf
		
		oSection1:Cell("VLREPASSE"):SetBlock( { || (cArqTmp)->PZ5_VALNCC })
		oSection1:Cell("VLREPASSADO"):SetBlock( { || (cArqTmp)->PZ5_VALUSA})
		oSection1:Cell("Saldo"):SetBlock( { || (cArqTmp)->PZ5_VALSLD})
		
		If Alltrim((cArqTmp)->STATUSPZ5) == '1'
			oSection1:Cell("STATUS"):SetBlock( { || "Nใo Aplicado" })		

		ElseIf Alltrim((cArqTmp)->STATUSPZ5) == '2'
			oSection1:Cell("STATUS"):SetBlock( { || "Parc.Aplicado" })	
		
		ElseIf Alltrim((cArqTmp)->STATUSPZ5) == '3'
			oSection1:Cell("STATUS"):SetBlock( { || "Aplicado" })	
			
		EndIf

		oSection1:PrintLine()
		
		(cArqTmp)->(DbSkip())
	EndDo
	
EndIf


oSection1:Finish() 

RestArea(aArea)
Return NIL  
 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDRel   บAutor  ณElton C.            บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o arquivo temporario os dados a serem impressos no  บฑฑ
ฑฑบ          ณrelatorio			                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDRel()

Local aArea 	:= GetArea()
Local cArqTmp   := GetNextAlias()
Local cQuery	:= "" 


cQuery	:= " SELECT * FROM ( "+CRLF
cQuery	+= " SELECT A1_COD, A1_LOJA, A1_NREDUZ, P05_DTEFET, PZ5_CODPP, ' ' TIPOPP, P05_CODPRO, B1_XDESC, P05_PUBLIS, P06_TPREP, SUM(PZ5_VALNCC) PZ5_VALNCC, "+CRLF
cQuery	+= "        SUM(PZ5_VALUSA) PZ5_VALUSA, SUM(PZ5_VALSLD) PZ5_VALSLD, PZ5_DTEMIS, PZ5_TIPOPC, PZ5_VERBPU,  "+CRLF
cQuery	+= "          CASE "+CRLF
cQuery	+= "              WHEN SUM(PZ5_VALUSA) = 0 "+CRLF
cQuery	+= "                THEN '1' "+CRLF
cQuery	+= "              WHEN SUM(PZ5_VALUSA) != 0 AND SUM(PZ5_VALSLD) != 0 "+CRLF
cQuery	+= "                THEN '2' "+CRLF
cQuery	+= "              WHEN SUM(PZ5_VALUSA) != 0 AND SUM(PZ5_VALSLD) = 0 "+CRLF
cQuery	+= "                THEN '3' "+CRLF
cQuery	+= "          END AS STATUSPZ5 "+CRLF
cQuery	+= "  FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF 

cQuery	+= " INNER JOIN "+RetSqlName("P05")+" P05 "+CRLF
cQuery	+= " ON P05.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND P05.P05_FILIAL = PZ5.PZ5_FILIAL "+CRLF
cQuery	+= " AND P05.P05_CODPP = PZ5.PZ5_CODPP "+CRLF
cQuery	+= " AND P05.P05_DTEFET BETWEEN '"+DTOS(MV_PAR11)+"' AND '"+DTOS(MV_PAR12)+"' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery	+= " ON P06.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND P06.P06_FILIAL = P05.P05_FILIAL  "+CRLF
cQuery	+= " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQuery	+= " AND P06.P06_CLIENT = PZ5.PZ5_CLIENT "+CRLF
cQuery	+= " AND P06.P06_LOJA = PZ5.PZ5_LOJA "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery	+= " ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery	+= " AND SB1.B1_COD = P05.P05_CODPRO "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery	+= " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery	+= " AND SA1.A1_COD= PZ5.PZ5_CLIENT "+CRLF
cQuery	+= " AND SA1.A1_LOJA = PZ5.PZ5_LOJA "+CRLF

cQuery	+= " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery	+= " AND PZ5.PZ5_CLIENT BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'  "+CRLF
cQuery	+= " AND PZ5.PZ5_LOJA BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+CRLF
cQuery	+= " AND PZ5.PZ5_DTEMIS BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' "+CRLF
cQuery	+= " AND PZ5.PZ5_PPPUB BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "+CRLF
cQuery	+= " AND PZ5.PZ5_CODPP BETWEEN '"+MV_PAR09+"' AND '"+MV_PAR10+"' "+CRLF

//Filtra o tipo de repasse
If MV_PAR13 == 1  //Tipo de repasse Credito
	cQuery	+= " AND PZ5.PZ5_TIPOPC = '1' "+CRLF
ElseIf MV_PAR13 == 2 //Tipo de repasse Produto
	cQuery	+= " AND PZ5.PZ5_TIPOPC = '2' "+CRLF
EndIf

cQuery	+= " GROUP BY A1_COD, A1_LOJA, A1_NREDUZ, P05_DTEFET, PZ5_CODPP, P05_CODPRO, B1_XDESC, P05_PUBLIS, P06_TPREP, PZ5_DTEMIS, PZ5_TIPOPC, PZ5_VERBPU  "+CRLF
cQuery	+= " ) DADOSPZ5 "+CRLF

If MV_PAR14 == 1//Nao aplicado
	cQuery	+= " WHERE STATUSPZ5 = '1' "+CRLF
ElseIf MV_PAR14 == 2//Parcialmente aplicado
	cQuery	+= " WHERE STATUSPZ5 = '2' "+CRLF
ElseIf  MV_PAR14 == 3//aplicado
	cQuery	+= " WHERE STATUSPZ5 = '3' "+CRLF 
EndIf

cQuery	+= " ORDER BY A1_COD, A1_LOJA, A1_NREDUZ "+CRLF

//Aviso("Query", cQuery, {"Ok"},3)

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

/*aStruct   := PZ5->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cArqTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX*/


(cArqTmp)->(DbGoTop())

RestArea(aArea)
Return cArqTmp 


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณ CriaSX1   ณ Autor ณ Microsiga - PLS      ณ Data ณ 27.01.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณ Atualiza SX1                                               ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function CriaSX1(cPerg)
	
Default cPerg := ""

PutSx1(cPerg, "01", "Cliente de ","Cliente de ","Cliente de ","mv_ch1","C",TAMSX3("A1_COD")[1],0,1,"G","","SA1","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "02", "Cliente at้ ","Cliente at้ ","Cliente at้ ","mv_ch2","C",TAMSX3("A1_COD")[1],0,1,"G","","SA1","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "03", "Loja de ","Loja de ","Loja de","mv_ch3","C",TAMSX3("A1_LOJA")[1],0,1,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "04", "Loja at้ ","Loja at้ ","Loja at้ ","mv_ch4","C",TAMSX3("A1_LOJA")[1],0,1,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "05", "Dt.Repasse de"  ,"Dt.Repasse de","Dt.Repasse de"	,"mv_ch5","D",08,0,1,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "06", "Dt.Repasse at้"  ,"Dt.Repasse at้","Dt.Repasse at้"	,"mv_ch6","D",08,0,1,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "07", "Camp.Publisher de","Camp.Publisher de","Camp.Publisher de","mv_ch7","C",TAMSX3("P05_PPPUB")[1],0,1,"G","","P0C","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "08", "Camp.Publisher at้ ","Camp.Publisher at้ ","Camp.Publisher at้ ","mv_ch8","C",TAMSX3("P05_PPPUB")[1],0,1,"G","","P0C","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "09", "Cod. PP de","Cod. PP de","Cod. PP de","mv_ch9","C",TAMSX3("P05_CODPP")[1],0,1,"G","","P05","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "10", "Cod. PP at้ ","Cod. PP at้ ","Cod. PP at้ ","mv_cha","C",TAMSX3("P05_CODPP")[1],0,1,"G","","P05","","","mv_par10","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "11", "Dt.Efet. de"  ,"Dt.Efet. de","Dt.Efet. de"	,"mv_chb","D",08,0,1,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "12", "Dt.Efet. at้"  ,"Dt.Efet. at้","Dt.Efet. at้"	,"mv_chc","D",08,0,1,"G","","","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "13",	"Tp.Repasse"	,"",""	,"mv_chd","N",01,0,2,"C","","","","","mv_par13","Credito","","","","Produto","","","Todos","" )	
PutSx1(cPerg, "14",	"Status"	,"",""	,"mv_che","N",01,0,2,"C","","","","","mv_par14","Nใo Aplicado","","","","Parc.Aplicado","","","Aplicado","","","Todos" )	


Return .T.               


