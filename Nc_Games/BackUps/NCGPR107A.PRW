#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"
Static dDtSB9

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  08/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR107JOB(aDados)

Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2] )

PR107NFSQL("E")
PR107BNF("S")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  10/04/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR107NFSQL(cTipoNF)
Local cQuery 	:= ""
Local aAreaAtu 	:= GetArea()
Local cAliasQry := GetNextAlias()

cTipoNF=="E"

cQuery:=" SELECT DISTINCT F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_FORMUL,F1_TIPO, SF1.R_E_C_N_O_ SF1REC  "
cQuery+=" FROM "+RetSqlName("SF1")+" SF1,"+RetSqlName("SD1")+" SD1,"+RetSqlName("SF2")+" SF2 "
cQuery+=" WHERE SD1.D1_DOC = SF1.F1_DOC
cQuery+=" AND SD1.D1_SERIE  = SF1.F1_SERIE
cQuery+=" AND SD1.D1_FORNECE= SF1.F1_FORNECE
cQuery+=" AND SD1.D1_LOJA   = SF1.F1_LOJA
cQuery+=" AND SD1.D_E_L_E_T_= ' '
cQuery+=" AND SD1.D1_FILIAL = '"+xFilial("SD1")+"'"
cQuery+=" AND SD1.D1_NFORI = SF2.F2_DOC
cQuery+=" AND SD1.D1_SERIORI= SF2.F2_SERIE
cQuery+=" AND SD1.D1_LOJA   = SF2.F2_LOJA
cQuery+=" AND SF2.F2_CLIENTE= SD1.D1_FORNECE
cQuery+=" AND SF2.F2_FILIAL= '"+xFilial("SF2")+"'"
cQuery+=" AND SF2.D_E_L_E_T_  = ' '
cQuery+=" AND SD1.D1_DTDIGIT>='20131001'"
cQuery+=" AND SF1.F1_FILIAL= '"+xFilial("SF1")+"'"
cQuery+=" AND SF1.D_E_L_E_T_  = ' '"
cQuery+=" AND SF1.F1_YDTMARG = ' '"
cQuery+=" AND EXISTS (SELECT 'X' FROM  "+RetSqlName("SF4")+" SF4 WHERE SF4.F4_FILIAL = '"+xFilial("SF4")+"'"
cQuery+="             AND D1_TES = SF4.F4_CODIGO
cQuery+="             AND SF4.F4_DUPLIC ='S'
cQuery+="             AND SF4.F4_ESTOQUE ='S'
cQuery+="             AND SF4.D_E_L_E_T_ =' '
cQuery+="             )"

cQuery := ChangeQuery(cQuery)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)

Do While (cAliasQry)->(!Eof())
	SF1->( DbGoTo( (cAliasQry)->SF1REC ) )
	(cAliasQry)->(U_PR170NOTA(F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_FORMUL,F1_TIPO,"E"))
	(cAliasQry)->(DbSkip())
EndDo
(cAliasQry)->(DbCloseArea())


RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  08/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR170NOTA(cNumDoc,cSerie,cCliente,cLojaCli,cFormul,cTipoNF,cTipoNota )

Local aAreaAtu	:=GetArea()
Local aAreaZF2	:=ZF2->(GetArea())
Local aAreaZD2	:=ZD2->(GetArea())
Local aAreaSF2	:=SF2->(GetArea())
Local aAreaSD2	:=SD2->(GetArea())
Local aAreaSF1	:=SF1->(GetArea())
Local aAreaSD1	:=SD1->(GetArea())
Local cFilSD2	:=xFilial("SD2")
Local cFilSD1	:=xFilial("SD1")
Local aColsAux	:={}
Local aHeadAux	:={}
Local cQryFrete	:=GetNextAlias()
Local aCpoSC5   :=SC5->(DbStruct())
Local aCpoZF2	:={}
Local aCpoZD2	:={}
Local nPosProd
Local nPosItemPv
Local nPosRec
Local aPedido	:={}
Local aTotaCols	:={}
Local nPVInd


If !Empty(SF1->F1_YDTMARG)
	Return
EndIf

dDtSB9 := SF1->F1_DTDIGIT

If Type('aCols')=="A"
	aColsAux:=aClone(aCols)
EndIf

If Type('aHeader')=="A"
	aHeadAux:=aClone(aHeader)
EndIf

aCols	:={}
aHeader	:={}


SD1->(DbSetOrder(1))//D1_FILAL+D1_DOC+D1_SERIE+D1_CLIENTE+D1_LOJA+D1_COD
SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM

SD1->(DbSeek(cFilSD1+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)))
Do While SD1->(!Eof()) .And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)==cFilSD1+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
	
	If SD2->(DbSeek(cFilSD2+SD1->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEMORI)))  .And. Ascan(aPedido,{|a| a[1]==SD2->D2_PEDIDO})==0
		AADD(aPedido,{SD2->D2_PEDIDO,SF1->(Recno())  })
	EndIf
	
	SD1->(DbSkip())
EndDo


For nPVInd:=1  To Len(aPedido)
	
	SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
	If !(SC5->(DbSeek(xFilial("SC5")+aPedido[nPVInd,1])))
		Loop
	EndIf
	RegToMemory("SC5",.F.,.F.)
	For nInd:=1 To Len(aCpoSC5)
		
		cCpoZF2:="ZF2_"+SubStr(aCpoSC5[nInd,1],5)
		
		If !Left( aCpoSC5[nInd,1],4)=="C5_Y"  .Or.ZF2->(FieldPos(cCpoZF2))==0
			Loop
		EndIf
		
		AADD(aCpoZF2,{cCpoZF2,aCpoSC5[nInd,1]}  )
	Next
	
	aCols	:= {}
	aHeader	:= {}
	
	SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM },  /*uSeekFor*/, /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
	
	For nInd:=1 To Len(aHeader)
		cCpoSC6:=AllTrim( aHeader[nInd,2] )
		cCpoZD2:="ZD2_"+SubStr(cCpoSC6,5)
		
		If !Left( cCpoSC6,4)=="C6_Y"  .Or. ZD2->(FieldPos(cCpoZD2))==0
			Loop
		EndIf
		AADD(aCpoZD2,{cCpoZD2,cCpoSC6}  )
	Next
	
	nPosProd	:=GdFieldPos("C6_PRODUTO")
	nPosNumPv	:=GdFieldPos("C6_NUM")
	nPosItemPv	:=GdFieldPos("C6_ITEM")
	nPosRec		:=GdFieldPos('C6_REC_WT')
	
	nDelete:=Len(aHeader)+1
	For nInd:=1 To Len(aCols)
		aCols[nInd,nDelete] :=.T.
		aCols[nInd,nPosRec]	:=0
	Next
	
	SF1->(DbGoTo(aPedido[nPVInd,2]))
	SD1->(DbSetOrder(1))//D1_FILAL+D1_DOC+D1_SERIE+D1_CLIENTE+D1_LOJA+D1_COD
	SD1->(DbSeek(cFilSD1+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)))
	
	Do While SD1->(!Eof()) .And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)==cFilSD1+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
		
		If SD2->(DbSeek(cFilSD2+SD1->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEMORI))) .And. ( nAscan:=Ascan( aCols, { |a|   a[nPosItemPv]==SD2->D2_ITEMPV .And. aPedido[nPVInd,1]==SD2->D2_PEDIDO  .And. a[nPosProd]==SD2->D2_COD   }  ))  >0
			//If SD2->(DbSeek(cFilSD2+SD1->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEMORI))) .And. ( nAscan:=Ascan( aCols, { |a|   a[nPosItemPv]==SD2->D2_ITEMPV .And. a[nPosNumPv]==SD2->D2_PEDIDO  .And. a[nPosProd]==SD2->D2_COD   }  ))  >0
			aCols[nAscan,nDelete] 	:=.F.
			GdFieldPut("C6_YQTDLIB",SD1->D1_QUANT ,nAscan)
			GdFieldPut("C6_PRCVEN" ,SD1->D1_VUNIT,nAscan)
			GdFieldPut("C6_TOTAL"  ,SD1->D1_TOTAL ,nAscan)
			GdFieldPut('C6_YVLRIPI',SD1->D1_VALIPI,nAscan)
			GdFieldPut('C6_YVLRICM',SD1->D1_VALICM,nAscan)
			GdFieldPut('C6_YVLRICR',SD1->D1_ICMSRET,nAscan)
			GdFieldPut('C6_YVLRPIS',SD1->D1_VALIMP6,nAscan)
			GdFieldPut('C6_YVLRCOF',SD1->D1_VALIMP5,nAscan)
			aCols[nAscan,nPosRec]:=SD1->(Recno())
			aadd(aTotaCols,aCols[nAscan])
	
		EndIf
		SD1->(DbSkip())
	EndDo
	
Next

aCols:=aTotaCols

If Type('n') == "U"
	_SetOwnerPrvt("n",1)
EndIf  

U_PR107VAL() //Simulador Margem Liquida


Begin Transaction


lAlt := .T.

For nInd:=1 To Len(aCols)
	
	If aCols[nInd,nDelete] .Or. aCols[nInd,nPosRec]==0
		Loop
	EndIf
	
	SD1->(DbGoTo(aCols[nInd,nPosRec]))
	
	ZD2->(RecLock("ZD2",lAlt))
	
	ZD2->ZD2_ALIAS	:= "SD1"
	ZD2->ZD2_FILIAL:= SD1->D1_FILIAL
	ZD2->ZD2_CLIENT	:= SD1->D1_FORNECE
	ZD2->ZD2_LOJA	:= SD1->D1_LOJA
	ZD2->ZD2_DOC	:= SD1->D1_DOC
	ZD2->ZD2_SERIE 	:= SD1->D1_SERIE
	ZD2->ZD2_COD	:= SD1->D1_COD
	ZD2->ZD2_ITEM 	:= SD1->D1_ITEM
	ZD2->ZD2_QUANT	:= SD1->D1_QUANT
	ZD2->ZD2_PRCVEN	:= SD1->D1_VUNIT
	ZD2->ZD2_TOTAL	:= SD1->D1_TOTAL
	ZD2->ZD2_TES	:= SD1->D1_TES
	ZD2->ZD2_CF		:= SD1->D1_CF
	ZD2->ZD2_NFORI	:= SD1->D1_NFORI
	ZD2->ZD2_SERORI := SD1->D1_SERIORI
	ZD2->ZD2_ITORI	:= SD1->D1_ITEMORI
	
	
	For nYnd:=1 To Len(aCpoZD2)
		ZD2->( FieldPut( FieldPos(aCpoZD2[nYnd,1]) ,GdFieldGet( aCpoZD2[nYnd,2], nInd) )  )
	Next
	
	ZD2->(MsUnLock())
Next

ZF2->(RecLock("ZF2",lAlt))

ZF2->ZF2_ALIAS	:= "SF1"
ZF2->ZF2_FILIAL	:= SF1->F1_FILIAL
ZF2->ZF2_DOC	:= SF1->F1_DOC
ZF2->ZF2_SERIE	:= SF1->F1_SERIE
ZF2->ZF2_CLIENT	:= SF1->F1_FORNECE
ZF2->ZF2_LOJA	:= SF1->F1_LOJA
ZF2->ZF2_EMISSA	:= SF1->F1_EMISSAO

For nInd:=1 To Len(aCpoZF2)
	cNomeCpo:= aCpoZF2[nInd,2]
	xValorCpo:= Eval(MemVarBlock(aCpoZF2[nInd,2] )  )
	ZF2->( FieldPut( FieldPos(aCpoZF2[nInd,1]) ,Eval(MemVarBlock(aCpoZF2[nInd,2] )  )   )   )
Next

SF1->(RecLock("SF1",.F.))
SF1->F1_YDTMARG:= MsDate()
SF1->(MsUnLock())

ZF2->(MsUnLock())


End Transaction 

aCols	:=aClone(aColsAux)
aHeader	:=aClone(aHeadAux)

RestArea(aAreaSF2)
RestArea(aAreaSD2)
RestArea(aAreaSF1)
RestArea(aAreaSD1)
RestArea(aAreaZF2)
RestArea(aAreaZD2)



RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107B บAutor  ณMicrosiga           บ Data ณ  02/03/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PR107BNF(cTipoNF)
Local cQuery 	:= ""
Local aAreaAtu := GetArea()


cQuery:=" SELECT R_E_C_N_O_ SF2REC "+CRLF
cQuery+="  FROM "+RetSqlName("SF2")+" SF2 "+CRLF
cQuery+="  WHERE F2_FILIAL='"+xFilial("SF2")+"' "+CRLF
cQuery+="   AND D_E_L_E_T_=' ' "+CRLF
cQuery+="   AND F2_EMISSAO>='20131001' "+CRLF
cQuery+="   AND F2_YDTMARG = ' ' "+CRLF
cQuery+=" ORDER BY F2_EMISSAO "+CRLF   


DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"__SF2DOC", .F., .F.)


Do While __SF2DOC->(!Eof())
	SF2->( DbGoTo( __SF2DOC->SF2REC ) )
	PtInternal(1,"NOTA FISCAL DO DIA "+DTOC(SF2->F2_EMISSAO) )
	SF2->(U_PR170BNOT(F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_FORMUL,F2_TIPO))
	__SF2DOC->(DbSkip())
EndDo
__SF2DOC->(DbCloseArea())


RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107B บAutor  ณMicrosiga           บ Data ณ  02/03/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR170BNOT(cNumDoc,cSerie,cCliente,cLojaCli,cFormul,cTipoNF )
Local aAreaAtu	:= GetArea()
Local aAreaZF2	:= ZF2->(GetArea())
Local aAreaZD2	:= ZD2->(GetArea())
Local aAreaSF2	:= SF2->(GetArea())
Local aAreaSD2	:= SD2->(GetArea())
Local cFilSD2	:= xFilial("SD2")
Local aColsAux	:= {}
Local aHeadAux	:= {}
Local cQryFrete:= GetNextAlias()
Local aCpoSC5  := SC5->(DbStruct())
Local aCpoZF2	:= {}
Local aCpoZD2	:= {}
Local nPosProd
Local nPosItemPv
Local nPosRec

If !Empty(SF2->F2_YDTMARG)
	Return
EndIf

dDtSB9 := SF2->F2_EMISSAO

If Type('aCols')=="A"
	aColsAux:=aClone(aCols)
EndIf

If Type('aHeader')=="A"
	aHeadAux:=aClone(aHeader)
EndIf

aCols		:={}
aHeader	:={}


SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM

lTabAcess:= SD2->(DbSeek(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)  )) .And. SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))


If lTabAcess
	RegToMemory("SC5",.F.,.F.)
	For nInd:=1 To Len(aCpoSC5)
		
		cCpoZF2:="ZF2_"+SubStr(aCpoSC5[nInd,1],5)
		
		If !Left( aCpoSC5[nInd,1],4)=="C5_Y"  .Or.ZF2->(FieldPos(cCpoZF2))==0
			Loop
		EndIf
		
		AADD(aCpoZF2,{cCpoZF2,aCpoSC5[nInd,1]}  )
	Next
	
	nVlrFrete:= 0
	
	If SF2->F2_TPFRETE=="C" .And. .F.
		cAliasAtu:=Alias()
		cQuery:=' SELECT NFD.NUMNF_NFDESPACHADAS, NFD.SERIENF_NFDESPACHADAS, NFD.CHAVE_ACESSO, FN.VALOR_FRETE'
		cQuery+=' FROM FRETES.TB_FRTNFDESPACHADAS NFD,FRETES.TB_FRTFRETENOTA FN'
		cQuery+=' WHERE NFD.NUMNF_NFDESPACHADAS ='+AllTrim(Str(Val(SD2->D2_DOC)))
		cQuery+=' AND NFD.SERIENF_NFDESPACHADAS='+AllTrim(Str(Val(SD2->D2_SERIE)))
		cQuery+=" AND NFD.PEDIDO_NFDESPACHADAS='"+StrZero(Val(SD2->D2_PEDIDO),10)+"'"
		cQuery+=' AND  FN.DOC_NFDESPACHADAS = NFD.DOC_NFDESPACHADAS'
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQryFrete, .F., .F.)
		nVlrFrete:=(cQryFrete)->VALOR_FRETE
		(cQryFrete)->(DbCloseArea())
		DbSelectArea(cAliasAtu)
	EndIf
	
	If nVlrFrete>0
		M->C5_YPGFRET:= nVlrFrete
	EndIf
	
	M->C5_YVLRSEG:= 0
	M->C5_FRETE  := 0
	M->C5_SEGURO := 0
	M->C5_YCOMISS:= SD2->D2_COMIS1
	M->C5_YCONDPG:= SF2->F2_COND
	SE4->(DbSetOrder(1))
	SE4->(DbSeek(xFilial("SE4")+M->C5_YCONDPG))
	M->C5_YDESFIN:=(SE4->E4_YDESCFI)
	
	
	
	SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM },  /*uSeekFor*/, /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
	
	For nInd:=1 To Len(aHeader)
		cCpoSC6:=AllTrim( aHeader[nInd,2] )
		cCpoZD2:="ZD2_"+SubStr(cCpoSC6,5)
		
		If !Left( cCpoSC6,4)=="C6_Y"  .Or. ZD2->(FieldPos(cCpoZD2))==0
			Loop
		EndIf
		AADD(aCpoZD2,{cCpoZD2,cCpoSC6}  )
	Next
	
	nPosProd		:= GdFieldPos("C6_PRODUTO")
	nPosItemPv	:= GdFieldPos("C6_ITEM")
	nPosRec		:= GdFieldPos('C6_REC_WT')
	
	nDelete:=Len(aHeader)+1
	For nInd:=1 To Len(aCols)
		aCols[nInd,nDelete] := .T.
		aCols[nInd,nPosRec] := 0
	Next
	
	Do While SD2->(!Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==(cFilSD2+cNumDoc+cSerie+cCliente+cLojaCli)
		If ( nAscan:=Ascan( aCols, { |a|   a[nPosItemPv]==SD2->D2_ITEMPV .And. a[nPosProd]==SD2->D2_COD   }  ))  >0
			aCols[nAscan,nDelete] := .F.
			GdFieldPut("C6_YQTDLIB",SD2->D2_QUANT , nAscan)
			GdFieldPut("C6_PRCVEN" ,SD2->D2_PRCVEN, nAscan)
			GdFieldPut("C6_TOTAL"  ,SD2->D2_TOTAL , nAscan)
			GdFieldPut('C6_YVLRIPI',SD2->D2_VALIPI, nAscan)
			GdFieldPut('C6_YVLRICM',SD2->D2_VALICM, nAscan)
			GdFieldPut('C6_YVLRICR',SD2->D2_ICMSRET,nAscan)
			GdFieldPut('C6_YVLRPIS',SD2->D2_VALIMP6,nAscan)
			GdFieldPut('C6_YVLRCOF',SD2->D2_VALIMP5,nAscan)
			aCols[nAscan,nPosRec]:= SD2->(Recno())
		EndIf
		SD2->(DbSkip())
	EndDo
	
EndIf

If Type('n') == "U"
	_SetOwnerPrvt("n",1)
EndIf

U_PR107VAL() //Simulador Margem Liquida

Begin Transaction


lAlt := .T.
lAppend := ! ZD2->(  DbSeek(xFilial("SD2")  )    )

For nInd:=1 To Len(aCols)
	
	If aCols[nInd,nDelete] .Or. aCols[nInd,nPosRec]==0
		Loop
	EndIf
	
	SD2->(DbGoTo(aCols[nInd,nPosRec]))
	
	
	ZD2->(RecLock("ZD2",lAlt))
	
	ZD2->ZD2_ALIAS	:= "SD2"
	ZD2->ZD2_FILIAL	:= SD2->D2_FILIAL
	ZD2->ZD2_CLIENT	:= SD2->D2_CLIENTE
	ZD2->ZD2_LOJA 		:= SD2->D2_LOJA
	ZD2->ZD2_DOC		:= SD2->D2_DOC
	ZD2->ZD2_SERIE 	:= SD2->D2_SERIE
	ZD2->ZD2_COD		:= SD2->D2_COD
	ZD2->ZD2_ITEM 		:= SD2->D2_ITEM
	ZD2->ZD2_QUANT		:= SD2->D2_QUANT
	ZD2->ZD2_PRCVEN	:= SD2->D2_PRCVEN
	ZD2->ZD2_TOTAL		:= SD2->D2_TOTAL
	ZD2->ZD2_TES		:= SD2->D2_TES
	ZD2->ZD2_CF	 		:= SD2->D2_CF
	ZD2->ZD2_PESO	:= SD2->D2_PESO
	ZD2->ZD2_PEDIDO	:= SD2->D2_PEDIDO
	ZD2->ZD2_ITEMPV	:= SD2->D2_ITEMPV
	
	For nYnd:=1 To Len(aCpoZD2)
		cNomeCpo	:= aCpoZD2[nYnd,2]
		xValorCpo:= GdFieldGet( aCpoZD2[nYnd,2], nInd)
		ZD2->( FieldPut( FieldPos(aCpoZD2[nYnd,1]) ,xValorCpo )  )
	Next
	
	ZD2->ZD2_HCONSU := Dtos(MsDate())
	
	ZD2->(MsUnLock())
Next

ZF2->(RecLock("ZF2",lAlt))

ZF2->ZF2_ALIAS	:= "SF2"
ZF2->ZF2_FILIAL	:= SF2->F2_FILIAL
ZF2->ZF2_DOC	:= SF2->F2_DOC
ZF2->ZF2_SERIE	:= SF2->F2_SERIE
ZF2->ZF2_CLIENT	:= SF2->F2_CLIENTE
ZF2->ZF2_LOJA	:= SF2->F2_LOJA 
ZF2->ZF2_COND	:= SF2->F2_COND
ZF2->ZF2_DUPL	:= SF2->F2_DUPL
ZF2->ZF2_EMISSA	:= SF2->F2_EMISSAO

For nInd:= 1 To Len(aCpoZF2)
	cNomeCpo	:= aCpoZF2[nInd,2]
	xValorCpo:= Eval(MemVarBlock(aCpoZF2[nInd,2] )  )
	ZF2->( FieldPut( FieldPos(aCpoZF2[nInd,1]) ,Eval(MemVarBlock(aCpoZF2[nInd,2] )  )   )   )
Next
SF2->(RecLock("SF2",.F.))
SF2->F2_YDTMARG:= MsDate()
SF2->(MsUnLock())
ZF2->(MsUnLock())


End Transaction

aCols	:= aClone(aColsAux)
aHeader	:= aClone(aHeadAux)

RestArea(aAreaSF2)
RestArea(aAreaSD2)
RestArea(aAreaZF2)
RestArea(aAreaZD2)

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  02/11/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR107Contru(oHtml,cPedidoVenda,lWorkFlow)
Local aNomeMes		:={"Janeiro","Fevereiro","Mar็o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
Local nValMerc		:=0
Local nTotValMerc	:=0
Local nTotValDesc	:=0
Local nTotVPCDesc	:=0
Local nTotVlrOver	:=0
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq:="@E 9999.9"
Local aCombo	:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local aTipoVPC	:=RetSx3Box( Posicione("SX3", 2, "C5_YTIPACO","X3CBox()" ),,,1)
Local nPercent
Local lGetRent:=.T.
Local clAlias:=GetNextAlias()
Local cQrySC6:=GetNextAlias()
Local lTemLiberado:=.F.
Local nInd
Local cTitulo
Local cProdEsp 	:= SuperGetMv("NCG_000049",.t.,"")
Local cProdEsp1	:= Alltrim(U_MyNewSX6("NCG_000050","","C","Produto Exce็ใo Adicional ao NCG_000049 ","Produto Exce็ใo Adicional ao NCG_000049","",.F. )   )
Local cProd1Esp	:= Alltrim(U_MyNewSX6("NCG_000051","","C","Produto Exce็ใo ","Produto Exce็ใo  ","Produto Exce็ใo  ",.F. )   )
Local cPathPromo:="\MARGEMLIQ\"
Local cHtmlPromo:="TELA_ANALISE_PROMO.html"
Local cDirHtml		:=  Alltrim(U_MyNewSX6(	"NCG_000022","","C","Diretorio dos Html do Workflow ","Diretorio dos Html do Workflow ","Diretorio dos Html do Workflow ",.F. )   )
Local lTemPromo:=U_PR107TemPromo(cPedidoVenda)

Default lWorkFlow:=.T.


aAnoMes:=PR107GetLastMes(dDataBase,3)

For nInd:=1 To Len(aAnoMes)
	oHtml:ValbyName("cMes"+StrZero(nInd,1) ,aNomeMes[Val(Right(aAnoMes[nInd],2))] )
Next

SB2->(DbSetOrder(1))//B2_FILIAL+B2_COD+B2_LOCAL
P0B->(DbSetOrder(5))//P0B_FILIAL+P0B_CODCLI+P0B_LOJA+P0B_PEDIDO+P0B_NIVEL
SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
//SC6->(DbSeek(cChaveSC6) )

nTotalDesc    :=0
nTotalVPCDesc :=0

cQuery:=" Select SC6.R_E_C_N_O_ RecSC6 "
cQuery+=" From "+RetSqlName("SC6")+" SC6 "
cQuery+=" Where SC6.C6_FILIAL='"+xFilial("SC6")+"'"
cQuery+=" And SC6.C6_NUM='"+cPedidoVenda+"'"
cQuery+=" And SC6.D_E_L_E_T_=' '"
cQuery+=" Order By C6_YESTOQU Desc"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQrySC6, .F., .F.)

SB2->(DbSetOrder(1)) //B2_FILIAL+B2_COD+B2_LOCAL

Do While (cQrySC6)->( !Eof()   )
	
	SC6->(DbGoTo( (cQrySC6)->RECSC6   ))
	lEstoqueZero:=(SC6->C6_YESTOQU<=0)
	cProdEsp 	:= cProdEsp + ";" + cProdEsp1
	lProdExc	:= AllTrim(SC6->C6_PRODUTO)$cProdEsp
	lProd1Ex	:= AllTrim(SC6->C6_PRODUTO)$cProd1Esp
	lSoftware:=U_M001IsSoftware( SC6->C6_PRODUTO )
	
	If lSoftware
		(cQrySC6)->(DbSkip());Loop
	EndIf
	
	
	If lGetRent
		nPercent:=0
		If P0B->(DbSeek(xFilial("P0B")+SC6->(C6_CLI+C6_LOJA+C6_NUM) )) .And. P0B->P0B_RENFIN>0
			nPercent:=P0B->P0B_RENFIN
		Else
			U_QRYALC104(@clAlias,0,"2",SC5->C5_YCANAL)
			nPercent:=(clAlias)->P09_RENFIN
			(clAlias)->(DbCloseArea())
			DbSelectArea("SC6")
		EndIf
		lGetRent:=.F.
	Endif
	
	nQtdVen:=SC6->C6_QTDVEN
	If SC6->C6_YQTDLIB>0 .Or. SC5->C5_YLIBC9
		nQtdVen:=SC6->C6_YQTDLIB
	EndIf
	
	nValMerc	:=nQtdVen*SC6->C6_PRCVEN
	nValDescVPC:=SC6->C6_YVALVPC
	nVlrOver	:=SC6->C6_YVLOVER*nQtdVen
	
	If SC6->C6_DESCONT>0
		nValDesc:=SC6->C6_VALDESC
		nPerDesc:=SC6->C6_DESCONT
	Else
		nValDesc:=(SC6->(C6_PRCTAB-C6_PRCVEN)*nQtdVen) +nVlrOver-nValDescVPC
		nPerDesc:=(nValDesc/((SC6->C6_PRCTAB*nQtdVen) +nVlrOver))*100
	EndIf
	
	If (!lEstoqueZero) .Or. AllTrim(SC5->C5_YORIGEM)=="SIMULAR" .Or. lProdExc .Or. lProd1Ex
		nTotValMerc	+=nValMerc
		nTotValDesc +=nValDesc
		nTotVPCDesc +=nValDescVPC
		nTotVlrOver+=nVlrOver
	EndIf
	
	If nQtdVen==0 .Or. SC6->C6_YESTOQU==0
		cColor:="NCGAMES2013_black-status.png"
	Else
		cColor:="NCGAMES2013_green-status.png"
		
		If SC6->C6_YPERLIQ==nPercent
			cColor:="NCGAMES2013_yellow-status.png"
		ElseIf SC6->C6_YPERLIQ<nPercent
			cColor:="NCGAMES2013_red-status.png"
		EndIf
	EndIf
	
	cImagem:="https://www.ncgames.com.br/Assets/Uploads/Margem/"+cColor
	
	
	SB2->(DbSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL )  )
	
	cCorLinha:='"#FFFFFF"'
	If SC6->C6_YPROMO=="S"
		cCorLinha:='"#CAE1FF"'
	EndIf
	
	//oHtml:ExistField( 1, "it.corlinha" )
	AAdd( oHtml:ValByName("it.corlinha"),cCorLinha)
	
	If AllTrim(SC5->C5_YORIGEM)=="SIMULAR"
		AAdd( oHtml:ValByName("it.estoqueatual"),SB2->B2_QATU)//TransForm(SaldoSB2(),cPictQuantid))
		AAdd( oHtml:ValByName("it.estoqueReser"),SB2->B2_RESERVA)
	Else
		AAdd( oHtml:ValByName("it.estoqueatual"),TransForm(SaldoSB2(),cPictQuantid))
		AAdd( oHtml:ValByName("it.estoqueReser"),SC6->C6_QTDRESE)
	EndIf
	
	AAdd( oHtml:ValByName("it.estoquepv")   ,SC6->C6_YESTOQU)
	AAdd( oHtml:ValByName("it.horaestoque") ,SC6->C6_YHCONSU)
	
	aDadosVenda:=PR107Dados(SC6->C6_PRODUTO,aAnoMes,SC6->C6_YALQICM)
	
	For nInd:=1 To Len(aDadosVenda)
		AAdd( oHtml:ValByName("it.vendames"+StrZero(nInd,1) ),TransForm(aDadosVenda[nInd,1],cPictQuantid))
		AAdd( oHtml:ValByName("it.mediames"+StrZero(nInd,1) ),TransForm(aDadosVenda[nInd,2],cPictVlrTota))
	Next
	
	
	AAdd( oHtml:ValByName("it.margembruta")  	 	,TransForm(SC6->C6_YMKPBRU,cPictVlrUnit))
	AAdd( oHtml:ValByName("it.pmargembruta")  	 	,TransForm(SC6->C6_PERBRUT,"@E 9999.9"))
	
	AAdd( oHtml:ValByName("it.pverbaextranopv")  	,Iif(nQtdVen=0,0,PR107GetPer(SC5->C5_DESCONT,SC6->C6_YVERBPV,,.T.)) )
	AAdd( oHtml:ValByName("it.pverbaextra")  	    ,Iif(nQtdVen=0,0,PR107GetPer(SC5->C5_YVERBA,SC6->C6_YVERBPV,,.T.) ))
	
	AAdd( oHtml:ValByName("it.vpc")  				,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRACO),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pvpc")  	    		,Iif(nQtdVen=0 .Or. lEstoqueZero,0,PR107GetPer(SC5->C5_YVLVPC,SC6->C6_YVLRACO,,.T.) ))
	
	AAdd(oHtml:ValByName("it.despesafinanceira")	,TransForm(Iif(nQtdVen=0 .Or. lEstoqueZero,0,SC6->(C6_YVLRDFI)),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pdespesafinanceira")  ,Iif(nQtdVen=0 .Or. lEstoqueZero,0,PR107GetPer(SC5->(C5_YVLRFIN),SC6->(C6_YVLRDFI),,.T.) ))
	
	AAdd( oHtml:ValByName("it.frete")  				,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRFRE),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pfrete")  	    	,Iif(nQtdVen=0 .Or. lEstoqueZero,0,PR107GetPer(SC5->C5_YPGFRET,SC6->C6_YVLRFRE,"@E 9999.9",.T.) ))
	
	AAdd( oHtml:ValByName("it.seguro") 		   		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRSEG),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pseguro")  	    	,Iif(nQtdVen=0 .Or. lEstoqueZero,0,PR107GetPer(SC5->C5_YVLRSEG,SC6->C6_YVLRSEG,"@E 9999.9",.T.) ))
	
	AAdd( oHtml:ValByName("it.despesamkt")    		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRMKT),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pdespesamkt")  	    ,Iif(nQtdVen=0 .Or. lEstoqueZero,0,PR107GetPer(SC5->C5_YMKTINS,SC6->C6_YVLRMKT,"@E 999.9",.T.) ))
	
	AAdd( oHtml:ValByName("it.despesatrade")    	,TransForm(Iif(nQtdVen=0.Or. lEstoqueZero,0,SC6->C6_YVLRTRA),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pdespesatrade")  	    ,Iif(nQtdVen=0 .Or. lEstoqueZero,0,PR107GetPer(SC5->C5_YTRAMKT,SC6->C6_YVLRTRA,"@E 999.9",.T.) ))
	
	
	AAdd( oHtml:ValByName("it.comissoes")  			,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLCOMI),cPictVlrUnit ))
	
	AAdd( oHtml:ValByName("it.pipi")  				,TransForm(SC6->C6_YALQIPI,"@E 99.99"))
	AAdd( oHtml:ValByName("it.picmsret")			,TransForm(SC6->C6_YALQICR,"@E 99.99"))
	AAdd( oHtml:ValByName("it.picms")  				,TransForm(SC6->C6_YALQICM,"@E 99.99"))
	AAdd( oHtml:ValByName("it.ppis")  				,TransForm(SC6->C6_YALQPIS,"@E 99.99"))
	AAdd( oHtml:ValByName("it.pcofins")				,TransForm(SC6->C6_YALQCOF,"@E 99.99"))
	
	AAdd( oHtml:ValByName("it.vpcnopv")  	 		,TransForm(SC6->C6_YVALVPC,cPictVlrUnit))
	AAdd( oHtml:ValByName("it.pvpcnopv")  		 	,TransForm(SC6->C6_YPERVPC,"@E 99.9"))
	
	
	
	AAdd( oHtml:ValByName("it.verbaextranopv") 		 ,TransForm(SC6->C6_YVERBPV,cPictVlrUnit) )
	AAdd( oHtml:ValByName("it.imagem" )    			, cImagem  )
	AAdd( oHtml:ValByName("it.produto" )   			,SC6->C6_PRODUTO )
	AAdd( oHtml:ValByName("it.descricao")  			,SC6->C6_DESCRI )
	AAdd( oHtml:ValByName("it.unidade")  			,SC6->C6_UM)
	AAdd( oHtml:ValByName("it.quantidade" )			,TransForm(nQtdVen,cPictQuantid)   )
	AAdd( oHtml:ValByName("it.precotabela")  		,TransForm(SC6->C6_PRCTAB,cPictVlrUnit))
	
	AAdd( oHtml:ValByName("it.desconto" 	)		,TransForm(nValDesc,cPictVlrUnit))
	AAdd( oHtml:ValByName("it.pdesc")  				,TransForm(nPerDesc,"@E 99.9") )
	
	AAdd( oHtml:ValByName("it.overprice" ) 	   		,TransForm(nQtdVen*SC6->C6_YVLOVER,cPictVlrUnit))
	AAdd( oHtml:ValByName("it.precosemipi" )		,TransForm(SC6->C6_PRCVEN,cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.vlrtotal" )			,TransForm(nQtdVen*SC6->C6_PRCVEN,cPictVlrTota )	)
	AAdd( oHtml:ValByName("it.armazen")  			,SC6->C6_LOCAL)
	AAdd( oHtml:ValByName("it.cfpo")  				,SC6->C6_CF)
	AAdd( oHtml:ValByName("it.tes") 				,SC6->C6_TES)
	
	
	
	AAdd( oHtml:ValByName("it.vlripi")  		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRIPI),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.vlricmsret") 		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRICR),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.vlricms")  		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRICM),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.vlrpis")  		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRPIS),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.vlrcofins")  		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRCOF),cPictVlrUnit ))
	
	AAdd( oHtml:ValByName("it.verbaextra") 		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YVLRVER),cPictVlrUnit ))
	
	AAdd( oHtml:ValByName("it.tipocmv") 	    	, Left ( aCombo[Ascan(aCombo,{|a| a[2]==SC6->C6_YSTPCMV} ),3],3)    )
	AAdd( oHtml:ValByName("it.cmvunit")  			,TransForm(SC6->C6_YCMVUNI,cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.cmvtotal")  			,TransForm(Iif(nQtdVen=0,0,SC6->C6_YCMVTOT),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.margemliquida")  		,TransForm(Iif(nQtdVen=0,0,SC6->C6_YMKPLIQ),cPictVlrUnit ))
	AAdd( oHtml:ValByName("it.pmargemliquida") 		,TransForm( Iif(nQtdVen=0,0,SC6->C6_YPERLIQ),cPerLiq   ) )
	
	
	(cQrySC6)->(DbSkip())
EndDo


oHtml:ValbyName("cPedido" ,SC5->C5_NUM )
oHtml:ValbyName("cCliente",SC5->( C5_CLIENTE+C5_LOJACLI+"-"+C5_NOMCLI))
oHtml:ValbyName("dEmissao",dtoc(SC5->C5_EMISSAO))

If !Empty(SC5->C5_YCONDPG)
	oHtml:ValbyName("cCondPag",SC5->C5_YCONDPG+"-"+Posicione("SE4",1,xFilial("SE4")+SC5->C5_YCONDPG,"E4_COND") )
Else
	oHtml:ValbyName("cCondPag",SC5->C5_CONDPAG+"-"+Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_COND") )
EndIf

cTitulo:="Anแlise Margem Lํquida"
If AllTrim(SC5->C5_YORIGEM)=="SIMULAR"
	cTitulo:="Or็amento"
EndIf

oHtml:ValbyName("cTituloHTML", cTitulo)

oHtml:ValbyName("cVendedor", SC5->C5_VEND1+"-"+Posicione("SA3",1,xFilial("SA3")+SC5->C5_VEND1,"A3_NOME"))
oHtml:ValbyName("cCanal", SC5->( C5_YCANAL+"-"+C5_YDCANAL) )
oHtml:ValbyName("cUf", Posicione("SA1",1,xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI,"A1_EST"))


nValBrut	:= SC5->C5_YTOTBRU  
nImpIPI		:= SC5->C5_YVLRIPI	//Solicita็ใo do Claudio - IPI
nImpICM		:= SC5->C5_YVLRICM	//Solicita็ใo do Claudio - ICMS
nImpST		:= SC5->C5_YVLRICR	//Solicita็ใo do Claudio - ST
nImpPIS		:= SC5->C5_YVLRPIS	//Solicita็ใo do Claudio - PIS
nImpCOF		:= SC5->C5_YVLRCOF	//Solicita็ใo do Claudio - COFINS
nTotImposto	:= SC5->(C5_YVLRIPI+C5_YVLRICR+C5_YVLRICM+C5_YVLRPIS+C5_YVLRCOF)
nSubTotal07	:= (nValBrut+nTotVlrOver-nTotValDesc-nTotVPCDesc-SC5->C5_DESCONT)
nVlrMerc 	:= (nSubTotal07 - nImpIPI - nImpST)

oHtml:ValbyName("nVENDABRUTA" ,TransForm(nValBrut,cPictVlrTota))
oHtml:ValbyName("nOverPrice"  ,TransForm(nTotVlrOver,cPictVlrTota))
oHtml:ValbyName("pOverPrice" ,PR107GetPer(nValBrut,nTotVlrOver))


oHtml:ValbyName("nSubTotal03",TransForm(nValBrut+nTotVlrOver,cPictVlrTota))


oHtml:ValbyName("nDESCONTO",TransForm(nTotValDesc,cPictVlrTota))
oHtml:ValbyName("pDESCONTO",PR107GetPer(nValBrut+nTotVlrOver,nTotValDesc))

oHtml:ValbyName("nVPCPV" , TransForm(nTotVPCDesc,cPictVlrTota))
oHtml:ValbyName("cTipoVPC",aTipoVPC[Ascan(aTipoVPC,{|a| a[2]==SC5->C5_YTIPACO} ),3])

//oHtml:ValbyName("pVPCPV",PR107GetPer((nVlrMerc+nTotVlrOver),nTotVPCDesc,"@E 999.9",.T.,2))//TransForm(SC5->C5_DESC2,"@E 999.99"))
oHtml:ValbyName("pVPCPV",PR107GetPer(nValBrut+nTotVlrOver,nTotVPCDesc,"@E 999.9",.T.,1))//TransForm(SC5->C5_DESC2,"@E 999.99"))

oHtml:ValbyName("nVERBAPVEXTRA",TransForm(SC5->C5_DESCONT,cPictVlrTota))
oHtml:ValbyName("pVERBAPVEXTRA",PR107GetPer(nValBrut+nTotVlrOver,SC5->C5_DESCONT,"@E 9999.9"))

/*---------------------------------------------------------------------------------*/

oHtml:ValbyName("nSubTotal07",TransForm(nSubTotal07,cPictVlrTota))
oHtml:ValbyName("pSubTotal07",PR107GetPer(nSubTotal07,nSubTotal07,"@E 9999.9"))

oHtml:ValbyName("nImpIPI", TransForm(nImpIPI,cPictVlrTota)  )
oHtml:ValbyName("pImpIPI",PR107GetPer(nVlrMerc,nImpIPI,"@E 9999.9"))

oHtml:ValbyName("nImpICMS", TransForm(nImpICM,cPictVlrTota)  )
oHtml:ValbyName("pImpICMS",PR107GetPer(nVlrMerc,nImpICM,"@E 9999.9"))

oHtml:ValbyName("nImpST", TransForm(nImpST,cPictVlrTota)  )
oHtml:ValbyName("pImpST",PR107GetPer(nSubTotal07,nImpST,"@E 9999.9"))

oHtml:ValbyName("nImpPIS", TransForm(nImpPIS,cPictVlrTota)  )
oHtml:ValbyName("pImpPIS",PR107GetPer(nVlrMerc,nImpPIS,"@E 9999.9"))

oHtml:ValbyName("nImpCOFINS", TransForm(nImpCOF,cPictVlrTota)  )
oHtml:ValbyName("pImpCOFINS",PR107GetPer(nVlrMerc,nImpCOF,"@E 9999.9"))

oHtml:ValbyName("nIMPOSTO", TransForm(nTotImposto,cPictVlrTota)  )
oHtml:ValbyName("pIMPOSTO",PR107GetPer(nSubTotal07,nTotImposto,"@E 9999.9"))

/*----------------------------------------------------------------------------*/

oHtml:ValbyName("nVENDALIQUIDA",TransForm(nSubTotal07-nTotImposto,cPictVlrTota) )
oHtml:ValbyName("pVENDALIQUIDA",  PR107GetPer(nSubTotal07,nValBrut+nTotVlrOver-nTotValDesc-nTotVPCDesc-nTotImposto-SC5->C5_DESCONT-SC5->C5_YVANUAL,"@E 9999.9")  )

oHtml:ValbyName("nCMV",TransForm(SC5->C5_YTOTCUS,cPictVlrTota) )
oHtml:ValbyName("pCMV",PR107GetPer(nSubTotal07,SC5->C5_YTOTCUS,"@E 9999.9"))

oHtml:ValbyName("nLUCROBRUTO",TransForm(SC5->C5_YLUCRBR,cPictVlrTota) )
oHtml:ValbyName("pLUCROBRUTO",TransForm(SC5->C5_YPERRBR,"@E 9999.99"))

//-----------------------------------------------------------------------------//

oHtml:ValbyName("nFRETE",TransForm(SC5->C5_YPGFRET,cPictVlrTota))
oHtml:ValbyName("pFRETE",TransForm(SC5->C5_YPFRETE,AvSx3("C5_YPFRETE",6)  ))

oHtml:ValbyName("nFRETEtransf",TransForm(SC5->C5_YVFRTRA,cPictVlrTota))			  //Frete Transferencia
oHtml:ValbyName("pFRETEtransf",TransForm(SC5->C5_YPFRTRA,AvSx3("C5_YPFRTRA",6)  ))//Frete Transferencia

oHtml:ValbyName("nSEGURO",TransForm(SC5->C5_YVLRSEG,cPictVlrTota))
oHtml:ValbyName("pSEGURO",TransForm(SC5->C5_YPSEGUR,AvSx3("C5_YPSEGUR",6)))

oHtml:ValbyName("nSEGUROtransf",TransForm(SC5->C5_YVSETRA,cPictVlrTota))          //Seguro Transferencia
oHtml:ValbyName("pSEGUROtransf",TransForm(SC5->C5_YPSETRA,AvSx3("C5_YPSETRA",6)	))//Seguro Transferencia

oHtml:ValbyName("nCOMISSOES",TransForm(SC5->C5_YVLRCOM,cPictVlrTota))
oHtml:ValbyName("pCOMISSOES",TransForm(SC5->C5_YCOMISS,"@E 999.99"))

oHtml:ValbyName("nDESPESASMKT",TransForm(SC5->C5_YMKTINS,cPictVlrTota))
oHtml:ValbyName("pDESPESASMKT",TransForm(SC5->C5_YPERMKT,AvSx3("C5_YPERMKT",6)))

oHtml:ValbyName("nDESPESASTRADE",TransForm(SC5->C5_YTRAMKT,cPictVlrTota))
oHtml:ValbyName("pDESPESASTRADE",TransForm(SC5->C5_YPERTRA,AvSx3("C5_YPERTRA",6)))

oHtml:ValbyName("nVPC" , TransForm(SC5->C5_YVLVPC,cPictVlrTota))
oHtml:ValbyName("pVPC",TransForm(SC5->C5_YACORDO,AvSx3("C5_YACORDO",6)))

oHtml:ValbyName("nVERBAEXTRA",TransForm(SC5->C5_YVERBA,cPictVlrTota))
oHtml:ValbyName("pVERBAEXTRA",TransForm(SC5->C5_YPERVER,AvSx3("C5_YPERVER",6)))

nC5DESP := SC5->(C5_YPGFRET+C5_YVLRSEG+C5_YVLRCOM+C5_YMKTINS+C5_YTRAMKT+C5_YVERBA+C5_YVLVPC) 

oHtml:ValbyName("nSubTotal19",TransForm(nC5DESP,cPictVlrTota))
oHtml:ValbyName("pSubTotal19",PR107GetPer(nSubTotal07,nC5DESP))

//--------------------------------------------------------------------------------------// 

nC5YLUCR := SC5->C5_YLUCRBR-nC5DESP 

oHtml:ValbyName("nSubTotal20",TransForm(nC5YLUCR,cPictVlrTota))
oHtml:ValbyName("pSubTotal20",PR107GetPer(nSubTotal07,nC5YLUCR))

oHtml:ValbyName("nValorBoleto",TransForm(SC5->C5_YDESPES,cPictVlrTota))
oHtml:ValbyName("pValorBoleto",PR107GetPer(nSubTotal07,SC5->C5_YDESPES,"@E 999.9"))

oHtml:ValbyName("nDESPESAFINANCEIRA",TransForm(SC5->C5_YVLRFIN,cPictVlrTota))
oHtml:ValbyName("pDESPESAFINANCEIRA",TransForm(SC5->C5_YDESFIN,"@E 999.99"))                                        '

//--------------------------------------------------------------------------------------//

oHtml:ValbyName("nMARGEMLIQUIDA",TransForm(nC5YLUCR-SC5->(C5_YDESPES+C5_YVLRFIN),cPictVlrTota))
oHtml:ValbyName("pMARGEMLIQUIDA",PR107GetPer(nSubTotal07,nC5YLUCR-SC5->(C5_YDESPES+C5_YVLRFIN),"@E 9999.9"))

//oHtml:ValbyName("nMARGEMLIQUIDA",TransForm(SC5->C5_YTOTLIQ,cPictVlrTota))
//oHtml:ValbyName("pMARGEMLIQUIDA",PR107GetPer(nValBrut,SC5->C5_YTOTLIQ,"@E 9999.9"))


If lTemPromo
	Processa( {|| U_PR107Promo(oHtml) })
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107A บAutor  ณMicrosiga           บ Data ณ  10/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR107Promo(oHtml)
Local aAeraAtu:=GetArea()
Local aAeraSC5:=SC5->(GetArea())
Local bSeekFor
Local cSufixo
Default oHtml:=Nil

INCLUI:=.T. // Por causa do CalcFrete

For nInd:=1 To 2   // Fazer a simulacao uma vez com promo็ao e outra sem promocao
	RegToMemory("SC5",.F.,.F.)
	If nInd==1
		bSeekFor	:={|| C6_YPROMO=="S"  }
		cSufixo	:="SP"  //Sim Promocao
	Else
		bSeekFor:={|| !C6_YPROMO=="S"  }
		cSufixo	:="NP"//Nao Promocao
	EndIf
	
	aCols:={}
	aHeader:={}
	
	SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM }, bSeekFor , /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
	
	If !Empty(GdFieldGet("C6_PRODUTO",1))
		PR107HtmPromo(oHtml,cSufixo)
	Endif
Next


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107A บAutor  ณMicrosiga           บ Data ณ  10/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR107HtmPromo(oHtml,cSufixo)
Local nInd
Local nValMerc		:=0
Local nTotValMerc	:=0
Local nTotValDesc	:=0
Local nTotVPCDesc	:=0
Local nTotVlrOver	:=0
Local cPictVlrUnit:="@E 99,999,999.99"
Local cPictVlrTota:="@E 999,999,999.99"
Local cPictQuantid:="@E 999999999"
Local cPerLiq		:="@E 9999.9"
Local aCombo		:=RetSx3Box( Posicione("SX3", 2, "C6_YSTPCMV","X3CBox()" ),,,1)
Local aTipoVPC		:=RetSx3Box( Posicione("SX3", 2, "C5_YTIPACO","X3CBox()" ),,,1)
Local lProdExc
Local lProd1Ex
Local cProdEsp 	:= SuperGetMv("NCG_000049",.t.,"")
Local cProdEsp1	:= Alltrim(U_MyNewSX6("NCG_000050","","C","Produto Exce็ใo Adicional ao NCG_000049 ","Produto Exce็ใo Adicional ao NCG_000049","",.F. )   )
Local cProd1Esp	:= Alltrim(U_MyNewSX6("NCG_000051","","C","Produto Exce็ใo ","Produto Exce็ใo  ","Produto Exce็ใo  ",.F. )   )


U_PR107VAL() //Simulador Margem Liquida


For nInd:=1 To Len(aCols)
	
	lEstoqueZero:=(GdFieldGet("C6_YESTOQU",nInd)<=0)
	cProdEsp 	:= cProdEsp + ";" + cProdEsp1
	lProdExc	:= AllTrim(GdFieldGet("C6_PRODUTO",nInd))$cProdEsp
	lProd1Ex	:= AllTrim(GdFieldGet("C6_PRODUTO",nInd))$cProd1Esp
	lSoftware:=U_M001IsSoftware( GdFieldGet("C6_PRODUTO",nInd) )
	
	If lSoftware
		Loop
	EndIf
	
	nQtdVen:=GdFieldGet("C6_QTDVEN",nInd)
	If GdFieldGet("C6_YQTDLIB",nInd)>0 .Or. M->C5_YLIBC9
		nQtdVen:=GdFieldGet("C6_YQTDLIB",nInd)
	EndIf
	
	nValMerc	:=nQtdVen*GdFieldGet("C6_PRCVEN",nInd)
	nValDescVPC:=GdFieldGet("C6_YVALVPC",nInd)
	nVlrOver	:=GdFieldGet("C6_YVLOVER",nInd)*nQtdVen
	
	If GdFieldGet("C6_DESCONT",nInd)>0
		nValDesc:=GdFieldGet("C6_VALDESC",nInd)
		nPerDesc:=GdFieldGet("C6_DESCONT",nInd)
	Else
		nValDesc:=((GdFieldGet("C6_PRCTAB",nInd)-GdFieldGet("C6_PRCVEN",nInd))*nQtdVen) +nVlrOver-nValDescVPC
		nPerDesc:=(nValDesc/((GdFieldGet("C6_PRCTAB",nInd)*nQtdVen) +nVlrOver))*100
	EndIf
	
	If (!lEstoqueZero) .Or. AllTrim(M->C5_YORIGEM)=="SIMULAR" .Or. lProdExc .Or. lProd1Ex
		nTotValMerc	+=nValMerc
		nTotValDesc +=nValDesc
		nTotVPCDesc +=nValDescVPC
		nTotVlrOver+=nVlrOver
	EndIf
	
Next

nValBrut	:=M->C5_YTOTBRU
nTotImposto	:=M->(C5_YVLRIPI+C5_YVLRICR+C5_YVLRICM+C5_YVLRPIS+C5_YVLRCOF)

oHtml:ValbyName("nVENDABRUTA"+cSufixo ,TransForm(nValBrut,cPictVlrTota))
oHtml:ValbyName("nOverPrice"+cSufixo  ,TransForm(nTotVlrOver,cPictVlrTota))
oHtml:ValbyName("pOverPrice"+cSufixo ,PR107GetPer(nValBrut,nTotVlrOver))

oHtml:ValbyName("nSubTotal03"+cSufixo,TransForm(nValBrut+nTotVlrOver,cPictVlrTota))

oHtml:ValbyName("nDESCONTO"+cSufixo,TransForm(nTotValDesc,cPictVlrTota))
oHtml:ValbyName("pDESCONTO"+cSufixo,PR107GetPer(nValBrut+nTotVlrOver,nTotValDesc))

oHtml:ValbyName("nVPCPV"+cSufixo , TransForm(nTotVPCDesc,cPictVlrTota))
oHtml:ValbyName("cTipoVPC"+cSufixo,aTipoVPC[Ascan(aTipoVPC,{|a| a[2]==M->C5_YTIPACO} ),3])

oHtml:ValbyName("pVPCPV"+cSufixo,PR107GetPer(nValBrut+nTotVlrOver,nTotVPCDesc,"@E 999.9",.T.))//TransForm(M->C5_DESC2,"@E 999.99"))

oHtml:ValbyName("nVERBAPVEXTRA"+cSufixo,TransForm(M->C5_DESCONT,cPictVlrTota))
oHtml:ValbyName("pVERBAPVEXTRA"+cSufixo,PR107GetPer(nValBrut+nTotVlrOver,M->C5_DESCONT,"@E 9999.9"))

nSubTotal07:=(nValBrut+nTotVlrOver-nTotValDesc-nTotVPCDesc-M->C5_DESCONT-M->C5_YVANUAL)
oHtml:ValbyName("nSubTotal07"+cSufixo,TransForm(nSubTotal07,cPictVlrTota))
oHtml:ValbyName("pSubTotal07"+cSufixo,PR107GetPer(nSubTotal07,nSubTotal07,"@E 9999.9"))


oHtml:ValbyName("nIMPOSTO"+cSufixo, TransForm(nTotImposto,cPictVlrTota)  )
oHtml:ValbyName("pIMPOSTO"+cSufixo,PR107GetPer(nSubTotal07,nTotImposto,"@E 9999.9"))


oHtml:ValbyName("nVENDALIQUIDA"+cSufixo,TransForm(nValBrut+nTotVlrOver-nTotValDesc-nTotVPCDesc-M->C5_DESCONT-nTotImposto-M->C5_YVANUAL,cPictVlrTota) )
oHtml:ValbyName("pVENDALIQUIDA"+cSufixo,  PR107GetPer(nSubTotal07,nValBrut+nTotVlrOver-nTotValDesc-nTotVPCDesc-nTotImposto-M->C5_DESCONT-M->C5_YVANUAL,"@E 9999.9")  )

oHtml:ValbyName("nCMV"+cSufixo,TransForm(M->C5_YTOTCUS,cPictVlrTota) )
oHtml:ValbyName("pCMV"+cSufixo,PR107GetPer(nSubTotal07,M->C5_YTOTCUS,"@E 9999.9"))


oHtml:ValbyName("nLUCROBRUTO"+cSufixo,TransForm(M->C5_YLUCRBR,cPictVlrTota) )
oHtml:ValbyName("pLUCROBRUTO"+cSufixo,TransForm(M->C5_YPERRBR,"@E 999.99"))

oHtml:ValbyName("nFRETE"+cSufixo,TransForm(M->C5_YPGFRET,cPictVlrTota))
oHtml:ValbyName("pFRETE"+cSufixo,TransForm(M->C5_YPFRETE,AvSx3("C5_YPFRETE",6)  ))

oHtml:ValbyName("nSEGURO"+cSufixo,TransForm(M->C5_YVLRSEG,cPictVlrTota))
oHtml:ValbyName("pSEGURO"+cSufixo,TransForm(M->C5_YPSEGUR,AvSx3("C5_YPSEGUR",6)))

oHtml:ValbyName("nCOMISSOES"+cSufixo,TransForm(M->C5_YVLRCOM,cPictVlrTota))
oHtml:ValbyName("pCOMISSOES"+cSufixo,TransForm(M->C5_YCOMISS,"@E 999.99"))


oHtml:ValbyName("nDESPESASMKT"+cSufixo,TransForm(M->C5_YMKTINS,cPictVlrTota))
oHtml:ValbyName("pDESPESASMKT"+cSufixo,TransForm(M->C5_YPERMKT,AvSx3("C5_YPERMKT",6)))

oHtml:ValbyName("nDESPESASTRADE"+cSufixo,TransForm(M->C5_YTRAMKT,cPictVlrTota))
oHtml:ValbyName("pDESPESASTRADE"+cSufixo,TransForm(M->C5_YPERTRA,AvSx3("C5_YPERTRA",6)))

oHtml:ValbyName("nVPC"+cSufixo , TransForm(M->C5_YVLVPC,cPictVlrTota))
oHtml:ValbyName("pVPC"+cSufixo,TransForm(M->C5_YACORDO,AvSx3("C5_YACORDO",6)))

oHtml:ValbyName("nVERBAEXTRA"+cSufixo,TransForm(M->C5_YVERBA,cPictVlrTota))
oHtml:ValbyName("pVERBAEXTRA"+cSufixo,TransForm(M->C5_YPERVER,AvSx3("C5_YPERVER",6)))

oHtml:ValbyName("nSubTotal19"+cSufixo,TransForm(M->(C5_YPGFRET+C5_YVLRSEG+C5_YVLRCOM+C5_YMKTINS+C5_YTRAMKT+C5_YVERBA+C5_YVLVPC),cPictVlrTota))
oHtml:ValbyName("pSubTotal19"+cSufixo,PR107GetPer(nSubTotal07,M->(C5_YPGFRET+C5_YVLRSEG+C5_YVLRCOM+C5_YMKTINS+C5_YTRAMKT+C5_YVERBA+C5_YVLVPC)))


oHtml:ValbyName("nSubTotal20"+cSufixo,TransForm(M->C5_YLUCRBR-M->(C5_YPGFRET+C5_YVLRSEG+C5_YVLRCOM+C5_YMKTINS+C5_YTRAMKT+C5_YVERBA+C5_YVLVPC),cPictVlrTota))
oHtml:ValbyName("pSubTotal20"+cSufixo,PR107GetPer(nSubTotal07,M->C5_YLUCRBR-M->(C5_YPGFRET+C5_YVLRSEG+C5_YVLRCOM+C5_YMKTINS+C5_YTRAMKT+C5_YVERBA+C5_YVLVPC)))

oHtml:ValbyName("nDESPESAFINANCEIRA"+cSufixo,TransForm(M->C5_YVLRFIN,cPictVlrTota))
oHtml:ValbyName("pDESPESAFINANCEIRA"+cSufixo,TransForm(M->C5_YDESFIN,"@E 999.99"))

oHtml:ValbyName("nMARGEMLIQUIDA"+cSufixo,TransForm(M->C5_YTOTLIQ,cPictVlrTota))
oHtml:ValbyName("pMARGEMLIQUIDA"+cSufixo,PR107GetPer(nValBrut,M->C5_YTOTLIQ,"@E 9999.9"))

oHtml:ValbyName("nValorBoleto"+cSufixo,TransForm(M->C5_YDESPES,cPictVlrTota))
oHtml:ValbyName("pValorBoleto"+cSufixo,PR107GetPer(nSubTotal07,M->C5_YDESPES,"@E 999.9"))


oHtml:ValbyName("nVPCAnual"+cSufixo,TransForm(M->C5_YVANUAL,cPictVlrTota))
oHtml:ValbyName("pVPCAnual"+cSufixo,TransForm(M->C5_YPANUAL,AvSx3("C5_YPANUAL",6)))

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107A บAutor  ณMicrosiga           บ Data ณ  10/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR107TemPromo(cPedidoVenda)
Local aAreaAtu		:=GetArea()
Local cQrySC6		:=GetNextAlias()
Local cQuery
Local lTemPromo

cQuery:=" Select Count(1) Contar "
cQuery+=" From "+RetSqlName("SC6")+" SC6 "
cQuery+=" Where SC6.C6_FILIAL='"+xFilial("SC6")+"'"
cQuery+=" And SC6.C6_NUM='"+cPedidoVenda+"'"
cQuery+=" And SC6.C6_YPROMO='S'"
cQuery+=" And SC6.D_E_L_E_T_=' '"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQrySC6, .F., .F.)

lTemPromo:=(cQrySC6)->Contar>0
(cQrySC6)->(DbCloseArea())
RestArea(aAreaAtu)

Return  lTemPromo


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  04/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR107Dados(cProduto,aAnoMes,nAliqICM)
Local aDados     :={}
Local aAreaAtu  :=GetArea()
Local cAliasQry  :=GetNextAlias()
Local nQuantVend:=0
Local nInd


For nInd:=1 To Len(aAnoMes)
	cAnoMes:=aAnoMes[nInd]
	
	nVlrMedio:=0
	
	For nYnd:=1 To 2
		IncProc("Verificando Venda Produto "+cProduto+" M๊s "+Right(cAnoMes,2)+" Ano "+Left(cAnoMes,4)   )
		
		cQuery:=" SELECT SD2.D2_QUANT QUANT, SD2.D2_TOTAL TOTAL"
		cQuery+=" FROM   "+RetSqlName("SD2")+" SD2, "+RetSqlName("SF2")+" SF2 "
		cQuery+=" WHERE Substr(SF2.F2_EMISSAO,1,6)='"+cAnoMes+"'"
		cQuery+=" AND SD2.D_E_L_E_T_    <> '*' "
		cQuery+=" AND SF2.D_E_L_E_T_    <> '*' "
		cQuery+=" AND SD2.D2_FILIAL     =  '"+xFilial("SD2")+"' "
		cQuery+=" AND SF2.F2_DOC        = SD2.D2_DOC "
		cQuery+=" AND SF2.F2_SERIE      = SD2.D2_SERIE "
		cQuery+=" AND SF2.F2_LOJA       = SD2.D2_LOJA "
		cQuery+=" AND SF2.F2_FILIAL     = SD2.D2_FILIAL "
		cQuery+=" AND SF2.F2_CLIENTE    = SD2.D2_CLIENTE "
		cQuery+=" AND SD2.D2_CF         IN (5102,6102,5403,6403,5405,6405,5108,6108,5110,6110,5404,6404,5114,6114) "
		cQuery+=" AND SD2.D2_COD='"+cProduto+"'"
		
		If nYnd==1  //Valor
			cQuery+=" AND SD2.D2_PICM="+AllTrim(Str(nAliqICM))
		EndIf
		
		cQuery+=" UNION ALL "
		
		cQuery+=" SELECT   SD1.D1_QUANT*-1 QUANT, SD1.D1_TOTAL*-1 TOTAL   "
		cQuery+=" FROM "+RetSqlName("SF1")+" SF1,"+RetSqlName("SD1")+" SD1,"+RetSqlName("SF2")+" SF2 "
		cQuery+=" WHERE SD1.D1_DOC = SF1.F1_DOC
		cQuery+=" AND SD1.D1_SERIE  = SF1.F1_SERIE
		cQuery+=" AND SD1.D1_FORNECE= SF1.F1_FORNECE
		cQuery+=" AND SD1.D1_LOJA   = SF1.F1_LOJA
		cQuery+=" AND SD1.D_E_L_E_T_= ' '
		cQuery+=" AND SD1.D1_COD='"+cProduto+"'"
		cQuery+=" AND SD1.D1_FILIAL = '"+xFilial("SD1")+"'"
		cQuery+=" AND SD1.D1_NFORI = SF2.F2_DOC
		cQuery+=" AND SD1.D1_SERIORI= SF2.F2_SERIE
		cQuery+=" AND SD1.D1_LOJA   = SF2.F2_LOJA
		cQuery+=" AND SF2.F2_CLIENTE= SD1.D1_FORNECE
		cQuery+=" AND SF2.F2_FILIAL= '"+xFilial("SF2")+"'"
		cQuery+=" AND SF2.D_E_L_E_T_  = ' '
		cQuery+=" AND Substr(SD1.D1_DTDIGIT,16)='"+cAnoMes+"'"
		cQuery+=" AND SF1.F1_FILIAL= '"+xFilial("SF1")+"'"
		cQuery+=" AND SF1.D_E_L_E_T_  = ' '"
		cQuery+=" AND EXISTS (SELECT 'X' FROM  "+RetSqlName("SF4")+" SF4 WHERE SF4.F4_FILIAL = '"+xFilial("SF4")+"'"
		cQuery+="             AND D1_TES = SF4.F4_CODIGO
		cQuery+="             AND SF4.F4_DUPLIC ='S'
		cQuery+="             AND SF4.F4_ESTOQUE ='S'
		cQuery+="             AND SF4.D_E_L_E_T_ =' '
		cQuery+="             )"
		
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)
		
		nQuantVend:=0
		nVlrTotal :=0
		
		Do While (cAliasQry)->(!Eof())
			nQuantVend+=(cAliasQry)->QUANT
			nVlrTotal+=(cAliasQry)->TOTAL
			(cAliasQry)->(DbSkip())
		EndDo
		
		(cAliasQry)->(DbCloseArea())
		
		If nYnd==1  //Valor
			nVlrMedio:= nVlrTotal/(IIf(nQuantVend==0,1,nQuantVend))
		EndIf
		
	Next
	AADD(aDados,{nQuantVend,nVlrMedio})
Next

RestArea(aAreaAtu)

Return aDados
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  04/14/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR107GetLastMes(dDataBase,nMesAnt)
Local aReturn:={}
Local nInd:=1
Local dtAux:=dDataBase

For nInd:=1 To nMesAnt
	dtAux:=FirstDay(dtAux)-1
	AADD(aReturn, StrZero(Year(dtAux),4)+StrZero(Month(dtAux),2)  )
Next

Return aReturn
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR107  บAutor  ณMicrosiga           บ Data ณ  01/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR107GetPer(nTotal,nValor,cPicture,lRound,nCasaArred)
Local nVlrRet

Default cPicture:="@E 9999.9"
Default lRound:=.F.
Default nCasaArred:=0


If nTotal==0
	nVlrRe:=0
Else
	nVlrRet:=nValor/nTotal*100
	If lRound
		nVlrRet:=Round(nVlrRet,nCasaArred)
	EndIf
EndIf


Return TransForm(  nVlrRet, cPicture)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณP107Dtb บAutor  ณMicrosiga           บ Data ณ  06/10/14     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function P107Dtb()
Return dDtSB9
