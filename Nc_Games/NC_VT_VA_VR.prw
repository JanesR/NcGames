#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCIMPDES	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Importa��o e/ou manuentencao das despesas referentes ao 	  ���
���          �AM, AO, VT, VR e VA	                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCVTVRVA()
Local aArea := GetArea()

Local cAliasMB		:= "PX7"

Private cCadastro	:= "Rotina de manuten��o do VT, VR e VA"
Private aRotina		:= Menudef()

DbSelectArea("PX8")
DbSetOrder(1)  

DbSelectArea("PX7")
DbSetOrder(1)
mBrowse( 6, 1,22,75,cAliasMB,,,,,,/*aCores*/,,,, ,,,,)

RestArea(aArea)
Return                          

/*
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������ͻ��
���Programa  �MntTVTRA	  �Autor  �DBM                 � Data �  01/11/12   ���
���������������������������������������������������������������������������͹��
���Desc.     �Monta a tela para a manuten��o do VT, VR e VA                 ���
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
*/
User Function ManutVTRA(cAlias, nRecno, nOpc)

Local aArea 	:= GetArea()
Local cTitulo   := ""
Local aButtons	:= {} 
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local lVirtual := .T.
Local nLinhas  := 99999
Local nFreeze  := 0
Local aCampos	:= {"PX8_SEQ","PX8_NOTA", "PX8_SERIE", "PX8_PEDIDO", "PX8_TPIMP", "PX8_MATRIC", "PX8_NOME", "PX8_CPF",;
						 "PX8_QUANT", "PX8_VLUNIT", "PX8_VLTOT","PX8_VLDESC", "PX8_CALCUL",;
						   "PX8_CODVB", "PX8_VERBA"}

Local aCpoAlter := {"PX8_NOTA", "PX8_SERIE", "PX8_TPIMP","PX8_PEDIDO","PX8_VLUNIT","PX8_QUANT", "PX8_VLTOT", "PX8_PERDES",;
					 "PX8_CODVB", "PX8_MATRIC"}
						  

Private aHeader		 := {}
Private aCols		 := {}                        
Private aCpoEnchoice := {"PX7_CODIMP","PX7_DTIMP"}
Private aAltEnchoice := {"PX7_DTIMP"}
Private aAlt         := {} 
Private oGetDados                        
Private cAlias1	 	 := "PX7"
Private cAlias2		 := "PX8"

//MntTela(cCadastro, cAlias1, cAlias2, aCpoEnchoice, cLinOK, cTudoOK, nOpcE, nOpcG, cFieldOK, lVirtual, nLinhas, aAltEnchoice, nFreeze,aButtons,,220)


// Cria variaveis de memoria dos campos da tabela Pai.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

aHeader	:= CriaHeader(aCampos)
aCols	:= CriaAcols(nOpc)
           //CriaCols(nOpc)


If nOpc == 3//Inclus�o

	cTitulo	:= "Manuten��o VT, VR e VA - Inclus�o"
ElseIf nOpc == 4//Altera��o

	cTitulo	:= "Manuten��o VT, VR e VA - Altera��o"
ElseIf nOpc == 5 //Exclus�o

	cTitulo	:= "Manuten��o VT, VR e VA - Exclus�o"	
EndIf

//AAdd(aButtons, {"Estoque NC"		, {|| }	, 'STR0059' , 'Estoque NC' })	// Escolhe Vendedor...(F12)

lRet := U_TelaVtar(cTitulo,cAlias1,cAlias2,aCpoEnchoice,/*cLinOk*/,/*cTudoOk*/,nOpcE,nOpcG,/*cFieldOk*/,lVirtual,nLinhas,aAltEnchoice,nFreeze,{},,220, aCpoAlter)


If lRet 
	If nOpc == 3
		If Aviso("Confirma", "Confirma a grava��o dos dados ?", {"Sim","N�o"}) == 1
			aCols := oGetDados:Acols
			Processa({|| GrvDados()}, cCadastro, "Gravando os dados, aguarde...")
		EndIf
    ElseIf nOpc == 4
		If Aviso("Confirma", "Confirma a altera��o dos dados ?", {"Sim","N�o"}) == 1
			aCols := oGetDados:Acols
			Processa({||AltDados()}, cCadastro, "Alterando os dados, aguarde...")
		EndIf
	ElseIf nOpc == 5

		If Aviso("Confirma", "Confirma a exclus�o dos dados ?", {"Sim","N�o"}) == 1
			aCols := oGetDados:Acols
			Processa({||ExcDados()}, cCadastro, "Excluindo os dados, aguarde...")
		EndIf
	EndIf    

EndIf

RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GrvDados �Autor  �DBM                 � Data �  11/23/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gravacao dos dados                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
dbSelectArea("PX8")

For i := 1 To Len(aCols)
	
	IncProc()
	
	If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.
		
		RecLock("PX8", .T.)
		
		PX8->PX8_FILIAL := xFilial("PX8")
		PX8->PX8_CODIMP := M->PX7_CODIMP
		PX8->PX8_DTIMP	:= M->PX7_DTIMP
		PX8->PX8_DTDIGI	:= dDataBase

		For y := 1 To Len(aHeader)
			FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
		Next
		
		PX8->(MSUnlock())
		
	EndIf
	
Next

RestArea(aArea)
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AltDados  �Autor  �DBM                 � Data �  11/23/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Alteracao dos dados e efetivacao                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
			(cAlias2)->PX8_FILIAL := xFilial(cAlias2)
			(cAlias2)->PX8_CODIMP := (cAlias1)->PX7_CODIMP
			(cAlias2)->PX8_DTIMP  := (cAlias1)->PX7_DTIMP
			MSUnlock()
			nItem++
		EndIf
		
	EndIf
	
Next  

RestArea(aArea)
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExcDados  �Autor  �DBM                 � Data �  11/23/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Exclusao                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExcDados()

Local aArea		:= GetArea()

ProcRegua(Len(aCols)+1)   // +1 � por causa da exclusao do arq. de cabe�alho.

dbSelectArea(cAlias2)
dbSetOrder(1)
dbSeek(xFilial(cAlias2) + (cAlias1)->PX7_CODIMP)

While !EOF() .And. ((cAlias2)->PX8_FILIAL == xFilial(cAlias2)) .And. (Alltrim((cAlias2)->PX8_CODIMP) == Alltrim((cAlias1)->PX7_CODIMP))
	IncProc()
	RecLock(cAlias2, .F.)
	dbDelete()
	MSUnlock()
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaHeader�Autor  �Elton C.            � Data �  15/.12.11  ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria o aHeader						                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaCols  �Autor  �DBM                 � Data �  11/09/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria vetor aCols da GETDADOS                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CriaAcols(nOpc)
Local nQtdCpo := 0
Local i       := 0
Local alACols := {}
Local nCols   := 0

nQtdCpo := Len(aHeader)
alACols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.
	
	AAdd(alACols, Array(Len(aHeader)+1))
	
	For i := 1 To nQtdCpo
		If Alltrim(aHeader[i][2]) == "PX8_SEQ"
			alACols[1][i] := CriaVar(aHeader[i][2])
			alACols[1][i] := "0001"
		Else
			alACols[1][i] := CriaVar(aHeader[i][2])		
		EndIf
	Next
	
	alACols[1][nQtdCpo+1] := .F.
	
Else                           
	
	M->PX7_CODIMP 	:= PX7->PX7_CODIMP
	M->PX7_DTIMP	:= PX7->PX7_DTIMP
	dbSelectArea("PX8")
	dbSetOrder(1)
	dbSeek(xFilial("PX8") + PX7->PX7_CODIMP)
	
	While PX8->(!EOF()) .And. (PX8->PX8_FILIAL == xFilial("PX8")) .And. (Alltrim(PX8->PX8_CODIMP) == Alltrim(PX7->PX7_CODIMP))
		
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

		PX8->(dbSkip())
	EndDo                    


EndIf

Return aCols




/*
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������ͻ��
���Programa  �MntTela	  �Autor  �DBM                 � Data �  01/11/12   ���
���������������������������������������������������������������������������͹��
���Desc.     �Monta a tela 					                                ���
���������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
*/
User Function TelaVtar(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aButtons,aCordW,nSizeHeader, aCpoAlter)
Local lRet, nOpca := 0,cSaveMenuh,nReg:=(cAlias1)->(Recno()),oDlg

Local nDlgHeight   
Local nDlgWidth
Local nDiffWidth := 0 
Local lMDI := .F.
Local aSize	:= MsAdvSize(.F.,.F.,0)
Local aInfo	:= {}
Local aObjects	:= {}
Local nOpcAux	:= 0

Private Altera:=.t.,Inclui:=.t.,lRefresh:=.t.,aTELA:=Array(0,0),aGets:=Array(0),;
bCampo:={|nCPO|Field(nCPO)},nPosAnt:=9999,nColAnt:=9999
Private cSavScrVT,cSavScrVP,cSavScrHT,cSavScrHP,CurLen,nPosAtu:=0
Private oEnchoice

If nOpcE == 3 .Or. nOpcE == 4
	nOpcAux := GD_INSERT + GD_UPDATE + GD_DELETE
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

oEnchoice := Msmget():New(cAlias1,nReg,nOpcE,,,,aMyEncho,{13,1,(nSizeHeader/2)-50,If(lMdi, (aSize[5]/2)-2,__DlgWidth(oDlg)-nDiffWidth)},aAltEnchoice,1,,,,oDlg,,lVirtual,,,,,,,,.T.)       

oGetDados := MsNewGetDados():New((nSizeHeader/2)-45,001,(aSize[6]/2)-30,(aSize[5]/2)-2,nOpcAux ,cLinOk,cTudoOk,"+PX8_SEQ",aCpoAlter,,9999,"AllWaysTrue()",,,,aHeader,aCols)
oGetDados:ForceRefresh()
                                                                   

ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar(oDlg,{||nOpca:=1,If(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},{||oDlg:End()},,aButtons))

lRet:=(nOpca==1)
Return lRet



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �Menudef   � Autor � Sergio Artero      � Data �  29/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Cria o menu da MBrowse.                                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Catupiry                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Menudef()

/*Local alRotina := {	{"&Pesquisar"		,"U_CTPAPesq"	,0,1},;
					{"&Visualizar"		,"U_ManutVTRA(6)"	,0,2},;
					{"&Incluir"			,"U_ManutVTRA(3)"	,0,3},;					
					{"&Alterar"			,"U_ManutVTRA(4)"	,0,3},;										
					{"&Excluir"			,"U_ManutVTRA(5)"	,0,3},;										
					{"&Imp.VT/VR/VA"	,"U_ImpPlVT"	,0,3}}*/

Local alRotina := {	{"&Imp.VT/VR/VA"	,"U_ImpPlVT"	,0,3},;
					{"&Visualizar"		,"U_ManutVTRA"	,0,2},;
					{"&Incluir"			,"U_ManutVTRA"	,0,3},;					
					{"&Alterar"			,"U_ManutVTRA"	,0,4},;										
					{"&Excluir"			,"U_ManutVTRA"	,0,5};										
					}

Return alRotina


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCLegend		�Autor  �ELTON SANTANA	 � Data �  28/09/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o utilizada para montar a tela de legenda	 		  ���
���          �   												  		  ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCLegend()

Local aCor := {}

aAdd(aCor,{"BR_VERDE" ,"VT-Vale Transporte" })
aAdd(aCor,{"BR_PINK"	,"VR-Vale Refei��o"   })
aAdd(aCor,{"BR_AMARELO"	,"VA-Vale Alimenta��o" })


BrwLegenda(,OemToAnsi("Tipo de movimento"),aCor)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ImpPlVT		�Autor  �ELTON SANTANA	 � Data �  28/09/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para ler o arquivo e efetuar a importa��o  ���
���          �dos dados da planilha	referente o VT, VR e VA		  		  ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ImpPlVT()

Local aBotoes	:= {}
Local aSays		:= {}
Local aPergunt	:= {}
Local nOpcao	:= 0   
Local oRegua    := Nil
Local alPerg	:= {}
Local llImp		:= .T.

Private alMsgErro	:= {} 


//Tela de aviso e acesso aos parametros
AAdd(aSays,"[Importa��o de planilha]")
AAdd(aSays,"Esse programa efetuara a importa��o da planilha  ")
AAdd(aSays,"referente o VT, VR e VA...")


AAdd(aBotoes,{ 5,.T.,{|| alPerg := PergFile() 		}} )
AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )        
FormBatch( "[Importa��o de planilha]", aSays, aBotoes )

//Verifica se o parametro com o endere�o do arquivo foi preenchido
If Len(alPerg) > 0

	If alPerg[1]
		If nOpcao == 1
			MsgRun( 'Importando dados...' ,  '', { || LeArqVTRA(alPerg)} )
		EndIf
	Else
		MsgAlert("Erro ao ler arquivo...")
	EndIf
Else
	MsgAlert("O par�metro com o nome do arquivo n�o foi preenchido ! ")
EndIf



Return(Nil)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LeArqVTRA �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Leitura do arquiv com a exten��o .CSV                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LeArqVTRA(aParam)

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
    
    //Pula a primeira linha do arquivo a qual contem o cabe�alho
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
    
	If Len(alLinha) < 13
 		Aviso("Arquivo inv�lido","Arquivo com o formato inesperado, verifique se as colunas est�o corretas.",{"Ok"},2)
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
aErroImp := ImpVTVAVR(aArquivo, dDtRef) 
If Len(aErroImp) > 0
	If Aviso("Erro na importa��o","Alguns itens n�o foram importados, deseja visualizar ?",{"Sim", "N�o"},3) == 1
		GerPlnErr(aErroImp)
	EndIf
EndIf

Return lRetImp



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ImpVTVAVR  �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para efetuar a importa��o do arquivo		  ���
���          �							                                  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/   
Static Function ImpVTVAVR(aDadosArq, dDataRef) 

Local aArea			:= GetArea()
Local nX			:= 0
Local aVerbTpMov	:= {}
Local aDadosFunc	:= {}
Local cCodVerba		:= ""
Local cTpMov		:= ""
Local cCodMatric	:= ""
Local cNomeFunc		:= ""
Local nSalario		:= 0
Local nDesc			:= 0
Local nCalc			:= 0
Local nDescAux		:= 0
Local cCodImp		:= ""
Local cVlUnitAux	:= ""
Local cTotalAux		:= ""	
Local cQtdAux		:= ""	
Local nVlUnitAux	:= 0	
Local nTotalAux		:= 0	
Local nQtdAux		:= 0	
Local cSeq			:= ""
Local aMsgErro		:= {}
Local nY			:= 0 
Local aLinErrAux	:= {}
Local aLinErr		:= {}
Local cMsgErr		:= ""
Local cCPFAux		:= ""
Local nPerncDesc 	:= GetCtParam("NC_PERCDES",;
  										"6",;
										"N",;
										"Informar o percentual de desconto do funcionario",;
										"Informar o percentual de desconto do funcionario",;
										"Informar o percentual de desconto do funcionario",;
										.F. ) 
Local nPercAux		:= 0
Default aDadosArq 	:= {}
Default dDataRef	:= CTOD('')

//Recebe o codigo da importa��o
cCodImp := u_GetCodImp()

//Percorre as linhas do arquivo para efetaur a importa��o
For nX := 1 To Len(aDadosArq)
	
	//Zera as variaveis 
	aVerbTpMov	:= {}
	aDadosFunc	:= {}
    
	cSeq		:= ""
	cCodVerba	:= ""
	cCodMatric	:= ""
	cNomeFunc	:= ""
	cTpMov		:= ""
	nSalario	:= 0
	nDesc		:= 0
	nCalc		:= 0


	cVlUnitAux	:= ""
	cTotalAux	:= ""	
	cQtdAux		:= ""	
	nVlUnitAux	:= 0	
	nTotalAux	:= 0	
	nQtdAux		:= 0	


	cQtdAux	:= STRTRAN(aDadosArq[nX][11], ".", "")
	cQtdAux	:= STRTRAN(cQtdAux, ",", ".")
	nQtdAux	:= Val(cQtdAux)//Quantidade


	cVlUnitAux	:= STRTRAN(aDadosArq[nX][9], "R$", "")
	cVlUnitAux	:= STRTRAN(cVlUnitAux, ".", "")
	cVlUnitAux	:= STRTRAN(cVlUnitAux, ",", ".")
	nVlUnitAux	:= Val(cVlUnitAux)//Valor unit�rio no valor esperado
	
	
	cTotalAux	:= STRTRAN(aDadosArq[nX][12], "R$", "")
	cTotalAux	:= STRTRAN(cTotalAux, ".", "")
	cTotalAux	:= STRTRAN(cTotalAux, ",", ".")
	nTotalAux	:= Val(cTotalAux)	
    
	cCPFAux		:= ""
	cCPFAux		:= STRZERO(Val(aDadosArq[nX][6]), TAMSX3("RA_CIC")[1])	
	aVerbTpMov := GetVTipMov(aDadosArq[nX][8])//Busca os dados da verba e o tipo de movimenta��o, de acordo com o codigo do movimento(Arquivo .CSV)
	aDadosFunc := GetMNS(cCPFAux)//Busca os dados do funcionario (Matricula, Nome e Salario) de acordo com o numero do CPF
	
	cCodVerba	:= aVerbTpMov[1]//Codigo da Verba RH
	cTpMov		:= aVerbTpMov[2]//Tipo de Movimento (VA,VT e VR)

	cCodMatric	:= aDadosFunc[1]//Matricula
	cNomeFunc	:= aDadosFunc[2]//Nome do funcionario
	nSalario	:= aDadosFunc[3]//Salario
	nPercAux := 0
	If Alltrim(cTpMov) == "VT" 
		nPercAux := nPerncDesc
		nDescAux := (nSalario * nPerncDesc)/100 //Obtem o valor de desconto do funcionario
		
		//----------------------------------------------------------------------------------
		//Verifica se o valor do desconto (6% do salario) e maior que o valor da nota.     |
		//Se for, ser� considerado o valor da nota                                         |
		//----------------------------------------------------------------------------------
		If nDescAux > nTotalAux
			nDesc		:= nTotalAux//Valor de desconto igual o total da nota
			nCalc		:= 0//Obtem zero pq o funcionario efetuou o pagamento total das despesas
		Else                   
			//Preenche o calculo com o valor da nota - o desconto
			nDesc		:= nDescAux//Valor de desconto
			nCalc		:= nTotalAux - nDescAux //Valor total da nota - o desconto
		EndiF
	Else
		//Se n�o for VT n�o ter� desconto do funcionario		
		nDesc		:= 0
		nCalc		:= nTotalAux
		nPercAux	:= 0     
		
	EndIf
    
    //Pega o valor sequencial da linha
	cSeq := ""
	cSeq := STRZERO(nX, TAMSX3("PX8_SEQ")[1])	
	 
	aMsgErro := {}
	
	//Faz a valida��o dos dados
	If VldLin(cCodImp, cSeq, dDataRef, aDadosArq[nX][2], aDadosArq[nX][3], cCodVerba, nVlUnitAux,;
							 nQtdAux, nTotalAux, nPerncDesc, nCalc, cTpMov, aDadosArq[nX][8], cCPFAux, cCodMatric,cNomeFunc, @aMsgErro)
    
    	//Inclui os dados na tabela PX8 (Importa��o do VT, VA e VR)
		GrvIncVTRA(1,cCodImp, cSeq, dDataRef, aDadosArq[nX][1], aDadosArq[nX][2], aDadosArq[nX][3], cCodVerba, nVlUnitAux,;
							 nQtdAux, nTotalAux, nPercAux, nCalc, cTpMov, aDadosArq[nX][8], cCPFAux, cCodMatric,cNomeFunc, nDesc)
		
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetVTipMov  �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o codigo da verba e o tipo de 					  ���
���          �movimento (VT, VR ou VA)                                    ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/   
Static Function GetVTipMov(cCod)

Local aArea 	:= GetArea()      
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCod := ""

cArqTmp	:= ""                    
cArqTmp	:= GetNextAlias()

cQuery := " SELECT PX9_VERBA, PX9_TPMOV FROM "+RetSqlName("PX9")+" PX9 "
cQuery += " WHERE PX9.D_E_L_E_T_ = ' ' "
cQuery += " AND PX9.PX9_FILIAL = '"+xFilial("PX9")+"' "
cQuery += " AND PX9.PX9_CODIMP = '"+cCod+"' "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	aRet := {(cArqTmp)->PX9_VERBA, (cArqTmp)->PX9_TPMOV}
Else
	aRet := {"",""}
EndIf

//Fecha a tabela temporaria
//If Select("cArqTmp") > 0
	(cArqTmp)->( dbCloseArea() )
//EndIf

RestArea(aArea)
Return aRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetMNS   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para calcular o valor de desconto					  ���
���          �						                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GatCDesc()

Local aArea 		:=GetArea()
Local nRet			:= 0      
Local aDadosFunc	:= {}	         
Local nSalario		:= ""
Local nDescAux		:= 0       
Local nLinha		:= oGetDados:NAT
Local nPosCPF		:= GdFieldPos("PX8_CPF")
Local nPosTpMov		:= GdFieldPos("PX8_TPIMP")
Local nPosQuant		:= GdFieldPos("PX8_QUANT")          
Local nPosVlUnit	:= GdFieldPos("PX8_VLUNIT")

Local nPerncDesc 	:= GetCtParam("NC_PERCDES",;
  										"6",;
										"N",;
										"Informar o percentual de desconto do funcionario",;
										"Informar o percentual de desconto do funcionario",;
										"Informar o percentual de desconto do funcionario",;
										.F. )
        
cTpMov 		:= oGetDados:aCols[nLinha,nPosTpMov]
cCpf		:= oGetDados:aCols[nLinha,nPosCPF]
nTotalAux  	:= oGetDados:aCols[nLinha,nPosVlUnit] * oGetDados:aCols[nLinha,nPosQuant]

aDadosFunc 	:= GetMNS(cCpf)//Busca os dados do funcionario (Matricula, Nome e Salario) de acordo com o numero do CPF
nSalario	:= aDadosFunc[3]//Salario*/

If cTpMov == "VT"
	nDescAux := (nSalario * nPerncDesc)/100 //Obtem o valor de desconto do funcionario
	
	//----------------------------------------------------------------------------------
	//Verifica se o valor do desconto (6% do salario) e maior que o valor da nota.     |
	//Se for, ser� considerado o valor da nota                                         |
	//----------------------------------------------------------------------------------
	If nDescAux > nTotalAux
		nDesc		:= nTotalAux//Valor de desconto igual o total da nota
		nCalc		:= 0//Obtem zero pq o funcionario efetuou o pagamento total das despesas
	Else
		//Preenche o calculo com o valor da nota - o desconto
		nDesc		:= nDescAux//Valor de desconto
		nCalc		:= nTotalAux - nDescAux //Valor total da nota - o desconto
	EndiF 

	nRet := nDesc
EndIf

RestArea(aArea)
Return nRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GatVerVb   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o codigo da verba utilizado na amarra��o			  ���
���          �						                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GatVerVb()

Local aArea := GetArea()
Local nPosCodVB		:= GdFieldPos("PX8_CODVB")
Local nPosTpMov		:= GdFieldPos("PX8_TPIMP")
Local cCodVB		:= ""              
Local cTpMOV		:= ""
Local nLinha		:= oGetDados:NAT
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local cRet			:= ""

cCodVB := oGetDados:aCols[nLinha,nPosCodVB]
cTpMOV := oGetDados:aCols[nLinha,nPosTpMov]

cQuery := "SELECT * FROM "+RetSqlName("PX9")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND PX9_FILIAL = '"+xFilial("PX9")+"' "
cQuery += " AND PX9_CODIMP = '"+cCodVB+"' "
cQuery += " AND PX9_TPMOV = '"+cTpMOV+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())
If (cArqTmp)->(!Eof())
	cRet := (cArqTmp)->PX9_VERBA
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �XVldFunc   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para calcular o valor das despesas				  ���
���          �						                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function XVldFunc(cCodFunc, nInd)

Local aArea := GetArea()
Local lRet	:= .F.

Default cCodFunc := ""        
Default nInd     := 1

DbSelectArea("SRA")
DbSetOrder(nInd)
If SRA->(DbSeek(xFilial("SRA") + cCodFunc))
	lRet := .T.
Else
	Aviso("Cadastro inexistente","C�digo de funcion�rio n�o encontrado ", {"Ok"}, 2)
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �XVldCodVb   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se o codigo VB vs Verba existe para o 			  ���
���          �tipo de movimento		                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function XVldCodVb()

Local aArea := GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local lRet			:= .F.

Local cCodVb	:= M->PX8_CODVB 
Local cTpMov	:= M->PX8_TPIMP

cQuery := "SELECT * FROM "+RetSqlName("PX9")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND PX9_FILIAL = '"+xFilial("PX9")+"' "
cQuery += " AND PX9_CODIMP = '"+cCodVb+"' "
cQuery += " AND PX9_TPMOV = '"+cTpMov+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())
If (cArqTmp)->(!Eof())
	lRet := .T.
Else
	Aviso("Erro na amarra��o Codigo VB vs Verba","A amarra��o do C�digo VB vs Verba, n�o existe para este tipo de movimento", {"Ok"},2)
	lRet := .F.
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GatCalcD   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para calcular o valor das despesas				  ���
���          �						                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GatCalcD()

Local aArea 		:= GetArea()
Local nRet			:= 0      
Local aDadosFunc	:= {}	         
Local nSalario		:= ""
Local nDescAux		:= 0       
Local nLinha		:= oGetDados:NAT
Local nPosCPF		:= GdFieldPos("PX8_CPF")
Local nPosTpMov		:= GdFieldPos("PX8_TPIMP")
Local nPosQuant		:= GdFieldPos("PX8_QUANT")
Local nPosVlUnit	:= GdFieldPos("PX8_VLUNIT")

Local nPerncDesc 	:= GetCtParam("NC_PERCDES",;
  										"6",;
										"N",;
										"Informar o percentual de desconto do funcionario",;
										"Informar o percentual de desconto do funcionario",;
										"Informar o percentual de desconto do funcionario",;
										.F. )
        
cTpMov 		:= oGetDados:aCols[nLinha,nPosTpMov]
cCpf		:= oGetDados:aCols[nLinha,nPosCPF]
nTotalAux  	:= oGetDados:aCols[nLinha,nPosVlUnit] * oGetDados:aCols[nLinha,nPosQuant]

aDadosFunc 	:= GetMNS(cCpf)//Busca os dados do funcionario (Matricula, Nome e Salario) de acordo com o numero do CPF
nSalario	:= aDadosFunc[3]//Salario*/

If cTpMov == "VT"
	nDescAux := (nSalario * nPerncDesc)/100 //Obtem o valor de desconto do funcionario
	
	//----------------------------------------------------------------------------------
	//Verifica se o valor do desconto (6% do salario) e maior que o valor da nota.     |
	//Se for, ser� considerado o valor da nota                                         |
	//----------------------------------------------------------------------------------
	If nDescAux > nTotalAux
		nDesc		:= nTotalAux//Valor de desconto igual o total da nota
		nCalc		:= 0//Obtem zero pq o funcionario efetuou o pagamento total das despesas
	Else
		//Preenche o calculo com o valor da nota - o desconto
		nDesc		:= nDescAux//Valor de desconto
		nCalc		:= nTotalAux - nDescAux //Valor total da nota - o desconto
	EndiF 

	nRet := nCalc
Else
	nRet := nTotalAux
EndIf

RestArea(aArea)
Return nRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GatTotQU   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para calcular o valor total Quantidade * unitario   ���
���          �						                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GatTotQU()

Local aArea 		:=GetArea()
Local nRet			:= 0      
Local nLinha		:= oGetDados:NAT
Local nPosQuant		:= GdFieldPos("PX8_QUANT")
Local nPosVlUnit	:= GdFieldPos("PX8_VLUNIT")

nRet  	:= oGetDados:aCols[nLinha,nPosVlUnit] * oGetDados:aCols[nLinha,nPosQuant]


RestArea(aArea)
Return nRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetMNS   �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna a Matricula, Nome e Salario do funcionario		  ���
���          �de acordo com o CPF	                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldLin�Autor  �Elton C.			 � Data �  05/11/11   	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o da linha do arquivo e/ou inclus�o manual          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldLin(cCodigo, cSeq, cNota, cSerie, cPedido, cVerba, nValUnit,;
							 nQuant, nValTot, nPercetDesc, nCalcDesp, cTpImp, cCodMov, cCPF, cMatricFunc,cNomeFunc, aMsgErro)

Local aArea	:= GetArea()
Local lRet	:= .T.

Default cCodigo		:= "" 
Default cSeq		:= "" 
Default cNota		:= "" 
Default cSerie		:= "" 
Default cPedido		:= "" 
Default cVerba		:= "" 
Default nValUnit 	:= 0
Default nQuant		:= 0
Default nValTot		:= 0 
Default nPercetDesc	:= 0 
Default nCalcDesp	:= 0 
Default cTpImp		:= "" 
Default cCodMov		:= "" 
Default cCPF		:= "" 
Default cMatricFunc	:= ""
Default cNomeFunc	:= ""
Default aMsgErro	:= {}

//Verifica se o codigo de importa��o esta vazio e/ou se o mesmo ja existe no cadastro
If Empty(cCodigo)
	lRet	:= .F.
	Aadd(aMsgErro, "C�digo n�o informado - Linha: "+cSeq)
Else
	DbSelectArea("PX8")
	DbSetOrder(1)
	If PX8->(DbSeek(xFilial("PX8") + PadR(cCodigo,TAMSX3("PX8_CODIMP")[1]) + PadR(cSeq,TAMSX3("PX8_SEQ")[1])))
		lRet	:= .F.
		Aadd(aMsgErro, "O c�digo de importa��o e a sequencia j� existe - Linha: "+cSeq)
	EndIf
EndIf

//Verifica se o numero sequencia existe
If Empty(cSeq)
	lRet	:= .F.
	Aadd(aMsgErro, "Sequnecia n�o informada - Linha: "+cSeq)
EndIf 

//Verifica se a nota foi informada
If Empty(cNota)
	lRet	:= .F.
	Aadd(aMsgErro, "Numero da nota fiscal n�o preenchido - Linha: "+cSeq)
EndIf

//Verifica se o pedido foi preenchido
If Empty(cPedido)
	lRet	:= .F.
	Aadd(aMsgErro, "Numero do pedido n�o preenchido n�o preenchido - Linha: "+cSeq)
EndIf

//Verifica se o pedido foi preenchido
If Empty(cVerba)
	lRet	:= .F.
	Aadd(aMsgErro, "C�digo da verba n�o encontrado - Linha: "+cSeq)
Else
	DbSelectArea("SRV")
	DbSetOrder(1)
	If !SRV->(DbSeek(xFilial("SRV") + cVerba ))
		lRet	:= .F.
		Aadd(aMsgErro, "C�digo da verba n�o encontrado - Linha: "+cSeq)
	EndIf
EndIf

//Verifica se o valor unit�rio foi preenchido
If Empty(nValUnit) .Or. (nValUnit <= 0)
	lRet	:= .F.
	Aadd(aMsgErro, "Valor unit�rio n�o preenchido ou menor e/ou igual a zero - Linha: "+cSeq)
EndIf


//Verifica se o valor unit�rio foi preenchido
If Empty(nQuant) .Or. (nQuant <= 0)
	lRet	:= .F.
	Aadd(aMsgErro, "Quantidade n�o preenchido ou menor e/ou igual a zero - Linha: "+cSeq)
EndIf

//Verifica se o valor total foi preenchido
If Empty(nValTot) .Or. (nValTot <= 0)
	lRet	:= .F.
	Aadd(aMsgErro, "Valor total n�o preenchido ou menor e/ou igual a zero - Linha: "+cSeq)
EndIf

//Verifica se o percentual foi preenchido
If Alltrim(cTpImp) == "VT"
	If Empty(nPercetDesc) .Or. (nPercetDesc <= 0)
		lRet	:= .F.
		Aadd(aMsgErro, "Percentual n�o informado ou menor e/ou igual a zero - Linha: "+cSeq)
	EndIf
Endif

//Verifica se o tipo de movimenta��o foi informado
If Empty(cTpImp)
	lRet	:= .F.
	Aadd(aMsgErro, "Tipo de movimento n�o encontrado - Linha: "+cSeq)
EndIf


//Verifica se o codigo do movimento foi preenchido
If Empty(cCodMov)
	lRet	:= .F.
	Aadd(aMsgErro, "C�digo do movimento n�o preenchido - Linha: "+cSeq)
EndIf

//Verifica se o CPF foi preenchido
If Empty(cCPF)
	lRet	:= .F.
	Aadd(aMsgErro, "CPF n�o preenchido - Linha: "+cSeq)
EndIf

//Verifica se o codigo da matricula foi preenchida
If Empty(cMatricFunc)
	lRet	:= .F.
	Aadd(aMsgErro, " C�digo da matricula n�o encontrado para o CPF: "+cCPF+" (Verifique se o funcion�rio est� com a situa��o normal) - Linha: "+cSeq)
Else
	DbSelectArea("SRA")
	DbSetOrder(1)
	If !SRA->(DbSeek(xFilial("SRA") + cMatricFunc))
		lRet	:= .F.
		Aadd(aMsgErro, " C�digo da matricula n�o encontrado para o CPF: "+cCPF+" - Linha: "+cSeq)
	EndIf
EndIf

RestArea(aArea)

Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvIncVTRA�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o proximo codigo de importa��o 			          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvIncVTRA(nOpc,cCodigo, cSeq, dDtImp, cNota, cSerie, cPedido, cVerba, nValUnit,;
							 nQuant, nValTot, nPercetDesc, nCalcDesp, cTpImp, cCodMov, cCPF, cMatricFunc,cNomeFunc, nDesc)

Local aArea := GetArea()
Local lRet	:= .T.

Default nOpc		:= 0
Default cCodigo		:= "" 
Default cSeq		:= "" 
Default dDtImp		:= CTOD('') 
Default cNota		:= "" 
Default cSerie		:= "" 
Default cPedido		:= "" 
Default cVerba		:= "" 
Default nValUnit 	:= 0
Default nQuant		:= 0
Default nValTot		:= 0 
Default nPercetDesc	:= 0 
Default nCalcDesp	:= 0 
Default cTpImp		:= "" 
Default cCodMov		:= "" 
Default cCPF		:= "" 
Default cMatricFunc	:= ""
Default cNomeFunc	:= ""
Default nDesc		:= 0

//Grava o cabe�alho da importa��o
DbSelectArea("PX7")
DbSetOrder(1)
If !PX7->(DbSeek(xFilial("PX7") + cCodigo))
	
	If Reclock("PX7", .T.)
		PX7->PX7_FILIAL := xFilial("PX7")
		PX7->PX7_CODIMP	:= cCodigo
		PX7->PX7_DTIMP	:= dDtImp
		PX7->PX7_DTDIGT	:= MsDate()
	EndIf
	
EndIf

//Grava os itens da  importa��o
DbSelectArea("PX8")
DbSetOrder(1)
If RecLock("PX8", .T.)
	PX8->PX8_FILIAL := xFilial("PX8")//Filial
	PX8->PX8_CODIMP := cCodigo 		//Codigo da movimenta��o (Numero sequencial nas inclus�es)
	PX8->PX8_SEQ 	:= cSeq 		//Numero sequencial da linha
	PX8->PX8_DTIMP	:= dDtImp 		//Data da importa��o e/ou inclus�o
	PX8->PX8_NOTA	:= cNota		//NUmero da nota fiscal
	PX8->PX8_SERIE	:= cSerie		//serie da nota fiscal
	PX8->PX8_PEDIDO := cPedido		//Numero do pedido
	PX8->PX8_VERBA	:= cVerba		//Codigo da verba para essa movimenta��o
	PX8->PX8_VLUNIT	:= nValUnit		//Valor unitario
	PX8->PX8_QUANT	:= nQuant		//Quantidades solicitada
	PX8->PX8_VLTOT	:= nValTot		//Valor Total
	PX8->PX8_PERDES	:= nPercetDesc	//Percentual de desconto do funcionario
	PX8->PX8_CALCUL	:= nCalcDesp 	//Calculo do valor total - o desconto
	PX8->PX8_TPIMP	:= cTpImp 		//Tipo de movimento (VT,VR ou VA)
	PX8->PX8_CODVB	:= cCodMov		//Codigo do Movimento (Empresa VB)
	PX8->PX8_CPF	:= cCPF 		//cpf do funcionario
	PX8->PX8_MATRIC	:= cMatricFunc	//Codigo da Matricula do funcionario
	PX8->PX8_NOME 	:= cNomeFunc	//Nome do funcionario
	PX8->PX8_vldesc	:= nDesc
	PX8->(MsUnLock())
Else
	lRet	:= .F.
EndIf



RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetCodImp	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o proximo codigo de importa��o 			          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GetCodImp()

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()


cQuery := " SELECT MAX(PX8_CODIMP) PX8_CODIMP FROM "+RetSqlName("PX8")+" PX8 "
cQuery += " WHERE PX8.D_E_L_E_T_ = ' ' "
cQuery += " AND PX8.PX8_FILIAL = '"+xFilial("PX8")+"' "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	cRet := soma1((cArqTmp)->PX8_CODIMP)
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PergFile	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Pergunta com o endere�o do arquivo				          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere�o de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})
aAdd( alParamBox ,{1,"Dt.Refer�ncia"	,MsDate()				,"@!",""		,""		,"",50						,.F.})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Parametros",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetCtParam�Autor  �Elton C.		     � Data �  03/13/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o conteudo do parametro e ou cria o parametro       ���
���          �caso n�o exista                                             ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                              	          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GerPlnErr�Autor  �Elton C.		     � Data �  03/13/09   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gera a o arquivo excel com os erros encontrados             ���
���          �                                          				  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                              	          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GerPlnErr(aDadosErr)
Local aArea := GetArea()     
Local nX	:= 1

Private apExcel		:= {}


MontaExcel(1)
	

For nX := 1 To Len(aDadosErr)
	MontaExcel(2,aDadosErr[nX][1],aDadosErr[nX][2],aDadosErr[nX][3],aDadosErr[nX][4],aDadosErr[nX][5],aDadosErr[nX][6],;
				aDadosErr[nX][7],aDadosErr[nX][8],aDadosErr[nX][9],aDadosErr[nX][10],aDadosErr[nX][11],aDadosErr[nX][12],;
				aDadosErr[nX][13],aDadosErr[nX][14],)
Next

MontaExcel(3)
GeraExcel(apExcel)


RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �MontaExcel �Autor  �Elton C.		     � Data �  11/07/2011 ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que monta o HTML para exportar para o excel          ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MontaExcel(nOpc, cNota, cSerie, cPedido, cMatric, cFunc, cCpf, cSetor, cCodigo, nVlUnit, nTaxa, nQtd, nTotal, cCartao, cMsgErr)

Local aArea  := GetArea()  

Default cNota	:= ""
Default cSerie	:= ""
Default cPedido	:= "" 
Default cMatric	:= "" 
Default cFunc	:= "" 
Default cCpf	:= "" 
Default cSetor	:= "" 
Default cCodigo	:= "" 
Default nVlUnit	:= 0 
Default nTaxa	:= 0 
Default nQtd	:= 0 
Default nTotal	:= 0
Default cCartao	:= "" 
Default	cMsgErr	:= ""

If nOpc = 1 //Abre as tags HTML
	
	AADD(apExcel, '<html>')
	AADD(apExcel, '<body>')
	AADD(apExcel, '<table border="1">')
	AADD(apExcel, '<tr>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Nota Fiscal</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Serie</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Pedido</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Matricula</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Funcionario</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>CPF</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Setor</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Codigo</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Valor Unitario</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Taxa Total</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Quantidade</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Total</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Cartao</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Mensagem Erro</Font></b></td>')
	AADD(apExcel, '</tr>')
	
ElseIf nOpc = 2 // Preenche o dados dos movimentos contabeis
	
	
	
	AADD(apExcel, '<tr>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cNota+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cSerie+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cPedido+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cMatric+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cFunc+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCpf+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cSetor+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCodigo+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+nVlUnit+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+nTaxa+ '</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+nQtd+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+nTotal+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCartao+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cMsgErr+'</Font></td>')
	AADD(apExcel, '</tr>')
	
ElseIf nOpc = 3 //Fecha as tags html
	
	AADD(apExcel, '</table>')
	AADD(apExcel, '</body>')
	AADD(apExcel, '</html>')
	
EndIf


RestArea(aArea)
Return
            
					
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GeraExcel �Autor  �Elton C.		     � Data �  11/07/2011 ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que cria e escreve o arquivo excel.                  ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GeraExcel(alPlanilha)
	
	Local nlHandle
	Local clLocal := ""
	Local clNameArq := "ImportacaoVt_Vr_Va_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
	Local olExcelApp
	Local aPerg	:= PergPlErr()//Pergunta com o endere�o do arquivo
	
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
		MsgStop("N�o foi poss�vel criar o arquivo em: " + CRLF + clLocal)
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PergFile	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Pergunta com o endere�o do arquivo				          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �Catupiry                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergPlErr()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere�o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere�o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  






