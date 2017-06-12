#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#Include "FIVEWIN.Ch"
#Include "TBICONN.CH"  
 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO4     º Autor ³ AP6 IDE            º Data ³  04/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DBRELPIC(aldata)    
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Pendências Logistica"
Local cPict          := ""
Local titulo         := "RELATORIO TRACKING"
Local nLin           := 80 

Local CBLQCRED:= " "
LOCAL NVLRTOT := 0 
Local clCanal := ""
Local clDCanal := "" 

                      //0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
                      //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1         :="NumPed   Emissao  Cliente         UF       Vlr Ped  Dt Lib   Hr Lib C Dt Cred  Hr Cred Dt Pick  HrPick  DtEtiqV  HrEtiqV DtEmis NF HrNF   Dt Etiq NF Hr Etiq NF Dt Saida Entrega   NumNF     Serie Nat Oper      Vlr Tot NF  Transp"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Local clTime 

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "TRACK_PICK" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "TRACK_PICK"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "TRACK_PICK" // Coloque aqui o nome do arquivo usado para impressao em disco

Private lAuto := IIF(Select("SM0") > 0, .f., .t.)
		
IF LAUTO
	QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1'
ENDIF

//VALIDPERG()

//pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Private clCodcli := "" 
Private clLoja	:= ""

Default alData := {} 

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

dlDtDe := dldTLibDe - 45
dlDtate := Date()

DB_PAR01 := dlDtde  //AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","DB_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR02 := dlDtAte //AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","DB_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR03 := 1  //AADD(aRegs,{cPerg,"03","Export Excel?","","","mv_ch3","C",1,0,1,"C","","DB_PAR03","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
DB_PAR04 := "L" //AADD(aRegs,{cPerg,"04","Liberado ?","","","mv_ch4","C",1,0,1,"C","","DB_PAR04","TODOS","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR05 := dlDtlibde //AADD(aRegs,{cPerg,"05","Data Lib. De ?","","","mv_ch5","D", 8,0,0,"G","","DB_PAR05","","","","","","","","","","","","","","","","","","","","","","","","",""})
DB_PAR06 := dlDtLibAte //AADD(aRegs,{cPerg,"06","Data Lib. Ate ?", 



//IF DB_PAR03 == 1
	aDbStru := {}
	AADD(aDbStru,{"NUMPED","C",08,0})
	AADD(aDbStru,{"ROMANEIO","N",15,0})
	AADD(aDbStru,{"TPOPER","C",20,0})
	AADD(aDbStru,{"CAMP","C",10,0})
	AADD(aDbStru,{"DCAMP","C",60,0})
	AADD(aDbStru,{"EMISPED","C",08,0}) 
	AADD(aDbStru,{"CODCLI","C",6,0} )
	AADD(aDbStru,{"LOJA","C",2,0} )
	AADD(aDbStru,{"CANAL","C",TamSX3("A1_YCANAL")[1],0} )
	AADD(aDbStru,{"DCANAL","C",TamSX3("ACA_DESCRI")[1],0} )
	AADD(aDbStru,{"NOMECLI","C",30,0} )
	AADD(aDbStru,{"CIDADE","C",TamSX3("A1_MUN")[1],TamSX3("A1_MUN")[2]} )
	AADD(aDbStru,{"UF","C",02,0} )
	AADD(aDbStru,{"CEP","C",10,0})
	AADD(aDbStru,{"ENDENT","C",60,0})
	AADD(aDbStru,{"BAIRROE","C",30,0})		
	AADD(aDbStru,{"VLRPED","N",14,2} )
	AADD(aDbStru,{"DTLIBPED","C",08,0} )
	AADD(aDbStru,{"HORALIB","C",05,0})
	AADD(aDbStru,{"CRED","C",01,0})
	AADD(aDbStru,{"ESTORNO","C",01,0})
	AADD(aDbStru,{"DTLIBCRED","C",08,0})
	AADD(aDbStru,{"HRLIBCRED","C",05,0})
	AADD(aDbStru,{"DTDISPSEP","C",10,0})
	AADD(aDbStru,{"HRDISPSEP","C",05,0})
	AADD(aDbStru,{"DTINISEP","C",10,0})
	AADD(aDbStru,{"HRINISEP","C",05,0})
	AADD(aDbStru,{"USUAR_SEP","C",60,0})
	AADD(aDbStru,{"DTDISCONF","C",10,0})
	AADD(aDbStru,{"HRDISCONF","C",05,0})
	AADD(aDbStru,{"DTINICONF","C",10,0})
	AADD(aDbStru,{"HRINICONF","C",05,0})
	AADD(aDbStru,{"USU_CONF","C",60,0})
	AADD(aDbStru,{"DTDISPNF","C",10,0})
	AADD(aDbStru,{"HRDISPNF","C",05,0})
	AADD(aDbStru,{"DTPICK","C",10,0})
	AADD(aDbStru,{"HORAPICK","C",05,0})
	AADD(aDbStru,{"DTETIVOL","C",10,0})
	AADD(aDbStru,{"HRETIVOL","C",05,0})
	AADD(aDbStru,{"DTEMISNF","C",10,0})
	AADD(aDbStru,{"HRNF","C",05,0})
	AADD(aDbStru,{"DTETINF","C",08,0})
	AADD(aDbStru,{"HRETINF","C",05,0})
	AADD(aDbStru,{"DTSAIDA","C",10,0})
	AADD(aDbStru,{"DTENTREG","C",10,0})	
	AADD(aDbStru,{"NUMNF","C",09,0})
	AADD(aDbStru,{"SERIENF","C",03,0})
	AADD(aDbStru,{"VOLNF","N",10,0})
	AADD(aDbStru,{"ESPEC","C",03,0})
	AADD(aDbStru,{"PLIQUI","N",15,4})
	AADD(aDbStru,{"PBRUTO","N",15,4})
	AADD(aDbStru,{"NATOPER","C",20,0})
	AADD(aDbStru,{"VLRTOTNF","N",14,2})
	AADD(aDbStru,{"TRANSP","C",15,0})
	AADD(aDbStru,{"LIBERPED","C",01,0})
	AADD(aDbStru,{"VEND","C",06,0})
	AADD(aDbStru,{"AGENDAM","C",3,0} )
	AADD(aDbStru,{"QTDITENS","N",12,0} )
	AADD(aDbStru,{"QTDPROD","N",12,0} )
	AADD(aDbStru,{"DTPREVENT","C",10,0})
	AADD(aDbStru,{"DTDISFT","C",10,0})
	AADD(aDbStru,{"DTAGEND","C",10,0})
	//AADD(aDbStru,{"PEDCLI","C",15,0})
		
	
	
	Do Case
		Case Month(DB_PAR05) < 4
	   		CNOMEDBF := "TK"+STRZERO(YEAR(DB_PAR05),4) + "Q1"
	 	Case Month(DB_PAR05) < 7 .And. Month(DB_PAR05) > 3
	 		CNOMEDBF := "TK"+STRZERO(YEAR(DB_PAR05),4) + "Q2"
	 	Case Month(DB_PAR05) < 10 .And. Month(DB_PAR05) > 6 
	 		CNOMEDBF := "TK"+STRZERO(YEAR(DB_PAR05),4) + "Q3"
	 	Case Month(DB_PAR05) > 9 
	 		CNOMEDBF := "TK"+STRZERO(YEAR(DB_PAR05),4) + "Q4"
	 EndCase		
	
  	//If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	//FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
   //	EndIf 
	clTime := Time()
	While ":" $ clTime
		clTime := Stuff(clTime,At(":",clTime),1,"")
	End
	CNOMEDBF := "TK"+STRZERO(YEAR(DB_PAR05),4) 
	//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR 
	If File("XLSNC\" + CNOMEDBF + ".dbf")
	//fErase("XLSNC\" + CNOMEDBF +GetDBExtension())                        SubStr(DtoS(Date()   ),5,4)
		//COPY FILE ("XLSNC\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF +  SubStr(DtoS(Date()),5,4) + ".dbf")
		fErase("XLSNC\" + CNOMEDBF +GetDBExtension())
	EndIf
	If File("SYSTEM\" + CNOMEDBF + ".dbf")
	//fErase("XLSNC\" + CNOMEDBF +GetDBExtension())                        SubStr(DtoS(Date()   ),5,4)
		//COPY FILE ("XLSNC\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF +  SubStr(DtoS(Date()),5,4) + ".dbf")
		fErase("SYSTEM\" + CNOMEDBF +GetDBExtension()) 
	EndIf
//CNOMEDBF := "TK"+STRZERO(YEAR(DB_PAR05),4) 

DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + ".dbf")
fErase("SYSTEM\" + CNOMEDBF +GetDBExtension()) 

If Select("NCPED") > 0
	NCPED->(DbCloseArea())
EndIf
	//DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
	DbUseArea(.T.,"DBFCDXADS","XLSNC\" + CNOMEDBF,"NCPED",.T.,.F.)
//ENDIF

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP ,C5_XECOMER  "
cQuery+= " FROM "+ RetSqlName("SC5") +" SC5, "+ RetSqlName("SA4") +" SA4, "+ RetSqlName("SC6") +" SC6, "+ RetSqlName("SC9") +" SC9 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(DB_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(DB_PAR02)+"' "
cQuery+= " AND C9_DATALIB >= '"+DTOS(DB_PAR05)+"' "
cQuery+= " AND C9_DATALIB <= '"+DTOS(DB_PAR06)+"' "
cQuery+= " AND C5_FILIAL = '"+XFILIAL("SC5")+"' "
cQuery+= " AND C6_NUM = C5_NUM AND C5_NUM = C9_PEDIDO "
cQuery+= " AND C6_PRODUTO = C9_PRODUTO AND C6_FILIAL = C9_FILIAL AND C6_ITEM = C9_ITEM "
cQuery+= " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND (C9_BLEST = ' ' OR C9_BLEST = '10') "
//IF DB_PAR04 == 1
//	cQuery+= " AND C5_LIBEROK = 'S' "
//ELSEIF DB_PAR04 == 2
//	cQuery+= " AND C5_LIBEROK = ' ' "
//ENDIF

cQuery+= " AND SC5.D_E_L_E_T_ <> '*' "
cQuery+= " AND SA4.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC6.D_E_L_E_T_ <> '*' " 
cQuery+= " AND SC9.D_E_L_E_T_ <> '*' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " AND C9_FILIAL = '"+XFILIAL("SC9")+"' "
cQuery+= " AND A4_FILIAL = '"+XFILIAL("SA4")+"' "
cQuery+= " GROUP BY C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP ,C5_XECOMER"
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

DbSelectArea("SA1")
DbSetOrder(1)

DbSelectArea("SZ1")
DbSetOrder(1)   


DbSelectArea("SZA")
DbSetOrder(1)



dbSelectArea("TRB1")
TRB1->(dbGoTop())
cEstWMS	:= ""

NSEQ:= TRB1->C6_SEQCAR

WHILE TRB1->(!EOF())
		
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	CNUMPED		:= TRB1->C5_NUM //+"/"+ALLTRIM(STR(TRB1->C6_SEQCAR))
	DDTPED		:= SUBSTR(TRB1->C5_EMISSAO,7,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,5,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,3,2) //STOD(TRB1->C5_EMISSAO)
	CCLIENTE	:= SUBSTR(TRB1->C5_NOMCLI,1,15)
	clCodCli	:= TRB1->C5_CLIENTE
	clLoja		:= TRB1->C5_LOJACLI
	SA1->(DbSeek(xFilial("SA1") + TRB1->C5_CLIENTE + TRB1->C5_LOJACLI))
	CUF			:= SA1->A1_EST
	CCIDADE		:= SA1->A1_MUN
	CCEP		:= SA1->A1_CEP
	CEENT		:= SA1->A1_ENDENT
	CBAIR		:= SA1->A1_BAIRROE
	Clcanal		:= SA1->A1_YCANAL
	//Cldcanal	:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_YDCANAL"))  
	Cldcanal	:= ALLTRIM(POSICIONE("ACA",1,XFILIAL("ACA")+SA1->A1_YCANAL,"ACA_DESCRI"))
	CCAMP		:= TRB1->C5_CODCAMP
	CDCAMP		:= ALLTRIM(POSICIONE("SZA",1,XFILIAL("SZA")+TRB1->C5_CODCAMP,"ZA_DESCR"))
	AGENDAMENTO := IIF(SA1->A1_AGEND == "1", "SIM", "NAO")
	DDTDISFAT	:= SUBSTR(TRB1->C5_DTDISNF,7,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,5,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,3,2)
	DDTPREVENTR	:= SUBSTR(TRB1->C5_DTAGEND,7,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,5,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,3,2)
	If TRB1->C5_XECOMER=="C" 
		U_COM05EndEnt(CNUMPED,@CEENT,@CBAIR,@CCEP,@CCIDADE,@CUF)
	EndIf
	
	IF  DDTDISFAT == "  /  /  "
		DDTDISFAT := "        "
	ENDIF
	
	IF 	EMPTY(ALLTRIM(TRB1->C5_DTAGEND ))
		DDTPREVENTR := "        "
	ENDIF
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
	CESPEC		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_ESPECI1")
	NVOLNF		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_VOLUME1")
	NPLIQUI		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_PLIQUI")
	NPBRUTO		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_PBRUTO")
	DDTAGEN		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_DATAAG")
	CNATOP		:= SUBSTR(ALLTRIM(POSICIONE("SF4",1,XFILIAL("SF4")+SD2->D2_TES,"F4_TEXTO")),1,10)
	
	DDTEMISNF	:= SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_EMISSAO")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_EMISSAO")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_EMISSAO")),3,2)//STOD(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+SD2->D2_DOC+SD2->D2_SERIE,"F2_EMISSAO")))
	
	CHRNF			:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_HORA")
	NVLRTOTNF	:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_VALMERC")
	CTRANSP		:= SUBSTR(ALLTRIM(TRB1->A4_NREDUZ),1,08)
	
	DBSELECTAREA("SZ7")
	SZ7->(DBSETORDER(3))
	
	IF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C6_NOTA+TRB1->C6_SERIE+"000012"))
		DDTETINF	:= SUBSTR(DTOS(SZ7->Z7_DATA),7,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),5,2)+"/"+SUBSTR(DTOS(SZ7->Z7_DATA),3,2)//STOD(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+SD2->D2_DOC+SD2->D2_SERIE,"Z1_DTEMISS")))
		CHRETINF	:= SZ7->Z7_HORA
	ELSE
		DDTETINF	:= "        "
		CHRETINF    := "     "
	ENDIF
	SZ7->(DBCLOSEAREA("SZ7"))
	
	DDTSAIDA	:= SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+TRB1->C6_NOTA+TRB1->C6_SERIE,"Z1_DTSAIDA")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+TRB1->C6_NOTA+TRB1->C6_SERIE,"Z1_DTSAIDA")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+TRB1->C6_NOTA+TRB1->C6_SERIE,"Z1_DTSAIDA")),3,2)//STOD(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+SD2->D2_DOC+SD2->D2_SERIE,"Z1_DTSAIDA")))
	
	DDTENTR		:= SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+TRB1->C6_NOTA+TRB1->C6_SERIE,"Z1_DTENTRE")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+TRB1->C6_NOTA+TRB1->C6_SERIE,"Z1_DTENTRE")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+TRB1->C6_NOTA+TRB1->C6_SERIE,"Z1_DTENTRE")),3,2)//STOD(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+SD2->D2_DOC+SD2->D2_SERIE,"Z1_DTENTRE")))
	
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


		NCPED->(RECLOCK("NCPED",.T.))
		
		NCPED->NUMPED			:= CNUMPED
		NCPED->TPOPER			:= POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER")+" - "+POSICIONE("SX5",1,XFILIAL("SX5")+"DJ"+POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER"),"X5_DESCRI")
		NCPED->EMISPED		:= DDTPED
		NCPED->CODCLI		:= TRB1->C5_CLIENTE // clCodCli
		NCPED->NOMECLI		:= CCLIENTE
		NCPED->CIDADE			:= CCIDADE
		NCPED->UF				:= CUF 
		NCPED->ENDENT			:= CEENT
		NCPED->BAIRROE		:= CBAIR
		NCPED->CANAL		:= clCanal
		NCPED->DCANAL		:= clDCanal
		NCPED->QTDITENS		:= NQTDITEM
		NCPED->QTDPROD		:= NQTDPROD
		NCPED->VLRPED			:= NVLRTOT
		NCPED->DTLIBPED		:= DDTLIB
		NCPED->HORALIB		:= CHRLIB 

		NCPED->CRED			:= CBLQCRED
		NCPED->ESTORNO		:= cEstWMS
		NCPED->DTLIBCRED		:= DDTLIBCRED
		NCPED->HRLIBCRED		:= CHRLIBCRED
		NCPED->DTPICK			:= DDTPICK
		NCPED->HORAPICK		:= CHRPICK
		NCPED->DTETIVOL		:= DDTETIPED
		NCPED->HRETIVOL		:= CHRETIPED
		NCPED->DTEMISNF		:= DDTEMISNF
		NCPED->HRNF			:= CHRNF
		NCPED->DTETINF		:= DDTETINF
		NCPED->HRETINF		:= CHRETINF
		NCPED->DTSAIDA		:= DDTSAIDA
		NCPED->DTENTREG		:= DDTENTR
		NCPED->NUMNF			:= CNUMNF
		NCPED->SERIENF		:= CSERIE
		NCPED->VOLNF			:= NVOLNF
		NCPED->ESPEC			:= CESPEC
		NCPED->PLIQUI			:= NPLIQUI
		NCPED->PBRUTO			:= NPBRUTO
		NCPED->NATOPER		:= CNATOP
		NCPED->VLRTOTNF		:= NVLRTOTNF
		NCPED->TRANSP			:= CTRANSP
		NCPED->LIBERPED		:= TRB1->C5_LIBEROK
		NCPED->VEND			:= TRB1->C5_VEND1
		//NCPED->CLIENT			:= TRB1->C5_CLIENTE
		NCPED->LOJA			:= TRB1->C5_LOJACLI
		NCPED->DTDISPSEP      := TRB9->DTDSEP
	    NCPED->HRDISPSEP      := TRB9->HRDSEP
	    NCPED->DTINISEP       := TRB9->DTSEP
	    NCPED->HRINISEP       := TRB9->HRSEP
		NCPED->DTDISCONF		:= TRB9->DTDCONF
		NCPED->HRDISCONF		:= TRB9->HRDCONF
	    NCPED->DTINICONF      := TRB9->DTCONF
	    NCPED->HRINICONF      := TRB9->HRCONF
	    NCPED->DTDISPNF       := TRB9->DTDNF
	    NCPED->HRDISPNF       := TRB9->HRDNF
	    NCPED->USUAR_SEP		:= TRB9->USUSEP
	    NCPED->USU_CONF		:= TRB9->USUCONF
	    NCPED->ROMANEIO		:= TRB9->ROMAN
	    NCPED->CAMP			:= CCAMP
	    NCPED->DCAMP			:= CDCAMP
	    NCPED->DTPREVENT		:= SUBSTR(TRB1->C5_DTAGEND,7,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,5,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,3,2)
	    NCPED->DTDISFT		:= SUBSTR(TRB1->C5_DTDISNF,7,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,5,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,3,2)
	    If ValType(DDTAGEN) = "D"
	    	NCPED->DTAGEND		:= SUBSTR(DTOS(DDTAGEN),7,2)+"/"+SUBSTR(DTOS(DDTAGEN),5,2)+"/"+SUBSTR(DTOS(DDTAGEN),3,2)
	    EndIf
	    NCPED->CEP			:= CCEP
	    AGEND:= POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_AGEND")
	    NCPED->AGENDAM		:= IIF(AGEND == "1", "SIM", "NAO")
	    
	   
	    
	ENDIF

	
	TRB1->(DBSKIP())
	
	NVLRTOT := 0
	nLin ++
	NSEQ++
	IF TRB1->C5_NUM <> SUBSTR(CNUMPED,1,6)
		NSEQ:= TRB1->C6_SEQCAR
	ENDIF
ENDDO

IF DB_PAR03 == 1
	NCPED->(DBGOTOP())
	//CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
	//Alert("Arquivo salvo em C:\RELATORIOS\" + CNOMEDBF + ".DBF" )
	
	
	DbSelectArea("TRB1")
	DbCloseArea()
	
   //	oExcelApp := MsExcel():New()
	//oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
   //	oExcelApp:SetVisible(.T.)
	NCPED->(DBCLOSEAREA())
ENDIF

//FErase("\SYSTEM\" + CNOMEDBF +".DBF")

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VALIDPERG ³ Autor ³ RAIMUNDO PEREIRA      ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg() 

Local j := 0
Local i := 0
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Export Excel?","","","mv_ch3","C",1,0,1,"C","","mv_par03","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Liberado ?","","","mv_ch4","C",1,0,1,"C","","mv_par04","TODOS","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Data Lib. De ?","","","mv_ch5","D", 8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Data Lib. Ate ?","","","mv_ch6","D", 8,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
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
