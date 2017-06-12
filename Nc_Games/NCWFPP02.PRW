#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCWFPP02  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para montar a al็ada de aprova็ใo e 		  บฑฑ
ฑฑบ          ณ solicitar o envio do primeiro WF  						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCWFPP02(cCodPP)            

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cCodProc	:= ""   
Local lEnvWF	:= .F.

Default cCodPP := ""

cQuery    := " SELECT * FROM "+RetSqlName("PZA")+" PZA "+CRLF
cQuery    += " WHERE PZA.PZA_FILIAL = '"+xFilial("PZA")+"' "+CRLF
cQuery    += " AND PZA.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " ORDER BY PZA_NIVEL, PZA_CODUSE "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

//Se existir processo de aprova็ใo para o Price Protection, o mesmo serแ excluido, para gera็ใo da nova al็ada de aprova็ใo.
//RepProcExist(cCodPP)

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
		
		lEnvWF	:= .T.
	EndIf
	
	PZB->(MsUnLock())				
	
	(cArqTmp)->(DbSkip())
EndDo

If lEnvWF
	//Envia o WF para o aprovador
	//U_NCSelAPP({cEmpAnt,cFilAnt,cCodPP,.T.})  
	StartJob("U_NCSelAPP",GetEnvServer(),.F.,{cEmpAnt,cFilAnt,cCodPP,.T.})
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return          


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRepProcExist  บAutor  ณElton C.	    บ Data ณ   03/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica se existe processo de aprova็ใo. Se existir  	  บฑฑ
ฑฑบ          ณ o mesmo serแ excluido para cria็ใo do novo processo.		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RepProcExist(cCodPP)

Local aArea 	:= GetArea()
Local cQuery    := "" 
Local cArqTmp	:= GetNextAlias()             

Default cCodPP := ""

cQuery    := " SELECT R_E_C_N_O_ RECNOPZB FROM "+RetSqlName("PZB")+" PZB010 "
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "
cQuery    += " AND PZB_CODPP = '"+cCodPP+"' "
cQuery    += " AND D_E_L_E_T_ = ' ' "      

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

DbSelectArea("PZB")
DbSetOrder(1)

While (cArqTmp)->(!Eof())
	 PZB->(DbGoTo((cArqTmp)->RECNOPZB))     

     PZB->(Reclock("PZB", .F.))
	 PZB->(DbDelete())
     PZB->(MsUnLock())
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCSelAPP  บAutor  ณElton C.			บ Data ณ   03/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para envio do WF de aprova็ใo			  บฑฑ
ฑฑบ          ณ 									  						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCSelAPP(aParam)

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
cQuery    += " AND D_E_L_E_T_ = ' ' "
cQuery    += " ORDER BY PZB_NIVEL, PZB_NOMEUS "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())//Verifica se existe processo a ser aprovado
	
	//Envia o WF para o Aprovador
	WFAPRPP02(cCodPP, (cArqTmp)->PZB_CODUSE, (cArqTmp)->PZB_NOMEUS, (cArqTmp)->PZB_MAIL)	
	
	
ElseIf lAprovado //Envia e-mail ao solicitante informando o final do processo de aprova็ใo
	
	AtuStsPP(cCodPP, lAprovado)  

	//Efetua a aplica็ใo do Price Protection    
    U_PR102Aplic(cCodPP)
        
    //Envia e-mail ao solicitante informando a aprova็ใo
	DbSelectArea("PZB")
	DbSetOrder(2)
	If PZB->(DbSeek(xFilial("PZB") + cCodPP ))
	 	NCWF2SEND("Price Protection Aprovado - "+cCodPP,;
	 				 "O Price Protection "+cCodPP+" foi aprovado e aplicado. "+CRLF+;
	 				 	"Por gentileza, analisar o novo custo gerencial. "+CRLF+CRLF+"E-mail automแtico, favor nใo responder. ",;
	 				  {}, PZB->PZB_MAILSO, "", "")
	EndIf
	
Else //Envia e-mail ao solicitante informando o final do processo caso seja reprovado 
	AtuStsPP(cCodPP, lAprovado)	             
	
	//Envia e-mail ao solicitante de aprovado
	DbSelectArea("PZB")
	DbSetOrder(2)
	If PZB->(DbSeek(xFilial("PZB") + cCodPP ))
	 	
	 	NCWF2SEND("Price Protection Reprovado - "+cCodPP,;
	 				 "O Price Protection "+cCodPP+" foi reprovado. "+CRLF+CRLF+"E-mail automแtico, favor nใo responder. ",;
	 				 {}, PZB->PZB_MAILSO, "", "")
	 				  
	 				  
	EndIf
	
Endif


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


           

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFAPRPP02  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para envio do WF de aprova็ใo			  บฑฑ
ฑฑบ          ณ 									  						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WFAPRPP02(cCodPP, cCodUser, cNomeAprov, cMailDest)

Local aArea 			:= GetArea()
Local lReturn			:=.T.
Local clCodProces		:= ""//Nome do Processo de WorkFlow
Local clHtmlMod 		:= "" //Nome do arquivo html que serแ gerado para envio ao setor financeiro
Local clAssunto 		:= ""
Local cTitulo			:= ""
Local clMailID			:= ""
Local cArqTmp			:= ""
Local aCust				:= {}
Local cTitEstCli		:= ""			
Local lProxLiNCL		:= .F.
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
clHtmlMod := cDirHtml+IIf(Right(clHtmlMod,1) != "\", "\","")+ "solaprpp.htm"


If (cArqTmp)->(!Eof())

	If File(clHtmlMod) 
	    
		clAssunto 		:= "Aprova็ใo Price Protection (Estoque NC Games)"
		cTitulo			:= "Aprova็ใo do Price Protection </br> (Estoque NC Games)"
		
		//Cria็a๕ do objeto WF
		olProcess := TWFProcess():New(clAssunto, clAssunto) //Instancia objeto da classe TWFProcess para inicializar WF
		olProcess:NewTask(clAssunto, clHtmlMod)//Inicializa a tarefa
		olProcess:cSubject 	:= clAssunto
		olProcess:cTo 		:= cMailDest
		olProcess:bReturn 	:= "U_WFPP02RET()"//Rotina de retorno do WF
		
		oHtml    := olProcess:oHtml
                                     
		//Preenchimento dos dados do WF
		oHtml:ValByName( "cTiTuloHtml"	, cTitulo)
		oHtml:ValByName( "cCodPP"		, (cArqTmp)->P05_CODPP   )
		oHtml:ValByName( "cPublisher"	, (cArqTmp)->P05_PUBLIS  )
		oHtml:ValByName( "cCampanha"	, (cArqTmp)->P05_PPPUB  	 )
		oHtml:ValByName( "cVlTotRep"    , Transform((cArqTmp)->P05_NCUSTO,"@E 999,999,999.99" )  )
		oHtml:ValByName( "cDtApli"  	, DTOC(STOD((cArqTmp)->P05_DTAPLI))   )
		oHtml:ValByName( "cDtAprovP"   	, DTOC(STOD((cArqTmp)->P05_DTACEI))  )
		oHtml:ValByName( "cCodAprov"   	, cCodUser  )
		oHtml:ValByName( "cNomAprov"   	, cNomeAprov  )
		
			
		While (cArqTmp)->(!Eof())
			
		 	AAdd( oHtml:ValByName("it.cDescNC") 	,(cArqTmp)->P06_DESC) 
		 	AAdd( oHtml:ValByName("it.cCodProd") 	,(cArqTmp)->P06_CODPRO)
		 	AAdd( oHtml:ValByName("it.cPlataf") 	,(cArqTmp)->P06_DPLATA)
		 	AAdd( oHtml:ValByName("it.cArmz") 		,(cArqTmp)->P06_LOCAL)		 	
		 	AAdd( oHtml:ValByName("it.cQtdProt") 	,Transform((cArqTmp)->P06_QUANT,"@E 999,999,999.99" ))
		 	AAdd( oHtml:ValByName("it.CMGAnt") 		,Transform((cArqTmp)->P06_CUSCON,"@E 999,999.9999" ) 	)
		 	AAdd( oHtml:ValByName("it.cCMGNovo") 	,Transform((cArqTmp)->P06_YCMVG ,"@E 999,999.9999" ) 	)
		 	AAdd( oHtml:ValByName("it.cDescUnit") 	,Transform((cArqTmp)->P06_VLUNIT,"@E 999,999.9999" ) ) 
		 	AAdd( oHtml:ValByName("it.cPrcAnt") 	,Transform((cArqTmp)->P06_PRCATU,"@E 999,999.99" ) )
		 	AAdd( oHtml:ValByName("it.cPrcNovo") 	,Transform((cArqTmp)->P06_PRCNOV,"@E 999,999.99" ) )
			AAdd( oHtml:ValByName("it.cMasMgAnt") 	,Transform((cArqTmp)->P06_MASATU,"@E 999,999,999,999.99" ) )
			AAdd( oHtml:ValByName("it.cMasMgNov") 	,Transform((cArqTmp)->P06_MASNOV,"@E 999,999,999,999.99" ) )
			AAdd( oHtml:ValByName("it.cMasMgDif") 	,Transform((cArqTmp)->P06_DIFMAS,"@E 999,999,999,999.99" ) )
			AAdd( oHtml:ValByName("it.cMgAnterior")	,Transform((cArqTmp)->P06_MGATUA,"@E 999,999.99" ) )
			AAdd( oHtml:ValByName("it.cMgNovo") 	,Transform((cArqTmp)->P06_MGNOVA,"@E 999,999.99" ) )
			                                                                                                                   
			(cArqTmp)->(DbSkip())		
		EndDo
		 
		
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDPP	บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o arquivo temporario com os dados do price 		  บฑฑ
ฑฑบ          ณprotection												  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDPP(cCodPP)

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()	

Default cCodPP := ""

cQuery    := " SELECT * FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("P06")+ " P06 "+CRLF
cQuery    += " ON P06.P06_FILIAL = P05.P05_FILIAL "+CRLF
cQuery    += " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQuery    += " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery    += " AND P05.P05_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND P05.D_E_L_E_T_ = ' ' "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

(cArqTmp)->(DbGoTop())

RestArea(aArea)
Return cArqTmp


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvWFLink  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o link do WF para acesso interno e externo			  บฑฑ
ฑฑบ          ณ														      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvWFLink(cHtmlFile, cOldTo, cOldCC, cOldBCC, cSubject, clAssunto, cNomeAprov, oObjWf, cUserWF, cNumAlc )

Local aArea			:= GetArea()
Local cSrvHttpIn 	:= U_MyNewSX6("NCG_000020",;
									"",;
									"C",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere็o interno (a clausula 'http://' ้ necessแria ) ",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere็o interno (a clausula 'http://' ้ necessแria ) ",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere็o interno (a clausula 'http://' ้ necessแria ) ",;
									.F. )
Local cSrvHttpEx 	:=  U_MyNewSX6(	"NCG_000021",;
									"",;
									"C",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere็o externo (a clausula 'http://' ้ necessแria )",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere็o externo (a clausula 'http://' ้ necessแria )",;
									"Server HTTP do Protheus: utilizado para WORKFLOW - Endere็o externo (a clausula 'http://' ้ necessแria )",;
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
									"Endere็o dos arquivos de workflow para acesso via browser do Protheus (nใo incluir a pasta com o c๓digo da empresa, pois a rotina preencherแ automaticamente )",;
									"Endere็o dos arquivos de workflow para acesso via browser do Protheus (nใo incluir a pasta com o c๓digo da empresa, pois a rotina preencherแ automaticamente )",;
									"Endere็o dos arquivos de workflow para acesso via browser do Protheus (nใo incluir a pasta com o c๓digo da empresa, pois a rotina preencherแ automaticamente )",;
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
	
	Aviso("Aten็ใo","Nใo foi localizado o modelo HTML para envio do link Workflow. Solicite ao Dpto. de Tecnologia da Informa็ใo para verificar os modelos HTML do Workflow de aprova็ใo do Price Protection.",{"Ok"},3)
	
EndIf

RestArea(aArea)
Return(cIdWf)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFPP02RET  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorno do WF de libera็ใo para applica็ใo do 	          บฑฑ
ฑฑบ          ณPrice Protection                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WFPP02RET(oProcRet)

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
	
	DbSelectArea("P05")
	DbSetOrder(1)
	If P05->(DbSeek(xFilial("P05") + cCodPP ))
		
		If Empty(P05->P05_FLAGAR)
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuStsPP  บAutor  ณElton C.		    บ Data ณ   03/07/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o status de aprova็ใo do PP				          บฑฑ
ฑฑบ          ณ					                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuStsPP(cCodPP, lAprovado)

Local aArea := GetArea()

Default cCodPP		:= ""
Default lAprovado   := .F.

DbSelectArea("P05")
DbSetOrder(1)
If P05->(DbSeek(xFilial("P05") + cCodPP ))
	
	If Empty(P05->P05_FLAGAR)
		
		If lAprovado
			Reclock("P05",.F.)
			P05->P05_FLAGAR := "A"
			P05->(MsUnLock())
		Else
			Reclock("P05",.F.)
			P05->P05_FLAGAR := "R"
			P05->P05_DTACEI := CTOD('')
			P05->(MsUnLock())
		EndIf
	
	EndIF
EndIf

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuCApr  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza a tabela (PZB) de controle de aprova็ใo	          บฑฑ
ฑฑบ          ณ					                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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

//Reprova todos os processo em caso de alguma reprova็ใo
If !lAprovado
	FinProcRep(cCodPP)
EndIf

//Envia o WF
//U_NCSelAPP(cCodPP, lAprovado)
StartJob("U_NCSelAPP",GetEnvServer(),.F.,{cEmpAnt,cFilAnt,cCodPP,lAprovado})
		
(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFinProcRep  บAutor  ณElton C.		    บ Data ณ   20/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFinaliza os proximos processos devido a reprova็ใo 	      บฑฑ
ฑฑบ          ณ					                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCWFReenv  บAutor  ณElton C.			บ Data ณ   03/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para reenvio do WF de aprova็ใo			  บฑฑ
ฑฑบ          ณ 									  						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCWFReenv(cCodPP)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cCodPP 		:= ""          

//Query para selecionar os aprovadores
cQuery    := " SELECT * FROM "+RetSqlName("PZB")
cQuery    += " WHERE PZB_FILIAL = '"+xFilial("PZB")+"' "
cQuery    += " AND PZB_CODPP = '"+cCodPP+"' "
cQuery    += " AND PZB_STATUS = '3' "
cQuery    += " AND D_E_L_E_T_ = ' ' "
cQuery    += " ORDER BY PZB_NIVEL, PZB_NOMEUS "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())//Verifica se existe processo a ser aprovado
	
	//Envia o WF para o Aprovador
	If WFAPRPP02(cCodPP, (cArqTmp)->PZB_CODUSE, (cArqTmp)->PZB_NOMEUS, (cArqTmp)->PZB_MAIL)	
		Aviso("Aten็ใo","WF Reenviado com sucesso.",{"Ok"},2)	
	Else
		Aviso("Aten็ใo","Erro ao tentar reenviar o WF.",{"Ok"},2)	
	EndIf
	
	
Else
	Aviso("Aten็ใo","Nใo existe processo a ser reenviado.",{"Ok"},2)

Endif


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณCalcCMG	  ณ Autor ณELTON SANTANA	   ณ Data ณ 11/10/11  ณฑฑ
ฑฑณ			 ณ 												  			  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Executa a rotina de recalculo do CMG 	 				  ณฑฑ
ฑฑณ			 ณ 												  			  ณฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function CalcCMGPP(cCodPro, dDtApli, cCodPP)

Local aArea 	:= GetArea()
Local dDtAux    := CTOD('')
Local aRet		:= {}

Default cCodPro := ""                   
Default dDtApli	:= CTOD('')             
Default cCodPP	:= ""

//Recupera a data do 1บ Price Protection
dDtAux := u_GetPDtPP( cCodPro )         

If !Empty(dDtAux) 
	aRet := u_GetPPAApl( dDtAux, MsDate(), cCodPro, cCodPP)
Else
	aRet := u_GetPPAApl( dDtApli, MsDate(), cCodPro, cCodPP)
EndIf

RestArea(aArea)
Return aRet    




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSetEmpFil บAutor  ณElton C.         	 บFecha ณ  10/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao utilizada para setar a empresa e filial	  	  	  บฑฑ
ฑฑบ			 |						                    				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP 	                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCWF2SEND  บAutor  ณMicrosiga           บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
		cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return(lRetorno)

