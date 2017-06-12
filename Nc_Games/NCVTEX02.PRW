#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"
//
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX02  บAutor  ณMicrosiga           บ Data ณ  02/05/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCVTEX02()
Local aRet		 := {}
Local aParamBox := {}
Local nInd
Local cEmail	:=Padr(UsrRetMail(__cUserId),50)

Local aURL		:={"www.proximogames.com.br/XMLData/b2w.xml","www.proximogames.com.br/XMLData/facebook-loja.xml"}

Private aFiles	:={"ProximoGames","UzGames"}
Private cPathArq	:="\XML_Vtex\"

For nInd:=1 To Len(aFiles)
	If !File(cPathArq+aFiles[nInd]+".xml")
		MsgStop("Arquivo "+aFiles[nInd]+" nใo encontrado"+CRLF+" Contate o Administrador","NcGames")
		Return
	EndIf
Next

//aAdd(aParamBox,{6,"Buscar arquivo XML",Space(50),"","","",50,.F.,"XML (*.xml) |*.xml"})
//aAdd(aParamBox,{3,"Qual Sistema?",1,aFiles,50,"",.F.})
//aAdd(aParamBox,{1,"E-mail",cEmail,"","","","",0,.T.}) // Tipo caractere
aAdd(aParamBox,{3,"URL XML",1,aURL,140,"",.F.})

//Do While .T.
	
	If !ParamBox(aParamBox,"Consulta Produto Vtex",@aRet)
		Return
	EndIf
	
	cUrl:=AllTrim(aURL[aRet[1]])
	
	//If !File(AllTrim(aRet[1]))
//		MsgStop("Arquivo ["+AllTrim(aRet[1])+"] nใo encontrado")
 //		Loop
//	EndIf
// Exit
 
 
//EndDo

Processa( {||VTEX02Get(cUrl,.F.) } )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX02  บAutor  ณMicrosiga           บ Data ณ  02/22/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX02Get(cUrlXML,lJob)
Local cPathReport	:="\XML_Vtex\Report"
Local cArqXML		
Local aReport		:={cPathReport+"\NcGames-Produtos-ProximoGames-0-OK.txt",cPathReport+"\NcGames-Produtos-uzgames-0-OK.txt"}
Local cError		:=""
Local cWarning		:=""
Local cArqXML		
Local aStruct 		:= { {"ID","C",15,0} }
Local lFundoBranco:=.T.
Local cCorLinha
Local cLine	:=""
Local cDrive:=""
Local cPath	:=""
Local cFName:=""
Local cExt :=""
Local cBuffer:=""
Local cPathRoot:=AllTrim(GetSrvProfString( "RootPath" , "" ) )
Local lB2W	:=.F.
Local nOpcao
Private nHdl
Private cExtExcel   	:= ".xls"
Private cPathExcel   :=GetTempPath()
Private cArqXls		:=E_Create(,.F.)

Default lJob:=.F.

//cUrlXML:="www.proximogames.com.br/XMLData/b2w.xml"

//SplitPath( cArquivo, @cDrive, @cPath, @cFName, @cExt )

//If !CpyT2S ( cArquivo, '\XML_Vtex\')
//	MsgStop("Nao foi possivel copiar o arquivo "+cArquivo+" para o Servidor","NcGames")
//	Return
//EndIf             

If "PROXIMO"$Upper(cUrlXML)
	cArqXML:="Proximo"
	nOpcao:=1
Else
	cArqXML:="UzGames"
	nOpcao:=2
EndIf	
cArqXML		:=cPathArq+aFiles[nOpcao]


cFName:=Atail(  Separa(cUrlXML,"/") )
Ferase(cPathArq+cFName)
ProcRegua(2)
IncProc("Buscando arquivo "+cUrlXML) 
WaitRunSrv(cPathRoot+cPathArq+"wget -t1 "+cUrlXML,.T.,cPathRoot+cPathArq)
                     

oXMl:=XmlParserFile( '\XML_Vtex\'+cFName, "_", @cError, @cWarning )

If !Empty(cError) .Or. ValType(oXMl) <>"O"
	MsgStop("Erro "+cError+" na leitura do XML","NcGames")
	Return
Endif

cNomArq 	:= CriaTrab(aStruct,.T.)
If Select("TRB")>0
	Trb->(DbCloseArea())
EndIf

dbUseArea( .T.,, cNomArq,"TRB", .T. , .F. )
IndRegua("TRB",cNomArq,"ID")

If "B2W"$Upper(cFName)
	oProduto:=oXMl:_CARGAPRODUTO:_PRODUTO
	lB2W:=.T.        	
Else
	oProduto:=oXMl:_PROXIMO_GAMES:_PRODUTO
EndIf

ProcRegua(Len(oProduto))

For nInd:=1 To Len(oProduto)
	IncProc("Gravando dados XML "+cUrlXML)
	TRB->(DbAppend())
	
	If lB2W
		TRB->ID:=oProduto[nInd]:_IDSKU:TEXT
	Else
		TRB->ID:=oProduto[nInd]:_ID_SKU:TEXT
	EndIf
Next

ProcRegua(2)
IncProc("Buscando Produtos do sistema "+cArqXML)
Ferase(aReport[nOpcao])
WaitRunSrv("D:\SmartBear\SoapUI-5.0.0\bin\testrunner.bat -sNcGames -cProdutos -a -f"+cPathRoot+cPathReport+" -I -S "+cPathRoot+cArqXML+".xml",.T.,'D:\SmartBear\SoapUI-5.0.0\bin\')


If !File(aReport[nOpcao])
	MsgStop("Nao foi possivel gerar arquivo de produtos do sistema "+aFiles[nOpcao])
	Return
EndIf

FT_FUSE(aReport[nOpcao]) //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER

nHdl := FCreate(cPathArq+cArqXls+cExtExcel)
VTEX02Cabec()

cLine+=' <Worksheet ss:Name="Produtos">'+CRLF
cLine+='  <Names>'+CRLF
cLine+='   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=Produtos!R1C1:R1C2"'+CRLF
cLine+='    ss:Hidden="1"/>'+CRLF
cLine+='  </Names>'+CRLF
cLine+='  <Table ss:ExpandedColumnCount="2" ss:ExpandedRowCount="999990" x:FullColumns="1"'+CRLF
cLine+='   x:FullRows="1" ss:DefaultColumnWidth="65.400000000000006"'+CRLF
cLine+='   ss:DefaultRowHeight="14.55">'+CRLF
cLine+='   <Column ss:Index="2" ss:Width="114"/>'+CRLF
cLine+='   <Row ss:AutoFitHeight="0">'+CRLF
cLine+='    <Cell ss:StyleID="s62"><Data ss:Type="String">ID</Data><NamedCell'+CRLF
cLine+='      ss:Name="_FilterDatabase"/></Cell>'+CRLF
cLine+='    <Cell ss:StyleID="s62"><Data ss:Type="String">Status</Data><NamedCell'+CRLF
cLine+='      ss:Name="_FilterDatabase"/></Cell>'+CRLF
cLine+='   </Row>'+CRLF


While !FT_FEOF() //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	
	IncProc("Comparando arquivos")
	cBuffer := AllTrim(FT_FREADLN()) //LENDO LINHA
	
	If AT('<a:Id>',cBuffer)>0
		
		cBuffer:=StrTran(cBuffer,'<a:Id>','')
		cBuffer:=StrTran(cBuffer,'</a:Id>','')
		
		If !Empty(cBuffer)
			If lFundoBranco
				cCorLinha:='s63'
			Else
				cCorLinha:='s64'
			EndIf
			lFundoBranco:=!lFundoBranco
			cLine+='  <Row ss:AutoFitHeight="0">'+CRLF
			cLine+='  <Cell ss:StyleID="'+cCorLinha+'"><Data ss:Type="Number">'+cBuffer+'</Data></Cell>'+CRLF
			cLine+='  <Cell ss:StyleID="'+cCorLinha+'"><Data ss:Type="String">'+IIF(TRB->(DbSeek(cBuffer)),"","Nao ")+"Encontrado no XML"+'</Data></Cell>'+CRLF
			cLine+='  </Row>'+CRLF
			VTEX02Write(@cLine)
			
		EndIf
	EndIf
	FT_FSKIP() //pr๓ximo registro no arquivo txt
	
EndDo
cLine:='  </Table>'+CRLF
VTEX02Write(@cLine)

FT_FUSE() //fecha o arquivo txt
VTEX02RodaPe()
FClose(nHdl)


TRB->(DbCloseArea())
fErase(cNomArq+GetDBExtension())
fErase(cNomArq+OrdBagExt())


cNomArq:="Produtos_"+dTos(MsDate()) + StrTran(Time(),":","")

If lJob
	//fRename( cPathArq+cArqXls+cExtExcel,cPathArq+cNomArq+cExtExcel )
	//MySndMail("Planilha", "Planilha"+DTOC(MsDate()), {cPathArq+cNomArq+cExtExcel}, cEmailTo)
Else
	
	IncProc("Copiando planilha "+cNomArq+" para "+cPathExcel)
	
	If __CopyFile(cPathArq+cArqXls+cExtExcel,cPathExcel+cArqXls+cExtExcel)
		fRename( cPathExcel+cArqXls+cExtExcel,cPathExcel+cNomArq+cExtExcel )
		If !lJob
			If !ApOleCliente( "MsExcel" )
				MsgStop( "Microsoft Excel nใo Instalado... Contate o Administrador do Sistema!" )
				MsgInfo( "Arquivo salvo em "+cPathExcel+cNomArq+cExtExcel)
			Else
				If MsgYesNo("Abrir o Microsoft Excel?")
					oExcelApp:=MsExcel():New()
					oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
					oExcelApp:SetVisible( .T. )
					oExcelApp:Destroy()
				EndIf
			EndIf
		EndIf
	ElseIf !lJob
		MsgStop("Erro ao copiar planilha")
	EndIf
EndIf

Ferase(cPathArq+cArqXls+cExtExcel)

//MsgInfo( ELAPTIME( cTimeIni, Time() ) )
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX02  บAutor  ณMicrosiga           บ Data ณ  02/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX02Cabec()
Local cLine:=""

cLine+='<?xml version="1.0"?>'+CRLF
cLine+='<?mso-application progid="Excel.Sheet"?>'+CRLF
cLine+='<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cLine+=' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF
cLine+=' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF
cLine+=' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cLine+=' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
cLine+=' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cLine+='  <Author>NcGames</Author>'+CRLF
cLine+='  <LastAuthor>NcGames</LastAuthor>'+CRLF
cLine+='  <Created>2015-02-24T16:24:57Z</Created>'+CRLF
cLine+='  <Version>15.00</Version>'+CRLF
cLine+=' </DocumentProperties>'+CRLF
cLine+=' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cLine+='  <AllowPNG/>'+CRLF
cLine+=' </OfficeDocumentSettings>'+CRLF
cLine+=' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cLine+='  <WindowHeight>9408</WindowHeight>'+CRLF
cLine+='  <WindowWidth>23040</WindowWidth>'+CRLF
cLine+='  <WindowTopX>0</WindowTopX>'+CRLF
cLine+='  <WindowTopY>0</WindowTopY>'+CRLF
cLine+='  <ProtectStructure>False</ProtectStructure>'+CRLF
cLine+='  <ProtectWindows>False</ProtectWindows>'+CRLF
cLine+=' </ExcelWorkbook>'+CRLF
cLine+=' <Styles>'+CRLF
cLine+='  <Style ss:ID="Default" ss:Name="Normal">'+CRLF
cLine+='   <Alignment ss:Vertical="Bottom"/>'+CRLF
cLine+='   <Borders/>'+CRLF
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
cLine+='   <Interior/>'+CRLF
cLine+='   <NumberFormat/>'+CRLF
cLine+='   <Protection/>'+CRLF
cLine+='  </Style>'+CRLF
cLine+='  <Style ss:ID="s62">'+CRLF
cLine+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cLine+='   <Borders>'+CRLF
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='   </Borders>'+CRLF
cLine+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"'+CRLF
cLine+='    ss:Bold="1"/>'+CRLF
cLine+='  </Style>'+CRLF
cLine+='  <Style ss:ID="s63">'+CRLF
cLine+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cLine+='   <Borders>'+CRLF
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='   </Borders>'+CRLF
cLine+='  </Style>'+CRLF
cLine+='  <Style ss:ID="s64">'+CRLF
cLine+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cLine+='   <Borders>'+CRLF
cLine+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cLine+='   </Borders>'+CRLF
cLine+='   <Interior ss:Color="#E2EFDA" ss:Pattern="Solid"/>'+CRLF
cLine+='  </Style>'+CRLF
cLine+=' </Styles>'+CRLF

VTEX02Write(cLine)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX02  บAutor  ณMicrosiga           บ Data ณ  02/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX02RodaPe()
Local cLine:=""

cLine+='<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cLine+='   <PageSetup>'+CRLF
cLine+='    <Header x:Margin="0.31496062000000002"/>'+CRLF
cLine+='    <Footer x:Margin="0.31496062000000002"/>'+CRLF
cLine+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
cLine+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
cLine+='   </PageSetup>'+CRLF
cLine+='   <Unsynced/>'+CRLF
cLine+='   <Print>'+CRLF
cLine+='    <ValidPrinterInfo/>'+CRLF
cLine+='    <PaperSizeIndex>9</PaperSizeIndex>'+CRLF
cLine+='    <HorizontalResolution>600</HorizontalResolution>'+CRLF
cLine+='    <VerticalResolution>600</VerticalResolution>'+CRLF
cLine+='   </Print>'+CRLF
cLine+='   <Selected/>'+CRLF
cLine+='   <Panes>'+CRLF
cLine+='    <Pane>'+CRLF
cLine+='     <Number>3</Number>'+CRLF
cLine+='     <ActiveRow>6</ActiveRow>'+CRLF
cLine+='     <ActiveCol>1</ActiveCol>'+CRLF
cLine+='    </Pane>'+CRLF
cLine+='   </Panes>+CRLF
cLine+='   <ProtectObjects>False</ProtectObjects>'+CRLF
cLine+='   <ProtectScenarios>False</ProtectScenarios>'+CRLF
cLine+='  </WorksheetOptions>'+CRLF
cLine+='  <AutoFilter x:Range="R1C1:R1C2" xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cLine+='  </AutoFilter>'+CRLF
cLine+=' </Worksheet>'+CRLF
cLine+='</Workbook>'+CRLF

VTEX02Write(cLine)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX02  บAutor  ณMicrosiga           บ Data ณ  02/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX02Write(cLine)
FWrite(nHdl,cLine,Len(cLine))
cLine:=""
Return   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX02  บAutor  ณMicrosiga           บ Data ณ  02/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                            
User Function VETEX02Arq(cPathReport,cArqXML)
Local cPathRoot:=AllTrim(GetSrvProfString( "RootPath" , "" ) )



Return                                     

User Function xvtex02()
Local cPathReport	:="\XML_Vtex\Report"
Local cArqXML	:="\XML_Vtex\ProximoGames"

U_VETEX02Arq(cPathReport,cArqXML)

Return