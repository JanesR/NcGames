#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NFSELSF2 º Autor ³ Rodrigo Okamoto    º Data ³  18/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ ROTINA PARA SELEÇÃO DE NOTAS NO SF2.                       º±±
±±º          ³ IMPRESSÃO PICKLIST (NFatr10A)                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC GAMES / LOGISTICA                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NFSELSF2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cArqInd 	:= CriaTrab(,.F.)		//Nome do arq. temporario
Private nIndex	:= 0					//Indice do arq. temporario a ser utilizado
Private cString   := "SF2"
Private aArea    := GetArea()
Private cMarca    := getmark()
Private cCadastro := "Controle de Despacho"
Private aRotina 

	aRotina := {{ OemToAnsi("Pesquisar")		,"AxPesqui"  	,0,1},;
	{ OemToAnsi("PickList")						,"U_NFatr05A(cMarca)"	,0,4,20},;
	{ OemToAnsi("PickList Aglutinado")			,"U_NFatr10A(cMarca)"	,0,4,20}}
	cCadastro := "Impressão de Pick List"
	cQuery:=""

//DESMARCA TODOS OS REGISTROS ANTES DE ABRIR A MARKBROWSE
/*Private nRecno := Recno()
cQry:="F2_MARK<>'  '"
dbSelectArea('SF2')
IndRegua("SF2",cArqInd,IndexKey(),,cQry)
nIndex := RetIndex("SF2")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
While !Eof()
	RecLock('SF2',.F.)
	REPLACE SF2->F2_MARK WITH SPACE(2)
	MsUnLock()
	dbSkip()
End
dbGoto( nRecno )
dbSelectArea("SF2")
RetIndex("SF2")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())*/

//SELECIONA OS REGISTROS E ABRE A MARK BROWSE
dbSelectArea("SF2")
IndRegua("SF2",cArqInd,IndexKey(),,cQuery)
nIndex := RetIndex("SF2")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
If ( !Eof() .AND. !Bof() )
	MarkBrow("SF2","F2_MARK",,,,cMarca)
Else
	Help(" ",1,"REGNOIS")
EndIf
dbSelectArea("SF2")
RetIndex("SF2")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())

//DESMARCA TODOS OS REGISTROS MARCADOS ANTES DE FECHAR A MARKBROWSE
Private nRecno := Recno()
cQry:="F2_MARK == cMarca"
dbSelectArea('SF2')
IndRegua("SF2",cArqInd,IndexKey(),,cQry)
nIndex := RetIndex("SF2")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
While !Eof()
	RecLock('SF2',.F.)
	REPLACE SF2->F2_MARK WITH SPACE(2)
	MsUnLock()
	dbSkip()
End
dbGoto( nRecno )
dbSelectArea("SF2")
RetIndex("SF2")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())


Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ NFatr10A  ³ Autor ³IMFOC                  ³ Data ³ 22.11.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pick-List aglutinado (Expedicao) NC Games                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ NC Games                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NFatr10A(cMarca)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel     := "NFatr10A"
LOCAL tamanho	:= "G"
LOCAL titulo    := OemToAnsi("Pick-List Aglutinado (Expedicao)")
LOCAL cDesc1    := OemToAnsi("Emiss„o de produtos a serem separados pela expedicao, para")
LOCAL cDesc2    := OemToAnsi("notas fiscais selecionadas.")
LOCAL cDesc3	:= ""
LOCAL cString	:= "SD2"
LOCAL cPerg  	:= ""

PRIVATE aReturn         := {"Zebrado", 1,"Administracao", 2, 2, 1, "",0 }
PRIVATE nomeprog	:= "NFatr10A"
PRIVATE nLastKey 	:= 0
PRIVATE nBegin		:= 0
PRIVATE aLinha		:= {}
PRIVATE li			:= 80
PRIVATE limite		:= 132
PRIVATE lRodape		:= .F.
PRIVATE m_pag       :=1
PRIVATE cMark		:= cMarca        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                      ³
//³ mv_par01	     	  Da Nota                             ³
//³ mv_par02	     	  Ate a Nota                          ³
//³ mv_par03	     	  Serie	                              ³
//³ mv_par04	     	  Mascara                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Sx1
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//AjustaSX1(cPerg)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//pergunte(cPerg,.F.)


wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho,,.T.)

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| C775Imp(@lEnd,wnRel,cString,cPerg,tamanho,@titulo,@cDesc1,;
@cDesc2,@cDesc3)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C775IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR775			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C775Imp(lEnd,WnRel,cString,cPerg,tamanho,titulo,cDesc1,cDesc2,;
cDesc3)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cabec1     := OemToAnsi("         Codigo           Desc. do Material                                                        Cod. Barra      UM   Quantidade       Endreço 1       Endereço 2   Armz.")
LOCAL cabec2	 := ""
LOCAL lContinua  := .T.
LOCAL lFirst 	 := .T.
LOCAL cPedAnt	 := ""
LOCAL nI		 := 0
LOCAL aTam    	 := {}
LOCAL cMascara 	 := GetMv("MV_MASCGRD")
LOCAL nTamRef  	 := Val(Substr(cMascara,1,2))
LOCAL cbtxt      := SPACE(10)
LOCAL cbcont	 := 0
LOCAL nTotQuant	 := 0
LOCAL aStruSD2   := {}
LOCAL nSD2       := 0
LOCAL cFilter    := ""
LOCAL cAliasSD2  := "SD2"
LOCAL cIndexSD2  := ""
LOCAL cKey 	     := ""
Local _cDoc      := ""
LOCAL lQuery     := .F.
LOCAL lRet       := .T.
LOCAL cProdRef	 := ""
LOCAL lSkip		 := .F.
LOCAL cCodProd 	 := ""
LOCAL nQtdIt   	 := 0
LOCAL cDescProd	 := ""
LOCAL cGrade   	 := ""
LOCAL cUnidade 	 := ""
LOCAL cLocaliza	 := ""
LOCAL cLote	 	 := ""
LOCAL cLocal 	 := ""
LOCAL cSubLote   := ""
LOCAL dDtValid   := dDatabase
Local nPos       := 0
Local aLista     := {}
Local aLista2    := {}
Local nX         := 0
Local _cGrupo    := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li := 80
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi("PICK-LIST AGLUTINADO")
//XXXXXXXXXXXXXXX X----------------------------X XX 999,999.99  99  XXXXXXXXXXXXXXX
//0        1         2         3         4         5         6         7         8
//012345678901234567890123456789012345678901234567890123456789012345678901234567890
#IFDEF TOP
	If TcSrvType() <> "AS/400"
		cAliasSD2:= "C775Imp"
		aStruSD2  := SD2->(dbStruct())
		lQuery    := .T.
		
		/*cQuery := "SELECT SD2.R_E_C_N_O_ SD2REC,"
		cQuery += "SD2.D2_DOC,SD2.D2_FILIAL,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_SERIE,SD2.D2_QUANT,SD2.D2_COD, "
		cQuery += "SD2.D2_LOCAL,SD2.D2_GRADE,SD2.D2_LOTECTL, "
		cQuery += "SD2.D2_NUMLOTE,SD2.D2_DTVALID "
		cQuery += "FROM "
		cQuery += RetSqlName("SD2") + " SD2 "
		cQuery += "WHERE "
		cQuery += "(SD2.D2_SERIE = '"+mv_par03+"' OR SD2.D2_QUANT > 0) AND "
		cQuery += "SD2.D2_DOC >= '"+mv_par01+"' AND "
		cQuery += "SD2.D2_DOC <= '"+mv_par02+"' AND "
		cQuery += "SD2.D2_CLIENTE >= '"+mv_par05+"' And "
		cQuery += "SD2.D2_CLIENTE <= '"+mv_par06+"' and "
		cQuery += "SD2.D2_FILIAL = '"+xFilial("SD2")+"' AND "
		cQuery += "SD2.D_E_L_E_T_ = ' ' "
		cQuery += "ORDER BY SD2.D2_FILIAL,SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_COD,SD2.D2_LOTECTL,"
		cQuery += "SD2.D2_NUMLOTE,SD2.D2_DTVALID"*/

		cQuery := "SELECT SD2.R_E_C_N_O_ SD2REC,"
		cQuery += "SD2.D2_DOC,SD2.D2_FILIAL,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_SERIE,SD2.D2_QUANT,SD2.D2_COD, "
		cQuery += "SD2.D2_LOCAL,SD2.D2_GRADE,SD2.D2_LOTECTL, SD2.D2_NUMLOTE,SD2.D2_DTVALID,SD2.D2_PEDIDO, SF2.F2_MARK "
		cQuery += "FROM SD2010 SD2, SF2010 SF2 "
		cQuery += "WHERE SD2.D2_QUANT > 0 AND SD2.D2_DOC = SF2.F2_DOC AND "
		cQuery += "SD2.D2_SERIE = SF2.F2_SERIE AND SD2.D2_FILIAL = SF2.F2_FILIAL AND "
		cQuery += "SF2.F2_MARK = '"+cMark+"' AND SD2.D_E_L_E_T_ = ' '  AND SF2.D_E_L_E_T_ = ' ' "
		cQuery += "ORDER BY SD2.D2_FILIAL,SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_COD,SD2.D2_LOTECTL, "
		cQuery += "SD2.D2_NUMLOTE,SD2.D2_DTVALID"		
		cQuery := ChangeQuery(cQuery)		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD2,.T.,.T.)

		For nSD2 := 1 To Len(aStruSD2)
			If aStruSD2[nSD2][2] <> "C" .and.  FieldPos(aStruSD2[nSD2][1]) > 0
				TcSetField(cAliasSD2,aStruSD2[nSD2][1],aStruSD2[nSD2][2],aStruSD2[nSD2][3],aStruSD2[nSD2][4])
			EndIf
		Next nSD2
	Endif
#ELSE
	dbSelectArea(cString)
	cIndexSD2  := CriaTrab(nil,.f.)
	cKey :="D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_LOTECTL+D2_NUMLOTE+DTOS(D2_DTVALID)"
	cFilter := "D2_FILIAL = '" + xFilial("SD2") + "' .And. "
	cFilter += "D2_QUANT > 0 .And. "
	cFilter += "D2_CLIENTE >= '"      "' .And. "
	cFilter += "D2_CLIENTE <= '"ZZZ"' "
/*	cFilter += "D2_DOC >= '"+mv_par01+"' .And. "
	cFilter += "D2_DOC <= '"+mv_par02+"'"*/
	
	IndRegua(cAliasSD2,cIndexSD2,cKey,,cFilter,"Selecionando Registros...")
	#IFNDEF TOP
		DbSetIndex(cIndexSD2+OrdBagExt())
	#ENDIF
	SetRegua(RecCount())		// Total de Elementos da regua
	DbGoTop()
#ENDIF

DbGoTop()
SetRegua(RecCount())		// Total de Elementos da regua

While (cAliasSD2)->(!Eof())
	
/*	If !(cAliasSD2)->D2_DOC $ MV_PAR07+"/"+MV_PAR08 .and. !Empty(MV_PAR07+MV_PAR08)
		dbSelectArea(cAliasSD2)
		dbSkip()
		Loop
	EndIf*/
	
	//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	³ Valida o produto conforme a mascara         ³
	//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//	lRet:=ValidMasc((cAliasSD2)->D2_COD,MV_PAR04)
//	If lRet .and. !Empty(aReturn[7])
//		lRet := &(aReturn[7])
//	Endif
	
	IncRegua()
	
	If lRet
		
		dbSelectArea("SB1")
		dbSeek(xFilial("SB1") + (cAliasSD2)->D2_COD)
		dbSelectArea("SBM")
		dbSetOrder(1)
		dbSeek(xFilial("SBM") + SB1->B1_GRUPO)
		dbSelectArea("SB2")
		dbSeek(xFilial("SB2") + (cAliasSD2)->D2_COD + (cAliasSD2)->D2_LOCAL )
		dbSelectArea("SA1")
		dbSeek(xFilial("SA1") + (cAliasSD2)->D2_CLIENTE+ (cAliasSD2)->D2_LOJA)
		dbSelectArea("SF2")
		dbSetOrder(1)
		dbSeek(xFilial("SF2") +(cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA)
		dbSelectArea("SA4")
		dbSetOrder(1)
		dbSeek(xFilial("SA4") + SF2->F2_TRANSP)
		
		
		
		

		
		cCodProd := (cAliasSD2)->D2_COD
		cCodBAR  := SB1->B1_CODBAR
		nQtdIt   := (cAliasSD2)->D2_QUANT
		//cDescProd:= Subs(SB1->B1_DESC,1,70)
		cDescProd:= Subs(SB1->B1_XDESC,1,70)
		cGrade   := (cAliasSD2)->D2_GRADE
		cUnidade := SB1->B1_UM
		cLocaliza:= SB2->B2_LOCALIZ
		//_cLocEnd2:= ""
		_cLocEnd2:= SB2->B2_LOCALI2
		cLote	 := (cAliasSD2)->D2_LOTECTL
		cLocal 	 := (cAliasSD2)->D2_LOCAL
		cSubLote := (cAliasSD2)->D2_NUMLOTE
		dDtValid := (cAliasSD2)->D2_DTVALID
		cGrupo   :=  SB1->B1_GRUPO
		cDescGrup:=  SBM->BM_DESC
		cVendedor:= GETADVFVAL("SA3","A3_NOME",xFilial("SA3")+GETADVFVAL("SC5","C5_VEND1",xFilial("SC5")+(cAliasSD2)->D2_PEDIDO,1,""),1,"")   

		
		//
		// Agrupando pelo Codigo do produto
		//
		nPos := aScan(aLista,{|x| AllTrim(x[1])==Alltrim(cCodProd)})
		
		If nPos = 0
			aadd(aLista,{cCodProd,;
			cCodBAR,;
			nQtdIt,;
			cDescProd,;
			cGrade,;
			cUnidade,;
			cLocaliza,;
			_cLocEnd2,;
			cLote,;
			cLocal,;
			cSubLote,;
			dDtValid,;
			cGrupo,;
			cDescGrup})
		Else
			aLista[nPos][3] += nQtdIt
		Endif
		
		nPos2 := aScan(aLista2,{|x| AllTrim(x[1])==(cAliasSD2)->D2_DOC})
		
		If nPos2 = 0
			aadd(aLista2,{(cAliasSD2)->D2_DOC,;
			(cAliasSD2)->D2_CLIENTE,;
			SA1->A1_NOME,;
			SA1->A1_EST,;
			SA4->A4_NOME,;
			cVendedor})
		Endif
		
		
	EndIf
	
	dbSelectArea(cAliasSD2)
	dbSkip()
	
End

//
// Ordenando pelo Grupo e Descricao do Produto
//
aSort(aLista, , , {|x,y| x[13]+x[1] < y[13]+y[1]})

aSort(aLista2, , , {|x,y| x[1] < y[1]})

//
// Impressao do Documento
//
lFirst := .T.

SetRegua(len(aLista))		// Total de Elementos da regua

For nX := 1 to Len(aLista)
	
	
	cCodProd  := aLista[nX][01]
	cCodBAR   := aLista[nX][02]
	nQtdIt    := aLista[nX][03]
	cDescProd := aLista[nX][04]
	cGrade    := aLista[nX][05]
	cUnidade  := aLista[nX][06]
	cLocaliza := aLista[nX][07]
	_cLocEnd2 := aLista[nX][08]
	cLote     := aLista[nX][09]
	cLocal    := aLista[nX][10]
	cSubLote  := aLista[nX][11]
	dDtValid  := aLista[nX][12]
	cGrupo    := aLista[nX][13]
	cDescGrup := aLista[nX][14]
	
	
	IF lEnd
		@PROW()+1,001 Psay "CANCELADO PELO OPERADOR"
		lContinua := .F.
		Exit
	Endif
	
	IF li > 55 .or. lFirst
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	Endif
	
	
	If  _cGrupo <> cGrupo .or. lFirst
		lFirst  := .f.
		_cGrupo := cGrupo
		li++
		@ li, 00  Psay alltrim(cGrupo) + "  -  "+ cDescGrup Picture "@!"
		li++
		li++
	Endif
	
	//2         3         4         5         6         7         8         9        10        11        12        13         14       15
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX 999,999,999.99 XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX  XX
	@ li, 02  Psay "(   )  " + cCodProd Picture "@!"
	@ li, 26  Psay cDescProd	Picture "@!"
	@ li, 100  Psay cCodBAR
	@ li, 116  Psay cUnidade Picture "@!"
	@ li, 120 Psay IIF(cGrade=="S" .And. MV_PAR05 == 1,nTotQuant,nQtdIt) Picture "@E 999,999,999.99"
	@ li, 135 Psay cLocaliza
	@ li, 153 Psay _cLocEnd2
	@ li, 169 Psay cLocal
/*	@ li, 02  Psay "(   )  " + cCodProd Picture "@!"
	@ li, 26  Psay cDescProd	Picture "@!"
	@ li, 89  Psay cCodBAR
	@ li, 105  Psay cUnidade Picture "@!"
	@ li, 109 Psay IIF(cGrade=="S" .And. MV_PAR05 == 1,nTotQuant,nQtdIt) Picture "@E 999,999,999.99"
	@ li, 124 Psay cLocaliza
	@ li, 142 Psay _cLocEnd2
	@ li, 158 Psay cLocal*/
	
	//		@ li, 80  Psay cUnidade Picture "@!"
	//		@ li, 83  Psay IIF(cGrade=="S" .And. MV_PAR05 == 1,nTotQuant,nQtdIt) Picture "@E 999,999.99"
	//		@ li, 94  Psay cLocaliza
	//		@ li, 112 Psay _cLocEnd2
	//		@ li, 128 Psay cLocal
	//		@ li, 134 Psay cCodBAR
	li++
	
Next nX

li := 	li + 5
                  
IF li > 55 .or. lFirst
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,50)
Endif

@ li, 02  Psay "  Lista das NOTAS "
li++
@ li, 02  Psay "Nota         Cliente          Nome                                            UF    Transportadora                              Vendedor"
li := li+2

For x:=1 to Len(aLista2)
	
	IF li > 55 .or. lFirst
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,50)
		@ li, 02  Psay "Nota         Cliente          Nome                                            UF    Transportadora                              Vendedor"
		li := li+2
	Endif

	@ li, 02  Psay aLista2[x,1]
	@ li, 15  Psay aLista2[x,2]
	@ li, 32  Psay aLista2[x,3]
	@ li, 80  Psay aLista2[x,4]
	@ li, 85  Psay aLista2[x,5]
	@ li,130  Psay aLista2[x,6]
	li++
	
Next

IF lRodape
	roda(cbcont,cbtxt,"M")
Endif

If lQuery
	dbSelectArea(cAliasSD2)
	dbCloseArea()
	dbSelectArea("SD2")
Else
	RetIndex("SD2")
	Ferase(cIndexSD2+OrdBagExt())
	dbSelectArea("SD2")
	Set Filter to
	dbSetOrder(1)
	dbGotop()
Endif

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Edson Maricate      º Data ³  06/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PMSR150 AP7                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaSX1(cPerg)

Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}
Local aHelpPor1	:= {}
Local aHelpEng1	:= {}
Local aHelpSpa1	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                      ³
//³ mv_par01	     	  Da Nota                             ³
//³ mv_par02	     	  Ate a Nota                          ³
//³ mv_par03	     	  Serie	                              ³
//³ mv_par04	     	  Mascara                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PutSx1( cPerg , "01", "Da Nota Fiscal    ?", "Da Nota Fiscal   ?","Da Nota            ?","mv_ch1","C",6,0,1,"G","","","","",;
"mv_par01","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "02", "Ate a Nota       ?", "Ate a Nota        ?","Ate a Nota         ?","mv_ch2","C",6,0,1,"G","","","","",;
"mv_par02","","","","zzzzzzzzzzzzzzz","","","","","","","","","","","","",,,)

PutSx1( cPerg , "03", "Serie            ?", "Serie             ?","Serie              ?","mv_ch3","C",3,0,1,"G","","","","",;
"mv_par03","","","","zzzzzzzzzzzzzzz","","","","","","","","","","","","",,,)

PutSx1( cPerg , "04", "Mascara          ?", "Mascara           ?","Mascara            ?","mv_ch4","C",15,0,1,"G","","","","",;
"mv_par04","","","","zzzzzzzzzzzzzzz","","","","","","","","","","","","",,,)

PutSx1( cPerg , "05", "Cliente De       ?", "Cliente           ?","Cliente            ?","mv_ch5","C",06,0,1,"G","","","","",;
"mv_par05","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "06", "Cliente Ate      ?", "Cliente           ?","Cliente            ?","mv_ch6","C",06,0,1,"G","","","","",;
"mv_par06","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "07", "Nota             ?", "Nota           ?","Nota                 ?","mv_ch7","C",50,0,1,"G","","","","",;
"mv_par07","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "08", "Nota             ?", "Nota           ?","Nota                 ?","mv_ch8","C",50,0,1,"G","","","","",;
"mv_par08","","","","","","","","","","","","","","","","",,,)


Return

