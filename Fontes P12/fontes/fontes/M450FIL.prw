#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M450FIL  ºAutor  ³Microsiga  	        º Data ³  09/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para filtro do Browse da rotina			  º±±
±±º          ³analise de pedido de cliente MATA450	                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M450FIL()

	Local aArea 	:= GetArea()
	Local cRetFil	:= ""
	Local cFilPed	:= ""
	Local lPvSite	:= IsInCallStack("U_ECAnPed")
	Local lPedidosFat:=.F.                     
	Local aParamBox	:={}
	Local aRet		:={}
	Local nOpcao
	Local aOpcoes	:={"Todos","Somente Pedidos de e-commerce Faturado"}
	Local aMvs		:={mv_par01}

	aAdd(aParamBox,{2,"Selecione Filtro",1,aOpcoes,110,"",.T.})

	If !lPvSite .And. ParamBox(aParamBox,"Parametros",@aRet,,,,,,,,.F.) 

		If ValType(aRet[1])=="N"
			nOpcao:=aRet[1]
		Else
			nOpcao:= Ascan(aOpcoes, aRet[1] )
		EndIf

		lPedidosFat:=(nOpcao==2)



	EndIf	
	mv_par01:=aMvs[1]


	//Busca os pedidos a serem filtrados                          
	cFilPed := GetFilPed(lPedidosFat)
	If lPvSite	.Or. lPedidosFat
		cRetFil	:= " ( C9_PEDIDO $ '"+cFilPed+"' ) " 	
	Else                               
		If !Empty(cFilPed)
			cRetFil	:= " !( C9_PEDIDO $ '"+cFilPed+"' ) " 	
		EndIf
	EndIf

	RestArea(aArea)
Return  cRetFil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetPedFil  ºAutor  ³Microsiga	        º Data ³  09/04/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para filtro do Browse da rotina			 	  º±±
±±º          ³analise de pedido de cliente MATA450	                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetFilPed(lPedidosFat)

	Local aArea 	:= GetArea()
	Local cRet		:= ""
	Local cQuery   := ""
	Local cArqTmp	:= GetNextAlias()


	cQuery   := " SELECT C9_PEDIDO, ZC5_NUMPV FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

	cQuery   += "  INNER JOIN "+RetSqlName("SC9")+" SC9 "+CRLF
	cQuery   += "    ON SC9.C9_FILIAL = '"+xFilial("SC9")+"' "+CRLF
	cQuery   += "    AND SC9.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += "    AND SC9.C9_PEDIDO = ZC5.ZC5_NUMPV "+CRLF
	cQuery   += "    AND SC9.C9_BLCRED != ' ' "+CRLF

	cQuery   += "   WHERE ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery   += "   AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += "   AND ZC5.ZC5_DOCDEV = ' ' "+CRLF
	cQuery   += "   AND ZC5_NOTA = ' ' "+CRLF
	cQuery   += "   AND ZC5_ESTORN != 'S' "+CRLF
	cQuery   += "   AND ZC5_STATUS != '90' "+CRLF

	If lPedidosFat
		cQuery   += "   AND ZC5.ZC5_COND = 'FAT' "+CRLF
	EndIf


	dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

	While (cArqTmp)->(!Eof())

		cRet += (cArqTmp)->C9_PEDIDO+"|"   

		(cArqTmp)->(DbSkip())
	EndDo

	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return cRet