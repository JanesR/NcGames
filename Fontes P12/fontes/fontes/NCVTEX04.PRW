#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX04  ºAutor  ³Microsiga           º Data ³  03/24/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function XVTEX04JOB(aDados)
Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2])

U_NCVTEX04()

Return   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX04  ºAutor  ³Microsiga           º Data ³  04/29/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function VTEX04MNU()

Local cMsgYes := "Deseja executar a rotina de Exportação de tabela de preço?"

If MsgYesno(cMsgYes)
	Processa( {|| U_NCVTEX04()},"Aguarde...","Exportando tabela de preço NcGames_B2B...",.F.)
EndIf                                                                 

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX01  ºAutor  ³Microsiga           º Data ³  02/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function XNCVTEX04(cLojaCli,cCodProd)

Local aAreaAtu	:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQuery	:= ""

Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","Cód. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","Cód. de loja NcGames utilizado no VTex","","",.F. ))
Local aPost		:= {"",""}

Local dData		:= MsDate()
Local cTabelCon	:= Alltrim(U_MyNewSX6("VT_000010","058" ,"C","Codigo Tabela de Preco Consumidor","","",.F. ))
Local cValidade	:= "2015-07-15T00:00:00.000"//StrZero(Year(dData),4)+"-"+StrZero(Month(dData),2)+"-"+StrZero(Day(dData),2)+" T00:00:00.000"
Local nContar	:= 0
Local bSeek		:= {|| ZC4->(MsSeek(xFilial("ZC4")+cTabelCon)) }
Local bWhile	:= {|| ZC4->(ZC4_FILIAL+ZC4_CODTAB)== xFilial("ZC4")+cTabelCon}
Local cPost		:= ""

Local cPrcDe	:= ""
Local cPrcPor	:= ""
Local cSalesCh	:= Alltrim(U_MyNewSX6("VT_NCG0014","2","C","Codigo Tabela de Preco Consumidor","","",.F. ))//"2"//trocar para 2 - Ecommerce B2C

Local oSite
Local nHDL
Local nLin


Default cCodProd:=""

oSite:= ApiVtex():New("NcGames")
oSite:cUrl	:= "/api/pricing/pvt/price-sheet"


If !Semaforo(.T.,@nHDL,"NCVTEX04")
	Return()
EndIf

If !Empty(cCodProd)
	bSeek := {|| ZC4->(DbSeek(xFilial("ZC4")+cTabelCon+cCodProd)) }
	bWhile:={|| ZC4->(ZC4_FILIAL+ZC4_CODTAB+ZC4_CODPRO)== xFilial("ZC4")+cTabelCon+cCodProd }
EndIf


SA1->(DbSetOrder(1))
If !SA1->(MsSeek(xFilial("SA1")+cCliNc+cLojaNc ))
	Conount("Cliente não encontrado.")
	Return .F.
EndIf

ZC4->(DbSetOrder(2))//ZC4_FILIAL+ZC4_CODTAB+ZC4_CODPRO
If !Eval(bSeek)
	Conount("Tabela de preço não encontrada.")
	Return .F.
EndIf

Do While ZC4->(!Eof()) .And. ZC4->(Eval(bWhile))
	
	
	If ZC4->ZC4_PRCCIA == 0
		ZC4->(DbSkip());Loop
	EndIf
	
	cCodProCli:=AllTrim(U_VTEX01PROD( ZC4->ZC4_CODPRO,.F.))
	
	If !Empty(cCodProCli)
		cPrcDe	:= AllTrim( Str( IIf(ZC4->ZC4_CIAOFE==0,ZC4->ZC4_PRCCIA,ZC4->ZC4_CIAOFE) ))
		cPrcPor:= AllTrim( Str( ZC4->ZC4_PRCCIA ))
		
		aSalesCh := Separa(cSalesCh,";")
		
		For nLin:=1 to Len(aSalesCh)
			cPost	+= '{ "itemId": '+ cCodProCli +',"price":'+ cPrcPor +',"salesChannel": '+ aSalesCh[nLin] +',"listPrice":'+ cPrcDe +', "validFrom": "'+ cValidade +'", "validTo": "2113-12-31T00:00:00.000"  },'
			If ++nContar>=1000
				If !Empty(cPost)
					cPost		:= "["+Left( cPost,Len(cPost)-1)+"]"
					oSite:cBody	:= cPost
					oSite:HttpPost()
					oSite:cBody	:= ""
					nContar		:= 0
					cPost		:= ""
				EndIf
			EndIf
		Next
	EndIf
	
	
	ZC4->(DbSkip())
	If ++nContar>=1000 .Or. ZC4->(Eof())
		If !Empty(cPost)
			cPost		:= "["+Left( cPost,Len(cPost)-1)+"]"
			oSite:cBody	:= cPost
			oSite:HttpPost()
			oSite:cBody	:= ""
			nContar		:= 0
			cPost		:= ""
		EndIf
	EndIf
EndDo

If !Empty(cPost)
	cPost			:= "["+Left( cPost,Len(cPost)-1)+"]"
	oSite:cBody	:= cPost
	oSite:HttpPost()
EndIf

oSite	:=Nil

Semaforo(.F.,nHDL,"NCVTEX04")
RestArea(aAreaAtu)
Return .T.

/*          
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX04  ºAutor  ³Microsiga           º Data ³  03/20/15   º±±
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
