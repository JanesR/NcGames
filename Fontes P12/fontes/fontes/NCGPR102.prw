#INCLUDE "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR102		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para manuten็ใo do Price Protection				  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR102()
Private aCores    := {	;
						{"Empty(P05_DTACEI) .And. Empty(P05_DTEFET) .And. Empty(P05_FLAGAR)"	, "BR_VERDE"   , "PP Em Aberto"    	},;
						{"!Empty(P05_DTACEI) .And. Empty(P05_DTEFET) .And. (Empty(P05_FLAGAR) .Or. P05_FLAGAR == 'R') "	, "BR_VERMELHO", "Aguard.Aprova็ใo p/ aplicar" },;
						{"!Empty(P05_DTACEI) .And. Empty(P05_DTEFET) .And. P05_FLAGAR == 'A' "	, "BR_LARANJA", "Aprovado aguard.aplica็ใo" },;
						{"Empty(P05_DTACEI) .And. Empty(P05_DTEFET) .And. P05_FLAGAR == 'R' "	, "BR_PRETO", "Reprovado nใo pode ser aplicado" },;
						{"!Empty(P05_DTEFET) .And. !Empty(P05_DTACEI)"	, "BR_AZUL"   , "PP Aceito pelo publisher (Creditado)"      }}
						
Private aRotina	:= xMenuDef()  
Private cCadastro := "Price Protection"
Private cAlias1 := "P05"                    // Alias da Enchoice.
Private cAlias2 := "P06"                    // Alias da GetDados.

DbSelectArea(cAlias1)
DbSetOrder(1)

mBrowse(6, 1,22,75,cAlias1,,,,,,aCores)                
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR102		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณManuten็ใo dos registros									  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR102Manut(cAlias, nRecno, nOpc)
Local i        := 0
Local cLinOK   := "U_PR102LinOK"
Local cTudoOK  := "U_PR102TudOK"
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK := "U_PR102CpoOK"
Local lVirtual := .T.
Local nLinhas  := 99
Local nFreeze  := 0
Local lRet     := .T.
Local aButtons :={}
Local nOpcBkp  := nOpc

Private aCols        := {}
Private aHeader      := {}
Private aCpoEnchoice := {}
Private aAltEnchoice := {}
Private aAlt         := {}
Private oGetDados


If ((nOpc==4 .Or. nOpc==5) .And. !Empty(P05->P05_DTACEI)) .Or. (nOpc == 8 .And. !Empty(P05->P05_DTACEI)) 
	MsgInfo("Price Protection aplicado,Manuten็ใo nใo permitida")
	Return                                                                                               
ElseIf (nOpc == 7 .And. !Empty(P05->P05_DTACEI) )
	Aviso("Aten็ใo","Data de Aceite jแ preenchida, nใo ้ possํvel efetuar altera็ใo ",{"Ok"},2)
	Return
ElseIf (nOpc == 9 .And. !Empty(P05->P05_CREDNO) )
	Aviso("Aten็ใo","Credit Note jแ preenchida, nใo ้ possํvel efetuar altera็ใo ",{"Ok"},2)
	Return	
EndIf

If nOpc == 7 .Or. nOpc == 9
	nOpc := 4
EndIf


// Cria variaveis de memoria dos campos da tabela Pai.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

CriaHeader()

CriaCols(nOpc)

AAdd(aButtons, {"Importar"		, {|| PP3Import() }	, "Importar" , "Importar" })
AAdd(aButtons, {"Wizard"		, {|| PP3Wizard() }	, "Wizard" , "Wizard" })
											 	
lRet := U_MntTela(cCadastro, cAlias1, cAlias2, aCpoEnchoice, cLinOK, cTudoOK, nOpcE, nOpcG, cFieldOK, lVirtual, nLinhas, aAltEnchoice, nFreeze,aButtons,,220)

If lRet
	If nOpc == 3
		If MsgYesNo("Confirma a grava็ใo dos dados?", cCadastro)
			ConfirmSX8()
			aCols := oGetDados:Acols
			Processa({|| GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
		EndIf
	ElseIf nOpc == 4
		
		If nOpcBkp == 7
			If Aviso("Aten็ใo","Confirma a grava็ใo da Dt. de Aceite do Publisher ?",{"Sim","Nใo"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf
		ElseIf nOpcBkp == 8
			If Aviso("Aten็ใo","Confirma a efetiva็ใo do price protection ?",{"Sim","Nใo"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf
		ElseIf nOpcBkp == 9
			If Aviso("Aten็ใo","Confirma a grava็ใo do Credit Note",{"Sim","Nใo"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf
		Else
			If Aviso("Aten็ใo","Confirma a altera็ใo dos dados?",{"Sim","Nใo"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf		  	
		EndIf
		
	ElseIf nOpc == 5
		If MsgYesNo("Confirma a exclusใo dos dados?", cCadastro)
			aCols := oGetDados:Acols
			Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
		EndIf
		
	EndIf
Else
	RollBackSX8()
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeader	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o cabe็alho da tela do PP							  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaHeader()

aHeader      := {}
aCpoEnchoice := {}
aAltEnchoice := {}

// aHeader ้ igual ao do Modelo2.

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias2)

While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias2
	
	If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo ้ usado.
		cNivel >= SX3->X3_Nivel .And.;                  // Nivel do Usuario ้ maior que o Nivel do Campo.
		Trim(SX3->X3_Campo) <> "P06_CODPP"
		
		aAdd( aHeader, {AlLTrim( X3Titulo() )	, ;	// 01 - Titulo
		SX3->X3_CAMPO	, ;	// 02 - Campo
		SX3->X3_Picture	, ;	// 03 - Picture
		SX3->X3_TAMANHO	, ;	// 04 - Tamanho
		SX3->X3_DECIMAL	, ;	// 05 - Decimal
		SX3->X3_Valid  	, ;	// 06 - Valid
		SX3->X3_USADO  	, ;	// 07 - Usado
		SX3->X3_TIPO   	, ;	// 08 - Tipo
		SX3->X3_F3		, ;	// 09 - F3
		SX3->X3_CONTEXT	, ;	// 10 - Contexto
		SX3->X3_CBOX	, ; // 11 - ComboBox
		SX3->X3_RELACAO	} )	// 12 - Relacao
		
	EndIf
	
	SX3->(dbSkip())
	
End

// Campos da Enchoice.
SX3->(dbSetOrder(1))
SX3->(dbSeek(cAlias1))

Do While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias1
	
	If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo ้ usado.
		cNivel >= SX3->X3_Nivel                         // Nivel do Usuario ้ maior que o Nivel do Campo.
		
		// Campos da Enchoice.
		AAdd(aCpoEnchoice, X3_Campo)
		
		// Campos da Enchoice que podem ser editadas.
		// Se tiver algum campo que nao deve ser editado, nao incluir aqui.
		If Alltrim(X3_Campo) != "P05_DTACEI"
			AAdd(aAltEnchoice, X3_Campo)
		EndIf
		
	EndIf
	
	SX3->(dbSkip())
	
EndDo

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaCols		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o acols da tela do Price Protection					  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaCols(nOpc)
Local nQtdCpo := 0
Local i       := 0
Local nCols   := 0

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.
	
	AAdd(aCols, Array(Len(aHeader)+1))
	
	For i := 1 To nQtdCpo
		aCols[1][i] := CriaVar(aHeader[i][2])
	Next
	
	aCols[1][nQtdCpo+1] := .F.
	
Else
	
	dbSelectArea(cAlias2)
	dbSetOrder(1)
	dbSeek(xFilial(cAlias2) + (cAlias1)->P05_CODPP)
	
	While !EOF() .And. (cAlias2)->P06_FILIAL == xFilial(cAlias2) .And. (cAlias2)->P06_CODPP == (cAlias1)->P05_CODPP
		
		AAdd(aCols, Array(nQtdCpo+1))
		nCols++
		
		For i := 1 To nQtdCpo
			If aHeader[i][10] <> "V"
				aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
			Else
				aCols[nCols][i] := CriaVar(aHeader[i][2], .T.)
			EndIf
			
			If aHeader[i][2]=="P06_NOME  "
				aCols[nCols][i]:=Posicione("SA1",1,xFilial("SA1")+P06->(P06_CLIENT+P06_LOJA),"A1_NOME")
			EndIf
			
		Next
		
		aCols[nCols][nQtdCpo+1] := .F.
		
		AAdd(aAlt, Recno())
		
		dbSelectArea(cAlias2)
		dbSkip()
		
	End
	
EndIf

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvDados		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados do Price Protection						  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvDados()

Local bCampo := {|nField| Field(nField)}
Local i      := 0
Local y      := 0
Local nItem  := 0

ProcRegua(Len(aCols) + FCount())

// Grava o registro da tabela Pai, obtendo o valor de cada campo
// a partir da var. de memoria correspondente.

dbSelectArea(cAlias1)
RecLock(cAlias1, .T.)
For i := 1 To FCount()
	IncProc()
	If "FILIAL" $ FieldName(i)
		FieldPut(i, xFilial(cAlias1))
	Else
		FieldPut(i, M->&(Eval(bCampo,i)))
	EndIf
Next
(cAlias1)->(MSUnlock())


// Grava os registros da tabela Filho.
dbSelectArea("P06")

For i := 1 To Len(aCols)
	
	IncProc()
	
	If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.
		
		RecLock("P06", .T.)
		
		P06->P06_FILIAL := xFilial("P06")
		P06->P06_CODPP  := M->P05_CODPP
		
		For y := 1 To Len(aHeader)
			FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
		Next
		                                                                                   
		P06->(MSUnlock())
		
	EndIf
	
Next

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAltDados		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRtoina de altera็ใo do Price Protection					  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AltDados(nOpcBkp)

Local i      := 0
Local y      := 0
Local nItem  := 0

ProcRegua(Len(aCols) + FCount())


dbSelectArea(cAlias1)
RecLock(cAlias1, .F.)

For i := 1 To FCount()
	IncProc()
	If "FILIAL" $ FieldName(i)
		FieldPut(i, xFilial(cAlias1))
	Else
		FieldPut(i, M->&(fieldname(i)))
	EndIf
Next
MSUnlock()


dbSelectArea(cAlias2)
dbSetOrder(1)

nItem := Len(aAlt) + 1

For i := 1 To Len(aCols)
	
	If i <= Len(aAlt)
		
		dbGoTo(aAlt[i])
		RecLock(cAlias2, .F.)
		
		If aCols[i][Len(aHeader)+1]
			dbDelete()
		Else
			For y := 1 To Len(aHeader)
				FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
			Next
		EndIf
		
		MSUnlock()
		
	Else
		
		If !aCols[i][Len(aHeader)+1]
			RecLock(cAlias2, .T.)
			For y := 1 To Len(aHeader)
				FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
			Next
			(cAlias2)->P06_FILIAL := xFilial(cAlias2)
			(cAlias2)->P06_CODPP := (cAlias1)->P05_CODPP
			MSUnlock()
			nItem++
		EndIf
		
	EndIf
	
Next

If nOpcBkp == 7//Grava a daata de aceite do Publisher
	P05->(RecLock("P05",.F.))
	P05->P05_DTACEI := M->P05_DTACEI
	P05->P05_FLAGAR := ""
	P05->(MsUnlock()) 
	
	//Chama a rotina para envio do Workflow de aprova็ใo
	u_NCWFPP02(P05->P05_CODPP)   

ElseIf	nOpcBkp == 9//Grava o numero Credit Note disponibilizado pelo Publisher

	P05->(RecLock("P05",.F.))
	P05->P05_CREDNO := M->P05_CREDNO
	P05->(MsUnlock()) 

EndIf


Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcDados		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de excluใo do Price Protection						  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcDados()


ProcRegua(Len(aCols)+1)   
dbSelectArea(cAlias2)
dbSetOrder(1)
dbSeek(xFilial(cAlias2) + (cAlias1)->P05_CODPP)


While !EOF() .And. (cAlias2)->P06_FILIAL == xFilial(cAlias2) .And. (cAlias2)->P06_CODPP == (cAlias1)->P05_CODPP
	IncProc()
	RecLock(cAlias2, .F.)
	(cAlias2)->(dbDelete())
	(cAlias2)->(MSUnlock())
	dbSkip()
End

dbSelectArea(cAlias1)
dbSetOrder(1)
//IndProc()
RecLock(cAlias1, .F.)
(cAlias1)->(dbDelete())
(cAlias1)->(MSUnlock())

Return Nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR102TudOK	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo do documento 									  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR102TudOK()
Local lRetorno:=.T.
Local aCposObrigat := GdObrigat( aHeader )
Local aCposKey := {"P06_PAIS","P06_CODPRO","P06_LOCAL"}

If !GdCheckKey(aCposKey,4,aCposObrigat ) //Verifica Itens duplicados na getdados
	Return .F.
EndIf

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR102LinOK	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo da linha dos itens do Price Protection			  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR102LinOK()

Local nLinha    := oGetDados:nAt
Local cMsgAux	:= ""
Local lRet		:= .T.

Local aCposObrigat := GdObrigat( aHeader )
Local aCposKey := {"P06_PAIS","P06_CODPRO","P06_LOCAL"}

If !GdCheckKey(aCposKey,4,aCposObrigat ) //Verifica Itens duplicados na getdados
	lRet := .F.
EndIf		   

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR102Aplic	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de aplica็ใo do PP									  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR102Aplic(cCodPP)
Local aArea := GetArea()
Local lRet	:= .T.       

Default cCodPP := ""

DbSelectArea("P05")
DbSetOrder(1)
If P05->(DbSeek(xFilial("P05") + cCodPP ))
    
    //Verifica se o documento ja foi efetivado (Aplica็ใo sem aprova็ใo por Workflow)
    If Empty(P05->P05_DTEFET)
		
		//Chama a rotina para efetuar o recalculo do CMG
		lRet	:= PR102AplPrc(cCodPP)    
    EndIF	
EndIf

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR102AplPrc	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento da aplica็ใo do Price Protection			  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR102AplPrc(cCodPP)

Local aArea 	:= GetArea()
Local lAplicPP	:= .F.
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCodPP := ""

//Query utilizada para montar o Acols
cQuery := " SELECT DISTINCT P06_CODPRO, P06_DESC FROM "+RetSqlName("P06")+CRLF
cQuery += " WHERE P06_FILIAL = '"+xFilial("P06")+"' "+CRLF
cQuery += " AND P06_CODPP = '"+cCodPP+"' "+CRLF
cQuery += " AND D_E_L_E_T_ = ' ' "+CRLF
cQuery += " ORDER BY P06_CODPRO "+CRLF
cQuery := ChangeQuery(cQuery)

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

DbSelectArea("P05")
DbSetOrder(1)
If P05->(DbSeek(xFilial("P05") + cCodPP))
	
	While (cArqTmp)->(!Eof())
		lAplicPP := U_CalCMGPP((cArqTmp)->P06_CODPRO, P05->P05_DTAPLI, P05->P05_CODPP)
		
		(cArqTmp)->(DbSkip())
	Enddo
	//Verifica se foi efetuado o recalculo com sucesso
	If lAplicPP
		
		//Atualiza o status do PP
		P05->(RECLOCK("P05",.F.))
		P05->P05_DTEFET := MsDate()
		P05->(MsUnlock())
	EndIf
	
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lAplicPP


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPR102Leg 		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda da mBrowse										  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR102Leg()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMntTela 		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a tela do Price Protection							  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MntTela(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aButtons,aCordW,nSizeHeader)
Local lRet, nOpca := 0,cSaveMenuh,nReg:=(cAlias1)->(Recno()),oDlg

Local nDlgHeight
Local nDlgWidth
Local nDiffWidth := 0
Local lMDI := .F.
Local aSize	:= MsAdvSize(.F.,.F.,0)
Local aInfo	:= {}
Local aObjects	:= {}
Local nOpcAux	:= 0
Local lConfirmPP := .F.
Local oTimer	

Private Altera:=.t.,Inclui:=.t.,lRefresh:=.t.,aTELA:=Array(0,0),aGets:=Array(0),;
bCampo:={|nCPO|Field(nCPO)},nPosAnt:=9999,nColAnt:=9999
Private cSavScrVT,cSavScrVP,cSavScrHT,cSavScrHP,CurLen,nPosAtu:=0
Private oEnchoice

If nOpcE == 3 .Or. nOpcE == 4
	nOpcAux := GD_INSERT + GD_UPDATE + GD_DELETE
	If nOpcE == 4
		aAltEnchoice    := {}
	EndIf
ElseIf nOpcE == 7
	nOpcE 			:= 4
	aAltEnchoice    := {"P05_DTACEI"}
	lConfirmPP		:= .T.
ElseIf nOpcE == 9
	nOpcE 			:= 4
	aAltEnchoice    := {"P05_CREDNO"}
	lConfirmPP		:= .T.	
Else
	nOpcAux := 0
EndIf

nOpcE := If(nOpcE==Nil,3,nOpcE)
nOpcG := If(nOpcG==Nil,3,nOpcG)
lVirtual := Iif(lVirtual==Nil,.F.,lVirtual)
nLinhas:=Iif(nLinhas==Nil,99,nLinhas)

aObjects	:= {{ 100, 157 , .T., .T. }}
aInfo		:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 0, 0 }
aPosObj		:= MsObjSize( aInfo, aObjects )


aSize[6] := aSize[6]+30

lMdi := .T.
nDiffWidth := 0

Default nSizeHeader := 110


DEFINE MSDIALOG oDlg TITLE cTitulo From /*aSize[7]*/10, 0 to aSize[6],aSize[5] Pixel of oMainWnd
If lMdi
	oDlg:lMaximized := .T.
EndIf

oEnchoice := Msmget():New(cAlias1,nReg,nOpcE,,,,aMyEncho,{13,1,(nSizeHeader/2)+13,If(lMdi, (aSize[5]/2)-2,__DlgWidth(oDlg)-nDiffWidth)},aAltEnchoice,3,,,,oDlg,,lVirtual,,,,,,,,.T.)

oGetDados := MsNewGetDados():New((nSizeHeader/2)+13+2,001,(aSize[6]/2)-30,(aSize[5]/2)-2,nOpcAux ,cLinOk,cTudoOk,"",,,9999,"AllWaysTrue()",,,,aHeader,aCols)
oGetDados:ForceRefresh()

//Atualiza o cabe็alho o cabe็alho
oTimer:= TTimer():New(500,{|| AtuCabec() },oDlg) // Ativa timer
oTimer:Activate()

ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar(oDlg,{|| Iif(lConfirmPP,	Iif(VldCfmPs(M->P05_DTAPLI, M->P05_DTACEI), nOpca:=1,  nOpca:=0) , nOpca := 1 ),;
Iif(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},;
{||oDlg:End()},,aButtons))

lRet:=(nOpca==1)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuCabec 		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o cabe็alho do Price Protection					  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuCabec()

Local aArea 	:= GetArea()
Local nX		:= 0
Local nTotRep   := 0
Local nTotGer	:= 0
Local nTotCMGAt	:= 0
Local nTotQtd	:= 0
Local nTotDolar	:= 0

For nX := 1 To Len(oGetDados:aCols)
    
	nTotQtd 	+= oGetDados:aCols[nX,GdFieldPos("P06_QUANT")]
	nTotRep 	+= oGetDados:aCols[nX,GdFieldPos("P06_TOTAL")]	
	nTotDolar	+= oGetDados:aCols[nX,GdFieldPos("P06_DLCONV")]
	nTotCMGAt 	+= oGetDados:aCols[nX,GdFieldPos("P06_CUSTCT")]
	nTotGer 	+= oGetDados:aCols[nX,GdFieldPos("P06_CTGER")]	
	
Next
 
M->P05_NCUSTO := nTotRep// Repasse
M->P05_DLCONV := nTotDolar// Conv.Dolar
M->P05_QUANT  := nTotQtd//Qtd.Total
M->P05_VALOR  := nTotGer//V.Tot.Ger
M->P05_CUSTCT := nTotCMGAt//Total CMG Anterior	

//Atualiza o objeto MsMGet
oEnchoice:EnchRefreshAll()

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDPais 		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho com a descri็ใo do pais							  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetDPais(cCodPais)

Local aArea 		:= GetArea()
Local nLinha		:= oGetDados:NAT
Local cRet			:= ""

Default cCodPais := ""

DbSelectArea("SYA")
DbSetOrder(1)

If !Empty(cCodPais)
	If SYA->(DbSeek(xFilial("SYA") + cCodPais) )
		cRet := SYA->YA_DESCR
	EndIf
Else
	If SYA->(DbSeek(xFilial("SYA") + Alltrim(oGetDados:aCols[nLinha,GdFieldPos("P06_PAIS")]) ) )
		cRet := SYA->YA_DESCR
	EndIf
EndIf

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetNCli 		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho com a descri็ใo do cliente						  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetNCli(cCod, cLoja)

Local aArea		:= GetArea()
Local cRet		:= ""

Default cCod	:= ""
Default cLoja	:= ""


DbSelectArea("SA1")
DbSetOrder(1)

If!Empty(cCod)
	If SA1->(DbSeek(xFilial("SA1") + Padr(cCod,TAMSX3("A1_COD")[1]) + PADR(cLoja, TAMSX3("A1_LOJA")[1])  )  )
		cRet := SA1->A1_NOME
	EndIf
Else
	If SA1->(DbSeek(xFilial("SA1") + Alltrim(oGetDados:aCols[nLinha,GdFieldPos("P06_CLIENT")]) + Alltrim(oGetDados:aCols[nLinha,GdFieldPos("P06_LOJA")]))  )
		cRet := SA1->A1_NOME
	EndIf
EndIf

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCfmPs 		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se a data de aceite do publisher e menor			  บฑฑ
ฑฑบ          ณ que a data de aplica็ใo					  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldCfmPs(dDtApli, dDtAcei)

Local aArea := GetArea()
Local lRet	:= .T.

Default dDtApli	:= CTOD('')
Default dDtAcei	:= CTOD('')


If !Empty(dDtAcei)
	If dDtApli > dDtAcei
		Aviso("Data de aceite incorreta","A data de aceite do Publisher, nใo pode ser menor que a data de aplica็ใo do Price Protection.",{"Ok"},2)
		lRet := .F.
	EndIf
Else
	Aviso("Data de aceite incorreta","Data de aceite do Publisher, nใo preenchida.",{"Ok"},2)
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet


/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณPesqPP  ณ Autor ณELTON SANTANA		    ณ Data ณ 11/10/11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Funcao para pesquisa                                       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ PesqPP(ExpC1,ExpN1,ExpN2)                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ ExpC1 = Alias do arquivo                                   ณฑฑ
ฑฑณ          ณ ExpN1 = Numero do registro                                 ณฑฑ
ฑฑณ          ณ ExpN2 = Numero da opcao selecionada                        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PesqPP(ciAlias,nReg,nOpcx)

Local cOrd		:= ""
Local cCampo	:= Space(40)
Local nOpca		:=0
Local nOpt1		:=0
Local nI			:=0
Local aOrd 		:= {"Nบ Price Protecion"}
Local bSav12 	:= SetKey(VK_F12)
Local oDlg
Local oCbx

SetKey( VK_F12, {||nil} )

cOrd := aOrd[1]

For ni:=1 to Len(aOrd)
	aOrd[nI] := OemToAnsi(aOrd[nI])
Next

If IndexOrd() >= Len(aOrd)
	cOrd 	:= aOrd[Len(aOrd)]
	nOpt1 := Len(aOrd)
ElseIf IndexOrd() <= 1
	cOrd := aOrd[1]
	nOpt1 := 1
Else
	cOrd := aOrd[1]
	nOpt1 := IndexOrd()
EndIf

DEFINE MSDIALOG oDlg FROM 5, 5 TO 14, 50 TITLE OemToAnsi("Buscar") //"Buscar"
@ 0.6,1.3 COMBOBOX oCBX VAR cOrd ITEMS aOrd  SIZE 165,44  ON CHANGE (nOpt1:=oCbx:nAt)  OF oDlg FONT oDlg:oFont
@ 2.1,1.3	MSGET cCampo SIZE 165,10
DEFINE SBUTTON FROM 055,122	TYPE 1 ACTION (nOpca := 1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 055,149.1 TYPE 2 ACTION (oDlg  :End()) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If nOpca == 1
	dbSelectArea(ciAlias)
	nReg := RecNo()
	dbSetOrder(nOpt1)
	
	MsSeek(xFilial(ciAlias) + Alltrim(cCampo),.T.)
	If ! Found()
		Help(" ",1,"PESQ01")
		MsGoTo(nReg)
	EndIf
Else
	DbSelectArea(ciAlias)
EndIf

lRefresh := .T.
SetKey(VK_F12,bSav12)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณMenuDef   ณ Autor ณ Microsiga             ณ Data ณ00/00/0000ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Utilizacao de menu Funcional                               ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณArray com opcoes da rotina.                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณParametros do array a Rotina:                               ณฑฑ
ฑฑณ          ณ1. Nome a aparecer no cabecalho                             ณฑฑ
ฑฑณ          ณ2. Nome da Rotina associada                                 ณฑฑ
ฑฑณ          ณ3. Reservado                                                ณฑฑ
ฑฑณ          ณ4. Tipo de Transao a ser efetuada:                        ณฑฑ
ฑฑณ          ณ		1 - Pesquisa e Posiciona em um Banco de Dados         ณฑฑ
ฑฑณ          ณ    2 - Simplesmente Mostra os Campos                       ณฑฑ
ฑฑณ          ณ    3 - Inclui registros no Bancos de Dados                 ณฑฑ
ฑฑณ          ณ    4 - Altera o registro corrente                          ณฑฑ
ฑฑณ          ณ    5 - Remove o registro corrente do Banco de Dados        ณฑฑ
ฑฑณ          ณ5. Nivel de acesso                                          ณฑฑ
ฑฑณ          ณ6. Habilita Menu Funcional                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณJeferson                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function xMenuDef()

Local cCodUser	:= Alltrim(RetCodUsr())
Local cUserAut	:=	U_MyNewSX6("NC_LIBFORP",;
									"",;
									"C",;
									"Usuแrio para efetuar libera็ใo fora da politica PP",;
									"Usuแrio para efetuar libera็ใo fora da politica PP",;
									"Usuแrio para efetuar libera็ใo fora da politica PP",;
									.F. )

Private aRotina := { }

AAdd(aRotina, {"Pesquisar"					,"u_PesqPP"  	,0 , 1})
AAdd(aRotina, {"Visualizar"					, "u_PR102Manut", 0, 2})
AAdd(aRotina, {"Incluir"   					, "u_PR102Manut", 0, 3})
AAdd(aRotina, {"Alterar"   					, "u_PR102Manut", 0, 4})
AAdd(aRotina, {"Excluir"   					, "u_PR102Manut", 0, 5})
AAdd(aRotina, {"Conhecimento"				, "MsDocument"	,0,6} )     
AAdd(aRotina, {"Confirma็ใo do Publisher"	, "u_PR102Manut", 0, 7})
AAdd(aRotina, {"Credit Note Publisher"		, "u_PR102Manut", 0, 9})
AAdd(aRotina, {"Cons.Kardex"				, "u_PP3ConsKx"	, 0, 12})

If Alltrim(cCodUser) $ Alltrim(cUserAut)
	AAdd(aRotina, {"Aplicar Sem Aprova็ใo WF"	, "u_NCAprFP", 0, 13})
EndIf                 

AAdd(aRotina, {"Legenda"					, "u_PR102Leg"	, 0, 14})

Return(aRotina)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCAprFP  บAutor  ณDBM                 บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLibera็ใo fora da politica				                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCAprFP()

Local aArea 	:= GetArea()
Local dDtLibFp  := MsDate()
Local lContinua	:= .F.
Local cTimeFP	:= Time()
Local cJustif	:= ""   
Local cCodUser	:= Alltrim(RetCodUsr())
Local cUserFP	:= U_MyNewSX6("NC_LIBFORP",;
									"",;
									"C",;
									"Usuแrio para efetuar libera็ใo fora da politica PP",;
									"Usuแrio para efetuar libera็ใo fora da politica PP",;
									"Usuแrio para efetuar libera็ใo fora da politica PP",;
									.F. )


//Verifica se o usuแrio esta autorizado a efetuar libera็ใo fora da politica
If Alltrim(cCodUser) $ Alltrim(cUserFP)
	
	If Empty(P05->P05_DTEFET)
		
		//Chama a rotina para preencher a justificativa da apica็ใo fora da politica
		cJustif := NCJustFP()
		
		//Verifica se a justificativa foi preenchida
		If !Empty(cJustif)
			
			//Chama a rotina de aplica็ใo do Price Protection
			LJMsgRun("Aguarde o processamento...","Aguarde...",{||lContinua :=	U_PR102Aplic(P05->P05_CODPP) })
			
			If lContinua	
				//Grava os detalhes da justificativa
				RecLock("P05",.F.)
				If Empty(P05->P05_DTACEI)
					P05->P05_DTACEI := MsDate() 				
				EndIf
				P05->P05_DLIBFP := MsDate()
				P05->P05_TIMEFP	:= Time()
				P05->P05_JUSTFP	:= cJustif
				P05->P05_FLAGAR := "A"//Aprovado
				P05->(MsUnLock())
			EndIf
			
		EndIf
		
	Else
		Aviso("Aten็ใo","Price Protection jแ aplicado, nใo ้ possํvel efetuar altera็ใo. ",{"Ok"},2)
	EndIf
	
Else
	Aviso("Aten็ใo","Usuแrio nใo autorizado. (NC_LIBFORP)",{"Ok"},2)
EndIf

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCJustFP	บAutor  ณElton C.		  บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a mensagem de justificativa preenchida pelo user	  บฑฑ
ฑฑบ          ณ	                                           				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCJustFP()

Local aArea := GetArea()
Local cRet	:= ""
Local oDlg 
Local oWin01
Local oFWLayer 
Local oButSair
Local oButOk
Local bSair			:= {|| oDlg:End() }//Sair
Local oTMulget

//Montagem da tela
DEFINE DIALOG oDlg TITLE "Aprova็ใo fora da polํtica (Justificativa)" SIZE 400,400 PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro ้ para 
//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho 		  
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )


// Cria tela passando, nome da coluna onde sera criada, nome da window			 	
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,	
// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split 	
oFWLayer:AddWindow( "Col01", "Win01", "Justificativa", 100, .F., .T., ,,) 
oWin01 := oFWLayer:getWinPanel('Col01','Win01')

oTMulget := TMultiGet():New( 005,005, {|u| if( Pcount()>0, cRet:= u, cRet) },;
											oWin01,183,oWin01:nClientHeight - (oWin01:nClientHeight * 56.45)/100 ,;
											,.T.,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,.T.)  
											

oButOk		:= TButton():New( 153, 125, "Continuar",oWin01,{ || IIf(Empty(cRet),Aviso("Campo obrigat๓rio","Campo obrigat๓rio nใo preenchido",{"Ok"},1),oDlg:End()) }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

oButSair		:= TButton():New( 153, 160, "Sair",oWin01,{ ||cRet := "", oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
             
ACTIVATE DIALOG oDlg CENTERED

//Verifica se a justificativa foi preenchida para gravar os dados do usuแrio, data e hora de cancelamento
If !Empty(cRet)
	cRet := cRet +CRLF+CRLF+"Usuแrio: "+UsrFullName( RetCodUsr())+CRLF+"Data: "+DTOC(MsDate())+CRLF+"Hora: "+Time()
EndIf

RestArea(aArea)
Return cRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalCMGPP  บAutor  ณMicrosiga           บ Data ณ  06/10/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta a rotina de recalculo do CMG 					      บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CalCMGPP(cCodPro, dDtApli, cCodPP)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local dDtAux    := CTOD('')

Default cCodPro := ""                   
Default dDtApli	:= CTOD('')             
Default cCodPP	:= ""

//Recupera a data do 1บ Price Protection
dDtAux := u_GetPDtPP( cCodPro )         

If !Empty(dDtAux) 
	CusGerBrPP( dDtAux, MsDate(), cCodPro, cCodPP)
Else
	CusGerBrPP( dDtApli, MsDate(), cCodPro, cCodPP)
EndIf

RestArea(aArea)
Return lRet 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCusGerBrPP  บAutor  ณMicrosiga         บ Data ณ  06/10/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRecalculo do CMG	 				 					      บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CusGerBrPP( dDatIni, dDatFin, cCodPro, cCodPP)

Local aAreaAtu		:= GetArea()
Local cQry			:= ""
Local cArqQry		:= GetNextAlias()
Local nCustAux		:= 0
Local cArmApliCMG	:= ""
Local cPPEfetAux	:= ""
Local aPPAux		:= {}  
Local nX			:= 0

Private cArqSPP := GetNextAlias()

Default dDatIni := CTOD('')
Default dDatFin := CTOD('')
Default cCodPro	:= "" 
Default cCodPP	:= ""

//Cria a tabela temporaria 
TabTempPP()

//Atualiza a SB2 com o saldo do ultimo fechamento (SB9), anterior a data de referencia
AtuPZCCSB9(cCodPro, dDatIni)


cQry	:= " SELECT SD1.D1_DTDIGIT DATMOV,SD1.D1_SEQCALC SEQUEN,SD1.D1_QUANT QDEENT,0 QDESAI,SD1.D1_CUSTO CUSFIS, "+CRLF

cQry	+= " (CASE WHEN SD1.D1_YCUSGER != 0 "+CRLF
cQry	+= " 			THEN SD1.D1_YCUSGER "+CRLF
cQry	+= " 		WHEN SD1.D1_YCMGBR != 0 "+CRLF  
cQry	+= " 			THEN SD1.D1_YCMGBR "+CRLF
cQry	+= " 		ELSE SD1.D1_CUSTO   "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF
cQry	+= " 0 CUSSAIBR,'SD1' TIPO,SD1.D1_TES TIPMOV,'1' SEQPROC, SD1.D1_LOCAL ARMAZEM, SD1.R_E_C_N_O_ NC_RECNO "+CRLF


cQry	+= " FROM " + RetSqlName( "SD1" ) + " SD1, "+RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD1.D1_FILIAL = '" + xFilial( "SD1" ) + "'"+CRLF
cQry	+= " 		AND SD1.D1_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD1.D1_DTDIGIT  BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD1.D1_ORIGLAN <> 'LF' "+CRLF
cQry	+= " 		AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' "+CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF 
cQry	+= " SELECT SD2.D2_EMISSAO DATMOV,SD2.D2_SEQCALC SEQUEN,0 QDEENT,SD2.D2_QUANT QDESAI,SD2.D2_CUSTO1 CUSFIS, 0 CUSENTBR, " +CRLF

cQry	+= " (CASE WHEN SD2.D2_YCMVG != 0 "+CRLF
cQry	+= " 		THEN SD2.D2_YCMVG "+CRLF
cQry	+= " 	WHEN SD2.D2_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD2.D2_YCMGBR "+CRLF
cQry	+= " 	ELSE SD2.D2_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF

cQry	+= " 'SD2' TIPO,SD2.D2_TES TIPMOV,'3' SEQPROC, SD2.D2_LOCAL ARMAZEM, SD2.R_E_C_N_O_ NC_RECNO  "+CRLF

cQry	+= " FROM " + RetSqlName( "SD2" ) + " SD2, "+ RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD2.D2_FILIAL = '" + xFilial( "SD2" ) + "' "+CRLF
cQry	+= " 		AND SD2.D2_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD2.D2_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD2.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD2.D2_TES " +CRLF
cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' " +CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,SD3.D3_QUANT QDEENT,0 SAIDA,SD3.D3_CUSTO1 CUSFIS, "+CRLF


cQry	+= " (CASE WHEN SD3.D3_YCUSGER != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCUSGER "+CRLF
cQry	+= " 	WHEN SD3.D3_YCMGBR != 0	"+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF

cQry	+= " 0 CUSSAIBR,'SD3E' TIPO,SD3.D3_TM TIPMOV,'2' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3 "+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "'"+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD3.D3_TM <= '500' "+CRLF
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S' "+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,0 QDEENT,SD3.D3_QUANT QDESAI,SD3.D3_CUSTO1 CUSFIS, 0 CUSENTBR,"+CRLF

cQry	+= " (CASE WHEN SD3.D3_YCUSGER != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCUSGER "+CRLF
cQry	+= " 	WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF
cQry	+= " 'SD3S' TIPO,SD3.D3_TM TIPMOV,'4' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO  "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3"+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD3.D3_TM > '500'"+CRLF

If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S'"+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " ORDER BY DATMOV, SEQUEN  "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQry), cArqQry , .F., .T.)

TcSetField( cArqQry, "DATMOV", "D", 08, 00 )
TcSetField( cArqQry, "CUSFIS", "N", 18, 02 )
TcSetField( cArqQry, "QDEENT", "N", 18, 02 )
TcSetField( cArqQry, "QDESAI", "N", 18, 02 )
TcSetField( cArqQry, "CUSENTBR", "N", 18, 02 )
TcSetField( cArqQry, "CUSSAIBR", "N", 18, 02 )


(cArqQry)->(DbGoTop())

DbSelectArea("SD1")
DbSetOrder(1)

DbSelectArea("SD2")
DbSetOrder(1)

DbSelectArea("SD3")
DbSetOrder(1)

DbSelectArea("SB2")
DbSetOrder(1)

//---------------------------------------------------------------------------------------------------
//Chama a rotina para buscar todos os PPดs a serem aplicados. Essa rotina levarแ em considera็ใo    |
//todos prices aplicados e\ou o Price Protection atual (que esta sendo aplicado).                   |
//O Recalculo serแ efetuado com base em todos os Price Protections.                                 |
//---------------------------------------------------------------------------------------------------

//Array de retorno: {Cod.PP, Quantidade, Vl.Unitario, Dt.Aplica็ใo, Armazem, Flag PP Aplicado}
aPPAux := GetPP( cCodPro, cCodPP)

While (cArqQry)->(!Eof())
	
	For nX := 1 To Len(aPPAux)
		
		If !aPPAux[nX][6] .And. (Alltrim(aPPAux[nX][5]) == Alltrim((cArqQry)->ARMAZEM)) .And. (aPPAux[nX][4] <= (cArqQry)->DATMOV)
			
			If (cArqSPP)->(DbSeek(xFilial("SB2") + PADR(cCodPro, TAMSX3("B2_COD")[1]) + PADR((cArqQry)->ARMAZEM, TAMSX3("B2_LOCAL")[1])   ))
				//Efetua a aplica็ใo do PP
				RecLock(cArqSPP,.F.)
				(cArqSPP)->YYY_YTCMG -= aPPAux[nX][2] * aPPAux[nX][3]
				(cArqSPP)->YYY_YCMVG := (cArqSPP)->YYY_YTCMG / (cArqSPP)->YYY_QUANT 
				(cArqSPP)->(MsUnLock())
				
				
				//Flag para informar que o Price Protection ja foi aplicado
				aPPAux[nX][6] 	:= .T.
			EndIf
		EndIf
		
	Next
	
	//Atualiza osdbm documentos com o valor do CMG BR atual
	If 'SD1' $ (cArqQry)->TIPO
		
		nCustAux := 0
		SD1->(DbGoTo((cArqQry)->NC_RECNO) )
		
		//Se for devolu็ใo, o custo serแ o mesmo utilizado na saํda. Se nใo existir o custo, entใo serแ considerado o custo contabil
		If Alltrim(SD1->D1_TIPO) == 'D'
			nCustAux := GetCGBRDev(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_NFORI, SD1->D1_SERIORI)
			
			If nCustAux != 0
				RecLock("SD1",.F.)
				SD1->D1_YCUSGER :=  nCustAux * SD1->D1_QUANT 
				SD1->(MsUnLock())
			Else
				
				RecLock("SD1",.F.)
				
				If SD1->D1_YCMGBR == 0
					SD1->D1_YCUSGER := SD1->D1_CUSTO
				Else
					SD1->D1_YCUSGER := SD1->D1_YCMGBR
				EndIf
				SD1->(MsUnLock())
				
			EndIf
			
			//Atualiza a SB2
			GrvPZCBR(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_QUANT, SD1->D1_YCUSGER, .F.)
		Else
			
			RecLock("SD1",.F.)
			
			If SD1->D1_YCMGBR == 0
				SD1->D1_YCUSGER := SD1->D1_CUSTO
			Else
				SD1->D1_YCUSGER := SD1->D1_YCMGBR
			EndIf
			
			SD1->(MsUnLock())
			
			//Atualiza a SB2
			GrvPZCBR(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_QUANT, SD1->D1_YCUSGER, .F.)
			
		EndIf
		
		
		
	ElseIf 'SD2' $ (cArqQry)->TIPO
		nCustAux := 0
		
		SD2->(DbGoTo((cArqQry)->NC_RECNO) )
		
		If (cArqSPP)->(DbSeek(xFilial("SB2") + PADR(SD2->D2_COD, TAMSX3("B2_COD")[1]) + PADR(SD2->D2_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
			nCustAux :=  (SD2->D2_QUANT * (cArqSPP)->YYY_YCMVG)
		Else
			nCustAux := SD2->D2_YCMGBR
			
			If nCustAux == 0
				nCustAux := SD2->D2_CUSTO1      
			EndIf
		EndIf
		
		RecLock("SD2",.F.)
		SD2->D2_YCMVG := nCustAux
		SD2->(MsUnLock())
		
		//Atualiza a SB2
		GrvPZCBR(SD2->D2_COD, SD2->D2_LOCAL, SD2->D2_QUANT, SD2->D2_YCMVG, .T.)
		
	ElseIf 'SD3' $ (cArqQry)->TIPO
		
		nCustAux := 0
		
		SD3->(DbGoTo((cArqQry)->NC_RECNO) )
		
		//O armazem destino, deverแ receber o valor do custo do armazem origem, efetuando o calculo do CMV
		If SD3->D3_TM > '500'
			
			//Verifica se o movimento ้ referente o inventario
			If Alltrim(upper(SD3->D3_DOC)) == "INVENT"
				
				If (cArqSPP)->(DbSeek(xFilial("SB2") + PADR(SD3->D3_COD, TAMSX3("B2_COD")[1]) + PADR(SD3->D3_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
					If SD3->D3_QUANT != 0
						nCustAux :=  (SD3->D3_QUANT * (cArqSPP)->YYY_YCMVG) 
					Else
						nCustAux :=  SD3->D3_YCMGBR
					EndIf
				Else
					nCustAux := SD3->D3_YCMGBR
			
					If nCustAux == 0
						nCustAux := SD3->D3_CUSTO1
					EndIf
				EndIf
				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCUSGER := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					
					If SD3->D3_YCMGBR == 0
						SD3->D3_YCUSGER := SD3->D3_CUSTO1
					Else
						SD3->D3_YCUSGER := SD3->D3_YCMGBR
					EndIf
					
					SD3->(MsUnLock())
					
				EndIf
				
				GrvPZCBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCUSGER, .T.)
				
			Else
				
				
				//Verifica se a tranferencia foi efetua pela baixa do CQ
				nCustAux := GetSd3Sai(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_DOC, SD3->D3_IDENT, SD3->D3_NUMSEQ, SD3->D3_QUANT )
				
				If nCustAux == 0
					
					If (cArqSPP)->(DbSeek(xFilial("SB2") + PADR(SD3->D3_COD, TAMSX3("B2_COD")[1]) + PADR(SD3->D3_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
						If SD3->D3_QUANT != 0
							nCustAux :=  (SD3->D3_QUANT * (cArqSPP)->YYY_YCMVG) 

						Else
							nCustAux :=  SD3->D3_YCMGBR
						EndIf
					Else
						nCustAux := SD3->D3_YCMGBR
						
						If nCustAux == 0
							nCustAux := SD3->D3_CUSTO1
						EndIf
					EndIf
					
				EndIf
				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCUSGER := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					
					If SD3->D3_YCMGBR == 0
						SD3->D3_YCUSGER := SD3->D3_CUSTO1
					Else
						SD3->D3_YCUSGER := SD3->D3_YCMGBR
					EndIf
					
					SD3->(MsUnLock())
					
				EndIf
				
				GrvPZCBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCUSGER, .T.)
				
			Endif
		Else
			
			//Verifica se o movimento ้ referente o inventario
			If Alltrim(upper(SD3->D3_DOC)) == "INVENT"
				
				If (cArqSPP)->(DbSeek(xFilial("SB2") + PADR(SD3->D3_COD, TAMSX3("B2_COD")[1]) + PADR(SD3->D3_LOCAL, TAMSX3("B2_LOCAL")[1])   ))
					If SD3->D3_QUANT != 0
						nCustAux :=  (SD3->D3_QUANT * (cArqSPP)->YYY_YCMVG) 
					Else
						nCustAux :=  SD3->D3_YCMGBR
					EndIf
				Else
					nCustAux := SD3->D3_YCMGBR
					
					If nCustAux == 0
						nCustAux := SD3->D3_CUSTO1
					EndIf
				EndIf
				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCUSGER := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					
					If SD3->D3_YCMGBR == 0
						SD3->D3_YCUSGER := SD3->D3_CUSTO1
					Else
						SD3->D3_YCUSGER := SD3->D3_YCMGBR
					EndIf
					
					SD3->(MsUnLock())
					
				EndIf
				
				GrvPZCBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCUSGER, .F.)
				
			Else
				
				nCustAux := 0
				nCustAux := GetSd3Ent(SD3->D3_COD, SD3->D3_DOC, DTOS(SD3->D3_EMISSAO), SD3->D3_NUMSEQ, SD3->D3_IDENT)
				
				If nCustAux != 0
					RecLock("SD3",.F.)
					SD3->D3_YCUSGER := nCustAux
					SD3->(MsUnLock())
				Else
					RecLock("SD3",.F.)
					
					If SD3->D3_YCMGBR == 0
						SD3->D3_YCUSGER := SD3->D3_CUSTO1
					Else
						SD3->D3_YCUSGER := SD3->D3_YCMGBR
					EndIf
					
					SD3->(MsUnLock())
					
				EndIf
				
				GrvPZCBR(SD3->D3_COD, SD3->D3_LOCAL, SD3->D3_QUANT, SD3->D3_YCUSGER, .F.)
				
			EndIf
		EndIf
	EndIf
	
	(cArqQry)->(DbSkip())
EndDo


DbSelectArea("SB2")
DbSetOrder(1)
(cArqSPP)->(DbGoTop())
While (cArqSPP)->(!Eof()) 


	//------------------------------------------------------------------------------------------------------
	//Verifica se o Price Protection foi aplicado para todos os produtos de acordo com as movimenta็๕es.   |
	//Caso nใo exista movimentos para a data de aplica็ใo, entใo a rebaixa serแ efetuada diretamente no    |
	//saldo atual.                                                                                         |
	//------------------------------------------------------------------------------------------------------
	For nX := 1 To Len(aPPAux)
		If !aPPAux[nX][6] .And. (Alltrim(aPPAux[nX][5]) == Alltrim((cArqSPP)->YYY_LOCAL))
	  		//Efetua a aplica็ใo do PP
	 		RecLock(cArqSPP,.F.)
		  		(cArqSPP)->YYY_YTCMG -= aPPAux[nX][2] * aPPAux[nX][3]
		  		(cArqSPP)->YYY_YCMVG := (cArqSPP)->YYY_YTCMG / (cArqSPP)->YYY_QUANT
		  	(cArqSPP)->(MsUnLock())  

		  	//Flag para informar que o Price Protection ja foi aplicado 
		  	aPPAux[nX][6] := .T.
		EndIf
	Next 

	
	If SB2->( DbSeek(xFilial("SB2") + Padr((cArqSPP)->YYY_COD, TAMSX3("B2_COD")[1] ) + PADR( (cArqSPP)->YYY_LOCAL , TAMSX3("B2_LOCAL")[1])  )  )
		
		Reclock("SB2",.F.)
		
		SB2->B2_YCMVG := (cArqSPP)->YYY_YCMVG
		SB2->B2_YTCMG := (cArqSPP)->YYY_YCMVG * SB2->B2_QATU

		SB2->(MsUnLock())			
	EndIf

	(cArqSPP)->(DbSkip())
EndDo


(cArqSPP)->(DbCloseArea())
(cArqQry)->(DbCloseArea())
RestArea( aAreaAtu )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetSd3Ent  บAutor  ณMicrosiga           บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o custo das movimenta็๕es internas de entrada       บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetSd3Ent(cCodProd, cDoc, cEmissao, cNumSeq, cIdent)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd3	:= GetNextAlias()
Local nRet			:= 0

Default cCodProd	:= "" 
Default cDoc		:= "" 
Default cEmissao	:= ""                  
Default cIdent		:= ""
Default cNumSeq		:= ""

cQuery := " SELECT D3_YCUSGER, D3_YCMGBR, D3_CUSTO1 FROM "+RetSqlName("SD3")+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "      +CRLF
cQuery += "  AND D3_FILIAL = '"+xFilial("SD3")+"' "+CRLF
cQuery += "  AND D3_COD = '"+cCodProd+"' "+CRLF
cQuery += "  AND D3_DOC = '"+cDoc+"' "+CRLF
cQuery += "  AND D3_NUMSEQ = '"+cNumSeq+"' "+CRLF
cQuery += "  AND D3_IDENT = '"+cIdent+"' "+CRLF
cQuery += "  AND D3_EMISSAO = '"+cEmissao+"' "+CRLF
cQuery += "  AND SUBSTR(D3_CF,1,2) = 'RE' "+CRLF
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd3 , .F., .T.)

(cArqTmpSd3)->(DbGoTop())
If (cArqTmpSd3)->(!Eof())
	
	If (cArqTmpSd3)->D3_YCUSGER != 0
		nRet := (cArqTmpSd3)->D3_YCUSGER		

	Else
		If (cArqTmpSd3)->D3_YCMGBR == 0
			nRet := (cArqTmpSd3)->D3_CUSTO1	
		Else
			nRet := (cArqTmpSd3)->D3_YCMGBR
		EndIf
	
	EndIf              
Else            
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet
                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetSd3Sai  บAutor  ณMicrosiga           บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o custo das movimenta็๕es internas de saida	      บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetSd3Sai(cCodProd, cLocal, cDoc, cIdent, cNumSeq, nQuant)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd3	:= GetNextAlias()
Local nRet			:= 0
Local cLocalCQ		:= GETNEWPAR("MV_CQ", "99")

Default cCodProd	:= "" 
Default cLocal		:= "" 
Default cDoc		:= "" 
Default cIdent		:= ""                         
Default cNumSeq		:= ""                                              
Default nQuant		:= 0

cQuery := " SELECT D7_PRODUTO, D7_NUMSEQ, D7_NUMERO, D7_TIPO, D7_QTDE, D7_SALDO, D7_SEQ, "+CRLF
cQuery += " D1_TIPO, D1_DOC, D1_SERIE, D1_COD, D1_CUSTO, D1_YCMGBR, D1_YCUSGER, "+CRLF
cQuery += " D3_EMISSAO, D3_DOC, D3_LOCAL, D3_TM, D3_CF, D3_SEQCALC, D3_IDENT, "+CRLF
cQuery += " D3_NUMSEQ, D3_QUANT, D3_CUSTO1, D3_YCUSGER, D3_YCMGBR  FROM "+RetSqlName("SD7")+" SD7 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SD1")+" SD1 "+CRLF
cQuery += " ON SD1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SD1.D1_FILIAL = SD7.D7_FILIAL "+CRLF
cQuery += " AND SD1.D1_COD = SD7.D7_PRODUTO "+CRLF
cQuery += " AND SD1.D1_DOC = SD7.D7_DOC "+CRLF
cQuery += " AND SD1.D1_LOCAL = SD7.D7_LOCAL "+CRLF
cQuery += " AND SD1.D1_SERIE = SD7.D7_SERIE "+CRLF
cQuery += " AND SD1.D1_FORNECE = SD7.D7_FORNECE "+CRLF
cQuery += " AND SD1.D1_LOJA = SD7.D7_LOJA "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SD3")+" SD3 "+CRLF
cQuery += " ON SD3.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SD3.D3_DOC = SD7.D7_NUMERO "+CRLF
cQuery += " AND SD3.D3_LOCAL = SD7.D7_LOCAL "+CRLF
cQuery += " AND SD3.D3_COD = SD7.D7_PRODUTO "+CRLF
cQuery += " AND SD3.D3_IDENT = '"+cIdent+"' "+CRLF
cQuery += " AND SD3.D3_NUMSEQ = '"+cNumSeq+"' "+CRLF

cQuery += " WHERE SD7.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SD7.D7_FILIAL = '"+xFilial("SD7")+"' "+CRLF
cQuery += " AND SD7.D7_NUMERO = '"+cDoc+"'  "+CRLF
cQuery += " AND ((SD7.D7_NUMSEQ = '"+cIdent+"') OR (SD7.D7_NUMSEQ = '"+cNumSeq+"')) "+CRLF
cQuery += " AND SD7.D7_PRODUTO = '"+cCodProd+"' "+CRLF
cQuery += " AND SD7.D7_LOCAL = '"+cLocal+"' "+CRLF                                       
cQuery += " AND SD7.D7_QTDE = '"+Alltrim(Str(nQuant))+"' "+CRLF
cQuery += " ORDER BY D7_SEQ "+CRLF

cQuery := ChangeQuery(cQuery)
 
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd3 , .F., .T.)

(cArqTmpSd3)->(DbGoTop())
If (cArqTmpSd3)->(!Eof())
	
	While (cArqTmpSd3)->(!Eof())
		
		If (cArqTmpSd3)->D1_TIPO != 'D'//Se nใo for devolu็ใo retorna o custo BR ou Contabil
			
			If (cArqTmpSd3)->D1_YCMGBR != 0
				nRet := (cArqTmpSd3)->D3_YCMGBR
				
			Else
				nRet := (cArqTmpSd3)->D3_CUSTO1
				
			EndIf
		Else
			
			If (cArqTmpSd3)->D1_YCUSGER != 0
				nRet := (cArqTmpSd3)->D1_YCUSGER
				
			ElseIf (cArqTmpSd3)->D1_YCMGBR != 0
				nRet := (cArqTmpSd3)->D1_YCMGBR
				
			Else
				nRet := (cArqTmpSd3)->D1_CUSTO
				
			EndIf
			
		EndIf
		
		(cArqTmpSd3)->(DbSkip())
	EndDo

Else
	nRet := 0
EndIf

(cArqTmpSd3)->(DbCloseArea())

RestArea(aArea)
Return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCGBRDev  บAutor  ณMicrosiga          บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o CMG de devolu็ใo							      บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCGBRDev(cCodProd, cArm, cDoc, cSerie)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd2	:= GetNextAlias()
Local nRet			:= 0

Default cCodProd	:= "" 
Default cArm		:= "" 
Default cDoc		:= "" 
Default cSerie		:= ""

cQuery := " SELECT D2_QUANT, D2_YCMVG, D2_YCMGBR, D2_CUSTO1 FROM "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery += " WHERE SD2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " 	AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "	+CRLF
cQuery += " 	AND SD2.D2_COD = '"+cCodProd+"' "+CRLF
cQuery += " 	AND SD2.D2_DOC = '"+cDoc+"' "+CRLF
cQuery += " 	AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd2 , .F., .T.)

(cArqTmpSd2)->(DbGoTop())
If (cArqTmpSd2)->(!Eof())
	
	If (cArqTmpSd2)->D2_YCMVG != 0
		nRet := (cArqTmpSd2)->D2_YCMVG / (cArqTmpSd2)->D2_QUANT	
	Else	
		If (cArqTmpSd2)->D2_YCMGBR == 0
			nRet := (cArqTmpSd2)->D2_CUSTO1 / (cArqTmpSd2)->D2_QUANT
		Else
			nRet := (cArqTmpSd2)->D2_YCMGBR  / (cArqTmpSd2)->D2_QUANT
		EndIf

	EndIf

EndIf

(cArqTmpSd2)->(DbCloseArea())

RestArea(aArea)
Return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvB2BR	  บAutor  ณMicrosiga          บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava o custo gerencial na tabela de saldos atuais (SB2)   บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvB2BR(cCod, cLocal, nQtd, nVal, lSaida)

Local aArea 	:= GetArea()

Default cCod	:= "" 
Default cLocal	:= "" 
Default nQtd	:= 0 
Default nVal	:= 0 
Default lSaida	:= .F.

DbSelectArea("SB2")
DbSetOrder(1)
If SB2->(DbSeek(xFilial("SB2") + PADR(cCod, TAMSX3("B2_COD")[1]) + PADR(cLocal, TAMSX3("B2_LOCAL")[1])   ))
	
	//Verifica se a atualiza็ใo vem de um documento de saida
	If lSaida

		//Atualiza o total do CMG BR
		RecLock("SB2",.F.)
		SB2->B2_YQTDCMG -= nQtd 
		SB2->B2_YTCMG :=  ( SB2->B2_YCMVG * SB2->B2_YQTDCMG)
		
		SB2->(MsUnLock())


	Else//Atualiza็ใo de entrada
		
		RecLock("SB2",.F.)
        
        
		If (SB2->B2_YQTDCMG + nQtd) > 0
			SB2->B2_YCMVG	:=  (SB2->B2_YTCMG + nVal) / (SB2->B2_YQTDCMG + nQtd) 
		EndIf
		
		SB2->B2_YTCMG := (SB2->B2_YTCMG + nVal)
		SB2->B2_YQTDCMG := SB2->B2_YQTDCMG + nQtd 
        
		SB2->(MsUnLock())
	EndIf
EndIf


RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetPP	  บAutor  ณMicrosiga	          บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para verificar se existe PP aplicado	  บฑฑ
ฑฑบ          ณ para o produto			          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetPP( cCodPro, cCodPP)

Local aAreaAtu 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}

Default cCodPro		:= ""
Default cCodPP		:= ""                                           

cQuery := " SELECT P05_DTAPLI, P05_CODPP, P06_LOCAL,P06_VLUNIT,P06_QUANT "+CRLF
cQuery += " FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery += " ON P06.P06_FILIAL = '" + xFilial( "P06" ) + "' "+CRLF
cQuery += " AND P06.P06_CODPP = P05.P05_CODPP " +CRLF
cQuery += " AND P06.P06_CODPRO = '"+cCodPro+"' "+CRLF
cQuery += " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " WHERE P05.P05_FILIAL = '" + xFilial( "P05" ) + "' "+CRLF
cQuery += " AND (P05.P05_DTEFET != ' ' OR P05.P05_CODPP = '"+cCodPP+"' )"+CRLF
cQuery += " AND P05.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " ORDER BY P05_DTAPLI, P06_LOCAL DESC "+CRLF

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof()) 

	Aadd(aRet,{ (cArqTmp)->P05_CODPP, (cArqTmp)->P06_QUANT, (cArqTmp)->P06_VLUNIT,SToD( (cArqTmp)->P05_DTAPLI ), (cArqTmp)->P06_LOCAL, .F. })
		
	(cArqTmp)->(DbSkip())			 	
EndDo

(cArqTmp)->(DbCloseArea())
RestArea( aAreaAtu )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetTotPP  บAutor  ณMicrosiga	          บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a soma do PP em determinado intervalo de datas 	  บฑฑ
ฑฑบ          ณ 							          						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTotPP(cCodPro, cLocal, dDtIni, dDtFin)

Local aAreaAtu 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local nRet		:= 0

Default cCodPro	:= "" 
Default cLocal	:= "" 
Default dDtIni	:= CTOD('')
Default dDtFin	:= CTOD('') 

cQuery := " SELECT SUM(P06_VLUNIT * P06_QUANT) VLTOT "+CRLF
cQuery += " FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery += " ON P06.P06_FILIAL = '" + xFilial( "P06" ) + "' "+CRLF
cQuery += " AND P06.P06_CODPP = P05.P05_CODPP " +CRLF
cQuery += " AND P06.P06_CODPRO = '"+cCodPro+"' "+CRLF
cQuery += " AND P06.P06_LOCAL = '"+cLocal+"' "+CRLF
cQuery += " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " WHERE P05.P05_FILIAL = '" + xFilial( "P05" ) + "' "+CRLF
cQuery += " AND P05.P05_DTEFET != ' ' "+CRLF
cQuery += " AND P05_DTAPLI BETWEEN '"+dtos(dDtIni)+"' AND '"+dtos(dDtFin)+"' "
cQuery += " AND P05.D_E_L_E_T_ = ' ' "+CRLF

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof()) 
	nRet := (cArqTmp)->VLTOT	
Else
	nRet := 0
EndIf
(cArqTmp)->(DbCloseArea())
RestArea( aAreaAtu )
Return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetPDtPP	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a data de aplica็ใo do 1บ Price Protection		  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetPDtPP( cCodPro )

Local aAreaAtu 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local dDtRet	:= CTOD('')

Default cCodPro		:= ""

cQuery := " SELECT MIN(P05_DTAPLI) P05_DTAPLI, P05_CODPP "+CRLF
cQuery += " FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery += " ON P06.P06_FILIAL = '" + xFilial( "P06" ) + "' "+CRLF
cQuery += " AND P06.P06_CODPP = P05.P05_CODPP " +CRLF
cQuery += " AND P06.P06_CODPRO = '"+cCodPro+"' "+CRLF
cQuery += " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " WHERE P05.P05_FILIAL = '" + xFilial( "P05" ) + "' "+CRLF
cQuery += " AND P05.P05_DTEFET != ' ' "+CRLF    
cQuery += " AND P05.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " GROUP BY P05_CODPP "
cQuery += " ORDER BY P05_DTAPLI, P05_CODPP "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!eof())            
	dDtRet	:= STOD((cArqTmp)->P05_DTAPLI)
Else
	dDtRet	:= CTOD('')
EndIf

(cArqTmp)->(DbCloseArea())
RestArea( aAreaAtu )
Return dDtRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCEstPP	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Recalculo e retorno do valor do custo gerencial na data 	  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCEstPP( dDatIni, dDatFin, cCodPro, cLocal, nQdeIni, nVlrIni)

Local aAreaAtu	:= GetArea()
Local cQry		:= ""
Local cArqQry	:= GetNextAlias()
Local nQuant	:= 0
Local nCusto	:= 0
Local aRet		:= {}

Default dDatIni := CTOD('')
Default dDatFin := CTOD('')
Default cCodPro	:= "" 
Default cLocal	:= "" 
Default nQdeIni	:= 0 
Default nVlrIni	:= 0 



cQry	:= " SELECT SD1.D1_DTDIGIT DATMOV,SD1.D1_SEQCALC SEQUEN,SD1.D1_QUANT QDEENT,0 QDESAI,SD1.D1_CUSTO CUSFIS, "+CRLF

cQry	+= " (CASE WHEN SD1.D1_YCUSGER != 0  "+CRLF
cQry	+= " 			THEN SD1.D1_YCUSGER "+CRLF
cQry	+= " 	   WHEN SD1.D1_YCMGBR != 0 "+CRLF
cQry	+= " 			THEN SD1.D1_YCMGBR "+CRLF
cQry	+= " 	   ELSE SD1.D1_CUSTO   "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF

cQry	+= " 0 CUSSAIBR,'SD1' TIPO,SD1.D1_TES TIPMOV,'1' SEQPROC, SD1.D1_LOCAL ARMAZEM, SD1.R_E_C_N_O_ NC_RECNO "+CRLF


cQry	+= " FROM " + RetSqlName( "SD1" ) + " SD1, "+RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD1.D1_FILIAL = '" + xFilial( "SD1" ) + "'"+CRLF
cQry	+= " 		AND SD1.D1_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD1.D1_LOCAL = '" + cLocal + "' "+CRLF
cQry	+= " 		AND SD1.D1_DTDIGIT  BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD1.D1_ORIGLAN <> 'LF' "+CRLF
cQry	+= " 		AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' "+CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF 
cQry	+= " SELECT SD2.D2_EMISSAO DATMOV,SD2.D2_SEQCALC SEQUEN,0 QDEENT,SD2.D2_QUANT QDESAI,SD2.D2_CUSTO1 CUSFIS, 0 CUSENTBR, " +CRLF

cQry	+= " (CASE WHEN SD2.D2_YCMVG != 0 "+CRLF
cQry	+= " 		THEN SD2.D2_YCMVG "+CRLF
cQry	+= " 	WHEN SD2.D2_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD2.D2_YCMGBR "+CRLF
cQry	+= " 	ELSE SD2.D2_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF

cQry	+= " 'SD2' TIPO,SD2.D2_TES TIPMOV,'3' SEQPROC, SD2.D2_LOCAL ARMAZEM, SD2.R_E_C_N_O_ NC_RECNO  "+CRLF

cQry	+= " FROM " + RetSqlName( "SD2" ) + " SD2, "+ RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD2.D2_FILIAL = '" + xFilial( "SD2" ) + "' "+CRLF
cQry	+= " 		AND SD2.D2_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD2.D2_LOCAL = '" + cLocal + "' "+CRLF
cQry	+= " 		AND SD2.D2_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD2.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD2.D2_TES " +CRLF
cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' " +CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,SD3.D3_QUANT QDEENT,0 SAIDA,SD3.D3_CUSTO1 CUSFIS, "+CRLF


cQry	+= " (CASE WHEN SD3.D3_YCUSGER != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCUSGER "+CRLF
cQry	+= " 	WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF

cQry	+= " 0 CUSSAIBR,'SD3E' TIPO,SD3.D3_TM TIPMOV,'2' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3 "+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "'"+CRLF
cQry	+= " 		AND SD3.D3_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD3.D3_TM <= '500' "+CRLF
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S' "+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,0 QDEENT,SD3.D3_QUANT QDESAI,SD3.D3_CUSTO1 CUSFIS, 0 CUSENTBR,"+CRLF

cQry	+= " (CASE WHEN SD3.D3_YCUSGER != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCUSGER "+CRLF
cQry	+= " 	WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF
cQry	+= " 'SD3S' TIPO,SD3.D3_TM TIPMOV,'4' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO  "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3"+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD3.D3_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD3.D3_TM > '500'"+CRLF

If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S'"+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " ORDER BY DATMOV, SEQUEN "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQry), cArqQry , .F., .T.)

TcSetField( cArqQry, "DATMOV", "D", 08, 00 )
TcSetField( cArqQry, "CUSFIS", "N", 18, 02 )
TcSetField( cArqQry, "QDEENT", "N", 18, 02 )
TcSetField( cArqQry, "QDESAI", "N", 18, 02 )
TcSetField( cArqQry, "CUSENTBR", "N", 18, 02 )
TcSetField( cArqQry, "CUSSAIBR", "N", 18, 02 )

//Preenchiemnto do valores iniciais
nQuant	:= nQdeIni
nCusto	:= nVlrIni

While (cArqQry)->(!Eof())
	
	//Calculo do custo gerencial
	nQuant	+= ( (cArqQry)->QDEENT - (cArqQry)->QDESAI )
	nCusto	+= ((cArqQry)->CUSENTBR - (cArqQry)->CUSSAIBR )

	(cArqQry)->(DbSkip())
EndDo

If nQuant != 0                                                        	

	nCusto -= GetTotPP(cCodPro, cLocal, dDatIni, dDatFin)	
	
	aRet := {nQuant, nCusto, nCusto / nQuant}
Else
	aRet := {0, 0, 0}
EndIf

(cArqQry)->(DbCloseArea())

RestArea( aAreaAtu )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetEstPP	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o custo gerencial na data		 				  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetEstPP(cCodPro, cLocal, dDtRef)

Local aArea			:= GetArea()
Local aFechAux		:= {}                           
Local aRet			:= {}
Local dDataIni		:= CTOD('')
Local dDtIniCMGBR 	:= U_MyNewSX6("NC_DTIMGBR",;
								"20130801",;
								"D",;
								"Data inicial do CMG BR",;
								"Data inicial do CMG BR",;
								"Data inici'al do CMG BR",;
								.F. )

Default cCodPro := "" 
Default cLocal	:= "" 
Default dDtRef 	:= CTOD('')

If dDtRef >= dDtIniCMGBR 
	dDataIni := dDtIniCMGBR 
Else 
	dDataIni := dDtRef 
EndIf

aFechAux := CalcEst( cCodPro, cLocal, dDataIni )
aRet := GetCEstPP( dDataIni, dDtRef-1, cCodPro, cLocal, aFechAux[1], aFechAux[2])

If Len(aRet) < 3
	aRet := {0,0,0}
EndIf

RestArea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNcVisKar	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Consulta ao Kardex						 				  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NcVisKar(cCodProd)
                                
Local aArea    		:= GetArea()
Default cCodProd	:= ""


DbSelectArea("SB1")
DbSetOrder(1)
If !Empty(cCodProd) .And. SB1->(DbSeek(xFilial("SB1") + cCodProd))
	LJMsgRun("Aguarde o processamento...","Aguarde...",{||	A010Consul() })

Else
	Aviso("NOEXISTE","Produto nใo encontrado",{"Ok"},2)
EndIf

RestArea(aArea)
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPP3ConsKx	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela para selecionar o produto a ser visualizado no Kardex บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PP3ConsKx()

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aCpoKx	:= {"P06_CODPRO", "P06_DESC"}
Local oDlg 
Local oWin01
Local oFWLayer 
Local oFont        
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= 515//aScreen[1]-130
Local nHStage 		:= 400//aScreen[2]-225
Local oGetDKx	
Local oButOk		
Local oButSair		

Private aAcolsKx 	:= {}
Private aHeadKx   := {}

aHeadKx := CriaHeadKx(aCpoKx)

//Query utilizada para montar o Acols
cQuery := " SELECT DISTINCT P06_CODPRO, P06_DESC FROM "+RetSqlName("P06")+CRLF
cQuery += " WHERE P06_FILIAL = '"+xFilial("P06")+"' "+CRLF
cQuery += " AND P06_CODPP = '"+P05->P05_CODPP+"' "+CRLF
cQuery += " AND D_E_L_E_T_ = ' ' "+CRLF
cQuery += " ORDER BY P06_CODPRO "+CRLF
cQuery := ChangeQuery(cQuery)

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

aAcolsKx 	:= {}

//Preenchimento do Acols
(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
    
	//Preenche o acols
	aAdd(aAcolsKx,{(cArqTmp)->P06_CODPRO,(cArqTmp)->P06_DESC,.F.})
	
	(cArqTmp)->(DbSkip())
EndDo                 

If Len(aAcolsKx) > 0
	//Montagem da tela
	DEFINE DIALOG oDlg TITLE "Consulta ao Kardex " SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)
	
	//Cria instancia do fwlayer
	oFWLayer := FWLayer():New()
	
	//Inicializa componente passa a Dialog criada,o segundo parametro ้ para
	//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho
	oFWLayer:Init( oDlg, .T. )
	
	// Efetua a montagem das colunas das telas
	oFWLayer:AddCollumn( "Col01", 100, .T. )
	
	
	// Cria windows passando, nome da coluna onde sera criada, nome da window
	// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
	// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split
	oFWLayer:AddWindow( "Col01", "oWin01", "Produtos do Price Protection", 100, .F., .T., ,,)
	oWin01	:= oFWLayer:getWinPanel('Col01','oWin01')
	
	oGetDKx := MsNewGetDados():New(002,002,145,240 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeadKx,aAcolsKx)
	oButOk		:= TButton():New( 150, 165, "Kardex",oWin01,{ || NcVisKar(oGetDKx:Acols[oGetDKx:nAt][1])}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButSair	:= TButton():New( 150, 210, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	
	ACTIVATE DIALOG oDlg CENTERED
	
	
Else
	Aviso("Dados nใo encontrado", "Dados nใo encontrados",{"Ok"},2)
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeadKxบAutor  ณElton C.	         บ Data ณ  02/24/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o aHeader para o kardex			                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaHeadKx(aCampos)
Local aArea		:= GetArea()
Local aRet	 	:= {}
Local nIx		:= 0

Default aCampos := {}

DbSelectArea( "SX3" )
DbSetOrder(2)

For nIx := 1 To Len( aCampos )
	If SX3->( MsSeek( aCampos[ nIx ] ) )
		aAdd( aRet, {AlLTrim( X3Titulo() )	, ;	// 01 - Titulo
		SX3->X3_CAMPO	, ;	// 02 - Campo
		SX3->X3_Picture	, ;	// 03 - Picture
		SX3->X3_TAMANHO	, ;	// 04 - Tamanho
		SX3->X3_DECIMAL	, ;	// 05 - Decimal
		SX3->X3_Valid  	, ;	// 06 - Valid
		SX3->X3_USADO  	, ;	// 07 - Usado
		SX3->X3_TIPO   	, ;	// 08 - Tipo
		SX3->X3_F3		, ;	// 09 - F3
		SX3->X3_CONTEXT	, ;	// 10 - Contexto
		SX3->X3_CBOX	, ; // 11 - ComboBox
		SX3->X3_RELACAO	} )	// 12 - Relacao
	Endif
Next

RestArea( aArea )

Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetTxDol	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a taxa do dolar na data de acordo com o bcb		  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetTxDol(dDtTxDolar)
Local cUrl		:= "https://www3.bcb.gov.br/wssgs/services/FachadaWSSGS"
Local nRet		:= 0
Local nX		:= 0
Local nDiasAnt	:= 0	
Local oXmlTxD   
Local dDtAux	:= CTOD('')

Default dDtTxDolar := CTOD('')

If !Empty(dDtTxDolar)
	
	//Efetua 5 tentativas de consulta a taxa do dolar
	For nX := 1 To 5
		
		nRet := 0
		
		dDtAux := dDtTxDolar - nDiasAnt
		++nDiasAnt
		 
		//Efetua a consulta da taxa do d๓lar
		oXmlTxD	:= GetObjTxD(cUrl,dDtAux)
		
		//Verifica se houve retorno WebService
		If ValType(oXmlTxD) == "O"
		   	
		   	If XmlNodeExist(oXmlTxD,"_SOAPENV_ENVELOPE") 
		   		If XmlNodeExist(oXmlTxD:_SOAPENV_ENVELOPE,"_SOAPENV_BODY") 
					If XmlNodeExist(oXmlTxD:_SOAPENV_ENVELOPE:_SOAPENV_BODY,"_MULTIREF") 
						nRet := Val(oXmlTxD:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_MULTIREF:TEXT)	
					Endif
		   		Endif 
		   	EndIf
		   	
		   	//Verifica se encontrou a taxa do dolar
		   	If nRet != 0
				Exit
			EndIf
		EndIf
	Next	

Else
	Aviso("Consulta Taxa do D๓lar","Data de refer๊ncia nใo preenchida.",{"Ok"},2)
EndIf

If nRet == 0
	Aviso("Aten็ใo","Nใo foi possํvel encontrar a cota็ใo do d๓lar para a data: "+dtoc(dDtTxDolar),{"Ok"},2)	
EndIf

Return nRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetObjTxD	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o objeto da consulta da taxa do dolar no BCB		  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetObjTxD(cUrl, dDtConsDol)
Local aArea       := GetArea()
Local cSoap	      :=""	
Local oXmlRet	                                                 

Default cUrl		:= "" 
Default dDtConsDol  := CTOD('')

//Preenchimento da string a ser consultada 	
cSoap	+= ' <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:pub="http://publico.ws.casosdeuso.sgs.pec.bcb.gov.br">'
cSoap	+= '    <soapenv:Header/>'
cSoap	+= '    <soapenv:Body>'
cSoap	+= '       <pub:getValor soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'
cSoap	+= '          <in0 xsi:type="xsd:long">1</in0>'
cSoap	+= '          <in1 xsi:type="xsd:string">'+DTOC(dDtConsDol)+'</in1>'
cSoap	+= '       </pub:getValor>'
cSoap	+= '    </soapenv:Body>'
cSoap	+= '</soapenv:Envelope>'

//Chama a rotina de conexใo do WS
oXmlRet := MySvcSoapCall(cSoap,cUrl) //Objeto de retorno do ws


Return oXmlRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMySvcSoapCall	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o objeto da consulta da taxa do dolar no BCB		  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MySvcSoapCall(cSoap, cPostUrl )

Local cRetPost  := ""
Local aHeadOut  := {}
Local cXmlHead  := ""     
Local cError    := ""
Local cWarning  := ""
Local oXmlRet   := Nil    

TIMEINI := TIME()
                                           
aadd(aHeadOut,'SOAPAction: ""')
aadd(aHeadOut,'Content-Type: text/xml; charset=UTF-8')
aadd(aHeadOut,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')

cRetPost := Httppost(cPostUrl,"",cSoap,,aHeadOut,@cXmlHead) 

If !Empty(cRetPost)
	oXmlRet := XmlParser(cRetPost,'_',@cError,@cWarning)
EndIf

Return(oXmlRet)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuPZCCSB9	  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o objeto da consulta da taxa do dolar no BCB		  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuPZCCSB9(cCod, dDtRef)
                
Local aArea 	:= GetArea()
Local cQuery    := ""
Local cAliasTmp	:= GetNextAlias()   
Local aFechAux	:= {}

Default cCod 	:= ""
Default dDtRef  := CTOD('')

cQuery    := " SELECT R_E_C_N_O_ RECNOSB2 FROM "+RetSqlName("SB2")
cQuery    += "  WHERE D_E_L_E_T_ = ' ' "
cQuery    += "  AND B2_FILIAL = '"+xFilial("SB2")+"' "
cQuery    += "  AND B2_COD = '"+cCod+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasTmp , .F., .T.)

DbSelectArea("SB2")
DbSetOrder(1)

DbSelectArea(cArqSPP)
DbSetOrder(1)

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	SB2->(DbGotO((cAliasTmp)->RECNOSB2))

	aFechAux := {}
	aFechAux := u_GetEstPP(SB2->B2_COD, SB2->B2_LOCAL, dDtRef)

	If Len(aFechAux) >= 2
		
		If (cArqSPP)->(DbSeek(xFilial("SB2") + SB2->B2_COD + SB2->B2_LOCAL ))
		
			RecLock(cArqSPP, .F.)
	
			(cArqSPP)->YYY_QUANT	:= aFechAux[1]         
		
			If aFechAux[1] != 0
				(cArqSPP)->YYY_YCMVG 	:= aFechAux[2] / aFechAux[1]
			Else             
				(cArqSPP)->YYY_YCMVG	:= 0
			EndIf
		
			(cArqSPP)->YYY_YTCMG	:= aFechAux[2]

   			(cArqSPP)->(MsUnLock())
   			
		Else
			
			RecLock(cArqSPP, .T.)
	        
	 		(cArqSPP)->YYY_FILIAL 	:= xFilial("SB2")
	 		(cArqSPP)->YYY_COD		:= SB2->B2_COD
	 		(cArqSPP)->YYY_LOCAL 	:= SB2->B2_LOCAL
	 		
			(cArqSPP)->YYY_QUANT	:= aFechAux[1]         
		
			If aFechAux[1] != 0
				(cArqSPP)->YYY_YCMVG 	:= aFechAux[2] / aFechAux[1]
			Else             
				(cArqSPP)->YYY_YCMVG	:= 0
			EndIf
		
			(cArqSPP)->YYY_YTCMG	:= aFechAux[2]

   			(cArqSPP)->(MsUnLock())
		EndIf                                   
	EndIf
		
	(cAliasTmp)->(DbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvPZCBR		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza o valor da tabela temporaria					  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvPZCBR(cCod, cLocal, nQtd, nVal, lSaida)

Local aArea 	:= GetArea()

Default cCod	:= "" 
Default cLocal	:= "" 
Default nQtd	:= 0 
Default nVal	:= 0 
Default lSaida	:= .F.

DbSelectArea("SB2")
DbSetOrder(1)
If (cArqSPP)->(DbSeek(xFilial("SB2") + PADR(cCod, TAMSX3("B2_COD")[1]) + PADR(cLocal, TAMSX3("B2_LOCAL")[1])   ))
	
	//Verifica se a atualiza็ใo vem de um documento de saida
	If lSaida
        
		//Atualiza o total do CMG BR
		RecLock(cArqSPP,.F.)
		(cArqSPP)->YYY_QUANT -= nQtd 
		(cArqSPP)->YYY_YTCMG -= nVal 
		
		If (cArqSPP)->YYY_QUANT != 0
			(cArqSPP)->YYY_YCMVG := (cArqSPP)->YYY_YTCMG / (cArqSPP)->YYY_QUANT
		Endif
		
		SB2->(MsUnLock())
	
	Else//Atualiza็ใo de entrada
		
		RecLock(cArqSPP,.F.)                                
		(cArqSPP)->YYY_QUANT += nQtd 
		(cArqSPP)->YYY_YTCMG += nVal 
		
		If (cArqSPP)->YYY_QUANT != 0
			(cArqSPP)->YYY_YCMVG := (cArqSPP)->YYY_YTCMG / (cArqSPP)->YYY_QUANT
		Endif
        
		/*If ((cArqSPP)->YYY_QUANT + nQtd) > 0
			(cArqSPP)->YYY_YCMVG	:= ((cArqSPP)->YYY_YTCMG + nVal) / ((cArqSPP)->YYY_QUANT + nQtd)
		EndIf
		
		(cArqSPP)->YYY_YTCMG := ((cArqSPP)->YYY_YTCMG + nVal)
		(cArqSPP)->YYY_QUANT := (cArqSPP)->YYY_QUANT + nQtd */
        
		SB2->(MsUnLock())
	EndIf
EndIf


RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTabTempPP		  บAutor  ณMicrosiga      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria a tabela temporaria, para o recalculo do CMG		  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TabTempPP()

Local aArea := GetArea()
Local aCmp	:= {}
Local cArq	:= ""

aAdd (aCmp, {"YYY_FILIAL"	,"C", TAMSX3("B2_FILIAL")[1],	TAMSX3("B2_FILIAL")[2]})
aAdd (aCmp, {"YYY_COD"		,"C", TAMSX3("B2_COD")[1]  ,	TAMSX3("B2_COD")[2]})
aAdd (aCmp, {"YYY_LOCAL"	,"C", TAMSX3("B2_LOCAL")[1],	TAMSX3("B2_LOCAL")[2]})
aAdd (aCmp, {"YYY_QUANT"	,"N", TAMSX3("B2_YQTDCMG")[1],	TAMSX3("B2_YQTDCMG")[2]})
aAdd (aCmp, {"YYY_YCMVG"	,"N", TAMSX3("B2_YCMVG")[1],	TAMSX3("B2_YCMVG")[2]})
aAdd (aCmp, {"YYY_YTCMG"	,"N", TAMSX3("B2_YTCMG")[1],	TAMSX3("B2_YTCMG")[2]})

cArq	:=	CriaTrab (aCmp)
DbUseArea (.T., __LocalDriver, cArq, cArqSPP)
IndRegua (cArqSPP, cArq, "YYY_FILIAL+YYY_COD+YYY_LOCAL")

RestArea(aArea)
Return  
                       


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDPais	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o custo gerencial na data		 				  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
Static Function GetDPais(cCodPais)

Local aArea := GetArea()
Local cRet	:= ""

Default cCodPais := ""

DbSelectArea("SYA")
DbSetOrder(1)
If !Empty(cCodPais)
	If SYA->(MsSeek(xFilial("SYA") + cCodPais))
		cRet := SYA->YA_DESCR
	EndIf
EndIf

RestArea(aArea)
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPP3GtMAtu	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gatilho para retornar a massa de margem atual			  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/       
User Function PP3GtMAtu()

Local aArea := GetArea()
Local nRet	:= 0

//Regra: ("Pr็.Tab.Atual"-("Pr็.Tab.Atual" * "Impostos%") - CMG Atual) * Qtd.Prote็ใo
nRet := (;  
			GdFieldGet("P06_PRCATU"); 
				-; 
			(  (GdFieldGet("P06_PRCATU") * (GdFieldGet("P06_ALICMS") + GdFieldGet("P06_ALPIS") + GdFieldGet("P06_ALCOFI")))/100  );
			   -; 
			   GdFieldGet("P06_CUSCON");
		) * GdFieldGet("P06_QUANT")

RestArea(aArea)
Return nRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPP3GtNvM	  บAutor  ณMicrosiga	      บ Data ณ  06/10/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gatilho para nova massa de margem 						  บฑฑ
ฑฑบ          ณ 			          						  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/       
User Function PP3GtNvM()

Local aArea := GetArea()
Local nRet	:= 0

//Regra: ("Novo Pr็.Tab."-("Novo Pr็.Tab." * "Impostos%") - Novo CMG) * Qtd.Prote็ใo
nRet := (;  
			GdFieldGet("P06_PRCNOV"); 
				-; 
			(  (GdFieldGet("P06_PRCNOV") * (GdFieldGet("P06_ALICMS") + GdFieldGet("P06_ALPIS") + GdFieldGet("P06_ALCOFI")))/100  );
			   -; 
			   GdFieldGet("P06_YCMVG");
		) * GdFieldGet("P06_QUANT")

RestArea(aArea)
Return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPP3Wizard	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Assistente para preencher os itens do Price Protection     บฑฑ
ฑฑบ          ณ 				                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PP3Wizard()

Local aArea 	:= GetArea()
Local aParam	:= {}

If !(INCLUI .OR. ALTERA)
	Aviso("Aten็ใo","Rotina utilizada apenas na inclusใo ou altera็ใo do documento.",{"Ok"},2)
	Return
EndIf

If u_PP3VldCb()
	If PergPP3(@aParam)
		
		//Chama a rotina para efetuar os calculos dos itens do Price Protection
		//AddItPP3(cCodPais, cCodProd, cCodTab, nNovoPrc, nCMGAtu, nNovoCMG, nAliqICMS, nAliqPIS, nAliqCof, nNovoSRP)
		LJMsgRun("Aguarde o processamento...","Aguarde...",{||	AddItPP3(aParam[1], aParam[2], aParam[3], aParam[4],aParam[5], aParam[6], aParam[7], aParam[8], aParam[9], aParam[10], aParam[11]) })
		
	EndIf
EndIf

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergPP3	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas a serem utilizadas no preenchimento do Price     บฑฑ
ฑฑบ          ณ Protection                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergPP3(aParams)

Local aParamBox  := {}
Local lRet       := .T.
Local cPaisIni	 := "105"+Space(TAMSX3("P06_PAIS")[1]-3 )//Padrใo 105 - Brasil
Local cCodTabIni := U_MyNewSX6("NC_PP3TAB",;
									"018",;
									"C",;
									"C๓digo da tabela de pre็o sugerida para o PP (Estoque NC)",;
									"C๓digo da tabela de pre็o sugerida para o PP (Estoque NC)",;
									"C๓digo da tabela de pre็o sugerida para o PP (Estoque NC)",;
									.F. ) 
Local nCIMSni	:= U_MyNewSX6("NC_PP3ICMS",;
									"18",;
									"N",;
									"Aliq.ICMS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.ICMS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.ICMS utilizado no calculo do PP (Estoque NC)",;
									.F. ) 
Local nPISIni	:= U_MyNewSX6("NC_PP3PIS",;
									"1.65",;
									"N",;
									"Aliq.PIS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.PIS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.PIS utilizado no calculo do PP (Estoque NC)",;
									.F. ) 
Local nCOFIni	:= U_MyNewSX6("NC_PP3COF",;
									"7.6",;
									"N",;
									"Aliq.COFINS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.COFINS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.COFINS utilizado no calculo do PP (Estoque NC)",;
									.F. ) 

AADD(aParamBox,{1,"Cod.Pais:"				,cPaisIni						,"@!"	,"ExistCpo('SYA')","SYA","",70,.T.})
AADD(aParamBox,{1,"Cod.Produto"				,Space(TAMSX3("B1_COD")[1])		,"@!"	,"ExistCpo('SB1')","SB1","",70,.T.})
AADD(aParamBox,{1,"Cod.Tab.Pre็o"			,cCodTabIni						,"@!"	,"ExistCpo('DA0')","DA0","",70,.T.})
AADD(aParamBox,{1,"Pr็.Tabela Ant."			,0								,X3PICTURE("P06_TOTAL")	,"","","",70,.T.})
AADD(aParamBox,{1,"Novo Pr็.Tabela"			,0								,X3PICTURE("P06_TOTAL")	,"","","",70,.T.})
AADD(aParamBox,{1,"Custo Ant. $ "			,0								,X3PICTURE("P06_VLUNIT")	,"","","",70,.T.})
AADD(aParamBox,{1,"Novo Custo $ "			,0								,X3PICTURE("P06_VLUNIT")	,"","","",70,.T.})
AADD(aParamBox,{1,"Aliq.ICMS"				,nCIMSni						,X3PICTURE("P06_ALICMS")	,"","","",70,.T.})
AADD(aParamBox,{1,"Aliq.PIS"				,nPISIni						,X3PICTURE("P06_ALPIS")	,"","","",70,.T.})
AADD(aParamBox,{1,"Aliq.Cofins"				,nCOFIni						,X3PICTURE("P06_ALCOFI")	,"","","",70,.T.})
AADD(aParamBox,{1,"Novo SRP"				,0								,X3PICTURE("P06_SRPNOV")	,"","","",70,.F.})


lRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .f., .f.)

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPP3VldCb	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas a serem utilizadas no preenchimento do Price     บฑฑ
ฑฑบ          ณ Protection                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PP3VldCb()

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux   := ""

If Empty(M->P05_DTAPLI)
	cMsgAux += "-Dt.Aplica็ใo nใo preenchida"+CRLF
	lRet := .F.
EndIf

If M->P05_TXDOLA <= 0
	cMsgAux += "-Tx.Dolar nใo preenchida"+CRLF	
	lRet := .F.
EndIf

If !lRet
	Aviso("VLDCAMPCAB","Campos obrigat๓rios nใo preenchido: "+CRLF+cMsgAux,{"Ok"},2)
EndIf

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPP3Import	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para importar os itens do PP			  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PP3Import()

Local aArea := GetArea()
Local aBotoes	:= {}
Local aSays		:= {}
Local nOpcao	:= 0   
Local aPerg	:= {}

Private  alMsgErro	:= {}

If !(INCLUI .OR. ALTERA)
	Aviso("Aten็ใo","Rotina utilizada apenas na inclusใo ou altera็ใo do documento.",{"Ok"},2)
	Return
EndIf


If u_PP3VldCb()
	
	//Tela de aviso e acesso aos parametros
	AAdd(aSays,"[Importa็ใo de Itens do Price Protection]")
	AAdd(aSays,"Este programa auxiliarแ na importa็ใo dos itens.")
	
	
	AAdd(aBotoes,{ 5,.T.,{|| aPerg := PergFile() 		}} )
	AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
	AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )
	FormBatch( "[Importa็ใo]", aSays, aBotoes )
	
	//Verifica se o parametro com o endere็o do arquivo foi preenchido
	If Len(aPerg) > 0
		
		If aPerg[1]
			If nOpcao == 1
				Processa({|| PP3ImpArq(aPerg[2][1]) })
			EndIf
		Else
			Aviso("Erro na importa็ใo","Erro ao ler arquivo...",{"Ok"},2)
		EndIf
	Else
		Aviso("Campo obrigat๓rio","O parโmetro com o nome do arquivo nใo foi preenchido ! ",{"Ok"},2)
	EndIf
	
EndIf

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergFile	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pergunta com o endere็o do arquivo						  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPP3ImpArq	บAutor  ณElton C.		     บ Data ณ  18/10/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento da rotina de importacao					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PP3ImpArq(clArqPro)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local nX			:= 0
Local nlCont		:= 1
Local aErro			:= {}
Local cValPrcAnt	:= ""
Local cValPrcAux	:= ""
Local cCusAtuAux	:= ""
Local cCusNovAux	:= ""
Local cAlqIcmsAux	:= ""
Local cAlqPisAux	:= ""
Local cAlqCofAux	:= ""
Local cNovSRPAux	:= ""

Default clArqPro := ""


If !File(clArqPro)
	Aviso("Aten็ใo", "O arquivo informado nใo foi localizado.",{"Ok"},2)
EndIf     

FT_FUse(clArqPro)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo (Cabe็alho)
    If nlCont == 1
    	nlCont++
    	FT_FSkip()
       loop
    EndIf
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	alLinha := {}
	
	cLinha   	:= FT_FReadLn() //Le alinha    
	alLinha		:= Separa(cLinha,";") //Quebra a linha em colunas de acordo com o delimitador ';'
	
	//Verifica se o arquivo esta com a quantidade de colunas correta
	If Len(alLinha) >= 11
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha ) 
	Else
		Aviso("Formado invแlido","Formato do arquivo invแlido, verifique o layout correto")
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 

If Len(aArquivo) > 0
	ProcRegua(Len(aArquivo))
			
	For nX := 1 To Len(aArquivo)
		IncProc("Efetuando a importa็ใo...")
		
		If VldImpIt(aArquivo[nX], @aErro, nX+1)//Obs. adicionado +1 na linha, tendo em vista a retirada do cabe็alho
			
			//Preenchimento das variaveis auxiliares
			cValPrcAnt	:= ""
			cValPrcAnt	:= Strtran( aArquivo[nX][4], ".", "" )
			cValPrcAnt	:= Strtran( cValPrcAnt , ",", "." )

			cValPrcAux	:= ""
			cValPrcAux	:= Strtran( aArquivo[nX][5], ".", "" )
			cValPrcAux	:= Strtran( cValPrcAux , ",", "." )
			
			cCusAtuAux	:= ""
			cCusAtuAux	:= Strtran( aArquivo[nX][6], ".", "" )
			cCusAtuAux	:= Strtran( cCusAtuAux , ",", "." )

			cCusNovAux	:= ""
			cCusNovAux	:= Strtran( aArquivo[nX][7], ".", "" )
			cCusNovAux	:= Strtran( cCusNovAux , ",", "." )

			cAlqIcmsAux	:= ""
			cAlqIcmsAux	:= Strtran( aArquivo[nX][8], ".", "" )
			cAlqIcmsAux	:= Strtran( cAlqIcmsAux , ",", "." )

			cAlqPisAux	:= ""
			cAlqPisAux	:= Strtran( aArquivo[nX][9], ".", "" )
			cAlqPisAux	:= Strtran( cAlqPisAux , ",", "." )

			cAlqCofAux	:= ""
			cAlqCofAux	:= Strtran( aArquivo[nX][10], ".", "" )
			cAlqCofAux	:= Strtran( cAlqCofAux , ",", "." )

			cNovSRPAux	:= ""
			cNovSRPAux	:= Strtran( aArquivo[nX][11], ".", "" )
			cNovSRPAux	:= Strtran( cNovSRPAux , ",", "." )

		
			//AddItPP3(cCodPais, cCodProd, cCodTab, nPrcAnt,nNovoPrc, nCMGAtu, nNovoCMG, nAliqICMS, nAliqPIS, nAliqCof, nNovoSRP)
			LJMsgRun("Aguarde o processamento...","Aguarde...",{|| ;
																	AddItPP3(aArquivo[nX][1],;//Codigo do paํs 
																			aArquivo[nX][2],;//C๓digo do produto 
																			aArquivo[nX][3],;//Codigo da tabela   
																			Val(cValPrcAnt),;//Pr็.Tab.Ant
																			Val(cValPrcAux),;//Novo Pr็.da tabela 
																			Val(cCusAtuAux),;//Custo atual em $ 
																			Val(cCusNovAux),;//Novo custo em $ 
																			Val(cAlqIcmsAux),;//Aliq.ICMS 
																			Val(cAlqPisAux),;//Aliq.PIS 
																			Val(cAlqCofAux),;//Aliq.COFINS
																			Val(cNovSRPAux));//Novo SRP (Campo nใo obrigat๓rio)	
																	})
		EndIf
	Next
	
	If Len(aErro) > 0
		If Aviso("Aten็ใo", "Alguns itens nใo foram importados, deseja visualizar o log de erro ? ", {"Sim","Nใo"}, 2) == 1

			//Chama a rotina para imprimir o log de importa็ใo
			CtRConOut(aErro)
		EndIf
	
	EndIf	

EndIf

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVldImpIt	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo dos itens a serem importados					  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldImpIt(aArqImp, aErro, nLin)

Local aArea 	:= GetArea()
Local cMsgAux   := ""
Local lRet		:= .T.
Local cValAux	:= ""

Default aArqImp	:= {} 
Default aErro 	:= {}
Default nLin	:= 0

//Valida็ใo do paํs  [1]
If !Empty(aArqImp[1])
	DbSelectArea("SYA")
	DbSetOrder(1)
	If !SYA->(MsSeek(xFilial("SYA") + aArqImp[1] ))
		lRet 	  := .F.
		cMsgAux   += "-Cod.do paํs nใo encontrado"+CRLF
	EndIf
Else
	lRet := .F.
	cMsgAux   += "-Cod.do paํs nใo preenchido"+CRLF	
EndIf

//Valida็ใo do produto [2] 
If !Empty(aArqImp[2])
	DbSelectArea("SB1")
	DbSetOrder(1)
	If !SB1->(MsSeek(xFilial("SB1") + aArqImp[2]))
		lRet := .F.
		cMsgAux   += "-Cod.do produto nใo encontrado"+CRLF
	EndIf
Else
	lRet := .F.
	cMsgAux   += "-Cod.do produto nใo preenchido"+CRLF
EndIf

//Valida็ใo da tabela [3]
If !Empty(aArqImp[3])
	DbSelectArea("DA0")
	DbSetOrder(1)
	If !DA0->(MsSeek(xFilial("DA0") + PadR(aArqImp[3],TamSx3("DA0_CODTAB")[1]) ))
		lRet := .F.
		cMsgAux   += "-Cod.da tabela nใo encontrado"+CRLF
	EndIf
	
Else
	lRet := .F.
	cMsgAux   += "-Cod.da tabela nใo preenchido"+CRLF
EndIf

//Valida็ใo do Pr็.Ant.Tab.[4]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[4], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Pre็o anterior de tabela nใo preenchido."+CRLF
EndIf                                                           

//Valida็ใo do Novo Pr็.da tabela[5]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[5], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Novo pre็o de tabela nใo preenchido."+CRLF
EndIf                                                           
 
//Valida็ใo do Custo atual em $ [6]     
cValAux	:= ""
cValAux	:= Strtran( aArqImp[6], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Custo atual em $ nใo preenchido."+CRLF
EndIf   

                                                        
//Valida็ใo do Novo custo em $ [7]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[7], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Novo Custo em $ nใo preenchido."+CRLF
EndIf   

//Valida็ใo da Aliq.ICMS [8]    
cValAux	:= ""
cValAux	:= Strtran( aArqImp[8], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )                  
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Aliq.ICMS nใo preenchido."+CRLF
EndIf   

//Valida็ใo da Aliq.PIS [9]
cValAux	:= "" 
cValAux	:= Strtran( aArqImp[9], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Aliq.PIS nใo preenchido."+CRLF
EndIf   

//Valida็ใo da Aliq.COFINS [10]
cValAux	:= "" 
cValAux	:= Strtran( aArqImp[10], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Aliq.COFINS nใo preenchido."+CRLF
EndIf   

//Preenche o log de erro
If !lRet
	Aadd(aErro,Replicate("-", 100)+CRLF+CRLF)
	Aadd(aErro,"Erro na linha: "+Alltrim(Str(nLin))+CRLF )
	Aadd(aErro,cMsgAux)			
EndIf 

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณAddItPP3	บAutor  ณElton C.		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina utilizada para adicionar os itens do PP			  บฑฑ
ฑฑบ          ณ 			                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AddItPP3(cCodPais, cCodProd, cCodTab, nPrcAnt,nNovoPrc, nCMGAtu, nNovoCMG, nAliqICMS, nAliqPIS, nAliqCof, nNovoSRP)

Local aArea 		:= GetArea()
Local cQuery    	:= ""
Local cArqTmp		:= GetNextAlias()
Local cNomPais 		:= ""
Local cDescProd		:= ""
Local cCodPlat		:= ""
Local cDescPlat		:= ""
Local nSRPAtu		:= 0
Local aCMGBr		:= {0,0,0}
Local nPrcAtu		:= 0
Local lExisteEst 	:= .F.
Local nAscan		:= 0

Default cCodPais	:= "" 
Default cCodProd	:= "" 
Default cCodTab		:= ""  
Default nPrcAnt		:= 0
Default nNovoPrc	:= 0 
Default nCMGAtu		:= 0 
Default nNovoCMG	:= 0 
Default nAliqICMS	:= 0 
Default nAliqPIS	:= 0 
Default nAliqCof	:= 0  
Default nNovoSRP	:= 0 

cQuery:=" Select SB2.R_E_C_N_O_ SB2RECNO FROM "+RetSqlName("SB2")+" SB2"+CRLF
cQuery+=" Where SB2.B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
cQuery+=" And SB2.B2_COD='"+cCodProd+"' "+CRLF
cQuery+=" And SB2.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

//Preenche os dados referente ao paํs 
cNomPais  	:= Posicione("SYA",1,xFilial("SYA")+Alltrim(cCodPais),"YA_DESCR")

//Preenche os dados do produto
DbSelectArea("SB1")
DbSetOrder(1)
If SB1->(MsSeek(xFilial("SB1") + cCodProd))
	cDescProd 	:= SB1->B1_XDESC
	cCodPlat	:= SB1->B1_PLATAF
	cDescPlat	:= SB1->B1_PLATEXT
	nSRPAtu		:= SB1->B1_CONSUMI
EndIf

//Preenche o pre็o do produto na tabela atual
//nPrcAtu	:= Posicione("DA1",1,xFilial("DA1") + PadR(cCodTab,TamSx3("DA1_CODTAB")[1]) + PadR(cCodProd,TamSx3("DA1_CODPRO")[1]),"DA1_PRCVEN")
nPrcAtu 	:= nPrcAnt

          

DbSelectArea("SB2")
DbSetOrder(1)
While (cArqTmp)->(!Eof())
     SB2->(DbGoTo((cArqTmp)->SB2RECNO))
	 
	 aCMGBr	:= U_GetEstPP(cCodProd, SB2->B2_LOCAL, M->P05_DTAPLI)//Retorno: [1]Quantidade [2]Custo Total [3]Custo Unitario
	 
	 
	 //Verifica se existe estoque para o produto
	 If Len(aCMGBr) >= 3 .And. (aCMGBr[1] != 0  )
	 	 
	 	//Variavel utilizada para verificar se existe saldo do produto na data de aplica็ใo
	 	lExisteEst 	:= .T. 
	                                                                     
		//Verifica se a linha do item ja foi preenchida	                        
	 	If Empty(oGetDados:aCols[oGetDados:NAT,GdFieldPos("P06_CODPRO")])
	 		nAscan := oGetDados:NAT	 	
			
	 	Else//Adiciona linha nos itens do PP
			Eval(oGetDados:oBrowse:BADD)
			nAscan:=Len(oGetDados:aCols)
		EndIf		                        
		
		//Preenchimento das campos/colunas dos itens do PP
		oGetDados:aCols[nAscan,GdFieldPos("P06_PAIS")]		:= cCodPais //Pais
		oGetDados:aCols[nAscan,GdFieldPos("P06_DPAIS")]		:= cNomPais	//Descri็ใo do pais	
		oGetDados:aCols[nAscan,GdFieldPos("P06_CODPRO")]	:= cCodProd //Codigo do produto 
		oGetDados:aCols[nAscan,GdFieldPos("P06_DESC")]		:= cDescProd//Descri็ใo do produto
		oGetDados:aCols[nAscan,GdFieldPos("P06_CPLATA")]	:= cCodPlat//Cod.Plataforma
		oGetDados:aCols[nAscan,GdFieldPos("P06_DPLATA")]	:= cDescPlat//Descri็ใo da plataforma
		oGetDados:aCols[nAscan,GdFieldPos("P06_LOCAL")]		:= SB2->B2_LOCAL //Armazem
		oGetDados:aCols[nAscan,GdFieldPos("P06_ALICMS")]	:= nAliqICMS	//Alq.ICMS
		oGetDados:aCols[nAscan,GdFieldPos("P06_ALPIS")]		:= nAliqPIS	//Aliq.PIS	
		oGetDados:aCols[nAscan,GdFieldPos("P06_ALCOFI")]	:= nAliqCof  //Aliq.COFINS
		oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")]		:=	aCMGBr[1]//Quantidade protegida
		oGetDados:aCols[nAscan,GdFieldPos("P06_QTDORI")]	:=	aCMGBr[1]//Quantidade original 
		oGetDados:aCols[nAscan,GdFieldPos("P06_VLUNIT")]	:= 	(nCMGAtu - nNovoCMG) * M->P05_TXDOLA//Valor unitแrio do repasse
		oGetDados:aCols[nAscan,GdFieldPos("P06_TOTAL")]		:= 	oGetDados:aCols[nAscan,GdFieldPos("P06_VLUNIT")] * oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")]//Valor total do repasse
		oGetDados:aCols[nAscan,GdFieldPos("P06_DLCONV")]	:=  Iif(M->P05_TXDOLA !=0, oGetDados:aCols[nAscan,GdFieldPos("P06_TOTAL")] / M->P05_TXDOLA, 0)//Valor do repasse em dolar
		oGetDados:aCols[nAscan,GdFieldPos("P06_CUSCON")]	:=  aCMGBr[3]//CMG Atual
		oGetDados:aCols[nAscan,GdFieldPos("P06_CUSTCT")]	:= 	aCMGBr[2]//Total CMG Atual
		oGetDados:aCols[nAscan,GdFieldPos("P06_YCMVG")]		:=	oGetDados:aCols[nAscan,GdFieldPos("P06_CUSCON")] - oGetDados:aCols[nAscan,GdFieldPos("P06_VLUNIT")]//Novo CMG
		oGetDados:aCols[nAscan,GdFieldPos("P06_CTGER")]		:= 	oGetDados:aCols[nAscan,GdFieldPos("P06_YCMVG")] * oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")]  // Total do Novo CMG
		oGetDados:aCols[nAscan,GdFieldPos("P06_SRPATU")]	:=  nSRPAtu	//SRP Atual
		oGetDados:aCols[nAscan,GdFieldPos("P06_SRPNOV")]	:= 	nNovoSRP//Novo SRP
		oGetDados:aCols[nAscan,GdFieldPos("P06_TABPRC")]	:=  cCodTab//Cod. da tabela de pre็o 
		oGetDados:aCols[nAscan,GdFieldPos("P06_PRCATU")]	:= 	nPrcAtu//Pre็o da tabela atual
		oGetDados:aCols[nAscan,GdFieldPos("P06_PRCNOV")]	:= 	nNovoPrc//Novo pre็o de tabela
		oGetDados:aCols[nAscan,GdFieldPos("P06_MASATU")]	:=  (nPrcAtu-( (nPrcAtu * (nAliqICMS+nAliqPIS+nAliqCof) ) /100) - oGetDados:aCols[nAscan,GdFieldPos("P06_CUSCON")]) * oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")] //Massa de margem atual
		oGetDados:aCols[nAscan,GdFieldPos("P06_MASNOV")]	:= 	(nNovoPrc-( (nNovoPrc * (nAliqICMS+nAliqPIS+nAliqCof) ) /100) - oGetDados:aCols[nAscan,GdFieldPos("P06_YCMVG")]) * oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")]//Nova Massa de margem
		oGetDados:aCols[nAscan,GdFieldPos("P06_DIFMAS")]	:=  oGetDados:aCols[nAscan,GdFieldPos("P06_MASATU")] - oGetDados:aCols[nAscan,GdFieldPos("P06_MASNOV")]//Diferen็a da massa de margem
		oGetDados:aCols[nAscan,GdFieldPos("P06_MGATUA")]	:= 	Iif(aCMGBr[1] * nPrcAtu != 0,((oGetDados:aCols[nAscan,GdFieldPos("P06_MASATU")] / (oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")] * oGetDados:aCols[nAscan,GdFieldPos("P06_PRCATU")]) )) * 100, 0)//%Margem Atual
		oGetDados:aCols[nAscan,GdFieldPos("P06_MGNOVA")]	:= 	Iif(aCMGBr[1] * nNovoPrc != 0,((oGetDados:aCols[nAscan,GdFieldPos("P06_MASNOV")] / (oGetDados:aCols[nAscan,GdFieldPos("P06_QUANT")] * oGetDados:aCols[nAscan,GdFieldPos("P06_PRCNOV")]) )) * 100, 0)//%Nova Margem 
		     
	 EndIf
	(cArqTmp)->(DbSkip())
EndDo

If !lExisteEst 
	Aviso("Aten็ใo", "Nใo existe saldo em estoque para o produto: "+Alltrim(cCodProd) +" - "+ Alltrim(cDescProd),{"Ok"},2)
EndIf

//Atualiza a getdados
oGetDados:ForceRefresh()

RestArea(aArea)
Return
