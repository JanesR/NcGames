#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#define clr Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR704  ºAutor  ³ACPD                º Data ³  04/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Recalculo Verba Extra Financeiro                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCGPR704()
Local oBrowse
Local aFields:={}
Local aFixes :={}
Private cCadastro := "Verba Extra Apuração Financeira"

AADD(aFixes, {AvSx3("P01_PEDVEN",5),"P01_PEDVEN" })
AADD(aFixes, {AvSx3("P01_DTAPUR",5),"P01_DTAPUR" })
AADD(aFixes, {AvSx3("P01_HOAPUR",5),"P01_HOAPUR" })


AADD(aFixes, {AvSx3("P02_PERCEN",5), {|| Posicione("P02",1,xFilial("P02")+P01->(P01_CODIGO+P01_VERSAO) ,"P02_PERCEN"  )  },,AvSx3("P02_PERCEN" ,6)  })
AADD(aFixes, {AvSx3("P02_VLRFAT",5), {|| Posicione("P02",1,xFilial("P02")+P01->(P01_CODIGO+P01_VERSAO) ,"P02_VLRFAT"  )  },,AvSx3("P02_VLRFAT" ,6)  })
AADD(aFixes, {AvSx3("P02_VALOR" ,5), {|| Posicione("P02",1,xFilial("P02")+P01->(P01_CODIGO+P01_VERSAO) ,"P02_VALOR"   )  },,AvSx3("P02_VALOR"  ,6)  })
AADD(aFixes, {AvSx3("P02_VLORIG",5), {|| Posicione("P02",1,xFilial("P02")+P01->(P01_CODIGO+P01_VERSAO) ,"P02_VLORIG"  )  },,AvSx3("P02_VLORIG" ,6)  })



oBrowse := FWMBrowse():New()
oBrowse:SetAlias("P01")
oBrowse:SetFields(aFixes)
oBrowse:SetFilterDefault( "P01_TPCAD='2' .And. P01_TPVPC='2' .And. P01_REPASS='1' .And. P01_PEDVEN<>' '" )
oBrowse:SetDescription(cCadastro)
oBrowse:Activate()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR704  ºAutor  ³Microsiga           º Data ³  07/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MenuDef()
Local aRotina := { }
AADD(aRotina, {"Pesquisar"	  		,"AxPesqui"			,0,1} )
AADD(aRotina, {"Recalcular"	   ," Processa( {|| U_PR704RECAL() } )" ,0,4} )

Return aRotina
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PR01PROP04ºAutor  ³ACPD                    º Data ³  04/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Exibe os parâmetros para realizar processamento da apuracao º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR704RECAL()
Local aAreaAtu	:=GetArea()
Local cPerg		:= Padr("NCGPR704",Len(SX1->X1_GRUPO))
Local cQuery	:=""
Local cAliasQry:= GetNextAlias()
Local clQRYAPR	:= GetNextAlias()
Local cFilSD2	:=xFilial("SD2")


NCPRSX1(cPerg)

If  !Pergunte(cPerg, .T. )
	Return
EndIf


SD2->(DbSetOrder(8))	//D2_FILIAL+D2_PEDIDO+D2_ITEMPV
P02->(DbSetOrder(1))//P02_FILIAL+P02_CODVPC+P02_VERSAO+P02_CODTP

cQuery :=" SELECT P01.R_E_C_N_O_ P01Rec FROM "+RetSqlName("P01")+" P01 "   + clr
cQuery +=" WHERE P01.P01_FILIAL='"+xFilial("P01")+"'"
cQuery +=" AND P01.P01_CODCLI BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'" + clr
cQuery +=" AND P01.P01_LOJCLI BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'" + clr
cQuery +=" AND P01.P01_TPCAD='2'    "											   	   + clr
cQuery +=" AND P01.P01_REPASS = '1'"											   	+ clr
cQuery +=" AND P01.P01_STSAPR = '1'"											   	+ clr
cQuery +=" AND P01.P01_PEDVEN<>' '" 											   	+ clr
cQuery +=" AND ( P01.P01_DTVINI <= '"+DtoS(MV_PAR01)+"' 	AND   P01.P01_DTVFIM >= '"+DtoS(MV_PAR02)+"')"			   		+ clr
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)



Do While (cAliasQry)->(!Eof())
	
	P01->(DbGoTo((cAliasQry)->P01Rec))
	
	IncProc("Pedido "+P01->P01_PEDVEN)
	
	If !P02->(DbSeek(xFilial("P02")+P01->(P01_CODIGO+P01_VERSAO))) .Or. P02->P02_PERCEN==0
		(cAliasQry)->(DbSkip());Loop
	EndIf
	
	If Select(clQRYAPR) >0
		(clQRYAPR)->(DbCloseArea())
	EndIf
	
	If SD2->(DbSeek(cFilSD2+P01->P01_PEDVEN))
		
		PR704Recalc(clQRYAPR)
		
		Begin Transaction
		
		P02->(RecLock("P02",.F.))
		If Empty(P02->P02_VLORIG)
			P02->P02_VLORIG:=P02->P02_VALOR
		EndIf
		
		If P01->P01_TPFAT=='1' 		//1=Bruto;2=Liquido
			nValor:= (clQRYAPR)->BRUTO
		Else
			nValor:= (clQRYAPR)->LIQUIDO
		EndIf
		
		P02->P02_VALOR:=nValor*P02->P02_PERCEN/100
		P02->P02_VLRFAT:=nValor
		
		P02->(MsUnLock())
		
		P01->(RecLock("P01",.F.))
		P01->P01_DTAPUR:=MsDate()
		P01->P01_HOAPUR:=Time()
		P01->(MsUnLock())
		
		End Transaction
		
	EndIf
	
	(cAliasQry)->(DbSkip())
EndDo



(cAliasQry)->(DbCloseArea())
If Select(clQRYAPR) >0
	(clQRYAPR)->(DbCloseArea())
EndIf

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PR704Recalc ºAutor  ³ACPD                º Data ³  10/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query para carregar a tela de apuração                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR704Recalc(clQRYAPR)
Local cQry 		:= ""
Local cQryInter	:= ""
Local nCOuntReg	:= 0



cQry += " SELECT CLIENTE"		+ clr
cQry += "  ,LOJA"				+ clr
cQry += "  ,NOME "				+ clr
cQry += "  ,TPFAT"				+ clr
cQry += "  ,TOTPER"				+ clr
cQry += "  ,CODVPC"				+ clr
cQry += "  ,VERVPC"				+ clr
cQry += "  ,SUM(NVL(BRUTO,0)) AS TOTBRUTO"		+ clr
cQry += "  ,SUM(NVL(LIQUIDO,0)) AS TOTLIQUIDO"	+ clr
cQry += "   FROM ( "			+ clr

// Notas de Saída
cQryInter += " 			SELECT "	   					+ clr

cQryInter += " 			F2_FILIAL AS FILIAL"			+ clr
cQryInter += " 			,'S' AS TIPONF"	   				+ clr
cQryInter += " 			,F2_TIPO AS TIPO "	 			+ clr
cQryInter += " 			,F2_SERIE AS SERIE "			+ clr
cQryInter += " 			,F2_DOC AS DOC "				+ clr

cQryInter += " 			,F2_CLIENTE AS CLIENTE"			+ clr
cQryInter += " 			,F2_LOJA AS LOJA"				+ clr
cQryInter += "  			,A1_NOME AS NOME "			+ clr
cQryInter += "  			,P01_TPFAT AS TPFAT" 		+ clr
cQryInter += "  			,P01_TOTPER AS TOTPER "		+ clr
cQryInter += "  			,P01_CODIGO AS CODVPC "		+ clr
cQryInter += "  			,P01_VERSAO AS VERVPC "		+ clr
cQryInter += "  			,( SELECT "					+ clr
cQryInter += "  					(SUM (SUBBT.D2_TOTAL + SUBBT.D2_ICMSRET + SUBBT.D2_VALIPI +  SUBBT.D2_DESPESA + SUBBT.D2_SEGURO + SUBBT.D2_VALFRE  ))  AS BRUT "	+ clr
cQryInter += "  					FROM "+RetSqlName("SD2")+" SUBBT "			+ clr
cQryInter += "  					WHERE SUBBT.D_E_L_E_T_ <> '*'"				+ clr
cQryInter += "  					AND SUBBT.D2_FILIAL		= SF2.F2_FILIAL"	+ clr
cQryInter += "  					AND SUBBT.D2_CLIENTE	= SF2.F2_CLIENTE"	+ clr
cQryInter += "  			 		AND SUBBT.D2_LOJA		= SF2.F2_LOJA"		+ clr
cQryInter += "  			 		AND SUBBT.D2_TIPO		= SF2.F2_TIPO"		+ clr
cQryInter += "  			 		AND SUBBT.D2_DOC		= SF2.F2_DOC"		+ clr
cQryInter += "  			 		AND SUBBT.D2_SERIE	= SF2.F2_SERIE"		+ clr
cQryInter += "  			 		AND SUBBT.D2_PEDIDO	='"+P01->P01_PEDVEN+"'"		+ clr
cQryInter += "  			 		AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SUBBT.D2_TES AND SF4.D_E_L_E_T_=' ')"	+ clr

cQryInter += "  			 	) AS BRUTO "									+ clr

cQryInter += " 			,( SELECT "						+ clr
cQryInter += " 				((SUM (SUBD2.D2_TOTAL + SUBD2.D2_ICMSRET + SUBD2.D2_VALIPI +   SUBD2.D2_DESPESA + SUBD2.D2_SEGURO + SUBD2.D2_VALFRE  ))  -  (SUM(SUBD2.D2_VALICM+SUBD2.D2_VALIMP6+SUBD2.D2_VALIMP5+SUBD2.D2_VALIPI+SUBD2.D2_ICMSRET+SUBD2.D2_DESPESA+SUBD2.D2_SEGURO+SUBD2.D2_VALFRE))) AS LIQ " 	+ clr
cQryInter += " 				FROM "+RetSqlName("SD2")+ " SUBD2 "			+ clr
cQryInter += " 				WHERE SUBD2.D_E_L_E_T_ <> '*'"				+ clr
cQryInter += " 				AND SUBD2.D2_FILIAL		= SF2.F2_FILIAL"	+ clr
cQryInter += " 				AND SUBD2.D2_CLIENTE	= SF2.F2_CLIENTE"	+ clr
cQryInter += " 				AND SUBD2.D2_LOJA		= SF2.F2_LOJA"		+ clr
cQryInter += " 				AND SUBD2.D2_TIPO		= SF2.F2_TIPO"		+ clr
cQryInter += " 				AND SUBD2.D2_DOC		= SF2.F2_DOC"		+ clr
cQryInter += " 				AND SUBD2.D2_SERIE		= SF2.F2_SERIE"		+ clr
cQryInter += "  			 	AND SUBD2.D2_PEDIDO	='"+P01->P01_PEDVEN+"'"		+ clr
cQryInter += "  			 AND EXISTS ( SELECT 1 FROM "+RetSqlName("SF4") +" SF4 WHERE SF4.F4_FILIAL='"+xFilial("SF4")+"' AND SF4.F4_DUPLIC='S' AND SF4.F4_CODIGO=SUBD2.D2_TES AND SF4.D_E_L_E_T_=' ')"	+ clr
cQryInter += " 				)  LIQUIDO "								+ clr

cQryInter += "  			FROM "+RetSqlName("SF2")+" SF2 "+ clr

cQryInter += "  			JOIN "+RetSqlName("SA1")+" SA1 "+ clr
cQryInter += "  			ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"	+ clr
cQryInter += "  			AND SA1.A1_COD = SF2.F2_CLIENTE"+ clr
cQryInter += "  			AND SA1.A1_LOJA = SF2.F2_LOJA "	+ clr

//If  !Empty(MV_PAR03) .and. !Empty(MV_PAR05) .or. Empty(MV_PAR03) .and. !Empty(MV_PAR05)
//	cQryInter += "   			AND SA1.A1_COD BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"+ clr
//	If  !Empty(MV_PAR06)
//		cQryInter += " 			AND SA1.A1_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"+ clr
//	EndIf
//EndIf

cQryInter += " 			AND SA1.D_E_L_E_T_= ' '"												+ clr

cQryInter += " 			JOIN "+RetSqlName("P01")+" P01 "										+ clr
cQryInter += " 			ON P01.P01_FILIAL = '"+xFilial("P01")+"'"								+ clr

cQryInter += " 			AND P01.P01_CODCLI = SA1.A1_COD "							   		+ clr
cQryInter += " 			AND P01.P01_LOJCLI = (CASE WHEN P01.P01_LOJCLI = '  ' THEN  '  '  ELSE SA1.A1_LOJA END )"+ clr


cQryInter += " 			AND P01.P01_CODIGO = '"+P01->P01_CODIGO+"'"												+ clr
cQryInter += " 			AND P01.P01_VERSAO = '"+P01->P01_VERSAO+"'"												+ clr

cQryInter += " 			AND P01.D_E_L_E_T_= ' '"												+ clr


cQryInter += " 			WHERE SF2.F2_FILIAL ='"+xFilial("SF2")+"'"								+ clr
cQryInter += " 			AND SF2.F2_DOC='"+SD2->D2_DOC+"'"
cQryInter += "  			AND SF2.F2_SERIE='"+SD2->D2_SERIE+"'"


//If !Empty(MV_PAR03) .or. !Empty(MV_PAR05)
//	cQryInter += " 			AND SF2.F2_CLIENTE BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"	+ clr
//	cQryInter += "  			AND SF2.F2_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"		+ clr
//Else
//	cQryInter += "  			AND SF2.F2_CLIENTE BETWEEN '"+Replicate(" ",TamSx3("F2_CLIENTE")[1])+"' AND '"+Replicate("Z",TamSx3("F2_CLIENTE")[1])+"'"	+ clr
//	cQryInter += "  			AND SF2.F2_LOJA BETWEEN '"	+Replicate(" ",TamSx3("F2_LOJA")[1])+"' AND '"+Replicate("Z",TamSx3("F2_LOJA")[1])+"'"				+ clr
//EndIf


cQryInter += "  			AND SF2.F2_TIPO = 'N'"													+ clr

//If nOpc == 3
//cQryInter += "  			AND SF2.F2_YAPURAC = ' ' "											+ clr
//cQryInter += "  			AND SF2.F2_YVERAPU = ' ' "											+ clr
//EndIf

cQryInter += "  			AND EXISTS(	SELECT "													+ clr
cQryInter += " 			 					Z1_DOC"												+ clr
cQryInter += " 						  	FROM "+RetSqlName("SZ1")+ " SZ1 "						+ clr
cQryInter += " 			             	WHERE SZ1.Z1_FILIAL = SF2.F2_FILIAL"					+ clr
cQryInter += " 			             	AND SZ1.Z1_DOC = SF2.F2_DOC "							+ clr
cQryInter += " 			             	AND SZ1.Z1_SERIE = SF2.F2_SERIE "						+ clr
cQryInter += " 			             	AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"					+ clr
cQryInter += " 			             	AND SZ1.Z1_LOJA = SF2.F2_LOJA"							+ clr
//cQryInter += " 			             	AND SZ1.Z1_DTENTRE BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"'"	+ clr
cQryInter += " 			             	AND SZ1.D_E_L_E_T_= ' ')"								+ clr
cQryInter += "  			AND SF2.D_E_L_E_T_= ' '"												+ clr


cQryInter += "  			GROUP BY  F2_FILIAL,F2_TIPO,F2_SERIE,F2_DOC,F2_CLIENTE,F2_LOJA,A1_NOME,P01_TPFAT,P01_TOTPER,P01_CODIGO,P01_VERSAO  "		+ clr

// Devoluções
cQryInter += "  			UNION "								+ clr

cQryInter += "  			SELECT "							+ clr
cQryInter += "  			F1_FILIAL AS FILIAL "				+ clr
cQryInter += " 		   		,'E' AS TIPONF"	  	 				+ clr
cQryInter += "  			,F1_TIPO AS TIPO "					+ clr
cQryInter += "  			,F1_SERIE AS SERIE "				+ clr
cQryInter += "  			,F1_DOC AS DOC "					+ clr
cQryInter += "  			,F1_FORNECE AS CLIENTE"				+ clr
cQryInter += "  			,F1_LOJA AS LOJA "					+ clr
cQryInter += "  			,A1_NOME AS NOME "					+ clr

cQryInter += "  			,P01_TPFAT AS TPFAT " 				+ clr
cQryInter += "  			,P01_TOTPER AS TOTPER "				+ clr
cQryInter += "  			,P01_CODIGO AS CODVPC "				+ clr
cQryInter += " 			,P01_VERSAO AS VERVPC "			 		+ clr


cQryInter += "  			,( SELECT  "						+ clr
cQryInter += "  				( (Sum ((SUBD0.D1_TOTAL + SUBD0.D1_VALIPI + SUBD0.D1_ICMSRET + SUBD0.D1_DESPESA + SUBD0.D1_SEGURO + SUBD0.D1_VALFRE ) - SUBD0.D1_VALDESC ))  * -1 )  "	+ clr
cQryInter += "  				FROM "+RetSqlName("SD1")+" SUBD0 "			+ clr
cQryInter += "  				WHERE SUBD0.D_E_L_E_T_ <> '*' "				+ clr
cQryInter += "  				AND SUBD0.D1_FILIAL		= SF1.F1_FILIAL "	+ clr
cQryInter += "  				AND SUBD0.D1_FORNECE	= SF1.F1_FORNECE "	+ clr
cQryInter += "  				AND SUBD0.D1_LOJA		= SF1.F1_LOJA "		+ clr
cQryInter += "  				AND SUBD0.D1_TIPO		= SF1.F1_TIPO "		+ clr
cQryInter += "  				AND SUBD0.D1_DOC		= SF1.F1_DOC " 		+ clr
cQryInter += "  				AND SUBD0.D1_SERIE		= SF1.F1_SERIE "	+ clr
cQryInter += "  			 )  AS  BRUTO "									+ clr


cQryInter += "  			,( SELECT  "									+ clr
cQryInter += "  				( (Sum ((SUBD1.D1_TOTAL + SUBD1.D1_VALIPI + SUBD1.D1_ICMSRET + SUBD1.D1_DESPESA + SUBD1.D1_SEGURO + SUBD1.D1_VALFRE ) - (SUBD1.D1_VALDESC) )  - SUM(SUBD1.D1_VALICM+SUBD1.D1_VALIMP6+SUBD1.D1_VALIMP5+SUBD1.D1_VALIPI+SUBD1.D1_ICMSRET+ SUBD1.D1_DESPESA + SUBD1.D1_SEGURO + SUBD1.D1_VALFRE) )  * -1 )	AS LIQ "	+ clr

cQryInter += "  				FROM "+RetSqlName("SD1")+" SUBD1 "			+ clr
cQryInter += "  				WHERE SUBD1.D_E_L_E_T_ <> '*' "				+ clr
cQryInter += "  				AND SUBD1.D1_FILIAL		= SF1.F1_FILIAL "	+ clr
cQryInter += "  				AND SUBD1.D1_FORNECE	= SF1.F1_FORNECE "	+ clr
cQryInter += "  				AND SUBD1.D1_LOJA		= SF1.F1_LOJA "		+ clr
cQryInter += "  				AND SUBD1.D1_TIPO		= SF1.F1_TIPO "		+ clr
cQryInter += "  				AND SUBD1.D1_DOC		= SF1.F1_DOC " 		+ clr
cQryInter += "  				AND SUBD1.D1_SERIE		= SF1.F1_SERIE "	+ clr
cQryInter += "  			 )  LIQUIDO "									+ clr

cQryInter += " 			 FROM "+ RetSqlName("SF1")+ " SF1 "	+ clr

cQryInter += "  		JOIN "+RetSqlName("SD1")+ " SD1 "	+ clr
cQryInter += " 			ON SD1.D1_FILIAL = SF1.F1_FILIAL"	+ clr
cQryInter += " 			AND SD1.D1_DOC = SF1.F1_DOC"		+ clr
cQryInter += " 			AND SD1.D1_SERIE = SF1.F1_SERIE"	+ clr
cQryInter += " 			AND SD1.D1_FORNECE = SF1.F1_FORNECE"+ clr
cQryInter += "  		AND SD1.D1_LOJA = SF1.F1_LOJA"   	+ clr
cQryInter += " 			AND SD1.D1_TIPO = SF1.F1_TIPO"		+ clr
cQryInter += "  		AND SD1.D1_DTDIGIT = SF1.F1_DTDIGIT"+ clr
cQryInter += "  		AND SD1.D_E_L_E_T_= ' '"			+ clr

cQryInter += " 			JOIN "+RetSqlName("SD2")+ " SD2 "	+ clr
cQryInter += " 			ON SD2.D2_FILIAL = SD1.D1_FILIAL"	+ clr
cQryInter += " 			AND SD2.D2_DOC = SD1.D1_NFORI"		+ clr
cQryInter += " 			AND SD2.D2_SERIE = SD1.D1_SERIORI"	+ clr
cQryInter += " 			AND SD2.D2_CLIENTE = SD1.D1_FORNECE"+ clr
cQryInter += " 			AND SD2.D2_LOJA = SD1.D1_LOJA"		+ clr
cQryInter += " 			AND SD2.D2_COD = SD1.D1_COD"		+ clr
cQryInter += "  			AND SD2.D2_PEDIDO	='"+P01->P01_PEDVEN+"'"		+ clr
cQryInter += " 			AND SD2.D_E_L_E_T_= ' '"			+ clr

cQryInter += " 			JOIN " +RetSqlName("SF2")+" SF2 "	+ clr
cQryInter += " 			ON SF2.F2_FILIAL = SD2.D2_FILIAL "	+ clr
cQryInter += " 			AND SF2.F2_DOC = SD2.D2_DOC "		+ clr
cQryInter += " 			AND SF2.F2_SERIE = SD2.D2_SERIE "	+ clr
cQryInter += " 			AND SF2.F2_CLIENTE = SD2.D2_CLIENTE"+ clr
cQryInter += " 			AND SF2.F2_LOJA  = SD2.D2_LOJA "	+ clr
cQryInter += " 			AND SF2.F2_DOC='"+SD2->D2_DOC+"'"
cQryInter += "  			AND SF2.F2_SERIE='"+SD2->D2_SERIE+"'"

cQryInter += " 			AND SF2.D_E_L_E_T_= ' '"			+ clr

cQryInter += "  			AND EXISTS(	SELECT "													+ clr
cQryInter += " 			 					Z1_DOC"												+ clr
cQryInter += " 						  	FROM "+RetSqlName("SZ1")+ " SZ1 "						+ clr
cQryInter += " 			             	WHERE SZ1.Z1_FILIAL = SF2.F2_FILIAL"					+ clr
cQryInter += " 			             	AND SZ1.Z1_DOC = SF2.F2_DOC "							+ clr
cQryInter += " 			             	AND SZ1.Z1_SERIE = SF2.F2_SERIE "						+ clr
cQryInter += " 			             	AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"					+ clr
cQryInter += " 			             	AND SZ1.Z1_LOJA = SF2.F2_LOJA"							+ clr
cQryInter += " 			             	AND SZ1.Z1_DTENTRE <>' '"			+ clr
cQryInter += " 			             	AND SZ1.D_E_L_E_T_= ' ')"								+ clr


cQryInter += " 			JOIN "+RetSqlName("SA1")+" SA1 "	+ clr
cQryInter += " 			ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"	+ clr
cQryInter += "  			AND SA1.A1_COD = SF1.F1_FORNECE"		+ clr
cQryInter += " 			AND SA1.A1_LOJA = SF1.F1_LOJA "		+ clr

//If  !Empty(MV_PAR03) .and. !Empty(MV_PAR05) .or. Empty(MV_PAR03) .and. !Empty(MV_PAR05)
//	cQryInter += "   			AND SA1.A1_COD BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"	+ clr
//	If  !Empty(MV_PAR06)
//		cQryInter += "   			AND SA1.A1_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"+ clr
//	EndIf
//EndIf


cQryInter += "  			AND SA1.D_E_L_E_T_= ' '"								+ clr

cQryInter += "   			JOIN "+RetSqlName("P01")+" P01 "					+ clr
cQryInter += "   			ON P01.P01_FILIAL = '"+xFilial("P01")+"'"			+ clr

cQryInter += "   			AND P01.P01_CODCLI = SA1.A1_COD "				+ clr
cQryInter += "   			AND P01.P01_LOJCLI = (CASE WHEN P01.P01_LOJCLI = '  ' THEN  '  '  ELSE SA1.A1_LOJA END )"+ clr



cQryInter += " 			AND P01.P01_CODIGO = '"+P01->P01_CODIGO+"'"												+ clr
cQryInter += " 			AND P01.P01_VERSAO = '"+P01->P01_VERSAO+"'"												+ clr
cQryInter += "   			AND P01.D_E_L_E_T_= ' '"							+ clr

cQryInter += "  			WHERE SF1.F1_FILIAL = '"+xFilial("SF1")+"'"				+ clr
cQryInter += "  			AND SF1.F1_DOC      BETWEEN '"+Replicate(" ",TamSx3("F1_DOC")[1])+"' AND '"+Replicate("Z",TamSx3("F1_DOC")[1])+"'"		+ clr
cQryInter += "  			AND SF1.F1_SERIE    BETWEEN '"+Replicate(" ",TamSx3("F1_SERIE")[1])+"' AND '"+Replicate("Z",TamSx3("F1_SERIE")[1])+"'"	+ clr
//If !Empty(MV_PAR03) .or. !Empty(MV_PAR05)
//	cQryInter += "  			AND SF1.F1_FORNECE BETWEEN '"	+MV_PAR03+"' AND '"+MV_PAR05+"'"	+ clr
//	cQryInter += " 			AND SF1.F1_LOJA BETWEEN '"	+MV_PAR04+"' AND '"+MV_PAR06+"'"		+ clr
//Else
//	cQryInter += "  			AND SF1.F1_FORNECE BETWEEN '"	+Replicate(" ",TamSx3("F1_FORNECE")[1])+"' AND '"+Replicate("Z",TamSx3("F1_FORNECE")[1])+"'"	+ clr
//	cQryInter += "  			AND SF1.F1_LOJA BETWEEN '"	+Replicate(" ",TamSx3("F1_LOJA")[1])+"' AND '"+Replicate("Z",TamSx3("F1_LOJA")[1])+"'"				+ clr
//EndIf
cQryInter += "  			AND SF1.F1_TIPO = 'D'"		   		+ clr
cQryInter += "  			AND SF1.F1_DTDIGIT  BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"'"	+ clr


//cQryInter += "  			AND SF1.F1_YAPURAC = ' ' "		+ clr
//cQryInter += "  			AND SF1.F1_YVERAPU = ' ' "		+ clr


cQryInter += "  			AND SF1.D_E_L_E_T_= ' '"			+ clr


cQryInter += "  			GROUP BY F1_FILIAL,F1_TIPO,F1_SERIE,F1_DOC,F1_FORNECE,F1_LOJA,A1_NOME,P01_TPFAT,P01_TOTPER,P01_CODIGO,P01_VERSAO "	+ clr

cQry += cQryInter

//cQry += " ) TAB "										+ clr
//cQry += " HAVING (SUM(BRUTO)>0 Or SUM(LIQUIDO)>0) "+ clr


//cQry += " GROUP BY TAB.CLIENTE,TAB.LOJA,TAB.NOME,TAB.TPFAT,TAB.TOTPER,TAB.CODVPC,TAB.VERVPC "+ clr


//cQry += " ORDER BY CLIENTE,LOJA "		+ clr

TcQuery cQryInter New Alias &(clQRYAPR)
TCSetField((clQRYAPR),"TOTBRUTO"		,"N",TamSx3("F2_VALBRUT")[1],TamSx3("F2_VALBRUT")[2]	)
TCSetField((clQRYAPR),"TOTLIQUIDO"		,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
TCSetField((clQRYAPR),"TOTPER"			,"N",TamSx3("P01_TOTPER")[1],TamSx3("P01_TOTPER")[2]	)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCPRSX1   ºAutor  ³ACPD                    º Data ³  04/10/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o grupo de perguntas                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function NCPRSX1( cPerg )

Local alAreaAtu	:= GetArea()
Local alAux		:= {}

aAdd( alAux, {	"01",;		  					// 01-Ordem da Pergunta (2)
"Da Data",;					  					// 02-Descrição em Portugues (30)
"Da Data",;				  						// 03-Descrição em Espanhol (30)
"Da Data",;				  						// 04-Descrição em Ingles (30)
"mv_ch1",;							  			// 05-Nome da Variável (6)
"D",;											// 06-Tipo da Variável (1)
8,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR01",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"02",;		  					// 01-Ordem da Pergunta (2)
"Ate Data",;					  				// 02-Descrição em Portugues (30)
"Ate Data",;				  					// 03-Descrição em Espanhol (30)
"Ate Data",;				  					// 04-Descrição em Ingles (30)
"mv_ch2",;							  			// 05-Nome da Variável (6)
"D",;											// 06-Tipo da Variável (1)
8,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR02",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"03",;		  					// 01-Ordem da Pergunta (2)
"Do Cliente",;					  				// 02-Descrição em Portugues (30)
"Do Cliente",;				  					// 03-Descrição em Espanhol (30)
"Do Cliente",;				  					// 04-Descrição em Ingles (30)
"mv_ch3",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"VAZIO()",;// 11-Expressão de Validação da Variável (60)
"SA1",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR03",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"04",;		  									// 01-Ordem da Pergunta (2)
"Da Loja",;						  				// 02-Descrição em Portugues (30)
"Da Loja",;				  						// 03-Descrição em Espanhol (30)
"Da Loja",;				  						// 04-Descrição em Ingles (30)
"mv_ch4",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR04",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"05",;		  									// 01-Ordem da Pergunta (2)
"Até o Cliente",;					  			// 02-Descrição em Portugues (30)
"Até o Cliente",;				  					// 03-Descrição em Espanhol (30)
"Até o Cliente",;				  					// 04-Descrição em Ingles (30)
"mv_ch5",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"VAZIO()",;			// 11-Expressão de Validação da Variável (60)
"SA1",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR05",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"06",;		  									// 01-Ordem da Pergunta (2)
"Ate a Loja",;						  				// 02-Descrição em Portugues (30)
"Ate a Loja",;				  						// 03-Descrição em Espanhol (30)
"Ate a Loja",;				  						// 04-Descrição em Ingles (30)
"mv_ch6",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR06",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


U_MyNewX1( { cPerg, aClone( alAux ) } )

RestArea( alAreaAtu )

Return()
