#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"

#Define Enter Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCTABSITE  ºAutor  ³Microsiga          º Data ³  10/11/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                                       
User Function RL208Job(aDados)

Default aDados:={"01","03"} 

RpcSetEnv(aDados[1],aDados[2])

u_NCGRL208()

Return               

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCTABSITE ºAutor  ³Lucas Felipe        º Data ³  09/30/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCGRL208()

Local aAreaAtu	:= GetArea()
Local aAreaSB5	:= SB5->(GetArea())
Local aAliasSql	:= GetNextAlias()

Local cPara		:= Alltrim(U_MyNewSX6("NCG_000086","lfelipe@ncgames.com.br","C","E-mail para envio de arquivo de estoque e preços Gazin","","",.F. ))
Local cAssunto  := "Estoque"+DtoC(MsDate())
Local cBody     := "Email gerado automaticamente"
Local cAttach   := ""

Local lAuto		:= IsInCallStack("U_RL208Job")
Local cUsrEmail	:= UsrRetMail(AllTrim(RetCodUsr(Substr(cUsuario,1,6))))

Local nTotLinhas:= 0
Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Local cArq 		:= "est_"+DtoS(MsDate())
Local cExtExcel	:= ".CSV"
Local nArq

Local cCabec	:= "Codigo;CodBar;Descrição;SP;NO_NE_CO;SUL_SUD;CONSUMIDO;QNT_DISPONIVEL"

Local cSql		:= ""

Local cProd		:= ""
Local cCodBar	:= ""
Local cDesc		:= ""
Local cPrc018	:= ""
Local cPrc107	:= ""
Local cPrc112	:= ""
Local cPrcCon	:= ""
Local cEstDisp	:= ""


nArq  := FCreate(cPathArq + cArq + cExtExcel)
FWrite(nArq, cCabec + Enter)


cSql +=	"	SELECT SB1.B1_COD "+CRLF
cSql +=	"	 		,SB1.B1_CODBAR "+CRLF
cSql +=	" 			,SB1.B1_XDESC "+CRLF
cSql +=	" 			,nvl(DA1SP.DA1_PRCVEN,0) AS SP "+CRLF
cSql +=	" 			,nvl(DA1NO.DA1_PRCVEN,0) AS NO_NE_CO "+CRLF
cSql +=	" 			,nvl(DA1SU.DA1_PRCVEN,0) AS SUL_SUD "+CRLF
cSql +=	" 			,SB1.B1_CONSUMI CONSU "+CRLF
cSql +=	" 			,SB2.B2_QATU - SB2.B2_RESERVA DISPONIVEL "+CRLF
cSql +=	"	FROM "+RetSqlName("SB1")+" SB1 "+CRLF

cSql +=	"	INNER JOIN "+RetSqlName("DA1")+" DA1SP "+CRLF
cSql +=	"	ON DA1SP.DA1_FILIAL = '"+xFilial("DA1")+"' "+CRLF
cSql +=	"	AND DA1SP.D_E_L_E_T_ = ' ' "+CRLF
cSql +=	"	AND DA1SP.DA1_CODTAB = '018' "+CRLF
cSql +=	"	AND DA1SP.DA1_CODPRO = SB1.B1_COD "+CRLF
cSql +=	"	AND DA1SP.DA1_ATIVO = '1' "+CRLF
cSql +=	"	AND DA1SP.DA1_PRCVEN > 0 "+CRLF

cSql +=	"	LEFT OUTER JOIN "+RetSqlName("DA1")+" DA1NO "+CRLF
cSql +=	"	ON DA1NO.DA1_FILIAL = '"+xFilial("DA1")+"' "+CRLF
cSql +=	"	AND DA1NO.D_E_L_E_T_ = ' ' "+CRLF
cSql +=	"	AND DA1NO.DA1_CODTAB = '107' "+CRLF
cSql +=	"	AND DA1NO.DA1_CODPRO = SB1.B1_COD "+CRLF
cSql +=	"	AND DA1NO.DA1_PRCVEN > 0 "+CRLF
cSql +=	"	AND DA1NO.DA1_ATIVO = '1' "+CRLF

cSql +=	"	LEFT OUTER JOIN "+RetSqlName("DA1")+" DA1SU "+CRLF
cSql +=	"	ON DA1SU.DA1_FILIAL = '"+xFilial("DA1")+"' "+CRLF
cSql +=	"	AND DA1SU.D_E_L_E_T_ = ' ' "+CRLF
cSql +=	"	AND DA1SU.DA1_CODTAB = '112' "+CRLF
cSql +=	"	AND DA1SU.DA1_CODPRO = SB1.B1_COD "+CRLF
cSql +=	"	AND DA1SU.DA1_ATIVO = '1' "+CRLF

cSql +=	"	INNER JOIN "+RetSqlName("SB2")+" SB2 "+CRLF
cSql +=	"	ON SB2.B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
cSql +=	"	AND SB2.B2_LOCAL = '01' "+CRLF
cSql +=	"	AND SB2.B2_COD = SB1.B1_COD "+CRLF

cSql +=	"	WHERE SB1.B1_FILIAL = '"+xFilial("SB1")+"'  "+CRLF
cSql +=	"		AND SB1.D_E_L_E_T_ = ' ' "+CRLF
cSql +=	"		AND SB1.B1_MSBLQL = '2' "+CRLF 	//Inativo := 1=Sim;2=Não
cSql +=	"		AND SB1.B1_BLQVEND = '2'  "+CRLF //Blq. Venda := 1=Sim;2=Não
cSql +=	"		AND SB1.B1_TIPO = 'PA' "+CRLF
cSql +=	"		AND SB1.B1_POSIPI NOT IN ('99999999') "+CRLF
cSql +=	"	GROUP BY B1_XDESC, "+CRLF
cSql +=	" 	B1_CODBAR, "+CRLF
cSql +=	" 	B1_COD, "+CRLF
cSql +=	" 	DA1SP.DA1_PRCVEN, "+CRLF
cSql +=	" 	DA1NO.DA1_PRCVEN, "+CRLF
cSql +=	" 	DA1SU.DA1_PRCVEN, "+CRLF
cSql +=	" 	B1_CONSUMI, "+CRLF
cSql +=	" 	SB2.B2_QATU-SB2.B2_RESERVA "+CRLF

cSql := ChangeQuery(cSql)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),aAliasSql, .F., .F.)

SB5->(DbSetOrder(1))

Do While (aAliasSql)->(!EOF())
	
	If SB5->(MsSeek(xFilial("SB5")+(aAliasSql)->B1_COD))
		If SB5->B5_YFRANCH == "S"
			(aAliasSql)->(DbSkip());Loop
		EndIf
	EndIf
	
	++ nTotLinhas
	
	cProd 		:= (aAliasSql)->B1_COD
	cCodBar		:= (aAliasSql)->B1_CODBAR
	cDesc		:= (aAliasSql)->B1_XDESC
	
	cPrc018		:= Transform((aAliasSql)->SP,"@E 999,999,999.99")
	cPrc107		:= Transform((aAliasSql)->NO_NE_CO,"@E 999,999,999.99")
	cPrc112		:= Transform((aAliasSql)->SUL_SUD,"@E 999,999,999.99")
	cPrcCon		:= Transform((aAliasSql)->CONSU,"@E 999,999,999.99")
	cEstDisp	:= Transform((aAliasSql)->DISPONIVEL, "@E 999,999,999")
	
	FWrite( nArq,cProd +";"+ cCodBar +";"+ cDesc +";"+ cPrc018 +";"+cPrc107 +";"+ cPrc112 +";"+ cPrcCon +";"+ cEstDisp + Enter)
	
	(aAliasSql)->(dbSKIP())
	
EndDo

FClose(nArq)
(aAliasSql)->(DbCloseArea())

cAttach:=cPathArq + cArq + cExtExcel

If lAuto
	U_RlSendCsv(,cPara,cAssunto,cBody,cAttach)
Else
	U_RlSendCsv(,cUsrEmail,cAssunto,cBody,cAttach)
EndIf

Ferase(cAttach)


RestArea(aAreaSB5)
RestArea(aAreaAtu)

Return
