#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#Include "FIVEWIN.Ch"
#Include "TBICONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBRELPRV  º Autor ³ AP6 IDE            º Data ³  11/09/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DBRELPRV (aldata)


Local CBLQCRED:= " "
LOCAL NVLRTOT := 0
Local clCanal := ""
Local clDCanal := ""
Local cCC, cBCC:= ""
Local aFiles:= {}

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
Private nVlrTotNf := 0
Private nVlrTot := 0
Private lAuto := IIF(Select("SM0") > 0, .f., .t.)

IF LAUTO
	QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1'
ENDIF

clAlia1 := GetNextAlias()

//VALIDPERG()

//pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Private clCodcli := ""
Private clLoja	:= ""
Private alData := {}
Private cEmails := ""
Private cBCC	:= ""

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
		X6_CONTEUD := "alberto.kibino@dbms.com.br;rciambarella@ncgames.com.br"  // Cabe ate 250 caracteres.
		X6_CONTSPA := "alberto.kibino@dbms.com.br;rciambarella@ncgames.com.br"
		X6_CONTENG := "alberto.kibino@dbms.com.br;rciambarella@ncgames.com.br"
		X6_PROPRI	:= "U"
		X6_PYME := "S"
		MsUnLock()
	EndIf
EndIf

cEmails := AllTrim(Getmv("DBM_REMAIL"))+AllTrim(Getmv("DB_REMAIL1"))+AllTrim(Getmv("DB_REMAIL2"))
cBCC	:= "cmacedo@ncgames.com.br"



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

dlDtDe := dldTLibDe //CtoD("01/07/2012") // dldTLibDe - 45
dlDtate := Date()

DB_PAR01 := dlDtde - 15  //AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","DB_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR02 := dlDtAte //AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","DB_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR03 := 1  //AADD(aRegs,{cPerg,"03","Export Excel?","","","mv_ch3","C",1,0,1,"C","","DB_PAR03","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
DB_PAR04 := "L" //AADD(aRegs,{cPerg,"04","Liberado ?","","","mv_ch4","C",1,0,1,"C","","DB_PAR04","TODOS","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR05 := dlDtlibde //AADD(aRegs,{cPerg,"05","Data Lib. De ?","","","mv_ch5","D", 8,0,0,"G","","DB_PAR05","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR06 := dlDtLibAte //AADD(aRegs,{cPerg,"06","Data Lib. Ate ?",

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP   "
cQuery+= " FROM SC5010, SA4010, SC6010, SC9010 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(DB_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(DB_PAR02)+"' "
cQuery+= " AND C9_DATALIB >= '"+DTOS(DB_PAR05)+"' "
cQuery+= " AND C9_DATALIB <= '"+DTOS(DB_PAR06)+"' "
cQuery+= " AND C5_FILIAL = '"+XFILIAL()+"' "
cQuery+= " AND C6_NUM = C5_NUM AND C5_NUM = C9_PEDIDO "
cQuery+= " AND C6_PRODUTO = C9_PRODUTO AND C6_FILIAL = C9_FILIAL AND C6_ITEM = C9_ITEM "
cQuery+= " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND (C9_BLEST = ' ' OR C9_BLEST = '10') "
cQuery+= " AND SC5010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SA4010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC6010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC9010.D_E_L_E_T_ <> '*' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " AND C9_FILIAL = '"+XFILIAL("SC9")+"' "
cQuery+= " AND A4_FILIAL = '  ' "
cQuery+= " GROUP BY C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP "
cQuery+= " ORDER BY C5_NUM, C6_SEQCAR, C6_NOTA "

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
	
	IF TRB1->C5_CODBL == "04".OR.TRB1->C5_CODBL == "01"
		CBLQCRED	:= "X"
	ELSEIF TRB1->C5_CODBL == "09"
		CBLQCRED	:= "R"
	ELSE
		CBLQCRED	:= " "
	ENDIF
	//Verifica estorno do pick list WMS
	cEstWMS	:= ""
	cEstWMS	:= VerWMS(TRB1->C5_NUM)
	
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
	
	If SF2->(dbSeek(xFilial("SF2") + TRB1->C6_NOTA+TRB1->C6_SERIE))
		CESPEC		:= SF2->F2_ESPECI1
		NVOLNF		:= SF2->F2_VOLUME1
		NPLIQUI		:= SF2->F2_PLIQUI
		NPBRUTO		:= SF2->F2_PBRUTO
		DDTAGEN		:= SF2->F2_DATAAG
		CHRNF		:= SF2->F2_HORA
		
		NVLRTOTNF	:= SF2->F2_VALMERC + SF2->F2_FRETE + SF2->F2_SEGURO + SF2->F2_ICMSRET + SF2->F2_VALIPI
	EndIf
	
	IF DB_PAR03 == 1
		
		IF EMPTY(CNUMNF)
			CNUM := TRB1->C5_NUM
		ELSE
			CNUM := CNUMNF
		ENDIF
		
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
		
		If CBLQCRED == "X"
			nlBlqCred += NVLRTOT
		EndIf
		If !EMPTY(CNUMNF)
			nlvlrFat += NVLRTOTNF
		Else
			If Empty(AllTrim(CBLQCRED))
				If AllTrim(POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER")) == "01"
					nlVlrOper += NVLRTOT
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


clQry := " SELECT SUM(D2_TOTAL+D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_ICMSRET) as TOTAL"
clQry += " FROM " + RetSqlName("SF2" ) +" F2"
clQry += "  , SD2010 D2 , SF4010 F4 , SB1010 B1 , SA1010 A1 , SA3010 A3 , ACA010 ACA , SC6010 C6 , SC5010 C5 , SE4010 E4  "
clQry += " WHERE  D2_FILIAL = '" + xFilial("SD2") + "'"
clQry += " AND F2_EMISSAO >= '"  + DTOS(DB_PAR05) + "' AND F2_EMISSAO <= '" + DTOS(DB_PAR06) + "' "
clQry += " AND F2_FILIAL = D2_FILIAL AND F2_DOC = D2_DOC AND F2_SERIE = D2_SERIE"
clQry += " AND D2_TES = F4_CODIGO AND F4_DUPLIC = 'S' AND D2_COD = B1_COD "
clQry += " AND F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA AND F2_VEND1 = A3_COD "
clQry += " AND A3_GRPREP = ACA_GRPREP AND F2_FILIAL = C6_FILIAL AND D2_PEDIDO = C6_NUM "
clQry += " AND D2_ITEMPV = C6_ITEM AND C6_FILIAL = C5_FILIAL AND C6_NUM = C5_NUM "
clQry += " AND E4_CODIGO = F2_COND AND F2.D_E_L_E_T_ != '*' "
clQry += " AND D2.D_E_L_E_T_ != '*' AND F4.D_E_L_E_T_ != '*' AND B1.D_E_L_E_T_ != '*' AND A1.D_E_L_E_T_ != '*' "
clQry += " AND A3.D_E_L_E_T_ != '*' AND ACA.D_E_L_E_T_ != '*' AND C6.D_E_L_E_T_ != '*' AND C5.D_E_L_E_T_ != '*' AND E4.D_E_L_E_T_ != '*' "

clQry := ChangeQuery(clQry)

If SELECT(clAlia1) > 0
	(clAlia1)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),clAlia1, .T., .T.)




clMensagem := "Previa de vendas do dia " + DtoC(Date()) + CRLF + CRLF
clMensagem += "Valor em operação: R$ " + AllTrim(Transform(nlVlrOper,"@E 999,999,999.99")) + CRLF
clMensagem += "Valor análise crédito: R$ " + AllTrim(Transform(nlBlqCred,"@E 999,999,999.99")) + CRLF
clMensagem += "Valor Faturado: R$ " + Alltrim(Transform((clAlia1)->TOTAL,"@E 999,999,999.99")) + CRLF + CRLF
clMensagem += "Total: R$ "  + Alltrim(Transform((clAlia1)->TOTAL + nlVlrOper + nlBlqCred,"@E 999,999,999.99"))  + CRLF + CRLF
clMensagem += "Relatório gerado pelo Protheus às " + Time() + CRLF
IF !LAUTO
	If MSGYESNO(clMensagem + CRLF + "Enviar por e-mail? " )
		U_ENVIAEMAIL(cEmails, cCC, cBCC, "Previa de vendas " + DtoC(Date()) + " - " + time(), clMensagem, aFiles)
	EndIf
ELSE
	U_ENVIAEMAIL(cEmails, cCC, cBCC, "Previa de vendas " + DtoC(Date()) + " - " + time(), clMensagem, aFiles)
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
