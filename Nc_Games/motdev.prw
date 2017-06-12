#INCLUDE "rwmake.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MotDev    ³ Autor ³ Rodrigo Okamoto       ³ Data ³ 06.05.12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rotina de digitação dos motivos de devolução				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MotDev()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Array contendo as Rotinas a executar do programa      ³
//³ ----------- Elementos contidos por dimensao ------------     ³
//³ 1. Nome a aparecer no cabecalho                              ³
//³ 2. Nome da Rotina associada                                  ³
//³ 3. Usado pela rotina                                         ³
//³ 4. Tipo de Transa‡"o a ser efetuada                          ³
//³    1 - Pesquisa e Posiciona em um Banco de Dados             ³
//³    2 - Simplesmente Mostra os Campos                         ³
//³    3 - Inclui registros no Bancos de Dados                   ³
//³    4 - Altera o registro corrente                            ³
//³    5 - Remove o registro corrente do Banco de Dados          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private dDataFecha	:= getmv("MV_ULDTDEV")
Private cArqInd 	:= CriaTrab(,.F.)		//Nome do arq. temporario
Private nIndex	:= 0					//Indice do arq. temporario a ser utilizado

Private aFixe	:= {	{RetTitle("F1_DOC"),"F1_DOC"},;
{RetTitle("F1_SERIE"),"F1_SERIE"},;
{RetTitle("F1_FORNECE"),"F1_FORNECE"},;
{RetTitle("F1_LOJA"),"F1_LOJA"},;
{RetTitle("F1_DTDIGIT"),"F1_DTDIGIT"},;
{RetTitle("F1_REFAT"),"F1_REFAT"},;
{RetTitle("F1_MOTIVO"),"F1_MOTIVO"},;
{RetTitle("F1_JUSTIF"),"F1_JUSTIF"}}

Private aRotina := {	{ "Pesquisar","AxPesqui"  , 0 , 1},;           //"Pesquisar"
{ "Visualizar","AxVisual"  , 0 , 2} }         //"Visualizar"
If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_USMOTDE")))
	AADD(aRotina,{ "Manutencao","u_DevManut()" ,0,4})       //"Manutencao"
EndIf
If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_ULUSDEV")))
	AADD(aRotina,{ "Fechamento","u_Devfecha()" ,0,3})       //"Manutencao"
EndIf


Private aCores	:= {}
AADD(aCores,{"EMPTY(F1_MOTIVO)","BR_VERDE" })
/*AADD(aCores,{"A1_TIPO == 'L'" ,"BR_AMARELO" })
AADD(aCores,{"A1_TIPO == 'R'" ,"BR_LARANJA" })
AADD(aCores,{"A1_TIPO == 'S'" ,"BR_MARRON" })
AADD(aCores,{"A1_TIPO == 'X'" ,"BR_AZUL" })*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o cabecalho da tela de atualizacoes                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cCadastro            := "Motivo e Justificativa de devolução"
Private cFiltSF1	:="F1_TIPO == 'D' .and. F1_DTDIGIT > dDataFecha "

//SELECIONA OS REGISTROS E ABRE A MARK BROWSE
dbSelectArea("SF1")
IndRegua("SF1",cArqInd,IndexKey(),,cFiltSF1)
nIndex := RetIndex("SF1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
If ( !Eof() .AND. !Bof() )
	mBrowse(6,1,22,75,"SF1",aFixe,,,,3,aCores)
Else
	Help(" ",1,"REGNOIS")
EndIf
dbSelectArea("SF1")
RetIndex("SF1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³AFATManut ³ Autor ³ Sergio S. Fuzinaka    ³ Data ³ 14.12.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Inclusao e/ou alteracao de Transportadora e Veiculo         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DevManut()

Local aArea       := GetArea()
Local aTitles     := {}//"Nota Fiscal" //"Nota Fiscal"
Local nCntFor     := 0
Local nOpc        := 0
Local nX          := 0
Local lVeiculo    := .T.//(SF2->(FieldPos("F2_VOLUME1"))>0 .And. SF2->(FieldPos("F2_PLIQUI"))>0 .And. SF2->(FieldPos("F2_PBRUTO"))>0)
Local cMotivo     := ""
Local cJustif     := ""
Local cRefat      := ""
Local oDlg
Local oFolder
Local oList
Local aCombo 	  := {"1=Sim","2=Não"," "}

Private aHeader   := {}
Private aCols     := {}

Private oMotivo
Private oJustif
Private oRefat



AADD(aTitles,"Nota Fiscal")

If lVeiculo
	
	RegToMemory("SF1",.F.)
	
	cJustif	:= SF1->F1_JUSTIF
	cMotivo	:= SF1->F1_MOTIVO
	cRefat	:= SF1->F1_REFAT
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Montagem do aHeader                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SX3")
	dbSetOrder(1)
	If dbSeek("SF1")
		While ( !Eof() .And. (SX3->X3_ARQUIVO == "SF1") )
			If ( X3USO(SX3->X3_USADO) .And. ;
				AllTrim(SX3->X3_CAMPO) $ "F1_DOC|F1_SERIE|F1_FORNECE|F1_LOJA|F1_EMISSAO|F1_DTDIGIT" .And. ;
				cNivel >= SX3->X3_NIVEL )
				
				Aadd(aHeader,{ TRIM(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				SX3->X3_VALID,;
				SX3->X3_USADO,;
				SX3->X3_TIPO,;
				SX3->X3_ARQUIVO,;
				SX3->X3_CONTEXT } )
			EndIf
			dbSelectArea("SX3")
			dbSkip()
		EndDo
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Montagem do aCols                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SF1")
	AADD(aCols,Array(Len(aHeader)))
	For nCntFor:=1 To Len(aHeader)
		If ( aHeader[nCntFor,10] <>  "V" )
			aCols[Len(aCols)][nCntFor] := FieldGet(FieldPos(aHeader[nCntFor,2]))
		Else
			aCols[Len(aCols)][nCntFor] := CriaVar(aHeader[nCntFor,2])
		EndIf
	Next nCntFor
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta a tela de exibicao dos dados           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE MSDIALOG oDlg TITLE "Digitação do motivo, justificativa e refaturado de devoluções" FROM 09,00 TO 32.2,80
	
	oFolder                := TFolder():New(001,001,aTitles,{"HEADER"},oDlg,,,, .T., .F.,315,161)
	oList      := TWBrowse():New( 5, 1, 310, 42,,{aHeader[1,1],aHeader[2,1],aHeader[3,1],aHeader[4,1],aHeader[5,1],aHeader[6,1]},{30,90,50,30,50,50},oFolder:aDialogs[1],,,,,,,,,,,,.F.,,.T.,,.F.,,, ) //"Numero"###"Serie"###"Cliente"###"Loja"###"DT Emissao"
	oList:SetArray(aCols)
	oList:bLine          := {|| {aCols[oList:nAt][1],aCols[oList:nAt][2],aCols[oList:nAt][3],aCols[oList:nAt][4],aCols[oList:nAt][5]}}
	oList:lAutoEdit  := .F.
	
	@ 051,005 SAY RetTitle("F1_JUSTIF")    SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
	@ 066,005 SAY RetTitle("F1_MOTIVO")   SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
	@ 081,005 SAY RetTitle("F1_REFAT")    SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
	//                @ 095,005 SAY RetTitle("F2_PBRUTO")    SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
	//                @ 110,005 SAY RetTitle("F2_ESPECI1")   SIZE 40,10 PIXEL OF oFolder:aDialogs[1]
	
	@ 051,050 MSGET M->F1_JUSTIF     PICTURE PesqPict("SF1","F1_JUSTIF")   SIZE 50,07 PIXEL OF oFolder:aDialogs[1] VALID (AFATDisp(@cJustif)) // VALID IIf(Vazio(),(cVeicul1:="",.T.),.F.) .Or. (AFATDisp(@cVeicul1))
	@ 066,050 MSGET M->F1_MOTIVO     PICTURE PesqPict("SF1","F1_MOTIVO")   F3 CpoRetF3("F1_MOTIVO") SIZE 50,07 PIXEL OF oFolder:aDialogs[1]  VALID (vazio() .or. ExistCpo("SX5","Z5"+M->F1_MOTIVO)) .AND. (AFATDisp(@cMotivo)) //VALID IIf(Vazio(),(cTransp:="",.T.),.F.) .Or. (ExistCpo("SA4").And.AFATDisp(@cTransp))
	@ 081,050 COMBOBOX M->F1_REFAT items aCombo /*PICTURE PesqPict("SF1","F1_REFAT")*/    SIZE 50,07 PIXEL OF oFolder:aDialogs[1]  VALID (AFATDisp(@cRefat)) // VALID IIf(Vazio(),(cVeicul2:="",.T.),.F.) .Or. (AFATDisp(@cVeicul2))
	//                @ 095,050 MSGET M->F2_PBRUTO     PICTURE PesqPict("SF2","F2_PBRUTO")   SIZE 50,07 PIXEL OF oFolder:aDialogs[1]// VALID IIf(Vazio(),(cVeicul3:="",.T.),.F.) .Or. (AFATDisp(@cVeicul3))
	//                @ 110,050 MSGET M->F2_ESPECI1    PICTURE PesqPict("SF2","F2_ESPECI1")  SIZE 50,07 PIXEL OF oFolder:aDialogs[1]// VALID IIf(Vazio(),(cVeicul3:="",.T.),.F.) .Or. (AFATDisp(@cVeicul3))
	
	@ 051,105 MSGET oJustif         VAR cJustif      PICTURE PesqPict("SF1","F1_JUSTIF")    WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
	@ 066,105 MSGET oMotivo         VAR cMotivo      PICTURE PesqPict("SF1","F1_MOTIVO")    WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
	@ 081,105 MSGET oRefat          VAR cRefat       PICTURE PesqPict("SF1","F1_REFAT")     WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
	//                @ 095,105 MSGET oVeicul3        VAR cVeicul3     PICTURE PesqPict("SF2","F2_PBRUTO")    WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
	//                @ 110,105 MSGET oVeicul4        VAR cVeicul4     PICTURE PesqPict("SF2","F2_ESPECI1")   WHEN .F. SIZE 150,07 PIXEL OF oFolder:aDialogs[1]
	
	@ 110,005 TO 111,310 PIXEL OF oFolder:aDialogs[1]
	@ 126,225 BUTTON "Confirmar"      SIZE 040,13 FONT oFolder:aDialogs[1]:oFont ACTION (nOpc:=1,oDlg:End()) OF oFolder:aDialogs[1] PIXEL     //"Confirmar"
	@ 126,270 BUTTON "Cancelar"       SIZE 040,13 FONT oFolder:aDialogs[1]:oFont ACTION oDlg:End()                                            OF oFolder:aDialogs[1] PIXEL     //"Cancelar"
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	If nOpc == 1
		RecLock("SF1",.F.)
		SF1->F1_MOTIVO	:= M->F1_MOTIVO
		SF1->F1_JUSTIF	:= M->F1_JUSTIF
		SF1->F1_REFAT	:= M->F1_REFAT
		MsUnlock()
	Endif
Else
	MsgAlert("Teste")
Endif

RestArea(aArea)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³AFATDisp  ³ Autor ³ Sergio S. Fuzinaka    ³ Data ³ 14.12.05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Display do Campo                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AFATDisp(cCampo)

Local aArea        := GetArea()
Local cCpo          := ReadVar()

Do Case
	Case cCpo == "M->F1_MOTIVO"
		cCampo := Posicione("SX5",1,xFilial("SX5")+"Z5"+M->F1_MOTIVO,"X5_DESCRI")
		oMotivo:Refresh()
	Case cCpo == "M->F1_JUSTIF"
		cCampo               := M->F1_JUSTIF
		oJustif:Refresh()
	Case cCpo == "M->F1_REFAT"
		cCampo               := M->F1_REFAT
		oRefat:Refresh()
		/*                Case cCpo == "M->F2_ESPECI1"
		cCampo               := M->F2_ESPECI1
		oVeicul4:Refresh()
		Otherwise
		cCampo               := M->F2_PBRUTO
		oVeicul3:Refresh()         */
EndCase

RestArea(aArea)

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MOTDEV    ºAutor  ³Microsiga           º Data ³  05/07/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Devfecha

Local aAreadev		:= Getarea()
DBSELECTAREA("SX6")
DBSETORDER(1)
If DBSEEK("  "+"MV_ULDTDEV")
	dDtFecha	:= CTOD(ALLTRIM(SX6->X6_CONTEUD))
	
	
	@ 100,001 To 350,400 Dialog oDlg Title "Fechamento das devoluções"
	@ 024,014 Say OemToAnsi("Digite a data do fechamento") Size 110,12 PIXEL of oDlg
	@ 034,014 msGet dDtFecha Size 110,12 PIXEL of oDlg
	@ 074,130 BMPBUTTON TYPE 01 ACTION execfecha(dDtFecha)
	@ 074,160 BmpButton Type 02 Action Close(oDlg)
	Activate Dialog oDlg Centered
	
EndIf
RestArea(aAreadev)

Return


//Executa o fechamento
Static Function execfecha(dDtFecha)


If msgyesno("Deseja realizar o fechamento com data de: "+DTOC(dDtFecha)+" ?")
	DBSELECTAREA("SX6")
	DBSETORDER(1)
	DBSEEK("  "+"MV_ULDTDEV")
	RECLOCK("SX6")
	SX6->X6_CONTEUD	:= DTOC(dDtFecha)
	MSUNLOCK()
	
	dDataFecha	:= dDtFecha
	dbSelectArea("SF1")
	IndRegua("SF1",cArqInd,IndexKey(),,cFiltSF1)
	nIndex := RetIndex("SF1")
	#IFNDEF TOP
		dbSetIndex(cArqInd+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
	dbgotop()
	
EndIf


Close(oDlg)

Return
