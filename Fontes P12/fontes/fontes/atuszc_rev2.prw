#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuSZC2    ºAutor  ³Microsiga           º Data ³  05/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function AtuSZC2

Local lAuto := IIF(Select("SM0") > 0, .f., .t.)
Local _aArea := GetArea()

IF lAuto
	QOUT("Preparando Environment ... "+dtoc(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SZA,SZB,SZC,SB1,SB2,SA1,SA2,SC5,SC6,SC9,SD2,SF2,SF1,SD1,SF4'
	dDtAtu	:= ddatabase
Else
	If !Pergunte("ATUSZC",.T.)
		Return(nil)
	EndIf
	dDtAtu	:= mv_par01
ENDIF

Private cCodPro	:= "" //ZC_CODPRO
Private cUPC		:= "" //ZC_UPC
Private cXDesc	:= "" //ZC_XDESC
Private nQtd		:= 0 //ZC_QUANT
Private nReceita	:= 0 //ZC_RECEITA
Private nPrcVen	:= 0 //ZC_PRCVEN
Private nLBrut	:= 0 //ZC_LBRUT
Private nLLiqu	:= 0 //ZC_LLIQU
Private nEstoque	:= 0 //ZC_ESTOQUE
Private dDataApur	:= dDtAtu
Private nQftDia	:= 0 //ZC_QFTDIA
Private nVftDia	:= 0 //ZC_VFTDIA
Private nPmddia	:= 0 //ZC_PMDDIA
Private nLBBrut	:= 0 //ZC_LBBRUT
Private nCmvDia	:= 0 //ZC_CMVDIA
Private nLLdia	:= 0 //ZC_LLDIA
Private nMkpdia	:= 0 //ZC_MKPDIA
Private nQpdAcm	:= 0 //ZC_QPDACM
Private nVpdAcm	:= 0 //ZC_VPDACM
Private nQftAcm	:= 0 //ZC_QFTACM
Private nVftAcm	:= 0 //ZC_VFTACM
Private nPmdAcm	:= 0 //ZC_PMDACM
Private nLBrAcm	:= 0 //ZC_LBRACM
Private nCmvAcm	:= 0 //ZC_CMVACM
Private nMkpAcm	:= 0 //ZC_MKPACM
Private nLLiAcm	:= 0 //ZC_LLIACM
Private nAtgAcm	:= 0 //ZC_ATGACM
Private nVlSImpd:= 0 //ZC_VLSIMPD
Private nVlSImpt:= 0 //ZC_VLSIMPT
Private nCustDia:= 0 //ZC_CUSTDIA
Private nCustTot:= 0 //ZC_CUSTTOT
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
	//Bloco para buscar os pedidos em carteira
	cArqSZC	:= CriaTrab(,.F.)		//Nome do arq. temporario
	cQry := ""
	cQry += CRLF+" SELECT ZB_COD, ZB_CODPRO, ZB_UPC, ZB_XDESC, ZB_QUANT, ZB_RECEITA, ZB_PRCVEN, ZB_LBRUT, ZB_LLIQU,
	cQry += CRLF+" QFAT_DIA,
	cQry += CRLF+" VALBRUT_DIA,
	cQry += CRLF+" VLSIMP_DIA,
	cQry += CRLF+" QDEV_DIA,
	cQry += CRLF+" DEVVALBRUTO_DIA,
	cQry += CRLF+" DEVVLSIMP_DIA,
	cQry += CRLF+" PRMEDIO_DIA,
	cQry += CRLF+" CMVUNIT_DIA,
	cQry += CRLF+" CMVFT_DIA,
	cQry += CRLF+" CMVDV_DIA,
	cQry += CRLF+" LBRUT_DIA,
	cQry += CRLF+" MARKUP_DIA,
	cQry += CRLF+" LLIQ_DIA,
	cQry += CRLF+" CASE WHEN QTDPED IS NULL THEN 0 ELSE QTDPED END QTDPED,
	cQry += CRLF+" CASE WHEN VALPED IS NULL THEN 0 ELSE VALPED END VALPED,
	cQry += CRLF+" QFAT_ACM, VALBRUT_ACM,
	cQry += CRLF+" VLSIMPT, QDEV_ACM, DEVVALBRUTO_ACM, DEVVLSIMPT, PRMEDIO,CMVUNIT,
	cQry += CRLF+" CMVFTTOT, CMVDVTOT, LBRUT_ACM, MARKUP_TOT,LLIQ_ACM,
	cQry += CRLF+" PERCATG
	cQry += CRLF+" FROM (SELECT ZB_COD, ZB_CODPRO, ZB_UPC, ZB_XDESC, ZB_QUANT, ZB_RECEITA,
	cQry += CRLF+" 	ZB_PRCVEN, ZB_LBRUT, ZB_LLIQU,CODCAMP, PRODUTO, QFAT_ACM, VALBRUT_ACM,
	cQry += CRLF+" 	VLSIMPT, QDEV_ACM, DEVVALBRUTO_ACM, DEVVLSIMPT, PRMEDIO,CMVUNIT,
	cQry += CRLF+" 	CMVFTTOT, CMVDVTOT, LBRUT_ACM, MARKUP_TOT,LLIQ_ACM,
	cQry += CRLF+" 	CASE WHEN LLIQ_ACM = 0 THEN 0 ELSE ROUND((LLIQ_ACM/ZB_LLIQU)*100,2) END PERCATG
	cQry += CRLF+" 	FROM SZB010 SZB,
	cQry += CRLF+" 		(SELECT CODCAMP,
	cQry += CRLF+" 		PRODUTO,
	cQry += CRLF+" 		QFATDIA QFAT_ACM,
	cQry += CRLF+" 		VALBRUTO VALBRUT_ACM,
	cQry += CRLF+" 		VLSIMPT,
	cQry += CRLF+" 		QDEVDIA QDEV_ACM,
	cQry += CRLF+" 		DEVVALBRUTO DEVVALBRUTO_ACM,
	cQry += CRLF+" 		DEVVLSIMPT,
	cQry += CRLF+" 		CASE WHEN QFATDIA = 0 THEN 0 ELSE ROUND(VALBRUTO/QFATDIA,2) END PRMEDIO,
	cQry += CRLF+" 		CASE WHEN QFATDIA = 0 THEN 0 ELSE ROUND(CMVFTTOT/QFATDIA,2) END CMVUNIT,
	cQry += CRLF+" 		CMVFTTOT,
	cQry += CRLF+" 		CMVDVTOT,
	cQry += CRLF+" 		(VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT) LBRUT_ACM,
	cQry += CRLF+" 		CASE WHEN CMVFTTOT-CMVDVTOT = 0 THEN 0 ELSE ROUND((VLSIMPT - DEVVLSIMPT)/(CMVFTTOT-CMVDVTOT),2) END MARKUP_TOT,
	cQry += CRLF+" 		CASE WHEN VLSIMPT - DEVVLSIMPT > 0
	cQry += CRLF+" 		THEN ROUND(((VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT))-((VLSIMPT - DEVVLSIMPT)*("+alltrim(str(nfator))+"/100)),2)
	cQry += CRLF+" 		ELSE  (VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT) END LLIQ_ACM
	cQry += CRLF+" 		FROM
	cQry += CRLF+" 		(SELECT ZB_COD CODCAMPFAT,
	cQry += CRLF+" 			ZB_CODPRO PRODUTOFAT,
	cQry += CRLF+" 			CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END VALMERC,
	cQry += CRLF+" 			CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END VALBRUTO,
	cQry += CRLF+" 			CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QFATDIA,
	cQry += CRLF+" 			CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVFTTOT,
	cQry += CRLF+" 			CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END VLSIMPT,
	cQry += CRLF+" 			CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END LBRUT,
	cQry += CRLF+" 			CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END LLIQ
	cQry += CRLF+" 			FROM SZB010 SZB,
	cQry += CRLF+" 			(SELECT D2_COD PRODUTO, SUM(D2_TOTAL) VALMERC,
	cQry += CRLF+" 				SUM(D2_VALBRUT) VALBRUTO, SUM(D2_QUANT) QFATDIA, SUM(D2_CUSTO1) CMVFTTOT,
	cQry += CRLF+" 				SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5) VLSIMPT,
	cQry += CRLF+" 				(SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))-(SUM(D2_CUSTO1)) LBRUT,
	cQry += CRLF+" 				ROUND((SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))-(SUM(D2_CUSTO1)) - ((SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))*("+alltrim(str(nfator))+"/100)),2) LLIQ
	cQry += CRLF+" 				FROM SD2010 SD2, SF4010 SF4, SF2010 SF2
	cQry += CRLF+" 				WHERE D2_FILIAL = '"+xFilial("SD2")+"'
	cQry += CRLF+" 				AND D2_EMISSAO BETWEEN '"+dtos(aZAAtiv[nn,3])+"' AND '"+dtos(dDtAtu)+"'
	cQry += CRLF+" 				AND D2_TIPO NOT IN ('D', 'B')
	cQry += CRLF+" 				AND F2_FILIAL  = '"+xFilial("SF2")+"'
	cQry += CRLF+" 				AND D2_DOC     = F2_DOC
	cQry += CRLF+" 				AND D2_SERIE   = F2_SERIE
	cQry += CRLF+" 				AND D2_CLIENTE = F2_CLIENTE
	cQry += CRLF+" 				AND D2_LOJA    = F2_LOJA
	cQry += CRLF+" 				AND F4_FILIAL  = '"+xFilial("SF4")+"'
	cQry += CRLF+" 				AND F4_CODIGO  = D2_TES
	cQry += CRLF+" 				AND SF4.F4_ESTOQUE = 'S'
	cQry += CRLF+" 				AND SF4.F4_DUPLIC = 'S'
	cQry += CRLF+" 				AND SD2.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SF2.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SF4.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SD2.D2_COD IN(SELECT ZB_CODPRO FROM SZB010 WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += CRLF+" 				GROUP BY D2_COD) VWAPUR
	cQry += CRLF+" 			WHERE SZB.D_E_L_E_T_ = ' '
	cQry += CRLF+" 			AND ZB_CODPRO = VWAPUR.PRODUTO(+)) FAT,
	cQry += CRLF+" 		(SELECT ZB_COD CODCAMP,
	cQry += CRLF+" 		ZB_CODPRO PRODUTO,
	cQry += CRLF+" 		CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END DEVVALMERC,
	cQry += CRLF+" 		CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END DEVVALBRUTO,
	cQry += CRLF+" 		CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QDEVDIA,
	cQry += CRLF+" 		CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVDVTOT,
	cQry += CRLF+" 		CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END DEVVLSIMPT,
	cQry += CRLF+" 		CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END DEVLBRUT,
	cQry += CRLF+" 		CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END DEVLLIQ
	cQry += CRLF+" 		FROM SZB010 SZB,
	cQry += CRLF+" 		(SELECT D1_COD PRODUTO, SUM(D1_TOTAL) VALMERC,
	cQry += CRLF+" 			SUM(D1_TOTAL+D1_VALIPI+D1_ICMSRET) VALBRUTO, SUM(D1_QUANT) QFATDIA, SUM(D1_CUSTO) CMVFTTOT,
	cQry += CRLF+" 			SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5) VLSIMPT,
	cQry += CRLF+" 			(SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) LBRUT,
	cQry += CRLF+" 			ROUND((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) - ((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))*("+alltrim(str(nfator))+"/100)),2) LLIQ
	cQry += CRLF+" 			FROM SD1010 SD1, SF4010 SF4, SF1010 SF1
	cQry += CRLF+" 			WHERE D1_FILIAL = '"+xFilial("SD1")+"'
	cQry += CRLF+" 			AND D1_DTDIGIT BETWEEN '"+dtos(aZAAtiv[nn,3])+"' AND '"+dtos(dDtAtu)+"'
	cQry += CRLF+" 			AND D1_TIPO = 'D'
	cQry += CRLF+" 			AND F1_FILIAL  = '"+xFilial("SF1")+"'
	cQry += CRLF+" 			AND D1_DOC     = F1_DOC
	cQry += CRLF+" 			AND D1_SERIE   = F1_SERIE
	cQry += CRLF+" 			AND D1_FORNECE = F1_FORNECE
	cQry += CRLF+" 			AND D1_LOJA    = F1_LOJA
	cQry += CRLF+" 			AND F4_FILIAL  = '"+xFilial("SF4")+"'
	cQry += CRLF+" 			AND F4_CODIGO  = D1_TES
	cQry += CRLF+" 			AND SF4.F4_ESTOQUE = 'S'
	cQry += CRLF+" 			AND SF4.F4_DUPLIC = 'S'
	cQry += CRLF+" 			AND SD1.D_E_L_E_T_ = ' '
	cQry += CRLF+" 			AND SF1.D_E_L_E_T_ = ' '
	cQry += CRLF+" 			AND SF4.D_E_L_E_T_ = ' '
	cQry += CRLF+" 			AND SD1.D1_COD IN(SELECT ZB_CODPRO FROM SZB010 WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += CRLF+" 			GROUP BY D1_COD) VWAPUR
	cQry += CRLF+" 		WHERE SZB.D_E_L_E_T_ = ' '
	cQry += CRLF+" 		AND ZB_CODPRO = VWAPUR.PRODUTO(+)) DEV
	cQry += CRLF+" 		WHERE FAT.PRODUTOFAT = DEV.PRODUTO) VWSZC
	cQry += CRLF+" 	WHERE SZB.D_E_L_E_T_ = ' '
	cQry += CRLF+" 	AND ZB_FILIAL = '"+xFilial("SZB")+"'
	cQry += CRLF+" 	AND ZB_COD = '"+aZAAtiv[nn,1]+"'
	cQry += CRLF+" 	AND SZB.ZB_COD  = VWSZC.CODCAMP
	cQry += CRLF+" 	AND SZB.ZB_CODPRO = VWSZC.PRODUTO) APURSZC,
	cQry += CRLF+" (SELECT C6_PRODUTO PRODUTO, SUM(C6_QTDVEN-C6_QTDENT) QTDPED, SUM((C6_QTDVEN-C6_QTDENT)*C6_PRCVEN) VALPED
	cQry += CRLF+" 	FROM SC6010 SC6, SF4010 SF4, SC5010 SC5
	cQry += CRLF+" 	WHERE SC6.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' ' AND SC5.D_E_L_E_T_ = ' '
	cQry += CRLF+" 	AND C6_QTDVEN > C6_QTDENT
	cQry += CRLF+" 	AND C6_BLQ <> 'R'
	cQry += CRLF+" 	AND C5_FILIAL = C6_FILIAL
	cQry += CRLF+" 	AND C5_NUM = C6_NUM
	cQry += CRLF+" 	AND C5_EMISSAO <= '"+dtos(dDtAtu)+"'
	cQry += CRLF+" 	AND C5_EMISSAO >= '"+dtos(aZAAtiv[nn,3])+"'
	cQry += CRLF+" 	AND SC6.C6_TES = SF4.F4_CODIGO
	cQry += CRLF+" 	AND SC6.C6_FILIAL = '"+xFilial("SC6")+"'
	cQry += CRLF+" 	AND SF4.F4_FILIAL = '"+xFilial("SF4")+"'
	cQry += CRLF+" 	AND SF4.F4_DUPLIC = 'S'
	cQry += CRLF+" 	AND SF4.F4_ESTOQUE = 'S'
	cQry += CRLF+" 	AND SC5.C5_LIBEROK = 'S'
	cQry += CRLF+" 	AND SC6.C6_PRODUTO IN (SELECT ZB_CODPRO FROM SZB010 WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += CRLF+" 	GROUP BY C6_PRODUTO) PEDLIB,
	cQry += CRLF+" (SELECT ZB_COD COD_DIA, ZB_CODPRO CODPRO_DIA, QFAT_ACM QFAT_DIA, VALBRUT_ACM VALBRUT_DIA,
	cQry += CRLF+" 	VLSIMPT VLSIMP_DIA, QDEV_ACM QDEV_DIA, DEVVALBRUTO_ACM DEVVALBRUTO_DIA, DEVVLSIMPT DEVVLSIMP_DIA, PRMEDIO PRMEDIO_DIA,CMVUNIT CMVUNIT_DIA,
	cQry += CRLF+" 	CMVFTTOT CMVFT_DIA, CMVDVTOT CMVDV_DIA, LBRUT_ACM LBRUT_DIA, MARKUP_TOT MARKUP_DIA,LLIQ_ACM LLIQ_DIA
	cQry += CRLF+" 	FROM SZB010 SZB,
	cQry += CRLF+" 	(SELECT CODCAMP,
	cQry += CRLF+" 		PRODUTO,
	cQry += CRLF+" 	QFATDIA QFAT_ACM,
	cQry += CRLF+" 	VALBRUTO VALBRUT_ACM,
	cQry += CRLF+" 	VLSIMPT,
	cQry += CRLF+" 	QDEVDIA QDEV_ACM,
	cQry += CRLF+" 	DEVVALBRUTO DEVVALBRUTO_ACM,
	cQry += CRLF+" 	DEVVLSIMPT,
	cQry += CRLF+" 	CASE WHEN QFATDIA = 0 THEN 0 ELSE ROUND(VALBRUTO/QFATDIA,2) END PRMEDIO,
	cQry += CRLF+" 	CASE WHEN QFATDIA = 0 THEN 0 ELSE ROUND(CMVFTTOT/QFATDIA,2) END CMVUNIT,
	cQry += CRLF+" 	CMVFTTOT,
	cQry += CRLF+" 	CMVDVTOT,
	cQry += CRLF+" 	(VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT) LBRUT_ACM,
	cQry += CRLF+" 	CASE WHEN CMVFTTOT-CMVDVTOT = 0 THEN 0 ELSE ROUND((VLSIMPT - DEVVLSIMPT)/(CMVFTTOT-CMVDVTOT),2) END MARKUP_TOT,
	cQry += CRLF+" 	CASE WHEN VLSIMPT - DEVVLSIMPT > 0
	cQry += CRLF+" 		THEN ROUND(((VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT))-((VLSIMPT - DEVVLSIMPT)*("+alltrim(str(nfator))+"/100)),2)
	cQry += CRLF+" 		ELSE  (VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT) END LLIQ_ACM
	cQry += CRLF+" 		FROM
	cQry += CRLF+" 		(SELECT ZB_COD CODCAMPFAT,
	cQry += CRLF+" 			ZB_CODPRO PRODUTOFAT,
	cQry += CRLF+" 			CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END VALMERC,
	cQry += CRLF+" 			CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END VALBRUTO,
	cQry += CRLF+" 			CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QFATDIA,
	cQry += CRLF+" 			CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVFTTOT,
	cQry += CRLF+" 			CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END VLSIMPT,
	cQry += CRLF+" 			CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END LBRUT,
	cQry += CRLF+" 			CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END LLIQ
	cQry += CRLF+" 			FROM SZB010 SZB,
	cQry += CRLF+" 			(SELECT D2_COD PRODUTO, SUM(D2_TOTAL) VALMERC,
	cQry += CRLF+" 				SUM(D2_VALBRUT) VALBRUTO, SUM(D2_QUANT) QFATDIA, SUM(D2_CUSTO1) CMVFTTOT,
	cQry += CRLF+" 				SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5) VLSIMPT,
	cQry += CRLF+" 				(SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))-(SUM(D2_CUSTO1)) LBRUT,
	cQry += CRLF+" 				ROUND((SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))-(SUM(D2_CUSTO1)) - ((SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))*("+alltrim(str(nfator))+"/100)),2) LLIQ
	cQry += CRLF+" 				FROM SD2010 SD2, SF4010 SF4, SF2010 SF2
	cQry += CRLF+" 				WHERE D2_FILIAL = '"+xFilial("SD2")+"'
	cQry += CRLF+" 				AND D2_EMISSAO = '"+dtos(dDtAtu)+"'
	cQry += CRLF+" 				AND D2_TIPO NOT IN ('D', 'B')
	cQry += CRLF+" 				AND F2_FILIAL  = '"+xFilial("SF2")+"'
	cQry += CRLF+" 				AND D2_DOC     = F2_DOC
	cQry += CRLF+" 				AND D2_SERIE   = F2_SERIE
	cQry += CRLF+" 				AND D2_CLIENTE = F2_CLIENTE
	cQry += CRLF+" 				AND D2_LOJA    = F2_LOJA
	cQry += CRLF+" 				AND F4_FILIAL  = '"+xFilial("SF4")+"'
	cQry += CRLF+" 				AND F4_CODIGO  = D2_TES
	cQry += CRLF+" 				AND SF4.F4_ESTOQUE = 'S'
	cQry += CRLF+" 				AND SF4.F4_DUPLIC = 'S'
	cQry += CRLF+" 				AND SD2.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SF2.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SF4.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SD2.D2_COD IN(SELECT ZB_CODPRO FROM SZB010 WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += CRLF+" 				GROUP BY D2_COD) VWAPUR
	cQry += CRLF+" 			WHERE SZB.D_E_L_E_T_ = ' '
	cQry += CRLF+" 			AND ZB_CODPRO = VWAPUR.PRODUTO(+)) FAT,
	cQry += CRLF+" 		(SELECT ZB_COD CODCAMP,
	cQry += CRLF+" 			ZB_CODPRO PRODUTO,
	cQry += CRLF+" 			CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END DEVVALMERC,
	cQry += CRLF+" 			CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END DEVVALBRUTO,
	cQry += CRLF+" 			CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QDEVDIA,
	cQry += CRLF+" 			CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVDVTOT,
	cQry += CRLF+" 			CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END DEVVLSIMPT,
	cQry += CRLF+" 			CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END DEVLBRUT,
	cQry += CRLF+" 			CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END DEVLLIQ
	cQry += CRLF+" 			FROM SZB010 SZB,
	cQry += CRLF+" 			(SELECT D1_COD PRODUTO, SUM(D1_TOTAL) VALMERC,
	cQry += CRLF+" 				SUM(D1_TOTAL+D1_VALIPI+D1_ICMSRET) VALBRUTO, SUM(D1_QUANT) QFATDIA, SUM(D1_CUSTO) CMVFTTOT,
	cQry += CRLF+" 				SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5) VLSIMPT,
	cQry += CRLF+" 				(SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) LBRUT,
	cQry += CRLF+" 				ROUND((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) - ((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))*("+alltrim(str(nfator))+"/100)),2) LLIQ
	cQry += CRLF+" 				FROM SD1010 SD1, SF4010 SF4, SF1010 SF1
	cQry += CRLF+" 				WHERE D1_FILIAL = '"+xFilial("SD1")+"'
	cQry += CRLF+" 				AND D1_DTDIGIT = '"+dtos(dDtAtu)+"'
	cQry += CRLF+" 				AND D1_TIPO = 'D'
	cQry += CRLF+" 				AND F1_FILIAL  = '"+xFilial("SF1")+"'
	cQry += CRLF+" 				AND D1_DOC     = F1_DOC
	cQry += CRLF+" 				AND D1_SERIE   = F1_SERIE
	cQry += CRLF+" 				AND D1_FORNECE = F1_FORNECE
	cQry += CRLF+" 				AND D1_LOJA    = F1_LOJA
	cQry += CRLF+" 				AND F4_FILIAL  = '"+xFilial("SF4")+"'
	cQry += CRLF+" 				AND F4_CODIGO  = D1_TES
	cQry += CRLF+" 				AND SF4.F4_ESTOQUE = 'S'
	cQry += CRLF+" 				AND SF4.F4_DUPLIC = 'S'
	cQry += CRLF+" 				AND SD1.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SF1.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SF4.D_E_L_E_T_ = ' '
	cQry += CRLF+" 				AND SD1.D1_COD IN(SELECT ZB_CODPRO FROM SZB010 WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+aZAAtiv[nn,1]+"' AND ZB_FILIAL = '"+xFilial("SZB")+"')
	cQry += CRLF+" 				GROUP BY D1_COD) VWAPUR
	cQry += CRLF+" 			WHERE SZB.D_E_L_E_T_ = ' '
	cQry += CRLF+" 			AND ZB_CODPRO = VWAPUR.PRODUTO(+)) DEV
	cQry += CRLF+" 		WHERE FAT.PRODUTOFAT = DEV.PRODUTO) VWSZC
	cQry += CRLF+" 	WHERE SZB.D_E_L_E_T_ = ' '
	cQry += CRLF+" 	AND ZB_FILIAL = '"+xFilial("SZB")+"'
	cQry += CRLF+" 	AND ZB_COD = '"+aZAAtiv[nn,1]+"'
	cQry += CRLF+" 	AND SZB.ZB_COD  = VWSZC.CODCAMP
	cQry += CRLF+" 	AND SZB.ZB_CODPRO = VWSZC.PRODUTO) APURDIA
	cQry += CRLF+" WHERE APURSZC.ZB_CODPRO = PEDLIB.PRODUTO(+)
	cQry += CRLF+" AND APURSZC.ZB_CODPRO = APURDIA.CODPRO_DIA
	
	cQry := ChangeQuery(cQry)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqSZC",.T.,.T.)
	
	While cArqszc->(!Eof())
	
	aSaldo := CalcEst( cArqSZC->ZB_CODPRO,"01",dDataApur+1,xfilial("SB2"))
	nEstDia := aSaldo[1]
	nCmvDia	:= aSaldo[2]/nEstDia		
	
	DbSelectArea("SZC")
	DbSetOrder(2)
	If !dbseek(xfilial("SZC")+DTOS(dDataApur)+aZAAtiv[nn,1]+cArqSZC->ZB_CODPRO)
		RecLock('SZC',.T.)
	Else
		RecLock('SZC',.F.)
	EndIf
	SZC->ZC_DATA 	:= dDataApur
	SZC->ZC_FILIAL	:= xFilial("SZC")
	SZC->ZC_COD 	:= aZAAtiv[nn,1]
	SZC->ZC_DESCR 	:= aZAAtiv[nn,2]
	SZC->ZC_CODPRO 	:= cArqSZC->ZB_CODPRO
	SZC->ZC_UPC		:= cArqSZC->ZB_UPC
	SZC->ZC_XDESC	:= cArqSZC->ZB_XDESC
	SZC->ZC_QUANT	:= cArqSZC->ZB_QUANT
	SZC->ZC_RECEITA	:= cArqSZC->ZB_RECEITA
	SZC->ZC_PRCVEN	:= cArqSZC->ZB_PRCVEN
	SZC->ZC_LBRUT	:= cArqSZC->ZB_LBRUT
	SZC->ZC_LLIQU	:= cArqSZC->ZB_LLIQU
	SZC->ZC_ESTOQUE	:= nEstDia
	SZC->ZC_QPDACM	:= cArqSZC->QTDPED
	SZC->ZC_VPDACM	:= cArqSZC->VALPED
	SZC->ZC_CMVDIA 	:= cArqSZC->CMVUNIT_DIA

	//VALORES FATURAMENTO DIA
	SZC->ZC_QFTDIA	:= cArqSZC->QFAT_DIA
	SZC->ZC_VFTDIA	:= cArqSZC->VALBRUT_DIA
	SZC->ZC_VLSIMPD	:= cArqSZC->VLSIMP_DIA
	SZC->ZC_PMDDIA	:= cArqSZC->PRMEDIO_DIA
	SZC->ZC_CUSTDIA	:= cArqSZC->CMVFT_DIA
	//VALORES DEVOLUÇÕES DIA
	SZC->ZC_QDVDIA	:= cArqSZC->QDEV_DIA
	SZC->ZC_VDVDIA	:= cArqSZC->DEVVALBRUTO_DIA
	SZC->ZC_DVSIMP	:= cArqSZC->DEVVLSIMP_DIA
	SZC->ZC_CMDEVDI	:= cArqSZC->CMVDV_DIA
	//VALORES APURAÇÃO DIA
	SZC->ZC_LBRDIA	:= cArqSZC->LBRUT_DIA
	SZC->ZC_LLDIA 	:= cArqSZC->LLIQ_DIA
	SZC->ZC_MKPDIA	:= cArqSZC->MARKUP_DIA


	//ACUMULADOS
	SZC->ZC_CMVACM	:= cArqSZC->CMVUNIT
	//ACUMULADOS FATURAMENTO
	SZC->ZC_QFTACM	:= cArqSZC->QFAT_ACM
	SZC->ZC_VFTACM	:= cArqSZC->VALBRUT_ACM
	SZC->ZC_VLSIMPT	:= cArqSZC->VLSIMPT
	SZC->ZC_PMDACM	:= cArqSZC->PRMEDIO
	SZC->ZC_CUSTTOT	:= cArqSZC->CMVFTTOT
	//ACUMULADOS DEVOLUÇÃO
	SZC->ZC_QDVACM	:= cArqSZC->QDEV_ACM
	SZC->ZC_VDVACM	:= cArqSZC->DEVVALBRUTO_ACM
	SZC->ZC_DVSIMPT	:= cArqSZC->DEVVLSIMPT
	SZC->ZC_CMDEVTO	:= cArqSZC->CMVDVTOT
	//ACUMULADOS APURAÇÃO
	SZC->ZC_LBRACM	:= cArqSZC->LBRUT_ACM
	SZC->ZC_LLIACM	:= cArqSZC->LLIQ_ACM
	SZC->ZC_MKPACM	:= cArqSZC->MARKUP_TOT
	SZC->ZC_ATGACM	:= cArqSZC->PERCATG
	
	MsUnlock()
	
	
		dbSelectArea("cArqSZC")
		dbskip()
	End
	dbSelectArea("cArqSZC")
	dbCloseArea()
	
Next nn


Return
