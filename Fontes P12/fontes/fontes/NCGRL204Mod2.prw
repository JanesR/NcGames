#INCLUDE "PROTHEUS.CH"
#INCLUDE 'FILEIO.CH'

#Define NewLine Chr(13)+Chr(10)

User Function TABPRMOD2()
	u_TABPRJOB(.F. , .F.)
Return

User Function TABPRFRA2()
	u_TABPRJOB(.F. , .T.)
Return


User Function TABPRJOB(lJob , lProdFran)
	Local aSays:={}
	Local aButtons:={}
	Local cPerg:="NCGRL204"
	Local lOk := .F.
	Local cCadastro:="Tabela de Preços"

	Default lJob:=.F.
	Default lProdFran:=.F.
	Private nHdl
	Private cPathExcel  	:= ""
	Private cExtExcel   	:= ".xls"
	Private arqFim

	If !lJob
		AADD( aSays, "Tabela de Preços Nc Games"+IIf(lProdFran,"-Produtos Franchising","") )
		AADD( aButtons, { 01, .T., {|| lOk := .T.,(cPathExcel:=cGetFile( "Defina o diretório | ",OemToAnsi("Selecione Diretorio de Gravação da Planilha"), ,"" ,.f.,GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE) ) ,Iif( !Empty(cPathExcel), FechaBatch(), msgStop("Informe o diretorio de gravaçao da planilha") ) } } )
		AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
		;FormBatch( cCadastro, aSays, aButtons )
	Else
		lOk := .T.
		cPathExcel:=GetMV("NC_CGRL204",,"")
	EndIf

	If lOk .And. !Empty(cPathExcel)
		Processa({ || GeraRel(lJob,lProdFran)})
	EndIf
	
	If MsgYesNo("Abrir o Microsoft Excel?")
		oExcelApp:=MsExcel():New()
		oExcelApp:WorkBooks:Open( arqFim )
		oExcelApp:SetVisible( .T. )
		oExcelApp:Destroy()
	EndIf
	
Return

Static Function GeraRel(lJob,lProdFran)
	Local aArea := GetArea()
	Local cAliasQry
	Private cArqXls:=E_Create(,.F.)
	Private contLinhas
	Private oFile
	
	
	oFile := fcreate(cPathExcel+cArqXls+cExtExcel,0)
	
	IF oFile != -1
	
		Processa({|| GetItens(@cAliasQry , lProdFran) })
	
		contLinhas := Contar(cAliasQry,"!Eof()")+9
		(cAliasQry)->(DbGoTop())
		
		Processa({|| Cab() })
		Processa({|| GrvItens(cAliasQry) })
		Processa({|| Rod() })
		  
		FClose(oFile)
		
		IF !lProdFran
			arqFim := cPathExcel+"Tabela de Preços"+cExtExcel
			frename(cPathExcel+cArqXls+cExtExcel, arqFim)
		Else
			arqFim := cPathExcel+"Tabela de Preços Franchising"+cExtExcel
			frename(cPathExcel+cArqXls+cExtExcel, arqFim)
		EndIF
		
	EndIF
	RestArea(aArea)
Return

Static Function GrvLinha(cLinha)
	Local aArea := GetArea()

	FWrite(oFile , cLinha, Len(cLinha))

	RestArea(aArea)
Return

Static Function Cab()
	Local aArea := GetArea()
	Local cLinha := ""
	
	cLinha += '<?xml version="1.0"?>																												'+NewLine
	cLinha += '<?mso-application progid="Excel.Sheet"?>                                                                                             '+NewLine
	cLinha += '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"                                                                       '+NewLine
	cLinha += ' xmlns:o="urn:schemas-microsoft-com:office:office"                                                                                   '+NewLine
	cLinha += ' xmlns:x="urn:schemas-microsoft-com:office:excel"                                                                                    '+NewLine
	cLinha += ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"                                                                             '+NewLine
	cLinha += ' xmlns:html="http://www.w3.org/TR/REC-html40">                                                                                       '+NewLine
	cLinha += ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">                                                                '+NewLine
	cLinha += '  <Author>rribeiro</Author>                                                                                                          '+NewLine
	cLinha += '  <LastAuthor>Janes Raulino Isidoro</LastAuthor>                                                                                     '+NewLine
	cLinha += '  <LastPrinted>2011-11-23T14:53:48Z</LastPrinted>                                                                                    '+NewLine
	cLinha += '  <Created>2010-12-10T13:06:25Z</Created>                                                                                            '+NewLine
	cLinha += '  <LastSaved>2016-12-12T12:21:08Z</LastSaved>                                                                                        '+NewLine
	cLinha += '  <Version>15.00</Version>                                                                                                           '+NewLine
	cLinha += ' </DocumentProperties>                                                                                                               '+NewLine
	cLinha += ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">                                                            '+NewLine
	cLinha += '  <AllowPNG/>                                                                                                                        '+NewLine
	cLinha += ' </OfficeDocumentSettings>                                                                                                           '+NewLine
	cLinha += ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">                                                                      '+NewLine
	cLinha += '  <WindowHeight>9735</WindowHeight>                                                                                                  '+NewLine
	cLinha += '  <WindowWidth>24000</WindowWidth>                                                                                                   '+NewLine
	cLinha += '  <WindowTopX>0</WindowTopX>                                                                                                         '+NewLine
	cLinha += '  <WindowTopY>0</WindowTopY>                                                                                                         '+NewLine
	cLinha += '  <TabRatio>514</TabRatio>                                                                                                           '+NewLine
	cLinha += '  <ProtectStructure>False</ProtectStructure>                                                                                         '+NewLine
	cLinha += '  <ProtectWindows>False</ProtectWindows>                                                                                             '+NewLine
	cLinha += ' </ExcelWorkbook>                                                                                                                    '+NewLine
	cLinha += ' <Styles>                                                                                                                            '+NewLine
	cLinha += '  <Style ss:ID="Default" ss:Name="Normal">                                                                                           '+NewLine
	cLinha += '   <Alignment ss:Vertical="Bottom"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>                                                    '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '   <Protection/>                                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s146" ss:Name="Hiperlink">                                                                                           '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#0563C1"                                                      '+NewLine
	cLinha += '    ss:Underline="Single"/>                                                                                                          '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s18" ss:Name="Moeda">                                                                                                '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s20" ss:Name="Porcentagem">                                                                                          '+NewLine
	cLinha += '   <NumberFormat ss:Format="0%"/>                                                                                                    '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="m115662988">                                                                                                         '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>                                                            '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"                                                             '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"                                                               '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"                                                              '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"                                                                '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="m115663008" ss:Parent="s20">                                                                                         '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"                                                             '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"                                                               '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"                                                              '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"                                                                '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="m115663028">                                                                                                         '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>                                                            '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"                                                             '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"                                                               '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"                                                              '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"                                                                '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="m115663048" ss:Parent="s20">                                                                                         '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"                                                             '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"                                                               '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"                                                              '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"                                                                '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="m115663068">                                                                                                         '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>                                                            '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"                                                             '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"                                                               '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"                                                              '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"                                                                '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="m115663088" ss:Parent="s20">                                                                                         '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"                                                             '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"                                                               '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"                                                              '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"                                                                '+NewLine
	cLinha += '     ss:Color="#A6A6A6"/>                                                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s62">                                                                                                                '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s63">                                                                                                                '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s64">                                                                                                                '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s66" ss:Parent="s18">                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Bottom"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '   <Protection/>                                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s67">                                                                                                                '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s69">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s70">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s71">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="16" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="00000000000"/>                                                                                           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s72">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="16" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s73">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>                                                            '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s74">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s75">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s76">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="Short Date"/>                                                                                            '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s77">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s78">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>                                                            '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s79">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s80">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s81">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>                                                            '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s83" ss:Parent="s20">                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="0%"/>                                                                                                    '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s85">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="24" ss:Bold="1"                                                             '+NewLine
	cLinha += '    ss:Italic="1" ss:Underline="Single"/>                                                                                            '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s86">                                                                                                                '+NewLine
	cLinha += '   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s102">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="00000000000"/>                                                                                           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s103">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="52" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s114">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s115">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="16" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat ss:Format="Fixed"/>                                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s116">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center" ss:WrapText="1"/>                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12" ss:Color="#000000"/>                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s118">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat ss:Format="00000000000"/>                                                                                           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s119">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>                                                              '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#8DB4E2" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s120">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>                                                              '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#8DB4E2" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s121">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>                                                              '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#FF0000" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s122">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>                                                              '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#000000"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s123">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>                                                              '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>                                                           '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s124">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12"/>                                                                       '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s125" ss:Parent="s18">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12"/>                                                                       '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat/>                                                                                                                   '+NewLine
	cLinha += '   <Protection/>                                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s126">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat ss:Format="00000000000"/>                                                                                           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s127">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="@"/>                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s128">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="0"/>                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s130" ss:Parent="s18">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center"/>                                                                            '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s131" ss:Parent="s18">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s132" ss:Parent="s18">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s133" ss:Parent="s20">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s134" ss:Parent="s20">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat ss:Format="0"/>                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s135" ss:Parent="s20">                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat ss:Format="0"/>                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s136">                                                                                                               '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Trebuchet MS" x:Family="Swiss"/>                                                                               '+NewLine
	cLinha += '   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s138">                                                                                                               '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Trebuchet MS" x:Family="Swiss"/>                                                                               '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s139">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>                                                             '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous"/>                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#808080" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s140">                                                                                                               '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous"/>                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Interior ss:Color="#808080" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s141">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center"/>                                                                                                 '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>                                                           '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>                                                            '+NewLine
	cLinha += '    <Border ss:Position="Top" ss:LineStyle="Continuous"/>                                                                            '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="16" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#808080" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s142">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s143">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>                                                                          '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>                                                                       '+NewLine
	cLinha += '   <Interior ss:Color="#DDD9C4" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '   <NumberFormat ss:Format="@"/>                                                                                                     '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s144">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12"/>                                                                       '+NewLine
	cLinha += '   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s145">                                                                                                               '+NewLine
	cLinha += '   <Alignment ss:Vertical="Center"/>                                                                                                 '+NewLine
	cLinha += '   <Borders/>                                                                                                                        '+NewLine
	cLinha += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="20" ss:Color="#FFFFFF"                                                      '+NewLine
	cLinha += '    ss:Bold="1"/>                                                                                                                    '+NewLine
	cLinha += '   <Interior ss:Color="#002060" ss:Pattern="Solid"/>                                                                                 '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += '  <Style ss:ID="s147" ss:Parent="s146">                                                                                              '+NewLine
	cLinha += '   <Alignment ss:Horizontal="Left" ss:Vertical="Center"/>                                                                            '+NewLine
	cLinha += '   <Borders>                                                                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>                                                                         '+NewLine
	cLinha += '    <Border ss:Position="Left" ss:LineStyle="Continuous"/>                                                                           '+NewLine
	cLinha += '    <Border ss:Position="Right" ss:LineStyle="Continuous"/>                                                                          '+NewLine
	cLinha += '   </Borders>                                                                                                                        '+NewLine
	cLinha += '   <Interior/>                                                                                                                       '+NewLine
	cLinha += '   <NumberFormat                                                                                                                     '+NewLine
	cLinha += '    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>           '+NewLine
	cLinha += '  </Style>                                                                                                                           '+NewLine
	cLinha += ' </Styles>                                                                                                                           '+NewLine
	cLinha += ' <Worksheet ss:Name="NC_GAMES">                                                                                                      '+NewLine
	cLinha += '  <Names>                                                                                                                            '+NewLine
	cLinha += '   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=NC_GAMES!#REF!"                                                               '+NewLine
	cLinha += '    ss:Hidden="1"/>                                                                                                                  '+NewLine
	cLinha += '  </Names>                                                                                                                           '+NewLine
	cLinha += '  <Table ss:ExpandedColumnCount="25" ss:ExpandedRowCount="'+ alltrim(trataCell(contLinhas + 100)) +'" x:FullColumns="1"                    '+NewLine
	cLinha += '   x:FullRows="1" ss:StyleID="s62" ss:DefaultRowHeight="15">                                                                         '+NewLine
	cLinha += '   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="4.5"/>                                                                     '+NewLine
	cLinha += '   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="6"/>                                                                       '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="243.75"/>                                                                  '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:Width="113.25"/>                                                                                      '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:Width="144.75"/>                                                                                      '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="456"/>                                                                     '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="108"/>                                                                     '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="83.25"/>                                                                   '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="86.25"/>                                                                   '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="109.5" ss:Span="1"/>                                                       '+NewLine
	cLinha += '   <Column ss:Index="12" ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="102"/>                                                       '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="117" ss:Span="2"/>                                                         '+NewLine
	cLinha += '   <Column ss:Index="16" ss:StyleID="s64" ss:Width="109.5"/>                                                                         '+NewLine
	cLinha += '   <Column ss:StyleID="s66" ss:AutoFitWidth="0" ss:Width="102" ss:Span="2"/>                                                         '+NewLine
	cLinha += '   <Column ss:Index="20" ss:StyleID="s66" ss:AutoFitWidth="0" ss:Width="662.25"/>                                                    '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:Width="80.25"/>                                                                                       '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:Width="79.5"/>                                                                                        '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:Width="135"/>                                                                                         '+NewLine
	cLinha += '   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="88.5"/>                                                                    '+NewLine
	cLinha += '   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="83.25"/>                                                                   '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:StyleID="s67">                                                                                       '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s71"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s71"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s72"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s72"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s72"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s73"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s72"/>                                                                                                         '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">                                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s75"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s76"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s77"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s78"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s78"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s73"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s77"/>                                                                                                         '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">                                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s81"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s73"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">                                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s81"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s73"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s75"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">                                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:MergeAcross="3" ss:StyleID="s85"><Data ss:Type="String">TABELA DE PREÇOS - NC GAMES</Data></Cell>                       '+NewLine
	cLinha += '    <Cell ss:StyleID="s83"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s86"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:MergeAcross="2" ss:StyleID="m115662988"><Data ss:Type="String">Total do pedido sem Impostos - SP</Data></Cell>          '+NewLine
	cLinha += '    <Cell ss:MergeAcross="1" ss:StyleID="m115663008" ss:Formula="=R['+ alltrim(trataCell(contLinhas - 4 )) +']C[2]"><Data                                                  '+NewLine
	cLinha += '      ss:Type="Number">0</Data></Cell>                                                                                               '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s80"/>                                                                                                         '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="23.25" ss:StyleID="s67">                                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s102"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s102"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"><Data ss:Type="String">         Tabela de Preços - Games &amp; Acessórios</Data></Cell>                  '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s86"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:MergeAcross="2" ss:StyleID="m115663028"><Data ss:Type="String">Total do pedido sem Impostos - ES NO NE CO </Data></Cell>'+NewLine
	cLinha += '    <Cell ss:MergeAcross="1" ss:StyleID="m115663048" ss:Formula="=R['+  alltrim(trataCell(contLinhas - 5 ))  +']C[3]"><Data                                                  '+NewLine
	cLinha += '      ss:Type="Number">0</Data></Cell>                                                                                               '+NewLine
	cLinha += '    <Cell ss:StyleID="s114"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s114"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s114"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">                                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"><Data ss:Type="String">PRODUTOS SUJEITOS À DISPONIBILIDADE DE ESTOQUE</Data></Cell>                       '+NewLine
	cLinha += '    <Cell ss:StyleID="s102"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s86"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:MergeAcross="2" ss:StyleID="m115663068"><Data ss:Type="String">Total do pedido sem Impostos - SUL E SUD</Data></Cell>   '+NewLine
	cLinha += '    <Cell ss:MergeAcross="1" ss:StyleID="m115663088" ss:Formula="=R['+  alltrim(trataCell(contLinhas - 6 ))  +']C[4]"><Data                                                  '+NewLine
	cLinha += '      ss:Type="Number">0</Data></Cell>                                                                                               '+NewLine
	cLinha += '    <Cell ss:StyleID="s115"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s115"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s115"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="67.5" ss:StyleID="s67">                                                                      '+NewLine
	cLinha += '    <Cell ss:StyleID="s69"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s79"><Data ss:Type="String">OS PREÇOS REFLETIDOS NESTA TABELA DE PREÇOS ESTÃO SEM ST E IPI</Data></Cell>       '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s73"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s74"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s70"/>                                                                                                         '+NewLine
	cLinha += '    <Cell ss:StyleID="s103"/>                                                                                                        '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	cLinha += '   <Row ss:AutoFitHeight="0" ss:Height="42" ss:StyleID="s116">                                                                       '+NewLine
	cLinha += '    <Cell ss:Index="2" ss:StyleID="s118"/>                                                                                           '+NewLine
	cLinha += '    <Cell ss:StyleID="s119"><Data ss:Type="String">CAMPANHA</Data></Cell>                                                            '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">CÓDIGO NC </Data></Cell>                                                          '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">CÓD. DE BARRAS </Data></Cell>                                                     '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">DESCRIÇÃO </Data></Cell>                                                          '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">PUBLISH</Data></Cell>                                                             '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">PLAT</Data></Cell>                                                                '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">GÊNERO</Data></Cell>                                                              '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">SP (18%)</Data></Cell>                                                            '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">ES NO NE e CO                 </Data></Cell>                                      '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">SUL e SUD                     </Data></Cell>                                      '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">Preço Consumidor</Data></Cell>                                                    '+NewLine
	cLinha += '    <Cell ss:StyleID="s120"><Data ss:Type="String">IPI</Data></Cell>                                                                 '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">Estoque Disponível</Data></Cell>                                                  '+NewLine
	cLinha += '    <Cell ss:StyleID="s122"><Data ss:Type="String">Quant Pedido</Data></Cell>                                                        '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">ICMS 18%</Data></Cell>                                                            '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">ICMS 7%</Data></Cell>                                                             '+NewLine
	cLinha += '    <Cell ss:StyleID="s121"><Data ss:Type="String">ICMS 12%</Data></Cell>                                                            '+NewLine
	cLinha += '    <Cell ss:StyleID="s123"><Data ss:Type="String">Página Jogo</Data></Cell>                                                         '+NewLine
	cLinha += '   </Row>                                                                                                                            '+NewLine
	
	GrvLinha(EncodeUTF8(cLinha))

	RestArea(aArea)
Return

Static Function Rod()
	Local aArea := GetArea()
	Local cLinha := ""
	
	cLinha +='   <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s136">																	'+NewLine
	cLinha +='    <Cell ss:Index="2" ss:StyleID="s138"/>                                                                                            '+NewLine
	cLinha +='    <Cell ss:StyleID="s139"><Data ss:Type="String">SubTotal</Data></Cell>                                                             '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s140"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s141" ss:Formula="=SUBTOTAL(109,R[-'+alltrim(trataCell(contLinhas))+']C:R[-1]C)"><Data                                                        '+NewLine
	cLinha +='      ss:Type="Number">1</Data></Cell>                                                                                                '+NewLine
	cLinha +='    <Cell ss:StyleID="s141" ss:Formula="=SUBTOTAL(109,R[-'+alltrim(trataCell(contLinhas))+']C:R[-1]C)"><Data                                                        '+NewLine
	cLinha +='      ss:Type="Number">131.31</Data></Cell>                                                                                           '+NewLine
	cLinha +='    <Cell ss:StyleID="s141" ss:Formula="=SUBTOTAL(109,R[-'+alltrim(trataCell(contLinhas))+']C:R[-1]C)"><Data                                                        '+NewLine
	cLinha +='      ss:Type="Number">117.46</Data></Cell>                                                                                           '+NewLine
	cLinha +='    <Cell ss:StyleID="s141" ss:Formula="=SUBTOTAL(109,R[-'+alltrim(trataCell(contLinhas))+']C:R[-1]C)"><Data                                                        '+NewLine
	cLinha +='      ss:Type="Number">124.92</Data></Cell>                                                                                           '+NewLine
	cLinha +='    <Cell ss:StyleID="s138"/>                                                                                                         '+NewLine
	cLinha +='   </Row>                                                                                                                             '+NewLine
	cLinha +='   <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s124">                                                                   '+NewLine
	cLinha +='    <Cell ss:Index="2" ss:StyleID="s142"/>                                                                                            '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s143"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:Index="17" ss:StyleID="s125"/>                                                                                           '+NewLine
	cLinha +='    <Cell ss:StyleID="s125"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s125"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s125"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:Index="25" ss:StyleID="s144"/>                                                                                           '+NewLine
	cLinha +='   </Row>                                                                                                                             '+NewLine
	cLinha +='   <Row ss:AutoFitHeight="0" ss:Height="33.75" ss:StyleID="s124">                                                                     '+NewLine
	cLinha +='    <Cell ss:Index="2" ss:StyleID="s142"/>                                                                                            '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"><Data ss:Type="String">Tel: (11) 4095-3100</Data></Cell>                                                  '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145" ss:HRef="http://www.ncgames.com.br/"><Data                                                                '+NewLine
	cLinha +='      ss:Type="String">www.ncgames.com.br</Data></Cell>                                                                               '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='   </Row>                                                                                                                             '+NewLine
	cLinha +='   <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s124">                                                                   '+NewLine
	cLinha +='    <Cell ss:Index="2" ss:StyleID="s142"/>                                                                                            '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s145"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='    <Cell ss:StyleID="s144"/>                                                                                                         '+NewLine
	cLinha +='   </Row>                                                                                                                             '+NewLine
	cLinha +='  </Table>                                                                                                                            '+NewLine
	cLinha +='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">                                                                   '+NewLine
	cLinha +='   <PageSetup>                                                                                                                        '+NewLine
	cLinha +='    <Header x:Margin="0.31496062992125984"/>                                                                                          '+NewLine
	cLinha +='    <Footer x:Margin="0.31496062992125984"/>                                                                                          '+NewLine
	cLinha +='    <PageMargins x:Bottom="0.74803149606299213" x:Left="0.23622047244094491"                                                          '+NewLine
	cLinha +='     x:Right="0.23622047244094491" x:Top="0.74803149606299213"/>                                                                      '+NewLine
	cLinha +='   </PageSetup>                                                                                                                       '+NewLine
	cLinha +='   <Unsynced/>                                                                                                                        '+NewLine
	cLinha +='   <Print>                                                                                                                            '+NewLine
	cLinha +='    <ValidPrinterInfo/>                                                                                                               '+NewLine
	cLinha +='    <PaperSizeIndex>9</PaperSizeIndex>                                                                                                '+NewLine
	cLinha +='    <Scale>20</Scale>                                                                                                                 '+NewLine
	cLinha +='    <HorizontalResolution>600</HorizontalResolution>                                                                                  '+NewLine
	cLinha +='    <VerticalResolution>600</VerticalResolution>                                                                                      '+NewLine
	cLinha +='   </Print>                                                                                                                           '+NewLine
	cLinha +='   <Zoom>60</Zoom>                                                                                                                    '+NewLine
	cLinha +='   <Selected/>                                                                                                                        '+NewLine
	cLinha +='   <DoNotDisplayGridlines/>                                                                                                           '+NewLine
	cLinha +='   <TopRowVisible>8</TopRowVisible>                                                                                                   '+NewLine
	cLinha +='   <LeftColumnVisible>8</LeftColumnVisible>                                                                                           '+NewLine
	cLinha +='   <Panes>                                                                                                                            '+NewLine
	cLinha +='    <Pane>                                                                                                                            '+NewLine
	cLinha +='     <Number>3</Number>                                                                                                               '+NewLine
	cLinha +='     <ActiveRow>10</ActiveRow>                                                                                                        '+NewLine
	cLinha +='     <ActiveCol>15</ActiveCol>                                                                                                        '+NewLine
	cLinha +='    </Pane>                                                                                                                           '+NewLine
	cLinha +='   </Panes>                                                                                                                           '+NewLine
	cLinha +='   <ProtectObjects>False</ProtectObjects>                                                                                             '+NewLine
	cLinha +='   <ProtectScenarios>False</ProtectScenarios>                                                                                         '+NewLine
	cLinha +='   <EnableSelection>UnlockedCells</EnableSelection>                                                                                   '+NewLine
	cLinha +='   <AllowSort/>                                                                                                                       '+NewLine
	cLinha +='   <AllowFilter/>                                                                                                                     '+NewLine
	cLinha +='   <AllowUsePivotTables/>                                                                                                             '+NewLine
	cLinha +='  </WorksheetOptions>                                                                                                                 '+NewLine
	cLinha +=' </Worksheet>                                                                                                                         '+NewLine
	cLinha +=' <Worksheet ss:Name="Plan1">                                                                                                          '+NewLine
	cLinha +='  <Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"                                                         '+NewLine
	cLinha +='   x:FullRows="1" ss:DefaultRowHeight="15">                                                                                           '+NewLine
	cLinha +='   <Row ss:AutoFitHeight="0"/>                                                                                                        '+NewLine
	cLinha +='  </Table>                                                                                                                            '+NewLine
	cLinha +='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">                                                                   '+NewLine
	cLinha +='   <PageSetup>                                                                                                                        '+NewLine
	cLinha +='    <Header x:Margin="0.31496062000000002"/>                                                                                          '+NewLine
	cLinha +='    <Footer x:Margin="0.31496062000000002"/>                                                                                          '+NewLine
	cLinha +='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"                                                                  '+NewLine
	cLinha +='     x:Right="0.511811024" x:Top="0.78740157499999996"/>                                                                              '+NewLine
	cLinha +='   </PageSetup>                                                                                                                       '+NewLine
	cLinha +='   <Unsynced/>                                                                                                                        '+NewLine
	cLinha +='   <Visible>SheetHidden</Visible>                                                                                                     '+NewLine
	cLinha +='   <Panes>                                                                                                                            '+NewLine
	cLinha +='    <Pane>                                                                                                                            '+NewLine
	cLinha +='     <Number>3</Number>                                                                                                               '+NewLine
	cLinha +='     <RangeSelection>R1C1:R8113C2</RangeSelection>                                                                                    '+NewLine
	cLinha +='    </Pane>                                                                                                                           '+NewLine
	cLinha +='   </Panes>                                                                                                                           '+NewLine
	cLinha +='   <ProtectObjects>False</ProtectObjects>                                                                                             '+NewLine
	cLinha +='   <ProtectScenarios>False</ProtectScenarios>                                                                                         '+NewLine
	cLinha +='  </WorksheetOptions>                                                                                                                 '+NewLine
	cLinha +=' </Worksheet>                                                                                                                         '+NewLine
	cLinha +=' <Worksheet ss:Name="Plan2">                                                                                                          '+NewLine
	cLinha +='  <Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"                                                         '+NewLine
	cLinha +='   x:FullRows="1" ss:DefaultRowHeight="15">                                                                                           '+NewLine
	cLinha +='   <Row ss:AutoFitHeight="0"/>                                                                                                        '+NewLine
	cLinha +='  </Table>                                                                                                                            '+NewLine
	cLinha +='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">                                                                   '+NewLine
	cLinha +='   <PageSetup>                                                                                                                        '+NewLine
	cLinha +='    <Header x:Margin="0.31496062000000002"/>                                                                                          '+NewLine
	cLinha +='    <Footer x:Margin="0.31496062000000002"/>                                                                                          '+NewLine
	cLinha +='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"                                                                  '+NewLine
	cLinha +='     x:Right="0.511811024" x:Top="0.78740157499999996"/>                                                                              '+NewLine
	cLinha +='   </PageSetup>                                                                                                                       '+NewLine
	cLinha +='   <Unsynced/>                                                                                                                        '+NewLine
	cLinha +='   <Visible>SheetHidden</Visible>                                                                                                     '+NewLine
	cLinha +='   <ProtectObjects>False</ProtectObjects>                                                                                             '+NewLine
	cLinha +='   <ProtectScenarios>False</ProtectScenarios>                                                                                         '+NewLine
	cLinha +='  </WorksheetOptions>                                                                                                                 '+NewLine
	cLinha +=' </Worksheet>                                                                                                                         '+NewLine
	cLinha +='</Workbook>                                                                                                                           '+NewLine
	
	
	GrvLinha(cLinha)
	RestArea(aArea)
Return

Static Function GetItens(cAliasQry ,lProdFran )
	Local aArea := GetArea()
	Local cQuery := ""
	Local cFran
	
	If lProdFran
		cFran := "% 'S' %"
	Else
		cFran := "% 'N' %"
	EndIF
	
	cAliasQry:= GetNextAlias()
	
	BeginSQL Alias cAliasQry
	
		SELECT PROD.CAMPANHA CAMPANHA, PROD.PROD PRODUTO, PROD.CODBAR CODBAR, PROD.DESCRI DESCRI, TRIM(PROD.PUBLISH) PUBLISH,PROD.PLATAF PLATAF, PROD.GENERO GENERO,
		TAB07.DA1_PRCVEN TAB07,TAB12.DA1_PRCVEN TAB12,TAB18.DA1_PRCVEN TAB18, PROD.IPI IPI, PROD.SALDO SALDO, PROD.POSIPI,PROD.PRCONSUM PRCONSUM, PROD.LINK LINK
		FROM
		(
		select TRIM(sb1.B1_XSELSIT) CAMPANHA, TRIM(sb1.B1_COD) PROD, TRIM(sb1.B1_CODBAR) CODBAR, sb1.B1_POSIPI POSIPI,sb1.B1_IPI IPI, (SB2.B2_QATU-SB2.B2_RESERVA) SALDO,
		TRIM(sb1.B1_XDESC) DESCRI,sb1.B1_PUBLISH PUBLISH ,TRIM(sb1.B1_PLATEXT) PLATAF, sb1.B1_CODGEN GENERO ,
		sb1.B1_CONSUMI PRCONSUM, sb1.B1_XPRV07 PR7, sb1.B1_XPRV12 PR12, sb1.B1_XPRV18 PR18, sb5.B5_LINKA LINK
		from %Table:SB1% sb1 left join %Table:SB5% sb5
		on sb1.B1_COD = sb5.B5_COD
		LEFT JOIN %Table:SB2% SB2
		ON SB1.B1_COD = SB2.B2_COD
		where sb1.B1_FILIAL = %xfilial:SB1%
		and sb1.b1_tipo = 'PA'
		and SB1.B1_MSBLQL = '2'
		and SB1.B1_BLQVEND = '2'
		and SB2.B2_FILIAL = %xfilial:SB2%
		and SB2.B2_LOCAL = '01'
		and sb5.B5_YFRANCH = %exp:cFran%
		)PROD LEFT JOIN
		(
		SELECT TRIM(DA1_CODPRO) CODPRO, DA1_PRCVEN, MAX(R_E_C_N_O_) FROM %Table:DA1% WHERE
		DA1_FILIAL = %xfilial:DA1% AND DA1_CODTAB = '007' AND D_E_L_E_T_ = ' '
		GROUP BY TRIM(DA1_CODPRO), DA1_PRCVEN
		) TAB07
		ON PROD.PROD = TAB07.CODPRO
		LEFT JOIN
		(
		SELECT TRIM(DA1_CODPRO) CODPRO, DA1_PRCVEN, MAX(R_E_C_N_O_) FROM %Table:DA1% WHERE
		DA1_FILIAL = %xfilial:DA1% AND DA1_CODTAB = '012' AND D_E_L_E_T_ = ' '
		GROUP BY TRIM(DA1_CODPRO), DA1_PRCVEN
		)TAB12
		ON PROD.PROD = TAB12.CODPRO
		LEFT JOIN
		(
		SELECT TRIM(DA1_CODPRO) CODPRO, DA1_PRCVEN, MAX(R_E_C_N_O_) FROM %Table:DA1% WHERE
		DA1_FILIAL =  %xfilial:DA1% AND DA1_CODTAB = '018' AND D_E_L_E_T_ = ' '
		GROUP BY TRIM(DA1_CODPRO), DA1_PRCVEN
		)TAB18
		ON PROD.PROD = TAB18.CODPRO
		order by prod.prod

	EndSQL
	
	
	RestArea(aArea)
Return

Static Function GrvItens(cAliasQry)
	Local aArea := GetArea()
	Local cLinha:=''
	Local nCont := 1
	ProcRegua(contLinhas)
	
	while (cAliasQry)->(!EOF())
		IncProc("Item " + Str(nCont) + " de " + Str(contLinhas) + " - "+ Str(round((nCont*100)/contLinhas , 2)) +" %")
		cLinha += ' <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s124"> '+NewLine
		cLinha += ' <Cell ss:Index="2" ss:StyleID="s126"/> '+NewLine
		cLinha += ' <Cell ss:StyleID="s127"><Data ss:Type="String">'+ alltrim(trataCell( NoAcento(AnsiToOem(Tabela('ZU', (cAliasQry)->CAMPANHA,.F.))))) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s128"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->PRODUTO ))+'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s128"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->CODBAR ))+'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s130"><Data ss:Type="String">'+ alltrim(NoAcento(AnsiToOem(trataCell((cAliasQry)->DESCRI ))))+'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s130"><Data ss:Type="String">'+ alltrim(trataCell((cAliasQry)->PUBLISH)) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s130"><Data ss:Type="String">'+ alltrim(trataCell((cAliasQry)->PLATAF ))+'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s130"><Data ss:Type="String">'+ alltrim(trataCell((Tabela('Z2',(cAliasQry)->GENERO,.F.))))+'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s131"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->TAB07 ))+'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s131"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->TAB12)) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s131"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->TAB18)) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s132"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->PRCONSUM)) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s133"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->IPI/100)) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s134"><Data ss:Type="Number">'+ alltrim(trataCell((cAliasQry)->SALDO)) +'</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s135"><Data ss:Type="Number">0</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s131" ss:Formula="=RC[-1]*RC[-7]"><Data ss:Type="Number">0</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s131" ss:Formula="=RC[-2]*RC[-7]"><Data ss:Type="Number">0</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s131" ss:Formula="=RC[-3]*RC[-7]"><Data ss:Type="Number">0</Data></Cell> '+NewLine
		cLinha += ' <Cell ss:StyleID="s147" ss:HRef="'+ alltrim(trataCell((cAliasQry)->LINK ))+'"><Data ss:Type="String">'+ alltrim(trataCell((cAliasQry)->LINK)) +'</Data></Cell> '+NewLine
		cLinha += ' </Row>
		
		
		
		GrvLinha(cLinha)
		cLinha:=""
		nCont++
		(cAliasQry)->(DbSkip())
	EndDo
	
	(cAliasQry)->(DbCloseArea())
	
	RestArea(aArea)
Return

Static Function trataCell(cItem)
	Local aArea := GetArea()
	Local cRet

	IF ValType(cItem) == "U"
		cRet := " "
	ElseIF ValType(cItem) == "N"
		cRet := Str(cItem)
	ElseIF ValType(cItem) == "C"
		cRet := cItem
	ElseIf ValType(cItem) == "D"
		cRet:= StrZero(Year(xDados),4)+"-"+StrZero(Month(xDados),2)+"-"+StrZero(Day(xDados),2)+'T00:00:00.000'
	EndIF

	RestArea(aArea)
Return cRet