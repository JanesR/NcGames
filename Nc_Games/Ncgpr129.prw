#include 'totvs.ch'
#include 'protheus.ch'

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Ncgpr129
Fonte responsavel pelo envio de email com a informação dos pedidos que não foram localizados 
no SGP ou Correios

@author    Lucas Felipe
@version   1.xx
@since     08/04/2016
/*/
//------------------------------------------------------------------------------------------

User Function Pr129job(aDados)
	Default aDados := {"01","03"}

	RpcSetEnv(aDados[1],aDados[2])

	U_Ncgpr129()

	RpcClearEnv()

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Ncgpr129
Fonte responsavel pelo envio de email com a informação dos pedidos que não foram localizados 
no SGP ou Correios

@author    Lucas Felipe
@version   1.xx
@since     08/04/2016
/*/
//------------------------------------------------------------------------------------------
User Function Ncgpr129()

	Local cPara		:= ""//definir parametro para manter boas praticas.
	Local cAssunto  	:= "Rastreios não encontrados no correio
	Local cBody     	:= "Email gerado automaticamente"
	Local cAttach   	:= ""

	Local aAreaAtu 	:= GetArea()
	Local aAliasQry	:= GetNextAlias()
	
	Local cDataIni 	:= DtoS(MsDate()-2)
	Local cDataFim 	:= DtoS(MsDate())
	Local aRast 		:= {}
	local cMsg 		:= ""
	
	Local cCodRast	:= ""
	Local cUrl			:= Alltrim(U_MyNewSX6("EC_NCG0021",'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=',	"C","URL Correrios","","",.F. ))
	Local cUrlAux
	Local cHtmlPage
	
	Local nI

	BeginSql Alias aAliasQry


		SELECT FRTRAS.COD_RASTREIO,
		SZ1.Z1_DOC,
		SZ1.Z1_SERIE,
		SZ1.Z1_PEDIDO,
		SZ1.Z1_DTSAIDA
		FROM %table:SZ1% SZ1

		LEFT OUTER JOIN FRETES.TB_FRT_INTERF_ECT FRTRAS
		ON Z1_PEDIDO = SubStr(NUM_DOCUMENTO,5,6)

		WHERE SZ1.Z1_FILIAL = %xfilial:SZ1%
		AND SZ1.Z1_DTSAIDA BETWEEN %Exp:cDataIni% AND %Exp:cDataFim%
		AND FRTRAS.COD_RASTREIO <> ' '
		AND SZ1.%notDel%
		AND SZ1.Z1_DTENTRE = ' ' 

	EndSql

	Do While (aAliasQry)->(!Eof())

		cCodRast	:= AllTrim((aAliasQry)->COD_RASTREIO)
			
		If !Empty(cCodRast) .And. Right(cCodRast,2)<>"BR"
			cCodRast+="BR"
		EndIf
			
		If !Empty(cCodRast)
			cUrlAux:=cUrl+cCodRast
			lConecta:=.F.
				
			For nCont:=1 To 2
					
				Conout("URL"+cUrlAux)
				cHtmlPage := Httpget(cUrlAux)
					
				If !ValType(cHtmlPage)=="C"
					Loop
				EndIf
					
				If At(cCodRast,cHtmlPage)>0
					lConecta:=.T.
					Exit
				EndIf
					
				cCodRast	:= AllTrim((aAliasQry)->COD_RASTREIO)
				cUrlAux	:= cUrl+cCodRast
			Next
					
		EndIf
		
		If lConecta
			aAdd(aRast,{(aAliasQry)->COD_RASTREIO,(aAliasQry)->Z1_DOC+(aAliasQry)->Z1_SERIE,(aAliasQry)->Z1_PEDIDO,(aAliasQry)->Z1_DTSAIDA})
		Endif
		
		(aAliasQry)->(DbSkip())
	EndDo
		
	For nI:=1 to Len(aRast)
		cMsg += "<p> "+ aRast[nI][1] +" - Objeto Inválido ou não encontrado! | NF: "+ aRast[nI][2] +" | Pv: "+ aRast[nI][3] +" | Dt.Saida: "+ DtoC(StoD(aRast[nI][4])) +"<br>"
	Next
	cMsg += "</p>"
	
	cBody := "<html><head></head><body>"+ cMsg +"</body></html>"
	cPara := "lfelipe@ncgames.com.br;fbborges@ncgames.com.br;rciambarella@ncgames.com.br;jisidoro@ncgames.com.br"	
	
	U_RlSendCsv(,cPara,cAssunto,cBody,cAttach)
	

	RestArea(aAreaAtu)

Return