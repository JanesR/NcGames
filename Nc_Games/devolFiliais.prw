#Include 'Protheus.ch'
#DEFINE CRLF Chr(13) + Chr(10)

User Function devolFilia()

Local aArea := GetArea()
Local cPerg := "DEVPERG"

ajustaSX1()

Pergunte(cPerg,.t.)

geraRel(DtoS(MV_PAR01),DtoS(MV_PAR02))

RestArea(aArea)
Return

Static Function geraRel( dDataIni, dDataFim )

Local aArea := GetArea()
Local cAliasQr1 := GetNextAlias()
Local cQuery :=""
Local aCabExcel :={}
Local aItens	:={}
Local data1 := dDataIni
Local data2 := dDataFim


AADD(aCabExcel,{"EMPRESA"    ,"C", 02, 0})
AADD(aCabExcel,{"FILIAL"    ,"C", 02, 0})
AADD(aCabExcel,{"DESCRICAO LOJA"    ,"C", 15, 0})
AADD(aCabExcel,{"LOJAS"    ,"N", 04, 0})
AADD(aCabExcel,{"COD. DESTINATARIO"    ,"C", 04, 0})
AADD(aCabExcel,{"LOJA CLIENTE"    ,"C", 02, 0})
AADD(aCabExcel,{"NOME CLIENTE"    ,"C", 15, 0})
AADD(aCabExcel,{"CNPJ"    ,"C", 30, 0})
AADD(aCabExcel,{"NFD NUMERO"    ,"C", 09, 0})
AADD(aCabExcel,{"SERIE"    ,"C", 03, 0})
AADD(aCabExcel,{"DATA EMISSAO"    ,"D", 08, 0})
AADD(aCabExcel,{"COD PRODUTO WEB"    ,"C", 60, 0})
AADD(aCabExcel,{"COD BARRAS"    ,"C", 15, 0})
AADD(aCabExcel,{"DESC PRODUTO"    ,"C", 15, 0})
AADD(aCabExcel,{"CFOP"    ,"C", 04, 0})
AADD(aCabExcel,{"TES"    ,"C", 03, 0})
AADD(aCabExcel,{"ESTOQUE"    ,"C", 03, 0})
AADD(aCabExcel,{"FINANCEIRO"    ,"C", 03, 0})
AADD(aCabExcel,{"QDE"    ,"N", 10, 0})
AADD(aCabExcel,{"VLR UNITARIO"    ,"N", 60, 2})
AADD(aCabExcel,{"VLR TOTAL"    ,"N", 060, 2})
AADD(aCabExcel,{" "    ,"C", 60, 0})
AADD(aCabExcel,{" "    ,"C", 60, 0})

cQuery :="	SELECT distinct 'NC STORE' AS EMPRESA, " + CRLF
cQuery +="	       f2_filial AS FILIAL, " + CRLF
cQuery +="	       SUBSTR(zx5.ZX5_DESCRI, 7,50) AS DESCLOJA, " + CRLF
cQuery +="	       zx5.zx5_chave AS LOJAS, " + CRLF
cQuery +="	       sf2.F2_CLIENTE AS CODDESTINO, " + CRLF
cQuery +="	       sf2.f2_loja AS LOJACLO, " + CRLF
cQuery +="	       sa2.A2_NOME as NOMECLI, " + CRLF
cQuery +="	       sa2.A2_CGC AS CNPJ, " + CRLF
cQuery +="	       sf2.f2_doc AS NFD, " + CRLF
cQuery +="	       sf2.f2_serie AS SERIE, " + CRLF
cQuery +="	       substr(f2_emissao,7,2)||'/'||substr(f2_emissao,5,2)||'/'||substr(f2_emissao,1,4) AS DTEMISSAO, " + CRLF
cQuery +="	       sd2.d2_cod AS PRODWEB, " + CRLF
cQuery +="	       sb1.b1_codbar AS CODBARRAS, " + CRLF
cQuery +="	       sb1.b1_desc as DESPROD, " + CRLF 
cQuery +="	       sd2.D2_CF AS CFOP, " + CRLF
cQuery +="	       sd2.d2_TES AS TES, " + CRLF
cQuery +="	       DECODE(sf4.f4_estoque, 'S','SIM',' ','NAO', 'NAO') AS ESTOQUE, " + CRLF
cQuery +="	       DECODE(sf4.f4_DUPLIC, 'S','SIM',' ','NAO', 'NAO') AS FINAN, " + CRLF
cQuery +="	       sd2.D2_QUANT AS QDE, " + CRLF
cQuery +="	       sd2.D2_PRCVEN AS VLRUNI, " + CRLF
cQuery +="	       sd2.D2_TOTAL AS VLRTOT " + CRLF
cQuery +="	FROM sf2030 sf2 " + CRLF
cQuery +="	LEFT JOIN sd2030 sd2 ON (sf2.f2_filial = sd2.d2_filial " + CRLF
cQuery +="	                         AND sf2.f2_doc = sd2.d2_doc " + CRLF
cQuery +="	                         AND sf2.f2_serie = sd2.d2_serie) " + CRLF
cQuery +="	LEFT JOIN sa2030 sa2 ON (sf2.F2_CLIENTE = sa2.a2_COD " + CRLF
cQuery +="	                         AND sf2.F2_LOJA = sa2.a2_loja) " + CRLF
cQuery +="	LEFT JOIN sb1030 sb1 ON (sd2.d2_cod = sb1.b1_cod) " + CRLF
cQuery +="	LEFT JOIN sf4030 sf4 ON (sd2.d2_tes = sf4.f4_codigo) " + CRLF
cQuery +="	LEFT JOIN zx5010 zx5 ON ( '03;'||sf2.f2_filial = SUBSTR(zx5.ZX5_DESCRI, 1,5)) " + CRLF
cQuery +="	WHERE sf2.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND sd2.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND sf4.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND sb1.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND zx5.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND zx5.ZX5_TABELA = '00006' " + CRLF
cQuery +="	  AND SA2.A2_CGC = '01455929000330' " + CRLF
cQuery +="	  AND SF2.F2_EMISSAO between '"+data1+"' and '"+data2+"' " + CRLF
cQuery +="	  AND sd2.D2_CF IN('5202','6202','5411','6411') " + CRLF
cQuery +="	UNION ALL " + CRLF
cQuery +="	SELECT distinct 'PROXIMO GAMES' AS EMPRESA, " + CRLF
cQuery +="	       f2_filial AS FILIAL, " + CRLF
cQuery +="	       SUBSTR(zx5.ZX5_DESCRI, 7,50) AS DESCLOJA, " + CRLF
cQuery +="	       zx5.zx5_chave AS LOJAS, " + CRLF
cQuery +="	       sf2.F2_CLIENTE AS CODDESTINO, " + CRLF
cQuery +="	       sf2.f2_loja AS LOJACLO, " + CRLF
cQuery +="	       sa2.A2_NOME as NOMECLI, " + CRLF
cQuery +="	       sa2.A2_CGC AS CNPJ, " + CRLF
cQuery +="	       sf2.f2_doc AS NFD, " + CRLF
cQuery +="	       sf2.f2_serie AS SERIE, " + CRLF
cQuery +="	       substr(f2_emissao,7,2)||'/'||substr(f2_emissao,5,2)||'/'||substr(f2_emissao,1,4) AS DTEMISSAO, " + CRLF
cQuery +="	       sd2.d2_cod AS PRODWEB, " + CRLF
cQuery +="	       sb1.b1_codbar AS CODBARRAS, " + CRLF
cQuery +="	       sb1.b1_desc as DESPROD,  " + CRLF
cQuery +="	       sd2.D2_CF AS CFOP, " + CRLF
cQuery +="	       sd2.d2_TES AS TES, " + CRLF
cQuery +="	       DECODE(sf4.f4_estoque, 'S','SIM',' ','NAO', 'NAO') AS ESTOQUE, " + CRLF
cQuery +="	       DECODE(sf4.f4_DUPLIC, 'S','SIM',' ','NAO', 'NAO') AS FINAN, " + CRLF
cQuery +="	       sd2.D2_QUANT AS QDE, " + CRLF
cQuery +="	       sd2.D2_PRCVEN AS VLRUNI, " + CRLF
cQuery +="	       sd2.D2_TOTAL AS VLRTOT " + CRLF
cQuery +="	FROM sf2400 sf2 " + CRLF
cQuery +="	LEFT JOIN sd2400 sd2 ON (sf2.f2_filial = sd2.d2_filial " + CRLF
cQuery +="	                         AND sf2.f2_doc = sd2.d2_doc " + CRLF
cQuery +="	                         AND sf2.f2_serie = sd2.d2_serie) " + CRLF
cQuery +="	LEFT JOIN sa2400 sa2 ON (sf2.F2_CLIENTE = sa2.a2_COD " + CRLF
cQuery +="	                         AND sf2.F2_LOJA = sa2.a2_loja) " + CRLF
cQuery +="	LEFT JOIN sb1400 sb1 ON (sd2.d2_cod = sb1.b1_cod) " + CRLF
cQuery +="	LEFT JOIN sf4400 sf4 ON (sd2.d2_tes = sf4.f4_codigo) " + CRLF
cQuery +="	LEFT JOIN zx5010 zx5 ON ('40;'||sf2.f2_filial = SUBSTR(zx5.ZX5_DESCRI, 1,5)) " + CRLF
cQuery +="	WHERE sf2.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND sd2.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND sf4.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND sb1.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND zx5.D_E_L_E_T_ = ' ' " + CRLF
cQuery +="	  AND zx5.ZX5_TABELA = '00006' " + CRLF
cQuery +="	  AND SA2.A2_CGC = '01455929000330' " + CRLF
cQuery +="	  AND SF2.F2_EMISSAO between '"+data1+"' and '"+data2+"' " + CRLF
cQuery +="	  AND sd2.D2_CF IN('5202','6202','5411','6411') " + CRLF	


MsgRun( "Coletando os dados......","Coleta de Dados",{|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQr1,.T.,.T.)} )

Do While(cAliasQr1)->(!Eof())

AADD(aItens,{;    
		(cAliasQr1)->EMPRESA,;
		(cAliasQr1)->FILIAL	,;
		(cAliasQr1)->DESCLOJA	,;
		(cAliasQr1)->LOJAS	,;
		(cAliasQr1)->CODDESTINO	,;
		(cAliasQr1)->LOJACLO	,;
		(cAliasQr1)->NOMECLI	,;
		(cAliasQr1)->CNPJ	,;
		(cAliasQr1)->NFD	,;
		(cAliasQr1)->SERIE	,;
		(cAliasQr1)->DTEMISSAO	,;
		(cAliasQr1)->PRODWEB	,;
		(cAliasQr1)->CODBARRAS	,;
		(cAliasQr1)->DESPROD	,;
		(cAliasQr1)->CFOP	,;
		(cAliasQr1)->TES	,;
		(cAliasQr1)->ESTOQUE	,;
		(cAliasQr1)->FINAN	,;
		(cAliasQr1)->QDE	,;
		(cAliasQr1)->VLRUNI	,;
		(cAliasQr1)->VLRTOT	,;
		"",;
		""})
		
        DbSkip()
EndDo

        DbCloseArea(cAliasQr1)

If !EMPTY(aItens)
	MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCabExcel,aItens}})})
Else
	Alert("Nenhum dado encontrado!")
EndIf


RestArea(aArea)
Return


Static Function ajustaSX1()
Local aArea := GetArea()
Local aHelpP	:= {}

Aadd( aHelpP, "Dt Emissao de ? " )
PutSx1("DEVPERG","01","Dt Emissao de?     "  ,"Dt Emissao de ?     ","Dt Emissao de?     ","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

Aadd( aHelpP, "Dt Emissao ate ? " )
PutSx1("DEVPERG","02","Dt Emissao ate?     "  ,"Dt Emissao ate ?     ","Dt Emissao ate?     ","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}


RestArea(aArea)
Return

