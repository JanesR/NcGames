#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX03  ºAutor  ³Microsiga           º Data ³  03/24/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VTEX03JOB(aDados)
Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2])
U_NCVTEX03()

RpcClearEnv()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX03  ºAutor  ³Microsiga           º Data ³  04/29/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VTEX03MNU()

Local cMsgYes := "Deseja executar a rotina de Exportação de Estoque?"

If MsgYesno(cMsgYes)
	Processa( {|| U_NCVTEX03()},"Aguarde...","Exportando Estoque...",.F.)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX03  ºAutor  ³Microsiga           º Data ³  02/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Fonte de Integração de Estoque Protheus X Vtex             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCVTEX03(cCodProd,cOrigem)

Local aAreaAtu	:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQuery	:= ""
Local oSiteNc	:= ApiVtex():New("NcGames")
Local nHDL
Local nContar
Local cLojaB2B	:= Alltrim(U_MyNewSX6("VT_NCG0008","1_1","C","Armazem de Venda Vtex B2B","","",.F. ))
Local cLojaB2C	:= Alltrim(U_MyNewSX6("VT_NCG0009","2_1","C","Armazem de Venda Vtex B2C","","",.F. )) 	 //Deverá ser repensado
Local cLocalERP	:= Alltrim(U_MyNewSX6("VT_000005","51" ,"C","Armazem de Venda Protheus Vtex","","",.F. ))//Deverá ser repensado
Local cAtualiza	:= Alltrim(U_MyNewSX6("VT_NCG0007","S"	,"C","Atualiza estoque Site","","",.F. ))
Local aPost		:= {"",""}

Default cCodProd:= ""
Default cOrigem	:= FunName(0)

If !Semaforo(.T.,@nHDL,"NCVTEX03")
	Return()
EndIf

//oSiteNc:cUrl	:="api/logistics/pvt/inventory/warehouseitems/setbalance" //alterado pois este link retorna 500
oSiteNc:cUrl	:="api/logistics/pvt/inventory/warehouseitembalances"


cQuery+=" SELECT SB1.B1_COD, "+CRLF
cQuery+=" 		ZC3.ZC3_STATUS, "+CRLF
cQuery+=" 		SB1.B1_PRV1, "+CRLF
cQuery+=" 		SB1.B1_CONSUMI, "+CRLF
cQuery+=" 		SB1.B1_BLQVEND, "+CRLF
cQuery+=" 		SB1.B1_MSBLQL, "+CRLF
cQuery+=" 		SB2.B2_LOCAL, "+CRLF
cQuery+=" 		SB5.B5_YPREVEN, "+CRLF
cQuery+=" 		NVL(B2_QATU-B2_RESERVA-B2_QEMP,0) AS SALDO  "+CRLF
cQuery+=" FROM "+RetSqlName("ZC3")+" ZC3 "+CRLF
cQuery+=" 		LEFT OUTER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery+=" 		ON SB1.B1_COD = ZC3.ZC3_CODPRO "+CRLF
cQuery+=" 		AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery+="	 	AND SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery+=" 	LEFT OUTER JOIN "+RetSqlName("SB2")+" SB2 "+CRLF
cQuery+=" 		ON SB2.B2_COD = ZC3.ZC3_CODPRO "+CRLF
cQuery+=" 		AND SB2.B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
cQuery+=" 		AND SB2.B2_LOCAL IN ('"+ cLocalERP +"') "+CRLF
cQuery+=" 		AND SB2.D_E_L_E_T_ = ' ' "+CRLF
cQuery+=" 	LEFT OUTER JOIN "+RetSqlName("SB5")+" SB5 "+CRLF
cQuery+=" 		ON SB5.D_E_L_E_T_ = ' ' "+CRLF
cQuery+=" 		AND SB5.B5_FILIAL = '"+xFilial("SB5")+"' "+CRLF
cQuery+=" 		AND ZC3.ZC3_CODPRO = SB5.B5_COD  "+CRLF
cQuery+=" WHERE ZC3.D_E_L_E_T_ = ' '  and b2_local is not null and ZC3.ZC3_STATUS !='04'"+CRLF

If !Empty(cCodProd)
	cQuery+=" AND B1_COD In "+FormatIn(cCodProd,";")+CRLF
EndIf

If cAtualiza=="N"
	cQuery+=" AND 1=2" // Forco comparacao falsa
EndIf

cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .T., .F.)

nContar:=0

Do While !(cAliasQry)->(Eof())
	
	If !((cAliasQry)->B5_YPREVEN=="S")
		aCodProd:={ U_VTEX01PROD((cAliasQry)->B1_COD,.F.)}
		
		If (cAliasQry)->B2_LOCAL == cLocalERP
			For nInd:=1 To Len(aCodProd)
				If !Empty(aCodProd[nInd])
					aPost[nInd]+='{"wareHouseId":"'+cLojaB2C+'","itemId":"'+AllTrim(aCodProd[nInd])+'","quantity":'+AllTrim( Str( (cAliasQry)->SALDO ))+'},'
				EndIf
			Next
		Else
			For nInd:=1 To Len(aCodProd)
				If !Empty(aCodProd[nInd])
					aPost[nInd]+='{"wareHouseId":"'+cLojaB2B+'","itemId":"'+AllTrim(aCodProd[nInd])+'","quantity":'+AllTrim( Str( (cAliasQry)->SALDO ))+'},'
				EndIf
			Next
		EndIf
	EndIf
	
	(cAliasQry)->(DbSkip())
	
	//If ++nContar>=1000 .Or. (cAliasQry)->(Eof())
	If ++nContar>=1 .Or. (cAliasQry)->(Eof())
		If !Empty(aPost[1])
			aPost[1] := "["+Left( aPost[1],Len(aPost[1])-1)+"]"
			oSiteNc:cBody := aPost[1]
			oSiteNc:HttpPost()
			sleep(1000)
		EndIf
		
		nContar		:= 0
		aPost			:= {"",""}
		oSiteNc:cBody	:= ""
		
	EndIf
EndDo

If !Empty(aPost[1])
	aPost[1]	:="["+Left( aPost[1],Len(aPost[1])-1)+"]"
	oSiteNc:cBody:=aPost[1]
	oSiteNc:HttpPost()
EndIf

oSiteNc:=Nil

Semaforo(.F.,nHDL,"NCVTEX03")

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX03  ºAutor  ³Microsiga           º Data ³  03/20/15   º±±
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
