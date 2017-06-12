#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNFinr01   บ Autor ณ Reinaldo Caldas    บ Data ณ  26/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Emissao de duplicatas                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function Nfinr01A


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Emissao de duplicatas NC Games"
Local cPict          := ""
Local titulo       	 := "Emissao de duplicatas NC Games"
Local nLin         	 := 7
Local cPerg          :="FINR01A"
Local Cabec1         := "Este programa ira emitir duplicatas conforme"
Local Cabec2         := "os parametros selecionados"
Local imprime        := .T.
Local aOrd 			 := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 80
Private tamanho      := "P"
Private nomeprog     := "NFinr01A"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Public wnrel1        := "NFinr01A"

Pergunte(cPerg,.T.)               // Pergunta no SX1

Private cString := "SE1"

dbSelectArea("SE1")
dbSetOrder(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel1 := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  26/07/04   บฑฑ
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
_lAB:=.F.

//dbSelectArea(cString)
//dbSetOrder(1)
//dbSeek(xFilial()+mv_par03+mv_par01)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Empty(mv_par01)
	
	If Select("SQL") > 0
		dbSelectArea("SQL")
		dbCloseArea()
	Endif
	
	_cQry1:="SELECT SE1.E1_NUM NUMERO, SE1.E1_PREFIXO PREFIXO, SE1.E1_NUMBOR NUMBOR,"
	_cQry1+=" SE1.E1_TIPO TIPO,SE1.E1_VALOR VALOR,SE1.E1_EMISSAO EMISSAO,SE1.E1_SALDO SALDO,"
	_cQry1+=" SE1.E1_VENCTO VENCTO,SE1.E1_PARCELA PARCELA,SE1.E1_CLIENTE CLIENTE,SE1.E1_LOJA LOJA"
	_cQry1+=" FROM  "+RetSQLName("SE1")+" SE1"
	_cQry1+=" WHERE SE1.E1_NUMBOR = '"+mv_par01+"' AND SE1.E1_PREFIXO ='"+mv_par03+"'
	_cQry1+=" AND SE1.D_E_L_E_T_ = ' '"
	_cQry1+=" ORDER BY PREFIXO,NUMERO, PARCELA"
	memowrit("TESTE.sql",_cQry1)
	_cQry1 := ChangeQuery(_cQry1)
	
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry1),"SQL", .F., .T.)
	dbGoTop()
	SetRegua(RecCount())
	While ! EOF() //.AND. _cNumbor==MV_PAR06
		
		Public		_cNumero 	:=SQL->NUMERO
		Public		_cPrefixo 	:=SQL->PREFIXO
		Public		_cNumBor 	:=SQL->NUMBOR
		Public		_cTipo 		:=SQL->TIPO
		Public		_nValor 	:=SQL->VALOR
		Public		_dEmissao 	:=DTOC(StoD(SQL->EMISSAO))
		Public		_nSaldo 	:=SQL->SALDO
		Public		_dVencto 	:=DTOC(StoD(SQL->VENCTO))
		Public		_cParcela 	:=SQL->PARCELA
		Public		_cLiente 	:=SQL->CLIENTE
		Public		_lOja	 	:=SQL->LOJA
		
		
		IF _CTIPO != "NF"
			Dbskip()
			Loop
		EndIF
		
		CNUM:=		_cNumero
		CSERIE:=	_cPrefixo
		dbSelectArea("SF2")
		If Select("SQL2") > 0
			dbSelectArea("SQL2")
			dbCloseArea()
		Endif
		
		_cQry:="SELECT SF2.F2_DOC DOC, SF2.F2_SERIE SERIE, SF2.F2_CLIENTE CLIENTE, SF2.F2_LOJA LOJA,"
		_cQry+=" SF2.F2_VALMERC MERC, SF2.F2_VALBRUT BRUTO, SF2.F2_VALICM ICM, SF2.F2_VALIPI IPI"
		_cQry+=" FROM  "+RetSQLName("SF2")+" SF2"
		_cQry+=" WHERE SF2.F2_DOC= '"+CNUM+"' AND SF2.F2_SERIE='"+CSERIE+"'
		memowrit("TESTE.sql2",_cQry)
		_cQry := ChangeQuery(_cQry)
		
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry),"SQL2", .F., .T.)
		
		dbGoTop()
		SetRegua(RecCount())
		_cCliente :=SQL2->CLIENTE
		_nValBrut :=SQL2->BRUTO
		_NumDoc :=SQL2->DOC
		
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		/*
		IF _CTIPO == "AB-"
		_lAB:=.T.
		_nValor:=_nValor
		Dbskip()
		Loop
		Else
		IF !_lAB
		_nValor:=0
		EndIF
		Endif
		*/
		@ nLin,062 PSAY _dEmissao
		nLin:= nLin + 5
		
		@ nLin,009 PSAY Alltrim(transform(_nValBrut,"999,999.99"))
		
		// RETIRADO POR ROGERIO - SUPERTECH PARA IMPRIMIR O VALOR TOTAL DA NOTA
		/*
		Do Case
		Case mv_par04=3
		@ nLin,009 PSAY Alltrim(transform(e1_valor,"999,999.99"))
		Case e1_saldo==e1_valor  .or. mv_par04=2
		@ nLin,009 PSAY Alltrim(transform(e1_valor,"999,999.99"))
		OtherWise
		@ nLin,009 PSAY Alltrim(transform(e1_saldo,"999,999.99"))
		EndCase
		*/
		@ nLin,020 Psay _cPREFIXO //criado pelo Rafael 03.12.09
		@ nLin,022 PSAY _cNumero
		
		Do Case
			Case mv_par02=3
				@ nLin,032 PSAY Alltrim(transform(_nSaldo,"999,999.99"))
			Case _nSaldo==_nValor  .or. mv_par02=2
				@ nLin,032 PSAY Alltrim(transform(_nValor,"999,999.99"))
			OtherWise
				@ nLin,032 PSAY Alltrim(transform(_nSaldo,"999,999.99"))
		EndCase
		
		@ nLin,047 Psay _cPREFIXO //criado pelo Rafael 03.12.2009
 
        IF LEN(_cNumero) == 9
			@ nLin,049 PSAY ALLTRIM(SUBSTR(_cNumero,4,6))+" "+_cParcela
		ELSE
			@ nLin,049 PSAY _cNumero+" "+_cParcela
		ENDIF
		
		@ nLin,060 PSAY _dVENCTO
		nLin:= nLin + 3
		if _nValor!=_nSaldo .and. mv_par02=3
			@ nLin,26 PSAY "APLICADO DESCONTO NA DUPLICATA DE R$ "+Alltrim(transform(_nValor-_nSaldo,"999,999.99"))+"****"
		Endif
		nLin++
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial()+_CLIENTE+_LOJA)
		@ nLin,038 PSAY A1_COD
		@ nLin,055 PSAY A1_VEND
		@ nLin,072 PSAY A1_BCO1
		nLin:= nLin + 2
		If found()
			@ nLin,000 PSAY CHR(15)
			@ nLin,045 PSAY A1_NOME
			nLin:= nLin + 1
			@ nLin,045 PSAY A1_ENDCOB
			nLin:= nLin +1
			@ nLin,045 PSAY A1_MUNC
			@ nLin,117 PSAY A1_ESTC
			@ nLin,127 PSAY A1_CEPC
			@ nLin,000 PSAY CHR(15)
			nLin := nLin + 1
			@ nLin,045 PSAY ALLTRIM(A1_MUNC)+" "+ALLTRIM(A1_ESTC)
			nLin := nLin + 1
			@ nLin,045 PSAY A1_CGC
			@ nLin,100 PSAY A1_INSCR
			@ nLin,000 PSAY CHR(18)
			nLin := nLin +2
		Endif
		
		//DbSelectArea("SE1")
		//dbSetOrder(1)
		@ nLin,000 PSAY CHR(15)
		IF _nSaldo == _nValor .OR. MV_PAR02 = 2
			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(_nValor),1,55)) + REPLICATE("*",69),1,69)
			nLin:= nLin + 1
			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(_nValor),56,55)) + REPLICATE("*",69),1,69)
			nLin:= nLin + 1
			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(_nValor),112,55)) + REPLICATE("*",69),1,69)
		Else
			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(_nSaldo),1,55)) + REPLICATE("*",69),1,69)
			nLin:= nLin + 1
			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(_nSaldo),56,55)) + REPLICATE("*",69),1,69)
			nLin:= nLin + 1
			@ nLin,045 PSAY Subs(RTRIM(SUBS(EXTENSO(_nSaldo),112,55)) + REPLICATE("*",69),1,69)
		EndIF
		
		@ nLin,000 PSAY CHR(18)
		
		_lAB:=.F.
		IF nLin > 80
			SetPrc(0,0) // (Zera o Formulario)
			nLin:=17
		Else
			nLin := nLin+17
		EndIF
		dbSelectArea("SQL")
		DbSkip()
		
	EndDO
End If

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
	OurSpool(wnrel1)
Endif

MS_FLUSH()

Return