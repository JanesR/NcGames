#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"

//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGames
//|Funcao....: U_FA050S
//|Autor.....: Norival Júnior
//|Data......: 12 de Agosto de 2013
//|Uso.......: SIGAEIC
//|Versao....: Protheus - 11
//|Descricao.: Função para preenchimento automático na integração com o Despachante
//					Onde o programa preenche o Contas a Pagar.
//|Observação:
//------------------------------------------------------------------------------------// 


User Function ProxParc(cFil,cPrefixo,cNum,cTipo,cFornec,cLoja)

Local aArea   	:= GetArea()
Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local cParc		:= ""
Local nParc		:= ""


cQry	:= " SELECT MAX(E2_PARCELA) ULTPARC FROM SE2010 WHERE D_E_L_E_T_ = ' '
cQry	+= " AND E2_FILIAL = '"+cFil+"'
cQry	+= " AND E2_PREFIXO = '"+cPrefixo+"'
cQry	+= " AND E2_NUM = '"+cNum+"'
cQry	+= " AND E2_TIPO = '"+cTipo+"'
//cQry	+= " AND E2_FORNECE = '"+cFornec+"'
//cQry	+= " AND E2_LOJA = '"+cLoja+"'

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias  ,.F.,.T.)

nParc	:= val(RetAsc((cAlias)->ULTPARC,1,.F.))+1
cParc	:= RetAsc(alltrim(str(nParc)),1,.T.)

(cAlias)->(dbCloseArea())

RestArea(aArea)

Return(cParc)

*--------------------*
User Function FA050S
*--------------------*

Local aArea   	:= GetArea()
Local cDespesa 	:= SWD->WD_DESPESA
Local cNum 			:= SWD->WD_HAWB
Local cFornec 		:= SYB->YB_FORN
Local cLoja			:= SYB->YB_LJFORN
Local cNom			:= SYB->YB_DESFORN
Local cParcela  	:= SE2->E2_PARCELA
Local cPrefixo		:= "EIC"
Local cTipo			:= "NF"
Local cNaturez		:= criavar("E2_NATUREZ")

M->E2_PREFIXO := cPrefixo
M->E2_NUM    := substr(cNum,1,9)
M->E2_TIPO   :=  cTipo
If SYB->(FieldPos("YB_YNATDSP")) # 0
	cNaturez	:= SYB->YB_YNATDSP
Else
	cNaturez	:= criavar("E2_NATUREZ")
EndIf

M->E2_NATUREZ 	:= cNaturez
M->E2_FORNECE 	:= cFornec				//"UNIAO"
M->E2_NOMFOR 	:= cNom					//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_NOMFOR")
M->E2_LOJA 		:= cLoja					//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_LOJA") //"03"

DO CASE
	CASE alltrim(cDespesa) $ "201/202/203/204/205/415"
		M->E2_NATUREZ 	:= cNaturez
		M->E2_FORNECE 	:= cFornec				//"UNIAO"
		M->E2_NOMFOR 	:= cNom					//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_NOMFOR")
		M->E2_LOJA 		:= cLoja					//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_LOJA") //"03"
		cParcela	:= u_ProxParc(xFilial("SE2"),cPrefixo,alltrim (substr(cNum,1,9)),cTipo,cFornec,cLoja)
		M->E2_PARCELA := cParcela
		
		
	CASE cDespesa == "333"
		M->E2_NATUREZ 	:= cNaturez
		M->E2_FORNECE 	:= ""
		M->E2_NOMFOR 	:= ""
		M->E2_LOJA		:= ""
		cParcela	:= u_ProxParc(xFilial("SE2"),cPrefixo, alltrim (substr(cNum,1,9)),cTipo,cFornec,cLoja)
		M->E2_PARCELA := cParcela
		
	CASE cDespesa == "402"
		M->E2_NATUREZ 	:= cNaturez
		M->E2_FORNECE 	:= ""
		M->E2_NOMFOR 	:= ""
		M->E2_LOJA 		:= ""
		cParcela	:= u_ProxParc(xFilial("SE2"),cPrefixo, alltrim (substr(cNum,1,9)),cTipo,cFornec,cLoja)
		M->E2_PARCELA := cParcela
		
	CASE alltrim(cDespesa) $ "404/407"
		M->E2_NATUREZ := cNaturez
		M->E2_FORNECE := cFornec				//"000923"
		M->E2_NOMFOR	:=	cNom					//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_NOMFOR")
		M->E2_LOJA := 		cLoja					//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_LOJA") 		//"01"
		cParcela	:= u_ProxParc(xFilial("SE2"),cPrefixo, alltrim (substr(cNum,1,9)),cTipo,cFornec,cLoja)
		M->E2_PARCELA := cParcela
		
	CASE cDespesa == "406"
		M->E2_NATUREZ := cNaturez
		M->E2_FORNECE := cFornec				//"001419"
		M->E2_NOMFOR := cNom						//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_NOMFOR")
		M->E2_LOJA := cLoja						//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_LOJA")			//"01"
		cParcela	:= u_ProxParc(xFilial("SE2"),cPrefixo, alltrim (substr(cNum,1,9)),cTipo,cFornec,cLoja)
		M->E2_PARCELA := cParcela
		
	CASE alltrim(cDespesa) $ "416/417"
		M->E2_NATUREZ := cNaturez
		M->E2_FORNECE := cFornec				// "000626"
		M->E2_NOMFOR := cNom						//	Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_NOMFOR")
		M->E2_LOJA := cLoja						//Posicione("SE2", 6, xFilial("SE2") + M->E2_FORNECE, "E2_LOJA")			//"02"
		cParcela	:= u_ProxParc(xFilial("SE2"),cPrefixo, alltrim (substr(cNum,1,9)),cTipo,cFornec,cLoja)
		M->E2_PARCELA := cParcela
	OTHERWISE
ENDCASE

RestArea(aArea)
Return M->E2_NATUREZ
