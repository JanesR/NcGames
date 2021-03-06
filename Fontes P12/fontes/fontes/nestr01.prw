#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"

User Function NESTR01

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local Tamanho
Local Titulo   := 'Listagem para Inventario'
Local cDesc1   := 'Este programa emite um relatorio que facilita a digitacao'
Local cDesc2   := 'das quantidades inventariadas.'
Local cDesc3   := "Ele e' emitido de acordo com os parametros informados."
Local cString  := 'SB1'
Local aOrd     := {}
Local wnRel    := 'NESTR01'

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis tipo Private padrao de todos os relatorios         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private limite           := 132
Private tamanho          := "G"
Private nTipo            := 18
Private aReturn  := {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 }
Private nLastKey := 0
Private cPerg    := 'MTR280'

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Tratamento da Ordem para utilizacao do Siga Pyme             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

aOrd := {OemToAnsi(' Por Codigo         '),OemToAnsi(' Por Tipo           '),OemToAnsi(' Por Descricao    '),OemToAnsi(' Por Grupo        ')}


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01     // Almox. de                                    �
//� mv_par02     // Almox. ate                                   �
//� mv_par03     // Produto de                                   �
//� mv_par04     // Produto ate                                  �
//� mv_par05     // tipo de                                      �
//� mv_par06     // tipo ate                                     �
//� mv_par07     // grupo de                                     �
//� mv_par08     // grupo ate                                    �
//� mv_par09     // descricao de                                 �
//� mv_par10     // descricao ate                                �
//� mv_par11     // data Selecao de                              �
//� mv_par12     // data Selecao ate                             �
//� mv_par13     // Imprime Lote/Sub-Lote e N즡ero de S굍ie ?    �
//� mv_par14     // Lista Prod. C/ Sld Zerado ? (Sim/Nao)        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inclui pergunta no SX1                                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
PutSX1("MTR280","14","Lista Prod. Com Saldo Zerado ?","Lista Prod. Con Saldo Nulo ?  ","Cons. Prod. With Stock Zero ? ","mv_che","N",1,0,0,"C","","","","","mv_par14","Sim","Si","Yes","","Nao","No","No","","","","","","","","","",{"Considera o produto com saldo zerado na","filtragem do cadastro de saldos (SB2)."},{"Consider the product with zeroed balance","in filtering the balances file (SB2)."},{"Considera el producto con saldo cero en","el filtro del archivo de saldos (SB2)."})
Pergunte(cPerg,.F.)
//-- Define a variavel Tamanho de acordo com Impress꼘 ou N꼘 do Lote/Sub-Lote e N.S.
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
wnRel:=SetPrint(cString,wnRel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey == 27
	dbClearFilter()
	Return Nil
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	dbClearFilter()
	Return Nil
Endif


RptStatus({|lEnd| C280Imp(aOrd,@lEnd,wnRel,cString,Titulo,Tamanho)},Titulo)

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � C280IMP  � Autor � Rodrigo de A. Sartorio� Data � 11.12.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Chamada do Relatorio                                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � MATR280			                                              낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function C280Imp(aOrd,lEnd,wnRel,cString,Titulo,Tamanho)

Local cRodaTxt   := 'PRODUTO(S)'
Local nCntImpr   := 0
Local ntipo      := 0
Local lRastro    := .F.
Local lRastroS   := .F.
Local lCLocal    := .F.
Local cDet       := '[            ]  [          ]   [            ]  [          ]   [            ]  [          ]'
Local cLoteAnt   := ""
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Contadores de linha e pagina                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private Li      := 80
Private m_pag   := 1

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis privadas exclusivas deste programa                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private cCondicao  := ''
Private cCondicao1 := ''
Private lContinua  := .T.
Private lUsaLote   := If(GetMV('MV_RASTRO')=='S',.T.,.F.)
Private lImpLote   := If(mv_par13==1,.T.,.F.)

//-- Define Tamanho do Detalhe
If !lImpLote
	cDet := '[         ][     ][         ][     ][         ][     ]'
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicializa os codigos de caracter Comprimido/Normal da impressora �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
nTipo := If(aReturn[4]==1,15,18)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Adiciona a ordem escolhida ao Titulo do relatorio          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If Type('NewHead') # 'U'
	NewHead += ' (' + AllTrim(aOrd[aReturn[8]]) + ')'
Else
	Titulo += ' (' + AllTrim(aOrd[aReturn[8]]) + ')'
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Monta os Cabecalhos                                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If lImpLote
	Cabec1 := 'CODIGO          COD.BARRA      TP GRUPO DESC.NC GAMES                  UM ALM DESCRICAO       LOCALIZACAO     LOTE       SUB    NUMERO           ______1a. CONTAGEM______       ______2a. CONTAGEM______       ______3a. CONTAGEM______'
	Cabec2 := '                                                                              ALMOXARIFADO    FISICA                     LOTE   SERIE            QUANTIDADE      ETIQUETA       QUANTIDADE      ETIQUETA       QUANTIDADE      ETIQUETA'


//	Cabec1 := 'CODIGO          TP GRUPO DESCRICAO                      UM ALM DESCRICAO       LOCALIZACAO     LOTE       SUB    NUMERO           ______1a. CONTAGEM______       ______2a. CONTAGEM______       ______3a. CONTAGEM______'
//	Cabec2 := '                                                               ALMOXARIFADO    FISICA                     LOTE   SERIE            QUANTIDADE      ETIQUETA       QUANTIDADE      ETIQUETA       QUANTIDADE      ETIQUETA'
	//--                     123456789012345 12 1234  123456789012345678901234567890 12 12  123456789012345 123456789012345 1234567890 123456 12345678901234 [            ]  [          ]   [            ]  [          ]   [            ]  [          ]
	//--                     0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	//--                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Else
//	Cabec1 := 'CODIGO          TP GRUP DESCRICAO                      UM ALM LOCALIZACAO      __1a. CONTAGEM__  __2a. CONTAGEM__  __3a. CONTAGEM__ '
//	Cabec2 := '                                                                               QUANTIDADE ETIQU. QUANTIDADE ETIQU. QUANTIDADE ETIQU.'
	
	Cabec1 := 'CODIGO          COD.BARRA        TP GRUP DESC.NC GAMES                                                       UM ALM LOCALIZACAO      __1a. CONTAGEM__  __2a. CONTAGEM__  __3a. CONTAGEM__ '
	Cabec2 := '                                                                                                                                    QUANTIDADE ETIQU. QUANTIDADE ETIQU. QUANTIDADE ETIQU.'
EndIf
//--                     123456789012345 12 1234 123456789012345678901234567890 12 12  123456789012345 [         ][     ][         ][     ][         ][     ]
//--                     0         1         2         3         4         5         6         7         8         9        10        11        12        13
//--                     0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa os Arquivos e Ordens a serem utilizados           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB8')
dbSetOrder(3)

dbSelectArea('SBF')
dbSetOrder(2)

dbSelectArea('SB1')
dbSetOrder(aReturn[8])

If !__lPyme .And. aReturn[8] == 5
	A280ImpEnd(aOrd,lEnd,wnRel,cString,Titulo,Tamanho)
Else
	If aReturn[8] == 4
		dbSeek(cFilial + mv_par07, .T.)
		cCondicao := 'lContinua .And. !Eof() .And. B1_GRUPO <= mv_par08'
	ElseIf aReturn[8] == 3
		dbSeek(cFilial + mv_par09, .T.)
		cCondicao := 'lContinua .And. !Eof() .And. B1_DESC <= mv_par10'
	ElseIf aReturn[8] == 2
		dbSeek(cFilial + mv_par05, .T.)
		cCondicao := 'lContinua .And. !Eof() .And. B1_TIPO <= mv_par06'
	Else
		dbSeek(cFilial + mv_par03, .T.)
		cCondicao := 'lContinua .And. !Eof() .And. B1_COD <= mv_par04'
	Endif
	
	SetRegua(LastRec())
	Do While &(cCondicao) .And. B1_FILIAL == cFilial
		
		If lEnd
			@ pRow()+1, 001 PSAY 'CANCELADO PELO OPERADOR'
			Exit
		EndIf
		
		IncRegua()
		
		If !SB2->(dbSeek(xFilial('SB2') + SB1->B1_COD, .F.)) .Or. ;
			(SB1->B1_COD   < mv_par03) .Or. (SB1->B1_COD   > mv_par04) .Or. ;
			(SB1->B1_TIPO  < mv_par05) .Or. (SB1->B1_TIPO  > mv_par06) .Or. ;
			(SB1->B1_DESC  < mv_par09) .Or. (SB1->B1_DESC  > mv_par10) .Or. ;
			(SB1->B1_GRUPO < mv_par07) .Or. (SB1->B1_GRUPO > mv_par08)
			SB1->(dbSkip())
			Loop
		EndIf
		
		lRastro  := Rastro(SB1->B1_COD)
		lRastroS := Rastro(SB1->B1_COD, 'S')
		lCLocal  := Localiza(SB1->B1_COD)
		
		Do While !SB2->(Eof()) .And. ;
			SB2->B2_FILIAL + SB2->B2_COD == xFilial('SB2') + SB1->B1_COD
			
			If lEnd
				@ pRow()+1, 001 PSAY 'CANCELADO PELO OPERADOR'
				lContinua := .F.
				Exit
			EndIf
			
			If (!Empty(SB2->B2_DINVENT) .And. ;
				(((SB2->B2_DINVENT + SB1->B1_PERINV) < mv_par11) .Or. ;
				((SB2->B2_DINVENT + SB1->B1_PERINV) > mv_par12)))
				SB2->(dbSkip())
				Loop
			EndIf
			
			//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
			//� Verifica as consistencias de acordo com as perguntas         �
			//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
			If (SB2->B2_LOCAL < mv_par01) .Or. (SB2->B2_LOCAL > mv_par02)
				SB2->(dbSkip())
				Loop
			EndIf
			
			//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
			//� Verifica se o saldo estiver zerado (mv_par14 == 2 (Nao))     �
			//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
			If mv_par14 == 2 .And. SB2->B2_QATU == 0
				SB2->(dbSkip())
				Loop
			EndIf
			
			If Li > 55
				Cabec(Titulo,Cabec1,Cabec2,wnRel,Tamanho,nTipo)
			EndIf
			
			//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			//� Adiciona 1 ao contador de registros impressos         �
			//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			nCntImpr++
			
			f280ImpDet()
			
			If lCLocal .And. lImpLote .And.;
				SBF->(dbSeek(xFilial('SBF') + SB1->B1_COD + SB2->B2_LOCAL, .F.))
				Do While !SBF->(Eof()) .And. ;
					xFilial('SBF') + SB1->B1_COD + SB2->B2_LOCAL == SBF->BF_FILIAL + SBF->BF_PRODUTO + SBF->BF_LOCAL
					If Li > 55
						Cabec(Titulo,Cabec1,Cabec2,wnRel,Tamanho,nTipo)
						f280ImpDet()
					EndIf
					@ Li, 079 PSAY Left(SBF->BF_LOCALIZ, 15)
					@ Li, 085 PSAY Left(SBF->BF_LOTECTL, 10)
					@ Li, 096 PSAY Left(SBF->BF_NUMLOTE, 06)
					@ Li, 103 PSAY Left(SBF->BF_NUMSERI, 14) + " "
					@ Li, 120 PSAY cDet
					Li++
					SBF->(dbSkip())
				EndDo
			ElseIf lRastro .And. lImpLote .And.;
				SB8->(dbSeek(xFilial('SB8') + SB1->B1_COD + SB2->B2_LOCAL, .F.))
				cLoteAnt   := ""
				cCondicao1 := 'SB8->B8_FILIAL + SB8->B8_PRODUTO + SB8->B8_LOCAL + SB8->B8_LOTECTL ' + If(lRastroS,'+ SB8->B8_NUMLOTE','')
				Do While !SB8->(Eof()) .And. ;
					xFilial('SB8') + SB1->B1_COD + SB2->B2_LOCAL + SB8->B8_LOTECTL + If(lRastroS,SB8->B8_NUMLOTE,'') == &(cCondicao1)
					If Li > 55
						Cabec(Titulo,Cabec1,Cabec2,wnRel,Tamanho,nTipo)
						f280ImpDet()
					EndIf
					If !(cLoteAnt==SB8->B8_LOTECTL) .Or. lRastroS
						@ Li, 085 PSAY Left(SB8->B8_LOTECTL,10)
						@ Li, 096 PSAY If(lRastroS,Left(SB8->B8_NUMLOTE,06),'')+" "
						@ Li, 110 PSAY cDet
						cLoteAnt := SB8->B8_LOTECTL
						Li++
					Endif
					SB8->(dbSkip())
				EndDo
			Else
				If lImpLote
					@ Li, 148 PSAY cDet
				Else
					@ Li, 130 PSAY cDet
				EndIf
				Li++
			EndIf
			
			SB2->(dbSkip())
			
		EndDo
		
		SB1->(dbSkip())
		
	EndDo
EndIf
If Li # 80
	Roda(nCntImpr,cRodaTxt,Tamanho)
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Devolve a condicao original do arquivo principal             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea(cString)
dbSetOrder(1)
dbClearFilter()

SB1->(dbSetOrder(1))
SB2->(dbSetOrder(1))
SB8->(dbSetOrder(1))
SBF->(dbSetOrder(1))

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnRel)
Endif

MS_FLUSH()

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿯250ImpDet� Autor � Fernando Joly Siquini � Data � 22.09.98 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Impress�o do Detalhe com os Dados do Produto               낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � MATR280			                                          낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function f280ImpDet()

If lImpLote
	@ Li, 000 PSAY Left(SB1->B1_COD    , 15)
	@ Li, 016 PSAY Left(SB1->B1_CODBAR , 15)
	@ Li, 033 PSAY Left(SB1->B1_TIPO   , 02)
	@ Li, 036 PSAY Left(SB1->B1_GRUPO  , 04)
	@ Li, 042 PSAY Left(SB1->B1_XDESC  , 60)
	@ Li, 102 PSAY Left(SB1->B1_UM     , 02)
	@ Li, 105 PSAY Left(SB2->B2_LOCAL  , 02)
	@ Li, 109 PSAY Left(SB2->B2_LOCALIZ, 15)
Else
	@ Li, 000 PSAY Left(SB1->B1_COD    , 15)
	@ Li, 016 PSAY Left(SB1->B1_CODBAR , 15)
	@ Li, 033 PSAY Left(SB1->B1_TIPO   , 02)
	@ Li, 036 PSAY Left(SB1->B1_GRUPO  , 04)
	@ Li, 042 PSAY Left(SB1->B1_XDESC  , 65)
	@ Li, 109 PSAY Left(SB1->B1_UM     , 02)
EndIf

Return Nil


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿌280IMPEND� Autor � Larson Zordan         � Data � 23.11.01 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Chamada do Relatorio Para a opcao de Endereco+Produto      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � MATR280		                                              낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function A280ImpEnd(aOrd,lEnd,wnRel,cString,Titulo,Tamanho)

Local cRodaTxt   := 'PRODUTO(S)'
Local nCntImpr   := 0
Local ntipo      := 0
Local lRastro    := .F.
Local lRastroS   := .F.
Local lCLocal    := .F.
Local cDet       := '[            ]  [          ]   [            ]  [          ]   [            ]  [          ]'

SB1->(dbSetOrder(1))

dbSelectArea("SBE")
dbSetOrder(1)
dbGotop()
SetRegua(LastRec())

While !Eof() .And. BE_FILIAL == xFilial("SBE")
	
	If lEnd
		@ pRow()+1, 001 PSAY 'CANCELADO PELO OPERADOR'
		Exit
	EndIf
	
	IncRegua()
	
	If (BE_LOCAL < mv_par01) .Or. (BE_LOCAL > mv_par02)
		dbSkip()
		Loop
	EndIf
	
	SBF->(dbSetOrder(1))
	SBF->(dbSeek(xFilial('SBF')+SBE->BE_LOCAL+SBE->BE_LOCALIZ,.F.))
	Do While !SBF->(Eof()) .And. xFilial('SBF')+SBE->BE_LOCAL+SBE->BE_LOCALIZ == SBF->BF_FILIAL+SBF->BF_LOCAL+SBF->BF_LOCALIZ
		
		If lEnd
			@ pRow()+1, 001 PSAY 'CANCELADO PELO OPERADOR'
			lContinua := .F.
			Exit
		EndIf
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Verifica as consistencias de acordo com as perguntas         �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		If SBF->BF_PRODUTO < mv_par03 .Or. SBF->BF_PRODUTO > mv_par04
			SBF->(dbSkip())
			Loop
		EndIf
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Verifica se o saldo estiver zerado (mv_par14 == 2 (Nao))     �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		If mv_par14 == 2 .And. SBF->BF_QUANT == 0
			dbSkip()
			Loop
		EndIf
		
		lRastro  := Rastro(SBF->BF_PRODUTO)
		lRastroS := Rastro(SBF->BF_PRODUTO, 'S')
		lCLocal  := Localiza(SBF->BF_PRODUTO)
		
		SB1->(dbSeek(xFilial('SB1')+SBF->BF_PRODUTO,.F.))
		
		SB2->(dbSeek(xFilial('SB2')+SBF->BF_PRODUTO+SBF->BF_LOCAL,.F.))
		If (!Empty(SB2->B2_DINVENT) .And. ;
			(((SB2->B2_DINVENT + SB1->B1_PERINV) < mv_par11) .Or. ;
			((SB2->B2_DINVENT + SB1->B1_PERINV) > mv_par12)))
			SBF->(dbSkip())
			Loop
		EndIf
		
		If Li > 55
			Cabec(Titulo,Cabec1,Cabec2,wnRel,Tamanho,nTipo)
		EndIf
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Adiciona 1 ao contador de registros impressos         �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		nCntImpr++
		
		f280ImpDet()
		
		If lCLocal .And. lImpLote
			If Li > 55
				Cabec(Titulo,Cabec1,Cabec2,wnRel,Tamanho,nTipo)
				f280ImpDet()
			EndIf
			@ Li, 109 PSAY Left(SBF->BF_LOCALIZ, 15)
			@ Li, 125 PSAY Left(SBF->BF_LOTECTL, 10)
			@ Li, 136 PSAY Left(SBF->BF_NUMLOTE, 06)
			@ Li, 143 PSAY Left(SBF->BF_NUMSERI, 14)+" "
			@ Li, 153 PSAY cDet
			Li++
		ElseIf lRastro .And. lImpLote .And.;
			SB8->(dbSeek(xFilial('SB8') + SB1->B1_COD + SB2->B2_LOCAL, .F.))
			cCondicao1 := 'SB8->B8_FILIAL + SB8->B8_PRODUTO + SB8->B8_LOCAL + SB8->B8_LOTECTL ' + If(lRastroS,'+ SB8->B8_NUMLOTE','')
			Do While !SB8->(Eof()) .And. ;
				xFilial('SB8') + SB1->B1_COD + SB2->B2_LOCAL + SB8->B8_LOTECTL + If(lRastroS,SB8->B8_NUMLOTE,'') == &(cCondicao1)
				If Li > 55
					Cabec(Titulo,Cabec1,Cabec2,wnRel,Tamanho,nTipo)
					f280ImpDet()
				EndIf
				@ Li, 125 PSAY Left(SB8->B8_LOTECTL,10)
				@ Li, 136 PSAY If(lRastroS,Left(SB8->B8_NUMLOTE,06),'')+" "
				@ Li, 153 PSAY cDet
				Li++
				SB8->(dbSkip())
			EndDo
		Else
			If lImpLote
				@ Li, 153 PSAY cDet
			Else
				@ Li, 153 PSAY cDet
			EndIf
			Li++
		EndIf
		
		SBF->(dbSkip())
		
	EndDo
	
	SBE->(dbSkip())
	
EndDo

Return Nil
