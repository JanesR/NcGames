#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWFPP32  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para montar a al�ada de aprova��o e 		  ���
���          � solicitar o envio do primeiro WF da Verba Publisher		  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWFPP32(cCodVP)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cCodProc	:= ""   
Local lEnvWF	:= .F.

Default cCodVP 	:= ""     

cQuery    := " SELECT * FROM "+RetSqlName("PZA")+" PZA "+CRLF
cQuery    += " WHERE PZA.PZA_FILIAL = '"+xFilial("PZA")+"' "+CRLF
cQuery    += " AND PZA.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZA_NIVEL, PZA_CODUSE "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

cCodProc := GetSXENum("PZB","PZB_CODPRO")//Processo
ConfirmSX8()

DbSelectArea("PZB")
DbSetOrder(1)
While (cArqTmp)->(!Eof())
	
	If Reclock("PZB", .T.)
		PZB->PZB_FILIAL := xFilial("PZB")
		PZB->PZB_CODPRO	:= cCodProc
		PZB->PZB_CODPP  := cCodVP
		PZB->PZB_CODAPR := (cArqTmp)->PZA_CODIGO
		PZB->PZB_CODUSE := (cArqTmp)->PZA_CODUSE
		PZB->PZB_NOMEUS := (cArqTmp)->PZA_NOMEUS
		PZB->PZB_MAIL   := (cArqTmp)->PZA_MAIL  
		PZB->PZB_NIVEL  := (cArqTmp)->PZA_NIVEL
		PZB->PZB_DTENV  := MsDate()
		PZB->PZB_CODSOL := RetCodUsr()
		PZB->PZB_NOMSOL := UsrFullName(RetCodUsr())
		PZB->PZB_MAILSO := UsrRetMail(RetCodUsr())
		PZB->PZB_STATUS := "3"
		PZB->PZB_TPREP 	:= "3"//Verba Publisher
		lEnvWF	:= .T.
	EndIf
	
	PZB->(MsUnLock())				
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

If lEnvWF
	//Envia o WF para o aprovador
	//U_NCPP3AVP({cEmpAnt,cFilAnt,cCodVP,.T.})  
	StartJob("U_NCPP3AVP",GetEnvServer(),.F.,{cEmpAnt,cFilAnt,cCodVP,.T.})
EndIf


RestArea(aArea)
Return          



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCPP3AVP  �Autor  �Elton C.			� Data �   03/07/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para envio do WF de aprova��o estoque	  ���
���          �de cliente						  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCPP3AVP(aParam)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cCodVP 	:= ""          
Local lAprovado := .T.

If Len(aParam) > 0
	SetEmpFil(aParam[1], aParam[2])
	cCodVP 		:= 	aParam[3]
	lAprovado 	:=  aParam[4]	
Else
	Return
EndIf

//Query para selecionar os aprovadores
cQuery    := " SELECT * FROM "+RetSqlName("PZB")
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "
cQuery    += " AND PZB_CODPP = '"+cCodVP+"' "
cQuery    += " AND PZB_STATUS = '3' "
cQuery    += " AND PZB_TPREP = '3' "//Verba Publisher
cQuery    += " AND D_E_L_E_T_ = ' ' "
cQuery    += " ORDER BY PZB_NIVEL, PZB_NOMEUS "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())//Verifica se existe processo a ser aprovado
	
	//Envia o WF para o Aprovador
	WFAPRPP32(cCodVP, (cArqTmp)->PZB_CODUSE, (cArqTmp)->PZB_NOMEUS, (cArqTmp)->PZB_MAIL)	
	
	
ElseIf lAprovado //Envia e-mail ao solicitante informando o final do processo de aprova��o
	
	AtuStsVP(cCodVP, lAprovado)  

        
    //Envia e-mail ao solicitante informando a aprova��o
	DbSelectArea("PZB")
	DbSetOrder(2)
	If PZB->(DbSeek(xFilial("PZB")+"3"+ cCodVP ))
	 	NCWF2SEND("Verba Publisher Aprovada - "+cCodVP,;
	 				 "A Verba Publisher "+cCodVP+" foi aprovada. "+CRLF+CRLF+;
	 				 	"E-mail autom�tico, favor n�o responder. ",;
	 				  {}, PZB->PZB_MAILSO, "", "")
	EndIf
	
Else //Envia e-mail ao solicitante informando o final do processo caso seja reprovado 
	AtuStsVP(cCodVP, lAprovado)	             
	
	//Envia e-mail ao solicitante de aprovado
	DbSelectArea("PZB")
	DbSetOrder(2)
	If PZB->(DbSeek(xFilial("PZB")+"3"+ cCodVP ))
	 	
	 	NCWF2SEND("Verba Publisher Reprovada - "+cCodVP,;
	 				 "A Verba Publisher "+cCodVP+" foi reprovada. "+CRLF+CRLF+"E-mail autom�tico, favor n�o responder. ",;
	 				 {}, PZB->PZB_MAILSO, "", "")
	 				  
	 				  
	EndIf
	
Endif


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


           

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WFAPRPP32  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para envio do WF de aprova��o			  ���
���          � 									  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WFAPRPP32(cCodVP, cCodUser, cNomeAprov, cMailDest)

Local aArea 			:= GetArea()
Local lReturn			:=.T.
Local clCodProces		:= ""//Nome do Processo de WorkFlow
Local clHtmlMod 		:= "" //Nome do arquivo html que ser� gerado para envio ao setor financeiro
Local clAssunto 		:= ""
Local cTitulo			:= ""
Local clMailID			:= ""
Local cArqTmp			:= ""
Local aCust				:= {}
Local cTitEstCli		:= ""			
Local lProxLiNCL		:= .F.
Local cTableCli			:= ""
Local cDirHtml			:= Alltrim(U_MyNewSX6(	"NCG_000022",;
												"",;
												"C",;
												"Diretorio dos Html do Workflow ",;
												"Diretorio dos Html do Workflow ",;
												"Diretorio dos Html do Workflow ",;
												.F. )   )  
Default cCodVP 		:= ""												                          
Default cCodUser	:= "" 
Default cNomeAprov	:= ""
Default cMailDest	:= ""


cArqTmp			:= GetDVP(cCodVP)//Arquivo temporario com os dados do price protection

//Caminho do arquivo html com a estrutura do WF
clHtmlMod := cDirHtml+IIf(Right(clHtmlMod,1) != "\", "\","")+ "solaprvp_cli.htm"


If (cArqTmp)->(!Eof())

	If File(clHtmlMod) 
	    
		clAssunto 		:= "Aprova��o de Verba Publisher"
		cTitulo			:= "Aprova��o de Verba Publisher"
		
		//Cria�a� do objeto WF
		olProcess := TWFProcess():New(clAssunto, clAssunto) //Instancia objeto da classe TWFProcess para inicializar WF
		olProcess:NewTask(clAssunto, clHtmlMod)//Inicializa a tarefa
		olProcess:cSubject 	:= clAssunto
		olProcess:cTo 		:= cMailDest
		olProcess:bReturn 	:= "U_NCWFP3VP()"//Rotina de retorno do WF
		
		oHtml    := olProcess:oHtml
                                     
		//Preenchimento dos dados do cabe�alho WF
		oHtml:ValByName( "cTiTuloHtml"	, cTitulo)
		oHtml:ValByName( "cCodVP"		, (cArqTmp)->PZE_CODVP )
		oHtml:ValByName( "cPublisher"	, (cArqTmp)->PZE_PUBLIS )
		oHtml:ValByName( "cCampanha"	, (cArqTmp)->PZE_PPPUB )
		oHtml:ValByName( "cVlTotRec"    , Transform((cArqTmp)->PZE_CREDRE,"@E 999,999,999.99" )  )
		oHtml:ValByName( "cDtProtec"  	, DTOC(STOD((cArqTmp)->PZE_DTDIGI))   )
		oHtml:ValByName( "cDtAprovP"   	, DTOC(STOD((cArqTmp)->PZE_DTACEI))  )
		oHtml:ValByName( "cCodAprov"   	, cCodUser  )
		oHtml:ValByName( "cNomAprov"   	, cNomeAprov  )
			                                   
		//Preenchimento da tabela resumida dos clientes 
		cTableCli := U_NGetTVPWF(cCodVP)
		oHtml:ValByName( "cTableCli"   	, cTableCli  )		 
		
		cOldTo  := olProcess:cTo
		cOldCC  := olProcess:cCC
		cOldBCC := olProcess:cBCC
		
		//Endereco invalido, apenas para criar o processo de workflow, mas sem envia-lo
		olProcess:cTo  := cCodUser
		olProcess:cCC  := NIL
		olProcess:cBCC := NIL
		clMailID := olProcess:Start()

		If Empty(EnvWFLink(clMailID ,cOldTo ,cOldCC ,cOldBCC , olProcess:cSubject, clAssunto, Alltrim(cNomeAprov), olProcess,cCodUser, cCodVP ))
			lReturn:=.F.
		EndIf
		
	EndIf

EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lReturn


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetDVP	�Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o arquivo temporario com os dados do price 		  ���
���          �protection												  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetDVP(cCodVP)

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodVP := ""


cQuery    := " SELECT PZE_CODVP, PZE_PUBLIS, PZE_PPPUB, PZE_CREDRE, PZE_CDOLAR, PZE_DTDIGI, PZE_DTACEI "+CRLF
cQuery    += " FROM "+RetSqlName("PZE")+" PZE "+CRLF

cQuery    += " WHERE PZE.PZE_FILIAL = '"+xFilial("PZE")+"' "+CRLF
cQuery    += " AND PZE.PZE_CODVP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZE.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

(cArqTmp)->(DbGoTop())

RestArea(aArea)
Return cArqTmp


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EnvWFLink  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia o link do WF para acesso interno e externo			  ���
���          �														      ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function EnvWFLink(cHtmlFile, cOldTo, cOldCC, cOldBCC, cSubject, clAssunto, cNomeAprov, oObjWf, cUserWF, cNumAlc )

Local aArea			:= GetArea()
Local cSrvHttpIn 	:= U_MyNewSX6("NCG_000020",;
									"",;
									"C",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
									.F. )
Local cSrvHttpEx 	:=  U_MyNewSX6(	"NCG_000021",;
									"",;
									"C",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
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
									"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
									"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
									"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
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
	
	Aviso("Aten��o","N�o foi localizado o modelo HTML para envio do link Workflow. Solicite ao Dpto. de Tecnologia da Informa��o para verificar os modelos HTML do Workflow de aprova��o do Price Protection.",{"Ok"},3)
	
EndIf

RestArea(aArea)
Return(cIdWf)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWFP3VP  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorno do WF de libera��o para applica��o do 	          ���
���          �Price Protection                                            ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWFP3VP(oProcRet) 

Local aArea 		:= GetArea() 
Local cCodVP		:= ""    
Local cAprRepr		:= "" 
Local cObsWF		:= "" 
Local cCodAprova	:= ""

If oProcRet != Nil
	
	cCodVP 		:= oProcRet:oHtml:RetByName("cCodVP")
	cAprRepr	:= oProcRet:oHtml:RetByName("APROVAR")
	cObsWF		:= oProcRet:oHtml:RetByName("OBS")
	cCodAprova	:= oProcRet:oHtml:RetByName("cCodAprov")//Codigo do aprovador
	
	DbSelectArea("PZE")
	DbSetOrder(1)
	If PZE->(DbSeek(xFilial("PZE") + cCodVP ))
		
		If Empty(PZE->PZE_FLAGAR)
			If Upper(Alltrim(cAprRepr)) == "S"
				AtuCApr(cCodVP, cCodAprova, .T., cObsWF)
			Else
				AtuCApr(cCodVP, cCodAprova, .F., cObsWF)
			EndIf
		EndIF
	EndIf
	
	oProcRet:Finish()
EndIf


RestArea(aArea)
Return              

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuStsVP  �Autor  �Elton C.		    � Data �   03/07/2014 ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o status de aprova��o do PP				          ���
���          �					                                          ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuStsVP(cCodVP, lAprovado) 

Local aArea := GetArea()

Default cCodVP		:= ""
Default lAprovado   := .F.

DbSelectArea("PZE")
DbSetOrder(1)
If PZE->(DbSeek(xFilial("PZE") + cCodVP ))
	
	If Empty(PZE->PZE_FLAGAR)
		
		If lAprovado
			Reclock("PZE",.F.)
			PZE->PZE_FLAGAR := "A"
			PZE->PZE_DTEFET := MsDate()
			PZE->(MsUnLock())
		Else
			Reclock("PZE",.F.)
			PZE->PZE_FLAGAR := "R"
			PZE->PZE_DTACEI := CTOD('')
			PZE->(MsUnLock())
		EndIf
	
	EndIF
EndIf

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuCApr  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza a tabela (PZB) de controle de aprova��o	          ���
���          �					                                          ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuCApr(cCodVP, cCodApr, lAprovado, cObs)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodVP		:= "" 
Default cCodApr		:= ""
Default lAprovado   := .F.                   
Default cObs		:= ""
	
cQuery    := " SELECT R_E_C_N_O_ RECNOPZB FROM "+RetSqlName("PZB")+CRLF
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "+CRLF
cQuery    += " AND PZB_CODPP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZB_CODUSE = '"+cCodApr+"' "+CRLF
cQuery    += " AND PZB_STATUS = '3' "+CRLF
cQuery    += " AND PZB_TPREP = '3' "
cQuery    += " AND D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZB_NIVEL, PZB_CODUSE "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

DbSelectArea("PZB")
DbSetOrder(1)
If (cArqTmp)->(!Eof())
	PZB->(DbGoTo((cArqTmp)->RECNOPZB))
	
	Reclock("PZB",.F.)
	If lAprovado
		PZB->PZB_STATUS := "1"
	Else
		PZB->PZB_STATUS := "2"
	EndIf
	
	PZB->PZB_OBS	:= cObs
	PZB->(MsUnLock())
EndIf

//Reprova todos os processo em caso de alguma reprova��o
If !lAprovado
	FinProcRep(cCodVP)
EndIf

//Envia o WF
//U_NCPP3AVP(cCodVP, lAprovado)
StartJob("U_NCPP3AVP",GetEnvServer(),.F.,{cEmpAnt,cFilAnt,cCodVP,lAprovado})
		
(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FinProcRep  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Finaliza os proximos processos devido a reprova��o 	      ���
���          �					                                          ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FinProcRep(cCodVP)

Local aArea :=  GetArea()  
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodVP := ""

cQuery    := " SELECT R_E_C_N_O_ RECNOPZB FROM "+RetSqlName("PZB")+CRLF
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "+CRLF
cQuery    += " AND PZB_CODPP = '"+cCodVP+"' "+CRLF
cQuery    += " AND PZB_STATUS = '3' "+CRLF                   
cQuery    += " AND PZB_TPREP = '3' "
cQuery    += " AND D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZB_NIVEL, PZB_CODUSE "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

DbSelectArea("PZB")
DbSetOrder(1)
While (cArqTmp)->(!Eof())
	
	PZB->(DbGoTo((cArqTmp)->RECNOPZB))
	Reclock("PZB",.F.)
	PZB->PZB_STATUS := "4"
	PZB->(MsUnLock())

	(cArqTmp)->(DbSkip())
EndDo
		

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return     





/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWF3RVP  �Autor  �Elton C.			� Data �   03/07/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para reenvio do WF de aprova��o			  ���
���          � 									  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWF3RVP(cCodVP)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodVP 		:= ""          

//Query para selecionar os aprovadores
cQuery    := " SELECT * FROM "+RetSqlName("PZB")
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "
cQuery    += " AND PZB_CODPP = '"+cCodVP+"' "
cQuery    += " AND PZB_STATUS = '3' "       
cQuery    += " AND PZB_TPREP = '3' "
cQuery    += " AND D_E_L_E_T_ = ' ' "
cQuery    += " ORDER BY PZB_NIVEL, PZB_NOMEUS "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())//Verifica se existe processo a ser aprovado
	
	//Envia o WF para o Aprovador
	If WFAPRPP32(cCodVP, (cArqTmp)->PZB_CODUSE, (cArqTmp)->PZB_NOMEUS, (cArqTmp)->PZB_MAIL)	
		Aviso("Aten��o","WF Reenviado com sucesso.",{"Ok"},2)	
	Else
		Aviso("Aten��o","Erro ao tentar reenviar o WF.",{"Ok"},2)	
	EndIf
	
	
Else
	Aviso("Aten��o","N�o existe processo a ser reenviado.",{"Ok"},2)

Endif


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SetEmpFil �Autor  �Elton C.         	 �Fecha �  10/05/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao utilizada para setar a empresa e filial	  	  	  ���
���			 |						                    				  ���
�������������������������������������������������������������������������͹��
���Uso       � AP 	                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SetEmpFil(cEmpEnv, cFilialEnv)

Default cFilialEnv := ""
Default cEmpEnv  := ""

//Vai para empresa complemnetar
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(cEmpEnv,cFilialEnv)

Return  




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWF2SEND  �Autor  �Microsiga           � Data �  01/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCWF2SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
Local lRetorno		:= .T.
Local cServer   	:= GetNewPar("MV_RELSERV","")
Local cAccount		:= GetNewPar("MV_RELACNT","")
Local cPassword		:= GetNewPar("MV_RELAPSW","")
Local lMailAuth		:= GetNewPar("MV_RELAUTH",.F.)

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
		cErro := "Erro na tentativa de autentica��o da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conex�o com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return(lRetorno)

