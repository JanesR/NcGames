#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNFATR03   บ Autor ณ Reinaldo Caldas    บ Data ณ  09/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function NFatr04


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
Private nomeprog         := "NFatr04" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "NFATR04" // Coloque aqui o nome do arquivo usado para impressao em disco
Private _cUnq	   :=""
Private _cUnq1	   :=""
Private _cDoc	   :=""
Private _cItem	   :=""


Private cString := "SZ1"
Private cPerg   := "FATR04"

Pergunte(cPerg,.F.)

dbSelectArea("SZ1")
dbSetOrder(1)


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
Local cNumPed
Local cEndSA1
Local cCepSA1
Local cBairSA
Local cMumSA1
Local cEstSA1

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


_cQry:="SELECT SZ1.Z1_DOC DOC, SZ1.Z1_SERIE SERIE, SZ1.Z1_CLIENTE CLIENTE, SZ1.Z1_LOJA LOJA,"
_cQry+=" SZ1.Z1_QTDVOL QTDVOL, SZ1.Z1_HORALB HORALB, SZ1.Z1_DTSAIDA SAIDA, SZ3.Z3_CODMOTO CODMOTO, SZ3.Z3_ITEM ITEM"
_cQry+=" FROM SZ1010 SZ1, SZ3010 SZ3 "
_cQry+=" WHERE  SZ1.Z1_DOC = SZ3.Z3_DOC AND SZ1.Z1_SERIE = SZ3.Z3_SERIE AND"
_cQry+=" SZ1.Z1_DOC >= '"+mv_par03+"' AND SZ1.Z1_DOC <= '"+mv_par04+"' AND SZ3.Z3_CODMOTO >= '"+mv_par01+"' AND SZ3.Z3_CODMOTO <= '"+mv_par02+"' AND "
_cQry+=" SZ1.Z1_STATUS = 'A' AND SZ1.D_E_L_E_T_ = ' ' AND SZ3.D_E_L_E_T_ = ' ' "
_cQry+=" ORDER BY SZ3.Z3_CODMOTO, SZ1.Z1_DOC, SZ1.Z1_SERIE, SZ3.Z3_ITEM "
memowrit("TESTE.sql",_cQry)
_cQry := ChangeQuery(_cQry)

dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry),"SQL", .F., .T.)

dbGoTop()
SetRegua(RecCount())


While !Eof() .AND. _cUnq <> SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA
	_cUnq := SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA
	_cItem:= SQL->ITEM
	
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
	
	dbSelectArea("DA4")
	dbSetOrder(1)
	dbSeek(xFilial("DA4")+SQL->CODMOTO)
	
	dbSelectArea("SF2")
	dbSetOrder(1)
	dbSeek(xFilial("SF2")+SQL->DOC+SQL->SERIE+SQL->CLIENTE+SQL->LOJA)
	
	dbSelectArea("SA4")
	dbSetOrder(1)
	dbSeek(xFilial("SA4")+SF2->F2_TRANSP)

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
	cNumPed:=Posicione("SD2",3,xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"D2_PEDIDO")
	
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
	@ nLin, 056 PSAY cMunSA1
	@ nLin, 075 PSAY cEstSA1
	
	
	_cCliente:=SQL->CLIENTE
	_cLoja   :=SQL->LOJA
	IF SQL->CLIENTE == _cCliente
		While SQL->CLIENTE+SQL->LOJA == _cCliente+_cLoja .and. _cUnq1 <> SQL->DOC+SQL->SERIE+SQL->ITEM+SQL->CLIENTE+SQL->LOJA
			If  _cDoc <> SQL->DOC
				_cItem := SQL->ITEM
			EndIf
			_cUnq1:= SQL->DOC+SQL->SERIE+SQL->ITEM+SQL->CLIENTE+SQL->LOJA
			IF _cItem <> SQL->ITEM
				_cItem:= SQL->ITEM
				dbSelectArea("SQL")
				dbSkip()
			ELSE     
				_cDoc := SQL->DOC
				nLin +=2
				@nLin,002 PSAY "Nota Fiscal :"+SQL->DOC+" "+SQL->SERIE
				@nLin,035 PSAY "Qtd.Volumes  :"+Alltrim(STR(SQL->QTDVOL))
				nLin +=1
				dbSelectArea("SZ3")
				dbSetOrder(1)
				dbSeek(xFilial("SZ3")+SQL->DOC+SQL->SERIE)
				While !Eof() .and. SQL->DOC+SQL->SERIE == SZ3->Z3_DOC+SZ3->Z3_SERIE
					aAdd(_aCodPack,SZ3->Z3_CODPACK)
					SZ3->(dbSkip())
				EndDo
				For _i:=1 To LEN(_aCodPack)
					@ nLin, 037 PSAY _aCodPack[_i]
					nLin +=1
				Next
				nLin +=1
				@ nLin, 002 PSAY "Data de Saida:"+DTOC(StoD(SQL->SAIDA)) Picture "@ 99/99/99"
				@ nLin, 030 PSAY "Hr.da Saida  :"+SQL->HORALB
				dbSelectArea("SQL")
				dbSkip()				
			EndIf
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
