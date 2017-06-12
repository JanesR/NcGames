#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณM460MARK  บAutor  ณMicrosiga           บ Data ณ  11/14/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function M460MARK

Local aArea		:= GetArea()
Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local cTpEst	:= ""
Local cProdWms	:= ""
Local cCodChvPd	:= ""
Local nCont		:= 0
Local nTamprod	:= TamSx3("C9_PRODUTO")[1]
Local nTamLoc	:= TamSx3("C9_LOCAL")[1]
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,'03')
Local cArmz		:= SuperGetMV("MV_ARMWMAS")
Local lRet		:= .T.
Local cMark     := PARAMIXB[1]          // caracteres referentes aos itens selecionados para NF de saida
Local lInverte  := PARAMIXB[2]          // caracteres referentes aos itens selecionados para NF de saida
Local aDadosC9	:= {}
Local aDadosWMS	:= {}
//Verifica se a filial faz integra็ใo com o WMS
If !xFilial("SF2") $ FormatIN(cFiliais,"|")
	Return .T.
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQUERY COM ITENS SELECIONADOS PARA NF CONTROLADOS WMS     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQry := " SELECT C9_PEDIDO, C9_PRODUTO, C9_LOCAL, sum(C9_QTDLIB) QTDLIB
cQry += " FROM "+RetSqlName("SC9")+" SC9
cQry += " WHERE D_E_L_E_T_ = ' ' AND C9_FILIAL = '"+xFilial("SC9")+"' AND C9_NFISCAL = ' ' "
cQry += " AND C9_BLEST = ' ' AND C9_BLCRED = ' ' And C9_BLWMS=' '"
cQry += " AND C9_LOCAL IN "+FORMATIN(cArmz,"/")

//*****************************************************************
Pergunte("MT461A",.F.)
If lInverte
	cQry += " AND C9_OK <> '"+cMark+"' 
Else
	cQry += " AND C9_OK = '"+cMark+"' 
EndIf
cQry += " AND C9_PEDIDO BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'"
//cQry += " AND C9_OK = '"+cMark+"' 
//*****************************************************************
//Tratamento para considerar apenas os itens com controle de estoque - 02/12/2013
cQry += " AND SC9.C9_FILIAL||SC9.C9_PEDIDO||SC9.C9_ITEM NOT IN(SELECT C6_FILIAL||C6_NUM||C6_ITEM "
cQry += " 	FROM "+RetSqlName("SC6")+" C6, "+RetSqlName("SF4")+" F4 "
cQry += " 	WHERE C6.D_E_L_E_T_ = ' ' "
cQry += " 	AND F4.D_E_L_E_T_ = ' ' "
cQry += " 	AND F4.F4_FILIAL = '"+xFilial("SF4")+"' "
cQry += " 	AND C6.C6_FILIAL = '"+xFilial("SC6")+"' "
cQry += " 	AND C6.C6_TES = F4.F4_CODIGO "
cQry += " 	AND F4.F4_ESTOQUE = 'N' "
cQry += " 	AND C6_NUM BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"') "
//*****************************************************************

Pergunte("MT460A",.F.)
cQry += " GROUP BY C9_PEDIDO, C9_PRODUTO, C9_LOCAL
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAlias,.T.,.T.)
(cAlias)->(dbGoTop())
While (cAlias)->(!Eof())
	cCodChvPd	:= xFilial("SC9")+(cAlias)->C9_PEDIDO
	aadd(aDadosC9,{(cAlias)->C9_PRODUTO,(cAlias)->C9_LOCAL,(cAlias)->QTDLIB,""})
	(cAlias)->(DbSkip())
End
(cAlias)->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQUERY COM ITENS SELECIONADOS PARA NF                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQry := " SELECT CS_COD_DEPOSITO, CS_COD_DEPOSITANTE, CS_COD_PRODUTO CODPRODWMS, CS_COD_TIPO_ESTOQUE TPESTWMS, SUM(CS_QTDE_SEPARADA) QTDE
cQry += " FROM WMS.TB_WMSINTERF_CONF_SEPARACAO
cQry += " WHERE CS_COD_CHAVE = '"+alltrim(cCodChvPd)+"' AND CS_COD_DEPOSITO = "+alltrim(str(val(cEmpAnt)))
cQry += " GROUP BY CS_COD_DEPOSITO, CS_COD_DEPOSITANTE, CS_COD_PRODUTO, CS_COD_TIPO_ESTOQUE
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAlias,.T.,.T.)
(cAlias)->(dbGoTop())
While (cAlias)->(!Eof())
	cProdWms:= Padr((cAlias)->CODPRODWMS,nTamProd)
	cTpEst	:= strzero((cAlias)->TPESTWMS,nTamLoc)
	If (nPos := aScan(aDadosC9,{|x| x[1]+x[2] == cProdWms+cTpEst})) > 0
		aDadosC9[nPos,3] -= (cAlias)->QTDE
	Else
		aadd(aDadosC9,{cProdWms,cTpEst,-(cAlias)->QTDE,""})
	EndIf
	(cAlias)->(DbSkip())
End
(cAlias)->(DbCloseArea())

nCont	:= 0
For nInd:=1 To Len(aDadosC9)
	If (nAscan:=Ascan(aDadosC9,{|a| a[3]==0}))>0
		Adel(aDadosC9,nAscan)
		aSize(aDadosC9,Len(aDadosC9)-1)
		
	EndIf
Next nInd

If len(aDadosC9) > 0
	For nx:=1 to len(aDadosC9)	
		If aDadosC9[nx,3] > 0
			aDadosC9[nx,4]	:= "Quantidade a maior na NF"
		Else
			aDadosC9[nx,4]	:= "Quantidade a maior no WMS"		
		EndIf
	Next nx

	lRet	:= .F.
	NCGM460Div(aDadosC9)
Else
	lRet	:= .T.
EndIf

Return lRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGM460DivบAutor  ณMicrosiga           บ Data ณ  11/14/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Montagem da tela de diverg๊ncias                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function NCGM460Div(aDadosC9)

Default aDadosC9	:= {}

If len(aDadosC9) > 0
	
	@ 001,001 To 400,600 Dialog oDlgLib Title "Diverg๊ncia entre  NF e WMS"
	@ 005,005 LISTBOX oItems Fields Title PADR("Produto",20),;
	PADR('Local',5),;
	PADR('Qtd',10),;
	PADR('Mensagem',20) SIZE 290,155 PIXEL
	oItems:SetArray(aDadosC9)
	
	oItems:bLine := { || {aDadosC9[oItems:nAt,01] ,;
	aDadosC9[oItems:nAt,02] ,;
	TRANSFORM(aDadosC9[oItems:nAt,03],"@E 9,999,999.99"),;
	aDadosC9[oItems:nAt,04] }}
	@ 167,005 SAY "Nใo serแ faturado o pedido por motivo de diverg๊ncia de quantidades separadas e Faturadas!!!"
	@ 180,200 BMPBUTTON TYPE 01 ACTION Close( oDlgLib )
	Activate Dialog oDlgLib Centered
	
	
EndIf

Return
