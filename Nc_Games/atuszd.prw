#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuSZD    ºAutor  ³Microsiga           º Data ³  05/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function AtuSZD

Local lAuto := IIF(Select("SM0") > 0, .f., .t.)
Local _aArea := GetArea()

IF lAuto
	QOUT("Preparando Environment ... "+dtoc(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SZA,SZB,SZC,SZD,SB1,SB2,SA1,SA2,SC5,SC6,SC9,SD2,SF2,SF1,SD1,SF4'
	dDtAtu	:= ddatabase
Else
	If !Pergunte("ATUSZC",.T.)
		Return(nil)
	EndIf
	dDtAtu	:= mv_par01
ENDIF

Private cCodPro	:= "" //ZD_CODPRO
Private cUPC		:= "" //ZD_UPC
Private cXDesc	:= "" //ZD_XDESC
Private nQtd		:= 0 //ZD_QUANT
Private nReceita	:= 0 //ZD_RECEITA
Private nPrcVen	:= 0 //ZD_PRCVEN
Private nLBrut	:= 0 //ZD_LBRUT
Private nLLiqu	:= 0 //ZD_LLIQU
Private nEstoque	:= 0 //ZD_ESTOQUE
Private dDataApur	:= dDtAtu
Private nQftDia	:= 0 //ZD_QFTDIA
Private nVftDia	:= 0 //ZD_VFTDIA
Private nPmddia	:= 0 //ZD_PMDDIA
Private nLBBrut	:= 0 //ZD_LBBRUT
Private nCmvDia	:= 0 //ZD_CMVDIA
Private nLLdia	:= 0 //ZD_LLDIA
Private nMkpdia	:= 0 //ZD_MKPDIA
Private nQpdAcm	:= 0 //ZD_QPDACM
Private nVpdAcm	:= 0 //ZD_VPDACM
Private nQftAcm	:= 0 //ZD_QFTACM
Private nVftAcm	:= 0 //ZD_VFTACM
Private nPmdAcm	:= 0 //ZD_PMDACM
Private nLBrAcm	:= 0 //ZD_LBRACM
Private nCmvAcm	:= 0 //ZD_CMVACM
Private nMkpAcm	:= 0 //ZD_MKPACM
Private nLLiAcm	:= 0 //ZD_LLIACM
Private nAtgAcm	:= 0 //ZD_ATGACM
Private nVlSImpd:= 0 //ZD_VLSIMPD
Private nVlSImpt:= 0 //ZD_VLSIMPT
Private nCustDia:= 0 //ZD_CUSTDIA
Private nCustTot:= 0 //ZD_CUSTTOT
Private aZAAtiv	:= {}
Private aSaldo	:= {}

//Verifica as campanhas ativas
DbSelectArea("SZA")
DbSetOrder(3)
While SZA->(!EOF()) .AND. ZA_DTINI <= ddatabase
	If SZA->ZA_DTFIM >= ddatabase
		aadd(aZAAtiv,{SZA->ZA_COD,SZA->ZA_DESCR,SZA->ZA_DTINI,SZA->ZA_DTFIM})
	EndIf
	SZA->(DbSkip())
End
SZA->(DbCloseArea())

//fator definido conforme Eduardo Bassoli
nfator	:= 9 //87.62 alterado conforme informado por Wilson Tessari

//Apuração das campanhas
For nn:=1 to len(aZAAtiv)
	aCposG	:= {}
	DbSelectArea("SZB")
	DbSetOrder(1)
	If DbSeek(xFilial("SZB")+aZAAtiv[nn,1])
		While SZB->(!eof())
			//Bloco para buscar os pedidos em carteira
			cArqPED	:= CriaTrab(,.F.)		//Nome do arq. temporario
			cQry := ""
			cQry += " SELECT C5_CLIENTE CODCLI, C5_LOJACLI LOJACLI, C6_PRODUTO PRODUTO, SUM(C6_QTDVEN-C6_QTDENT) QTDPED, SUM((C6_QTDVEN-C6_QTDENT)*C6_PRCVEN) VALPED,
			cQry += " B1_PLATAF PLATAF, B1_PLATEXT PLATEXT, B1_ITEMCC ITECC, B1_PUBLISH PUBLISH, B1_DESCCAT DESCCAT, B1_DESCCLA DESCCLA, C5_VEND1 CODVEND
			cQry += " FROM "+RetSqlName("SC6")+" SC6, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SC5")+" SC5, "+RetSqlName("SB1")+" SB1
			cQry += " WHERE SC6.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' ' AND SC5.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' '
			cQry += " AND B1_FILIAL = '"+xFilial("SB1")+"' AND B1_COD = C6_PRODUTO
			cQry += " AND C6_QTDVEN > C6_QTDENT
			cQry += " AND C6_BLQ <> 'R'
			cQry += " AND C5_FILIAL = C6_FILIAL
			cQry += " AND C5_NUM = C6_NUM
			cQry += " AND C5_EMISSAO <= '"+dtos(dDtAtu)+"'
			cQry += " AND C5_EMISSAO >= '"+dtos(aZAAtiv[nn,3])+"'
			cQry += " AND SC6.C6_TES = SF4.F4_CODIGO
			cQry += " AND SC6.C6_FILIAL = '"+xFilial("SC6")+"'
			cQry += " AND SF4.F4_FILIAL = '"+xFilial("SF4")+"'
			cQry += " AND SF4.F4_DUPLIC = 'S'
			cQry += " AND SF4.F4_ESTOQUE = 'S'
			cQry += " AND SC6.C6_PRODUTO = '"+SZB->ZB_CODPRO+"'
			cQry += " GROUP BY C5_CLIENTE, C5_LOJACLI, C6_PRODUTO, B1_PLATAF, B1_PLATEXT, B1_ITEMCC, B1_PUBLISH, B1_DESCCAT, B1_DESCCLA, C5_VEND1
			cQry += " ORDER BY SC6.C6_PRODUTO, C5_CLIENTE, C5_LOJACLI
			cQry := ChangeQuery(cQry)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqPED",.T.,.T.)
			
			While cArqPED->(!EOF())
				
				aSaldo := CalcEst(SZB->ZB_CODPRO,"01",dDataApur+1,xfilial("SB2"))
				
				nEstDia := aSaldo[1]
				nCmvDia	:= aSaldo[2]/nEstDia
				nQpdAcm	:= cArqPED->QTDPED
				nVpdAcm	:= cArqPED->VALPED
				DbSelectArea("SZD")
				DbSetOrder(2)
				If !dbseek(xfilial("SZD")+DTOS(dDataApur)+aZAAtiv[nn,1]+cArqPED->CODCLI+cArqPED->LOJACLI+SZB->ZB_CODPRO)
					RecLock('SZD',.T.)
				Else
					RecLock('SZD',.F.)
				EndIf
				SZD->ZD_DATA 	:= dDataApur
				SZD->ZD_FILIAL	:= xFilial("SZD")
				SZD->ZD_COD 	:= aZAAtiv[nn,1]
				SZD->ZD_CODCLI 	:= cArqPED->CODCLI
				SZD->ZD_LOJACLI	:= cArqPED->LOJACLI
				SZD->ZD_CODVEND	:= cArqPED->CODVEND
				SZD->ZD_NOMVEND	:= GETADVFVAL("SA3","A3_NOME",xFILIAL("SA3")+cArqPED->CODVEND,1,"")
				SZD->ZD_GRPREP	:= GETADVFVAL("SA3","A3_GRPREP",xFILIAL("SA3")+cArqPED->CODVEND,1,"")
				SZD->ZD_DCANAL	:= GETADVFVAL("ACA","ACA_DESCRI",xFILIAL("ACA")+SZD->ZD_GRPREP,1,"")
				SZD->ZD_NOMCLI  := getadvfval("SA1","A1_NOME",xFilial("SA1")+cArqPED->CODCLI+cArqPED->LOJACLI,1,"")
				SZD->ZD_DESCR 	:= SZB->ZB_DESCR
				SZD->ZD_CODPRO 	:= SZB->ZB_CODPRO
				SZD->ZD_UPC		:= SZB->ZB_UPC
				SZD->ZD_XDESC	:= SZB->ZB_XDESC
				SZD->ZD_PLATAF	:= cArqPED->PLATAF
				SZD->ZD_PLATEXT	:= cArqPED->PLATEXT
				SZD->ZD_ITECC	:= cArqPED->ITECC
				SZD->ZD_PUBLISH	:= cArqPED->PUBLISH
				SZD->ZD_DESCCAT	:= cArqPED->DESCCAT
				SZD->ZD_DESCCLA	:= cArqPED->DESCCLA
				SZD->ZD_XDESC	:= SZB->ZB_XDESC
				SZD->ZD_QUANT	:= SZB->ZB_QUANT
				SZD->ZD_RECEITA	:= SZB->ZB_RECEITA
				SZD->ZD_PRCVEN	:= SZB->ZB_PRCVEN
				SZD->ZD_LBRUT	:= SZB->ZB_LBRUT
				SZD->ZD_LLIQU	:= SZB->ZB_LLIQU
				//			SZD->ZD_ESTOQUE	:= nEstDia
				SZD->ZD_CMVDIA 	:= nCmvDia
				SZD->ZD_QPDACM	:= nQpdAcm
				SZD->ZD_VPDACM	:= nVpdAcm
/*				//VALORES
				SZD->ZD_QDVDIA	:= 0
				SZD->ZD_VDVDIA	:= 0
				SZD->ZD_DVSIMP	:= 0
				SZD->ZD_LBRDIA	:= 0
				SZD->ZD_LLDIA 	:= 0
				SZD->ZD_CMDEVDI	:= 0
				//ACUMULADOS
				SZD->ZD_QDVACM	:= 0
				SZD->ZD_VDVACM	:= 0
				SZD->ZD_PMDACM	:= 0
				SZD->ZD_LBRACM	:= 0
				SZD->ZD_MKPACM	:= 0
				SZD->ZD_LLIACM	:= 0
				SZD->ZD_ATGACM	:= 0
				SZD->ZD_DVSIMPT	:= 0
				SZD->ZD_CMDEVTO	:= 0
				*/
				MsUnlock()
				cArqPED->(dbskip())
			End
			dbSelectArea("cArqPED")
			dbCloseArea()
			
			SZB->(dbskip())
		END
	EndIf
	
	cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario
	cQry := ""
	
	cQry += " SELECT CODCLI, LOJACLI, ZB_COD CODCAMP, EMISSAO, ZB_CODPRO PRODUTO, VALMERC, VALICM, VALIPI,
	cQry += " ICMSRET, PIS, COFINS, VALBRUTO, QTDVEND, FRETE, DESPESA, SEGURO, CODVEND
	cQry += " FROM SZB010 SZB,
	cQry += " (SELECT D2_CLIENTE CODCLI, D2_LOJA LOJACLI, D2_EMISSAO EMISSAO, D2_COD PRODUTO, SUM(D2_TOTAL) VALMERC, SUM(D2_VALICM) VALICM, SUM(D2_VALIPI) VALIPI,
	cQry += " SUM(D2_ICMSRET) ICMSRET, SUM(D2_VALIMP6) PIS, SUM(D2_VALIMP5) COFINS, SUM(D2_VALBRUT) VALBRUTO, SUM(D2_QUANT) QTDVEND,
	cQry += " SUM(D2_VALFRE) FRETE, SUM(D2_DESPESA) DESPESA, SUM(D2_SEGURO) SEGURO, F2_VEND1 CODVEND
	cQry += " FROM "+RetSqlName("SD2")+" SD2, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SF2")+" SF2
	cQry += " WHERE D2_FILIAL = '"+xFilial("SD2")+"'
	cQry += " AND D2_EMISSAO = '"+dtos(dDtAtu)+"'
	cQry += " AND D2_TIPO NOT IN ('D', 'B')
	cQry += " AND F2_FILIAL  = '"+xFilial("SF2")+"'
	cQry += " AND D2_DOC     = F2_DOC
	cQry += " AND D2_SERIE   = F2_SERIE
	cQry += " AND D2_CLIENTE = F2_CLIENTE
	cQry += " AND D2_LOJA    = F2_LOJA
	cQry += " AND F4_FILIAL  = '"+xFilial("SF4")+"'
	cQry += " AND F4_CODIGO  = D2_TES
	cQry += " AND SF4.F4_ESTOQUE = 'S'
	cQry += " AND SF4.F4_DUPLIC = 'S'
	cQry += " AND SD2.D_E_L_E_T_ = ' '
	cQry += " AND SF2.D_E_L_E_T_ = ' '
	cQry += " AND SF4.D_E_L_E_T_ = ' '
	cQry += " AND SD2.D2_COD IN(SELECT ZB_CODPRO FROM "+RetSqlName("SZB")+" WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += " GROUP BY D2_CLIENTE, D2_LOJA, D2_COD, D2_EMISSAO, F2_VEND1
	cQry += " ORDER BY D2_EMISSAO) VWAPUR
	cQry += " WHERE SZB.D_E_L_E_T_ = ' '
	cQry += " AND ZB_CODPRO = VWAPUR.PRODUTO "//(+)
	
	cQry := ChangeQuery(cQry)
	
	TCQUERY cQry NEW ALIAS "cArqTRB"
	
	ProcRegua(cArqTRB->(Reccount()))
	
	While !cArqTRB->(EOF())
		
/*		cQry := ""
		cQry += " SELECT ZD_CODPRO PRODUTO, SUM(ZD_QFTDIA) QFATDIA, SUM(ZD_VFTDIA) VFATDIA,
		cQry += " SUM(ZD_LBRDIA) LBRUTDIA, SUM(ZD_LLDIA) LLDIA, SUM(ZD_VLSIMPD) VLSIMPT, SUM(ZD_CUSTDIA) CMVFTTOT
		cQry += " FROM "+RetSqlName("SZD")+" SZD
		cQry += " WHERE SZD.D_E_L_E_T_ = ' '
		cQry += " AND SZD.ZD_CODPRO = '"+cArqTRB->PRODUTO+"'
		cQry += " AND SZD.ZD_CODCLI = '"+cArqTRB->CODCLI+"'
		cQry += " AND SZD.ZD_LOJACLI = '"+cArqTRB->LOJACLI+"'
		cQry += " AND SZD.ZD_DATA < '"+dtos(dDtAtu)+"'
		cQry += " AND SZD.ZD_FILIAL = '"+xFilial("SZD")+"'
		cQry += " GROUP BY ZD_CODPRO
		cQry := ChangeQuery(cQry)
		cArqACM	:= CriaTrab(,.F.)		//Nome do arq. temporario
		//Valores acumulados
		TCQUERY cQry NEW ALIAS "cArqACM"
		
		nQftAcm	:= cArqACM->QFATDIA
		nVftAcm	:= cArqACM->VFATDIA
		nLBrAcm	:= cArqACM->LBRUTDIA
		nLLiAcm	:= cArqACM->LLDIA
		nVlSImpt:= cArqACM->VLSIMPT
		nCMVFTTOT:= cArqACM->CMVFTTOT
		
		dbSelectArea("cArqACM")
		dbCloseArea()
		*/
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		DBSEEK(xFilial("SB1")+cArqTRB->PRODUTO)
		
		DbSelectArea("SZD")
		DbSetOrder(2)
		If dbseek(xfilial("SZD")+DTOS(dDataApur)+aZAAtiv[nn,1]+cArqTRB->CODCLI+cArqTRB->LOJACLI+cArqTRB->PRODUTO)
			RecLock('SZD',.F.)
		Else
			aSaldo := CalcEst(cArqTRB->PRODUTO,"01",dDataApur+1,xfilial("SB2"))
			nEstDia := aSaldo[1]
			nCmvDia	:= aSaldo[2]/nEstDia
			
			RecLock('SZD',.T.)
			
			SZD->ZD_DATA 	:= dDataApur
			SZD->ZD_FILIAL	:= xFilial("SZD")
			SZD->ZD_COD 	:= aZAAtiv[nn,1]
			SZD->ZD_CODCLI 	:= cArqTRB->CODCLI
			SZD->ZD_LOJACLI	:= cArqTRB->LOJACLI

			SZD->ZD_CODVEND	:= cArqTRB->CODVEND
			SZD->ZD_NOMVEND	:= GETADVFVAL("SA3","A3_NOME",xFILIAL("SA3")+cArqTRB->CODVEND,1,"")
			SZD->ZD_GRPREP	:= GETADVFVAL("SA3","A3_GRPREP",xFILIAL("SA3")+cArqTRB->CODVEND,1,"")
			SZD->ZD_DCANAL	:= GETADVFVAL("ACA","ACA_DESCRI",xFILIAL("ACA")+SZD->ZD_GRPREP,1,"")

			SZD->ZD_NOMCLI  := getadvfval("SA1","A1_NOME",xFilial("SA1")+cArqTRB->CODCLI+cArqTRB->LOJACLI,1,"")
			SZD->ZD_DESCR 	:= aZAAtiv[nn,2]
			SZD->ZD_CODPRO 	:= cArqTRB->PRODUTO
			SZD->ZD_UPC		:= SB1->B1_CODBAR
			SZD->ZD_XDESC	:= SB1->B1_XDESC
			SZD->ZD_PLATAF	:= SB1->B1_PLATAF
			SZD->ZD_PLATEXT	:= SB1->B1_PLATEXT
			SZD->ZD_ITECC	:= SB1->B1_ITEMCC
			SZD->ZD_PUBLISH	:= SB1->B1_PUBLISH
			SZD->ZD_DESCCAT	:= SB1->B1_DESCCAT
			SZD->ZD_DESCCLA	:= SB1->B1_DESCCLA
			SZD->ZD_QUANT	:= GETADVFVAL("SZB","ZB_QUANT",xFilial("SZB")+aZAAtiv[nn,1]+cArqTRB->PRODUTO,1,"")
			SZD->ZD_RECEITA	:= GETADVFVAL("SZB","ZB_RECEITA",xFilial("SZB")+aZAAtiv[nn,1]+cArqTRB->PRODUTO,1,"")
			SZD->ZD_PRCVEN	:= GETADVFVAL("SZB","ZB_PRCVEN",xFilial("SZB")+aZAAtiv[nn,1]+cArqTRB->PRODUTO,1,"")
			SZD->ZD_LBRUT	:= GETADVFVAL("SZB","ZB_LBRUT",xFilial("SZB")+aZAAtiv[nn,1]+cArqTRB->PRODUTO,1,"")
			SZD->ZD_LLIQU	:= GETADVFVAL("SZB","ZB_LLIQU",xFilial("SZB")+aZAAtiv[nn,1]+cArqTRB->PRODUTO,1,"")
			SZD->ZD_CMVDIA 	:= nCmvDia
		EndIf
		
		dbSelectArea("SB1")
		dbCloseArea()
		
		nQftDia	:= cArqTRB->QTDVEND
		nVftDia	:= cArqTRB->VALBRUTO
		nPmddia	:= cArqTRB->VALBRUTO/cArqTRB->QTDVEND
		nLBBrut	:= (cArqTRB->(VALMERC-VALICM-PIS-COFINS))-(SZD->ZD_CMVDIA*cArqTRB->QTDVEND)
		nMkpdia	:= (cArqTRB->VALBRUTO / (SZD->ZD_CMVDIA * cArqTRB->QTDVEND))
		nVlSImpd:= cArqTRB->(VALMERC-VALICM-PIS-COFINS)
		nLLdia	:= nLBBrut-((nVlSImpd)*(nfator/100))
		
/*		nQftAcm	:= nQftAcm+nQftDia
		nVftAcm	:= nVftAcm+nVftDia
		nVlSImpt:= nVlSImpt+nVlSImpd
		nLBrAcm	:= nLBrAcm+nLBBrut
		nPmdAcm	:= nVftAcm/nQftAcm
		nCmvAcm	:= SZD->ZD_CMVDIA
		nMkpAcm	:= (nVftAcm / (nCmvAcm * nQftAcm))
		nLLiAcm	:= nLLiAcm + nLLdia //nLBrAcm-((nVlSImpt)*(nfator/100))
		nAtgAcm	:= (nLLiAcm/SZD->ZD_LLIQU)*100*/
		
		//			RecLock('SZD',.F.)
		SZD->ZD_QFTDIA	:= nQftDia
		SZD->ZD_VFTDIA	:= nVftDia
		SZD->ZD_PMDDIA	:= nPmddia
		SZD->ZD_LBRDIA	:= nLBBrut
		SZD->ZD_LLDIA 	:= nLLdia
		SZD->ZD_MKPDIA	:= nMkpdia
/*		SZD->ZD_QFTACM	:= nQftAcm
		SZD->ZD_VFTACM	:= nVftAcm
		SZD->ZD_PMDACM	:= nPmdAcm
		SZD->ZD_LBRACM	:= nLBrAcm
		SZD->ZD_CMVACM	:= nCmvAcm
		SZD->ZD_MKPACM	:= nMkpAcm
		SZD->ZD_LLIACM	:= nLLiAcm
		SZD->ZD_ATGACM	:= nAtgAcm*/
		SZD->ZD_VLSIMPD	:= nVlSImpd
//		SZD->ZD_VLSIMPT	:= nVlSImpt
		SZD->ZD_CUSTDIA	:= nQftDia*SZD->ZD_CMVDIA
//		SZD->ZD_CUSTTOT	:= nCMVFTTOT + (nQftDia*SZD->ZD_CMVDIA) //nQftAcm*nCmvAcm
		
		MsUnlock()
		cArqTRB->(DBSKIP())
	End
	dbSelectArea("cArqTRB")
	dbCloseArea()
	
	//Processa devoluções
	cArqDEV	:= CriaTrab(,.F.)		//Nome do arq. temporario
	cQry := ""
	cQry += " SELECT CODCLI, LOJACLI, ZB_COD CODCAMP, ZB_CODPRO PRODUTO, QTDDEV, VLRTOTAL, VALICM, VALIPI, ICMSRET, VALBRUTO, COFINS, PIS, CODVEND
	cQry += " FROM "+RetSqlName("SZB")+" SZB,
	cQry += " (SELECT D1_FORNECE CODCLI, D1_LOJA LOJACLI, D1_COD PROD, SUM(D1_QUANT) QTDDEV, SUM(D1_TOTAL) VLRTOTAL, SUM(D1_VALICM) VALICM, F2_VEND1 CODVEND,
	cQry += " SUM(D1_VALIPI) VALIPI, SUM(D1_ICMSRET) ICMSRET, SUM(D1_TOTAL+D1_VALIPI+D1_ICMSRET) VALBRUTO, SUM(D1_VALIMP5) COFINS, SUM(D1_VALIMP6) PIS
	cQry += " FROM "+RetSqlName("SD1")+" SD1, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SF2")+" SF2, "+RetSqlName("SF1")+" SF1
	cQry += " WHERE D1_FILIAL  = '"+xFilial("SD1")+"'
	cQry += " AND D1_DTDIGIT = '"+dtos(dDtAtu)+"'
	cQry += " AND D1_COD IN(SELECT ZB_CODPRO FROM "+RetSqlName("SZB")+" WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += " AND D1_TIPO = 'D'
	cQry += " AND F4_FILIAL  = '"+xFilial("SF4")+"'
	cQry += " AND F4_CODIGO  = D1_TES
	cQry += " AND F2_FILIAL  = '"+xFilial("SF2")+"'
	cQry += " AND F2_DOC     = D1_NFORI
	cQry += " AND F2_SERIE   = D1_SERIORI
	cQry += " AND F2_LOJA    = D1_LOJA
	cQry += " AND F1_FILIAL  = '"+xFilial("SF1")+"'
	cQry += " AND F1_DOC     = D1_DOC
	cQry += " AND F1_SERIE   = D1_SERIE
	cQry += " AND F1_FORNECE = D1_FORNECE
	cQry += " AND F1_LOJA    = D1_LOJA
	cQry += " AND SD1.D_E_L_E_T_ = ' '
	cQry += " AND SF4.D_E_L_E_T_ = ' '
	cQry += " AND SF2.D_E_L_E_T_ = ' '
	cQry += " AND SF1.D_E_L_E_T_ = ' '
	cQry += " GROUP BY D1_COD, D1_FORNECE, D1_LOJA, F2_VEND1
	cQry += " ORDER BY D1_COD) VWDEV
	cQry += " WHERE SZB.D_E_L_E_T_ = ' '
	cQry += " AND ZB_CODPRO = VWDEV.PROD " //(+)
	cQry := ChangeQuery(cQry)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqDEV",.T.,.T.)
	nQdvAcm:= 0
	nVdvAcm	:= 0
	//REALIZAR TRATAMENTOS
	While !cArqDEV->(EOF())
/*		cQry := ""
		cQry += " SELECT ZD_CODPRO PRODUTO, SUM(ZD_QDVDIA) QFATDIA, SUM(ZD_VDVDIA) VFATDIA,
		cQry += " SUM(ZD_LBRDIA) LBRUTDIA, SUM(ZD_LLDIA) LLDIA, SUM(ZD_DVSIMP) VLSIMPT, SUM(ZD_CMDEVDI) CMVDVTOT
		cQry += " FROM "+RetSqlName("SZD")+" SZD
		cQry += " WHERE SZD.D_E_L_E_T_ = ' '
		cQry += " AND SZD.ZD_CODPRO = '"+cArqDEV->PRODUTO+"'
		cQry += " AND SZD.ZD_DATA < '"+dtos(dDtAtu)+"'
		cQry += " AND SZD.ZD_FILIAL = '"+xFilial("SZD")+"'
		cQry += " AND SZD.ZD_CODCLI = '"+cArqDEV->CODCLI+"'
		cQry += " AND SZD.ZD_LOJACLI = '"+cArqDEV->LOJACLI+"'
		cQry += " GROUP BY ZD_CODPRO
		cQry := ChangeQuery(cQry)
		cArqACM	:= CriaTrab(,.F.)		//Nome do arq. temporario
		//Valores acumulados
		TCQUERY cQry NEW ALIAS "cArqACM"
		nQdvAcm	:= cArqACM->QFATDIA
		nVdvAcm	:= cArqACM->VFATDIA
		nLBrAcm	:= cArqACM->LBRUTDIA
		nDvImpt:= cArqACM->VLSIMPT
		nCMVDVTOT:= cArqACM->CMVDVTOT
		nLLiAcm	:= cArqACM->LLDIA
		
		dbSelectArea("cArqACM")
		dbCloseArea()*/
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+cArqDEV->PRODUTO)
		
		DbSelectArea("SZD")
		DbSetOrder(2)
		If dbseek(xfilial("SZD")+DTOS(dDataApur)+aZAAtiv[nn,1]+cArqDEV->CODCLI+cArqDEV->LOJACLI+cArqDEV->PRODUTO)
			RecLock('SZD',.F.)
		Else
			aSaldo := CalcEst(cArqDEV->PRODUTO,"01",dDataApur+1,xfilial("SB2"))
			nEstDia := aSaldo[1]
			nCmvDia	:= aSaldo[2]/nEstDia
			
			RecLock('SZD',.T.)
			SZD->ZD_DATA 	:= dDataApur
			SZD->ZD_FILIAL	:= xFilial("SZD")
			SZD->ZD_COD 	:= aZAAtiv[nn,1]
			SZD->ZD_CODCLI 	:= cArqDEV->CODCLI
			SZD->ZD_LOJACLI	:= cArqDEV->LOJACLI

			SZD->ZD_CODVEND	:= cArqDEV->CODVEND
			SZD->ZD_NOMVEND	:= GETADVFVAL("SA3","A3_NOME",xFILIAL("SA3")+cArqDEV->CODVEND,1,"")
			SZD->ZD_GRPREP	:= GETADVFVAL("SA3","A3_GRPREP",xFILIAL("SA3")+cArqDEV->CODVEND,1,"")
			SZD->ZD_DCANAL	:= GETADVFVAL("ACA","ACA_DESCRI",xFILIAL("ACA")+SZD->ZD_GRPREP,1,"")

			SZD->ZD_NOMCLI  := getadvfval("SA1","A1_NOME",xFilial("SA1")+cArqDEV->CODCLI+cArqDEV->LOJACLI,1,"")
			SZD->ZD_DESCR 	:= aZAAtiv[nn,2]
			SZD->ZD_CODPRO 	:= cArqDEV->PRODUTO
			SZD->ZD_UPC		:= SB1->B1_CODBAR
			SZD->ZD_XDESC	:= SB1->B1_XDESC
			SZD->ZD_PLATAF	:= SB1->B1_PLATAF
			SZD->ZD_PLATEXT	:= SB1->B1_PLATEXT
			SZD->ZD_ITECC	:= SB1->B1_ITEMCC
			SZD->ZD_PUBLISH	:= SB1->B1_PUBLISH
			SZD->ZD_DESCCAT	:= SB1->B1_DESCCAT
			SZD->ZD_DESCCLA	:= SB1->B1_DESCCLA
			SZD->ZD_QUANT	:= GETADVFVAL("SZB","ZB_QUANT",xFilial("SZB")+aZAAtiv[nn,1]+cArqDEV->PRODUTO,1,"")
			SZD->ZD_RECEITA	:= GETADVFVAL("SZB","ZB_RECEITA",xFilial("SZB")+aZAAtiv[nn,1]+cArqDEV->PRODUTO,1,"")
			SZD->ZD_PRCVEN	:= GETADVFVAL("SZB","ZB_PRCVEN",xFilial("SZB")+aZAAtiv[nn,1]+cArqDEV->PRODUTO,1,"")
			SZD->ZD_LBRUT	:= GETADVFVAL("SZB","ZB_LBRUT",xFilial("SZB")+aZAAtiv[nn,1]+cArqDEV->PRODUTO,1,"")
			SZD->ZD_LLIQU	:= GETADVFVAL("SZB","ZB_LLIQU",xFilial("SZB")+aZAAtiv[nn,1]+cArqDEV->PRODUTO,1,"")
			SZD->ZD_CMVDIA 	:= nCmvDia
		EndIf
		
		dbSelectArea("SB1")
		dbCloseArea()
		
		nQdvDia	:= cArqDEV->QTDDEV
		nVdvDia	:= cArqDEV->VALBRUTO
		nVlSImpd:= cArqDEV->(VLRTOTAL-VALICM-PIS-COFINS)
		nLBBrut	:= (SZD->ZD_VLSIMPD-cArqDEV->(VLRTOTAL-VALICM-PIS-COFINS))-(SZD->ZD_CMVDIA*(SZD->ZD_QFTDIA-cArqDEV->QTDDEV))
		nLLdia	:= iif(SZD->ZD_VLSIMPD-nVlSImpd>0,nLBBrut-((SZD->ZD_VLSIMPD-nVlSImpd)*(nfator/100)),nLBBrut)
		
/*		nQdvAcm	:= nQdvAcm+nQdvDia
		nVdvAcm	:= nVdvAcm+nVdvDia
		
		nVlSImpt:= nDvImpt+nVlSImpd
		nLBrAcm	:= nLBrAcm + nLBBrut //(SZD->ZD_VLSIMPT-nVlSImpt)-(SZD->ZD_CUSTTOT-(nQdvAcm*SZD->ZD_CMVDIA))
		nCmvAcm	:= SZD->ZD_CMVDIA
		nLLiAcm	:= nLLiAcm + nLLdia //iif(SZD->ZD_VLSIMPT-nVlSImpt>0,nLBrAcm-((SZD->ZD_VLSIMPT-nVlSImpt)*(nfator/100)),nLBrAcm)
		nAtgAcm	:= (nLLiAcm/SZD->ZD_LLIQU)*100*/
		
		//DIARIOS
		SZD->ZD_QDVDIA	:= nQdvDia
		SZD->ZD_VDVDIA	:= nVdvDia
		SZD->ZD_DVSIMP	:= nVlSImpd
		SZD->ZD_LBRDIA	:= nLBBrut
		SZD->ZD_LLDIA 	:= nLLdia
		SZD->ZD_CMDEVDI	:= nQdvDia*SZD->ZD_CMVDIA
		
		//ACUMULADOS
/*		SZD->ZD_QDVACM	:= nQdvAcm
		SZD->ZD_VDVACM	:= nVdvAcm
		SZD->ZD_LBRACM	:= nLBrAcm
		SZD->ZD_LLIACM	:= nLLiAcm
		SZD->ZD_ATGACM	:= nAtgAcm
		SZD->ZD_DVSIMPT	:= nVlSImpt
		SZD->ZD_CMDEVTO	:= nCMVDVTOT + (nQdvDia*SZD->ZD_CMVDIA) //nQdvAcm*SZD->ZD_CMVDIA
		*/
		MsUnlock()
		//
		cArqDEV->(DBSKIP())
	EndDo
	//FIM DOS TRATAMENTOS
	dbSelectArea("cArqDEV")
	dbCloseArea()
	
Next nn


Return
