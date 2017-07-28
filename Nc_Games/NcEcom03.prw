#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "XMLXFUN.CH"
#INCLUDE "TBICONN.CH"

#Define Enter Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM03  ºAutor  ³Microsiga           º Data ³  03/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ecom03Job(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

U_NcEcom03()

RpcClearEnv()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NcEcom03  ºAutor  ³Octavio A. Estevam  º Data ³  09/12/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Integração Protheus x CiaShop                              º±±
±±º          ³ Atualiza o estoque na ferramenta Ciashop                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NcEcom03()

Local aArea 	:= GetArea()
Local oobj		:= nil
Local oXml		:= nil
Local _cxml		:= ""
Local _cxmltab	:= ""
Local cError  	:= ""
Local cWarning	:= ""
Local _cQuery	:= ""
Local nHDL
Local _aXml		:= {}
Local _aXmlTab	:= {}
Local _nCont	:= 0
Local cWSUser	:= Alltrim(U_MyNewSX6("EC_NCG0010","wsncgames","C","Usuário com acesso a Integração(WS)","","",.F. )   )
Local cWSPass	:= Alltrim(U_MyNewSX6("EC_NCG0011","apeei.1453","C","Senha do Usuário com acesso a Integração(WS)","","",.F. )   )
Local cArmPad	:= SuperGetMv("MV_CIAESTO",,"01")                                                           

Local nEstSeg	:= U_MyNewSX6("EC_NCG0028","8","N","Estoque de segurança para integração de estoque B2B","","",.F. )
Local nArq

If !Semaforo(.T.,@nHDL,"NCECOM03")
	Return()
EndIf

_cQuery := ""
_cQuery += " SELECT SB1.B1_COD, "+CRLF
_cQuery += " 		ZC3.ZC3_STATUS, "+CRLF
_cQuery += " 		SB1.B1_PRV1, "+CRLF
_cQuery += " 		SB1.B1_CONSUMI, "+CRLF
_cQuery += " 		SB1.B1_BLQVEND, "+CRLF
_cQuery += " 		SB1.B1_MSBLQL, "+CRLF
_cQuery += " 		NVL(B2_QATU-B2_RESERVA,0) AS SALDO,  "+CRLF
_cQuery += " 		SB2.B2_LOCAL  "+CRLF
_cQuery += " FROM "+RetSqlName("ZC3")+" ZC3 "+CRLF
_cQuery += " 		LEFT OUTER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
_cQuery += " 		ON SB1.B1_COD = ZC3.ZC3_CODPRO "+CRLF
_cQuery += " 		AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
_cQuery += "	 	AND SB1.D_E_L_E_T_ = ' ' "+CRLF
_cQuery += " 	LEFT OUTER JOIN "+RetSqlName("SB2")+" SB2 "+CRLF
_cQuery += " 		ON SB2.B2_COD = ZC3.ZC3_CODPRO "+CRLF
_cQuery += " 		AND SB2.B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
_cQuery += " 		AND SB2.B2_LOCAL IN "+ FormatIn(cArmPad,';') +" "+CRLF
_cQuery += " 		AND SB2.D_E_L_E_T_ = ' ' "+CRLF
_cQuery += " WHERE ZC3.D_E_L_E_T_ = ' ' "+CRLF
_cQuery += " AND ZC3.ZC3_STATUS IN ('01','03') "+CRLF
_cQuery += " and sb2.b2_local is not null "+CRLF

_cQuery := ChangeQuery(_cQuery)

dbUseArea(.T., "TOPCONN", TCGenQry(,,_cQuery), 'TRBEST', .T., .F.)

DbSelectArea("TRBEST")
DbGoTop()
TRBEST->(DbGoTop())

If !TRBEST->(EoF())
	
	Do While !TRBEST->(EoF())
		If _nCont==1000
			_nCont:=0
			Aadd(_aXml,_cxml)
			Aadd(_aXmlTab,_cxmltab)
			_cXml:=""
		Endif
		
		If (TRBEST->B1_CONSUMI) > 0
			cPrcConsumi := Str(100*((TRBEST->B1_CONSUMI)+((TRBEST->B1_CONSUMI)*0.05)),9)
			cPrcCons	:= Str(100*((TRBEST->B1_CONSUMI)),9)
		Else //Sem preço de consumidor cadastrado.
			cPrcCons	:= "99989"
			cPrcConsumi	:= "99990"
		EndIf
		
		cEstAtu := "0"
		If (TRBEST->SALDO) > 0 .And. (TRBEST->SALDO - nEstSeg) > 0
			cEstAtu := Alltrim(Str(TRBEST->SALDO))
		EndIf
		
		IF (TRBEST->ZC3_STATUS) == "02"  //Se o Produto estiver como 02(não vai para Site)
			cEstAtu := "0"
		ElseIf(TRBEST->B1_BLQVEND) == "1" .Or. (TRBEST->B1_MSBLQL) == "1" //ele atualiza o estoque para 0
			cEstAtu := "0"
		EndIf
		
		_cxml+='<update_stock xmlns="" sku="'+ALLTRIM(TRBEST->B1_COD)+'" estoque="'+ cEstAtu+'" armazem = "'+ALLTRIM(cEmpAnt + cFilAnt +  TRBEST->B2_LOCAL) +'" sale_start="2012-01-01" sale_end="2012-02-01" />'
	

		TRBEST->(DbSkip())
		_nCont++
		
	EndDo
	
	If !Empty(Alltrim(_cxml))
		Aadd(_aXml,_cxml)
	Endif
	If !Empty(Alltrim(_cxmltab))
		Aadd(_aXmlTab,_cxmltab)
	Endif
	
	For i:=1 to Len(_aXml)
		
		_cxml:='<?xml version="1.0" encoding="utf-8" standalone="no" ?><update_stockList xmlns="dsReceipt.xsd">'
		_cxml+=_aXml[i]
		_cxml+='</update_stockList >'
		
		oobj:=NC_WSWSIntegracao():new()
		
		
		oobj:AtualizaEstoque(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),_cxml)
		
		//chama o metodo do portal
		If oobj:lAtualizaEstoqueResult
			
			//transforma o xml do resultado em objeto
			oXml := XmlParser( oobj:cxml, "_", @cError, @cWarning )
			
			//recupera o conteudo dentro do objeto xml
			//U_NcEcoLog("NcEcom03()",oxml:_result:_resulttext:text)
			
			If oobj:lAtualizaEstoqueResult
				U_COM09CAD("ESTOQUE","ESTOQUE","UPDATE","Atualização do Estoque realizada com sucesso.","","")
				TRBEST->(DbGoTop())
				SB1->(DbSetOrder(1))
				Do While !TRBEST->(EoF())
					If SB1->(DbSeek(xFilial("SB1")+TRBEST->B1_COD))
						Reclock("SB1",.F.)
						SB1->B1_ZSALCIA:=TRBEST->SALDO
						SB1->(MsUnlock())
					Endif
					TRBEST->(DbSkip())
				EndDo
			Endif
		Else
			U_COM09CAD("ESTOQUE","ESTOQUE","UPDATE","",GetWSCError(),"")
		Endif
	Next i
	
Else
	//U_NcEcoLog("NcEcom03()","Não há saldos a serem exportados!")
Endif
TRBEST->(DbCloseArea())


Semaforo(.F.,nHDL,"NCECOM03")

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM03  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Semaforo(lTipo,nHdl,cArq)

Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+".LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM03  ºAutor  ³Microsiga           º Data ³  04/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NcE03Proc()

Local cMsgYes := "A Rotina de Atualização de estoque pode demorar alguns minutos. Deseja Prosseguir?"

If MsgYesno(cMsgYes)
	Processa( { ||U_NcEcom03()}, "Aguarde...", "Processando atualização...",.F.)
Else
	Return
EndIf

Return

User Function sndPrdUnic(cCodProd, cLocal)

Local aArea := GetArea()
Local cArmPad
Local oApiSite
Local cBody := ""

If Empty(cCodProd)
	Return
EndIf

If !Empty(alltrim(cCodProd)) .And. !Empty( alltrim(cLocal) )
	
	DbSelectArea("SB2")
	DbSetOrder(1)
	If MsSeek( xFilial("SB2") + Padr(cCodProd, AvSx3("B2_COD",3) ) + cLocal)
		
		cArmPad := cEmpAnt + xFilial("SB2") + cLocal
		oApiSite := ApiCiaShop():New()
		cBody := '{ "quantity": '+ alltrim(Str(SB2->B2_QATU - SB2->B2_RESERVA))  +' }'	
		oApiSite:cUrl := "variants/"+ cCodProd +"/warehouses/"+ cArmPad +"/inventory"
		oApiSite:cBody := EnCodeUtf8(cBody)
		oApiSite:HttpPost()

		If At("errors",oApiSite:cResponse)>0
			cMensagem:="Erro no envio do estoque!"
			MsgInfo(cMensagem)
		Else
			cMensagem := "Envio de estoque finalizado!"
			MsgInfo(cMensagem)
		EndIf
	EndIf
	DbCloseArea("SB2")
EndIf
RestArea(aArea)
Return