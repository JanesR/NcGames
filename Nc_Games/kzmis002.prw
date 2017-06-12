#Include "Protheus.ch"
#Include "Topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³KZMIS002  º Autor ³ SServices          º Data ³  07/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Programa para geração de planilha Excel contendo os dados  º±±
±±º          ³ das notas fiscais canceladas.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico NC Games                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºDefinição ³ Executada via menu.                                        º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function KZMIS002()

Local cCrLf		:= Chr(13) + Chr(10)
Local nX := 0
Local _aCampos := {}
Local aPergs 	:= {}
Local aRet 		:= {}
Local _cQry 	:= ""
Local _nTotSC6 	:= 0 // total do pedido de venda
Local _nTotSD2 	:= 0 // Calcula o total de itens da nota
Local _nTotProd := 0 // Calcula quantidade de produtos da nota
Local cCadastro := OemToAnsi("Relação de Notas Fiscais Canceladas - Excel")
Local aSays:={}, aButtons:={}
Local nOpca     := 0

Private _cArqTmp	:= ""
Private _cIndTmp	:= ""


AADD(aSays,OemToAnsi( "Este programa tem como objetivo gerar planilha Excel  "))
AADD(aSays,OemToAnsi( "contendo as notas fiscais canceladas de acrodo com os "))
AADD(aSays,OemToAnsi( "parâmetros definidos pelo usuário.                    "))

//AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
AADD(aButtons, { 1,.T.,{|| nOpca := 1,FechaBatch() }} )
AADD(aButtons, { 2,.T.,{|| nOpca := 0,FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	Processa( { || KZMIS002X() })
EndIf

cFOpen := cGetFile("Todos os Arquivos|*.*",'Selecione o Diretorio',0,'C:\',.T.,GETF_LOCALFLOPPY+GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.F.)


__CopyFile(_cArqTmp+".DBF",cFOpen+"NF_CANC")

apmsgstop("Arquivo Gerado "+cFOpen+"NF_CANC","ATENCAO")
If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf
// abre arquivo temporario em excel.
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( cFOpen+"NF_CANC" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)

Ferase(_cArqTmp+".DBF")



Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function  KZMIS002X()

Local cCrLf		:= Chr(13) + Chr(10)
Local nX := 0

Local aPergs 	:= {}
Local aRet 		:= {}
Local _aCampos := {}
Local _cQry 	:= ""
Local sAgend	:= fLeAgend() // {} // retorna array contendo os agendamentos do pedido de venda
Local _nTotSC6 	:= 0 // total do pedido de venda
Local _nTotSD2 	:= 0 // Calcula o total de itens da nota
Local _nTotProd := 0 // Calcula quantidade de produtos da nota

aAdd( aPergs ,{1,"Emissão de	: "    	, dDataBase , PesqPict("SF2", "F2_EMISSAO"),'.T.',"" ,'.T.', TamSX3("F2_EMISSAO")[1], .T.}) // 1
aAdd( aPergs ,{1,"Emissão até	: "    	, dDataBase , PesqPict("SF2", "F2_EMISSAO"),'.T.',"" ,'.T.', TamSX3("F2_EMISSAO")[1], .T.}) // 2
aAdd( aPergs ,{2,"Agendamento	: "	  	, 0			, &sAgend, 110,'.T.',.T.})                                                      // 3
aAdd( aPergs ,{1,"Cliente de 	: "		,Space(TamSX3("A1_COD")[1])		,PesqPict("SA1", "A1_COD")	,'.T.',"SA1",'.T.',TamSX3("A1_COD")[1],.F.})        // 4
aAdd( aPergs ,{1,"Loja de 		: "		,Space(TamSX3("A1_LOJA")[1])	,PesqPict("SA1", "A1_LOJA")	,'.T.',,'.T.',TamSX3("A1_LOJA")[1],.F.})            // 5
aAdd( aPergs ,{1,"Cliente até 	: "		,Replicate("Z", TamSX3("A1_COD")[1])	,PesqPict("SA1", "A1_COD")	,'.T.',"SA1",'.T.',TamSX3("A1_COD")[1],.F.})        // 6
aAdd( aPergs ,{1,"Loja até 		: "		,Replicate("Z", TamSX3("A1_LOJA")[1])	,PesqPict("SA1", "A1_LOJA")	,'.T.',,'.T.',TamSX3("A1_LOJA")[1],.F.})            // 7
aAdd( aPergs ,{1,"Vendedor de 	: "		,Space(TamSX3("A3_COD")[1])	,PesqPict("SA3", "A3_COD")	,'.T.',"SA3",'.T.',TamSX3("A3_COD")[1],.F.})        // 8
aAdd( aPergs ,{1,"Vendedor até 	: "		,Replicate("Z", TamSX3("A3_COD")[1])	,PesqPict("SA3", "A3_COD")	,'.T.',"SA3",'.T.',TamSX3("A3_COD")[1],.F.})        // 9

If !ParamBox(aPergs ,"Parametros ",aRet)
	Return
EndIf



If Select("TSF2") > 0
	TSF2->(dbCloseArea())
EndIf

_cQry := " SELECT	SF2.F2_FILIAL, SF2.F2_DOC, SF2.F2_SERIE, SF2.F2_CLIENTE, SF2.F2_LOJA, SF2.F2_EMISSAO, SF2.F2_HORA, SF2.F2_VOLUME1, SF2.F2_ESPECIE, "
_cQry += " 			SF2.F2_PLIQUI,SF2.F2_PBRUTO, SF2.F2_VALBRUT, SF2.F2_TIPO, SF2.F2_VEND1, "
_cQry += " 			SF3.F3_NFISCAL, SF3.F3_SERIE, SF3.F3_CLIEFOR, SF3.F3_LOJA, SF3.F3_DTCANC "
_cQry += " FROM "+RetSqlName("SF2") + " SF2 "
_cQry += " INNER JOIN " + RetSqlName("SF3") + " SF3 "
_cQry += " 	ON SF2.F2_DOC = SF3.F3_NFISCAL "
_cQry += " 		AND SF2.F2_SERIE = SF3.F3_SERIE "
_cQry += " 		AND SF2.F2_CLIENTE = SF3.F3_CLIEFOR "
_cQry += " 		AND SF2.F2_LOJA = SF3.F3_LOJA "
_cQry += " 		AND (SF3.F3_DTCANC <> '' OR SF3.F3_OBSERV LIKE '%CANCEL%') "
_cQry += " 		AND SF2.F2_TIPO = 'N' "
_cQry += " 		AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "
_cQry += " 		AND SF3.F3_FILIAL = '"+xFilial("SF3")+"' "
_cQry += " 		AND F3_EMISSAO BETWEEN '"+Dtos(aRet[1])+"' AND '"+Dtos(aRet[2])+"' "
_cQry += " 		AND F3_CLIEFOR BETWEEN '"+aRet[4]+"' AND '"+aRet[6]+"' "
_cQry += " 		AND F3_LOJA BETWEEN '"+aRet[5]+"' AND '"+aRet[7]+"' "
//_cQry += " 		AND SF3.D_E_L_E_T_ <> '*' "

_cQry := ChangeQuery(_cQry)
dbUsearea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TSF2",.T.,.T.)

// Caso não haja notas canceladas
If TSF2->(Eof())
	ApMsgInfo("Não existem notas canceladas para os parâmetros digitados!","Atenção")
	TSF2->(dbCloseArea())
	Return
EndIf

TSF2->(dbGoTop())

aAdd(_aCampos,{"NUMPED"	 ,"C",6,0})
aAdd(_aCampos,{"NOMECLI" ,"C",40,0})
aAdd(_aCampos,{"UF"	 ,"C",2,0})
aAdd(_aCampos,{"VLRPED" ,"N",16,2})
aAdd(_aCampos,{"DTEMISNF","D",8,0})
aAdd(_aCampos,{"HRNF"	,"C",8,0})
aAdd(_aCampos,{"NUMNF"	,"C",9,0})
aAdd(_aCampos,{"SERIENF","C",3,0})
aAdd(_aCampos,{"VOLNF"	 ,"N",16,2})
aAdd(_aCampos,{"ESPEC"	 ,"C",5,0})
aAdd(_aCampos,{"PLIQUI"	 ,"N",16,2})
aAdd(_aCampos,{"PBRUTO"	 ,"N",16,2})
aAdd(_aCampos,{"NATOPER" ,"C",20,0})
aAdd(_aCampos,{"VLRTOTNF","N",16,2})
aAdd(_aCampos,{"VEND"	,"C",6,0})
aAdd(_aCampos,{"CLIENT"	,"C",6,0})
aAdd(_aCampos,{"NOMEVEND","C",40,0})
aAdd(_aCampos,{"AGENDAM","C",1,0})
aAdd(_aCampos,{"QTDITENS","N",16,2})
aAdd(_aCampos,{"QTDPROD","N",16,2})
aAdd(_aCampos,{"DTCANC"	 ,"D",8,0})


_cArqTmp	:= Criatrab(_aCampos,.t.)
//_cIndTmp	:= Criatrab(,.f.)


DbUseArea(.T.,,_cArqTmp,"TMP",.T.,.F.)

dbSelectArea("TSF2")
dbGotop()



// Lê caminho de gravação do arquivo de relatórios notas fiscais canceladas
_cDirExp := GetNewPar("KZ_DIRNFCA","\SYSTEM\DATA\")

// Lê o nome de arquivo de gravação da tabela de preço
_cArqExp := "Emp_"+SM0->M0_CODIGO + "_Fil_" + SM0->M0_CODFIL + "_NF_CANCEL_"+Dtos(MsDate()) + "_" + SubStr(time(),1,2)+SubStr(time(),4,2)+SubStr(time(),7,2) + ".XLS"


// Caso não haja registros a exportar
TSF2->(dbGotop())
//ProcRegua(Reccount())

cIndex := " "


While !TSF2->(Eof())
	//	IncProc()
	
	If TSF2->(F3_CLIEFOR+F3_LOJA)+TSF2->(F3_NFISCAL+F3_SERIE) = cIndex
		TSF2->(dbSkip())
		Loop
	EndIf
	
	// Posiciona item da nota
	If Select("TSD2") > 0
		TSD2->(dbCloseArea())
	EndIf
	_cQry := " SELECT D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_PEDIDO, D2_CF, D2_TES  "
	_cQry += " FROM "+RetSqlName("SD2")
	_cQry += " WHERE D2_FILIAL = '"+xFilial("SD2")+"' "
	_cQry += " AND D2_DOC = '"+TSF2->F3_NFISCAL+"' "
	_cQry += " AND D2_SERIE = '"+TSF2->F3_SERIE+"' "
	_cQry += " AND D2_CLIENTE = '"+TSF2->F3_CLIEFOR+"' "
	_cQry += " AND D2_LOJA = '"+TSF2->F3_LOJA+"' "
	
	_cQry := ChangeQuery(_cQry)
	dbUsearea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TSD2",.T.,.T.)
	
	// Posiciona pedido de venda
	SC5->(dbSetOrder(3)) // C5_FILIAL+C5_CLIENTE+C5_LOJACLI+C5_NUM
	SC5->(dbSeek(xFilial("SC5")+TSF2->(F3_CLIEFOR+F3_LOJA)+TSD2->D2_PEDIDO))
	
	// Verifica o agendamento selecionado pelo usuário
	If aRet[3] == "9"	// T=Todos	// If !"T" $ Upper(aRet[3])
		// Não faz nada
	Else
		If aRet[3] <> SC5->C5_TIPAGEN
			TSF2->(dbSkip())
			Loop
		EndIf
	EndIf
	
	
	_cVend1   := Posicione("SC5",3,xFilial("SC5")+TSF2->(F3_CLIEFOR+F3_LOJA)+TSD2->D2_PEDIDO,"C5_VEND1")
	
	
	// Verifica se o vendedor é válido
	If _cVend1< aRet[8] .Or. _cVend1 > aRet[9]
		TSF2->(dbSkip())
		Loop
	EndIf
	
	// Posiciona vendedores
	SA3->(dbSetOrder(1))
	SA3->(dbSeek(xFilial("SA3")+_cVend1))
	
	
	// Posiciona item da nota fiscal de sadia
	SF2->(dbSetOrder(2)) // F2_FILIAL+F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE
	SF2->(dbSeek(xFilial("SF2")+TSF2->(F3_CLIEFOR+F3_LOJA)+TSF2->(F3_NFISCAL+F3_SERIE)))
	
	
	// Calcula o total do pedido de venda
	_nTotSC6 := KZTotSC6()
	
	// Calcula o total de itens da nota
	_nTotSD2 := KZTotSD2()
	
	// Calcula quantidade de produtos da nota
	_nTotProd := KZTotProd()
	
	_cNomVd   := Posicione("SA3",1,xFilial("SA3")+TSF2->F2_VEND1,"A3_NOME")
	_cNatOp   := Posicione("SF4",1,xFilial("SF4")+TSD2->D2_TES,"F4_TEXTO")
	_cCliente := Posicione("SA1",1,xFilial("SA1")+TSF2->(F3_CLIEFOR+F3_LOJA),"A1_NOME")
	_cEst     := Posicione("SA1",1,xFilial("SA1")+TSF2->(F3_CLIEFOR+F3_LOJA),"A1_EST")
	_cNota    := TSF2->F3_NFISCAL
	

	
	dbSelectArea("TMP")
	RecLock("TMP",.T.)
	
	TMP->NUMPED  :=	 TSD2->D2_PEDIDO
	TMP->NOMECLI := _cCliente
	TMP->UF	     :=	 _cEst
	TMP->VLRPED  :=	 _nTotSC6
	TMP->DTEMISNF:=	 Stod(TSF2->F2_EMISSAO)
	TMP->HRNF    :=	 AllTrim(TSF2->F2_HORA)
	TMP->NUMNF   :=	 AllTrim(_cNota)
	TMP->SERIENF :=	 AllTrim(TSF2->F3_SERIE)
	TMP->VOLNF   :=	 TSF2->F2_VOLUME1
	TMP->ESPEC   :=	 AllTrim(TSF2->F2_ESPECIE)
	TMP->PLIQUI  := TSF2->F2_PLIQUI
	TMP->PBRUTO  :=  TSF2->F2_PBRUTO
	TMP->NATOPER :=  AllTrim(_cNatOp)
	TMP->VLRTOTNF:= TSF2->F2_VALBRUT
	TMP->VEND    := TSF2->F2_VEND1 //AllTrim(_cVend1)
	TMP->CLIENT  := TSF2->F3_CLIEFOR+"/"+TSF2->F3_LOJA
	TMP->NOMEVEND := AllTrim(_cNomVd)
	TMP->AGENDAM  := SC5->C5_TIPAGEN
	TMP->QTDITENS := _nTotSD2
	TMP->QTDPROD  := _nTotProd
	TMP->DTCANC   := Stod(TSF2->F3_DTCANC)
	
	MsUnLock()
	
	
	cIndex := TSF2->(F3_CLIEFOR+F3_LOJA)+TSF2->(F3_NFISCAL+F3_SERIE)
	
	TSF2->(dbSkip())
EndDo



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fLeAgend  ºAutor  ³Microsiga           º Data ³  05/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Seleciona os tipos de tipagem do pedido de venda.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico NC Games                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fLeAgend()

Local _sAgd := '{' // '{"T=Todos",'
Local aAux 	:= {}
Local i 	:= 1

SX3->(dbSetOrder(2))
SX3->(dbSeek("C5_TIPAGEN"))

aAux 	:= RetSX3Box( SX3->(X3Cbox()) , 1, 5, SX3->X3_TAMANHO )

While i <= Len(aAux)
	If !Empty(aAux[i][1])
		_sAgd += '"'+AllTrim(aAux[i][1])+'"'
	EndIf
	i++
	If i <= Len(aAux) .And. !Empty(aAux[i][1])
		_sAgd += ','
	EndIf
EndDo
_sAgd += ',"9=Todos"}'	// '{"T=Todos",'

Return(_sAgd)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³KZTotSC6  ºAutor  ³SServices           º Data ³  05/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula o total do pedido de venda.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico NC Games                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KZTotSC6()

Local nTotPed := 0

If Select("TSC6") > 0
	TSC6->(dbCloseArea())
EndIf

_cQry := " SELECT SUM(C6_VALOR) TOTPED "
_cQry += " FROM " + RetSqlName("SC6")
_cQry += " WHERE C6_FILIAL = '"+xFilial("SC6")+"' "
_cQry += " AND C6_NUM = '"+TSD2->D2_PEDIDO+"' "
//_cQry += " AND C6_NOTA = '"+TSF2->F3_NFISCAL+"' "// comente esta linha caso queira o total do pedido em vez do total dos itens faturados
//_cQry += " AND C6_SERIE = '"+TSF2->F3_SERIE+"' " // comente esta linha caso queira o total do pedido em vez do total dos itens faturados
_cQry += " AND C6_CLI = '"+TSD2->D2_CLIENTE+"' "
_cQry += " AND C6_LOJA = '"+TSD2->D2_LOJA+"' "
//_cQry += " AND D_E_L_E_T_ <> '*' "

_cQry := ChangeQuery(_cQry)
dbUsearea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TSC6",.T.,.T.)

If !TSC6->(Eof())
	nTotPed := 	TSC6->TOTPED
EndIf

TSC6->(dbCloseArea())

Return(nTotPed)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³KZTotItn  ºAutor  ³SServices           º Data ³  05/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula o total de itens da nota.                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico NC Games                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KZTotSD2()

Local nTotItn := 0

If Select("TRB") > 0
	TRB->(dbCloseArea())
EndIf

_cQry := " SELECT COUNT(D2_ITEM) TOTITN "
_cQry += " FROM  " + RetSqlName("SD2")
_cQry += " WHERE D2_FILIAL = '"+xFilial("SD2")+"' "
_cQry += " AND D2_DOC = '"+TSF2->F3_NFISCAL+"' "
_cQry += " AND D2_SERIE = '"+TSF2->F3_SERIE+"' "
_cQry += " AND D2_CLIENTE = '"+TSF2->F2_CLIENTE+"' "
_cQry += " AND D2_LOJA = '"+TSF2->F2_LOJA+"' "

_cQry := ChangeQuery(_cQry)
dbUsearea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TRB",.T.,.T.)

If !TRB->(Eof())
	nTotItn := 	TRB->TOTITN
EndIf

TRB->(dbCloseArea())

Return(nTotItn)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³KZTotProd()ºAutor  ³SServices          º Data ³  05/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula quantidade de produtos da nota.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico NC Games                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KZTotProd()

Local nTotProd := 0

If Select("TRB") > 0
	TRB->(dbCloseArea())
EndIf

_cQry := " SELECT SUM(D2_QUANT) AS QUANT "
_cQry += " FROM  " + RetSqlName("SD2")
_cQry += " WHERE D2_FILIAL = '"+xFilial("SD2")+"' "
_cQry += " AND D2_DOC = '"+TSF2->F3_NFISCAL+"' "
_cQry += " AND D2_SERIE = '"+TSF2->F3_SERIE+"' "
_cQry += " AND D2_CLIENTE = '"+TSF2->F2_CLIENTE+"' "
_cQry += " AND D2_LOJA = '"+TSF2->F2_LOJA+"' "

_cQry := ChangeQuery(_cQry)
dbUsearea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TRB",.T.,.T.)


If !TRB->(Eof())
	nTotProd :=  TRB->QUANT
EndIf

TRB->(dbCloseArea())

Return(nTotProd)
