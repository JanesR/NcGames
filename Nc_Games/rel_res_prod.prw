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
User Function RES_PROD

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "RESUMO TRACKING POR PRODUTO"
Local cPict          := ""
Local titulo         := "RELATORIO TRACKING RESUMO POR PRODUTO"
Local nLin           := 80
//0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1         :="Cod. Produto     Descrição Produto                                       Vlr. Total        Qtd. Peças             Qtd. Itens"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RES_PROD" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RES_PROD"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RES_PROD" // Coloque aqui o nome do arquivo usado para impressao em disco

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

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local CBLQCRED:= " "
LOCAL NVLRTOT 	:= 0
LOCAL NQTDLIB 	:= 0
LOCAL NQTDITEM	:= 0
LOCAL NQTDPROD	:= 0
LOCAL VLRBRUT 	:= 0
LOCAL VLRSICM 	:= 0
LOCAL VLRMERC 	:= 0
LOCAL NSEQ 		:= 0
LOCAL QTDITEMFT := 0
Local aCampos 	:= {}
Local nVlrTBrut := 0
Local nVlrSicms := 0
Local nVlrMerc  := 0
Local nQTDPCFT  := 0
Local nQTDITFT  := 0
Local nVlrTAF   := 0
Local nQTDPCAF  := 0
Local nQTDITAF  := 0
Local nVlrTB1   := 0
Local nVlrSi1 	:= 0
Local nVlrMe1 	:= 0
Local nQTDPC1 	:= 0
Local nQTDIT1 	:= 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria array para gerar arquivo de trabalho                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("D2_COD")
AADD(aCampos,{ "TB_PROD"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("B1_XDESC")
AADD(aCampos,{ "TB_DESCR","C",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TB_VLRTAF","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_QUANT")
AADD(aCampos,{ "TB_QTDITAF","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_QUANT")
AADD(aCampos,{ "TB_QTDPCAF","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TB_PRCMAF","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TB_VLRBRF","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TB_VLRSIF","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TB_VLRMERC","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_QUANT")
AADD(aCampos,{ "TB_QTDITFT","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_QUANT")
AADD(aCampos,{ "TB_QTDPCFT","N",aTam[1],aTam[2] } )
aTam:=TamSX3("D2_TOTAL")
AADD(aCampos,{ "TB_PRCMFT","N",aTam[1],aTam[2] } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cNomArq 	:= CriaTrab(aCampos,.T.)
dbUseArea( .T.,, cNomArq,"TRB5", .T. , .F. )

_cArq1   := CriaTrab(NIL,.F.)
_cChave1 := "TB_PROD"
IndRegua("TRB5",_cArq1,_cChave1,,,"Selecionando Regs...")		//"Selecionando Registros..."

dbClearIndex()
dbSetIndex(_cArq1+OrdBagExt())

IF MV_PAR03 == 1
	aDbStru := {}
	AADD(aDbStru,{"CODPROD","C",15,0})
	AADD(aDbStru,{"DESCPROD","C",60,0} )
	AADD(aDbStru,{"VLRTOT","N",14,2} )
	AADD(aDbStru,{"QTDITENS","N",12,0} )
	AADD(aDbStru,{"QTDPECAS","N",12,0} )
	AADD(aDbStru,{"PRCMD","N",14,2} )
	AADD(aDbStru,{"VLRBRUT","N",14,2} )
	AADD(aDbStru,{"VLRSICM","N",14,2} )
	AADD(aDbStru,{"VLRMERC","N",14,2} )
	AADD(aDbStru,{"QTDITEFT","N",12,0} )
	AADD(aDbStru,{"QTDPECFT","N",12,0} )
	AADD(aDbStru,{"PRCMDFT","N",14,2} )
	
	CNOMEDBF := "RESPROD-"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))
	
	If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
		FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	EndIf
	
	//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
	DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
	DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)
ENDIF

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT C9_PRODUTO PRODC9, SUM(C9_QTDLIB*C6_PRCVEN)VLRAFT, SUM(C9_QTDLIB) QTDLIB, COUNT(*) QTDITAFT "
cQuery+= " FROM SC5010, SA4010, SC6010, SC9010 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"' "
cQuery+= " AND C9_DATALIB >= '"+DTOS(MV_PAR04)+"' "
cQuery+= " AND C9_DATALIB <= '"+DTOS(MV_PAR05)+"' "
cQuery+= " AND C5_FILIAL = '"+XFILIAL("SC5")+"' "
cQuery+= " AND C9_PRODUTO >= '"+ALLTRIM(MV_PAR06)+"' "
cQuery+= " AND C9_PRODUTO <= '"+ALLTRIM(MV_PAR07)+"' "
cQuery+= " AND C6_NUM = C5_NUM AND C5_NUM = C9_PEDIDO "
cQuery+= " AND C6_PRODUTO = C9_PRODUTO AND C6_FILIAL = C9_FILIAL AND C6_ITEM = C9_ITEM "
cQuery+= " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND (C9_BLEST = ' ' OR C9_BLEST = '10') AND (C9_BLCRED = ' ' )  "
cQuery+= " AND SC5010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SA4010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC6010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC9010.D_E_L_E_T_ <> '*' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " AND C9_NFISCAL = ' ' "
cQuery+= " AND C6_TPOPER = '01' AND C9_SEQUEN = '01' "
cQuery+= " GROUP BY C9_PRODUTO "
cQuery+= " ORDER BY C9_PRODUTO "

If Select("TRB2") > 0
	dbSelectArea("TRB2")
	dbCloseArea("TRB2")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB2",.T.,.T.)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())


dbSelectArea("TRB2")
TRB2->(dbGoTop())

WHILE TRB2->(!EOF())
	
	dbSelectArea("TRB5")
	dbSetOrder(1)
	
	IF TRB5->(dbSeek(TRB2->PRODC9))
		RecLock("TRB5",.F.)
	Else
		RECLOCK("TRB5", .T.)
		REPLACE TB_PROD WITH TRB2->PRODC9
		REPLACE TB_DESCR WITH POSICIONE("SB1",1,XFILIAL("SB1")+TRB2->PRODC9,"B1_XDESC")
	ENDIF
	REPLACE TB_VLRTAF WITH TB_VLRTAF+(TRB2->VLRAFT)
	REPLACE TB_QTDITAF	WITH TB_QTDITAF+TRB2->QTDITAFT
	REPLACE TB_QTDPCAF WITH TB_QTDPCAF + TRB2->QTDLIB
	TRB5->(MSUNLOCK())
	
	nVlrTAF   += TB_VLRTAF
	nQTDPCAF  += TB_QTDPCAF
	nQTDITAF  += TB_QTDITAF
	
	TRB2->(DBSKIP())
	
ENDDO

cQuery1:= " SELECT D2_COD, SUM(D2_TOTAL+D2_VALIPI+D2_VALFRE+D2_SEGURO+D2_DESPESA+D2_ICMSRET) VLRBRUT,  "
cQuery1+= " SUM(D2_TOTAL-D2_VALICM) VLRSICMIPI, SUM(D2_TOTAL) VLRMERC, SUM(D2_QUANT) QTDPCFT, COUNT(*) QTDIFT  "
cQuery1+= " FROM SD2010, SF2010, SF4010 "
cQuery1+= " WHERE D2_FILIAL = '"+XFILIAL("SD2")+"' "
cQuery1+= " AND D2_FILIAL = F2_FILIAL "
cQuery1+= " AND D2_DOC = F2_DOC "
cQuery1+= " AND F2_SERIE 	= D2_SERIE "
cQuery1+= " AND F2_EMISSAO >= '"+DTOS(MV_PAR08)+"' "
cQuery1+= " AND F2_EMISSAO <= '"+DTOS(MV_PAR09)+"' "
cQuery1+= " AND F4_FILIAL = '  ' "
cQuery1+= " AND D2_TES = F4_CODIGO "
cQuery1+= " AND F4_DUPLIC = 'S' "
cQuery1+= " AND F4_ESTOQUE = 'S' "
cQuery1+= " AND F2_VEND1 <> ' ' "
cQuery1+= " AND SD2010.D_E_L_E_T_ = ' ' "
cQuery1+= " AND SF4010.D_E_L_E_T_ = ' ' "
cQuery1+= " AND SF2010.D_E_L_E_T_ = ' ' "
cQuery1+= " GROUP BY D2_COD "
cQuery1+= " ORDER BY D2_COD "

If Select("TRB3") > 0
	dbSelectArea("TRB3")
	dbCloseArea("TRB3")
Endif

cQuery1 := ChangeQuery(cQuery1)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),"TRB3",.T.,.T.)

dbSelectArea("TRB3")

WHILE TRB3->(!EOF())
	dbSelectArea("TRB5")
	TRB5->(dbSetOrder(1))
	If TRB5->(dbSeek(TRB3->D2_COD))
		RecLock("TRB5",.F.)
	Else
		RecLock("TRB5",.T.)
		REPLACE TB_PROD WITH TRB3->D2_COD
		REPLACE TB_DESCR WITH POSICIONE("SB1",1,XFILIAL("SB1")+TRB3->D2_COD,"B1_XDESC")
	EndIF
	REPLACE TB_VLRTAF 	WITH TB_VLRTAF
	REPLACE TB_QTDITAF	WITH TB_QTDITAF
	REPLACE TB_QTDPCAF 	WITH TB_QTDPCAF
	REPLACE TB_VLRBRF 	WITH TB_VLRBRF+TRB3->VLRBRUT
	REPLACE TB_VLRSIF   WITH TB_VLRSIF+TRB3->VLRSICMIPI
	REPLACE TB_VLRMERC  WITH TB_VLRMERC+TRB3->VLRMERC
	REPLACE TB_QTDITFT  WITH TB_QTDITFT+TRB3->QTDIFT
	REPLACE TB_QTDPCFT  WITH TB_QTDPCFT+TRB3->QTDPCFT
	nVlrTBrut += TB_VLRBRF
	nVlrSicms += TB_VLRSIF
	nVlrMerc  += TB_VLRMERC
	nQTDPCFT  += TB_QTDPCFT
	nQTDITFT  += TB_QTDITFT
	
	TRB5->(MSUNLOCK())
	
	TRB3->(DBSKIP())
	
ENDDO

IF MV_PAR10 = 1
	cQuery2:= " SELECT D1_COD, SUM(D1_TOTAL+D1_ICMSRET+D1_VALIPI-D1_VALDESC) VLRBRUT1,
	cQuery2+= " SUM( D1_TOTAL-D1_VALICM ) VLRSICMIPI1, SUM( D1_TOTAL ) VLRMERC1, SUM( D1_QUANT ) QTDPCFT1, COUNT(*) QTDIFT1
	cQuery2+= " FROM SD1010 SD1, SF4010 SF4, SF2010 SF2, SF1010 SF1
	cQuery2+= " WHERE D1_FILIAL  = '"+XFILIAL("SD1")+"'
	cQuery2+= " AND D1_DTDIGIT between '"+DTOS(MV_PAR08)+"' AND '"+DTOS(MV_PAR09)+"'
	cQuery2+= " AND D1_TIPO = 'D'
	cQuery2+= " AND F4_FILIAL  = ' '
	cQuery2+= " AND F4_CODIGO  = D1_TES
	cQuery2+= " AND F2_FILIAL  = '"+XFILIAL("SF2")+"'
	cQuery2+= " AND F4_DUPLIC = 'S'
	cQuery2+= " AND F4_ESTOQUE = 'S'
	cQuery2+= " AND F2_DOC     = D1_NFORI
	cQuery2+= " AND F2_SERIE   = D1_SERIORI
	cQuery2+= " AND F2_LOJA    = D1_LOJA
	cQuery2+= " AND F1_FILIAL  = '"+XFILIAL("SF1")+"'
	cQuery2+= " AND F1_DOC     = D1_DOC
	cQuery2+= " AND F1_SERIE   = D1_SERIE
	cQuery2+= " AND F1_FORNECE = D1_FORNECE
	cQuery2+= " AND F1_LOJA    = D1_LOJA
	cQuery2+= " AND SD1.D_E_L_E_T_ = ' '
	cQuery2+= " AND SF4.D_E_L_E_T_ = ' '
	cQuery2+= " AND SF2.D_E_L_E_T_ = ' '
	cQuery2+= " AND SF1.D_E_L_E_T_ = ' '
	cQuery2+= " GROUP BY D1_COD
	cQuery2+= " ORDER BY D1_COD
	
	If Select("TRB4") > 0
		dbSelectArea("TRB4")
		dbCloseArea("TRB4")
	Endif
	
	cQuery2 := ChangeQuery(cQuery2)
	
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery2),"TRB4",.T.,.T.)
	
	dbSelectArea("TRB4")
	WHILE TRB4->(!EOF())
		dbSelectArea("TRB5")
		TRB5->(dbSetOrder(1))
		If TRB5->(dbSeek(TRB4->D1_COD))
			RecLock("TRB5",.F.)
		Else
			RecLock("TRB5",.T.)
			REPLACE TB_PROD WITH TRB4->D1_COD
			REPLACE TB_DESCR WITH POSICIONE("SB1",1,XFILIAL("SB1")+TRB4->D1_COD,"B1_XDESC")
		EndIF
		REPLACE TB_VLRTAF 	WITH TB_VLRTAF
		REPLACE TB_QTDITAF	WITH TB_QTDITAF
		REPLACE TB_QTDPCAF 	WITH TB_QTDPCAF
		REPLACE TB_VLRBRF 	WITH TB_VLRBRF - TRB4->VLRBRUT1
		REPLACE TB_VLRSIF   WITH TB_VLRSIF - TRB4->VLRSICMIPI1
		REPLACE TB_VLRMERC  WITH TB_VLRMERC - TRB4->VLRMERC1
		REPLACE TB_QTDITFT  WITH TB_QTDITFT - TRB4->QTDIFT1
		REPLACE TB_QTDPCFT  WITH TB_QTDPCFT - TRB4->QTDPCFT1
		TRB5->(MSUNLOCK())
		
		nVlrTB1 += TRB4->VLRBRUT1
		nVlrSi1 += TRB4->VLRSICMIPI1
		nVlrMe1  += TRB4->VLRMERC1
		nQTDPC1  += TRB4->QTDPCFT1
		nQTDIT1  += TRB4->QTDIFT1		
		
		TRB4->(DBSKIP())
		
	ENDDO
ENDIF

dbSelectArea("TRB5")
dbSetOrder(1)
DBGOTOP()

WHILE TRB5->(!EOF())
	
	XLS->(RECLOCK("XLS",.T.))
	XLS->CODPROD  := TB_PROD
	XLS->DESCPROD := TB_DESCR
	XLS->VLRTOT	  := TB_VLRTAF
	XLS->QTDITENS := TB_QTDITAF
	XLS->QTDPECAS := TB_QTDPCAF
	XLS->PRCMD	  := TB_VLRTAF/TB_QTDPCAF
	XLS->VLRBRUT  := TB_VLRBRF
	XLS->VLRSICM  := TB_VLRSIF
	XLS->VLRMERC  := TB_VLRMERC
	XLS->QTDITEFT := TB_QTDITFT
	XLS->QTDPECFT := TB_QTDPCFT
	XLS->PRCMDFT  := TB_VLRMERC/TB_QTDPCFT
	XLS->(MSUNLOCK())
	
	NLIN ++
	NQTDLIB 	:= 0
	NQTDITEM	:= 0
	NQTDPROD	:= 0
	NVLRTOT		:= 0
	VLRBRUT 	:= 0
	VLRSICM 	:= 0
	VLRMERC 	:= 0
	NSEQ 		:= 0
	QTDITEMFT 	:= 0
	
	TRB5->(DBSKIP())
ENDDO	

XLS->(RECLOCK("XLS",.T.))
XLS->CODPROD  := " "
XLS->DESCPROD := "TOTAL"
XLS->VLRTOT	  := nVlrTAF
XLS->QTDITENS := nQTDITAF
XLS->QTDPECAS := nQTDPCAF
XLS->PRCMD	  := nVlrTAF/nQTDPCAF
XLS->VLRBRUT  := nVlrTBrut-nVlrTB1
XLS->VLRSICM  := nVlrSicms-nVlrSi1
XLS->VLRMERC  := nVlrMerc-nVlrMe1
XLS->QTDITEFT := nQTDITFT-nQTDIT1 
XLS->QTDPECFT := nQTDPCFT-nQTDPC1
XLS->PRCMDFT  := (nVlrMerc-nVlrMe1)/(nQTDPCFT-nQTDPC1)
XLS->(MSUNLOCK())

IF MV_PAR03 == 1
	XLS->(DBGOTOP())
	CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
	Alert("Arquivo salvo em C:\RELATORIOS\" + CNOMEDBF + ".DBF" )
	
	If ! ApOleClient( 'MsExcel' )
		MsgStop( 'MsExcel nao instalado' )
		Return
	EndIf
	
	DbSelectArea("TRB2")
	DbCloseArea()
	
	DbSelectArea("TRB3")
	DbCloseArea()
	
	IF MV_PAR10 = 1
		DbSelectArea("TRB4")
		DbCloseArea()
	ENDIF
	
	DbSelectArea("TRB5")
	DbCloseArea()
	
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
ENDIF

FErase("\SYSTEM\" + CNOMEDBF +".DBF")


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
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Export Excel?","","","mv_ch3","C",1,0,1,"C","","mv_par03","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Data Lib. De ?","","","mv_ch4","D", 8,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Data Lib. Ate ?","","","mv_ch5","D", 8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Produto De?","","","mv_ch6","C", 15,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"07","Produto Ate?","","","mv_ch7","C", 15,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"08","Data Fat. De?","","","mv_ch8","D", 8,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Data Fat. Ate?","","","mv_ch9","D", 8,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"10","Considera Devol.?","","","mv_chA","C",1,0,1,"C","","mv_par10","SIM","","","","","NÃO","","","","","","","","","","","","","","","","","","",""})

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
