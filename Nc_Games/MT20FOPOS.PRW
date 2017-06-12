User Function MT20FOPOS

Local nOpcA :=PARAMIXB[1]
Local cQry:= ""
Local cAliasMT20	:= GetNextAlias()

If nOpcA == 3
	
	cQry := " SELECT MAX(A2_YCODWMS) PROXNUM FROM SA2010
	cQry += " WHERE D_E_L_E_T_ = ' '
	IIf(Select(cAliasMT20) > 0,(cAliasMT20)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasMT20  ,.F.,.T.)
	
	reclock("SA2",.F.)
	SA2->A2_YCODWMS := (cAliasMT20)->PROXNUM+1
	msunlock()
	
	(cAliasMT20)->(dbCloseArea())
	
	
	
EndIf

Return
