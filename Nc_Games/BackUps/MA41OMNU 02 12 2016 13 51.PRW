#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  MA410MNU   ºAutor  ³FELIPE V. NAMBARA   º Data ³  09/08/10    º±±

±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada executado antes da criação da tela de     º±±
±±º          ³ liberação do pedido de venda.                              º±±
±±º          ³ Caso o pedido de venda esteja em análise do setor financei-º±±
±±º          ³ ro ou foi bloqueado pelo mesmo, somente os usuários cadas- º±±
±±º          ³ trados (IDS) no parâmetro CL_0000014 poderão liberar o mes-º±±
±±º          ³ mo.                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FATURAMENTO                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MA410MNU()
Local lPvSimul	:=IsInCallStack("U_PR107PVSIMUL")
Local lPvSite	:=IsInCallStack("U_ECOM08PV")

If !lPvSimul
	//Considera usuários que poderão ter acesso à rotina de cópia de residuos 
	aadd(aRotina,{'Copia Residuo','U_CPYRESIDUO' ,0,6,0 ,NIL})
	//If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_NCUSRLB")))
	//	aadd(aRotina,{'Copia Residuo','U_CPYRESIDUO' ,0,6,0 ,NIL})
	//endif
	
	aadd(aRotina,{'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL})
	
	//If UPPER(Alltrim(cUsername)) $ UPPER(GetMv("MV_NCUSRLB"))
	//	aadd(aRotina,{'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL})
	//Endif 
	aadd(aRotina,{'Imprimir Danfe','U_NCGPR125(SC5->C5_NUM)' ,0,2,0 ,NIL})
	
	AADD(aRotina,{ "Envia para aprovação","u_NCGPR108"	,0,9,0 ,.F.})
	AADD(aRotina,{ "Observações sobre a Aprovação PL","u_NCGPROBS()"	,0,10,0 ,.F.})
	AADD(aRotina,{ "Legenda Status Margem Líquida","u_MyLegPed"	,0,11,0 ,.F.})
	//Considera usuários que poderão ter acesso à rotina de cópia de residuos
	//If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_NCUSRLB")))
	//	aadd(aRotina,{'Copia Residuo','U_CPYRESIDUO' ,0,6,0 ,NIL})
	//endif
Else
	aadd(aRotina,{'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL})
EndIf 

If lPvSite
	aadd(aRotina,{'Emissao da Pré-Nota','U_ESP_ECOM' ,0,2,0 ,NIL})
EndIf

	aadd(aRotina,{'Tracking Vendedor','U_NCGPR138()' ,0,2,0 ,NIL})

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MA41OMNU  ºAutor  ³Microsiga           º Data ³  05/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LEGSTATUS()

Local _aLegenda  := {}
Private _cTitulo := "Status do Orcamento - Margem"   

AADD(_aLegenda,{"","01 - Orcamento Sem Restricao de Margem" })
AADD(_aLegenda,{"","02 - Orcamento Sujeito a Aprovacao " })
AADD(_aLegenda,{"","03 - Orcamento Aguardando Aprovacao" })
//AADD(_aLegenda,{"","04 - Orcamento Aguardando 1 Liberacao" })
AADD(_aLegenda,{"","04 - Orcamento Com Margem Aprovado" })
AADD(_aLegenda,{"","05 - Orcamento Com Margem Reprovado" })

BrwLegenda(_cTitulo,"Legenda", _aLegenda)
/*/
Private _cCRLF   := chr(13)+chr(10)
Private _cTitulo := "LEGENDA - Status do Pedido - Mark-Up"
Private _cMensag := "Status 01 - Pedido Sem Restricao de Mark-Up   "+_cCRLF+;
"Status 02 - Pedido Mark-Up sujeito a aprovacao"+_cCRLF+;
"Status 03 - Pedido Aguardando 2 Liberacoes    "+_cCRLF+;
"Status 04 - Pedido Agaurdando 1 Liberacao     "+_cCRLF+;
"Status 05 - Pedido com Mark-Up Aprovado       "+_cCRLF+;
"Status 06 - Pedido com Mark-Up Rejeitado      "
Private _aPergs  := {"Ok"}
Private _nResp   := Aviso(_cTitulo, _cMensag, _aPergs)
Private _lRet    := .T.
/*/
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MA41OMNU  ºAutor  ³Microsiga           º Data ³  05/02/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPROBS(cNumP0B)

Local cQuery 	:= ""
Local cAlias 	:= GetNextAlias()
Local cObs		:= ""
Local aStatus	:= {}
Local lReprovado:= .F.

Default cNumP0B	:= ""

aAdd(aStatus,"Aguardando sua aprovação")		 	// 01
aAdd(aStatus,"Aguar. demais aprov. no mesmo nível")	// 02
aAdd(aStatus,"Aguardando aprovação nível superior") // 03
aAdd(aStatus,"Aprovado") 							// 04
aAdd(aStatus,"Reprovado")							// 05


cQuery := " SELECT P0B_CODOBS,P0B_USER,P0B_DTLIB,P0B_STATUS,P0B_DTREPR"
cQuery += " FROM " + RetSqlName("P0B") + " P0B"
cQuery += " WHERE P0B_FILIAL = '"+ xFilial("P0B") + "'"
cQuery += " AND P0B_TABORI = 'SC5'"
cQuery += " AND P0B_TIPO = 'PAL'"
cQuery += " AND P0B_PEDIDO = '"+ SC5->C5_NUM + "'"

If !Empty(cNumP0B)
	cQuery += " AND P0B_NUM = '"+cNumP0B+"'"
EndIf


cQuery += " ORDER BY P0B_NUM, P0B_NIVEL"

cQuery := ChangeQuery(cQuery)
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias, .F., .F.)

DbSelectArea(cAlias)
(cAlias)->(dbGoTop())

While !(cAlias)->(Eof())
	
	cObs+="Aprovador "+UsrFullName((cAlias)->P0B_USER)+"-"
		
	If !Empty((cAlias)->P0B_DTLIB)
		//cObs+="Aprovado "+DTOC(STOD((cAlias)->P0B_DTLIB))
	ElseIf !Empty((cAlias)->P0B_DTREPR)
		//cObs+="Reprovado "+DTOC(STOD((cAlias)->P0B_DTREPR))
		lReprovado:=.T.
	ElseIf lReprovado
		cObs+="Reprovado Anteriormente"
		//ElseIf !Empty((cAlias)->P0B_STATUS)
		//	cObs+=aStatus[Val((cAlias)->P0B_STATUS)]
	Else
		//cObs+="Aguardando Aprovação"
	EndIf
	
	cObs+=CRLF
	If !Empty((cAlias)->P0B_CODOBS)
		cTexto := AllTrim(Msmm((cAlias)->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, )) //+ (cAlias)->(MEMO)
		If !Empty(cTexto)
			cObs+=cTexto+CRLF
		EndIf
	EndIf
	cObs+="---------------------------------------"+CRLF
	(cAlias)->(DbSkip())
End
If Empty(cObs)
	cObs:= SC5->(C5_YSTATUS+"-"+C5_YAPROV)    //"Pedido sem alçada de aprovação!!"
EndIf

Aviso("MA410MNU - 15",@cObs,{"Ok"},3,"Observação",,,.F.)
If Select(cAlias) > 0
	(cAlias)->(DbCloseArea())
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR108  ºAutor  ³Microsiga           º Data ³  06/02/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCGPR108()  

Local alArea		:= GetArea()
Local aAreaSC6		:= SC6->(GetArea())
Local lAlcada 		:= .F.
Local cStNotLib 	:= Alltrim(U_MyNewSX6("NCG_000108","05*20*35*40","C","Status que nao permite envio","","",.F. ))
Local cCanal		:= SC5->C5_YCANAL
Local cProdExce	 	:= Alltrim(U_MyNewSX6("NCG_000049","PES2014;PES2014;PES2014","C","Codigo do Produtos de Exceção","","",.F. ))
Local cProdExc1		:= Alltrim(U_MyNewSX6("NCG_000050","","C","Produto Exceção Adicional ao NCG_000049","","",.F. )   )
Local cCanalExce	:= Alltrim(U_MyNewSX6("NCG_000040","999998","C","Codigo do Canal de Exceção","","",.F. ))
Local cProd1Exc		:= Alltrim(U_MyNewSX6("NCG_000051","","C","Produto Exceção","Produto Exceção","",.F. ))
Local cCanal1Exc	:= Alltrim(U_MyNewSX6("NCG_000048","999997","C","Codigo do Canal de Exceção","","",.F. ))
Private aHeader		:= {}

If  SC5->C5_XSTAPED $ cStNotLib
	MsgStop("Pedido "+SC5->C5_NUM+" esta com status "+SC5->C5_XSTAPED+"-"+Posicione("SX5",1,xFilial("SX5")+"Z6"+SC5->C5_XSTAPED,"X5_DESCRI")+".Envio para aprovação não permitida")
	Return
EndIf

If SC5->C5_YTOTBRU == 0
	MsgStop("Pedido "+SC5->C5_NUM+" esta com margem igual a 0, Verificar se os produtos do pedido tem estoque.Envio para aprovação não permitida")
	Return
EndIf

RegToMemory( "SC5", .F., .F. )

SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM },  /*uSeekFor*/, /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))


If AllTrim(SC5->C5_YBLQPAL) == 'T'
	If MsgYesNo("Confirma envio de solicitacão de aprovação?","Envio solicitação")
		SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
		SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM ))
		Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==xFilial("SC6")+SC5->C5_NUM
			cProdExce := cProdExce + ";" + cProdExc1
			If AllTrim(SC6->C6_PRODUTO)$cProdExce
				cCanal:=cCanalExce
				Exit
			ElseIf AllTrim(SC6->C6_PRODUTO)$cProd1Exc
				cCanal:=cCanal1Exc
				Exit
			EndIf
			SC6->(DbSkip())
		EndDo
		
		lAlcada := U_GETALCAVPC(SC5->C5_YPERLIQ,"2","PAL",SC5->C5_NUM,1,"SC5",,,cCanal)
		
		If lAlcada
			If SC5->(RecLock("SC5",.F.))
				SC5->C5_YBLQPAL := "B"
				SC5->C5_YSTATUS := "03"
				SC5->C5_YAPROV  :="Aguardando aprovação da Margem "
				SC5->(MsUnLock())
				MsgAlert("Gerado solicitação de aprovação para o pedido "+ SC5->C5_NUM + ". ","Aprovação")
			Else
				MsgAlert("Gerado solicitação de aprovação do pedido "+ SC5->C5_NUM + ". ","Aprovação")
			EndIf
		Else
			MsgAlert("Não foi gerado aprovação deste pedido, verificar as configurações de aprovadores de P&L.","Aprovação")
		EndIf
	EndIf
Else
	If AllTrim(SC5->C5_YBLQPAL) == 'B'
		MsgAlert("O pedido " + SC5->C5_NUM + " já esta em processo de aprovação.", "Atencão")
	ElseIf AllTrim(SC5->C5_YBLQPAL) == 'R'
		MsgAlert("O pedido " + SC5->C5_NUM + " já passou por processo de aprovação e foi reprovado.", "Atencão")
	Else
		MsgAlert("Somente pedido com margem baixa pode ser enviada para aprovação", "Atencão")
	EndIf
EndIf

RestArea(alArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MyLegPed  ºAutor  ³Microsiga           º Data ³  06/02/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MyLegPed()

Local oDlg
Local oTPanel1
Local cCadastro := "Status da Margem Líquida - LEGENDA"
Local nGetLin	:= 7
Local nPulaLin	:= 12

Local FontA0 := TFont():New( "Arial",,-13,,.T.,,,,,.F. )

//TFont(): New ( [ cName], [ uPar2], [ nHeight], [ uPar4], [ lBold], [ uPar6], [ uPar7], [ uPar8], [ uPar9], [ lUnderline], [ lItalic] ) --> oObjeto

DEFINE MSDIALOG oDlg TITLE cCadastro From 0,0 to 200,400  /*OF /*oMainWnd*/ PIXEL

oTPanel1 := TPanel():New(0,25,"",oDlg,NIL,.T.,.F.,NIL,NIL,200,100/*16*/,.T.,.F.)
//oTPanel1:Align := CONTROL_ALIGN_TOP
@ nGetLin	, 10 SAY "Legenda" Font FontA0 SIZE 70,7 PIXEL OF oTPanel1
nGetLin +=  7
@ nGetLin	, 0 SAY "______________________________________________________________________________" SIZE 180,7 PIXEL OF oTPanel1
@ nGetLin + 2	, 0 SAY "______________________________________________________________________________" SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin	, 15 SAY " 01 - Pedido sem restrição de Margem Líquida." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 02 - Pedido c/ margem sujeita a aprovação." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 03 - Pedido aguardando Aprovação de Margem." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 06 - Pedido c/ Margem Aprovada." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 07 - Pedido c/ Margem Reprovado." SIZE 180,7 PIXEL OF oTPanel1

nGetLin += nPulaLin
@ nGetLin, 15 SAY " 99 - Pedido Rejeitado pelo Cliente." SIZE 180,7 PIXEL OF oTPanel1


ACTIVATE MSDIALOG oDlg CENTER //ON INIT // EnchoiceBar(oTPanel1,{|| oDlg:End()})

Return
