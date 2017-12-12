#INCLUDE "RWMAKE.CH"
#INCLUDE "TopConn.ch"
#INCLUDE "vKey.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VERPV		ºAutor  ³ ERICH BUTTNER		 º Data ³  03/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ FUNCAO QUE VISUALIZA OS ITENS DO PEDIDO DE VENDA			  º±±
±±º          ³ 									                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER Function ATUSZQ()
Local aArea		:= GetArea()									// Salva a area atual
Local cCodLig	:= ""											// Codigo do atendimento
Local oDlgHist													// Tela do Historico
Local oObsMemo                                      			// Observacao do MEMO
Local oMonoAs  	:= TFont():New( "Courier New",6,0) 				// Fonte para o campo Memo
Local oGetHist													// Itens de cada atendimento
Local oBmp 		:= LoadBitmap( GetResources(), "BRANCO" )   	// Objeto BMP para exibir a cor da legenda
Local nOpcA		:= 0                                            // Opcao de OK ou CANCELA
Local lRet 		:= .T.                                          // Retorno da funcao
Local NVLRTOT   := 0
Local nLin		:= 1
Local NSEQ		:= 1
Local CBLQCRED  := ""
Local CCANAL	:= ""
Local dDTLB 	:= ""
Local CINFOBS	:= ""
Private cObsMemo 	:= ""	// String com a descricao do MEMO

PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SZA,SZB,SZC,SZD,SB1,SB2,SA1,SA2,SC5,SC6,SC9,SD2,SF2,SF1,SD1,SF4'

CursorWait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona todas a liga‡oes desse cliente indexando por ordem de liga‡ao decrescente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aLigacoes := {}
aCC       := {}
LCOORD := .F.

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""
cQuery:= " SELECT C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, C5_TRANSP, " 
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP, C5_YDLIMIT " 
cQuery+= " FROM SC5010, SA4010, SC6010 "
cQuery+= " WHERE C5_EMISSAO >= '"+DTOS(dDataBase-11)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(dDataBase)+"' "
cQuery+= " AND C5_FILIAL = '03' "
cQuery+= " AND C6_NUM = C5_NUM "
cQuery+= " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0) "
cQuery+= " AND SC5010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SA4010.D_E_L_E_T_ <> '*' "
cQuery+= " AND SC6010.D_E_L_E_T_ <> '*' "
cQuery+= " AND A4_COD = C5_TRANSP "
cQuery+= " AND A4_FILIAL = '  ' "
cQuery+= " GROUP BY C6_SEQCAR, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, A4_NREDUZ, C5_TRANSP, "
cQuery+= " C5_NUM, C5_EMISSAO, C5_CODBL, C5_LIBEROK, C5_VEND1, C5_DTAGEND, C5_DTDISNF, C5_CODCAMP,C5_YDLIMIT "
cQuery+= " ORDER BY C5_NUM, C6_SEQCAR "

If Select("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea("TRB1")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)

dbSelectArea("TRB1")
TRB1->(dbGoTop())
cEstWMS	:= ""

NSEQ:= TRB1->C6_SEQCAR

WHILE TRB1->(!EOF())
	
	CNUMPED		:= TRB1->C5_NUM
	DDTPED		:= SUBSTR(TRB1->C5_EMISSAO,7,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,5,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,3,2) 
	DDTLIB		:= POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM,"C9_DATALIB")
	
	DBSELECTAREA("SZ7")
	SZ7->(DBSETORDER(1))
	IF SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000006")).OR.SZ7->(DBSEEK(XFILIAL("SZ7")+TRB1->C5_NUM+"000004")) 
		DDTLIBCRED		:= SZ7->Z7_DATA
		cHRLBCRED		:= SZ7->Z7_HORA 
	ELSE
		DDTLIBCRED		:= CTOD("  /  /    ")
		cHRLBCRED		:= " " 
	ENDIF
	
	CTRANSP		:= SUBSTR(ALLTRIM(TRB1->A4_NREDUZ),1,08)
	DDTPREVENTR	:= SUBSTR(TRB1->C5_DTAGEND,7,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,5,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,3,2)
	AGENDAMENTO := IIF(ALLTRIM(POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_AGEND")) == "1", "SIM", "NAO")
	
	DBSELECTAREA("SD2")
	SD2->(DBSETORDER(8))
	SD2->(DBSEEK(XFILIAL("SD2")+TRB1->C5_NUM))
	CNUMNF		:= SD2->D2_DOC+SD2->D2_SERIE
	DDTAGEN		:= POSICIONE("SF2",1,XFILIAL("SF2")+CNUMNF,"F2_DATAAG")
	CCLIENTE	:= SUBSTR(TRB1->C5_NOMCLI,1,15)
	NQTDLIB 	:= 0

	DDTEMISNF	:= SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+CNUMNF,"F2_EMISSAO")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+CNUMNF,"F2_EMISSAO")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SF2",1,XFILIAL("SF2")+CNUMNF,"F2_EMISSAO")),3,2)
	
	CHRFATNF    := POSICIONE("SF2",1,XFILIAL("SF2")+CNUMNF,"F2_HORA")
	DDTSAIDA	:= SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+CNUMNF,"Z1_DTSAIDA")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+CNUMNF,"Z1_DTSAIDA")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+CNUMNF,"Z1_DTSAIDA")),3,2)
	
	DDTENTR		:= SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+CNUMNF,"Z1_DTENTRE")),7,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+CNUMNF,"Z1_DTENTRE")),5,2);
	+"/"+SUBSTR(DTOS(POSICIONE("SZ1",1,XFILIAL("SZ1")+CNUMNF,"Z1_DTENTRE")),3,2)
	
	DDTLIMCRED := SUBSTR(TRB1->C5_YDLIMIT,7,2)+"/"+SUBSTR(TRB1->C5_YDLIMIT,5,2)+"/"+SUBSTR(TRB1->C5_YDLIMIT,3,2)
	
	DBSELECTAREA("SC6")
	SC6->(DBORDERNICKNAME("SEQCAR"))
	SC6->(DBSEEK(XFILIAL("SC6")+TRB1->C5_NUM+ALLTRIM(STR(TRB1->C6_SEQCAR))))
	WHILE SC6->(!EOF()).AND.TRB1->C5_NUM == SC6->C6_NUM
		NQTDLIB  := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_QTDLIB")
		CBLOQEST := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_BLEST")
		NVLRTOT  := NVLRTOT+(IIF(EMPTY(CBLOQEST).OR.CBLOQEST == "10",NQTDLIB, 0 )* SC6->C6_PRCVEN)
		CBLQCRED := POSICIONE("SC9",1,XFILIAL("SC9")+TRB1->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")
		SC6->(DBSKIP())
	ENDDO
	SC6->(DBCLOSEAREA())
	
	NVLRTOTNF	:= POSICIONE("SF2",1,XFILIAL("SF2")+CNUMNF,"F2_VALMERC")
	
	IF EMPTY(CNUMNF)
		CNUM := TRB1->C5_NUM
	ELSE
		CNUM := SUBSTR(ALLTRIM(CNUMNF),1,9)
	ENDIF
	
	 CTPOPER:= POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_TPOPER")
	
	dDtIseP	:= CTOD("  /  /  ")
	cHrISep := ""
	dDtICof	:= CTOD("  /  /  ")
	cHrIcof	:= ""
	
    If DDTLIB < ctod("03/08/13") //data da substituição do wms store para wms Inovatech
		_cQuery01 := " SELECT DATADISPSEP DTDSEP,DATADISPONIVELSEP HRDSEP,DATASEP DTSEP,DATASEPARACAO HRSEP, "
		_cQuery01 += " DATADISPCONF DTDCONF,DATADISPONIVELCONF HRDCONF,DATACONF DTCONF,DATACONFERENCIA HRCONF, "
		_cQuery01 += " DATAFIM DTDNF, DATACONFIRMACAO HRDNF, USUARIOSEPARACAO USUSEP, USUARIOCONFERENCIA USUCONF, CODIGOROMANEIO ROMAN "
		_cQuery01 += " FROM ORAINT.X_077_VW_DOCUMENTOSAIDAPAINEL DOCPAINEL WHERE DOCPAINEL.DOCUMENTOSAIDA = '"+CNUM+"' "

		_cQuery01 := ChangeQuery(_cQuery01)
	
		If Select("TRB9") > 0
			dbSelectArea("TRB9")
			dbCloseArea()
		EndIf
		TCQUERY _cQuery01 New Alias "TRB9"

		dDtIseP	:= CTOD(TRB9->DTSEP)
		cHrISep	:= TRB9->HRSEP
		dDtICof	:= CTOD(TRB9->DTCONF)
		cHrIcof	:= TRB9->HRCONF

	Else
	
		_cQuery01 := " SELECT TO_CHAR(DT_HOR_DISPONIVEL_SEPARACAO,'DD/MM/YYYY HH24:MI:SS') DTDISPSEP, 
		_cQuery01 += " TO_CHAR(DT_HOR_INICIO_SEPARACAO,'DD/MM/YYYY HH24:MI:SS') DTINISEP, 
		_cQuery01 += " USUARIO_SEPARACAO USUSEP, 
		_cQuery01 += " DOCSEP.NUMERO_ROMANEIO ROMAN, 
		_cQuery01 += " DOCSEP.DOCUMENTO_ERP PEDWMS, 
		_cQuery01 += " DOCSEP.COD_DEPOSITO CODDEP,
		_cQuery01 += " TO_CHAR(DT_HOR_DISPONIVEL_CONFERENCIA,'DD/MM/YYYY HH24:MI:SS') DTDISPCONF, 
		_cQuery01 += " TO_CHAR(DT_HOR_INICIO_CONFERENCIA,'DD/MM/YYYY HH24:MI:SS') DTINICONF, 
		_cQuery01 += " TO_CHAR(DT_HOR_FIM_CONFERENCIA,'DD/MM/YYYY HH24:MI:SS') DTFIMCONF, 
		_cQuery01 += " USUARIO_CONFERENCIA USUCONF
		_cQuery01 += " FROM WMS.VIW_DOC_SEPARACAO_ERP DOCSEP LEFT OUTER JOIN WMS.VIW_DOC_SAIDA_ERP DOCSAIDA 
		_cQuery01 += " ON(DOCSEP.DOCUMENTO_ERP = DOCSAIDA.DOCUMENTO_ERP)
		_cQuery01 += " WHERE DOCSEP.DOCUMENTO_ERP = '"+xFilial("SC5")+CNUMPED+"'
		_cQuery01 += " ORDER BY DOCSEP.DOCUMENTO_ERP, DOCSEP.DT_HOR_INICIO_SEPARACAO

		_cQuery01 := ChangeQuery(_cQuery01)
	
		If Select("TRB9") > 0
			dbSelectArea("TRB9")
			dbCloseArea()
		EndIf

		TCQUERY _cQuery01 New Alias "TRB9"
		lcontinua	:= .T.
		While TRB9->(!eof()) .and. lcontinua
			lcontinua	:= .F.
			dDtIseP	:= ctod(substr(TRB9->DTINISEP,1,10))
			cHrISep	:= substr(TRB9->DTINISEP,12,8)
			dDtICof	:= ctod(substr(TRB9->DTINICONF,1,10))
			cHrIcof	:= substr(TRB9->DTINICONF,12,8)
			TRB9->(dbskip())
		end


	EndIf

	AGEND := POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_AGEND")
	CDCANAL:= POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_YDCANAL") 
    CCANAL := POSICIONE("SA1",1,XFILIAL("SA1")+TRB1->C5_CLIENTE+TRB1->C5_LOJACLI,"A1_YCANAL")
    
    CINFOBS := POSICIONE("SC5",1,XFILIAL("SC5")+CNUMPED,"C5_YFINOBS")

    nlinvsint := mlcount(CINFOBS)
	clinvsint := ""
	For nx := 1 to nlinvsint
		clinvsint += if(right(MemoLine(CINFOBS,,nx ),1) == " ",alltrim(MemoLine(CINFOBS,,nx ))+" ",alltrim(MemoLine(CINFOBS,,nx )))
	Next nx    

 	DBSELECTAREA("SZQ")
 	DBSETORDER(1)
 	
 	IF DBSEEK(XFILIAL("SZQ")+ALLTRIM(CNUMPED))
 		RECLOCK("SZQ",.F.)
 	ELSE	
 		RECLOCK("SZQ",.T.)
 	ENDIF
 	SZQ->ZQ_FILIAL := "03"
	SZQ->ZQ_NUMPED := CNUMPED 
	SZQ->ZQ_EMIPED := CTOD(DDTPED)
	SZQ->ZQ_DTLBPD := DDTLIB
	SZQ->ZQ_DTLBCD := DDTLIBCRED
	SZQ->ZQ_HRLBCRD:= cHRLBCRED
	//wmas store
//	SZQ->ZQ_DTISEP := CTOD(TRB9->DTSEP)
//	SZQ->ZQ_HRSEP  := TRB9->HRSEP
//	SZQ->ZQ_DTICOF := CTOD(TRB9->DTCONF)
//	SZQ->ZQ_HRCONF := TRB9->HRCONF
	//entrada do novo wms inovatech
	SZQ->ZQ_DTISEP := dDtIseP
	SZQ->ZQ_HRSEP  := cHrISep
	SZQ->ZQ_DTICOF := dDtICof
	SZQ->ZQ_HRCONF := cHrIcof
//
	SZQ->ZQ_DTEMNF := CTOD(DDTEMISNF)
	SZQ->ZQ_HRFAT  := CHRFATNF
	SZQ->ZQ_DTSAID := CTOD(DDTSAIDA)
	SZQ->ZQ_DTENTR := CTOD(DDTENTR)
	SZQ->ZQ_TRANSP := TRB1->C5_TRANSP
	SZQ->ZQ_NMTRAN := CTRANSP
	SZQ->ZQ_VEND   := TRB1->C5_VEND1
	SZQ->ZQ_NMVEND := POSICIONE("SA3",1,XFILIAL("SA3")+TRB1->C5_VEND1,"A3_NOME")
	SZQ->ZQ_CLIENT := TRB1->C5_CLIENTE
	SZQ->ZQ_LOJA   := TRB1->C5_LOJACLI
	SZQ->ZQ_NMCLI  := CCLIENTE
	SZQ->ZQ_DTPREV := CTOD(SUBSTR(TRB1->C5_DTAGEND,7,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,5,2)+"/"+SUBSTR(TRB1->C5_DTAGEND,3,2))
	SZQ->ZQ_CLIAGE := IIF(AGEND == "1", "SIM", "NAO")
	SZQ->ZQ_AGEND  := CTOD(SUBSTR(DTOS(DDTAGEN),7,2)+"/"+SUBSTR(DTOS(DDTAGEN),5,2)+"/"+SUBSTR(DTOS(DDTAGEN),3,2))
	SZQ->ZQ_NUMNF  := SUBSTR(CNUMNF,1,9)
	SZQ->ZQ_SERIE  := SUBSTR(CNUMNF,10,3)
	SZQ->ZQ_VLRTOT := NVLRTOT	
	SZQ->ZQ_BLCRED := IF(EMPTY(CBLQCRED),"NÃO",IF(CBLQCRED <> "10","SIM"," " ))
	SZQ->ZQ_DCANAL := ALLTRIM(CDCANAL)
	SZQ->ZQ_CANAL  := ALLTRIM(CCANAL)
	SZQ->ZQ_TPOPER := CTPOPER
	SZQ->ZQ_YDLIMIT:= CTOD(DDTLIMCRED)
    SZQ->ZQ_YFINOBS:= clinvsint
    
    SZQ->(MSUNLOCK())
    
   // RECLOCK("SZQ",.F.)
//		MSMM(SZQ->ZQ_YFINOBS,80,,ALLTRIM(clinvsint), 1,,, "SZQ", "ZQ_YFINOBS")    
//	SZQ->(MSUNLOCK())
	
	TRB1->(DBSKIP())
	
	NVLRTOT := 0
	nLin ++
	NSEQ++
	IF TRB1->C5_NUM <> SUBSTR(CNUMPED,1,6)
		NSEQ:= TRB1->C6_SEQCAR
	ENDIF
ENDDO

RestArea(aArea)

CONOUT("CONCLUIDO COM SUCESSO!!!!")

Return