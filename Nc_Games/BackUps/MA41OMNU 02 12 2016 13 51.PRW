#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  MA410MNU   �Autor  �FELIPE V. NAMBARA   � Data �  09/08/10    ���

�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada executado antes da cria��o da tela de     ���
���          � libera��o do pedido de venda.                              ���
���          � Caso o pedido de venda esteja em an�lise do setor financei-���
���          � ro ou foi bloqueado pelo mesmo, somente os usu�rios cadas- ���
���          � trados (IDS) no par�metro CL_0000014 poder�o liberar o mes-���
���          � mo.                                                        ���
�������������������������������������������������������������������������͹��
���Uso       � FATURAMENTO                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MA410MNU()
Local lPvSimul	:=IsInCallStack("U_PR107PVSIMUL")
Local lPvSite	:=IsInCallStack("U_ECOM08PV")

If !lPvSimul
	//Considera usu�rios que poder�o ter acesso � rotina de c�pia de residuos 
	aadd(aRotina,{'Copia Residuo','U_CPYRESIDUO' ,0,6,0 ,NIL})
	//If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_NCUSRLB")))
	//	aadd(aRotina,{'Copia Residuo','U_CPYRESIDUO' ,0,6,0 ,NIL})
	//endif
	
	aadd(aRotina,{'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL})
	
	//If UPPER(Alltrim(cUsername)) $ UPPER(GetMv("MV_NCUSRLB"))
	//	aadd(aRotina,{'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL})
	//Endif 
	aadd(aRotina,{'Imprimir Danfe','U_NCGPR125(SC5->C5_NUM)' ,0,2,0 ,NIL})
	
	AADD(aRotina,{ "Envia para aprova��o","u_NCGPR108"	,0,9,0 ,.F.})
	AADD(aRotina,{ "Observa��es sobre a Aprova��o PL","u_NCGPROBS()"	,0,10,0 ,.F.})
	AADD(aRotina,{ "Legenda Status Margem L�quida","u_MyLegPed"	,0,11,0 ,.F.})
	//Considera usu�rios que poder�o ter acesso � rotina de c�pia de residuos
	//If ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_NCUSRLB")))
	//	aadd(aRotina,{'Copia Residuo','U_CPYRESIDUO' ,0,6,0 ,NIL})
	//endif
Else
	aadd(aRotina,{'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL})
EndIf 

If lPvSite
	aadd(aRotina,{'Emissao da Pr�-Nota','U_ESP_ECOM' ,0,2,0 ,NIL})
EndIf

	aadd(aRotina,{'Tracking Vendedor','U_NCGPR138()' ,0,2,0 ,NIL})

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA41OMNU  �Autor  �Microsiga           � Data �  05/02/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA41OMNU  �Autor  �Microsiga           � Data �  05/02/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPROBS(cNumP0B)

Local cQuery 	:= ""
Local cAlias 	:= GetNextAlias()
Local cObs		:= ""
Local aStatus	:= {}
Local lReprovado:= .F.

Default cNumP0B	:= ""

aAdd(aStatus,"Aguardando sua aprova��o")		 	// 01
aAdd(aStatus,"Aguar. demais aprov. no mesmo n�vel")	// 02
aAdd(aStatus,"Aguardando aprova��o n�vel superior") // 03
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
		//cObs+="Aguardando Aprova��o"
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
	cObs:= SC5->(C5_YSTATUS+"-"+C5_YAPROV)    //"Pedido sem al�ada de aprova��o!!"
EndIf

Aviso("MA410MNU - 15",@cObs,{"Ok"},3,"Observa��o",,,.F.)
If Select(cAlias) > 0
	(cAlias)->(DbCloseArea())
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR108  �Autor  �Microsiga           � Data �  06/02/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NCGPR108()  

Local alArea		:= GetArea()
Local aAreaSC6		:= SC6->(GetArea())
Local lAlcada 		:= .F.
Local cStNotLib 	:= Alltrim(U_MyNewSX6("NCG_000108","05*20*35*40","C","Status que nao permite envio","","",.F. ))
Local cCanal		:= SC5->C5_YCANAL
Local cProdExce	 	:= Alltrim(U_MyNewSX6("NCG_000049","PES2014;PES2014;PES2014","C","Codigo do Produtos de Exce��o","","",.F. ))
Local cProdExc1		:= Alltrim(U_MyNewSX6("NCG_000050","","C","Produto Exce��o Adicional ao NCG_000049","","",.F. )   )
Local cCanalExce	:= Alltrim(U_MyNewSX6("NCG_000040","999998","C","Codigo do Canal de Exce��o","","",.F. ))
Local cProd1Exc		:= Alltrim(U_MyNewSX6("NCG_000051","","C","Produto Exce��o","Produto Exce��o","",.F. ))
Local cCanal1Exc	:= Alltrim(U_MyNewSX6("NCG_000048","999997","C","Codigo do Canal de Exce��o","","",.F. ))
Private aHeader		:= {}

If  SC5->C5_XSTAPED $ cStNotLib
	MsgStop("Pedido "+SC5->C5_NUM+" esta com status "+SC5->C5_XSTAPED+"-"+Posicione("SX5",1,xFilial("SX5")+"Z6"+SC5->C5_XSTAPED,"X5_DESCRI")+".Envio para aprova��o n�o permitida")
	Return
EndIf

If SC5->C5_YTOTBRU == 0
	MsgStop("Pedido "+SC5->C5_NUM+" esta com margem igual a 0, Verificar se os produtos do pedido tem estoque.Envio para aprova��o n�o permitida")
	Return
EndIf

RegToMemory( "SC5", .F., .F. )

SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM },  /*uSeekFor*/, /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))


If AllTrim(SC5->C5_YBLQPAL) == 'T'
	If MsgYesNo("Confirma envio de solicitac�o de aprova��o?","Envio solicita��o")
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
				SC5->C5_YAPROV  :="Aguardando aprova��o da Margem "
				SC5->(MsUnLock())
				MsgAlert("Gerado solicita��o de aprova��o para o pedido "+ SC5->C5_NUM + ". ","Aprova��o")
			Else
				MsgAlert("Gerado solicita��o de aprova��o do pedido "+ SC5->C5_NUM + ". ","Aprova��o")
			EndIf
		Else
			MsgAlert("N�o foi gerado aprova��o deste pedido, verificar as configura��es de aprovadores de P&L.","Aprova��o")
		EndIf
	EndIf
Else
	If AllTrim(SC5->C5_YBLQPAL) == 'B'
		MsgAlert("O pedido " + SC5->C5_NUM + " j� esta em processo de aprova��o.", "Atenc�o")
	ElseIf AllTrim(SC5->C5_YBLQPAL) == 'R'
		MsgAlert("O pedido " + SC5->C5_NUM + " j� passou por processo de aprova��o e foi reprovado.", "Atenc�o")
	Else
		MsgAlert("Somente pedido com margem baixa pode ser enviada para aprova��o", "Atenc�o")
	EndIf
EndIf

RestArea(alArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MyLegPed  �Autor  �Microsiga           � Data �  06/02/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MyLegPed()

Local oDlg
Local oTPanel1
Local cCadastro := "Status da Margem L�quida - LEGENDA"
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
@ nGetLin	, 15 SAY " 01 - Pedido sem restri��o de Margem L�quida." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 02 - Pedido c/ margem sujeita a aprova��o." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 03 - Pedido aguardando Aprova��o de Margem." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 06 - Pedido c/ Margem Aprovada." SIZE 180,7 PIXEL OF oTPanel1
nGetLin += nPulaLin
@ nGetLin, 15 SAY " 07 - Pedido c/ Margem Reprovado." SIZE 180,7 PIXEL OF oTPanel1

nGetLin += nPulaLin
@ nGetLin, 15 SAY " 99 - Pedido Rejeitado pelo Cliente." SIZE 180,7 PIXEL OF oTPanel1


ACTIVATE MSDIALOG oDlg CENTER //ON INIT // EnchoiceBar(oTPanel1,{|| oDlg:End()})

Return
