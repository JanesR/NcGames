#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"

//Variavel estatica para chamada no programa SF2520E 
Static cNCGMVNFIS := ""

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMS520VLD  บAutor  ณMicrosiga           บ Data ณ  06/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ MS520VLD - Valida็ใo da exclusใo da NFS.                   บฑฑ
ฑฑบ          ณ Esse ponto de entrada ้ chamado para validar ou nใo a      บฑฑ
ฑฑบ          ณ exclusใo da nota na rotina MATA521  				           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MS520VLD

Local _aArea   := GetArea()
Local _aAreaZ3 := SD3->(GetArea())
Local lRet 		:= .F.
Local clFil 	:= cFilant
Local cFiliais 	:= SuperGetMV("NCG_000030",.F.,"03")
Local clDoc		:= SF2->F2_DOC
Local clSerie 	:= SF2->F2_SERIE
Local clClient	:= SF2->F2_CLIENTE
Local clLoja	:= SF2->F2_LOJA
Local cNumPed	:= Posicione("SD2",3,xFilial("SD2")+SF2->(F2_DOC+F2_SERIE),"D2_PEDIDO")
Local cCondPg	:= Posicione("SC5",1,xFilial("SC5")+cNumPed,"C5_CONDPAG")
Local cFmPgto	:= Posicione("SE4",1,xFilial("SE4")+cCondPg,"E4_FORMA")
Local clQry		:= ""
Local clQry2	:= ""
Local clQry3	:= ""
Local clQry4	:= ""
Local cAlias	:= GetNextAlias()
Local cAlias2	:= GetNextAlias()
Local cAlias3	:= GetNextAlias()
Local cAlias4	:= GetNextAlias()
Local llCntValid:= .F.
Local clChave	:= clFil+clDoc+clSerie+clClient+clLoja
Local clUsrBD	:= U_MyNewSX6(	"NCG_000019","","C","Usuแrio para acessar a base do WMS","","",.F. ) 
Local cCanalVen	:= SF2->F2_YCANAL

If cCanalVen == "999996" //Pedidos de assitencia tecnica
	cNCGMVNFIS	:= MVNOTAFIS
	MVNOTAFIS	:= padr("OS",tamsx3("E1_TIPO")[1])
EndIf 

//Variavel adicionada para considerar o Tipo CC para exclusใo do tํtulo referente ao cartใo de cr้dito
//Private cMVNFISNCG	:= MVNOTAFIS
If alltrim(cFmPgto) == "CC" .Or. AllTrim(cCondPg) == "618"
	cNCGMVNFIS	:= MVNOTAFIS
	MVNOTAFIS	:= padr("CC",tamsx3("E1_TIPO")[1])
EndIf 

//*****************************

dbSelectArea("SZ3")
dbSetOrder(1)
If dbSeek(xFilial("SZ3")+SF2->F2_DOC+SF2->F2_SERIE)
	_lRet := .F.
	Aviso("Atencao","A nota fiscal  "+SZ3->Z3_DOC+" nao podera ser excluida pois ja existe etiqueta no item "+SZ3->Z3_ITEM+".Caso necessite realizar o cancelamento da NF, entre em contato com a expedicao para realizar o cancelamento da mesma. ",{"Ok"}, 2 )
EndIf

SD2->(DBSetORder(3))
If SD2->( DBSeek(clFil+clDoc+clSerie+clClient+clLoja) )
	clPedido := SD2->D2_PEDIDO
EndIF

If clFil $ FormatIN(cFiliais,"|") .AND. !(EMPTY(clPedido))
	
	/********************************************************************************************
	| A NF Saida s๓ pode ser Excluํda se a mesma nใo estiver na tabela P0A ou se				|
	| ainda nใo foi exportada para o WMS, caso jแ tenha sido exportada 							|
	| deve possuir uma integra็ใo com a tabela TB_WMSINTERF_CANC_ENT_SAI						|
	********************************************************************************************/
	clQry 	:= " SELECT P0A_EXPORT, R_E_C_N_O_ FROM " + RetSqlName("P0A") + " P0A "
	clQry 	+= " WHERE P0A_CHAVE = '"+ ALLTRIM(clFil) +"'||'"+ ALLTRIM(clPedido) +"' "
	clQry 	+= " AND D_E_L_E_T_ = ' ' "
	clQry 	+= " ORDER BY R_E_C_N_O_ DESC "
	
	Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)
	
	If (cAlias)->(EOF())
		LRET := .T.
	Else
		If (cAlias)->P0A_EXPORT == '2'
			IF ALTERA
				LRET := .T.
			ElseIf !ALTERA .AND. !INCLUI //ษ EXCLUSรO
				//DELETE O REGISTRO CORRESPONDENTE DA TABELA P0A
				clQry2 := " SELECT R_E_C_N_O_ FROM " + RetSqlName("P0A") + " P0A "
				clQry2 += " WHERE P0A_CHAVE LIKE '%"+ ALLTRIM(clFil) +"'||'"+ALLTRIM(clPedido)+"%' "
				clQry2 += " AND D_E_L_E_T_ = ' ' "
				clQry2 += " ORDER BY R_E_C_N_O_ "
				
				Iif(Select(cAlias2) > 0,(cAlias2)->(dbCloseArea()),Nil)
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry2),cAlias2  ,.F.,.T.)
				
				DBSelectArea("P0A")
				
				While (cAlias2)->(!EOF())
					
					
					P0A->(DBGoTO((cAlias2)->R_E_C_N_O_))
					IF RecLock("P0A",.F.)
						P0A->(DBDelete())
						P0A->(MsUnlock())
					EndIF
					
					(cAlias2)->(DBSkip())
					
				EndDO
				
			EndIF
		Else
			llCntValid := .T.
		EndIF
	EndIF
	
	If llCntValid
		//VERIFICA SE O PEDIDO ESTA NO WMS NA TABELA TB_WMSINTERF_DOC_SAIDA
		clQry3 	:= " SELECT RNV_COD_CHAVE, STATUS AS S_T_A_T_U_S FROM "+clUsrBD+".TB_FRTINTERFNOTAS "
		clQry3	+= " WHERE RNV_COD_CHAVE = '"+clChave+"' "
		
		Iif(Select(cAlias3) > 0,(cAlias3)->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry3),cAlias3  ,.F.,.T.)
		
		If (cAlias3)->(!EOF())
			If (cAlias3)->S_T_A_T_U_S == 'ER'
				LRET := .T.
			Else
				//VERIFICA SE O PEDIDO POSSUI INTEGRAวรO DE EXCLUSรO NA TABELA TB_WMSINTERF_CANC_ENT_SAI
				clQry4	:= " SELECT CES_COD_CHAVE FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
				clQry4	+= " WHERE CES_COD_CHAVE = '"+alltrim(clFil+clPedido)+"' " //'"+alltrim(clChave)+"' "
				clQry4	+= " AND STATUS = 'NP' "
				
				Iif(Select(cAlias4) > 0,(cAlias4)->(dbCloseArea()),Nil)
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry4),cAlias4  ,.F.,.T.)
				
				If (cAlias4)->(!EOF())
					alCampos1 := {}
					aadd(alCampos1,"STATUS")
					aadd(alCampos1,"DESC_ERRO")
					alReg1 := {}
					aadd(alReg1,"PA")
					aadd(alReg1," ")
					
					clTabWMS := "TB_WMSINTERF_CANC_ENT_SAI"
					
					alCmpChave := {}
					aadd(alCmpChave,"CES_COD_CHAVE")
					
					alValChave := {}
					aadd(alValChave,ALLTRIM((cAlias4)->CES_COD_CHAVE))
					
					clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
					
					If !Empty(clQuery)
						If TcSqlExec(clQuery) >= 0
							TcSqlExec("COMMIT")
							LRET := .T.
						Else
							LRET := .F.
							Aviso("ERRO",TCSQLError() + " - " + clQuery, {"Ok"})
						EndIf
					EndIf
				Else
					MSgInfo("Documento de Saํda nใo pode ser Excluํdo. Solicite ao setor da Logํstica para a exclusใo no WMS ","ATENวรO")
					LRET := .F.
				EndIF
			EndIF
		Else
			LRET := .T.
		EndIF
	EndIF
EndIF

If LRET
	cQry	:= " DELETE FROM "+RetSqlName("P0A")
	cQry	+= " WHERE D_E_L_E_T_ = ' ' AND P0A_FILIAL = '"+xFilial("P0A")+"'
	cQry	+= " AND P0A_CHAVE LIKE '"+clChave+"%'
	cQry	+= " AND P0A_EXPORT = '2'
	cQry	+= " AND P0A_TABELA IN('SD2','SF2')
	If TcSqlExec(cQry) >= 0
		TcSqlExec("COMMIT")
		LRET := .T.
	Else
		LRET := .F.
		Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
	EndIf

	cQry	:= " DELETE FROM WMS.TB_FRTINTERFNOTAS WHERE RNV_TIPOMOV_NOTAS = 'S' AND RNV_COD_CHAVE = '"+ALLTRIM(clChave)+"'
	If TcSqlExec(cQry) >= 0
		TcSqlExec("COMMIT")
		LRET := .T.
	Else
		LRET := .F.
		Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
	EndIf

	cQry	:= " DELETE FROM WMS.TB_FRTINTERFITENSNOTAS
	cQry	+= " WHERE RNVI_CNPJ_EMBARCADOR = '"+ALLTRIM(SM0->M0_CGC)+"'
	cQry	+= " AND RNVI_NUM_NOTA_FISCAL = "+alltrim(str(val(clDoc)))
	cQry	+= " AND RNVI_SERIE_NOTA_FISCAL = '"+ALLTRIM(clSerie)+"'
	If TcSqlExec(cQry) >= 0
		TcSqlExec("COMMIT")
		LRET := .T.
	Else
		LRET := .F.
		Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
	EndIf

EndIf

If !(clFil $ FormatIN(cFiliais,"|"))
	LRET := .T.
EndIf

//Verifica se o documento existe na conferencia cega (Web Manager)
If lRet
	lRet := u_NCVlExCC(SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_TIPO, SF2->F2_CLIENTE, SF2->F2_LOJA)
EndIf

RestArea(_aAreaZ3)
RestArea(_aArea)
Return(lRet)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณGetMS520	บAutor  ณ        	 		 บ Data ณ  10/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Retorna os dados dos itens alterados antes da grava็ใo	  บฑฑ
ฑฑบ          ณ                                            				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetMS520()

Local cRet := cNCGMVNFIS

Return cRet