User Function MA050TTS

//Faz a gravação do código WMS no cadastro de transportadoras

Local cQry:= ""
Local cAliasMT50	:= GetNextAlias()

If Empty(SA4->A4_YCODWMS)

	cQry := " SELECT MAX(A4_YCODWMS) PROXNUM FROM SA4010
	cQry += " WHERE D_E_L_E_T_ = ' '
	IIf(Select(cAliasMT50) > 0,(cAliasMT50)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasMT50  ,.F.,.T.)
	
	reclock("SA4",.F.)
	SA4->A4_YCODWMS := (cAliasMT50)->PROXNUM+1
	msunlock()
	
	(cAliasMT50)->(dbCloseArea())

EndIf


Return