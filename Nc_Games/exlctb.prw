#include "rwmake.ch"
#Include "Protheus.Ch"
#INCLUDE "FWPrintSetup.ch"

#DEFINE IMP_SPOOL 	002
#DEFINE IMP_PDF   	006

#DEFINE VBOX      	080
#DEFINE VSPACE    	008
#DEFINE HSPACE    	010
#DEFINE SAYVSPACE 	008
#DEFINE SAYHSPACE 	008
#DEFINE HMARGEM   	030
#DEFINE VMARGEM   	030
#DEFINE DMPAPER_A4 	009

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Funcao   ³ exlctb   ³ Autor ³ Thiago Queiroz		³ Data ³05/04/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio Relacao OS					                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ exlctb()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Panambra     		                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function exlctb()

IF /*(lPerg	== .T. .OR. lPerg	== NIL) .or. */(type("lPerg") == "U")
	ValidPerg()
ENDIF

//oPrn:= FwMsPrinter():New("RelGiroEst",IMP_PDF,.T.,alltrim(mv_par09),.T.)
oPrn:= FwMsPrinter():New("exlctb",IMP_PDF,.T.,"C:\orçamentos\",.T.)
oPrn:SetResolution(72) //
oPrn:SetLandscape()
oPrn:SetPaperSize(DMPAPER_A4) //2480 px de largura 3508 px de altura
oPrn:SetMargin(60,60,60,60)
oPrn:nDevice 		:= IMP_PDF
oPrn:cPathPDF 		:= "C:\orçamentos\" //alltrim(mv_par09)

Private PixelX 		:= oPrn:nLogPixelX()
Private PixelY 		:= oPrn:nLogPixelY()
PRIVATE oFtTit    	:= TFontEx():New(oPrn,"Arial",20,20,.T.,.T.,.F.)
PRIVATE oFtTotal 	:= TFontEx():New(oPrn,"Arial",10,10,.T.,.T.,.F.)
PRIVATE oFtItem 	:= TFontEx():New(oPrn,"Arial",10,10,.F.,.T.,.F.)
PRIVATE oFtCabGrp 	:= TFontEx():New(oPrn,"Arial",16,16,.T.,.T.,.F.)
PRIVATE oFtCab 		:= TFontEx():New(oPrn,"Arial",14,14,.F.,.T.,.F.)

LjMsgRun("Gerando Detalhamento...",, 	{|| exlctbPROC(@oPrn) })

IF /*(lPerg	== .T. .OR. lPerg	== NIL) .or. */(type("lPerg") == "U")
	//	oPrn:Preview()
ENDIF

FreeObj(oPrn)
oPrn := Nil


Return nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao   ³ exlctb1  | Autor ³  Thiago Queiroz      ³ Data ³22/03/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Processa a Impressao do relatório 			              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ exlctb1()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ PANAMBRA					                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function exlctbPROC(oPrn)

If Select("TRBCTB") > 0
	dbSelectArea("TRBCTB")
	dbCloseArea()
Endif

cQuery		:= ' SELECT D1_COD    			AS "Produto" '
cQuery		+= ' , D1.D1_QUANT          	AS "Qtd_NF" '
cQuery		+= ' , D7_QTDE			   		AS "Qtd_CQ" '
cQuery		+= ' , D1.D1_CUSTO          	AS "Custo_NF" '
cQuery		+= ' , F1_VALBRUT		   		AS "Val_Bruto" '
cQuery		+= ' , F1_VALMERC		   		AS "Val_Merc" '
cQuery		+= ' , F1_DESPESA		   		AS "Despesas" '
cQuery		+= ' , F1_VALBRUT - F1_VALMERC	AS "Imposto" '
cQuery		+= ' , D7_TIPO			   		AS "Tipo_CQ" '
cQuery		+= ' , D7_LOCAL			   		AS "Armazem_Origem" '
cQuery		+= ' , D7_LOCDEST	  	   		AS "Armazem_Destino" '
cQuery		+= ' , D7_DOC           	   	AS "Nota_Fiscal" '
cQuery		+= ' , D7_SERIE      	   		AS "Serie" '
cQuery		+= ' , D1.D1_EMISSAO        	AS "Emissao_NF" '
cQuery		+= ' , D1.D1_CONHEC	   	   		AS "Conhecimento" '
cQuery		+= ' , D7_NUMERO				AS "NUM_CQ" '
cQuery		+= ' , D7_NUMSEQ		   	   	AS "NUM_SEQ_CQ" '
cQuery		+= ' , D1_TES					AS "TES" '
cQuery		+= ' FROM SD1010 D1, SD7010 D7, SF1010 F1
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120101' AND '20120131'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN ''20120201'' AND ''20120229''
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120301' AND '20120331'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120401' AND '20120430'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120501' AND '20120531'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120601' AND '20120630'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120701' AND '20120731'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120801' AND '20120831'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20120901' AND '20120930'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20121001' AND '20121031'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20121101' AND '20121130'
//cQuery	+= ' --WHERE D1_EMISSAO BETWEEN '20121201' AND '20121231'
cQuery		+= " WHERE D1_EMISSAO BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"'"
IF !EMPTY(ALLTRIM(MV_PAR05))
	cQuery	+= " AND D1_CONHEC  		= '"+MV_PAR05+"'"
ENDIF
cQuery		+= " AND D1.D_E_L_E_T_      != '*' "
cQuery		+= " AND D7.D_E_L_E_T_      != '*' "
IF !EMPTY(ALLTRIM(MV_PAR03))
	cQuery	+= " AND D1.D1_DOC			= '"+MV_PAR03+"'" // COLOCAR COMO PARAMETRO
	cQuery	+= " AND D1.D1_SERIE		= '"+MV_PAR04+"'"
ENDIF
cQuery 		+= " AND D1.D1_DOC			= D7_DOC "
cQuery 		+= " AND D1.D1_SERIE		= D7_SERIE "
cQuery 		+= " AND D1.D1_NUMCQ        = D7_NUMERO "
cQuery 		+= " AND D1.D1_COD 			= D7_PRODUTO "
cQuery 		+= " AND D1.D1_NUMSEQ		= D7_NUMSEQ "
cQuery 		+= " AND D1.D1_LOCAL		= D7_LOCAL "
cQuery 		+= " AND D1.D1_DOC			= F1_DOC "
cQuery 		+= " AND D1.D1_SERIE		= F1_SERIE "
IF !EMPTY(ALLTRIM(MV_PAR06))
	cQuery 	+= " AND D1.D1_CF			= '"+MV_PAR06+"'"  // COLOCAR COMO PARAMETRO
ENDIF
cQuery		+= ' ORDER BY D1.D1_CONHEC, D1.D1_DOC, D1_COD, D7_LOCAL DESC '

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),"TRBCTB",.F.,.T.)

dbSelectArea("TRBCTB")
TRBCTB->(dbGoTop())

aValores	:= {}
Grp			:= {}
cUltCod 	:= TRBCTB->Produto
nX			:= 1
nCustoSaida := 0
nCustoEntr	:= 0
nQtdSaida	:= 0
nQtdEntrada	:= 0



WHILE !(TRBCTB->(EOF()))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava no vetor valores a serem impressos       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//IF TRBCTB->Produto != cUltCod
	//	cUltCod := TRBCTB->Produto
	//	nX++
	//ENDIF
	
	//Aadd(aValores,{" "," "," ",0," "," "}) //,0,0,0,0,0,0,0," "})
	
	Aadd(aValores,{" ",0,0,0,0,0,0,0,0," "," "," "," "," "," "," "," "," ",0,0," ",0,0," "})
	
	//Produto	Qtd NF	Qtd CQ	Custo NF	Val Bruto	Val. Merc	Despesas	Imposto	Tipo CQ	Armazem Origem	Armazem Destino	Nota Fiscal	Serie	Emissao NF	Conhecimento	NUM CQ	NUM SEQ CQ	TES
	
	aValores[nX][01] 	:= TRBCTB->Produto
	aValores[nX][02] 	:= TRBCTB->QTD_NF
	aValores[nX][03] 	:= TRBCTB->QTD_CQ
	aValores[nX][04] 	:= TRBCTB->CUSTO_NF
	aValores[nX][05] 	:= TRBCTB->VAL_BRUTO
	aValores[nX][06] 	:= TRBCTB->VAL_MERC
	aValores[nX][07] 	:= TRBCTB->DESPESAS
	aValores[nX][08] 	:= TRBCTB->IMPOSTO
	aValores[nX][09] 	:= ALLTRIM(STR(TRBCTB->Tipo_CQ))
	aValores[nX][10] 	:= TRBCTB->Armazem_origem
	aValores[nX][11] 	:= TRBCTB->Armazem_destino
	aValores[nX][12] 	:= TRBCTB->Nota_fiscal
	aValores[nX][13] 	:= TRBCTB->serie
	aValores[nX][14] 	:= TRBCTB->Emissao_nf
	aValores[nX][15] 	:= TRBCTB->conhecimento
	aValores[nX][16] 	:= TRBCTB->num_cq
	aValores[nX][17] 	:= TRBCTB->num_seq_cq
	aValores[nX][18] 	:= TRBCTB->tes
	//aValores[nX][23] 	:= TRBCTB->tes
	
	DBSELECTAREA("SD3")
	DBSETORDER(2)
	IF DBSEEK(XFILIAL("SD3")+TRBCTB->num_cq+SPACE(9-LEN(TRBCTB->num_cq))+TRBCTB->PRODUTO)
		
		WHILE !EOF() .AND. ALLTRIM(SD3->D3_DOC) == ALLTRIM(TRBCTB->num_cq)
			IF ALLTRIM(SD3->D3_IDENT) == ALLTRIM(TRBCTB->num_seq_cq)
				IF ALLTRIM(SD3->D3_TM) > '500'
					nCustoSaida		:= nCustoSaida + SD3->D3_CUSTO1
					dDtTfSaida		:= DtoS(SD3->D3_EMISSAO)
					nQtdSaida		:= nQtdSaida + SD3->D3_QUANT
				ELSEIF ALLTRIM(SD3->D3_TM) < '500'
					nCustoEntr		:= nCustoEntr + SD3->D3_CUSTO1
					nQtdEntrada		:= nQTDEntrada + SD3->D3_QUANT
					dDtTfEntrada	:= DtoS(SD3->D3_EMISSAO)
				ELSE
					nCustoSaida		:= 0 //SD3->D3_CUSTO1
					nCustoEntr		:= 0 //SD3->D3_CUSTO1
					dDtTfSaida		:= '19800101'
					dDtTfEntrada	:= '19800101'
					nQtdSaida		:= 0
					nQtdEntrada		:= 0
				ENDIF
				//getadvfval("SD3","D3_CUSTO1",XFILIAL("SD3")+TRBCTB->num_cq+SPACE(9-LEN(TRBCTB->num_cq))+TRBCTB->PRODUTO,2,"")
				//Posicione("SD3",2,"03"+TRBCTB->num_cq+SPACE(9-LEN(TRBCTB->num_cq))+TRBCTB->PRODUTO,"D3_CUSTO1")
			ENDIF
			
			dbSelectArea("SD3")
			dbSkip()
		EndDO
		
	ENDIF
	
	aValores[nX][19] 	:= nQtdSaida
	aValores[nX][20] 	:= nCustoSaida
	aValores[nX][21] 	:= dDtTfSaida
	aValores[nX][22] 	:= nQtdEntrada
	aValores[nX][23] 	:= nCustoEntr
	aValores[nX][24] 	:= dDtTfEntrada
	
	nCustoSaida			:= 0
	nCustoEntr			:= 0
	nQtdSaida			:= 0
	nQtdEntrada			:= 0
	cUltCod 			:= TRBCTB->Produto
	nX++
	
	TRBCTB->(DbSkip())
Enddo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia Impressao					           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
nHPage := oPrn:nHorzRes()
nHPage *= (300/PixelX)
nHPage -= HMARGEM
nVPage := oPrn:nVerTREs()
nVPage *= (300/PixelY)
nVPage -= VBOX
*/

private rLin:= 1//nVPage/2480
private rCol:= 1//nHPage/3508

exlctbIT(@oPrn,aValores, Grp)

oPrn:EndPage()
//ENDIF

Return(.T.)

///////////////////////////////////////////////////////////////////////////
// ********************************************************************* //
///////////////////////////////////////////////////////////////////////////
Static Function exlctbIT(oPrn,aValores, Grp)

Li		:= 600
nCont	:= 1
Y		:= 1
lExcel	:= .T.
IF /*(lPerg	== .T. .OR. lPerg	== NIL) .or. */(type("lPerg") == "U")
	IF len(aValores) < 1
		MsgBox("Não existem dados a serem impressos com estes parametros!")
		Return
	EndIF
ENDIF

//IF MSGYESNO("Deseja Gerar em Excel ?")
lExcel := .T.

aDbStru := {}

AADD(aDbStru,{"Produto"  	,"C",015,0})
AADD(aDbStru,{"QtdNF"   	,"N",020,6})
AADD(aDbStru,{"QtdCQ"		,"N",020,6})
AADD(aDbStru,{"CustoNF"		,"N",020,6})
AADD(aDbStru,{"ValBruto"  	,"N",020,6})
AADD(aDbStru,{"ValMerc" 	,"N",020,6})
AADD(aDbStru,{"Despesas" 	,"N",020,6})
AADD(aDbStru,{"Imposto"		,"N",020,6})
AADD(aDbStru,{"TipoCQ"		,"C",001,0})
AADD(aDbStru,{"ArmOrigem"	,"C",002,0})
AADD(aDbStru,{"ArmDestino"	,"C",002,0})
AADD(aDbStru,{"NotaFiscal"	,"C",009,0})
AADD(aDbStru,{"Serie"		,"C",003,0})
AADD(aDbStru,{"EmissaoNF"	,"C",008,0})
AADD(aDbStru,{"Conhecimto"	,"C",020,0})
AADD(aDbStru,{"NumCQ"		,"C",006,0})
AADD(aDbStru,{"NumSeqCQ"	,"C",006,0})
AADD(aDbStru,{"tes"			,"C",003,0})
AADD(aDbStru,{"QtdSaida"	,"N",020,6})
AADD(aDbStru,{"CustoSaida"	,"N",020,6})
AADD(aDbStru,{"DtSaida"		,"C",008,0})
AADD(aDbStru,{"QtdEntra"	,"N",020,6})
AADD(aDbStru,{"CustoEntra"	,"N",020,6})
AADD(aDbStru,{"DtEntrada"	,"C",008,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "exlctb"
DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","System\" + CNOMEDBF,"XLS",.T.,.F.)

//ELSE
//	lExcel := .F.
//ENDIF

For x:=1 to Len(aValores)
	
	//If !(Li<2100)
	//oPrn:EndPage()
	//exlctbCab(@oPrn)
	//Li:= 600
	//Endif
	
	IF alltrim(aValores[x][1]) != ""
		
		Li+=50
		
		oPrn:SayAlign(Li,0120 , ALLTRIM(aValores[x,01])							   		,oFtItem:oFont,200,30,,0,)	//PRODUTO
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,02] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//QTD NF
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,03] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//QTD CQ
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,04] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//CUSTO NF
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,05] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//VALOR BRUTO
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,06] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//VALOR MERCADORIA
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,07] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//DESPESAS
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,08] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//IMPOSTO
		oPrn:SayAlign(Li,1450 , ALLTRIM(aValores[x,09])									,oFtItem:oFont,100,30,,1,)	//TIPO CQ
		oPrn:SayAlign(Li,0440 , ALLTRIM(aValores[x,10])							   		,oFtItem:oFont,230,30,,0,)	//ARMAZEM ORIGEM
		oPrn:SayAlign(Li,0810 , ALLTRIM(aValores[x,11]) 								,oFtItem:oFont,100,30,,1,)	//ARMAZEM DESTINO
		oPrn:SayAlign(Li,0980 , ALLTRIM(aValores[x,12]) 								,oFtItem:oFont,150,30,,1,)	//NOTA FISCAL
		oPrn:SayAlign(Li,0980 , ALLTRIM(aValores[x,13]) 								,oFtItem:oFont,150,30,,1,)	//SERIE
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,14]) 								,oFtItem:oFont,180,30,,1,)	//DT EMISSAO NF
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,15]) 								,oFtItem:oFont,180,30,,1,)	//CONHECIMENTO
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,16]) 								,oFtItem:oFont,180,30,,1,)	//NUMERACAO CQ
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,17]) 								,oFtItem:oFont,180,30,,1,)	//NUM. SEQUENCIAL CQ
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,18]) 								,oFtItem:oFont,180,30,,1,)	//TES
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,19] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//QUANTIDADE TRANSFERENCIA SAIDA
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,20] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//Custo TRANSFERENCIA SAIDA
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,21]) 								,oFtItem:oFont,180,30,,1,)	//DT TRANSFERENCIA SAIDA
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,22] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//QUANTIDADE TRANSFERENCIA ENTRADA
		oPrn:SayAlign(Li,1450 , ALLTRIM(Transform(aValores[x,23] ,"@E 999,999.99"))		,oFtItem:oFont,100,30,,1,)	//Custo TRANSFERENCIA ENTRADA
		oPrn:SayAlign(Li,1100 , ALLTRIM(aValores[x,24]) 								,oFtItem:oFont,180,30,,1,)	//DT TRANSFERENCIA ENTRADA
		
		Li+=30
	ENDIF
	
	IF lExcel == .T.
		IF alltrim(aValores[x][1]) != ""
			XLS->(RECLOCK("XLS",.T.))
			
			XLS->Produto    	:= aValores[x,01]		// Produto
			XLS->QtdNF			:= aValores[x,02]		// Qtd NF
			XLS->QtdCQ			:= aValores[x,03]		// Qtd CQ
			XLS->CustoNF		:= aValores[x,04]		// Custo NF
			XLS->ValBruto		:= aValores[x,05]		// Valor Bruto
			XLS->ValMerc		:= aValores[x,06]		// Valor Mercadoria
			XLS->Despesas		:= aValores[x,07]		// Despesas
			XLS->Imposto		:= aValores[x,08]       // Impostos
			XLS->TipoCQ			:= aValores[x,09]       // Tipo CQ
			XLS->ArmOrigem		:= aValores[x,10]       // Armazem Origem
			XLS->ArmDestino		:= aValores[x,11]		// Armazem Destino
			XLS->NotaFiscal		:= aValores[x,12]		// Nota Fiscal
			XLS->Serie			:= aValores[x,13]		// Serie
			XLS->EmissaoNF		:= aValores[x,14]		// DT Emissao NF
			XLS->Conhecimto		:= aValores[x,15]		// Conhecimento
			XLS->NumCQ			:= aValores[x,16]		// Num CQ
			XLS->NumSeqCQ		:= aValores[x,17]		// Num Seq CQ
			XLS->TES			:= aValores[x,18]		// TES
			XLS->QtdSaida		:= aValores[x,19]		// Custo Transferencia Saida
			XLS->CustoSaida		:= aValores[x,20]		// Custo Transferencia Saida
			XLS->DtSaida		:= aValores[x,21]		// Data Transferencia Saida
			XLS->QtdEntra		:= aValores[x,22]		// Custo Transferencia Entrada
			XLS->CustoEntra		:= aValores[x,23]		// Custo Transferencia Entrada
			XLS->DtEntrada		:= aValores[x,24]		// Data Transferencia Entrada
			
			
		ENDIF
	ENDIF
	
Next x

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ IMPRESSAO EXCEL							                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

IF lExcel == .T.
	
	XLS->(DBGOTOP())
	TRBCTB->(DBGOTOP())
	CpyS2T( "\System\" + CNOMEDBF +".DBF" , "C:\orçamentos\" , .F. )
	IF FILE("C:\orçamentos\" + CNOMEDBF +".XLS")
		//FERASE(GetSrvProfString ("ROOTPATH","") +"\System\exlctb.xls")
		FERASE("C:\orçamentos\exlctb.xls")
	ENDIF
	FRENAME("C:\orçamentos\" + CNOMEDBF +".DBF", "C:\orçamentos\" + CNOMEDBF +".XLS")
	IF /*(lPerg	== .T. .OR. lPerg	== NIL) .or. */(type("lPerg") == "U")
		Alert("Arquivo salvo em C:\orçamentos\" + CNOMEDBF + ".XLS" )
	ENDIF
	
	IF /*(lPerg	== .T. .OR. lPerg	== NIL) .or. */(type("lPerg") == "U")
		
		If ! ApOleClient( 'MsExcel' )
			IF /*(lPerg	== .T. .OR. lPerg	== NIL) .or. */(type("lPerg") == "U")
				MsgStop( 'MsExcel nao instalado' )
			ENDIF
			DbSelectArea("TRBCTB")
			DbCloseArea()
			XLS->(DBCLOSEAREA())
			//	Return
		ELSE
			//EndIf
			
			DbSelectArea("TRBCTB")
			DbCloseArea()
			
			oExcelApp := MsExcel():New()
			oExcelApp:WorkBooks:Open( "C:\orçamentos\" + CNOMEDBF +".XLS" ) // Abre uma planilha
			oExcelApp:SetVisible(.T.)
			//DbCloseArea()
			XLS->(DBCLOSEAREA())
			//OLE_CloseFile( hWord )
			//OLE_CloseLink( hWord )
			
		ENDIF
	EndIf
ELSE
	XLS->(DBCLOSEAREA())
ENDIF

XLS->(DBCLOSEAREA())

RETURN

///////////////////////////////////////////////////////////////////////////
// ********************************************************************* //
///////////////////////////////////////////////////////////////////////////
Static Function ValidPerg()

_aAreaVP	:= GetArea()
cPerg		:= "exlctb"

DBSelectArea("SX1")
DBSetOrder(1)

If !DBSeek(cPerg)
	
	cPerg  		:= PADR(cPerg,10)
	aRegs  		:= {}
	
	aHelpP1		:= {}
	/*
	Aadd( aHelpP1, "Preencha conforme abaixo" )
	Aadd( aHelpP1, "Seguindo a regra:" )
	Aadd( aHelpP1, "Exemplo: 'A','V' ou " )
	Aadd( aHelpP1, "'A' ou 'V','E','F' " )
	Aadd( aHelpP1, "Os Status preenchidos NAO" )
	Aadd( aHelpP1, "serao impressos " )
	Aadd( aHelpP1, "Branco ira trazer todas as OS" )
	Aadd( aHelpP1, "A = Sem Classificacao" )
	Aadd( aHelpP1, "V = Sem Requisicoes" )
	Aadd( aHelpP1, "X = Com Requisicoes" )
	Aadd( aHelpP1, "O = Gerado Orc. Vendas" )
	Aadd( aHelpP1, "T = Aguard. aprov. da AT" )
	Aadd( aHelpP1, "P = Aprov. pelo CLiente" )
	Aadd( aHelpP1, "N = Nao aprov. pelo CLiente" )
	Aadd( aHelpP1, "E = Finalizada" )
	Aadd( aHelpP1, "F = Garantia Negada" )
	*/
	//PutSX1(cGrupo,cOrdem,cPergunt,cPerSpa,cPerEng,cVar,cTipo,nTamanho,nDecimal,nPresel,cGSC,cValid,cF3,cGrpSxg,cPyme,cVar01,cDef01,cDefSpa1,cDefEng1,cCnt01,cDef02,cDefSpa2,cDefEng2,cDef03,cDefSpa3,cDefEng3,cDef04,cDefSpa4,cDefEng4,cDef05,cDefSpa5,cDefEng5,aHelpPor,aHelpEng,aHelpSpa,cHelp)
	PutSx1(cPerg,"01","De Data"  		,"","","mv_ch3","D",08,0,0,"G","","AB3","","","mv_par01","","","","","","","","","","","","","","","","",{}		)
	PutSx1(cPerg,"02","Ate Data"  		,"","","mv_ch2","D",08,0,0,"G","","AB3","","","mv_par02","","","","","","","","","","","","","","","","",{}		)
	PutSx1(cPerg,"03","Nota Fiscal"		,"","","mv_ch3","C",09,0,0,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",{}		)
	PutSx1(cPerg,"04","Serie"			,"","","mv_ch4","C",03,0,0,"G","",""   ,"","","mv_par04","","","","","","","","","","","","","","","","",{}		)
	PutSx1(cPerg,"05","Conhecimento" 	,"","","mv_ch5","C",20,0,0,"G","",""   ,"","","mv_par05","","","","","","","","","","","","","","","","",{}		)
	PutSx1(cPerg,"06","CFOP"			,"","","mv_ch6","C",04,0,0,"G","",""   ,"","","mv_par06","","","","","","","","","","","","","","","","",{}		)
	//PutSx1(cPerg,"07","Status"  		,"","","mv_ch7","C",35,0,0,"G","",""   ,"","","mv_par07","","","","","","","","","","","","","","","","",aHelpP1)
	
	
Endif

RestArea(_aAreaVP)

IF Pergunte(cPerg,.T.,"Relacao OS")
	
EndIF


RETURN

