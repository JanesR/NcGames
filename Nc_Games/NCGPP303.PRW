#INCLUDE "PROTHEUS.CH"


#DEFINE VLBRUTONC 2
#DEFINE VLLIQUINC 4
#DEFINE VLCUSTANT 4
#DEFINE MGANTERIOR 7
#DEFINE VERBAANT 5
#DEFINE VLREPASSE 8


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPP303		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para manutenção do Price Protection 				  º±±
±±º          ³(Estoque do cliente)						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPP303()
Private aCores    := {	;
						{"Empty(PZC_DTACEI) .And. Empty(PZC_DTEFET) .And. Empty(PZC_FLAGAR)"	, "BR_VERDE"   , "PP Em Aberto"    	},;
						{"!Empty(PZC_DTACEI) .And. Empty(PZC_DTEFET) .And. (Empty(PZC_FLAGAR) .Or. PZC_FLAGAR == 'R') "	, "BR_VERMELHO", "Aguard.Aprovação" },;
						{"Empty(PZC_DTACEI) .And. Empty(PZC_DTEFET) .And. PZC_FLAGAR == 'R' "	, "BR_PRETO", "Reprovado" },;
						{"!Empty(PZC_DTEFET) .And. !Empty(PZC_DTACEI)"	, "BR_AZUL"   , "Aprovado"      }}
						
Private aRotina	:= xMenuDef()  
Private cCadastro := "Price Protection Cliente"
Private cAlias1 := "PZC"                    // Alias da Enchoice.
Private cAlias2 := "PZD"                    // Alias da GetDados.

DbSelectArea(cAlias1)
DbSetOrder(1)

mBrowse(,,,,cAlias1,,,,,,aCores)                
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PP3CManut		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Manutenção dos registros									  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PP3CManut(cAlias, nRecno, nOpc)
Local i        := 0
Local cLinOK   := "U_PP3CLinOK"
Local cTudoOK  := "U_PP3CTudOK"
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK := ""
Local lVirtual := .T.
Local nLinhas  := 9999
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


If ((nOpc==4 .Or. nOpc==5) .And. !Empty(PZC->PZC_DTACEI)) .Or. (nOpc == 8 .And. !Empty(PZC->PZC_DTACEI)) 
	Aviso("Atenção","Documento efetivado, a manutenção não é permitida ",{"Ok"},2)
	Return                                                                                               
ElseIf (nOpc == 6 .And. !Empty(PZC->PZC_DTACEI) )
	Aviso("Atenção","Documento em aprovação, a manutenção não é permitida ",{"Ok"},2)
	Return
ElseIf (nOpc == 7 .And. !Empty(PZC->PZC_CREDNO) )
	Aviso("Atenção","Credit Note já preenchido",{"Ok"},2)
	Return	
EndIf

If nOpc == 6 .Or. nOpc == 7
	nOpc := 4
EndIf


// Cria variaveis de memoria dos campos da tabela Pai.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

CriaHeader()

CriaCols(nOpc)

AAdd(aButtons, {"Importar"		, {|| PP3Import() }		, "Importar" , "Importar" }) 
AAdd(aButtons, {"Wizard"		, {|| PP3WizardC() }	, "Wizard" , "Wizard" })
											 	
lRet := PP3MntTela(cCadastro, cAlias1, cAlias2, aCpoEnchoice, cLinOK, cTudoOK, nOpcE, nOpcG, cFieldOK, lVirtual, nLinhas, aAltEnchoice, nFreeze,aButtons,,220)

If lRet
	If nOpc == 3
		   
		If Aviso("Atenção", "Confirma a gravação dos dados?", {"Sim","Não"},2 ) == 1
			ConfirmSX8()
			aCols := oGetDados:Acols
			Processa({|| GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
		EndIf
	ElseIf nOpc == 4
		
		If nOpcBkp == 6
			If Aviso("Atenção","Confirma a gravação da Dt. de Aceite do Publisher ?",{"Sim","Não"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf
		ElseIf nOpcBkp == 7
			If Aviso("Atenção","Confirma a gravação do Credit Note",{"Sim","Não"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf
		Else
			If Aviso("Atenção","Confirma a alteração ?",{"Sim","Não"},2) == 1
				aCols := oGetDados:Acols
				Processa({||AltDados(nOpcBkp)}, cCadastro, "Alterando os dados, aguarde...")
			EndIf		  	
		EndIf
		
	ElseIf nOpc == 5                                                         
			
		If Aviso("Atenção","Confirma a exclusão ?",{"Sim","Não"},2) == 1
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaHeader	  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o cabeçalho da tela do PP							  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaHeader()

aHeader      := {}
aCpoEnchoice := {}
aAltEnchoice := {}

// aHeader é igual ao do Modelo2.

dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAlias2)

While !SX3->(EOF()) .And. SX3->X3_Arquivo == cAlias2
	
	If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
		cNivel >= SX3->X3_Nivel .And.;                  // Nivel do Usuario é maior que o Nivel do Campo.
		Trim(SX3->X3_Campo) <> "PZD_CODPP"
		
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
	
	If X3Uso(SX3->X3_Usado)    .And.;                  // O Campo é usado.
		cNivel >= SX3->X3_Nivel                         // Nivel do Usuario é maior que o Nivel do Campo.
		
		// Campos da Enchoice.
		AAdd(aCpoEnchoice, X3_Campo)
		
		// Campos da Enchoice que podem ser editadas.
		// Se tiver algum campo que nao deve ser editado, nao incluir aqui.
		If Alltrim(X3_Campo) != "PZC_DTACEI"
			AAdd(aAltEnchoice, X3_Campo)
		EndIf
		
	EndIf
	
	SX3->(dbSkip())
	
EndDo

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaCols		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o acols da tela do Price Protection					  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
	dbSeek(xFilial(cAlias2) + (cAlias1)->PZC_CODPP)
	
	While (cAlias2)->(!EOF()) .And. (cAlias2)->PZD_FILIAL == xFilial(cAlias2) .And. (cAlias2)->PZD_CODPP == (cAlias1)->PZC_CODPP
		
		AAdd(aCols, Array(nQtdCpo+1))
		nCols++
		
		For i := 1 To nQtdCpo
			If aHeader[i][10] <> "V"
				aCols[nCols][i] := FieldGet(FieldPos(aHeader[i][2]))
			Else
				aCols[nCols][i] := CriaVar(aHeader[i][2], .T.)
			EndIf

		Next
		
		aCols[nCols][nQtdCpo+1] := .F.
		
		AAdd(aAlt, Recno())
		
		(cAlias2)->(dbSkip())
	End
EndIf

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvDados		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava os dados do Price Protection						  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
dbSelectArea("PZD")

For i := 1 To Len(aCols)
	
	IncProc()
	
	If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.
		
		RecLock(cAlias2, .T.)
		
		(cAlias2)->PZD_FILIAL := xFilial(cAlias2)
		(cAlias2)->PZD_CODPP  := M->PZC_CODPP
		
		For y := 1 To Len(aHeader)
			FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
		Next
		                                                                                   
		(cAlias2)->(MSUnlock())
		
	EndIf
	
Next

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AltDados		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rtoina de alteração do Price Protection					  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
		
		(cAlias2)->(MSUnlock())
		
	Else
		
		If !aCols[i][Len(aHeader)+1]
			RecLock(cAlias2, .T.)
			For y := 1 To Len(aHeader)
				FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
			Next
			(cAlias2)->PZD_FILIAL := xFilial(cAlias2)
			(cAlias2)->PZD_CODPP := (cAlias1)->PZC_CODPP
			(cAlias2)->(MSUnlock())
			nItem++
		EndIf
		
	EndIf
	
Next

If nOpcBkp == 6//Grava a daata de aceite do Publisher
	(cAlias1)->(RecLock(cAlias1,.F.))
	(cAlias1)->PZC_DTACEI := M->PZC_DTACEI
	(cAlias1)->PZC_FLAGAR := ""
	(cAlias1)->(MsUnlock()) 
	
	//Chama a rotina para envio do Workflow de aprovação
	u_NCWFPP31(PZC->PZC_CODPP)   

ElseIf	nOpcBkp == 7//Grava o numero Credit Note disponibilizado pelo Publisher

	(cAlias1)->(RecLock(cAlias1,.F.))
	(cAlias1)->PZC_CREDNO := M->PZC_CREDNO
	(cAlias1)->(MsUnlock()) 

EndIf


Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ExcDados		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de excluão do Price Protection						  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ExcDados()


ProcRegua(Len(aCols)+1)   


dbSelectArea(cAlias2)
dbSetOrder(1)

//Exclui os itens
If (cAlias2)->(dbSeek(xFilial(cAlias2) + (cAlias1)->PZC_CODPP))
	While !EOF() .And. (cAlias2)->PZD_FILIAL == xFilial(cAlias2) .And. (cAlias2)->PZD_CODPP == (cAlias1)->PZC_CODPP
		IncProc()
		RecLock(cAlias2, .F.)
		(cAlias2)->(dbDelete())
		(cAlias2)->(MSUnlock())

		(cAlias2)->(dbSkip())
	EndDo
EndIf


//Exclui o cabeçalho
dbSelectArea(cAlias1)
dbSetOrder(1)
RecLock(cAlias1, .F.)
(cAlias1)->(dbDelete())
(cAlias1)->(MSUnlock())


Return Nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PP3CTudOK		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação do documento 									  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PP3CTudOK()
Local lRetorno:=.T.
Local aCposObrigat := GdObrigat( aHeader )
Local aCposKey := {"PZD_CODPRO","PZD_CLIENT", "PZD_LOJA"}

If !GdCheckKey(aCposKey,4,aCposObrigat ) //Verifica Itens duplicados na getdados
	lRetorno := .F.
EndIf

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PP3CLinOK		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação da linha dos itens do Price Protection			  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PP3CLinOK()

Local nLinha    := oGetDados:nAt
Local cMsgAux	:= ""
Local lRet		:= .T.

Local aCposObrigat 	:= GdObrigat( aHeader )
Local aCposKey 		:= {"PZD_CODPRO","PZD_CLIENT", "PZD_LOJA"}

If !GdCheckKey(aCposKey,4,aCposObrigat ) //Verifica Itens duplicados na getdados
	lRet := .F.
EndIf		   

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PP3C03Leg		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Legenda da mBrowse										  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PP3C03Leg()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PP3MntTela	  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta a tela do Price Protection							  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PP3MntTela(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aButtons,aCordW,nSizeHeader)
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
ElseIf nOpcE == 6
	nOpcE 			:= 4
	aAltEnchoice    := {"PZC_DTACEI"}
	lConfirmPP		:= .T.
ElseIf nOpcE == 7
	nOpcE 			:= 4
	aAltEnchoice    := {"PZC_CREDNO"}
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

//Atualiza o cabeçalho o cabeçalho
oTimer:= TTimer():New(500,{|| AtuCabec() },oDlg) // Ativa timer
oTimer:Activate()

ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar(oDlg,{|| Iif(lConfirmPP,	Iif(VldCfmPs(M->PZC_DTAPLI, M->PZC_DTACEI), nOpca:=1,  nOpca:=0) , nOpca := 1 ),;
Iif(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},;
{||oDlg:End()},,aButtons))

lRet:=(nOpca==1)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuCabec 		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Atualiza o cabeçalho do Price Protection					  º±±
±±º          ³ 			          						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtuCabec()

Local aArea 	:= GetArea()
Local nX		:= 0
Local nTotRec	:= 0 //Total recebido do Publisher
Local nTotRecD	:= 0 //Total recebido em dolar
Local nTotRepas	:= 0 //Total repassado

For nX := 1 To Len(oGetDados:aCols)
    
	nTotRec 	+= oGetDados:aCols[nX,GdFieldPos("PZD_TOTPUB")]	//Total recebido
	//nTotRecD	+= oGetDados:aCols[nX,GdFieldPos("PZD_CDOLAR")]
	nTotRepas 	+= oGetDados:aCols[nX,GdFieldPos("PZD_TOTREP")] //Total repassado

	
Next
 
M->PZC_CREDRE := nTotRec// Total recebido 
M->PZC_CDOLAR := Iif(M->PZC_TXDOLA != 0, nTotRec / M->PZC_TXDOLA, 0 )  //Total recebido em $
M->PZC_TOTREP := nTotRepas//Total repassado

//Atualiza o objeto MsMGet
oEnchoice:EnchRefreshAll()

RestArea(aArea)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldCfmPs 		  ºAutor  ³Microsiga      º Data ³  06/10/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se a data de aceite do publisher e menor			  º±±
±±º          ³ que a data de aplicação					  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldCfmPs(dDtApli, dDtAcei)

Local aArea := GetArea()
Local lRet	:= .T.

Default dDtApli	:= CTOD('')
Default dDtAcei	:= CTOD('')


If !Empty(dDtAcei)
	If dDtApli > dDtAcei
		Aviso("Data de aceite incorreta","A data de aceite do Publisher, não pode ser menor que a data de aplicação do Price Protection.",{"Ok"},2)
		lRet := .F.
	EndIf
Else
	Aviso("Data de aceite incorreta","Data de aceite do Publisher, não preenchida.",{"Ok"},2)
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PesqPP  ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao para pesquisa                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PesqPP(ExpC1,ExpN1,ExpN2)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Alias do arquivo                                   ³±±
±±³          ³ ExpN1 = Numero do registro                                 ³±±
±±³          ³ ExpN2 = Numero da opcao selecionada                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PP3CPesqPP(ciAlias,nReg,nOpcx)

Local cOrd		:= ""
Local cCampo	:= Space(40)
Local nOpca		:=0
Local nOpt1		:=0
Local nI			:=0
Local aOrd 		:= {"Nº Price Protecion"}
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MenuDef   ³ Autor ³ Microsiga             ³ Data ³00/00/0000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Utilizacao de menu Funcional                               ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Array com opcoes da rotina.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Parametros do array a Rotina:                               ³±±
±±³          ³1. Nome a aparecer no cabecalho                             ³±±
±±³          ³2. Nome da Rotina associada                                 ³±±
±±³          ³3. Reservado                                                ³±±
±±³          ³4. Tipo de Transa‡„o a ser efetuada:                        ³±±
±±³          ³		1 - Pesquisa e Posiciona em um Banco de Dados         ³±±
±±³          ³    2 - Simplesmente Mostra os Campos                       ³±±
±±³          ³    3 - Inclui registros no Bancos de Dados                 ³±±
±±³          ³    4 - Altera o registro corrente                          ³±±
±±³          ³    5 - Remove o registro corrente do Banco de Dados        ³±±
±±³          ³5. Nivel de acesso                                          ³±±
±±³          ³6. Habilita Menu Funcional                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Jeferson                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function xMenuDef()


Private aRotina := { }

AAdd(aRotina, {"Pesquisar"					, "u_PP3CPesqPP",0 , 1})
AAdd(aRotina, {"Visualizar"					, "u_PP3CManut", 0, 2})
AAdd(aRotina, {"Incluir"   					, "u_PP3CManut", 0, 3})
AAdd(aRotina, {"Alterar"   					, "u_PP3CManut", 0, 4})
AAdd(aRotina, {"Excluir"   					, "u_PP3CManut", 0, 5})
AAdd(aRotina, {"Confirmação do Publisher"	, "u_PP3CManut", 0, 7})
AAdd(aRotina, {"Credit Note Publisher"		, "u_PP3CManut", 0, 8})
AAdd(aRotina, {"Repasse Cred. Cliente"		, "u_NCRepCrC" , 0, 9})
AAdd(aRotina, {"Visualizar WF"				, "u_NCViewWF" , 0, 10})
AAdd(aRotina, {"Legenda"					, "u_PP3C03Leg", 0, 11})

Return(aRotina)
                               
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PP3WizardCºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Assistente para preencher os itens do Price Protection     º±±
±±º          ³ 				                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PP3WizardC()

Local aArea 	:= GetArea()
Local aParam	:= {}

If !(INCLUI .OR. ALTERA)
	Aviso("Atenção","Rotina utilizada apenas na inclusão ou alteração do documento.",{"Ok"},2)
	Return
EndIf

If u_PP3CVldCb()
	If PergPP3C(@aParam)  
		LJMsgRun("Aguarde o processamento...","Aguarde...",{||; 
				    											AddItCPP3(aParam[1],;//Codigo do produto
				    											 			aParam[5],;//Quantidade
				    											 			aParam[2],; //Codigo do cliente
				    											 			aParam[3],; //Loja
				    											 			aParam[6],; //Preço da tabela anterior
				    											 			aParam[7],; //Novo Preço da tabela
				    											 			aParam[8],; //SRP Anterior
				    											 			aParam[9],; //Novo SRP
				    											 			aParam[10],;// Valor unitario de repasse
				    											 			aParam[4],; //Unidade Federativa
				    											 			aParam[16],;//Tipo de repasse (Credito ou Produto)
				    											 			aParam[14],;//% VPC
				    											 			aParam[15],;//% Desconto comercial
				    											 			aParam[11],;//CMG Ant
				    											 			aParam[12],;//Novo CMG
				    											 			aParam[17],;//Aliq.ICMS
				    											 			aParam[18],;//Aliq.PIS
				    											 			aParam[19],;//Aliq.COFINS
				    											 			.F.,;//Gatilho   
				    											 			(aParam[13] == "1"));//Calc. Vpc Vl.Bruto
											    	 	})
	    
	EndIf
EndIf

RestArea(aArea)
Return   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PP3VldCb	ºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Perguntas a serem utilizadas no preenchimento do Price     º±±
±±º          ³ Protection                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PP3CVldCb()

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux   := ""

If Empty(M->PZC_DTAPLI)
	cMsgAux += "-Dt.Aplicação não preenchida"+CRLF
	lRet := .F.
EndIf

If M->PZC_TXDOLA <= 0
	cMsgAux += "-Tx.Dolar não preenchida"+CRLF	
	lRet := .F.
EndIf

If !lRet
	Aviso("VLDCAMPCAB","Campos obrigatórios não preenchido: "+CRLF+cMsgAux,{"Ok"},2)
EndIf

RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PergPP3C	ºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Perguntas a serem utilizadas no preenchimento do Price     º±±
±±º          ³ Protection                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PergPP3C(aParams)

Local aParamBox  := {}
Local lRet       := .T.

AADD(aParamBox,{1,"Cod.Produto"				,Space(TAMSX3("B1_COD")[1])		,"@!"	,"ExistCpo('SB1')","SB1","",70,.T.})
AADD(aParamBox,{1,"Cod.Cliente"				,Space(TAMSX3("A1_COD")[1])		,"@!"	,"ExistCpo('SA1')","SA1","",70,.T.})
AADD(aParamBox,{1,"Loja"					,Space(TAMSX3("A1_LOJA")[1])	,"@!"	,"ExistCpo('SA1',MV_PAR02+MV_PAR03,1)",""	,"",70,.T.})
AADD(aParamBox,{1,"UF Imposto"				,"SP"							,"@!"	,"ExistCpo('SX5','12'+MV_PAR04) ","12","",70,.F.})
AADD(aParamBox,{1,"Qtd.Protegida"			,0								,X3PICTURE("P06_QUANT")	,"","","",70,.T.})
AADD(aParamBox,{1,"Prç.Tabela Ant."			,0								,X3PICTURE("P06_TOTAL")	,"","","",70,.T.})
AADD(aParamBox,{1,"Novo Prç.Tabela"			,0								,X3PICTURE("P06_TOTAL")	,"","","",70,.T.})
AADD(aParamBox,{1,"SRP Ant."				,0								,X3PICTURE("B1_CONSUMI"),"","","",70,.T.})
AADD(aParamBox,{1,"Novo SRP"				,0								,X3PICTURE("B1_CONSUMI"),"","","",70,.T.})
AADD(aParamBox,{1,"Vl.Unit.Pub"				,0								,X3PICTURE("PZD_VLUNIT"),"","","",70,.T.})
AADD(aParamBox,{1,"CMG Anterior"			,0								,X3PICTURE("PZD_UNIREP"),"","","",70,.F.})
AADD(aParamBox,{1,"Novo CMG"				,0								,X3PICTURE("PZD_UNIREP"),"","","",70,.F.})
AADD(aParamBox,{2,"VPC Vlr. Liq. ou Bruto"	,"1"							,{"1=Bruto","2=Liquido"}	, 70,".T."					,.F.})
AADD(aParamBox,{1,"% VPC"					,3								,X3PICTURE("PZD_UNIREP"),"","","",70,.F.})
AADD(aParamBox,{1,"% Desc.Comercial"		,3								,X3PICTURE("PZD_UNIREP"),"","","",70,.F.})
AADD(aParamBox,{2,"Tp.Repasse"				,"1"							, {"1=Credito","2=Produto"}	, 70,".T."					,.F.})
AADD(aParamBox,{1,"Aliq.ICMS"				,0								,X3PICTURE("P06_ALICMS")	,"","","",70,.F.})
AADD(aParamBox,{1,"Aliq.PIS"				,0								,X3PICTURE("P06_ALPIS")	,"","","",70,.F.})
AADD(aParamBox,{1,"Aliq.Cofins"				,0								,X3PICTURE("P06_ALCOFI")	,"","","",70,.F.})

lRet := ParamBox(aParamBox, "Parâmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .f., .f.)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PP3CGatIt	ºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gatilho utilizado para preencher os campos dos itens		  º±±
±±º          ³ caso tenha alterações                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PP3CGatIt(cCampo)

Local aArea 	:= GetArea() 
Local nAscan 	:= oGetDados:NAT//Linha posicionada
Local cCodProd	:= "" 
Local nQtd		:= 0 
Local cCodCli	:= "" 
Local cLoja		:= "" 
Local nPrcTabAnt:= 0 
Local nPrcTabAtu:= 0 
Local nSRPAnt	:= 0 
Local nSRPAtu	:= 0 
Local nVlUnPub	:= 0 
Local nVlUnRep	:= 0 
Local cUF		:= "" 
Local cTpRep	:= ""
Local nPercVPC	:= 0 
Local nPercDCom	:= 0
Local nCMGAnt	:= 0
Local nCMGNov	:= 0
Local nICMS		:= 0 
Local nPIS		:= 0 
Local nCOFINS	:= 0
Local lGatilho	:= .T.
Local lVPCBrt	:= .T.                        

Default cCampo := ""

//Codigo do produto
If "PZD_CODPRO" == Alltrim(cCampo)
	cCodProd := M->PZD_CODPRO
Else
	cCodProd := oGetDados:aCols[nAscan,GdFieldPos("PZD_CODPRO")]
EndIf
                   
//Quantidade
If "PZD_QUANT" == Alltrim(cCampo)
	nQtd := M->PZD_QUANT
Else
	nQtd := oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")]
EndIf

//Cod. do cliente
If "PZD_CLIENT" == Alltrim(cCampo)
	cCodCli := M->PZD_CLIENT
Else
	cCodCli := oGetDados:aCols[nAscan,GdFieldPos("PZD_CLIENT")]
EndIf

//Loja
If "PZD_LOJA" == Alltrim(cCampo)
	cLoja := M->PZD_LOJA
Else
	cLoja := oGetDados:aCols[nAscan,GdFieldPos("PZD_LOJA")]
EndIf

//Preço de tabela anterior
If "PZD_PRCANT" == Alltrim(cCampo)
	nPrcTabAnt := M->PZD_PRCANT
Else
	nPrcTabAnt := oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCANT")]
EndiF

//Novo Preço de tabela
If "PZD_PRCNOV" == Alltrim(cCampo)
	nPrcTabAtu := M->PZD_PRCNOV
Else
	nPrcTabAtu := oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCNOV")]
EndIF

//SRP Anterior                                  
If "PZD_SRPANT" == Alltrim(cCampo)
	nSRPAnt := M->PZD_SRPANT
Else
	nSRPAnt := oGetDados:aCols[nAscan,GdFieldPos("PZD_SRPANT")]
EndIf

//Novo SRP
If "PZD_SRPNOV" == Alltrim(cCampo)
	nSRPAtu := M->PZD_SRPNOV
Else
	nSRPAtu := oGetDados:aCols[nAscan,GdFieldPos("PZD_SRPNOV")]
EndIf

//Valor unitario disponibilizado pelo Publisher
If "PZD_VLUNIT" == Alltrim(cCampo)
	nVlUnPub := M->PZD_VLUNIT
Else	
	nVlUnPub := oGetDados:aCols[nAscan,GdFieldPos("PZD_VLUNIT")]
EndIf

//Valor unitario repassado ao cliente
If "PZD_UNIREP" == Alltrim(cCampo)
	nVlUnRep := M->PZD_UNIREP
Else
	nVlUnRep := oGetDados:aCols[nAscan,GdFieldPos("PZD_UNIREP")]
EndIf
                 
//Unidade Federativa de referencia para o imposto
If "PZD_UFREF" == Alltrim(cCampo)
	cUF := M->PZD_UFREF 
Else	
	cUF := oGetDados:aCols[nAscan,GdFieldPos("PZD_UFREF")]
EndIf
                 
//Tipo de repasse
If "PZD_TPREP" == Alltrim(cCampo)
	cTpRep := M->PZD_TPREP     
Else
	cTpRep := oGetDados:aCols[nAscan,GdFieldPos("PZD_TPREP")]
EndIf

//Percentual do VPC
If "PZD_PERVPC" == Alltrim(cCampo)
	nPercVPC := M->PZD_PERVPC     
Else
	nPercVPC := oGetDados:aCols[nAscan,GdFieldPos("PZD_PERVPC")]
EndIf

//Percentual do desconto comercial
If "PZD_PDECOM" == Alltrim(cCampo)
	nPercDCom := M->PZD_PDECOM     
Else
	nPercDCom := oGetDados:aCols[nAscan,GdFieldPos("PZD_PDECOM")]
EndIf

//CMG Ant
If "PZD_CMGANT" == Alltrim(cCampo)
	nCMGAnt := M->PZD_CMGANT     
Else
	nCMGAnt := oGetDados:aCols[nAscan,GdFieldPos("PZD_CMGANT")]
EndIf


//Novo CMG 
If "PZD_NOVCMG" == Alltrim(cCampo)
	nCMGNov := M->PZD_NOVCMG     
Else
	nCMGNov := oGetDados:aCols[nAscan,GdFieldPos("PZD_NOVCMG")]
EndIf  


//ICMS 
If "PZD_ALICMS" == Alltrim(cCampo)
	nICMS := M->PZD_ALICMS     
Else
	nICMS := oGetDados:aCols[nAscan,GdFieldPos("PZD_ALICMS")]
EndIf  

//PIS 
If "PZD_ALPIS" == Alltrim(cCampo)
	nPIS := M->PZD_ALPIS     
Else
	nPIS := oGetDados:aCols[nAscan,GdFieldPos("PZD_ALPIS")]
EndIf  

//COFINS 
If "PZD_ALCOFI" == Alltrim(cCampo)
	nCOFINS := M->PZD_ALCOFI     
Else
	nCOFINS := oGetDados:aCols[nAscan,GdFieldPos("PZD_ALCOFI")]
EndIf  
       
//Calculo VPC sobre o valor liquido ou bruto 
If "PZD_VPCTP" == Alltrim(cCampo)
	If Alltrim(M->PZD_VPCTP) == "1"
		lVPCBrt := .T.
	Else	
		lVPCBrt := .F.
	EndIf     
Else
	If Alltrim(oGetDados:aCols[nAscan,GdFieldPos("PZD_VPCTP")]) == "1"
		lVPCBrt := .T.
	Else	
		lVPCBrt := .F.
	EndIf     
EndIf  

//Chama a rotin apara atualizar os itens do documento
AddItCPP3(cCodProd, nQtd, cCodCli, cLoja, nPrcTabAnt, nPrcTabAtu, nSRPAnt, nSRPAtu, nVlUnPub,;
			 cUF, cTpRep, nPercVPC, nPercDCom, nCMGAnt, nCMGNov,nICMS,nPIS, nCOFINS, lGatilho, lVPCBrt)

RestArea(aArea)
Return .T.




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³AddItCPP3	ºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para adicionar os itens do PP			  º±±
±±º          ³ 			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AddItCPP3(cCodProd, nQtd, cCodCli, cLoja, nPrcTabAnt, nPrcTabAtu, nSRPAnt, nSRPAtu, nVlUnPub, cUF,;
						 	cTpRep, nPercVPC, nPercDCom, nCMGAnt, nCMGNov, nICMS, nPIS, nCOFINS, lGatilho, lVpcBrt)

Local aArea 	:= GetArea()
Local nAscan	:= 0
Local aCMGAnt	:= {0,0,0}                      
Local aCMGNov	:= {0,0,0}
Local aNFRef	:= {}
Local nAliqICMS	:= U_MyNewSX6("NC_PP3ICMS",;
									"18",;
									"N",;
									"Aliq.ICMS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.ICMS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.ICMS utilizado no calculo do PP (Estoque NC)",;
									.F. ) 
Local nAliqPIS	:= U_MyNewSX6("'NC_PP3PIS",;
									"1.65",;
									"N",;
									"Aliq.PIS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.PIS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.PIS utilizado no calculo do PP (Estoque NC)",;
									.F. ) 
Local nAliqCof	:= U_MyNewSX6("NC_PP3COF",;
									"7.6",;
									"N",;
									"Aliq.COFINS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.COFINS utilizado no calculo do PP (Estoque NC)",;
									"Aliq.COFINS utilizado no calculo do PP (Estoque NC)",;
									.F. ) 
Local cNFRef	:= ""
Local cSerieRef	:= ""
Local aVarAntDep	:= {} //Dados do varejo antes e depois do repasse do Price Protection
Local aVarAnt		:= {}
Local aVarDep		:= {}
Local cVpcTp		:= ""

//Variveis com os valores do varejo antes do repasse do Price Protection
Local nValBrtAnt	:= 0
Local nValImpAnt	:= 0
Local nValLiqAnt	:= 0
Local nCustoAnt		:= 0
Local nVerbaAnt		:= 0
Local nMargemAnt	:= 0
Local nPercMgAnt	:= 0


//Variveis com os valores do varejo depois do repasse do Price Protection
Local nValBrtDep	:= 0
Local nValImpDep	:= 0
Local nValLiqDep	:= 0
Local nCustoDep		:= 0
Local nVerbaDep		:= 0
Local nMargemDep	:= 0
Local nPercMgDep	:= 0


Default cCodProd	:= "" 
Default nQtd		:= 0 
Default cCodCli		:= "" 
Default cLoja		:= "" 
Default nPrcTabAnt	:= 0 
Default nPrcTabAtu	:= 0 
Default nSRPAnt		:= 0 
Default nSRPAtu		:= 0 
Default nVlUnPub	:= 0 
Default cTpRep		:= "1"
Default nPercVPC	:= 0 
Default nPercDCom	:= 0
Default nCMGAnt     := 0
Default nCMGNov     := 0
Default nICMS		:= 0
Default nPIS		:= 0 
Default nCOFINS		:= 0
Default lGatilho	:= .F.
Default lVpcBrt		:= .T.//VPC calculado sobre o valor bruto

//Preenche os dados do produto
DbSelectArea("SB1")
DbSetOrder(1)
If !SB1->(MsSeek(xFilial("SB1") + cCodProd))
	Aviso("Atenção","Produto não encontrado",{"Ok"},2)
	Return
EndIf

DbSelectArea("SA1")
DbSetOrder(1)
If !SA1->(MsSeek(xFilial("SA1") + cCodCli + cLoja ))
    Aviso("Atenção","Cliente ('"+cCodCli+"/"+cLoja+"') não encontrado",{"Ok"},2)
EndIf

//CMG Anterior a data de proteção do estoque do cliente
If nCMGAnt != 0
	aCMGAnt	:= {,,nCMGAnt}
Else
	aCMGAnt	:= U_GetEstPP(cCodProd, "01", M->PZC_DTAPLI-1)//Retorno: [1]Quantidade [2]Custo Total [3]Custo Unitario
EndIf

//CMG Posterior a data de proteção do estoque do cliente
If nCMGNov == 0
	aCMGNov	:= U_GetEstPP(cCodProd, "01", M->PZC_DTAPLI+1)//Retorno: [1]Quantidade [2]Custo Total [3]Custo Unitario
Else
	aCMGNov	:= 	{,,nCMGNov}
EndIf


//Preenche os dados dos impostos de acordo com a ultima NF emitida para o cliente, estado e produto.
aNFRef := GetAlqImp(cCodCli, cUF, cCodProd)//Doc [1], Serie [2], Aliq.ICMS[3], Aliq.PIS[4], Aliq.Cofins[5]

//Preenche os dados da Aliq.do ICMS
//Obs. Se não preencher a aliquota nessas condições, será considerado o valor do parametro (utilizado na declaração da variavel)
If nICMS != 0//Valor digitado pelo usuário                                                                                                                   
	nAliqICMS := nICMS
ElseIf (Len(aNFRef) > 0) .And. !Empty(aNFRef[1])//Valor da ultima Nota fiscal emitida para o cliente
	cNFRef		:= aNFRef[1]
	cSerieRef	:= aNFRef[2]
	nAliqICMS 	:= aNFRef[3]
EndIf
    
//Preenche os dados da Aliq.do PIS
//Obs. Se não preencher a aliquota nessas condições, será considerado o valor do parametro (utilizado na declaração da variavel)
If nPIS != 0//Valor digitado pelo usuário
	nAliqPIS := nPIS
ElseIf (Len(aNFRef) > 0) .And. !Empty(aNFRef[1])//Valor da ultima Nota fiscal emitida para o cliente
	cNFRef		:= aNFRef[1]
	cSerieRef	:= aNFRef[2]
	nAliqPIS    := aNFRef[4]
EndIf

//Preenche os dados da Aliq. COFINS
//Obs. Se não preencher a aliquota nessas condições, será considerado o valor do parametro (utilizado na declaração da variavel)
If nCOFINS != 0 //Valor digitado pelo usuário
	nAliqCof := nCOFINS

ElseIf (Len(aNFRef) > 0) .And. !Empty(aNFRef[1]) //Valor da ultima Nota fiscal emitida para o cliente
	cNFRef		:= aNFRef[1]
	cSerieRef	:= aNFRef[2]
	nAliqCof    := aNFRef[5]
EndIf       

//Verifica se o vpc será calculo sobre o valor bruto ou liquido
If lVpcBrt 
	cVpcTp := "1"
Else
	cVpcTp := "2"
EndIf


//Recebe os valores do simulador antes e depois do repasse ao cliente
aVarAntDep := GetVRepCli(nQtd, nSRPAnt, nSRPAtu, nPrcTabAnt, nPrcTabAtu, nAliqICMS, nAliqPIS, nAliqCof,nPercVPC, nPercDCom, nVlUnPub, lVpcBrt )
If Len(aVarAntDep) >= 2
	aVarAnt		:= aVarAntDep[1]
	aVarDep		:= aVarAntDep[2]
Else               
	aVarAnt		:= {}           
	aVarDep		:= {}
EndIf

//Preenche as variaveis com os valores anteriores ao repasse
If Len(aVarAnt) >= 7                                        
	nValBrtAnt	:= aVarAnt[1]//Valor Bruto anterior ao repasse
	nValImpAnt	:= aVarAnt[2]//Valor dos impostos anterior ao repasse
	nValLiqAnt	:= aVarAnt[3]//Valor liquido anterior ao repasse
	nCustoAnt	:= aVarAnt[4]//Custo Anterior ao repasse
	nVerbaAnt	:= aVarAnt[5]//Verba anterior ao repasse
	nMargemAnt	:= aVarAnt[6]//Margem anterior ao repasse
	nPercMgAnt	:= aVarAnt[7]//percentual de margem anterio ao repasse
Else
	nValBrtAnt	:= aVarAnt[1]//Valor Bruto anterior ao repasse
	nValImpAnt	:= aVarAnt[2]//Valor dos impostos anterior ao repasse
	nValLiqAnt	:= aVarAnt[3]//Valor liquido anterior ao repasse
	nCustoAnt	:= aVarAnt[4]//Custo Anterior ao repasse
	nVerbaAnt	:= aVarAnt[5]//Verba anterior ao repasse
	nMargemAnt	:= aVarAnt[6]//Margem anterior ao repasse
	nPercMgAnt	:= aVarAnt[7]//percentual de margem anterio ao repasse	
EndIf


//Preenche as variaveis com os valores após o repasse
If Len(aVarDep) >= 8
	nValBrtDep	:= aVarDep[1]//Valor bruto após o repasse
	nValImpDep	:= aVarDep[2]//Valor do imposto  após o repasse
	nValLiqDep	:= aVarDep[3]//Valor liquido após o repasse
	nCustoDep	:= aVarDep[4]//Custo após o repasse
	nVerbaDep	:= aVarDep[5]//Verba após o repasse
	nMargemDep	:= aVarDep[6]//Margem após o repasse
	nPercMgDep	:= aVarDep[7]//Percentual da margem após o repasse
	nVlUnRep  	:= aVarDep[8]//Valor unitário de repasse ao cliente
Else
	nValBrtDep	:= 0//Valor bruto após o repasse
	nValImpDep	:= 0//Valor do imposto  após o repasse
	nValLiqDep	:= 0//Valor liquido após o repasse
	nCustoDep	:= 0//Custo após o repasse
	nVerbaDep	:= 0//Verba após o repasse
	nMargemDep	:= 0//Margem após o repasse
	nPercMgDep	:= 0//Percentual da margem após o repasse
	nVlUnRep  	:= 0//Valor unitário de repasse ao cliente
EndIf


                                 

//Verifica se econtrou o cmg do produto
If (Len(aCMGAnt) >= 3 .And. (aCMGAnt[3] != 0  ) ) .And. (Len(aCMGNov) >= 3 .And. (aCMGNov[3] != 0  ))
	
	//Verifica se a linha do item ja foi preenchida	                        
 	If Empty(oGetDados:aCols[oGetDados:NAT,GdFieldPos("PZD_CODPRO")]) .Or. lGatilho
 		nAscan := oGetDados:NAT	 	
		
 	Else//Adiciona linha nos itens do PP
		Eval(oGetDados:oBrowse:BADD)
		nAscan:=Len(oGetDados:aCols)
	EndIf		                        

	//Preenchimento das campos/colunas dos itens do PP
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CODPRO")]	:= cCodProd //Codigo do produto
	oGetDados:aCols[nAscan,GdFieldPos("PZD_DESC")]		:= SB1->B1_XDESC//Descrição do produto
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CPLATA")]	:= SB1->B1_PLATAF//Cod.Plataforma
	oGetDados:aCols[nAscan,GdFieldPos("PZD_DPLATA")]	:= SB1->B1_PLATEXT//Descrição da plataforma
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CLIENT")]	:= cCodCli//Cod.Cliente
	oGetDados:aCols[nAscan,GdFieldPos("PZD_LOJA")]		:= cLoja//Loja do Cliente
	oGetDados:aCols[nAscan,GdFieldPos("PZD_NOME")]		:= SA1->A1_NREDUZ//Nome do Cliente
	oGetDados:aCols[nAscan,GdFieldPos("PZD_ALICMS")]	:= nAliqICMS//Alq.ICMS
	oGetDados:aCols[nAscan,GdFieldPos("PZD_ALPIS")]		:= nAliqPIS//Aliq.PIS
	oGetDados:aCols[nAscan,GdFieldPos("PZD_ALCOFI")]	:= nAliqCof//Aliq.COFINS
	oGetDados:aCols[nAscan,GdFieldPos("PZD_UFREF")]		:= cUF
	oGetDados:aCols[nAscan,GdFieldPos("PZD_NFORIG")]	:= cNFRef//NF Ref. dos impostos
	oGetDados:aCols[nAscan,GdFieldPos("PZD_SERIE")]		:= cSerieRef//Serie da NF de referencia	
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CMGANT")]	:= aCMGAnt[3]//CMG Anterior
	oGetDados:aCols[nAscan,GdFieldPos("PZD_NOVCMG")]	:= aCMGNov[3]//Novo CMG
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CODTAB")]	:= SA1->A1_TABELA//Cod. tabela de preço
	oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCANT")]	:= nPrcTabAnt// Preço de tabela anterior
	oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCNOV")]	:= nPrcTabAtu// Novo Preço de tabela
	oGetDados:aCols[nAscan,GdFieldPos("PZD_SRPANT")]	:= nSRPAnt// SRP Anterior
	oGetDados:aCols[nAscan,GdFieldPos("PZD_SRPNOV")]	:= nSRPAtu//Novo SRP	
	oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")]		:= nQtd//Quantidade protegida
	oGetDados:aCols[nAscan,GdFieldPos("PZD_MASANT")]	:= (oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCANT")]-( (oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCANT")] * (nAliqICMS+nAliqPIS+nAliqCof) ) /100) - oGetDados:aCols[nAscan,GdFieldPos("PZD_CMGANT")]) * oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")] //Massa Mg anterior
	oGetDados:aCols[nAscan,GdFieldPos("PZD_MASNOV")]	:= (oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCNOV")]-( (oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCNOV")] * (nAliqICMS+nAliqPIS+nAliqCof) ) /100) - oGetDados:aCols[nAscan,GdFieldPos("PZD_NOVCMG")]) * oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")] //Nova Massa Mg
	oGetDados:aCols[nAscan,GdFieldPos("PZD_DIFMAR")]	:= oGetDados:aCols[nAscan,GdFieldPos("PZD_MASANT")] - oGetDados:aCols[nAscan,GdFieldPos("PZD_MASNOV")] //Diferença de Massa 
	oGetDados:aCols[nAscan,GdFieldPos("PZD_MGVENF")]	:= (oGetDados:aCols[nAscan,GdFieldPos("PZD_MASANT")] / (oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCANT")] * oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")]))*100//% Venda feita
	oGetDados:aCols[nAscan,GdFieldPos("PZD_MGNVEN")]	:= (oGetDados:aCols[nAscan,GdFieldPos("PZD_MASNOV")] / (oGetDados:aCols[nAscan,GdFieldPos("PZD_PRCNOV")] * oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")]))*100//% Novo Venda feita
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLUNIT")]	:= nVlUnPub//Valor unitario recebido do Publisher
	oGetDados:aCols[nAscan,GdFieldPos("PZD_TOTPUB")]	:= oGetDados:aCols[nAscan,GdFieldPos("PZD_VLUNIT")] * oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")]//Valor total recebido do Publisher
    oGetDados:aCols[nAscan,GdFieldPos("PZD_CDOLAR")]	:= Iif(M->PZC_TXDOLA != 0, oGetDados:aCols[nAscan,GdFieldPos("PZD_TOTPUB")] / M->PZC_TXDOLA, 0)
	oGetDados:aCols[nAscan,GdFieldPos("PZD_UNIREP")]	:= nVlUnRep//Valor unitario repassado ao cliente
	oGetDados:aCols[nAscan,GdFieldPos("PZD_TOTREP")]	:= oGetDados:aCols[nAscan,GdFieldPos("PZD_UNIREP")] * oGetDados:aCols[nAscan,GdFieldPos("PZD_QUANT")]//Valor total repassado ao cliente
    oGetDados:aCols[nAscan,GdFieldPos("PZD_PERVPC")]	:= nPercVPC// % VPC
	oGetDados:aCols[nAscan,GdFieldPos("PZD_PDECOM")]	:= nPercDCom// % Desconto comercial
	oGetDados:aCols[nAscan,GdFieldPos("PZD_DIFREP")]	:= oGetDados:aCols[nAscan,GdFieldPos("PZD_TOTPUB")] - oGetDados:aCols[nAscan,GdFieldPos("PZD_TOTREP")] //Diferença entre o valor recebido e o valor repassado
	oGetDados:aCols[nAscan,GdFieldPos("PZD_TPREP")]		:= cTpRep//Tipo repasse	 
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLBRTA")]	:= nValBrtAnt//Valor bruto anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_IMPA")]		:= nValImpAnt//Imposto anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLLIQA")]	:= nValLiqAnt//Valor liquido anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CUSTOA")]	:= nCustoAnt//Custo anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VERBAA")]	:= nVerbaAnt//Verba anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLMGA")]		:= nMargemAnt//Margem anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_PERMGA")]	:= nPercMgAnt//Percentual de margem anterior ao repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLBRTD")]	:= nValBrtDep//Valor bruto após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_IMPD")]		:= nValImpDep//Imposto após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLLIQD")]	:= nValLiqDep//Valor liquido após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_CUSTOD")]	:= nCustoDep//Custo após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VERBAD")]	:= nVerbaDep//Verba após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VLMGD")]		:= nMargemDep//Margem após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_PERMGD")]	:= nPercMgDep//Percentual de margem após o repasse
	oGetDados:aCols[nAscan,GdFieldPos("PZD_VPCTP")]		:= cVpcTp//Tipo VPC

Else
	Aviso("Atenção", "Não foi possível calcular o CMG para este produto",{"Ok"},2)	
EndIF

//Atualiza a getdados 
If lGatilho             
	oGetDados:Refresh()
Else
	oGetDados:ForceRefresh()
EndIf

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GetVRepCliºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para calcular o valor real de repasse	  º±±
±±º          ³ ao cliente                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetVRepCli(nQtd, nSRPAnt, nSRPNov, nPrcTabAnt, nPrcTabNov, nICMS, nPIS, nCofins,nPercVPC, nPercDCom, nVlUniRep, lVpcBrt )

Local aArea 		:= GetArea()
Local aRet			:= {}
Local aVarejoAnt	:= {}
Local aVarejoNov	:= {}
Local aVendNCAnt	:= {}
Local aVendNCNov	:= {}

Default nQtd		:= 0 
Default nSRPAnt		:= 0 
Default nSRPNov		:= 0 
Default nPrcTabAnt	:= 0 
Default nPrcTabNov	:= 0 
Default nICMS		:= 0 
Default nPIS		:= 0 
Default nCofins		:= 0
Default nPercVPC	:= 0 
Default nPercDCom	:= 0 
Default nVlUniRep	:= 0 
Default lVpcBrt 	:= .T.


//Valores de vendas efetuadas pela nc games
aVendNCAnt	:= GetVNCAnt(nQtd, nPrcTabAnt, nPercDCom, nICMS, nPIS, nCofins)

//Valores de vendas futuras da nc games
aVendNCNov	:= GetVNCNov(nQtd, nPrcTabNov, nPercDCom, nICMS, nPIS, nCofins)

//Valores do varejo (antes)
aVarejoAnt := GetVrjAnt(nQtd, nSRPAnt, nICMS, nPIS, nCofins, nPercVPC, aVendNCAnt[VLBRUTONC], aVendNCAnt[VLLIQUINC], lVpcBrt)

//Valores do varejo (depois)
aVarejoNov := GetVrjNov(nQtd, nSRPNov, nICMS, nPIS, nCofins, aVendNCNov[VLBRUTONC], aVarejoAnt[VLCUSTANT],;
						 nVlUniRep, aVarejoAnt[MGANTERIOR], aVarejoAnt[VERBAANT])

aRet := {aVarejoAnt,aVarejoNov}


RestArea(aArea)
Return aRet 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GetVrjAntºAutor  ³Elton C.		     º Data ³  04/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para calcular os valores de venda 		  º±±
±±º          ³ realizadas pela NC Games	                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Retorno     ³[1]=Venda bruta                            			  º±±
±±º      		³[2]=Valor dos impostos                                   º±±
±±º      		³[3]=Venda liquida                           	          º±±
±±º      		³[4]=Custo	                        		              º±±
±±º      		³[5]=Verba	                		                      º±±
±±º      		³[6]=Margem			                                      º±±
±±º      		³[7]=Percentual de margem	                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetVrjAnt(nQtd, nSRP, nICMS, nPIS, nCofins, nPercVPC, nVBrtNC, nVLiqNC, lVpcBrt)
Local aArea 	:= GetArea()
Local aRet	    := {}
Local nVBruta 	:= 0//Venda bruta no varejo
Local nVImp		:= 0//Valor dos impostos
Local nVliq		:= 0//Venda liquida no varejo
Local nCust		:= 0//Custo para o varejo
Local nVerba	:= 0//Valor da verba
Local nMg		:= 0//Margem
Local nPercMg	:= 0//Percentual da margem

Default nQtd		:= 0 
Default nSRP		:= 0 
Default nICMS		:= 0 
Default nPIS		:= 0 
Default nCofins		:= 0 
Default nPercVPC	:= 0 
Default nVBrtNC		:= 0
Default nVLiqNC		:= 0                                                  
Default lVpcBrt		:= .T.

nVBruta := nQtd * nSRP
nVImp	:= (nVBruta * (nICMS+nPIS+nCofins))/100  
nVliq	:= nVBruta - nVImp
nCust	:= nVLiqNC

If lVpcBrt
	nVerba	:= (nVBrtNC * nPercVPC)/100
Else 
	nVerba	:= (nVLiqNC * nPercVPC)/100
EndIf

nMg		:= nVliq - nCust + nVerba
nPercMg	:= (nMg / nVBruta)*100

aRet    := {nVBruta,nVImp,nVliq,nCust,nVerba,nMg,Noround(nPercMg,TAMSX3("PZD_MGVENF")[2])}

RestArea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GetVrjNovºAutor  ³Elton C.		     º Data ³  04/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para calcular os valores de venda 		  º±±
±±º          ³ realizadas pela NC Games	                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Retorno     ³[1]=Venda bruta                            			  º±±
±±º      		³[2]=Valor dos impostos                                   º±±
±±º      		³[3]=Venda liquida                           	          º±±
±±º      		³[4]=Custo	                        		              º±±
±±º      		³[5]=Verba	                		                      º±±
±±º      		³[6]=Margem			                                      º±±
±±º      		³[7]=Percentual de margem	                              º±±
±±º      		³[8]=Valor unitario a ser repassado                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetVrjNov(nQtd, nSRP, nICMS, nPIS, nCofins, nVBrtNC, nCustAnt, nVlUniRep, nPercMgAnt, nVerbaAnt)
Local aArea 	:= GetArea()
Local aRet	    := {}
Local nVBruta 	:= 0//Venda bruta no varejo
Local nVImp		:= 0//Valor dos impostos
Local nVliq		:= 0//Venda liquida no varejo
Local nCust		:= 0//Custo para o varejo
Local nVerba	:= 0//Valor da verba
Local nMg		:= 0//Margem
Local nPercMg	:= 0//Percentual da margem
Local nVlAtigMg := 0

Default nQtd		:= 0 
Default nSRP		:= 0 
Default nICMS		:= 0 
Default nPIS		:= 0 
Default nCofins		:= 0 
Default nVBrtNC		:= 0
Default nVlUniRep	:= 0
Default nCustAnt	:= 0
Default nVlUniRep	:= 0 
Default nPercMgAnt	:= 0
Default nVerbaAnt	:= 0

If nSRP != 0 .And. nQtd != 0
	
	nVBruta := nQtd * nSRP
	nVImp	:= (nVBruta * (nICMS+nPIS+nCofins))/100
	nVliq	:= nVBruta - nVImp
	nCust	:= nCustAnt - ( nVlUniRep * nQtd)
	nVerba	:= nVerbaAnt
	nMg		:= nVliq - nCust + nVerba
	nPercMg	:= (nMg / nVBruta)*100
		
	
	//Atingir margem
	If (nPercMgAnt - nPercMg) != 0
		
		nVlAtigMg := (((nMg * nPercMgAnt)/nPercMg) - nMg) / nQtd //Valor unitario a ser complementado no repassado pelo Publisher
		
		nCust	:= nCustAnt + nVlAtigMg - ( (nVlUniRep + nVlAtigMg) * nQtd)
		nMg		:= nVliq - nCust + nVerba
		nPercMg	:= (nMg / nVBruta)*100
		
		if noround((nPercMgAnt - nPercMg),1 ) > 0
			
			While noround((nPercMgAnt - nPercMg),1 ) > 0
				nVlAtigMg 	+= 0.01
				nCust		:= nCustAnt - ( (nVlUniRep + nVlAtigMg) * nQtd)
				nMg			:= nVliq - nCust + nVerba
				nPercMg		:= (nMg / nVBruta)*100
			EndDo
			
		ElseIf noround((nPercMgAnt-nPercMg),1) < 0
			
			While noround((nPercMgAnt - nPercMg),1) < 0
				nVlAtigMg 	-= 0.01
				nCust		:= nCustAnt - ( (nVlUniRep + nVlAtigMg) * nQtd)
				nMg			:= nVliq - nCust + nVerba
				nPercMg		:= (nMg / nVBruta)*100
			EndDo
			
		EndIf
		
	EndIf

	aRet    := 	{nVBruta,nVImp,nVliq,nCust,nVerba,nMg,Noround(nPercMg,TAMSX3("PZD_MGNVEN")[2]), Noround(nVlUniRep + nVlAtigMg, TAMSX3("PZD_UNIREP")[2])}
Else
	aRet    := {0,0,0,0,0,0,0,0}
EndIf


RestArea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GetVNCAntºAutor  ³Elton C.		     º Data ³  04/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para calcular os valores de venda 		  º±±
±±º          ³ realizadas pela NC Games	                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Retorno     ³[1]=Preço com desconto do VPC                            º±±
±±º      		³[2]=Venda Bruta	                                      º±±
±±º      		³[3]=Valor de impostos                                    º±±
±±º      		³[4]=Venda liquida	                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetVNCAnt(nQtd, nPrcTabAnt, nPercDCom, nICMS, nPIS, nCofins)

Local aArea 		:= GetArea()
Local aRet			:= {}
Local nPrcCVPC		:= 0//Preço de venda com o desconto do VPC
Local nVBrtNC		:= 0//Venda bruta
Local nVlImp		:= 0//Valor dos impostos
Local nVLqNC		:= 0//Venda liquida

Default nQtd		:= 0 
Default nPrcTabAnt	:= 0 
Default nPercDCom	:= 0
Default nICMS		:= 0 
Default nPIS		:= 0 
Default nCofins		:= 0

nPrcCVPC 	:= nPrcTabAnt - ( (nPrcTabAnt * nPercDCom) / 100)
nVBrtNC		:= nQtd * nPrcCVPC
nVlImp		:= (nVBrtNC * (nICMS+nPIS+nCofins))/100
nVLqNC		:= nVBrtNC - nVlImp

aRet := {nPrcCVPC, nVBrtNC, nVlImp, nVLqNC}

RestArea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GetVNCNovºAutor  ³Elton C.		     º Data ³  04/11/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para calcular os valores das vendas		  º±±
±±º          ³ futuras, realizadas pela NC Games.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Retorno     ³[1]=Preço com desconto do VPC                            º±±
±±º      		³[2]=Venda Bruta	                                      º±±
±±º      		³[3]=Valor de impostos                                    º±±
±±º      		³[4]=Venda liquida	                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetVNCNov(nQtd, nPrcTabNov, nPercDCom, nICMS, nPIS, nCofins)

Local aArea 		:= GetArea()
Local aRet			:= {}
Local nPrcCVPC		:= 0//Preço de venda com o desconto do VPC
Local nVBrtNC		:= 0//Venda bruta
Local nVlImp		:= 0//Valor dos impostos
Local nVLqNC		:= 0//Venda liquida

Default nQtd		:= 0 
Default nPrcTabNov	:= 0 
Default nPercDCom	:= 0
Default nICMS		:= 0 
Default nPIS		:= 0 
Default nCofins		:= 0

nPrcCVPC 	:= nPrcTabNov - ( (nPrcTabNov * nPercDCom) / 100)
nVBrtNC		:= nQtd * nPrcCVPC
nVlImp		:= (nVBrtNC * (nICMS+nPIS+nCofins))/100
nVLqNC		:= nVBrtNC - nVlImp

aRet := {nPrcCVPC, nVBrtNC, nVlImp, nVLqNC}

RestArea(aArea)
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GetAlqImp	ºAutor  ³Elton C.		     º Data ³  21/10/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna os dados da ultima NF e os impostos 				  º±±
±±º          ³ utilizados no calculo do repasse	                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetAlqImp(cCodCli, cUF, cCodPro)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}

Default cCodCli		:= "" 
Default cUF			:= "" 
Default cCodPro		:= ""

cQuery	:= " SELECT * FROM ( "
cQuery	+= " SELECT F2_EMISSAO, F2_DOC, F2_EST, F2_SERIE, F2_CLIENTE, F2_LOJA, D2_COD, D2_PICM, D2_ALQPIS, D2_ALQCOF  FROM "+RetSqlName("SF2")+ " SF2 "

cQuery	+= " INNER JOIN "+RetSqlName("SD2")+" SD2 "
cQuery	+= " ON SD2.D2_FILIAL = SF2.F2_FILIAL "
cQuery	+= " AND SD2.D2_DOC = SF2.F2_DOC "
cQuery	+= " AND SD2.D2_SERIE = SF2.F2_SERIE "
cQuery	+= " AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "
cQuery	+= " AND SD2.D2_LOJA = SF2.F2_LOJA "
cQuery	+= " AND SD2.D2_COD = '"+cCodPro+"' "
cQuery	+= " AND SD2.D_E_L_E_T_ = ' ' "

cQuery	+= " WHERE SF2.F2_FILIAL = '"+xFilial("SF2")+"' "
cQuery	+= " AND SF2.F2_CLIENTE = '"+cCodCli+"' "
cQuery	+= " AND SF2.F2_EST = '"+cUF+"' "
cQuery	+= " ORDER BY F2_EMISSAO DESC "
cQuery	+= " ) DADOS  "
cQuery	+= " WHERE ROWNUM = 1 "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!eof())
	aRet := {(cArqTmp)->F2_DOC,(cArqTmp)->F2_SERIE,(cArqTmp)->D2_PICM,(cArqTmp)->D2_ALQPIS,(cArqTmp)->D2_ALQCOF}
Else        
	aRet := {"","",0,0,0}//Doc, Serie, Aliq.ICMS, Aliq.PIS, Aliq.Cofins
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet          




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PP3Import	ºAutor  ³Elton C.		     º Data ³  18/10/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para importar os itens do PP			  º±±
±±º          ³ 			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PP3Import()

Local aArea := GetArea()
Local aBotoes	:= {}
Local aSays		:= {}
Local nOpcao	:= 0   
Local aPerg	:= {}

Private  alMsgErro	:= {}

If !(INCLUI .OR. ALTERA)
	Aviso("Atenção","Rotina utilizada apenas na inclusão ou alteração do documento.",{"Ok"},2)
	Return
EndIf


If u_PP3CVldCb()
	
	//Tela de aviso e acesso aos parametros
	AAdd(aSays,"[Importação de Itens do Price Protection]")
	AAdd(aSays,"Este programa auxiliará na importação dos itens.")
	
	
	AAdd(aBotoes,{ 5,.T.,{|| aPerg := PergFile() 		}} )
	AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
	AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )
	FormBatch( "[Importação]", aSays, aBotoes )
	
	//Verifica se o parametro com o endereço do arquivo foi preenchido
	If Len(aPerg) > 0
		
		If aPerg[1]
			If nOpcao == 1
				Processa({|| PP3ImpArq(aPerg[2][1]) })
			EndIf
		Else
			Aviso("Erro na importação","Erro ao ler arquivo...",{"Ok"},2)
		EndIf
	Else
		Aviso("Campo obrigatório","O parâmetro com o nome do arquivo não foi preenchido ! ",{"Ok"},2)
	EndIf
	
EndIf

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PergFile	ºAutor  ³Elton C.		     º Data ³  18/10/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pergunta com o endereço do arquivo						  º±±
±±º          ³ 			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endereço de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endereço de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PP3ImpArq	ºAutor  ³Elton C.		     º Data ³  18/10/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento da rotina de importacao					  º±±
±±º          ³ 			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PP3ImpArq(clArqPro)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local nX			:= 0
Local nlCont		:= 1
Local aErro			:= {}
Local cValQtd		:= ""
Local cPrcAnt		:= ""
Local cPrcNov		:= ""
Local cSRPAnt		:= ""
Local cSRPNov		:= ""
Local cVlUnit		:= ""
Local cNovoCMG		:= ""
Local cVPC			:= ""
Local cDescCom		:= "" 
Local cTpRep		:= ""
Local cCmgAnt		:= ""
Local cICMS			:= ""
Local cPIS			:= ""
Local cCOFINS		:= ""
Local lVpcBrt		:= .T.

Default clArqPro := ""

If !File(clArqPro)
	Aviso("Atenção", "O arquivo informado não foi localizado.",{"Ok"},2)
EndIf     

FT_FUse(clArqPro)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo (Cabeçalho)
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
	If Len(alLinha) >= 19
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha ) 
	Else
		Aviso("Formado inválido","Formato do arquivo inválido, verifique o layout correto",{"Ok"},2)
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 

If Len(aArquivo) > 0
	ProcRegua(Len(aArquivo))
			
	For nX := 1 To Len(aArquivo)
		IncProc("Efetuando a importação...")
		
		//Obs. adicionado +1 na linha, tendo em vista a retirada do cabeçalho. Essa informação será utilizada no relatorio de erro
		If VldImpIt(aArquivo[nX], @aErro, nX+1)
			
			//Preenchimento das variaveis auxiliares
			cValQtd		:= ""
			cValQtd		:= Strtran( aArquivo[nX][5], ".", "" )
			cValQtd		:= Strtran( cValQtd , ",", "." )

			cPrcAnt		:= ""
			cPrcAnt		:= Strtran( aArquivo[nX][6], ".", "" )
			cPrcAnt		:= Strtran( cPrcAnt , ",", "." )

			cPrcNov		:= ""
			cPrcNov		:= Strtran( aArquivo[nX][7], ".", "" )
			cPrcNov		:= Strtran( cPrcNov , ",", "." )

			cSRPAnt		:= ""
			cSRPAnt		:= Strtran( aArquivo[nX][8], ".", "" )
			cSRPAnt		:= Strtran( cSRPAnt , ",", "." )

			cSRPNov		:= ""
			cSRPNov		:= Strtran( aArquivo[nX][9], ".", "" )
			cSRPNov		:= Strtran( cSRPNov , ",", "." )

			cVlUnit		:= ""
			cVlUnit		:= Strtran( aArquivo[nX][10], ".", "" )
			cVlUnit		:= Strtran( cVlUnit , ",", "." )

			cCmgAnt	:= ""
			cCmgAnt	:= Strtran( aArquivo[nX][11], ".", "" )
			cCmgAnt	:= Strtran( cCmgAnt , ",", "." ) 

			cNovoCMG	:= ""
			cNovoCMG	:= Strtran( aArquivo[nX][12], ".", "" )
			cNovoCMG	:= Strtran( cNovoCMG , ",", "." )

			If Alltrim(upper(aArquivo[nX][13])) == "BRUTO" .Or. Empty(aArquivo[nX][13])
				lVpcBrt := .T.
			ElseIf Alltrim(upper(aArquivo[nX][13])) == "LIQUIDO"
				lVpcBrt := .F.
			Else             
				lVpcBrt := .T.
			EndIf
			
			cVPC		:= ""
			cVPC		:= Strtran( aArquivo[nX][14], ".", "" )
			cVPC		:= Strtran( cVPC , ",", "." )

			cDescCom	:= ""
			cDescCom	:= Strtran( aArquivo[nX][15], ".", "" )
			cDescCom	:= Strtran( cDescCom , ",", "." ) 


			If Alltrim(upper(aArquivo[nX][16])) == "CREDITO" .Or. Empty(aArquivo[nX][16])
				cTpRep := "1"
			ElseIf Alltrim(upper(aArquivo[nX][16])) == "PRODUTO"
				cTpRep := "2"
			Else             
				cTpRep := "1"
			EndIf

			cICMS	:= ""
			cICMS	:= Strtran( aArquivo[nX][17], ".", "" )
			cICMS	:= Strtran( cICMS , ",", "." ) 

			cPIS	:= ""
			cPIS	:= Strtran( aArquivo[nX][18], ".", "" )
			cPIS	:= Strtran( cPIS , ",", "." ) 
			
			cCOFINS	:= ""
			cCOFINS	:= Strtran( aArquivo[nX][19], ".", "" )
			cCOFINS	:= Strtran( cCOFINS , ",", "." ) 
		    
			AddItCPP3(aArquivo[nX][1]	,;//Codigo do produto
			 			Val(cValQtd)	,;//Quantidade
			 			aArquivo[nX][2]	,; //Codigo do cliente
			 			aArquivo[nX][3]	,; //Loja
			 			Val(cPrcAnt)	,; //Preço da tabela anterior
			 			Val(cPrcNov)	,; //Novo Preço da tabela
			 			Val(cSRPAnt)	,; //SRP Anterior
			 			Val(cSRPNov)	,; //Novo SRP
			 			Val(cVlUnit)	,;// Valor unitario de repasse
			 			aArquivo[nX][4]	,; //Unidade Federativa
			 			cTpRep			,;//Tipo de repasse (Credito ou Produto)
			 			Val(cVPC)		,;//% VPC
			 			Val(cDescCom)	,;//% Desconto comercial
			 			Val(cCmgAnt)	,;//CMG Ant
			 			Val(cNovoCMG)	,;//Novo CMG
			 			Val(cICMS)		,;//Aliq.ICMS
			 			Val(cPIS)		,;//Aliq.PIS
			 			Val(cCOFINS)	,;//Aliq.COFINS
			 			.F.,;//Gatilho
			 			lVpcBrt)//Calcula o VPC pelo valor bruto
		EndIf
	Next
	
	If Len(aErro) > 0
		If Aviso("Atenção", "Alguns itens não foram importados, deseja visualizar o log de erro ? ", {"Sim","Não"}, 2) == 1

			//Chama a rotina para imprimir o log de importação
			CtRConOut(aErro)
		EndIf
	
	EndIf	

EndIf

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³VldImpIt	ºAutor  ³Elton C.		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Validação dos itens a serem importados					  º±±
±±º          ³ 			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldImpIt(aArqImp, aErro, nLin)

Local aArea 	:= GetArea()
Local cMsgAux   := ""
Local lRet		:= .T.
Local cValAux	:= ""

Default aArqImp	:= {} 
Default aErro 	:= {}
Default nLin	:= 0

//Validação do produto [1] 
If !Empty(aArqImp[1])
	DbSelectArea("SB1")
	DbSetOrder(1)
	If !SB1->(MsSeek(xFilial("SB1") + aArqImp[1]))
		lRet := .F.
		cMsgAux   += "-Cod.do produto ("+aArqImp[1]+") não encontrado;"+CRLF
	EndIf
Else
	lRet := .F.
	cMsgAux   += "-Cod.do produto não preenchido;"+CRLF
EndIf
                  
//Validação do Cliente [2] e [3]
If !Empty(aArqImp[2]) .And. !Empty(aArqImp[3])
	DbSelectArea("SA1")
	DbSetOrder(1)
	If !SA1->(MsSeek(xFilial("SA1") + aArqImp[2] +  aArqImp[3]))
		lRet := .F.
		cMsgAux   += "-Cliente ("+aArqImp[2]+"/"+aArqImp[3]+") não encontrado;"+CRLF
	EndIf
Else
	lRet := .F.
	cMsgAux   += "-Código ou loja do cliente não preenchido;"+CRLF
EndIf


//Validação da UF [4]
If !Empty(aArqImp[4])
	
	DbSelectArea("SX5")
	DbSetOrder(1)
	If !SX5->(MsSeek(xFilial("SX5") + "12" + aArqImp[4] ))
		lRet := .F.
		cMsgAux   += "-UF ("+aArqImp[4]+") não encontrada;"+CRLF
	EndIf
Else	
	lRet := .F.
	cMsgAux   += "-UF não preenchida;"+CRLF
EndIf

//Validação da quantidade [5]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[5], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) <= 0
	lRet := .F.
	cMsgAux   += "-Quantidade não preenchida ou menor que zero;"+CRLF
EndIf  


//Validação do Prç.Ant.Tabela [6]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[6], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Preço anterior da tabela não preenchido ou menor que zero;"+CRLF
EndIf                                                           

//Validação do Novo Prç.da tabela[7]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[7], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) == 0
	lRet := .F.
	cMsgAux   += "-Novo preço da tabela não preenchido ou menor que zero;"+CRLF
EndIf                                                           
 

//Validação do SRP Anterior [8]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[8], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) <= 0
	lRet := .F.
	cMsgAux   += "-SRP anterior não preenchido ou menor que zero;"+CRLF
EndIf   


//Validação do Novo SRP [9]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[9], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) <= 0
	lRet := .F.
	cMsgAux   += "-Novo SRP não preenchido ou menor que zero;"+CRLF
EndIf   


//Validação do Valor unitário de repasse do Publisher [10]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[10], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) <= 0
	lRet := .F.
	cMsgAux   += "-Valor unitário não preenchido ou menor que zero;"+CRLF
EndIf   

//Validação do novo CMG Ant[11]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[11], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) < 0
	lRet := .F.
	cMsgAux   += "-CMG Anterior menor que zero;"+CRLF
EndIf   


//Validação do novo CMG [12]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[12], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) < 0
	lRet := .F.
	cMsgAux   += "-Novo CMG menor que zero;"+CRLF
EndIf   

//Validação do tipo de repasse [13]
If !Empty(aArqImp[13]) .And. !(Alltrim(UPPER(aArqImp[13])) $ "BRUTO|LIQUIDO" )
	lRet := .F.
	cMsgAux   += "-O campo 'VPC  Vlr. Bruto ou Liq.', deve ser preenchido com 'BRUTO' ou 'LIQUIDO'.;"+CRLF
EndIf  

//Validação do tipo de repasse [16]
If !Empty(aArqImp[16]) .And. !(Alltrim(UPPER(aArqImp[16])) $ "CREDITO|PRODUTO" )
	lRet := .F.
	cMsgAux   += "-Tipo de repasse diferente do esperado (CREDITO OU PRODUTO);"+CRLF
EndIf  

//Validação do ICMS [17]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[17], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) < 0
	lRet := .F.
	cMsgAux   += "-ICMS menor que zero;"+CRLF
EndIf   


//Validação do PIS [18]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[18], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) < 0
	lRet := .F.
	cMsgAux   += "-PIS menor que zero;"+CRLF
EndIf   

//Validação do COFINS [19]
cValAux	:= ""
cValAux	:= Strtran( aArqImp[19], ".", "" )
cValAux	:= Strtran( cValAux , ",", "." )
If val(cValAux) < 0
	lRet := .F.
	cMsgAux   += "-COFINS menor que zero;"+CRLF
EndIf   


//Preenche o log de erro
If !lRet
	Aadd(aErro,Replicate("-", 100)+CRLF)
	Aadd(aErro,"Erro na linha: "+Alltrim(Str(nLin))+CRLF )
	Aadd(aErro,cMsgAux)			
EndIf 

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCViewWF  ºAutor  ³Microsiga           º Data ³  10/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCViewWF()

Local aAreaAtu	:=GetArea()
Local oDlg
Local cPath		:="\PPVIEWWF\"
Local cHtml		:="analiseWFPPcli.htm"
Local oHtml
Local cNomeArq 	:= CriaTrab(,.f.) + ".htm"
Local cCodPP 	:= PZC->PZC_CODPP 
Local cPathTemp  := GETTEMPPATH()

oHtml	:=	TWFHTML():New(Alltrim(cPath) + Alltrim(cHtml))

//Monta a tela com a simulação do WF de aprovação
PP303SWF(oHtml,cCodPP)


cNomeArq := Alltrim(cPath) + cNomeArq
cNomeArq := StrTran(cNomeArq,'\\','\')
oHtml:SaveFile( Alltrim(cNomeArq) )	// Grava o HTML temporario

cNomeHtml:="PP_2_"+cCodPP+StrTran(Time(),":","")+Dtos(Date())+ ".htm"
If __CopyFile(cNomeArq,cPathTemp+cNomeHtml)
	
	Define MsDialog oDlg Title "Analise: "+cCodPP FROM oMainWnd:nTop,oMainWnd:nLeft TO oMainWnd:nBottom,oMainWnd:nRight*0.98 Of oMainWnd PIXEL
	nWidth:= oDlg:nWidth/2
	nHeight:=(oDlg:nHeight/2)-10
	
	
	oTIBrowser:= TIBrowser():New(0,0,nWidth,nHeight,cPathTemp+cNomeHtml,oDlg )
	
	tButton():New(10,10	,  "Fechar"  	,oDlg,{|| oDlg:End()	},32,12,,,,.T.)
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
Else
	Aviso("Erro arquivo temporário","Erro ao tentar gravar o arquivo temporário. Entre em contato com o administrador. ",{"Ok"},2)
EndIf

Ferase(cNomeArq)
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PP303SWF  ºAutor  ³Microsiga           º Data ³  02/11/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PP303SWF(oHtml,cCodPP)
Local aArea 	:= GetArea()
Local cArqTmp 	:= ""
Local cTitulo	:= ""
Local cTableCli	:= ""

Default oHtml := Nil

cArqTmp	:= GetDPP(cCodPP)//Recebe os dados do price protection


If (cArqTmp)->(!Eof()) .And. (oHtml != Nil)
	
	cTitulo			:= "Aprovação do Price Protection </br> (Estoque de clientes)"
	
	//Preenchimento dos dados do cabeçalho WF
	oHtml:ValByName( "cTiTuloHtml"	, cTitulo)
	oHtml:ValByName( "cCodPP"		, (cArqTmp)->PZC_CODPP )
	oHtml:ValByName( "cPublisher"	, (cArqTmp)->PZC_PUBLIS )
	oHtml:ValByName( "cCampanha"	, (cArqTmp)->PZC_PPPUB )
	oHtml:ValByName( "cVlTotRec"    , Transform((cArqTmp)->PZC_CREDRE,"@E 999,999,999.99" )  )
	oHtml:ValByName( "cVlTotRep"    , Transform((cArqTmp)->PZC_TOTREP,"@E 999,999,999.99" )  )
	oHtml:ValByName( "cDtProtec"  	, DTOC(STOD((cArqTmp)->PZC_DTAPLI))   )
	oHtml:ValByName( "cDtAprovP"   	, DTOC(STOD((cArqTmp)->PZC_DTACEI))  )
	oHtml:ValByName( "cCodAprov"   	, "" )
	oHtml:ValByName( "cNomAprov"   	, "" )
	
	
	//preenchimento dos itens
	While (cArqTmp)->(!Eof())
		
		AAdd( oHtml:ValByName("it.cDescNC") 	,Alltrim((cArqTmp)->PZD_CODPRO) +"-"+ (cArqTmp)->PZD_DESC   )
		AAdd( oHtml:ValByName("it.cCMGAnt") 	,Transform((cArqTmp)->PZD_CMGANT,"@E 999,999,999.9999" )	)
		AAdd( oHtml:ValByName("it.cCMGNov") 	,Transform((cArqTmp)->PZD_NOVCMG,"@E 999,999,999.9999" )	)
		AAdd( oHtml:ValByName("it.cVNFAnt") 	,Transform((cArqTmp)->PZD_PRCANT,"@E 999,999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cVNFNov") 	,Transform((cArqTmp)->PZD_PRCNOV,"@E 999,999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cSRPAnt") 	,Transform((cArqTmp)->PZD_SRPANT,"@E 999,999,999.99" ) 		)
		AAdd( oHtml:ValByName("it.cSRPNov") 	,Transform((cArqTmp)->PZD_SRPNOV,"@E 999,999,999.99" ) 		)
		AAdd( oHtml:ValByName("it.cMasMgAnt") 	,Transform((cArqTmp)->PZD_MASANT,"@E 999,999,999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cMasMgNov") 	,Transform((cArqTmp)->PZD_MASNOV,"@E 999,999,999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cPerdMass") 	,Transform((cArqTmp)->PZD_DIFMAR,"@E 999,999,999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cPercMgAnt")	,Transform((cArqTmp)->PZD_MGVENF,"@E 999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cPercMgNov") 	,Transform((cArqTmp)->PZD_MGNVEN,"@E 999,999.99" ) 	)
		AAdd( oHtml:ValByName("it.cQtdTotVrj") 	,Transform((cArqTmp)->PZD_QUANT ,"@E 999,999,999,999" ) 		)
		AAdd( oHtml:ValByName("it.cVlTotRece") 	,Transform((cArqTmp)->PZD_TOTPUB,"@E 999,999,999,999.99" ) 		)
		AAdd( oHtml:ValByName("it.cVlTotRCli") 	,Transform((cArqTmp)->PZD_TOTREP,"@E 999,999,999,999.99" ) 		)
		AAdd( oHtml:ValByName("it.cDif") 		,Transform((cArqTmp)->PZD_DIFREP,"@E 999,999,999,999.99" ) 		)
		
		(cArqTmp)->(DbSkip())
	EndDo
	
	//Preenchimento da tabela resumida dos clientes
	cTableCli := U_NGetTClWF(cCodPP)
	oHtml:ValByName( "cTableCli"   	, cTableCli  )
	
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NGetTClWFºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria a tabela com os itens do Workflow			 		  º±±
±±º          ³												  			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NGetTClWF(cCodPP)

Local aArea 	:= GetArea()
Local cRet	    := ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	
Local aCliente	:= GetCliPP(cCodPP)
Local nX		:= 0
Local nQtd		:= 0
Local nTotRepC	:= 0
Local  nCnt		:= 0

Default cCodPP  := ""

cQuery    := " SELECT DISTINCT PZD_CODPRO, PZD_DESC FROM "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " WHERE PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery    += " AND PZD.PZD_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZD.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZD_DESC "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)


(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

cRet += ' <br/><br/> '	                            
cRet += ' <br/><br/> '	
cRet += ' <br/><br/> '	                            
For nX := 1 To nCnt
	cRet += ' <br/><br/> '	
Next

cRet += '<div class="table-over" style="overflow: scroll; max-width:98%; margin:0 auto; min-height: 150px;margin-left: 10px;" > '+CRLF
cRet += ' 	<table border="0" align="left" cellpadding="4" cellspacing="1" style="margin-left: 0px;"> '+CRLF
cRet += '		<tr>'+CRLF
cRet += '			<th bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold; color:#FFF;"  nowrap>Cliente: </th>'+CRLF

//Preenche o cabeçalho com o nome do cliente
For nX := 1 To Len(aCliente)
	cRet += '			<th width="80px" bgcolor="#666666" style="font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold; color:#FFF;"  >'+aCliente[nX][3]+'</th> '+CRLF
Next

cRet += '		</tr>'
While (cArqTmp)->(!Eof())
	
	cRet += ' 		<tr> '+CRLF
	cRet += '			<th bgcolor="#efefef" style="text-align: right; font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold;"></th> '+CRLF
	
	For nX := 1 To Len(aCliente)
		nQtd := 0
		nQtd := GetQtdPrdC(cCodPP, (cArqTmp)->PZD_CODPRO, aCliente[nX][1], aCliente[nX][2])
		cRet += '			<th  nowrap  bgcolor="#efefef" style="text-align: right; font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold;">'+Transform(nQtd,"@E 999,999,999" )+'</th>'+CRLF
	Next
	
	cRet += '		</tr> '+CRLF
				
	(cArqTmp)->(DbSkip())
EndDo

cRet += ' 		<tr> '
cRet += ' 			<th nowrap bgcolor="#efefef" style="font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold;">Total R$: </th> '+CRLF

//Imprime o valor total de repasse ao cliente
For nX := 1 To Len(aCliente)
	nTotRepC 	:= 0
	nTotRepC	:= GetTRCli(cCodPP, aCliente[nX][1], aCliente[nX][2])
	cRet += ' 			<th bgcolor="#efefef" style="text-align: right; font-family:Arial, Helvetica, sans-serif; font-size:9px; font-weight:bold;">'+Transform(nTotRepC,"@E 999,999,999,999.99" )+'</th>'+CRLF
Next

cRet += ' 		</tr> '+CRLF
cRet += '	</table> '+CRLF
cRet += '</div>'+CRLF


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetCliPP  ºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna os clientes utilizados no PP					 	  º±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCliPP(cCodPP)

Local aArea 	:= GetArea()
Local aRet		:= {}
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP := ""

cQuery    := " SELECT DISTINCT PZD_CLIENT, PZD_LOJA, PZD_NOME FROM "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " WHERE PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery    += " AND PZD.PZD_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZD.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZD_NOME "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

While (cArqTmp)->(!Eof())

	Aadd(aRet, {(cArqTmp)->PZD_CLIENT, (cArqTmp)->PZD_LOJA, (cArqTmp)->PZD_NOME})

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetQtdPrdCºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a quantidade do produto do estoque do cliente	 	  º±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetQtdPrdC(cCodPP, cCodPro, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local nRet		:= 0
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP	:= "" 
Default cCodPro	:= "" 
Default cCodCli := "" 
Default cLoja	:= ""

cQuery    := " SELECT SUM(PZD_QUANT) PZD_QUANT FROM "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " WHERE PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery    += " AND PZD.PZD_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZD.PZD_CODPRO = '"+cCodPro+"' "+CRLF
cQuery    += " AND PZD.PZD_CLIENT = '"+cCodCli+"' "+CRLF
cQuery    += " AND PZD.PZD_LOJA = '"+cLoja+"' "
cQuery    += " AND PZD.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())
	nRet := (cArqTmp)->PZD_QUANT
Else
	nRet := 0
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return nRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetTRCliºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o valor total de repasse ao cliente			 	  º±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetTRCli(cCodPP, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local nRet		:= 0
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP	:= "" 
Default cCodCli := ""                 
Default cLoja	:= ""

cQuery    := " SELECT SUM(PZD_TOTREP) PZD_TOTREP FROM "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " WHERE PZD.PZD_FILIAL = '"+xFilial("PZD")+"' "+CRLF
cQuery    += " AND PZD.PZD_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZD.PZD_CLIENT = '"+cCodCli+"' "+CRLF
cQuery    += " AND PZD.PZD_LOJA = '"+cLoja+"' "+CRLF
cQuery    += " AND PZD.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())
	nRet := (cArqTmp)->PZD_TOTREP
Else
	nRet := 0
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return nRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetDPP	ºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o arquivo temporario com os dados do price 		  º±±
±±º          ³protection												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetDPP(cCodPP)

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP := ""


cQuery    := " SELECT PZC_CODPP, PZC_PUBLIS, PZC_PPPUB, PZC_CREDRE, PZC_TOTREP, PZC_DTAPLI, PZC_DTACEI, PZD_DESC, PZD_CMGANT, "+CRLF
cQuery    += "        PZD_NOVCMG, PZD_PRCANT, PZD_PRCNOV, PZD_SRPANT, PZD_SRPNOV, SUM(PZD_MASANT) PZD_MASANT, SUM(PZD_MASNOV) PZD_MASNOV, "+CRLF
cQuery    += "        SUM(PZD_DIFMAR) PZD_DIFMAR, ROUND(((SUM(PZD_MASANT) / (PZD_PRCANT * SUM(PZD_QUANT)) )*100),2) PZD_MGVENF, "+CRLF
cQuery    += "        ROUND(((SUM(PZD_MASNOV) / (PZD_PRCNOV * SUM(PZD_QUANT)) )*100),2) PZD_MGNVEN, SUM(PZD_QUANT) PZD_QUANT, "+CRLF
cQuery    += "        SUM(PZD_TOTPUB) PZD_TOTPUB, SUM(PZD_TOTREP) PZD_TOTREP, SUM(PZD_DIFREP) PZD_DIFREP, PZD_CODPRO FROM "+RetSqlName("PZC")+" PZC "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " ON PZD.PZD_FILIAL = PZC.PZC_FILIAL "+CRLF
cQuery    += " AND PZD.PZD_CODPP = PZC.PZC_CODPP "+CRLF
cQuery    += " AND PZD.D_E_L_E_T_ = ' '  "+CRLF

cQuery    += " WHERE PZC.PZC_FILIAL = '"+xFilial("PZC")+"' "+CRLF
cQuery    += " AND PZC.PZC_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZC.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " GROUP BY PZC_CODPP, PZC_PUBLIS, PZC_PPPUB, PZC_CREDRE, PZC_TOTREP, PZC_DTAPLI, PZC_DTACEI, PZD_DESC, PZD_CMGANT, "+CRLF
cQuery    += "          PZD_NOVCMG, PZD_PRCANT, PZD_PRCNOV, PZD_SRPANT, PZD_SRPNOV, PZD_CODPRO "+CRLF
cQuery    += " ORDER BY PZD_DESC "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

(cArqTmp)->(DbGoTop())

RestArea(aArea)
Return cArqTmp


