#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
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
User Function TRACK_PICK           

u_nctrack001()

Return

/*Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Pendências Logistica"
Local cPict          := ""
Local titulo         := "RELATORIO TRACKING"
Local nLin           := 80
//0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1         :="NumPed   Emissao  Cliente         UF       Vlr Ped  Dt Lib   Hr Lib C Dt Cred  Hr Cred Dt Pick  HrPick  DtEtiqV  HrEtiqV DtEmis NF HrNF   Dt Etiq NF Hr Etiq NF Dt Saida Entrega   NumNF     Serie Nat Oper      Vlr Tot NF  Transp"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Local cHISTWF		 := ""
Local nVlFrete		 := 0

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

VALIDPERG()

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint("SC5",NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,"SC5")

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return
*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  04/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local CBLQCRED:= " "
LOCAL NVLRTOT := 0



IF MV_PAR03 == 1
	aDbStru := {}
	AADD(aDbStru,{"NUMPED","C",08,0})
	AADD(aDbStru,{"ROMANEIO","N",15,0})
	AADD(aDbStru,{"TPOPER","C",20,0})
	AADD(aDbStru,{"CAMP","C",10,0})
	AADD(aDbStru,{"DCAMP","C",60,0})
	AADD(aDbStru,{"EMISPED","C",08,0})
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
	AADD(aDbStru,{"TRAN_NF","C",15,0})
	AADD(aDbStru,{"LIBERPED","C",01,0})
	AADD(aDbStru,{"VEND","C",06,0})
	AADD(aDbStru,{"CLIENT","C",06,0})
	AADD(aDbStru,{"LOJA","C",02,0})
	AADD(aDbStru,{"AGENDAM","C",3,0} )
	AADD(aDbStru,{"QTDITENS","N",12,0} )
	AADD(aDbStru,{"QTDPROD","N",12,0} )
	AADD(aDbStru,{"DTPREVENT","C",10,0})
	AADD(aDbStru,{"DTDISFT","C",10,0})
	AADD(aDbStru,{"DTAGEND","C",10,0})
	AADD(aDbStru,{"DTLIMFIN","C",10,0})
	AADD(aDbStru,{"OBSFIN","C",255,0})
	AADD(aDbStru,{"HISTWF","C",60,0})
	AADD(aDbStru,{"VL_FRETE","N",12,2})
	AADD(aDbStru,{"TP_FRETE","C",3,0})
	AADD(aDbStru,{"TRAN_FINAL","C",40,0})
	AADD(aDbStru,{"USU_EXPED","C",30,0})
	AADD(aDbStru,{"PEDCLI","C",15,0})
	
	CNOMEDBF := "TRACKING-"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))
	
	If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
		FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	EndIf
	
	//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
	DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
	
	If Select("XLS")>0
		XLS->(DbCloseArea())
	EndIf
	
	
	DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)
ENDIF

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP, C5_YDLIMIT  , C5_PEDCLI,C5_XECOMER  "
cQuery+= " FROM "+RetSqlName("SC5")+" SC5, "+RetSqlName("SA4")+" SA4, "+RetSQlName("SC6")+" SC6, "+RetSqlName("SC9")+" SC9 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"' "
cQuery+= " AND C9_DATALIB >= '"+DTOS(MV_PAR05)+"' "
cQuery+= " AND C9_DATALIB <= '"+DTOS(MV_PAR06)+"' "
cQuery+= " AND C5_FILIAL = '"+XFILIAL("SC5")+"' "
cQuery+= " AND C6_NUM = C5_NUM AND C5_NUM = C9_PEDIDO "
cQuery+= " AND C6_PRODUTO = C9_PRODUTO AND C6_FILIAL = C9_FILIAL AND C6_ITEM = C9_ITEM "
cQuery+= " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND (C9_BLEST = ' ' OR C9_BLEST = '10') "
cQuery+= " AND SC5.D_E_L_E_T_ = ' ' "
cQuery+= " AND SA4.D_E_L_E_T_ = ' ' "
cQuery+= " AND SC6.D_E_L_E_T_ = ' ' "
cQuery+= " AND SC9.D_E_L_E_T_ = ' ' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " AND A4_FILIAL = '  ' AND C9_FILIAL = '03' "
cQuery+= " GROUP BY C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP, C5_YDLIMIT, C5_PEDCLI,C5_XECOMER "
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

SetRegua(RecCount())


dbSelectArea("TRB1")
TRB1->(dbGoTop())
cEstWMS	:= ""

NSEQ:= TRB1->C6_SEQCAR

WHILE TRB1->(!EOF())
	cTr_Final	:= ""
	cUsu_expe	:= ""
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	nVlFrete	:= 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	
	CNUMPED		:= TRB1->C5_NUM //+"/"+ALLTRIM(STR(TRB1->C6_SEQCAR))
	DDTPED		:= SUBSTR(TRB1->C5_EMISSAO,7,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,5,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,3,2) //STOD(TRB1->C5_EMISSAO)
	CCLIENTE	:= SUBSTR(TRB1->C5_NOMCLI,1,15)
	CUF			:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_EST"))
	CCIDADE		:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_MUN"))
	CCEP		:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_CEP"))
	CEENT		:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_ENDENT"))
	CBAIR		:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_BAIRROE"))
	CCAMP		:= TRB1->C5_CODCAMP
	If TRB1->C5_XECOMER=="C" 
		U_COM05EndEnt(CNUMPED,@CEENT,@CBAIR,@CCEP,@CCIDADE,@CUF)
	EndIf
	CDCAMP		:= ALLTRIM(POSICIONE("SZA",1,XFILIAL("SZA")+TRB1->C5_CODCAMP,"ZA_DESCR"))
	AGENDAMENTO := IIF(ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_AGEND")) == "1", "SIM", "NAO")
	DDTDISFAT	:= SUBSTR(TRB1->C5_DTDISNF,7,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,5,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,3,2)
	DDTPREVENTR	:= SUBSTR(TRB1->C5_DTAGEND,7,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,5,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,3,2)
	
	DDTLIMCRED := SUBSTR(TRB1->C5_YDLIMIT,7,2)+"/"+SUBSTR(TRB1->C5_YDLIMIT,5,2)+"/"+SUBSTR(TRB1->C5_YDLIMIT,3,2)
	
	
	CINFOBS := POSICIONE("SC5",1,XFILIAL("SC5")+CNUMPED,"C5_YFINOBS")
	
	nlinvsint := mlcount(CINFOBS)
	clinvsint := ""
	For nx := 1 to nlinvsint
		clinvsint += if(right(MemoLine(CINFOBS,,nx ),1) == " ",alltrim(MemoLine(CINFOBS,,nx ))+" ",alltrim(MemoLine(CINFOBS,,nx )))
	Next nx
	
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
	
	cCodBlCred := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM,"C9_BLCRED")
	
	IF cCodBlCred == "04".OR.cCodBlCred == "01"
		CBLQCRED	:= "X"
	ELSEIF cCodBlCred == '09'
		CBLQCRED	:= "R"
	ELSE
		CBLQCRED	:= " "
	ENDIF
	//Verifica estorno do pick list WMS
	cEstWMS	:= ""
	If ctod(DDTLIB) < ctod("03/08/13") //data da substituição do wms store para wms Inovatec
		cEstWMS	:= VerWMS(TRB1->C5_NUM)
	Else
		cEstWMS	:= VerINOV(TRB1->C5_NUM)
	EndIf
	
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
	cHISTWF		:= LEFT(GETADVFVAL("SE1","E1_HISTWF",XFILIAL("SE1")+SD2->(D2_DOC+D2_SERIE),1,""),60)
	nVlFrete	:= POSICIONE("SF2",1,XFILIAL("SF2")+SD2->(D2_DOC+D2_SERIE),"F2_FRETE")
	nVlFrete	:= nVlFrete+POSICIONE("SF2",1,XFILIAL("SF2")+SD2->(D2_DOC+D2_SERIE),"F2_SEGURO")
	cTP_FRETE	:= POSICIONE("SF2",1,XFILIAL("SF2")+SD2->(D2_DOC+D2_SERIE),"F2_TPFRETE")
	If cTP_FRETE == "C"
		cTP_FRETE	:= "CIF"
	ElseIf cTP_FRETE == "F"
		cTP_FRETE	:= "FOB"
	ElseIf cTP_FRETE == "T"
		cTP_FRETE	:= "TER"
	ElseIf cTP_FRETE == "S"
		cTP_FRETE	:= "SFR"
	EndIf
	CNUMNF		:= TRB1->C6_NOTA
	CSERIE		:= TRB1->C6_SERIE
	CESPEC		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_ESPECI1")
	NVOLNF		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_VOLUME1")
	NPLIQUI		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_PLIQUI")
	NPBRUTO		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_PBRUTO")
	DDTAGEN		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_DATAAG")
	CTNNF		:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_TRANSP")
	CTRANNF		:= POSICIONE("SA4",1,XFILIAL("SA4")+CTNNF,"A4_NREDUZ")
	CNATOP		:= SUBSTR(ALLTRIM(POSICIONE("SF4",1,XFILIAL("SF4")+SD2->D2_TES,"F4_TEXTO")),1,10)
	
	DDTEMISNF	:= SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_EMISSAO")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_EMISSAO")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_EMISSAO")),3,2)//STOD(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+SD2->D2_DOC+SD2->D2_SERIE,"F2_EMISSAO")))
	
	CHRNF			:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_HORA")
	NVLRTOTNF	:= POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->C6_NOTA+TRB1->C6_SERIE,"F2_VALBRUT") //F2_VALMERC alterado em 16/06/2013 por Rodrigo - conforme solicitação de Edmar Brito
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
	
	IF MV_PAR03 == 1
		
		IF EMPTY(CNUMNF)
			CNUM := TRB1->C5_NUM
		ELSE
			CNUM := CNUMNF
		ENDIF
		
		dDTDISPSEP      := ""
		cHRDISPSEP      := ""
		dDTINISEP       := ""
		cHRINISEP       := ""
		dDTDISCONF		:= ""
		cHRDISCONF		:= ""
		dDTINICONF      := ""
		cHRINICONF      := ""
		dDTDISPNF       := ""
		cHRDISPNF       := ""
		cUSUAR_SEP		:= ""
		cUSU_CONF		:= ""
		cROMANEIO		:= 0
		
		
		If ctod(DDTLIB) < ctod("03/08/13") //data da substituição do wms store para wms Inovatech
			
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
			
			dDTDISPSEP      := TRB9->DTDSEP
			cHRDISPSEP      := TRB9->HRDSEP
			dDTINISEP       := TRB9->DTSEP
			cHRINISEP       := TRB9->HRSEP
			dDTDISCONF		:= TRB9->DTDCONF
			cHRDISCONF		:= TRB9->HRDCONF
			dDTINICONF      := TRB9->DTCONF
			cHRINICONF      := TRB9->HRCONF
			dDTDISPNF       := TRB9->DTDNF
			cHRDISPNF       := TRB9->HRDNF
			cUSUAR_SEP		:= TRB9->USUSEP
			cUSU_CONF		:= TRB9->USUCONF
			cROMANEIO		:= TRB9->ROMAN
			
		Else
			_cQuery01 := " SELECT TO_CHAR(DT_HOR_DISPONIVEL_SEPARACAO,'DD/MM/YYYY HH24:MI:SS') DTDISPSEP,
			_cQuery01 += " TO_CHAR(DT_HOR_INICIO_SEPARACAO,'DD/MM/YYYY HH24:MI:SS') DTINISEP,
			_cQuery01 += " USUARIO_SEPARACAO USUSEP,
			_cQuery01 += " DOCSEP.NUMERO_ROMANEIO ROMAN,
			_cQuery01 += " DOCSEP.DOCUMENTO_ERP PEDWMS,
			_cQuery01 += " DOCSEP.COD_DEPOSITO CODDEP,
			_cQuery01 += " TO_CHAR(DT_HOR_DISPONIVEL_CONFERENCIA,'DD/MM/YYYY HH24:MI:SS') DTDISPCONF,
			_cQuery01 += " TO_CHAR(DT_HOR_INICIO_CONFERENCIA,'DD/MM/YYYY HH24:MI:SS') DTINICONF,
			_cQuery01 += " TO_CHAR(DT_HOR_FIM_CONFERENCIA,'DD/MM/YYYY HH24:MI:SS') DTFIMCONF,
			_cQuery01 += " USUARIO_CONFERENCIA USUCONF
			_cQuery01 += " FROM WMS.VIW_DOC_SEPARACAO_ERP DOCSEP LEFT OUTER JOIN WMS.VIW_DOC_SAIDA_ERP DOCSAIDA
			_cQuery01 += " ON(DOCSEP.DOCUMENTO_ERP = DOCSAIDA.DOCUMENTO_ERP)
			_cQuery01 += " WHERE DOCSEP.DOCUMENTO_ERP = '"+xFilial("SC5")+CNUMPED+"'
			_cQuery01 += " ORDER BY DOCSEP.DOCUMENTO_ERP, DOCSEP.DT_HOR_INICIO_SEPARACAO
			
			_cQuery01 := ChangeQuery(_cQuery01)
			
			If Select("TRB9") > 0
				dbSelectArea("TRB9")
				dbCloseArea()
			EndIf
			
			TCQUERY _cQuery01 New Alias "TRB9"
			lFirst	:= .T.
			While TRB9->(!eof())
				If lFirst
					dDTDISPSEP      := substr(TRB9->DTDISPSEP,1,10)
					cHRDISPSEP      := substr(TRB9->DTDISPSEP,12,8)
					dDTINISEP       := substr(TRB9->DTINISEP,1,10)
					cHRINISEP       := substr(TRB9->DTINISEP,12,8)
					dDTDISCONF		:= substr(TRB9->DTDISPCONF,1,10)
					cHRDISCONF		:= substr(TRB9->DTDISPCONF,12,8)
					dDTINICONF      := substr(TRB9->DTINICONF,1,10)
					cHRINICONF      := substr(TRB9->DTINICONF,12,8)
					dDTDISPNF       := substr(TRB9->DTFIMCONF,1,10)
					cHRDISPNF       := substr(TRB9->DTFIMCONF,12,8)
					cUSU_CONF		:= alltrim(TRB9->USUCONF)
					cROMANEIO		:= iif(TRB9->ROMAN==nil,0,TRB9->ROMAN)
					cUSUAR_SEP		:= alltrim(TRB9->USUSEP)
					cUsu_expe		:= TrUsuExp(cROMANEIO)
					lFirst	:= .F.
				Else
					cUSUAR_SEP		+= ", "+alltrim(TRB9->USUSEP)
				EndIf
				
				TRB9->(dbskip())
			end
			
			cTr_Final	:= TrFRETES(CNUMNF,CSERIE)
			
		EndIf
		
		XLS->(RECLOCK("XLS",.T.))
		
		XLS->NUMPED			:= CNUMPED
		XLS->TPOPER			:= POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER")+" - "+POSICIONE("SX5",1,XFILIAL("SX5")+"DJ"+POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER"),"X5_DESCRI")
		XLS->EMISPED		:= DDTPED
		XLS->NOMECLI		:= CCLIENTE
		XLS->CIDADE			:= CCIDADE
		XLS->UF				:= CUF
		XLS->ENDENT			:= CEENT
		XLS->BAIRROE		:= CBAIR
		XLS->QTDITENS		:= NQTDITEM
		XLS->QTDPROD		:= NQTDPROD
		XLS->VLRPED			:= NVLRTOT
		XLS->DTLIBPED		:= DDTLIB
		XLS->HORALIB		:= CHRLIB
		XLS->CRED			:= CBLQCRED
		XLS->ESTORNO		:= cEstWMS
		XLS->DTLIBCRED		:= DDTLIBCRED
		XLS->HRLIBCRED		:= CHRLIBCRED
		XLS->DTPICK			:= DDTPICK
		XLS->HORAPICK		:= CHRPICK
		XLS->DTETIVOL		:= DDTETIPED
		XLS->HRETIVOL		:= CHRETIPED
		XLS->DTEMISNF		:= DDTEMISNF
		XLS->HRNF			:= CHRNF
		XLS->DTETINF		:= DDTETINF
		XLS->HRETINF		:= CHRETINF
		XLS->DTSAIDA		:= DDTSAIDA
		XLS->DTENTREG		:= DDTENTR
		XLS->NUMNF			:= CNUMNF
		XLS->SERIENF		:= CSERIE
		XLS->VOLNF			:= NVOLNF
		XLS->ESPEC			:= CESPEC
		XLS->PLIQUI			:= NPLIQUI
		XLS->PBRUTO			:= NPBRUTO
		XLS->NATOPER		:= CNATOP
		XLS->VLRTOTNF		:= NVLRTOTNF
		XLS->TRANSP			:= CTRANSP
		XLS->TRAN_NF		:= CTRANNF
		XLS->LIBERPED		:= TRB1->C5_LIBEROK
		XLS->VEND			:= TRB1->C5_VEND1
		XLS->CLIENT			:= TRB1->C5_CLIENTE
		XLS->LOJA			:= TRB1->C5_LOJACLI
		XLS->DTDISPSEP    := dDTDISPSEP
		XLS->HRDISPSEP   	:= cHRDISPSEP
		XLS->DTINISEP    	:= dDTINISEP
		XLS->HRINISEP    	:= cHRINISEP
		XLS->DTDISCONF		:= dDTDISCONF
		XLS->HRDISCONF		:= cHRDISCONF
		XLS->DTINICONF   	:= dDTINICONF
		XLS->HRINICONF   	:= cHRINICONF
		XLS->DTDISPNF    	:= dDTDISPNF
		XLS->HRDISPNF  	:= cHRDISPNF
		XLS->USUAR_SEP		:= cUSUAR_SEP
		XLS->USU_CONF		:= cUSU_CONF
		XLS->ROMANEIO		:= cROMANEIO
		XLS->CAMP			:= CCAMP
		XLS->DCAMP			:= CDCAMP
		XLS->DTPREVENT		:= SUBSTR(TRB1->C5_DTAGEND,7,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,5,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,3,2)
		XLS->DTDISFT		:= SUBSTR(TRB1->C5_DTDISNF,7,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,5,2)+"/"+SUBSTR(TRB1->C5_DTDISNF,3,2)
		XLS->DTAGEND		:= SUBSTR(DTOS(DDTAGEN),7,2)+"/"+SUBSTR(DTOS(DDTAGEN),5,2)+"/"+SUBSTR(DTOS(DDTAGEN),3,2)
		XLS->CEP				:= CCEP
		AGEND					:= POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_AGEND")
		XLS->AGENDAM		:= IIF(AGEND == "1", "SIM", "NAO")
		XLS->DTLIMFIN		:= DDTLIMCRED
		XLS->OBSFIN			:= clinvsint
		XLS->HISTWF			:= cHISTWF
		XLS->VL_FRETE 		:= nVlFrete
		XLS->TP_FRETE 		:= cTP_FRETE
		XLS->TRAN_FINAL	:= cTr_Final
		XLS->USU_EXPED		:= cUsu_expe
		
		XLS->PEDCLI			:=TRB1->C5_PEDCLI
		
	ENDIF
	@ nLin, 00 		    PSAY  CNUMPED
	@ nLin, 09 		    PSAY  DDTPED
	@ nLin, 18 		    PSAY  CCLIENTE
	@ nLin, 34 		    PSAY  CUF
	@ nLin, 37 		    PSAY  TRANSFORM(NVLRTOT, "@E 9,999,999.99")
	
	@ nLin, 52 		    PSAY  DDTLIB
	@ nLin, 61 		    PSAY  CHRLIB
	
	@ nLin, 68 		    PSAY  CBLQCRED
	@ nLin, 70 		    PSAY  DDTLIBCRED
	@ nLin, 79 		    PSAY  CHRLIBCRED
	
	@ nLin, 87 		    PSAY  DDTPICK
	@ nLin, 96 		    PSAY  CHRPICK
	
	@ nLin, 104		    PSAY  DDTETIPED
	@ nLin, 113		    PSAY  CHRETIPED
	
	@ nLin, 121		    PSAY  DDTEMISNF
	@ nLin, 131		    PSAY  CHRNF
	
	@ nLin, 138		    PSAY  DDTETINF
	@ nLin, 149		    PSAY  CHRETINF
	
	@ nLin, 160		    PSAY  DDTSAIDA
	@ nLin, 169		    PSAY  DDTENTR
	
	@ nLin, 179		    PSAY  CNUMNF
	@ nLin, 189		    PSAY  CSERIE
	
	IF !EMPTY(CNATOP)
		@ nLin, 195	    PSAY  CNATOP
	ENDIF
	
	@ nLin, 206		    PSAY  TRANSFORM(NVLRTOTNF, "@E 9,999,999.99")
	
	IF !EMPTY(CTRANSP)
		@ nLin, 221	    PSAY  CTRANSP
	ENDIF
	
	
	
	
	TRB1->(DBSKIP())
	
	NVLRTOT := 0
	nLin ++
	NSEQ++
	IF TRB1->C5_NUM <> SUBSTR(CNUMPED,1,6)
		NSEQ:= TRB1->C6_SEQCAR
	ENDIF
ENDDO

IF MV_PAR03 == 1
	XLS->(DBGOTOP())
	CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
	Alert("Arquivo salvo em C:\RELATORIOS\" + CNOMEDBF + ".DBF" )
	
	If ! ApOleClient( 'MsExcel' )
		MsgStop( 'MsExcel nao instalado' )
		Return
	EndIf
	
	DbSelectArea("TRB1")
	DbCloseArea()
	
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
ENDIF

FErase("\SYSTEM\" + CNOMEDBF +".DBF")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return */

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
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
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
*/
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

//Verifica se há cancelamento do pedido no WMS
Static Function VerINOV(cPed)

Local cWMS	:= ""
Local cQry	:= ""
Local cAliasWMS	:= GetNextAlias()

cQry	:= "SELECT CES_DATA_EXCLUSAO FROM WMS.TB_WMSINTERF_CANC_ENT_SAI WHERE CES_COD_CHAVE = '"+xFilial("SC5")+cPed+"'
Iif(Select(cAliasWMS) > 0,(cAliasWMS)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasWMS,.F.,.T.)
While (cAliasWMS)->(!eof())
	cWMS	:= "E"
	(cAliasWMS)->(dbskip())
End

(cAliasWMS)->(dbclosearea())

Return(cWMS)


//Função para busca o código da Transportadora Final
Static Function TrFRETES(cNumNf,cSerieNf)

Local aAreaSA4	:= SA4->(GetArea())
Local cRet		:= ""
Local cCGCSA4	:= ""
Local cQry		:= ""
Local cAliasFRE	:= GetNextAlias()


cQry	:= " SELECT NUMNF_NFDESPACHADAS NUMNF, SERIENF_NFDESPACHADAS SERIENF, CNPJ_FILIAISTRANSPORTE CGCTRANSP FROM FRETES.TB_FRTNFDESPACHADAS "
cQry	+= " WHERE NUMNF_NFDESPACHADAS = '"+alltrim(str(val(cNumNf)))+"' "
cQry	+= " AND SERIENF_NFDESPACHADAS = '"+alltrim(str(val(cSerieNf)))+"' "
Iif(Select(cAliasFRE) > 0,(cAliasFRE)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasFRE  ,.F.,.T.)
While (cAliasFRE)->(!eof()) .and. Empty(cCGCSA4)
	cCGCSA4	:= (cAliasFRE)->CGCTRANSP
	(cAliasFRE)->(dbskip())
End

If !Empty(cCGCSA4)
	DbSelectArea("SA4")
	DbSetOrder(3)
	If DbSeek(xFilial("SA4")+cCGCSA4)
		cRet	:= SA4->A4_NOME
	Else
		cRet	:= cCGCSA4
	Endif
Else
	cRet	:= cCGCSA4
Endif

(cAliasFRE)->(dbCloseArea())

RestArea(aAreaSA4)

Return	cRet




//Função para busca o código da Transportadora Final
Static Function TrUsuExp(nRoman)

Local cRet		:= ""
Local cQry		:= ""
Local cAliasFRE	:= GetNextAlias()


cQry	:= " SELECT DISTINCT(USUARIO_LEITURA) USUEXP FROM WMS.TB_CONF_VOLUME WHERE NUM_PRE_ROMANEIO = "+alltrim(str(nRoman))+" "
Iif(Select(cAliasFRE) > 0,(cAliasFRE)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasFRE  ,.F.,.T.)
While (cAliasFRE)->(!eof()) .and. Empty(cRet)
	cRet	:= (cAliasFRE)->USUEXP
	(cAliasFRE)->(dbskip())
End

(cAliasFRE)->(dbCloseArea())

Return	cRet
