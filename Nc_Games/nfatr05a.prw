#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ NFatr05A ³ Autor ³ Reinaldo Caldas       ³ Data ³ 22.11.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pick-List (Expedicao) NC Games                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ NC Games                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NFatr05A(cMarca)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel     := "NFatr05A"
LOCAL tamanho	:= "G"
LOCAL titulo    := OemToAnsi("Pick-List  (Expedicao)")
LOCAL cDesc1    := OemToAnsi("Emiss„o de produtos a serem separados pela expedicao, para")
LOCAL cDesc2    := OemToAnsi("determinada faixa de notas fiscais.")
LOCAL cDesc3	:= ""
LOCAL cString	:= "SD2"
LOCAL cPerg  	:= ""

PRIVATE aReturn         := {"Zebrado", 1,"Administracao", 2, 2, 1, "",0 }
PRIVATE nomeprog	:= "NFatr05A"
PRIVATE nLastKey 	:= 0
PRIVATE nBegin		:= 0
PRIVATE aLinha		:= {}
PRIVATE li			:= 80
PRIVATE limite		:= 132
PRIVATE lRodape		:= .F.
PRIVATE m_pag       :=1
PRIVATE cCodProd 	:= ""
PRIVATE cCodBAR  	:= ""
PRIVATE nQtdIt   	:= ""
PRIVATE cDescProd	:= ""
PRIVATE cGrade   	:= ""
PRIVATE cUnidade 	:= ""
PRIVATE cLocaliza	:= ""
PRIVATE cLocEnd2 	:= ""
PRIVATE cLote	 	:= ""
PRIVATE cLocal 	 	:= ""
PRIVATE cSubLote 	:= ""
PRIVATE dDtValid 	:= CTOD("  /  /  ")
PRIVATE cGrupo   	:= ""
PRIVATE cDescGrup	:= ""
PRIVATE cDoc	 	:= ""
PRIVATE cCliente 	:= ""
PRIVATE cNomCli  	:= ""
PRIVATE cUF		 	:= ""
PRIVATE cNTransp 	:= ""
PRIVATE _cGrupo 	:= ""
PRIVATE cVendedor	:= ""
PRIVATE cMark		:= cMarca
PRIVATE xGRUPO		:= {}
PRIVATE wGRUPO		:= {}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                      ³
//³ mv_par01	     	  Da Nota
//³ mv_par02	     	  Ate a Nota                             ³
//³ mv_par03	     	  Serie	                                ³
//³ mv_par04	     	  Mascara                                ³
//³ mv_par05	     	  Aglutina itens grade                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

LOCAL cabec1     := OemToAnsi("  Codigo           Desc. do Material                                                                  Cod. Barra      UM   Quantidade    Endreço 1       Endereço 2   Armz.")
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
LOCAL nTotProd 	 := 0
LOCAL nTotnf 	 := 0
LOCAL cDescProd	 := ""
LOCAL cGrade   	 := ""
LOCAL cUnidade 	 := ""
LOCAL cLocaliza	 := ""
LOCAL cLote	 	 := ""
LOCAL cLocal 	 := ""
LOCAL cSubLote   := ""
LOCAL dDtValid   := dDatabase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li := 80
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi("PICK-LIST")
//XXXXXXXXXXXXXXX X----------------------------X XX 999,999.99  99  XXXXXXXXXXXXXXX
//0        1         2         3         4         5         6         7         8
//012345678901234567890123456789012345678901234567890123456789012345678901234567890
#IFDEF TOP
	cAliasSD2:= "C775Imp"
	aStruSD2  := SD2->(dbStruct())
	lQuery    := .T.
	cQuery := "SELECT SD2.R_E_C_N_O_ SD2REC, SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_CLIENTE,SD2.D2_LOJA,SD2.D2_FILIAL,SD2.D2_QUANT,SD2.D2_COD, "
	cQuery += "SD2.D2_LOCAL,SD2.D2_GRADE,SD2.D2_LOTECTL, SD2.D2_NUMLOTE,SD2.D2_DTVALID,SD2.D2_PEDIDO,SF2.F2_DOC,SF2.F2_TRANSP,SB1.B1_GRUPO "
	cQuery += "FROM SD2010 SD2 ,SF2010 SF2, SB1010 SB1 "
	cQuery += "WHERE SD2.D2_QUANT > 0 AND "
	cQuery += "SD2.D2_DOC = SF2.F2_DOC AND "
	cQuery += "SD2.D2_SERIE = SF2.F2_SERIE AND "
	cQuery += "SD2.D2_FILIAL = SF2.F2_FILIAL AND "
	cQuery += "SD2.D2_COD = SB1.B1_COD AND SF2.F2_MARK = '"+cMark+"' AND "
	cQuery += "SD2.D_E_L_E_T_ = ' ' AND SF2.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' ' "
	cQuery += "ORDER BY SD2.D2_FILIAL,SD2.D2_DOC,SD2.D2_SERIE,SD2.D2_CLIENTE,SD2.D2_LOJA,SB1.B1_GRUPO,SD2.D2_COD,SD2.D2_LOTECTL, "
	cQuery += "SD2.D2_NUMLOTE,SD2.D2_DTVALID "
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD2,.T.,.T.)
	
	For nSD2 := 1 To Len(aStruSD2)
		If aStruSD2[nSD2][2] <> "C" .and.  FieldPos(aStruSD2[nSD2][1]) > 0
			TcSetField(cAliasSD2,aStruSD2[nSD2][1],aStruSD2[nSD2][2],aStruSD2[nSD2][3],aStruSD2[nSD2][4])
		EndIf
	Next nSD2
#ENDIF

While (cAliasSD2)->(!Eof())
	//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	³ Valida o produto conforme a mascara         ³
	//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lRet
		IF lEnd
			@PROW()+1,001 Psay "CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		Endif
		If !lQuery
			IncRegua()
		EndIf
		
		IF li > 55 .or. lFirst
			lFirst  := .F.
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			lRodape := .T.
		Endif
		
		
		cCodProd := (cAliasSD2)->D2_COD
		cCodBAR  := GETADVFVAL("SB1","B1_CODBAR",XFILIAL("SB1")+(cAliasSD2)->D2_COD,1,"")
		nQtdIt   := (cAliasSD2)->D2_QUANT
		nTotProd += nQtdIt
		nTotNF   += nQtdIt
		
		//SOMATORIA POR GRUPO (PLATAFORMA) // MARCO - 03/03/10
		NXX := Ascan(xGRUPO, {|x| x[1] == (cAliasSD2)->B1_GRUPO }   ) 
		If nXX == 0
			AADD(xGRUPO ,{(cAliasSD2)->B1_GRUPO , nQtdIt })
		ELSE		
		    xGRUPO[nXX][2] += nQtdIt
		Endif
		

		//SOMATORIA POR GRUPO (PLATAFORMA) // MARCO - 03/03/10
		NWW := Ascan(wGRUPO, {|x| x[1] == (cAliasSD2)->B1_GRUPO }   ) 
		If nWW == 0
			AADD(wGRUPO ,{(cAliasSD2)->B1_GRUPO , nQtdIt })
		ELSE		
		    wGRUPO[nWW][2] += nQtdIt
		Endif
		
		
		cDescProd:= Subs(GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+(cAliasSD2)->D2_COD,1,""),1,70)
		cGrade   := (cAliasSD2)->D2_GRADE
		cUnidade := GETADVFVAL("SB1","B1_UM",XFILIAL("SB1")+(cAliasSD2)->D2_COD,1,"")
		cLocaliza:= GETADVFVAL("SB2","B2_LOCALIZ",xFilial("SB2")+(cAliasSD2)->D2_COD+(cAliasSD2)->D2_LOCAL,1,"")
		cLocEnd2 := GETADVFVAL("SB2","B2_LOCALI2",xFilial("SB2")+(cAliasSD2)->D2_COD+(cAliasSD2)->D2_LOCAL,1,"")
		cLote	 := (cAliasSD2)->D2_LOTECTL
		cLocal 	 := (cAliasSD2)->D2_LOCAL
		cSubLote := (cAliasSD2)->D2_NUMLOTE
		dDtValid := (cAliasSD2)->D2_DTVALID
		cGrupo   := (cAliasSD2)->B1_GRUPO
		cDescGrup:= GETADVFVAL("SBM","BM_DESC",xFilial("SBM")+(cAliasSD2)->B1_GRUPO,1,"")
		cDoc	 := (cAliasSD2)->D2_DOC
		cCliente := (cAliasSD2)->D2_CLIENTE
		cNomCli  := GETADVFVAL("SA1","A1_NOME",xFilial("SA1")+(cAliasSD2)->D2_CLIENTE,1,"")
		cUF		 := GETADVFVAL("SA1","A1_EST",xFilial("SA1")+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA,,1,"")
		cNTransp := GETADVFVAL("SA4","A4_NOME",xFilial("SA4")+(cAliasSD2)->F2_TRANSP,1,"")   
		cVendedor:= GETADVFVAL("SA3","A3_NOME",xFilial("SA3")+GETADVFVAL("SC5","C5_VEND1",xFilial("SC5")+(cAliasSD2)->D2_PEDIDO,1,""),1,"")   
		cMensInt := GETADVFVAL("SC5","C5_MENSINT",xFilial("SC5")+(cAliasSD2)->D2_PEDIDO,1,"")   
		cFrete	 := IF( GETADVFVAL("SC5","C5_TPFRETE",xFilial("SC5")+(cAliasSD2)->D2_PEDIDO,1,"") == "F", "FOB", "CIF")
		
		If  _cGrupo <> cGrupo
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
		@ li, 128 Psay INT(nQtdIt) Picture "@E 99,999"
		@ li, 135 Psay cLocaliza
		@ li, 153 Psay cLocEnd2
		@ li, 169 Psay cLocal
		
		li++
		dbSelectArea(cAliasSD2)
		dbSkip()
		If  !lFirst .and. cDoc != (cAliasSD2)->D2_DOC
			_cDoc 	:= (cAliasSD2)->D2_DOC
			_cGrupo	:= ""
			li := li+2
			@ li, 02  Psay "Nota         Cliente          Nome                                            UF    Transportadora                              Frete   Vendedor"
			li := li+2
			
			@ li, 02  Psay cDoc
			@ li, 15  Psay cCliente
			@ li, 32  Psay cNomCli
			@ li, 80  Psay cUF
			@ li, 85  Psay cNTransp
			@ li,130  Psay cfrete
			@ li,138  Psay cVendedor
			li++                                     
			li++                                     
			@ li, 02  Psay IF(cMensInt<>"","Obs.:"+ cMensInt,"")

			li := li+2
			@ li, 02 Psay "Quantidade de Itens..........................................................................................................."
			@ li,128  Psay INT(nTotNF) PICTURE "99,999"
			nTotNF := 0
			
			li := li + 2
			@ li, 02 Psay "Totais por Plataforma........................................................................................................."
			li := li + 1
			for f:=1 to len(wGRUPO)
				@ li, 02 Psay wGRUPO[f][1]
				@ li, 40 Psay getadvfval("SBM","BM_DESC",XFILIAL("SBM")+wGRUPO[f][1],1,"")
				@ li,128  Psay INT(wGRUPO[f][2]) PICTURE "99,999"
			li ++
			next f

			wGRUPO := {}
						
			IF !EMPTY((cAliasSD2)->D2_DOC)                     
				m_pag	:= 1
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,50)
			EndIf
		Endif
			
	EndIf
	
End
li := li+2
/*
@ li, 02 Psay "TOTAL GERAL - Itens..........................................................................................................."
@ li,128  Psay INT(nTotProd) PICTURE "99,999"

li := li + 2
@ li, 02 Psay "TOTAL GERAL - Plataformas....................................................................................................."
li := li + 1
for f:=1 to len(xGRUPO)
	@ li, 02 Psay xGRUPO[f][1]
	@ li, 40 Psay getadvfval("SBM","BM_DESC",XFILIAL("SBM")+xGRUPO[f][1],1,"")
	@ li,128  Psay INT(xGRUPO[f][2]) PICTURE "99,999"
	li ++
next f
*/
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