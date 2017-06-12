#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO4     บ Autor ณ AP6 IDE            บ Data ณ  04/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function TRCK_PICK2
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Pend๊ncias Logistica"
Local cPict          := ""
Local titulo         := "RELATORIO TRACKING"
Local nLin           := 80
//0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
Local Cabec1         :="NumPed   Emissao  Cliente         UF       Vlr Ped  Dt Lib   Hr Lib C Dt Cred  Hr Cred Dt Pick  HrPick  DtEtiqV  HrEtiqV DtEmis NF HrNF   Dt Etiq NF Hr Etiq NF Dt Saida Entrega   NumNF     Serie Nat Oper      Vlr Tot NF  Transp"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "TRACK_PICK" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "TRACK_PIC2"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "TRACK_PICK" // Coloque aqui o nome do arquivo usado para impressao em disco

VALIDPERG()

pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint("SC5",NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,"SC5")

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  04/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local CBLQCRED:= " "
LOCAL NVLRTOT := 0



IF MV_PAR03 == 1
	aDbStru := {}
	
	AADD(aDbStru,{"NUMPED","C",08,0})
	AADD(aDbStru,{"PARTE","C",2,0})
	AADD(aDbStru,{"TPOPER","C",20,0})
	AADD(aDbStru,{"EMISPED","C",08,0})
	AADD(aDbStru,{"NOMECLI","C",30,0} )
	AADD(aDbStru,{"UF","C",02,0} )
	AADD(aDbStru,{"CAMP","C",10,0})
	AADD(aDbStru,{"DCAMP","C",60,0})
	AADD(aDbStru,{"VLRPED","N",14,2} )
	AADD(aDbStru,{"DTLIBPED","C",08,0} )
	AADD(aDbStru,{"HORALIB","C",05,0})
	AADD(aDbStru,{"CRED","C",01,0})
	AADD(aDbStru,{"DTLIBCRED","C",08,0})
	AADD(aDbStru,{"HRLIBCRED","C",05,0})
	
	AADD(aDbStru,{"DTDISPSEP","C",10,0})
	AADD(aDbStru,{"HRDISPSEP","C",05,0})
	AADD(aDbStru,{"DTINISEP","C",10,0})
	AADD(aDbStru,{"HRINISEP","C",05,0})
	AADD(aDbStru,{"DTINICONF","C",10,0})
	AADD(aDbStru,{"HRINICONF","C",05,0})
	AADD(aDbStru,{"DTDISPNF","C",10,0})
	AADD(aDbStru,{"HRDISPNF","C",05,0})
	
	AADD(aDbStru,{"DTPICK","C",08,0})
	AADD(aDbStru,{"HORAPICK","C",05,0})
	AADD(aDbStru,{"DTETIVOL","C",08,0})
	AADD(aDbStru,{"HRETIVOL","C",05,0})
	AADD(aDbStru,{"DTEMISNF","C",08,0})
	AADD(aDbStru,{"HRNF","C",05,0})
	//
	//	AADD(aDbStru,{"DTCONFNF","C",08,0})
	//	AADD(aDbStru,{"HRCONFNF","C",05,0})
	//
	AADD(aDbStru,{"DTETINF","C",08,0})
	AADD(aDbStru,{"HRETINF","C",05,0})
	AADD(aDbStru,{"DTSAIDA","C",08,0})
	AADD(aDbStru,{"DTENTREG","C",08,0})
	AADD(aDbStru,{"NUMNF","C",09,0})
	AADD(aDbStru,{"SERIENF","C",03,0})
	AADD(aDbStru,{"VOLNF","N",10,0})
	AADD(aDbStru,{"ESPEC","C",03,0})
	AADD(aDbStru,{"PLIQUI","N",10,4})
	AADD(aDbStru,{"PBRUTO","N",10,4})
	AADD(aDbStru,{"NATOPER","C",20,0})
	AADD(aDbStru,{"VLRTOTNF","N",14,2})
	AADD(aDbStru,{"TRANSP","C",15,0})
	AADD(aDbStru,{"LIBERPED","C",01,0})
	AADD(aDbStru,{"VEND","C",06,0})
	AADD(aDbStru,{"CLIENT","C",06,0})
	AADD(aDbStru,{"LOJA","C",02,0})
	AADD(aDbStru,{"QTDITENS","N",12,0} )
	AADD(aDbStru,{"QTDPROD","N",12,0} )   
	AADD(aDbStru,{"PEDCLI","C",15,0})
	
	CNOMEDBF := "TRACKV2-"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))
	
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
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C5_LIBEROK, C5_VEND1, C5_CODCAMP ,C5_PEDCLI  "
cQuery+= " FROM SC5010, SA4010, SC6010 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"' "
cQuery+= " AND C5_FILIAL = '"+XFILIAL()+"' "
cQuery+= " AND C6_NUM = C5_NUM "
cQuery+= " AND ( C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND SC5010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SA4010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC6010.D_E_L_E_T_ <> '*' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " GROUP BY C6_NOTA, C6_SERIE, C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C5_LIBEROK, C5_VEND1 , C5_CODCAMP,C5_PEDCLI "
cQuery+= " ORDER BY C5_NUM, C6_SEQCAR, C6_NOTA "

If Select("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea("TRB1")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())


dbSelectArea("TRB1")
TRB1->(dbGoTop())

NSEQ:= TRB1->C6_SEQCAR

WHILE TRB1->(!EOF())
	DBSELECTAREA("SC9")
	DBSETORDER(1)
	
	IF !(DBSEEK(XFILIAL("SC9")+TRB1->C5_NUM))
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Impressao do cabecalho do relatorio. . .                            ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
		Endif
		
		CNUMPED		:= TRB1->C5_NUM+"/"+ALLTRIM(STR(TRB1->C6_SEQCAR))
		DDTPED		:= SUBSTR(TRB1->C5_EMISSAO,7,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,5,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,3,2) //STOD(TRB1->C5_EMISSAO)
		CCLIENTE	:= SUBSTR(TRB1->C5_NOMCLI,1,15)
		CUF			:= ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_EST"))
		CCAMP		:= TRB1->C5_CODCAMP
		CDCAMP		:= ALLTRIM(POSICIONE("SZA",1,XFILIAL("SZA")+TRB1->C5_CODCAMP,"ZA_DESCR"))
		NQTDITEM	:= 0
		NQTDPROD	:= 0
		DBSELECTAREA("SC6")
		SC6->(DBORDERNICKNAME("SEQCAR"))
		SC6->(DBSEEK(XFILIAL("SC6")+TRB1->C5_NUM+ALLTRIM(STR(TRB1->C6_SEQCAR))))
		WHILE SC6->(!EOF()).AND.TRB1->C5_NUM == SC6->C6_NUM //บ.AND. SC6->C6_SEQCAR == NSEQ
			NVLRTOT:= 	NVLRTOT+(IIF(SC6->C6_QTDENT = 0, SC6->C6_QTDVEN,SC6->C6_QTDENT)* SC6->C6_PRCVEN)
			NQTDITEM	+= 1
			NQTDPROD	+= IIF(SC6->C6_QTDENT = 0, SC6->C6_QTDVEN,SC6->C6_QTDENT)
			SC6->(DBSKIP())
		ENDDO
		SC6->(DBCLOSEAREA())
		
		DDTLIB		:= "  /  /  " //SUBSTR(TRB1->C9_DATALIB,7,2)+"/"+SUBSTR(TRB1->C9_DATALIB,5,2)+"/"+SUBSTR(TRB1->C9_DATALIB,3,2)//STOD(TRB1->C5_DTLIB)
		
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
		ELSE
			CBLQCRED	:= " "
		ENDIF
		
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
		
		IF MV_PAR03 == 1
			
			IF EMPTY(CNUMNF)
				CNUM := TRB1->C5_NUM
			ELSE
				CNUM := CNUMNF
			ENDIF
			
			_cQuery01 := " SELECT * FROM ORAINT.X_077_VW_DOCUMENTOSAIDAPAINEL DOCPAINEL WHERE DOCPAINEL.DOCUMENTOSAIDA = '"+CNUM+"' "
			_cQuery01 := ChangeQuery(_cQuery01)
			If Select("TRB9") > 0
				dbSelectArea("TRB9")
				dbCloseArea()
			EndIf
			TCQUERY _cQuery01 New Alias "TRB9"
			
			
			XLS->(RECLOCK("XLS",.T.))
			
			XLS->NUMPED			:= CNUMPED
			XLS->PARTE			:= ALLTRIM(STR(TRB1->C6_SEQCAR))
			XLS->TPOPER			:= POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER")+" - "+POSICIONE("SX5",1,XFILIAL("SX5")+"DJ"+POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER"),"X5_DESCRI")
			XLS->EMISPED		:= DDTPED
			XLS->NOMECLI		:= CCLIENTE
			XLS->UF				:= CUF
			XLS->CAMP			:= CCAMP
	    	XLS->DCAMP			:= CDCAMP
			XLS->QTDITENS		:= NQTDITEM
			XLS->QTDPROD		:= NQTDPROD
			
			XLS->VLRPED			:= NVLRTOT
			XLS->DTLIBPED		:= DDTLIB
			XLS->HORALIB		:= CHRLIB
			XLS->CRED			:= CBLQCRED
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
			XLS->LIBERPED		:= TRB1->C5_LIBEROK
			XLS->VEND			:= TRB1->C5_VEND1
			XLS->CLIENT			:= TRB1->C5_CLIENTE
			XLS->LOJA			:= TRB1->C5_LOJACLI
			//
			//      Alterado em Out/2011
			//	    XLS->DTDISPSEP      := TRB9->DATADISPSEP
			//	    XLS->HRDISPSEP      := TRB9->DATADISPONIVELSEP
			//	    XLS->DTINISEP       := TRB9->DATASEP
			//	    XLS->HRINISEP       := TRB9->DATASEPARACAO
			XLS->DTDISPSEP      := TRB9->DATADISPSEP
			XLS->HRDISPSEP      := TRB9->DATASEPARACAO
			XLS->DTINISEP       := TRB9->DATASEP
			XLS->HRINISEP       := TRB9->DATADISPONIVELSEP
			
			XLS->DTINICONF      := TRB9->DATACONF
			XLS->HRINICONF      := TRB9->DATACONFERENCIA
			//
			//      Alterado em Set/2011
			//	    XLS->DTDISPNF       := TRB9->DATADISPCONF
			//	    XLS->HRDISPNF       := TRB9->DATADISPONIVELCONF
			XLS->DTDISPNF       := TRB9->DATAFIM
			XLS->HRDISPNF       := TRB9->DATACONFIRMACAO
			XLS->PEDCLI			:= TRB1->C5_PEDCLI
			
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
	ELSE
		TRB1->(DBSKIP())
		LOOP
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

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณVALIDPERG ณ Autor ณ RAIMUNDO PEREIRA      ณ Data ณ 01/08/02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ Verifica as perguntas incluกndo-as caso no existam        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especifico para Clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
AADD(aRegs,{cPerg,"03","Export Excel?","","","mv_ch3","C",1,0,1,"C","","mv_par03","SIM","","","","","NรO","","","","","","","","","","","","","","","","","","",""})
//AADD(aRegs,{cPerg,"04","Liberado ?","","","mv_ch4","C",1,0,1,"C","","mv_par04","SIM","","","","","NรO","","","","","TODOS","","","","","","","","","","","","","",""})
//AADD(aRegs,{cPerg,"04","Data Lib. De ?","","","mv_ch4","D", 8,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
//AADD(aRegs,{cPerg,"05","Data Lib. Ate ?","","","mv_ch5","D", 8,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})

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
