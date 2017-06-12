#include 'protheus.ch'
#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "shell.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR002  บAutor  ณMicrosiga           บ Data ณ  12/13/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NcGames                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

user function NcTrack001()
Local aArea := GetArea()
Local cPerg := "TRK001"
Local cHoraIni := Time()
Local cHoraFim
ajustaSX1()
Pergunte(cPerg,.t.)
impRel()

cHoraFim := Time()

Alert("Finalizado. Hora Inicio:"+ cHoraIni + " Hora Fim:"+ cHoraFim)

RestArea(aArea)
return         

static function impRel()
Local aArea := GetArea()
Local aCab  :={}
Local aItem :={}
Local aLinhas:={}
Local cQuery := ""   
Local cAlias := GetNextAlias()


cQuery += " SELECT                                                                                                                                              "
cQuery += " distinct *                                                                                                                                                   "
cQuery += " FROM                                                                                                                                                "
cQuery += " (SELECT                                                                                                                                             "
cQuery += " DISTINCT SC5.C5_FILIAL||SC5.C5_NUM CHAVE,                                                                                                                    "
cQuery += " SC5.C5_FILIAL	FILIAL	,	                                                                                                         "
cQuery += " SC5.C5_NUM	NUMPED	,	                                                                                                             "
cQuery += " SC5.C5_PEDCLI	PEDCLI	,	                                                                                                 "
cQuery += " SC5.C5_YDCANAL CANAL,																			                                               "
cQuery += " SC5.C5_CODCAMP CAMP,  "
cQuery += " SC5.C5_DESCCAM DCAMP, "
cQuery += " SC5.C5_EMISSAO	EMISPED	,	                                                                                                "
cQuery += " SC5.C5_CLIENTE	CLIENT	,	                                                                                                    "
cQuery += " SC5.C5_LOJACLI	LOJA	,	                                                                                                        "
cQuery += " SA1.A1_NREDUZ	NOMECLI	,	                                                                                                 "
cQuery += " SC5.C5_VEND1	VEND	,	                                                                                                     "
cQuery += " DECODE(SA1.A1_AGEND,'1','SIM','2','NAO',null,'NAO',' ','NAO')	AGENDAM	,	                                                                     "
cQuery += " SC6.C6_TPOPER||'-'||SX5.X5_DESCRI	TPOPER	,	                                                                                            "
cQuery += " SA1.A1_MUN	CIDADE	,	                                                                                                             "
cQuery += " SA1.A1_EST	UF	,	                                                                                                                 "
cQuery += " SA1.A1_CEP	CEP	,	                                                                                                                    "
cQuery += " SA1.A1_ENDENT	ENDENT	,	                                                                                             "
cQuery += " SA1.A1_BAIRROE	BAIRROE	,	                                                                                             "
cQuery += " sum(SC6.C6_VALOR)	VLRPED	,	                                                                                        "
cQuery += " SC5.C5_LIBEROK	LIBERPED	,	                                                                                             "
cQuery += " UTL_RAW.CAST_TO_VARCHAR2(SC5.C5_YFINOBS)	OBSFIN	,	                                                             "
cQuery += " SC9.C9_DATALIB	DTLIBPED	,	                                                                                    "
cQuery += " SZ7.Z7_HORA	HORALIB	,	                                                                                            "
cQuery += " SC5.C5_TRANSP	TRANSP	,	                                                                                    "
cQuery += " SC5.C5_DTAGEND	DTPREVENT	,	                                                                               "
cQuery += " SC5.C5_DTDISNF	DTDISFT,	                                                                                     "
cQuery += " SUM(SC9.C9_QTDLIB)	QTDITENS	,	                                                                                     "
cQuery += " COUNT(SC9.C9_PRODUTO)	QTDPROD	,	                                                                                "
cQuery += " SC5.C5_YDLIMIT	DTLIMFIN,                                                                            "
cQuery += " DECODE(SC9.C9_BLCRED,'04','X','01','X','09','R',' ',' ') CRED, "
cQuery += " SC9.c9_nfiscal NOTA,	                                                                                         "
cQuery += " SA1.A1_TEL TELEFONE,    "
cQuery += " SA1.A1_EMAIL EMAIL    "
cQuery += " from                                                                                                                                                "
cQuery += " "+RetSqlName("SC5")+" SC5 left join "+RetSqlName("SC6")+" SC6                                                                                                                     "
cQuery += "   on(SC5.C5_FILIAL = SC6.C6_FILIAL AND SC5.C5_NUM = SC6.C6_NUM)                                                                                     "
cQuery += " LEFT JOIN "+RetSqlName("SC9")+" SC9                                                                                                                                "
cQuery += "   on(SC6.C6_FILIAL = SC9.C9_FILIAL AND SC6.C6_ITEM = SC9.C9_ITEM AND SC6.C6_PRODUTO = SC9.C9_PRODUTO AND SC6.C6_NUM = SC9.C9_PEDIDO)                "
cQuery += " LEFT JOIN "+RetSqlName("SA1")+" SA1                                                                                                                                "
cQuery += "   on(SC5.C5_CLIENTE = SA1.A1_COD AND SC5.C5_LOJACLI = SA1.A1_LOJA)                                                                                  "
cQuery += " LEFT JOIN "+RetSqlName("SZ7")+" SZ7                                                                                                                                "
cQuery += "   ON(SC5.C5_FILIAL = SZ7.Z7_FILIAL AND SC5.C5_NUM = SZ7.Z7_NUM AND SC5.C5_CLIENTE = SZ7.Z7_CODCLI)                                                  "
cQuery += " LEFT JOIN "+RetSqlName("SX5")+" SX5                                                                                                                 "
cQuery += "   ON(SC6.C6_TPOPER = SX5.X5_CHAVE AND SX5.X5_TABELA = '16')                                                  "
cQuery += " WHERE                                                                                                                                               "
cQuery += "     SC5.C5_FILIAL = '"+xFilial("SC5")+"'                                                                                                                            "
cQuery += " AND SC5.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += " AND SC6.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += " AND SC9.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += "                                                                                                                             "
cQuery += " AND SZ7.Z7_STAT = '000002'                                                                                                                          "
cQuery += " AND SC5.C5_EMISSAO BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"'                                                                                                "
cQuery += " AND SC9.C9_DATALIB BETWEEN '"+DtoS(MV_PAR03)+"' AND '"+DtoS(MV_PAR04)+"'                                                                                                "
cQuery += " AND (C6_BLQ <> 'R' OR C6_QTDENT <>0)                                                                                                                "
cQuery += " AND (C9_BLEST = ' ' OR C9_BLEST = '10')                                                                                                             "
cQuery += " GROUP BY                                                                                                                                            "
cQuery += " 	SC5.C5_FILIAL||SC5.C5_NUM,                                                                                                                      "
cQuery += "     SC5.C5_FILIAL,                                                                                                                                  "
cQuery += "     SC5.C5_NUM,                                                                                                                                     "
cQuery += "     SC5.C5_PEDCLI,                                                                                                                                  "
cQuery += "     SC5.C5_YDCANAL, "
cQuery += "     SC5.C5_CODCAMP, "
cQuery += "     SC5.C5_DESCCAM, "
cQuery += "     SC5.C5_EMISSAO,                                                                                                                                 "
cQuery += "     SC5.C5_CLIENTE,                                                                                                                                 "
cQuery += "     SC5.C5_LOJACLI,                                                                                                                                 "
cQuery += "     SA1.A1_NREDUZ,                                                                                                                                  "
cQuery += "     SC5.C5_VEND1,                                                                                                                                   "
cQuery += "     SA1.A1_AGEND,                                                                                                                                   "
cQuery += "     SC6.C6_TPOPER||'-'||SX5.X5_DESCRI,                                                                                                                                  "
cQuery += "     SA1.A1_MUN,                                                                                                                                     "
cQuery += "     DECODE(SA1.A1_AGEND,'1','SIM','2','NAO',NULL,'NAO'),                                                                                                       "
cQuery += "     SA1.A1_EST,                                                                                                                                     "
cQuery += "     SA1.A1_CEP,                                                                                                                                     "
cQuery += "     SA1.A1_ENDENT,                                                                                                                                  "
cQuery += "     SA1.A1_BAIRROE,                                                                                                                                 "
cQuery += "     SC5.C5_LIBEROK,                                                                                                                                 "
cQuery += "     UTL_RAW.CAST_TO_VARCHAR2(SC5.C5_YFINOBS),                                                                                                       "
cQuery += "     SC9.C9_DATALIB,                                                                                                                                 "
cQuery += "     SZ7.Z7_HORA,                                                                                                                                    "
cQuery += "     SC5.C5_TRANSP,                                                                                                                                  "
cQuery += "     SC5.C5_DTAGEND,                                                                                                                                 "
cQuery += "     SC5.C5_DTDISNF,                                                                                                                                 "
cQuery += "     SC5.C5_YDLIMIT,                                                                                                                                  "
cQuery += "     SC9.C9_BLCRED, "
cQuery += "     SC9.c9_nfiscal,     "
cQuery += "     SA1.A1_TEL,    "
cQuery += "     SA1.A1_EMAIL    "
cQuery += " ORDER BY                                                                                                                                            "
cQuery += "     SC5.C5_FILIAL, SC5.C5_NUM                                                                                                                       "
cQuery += " )qr1 left join                                                                                                                                      "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT CES_COD_CHAVE CHAVEEXCL, CES_DATA_EXCLUSAO DATEEXC FROM WMS.TB_WMSINTERF_CANC_ENT_SAI                                                        "
cQuery += " ) qr2                                                                                                                                               "
cQuery += " on qr1.CHAVE = QR2.CHAVEEXCL                                                                                                                        "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT                                                                                                                                              "
cQuery += " SZ7.Z7_FILIAL||SZ7.Z7_NUM CHAVELIBCRED,                                                                                                             "
cQuery += " SZ7.Z7_DATA	DTLIBCRED,                                                                                                                              "
cQuery += " SZ7.Z7_HORA	HRLIBCRED                                                                                                                               "
cQuery += " FROM "+RetSqlName("SZ7")+"  SZ7                                                                                                                                    "
cQuery += " WHERE Z7_STAT = '000006'                                                                                                                            "

cQuery += " )qr3                                                                                                                                                "
cQuery += " on qr1.chave = qr3.CHAVELIBCRED                                                                                                                     "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "  
cQuery += " SELECT DOCSEP.DOCUMENTO_ERP CHAVEWMS,  "
cQuery += "           TO_CHAR(DT_HOR_DISPONIVEL_SEPARACAO,'DD/MM/YYYY') DTDISPSEP,  "
cQuery += "           TO_CHAR(DT_HOR_DISPONIVEL_SEPARACAO,'HH24:MI:SS') HRDISPSEP,  "
cQuery += "           TO_CHAR(DT_HOR_INICIO_SEPARACAO,'DD/MM/YYYY') DTINISEP,  "
cQuery += "           TO_CHAR(DT_HOR_INICIO_SEPARACAO,'HH24:MI:SS') HRINISEP,  "
cQuery += "           USUARIO_SEPARACAO USUSEP,  "
cQuery += "           DOCSEP.NUMERO_ROMANEIO ROMANQ4,  "
cQuery += "           DOCSEP.DOCUMENTO_ERP PEDWMS,  "
cQuery += "           DOCSEP.COD_DEPOSITO CODDEP,  "
cQuery += "           TO_CHAR(DT_HOR_DISPONIVEL_CONFERENCIA,'DD/MM/YYYY') DTDISPCONF,    "
cQuery += "           TO_CHAR(DT_HOR_DISPONIVEL_CONFERENCIA,'HH24:MI:SS') HRDISCONF,    "
cQuery += "           TO_CHAR(DT_HOR_INICIO_CONFERENCIA,'DD/MM/YYYY') DTINICONF,  "
cQuery += "           TO_CHAR(DT_HOR_INICIO_CONFERENCIA,'HH24:MI:SS') HRINICONF,  "
cQuery += "           TO_CHAR(DT_HOR_FIM_CONFERENCIA,'DD/MM/YYYY') DTFIMCONF,  "
cQuery += "           USUARIO_CONFERENCIA USUCONF  "
cQuery += "    FROM WMS.VIW_DOC_SEPARACAO_ERP DOCSEP  "
cQuery += "    LEFT OUTER JOIN WMS.VIW_DOC_SAIDA_ERP DOCSAIDA ON(DOCSEP.DOCUMENTO_ERP = DOCSAIDA.DOCUMENTO_ERP)                                                 "                                                    "
cQuery += " )qr4                                                                                                                                                "
cQuery += " on qr1.CHAVE = QR4.CHAVEWMS                                                                                                                            "
cQuery += " left join(                                                                                                                                          "
cQuery += " SELECT                                                                                                                                              "
cQuery += " SZ7.Z7_FILIAL||SZ7.Z7_NUM CHAVEPICK,                                                                                                                "
cQuery += " SZ7.Z7_DATA	DTPICK,                                                                                                                                 "
cQuery += " SZ7.Z7_HORA	HORAPICK                                                                                                                                "
cQuery += " FROM "+RetSqlName("SZ7")+"  SZ7                                                                                                                                    "
cQuery += " WHERE Z7_STAT = '000010'                                                                                                                            "

cQuery += " )QR5                                                                                                                                                "
cQuery += " on qr1.chave = qr5.CHAVEPICK                                                                                                                        "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT                                                                                                                                              "
cQuery += " SZ7.Z7_FILIAL||SZ7.Z7_NUM CHAVETIVOL,                                                                                                               "
cQuery += " SZ7.Z7_DATA	DTETIVOL,                                                                                                                               "
cQuery += " SZ7.Z7_HORA	HRETIVOL                                                                                                                                "
cQuery += " FROM "+RetSqlName("SZ7")+" SZ7                                                                                                                                    "
cQuery += " WHERE Z7_STAT = '000011'                                                                                                                            "

cQuery += " )QR6                                                                                                                                                "
cQuery += " on qr1.chave = qr6.CHAVETIVOL                                                                                                                       "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT                                                                                                                                              "
cQuery += " DISTINCT SD2.D2_FILIAL||SD2.D2_PEDIDO CHAVEDOCNF,                                                                                                        "
cQuery += " F2_DOC	NUMNF	,	                                                                                                    "
cQuery += " F2_SERIE	SERIENF	,                                                                                                                 "
cQuery += " F2_VOLUME1	VOLNF	,                                                                                             "
cQuery += " F2_ESPECIE	ESPEC	,                                                                                                          "
cQuery += " F2_PLIQUI	PLIQUI	,	                                                                                                           "
cQuery += " F2_PBRUTO	PBRUTO	,                                                                                                             "
cQuery += " F2_VALBRUT	VLRTOTNF	,                                                                                                  "
cQuery += " F2_EMISSAO	DTEMISNF	,	                                                                                               "
cQuery += " F2_HORA	HRNF	,                                                                                                           "
cQuery += " F2_DATAAG	DTAGEND	,                                                                                              "
cQuery += " E1_HISTWF	HISTWF	,	                                                                                                  "
cQuery += " SF2.F2_TRANSP TRANSPNF,                                                                                                                             "
cQuery += " SA4.A4_NREDUZ NOMETRANSPNF,                                                                                                                         "
cQuery += " sf2.F2_FRETE + sf2.F2_SEGURO	VL_FRETE	,	                                                                                 "
cQuery += " decode(sf2.F2_TPFRETE,'C','CIF','F','FOB','T','TER','S','SFR')	TP_FRETE                                                     "
cQuery += " FROM                                                                                                                                                "
cQuery += " "+RetSqlName("SF2")+" SF2 LEFT JOIN "+RetSqlName("SD2")+" SD2                                                                                                                     "
cQuery += " ON(SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE)                                                                                         "
cQuery += " LEFT JOIN "+RetSqlName("SE1")+" SE1                                                                                                                                "
cQuery += " ON(SF2.F2_DUPL  = SE1.E1_NUM)                                                                                                                       "
cQuery += " LEFT JOIN "+RetSqlName("SA4")+" SA4                                                                                                                                "
cQuery += " ON(SF2.F2_TRANSP = SA4.A4_COD)                                                                                                                      "
cQuery += " WHERE                                                                                                                                               "
cQuery += "  	SF2.F2_FILIAL = '"+xFilial("SF2")+"'                                                                                                                            "
cQuery += " AND SF2.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += " AND SD2.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += " AND SE1.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += " AND SA4.D_E_L_E_T_ = ' '                                                                                                                            "
cQuery += " )QR7                                                                                                                                                "
cQuery += " on qr1.chave = qr7.CHAVEDOCNF                                                                                                                            "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT                                                                                                                                              "
cQuery += " SZ7.Z7_FILIAL||SZ7.Z7_NUM CHAVEETINF,                                                                                                               "
cQuery += " SZ7.Z7_DATA	DTETINF,                                                                                                                                "
cQuery += " SZ7.Z7_HORA	HORAPICK                                                                                                                                "
cQuery += " FROM "+RetSqlName("SZ7")+" SZ7                                                                                                                                    "
cQuery += " WHERE Z7_STAT = '000012'                                                                                                                            "

cQuery += " )QR8                                                                                                                                                "
cQuery += " on qr1.chave = qr8.CHAVEETINF                                                                                                                       "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT                                                                                                                                              "
cQuery += " DISTINCT SZ1.Z1_FILIAL||SZ1.Z1_PEDIDO CHAVEENTR,                                                                                                        "
cQuery += " Z1_DTSAIDA	DTSAIDA	,	                                                                                                      "
cQuery += " Z1_DTENTRE	DTENTREG		                                                                                           		 "
cQuery += "  FROM "+RetSqlName("SZ1")+" SZ1                                                                                                                                    "
cQuery += "  WHERE                                                                                                                                              "
cQuery += "  SZ1.Z1_FILIAL = '"+xFilial("SZ1")+"'                                                                                                                               "
cQuery += "  AND SZ1.D_E_L_E_T_ = ' '                                                                                                                           "
cQuery += " )QR9                                                                                                                                                "
cQuery += " on qr1.chave = qr9.CHAVEENTR                                                                                                                        "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT DISTINCT NUM_PRE_ROMANEIO ROMANQ10, USUARIO_LEITURA FROM WMS.TB_CONF_VOLUME                                                                     "
cQuery += " )QR10                                                                                                                                               "
cQuery += " on QR4.ROMANQ4 = QR10.ROMANQ10                                                                                                                           "
cQuery += " left join                                                                                                                                           "
cQuery += " (                                                                                                                                                   "
cQuery += " SELECT lpad(NUMNF_NFDESPACHADAS,9,'0') NUMNF, SERIENF_NFDESPACHADAS SERIENF, CNPJ_FILIAISTRANSPORTE CGCTRANSP, trp.RAZAO_SOCIAL TRANSPENTREGA FROM                    "
cQuery += " FRETES.TB_FRTNFDESPACHADAS FTR LEFT JOIN wms.transportador trp                                                                                                "
cQuery += " ON(trp.CNPJ = CNPJ_FILIAISTRANSPORTE)                                                                                                             "
cQuery += " )QR11                                                                                                                                               "
cQuery += " ON QR1.NOTA = LPAD(QR11.NUMNF,9,'0')                                                                                                                           "
cQuery += " left JOIN
cQuery += "    ( "
cQuery += "     SELECT DPCS_COD_CHAVE CHAVEINTR, "
cQuery += "     decode (STATUS,'NP','Nใo processado','P','Integrado ao WMS','ER','Erro de Integra็ao','FR','Aguardando transportadora',null,'Nao enviado ao wms') statuswms  "
cQuery += "     FROM WMS.TB_WMSINTERF_DOC_SAIDA "
cQuery += "    )QR12 ON QR1.CHAVE = QR12.CHAVEINTR "
   
Alert("Aten็ใo, o sistema buscarแ os dados para compor o relat๓rio. O processo pode levar alguns minutos. Favor aguardar...")

cQuery := ChangeQuery(cQuery)
MsgRun("Favor Aguardar, Buscando Registros....", "Buscando Registros",{|| DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)})
//DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)
DbSelectArea(cAlias)

  
AADD(aCab,{"NUMPED","C",150,0} )//1
AADD(aCab,{"ROMAN","C",150,0} )//2
AADD(aCab,{"TPOPER","C",150,0} )//3
AADD(aCab,{"CAMPANHA","C",150,0} )//4
AADD(aCab,{"DESC CAMPANHA","C",150,0} )//5
AADD(aCab,{"EMISPED","C",150,0} )//6
AADD(aCab,{"NOMECLI","C",150,0} )//7
AADD(aCab,{"CIDADE","C",150,0} )//8
AADD(aCab,{"UF","C",150,0} )//9
AADD(aCab,{"CEP","C",150,0} )//10
AADD(aCab,{"ENDENT","C",150,0} )//11
AADD(aCab,{"BAIRROE","C",150,0} )//12
AADD(aCab,{"VLRPED","C",150,0} )//13
AADD(aCab,{"DTLIBPED","C",150,0} )//14
AADD(aCab,{"HORALIB","C",150,0} )//15
AADD(aCab,{"CRED","C",150,0} )//16
AADD(aCab,{"DATEEXC","C",150,0} )//17
AADD(aCab,{"DTLIBCRED","C",150,0} )//18
AADD(aCab,{"HRLIBCRED","C",150,0} )//19
AADD(aCab,{"DTDISPSEP","C",150,0} )//20
AADD(aCab,{"HRDISPSEP","C",150,0} )//20
AADD(aCab,{"DTINISEP","C",150,0} )//21
AADD(aCab,{"HRINISEP","C",150,0} )//22
AADD(aCab,{"USUSEP","C",150,0} )//22
AADD(aCab,{"DTDISPCONF","C",150,0} )//25
AADD(aCab,{"HRDISCONF","C",150,0} )//26
AADD(aCab,{"DTINICONF","C",150,0} )//27
AADD(aCab,{"HRINICONF","C",150,0} )//28
AADD(aCab,{"USUCONF","C",150,0} )//29
AADD(aCab,{"DTEMISNF","C",150,0} )//30
AADD(aCab,{"HRNF","C",150,0} )//31
AADD(aCab,{"DTPICK","C",150,0} )//32
AADD(aCab,{"HORAPICK","C",150,0} )//33
AADD(aCab,{"DTETIVOL","C",150,0} )//34
AADD(aCab,{"HRETIVOL","C",150,0} )//35
AADD(aCab,{"DTETINF","C",150,0} )//36
AADD(aCab,{"HRNF","C",150,0} )//37
AADD(aCab,{"DTFIMCONF","C",150,0} )//38
AADD(aCab,{"HRFIMCONF","C",150,0} )//39
AADD(aCab,{"DTSAIDA","C",150,0} )//40
AADD(aCab,{"DTENTREG","C",150,0} )//41
AADD(aCab,{"NUMNF","C",150,0} )//42
AADD(aCab,{"SERIENF","C",150,0} )//43
AADD(aCab,{"VOLNF","C",150,0} )//44
AADD(aCab,{"ESPEC","C",150,0} )//45
AADD(aCab,{"PLIQUI","C",150,0} )//46
AADD(aCab,{"PBRUTO","C",150,0} )//47
AADD(aCab,{"NATOPER","C",150,0} )//47
AADD(aCab,{"VLRTOTNF","C",150,0} )//49
AADD(aCab,{"TRANSP","C",150,0} )//03//50
AADD(aCab,{"TRANSPNF","C",150,0} )//51
AADD(aCab,{"LIBERPED","C",150,0} )//03//52
AADD(aCab,{"VEND","C",150,0} )//09//53
AADD(aCab,{"CLIENT","C",150,0} )//06//54
AADD(aCab,{"LOJA","C",150,0} )//07//55
AADD(aCab,{"AGENDAM","C",150,0} )////56
AADD(aCab,{"QTDITENS","C",150,0} )//57
AADD(aCab,{"QTDPROD","C",150,0} )//58
AADD(aCab,{"DTPREVENT","C",150,0} )//59
AADD(aCab,{"DTDISFT","C",150,0} )//60
AADD(aCab,{"DTAGEND","C",150,0} )//61
AADD(aCab,{"DTLIMFIN","C",150,0} )//62
AADD(aCab,{"OBSFIN","C",150,0} )//03//63
AADD(aCab,{"HISTWF","C",150,0} )//64
AADD(aCab,{"VL_FRETE","C",150,0} )//65
AADD(aCab,{"TP_FRETE","C",150,0} )//66
AADD(aCab,{"TRANSP ENTREGA","C",150,0} )//67
AADD(aCab,{"USUARIO_LEITURA","C",150,0} )//68
AADD(aCab,{"PEDCLI","C",150,0} )//04//69
AADD(aCab,{"FILIAL","C",150,0} )   //02//70
AADD(aCab,{"CANAL","C",150,0} )//04 //71
AADD(aCab,{"INTEGRACAO WMS","C",150,0} )//72
AADD(aCab,{"PEDWMS","C",150,0} )//73
AADD(aCab,{"CODDEP","C",150,0} )//74
AADD(aCab,{"NOMETRANSPNF","C",150,0} )//75
AADD(aCab,{"CGCTRANSP","C",150,0} )//76
AADD(aCab,{"TELEFONE","C",150,0} )//77
AADD(aCab,{"EMAIL","C",300,0} )//78
AADD(aCab,{" ","C",5,0} )//79


while (cAlias)->(!EOF())

aadd(aItem,IIF(empty((cAlias)->NUMPED)," ",(cAlias)->NUMPED))//1
aadd(aItem,IIF(empty((cAlias)->ROMANQ4)," ",(cAlias)->ROMANQ4))//2
aadd(aItem,IIF(empty((cAlias)->TPOPER)," ",(cAlias)->TPOPER))//3
aadd(aItem,IIF(empty((cAlias)->CAMP)," ",(cAlias)->CAMP))  //4
aadd(aItem,IIF(empty((cAlias)->DCAMP)," ",(cAlias)->DCAMP))  //5
aadd(aItem,IIF(empty((cAlias)->EMISPED)," ",StoD((cAlias)->EMISPED)))//6
aadd(aItem,IIF(empty((cAlias)->NOMECLI)," ",(cAlias)->NOMECLI))//7
aadd(aItem,IIF(empty((cAlias)->CIDADE)," ",(cAlias)->CIDADE))//8
aadd(aItem,IIF(empty((cAlias)->UF)," ",(cAlias)->UF))//9
aadd(aItem,IIF(empty((cAlias)->CEP)," ",(cAlias)->CEP))//10
aadd(aItem,IIF(empty((cAlias)->ENDENT)," ",(cAlias)->ENDENT))//11
aadd(aItem,IIF(empty((cAlias)->BAIRROE)," ",(cAlias)->BAIRROE))//12
aadd(aItem,IIF(empty((cAlias)->VLRPED)," ",(cAlias)->VLRPED))//13
aadd(aItem,IIF(empty((cAlias)->DTLIBPED)," ",StoD((cAlias)->DTLIBPED)))//14
aadd(aItem,IIF(empty((cAlias)->HORALIB)," ",(cAlias)->HORALIB))//15
aadd(aItem,IIF(empty((cAlias)->CRED)," ",(cAlias)->CRED))//16
aadd(aItem,IIF(empty((cAlias)->DATEEXC)," ",(cAlias)->DATEEXC))//17
aadd(aItem,IIF(empty((cAlias)->DTLIBCRED)," ",StoD((cAlias)->DTLIBCRED)))//18
aadd(aItem,IIF(empty((cAlias)->HRLIBCRED)," ",(cAlias)->HRLIBCRED))//19
aadd(aItem,IIF(empty((cAlias)->DTDISPSEP)," ", substr((cAlias)->DTDISPSEP,1,10)))//20
aadd(aItem,IIF(empty((cAlias)->HRDISPSEP)," ", substr((cAlias)->HRDISPSEP,1,10)))//20
aadd(aItem,IIF(empty((cAlias)->DTINISEP)," ", substr((cAlias)->DTINISEP,1,10)))//20
aadd(aItem,IIF(empty((cAlias)->HRINISEP)," ", substr((cAlias)->HRINISEP,1,10)))//20
aadd(aItem,IIF(empty((cAlias)->USUSEP)," ",(cAlias)->USUSEP))//22
aadd(aItem,IIF(empty((cAlias)->DTDISPCONF)," ",substr((cAlias)->DTDISPCONF,1,10)))//25
aadd(aItem,IIF(empty((cAlias)->DTDISPCONF)," ",substr((cAlias)->DTDISPCONF,12,8)))//26
aadd(aItem,IIF(empty((cAlias)->DTINICONF)," ",substr((cAlias)->DTINICONF,1,10)))//27
aadd(aItem,IIF(empty((cAlias)->DTINICONF)," ",substr((cAlias)->DTINICONF,12,8)))//28
aadd(aItem,IIF(empty((cAlias)->USUCONF)," ",(cAlias)->USUCONF))//29
aadd(aItem,IIF(empty((cAlias)->DTEMISNF)," ",StoD((cAlias)->DTEMISNF)))//30
aadd(aItem,IIF(empty((cAlias)->HRNF)," ",(cAlias)->HRNF))//31
aadd(aItem,IIF(empty((cAlias)->DTPICK)," ",(cAlias)->DTPICK))//32
aadd(aItem,IIF(empty((cAlias)->HORAPICK)," ",(cAlias)->HORAPICK))//33
aadd(aItem,IIF(empty((cAlias)->DTETIVOL)," ",StoD((cAlias)->DTETIVOL)))//34
aadd(aItem,IIF(empty((cAlias)->HRETIVOL)," ",(cAlias)->HRETIVOL))//35
aadd(aItem,IIF(empty((cAlias)->DTETINF)," ",StoD((cAlias)->DTETINF)))//36
aadd(aItem,IIF(empty((cAlias)->HORAPICK)," ",(cAlias)->HORAPICK))//37
aadd(aItem,IIF(empty((cAlias)->DTFIMCONF)," ",substr((cAlias)->DTFIMCONF,1,10)))//38
aadd(aItem,IIF(empty((cAlias)->DTFIMCONF)," ",substr((cAlias)->DTFIMCONF,12,8)))//39
aadd(aItem,IIF(empty((cAlias)->DTSAIDA)," ",StoD((cAlias)->DTSAIDA)))//40
aadd(aItem,IIF(empty((cAlias)->DTENTREG)," ",StoD((cAlias)->DTENTREG)))//41
aadd(aItem,IIF(empty((cAlias)->NOTA)," ",(cAlias)->NOTA))//42
aadd(aItem,IIF(empty((cAlias)->SERIENF)," ",(cAlias)->SERIENF))//43
aadd(aItem,IIF(empty((cAlias)->VOLNF)," ",(cAlias)->VOLNF))//44
aadd(aItem,IIF(empty((cAlias)->ESPEC)," ",(cAlias)->ESPEC))//45
aadd(aItem,IIF(empty((cAlias)->PLIQUI)," ",(cAlias)->PLIQUI))//46
aadd(aItem,IIF(empty((cAlias)->PBRUTO)," ",(cAlias)->PBRUTO))//47
aadd(aItem,IIF(empty((cAlias)->TPOPER)," ",(cAlias)->TPOPER))//47
aadd(aItem,IIF(empty((cAlias)->VLRTOTNF)," ",(cAlias)->VLRTOTNF))//49
aadd(aItem,IIF(empty((cAlias)->TRANSP)," ",(cAlias)->TRANSP))//50
aadd(aItem,IIF(empty((cAlias)->TRANSPNF)," ",(cAlias)->TRANSPNF))//51
aadd(aItem,IIF(empty((cAlias)->LIBERPED)," ",(cAlias)->LIBERPED))//52
aadd(aItem,IIF(empty((cAlias)->VEND)," ",(cAlias)->VEND))//53
aadd(aItem,IIF(empty((cAlias)->CLIENT)," ",(cAlias)->CLIENT))//54
aadd(aItem,IIF(empty((cAlias)->LOJA)," ",(cAlias)->LOJA))//55
aadd(aItem,IIF(empty((cAlias)->AGENDAM)," ",(cAlias)->AGENDAM))//56
aadd(aItem,IIF(empty((cAlias)->QTDITENS)," ",(cAlias)->QTDITENS))//57
aadd(aItem,IIF(empty((cAlias)->QTDPROD)," ",(cAlias)->QTDPROD))//58
aadd(aItem,IIF(empty((cAlias)->DTPREVENT)," ",StoD((cAlias)->DTPREVENT)))//59
aadd(aItem,IIF(empty((cAlias)->DTDISFT)," ",StoD((cAlias)->DTDISFT)))//60
aadd(aItem,IIF(empty((cAlias)->DTAGEND)," ",StoD((cAlias)->DTAGEND)))//61
aadd(aItem,IIF(empty((cAlias)->DTLIMFIN)," ",StoD((cAlias)->DTLIMFIN)))//62
aadd(aItem,IIF(empty((cAlias)->OBSFIN)," ",(cAlias)->OBSFIN))//63
aadd(aItem,IIF(empty((cAlias)->HISTWF)," ",(cAlias)->HISTWF))//64
aadd(aItem,IIF(empty((cAlias)->VL_FRETE)," ",(cAlias)->VL_FRETE))//65
aadd(aItem,IIF(empty((cAlias)->TP_FRETE)," ",(cAlias)->TP_FRETE))//66                   
aadd(aItem,IIF(empty((cAlias)->TRANSPENTREGA)  ," ",(cAlias)->TRANSPENTREGA))//67
aadd(aItem,IIF(empty((cAlias)->USUARIO_LEITURA)," ",(cAlias)->USUARIO_LEITURA))//68
aadd(aItem,IIF(empty((cAlias)->PEDCLI)," ",(cAlias)->PEDCLI))//69
aadd(aItem,IIF(empty((cAlias)->FILIAL)," ",(cAlias)->FILIAL))//70
aadd(aItem,IIF(empty((cAlias)->CANAL)," ",(cAlias)->CANAL))  //71
aadd(aItem,IIF(empty((cAlias)->STATUSWMS)," ",(cAlias)->STATUSWMS))//72
aadd(aItem,IIF(empty((cAlias)->PEDWMS)," ",(cAlias)->PEDWMS))//73
aadd(aItem,IIF(empty((cAlias)->CODDEP)," ",(cAlias)->CODDEP))//74
aadd(aItem,IIF(empty((cAlias)->NOMETRANSPNF)," ",(cAlias)->NOMETRANSPNF))//75
aadd(aItem,IIF(empty((cAlias)->CGCTRANSP)," ",(cAlias)->CGCTRANSP))//76
aadd(aItem,IIF(empty((cAlias)->TELEFONE)," ",(cAlias)->TELEFONE))//77       
aadd(aItem,IIF(empty((cAlias)->EMAIL)," ",(cAlias)->EMAIL))//78
aadd(aItem," ")//79
  
aadd(aLinhas,aItem)
aItem:={}
dbSkip()	
Enddo

MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCab,aLinhas}})})

RestArea(aArea)
return

static function ajustaSX1()
Local aArea := GetArea()
Local aHelpP	:= {}

Aadd( aHelpP, "Dt Emissao de ? " )
PutSx1("TRK001","01","Dt Emissao de?     "  ,"Dt Emissao de ?     ","Dt Emissao de?     ","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

Aadd( aHelpP, "Dt Emissao ate ? " )
PutSx1("TRK001","02","Dt Emissao ate?     "  ,"Dt Emissao ate ?     ","Dt Emissao ate?     ","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

Aadd( aHelpP, "Dt Liberacao de ? " )
PutSx1("TRK001","03","Dt Liberacao de?     "  ,"Dt Liberacap de ?     ","Dt Liberacao de?     ","mv_ch3","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

Aadd( aHelpP, "Dt Liberacao ate ? " )
PutSx1("TRK001","04","Dt Liberacao ate?     "  ,"Dt Liberacao ate ?     ","Dt Liberacao ate?     ","mv_ch4","D",08,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

RestArea(aArea)
return
