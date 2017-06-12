#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCIMPAM	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImporta็ใo e/ou manuentencao das despesas referentes ao 	  บฑฑ
ฑฑบ          ณAM					                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIMPAM()
Local aArea := GetArea()

Local cAliasMB		:= "PX1"

Private cCadastro	:= "Rotina de manuten็ใo Assis.M้dica"
Private aRotina		:= Menudef()

DbSelectArea("PX1")
DbSetOrder(1)
mBrowse( 6, 1,22,75,cAliasMB,,,,,,/*aCores*/,,,, ,,,,)

RestArea(aArea)
Return                          

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMntTVTRA	  บAutor  ณDBM                 บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a tela para a manuten็ใo do VT, VR e VA                 บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ManutAM(cAlias, nRecno, nOpc)

Local aArea 	:= GetArea()
Local cTitulo   := ""
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK  := ""//"U_PR102CpoOK"
Local lVirtual := .T.
Local nLinhas  := 99999
Local nFreeze  := 0
Local aCampos	:= {"PX2_SEQ","PX2_NOTA","PX2_SERIE","PX2_MATRIC","PX2_CPF","PX2_NOME",;
						"PX2_IDADE","PX2_VALOR","PX2_VLDESC","PX2_VLCALC"}
Local aCpoAlter := {"PX2_NOTA","PX2_SERIE","PX2_MATRIC","PX2_IDADE","PX2_VALOR","PX2_VLDESC","PX2_VLCALC"}				  

Private aHeader		 := {}
Private aCols		 := {}                        
Private aCpoEnchoice := {"PX1_CODIMP","PX1_DTIMP"}
Private aAltEnchoice := {"PX1_DTIMP"}
Private aAlt         := {} 
Private oGetDados                        
Private cAlias1	 	 := "PX1"
Private cAlias2		 := "PX2"




// Cria variaveis de memoria dos campos da tabela Pai.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

aHeader	:= CriaHeader(aCampos)
aCols	:= CriaAcols(nOpc)

If nOpc == 3//Inclusใo

	cTitulo	:= "Manuten็ใo Assis. M้dica - Inclusใo"
ElseIf nOpc == 4//Altera็ใo

	cTitulo	:= "Manuten็ใo Assis. M้dica - Altera็ใo"
ElseIf nOpc == 5 //Exclusใo

	cTitulo	:= "Manuten็ใo Assis. M้dica - Exclusใo"	
EndIf

lRet := U_TelaAM(cTitulo,cAlias1,cAlias2,aCpoEnchoice,/*cLinOk*/,/*cTudoOk*/,nOpcE,nOpcG,/*cFieldOk*/,lVirtual,nLinhas,aAltEnchoice,nFreeze,{},,aCpoAlter)


If lRet 
	If nOpc == 3
		If Aviso("Confirma", "Confirma a grava็ใo dos dados ?", {"Sim","Nใo"}) == 1
			aCols := oGetDados:Acols
			Processa({|| GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
		EndIf
    ElseIf nOpc == 4
		If Aviso("Confirma", "Confirma a altera็ใo dos dados ?", {"Sim","Nใo"}) == 1
			aCols := oGetDados:Acols
			Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")
		EndIf
	ElseIf nOpc == 5

		If Aviso("Confirma", "Confirma a exclusใo dos dados ?", {"Sim","Nใo"}) == 1
			aCols := oGetDados:Acols
			Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
		EndIf
	EndIf    

EndIf

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GrvDados บAutor  ณDBM                 บ Data ณ  11/23/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGravacao dos dados                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvDados()

Local aArea	 := GetArea()
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
	ElseIf "DTDIGT" $ FieldName(i)
		FieldPut(i, dDataBase)	
	Else
		FieldPut(i, M->&(Eval(bCampo,i)))
	EndIf
Next
(cAlias1)->(MSUnlock())


// Grava os registros da tabela Filho.
dbSelectArea("PX2")

For i := 1 To Len(aCols)
	
	IncProc()
	
	If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.
		
		RecLock("PX2", .T.)
		
		PX2->PX2_FILIAL := xFilial("PX2")
		PX2->PX2_CODIMP := M->PX1_CODIMP
		PX2->PX2_DTIMP	:= M->PX1_DTIMP
		PX2->PX2_DTDIGI	:= dDataBase

		For y := 1 To Len(aHeader)
			FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
		Next
		
		PX2->(MSUnlock())
		
	EndIf
	
Next

RestArea(aArea)
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAltDados  บAutor  ณDBM                 บ Data ณ  11/23/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAlteracao dos dados e efetivacao                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AltDados()

Local aArea	 := GetArea()
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
			
			//Exclui os dependetes
			ExcDepend(PX2->PX2_CODIMP, PX2->PX2_MATRIC)
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
			(cAlias2)->PX2_FILIAL := xFilial(cAlias2)
			(cAlias2)->PX2_CODIMP := (cAlias1)->PX1_CODIMP
			(cAlias2)->PX2_DTIMP  := (cAlias1)->PX1_DTIMP
			MSUnlock()
			nItem++
		EndIf
		
	EndIf
	
Next  

RestArea(aArea)
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcDados  บAutor  ณDBM                 บ Data ณ  11/23/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclusao                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcDados()

Local aArea		:= GetArea()

ProcRegua(Len(aCols)+1)   // +1 ้ por causa da exclusao do arq. de cabe็alho.

dbSelectArea(cAlias2)
dbSetOrder(1)
dbSeek(xFilial(cAlias2) + (cAlias1)->PX1_CODIMP)

While !EOF() .And. ((cAlias2)->PX2_FILIAL == xFilial(cAlias2)) .And. (Alltrim((cAlias2)->PX2_CODIMP) == Alltrim((cAlias1)->PX1_CODIMP))
	IncProc()
	RecLock(cAlias2, .F.)
	dbDelete()
	MSUnlock()

	//Exclui os dependetes
	ExcDepend( Alltrim((cAlias2)->PX2_CODIMP), Alltrim((cAlias2)->PX2_MATRIC) )

	dbSkip()
End

dbSelectArea(cAlias1)
dbSetOrder(1)
//IndProc()
RecLock(cAlias1, .F.)
dbDelete()
MSUnlock()

RestArea(aArea)
Return Nil



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeaderบAutor  ณElton C.            บ Data ณ  15/.12.11  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o aHeader						                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaHeader(aCampos)
Local aArea		:= GetArea()
Local alHeader 	:= {}
Local nIx		:= 0

DbSelectArea( "SX3" )
DbSetOrder(2)

For nIx := 1 To Len( aCampos )
	If SX3->( MsSeek( aCampos[ nIx ] ) )
		aAdd( alHeader, {AlLTrim( X3Titulo() )	, ;	// 01 - Titulo
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

Return alHeader 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaCols  บAutor  ณDBM                 บ Data ณ  11/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria vetor aCols da GETDADOS                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcols(nOpc)
Local nQtdCpo := 0
Local i       := 0
Local nCols   := 0

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.
	
	AAdd(aCols, Array(Len(aHeader)+1))
	
	For i := 1 To nQtdCpo
		If Alltrim(aHeader[i][2]) == "PX2_SEQ"
			aCols[1][i] := CriaVar(aHeader[i][2])
			aCols[1][i] := "0001"
		Else
			aCols[1][i] := CriaVar(aHeader[i][2])		
		EndIf
	Next
	
	aCols[1][nQtdCpo+1] := .F.
	
Else                           
	
	M->PX1_CODIMP 	:= PX1->PX1_CODIMP
	M->PX1_DTIMP	:= PX1->PX1_DTIMP
	dbSelectArea("PX2")
	dbSetOrder(1)
	dbSeek(xFilial("PX2") + PX1->PX1_CODIMP)
	
	While PX2->(!EOF()) .And. (PX2->PX2_FILIAL == xFilial("PX2")) .And. (Alltrim(PX2->PX2_CODIMP) == Alltrim(PX1->PX1_CODIMP))
		
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

		PX2->(dbSkip())
	EndDo                    


EndIf

//Ordena o acols de acordo com a sequencia
//aCols := aSort( aCols,,,{|x,y| x[1] < y[1]} )

Return aCols




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMntTela	  บAutor  ณDBM                 บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a tela 					                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TelaAM(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aCordW,nSizeHeader, aCpoAlter)

Local aArea 		:= GetArea()
Local lRet, nOpca 	:= 0,cSaveMenuh,nReg:=(cAlias1)->(Recno()),oDlg
Local nDlgHeight   
Local nDlgWidth
Local nDiffWidth 	:= 0 
Local lMDI 			:= .F.
Local aSize			:= MsAdvSize(.F.,.F.,0)
Local aInfo			:= {}
Local aObjects		:= {}
Local nOpcAux		:= 0
Local aButtons 		:= {}  
Local oBtnDp		:= Nil

Private Altera:=.t.,Inclui:=.t.,lRefresh:=.t.,aTELA:=Array(0,0),aGets:=Array(0),;
bCampo:={|nCPO|Field(nCPO)},nPosAnt:=9999,nColAnt:=9999
Private cSavScrVT,cSavScrVP,cSavScrHT,cSavScrHP,CurLen,nPosAtu:=0
Private oEnchoice
Private nOpcDP := 0

If nOpcE == 3 .Or. nOpcE == 4
	nOpcAux := GD_INSERT + GD_UPDATE + GD_DELETE
Else 
	nOpcAux := 0
EndIf

nOpcE := If(nOpcE==Nil,3,nOpcE)
nOpcG := If(nOpcG==Nil,3,nOpcG)
lVirtual := Iif(lVirtual==Nil,.F.,lVirtual)
nLinhas:=Iif(nLinhas==Nil,99,nLinhas)

//Varival utilizada na rotina de manuten็ใo do dependente
nOpcDP := nOpcE

aObjects	:= {{ 100, 157 , .T., .T. }}
aInfo		:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 0, 0 }
aPosObj		:= MsObjSize( aInfo, aObjects )


aSize[6] := aSize[6]+30

lMdi := .T.
nDiffWidth := 0

Default nSizeHeader := 110

//Cria Botao paramanuten็ใo do dependente
Aadd(aButtons, {oBtnDp,"U_MnDmAM()","Dependente","Dependente"})

DEFINE MSDIALOG oDlg TITLE cTitulo From /*aSize[7]*/10, 0 to aSize[6],aSize[5] Pixel of oMainWnd
If lMdi
	oDlg:lMaximized := .T.
EndIf

oEnchoice := Msmget():New(cAlias1,nReg,nOpcE,,,,aMyEncho,{13,1,((nSizeHeader/2)-50),If(lMdi, (aSize[5]/2)-2,__DlgWidth(oDlg)-nDiffWidth)},aAltEnchoice,1,,,,oDlg,,lVirtual,,,,,,,,.T.)       

oGetDados := MsNewGetDados():New((nSizeHeader/2)-15,001,(aSize[6]/2)-30,(aSize[5]/2)-2,nOpcAux ,cLinOk,cTudoOk,"+PX2_SEQ",aCpoAlter,,9999,"AllWaysTrue()",,,,aHeader,aCols)
oGetDados:ForceRefresh()
                                                                   

ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar(oDlg,{||nOpca:=1,If(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},{||oDlg:End()},,aButtons))

lRet:=(nOpca==1)

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GatDescAm บAutor  ณElton C.	         บ Data ณ  11/23/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna os dados de desconto por idade para funcionarios    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GatDescAm(cMatric, nIdade)

Local aArea 	:= GetArea()
Local nRet		:= 0
Local nIdadeFun	:= 0
Local cTbDescAM := GetCtParam("NC_DESCAM",;
  										"S009",;
										"C",;
										"Informar a tabela de desconto por idade",;
										"Informar a tabela de desconto por idade",;
										"Informar a tabela de desconto por idade",;
										.F. ) 

Default cMatric	:= ""
Default nIdade	:= 0

DbSelectArea("SRA")
DbSetOrder(1)
If SRA->(DbSeek(xFilial("SRA") + cMatric))
		
	If nIdade == 0
		nIdadeFun := int( (MsDate() - SRA->RA_NASC)/365)   			
		nRet := GetDescId(nIdadeFun, cTbDescAM, SRA->RA_MAT)
	Else
		nRet := GetDescId(nIdade, cTbDescAM, SRA->RA_MAT)		
	EndIf
EndIf
	

RestArea(aArea)
Return nRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetDescId บ Autor ณ Elton C.		     บ Data ณ  29/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina utilizada para retornar o valor de desconto         บฑฑ
ฑฑบ          ณ de acordo com a idade do funcionario                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function GetDescId(nIdade, cTabela, cMatricula)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local nRet		:= 0

Default nIdade		:= 0
Default cTabela		:= ""                      
Default cMatricula	:= ""


cQuery	:= " SELECT RHK_MAT, RHK_PLANO, "+CRLF
cQuery	+= " 		SUBSTRING(RHK_PLANO,1,2) , "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,14,2) IDADE, "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,26,12) VL_TITULAR, "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,38,12) VL_DEPEND, "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,50,12) VL_AGREG, "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,83,3) CODFORNEC "+CRLF
cQuery	+= "		FROM "+RetSqlName("RHK")+" RHK "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("RCC")+" RCC "+CRLF
cQuery	+= " ON RCC.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND RCC.RCC_FILIAL = '"+xFilial("RCC")+"' "+CRLF
cQuery	+= " AND RCC.RCC_CODIGO = '"+cTabela+"' "+CRLF
cQuery	+= " AND SUBSTRING(RCC.RCC_CONTEU,1,2) = SUBSTRING(RHK_PLANO,1,2) "+CRLF
cQuery	+= " AND SUBSTRING(RCC.RCC_CONTEU,83,3) = RHK.RHK_CODFOR "+CRLF
cQuery	+= " AND SUBSTRING(RCC.RCC_CONTEU,14,2) >= '"+Alltrim(Str(nIdade))+"' "+CRLF

cQuery	+= " WHERE RHK.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " 	AND RHK.RHK_FILIAL = '"+xFilial("RHK")+"' "+CRLF
cQuery	+= " 	AND RHK.RHK_MAT = '"+cMatricula+"' "+CRLF
cQuery	+= " 	AND RHK.RHK_PERINI <= '"+DTOS(MsDate())+"' "+CRLF
cQuery	+= "	AND (RHK.RHK_PERFIM = ' ' OR RHK.RHK_PERFIM >= '"+DTOS(MsDate())+"') "+CRLF
cQuery	+= "AND RHK.RHK_TPFORN = '1' "+CRLF

cQuery	+= " ORDER BY IDADE "+CRLF

cQuery	:= ChangeQuery( cQuery )   

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	nRet := Val((cArqTmp)->VL_TITULAR)// + Val((cArqTmp)->VL_DEPEND) + Val((cArqTmp)->VL_AGREG)
Else
	nRet := 0	
EndiF

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return nRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณMenudef   บ Autor ณ Sergio Artero      บ Data ณ  29/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Cria o menu da MBrowse.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Catupiry                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Menudef()

Local alRotina := {	{"&Imp.Assis.M้dica"	,"U_ImpPlAM"	,0,3},;
					{"&Visualizar"			,"U_ManutAM"	,0,2},;
					{"&Incluir"				,"U_ManutAM"	,0,3},;					
					{"&Alterar"				,"U_ManutAM"	,0,4},;										
					{"&Excluir"				,"U_ManutAM"	,0,5};										
					}

Return alRotina



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpPlVT		บAutor  ณELTON SANTANA	 บ Data ณ  28/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para ler o arquivo e efetuar a importa็ใo  บฑฑ
ฑฑบ          ณdos dados da planilha	referente o VT, VR e VA		  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ImpPlAM()

Local aBotoes	:= {}
Local aSays		:= {}
Local aPergunt	:= {}
Local nOpcao	:= 0   
Local oRegua    := Nil
Local alPerg	:= {}
Local llImp		:= .T.

Private alMsgErro	:= {} 


//Tela de aviso e acesso aos parametros
AAdd(aSays,"[Importa็ใo de planilha]")
AAdd(aSays,"Esse programa efetuara a importa็ใo da planilha  ")
AAdd(aSays,"referente a Assis. M้dica ...")


AAdd(aBotoes,{ 5,.T.,{|| alPerg := PergFile() 		}} )
AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )        
FormBatch( "[Importa็ใo de planilha]", aSays, aBotoes )

//Verifica se o parametro com o endere็o do arquivo foi preenchido
If Len(alPerg) > 0

	If alPerg[1]
		If nOpcao == 1
			MsgRun( 'Importando dados...' ,  '', { || LeArqAm(alPerg)} )
		EndIf
	Else
		MsgAlert("Erro ao ler arquivo...")
	EndIf
Else
	MsgAlert("O parโmetro com o nome do arquivo nใo foi preenchido ! ")
EndIf



Return(Nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLeArqAm 	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLeitura do arquiv com a exten็ใo .CSV                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function LeArqAm(aParam)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local nlCont		:= 1
Local lRetImp		:= .T.
Local clArq 		:= aParam[2][1]
Local dDtRef		:= aParam[2][2]
Local aErroImp		:= {}		

Private uConteudo := Nil

FT_FUse(clArq)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
   
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo a qual contem o cabe็alho
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
    
	If Len(alLinha) < 18
 		Aviso("Arquivo invแlido","Arquivo com o formato inesperado, verifique se as colunas estใo corretas.",{"Ok"},2)
 		Exit
 		Return .F.
	Else
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha )
	EndIf
	
	FT_FSkip()
EndDo 

//Chama a rotina para importar
aErroImp := {}
aErroImp := ImpAM(aArquivo, dDtRef) 
If Len(aErroImp) > 0
	If Aviso("Erro na importa็ใo","Alguns itens nใo foram importados, deseja visualizar ?",{"Sim", "Nใo"},3) == 1
		GerPlnErr(aErroImp)
	EndIf
EndIf

Return lRetImp



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpAM  บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para efetuar a importa็ใo do arquivo		  บฑฑ
ฑฑบ          ณ							                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   
Static Function ImpAM(aDadosArq, dDataRef) 

Local aArea			:= GetArea()
Local nX			:= 0
Local aDadosFunc	:= {}
Local cTpMov		:= ""
Local cCodMatric	:= ""
Local cNomeFunc		:= ""
Local nDesc			:= 0
Local nCalc			:= 0
Local cCodImp		:= ""
Local cValor		:= ""
Local nValor		:= 0	
Local cSeq			:= ""
Local nSeq			:= 0
Local aMsgErro		:= {}
Local nY			:= 0 
Local aLinErrAux	:= {}
Local aLinErr		:= {}
Local cMsgErr		:= ""
Local cCPFAux		:= ""
Local cSeqDepend	:= ""
Local nSeqDp		:= 0
Local cTbDescAM 	:= GetCtParam("NC_DESCAM",;
  										"S009",;
										"C",;
										"Informar a tabela de desconto por idade",;
										"Informar a tabela de desconto por idade",;
										"Informar a tabela de desconto por idade",;
										.F. ) 


Default aDadosArq 	:= {}
Default dDataRef	:= CTOD('')

//Recebe o codigo da importa็ใo
cCodImp := u_CodImpAM()

//Percorre as linhas do arquivo para efetaur a importa็ใo
For nX := 1 To Len(aDadosArq)
	
	//Zera as variaveis 
	aDadosFunc	:= {}
    
	cSeq		:= ""
	cCodMatric	:= ""
	cNomeFunc	:= ""
	cTpMov		:= ""
	nDesc		:= 0
	nCalc		:= 0

	cCPFAux		:= ""
	cCPFAux		:= STRZERO(Val(aDadosArq[nX][18]), TAMSX3("RA_CIC")[1])	
	aDadosFunc 	:= GetMNS(cCPFAux)//Busca os dados do funcionario (Matricula, Nome e Salario) de acordo com o numero do CPF
	
	cCodMatric	:= aDadosFunc[1]//Matricula
	cNomeFunc	:= aDadosArq[nX][6]//Nome do Funcionario

	If Alltrim(aDadosArq[nX][13]) == 'T'
		nDesc		:= GetDescId(Val(aDadosArq[nX][9]), cTbDescAM, aDadosFunc[1])//Verifica o valor do desconto
	Else 
		nDesc := 0
	EndIf         

	cValor	:= STRTRAN(aDadosArq[nX][14], "R$", "")
	cValor	:= STRTRAN(cValor, ".", "")
	cValor	:= STRTRAN(cValor, ",", ".")
	nValor	:= Val(cValor)//Valor da transa็ใo
	
	nCalc		:= nValor - nDesc


	aMsgErro := {}
	
	
	//Faz a valida็ใo dos dados
		//VldLin(cCodImp,dDataRef, cSeq, cNota, cCPF, cMatric, cNomeFun, nIdade, cTpUser, nValor, nValDesc, nVlCalc)
	If VldLin(cCodImp,dDataRef, Alltrim(Str(nX)), aDadosArq[nX][2], cCPFAux, cCodMatric, cNomeFunc,;
				 Val(aDadosArq[nX][9]), nValor, nDesc, nCalc, @aMsgErro)

        //Pega o valor sequencial da linha
		cSeq := ""
		++nSeq
		cSeq := STRZERO(nSeq, TAMSX3("PX2_SEQ")[1])	

     	//Inclui os dados da importa็ใo nas tabelas PX1 e PX2
		//GrvImpAM(cCodigo,dDtImp, cSeq, cNota, cCPF, cMatric, cNomeFun, nIdade, cTpUser, nValor, nValDesc, nVlCalc )
		GrvImpAM(cCodImp,dDataRef, cSeq, aDadosArq[nX][2], cCPFAux, cCodMatric, cNomeFunc,;
					 Val(aDadosArq[nX][9]), nValor, nDesc, nCalc )



        //Grava os dados do Dependente na tabela PX3
    	If (nX + 1) <= Len(aDadosArq)
    	    If Alltrim(aDadosArq[nX+1][13]) != 'T'
   		  		nSeqDp 		:= 0
   		  		cSeqDepend  := ""
   		  		For nX := nX+1 To Len(aDadosArq)
    		    	If (Alltrim(aDadosArq[nX][13]) != 'T')
					
						cValor	:= STRTRAN(aDadosArq[nX][14], "R$", "")
						cValor	:= STRTRAN(cValor, ".", "")
						cValor	:= STRTRAN(cValor, ",", ".")
						nValor	:= Val(cValor)//Valor da transa็ใo
      					
      					cCPFAux		:= ""
						cCPFAux		:= STRZERO(Val(aDadosArq[nX][18]), TAMSX3("RA_CIC")[1])	

                        If nValor > 0
		    		    	++nSeqDp
    				    	cSeqDepend := STRZERO(nSeqDp, TAMSX3("PX3_SEQ")[1])

	    		   		  	//Chama a rotina para gravar os dependentes
	    		    		GrvImpAMDp(cCodImp, cSeqDepend, dDataRef,, aDadosArq[nX][2],, cCPFAux,;
    			    					 cCodMatric, aDadosArq[nX][6], Val(aDadosArq[nX][9]), nValor, .F.)
						EndIf
    			    Else
    			    	Exit
    			    EndIf
	    		Next
	    		
	    		//Diminui o valor de nX para continuar o preenchimento dos titulares
	    		nX -= 1
    	    EndIf
    	 EndIf
    	 
    Else                          

    	cMsgErr := ""
    	aLinErrAux := {}
    	aLinErrAux := aDadosArq[nX]
    	For nY := 1 To Len(aMsgErro)
	    	cMsgErr += " | "+aMsgErro[nY]
	    Next                    
    	
    	Aadd(aLinErrAux, cMsgErr)
    	Aadd(aLinErr,aLinErrAux)
	EndIf
	
Next

RestArea(aArea)
Return aLinErr


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCodImpAM	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o proximo codigo de importa็ใo 			          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CodImpAM()

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()


cQuery := " SELECT MAX(PX1_CODIMP) PX1_CODIMP FROM "+RetSqlName("PX1")+" PX1 "
cQuery += " WHERE PX1.D_E_L_E_T_ = ' ' "
cQuery += " AND PX1.PX1_FILIAL = '"+xFilial("PX1")+"' "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	cRet := soma1((cArqTmp)->PX1_CODIMP)
Else
	//Preenchimento incial do codigo
	cRet := "000001"
EndIf

If Select("cArqTmp") > 0
	(cArqTmp)->( dbCloseArea() )
EndIf

RestArea(aArea)
Return cRet





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetMNS   บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a Matricula, Nome e Salario do funcionario		  บฑฑ
ฑฑบ          ณde acordo com o CPF	                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetMNS(cCpf)

Local aArea 	:= GetArea()
Local aRet		:= ""
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCpf	:= ""

cQuery	:= " SELECT RA_MAT, RA_NOME, RA_SALARIO FROM "+RetSqlName("SRA")+" SRA "+CRLF
cQuery	+= " WHERE SRA.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND SRA.RA_FILIAL = '"+xFilial("SRA")+"' "+CRLF
cQuery	+= " AND SRA.RA_CIC = '"+cCpf+"' " +CRLF
cQuery	+= " AND SRA.RA_SITFOLH IN(' ','A','F','D') "+CRLF

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	aRet := {(cArqTmp)->RA_MAT,(cArqTmp)->RA_NOME ,(cArqTmp)->RA_SALARIO }
Else
	aRet := {"","",0}
EndIf

//Fecha a tabela temporaria
If Select("cArqTmp") > 0
	(cArqTmp)->( dbCloseArea() )
EndIf

RestArea(aArea)	
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldLinบAutor  ณElton C.			 บ Data ณ  05/11/11   	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo da linha do arquivo e/ou inclusใo manual          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldLin(cCodigo,dDtImp, cSeq, cNota, cCPF, cMatric, cNomeFun, nIdade, nValor, nValDesc, nVlCalc, aMsgErro)

Local aArea	:= GetArea()
Local lRet	:= .T.

Default cCodigo		:= ""
Default dDtImp		:= CTOD('') 
Default cSeq		:= "" 
Default cNota		:= "" 
Default cCPF		:= "" 
Default cMatric		:= "" 
Default cNomeFun	:= "" 
Default nIdade		:= 0 
Default nValor		:= 0 
Default nValDesc	:= 0
Default nVlCalc		:= 0
Default aMsgErro	:= {}


If Empty(cCodigo)
	Aadd(aMsgErro, "C๓digo nใo informado - Linha: "+cSeq)
Else
	DbSelectArea("PX1")
	DbSetOrder(1)
	If PX1->(DbSeek(xFilial("P0G") + PadR(cCodigo,TAMSX3("PX2_CODIMP")[1]) + PadR(cSeq,TAMSX3("PX2_SEQ")[1])))
		lRet	:= .F.
		Aadd(aMsgErro, "O c๓digo de importa็ใo e a sequencia jแ existe - Linha: "+cSeq)
	EndIf
EndIf                

//Verifica se a nota foi informada
If Empty(cNota)
	lRet	:= .F.
	Aadd(aMsgErro, "Numero da nota fiscal nใo preenchido - Linha: "+cSeq)
EndIf


//Verifica se o CPF foi preenchido
If (Empty(cCPF)) 
	lRet	:= .F.
	Aadd(aMsgErro, "CPF nใo preenchido - Linha: "+cSeq)
EndIf

//Verifica se o CPF foi preenchido
If nIdade <= 0 
	lRet	:= .F.
	Aadd(aMsgErro, "A idade deve ser diferente de 0 "+cSeq)
EndIf



//Verifica se o codigo da matricula foi preenchida
If Empty(cMatric) 
	lRet	:= .F.
	Aadd(aMsgErro, " C๓digo da matricula nใo encontrado para o CPF: "+cCPF+" - Linha: "+cSeq)
Else	
	DbSelectArea("SRA")
	DbSetOrder(1)
	If !SRA->(DbSeek(xFilial("SRA") + cMatric))
		lRet	:= .F.
		Aadd(aMsgErro, " C๓digo da matricula nใo encontrado para o CPF: "+cCPF+" - Linha: "+cSeq)
	EndIf
EndIf


RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvImpAMบ	Autor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados da movimenta็ใo		 			          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvImpAM(cCodigo,dDtImp, cSeq, cNota, cCPF, cMatric, cNomeFun, nIdade, nValor, nValDesc, nVlCalc )

Local aArea := GetArea()
Local lRet	:= .T.

Default cCodigo		:= ""
Default dDtImp		:= CTOD('')
Default cSeq		:= "" 
Default cNota		:= "" 
Default cCPF		:= "" 
Default cMatric		:= "" 
Default cNomeFun	:= "" 
Default nIdade		:= 0 
Default nValor		:= 0 
Default nValDesc	:= 0 
Default nVlCalc		:= 0

DbSelectArea("PX1")
DbSetOrder(1)
If !PX1->(DbSeek(xFilial("PX1") + cCodigo))
	
	If RECLOCK("PX1", .T.)
		PX1->PX1_FILIAL := xFilial("PX1")
		PX1->PX1_CODIMP := cCodigo 
		PX1->PX1_DTIMP 	:= dDtImp
		PX1->PX1_DTDIGI := MsDate()
	Else
		lRet	:= .F.
	EndIF
EndIf


DbSelectArea("PX2")
DbSetOrder(1)
If RecLock("PX2", .T.)
	PX2->PX2_FILIAL	:= xFilial("PX2")
	PX2->PX2_CODIMP := cCodigo
	PX2->PX2_DTIMP  := dDtImp
	PX2->PX2_DTDIGI := MsDate()
	PX2->PX2_SEQ    := cSeq
	PX2->PX2_NOTA   := cNota
	PX2->PX2_SERIE  := ""
	PX2->PX2_CPF    := cCPF
	PX2->PX2_MATRIC := cMatric
	PX2->PX2_NOME   := cNomeFun
	PX2->PX2_IDADE  := nIdade
	PX2->PX2_VALOR  := nValor
	PX2->PX2_VLDESC := nValDesc
	PX2->PX2_VLCALC := nVlCalc
Else
	lRet	:= .F.
EndIf	    

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetAMImp	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o proximo codigo de importa็ใo 			          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetAMImp()

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()


cQuery := " SELECT MAX(PX1_CODIMP) PX1_CODIMP FROM "+RetSqlName("PX1")+" PX1 "
cQuery += " WHERE PX1.D_E_L_E_T_ = ' ' "
cQuery += " AND PX1.PX1_FILIAL = '"+xFilial("PX1")+"' "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	cRet := soma1((cArqTmp)->PX1_CODIMP)
Else
	//Preenchimento incial do codigo
	cRet := "000001"
EndIf

If Select("cArqTmp") > 0
	(cArqTmp)->( dbCloseArea() )
EndIf

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFile	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta com o endere็o do arquivo				          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})
aAdd( alParamBox ,{1,"Dt.Refer๊ncia"	,MsDate()				,"@!",""		,""		,"",50						,.F.})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Parametros",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCtParamบAutor  ณElton C.		     บ Data ณ  03/13/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o conteudo do parametro e ou cria o parametro       บฑฑ
ฑฑบ          ณcaso nใo exista                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCtParam( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)
lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
RecLock( "SX6", lRecLock )
FieldPut( FieldPos( "X6_VAR" ), cMvPar )
FieldPut( FieldPos( "X6_TIPO" ), cTipo )
FieldPut( FieldPos( "X6_PROPRI" ), "U" )
If !Empty( cDescP )
	FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
	FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
	FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
EndIf
If !Empty( cDescS )
	FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
	FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
	FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
EndIf
If !Empty( cDescE )
	FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
	FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
	FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
EndIf
If lRecLock .Or. lAlter
	FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
	FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
	FieldPut( FieldPos( "X6_CONTENG" ), xValor )
EndIf

MsUnlock()

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerPlnErrบAutor  ณElton C.		     บ Data ณ  03/13/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera a o arquivo excel com os erros encontrados             บฑฑ
ฑฑบ          ณ                                          				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerPlnErr(aDadosErr)
Local aArea := GetArea()     
Local nX	:= 1

Private apExcel		:= {}


MontaExcel(1)
	

For nX := 1 To Len(aDadosErr)
	MontaExcel(2, aDadosErr[nX][1], aDadosErr[nX][2], aDadosErr[nX][3], aDadosErr[nX][4], aDadosErr[nX][5], aDadosErr[nX][6],;
				 aDadosErr[nX][7], aDadosErr[nX][8], aDadosErr[nX][9], aDadosErr[nX][10], aDadosErr[nX][11], aDadosErr[nX][12],;
				 aDadosErr[nX][13], aDadosErr[nX][14], aDadosErr[nX][15], aDadosErr[nX][16], aDadosErr[nX][17], aDadosErr[nX][18], aDadosErr[nX][19])

Next

MontaExcel(3)
GeraExcel(apExcel)


RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณMontaExcel บAutor  ณElton C.		     บ Data ณ  11/07/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que monta o HTML para exportar para o excel          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MontaExcel(nOpc, cEmpresa, cNota, cComp, cRef, cCodUsuario, cNome, cRegTrab, cDataNasc, cIdade, cDtCadastro,;
								 cCodPlano, cNomePlano, cTpUsu, cValor, cLocalEmp, cSubLocal, cNomeLocal, cCPF, cMsgErro)

Local aArea  := GetArea()  

Default cEmpresa		:= ""
Default cNota           := ""
Default cComp           := ""
Default cRef            := ""
Default cCodUsuario     := ""
Default cNome           := ""
Default cRegTrab        := ""
Default cDataNasc       := ""
Default cIdade          := ""
Default cDtCadastro     := ""
Default cCodPlano       := ""
Default cNomePlano      := ""
Default cTpUsu          := ""
Default cValor          := ""
Default cLocalEmp       := ""
Default cSubLocal       := ""
Default cNomeLocal      := ""
Default cCPF            := ""
Default cMsgErro        := ""



If nOpc = 1 //Abre as tags HTML
	
	AADD(apExcel, '<html>')
	AADD(apExcel, '<body>')
	AADD(apExcel, '<table border="1">')
	AADD(apExcel, '<tr>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Empresa</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Nota</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Comp.</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Ref.</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Codigo Usuario</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Nome Usuario</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Reg. Trab.</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Data Nasc.</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Idade</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Data Cadastro</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Cod. Plano</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Nome Plano</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Tp. Usu.</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Valor</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Local Empresa</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Sub Local</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Nome Local</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>CPF</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Msg. Erro</Font></b></td>')
	AADD(apExcel, '</tr>')
	
ElseIf nOpc = 2 // Preenche o dados dos movimentos contabeis
                  
	AADD(apExcel, '<tr>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cEmpresa+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cNota+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cComp+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cRef+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCodUsuario+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cNome+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cRegTrab+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cDataNasc+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cIdade+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cDtCadastro+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCodPlano+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cNomePlano+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cTpUsu+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cValor+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cLocalEmp+'</Font></td>')	
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cSubLocal+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cNomeLocal+'</Font></td>')		
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCPF+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cMsgErro+'</Font></td>')	
	AADD(apExcel, '</tr>')
	
ElseIf nOpc = 3 //Fecha as tags html
	
	AADD(apExcel, '</table>')
	AADD(apExcel, '</body>')
	AADD(apExcel, '</html>')
	
EndIf


RestArea(aArea)
Return
            
					
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGeraExcel บAutor  ณElton C.		     บ Data ณ  11/07/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria e escreve o arquivo excel.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraExcel(alPlanilha)
	
	Local nlHandle
	Local clLocal := ""
	Local clNameArq := "Importacao_AM_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
	Local olExcelApp
	Local aPerg	:= PergPlErr()//Pergunta com o endere็o do arquivo
	
	If Len(aPerg[2] ) > 0
		If !aPerg[1]
			Return     
		EndIf
	Else
	    return
	EndIf 
	clDir := Alltrim(aPerg[2][1])
	clLocal := clDir + clNameArq

	nlHandle  := FCREATE(clLocal)
	
	if nlHandle == -1
		MsgStop("Nใo foi possํvel criar o arquivo em: " + CRLF + clLocal)
	else
		AEVAL(alPlanilha, {|x| FWRITE(nlHandle, x)} )
		FCLOSE(nlHandle)
		
		if File(clLocal)
	
			olExcelApp	:= MsExcel():New()
			olExcelApp:WorkBooks:Open(clLocal)
			olExcelApp:SetVisible(.T.)
	
		else
			Conout("Erro ao criar o arquivo em: " + clLocal)
			MsgAlert("Erro ao criar o arquivo em: " + clLocal)
		endif
		
	endif

Return     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFile	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta com o endere็o do arquivo				          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC	                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergPlErr()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  






//------------------------------------------------------------------Mnuten็ใo do Dependente -----------------------------------------------------------------



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณIncCCApr	  ณ Autor ณElton C.		        ณ Data ณ15/12/11  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณTela para amarra็ใo do centro de Custo x Aprovador		  ณฑฑ
ฑฑณ			 ณ															  ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function MnDmAM()

Local aArea 		:= GetArea()
Local oDlgDp     		:= Nil
Local aColsDepend	:= {}
Local aHeaderDp		:= {}
Local aCampos		:= {"PX3_SEQ","PX3_CPF","PX3_NOME", "PX3_IDADE", "PX3_VALOR"}//Campos da pergunta
Local aCpoAlter		:= {"PX3_CPF","PX3_NOME", "PX3_IDADE", "PX3_VALOR"}//Campos da pergunta
Local oBtnGrv		:= Nil
Local oBtnSair		:= Nil
Local aBotoes		:= {} 
Local nOpcAux		:= 0

If nOpcDP == 3 .Or. nOpcDP == 4
	nOpcAux := GD_INSERT + GD_UPDATE + GD_DELETE
Else 
	nOpcAux := 0
EndIf


aHeaderDp	:= CriaHeader(aCampos)//Cria o aheader a ser utilizado na getdados
aColsDepend	:= CAcolsDp(M->PX1_CODIMP, ogetdados:Acols[ogetdados:nAt][GdFieldPos("PX2_MATRIC")], aHeaderDp)
DEFINE MSDIALOG oDlgDp TITLE "Dependente" FROM 001, 001  TO 300, 780 COLORS 0, 16777215 PIXEL

oGetAlt := MsNewGetDados():New(013,000,151,390,nOpcAux,,,"+PX3_SEQ",aCpoAlter,/*freeze*/,50,/*fieldok*/,/*superdel*/,/*delok*/,oDlgDp,aHeaderDp,aColsDepend)
oGetAlt:ForceRefresh()

//Botoes com as op็๕es de gravar os dados incluidos e botao para sair da rotina
Aadd(aBotoes, {oBtnGrv,"SALVAR","Salvar","Salva dependente",{|| GrvDp(oGetAlt,aHeaderDp), oDlgDp:End() } })
Aadd(aBotoes, {oBtnSair,"FINAL","Sair","Sair",{||oDlgDp:End() } })


ACTIVATE MSDIALOG oDlgDp CENTERED  ON INIT BtnBar( oDlgDp, aBotoes)


RestArea(aArea)
Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณBtnBar	  ณ Autor ณElton C.		        ณ Data ณ15/12/11  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณMonta os botoes a serem utilizados com enchoicebar		  ณฑฑ
ฑฑณ			 ณ															  ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function BtnBar( oDlgDp, aBotoes)

Local nX
Local oBar

Default aBotoes := {}			     

DEFINE BUTTONBAR oBar SIZE 25,25 3D TOP OF oDlgDp

//-- Adiciona novos botoes
For nX:=1 to Len(aBotoes)
	DEFINE BUTTON aBotoes[nX][1] RESOURCE aBotoes[nX,2] OF oBar GROUP	 TOOLTIP OemToAnsi( aBotoes[nX,3] )  			   // Titulo Completo
	aBotoes[nX][1]:cTitle:= aBotoes[nX,4]  //Titulo Sintetico  
	aBotoes[nX][1]:bAction:=aBotoes[nX,5]  //Bloco de acao para o botao
Next nX      

Return
       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCAcolsDp  บAutor  ณDBM                 บ Data ณ  11/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria vetor aCols da GETDADOS                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CAcolsDp(cCodImp,cMatric,aHeaderDp)
Local nQtdCpo := 0
Local i       := 0
Local nCols   := 0
Local aRet	  := {}


Default aHeaderDp 	:= {}
Default cCodImp		:= ""
Default cMatric		:= ""
 
nQtdCpo := Len(aHeaderDp)
aRet   := {}
	
dbSelectArea("PX3")
dbSetOrder(1)
dbSeek(xFilial("PX3") + PADR(cCodImp,TAMSX3("PX3_CODIMP")[1]) + PADR(cMatric, TAMSX3("PX3_MATRIC")[1]))

If !Empty(cCodImp) .And. !Empty(cMatric)

	While PX3->(!EOF()) ;
			.And. (PX3->PX3_FILIAL == xFilial("PX3"));
			.And. (Alltrim(PX3->PX3_CODIMP) == Alltrim(cCodImp));
			.And. (Alltrim(PX3->PX3_MATRIC) == Alltrim(cMatric))
		
		AAdd(aRet, Array(nQtdCpo+1))
		nCols++
		
		For i := 1 To nQtdCpo
			If aHeaderDp[i][10] <> "V"
				aRet[nCols][i] := FieldGet(FieldPos(aHeaderDp[i][2]))
			Else
				aRet[nCols][i] := CriaVar(aHeaderDp[i][2], .T.)
			EndIf
		Next
		
		aRet[nCols][nQtdCpo+1] := .F.
		
		PX3->(dbSkip())
	EndDo
	
	If Len(aRet) <= 0
		AAdd(aRet, Array(Len(aHeaderDp)+1))
		
		For i := 1 To nQtdCpo
			If Alltrim(aHeaderDp[i][2]) == "PX3_SEQ"
				aRet[1][i] := CriaVar(aHeaderDp[i][2])
				aRet[1][i] := "0001"
			Else
				aRet[1][i] := CriaVar(aHeaderDp[i][2])
			EndIf
		Next
		
		aRet[1][nQtdCpo+1] := .F.
		
	EndIf
	
EndIf

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvDp		บ	Autor  ณElton C.		 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณChama a rotina de grava็ใo dos dependentes				  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvDp(oGetDadosDp, aHeaderDp)

Local aArea 	:= GetArea()
Local nAt		:= ogetdados:nAt
Local nPosNota	:= GdFieldPos("PX2_NOTA") 	
Local nPosSerie	:= GdFieldPos("PX2_SERIE")	
Local nMatric	:= GdFieldPos("PX2_MATRIC")
Local cCodImp	:= M->PX1_CODIMP
Local nX		:= 0

//Local aCampos		:= {"PX3_SEQ","PX3_CPF","PX3_NOME", "PX3_IDADE", "PX3_VALOR"}//Campos da pergunta
For nX := 1 To Len(oGetDadosDp:Acols)
	GrvImpAMDp(cCODIMP,;
				 oGetDadosDp:Acols[nX][1],;//Sequencia
				 ,;
				 ,;
				 ogetdados:Acols[nAt][nPosNota],;
				 ogetdados:Acols[nAt][nPosSerie],;
				 oGetDadosDp:Acols[nX][2],;//CPF
				 ogetdados:Acols[nAt][nMatric],;
				 oGetDadosDp:Acols[nX][3],;//nOME
				 oGetDadosDp:Acols[nX][4],;//Idade
				 oGetDadosDp:Acols[nX][5],;//Valor
				 oGetDadosDp:Acols[nX][Len(aHeaderDp)+1]  )//Verifica se e item deletado
Next


RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvImpAMDpบ	Autor  ณElton C.		 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados do dependente.Rotina utilizada na importa็ใo.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvImpAMDp(cCODIMP, cSEQ, dDTMP, dDTDIGI, cNOTA, cSERIE, cCPF, cMATRIC, cNOME, nIDADE, nVALOR, lDel)

Local aArea := GetArea()

Default cCODIMP	:= ""
Default cSEQ	:= "" 
Default dDTMP	:= ctod('') 
Default dDTDIGI	:= ctod('') 
Default cNOTA	:= "" 
Default cSERIE	:= "" 
Default cCPF	:= "" 
Default cMATRIC	:= "" 
Default cNOME	:= ""              
Default nIDADE	:= 0
Default nVALOR	:= 0
Default lDel	:= .F.

DbSelectArea("PX3")
DbSetOrder(1)    

//Verifica se serแ altera็ใo
If DbSeek(xFilial("PX3") + PADR(cCODIMP,TAMSX3("PX3_CODIMP")[1]) ;
				+ PADR(cMATRIC,TAMSX3("PX3_MATRIC")[1]) ;
				+ PADR(cSEQ,TAMSX3("PX3_SEQ")[1]);
				 )
    
	If !lDel
		RECLOCK("PX3",.F.)

		PX3_FILIAL	:= xFilial("PX3")
		PX3_CODIMP  := cCODIMP
		PX3_SEQ     := cSEQ
		PX3_DTMP    := dDTMP
		PX3_DTDIGI  := dDTDIGI
		PX3_NOTA    := cNOTA
		PX3_SERIE   := cSERIE
		PX3_CPF     := cCPF
		PX3_MATRIC  := cMATRIC
		PX3_NOME    := cNOME
		PX3_IDADE   := nIDADE
		PX3_VALOR	:= nVALOR
			
		PX3->(MsUnLock())
	Else
		//Exclusใo
		RECLOCK("PX3",.F.)	
		PX3->(DbDelete())
		PX3->(MsUnLock())
	EndiF
Else
	//Inclusใo
	RECLOCK("PX3",.T.)

	PX3_FILIAL	:= xFilial("PX3")
	PX3_CODIMP  := cCODIMP
	PX3_SEQ     := cSEQ
	PX3_DTMP    := dDTMP
	PX3_DTDIGI  := dDTDIGI
	PX3_NOTA    := cNOTA
	PX3_SERIE   := cSERIE
	PX3_CPF     := cCPF
	PX3_MATRIC  := cMATRIC
	PX3_NOME    := cNOME
	PX3_IDADE   := nIDADE
	PX3_VALOR	:= nVALOR
		
	PX3->(MsUnLock())


EndIf

RestArea(aArea)
Return     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcDependบ	Autor  ณElton C.		 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados do dependente.Rotina utilizada na importa็ใo.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcDepend(cCodImp, cMatric)

Local aArea := GetArea()

DbSelectArea("PX3")
DbSetOrder(1)    
If DbSeek(xFilial("PX3") + PADR(cCODIMP,TAMSX3("PX3_CODIMP")[1]) ;
				+ PADR(cMATRIC,TAMSX3("PX3_MATRIC")[1]) ;
				 )
	
	//Exclui todos os dependente	
	While PX3->(!Eof()) .And. (Alltrim(PX3->PX3_CODIMP) == Alltrim(cCodImp)) .And. Alltrim(PX3->PX3_MATRIC) == Alltrim(cMatric)
		RECLOCK("PX3",.F.)	
		PX3->(DbDelete())
		PX3->(MsUnLock())
		
		PX3->(DbSkip())
	EndDo
EndiF


RestArea(aArea)
Return

