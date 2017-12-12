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
User Function RES_CLI
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Pendências Logistica"
Local cPict          := ""
Local titulo         := "RELATORIO TRACKING RESUMO POR CLIENTE"
Local nLin           := 80
                      //0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
                      //01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1         :="Cod. Cliente  Loja     Nome Cliente                                        Vlr. Total        Qtd. Peças             Qtd. Itens"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RES_CLI" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RES_CLI"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RES_CLI" // Coloque aqui o nome do arquivo usado para impressao em disco

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
	

IF MV_PAR03 == 1
	aDbStru := {}
	AADD(aDbStru,{"CODCLI","C",08,0})
	AADD(aDbStru,{"LOJA","C",02,0} )
	AADD(aDbStru,{"NOMECLI","C",60,0} )
	AADD(aDbStru,{"VLRTOT","N",14,2} )
	AADD(aDbStru,{"QTDITENS","N",12,0} )
	AADD(aDbStru,{"QTDPECAS","N",12,0} )
	
	CNOMEDBF := "RESCLI-"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))
	
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

cQuery:= " SELECT C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1  "
cQuery+= " FROM SC5010, SA4010, SC6010, SC9010 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"' "
cQuery+= " AND C9_DATALIB >= '"+DTOS(MV_PAR04)+"' "
cQuery+= " AND C9_DATALIB <= '"+DTOS(MV_PAR05)+"' "
cQuery+= " AND C5_FILIAL = '"+XFILIAL()+"' "
cQuery+= " AND C5_FILIAL = C9_FILIAL "
cQuery+= " AND C9_FILIAL = '03' "
cQuery+= " AND C5_CLIENTE >= '"+MV_PAR06+"' "
cQuery+= " AND C5_CLIENTE <= '"+MV_PAR08+"' "
cQuery+= " AND C5_LOJACLI >= '"+MV_PAR07+"' "
cQuery+= " AND C5_LOJACLI <= '"+MV_PAR09+"' "
cQuery+= " AND C6_NUM = C5_NUM AND C5_NUM = C9_PEDIDO "
cQuery+= " AND C6_PRODUTO = C9_PRODUTO AND C6_FILIAL = C9_FILIAL AND C6_ITEM = C9_ITEM "
cQuery+= " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND (C9_BLEST = ' ' OR C9_BLEST = '10') "
cQuery+= " AND SC5010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SA4010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC6010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC9010.D_E_L_E_T_ <> '*' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " AND C9_NFISCAL = ' ' "
cQuery+= " AND C6_TPOPER = '01' "
cQuery+= " GROUP BY C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM,C5_EMISSAO, C5_CODBL, C9_DATALIB, C5_LIBEROK, C5_VEND1 "
cQuery+= " ORDER BY C5_CLIENTE, C5_LOJACLI, C5_NUM, C6_SEQCAR, C6_NOTA "

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
CVEND:= " "
WHILE TRB1->(!EOF())
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	
	CBLOQEST	:= " "
	CBLOQCRED	:= " "
	
	CCLI		:= TRB1->C5_CLIENTE
	CLOJA		:= TRB1->C5_LOJACLI
	
	DBSELECTAREA("SC6")
	SC6->(DBORDERNICKNAME("SEQCAR"))
	SC6->(DBSEEK(XFILIAL("SC6")+TRB1->C5_NUM+ALLTRIM(STR(TRB1->C6_SEQCAR))))
	WHILE SC6->(!EOF()).AND.TRB1->C5_NUM == SC6->C6_NUM
		NQTDLIB  := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_QTDLIB")
		CBLOQEST := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_BLEST")
		CBLOQCRED:= POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")
		NVLRTOT:= NVLRTOT+(IIF(EMPTY(CBLOQEST).AND.EMPTY(CBLOQCRED).AND.NQTDLIB > 0,NQTDLIB, 0 )* SC6->C6_PRCVEN) //NVLRTOT+(IIF(SC6->C6_QTDENT = 0.OR.NQTDLIB = 0, SC6->C6_QTDVEN, NQTDLIB)* SC6->C6_PRCVEN)
		IF EMPTY(CBLOQEST).AND.EMPTY(CBLOQCRED).AND.NQTDLIB > 0 
			NQTDITEM	+= 1
		ENDIF
		NQTDPROD	+= IIF(EMPTY(CBLOQEST).AND.EMPTY(CBLOQCRED).AND.NQTDLIB > 0,NQTDLIB, 0 )//IIF(SC6->C6_QTDENT = 0.OR.NQTDLIB = 0, SC6->C6_QTDVEN, NQTDLIB)
		SC6->(DBSKIP())
	ENDDO
	SC6->(DBCLOSEAREA())
	
	TRB1->(DBSKIP())
	IF (NVLRTOT > 0 .AND.CCLI <> TRB1->C5_CLIENTE .AND. CLOJA <> TRB1->C5_LOJACLI) .OR. TRB1->(EOF())
		XLS->(RECLOCK("XLS",.T.))
		XLS->CODCLI  := CCLI
		XLS->LOJA    := CLOJA
		XLS->NOMECLI := POSICIONE("SA1",1,XFILIAL("SA1")+CCLI+CLOJA,"A1_NREDUZ")
		XLS->VLRTOT	 := NVLRTOT
		XLS->QTDITENS:= NQTDITEM
		XLS->QTDPECAS:= NQTDPROD
		
		@ nLin, 00 		    PSAY  CCLI
		@ nLin, 14 		    PSAY  CLOJA
		@ nLin, 23 		    PSAY  POSICIONE("SA1",1,XFILIAL("SA1")+CCLI+CLOJA,"A1_NREDUZ")
		@ nLin, 75 		    PSAY  TRANSFORM(NVLRTOT, "@E 9,999,999.99")
		@ nLin, 93		    PSAY  NQTDITEM
		@ nLin, 116		    PSAY  NQTDPROD
		NLIN ++
		NQTDLIB 	:= 0
		NQTDITEM	:= 0
		NQTDPROD	:= 0
		NVLRTOT		:= 0
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
AADD(aRegs,{cPerg,"06","Cliente De?","","","mv_ch6","C", 06,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
AADD(aRegs,{cPerg,"07","Loja De?","","","mv_ch7","C", 02,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Cliente Ate?","","","mv_ch8","C", 06,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
AADD(aRegs,{cPerg,"09","Loja Ate?","","","mv_ch9","C", 02,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""})

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
