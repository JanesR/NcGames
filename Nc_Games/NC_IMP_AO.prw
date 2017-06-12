#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCIMPAO	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Importa��o e/ou manuentencao das despesas referentes ao 	  ���
���          �AO					                                      ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIMPAO()
Local aArea := GetArea()

Local cAliasMB		:= "PX4"

Private cCadastro	:= "Rotina de manuten��o Assis. Odontol�gica"
Private aRotina		:= Menudef()

DbSelectArea("PX4")
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
User Function ManutAO(cAlias, nRecno, nOpc)

Local aArea 	:= GetArea()
Local cTitulo   := ""
Local nOpcE    := nOpc
Local nOpcG    := nOpc
Local cFieldOK  := ""//"U_PR102CpoOK"
Local lVirtual := .T.
Local nLinhas  := 99999
Local nFreeze  := 0
Local aCampos	:= {"PX5_SEQ","PX5_NOTA","PX5_SERIE","PX5_MATRIC","PX5_CPF","PX5_NOME",;
						"PX5_VALOR","PX5_VLDESC","PX5_VLCALC"}
Local aCpoAlter := {"PX5_NOTA","PX5_SERIE","PX5_MATRIC","PX5_VALOR","PX5_VLDESC","PX5_VLCALC"}				  

Private aHeader		 := {}
Private aCols		 := {}                        
Private aCpoEnchoice := {"PX4_CODIMP","PX4_DTIMP"}
Private aAltEnchoice := {"PX4_DTIMP"}
Private aAlt         := {} 
Private oGetDados                        
Private cAlias1	 	 := "PX4"
Private cAlias2		 := "PX5"

// Cria variaveis de memoria dos campos da tabela Pai.
RegToMemory(cAlias1, (nOpc==3))

// Cria variaveis de memoria dos campos da tabela Filho.
RegToMemory(cAlias2, (nOpc==3))

aHeader	:= CriaHeader(aCampos)
aCols	:= CriaAcols(nOpc)

If nOpc == 3//Inclus�o

	cTitulo	:= "Manuten��o Assis. Odontol�gica - Inclus�o"
ElseIf nOpc == 4//Altera��o

	cTitulo	:= "Manuten��o Assis. Odontol�gica - Altera��o"
ElseIf nOpc == 5 //Exclus�o

	cTitulo	:= "Manuten��o Assis. Odontol�gica - Exclus�o"	
EndIf

lRet := U_TelaAO(cTitulo,cAlias1,cAlias2,aCpoEnchoice,/*cLinOk*/,/*cTudoOk*/,nOpcE,nOpcG,/*cFieldOk*/,lVirtual,nLinhas,aAltEnchoice,nFreeze,{},,aCpoAlter)


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
dbSelectArea("PX5")

For i := 1 To Len(aCols)
	
	IncProc()
	
	If !aCols[i][Len(aHeader)+1]       // A linha nao esta deletada, logo, pode gravar.
		
		RecLock("PX5", .T.)
		
		PX5->PX5_FILIAL := xFilial("PX5")
		PX5->PX5_CODIMP := M->PX4_CODIMP
		PX5->PX5_DTIMP	:= M->PX4_DTIMP
		PX5->PX5_DTDIGI	:= dDataBase

		For y := 1 To Len(aHeader)
			FieldPut(FieldPos(Trim(aHeader[y][2])), aCols[i][y])
		Next
		
		PX5->(MSUnlock())
		
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
			//Exclui os dependetes
			ExcDepend(PX5->PX5_CODIMP, PX5->PX5_MATRIC)
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
			(cAlias2)->PX5_FILIAL := xFilial(cAlias2)
			(cAlias2)->PX5_CODIMP := (cAlias1)->PX4_CODIMP
			(cAlias2)->PX5_DTIMP  := (cAlias1)->PX4_DTIMP
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
dbSeek(xFilial(cAlias2) + (cAlias1)->PX4_CODIMP)

While !EOF() .And. ((cAlias2)->PX5_FILIAL == xFilial(cAlias2)) .And. (Alltrim((cAlias2)->PX5_CODIMP) == Alltrim((cAlias1)->PX4_CODIMP))
	IncProc()
	RecLock(cAlias2, .F.)
	dbDelete()
	MSUnlock()
	//Exclui os dependetes
	ExcDepend( Alltrim((cAlias2)->PX5_CODIMP), Alltrim((cAlias2)->PX5_MATRIC) )
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
Local nCols   := 0

nQtdCpo := Len(aHeader)
aCols   := {}
aAlt    := {}

If nOpc == 3       // Inclusao.
	
	AAdd(aCols, Array(Len(aHeader)+1))
	
	For i := 1 To nQtdCpo
		If Alltrim(aHeader[i][2]) == "PX5_SEQ"
			aCols[1][i] := CriaVar(aHeader[i][2])
			aCols[1][i] := "0001"
		Else
			aCols[1][i] := CriaVar(aHeader[i][2])		
		EndIf
	Next
	
	aCols[1][nQtdCpo+1] := .F.
	
Else                           
	
	M->PX4_CODIMP 	:= PX4->PX4_CODIMP
	M->PX4_DTIMP	:= PX4->PX4_DTIMP
	dbSelectArea("PX5")
	dbSetOrder(1)
	dbSeek(xFilial("PX5") + PX4->PX4_CODIMP)
	
	While PX5->(!EOF()) .And. (PX5->PX5_FILIAL == xFilial("PX5")) .And. (Alltrim(PX5->PX5_CODIMP) == Alltrim(PX4->PX4_CODIMP))
		
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

		PX5->(dbSkip())
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
User Function TelaAO(cTitulo,cAlias1,cAlias2,aMyEncho,cLinOk,cTudoOk,nOpcE,nOpcG,cFieldOk,lVirtual,nLinhas,aAltEnchoice,nFreeze,aCordW,nSizeHeader, aCpoAlter)
Local lRet, nOpca := 0,cSaveMenuh,nReg:=(cAlias1)->(Recno()),oDlg
Local aArea 		:= GetArea()
Local nDlgHeight   
Local nDlgWidth
Local nDiffWidth := 0 
Local lMDI := .F.
Local aSize	:= MsAdvSize(.F.,.F.,0)
Local aInfo	:= {}
Local aObjects	:= {}
Local nOpcAux	:= 0
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

//Varival utilizada na rotina de manuten��o do dependente
nOpcDP := nOpcE
aObjects	:= {{ 100, 157 , .T., .T. }}
aInfo		:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 0, 0 }
aPosObj		:= MsObjSize( aInfo, aObjects )


aSize[6] := aSize[6]+30

lMdi := .T.
nDiffWidth := 0

Default nSizeHeader := 110

//Cria Botao paramanuten��o do dependente
Aadd(aButtons, {oBtnDp,"U_MnDmAO()","Dependente","Dependente"})

DEFINE MSDIALOG oDlg TITLE cTitulo From /*aSize[7]*/10, 0 to aSize[6],aSize[5] Pixel of oMainWnd
If lMdi
	oDlg:lMaximized := .T.
EndIf

oEnchoice := Msmget():New(cAlias1,nReg,nOpcE,,,,aMyEncho,{13,1,((nSizeHeader/2)-50),If(lMdi, (aSize[5]/2)-2,__DlgWidth(oDlg)-nDiffWidth)},aAltEnchoice,1,,,,oDlg,,lVirtual,,,,,,,,.T.)       

oGetDados := MsNewGetDados():New((nSizeHeader/2)-15,001,(aSize[6]/2)-30,(aSize[5]/2)-2,nOpcAux ,cLinOk,cTudoOk,"+PX5_SEQ",aCpoAlter,,9999,"AllWaysTrue()",,,,aHeader,aCols)
oGetDados:ForceRefresh()
                                                                   

ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar(oDlg,{||nOpca:=1,If(oGetDados:TudoOk(),If(!obrigatorio(aGets,aTela),nOpca := 0,oDlg:End()),nOpca := 0)},{||oDlg:End()},,aButtons))

lRet:=(nOpca==1)
RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � GatDescAO �Autor  �Elton C.	         � Data �  11/23/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna os dados de desconto por idade para funcionarios    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GatDesAO(cMatric)

Local aArea 	:= GetArea()
Local nRet		:= 0
Local cTbDescAO := GetCtParam("NC_DESCAO",;
  										"S013",;
										"C",;
										"Informar a tabela de desconto AO",;
										"Informar a tabela de desconto AO",;
										"Informar a tabela de desconto AO",;
										.F. ) 

Default cMatric	:= ""

DbSelectArea("SRA")
DbSetOrder(1)
If SRA->(DbSeek(xFilial("SRA") + cMatric))
	nRet := GetDescId(cTbDescAO, cMatric)
EndIf


RestArea(aArea)
Return nRet


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GetDescId � Autor � Elton C.		     � Data �  29/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Rotina utilizada para retornar o valor de desconto         ���
���          � de acordo com a idade do funcionario                       ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function GetDescId(cTabela, cMatricula)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local nRet		:= 0

Default cTabela		:= ""                      
Default cMatricula	:= ""                              

cQuery	:= " SELECT RHK_MAT, RHK_PLANO, "+CRLF
cQuery	+= " 		SUBSTRING(RHK_PLANO,1,2) , "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,35,12) VL_TITULAR, "+CRLF
cQuery	+= "		SUBSTRING(RCC.RCC_CONTEU,93,3) CODFORNEC "+CRLF
cQuery	+= "		FROM "+RetSqlName("RHK")+" RHK "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("RCC")+" RCC "+CRLF
cQuery	+= " ON RCC.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND RCC.RCC_FILIAL = '"+xFilial("RCC")+"' "+CRLF
cQuery	+= " AND RCC.RCC_CODIGO = '"+cTabela+"' "+CRLF
cQuery	+= " AND SUBSTRING(RCC.RCC_CONTEU,1,2) = SUBSTRING(RHK_PLANO,1,2) "+CRLF
cQuery	+= " AND SUBSTRING(RCC.RCC_CONTEU,93,3) = RHK.RHK_CODFOR "+CRLF

cQuery	+= " WHERE RHK.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " 	AND RHK.RHK_FILIAL = '"+xFilial("RHK")+"' "+CRLF
cQuery	+= " 	AND RHK.RHK_MAT = '"+cMatricula+"' "+CRLF
cQuery	+= " 	AND RHK.RHK_PERINI <= '"+DTOS(MsDate())+"' "+CRLF
cQuery	+= "	AND (RHK.RHK_PERFIM = ' ' OR RHK.RHK_PERFIM >= '"+DTOS(MsDate())+"') "+CRLF
cQuery	+= "AND RHK.RHK_TPFORN = '2' "+CRLF

cQuery	:= ChangeQuery( cQuery )   

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	nRet := Val((cArqTmp)->VL_TITULAR)
Else
	nRet := 0	
EndiF

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return nRet



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

Local alRotina := {	{"&Imp.Assis.Odontol�gica"	,"U_ImpPlAO"	,0,3},;
					{"&Visualizar"			,"U_ManutAO"	,0,2},;
					{"&Incluir"				,"U_ManutAO"	,0,3},;					
					{"&Alterar"				,"U_ManutAO"	,0,4},;										
					{"&Excluir"				,"U_ManutAO"	,0,5};										
					}

Return alRotina



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ImpPlAO		�Autor  �ELTON SANTANA	 � Data �  28/09/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para ler o arquivo e efetuar a importa��o  ���
���          �dos dados da planilha	referente o VT, VR e VA		  		  ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ImpPlAO()

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
AAdd(aSays,"referente a Assis. Odontol�gica ...")


AAdd(aBotoes,{ 5,.T.,{|| alPerg := PergFile() 		}} )
AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )        
FormBatch( "[Importa��o de planilha]", aSays, aBotoes )

//Verifica se o parametro com o endere�o do arquivo foi preenchido
If Len(alPerg) > 0

	If alPerg[1]
		If nOpcao == 1
			MsgRun( 'Importando dados...' ,  '', { || LeArqAO(alPerg)} )
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
���Programa  �LeArqAO 	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Leitura do arquiv com a exten��o .CSV                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LeArqAO(aParam)

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
    
	If Len(alLinha) < 12
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
aErroImp := ImpAO(aArquivo, dDtRef) 
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
���Programa  �ImpAO  �Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para efetuar a importa��o do arquivo		  ���
���          �							                                  ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/   
Static Function ImpAO(aDadosArq, dDataRef) 

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
Local cTpUser		:= ""
Local cSeqDepend	:= ""
Local nSeqDp		:= 0
Local cTbDescAO 	:= GetCtParam("NC_DESCAO",;
  										"S013",;
										"C",;
										"Informar a tabela de desconto AO",;
										"Informar a tabela de desconto AO",;
										"Informar a tabela de desconto AO",;
										.F. ) 


Default aDadosArq 	:= {}
Default dDataRef	:= CTOD('')

//Recebe o codigo da importa��o
cCodImp := u_CodImpAO()

//Percorre as linhas do arquivo para efetaur a importa��o
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
	cCPFAux		:= STRZERO(Val(aDadosArq[nX][11]), TAMSX3("RA_CIC")[1])	
	aDadosFunc 	:= GetMNS(cCPFAux)//Busca os dados do funcionario (Matricula, Nome e Salario) de acordo com o numero do CPF
	
	cCodMatric	:= aDadosFunc[1]//Matricula
	cNomeFunc	:= aDadosFunc[2]//Nome do funcionario e/ou dependente
	
	cValor	:= STRTRAN(aDadosArq[nX][6], "R$", "")
	cValor	:= STRTRAN(cValor, ".", "")
	cValor	:= STRTRAN(cValor, ",", ".")
	nValor	:= Val(cValor)//Valor da transa��o
	
	nDesc		:= GetDescId(cTbDescAO, cCodMatric)//Verifica o valor do desconto
	nCalc		:= nValor - nDesc

	 
	aMsgErro := {}
	
	//Faz a valida��o dos dados
		//VldLin(cCodImp,dDataRef, cSeq, cNota, cCPF, cMatric, cNomeFun, nValor, nValDesc, nVlCalc)
	If VldLin(cCodImp,dDataRef, Alltrim(Str(nX)), aDadosArq[nX][1], cCPFAux, cCodMatric, cNomeFunc,;
				  nValor, nDesc, nCalc, @aMsgErro, SubStr(Alltrim(aDadosArq[nX][5]),1,1))

        //Pega o valor sequencial da linha
		cSeq := ""
		++nSeq
		cSeq := STRZERO(nSeq, TAMSX3("PX5_SEQ")[1])	

    
    	//Inclui os dados nas tabelas PX4 e PX5
		//GrvImpAO(cCodigo,dDtImp, cSeq, cNota, cCPF, cMatric, cNomeFun, nIdade, nValor, nValDesc, nVlCalc )
		GrvImpAO(cCodImp,dDataRef, cSeq, aDadosArq[nX][1], cCPFAux, cCodMatric, cNomeFunc,;
					 nValor, nDesc, nCalc )
					 
					 
        //Grava os dados do Dependente na tabela PX5
    	If (nX + 1) <= Len(aDadosArq)
    	    If SubStr(Alltrim(aDadosArq[nX+1][5]),1,1) != 'T'
   		  		nSeqDp 		:= 0
   		  		cSeqDepend  := ""
   		  		For nX := nX+1 To Len(aDadosArq)
    		    	If SubStr(Alltrim(aDadosArq[nX][5]),1,1) != 'T'

						cValor	:= STRTRAN(aDadosArq[nX][6], "R$", "")
						cValor	:= STRTRAN(cValor, ".", "")
						cValor	:= STRTRAN(cValor, ",", ".")
						nValor	:= Val(cValor)//Valor da transa��o
					
      					cCPFAux		:= ""
						cCPFAux		:= STRZERO(Val(aDadosArq[nX][11]), TAMSX3("RA_CIC")[1])	

                        If nValor > 0
		    		    	++nSeqDp
    				    	cSeqDepend := STRZERO(nSeqDp, TAMSX3("PX5_SEQ")[1])
							
							//GrvImpAMDp(cCODIMP, cSEQ, dDTMP, dDTDIGI, cNOTA, cSERIE, cCPF, cMATRIC, cNOME, nIDADE, nVALOR, lDel)                            

	    		   		  	//Chama a rotina para gravar os dependentes
	    		    		GrvImpAMDp(cCodImp, cSeqDepend, dDataRef,, aDadosArq[nX][1],, cCPFAux,;
    			    					 cCodMatric, aDadosArq[nX][2],nValor, .F.)
    			    					 
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CodImpAO	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o proximo codigo de importa��o 			          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CodImpAO()

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()


cQuery := " SELECT MAX(PX4_CODIMP) PX4_CODIMP FROM "+RetSqlName("PX4")+" PX4 "
cQuery += " WHERE PX4.D_E_L_E_T_ = ' ' "
cQuery += " AND PX4.PX4_FILIAL = '"+xFilial("PX4")+"' "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	cRet := soma1((cArqTmp)->PX4_CODIMP)
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
Static Function VldLin(cCodigo,dDtImp, cSeq, cNota, cCPF, cMatric, cNomeFun, nValor, nValDesc, nVlCalc, aMsgErro, cTpUser)

Local aArea	:= GetArea()
Local lRet	:= .T.

Default cCodigo		:= ""
Default dDtImp		:= CTOD('') 
Default cSeq		:= "" 
Default cNota		:= "" 
Default cCPF		:= "" 
Default cMatric		:= "" 
Default cNomeFun	:= "" 
Default nValor		:= 0 
Default nValDesc	:= 0
Default nVlCalc		:= 0
Default aMsgErro	:= {}                                                                        
Default cTpUser		:= ""


//Verifica se o numero sequencia existe
If Empty(cSeq)
	lRet	:= .F.
	Aadd(aMsgErro, "Sequnecia n�o informada - Linha: "+cSeq)
EndIf 

If Empty(cCodigo)
	Aadd(aMsgErro, "C�digo n�o informado - Linha: "+cSeq)
Else
	DbSelectArea("PX4")
	DbSetOrder(1)
	If PX4->(DbSeek(xFilial("P0G") + PadR(cCodigo,TAMSX3("PX5_CODIMP")[1]) + PadR(cSeq,TAMSX3("PX5_SEQ")[1])))
		lRet	:= .F.
		Aadd(aMsgErro, "O c�digo de importa��o e a sequencia j� existe - Linha: "+cSeq)
	EndIf
EndIf                

//Verifica se a nota foi informada
If Empty(cNota)
	lRet	:= .F.
	Aadd(aMsgErro, "Numero da nota fiscal n�o preenchido - Linha: "+cSeq)
EndIf

//Verifica se o valor unit�rio foi preenchido
If (Empty(nValor) .Or. (nValor <= 0)) 
	lRet	:= .F.
	Aadd(aMsgErro, "Valor n�o preenchido ou menor que zero - Linha: "+cSeq)
EndIf


//Verifica se o CPF foi preenchido
If (Empty(cCPF))
	lRet	:= .F.
	Aadd(aMsgErro, "CPF n�o preenchido - Linha: "+cSeq)
EndIf


//Verifica se o codigo da matricula foi preenchida
If (Empty(cMatric)) .And. (cTpUser == "T")
	lRet	:= .F.
	Aadd(aMsgErro, " C�digo da matricula n�o encontrado para o CPF: "+cCPF+" - Linha: "+cSeq)
ElseIf (cTpUser == "T")
	
	DbSelectArea("SRA")
	DbSetOrder(1)
	If !SRA->(DbSeek(xFilial("SRA") + cMatric))
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
���Programa  �GrvImpAO�	Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava os dados da movimenta��o		 			          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvImpAO(cCodigo,dDtImp, cSeq, cNota, cCPF, cMatric, cNomeFun, nValor, nValDesc, nVlCalc )

Local aArea := GetArea()
Local lRet	:= .T.

Default cCodigo		:= ""
Default dDtImp		:= CTOD('')
Default cSeq		:= "" 
Default cNota		:= "" 
Default cCPF		:= "" 
Default cMatric		:= "" 
Default cNomeFun	:= "" 

Default nValor		:= 0 
Default nValDesc	:= 0 
Default nVlCalc		:= 0

DbSelectArea("PX4")
DbSetOrder(1)
If !PX4->(DbSeek(xFilial("PX4") + cCodigo))
	
	If RECLOCK("PX4", .T.)
		PX4->PX4_FILIAL := xFilial("PX4")
		PX4->PX4_CODIMP := cCodigo 
		PX4->PX4_DTIMP 	:= dDtImp
		PX4->PX4_DTDIGI := MsDate()
	Else
		lRet	:= .F.
	EndIF
EndIf


DbSelectArea("PX5")
DbSetOrder(1)
If RecLock("PX5", .T.)
	PX5->PX5_FILIAL	:= xFilial("PX5")
	PX5->PX5_CODIMP := cCodigo
	PX5->PX5_DTIMP  := dDtImp
	PX5->PX5_DTDIGI := MsDate()
	PX5->PX5_SEQ    := cSeq
	PX5->PX5_NOTA   := cNota
	PX5->PX5_SERIE  := ""
	PX5->PX5_CPF    := cCPF
	PX5->PX5_MATRIC := cMatric
	PX5->PX5_NOME   := cNomeFun
	PX5->PX5_VALOR  := nValor
	PX5->PX5_VLDESC := nValDesc
	PX5->PX5_VLCALC := nVlCalc
Else
	lRet	:= .F.
EndIf	    

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetAOImp	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o proximo codigo de importa��o 			          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GetAOImp()

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()


cQuery := " SELECT MAX(PX4_CODIMP) PX4_CODIMP FROM "+RetSqlName("PX4")+" PX4 "
cQuery += " WHERE PX4.D_E_L_E_T_ = ' ' "
cQuery += " AND PX4.PX4_FILIAL = '"+xFilial("PX4")+"' "

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp,.T.,.F.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	cRet := soma1((cArqTmp)->PX4_CODIMP)
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
	MontaExcel(2, aDadosErr[nX][1], aDadosErr[nX][2], aDadosErr[nX][3], aDadosErr[nX][4], aDadosErr[nX][5],;
				 aDadosErr[nX][6], aDadosErr[nX][7], aDadosErr[nX][8], aDadosErr[nX][9], aDadosErr[nX][10], aDadosErr[nX][11], aDadosErr[nX][12], aDadosErr[nX][13])
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
Static Function MontaExcel(nOpc, cNota, cAssociado, cDtInc, cPlano, cParentesco, cValor, cMatricula, cDepto, cSomaTit, cDtNasc, cCpf, cOdonto, cMsgErr)

Local aArea  := GetArea()  

Default cNota		:= ""
Default cAssociado	:= ""
Default cDtInc      := ""
Default cPlano	    := ""
Default cParentesco	:= ""
Default cValor	    := ""
Default cMatricula	:= ""
Default cDepto      := ""
Default cSomaTit    := ""
Default cDtNasc     := ""
Default cCpf        := ""
Default cOdonto     := ""
Default cMsgErr     := ""

If nOpc = 1 //Abre as tags HTML
	
	AADD(apExcel, '<html>')
	AADD(apExcel, '<body>')
	AADD(apExcel, '<table border="1">')
	AADD(apExcel, '<tr>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>nota fiscal</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Associado</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Data Inclus�o</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Plano</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Parentesco</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Valor</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Matricula</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Departamento</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Soma Titular</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Data Nascimento</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Cpf</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Numero Odonto</Font></b></td>')
	AADD(apExcel, '<td BgColor=#2293FF ;ALIGN=CENTER><font face=Arial color=WHITE size=2><b>Msg. Erro</Font></b></td>')
	AADD(apExcel, '</tr>')
	
ElseIf nOpc = 2 // Preenche o dados dos movimentos contabeis

	AADD(apExcel, '<tr>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cNota+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cAssociado+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cDtInc+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cPlano+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cParentesco+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cValor+'</Font></td>') 
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cMatricula+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cDepto+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cSomaTit+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cDtNasc+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cCpf+'</Font></td>')
	AADD(apExcel, '<td><font face=Arial color=black size=1>'+cOdonto+'</Font></td>')
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
	Local clNameArq := "Importacao_AO_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
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
���Uso       �NC	                                                      ���
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





//------------------------------------------------------------------Mnuten��o do Dependente -----------------------------------------------------------------



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �MnDmAO	  � Autor �Elton C.		        � Data �15/12/11  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Tela para amarra��o do centro de Custo x Aprovador		  ���
���			 �															  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MnDmAO()

Local aArea 		:= GetArea()
Local oDlgDp     		:= Nil
Local aColsDepend	:= {}
Local aHeaderDp		:= {}
Local aCampos		:= {"PX6_SEQ","PX6_CPF","PX6_NOME", "PX6_VALOR"}//Campos da pergunta
Local aCpoAlter		:= {"PX6_CPF","PX6_NOME", "PX6_VALOR"}//Campos da pergunta
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
aColsDepend	:= CAcolsDp(M->PX4_CODIMP, ogetdados:Acols[ogetdados:nAt][GdFieldPos("PX5_MATRIC")], aHeaderDp)
DEFINE MSDIALOG oDlgDp TITLE "Dependente" FROM 001, 001  TO 300, 780 COLORS 0, 16777215 PIXEL

oGetAlt := MsNewGetDados():New(013,000,151,390,nOpcAux,,,"+PX6_SEQ",aCpoAlter,/*freeze*/,50,/*fieldok*/,/*superdel*/,/*delok*/,oDlgDp,aHeaderDp,aColsDepend)
oGetAlt:ForceRefresh()

//Botoes com as op��es de gravar os dados incluidos e botao para sair da rotina
Aadd(aBotoes, {oBtnGrv,"SALVAR","Salvar","Salva dependente",{|| GrvDp(oGetAlt,aHeaderDp), oDlgDp:End() } })
Aadd(aBotoes, {oBtnSair,"FINAL","Sair","Sair",{||oDlgDp:End() } })


ACTIVATE MSDIALOG oDlgDp CENTERED  ON INIT BtnBar( oDlgDp, aBotoes)


RestArea(aArea)
Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �BtnBar	  � Autor �Elton C.		        � Data �15/12/11  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Monta os botoes a serem utilizados com enchoicebar		  ���
���			 �															  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CAcolsDp  �Autor  �DBM                 � Data �  11/09/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria vetor aCols da GETDADOS                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
	
dbSelectArea("PX6")
dbSetOrder(1)
dbSeek(xFilial("PX6") + PADR(cCodImp,TAMSX3("PX6_CODIMP")[1]) + PADR(cMatric, TAMSX3("PX6_MATRIC")[1]))

If !Empty(cCodImp) .And. !Empty(cMatric)

	While PX6->(!EOF()) ;
			.And. (PX6->PX6_FILIAL == xFilial("PX6"));
			.And. (Alltrim(PX6->PX6_CODIMP) == Alltrim(cCodImp));
			.And. (Alltrim(PX6->PX6_MATRIC) == Alltrim(cMatric))
		
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
		
		PX6->(dbSkip())
	EndDo
	
	If Len(aRet) <= 0
		AAdd(aRet, Array(Len(aHeaderDp)+1))
		
		For i := 1 To nQtdCpo
			If Alltrim(aHeaderDp[i][2]) == "PX6_SEQ"
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvDp		�	Autor  �Elton C.		 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Chama a rotina de grava��o dos dependentes				  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvDp(oGetDadosDp, aHeaderDp)

Local aArea 	:= GetArea()
Local nAt		:= ogetdados:nAt
Local nPosNota	:= GdFieldPos("PX5_NOTA") 	
Local nPosSerie	:= GdFieldPos("PX5_SERIE")	
Local nMatric	:= GdFieldPos("PX5_MATRIC")
Local cCodImp	:= M->PX4_CODIMP
Local nX		:= 0

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
				 oGetDadosDp:Acols[nX][4],;//Valor
				 oGetDadosDp:Acols[nX][Len(aHeaderDp)+1]  )//Verifica se e item deletado
Next


RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvImpAMDp�	Autor  �Elton C.		 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava os dados do dependente.Rotina utilizada na importa��o.���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvImpAMDp(cCODIMP, cSEQ, dDTMP, dDTDIGI, cNOTA, cSERIE, cCPF, cMATRIC, cNOME, nVALOR, lDel)

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
Default nVALOR	:= 0
Default lDel	:= .F.

DbSelectArea("PX6")
DbSetOrder(1)    

//Verifica se ser� altera��o
If DbSeek(xFilial("PX6") + PADR(cCODIMP,TAMSX3("PX6_CODIMP")[1]) ;
				+ PADR(cMATRIC,TAMSX3("PX6_MATRIC")[1]) ;
				+ PADR(cSEQ,TAMSX3("PX6_SEQ")[1]);
				 )
    
	If !lDel
		RECLOCK("PX6",.F.)

		PX6_FILIAL	:= xFilial("PX6")
		PX6_CODIMP  := cCODIMP
		PX6_SEQ     := cSEQ
		PX6_DTMP    := dDTMP
		PX6_DTDIGI  := dDTDIGI
		PX6_NOTA    := cNOTA
		PX6_SERIE   := cSERIE
		PX6_CPF     := cCPF
		PX6_MATRIC  := cMATRIC
		PX6_NOME    := cNOME
		PX6_VALOR	:= nVALOR
			
		PX6->(MsUnLock())
	Else
		//Exclus�o
		RECLOCK("PX6",.F.)	
		PX6->(DbDelete())
		PX6->(MsUnLock())
	EndiF
Else
	//Inclus�o
	RECLOCK("PX6",.T.)

	PX6_FILIAL	:= xFilial("PX6")
	PX6_CODIMP  := cCODIMP
	PX6_SEQ     := cSEQ
	PX6_DTMP    := dDTMP
	PX6_DTDIGI  := dDTDIGI
	PX6_NOTA    := cNOTA
	PX6_SERIE   := cSERIE
	PX6_CPF     := cCPF
	PX6_MATRIC  := cMATRIC
	PX6_NOME    := cNOME
	PX6_VALOR	:= nVALOR
		
	PX6->(MsUnLock())


EndIf

RestArea(aArea)
Return     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExcDepend�	Autor  �Elton C.		 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava os dados do dependente.Rotina utilizada na importa��o.���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExcDepend(cCodImp, cMatric)

Local aArea := GetArea()

DbSelectArea("PX6")
DbSetOrder(1)    
If DbSeek(xFilial("PX6") + PADR(cCODIMP,TAMSX3("PX6_CODIMP")[1]) ;
				+ PADR(cMATRIC,TAMSX3("PX6_MATRIC")[1]) ;
				 )
	
	//Exclui todos os dependente	
	While PX6->(!Eof()) .And. (Alltrim(PX6->PX6_CODIMP) == Alltrim(cCodImp)) .And. Alltrim(PX6->PX6_MATRIC) == Alltrim(cMatric)
		RECLOCK("PX6",.F.)	
		PX6->(DbDelete())
		PX6->(MsUnLock())
		
		PX6->(DbSkip())
	EndDo
EndiF


RestArea(aArea)
Return


