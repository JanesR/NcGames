
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#Include "FIVEWIN.Ch"
#Include "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL210  บAutor  ณLucas Felipe        บ Data ณ  01/21/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function R210JOB2(aDados)

Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2] )

U_NCGRL210() 

RpcClearEnv()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL210  บAutor  ณLucas Felipe        บ Data ณ  01/21/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RL210JOB(aDados)

Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2] )

U_NCGRL210()

RpcClearEnv()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBRELPR2  บ Autor ณ AP6 IDE            บ Data ณ  11/09/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCGRL210()

Local cCC, cBCC	:= ""
Local aFiles	:= {}
Local aFat		:= {}
Local aDev		:= {}
Local cHtml		:= ""
Local clMensagem:= ""
Local lAuto		:= IsInCallStack("U_RL210JOB")
Local lJob2		:= IsInCallStack("U_R210JOB2")
Local cPVEmail 	:= Alltrim(U_MyNewSX6("DBM_REMAIL","lfelipe@ncgames.com","C","Email Workflow Previa","Email Workflow Previa","Email Workflow Previa",.F. )   )
Local cPEmail2 	:= Alltrim(U_MyNewSX6("DB_REMAIL1","lfelipe@ncgames.com","C","Email Workflow Previa que sera executado apenas uma vez ao dia","","",.F. )   )
Local cEmails 	:= ""
Local cEmpresa	:= ""

Local nToRejeit	:= 0	//Rejeitado
Local nToAnalis	:= 0	//Em Analise
Local nToBloq	:= 0	//Bloqueado

Local nTotalFat	:= 0
Local nTBlqCred	:= 0	//NVLRTOT
Local nTotalOpe	:= 0	//NVLRTOT
Local nTotalDev	:= 0

Local nCampo	:= 0
Local cWhereAux	:= ""
Local cVendedor	:= "1"
Local cWhere 	:= ""
Local nli		:= 0
Local nVendedor	:= Fa440CntVen()

Local clAlia1 	:= GetNextAlias()
Local cAliaAb	:= GetNextAlias()
Local cAliasSD1	:= GetNextAlias()
Local cAliasEFT	:= GetNextAlias()

Private cSqlAlias	:= GetNextAlias()

Private alData		:= {DtoS(FirstDay(date())),DtoS(date())}
Private _cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Private cUserEmail	:= UsrRetMail(AllTrim(_cUser))

If Len(alData) > 1
	clDtde 	:= alData[1]
	clDtAte := alData[2]
Else
	clDtde := FirstDay(date())
	clDtde := Date()
endIf
If EMpty(clDtDe)
	dldTLibDe := FirstDay(Date())
	dlDtLibAte := Date()
Else
	If Valtype(clDtDe) == "N"
		dldTLibDe := StoD(AllTrim(Str(clDtDe)))
		dlDtLibAte := StoD(AllTrim(Str(clDtAte)))
		
	Else
		dldTLibDe := StoD(clDtDe)
		dlDtLibAte := StoD(clDtAte)
	EndIf
EndIf

dldTLibDe	:= FirstDay(Date())
dlDtLibAte	:= Date()
dlDtDe		:= dldTLibDe
dlDtate 	:= Date()

DB_PAR01 := dlDtde - 15
DB_PAR02 := dlDtAte
DB_PAR03 := 1
DB_PAR04 := "L"
DB_PAR05 := dlDtlibde
DB_PAR06 := dlDtLibAte

clAlia1	:= GetNextAlias()

If lJob2
	cEmails := cPEmail2
Else
	cEmails := AllTrim(Getmv("DBM_REMAIL"))//+AllTrim(Getmv("DB_REMAIL1"))+AllTrim(Getmv("DB_REMAIL2"))
EndIf 
   

VerCanal()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTOTAL FATURADO  											  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

clQry := " "
clQry += " 	SELECT B1_YCLASSE,
clQry += " 	       ACA_GRPREP, "+CRLF
clQry += " 	       ACA_DESCRI, "+CRLF
clQry += " 	       SUM(D2_TOTAL+D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_DESPESA) AS TOTAL "+CRLF
clQry += " 	FROM " + RetSqlName("SF2") + " SF2 "+CRLF
clQry += " 		LEFT OUTER JOIN " + RetSqlName("ACA") + "  ACA "+CRLF
clQry += "		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
clQry += " 		AND ACA.ACA_GRPREP = SF2.F2_YCANAL "+CRLF
clQry += " 		LEFT OUTER JOIN " + RetSqlName("SD2") + " SD2 "+CRLF
clQry += "		ON SD2.D_E_L_E_T_ = ' ' "+CRLF
clQry += " 		AND SD2.D2_FILIAL = SF2.F2_FILIAL "+CRLF
clQry += " 		AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
clQry += " 		AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
clQry += " 		AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
clQry += " 			LEFT OUTER JOIN " + RetSqlName("SF4") + " SF4 "+CRLF
clQry += "			ON SF4.D_E_L_E_T_ = ' ' "+CRLF
clQry += " 			AND SF4.F4_FILIAL = SD2.D2_FILIAL "+CRLF
clQry += " 			AND SF4.F4_CODIGO = SD2.D2_TES "+CRLF
clQry += " 			AND SF4.F4_DUPLIC = 'S' "+CRLF
clQry += " 			INNER JOIN " + RetSqlName("SC6") + " SC6 "+CRLF
clQry += "			ON SC6.D_E_L_E_T_ = ' ' "+CRLF
clQry += " 			AND SC6.C6_NUM = SD2.D2_PEDIDO "+CRLF
clQry += " 			AND SC6.C6_PRODUTO = SD2.D2_COD "+CRLF
clQry += " 			AND SC6.C6_TPOPER IN('01','19') "+CRLF
clQry += " 			INNER JOIN " + RetSqlName("SB1") + " SB1 "+CRLF
clQry += "			ON SB1.D_E_L_E_T_ = ' ' "+CRLF
clQry += " 			AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
clQry += " 			AND SB1.B1_COD = SD2.D2_COD "+CRLF
clQry += " 	   		AND SB1.B1_TIPO = 'PA' " +CRLF
clQry += " 	WHERE D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
clQry += " 		AND F2_EMISSAO >= '"  + DTOS(DB_PAR05) + "'" +CRLF
clQry += " 		AND F2_EMISSAO <= '" + DTOS(DB_PAR06) + "' " +CRLF
clQry += " 		AND F2_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
clQry += " 	GROUP BY B1_YCLASSE,ACA_GRPREP, "+CRLF
clQry += " 	         ACA_DESCRI	 "+CRLF
clQry += " 	ORDER BY B1_YCLASSE,ACA_GRPREP, "+CRLF
clQry += " 	         ACA_DESCRI	 "+CRLF

clQry := ChangeQuery(clQry)



dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),clAlia1, .T., .T.)

DbSelectArea(clAlia1)
DbgoTop()
nTotalFat	:= 0
cDescri2	:= ""
cHtml2		:= ""
While (clAlia1)->(!EOF())
	nTotalFat	+=(clAlia1)->TOTAL
	cFatClasse	:= (clAlia1)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= PadR(Capital((clAlia1)->(ACA_DESCRI)),50)
	
	aAdd(aFat,{cFatClasse,(clAlia1)->(ACA_DESCRI),nTotalFat})
	
	cDescri2	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((clAlia1)->TOTAL,"@E 999,999,999.99")) + CRLF
	cHtml2		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml2		+= '<td width="5%">R$</td>'
	cHtml2		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((clAlia1)->TOTAL,"@E 999,999,999.99")) +'</div></td></tr>'
	(clAlia1)->(dbSkip())
End

(clAlia1)->(dbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ							DEVOLUวีES				   	   	       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cSqlDev := ""
cSqlDev += "  SELECT "+CRLF
cSqlDev += "  		ACA.ACA_GRPREP, "+CRLF
cSqlDev += "  		ACA.ACA_DESCRI, "+CRLF
cSqlDev += "  		SUM(D1_TOTAL+D1_VALIPI + D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_DESPESA) AS TOTAL "+CRLF
cSqlDev += "  FROM "+RetSqlName("SD1")+" SD1 "+CRLF
cSqlDev += " 	 INNER JOIN " + RetSqlName("SB1") + " SB1 "+CRLF
cSqlDev += " 	 ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cSqlDev += " 	 AND SB1.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += " 	 AND SB1.B1_COD = SD1.D1_COD "+CRLF
cSqlDev += " 	 AND SB1.B1_TIPO = 'PA' "+CRLF
cSqlDev += " 	 INNER JOIN " + RetSqlName("SF4") + " SF4 "+CRLF
cSqlDev += " 	 ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cSqlDev += " 	 AND SF4.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += " 	 AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cSqlDev += " 	 INNER JOIN " + RetSqlName("SF1") + " SF1 "+CRLF
cSqlDev += " 	 ON SF1.F1_FILIAL = '"+xFilial("SF1")+"' "+CRLF
cSqlDev += " 	 AND SF1.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += " 	 AND SF1.F1_DOC     = SD1.D1_DOC "+CRLF
cSqlDev += " 	 AND SF1.F1_SERIE   = SD1.D1_SERIE "+CRLF
cSqlDev += " 	 AND SF1.F1_FORNECE = SD1.D1_FORNECE "+CRLF
cSqlDev += " 	 AND SF1.F1_LOJA    = SD1.D1_LOJA "+CRLF
cSqlDev += " 	 INNER JOIN " + RetSqlName("SF2") + " SF2 "+CRLF
cSqlDev += " 	 ON SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
cSqlDev += " 	 AND SF2.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += " 	 AND SF2.F2_DOC     = SD1.D1_NFORI "+CRLF
cSqlDev += " 	 AND SF2.F2_SERIE   = SD1.D1_SERIORI "+CRLF
cSqlDev += " 	 AND SF2.F2_LOJA    = SD1.D1_LOJA "+CRLF
cSqlDev += " 	 AND F2_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cSqlDev += " 		 INNER JOIN " + RetSqlName("SA3") + " SA3 "+CRLF
cSqlDev += " 		 ON SA3.A3_FILIAL = '"+xFilial("SA3")+"' "+CRLF
cSqlDev += " 		 AND SA3.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += " 		 AND SA3.A3_COD = SF2.F2_VEND1 "+CRLF
cSqlDev += " 			 INNER JOIN " + RetSqlName("ACA") + " ACA "+CRLF
cSqlDev += " 			 ON ACA.ACA_FILIAL = '"+xFilial("ACA")+"' "+CRLF
cSqlDev += " 			 AND ACA.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += " 			 AND ACA_GRPREP = SF2.F2_YCANAL "+CRLF
cSqlDev += "  WHERE D1_FILIAL  = '"+xFilial("SD1")+"' "+CRLF
cSqlDev += "  AND D1_DTDIGIT BETWEEN '"+DtoS(DB_PAR05)+"' AND '"+DtoS(DB_PAR06)+"' "+CRLF
cSqlDev += "  AND D1_TIPO = 'D' "+CRLF
cSqlDev += "  AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cSqlDev += "  AND NOT (D1_TIPODOC >= '50' ) "+CRLF
cSqlDev += "  AND SD1.D1_CF IN ('1949','2949','2202','1202','1411','2411') "+CRLF
//Notas fiscais em exce็ใo
cSqlDev += "  AND SD1.D1_DOC NOT IN ('000207401') "+CRLF
//
cSqlDev += "  GROUP BY "+CRLF
cSqlDev += "  		  ACA.ACA_GRPREP, "+CRLF
cSqlDev += "  		  ACA.ACA_DESCRI "+CRLF
cSqlDev += "  ORDER BY 1, 2 "+CRLF

cSqlDev := ChangeQuery(cSqlDev)

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlDev),cAliasSD1, .T., .T.)

DbSelectArea(cAliasSD1)
DbgoTop()

nTotalDev	:= 0
cDescriD		:= ""
cHtmlD		:= ""
While (cAliasSD1)->(!EOF())
	ntotalDev	+= (cAliasSD1)->TOTAL
	cCanDescri	:= PadR(Capital((cAliasSD1)->(ACA_DESCRI)),50)
	
	cDescriD	+= cCanDescri + "R$ " + AllTrim(Transform((cAliasSD1)->TOTAL,"@E 999,999,999.99")) + CRLF
	//cHtmlD		+= '<Br>'+ cCanDescri + "R$ " + AllTrim(Transform((cAliasSD1)->TOTAL,"@E 999,999,999.99"))
	cHtmlD		+= '<tr><td width="70%">'+ cCanDescri +'</td>'
	cHtmlD		+= '<td width="5%">R$</td>'
	cHtmlD		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cAliasSD1)->TOTAL,"@E 999,999,999.99")) +'</div></td></tr>'
	
	(cAliasSD1)->(dbSkip())
	
End

(cAliasSD1)->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFIM DEVOLUวรOณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ							TOTAL EFETIVO						    	ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cSqlEft := "SELECT GRUPO, DESCR, SUM(TOTAL) as TOTAL"+CRLF
cSqlEft += "FROM "+CRLF
cSqlEft += "( "+CRLF
cSqlEft += "	SELECT 'FAT' AS TIPO, "+CRLF
cSqlEft += "		B1_YCLASSE CLASSE, "+CRLF
cSqlEft += "		ACA_GRPREP GRUPO, "+CRLF
cSqlEft += "		ACA_DESCRI DESCR, "+CRLF
cSqlEft += "		SUM(D2_TOTAL + D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_DESPESA) AS TOTAL "+CRLF
cSqlEft += "	FROM "+RetSqlName("SF2")+" SF2 "+CRLF
cSqlEft += "		LEFT OUTER JOIN "+RetSqlName("ACA")+" ACA "+CRLF
cSqlEft += "		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND ACA.ACA_GRPREP = SF2.F2_YCANAL "+CRLF
cSqlEft += "		LEFT OUTER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF
cSqlEft += "		ON SD2.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SD2.D2_FILIAL = SF2.F2_FILIAL "+CRLF
cSqlEft += "		AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
cSqlEft += "		AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
cSqlEft += "		AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
cSqlEft += "		LEFT OUTER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cSqlEft += "		ON SF4.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SF4.F4_FILIAL = SD2.D2_FILIAL "+CRLF
cSqlEft += "		AND SF4.F4_CODIGO = SD2.D2_TES "+CRLF
cSqlEft += "		AND SF4.F4_DUPLIC = 'S' "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("SC6")+" SC6 "+CRLF
cSqlEft += "		ON SC6.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SC6.C6_NUM = SD2.D2_PEDIDO "+CRLF
cSqlEft += "		AND SC6.C6_PRODUTO = SD2.D2_COD "+CRLF
cSqlEft += "		AND SC6.C6_TPOPER IN('01','19') "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cSqlEft += "		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SB1.B1_FILIAL = ' ' "+CRLF
cSqlEft += "		AND SB1.B1_COD = SD2.D2_COD "+CRLF
//cSqlEft += "		AND SB1.B1_SEGUM = SD2.D2_SEGUM "+CRLF
cSqlEft += "		AND SB1.B1_TIPO = 'PA' "+CRLF
cSqlEft += "	WHERE D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
cSqlEft += "	AND F2_EMISSAO >= '"  + DTOS(DB_PAR05) + "' "+CRLF
cSqlEft += "	AND F2_EMISSAO <= '"  + DTOS(DB_PAR06) + "' "+CRLF
cSqlEft += "	AND F2_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cSqlEft += "	GROUP BY B1_YCLASSE, ACA_GRPREP, ACA_DESCRI "+CRLF
cSqlEft += "	UNION "+CRLF
cSqlEft += "	SELECT 'DEV' AS TIPO, "+CRLF
cSqlEft += "		B1_YCLASSE CLASSE, "+CRLF
cSqlEft += "		ACA_GRPREP GRUPO, "+CRLF
cSqlEft += "		ACA_DESCRI DESCR, "+CRLF
cSqlEft += "		SUM(D1_TOTAL + D1_VALIPI + D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_DESPESA) * -1 AS TOTAL "+CRLF
cSqlEft += "		FROM "+RetSqlName("SD1")+" SD1 "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("SB1")+" SB1 ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cSqlEft += "		AND SB1.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SB1.B1_COD = SD1.D1_COD "+CRLF
cSqlEft += "		AND SB1.B1_TIPO = 'PA' "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cSqlEft += "		ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cSqlEft += "		AND SF4.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("SF1")+" SF1 "+CRLF
cSqlEft += "		ON SF1.F1_FILIAL = '"+xFilial("SF1")+"' "+CRLF
cSqlEft += "		AND SF1.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SF1.F1_DOC = SD1.D1_DOC "+CRLF
cSqlEft += "		AND SF1.F1_SERIE = SD1.D1_SERIE "+CRLF
cSqlEft += "		AND SF1.F1_FORNECE = SD1.D1_FORNECE "+CRLF
cSqlEft += "		AND SF1.F1_LOJA = SD1.D1_LOJA "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("SF2")+" SF2 "+CRLF
cSqlEft += "		ON SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
cSqlEft += "		AND SF2.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SF2.F2_DOC = SD1.D1_NFORI "+CRLF
cSqlEft += "		AND SF2.F2_SERIE = SD1.D1_SERIORI "+CRLF
cSqlEft += "		AND SF2.F2_LOJA = SD1.D1_LOJA "+CRLF
cSqlEft += "		AND F2_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cSqlEft += "		INNER JOIN "+RetSqlName("SA3")+" SA3 "+CRLF
cSqlEft += "		ON SA3.A3_FILIAL = '"+xFilial("SA3")+"' "+CRLF
cSqlEft += "		AND SA3.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SA3.A3_COD = SF2.F2_VEND1 "+CRLF
cSqlEft += "		INNER JOIN "+RetSqlName("ACA")+" ACA "+CRLF
cSqlEft += "		ON ACA.ACA_FILIAL = '"+xFilial("ACA")+"' "+CRLF
cSqlEft += "		AND ACA.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND ACA_GRPREP = SF2.F2_YCANAL "+CRLF
cSqlEft += "	WHERE D1_FILIAL = '"+xFilial("SD1")+"' "+CRLF
cSqlEft += "	AND D1_DTDIGIT BETWEEN '"+DTOS(DB_PAR05)+"' AND '"+DTOS(DB_PAR06)+"' "+CRLF
cSqlEft += "	AND D1_TIPO = 'D' "+CRLF
cSqlEft += "	AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "	AND NOT (D1_TIPODOC >= '50') "+CRLF
cSqlEft += "	AND SD1.D1_CF IN ('1949','2949','2202','1202','1411','2411') "+CRLF
//Notas fiscais em exce็ใo
cSqlEft += "  AND SD1.D1_DOC NOT IN ('000207401') "+CRLF
//
cSqlEft += "	GROUP BY B1_YCLASSE,  ACA.ACA_GRPREP, ACA.ACA_DESCRI "+CRLF
cSqlEft += "	UNION "+CRLF
cSqlEft += "	SELECT 'FAT' AS TIPO, "+CRLF
cSqlEft += "		B1_YCLASSE CLASSE, "+CRLF
cSqlEft += "		ACA_GRPREP GRUPO, "+CRLF
cSqlEft += "		ACA_DESCRI DESCR, "+CRLF
cSqlEft += "       	SUM(SC9.C9_QTDLIB*SC6.C6_PRCVEN) TOTAL "+CRLF
cSqlEft += "		FROM "+RetSqlName("SC5")+" SC5 "+CRLF
cSqlEft += "		LEFT OUTER JOIN "+RetSqlName("ACA")+" ACA "+CRLF
cSqlEft += "		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND ACA.ACA_GRPREP = SC5.C5_YCANAL "+CRLF
cSqlEft += "		LEFT OUTER JOIN "+RetSqlName("SC6")+" SC6 "+CRLF
cSqlEft += "		ON SC6.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "		AND SC6.C6_FILIAL = SC5.C5_FILIAL "+CRLF
cSqlEft += "		AND SC6.C6_NUM = SC5.C5_NUM "+CRLF
cSqlEft += "		AND SC6.C6_CLI = SC5.C5_CLIENTE "+CRLF
cSqlEft += "		AND SC6.C6_LOJA = SC5.C5_LOJACLI "+CRLF
cSqlEft += " 		AND (SC6.C6_BLQ <> 'R' OR SC6.C6_QTDENT <>0) "+CRLF
cSqlEft += " 			 		INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cSqlEft += " 			 		ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cSqlEft += " 			 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += " 			 		AND SF4.F4_CODIGO = SC6.C6_TES "+CRLF
cSqlEft += " 			 		AND SF4.F4_DUPLIC = 'S' "+CRLF
cSqlEft += "   		LEFT OUTER JOIN "+RetSqlName("SC9")+" SC9 "+CRLF
cSqlEft += "    	ON SC9.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "	    AND SC9.C9_FILIAL = SC6.C6_FILIAL "+CRLF
cSqlEft += "	    AND SC9.C9_PEDIDO = SC6.C6_NUM "+CRLF
cSqlEft += "	    AND SC9.C9_CLIENTE = SC6.C6_CLI "+CRLF
cSqlEft += "	    AND SC9.C9_LOJA = SC6.C6_LOJA "+CRLF
cSqlEft += "	    AND SC9.C9_PRODUTO = SC6.C6_PRODUTO "+CRLF
cSqlEft += "	    AND (SC9.C9_BLEST = ' ' OR SC9.C9_BLEST = '10') "+CRLF
cSqlEft += "		AND (SC9.C9_BLWMS = '02' OR SC9.C9_BLWMS = ' ') "+CRLF
cSqlEft += "	    INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cSqlEft += "	    ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cSqlEft += "	    AND SB1.B1_COD = SC6.C6_PRODUTO "+CRLF
cSqlEft += "	    AND SB1.B1_TIPO = 'PA' "+CRLF
cSqlEft += "		AND SB1.B1_FILIAL = ' ' "+CRLF
cSqlEft += "	WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"' "+CRLF
cSqlEft += "	AND SC5.C5_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cSqlEft += "	AND SC9.C9_DATALIB >= '"  + DTOS(DB_PAR01) + "' "+CRLF
cSqlEft += "	AND SC9.C9_DATALIB <= '"  + DTOS(DB_PAR02) + "' "+CRLF
cSqlEft += "	AND SC9.C9_BLCRED = ' ' "+CRLF
cSqlEft += "	GROUP BY B1_YCLASSE, ACA_GRPREP, ACA_DESCRI "+CRLF
cSqlEft += ") "+CRLF
//cSqlEft += "GROUP BY CLASSE, GRUPO, DESCR "+CRLF
cSqlEft += "GROUP BY GRUPO, DESCR "+CRLF
cSqlEft += "ORDER BY 1 "+CRLF

cSqlEft := ChangeQuery(cSqlEft)

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlEft),cAliasEFT, .T., .T.)

DbSelectArea(cAliasEFT)
DbgoTop()

nTotalEft	:= 0
cDescriEF	:= ""
cHtmlEF		:= ""

While (cAliasEFT)->(!EOF())
	ntotalEft	+= (cAliasEFT)->TOTAL
	cCanDescri	:= PadR(Capital((cAliasEFT)->(DESCR)),50)
	
	cDescriEF	+= cCanDescri + "R$ " + AllTrim(Transform((cAliasEFT)->TOTAL,"@E 999,999,999.99")) + CRLF
	//cHtmlEF		+= '<Br>'+ cCanDescri + "R$ " + AllTrim(Transform((cAliasEFT)->TOTAL,"@E 999,999,999.99"))
	cHtmlEF		+= '<tr><td width="70%">'+ cCanDescri +'</td>'
	cHtmlEF		+= '<td width="5%">R$</td>'
	cHtmlEF		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cAliasEFT)->TOTAL,"@E 999,999,999.99")) +'</div></td></tr>'
	
	(cAliasEFT)->(dbSkip())
	
End

(cAliasEFT)->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ							FIM TOTAL EFETIVO						  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ฟ
//ณ						Pedidos nใo liberado 	  				     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ู

cQryAb := " "
cQryAb += " SELECT DISTINCT B1_YCLASSE, "+CRLF
cQryAb += " 		C5_YCANAL, "+CRLF
cQryAb += " 		ACA_DESCRI C5_YDCANAL, "+CRLF
cQryAb += " 		SUM(C6_VALOR) total"+CRLF
cQryAb += " FROM " + RetSqlName("SC6") + " SC6"+CRLF
cQryAb += " INNER JOIN " + RetSqlName("SC5") + " SC5" +CRLF
cQryAb += " 	ON C5_FILIAL = C6_FILIAL" +CRLF
cQryAb += " 	AND C5_NUM = C6_NUM" +CRLF
cQryAb += "		AND C5_XSTAPED NOT IN('00','05','07') " +CRLF
cQryAb += " 	AND SC5.D_E_L_E_T_ = ' '" +CRLF
cQryAb += " 	AND SC5.C5_XECOMER <> 'C'" +CRLF
cQryAb += " 	AND SC5.C5_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cQryAb += " LEFT OUTER JOIN " + RetSqlName("ACA") + " ACA "+CRLF
cQryAb += "		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
cQryAb += " 	AND ACA.ACA_GRPREP = SC5.C5_YCANAL "+CRLF
cQryAb += " INNER JOIN "+ RetSqlName("SF4") + " SF4"+CRLF
cQryAb += " 	ON F4_FILIAL = '"+xFilial("SF4") +" '"+CRLF
cQryAb += " 	AND F4_CODIGO = C6_TES"+CRLF
cQryAb += " 	AND SF4.D_E_L_E_T_ = ' '"+CRLF
cQryAb += " INNER JOIN " + RetSqlName("SA3") +" SA3"+CRLF
cQryAb += " 	ON A3_FILIAL = '" + xFilial("SA3") + "'" +CRLF
cQryAb += " 	AND A3_COD = C5_VEND1" +CRLF
cQryAb += " 	AND SA3.D_E_L_E_T_ = ' '"+CRLF
cQryAb += " INNER JOIN SB1010 SB1" +CRLF
cQryAb += " 	ON SB1.D_E_L_E_T_ = ' '" +CRLF
cQryAb += " 	AND SB1.B1_COD = SC6.C6_PRODUTO" +CRLF
cQryAb += " 	AND SB1.B1_TIPO = 'PA'" +CRLF
cQryAb += " 	AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'" +CRLF
cQryAb += " WHERE SC6.D_E_L_E_T_ = ' '"+CRLF
cQryAb += " AND F4_DUPLIC = 'S'"+CRLF
cQryAb += " AND C6_FILIAL = '" + xFilial("SC6") + "' "+CRLF
cQryAb += " AND C5_EMISSAO BETWEEN '"  + DTOS(DB_PAR01) + "' AND '" + DTOS(DB_PAR02) + "' "+CRLF    // parโmetro oficial 5 e 6
cQryAb += " AND C6_BLQ <> 'R' "+CRLF
cQryAb += " AND C6_TPOPER  IN('01','19') "+CRLF
cQryAb += " AND" +CRLF
cQryAb += " NOT EXISTS "+CRLF
cQryAb += " 	( SELECT 1 "+CRLF
cQryAb += " 		FROM " + RetSqlName("SC9") + " SC9"+CRLF
cQryAb += "			WHERE SC9.C9_FILIAL = SC6.C6_FILIAL"+CRLF
cQryAb += "     	AND SC9.C9_PEDIDO = SC6.C6_NUM "+CRLF	
cQryAb += "     	AND SC9.C9_CLIENTE = SC6.C6_CLI "+CRLF
cQryAb += "     	AND SC9.C9_LOJA = SC6.C6_LOJA "+CRLF
cQryAb += " 		AND SC9.D_E_L_E_T_ = ' ')" +CRLF
cQryAb += " GROUP BY B1_YCLASSE," +CRLF
cQryAb += " 		C5_YCANAL," +CRLF
cQryAb += " 		ACA_DESCRI" +CRLF
cQryAb += " ORDER BY B1_YCLASSE," +CRLF
cQryAb += " 		C5_YCANAL" +CRLF

cQryAb := ChangeQuery(cQryAb)

If SELECT(cAliaAb) > 0
	(cAliaAb)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQryAb),cAliaAb, .T., .T.)
DbSelectArea(cAliaAb)
DbgoTop()

nToNaoLib	:= 0
cDescri3	:= ""
cHtml3		:= ""
While (cAliaAb)->(!EOF())
	nToNaoLib	+=(cAliaAb)->TOTAL
	cFatClasse	:= (cAliaAb)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= PadR(Capital((cAliaAb)->(C5_YDCANAL)),50)
	
	cDescri3	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cAliaAb)->TOTAL,"@E 999,999,999.99")) + CRLF
	//cHtml3		+= '<Br>'+ cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cAliaAb)->TOTAL,"@E 999,999,999.99"))
	cHtml3		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml3		+= '<td width="5%">R$</td>'
	cHtml3		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cAliaAb)->TOTAL,"@E 999,999,999.99")) +'</div></td></tr>'
	(cAliaAb)->(dbSkip())
End

(cAliaAb)->(dbCloseArea())


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ7
//ณ					Query para pedidos or็amento(PEDIDOS EM NEGOCIAวรO)  		  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ7

cQryAb := " "
cQryAb += " SELECT DISTINCT B1_YCLASSE, "+CRLF
cQryAb += " 		C5_YCANAL, "+CRLF
cQryAb += " 		ACA_DESCRI C5_YDCANAL, "+CRLF
cQryAb += " 		SUM(C6_VALOR) total"+CRLF
cQryAb += " FROM " + RetSqlName("SC6") + " SC6 "+CRLF
cQryAb += " INNER JOIN " + RetSqlName("SC5") + " SC5 "+CRLF
cQryAb += " 	ON C5_FILIAL = C6_FILIAL"+CRLF
cQryAb += " 	AND C5_NUM = C6_NUM"+CRLF
cQryAb += " 	AND C5_XSTAPED IN('05','07') "
cQryAb += " 	AND SC5.D_E_L_E_T_ = ' ' "+CRLF
cQryAb += " 	AND SC5.C5_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cQryAb += " LEFT OUTER JOIN " + RetSqlName("ACA") + " ACA "+CRLF
cQryAb += "		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
cQryAb += " 	AND ACA.ACA_GRPREP = SC5.C5_YCANAL "+CRLF
cQryAb += " INNER JOIN "+ RetSqlName("SF4") + " SF4 "+CRLF
cQryAb += " 	ON F4_FILIAL = '"+xFilial("SF4") +" ' "+CRLF
cQryAb += " 	AND F4_CODIGO = C6_TES"+CRLF
cQryAb += " 	AND SF4.D_E_L_E_T_ = ''"+CRLF
cQryAb += " INNER JOIN " + RetSqlName("SA3") +" SA3"+CRLF
cQryAb += " 	ON A3_FILIAL = '" + xFilial("SA3") + "'" +CRLF
cQryAb += " 	AND A3_COD = C5_VEND1" +CRLF
cQryAb += " 	AND SA3.D_E_L_E_T_ = ' '"+CRLF
cQryAb += " INNER JOIN "+ RetSqlName("SB1") +" SB1 "+CRLF
cQryAb += " 	ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQryAb += " 	AND SB1.B1_COD = SC6.C6_PRODUTO "+CRLF
cQryAb += " 	AND SB1.B1_TIPO = 'PA' "+CRLF
cQryAb += " 	AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQryAb += " WHERE SC6.D_E_L_E_T_ = '' "+CRLF
cQryAb += " AND F4_DUPLIC = 'S' "+CRLF
cQryAb += " AND C6_FILIAL = '" + xFilial("SC6") + "' "+CRLF
cQryAb += " AND C5_EMISSAO BETWEEN '"  + DTOS(DB_PAR01) + "' AND '" + DTOS(DB_PAR02) + "' "+CRLF
cQryAb += " AND C6_BLQ <> 'R' "+CRLF
cQryAb += " AND C6_TPOPER  IN('01','19') "+CRLF
cQryAb += " AND "+CRLF
cQryAb += " NOT EXISTS "+CRLF
cQryAb += " 	( SELECT 1 "+CRLF
cQryAb += " 	FROM " + RetSqlName("SC9") + " SC9"+CRLF
cQryAb += " 	WHERE SC9.C9_FILIAL	= SC6.C6_FILIAL"+CRLF
cQryAb += "     AND SC9.C9_PEDIDO = SC6.C6_NUM "+CRLF	
cQryAb += "     AND SC9.C9_CLIENTE = SC6.C6_CLI "+CRLF
cQryAb += "     AND SC9.C9_LOJA = SC6.C6_LOJA "+CRLF
cQryAb += " 	AND SC9.D_E_L_E_T_ = ' ')"+CRLF
cQryAb += " GROUP BY B1_YCLASSE," +CRLF
cQryAb += " 		C5_YCANAL," +CRLF
cQryAb += " 		ACA_DESCRI" +CRLF
cQryAb += " Order BY B1_YCLASSE," +CRLF
cQryAb += " 		C5_YCANAL" +CRLF

cQryAb := ChangeQuery(cQryAb)

If SELECT(cAliaAb) > 0
	(cAliaAb)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQryAb),cAliaAb, .T., .T.)
DbSelectArea(cAliaAb)
(cAliaAb)->(DbgoTop())

nTotOrc 	:= 0
cDescri4	:= ""
cHtml4		:= ""
While (cAliaAb)->(!EOF())
	nTotOrc	+=(cAliaAb)->TOTAL
	cFatClasse	:= (cAliaAb)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= PadR(Capital((cAliaAb)->(C5_YDCANAL)),50)
	
	cDescri4	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cAliaAb)->TOTAL,"@E 999,999,999.99")) + CRLF
	//	cHtml4		+= '<Br>'+ cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cAliaAb)->TOTAL,"@E 999,999,999.99"))
	cHtml4		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml4		+= '<td width="5%">R$</td>'
	cHtml4		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cAliaAb)->TOTAL,"@E 999,999,999.99")) +'</div></td></tr>'
	(cAliaAb)->(dbSkip())
End

(cAliaAb)->(dbCloseArea())

//ฺฤฤฤฤฤฤฤฤฟ
//ณOpera็ใoณ
//ภฤฤฤฤฤฤฤฤู
cSqlAlias	:= GetNextAlias()
cBlqWMS		:= "AND (SC9.C9_BLWMS = '02' OR SC9.C9_BLWMS = ' ')" +CRLF
cBlqCred	:= "AND SC9.C9_BLCRED = ' '" +CRLF

RL210SC9(cSqlAlias,cBlqWMS,cBlqCred)

(cSqlAlias)->(DbgoTop())

nTotalOpe	:= 0
cDescri5	:= ""
cHtml5		:= ""
While (cSqlAlias)->(!EOF())
	nTotalOpe	+=(cSqlAlias)->NVLRTOT
	cFatClasse	:= (cSqlAlias)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= PadR(Capital((cSqlAlias)->(C5_YDCANAL)),50)
	
	cDescri5	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99")) + CRLF
	//cHtml5		+= '<Br>'+ cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99"))
	cHtml5		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml5		+= '<td width="5%">R$</td>'
	cHtml5		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99")) +'</div></td></tr>'
	
	
	(cSqlAlias)->(dbSkip())
End
(cSqlAlias)->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฟ
//ณRejeitadoณ
//ภฤฤฤฤฤฤฤฤฤู
cSqlAlias	:= GetNextAlias()
cBlqWMS		:= "AND SC9.C9_BLWMS = ' '" +CRLF
cBlqCred	:= "AND SC9.C9_BLCRED = '09'" +CRLF
cAnalise	:= "R"
aAnalise	:= {}

RL210SC9(cSqlAlias,cBlqWMS,cBlqCred)

(cSqlAlias)->(DbgoTop())

nToRejeit	:= 0
cDescri6	:= ""
cHtml6		:= ""
While (cSqlAlias)->(!EOF())
	nToRejeit	+=(cSqlAlias)->NVLRTOT
	cFatClasse	:= (cSqlAlias)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= PadR(Capital((cSqlAlias)->(C5_YDCANAL)),50)
	
	cDescri6	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99")) + CRLF
	//cHtml6		+= '<Br>'+ cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99"))
	cHtml6		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml6		+= '<td width="5%">R$</td>'
	cHtml6		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99")) +'</div></td></tr>'
	
	(cSqlAlias)->(dbSkip())
End
(cSqlAlias)->(DbCloseArea())

aAnalise := R210Ecom(cAnalise)

For nI := 1 to Len( aAnalise)
	
	nToRejeit	+= aAnalise[nI][3]
	cFatClasse	:= aAnalise[nI][1]
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= "E-commerce "
	
	cDescri6	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform(aAnalise[nI][3],"@E 999,999,999.99")) + CRLF
	//cHtml6		+= '<Br>'+ cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform(aAnalise[nI][3],"@E 999,999,999.99"))
	cHtml6		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml6		+= '<td width="5%">R$</td>'
	cHtml6		+= '<td width="25%"><div align="right">'+ AllTrim(Transform(aAnalise[nI][3],"@E 999,999,999.99")) +'</div></td></tr>'
	
Next nI

//ฺฤฤฤฤฤฤฤฤฤฤฟ
//ณEM ANALISEณ
//ภฤฤฤฤฤฤฤฤฤฤู

cSqlAlias	:= GetNextAlias()
cBlqWMS		:= "AND SC9.C9_BLWMS = ' '" +CRLF
cBlqCred	:= "AND SC9.C9_BLCRED NOT IN (' ','10','09')" +CRLF
cAnalise	:= "A"
aAnalise	:= {}

RL210SC9(cSqlAlias,cBlqWMS,cBlqCred)

(cSqlAlias)->(DbgoTop())

nToAnalis	:= 0
cDescri7	:= ""
cHtml7		:= ""

While (cSqlAlias)->(!EOF())
	nToAnalis	+=(cSqlAlias)->NVLRTOT
	cFatClasse	:= (cSqlAlias)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= PadR(Capital((cSqlAlias)->(C5_YDCANAL)),50)
	
	cDescri7	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99")) + CRLF
	//cHtml7		+= '<Br>'+ cDesClasse +" - "+cCanDescri + "R$ " + AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99"))
	cHtml7		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml7		+= '<td width="5%">R$</td>'
	cHtml7		+= '<td width="25%"><div align="right">'+ AllTrim(Transform((cSqlAlias)->NVLRTOT,"@E 999,999,999.99")) +'</div></td></tr>'
	
	(cSqlAlias)->(dbSkip())
End
(cSqlAlias)->(DbCloseArea())

aAnalise := R210Ecom(cAnalise)

For nI := 1 to Len( aAnalise)
	
	nToAnalis	+= aAnalise[nI][3]
	cFatClasse	:= aAnalise[nI][1]
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	cCanDescri	:= "E-commerce "
	
	cDescri7	+= cDesClasse +" - "+ cCanDescri + "R$ " + AllTrim(Transform(aAnalise[nI][3],"@E 999,999,999.99")) + CRLF
	//cHtml7		+= '<Br>'+ cDesClasse +" - "+cCanDescri + "R$ " + AllTrim(Transform(aAnalise[nI][3],"@E 999,999,999.99"))
	cHtml7		+= '<tr><td width="70%">'+ cDesClasse +' - '+ cCanDescri +'</td>'
	cHtml7		+= '<td width="5%">R$</td>'
	cHtml7		+= '<td width="25%"><div align="right">'+ AllTrim(Transform(aAnalise[nI][3],"@E 999,999,999.99")) +'</div></td></tr>'
	
	
Next nI

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ						Previa de vendas na tela				     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cEmpresa		:= Alltrim(SM0->M0_FILIAL)
cEmpresa := IIf(xFilial("SC5")=="06","NC Espirito Santo",cEmpresa)

clMensagem := "Workflow de visใo comercial vendas da Filial "+ cEmpresa +" at้ o dia " + DtoC(Date()) +  CRLF
clMensagem += "Informa็ใo gerada pelo protheus." + " " + Time() + CRLF  + CRLF

clMensagem += "TOTAL EFETIVO – DEVOLUวรO"+ CRLF
clMensagem += cDescriEF
clMensagem += "TOTAL: R$ " + Alltrim(Transform(nTotalEft,"@E 999,999,999.99")) + CRLF

clMensagem += "TOTAL EFETIVO*: R$ "  + Alltrim(Transform(nTotalFat+nTotalOpe,"@E 999,999,999.99")) + CRLF
clMensagem += "*(Faturado + Opera็ใo)" + CRLF

clMensagem += "DEVOLUวรO"+ CRLF
clMensagem += cDescriD
clMensagem += "TOTAL: R$ " + Alltrim(Transform(nTotalDev,"@E 999,999,999.99")) + CRLF

clMensagem += "FATURADO"+ CRLF
clMensagem += cDescri2
clMensagem += "TOTAL: R$ "+ Alltrim(Transform(nTotalFat,"@E 999,999,999.99")) + CRLF + CRLF

clMensagem += CRLF
clMensagem += "OPERAวรO"
clMensagem += cDescri5
clMensagem += "TOTAL R$ " + AllTrim(Transform(nTotalOpe,"@E 999,999,999.99")) + CRLF

clMensagem += CRLF
clMensagem += "TOTAL POTENCIAL**: R$ "  + Alltrim(Transform(nToNaoLib /*+ nBloqueado*/,"@E 999,999,999.99"))  + CRLF
clMensagem += "**(Cr้dito (Valor Em Analise) + Nใo liberados)" + CRLF

clMensagem += CRLF
clMensagem += "CRษDITO" +CRLF
clMensagem += "REJEITADO" +CRLF
clMensagem += cDescri6
clMensagem += "TOTAL R$ " + AllTrim(Transform(nToRejeit,"@E 999,999,999.99")) + CRLF
clMensagem += CRLF
clMensagem += "EM ANALISE" +CRLF
clMensagem += cDescri7
clMensagem += "TOTAL R$ " + AllTrim(Transform(nToAnalis,"@E 999,999,999.99")) + CRLF
clMensagem += CRLF
clMensagem += "TOTAL R$ " + AllTrim(Transform(nToAnalis + nToRejeit,"@E 999,999,999.99")) + CRLF

clMensagem += "NรO LIBERADOS:" +CRLF
clMensagem += cDescri3
clMensagem += "TOTAL R$ " + AllTrim(Transform(nToNaoLib,"@E 999,999,999.99")) + CRLF

clMensagem += "PEDIDOS EM NEGOCIAวรO: " +CRLF
clMensagem += cDescri4
clMensagem += "TOTAL R$ " + AllTrim(Transform(nTotOrc,"@E 999,999,999.99"))

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ							HTML de previa de vendas						       			  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cHtml := '<!-- saved from url=(0022)http://internet.e-mail -->
cHtml += '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml">
cHtml += '<head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /><title>Pr้via de Vendas NC</title></head>
cHtml += '<body 	style="margin: 0px; padding: 0px; background-repeat: repeat-x; background-position: top; background-color: #FFF;" >
cHtml += '<div id="principal" style="margin: 20px auto; width: 1212px; padding: 15px; background-color: #FFF; font-family: Tahoma; font-size: 12px;" >

cHtml += '<table width="70%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">'
cHtml += '<tr><td width="25%" height="39" align="left" valign="top"> </td>'
cHtml += '<td height="39" valign="middle" style="font-family: Trebuchet MS, Arial, Helvetica, sans-serif; font-size: 30px; color: #FF952B; text-transform: uppercase; text-align: left;" ><div style="text-align: center">PRษVIA DE VENDAS</div></td>'
cHtml += '</tr></table>'

cHtml += '<p>&nbsp;</p>'

cHtml += '<table width="70%"><tr><td><p>Prezados  ,</p><br />
cHtml += '<br>Workflow de visใo comercial vendas  '+ cEmpresa +' at้ o dia ' + DtoC(Date()) + ',Informa็ใo gerada pelo protheus. ' + Time() +'</td>'
cHtml += '</tr></table>'


cHtml += '<table width="70%"><tr>'
cHtml += '<td><p>&nbsp;</p>'

cHtml += '<table width="60%"><tr><td colspan="3"><b>TOTAL EFETIVO - DEVOLUวรO </b></td></tr><tr>'
cHtml += cHtmlEF
cHtml += '<tr><td><b>TOTAL:</b></td><td><b>R$</b></td>'
cHtml += '<td><div align="right"><b>'+ Alltrim(Transform(nTotalEft,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<h6>&nbsp;</h6>'

cHtml += '<table width="60%">'
cHtml += '<tr><td width="70%"><b>TOTAL EFETIVO*: </b></td><td width="5%"><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ Alltrim(Transform(nTotalFat + nTotalOpe,"@E 999,999,999.99")) +'</b></div></td></tr>'
cHtml += '<tr><td colspan="3">*(Faturado + Opera็ใo)</td></tr></table>'

cHtml += '<h6>&nbsp;</h6>'

cHtml += '<table width="60%">'
cHtml += '<tr><td colspan="3"><b> DEVOLUวรO </b></td></tr>'
cHtml += cHtmlD
cHtml += '<tr><td><b>TOTAL:</b></td><td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ Alltrim(Transform(nTotalDev,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<h6>&nbsp;</h6>'

cHtml += '<table width="60%"><tr><td colspan="3"><b> FATURADO </b></td></tr><tr>'
cHtml += cHtml2
cHtml += '<tr><td><b>TOTAL:</b></td><td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ Alltrim(Transform(nTotalFat,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<h6>&nbsp;</h6>'

cHtml += '<table width="60%"><tr><td colspan="3"><b> OPERAวรO </b></td></tr><tr>'
cHtml += cHtml5
cHtml += '<tr><td><B>TOTAL:</b></td><td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ AllTrim(Transform(nTotalOpe,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<h6>&nbsp;</h6>'

cHtml += '<table width="60%">'
cHtml += '<tr><td width="70%"><b>TOTAL POTENCIAL**: </b></td><td width="5%"><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ Alltrim(Transform(nToNaoLib + nToAnalis,"@E 999,999,999.99")) +'</b></div></td></tr>'
cHtml += '<tr><td colspan="3">**(Cr้dito (Valor Em Analise) + Nใo liberados)</td></tr></table>'

cHtml += '<h6>&nbsp;</h6>'

cHtml += '<p><b> CRษDITO </b></p>'

cHtml += '<table width="60%"><tr><td colspan="3"><b> REJEITADO </b></td></tr><tr>'
cHtml += cHtml6
cHtml += '<tr><td><b>TOTAL:</b></td>
cHtml += '<td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ AllTrim(Transform(nToRejeit,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<p>&nbsp;</p>'

cHtml += '<table width="60%"><tr><td colspan="3"><b> EM ANALISE </b></td></tr><tr>'
cHtml += cHtml7
cHtml += '<tr><td><b>TOTAL:</b></td><td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ AllTrim(Transform(nToAnalis,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<br>'
cHtml += '<br><b> TOTAL CRษDITO R$ ' + AllTrim(Transform(nToRejeit+nToAnalis,"@E 999,999,999.99")) + '</b><br />'

cHtml += '<p>&nbsp;</p>'

cHtml += '<table width="60%"><tr><td colspan="3"><b> NรO LIBERADOS </b></td></tr><tr>'
cHtml += cHtml3
cHtml += '<tr><td><b>TOTAL:</b></td>'
cHtml += '<td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ AllTrim(Transform(nToNaoLib,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '<br>'

cHtml += '<table width="60%"><tr><td colspan="3"><b> PEDIDOS EM NEGOCIAวรO </b></td></tr><tr>'
cHtml += cHtml4
cHtml += '<tr><td><b>TOTAL:</b></td>'
cHtml += '<td><b>R$</b></td>'
cHtml += '<td width="25%"><div align="right"><b>'+ AllTrim(Transform(nTotOrc,"@E 999,999,999.99")) +'</b></div></td></tr></table>'

cHtml += '</td></tr></table></div></td>'
cHtml += '</tr></table></div></body></html>'


IF !LAUTO .And. !lJob2
	If  Aviso("Dados do processamento: ", clMensagem +" "+CRLF+CRLF,{"Sim","Nใo"},3,"Previa de Vendas") == 1
		clMensagem += "*** NรO RESPONDER A ESSE E-MAIL, POIS TRATA-SE DE UMA MENSAGEM AUTOMมTICA ***"
		U_ENVIAEMAIL(cUserEmail, cCC, cBCC, "Previa de vendas - "+cEmpresa+" - " + DtoC(Date()) + " - " + time(), cHtml, aFiles)
	EndIf
ELSE
	U_ENVIAEMAIL(cEmails, cCC, cBCC, "Previa de vendas - "+cEmpresa+" - " + DtoC(Date()) + " - " + time(), cHtml, aFiles)
ENDIF


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBRELPR2  บAutor  ณMicrosiga           บ Data ณ  01/21/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RL210SC9(cAliasSql,cBlqWMS,cBlqCred)

cQuery:= ""
cQuery+= " 	SELECT B1_YCLASSE, "+CRLF
cQuery+= " 	       C5_YCANAL, "+CRLF
cQuery+= " 	       ACA_DESCRI C5_YDCANAL, "+CRLF
cQuery+= " 	       SUM(SC9.C9_QTDLIB*SC6.C6_PRCVEN) NVLRTOT "+CRLF
cQuery+= " 	FROM " + RetSqlName("SC5") + " SC5 "+CRLF
cQuery+= " 		LEFT OUTER JOIN " + RetSqlName("ACA") + " ACA "+CRLF
cQuery+= " 		ON ACA.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " 		AND ACA.ACA_GRPREP = SC5.C5_YCANAL "+CRLF
cQuery+= " 		LEFT OUTER JOIN " + RetSqlName("SC6") + " SC6 "+CRLF
cQuery+= " 		ON SC6.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " 		AND SC6.C6_FILIAL = SC5.C5_FILIAL "+CRLF
cQuery+= " 		AND SC6.C6_NUM = SC5.C5_NUM "+CRLF
cQuery+= " 		AND SC6.C6_CLI = SC5.C5_CLIENTE "+CRLF
cQuery+= " 		AND SC6.C6_LOJA = SC5.C5_LOJACLI "+CRLF
cQuery+= " 	  	AND (SC6.C6_BLQ <> 'R' OR SC6.C6_QTDENT <>0) "+CRLF
cQuery+= " 			 		INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cQuery+= " 			 		ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
cQuery+= " 			 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " 			 		AND SF4.F4_CODIGO = SC6.C6_TES "+CRLF
cQuery+= " 			 		AND SF4.F4_DUPLIC = 'S' "+CRLF
cQuery+= " 	    LEFT OUTER JOIN " + RetSqlName("SC9") + " SC9 "+CRLF
cQuery+= " 	    ON SC9.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " 	    AND SC9.C9_FILIAL = SC6.C6_FILIAL "+CRLF
cQuery+= " 	    AND SC9.C9_PEDIDO = SC6.C6_NUM "+CRLF
cQuery+= " 	    AND SC9.C9_CLIENTE = SC6.C6_CLI "+CRLF
cQuery+= " 	    AND SC9.C9_LOJA = SC6.C6_LOJA "+CRLF
cQuery+= " 	    AND SC9.C9_PRODUTO = SC6.C6_PRODUTO "+CRLF
cQuery+= " 	    AND (SC9.C9_BLEST = ' ' OR SC9.C9_BLEST = '10') "+CRLF
cQuery+= " 		"+ cBlqWMS +""
cQuery+= " 	    INNER JOIN " + RetSqlName("SB1") + " SB1 "+CRLF
cQuery+= " 	    ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " 	    AND SB1.B1_COD = SC6.C6_PRODUTO "+CRLF
cQuery+= " 	    AND SB1.B1_TIPO = 'PA' "+CRLF
cQuery+= " 		AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery+= " 	WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"' "+CRLF
cQuery+= " 	AND SC5.C5_YCANAL NOT IN ('000011') " +CRLF  //Retirar Canais
cQuery+= "  AND SC9.C9_DATALIB >= '"+DTOS(DB_PAR01)+"' "+CRLF
cQuery+= "  AND SC9.C9_DATALIB <= '"+DTOS(DB_PAR02)+"' "+CRLF
cQuery+= " 	"+ cBlqCred +""+CRLF
cQuery+= " 	GROUP BY B1_YCLASSE, "+CRLF
cQuery+= "        	C5_YCANAL, "+CRLF
cQuery+= "        	ACA_DESCRI "+CRLF
cQuery+= " 	ORDER BY B1_YCLASSE,C5_YCANAL "+CRLF


cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSql,.T.,.T.)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL210  บAutor  ณLucas Felipe        บ Data ณ  05/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R210Ecom(cAnalise)

Local cQry 		:= ""
Local cAliasQry := GetNextAlias()

Local aAnaliCre	:= {}

If cAnalise=="A"
	cAnalise := " AND ZC5.ZC5_STATUS='4'"
ElseIf cAnalise=="R"
	cAnalise := " AND ZC5.ZC5_STATUS='90' And ZC5_PAGTO=' '"
EndIf

cQry += " SELECT SB1.B1_YCLASSE, ZC5_STATUS, SUM(C6_VALOR) total "+ CRLF
cQry += " FROM "+RetSqlName("ZC5")+" ZC5 "+ CRLF
cQry += " INNER JOIN "+RetSqlName("SC5")+" SC5 "+ CRLF
cQry += "	ON SC5.C5_FILIAL = '"+xFilial("SC5")+"' "+ CRLF
cQry += " 	AND ZC5.ZC5_NUMPV = SC5.C5_NUM "+ CRLF
cQry += " 	AND ZC5.ZC5_CLIENT = SC5.C5_CLIENTE "+ CRLF
cQry += " 	AND ZC5.ZC5_LOJA = SC5.C5_LOJACLI "+ CRLF
cQry += "		INNER JOIN "+RetSqlName("SC6")+" SC6 "+ CRLF
cQry += "		ON SC6.C6_NUM = SC5.C5_NUM "+ CRLF
cQry += "		AND SC5.C5_FILIAL = SC6.C6_FILIAL "+ CRLF
cQry += "			INNER JOIN "+RetSqlName("SB1")+" SB1 "+ CRLF
cQry += "			ON SB1.D_E_L_E_T_ = ' ' "+ CRLF
cQry += "			AND SB1.B1_COD = SC6.C6_PRODUTO "+ CRLF
cQry += "			AND SB1.B1_TIPO = 'PA' "+ CRLF
cQry += "			AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+ CRLF
cQry += " WHERE ZC5.D_E_L_E_T_ = ' ' "+ CRLF
cQry += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+ CRLF
cQry += " AND ZC5.ZC5_FLAG = ' ' "+ CRLF
cQry += " AND SC5.C5_EMISSAO BETWEEN '"  + DTOS(DB_PAR01) + "' AND '" + DTOS(DB_PAR02) + "' "+CRLF    // parโmetro oficial 5 e 6
cQry += " "+cAnalise+" "+CRLF
cQry += " AND NOT EXISTS (SELECT 'X' FROM "+RetSqlName("SC9")+" SC9 "+ CRLF
cQry += "				WHERE C9_FILIAL = SC5.C5_FILIAL "+ CRLF
cQry += "				AND SC9.C9_PEDIDO = ZC5.ZC5_NUMPV "+ CRLF
cQry += "				AND SC9.D_E_L_E_T_ = ' ') "+ CRLF
cQry += " GROUP BY B1_YCLASSE, ZC5_STATUS "+ CRLF

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)

While (cAliasQry)->(!Eof())
	
	(cAliasQry)->(aAdd(aAnaliCre,{B1_YCLASSE, ZC5_STATUS, TOTAL}))
	
	(cAliasQry)->(DbSkip())
	
EndDo


Return aAnaliCre



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL210  บAutor  ณMicrosiga           บ Data ณ  12/31/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xTestOpe()


RpcSetEnv("01","03")

cQuery:="SELECT C5_FILIAL,C5_NUM,B1_YCLASSE,ACA_DESCRI,SC9.C9_QTDLIB,SC6.C6_PRCVEN FROM SC5010 SC5 LEFT OUTER JOIN ACA010 ACA ON ACA.D_E_L_E_T_ = ' ' AND ACA.ACA_GRPREP = SC5.C5_YCANAL LEFT OUTER JOIN SC6010 SC6 ON SC6.D_E_L_E_T_ = ' ' AND SC6.C6_FILIAL = SC5.C5_FILIAL AND SC6.C6_NUM = SC5.C5_NUM AND SC6.C6_CLI = SC5.C5_CLIENTE AND SC6.C6_LOJA = SC5.C5_LOJACLI AND (SC6.C6_BLQ <> 'R'      OR SC6.C6_QTDENT <>0) LEFT OUTER JOIN SC9010 SC9 ON SC9.D_E_L_E_T_ = ' ' AND SC9.C9_FILIAL = SC6.C6_FILIAL AND SC9.C9_PEDIDO = SC6.C6_NUM AND SC9.C9_CLIENTE = SC6.C6_CLI AND SC9.C9_LOJA = SC6.C6_LOJA AND SC9.C9_PRODUTO = SC6.C6_PRODUTO AND (SC9.C9_BLEST = ' '     OR SC9.C9_BLEST = '10') AND (SC9.C9_BLWMS = '02'      OR SC9.C9_BLWMS = ' ') INNER JOIN SB1010 SB1 ON SB1.D_E_L_E_T_ = ' ' AND SB1.B1_COD = SC6.C6_PRODUTO AND SB1.B1_TIPO = 'PA' AND SB1.B1_FILIAL = '  ' WHERE SC5.C5_FILIAL = '03'   AND SC9.C9_DATALIB >= '20141116'   AND SC9.C9_DATALIB <= '20141231'   AND SC9.C9_BLCRED = ' '  ORDER BY 1,2"
cSqlAlias:="sc9pv"
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cSqlAlias, .T., .T.)

(cSqlAlias)->(DbgoTop())

cQuery+= " 	       C5_YCANAL, "+CRLF
cQuery+= " 	        C5_YDCANAL, "+CRLF
cQuery+= " 	       SUM(


cHtml7		:= ""

While (cSqlAlias)->(!EOF())
	
	cFatClasse	:= (cSqlAlias)->B1_YCLASSE
	cDesClasse	:= PadR(Capital((Posicione("SX5",1,xFilial("SX5")+"_Y"+cFatClasse,"X5_DESCRI"))),50)
	
	cHtml7		+=(cSqlAlias)->(C5_NUM+";"+cDesClasse+";"+ACA_DESCRI+";"+Transform(C9_QTDLIB,"@E 999,999,999.99")+";"+Transform(C6_PRCVEN,"@E 999,999,999.99"))+CRLF
	
	
	
	(cSqlAlias)->(dbSkip())
End
(cSqlAlias)->(DbCloseArea())


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerCanal  บAutor  ณLucas Oliveira      บ Data ณ  01/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo criada para corrigir problemas com notas sem canal  บฑฑ
ฑฑบ          ณ ela deverแ ser excultada antes da rotina de previa de vend บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function VerCanal()

Local cAliasQry := GetNextAlias()
Local cQry	:= ""


cQry += "	SELECT F2_DOC,  "+ CRLF
cQry += "			F2_SERIE,  "+ CRLF
cQry += "			F2_CLIENTE,  "+ CRLF
cQry += "			F2_LOJA,  "+ CRLF
cQry += "			F2_YCANAL,  "+ CRLF
cQry += "			D2_PEDIDO,  "+ CRLF
cQry += "			C5_YCANAL "+ CRLF
cQry += "		FROM "+ RetSqlName("SF2") +" SF2 "+ CRLF
cQry += "			LEFT OUTER JOIN "+RetSqlName("SD2")+" SD2 "+ CRLF
cQry += "			ON SD2.D_E_L_E_T_ = ' ' "+ CRLF
cQry += "			AND F2_DOC = SD2.D2_DOC "+ CRLF
cQry += "			AND F2_EMISSAO = SD2.D2_EMISSAO "+ CRLF
cQry += "			AND SD2.D2_FILIAL = '"+ xFilial("SD2") +"' "+ CRLF
cQry += "				LEFT OUTER JOIN "+ RetSqlName("SC5") +" SC5 "+ CRLF
cQry += "				ON SC5.D_E_L_E_T_ = ' ' "+ CRLF
cQry += "				AND SD2.D2_FILIAL = SC5.C5_FILIAL "+ CRLF
cQry += "				AND SD2.D2_PEDIDO = SC5.C5_NUM "+ CRLF
cQry += "				AND SD2.D2_CLIENTE = SC5.C5_CLIENTE "+ CRLF
cQry += "				AND SD2.D2_LOJA = SC5.C5_LOJACLI "+ CRLF
cQry += "	WHERE F2_EMISSAO BETWEEN '"+ DTOS(DB_PAR01) +"' AND '"+ DTOS(DB_PAR02) +"' "+ CRLF
cQry += "	AND F2_YCANAL = ' ' "+ CRLF
cQry += "	AND SF2.D_E_L_E_T_ = ' ' "+ CRLF
cQry += "	GROUP BY F2_DOC,  "+ CRLF
cQry += "			 F2_SERIE,  "+ CRLF
cQry += "			 F2_CLIENTE,  "+ CRLF
cQry += "			 F2_LOJA,  "+ CRLF
cQry += "			 F2_YCANAL,  "+ CRLF
cQry += "			 D2_PEDIDO,  "+ CRLF
cQry += "			 C5_YCANAL "+ CRLF

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)

While (cAliasQry)->(!Eof())
	
	SF2->(DbSetOrder(1))
	
	If SF2->(DbSeek(xFilial("SF2")+(cAliasQry)->F2_DOC))
		
		SF2->(RecLock("SF2",.F.))
		SF2->F2_YCANAL := (cAliasQry)->C5_YCANAL
		SF2->(MsUnlock())
		
	EndIf
	
	(cAliasQry)->(DbSkip())
	
EndDo

(cAliasQry)->(DbCloseArea())

Return
