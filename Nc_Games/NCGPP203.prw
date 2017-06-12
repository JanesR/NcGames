#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FCHCMGBR  �Autor  �Microsiga           � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para efetuar o fechamento do CMG BR        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                 
                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FCHCMGBR  �Autor  �Microsiga           � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para efetuar o fechamento do CMG BR        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �PergRel	�Autor  �Microsiga		     � Data �  17/02/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     � Perguntas a serem utilizadas no filtro do relatorio        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Ap		                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergRel(aParams)

Local aParamBox := {}
Local llRet      := .T.

AADD(aParamBox,{1,"Data Ref:"		,CtoD("//")							,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Produto de:"		,Space(TAMSX3("B1_COD")[1])			,"@!"	,"","SB1","",70,.F.})
AADD(aParamBox,{1,"Produto at�:"	,Space(TAMSX3("B1_COD")[1])			,"@!"	,"","SB1","",70,.F.})
AADD(aParamBox,{1,"Armaz�m de:"		,Space(TAMSX3("B2_LOCAL")[1])		,"@!"	,"","","",70,.F.})
AADD(aParamBox,{1,"Armaz�m at�:"	,Space(TAMSX3("B2_LOCAL")[1])		,"@!"	,"","","",70,.F.})

llRet := ParamBox(aParamBox, "Par�metros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return llRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldParam  �Autor  �Microsiga           � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para validar os par�metros do relat�rio    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldParam(aParam)

Local aArea 	:= GetArea()
Local cMsgErro  := "Campos obrigat�rios n�o preenchidos"+CRLF+CRLF
Local cMsgAux	:= ""
Local lRet	 	:= .T.

If Empty(aParam[1])
	cMsgAux	+= " Data Ref: "+CRLF
EndIf

If Empty(aParam[3])
	cMsgAux	+= " Produto at�: "+CRLF
EndIf

If Empty(aParam[5])
	cMsgAux	+= " Armaz�m at�: "+CRLF
EndIf                   

If !Empty(cMsgAux)
	lRet	 := .F.
	cMsgErro := cMsgErro + cMsgAux
	Aviso("Valida��o de par�metros",cMsgErro,{"Ok"},2)
EndIf

RestArea(aArea)
Return lRet