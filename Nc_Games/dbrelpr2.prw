#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#Include "FIVEWIN.Ch"
#Include "TBICONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBRELPR2  º Autor ³ AP6 IDE            º Data ³  11/09/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DBRELPR2()//aldata)


Local CBLQCRED:= " "
LOCAL NVLRTOT := 0
Local clCanal := ""
Local clDCanal := ""
Local cCC, cBCC:= ""
Local aFiles:= {}
Local cHtml	:= ""
Local cHtml2 := "" 

//0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

Local clTime

Local nlBlqCred := 0//NVLRTOT
Local nlvlrFat := 0 //NVLRTOTNF
Local nlVlrOper := 0 //NVLRTOT
Local clMensagem := ""
Local CNUMPED := ""
Local clQry := ""
Local clAlia1 := ""
Local cQryAb	:= ""
Local cAliaAb	:= "" 
Local cGrpCanal := ""//MyCanalVen(cNumPed)
Local aCanais   := {}
Local nPosCanal	:= 0 
Local nTotalFat := 0
Local cDescri2	:= ""
Local nRejeitado := 0
Local nBloqueado := 0


Local nVendedor	:= "" //Fa440CntVen() 
Local nCampo	:= 0
Local cAliasSD1:= "" //GetNextAlias()
Local cWhereAux 	:= ""
Local cVendedor 	:= "1"
Local cWhere := ""
Local ntotalDev	:= 0 
Local nli		:= 0
Local nTotOrc	:= 0
Local nToNaoLib	:= 0
Local nTotNLib	:= 0

Private lAuto := IIF(Select("SM0") > 0, .f., .t.)  

IF LAUTO
	QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1'
ENDIF  


nVendedor	:= Fa440CntVen() 
cAliasSD1	:= GetNextAlias()


clAlia1 := GetNextAlias()
cAliaAb := GetNextAlias()

//VALIDPERG()

//pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Private clCodcli := ""
Private clLoja	:= ""
Private alData := {}
Private cEmails := "" 
Private aCanais	:= {}

DbSelectArea("ACA")
DbSetOrder(1)
DbGoTop()

Do While ACA->(!EOF()) 
	//Array[1] = Operacao, Array[2] = Analise Reprovado, Array[3] = Analise, Array[4] = Bloqueado, Array[5] Faturado 	 
    AADD(aCanais,{ACA->ACA_GRPREP, ACA->ACA_DESCRI,{0,0,0,0,0,0,0}}) 
    ACA->(DbSkip())
EndDo

Default alData := {}

DbSelectArea("SX6")

DbSetOrder(1)

If !dbSeek(xfilial("SX6") + "DBM_REMAIL")
	If RecLock("SX6",.T.)
		X6_FILIAL := xfilial("SX6")
		X6_VAR 	:= "DBM_REMAIL"
		X6_TIPO := "C"
		X6_DESCRIC := "E-mails para envio da previa de vendas"
		X6_DSCSPA := "E-mails para envio da previa de vendas"
		X6_DSCENG := "E-mails para envio da previa de vendas"
		X6_CONTEUD := "alberto.kibino@dbms.com.br"  // Cabe ate 250 caracteres.
		X6_CONTSPA := "alberto.kibino@dbms.com.br"
		X6_CONTENG := "alberto.kibino@dbms.com.br"
		X6_PROPRI	:= "U"
		X6_PYME := "S"
		MsUnLock()
	EndIf
EndIf

cEmails := AllTrim(Getmv("DBM_REMAIL"))+AllTrim(Getmv("DB_REMAIL1"))+AllTrim(Getmv("DB_REMAIL2"))


//cEmails := "alberto.kibino@dbms.com.br;apaula@ncgames.com.br;rvaz@ncgames.com.br;lbrim@ncgames.com.br" //******************

alData := {DtoS(FirstDay(date())),DtoS(date())}

If Len(alData) > 1
	clDtde := alData[1]
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

dldTLibDe := FirstDay(Date())
dlDtLibAte := Date()
dlDtDe := dldTLibDe
dlDtate := Date()
 

//**********************para teste**********************
//dldTLibDe := Date()
//dlDtLibAte := Date()
//dlDtDe := Date()
//dlDtate := Date()
/*
dldTLibDe := FirstDay(Date())+15
dlDtLibAte := Date() -1
dlDtDe := dldTLibDe
dlDtate := Date() -1
*/
//**********************para teste**********************

DB_PAR01 := dlDtde - 15  //AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","DB_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR02 := dlDtAte //AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","DB_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR03 := 1  //AADD(aRegs,{cPerg,"03","Export Excel?","","","mv_ch3","C",1,0,1,"C","","DB_PAR03","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
DB_PAR04 := "L" //AADD(aRegs,{cPerg,"04","Liberado ?","","","mv_ch4","C",1,0,1,"C","","DB_PAR04","TODOS","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR05 := dlDtlibde //AADD(aRegs,{cPerg,"05","Data Lib. De ?","","","mv_ch5","D", 8,0,0,"G","","DB_PAR05","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR06 := dlDtLibAte //AADD(aRegs,{cPerg,"06","Data Lib. Ate ?",

DBSELECTAREA("SC5")
DBSETORDER(1)


cQuery:= ""
cQuery:= " SELECT C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "+CRLF
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP "+CRLF
cQuery+= " FROM " + RetSqlName("SC5") + " SC5,"+CRLF
cQuery+= " " + RetSqlName("SC6") + " SC6,"+CRLF
cQuery+= " " + RetSqlName("SA4") + " SA4,"+CRLF
cQuery+= " " + RetSqlName("SC9") + " SC9 "+CRLF
cQuery+= " WHERE SC9.C9_FILIAL = '"+ xFilial("SC9")+"' "+CRLF
cQuery+= " AND SC5.C5_FILIAL = '"+ xFilial("SC5")+"' "+CRLF
cQuery+= " AND SC5.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " AND SA4.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " AND SC6.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " AND SC9.D_E_L_E_T_ = ' ' "+CRLF
cQuery+= " AND SC9.C9_DATALIB >= '"+DTOS(DB_PAR01)+"' "+CRLF
cQuery+= " AND SC9.C9_DATALIB <= '"+DTOS(DB_PAR02)+"' " +CRLF
cQuery+= " AND SC6.C6_NUM = SC5.C5_NUM "+CRLF 
cQuery+= " AND SC5.C5_NUM = SC9.C9_PEDIDO "+CRLF
cQuery+= " AND SC6.C6_PRODUTO = SC9.C9_PRODUTO "+CRLF 
cQuery+= " AND SC6.C6_FILIAL = SC9.C9_FILIAL "+CRLF 
cQuery+= " AND SC6.C6_ITEM = SC9.C9_ITEM "+CRLF
cQuery+= " AND (SC6.C6_BLQ <> 'R' OR SC6.C6_QTDENT <>0) "+CRLF
cQuery+= " AND (SC9.C9_BLEST = ' ' OR SC9.C9_BLEST = '10') "+CRLF
cQuery+= " AND SA4.A4_FILIAL = ' ' "+CRLF
cQuery+= " AND SA4.A4_COD = SC5.C5_TRANSP "+CRLF
cQuery+= " GROUP BY C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "+CRLF
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP "+CRLF
cQuery+= " ORDER BY C5_NUM, C6_SEQCAR, C6_NOTA "+CRLF

If Select("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea("TRB1")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ




dbSelectArea("TRB1")
TRB1->(dbGoTop())
cEstWMS	:= ""

NSEQ:= TRB1->C6_SEQCAR

dbSelectArea("SF2")
DbSetOrder(1)


WHILE TRB1->(!EOF())
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	CNUMPED		:= TRB1->C5_NUM
	CBLOQEST	:= " "
	NQTDLIB 	:= 0
	NQTDITEM	:= 0
	NQTDPROD	:= 0

	DBSELECTAREA("SC6")
	SC6->(DBORDERNICKNAME("SEQCAR"))
	SC6->(DBSEEK(XFILIAL("SC6")+TRB1->C5_NUM+ALLTRIM(STR(TRB1->C6_SEQCAR))))
	WHILE SC6->(!EOF()).AND.TRB1->C5_NUM == SC6->C6_NUM //.AND. SC6->C6_SEQCAR == NSEQ
		NQTDLIB  := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_QTDLIB")
		CBLOQEST := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_BLEST")
		NVLRTOT:= NVLRTOT+(IIF(EMPTY(CBLOQEST).OR.CBLOQEST == "10",NQTDLIB, 0 )* SC6->C6_PRCVEN) //NVLRTOT+(IIF(SC6->C6_QTDENT = 0.OR.NQTDLIB = 0, SC6->C6_QTDVEN, NQTDLIB)* SC6->C6_PRCVEN)
		
		IF EMPTY(CBLOQEST).OR.CBLOQEST == "10"
			NQTDITEM	+= 1
		ENDIF
		NQTDPROD	+= IIF(EMPTY(CBLOQEST).OR.CBLOQEST == "10",NQTDLIB, 0 )//IIF(SC6->C6_QTDENT = 0.OR.NQTDLIB = 0, SC6->C6_QTDVEN, NQTDLIB)
		SC6->(DBSKIP())
	ENDDO
	SC6->(DBCLOSEAREA())
	
	DDTLIB		:= SUBSTR(TRB1->C9_DATALIB,7,2)+"/"+SUBSTR(TRB1->C9_DATALIB,5,2)+"/"+SUBSTR(TRB1->C9_DATALIB,3,2)//STOD(TRB1->C5_DTLIB)
	
	DBSELECTAREA("SZ7")
	SZ7->(DBSETORDER(1))
	IF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000002"))
		CHRLIB		:= SZ7->Z7_HORA
	ELSE
		CHRLIB		:= "     "
	ENDIF
	
	IF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000006"))
		DDTLIBCRED		:= SUBSTR(DTOS(SZ7->Z7_DATA),7,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),5,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),3,2)
		CHRLIBCRED		:= SZ7->Z7_HORA
	ELSEIF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000002"))
		DDTLIBCRED		:= DDTLIB
		CHRLIBCRED		:= CHRLIB
	ELSE
		DDTLIBCRED		:= "        "
		CHRLIBCRED      := "     "
	ENDIF
	
	SZ7->(DBCLOSEAREA("SZ7"))  
	cCodBlCred	:= Posicione("SC9", 1, xFilial("SC9") + TRB1->C5_NUM, "C9_BLCRED")
	
	IF cCodBlCred == "04".OR. cCodBlCred == "01"
		CBLQCRED	:= "X"
	ELSEIF cCodBlCred == "09"
		CBLQCRED	:= "R"
	ELSE
		CBLQCRED	:= " "
	ENDIF
	//Verifica estorno do pick list WMS 
	/*
	cEstWMS	:= ""
	cEstWMS	:= VerWMS(TRB1->C5_NUM)
	*/
	DBSELECTAREA("SZ7")
	SZ7->(DBSETORDER(1))
	IF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000010"))
		DDTPICK		:= SUBSTR(DTOS(SZ7->Z7_DATA),7,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),5,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),3,2)//STOD(DTOS(SZ7->Z7_DATA))
		CHRPICK		:= SZ7->Z7_HORA
	ELSEIF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000010"+"  "))
		DDTPICK		:= SUBSTR(DTOS(SZ7->Z7_DATA),7,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),5,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),3,2)//STOD(DTOS(SZ7->Z7_DATA))
		CHRPICK		:= SZ7->Z7_HORA
	ELSE
		DDTPICK		:= "        "                 
		CHRPICK		:= "     "
	ENDIF
	
	DBSELECTAREA("SZ7")
	SZ7->(DBSETORDER(2))
	
	IF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000011"+ALLTRIM(STR(TRB1->C6_SEQCAR))))
		DDTETIPED	:= SUBSTR(DTOS(SZ7->Z7_DATA),7,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),5,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),3,2)//STOD(DTOS(SZ7->Z7_DATA))
		CHRETIPED	:= SZ7->Z7_HORA
	ELSEIF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000011"+"  "))
		DDTETIPED	:= SUBSTR(DTOS(SZ7->Z7_DATA),7,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),5,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),3,2)//STOD(DTOS(SZ7->Z7_DATA))
		CHRETIPED	:= SZ7->Z7_HORA
	ELSE
		DDTETIPED	:= "        "
		CHRETIPED	:= "     "
	ENDIF
	
	SZ7->(DBCLOSEAREA("SZ7"))
	
	DBSELECTAREA("SD2")
	SD2->(DBSETORDER(3))
	SD2->(DBSEEK(XFILIAL("SD2")+TRB1->C6_NOTA+TRB1->C6_SERIE))
	CNUMNF		:= TRB1->C6_NOTA
	CSERIE		:= TRB1->C6_SERIE
	
	SF2->(dbSeek(xFilial("SF2") + TRB1->C6_NOTA+TRB1->C6_SERIE))
	CESPEC		:= SF2->F2_ESPECI1
	NVOLNF		:= SF2->F2_VOLUME1
	NPLIQUI		:= SF2->F2_PLIQUI
	NPBRUTO		:= SF2->F2_PBRUTO
	DDTAGEN		:= SF2->F2_DATAAG
	CHRNF		:= SF2->F2_HORA
	
	NVLRTOTNF	:= SF2->F2_VALMERC + SF2->F2_FRETE + SF2->F2_SEGURO + SF2->F2_ICMSRET + SF2->F2_VALIPI

	
	IF DB_PAR03 == 1
		
		IF EMPTY(CNUMNF)
			CNUM := TRB1->C5_NUM
		ELSE
			CNUM := CNUMNF
		ENDIF
		/*
		_cQuery01 := " SELECT DATADISPSEP DTDSEP,DATADISPONIVELSEP HRDSEP,DATASEP DTSEP,DATASEPARACAO HRSEP, "
		_cQuery01 += " DATADISPCONF DTDCONF,DATADISPONIVELCONF HRDCONF,DATACONF DTCONF,DATACONFERENCIA HRCONF, "
		_cQuery01 += " DATAFIM DTDNF, DATACONFIRMACAO HRDNF, USUARIOSEPARACAO USUSEP, USUARIOCONFERENCIA USUCONF, CODIGOROMANEIO ROMAN "
		_cQuery01 += "FROM ORAINT.X_077_VW_DOCUMENTOSAIDAPAINEL DOCPAINEL WHERE DOCPAINEL.DOCUMENTOSAIDA = '"+CNUM+"' "
		_cQuery01 := ChangeQuery(_cQuery01)
		
		If Select("TRB9") > 0
			dbSelectArea("TRB9")
			dbCloseArea()
		EndIf
		
		TCQUERY _cQuery01 New Alias "TRB9"  
		*/
		cGrpCanal := MyCanalVen(TRB1->C5_VEND1)
		nPosCanal := aScan( aCanais,{ |x| AllTrim( x[1] ) == cGrpCanal } )  
		
		
		If CBLQCRED == "X"
			nlBlqCred += NVLRTOT
			//Array[1] = Operacao, Array[2] = Analise Reprovado, Array[3] = Analise, Array[4] = Bloqueado, Array[5] Faturado 
			nBloqueado += NVLRTOT	  
			If nPosCanal > 0
				aCanais[nPosCanal,3,4] += NVLRTOT
			EndIf 
		ElseIf CBLQCRED == "R" 
			nlBlqCred += NVLRTOT
			nRejeitado += NVLRTOT	
			If nPosCanal > 0
				aCanais[nPosCanal,3,2] += NVLRTOT
			EndIf
		EndIf
		If !EMPTY(CNUMNF)
			nlvlrFat += NVLRTOTNF
			If nPosCanal > 0
				aCanais[nPosCanal,3,5] += NVLRTOT
			EndIf
		Else
			If Empty(AllTrim(CBLQCRED))
				If AllTrim(POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER")) == "01"
					nlVlrOper += NVLRTOT 
					If nPosCanal > 0
						aCanais[nPosCanal,3,1] += NVLRTOT
					EndIf
				EndIf
			EndIf
		EndIf
	ENDIF
	
	
	TRB1->(DBSKIP())
	
	NVLRTOT := 0
	//nLin ++
	NSEQ++
	IF TRB1->C5_NUM <> SUBSTR(CNUMPED,1,6)
		NSEQ:= TRB1->C6_SEQCAR
	ENDIF
ENDDO

clQry := " SELECT ACA_GRPREP, ACA_DESCRI, SUM(D2_TOTAL+D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_DESPESA) as TOTAL"+CRLF
clQry += " FROM " + RetSqlName("SF2") + " F2,"+CRLF
clQry += " " + RetSqlName("SB1") + " B1,"+CRLF
clQry += " " + RetSqlName("SD2") + " D2,"+CRLF
clQry += " " + RetSqlName("SA1") + " A1,"+CRLF
clQry += " " + RetSqlName("SA3") + " A3,"+CRLF
clQry += " " + RetSqlName("ACA") + " ACA,"+CRLF
clQry += " " + RetSqlName("SC6") + " C6,"+CRLF
clQry += " " + RetSqlName("SC5") + " C5,"+CRLF
clQry += " " + RetSqlName("SF4") + " F4,"+CRLF
clQry += " " + RetSqlName("SE4") + " E4 "+CRLF
clQry += " WHERE D2_FILIAL = '" + xFilial("SD2") + "'" +CRLF
clQry += " AND F2_EMISSAO >= '"  + DTOS(DB_PAR05) + "'" +CRLF
clQry += " AND F2_EMISSAO <= '" + DTOS(DB_PAR06) + "' " +CRLF
clQry += " AND F2_FILIAL = D2_FILIAL " +CRLF
clQry += " AND F2_DOC = D2_DOC " +CRLF
clQry += " AND F2_SERIE = D2_SERIE" +CRLF
clQry += " AND F4_FILIAL = '" + xFilial("SF4") + "'" +CRLF
clQry += " AND D2_TES = F4_CODIGO " +CRLF
clQry += " AND F4_DUPLIC = 'S' " +CRLF
clQry += " AND D2_COD = B1_COD " +CRLF
clQry += " AND F2_CLIENTE = A1_COD " +CRLF
clQry += " AND F2_LOJA = A1_LOJA " +CRLF
clQry += " AND F2_VEND1 = A3_COD " +CRLF
clQry += " AND F2_YCANAL = ACA_GRPREP" +CRLF
clQry += " AND F2_FILIAL = C6_FILIAL " +CRLF
clQry += " AND D2_PEDIDO = C6_NUM " +CRLF
clQry += " AND D2_ITEMPV = C6_ITEM " +CRLF
clQry += " AND C6_FILIAL = C5_FILIAL" +CRLF
clQry += " AND C6_NUM = C5_NUM " +CRLF
//clQry += " AND C6_TPOPER = '01'" //Atenção ficou de verificar esta regra!!!
clQry += " AND E4_CODIGO = F2_COND  " +CRLF
clQry += " AND F2.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND D2.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND F4.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND B1.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND A1.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND A3.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND ACA.D_E_L_E_T_ = ' ' "+CRLF 
clQry += " AND C6.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND C5.D_E_L_E_T_ = ' ' " +CRLF
clQry += " AND E4.D_E_L_E_T_ = ' ' " +CRLF
clQry += " GROUP BY ACA_GRPREP, ACA_DESCRI" +CRLF
clQry += " ORDER BY ACA_GRPREP, ACA_DESCRI" +CRLF


clQry := ChangeQuery(clQry)

If SELECT(clAlia1) > 0
	(clAlia1)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),clAlia1, .T., .T.)

DbSelectArea(clAlia1)
DbgoTop()
nTotalFat := 0 
cDescri2 := ""
While (clAlia1)->(!EOF())
	nTotalFat +=(clAlia1)->TOTAL 
	cDescri2 += PadR(Capital((clAlia1)->(ACA_DESCRI)),50) + "R$ " + AllTrim(Transform((clAlia1)->TOTAL,"@E 999,999,999.99")) + CRLF
	cHtml2 += '<Br>'+ PadR(Capital((clAlia1)->(ACA_DESCRI)),50) + "R$ " + AllTrim(Transform((clAlia1)->TOTAL,"@E 999,999,999.99"))  
	(clAlia1)->(dbSkip())
End

//********************Devoluções **************************************************************************

//cAliasSD1:= GetNextAlias()

cWhereAux 	:= ""
cVendedor 	:= "1"

cWhere := ""
cAddField := "" 
If cPaisLoc == "BRA"
	For nCampo := 1 To nVendedor
		cCampo := "F2_VEND"+cVendedor
		If SF2->(FieldPos(cCampo)) > 0
			cWhereAux += "(" + cCampo + " between '      ' and 'ZZZZZZ') or "
			cAddField += ", "  + cCampo
		EndIf
		cVendedor := Soma1(cVendedor,1)
	Next nCampo
Else
	For nCampo := 1 To 35
		cCampo := "F1_VEND"+cVendedor
		If SF1->(FieldPos(cCampo)) > 0
			cWhereAux += "(" + cCampo + " between '     ' and 'ZZZZZZ') or "
			cAddField += ", "  + cCampo
		EndIf
		cVendedor := Soma1(cVendedor,1)
	Next nCampo
EndIf

If Empty(cWhereAux)
	cWhere += " NOT ("+IsRemito(2,"D1_TIPODOC")+")"
Else
	cWhereAux := Left(cWhereAux,Len(cWhereAux)-4)
	cWhere := "(" + cWhereAux + " ) AND NOT ("+IsRemito(2,"D1_TIPODOC")+")"	
EndIf


If SF1->(FieldPos("F1_FRETINC")) > 0
	cAddField += ", F1_FRETINC"
EndIf
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Esta Rotina adiciona a cQuery os campos retornados na string de filtro do  |
    //³ponto de entrada MR580FIL.                                                 |

cSqlDev := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET, F1_EST, F1_COND,"+CRLF
cSqlDev += " F1_DTDIGIT,F2_DOC, F2_SERIE, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_VEND1, F1_TXMOEDA, F1_MOEDA, F1_FORMUL, A3_NOME, A3_GRPREP, ACA_DESCRI, B1_XDESC, B1_PLATAF, B1_PUBLISH " + cAddField+CRLF
cSqlDev += " FROM " + RetSqlName("SD1") + " SD1, "+CRLF
cSqlDev += " " + RetSqlname("SF4") + " SF4,"+CRLF
cSqlDev += " " + RetSqlName("SF2") + " SF2,"+CRLF
cSqlDev += " " + RetSqlName("SF1") + " SF1,"+CRLF
cSqlDev += " " + RetSqlName("SA3") + " SA3,"+CRLF
cSqlDev += " " + RetSqlName("ACA") + " ACA,"+CRLF
cSqlDev += " " + RetSqlName("SB1") + " SB1 " +CRLF //,"+ RetSqlName("SZ1") + " SZ1"
cSqlDev += " WHERE D1_FILIAL  = '" + xFilial("SD1") + "'" +CRLF
cSqlDev += " AND D1_DTDIGIT BETWEEN '" + DTOS(DB_PAR05) + "' AND '" + DTOS(DB_PAR06) + "'"+CRLF
cSqlDev += " AND D1_TIPO = 'D'"+CRLF
cSqlDev += " AND F4_FILIAL  = '" + xFilial("SF4") + "'"+CRLF
cSqlDev += " AND F4_CODIGO  = D1_TES"+CRLF
cSqlDev += " AND F2_FILIAL  = '" + xFilial("SF2") + "' "  +CRLF
cSqlDev += " AND F2_DOC     = D1_NFORI" +CRLF
cSqlDev += " AND F2_SERIE   = D1_SERIORI"+CRLF
cSqlDev += " AND F2_LOJA    = D1_LOJA"+CRLF
cSqlDev += " AND F2_VEND1	 = A3_COD"+CRLF
cSqlDev += " AND F1_FILIAL  = '" + xFilial("SF1") + "'"+CRLF
cSqlDev += " AND F1_DOC     = D1_DOC" +CRLF
cSqlDev += " AND F1_SERIE   = D1_SERIE"+CRLF
cSqlDev += " AND F1_FORNECE = D1_FORNECE"+CRLF
cSqlDev += " AND F1_LOJA    = D1_LOJA"+CRLF
cSqlDev += " AND ACA_FILIAL = '" + xFilial("ACA") + "'"+CRLF
cSqlDev += " AND ACA_GRPREP = A3_GRPREP"+CRLF 
cSqlDev += " AND B1_FILIAL = '" + xFilial("SB1") + "' "+CRLF
cSqlDev += " AND B1_COD = D1_COD "+CRLF
cSqlDev += " AND A3_FILIAL	= '" + xFilial("SA3")  + "' " +CRLF
//cSqlDev += " AND A3_GRPREP BETWEEN '" + cGrpCli + "' AND '" + cGrpCli + "'"
cSqlDev += " AND SD1.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND SF4.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND SF2.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND SF1.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND SA3.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND ACA.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND SB1.D_E_L_E_T_ = ' '"+CRLF
cSqlDev += " AND " + cWhere+CRLF
cSqlDev += " ORDER BY D1_FILIAL,D1_FORNECE,D1_LOJA,D1_DTDIGIT,D1_DOC,D1_SERIE,D1_NUMSEQ " +CRLF

cSqlDev := ChangeQuery(cSqlDev)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlDev),cAliasSD1, .T., .T.)
nTotalDev := 0
While (cAliasSD1)->(!EOF()) 
	cProvCanal	:= "" 

	ntotalDev += (D1_TOTAL+D1_VALIPI + D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_DESPESA)
	
	(cAliasSD1)->(dbSkip())

End
//********************Devoluções**************************************************************************



//Query para pedidos não liberados
cQryAb := " SELECT C6_FILIAL, C6_ITEM, C6_PRODUTO, C6_PRCVEN, C6_VALOR, C5_VEND1, A3_NOME, A3_GRPREP "+CRLF
cQryAb += " FROM " + RetSqlName("SC6") + " SC6"+CRLF

cQryAb += " INNER JOIN " + RetSqlName("SC5") + " SC5" +CRLF
cQryAb += " ON C5_FILIAL = C6_FILIAL" +CRLF
cQryAb += " AND C5_NUM = C6_NUM" +CRLF
cQryAb += " AND C5_XSTAPED NOT IN('00','05') " +CRLF
cQryAb += " AND SC5.D_E_L_E_T_ = ''" +CRLF

cQryAb += " INNER JOIN "+ RetSqlName("SF4") + " SF4"+CRLF
cQryAb += " ON F4_FILIAL = '"+xFilial("SF4") +" '"+CRLF
cQryAb += " AND F4_CODIGO = C6_TES"+CRLF
cQryAb += " AND SF4.D_E_L_E_T_ = ''"+CRLF

cQryAb += " INNER JOIN " + RetSqlName("SA3") +" SA3"+CRLF
cQryAb += " ON A3_FILIAL = '" + xFilial("SA3") + "'" +CRLF
cQryAb += " AND A3_COD = C5_VEND1" +CRLF
cQryAb += " AND SA3.D_E_L_E_T_ = ' '"+CRLF


cQryAb += " WHERE SC6.D_E_L_E_T_ = ' '"+CRLF
cQryAb += " AND F4_DUPLIC = 'S'"+CRLF
cQryAb += " AND C6_FILIAL = '" + xFilial("SC6") + "' "+CRLF
cQryAb += " AND C5_EMISSAO BETWEEN '"  + DTOS(DB_PAR01) + "' AND '" + DTOS(DB_PAR02) + "' "+CRLF    // parâmetro oficial 5 e 6
cQryAb += " AND C6_BLQ <> 'R' "+CRLF
cQryAb += " AND C6_TPOPER = '01'"+CRLF
cQryAb += " AND" +CRLF
cQryAb += " NOT EXISTS "+CRLF
cQryAb += " 	( SELECT 1 "+CRLF
cQryAb += " 		FROM " + RetSqlName("SC9") + " SC9"+CRLF
cQryAb += "			WHERE SC9.C9_FILIAL = SC6.C6_FILIAL"+CRLF
cQryAb += "     	AND SC9.C9_PEDIDO = SC6.C6_NUM" +CRLF
cQryAb += "     	AND SC9.C9_ITEM = SC6.C6_ITEM"+CRLF
cQryAb += " 		AND SC9.D_E_L_E_T_ = ' ')"  +CRLF  

cQryAb := ChangeQuery(cQryAb)

If SELECT(cAliaAb) > 0
	(cAliaAb)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQryAb),cAliaAb, .T., .T.)
DbSelectArea(cAliaAb)
DbgoTop() 

nToNaoLib := 0    
While (cAliaAb)->(!EOF())
	//cGrpCanal := MyCanalVen((cAliaAb)->C6_NUM)
	nPosCanal := aScan( aCanais,{ |x| AllTrim( x[1] ) == (cAliaAb)->A3_GRPREP } ) 
	If nPosCanal > 0
		aCanais[nPosCanal,3,6] += (cAliaAb)->C6_VALOR 
		nToNaoLib += (cAliaAb)->C6_VALOR 
	EndIf 
	(cAliaAb)->(dbSkip())
	
End 

//Query para pedidos orçamento
cQryAb := " SELECT C6_FILIAL, C6_ITEM, C6_PRODUTO, C6_PRCVEN, C6_VALOR, C5_VEND1, A3_NOME, A3_GRPREP "+CRLF
cQryAb += " FROM " + RetSqlName("SC6") + " SC6"+CRLF

cQryAb += " INNER JOIN " + RetSqlName("SC5") + " SC5"+CRLF
cQryAb += " ON C5_FILIAL = C6_FILIAL"+CRLF
cQryAb += " AND C5_NUM = C6_NUM"+CRLF
cQryAb += " AND C5_XSTAPED IN('00','05') "
cQryAb += " AND SC5.D_E_L_E_T_ = ''" +CRLF

cQryAb += " INNER JOIN "+ RetSqlName("SF4") + " SF4"+CRLF
cQryAb += " ON F4_FILIAL = '"+xFilial("SF4") +" '"+CRLF
cQryAb += " AND F4_CODIGO = C6_TES"+CRLF
cQryAb += " AND SF4.D_E_L_E_T_ = ''"+CRLF

cQryAb += " INNER JOIN " + RetSqlName("SA3") +" SA3"+CRLF
cQryAb += " ON A3_FILIAL = '" + xFilial("SA3") + "'" +CRLF
cQryAb += " AND A3_COD = C5_VEND1" +CRLF
cQryAb += " AND SA3.D_E_L_E_T_ = ' '"+CRLF


cQryAb += " WHERE SC6.D_E_L_E_T_ = ''"+CRLF
cQryAb += " AND F4_DUPLIC = 'S'"+CRLF
cQryAb += " AND C6_FILIAL = '" + xFilial("SC6") + "' "+CRLF
cQryAb += " AND C5_EMISSAO BETWEEN '"  + DTOS(DB_PAR01) + "' AND '" + DTOS(DB_PAR02) + "' "+CRLF    // parâmetro oficial 5 e 6
cQryAb += " AND C6_BLQ <> 'R' "+CRLF
cQryAb += " AND C6_TPOPER = '01'"+CRLF
cQryAb += " AND" +CRLF
cQryAb += " NOT EXISTS "+CRLF
cQryAb += " 	( SELECT 1 "+CRLF
cQryAb += " 	FROM " + RetSqlName("SC9") + " SC9"+CRLF
cQryAb += " 	WHERE SC9.C9_FILIAL=SC6.C6_FILIAL"+CRLF
cQryAb += "     AND SC9.C9_PEDIDO = SC6.C6_NUM" +CRLF
cQryAb += "     AND SC9.C9_ITEM = SC6.C6_ITEM"+CRLF
cQryAb += " 	AND SC9.D_E_L_E_T_ = ' ')"         +CRLF  

cQryAb := ChangeQuery(cQryAb)

If SELECT(cAliaAb) > 0
	(cAliaAb)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQryAb),cAliaAb, .T., .T.)
DbSelectArea(cAliaAb)
(cAliaAb)->(DbgoTop())

nTotOrc := 0 
While (cAliaAb)->(!EOF())
	//cGrpCanal := MyCanalVen((cAliaAb)->C6_NUM)
	nPosCanal := aScan( aCanais,{ |x| AllTrim( x[1] ) == (cAliaAb)->A3_GRPREP } ) 
	If nPosCanal > 0
		aCanais[nPosCanal,3,7] += (cAliaAb)->C6_VALOR 
		nTotOrc += (cAliaAb)->C6_VALOR 
	EndIf 
	(cAliaAb)->(dbSkip())
	
End 

cHtml := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml">' 
cHtml += '<head>'
cHtml += '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'
cHtml += '</head>'
cHtml += '<body style="font-size: 12px; font-family: Arial, Verdana, sans-serif; background: #fafafa" >'
cHtml += '<div style="width: 90%; border: 1px solid #ececec; margin:0 auto; padding: 20px; background: #fff">'
//cHtml += '<img src="http://www.ncgames.com.br/public/img/logo/home-logo.png" alt="LOGOTIPO NCGAMES" />'
cHtml += '<hr style="border:none; border-top:1px solid #FCEFBA" />'
cHtml += '<!-- saved from url=(0022)http://internet.e-mail -->'
cHtml += '<p>' + "Prezado" + ' ' +  '<strong>'  + '</strong>,</p>'
//cHtml += '<DIV>'
//cHtml += '<DIV>'



clMensagem := "Workflow de visão comercial vendas até o dia " + DtoC(Date()) +  CRLF 
clMensagem += "Informação gerada pelo protheus." + " " + Time() + CRLF  + CRLF 
 
cHtml += '<Br>' +"Workflow de visão comercial vendas até o dia " + DtoC(Date()) + '<br />'
cHtml += "Informação gerada pelo protheus." + " " + Time() + CRLF  + CRLF  

cHtml += "<b>TOTAL EFETIVO – DEVOLUÇÃO:</b> R$ "  + Alltrim(Transform(nTotalFat+nlVlrOper - nTotalDev,"@E 999,999,999.99")) + "<br>"

cHtml += "<b>DEVOLUÇÃO:</b> R$ "  + Alltrim(Transform(nTotalDev,"@E 999,999,999.99")) + "<Br><br>"

cHtml += '<Br><b>'+ "TOTAL EFETIVO*: R$ " + Alltrim(Transform(nlVlrOper + nTotalFat,"@E 999,999,999.99")) + '</b><br />' 
cHtml += "*(Faturado + Operação)<Br><br>" 

clMensagem += "TOTAL EFETIVO*: R$ "  + Alltrim(Transform(nlVlrOper + nTotalFat ,"@E 999,999,999.99"))  + CRLF
clMensagem += "*(Faturado + Operação)" + CRLF 


/*clMensagem += "TOTAL EFETIVO*: R$ "  + Alltrim(Transform(nlVlrOper + nTotalFat ,"@E 999,999,999.99"))  + CRLF
cHtml += '<Br><b>'+ "TOTAL EFETIVO*: R$ " + Alltrim(Transform(nlVlrOper + nTotalFat,"@E 999,999,999.99")) + '</b><br />' 
clMensagem += "*(Faturado + Operação)" + CRLF 
cHtml += "*(Faturado + Operação)<Br><br>"  
//*******************devolucao/**************************

clMensagem += "DEVOLUÇÃO: R$ " + Alltrim(Transform(nTotalDev,"@E 999,999,999.99"))   + CRLF 
clMensagem += "TOTAL EFETIVO – DEVOLUÇÃO: "  + Alltrim(Transform(nTotalFat+nlVlrOper - nTotalDev,"@E 999,999,999.99")) + CRLF + CRLF
//clMensagem += "TOTAL FATURADO – DEVOLUÇÃO: "  + Alltrim(Transform(nTotalFat+nlVlrOper - nTotalDev,"@E 999,999,999.99")) + CRLF + CRLF

//cHtml += "<b>DEVOLUÇÃO:</b> R$ "  + Alltrim(Transform(nTotalDev,"@E 999,999,999.99")) + "<Br><br>"
//cHtml += "<b>TOTAL EFETIVO – DEVOLUÇÃO:</b> R$ "  + Alltrim(Transform(nTotalFat+nlVlrOper - nTotalDev,"@E 999,999,999.99")) + "<br>"
//cHtml += "<b>TOTAL FATURADO – DEVOLUÇÃO:</b> R$ "  + Alltrim(Transform(nTotalFat+nlVlrOper - nTotalDev,"@E 999,999,999.99")) + "<br>"

*/

//*********************devolucao/******************************
clMensagem += "FATURADO"
clMensagem += CRLF
cHtml += '<Br><b>'+ "FATURADO" + "</b>" 
cHtml += cHtml2
clMensagem += CRLF
clMensagem += cDescri2
clMensagem += CRLF
clMensagem += "TOTAL: R$ "+ Alltrim(Transform(nTotalFat,"@E 999,999,999.99")) + CRLF + CRLF 
cHtml += "<br><b> TOTAL: R$ " + Alltrim(Transform(nTotalFat,"@E 999,999,999.99")) + "</b>"  
 


cHtml += '<br>'+'<br />'

clMensagem += "OPERAÇÃO" 
clMensagem += CRLF
cHtml += '<Br><b>'+ "OPERAÇÃO" + "</b><Br>" 
For nli := 1 to Len(aCanais)
	If aCanais[nli,3,1] <> 0
		clMensagem += Space(5) + Padr(Capital(aCanais[nli,2]),50) + "R$ " + AllTrim(Transform(aCanais[nli,3,1],"@E 999,999,999.99")) + CRLF
		cHtml += Space(5) + Padr(Capital(aCanais[nli,2]),50) + "R$ " + AllTrim(Transform(aCanais[nli,3,1],"@E 999,999,999.99")) + '<Br>'
	EndIf
Next 
clMensagem += "TOTAL: R$ " + AllTrim(Transform(nlVlrOper,"@E 999,999,999.99")) + CRLF
cHtml += "<b>TOTAL: R$ " + AllTrim(Transform(nlVlrOper,"@E 999,999,999.99")) + '</b>'
clMensagem += CRLF
//cHtml += '<br>'+'<br />' 

cHtml += '<Br>'
clMensagem += "TOTAL POTENCIAL**: R$ "  + Alltrim(Transform(nToNaoLib + nBloqueado,"@E 999,999,999.99"))  + CRLF 
cHtml += '<Br><b>'+ "TOTAL POTENCIAL**: R$ " + Alltrim(Transform(nToNaoLib + nBloqueado,"@E 999,999,999.99")) + '</b><br />' 
clMensagem += "**(Crédito (Valor Em Analise) + Não liberados)"
cHtml += "**(Crédito (Valor Em Analise) + Não liberados)<Br>" 

clMensagem += CRLF
cHtml += '<br>'
clMensagem += "CRÉDITO"
clMensagem += CRLF
cHtml += "<br><b>CRÉDITO</b>"
//For nli := 1 to Len(aCanais)
	clMensagem += Space(5) + Padr(Capital("Rejeitado"),50) + "R$ " + AllTrim(Transform(nRejeitado,"@E 999,999,999.99")) + CRLF
	cHtml += '<Br>'+ Space(5) + Padr(Capital("Rejeitado"),50) + "R$ " + AllTrim(Transform(nRejeitado,"@E 999,999,999.99"))
	clMensagem += Space(5) + Padr(Capital("Em análise"),50) + "R$ " + AllTrim(Transform(nBloqueado,"@E 999,999,999.99")) + CRLF 
	cHtml += '<Br>'+ Space(5) + Padr(Capital("Em análise"),50) + "R$ " + AllTrim(Transform(nBloqueado,"@E 999,999,999.99")) 

	
	//Array[1] = Operacao, Array[2] = Analise Reprovado, Array[3] = Analise, Array[4] = Bloqueado, Array[5] Faturado   
	/*
	If aCanais[nli,3,2] <> 0
		clMensagem += Capital(Padr(aCanais[nli,2] + ": Rejeitado",50,"_")) + " R$ " + AllTrim(Transform(aCanais[nli,3,2],"@E 999,999,999.99")) + CRLF
	EndIf
	If aCanais[nli,3,4] <> 0
		clMensagem += Capital(Padr(aCanais[nli,2] + ": Em análise",50,"_")) + " R$ " + AllTrim(Transform(aCanais[nli,3,4],"@E 999,999,999.99")) + CRLF  
	EndIf
	*/
//Next

clMensagem += "TOTAL: R$ " + AllTrim(Transform(nlBlqCred,"@E 999,999,999.99")) + CRLF
cHtml 		+= "<br><b> TOTAL: R$ " + AllTrim(Transform(nlBlqCred,"@E 999,999,999.99")) + "</b>"

cHtml += '<br>'


clMensagem += CRLF 
clMensagem += "NÃO LIBERADOS:" 
clMensagem += CRLF 
cHtml += '<br><br><b>'+ "NÃO LIBERADOS:" + '</b>'
For nli := 1 to Len(aCanais)
	//Array[1] = Operacao, Array[2] = Analise Reprovado, Array[3] = Analise, Array[4] = Bloqueado, Array[5] Faturado 
	If aCanais[nli,3,6] <> 0
		clMensagem += Space(5) + Padr(Capital(aCanais[nli,2] ),50) + "R$ " + AllTrim(Transform(aCanais[nli,3,6],"@E 999,999,999.99")) + CRLF 
		cHtml += '<Br>' + Space(5) + Padr(Capital(aCanais[nli,2] ),50) + "R$ " + AllTrim(Transform(aCanais[nli,3,6],"@E 999,999,999.99")) 
	EndIf
Next 

clMensagem += "TOTAL R$ " + AllTrim(Transform(nToNaoLib,"@E 999,999,999.99"))
cHtml 	+=  '<br><b>' + "TOTAL R$ " + AllTrim(Transform(nToNaoLib,"@E 999,999,999.99")) + "</b>"



clMensagem += CRLF 
clMensagem += "ORÇAMENTO: " 
clMensagem += CRLF 
cHtml += '<br><br><b>'+ "ORÇAMENTO: " + '</b>'
For nli := 1 to Len(aCanais)
	//Array[1] = Operacao, Array[2] = Analise Reprovado, Array[3] = Analise, Array[4] = Bloqueado, Array[5] Faturado 
	If aCanais[nli,3,7] <> 0
		clMensagem += Space(5) + Padr(Capital(aCanais[nli,2] ),50) + "R$ " + AllTrim(Transform(aCanais[nli,3,7],"@E 999,999,999.99")) + CRLF 
		cHtml += '<Br>' + Space(5) + Padr(Capital(aCanais[nli,2] ),50) + "R$ " + AllTrim(Transform(aCanais[nli,3,7],"@E 999,999,999.99")) 
	EndIf
Next 


clMensagem += "TOTAL R$ " + AllTrim(Transform(nTotOrc,"@E 999,999,999.99"))
cHtml 	+=  '<br><b>' + "TOTAL R$ " + AllTrim(Transform(nTotOrc,"@E 999,999,999.99")) + "</b>"


/*
cHtml += '<Br>'
cHtml += '<Br>'
cHtml += '<br />'
cHtml += '<BR>*** NÃO RESPONDER A ESSE E-MAIL, POIS TRATA-SE DE UMA MENSAGEM AUTOMÁTICA ***'
cHtml += '<p><strong>Departamento de Tecnologia Da Informação</strong></p>'
cHtml += '<p>At.</p>' 
*/
cHtml += '</body>'
cHtml += '</html>' 

IF !LAUTO
	If  Aviso("Dados do processamento: ", clMensagem +" "+CRLF+CRLF+CRLF,{"Sim","Não"},3) == 1
		//MSGYESNO(clMensagem + CRLF + "Enviar por e-mail? " ) 
		clMensagem += "*** NÃO RESPONDER A ESSE E-MAIL, POIS TRATA-SE DE UMA MENSAGEM AUTOMÁTICA ***"
		U_ENVIAEMAIL(cEmails, cCC, cBCC, "Previa de vendas " + DtoC(Date()) + " - " + time(), cHtml, aFiles)
	EndIf
ELSE
	U_ENVIAEMAIL(cEmails, cCC, cBCC, "Previa de vendas " + DtoC(Date()) + " - " + time(), cHtml, aFiles)
ENDIF

If SELECT(clAlia1) > 0
	(clAlia1)->(dbCloseArea())
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VerWMS  ºAutor  ³Microsiga           º Data ³  02/17/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function VerWMS(cPed, CNF)

_cPEDWMAS := " SELECT max(INTEG.SEQUENCIAINTEGRACAO) DOCINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG "
_cPEDWMAS += " WHERE (DOC.NUMERODOCUMENTO = '"+cPed+"') "
_cPEDWMAS += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "
_cPEDWMAS += " ORDER BY INTEG.SEQUENCIAINTEGRACAO "
_cPEDWMAS := ChangeQuery(_cPEDWMAS)

If Select("TRWM") >0
	dbSelectArea("TRWM")
	dbCloseArea()
Endif

TCQUERY _cPEDWMAS New Alias "TRWM"

dbSelectArea("TRWM")

_cPEDWMAS1 := " SELECT * FROM ORAINT.INTEGRACAO "
_cPEDWMAS1 += " WHERE SEQUENCIAINTEGRACAO = "+STR(TRWM->DOCINT)+"  "
_cPEDWMAS1 := ChangeQuery(_cPEDWMAS1)

If Select("TRWM1") >0
	dbSelectArea("TRWM1")
	dbCloseArea()
Endif

TCQUERY _cPEDWMAS1 New Alias "TRWM1"

dbSelectArea("TRWM1")

cWMS:= ""
IF TRWM1->TIPOINTEGRACAO == 251 .AND. TRWM1->TIPOINTEGRACAO <> 0 //.AND. TRWM->ESTADOINTEGRACAO == 1
	cWMS := "E"
ELSE
	cWMS := ""
ENDIF

If Select("TRWM") >0
	dbSelectArea("TRWM")
	dbCloseArea()
Endif
If Select("TRWM1") >0
	dbSelectArea("TRWM1")
	dbCloseArea()
Endif
Return(cWMS)

Static Function MyCanalVen(cCodVen)

Local cRetCanal := ""  

SA3->(DbSetOrder(1))
If SA3->(dbSeek(xFilial("SA3") + cCodVen))
	cRetCanal := SA3->A3_GRPREP
Else
	cRetCanal := "SEM VENDEDOR"
EndIf

Return cRetCanal
 
