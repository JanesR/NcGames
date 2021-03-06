#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF13		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Relat�rio de inconsist�ncia da integra��o com o Web Manager���
���          � 			  				  								  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF13() 

Local aArea := GetArea()

//Gera o relatorio de inconsistencia 
Processa({ || GerRel()})

RestArea(aArea)
Return
                    

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWMJF13		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina (JOB) utilizada para gerar relat�rio 			      ���
���          � de inconsistencia na integra��o com Web Manager			  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWMJF13(aDados) 

Default aDados:={"01","03",.F.}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])  

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCWMJF13", "Relatorio de inconsistencia - Financeiro", "FINANCEIRO", MsDate() )

//Executa a rotina para gerar o relatorio
JobErrIWM()

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCWMJF13", "Relatorio de inconsistencia - Financeiro", "FINANCEIRO", MsDate(), "F" )


RpcClearEnv()
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GerRel		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     �Gera o relatorio em excel								  	  ���
���          � 											  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/        
Static Function GerRel(lJob, cDir)

Local aArea 	:= GetArea()
Local cArqTmp   := ""
Local nQtdReg	:= 0
Local cNameArq 	:= "RelInconsistenciaFinanceiroWM_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
Local apExcel	:= {}  

Default lJob	:= .F. 
Default cDir	:= ""

cArqTmp   := GetDRel()

If (cArqTmp)->(!Eof())

	//Verifica quantidade de registros
	(cArqTmp)->( dbEval( {|| nQtdReg++ } ) )
	(cArqTmp)->( dbGoTop() )
	
	++nQtdReg//Soma 1, para considerar o cabe�alho
	ProcRegua(nQtdReg)
	
	WrTXMLArq(1,@apExcel, nQtdReg)
	
	While (cArqTmp)->(!Eof())
		IncProc("Processando...")
		
		WrTXMLArq(2,;
					@apExcel,;
					nQtdReg,;
					(cArqTmp)->PZP_EMPORI,; //Codigo da empresa
					(cArqTmp)->PZP_FILORI,; //Filial
					(cArqTmp)->PZP_CODLJ,; //Codigo da loja
					(cArqTmp)->PZP_NOMELJ,; //Nome da loja
					(cArqTmp)->PZP_DTMOVI,;//Data do movimento
					(cArqTmp)->PZP_OPER,; //Tipo de opera��o
					(cArqTmp)->PZP_CODMOV,; //Codigo do Web Manager
					(cArqTmp)->PZP_NOTA,; //Cupom Fiscal
					(cArqTmp)->PZP_CODFIN,; //Codigo Financeiro
					(cArqTmp)->PZP_DESCFI,; //Descri��o Financeiro
					(cArqTmp)->PZP_VLOPER,; //Valor da opera��o
					(cArqTmp)->PZP_TOTOPE,; //Valor total da opera��o
					(cArqTmp)->PZP_LOGERR)//Mensagem de erro
		
		(cArqTmp)->(DbSkip())
	EndDo
	WrTXMLArq(3,@apExcel)
	
	
	If lJob//Verifica se o processo foi executado por job	

		//Chama a rotina para gerar Excel (Chamada por job)
		GeraExcel(apExcel, cNameArq, .T., cDir )
	Else	
		
		//Chama a rotina para gerar Excel (Chamada por Menu)
		GeraExcel(apExcel, cNameArq, .F.)
	EndIf
Else
	If !lJob
		Aviso("Registro n�o encontrado","Nenhum registro encontrado.",{"Ok"},2)	
	EndIf
	cNameArq 	:= ""
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cNameArq


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetDRel		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o arquivo temporario com os dados do relatorio 	  ���
���          � 											  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/        
Static Function GetDRel()

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias() 
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))

cQuery    := " SELECT PZP_EMPORI, PZP_FILORI, PZP_CODLJ, PZP_NOMELJ, PZP_DTMOVI, PZP_OPER, " 
cQuery    += " 			PZP_CODMOV, PZP_NOTA, PZP_CODFIN, PZP_DESCFI, PZP_VLOPER, PZP_TOTOPE, "+CRLF
cQuery    += "         	utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(PZP_LOGERR,2000,1)) PZP_LOGERR FROM "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
cQuery    += " WHERE PZP.PZP_FILIAL = '"+xFilial("PZP",cEmpAux)+"'  "+CRLF
cQuery    += " AND PZP.PZP_PREFIX = ' ' "+CRLF
cQuery    += " AND PZP.D_E_L_E_T_ = ' ' "+CRLF

//Aviso("",cQuery,{"Ok"},3)
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

RestArea(aArea)
Return cArqTmp          


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �JobErrIWM � Autor � Microsiga		     � Data �  11/06/15   ���
�������������������������������������������������������������������������͹��
���Descricao � Fun��o utilizada em schedule para enviar o relatorio geral ���
���          � de todos os vendedores 			 			              ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function JobErrIWM()

Local aArea 		:= GetArea()
Local cNameArq 		:= ""
Local cDir			:= "\IntegracaoWM\"
Local cEmailPara    := U_MyNewSX6("NC_IWMEMF",;
									"esantana@ncgames.com.br;",;
									"C",;
									"E-mail para envio do WF c/ relatorio de inconsist�ncia na integra��o com WM (Financeiro)",;
									"E-mail para envio do WF c/ relatorio de inconsist�ncia na integra��o com WM (Financeiro)",;
									"E-mail para envio do WF c/ relatorio de inconsist�ncia na integra��o com WM (Financeiro)",;
									.F. )
Local cMsgEmail	:= ""
Local cAssunto	:= "Inconsist�ncia na integra��o Web Manager x Protheus (Financeiro)"

cMsgEmail	:= "Relat�rio com as inconsist�ncias encontradas na integra��o entre os sistemas Web Manager e Protheus.  "+CRLF+CRLF
cMsgEmail	+= " E-mail autom�tico, favor n�o responder."+CRLF

//Gerar o arquivo do relatorio
cNameArq := GerRel(.T., cDir)

If !Empty(cNameArq) .And. !Empty(cEmailPara)
    
	//Envia o Arquivo por e-mail
	NCEnvEmail(cAssunto,;//Assunto
				cMsgEmail,;//Mensagem
				{cDir+cNameArq},;//Anexo
				Alltrim(cEmailPara),;//E-mail do destinatario
				"",;//C�pia do e-mail
				"")
				
	//Exclui o arquivo temporario do relatorio, ap�s o envio do e-mail
	ExclArq(cDir, cNameArq)

EndIf
		    
RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WrTXMLArq  �Autor  �Microsiga         � Data �  01/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna os dados do XML a ser gravado no relat�rio do Excel���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                  	      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/            
Static Function WrTXMLArq(nOpc, apExcel, nQtdReg, cEmpWM, cFilWM, cCodLoja, cNomeLoja, cDtMovimto,;
							 cTpOper, cCodWM, cCupom, cCodFin, cDescFin, nValOper, nTotValOper, cErro)
								
                     
Local cDtMovAux	:= ""

Default nOpc 		:= 1
Default apExcel 	:= {}
Default nQtdReg		:= 0 
Default cEmpWM		:= ""
Default cFilWM		:= ""	
Default cCodLoja	:= ""
Default cNomeLoja	:= ""
Default cDtMovimto	:= ""
Default cTpOper		:= ""
Default cCodWM		:= ""
Default cCupom		:= ""
Default cCodFin		:= ""
Default cDescFin	:= ""
Default nValOper	:= 0
Default nTotValOper	:= 0
Default cErro		:= ""


//Converte a data de emiss�o para o formado do excel
cDtMovAux	:= SubStr(cDtMovimto,1,4)+"-"+SubStr(cDtMovimto,5,2)+"-"+SubStr(cDtMovimto,7,2)+"T00:00:00.000"

If nOpc == 1
	Aadd(apExcel, '<?xml version="1.0"?>'+CRLF)
	Aadd(apExcel, '<?mso-application progid="Excel.Sheet"?>'+CRLF)
	Aadd(apExcel, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF)
	Aadd(apExcel, ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF)
	Aadd(apExcel, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF)
	Aadd(apExcel, ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '  <Author>Elton Santana</Author>'+CRLF)
	Aadd(apExcel, '  <LastAuthor>Elton Santana</LastAuthor>'+CRLF)
	Aadd(apExcel, '  <Created>2015-06-10T19:51:46Z</Created>'+CRLF)
	Aadd(apExcel, '  <LastSaved>2015-06-11T12:56:08Z</LastSaved>'+CRLF)
	Aadd(apExcel, '  <Version>15.00</Version>'+CRLF)
	Aadd(apExcel, ' </DocumentProperties>'+CRLF)
	Aadd(apExcel, ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '  <AllowPNG/>'+CRLF)
	Aadd(apExcel, ' </OfficeDocumentSettings>'+CRLF)
	Aadd(apExcel, ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '  <WindowHeight>9735</WindowHeight>'+CRLF)
	Aadd(apExcel, '  <WindowWidth>24000</WindowWidth>'+CRLF)
	Aadd(apExcel, '  <WindowTopX>0</WindowTopX>'+CRLF)
	Aadd(apExcel, '  <WindowTopY>0</WindowTopY>'+CRLF)
	Aadd(apExcel, '  <ProtectStructure>False</ProtectStructure>'+CRLF)
	Aadd(apExcel, '  <ProtectWindows>False</ProtectWindows>'+CRLF)
	Aadd(apExcel, ' </ExcelWorkbook>'+CRLF)
	Aadd(apExcel, ' <Styles>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '   <Borders/>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <Interior/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat/>'+CRLF)
	Aadd(apExcel, '   <Protection/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s16" ss:Name="Vírgula">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s17">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s18">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s19" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s20" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s66">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s67">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, ' </Styles>'+CRLF)
	Aadd(apExcel, ' <Worksheet ss:Name="Plan1">'+CRLF)
	Aadd(apExcel, '  <Table ss:ExpandedColumnCount="13" ss:ExpandedRowCount="'+Alltrim(Str(nQtdReg))+'" x:FullColumns="1"'+CRLF)
	Aadd(apExcel, '   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:Width="47.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:AutoFitWidth="0" ss:Width="36.75"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:Width="45"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:Width="154.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="73.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:Width="72.75"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:Width="92.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:AutoFitWidth="0" ss:Width="77.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:AutoFitWidth="0" ss:Width="88.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s67" ss:AutoFitWidth="0" ss:Width="129"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s20" ss:AutoFitWidth="0" ss:Width="91.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s20" ss:Width="103.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="364.5"/>'+CRLF)
	Aadd(apExcel, '   <Row>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Empresa </Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Filial</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Cod.Loja</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Nome da Loja</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s17"><Data ss:Type="String">Dt.Movimento</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Tipo Operação</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Cod.Web Manager</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Cupom</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Cod.Financeiro</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s66"><Data ss:Type="String">Descrição Financeiro</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s19"><Data ss:Type="String">Valor Oepração</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s19"><Data ss:Type="String">Valor Total Operação</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s17"><Data ss:Type="String">Erro</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)


ElseIf nOpc == 2
	
	Aadd(apExcel, '   <Row>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+Alltrim(cEmpWM)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+Alltrim(cFilWM)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(cCodLoja)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+Alltrim(cNomeLoja)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="DateTime">'+cDtMovAux+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+Alltrim(cTpOper)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(cCodWM)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(cCupom)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(cCodFin)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+Alltrim(cDescFin)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(Str(nValOper))+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(Str(nTotValOper))+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+Alltrim(cErro)+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)
	
ElseIf nOpc == 3

  	Aadd(apExcel, '</Table>'+CRLF)
	Aadd(apExcel, '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '   <PageSetup>'+CRLF)
	Aadd(apExcel, '    <Header x:Margin="0.31496062000000002"/>'+CRLF)
	Aadd(apExcel, '    <Footer x:Margin="0.31496062000000002"/>'+CRLF)
	Aadd(apExcel, '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF)
	Aadd(apExcel, '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF)
	Aadd(apExcel, '   </PageSetup>'+CRLF)
	Aadd(apExcel, '   <Print>'+CRLF)
	Aadd(apExcel, '    <ValidPrinterInfo/>'+CRLF)
	Aadd(apExcel, '    <PaperSizeIndex>9</PaperSizeIndex>'+CRLF)
	Aadd(apExcel, '    <HorizontalResolution>600</HorizontalResolution>'+CRLF)
	Aadd(apExcel, '    <VerticalResolution>600</VerticalResolution>'+CRLF)
	Aadd(apExcel, '   </Print>'+CRLF)
	Aadd(apExcel, '   <Selected/>'+CRLF)
	Aadd(apExcel, '   <Panes>'+CRLF)
	Aadd(apExcel, '    <Pane>'+CRLF)
	Aadd(apExcel, '     <Number>3</Number>'+CRLF)
	Aadd(apExcel, '     <ActiveRow>11</ActiveRow>'+CRLF)
	Aadd(apExcel, '     <ActiveCol>9</ActiveCol>'+CRLF)
	Aadd(apExcel, '    </Pane>'+CRLF)
	Aadd(apExcel, '   </Panes>'+CRLF)
	Aadd(apExcel, '   <ProtectObjects>False</ProtectObjects>'+CRLF)
	Aadd(apExcel, '   <ProtectScenarios>False</ProtectScenarios>'+CRLF)
	Aadd(apExcel, '  </WorksheetOptions>'+CRLF)
	Aadd(apExcel, ' </Worksheet>'+CRLF)
	Aadd(apExcel, '</Workbook>'+CRLF)

EndIf

Return 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GeraExcel �Autor  �Microsiga		     � Data �  11/06/2015 ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que cria e escreve o arquivo excel.                  ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GeraExcel(alPlanilha, cNameArq, lJob, cDirJob)
	
Local nlHandle
Local clLocal 	:= ""
Local olExcelApp
Local aPerg		:= {}
Local lRet		:= .T.

Default alPlanilha	:= {}
Default cNameArq 	:= ""
Default lJob 		:= .F.
Default cDirJob		:= ""


If !lJob
	
	aPerg	:= PergFile()//Pergunta com o endere�o do arquivo
	
	If Len(aPerg[2] ) > 0
		If !aPerg[1]
			Return
		EndIf
	Else
		return
	EndIf
	clDir := Alltrim(aPerg[2][1])
	clLocal := clDir + cNameArq
	
	nlHandle  := FCREATE(clLocal)
	
	if nlHandle == -1
		MsgStop("N�o foi poss�vel criar o arquivo em: " + CRLF + clLocal)
	else
		AEVAL(alPlanilha, {|x| FWRITE(nlHandle, x)} )
		FCLOSE(nlHandle)
		
		if File(clLocal)
			
			If Aviso("Abrir arquivo","Deseja abrir o arquivo ?",{"Sim","N�o"},2) == 1
				olExcelApp	:= MsExcel():New()
				olExcelApp:WorkBooks:Open(clLocal)
				olExcelApp:SetVisible(.T.)
				olExcelApp:Destroy()
			EndIf
			
		else
			Conout("Erro ao criar o arquivo em: " + clLocal)
			MsgAlert("Erro ao criar o arquivo em: " + clLocal)
		endif
		
	endif
	
	
Else
	
	clDir 	:= cDirJob
	
	//Verifica se existe o diret�rio, sen�o existir ser� criado no ProtheusData
	If !EXISTDIR(clDir)
		If MakeDir( clDir ) < 0
			lRet := .F.
			Conout("Erro na cria��o do diretorio")
			
			Return lRet
		Else
			lRet := .T.
		EndIf
	EndIf
	
	If lRet
		clLocal := clDir + cNameArq
		nlHandle  := FCREATE(clLocal)
		
		if nlHandle == -1
			Conout("N�o foi poss�vel criar o arquivo em: " + CRLF + clLocal)
		else
			AEVAL(alPlanilha, {|x| FWRITE(nlHandle, x)} )
			FCLOSE(nlHandle)
			
			/*if File(clLocal)
				olExcelApp	:= MsExcel():New()
				olExcelApp:WorkBooks:Open(clLocal)
				olExcelApp:Destroy()
			else
				Conout("Erro ao criar o arquivo em: " + clLocal)
			endif*/
		endif
	EndIf
EndIf

Return lRet     


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PergFile	�Autor  �Microsiga			 � Data �  11/06/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Pergunta com o endere�o do arquivo				          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere�o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere�o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ExclArq	� Autor � Microsiga		     � Data �  02/02/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Exclui arquivos ap�s o envio do e-mail					  ���
���          �                      									  ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ExclArq(cDir, cNomeArq)

Local aArea		:= GetArea()
Local nRetExc   := 0
Local cMsgErr	:= ""
Local lRet		:= .T. 

Default cDir 		:= ""  
Default cNomeArq    := ""


nRetExc := FERASE(Alltrim(cDir)+Alltrim(cNomeArq))
If nRetExc !=  0
	conout("Erro ao excluir arquivo -> "+Alltrim(cDir)+Alltrim(cNomeArq))
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCEnvEmail  �Autor  �Microsiga         � Data �  01/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCEnvEmail(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
Local lRetorno	:= .T.
Local cServer   := GetNewPar("MV_RELSERV","") 
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Default aAnexos		:= {}
Default cBody		:= ""
Default cAssunto	:= ""
Default cErro		:= ""
Default cEmailCc	:= ""

If MailSmtpOn( cServer, cAccount, cPassword )
	If lMailAuth
		If ! ( lRetorno := MailAuth(cAccount,cPassword) )
			lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
		EndIf
	Endif
	If lRetorno
		If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cBody,aAnexos,.F.)
			cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
			lRetorno := .F.
		EndIf
	Else
		cErro := "Erro na tentativa de autentica��o da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conex�o com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return lRetorno
