#DEFINE CRLF Chr(13)+Chr(10)


Static aCpoSA1Alt :={}
Static cMObs030 := ""

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA030TOK  บAutor  ณMicrosiga           บ Data ณ  02/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MA030TOK()

Local cAliasAtu	:= GetArea()
Local cAliasCTD := CTD->(GetArea())
Local lItem		:= .F.
Local lRetorno	:= .T.
Local aAltCpo	:= {}
Local aLcCpo 	:= {}
Local nInd
Local cNomeCpo


If !Empty(M->A1_ZCODCIA)
	
	aAdd(aAltCpo,"A1_NOME")
	aAdd(aAltCpo,"A1_EMAIL")
	aAdd(aAltCpo,"A1_END")
	aAdd(aAltCpo,"A1_COMPLEM")
	aAdd(aAltCpo,"A1_BAIRRO")
	aAdd(aAltCpo,"A1_MUN")
	aAdd(aAltCpo,"A1_EST")
	aAdd(aAltCpo,"A1_CEP")
	aAdd(aAltCpo,"A1_DDD")
	aAdd(aAltCpo,"A1_TEL")
	aAdd(aAltCpo,"A1_DTNASC")
	aAdd(aAltCpo,"A1_PFISICA")
	aAdd(aAltCpo,"A1_PESSOA")
	aAdd(aAltCpo,"A1_INSCR")
	aAdd(aAltCpo,"A1_CGC")
	aAdd(aAltCpo,"A1_MSBLQL")
	
	aCpoSA1Alt := {}
	For nInd := 1 to Len(aAltCpo) //SA1->(FCount())
		cNomeCpo:=aAltCpo[nInd]   //SA1->(FieldName(nInd))
		If !&('M->'+cNomeCpo)==&('SA1->'+cNomeCpo)
			aAdd( aCpoSA1Alt, {cNomeCpo,AllTrim(AvSx3(cNomeCpo,5)),AvSx3(cNomeCpo,2),&('SA1->'+cNomeCpo),&('M->'+cNomeCpo)})
		EndIf
	Next nInd
EndIf

CTD->(DbSetOrder(1))
lItem := CTD->(DbSeek(xFilial("CTD")+"C"+M->A1_COD+M->A1_LOJA))

CTD->(RecLock("CTD",!lItem))

CTD->CTD_ITEM	:= "C"+M->A1_COD+M->A1_LOJA
CTD->CTD_CLASSE	:= "2"
CTD->CTD_DESC01	:= M->A1_NOME                                   	
CTD->CTD_BLOQ	:= "2"
CTD->CTD_DTEXIS	:= CtoD("01/01/2014")
CTD->CTD_CLOBRG	:= "2"        	
CTD->CTD_ACCLVL	:= "1"

CTD->(MsUnlock())
If !IsBlind()
	IIf(lItem==.T.,MsgAlert("O cliente "+CTD->CTD_ITEM+" foi alterado"),MsgAlert("O cliente "+CTD->CTD_ITEM+" foi incluso"))
EndIf	

If !Empty(M->A1_PRF_OBS)
	cMObs030 := M->A1_PRF_OBS
Else
	cMObs030 := SA1->A1_PRF_OBS
EndIf

aAdd(aLcCpo,"A1_RISCO")
aAdd(aLcCpo,"A1_LC")
//aAdd(aLcCpo,"A1_VENCLC")
aAdd(aLcCpo,"A1_CLASSE")
aAdd(aLcCpo,"A1_LCFIN")

For nInd := 1 to Len(aLcCpo) //SA1->(FCount())
	cNomeCpo:=aLcCpo[nInd]   //SA1->(FieldName(nInd))
	If !&('M->'+cNomeCpo)==&('SA1->'+cNomeCpo)
		
		xContAnt:=&('SA1->'+cNomeCpo)
		xContDep:=&('M->'+cNomeCpo)
		If AvSx3(cNomeCpo,2)=="D"
			xContAnt:=DTOC(&('SA1->'+cNomeCpo))                                                                                                       
			xContDep:DTOC(&('M->'+cNomeCpo))
		ElseIf AvSx3(cNomeCpo,2)=="N"
			xContAnt:=TransForm(&('SA1->'+cNomeCpo),(AvSx3(cNomeCpo,6)))
			xContDep:=TransForm(&('M->'+cNomeCpo),(AvSx3(cNomeCpo,6)))
		EndIf
		
		cMObs030 += " O Campo "+AllTrim(AvSx3(cNomeCpo,5))+" foi alterado de: "+Alltrim(xContAnt)+" para: "+Alltrim(xContDep)+"em "+DtoC(MsDate())+" "+time()+CRLF
		
	EndIf
Next nInd

RestArea(cAliasCTD)
RestArea(cAliasAtu)

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA030TOK  บAutor  ณMicrosiga           บ Data ณ  02/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetaCpoSA1()
Return aCpoSA1Alt


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMA030TOK  บAutor  ณMicrosiga           บ Data ณ  09/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetSA1Fin()
Return cMObs030  
