#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"

User Function ATUDA0DA1()
Private _aUser    := PswRet(1)
Private _nI       := 0
Private _cProduto := Space(15)
Private _cTabelas := AllTrim(SuperGetMv("MV_NCTABPR",.F.,""))

Processa({|| Atu001_001() },"Processando Atualizacoes...")
Return

Static Function Atu001_001()
dbSelectArea("SZJ")
dbSetOrder(3)            // ZJ_FILIAL+ZJ_DTPROG+ZJ_CODIGO
dbSeek(xFilial("SZJ"),.T.)

Do While !Eof() .And. SZJ->ZJ_DTPROG <= dDataBase
	If SZJ->ZJ_STATUS <> "1"
		dbSkip()
		Loop
	EndIf
	If SZJ->ZJ_DTPROG <> dDataBase
		dbSkip()
		Loop
	EndIf
	
	dbSelectArea("SZH")
	dbSetOrder(3)           // ZH_FILIAL+ZH_CODIGO+ZH_ITEM
	dbSeek(xFilial("SZH")+SZJ->ZJ_CODIGO,.T.)
	ProcRegua(RecCount())
	Do While !Eof() .And. SZJ->ZJ_CODIGO == SZH->ZH_CODIGO

        IncProc("Atualizando Produto "+SZH->ZH_PRODUTO)

//      Verifica se o produto existe nas tabelas 007, 012, 018 E contidas no parametro MV_NCTABPR, caso não exista sera criado.
        _cProduto := SZH->ZH_PRODUTO
	    Verifica_Prods()
//      Fim verificação
		dbSelectArea("DA1")
		dbSetOrder(2)               // DA1_FILIAL+DA1_CODPRO+DA1_CODTAB+DA1_ITEM
		If dbSeek(xFilial("DA1")+SZH->ZH_PRODUTO,.T.)
            ProcRegua(RecCount())		
		    Do While !Eof() .And. SZH->ZH_PRODUTO == DA1->DA1_CODPRO
                IncProc("Atualizando Produto "+SZH->ZH_PRODUTO+" Tabela "+DA1->DA1_CODTAB)
				If DA1->DA1_CODTAB == "007"
					RecLock("DA1",.F.)
					DA1->DA1_PRCVEN  := SZH->ZH_PRECO07
					MsUnlock()
					_nI++
				Else
					If DA1->DA1_CODTAB == "012"
						RecLock("DA1",.F.)
						DA1->DA1_PRCVEN  := SZH->ZH_PRECO12
						MsUnlock()
						_nI++
					Else
						If DA1->DA1_CODTAB == "018"
							RecLock("DA1",.F.)
							DA1->DA1_PRCVEN  := SZH->ZH_PRECO18
							MsUnlock()
							_nI++
						EndIf
					EndIf
				EndIf
				dbSelectArea("DA1")
				dbSkip()
		    EndDo
		EndIf
		
		dbSelectArea("SB1")
		dbSetOrder(1)
		If dbSeek(xFilial("SB1")+SZH->ZH_PRODUTO)
			RecLock("SB1",.F.)
			SB1->B1_CONSUMI  := SZH->ZH_PRVSUG
			SB1->B1_PRV1     := SZH->ZH_PRV0
			SB1->B1_XPRV18   := SZH->ZH_PRECO18
			SB1->B1_XPRV12   := SZH->ZH_PRECO12
			SB1->B1_XPRV07   := SZH->ZH_PRECO07
			MsUnlock()
		EndIf
		dbSelectArea("SZH")
		dbSkip()
	EndDo
	dbSelectArea("SZJ")
	RecLock("SZJ",.F.)
	SZJ->ZJ_STATUS := "2"
	MsUnlock()
	dBSkip()
EndDo

If _nI == 0
	Alert("Nao foi encontrada nenhuma Tabela para atualizacao programada para a Data de Hoje ("+Dtoc(dDataBase)+")...")
	Return
EndIf
//
//  Atualiza todas as outras tabelas com base nas tabelas 007, 012 e 018
//
Private _nIndice  := 0.00
Private _cTabBase := Space(03)

dbSelectArea("DA0")
dbSetOrder(1)            // DA0_FILIAL+DA0_CODTAB
dbSeek(xFilial("DA0"),.T.)
Do While !Eof()
	If DA0->DA0_CODTAB == "007" .Or. DA0->DA0_CODTAB == "012" .Or. DA0->DA0_CODTAB == "018"
		dbSkip()
		Loop
	EndIf
	
	If Empty(DA0->DA0_TABBAS)
		dbSkip()
		Loop
	EndIf
	
	dbSelectArea("SZK")
	dbSetOrder(3)               // ZK_FILIAL+ZK_TABAATU
	If dbSeek(xFilial("SZK")+DA0->DA0_CODTAB)
		_cTabBase := SZK->ZK_TABBASE
		_nIndice  := SZK->ZK_INDICE
	EndIf
	
	If DA0->DA0_TABBAS <> _cTabBase
		Alert("Dados divergentes...  Tabela Base informada na Tabela de preco e na Amarracao para atualizacao nao sao as mesmas...")
		dbSelectArea("DA0")
		dbSkip()
		Loop
	EndIf
	
	Private _nPrcVen := 0.00
	dbSelectArea("DA1")
	dbSetOrder(1)       // DA1_FILIAL+DA1_CODTAB+DA1_CODPRO+DA1_INDLOT+DA1_ITEM
	dbSeek(xFilial("DA1")+DA0->DA0_CODTAB,.T.)
    ProcRegua(RecCount())
	Do While !Eof() .And. DA0->DA0_CODTAB == DA1->DA1_CODTAB
        IncProc("Atualizando Produto "+DA1->DA1_CODPRO+" Tabela "+DA1->DA1_CODTAB)	
		_nPrcVen := GetAdvFVal("DA1","DA1_PRCVEN",xFilial("DA1")+_cTabBase+DA1->DA1_CODPRO,1,0.00)
		If _nPrcVen > 0.00
			_nPrcVen := _nPrcVen + ((_nPrcVen / 100) * _nIndice)
			RecLock("DA1",.F.)
			DA1->DA1_PRCVEN := _nPrcVen
			DA1->DA1_DATVIG := dDatabase
			MsUnlock()
		EndIf
		_nPrcVen := 0.00
		dbSkip()
	EndDo
	dbSelectArea("DA0")
	dbSkip()
EndDo

Alert("Atualizacao Concluida... Favor conferir tabelas envolvidas nesse periodo de testes para posterior subtituicao dessa mensagem...")
Return

Static Function Verifica_Prods()
Private _cItem    := SPACE(04)
Private _cTabAtu  := Space(03)
Private _nI       := 0

For _nI := 1  To  Len(_cTabelas)  Step 4
    _cTabAtu := Substr(_cTabelas,_nI,3)
    
    dbSelectArea("DA1")
    dbSetOrder(2)               // DA1_FILIAL+DA1_CODPRO+DA1_CODTAB+DA1_ITEM
    If !(dbSeek(xFilial("DA1")+_cProduto+_cTabAtu,.T.))
         Inclui_Prods()
    EndIf
Next
Return

Static Function Inclui_Prods()
Private _cItem     := Space(04)
Private _cProxItem := Space(04)

dbSelectArea("DA1")
dbSetOrder(3)               // DA1_FILIAL+DA1_CODTAB+DA1_ITEM
dbSeek(xFilial("DA1")+_cTabAtu,.T.)
Do While !Eof() .And. DA1->DA1_CODTAB == _cTabAtu
    _cItem := DA1->DA1_ITEM
    dbSkip()
EndDo
_cProxItem := Soma1(_cItem,4)

RecLock("DA1",.T.)
DA1->DA1_FILIAL  := xFilial("DA1")
DA1->DA1_ITEM    := _cProxItem
DA1->DA1_CODTAB  := _cTabAtu
DA1->DA1_CODPRO  := _cProduto
DA1->DA1_GRUPO   := SPACE(04)
DA1->DA1_REFGRD  := SPACE(26)
DA1->DA1_PRCVEN  := 0.00
DA1->DA1_VLRDES  := 0.00
DA1->DA1_PERDES  := 0.0000
DA1->DA1_ATIVO   := "1"
DA1->DA1_FRETE   := 0.00
DA1->DA1_ESTADO  := SPACE(02)
DA1->DA1_TPOPER  := "4"
DA1->DA1_QTDLOT  := 999999.99
DA1->DA1_INDLOT  := "000000000999999.99"
DA1->DA1_MOEDA   := 1
DA1->DA1_DATVIG  := GETADVFVAL("DA0","DA0_DATATE",xFIlial("DA0")+_cTabAtu,1,Ctod(""))  // DA0->DA0_DATATE - DA0(1) DA0_FILIAL+DA0_CODTAB
DA1->DA1_ITEMGR  := SPACE(03)
DA1->DA1_PRCMAX  := 0.00
DA1->DA1_XMOT    := SPACE(06)
DA1->DA1_XMOTD   := SPACE(60)
MsUnlock()
Return