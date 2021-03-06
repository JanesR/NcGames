#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "AP5MAIL.CH"

User Function NCPREATUAL()

Local aArea := GetArea()

Processa({|| ProcTabela() })

MsgAlert("Processo Finalizado!")

RestArea(aArea)
Return

Static Function ProcTabela()

Local aArea := GetArea()
Local aTabPend := {}
Local aAuxAtu :={}
Local bTabAtua := .F.

//Pega as tabelas pendentes de atualiza��o
DbSelectArea("SZJ")
dbSetOrder(3)
dbSeek(xFilial("SZJ"),.T.)

Do While !Eof() .And. SZJ->ZJ_DTPROG <= dDataBase
	
	If (SZJ->ZJ_STATUS == "1")
		
		Aadd(aTabPend, SZJ->ZJ_CODIGO)
		SZJ->(dbSkip())
		Loop
	Else
		SZJ->(dbSkip())
		Loop
	EndIf
EndDo

SZJ->(DbCloseArea())

If (Len(aTabPend) == 0)
	Return
EndIf

ProcRegua( Len(aTabPend) )

//Lista os itens por  tabela e solicita atualiza��o atualiza


For nX := 1 to Len(aTabPend)
	
	IncProc('Processando tabelas')
	
	DbSelectArea("SZH")
	DbSetOrder(3)
	If DbSeek( xFilial("SZH") + aTabPend[nX])
		
		Do While !EoF() .And. SZH->ZH_CODIGO == aTabPend[nX]
			Aadd(aAuxAtu, {SZH->ZH_PRODUTO ,SZH->ZH_PRV0,SZH->ZH_PRVSUG})
			SZH->(DbSkip())
			Loop
		EndDo
		SZH->(DbCloseArea())
		
		bTabAtua := AtualiDA1(aAuxAtu)
		aAuxAtu := {}
		
		If bTabAtua
			
			DbSelectArea("SZJ")
			DbSetOrder(1)
			If DbSeek(xFilial("SZJ") + aTabPend[nX] ,.T.)
				
				If RecLock("SZJ",.F.)
					SZJ->ZJ_STATUS := "2"
				EndIf
				SZJ->(MsUnlock())
			EndIf
			SZJ->(DbCloseArea())
			bTabAtua := .F.
		EndIf
		
	EndIF
	
Next


RestArea(aArea)
Return

Static Function AtualiDA1(aListaAtu)
Local aArea 		:= GetArea()
Local aList 		:= aListaAtu
Local bTabAtu 	:= .F.
Local cOrigensN 	:= AllTrim(SuperGetMv("NCG_000110",.F.,"")) // origens nacionais
Local cOrigemPro := ""
Local cTabelas	:= {}
Local cProd:=""
Local cPreco:=""
Local cPrecoSug:=""
Local cCont := 0
Local _FatorPRE := 0
Local _FatorOver := 0
Local cTab := ""

For nZ:= 1 to Len(aList)
	
	cProd  	:= aList[nZ,1]
	cPreco 	:= aList[nZ,2]
	cPrecoSug	:= aList[nZ,3]
	
	If Select("SB1") > 0
		SB1->(DbCloseArea())
	EndIf
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	If DbSeek(xFilial("SB1") + cProd)
		
		cOrigemPro := SB1->B1_ORIGEM
		
		//If cOrigemPro $ cOrigensN
		cTabelas := StrTokArr( AllTrim(SuperGetMv("MV_NCTABPR",.F.,"")) , ";") //tabelas para origens nacionais
		//Else
		//	cTabelas := StrTokArr( AllTrim(SuperGetMv("NCG_000111",.F.,"")) , ";") //Tabelas para produtos Importados
		//EndIf
		
		For nY := 1 to Len(cTabelas)
			ValidProd(cProd, cTabelas[nY])
		Next
		
		If RecLock("SB1",.F.)
			SB1->B1_CONSUMI  := SZH->ZH_PRVSUG
			SB1->B1_PRV1     := SZH->ZH_PRV0
			SB1->B1_XPRV18   := SZH->ZH_PRV0 / GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+"018"+cOrigemPro,1,0.00)
			SB1->B1_XPRV12   := SZH->ZH_PRV0 / GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+"012"+cOrigemPro,1,0.00)
			SB1->B1_XPRV07   := SZH->ZH_PRV0 / GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+"007"+cOrigemPro,1,0.00)
			SB1->(MsUnlock())
		EndIf
		
		//TabConsu(cProd,cPrecoSug)//Retirado pois apenas o Ecommerce ir� ajustar as tabelas CON/CDE - LucasOliveira
		
	EndIF
	SB1->(DbCloseArea())
	
	For nY := 1 to Len(cTabelas)
		
		//Tratamento para produtos com over price
		If cTabelas[nY] > "100"
			DbSelectArea("SZK")
			DbSetOrder(3)
			If dbSeek(xFilial("SZK")+cTabelas[nY])
				_FatorOver := SZK->ZK_INDICE
				cTab := SZK->ZK_TABBASE
			Else
				cTab := cTabelas[nY]
			EndIf
			SZK->(DbCloseArea())
		Else
			cTab:= cTabelas[nY]
		EndIf
		
		DbSelectArea("SZU")
		DbSetOrder(1)
		If DbSeek(xFilial("SZU") +  cTab + cOrigemPro ,.T.)
			_FatorPRE := SZU->ZU_FATOR
			
			cTab:= cTabelas[nY]
			
			DbSelectArea("DA1")
			DbSetOrder(1)
			IF DbSeek(xFilial("DA1") + cTab + cProd,.T.)
				
				IF cTabelas[nY] < "100"
					If RecLock("DA1",.F.)
						DA1->DA1_PRCVEN:= Round( cPreco/_FatorPRE, 2)
					EndIF
					DA1->(MsUnlock())
				Else
					If RecLock("DA1",.F.)
						DA1->DA1_PRCVEN:= Round( (cPreco/_FatorPRE) / ( 1 - _FatorOver/100 )  , 2)
					EndIF
					DA1->(MsUnlock())
				EndIF
				
				cCont := cCont + 1
			EndIf
			DA1->(DbCloseArea())
		EndIf
		SZU->(DbCloseArea())
	Next
Next

//If cCont == Len(aList)
bTabAtu := .T.
//EndIF

RestArea(aArea)
Return bTabAtu


Static Function ValidProd(cProd, cTab)
Local aArea := GetArea()

DbSelectArea("DA1")
DbSetOrder(1)

If !DbSeek(xFilial("DA1") + cTab + cProd)
	
	If RecLock("DA1",.T.)
		
		DA1->DA1_FILIAL  := xFilial("DA1")
		DA1->DA1_ITEM    := "0001"
		DA1->DA1_CODTAB  := cTab
		DA1->DA1_CODPRO  := cProd
		DA1->DA1_GRUPO   := SPACE(04)
		DA1->DA1_REFGRD  := SPACE(26)
		DA1->DA1_PRCVEN  := 0.00
		DA1->DA1_VLRDES  := 0.00
		DA1->DA1_PERDES  := 0.0000
		DA1->DA1_ATIVO   := "1"
		DA1->DA1_FRETE   := 0.00
		DA1->DA1_ESTADO  := SPACE(02)
		DA1->DA1_TPOPER  := "4"
		DA1->DA1_QTDLOT  := 999999.99
		DA1->DA1_INDLOT  := "000000000999999.99"
		DA1->DA1_MOEDA   := 1
		DA1->DA1_DATVIG  := CtoD("20140101")
		DA1->DA1_ITEMGR  := SPACE(03)
		DA1->DA1_PRCMAX  := 0.00
		DA1->DA1_XMOT    := SPACE(06)
		DA1->DA1_XMOTD   := SPACE(60)
		
	EndIF
	DA1->(MsUnlock())
EndIf

RestArea(aArea)
Return

Static Function TabConsu(cCodPro,nConsumi)

Local cTabConsu 	:= Alltrim(U_MyNewSX6("MV_NCTABCO","CON","C","Tabela de Pre�o consumidor","","",.F. )   )
Local cAliasDA1 	:= DA1->(GetArea())
Local dAtual 		:= MsDate()
Local cItem			:= Space(04)
Local cNextItem 	:= Space(04)

DA1->(DbSetOrder(1))// DA1_FILIAL+DA1_CODTAB+DA1_CODPRO
DA1->(DbSeek(xFilial("DA1")+cTabConsu))

If DA1->(DbSeek(xFilial("DA1")+cTabConsu+cCodPro))
	DA1->(RecLock("DA1",.F.))
	
	DA1->DA1_PRCVEN  := nConsumi
	DA1->DA1_DATVIG  := dAtual
	
	DA1->(MsUnlock())
Else
	Do While !Eof() .And. DA1->DA1_CODTAB == cTabConsu
		cItem := DA1->DA1_ITEM
		dbSkip()
	EndDo
	cNextItem := Soma1(cItem,4)
	
	DA1->(Reclock("DA1",.T.))
	
	DA1->DA1_FILIAL  := xFilial("DA1")
	DA1->DA1_ITEM    := cNextItem
	DA1->DA1_CODTAB  := cTabConsu
	DA1->DA1_CODPRO  := cCodPro
	DA1->DA1_PRCVEN  := nConsumi
	DA1->DA1_ATIVO   := "1"
	DA1->DA1_TPOPER  := "4"
	DA1->DA1_MOEDA   := 1
	
	DA1->DA1_DATVIG  := dAtual
	
	DA1->(MsUnlock())
EndIf

RestArea(cAliasDA1)

Return
