#INCLUDE "rwmake.ch"

User Function NFatr06


Local Titulo     := 'Saldos no Estoque X Preco de venda'
Local cDesc1     := "Este programa ira' emitir um resumo dos saldos, em quantidade,"
Local cDesc2     := 'dos produtos em estoque.'
Local cDesc3     := ''
Local cString    := 'SB1'
Local WnRel      := 'NFAT06'
Local nLin       := 81
cCabec1 := OemToAnsi('CODIGO          DESCRICAO                                                       UM      QUANTIDADE              PRC.VENDA')
//--             123456789012345 12345678901234567890123456789012345678901234567890            
cCabec2 := OemToAnsi('CODIGO          DESCRICAO                                                       UM          PRC.VENDA')

//��������������������������������������������������������������Ŀ
//� Variaveis tipo Private padrao de todos os relatorios         �
//����������������������������������������������������������������
Private aReturn    := {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 }
Private nLastKey   := 0
Private cPerg      := 'NFAT06'
Private lEnd       := .F.
Private nomeprog   := "NFatr06"
Private wnrel      := "NFatr06"
Private Tamanho    := 'M'
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
//�����������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                  �
//� mv_par01     // Aglutina por: Almoxarifado / Filial / Empresa         �
//� mv_par02     // Filial de                                             �
//� mv_par03     // Filial ate                                            �
//� mv_par04     // Almoxarifado de                                       �
//� mv_par05     // Almoxarifado ate                                      �
//� mv_par06     // Produto de                                            �
//� mv_par07     // Produto ate                                           �
//� mv_par08     // tipo de                                               �
//� mv_par09     // tipo ate                                              �
//� mv_par10     // grupo de                                              �
//� mv_par11     // grupo ate                                             �
//� mv_par12     // descricao de                                          �
//� mv_par13     // descricao ate                                         �
//� mv_par14     // imprime qtde zeradas                                  �
//� mv_par15     // Saldo a considerar : Atual / Fechamento / Movimento   �
//� mv_par16     // Lista Somente Saldos Negativos                        �
//� mv_par17     // Descricao Produto : Cientifica / Generica             �
//� mv_par18     // Imprime Qtd em estoque (Se cliente nao)               �
//�������������������������������������������������������������������������
Pergunte(cPerg,.F.)

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
WnRel := SetPrint(cString,WnRel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.T.,"",.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
//	Set Filter to
	Return
Endif

//RptStatus({|lEnd| C240Imp(,@lEnd,WnRel,"Saldo X Preco de Venda",Tamanho)},"Saldo X Preco de Venda")
RptStatus({|| C240Imp(CCabec1,CCabec2,Titulo,nLin,wnrel) },Titulo)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � C240IMP  � Autor � Rodrigo de A. Sartorio� Data � 11.12.95 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relatorio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR240													  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function C240Imp(CCabec1,CCabec2,Titulo,nLin,wnrel)//(lEnd,WnRel,Titulo,Tamanho)

//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������

Local cRodaTxt   := 'REG(S)'
Local nCntImpr   := 0
Local nTipo      := 0

//��������������������������������������������������������������Ŀ
//� Variaveis locais exclusivas deste programa                   �
//����������������������������������������������������������������
Local lImpr      :=.F.
Local nSoma      := 0
Local nSavRec    := 0
Local nTotSoma   := 0
Local nX         := 0
Local nRegM0     := 0
Local nIndB1     := 0
Local nIndB2     := 0
Local nQtdProd   := 0
Local aSalProd   := {}
Local cFilialDe  := ''
Local cQuebra1   := ''
Local cCampo     := ''
Local cMens      := ''
Local aProd      := {}
Local aProd1     := {}
Local aProd2     := {}
Local aProd3     := {}
Local cFilOld    := '��'
Local cCodAnt    := '��'
Local cDesc 
Local lIsCient
Local cPict

cPict:= PesqPictQt(If(mv_par15==1,'B2_QATU','B2_QFIM'),16)

//��������������������������������������������������������������Ŀ
//� Variaveis Private exclusivas deste programa                  �
//����������������������������������������������������������������
Private cQuebra2   := ''
Private cCond2     := ''
Private cFiltroB1  := ''
Private cIndB1     := ''
Private aFiliais   := {}
Private cFiltroB2  := ''
Private cIndB2     := ''
Private lContinua  := .T.
Private cNomArqB1  := ''
Private cNomArqB2  := ''

//��������������������������������������������������������������Ŀ
//� Contadores de linha e pagina                                 �
//����������������������������������������������������������������
Private Li         := 80
Private m_pag      := 1

//�������������������������������������������������������������������Ŀ
//� Inicializa os codigos de caracter Comprimido/Normal da impressora �
//���������������������������������������������������������������������
nTipo := If(aReturn[4]==1,15,18)

//������������������������������������������������������������Ŀ
//� Adiciona a ordem escolhida ao Titulo do relatorio          �
//��������������������������������������������������������������

Titulo := "Saldo X Preco de Venda"

//��������������������������������������������������������������Ŀ
//� Monta os Cabecalhos                                          �
//����������������������������������������������������������������
//-- 123456789012345 12 1234 123456789012345678901234567890 12 12 12 999,999,999.99
//-- 0         1         2         3         4         5         6         7
//-- 012345678901234567890123456789012345678901234567890123456789012345678901234567890

//-- Alimenta Array com Filiais a serem Pesquizadas
aFiliais := {}
nRegM0   := SM0->(Recno())
SM0->(dbSeek(cEmpAnt, .T.))
Do While !SM0->(Eof()) .And. SM0->M0_CODIGO == cEmpAnt
	If SM0->M0_CODFIL >= mv_par02 .And. SM0->M0_CODFIL <= mv_par03
		aAdd(aFiliais, SM0->M0_CODFIL)
	Endif
	SM0->(dbSkip())
End
SM0->(dbGoto(nRegM0))

//��������������������������������������������������������������Ŀ
//� Processos de Inicia��o dos Arquivos Utilizados               �
//����������������������������������������������������������������

//-- SB2 (Saldos em Estoque)
dbSelectArea('SB2')
dbSetOrder(1)

cFiltroB2 := 'B2_COD>="'+mv_par06+'".And.B2_COD<="'+mv_par07+'".And.'
cFiltroB2 += 'B2_LOCAL>="'+mv_par04+'".And.B2_LOCAL<="'+mv_par05+'"'
If !Empty(xFilial('SB2'))
	cFiltroB2 += '.And.B2_FILIAL>="'+mv_par02+'".And.B2_FILIAL<="'+mv_par03+'"'
EndIf

If mv_par01 == 3
	cIndB2 := 'B2_COD + B2_FILIAL + B2_LOCAL'
ElseIf mv_par01 == 2
	cIndB2 := 'B2_FILIAL + B2_COD + B2_LOCAL'
Else
	cIndB2 := 'B2_COD + B2_FILIAL + B2_LOCAL'
EndIf	

cNomArqB2 := Left(CriaTrab('',.F.),7) + 'a'

IndRegua('SB2',cNomArqB2,cIndB2,,cFiltroB2,'Selecionando Registros...') 
nIndB2 := RetIndex('SB2')
#IFNDEF TOP
	dbSetIndex(cNomArqB2 + OrdBagExt())
#ENDIF
dbSetOrder(nIndB2 + 1)
dbGoTop()

//-- SB1 (Produtos)
dbSelectArea('SB1')
dbSetOrder(8) //aReturn[8])

cFiltroB1 := 'B1_COD>="'+mv_par06+'".And.B1_COD<="'+mv_par07+'".And.'
cFiltroB1 += 'B1_TIPO>="'+mv_par08+'".And.B1_TIPO<="'+mv_par09+'".And.'
cFiltroB1 += 'B1_GRUPO>="'+mv_par10+'".And.B1_GRUPO<="'+mv_par11+'"'
If !Empty(xFilial('SB1'))
	cFiltroB1 += '.And.B1_FILIAL>="'+mv_par02+'".And.B1_FILIAL<="'+mv_par03+'"'
EndIf

cIndB1 := 'B1_COD+B1_FILIAL'
cCampo := .T.

cNomArqB1 := Left(CriaTrab('',.F.),7) + 'b'

IndRegua('SB1',cNomArqB1,cIndB1,,cFiltroB1,'Selecionando Registros...') 
nIndB1 := RetIndex('SB1')
#IFNDEF TOP
	dbSetIndex(cNomArqB1 + OrdBagExt())
#ENDIF
dbSetOrder(8)//(nIndB1 + 1)
dbGoTop()

SetRegua(LastRec())

cFilialDe := If(Empty(xFilial('SB2')),xFilial('SB2'),mv_par02)

If aReturn[8] == 4
	dbSeek(mv_par10, .T.)
ElseIf aReturn[8] == 3
	//-- Pesquisa Somente se a Descricao For Generica.
	If mv_par17 == 2
		dbSeek(mv_par12, .T.)
	Endif
ElseIf aReturn[8] == 2
	dbSeek(mv_par08, .T.)
Else
	dbSeek(mv_par06, .T.)
Endif

//-- 1� Looping no Arquivo Principal (SB1)
Do While !SB1->(Eof()) .and. lContinua

	aProd  := {}
	aProd1 := {}

	//�����������������������������������������������������������Ŀ
	//� Verifica se imprime nome cientifico do produto. Se Sim    �
	//� verifica se existe registro no SB5 e se nao esta vazio    �
	//�������������������������������������������������������������
        cDesc    := SB1->B1_XDESC
        _cPrcVen := SB1->B1_PRV1
	lIsCient := .F.
	If mv_par17 == 1
		dbSelectArea("SB5")
		dbSeek(xFilial()+SB1->B1_COD)
		If Found() .and. !Empty(B5_CEME)
			cDesc := B5_CEME
			lIsCient := .T.
		EndIf
		dbSelectArea('SB1')
	Endif
	
	//-- Consiste Descri��o De/At�
	If cDesc < mv_par12 .Or. cDesc > mv_par13
		SB1->(dbSkip())
		Loop
	EndIf
	
	//-- Filtro do usuario
	If !Empty(aReturn[7]) .And. !&(aReturn[7])
		SB1->(dbSkip())
		Loop
	EndIf
		
	If lEnd
                @ PROW()+1, 001 pSay "CANCELADO PELO OPERADOR"
		Exit
	EndIf
	
	cQuebra1 := If(aReturn[8]==1.Or.aReturn[8]==3,.T.,&(cCampo))
	
	//-- 2� Looping no Arquivo Principal (SB1)
	Do While !SB1->(Eof()) .And. (cQuebra1 == If(aReturn[8]==1.Or.aReturn[8]==3,.T.,&(cCampo))) .And. lContinua

		//-- Incrementa R�gua
		IncRegua()

		lImpr := .F.

		//�����������������������������������������������������������Ŀ
		//� Verifica se imprime nome cientifico do produto. Se Sim    �
		//� verifica se existe registro no SB5 e se nao esta vazio    �
		//�������������������������������������������������������������
                cDesc := SB1->B1_XDESC
                _cPrcVen := SB1->B1_PRV1
		lIsCient := .F.
		If mv_par17 == 1
			dbSelectArea("SB5")
			dbSeek(xFilial()+SB1->B1_COD)
			If Found() .and. !Empty(B5_CEME)
				cDesc := B5_CEME
				lIsCient := .T.
			EndIf
			dbSelectArea('SB1')
		Endif
		
		//-- Consiste Descri��o De/At�
		If cDesc < mv_par12 .Or. cDesc > mv_par13
			SB1->(dbSkip())
			Loop
		EndIf
		
		//-- Filtro do usuario
		If !Empty(aReturn[7]) .And. !&(aReturn[7])
			SB1->(dbSkip())
			Loop
		EndIf

		For nX := 1 to Len(aFiliais)
			
			IF !lContinua
				Exit
			Endif
			
			//��������������������������������������������������������������Ŀ
			//� Localiza produto no Cadastro de ACUMULADOS DO ESTOQUE        �
			//����������������������������������������������������������������
			dbSelectArea('SB2')
			If mv_par01 == 3
				dbSeek(SB1->B1_COD + If(Empty(xFilial('SB2')),xFilial('SB2'),aFiliais[nX]), .T.)
			ElseIf mv_par01 == 2
				dbSeek(If(Empty(xFilial('SB2')),xFilial('SB2'),aFiliais[nX]) + SB1->B1_COD, .T.)
			Else
				dbSeek(SB1->B1_COD + If(Empty(xFilial('SB2')),xFilial('SB2'),aFiliais[nX]) + mv_par04, .T.)
			EndIf
			
			//-- 1� Looping no Arquivo Secund�rio (SB2)
			Do While lContinua .And. !SB2->(Eof()) .And. B2_COD == SB1->B1_COD
			
				If mv_par01 == 3
					If Empty(xFilial('SB1'))
						cQuebra2  := B2_COD
						cCond2	 := 'B2_COD == cQuebra2'
					Else
						cQuebra2  := B2_COD + B2_FILIAL
						cCond2	 := 'B2_COD + B2_FILIAL == cQuebra2'
					EndIf	
				ElseIf mv_par01 == 2
					cQuebra2 := B2_FILIAL + B2_COD
                                        cCond2   := 'B2_FILIAL + B2_COD == cQuebra2'
				Else
					cQuebra2 := B2_COD + B2_FILIAL + B2_LOCAL
					cCond2   := 'B2_COD + B2_FILIAL + B2_LOCAL == cQuebra2'
				EndIf
				
				//-- N�o deixa o mesmo Filial/Produto passar mais de 1 vez
				If Len(aProd) <= 4096
					If Len(aProd) == 0 .Or. Len(aProd[Len(aProd)]) == 4096
						aAdd(aProd, {})
					EndIf
					If aScan(aProd[Len(aProd)], cQuebra2) > 0
						SB2->(dbSkip())
						Loop
					Else
						aAdd(aProd[Len(aProd)], cQuebra2)
					EndIf
				Else
					If Len(aProd1) == 0 .Or. Len(aProd1[Len(aProd1)]) == 4096
						aAdd(aProd1, {})
					EndIf
					If aScan(aProd1[Len(aProd1)], cQuebra2) > 0
						SB2->(dbSkip())
						Loop
					Else
						aAdd(aProd1[Len(aProd1)], cQuebra2)
					EndIf					
				EndIf

				//-- 2� Looping no Arquivo Secund�rio (SB2)
				Do While lContinua .And. !SB2->(Eof()) .And. &(cCond2)

					If aReturn[8] == 2 //-- Tipo
						If SB1->B1_TIPO # fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_TIPO')
							SB2->(dbSkip())
							Loop
						EndIf
					ElseIf aReturn[8] == 4 //-- Grupo
						If SB1->B1_GRUPO # fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_GRUPO')
							SB2->(dbSkip())
							Loop
						EndIf
					EndIf
	
					If !Empty(SB2->B2_FILIAL)
						//-- Posiciona o SM0 na Filial Correta
						If SM0->(dbSeek(cEmpAnt+SB2->B2_FILIAL, .F.))
							//-- Atualiza a Variavel utilizada pela fun��o xFilial()
							If !(cFilAnt==SM0->M0_CODFIL)
								cFilAnt := SM0->M0_CODFIL
							EndIf	
						EndIf
					EndIf

					If lEnd
                        @ PROW()+1, 001 pSay OemToAnsi("CANCELADO PELO OPERADOR")
						lContinua := .F.
						Exit
					EndIf

					//��������������������������������������������������������������Ŀ
					//� Carrega array com dados do produto na data base.             �
					//����������������������������������������������������������������
					IF mv_par15 > 2
						//-- Verifica se o SM0 esta posicionado na Filial Correta
						If !Empty(SB2->B2_FILIAL) .And. !(cFilAnt==SB2->B2_FILIAL)
							aSalProd := {0,0,0,0,0,0,0}
						Else
							aSalProd := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,dDataBase+1)
						EndIf	
					Else
						aSalProd := {0,0,0,0,0,0,0}
					Endif
					
					//��������������������������������������������������������������Ŀ
					//� Verifica se devera ser impressa o produto zerado             �
					//����������������������������������������������������������������
					If If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])) == 0 .And. mv_par14 == 2 .Or. ;
					   If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])) >= 0 .And. mv_par16 == 1 
						cCodAnt := SB2->B2_COD
						SB2->(dbSkip())
						If mv_par01 == 1 .And. SB2->B2_COD # cCodAnt
							If nQtdProd > 1
								lImpr := .T.
							Else
								nSoma    := 0
								nQtdProd := 0
							EndIf
						EndIf
						Loop
					EndIf
					
					//�������������������������������������������������������Ŀ
					//� Adiciona 1 ao contador de registros impressos         �
					//���������������������������������������������������������
					If mv_par01 == 1
					
						If Li > 55
							Cabec("Saldo X Preco de Venda",IIF(mv_par18 == 1,cCabec1,cCabec2),"",nomeprog,Tamanho,nTipo)
						EndIf
					    IF mv_par18 == 1 // Imprime Quantidade em estoque com preco de venda
							@ Li, 00 pSay SB1->B1_COD
                        	@ Li, 16 pSay Left(SB1->B1_XDESC,65)
                        	@ Li, 81 pSay SB1->B1_UM
                        	@ Li, 83 pSay Transform( If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])), cPict)
                        	@ Li, 105 pSay _cPrcVen Picture "@E 999,999,999.99"
							Li++					
							nQtdProd ++
						Else
							@ Li, 00 pSay SB1->B1_COD //B2_COD
                        	@ Li, 16 pSay Left(SB1->B1_XDESC,65) //Left(If(lIsCient, cDesc,  fContSB1(SB2->B2_FILIAL, cCodAnt, 'B1_XDESC')),65)
                        	@ Li, 81 pSay SB1->B1_UM  //fContSB1(SB2->B2_FILIAL, cCodAnt, 'B1_UM')
                        	@ Li, 83 pSay _cPrcVen Picture "@E 999,999,999.99"
							Li++					
							nQtdProd ++
						EndIF	
					EndIf
					
					nSoma += If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1]))
					nTotSoma += If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1]))
					
					cFilOld := SB2->B2_FILIAL
					cCodAnt := SB2->B2_COD

					SB2->(dbSkip())
					
				EndDo
				
				If !(mv_par01 # 1 .And. (nSoma == 0 .And. mv_par14 == 2) .Or. (nSoma >= 0  .And. mv_par16 == 1))
					lImpr:=.T.
				EndIf
				
				If lImpr	
					If Li > 55
						Cabec("Saldo X Preco de Venda",IIF(mv_par18 == 1,cCabec1,cCabec2),"",nomeprog,Tamanho,nTipo)
					EndIf

					If mv_par01 == 1
						If SB2->B2_COD # cCodAnt .And. ;
							(aReturn[8] # 2 .And. aReturn[8] # 4)
							If nQtdProd > 1
                                @ Li, 24 pSay OemToAnsi("Total do Produto") + Space(1) + AllTrim(Left(cCodAnt,15)) + Space(1) + Replicate('.',21-Len(AllTrim(Left(cCodAnt,15)))) 
								@ Li, 66 pSay Transform(nSoma, cPict)
								Li += 2
							EndIf	
							nSoma    := 0
							nQtdProd := 0
						EndIf
					//��������������������������������������������������������������Ŀ
					//� Verifica se devera ser impressa o produto zerado             �
					//����������������������������������������������������������������
					ElseIf !(nSoma == 0 .And. mv_par14 == 2) .Or. (nSoma >= 0  .And. mv_par16 == 1) 
						IF mv_par18 == 1 // Imprime Quantidade em estoque com preco de venda
							@ Li, 00 pSay cCodAnt
                        	@ Li, 16 pSay Left(SB1->B1_XDESC,65) //Left(If(lIsCient, cDesc,  fContSB1(SB1->B1_FILIAL, SB1->B1_COD, 'B1_XDESC')),65)
                        	@ Li, 81 pSay SB1->B1_UM //fContSB1(SB2->B2_FILIAL, cCodAnt, 'B1_UM')
                        	@ Li, 83 pSay Transform( If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])), cPict)
                        	@ Li, 105 pSay _cPrcVen Picture "@E 999,999,999.99"
							Li++
							nSoma := 0
						Else
							@ Li, 00 pSay cCodAnt
                        	@ Li, 16 pSay Left(SB1->B1_XDESC,65) //Left(If(lIsCient, cDesc,  fContSB1(SB1->B1_FILIAL, cCodAnt, 'B1_XDESC')),65)
                        	@ Li, 81 pSay SB1->B1_UM //fContSB1(SB2->B2_FILIAL, cCodAnt, 'B1_UM')
                        	@ Li, 83 pSay _cPrcVen Picture "@E 999,999,999.99"                        	
      						Li++
							nSoma := 0
						EndIF	
					EndIf
					
					lImpr := .F.
					
				EndIf
			EndDo
		
		Next nX
		
		dbSelectArea('SB1')
		SB1->(dbSkip())

	EndDo

	If Li > 55
		Cabec("Saldo X Preco de Venda",IIF(mv_par18 == 1,cCabec1,cCabec2),"",nomeprog,Tamanho,nTipo)
	EndIf

	If (aReturn[8] == 2 .Or. aReturn[8] == 4) .And. ;
		nTotSoma # 0
                @ Li, 40 pSay "Total do " + cMens
		@ Li, 66 pSay Transform(nTotSoma, cPict)
		Li += 2
		nTotSoma := 0
	EndIf

EndDo

If Li # 80
	Roda(nCntImpr,cRodaTxt,Tamanho)
EndIf

//-- Retorna a Posi��o Correta do SM0
SM0->(dbGoto(nRegM0))
//-- Reinicializa o Conteudo da Variavel cFilAnt
If !(cFilAnt==SM0->M0_CODFIL)	
	cFilAnt := SM0->M0_CODFIL
EndIf	

//��������������������������������������������������������������Ŀ
//� Devolve as ordens originais dos arquivos                     �
//����������������������������������������������������������������
RetIndex('SB2')
Set Filter to

RetIndex('SB1')
Set Filter to

//��������������������������������������������������������������Ŀ
//� Apaga indices de trabalho                                    �
//����������������������������������������������������������������
If File(cNomArqB2 += OrdBagExt())
	fErase(cNomArqB2)
EndIf	
If File(cNomArqB1 += OrdBagExt())
	fErase(cNomArqB1)
EndIf	

//��������������������������������������������������������������Ŀ
//� Devolve a condicao original dos arquivos principal           �
//����������������������������������������������������������������
dbSelectArea('SB1')
Set Filter To
dbSetOrder(1)

dbSelectArea('SB2')
Set Filter To
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(WnRel)
Endif

Ms_Flush()

Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � fContSB1 � Autor � Fernando Joly Siquini � Data � 13.10.98 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Procura produto em SB1 e retorna o conteudo do campo       ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � fContSB1( cChave, cCampo)                                  ���
�������������������������������������������������������������������������Ĵ��
���Par�metros� cFil   = Filial de procura                                 ���
���Par�metros� cCod   = Codido de procura                                 ���
���          � cCampo = Campo cujo conte�do se deseja retornar            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function fContSB1(cFil, cCod, cCampo)
	
//-- Inicializa Variaveis
Local cCont      := &('SB1->' + cCampo)
Local cPesq      := ''
Local nPos       := 0
Local nOrdem     := SB1->(IndexOrd())
Local nRecno     := SB1->(Recno())

If Empty(xFilial('SB1')) .And. !Empty(cFil)
	cFil := xFilial('SB1')
EndIf

cPesq := cFil + cCod

If cPesq == Nil .Or. cCampo == Nil
	Return cCont
EndIf	
	
SB1->(dbSetOrder(1))
If SB1->(dbSeek(cPesq, .F.)) .And. (nPos := SB1->(FieldPos(Upper(cCampo)))) > 0
	cCont := SB1->(FieldGet(nPos))
EndIf
	
SB1->(dbSetOrder(nOrdem))
SB1->(dbGoto(nRecno))

Return cCont
