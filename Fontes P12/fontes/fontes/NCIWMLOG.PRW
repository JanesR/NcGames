#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMF13		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de log de processamento (Integra็ใo Web manager) บฑฑ
ฑฑบ          ณ 			  				  								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWMLOG() 

Local aArea := GetArea()

//Gera o relatorio de inconsistencia 
Processa({ || GerRel()})

RestArea(aArea)
Return
                    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCWMJLOG		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina (JOB) utilizada para gerar relat๓rio de log de      บฑฑ
ฑฑบ          ณ processamento (Integra็ใo Web manager)					  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCWMJLOG(aDados) 

Default aDados:={"01","03",.F.}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])  

//Executa a rotina para gerar o relatorio
JobLogIWM()

RpcClearEnv()
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerRel		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera o relatorio em excel								  	  บฑฑ
ฑฑบ          ณ 											  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/        
Static Function GerRel(lJob, cDir)

Local aArea 	:= GetArea()
Local cArqTmp   := ""
Local nQtdReg	:= 0
Local cNameArq 	:= "RelLogWM_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
Local apExcel	:= {}  

Default lJob	:= .F. 
Default cDir	:= ""

cArqTmp   := GetDRel()

If (cArqTmp)->(!Eof())

	//Verifica quantidade de registros
	(cArqTmp)->( dbEval( {|| nQtdReg++ } ) )
	(cArqTmp)->( dbGoTop() )
	
	++nQtdReg//Soma 1, para considerar o cabe็alho
	ProcRegua(nQtdReg)
	
	WrTXMLArq(1,@apExcel, nQtdReg)
	
	While (cArqTmp)->(!Eof())
		IncProc("Processando...")
		
		WrTXMLArq(2,; 
					@apExcel,; 
					nQtdReg,; 
					(cArqTmp)->PZK_EMPORI,; 	//Empresa origem
					(cArqTmp)->PZK_FILORI,; 	//Filial Origem
					(cArqTmp)->PZK_NOMFIL,; 	//Nome da filial 
					(cArqTmp)->PZK_ROTINA,; 	//Nome da Rotina
					(cArqTmp)->PZK_DESC,;  		//Descri็ใo da rotina
					(cArqTmp)->PZK_PROCES,; 	//Nome do processamento
					(cArqTmp)->PZK_DATA,; 		//Data do log
					(cArqTmp)->PZK_HORINI,; 	//Hora de inicio
					(cArqTmp)->PZK_HORFIN,; 	//Hora fim
					iIF((cArqTmp)->PZK_STATUS == "1","OK","NAO FINALIZADO" ))		//Status
		
		
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
		Aviso("Registro nใo encontrado","Nenhum registro encontrado.",{"Ok"},2)	
	EndIf
	cNameArq 	:= ""
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cNameArq


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDRel		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o arquivo temporario com os dados do relatorio 	  บฑฑ
ฑฑบ          ณ 											  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/        
Static Function GetDRel()

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias() 
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra็ใo Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra็ใo Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra็ใo Web Manager x Protheus",;
									.F. ))
                                           

cQuery    := " SELECT * FROM "+RetFullName("PZK", cEmpAux)+" PZK "+CRLF
cQuery    += " WHERE PZK_FILIAL = '"+xFilial("PZK",cEmpAux)+"' "
cQuery    += " AND PZK_DATA = '"+DTOS(MsDate())+"' "
cQuery    += " AND D_E_L_E_T_ = ' ' "

//Aviso("",cQuery,{"Ok"},3)
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

RestArea(aArea)
Return cArqTmp          


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณJobLogIWM บ Autor ณ Microsiga		     บ Data ณ  11/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Fun็ใo utilizada em schedule para enviar o relatorio 	  บฑฑ
ฑฑบ          ณ de log de processamento 			 			              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function JobLogIWM()

Local aArea 		:= GetArea()
Local cNameArq 		:= ""
Local cDir			:= "\IntegracaoWM\"
Local cEmailPara    := U_MyNewSX6("NC_IWMELOG",;
									"esantana@ncgames.com.br; ",;
									"C",;
									"E-mail para envio do WF c/ relatorio de log de processamento da integra็ใo com WM",;
									"E-mail para envio do WF c/ relatorio de log de processamento da integra็ใo com WM",;
									"E-mail para envio do WF c/ relatorio de log de processamento da integra็ใo com WM",;
									.F. )
Local cMsgEmail	:= ""
Local cAssunto	:= "Log de Processamento - Web Manager x Protheus"

cMsgEmail	:= "Relat๓rio de log referente a integra็ใo entre os sistemas Web Manager e Protheus.  "+CRLF+CRLF
cMsgEmail	+= " E-mail automแtico, favor nใo responder."+CRLF

//Gerar o arquivo do relatorio
cNameArq := GerRel(.T., cDir)

If !Empty(cNameArq) .And. !Empty(cEmailPara)
    
	//Envia o Arquivo por e-mail
	NCEnvEmail(cAssunto,;//Assunto
				cMsgEmail,;//Mensagem
				{cDir+cNameArq},;//Anexo
				Alltrim(cEmailPara),;//E-mail do destinatario
				"",;//C๓pia do e-mail
				"")
				
	//Exclui o arquivo temporario do relatorio, ap๓s o envio do e-mail
	ExclArq(cDir, cNameArq)

EndIf
		    
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWrTXMLArq  บAutor  ณMicrosiga         บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os dados do XML a ser gravado no relat๓rio do Excelบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                  	      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
Static Function WrTXMLArq(nOpc, apExcel, nQtdReg, cEmpOri, cFilOri, cNomeFil, cRotin, cDescRot, cProcess, cDtLog, cHorIni, cHorFin, cSts)
								
                     
Local cDtLogAux	:= ""

Default nOpc 		:= 1
Default apExcel 	:= {}
Default nQtdReg		:= 0 
Default cEmpOri		:= "" 
Default cFilOri		:= "" 
Default cNomeFil	:= "" 
Default cRotin		:= "" 
Default cDescRot	:= "" 
Default cProcess	:= "" 
Default cDtLog		:= "" 
Default cHorIni		:= "" 
Default cHorFin		:= "" 
Default cSts 		:= ""


//Converte a data de emissใo para o formado do excel
cDtLogAux	:= SubStr(cDtLog,1,4)+"-"+SubStr(cDtLog,5,2)+"-"+SubStr(cDtLog,7,2)+"T00:00:00.000"

If nOpc == 1
	Aadd(apExcel, '<?xml version="1.0"?>'+CRLF)
	Aadd(apExcel, '<?mso-application progid="Excel.Sheet"?>'+CRLF)
	Aadd(apExcel, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF)
	Aadd(apExcel, ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF)
	Aadd(apExcel, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF)
	Aadd(apExcel, ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '  <Author>NC Games</Author>'+CRLF)
	Aadd(apExcel, '  <LastAuthor>NC GAMES</LastAuthor>'+CRLF)
	Aadd(apExcel, '  <Created>2015-06-25T13:45:09Z</Created>'+CRLF)
	Aadd(apExcel, '  <LastSaved>2015-06-25T21:04:39Z</LastSaved>'+CRLF)
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
	Aadd(apExcel, '  <Style ss:ID="s16">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s17">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s18">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s19">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s20">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s21">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Time"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s71">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s72">'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s73">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, ' </Styles>'+CRLF)
	Aadd(apExcel, ' <Worksheet ss:Name="Plan1">'+CRLF)
	Aadd(apExcel, '  <Table ss:ExpandedColumnCount="10" ss:ExpandedRowCount="'+Alltrim(Str(nQtdReg))+'" x:FullColumns="1"'+CRLF)
	Aadd(apExcel, '   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s16" ss:Width="45"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s16" ss:AutoFitWidth="0" ss:Width="38.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s16" ss:AutoFitWidth="0" ss:Width="267.75"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:AutoFitWidth="0" ss:Width="78.75"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="402"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:AutoFitWidth="0" ss:Width="74.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s73" ss:AutoFitWidth="0" ss:Width="84"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="57"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="51.75"/>'+CRLF)
	Aadd(apExcel, '   <Row>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s17"><Data ss:Type="String">Empresa</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s17"><Data ss:Type="String">Filial</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s17"><Data ss:Type="String">Nome</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="String">Rotina</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="String">Descriรงรฃo</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="String">Processo</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s71"><Data ss:Type="String">Data</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="String">Hora Inicial</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="String">Hora Final</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s18"><Data ss:Type="String">Status</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)

ElseIf nOpc == 2
    
	Aadd(apExcel, '   <Row>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s19"><Data ss:Type="String">'+cEmpOri+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s19"><Data ss:Type="String">'+cFilOri+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s19"><Data ss:Type="String">'+cNomeFil+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s20"><Data ss:Type="String">'+cRotin+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s20"><Data ss:Type="String">'+cDescRot+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s19"><Data ss:Type="String">'+cProcess+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s72"><Data ss:Type="DateTime">'+cDtLogAux+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s20"><Data ss:Type="String">'+cHorIni+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s20"><Data ss:Type="String">'+cHorFin+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s20"><Data ss:Type="String">'+cSts+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)
	
ElseIf nOpc == 3

  	Aadd(apExcel, '  </Table>'+CRLF)
  	Aadd(apExcel, '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
  	Aadd(apExcel, '   <PageSetup>'+CRLF)
  	Aadd(apExcel, '    <Header x:Margin="0.31496062000000002"/>'+CRLF)
  	Aadd(apExcel, '    <Footer x:Margin="0.31496062000000002"/>'+CRLF)
  	Aadd(apExcel, '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF)
  	Aadd(apExcel, '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF)
  	Aadd(apExcel, '   </PageSetup>'+CRLF)
  	Aadd(apExcel, '   <Selected/>'+CRLF)
  	Aadd(apExcel, '   <Panes>'+CRLF)
  	Aadd(apExcel, '    <Pane>'+CRLF)
  	Aadd(apExcel, '     <Number>3</Number>'+CRLF)
  	Aadd(apExcel, '     <ActiveRow>16</ActiveRow>'+CRLF)
  	Aadd(apExcel, '     <ActiveCol>2</ActiveCol>'+CRLF)
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGeraExcel บAutor  ณMicrosiga		     บ Data ณ  11/06/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria e escreve o arquivo excel.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
	
	aPerg	:= PergFile()//Pergunta com o endere็o do arquivo
	
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
		MsgStop("Nใo foi possํvel criar o arquivo em: " + CRLF + clLocal)
	else
		AEVAL(alPlanilha, {|x| FWRITE(nlHandle, x)} )
		FCLOSE(nlHandle)
		
		if File(clLocal)
			
			If Aviso("Abrir arquivo","Deseja abrir o arquivo ?",{"Sim","Nใo"},2) == 1
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
	
	//Verifica se existe o diret๓rio, senใo existir serแ criado no ProtheusData
	If !EXISTDIR(clDir)
		If MakeDir( clDir ) < 0
			lRet := .F.
			Conout("Erro na cria็ใo do diretorio")
			
			Return lRet
		Else
			lRet := .T.
		EndIf
	EndIf
	
	If lRet
		clLocal := clDir + cNameArq
		nlHandle  := FCREATE(clLocal)
		
		if nlHandle == -1
			Conout("Nใo foi possํvel criar o arquivo em: " + CRLF + clLocal)
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFile	บAutor  ณMicrosiga			 บ Data ณ  11/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta com o endere็o do arquivo				          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณExclArq	บ Autor ณ Microsiga		     บ Data ณ  02/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Exclui arquivos ap๓s o envio do e-mail					  บฑฑ
ฑฑบ          ณ                      									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCEnvEmail  บAutor  ณMicrosiga         บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
		cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return lRetorno
