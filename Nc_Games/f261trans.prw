#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ F261TRANS ºAutor  ³Roger Cangianeli 		   º Data ³  10/12/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que efetua os movimentos de transferencias entre almoxa-  º±±
±±º          ³ rifados conforme escolha dos parametros.                         º±±
±±º          ³                                                                  º±±
±±º          ³                                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 8 - Nc Games                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function f261Trans()

cPerg	:= "NC0261"

N		:= 1

ValidPerg()
If !Pergunte(cPerg,.T.)
	Return
EndIf

_cMsg	:= "Esta rotina tranfere todo o conteudo dos produtos parametrizados de um "+Chr(10)+CHR(13)
_cMsg	+= "almoxarifado para outro. "+CHR(10)+CHR(13)
_cMsg	+= "Procedimento IRREVERSIVEL. Deseja Continuar ?"

If !MsgBox(_cMsg, "ATENCAO","YESNO")
	Return
EndIF

cQuery      := ""
//
aTRegistros  := {}
aRRegistros  := {}
//
cDocumento  := ""
cId         := ""
cProduto    := ""
cDescricao  := ""
cUM         := ""
cLocalDe    := ""
cLocalAte   := ""
nQuantidade := 0
cOwner      := ""
//
aTMovimento := {}
aRMovimento := {}
//
aTItens     := {{"", dDataBase}}
aRItens     := {{"", dDataBase}}
//
Private lMsHelpAuto := .f.
Private lMsErroAuto := .f.
//
_nHandle	:= fCreate("errotrf.log", 0 )

dbSelectArea("SD3")
cDocumento  := NEXTNUMERO("SD3",2,"D3_DOC",.T.)
_nItem		:= 0
_dData := dDataBase + 1

// PERMITIR ESTOQUE NEGATIVO, CASO CONTRARIO NAO FAZ A TRANSFERENCIA
// RESSALTO QUE O ESTOQUE NAO FICARA NEGATIVO, POIS É CHECADO PELA FUNCAO CALCEST.
// ROGER - 14/12/04
_lEstNeg := GetMV("MV_ESTNEG")
If _lEstNeg == "N"
	dbSelectArea("SX6")
	dbSeek("  MV_ESTNEG")
	RecLock("SX6",.F.)
	SX6->X6_CONTEUD	:= 'S'
	msUnlock()
	_lTrocou	:= .T.
EndIf


dbSelectArea("SB1")
dbSetOrder(1)
dbSeek(xFilial("SB1")+AllTrim(MV_PAR01),.T.)
while !eof() .AND. SB1->B1_COD <= ALLTRIM(MV_PAR02)
	
	If SB1->B1_GRUPO < MV_PAR03 .OR. SB1->B1_GRUPO > MV_PAR04
		dbSkip()
		Loop
	EndIf
	
	If SB1->B1_TIPO < MV_PAR05 .OR. SB1->B1_TIPO > MV_PAR06
		dbSkip()
		Loop
	EndIf
	
	aEst  	:= CalcEst( SB1->B1_COD, MV_PAR07, _dData, "01", "", "01" )
	If VALTYPE(AEST) == 'U'
		nQtdEst	:= 0
	Else
		nQtdEst	:= aEst[1]
	EndIf
	
	If nQtdEst <= 0
		dbSelectArea("SB1")
		dbSkip()
		Loop
	EndIf
	
	_nItem ++

	AAdd(aTRegistros, { SB1->B1_COD, _nItem, MV_PAR07, MV_PAR08, nQtdEst, "T" })
	
	cProduto    := SB1->B1_COD
	cDescricao  := SB1->B1_DESC
	cUM         := SB1->B1_UM
	cLocalDe    := MV_PAR07
	cLocalAte   := MV_PAR08

	//
	If ( (nRow := aScan(aTMovimento, {|xColuna| xColuna[1] == cDocumento})) > 0 )
		//
		AAdd ( aTMovimento[nRow], {cProduto, cDescricao, cUM, cLocalDe, "", cProduto, cDescricao, cUM, cLocalAte, "", "", "", "", CtoD("  /  /  "), 0.00, nQtdEst, 0.00, "", ""} )
		//
	Else
		// adicionando o documento de transferencia
		AAdd ( aTMovimento, {cDocumento, {cProduto, cDescricao, cUM, cLocalDe, "", cProduto, cDescricao, cUM, cLocalAte, "", "", "", "", CtoD("  /  /  "), 0.00, nQtdEst, 0.00, "", ""} } )
		//
	Endif
	//
	
	dbSelectArea("SB2")
	dbSetOrder(1)
	If !dbSeek(xFilial("SB2")+SB1->B1_COD+MV_PAR08,.F.)
		RecLock("SB2",.T.)
		SB2->B2_FILIAL	:= XFILIAL("SB2")
		SB2->B2_COD		:= SB1->B1_COD
		SB2->B2_LOCAL	:= MV_PAR08
		msUnlock()
	EndIf
	
	
	dbSelectArea("SB1")
	dbSkip()
	
End-Do


dbSelecTArea("SD3")
cDocumento  := NEXTNUMERO("SD3",2,"D3_DOC",.T.)

For nExecuta := 1 To Len(aTMovimento)
	//
	dbSelecTArea("SD3")
	cDocumento  := NEXTNUMERO("SD3",2,"D3_DOC",.T.)
	aTItens     := {{cDocumento, dDataBase}}

	//
	aEval ( aTMovimento[nExecuta], { |xRow| If ( ValType(xRow) == "A", AAdd ( aTItens, xRow ), (cDocumento := xRow) ) } )
	//
	MsExecAuto({|aArg1, nArg2| Mata261( aArg1, nArg2)}, aTItens, 3)
	//
	If lMsErroAuto
		//
		_cMsg := "Falha na Transferencia - Ref.: [ " + cDocumento + "/" + StrZero(nExecuta,6,0) + " ]"
		ConOut(_cMsg)
		
		Fwrite( _nHandle,_cMsg )
		
		lMsErroAuto := .f.
	Endif
	
Next nExecuta

fClose( _nHandle )

If _lTrocou
	dbSelectArea("SX6")
	dbSeek("  MV_ESTNEG")
	RecLock("SX6",.F.)
	SX6->X6_CONTEUD	:= 'N'
	msUnlock()
EndIf

MSGBOX("Rotina Concluida com sucesso.", "FIM DE PROCESSAMENTO", "STOP")

Return(Nil)



/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ ValidPerg()¦ Autor ¦ Jose Lucas          ¦ Data ¦ 11/12/04 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Verifica as perguntas incluíndo-as caso näo existam        ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Constroeste                                                ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
aRegs:={}
aAdd(aRegs,{cPerg,"01","Produto de  ?","","","mv_ch1","C",15,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
aAdd(aRegs,{cPerg,"02","Produto Ate ?","","","mv_ch2","C",15,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
aAdd(aRegs,{cPerg,"03","Grupo de    ?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Grupo Ate   ?","","","mv_ch4","C",04,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Tipo de     ?","","","mv_ch5","C",02,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Tipo Ate    ?","","","mv_ch6","C",02,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Almox de    ?","","","mv_ch7","C",02,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Almox Para  ?","","","mv_ch8","C",02,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
	Else
		RecLock("SX1",.F.)
	Endif
	
	For j:=1 to FCount()
		If j <= Len(aRegs[i])
			If !Empty(aRegs[i,j])
				FieldPut(j,aRegs[i,j])
			EndIf
		Endif
	Next
	MsUnlock()
Next
dbSelectArea(_sAlias)
RETURN

