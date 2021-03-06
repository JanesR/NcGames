#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWFPP31  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para montar a al�ada de aprova��o e 		  ���
���          � solicitar o envio do primeiro WF  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWFPP31(cCodPP)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cCodProc	:= ""   
Local lEnvWF	:= .F.

Default cCodPP 	:= ""     

cQuery    := " SELECT * FROM "+RetSqlName("PZA")+" PZA "+CRLF
cQuery    += " WHERE PZA.PZA_FILIAL = '"+xFilial("PZA")+"' "+CRLF
cQuery    += " AND PZA.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZA_NIVEL, PZA_CODUSE "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

cCodProc := GetSXENum("PZB","PZB_CODPRO")
ConfirmSX8()

DbSelectArea("PZB")
DbSetOrder(1)
While (cArqTmp)->(!Eof())
	
	If Reclock("PZB", .T.)
		PZB->PZB_FILIAL := xFilial("PZB")
		PZB->PZB_CODPRO	:= cCodProc
		PZB->PZB_CODPP  := cCodPP
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
		PZB->PZB_TPREP 	:= "2"
		lEnvWF	:= .T.
	EndIf
	
	PZB->(MsUnLock())				
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

If lEnvWF
	//Envia o WF para o aprovador
	//U_NCPP3ACL({cEmpAnt,cFilAnt,cCodPP,.T.})  
	StartJob("U_NCPP3ACL",GetEnvServer(),.F.,{cEmpAnt,cFilAnt,cCodPP,.T.})
EndIf


RestArea(aArea)
Return          



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCPP3ACL  �Autor  �Elton C.			� Data �   03/07/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para envio do WF de aprova��o estoque	  ���
���          �de cliente						  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCPP3ACL(aParam)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cCodPP 	:= ""          
Local lAprovado := .T.

If Len(aParam) > 0
	SetEmpFil(aParam[1], aParam[2])
	cCodPP 		:= 	aParam[3]
	lAprovado 	:=  aParam[4]	
Else
	Return
EndIf

//Query para selecionar os aprovadores
cQuery    := " SELECT * FROM "+RetSqlName("PZB")
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "
cQuery    += " AND PZB_CODPP = '"+cCodPP+"' "
cQuery    += " AND PZB_STATUS = '3' "
cQuery    += " AND PZB_TPREP = '2' "
cQuery    += " AND D_E_L_E_T_ = ' ' "
cQuery    += " ORDER BY PZB_NIVEL, PZB_NOMEUS "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())//Verifica se existe processo a ser aprovado
	
	//Envia o WF para o Aprovador
	WFAPRPP31(cCodPP, (cArqTmp)->PZB_CODUSE, (cArqTmp)->PZB_NOMEUS, (cArqTmp)->PZB_MAIL)	
	
	
ElseIf lAprovado //Envia e-mail ao solicitante informando o final do processo de aprova��o
	
	AtuStsPP(cCodPP, lAprovado)  

        
    //Envia e-mail ao solicitante informando a aprova��o
	DbSelectArea("PZB")
	DbSetOrder(2)
	If PZB->(DbSeek(xFilial("PZB")+"2"+ cCodPP ))
	 	NCWF2SEND("Price Protection (Estoque de clientes) Aprovado - "+cCodPP,;
	 				 "O Price Protection (Estoque de clientes) "+cCodPP+" foi aprovado. "+CRLF+CRLF+;
	 				 	"E-mail autom�tico, favor n�o responder. ",;
	 				  {}, PZB->PZB_MAILSO, "", "")
	EndIf
	
Else //Envia e-mail ao solicitante informando o final do processo caso seja reprovado 
	AtuStsPP(cCodPP, lAprovado)	             
	
	//Envia e-mail ao solicitante de aprovado
	DbSelectArea("PZB")
	DbSetOrder(2)
	If PZB->(DbSeek(xFilial("PZB")+"2"+ cCodPP ))
	 	
	 	NCWF2SEND("Price Protection (Estoque de clientes) Reprovado - "+cCodPP,;
	 				 "O Price Protection "+cCodPP+" foi reprovado. "+CRLF+CRLF+"E-mail autom�tico, favor n�o responder. ",;
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
���Programa  �WFAPRPP31  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para envio do WF de aprova��o			  ���
���          � 									  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WFAPRPP31(cCodPP, cCodUser, cNomeAprov, cMailDest)

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
Default cCodPP 		:= ""												                          
Default cCodUser	:= "" 
Default cNomeAprov	:= ""
Default cMailDest	:= ""


cArqTmp			:= GetDPP(cCodPP)//Arquivo temporario com os dados do price protection

//Caminho do arquivo html com a estrutura do WF
clHtmlMod := cDirHtml+IIf(Right(clHtmlMod,1) != "\", "\","")+ "solaprpp_cli.htm"


If (cArqTmp)->(!Eof())

	If File(clHtmlMod) 
	    
		clAssunto 		:= "Aprova��o Price Protection (Estoque de clientes)"
		cTitulo			:= "Aprova��o do Price Protection </br> (Estoque de clientes)"
		
		//Cria�a� do objeto WF
		olProcess := TWFProcess():New(clAssunto, clAssunto) //Instancia objeto da classe TWFProcess para inicializar WF
		olProcess:NewTask(clAssunto, clHtmlMod)//Inicializa a tarefa
		olProcess:cSubject 	:= clAssunto
		olProcess:cTo 		:= cMailDest
		olProcess:bReturn 	:= "U_WFPP31RET()"//Rotina de retorno do WF
		
		oHtml    := olProcess:oHtml
                                     
		//Preenchimento dos dados do cabe�alho WF
		oHtml:ValByName( "cTiTuloHtml"	, cTitulo)
		oHtml:ValByName( "cCodPP"		, (cArqTmp)->PZC_CODPP )
		oHtml:ValByName( "cPublisher"	, (cArqTmp)->PZC_PUBLIS )
		oHtml:ValByName( "cCampanha"	, (cArqTmp)->PZC_PPPUB )
		oHtml:ValByName( "cVlTotRec"    , Transform((cArqTmp)->PZC_CREDRE,"@E 999,999,999.99" )  )
		oHtml:ValByName( "cVlTotRep"    , Transform((cArqTmp)->PZC_TOTREP,"@E 999,999,999.99" )  )
		oHtml:ValByName( "cDtProtec"  	, DTOC(STOD((cArqTmp)->PZC_DTAPLI))   )
		oHtml:ValByName( "cDtAprovP"   	, DTOC(STOD((cArqTmp)->PZC_DTACEI))  )
		oHtml:ValByName( "cCodAprov"   	, cCodUser  )
		oHtml:ValByName( "cNomAprov"   	, cNomeAprov  )
			                                   
		//preenchimento dos itens	
		While (cArqTmp)->(!Eof())
			
		 	AAdd( oHtml:ValByName("it.cDescNC") 	,Alltrim((cArqTmp)->PZD_CODPRO) +"-"+ (cArqTmp)->PZD_DESC  ) 
		 	AAdd( oHtml:ValByName("it.cCMGAnt") 	,Transform((cArqTmp)->PZD_CMGANT,"@E 999,999,999.9999" )	)
		 	AAdd( oHtml:ValByName("it.cCMGNov") 	,Transform((cArqTmp)->PZD_NOVCMG,"@E 999,999,999.9999" )	)
		 	AAdd( oHtml:ValByName("it.cVNFAnt") 	,Transform((cArqTmp)->PZD_PRCANT,"@E 999,999,999.99" ) 	)
		 	AAdd( oHtml:ValByName("it.cVNFNov") 	,Transform((cArqTmp)->PZD_PRCNOV,"@E 999,999,999.99" ) 	) 
		 	AAdd( oHtml:ValByName("it.cSRPAnt") 	,Transform((cArqTmp)->PZD_SRPANT,"@E 999,999,999.99" ) 		)
		 	AAdd( oHtml:ValByName("it.cSRPNov") 	,Transform((cArqTmp)->PZD_SRPNOV,"@E 999,999,999.99" ) 		)
			AAdd( oHtml:ValByName("it.cMasMgAnt") 	,Transform((cArqTmp)->PZD_MASANT,"@E 999,999,999,999.99" ) 	)
			AAdd( oHtml:ValByName("it.cMasMgNov") 	,Transform((cArqTmp)->PZD_MASNOV,"@E 999,999,999,999.99" ) 	)
			AAdd( oHtml:ValByName("it.cPerdMass") 	,Transform((cArqTmp)->PZD_DIFMAR,"@E 999,999,999,999.99" ) 	)
			AAdd( oHtml:ValByName("it.cPercMgAnt")	,Transform((cArqTmp)->PZD_MGVENF,"@E 999,999.99" ) 	)
			AAdd( oHtml:ValByName("it.cPercMgNov") 	,Transform((cArqTmp)->PZD_MGNVEN,"@E 999,999.99" ) 	)
			AAdd( oHtml:ValByName("it.cQtdTotVrj") 	,Transform((cArqTmp)->PZD_QUANT ,"@E 999,999,999,999" ) 		)
			AAdd( oHtml:ValByName("it.cVlTotRece") 	,Transform((cArqTmp)->PZD_TOTPUB,"@E 999,999,999,999.99" ) 		)
			AAdd( oHtml:ValByName("it.cVlTotRCli") 	,Transform((cArqTmp)->PZD_TOTREP,"@E 999,999,999,999.99" ) 		)
			AAdd( oHtml:ValByName("it.cDif") 		,Transform((cArqTmp)->PZD_DIFREP,"@E 999,999,999,999.99" ) 		)
			
			(cArqTmp)->(DbSkip())		
		EndDo
		
		//Preenchimento da tabela resumida dos clientes 
		cTableCli := U_NGetTClWF(cCodPP)
		oHtml:ValByName( "cTableCli"   	, cTableCli  )		 
		
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetDPP	�Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o arquivo temporario com os dados do price 		  ���
���          �protection												  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetDPP(cCodPP)

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP := ""


cQuery    := " SELECT PZC_CODPP, PZC_PUBLIS, PZC_PPPUB, PZC_CREDRE, PZC_TOTREP, PZC_DTAPLI, PZC_DTACEI, PZD_DESC, PZD_CMGANT, "+CRLF
cQuery    += "        PZD_NOVCMG, PZD_PRCANT, PZD_PRCNOV, PZD_SRPANT, PZD_SRPNOV, SUM(PZD_MASANT) PZD_MASANT, SUM(PZD_MASNOV) PZD_MASNOV, "+CRLF
cQuery    += "        SUM(PZD_DIFMAR) PZD_DIFMAR, ROUND(((SUM(PZD_MASANT) / (PZD_PRCANT * SUM(PZD_QUANT)) )*100),2) PZD_MGVENF, "+CRLF
cQuery    += "        ROUND(((SUM(PZD_MASNOV) / (PZD_PRCNOV * SUM(PZD_QUANT)) )*100),2) PZD_MGNVEN, SUM(PZD_QUANT) PZD_QUANT, "+CRLF
cQuery    += "        SUM(PZD_TOTPUB) PZD_TOTPUB, SUM(PZD_TOTREP) PZD_TOTREP, SUM(PZD_DIFREP) PZD_DIFREP, PZD_CODPRO FROM "+RetSqlName("PZC")+" PZC "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZD")+" PZD "+CRLF
cQuery    += " ON PZD.PZD_FILIAL = PZC.PZC_FILIAL "+CRLF
cQuery    += " AND PZD.PZD_CODPP = PZC.PZC_CODPP "+CRLF
cQuery    += " AND PZD.D_E_L_E_T_ = ' '  "+CRLF

cQuery    += " WHERE PZC.PZC_FILIAL = '"+xFilial("PZC")+"' "+CRLF
cQuery    += " AND PZC.PZC_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZC.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " GROUP BY PZC_CODPP, PZC_PUBLIS, PZC_PPPUB, PZC_CREDRE, PZC_TOTREP, PZC_DTAPLI, PZC_DTACEI, PZD_DESC, PZD_CMGANT, "+CRLF
cQuery    += "          PZD_NOVCMG, PZD_PRCANT, PZD_PRCNOV, PZD_SRPANT, PZD_SRPNOV, PZD_CODPRO "+CRLF
cQuery    += " ORDER BY PZD_DESC "+CRLF

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
���Programa  �WFPP31RET  �Autor  �Elton C.		    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorno do WF de libera��o para applica��o do 	          ���
���          �Price Protection                                            ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WFPP31RET(oProcRet) 

Local aArea 		:= GetArea() 
Local cCodPP		:= ""    
Local cAprRepr		:= "" 
Local cObsWF		:= "" 
Local cCodAprova	:= ""

If oProcRet != Nil
	
	cCodPP 		:= oProcRet:oHtml:RetByName("CCODPP")
	cAprRepr	:= oProcRet:oHtml:RetByName("APROVAR")
	cObsWF		:= oProcRet:oHtml:RetByName("OBS")
	cCodAprova	:= oProcRet:oHtml:RetByName("cCodAprov")//Codigo do aprovador
	
	DbSelectArea("PZC")
	DbSetOrder(1)
	If PZC->(DbSeek(xFilial("PZC") + cCodPP ))
		
		If Empty(PZC->PZC_FLAGAR)
			If Upper(Alltrim(cAprRepr)) == "S"
				AtuCApr(cCodPP, cCodAprova, .T., cObsWF)
			Else
				AtuCApr(cCodPP, cCodAprova, .F., cObsWF)
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
���Programa  �AtuStsPP  �Autor  �Elton C.		    � Data �   03/07/2014 ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o status de aprova��o do PP				          ���
���          �					                                          ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuStsPP(cCodPP, lAprovado) 

Local aArea := GetArea()

Default cCodPP		:= ""
Default lAprovado   := .F.

DbSelectArea("PZC")
DbSetOrder(1)
If PZC->(DbSeek(xFilial("PZC") + cCodPP ))
	
	If Empty(PZC->PZC_FLAGAR)
		
		If lAprovado
			Reclock("PZC",.F.)
			PZC->PZC_FLAGAR := "A"
			PZC->PZC_DTEFET := MsDate()
			PZC->(MsUnLock())
		Else
			Reclock("PZC",.F.)
			PZC->PZC_FLAGAR := "R"
			PZC->PZC_DTACEI := CTOD('')
			PZC->(MsUnLock())
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
Static Function AtuCApr(cCodPP, cCodApr, lAprovado, cObs)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodPP		:= "" 
Default cCodApr		:= ""
Default lAprovado   := .F.                   
Default cObs		:= ""
	
cQuery    := " SELECT R_E_C_N_O_ RECNOPZB FROM "+RetSqlName("PZB")+CRLF
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "+CRLF
cQuery    += " AND PZB_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZB_CODUSE = '"+cCodApr+"' "+CRLF
cQuery    += " AND PZB_STATUS = '3' "+CRLF
cQuery    += " AND PZB_TPREP = '2' "
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
	FinProcRep(cCodPP)
EndIf

//Envia o WF
//U_NCPP3ACL(cCodPP, lAprovado)
StartJob("U_NCPP3ACL",GetEnvServer(),.F.,{cEmpAnt,cFilAnt,cCodPP,lAprovado})
		
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
Static Function FinProcRep(cCodPP)

Local aArea :=  GetArea()  
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodPP := ""

cQuery    := " SELECT R_E_C_N_O_ RECNOPZB FROM "+RetSqlName("PZB")+CRLF
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "+CRLF
cQuery    += " AND PZB_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND PZB_STATUS = '3' "+CRLF                   
cQuery    += " AND PZB_TPREP = '2' "
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
���Programa  �NCWfFPP3RV  �Autor  �Elton C.			� Data �   03/07/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para reenvio do WF de aprova��o			  ���
���          � 									  						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWfFPP3RV(cCodPP)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodPP 		:= ""          

//Query para selecionar os aprovadores
cQuery    := " SELECT * FROM "+RetSqlName("PZB")
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "
cQuery    += " AND PZB_CODPP = '"+cCodPP+"' "
cQuery    += " AND PZB_STATUS = '3' "       
cQuery    += " AND PZB_TPREP = '2' "
cQuery    += " AND D_E_L_E_T_ = ' ' "
cQuery    += " ORDER BY PZB_NIVEL, PZB_NOMEUS "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())//Verifica se existe processo a ser aprovado
	
	//Envia o WF para o Aprovador
	If WFAPRPP31(cCodPP, (cArqTmp)->PZB_CODUSE, (cArqTmp)->PZB_NOMEUS, (cArqTmp)->PZB_MAIL)	
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

/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �CalcCMG	  � Autor �ELTON SANTANA	   � Data � 11/10/11  ���
���			 � 												  			  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Executa a rotina de recalculo do CMG 	 				  ���
���			 � 												  			  ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function CalcCMGPP(cCodPro, dDtApli, cCodPP)

Local aArea 	:= GetArea()
Local dDtAux    := CTOD('')
Local aRet		:= {}

Default cCodPro := ""                   
Default dDtApli	:= CTOD('')             
Default cCodPP	:= ""

//Recupera a data do 1� Price Protection
dDtAux := u_GetPDtPP( cCodPro )         

If !Empty(dDtAux) 
	aRet := u_GetPPAApl( dDtAux, MsDate(), cCodPro, cCodPP)
Else
	aRet := u_GetPPAApl( dDtApli, MsDate(), cCodPro, cCodPP)
EndIf

RestArea(aArea)
Return aRet    




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

