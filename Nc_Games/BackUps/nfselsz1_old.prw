#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NFSELSZ1 บ Autor ณ Rodrigo Okamoto    บ Data ณ  15/01/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ ROTINA PARA SELEวรO DE NOTAS NO SZ1.                       บฑฑ
ฑฑบ          ณ IMPRESSรO DE ROMANEIOS (ImprRom)                           บฑฑ
ฑฑบ          ณ LIBERAวรO PARA ENTREGA (NFATM02A)                          บฑฑ
ฑฑบ          ณ BAIXA DE CANHOTOS      (NFATM02A)                          บฑฑ
ฑฑบ          ณ CANCELAMENTO DE ETIQUETAS (NFATM03A)                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC GAMES / LOGISTICA                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function NFSELSZ1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private cArqInd 	:= CriaTrab(,.F.)		//Nome do arq. temporario
Private nIndex	:= 0					//Indice do arq. temporario a ser utilizado
Private cString   := "SZ1"
Private aArea    := GetArea()
Private cMarca    := getmark()
Private cCadastro := "Controle de Despacho"
Private aRotina 

If !Pergunte("FATM02A",.T.)
	Return
EndIf

IF mv_par01 == 1
	aRotina := {{ OemToAnsi("Pesquisar")		,"AxPesqui"  	,0,1},;
	{ OemToAnsi("Liberar")			,"U_NFATM02A(cMarca)"	,0,4,20}}
	cCadastro := "Libera็ใo de Mecadoria"
	cQuery:="Z1_STATUS==' '"
ElseIf mv_par01 == 2
	aRotina := {{ OemToAnsi("Pesquisar")		,"AxPesqui"  	,0,1},;
	{ OemToAnsi("Baixa Canhoto")	,"U_NFATM02A(cMarca)"	,0,4,20}}
	cCadastro := 'Baixa Canhoto'
	cQuery:="Z1_STATUS=='A' .AND. Z1_DTSAIDA <= DDATABASE "
ElseIf mv_par01 == 3
	aRotina := {{ OemToAnsi("Pesquisar")		,"AxPesqui"  	,0,1},;
	{ OemToAnsi("Canc.Conf.Romaneio")	,"U_NFATM03A(cMarca)"	,0,4,20}}
	cCadastro := 'Cancela Conf. de Romaneio'
	cQuery:=""
ElseIf mv_par01 == 4
	aRotina := {{ OemToAnsi("Pesquisar")		,"AxPesqui"  	,0,1},;
	{ OemToAnsi("Imprime Romaneio")	,"U_ImprRom(cMarca)"	,0,4,20}}
	cCadastro := 'Impressใo do Romaneio'
	cQuery:="Z1_STATUS=='A'"
//    alert("Impressใo de romaneio somente feita pelo WMAS!")
EndIF

//SELECIONA OS REGISTROS E ABRE A MARK BROWSE
dbSelectArea("SZ1")
IndRegua("SZ1",cArqInd,IndexKey(),,cQuery)
nIndex := RetIndex("SZ1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
If ( !Eof() .AND. !Bof() )
	MarkBrow("SZ1","Z1_MARK",,,,cMarca)
Else
	Help(" ",1,"REGNOIS")
EndIf
dbSelectArea("SZ1")
RetIndex("SZ1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())

//DESMARCA OS REGISTROS MARCADOS
cQry:="Z1_MARK = cMarca"
dbSelectArea('SZ1')
IndRegua("SZ1",cArqInd,IndexKey(),,cQry)
nIndex := RetIndex("SZ1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
While !Eof()
	RecLock('SZ1',.F.)
	REPLACE SZ1->Z1_MARK WITH SPACE(2)
	MsUnLock()
	dbSkip()
End
//dbGoto( nRecno )
dbSelectArea("SZ1")
RetIndex("SZ1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())

Return


//IMPRESSรO DO ROMANEIO
User Function ImprRom(cMarca)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ImprRom  บ Autor ณ Rodrigo Okamoto    บ Data ณ  15/01/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ IMPRESSรO DE ROMANEIOS.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC GAMES / LOGISTICA                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatorio de romaneio de despacho de pacotes(em poder dos motoristas)"
Local cPict          := ""
Local titulo       := "Romaneio de Entrega"
Local nLin         := 81
Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "ImprRom" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "ImprRom" // Coloque aqui o nome do arquivo usado para impressao em disco
Private _cUnq	   :=""
Private _cUnq1	   :=""
Private _cDoc	   :=""
Private _cItem	   :=""
Private cMark	   := cMarca


Private cString := "SZ1"
Private cPerg   := " "

Pergunte(cPerg,.F.)

dbSelectArea("SZ1")
//	dbSetOrder(1)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,"",.F.,Tamanho,,.T.)

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
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  09/11/04   บฑฑ
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

Local	cEndSA1
Local	cCepSA1
Local	cBairSA1
Local	cMumSA1
Local	cEstSA1
Local	cNumPed
Local _nTotGeral :=0
Local _nTotGICM  :=0
Local _nTotGIPI  :=0
Local _nTotGMerc :=0
Local _aCodPack  := {}
Local Cabec1 := ""
Local Cabec2 := ""

If Select("SQL") > 0
	dbSelectArea("SQL")
	dbCloseArea()
Endif

/*_cQry:="SELECT SZ1.Z1_DOC DOC, SZ1.Z1_SERIE SERIE, SZ1.Z1_CLIENTE CLIENTE, SZ1.Z1_LOJA LOJA,"
_cQry+=" SZ1.Z1_QTDVOL QTDVOL, SZ1.Z1_HORALB HORALB, SZ1.Z1_DTSAIDA SAIDA, SZ3.Z3_CODMOTO CODMOTO, SZ3.Z3_ITEM ITEM"
_cQry+=" FROM SZ1010 SZ1, SZ3010 SZ3 "
_cQry+=" WHERE  SZ1.Z1_DOC = SZ3.Z3_DOC AND SZ1.Z1_SERIE = SZ3.Z3_SERIE AND"
_cQry+=" SZ1.Z1_MARK <> '  ' AND"
_cQry+=" SZ1.Z1_STATUS = 'A' AND SZ1.D_E_L_E_T_ = ' ' AND SZ3.D_E_L_E_T_ = ' ' "
_cQry+=" ORDER BY SZ3.Z3_CODMOTO, SZ1.Z1_DOC, SZ1.Z1_SERIE, SZ3.Z3_ITEM "*/

_cQry:=" SELECT SZ1.Z1_FILIAL FILIAL, SZ1.Z1_DOC DOC, SZ1.Z1_SERIE SERIE, SZ1.Z1_CLIENTE CLIENTE, SZ1.Z1_LOJA LOJA,"
_cQry+=" SZ1.Z1_QTDVOL QTDVOL, SZ1.Z1_HORALB HORALB, SZ1.Z1_DTSAIDA SAIDA, SF2.F2_TRANSP TRANSP"
_cQry+=" FROM "+RetSqlName("SZ1")+" SZ1, "+RetSqlName("SF2")+" SF2"
_cQry+=" WHERE SZ1.Z1_DOC = SF2.F2_DOC AND SZ1.Z1_SERIE = SF2.F2_SERIE AND"
_cQry+=" SZ1.Z1_MARK = '"+cMark+"' AND"
_cQry+=" SZ1.Z1_STATUS = 'A' AND SZ1.D_E_L_E_T_ = ' '"
_cQry+=" ORDER BY SF2.F2_TRANSP, SZ1.Z1_CLIENTE, SZ1.Z1_LOJA, SZ1.Z1_DOC, SZ1.Z1_SERIE"
memowrit("TESTE.sql",_cQry)
_cQry := ChangeQuery(_cQry)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry),"SQL", .F., .T.)

dbGoTop()
SetRegua(RecCount())


While !Eof() .AND. _cUnq <> SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA
	_cUnq := SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA
	//_cItem:= SQL->ITEM
	
	cPed	:= getadvfval("SD2","D2_PEDIDO",xFilial("SD2")+PADR(SQL->DOC,9)+SQL->SERIE,3,"")
	lverwms := VerWMS(cPed)
	If lverwms
	// nใo imprime o romaneio caso o processo esteja no WMS
			Alert("Romaneio nใo serแ impresso para a NF: "+SQL->DOC+" pois se encontra no WMS!")
			dbSelectArea("SQL")
			dbSkip()
			loop
	EndIf
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Impressao do cabecalho do relatorio. . .                            ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	If nLin > 50 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	
	/*dbSelectArea("DA4")
	dbSetOrder(1)
	dbSeek(xFilial("DA4")+SQL->CODMOTO)*/
	
	/*	dbSelectArea("SF2")
	dbSetOrder(1)
	dbSeek(xFilial("SF2")+SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA)*/
	
	dbSelectArea("SA4")
	dbSetOrder(1)
	dbSeek(xFilial("SA4")+SQL->TRANSP)
	
	@nLin,045 PSAY "Transp. : "+Alltrim(SA4->A4_NOME)
	//@nLin,045 PSAY "Transp. : "+Alltrim(DA4->DA4_NOME)
	nLin +=1
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+SQL->CLIENTE+SQL->LOJA)
	
	cEndSA1:=Alltrim(SA1->A1_ENDENT)
	cCepSA1:=Alltrim(SA1->A1_CEPE)
	cBairSA1:=Alltrim(SA1->A1_BAIRROE)
	cMumSA1:=Alltrim(SA1->A1_MUNE)
	cEstSA1:=AllTrim(SA1->A1_ESTE)
	cNumPed:=Posicione("SD2",3,xFilial("SD2")+SQL->(DOC+SERIE+CLIENTE+LOJA),"D2_PEDIDO")
	
	If Posicione("SC5",1,xFilial("SC5")+cNumPed,"C5_XECOMER")=="C"
		U_COM05EndEnt(cNumPed,@cEndSA1,@cBairSA1,@cCepSA1,@cMumSA1,@cEstSA1)
	EndIf
	
	@nLin,002 PSAY "Cliente/Loja : "+SA1->A1_COD+"/"+SA1->A1_LOJA
	nLin +=1
	@nLin,002 PSAY Alltrim(SA1->A1_NOME)+"/"+SA1->A1_LOJA
	nLin +=2
	@nLin,002 PSAY "Endere็o: "+cEndSA1
	nLin +=1
	@ nLin, 002 PSAY "CEP: "+cCepSA1
	@ nLin, 030 PSAY cBairSA1
	@ nLin, 056 PSAY cMumSA1
	@ nLin, 075 PSAY cEstSA1
	
	
	_cCliente:=SQL->CLIENTE
	_cLoja   :=SQL->LOJA
	IF SQL->CLIENTE == _cCliente
		While SQL->CLIENTE+SQL->LOJA == _cCliente+_cLoja //.and. _cUnq1 <> SQL->FILIAL+SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA
			If  SQL->FILIAL+SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA == _cUnq1
				MSGBOX("NOTA FISCAL: "+SQL->DOC+" SERIE: "+SQL->SERIE+" CLIENTE: "+SQL->CLIENTE+" LOJA: "+SQL->LOJA+"EM DUPLICIDADE NA TABELA SZ1!!!",AVISO,INFO)
			EndIf
			_cUnq1:= SQL->FILIAL+SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA
			nLin +=2
			@nLin,002 PSAY "Nota Fiscal :"+SQL->DOC+" "+SQL->SERIE
			@nLin,035 PSAY "Qtd.Volumes  :"+Alltrim(STR(SQL->QTDVOL))
			nLin +=1
			nLin +=1
			@nLin,002 PSAY "Data de Saida:"+DTOC(StoD(SQL->SAIDA)) Picture "@ 99/99/99"
			@nLin,030 PSAY "Hr.da Saida  :"+SQL->HORALB
			dbSelectArea("SQL")
			dbSkip()
		EndDo
		
		nLin := nLin + 2 // Avanca a linha de impressao
		
		
		@nLin,002 PSAY "Data da Entrega: __/__/__ "
		@nLin,030 PSAY "Horario da Entrega: _________ "
		nLin := nLin + 3
		@ nLin,030 PSAY "Ass.Cliente:________________________________________"
		nLin +=2
	EndIF
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN
dbSelectArea("SQL")
dbCloseArea("SQL")

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


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerWMS  บAutor  ณMicrosiga           บ Data ณ  02/17/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function VerWMS(cPed)

	_cPEDWMAS := " SELECT max(DOC.SEQUENCIAINTEGRACAO) DOCINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG "
	_cPEDWMAS += " WHERE DOC.NUMERODOCUMENTO = '"+cPed+"'"
	_cPEDWMAS += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "

	_cPEDWMAS := ChangeQuery(_cPEDWMAS)
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS New Alias "TRWM"
	
	dbSelectArea("TRWM")
	
	_cPEDWMAS1 := " SELECT INTEG.TIPOINTEGRACAO TIPINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG
	_cPEDWMAS1 += " WHERE DOC.SEQUENCIAINTEGRACAO = '"+STR(TRWM->DOCINT)+"' "
	_cPEDWMAS1 += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "
	
	_cPEDWMAS1 := ChangeQuery(_cPEDWMAS1)
	
	If Select("TRWM1") >0
		dbSelectArea("TRWM1")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS1 New Alias "TRWM1"
	
	dbSelectArea("TRWM1")

	IF TRWM1->TIPINT <> 251 .AND. TRWM1->TIPINT <> 0 .AND. TRWM->DOCINT <> 0 
	  //	MSGBOX("NรO ษ PERMITIDO A ALTERAวรO DO PEDIDO POIS ESTม NO WMAS."+CHR(13)+"SOLICITE O ESTORNO AO DEPARTAMENTO DE EXPEDIวรO")
		lWMS:= .T.
	ELSE
		lWMS:= .F.	
	ENDIF				
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	If Select("TRWM1") >0
		dbSelectArea("TRWM1")
		dbCloseArea()
	Endif

	
Return(lWMS)
