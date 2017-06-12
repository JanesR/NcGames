#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFCHCMGBR  บAutor  ณMicrosiga           บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para efetuar o fechamento do CMG BR        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                 
                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPP203()

Local aArea 	:= GetArea()
Local aParams	:= {}

If PergRel(@aParams)
	
	If VldParam(aParams)	      
						//FCHCMGBR(dDtRef, cCodIni, cCodFin, cLocalIni, cLocalFin)			
		Processa({|lEnd|  FCHCMGBR(aParams[1],aParams[2], aParams[3], aParams[4], aParams[5]) }, 'Fechamento CMG BR...')
		
	 EndIf
EndIf

RestArea(aArea)
Return                        


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFCHCMGBR  บAutor  ณMicrosiga           บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para efetuar o fechamento do CMG BR        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FCHCMGBR(dDtRef, cCodIni, cCodFin, cLocalIni, cLocalFin)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local aEstDt	:= {}
Local nCustMed	:= 0      
Local nCnt		:= 0

Default dDtRef		:= CTOD('')
Default cCodIni		:= "" 
Default cCodFin		:= "" 
Default cLocalIni	:= "" 
Default cLocalFin	:= ""


cQuery    := " SELECT B9_DATA, B9_COD, B9_LOCAL, B9_CM1, B9_VINI1, R_E_C_N_O_ RECNOSB9 FROM "+RetSqlName("SB9")+" SB9 "+CRLF
cQuery    += " WHERE SB9.B9_FILIAL = '"+xFilial("SB9")+"' "+CRLF
cQuery    += " AND SB9.B9_COD BETWEEN '"+cCodIni+"' AND '"+cCodFin+"' "+CRLF
cQuery    += " AND SB9.B9_LOCAL BETWEEN '"+cLocalIni+"' AND '"+cLocalFin+"' "+CRLF
cQuery    += " AND SB9.B9_DATA BETWEEN '20140101' AND '"+DTOS(dDtRef)+"' "+CRLF
cQuery    += " AND SB9.B9_YCMGBR = '0' "
cQuery    += " AND SB9.D_E_L_E_T_  = '  ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("SB9")
DbSetOrder(1)

DbSelectArea(cArqTmp)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua( nCnt )

While (cArqTmp)->(!Eof())
	
	IncProc("Produto: " + (cArqTmp)->B9_COD + "/  Armz. " + (cArqTmp)->B9_LOCAL )
		
	nCustMed	:= 0

	//Efetua o calculo do CMG BR do final do dia
	aEstDt := u_GetEstBR((cArqTmp)->B9_COD, (cArqTmp)->B9_LOCAL, stod((cArqTmp)->B9_DATA) + 1)
	
	If Len(aEstDt) >= 3
		
		If aEstDt[2] > 0
			nCustMed	:= aEstDt[3]
	    Else
			nCustMed	:= (cArqTmp)->B9_CM1
		EndIf
	EndIf
	
	If (cArqTmp)->(!Eof())
   		SB9->(DbGoTo((cArqTmp)->RECNOSB9))
   		RecLock("SB9",.F.)
   		SB9->B9_YCMGBR := nCustMed
   		SB9->(MsUnLock())		
	EndIf
	
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return                                                                       




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPergRel	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas a serem utilizadas no filtro do relatorio        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergRel(aParams)

Local aParamBox := {}
Local llRet      := .T.

AADD(aParamBox,{1,"Data Ref:"		,CtoD("//")							,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Produto de:"		,Space(TAMSX3("B1_COD")[1])			,"@!"	,"","SB1","",70,.F.})
AADD(aParamBox,{1,"Produto at้:"	,Space(TAMSX3("B1_COD")[1])			,"@!"	,"","SB1","",70,.F.})
AADD(aParamBox,{1,"Armaz้m de:"		,Space(TAMSX3("B2_LOCAL")[1])		,"@!"	,"","","",70,.F.})
AADD(aParamBox,{1,"Armaz้m at้:"	,Space(TAMSX3("B2_LOCAL")[1])		,"@!"	,"","","",70,.F.})

llRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return llRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldParam  บAutor  ณMicrosiga           บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para validar os parโmetros do relat๓rio    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldParam(aParam)

Local aArea 	:= GetArea()
Local cMsgErro  := "Campos obrigat๓rios nใo preenchidos"+CRLF+CRLF
Local cMsgAux	:= ""
Local lRet	 	:= .T.

If Empty(aParam[1])
	cMsgAux	+= " Data Ref: "+CRLF
EndIf

If Empty(aParam[3])
	cMsgAux	+= " Produto at้: "+CRLF
EndIf

If Empty(aParam[5])
	cMsgAux	+= " Armaz้m at้: "+CRLF
EndIf                   

If !Empty(cMsgAux)
	lRet	 := .F.
	cMsgErro := cMsgErro + cMsgAux
	Aviso("Valida็ใo de parโmetros",cMsgErro,{"Ok"},2)
EndIf

RestArea(aArea)
Return lRet