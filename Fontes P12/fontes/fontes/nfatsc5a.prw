#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³Fun‡…o    ³ NFatSC5A ³ Autor ³ ERICH BUTTNER			  ³ Data ³16.06.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³Descri‡…o ³ Pick-List (Expedicao) NC Games                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³ Uso      ³ NC Games                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NFatSC5A(cMarca)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel     := "NFatSC5A"
LOCAL tamanho	:= "G"
LOCAL titulo    := OemToAnsi("Pick-List  (Expedicao)")
LOCAL cDesc1    := OemToAnsi("Emiss„o de produtos a serem separados pela expedicao, para")
LOCAL cDesc2    := OemToAnsi("determinada faixa de notas fiscais.")
LOCAL cDesc3	:= ""
LOCAL cString	:= "SC6"
LOCAL cPerg  	:= ""

PRIVATE aReturn         := {"Zebrado", 1,"Administracao", 2, 2, 1, "",0 }
PRIVATE nomeprog	:= "NFatSC5A"
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

RptStatus({|lEnd| C775Imp(@lEnd,wnRel,cString,,tamanho,@titulo,@cDesc1,;
@cDesc2,@cDesc3)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³Fun‡…o    ³ C775IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³Descri‡…o ³ Chamada do Relatorio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³ Uso      ³ NFATSC5											           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C775Imp(lEnd,WnRel,cString,CPERG,tamanho,titulo,cDesc1,cDesc2,;
cDesc3)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cabec1     := OemToAnsi("  Codigo           Desc. do Material                                                                  Cod. Barra      UM   Quantidade    Endreço 1       Endereço 2   Armz.    Verso     Frente")
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
LOCAL aStruSC6   := {}
LOCAL nSD2       := 0
LOCAL cFilter    := ""
LOCAL cAliasSC6  := "SC6"
LOCAL MARCA		 := "SC5"
LOCAL cIndexSC6  := ""
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
LOCAL NLIN		 := 1
LOCAL NVLRTOT	 := 0
LOCAL CPEDLIST	 := ""	
PRIVATE NSEQ	 := 1
PRIVATE NSEQ1	 := 1 
PRIVATE SC9SEQ	 := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li := 80
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_NVERPICK(CMARCA)

//U_NPEDSC9(CMARCA)

titulo := OemToAnsi("PICK-LIST")
//XXXXXXXXXXXXXXX X----------------------------X XX 999,999.99  99  XXXXXXXXXXXXXXX
//0        1         2         3         4         5         6         7         8
//012345678901234567890123456789012345678901234567890123456789012345678901234567890
#IFDEF TOP
	cAliasSC6:= "C775Imp"
	aStruSC6  := SC6->(dbStruct())
	lQuery    := .T.
	cQuery := "SELECT SC6.R_E_C_N_O_ SC6REC, SC6.C6_NUM,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_FILIAL,SC6.C6_QTDVEN,SC6.C6_PRODUTO,SC6.C6_VALOR,SC5.C5_STAPICK,SC6.C6_PRCVEN,SC5.C5_TIPAGEN, SC5.C5_DTAGEND, "            
	cQuery += "SC6.C6_LOCAL,SC6.C6_GRADE,SC6.C6_LOTECTL, SC6.C6_NUMLOTE,SC6.C6_DTVALID,SC6.C6_NUM,SC5.C5_NUM,SC5.C5_TRANSP, SC9.C9_QTDLIB, SB1.B1_GRUPO, SC6.C6_ITEM, SC9.C9_SEQCAR, SC5.C5_REPICK, "
	cQuery += "SB1.B1_OLD, SB1.B1_ECIV, SB1.B1_SBCATEG, SB1.B1_DESCCLA, SB1.B1_GRPWMS "
	cQuery += "FROM "+RetSqlName("SC6")+" SC6 ,"+RetSQLName("SC5")+" SC5, "+RetSQLName("SC9")+" SC9,"+RetSQLName("SB1")+" SB1 "
	cQuery += "WHERE SC6.C6_QTDVEN > 0 AND "
	cQuery += "SC6.C6_NUM = SC5.C5_NUM AND "
	cQuery += "SC9.C9_PEDIDO = SC6.C6_NUM AND SC9.C9_ITEM = SC6.C6_ITEM AND "
	cQuery += "SC6.C6_FILIAL = SC5.C5_FILIAL AND SC9.C9_BLEST = '  ' AND "
	cQuery += "SC6.C6_PRODUTO = SB1.B1_COD AND SC5.C5_MARK = '"+cMark+"' AND "
	cQuery += "SC6.D_E_L_E_T_ = ' ' AND SC5.D_E_L_E_T_ = ' '  AND SB1.D_E_L_E_T_ = ' ' AND SC9.D_E_L_E_T_ = ' ' "
	cQuery += "ORDER BY SC6.C6_FILIAL,SC6.C6_NUM, SC9.C9_SEQCAR,SB1.B1_SBCATEG,SB1.B1_GRPWMS,SC6.C6_ITEM,SC6.C6_PRODUTO,SC6.C6_LOTECTL, "
	cQuery += "SC6.C6_NUMLOTE,SC6.C6_DTVALID "//, SC9.C9_SEQCAR "
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)

	For nSC6 := 1 To Len(aStruSC6)
		If aStruSC6[nSC6][2] <> "C" .and.  FieldPos(aStruSC6[nSC6][1]) > 0
			TcSetField(cAliasSC6,aStruSC6[nSC6][1],aStruSC6[nSC6][2],aStruSC6[nSC6][3],aStruSC6[nSC6][4])
		EndIf
	Next nSC6

#ENDIF

WHILE (cAliasSC6)->(!Eof())
 
 	IF EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+(cAliasSC6)->C5_NUM+(cAliasSC6)->C6_ITEM,"C9_BLEST"))	
 		IF !((cAliasSC6)->C5_NUM $ CPEDLIST)
 			CPEDLIST+= (cAliasSC6)->C5_NUM+" / "
 		ENDIF
    ENDIF
    
	(cAliasSC6)->(DBSKIP())
ENDDO

@ 9, 02 Psay "PEDIDOS IMPRESSOS: "+CPEDLIST

LI:= 68

(cAliasSC6)->(DBGOTOP())

NITEM	:= (cAliasSC6)->C6_ITEM

_cDoc:=(cAliasSC6)->C5_NUM

While (cAliasSC6)->(!Eof())
	
   	//	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//	³ Valida o produto conforme a mascara         ³
	//	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	IF lEnd
		@PROW()+1,001 Psay "CANCELADO PELO OPERADOR"
		lContinua := .F.
		Exit
	Endif
	If !lQuery
		IncRegua()
	EndIf
	
	IF !EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+(cAliasSC6)->C5_NUM+(cAliasSC6)->C6_ITEM,"C9_BLEST"))
		(cAliasSC6)->(DBSKIP())
		LOOP
	ELSE
		DBSELECTAREA("SC5")
		SC5->(DBSETORDER(1))

		IF DBSEEK(XFILIAL("SC5")+(cAliasSC6)->C5_NUM)
			SC5->(RECLOCK("SC5", .F.))
 			SC5->C5_MARK:= " "
			SC5->C5_STAPICK := "1"
			SC5->(MSUNLOCK())
 		ENDIF

		DBSELECTAREA("SC9")
		SC9->(DBSETORDER(1))

		IF DBSEEK(XFILIAL("SC9")+(cAliasSC6)->C5_NUM+(cAliasSC6)->C6_ITEM)
			SC9->(RECLOCK("SC9", .F.))
			SC9->C9_STAPICK := "1"
			SC9->C9_BLWMS   := ""
			SC9->(MSUNLOCK())
		ENDIF
	ENDIF
  
	IF li > 67 .or. lFirst
		lFirst  := .F.
		@ 69, 02 Psay "SEPARADOR:________________________ DATA: ___/___/_____ HORA: __:__   CONFERENTE:__________________________ DATA: ___/___/_____ HORA: __:__   VOLUME:_______ /PESO LIQ.: _________ /PESO BRUT.: _________ /NOTA FISCAL:________ "
 		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		lRodape := .T.
	Endif
	
	IF LI == 8
	
		@ 9,180 Psay "PEDIDO : "+(cAliasSC6)->C5_NUM+" ->"+"PARTE: "+TRANSFORM ((cAliasSC6)->C9_SEQCAR, "@R 99")+" / "+TRANSFORM(SC9->C9_ULTIMCA, "@R 99")+IIF(ALLTRIM((cAliasSC6)->C5_REPICK) == "R"," - REIMPRESSO"," ")

		@ 10,2 Psay " CLIENTE: "+ALLTRIM((cAliasSC6)->C6_CLI)+"-";
		+ALLTRIM(SUBSTR(GETADVFVAL("SA1","A1_NREDUZ",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,1,""),1,30))+" ";
		+"CNPJ: "+ALLTRIM(GETADVFVAL("SA1","A1_CGC",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,1,""))+" ";
		+ALLTRIM(SUBSTR(GETADVFVAL("SA1","A1_END",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,1,""),1,45))+" ";
		+"CEP: "+ALLTRIM(GETADVFVAL("SA1","A1_CEP",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,1,""))+" ";
		+" - "+ALLTRIM(SUBSTR(GETADVFVAL("SA1","A1_MUN",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,1,""),1,15));
		+" UF: "+ALLTRIM(GETADVFVAL("SA1","A1_EST",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,,1,""));
		+" TRASPORTADORA: "+ALLTRIM(SUBSTR(ALLTRIM(GETADVFVAL("SA4","A4_NOME",xFilial("SA4")+(cAliasSC6)->C5_TRANSP,1,"")),1,20));
		+" FRETE: "+IF( GETADVFVAL("SC5","C5_TPFRETE",xFilial("SC5")+(cAliasSC6)->C6_NUM,1,"") == "F", "FOB", "CIF");
		+" VENDEDOR: "+SUBSTR(ALLTRIM(GETADVFVAL("SA3","A3_NOME",xFilial("SA3")+GETADVFVAL("SC5","C5_VEND1",xFilial("SC5")+(cAliasSC6)->C6_NUM,1,""),1,"")),1,20)		
		li:= 11
    ENDIF
	
	cCodProd := (cAliasSC6)->C6_PRODUTO
	cCodBAR  := GETADVFVAL("SB1","B1_CODBAR",XFILIAL("SB1")+(cAliasSC6)->C6_PRODUTO,1,"")
	nQtdIt   := (cAliasSC6)->C9_QTDLIB
	nTotProd += nQtdIt
	nTotNF   += nQtdIt
		
	cDescProd:= Subs(GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+(cAliasSC6)->C6_PRODUTO,1,""),1,70)
	cGrade   := (cAliasSC6)->C6_GRADE
	cUnidade := GETADVFVAL("SB1","B1_UM",XFILIAL("SB1")+(cAliasSC6)->C6_PRODUTO,1,"")
	cLocaliza:= GETADVFVAL("SB2","B2_LOCALIZ",xFilial("SB2")+(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_LOCAL,1,"")
	cLocEnd2 := GETADVFVAL("SB2","B2_LOCALI2",xFilial("SB2")+(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_LOCAL,1,"")
	cLote	 := (cAliasSC6)->C6_LOTECTL
	cLocal 	 := (cAliasSC6)->C6_LOCAL
	cEcif	 := (cAliasSC6)->B1_OLD
    cEciv	 :=  (cAliasSC6)->B1_ECIV
	cSubLote := (cAliasSC6)->C6_NUMLOTE
	dDtValid := (cAliasSC6)->C6_DTVALID
	cGrupo   := (cAliasSC6)->(B1_SBCATEG+B1_GRPWMS) //B1_GRUPO
	cDescCla := (cAliasSC6)->B1_DESCCLA
	cDescWMS := POSICIONE("SX5",1,XFILIAL("SX5")+"Z3"+(cAliasSC6)->B1_GRPWMS, "X5_DESCRI")
	cDescGrup:= alltrim(cDescCla)+" - "+cDescWMS//GETADVFVAL("SBM","BM_DESC",xFilial("SBM")+(cAliasSC6)->B1_GRUPO,1,"")
	cDoc	 := (cAliasSC6)->C6_NUM
	cCliente := (cAliasSC6)->C6_CLI
	cNomCli  := GETADVFVAL("SA1","A1_NOME",xFilial("SA1")+(cAliasSC6)->C6_CLI,1,"")
	cUF		 := GETADVFVAL("SA1","A1_EST",xFilial("SA1")+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA,,1,"")
	cNTransp := GETADVFVAL("SA4","A4_NOME",xFilial("SA4")+(cAliasSC6)->C5_TRANSP,1,"")
	cVendedor:= GETADVFVAL("SA3","A3_NOME",xFilial("SA3")+GETADVFVAL("SC5","C5_VEND1",xFilial("SC5")+(cAliasSC6)->C6_NUM,1,""),1,"")
	cMensInt := GETADVFVAL("SC5","C5_MENSINT",xFilial("SC5")+(cAliasSC6)->C6_NUM,1,"")
	cFrete	 := IF( GETADVFVAL("SC5","C5_TPFRETE",xFilial("SC5")+(cAliasSC6)->C6_NUM,1,"") == "F", "FOB", "CIF")
	
	//SOMATORIA POR GRUPO (PLATAFORMA) // MARCO - 03/03/10
	NXX := Ascan(xGRUPO, {|x| x[1] == (cAliasSC6)->(B1_SBCATEG+B1_GRPWMS) }   )//(cAliasSC6)->B1_GRUPO }   )//SB1.B1_SBCATEG,SB1.B1_GRPWMS
	If nXX == 0
		AADD(xGRUPO ,{(cAliasSC6)->(B1_SBCATEG+B1_GRPWMS) , nQtdIt, cDescGrup }) //{(cAliasSC6)->B1_GRUPO , nQtdIt })
	ELSE
		xGRUPO[nXX][2] += nQtdIt
	Endif
	
	
	//SOMATORIA POR GRUPO (PLATAFORMA) // MARCO - 03/03/10
	NWW := Ascan(wGRUPO, {|x| x[1] == (cAliasSC6)->(B1_SBCATEG+B1_GRPWMS) }   ) //(cAliasSC6)->B1_GRUPO }   )
	If nWW == 0
		AADD(wGRUPO ,{(cAliasSC6)->(B1_SBCATEG+B1_GRPWMS) , nQtdIt, cDescGrup }) //{(cAliasSC6)->B1_GRUPO , nQtdIt })
	ELSE
		wGRUPO[nWW][2] += nQtdIt
	Endif

	If  _cGrupo <> cGrupo
		lFirst  := .f.
		_cGrupo := cGrupo
		li++
		@ li, 00  Psay alltrim(cGrupo) + "  -  "+ cDescGrup Picture "@!"
//		li++
		li++
	Endif
	
	//2         3         4         5         6         7         8         9        10        11        12        13         14       15
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX 999,999,999.99 XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX  XX
	@ li, 02  Psay "(   )  " + cCodProd Picture "@!"
	@ li, 26  Psay cDescProd	Picture "@!"
	@ li, 100 Psay cCodBAR
	@ li, 116 Psay cUnidade Picture "@!"
	@ li, 128 Psay INT(nQtdIt) Picture "@E 99,999"
	@ li, 135 Psay cLocaliza
	@ li, 153 Psay cLocEnd2
	@ li, 169 Psay cLocal
	@ li, 175 Psay cEciv
	@ li, 198 Psay POSICIONE("SX5",1,XFILIAL("SX5")+"ZF"+cEcif, "X5_DESCRI")
	
	li++
	nlin++
    
    nvlrtot:= nvlrtot + ((cAliasSC6)->C6_PRCVEN*(cAliasSC6)->C9_QTDLIB)
    
	DBSELECTAREA("SZ7")
	DBSETORDER(2)
	
	IF !SZ7->(DBSEEK(XFILIAL("SZ7")+(cAliasSC6)->C6_NUM+"000010"+ALLTRIM(STR(NSEQ1))))
		RECLOCK("SZ7", .T.)
	ELSE
		RECLOCK("SZ7", .F.)
	ENDIF
	
	SZ7->Z7_FILIAL 	:= xFilial("SZ7")
  	SZ7->Z7_NUM	   	:= (cAliasSC6)->C6_NUM
  	SZ7->Z7_STAT   	:= "000010"
 	SZ7->Z7_STATUS 	:= "PICKING EMITIDO"
  	SZ7->Z7_CODCLI 	:= cCliente
  	SZ7->Z7_DATA   	:= DATE()
  	SZ7->Z7_HORA   	:= TIME()
  	SZ7->Z7_USUARIO	:= Upper(Substr(cUsuario,7,15))
  	SZ7->Z7_SEQCAR	:= ALLTRIM(STR(NSEQ1))
  	SZ7->(MsUnLock())	 
	
	DBCLOSEAREA("SZ7")
	
	
	dbSelectArea(cAliasSC6)
	(cAliasSC6)->(dbSkip())
	
//	SC9SEQ := (cAliasSC6)->C9_SEQCAR
	
	If  !lFirst .and. (_cDoc != (cAliasSC6)->C6_NUM) //.OR. ALLTRIM(SC9SEQ) != ALLTRIM(STR(NSEQ1)) )
/*		IF _cDoc != (cAliasSC6)->C6_NUM
			NSEQ1:= 1
		ENDIF*/
		_cDoc 	:= (cAliasSC6)->C6_NUM
   		_cGrupo	:= ""
		li++
		@ li, 02  Psay "Pedido         Cliente          Nome                                            UF    Transportadora                              Frete   Vendedor"
		li++
		
		@ li, 02  Psay cDoc
		@ li, 15  Psay cCliente
		@ li, 32  Psay cNomCli
		@ li, 80  Psay cUF
		@ li, 85  Psay cNTransp
		@ li,130  Psay cfrete
		@ li,138  Psay cVendedor
		li++
		//li++
		@ li, 02  Psay IF(cMensInt<>"","Obs.:"+ cMensInt,"")
        @ LI, 160 Psay "Tipo Agend: "+IIF((cAliasSC6)->C5_TIPAGEN == "0", "SEM AGENDAMENTO",IIF((cAliasSC6)->C5_TIPAGEN == "1","AGENDAMENTO SEM BATIMENTO",IF((cAliasSC6)->C5_TIPAGEN == "2","AGENDAMENTO COM BATIMENTO","")))+" Data Agend: "+DTOC(STOD((cAliasSC6)->C5_DTAGEND))
		li++
		@ li, 02 Psay "Valor Total Mercadoria........................................................................................................"
		@ li,128  Psay nvlrTot PICTURE "999,999,999.99"
	
		li++
		@ li, 02 Psay "Quantidade de Itens..........................................................................................................."
		@ li,128  Psay INT(nTotNF) PICTURE "99,999"
		nTotNF := 0
		
		li++ 
		@ li, 02 Psay "Totais por Plataforma........................................................................................................."
		li := li + 1
		for f:=1 to len(wGRUPO)
			@ li, 02 Psay wGRUPO[f][1]
			@ li, 40 Psay wGRUPO[f][3] //getadvfval("SBM","BM_DESC",XFILIAL("SBM")+wGRUPO[f][1],1,"")
			@ li,128  Psay INT(wGRUPO[f][2]) PICTURE "99,999"
			li ++
		next f
		
		wGRUPO := {}
		@ 69, 02 Psay "SEPARADOR:________________________ DATA: ___/___/_____ HORA: __:__   CONFERENTE:__________________________ DATA: ___/___/_____ HORA: __:__   VOLUME:_______ /PESO LIQ.: _________ /PESO BRUT.: _________ /NOTA FISCAL:________ "
		 		
		IF !EMPTY((cAliasSC6)->C6_NUM)
			m_pag	:= 1
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,50)
		EndIf
		
	    nvlrTot:= 0
	
/*		IF ALLTRIM(SC9SEQ) != ALLTRIM(STR(NSEQ1))
			NSEQ1++
		ENDIF*/
	ENDIF
End

li := li+2

//IF lRodape
//	roda(cbcont,cbtxt,"M")
//Endif

If lQuery
	dbSelectArea(cAliasSC6)
	dbCloseArea()
	dbSelectArea("SC6")
Else
	RetIndex("SC6")
	Ferase(cIndexSC6+OrdBagExt())
	dbSelectArea("SC6")
	Set Filter to
	dbSetOrder(1)
	dbGotop()
Endif

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

NSEQ1:= 1

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³Fun‡…o    ³ NFatSC5A ³ Autor ³ ERICH BUTTNER			³ Data ³16.06.10   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³Descri‡…o ³ Pick-List (Expedicao) NC Games                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±³ Uso      ³ NC Games                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NVERPICK(cMarca)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
LOCAL aStruSC6   := {}
LOCAL nSD2       := 0
LOCAL cFilter    := ""
LOCAL cAliasSC6  := "SC6"
LOCAL cIndexSC6  := ""
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
LOCAL NLIN		 := 1
LOCAL NVLRTOT	 := 0
LOCAL NSEQ	 := 1
LOCAL NULTIMCA := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li := 80
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#IFDEF TOP
	cAliasSC6:= "VERPICK"
	aStruSC6  := SC6->(dbStruct())
	lQuery    := .T.
	cQuery := " SELECT SC5.C5_STAPICK, SC5.C5_MARK, SC5.C5_NUM, SC5.C5_REPICK "
	cQuery += " FROM "+ RetSQLName("SC5") +" SC5 "
	cQuery += " WHERE SC5.C5_MARK = '"+cMark+"'  "
	cQuery += " AND SC5.D_E_L_E_T_ = ' ' "
	cQuery += " ORDER BY SC5.C5_NUM "
	
	cQuery := ChangeQuery(cQuery)
	
  	If Select("VERPICK") > 0
		dbSelectArea("VERPICK")
		dbCloseArea()
	Endif  
		
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)
	
	For nSC6 := 1 To Len(aStruSC6)
		If aStruSC6[nSC6][2] <> "C" .and.  FieldPos(aStruSC6[nSC6][1]) > 0
			TcSetField(cAliasSC6,aStruSC6[nSC6][1],aStruSC6[nSC6][2],aStruSC6[nSC6][3],aStruSC6[nSC6][4])
		EndIf
	Next nSC6
#ENDIF

WHILE (cAliasSC6)->(!EOF())
	IF (cAliasSC6)->C5_STAPICK == '1 '.OR.(cAliasSC6)->C5_REPICK == 'R'
		IF MSGYESNO("PICK LIST DO PEDIDO: "+(cAliasSC6)->C5_NUM+" JÁ IMPRESSO!"+CHR(13)+"DESEJA REIMPRIMI-LO? ")
	   	DBSELECTAREA("SC5")
			SC5->(DBSETORDER(1))
		 	DBSEEK(XFILIAL("SC5")+(cAliasSC6)->C5_NUM)
	   	RECLOCK("SC5",.F.)
	   	SC5->C5_REPICK := "R"
	      MSUNLOCK()
	   ELSE
	   	DBSELECTAREA("SC5")
			SC5->(DBSETORDER(1))
		 	DBSEEK(XFILIAL("SC5")+(cAliasSC6)->C5_NUM)
	   	RECLOCK("SC5",.F.)
	   	SC5->C5_MARK := ""
	      MSUNLOCK()
	   ENDIF
	ENDIF
	(cAliasSC6)->(DBSKIP())
ENDDO				
