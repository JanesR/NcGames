#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'
#INCLUDE "RPTDEF.CH"
#INCLUDE "Font.ch"
#INCLUDE "COLORS.CH"
#INCLUDE "REPORT.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR711  ºAutor  ³Microsiga           º Data ³  01/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPR712()
Local oReport	:= Nil
Private clAlias		:= GetNextAlias()
Private clAliasQry
oReport:=ReportDef()

IIF(Select((clAlias)) > 0,(clAlias)->(dbCloseArea()),.f.  )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR712  ºAutor  ³Microsiga           º Data ³  01/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

Local cTitulo	:= "Relatório Conciliação Final"
Local cDescricao:= "Este programa tem como objetivo imprimir relatório de acordo com os parametros informados pelo usuario."
Local clPerg	:= Padr("NCGPR712",Len(SX1->X1_GRUPO))
Local oReport	:= Nil

Local oBreak	:= Nil
Local oTotal1	:= nil
Local oTotal2	:= nil
Local oTotal3	:= nil
Local oNotas	:= nil


NCRL1SX1(clPerg)

If !Pergunte(clPerg, .T. )
	Return
EndIf

oReport := TReport():New("NCGPR712",cTitulo,clPerg,{|oReport| ReportPrint(oReport)},cDescricao)
//oReport:SetLandscape(.F.)//Impressao Paissagem
oReport:oPage:nPaperSize:= 9
//oReport:DisableOrientation()//Desabilita a mudanca de impressao
oReport:nDevice := 4

oSection := TRSection():New(oReport,"",(clAlias),,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
oSection:SetHeaderSection():=.F.

TRCell():New(oSection,"ZZJ_CLIENT"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->CLIENTE		})
TRCell():New(oSection,"ZZJ_LOJA"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->LOJA		})
TRCell():New(oSection,"ZZJ_DESCLI"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->NOME		})

// SECTION 1
oSection1 := TRSection():New(oSection,"Contrato VPC","ZZJ",,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
oSection1:SetHeaderSection():=.F.

TRCell():New(oSection1,"ZZJ_VLRVPC"	  ,"ZZJ","Apuraçcao"	,/*Picture*/					,/*Tamanho*/,/*lPixel*/			,{|| (clAliasQry)->ZZJ_VLRVPC									})
TRCell():New(oSection1,"ZZJ_VLRCLI"	  ,"ZZJ","Cobrado Cliente"	,/*Picture*/					    ,/*Tamanho*/,/*lPixel*/,{|| (clAliasQry)->ZZJ_VLRCLI									})
TRCell():New(oSection1,"E1_SALDO"	  ,"ZZJ","Pago"			,/*Picture*/					,/*Tamanho*/,/*lPixel*/		    ,{|| (clAliasQry)->E1_SALDO										})
TRCell():New(oSection1,"ZZJ_VLRCLI"	  ,"ZZJ","Pedido Venda"	,/*Picture*/					,/*Tamanho*/,/*lPixel*/		,{|| M->C5_YVLVPC									})


// SECTION 2
oSection2:= TRSection():New(oSection,"Verba Extra",/*lLoadCells*/,,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
oSection2:SetHeaderSection():=.F.

TRCell():New(oSection2,"ZZJ_VLRVPC"	  ,"ZZJ","Apuração"	        ,/*Picture*/					,/*Tamanho*/,/*lPixel*/    ,{||  M->ZZM_VLRVER									})
TRCell():New(oSection2,"ZZJ_VLRCLI"	  ,"ZZJ","Cobrado Cliente"          	,/*Picture*/					    ,/*Tamanho*/,/*lPixel*/,{||  M->ZZM_VLRCLI									})
TRCell():New(oSection2,"E1_SALDO"	  ,"ZZJ","Pago"							,/*Picture*/					,/*Tamanho*/,/*lPixel*/	    ,{|| M->E1_SALDO									})
TRCell():New(oSection2,"ZZJ_VLRCLI"	  ,"ZZJ","Pedido Venda"			,/*Picture*/					,/*Tamanho*/,/*lPixel*/	            ,{|| M->ZZM_PVVER									})


// SECTION 4
oTotal 	:= TRSection():New(oSection,"Total Consolidado",,,/*lLoadCells*/,/*lLoadOrder*/,"Total Consolidado",/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
oTotal:SetHeaderSection():=.F.

TRCell():New(oTotal,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
TRCell():New(oTotal,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
TRCell():New(oTotal,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
TRCell():New(oTotal,"TOTAL"		    ,""	,"Total Cobrado Cliente"	,PesqPict("ZZM","ZZM_VLRCLI")		,/*Tamanho*/,/*lPixel*/	,{|| M->TOTAL	})


//oReport:Section(1):SetLineStyle(.F.)
//oReport:Section(1):Section(1):SetLineStyle(.F.)
//oReport:Section(1):Section(2):SetLineStyle(.F.)

//oReport:Section(1):lReadOnly := .T.
//oReport:Section(1):Section(1):lReadOnly := .T.
//oReport:Section(1):Section(2):lReadOnly := .T.

oReport:PrintDialog()

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintAutor  ³Hermes Ferreira     º Data ³  23/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressão do Relatório			 			              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games						                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
Local oSecIni 	:= oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local oSection2 := oReport:Section(1):Section(2)
Local oTotal	 :=oReport:Section(1):Section(3)
Local lFirst	:=.T.

Local nlTamFonte:= oReport:oFontBody:NHEIGHT
Local nlNewTamF	:= 10

Local cCliente	:= ""
Local cLoja		:= ""

Local cTpVpc		:= ""

Local clAliasPV 


// Totalizadores Verba
Local nVerTotRep:= 0
Local nVerTotAct:= 0
Local nVerPerAct:= 0
Local nVerSldAbt:= 0
Local nGeralRel	:= 0

Local cPrfVerba	:= U_MyNewSX6("NCG_PR7102", "VE" ,"C","Prefixo Verba Extra","Prefixo Verba Extra","Prefixo Verba Extra",.F. )
Local cPrfVPC	:= PadR( GetMv("NCG_000016",,"VPC"), TAMSX3( "E1_PREFIXO" )[1] )

// Query Principal
PR712Qry()

(clAlias)->(dbGoTop())
oReport:SetMeter(RecCount())
(clAlias)->(dbGoTop())


While !oReport:Cancel() .AND. (clAlias)->(!Eof())
	
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	cCliente	:= (clAlias)->CLIENTE
	cLoja		:= (clAlias)->LOJA
	M->TOTAL	:= 0

	If  !lFirst .And. mv_par07==1
		oReport:EndPage()
	EndIf
	lFirst:=.F.
	
	Do While (clAlias)->(!Eof()) .And. (clAlias)->(CLIENTE+LOJA)==cCliente+cLoja
		
		If MV_PAR07 <> 1 .or. oReport:nDevice == 4
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		oSecIni:Init()
		oSecIni:PrintLine()
		// VPC
		oSection1:BeginQuery()
		clAliasQry:=GetNextAlias()
		cQuery:=" SELECT SUM(ZZJ_VLRVPC) ZZJ_VLRVPC,Sum(ZZJ_VLRCLI) ZZJ_VLRCLI ,Sum(E1_VALOR-E1_SALDO) E1_SALDO "+CRLF
		cQuery+=" FROM  "+RetSqlName('ZZJ')+" ZZJ "+CRLF
		cQuery+=" LEFT JOIN  "+RetSqlName('SE1')+" SE1 "+CRLF
		cQuery+=" ON E1_FILIAL       ='" +xFilial('SE1')+"'"+CRLF
		cQuery+=" AND SE1.E1_PREFIXO = ZZJ.ZZJ_PREFIX"+CRLF
		cQuery+=" AND SE1.E1_NUM     =ZZJ.ZZJ_TITULO"+CRLF
		cQuery+=" AND SE1.E1_PARCELA =ZZJ.ZZJ_ITEM"+CRLF
		cQuery+=" AND SE1.E1_CLIENTE = ZZJ.ZZJ_CLIENT "+CRLF
		cQuery+=" AND SE1.E1_LOJA    = ZZJ.ZZJ_LOJA"+CRLF
		cQuery+=" AND SE1.E1_TIPO BETWEEN  ' ' And 'Z'"+CRLF
		cQuery+=" AND SE1.D_E_L_E_T_= ' ' "+CRLF		
		cQuery+=" WHERE ZZJ.ZZJ_FILIAL =  '" +xFilial('ZZJ')+"'"+CRLF
		cQuery+=" AND ZZJ.ZZJ_CLIENT = "+___SQLGetValue((clAlias)->CLIENTE)+CRLF
		cQuery+=" AND ZZJ.ZZJ_LOJA  = "+___SQLGetValue((clAlias)->LOJA)+CRLF
		cQuery+=" AND ZZJ.D_E_L_E_T_= ' '"+CRLF

		__execSql(clAliasQry,cQuery,{},.F.)
		oSection1:EndQuery()
		
		M->TOTAL	+=(clAliasQry)->ZZJ_VLRCLI
		If oReport:nDevice <> 4
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		
		oReport:oFontBody:Bold := .T.
		oReport:oFontBody:NHEIGHT:= nlNewTamF
		
		If oReport:nDevice <> 4
			oReport:Say(oReport:Row() ,10,"Contrato VPC",,,)
			oReport:SkipLine()
		Else
			oReport:SkipLine()
			oReport:PrintText("Contrato VPC")
		EndIf
		
		oReport:oFontBody:NHEIGHT := nlTamFonte
		oReport:oFontBody:Bold := .F.
		
		M->C5_YVLVPC:=0
		clAliasPV:=GetNextAlias()
		cQuery:=" Select Sum(C5_YVLVPC) C5_YVLVPC "+CRLF
		cQuery+=" From "+RetSqlName("SC5")+" SC5 "+CRLF
		cQuery+=" Where SC5.C5_FILIAL Between '  ' And 'ZZ'"+CRLF
		cQuery+=" And SC5.C5_CLIENTE= "+___SQLGetValue((clAlias)->CLIENTE)+CRLF
		cQuery+=" And SC5.C5_LOJACLI= "+___SQLGetValue((clAlias)->LOJA)+CRLF
		cQuery+=" And SC5.C5_EMISSAO Between '"+Dtos(mv_par08)+"' And '"+Dtos(mv_par09)+"'"+CRLF
		cQuery+=" And SC5.D_E_L_E_T_=' '"+CRLF
		__execSql(clAliasPV,cQuery,{},.F.)		
		
		M->C5_YVLVPC:=(clAliasPV)->C5_YVLVPC
		
		oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()
		
		
		(clAliasQry)->(dbCloseArea())
		(clAliasPV)->(dbCloseArea()) 
		
		//Verba		
		oSection2:BeginQuery()
		clAliasQry:=GetNextAlias()
		
		cQuery:=" SELECT ZZM_TPVERB,SUM(ZZM_VLRVER) ZZM_VLRVER,Sum(ZZM_VLRCLI) ZZM_VLRCLI ,Sum(E1_VALOR-E1_SALDO) E1_SALDO "+CRLF
		cQuery+=" FROM  "+RetSqlName('ZZM')+" ZZM "+CRLF
		cQuery+=" LEFT JOIN  "+RetSqlName('SE1')+" SE1 "+CRLF
		cQuery+=" ON E1_FILIAL       ='" +xFilial('SE1')+"'"+CRLF
		cQuery+=" AND SE1.E1_PREFIXO = ZZM.ZZM_PREFIX"+CRLF
		cQuery+=" AND SE1.E1_NUM     =ZZM.ZZM_TITULO"+CRLF
		cQuery+=" AND SE1.E1_PARCELA =ZZM.ZZM_ITEM"+CRLF
		cQuery+=" AND SE1.E1_CLIENTE = ZZM.ZZM_CLIENT "+CRLF
		cQuery+=" AND SE1.E1_LOJA    = ZZM.ZZM_LOJA"+CRLF
		cQuery+=" AND SE1.E1_TIPO BETWEEN  ' ' And 'Z'"+CRLF
		cQuery+=" AND SE1.D_E_L_E_T_= ' ' "+CRLF		
		cQuery+=" WHERE ZZM.ZZM_FILIAL =  '" +xFilial('ZZM')+"'"+CRLF
		cQuery+=" AND ZZM.ZZM_CLIENT = "+___SQLGetValue((clAlias)->CLIENTE)+CRLF
		cQuery+=" AND ZZM.ZZM_LOJA  = "+___SQLGetValue((clAlias)->LOJA)+CRLF
		cQuery+=" AND ZZM.D_E_L_E_T_= ' '"+CRLF
		cQuery+=" Group By ZZM_TPVERB"

		__execSql(clAliasQry,cQuery,{},.F.)
		oSection2:EndQuery()
		
		Do While (clAliasQry)->(!Eof())
			If (clAliasQry)->ZZM_TPVERB=="1"			
				M->ZZM_VLRVER :=(clAliasQry)->ZZM_VLRVER
				M->ZZM_VLRCLI :=(clAliasQry)->ZZM_VLRCLI
				M->E1_SALDO   :=(clAliasQry)->E1_SALDO
				M->TOTAL	  +=(clAliasQry)->ZZM_VLRCLI
            Else
				M->ZZM_PVVER :=(clAliasQry)->ZZM_VLRVER
			EndIf
			(clAliasQry)->(DbSkip())		
		EndDo
		
		If oReport:nDevice <> 4
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		oReport:oFontBody:Bold := .T.
		oReport:oFontBody:NHEIGHT:= nlNewTamF
		
		If oReport:nDevice <> 4
			oReport:Say(oReport:Row() ,15,"Verba Extra",,,)
			oReport:SkipLine()
		Else
			oReport:SkipLine()
			oReport:PrintText("Verba Extra")
		EndIf
		
		oReport:oFontBody:NHEIGHT := nlTamFonte
		oReport:oFontBody:Bold := .F.
		
		oSection2:Init()
		oSection2:PrintLine()
		oSection2:Finish()
			
		(clAliasQry)->(dbCloseArea())
		
		oTotal:Init()
		oTotal:PrintLine()
		oTotal:Finish()
			
		(clAlias)->(DbSkip())
		
	EndDo
EndDo



Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR712  ºAutor  ³Microsiga           º Data ³  01/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR712Qry()
Local cQuery := ""

cQuery :="Select Distinct Cliente,Loja,Nome From ("+CRLF
cQuery +=" Select Distinct ZZJ_CLIENT Cliente,ZZJ_LOJA Loja,ZZJ_DESCLI Nome"+CRLF
cQuery +=" From "+RetSqlName("ZZJ")+" ZZJ "+CRLF
cQuery +=" Where ZZJ.ZZJ_FILIAL='"+xFilial("ZZJ")+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_DTAPUR Between '"+Dtos(mv_par01)+"' And '"+Dtos(mv_par02)+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_CLIENT Between '"+mv_par03+"' And '"+mv_par05+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_LOJA   Between '"+mv_par04+"' And '"+mv_par06+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_TIPO='E'"+CRLF
cQuery +=" And ZZJ.D_E_L_E_T_=' '"+CRLF


cQuery +=" Union "+CRLF
cQuery +=" Select Distinct ZZM_CLIENT Cliente,ZZM_LOJA Loja,ZZM_DESCLI Nome"+CRLF
cQuery +=" From "+RetSqlName("ZZM")+" ZZM "+CRLF
cQuery +=" Where ZZM.ZZM_FILIAL='"+xFilial("ZZM")+"'"+CRLF
cQuery +=" And ZZM.ZZM_DTAPUR Between '"+Dtos(mv_par01)+"' And '"+Dtos(mv_par02)+"'"+CRLF
cQuery +=" And ZZM.ZZM_CLIENT Between '"+mv_par03+"' And '"+mv_par05+"'"+CRLF
cQuery +=" And ZZM.ZZM_LOJA   Between '"+mv_par04+"' And '"+mv_par06+"'"+CRLF
cQuery +=" And ZZM.ZZM_TIPO='E'"+CRLF
cQuery +=" And ZZM.D_E_L_E_T_=' '"
cQuery +=")"
cQuery +="Order By Cliente,Loja"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR712  ºAutor  ³Microsiga           º Data ³  01/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCRL1SX1( clPerg )
Local alAreaAtu	:= GetArea()
Local alAux		:= {}

aAdd( alAux, {	"01",;		  					// 01-Ordem da Pergunta (2)
"Da Data Apuracao",;					  					// 02-Descrição em Portugues (30)
"Da Data Apuracao",;				  						// 03-Descrição em Espanhol (30)
"Da Data Apuracao",;				  						// 04-Descrição em Ingles (30)
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
"Da Data Final   						 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Da Data Final   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Da Data Final   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"02",;		  					// 01-Ordem da Pergunta (2)
"Ate Data Apuracao",;					  				// 02-Descrição em Portugues (30)
"Ate Data Apuracao",;				  					// 03-Descrição em Espanhol (30)
"Ate Data Apuracao",;				  					// 04-Descrição em Ingles (30)
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
"",;											// 11-Expressão de Validação da Variável (60)
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
"",;		  									// 11-Expressão de Validação da Variável (60)
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


aAdd( alAux, {	"07",;							// 01-Ordem da Pergunta (2)
"Quebra Página por Cliente",;			  		// 02-Descrição em Portugues (30)
"Quebra Página por Cliente",;	  				// 03-Descrição em Espanhol (30)
"Quebra Página por Cliente",;	  				// 04-Descrição em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variável (6)
"N",;											// 06-Tipo da Variável (1)
1,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"Sim",;											// 20,01-1a. Definição em Portugues (15)
"Sim",;											// 20,02-1a. Definição em Espanhol (15)
"Sim",;											// 20,03-1a. Definição em Ingles (15)
"Não",;											// 20,04-2a. Definição em Portugues (15)
"Não",;											// 20,05-2a. Definição em Espanhol (15)
"Não",;											// 20,06-2a. Definição em Ingles (15)
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
"Quebra pagina por cliente + Loja		 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Quebra pagina por cliente + Loja		 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Quebra pagina por cliente + Loja		 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"08",;		  					// 01-Ordem da Pergunta (2)
"Da Emissao PV",;					  					// 02-Descrição em Portugues (30)
"Da Emissao PV",;				  						// 03-Descrição em Espanhol (30)
"Da Emissao PV",;				  						// 04-Descrição em Ingles (30)
"mv_ch8",;							  			// 05-Nome da Variável (6)
"D",;											// 06-Tipo da Variável (1)
8,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR08",;									// 18-Nome da variável (15)
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
"Da Data Emissao PV   						 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Da Data Emissao PV   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Da Data Emissao PV   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"09",;		  					// 01-Ordem da Pergunta (2)
"Ate Emissao PV",;					  				// 02-Descrição em Portugues (30)
"Ate Emissao PV",;				  					// 03-Descrição em Espanhol (30)
"Ate Emissao PV",;				  					// 04-Descrição em Ingles (30)
"mv_ch9",;							  			// 05-Nome da Variável (6)
"D",;											// 06-Tipo da Variável (1)
8,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR09",;									// 18-Nome da variável (15)
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
"Ate Emissao PV   					 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Ate Emissao PV   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Ate Emissao PV   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )



U_MyNewX1( { clPerg, aClone( alAux ) } )



RestArea( alAreaAtu )

Return()
