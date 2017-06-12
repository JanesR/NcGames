#define FIX_ENCHOICELEFT		1 	 /* esquerda FIXA da enchoice */
#define FIX_ENCHOICERIGHT		315	 /* direita FIXA da enchoice */	//?? este número deveria ser o misterioso 315
#define DFL_ENCHOICETOP			12	 /* default para a cordenada TOP da enchoice */
#define IDX_ENCHOICETOP			1 	 /* índice desta cordenada dentro do Array aPos */
#define DFL_ENCHOICEBOTTOM		143	 /* default para a cordenada BOTTOM da enchoice */
#define IDX_ENCHOICEBOTTOM		3 	 /* índice desta cordenada dentro do Array aPos */

#define IDX_ENCHOICELEFT		2   //FGODOY
#define IDX_ENCHOICERIGHT		4   //FGODOY

#define ENCHOICE_TOP 		    3 	/* distância entre o primeiro controle e o topo da enchoice */
#define ENCHOICE_LINEHEIGHT		11	/* altura de cada linha da enchoice */
#define ENCHOICE_LINESPACE		6 	/* folga da edit em relação a linha */
#define ENCHOICE_HEIGHT			8 	/* altura do say que mostra o nome do campo */

#define LARG_BTNBMP				7 	/* largura do botão para editar memos e bitmaps */
#define FOLGA_BTNBMP			3 	/* folga entre o botão e o label com a descrição  */

#define ENCHOICE_LARGBOTAO		9 	/* largura do botão dentro dos gets */

#include "mscolors.ch"
#include "protheus.ch"
#include "msmgetpr.ch"
#include "style.ch"

//********************************************************//
// Classe de Enchoice                                     //
//********************************************************//

Static lEntryPoint , lX3FOLDER, lX3MEMO, lBmpStretch

CLASS MSMGET
	DATA oBox
	DATA oMemoFont

	DATA hWnd

	DATA lFolder
	DATA lNoSX3
	DATA lColumn
	DATA lActive

	DATA cAlias

	DATA aGets
	DATA aTela
	DATA aRotina
	DATA aPrompts
	DATA aEntryCtrls
	DATA aTop

	DATA nCtrl
	
	METHOD New(cAlias, nReg, nOpc, aACho, aPos, aCpos, nModelo, oWnd,lF3,lMemoria) CONSTRUCTOR
	METHOD EnchRefreshAll()
	METHOD EnchExecTrig(cCampo)
	METHOD Hide()
	METHOD Show()
	METHOD Refresh()
	METHOD ValFolder()
	METHOD CalcFieldSize()
	METHOD EnchTop(nFolder)
	METHOD EnchMemo(uVar,lF3,lVisual,cTitulo,nSize,lDisable)
	METHOD MontaArray(nOpc,lF3,lMemoria,lIncluir)
	METHOD MontArray2(nOpc,aAcho,lF3,lMemoria,lIncluir)
	METHOD MontArray3(aField,nOpc,lF3,lIncluir,aFolder)
	METHOD SetFocus()
	METHOD GoToCtrl()
	METHOD Enable()
	METHOD Disable()
	METHOD ResetScroll()
ENDCLASS

//----------------------------------------------------------------------//
METHOD ResetScroll() CLASS MSMGET
Local ni
Local nLen

If ::lFolder
	nLen := Len(::aPrompts)

	For ni := 1 To nLen
		::oBox:aDialogs[ni]:Cargo:Reset()
	Next	
Else
	::oBox:Reset()
Endif

Return Nil

//----------------------------------------------------------------------//
METHOD SetFocus() CLASS MSMGET
Local nI
Local bError
Local aCtrls

If ::lFolder
	aCtrls := ::oBox:aDialogs[::oBox:nOption]:Cargo:Cargo
Else
	aCtrls := ::oBox:Cargo
EndIf

If !Empty(aCtrls)
	bError := ErrorBlock({|e| .T.})
	For nI := 1 To Len(aCtrls)
		If nI <> ::nCtrl
			aCtrls[nI]:cText(&(aCtrls[nI]:cReadVar))
		EndIf
	Next nI
	aCtrls[1]:SetFocus()
	ErrorBlock(bError)
EndIf
Return

//----------------------------------------------------------------------//
METHOD EnchExecTrig(cCampo) CLASS MSMGET
Local cCurAlias := Alias(), nOldOrd
dbSelectArea("SX3") // seleciona o SX3 p/ poder posicionar no registro certo
nOldOrd:=IndexOrd() // guarda a ordem atual do SX3
dbSetOrder(2)		 // acha o reg.
dbSeek(cCampo)		 //
dbSetOrder(nOldOrd) // recupera a ordem

If !Empty(cCurAlias)
	dbSelectArea(cCurAlias)
EndIf
RunTrigger(1,,,Self)
return nil

//----------------------------------------------------------------------//
METHOD EnchRefreshAll() CLASS MSMGET
Local nCtrl := 1, nNumCtrls := Len(::aEntryCtrls)
FOR nCtrl := 1 TO nNumCtrls
	::aEntryCtrls[nCtrl]:Refresh()
NEXT
return nil

//----------------------------------------------------------------------//
METHOD Refresh() CLASS MSMGET
Return ::EnchRefreshAll()

//----------------------------------------------------------------------//
METHOD Hide() CLASS MSMGET
::oBox:Hide()
If ::lFolder
	::oBox:aDialogs[::oBox:nOption]:Hide()
EndIf
Return Nil

//----------------------------------------------------------------------//
METHOD Show() CLASS MSMGET
::oBox:Show()
If ::lFolder
	::oBox:aDialogs[::oBox:nOption]:Show()
EndIf
Return Nil

//----------------------------------------------------------------------//
METHOD ValFolder() CLASS MSMGET
Local i, j
Local nFolder
Local nLen := Len(::aPrompts)
Local cPrompt
Local cUpper
Local cChar := ""

nFolder := Ascan(::aGets,{|x| Subs(x,27,1) == "Z"})

If nFolder > 0 .and. nFolder > nLen
	Aadd(::aPrompts,STR0001)
	nLen++
EndIf

//coloca "&" nos titulos das pastas p/ acesso via hotkey
For i := 1 To nLen
	cPrompt := ::aPrompts[i]
	cUpper := Upper(cPrompt)

	For j := 1 To Len(cUpper)
		If !(Subs(cUpper,j,1) $ cChar)
			cPrompt := Subs(cPrompt,1,j-1)+"&"+Subs(cPrompt,j)
			cChar += Subs(cUpper,j,1)
			::aPrompts[i] := cPrompt
			Exit
		EndIf
	Next
Next
Return NIL

//----------------------------------------------------------------------//
METHOD EnchMemo(uVar,lF3,lVisual,cTitulo,nSize,lDisable) CLASS MSMGET
Local oMain := GetWndDefault(),oDlg,oBt1,oBt2,oMemo,oFont
Local nTam := 0, nLargJan, nLargMemo
Local cGet := &(uVar)
Local lOK := .F.

// Tamanho do Campo
nTam := If(nSize == NIL,TamSX3(SUBS(uVar,4,10))[1],nSize)
// Mantem o tamanho Default em char.
nTam := If(nTam == 0 .or. nTam == 10,56,nTam)
// Se tamanho menor que tamanho titulo, considerar o tam do Titulo
nTam := If(nTam < Len(Trim(cTitulo)),Len(Trim(cTitulo))+2,nTam)
// Calcular largura da janela
nLargJan := (nTam * 6)+27
// Encerra Fonte e inicializa o Novo
oFont := TFont():New("FW Microsiga",8,0,.F.,.F.,,,,.F.,.F.,,,,,,)

DEFINE MSDIALOG oDlg TITLE OemToAnsi(cTitulo) FROM 15,1 TO 173,nLargJan PIXEL OF oMain

DEFINE SBUTTON oBt1 FROM 65,02 TYPE 1 ACTION (lOK := .T., oDlg:End()) ENABLE OF oDlg PIXEL
DEFINE SBUTTON oBt2 FROM 65,33 TYPE 2 ACTION (oDlg:End()) ENABLE OF oDlg PIXEL

If nTam > 50
	nLargMemo := round(3.08 * nTam,0)+7
Else
	nLargMemo := round(3.10 * nTam,0)+8
EndIf

IF lVisual
	@02,02 GET oMemo VAR cGet MULTILINE SIZE nLargMemo,60 FONT oFont READONLY PIXEL OF oDlg NO VSCROLL//194 gilson
Else
	@02,02 GET oMemo VAR cGet MULTILINE SIZE nLargMemo,60 PIXEL OF oDlg NO VSCROLL	//194 gilson
	If lDisable
		oMemo:Disable()
	EndIf
Endif

oMemo:cReadVar := uVar
oMemo:oFont := oFont
oMemo:bRClicked := {||AllwaysTrue()}

ACTIVATE MSDIALOG oDlg CENTERED

If lOK
	&(uVar) := cGet
EndIf
Return

//----------------------------------------------------------------------//
METHOD CalcFieldSize(cTIPO,nTAMANHO,nDECIMAL,cPICTURE) CLASS MSMGET
Local nRet

If cTIPO == "M"
	If lX3MEMO
		nRet := CalcMemoSize(nTAMANHO)
	Else
		nRet := 1
	EndIf
Else
	nRet := CalcFieldSize(cTIPO,nTAMANHO,nDECIMAL,cPICTURE,"")
EndIf
Return nRet

//----------------------------------------------------------------------//
METHOD EnchTop(nFolder) CLASS MSMGET
Local nRet := 0

DEFAULT nFolder := 1

nFolder := If(::lFolder,nFolder,1)

If nFolder > 0 .and. nFolder <= Len(::aTop)
	nRet := ((::aTop[nFolder][1]-1)*ENCHOICE_LINEHEIGHT)+ENCHOICE_TOP+::aTop[nFolder][2]
EndIf
Return nRet

//----------------------------------------------------------------------//
METHOD MontaArray(nOpc,lF3,lMemoria,lIncluir) CLASS MSMGET
Local cC := ""
Local cLinPos
Local lObrigat
Local nSX3Order
Local lCondicao
Local nPosTela := 0
Local cFolder := "!@#$"
Local nLINHA := 0
Local nCNT2 := 0
Local nCNT3 := 0
Local LVar03 := 0
Local cNewFOld
Local cRealFol := "0"
Local nWidth
Local nZLinha := 0

DEFAULT lIncluir := .f.
DEFAULT lF3      := .F.
DEFAULT lMemoria := .F.

DbSelectArea("SX3")
nSX3Order := IndexOrd()
DbSetOrder(If(::lFolder,4,1))

If !DbSeek(::cAlias)
	Tone(3000,1)
	Return 0
EndIf

While X3_ARQUIVO == ::cAlias

	lObrigat := VerByte(X3_RESERV,7) .or. (Subs(Bin2Str(X3_OBRIGAT),1,1) == "x")
	lCondicao := (cNivel >= X3_NIVEL) .or. lObrigat

	If !X3Uso(X3_USADO) .or. !lCondicao
		DbSkip()
		Loop
	EndIf
	
	If ::lFolder
		If cFolder <> X3_FOLDER
			nLinha := 0
			nCNT3 := 0
			cFolder := X3_FOLDER
			If ( Empty(cFolder) )
				cNewFold := "Z"
			Else
				DbSelectArea("SXA")
				DbSetOrder(1)
				If DbSeek(::cAlias+cFolder)
					Aadd(::aPrompts,Capital(AllTrim(XADescric())))
					cRealFol := Soma1(cRealFol)
					cNewFold := cRealFol
				Else
					cNewFold := "Z"
				EndIf
				DbSelectArea("SX3")
			EndIf
		EndIf
	Else
		cFolder := " "
		cNewFold := " "
	EndIf

	nCNT3++
	nCNT2++

	If ("BITMAP" $ X3_CAMPO)
		LVar03 := STR0002	//"Imagem"

	ElseIf X3_TIPO == "M"
		LVar03 := "Memo"
	
	ElseIf X3_CONTEXT != "V"
		If lF3
			cC := "M->"+Trim(X3_CAMPO)
		Else
			cC := Iif((::aRotina[nOpc][4] >=3 .and. ::aRotina[nOpc][4] <= 4) .or. lMemoria,"M->"+Trim(X3_CAMPO),::cAlias+"->"+Trim(X3_CAMPO))
		EndIf
		lVar03 := &cC

	Else
		cC := "M->"+Trim(X3_CAMPO)
		If Type(cC) == "U"
			LVar03 := CriaVar(X3_CAMPO)
		Else
			LVar03 := &cC
		EndIf
	EndIf

	nWidth := ::CalcFieldSize(X3_TIPO,X3_TAMANHO,X3_DECIMAL,X3_PICTURE)

	If nCNT3 == 1 .Or. ::lColumn
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Move o campo para os array                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cNewFold == "Z"
			nZLinha++
			nLinha := nZLinha
		Else
			nLINHA++
		EndIf
		nPosTela++
		cLinPos := RetAsc(StrZero(nLinha),2,.T.)
		Aadd(::aTELA,{X3Titulo(),Transform(LVar03,Trim(X3_PICTURE))," "," ",cNewFold+cLinPos})
		Aadd(::aGETS,cLinPos+"1"+X3_ARQUIVO+X3_ORDEM+X3_CAMPO+X3_F3+Iif(lObrigat,"T","F")+X3_TIPO+cNewFold)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Se o primeiro campo ultrapassa a reserva do segundo  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nWidth >= ENCH_TAM1GET
			nCNT3 := 0
		EndIf
	Else
		If nWidth >= ENCH_TAM1GET
			nCNT3 := 0
			Loop
		EndIf
		::aTela[nPosTela,3] := X3Titulo()
		::aTela[nPosTela,4] := Transform(LVar03,Trim(X3_PICTURE))
		cLinPos := RetAsc(StrZero(nLinha),2,.t.)
		Aadd(::aGets,cLinPos+"2"+X3_ARQUIVO+X3_ORDEM+X3_CAMPO+X3_F3+Iif(lObrigat,"T","F")+X3_TIPO+cNewFold)
		nCNT3 := 0
	EndIf
	DbSkip()
End

DbSelectArea("SX3")
DbSetOrder(nSX3Order)
Return ::aPrompts

//----------------------------------------------------------------------//
METHOD MontArray2(nOpc,aAcho,lF3,lMemoria,lIncluir) CLASS MSMGET
Local cC := ""
Local cLinPos
Local lObrigat
Local lCondicao
Local iIdxCopia
Local nSX3Order
Local nPosTela := 0
Local cFolder := "!@#$"
Local nLINHA := 0
Local nCNT2 := 0
Local nCNT3 := 0
Local LVar03 := 0
Local iTamCopia                      // usado para copiar de aAcho para aPadAcho
Local aPadAcho := Array(Len(aAcho)) // cria um array primo do aAcho no qual o pad já vai ter sido feito
Local cRealFol := "0"
Local cNewFold
Local nWidth
Local nZLinha := 0
Local lAddUser := (Ascan(aAcho,"NOUSER") == 0)

DEFAULT lIncluir := .f.
DEFAULT lF3      := .F.
DEFAULT lMemoria := .F.

DbSelectArea("SX3")
nSX3Order := IndexOrd()
DbSetOrder(If(::lFolder,4,1))
DbSeek(::cAlias)

iTamCopia := Len(aAcho)
For iIdxCopia := 1 To iTamCopia
	aPadAcho[iIdxCopia] := Padr(aAcho[iIdxCopia],10)
End

While X3_ARQUIVO == ::cAlias

	lObrigat := VerByte(X3_RESERV,7) .or.  (Subs(Bin2Str(X3_OBRIGAT),1,1) == "x")
	lCondicao := (cNivel >= X3_NIVEL) .or. lObrigat

	If (lAddUser .and. X3_PROPRI == "U") .or. X3_PROPRI == "T"	//campo de usuario ou template
		lCondicao := (lCondicao .and. X3Uso(X3_USADO))
		nPos := 1
	Else
		nPos := Ascan(aPadAcho,X3_CAMPO )
	EndIf

	If (nPos > 0 .and. lCondicao)
		If ::lFolder
			If cFolder <> X3_FOLDER
				nLinha := 0
				nCNT3 := 0
				cFolder := X3_FOLDER
				If ( Empty(cFolder) )
					cNewFold := "Z"
				Else
					DbSelectArea("SXA")
					DbSetOrder(1)
					If DbSeek(::cAlias+cFolder)
						Aadd(::aPrompts,Capital(AllTrim(XADescric())))
						cRealFol := Soma1(cRealFol)
						cNewFold := cRealFol
					Else
						cNewFold := "Z"
					EndIf
					DbSelectArea("SX3")
				EndIf
			EndIf
		Else
			cFolder := " "
			cNewFold := " "
		EndIf
		
		nCNT3++
		nCNT2++
		
		If ("BITMAP" $ X3_CAMPO)
			LVar03 := STR0002	//"Imagem"
		
		ElseIf X3_TIPO == "M"
			LVar03 := "Memo"

		ElseIf X3_CONTEXT != "V"
			If lF3
				cC := "M->"+Trim(X3_CAMPO)
			Else
				cC := Iif(((::aRotina[nOpc][4] >= 3 .and. ::aRotina[nOpc][4] <= 4) .or. lMemoria),"M->"+Trim(X3_CAMPO),::cAlias+"->"+Trim(X3_CAMPO))
			EndIf
			LVar03 := &cC

		Else
			cC := "M->"+Trim(X3_CAMPO)
			If Type(cC) == "U"
				LVar03 := CriaVar(X3_CAMPO)
			Else
				LVar03 := &cC
			EndIf
		EndIf

		nWidth := ::CalcFieldSize(X3_TIPO,X3_TAMANHO,X3_DECIMAL,X3_PICTURE)

		If nCNT3 == 1 .Or. ::lColumn
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Move o campo para os array                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cNewFold == "Z"
				nZLinha++
				nLinha := nZLinha
			Else
				nLINHA++
			EndIf
			nPosTela++
			cLinPos := RetAsc(StrZero(nLinha),2,.T.)
			Aadd(::aTELA,{X3Titulo(),Transform(LVar03,Trim(X3_PICTURE))," "," ",cNewFold+cLinPos})
			Aadd(::aGETS,cLinPos+"1"+X3_ARQUIVO+X3_ORDEM+X3_CAMPO+X3_F3+Iif(lObrigat,"T","F")+X3_TIPO+cNewFold)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Se o primeiro campo ultrapassa a reserva do segundo  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nWidth >= ENCH_TAM1GET
				nCNT3 := 0
			EndIf
		Else
			If nWidth >= ENCH_TAM1GET
				nCNT3 := 0
				Loop
			EndIf
			::aTELA[nPosTela,3] := X3Titulo()
			::aTELA[nPosTela,4] := TRANSFORM(LVar03,Trim(x3_picture))
			cLinPos := RetAsc(StrZero(nLinha),2,.T.)
			Aadd(::aGETS,cLinPos+"2"+X3_ARQUIVO+X3_ORDEM+X3_CAMPO+X3_F3+Iif(lObrigat,"T","F")+X3_TIPO+cNewFold)
			nCNT3 := 0
		EndIf
	EndIf
	DbSkip()
End

DbSelectArea("SX3")
DbSetOrder(nSX3Order)
Return ::aPrompts

METHOD MontArray3(aField,nOpc,lF3,lIncluir,aFolder) CLASS MSMGET
Local i, j
Local cC := ""
Local cLinPos
Local lObrigat
Local lCondicao
Local nPosTela := 0
Local nLINHA := 0
Local nCNT2 := 0
Local nCNT3 := 0
Local LVar03 := 0
Local xOrdem := "00"
Local nFolder := -1
Local cNewFOld
Local cRealFol := "0"
Local nLen := If(Empty(aFolder),0,Len(aFolder))
Local nWidth

/*
aField:
[1]  -> titulo
[2]  -> campo
[3]  -> tipo
[4]  -> tamanho
[5]  -> decimal
[6]  -> picture
[7]  -> valid
[8]  -> obrigat
[9]  -> nivel
[10] -> inicializador padrao
[11] -> F3
[12] -> when
[13] -> visual
[14] -> chave
[15] -> box
[16] -> folder
[17] -> nao alteravel
[18] -> pictvar

agets:
linha + coluna + alias + ordem + campo + F3 + obrigat + tipo + folder
2     + 1      + 3     + 2     + 10    + 6  + 1       + 1    + 1

atela:
[1] -> titulo coluna 1
[2] -> valor coluna 1
[3] -> titulo coluna 2
[4] -> valor coluna 2
[5] -> folder + linha
*/

DEFAULT lIncluir := .f.
DEFAULT lF3      := .F.
DEFAULT nLen	 := 0

If Empty(aField)
	Tone(3000,1)
	Return 0
EndIf

For i := 1 To Len(aField)

	lObrigat := aField[i][8]
	lCondicao := (cNivel >= aField[i][9]) .or. lObrigat

	If lCondicao
		nCNT3++
		nCNT2++
		xOrdem := Soma1(xOrdem)
		
		aField[i][2]  := Padr(aField[i][2],10)
		For j := 6 To Len(aField[i])
			If j == 16
				DEFAULT aField[i][j] := 0
			ElseIf j <> 8 .and. j <> 17
				DEFAULT aField[i][j] := ""
			EndIf
		Next
	
		If ::lFolder
			If nFolder <> aField[i][16]
				nLinha := 0
				nCNT3 := 1
				nFolder := aField[i][16]
				If nFolder == 0
					cNewFold := "Z"
				ElseIf nFolder > nLen
					cNewFold := "Z"
				Else
					Aadd(::aPrompts,aFolder[nFolder])
					cRealFol := RetAsc(nFolder,1,.T.)
					cNewFold := cRealFol
				EndIf
			EndIf
		Else
  			cNewFold := " "
		EndIf
		
		If ("BITMAP" $ aField[i][2])
			LVar03 := "Imagem"

		ElseIf aField[i][3] == "M"
			LVar03 := "Memo"

		Else
			cC := "M->"+Trim(aField[i][2])
			LVar03 := &cC
		EndIf

		nWidth := ::CalcFieldSize(aField[i][3],aField[i][4],aField[i][5],aField[i][6])

		If nCNT3 == 1 .Or. ::lColumn
			nLINHA++
			nPosTela++
			cLinPos := RetAsc(StrZero(nLinha),2,.T.)
			Aadd(::aTela,{aField[i][1],Transform(LVar03,Trim(aField[i][6]))," "," ",cNewFold+cLinPos})
			Aadd(::aGets,cLinPos+"1"+"   "+xOrdem+aField[i][2]+Padr(aField[i][11],6)+Iif(lObrigat,"T","F")+aField[i][3]+cNewFold)
			
			If nWidth >= ENCH_TAM1GET
				nCNT3 := 0
			EndIf
		Else
			If nWidth >= ENCH_TAM1GET
				nCNT3 := 0
				i--
			Else
				::aTela[nPosTela,3] := aField[i][1]
				::aTela[nPosTela,4] := Transform(LVar03,Trim(aField[i][6]))
				cLinPos := RetAsc(StrZero(nLinha),2,.t.)
				Aadd(::aGets,cLinPos+"2"+"   "+xOrdem+aField[i][2]+Padr(aField[i][11],6)+Iif(lObrigat,"T","F")+aField[i][3]+cNewFold)
				nCNT3 := 0
			EndIf
		EndIf
	EndIf
Next
Return ::aPrompts

/*====================================================================================
// PROPRIEDADOS DA MSMGET - Enchoice
cAlias	-> tabela sendo alterada
nReg		->
nOpc		-> nOpc é usado para permitir o acesso a aRotina
aCRA		-> obsoleto
cLetras	-> obsoleto
cTexto	-> obsoleto
aACho 	-> provavelmente obsoleto
aPos		-> Array que contém as coordenadas da enchoice (apenas top e bottom)
aCpos 	-> campos que devem aceitar a edição
nModelo	->
nColMens -> obsoleto
cMensagem-> obsoleto
cTudoOk	-> obsoleto
oWnd		-> Tela que contém a enchoice
lF3		-> Determina se estamos dentro de uma compad
lMemoria -> Determina se TODOS os dados devem vir de variáveis de memória
====================================================================================*/
METHOD New(cAlias,nReg,nOpc,aCRA,cLetras,cTexto,aACho,aPos,aCpos,nModelo,nColMens,cMensagem, cTudoOk,oWnd,lF3,lMemoria,lColumn,caTela,lNoFolder,lProperty,aField,aFolder,lCreate,lNoMDIStretch) CLASS MSMGET
Local oBtn
Local oEditControl
Local oBox
Local oSay

Local ni
Local nLen
Local nDifTop1 := 0
Local nDifTop2 := 0
Local nAuxTop
Local nAuxLeft
Local nAuxWidth
Local nAuxHeight := ENCHOICE_LINEHEIGHT - ENCHOICE_LINESPACE
Local nMemoHeight := nAuxHeight*3.3
Local nBmpSize := ENCH_COL2SAY-ENCH_COL1GET-5
Local nRetAsc
Local nAt

Local nLaGets
Local nMaxLenCombo
Local nInitCBox
Local nPos := 0
Local nFolder
Local nTop
Local nRight
Local nLeft
Local nBottom
Local iGetLine := 1
Local nClientWidth

Local lCampoAlteravel
Local lEnchoiceAlteravel
Local lPriCol
Local laTela := .T.
Local lBitmap

Local cNomeVar
Local cPicture
Local cInitValue
Local cGetLine
Local cValid
Local cWhen
Local cPictVar
Local cControl
Local cLinTela
Local cColTela

Local cX3CAMPO
Local cX3F3
Local cX3TIPO
Local cX3VISUAL
Local cX3CHAVE
Local cX3NALTERA
Local cX3CONTEXT
Local cX3TITULO
Local cX3WHEN
Local cX3VLDUSER
Local cX3VALID
Local cX3TRIGGER
Local cX3PICTVAR
Local cX3PICTURE
Local cX3CBOX
Local nX3TAMANHO
Local nX3DECIMAL

Local bWhen
Local bValid
Local bBloco
Local bAction
Local bRemove

Local aComboText
Local aComboData
Local aBlock := {}

Local uVar

Local nRegSX3	:= SX3->(Recno())
Local nOrdSX3	:= SX3->(IndexOrd())
Local lFlatMode := FlatMode()

DEFAULT cAlias	  := Alias()
DEFAULT oWnd	  := GetWndDefault()
DEFAULT lF3 	  := .F.
DEFAULT lMemoria  := .F.
DEFAULT lColumn   := .F.
DEFAULT caTela    := ""
DEFAULT lNoFolder := .F.
DEFAULT lProperty := .F.
DEFAULT lCreate   := .F.
DEFAULT lNoMDIStretch := .F.

CursorWait()
SetEntryPoint(If(nModelo == NIL,.T.,nModelo == 1))
SetDlg(oWnd)
__SetEncMemo()

oWnd:Owner():lEscClose:= .F. // desabilita o fechamento por ESC da tela
oWnd:bRClicked := {|o,nCol,nLin| GetApply( o, nCol, nLin, cAlias, .F.,(::aRotina[nOpc][4] == 3 .Or. ::aRotina[nOpc][4] == 4), {|aParms| ApplyParms(aParms,Self)})}

::aEntryCtrls := {}
::aPrompts    := {}
::aTela       := If(Type("aTela") == "U" .or. lProperty,{},aTela)
::aGets       := If(Type("aGets") == "U" .or. lProperty,{},aGets)
::cAlias      := cAlias
::lColumn     := lColumn
::lNoSX3      := (aField <> NIL)
::aTop        := {}
::nCtrl		  := 0
::lActive    := .T.

If Type("aRotina") == "U" .or. lProperty
	::aRotina := {}
	Aadd(::aRotina,{"","",0,1})	// "Pesquisar"
	Aadd(::aRotina,{"","",0,2})	// "Visualizar"
	Aadd(::aRotina,{"","",0,3})	// "Incluir"
	Aadd(::aRotina,{"","",0,4})	// "Alterar"
	Aadd(::aRotina,{"","",0,5})	// "Excluir"
Else
	::aRotina := aRotina
EndIf

// descobre se esta enchoice aceita edições
lEnchoiceAlteravel := lF3 .or. ;
					  ::aRotina[nOpc][4] == 3 .or. ;
					  ::aRotina[nOpc][4] == 4 .or. ;
					  ::aRotina[nOpc][4] == 6

// Desativa variaveis Inclui e Altera se rotina de Visualizacao / Exclusao
INCLUI := If(Type("INCLUI") == "U",.T.,INCLUI)
INCLUI := If(::aRotina[nOpc][4] == 2 .or. ::aRotina[nOpc][4] == 5,.F.,INCLUI)

ALTERA := If(Type("ALTERA") == "U",.T.,ALTERA)
ALTERA := If(::aRotina[nOpc][4] == 2 .or. ::aRotina[nOpc][4] == 5,.F.,ALTERA)

// faz uma LIMPEZA no conteúdo do array (TrimAll)
If aCpos != NIL
	For ni := 1 To Len(aCpos)
		aCpos[ni]:= Alltrim(aCpos[ni])
	Next
Endif

If ::lNoSX3
	lMemoria := .T.
	::lFolder := !Empty(aFolder)
	If Len(::aTela) == 0
		::MontArray3(aField,nOpc,lF3,::aRotina[nOpc][4] == 3,aFolder)
		If lCreate .and. ::lFolder
			::aPrompts := aFolder
		EndIf
	EndIf
Else
	If lNoFolder
		::lFolder := .F.
	Else
		//verifica se existe folder para o alias
		::lFolder := SXA->(DbSeek(::cAlias))

		If lX3Folder == NIL
			nRegX6 := SX6->(Recno())
			If GetMv('MV_X3FOLDE',.T.)
				lX3Folder := GetMv('MV_X3FOLDE')
			Else
				lX3Folder := .t.
			EndIf
			SX6->(DbGoto(nRegX6))
		EndIf
		::lFolder := ::lFolder .And. lX3Folder
	EndIf
	
	//se o array "aTela" nao foi montado...
	If Len(::aTela) == 0
		If aACho != NIL
			::MontArray2(nOpc,aAcho,lF3,lMemoria,::aRotina[nOpc][4] == 3)
		Else
			::MontaArray(nOpc,lF3,lMemoria,::aRotina[nOpc][4] == 3)
		EndIf
	EndIf

	DbSelectArea("SX3")
	DbSetOrder(2)
EndIf

// atela para Folder
If ValType(&cAtela) == "A"
	laTela := .F.
	&cAtela := Aclone(::aTela)
Endif

If ::lFolder
	::aGets := Asort(::aGets,,,{|x,y| (Subs(x,27,1)+Subs(x,1,3)) < (Subs(y,27,1)+Subs(y,1,3))})
	::aTela := Asort(::aTela,,,{|x,y| x[5] < y[5]})
	::ValFolder()
	
	//cria o folder
	nLen := Len(::aPrompts)
	::aTop := Array(nLen)
	Afill(::aTop,{1,1})
	
	nLeft   := If(aPos == NIL .Or. aPos[IDX_ENCHOICELEFT]   == NIL,(FIX_ENCHOICELEFT) ,(aPos[IDX_ENCHOICELEFT]))
	nRight  := If(aPos == NIL .Or. aPos[IDX_ENCHOICERIGHT]  == NIL,(FIX_ENCHOICERIGHT),(aPos[IDX_ENCHOICERIGHT]))
	nTop    := If(aPos == NIL .Or. aPos[IDX_ENCHOICETOP]    == NIL,DFL_ENCHOICETOP    ,aPos[IDX_ENCHOICETOP])
	nBottom := If(aPos == NIL .Or. aPos[IDX_ENCHOICEBOTTOM] == NIL,DFL_ENCHOICEBOTTOM ,aPos[IDX_ENCHOICEBOTTOM])

	::oBox := TFolder():New(nTop,nLeft,::aPrompts,::aPrompts,oWnd,,,,.T.,.F.,(nRight-nLeft),(nBottom-nTop),)
	::oBox:lVisible := .t.
	::oBox:oFont := oWnd:oFont
	If lFlatMode
//		::oBox:SETCSS( STYLE0022 )
	EndIf
		

	If FlatMode() .and. !lNoMDIStretch .and. Abs(nRight - FIX_ENCHOICERIGHT) < 15 .and. Abs(nTop - DFL_ENCHOICETOP) < 15
		::oBox:Align := CONTROL_ALIGN_ALLCLIENT
	EndIf
	
	//cria pastas do folder
	For ni := 1 To nLen
		::oBox:aDialogs[ni]:Cargo := TScrollBox():New(::oBox:aDialogs[ni],0,0,((::oBox:nBottom-::oBox:nTop)-25)/2,((::oBox:nRight-::oBox:nLeft)-4)/2,.T.,.T.,.T.,::oBox:aDialogs[ni])
		::oBox:aDialogs[ni]:Cargo:Align := CONTROL_ALIGN_ALLCLIENT
		::oBox:aDialogs[ni]:Cargo:ReadClientCoors()
		::oBox:aDialogs[ni]:Cargo:Cargo := {}
		::oBox:aDialogs[ni]:Cargo:bRClicked := {|o,nCol,nLin| GetApply( o, nCol, nLin, cAlias,::aRotina[nOpc][4] <> 3,(::aRotina[nOpc][4] == 3 .Or. ::aRotina[nOpc][4] == 4), {|aParms| ApplyParms(aParms,Self)})}
		If lFlatMode
//			::oBox:SETCSS( STYLE0022 )
		EndIf
	Next
Else
	::aTop := {{1,1}}

	// cria o scrollBox
	::oBox := TScrollBox():New(oWnd,0,0, 30,30,.T.,.T.,.T.,oWnd)
	::oBox:lVisible := .t.
	::oBox:oFont    := oWnd:oFont
	::oBox:nLeft	:= If(aPos == NIL .Or. aPos[IDX_ENCHOICELEFT]   == NIL,(FIX_ENCHOICELEFT * 2) ,(aPos[IDX_ENCHOICELEFT]*2))
	::oBox:nRight	:= If(aPos == NIL .Or. aPos[IDX_ENCHOICERIGHT]  == NIL,(FIX_ENCHOICERIGHT * 2),(aPos[IDX_ENCHOICERIGHT]*2))
	::oBox:nTop		:= If(aPos == NIL .Or. aPos[IDX_ENCHOICETOP]    == NIL,DFL_ENCHOICETOP 		  ,aPos[IDX_ENCHOICETOP])*2
	::oBox:nBottom	:= If(aPos == NIL .Or. aPos[IDX_ENCHOICEBOTTOM] == NIL,DFL_ENCHOICEBOTTOM 	  ,aPos[IDX_ENCHOICEBOTTOM])*2
	::oBox:Cargo	:= {}
	::oBox:bRClicked := {|o,nCol,nLin| GetApply( o, nCol, nLin, cAlias,::aRotina[nOpc][4] <> 3,(::aRotina[nOpc][4] == 3 .Or. ::aRotina[nOpc][4] == 4), {|aParms| ApplyParms(aParms,Self)})}

	If FlatMode() .and. !lNoMDIStretch .and. Abs(::oBox:nRight - FIX_ENCHOICERIGHT*2) < 15 .and. Abs(::oBox:nTop - DFL_ENCHOICETOP) < 15
		::oBox:Align := CONTROL_ALIGN_ALLCLIENT
	EndIf

	::hWnd := ::oBox:hWnd
	oBox := ::oBox
EndIf

nLaGets := Len(::aGets)
While iGetLine <= nLaGets
	cGetLine := ::aGets[iGetLine]

	//se for folder troca pai dos objetos pela pasta correspondente
	If ::lFolder
	    nPos := Val(RetAsc(Subs(cGetLine,27,1),2,.F.))
		nPos  := If(nPos > nLen,nLen,nPos)
		If nPos <> nFolder
			nDifTop1 := 0
		EndIf
		nFolder  := nPos
		oBox     := ::oBox:aDialogs[nFolder]:Cargo
		nPos     := Ascan(::aTela,{|x| x[5] == (Subs(cGetLine,27,1)+Subs(cGetLine,1,2))})
		cLinTela := StrZero(nPos,3,0)
	Else
		nFolder := 1
		cLinTela := RetAsc(Substr(cGetLine,1,2),2,.F.)
	EndIf

	nClientWidth := ((oBox:nClientWidth/2)-8)
	cColTela := If(Subs(cGetLine,3,1) == "1","1","3")
	lPriCol	 := Subs(cGetLine,3,1) == "1"
	cX3CAMPO := AllTrim(Subs(cGetLine,9,10))
    cX3TIPO  := Subs(cGetLine,26,1)
	cX3F3    := AllTrim(Subs(cGetLine,19,6))

	If ::lNoSX3
		nPos := Ascan(aField,{|x| AllTrim(x[2]) == cX3CAMPO})
		cX3VISUAL  := If(aField[nPos][13],"V"," ")
		cX3CHAVE   := If(aField[nPos][14],"x"," ")
		cX3NALTERA := If(aField[nPos][17],"x"," ")
		cX3CONTEXT := " "
		cX3TITULO  := AllTrim(aField[nPos][1])
		cX3WHEN    := If(Empty(aField[nPos][12]),"",(Aadd(aBlock,aField[nPos][12]),"Eval(aBlock["+Str(Len(aBlock))+"])"))
		cX3VLDUSER := ""
		cX3VALID   := If(Empty(aField[nPos][7]),"",(Aadd(aBlock,aField[nPos][7]),"Eval(aBlock["+Str(Len(aBlock))+"])"))
		cX3TRIGGER := ""
		cX3PICTVAR := AllTrim(aField[nPos][18])
		cX3PICTURE := AllTrim(aField[nPos][6])
		cX3CBOX    := AllTrim(aField[nPos][15])
		nX3TAMANHO := aField[nPos][4]
		nX3DECIMAL := aField[nPos][5]
	Else
		SX3->(DbSeek(cX3CAMPO)) // posiciona o SX3 no campo em questão
		cX3VISUAL  := SX3->X3_VISUAL
		cX3CHAVE   := Subs(FirstBitOff(Bin2Str(SX3->X3_USADO)),101,1)
		cX3NALTERA := Subs(FirstBitOff(Bin2Str(SX3->X3_USADO)),102,1)
		cX3CONTEXT := SX3->X3_CONTEXT
		cX3TITULO  := AllTrim(OemToAnsi(X3Titulo()))
		cX3WHEN    := AllTrim(SX3->X3_WHEN)
		cX3VLDUSER := AllTrim(SX3->X3_VLDUSER)
		cX3VALID   := AllTrim(SX3->X3_VALID)
		cX3TRIGGER := SX3->X3_TRIGGER
		cX3PICTVAR := AllTrim(SX3->X3_PICTVAR)
		cX3PICTURE := AllTrim(SX3->X3_PICTURE)
		cX3CBOX    := AllTrim(X3CBox())
		nX3TAMANHO := SX3->X3_TAMANHO
		nX3DECIMAL := SX3->X3_DECIMAL
	EndIf
	
	//cria objeto SAY
	nRetAsc  := Val(RetAsc(Substr(cGetLine,1,2),2,.F.))
	nAuxTop	  := ((nRetAsc-1)*ENCHOICE_LINEHEIGHT)+ENCHOICE_TOP+nDifTop1
	nAuxLeft  := If(lPriCol,ENCH_COL1SAY,ENCH_COL2SAY)
	nAuxWidth := If(lPriCol,ENCH_COL1GET-ENCH_COL1SAY, ENCH_COL2GET-ENCH_COL2SAY)
	
	If laTela
		bBloco := &("{|| OemToAnsi(Self:aTela["+cLinTela+"]["+cColTela+"])}")
	Else
		bBloco := &("{|| OemToAnsi("+cAtela+"["+cLinTela+"]["+cColTela+"])}")
	Endif
	
	oSay := TSay():New(((ENCHOICE_LINEHEIGHT - ENCHOICE_HEIGHT)/2)+nAuxTop,nAuxLeft,bBloco,oBox,,oBox:oFont,.F.,.F.,.F.,.T.,If(Subs(cGetLine,25,1) == "T",RGB(0,0,253),CLR_BLACK),oBox:nClrPane,nAuxWidth,ENCHOICE_HEIGHT,.F.,.F.,.F.,.F.,.F.)
	oEditControl := NIL

	If lEnchoiceAlteravel
		
		//verifica se o campo pode ser alterado
		If aCpos <> NIL
			lCampoAlteravel := Ascan(aCpos,{|x| cX3CAMPO == AllTrim(x)}) <> 0
		Else
			lCampoAlteravel := .T. // caso aCpos tenha sido omitido, o campo pode ser alterado
		EndIf
		
		//verifica se o campo e visual
		//ou se e uma alteracao
		//e se e campo chave ou nao alteravel
		If lCampoAlteravel
			lCampoAlteravel := !((cX3VISUAL == "V") .or. ;
								((!lF3 .and. ::aRotina[nOpc][4] == 4) .and. ;
								("x" $ cX3CHAVE .or. ;
								"x" $ cX3NALTERA)))
		EndIf
	Else
		lCampoAlteravel := .F.
	EndIf

	//verifica se e variavel de memoria
	If lEnchoiceAlteravel .or. lMemoria .or. cX3CONTEXT == "V"
		cNomeVar := "M->"+cX3CAMPO
	Else
		cNomeVar := ::cAlias+"->"+cX3CAMPO
	EndIf
	
	//considerar campos virtuais
	If cX3CONTEXT == "V" .and. Type(cNomeVar) == "U"
		//criar variavel private no environment anterior
		_SetOwnerPrvt(cX3CAMPO,CriaVar(cX3CAMPO))
	EndIf
	
	//montagem de controles de edicao
	nAuxLeft := If(lPriCol,ENCH_COL1GET,ENCH_COL2GET)
	cControl := AllTrim(Str(Len(::aEntryCtrls)+1))
	lBitmap := .F.

	//campo bitmap
	If "BITMAP" $ Substr(cGetLine,12,10)
		If ::aRotina[nOpc][4] == 5
			CriaVarMem (cAlias)
		EndIf

		If lX3MEMO
			If ::lColumn
				nDifTop1 += nBmpSize
			Else
				If lPriCol
					If iGetLine < nLaGets
						If Substr(::aGets[iGetLine+1],3,1) # "2"
							nDifTop1 += nBmpSize
						Else
							nDifTop2 := nBmpSize
						EndIf
					EndIf
				Else
					nDifTop1 += nBmpSize
				EndIf
			EndIf

			@nAuxTop-2,nAuxLeft TO nAuxTop+nBmpSize,nAuxLeft+nBmpSize PIXEL OF oBox
			@nAuxTop,nAuxLeft REPOSITORY oEditControl RESOURCE &cNomeVar NOBORDER SIZE nBmpSize,nBmpSize OF oBox PIXEL
			oEditControl:lStretch := __SetBmpStretch()
			lBitmap := .T.
		Else
			If lEnchoiceAlteravel .and. lCampoAlteravel
				bAction := &("{|| "+cNomeVar+" := SelectBmp("+cNomeVar+","+Str(::aRotina[nOpc][4])+")}")
			Else
				bAction := &("{|| SelectBmp("+cNomeVar+","+Str(::aRotina[nOpc][4])+")}")
			EndIf
			TButton():New(nAuxTop,nAuxLeft,STR0002,oBox,bAction,50,10,,,.F.,.T.,.F.,,.F.,{|| Self:lActive},,.F.)
		EndIf
	
	Else

		//campo memo
		If Substr(cGetLine,26,1) == "M"
			If lX3MEMO
				If ::oMemoFont == NIL
					::oMemoFont := TFont():New("Courier New",6,0,.F.,.F.,,,,.F.,.F.,,,,,,)
				EndIf
	
				If ::lColumn
					nDifTop1 += nMemoHeight
				Else
					If lPriCol
						If iGetLine < nLaGets
							If Substr(::aGets[iGetLine+1],3,1) # "2"
								nDifTop1 += nMemoHeight
							Else
								nDifTop2 := nMemoHeight
							EndIf
						EndIf
					Else
						nDifTop1 += nMemoHeight
					EndIf
				EndIf
	
				nAuxWidth := CalcMemoSize(nX3TAMANHO)
				bBloco := &("{|x| if (ValType(x) <> 'U',"+cNomeVar+" := x,"+cNomeVar+")}")
				oEditControl := TMultiGet():New(nAuxTop,nAuxLeft, bBloco,oBox, nAuxWidth,nAuxHeight*4.5, ::oMemoFont,.F.,,,,.T.,,.F.,,.F.,.F.,!lEnchoiceAlteravel,,,.F.,.F.,.T.)
				oEditControl:lCorretor := .T.
				oEditControl:cReadVar := cNomeVar
				If lCampoAlteravel
					oEditControl:bWhen := &("{|| Self:lActive "+If(Empty(cX3WHEN),""," .and. "+cX3WHEN)+"}")
				EndIf
			Else
				If ( "'" $ cX3TITULO )
					bAction := &('{|| Self:EnchMemo("'+cNomeVar+'",lF3,!lEnchoiceAlteravel,"'+cX3TITULO+'",'+Str(nX3TAMANHO)+',!lCampoAlteravel)}')
				Else
					bAction := &("{|| Self:EnchMemo('"+cNomeVar+"',lF3,!lEnchoiceAlteravel,'"+cX3TITULO+"',"+Str(nX3TAMANHO)+",!lCampoAlteravel)}")
				EndIf
				TButton():New(nAuxTop,nAuxLeft,"Memo...",oBox,bAction,50,10,,,.F.,.T.,.F.,,.F.,{|| Self:lActive},,.F.)
			EndIf

		//campo comum
		Else
			nDifTop1 += nDifTop2
			nDifTop2 := 0

			If lCampoAlteravel
				cWhen := "Self:lActive "+If(Empty(cX3WHEN),""," .and. "+cX3WHEN)
	
				//validacao do usuario
				If !Empty(cX3VLDUSER)
					cValid := "("+cX3VLDUSER+")"
				Else
					cValid := ""
				EndIf
	
				//validacao do siga
				If !Empty(cX3VALID)
					If Len(cValid) > 0
						cValid += " .AND. "
					EndIf
					cValid += "("+cX3VALID+")"
				EndIf
	
				//verifica se existe gatilho
				If cX3TRIGGER == "S"
					If Len(cValid) > 0
						cValid := "(lResValid := If(o:lModified .or. (o:Cargo <> NIL .and. o:Cargo <> "+cNomeVar+"),If("+cValid+",(Self:EnchExecTrig('"+cX3CAMPO+"'),.T.),.F.),.T.))"
					Else
						cValid := "(lResValid := .T.),If(o:lModified .or. (o:Cargo <> NIL .and. o:Cargo <> "+cNomeVar+"),Self:EnchExecTrig('"+cX3CAMPO+"'),)"
					EndIf
				Else
					If Len(cValid) > 0
						cValid := "(lResValid := If(o:lModified .or. (o:Cargo <> NIL .and. o:Cargo <> "+cNomeVar+"),"+cValid+",.T.))"
					Else
						cValid := "(lResValid := .T.)"
					EndIf
				EndIf
	
				//executa refresh apos validacao
				cValid += ",(If(Type('lRefresh') == 'L' .and. lRefresh,Self:EnchRefreshAll(),)),lResValid"
				cValid := "{|x,lResValid,o| o := Self:aEntryCtrls["+cControl+"],"+cValid+"}"
			Else
				cWhen  := ""
				cValid := ""
			EndIf
	
			//picture
			cPicture := ""
			If !Empty(cX3PICTVAR) .and. ::aRotina[nOpc][4] # 5
				If lEnchoiceAlteravel
					cPictVar:= "x:PictVar := "+cX3PICTVAR
				Else
					cPictVar := ""
					cPicture := &(cX3PICTVAR)
					nAt := At("%",cPicture)
					If nAt > 0
						cPicture := Subs(cPicture,1,nAt-1)
					EndIf
				EndIf
			Else
				cPicture := cX3PICTURE
				cPictVar := ""
			Endif
	
			// monta o bloco de when (se o campo for alterável e se este existir)
			If !Empty(cPictVar)
				If Empty(cWhen)
					cWhen := cPictVar + "," + cValToChar(lCampoAlteravel)
				Else
					cWhen := "If("+cWhen+",("+cPictVar+",.T.),.F.)"
				EndIf
			EndIf
	
			If Empty(cWhen)
				bWhen := NIL
			Else
				bWhen := &("{|x| "+cWhen+"}")
			EndIf
				
			If Empty(cValid)
				bValid := NIL
			Else
				bValid := &(cValid)
			EndIf
	
			//cria o bloco de get e set usado no combo ou no get
			bBloco := &("{|x| if (ValType(x) <> 'U',"+cNomeVar+" := x,"+cNomeVar+")}")

			//checkbox
			If cX3TIPO == "L"
  
				oEditControl := TCheckBox():New(nAuxTop+2,nAuxLeft,"",bBloco,oBox,50,nAuxHeight,,,oBox:oFont,bValid,,,.F.,.T.,,.F.,bWhen)
			
			//verifica se usa combobox
			ElseIf !Empty( cX3CBOX ) .and. Empty(cX3F3) .and. cX3TIPO == "C" .and.  __MVCOMBOBOX
	
				//retorna items do combo
				cInitValue := &(cNomeVar)
				uVar := cInitValue
				aComboData := RetSX3Box(cX3CBOX,@nInitCBox,@nMaxLenCombo,nX3TAMANHO,@cInitValue)
				nAuxWidth  := CalcFieldSize("C",nMaxLenCombo,0,,"")+10
				aComboText := {}
	
				For ni :=1 To Len(aComboData)
					Aadd(aComboText,aComboData[ni,1])
				Next
	
				If INCLUI
					If !Empty(cInitValue)
						Eval(bBloco,cInitValue)
					EndIf
				Else
					cInitValue := Eval(bBloco)
					If !ALTERA .and. Ascan(aComboData,{|x| x[2] == uVar}) == 0
						Aadd(aComboText,uVar)
					EndIf
				EndIf
	
				//corrige o tamanho do combo
				If ::lColumn
					If nAuxWidth > (nClientWidth-nAuxLeft)
						nAuxWidth := nClientWidth-nAuxLeft
					EndIf
				Else
					If lPriCol
						If (nAuxWidth > ENCH_TAM1GET)
							nAuxWidth := ENCH_TAM1GET
						EndIf
					Else
						If (nAuxWidth > ENCH_TAM2GET)
							nAuxWidth := ENCH_TAM2GET
						EndIf
					EndIf
				EndIf
	
				//cria objeto COMBOBOX
				oEditControl := TComboBox():New(nAuxTop,nAuxLeft,bBloco,aComboText,nAuxWidth,nAuxHeight+4,oBox,0, ,bValid,CLR_DEFAULT,CLR_DEFAULT,.T.,oBox:oFont,"",.F.,bWhen,.F.,{},,"",cNomeVar)
			else
	
				nAuxWidth := CalcFieldSize(cX3TIPO,nX3TAMANHO,nX3DECIMAL,cX3PICTURE,"")
	
				If cX3TIPO != "C"
					nAuxWidth += 20
				ElseIf !Empty(cX3F3) .and. cX3TIPO == "C"
					nAuxWidth += 20
				EndIf
	
				//corrige o tamanho do get
				If ::lColumn
					If nAuxWidth > (nClientWidth-nAuxLeft)
						nAuxWidth := nClientWidth-nAuxLeft
					EndIf
				Else
					If lPriCol
						If nAuxWidth > ENCH_TAM1GET
							If iGetLine < nLaGets
								If Substr(::aGets[iGetLine+1],3,1) # "2"
									nAuxWidth := (FIX_ENCHOICERIGHT - ENCH_TAM1GET)+36
								Else
									nAuxWidth := ENCH_TAM1GET
								EndIf
							EndIf
						EndIf
					Else
						If (nAuxWidth > ENCH_TAM2GET)
							nAuxWidth := ENCH_TAM2GET
						EndIf
					EndIf
				EndIf
	
				//cria objeto GET
				oEditControl := TGet():new(nAuxTop,nAuxLeft, bBloco,oBox,nAuxWidth,nAuxHeight,cPicture, bValid,CLR_DEFAULT,CLR_DEFAULT, oBox:oFont,.F.,,.T.,"",.F.,bWhen,.F.,.F.,,.F.,.F.,cX3F3,cNomeVar,cX3CAMPO,.F.,0,.T.)
			EndIf
		EndIf
	EndIf

	If oEditControl <> NIL
		If !lEnchoiceAlteravel
			oEditControl:lReadOnly := .T.
		Else
			If (!lCampoAlteravel)
				oEditControl:Disable()
			EndIf
		EndIf

		oEditControl:bGotFocus := &("{|o| Self:nCtrl := "+cControl+",Self:aEntryCtrls["+cControl+"]:Cargo := "+cNomeVar+"}")
		Aadd(oBox:Cargo,oEditControl)

		//coloca no array de controles
		Aadd(::aEntryCtrls,oEditControl)

		If lBitmap
			TCheckBox():New(nAuxTop+nBmpSize,nAuxLeft,STR0003,&("{ | u | If( PCount() == 0, Self:aEntryCtrls[" + cControl + "]:lStretch, Self:aEntryCtrls[" + cControl + "]:lStretch := u ) }"),oBox,50,10,,&("{|| __SetBmpStretch(Self:aEntryCtrls[" + cControl + "]:lStretch)}"),,,,,.F.,.T.,,.F.,)	//"Ajustar"
			bAction := &("{|| PreviewBmp("+cNomeVar+")}")
			TButton():New(nAuxTop+nBmpSize,nAuxLeft+nBmpSize-83,"Preview",oBox,bAction,27,10,,,.F.,.T.,.F.,,.F.,{|| Self:lActive},,.F.)
			If lEnchoiceAlteravel .and. lCampoAlteravel
				bAction := &("{|| "+cNomeVar+" := SelectBmp(" + cNomeVar + ","+Str(::aRotina[nOpc][4])+"),Self:aEntryCtrls[" + cControl + "]:LoadBmp(" + cNomeVar + "),Self:aEntryCtrls[" + cControl + "]:Refresh(.T.)}")
				TButton():New(nAuxTop+nBmpSize,nAuxLeft+nBmpSize-55,STR0002,oBox,bAction,27,10,,,.F.,.T.,.F.,,.F.,{|| Self:lActive},,.F.)
				bRemove := &("{|| "+cNomeVar+" := '',Self:aEntryCtrls[" + cControl + "]:SetEmpty(),Self:aEntryCtrls[" + cControl + "]:Refresh(.T.)}")
				TButton():New(nAuxTop+nBmpSize,nAuxLeft+nBmpSize-27,STR0004,oBox,bRemove,27,10,,,.F.,.T.,.F.,,.F.,{|| Self:lActive},,.F.)
			EndIf
		EndIf
	EndIf

	::aTop[nFolder] := {nRetAsc+1,nDifTop1}
	iGetLine++
End

//objeto criado p/ que o ultimo get seja validado
If ::lFolder
	For ni := 1 To nLen
		If Len(::oBox:aDialogs[ni]:Cargo:Cargo) == 1
			oBtn := TButton():New(-1000,-1000,"BUTTON",::oBox:aDialogs[ni],,,,,,,.T.,,,,,,)
			oBtn:bGotFocus := {|| Self:GoToCtrl(1)}
		EndIf
	Next
ElseIf Len(::oBox:Cargo) == 1
	oBtn := TButton():New(-1000,-1000,"BUTTON",::oBox,,,,,,,.T.,,,,,,)
	oBtn:bGotFocus := {|| Self:GoToCtrl(1)}
EndIf

SX3->(DbSetOrder(nOrdSX3))
SX3->(DbGoTo(nRegSX3))

DbSelectArea(::cAlias)
CursorArrow()
Return Self

METHOD GoToCtrl(nCtrl) CLASS MSMGET
Local nI
Local bError
Local aCtrls

If ::lFolder
	aCtrls := ::oBox:aDialogs[::oBox:nOption]:Cargo:Cargo
Else
	aCtrls := ::oBox:Cargo
EndIf

If !Empty(aCtrls)
	bError := ErrorBlock({|e| .T.})
	For nI := nCtrl To Len(aCtrls)
		If nI == nCtrl
			If aCtrls[nI]:lActive
				aCtrls[nI]:SetFocus()
				Exit
			Else
				nCtrl++
			EndIf
		EndIf
	Next
	ErrorBlock(bError)
EndIf
Return

METHOD Enable() CLASS MSMGET

If !::lActive
	::lActive := .T.

	If ::lFolder
		::oBox:aDialogs[::oBox:nOption]:Cargo:Refresh()
	Else
		::oBox:Refresh()
	EndIf
EndIf
Return

METHOD Disable() CLASS MSMGET

If ::lActive
	::lActive := .F.

	If ::lFolder
		::oBox:aDialogs[::oBox:nOption]:Cargo:Refresh()
	Else
		::oBox:Refresh()
	EndIf
EndIf
Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³                             FUNCOES                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
// ---- Cria uma variável de memória com o valor de um campo de um alias
Function CriaVarMem (cAlias)
If SX3->X3_CONTEXT # "V"
	&("M->"+SX3->X3_CAMPO) := &(cAlias+"->"+SX3->X3_CAMPO)
endif
Return

//-------------
Function StuffChar(cChar,oGet,cPict)
Local cTipo := ValType(Eval(oGet:oGet:bSetGet))

IF (cTipo = "N") .AND. (cChar $ "0123456789")
	&(oGet:oGet:cReadVar) := Val(cChar)
ELSE
	IF (cTipo = "C")
		&(oGet:oGet:cReadVar) := cChar
	ENDIF
ENDIF

Return

//-------------
Function ValidGet(oDlg,bValid,oGet,lCombo,cVar,lCargo)
Local nHdl
DEFAULT lCombo := .f.
IF !lCombo
	__ReadVar := oGet:cReadVar
Else
	__ReadVar := cVar
Endif
if  oDlg:nLastKey == 13
	nHdl := GetFocus()
	if Eval(bValid)
		lCargo := .t.
	else
		oDlg:nLastKey := 0
		SetFocus(oGet:hWnd)
  	oGet:Refresh(.f.)
		lCargo := .f.
	endif
//	SetFocus(oGet:hWnd)
//	oGet:Refresh(.f.)
	Return lCargo
endif
Return .t.

//  Muda o nome desta função devido apenas a problemas de incompatibilidade
//  com as outras GetF3Ret (chamadas diretamente em C++ no protheus)
//  Esta função poderia estar junto do fonte MSMGETPR, mas isto complicaria a manutenção
//---------------
Function GetF3RetEnch(nActive,cF3)
Local uVar,i,lFound,nSx5Ant := SX5->(Recno())

lFound := SXB->(dbSeek(PadR(cF3,3)+"1"))
IF !lFound
	IF SX5->(dbSeek(xFilial("SX5")+Subs(cF3,1,2)))
		lFound := SXB->(dbSeek("SX51"))
		SX5->(DbGoTo(nSx5Ant))
	Endif
Endif

If lFound
	If ( Trim(SXB->XB_COLUNA) <> "US" .And. Trim(SXB->XB_COLUNA) <> "GR" )
		For i:= 0 to Len(aCpoRet)-1
			uVar := "M->"+SubStr(aGets[nActive+i],9,10)
			&(uVar) := ReturnCpo(&(aCpoRet[i+1]),&(uVar) )
			lRefresh := .t.
		Next
	Else
		For i:= 0 to Len(aCpoRet)-1
			uVar := "M->"+SubStr(aGets[nActive+i],9,10)
			&(uVar) := aCpoRet[i+1]
			lRefresh := .t.
		Next
	EndIf
Endif
Return

//------------------
Function GetEntryPoint()
Local lRet
DEFAULT lEntryPoint := .f.
lRet := lEntryPoint
lEntryPoint := .f.
Return lRet

//---------------------
Function SetEntryPoint(lVar)
lEntryPoint := lVar
Return Nil

//---------------------
Static Function CalcMemoSize(nTam)
Local nRet

// Mantem o tamanho Default em char.
nRet := If(nTam == 0 .or. nTam == 10,56,nTam)
nRet := If(nRet > 80,80,nRet)
If nRet > 50
//	nRet := round(( 3.08 * nRet) ,0)+7
	nRet := (308 * nRet / 100) +7
Else
//	nRet := round( (3.10 * nRet) ,0)+8
	nRet := (310 * nRet / 100)+8
EndIf
Return nRet

//---------------------
Function __SetEncMemo(lSet)
Local lRet
Local nRegX6

If lX3MEMO == NIL
	lX3MEMO := .T.
	If Select("SX6") > 0
		nRegX6 := SX6->(Recno())
		If GetMv('MV_ENCMEMO',.T.)
			lX3MEMO := GetMv('MV_ENCMEMO')
		EndIf
		SX6->(DbGoto(nRegX6))
	EndIf
EndIf

lRet := lX3MEMO
If ValType(lSet) == "L"
	lX3MEMO := lSet
EndIf
Return lRet

Function __SetBmpStretch(lSet,lSave)
Local lRet

DEFAULT lSave := .F.

If lSave
	If lBmpStretch <> NIL
		If FindProfDef(cUserName,"BITMAP","STRETCH")
			WriteProfDef(cUserName,"BITMAP","STRETCH","",cUserName,"BITMAP","STRETCH","",If(lBmpStretch,"T","F"))
		Else
			WriteNewProf(cUserName,"BITMAP","STRETCH","",If(lBmpStretch,"T","F"))
		EndIf
		lBmpStretch := NIL
	EndIf
Else
	If lBmpStretch == NIL
		lBmpStretch := (AllTrim(RetProfDef(cUserName,"BITMAP","STRETCH")) == "T")
	EndIf
	
	lRet := lBmpStretch
	
	If lSet <> NIL
		lBmpStretch := lSet
	EndIf
EndIf
Return lRet

//----------------------------------------

Function PreviewBmp(cBitMap)

Local oDlg
Local oBmp
Local oScrollBox

DEFINE MSDIALOG oDlg FROM 000,000 TO 600,800 TITLE "Preview" PIXEL

@ 005,002 SCROLLBOX oScrollBox SIZE 000,000 OF oDlg VERTICAL HORIZONTAL BORDER
oScrollBox:align:= CONTROL_ALIGN_ALLCLIENT

@ 000,000 REPOSITORY oBmp RESOURCE cBitMap SIZE 0,0 OF oScrollBox PIXEL
oBmp:lAutoSize := .T.

oBmp:Refresh()

ACTIVATE MSDIALOG oDlg CENTER

Return

// -----------------------------------

Static Function ApplyParms(aParms,oEnch)
Local oOwner := GetWndDefault()
Local cF3
Local aUsed := {}
Local nI
Local nAscan
Local nLenControls := Len(oOwner:aControls)

Private aCpoRet

If Empty(aParms)
	Return
EndIf

SXB->(dbSetOrder(1))
For nI:=1 To nLenControls
	If Empty(aParms)
		Exit
	EndIf

	If oOwner:aControls[ni]:ClassName() == "MSBRGETDBASE"
		__GDApplyParms(aParms,oOwner:aControls[nI]:oMother)
	ElseIf oOwner:aControls[ni]:ClassName() == "BRGETDDB"
		__GDBApplyParms(aParms,oOwner:aControls[nI]:oMother)
	Else
		If ( oOwner:aControls[nI]:ClassName() == "TGET" ) .And. !Empty( cF3 := oOwner:aControls[nI]:cF3 )
			If SXB->(dbSeek(Padr(cF3,6)+"101DB")) .And. (nAscan := Ascan(aParms,{|x| x[2]==SubStr(Upper(RTrim(SXB->XB_CONTEM)),1,3)})) > 0
				aCpoRet := {}
				SXB->(dbSeek(Padr(cF3,6)+"5"))
				While SXB->(!Eof()) .And. SXB->XB_ALIAS == Padr(cF3,6) .And. SXB->XB_TIPO == "5"
					Aadd(aCporet, {})
					aCpoRet[Len(aCpoRet)] := AllTrim(SXB->XB_CONTEM)
					SXB->(dbSkip())
				End
	
				(aParms[nAscan][2])->(dbGoto(aParms[nAscan][3]))
				
				__ReadVar := oOwner:aControls[nI]:cReadVar
				cCampo := SubStr(__ReadVar,4)

				If Empty(&__ReadVar)
					GetF3RetFwGet( oOwner, oOwner:aControls[nI]:hWnd, cF3)
					__ReadVar := oOwner:aControls[nI]:cReadVar
	
					oOwner:aControls[nI]:lModified := .T.
					If Eval(oOwner:aControls[nI]:bValid)
						If ExistTrigger(cCampo)
							RunTrigger(1,NIL,NIL,,cCampo)
						EndIf
						oOwner:GoNextCtrl(oOwner:aControls[nI]:hWnd)
					Else
						&__ReadVar := CriaVar(cCampo,.F.)
						MsgAlert("Ocorreu um problema no processo automático de preenchimento das entidades. Verifique a ocorrência !!!")
					EndIf
	
					oEnch:Refresh()
				
					If ( Ascan(aUsed,aParms[nAscan][1]) == 0 )
						Aadd( aUsed, aParms[nAscan][1] )
					EndIf
					Adel(aParms,nAscan)
					ASize(aParms,Len(aParms)-1)
				EndIf
			EndIf
		EndIf
	EndIf
Next nI

If !Empty(aUsed)
	ClearRmtBuffer(aUsed)
EndIf
Return