#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include "XMLXFUN.CH"
#INCLUDE "TBICONN.CH"

user Function CriaCli(aVetor,cPed,lJaExist)
Local aArea := GetArea()
Local returno := .F.
Local _cError	:= ""
Local cWarning := ""

PRIVATE lMsErroAuto 		:= .F.
Private lMsHelpAuto		:= .T.
PRIVATE lAutoErrNoFile	:= .T.
BEGIN TRANSACTION
			                            
			l030Auto:=.T.
			lMsErroAuto:=.F.
			CC2->(DBSETORDER(1))
			SA1->(DBSETORDER(3))
			MSExecAuto({|x,y| MATA030(x,y)},aVetor, Iif(lJaExist,4,3))
			_cError:=" "
			
			If lMsErroAuto
				_cError := MemoRead(NomeAutoLog())+CRLF
				
				ExecValid(aVetor,@_cError)
				
                u_ENVIAEMAIL("rciambarella@ncgames.com.br;jisidoro@ncgames.com.br", "", "", "Erro no Cadastro do Cliente - Pv CiaShop:"+cPed, "Verifique o cliente do pedido:"+cPed,{})
                U_NCECOM09(val(cPed), ,"IMPORTA_CLIENTE","Erro ao "+Iif(lJaExist,"Alterar o cliente codigo Protheus:"+SA1->A1_COD,"Incluir")+" Cliente."," ",.T.," "," ","","01")
				
				GravaZA1(cPed,_cError,aVetor,{})
				RollBackSXe()
                returno := .F.
			Else
				returno := .T.
				ConfirmSX8()
				U_NCECOM09(val(cPed), ,"IMPORTA_CLIENTE",Iif(lJaExist,"Cliente alterado código Protheus:"+SA1->A1_COD,"Incluido")+" Cliente."," ",.F.," "," ","","01")
			Endif
			
	END TRANSACTION

RestArea(aArea)
Return returno

Static Function ExecValid(aVetor,_cError)
Local nInd

RegToMemory("SA1",.F.,.F.)
For nInd:=1 To Len(aVetor)
	
	Eval ( MemVarBlock(aVetor[nInd][1]),aVetor[nInd][2])
	__READVAR		:= "M->"+aVetor[nInd][1]
	cReadVar		:= &(__READVAR)
	&(__READVAR)	:= aVetor[nInd][2]
	
	bValid := AvSx3(aVetor[nInd][1],7)
	If !Eval( bValid )
		xConteudo := aVetor[nInd][2]
		If ValType(xConteudo)=="N"
			xConteudo := AllTrim(Str(xConteudo))
		ElseIf ValType(xConteudo)=="D"
			xConteudo := DTOC(xConteudo)
		EndIf
		_cError += "Erro campo "+ aVetor[nInd][1] +" conteudo "+ xConteudo+CRLF
	EndIf
	
Next

Return

Static Function GravaZA1(cPvCia,cErro,aVetor,aZA1_SA1)
Local aAreaAtu:=GetArea()
Local aAreaZA1:=ZA1->(GetArea())
Local nInd
Local nAscan
Local bGrava
Local aAux

If Empty(aZA1_SA1)
	ZX5->(DbSetOrder(1))//ZX5_FILIAL+ZX5_TABELA+ZX5_CHAVE
	ZX5->(MsSeek(xFilial()+"00004") )
	Do While ZX5->(!Eof()) .And. ZX5->ZX5_TABELA=="00004"
		AADD(aZA1_SA1,Separa(ZX5->ZX5_DESCRI,"#"))
		ZX5->(DbSkip())
	EndDo
	
EndIf
For nInd:=1 To Len(aZA1_SA1)
	aAux:=aZA1_SA1[nInd]
	For nYnd:=1 To Len(aAux)
		aAux[nYnd]:=AllTrim(aAux[nYnd])
	Next
Next

ZA1->(DbSetOrder(1))

Begin Transaction
ZA1->(RecLock("ZA1", !ZA1->(MsSeek(xFilial("ZA1")+cPvCia )) ) )
For nInd:=1 To Len(aVetor)
	If (nAscan:=Ascan(aZA1_SA1,{|a| a[2]==aVetor[nInd][1] }))>0
		ZA1->(FieldPut(FieldPos(aZA1_SA1[nAscan,1]) ,aVetor[nInd][2] )  )
	EndIf
Next
ZA1->ZA1_FILIAL	:= xFilial("ZA1")
ZA1->ZA1_PVVTEX	:= cPvCia
ZA1->ZA1_ERRO		:=cErro
ZA1->(MsUnLock())
End Transaction

RestArea(aAreaZA1)
RestArea(aAreaAtu)
Return