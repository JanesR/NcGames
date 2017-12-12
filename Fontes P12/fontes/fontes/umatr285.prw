#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR285  ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 20/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem dos itens inventariados                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function UMATR285()
Local cPerg:='UNCMATR285'     

Private Enter:=Chr(13)+Chr(10)
Private nHdl
Private cPathExcel  	:= "c:\relatorios\"
Private cExtExcel   	:= ".xls"
//Private cPathArq		:=StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Private cPathArq		:=""
Private cArqXls	   :=E_Create(,.F.)

AjustaSX1(cPerg)  

MATR285R3(cPerg)


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR285R3³ Autor ³ Eveli Morasco         ³ Data ³ 05/02/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Listagem dos itens inventariados                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo Pim.³04/12/97³07906A³Definir a moeda a ser utilizada(mv_par10) ³±±
±±³Marcelo Pim.³09/12/97³07618A³Ajuste no posicionamento inicial do B7 p/ ³±±
±±³            ³        ³      ³nao utilizar o Local padrao.              ³±±
±±³Fernando J. ³23/09/98³06744A³Incluir informa‡”oes de LOTE, SUB-LOTE e  ³±±
±±³            ³        ³      ³NUMERO DE SERIE.                          ³±±
±±³Rodrigo Sar.³17/11/98³18459A³Acerto na impressao qdo almoxarifado CQ   ³±±
±±³Cesar       ³30/03/99³20706A³Imprimir Numero do Lote                   ³±±
±±³Cesar       ³30/03/99³XXXXXX³Manutencao na SetPrint()                  ³±±
±±³Fernando Jol³20/09/99³19581A³Incluir pergunta "Imprime Lote/Sub-Lote?" ³±±
±±³Patricia Sal³30/12/99³XXXXXX³Acerto LayOut (Doc. 12 digitos);Troca da  ³±±
±±³            ³        ³      ³PesqPictQt() pela PesqPict().             ³±±
±±³Marcos Hirak³12/12/03³XXXXXX³Imprimir B1_CODITO quando for gestão de   ³±±
±±³            ³        ³      ³Concessionárias ( MV_VEICULO = "S")       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MATR285R3(cPerg)
Local Tamanho 
Local Titulo  := 'Listagem dos Itens Inventariados'
Local cDesc1  := 'Emite uma relacao que mostra o saldo em estoque e todas as'
Local cDesc2  := 'contagens efetuadas no inventario. Baseado nestas duas in-'
Local cDesc3  := 'formacoes ele calcula a diferenca encontrada.'
Local cString := 'SB1'
Local nTipo   := 0
Local aOrd    := {OemToAnsi(' Por Codigo'),OemToAnsi('Por Tipo'),OemToAnsi('Por Grupo'),OemToAnsi('Por Descricao'),OemToAnsi('Por Local')}		//' Por Codigo    '###' Por Tipo      '###' Por Grupo   '###' Por Descricao '###' Por Local    '
Local wnRel   := 'UMATR285'
Private aSB1Cod := {}
Private aSB1Ite := {}
Private nCOL1	 := 0
Private aReturn  := {OemToAnsi('Zebrado'), 1,OemToAnsi('Administracao'), 2, 2, 1, '',1 }   //###
Private nLastKey := 0
Private lVEIC		:=.F.

//AjustaSX1(cPerg)
Pergunte(cPerg,.F.)


Tamanho := 'G'
wnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey == 27
	dbClearFilter()
	Return Nil
Endif

SetDefault(aReturn,cString)
           
If nLastKey == 27
	dbClearFilter()
	Return Nil
Endif

RptStatus({|lEnd| C285Imp(aOrd,@lEnd,wnRel,cString,titulo,Tamanho)},titulo)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C285IMP  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 12.12.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR285                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C285Imp(aOrd,lEnd,WnRel,cString,titulo,Tamanho)
Local nSB7Cnt  := 0
Local i		   := 0
Local nTotal   := 0
Local nTotVal  := 0
Local nSubVal  := 0
Local nCntImpr := 0
Local cAnt     := '',cSeek:='',cCompara :='',cLocaliz:='',cNumSeri:='',cLoteCtl:='',cNumLote:=''
Local cRodaTxt := 'PRODUTO(S)'
Local aSaldo   := {}
Local aSalQtd  := {}
Local aCM      := {}
Local lQuery   := .F.
Local cQuery   := ""
Local cQueryB1 := ""
Local aStruSB1 := {}
Local aStruSB2 := {}
Local aStruSB7 := {}
Local aRegInv  := {}
Local cAliasSB1:= "SB1"
Local cAliasSB2:= "SB2"
Local cAliasSB7:= "SB7"
Local cProduto := ""
Local cLocal   := ""
Local lFirst   := .T.
Local nX       := 0
Local lImprime := .T.
Local lContagem:=(SB7->(FieldPos("B7_CONTAGE")) > 0) .And. (SB7->(FieldPos("B7_ESCOLHA")) > 0) .And. (SB7->(FieldPos("B7_OK")) > 0) .And. SuperGetMv('MV_CONTINV',.F.,.F.)
Local cNomArq	:= ""
Local cKey		:= ""
Local cLocCQ	:= GetMV("MV_CQ")
Local cAliasQry	:=GetNextAlias()
Local nTotQtdInv:=0
Local nTotQtdSis:=0
Local nSaldoEst:=0
Local cB7Armazem:=""
Local nTotLine:=0

Private	lLocCQ	:=.T.
Private cCondicao := '!Eof()'
Private Li    := 80
Private m_Pag := 1
nTipo := If(aReturn[4]==1,15,18)  


cDoProd		:="               "
cAteProd		:="ZZZZZZZZZZZZZZZ"

nDaMoeda			:=1
nImpLoteZerado :=2
nCustoMedio 	:=1
nImpEndereco 	:=2
nListaProd 		:=3
cNomeDoc       :=mv_par01
cArmazem			:=mv_par02
cNoArmazem		:=""
cTipo				:=""
cNoTipo			:=""
//lGerarExcel		:=(mv_par03==1)
dDtEstq:=MsDate()
Titulo :=AllTrim(Titulo)+' (' + AllTrim(aOrd[aReturn[8]]) + ')'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1 := 'CODIGO          DESCRICAO                TP GRP  UM AL DOCUMENTO            QUANTIDADE         QTD NA DATA  _______________DIFERENCA_____________'
Cabec2 := '                                                                          INVENTARIADA       DO INVENTARIO          QUANTIDADE              VALOR'
//--                  123456789012345 123456789012345678901234 12 1234 12 12 123456789012 999.999.999.999,99  999.999.999.999,99  999.999.999.999,99 999.999.999.999,99
//--                  0         1         2         3         4         5         6         7         8         9        10        11        12        13        14
//--                  0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678012345

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os Arquivos e Ordens a serem utilizados           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHdl := FCreate(cPathArq+cArqXls+cExtExcel)

R285Cabec()
R285PASTA("1")//Produto Inventarioado

dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB7')
dbSetOrder(1)

dbSelectArea('SB1')
SetRegua(LastRec())


	If aReturn[8] == 2
		dbSetOrder(2) //-- Tipo
	ElseIf aReturn[8] == 3
		If lVEIC
			dbSetOrder(7) //--  B1_FILIAL+B1_GRUPO+B1_CODITE
		Else
			dbSetOrder(4) //-- Grupo
		EndIf	
	ElseIf aReturn[8] == 4
		dbSetOrder(3) //-- Descricao
	ElseIf aReturn[8] == 5
		If lVEIC
			cKey    := ' B1_FILIAL, B1_LOCPAD, B1_CODITE'
		Else
			cKey    := ' B1_FILIAL, B1_LOCPAD, B1_COD'
		EndIf	
		cKey    := Upper(cKey)
	Else
		If lVEIC
			cKey    := ' B1_FILIAL, B1_CODITE'
			cKey    := Upper(cKey)
		Else
		dbSetOrder(1) //-- Codigo
		EndIf	
	EndIf

	lQuery 	  := .T.
	aStruSB1  := SB1->(dbStruct())
	aStruSB2  := SB2->(dbStruct())
	aStruSB7  := SB7->(dbStruct())

	cAliasSB1 := "R285IMP"
	cAliasSB2 := "R285IMP"
	cAliasSB7 := "R285IMP"

    If Empty(aReturn[7])
		cQuery    := "SELECT "
		cQuery    += "SB1.R_E_C_N_O_ SB1REC, "
		cQuery    += "SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_LOCPAD, SB1.B1_TIPO, SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM , "
		If lVEIC
			cQuery    += "SB1.B1_CODITE , "
		EndIf
    Else
		cQueryB1    += "SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_LOCPAD, SB1.B1_TIPO, SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM , "
		If lVEIC
			cQueryB1+= "SB1.B1_CODITE , "
		EndIf
    	cQuery	  := "SELECT "
		cQuery    += "SB1.R_E_C_N_O_ SB1REC, "
        //Adiciona os campos do filtro na Query
    	cQuery    += cQueryB1 + A285QryFil("SB1",cQueryB1,aReturn[7])
    EndIf	
	cQuery    += "SB2.R_E_C_N_O_ SB2REC, "
	cQuery    += "SB2.B2_FILIAL, SB2.B2_COD, SB2.B2_LOCAL, SB2.B2_DINVENT, "
	cQuery    += "SB7.R_E_C_N_O_ SB7REC, "
	cQuery    += "SB7.B7_FILIAL, SB7.B7_COD, SB7.B7_LOCAL, SB7.B7_DATA, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE, SB7.B7_DOC, SB7.B7_QUANT "
	If lContagem
		cQuery += " ,SB7.B7_ESCOLHA ,SB7.B7_CONTAGE " 				
	EndIf
	cQuery    += "FROM "
	cQuery    += RetSqlName("SB1")+" SB1, "
	cQuery    += RetSqlName("SB2")+" SB2, "
	cQuery    += RetSqlName("SB7")+" SB7  "

	cQuery    += "WHERE "
	cQuery    += "SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
   
                                         
	If !Empty(cTipo)
		cQuery += " And SB1.B1_TIPO  In "+FormatIn(cTipo,";")
	EndIf

	If !Empty(cNoTipo)
		cQuery += " And SB1.B1_TIPO Not In "+FormatIn(cNoTipo,";")
	EndIf
	
	//cQuery += "SB1.B1_GRUPO >= '"+mv_par08+"' And SB1.B1_GRUPO <= '"+mv_par09+"' And "

	//If aReturn[8] == 5
		//cQuery += "SB1.B1_LOCPAD>= '"+mv_par06+"' And SB1.B1_LOCPAD<= '"+mv_par07+"' And "
	//EndIf


	cQuery += " And SB1.B1_COD    >= '"+cDoProd+"' And SB1.B1_COD   <= '"+cAteProd+"' And "
	
	cQuery    += "SB1.D_E_L_E_T_ = ' ' And "

	cQuery    += "SB2.B2_FILIAL = '"+xFilial("SB2")+"' And "
	cQuery    += "SB2.B2_COD = SB1.B1_COD And "
	cQuery    += "SB2.B2_LOCAL = SB7.B7_LOCAL And "
	cQuery    += "SB2.D_E_L_E_T_ = ' ' And "
	cQuery    += "SB7.B7_FILIAL = '"+xFilial("SB7")+"' And "
	cQuery    += " SB7.B7_COD = SB1.B1_COD "
	          
	If !Empty(cArmazem)
		cQuery += " And SB7.B7_LOCAL  In "+FormatIn(cArmazem,";")
	EndIf

	If !Empty(cNoArmazem)
		cQuery += " And SB7.B7_LOCAL Not In "+FormatIn(cNoArmazem,";")
	EndIf
	//cQuery    += " And SB7.B7_DATA   = '"+DtoS(mv_par03)+"' And "
	
	cQuery    += " And SB7.B7_DOC   = '"+cNomeDoc+"'"
	cQuery    += " And SB7.D_E_L_E_T_ = ' ' "


	If aReturn[8] == 5 // local
		cQuery    += "ORDER BY " + cKey // B1_FILIAL, B1_LOCPAD, B1_COD
	Else	
		cQuery    += "ORDER BY "+SqlOrder(SB1->(IndexKey()))
	EndIf	
	

	cQuery    := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB1,.T.,.T.)

	For nX := 1 To Len(aStruSB1)
		If ( aStruSB1[nX][2] <> "C" ) .And. FieldPos(aStruSB1[nX][1]) > 0
			TcSetField(cAliasSB1,aStruSB1[nX][1],aStruSB1[nX][2],aStruSB1[nX][3],aStruSB1[nX][4])
		EndIf
	Next nX

	For nX := 1 To Len(aStruSB2)
		If ( aStruSB2[nX][2] <> "C" ) .And. FieldPos(aStruSB2[nX][1]) > 0
			TcSetField(cAliasSB2,aStruSB2[nX][1],aStruSB2[nX][2],aStruSB2[nX][3],aStruSB2[nX][4])
		EndIf
	Next nX

	For nX := 1 To Len(aStruSB7)
		If ( aStruSB7[nX][2] <> "C" ) .And. FieldPos(aStruSB7[nX][1]) > 0
			TcSetField(cAliasSB7,aStruSB7[nX][1],aStruSB7[nX][2],aStruSB7[nX][3],aStruSB7[nX][4])
		EndIf
	Next nX
	cAnt:= ""
	If aReturn[8] == 2
		cAnt	:= (cAliasSB1)->B1_TIPO
	ElseIf aReturn[8] == 3
		cAnt	:= (cAliasSB1)->B1_GRUPO
	EndIf

nTotVal := 0
nSubVal := 0

While &cCondicao

	#IFNDEF TOP
	   If lVEIC
			If ((cAliasSB1)->B1_CODITE > cAteProd .And. aReturn[8] == 1)  
				Exit
			ElseIf ((cAliasSB1)->B1_GRUPO < mv_par08) .Or. ((cAliasSB1)->B1_GRUPO  > mv_par09) .Or. ;
				   ((cAliasSB1)->B1_TIPO   < mv_par04) .Or. ((cAliasSB1)->B1_TIPO   > mv_par05) .Or. ;
				   ((cAliasSB1)->B1_CODITE < cDoProd) .Or. ((cAliasSB1)->B1_CODITE > cAteProd)
 				    (cAliasSB1)->(dbSkip())
			        Loop
			EndIf
	   Else
			If ((cAliasSB1)->B1_COD > cAteProd .And. aReturn[8] == 1)
				Exit
			ElseIf ((cAliasSB1)->B1_GRUPO < mv_par08) .Or. ((cAliasSB1)->B1_GRUPO > mv_par09) .Or. ;
				   ((cAliasSB1)->B1_TIPO  < mv_par04) .Or. ((cAliasSB1)->B1_TIPO  > mv_par05) .Or. ;
				   ((cAliasSB1)->B1_COD   < cDoProd) .Or. ((cAliasSB1)->B1_COD   > cAteProd)
					(cAliasSB1)->(dbSkip())
					Loop
			EndIf
		EndIf
	#ENDIF

    If !Empty(aReturn[7]) .And. !&(aReturn[7])
       (cAliasSB1)->(dbSkip())
		Loop
	EndIf

	If lFirst  
		If aReturn[8] == 2 .and. cAnt <> (cAliasSB1)->B1_TIPO
			cAnt := (cAliasSB1)->B1_TIPO
			lFirst := .F.
		ElseIf aReturn[8] == 3 .and. cAnt <> (cAliasSB1)->B1_GRUPO
			cAnt := (cAliasSB1)->B1_GRUPO
			lFirst := .F.
		EndIf
	EndIf	
	If lEnd
		@ pRow()+1, 000 PSAY 'CANCELADO PELO OPERADOR'
		Exit
	EndIF
	
	IncRegua()

	#IFNDEF TOP
		(cAliasSB2)->(dbSeek(xFilial('SB2') + (cAliasSB1)->B1_COD, .T.))

		Do While !(cAliasSB2)->(Eof()) .And. (cAliasSB2)->B2_FILIAL+(cAliasSB2)->B2_COD == xFilial('SB2')+(cAliasSB1)->B1_COD

			(cAliasSB7)->(dbSeek(xFilial('SB7') + DtoS(mv_par03) + (cAliasSB2)->B2_COD + (cAliasSB2)->B2_LOCAL, .T.))
	#ENDIF

		cProduto := (cAliasSB2)->B2_COD
		cLocal   := (cAliasSB2)->B2_LOCAL
		dDtEstq := (cAliasSB7)->B7_DATA
		
		While !(cAliasSB7)->(Eof()) .And. (cAliasSB7)->(B7_FILIAL+DtoS(B7_DATA)+B7_COD+B7_LOCAL) == xFilial('SB7')+DtoS(dDtEstq)+cProduto+cLocal
			
			#IFNDEF TOP
				If ((cAliasSB7)->B7_LOCAL < mv_par06) .Or. ((cAliasSB7)->B7_LOCAL > mv_par07)
					(cAliasSB7)->(dbSkip())
					Loop
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Caso utilize contagem so considera a contagem escolhida      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lContagem .And. (cAliasSB7)->B7_ESCOLHA <> 'S'
					(cAliasSB7)->(dbSkip())
					Loop
				EndIf
			#ENDIF
			
			nTotal   := 0
			nSB7Cnt  := 0
			aRegInv  := {}
			cSeek    := xFilial('SB7')+DtoS(dDtEstq)+(cAliasSB7)->B7_COD+(cAliasSB7)->B7_LOCAL+(cAliasSB7)->B7_LOCALIZ+(cAliasSB7)->B7_NUMSERI+(cAliasSB7)->B7_LOTECTL+(cAliasSB7)->B7_NUMLOTE
			cCompara := "B7_FILIAL+DTOS(B7_DATA)+B7_COD+B7_LOCAL+B7_LOCALIZ+B7_NUMSERI+B7_LOTECTL+B7_NUMLOTE"
			cLocaliz := (cAliasSB7)->B7_LOCALIZ
			cNumSeri := (cAliasSB7)->B7_NUMSERI
			cLoteCtl := (cAliasSB7)->B7_LOTECTL
			cNumLote := (cAliasSB7)->B7_NUMLOTE
			lImprime := .T.
			
			While !(cAliasSB7)->(Eof()) .And. cSeek == (cAliasSB7)->&(cCompara)
				
				#IFNDEF TOP
					If ((cAliasSB7)->B7_LOCAL < mv_par06) .Or. ((cAliasSB7)->B7_LOCAL > mv_par07)
						(cAliasSB7)->(dbSkip())
						Loop
					EndIf
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Caso utilize contagem so considera a contagem escolhida      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lContagem .And. (cAliasSB7)->B7_ESCOLHA <> 'S'
						(cAliasSB7)->(dbSkip())
						Loop
					EndIf
				#ENDIF

				nSB7Cnt++
				
				aAdd(aRegInv,{	Left(cProduto,15)					,; //B2_COD
								Left((cAliasSB1)->B1_DESC,30)		,; //B1_DESC
								Left((cAliasSB7)->B7_LOTECTL,10)	,; //B7_LOTECTL
								Left((cAliasSB7)->B7_NUMLOTE,06)	,; //B7_NUMLOTE
								Left((cAliasSB7)->B7_LOCALIZ,15)	,; //B7_LOCALIZ
								Left((cAliasSB7)->B7_NUMSERI,20)	,; //B7_NUMSERI
								Left((cAliasSB1)->B1_TIPO ,02)		,; //B1_TIPO
								Left((cAliasSB1)->B1_GRUPO,04)		,; //B1_GRUPO
								Left((cAliasSB1)->B1_UM   ,02)		,; //B1_UM
								Left((cAliasSB2)->B2_LOCAL,02)		,; //B2_LOCAL
								(cAliasSB7)->B7_DOC					,; //B7_DOC
								Transform((cAliasSB7)->B7_QUANT,(cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)) ) } ) //B7_QUANT
				If At(aRegInv[nSB7Cnt,10],cB7Armazem )==0
					cB7Armazem+=aRegInv[nSB7Cnt,10]+";"
				EndIf	
				

				nTotal += (cAliasSB7)->B7_QUANT
				nTotQtdInv+=(cAliasSB7)->B7_QUANT
				(cAliasSB7)->(dbSkip())
			EndDo
			
			#IFNDEF TOP
				If nSB7Cnt == 0
					(cAliasSB2)->(dbSkip())
					Loop
				EndIf
			#ENDIF	
		
			If (Localiza(cProduto) .And. !Empty(cLocaliz+cNumSeri)) .Or. (Rastro(cProduto) .And. !Empty(cLotectl+cNumLote))
				aSalQtd   := CalcEstL(cProduto,cLocal,dDtEstq+1,cLoteCtl,cNumLote,cLocaliz,cNumSeri)
				aSaldo    := CalcEst(cProduto,cLocal,dDtEstq+1)
				aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
				aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
				aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
				aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
				aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
				aSaldo[7] := aSalQtd[7]
				aSaldo[1] := aSalQtd[1]
			Else
				If cLocCQ == cLocal
					aSalQtd	  := A340QtdCQ(cProduto,cLocal,dDtEstq+1,"")
					aSaldo	  := CalcEst(cProduto,cLocal,dDtEstq+1)
					aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
					aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
					aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
					aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
					aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
					aSaldo[7] := aSalQtd[7]
					aSaldo[1] := aSalQtd[1]
				Else
					aSaldo := CalcEst(cProduto,cLocal,dDtEstq+1)
				EndIf
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Validacao do Total da Diferenca X Saldo Disponivel           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nTotal-aSaldo[1] == 0
				If nListaProd == 1
					lImprime := .F.
				EndIf	
			Else 
			    If nListaProd == 2
				   lImprime := .F.
				EndIf 
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao do Inventario                                      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lImprime .Or. nListaProd == 3
						
				For nX:=1 to Len(aRegInv)
					
					If Li > 55
						Cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
					EndIf                
					
					
					If nX == 1
						@ Li, 000 PSAY aRegInv[nX,01] //B1_CODITE
						@ Li, 016 + nCOL1 PSAY aRegInv[nX,02] //B1_COD
					EndIf
	
					If nImpLoteZerado == 1  
						@ Li, 047 + nCOL1 PSAY aRegInv[nX,03] //B7_LOTECTL
						@ Li, 058 + nCOL1 PSAY aRegInv[nX,04] //B7_NUMLOTE
						If nImpEndereco == 1                            
							@ Li, 065 + nCOL1 PSAY aRegInv[nX,05] //B7_LOCALIZ
							@ Li, 081 + nCOL1 PSAY aRegInv[nX,06] //B7_NUMSERI
						EndIf
						If nX == 1
							@ Li,If(nImpEndereco==1,102,065) + nCOL1 PSAY aRegInv[nX,07] //B1_TIPO
							@ Li,If(nImpEndereco==1,105,068) + nCOL1 PSAY aRegInv[nX,08] //B1_GRUPO
							@ Li,If(nImpEndereco==1,109,073) + nCOL1 PSAY aRegInv[nX,09] //B1_UM
							@ Li,If(nImpEndereco==1,113,076) + nCOL1 PSAY aRegInv[nX,10] //B2_LOCAL 
						EndIf
						@ Li,If(nImpEndereco==1,116,079) + nCOL1 PSAY aRegInv[nX,11] //B7_DOC
						@ Li,If(nImpEndereco==1,129,092) + nCOL1 PSAY aRegInv[nX,12] //B7_QUANT
					Else
						If nImpEndereco == 1
							@ Li, 047 + nCOL1 PSAY aRegInv[nX,05] //B7_LOCALIZ
							@ Li, 063 + nCOL1 PSAY aRegInv[nX,06] //B7_NUMSERI
						EndIf
						If nX == 1							
							@ Li,If(nImpEndereco==1,084,047) + nCOL1 PSAY aRegInv[nX,07] //B1_TIPO
							@ Li,If(nImpEndereco==1,087,050) + nCOL1 PSAY aRegInv[nX,08] //B1_GRUPO
							@ Li,If(nImpEndereco==1,092,054) + nCOL1 PSAY aRegInv[nX,09] //B1_UM
							@ Li,If(nImpEndereco==1,095,057) + nCOL1 PSAY aRegInv[nX,10] //B2_LOCAL 							
						EndIf
						@ Li,If(nImpEndereco==1,098,061) + nCOL1 PSAY aRegInv[nX,11] //B7_DOC
						@ Li,If(nImpEndereco==1,111,074) + nCOL1 PSAY aRegInv[nX,12] //B7_QUANT						
					EndIf
               
					aExcel:=aClone(aRegInv[nX])
				
	
					Li++
			
				Next nX
					
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Adiciona 1 ao contador de registros impressos         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nCntImpr++
			
				If nSB7Cnt == 1
					Li--
				ElseIf nSB7Cnt > 1
					If nImpLoteZerado == 1
						@ Li,If(nImpEndereco==1,106,069) + nCOL1 PSAY  'TOTAL .................'
						@ Li,If(nImpEndereco==1,129,092) + nCOL1 PSAY Transform(nTotal, (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
					Else
						@ Li,If(nImpEndereco==1,088,050) + nCOL1 PSAY  'TOTAL .................'
						@ Li,If(nImpEndereco==1,111,074) + nCOL1 PSAY Transform(nTotal, (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
					EndIf
				EndIf

				If nImpLoteZerado == 1
					@ Li,If(nImpEndereco==1,149,112) + nCOL1 PSAY Transform(aSaldo[1], (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
				Else
					@ Li,If(nImpEndereco==1,131,094) + nCOL1 PSAY Transform(aSaldo[1], (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
				EndIf        
				nSaldoEst+=aSaldo[1]
				
				If nSB7Cnt > 0
					If nCustoMedio == 1
						aCM:={}
						If QtdComp(aSaldo[1]) > QtdComp(0)
							For i:=2 to Len(aSaldo)
								AADD(aCM,aSaldo[i]/aSaldo[1])
							Next i
        	    		Else
							aCm := PegaCmAtu(cProduto,cLocal)
	            		EndIf
                	Else
            	    	aCM := PegaCMFim(cProduto,cLocal)
					EndIf
		            dbSelectArea(cAliasSB7)

					If nImpLoteZerado == 1 
						@ Li,If(nImpEndereco==1,169,132) + nCOL1 PSAY Transform(nTotal-aSaldo[1], (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
						@ Li,If(nImpEndereco==1,188,151) + nCOL1 PSAY Transform((nTotal-aSaldo[1])*aCM[nDaMoeda], (cAliasSB2)->(PesqPict("SB2",'B2_VFIM1', 15)))
					Else
						@ Li,If(nImpEndereco==1,152,114) + nCOL1 PSAY Transform(nTotal-aSaldo[1], (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
						@ Li,If(nImpEndereco==1,171,133) + nCOL1 PSAY Transform((nTotal-aSaldo[1])*aCM[nDaMoeda], (cAliasSB2)->(PesqPict("SB2",'B2_VFIM1', 15)))
					EndIf
					nTotVal += (nTotal-aSaldo[1])*aCM[nDaMoeda]
					nSubVal += (nTotal-aSaldo[1])*aCM[nDaMoeda]
				EndIf
				Li++
			
				cLine:=''										
				cLine+='		<Row>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+aExcel[01]+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+EnCodeUtf8(NoAcento(aExcel[02]))+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+aExcel[07]+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+aExcel[08]+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+aExcel[09]+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+aExcel[10]+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s65"><Data ss:Type="String">'+aExcel[11]+'</Data></Cell>'+Enter
				
				cLine+='    	<Cell ss:StyleID="s95"><Data ss:Type="Number">'+AllTrim((aExcel[12]))+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s95"><Data ss:Type="Number">'+AllTrim(Str(aSaldo[1]))+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s95"><Data ss:Type="Number">'+AllTrim(Str(nTotal-aSaldo[1]))+'</Data></Cell>'+Enter
				cLine+='    	<Cell ss:StyleID="s93"><Data ss:Type="Number">'+AllTrim(Str((nTotal-aSaldo[1])*aCM[nDaMoeda]))+'</Data></Cell>'+Enter
				cLine+='   </Row>'+Enter
				             
				nTotLine++
				LineWrite(cLine)
				
				
			Else
				#IFNDEF TOP
					(cAliasSB2)->(dbSkip())
					Loop
				#ENDIF	
			EndIf
		EndDo
		
	#IFNDEF TOP
		(cAliasSB2)->(dbSkip())
		
	EndDo

	dbSelectArea(cAliasSB1)
	dbSkip()
	#ENDIF
	
	If aReturn[8] == 2
		If cAnt # B1_TIPO .And. nSB7Cnt >= 1
			If nImpLoteZerado == 1
				@ Li,If(nImpEndereco==1,158,120) + nCOL1 PSAY 'TOTAL DO TIPO ' + Left(cAnt,2) + ' .............' // 'TOTAL DO TIPO '
				@ Li,If(nImpEndereco==1,188,151) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			Else     
				@ Li,If(nImpEndereco==1,142,098) + nCOL1 PSAY 'TOTAL DO TIPO ' + Left(cAnt,2) + ' ............' // 'TOTAL DO TIPO '
				@ Li,If(nImpEndereco==1,171,133) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			EndIf
			cAnt    := B1_TIPO
			nSubVal := 0
			Li += 2
			nSB7Cnt := 0
		EndIf
	ElseIf aReturn[8] == 3
		If cAnt # B1_GRUPO  .And. nSB7Cnt >= 1
			If nImpLoteZerado == 1 
				@ Li,If(nImpEndereco==1,155,117) + nCOL1 PSAY 'TOTAL DO GRUPO ' + Left(cAnt,4) + ' .............' // 'TOTAL DO GRUPO '
				@ Li,If(nImpEndereco==1,188,151) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			Else
				@ Li,If(nImpEndereco==1,135,096) + nCOL1 PSAY 'TOTAL DO GRUPO ' + Left(cAnt,4) + ' .............' // 'TOTAL DO GRUPO '
				@ Li,If(nImpEndereco==1,171,133) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			EndIf
			cAnt    := B1_GRUPO
			nSubVal := 0
			Li += 2
			nSB7Cnt := 0
		EndIf
	EndIf
	
EndDo
//					@ Li,094 + nCOL1 PSAY Transform(aSaldo[1], (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
If nTotVal # 0
   
	cTotLine:=AllTrim(Str(nTotLine))
	cLine:=''
	cLine+='<Row>'+Enter
	cLine+='    <Cell ss:StyleID="s99"><Data ss:Type="String">Total</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s100" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">-9999</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s100" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">-29997</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s100" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">-29997</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s101" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">-299999.97000000003</Data></Cell>'+Enter
	cLine+='</Row>'+Enter
	LineWrite(cLine)

	Li++
	@ Li,000 psay __PrtFatLine()	
	Li++                          
	@ Li,01 + nCOL1 PSAY 'TOTAL DAS DIFERENCAS INVENTARIADAS'
	@ Li,074 + nCOL1 PSAY Transform(nTotQtdInv,'@E 999,999,999' )		
	@ Li,094 + nCOL1 PSAY Transform(nSaldoEst , '@E 999,999,999')		
	@ Li,114 + nCOL1 PSAY Transform(nTotQtdInv-nSaldoEst, '@E 999,999,999')
	@ Li,133 + nCOL1 PSAY Transform(nTotVal, (PesqPict("SB2",'B2_VFIM1', 15)))
	Li++
	@ Li,000 psay __PrtFatLine()		
EndIf

cLine:=''
cLine+='  </Table>'+Enter
cLine+='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cLine+='   <PageSetup>'+Enter
cLine+='    <Header x:Margin="0.31496062000000002"/>'+Enter
cLine+='    <Footer x:Margin="0.31496062000000002"/>'+Enter
cLine+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
cLine+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
cLine+='   </PageSetup>'+Enter
cLine+='   <Print>'+Enter
cLine+='    <ValidPrinterInfo/>'+Enter
cLine+='    <PaperSizeIndex>9</PaperSizeIndex>'+Enter
cLine+='    <HorizontalResolution>600</HorizontalResolution>'+Enter
cLine+='    <VerticalResolution>600</VerticalResolution>'+Enter
cLine+='   </Print>'+Enter
cLine+='   <Selected/>'+Enter
cLine+='   <Panes>'+Enter
cLine+='    <Pane>'+Enter
cLine+='     <Number>3</Number>'+Enter
cLine+='     <ActiveRow>13</ActiveRow>'+Enter
cLine+='     <ActiveCol>6</ActiveCol>'+Enter
cLine+='    </Pane>'+Enter
cLine+='   </Panes>'+Enter
cLine+='   <ProtectObjects>False</ProtectObjects>'+Enter
cLine+='   <ProtectScenarios>False</ProtectScenarios>'+Enter
cLine+='  </WorksheetOptions>'+Enter
cLine+=' </Worksheet>'+Enter
LineWrite(cLine)


dbSelectArea(cString)
RetIndex(cString)
dbSetOrder(1)
dbClearFilter()

#IFNDEF TOP
	(cAliasSB2)->(dbSetOrder(1))
	(cAliasSB7)->(dbSetOrder(1))
	(cAliasSB1)->(dbSetOrder(1))
#ELSE	
	dbSelectArea(cAliasSB1)
	dbCloseArea()
#ENDIF

If !empty(cNomArq)
	If aReturn[8] == 5 .or. (lVEIC .And. (aReturn[8] == 1 .or. aReturn[8] == 2))
		If File(cNomArq + OrdBagExt())
			fErase(cNomArq + OrdBagExt())
		EndIf
	EndIf
EndIf
Li:=999          

If Li+5>70
	Li:=999
EndIf	

R285PASTA("2")
          
Titulo  := 'Listagem dos Produtos não inventáriados com saldo no sistema'

cQuery:=" select sb2.r_e_c_n_o_ recsb2,sb1.r_e_c_n_o_ recsb1"
cQuery+=" from "+RetSqlName("SB1")+" sb1,"+RetSqlName("SB2")+" sb2"
cQuery+=" where sb1.b1_filial='"+xFilial("SB1")+"'"
cQuery+=" and sb1.b1_cod between '"+Space(Len(SB1->B1_COD))+"' and '"+Replicate('Z',Len(SB1->B1_COD))+"'"

If !Empty(cTipo)
	cQuery += " And SB1.B1_TIPO  In "+FormatIn(cTipo,";")
EndIf

If !Empty(cNoTipo)
	cQuery += " And SB1.B1_TIPO Not In "+FormatIn(cNoTipo,";")
EndIf

cQuery+=" and sb1.d_e_l_e_t_=' '"
cQuery+=" and sb2.b2_filial='"+xFilial("SB2")+"'"
cQuery+=" and sb2.b2_cod=sb1.b1_cod"
cQuery+=" and sb2.b2_qatu+sb2.b2_reserva>0"
cQuery+=" and sb2.d_e_l_e_t_=' '"

If !Empty(cArmazem)
	cQuery += " And SB2.B2_LOCAL  In "+FormatIn(cArmazem,";")
ElseIf !Empty(cB7Armazem)                                
	cB7Armazem:=Left(cB7Armazem,Len(cB7Armazem)-1) 
	cQuery += " And SB2.B2_LOCAL  In "+FormatIn(cB7Armazem,";")
EndIf

If !Empty(cNoArmazem)
	cQuery += " And SB2.B2_LOCAL Not In "+FormatIn(cNoArmazem,";")
EndIf



cQuery+=" and not Exists (Select 'X' From "+RetSqlName("SB7")+" SB7 "
cQuery+=" 				  Where SB7.B7_FILIAL='"+xFilial("SB7")+"'"
cQuery+="              and sb7.b7_doc   = '"+cNomeDoc+"'"
cQuery+=" 				  and sb7.b7_cod=sb2.b2_cod"
cQuery+=" 				  and sb7.b7_local=sb2.b2_local"

If !Empty(cArmazem)
	cQuery += " And SB7.B7_LOCAL  In "+FormatIn(cArmazem,";")
ElseIf !Empty(cB7Armazem)
	cQuery += " And SB7.B7_LOCAL  In "+FormatIn(cB7Armazem,";")
EndIf
	


If !Empty(cNoArmazem)
	cQuery += " And SB7.B7_LOCAL Not In "+FormatIn(cNoArmazem,";")
EndIf
cQuery+=" 				  and sb7.d_e_l_e_t_=' ')" 
cQuery+=" Order By B2_COD,B2_LOCAL"
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

   
Li++
If Li > 70
	Cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
EndIf                         

lTemDiverg:=.T.

@ Li,000 psay __PrtThinLine()
@ ++Li,000 psay __PrtCenter("Produtos não invetáriados com saldo no sistema")
@ ++Li,000 psay __PrtThinLine()

nQtdZerada	:=TransForm(0, cPictQtd:=PesqPict("SB7",'B7_QUANT', 15))
cDocVazio	:=Space(Len(SB7->B7_DOC))
nTotEst		:=0
nTotLine		:=0

Do While (cAliasQry)->(!Eof())
	lTemDiverg:=.F.
	SB1->(DbGoTo((cAliasQry)->recsb1))	
	SB2->(DbGoTo((cAliasQry)->recsb2))	

	Li++
	If Li > 70
		Cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
	   @ Li,000 psay __PrtThinLine()
		@ ++Li,000 psay __PrtCenter("Produtos não invetáriados com saldo no sistema")
		@ ++Li,000 psay __PrtThinLine()
		Li++
	EndIf                         
	
		
	@ Li, 000 PSAY Left(SB2->B2_COD,15)
	@ Li, 016 + nCOL1 PSAY Left(SB1->B1_DESC,30)


	@ Li,If(nImpEndereco==1,084,047) + nCOL1 PSAY SB1->B1_TIPO
	@ Li,If(nImpEndereco==1,087,050) + nCOL1 PSAY SB1->B1_GRUPO
	@ Li,If(nImpEndereco==1,092,054) + nCOL1 PSAY SB1->B1_UM
	@ Li,If(nImpEndereco==1,095,057) + nCOL1 PSAY SB2->B2_LOCAL
	
	//@ Li,If(nImpEndereco==1,098,061) + nCOL1 PSAY cDocVazio
	//@ Li,If(nImpEndereco==1,111,074) + nCOL1 PSAY nQtdZerada
	
	aSaldo := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,dDtEstq+1)
	aCm := PegaCmAtu(SB2->B2_COD,SB2->B2_LOCAL)
	
	nTotQtdSis+=aSaldo[1]
	
	nTotEst+=aSaldo[1]*aCM[nDaMoeda]
	
	@ Li,If(nImpEndereco==1,152,114) + nCOL1 PSAY Transform(aSaldo[1], PesqPict("SB7",'B7_QUANT', 15))
	@ Li,If(nImpEndereco==1,171,133) + nCOL1 PSAY Transform((aSaldo[1])*aCM[nDaMoeda], PesqPict("SB2",'B2_VFIM1', 15))
		       
	cLine:=''										
	cLine+='<Row>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String">'+Left(SB2->B2_COD,15)+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String">'+FwNoAccent(Left(SB1->B1_DESC,30))+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String">'+SB1->B1_TIPO+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String" x:Ticked="1">'+SB1->B1_GRUPO+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String">'+SB1->B1_UM+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String">'+SB2->B2_LOCAL+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s65"><Data ss:Type="String">'+""+'</Data></Cell>'+Enter
				
	cLine+='    <Cell ss:StyleID="s95"><Data ss:Type="Number">0</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s95"><Data ss:Type="Number">'+AllTrim(Str(aSaldo[1]))+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s95"><Data ss:Type="Number">'+AllTrim(Str(aSaldo[1]))+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s93"><Data ss:Type="Number">'+AllTrim(Str(aSaldo[1]*aCM[nDaMoeda]))+'</Data></Cell>'+Enter
	cLine+='   </Row>'+Enter
	nTotLine++
	LineWrite(cLine)
	(cAliasQry)->(DbSkip())
EndDo            



Li++
If Li > 70
	Cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
	@ Li,000 psay __PrtThinLine()
	@ ++Li,000 psay __PrtCenter("Produtos não invetáriados com saldo no sistema")
	@ ++Li,000 psay __PrtThinLine()
	Li++
EndIf                         


If lTemDiverg
	@ Li,000 psay __PrtCenter("Ná há produtos não inventáriados.")
Else

	Li++
	@ Li,000 psay __PrtFatLine()	
	Li++                          
	@ Li,01 + nCOL1 PSAY 'TOTAL DAS DIFERENCAS NAO INVENTARIADA'
	@ Li,114 + nCOL1 PSAY Transform(nTotQtdSis, '@E 999,999,999')
	@ Li,133 + nCOL1 PSAY Transform(nTotEst, PesqPict("SB2",'B2_VFIM1', 15))
	Li++
	@ Li,000 psay __PrtFatLine()			
	cTotLine:=AllTrim(Str(nTotLine))
	cLine:=''
	cLine+='<Row>'+Enter
	cLine+='    <Cell ss:StyleID="s99"><Data ss:Type="String">Total</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s99"/>'+Enter
	cLine+='    <Cell ss:StyleID="s100" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s100" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s100" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s101" ss:Formula="=SUM(R[-'+cTotLine+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+Enter
	cLine+='   </Row>'+Enter
	
   LineWrite(cLine) 		
EndIf	              

cLine:=''
cLine+='  </Table>'+Enter
cLine+='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cLine+='   <PageSetup>'+Enter
cLine+='    <Header x:Margin="0.31496062000000002"/>'+Enter
cLine+='    <Footer x:Margin="0.31496062000000002"/>'+Enter
cLine+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
cLine+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
cLine+='   </PageSetup>'+Enter
cLine+='   <Panes>'+Enter
cLine+='    <Pane>'+Enter
cLine+='     <Number>3</Number>'+Enter
cLine+='     <ActiveRow>13</ActiveRow>'+Enter
cLine+='     <ActiveCol>10</ActiveCol>'+Enter
cLine+='    </Pane>'+Enter
cLine+='   </Panes>'+Enter
cLine+='   <ProtectObjects>False</ProtectObjects>'+Enter
cLine+='   <ProtectScenarios>False</ProtectScenarios>'+Enter
cLine+='  </WorksheetOptions>'+Enter
cLine+=' </Worksheet>'+Enter
cLine+='</Workbook>'+Enter
LineWrite(cLine)


FClose(nHdl)
If !__CopyFile(cPathArq+cArqXls+cExtExcel, cPathExcel+cArqXls+cExtExcel)
	MsgStop("Erro ao copiar planilha")
ElseIf !ApOleCliente( "MsExcel" )
	MsgStop( "Microsoft Excel não Instalado... Contate o Administrador do Sistema!" )
ElseIf MsgYesNo("Abrir o Microsoft Excel?")
	oExcelApp:=MsExcel():New()
	oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
	oExcelApp:SetVisible( .T. )
	oExcelApp:Destroy()	
EndIf

Ferase(cPathArq+cArqXls+cExtExcel)


If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf

If Select(cAliasQry)>0
   (cAliasQry)->(DbCloseArea())
EndIf		

MS_FLUSH()

If IsIncallStack("A003Exec")
	U_A003LOG()
EndIf


Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A285QryFil³ Autor ³ Marcos V. Ferreira    ³ Data ³ 15.04.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao utilizada para adicionar no select os campos        ³±±
±±³			 ³ utilizados no filtro de usuario.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR285                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function A285QryFil(cAlias,cQuery,cFilUser)
Local cQryAd	:= ""
Local cName		:= ""
Local aStruct	:= (cAlias)->(dbStruct())
Local nX		:= 0
Default cAlias  := ""
Default cQuery  := ""
Default cFilUser:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta rotina foi escrita para adicionar no select os campos         ³
//³usados no filtro do usuario quando houver, a rotina acrecenta      ³
//³somente os campos que forem adicionados ao filtro testando         ³
//³se os mesmo já existem no select ou se forem definidos novamente   ³
//³pelo o usuario no filtro.                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   	
If !Empty(cFilUser)
	For nX := 1 To (cAlias)->(FCount())
		cName := (cAlias)->(FieldName(nX))
		If AllTrim( cName ) $ cFilUser
	    	If aStruct[nX,2] <> "M"  
	      	    If !cName $ cQuery .And. !cName $ cQryAd
		    		cQryAd += cName +","
	            EndIf 	
			EndIf
		EndIf 			       	
	Next nX
EndIf    

Return cQryAd

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AjustaSX1 ³ Autor ³ Marcos V. Ferreira    ³ Data ³ 21.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta o grupo de perguntas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR285                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function AjustaSX1(cPerg)  

PutSx1(cPerg,"01","Nome Documento"		,"","","MV_CH1","C",09,0,0,"G","","","","","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Listar Armazem"		,"","","MV_CH2","C",02,0,0,"G","","","","","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"03","Gerar Excel"			,"","","MV_CH3","N",01,0,3,"C","","","","","MV_PAR03","Sim","","","","Não","","","",""," ","               ","               ","               ","               ","               ","          ","","","","")

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UMATR285  ºAutor  ³Microsiga           º Data ³  09/14/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R285Cabec()
Local cLine:=""

cLine+='<?xml version="1.0"?>'+Enter
cLine+='<?mso-application progid="Excel.Sheet"?>'+Enter
cLine+='<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+Enter
cLine+=' xmlns:o="urn:schemas-microsoft-com:office:office"'+Enter
cLine+=' xmlns:x="urn:schemas-microsoft-com:office:excel"'+Enter
cLine+=' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+Enter
cLine+=' xmlns:html="http://www.w3.org/TR/REC-html40">'+Enter
cLine+=' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+Enter
cLine+='  <Author>NcGames</Author>'+Enter
cLine+='  <LastAuthor>NcGames</LastAuthor>'+Enter
cLine+='  <Created>2014-09-14T14:57:50Z</Created>'+Enter
cLine+='  <LastSaved>2014-09-14T15:12:43Z</LastSaved>'+Enter
cLine+='  <Version>15.00</Version>'+Enter
cLine+=' </DocumentProperties>'+Enter
cLine+=' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+Enter
cLine+='  <AllowPNG/>'+Enter
cLine+=' </OfficeDocumentSettings>'+Enter
cLine+=' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cLine+='  <WindowHeight>9408</WindowHeight>'+Enter
cLine+='  <WindowWidth>23040</WindowWidth>'+Enter
cLine+='  <WindowTopX>0</WindowTopX>'+Enter
cLine+='  <WindowTopY>0</WindowTopY>'+Enter
cLine+='  <ProtectStructure>False</ProtectStructure>'+Enter
cLine+='  <ProtectWindows>False</ProtectWindows>'+Enter
cLine+=' </ExcelWorkbook>'+Enter
cLine+=' <Styles>'+Enter
cLine+='  <Style ss:ID="Default" ss:Name="Normal">'+Enter
cLine+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cLine+='   <Borders/>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+Enter
cLine+='   <Interior/>'+Enter
cLine+='   <NumberFormat/>'+Enter
cLine+='   <Protection/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="m348070760">'+Enter
cLine+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="m231431272">'+Enter
cLine+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s65">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s68">'+Enter
cLine+='   <Borders/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s69">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s70">'+Enter
cLine+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s93">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <NumberFormat ss:Format="#,##0.00_ ;[Red]\-#,##0.00\ "/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s95">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <NumberFormat ss:Format="#,##0_ ;[Red]\-0\ "/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s99">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='   <Interior ss:Color="#D9E1F2" ss:Pattern="Solid"/>'+Enter
cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s100">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='   <Interior ss:Color="#D9E1F2" ss:Pattern="Solid"/>'+Enter
cLine+='   <NumberFormat ss:Format="#,##0_ ;[Red]\-0\ "/>'+Enter

cLine+='  </Style>'+Enter
cLine+='  <Style ss:ID="s101">'+Enter
cLine+='   <Borders>'+Enter
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cLine+='   </Borders>'+Enter
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+Enter
cLine+='    ss:Bold="1"/>'+Enter
cLine+='   <Interior ss:Color="#D9E1F2" ss:Pattern="Solid"/>'+Enter
cLine+='   <NumberFormat ss:Format="#,##0.00_ ;[Red]\-#,##0.00\ "/>'+Enter
cLine+='  </Style>'+Enter
cLine+=' </Styles>'+Enter
LineWrite(cLine)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UMATR285  ºAutor  ³Microsiga           º Data ³  09/14/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R285PASTA(cParam)
Local cLine:=""


If cParam=="1" 
	cLine+='<Worksheet ss:Name="Produtos Inventariados">'+Enter
	cLine+='  <Table ss:ExpandedColumnCount="11" ss:ExpandedRowCount="9999999" x:FullColumns="1"'+Enter
	cLine+='   x:FullRows="1" ss:DefaultRowHeight="14.4">'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="64.8"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="196.20000000000002"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="16.8"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="41.4"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="22.200000000000003"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="16.8"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="67.2"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="76.2"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="124.2"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="67.8"/>'+Enter
	cLine+='   <Column ss:StyleID="s68" ss:Width="60.6"/>'+Enter
	cLine+='   <Row>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">CODIGO</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">DESCRICAO</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">TP</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">GRP</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">UM</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">AL</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">DOCUMENTO</Data></Cell>'+Enter
	cLine+='    <Cell ss:MergeAcross="1" ss:StyleID="s70"><Data ss:Type="String">QUANTIDADE</Data></Cell>'+Enter
	cLine+='    <Cell ss:MergeAcross="1" ss:StyleID="s70"><Data ss:Type="String">DIFERENCA</Data></Cell>'+Enter
	cLine+='   </Row>'+Enter
	cLine+='   <Row>'+Enter
	cLine+='    <Cell ss:MergeAcross="6" ss:StyleID="m348070760"/>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">INVENTARIADA</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">DA DATA DO INVENTARIO</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">QUANTIDADE</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">VALOR</Data></Cell>'+Enter
	cLine+='   </Row>'+Enter
ElseIf cParam=="2"
	cLine+='<Worksheet ss:Name="Produtos nao Inventariados ">'+Enter
	cLine+='  <Table ss:ExpandedColumnCount="11" ss:ExpandedRowCount="999999" x:FullColumns="1"'+Enter
	cLine+='   x:FullRows="1" ss:DefaultRowHeight="14.4">'+Enter
	cLine+='   <Column ss:Width="64.8"/>'+Enter
	cLine+='   <Column ss:Width="196.20000000000002"/>'+Enter
	cLine+='   <Column ss:Width="16.8"/>'+Enter
	cLine+='   <Column ss:Width="41.4"/>'+Enter
	cLine+='   <Column ss:Width="22.200000000000003"/>'+Enter
	cLine+='   <Column ss:Width="16.8"/>'+Enter
	cLine+='   <Column ss:Width="67.2"/>'+Enter
	cLine+='   <Column ss:Width="76.2"/>'+Enter
	cLine+='   <Column ss:Width="124.2"/>'+Enter
	cLine+='   <Column ss:Width="67.2"/>'+Enter
	cLine+='   <Column ss:Width="60.6"/>'+Enter
	
	cLine+='<Row>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">CODIGO</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">DESCRICAO</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">TP</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">GRP</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">UM</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">AL</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">DOCUMENTO</Data></Cell>'+Enter
	cLine+='<Cell ss:MergeAcross="1" ss:StyleID="s70"><Data ss:Type="String">QUANTIDADE</Data></Cell>'+Enter
	cLine+='<Cell ss:MergeAcross="1" ss:StyleID="s70"><Data ss:Type="String">DIFERENCA</Data></Cell>'+Enter
	cLine+='</Row>'+Enter
	cLine+='<Row>'+Enter
	cLine+='<Cell ss:MergeAcross="6" ss:StyleID="m231431272"/>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">INVENTARIADA</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">DA DATA DO INVENTARIO</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">QUANTIDADE</Data></Cell>'+Enter
	cLine+='<Cell ss:StyleID="s69"><Data ss:Type="String">VALOR</Data></Cell>'+Enter
	cLine+='</Row>'+Enter
EndIf

LineWrite(cLine)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UMATR285  ºAutor  ³Microsiga           º Data ³  09/14/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LineWrite(cLine)
FWrite(nHdl,cLine,Len(cLine))
cLine:=""
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UMATR285  ºAutor  ³Microsiga           º Data ³  09/14/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
static FUNCTION NoAcento(cString)
Local cChar  := ""
Local nX     := 0 
Local nY     := 0
Local cVogal := "aeiouAEIOU"
Local cAgudo := "áéíóú"+"ÁÉÍÓÚ"
Local cCircu := "âêîôû"+"ÂÊÎÔÛ"
Local cTrema := "äëïöü"+"ÄËÏÖÜ"
Local cCrase := "àèìòù"+"ÀÈÌÒÙ" 
Local cTio   := "ãõÃÕ"
Local cCecid := "çÇ"
Local cMaior := "&lt;"
Local cMenor := "&gt;"

For nX:= 1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
		nY:= At(cChar,cAgudo)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCircu)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTrema)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCrase)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf		
		nY:= At(cChar,cTio)
		If nY > 0          
			cString := StrTran(cString,cChar,SubStr("aoAO",nY,1))
		EndIf		
		nY:= At(cChar,cCecid)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("cC",nY,1))
		EndIf
	Endif
Next

If cMaior$ cString 
	cString := strTran( cString, cMaior, "" ) 
EndIf
If cMenor$ cString 
	cString := strTran( cString, cMenor, "" )
EndIf

For nX:=1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	If (Asc(cChar) < 32 .Or. Asc(cChar) > 123) .and. !cChar $ '|'
		cString:=StrTran(cString,cChar,".")
	Endif
Next nX
Return cString