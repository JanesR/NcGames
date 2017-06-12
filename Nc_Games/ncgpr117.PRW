#INCLUDE "PROTHEUS.CH"
#Include "TopConn.ch"

Static aEmpresas:={}
Static cEmpCpy	 :=Alltrim(U_MyNewSX6("NC_NCGPR17","02;03","C","Empresas que o produto deve ser copiado","","",.F. ))
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  02/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPR117(lShowMensa,cCodProd,lGrvSBZ,lExecAltera,lUsaCodWeb)
Local aTabelas 	:={"SB1","SB5"}
Local aAreaAtu	:=GetArea()
Local aAreaSB1	:=SB1->(GetArea())
Local aAreaSB5	:=SB5->(GetArea())
Local aAreaSBZ	:=SBZ->(GetArea())
Local aAreaSM0	:=SM0->(GetArea())

Default lShowMensa	:=.T.
Default cCodProd	:=SB1->B1_COD
Default lGrvSBZ		:=.T.
Default lExecAltera	:=.T.
Default lUsaCodWeb	:=.T.


If cEmpAnt<>"01"
	If ! (IsIncallStack("U_MT010INC") 	.Or. IsIncallStack("U_MT010ALT") ) .And. lShowMensa
		MsgStop("Funcao disponivel somente na NC Distribuicao","NC Games")
	EndIf
	Return
EndIf
SB1->(DbSetOrder(1))
If SB1->(MsSeek(xFilial("SB1")+cCodProd))
	If lGrvSBZ
		U_PR117SBZ(cCodProd)
	EndIf
	Processa( {|| U_PR117Exec(lShowMensa,aTabelas,lExecAltera,lUsaCodWeb)},"NC Games")
ElseIf lShowMensa
	MsgStop("Produto ["+cCodProd+"] nao encontrado","NcGames")
EndIf

RestArea(aAreaSB1)
RestArea(aAreaSB5)
RestArea(aAreaSBZ)
RestArea(aAreaSM0)
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  02/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR117Exec(lShowMensa,aTabelas,lExecAltera,lUsaCodWeb)
Local cMensagem	:=""
Local nInd

Default lShowMensa:=.T.
Default lExecAltera:=.T.

Begin Transaction
For nInd:=1 To Len(aTabelas)
	PR117Cpy(aTabelas[nInd],@cMensagem,lExecAltera,lUsaCodWeb)
Next
End Transaction

If !Empty(cMensagem) .And. lShowMensa
	Aviso("Copia Produto",cMensagem,{"OK"},3)
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  02/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR117Cpy(cTabela,cMensagem,lExecAltera,lUsaCodWeb)
Local nOrder		:=1
Local cModo			:="C"
Local cAliasTmp	:=GetNextAlias()
Local nInd
Local nYnd
Local aFilAux
Local lSeparador:=.F.
Local cCodProduto:=SB1->B1_COD

ProcRegua(0)

If Len(aEmpresas)==0
	PR117GetEmp(cEmpCpy)
EndIf

If lUsaCodWeb
	aAreaSA7:=SA7->(GetArea())
	SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
	If SA7->(MsSeek(xFilial("SA7")+"00000001"+SB1->B1_COD)) .And. !Empty(SA7->A7_CODCLI)
		cCodProduto:=SA7->A7_CODCLI
	EndIf
	RestArea(aAreaSA7)
EndIf


For nInd:=1 To Len(aEmpresas)
	
	If !EmpOpenFile(cAliasTmp,cTabela,nOrder,.T.,aEmpresas[nInd,1],@cModo)
		Loop
	EndIf
	
	IncProc("Copiando Produto....")
	
	If cTabela=="SB1"
		If !(cAliasTmp)->(DbSeek(SB1->(B1_FILIAL+cCodProduto)))
			RecLock(cAliasTmp,.T.)
			cMensagem+="Produto ["+cCodProduto+"] Incluido com sucesso na "+aEmpresas[nInd,2]+CRLF
			lSeparador:=.T.
		Else
			RecLock(cAliasTmp,.F.)
			cMensagem+="Produto  ["+cCodProduto+"] Alterado com sucesso na "+aEmpresas[nInd,2]+CRLF
			lSeparador:=.T.
			If !lExecAltera
				Loop
			EndIf
		EndIf
		AvReplace(cTabela,cAliasTmp)
		(cAliasTmp)->B1_COD:=cCodProduto
		PR117Regra(cTabela,cAliasTmp)
		(cAliasTmp)->(MsUnLock())
		
	ElseIf cTabela=="SB5"
		SB5->(DbSetOrder(1))
		If SB5->(MsSeek(xFilial("SB5")+SB1->B1_COD))
			If !(cAliasTmp)->(DbSeek(SB5->(B5_FILIAL+cCodProduto)))
				RecLock(cAliasTmp,.T.)
				cMensagem+="Complemento Produto ["+cCodProduto+"] Incluido com sucesso na "+aEmpresas[nInd,2]+CRLF
				lSeparador:=.T.
			Else
				RecLock(cAliasTmp,.F.)
				cMensagem+="Complemento Produto ["+cCodProduto+"] Alterado com sucesso na "+aEmpresas[nInd,2]+CRLF
				lSeparador:=.T.
				If !lExecAltera
					Loop
				EndIf
			EndIf
			AvReplace(cTabela,cAliasTmp)
			(cAliasTmp)->B5_COD:=cCodProduto
			PR117Regra(cTabela,cAliasTmp)
			(cAliasTmp)->(MsUnLock())
		EndIf
	ElseIf cTabela=="SBZ"
		SBZ->(DbSetOrder(1))
		
		If SBZ->(MsSeek(xFilial("SBZ")+cCodProduto))
			
			aFilAux:=aEmpresas[nInd,3]
			
			For nYnd:=1 To Len(aFilAux)
				
				IncProc("Filial:"+aFilAux[nYnd,2])
				
				If !aFilAux[nYnd,3]==SM0->M0_ESTCOB
					Loop
				EndIf
				
				If !(cAliasTmp)->(DbSeek(aFilAux[nYnd,1]+SB1->B1_COD))
					RecLock(cAliasTmp,.T.)
					cMensagem+="Indicador Produto Incluido com sucesso na "+aEmpresas[nInd,2]+" Filial "+aFilAux[nYnd,2]+CRLF
					lSeparador:=.T.
				Else
					RecLock(cAliasTmp,.F.)
					cMensagem+="Indicador Produto Alterado com sucesso na "+aEmpresas[nInd,2]+" Filial "+aFilAux[nYnd,2]+CRLF
					lSeparador:=.T.
					If !lExecAltera
						Loop
					EndIf
					
				EndIf
				AvReplace(cTabela,cAliasTmp)
				PR117Regra(cTabela,cAliasTmp)
				(cAliasTmp)->BZ_FILIAL:=aFilAux[nYnd,1]
				(cAliasTmp)->(MsUnLock())
			Next
		EndIf
		
		
	EndIf
	
Next
If Select(cAliasTmp)>0
	(cAliasTmp)->(DbCloseArea())
EndIf

If lSeparador
	cMensagem+=Replicate("-",50)+CRLF
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  02/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR117GetEmp(cEmpCpy)
Local aAreaAtu	:=GetArea()
Local aAreaSM0	:=SM0->(GetArea())
Local cEmpAux	:=""
Local aFilAux

SM0->(DbGoTop())
Do While SM0->(!Eof())
	
	If !SM0->M0_CODIGO$cEmpCpy
		SM0->(DbSkip());Loop
	EndIf
	SM0->( AADD(aEmpresas,{M0_CODIGO,M0_NOMECOM,{{M0_CODFIL,M0_FILIAL,M0_ESTCOB} }}) )
	aFilAux:=aEmpresas[Len(aEmpresas),3]
	
	cEmpAux:=SM0->M0_CODIGO
	SM0->(DbSkip())
	Do While SM0->(!Eof()) .And. SM0->M0_CODIGO==cEmpAux
		AADD(aFilAux,{SM0->M0_CODFIL,SM0->M0_FILIAL,SM0->M0_ESTCOB})
		SM0->(DbSkip())
	EndDo
EndDo

RestArea(aAreaSM0)
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  02/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR117Regra(cTabela,cAliaTab)
If cTabela=="SB1"
	If (cAliaTab)->B1_ORIGEM=="1"
		(cAliaTab)->B1_ORIGEM:="2"
	EndIf
	
	If (cAliaTab)->B1_XUSADO=="1"
		(cAliaTab)->B1_MSBLQL:="2"
	EndIf
	
	
ElseIf cTabela=="SB5"
	
	
ElseIf cTabela=="SBZ"
	If (cAliaTab)->BZ_ORIGEM=="1"
		(cAliaTab)->BZ_ORIGEM:="2"
	EndIf
	(cAliaTab)->BZ_IPI:=0
	
EndIf



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  02/27/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR117SBZ(cCodProd)
Local aAreaAtu	:=GetArea()
Local aAreaSBZ	:=SBZ->(GetArea())
Local nInd
Local nYnd
Local nContCol
Local cNomeCol
Local aFilial:=FwAllFilial()

SBZ->(DbSetOrder(1))

For nYnd:=1 To Len(aFilial)
	
	If SBZ->(DbSeek(aFilial[nYnd]+cCodProd))
		Loop
	EndIf
	Begin Transaction
	nContCol:=SBZ->(FCount())
	SBZ->(RecLock("SBZ",.T.))
	For nInd:=1 To nContCol
		cNomeCol:=StrTran(SBZ->(FieldName(nInd)),"BZ","B1")
		If SB1->(FieldPos(cNomeCol))>0
			uValor:=&("SB1->"+cNomeCol)
			SBZ->(FieldPut(nInd,uValor))
		EndIf
		SBZ->BZ_FILIAL:=aFilial[nYnd]
	Next
	SBZ->(MsUnLock())
	End Transaction
	
Next
RestArea(aAreaSBZ)
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  07/30/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR117Copia(lCriaProdWM)
Local aAreaAtu:=GetArea()
Local aAreaSA7:=SA7->(GetArea())
Local lUsaCodWeb

SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO

If lCriaProdWM .And. !(SA7->(MsSeek(xFilial("SA7")+"00000001"+SB1->B1_COD)) .And. !Empty(SA7->A7_CODCLI))
	U_NCWEBM01()//Criar Produto no WebManager
EndIf

If (lUsaCodWeb:=SA7->(MsSeek(xFilial("SA7")+"00000001"+SB1->B1_COD)) .And. !Empty(SA7->A7_CODCLI))
	U_NCGPR117(.T.,SB1->B1_COD,.F.,,lUsaCodWeb)// NCGPR117(lShowMensa,cCodProd,lGrvSBZ,lExecAltera,lUsaCodWeb) Copiar Produto
EndIf	


RestArea(aAreaSA7)
RestArea(aAreaAtu)

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  12/06/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR117IMPOR()
Local cPerg:=Padr("PR117IMPOR",Len(SX1->X1_GRUPO))

PutSx1(cPerg,"01","Importar Planilha","","","MV_CH1","C",60,0,0,"F","                                                            ","      ","   "," ","MV_PAR01","56             ","               ","               ","                                           ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

If SX1->(DbSeek(cPerg+"01")) .And. AllTrim(SX1->X1_DEF01)<>"56"
	SX1->(RecLock("SX1",.F.))
	SX1->X1_DEF01:="56"
	SX1->(MsUnLock())
EndIf       

If !Pergunte(cPerg)
	Return
EndIf	
Processa({|| GravaDados() })      

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  12/06/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaDados() 
Local nInd

Local nLenCod:=AvSx3("B1_COD",3)

cArquivo:=AllTrim(mv_par01)

FT_FUSE(cArquivo)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(nTotLinha:=FT_FLASTREC())
           
ChkFile("SB1")
ChkFile("SB5")
ChkFile("SBZ")
FT_FSKIP()
nLinha:=0
Do While !FT_FEOF()
	cBuffer := FT_FREADLN() //LENDO LINHA
	IncProc("Gravando dados Linha:"+StrZero(++nLinha,5))

	
	
	aDados:=Separa(cBuffer,";")
	
	cCodProd:=Padr(aDados[1],nLenCod)
	
	If !SB1->(DbSeek(xFilial("SB1")+cCodProd ))
		Begin Transaction	
		RecLock("SB1",.T.)
		SB1->B1_FILIAL	:=xFilial("SB1")
		SB1->B1_COD		:=AllTrim(aDados[01])
		SB1->B1_DESC	:=AllTrim(aDados[02])
		SB1->B1_XDESC	:=AllTrim(aDados[03])
		SB1->B1_CODBAR	:=AllTrim(aDados[04])
		SB1->B1_TECNOC	:=AllTrim(aDados[05])
		SB1->B1_ITEMCC	:=AllTrim(aDados[06])
		SB1->B1_BLQVEND	:=AllTrim(aDados[07])
		SB1->B1_MSBLQL	:=AllTrim(aDados[08])
		SB1->B1_UM		:=AllTrim(aDados[09])
		SB1->B1_CC		:=AllTrim(aDados[10])
		SB1->B1_CATEG	:=AllTrim(aDados[11])
		SB1->B1_SBCATEG	:=AllTrim(aDados[12])
		SB1->B1_GRUPO	:=AllTrim(aDados[13])
		SB1->B1_ALT		:=Val(AllTrim(aDados[14]))
		SB1->B1_LARGURA	:=Val(AllTrim(aDados[15]))
		SB1->B1_PROF	:=Val(AllTrim(aDados[16]))
		SB1->B1_PESO	:=Val(AllTrim(aDados[17]))
		SB1->B1_PESBRU	:=Val(AllTrim(aDados[18]))
		SB1->B1_CONSUMI	:=Val( StrTran( AllTrim(aDados[19]),",",".") )
		SB1->B1_CONTA	:=AllTrim(aDados[20])
		SB1->B1_GRPWMS	:=Padl(AllTrim(aDados[21]),Len(SB1->B1_GRPWMS),"0")
		SB1->B1_XMOSTSI	:=AllTrim(aDados[22])
		SB1->B1_TIPO	:=AllTrim(aDados[23])
		SB1->B1_LOCPAD	:=Padl( AllTrim(aDados[24]),Len(SB1->B1_LOCPAD),"0")
		SB1->B1_IMPORT	:=AllTrim(aDados[25])
		SB1->B1_YCLASSE	:=Padl(AllTrim(aDados[26]),Len(SB1->B1_YCLASSE),"0")
		SB1->B1_POSIPI	:=AllTrim(aDados[27])
		SB1->B1_IMPZFRC	:=AllTrim(aDados[28])
		SB1->B1_GRTRIB	:=Padl( AllTrim(aDados[29]),Len(SB1->B1_GRTRIB),"0")
		SB1->B1_ORIGEM	:=AllTrim(aDados[30])
		SB1->B1_GARANT	:=AllTrim(aDados[31])
		SB1->B1_CONV	:=Val(AllTrim(aDados[32]))
		SB1->B1_YSERIE	:=AllTrim(aDados[33])
		SB1->B1_XMOSTSI	:=AllTrim(aDados[34])
		SB1->B1_YCODBA2	:=AllTrim(aDados[35])
		SB1->B1_YCODBA3	:=AllTrim(aDados[36])
		SB1->B1_YCODBA4	:=AllTrim(aDados[37])  
		SB1->B1_PUBLISH	:=AllTrim(aDados[38])  		
		SB1->B1_DTEXEC  :=MsDate()
		SB1->(MsUnLock())
		End Transaction
	EndIf
	
	 

	If !SB5->(DbSeek(xFilial("SB5")+cCodProd ))		
		RecLock("SB5",.T.)
		SB5->B5_FILIAL	:=xFilial("SB5")
		SB5->B5_COD		:=AllTrim(aDados[01])
		SB5->B5_TITULO	:=AllTrim(aDados[39])
		SB5->B5_CEME    :=AllTrim(aDados[40])		
		SB5->(MsUnLock())
	EndIf
	
	PR117GrvSBZ(SB1->B1_COD)		
	
	

	
	
	FT_FSKIP()
EndDo
FT_FUSE()



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR117  ºAutor  ³Microsiga           º Data ³  12/06/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR117GrvSBZ(cCodProd)
Local aAreaAtu	:=GetArea()
Local aAreaSBZ	:=SBZ->(GetArea())
Local nInd
Local nYnd
Local nContCol
Local cNomeCol
Local aFilial:=FwAllFilial()

SBZ->(DbSetOrder(1))

For nYnd:=1 To Len(aFilial)
	
	If SBZ->(DbSeek(aFilial[nYnd]+cCodProd))
		Loop
	EndIf
	Begin Transaction
	nContCol:=SBZ->(FCount())
	SBZ->(RecLock("SBZ",.T.))
	For nInd:=1 To nContCol
		cNomeCol:=StrTran(SBZ->(FieldName(nInd)),"BZ","B1")
		If SB1->(FieldPos(cNomeCol))>0
			uValor:=&("SB1->"+cNomeCol)
			SBZ->(FieldPut(nInd,uValor))
		EndIf
		SBZ->BZ_FILIAL:=aFilial[nYnd]
	Next
	PR117Regra("SBZ","SBZ")	
	SBZ->(MsUnLock())
	End Transaction
	
Next
RestArea(aAreaSBZ)
RestArea(aAreaAtu)

Return
