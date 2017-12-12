// #####################################################################################################
// Projeto:
// Modulo :
// Fonte  : Ncgrl213
// ---------+-------------------+-----------------------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------------------
// 24/02/16 | Lucas Felipe      | Programa responsavel pela geração de arquivo de pos.est Ecommerce
// ---------+-------------------+-----------------------------------------------------------------------

#Include 'Protheus.ch'
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"

#Define Enter Chr(13)+Chr(10)


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Job

@author    Lucas Felipe
@version   1.xx
@since     24/02/2016
/*/
//------------------------------------------------------------------------------------------

User Function Rl213Job(aDados)

	Default aDados:={"01","03"}
		
	RpcClearEnv()
	RpcSetEnv(aDados[1],aDados[2])

	Rl213csv()
        
	RpcClearEnv()
	
Return


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} NcgRl213

@author    Lucas Felipe
@version   1.xx
@since     24/02/2016
/*/
//------------------------------------------------------------------------------------------

User Function NcgRl213()

	Local cArmB2B		:= AllTrim("01")//colocar parametro do estoque b2b
	Local cArmB2C		:= AllTrim("51")//colocar parametro do estoque b2c

	Local cPerg		:= "NCGRL213  "
	Local oReport

	Local cArm			:= ""
	Local cArm2		:= ""
	Local nQtdSeg		:= 0
	Local nQtdEst		:= 0
	
	Local lB2B
	
	Private aAreaSql	:= GetNextAlias()


	Rl213Sx1(cPerg)
	Pergunte(cPerg,.T.)

	cArm		:= IIf(MV_PAR01==1,cArmB2B,cArmB2C) // Estoque principal
	cArm2		:= IIf(MV_PAR01==1,cArmB2C,cArmB2B) // Estoque secundario
	nQtdEst	:= MV_PAR02
	nQtdSeg	:= MV_PAR03
	
	lB2B := MV_PAR01 == 1

	oReport := ReportDef(lB2B,cArm,cArm2,nQtdEst,nQtdSeg)
	oReport:PrintDialog()
	

	If Select(aAreaSql)>0
		(aAreaSql)->(DbCloseArea())
	EndIf



Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

@author    Lucas Felipe
@version   1.xx
@since     24/02/2016
/*/
//------------------------------------------------------------------------------------------
Static Function ReportDef(lB2B,cArm,cArm2,nQtdEst,nQtdSeg)

	Local oReport
	Local oSection
	Local cTitle 	:=  "Posição de estoque"
	Local cRelDesc	:=	"Posição de estoque"

	
	oReport := TReport():New("RL213TELA",cTitle,"RL213TELA",{|oReport| PrintReport(oReport,lB2B,cArm,cArm2,nQtdEst,nQtdSeg)},cRelDesc)
	
	oReport:SetLandscape()
	oReport:SetTotalInLine(.F.)
	
	oSection := TRSection():New(oReport,cTitle,{"ZC5"})
	
	//TRCell():New( < oParent>, < cName>, [ cAlias], [ cTitle], [ cPicture], [ nSize], [ lPixel], [ bBlock] )
	
	TRCell():New(oSection,"COD"		,aAreaSql	,"Produto"		,"@!"		,16	)
	TRCell():New(oSection,"LOCAL" 	,aAreaSql	,"Local"		,"@R 99"	,3	)
	TRCell():New(oSection,"DESC"	,aAreaSql	,"Descrição"	,"@!"		,70 )
		
	If !lB2B
		TRCell():New(oSection,"DISP_51",aAreaSql	,"Disponivel 51"	,"@R 999.999.999"	,15	)
		TRCell():New(oSection,"DISP_01"	,aAreaSql	,"Disponivel 01"	,"@R 999.999.999"	,15	)
	Else
		TRCell():New(oSection,"DISP_01"	,aAreaSql	,"Disponivel 01"	,"@R 999.999.999"	,15	)
		TRCell():New(oSection,"DISP_51",aAreaSql	,"Disponivel 51"	,"@R 999.999.999"	,15	)
	EndIf
	
	//³ Alinhamento a direita as colunas de valor
	oSection:Cell("DISP_51"):SetHeaderAlign("RIGHT")
	oSection:Cell("DISP_01"):SetHeaderAlign("RIGHT")
	


Return oReport


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author    Lucas Felipe
@version   1.xx
@since     14/12/2015
/*/
//------------------------------------------------------------------------------------------

Static Function PrintReport(oReport,lB2B,cArm,cArm2,nQtdEst,nQtdSeg)

	Local oSection	:= oReport:Section(1)

	default lB2B		:= .F.		// .F. == B2C
	default cArm		:= '51' 	// Arm 51 Principal B2C
	default cArm2		:= '01' 	// Arm 01 Secundário
	default nQtdEst	:= 0		// Buscar apenas prod com estoque menor ou igual a 0nQtdEst
	default nQtdSeg	:= 10		// Estoque maior ou igual a  nQtdSeg

	If !lB2B
	
		BeginSql alias aAreaSql

			SELECT B2_COD,
			B2_LOCAL,
			B1_XDESC,
			(B2_QATU - B2_RESERVA) DISP51,
			(SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
			WHERE SB22.B2_FILIAL = %xfilial:SB2%
			AND SB22.B2_COD = SB2.B2_COD
			AND SB22.B2_LOCAL = %Exp:cArm2%
			AND (SB22.B2_QATU - SB22.B2_RESERVA) > 0
			AND SB22.%notDel%
			) DISP01
  
			FROM %table:SB2% SB2

			INNER JOIN %table:SB1% SB1
			ON SB1.B1_FILIAL = %xFilial:SB1%
			AND SB1.B1_COD = SB2.B2_COD
			AND SB1.%notDel%
		
			WHERE SB2.B2_FILIAL = %xfilial:SB2%
			AND SB2.B2_LOCAL = %Exp:cArm%
			AND (SB2.B2_QATU - SB2.B2_RESERVA) <= %Exp:nQtdEst%
			AND SB2.%notDel%
			AND EXISTS (SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
			WHERE SB22.B2_FILIAL = %xfilial:SB2%
			AND SB22.B2_COD = SB2.B2_COD
			AND SB22.B2_LOCAL = %Exp:cArm2%
			AND (SB22.B2_QATU - SB22.B2_RESERVA) >= %Exp:nQtdSeg%
			AND SB22.%notDel%
			)
                  
		EndSql
	
	Else
	
		BeginSql alias aAreaSql

			SELECT B2_COD,
			B2_LOCAL,
			B1_XDESC,
			(B2_QATU - B2_RESERVA) DISP51,
			(SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
			WHERE SB22.B2_FILIAL = %xfilial:SB2%
			AND SB22.B2_COD = SB2.B2_COD
			AND SB22.B2_LOCAL = %Exp:cArm2%
			AND (SB22.B2_QATU - SB22.B2_RESERVA) > 0
			AND SB22.%notDel%
			) DISP01
  
			FROM %table:SB2% SB2

			INNER JOIN %table:SB1% SB1
			ON SB1.B1_FILIAL = %xFilial:SB1%
			AND SB1.B1_COD = SB2.B2_COD
			AND SB1.%notDel%
		
			WHERE SB2.B2_FILIAL = %xfilial:SB2%
			AND SB2.B2_LOCAL = %Exp:cArm%
			AND (SB2.B2_QATU - SB2.B2_RESERVA) <= %Exp:nQtdEst%
			AND SB2.%notDel%
			AND EXISTS (SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
			WHERE SB22.B2_FILIAL = %xfilial:SB2%
			AND SB22.B2_COD = SB2.B2_COD
			AND SB22.B2_LOCAL = %Exp:cArm2%
			AND (SB22.B2_QATU - SB22.B2_RESERVA) >= %Exp:nQtdSeg%
			AND SB22.%notDel%
			)
                  
		EndSql
	
	EndIf
	
	oReport:SetMeter((aAreaSql)->(LastRec()))
	dbSelectArea(aAreaSql)
	
	//oReport:ThinLine() 
	//oSection:Init()
	
	While (aAreaSql)->(!Eof())
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oSection:Init()
				
		oSection:Cell("COD"):SetValue((aAreaSql)->B2_COD)
		oSection:Cell("LOCAL"):SetValue((aAreaSql)->B2_LOCAL)
		oSection:Cell("DESC"):SetValue((aAreaSql)->B1_XDESC)
		
		If !lB2B
			oSection:Cell("DISP_51"):SetValue((aAreaSql)->DISP51)
			oSection:Cell("DISP_01"):SetValue((aAreaSql)->DISP01)
		Else
			oSection:Cell("DISP_01"):SetValue((aAreaSql)->DISP01)
			oSection:Cell("DISP_51"):SetValue((aAreaSql)->DISP51)
	
		EndIf
		
		oSection:PrintLine()
		oReport:SkipLine()
		
		DbSelectArea(aAreaSql)
		(aAreaSql)->(DbSkip())
		
	End
	 
	oSection:Finish()
	oReport:IncMeter()
	



Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213csv


@author    Lucas Felipe
@version   1.xx
@since     24/02/2016
/*/
//------------------------------------------------------------------------------------------

Static Function Rl213csv()

	Local cPara		:= Alltrim(U_MyNewSX6("NCG_000084","lfelipe@ncgames.com.br","C","E-mail para envio de arquivo posição de estoque Ecommerce","","",.F. ))
	Local cAssunto  	:= "Posicao_Estoque"+DtoC(MsDate())
	Local cBody     	:= "Email gerado automaticamente"
	Local cAttach   	:= ""

	Local aAreaQry	:= GetNextAlias()

	Local nTotLinhas	:= 0
	Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
	Local cArq 		:= "Posi_est_"+DtoS(MsDate())
	Local cExtExcel	:= ".CSV"
	Local nArq

	Local cCabec	:= "CODIGO;LOCAL_ORIGINAL;DESCRICAO;DISP_51;DISP_01"
	Local cCabec2	:= "CODIGO;LOCAL_ORIGINAL;DESCRICAO;DISP_01;DISP_51"
	
	Local cArmB2B	:= Alltrim(U_MyNewSX6("MV_CIAESTO","01" ,"C","Armazem de estoque que sera importado no CiaShop","","",.F. ))
	Local cArmB2C	:= Alltrim(U_MyNewSX6("VT_000005","51" ,"C","Armazem de Venda Protheus Vtex","","",.F. ))
	Local nI


//----------------------------------------------------------
// Iniciar arquivo B2C - Arm 51 to 01
//----------------------------------------------------------
	
	nArq  := FCreate(cPathArq + cArq + "_B2C"+ cExtExcel )
	FWrite(nArq,cCabec+ Enter)

	BeginSql alias aAreaQry

		SELECT B2_COD,
		B2_LOCAL,
		B1_XDESC,
		(B2_QATU - B2_RESERVA) DISP_51,
		(SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
		WHERE SB22.B2_FILIAL = %xfilial:SB2%
		AND SB22.B2_COD = SB2.B2_COD
		AND SB22.B2_LOCAL = %Exp:cArmB2B%
		AND (SB22.B2_QATU - SB22.B2_RESERVA) > 0
		AND SB22.%notDel%
		) DISP_01
  
		FROM %table:SB2% SB2

		INNER JOIN %table:SB1% SB1
		ON SB1.B1_FILIAL = %xFilial:SB1%
		AND SB1.B1_COD = SB2.B2_COD
		AND SB1.%notDel%
		
		WHERE SB2.B2_FILIAL = %xfilial:SB2%
		AND SB2.B2_LOCAL = %Exp:cArmB2C%
		AND (SB2.B2_QATU - SB2.B2_RESERVA) <= 0
		AND SB2.%notDel%
		AND EXISTS (SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
		WHERE SB22.B2_FILIAL = %xfilial:SB2%
		AND SB22.B2_COD = SB2.B2_COD
		AND SB22.B2_LOCAL = %Exp:cArmB2B%
		AND (SB22.B2_QATU - SB22.B2_RESERVA) > 10
		AND SB22.%notDel%
		)
                  
	EndSql


	While !(aAreaQry)->(EOF())
		++ nTotLinhas
	
		cTexto	:= (aAreaQry)->B2_COD+";"+ (aAreaQry)->B2_LOCAL +";"+ (aAreaQry)->B1_XDESC +";"+ STR((aAreaQry)->DISP_51) +";"+ STR((aAreaQry)->DISP_01)
	
		FWrite(nArq, cTexto +Enter)
	
		(aAreaQry)->(DbSkip())
	
	EndDo
	

	FClose(nArq)
	(aAreaQry)->(DbCloseArea())
	
	cAttach:=cPathArq + cArq + "_B2C"+ cExtExcel

	
	U_RlSendCsv(,cPara,cAssunto+cArmB2C,cBody,cAttach)
	
	Ferase(cAttach)

//----------------------------------------------------------
// Iniciar arquivo B2B - Arm 01 to 51
//----------------------------------------------------------

	aAreaQry	:= GetNextAlias()
	nArq  		:= FCreate(cPathArq + cArq + "_B2B"+ cExtExcel )
	
	FWrite(nArq,cCabec+ Enter)

	BeginSql alias aAreaQry

		SELECT B2_COD,
		B2_LOCAL,
		B1_XDESC,
		(B2_QATU - B2_RESERVA) DISP_51,
		(SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
		WHERE SB22.B2_FILIAL = %xfilial:SB2%
		AND SB22.B2_COD = SB2.B2_COD
		AND SB22.B2_LOCAL = %Exp:cArmB2C%
		AND (SB22.B2_QATU - SB22.B2_RESERVA) > 0
		AND SB22.%notDel%
		) DISP_01
  
		FROM %table:SB2% SB2

		INNER JOIN %table:SB1% SB1
		ON SB1.B1_FILIAL = %xFilial:SB1%
		AND SB1.B1_COD = SB2.B2_COD
		AND SB1.%notDel%
		
		WHERE SB2.B2_FILIAL = %xfilial:SB2%
		AND SB2.B2_LOCAL = %Exp:cArmB2B%
		AND (SB2.B2_QATU - SB2.B2_RESERVA) <= 0
		AND SB2.%notDel%
		AND EXISTS (SELECT (SB22.B2_QATU - SB22.B2_RESERVA) QUANT FROM %table:SB2% SB22
		WHERE SB22.B2_FILIAL = %xfilial:SB2%
		AND SB22.B2_COD = SB2.B2_COD
		AND SB22.B2_LOCAL = %Exp:cArmB2C%
		AND (SB22.B2_QATU - SB22.B2_RESERVA) > 10
		AND SB22.%notDel%
		)
                  
	EndSql


	While !(aAreaQry)->(EOF())
		++ nTotLinhas
	
		cTexto	:= (aAreaQry)->B2_COD+";"+ (aAreaQry)->B2_LOCAL +";"+ (aAreaQry)->B1_XDESC +";"+ STR((aAreaQry)->DISP_01) +";"+ STR((aAreaQry)->DISP_51)
	
		FWrite(nArq, cTexto +Enter)
	
		(aAreaQry)->(DbSkip())
	
	EndDo
	
	FClose(nArq)
	cAttach:=cPathArq + cArq + "_B2B"+ cExtExcel
	

	U_RlSendCsv(,cPara,cAssunto+cArmB2B,cBody,cAttach)

	Ferase(cAttach)
	

	(aAreaQry)->(DbCloseArea())

Return


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} RlSendCsv


@author    Lucas Felipe
@version   1.xx
@since     24/02/2016
/*/
//------------------------------------------------------------------------------------------


User Function RlSendCsv(cFrom,cPara,cAssunto,cBody,cAttach)

	Local cUser 		:= GetNewPar("MV_RELACNT","")
	Local cPass 		:= GetNewPar("MV_RELAPSW","")
	Local cSendSrv 	:= GetNewPar("MV_RELSERV","")
	Local lMailAuth 	:= GetNewPar("MV_RELAUTH",.F.)
	Local nSmtpPort 	:= GetNewPar("MV_GCPPORT","")
	Local nPopPort
	Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
	Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)

	Local xRet
	Local oServer, oMessage

	Local cFrom1 		:= "Workflow@ncgames.com.br"
	Local nI

	Default cPara 	:= "lfelipe@ncgames.com.br"
	Default cAssunto	:= ""
	Default cBody 	:= ""

	If At(":",cSendSrv) > 0
		cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
	EndIf

	cFrom := IIf(Empty(cFrom),cFrom1,cFrom)

	oServer := TMailManager():New()
oServer:SetUseSSL( lSSL ) //ADD 26/05/2015 -- configuração de gmail
	oServer:SetUseTLS( lTLS ) //ADD 23/06/2016 -- configuração de gmail
	oServer:Init( "", cSendSrv, cUser, cPass, /*nPopPort*/, nSmtpPort )

// estabilish the connection with the SMTP server
	xRet := oServer:SMTPConnect()
	if xRet <> 0
		cMsg := "Could not connect on SMTP server: " + oServer:GetErrorString( xRet )
		conout( cMsg )
		return
	endif

// authenticate on the SMTP server (if needed)
	xRet := oServer:SmtpAuth( cUser, cPass )
	if xRet <> 0
		cMsg := "Could not authenticate on SMTP server: " + oServer:GetErrorString( xRet )
		conout( cMsg )
		oServer:SMTPDisconnect()
		return
	endif

	oMessage := TMailMessage():New()
	oMessage:Clear()

//oMessage:cDate := cValToChar( Date() )
	oMessage:cFrom	:= cFrom
	oMessage:cTo		:= cPara
	oMessage:cSubject	:= cAssunto
	oMessage:cBody	:= cBody

	
	If !Empty(cAttach)
		oMessage:AttachFile( cAttach ) // Adiciona um anexo.
	EndIf
	

	xRet := oMessage:Send( oServer )
	if xRet <> 0
		cMsg := "Could not send message: " + oServer:GetErrorString( xRet )
		conout( cMsg )
	endif

	xRet := oServer:SMTPDisconnect()
	if xRet <> 0
		cMsg := "Could not disconnect from SMTP server: " + oServer:GetErrorString( xRet )
		conout( cMsg )
	endif

return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rl213Sx1
// Fonte para a geração dos arquivos de importação.

 @author    Lucas Felipe
 @version   1.xx
 @since     25/02/2016
/*/
//------------------------------------------------------------------------------------------

Static Function Rl213Sx1(cPerg)

	Local aArea := GetArea()
	Local aHelpP	:= {}
	Local cString	:= ""

	Default cPerg		:= "NCGRL213  "

	Aadd( aHelpP, "Perguntas que definirão o tipo de relatorio a ser gerado." )


	cString := "Estoque Principal?"
	PutSx1(cPerg,"01",cString,cString,cString,"mv_ch1","C",1,0,0,"C","","","","","mv_par01","Estoque B2B","B2B","B2B","2","Estoque B2C","Estoque B2C","Estoque B2C","","","","","","","","","",aHelpP,,)
	
	aHelpP := {}
	Aadd( aHelpP, "Qnt. Estoque é referente a quantidade >= a digitada que vai ser buscado no Est principal" )
	cString := "Qnt. Estoque"
	PutSx1(cPerg,"02",cString,cString,cString,"mv_ch2","N",11,0,0,"G","Positivo()","","","","mv_par02","","","","0","","","","","","","","","","","","",aHelpP,,)
	
	aHelpP := {}
	Aadd( aHelpP, "Estoque de Segurança: Referente as peças de segurança que ficara no estoque secundario" )
	cString := "Estoque de Segurança?"
	PutSx1(cPerg,"03",cString,cString,cString,"mv_ch3","N",11,0,0,"G","Positivo()","","","","mv_par03","","","","10","","","","","","","","","","","","",aHelpP,,)

	aHelpP	:= {}

	RestArea(aArea)

Return
