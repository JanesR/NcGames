#Include "Protheus.ch"

STATIC cDirect 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNFATR001  บAutor  ณSServices           บ Data ณ  22/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de Devolucoes de vendas por vendedor              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games													  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NFATR001()
Local 	cTitulo	 	:= "Devolucao de vendas"
Private cPerg      	:= "NFATpa"
Private cDirGrv		:= ""
Private cMsgLog		:= ""

AjustaSX1(cPerg)

If(Pergunte(cPerg,.T.))
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณValidacoes perguntasณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If Empty(mv_par08)
		MsgStop("Informe o diretorio onde sera gravado o relatorio")
		Return()
	EndIf

	cDirGrv	:= Alltrim(mv_par08)
	If (SubStr(cDirGrv,Len(cDirGrv),1)<>"\")
		cDirGrv+=	"\"
	EndIf
	
	If Empty(mv_par01) .or. Empty(mv_par02)
		MsgStop("Informar data inicial e final")
		Return()
	EndIf
	
	If mv_par01 > mv_par02
		MsgStop("Problema nas datas informadas")
		Return()
	EndIf
	
	Processa( { || NFATR01A()}, "Processando Analitico...")
	Processa( { || NFATR01B()}, "Processando Sintetico...")
	
	MsgAlert(cMsgLog)
	
EndIf
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNFATR01A  บAutor  ณSServices           บ Data ณ  22/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento do relatorio analitico                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NFATR01A()
Local cAlQry	:= GetNextAlias()
Local cNmCli	:= ""
Local cNmVen	:= ""
Local cMotivo	:= ""
Local cDtEnt	:= ""
Local cDtOri 	:= ""                   
Local cRefat	:= ""                   
Local cFiltro	:= ""
Local chra		:= time()
Local cArq		:= "Dev_Vendas_Analit_"+Alltrim(dtos(ddatabase))+"_"+Substr(chra,1,2)+Substr(chra,4,2)+Substr(chra,7,2)
Local cTitulo  	:= "Devolucao Vendas - Analitico"
Local aItens	:= {}
Local aCabec	:= {}
Local nTotGeral := 0
Local nValor	:= 0
Local lRet	:= .F.

AADD(aCabec,"Nota")
AADD(aCabec,"Serie")
AADD(aCabec,"Dt Digitacao")
AADD(aCabec,"Cliente")
AADD(aCabec,"Loja")
AADD(aCabec,"Nome Cli")
AADD(aCabec,"NF Orig")
AADD(aCabec,"Serie Orig")
AADD(aCabec,"Dt Emissao Orig ")
AADD(aCabec,"Vendedor")
AADD(aCabec,"Nome Vend")
AADD(aCabec,"Valor")
AADD(aCabec,"Justificativa")
AADD(aCabec,"Motivo")
AADD(aCabec,"Refaturado")

cFiltro := "%"
If(MV_PAR06 = 1)
	cFiltro += " (SF4.F4_DUPLIC = 'S') AND  "
ElseIf (MV_PAR06 = 2)                 
	cFiltro += " (SF4.F4_DUPLIC = 'N') AND  "
Else 	
	cFiltro += " (SF4.F4_DUPLIC = 'S' OR SF4.F4_DUPLIC = 'N') AND "
EndIf

If(MV_PAR07 = 1)
	cFiltro += " (SF4.F4_ESTOQUE = 'S') AND  "
ElseIf (MV_PAR07 = 2)                 
	cFiltro += " (SF4.F4_ESTOQUE = 'N') AND  "
Else 	
	cFiltro += " (SF4.F4_ESTOQUE = 'S' OR SF4.F4_ESTOQUE = 'N') AND "
EndIf
cFiltro += "%"

BeginSql Alias cAlQry
	SELECT D1_DOC AS DOC, D1_SERIE AS SERIE, D1_DTDIGIT AS ENTRADA, D1_FORNECE AS CLIENTE, D1_LOJA AS LOJA,
	F2_DOC AS DOCORIG, F2_SERIE AS SERIEORIG, F2_EMISSAO AS EMISSAO, F2_VEND1 AS VENDEDOR, F1_JUSTIF AS JUSTIF,
	F1_MOTIVO AS MOTIVO, F1_REFAT AS REFATURADO, SUM(D1_TOTAL) AS VLMERC, SUM(D1_ICMSRET) AS RETIDO,
	SUM(D1_VALIPI) AS IPI, SUM(D1_VALFRE) AS FRETE, SUM(D1_SEGURO) AS SEGURO, SUM(D1_DESPESA) AS DESPESA
	FROM %Table:SD1% SD1
	JOIN %Table:SF4% SF4 ON (SF4.F4_FILIAL = %xFilial:SF4% AND SF4.F4_CODIGO = SD1.D1_TES AND %Exp:cFiltro% SF4.%notdel%)
	JOIN %Table:SF1% SF1 ON (SF1.F1_FILIAL = %xFilial:SF1% AND SF1.F1_DOC = SD1.D1_DOC AND SF1.F1_SERIE = SD1.D1_SERIE AND
	SF1.F1_FORNECE = SD1.D1_FORNECE AND SF1.F1_LOJA = SD1.D1_LOJA AND SF1.F1_TIPO = 'D' AND
	SF1.F1_DTDIGIT BETWEEN %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)% AND SF1.%notdel%)
	JOIN %Table:SF2% SF2 ON (SF2.F2_FILIAL = %xFilial:SF2% AND SF2.F2_DOC = SD1.D1_NFORI AND SF2.F2_SERIE = SD1.D1_SERIORI AND
	SF2.F2_CLIENTE = SD1.D1_FORNECE AND SF2.F2_LOJA = SD1.D1_LOJA AND SF2.%notdel%)
	WHERE
	SD1.D1_FILIAL  = %xFilial:SD1%
	AND SD1.%notdel%
	GROUP BY D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_DTDIGIT, F2_DOC, F2_SERIE, F2_EMISSAO, F2_VEND1, F1_JUSTIF, F1_MOTIVO, F1_REFAT
	ORDER BY D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_DTDIGIT
EndSql

nTotGeral 	:= 0

DbSelectArea(cAlQry)
(cAlQry)->(DbGoTop())
While (cAlQry)->(!Eof())
	cNmCli		:= ""
	cNmVen		:= ""
	cMotivo		:= ""
	cDtEnt		:= ""
	cDtOri  	:= ""
	cRefat		:= ""
	nValor		:= 0
	
	DbSelectArea("SA1")
	SA1->(DbSetOrder(1))
	If SA1->(DbSeek(xFilial("SA1")+(cAlQry)->CLIENTE+(cAlQry)->LOJA))
		cNmCli := SA1->A1_NREDUZ
	EndIf
	
	DbSelectArea("SA3")
	SA3->(DbSetOrder(1))
	If SA3->(DbSeek(xFilial("SA3")+(cAlQry)->VENDEDOR))
		cNmVen := SA3->A3_NREDUZ
	EndIf
	
	DbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	If SX5->(DbSeek(xFilial("SX5")+AvKey("Z5","X5_TABELA")+AvKey((cAlQry)->MOTIVO,"X5_CHAVE")))
		cMotivo := SubStr(SX5->X5_DESCRI,1,30)
	EndIf
	
	cDtEnt	:= Substr((cAlQry)->ENTRADA,7,2)+"/"+Substr((cAlQry)->ENTRADA,5,2)+"/"+Substr((cAlQry)->ENTRADA,1,4)
	cDtOri  := Substr((cAlQry)->EMISSAO,7,2)+"/"+Substr((cAlQry)->EMISSAO,5,2)+"/"+Substr((cAlQry)->EMISSAO,1,4)
	nValor	:= Iif(mv_par05=1,((cAlQry)->(VLMERC+RETIDO+IPI)),((cAlQry)->(VLMERC+RETIDO+IPI+FRETE+SEGURO+DESPESA)))
	cRefat	:= Iif((cAlQry)->REFATURADO=="1","SIM","NAO")
	
	AADD(aItens, {(cAlQry)->DOC, (cAlQry)->SERIE, cDtEnt, (cAlQry)->CLIENTE, (cAlQry)->LOJA, cNmCli,(cAlQry)->DOCORIG, (cAlQry)->SERIEORIG, cDtOri, (cAlQry)->VENDEDOR, cNmVen, nValor, (cAlQry)->JUSTIF, cMotivo, cRefat})
	
	nTotGeral += nValor
	(cAlQry)->(DbSkip())
EndDo
AADD(aItens, {"", "", "", "", "", "", "", "", "", "", "", nTotGeral, "", "", ""})
nTotGeral := 0

Processa( { || lRet:= GeraExcel(cTitulo,aCabec,aItens,cDirGrv,cArq)}, 'Gerando Excel...' )

If !lRet
	cMsgLog += "Arquivo gerado com sucesso em: "+Alltrim(cDirGrv)+cArq+".xls" +CRLF
Else
	cMsgLog += "Problemas na geracao do arquivo: "+cArq+".xls"+CRLF
EndIf

DbSelectArea(cAlQry)
(cAlQry)->(DbCloseArea())
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNFATR01B  บAutor  ณSServices           บ Data ณ  22/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento do relatorio sintetico                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NFATR01B()
Local cAlQry	:= GetNextAlias()
Local cTitulo  	:= "Devolucao Vendas - Sintetico"
Local cNmVen	:= ""
Local cMotivo	:= ""                                                               
Local chra		:= time()
Local cArq		:= "Dev_Vendas_Sint_"+Alltrim(dtos(ddatabase))+"_"+Substr(chra,1,2)+Substr(chra,4,2)+Substr(chra,7,2)
Local cFiltro 	:= ""
Local aItens	:= {}
Local aCabec	:= {}
Local nTotGeral	:= 0
Local nValor	:= 0
Local lRet 		:= .F.

AADD(aCabec,"Vendedor")
AADD(aCabec,"Nome")
AADD(aCabec,"Motivo")
AADD(aCabec,"Valor")

cFiltro := "%"
If(MV_PAR06 = 1)
	cFiltro += " (SF4.F4_DUPLIC = 'S') AND  "
ElseIf (MV_PAR06 = 2)                 
	cFiltro += " (SF4.F4_DUPLIC = 'N') AND  "
Else 	
	cFiltro += " (SF4.F4_DUPLIC = 'S' OR SF4.F4_DUPLIC = 'N') AND "
EndIf

If(MV_PAR07 = 1)
	cFiltro += " (SF4.F4_ESTOQUE = 'S') AND  "
ElseIf (MV_PAR07 = 2)                 
	cFiltro += " (SF4.F4_ESTOQUE = 'N') AND  "
Else 	
	cFiltro += " (SF4.F4_ESTOQUE = 'S' OR SF4.F4_ESTOQUE = 'N') AND "
EndIf
cFiltro += "%"

BeginSql Alias cAlQry
	SELECT F2_VEND1 AS VENDEDOR, F1_MOTIVO AS MOTIVO, SUM(D1_TOTAL) AS VLMERC, SUM(D1_ICMSRET) AS RETIDO, SUM(D1_VALIPI) AS IPI,
	SUM(D1_VALFRE) AS FRETE, SUM(D1_SEGURO) AS SEGURO, SUM(D1_DESPESA) AS DESPESA
	FROM %Table:SD1% SD1
	JOIN %Table:SF4% SF4 ON (SF4.F4_FILIAL = %xFilial:SF4% AND SF4.F4_CODIGO = SD1.D1_TES AND %Exp:cFiltro% SF4.%notdel%)
	JOIN %Table:SF1% SF1 ON (SF1.F1_FILIAL = %xFilial:SF1% AND SF1.F1_DOC = SD1.D1_DOC AND SF1.F1_SERIE = SD1.D1_SERIE AND
	SF1.F1_FORNECE = SD1.D1_FORNECE AND SF1.F1_LOJA = SD1.D1_LOJA AND SF1.F1_TIPO = 'D' AND
	SF1.F1_DTDIGIT BETWEEN %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)% AND SF1.%notdel%)
	JOIN %Table:SF2% SF2 ON (SF2.F2_FILIAL = %xFilial:SF2% AND SF2.F2_DOC = SD1.D1_NFORI AND SF2.F2_SERIE = SD1.D1_SERIORI AND
	SF2.F2_CLIENTE = SD1.D1_FORNECE AND SF2.F2_LOJA = SD1.D1_LOJA AND SF2.%notdel%)
	WHERE
	SD1.D1_FILIAL  = %xFilial:SD1%
	AND SD1.%notdel%
	GROUP BY F2_VEND1, F1_MOTIVO
	ORDER BY F2_VEND1, F1_MOTIVO
EndSql

nTotGeral 	:= 0

DbSelectArea(cAlQry)
(cAlQry)->(DbGoTop())
While (cAlQry)->(!Eof())
	cNmVen		:= ""
	cMotivo		:= ""
	nValor		:= 0
	
	DbSelectArea("SA3")
	SA3->(DbSetOrder(1))
	If SA3->(DbSeek(xFilial("SA3")+(cAlQry)->VENDEDOR))
		cNmVen := SA3->A3_NREDUZ
	EndIf
	
	DbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	If SX5->(DbSeek(xFilial("SX5")+AvKey("Z5","X5_TABELA")+AvKey((cAlQry)->MOTIVO,"X5_CHAVE")))
		cMotivo := SubStr(SX5->X5_DESCRI,1,30)
	EndIf
	
	nValor	:= Iif(mv_par05=1,((cAlQry)->(VLMERC+RETIDO+IPI)),((cAlQry)->(VLMERC+RETIDO+IPI+FRETE+SEGURO+DESPESA)))
	
	AADD(aItens, {(cAlQry)->VENDEDOR, cNmVen, cMotivo, nValor})
	
	nTotGeral += nValor
	(cAlQry)->(DbSkip())
EndDo
AADD(aItens, {"", "", "", nTotGeral})
nTotGeral := 0

Processa( { || lRet := GeraExcel(cTitulo,aCabec,aItens,cDirGrv,cArq)}, 'Gerando Excel...' )

If !lRet
	cMsgLog += "Arquivo gerado com sucesso em: "+Alltrim(cDirGrv)+cArq+".xls" +CRLF
Else
	cMsgLog += "Problemas na geracao do arquivo: "+cArq+".xls" +CRLF
EndIf

DbSelectArea(cAlQry)
(cAlQry)->(DbCloseArea())
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraExcel บAutor  ณSServices           บ Data ณ  22/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera Planilha Excel                                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraExcel(cTitulo,aHeader,aDados,cDir,cNmArq,lEspaco)
Local cDiretorio	:= ""
Local cFileName		:= ""
Local cTexto 		:= ""
Local aTestDir  	:= {}
Local lErro			:= .F.
Local nHdl
Local lxEsp     := lEspaco

If ValType(cDir) == "C"
	If !Empty(cDir)
		cDiretorio := Alltrim(cDir)
	EndIf
endIf

If !ExistDir(cDiretorio)
	If MakeDir(Trim(cDiretorio))<>0
		lErro:= .T.
		Return(lErro)
	EndIf
EndIf

If ValType(cNmArq) == "C"
	If !Empty(cNmArq)
		cFileName     := cDiretorio + "\" + Alltrim(cNmArq) + ".xls"
	EndIf
EndIf

nHdl := FCreate(cFILENAME,0)

If ( nHdl < 0 )
	lErro:= .T.
	Return(lErro)
EndIf

cTexto := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
cTexto += '<html xmlns="http://www.w3.org/1999/xhtml">'
cTexto += '<head>'
cTexto += '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />'
cTexto += '<title>'+ cTitulo +'</title>'
cTexto += '</head>'
cTexto += '<body>'
cTexto += '<table style="border: 1px solid #000; border-collapse:collapse; width:99%; font:10px Verdana;">'
cTexto += '	<caption style="padding:0 0 5px 0;">'+cTitulo+'</caption>'
cTexto += '	<thead style="background:#006; color:#FFF; font-weight:bold">'
cTexto += '	  <tr>'
For i:=1  To Len(aHeader)
	cTexto += '	    <th scope="col" style="border: 1px solid #000;">'+aHeader[i]+'</th>'
Next i
cTexto += '	  </tr>'
cTexto += '	</thead>'
cTexto += '	<tbody style="background:#FFFFFF;">'

fWrite(nHdl,cTexto,Len(cTexto))
cTexto := ""

ProcRegua(len(aDados))

For i:=1 to len(aDados)
	IncProc()
	cTexto += '	  <tr>'
	For j:= 1 To Len(aHeader)
		If Valtype(aDados[i][j]) == 'D'
			cConteudo := DTOC(aDados[i][j])
		ElseIf Valtype(aDados[i][j]) == 'N'
			cConteudo := Transform(aDados[i][j],'@E 999,999,999.99')
		Else
			If ValType(lxEsp) == "L"
				If lxEsp
					cConteudo := "&nbsp;" + aDados[i][j]
				Else
					cConteudo := aDados[i][j]
				EndIf
			Else
				cConteudo := "&nbsp;" + aDados[i][j]
			EndIf
		EndIF
		cTexto += '	    <td style="border: 1px solid #000;">'+cConteudo+'</td>'
	Next j
	cTexto += '	  </tr>'
	fWrite(nHdl,cTexto,Len(cTexto))
	cTexto := ""
Next i

cTexto += '	</tbody>'
cTexto += '</table>'
cTexto += '</body>'
cTexto += '</html>'

fWrite(nHdl,cTexto,Len(cTexto))
cTexto := ""
fClose(nHdl)
Return(lErro)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetDir 	บAutor  ณMicrosiga           บ Data ณ  05/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna Diretorio                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BscDir()

cDirect	:= cGetFile("\", "Selecione o Diretorio p/ Gerar os Arquivos",,,,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_LOCALFLOPPY)

Return !Empty(cDirect)

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ RetDir       ณ Autor ณSservices		    	ณ Data ณ 22/04/12 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Usado no SXB (XB_ALIAS= "DRC") para buscar um determinado DIR. ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Siga                                                           ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RetDir()

Return(cDirect)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณSServices           บ Data ณ  22/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAjusta perguntas do relatorio                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)
Local aHelpPor := {}
Local aHelpSpa := {}
Local aHelpEng := {}

//Data Inicial
Aadd( aHelpPor, 'Informe a data inicial para ')
Aadd( aHelpPor, 'processamento do relatorio')
PutSx1(cPerg,"01","Data Inicial ","Data Inicial ","Data Inicial ","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Data Final
aHelpPor := {}
Aadd( aHelpPor, 'Informe a data final para ')
Aadd( aHelpPor, 'processamento do relatorio')
PutSx1(cPerg,"02","Data Final ","Data Final ","Data Final ","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Do Vendedor
aHelpPor := {}
Aadd( aHelpPor, 'Informe o vendedor inicial para ')
Aadd( aHelpPor, 'processamento do relatorio')
PutSx1(cPerg,"03","Do Vendedor ","Do Vendedor ","Do Vendedor ","mv_ch3","C",TamSx3("A3_COD")[1],0,0,"G","","SA3","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Ate Vendedor
aHelpPor := {}
Aadd( aHelpPor, 'Informe o vendedor final para ')
Aadd( aHelpPor, 'processamento do relatorio')
PutSx1(cPerg,"04","Ate Vendedor ","Ate Vendedor ","Ate Vendedor ","mv_ch4","C",TamSx3("A3_COD")[1],0,0,"G","","SA3","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Desconsidera Adicionais
aHelpPor := {}
Aadd( aHelpPor, 'Desconsidera os valores de frete, ')
Aadd( aHelpPor, 'seguro e despesa no valor total')
PutSx1(cPerg,"05","Desconsidera Adicionais ","Desconsidera Adicionais ","Desconsidera Adicionais ","mv_ch5","N",1,0,2,"C","","","","","mv_par05","Sim","Sim","Sim","Nao","Nao","Nao","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//TES qto faturamento
aHelpPor := {}
Aadd( aHelpPor, 'Serแ considerado a TES de movimenta็ใo , ')
Aadd( aHelpPor, 'do faturamento no cadastro de itens do  ' )
Aadd( aHelpPor, 'pedido de venda.  ' )
PutSx1(cPerg,"06","TES qto faturamento ","TES qto faturamento ","TES qto faturamento ","mv_ch6","N",1,0,2,"C","","","","","mv_par06","gera financeiro","gera financeiro","gera financeiro","Nao gera","Nao gera","Nao gera","Considera Ambas","Considera Ambas","Considera Ambas","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//TES qto estoque
aHelpPor := {}
Aadd( aHelpPor, 'Serแ considerado a TES de movimenta็ใo , ')
Aadd( aHelpPor, 'do estoque no cadastro de itens do  ' )
Aadd( aHelpPor, 'pedido de venda.  ' )
PutSx1(cPerg,"07","TES qto estoque ","TES qto estoque ","TES qto estoque ","mv_ch7","N",1,0,2,"C","","","","","mv_par07","Movimenta","Movimenta","Movimenta","Nao Movimenta","Nao Movimenta","Nao Movimenta","Considera Ambas","Considera Ambas","Considera Ambas","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)

//Diretorio
aHelpPor := {}
Aadd( aHelpPor, 'Informe o diretorio para ')
Aadd( aHelpPor, 'gravacao do arquivo')
PutSx1(cPerg,"08","Diretorio ","Diretorio ","Diretorio ","mv_ch8","C",30,0,0,"G","","DRC","","","mv_par08","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
Return()