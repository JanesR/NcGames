#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"
                     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWFPP02  ºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³WF de aprovação de aplicação do price protection			  º±±
±±º          ³ 									  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCWFPP02(cCodPP)

Local aArea 			:= GetArea()
Local lReturn			:=.T.
Local clCodProces		:= ""//Nome do Processo de WorkFlow
Local clHtmlMod 		:= "" //Nome do arquivo html que será gerado para envio ao setor financeiro
Local clAssunto 		:= "Aprovação Price Protection"
Local clMailID			:= ""
Local cArqTmp			:= ""
Local cCodUser    		:= Alltrim(U_MyNewSX6(	"NC_CODAPPP",;
												"",;
												"C",;
												"Codigo do aprovador de aplicação do Price Protection ",;
												"Codigo do aprovador de aplicação do Price Protection ",;
												"Codigo do aprovador de aplicação do Price Protection ",;
												.F. )   )
Local cNomeAprov		:= Alltrim(UsrFullName( cCodUser))
Local cMailDest			:= Alltrim(U_MyNewSX6(	"NC_EMAILAP",;
												"",;
												"C",;
												"E-mail do aprovador de aplicação do Price Protection ",;
												"E-mail do aprovador de aplicação do Price Protection ",;
												"E-mail do aprovador de aplicação do Price Protection ",;
												.F. )   )

Local cDirHtml			:= Alltrim(U_MyNewSX6(	"NCG_000022",;
												"",;
												"C",;
												"Diretorio dos Html do Workflow ",;
												"Diretorio dos Html do Workflow ",;
												"Diretorio dos Html do Workflow ",;
												.F. )   )

Default cCodPP := ""												                          

cArqTmp			:= GetDPP(cCodPP)//Arquivo temporario com os dados do price protection

//Caminho do arquivo html com a estrutura do WF
clHtmlMod := cDirHtml+IIf(Right(clHtmlMod,1) != "\", "\","")+ "solaprpp.htm"


If (cArqTmp)->(!Eof())

	If File(clHtmlMod)
		
		//Criaçaõ do objeto WF
		olProcess := TWFProcess():New(clAssunto, clAssunto) //Instancia objeto da classe TWFProcess para inicializar WF
		olProcess:NewTask(clAssunto, clHtmlMod)//Inicializa a tarefa
		olProcess:cSubject 	:= clAssunto
		olProcess:cTo 		:= cMailDest
		olProcess:bReturn 	:= "U_WFPP02RET()"//Rotina de retorno do WF
		
		oHtml    := olProcess:oHtml
		
		//Preenchimento dos dados do WF
		oHtml:ValByName( "cTiTuloHtml"	, "Aprovação para aplicação do Price Protection"     )
		oHtml:ValByName( "CCODPP"		, (cArqTmp)->P05_CODPP   )
		oHtml:ValByName( "CCODPROD"		, (cArqTmp)->P05_CODPRO  )
		oHtml:ValByName( "CDESCPROD"	, (cArqTmp)->B1_XDESC  	 )
		oHtml:ValByName( "CDESCPUBLI"   , (cArqTmp)->P05_PUBLIS  )
		oHtml:ValByName( "CCAMPPUBLIS"  , (cArqTmp)->P05_PPPUB   )
		oHtml:ValByName( "CVALOR"   	, Transform((cArqTmp)->P05_VALOR,X3PICTURE("P05_VALOR") )  )
		oHtml:ValByName( "CDTACEI"   	, DTOC(STOD((cArqTmp)->P05_DTACEI))  )
		
		
		cOldTo  := olProcess:cTo
		cOldCC  := olProcess:cCC
		cOldBCC := olProcess:cBCC
		
		//Endereco invalido, apenas para criar o processo de workflow, mas sem envia-lo
		olProcess:cTo  := cCodUser
		olProcess:cCC  := NIL
		olProcess:cBCC := NIL
		clMailID := olProcess:Start()

		If Empty(EnvWFLink(clMailID ,cOldTo ,cOldCC ,cOldBCC , olProcess:cSubject, clAssunto, Alltrim(cNomeAprov), olProcess,cCodUser, cCodPP ))
			lReturn:=.F.
		EndIf
		
	EndIf

EndIf



(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetDPP	ºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o arquivo temporario com os dados do price 		  º±±
±±º          ³protection												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetDPP(cCodPP)

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP := ""

cQuery    := " SELECT P05_CODPP, P05_CODPRO, B1_XDESC, P05_PUBLIS, P05_VALOR, P05_PPPUB, P05_DTACEI FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery    += " ON B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery    += " AND SB1.B1_COD = P05.P05_CODPRO "+CRLF
cQuery    += " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery    += " AND P05.P05_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND P05.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

(cArqTmp)->(DbGoTop())

RestArea(aArea)
Return cArqTmp


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EnvWFLink  ºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Envia o link do WF para acesso interno e externo			  º±±
±±º          ³														      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EnvWFLink(cHtmlFile, cOldTo, cOldCC, cOldBCC, cSubject, clAssunto, cNomeAprov, oObjWf, cUserWF, cNumAlc )

Local aArea			:= GetArea()
Local cSrvHttpIn 	:= U_MyNewSX6("NCG_000020",;
									"",;
									"C",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endereço interno (a clausula 'http://' é necessária ) ",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endereço interno (a clausula 'http://' é necessária ) ",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endereço interno (a clausula 'http://' é necessária ) ",;
									.F. )
Local cSrvHttpEx 	:=  U_MyNewSX6(	"NCG_000021",;
									"",;
									"C",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endereço externo (a clausula 'http://' é necessária )",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endereço externo (a clausula 'http://' é necessária )",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endereço externo (a clausula 'http://' é necessária )",;
									.F. )
									
Local cEndHtml 		:=  U_MyNewSX6(	"NCG_000022",;
									"",;
									"C",;
								"Diretorio do Html do Workflow",;
								"Diretorio do Html do Workflow",;
								"Diretorio do Html do Workflow Link  wflink.htm",;
								.F.)
								
Local cEndArqWf		:=  U_MyNewSX6(	"NCG_000023",;
									"",;
									"C",;
									"Endereço dos arquivos de workflow para acesso via browser do Protheus (não incluir a pasta com o código da empresa, pois a rotina preencherá automaticamente )",;
									"Endereço dos arquivos de workflow para acesso via browser do Protheus (não incluir a pasta com o código da empresa, pois a rotina preencherá automaticamente )",;
									"Endereço dos arquivos de workflow para acesso via browser do Protheus (não incluir a pasta com o código da empresa, pois a rotina preencherá automaticamente )",;
									.F. )
									

Local cLinkInt 		:= ""
Local cLinkExt		:= ""
Local cIdWf			:= ""

cEndHtml := cEndHtml+IIf(Right(cEndHtml,1) != "\", "\","")+ "wflink_pp.htm"

If Right(cSrvHttpIn,1) == "/"
	cSrvHttpIn := Left(cSrvHttpIn,Len(cSrvHttpIn)-1)
EndIf

If Right(cSrvHttpEx,1) == "/"
	cSrvHttpEx := Left(cSrvHttpEx,Len(cSrvHttpEx)-1)
EndIf

If Right(cEndArqWf,1) == "/"
	cEndArqWf := Left(cEndArqWf,Len(cEndArqWf)-1)
EndIf

If File(cEndHtml)
	
	cLinkInt 		:= cSrvHttpIn +  cEndArqWf +cEmpAnt + "/" + cUserWF + "/" + cHtmlFile + ".htm"
	
	cLinkExt 		:= cSrvHttpEx +  cEndArqWf +cEmpAnt + "/" + cUserWF + "/" + cHtmlFile + ".htm"
	
	oObjWf:NewTask("Link de Processos De Workflow", cEndHtml)
	
	oObjWf:ohtml:ValByName("titulo"			,clAssunto	)
	oObjWf:ohtml:ValByName("nomeaprovador"	,cNomeAprov )
	oObjWf:ohtml:ValByName("proc_link"		,cLinkInt	)
	oObjWf:ohtml:ValByName("docalc"			,cNumAlc	)
	oObjWf:ohtml:ValByName("proc_link2"		,cLinkExt	)
	
	oObjWf:cTo  := cOldTo
	oObjWf:cCC  := cOldCC
	oObjWf:cBCC := cOldBCC
	oObjWf:csubject := cSubject
	
	cIdWf := oObjWf:start()
	
Else
	
	Aviso("Atenção","Não foi localizado o modelo HTML para envio do link Workflow. Solicite ao Dpto. de Tecnologia da Informação para verificar os modelos HTML do Workflow de aprovação do Price Protection.",{"Ok"},3)
	
EndIf

RestArea(aArea)
Return(cIdWf)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFPP02RET  ºAutor  ³Elton C.		    º Data ³   20/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorno do WF de liberação para applicação do 	          º±±
±±º          ³Price Protection                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WFPP02RET(oProcRet)

Local aArea 	:= GetArea()
Local cCodPP	:= ""    
Local cAprRepr	:= "" 
Local cObsWF	:= ""

If oProcRet != Nil
	
	cCodPP 		:= oProcRet:oHtml:RetByName("CCODPP")
	cAprRepr	:= oProcRet:oHtml:RetByName("APROVAR")
	cObsWF		:= oProcRet:oHtml:RetByName("OBS")
	
	DbSelectArea("P05")
	DbSetOrder(1)
	If P05->(DbSeek(xFilial("P05") + cCodPP ))
		
		If Empty(P05->P05_FLAGAR)
			If Upper(Alltrim(cAprRepr)) == "S"
				Reclock("P05",.F.)
				P05->P05_FLAGAR := "A"
				P05->P05_OBSAPR := cObsWF
				P05->(MsUnLock())
			Else
				Reclock("P05",.F.)
				P05->P05_FLAGAR := "R"
				P05->P05_OBSAPR := cObsWF
				P05->(MsUnLock())
			EndIf
		EndIF
	EndIf
	
	oProcRet:Finish()
EndIf


RestArea(aArea)
Return
