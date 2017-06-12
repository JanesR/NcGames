#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NCPrefFn	ºAutor  ³Elton C.			 º Data ³  05/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para preencher o prefixo dos titulos       º±±
±±º          ³a serem gerados no financeiro. Obs. Tratamento no caso de   º±±
±±º          ³Exportação												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCPrefFn()

Local aArea 	:= GetArea()
Local aAliasSC5 := SC5->(GetArea())
Local aAliasSD2 := SD2->(GetArea())
Local cRet		:= SF2->F2_SERIE
Local cPrefExp 	:= U_MyNewSX6(	"NC_PREFEXP", "EXP", "C", "Prefixo para clientes de exportação","Prefixo para clientes de exportação","Prefixo para clientes de exportação",.F. )
Local cPrefiWeb := Alltrim(U_MyNewSX6(	"EC_NCG0020", "ECO", "C", "Prefixo para pedidos de Ecommerce","","",.F. ))
Local cPrefCard	:= "CC" //Rubens liberou a digitação direta por se tratar de pedidos com pagto atraves do cartão de credito.

Local cPreUZgames	:= U_MyNewSX6(	"VT_NCG0002", "EUZ", "C", "Prefixo que será utilizado nos pedidos Ecommerce UZ","","",.F.) //Prefixo dos titulos Ecommerce Uz Games
Local cPrePGames	:=	U_MyNewSX6(	"VT_NCG0003", "EPG", "C", "Prefixo que será utilizado nos pedidos Ecommerce Proximo Games","","",.F.)//Prefixo dos titulos Ecommerce Proximo Grames
Local cPreMarket	:= U_MyNewSX6(	"VT_NCG0004", "EMP", "C", "Prefixo que será utilizado nos pedidos Ecommerce MarketPlace","","",.F.)//Prefixo dos titulos Ecommerce Marketplace


If SF2->F2_TIPO == "N"//Verifica se o pedido é normal
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	If SA1->(DbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA ))
		
		//Verifica se o cliente é de exportação
		If upper(Alltrim(SA1->A1_TIPO)) == "X"
			cRet := cPrefExp
		Else
			cRet := SF2->F2_SERIE
		EndIf
		
	Else
		cRet := SF2->F2_SERIE
	EndIf
	
	SD2->(DbSetOrder(3)) //D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA
	SC5->(DbSetOrder(1)) //C5_FILIAL+C5_NUM
	If SD2->(MsSeek(xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)))
		If SC5->(MsSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			If SC5->C5_XECOMER=="C"
				cRet := cPrefiWeb
				If  SC5->C5_CONDPAG == cPreUZgames
					cRet :=cPreUZgames
				ElseIf  SC5->C5_CONDPAG == cPrePGames
					cRet :=cPrePGames
				ElseIf  SC5->C5_CONDPAG == cPreMarket
					cRet :=cPreMarket
				EndIf
			ElseIf SC5->C5_CONDPAG == "618" //condição de pagamento: Avista Cartão de Crédito
				cRet := cPrefCard
			EndIf
		EndIf
	EndIf
	
	
Else
	cRet := SF2->F2_SERIE
Endif


RestArea(aAliasSC5)
RestArea(aAliasSD2)
RestArea(aArea)
Return cRet