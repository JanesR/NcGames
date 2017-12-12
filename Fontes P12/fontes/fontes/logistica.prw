#INCLUDE "rwmake.ch"

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

User Function LOG001


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Pend๊ncias Logistica"
Local cPict          := ""
Local titulo         := "Pend๊ncias Logistica"
Local nLin           := 80
Local Cabec1         := "NumNf  Ser Cliente                     Endereco                    UF Frete  Val Tot Dev? Val.Fret+Seg Hora  Emissao  Etiqueta Saida    Entrega  BaixaLog DtAgend  Hora Historico Logistica       Transp. Nat. Oper.    Port"
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "LOG001" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "LOG001"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "LOG001" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := "SF2"

dbSelectArea("SF2")
dbSetOrder(1)


pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

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

dbSelectArea(cString)
dbSetOrder(3)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())

DbSeek(xFilial("SF2") + SPACE(1) + DTOS(mv_par01),.T.) // Posiciona no 1o.reg. satisfatorio ณ

xxd          := CTOD("01/01/00")
NTTDD        := 0
NTTGG        := 0
SomaFrete    := 00
SomaFretetot := 00


While !EOF() .And. xFilial("SF2") == SF2->F2_FILIAL .And. SF2->F2_EMISSAO <= mv_par02

	IF 	xxd == CTOD("01/01/00")
		xxd := SF2->F2_EMISSAO
	ENDIF
	
	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica o cancelamento pelo usuario...                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
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
	
	// VERIFICA DEVOLUCAO
	NDEV  := U_E1NCC(SF2->F2_FILIAL + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA,SF2->F2_VALBRUT)
	LPULA := .F.
	
	DO CASE
		CASE MV_PAR03 == 1
			LPULA := .F.
		CASE MV_PAR03 == 2 .AND. !EMPTY(GETADVFVAL("SZ1","Z1_DTEMISS",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))  )
			LPULA := .T.
		CASE MV_PAR03 == 3 .AND. !EMPTY(GETADVFVAL("SZ1","Z1_DTSAIDA",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))  )
			LPULA := .T.
		CASE MV_PAR03 == 4 .AND. !EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))  )
			LPULA := .T.
	ENDCASE

	IF MV_PAR04 == 2 .AND. NDEV > 0
		LPULA := .T.
	ENDIF

	IF MV_PAR05 == 1 .AND. (U_CLIAGE3().AND. EMPTY(SF2->F2_DATAAG).AND.EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))),.T.,IIF(!U_CLIAGE3(),.T.,.F.))
		LPULA := .T.
	ENDIF

	IF MV_PAR05 == 2 .AND. U_CLIAGE3() //(!U_CLIAGE3().AND. EMPTY(SF2->F2_DATAAG).AND.EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))),.T.,IIF(!U_CLIAGE3(),.T.,.F.))
		LPULA := .T.
	ENDIF

	IF MV_PAR06 == 2
		IF (GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))) < MV_PAR07 .OR.GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) > MV_PAR08
			LPULA := .T.
		ENDIF
	ENDIF

	CPORTADOR := GETADVFVAL("SE1","E1_PORTADO",XFILIAL("SE1")+SF2->F2_SERIE+SF2->F2_DOC,1,"")

	IF MV_PAR09 == 2 .AND. EMPTY(CPORTADOR)
			LPULA := .T.
	ENDIF

	IF MV_PAR09 == 3 .AND. !EMPTY(CPORTADOR)
		LPULA := .T.
	ENDIF
	
	IF !EMPTY(MV_PAR10+MV_PAR11+MV_PAR12) .AND. GETADVFVAL("SD2","D2_TES",XFILIAL("SD2")+SF2->F2_DOC+SF2->F2_SERIE,3,"")$(MV_PAR10+"/"+MV_PAR11+"/"+MV_PAR12)
		LPULA := .T.
	ENDIF
	
	IF !EMPTY(MV_PAR13+MV_PAR14+MV_PAR15) .AND. !GETADVFVAL("SD2","D2_TES",XFILIAL("SD2")+SF2->F2_DOC+SF2->F2_SERIE,3,"")$(MV_PAR13+"/"+MV_PAR14+"/"+MV_PAR15)
		LPULA := .T.
	ENDIF
	
	IF 	GETADVFVAL("SZ1","Z1_DTEMISS",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) < MV_PAR16 .OR. GETADVFVAL("SZ1","Z1_DTEMISS",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) > MV_PAR17
		LPULA := .T.
	ENDIF
	
	IF 	GETADVFVAL("SZ1","Z1_DTSAIDA",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) < MV_PAR18 .OR. GETADVFVAL("SZ1","Z1_DTSAIDA",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) > MV_PAR19
		LPULA := .T.
	ENDIF
	
	IF 	GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) < MV_PAR20 .OR. GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD('')) > MV_PAR21
		LPULA := .T.
	ENDIF
	
	IF 	GETADVFVAL("SD2","D2_ORIGLAN",xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA,3,"") == "LF"
		LPULA := .T.
	ENDIF

	IF 	!EMPTY(SF2->F2_DATAAG) .AND. (SF2->F2_DATAAG < MV_PAR22 .OR. SF2->F2_DATAAG > MV_PAR23)
		LPULA := .T.
	ENDIF
	IF MV_PAR24 = 1 .AND. SF2->F2_TRANSP <> "000001"
		LPULA := .T.
	ENDIF
	IF MV_PAR24 = 2 .AND. SF2->F2_TRANSP <> "000007"
		LPULA := .T.
	ENDIF
	IF MV_PAR24 = 3 .AND.!SF2->F2_TRANSP $("000002/000012/000013")
		LPULA := .T.
	ENDIF
	IF MV_PAR24 = 4 .AND.!SF2->F2_TRANSP $("000002/000012/000013/000001/000007")
		LPULA := .T.
	ENDIF 
	
	IF ! LPULA
		
		IF xxd <> SF2->F2_EMISSAO
			nLin := nLin + 1
		
			@nLin, 000 PSAY "Total Dia"
			@nLin, 072 PSAY NTTDD     PICTURE "@E 999,999,999.99"
			@nLin, 089 Psay SomaFrete PICTURE "@E 99,999.99"
		
			NTTDD     := 0
			SomaFrete := 0
			xxd       := SF2->F2_EMISSAO
			nLin      := nLin + 2
		EndIF
		
		//GetAdvFVal(cAlias,uCpo,uChave,nOrder,uDef)

		dbSelectArea("SD2")
    	dbSetOrder(3)  //D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
    	dbSeek(xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA,.T.)

    	cPedVenda := SD2->D2_PEDIDO

    	dbSelectArea("SC5")
    	dbSetOrder(3) //C5_FILIAL+C5_CLIENTE+C5_LOJACLI+C5_NUM                                                                                                                          
    	dbSeek(xFilial("SC5") + SF2->F2_CLIENTE + SF2->F2_LOJA + cPedVenda,.T.)

    	cFrete := SC5->C5_TPFRETE

//		cFrete := GETADVFVAL("SC5","C5_TPFRETE",xFilial() + SF2->F2_DOC + SF2->F2_SERIE,1,)
		
		@ nLin, 00 		    PSAY SF2->F2_DOC
		@ nLin, PCOL()+1 	PSAY SF2->F2_SERIE
		@ nLin, PCOL()+1 	PSAY LEFT(GETADVFVAL("SA1","A1_NOME",XFILIAL('SA1')+SF2->F2_CLIENTE+SF2->F2_LOJA,1,""),27)
		@ nLin, PCOL()+1 	PSAY LEFT(GETADVFVAL("SA1","A1_END",XFILIAL('SA1')+SF2->F2_CLIENTE+SF2->F2_LOJA,1,""),27)
		@ nLin, PCOL()+1 	PSAY SF2->F2_EST
   			//ALERT("Tipo do Frete e: " + cFrete)

		IF cFrete == "C"
			@nLin, PCOL()+1 	PSAY "1"
		ElseIF cFrete == "F"
			@nLin, PCOL()+1 	PSAY "2"
		Else
			@nLin, PCOL()+1 	PSAY "B"
		EndIF
		
				
		@ nLin, PCOL()+1 	PSAY SF2->F2_VALBRUT PICTURE "@E 999,999,999.99"
		@ nLin, PCOL()+1 	PSAY IIF( NDEV > 0,IIF( NDEV == 1,"Parc","Totl") ,"    ")
		@ nLin, PCOL()+1 	PSAY SF2->F2_FRETE+SF2->F2_SEGURO PICTURE "@E 999,999.99"
		@ nLin, PCOL()+1 	PSAY SF2->F2_HORA
		@ nLin, PCOL()+1 	PSAY SF2->F2_EMISSAO
		@ nLin, PCOL()+1 	PSAY GETADVFVAL("SZ1","Z1_DTEMISS",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))
		@ nLin, PCOL()+1 	PSAY GETADVFVAL("SZ1","Z1_DTSAIDA",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))
		@ nLin, PCOL()+1 	PSAY GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))
		@ nLin, PCOL()+1 	PSAY GETADVFVAL("SZ1","Z1_DTBAIXA",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))
		@ nLin, PCOL()+1 	PSAY SF2->F2_DATAAG
		@ nLin, PCOL()+1 	PSAY SUBSTR(SF2->F2_HORAAG,1,5)

		IF  MV_PAR25 == 1 
	
   	  		@ nLin, PCOL()+1 	PSAY LEFT(GETADVFVAL("SE1","E1_HISTWF",XFILIAL("SE1")+SF2->F2_SERIE+SF2->F2_DOC,1,""),25) // alteracao solicitada por Rubens dia 05_05
	
		ENDiF

		//	@ nLin, PCOL()+9 	PSAY ALLTRIM(LEFT(GETADVFVAL("SE1","E1_HISTWF",XFILIAL("SE1")+SF2->F2_SERIE+SF2->F2_DOC,1,""),25))
		@ nLin, PCOL()+1  	PSAY LEFT(GETADVFVAL("SA4","A4_NREDUZ",XFILIAL("SA4")+SF2->F2_TRANSP,1,""),6)
		@ nLin, PCOL()+3	PSAY LEFT(GETADVFVAL("SF4","F4_TEXTO",XFILIAL("SF4")+GETADVFVAL("SD2","D2_TES",XFILIAL("SD2")+SF2->F2_DOC+SF2->F2_SERIE,3,""),1,""),12)
		@ nLin, PCOL()+1   	PSAY ALLTRIM(CPORTADOR)
		
		//			@nLin,PCOL()+1 	PSAY IIF(U_CLIAGE3().AND. EMPTY(SF2->F2_DATAAG).AND.EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))),IIF(NDEV==0,"AGENDAR","       "),IIF(!U_CLIAGE3().AND.!EMPTY(GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+SF2->F2_DOC+SF2->F2_SERIE,1,CTOD(''))),"       ","       "))
		//			@nLin,PCOL()+1 	PSAY IIF(U_CLIAGE3().AND. EMPTY(SF2->F2_HORAAG),"     ",IIF(!U_CLIAGE3(),"     ",SF2->F2_HORAAG))
		nLin := nLin + 1 // Avanca a linha de impressao
		NTTDD += SF2->F2_VALBRUT
		NTTGG += SF2->F2_VALBRUT
		SomaFrete += SF2->F2_FRETE+SF2->F2_SEGURO
		Somafretetot += SF2->F2_FRETE+SF2->F2_SEGURO
		
	ENDIF
	
	//dbSelectArea("SF2")
	//dbSetOrder(1)
	SF2->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	

EndDo
nLin := nLin + 1

@nLin, 000 PSAY "Total Dia"
@nLin, 072 PSAY NTTDD     PICTURE "@E 999,999,999.99"
@nLin, 089 Psay SomaFrete PICTURE "@E 99,999.99"

SomaFrete := 0
NTTDD     := 0
xxd       := SF2->F2_EMISSAO
nLin      := nLin + 2

@nLin,000 PSAY "Total Geral"
@nLin,020 PSAY NTTGG PICTURE "@E 999,999,999.99"
@nLin,045 Psay "Total Frete"
@nLin,058 Psay SomaFretetot PICTURE "@E 99,999.99"


nLin := nLin + 1

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
