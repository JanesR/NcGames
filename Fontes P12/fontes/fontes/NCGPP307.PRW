#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPP307		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Workflow com os documentos de PP/VP sem credit note 		  บฑฑ
ฑฑบ          ณ preenchido								  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPP307() 

Local aArea := GetArea()

//Chama a tela para envio do WF por e-mail
TelaWFCNP()

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCWFP307		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Workflow com os documentos de PP/VP sem credit note 		  บฑฑ
ฑฑบ          ณ preenchido								  				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCWFP307(aDados)

Default aDados:={"01","03"}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])  

//Chama a rotina para enviar o e-mail com credit note pendente
JobWFCNP()

RpcClearEnv()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvWFCNP  บAutor  ณMicrosiga  	     บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela para o preenchimento dos dados do e-mail              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TelaWFCNP()

Local aArea 		:= GetArea()
Local oDlg
Local oWin01
Local oFWLayer
Local oFont
Local oButEnvMail
Local oButSair
Local aButton		:= {}
Local bSair			:= {|| oDlg:End() }//Sair
Local oButton
Local oSayPara		
Local oTGetPara		
Local oSayCopia		
Local oTGetCopia	
Local oSayAssunt	
Local oTGetAssunt	
Local oTMultiget
Local cMensagem		:= ""
Local cPara			:= U_MyNewSX6("NC_WFPCRNO",;
									" ",;
									"C",;
									"E-mail de WF pendente de aprova็ใo",;
									"E-mail de WF pendente de aprova็ใo",;
									"E-mail de WF pendente de aprova็ใo",;
									.F. )+Space(800)
Local cCopia		:= Space(1000)
Local cAssunto		:= "Relat๓rio - Credit Note Pendente"+Space(500)
Local cErro			:= ""
Local lEnvMail		:= .F.

//Montagem da tela
DEFINE DIALOG oDlg TITLE "Envio de relat๓rio de Credit Note pendente" SIZE 800,500 PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro ้ para
//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )

// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Dados para envio do e-mail (Credit Note pendente)", 100, .F., .T., ,,)

oWin01 := oFWLayer:getWinPanel('Col01','Win01')

//Informa็ใo do E-mail "Para"
oSayPara	:= TSay():New(10,05,{|| "Para: " },oWin01,,,,,,.T.,,CLR_WHITE,200,20)
oTGetPara	:= TGet():New(10,30,{|u| if(PCount() > 0, cPara := u, cPara) },oWin01,350,009, "",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )

//Informa็ใo do E-mail "Copia"
oSayCopia	:= TSay():New(30,05,{|| "Copia: " },oWin01,,,,,,.T.,,CLR_WHITE,200,20)
oTGetCopia	:= TGet():New(30,30,{|u| if(PCount() > 0, cCopia := u, cCopia) },oWin01,350,009, "",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )

//Assunto da mensagem
oSayAssunt	:= TSay():New(50,05,{|| "Assunto: " },oWin01,,,,,,.T.,,CLR_WHITE,200,20)
oTGetAssunt	:= TGet():New(50,30,{|u| if(PCount() > 0, cAssunto := u, cAssunto) },oWin01,350,009, "",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )

//Mensagem
oTMultiget := oTMultiget := tMultiget():New( 070,05, {|u| if(Pcount() >0,cMensagem:= u, cMensagem)},oWin01,375,120,,.F.,,,,.T.,,,,,,, {||} )

//Enviar e-mail
oButEnvMail		:= TButton():New(200, 295, "Enviar",oWin01,{ || 	LJMsgRun("Aguarde o processamento...","Aguarde...",;
																				{|| lEnvMail := EnvWFCNP(Alltrim(cPara),;//Email para
																										 Alltrim(cCopia),;//Email copia
																										 Alltrim(cMensagem),;//Mensagem
																										 Alltrim(cAssunto));//Assunto
																										 }),;
																		 	 	oDlg:End();//Botใo para fechar a tela
																		 	 	 },;
									50,10,,,.F.,.T.,.F.,,.F.,,,.F. )


//Sair
oButSair		:= TButton():New(200, 350, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE DIALOG oDlg CENTERED


If lEnvMail
	Aviso("สxito no envio","E-mail enviado com sucesso.",{"Ok"},2)
EndIf

RestArea(aArea)
Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณEnvWFCNP บ Autor ณ Elton C.		     บ Data ณ  02/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Fun็ใo utilizada em schedule para enviar o relatorio geral บฑฑ
ฑฑบ          ณ de todos os documento pendente de Credit Note              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function EnvWFCNP(cEmailPara, cEmailCopia, cMsgEmail, cAssunto)

Local aArea 		:= GetArea()
Local cDir			:= "\CREDITNOTE\"
Local cMsgAux		:= "E-mail automแtico, favor nใo responder."
Local lRet			:= .T.

Default cEmailPara	:= "" 
Default cEmailCopia	:= "" 
Default cMsgEmail	:= "" 
Default cAssunto	:= ""

//Gerar o arquivo do relatorio no servidor
cNameArq := GerRelMail(cDir)

If !Empty(cNameArq) .And. !Empty(cEmailPara)
    
	//Envia o Arquivo por e-mail
	lRet := NCEnvEmail(cAssunto,;//Assunto
						cMsgEmail+CRLF+CRLF+cMsgAux,;//Mensagem
						{cDir+cNameArq},;//Anexo
						Alltrim(cEmailPara),;//E-mail do destinatario
						Alltrim(cEmailCopia),;//C๓pia do e-mail
						"")
						
	//Exclui o arquivo temporario do relatorio, ap๓s o envio do e-mail
	ExclArq(cDir, cNameArq)

EndIf
		    
RestArea(aArea)
Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณJobWFCNP บ Autor ณ Elton C.		     บ Data ณ  02/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Fun็ใo utilizada em schedule para enviar o relatorio geral บฑฑ
ฑฑบ          ณ de todos os documento pendente de Credit Note              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function JobWFCNP()

Local aArea 		:= GetArea()
Local cDir			:= "\CREDITNOTE\"
Local cMsgEmail		:= ""

Local cEmailPara	:= U_MyNewSX6("NC_WFPCRNO",;
									" ",;
									"C",;
									"E-mail de WF pendente de aprova็ใo",;
									"E-mail de WF pendente de aprova็ใo",;
									"E-mail de WF pendente de aprova็ใo",;
									.F. )

cMsgEmail	:= " Voc๊ recebeu e-mail com a planilha anexa,  relacionando todos os documentos de Price Protection e Verba Publisher "+CRLF
cMsgEmail	+= " pendentes de Credit Note. "+CRLF+CRLF
cMsgEmail	+= " Email automแtico, favor nใo responder. "+CRLF

//Gerar o arquivo do relatorio no servidor
cNameArq := GerRelMail(cDir)

If !Empty(cNameArq) .And. !Empty(cEmailPara)
    
	//Envia o Arquivo por e-mail
	NCEnvEmail("Relat๓rio - Credit Note Pendente",;//Assunto
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
ฑฑบFuncao    ณGeraExcel บAutor  ณElton C.		     บ Data ณ  11/07/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria e escreve o arquivo excel.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraExcel(alPlanilha, cNameArq, cDirJob)
	
Local nlHandle
Local clLocal 	:= ""
Local olExcelApp
Local aPerg		:= {}
Local lRet		:= .T.

Default alPlanilha	:= {}
Default cNameArq 	:= ""
Default cDirJob		:= ""

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
	endif
EndIf

Return lRet     


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGerRelMail บ Autor ณ Elton C.		     บ Data ณ  02/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Fun็ใo utilizada para gerar e enviar o relatorio por e-mailบฑฑ
ฑฑบ          ณ 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function GerRelMail(cDir)
Local aArea 		:= GetArea()
Local cNameArq 		:= "CreditNotePendente_" + DtoS(MsDate())+STRTRAN(Time(), ":", "")+".xls"
Local cArqTmp   	:= ""
Local apExcel		:= {} 
Local nQtdReg		:= 0

Default cDir := ""                          

//Lista os dados do relatorio
cArqTmp :=  GetDRel()
	
//Verifica quantidade de registros
(cArqTmp)->( dbEval( {|| nQtdReg++ } ) )
(cArqTmp)->( dbGoTop() )

++nQtdReg//Soma 1, para considerar o cabe็alho

If (cArqTmp)->(!Eof())

	//Tags de inicializa็ใo do arquivo
	WrTXMLArq(1,@apExcel, nQtdReg)
	
	While (cArqTmp)->(!Eof())

		WrTXMLArq(2,;//Op็ใo para preenchimento dos itens
					@apExcel,;//Array com as informa็๕es do XML
					nQtdReg,;//Qauntidade de itens
					(cArqTmp)->TPMOV,;//Tipo de repasse
					(cArqTmp)->CODCLI,;//Codigo do cliente
					(cArqTmp)->LOJA,;//Loja
					(cArqTmp)->NOME,;//Nome
					(cArqTmp)->CODPP,;//Codigo do PP / VP
					(cArqTmp)->CAMPANHA,;//Codigo da campanha
					(cArqTmp)->PUBLISHER,;//Publisher
					DTOC(STOD((cArqTmp)->DTEFET)),;//Dt.Efetiva็ใo
					(cArqTmp)->TXDOLA,;//Taxa do dolar
					(cArqTmp)->CODPRO,;//Codigo do Produto
					(cArqTmp)->DESCPRO,;//Descri็ใo do produto
					(cArqTmp)->QUANT,;//Quantidade 
					(cArqTmp)->VLTOTAL,;//Valor Total 
					(cArqTmp)->VLTOTDOLA;//Valor Total em dolar
					)
			
		(cArqTmp)->(DbSkip())
	EndDo
	
	//Fecha as tags de inicializa็ใo do arquivo
	WrTXMLArq(3,@apExcel)

	//Gera a planilha do Excel
	GeraExcel(apExcel, cNameArq, cDir )
Else
	cNameArq := ""
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return cNameArq 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDRel	  บAutor  ณElton C.          บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o arquivo temporario com os dados do relatorio	  บฑฑ
ฑฑบ          ณ                                 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDRel()

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpRet   	:= GetNextAlias()
Local cCliente		:= U_MyNewSX6("NC_CMVGCLI",;
									"000001",;
									"C",;
									"C๓digo do cliente NC Games",;
									"C๓digo do cliente NC Games",;
									"C๓digo do cliente NC Games",;
									.F. )
Local cLojaCli		:= U_MyNewSX6("NC_CMVGLJ",;
									"01",;
									"C",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									.F. )

cQuery	:= " SELECT * FROM ( "+CRLF

cQuery	+= " SELECT 'PP Est.NC' TPMOV, '"+cCliente+"' CODCLI, '"+cLojaCli+"' LOJA, A1_NREDUZ NOME, P05_CODPP CODPP, "+CRLF
cQuery	+= " P05_PPPUB CAMPANHA, P05_PUBLIS PUBLISHER, P05_CREDNO CREDITNOT, "+CRLF
cQuery	+= " P05_DTAPLI DTAPLIC, P05_DTEFET DTEFET, P06_CODPRO CODPRO, P06_DESC DESCPRO, P05_TXDOLA TXDOLA, "+CRLF
cQuery	+= "  P06_TOTAL VLTOTAL, P06_DLCONV VLTOTDOLA, P06_QUANT QUANT "+CRLF
cQuery	+= " FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery	+= " ON P06.P06_FILIAL = P05.P05_FILIAL "+CRLF
cQuery	+= " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQuery	+= " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery	+= " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery	+= " AND SA1.A1_COD = '"+cCliente+"' "+CRLF
cQuery	+= " AND SA1.A1_LOJA = '"+cLojaCli+"' "+CRLF
cQuery	+= " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery	+= " ON P0C.P0C_FILIAL = P05.P05_FILIAL "+CRLF
cQuery	+= " AND P0C.P0C_PPPUB = P05.P05_PPPUB "+CRLF
cQuery	+= " AND P0C.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery	+= " AND P05.P05_DTEFET != ' ' "+CRLF
cQuery	+= " AND P05.P05_CREDNO = ' ' "+CRLF
cQuery	+= " AND P05.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " UNION ALL "+CRLF
cQuery	+= " SELECT 'PP Est.Cli' TPMOV, PZD_CLIENT CODCLI, PZD_LOJA LOJA, PZD_NOME NOME, PZD_CODPP CODPP, "+CRLF
cQuery	+= " PZC_PPPUB CAMPANHA, PZC_PUBLIS PUBLISHER, PZC_CREDNO CREDITNOT, PZC_DTAPLI DTAPLIC, PZC_DTEFET DTEFET, "+CRLF
cQuery	+= " PZD_CODPRO CODPRO, PZD_DESC DESCPRO, PZC_TXDOLA TXDOLA, PZD_TOTPUB VLTOTAL, PZD_CDOLAR VLTOTDOLA, PZD_QUANT QUANT "+CRLF
cQuery	+= " FROM "+RetSqlName("PZC")+" PZC "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("PZD")+" PZD "+CRLF
cQuery	+= " ON PZD.PZD_FILIAL = PZC.PZC_FILIAL "+CRLF
cQuery	+= " AND PZD.PZD_CODPP = PZC.PZC_CODPP "+CRLF
cQuery	+= " AND PZD.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery	+= " ON P0C.P0C_FILIAL = PZC.PZC_FILIAL "+CRLF
cQuery	+= " AND P0C.P0C_PPPUB = PZC.PZC_PPPUB "+CRLF
cQuery	+= " AND P0C.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE PZC.PZC_FILIAL = '"+xFilial("PZC")+"' "+CRLF 
cQuery	+= " AND PZC.PZC_DTEFET != ' ' "+CRLF
cQuery	+= " AND PZC.PZC_CREDNO = ' ' "+CRLF
cQuery	+= " AND PZC.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " UNION ALL "+CRLF
cQuery	+= " SELECT 'Verba Publis.' TPMOV, PZF_CLIENT CODCLI, PZF_LOJA LOJA, PZF_NOME NOME, PZE_CODVP CODPP, "+CRLF
cQuery	+= " PZE_PPPUB CAMPANHA, PZE_PUBLIS PUBLISHER, PZE_CREDNO CREDITNOT, PZE_DTDIGI DTAPLIC, PZE_DTEFET DTEFET, "+CRLF
cQuery	+= " ' ' CODPRO, ' ' DESCPRO, PZE_TXDOLA TXDOLA, PZF_VALOR VLTOTAL, PZF_VLDOLA VLTOTDOLA, 0 QUANT  "+CRLF
cQuery	+= " FROM "+RetSqlName("PZE")+" PZE "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("PZF")+" PZF "+CRLF
cQuery	+= " ON PZF.PZF_FILIAL = PZE.PZE_FILIAL "+CRLF
cQuery	+= " AND PZF.PZF_CODVP = PZE.PZE_CODVP "+CRLF
cQuery	+= " AND PZF.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery	+= " ON P0C.P0C_FILIAL = PZE.PZE_FILIAL "+CRLF
cQuery	+= " AND P0C.P0C_PPPUB = PZE.PZE_PPPUB "+CRLF
cQuery	+= " AND P0C.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE PZE.PZE_FILIAL = '"+xFilial("PZE")+"' "+CRLF
cQuery	+= " AND PZE.PZE_DTEFET != ' ' "+CRLF
cQuery	+= " AND PZE.PZE_CREDNO = ' ' "+CRLF
cQuery	+= " AND PZE.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " ) DADOS "+CRLF
cQuery	+= " ORDER BY TPMOV, PUBLISHER, CODCLI, CODPP "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmpRet,.T.,.T.)

RestArea(aArea)
Return cArqTmpRet                                                     


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณExclArq	บ Autor ณ Elton C.		     บ Data ณ  02/02/12   บฑฑ
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
Default cEmailCc:=""

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
Static Function WrTXMLArq(nOpc, apExcel, nQtdReg, cTpMov, cCodCli, cLoja, cNome, cCodPPVP,;
							 cCampanha, cPublis, cDtEfeti, nTxDolar, cCodProd, cDescProd, nQtd, nVlTotal, nVlTotDolar)
								
                     
Default nOpc 		:= 1
Default apExcel 	:= {}
Default nQtdReg		:= 0 
Default cTpMov		:= "" 
Default cCodCli		:= "" 
Default cLoja		:= "" 
Default cNome		:= "" 
Default cCodPPVP	:= ""
Default cCampanha	:= "" 
Default cPublis		:= "" 
Default cDtEfeti	:= "" 
Default nTxDolar	:= 0 
Default cCodProd	:= "" 
Default cDescProd	:= "" 
Default nQtd		:= 0 
Default nVlTotal	:= 0 
Default nVlTotDolar	:= 0

If nOpc == 1
	
	Aadd(apExcel, '<?xml version="1.0"?>' )
	Aadd(apExcel, '<?mso-application progid="Excel.Sheet"?>')
	Aadd(apExcel, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"')
	Aadd(apExcel, ' xmlns:o="urn:schemas-microsoft-com:office:office"')
	Aadd(apExcel, ' xmlns:x="urn:schemas-microsoft-com:office:excel"')
	Aadd(apExcel, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"')
	Aadd(apExcel, ' xmlns:html="http://www.w3.org/TR/REC-html40">')
	Aadd(apExcel, ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">')
	Aadd(apExcel, '  <Author>Elton da Cunha Santana</Author>')
	Aadd(apExcel, '  <LastAuthor>Elton da Cunha Santana</LastAuthor>')
	Aadd(apExcel, '  <LastPrinted>2014-12-08T18:29:14Z</LastPrinted>')
	Aadd(apExcel, '  <Created>2014-12-06T13:02:03Z</Created>')
	Aadd(apExcel, '  <LastSaved>2015-01-20T17:37:01Z</LastSaved>')
	Aadd(apExcel, '  <Version>12.00</Version>')
	Aadd(apExcel, ' </DocumentProperties>')
	Aadd(apExcel, ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">')
	Aadd(apExcel, '  <WindowHeight>3930</WindowHeight>')
	Aadd(apExcel, '  <WindowWidth>18195</WindowWidth>')
	Aadd(apExcel, '  <WindowTopX>360</WindowTopX>')
	Aadd(apExcel, '  <WindowTopY>105</WindowTopY>')
	Aadd(apExcel, '  <ProtectStructure>False</ProtectStructure>')
	Aadd(apExcel, '  <ProtectWindows>False</ProtectWindows>')
	Aadd(apExcel, ' </ExcelWorkbook>')
	Aadd(apExcel, ' <Styles>')
	Aadd(apExcel, '  <Style ss:ID="Default" ss:Name="Normal">')
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>')
	Aadd(apExcel, '   <Borders/>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>')
	Aadd(apExcel, '   <Interior/>')
	Aadd(apExcel, '   <NumberFormat/>')
	Aadd(apExcel, '   <Protection/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s16" ss:Name="Separador de milhares">')
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s17">')
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s18">')
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s19" ss:Parent="s16">')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s20" ss:Parent="s16">')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0_-;\-* #,##0_-;_-* &quot;-&quot;??_-;_-@_-"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s23">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s24">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s25" ss:Parent="s16">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s26" ss:Parent="s16">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0_-;\-* #,##0_-;_-* &quot;-&quot;??_-;_-@_-"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s27">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#FFFFFF"/>')
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s28">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#FFFFFF"/>')
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s29" ss:Parent="s16">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#FFFFFF"/>')
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, '  <Style ss:ID="s30" ss:Parent="s16">')
	Aadd(apExcel, '   <Borders>')
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>')
	Aadd(apExcel, '   </Borders>')
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#FFFFFF"/>')
	Aadd(apExcel, '   <Interior ss:Color="#538ED5" ss:Pattern="Solid"/>')
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0_-;\-* #,##0_-;_-* &quot;-&quot;??_-;_-@_-"/>')
	Aadd(apExcel, '  </Style>')
	Aadd(apExcel, ' </Styles>')
	Aadd(apExcel, ' <Worksheet ss:Name="CreditNote">')
	Aadd(apExcel, '  <Table ss:ExpandedColumnCount="15" ss:ExpandedRowCount="'+Alltrim(Str(nQtdReg))+'" x:FullColumns="1"')
	Aadd(apExcel, '   x:FullRows="1" ss:DefaultRowHeight="15">')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:AutoFitWidth="0" ss:Width="65.25"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="51.75"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="22.5"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="45.75"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="46.5"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="144"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="94.5"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="132"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s18" ss:Width="66.75"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s19" ss:Width="51"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="84.75"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s17" ss:Width="246"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s20" ss:Width="60"/>')
	Aadd(apExcel, '   <Column ss:StyleID="s19" ss:Width="88.5" ss:Span="1"/>')
	Aadd(apExcel, '   <Row>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Tp. Repasse</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Cod.Cliente</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Loja</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Nome</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Codigo PP</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Campanha</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Publisher</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Credit Note</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s28"><Data ss:Type="String">Dt.Efetivaรงรฃo</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s29"><Data ss:Type="String">Tx.Dolar</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Cod.Produto</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s27"><Data ss:Type="String">Descriรงรฃo</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s30"><Data ss:Type="String">Quantidade</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s29"><Data ss:Type="String">Vl.Total</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s29"><Data ss:Type="String">Vl.Tota $</Data></Cell>')
	Aadd(apExcel, '   </Row>')
	
ElseIf nOpc == 2
	
	Aadd(apExcel, '   <Row>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cTpMov+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cCodCli+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cLoja+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cNome+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cCodPPVP+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cCampanha+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cPublis+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String"> </Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cDtEfeti+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s25"><Data ss:Type="Number">'+Alltrim(Str(nTxDolar))+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cCodProd+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s23"><Data ss:Type="String">'+cDescProd+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s26"><Data ss:Type="Number">'+Alltrim(Str(nQtd))+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s25"><Data ss:Type="Number">'+Alltrim(Str(nVlTotal))+'</Data></Cell>')
	Aadd(apExcel, '    <Cell ss:StyleID="s25"><Data ss:Type="Number">'+Alltrim(Str(nVlTotDolar))+'</Data></Cell>')
	Aadd(apExcel, '   </Row>')
	
ElseIf nOpc == 3
	
	Aadd(apExcel, '  </Table>')
	Aadd(apExcel, '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">')
	Aadd(apExcel, '   <PageSetup>')
	Aadd(apExcel, '    <Header x:Margin="0.31496062000000002"/>')
	Aadd(apExcel, '    <Footer x:Margin="0.31496062000000002"/>')
	Aadd(apExcel, '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"')
	Aadd(apExcel, '     x:Right="0.511811024" x:Top="0.78740157499999996"/>')
	Aadd(apExcel, '   </PageSetup>')
	Aadd(apExcel, '   <Print>')
	Aadd(apExcel, '    <ValidPrinterInfo/>')
	Aadd(apExcel, '    <PaperSizeIndex>9</PaperSizeIndex>')
	Aadd(apExcel, '    <HorizontalResolution>600</HorizontalResolution>')
	Aadd(apExcel, '    <VerticalResolution>600</VerticalResolution>')
	Aadd(apExcel, '   </Print>')
	Aadd(apExcel, '   <Selected/>')
	Aadd(apExcel, '   <Panes>')
	Aadd(apExcel, '    <Pane>')
	Aadd(apExcel, '     <Number>3</Number>')
	Aadd(apExcel, '     <ActiveRow>1</ActiveRow>')
	Aadd(apExcel, '    </Pane>')
	Aadd(apExcel, '   </Panes>')
	Aadd(apExcel, '   <ProtectObjects>False</ProtectObjects>')
	Aadd(apExcel, '   <ProtectScenarios>False</ProtectScenarios>')
	Aadd(apExcel, '  </WorksheetOptions>')
	Aadd(apExcel, ' </Worksheet>')
	Aadd(apExcel, '</Workbook>')
	
EndIf


Return 
