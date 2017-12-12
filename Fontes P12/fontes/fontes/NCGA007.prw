#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCGA007  บAutor  ณ 				     บ Data ณ  20/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_WMSINTERF_CONF_BAIXA e	  บฑฑ
ฑฑบ          ณ atualiza็ใo das informa็๕es de Data Saida e Hora Libera็ใo บฑฑ
ฑฑบ          ณ na tabela SZ1											  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGA007(lJob,cEmp,cFil)
Local cAlias		:= GetNextAlias()
Local clUsrBD		:= ""
Local clQuery		:= ""
Local clUsrBD		:= SuperGetMV("NCG_000019")

Default	lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(cEmp,cFil)
		
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		
		Return()
		
	EndIf
EndIF

clUsrBD	:= SuperGetMV("NCG_000019")

Conout("Iniciando rotina Retorno de Baixas - WMS")

//BUSCA NUMERO DO ROMANEIO COM BASE NOS REGISTROS PENDENTES NA PZ1
clQuery := "SELECT DOCUMENTO_ERP DOCERP, NUMERO_ROMANEIO NRROMAN
clQuery += " FROM "+clUsrBD+".VIW_DOC_SAIDA_ERP DOCSAIDA
clQuery += " WHERE DOCSAIDA.DOCUMENTO_ERP IN(SELECT PZ1_FILDES||PZ1_PVDEST CHVPVDEST
clQuery += " FROM "+RetSqlName("PZ1")
clQuery += " WHERE D_E_L_E_T_ = ' ' AND PZ1_FILIAL = '"+xFilial("PZ1")+"' 
clQuery += " AND PZ1_ROMAN = ' '
clQuery += " AND PZ1_DOCSF2 <> ' ')
clQuery += " AND NUMERO_ROMANEIO IS NOT NULL
clQuery += " AND COD_DEPOSITO = "+alltrim(str(VAL(cEmp)))+" AND COD_DEPOSITANTE = "+alltrim(str(VAL(xFilial("SF2"))))
clQuery += " ORDER BY 1

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

DBSelectArea("PZ1")
PZ1->(DBSetOrder(1))

DBSelectArea(cAlias)
(cAlias)->(DBGoTop())
While (cAlias)->(!EOF())
	nRecPZ1:= 0
	If U_M001TemPV(substr((cAlias)->DOCERP,1,2),substr((cAlias)->DOCERP,3,6),2,@nRecPZ1)
		PZ1->(DbGoTo(nRecPZ1))
		U_M001PZ1Grv("GRAVA_ROMANEIO",,,,,,,,,,,,,,,,,,alltrim(str((cAlias)->NRROMAN)))
	EndIf	
	(cAlias)->(DbSkip())
End

Return()
