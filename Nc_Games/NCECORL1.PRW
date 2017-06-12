#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"


User Function NcEcoRL1()

Local cPerg 	:= "ZC5PERG1  "
Local cEmail 	:= ""

Local aRel		:= {}

aRet 	:= ZC5Param()

If !Empty(aRet)
	cEmail := Lower(Alltrim(aRet[6]))
	
	Aadd(aRel,aRet[2]) //Est Insuficiente B2C
	Aadd(aRel,aRet[3]) //Est Insuficiente B2C Itens
	Aadd(aRel,aRet[4]) //Est Insuficiente B2B
	Aadd(aRel,aRet[5]) //Est Insuficiente B2B Itens
	
	Processa( {|| EcoRl1(cEmail,aRel)},"Aguarde....","Imprimindo relatÛrios selecionados" )	
	
EndIf

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ZC5Param
// Fonte para a geraÁ„o dos arquivos de importaÁ„o.
//
// @author    Lucas Felipe
// @version   1.xx
// @since     30/08/2016
/*/
//------------------------------------------------------------------------------------------
Static Function ZC5Param()

Local aArea 	:= GetArea()
Local aParam 	:= {}
Local aPergs 	:= {}
Local lRet   	:= .T.

Local lParam1 	:= .F.
Local lParam2 	:= .F.
Local lParam3 	:= .F.
Local lParam4 	:= .F.


aAdd( aPergs ,{9,"Marcar as opÁıes a serem enviadas por email.",200,10,.F.})

aAdd( aPergs ,{5,"Est Insuficiente B2C" 		,lParam1 ,70 ,"" ,.F.})
aAdd( aPergs ,{5,"Est Insu B2C por itens"		,lParam2 ,70 ,"" ,.F.})
aAdd( aPergs ,{5,"Est Insuficiente B2B"  		,lParam3 ,70 ,"" ,.F.})
aAdd( aPergs ,{5,"Est Insu B2B por itens"  		,lParam4 ,70 ,"" ,.F.})

aAdd(aPergs,{1,"Digite Email",Space(100),"","","","",100,.F.	})
aAdd(aPergs,{9,"",200,10,.T.})


ParamBox(aPergs, "Par‚metros", aParam, , /*alButtons*/, .T.,300,600,/*oDlgWizard*/,/*clLoad*/, .T., .T.)

RestArea(aArea)


Return aParam


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥NCECORL1  ∫Autor  ≥Microsiga           ∫ Data ≥  08/30/16   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥                                                            ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                        ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function EcoRl1(cPara,aRel)

Local cAssunto  := "Email Est_Insuficiente_"+DtoS(MsDate())
Local cBody     := "Email gerado automaticamente"
Local cAttach   := ""
Local aAttach   := {}

Local cQrySql 	:= ""
Local cAreaQry

Local nTotLinhas:= 0
Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Local cNewPatch	:= "C:\relatorios"
Local cArq 		:= ""
Local cExtExcel	:= ".CSV"
Local nArq
Local nI
Local nInd
Local cCabec	:= "" 

Local cArmVtex	:= Alltrim(U_MyNewSX6("VT_000005","51","C","Armazem de Venda Protheus Vtex","","",.F. ))  
Local cArmCia	:= Alltrim(U_MyNewSX6("MV_CIAESTO","01","C","Armazem de Venda Protheus Ciashop","","",.F. )) 

Default cPara := "" 

If !Empty(aRel)
	For nInd := 1 to Len(aRel)
		If aRel[nInd] .and. nInd==1 //Est Insuficiente B2C
			
			cArq 		:= "Estoque_insuficiente_B2C"+DtoS(MsDate())
			cCabec	 	:= "PV_VTEX;DT_VTEX;NUM_PV;PRE_VENDA;SKU;PRODUTO;DESCRICAO;QTD_PEDIDO;QTD_RES_PV;EST_51_DISP;EST_01_DISP"
			cQrySql 	:= ""
			cAreaQry	:= GetNextAlias()
			
			nArq  := FCreate(cPathArq + cArq + cExtExcel)
			
			FWrite(nArq, cCabec +CRLF)
				
			cQrySql += "SELECT ZC6_PVVTEX AS PVVTEX "+CRLF
			cQrySql += "		,ZC5.ZC5_NUMPV AS NumPed "+CRLF
			cQrySql += "		,ZC5.ZC5_DTVTEX AS DTVTEX "+CRLF
			cQrySql += "		,ZC5.ZC5_PREVEN AS PRE_VENDA "+CRLF
			cQrySql += "		,ZC6.ZC6_IDPROD AS SKU "+CRLF
			cQrySql += "	   	,ZC6.ZC6_PRODUT AS PRODUTO "+CRLF
			cQrySql += "	   	,SB1.B1_XDESC AS DESCRICAO "+CRLF
			cQrySql += "	   	,ZC6_QTDVEN AS QTD_PEDIDO "+CRLF
			cQrySql += "	   	,ZC6_QTDRES AS QTD_RES_PV "+CRLF
			cQrySql += "	   	,ZC6_LOCAL AS lOCAL_PV "+CRLF
			cQrySql += "	   	,NVL((SB2.B2_QATU-SB2.B2_RESERVA),0) AS EST_51_DISP "+CRLF
			cQrySql += "	   	,NVL((B2.B2_QATU - B2.B2_RESERVA),0) AS EST_01_DISP "+CRLF
			cQrySql += "FROM "+ RetSqlName("ZC6") +" ZC6 "+CRLF
			cQrySql += "	INNER JOIN "+ RetSqlName("SB1") +" SB1 "+CRLF
			cQrySql += "		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += "		AND SB1.B1_FILIAL = '"+ xFilial("SB1") +"' "+CRLF
			cQrySql += "		AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += "		LEFT OUTER JOIN "+ RetSqlName("SB2") +" B2 "+CRLF
			cQrySql += "			ON B2.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += "			AND B2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += "			AND B2.B2_LOCAL = '"+cArmCia+"' "+CRLF
			cQrySql += "			AND B2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += "		LEFT OUTER JOIN "+ RetSqlName("SB2") +" SB2  "+CRLF
			cQrySql += "			ON SB2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += "			AND SB2.B2_LOCAL = '"+cArmVtex+"' "+CRLF
			cQrySql += "			AND SB2.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += "			AND SB2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += "		LEFT OUTER JOIN "+ RetSqlName("ZC5") +" ZC5 "+CRLF
			cQrySql += "		ON ZC5.ZC5_FILIAL = ZC6.ZC6_FILIAL "+CRLF
			cQrySql += "		AND ZC5.ZC5_PVVTEX = ZC6.ZC6_PVVTEX "+CRLF
			cQrySql += "WHERE ZC6.ZC6_FILIAL = '"+ xFilial("ZC6") +"' "+CRLF
			cQrySql += "AND ZC6.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += "AND ZC6.ZC6_PVVTEX IN "+CRLF
			cQrySql += "					(SELECT ZC5.ZC5_PVVTEX FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
			cQrySql += "						WHERE ZC5_FILIAL = '"+ xFilial("ZC5") +"'  "+CRLF
			cQrySql += "						AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += "						AND ZC5.ZC5_CODINT = '003' "+CRLF
			cQrySql += "						AND ZC5.ZC5_STATUS IN ('4','10') "+CRLF
			cQrySql += "						AND ZC5.ZC5_NUMPV <> ' ' "+CRLF
			cQrySql += "						AND ZC5.ZC5_PLATAF NOT IN ('01') ) "+CRLF
			cQrySql += "ORDER BY ZC6.ZC6_PVVTEX "+CRLF
			
			cQrySql := ChangeQuery(cQrySql)
			
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQrySql), cAreaQry, .T., .F.)
			
			While !(cAreaQry)->(EOF())
				++ nTotLinhas
				
				cTexto := ""
				cTexto += Alltrim((cAreaQry)->PVVTEX)+";"
				cTexto += Alltrim(DtoC(StoD((cAreaQry)->DTVTEX)))+";"
				cTexto += Alltrim((cAreaQry)->NumPed)+";"
				cTexto += Alltrim((cAreaQry)->PRE_VENDA)+";"
				cTexto += Alltrim((cAreaQry)->SKU)+";"
				cTexto += Alltrim((cAreaQry)->PRODUTO)+";"
				cTexto += Alltrim((cAreaQry)->DESCRICAO)+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_PEDIDO))+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_RES_PV))+";"
				cTexto += Alltrim((cAreaQry)->lOCAL_PV)+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_51_DISP))+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_01_DISP))
				
				FWrite(nArq, cTexto +CRLF)
				
				(cAreaQry)->(DbSkip())
				
			EndDo
			
			FClose(nArq)
			
			cAttach := cPathArq+cArq+cExtExcel
			
			aAdd(aAttach,cAttach)
			
			(cAreaQry)->(DbCloseArea())
			
		ElseIf aRel[nInd] .and. nInd==2 //Est Insuficiente B2C Itens
			
			cArq	 	:= "EST_INS_ITENS_B2C_"+DtoS(MsDate())
			cCabec		:= "SKU;PRODUTO;DESCRICAO;QTD_PEDIDO;QTD_RES_PV;EST_51_DISP;EST_01_DISP"
			cQrySql 	:= ""
			cAreaQry	:= GetNextAlias()
			
			nArq  := FCreate(cPathArq + cArq + cExtExcel)
						
			FWrite(nArq, cCabec +CRLF) 
			 
			cQrySql += " SELECT DISTINCT ZC6_PRODUT AS PRODUTO "+CRLF
			cQrySql += "		,ZC6.ZC6_IDPROD AS SKU "+CRLF
			cQrySql += " 	   ,SB1.B1_XDESC AS DESCRICAO "+CRLF
			cQrySql += " 	   ,Sum(ZC6_QTDVEN) AS QTD_PEDIDO "+CRLF
			cQrySql += " 	   ,Sum(ZC6_QTDRES) AS QTD_RES_PV "+CRLF
			cQrySql += " 	   ,ZC6_LOCAL AS lOCAL_PV "+CRLF
			cQrySql += " 	   ,NVL((SB2.B2_QATU-SB2.B2_RESERVA),0) AS EST_51_DISP "+CRLF
			cQrySql += " 	   ,NVL((B2.B2_QATU - B2.B2_RESERVA),0) AS EST_01_DISP "+CRLF
			cQrySql += " FROM "+ RetSqlName("ZC6") +" ZC6 "+CRLF
			cQrySql += " 	INNER JOIN "+ RetSqlName("SB1") +" SB1 "+CRLF
			cQrySql += " 		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += " 		AND SB1.B1_FILIAL = '"+ xFilial("SB1") +"' "+CRLF
			cQrySql += " 		AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += " 		LEFT OUTER JOIN "+ RetSqlName("SB2") +" B2 "+CRLF
			cQrySql += " 			ON B2.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += " 			AND B2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += " 			AND B2.B2_LOCAL = '"+cArmCia+"' "+CRLF
			cQrySql += " 			AND B2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += " 		LEFT OUTER JOIN "+ RetSqlName("SB2") +" SB2 "+CRLF
			cQrySql += " 			ON SB2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += " 			AND SB2.B2_LOCAL = '"+cArmVtex+"' "+CRLF
			cQrySql += " 			AND SB2.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += " 			AND SB2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += " WHERE ZC6.ZC6_FILIAL = '"+ xFilial("ZC6") +"' "+CRLF
			cQrySql += " AND ZC6.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += " AND ZC6.ZC6_PVVTEX IN "+CRLF
			cQrySql += " 					(SELECT ZC5.ZC5_PVVTEX FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
			cQrySql += " 						WHERE ZC5_FILIAL = '"+ xFilial("ZC5") +"' "+CRLF
			cQrySql += " 						AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += " 						AND ZC5.ZC5_CODINT = '003' "+CRLF
			cQrySql += " 						AND ZC5.ZC5_STATUS IN ('4','10') "+CRLF
			cQrySql += " 						AND ZC5.ZC5_NUMPV <> ' ' "+CRLF
			cQrySql += " 						AND ZC5.ZC5_PLATAF NOT IN ('01')) "+CRLF
			cQrySql += " AND ZC6.ZC6_QTDRES = 0 "+CRLF
			cQrySql += " GROUP BY ZC6.ZC6_IDPROD, ZC6.ZC6_PRODUT, SB1.B1_XDESC, ZC6_LOCAL, SB2.B2_QATU-SB2.B2_RESERVA, B2.B2_QATU - B2.B2_RESERVA "+CRLF
				
			cQrySql := ChangeQuery(cQrySql)
			
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQrySql), cAreaQry, .T., .F.)
			
			While !(cAreaQry)->(EOF())
				++ nTotLinhas
				
				cTexto := ""
				cTexto += Alltrim((cAreaQry)->SKU)+";"
				cTexto += Alltrim((cAreaQry)->PRODUTO)+";"
				cTexto += Alltrim((cAreaQry)->DESCRICAO)+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_PEDIDO))+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_RES_PV))+";"
				cTexto += Alltrim((cAreaQry)->lOCAL_PV)+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_51_DISP))+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_01_DISP))+";"
				
				FWrite(nArq, cTexto +CRLF)
				
				(cAreaQry)->(DbSkip())
				
			EndDo
			
			FClose(nArq)
			cAttach := cPathArq+cArq+cExtExcel
			
			aAdd(aAttach,cAttach)
			
			(cAreaQry)->(DbCloseArea())
			
		ElseIf aRel[nInd] .and. nInd==3 //Est Insuficiente B2B
			
			cArq 		:= "Estoque_insuficiente_B2B"+DtoS(MsDate())
			cCabec	 	:= "PV_CIA;NUM_PV;PRE_VENDA;PRODUTO;DESCRICAO;QTD_PEDIDO;QTD_RES_PV;EST_51_DISP;EST_01_DISP"
			cQrySql 	:= ""
			cAreaQry	:= GetNextAlias()
			
			nArq  := FCreate(cPathArq + cArq + cExtExcel) 
			
			FWrite(nArq, cCabec +CRLF) 
			
			cQrySql += "SELECT ZC6.ZC6_NUM AS PVCIA "+CRLF
			cQrySql += "		,ZC5.ZC5_NUMPV AS NumPed "+CRLF
			cQrySql += "		,ZC5.ZC5_PREVEN AS PRE_VENDA "+CRLF
			cQrySql += "	   	,ZC6.ZC6_PRODUT AS PRODUTO "+CRLF
			cQrySql += "	   	,SB1.B1_XDESC AS DESCRICAO "+CRLF
			cQrySql += "	   	,ZC6_QTDVEN AS QTD_PEDIDO "+CRLF
			cQrySql += "	   	,ZC6_QTDRES AS QTD_RES_PV "+CRLF
			cQrySql += "	   	,ZC6_LOCAL AS lOCAL_PV "+CRLF
			cQrySql += "	   	,NVL((SB2.B2_QATU-SB2.B2_RESERVA),0) AS EST_51_DISP "+CRLF
			cQrySql += "	   	,NVL((B2.B2_QATU - B2.B2_RESERVA),0) AS EST_01_DISP "+CRLF
			cQrySql += "FROM "+ RetSqlName("ZC6") +" ZC6 "+CRLF
			cQrySql += "	INNER JOIN "+ RetSqlName("SB1") +" SB1 "+CRLF
			cQrySql += "		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += "		AND SB1.B1_FILIAL = '"+ xFilial("SB1") +"' "+CRLF
			cQrySql += "		AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += "		LEFT OUTER JOIN "+ RetSqlName("SB2") +" B2 "+CRLF
			cQrySql += "			ON B2.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += "			AND B2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += "			AND B2.B2_LOCAL = '"+cArmCia+"' "+CRLF
			cQrySql += "			AND B2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += "		LEFT OUTER JOIN "+ RetSqlName("SB2") +" SB2  "+CRLF
			cQrySql += "			ON SB2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += "			AND SB2.B2_LOCAL = '"+cArmVtex+"' "+CRLF
			cQrySql += "			AND SB2.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += "			AND SB2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += "		LEFT OUTER JOIN "+ RetSqlName("ZC5") +" ZC5 "+CRLF
			cQrySql += "			ON ZC5.ZC5_FILIAL = ZC6.ZC6_FILIAL "+CRLF
			cQrySql += "			AND ZC5.ZC5_NUM = ZC6.ZC6_NUM "+CRLF
			cQrySql += "			AND ZC5.ZC5_STATUS IN ('4','10') "+CRLF
			cQrySql += "WHERE ZC6.ZC6_FILIAL = '"+ xFilial("ZC6") +"' "+CRLF
			cQrySql += "AND ZC6.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += "AND ZC6.ZC6_NUM IN "+CRLF
			cQrySql += "					(SELECT ZC5.ZC5_NUM FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
			cQrySql += "						WHERE ZC5_FILIAL = '"+ xFilial("ZC5") +"'  "+CRLF
			cQrySql += "						AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += "						AND ZC5.ZC5_CODINT = '003' "+CRLF
			cQrySql += "						AND ZC5.ZC5_STATUS IN ('4','10') "+CRLF
			cQrySql += "						AND ZC5.ZC5_NUMPV <> ' ' "+CRLF
			cQrySql += "						AND ZC5.ZC5_PLATAF IN ('01') ) "+CRLF
			cQrySql += "ORDER BY ZC6.ZC6_NUM "+CRLF
			
			cQrySql := ChangeQuery(cQrySql)
			
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQrySql), cAreaQry, .T., .F.)
			
			While !(cAreaQry)->(EOF())
				++ nTotLinhas
				
				cTexto := ""
				cTexto += Alltrim((cAreaQry)->PVCIA)+";"
				cTexto += Alltrim((cAreaQry)->NumPed)+";"
				cTexto += Alltrim((cAreaQry)->PRE_VENDA)+";"
				cTexto += Alltrim((cAreaQry)->PRODUTO)+";"
				cTexto += Alltrim((cAreaQry)->DESCRICAO)+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_PEDIDO))+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_RES_PV))+";"
				cTexto += Alltrim((cAreaQry)->lOCAL_PV)+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_51_DISP))+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_01_DISP))+";"
				
				FWrite(nArq, cTexto +CRLF)
				
				(cAreaQry)->(DbSkip())
				
			EndDo
			
			FClose(nArq)
			cAttach := cPathArq+cArq+cExtExcel
			
			aAdd(aAttach,cAttach)
			
			(cAreaQry)->(DbCloseArea())
			
		ElseIf aRel[nInd] .and. nInd==4//Est Insuficiente B2B Itens
			
			cArq	 	:= "EST_INS_ITENS_B2B_"+DtoS(MsDate())
			cCabec		:= "PRODUTO;DESCRICAO;QTD_PEDIDO;QTD_RES_PV;EST_51_DISP;EST_01_DISP"
			cQrySql 	:= ""
			cAreaQry	:= GetNextAlias()
			
			nArq  := FCreate(cPathArq + cArq + cExtExcel)
						
			FWrite(nArq, cCabec +CRLF) 
			 
			cQrySql += " SELECT DISTINCT ZC6_PRODUT AS PRODUTO "+CRLF
			cQrySql += " 	   ,SB1.B1_XDESC AS DESCRICAO "+CRLF
			cQrySql += " 	   ,Sum(ZC6_QTDVEN) AS QTD_PEDIDO "+CRLF
			cQrySql += " 	   ,Sum(ZC6_QTDRES) AS QTD_RES_PV "+CRLF
			cQrySql += " 	   ,ZC6_LOCAL AS lOCAL_PV "+CRLF
			cQrySql += " 	   ,NVL((SB2.B2_QATU-SB2.B2_RESERVA),0) AS EST_51_DISP "+CRLF
			cQrySql += " 	   ,NVL((B2.B2_QATU - B2.B2_RESERVA),0) AS EST_01_DISP "+CRLF
			cQrySql += " FROM "+ RetSqlName("ZC6") +" ZC6 "+CRLF
			cQrySql += " 	INNER JOIN "+ RetSqlName("SB1") +" SB1 "+CRLF
			cQrySql += " 		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += " 		AND SB1.B1_FILIAL = '"+ xFilial("SB1") +"' "+CRLF
			cQrySql += " 		AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += " 		LEFT OUTER JOIN "+ RetSqlName("SB2") +" B2 "+CRLF
			cQrySql += " 			ON B2.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += " 			AND B2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += " 			AND B2.B2_LOCAL = '"+cArmCia+"' "+CRLF
			cQrySql += " 			AND B2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += " 		LEFT OUTER JOIN "+ RetSqlName("SB2") +" SB2 "+CRLF
			cQrySql += " 			ON SB2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
			cQrySql += " 			AND SB2.B2_LOCAL = '"+cArmVtex+"' "+CRLF
			cQrySql += " 			AND SB2.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += " 			AND SB2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
			cQrySql += " WHERE ZC6.ZC6_FILIAL = '"+ xFilial("ZC6") +"' "+CRLF
			cQrySql += " AND ZC6.D_E_L_E_T_ =' ' "+CRLF
			cQrySql += " AND ZC6.ZC6_PVVTEX IN "+CRLF
			cQrySql += " 					(SELECT ZC5.ZC5_PVVTEX FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
			cQrySql += " 						WHERE ZC5_FILIAL = '"+ xFilial("ZC5") +"' "+CRLF
			cQrySql += " 						AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
			cQrySql += " 						AND ZC5.ZC5_CODINT = '003' "+CRLF
			cQrySql += " 						AND ZC5.ZC5_STATUS IN ('4','10') "+CRLF
			cQrySql += " 						AND ZC5.ZC5_NUMPV <> ' ' "+CRLF
			cQrySql += " 						AND ZC5.ZC5_PLATAF IN ('01')) "+CRLF
			cQrySql += " AND ZC6.ZC6_QTDRES = 0 "+CRLF
			cQrySql += " GROUP BY ZC6.ZC6_PRODUT, SB1.B1_XDESC, ZC6_LOCAL, SB2.B2_QATU-SB2.B2_RESERVA, B2.B2_QATU - B2.B2_RESERVA "+CRLF
				
			cQrySql := ChangeQuery(cQrySql)
			
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQrySql), cAreaQry, .T., .F.)
			
			While !(cAreaQry)->(EOF())
				++ nTotLinhas
				
				cTexto := ""
				cTexto += Alltrim((cAreaQry)->PRODUTO)+";"
				cTexto += Alltrim((cAreaQry)->DESCRICAO)+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_PEDIDO))+";"
				cTexto += Alltrim(Str((cAreaQry)->QTD_RES_PV))+";"
				cTexto += Alltrim((cAreaQry)->lOCAL_PV)+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_51_DISP))+";"
				cTexto += Alltrim(Str((cAreaQry)->EST_01_DISP))+";"
				
				FWrite(nArq, cTexto +CRLF)
				
				(cAreaQry)->(DbSkip())
				
			EndDo
			
			FClose(nArq)
			cAttach := cPathArq+cArq+cExtExcel
			
			aAdd(aAttach,cAttach)
			
			(cAreaQry)->(DbCloseArea())
			
		EndIf
		
	Next
EndIf


If !Empty(cPara)
	MsgAlert("… possivel receber os relatÛrios via email ou gerar arquivos","NCECOMRL1")
	If MsgYesNo("Deseja receber via email?","NCECOMRL1-1")
		Vt09Send(,cPara,cAssunto,cBody,aAttach)
	Else
		MakeDir(cNewPatch)
		For nI:=1 to Len(aAttach)
			If CpyS2T(aAttach[nI],cNewPatch, .f.)
				MsgAlert("RelatÛrio salvo em "+cNewPatch)
				Ferase(aAttach[nI])
			EndIf
		Next
	EndIf
Else
	MakeDir(cNewPatch)
	For nI:=1 to Len(aAttach)
			If CpyS2T(aAttach[nI],cNewPatch, .f.)
			MsgAlert("RelatÛrio salvo em "+cNewPatch)
			Ferase(aAttach[nI])
		EndIf
	Next
EndIF

For nI:=1 to Len(aAttach)
	Ferase(aAttach[nI])
Next

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Vt09Send
// FunÁ„o responsavel pelo envio de relatÛrios por email.
//
// @author    Lucas Felipe
// @version   1.xx
// @since     14/12/2015
/*/
//------------------------------------------------------------------------------------------
Static Function Vt09Send(cFrom,cPara,cAssunto,cBody,aAttach)

Local cUser 	:= GetNewPar("MV_RELACNT","")
Local cPass 	:= GetNewPar("MV_RELAPSW","")
Local cSendSrv 	:= GetNewPar("MV_RELSERV","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Local nSmtpPort := GetNewPar("MV_GCPPORT","")

Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)
Local nPopPort

Local xRet
Local oServer, oMessage

Local cFrom1 	:= "Workflow@ncgames.com.br"
Local nI

Default cPara 	:= "lfelipe@ncgames.com.br"
Default cAssunto:= ""
Default cBody 	:= ""

If At(":",cSendSrv) > 0
	cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
EndIf

cFrom := IIf(Empty(cFrom),cFrom1,cFrom)

oServer := TMailManager():New()
oServer:SetUseSSL( lSSL )
oServer:SetUseTLS( lTLS )

oServer:Init( "", cSendSrv, cUser, cPass, /*nPopPort*/, nSmtpPort )

// estabilish the connection with the SMTP server
xRet := oServer:SMTPConnect()
if xRet <> 0
	cMsg := "Could not connect on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	return
endif

// authenticate on the SMTP server (if needed)
xRet := oServer:SmtpAuth( cUser, cPass )
if xRet <> 0
	cMsg := "Could not authenticate on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	oServer:SMTPDisconnect()
	return
endif

oMessage := TMailMessage():New()
oMessage:Clear()

//oMessage:cDate := cValToChar( Date() )
oMessage:cFrom		:= cFrom
oMessage:cTo		:= cPara
oMessage:cSubject	:= cAssunto
oMessage:cBody		:= cBody
If !Empty(aAttach)
	For nI:=1 to Len(aAttach)
		oMessage:AttachFile( aAttach[nI] ) // Adiciona um anexo.
	Next
EndIf

xRet := oMessage:Send( oServer )
if xRet <> 0
	cMsg := "Could not send message: " + oServer:GetErrorString( xRet )
	conout( cMsg )
endif

xRet := oServer:SMTPDisconnect()
if xRet <> 0
	cMsg := "Could not disconnect from SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
endif

return