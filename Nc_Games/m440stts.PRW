#include "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P_M440STTS ºAutor  ³Microsiga           º Data ³  14/01/05  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada depois da geracao do C9.,                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION M440STTS()

Local _aArea    := GetArea()
LOCAL CCODBLOQ	:= ""
LOCAL CODARM	:= 0
Local llSc5		:= .F.
Local clArmz	:= SuperGetMV("MV_ARMWMAS")
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,"03")
Local cAliasCES	:= GetNextAlias()
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore:=(cFilAnt$cFilStore)
Local lGravouP0A:=.F.

Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRODUTO"})
Local nPTES     := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_TES"})
Local nPLocal  	:= aScan(aHeader,{|x| AllTrim(x[2]) == "C6_LOCAL"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ITEM"})
Local aItePed	:= {}
Local lEnvia	:= .T.
Local lEcommerce  := Iif(Alltrim(SC5->C5_XECOMER) == "C", .T., .F.)

//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDesc.     ³ Criado pelo Rafael para alimentar o campo modal, trans e horario    º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±

dbSelectArea("SC5")
dbSetOrder(1)
//--dbSeek(xFilial() + SC5->C5_NUM)
dbSeek(xFilial() + "293686")

_cNum    := SC5->C5_NUM
_cHora   := SC5->C5_TIME

//TIAGO BIZAN - TRATAMENTOS PARA O WMS
clFil		:= SC5->C5_FILIAL
clPedido	:= SC5->C5_NUM
clCli		:= SC5->C5_CLIENTE
clLoja		:= SC5->C5_LOJACLI

If (clFil $ FormatIN(cFiliais,"|") ) .Or. lWmsStore
	
	U_PR106ExcP0A(clFil,clPedido)
	
	DBSelectArea("P0A")
	P0A->(DBSetOrder(1))
	SC9->(DBSetOrder(2))
	
	For nI := 1 to len(aCols)
		//SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
		If !Posicione("SB1",1,xFilial("SB1")+aCols[nI,nPProduto],"B1_TIPO") == "PA"
			Loop
		EndIf
		//SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
		If !Posicione("SF4",1,xFilial("SF4")+aCols[nI,nPTES],"F4_ESTOQUE") == "S"
			Loop
		EndIf
		//SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS) DEVEM SER EXPORTADORS PARA O WMS
		If !aCols[nI,nPLocal] $ FORMATIN(clArmz,"/")
			Loop
		EndIf
		//SE O ITEM POSSUIR BLOQUEIO POR CREDITO OU ESTOQUE NAO DEVE SER EXPORTADO PARA O WMS
		If SC9->( DBSeek(clFil+clCli+clLoja+clPedido+aCols[nI,nPItem] )) //C9_FILIAL, C9_CLIENTE, C9_LOJA, C9_PEDIDO, C9_ITEM
		
			If ( EMPTY(SC9->C9_BLEST) .OR. SC9->C9_BLEST  == '10' .OR. SC9->C9_BLEST  == 'ZZ' ) .AND. ( /*SC9->C9_BLCRED == '09' .OR.*/ EMPTY(SC9->C9_BLCRED) )
				//tratamento para não enviar produtos duplicados
				If (nPos := Ascan( aItePed, { |x| clFil+clPedido+aCols[nI,nPProduto] $ x[1] } ) ) == 0
					lEnvia	:= .T.
					aadd(aItePed,{clFil+clPedido+aCols[nI,nPProduto],1})
				Else
					lEnvia	:= .F.
					aItePed[nPos,2] += 1
				EndIf
				If lEnvia  .And. !lEcommerce
					If P0A->(RecLock("P0A",.T.))
						P0A->P0A_FILIAL	:= xFilial("P0A")
						P0A->P0A_CHAVE	:= clFil+clPedido+aCols[nI,nPItem]+aCols[nI,nPProduto]
						P0A->P0A_TABELA	:= "SC6"
						P0A->P0A_EXPORT := '9'
						P0A->P0A_INDICE	:= 'C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO'
						P0A->P0A_TIPO	:= '1'
						U_PR105LogP0A()
						P0A->(MsUnlock())
						llSc5 := .T.
					EndIF
				EndIf
			EndIF
		EndIF
		
		
		
	Next nI
	
	If llSc5  .And. !lEcommerce
		//caso o pedido já tenha sido excluido do WMS uma vez, ao liberar novamente o pedido, será excluida a confirmação do cancelamento anterior no WMS
		cQry2	:= " SELECT STATUS STATWMS FROM WMS.TB_WMSINTERF_CANC_ENT_SAI WHERE CES_COD_CHAVE = '"+ALLTRIM(clFil+clPedido)+"'
		Iif(Select(cAliasCES) > 0,(cAliasCES)->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry2),cAliasCES,.F.,.T.)
		While (cAliasCES)->(!eof())
			If alltrim((cAliasCES)->STATWMS) <> "P"
				cQry2	:= " DELETE FROM WMS.TB_WMSINTERF_CANC_ENT_SAI WHERE CES_COD_CHAVE = '"+ALLTRIM(clFil+clPedido)+"'
				If TcSqlExec(cQry2) >= 0
					TcSqlExec("COMMIT")
					conout("Interface de cancelamento de entrada e saída excluido para o pedido: "+clFil+clPedido)
				Endif
			EndIf
			(cAliasCES)->(dbskip())
		End
		Iif(Select(cAliasCES) > 0,(cAliasCES)->(dbCloseArea()),Nil)
		//***********************************************************************************************************************************************
		
		If P0A->(RecLock("P0A",.T.))
			P0A->P0A_FILIAL	:= xFilial("P0A")
			P0A->P0A_CHAVE	:= clFil+clPedido
			P0A->P0A_TABELA	:= "SC5"
			P0A->P0A_EXPORT := '2'
			P0A->P0A_INDICE	:= 'C5_FILIAL+C5_NUM'
			P0A->P0A_TIPO	:= '1'
			U_PR105LogP0A()
			P0A->(MsUnlock())
			lGravouP0A:=.T.
		EndIF
	EndIF
	
	P0A->(DBCloseArea())
EndIF
If lWmsStore .And. lGravouP0A
	SC5->( U_PR109Grv("SC5",C5_FILIAL+C5_NUM,"3"))
EndIf

IF SC5->C5_MODAL == "1"
	_cModal  := "CIF e Paga Frete"
elseif SC5->C5_MODAL == "2"
	_cModal  := "Valor Manual"
elseif SC5->C5_MODAL == "3"
	_cModal  := "FOB - Frete Pago pelo Cliente"
elseif SC5->C5_MODAL == "4"
	_cModal  := "CIF e Nao Paga Frete"
elseif SC5->C5_MODAL == "5"
	_cModal  := "Isento por Usuario"
elseif SC5->C5_MODAL == "6"
	_cModal  := "Isento Valor PV"
else
	_cModal  := "novo - incluir na lista"
endif


_nTransp := SC5->C5_TRANSP

dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xFilial() + _nTransp)

IF !EMPTY(SA4->A4_NREDUZ)
	_cTransp := SA4->A4_NREDUZ
ELSE
	_cTransp := SA4->A4_NOME
ENDIF

dbSelectArea("SC9")
dbSetOrder(1)
dbSeek(xFilial() + SC5->C5_NUM)

WHILE! eof() .AND. _cNum == SC9->C9_PEDIDO
	
	RECLOCK("SC9",.F.)
	SC9->C9_HORA   := _cHora
	
	IF !EMPTY(SC5->C5_MODAL)
		SC9->C9_MODAL  := _cModal
	ENDIF
	
	SC9->C9_TRANSP := _cTransp
	MSUNLOCK()
	
	dbSkip()
Enddo

//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±º          ³ fim do ajuste para gravar a hora, modal e transportadora.			 º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

WHILE SC6->(!EOF()).AND.SC5->C5_NUM == SC6->C6_NUM
	IF !EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")) //DBSEEK(XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM)
		CCODBLOQ:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")
		EXIT
	Endif
	if !EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLEST"))//SQL->(!Eof()) //sql->c9_blest!=' '
		U_Z7Status(xFilial("SC6"),SC5->C5_NUM,"000003","ATENÇÃO! ALGUNS ITENS FORAM BLOQUEADOS POR ESTOQUE",SC5->C5_cliente, sc5->c5_lojacli)
		EXIT
	Endif
	SC6->(DBSKIP())
ENDDO

dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))
//aNaoWMS	:= {}
aVaiWMS	:= {}
lBlEst	:= .T.
WHILE SC6->(!EOF()).AND.SC5->C5_NUM == SC6->C6_NUM
	CPED:= SC5->C5_NUM
	//Verificação se vai para o WMS
	cAtuEst	:= getadvfval("SF4","F4_ESTOQUE",xFilial("SF4")+SC6->C6_TES,1,"")
	IF !EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")) //DBSEEK(XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM)
		CCODBLOQ:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")
		EXIT
	Endif
	cBlqEst	:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLEST")
	//	If !(SC6->C6_LOCAL $ GETMV("MV_ARMWMAS")) .or. cAtuEst <> "S"
	If cAtuEst <> "S" //modificação feita em 15/10/2013 para criar bloqueio também para os pedidos de marketing
		//		AADD(aNaoWMS,{SC6->C6_ITEM,SC6->C6_LOCAL,cAtuEst})
	Else
		If Empty(cBlqEst)
			AADD(aVaiWMS,{SC6->C6_ITEM,SC6->C6_LOCAL,cAtuEst})
		EndIf
	EndIf
	//
	SC6->(DBSKIP())
ENDDO

U_Z7Status(xFilial("SC6"),SC5->C5_NUM,"000004",IIF(!EMPTY(ALLTRIM(CCODBLOQ)),"PEDIDO BLOQUEADO POR CREDITO","PEDIDO APROVADO POR CREDITO AUTOMATICO"),SC5->C5_cliente, sc5->c5_lojacli)

//IF DBSEEK(XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM)  CES 13/12/2013

SC5->(DbSetOrder(1))
IF SC5->(DBSEEK(XFILIAL("SC5")+SC5->C5_NUM))
	SC5->(RECLOCK("SC5"))
	SC5->C5_CODBL:= ALLTRIM(CCODBLOQ)
	SC5->C5_LIBEROK:= "S"
	SC5->C5_DTLIB := DDATABASE
	SC5->(MSUNLOCK())
ENDIF

//se tiver produto que vai para o WMS, ativa a interface de integração
If len(aVaiWMS) > 0
	IF EMPTY(CCODBLOQ) //EMPTY(POSICIONE("SC5",1,XFILIAL("SC5")+SC5->C5_NUM,"C5_CODBL")) //ACRESCENTADO POR ERICH BUTTNER 25/04/11 - PROJETO DE INTEGRAÇÃO COM O WMAS
		CPED := SC5->C5_NUM //ACRESCENTADO POR ERICH BUTTNER 25/04/11 - PROJETO DE INTEGRAÇÃO COM O WMAS
		//	   	U_INTPEDVEN(CPED) //ACRESCENTADO POR ERICH BUTTNER 25/04/11 - PROJETO DE INTEGRAÇÃO COM O WMAS
		
		TCSQLEXEC("UPDATE SC9010 SET C9_BLWMS = '02' WHERE C9_FILIAL='"+xFilial("SC9")+"' and C9_PEDIDO='"+alltrim(CPED)+"' ")
		
		TCSQLEXEC("COMMIT")
		
	ENDIF //ACRESCENTADO POR ERICH BUTTNER 25/04/11 - PROJETO DE INTEGRAÇÃO COM O WMAS
EndIf

If Empty(CCODBLOQ)
	U_NCGA001(SC5->C5_NUM,cFilAnt,SC5->C5_CLIENTE,SC5->C5_LOJACLI)
EndIf

RestArea(_aArea)

RETURN .T.
