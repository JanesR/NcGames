#include 'protheus.ch'
#include 'parmtype.ch'



CLASS ConsultaRastreios

	Data cUsuario
	Data cSenha 
	Data cTipoCon
	Data cResultado
	Data cObjetos 
	Data cPostUrl
	Data oRetorno 
	Data aHeadOut
	Data cHeadRet 
	Data cParms
	Data cLingua
	Data cSoapAction
	Data cBanco
	Data cLinkMoto
	Data cTokemMoto
	
	
	Method New()
	Method BuscaRastreiosCorreios()
	Method VerificaPedidos()
	Method SvcSoapCall()
	Method AtaulizaZ1()
	Method BuscaRastMotoBoy()
	Method ConsultaRastMoto()

End Class

/*------------------------------------------------------------------------------

@autor: Flavio de Brito Borges
@Descrição: Metodo construtor da classe.

//-----------------------------------------------------------------------------*/
Method New() Class ConsultaRastreios
  Self:cBanco := "P0G"
    Self:cUsuario 				:= AllTrim(U_MyNewSx6("NCG_200002",'nc', 'C', 'Usuario dos Correios para consulta de rastreios', '', '', .F. ))
    	Self:cSenha 			:= AllTrim(U_MyNewSx6("NCG_200003",'i97y97', 'C', 'Senha para consulta de codigos de rastreios nos Correios.', '', '', .F. ))
	 Self:cTokemMoto 			:= AllTrim(U_MyNewSx6("NCG_200004",'c38531a0-fc1f-11e5-93e3-0eb033e00358', 'C', 'Token para consultar rastreios da empresa Rapido.', '', '', .F. ))
  Self:cLinkMoto				:= AllTrim(U_MyNewSx6("NCG_200006","https://www.rapiddo.com.br/api/v1/orders/",'C',"Link da API da Rapido",'','',.F.))
Return Self

/*------------------------------------------------------------------------------

@autor: Flavio de Brito Borges
@Descrição: Metodo para consulta dos rastreios no sistema dos Correios.

//-----------------------------------------------------------------------------*/
Method BuscaRastreiosCorreios() Class ConsultaRastreios
	
	Local cAliasNovo
	Local cQuery
	Local cTipo
	Local nStatus
	Local dDtEntrega
	Local cStatusRet := Nil
	Local nQtdArray
	

	Self:cTipoCon := "L"
	Self:cResultado := "U"
	Self:cObjetos :=""
	Self:cPostUrl := "http://webservice.correios.com.br:80/service/rastro"
	Self:oRetorno :=""
	Self:aHeadOut :={}
	Self:cHeadRet :=""
	Self:cParms :=""
	Self:cLingua :="001"
	Self:cSoapAction := ""
	
	cAliasNovo := GetNextAlias()
	
		cQuery :=	"SELECT P0G_PEDIDO, P0G_NOTA, P0G_RAST FROM " + RetSQLName(Self:cBanco) + " "
		cQuery +=	"WHERE P0G_FILIAL = '" + xFilial(Self:cBanco)+"'"
		cQuery +=	"AND P0G_DTENTR = ' ' "
		cQuery +=	"AND D_E_L_E_T_=' ' "
		cQuery +=	"AND LENGTH(TRIM(P0G_RAST))>=13"
	
	 cQuery := ChangeQuery(cQuery)
	 dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),cAliasNovo, .F., .T.)
	 dbSelectArea(cAliasNovo)
	
	 HttpSetPass(Self:cUsuario,Self:cSenha)
	  
	 dbSelectArea(Self:cBanco)
	 dbSetOrder(1)
 
	 While (cAliasNovo)->(!Eof()) 

	cStatusRet := Nil
	
	Self:cParms := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:res="http://resource.webservice.correios.com.br/">'
	Self:cParms +='<soapenv:Header/>'
	Self:cParms +='<soapenv:Body>'
	Self:cParms +=' <res:buscaEventos>'

	Self:cParms +='    <usuario>'+ Self:cUsuario +'</usuario>'
	Self:cParms +='    <senha>'+ Self:cSenha +'</senha>'
	Self:cParms +='   <tipo>'+ Self:cTipoCon +'</tipo>'
	Self:cParms +='   <resultado>'+ Self:cResultado +'</resultado>'
	Self:cParms +='   <lingua>'+ Self:cLingua +'</lingua>'
	Self:cParms +='  <objetos>' + AllTrim((cAliasNovo)->P0G_RAST) + '</objetos>'

	Self:cParms +=' </res:buscaEventos>'
	Self:cParms +=' </soapenv:Body>'
	Self:cParms +=' </soapenv:Envelope>'
	
	Self:cSoapAction	:= "http://resource.webservice.correios.com.br/Service/buscaEventosResponse"
	
	Self:oRetorno	:= Self:SvcSoapCall(Self:cParms,Self:cSoapAction,Self:cPostUrl,.F.,.T.)
	
	If ValType(Self:oRetorno) == "O"
	
			If ValType(Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO)== "O"
			
				cStatusRet := XmlChildEx(Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO,"_ERRO")
			
			Else
				cStatusRet:= Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO[1]
				 
			EndIF
	
	If cStatusRet == Nil
		If ValType(Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO) == "A"
			nQtdArray := Len(Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO)

			cTipo 		:= Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO[nQtdArray]:_TIPO:TEXT
			nStatus 	:= Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO[nQtdArray]:_STATUS:TEXT
			dDtEntrega 	:= cToD(Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO[nQtdArray]:_DATA:TEXT)
		Else
			cTipo 		:= Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO:_TIPO:TEXT
			nStatus 	:= Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO:_STATUS:TEXT
			dDtEntrega 	:= cToD(Self:oRetorno:_SOAPENV_ENVELOPE:_SOAPENV_BODY:_NS2_BUSCAEVENTOSRESPONSE:_RETURN:_OBJETO:_EVENTO:_DATA:TEXT)
		EndIf
		
		
			If (cTipo == "BDE" .Or. cTipo == "BDI" .Or. cTipo == "BDR") .And. nStatus == "01"
					
					
					 If dbSeek(xFilial(Self:cBanco) + AllTrim((cAliasNovo)->P0G_PEDIDO) + AllTrim((cAliasNovo)->P0G_NOTA) + AllTrim((cAliasNovo)->P0G_RAST))
					 
						RECLOCK(Self:cBanco,.F.)
					 			P0G->P0G_STATUS	:= nStatus
					 			P0G->P0G_TIPO	:= cTipo
					 			P0G->P0G_DTENTR	:= dDtEntrega
					 	MSUNLOCK()
						
					EndIf
				 
			EndIf 
			
	EndIf
			(cAliasNovo)->(DbSkip())
 		
	EndIf
 EndDo
 
 dbCloseArea(cAliasNovo)
 dbCloseArea(Self:cBanco)
	
Return

/*------------------------------------------------------------------------------

@autor: Flavio de Brito Borges
@Descrição: Metodo para verificar pedidos/notas que estão sem data de entrega e possuem rastreios.

//-----------------------------------------------------------------------------*/
Method VerificaPedidos() Class ConsultaRastreios

Local cQuery
Local cAliasNovo


 cAliasNovo := GetNextAlias()

 
cQuery  ="SELECT DISTINCT Z1.Z1_FILIAL,Z1.Z1_DOC,Z1.Z1_PEDIDO, "
cQuery +="CASE "
cQuery +="WHEN (Z5.ZC5_RASTRE <>' ' AND LENGTH(Z5.ZC5_RASTRE)<13) "
cQuery +="     OR (Z5.ZC5_RASTRE <>' ' AND TRIM(Z5.ZC5_RASTRE) NOT IN (SELECT COD_RASTREIO FROM FRETES.TB_FRT_INTERF_ECT)) "
cQuery +="     THEN Z5.ZC5_RASTRE "
cQuery +="WHEN FR.COD_RASTREIO IS NOT NULL THEN FR.COD_RASTREIO "
cQuery +="WHEN Z5.ZC5_RASTRE=' ' AND FR.COD_RASTREIO IS NULL THEN NULL "
cQuery +='END  AS "RASTREIOS" '
cQuery +="FROM " + RetSQLName("SZ1") + " Z1 "
cQuery +="LEFT JOIN FRETES.TB_FRT_INTERF_ECT FR "
cQuery +="ON(Z1.Z1_DOC = LPAD(FR.NUM_NF,9,'0')) "
cQuery +="LEFT JOIN "+ RetSQLName("ZC5") +" Z5 "
cQuery +="ON Z5.ZC5_FILIAL = '"+ xFilial("SZ1") +"' "
cQuery +="AND Z5.D_E_L_E_T_= ' ' "
cQuery +="AND Z5.ZC5_NOTA <> ' ' "
cQuery +="AND Z5.ZC5_STATUS < '90' "
cQuery +="AND (Z5.ZC5_NOTA  = Z1.Z1_DOC ) "
cQuery +="WHERE Z1.Z1_FILIAL='"+ xFilial("SZ1") +"' "
cQuery +="AND Z1.D_E_L_E_T_=' ' "
cQuery +="AND Z1.Z1_DTSAIDA <> ' ' "
cQuery +="AND Z1.Z1_DTBAIXA =' ' "
cQuery +="AND Z1.Z1_DOC NOT IN (SELECT P0G_NOTA FROM " + RetSQLName(Self:cBanco) + " WHERE P0G_FILIAL = '" + xFilial(Self:cBanco) + "' AND  D_E_L_E_T_=' ') "
cQuery +="HAVING 'RASTREIOS' IS NOT NULL"
 
 cQuery := ChangeQuery(cQuery)
 dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),cAliasNovo, .F., .T.)
 dbSelectArea(cAliasNovo)
 
 dbSelectArea(Self:cBanco)
 dbSetOrder(1)
 While (cAliasNovo)->(!Eof()) 
 
 	IF  !dbSeek(xFilial(Self:cBanco) + (cAliasNovo)->Z1_PEDIDO + (cAliasNovo)->Z1_DOC + (cAliasNovo)->RASTREIOS)
 			IF !Empty(AllTrim((cAliasNovo)->RASTREIOS))
 			RECLOCK(Self:cBanco,.T.)
				P0G->P0G_FILIAL := xFilial(Self:cBanco)
				P0G->P0G_PEDIDO := (cAliasNovo)->Z1_PEDIDO
				P0G->P0G_NOTA 	:= (cAliasNovo)->Z1_DOC
				P0G->P0G_RAST 	:= (cAliasNovo)->RASTREIOS
 			MSUNLOCK() 
 			EndIf
 	EndIf
 	(cAliasNovo)->(DbSkip())
 EndDo
 
dbCloseArea(cAliasNovo)
dbCloseArea(Self:cBanco)

Return


/*------------------------------------------------------------------------------

@autor: Flavio de Brito Borges
@Descrição: Metodo para conexão e consutal do objeto xml/soap (cSoap) montado.

//-----------------------------------------------------------------------------*/
Method SvcSoapCall(cSoap,cSoapAction,cPostUrl,lSaveXML,lRetObj) Class ConsultaRastreios
Local cRetPost  := ""
Local aHeadOut  := {}
Local cXmlHead  := ""
Local cError    := ""
Local cWarning  := ""
Local oXmlRet   := Nil
Local nHdl
Local cMensagem:=""

Default lSaveXML	:=.F.
Default lRetObj	:=.F.

aadd(aHeadOut,'SOAPAction: '+ cSoapAction)
aadd(aHeadOut,'Content-Type: text/xml; charset=' + "utf-8" )
aadd(aHeadOut,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+'; '+'ADVPL WSDL Client 1.060117'+')')

If lSaveXML
	nHdl := FCreate(CriaTrab(Nil,.F.)+"_snd.xml")
	FWrite(nHdl,cSoap)
	FClose(nHdl)
EndIf

cRetPost := Httppost(cPostUrl,"",cSoap,,aHeadOut,@cXmlHead)

If (lRetObj .And. cRetPost <> Nil)
	uRetorno := XmlParser(cRetPost,'_',@cError,@cWarning)
Else
	uRetorno:=cRetPost
EndIf

If lSaveXML
	nHdl := FCreate(CriaTrab(Nil,.F.)+"_RCV.XML")
	FWrite(nHdl,cRetPost)
	FClose(nHdl)
EndIf


Return(uRetorno)

/*------------------------------------------------------------------------------

@autor: Flavio de Brito Borges
@Descrição: Metodo para atualizar a tabela Z1 com o status dos rastreios.

//-----------------------------------------------------------------------------*/
Method AtaulizaZ1() Class ConsultaRastreios

	Local cQuery
	Local cAliasNovo
	
	cAliasNovo := GetNextAlias()
	
	cQuery:= "SELECT VOLUMES.FILIAL FILIAL,                         "
	cQuery+= "       VOLUMES.PEDIDO PEDIDO,                         "
	cQuery+= "       VOLUMES.NOTA NOTA,                             "
	cQuery+= "       VOLUMES.VOLUMES VOLUMES,                       "
	cQuery+= "       CASE                                           "
	cQuery+= "           WHEN FINALIZADOS.FINALIZADOS IS NULL THEN 0"
	cQuery+= "           ELSE FINALIZADOS.FINALIZADOS               "
	cQuery+= "       END AS FINALIZADOS,                            "
	cQuery+= "       FINALIZADOS.DATAENTREGA DATA                   "
	cQuery+= "FROM                                                  "
	cQuery+= "  (SELECT P0G.P0G_FILIAL FILIAL,                      "
	cQuery+= "          P0G.P0G_PEDIDO PEDIDO,                      "
	cQuery+= "          P0G.P0G_NOTA NOTA,                          "
	cQuery+= "          COUNT(P0G.P0G_RAST) VOLUMES                 "
	cQuery+= "   FROM " + RetSQLName(Self:cBanco) + " P0G           "
	cQuery+= "   LEFT JOIN " + RetSQLName("SZ1") + " Z1		        "
	cQuery+= "   ON(                                                "
	cQuery+= "        P0G.P0G_NOTA=Z1.Z1_DOC                        "
	cQuery+= "      )                                               "
	cQuery+= "   WHERE P0G_FILIAL= '" + xFilial(Self:cBanco) + "'   "
	cQuery+= "     AND P0G.D_E_L_E_T_ = ' '                         "
	cQuery+= "     AND Z1.Z1_FILIAL= '" + xFilial(Self:cBanco) + "' "
	cQuery+= "     AND Z1.D_E_L_E_T_=' '                            "
	cQuery+= "     AND Z1.Z1_DTENTRE = ' '                          "
	cQuery+= "   GROUP BY P0G.P0G_FILIAL,                           "
	cQuery+= "            P0G.P0G_PEDIDO,                           "
	cQuery+= '            P0G.P0G_NOTA) "VOLUMES" 					'
	cQuery+= "LEFT JOIN                                             "
	cQuery+= "  (SELECT P0G.P0G_FILIAL FILIAL,                      "
	cQuery+= "          P0G.P0G_PEDIDO PEDIDO,                      "
	cQuery+= "          P0G.P0G_NOTA NOTA,                          "
	cQuery+= "          COUNT(P0G.P0G_RAST)  FINALIZADOS,           "
	cQuery+= "          MAX(P0G.P0G_DTENTR) DATAENTREGA             "
	cQuery+= "   FROM " + RetSQLName(Self:cBanco) + " P0G           "
	cQuery+= "   LEFT JOIN " + RetSQLName("SZ1") + " Z1             "
	cQuery+= "   ON(                                                "
	cQuery+= "        P0G.P0G_NOTA=Z1.Z1_DOC                        "
	cQuery+= "      )                                               "
	cQuery+= "   WHERE P0G_FILIAL= '" + xFilial(Self:cBanco) + "'   "
	cQuery+= "     AND P0G.D_E_L_E_T_ = ' '                         "
	cQuery+= "     AND P0G.P0G_DTENTR <> ' '                        "
	cQuery+= "     AND Z1.Z1_FILIAL= '" + xFilial(Self:cBanco) + "' "
	cQuery+= "     AND Z1.D_E_L_E_T_=' '                            "
	cQuery+= "     AND Z1.Z1_DTENTRE = ' '                          "
	cQuery+= "   GROUP BY P0G.P0G_FILIAL,                           "
	cQuery+= "            P0G.P0G_PEDIDO,                           "
	cQuery+= "            P0G.P0G_NOTA                              "
	cQuery+= ') "FINALIZADOS" 										'
	cQuery+= "ON(                                                   "
	cQuery+= "    VOLUMES.PEDIDO = FINALIZADOS.PEDIDO               "
	cQuery+= "    AND VOLUMES.NOTA = FINALIZADOS.NOTA               "
	cQuery+= ")										            	"

	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),cAliasNovo, .F., .T.)
	dbSelectArea(cAliasNovo)
 
	dbSelectArea("SZ1")
	dbSetOrder(2)
	
	While (cAliasNovo)->(!Eof()) 
	
 	IF  dbSeek((cAliasNovo)->FILIAL + (cAliasNovo)->PEDIDO)
 			
 			IF (cAliasNovo)->VOLUMES == (cAliasNovo)->FINALIZADOS
				RECLOCK("SZ1",.F.)
					SZ1->Z1_DTENTRE := SToD((cAliasNovo)->DATA)
					SZ1->Z1_STATUS  := 'B'
					SZ1->Z1_DTBAIXA := Date()
					
				MSUNLOCK() 
 			ENDIF
 	ENDIF
 	(cAliasNovo)->(DbSkip())
 EndDo
 
dbCloseArea(cAliasNovo)
dbCloseArea("SZ1")

Return


Method BuscaRastMotoBoy() Class ConsultaRastreios
	
	Local cQuery
	Local cAliasNovo
	Local cHmlPage
	Local oJson :={}
	Local lRetorno
	Local nCodTrans
	Local cLink
	
	nCodTrans := AllTrim(U_MyNewSx6("NCG_200005",'000149', 'C', 'Codigo da transportadora Rapido', '', '', .F. ))
	
	 cAliasNovo := GetNextAlias()
	 	cQuery:=  "SELECT Z1.Z1_DOC, Z1.Z1_PEDIDO FROM " + RetSQLName("SZ1") + " Z1 "
	 	cQuery+=  "LEFT JOIN " + RetSQLName("SF2") + " F2 "
	 	cQuery+=  "ON(Z1.Z1_DOC = F2.F2_DOC) "
	 	cQuery+=  "WHERE Z1.Z1_FILIAL= '" + xFilial("SZ1") + "' "
	 	cQuery+=  "AND Z1.Z1_DTENTRE = ' ' "
	 	cQuery+=  "AND Z1.Z1_DTEMISS>='20160101' "
	 	cQuery+=  "AND Z1.Z1_DTSAIDA <> ' ' "
	 	cQuery+=  "AND F2.F2_TRANSP='"+ nCodTrans +"' "
	 	cQuery+=  "AND Z1.Z1_DOC NOT IN (SELECT P0G_NOTA FROM " + RetSQLName(Self:cBanco) + ")"
	 	cQuery+=  "GROUP BY Z1.Z1_DOC, Z1.Z1_PEDIDO"	
	 	
	 cQuery := ChangeQuery(cQuery)
	 dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),cAliasNovo, .F., .T.)
	 dbSelectArea(cAliasNovo)
	 
	 dbSelectArea(Self:cBanco)
	 dbSetOrder(1)
	 
		While (cAliasNovo)->(!Eof()) 
		
		
			IF !dbSeek(xFilial(Self:cBanco)+(cAliasNovo)->Z1_PEDIDO+(cAliasNovo)->Z1_DOC)
			
		
				cLink := Self:cLinkMoto + AllTrim((cAliasNovo)->Z1_PEDIDO) + "?api_key=" + Self:cTokemMoto + "&live_mode=true"	
				cHtmlPage := Httpget(cLink)
				If lRetorno:= FWJsonDeserialize(cHtmlPage,@oJson)
			
				If ValType(oJson)!="O"
					If Len(oJson)!=0 
						If AllTrim((cAliasNovo)->Z1_PEDIDO) == oJson[1]:Id .And. oJson[1]:trackingId != "null"	.And. oJson[1]:trackingId != Nil 
														
							RECLOCK(Self:cBanco,.T.)
								P0G->P0G_FILIAL 		:= xFilial(Self:cBanco)
								P0G->P0G_PEDIDO 		:= AllTrim((cAliasNovo)->Z1_PEDIDO)
								P0G->P0G_NOTA			:= AllTrim((cAliasNovo)->Z1_DOC)
								P0G->P0G_RAST 			:= oJson[1]:trackingId
							MSUNLOCK() 
							
							If oJson[1]:DELIVERED != "null" .And. oJson[1]:DELIVERED != Nil .And. oJson[1]:Status == "COMPLETED"
								
								aData:= StrTokArr(oJson[1]:DELIVERED," ")
							
								RECLOCK(Self:cBanco,.F.)
									P0G->P0G_STATUS 		:= oJson[1]:Status
									P0G->P0G_DATA 			:= CToD(aData[1])
								MSUNLOCK() 
								
							EndIf
						EndIf
				EndIf
				//Next
				
				EndIf	
			Endif	
		EndIf	
			cLink = Nil
			(cAliasNovo)->(DbSkip())
		EndDo
			

	dbCloseArea(cAliasNovo)
	dbCloseArea(Self:cBanco)
	 
Return


Method ConsultaRastMoto() Class ConsultaRastreios

	Local cQuery
	Local cAliasNovo
	Local cHmlPage
	Local oJson :={}
	Local lRetorno
	Local cLink
	
	cAliasNovo := GetNextAlias()
	
	
		cQuery :=	"SELECT P0G_PEDIDO, P0G_NOTA, P0G_RAST FROM " + RetSQLName(Self:cBanco) + " "
		cQuery +=	"WHERE P0G_FILIAL = '" + xFilial(Self:cBanco)+"'"
		cQuery +=	"AND P0G_DTENTR = ' ' "
		cQuery +=	"AND D_E_L_E_T_=' ' "
		cQuery +=	"AND LENGTH(TRIM(P0G_RAST))<13"
	
	 cQuery := ChangeQuery(cQuery)
	 dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),cAliasNovo, .F., .T.)
	 dbSelectArea(cAliasNovo)
	 
	 dbSelectArea(Self:cBanco)
	 dbSetOrder(1)
	 
	While (cAliasNovo)->(!Eof())
	 
		IF dbSeek(xFilial(Self:cBanco)+(cAliasNovo)->P0G_PEDIDO+(cAliasNovo)->P0G_NOTA+(cAliasNovo)->P0G_RAST)
			cLink := Self:cLinkMoto + AllTrim((cAliasNovo)->P0G_PEDIDO) + "?api_key=" + Self:cTokemMoto + "&live_mode=true"	
			cHtmlPage := Httpget(cLink)
			If lRetorno:= FWJsonDeserialize(cHtmlPage,@oJson)
			
					If Len(oJson)!=0
						If AllTrim((cAliasNovo)->P0G_PEDIDO) == oJson[1]:Id .And. AllTrim((cAliasNovo)->P0G_RAST) == oJson[1]:trackingId .And. oJson[1]:DELIVERED != "null" .And. oJson[1]:DELIVERED != Nil .And. oJson[1]:Status == "COMPLETED"
							
							aData:= StrTokArr(oJson[1]:DELIVERED," ")
							
								RECLOCK(Self:cBanco,.F.)
									P0G->P0G_STATUS 		:= oJson[1]:Status
									P0G->P0G_DTENTR 		:= CToD(aData[1])
								MSUNLOCK()
						EndIf
					EndIf
			EndIf	
	 	EndIf
	 	cLink = Nil
	 	(cAliasNovo)->(DbSkip())
	EndDo
	dbCloseArea(cAliasNovo)
	dbCloseArea(Self:cBanco)
Return
