#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Fin130Job

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

User function Fin130Job(aDados)

	Default aDados:={"01","03"}
		
	RpcClearEnv()
	RpcSetEnv(aDados[1],aDados[2])

	NcFinR130()
        
	RpcClearEnv()
	
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Fin130mnu

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

User function Fin130Mnu()

	If Processa( { ||NcFinR130()}, "Aguarde...", "Processando relatório...",.F.)
		MsgAlert("Relatório salvo C:\relatorios")
	EndIf
	
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} NcFinR130

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function NcFinR130()

	Local cQry 		:= ""
	Local aAreaSql	:= GetNextAlias()
	
	Local nTotLinhas	:= 0
	Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
	Local cPathRede	:= Alltrim(U_MyNewSX6("NCG_000090","Posição de Cliente","C","Caminho da pasta para a geração do arquivo posição de cliente",,,.F. )   )
	Local cArq 		:= "Posi_Cliente_"+DtoS(MsDate())
	Local cExtExcel	:= ".xml"
	Local nArq
	Local nArq1
	
	Local cDataAtu 	:= DtoS(MsDate())
	Local cDataIni 	:= '20100101'
	Local cDataFim 	:= '20200101'
	Local cText 		:= ""
	Local cCab 		:= ""
	
	Local nDiasVenc 	:= 0
	Local nVlrVenc 	:= 0
	Local nVlrAVen 	:= 0
	
	Local nTotRows 	:= 0
	Local lJob			:= IsInCallStack("U_Fin130Job")
	Local cDirSystem	:= "C:\relatorios\"
	
	cPathRede := StrTran(cPathRede+"\","\\","\")
	
	//nArq  := FCreate(cPathArq + cArq + cExtExcel )
	nArq1  := FCreate(cPathArq + cPathRede + cArq + ".csv" )

	BeginSql Alias aAreaSql

		SELECT A1_COD
		,A1_LOJA
		,A1_NOME
		,A1_NREDUZ
		,A1_CGC
		,E1_PREFIXO ||'-'||E1_NUM||'-'||E1_PARCELA as PR_NUM
		,E1_TIPO
		,E1_EMISSAO
		,E1_VENCTO
		,E1_VENCREA
		,E1_VALOR
		,E1_SALDO+(E1_ACRESC-E1_DECRESC) AS E1_SALDO
		,E1_VENCREA
		,SZ1.Z1_DTENTRE
		,E1_HIST
		,E1_PORTADO||E1_SITUACA as Bco
		,E1_PORTADO
		,A1_YDCANAL
		,A1_VEND
		FROM %table:SE1% SE1
		LEFT OUTER JOIN %table:SA1% SA1
		ON SA1.A1_FILIAL = %xfilial:SA1%
		AND SA1.%notDel%
		AND SA1.A1_COD = SE1.E1_CLIENTE
		AND SA1.A1_LOJA = SE1.E1_LOJA
		LEFT OUTER JOIN %Table:SZ1% SZ1
		ON SZ1.Z1_FILIAL = %xfilial:SZ1%
		AND SZ1.%notDel%
		AND SZ1.Z1_CLIENTE = SE1.E1_CLIENTE
		AND SZ1.Z1_LOJA = SE1.E1_LOJA
		AND SZ1.Z1_DOC = SE1.E1_NUM
		WHERE SE1.E1_FILIAL = %xfilial:SE1%
		AND SE1.%notDel%
		AND SE1.E1_EMISSAO BETWEEN %Exp:cDataIni% AND %Exp:cDataFim%
		AND SE1.E1_SALDO > 0
		AND SE1.E1_TIPO NOT IN ('NCC','RA')
		Union All
		SELECT A1_COD
		,A1_LOJA
		,A1_NOME
		,A1_NREDUZ
		,A1_CGC
		,E1_PREFIXO ||'-'||E1_NUM||'-'||E1_PARCELA as PR_NUM
		,E1_TIPO
		,E1_EMISSAO
		,E1_VENCTO
		,E1_VENCREA
		,E1_VALOR *(-1)
		,(E1_SALDO+(E1_ACRESC-E1_DECRESC)) *(-1) AS E1_SALDO
		,E1_VENCREA
		,SZ1.Z1_DTENTRE
		,E1_HIST
		,E1_PORTADO||E1_SITUACA as Bco
		,E1_PORTADO
		,A1_YDCANAL
		,A1_VEND
		FROM %table:SE1% SE1
		LEFT OUTER JOIN %table:SA1% SA1
		ON SA1.A1_FILIAL = %xfilial:SA1%
		AND SA1.%notDel%
		AND SA1.A1_COD = SE1.E1_CLIENTE
		AND SA1.A1_LOJA = SE1.E1_LOJA
		LEFT OUTER JOIN %Table:SZ1% SZ1
		ON SZ1.Z1_FILIAL = %xfilial:SZ1%
		AND SZ1.%notDel%
		AND SZ1.Z1_CLIENTE = SE1.E1_CLIENTE
		AND SZ1.Z1_LOJA = SE1.E1_LOJA
		AND SZ1.Z1_DOC = SE1.E1_NUM
		WHERE SE1.E1_FILIAL = %xfilial:SE1%
		AND SE1.%notDel%
		AND SE1.E1_EMISSAO BETWEEN %Exp:cDataIni% AND %Exp:cDataFim%
		AND SE1.E1_SALDO > 0
		AND SE1.E1_TIPO IN ('NCC','RA')
	
	EndSql
	
	//(aAreaSql)->( DbGoTop() )
	//(aAreaSql)->( dbEval( { || nTotRows++ },,{ || !Eof() } ) )
	//(aAreaSql)->( DbGoTop() )	
	
	//cHeader := MontHeader()
	cCabec := MontCabec(nTotRows,@cCab)
	//cFooter := MontFoot()
	
	/*-------------------------------------------------------------------------------------//
	// Respónsavel por motar o Xml e gravar o arquivo											//
	//-------------------------------------------------------------------------------------*/
	
	//FWrite(nArq,cHeader + CRLF)
	//FWrite(nArq,cCabec + CRLF)
	
	FWrite(nArq1,cCab + CRLF)

	Do While (aAreaSql)->(!Eof())
		
		If (StoD((aAreaSql)->E1_VENCREA) - MsDate()) < 0
			nDiasVenc := MsDate() - StoD((aAreaSql)->E1_VENCREA)
			nVlrVenc := (aAreaSql)->E1_SALDO
			nVlrAVen := 0
		Else
			nDiasVenc := 0
			nVlrVenc := 0
			nVlrAVen := (aAreaSql)->E1_SALDO
		EndIf
	
//		cText := '		<Row ss:Height="15.75">'+CRLF //Manter tamanho da linha
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->A1_COD +'</Data></Cell>'+CRLF	//Cliente
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->A1_LOJA +'</Data></Cell>'+CRLF	//Loja
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ AllTrim((aAreaSql)->A1_NOME) +'</Data></Cell>'+CRLF	//Razao Social
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ AllTrim((aAreaSql)->A1_NREDUZ) +'</Data></Cell>'+CRLF	//N Fantasia
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->A1_CGC +'</Data></Cell>'+CRLF	//CNPJ/CPF
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->PR_NUM +'</Data></Cell>'+CRLF	//PRF - Num Titulo - Parcela
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->E1_TIPO +'</Data></Cell>'+CRLF	// Tipo
//		cText += '		 <Cell ss:StyleID="s65"><Data ss:Type="DateTime">'+ ConvDateEx((aAreaSql)->E1_EMISSAO) +'</Data></Cell>'+CRLF 	//Dt Emissao
//		cText += '		 <Cell ss:StyleID="s65"><Data ss:Type="DateTime">'+ ConvDateEx((aAreaSql)->E1_VENCREA) +'</Data></Cell>'+CRLF	//Dt Vencto Real
//		cText += '		 <Cell ss:StyleID="s66"><Data ss:Type="Number">'+ Alltrim(Str((aAreaSql)->E1_VALOR)) +'</Data></Cell>'+CRLF	//Valor Original
//		cText += '		 <Cell ss:StyleID="s66"><Data ss:Type="Number">'+ Alltrim(Str(nVlrVenc)) +'</Data></Cell>'+CRLF	//valor Vencido
//		cText += '		 <Cell ss:StyleID="s66"><Data ss:Type="Number">'+ Alltrim(Str(nVlrAVen)) +'</Data></Cell>'+CRLF	//Valor a vencer
//		cText += '		 <Cell ss:StyleID="s67"><Data ss:Type="Number">'+ Alltrim(Str(nDiasVenc)) +'</Data></Cell>'+CRLF	//Dias Atraso
//		cText += '		 <Cell ss:StyleID="s65"><Data ss:Type="DateTime">'+ ConvDateEx((aAreaSql)->Z1_DTENTRE) +'</Data></Cell>'+CRLF 	//Data Entrega
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ Alltrim((aAreaSql)->E1_HIST) +'</Data></Cell>'+CRLF	//Historico
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->Bco +'</Data></Cell>'+CRLF	//Banco - Situação
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->E1_PORTADO +'</Data></Cell>'+CRLF	//Portador
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->A1_YDCANAL +'</Data></Cell>'+CRLF	//Descricao Canal
//		cText += '		 <Cell ss:StyleID="s64"><Data ss:Type="String">'+ (aAreaSql)->A1_VEND +'</Data></Cell>'+CRLF	//Vendedor
//		cText += '		</Row>'+CRLF
		
		cString := "'"+(aAreaSql)->A1_COD+";'"+(aAreaSql)->A1_LOJA+";"+AllTrim((aAreaSql)->A1_NOME)+";"+AllTrim((aAreaSql)->A1_NREDUZ)+";'"+(aAreaSql)->A1_CGC+";"
		cString += (aAreaSql)->PR_NUM +";"+(aAreaSql)->E1_TIPO+";"+ConvDt((aAreaSql)->E1_EMISSAO)+";"+ConvDt((aAreaSql)->E1_VENCTO)+";"+ConvDt((aAreaSql)->E1_VENCREA)+";"+Alltrim(StrTran(Str((aAreaSql)->E1_VALOR),".",","))+";"
		cString += Alltrim(StrTran(Str(nVlrVenc),".",",")) +";"+Alltrim(StrTran(Str(nVlrAVen),".",","))+";"+Alltrim(Str(nDiasVenc))+";"+ConvDt((aAreaSql)->Z1_DTENTRE)+";"+Alltrim(StrTran((aAreaSql)->E1_HIST,";"," "))+";"
		cString += (aAreaSql)->Bco +";"+(aAreaSql)->E1_PORTADO+";"+(aAreaSql)->A1_YDCANAL+";"+(aAreaSql)->A1_VEND
	
		FWrite(nArq1,cString + CRLF)
//		FWrite(nArq,cText + CRLF)
			
		(aAreaSql)->(DbSkip())

	EndDo
		
//	FWrite(nArq,cFooter + CRLF)
	
	
	FClose(nArq1)
//	FClose(nArq)
	(aAreaSql)->(DbCloseArea())

	If !lJob
		MakeDir(cDirSystem + cPathRede)
		
		If CpyS2T(cPathArq + cPathRede + cArq + ".csv",cDirSystem + cPathRede, .f.)
			MsgAlert("Relatório salvo em C:\relatorios")
			//Ferase(cPathArq + cArq + ".csv" )
		EndIf
	EndIf
	
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ConvDateEx

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function ConvDateEx(cDtConv)

	Local aArea 	:= GetArea()
	Local cRet		:= ""

	Default cDtConv := ""

	If !Empty(cDtConv)
		If ValType(cDtConv) == "C"
			cRet := SubStr(cDtConv,1,4)+"-"+SubStr(cDtConv,5,2)+"-"+SubStr(cDtConv,7,2)
			cRet := cRet +"T00:00:00.000"
		Else
			cRet := ""
		EndIf
	Else
		cRet := ""
	EndIf

	RestArea(aArea)
Return cRet

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ConvDt

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function ConvDt(cDtConv)

	Local aArea 	:= GetArea()
	Local cRet		:= ""

	Default cDtConv := ""

	If !Empty(cDtConv)
		If ValType(cDtConv) == "C"
			cRet := SubStr(cDtConv,7,2)+"/"+SubStr(cDtConv,5,2)+"/"+SubStr(cDtConv,1,4)
		Else
			cRet := ""
		EndIf
	Else
		cRet := ""
	EndIf

	RestArea(aArea)
Return cRet

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} MontHeader

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function MontHeader()

	Local cText := ""

	cText += '<?xml version="1.0"?>'+CRLF
	cText += '<?mso-application progid="Excel.Sheet"?>'+CRLF
	cText += '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
	cText += ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF
	cText += ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF
	cText += ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
	cText += ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
	cText += ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
	cText += '  <Author>Lucas Felipe</Author>'+CRLF
	cText += '  <LastAuthor>Lucas Felipe</LastAuthor>'+CRLF
	cText += '  <Created>2016-05-18T15:13:33Z</Created>'+CRLF
	cText += '  <Version>15.00</Version>'+CRLF
	cText += ' </DocumentProperties>'+CRLF
	cText += ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
	cText += '  <AllowPNG/>'+CRLF
	cText += ' </OfficeDocumentSettings>'+CRLF
	cText += ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cText += '  <WindowHeight>9735</WindowHeight>'+CRLF
	cText += '  <WindowWidth>24000</WindowWidth>'+CRLF
	cText += '  <WindowTopX>0</WindowTopX>'+CRLF
	cText += '  <WindowTopY>0</WindowTopY>'+CRLF
	cText += '  <ProtectStructure>False</ProtectStructure>'+CRLF
	cText += '  <ProtectWindows>False</ProtectWindows>'+CRLF
	cText += ' </ExcelWorkbook>'+CRLF
	cText += ' <Styles>'+CRLF
	cText += '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF
	cText += '   <Alignment ss:Vertical="Bottom"/>'+CRLF
	cText += '   <Borders/>'+CRLF
	cText += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cText += '   <Interior/>'+CRLF
	cText += '   <NumberFormat/>'+CRLF
	cText += '   <Protection/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s16" ss:Name="Vírgula">'+CRLF
	cText += '   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s62">'+CRLF
	cText += '   <Borders>'+CRLF
	cText += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="3"/>'+CRLF
	cText += '   </Borders>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s63" ss:Parent="s16">'+CRLF
	cText += '   <Borders>'+CRLF
	cText += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="3"/>'+CRLF
	cText += '   </Borders>'+CRLF
	cText += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s64">'+CRLF
	cText += '   <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>'+CRLF
	cText += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s65">'+CRLF
	cText += '   <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>'+CRLF
	cText += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cText += '   <NumberFormat ss:Format="Short Date"/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s66" ss:Parent="s16">'+CRLF
	cText += '   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+CRLF
	cText += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += '  <Style ss:ID="s67">'+CRLF
	cText += '   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+CRLF
	cText += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cText += '   <NumberFormat ss:Format="Fixed"/>'+CRLF
	cText += '  </Style>'+CRLF
	cText += ' </Styles>'+CRLF

Return cText

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} MontCabec

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function MontCabec(nTotRows,cCab)

	Local aColumns	:= {}
	Local cColumns 	:= ""
	Local cRows		:= ""
	Local cText		:= ""
	Local nI

	Default nTotRows := 0
	Default cCab := ""

	aAdd( aColumns, "Codigo")
	aAdd( aColumns, "Loja")
	aAdd( aColumns, "Nome")
	aAdd( aColumns, "N_Fantasia")
	aAdd( aColumns, "CNPJ_CPF")
	aAdd( aColumns, "Prf_Numero_Parc")
	aAdd( aColumns, "Tipo")
	aAdd( aColumns, "Dt_Emissao")
	aAdd( aColumns, "Dt_Vencimento")
	aAdd( aColumns, "Vencto_Real")
	aAdd( aColumns, "Valor_Original")
	aAdd( aColumns, "Vl_Vencido")
	aAdd( aColumns, "Vl_a_Vencer")
	aAdd( aColumns, "Dias_Atraso")
	aAdd( aColumns, "Dt_Entrega")
	aAdd( aColumns, "Historico")
	aAdd( aColumns, "Bco_Situacao")
	aAdd( aColumns, "Portador")
	aAdd( aColumns, "Descri_Canal")
	aAdd( aColumns, "Vendedor")

	For nI:=1 to Len(aColumns)

		cColumns 	+= '		<Column ss:Width="70"/>'+CRLF
		cRows		+= '		<Cell ss:StyleID="s62"><Data ss:Type="String">'+aColumns[nI]+'</Data></Cell>'+CRLF
		cCab += aColumns[nI] + ";"

	Next nI

	cText += '<Worksheet ss:Name="Plan1">'+CRLF
	cText += '<Table ss:ExpandedColumnCount="'+AllTrim(Str(Len(aColumns)))+'" ss:ExpandedRowCount="'+AllTrim(Str(nTotRows+1))+'" x:FullColumns="1"  x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF

	cText += cColumns
	cText += '	<Row ss:Height="15.75">'+CRLF
	cText += cRows
	cText += '	</Row>'+CRLF

Return cText

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} MontFoot

@author    Lucas Felipe
@version   1.xx
@since     18/05/2016
/*/
//------------------------------------------------------------------------------------------

Static Function MontFoot()

	Local cText := ""

	cText += ' </Table>'+CRLF
	cText += '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cText += '   <PageSetup>'+CRLF
	cText += '    <Header x:Margin="0.31496062000000002"/>'+CRLF
	cText += '    <Footer x:Margin="0.31496062000000002"/>'+CRLF
	cText += '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
	cText += '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
	cText += '   </PageSetup>'+CRLF
	cText += '   <Selected/>'+CRLF
	cText += '   <Panes>'+CRLF
	cText += '    <Pane>'+CRLF
	cText += '     <Number>3</Number>'+CRLF
	cText += '     <ActiveRow>6</ActiveRow>'+CRLF
	cText += '     <ActiveCol>2</ActiveCol>'+CRLF
	cText += '    </Pane>'+CRLF
	cText += '   </Panes>'+CRLF
	cText += '   <ProtectObjects>False</ProtectObjects>'+CRLF
	cText += '   <ProtectScenarios>False</ProtectScenarios>'+CRLF
	cText += '  </WorksheetOptions>'+CRLF
	cText += ' </Worksheet>'+CRLF
	cText += '</Workbook>'+CRLF

Return cText
