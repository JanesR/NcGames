#Include 'Protheus.ch'

User Function NcVtex10()

	Local oReport

	oReport := ReportDef()
	oReport:PrintDialog()

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

@author    Lucas Felipe
@version   1.xx
@since     23/05/2016
/*/
//------------------------------------------------------------------------------------------
Static Function ReportDef()

	Local oReport
	Local oSection
	Local cTitle 		:=  "Tabela de preços CON/CDE"
	Local cRelDesc	:=	"Tabela de preços CON/CDE"
	Local aAreaSql 	:= GetNextAlias()

	
	oReport := TReport():New("VTEX10RL",cTitle,"VTEX10RL",{|oReport| PrintReport(oReport,aAreaSql)},cRelDesc)
	
	oReport:SetLandscape()
	oReport:SetTotalInLine(.F.)
	
	oSection := TRSection():New(oReport,cTitle,{"DA1"})
	
	//TRCell():New( < oParent>, < cName>, [ cAlias], [ cTitle], [ cPicture], [ nSize], [ lPixel], [ bBlock] )
	
	TRCell():New(oSection,"CODPRO"	,aAreaSql	,"Produto"		,"@!"		,16	)
	TRCell():New(oSection,"DESCR"	,aAreaSql	,"Descrição"	,"@!"		,100	)
	TRCell():New(oSection,"CON" 	,aAreaSql	,"Tab_Con"		,"@E 999,999.99"	,10	)
	TRCell():New(oSection,"CDE"		,aAreaSql	,"Tab_De"		,"@E 999,999.99"	,10 )
		
	//³ Alinhamento a direita as colunas de valor
	oSection:Cell("CON"):SetHeaderAlign("RIGHT")
	oSection:Cell("CDE"):SetHeaderAlign("RIGHT")
	

Return oReport


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author    Lucas Felipe
@version   1.xx
@since     23/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function PrintReport(oReport,aAreaSql)

	Local oSection	:= oReport:Section(1)
	Local cTabDe		:= "CDE"
	Local cTabPor		:= "CON"

	Default aAreaSql	:= GetNextAlias()	
	
	BeginSql alias aAreaSql
		
		SELECT DA1.DA1_CODPRO AS CODPRO,
		SB1.B1_XDESC AS DESCR,
		DA1.DA1_PRCVEN AS CON,
		DA2.DA1_PRCVEN AS CDE
		FROM DA1010 DA1
			
		LEFT OUTER JOIN DA1010 DA2
		ON DA2.DA1_FILIAL = %xfilial:DA1%
		AND DA2.DA1_CODTAB = %Exp:cTabDe%
		AND DA2.DA1_CODPRO = DA1.DA1_CODPRO
		AND DA2.%notDel%
			
		INNER JOIN SB1010 SB1
		ON SB1.B1_FILIAL = %xfilial:SB1%
		AND SB1.B1_COD = DA1.DA1_CODPRO
		AND SB1.%notDel%
			
		WHERE DA1.DA1_FILIAL = %xfilial:DA1%
		AND DA1.DA1_CODTAB = %Exp:cTabPor%
		AND DA1.%notDel%
		              
	EndSql
	
	oReport:SetMeter((aAreaSql)->(LastRec()))
	
	//oReport:ThinLine() 
	//oSection:Init()
	
	While (aAreaSql)->(!Eof())
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oSection:Init()
				
		oSection:Cell("CODPRO"):SetValue((aAreaSql)->CODPRO)
		oSection:Cell("DESCR"):SetValue((aAreaSql)->DESCR)
		oSection:Cell("CON"):SetValue((aAreaSql)->CON)
		oSection:Cell("CDE"):SetValue((aAreaSql)->CDE)

		oSection:PrintLine()
		oReport:SkipLine()
		
		DbSelectArea(aAreaSql)
		(aAreaSql)->(DbSkip())
		
	End
	 
	oSection:Finish()
	oReport:IncMeter()
	

Return

