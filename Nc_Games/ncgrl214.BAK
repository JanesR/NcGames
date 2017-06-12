// #####################################################################################################
// Projeto:
// Modulo :
// Fonte  : NcgRl214
// ---------+-------------------+-----------------------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------------------
// 09/10/16 | Lucas Felipe      | geração dos relatorios Gerenciais para a analise dos auditores.
// ---------+-------------------+-----------------------------------------------------------------------

#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "topconn.ch"

#Define Enter Chr(13)+Chr(10)

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     11/10/2016
/*/
//------------------------------------------------------------------------------------------
User Function NcgRl214()

	Local dDtIni
	Local dDtFim
	Local cPacthP	:= ""
	Local aSays:={}
	Local aButtons:={}
	Local cPerg:="RL214XML1"
	Local lOk:=.F.
	Local cCadastro:="Estoque "

	Local aRel		:= {}
	Local aRet		:={}

	Private nHdl
	Private cPathExcel  := ""
	Private cExtExcel   := ".xml"
	Private lCSV

	AADD( aSays, "Relatório de movimentações de Estoque" )

	aAdd( aButtons, { 05, .T., {|| aRet:= ZC5Param() } } )
	AADD( aButtons, { 01, .T., {|| lOk := .T.,(cPathExcel:=cGetFile( "Defina o diretório | ",OemToAnsi("Selecione Diretorio de Gravação da Planilha"), ,"" ,.f.,GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE) ) ,Iif( !Empty(cPathExcel), FechaBatch(), msgStop("Informe o diretorio de gravaçao da planilha") ) } } )
	AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )

	FormBatch( cCadastro, aSays, aButtons )

	if len(aRet) > 0
		if valtype(aRet[1]) == "D" .And. valtype(aRet[2]) == "D"
	
			dDtIni 	:= aRet[1]
			dDtFim 	:= aRet[2]
		
		Else
			MsgAlert("Para gerar o relatório é necesasrio selecionar as datas!")
			return
		End
		
		Aadd(aRel,aRet[6])
		Aadd(aRel,aRet[7])
		Aadd(aRel,aRet[8])
		Aadd(aRel,aRet[9])
		Aadd(aRel,aRet[10])
		
		If lOk
			If aRet[4]=="1" //CSV
				lCSV := .T.
				Processa({ || Rl214CSV(dDtIni,dDtFim,aRel)})
			Else
				lCSV := .F.
				Processa({ || R214Gera(dDtIni,dDtFim,aRel)})
			EndIf
			
		EndIf
	Else
		MsgAlert("Os parametros para geração dos arquivos não selecionado! Nenhum arquivo sera gerado!")
	EndIf
	

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl214Xml

@author    Lucas Felipe
@since     10/10/2016
/*/
//------------------------------------------------------------------------------------------
Static function Rl214CSV(dDtIni,dDtFim,aRel)
	Local nInd
	Local cTexto := 'Arquivos Gerados em:' + cPathExcel
	Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
	Local cArq 		:= "Posi_est_"+DtoS(MsDate())
	Local cExtExcel	:= ".CSV"
	Local nArq := ""

	Local cCabec	:= "CODIGO;LOCAL_ORIGINAL;DESCRICAO;DISP_51;DISP_01"
	Local cCabec2	:= "CODIGO;LOCAL_ORIGINAL;DESCRICAO;DISP_01;DISP_51"
	//Local dDtIni := MsDate()-7
	//Local dDtFim := MsDate()
	Local cDataIni := DtoS(dDtIni)
	Local cDataFim := DtoS(dDtFim)
	Local cPacthP := "C:\relatorios"

	If !Empty(aRel)
		
		If aRel[1]
			cTableTr := RSB2Rows(cDataIni,"SALDO INICIAL")
		EndIF
		
		If aRel[2]
			cTableTr := RSD1Rows(cDataIni,cDataFim,"ENTRADA")
		EndIF
		
		If aRel[3]
			cTableTr := RSD3Rows(cDataIni,cDataFim,"MOVTO. INTERNO")
		EndIF
		
		If aRel[4]
			cTableTr := RSD2Rows(cDataIni,cDataFim,"SAIDA")
		EndIF
		
		If aRel[5]
			cTableTr := RSB2Atual(cDataFim,"SALDO FINAL")
		EndIF
		
		
	EndIf

	MsgAlert(cTexto)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static function R214Gera(dDtIni,dDtFim,aRel)

	Local cNomArq 		:= ""
	Local oExcelApp
	Local cDataIni
	Local cDataFim
	Local lExec			:= .F.
	
	Private cPathArq		:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
	Private cArqXls		:= E_Create(,.F.)
	
	Default cPathExcel 	:= "C:\relatorios"
	
	If !empty(aRel)
		nHdl := FCreate(cPathArq+cArqXls+cExtExcel)

	//Preenchimento do cabeçalho
		cLine:=Rl214Cabec()
	//Escreve o cabeçalho no arquivo
		RL214Write(cLine)
	
		cDataIni := DtoS(dDtIni)
		cDataFim := DtoS(dDtFim)
	
	//Gera pasta Saldo Inicial
		If aRel[1]
			lExec := .t.
			R214Pasta(1,"Saldo_Inicial_"+cDataIni,cDataIni,cDataFim)
		EndIf
	
	//Gera pasta Entradas
		If aRel[2]
			lExec := .t.
			R214Pasta(2,"Entradas",cDataIni,cDataFim)
		EndIf
	
	//Gera pasta Movimentos
		If aRel[3]
			lExec := .t.
			R214Pasta(3,"Movimentos",cDataIni,cDataFim)
		EndIf
	
	//Gera pasta Saidas
		If aRel[4]
			lExec := .t.
			R214Pasta(4,"Saidas",cDataIni,cDataFim)
		EndIf
	
	//Gera pasta Saldo Final
		If aRel[5]
			lExec := .t.
			R214Pasta(5,"Saldo_Final",cDataIni,cDataFim)
		EndIf

		If !lExec
	//Preenchimento do Rodapé
			cLine:=Rl214Rodap()
	//Escreve o Rodapé no arquivo
			cLine += '</Workbook>'+Enter
			RL214Write(cLine)
		Else
			cLine := '</Workbook>'+Enter
			RL214Write(cLine)
		EndIf
	
		FClose(nHdl)

		cNomArq:="Arquivo_de_Saldos"

		IncProc("Copiando planilha "+cNomArq+" para "+cPathExcel)

		If __CopyFile(cPathArq+cArqXls+cExtExcel, cPathExcel+cArqXls)
			Ferase(cPathArq+cArqXls)
		
			fRename( cPathExcel+cArqXls, cPathExcel+cNomArq+cExtExcel )
			If !ApOleCliente( "MsExcel" )
				MsgStop( "Microsoft Excel não Instalado... Contate o Administrador do Sistema!" )
			Else
				If MsgYesNo("Abrir o Microsoft Excel?")
					oExcelApp := MsExcel():New()
					oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
					oExcelApp:SetVisible( .T. )
					oExcelApp:Destroy()
				EndIf
			EndIf
		EndIf
	EndIf

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function Rl214Cabec()

	Local cCabec := ""

	cCabec+='	<?xml version="1.0"?>'+ Enter
	cCabec+='	<?mso-application progid="Excel.Sheet"?>'+ Enter
	cCabec+='	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+ Enter
 	cCabec+='	xmlns:o="urn:schemas-microsoft-com:office:office"'+ Enter
 	cCabec+='	xmlns:x="urn:schemas-microsoft-com:office:excel"'+ Enter
 	cCabec+='	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+ Enter
 	cCabec+='	xmlns:html="http://www.w3.org/TR/REC-html40">'+ Enter
 	cCabec+='	<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+ Enter
  	cCabec+='	<Author>Janes Isidoro</Author>'+ Enter
  	cCabec+='	<LastAuthor>Protheus</LastAuthor>'+ Enter
	cCabec+='	<Created>2016-11-21T11:45:06Z</Created>'+ Enter
  	cCabec+='	<Version>15.00</Version>'+ Enter
 	cCabec+='	</DocumentProperties>'+ Enter
 	cCabec+='	<OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+ Enter
  	cCabec+='	<AllowPNG/>'+ Enter
 	cCabec+='	</OfficeDocumentSettings>'+ Enter
 	cCabec+='	<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+ Enter
  	cCabec+='	<WindowHeight>9735</WindowHeight>'+ Enter
  	cCabec+='	<WindowWidth>24000</WindowWidth>'+ Enter
  	cCabec+='	<WindowTopX>0</WindowTopX>'+ Enter
  	cCabec+='	<WindowTopY>0</WindowTopY>'+ Enter
  	cCabec+='	<ActiveSheet>1</ActiveSheet>'+ Enter
  	cCabec+='	<ProtectStructure>False</ProtectStructure>'+ Enter
  	cCabec+='	<ProtectWindows>False</ProtectWindows>'+ Enter
 	cCabec+='	</ExcelWorkbook>'+ Enter
 	cCabec+='	<Styles>'+ Enter
  	cCabec+='	<Style ss:ID="Default" ss:Name="Normal">'+ Enter
   	cCabec+='	<Alignment ss:Vertical="Bottom"/>'+ Enter
   	cCabec+='	<Borders/>'+ Enter
   	cCabec+='	<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+ Enter
   	cCabec+='	<Interior/>'+ Enter
   	cCabec+='	<NumberFormat/>'+ Enter
   	cCabec+='	<Protection/>'+ Enter
  	cCabec+='	</Style>'+ Enter
  	cCabec+='	<Style ss:ID="s62">'+ Enter
   	cCabec+='	<NumberFormat ss:Format="Short Date"/>'+ Enter
  	cCabec+='	</Style>'+ Enter
 	cCabec+='	</Styles>'+ Enter
Return cCabec


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function Rl214Rodap()

	Local cRodape := ""

	cRodape += '    <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
	cRodape += '     <PageSetup>'+Enter
	cRodape += '      <Header x:Margin="0.31496062000000002"/>'+Enter
	cRodape += '      <Footer x:Margin="0.31496062000000002"/>'+Enter
	cRodape += '      <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
	cRodape += '       x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
	cRodape += '     </PageSetup>'+Enter
	cRodape += '     <Unsynced/>'+Enter
	cRodape += '     <ProtectObjects>False</ProtectObjects>'+Enter
	cRodape += '     <ProtectScenarios>False</ProtectScenarios>'+Enter
	cRodape += '    </WorksheetOptions>'+Enter
	cRodape += '   </Worksheet>'+Enter

Return cRodape

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function R214Pasta(nOpcao,cPasta,cDataIni,cDataFim)

	Local cTable	:= ""
	Local cTableTr := ""
	Local nRowTr	:= 0

	Default cPasta	:= "New Worksheet"+Alltrim(Str(Randomize(00,10)))
	Default nOpcao	:= 1
	Default cDataIni 	:= DtoS(MsDate()-7)
	Default cDataFim 	:= DtoS(MsDate())


 	cTable += '<Worksheet ss:Name="'+ cPasta +'">'+Enter
  	cTable += '<Table ss:ExpandedColumnCount="16" ss:ExpandedRowCount="99999" x:FullColumns="1"'+Enter
   	cTable += 'x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
   	cTable += '	<Column ss:Width="59.25"/>'+Enter
   	cTable += '	   <Column ss:Width="77.25"/>'+Enter
   	cTable += '	   <Column ss:Width="511.5"/>'+Enter
   	cTable += '	   <Column ss:Width="65.25"/>'+Enter
   	cTable += '	   <Column ss:Width="27"/>'+Enter
   	cTable += '	   <Column ss:Width="113.25"/>'+Enter
   	cTable += '	   <Column ss:Width="75.75"/>'+Enter
   	cTable += '	   <Column ss:Width="85.5"/>'+Enter
   	cTable += '	   <Column ss:Width="30"/>'+Enter
   	cTable += '	   <Column ss:Width="53.25"/>'+Enter
   	cTable += '	   <Column ss:Width="27"/>'+Enter
   	cTable += '	   <Column ss:Width="69"/>'+Enter
   	cTable += '	   <Column ss:Width="86.25"/>'+Enter
   	cTable += '	   <Column ss:Width="30"/>'+Enter
   	cTable += '	   <Column ss:Width="57.75"/>'+Enter
   	cTable += '	   <Column ss:Width="71.25"/>'+Enter
   	cTable += '	<Row ss:AutoFitHeight="0">'+Enter
   	cTable += '    <Cell><Data ss:Type="String">MOVIMENTO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">CODIGO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">DESCRICAO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">UNIDADE</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">TIPO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">DOC</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">EMISSAO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">EMISSAO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">QUANT</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">LOCAL</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">TES</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">DUPLIC</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">ESTOQUE</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">CFOP</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">CUSTO</Data></Cell>'+Enter
   	cTable += '    <Cell><Data ss:Type="String">CUSTO TOTAL</Data></Cell>'+Enter
   	cTable += '   </Row>'+Enter
	
	
	RL214Write(cTable)
	
	If nOpcao == 1 //Saldo Inicial
		cTableTr := RSB2Rows(cDataIni,"SALDO INICIAL")
	ElseIf nOpcao == 2 //Entradas
		cTableTr := RSD1Rows(cDataIni,cDataFim,"ENTRADA")
	ElseIf nOpcao == 3 //Movimentos
		cTableTr := RSD3Rows(cDataIni,cDataFim,"MOVTO. INTERNO")
	ElseIf nOpcao == 4 //Saidas
		cTableTr := RSD2Rows(cDataIni,cDataFim,"SAIDA")
	ElseIf nOpcao == 5 //Saldo final(Atual)
		cTableTr := RSB2Atual(cDataFim,"SALDO FINAL")
	EndIf

	cTable := '  </Table>'+Enter
	
	RL214Write(cTable)
	
	//Preenchimento do Rodapé
	cLine:=Rl214Rodap()
	//Escreve o Rodapé no arquivo
	RL214Write(cLine)
	
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function RSB2Rows(cDataRef,cMovime)

	Local aSaldo	 	:= {}
	Local nQuant	 	:= 0
	Local nValor		:= 0
	Local cAliasSB2 	:= GetNextAlias()
	Local cLine		:= ""
	Local dDataRef   
	Local nRows		:= 0
	Local lGeraCsv	:= IsInCallStack("Rl214CSV")
	Local nFile
	Local cabCSV := '"MOVIMENTO";"COD_PRODUTO";"DESC_PRODUTO";"UNI_MEDIDA";"TIPO";"NÚMERO DOCUMENTO";"DATA EMISSÃO";"DATA DIGITACAO";"QTDE";"ARMAZÉM";"TES";"GERA_DUPLIC";"CONT_ESTOQUE";"CFOP";"CUSTO";"CUSTO TOTAL";'+ Enter
	
	Local csvLinha := ''
	//Default cDataRef	:= DtoS(MsDate()-7)

	If lGeraCsv
		nFile := fcreate(cPathExcel+ "Saldos_Inicial_" + cDataRef +".csv",0)
		if nFile != -1
			fwrite(nFile, cabCSV)
		Else
			MsgAlert("Não foi Possivel Criar o Arquivo de Saldo Inicial!")
			Return
		EndIF
	EndIF

	BeginSql Alias cAliasSB2
	
		SELECT B2_COD, B1_XDESC, B1_UM, B2_QATU, B2_LOCAL, ROUND(B2_CM1), B2_FILIAL,	ROUND(B2_CM1*B2_QATU,2) CUSTOTOTAL
		FROM %Table:SB1% SB1
		INNER JOIN %Table:SB2% SB2
		ON SB2.B2_FILIAL = %xfilial:SB2%
		AND SB2.B2_LOCAL < '90'
		AND SB2.%notDel%
		AND SB2.B2_COD = SB1.B1_COD
		WHERE SB1.B1_FILIAL = %xfilial:SB1%
		AND SB1.%notDel%
		AND SB1.B1_TIPO = 'PA'
		

	EndSql

	Do While (cAliasSB2)->(!Eof())
	
		IncProc("Processando Saldo Inicial - Produto: "+(cAliasSB2)->B2_COD)
		If lGeraCsv
				
				dDataRef 	:= StoD(cDataRef)
				nQuant 	:= (aSaldo := CalcEst( (cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,dDataRef+1,(cAliasSB2)->B2_FILIAL ))[1]
				nValor 	:= aSaldo[2]
			
			If nFile != -1 .And. nQuant > 0
				
				csvLinha +='"'+ cMovime +'";'//Movimento
				csvLinha +='"'+ AllTrim((cAliasSB2)->B2_COD)+'";'//Cod Produto
				csvLinha +='"'+ AllTrim((cAliasSB2)->B1_XDESC)+'";'//Descrição Produto
				csvLinha +='"'+ AllTrim((cAliasSB2)->B1_UM)+'";'//Unidade de Medida
				csvLinha +='"";'//Tipo
				csvLinha +='"";'//Número Documento
				csvLinha +='"'+ RL214Trans(dDataRef) + '";'//Data Emissao
				csvLinha +='"'+ RL214Trans(dDataRef)+'";'//Data de Digitação
				csvLinha +='"'+ RL214Trans(nQuant)+'";'//Quantidade
				csvLinha +='"'+ AllTrim((cAliasSB2)->B2_LOCAL)+'";'//Armazem
				csvLinha +='"";'//TES
				csvLinha +='"";'//Gera Dupluqui
				csvLinha +='"";'//Cont_Estoque
				csvLinha +='"";'//CFOP
				csvLinha +='"'+ RL214Trans(ROUND(nValor/nQuant,2))+'";'//Custo
				csvLinha +='"'+ RL214Trans(nValor)+'";' + Enter//Custo Total
				
				fwrite(nFile, csvLinha)
				csvLinha := ''
			EndIF
		
		Else
		nRows 		:= nRows+1
		dDataRef 	:= StoD(cDataRef)
		nQuant 	:= (aSaldo := CalcEst( (cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,dDataRef+1,(cAliasSB2)->B2_FILIAL ))[1]
		nValor 	:= aSaldo[2]
		
		
		cLine += '   <Row ss:AutoFitHeight="0">'+Enter
		cLine += ' 	<Cell><Data ss:Type="String">'+ cMovime +'</Data></Cell>'+Enter //MOVIMENTO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B2_COD) +'</Data></Cell>'+Enter // COD PRODUTO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B1_XDESC) +'</Data></Cell>'+Enter //DESCRICAO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B1_UM) +'</Data></Cell>'+Enter // UNIDADE DE MEDIDA
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // TIPO
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // NUMERO DOCUMENTO
		cLine += ' 	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(dDataRef)+'</Data></Cell>'+Enter //EMISSAO
		cLine += ' 	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(dDataRef)+'</Data></Cell>'+Enter // DIGITACAO
		cLine += ' 	<Cell><Data ss:Type="Number">'+ RL214Trans(nQuant) +'</Data></Cell>'+Enter // QUANTIDAE
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B2_LOCAL) +'</Data></Cell>'+Enter // LOCAL
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // TES
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // GERA DUPLIC
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // CONT_ESTOQUE
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // CFOP
		cLine += ' 	<Cell><Data ss:Type="Number">'+ RL214Trans(nValor/nQuant) +'</Data></Cell>'+Enter // CUSTO
		cLine += ' 	<Cell><Data ss:Type="Number">'+ RL214Trans(nValor) +'</Data></Cell>'+Enter // CUSTO TOTAL
		cLine += '   </Row>'+Enter
		
		RL214Write(cLine)
		cLine := ''
		EndIf
		
		(cAliasSB2)->(DbSkip())
	
	EndDo

	(cAliasSB2)->(DbCloseArea())
	
    if nFile != -1
    	fclose(nFile)
    EndIf
    
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function RSD1Rows(cDataini,cDataFim,cMovime)

	Local aSaldo	 	:= {}
	Local nQuant	 	:= 0
	Local cAliasQry 	:= GetNextAlias()
	Local cLine		:= ""
	Local dDataRef
	Local nRows		:= 0
	Local lGeraCsv	:= IsInCallStack("Rl214CSV")
	Local cabCSV 		:= '"MOVIMENTO";"COD_PRODUTO";"DESC_PRODUTO";"UNI_MEDIDA";"TIPO";"NÚMERO DOCUMENTO";"DATA EMISSÃO";"DATA DIGITACAO";"QTDE";"ARMAZÉM";"TES";"GERA_DUPLIC";"CONT_ESTOQUE";"CFOP";"CUSTO";"CUSTO TOTAL";'+Enter
	Local nFile
	Local csvLinha	:=''
	Default cDataini	:= DtoS(MsDate()-7)
	Default cDataFim	:= DtoS(MsDate())
	
	If lGeraCsv
		nFile := fcreate(cPathExcel+ "Entradas de " + cDataini +" ate "+ cDataFim + ".csv",0)
		if nFile != -1
			fwrite(nFile, cabCSV)
		Else
			MsgAlert("Não foi Possivel Criar o Arquivo de Saldo Inicial!")
			Return
		EndIF
	EndIF

	BeginSql Alias cAliasQry
		
		SELECT B1_COD, B1_XDESC, B1_UM,F1_TIPO,D1_DOC,D1_EMISSAO,D1_DTDIGIT,D1_QUANT,D1_LOCAL,
		D1_TES, F4_DUPLIC, F4_ESTOQUE, D1_CF, D1_CUSTO, (CASE WHEN D1_QUANT = 0 THEN D1_CUSTO/1 ELSE ROUND(D1_CUSTO/D1_QUANT,4) END) CUSTO
		FROM %Table:SB1% SB1
		INNER JOIN %Table:SD1% SD1
		ON SD1.D1_FILIAL = %xfilial:SD1%
		AND SD1.%notDel%
		AND SD1.D1_COD = SB1.B1_COD
		AND SD1.D1_LOCAL BETWEEN ' ' AND '89'
		LEFT OUTER JOIN %Table:SF41% SF4
		ON SF4.F4_FILIAL = %xfilial:SF4%
		AND SF4.%notDel%
		AND SF4.F4_CODIGO = SD1.D1_TES
		INNER JOIN %Table:SF1% SF1
		ON SF1.F1_FILIAL = %xfilial:SF1%
		AND SF1.%notDel%
		AND SF1.F1_DOC = SD1.D1_DOC
		AND SF1.F1_SERIE = SD1.D1_SERIE
		AND SF1.F1_FORNECE = SD1.D1_FORNECE
		AND SF1.F1_LOJA = SD1.D1_LOJA
		AND SF1.F1_DTDIGIT BETWEEN %exp:cDataini% AND %exp:cDataFim%
		WHERE SB1.B1_FILIAL = %xfilial:SB1%
		AND SB1.%notDel%
		AND SB1.B1_TIPO = 'PA'
		AND SB1.B1_MSBLQL = '2'
		AND F4_ESTOQUE <> 'N'

	EndSql
	
	Do While (cAliasQry)->(!Eof())
	
		IncProc("Processando...")
		
		If lGeraCsv
			
			If nFile != -1
				csvLinha += '"'+cMovime+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->B1_COD)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->B1_XDESC)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->B1_UM)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->F1_TIPO)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->D1_DOC)+'";'
				csvLinha += '"'+RL214Trans(StoD((cAliasQry)->D1_EMISSAO))+'";'
				csvLinha += '"'+RL214Trans(StoD((cAliasQry)->D1_DTDIGIT))+'";'
				csvLinha += '"'+RL214Trans((cAliasQry)->D1_QUANT)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->D1_LOCAL)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->D1_TES)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->F4_DUPLIC)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->F4_ESTOQUE)+'";'
				csvLinha += '"'+AllTrim((cAliasQry)->D1_CF)+'";'
				csvLinha += '"'+RL214Trans((cAliasQry)->CUSTO)+'";'
				csvLinha += '"'+RL214Trans((cAliasQry)->D1_CUSTO)+'";'+Enter
				fwrite(nFile,csvLinha)
			EndIF
						
			csvLinha := ''
		Else
			
		nRows 		:= nRows+1
		
		cLine += '   <Row ss:AutoFitHeight="0">'+Enter
		cLine += '    <Cell><Data ss:Type="String">'+ cMovime +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_COD) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_XDESC) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_UM) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->F1_TIPO) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D1_DOC) +'</Data></Cell>'+Enter
		cLine += '   	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(StoD((cAliasQry)->D1_EMISSAO))+'</Data></Cell>'+Enter
		cLine += '   	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(StoD((cAliasQry)->D1_DTDIGIT))+'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->D1_QUANT) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D1_LOCAL) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D1_TES) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->F4_DUPLIC) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->F4_ESTOQUE) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D1_CF) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->CUSTO) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->D1_CUSTO) +'</Data></Cell>'+Enter
		cLine += '   </Row>'+Enter

		RL214Write(cLine)
		cLine := ''
		EndIF
		
		(cAliasQry)->(DbSkip())
	
	EndDo

	(cAliasQry)->(DbCloseArea())
    If nFile != -1
    	fclose(nFile)
    EndIF   
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function RSD3Rows(cDataini,cDataFim,cMovime)

	Local aSaldo	 	:= {}
	Local nQuant	 	:= 0
	Local cAliasQry 	:= GetNextAlias()
	Local cLine		:= ""
	Local dDataRef
	Local nRows		:= 0
	Local nCustoUni	:= 0
	Local lGeraCsv	:= IsInCallStack("Rl214CSV")
	Local nFile
	Local cabCSV :='"Movimento";"COD_PRODUTO";"	DESC_PRODUTO";"UNI_MEDIDA";"TIPO";"NÚMERO DOCUMENTO";"DATA EMISSÃO";"DATA DIGITACAO";"QTDE";"ARMAZÉM";"TES";"GERA_DUPLIC";"CONT_ESTOQUE";"CFOP";"CUSTO";"CUSTO_TOTAL";'+Enter
	Local linhaCSV := ''
	Default cDataini	:= DtoS(MsDate()-7)
	Default cDataFim	:= DtoS(MsDate())

	If lGeraCsv
		nFile := fcreate(cPathExcel+ "Movimentos de "  + cDataini +" ate "+ cDataFim + ".csv",0)
		if nFile != -1
			fwrite(nFile, cabCSV)
		Else
			MsgAlert("Não foi Possivel Criar o Arquivo de Movimentos!")
			Return
		EndIF
	EndIF

	BeginSql Alias cAliasQry
		
		SELECT SB1.B1_COD, SB1.B1_XDESC, D3_UM, D3_DOC, D3_EMISSAO, D3_TM, D3_QUANT, D3_LOCAL, D3_CUSTO1
		FROM %Table:SB1% SB1
		LEFT OUTER JOIN %Table:SD3% SD3
		ON SD3.D3_FILIAL = %xfilial:SD3%
		AND SD3.%notDel%
		AND SD3.D3_COD = SB1.B1_COD
		LEFT OUTER JOIN %Table:SF5% SF5
		ON SF5.F5_FILIAL = %xfilial:SF5%
		AND SF5.%notDel%
		AND SF5.F5_CODIGO = SD3.D3_TM
		WHERE SB1.B1_FILIAL = %xfilial:SB1%
		AND SB1.%notDel%
		AND SB1.B1_TIPO = 'PA'
		AND SD3.D3_EMISSAO BETWEEN %exp:cDataini% AND %exp:cDataFim%
		AND SD3.D3_LOCAL BETWEEN ' ' AND '99'
		ORDER BY B1_COD,D3_EMISSAO,D3_LOCAL, SD3.R_E_C_N_O_

	EndSql

	Do While (cAliasQry)->(!Eof())
	
		IncProc("Processando Movimentos Internos")
		
		If lGeraCsv
		nCustoUni := Iif((cAliasQry)->D3_CUSTO1==0,1/(cAliasQry)->D3_CUSTO1,(cAliasQry)->D3_QUANT/(cAliasQry)->D3_CUSTO1)
			if nFile != -1
				
				linhaCSV += '"' + cMovime + '";'//Movimento
				linhaCSV += '"' + AllTrim((cAliasQry)->B1_COD) + '";'//codigo
				linhaCSV += '"' + AllTrim((cAliasQry)->B1_XDESC) + '";'//descrição
				linhaCSV += '"' + AllTrim((cAliasQry)->D3_UM) + '";'//unidade de medida
				linhaCSV += '"' + AllTrim((cAliasQry)->D3_TM) + '";'//tipo
				linhaCSV += '"' + AllTrim((cAliasQry)->D3_DOC) + '";'//documento
				linhaCSV += '"' + RL214Trans(StoD((cAliasQry)->D3_EMISSAO)) + '";'//emissao
				linhaCSV += '"' + RL214Trans(StoD((cAliasQry)->D3_EMISSAO)) + '";'//emissao
				linhaCSV += '"' + RL214Trans((cAliasQry)->D3_QUANT) + '";'//quantidade
				linhaCSV += '"' + AllTrim((cAliasQry)->D3_LOCAL) + '";'//armazem
				linhaCSV += '"";'
				linhaCSV += '"";'
				linhaCSV += '"";'
				linhaCSV += '"";'							
				linhaCSV += '"' + RL214Trans(ROUND(nCustoUni,2)) + '";'
				linhaCSV += '"' + RL214Trans((cAliasQry)->D3_CUSTO1) + '";' + Enter
				
				fwrite(nFile, linhaCSV)
				linhaCSV := ''
			EndIf
		Else
		
		nRows 		:= nRows+1
		
		nCustoUni := Iif((cAliasQry)->D3_CUSTO1==0,1/(cAliasQry)->D3_CUSTO1,(cAliasQry)->D3_QUANT/(cAliasQry)->D3_CUSTO1)
		
		cLine += '   <Row ss:AutoFitHeight="0">'+Enter
		cLine += ' 	<Cell><Data ss:Type="String">'+ cMovime +'</Data></Cell>'+Enter //MOVIMENTO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_COD) +'</Data></Cell>'+Enter // COD PRODUTO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_XDESC) +'</Data></Cell>'+Enter //DESCRICAO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D3_UM) +'</Data></Cell>'+Enter // UNIDADE DE MEDIDA
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D3_TM) +'</Data></Cell>'+Enter // TIPO
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D3_DOC) +'</Data></Cell>'+Enter // NUMERO DOCUMENTO
		cLine += ' 	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(StoD((cAliasQry)->D3_EMISSAO))+'</Data></Cell>'+Enter //EMISSAO
		cLine += ' 	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(StoD((cAliasQry)->D3_EMISSAO))+'</Data></Cell>'+Enter // DIGITACAO
		cLine += ' 	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->D3_QUANT) +'</Data></Cell>'+Enter // QUANTIDAE
		cLine += ' 	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D3_LOCAL) +'</Data></Cell>'+Enter // LOCAL
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // TES
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // GERA DUPLIC
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // CONT_ESTOQUE
		cLine += ' 	<Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter // CFOP
		cLine += ' 	<Cell><Data ss:Type="Number">'+  RL214Trans(nCustoUni) +'</Data></Cell>'+Enter // CUSTO
		cLine += ' 	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->D3_CUSTO1) +'</Data></Cell>'+Enter // CUSTO TOTAL
		cLine += '   </Row>'+Enter
		
		RL214Write(cLine)
		cLine := ''
		EndIF
		
		(cAliasQry)->(DbSkip())
	
	EndDo

	(cAliasQry)->(DbCloseArea())
    If nFile != -1
    	fclose(nFile)
    EndIF
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function RSD2Rows(cDataini,cDataFim,cMovime)

	Local aSaldo	 	:= {}
	Local nQuant	 	:= 0
	Local cAliasQry 	:= GetNextAlias()
	Local cLine		:= ""
	Local dDataRef
	Local nRows		:= 0
	Local nCustoUni	:= 0
	Local lGeraCsv	:= IsInCallStack("Rl214CSV")
	Local nFile
	Local cabCSV :='"Movimento";"COD_PRODUTO";"DESC_PRODUTO";"UNI_MEDIDA";"TIPO";"NÚMERO DOCUMENTO";"DATA EMISSÃO";"DATA DIGITACAO";"QTDE";"ARMAZÉM";"TES	";"GERA_DUPLIC";"	CONT_ESTOQUE";"CFOP";"CUSTO";"CUSTO_TOTAL";'+Enter
	Local linhaCSV :=''
	Default cDataini	:= DtoS(MsDate()-7)
	Default cDataFim	:= DtoS(MsDate())

	If lGeraCsv
		nFile := fcreate(cPathExcel+ "Saidas de "  + cDataini +" ate "+ cDataFim +  ".csv",0)
		if nFile != -1
			fwrite(nFile, cabCSV)
		Else
			MsgAlert("Não foi Possivel Criar o Arquivo de Saidas!")
			Return
		EndIF
	EndIF

	BeginSql Alias cAliasQry
				
		SELECT B1_COD, B1_XDESC, B1_UM, F2_TIPO,D2_DOC, D2_EMISSAO, D2_QUANT, D2_LOCAL,D2_TES, F4_DUPLIC, F4_ESTOQUE, D2_CF, D2_CUSTO1
		FROM %Table:SB1% SB1
		INNER JOIN %Table:SD2% SD2
		ON SD2.D2_FILIAL = %xfilial:SD2%
		AND SD2.%notDel%
		AND SD2.D2_COD = sb1.B1_COD
		AND SD2.D2_LOCAL BETWEEN ' ' AND '89'
		INNER JOIN %Table:SF2% SF2
		ON SF2.F2_FILIAL = %xfilial:SF2%
		AND SF2.%notDel%
		AND SF2.F2_DOC = SD2.D2_DOC
		AND SF2.F2_SERIE = SD2.D2_SERIE
		AND SF2.F2_CLIENTE = SD2.D2_CLIENTE
		AND SF2.F2_LOJA = SD2.D2_LOJA
		AND SF2.F2_EMISSAO BETWEEN %exp:cDataini% AND %exp:cDataFim%
		LEFT OUTER JOIN %Table:SF4% SF4
		ON SF4.F4_FILIAL = %xfilial:SF4%
		AND SF4.%notDel%
		AND SF4.F4_CODIGO = SD2.D2_TES
		WHERE SB1.B1_FILIAL = %xfilial:SB1%
		AND SB1.%notDel%
		AND SB1.B1_TIPO = 'PA'
		AND F4_ESTOQUE <> 'N'
		
	EndSql

	Do While (cAliasQry)->(!Eof())
	
		IncProc("Processando Saidas..." + (cAliasQry)->B1_COD)
		
		If lGeraCsv
		
			nCustoUni := Iif((cAliasQry)->D2_CUSTO1==0,1/(cAliasQry)->D2_CUSTO1,(cAliasQry)->D2_QUANT/(cAliasQry)->D2_CUSTO1)
			if nFile != -1
				linhaCSV +='"'+ cMovime +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->B1_COD) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->B1_XDESC) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->B1_UM) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->F2_TIPO) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->D2_DOC) +'";'
				linhaCSV +='"'+ RL214Trans(StoD((cAliasQry)->D2_EMISSAO)) +'";'
				linhaCSV +='"'+ RL214Trans(StoD((cAliasQry)->D2_EMISSAO)) +'";'
				linhaCSV +='"'+ RL214Trans((cAliasQry)->D2_QUANT) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->D2_LOCAL) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->D2_TES) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->F4_DUPLIC) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->F4_ESTOQUE) +'";'
				linhaCSV +='"'+ AllTrim((cAliasQry)->D2_CF) +'";'
				linhaCSV +='"'+ RL214Trans(nCustoUni) +'";'
				linhaCSV +='"'+ RL214Trans((cAliasQry)->D2_CUSTO1) +'";'+Enter
				
				fwrite(nFile, linhaCSV)
				linhaCSV := ''
			EndIf
		
		Else
		
		nRows 		:= nRows+1
		
		nCustoUni := Iif((cAliasQry)->D2_CUSTO1==0,1/(cAliasQry)->D2_CUSTO1,(cAliasQry)->D2_QUANT/(cAliasQry)->D2_CUSTO1)
		    	
		cLine += '   <Row ss:AutoFitHeight="0">'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ cMovime +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_COD) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_XDESC) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->B1_UM) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->F2_TIPO) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D2_DOC) +'</Data></Cell>'+Enter
		cLine += '   	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(StoD((cAliasQry)->D2_EMISSAO))+'</Data></Cell>'+Enter
		cLine += '   	<Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(StoD((cAliasQry)->D2_EMISSAO))+'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->D2_QUANT) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D2_LOCAL) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D2_TES) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->F4_DUPLIC) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->F4_ESTOQUE) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="String">'+ AllTrim((cAliasQry)->D2_CF) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="Number">'+ RL214Trans(nCustoUni) +'</Data></Cell>'+Enter
		cLine += '   	<Cell><Data ss:Type="Number">'+ RL214Trans((cAliasQry)->D2_CUSTO1) +'</Data></Cell>'+Enter
		cLine += '   </Row>'+Enter
		
		RL214Write(cLine)
		cLine := ''
		EndIf
		
		(cAliasQry)->(DbSkip())
	
	EndDo

	(cAliasQry)->(DbCloseArea())
    
    If nFile != -1
    	fclose(nFile)
    EndIf
        
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function RSB2Atual(cDataFim,cMovime)

	Local aSaldo	 	:= {}
	Local nQuant	 	:= 0
	Local cAliasSB2 	:= GetNextAlias()
	Local cLine		:= ""
	Local nRows		:= 0
	Local lGeraCsv	:= IsInCallStack("Rl214CSV")
	Local nFile
	Local cabCSV := '"MOVIMENTO";"COD_PRODUTO";"DESC_PRODUTO";"UNI_MEDIDA";"TIPO";"NÚMERO DOCUMENTO";"DATA EMISSÃO";"DATA DIGITACAO";"QTDE";"ARMAZÉM";"TES";"GERA_DUPLIC";"CONT_ESTOQUE";"CFOP";"CUSTO";"CUSTO TOTAL";'+ Enter
	Local csvLinha := ''
	Local dDataRef := cDataFim
	Default cDataFim	:= DtoS(MsDate())

	If lGeraCsv
		nFile := fcreate(cPathExcel+ "Saldo Final de" + cDataFim +".csv",0)
		if nFile != -1
			fwrite(nFile, cabCSV)
		Else
			MsgAlert("Não foi Possivel Criar o Arquivo de Saldo Final!")
			Return
		EndIF
	EndIF

	BeginSql Alias cAliasSB2
	
		SELECT B2_COD, B1_XDESC, B1_UM, B2_QATU, B2_LOCAL, B2_CM1, B2_FILIAL,	ROUND(B2_CM1*B2_QATU,2) CUSTOTOTAL
		FROM %Table:SB1% SB1
		INNER JOIN %Table:SB2% SB2
		ON SB2.B2_FILIAL = %xfilial:SB2%
		AND SB2.B2_LOCAL BETWEEN ' ' AND '89'
		AND SB2.%notDel%
		AND SB2.B2_COD = SB1.B1_COD
		WHERE SB1.B1_FILIAL = %xfilial:SB1%
		AND SB1.%notDel%
		AND SB1.B1_TIPO = 'PA'

	EndSql

	Do While (cAliasSB2)->(!Eof())
	
		IncProc("Processando Saldo Final - Produto:"+(cAliasSB2)->B2_COD)
		
		If lGeraCsv
			dDataRef 	:= StoD(cDataFim)	
			
			nQuant 	:= (aSaldo := CalcEst( (cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,dDataRef+1,(cAliasSB2)->B2_FILIAL ))[1]
			nValor 	:= aSaldo[2]
			
			if nFile != -1 .And. nQuant > 0
			
				csvLinha +='"'+ cMovime +'";'//Movimento
				csvLinha +='"'+ AllTrim((cAliasSB2)->B2_COD)+'";'//Cod Produto
				csvLinha +='"'+ AllTrim((cAliasSB2)->B1_XDESC)+'";'//Descrição Produto
				csvLinha +='"'+ AllTrim((cAliasSB2)->B1_UM)+'";'//Unidade de Medida
				csvLinha +='"";'//Tipo
				csvLinha +='"";'//Número Documento
				csvLinha +='"'+ RL214Trans(dDataRef) + '";'//Data Emissao
				csvLinha +='"'+ RL214Trans(dDataRef)+'";'//Data de Digitação
				csvLinha +='"'+ RL214Trans(nQuant)+'";'//Quantidade
				csvLinha +='"'+ AllTrim((cAliasSB2)->B2_LOCAL)+'";'//Armazem
				csvLinha +='"";'//TES
				csvLinha +='"";'//Gera Dupluqui
				csvLinha +='"";'//Cont_Estoque
				csvLinha +='"";'//CFOP
				csvLinha +='"'+ RL214Trans(ROUND(nValor/nQuant,2))+'";'//Custo
				csvLinha +='"'+ RL214Trans(nValor)+'";' + Enter//Custo Total
				
				fwrite(nFile, csvLinha)
				csvLinha := ''

			EndIF
			
		Else
		nRows 		:= nRows+1
		dDataRef 	:= StoD(cDataFim)
		nQuant 	:= (aSaldo := CalcEst( (cAliasSB2)->B2_COD,(cAliasSB2)->B2_LOCAL,dDataRef+1,(cAliasSB2)->B2_FILIAL ))[1]
		nValor 	:= aSaldo[2]
		
		
		cLine := '   <Row ss:AutoFitHeight="0">'+Enter
		cLine += '    <Cell><Data ss:Type="String">'+ cMovime +'</Data></Cell>'+Enter // MOVIMENTO
		cLine += '    <Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B2_COD) +'</Data></Cell>'+Enter // CODIGO
		cLine += '    <Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B1_XDESC) +'</Data></Cell>'+Enter // DESCRIÇÃO PRODUTO
		cLine += '    <Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B1_UM) +'</Data></Cell>'+Enter // UNIDADE DE MEDIDA 
		cLine += '    <Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter //Tipo
		cLine += '    <Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter //Número Documento
		cLine += '    <Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(dDataRef)+'</Data></Cell>'+Enter // EMISSAO
		cLine += '    <Cell ss:StyleID="s62"><Data ss:Type="DateTime">'+ RL214Trans(dDataRef)+'</Data></Cell>'+Enter // DIGITACAO
		cLine += '    <Cell><Data ss:Type="Number">'+ RL214Trans(nQuant) +'</Data></Cell>'+Enter //Quantidade
		cLine += '    <Cell><Data ss:Type="String">'+ AllTrim((cAliasSB2)->B2_LOCAL) +'</Data></Cell>'+Enter  //Local
		cLine += '    <Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter //TES
		cLine += '    <Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter //GERA DUPLI
		cLine += '    <Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter //CONT_ESTOQUE
		cLine += '    <Cell><Data ss:Type="String">'+ " " +'</Data></Cell>'+Enter //cfop
		cLine += '    <Cell><Data ss:Type="Number">'+ RL214Trans(ROUND(nValor/nQuant,2)) +'</Data></Cell>'+Enter //CUSTO
		cLine += '    <Cell><Data ss:Type="Number">'+ RL214Trans(nValor) +'</Data></Cell>'+Enter //CUSTO TOTAL
		cLine += '   </Row>'+Enter
		
		RL214Write(cLine)
		cLine := ''
		EndIf
		
		(cAliasSB2)->(DbSkip())
	
	EndDo

	(cAliasSB2)->(DbCloseArea())
    
    If nFile != -1
    	fclose(nFile)
    EndIf 
       
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------
Static Function RL214Trans(xDados)
	Local xRetorno

	If ValType(xDados)=="N"
		If lCSV
			xRetorno:=AllTrim(strtran(Str(xDados),'.',','))
		Else 
			xRetorno:=AllTrim(Str(round(xDados,2)))		
		EndIF
	ElseIf ValType(xDados)=="D"
		If lCSV
			xRetorno:=StrZero(Day(xDados),2)+"/"+StrZero(Month(xDados),2)+"/"+StrZero(Year(xDados),4)
		Else
			xRetorno:=StrZero(Year(xDados),4)+"-"+StrZero(Month(xDados),2)+"-"+StrZero(Day(xDados),2)+'T00:00:00.000'
		EndIF
	ElseIf ValType(xDados)=="U"
		xRetorno:=" "
	EndIf

Return xRetorno

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------

Static Function RL214Write(cLine)
	FWrite(nHdl,cLine,Len(cLine))
Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@since     09/10/2016
/*/
//------------------------------------------------------------------------------------------

Static Function ZC5Param()

	Local aArea 	:= GetArea()
	Local aParam 	:= {}
	Local aButtons:= {}
	Local aPergs 	:= {}
	Local lRet   	:= .T.

	Local lParam1 	:= .F.
	Local lParam2 	:= .F.
	Local lParam3 	:= .F.
	Local lParam4 	:= .F.
	Local lParam5 	:= .F.
	Local lParam6 	:= .F.
	Local lParam7 	:= .F.
	Local cPathExcel 	:= ""

	aAdd(aPergs,{1,"Data De? "	,CtoD("//")	,"@D"	,"","","",70,.T.})
	aAdd(aPergs,{1,"Data Até?"	,CtoD("//")	,"@D"	,"","","",70,.T.})
	
	aAdd( aPergs ,{9,"Em qual extensão deseja gravar o arquivo.",200,10,.F.})
	aAdd( aPergs ,{2,""	,"1",{"1=CSV","2=XML"},70 ,"" ,.T.})
	//aAdd( aPergs ,{2,""	,"1",{"1=CSV"},70 ,"" ,.T.})
	
	aAdd( aPergs ,{9,"Quais relatórios deseja gerar?",200,10,.F.})
	
	aAdd( aPergs ,{5,"Saldo Inicial"  		,lParam3 ,70 ,"" ,.F.})
	aAdd( aPergs ,{5,"Entrada"  			,lParam4 ,70 ,"" ,.F.})
	aAdd( aPergs ,{5,"Movimento"  			,lParam5 ,70 ,"" ,.F.})
	aAdd( aPergs ,{5,"Saída"  				,lParam6 ,70 ,"" ,.F.})
	aAdd( aPergs ,{5,"Saldo Final"  		,lParam7 ,70 ,"" ,.F.})
	
	//aAdd( aPergs ,{6,"Endereço de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos","",GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE})

	ParamBox(aPergs, "Parâmetros", aParam,/*BoK*/,/*aButtons*/, .T.,300,600,/*oDlgWizard*/,/*clLoad*/, .T., .T.)

	RestArea(aArea)

Return aParam


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl214Xml

@author    Lucas Felipe
@since     10/10/2016
/*/
//------------------------------------------------------------------------------------------
Static function Rl214Xml()

	Local aSays:={}
	Local aButtons:={}
	Local cPerg:="RL214XML1"
	Local lOk:=.F.
	Local cCadastro:="Estoque "

	Private nHdl
	Private cPathExcel  := ""
	Private cExtExcel   := ".xml"

	PutSx1(cPerg,"01","Data De?"		,"Data De?","Data De?"			,"MV_CH1","D",8,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",{},"","",".NCGRL20203.")
	PutSx1(cPerg,"02","Data Até?"		,"Data Até?","Data Até?"			,"MV_CH2","D",8,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",{},"","",".NCGRL20204.")
	PutSx1(cPerg,"03","Saldo Inicial"	,"Saldo Inicial","Saldo Inicial","MV_CH3","C",1,0,0,"C","","","","","mv_par03","Sim","Sim","Sim","1","Não","Não","Não","","","","","","","","","",{},,)
	PutSx1(cPerg,"04","Entrada"			,"Entrada","Entrada"				,"MV_CH4","C",1,0,0,"C","","","","","mv_par04","Sim","Sim","Sim","1","Não","Não","Não","","","","","","","","","",{},,)
	PutSx1(cPerg,"05","Movimento"		,"Movimento","Movimento"			,"MV_CH4","C",1,0,0,"C","","","","","mv_par05","Sim","Sim","Sim","1","Não","Não","Não","","","","","","","","","",{},,)
	PutSx1(cPerg,"06","Saída"			,"Saída","Saída"					,"MV_CH5","C",1,0,0,"C","","","","","mv_par06","Sim","Sim","Sim","1","Não","Não","Não","","","","","","","","","",{},,)
	PutSx1(cPerg,"07","Saldo Final"		,"Saldo Final","Saldo Final"	,"MV_CH6","C",1,0,0,"C","","","","","mv_par07","Sim","Sim","Sim","1","Não","Não","Não","","","","","","","","","",{},,)
	
	Pergunte(cPerg, .f.)

	AADD( aSays, "Relatório de movimentações de Estoque" )

	aAdd( aButtons, { 05, .T., {|| Pergunte( cPerg, .t. ) } } )
	AADD( aButtons, { 01, .T., {|| lOk := .T.,(cPathExcel:=cGetFile( "Defina o diretório | ",OemToAnsi("Selecione Diretorio de Gravação da Planilha"), ,"" ,.f.,GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE) ) ,Iif( !Empty(cPathExcel), FechaBatch(), msgStop("Informe o diretorio de gravaçao da planilha") ) } } )
	AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )

	FormBatch( cCadastro, aSays, aButtons )

	If lOk
		Processa({ || R214Gera()})
	EndIf

Return