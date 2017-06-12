#include 'protheus.ch'

/*/{Protheus.doc} TrocaTipoEstoqueReprocessa
(long_description)
@author fbborges
@since 06/09/2016
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
class TrocaTipoEstoqueReprocessa 
	Data cFil
	Data cDepto
	Data cDeptante
	Data cQuery
	Data cTabWms
	Data cAliasNovo
	Data cDescErro
	Data nCont
	Data B2
	Data nSaldo51
	Data nSaldo01
	
	method new() constructor 
	method consultaErros() 
	method comparaEGravaInterf()
	method insereNovaInterface()
	method deletaInterfaceAntig()

endclass

/*/{Protheus.doc} new
Metodo construtor
@author fbborges
@since 06/09/2016 
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
method new() class TrocaTipoEstoqueReprocessa

		Self:cTabWms 	:= "WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE"
		Self:cDepto		:= "1"
		Self:cDeptante	:= "3"
		Self:cDescErro  := "ERRO:HELP: MA240NEGAT Não existe quantidade suficiente em estoque para atender esta requisição."
		Self:B2			:= "SB2"
		Self:nSaldo01	:= 0
		Self:nSaldo51	:= 0
		
return

Method consultaErros() Class TrocaTipoEstoqueReprocessa
	
	Local cNomeCampo 	:= '"DT_ADD"'
	Local cForData 		:= "DD/MM/YYYY HH:MI:SS"
	
	Self:cAliasNovo := GetNextAlias()
	
		
		Self:cQuery := 'SELECT  WMS.BDE_COD_DEPOSITO "DEPOSITO", '
		Self:cQuery += '        WMS.BDE_COD_DEPOSITANTE "DEPOSITANT", '
		Self:cQuery += '        WMS.BDE_COD_PRODUTO "PRODUTO", '
		Self:cQuery += "        WMS.BDE_LOTE, "
		Self:cQuery += "        WMS.BDE_QTDE, "
		Self:cQuery += '        WMS.BDE_COD_TIPO_ESTOQUE_ORIGEM "ARMORI", ' 
		Self:cQuery += '        WMS.BDE_COD_TIPO_ESTOQUE_DESTINO "ARMDEST", '
		Self:cQuery += "        WMS.BDE_SEQ, 
		Self:cQuery += '        WMS.BDE_DATA_HORA "DATAHORA", '
		Self:cQuery += '        WMS.BDE_USUARIO "USUARIO", ' 
		Self:cQuery += "        WMS.STATUS, "
		Self:cQuery += "        WMS.DESC_ERRO, "
		Self:cQuery += "        WMS.DT_ADD, "
		Self:cQuery += "        WMS.DT_UPD, "
		Self:cQuery += "        WMS.DPCE_COD_CHAVE, "
		Self:cQuery += "        PROTHEUS_B2_01.QTD01, " 
		Self:cQuery += "        PROTHEUS_B2_01.RESERVA01, "
		Self:cQuery += "        PROTHEUS_B2_51.QTD51, "
		Self:cQuery += "        PROTHEUS_B2_51.RESERVA51 "
		Self:cQuery += "FROM "
		Self:cQuery += "  ( "
		Self:cQuery += "    SELECT "
		Self:cQuery += "        TTE.BDE_COD_DEPOSITO, "
		Self:cQuery += "        TTE.BDE_COD_DEPOSITANTE, "
		Self:cQuery += "        TTE.BDE_COD_PRODUTO, "
		Self:cQuery += "        TTE.BDE_LOTE, "
		Self:cQuery += "        TTE.BDE_QTDE, "
		Self:cQuery += "        TTE.BDE_COD_TIPO_ESTOQUE_ORIGEM, "
		Self:cQuery += "        TTE.BDE_COD_TIPO_ESTOQUE_DESTINO, "
		Self:cQuery += "        TTE.BDE_SEQ, 
		Self:cQuery += "        TTE.BDE_DATA_HORA, "
		Self:cQuery += "        TTE.BDE_USUARIO, 
		Self:cQuery += "        TTE.STATUS, "
		Self:cQuery += "        TTE.DESC_ERRO, "
		Self:cQuery += "        TO_CHAR(TTE.DT_ADD,'DD/MM/YYYY HH:MI:SS') "+'"DT_ADD", '
		Self:cQuery += "        TTE.DT_UPD, "
		Self:cQuery += "        TTE.DPCE_COD_CHAVE "
		Self:cQuery += "    FROM WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE TTE "
		Self:cQuery += "    WHERE  TTE.BDE_COD_DEPOSITO = 1 "
		Self:cQuery += "    AND TTE.BDE_COD_DEPOSITANTE= 3 "
		Self:cQuery += "    AND TTE.STATUS = 'ER' "
		Self:cQuery += "    AND TTE.DESC_ERRO LIKE 'ERRO:HELP: MA240NEGAT Não existe quantidade suficiente em estoque para atender esta requisição.%' "
		Self:cQuery += "    AND TTE.BDE_COD_TIPO_ESTOQUE_ORIGEM IN ('01','51') "
		Self:cQuery += "  )WMS "
		Self:cQuery += "LEFT JOIN "
		Self:cQuery += "  ( "
		Self:cQuery += '    SELECT  TRIM(B2_1.B2_COD) "PRODUTO", '
		Self:cQuery += '            B2_1.B2_QATU "QTD01", '
		Self:cQuery += '            B2_1.B2_RESERVA "RESERVA01" '
		Self:cQuery += "    FROM "+ RetSQLName(Self:B2) +" B2_1 "
		//Self:cQuery += "    FROM "+ RetSQLName(tab) +" B2_1 "
		Self:cQuery += "    WHERE B2_1.B2_FILIAL= '" + xFilial(Self:B2) + "' "
		Self:cQuery += "    AND B2_1.D_E_L_E_T_=' ' "
		Self:cQuery += "    AND B2_1.B2_LOCAL ='01' "
		Self:cQuery += "  )PROTHEUS_B2_01 "
		Self:cQuery += "ON WMS.BDE_COD_PRODUTO = PROTHEUS_B2_01.PRODUTO "
		Self:cQuery += "LEFT JOIN "
		Self:cQuery += "  ( "
		Self:cQuery += '    SELECT  TRIM(B2_51.B2_COD) "PRODUTO", '
		Self:cQuery += '            B2_51.B2_QATU "QTD51", '
		Self:cQuery += '            B2_51.B2_RESERVA "RESERVA51" '
		Self:cQuery += "    FROM "+ RetSQLName(Self:B2) +" B2_51 "
		Self:cQuery += "    WHERE B2_51.B2_FILIAL= '" + xFilial(Self:B2) + "' "
		Self:cQuery += "    AND B2_51.D_E_L_E_T_=' ' "
		Self:cQuery += "    AND B2_51.B2_LOCAL ='51' "
		Self:cQuery += "  )PROTHEUS_B2_51 "
		Self:cQuery += "ON WMS.BDE_COD_PRODUTO = PROTHEUS_B2_51.PRODUTO "
	 
	 Self:cQuery := ChangeQuery(Self:cQuery)
	 dbUseArea(.T., 'TOPCONN', TCGenQry(,,Self:cQuery),Self:cAliasNovo, .F., .T.)
	dbSelectArea(Self:cAliasNovo)
	 
Return

Method comparaEGravaInterf() Class TrocaTipoEstoqueReprocessa

	Local aEnvia 		:= {}
	Local nQtd01		:= 0
	Local nQtd51		:= 0
	Local cProAnt		:= ""
	
		IF !Empty(Self:cAliasNovo)
		While (Self:cAliasNovo)->(!Eof())
			
			If(cProAnt != AllTrim((Self:cAliasNovo)->(PRODUTO)))
				nQtd01 	:= (Self:cAliasNovo)->(QTD01) - (Self:cAliasNovo)->(RESERVA01)
				nQtd51 	:= (Self:cAliasNovo)->(QTD51) - (Self:cAliasNovo)->(RESERVA51)
				cProAnt := AllTrim((Self:cAliasNovo)->(PRODUTO))
			EndIf
						
				 If  (Self:cAliasNovo)->(BDE_QTDE) <= (Self:cAliasNovo)->(QTD51) - (Self:cAliasNovo)->(RESERVA51) .And. (Self:cAliasNovo)->(ARMORI) == 1 .And. nQtd51 > 0
				 		
				 		nQtd51:= nQtd51 -  (Self:cAliasNovo)->(BDE_QTDE)
				 		
				 		Self:cQuery := "UPDATE "+Self:cTabWms+" SET BDE_COD_TIPO_ESTOQUE_ORIGEM='51', STATUS='NP', DESC_ERRO=' ' "
				 		Self:cQuery += "WHERE BDE_COD_DEPOSITO = "+Self:cDepto
				 		Self:cQuery += " AND BDE_COD_DEPOSITANTE= "+Self:cDeptante
						Self:cQuery += " AND STATUS = 'ER' "
						Self:cQuery += " AND DESC_ERRO LIKE '"+Self:cDescErro+"%'"
				 		Self:cQuery += " AND BDE_COD_PRODUTO= '" + AllTrim((Self:cAliasNovo)->(PRODUTO)) + "'"
				 		Self:cQuery += " AND BDE_COD_TIPO_ESTOQUE_ORIGEM='"+AllTrim(STR((Self:cAliasNovo)->(ARMORI)))+"'"
				 		Self:cQuery += " AND BDE_SEQ = '"+AllTrim(STR((Self:cAliasNovo)->(BDE_SEQ)))+"'"
				 		Self:cQuery += " AND BDE_DATA_HORA = '"+AllTrim((Self:cAliasNovo)->(DATAHORA))+"'"
				 		
				 		If TcSqlExec(Self:cQuery) >= 0
								TcSqlExec("COMMIT")
						EndIf
						
				ElseIf (Self:cAliasNovo)->(BDE_QTDE) <= (Self:cAliasNovo)->(QTD01) - (Self:cAliasNovo)->(RESERVA01) .And. (Self:cAliasNovo)->(ARMORI) == 51 .And. nQtd01 > 0
						
						nQtd01 := nQtd01 - (Self:cAliasNovo)->(BDE_QTDE)
						
				 		Self:cQuery := "UPDATE "+Self:cTabWms+" SET BDE_COD_TIPO_ESTOQUE_ORIGEM='1', STATUS='NP', DESC_ERRO=' ' "
				 		Self:cQuery += "WHERE BDE_COD_DEPOSITO = "+Self:cDepto
				 		Self:cQuery += " AND BDE_COD_DEPOSITANTE= "+Self:cDeptante
						Self:cQuery += " AND STATUS = 'ER' "
						Self:cQuery += " AND DESC_ERRO LIKE '"+Self:cDescErro+"%'"
				 		Self:cQuery += " AND BDE_COD_PRODUTO= '" + AllTrim((Self:cAliasNovo)->(PRODUTO)) + "'"
				 		Self:cQuery += " AND BDE_COD_TIPO_ESTOQUE_ORIGEM='"+AllTrim(STR((Self:cAliasNovo)->(ARMORI)))+"'"
				 		Self:cQuery += " AND BDE_SEQ = '"+AllTrim(STR((Self:cAliasNovo)->(BDE_SEQ)))+"'"
				 		Self:cQuery += " AND BDE_DATA_HORA = '"+AllTrim((Self:cAliasNovo)->(DATAHORA))+"'"
				 		
				 		If TcSqlExec(Self:cQuery) >= 0
								TcSqlExec("COMMIT")
						EndIf
						
				ElseIf ((Self:cAliasNovo)->(QTD01) - (Self:cAliasNovo)->(RESERVA01)) + ((Self:cAliasNovo)->(QTD51) - (Self:cAliasNovo)->(RESERVA51)) >= (Self:cAliasNovo)->(BDE_QTDE) .And. nQtd01 > 0 .And. nQtd51 > 0
						/*1*/AADD(aEnvia,AllTrim((Self:cAliasNovo)->(PRODUTO)))
						/*2*/AADD(aEnvia,(Self:cAliasNovo)->(BDE_QTDE))
						/*3*/AADD(aEnvia,(Self:cAliasNovo)->(BDE_LOTE))
						/*4*/AADD(aEnvia,(Self:cAliasNovo)->(QTD01) - (Self:cAliasNovo)->(RESERVA01))
						/*5*/AADD(aEnvia,(Self:cAliasNovo)->(QTD51) - (Self:cAliasNovo)->(RESERVA51))
						/*6*/AADD(aEnvia,(Self:cAliasNovo)->(ARMORI))
						/*7*/AADD(aEnvia,(Self:cAliasNovo)->(ARMDEST))
						/*8*/AADD(aEnvia,(Self:cAliasNovo)->(BDE_SEQ))
						/*9*/AADD(aEnvia,(Self:cAliasNovo)->(DATAHORA))
						/*10*/AADD(aEnvia,(Self:cAliasNovo)->(USUARIO))
						/*11*/AADD(aEnvia,(Self:cAliasNovo)->(DT_ADD))
						/*12*/AADD(aEnvia,(Self:cAliasNovo)->(DT_UPD))
						/*13*/AADD(aEnvia,(Self:cAliasNovo)->(DPCE_COD_CHAVE))
						/*14*/AADD(aEnvia,(Self:cAliasNovo)->(DEPOSITO))
						/*15*/AADD(aEnvia,(Self:cAliasNovo)->(DEPOSITANT))
						
						Self:insereNovaInterface(aEnvia)
				EndIf

			 (Self:cAliasNovo)->(DbSkip())
		 EndDo
		 dbCloseArea(Self:cAliasNovo)
		EndIf
		
		
Return

Method deletaInterfaceAntiga(aRecebido) class TrocaTipoEstoqueReprocessa

If aRecebido[4] + aRecebido[5] == aRecebido[2]
nResultado := aRecebido[2] - aRecebido[4]
	If nResultado > 0
		//Deleta a interface com o erro.
		 Self:cQuery := "DELETE WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE " 
		 Self:cQuery += "WHERE BDE_COD_DEPOSITANTE='"+AllTrim(STR(aRecebido[15]))+"' "
		 Self:cQuery += "AND BDE_COD_DEPOSITO='"+AllTrim(STR(aRecebido[14]))+"' "
		 Self:cQuery += "AND BDE_COD_PRODUTO='"+aRecebido[1]+"' "
		 Self:cQuery += "AND BDE_QTDE='"+AllTrim(STR(aRecebido[2]))+"' "
		 Self:cQuery += "AND BDE_COD_TIPO_ESTOQUE_ORIGEM='"+AllTrim(STR(aRecebido[6]))+"' " 
		 Self:cQuery += "AND BDE_COD_TIPO_ESTOQUE_DESTINO='"+AllTrim(STR(aRecebido[7]))+"' "
		 Self:cQuery += "AND BDE_SEQ='"+AllTrim(STR(aRecebido[8]))+"' "
		 Self:cQuery += "AND BDE_USUARIO='"+aRecebido[10]+"' "
		 //Self:cQuery += "AND DT_ADD like '"+substr(AllTrim(aRecebido[11]), 1, 10)+"%' "
		 //Self:cQuery += "AND DT_ADD like '%"+substr(AllTrim(aRecebido[11]), 12, 8)+"' "
		 Self:cQuery += "AND STATUS='ER'"
		 If TcSqlExec(Self:cQuery) >= 0
			TcSqlExec("COMMIT")
		Else			
			alert("TCSQLError() " + TCSQLError())
		EndIf
	EndIf
EndIf

Return

Method insereNovaInterface(aRecebido) Class TrocaTipoEstoqueReprocessa
	Local nResultado := 0
	Local nChave := 0
	
	If aRecebido[4] + aRecebido[5] == aRecebido[2]
		nResultado := aRecebido[2] - aRecebido[4]
		if nResultado > 0
			 
		Self:cQuery := "Insert into WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE values "
		//Self:cQuery += "("+AllTrim(STR(aRecebido[14]))+","+AllTrim(STR(aRecebido[15]))+",'"+aRecebido[1]+"',' ',"+AllTrim(STR(aRecebido[4]))+",1,"+AllTrim(STR(aRecebido[7]))+","+AllTrim(STR(aRecebido[8]))+",'"+aRecebido[9]+"','"+aRecebido[10]+"','NP',' ', '"+AllTrim(aRecebido[11])+"', NULL, NULL) "
			Self:cQuery += "("+AllTrim(STR(aRecebido[14]))+","+AllTrim(STR(aRecebido[15]))+",'"+aRecebido[1]+"',' ',"+AllTrim(STR(aRecebido[4]))+",1,"+AllTrim(STR(aRecebido[7]))+","+AllTrim(STR(aRecebido[8]))+",'"+aRecebido[9]+"','"+aRecebido[10]+"','NP',' ',current_date , NULL, NULL) "			
			If TcSqlExec(Self:cQuery) >= 0
				TcSqlExec("COMMIT")
				nChave++
			Else			
			    alert("TCSQLError() " + TCSQLError())
			EndIf
			 
		Self:cQuery := "Insert into WMS.TB_WMSINTERF_TROCA_TP_ESTOQUE values "
		//Self:cQuery += "("+AllTrim(STR(aRecebido[14]))+","+AllTrim(STR(aRecebido[15]))+",'"+aRecebido[1]+"',' ',"+AllTrim(STR(nResultado))+",51,"+AllTrim(STR(aRecebido[7]))+","+AllTrim(STR(aRecebido[8]))+",'"+aRecebido[9]+"','"+aRecebido[10]+"','NP',' ','"+AllTrim(aRecebido[11])+"', NULL, NULL) "
		Self:cQuery += "("+AllTrim(STR(aRecebido[14]))+","+AllTrim(STR(aRecebido[15]))+",'"+aRecebido[1]+"',' ',"+AllTrim(STR(nResultado))+",51,"+AllTrim(STR(aRecebido[7]))+","+AllTrim(STR(aRecebido[8]))+",'"+aRecebido[9]+"','"+aRecebido[10]+"','NP',' ',current_date, NULL, NULL) "
			If TcSqlExec(Self:cQuery) >= 0
				TcSqlExec("COMMIT")
				nChave++
			Else			
			    alert("TCSQLError() " + TCSQLError())
			EndIf
			
			 If nChave == 2
			 	Self:deletaInterfaceAntiga(aRecebido)
			 EndIf
			 
		EndIf
	EndIf

Return