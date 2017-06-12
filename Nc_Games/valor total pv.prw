User Function VTOTPV(cNUMPV)
ASC5 := GETAREA()
nRET := 0                            

cQry:="SELECT SUM(C6_VALOR) NTOTPV FROM "+RetSqlName("SC6")+" 
cQry+="		WHERE D_E_L_E_T_ <> '*' "
cQry+="		AND C6_NUM = '" + cNUMPV + "'   "


DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )

TcSetField( "Pega", "NTOTPV", "N", 17, 2 )

nRET := Pega->NTOTPV

Pega->(DbCloseArea())
             

RESTAREA(ASC5)
Return nRET