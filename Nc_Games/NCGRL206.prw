#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE CRLF Chr(13)+Chr(10)

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ NCGRL206  ∫Autor  ≥                    ∫ Data ≥  21/08/13  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥  Processamento do relatÛrio de batimento de saldos entre   ∫±±
±±∫          ≥  WMS x Protheus                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

User Function NCGRL206(lJob,cEmp,cFil)


If MsgYesNo("Deseja processar o relatorio de batimento de saldos entre WMS X Protheus?","NcGames")
	//Processa({|| RL206PROC(lJob,cEmp,cFil) },"Processando relatÛrio...")
	Processa({|| RL001PROCF(lJob,cEmp,cFil) },"Processando relatÛrio...")
EndIf	

Return

/*---------------------------------------------------------------------------
//
//
//--------------------------------------------------------------------------*/

Static Function RL206PROC(lJob,cEmp,cFil)

Local cQryPro	:= ""
Local cQryWMS	:= ""
Local aArea		:= GetArea()
Local cAliasPRO	:= GetNextAlias()
Local cAliasWMS	:= GetNextAlias()
Local aSaldos	:= {}
Local cXML		:= ""
Local cNomArq	:= "Batimento_WMS_"+DtoS(MsDate())+STRTRAN(Time(), ":", "")
Local nCont		:= 2
Local cArmz	:= SuperGetMV("MV_ARMWMAS",.F.,'01')
Local lCalcEst:=.F.
Local dDtEstq

Private nHdl
Private cPathExcel  := "C:\relatorios\"
Private cExtExcel   := ".xml"
Private cPathArq:=StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Private cArqXls:=E_Create(,.F.)

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'
//lJob	:= .T.
nHdl := FCreate(cPathArq+cArqXls+cExtExcel)

If lJob
	RpcSetType(3)
	If !RpcSetEnv(cEmp,cFil)
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		Return()
	EndIf
EndIF

clUsrBD	:= "WMS" //SuperGetMV("NCG_000019")

Conout("Iniciando a geraÁ„o do relatÛrio de batimento de saldos WMS Inovatech x Protheus "+time())

If MsDate()<>dDataBase
	lCalcEst:=.T.
	dDtEstq:=dDataBase
EndIf	



cQry	:= " SELECT COUNT(*) QTD FROM "+RetSqlName("SB2")+" WHERE D_E_L_E_T_ = ' ' AND B2_QATU > 0 AND B2_FILIAL = '"+xFilial("SB2")+"' AND B2_LOCAL IN "+FORMATIN(cArmz,"/")
Iif(Select(cAliasPRO) > 0,(cAliasPRO)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasPRO,.F.,.T.)
While (cAliasPRO)->(!eof())
	nCont += (cAliasPRO)->QTD*2
	(cAliasPRO)->(dbskip())
End

cQry	:= " SELECT COUNT(*) QTD
cQry	+= " FROM "+clUsrBD+".VIW_RPT_SALDOS_PRODUTO WHERE DESC_TIPO_CASULO <> 'EXPEDICAO' "
cQry	+= " AND PARCEIRO = "+alltrim(str(val(xFilial("SB2"))))


Iif(Select(cAliasPRO) > 0,(cAliasPRO)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasPRO,.F.,.T.)
While (cAliasPRO)->(!eof())
	nCont += (cAliasPRO)->QTD*2
	(cAliasPRO)->(dbskip())
End

ProcRegua(nCont)


cQryPRO	:= " SELECT B2_COD, B1_XDESC, B2_LOCAL, B2_QATU, B1_TIPO
cQryPRO	+= " FROM "+RetSqlName("SB2")+" A, "+RetSqlName("SB1")+" B
cQryPRO	+= " WHERE A.D_E_L_E_T_ = ' '  AND B.D_E_L_E_T_ = ' '
cQryPRO	+= " AND B.B1_FILIAL = '"+xFilial("SB1")+"'
cQryPRO	+= " AND A.B2_FILIAL = '"+xFilial("SB2")+"'
cQryPRO	+= " AND A.B2_COD = B.B1_COD
cQryPRO	+= " AND A.B2_QATU > 0 "
cQryPRO	+= " AND B2_LOCAL IN "+FORMATIN(cArmz,"/")
Iif(Select(cAliasPRO) > 0,(cAliasPRO)->(dbCloseArea()),Nil)


DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryPRO),cAliasPRO,.F.,.T.)
While (cAliasPRO)->(!EOF())
	incproc("Processando dados do Protheus...")   
	                                                                  
	nSaldoAtu:=(cAliasPRO)->B2_QATU
	
	If lCalcEst	                                                           
		SB2->(DbSeek(xFilial("SB2")+(cAliasPRO)->B2_COD+(cAliasPRO)->B2_LOCAL))	
		aSaldo    := CalcEst((cAliasPRO)->B2_COD,(cAliasPRO)->B2_LOCAL,dDtEstq+1)
		nSaldoAtu:=aSaldo[1]
	EndIf	
	
	aadd(aSaldos,{ (cAliasPRO)->B2_COD,(cAliasPRO)->B2_LOCAL,nSaldoAtu,0 ,0,(cAliasPRO)->B1_XDESC,(cAliasPRO)->B1_TIPO} )
	
	(cAliasPRO)->(dbskip())
End
(cAliasPRO)->(dbclosearea())
//quantidade no wms fora expediÁ„o
cQryWMS	:= " SELECT PRODUTO, COD_TIPO_ESTOQUE, SUM(QTDE_TOTAL) QTDE "
cQryWMS	+= " FROM "+clUsrBD+".VIW_RPT_SALDOS_PRODUTO WHERE DESC_TIPO_CASULO <> 'EXPEDICAO' "
cQryWMS	+= " AND PARCEIRO = "+alltrim(str(val(xFilial("SB2"))))
cQryWMS	+= " AND COD_TIPO_ESTOQUE<>0"
cQryWMS	+= " GROUP BY PRODUTO, COD_TIPO_ESTOQUE "

Iif(Select(cAliasWMS) > 0,(cAliasWMS)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryWMS),cAliasWMS,.F.,.T.)

DbSelectArea("SB1")
DbSetOrder(1)
While (cAliasWMS)->(!EOF())
	incproc("Processando dados do WMS Inovatech...")
	cTipoEst	:= strzero((cAliasWMS)->COD_TIPO_ESTOQUE,2)
	If (nPos := Ascan( aSaldos, { |x| padr((cAliasWMS)->PRODUTO,15)+cTipoEst $ x[1]+x[2] } ) ) == 0
		If DbSeek(xFilial("SB1")+padr((cAliasWMS)->PRODUTO,15))
			aadd(aSaldos,{ (cAliasWMS)->PRODUTO,cTipoEst,0,(cAliasWMS)->QTDE ,0,SB1->B1_XDESC,SB1->B1_TIPO} )
		Else
			aadd(aSaldos,{ (cAliasWMS)->PRODUTO,cTipoEst,0,(cAliasWMS)->QTDE ,0,"DescriÁ„o n„o encontrada no Protheus"," "} )
		EndIf
	Else
		aSaldos[nPos,4] += (cAliasWMS)->QTDE
	EndIf
	(cAliasWMS)->(dbskip())
End
(cAliasWMS)->(dbclosearea())


//quantidade no wms em expediÁ„o
cQryWMS	:= " SELECT PRODUTO, COD_TIPO_ESTOQUE, SUM(QTDE_TOTAL) QTDE "
cQryWMS	+= " FROM "+clUsrBD+".VIW_RPT_SALDOS_PRODUTO WHERE DESC_TIPO_CASULO = 'EXPEDICAO' "
cQryWMS	+= " AND PARCEIRO = "+alltrim(str(val(xFilial("SB2"))))
cQryWMS	+= " AND COD_TIPO_ESTOQUE<>0"

cQryWMS	+= " GROUP BY PRODUTO, COD_TIPO_ESTOQUE "
Iif(Select(cAliasWMS) > 0,(cAliasWMS)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryWMS),cAliasWMS,.F.,.T.)

DbSelectArea("SB1")
DbSetOrder(1)
While (cAliasWMS)->(!EOF())
	incproc("Processando dados do WMS Inovatech...")
	cTipoEst	:= strzero((cAliasWMS)->COD_TIPO_ESTOQUE,2)
	If (nPos := Ascan( aSaldos, { |x| padr((cAliasWMS)->PRODUTO,15)+cTipoEst $ x[1]+x[2] } ) ) == 0
		If DbSeek(xFilial("SB1")+padr((cAliasWMS)->PRODUTO,15))
			aadd(aSaldos,{ (cAliasWMS)->PRODUTO,cTipoEst,0,0 ,(cAliasWMS)->QTDE,SB1->B1_XDESC,SB1->B1_TIPO} )
		Else
			aadd(aSaldos,{ (cAliasWMS)->PRODUTO,cTipoEst,0,0 ,(cAliasWMS)->QTDE,"DescriÁ„o n„o encontrada no Protheus"," "} )
		EndIf
	Else
		aSaldos[nPos,5] += (cAliasWMS)->QTDE
	EndIf
	(cAliasWMS)->(dbskip())
End
(cAliasWMS)->(dbclosearea())

aSaldos	:= aSort(aSaldos,,,{|x,y| x[1]+x[2]<y[1]+y[1]})


cXML	+= '<?xml version="1.0"?>'+CRLF
cXML	+= '<?mso-application progid="Excel.Sheet"?>'+CRLF
cXML	+= '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cXML	+= ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF
cXML	+= ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF
cXML	+= ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cXML	+= ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
cXML	+= ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cXML	+= '  <Author>Protheus</Author>'+CRLF
cXML	+= '  <LastAuthor>Protheus</LastAuthor>'+CRLF
cXML	+= '  <Created>2013-08-21T16:51:10Z</Created>'+CRLF
cXML	+= '  <Version>14.00</Version>'+CRLF
cXML	+= ' </DocumentProperties>'+CRLF
cXML	+= ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cXML	+= '  <AllowPNG/>'+CRLF
cXML	+= ' </OfficeDocumentSettings>'+CRLF
cXML	+= ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cXML	+= '  <WindowHeight>5190</WindowHeight>'+CRLF
cXML	+= '  <WindowWidth>10515</WindowWidth>'+CRLF
cXML	+= '  <WindowTopX>480</WindowTopX>'+CRLF
cXML	+= '  <WindowTopY>135</WindowTopY>'+CRLF
cXML	+= '  <ProtectStructure>False</ProtectStructure>'+CRLF
cXML	+= '  <ProtectWindows>False</ProtectWindows>'+CRLF
cXML	+= ' </ExcelWorkbook>'+CRLF    
cXML	+= ' <Styles>'+CRLF
cXML	+= '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF
cXML	+= '   <Alignment ss:Vertical="Bottom"/>'+CRLF
cXML	+= '   <Borders/>'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
cXML	+= '   <Interior/>'+CRLF
cXML	+= '   <NumberFormat/>'+CRLF
cXML	+= '   <Protection/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s62">'+CRLF
cXML	+= '   <NumberFormat ss:Format="@"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s63">'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cXML	+= '    ss:Bold="1"/>'+CRLF
cXML	+= '   <NumberFormat ss:Format="@"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s64">'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cXML	+= '    ss:Bold="1"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s71">'+CRLF
cXML	+= '   <NumberFormat ss:Format="#,##0"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s72">'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cXML	+= '    ss:Bold="1"/>'+CRLF
cXML	+= '   <NumberFormat ss:Format="#,##0"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= ' </Styles>'+CRLF
cXML	+= ' <Worksheet ss:Name="Batimento WMS">'+CRLF
cXML	+= '  <Table ss:ExpandedColumnCount="10" ss:ExpandedRowCount="999999" x:FullColumns="1"'+CRLF
cXML	+= '   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF
cXML	+= '   <Column ss:StyleID="s62" ss:Width="27.75"/>'+CRLF
cXML	+= '   <Column ss:StyleID="s62" ss:Width="74.25"/>'+CRLF
cXML	+= '   <Column ss:Width="174"/>'+CRLF
cXML	+= '   <Column ss:Width="25.5"/>'+CRLF
cXML	+= '   <Column ss:StyleID="s62" ss:Width="28.5"/>'+CRLF
cXML	+= '   <Column ss:Width="48.75"/>'+CRLF
cXML	+= '   <Column ss:Width="66.75"/>'+CRLF
cXML	+= '   <Column ss:Width="50.25"/>'+CRLF
cXML	+= '   <Row ss:AutoFitHeight="0">'+CRLF
cXML	+= '    <Cell ss:StyleID="s63"><Data ss:Type="String">Filial</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s63"><Data ss:Type="String">Produto</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Descri√ß√£o</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Tipo</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s63"><Data ss:Type="String">Local</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Qtd Protheus</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Qtd WMS</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Diferenca</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">WMS em Expedicao</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Total WMS</Data></Cell>'+CRLF
cXML	+= '   </Row>'+CRLF
RL206Write(@cXML)

cFil	:= xFilial("SB2")
For nx:=1 to len(aSaldos)
	//aadd(aSaldos,{ (cAliasPRO)->B2_COD,(cAliasPRO)->B2_LOCAL,(cAliasPRO)->B2_QATU,0 ,(cAliasPRO)->B1_XDESC,(cAliasPRO)->B1_TIPO} )
	incproc("Gravando dados na planilha...")
	
	cXML	+= '   <Row ss:AutoFitHeight="0">'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+cFil+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+alltrim(aSaldos[nx,1])+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+FwNoAccent(alltrim(aSaldos[nx,6]))+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+aSaldos[nx,7]+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+aSaldos[nx,2]+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,3]))+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,4]))+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71" ss:Formula="=RC[-2]-RC[-1]"><Data ss:Type="Number"></Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,5]))+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71" ss:Formula="=RC[-3]+RC[-1]"><Data ss:Type="Number"></Data></Cell>'+CRLF
	cXML	+= '   </Row>'+CRLF
	RL206Write(@cXML)
	
Next nx
//Totais
cXML	+= '   <Row ss:AutoFitHeight="0">'+CRLF
cXML	+= '    <Cell ss:Index="2" ss:StyleID="s63"><Data ss:Type="String">Totais</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:Index="6" ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data'+CRLF
cXML	+= '      ss:Type="Number">11</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">21</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '   </Row>'+CRLF
cXML	+= '  </Table>'+CRLF
cXML	+= '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cXML	+= '   <PageSetup>'+CRLF
cXML	+= '    <Header x:Margin="0.31496062000000002"/>'+CRLF
cXML	+= '    <Footer x:Margin="0.31496062000000002"/>'+CRLF
cXML	+= '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
cXML	+= '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
cXML	+= '   </PageSetup>'+CRLF
cXML	+= '   <Unsynced/>'+CRLF
cXML	+= '   <Print>'+CRLF
cXML	+= '    <ValidPrinterInfo/>'+CRLF
cXML	+= '    <HorizontalResolution>600</HorizontalResolution>'+CRLF
cXML	+= '    <VerticalResolution>600</VerticalResolution>'+CRLF
cXML	+= '   </Print>'+CRLF
cXML	+= '   <Selected/>'+CRLF
cXML	+= '   <Panes>'+CRLF
cXML	+= '    <Pane>'+CRLF
cXML	+= '     <Number>3</Number>'+CRLF
cXML	+= '     <ActiveRow>3</ActiveRow>'+CRLF
cXML	+= '     <ActiveCol>3</ActiveCol>'+CRLF
cXML	+= '    </Pane>'+CRLF
cXML	+= '   </Panes>'+CRLF
cXML	+= '   <ProtectObjects>False</ProtectObjects>'+CRLF
cXML	+= '   <ProtectScenarios>False</ProtectScenarios>'+CRLF
cXML	+= '  </WorksheetOptions>'+CRLF
cXML	+= ' </Worksheet>'+CRLF
cXML	+= '</Workbook>'+CRLF
cXML	+= ''+CRLF
RL206Write(@cXML)

FClose(nHdl)

If __CopyFile(cPathArq+cArqXls+cExtExcel, cPathExcel+cArqXls)
	Ferase(cPathArq+cArqXls)
	fRename( cPathExcel+cArqXls, cPathExcel+cNomArq+cExtExcel )
	If !lJob
		If !ApOleCliente( "MsExcel" )
			MsgStop( "Microsoft Excel n„o Instalado... Contate o Administrador do Sistema!" )
		Else
			If MsgYesNo("Abrir o Microsoft Excel?")
				oExcelApp:=MsExcel():New()
				oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
				oExcelApp:SetVisible( .T. )
				oExcelApp:Destroy()
			EndIf
		EndIf
	EndIf
	
EndIf

Conout("Finalizada a geraÁ„o do relatÛrio de batimento de saldos WMS Inovatech x Protheus "+time())

RestArea(aArea)

Return


//Grava no arquivo
Static Function RL206Write(cXML)

FWrite(nHdl,cXML,Len(cXML))
cXML	:= ""

Return

/*------------------------------------------------------------------------------------
//
//
//----------------------------------------------------------------------------------*/

Static function RL001PROCF(lJob,cEmp,cFil)

Local cQuery    :=""
Local aArea		:= GetNextAlias()
Local cAliasPRO	:= GetNextAlias()
Local aSaldos	:= {}
Local cXML		:= ""
Local cNomArq	:= "Batimento_WMS_"+DtoS(MsDate())+STRTRAN(Time(), ":", "")
Local nCont		:= 2
Local cArmz	:= SuperGetMV("MV_ARMWMAS",.F.,'01')
Local lCalcEst:=.F.
Local dDtEstq

Private nHdl
Private cPathExcel  := "C:\relatorios\"
Private cExtExcel   := ".xml"
Private cPathArq:=StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Private cArqXls:=E_Create(,.F.)

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'
//lJob	:= .T.
nHdl := FCreate(cPathArq+cArqXls+cExtExcel)

If lJob
	RpcSetType(3)
	If !RpcSetEnv(cEmp,cFil)
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		Return()
	EndIf
EndIF

clUsrBD	:= "WMS" //SuperGetMV("NCG_000019")

Conout("Iniciando a geraÁ„o do relatÛrio de batimento de saldos WMS Inovatech x Protheus "+time())

If MsDate()<>dDataBase
	lCalcEst:=.T.
	dDtEstq:=dDataBase
EndIf	

//Verifica a quatidade de registros na B2
cQry	:= " SELECT COUNT(*) QTD FROM "+RetSqlName("SB2")+" WHERE D_E_L_E_T_ = ' ' AND B2_QATU > 0 AND B2_FILIAL = '"+xFilial("SB2")+"' AND B2_LOCAL IN "+FORMATIN(cArmz,"/")
Iif(Select(cAliasPRO) > 0,(cAliasPRO)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasPRO,.F.,.T.)
While (cAliasPRO)->(!eof())
	nCont += (cAliasPRO)->QTD*2
	(cAliasPRO)->(dbskip())
End

ProcRegua(nCont)

cQuery :='SELECT  '
cQuery +='trim(PROTHEUS.CODIGO_PROTHEUS) "PRODUTO", '
cQuery +='PROTHEUS.DESC_PROTHEUS "DESCRICAO", '
cQuery +='PROTHEUS.TIPO, '
cQuery +='trim(PROTHEUS.ARM_PROTHEUS) "ARMAZEM", '
cQuery +='PROTHEUS.QTD_PROTHEUS "SALDO_PROTHEUS", '
cQuery +='CASE WHEN '
cQuery +='WMS_NORMAL.QTD_WMS IS NULL THEN 0 '
cQuery +='ELSE WMS_NORMAL.QTD_WMS '
cQuery +='END "SALDO_WMS", '
       
cQuery +='CASE WHEN '
cQuery +='PROTHEUS.QTD_PROTHEUS - WMS_NORMAL.QTD_WMS IS NULL THEN trim(PROTHEUS.QTD_PROTHEUS) - 0 ' 
cQuery +='ELSE trim(PROTHEUS.QTD_PROTHEUS) - trim(WMS_NORMAL.QTD_WMS) '
cQuery +='END  "DIVERGENCIA", '

cQuery +='CASE WHEN WMS_EXPEDICAO.QTD_WMS_EXPEDICAO IS NULL THEN 0 '
cQuery +='ELSE WMS_EXPEDICAO.QTD_WMS_EXPEDICAO '
cQuery +='END "WMS_EM_EXPEDICAO", '
       
cQuery +='CASE '
cQuery +='WHEN WMS_NORMAL.QTD_WMS IS NULL AND WMS_EXPEDICAO.QTD_WMS_EXPEDICAO IS NULL THEN 0 '
cQuery +='WHEN WMS_NORMAL.QTD_WMS IS NULL AND WMS_EXPEDICAO.QTD_WMS_EXPEDICAO IS NOT NULL THEN WMS_EXPEDICAO.QTD_WMS_EXPEDICAO '
cQuery +='WHEN WMS_NORMAL.QTD_WMS IS NOT NULL AND WMS_EXPEDICAO.QTD_WMS_EXPEDICAO IS NULL THEN WMS_NORMAL.QTD_WMS '
cQuery +='ELSE WMS_NORMAL.QTD_WMS+WMS_EXPEDICAO.QTD_WMS_EXPEDICAO '
cQuery +='END "TOTAL_WMS", '
       
cQuery +='CASE WHEN '
cQuery +='WMS_RECEBIMENTO.QTD_WMS_RECEBIMENTO IS NULL ' 
cQuery +='THEN 0 '
cQuery +='ELSE WMS_RECEBIMENTO.QTD_WMS_RECEBIMENTO '
cQuery +='END "QUANTIDADE_EM_RECEBIMENTO" '
cQuery +='FROM '
cQuery +='( '
cQuery +='select trim(B2_COD) "CODIGO_PROTHEUS", '
cQuery +='      TRIM(B1_XDESC) "DESC_PROTHEUS", '
cQuery +='       trim(B2_LOCAL) "ARM_PROTHEUS", '
cQuery +='       TRIM(B2_QATU) "QTD_PROTHEUS" , '
cQuery +='       TRIM(B1_TIPO) "TIPO" '
cQuery +='       from '+RetSqlName("SB2")+' B2 '
cQuery +='       LEFT JOIN '+RetSqlName("SB1")+' B1 '
cQuery +='       ON B2.B2_COD = B1.B1_COD '
cQuery +='WHERE B2.B2_FILIAL='+xFilial("SB2")+' '
cQuery +="AND B2.D_E_L_E_T_=' ' "
cQuery +="AND B1.D_E_L_E_T_=' ' " 
cQuery +='AND B2_LOCAL in '+FORMATIN(cArmz,"/")+' '
cQuery +="AND B2_COD <> ' ' "
cQuery +='GROUP BY B2.B2_COD,B1.B1_XDESC,B2.B2_LOCAL,B2.B2_QATU,B1.B1_TIPO '
cQuery +=')PROTHEUS '
cQuery +='LEFT JOIN '
cQuery +='( '
cQuery +='SELECT PRODUTO "CODIGO_WMS", ' 
cQuery +='       to_number(COD_TIPO_ESTOQUE) "ARM_WMS", ' 
cQuery +='       sum(QTDE_TOTAL) "QTD_WMS" '
cQuery +='FROM WMS.VIW_RPT_SALDOS_PRODUTO '
cQuery +="WHERE DESC_TIPO_CASULO<>'EXPEDICAO' "
cQuery +='AND PARCEIRO = 3 '
cQuery +='GROUP BY PRODUTO, COD_TIPO_ESTOQUE '
cQuery +=')WMS_NORMAL '
cQuery +='  ON TRIM(PROTHEUS.CODIGO_PROTHEUS) = TRIM(WMS_NORMAL.CODIGO_WMS) '
cQuery +='  AND trim(to_number(PROTHEUS.ARM_PROTHEUS)) = trim(WMS_NORMAL.ARM_WMS) '
cQuery +='LEFT JOIN '
cQuery +='( '
cQuery +='SELECT PRODUTO "CODIGO_WMS_EXPEDICAO", ' 
cQuery +='         to_number(COD_TIPO_ESTOQUE) "ARM_WMS_EXPEDICAO", ' 
cQuery +='         SUM(QTDE_TOTAL) "QTD_WMS_EXPEDICAO" '
cQuery +='FROM WMS.VIW_RPT_SALDOS_PRODUTO '
cQuery +="WHERE DESC_TIPO_CASULO = 'EXPEDICAO' "
cQuery +='AND PARCEIRO = 3 '
cQuery +='GROUP BY PRODUTO, COD_TIPO_ESTOQUE '
cQuery +=')WMS_EXPEDICAO '
cQuery +='ON TRIM(PROTHEUS.CODIGO_PROTHEUS) = WMS_EXPEDICAO.CODIGO_WMS_EXPEDICAO '
cQuery +='AND trim(to_number(PROTHEUS.ARM_PROTHEUS)) = trim(WMS_EXPEDICAO.ARM_WMS_EXPEDICAO) '
cQuery +='LEFT JOIN ( '
cQuery +='            SELECT DI.PRODUTO "CODIGO_WMS_PRODUTO_RECEBIMENTO", '
cQuery +='                   DI.COD_TIPO_ESTOQUE "ARM_WMS_RECEBIMENTO", '
cQuery +='                   SUM(DI.QTDE) "QTD_WMS_RECEBIMENTO" '
cQuery +='            FROM WMS.DOCPAR_CAB DC '
cQuery +='            LEFT JOIN WMS.DOCPAR_ITE DI '
cQuery +='            ON DC.DOCUMENTO = DI.DOCUMENTO '
cQuery +="            WHERE TIPO_DOC NOT IN ('8','16') " 
cQuery +="            AND DATA_EMISSAO LIKE '%2016%' " 
cQuery +='            AND DATA_LIVRO IS NULL '
cQuery +='            GROUP BY DI.PRODUTO,DI.COD_TIPO_ESTOQUE '
cQuery +=')WMS_RECEBIMENTO '
cQuery +='ON TRIM(PROTHEUS.CODIGO_PROTHEUS) = WMS_RECEBIMENTO.CODIGO_WMS_PRODUTO_RECEBIMENTO '
cQuery +='AND trim(to_number(PROTHEUS.ARM_PROTHEUS)) = trim(WMS_RECEBIMENTO.ARM_WMS_RECEBIMENTO) '
cQuery +='WHERE ( '
cQuery +='        PROTHEUS.QTD_PROTHEUS <> 0 OR ' 
cQuery +='        WMS_NORMAL.QTD_WMS <> 0	OR '
cQuery +='        WMS_EXPEDICAO.QTD_WMS_EXPEDICAO <> 0 OR '
cQuery +='        WMS_RECEBIMENTO.QTD_WMS_RECEBIMENTO <> 0 '
cQuery +='      ) '
cQuery +='ORDER BY PROTHEUS.CODIGO_PROTHEUS, PROTHEUS.ARM_PROTHEUS'

 	 cQuery := ChangeQuery(cQuery)
	 dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),aArea, .F., .T.)
	 dbSelectArea(aArea)

While (aArea)->(!EOF())
	incproc("Processando dados do Protheus...")   
	                                                                  
	aadd(aSaldos,{ cFil,(aArea)->PRODUTO,(aArea)->DESCRICAO,(aArea)->TIPO,(aArea)->ARMAZEM,(aArea)->SALDO_PROTHEUS,(aArea)->SALDO_WMS,(aArea)->DIVERGENCIA,(aArea)->WMS_EM_EXPEDICAO,(aArea)->TOTAL_WMS,(aArea)->QUANTIDADE_EM_RECEBIMENTO} )
	
	(aArea)->(dbskip())
End
(aArea)->(dbclosearea())


cXML	+= '<?xml version="1.0"?>'+CRLF
cXML	+= '<?mso-application progid="Excel.Sheet"?>'+CRLF
cXML	+= '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cXML	+= ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF
cXML	+= ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF
cXML	+= ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cXML	+= ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
cXML	+= ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cXML	+= '  <Author>Protheus</Author>'+CRLF
cXML	+= '  <LastAuthor>Protheus</LastAuthor>'+CRLF
cXML	+= '  <Created>2013-08-21T16:51:10Z</Created>'+CRLF
cXML	+= '  <Version>14.00</Version>'+CRLF
cXML	+= ' </DocumentProperties>'+CRLF
cXML	+= ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cXML	+= '  <AllowPNG/>'+CRLF
cXML	+= ' </OfficeDocumentSettings>'+CRLF
cXML	+= ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cXML	+= '  <WindowHeight>5190</WindowHeight>'+CRLF
cXML	+= '  <WindowWidth>10515</WindowWidth>'+CRLF
cXML	+= '  <WindowTopX>480</WindowTopX>'+CRLF
cXML	+= '  <WindowTopY>135</WindowTopY>'+CRLF
cXML	+= '  <ProtectStructure>False</ProtectStructure>'+CRLF
cXML	+= '  <ProtectWindows>False</ProtectWindows>'+CRLF
cXML	+= ' </ExcelWorkbook>'+CRLF    
cXML	+= ' <Styles>'+CRLF
cXML	+= '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF
cXML	+= '   <Alignment ss:Vertical="Bottom"/>'+CRLF
cXML	+= '   <Borders/>'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
cXML	+= '   <Interior/>'+CRLF
cXML	+= '   <NumberFormat/>'+CRLF
cXML	+= '   <Protection/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s62">'+CRLF
cXML	+= '   <NumberFormat ss:Format="@"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s63">'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cXML	+= '    ss:Bold="1"/>'+CRLF
cXML	+= '   <NumberFormat ss:Format="@"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s64">'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cXML	+= '    ss:Bold="1"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s71">'+CRLF
cXML	+= '   <NumberFormat ss:Format="#,##0"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= '  <Style ss:ID="s72">'+CRLF
cXML	+= '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cXML	+= '    ss:Bold="1"/>'+CRLF
cXML	+= '   <NumberFormat ss:Format="#,##0"/>'+CRLF
cXML	+= '  </Style>'+CRLF
cXML	+= ' </Styles>'+CRLF
cXML	+= ' <Worksheet ss:Name="Batimento WMS">'+CRLF
cXML	+= '  <Table ss:ExpandedColumnCount="11" ss:ExpandedRowCount="999999" x:FullColumns="1"'+CRLF
cXML	+= '   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF
cXML	+= '   <Column ss:StyleID="s62" ss:Width="27.75"/>'+CRLF
cXML	+= '   <Column ss:StyleID="s62" ss:Width="74.25"/>'+CRLF
cXML	+= '   <Column ss:Width="174"/>'+CRLF
cXML	+= '   <Column ss:Width="25.5"/>'+CRLF
cXML	+= '   <Column ss:StyleID="s62" ss:Width="28.5"/>'+CRLF
cXML	+= '   <Column ss:Width="48.75"/>'+CRLF
cXML	+= '   <Column ss:Width="66.75"/>'+CRLF
cXML	+= '   <Column ss:Width="50.25"/>'+CRLF
cXML	+= '   <Row ss:AutoFitHeight="0">'+CRLF
cXML	+= '    <Cell ss:StyleID="s63"><Data ss:Type="String">Filial</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s63"><Data ss:Type="String">Produto</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Descri√ß√£o</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Tipo</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s63"><Data ss:Type="String">Local</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Qtd Protheus</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Qtd WMS</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Diferenca</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">WMS em Expedicao</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Total WMS</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s64"><Data ss:Type="String">Saldo a receber</Data></Cell>'+CRLF
cXML	+= '   </Row>'+CRLF
RL206Write(@cXML)

For nx:=1 to len(aSaldos)
	//aadd(aSaldos,{ (cAliasPRO)->B2_COD,(cAliasPRO)->B2_LOCAL,(cAliasPRO)->B2_QATU,0 ,(cAliasPRO)->B1_XDESC,(cAliasPRO)->B1_TIPO} )
	incproc("Gravando dados na planilha...")
	
	cXML	+= '   <Row ss:AutoFitHeight="0">'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+alltrim(aSaldos[nx,1])+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+alltrim(aSaldos[nx,2])+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+FwNoAccent(alltrim(aSaldos[nx,3]))+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+aSaldos[nx,4]+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell><Data ss:Type="String">'+aSaldos[nx,5]+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(aSaldos[nx,6])+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,7]))+'</Data></Cell>'+CRLF
	//cXML	+= '    <Cell ss:StyleID="s71" ss:Formula="=RC[-2]-RC[-1]"><Data ss:Type="Number"></Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,8]))+'</Data></Cell>'+CRLF
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,9]))+'</Data></Cell>'+CRLF
	//cXML	+= '    <Cell ss:StyleID="s71" ss:Formula="=RC[-3]+RC[-1]"><Data ss:Type="Number"></Data></Cell>'+CRLF
	cXML		+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,10]))+'</Data></Cell>'+CRLF
	//Nova coluna com saldo dos produtos para serem recebidos no sistema WMS
	cXML	+= '    <Cell ss:StyleID="s71"><Data ss:Type="Number">'+alltrim(str(aSaldos[nx,11]))+'</Data></Cell>'+CRLF
	cXML	+= '   </Row>'+CRLF
	RL206Write(@cXML)
	
Next nx
//Totais
cXML	+= '   <Row ss:AutoFitHeight="0">'+CRLF
cXML	+= '    <Cell ss:Index="2" ss:StyleID="s63"><Data ss:Type="String">Totais</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:Index="6" ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data'+CRLF
cXML	+= '      ss:Type="Number">11</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">21</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '    <Cell ss:StyleID="s72" ss:Formula="=SUM(R[-'+alltrim(str(len(aSaldos)))+']C:R[-1]C)"><Data ss:Type="Number">-10</Data></Cell>'+CRLF
cXML	+= '   </Row>'+CRLF
cXML	+= '  </Table>'+CRLF
cXML	+= '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cXML	+= '   <PageSetup>'+CRLF
cXML	+= '    <Header x:Margin="0.31496062000000002"/>'+CRLF
cXML	+= '    <Footer x:Margin="0.31496062000000002"/>'+CRLF
cXML	+= '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
cXML	+= '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
cXML	+= '   </PageSetup>'+CRLF
cXML	+= '   <Unsynced/>'+CRLF
cXML	+= '   <Print>'+CRLF
cXML	+= '    <ValidPrinterInfo/>'+CRLF
cXML	+= '    <HorizontalResolution>600</HorizontalResolution>'+CRLF
cXML	+= '    <VerticalResolution>600</VerticalResolution>'+CRLF
cXML	+= '   </Print>'+CRLF
cXML	+= '   <Selected/>'+CRLF
cXML	+= '   <Panes>'+CRLF
cXML	+= '    <Pane>'+CRLF
cXML	+= '     <Number>3</Number>'+CRLF
cXML	+= '     <ActiveRow>3</ActiveRow>'+CRLF
cXML	+= '     <ActiveCol>3</ActiveCol>'+CRLF
cXML	+= '    </Pane>'+CRLF
cXML	+= '   </Panes>'+CRLF
cXML	+= '   <ProtectObjects>False</ProtectObjects>'+CRLF
cXML	+= '   <ProtectScenarios>False</ProtectScenarios>'+CRLF
cXML	+= '  </WorksheetOptions>'+CRLF
cXML	+= ' </Worksheet>'+CRLF
cXML	+= '</Workbook>'+CRLF
cXML	+= ''+CRLF
RL206Write(@cXML)

FClose(nHdl)

If __CopyFile(cPathArq+cArqXls+cExtExcel, cPathExcel+cArqXls)
	Ferase(cPathArq+cArqXls)
	fRename( cPathExcel+cArqXls, cPathExcel+cNomArq+cExtExcel )
	If !lJob
		If !ApOleCliente( "MsExcel" )
			MsgStop( "Microsoft Excel n„o Instalado... Contate o Administrador do Sistema!" )
		Else
			If MsgYesNo("Abrir o Microsoft Excel?")
				oExcelApp:=MsExcel():New()
				oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
				oExcelApp:SetVisible( .T. )
				oExcelApp:Destroy()
			EndIf
		EndIf
	EndIf
	
EndIf

Conout("Finalizada a geraÁ„o do relatÛrio de batimento de saldos WMS Inovatech x Protheus "+time())

dbCloseArea(aArea)

Return
