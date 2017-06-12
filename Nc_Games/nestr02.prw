#INCLUDE "rwmake.CH"
#INCLUDE "PROTHEUS.CH"

User Function NESTR02

Local Titulo     := 'Saldos em Estoque'
Local cDesc1     := "Este programa ira' emitir um resumo dos saldos, em quantidade,"
Local cDesc2     := 'dos produtos em estoque.'
Local cDesc3     := ''
Local cString    := 'SB1'
Local aOrd       := {OemToAnsi(' Por Codigo         '),OemToAnsi(' Por Tipo           '),OemToAnsi(' Por Descricao    '),OemToAnsi(' Por Grupo        ')}
Local WnRel      := 'NESTR02'
Local nTotQuebra := nTotQuebr2 := 0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis tipo Local para SIGAVEI, SIGAPEC e SIGAOFI         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local aArea1	:= Getarea() 
Private limite           := 132
Private tamanho          := "G"
Private nTipo            := 18
Private aReturn  := {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 }

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis tipo Private para SIGAVEI, SIGAPEC e SIGAOFI       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private lVEIC   := UPPER(GETMV("MV_VEICULO"))=="S"
Private aSB1Cod := {}
Private aSB1Ite := {}
Private nCOL1	 := 0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis tipo Private padrao de todos os relatorios         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private nLastKey := 0
Private cPerg    := 'MTR240'

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria a Pergunta Nova no Sx1                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
PutSx1("MTR240","18","QTDE. na 2a. U.M. ?","CTD. EN 2a. U.M. ?","QTTY. in 2a. U.M. ?", "mv_chi", "N", 1, 0, 2,"C", "", "", "", "","MV_PAR18","Sim","Si","Yes", "","Nao","No","No", "", "", "", "", "", "", "", "", "", "", "", "", "")

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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
//� mv_par16     // Lista Somente Saldos Negativos                 		  �
//� mv_par17     // Descricao Produto : Cientifica / Generica      		  �
//� mv_par18   	 // QTDE. na 2a. U.M. ?     (Sim/Nao)                     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Ajustar o SX1 para SIGAVEI, SIGAPEC e SIGAOFI                �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

aSB1Cod	:= TAMSX3("B1_COD")
aSB1Ite	:= TAMSX3("B1_CODITE")

if lVEIC
	Tamanho  := "M"
	nCOL1		:= ABS(aSB1Cod[1] - aSB1Ite[1]) + 1 + aSB1Cod[1]
   DBSELECTAREA("SX1")
   DBSETORDER(1)
   DBSEEK(cPerg)
   DO WHILE SX1->X1_GRUPO == cPerg .AND. !SX1->(EOF())
      IF "PRODU" $ UPPER(SX1->X1_PERGUNT) .AND. UPPER(SX1->X1_TIPO) == "C" .AND. ;
      (SX1->X1_TAMANHO <> aSB1Ite[1] .OR. UPPER(SX1->X1_F3) <> "VR4")

         RECLOCK("SX1",.F.)
         SX1->X1_TAMANHO := aSB1Ite[1]
         SX1->X1_F3 := "VR4"
         DBCOMMIT()
         MSUNLOCK()
         
      ENDIF
      DBSKIP()
   ENDDO
   DBCOMMITALL()
   RESTAREA(aArea1)
else
   DBSELECTAREA("SX1")
   DBSETORDER(1)
   DBSEEK(cPerg)
   DO WHILE SX1->X1_GRUPO == cPerg .AND. !SX1->(EOF())
      IF "PRODU" $ UPPER(SX1->X1_PERGUNT) .AND. UPPER(SX1->X1_TIPO) == "C" .AND. ;
      (SX1->X1_TAMANHO <> aSB1Cod[1] .OR. UPPER(SX1->X1_F3) <> "SB1")

         RECLOCK("SX1",.F.)
         SX1->X1_TAMANHO := aSB1Cod[1]
         SX1->X1_F3 := "SB1"
         DBCOMMIT()
         MSUNLOCK()
         
      ENDIF
      DBSKIP()
   ENDDO
   DBCOMMITALL()
   RESTAREA(aArea1)
endif

Pergunte(cPerg,.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
WnRel := SetPrint(cString,WnRel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If mv_par18 == 1
   Tamanho := "G"
Endif 
If nLastKey == 27
	DBSELECTAREA(cString)
	dbClearFilter()
	Return Nil
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	DBSELECTAREA(cString)
	dbClearFilter()
	Return Nil
Endif

RptStatus({|lEnd| C240Imp(aOrd,@lEnd,WnRel,Titulo,Tamanho)},Titulo)

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � C240IMP  � Autor � Rodrigo de A. Sartorio� Data � 11.12.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Chamada do Relatorio                                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � MATR240													  낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
Static Function C240Imp(aOrd,lEnd,WnRel,Titulo,Tamanho)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

Local cRodaTxt   := 'REG(S)'
Local nCntImpr   := 0
Local nTipo      := 0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis locais exclusivas deste programa                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local lImpr      :=.F.
Local nSoma      := nSoma2    := 0
Local nTotSoma   := nTotSoma2 := 0
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
Local aArea
Local cFilOld    := '頰'
Local cCodAnt    := '頰'
Local cDesc 
Local lIsCient
Local cPict
Local nQtdBlq    := nQtdBlq2 := 0
Local nQuant     := 0.00
Local nQuant2    := 0.00

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis Locais utilizadas na montagem das Querys           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local cQuery     := ''

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Ajustar variaveis LOCAIS para SIGAVEI, SIGAPEC e SIGAOFI     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local cCodite    := ''

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Ajustar variaveis PRIVATE para SIGAVEI, SIGAPEC e SIGAOFI    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
PRIVATE XSB1			:= XFILIAL('SB1')
PRIVATE XSB2			:= XFILIAL('SB2')
PRIVATE XSB5			:= XFILIAL('SB5')

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis Private utilizadas na montagem das Querys          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private cAliasTOP  := ''

// Fernando 09/11/99 
If ( cPaisLoc=="CHI" )
	Tamanho := 'M'
	cPict   := "@E 999,999,999.99"
Else          
	cPict:= PesqPictQt(If(mv_par15==1,'B2_QATU','B2_QFIM'),15)
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis Private exclusivas deste programa                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Contadores de linha e pagina                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private Li         := 80
Private m_pag      := 1

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicializa os codigos de caracter Comprimido/Normal da impressora �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Adiciona a ordem escolhida ao Titulo do relatorio          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If Type('NewHead') # 'U'
	NewHead := AllTrim(NewHead)
	NewHead += ' (' + AllTrim(SubStr(aOrd[aReturn[8]],6,20)) + ')'
Else
	Titulo := AllTrim(Titulo)
	Titulo += ' (' + AllTrim(SubStr(aOrd[aReturn[8]],6,20)) + ')'
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Monta os Cabecalhos                                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cCabec1 := 'CODIGO          COD.BARRA       TP GRUP DESCRICAO NC GAMES                                           UM FL ALM   QUANTIDADE  '
cCabec2 := ''
							 //-- 123456789012345 12 1234 123456789012345678901234567890 12 12 12 999,999,999.99
							 //-- 0         1         2         3         4         5         6         7
							 //-- 012345678901234567890123456789012345678901234567890123456789012345678901234567890

if lVEIC
   cCabec1 := substr(cCabec1,1,aSB1Cod[1]) + SPACE(nCOL1) + substr(cCabec1,aSB1Cod[1]+1)
   if !Empty(cCabec2)
	   cCabec2 := substr(cCabec2,1,aSB1Cod[1]) + SPACE(nCOL1) + substr(cCabec2,aSB1Cod[1]+1)
	endif
endif


//-- Alimenta Array com Filiais a serem Pesquizadas
aFiliais := {}
nRegM0   := SM0->(Recno())
SM0->(DBSeek(cEmpAnt, .T.))
Do While !SM0->(Eof()) .And. SM0->M0_CODIGO == cEmpAnt
	If SM0->M0_CODFIL >= mv_par02 .And. SM0->M0_CODFIL <= mv_par03
		aAdd(aFiliais, SM0->M0_CODFIL)
	Endif
	SM0->(dbSkip())
End
SM0->(dbGoto(nRegM0))

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Processos de Inicia뇙o dos Arquivos Utilizados               �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
#IFDEF TOP

	cAliasTOP := CriaTrab(Nil, .F.)

	If mv_par17 == 1 // Desc. Cientifica
		dbSelectArea("SB5")
		dbSetOrder(1)
	Endif

	//旼컴컴컴커
	//� SELECT �
	//읕컴컴컴켸
	cQuery := "SELECT SB2.B2_COD COD"      // 01
	cQuery += ", SB1.B1_TIPO TIPO"         // 02
	cQuery += ", SB1.B1_GRUPO GRUPO"       // 03
	cQuery += ", SB1.B1_DESC DESCRI"       // 04
	cQuery += ", SB1.B1_UM UM"             // 05
	If mv_par18 == 1
	   cQuery += ", SB1.B1_SEGUM SEGUM"    // 06 
	Endif   

	If lVEIC
		cQuery += ", SB1.B1_CODITE CODITE" // 07
	Endif

	If mv_par01 == 1 //-- Aglutina por Armazem
		cQuery += ", SB2.B2_LOCAL LOC, SB2.B2_FILIAL FILIAL"
	Else  //-- Aglutina por Filial ou por Empresa
		cQuery += ", '**' LOC"
	EndIf	
	If  mv_par01 == 2 //-- Aglutina por Filial
    	cQuery += ", SB2.B2_FILIAL FILIAL"
    Endif 	
    If mv_par01 == 3  //-- Aglutina por Empresa
  	   cQuery += ", '**' FILIAL"
  	Endif   
	cQuery += ", SUM(SB2.B2_QATU) QATU, SUM(SB2.B2_QFIM) QFIM, SB2.B2_STATUS SITU"
	cQuery += ", SUM(SB2.B2_QTSEGUM) QTSEGUM, SUM(SB2.B2_QFIM2) QFIM2"

	//旼컴컴커
	//� FROM �
	//읕컴컴켸
	cQuery += (" FROM "+RetSqlName('SB2')+" SB2, "+RetSqlName('SB1')+" SB1")

	//旼컴컴컴�
	//� WHERE �
	//읕컴컴컴�

	cQuery += " WHERE"

	If ! lVEIC
		cQuery += ("     SB1.B1_COD >= '" + mv_par06 + "'")
		cQuery += (" AND SB1.B1_COD <= '" + mv_par07 + "'")
	ELSE
		cQuery += ("     SB1.B1_CODITE >= '" + mv_par06 + "'")
		cQuery += (" AND SB1.B1_CODITE <= '" + mv_par07 + "'")
	ENDIF
	
	If !Empty(xSB1)
		// cQuery += "SB1.B1_FILIAL>='"+mv_par02+"' AND SB1.B1_FILIAL<='"+mv_par03+"' AND "
		cQuery += (" AND SB1.B1_FILIAL >= '" + mv_par02 + "'")
		cQuery += (" AND SB1.B1_FILIAL <= '" + mv_par03 + "'")
	EndIf	

	cQuery += (" AND SB1.B1_TIPO  >='" + mv_par08 + "'")
	cQuery += (" AND SB1.B1_TIPO  <='" + mv_par09 + "'")
	cQuery += (" AND SB1.B1_GRUPO >='" + mv_par10 + "'")
	cQuery += (" AND SB1.B1_GRUPO <='" + mv_par11 + "'")
	cQuery += (" AND SB1.B1_DESC  >='" + mv_par12 + "'")
 	cQuery += (" AND SB1.B1_DESC  <='" + mv_par13 + "'")
	cQuery += (" AND SB2.B2_LOCAL >='" + mv_par04 + "'")
	cQuery += (" AND SB2.B2_LOCAL <='" + mv_par05 + "'")

	If mv_par16 == 1 .And. mv_par01 == 1//-- Somente Negativos
		If mv_par14 == 2 //-- Imprime Zerados
			If mv_par15 == 1 //-- Saldo Atual
				cQuery += " AND (SB2.B2_QATU < 0)"
			ElseIf mv_par15 == 2 //-- Saldo Final
				cQuery += " AND (SB2.B2_QFIM < 0)"
			EndIf
		Else //-- Nao Imprime Zerados
			If mv_par15== 1 //-- Saldo Atual
				cQuery += " AND (SB2.B2_QATU <= 0)"
			ElseIf mv_par15 == 2 //-- Saldo Final
				cQuery += " AND (SB2.B2_QFIM <= 0)"
			EndIf
		EndIf	
	ElseIf mv_par14 == 2 .And. mv_par01 == 1//-- Nao Imprime Zerados
		If mv_par15 == 1 //-- Saldo Atual
			cQuery += " AND (SB2.B2_QATU <> 0)"
		ElseIf mv_par15 == 2 //-- Saldo Final
			cQuery += " AND (SB2.B2_QFIM <> 0)"
		EndIf
	EndIf
	cQuery +=  " AND    SB1.B1_COD  = SB2.B2_COD"
	cQuery +=  " AND SB2.D_E_L_E_T_ = ' '"
	cQuery +=  " AND SB1.D_E_L_E_T_ = ' '"
	cQuery += (" AND SB2.B2_FILIAL  >='" + mv_par02 + "'")
	cQuery += (" AND SB2.B2_FILIAL  <='" + mv_par03 + "'")
    
	If xSB1 # Space(2) .AND. xSB2 # Space(2)    
		cQuery += " AND SB1.B1_FILIAL = SB2.B2_FILIAL"
	Endif   

	//旼컴컴컴컴커
	//� GROUP BY �
	//읕컴컴컴컴켸

	cQuery += " GROUP BY"
	If ! lVEIC
		cQuery += " SB2.B2_COD, SB1.B1_TIPO, SB1.B1_GRUPO"
	ELSE	
		cQuery += " SB1.B1_CODITE, SB2.B2_COD, SB1.B1_TIPO, SB1.B1_GRUPO"
	ENDIF

	cQuery += ", SB1.B1_DESC"
	cQuery += ", SB1.B1_UM"
    If mv_par18 == 1
       cQuery += ", SB1.B1_SEGUM"
    Endif   
	If mv_par01 == 1 //-- Aglutina por Armazem
		cQuery += ", SB2.B2_LOCAL, SB2.B2_FILIAL"
	EndIf
	If mv_par01 == 2 //-- Aglutina por Filial
		cQuery += ", SB2.B2_FILIAL"
	EndIf	
	If mv_par01 == 3 //-- Aglutina por Empresa
		cQuery += " "
	EndIf	
	cQuery += ", SB2.B2_STATUS"
      
	//旼컴컴컴컴커
	//� ORDER BY �
	//읕컴컴컴컴켸

	cQuery += " ORDER BY"

	If ! lVEIC
		If aReturn[8] == 4
			cQuery += " 3, 1"   // Por Grupo, Codigo
			cCampo := 'B1_GRUPO'
			cMens  := OemToAnsi('Grupo.........')
		ElseIf aReturn[8] == 3
			cQuery += " 4, 1"   // Por Descricao, Codigo
			cCampo := .T.
		ElseIf aReturn[8] == 2
			cQuery += " 2, 1"   // Por Tipo, Codigo
			cCampo := 'B1_TIPO'
			cMens  := OemToAnsi('Tipo..........')
		Else
			cQuery += " 1"      // Por Codigo
			cCampo := .T.
		Endif

   ELSE

		If aReturn[8] == 4
			cQuery += " 3, 6"   // Por Grupo, Codite
			cCampo := 'B1_GRUPO'
			cMens  := OemToAnsi('Grupo.........')
		ElseIf aReturn[8] == 3
			cQuery += " 4, 6"   // Por Descricao, Codite
			cCampo := .T.
		ElseIf aReturn[8] == 2
			cQuery += " 2, 6"   // Por Tipo, Codite
			cCampo := 'B1_TIPO'
			cMens  := OemToAnsi('Tipo..........')
		Else
			cQuery += " 6"      // Por Codite
			cCampo := .T.
		Endif

	ENDIF
	cQuery := ChangeQuery(cQuery)
	MsAguarde({|| dbUseArea(.T.,'TOPCONN', TCGenQry(,,cQuery), cAliasTOP,.F.,.T.)}, "Selecionando Registros ...")

	//-- Inicializa Variaveis e Contadores
	cFilOld	  := (cAliasTop)->FILIAL
	cCodAnt    := (cAliasTop)->COD
	cTipoAnt   := (cAliasTop)->TIPO
	cGrupoAnt  := (cAliasTop)->GRUPO

	If lVEIC
		cCodite    := (cAliasTop)->CODITE
	endif		


	nQtdProd   := 0
	nTotProd   := 0
	nTotProdBl := 0
	nTotQuebra := 0
	nTotQuebr2 := 0 // 2a.UM
	dbSelectArea(cAliasTop)
	Do While !(cAliasTop)->(Eof())

		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Processa Flltro de Usuario �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		dbSelectArea("SB1")
		dbsetorder(1)		
		If !dbSeek(XSB1 + (cAliasTop)->COD)
			(cAliasTop)->(dbSkip())
			Loop
		EndIf

		dbSelectArea(cAliasTop)
		
		If lEnd
			@ PROW()+1, 001 pSay OemToAnsi( 'CANCELADO PELO OPERADOR')
			Exit
		EndIf

		nQuant := 0.00
		nQuant2:= 0.00
		If mv_par15 == 3 // MOVIMENTACAO
			If AllTrim((cAliasTop)->FILIAL) == '**'
				For nX := 1 to Len(aFiliais)
					cFilAnt := aFiliais[nX]
					If Alltrim((cAliasTop)->LOC) == '**'
						aArea:=GetArea()
						dbSelectArea("SB2")
						dbSetOrder(1)
						dbSeek(cFilAnt + (cAliasTOP)->COD)
						While !Eof() .And. B2_FILIAL == cFilAnt .And. B2_COD == (cAliasTOP)->COD
						    If SB2->B2_LOCAL >= mv_par04  .And. SB2->B2_LOCAL <= mv_par05
							   nQuant += CalcEst((cAliasTOP)->COD,SB2->B2_LOCAL,dDataBase + 1, B2_FILIAL)[1]
					   		   If mv_par18==1
								   nQuant2+= CalcEst((cAliasTOP)->COD,SB2->B2_LOCAL,dDataBase + 1, B2_FILIAL)[7]
							   Endif	   
							Endif   
							dbSkip()
						Enddo
						RestArea(aArea)
					Else
						nQuant += CalcEst((cAliasTop)->COD, (cAliasTop)->LOC, dDataBase+1)[1]
						If mv_par18==1
							nQuant2+= CalcEst((cAliasTop)->COD, (cAliasTop)->LOC, dDataBase+1)[7]
						Endif	
					EndIf
				Next nX
			Else
				If Alltrim((cAliasTop)->LOC) == '**'
					aArea:=GetArea()
					dbSelectArea("SB2")
					dbSetOrder(1)
					dbSeek(cSeek:=(cAliasTop)->FILIAL + (cAliasTop)->COD)
					While !Eof() .And. B2_FILIAL + B2_COD == cSeek
						If SB2->B2_LOCAL >= mv_par04  .And. SB2->B2_LOCAL <= mv_par05 
  						   nQuant += CalcEst((cAliasTOP)->COD,SB2->B2_LOCAL,dDataBase + 1, B2_FILIAL)[1]
						   If mv_par18==1
	  						   nQuant2+= CalcEst((cAliasTOP)->COD,SB2->B2_LOCAL,dDataBase + 1, B2_FILIAL)[7]
	  					   Endif	   
  						Endif   
						dbSkip()
					Enddo
					RestArea(aArea)
				Else
					nQuant := CalcEst((cAliasTop)->COD, (cAliasTop)->LOC, dDataBase+1,(cAliasTop)->FILIAL)[1]
					If mv_par18==1
						nQuant2:= CalcEst((cAliasTop)->COD, (cAliasTop)->LOC, dDataBase+1,(cAliasTop)->FILIAL)[7]
					Endif	
				EndIf
			EndIf
		Else
			nQuant := If(mv_par15==1,(cAliasTop)->QATU, (cAliasTop)->QFIM)
			If mv_par18==1
				nQuant2:= If(mv_par15==1,(cAliasTop)->QTSEGUM, (cAliasTop)->QFIM2)
			Endif	
		EndIf	
		//� mv_par14     // imprime qtde zeradas 1=SIM ; 2=NAO
		If (mv_par14 == 1 .OR. ( mv_par14 <> 1 .and. alltrim(str(nQuant,16,2)) <> "0.00")) .And. ;
		   (mv_par16 <> 1 .Or. ( mv_par16 == 1 .and. If(mv_par14 <> 1,alltrim(str(nQuant,16,2)) < "0.00",alltrim(str(nQuant,16,2)) <= "0.00")))
			If Li > 55
				Cabec(Titulo,cCabec1,cCabec2,WnRel,Tamanho,nTipo)
			EndIf
			SB1->(dbSetOrder(1))
			SB1->(dbSeek(xFilial("SB1")+(cAliasTop)->COD))
			If ! lVEIC
				@ Li, 00 pSay (cAliasTop)->COD
				
				@ Li, 16 pSay SB1->B1_CODBAR
			Else
				@ Li, 00 pSay (cAliasTop)->CODITE + " " + (cAliasTop)->COD
			Endif	
	
			@ Li, 32 + nCOL1 pSay (cAliasTop)->TIPO
			@ Li, 35 + nCOL1 pSay (cAliasTop)->GRUPO
	
			cDesc := Left(SB1->B1_XDESC, 60) 

			@ Li, 40 + nCOL1 pSay cDesc
			@ Li, 100 + nCOL1 pSay (cAliasTop)->UM
			@ Li, 103 + nCOL1 pSay AllTrim((cAliasTop)->FILIAL)
			@ Li, 106 + nCOL1 pSay AllTrim((cAliasTop)->LOC)
			@ Li, 125 + nCOL1 pSay Transform( nQuant, cPict)
			If mv_par18==1
			   @ Li, 142 + nCOL1 pSay (cAliasTop)->SEGUM
			   @ Li, 142 + nCOL1 pSay nQuant2 Picture cPict
			   @ Li, 169 + nCOL1 pSay SubStr(If(SubStr((cAliasTop)->SITU,1,1)$'2', "Bloqueada ", "Liberada"), 1, 1)
			Else
			   @ Li, 139 + nCOL1 pSay SubStr(If(SubStr((cAliasTop)->SITU,1,1)$'2', "Bloqueada ", "Liberada"), 1, 1)
			Endif   
			Li++

			//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			//� Atualiza Variaveis e Contadores �
			//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			cFilOld	  := (cAliasTop)->FILIAL
			cCodAnt    := (cAliasTop)->COD
			cTipoAnt   := (cAliasTop)->TIPO
			cGrupoAnt  := (cAliasTop)->GRUPO
	
			If lVEIC
				cCodite    := (cAliasTop)->CODITE
			endif		
			
			nQtdProd   ++
			nTotProd   += nQuant
			nTotProdBl += If(SubStr(SITU,1,1) $'2', nQuant, 0)
			nTotQuebra += nQuant
			nTotQuebr2 += nQuant2 //2a.UM

		endif
		
		(cAliasTop)->(dbSkip())

		//旼컴컴컴컴컴컴컴컴�
		//� Totaliza Quebra �
		//읕컴컴컴컴컴컴컴컴�
		If !(nTotQuebra==0) .And. 	If(aReturn[8]==4,	!(cGrupoAnt==GRUPO) .Or. ((cAliasTop)->(EOF()) .And.Empty(cGrupoAnt)),If(aReturn[8]==2,!(cTipoAnt==TIPO),.F.)) .Or. ;
			(mv_par01 <> 1 .And. !(cFilOld == (cAliasTop)->FILIAL))
			@ Li, 100 + nCOL1 pSay If(Empty(cMens),SubStr('Total do ',1,5),'Total do ' + cMens) 
			@ Li, 114 + nCOL1 pSay Transform(nTotQuebra, cPict)
			If mv_par18 == 1
			   @ Li, 111 + nCOL1 pSay (cAliasTop)->SEGUM
			   @ Li, 114 + nCOL1 pSay Transform(nTotQuebr2, cPict)
			Endif
			Li += 2
			nTotQuebra := 0
			nTotQuebr2 := 0
		Endif
		
		//旼컴컴컴컴컴컴컴컴커
		//� Totaliza Produto �
		//읕컴컴컴컴컴컴컴컴켸
		If   ( (!lVEIC) .and. (!(cCodAnt == (cAliasTop)->COD)  ));
		.or. ( ( lVEIC) .and. (!((cCodite + cCodAnt) == (cAliasTop)->(CODITE + cod))))			
			If nQtdProd > 1 .And. Alltrim(Str(aReturn[8])) $ "1|3" //-- So' totaliza Produto se houver mais de 1
				If (!(nTotProd==0).Or.!(nTotProdBl==0))
					@ Li, 40 + nCOL1 pSay "(" + SubStr("Qtde. ",1,1)+ ") = " + OemToAnsi("Liberada  ") + OemToAnsi("Qtde. ") + Replicate('.',14)  
					@ Li, 93 + nCOL1 pSay Transform((nTotProd-nTotProdBl), cPict)
					If mv_par18 == 1
					   @ Li, 114 + nCOL1 pSay Transform(ConvUm(cCodAnt,(nTotProd-nTotProdBl),0,2), cPict)
					Endif
					Li++
					@ Li, 40 + nCOL1 pSay "(" + SubStr("Qtde. ",1,1)+ ") = " + OemToAnsi("Bloqueada ") + OemToAnsi("Qtde. ") + Replicate('.',14) 
					@ Li, 93 + nCOL1 pSay Transform(nTotProdBl, cPict)
					If mv_par18 == 1
					   @ Li, 114 + nCOL1 pSay Transform(ConvUm(cCodAnt,(nTotProdBl),0,2), cPict)
					Endif
					Li++
					If ! lVEIC
						@ Li, 40 + nCOL1 pSay OemToAnsi('Total do Produto') + Space(1) + AllTrim(Left(cCodAnt,15))
					ELSE
						@ Li, 40 pSay OemToAnsi('Total do Produto') + Space(1) + (cCodite  + " " + cCodAnt)
					ENDIF	
					@ Li, 93 + nCOL1 pSay Transform(nTotProd, cPict)
					If mv_par18 == 1
					   @ Li, 114 + nCOL1 pSay Transform(ConvUm(cCodAnt,nTotProd,0,2), cPict)
					Endif
					Li += 2
				EndIf
			EndIf	
			nQtdProd   := 0
			nTotProd   := 0
			nTotProdBl := 0
		EndIf

	EndDo    
	
#ELSE
	//-- SB2 (Saldos em Estoque)
	dbSelectArea('SB2')
	dbSetOrder(1)
	
	if ! lVEIC 	// Filtro para SIGAVEI, SIGAPEC e SIGAOFI
	
		cFiltroB2 := 'B2_COD>="'+mv_par06+'".And.B2_COD<="'+mv_par07+'".And.'
		cFiltroB2 += 'B2_LOCAL>="'+mv_par04+'".And.B2_LOCAL<="'+mv_par05+'"'
		If !Empty(xSB2)
			cFiltroB2 += '.And.B2_FILIAL>="'+mv_par02+'".And.B2_FILIAL<="'+mv_par03+'"'
		EndIf
	
	else
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Filtro para SIGAVEI, SIGAPEC e SIGAOFI                       �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	   // nao precisa do filtro para B2_COD nos SIGAVEI, SIGAPEC e SIGAOFI!
		// cFiltroB2 := 'B2_COD>="'+mv_par06+'".And.B2_COD<="'+mv_par07+'".And.'
		cFiltroB2 := 'B2_LOCAL>="'+mv_par04+'".And.B2_LOCAL<="'+mv_par05+'"'
		If !Empty(xSB2)
			cFiltroB2 += '.And.B2_FILIAL>="'+mv_par02+'".And.B2_FILIAL<="'+mv_par03+'"'
		EndIf
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
	dbSetIndex(cNomArqB2 + OrdBagExt())
	dbSetOrder(nIndB2 + 1)
	dbGoTop()

	//-- SB1 (Produtos)
	dbSelectArea('SB1')
	dbSetOrder(aReturn[8])

	if lVEIC 	// Filtro para SIGAVEI, SIGAPEC e SIGAOFI

		cFiltroB1 := 'B1_CODITE>="'+mv_par06+'".And.B1_CODITE<="'+mv_par07+'".And.'
		cFiltroB1 += 'B1_TIPO>="'+mv_par08+'".And.B1_TIPO<="'+mv_par09+'".And.'
		cFiltroB1 += 'B1_GRUPO>="'+mv_par10+'".And.B1_GRUPO<="'+mv_par11+'"'
		If !Empty(xSB1)
			cFiltroB1 += '.And.B1_FILIAL>="'+mv_par02+'".And.B1_FILIAL<="'+mv_par03+'"'
		EndIf
   	
		If aReturn[8] == 4
			cIndB1 := 'B1_GRUPO+B1_CODITE+B1_FILIAL'
			cCampo := 'B1_GRUPO'
			cMens  := OemToAnsi('Grupo.........')
		ElseIf aReturn[8] == 3
			cIndB1 := 'B1_DESC+B1_CODITE+B1_FILIAL'
			cCampo := .T.
		ElseIf aReturn[8] == 2
			cIndB1 := 'B1_TIPO+B1_CODITE+B1_FILIAL'
			cCampo := 'B1_TIPO'
			cMens  := OemToAnsi('Tipo..........')
		Else
			cIndB1 := 'B1_CODITE+B1_FILIAL'
			cCampo := .T.
		Endif

	ELSE

		cFiltroB1 := 'B1_COD>="'+mv_par06+'".And.B1_COD<="'+mv_par07+'".And.'
		cFiltroB1 += 'B1_TIPO>="'+mv_par08+'".And.B1_TIPO<="'+mv_par09+'".And.'
		cFiltroB1 += 'B1_GRUPO>="'+mv_par10+'".And.B1_GRUPO<="'+mv_par11+'"'
		If !Empty(xSB1)
			cFiltroB1 += '.And.B1_FILIAL>="'+mv_par02+'".And.B1_FILIAL<="'+mv_par03+'"'
		EndIf
	
		If aReturn[8] == 4
			cIndB1 := 'B1_GRUPO+B1_COD+B1_FILIAL'
			cCampo := 'B1_GRUPO'
			cMens  := OemToAnsi('Grupo.........')
		ElseIf aReturn[8] == 3
			cIndB1 := 'B1_DESC+B1_COD+B1_FILIAL'
			cCampo := .T.
		ElseIf aReturn[8] == 2
			cIndB1 := 'B1_TIPO+B1_COD+B1_FILIAL'
			cCampo := 'B1_TIPO'
			cMens  := OemToAnsi( 'Tipo..........') 
		Else
			cIndB1 := 'B1_COD+B1_FILIAL'
			cCampo := .T.
		Endif
	
	endif
	cNomArqB1 := Left(CriaTrab('',.F.),7) + 'b'
	IndRegua('SB1',cNomArqB1,cIndB1,,cFiltroB1,'Selecionando Registros...')
	nIndB1 := RetIndex('SB1')
	dbSetIndex(cNomArqB1 + OrdBagExt())
	dbSetOrder(nIndB1 + 1)
	dbGoTop()
	SetRegua(LastRec())

	cFilialDe := If(Empty(xSB2),xSB2,mv_par02)
	
	If aReturn[8] == 4
		DBSeek(mv_par10, .T.)
	ElseIf aReturn[8] == 3
		//-- Pesquisa Somente se a Descricao For Generica.
		If mv_par17 == 2
			DBSeek(mv_par12, .T.)
		Endif
	ElseIf aReturn[8] == 2
		DBSeek(mv_par08, .T.)
	Else
		DBSeek(mv_par06, .T.)
	Endif
	
	//-- 1� Looping no Arquivo Principal (SB1)
	Do While !SB1->(Eof()) .and. lContinua
	
		aProd  := {}
		aProd1 := {}
	
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		//� Verifica se imprime nome cientifico do produto. Se Sim    �
		//� verifica se existe registro no SB5 e se nao esta vazio    �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
		cDesc := SB1->B1_DESC
		lIsCient := .F.
		If mv_par17 == 1
			dbSelectArea("SB5")
			DBSeek(xSB5 + SB1->B1_COD)
			If Found() .and. !Empty(B5_CEME)
				cDesc := B5_CEME
				lIsCient := .T.
			EndIf
			dbSelectArea('SB1')
		Endif
		
		//-- Consiste Descri눯o De/At�
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
			@ PROW()+1, 001 pSay OemToAnsi('CANCELADO PELO OPERADOR') 
			Exit
		EndIf
		
		cQuebra1 := If(aReturn[8]==1.Or.aReturn[8]==3,.T.,&(cCampo))
		
		//-- 2� Looping no Arquivo Principal (SB1)
		Do While !SB1->(Eof()) .And. (cQuebra1 == If(aReturn[8]==1.Or.aReturn[8]==3,.T.,&(cCampo))) .And. lContinua
	
			//-- Incrementa R괾ua
			IncRegua()
	
			lImpr := .F.
	
			//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			//� Verifica se imprime nome cientifico do produto. Se Sim    �
			//� verifica se existe registro no SB5 e se nao esta vazio    �
			//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
			cDesc := SB1->B1_DESC
			lIsCient := .F.
			If mv_par17 == 1
				dbSelectArea("SB5")
				DBSeek(xSB5 + SB1->B1_COD)
				If Found() .and. !Empty(B5_CEME)
					cDesc := B5_CEME
					lIsCient := .T.
				EndIf
				dbSelectArea('SB1')
			Endif
			
			//-- Consiste Descri눯o De/At�
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
				
				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Localiza produto no Cadastro de ACUMULADOS DO ESTOQUE        �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				dbSelectArea('SB2')
				If mv_par01 == 3
					DBSeek(SB1->B1_COD + If(Empty(xSB2),xSB2,aFiliais[nX]), .T.)
				ElseIf mv_par01 == 2
					DBSeek(If(Empty(xSB2),xSB2,aFiliais[nX]) + SB1->B1_COD, .T.)
				Else
					DBSeek(SB1->B1_COD + If(Empty(xSB2),xSB2,aFiliais[nX]) + mv_par04, .T.)
				EndIf
				
				//-- 1� Looping no Arquivo Secund쟲io (SB2)
				Do While lContinua .And. !SB2->(Eof()) .And. B2_COD == SB1->B1_COD
				
					If mv_par01 == 3
						If Empty(xSB1)
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
	
					//-- 2� Looping no Arquivo Secund쟲io (SB2)
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
							If SM0->(DBSeek(cEmpAnt+SB2->B2_FILIAL, .F.))
								//-- Atualiza a Variavel utilizada pela fun눯o xFilial()
								If !(cFilAnt==SM0->M0_CODFIL)
									cFilAnt := SM0->M0_CODFIL
								EndIf	
							EndIf
						EndIf
	
						If lEnd
							@ PROW()+1, 001 pSay OemToAnsi( 'CANCELADO PELO OPERADOR')
							lContinua := .F.
							Exit
						EndIf
	
						//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
						//� Carrega array com dados do produto na data base.             �
						//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
						
						//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
						//� Verifica se devera ser impressa o produto zerado             �
						//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
						If If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])) == 0 .And. mv_par14 == 2 .Or. ;
						   If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])) > 0 .And. mv_par16 == 1 
							cCodAnt := SB2->B2_COD
							SB2->(dbSkip())
							If mv_par01 == 1 .And. SB2->B2_COD # cCodAnt .And. (If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])) <> 0 .And. mv_par14 == 2)
								If nQtdProd > 1
									lImpr := .T.
								Else
									nSoma    := 0
									nSoma2   := 0  // 2a.UM.
									nQtdProd := 0
								EndIf
							EndIf
							Loop
						EndIf
						
						//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
						//� Adiciona 1 ao contador de registros impressos         �
						//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
						If mv_par01 == 1
						
							If Li > 55
								Cabec(Titulo,cCabec1,cCabec2,WnRel,Tamanho,nTipo)
							EndIf
						
							if lVEIC
								@ Li, 00 pSay SB1->B1_CODITE + " " + SB1->B1_COD
							ELSE
								@ Li, 00 pSay B2_COD
							Endif

							@ Li, 16 + nCOL1 pSay fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_TIPO')
							@ Li, 19 + nCOL1 pSay fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_GRUPO')
							@ Li, 24 + nCOL1 pSay Left(If(lIsCient, cDesc,	fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_DESC')),30)
							@ Li, 55 + nCOL1 pSay fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_UM')
							@ Li, 58 + nCOL1 pSay B2_FILIAL
							@ Li, 61 + nCOL1 pSay B2_LOCAL
							@ Li, 63 + nCOL1 pSay Transform( If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1])), cPict)
							If mv_par18 == 1
                               @ Li, 81 + nCOL1 pSay fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_SEGUM')
   							   @ Li, 84 + nCOL1 pSay Transform( If(mv_par15==1,B2_QTSEGUM,If(mv_par15==2,B2_QFIM2,aSalProd[7])), cPict)
						 	   @ Li, 99 + nCOL1 pSay SubStr(If(SubStr(B2_STATUS,1,1)$"2","Bloqueada ","Liberada"),1,1)
						 	Else   
							   @ Li, 79 + nCOL1 pSay SubStr(If(SubStr(B2_STATUS,1,1)$"2","Bloqueada ","Liberada"),1,1)
						    Endif
							Li++
							nQtdProd ++
							If SubStr(B2_STATUS,1,1) $ "2"
	 							nQtdBlq += If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1]))
	 							If mv_par18 == 1 //2a.UM
		 							nQtdBlq2+= If(mv_par15==1,B2_QTSEGUM,If(mv_par15==2,B2_QFIM2,aSalProd[7]))
		 						Endif	
	 						EndIf
						EndIf
						         
						nSoma    += If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1]))
						nTotSoma += If(mv_par15==1,B2_QATU,If(mv_par15==2,B2_QFIM,aSalProd[1]))
						If mv_par18 == 1 //2a.UM
							nSoma2    += If(mv_par15==1,B2_QTSEGUM,If(mv_par15==2,B2_QFIM2,aSalProd[7]))
							nTotSoma2 += If(mv_par15==1,B2_QTSEGUM,If(mv_par15==2,B2_QFIM2,aSalProd[7]))
						Endif

						cFilOld := SB2->B2_FILIAL
						cCodAnt := SB2->B2_COD
	
						SB2->(dbSkip())
						
					EndDo
					
					If !(mv_par01 # 1 .And. (nSoma == 0 .And. mv_par14 == 2) .Or. (nSoma >= 0  .And. mv_par16 == 1))
						lImpr:=.T.
					EndIf
					
					If lImpr	
						If Li > 55
							Cabec(Titulo,cCabec1,cCabec2,WnRel,Tamanho,nTipo)
						EndIf
	
						If mv_par01 == 1
							If SB2->B2_COD # cCodAnt .And. ;
								(aReturn[8] # 2 .And. aReturn[8] # 4)
								If nQtdProd > 1
									@ Li, 24 + nCOL1 pSay "(" + SubStr("Qtde. ",1,1)+ ") = " + OemToAnsi("Liberada  ") + OemToAnsi("Qtde. ") + Replicate('.',14)
									@ Li, 63 + nCOL1 pSay Transform((nSoma-nQtdBlq), cPict)
									If mv_par18 == 1 //2a.UM
									   @ Li, 84 + nCOL1 pSay Transform((nSoma2-nQtdBlq2), cPict)
									Endif
									Li++
 									@ Li, 24 + nCOL1 pSay "(" + SubStr("Bloqueada ",1,1)+ ") = " + OemToAnsi("Qtde. ") + OemToAnsi("Bloqueada ") + Replicate('.',14)
									@ Li, 63 + nCOL1 pSay Transform(nQtdBlq, cPict)
									If mv_par18 == 1
									   @ Li, 84 + nCOL1 pSay Transform(nQtdBlq2, cPict)
                                    Endif
									Li++
				 					If ! lVEIC
										@ Li, 24 pSay OemToAnsi( 'Total do Produto') + Space(1) + AllTrim(Left(cCodAnt,15))
									Else
										@ Li, 24 pSay OemToAnsi( 'Total do Produto') + Space(1) + SB1->B1_CODITE  + " " + cCodAnt 
									Endif
									@ Li, 63 + nCOL1 pSay Transform(nSoma, cPict)
									If mv_par18 == 1 // 2a.UM
									   @ Li, 84 + nCOL1 pSay Transform(nSoma2, cPict)
									Endif
									Li += 2
									nQtdBlq := 0
									nQtdBlq2:= 0								
								EndIf	
								nSoma    := 0
								nSoma2   := 0 // 2a.UM
								nQtdProd := 0
							EndIf
						//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
						//� Verifica se devera ser impressa o produto zerado             �
						//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
						ElseIf !(nSoma == 0 .And. mv_par14 == 2) .Or. (nSoma >= 0  .And. mv_par16 == 1) 
							if lVEIC
								@ Li, 00 pSay SB1->B1_CODITE  + " " + SB1->B1_COD
							ELSE
								@ Li, 00 pSay cCodAnt
							ENDIF	
							@ Li, 16 + nCOL1 pSay fContSB1(cFilOld, cCodAnt, 'B1_TIPO')
							@ Li, 19 + nCOL1 pSay fContSB1(cFilOld, cCodAnt, 'B1_GRUPO')
							@ Li, 24 + nCOL1 pSay Left(If(lIsCient, cDesc,	fContSB1(cFilOld, cCodAnt, 'B1_DESC')),30)
							@ Li, 55 + nCOL1 pSay fContSB1(cFilOld, cCodAnt, 'B1_UM')
							@ Li, 58 + nCOL1 pSay If(mv_par01==2,cFilOld,'**')
							@ Li, 61 + nCOL1 pSay '**'
							@ Li, 63 + nCOL1 pSay Transform(nSoma, cPict)
							If mv_par18 == 1 //2a. UM
                               @ Li, 81 + nCOL1 pSay fContSB1(SB2->B2_FILIAL, SB2->B2_COD, 'B1_SEGUM')
							   @ Li, 84 + nCOL1 pSay Transform(nSoma2, cPict)
							Endif
							Li++
							nSoma := 0
							nSoma2:= 0
						EndIf
						
						lImpr := .F.
						
					EndIf
				EndDo
			
			Next nX
			                                      
			dbSelectArea('SB1')
			SB1->(dbSkip())
	
		EndDo
	
		If Li > 55
			Cabec(Titulo,cCabec1,cCabec2,WnRel,Tamanho,nTipo)
		EndIf
	
		If (aReturn[8] == 2 .Or. aReturn[8] == 4) .And. ;
			nTotSoma # 0
			@ Li, 40 + nCOL1 pSay 'Total do ' + cMens
			@ Li, 63 + nCOL1 pSay Transform(nTotSoma, cPict)
			If mv_par18 == 1 // 2a.UM
			   @ Li, 84 + nCOL1 pSay Transform(nTotSoma2, cPict)
			Endif
			Li += 2
			nTotSoma := 0
			nTotsoma2:= 0
		EndIf
	
	EndDo
#ENDIF


If Li # 80
	Roda(nCntImpr,cRodaTxt,Tamanho)
EndIf

//-- Retorna a Posi눯o Correta do SM0
SM0->(dbGoto(nRegM0))
//-- Reinicializa o Conteudo da Variavel cFilAnt
If !(cFilAnt==SM0->M0_CODFIL)	
	cFilAnt := SM0->M0_CODFIL
EndIf	

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Devolve as ordens originais dos arquivos                     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SB2")
dbClearFilter()
RetIndex('SB2')
dbSetOrder(1)

dbSelectArea("SB1")
dbClearFilter()
RetIndex('SB1')
dbSetOrder(1)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Apaga indices de trabalho                                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If File(cNomArqB2 += OrdBagExt())
	fErase(cNomArqB2)
EndIf	
If File(cNomArqB1 += OrdBagExt())
	fErase(cNomArqB1)
EndIf	

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(WnRel)
Endif

Ms_Flush()

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    � fContSB1 � Autor � Fernando Joly Siquini � Data � 13.10.98 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o � Procura produto em SB1 e retorna o conteudo do campo       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fContSB1( cChave, cCampo)                                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛ar긩etros� cFil   = Filial de procura                                 낢�
굇쿛ar긩etros� cCod   = Codido de procura                                 낢�
굇�          � cCampo = Campo cujo conte즔o se deseja retornar            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
#IFNDEF TOP
	Static Function fContSB1(cFil, cCod, cCampo)
	
	//-- Inicializa Variaveis
	Local cCont      := &('SB1->' + cCampo)
	Local cPesq      := ''
	Local nPos       := 0
	Local nOrdem     := SB1->(IndexOrd())
	Local nRecno     := SB1->(Recno())
	
	If Empty(xSB1) .And. !Empty(cFil)
		cFil := xSB1
	EndIf
	
	cPesq := cFil + cCod
	
	If cPesq == Nil .Or. cCampo == Nil
		Return cCont
	EndIf	
		
	SB1->(dbSetOrder(1))
	If SB1->(DBSeek(cPesq, .F.)) .And. (nPos := SB1->(FieldPos(Upper(cCampo)))) > 0
		cCont := SB1->(FieldGet(nPos))
	EndIf
		
	SB1->(dbSetOrder(nOrdem))
	SB1->(dbGoto(nRecno))
	
	Return cCont
#ENDIF
