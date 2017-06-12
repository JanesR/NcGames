#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107B ºAutor  ³Microsiga           º Data ³  02/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function PR107BJOB(aDados)
Local cQuery:=""
Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2] )

PR107BNF("S")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107B ºAutor  ³Microsiga           º Data ³  02/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR107B ºAutor  ³Microsiga           º Data ³  02/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
	
	If SF2->F2_TPFRETE=="C"
		cAliasAtu:=Alias()
		cQuery:=' SELECT NFD.NUMNF_NFDESPACHADAS, NFD.SERIENF_NFDESPACHADAS, NFD.CHAVE_ACESSO, FN.VALOR_FRETE'
		cQuery+=' FROM FRETES.TB_FRTNFDESPACHADAS NFD,FRETES.TB_FRTFRETENOTA FN'
		cQuery+=' WHERE FN.DOC_NFDESPACHADAS ='+AllTrim(Str(Val(SD2->D2_DOC)))
		cQuery+=' AND NFD.SERIENF_NFDESPACHADAS='+AllTrim(Str(Val(SD2->D2_SERIE)))
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
	ZD2->ZD2_LOJA	:= SD2->D2_LOJA
	ZD2->ZD2_DOC	:= SD2->D2_DOC
	ZD2->ZD2_SERIE 	:= SD2->D2_SERIE
	ZD2->ZD2_COD	:= SD2->D2_COD
	ZD2->ZD2_ITEM 	:= SD2->D2_ITEM
	ZD2->ZD2_QUANT	:= SD2->D2_QUANT
	ZD2->ZD2_PRCVEN	:= SD2->D2_PRCVEN
	ZD2->ZD2_TOTAL	:= SD2->D2_TOTAL
	ZD2->ZD2_TES	:= SD2->D2_TES
	ZD2->ZD2_CF		:= SD2->D2_CF
	ZD2->ZD2_PESO	:= SD2->D2_PESO
	ZD2->ZD2_PEDIDO	:= SD2->D2_PEDIDO
	ZD2->ZD2_ITEMPV	:= SD2->D2_ITEMPV
	
	For nYnd:=1 To Len(aCpoZD2)
		cNomeCpo	:= aCpoZD2[nYnd,2]
		xValorCpo:= GdFieldGet( aCpoZD2[nYnd,2], nInd)
		ZD2->( FieldPut( FieldPos(aCpoZD2[nYnd,1]) ,GdFieldGet( aCpoZD2[nYnd,2], nInd) )  )
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

aCols		:= aClone(aColsAux)
aHeader	:= aClone(aHeadAux)

RestArea(aAreaSF2)
RestArea(aAreaSD2)
RestArea(aAreaZF2)
RestArea(aAreaZD2)

RestArea(aAreaAtu)
Return
