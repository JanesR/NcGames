#Include "PROTHEUS.CH "
#INCLUDE "TBICONN.CH"


#DEFINE STS_PROCOK   	"2"
#DEFINE STS_PROCER   	"9"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WML05JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
//RpcSetEnv("03","02")
//U_WML05SFT()
//SPDFCFPrfA()
U_NCIWML05()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCIWML05()
Processa({|| ExecBlock("WML05GERAR") }, " Gera Reduxao Z Movimento Fiscal ", "Interface de Dados")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WML05Gerar()
Local aAreaAtu		:=GetArea()
Local cQryAlias		:=GetNextAlias()
Local aDados		:={}
Local cModo			:=""
Local cTbPZX		:= "%PZX010 " + "PZX%"
Local cEmpPZX
Local cFilPZX
Local nInd
Local nYnd
Local aConexoes
Local aDadosAux
Local nContar
Local lWait

BeginSQL Alias cQryAlias
	SELECT PZX.R_E_C_N_O_ RecPZX, PZX.PZX_EMPDES, PZX.PZX_FILDES
	FROM  %exp:cTbPZX%
	WHERE PZX_FILIAL = %xfilial:PZX%
	AND PZX.PZX_STATUS=' '
	AND PZX.%notDel%
	ORDER BY PZX.PZX_EMPDES, PZX.PZX_FILDES,PZX.PZX_DTMOV
EndSQL

ProcRegua(2)
Conout("   -> " + GetLastQuery()[2])
Do While (cQryAlias)->(!Eof())
	
	cEmpPZX:=(cQryAlias)->PZX_EMPDES
	cFilPZX:=(cQryAlias)->PZX_FILDES
	
	AADD(aDados,{ {cEmpPZX,cFilPZX},{} } )
	aDadosAux:=aDados[Len(aDados),2]
	
	Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->PZX_EMPDES==cEmpPZX .And. (cQryAlias)->PZX_FILDES==cFilPZX
		AADD(aDadosAux,(cQryAlias)->RecPZX)
		(cQryAlias)->(DbSkip())
	EndDo
	
EndDo

(cQryAlias)->(DbCloseArea())

For nInd:=1 To Len(aDados)
	aDadosAux:=aDados[nInd]
	//aConexoes:=GetUserInfoArray()
	//nContar:=0
	//AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML05GRAVAR" ),nContar++, )   }  )
	//StartJob( "U_WML05Gravar",GetEnvServer(), nContar>=5, aDadosAux, .T.)
	U_WML05Gravar(aDadosAux)
Next

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WML05Gravar(aDados , lMultiT )
Local aArea			:= GetArea()
Local nX			:= 0
Local nI			:= 0
Local cModo 		:= ""
Local cAliasPZX		:= ""
Local cTipoReg		:= ""
Local lDefCampos	:= .F.
Local cNumero		:= ""
Local cCodTotal		:= ""
Local nValor		:= 0
Local nTamPDV 		:= 0
Local xInfo			:= NIL
Local nTamReduz 	:= 0
Local nCont			:= 0
Local cChave		:= ""
Local cAliasP		:= "SFI"
Local aCampos		:= {}
Local aMap			:= {}
Local cTotaliz		:= ""
Local aTotaliz		:= {}
Local aInfo			:= {}
Local cDec			:= ""
Local aRecnos		:=	aDados[2]
Local aCupom		:={}
Local nI
Local nTotImp:=0
Local cI  
Local aDatas:={,}


Default lMultiT := .T.

// ----------------------------------------------
// Se for processamento em MultitThread - Prep.Env.
If lMultiT
	RpcClearEnv()
	RpcSettype(3)
	RpcSetEnv(aDados[1,1],aDados[1,2])
EndIf

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML05JOB", "Gravação da Redução Z", "FISCAL", MsDate() )


// ----------------------------------
// Abrindo TABELAS
dbSelectArea("SFI")
SFI->(dbSetOrder(1))//FI_FILIAL+DTOS(FI_DTMOVTO)+FI_PDV+FI_NUMREDZ


dbSelectArea("SLG")
SLG->(dbSetOrder(1))


dDataAtu		:= dDataBase

cAliasPZX		:= GetNextAlias()
EmpOpenFile(cAliasPZX,"PZX",2,.T.,"01",@cModo)

nTamPDV 	:= TamSX3("FI_PDV ")[1]
nTamReduz 	:= TamSX3("FI_NUMREDZ")[1]

// ------------------------------------------------------
// Mapa de campso De/Para para gravacao
aAdd( aMap , {"FI_CRO"				,"PZX_CRO" } )
aAdd( aMap , {"FI_SERPDV"			,"PZX_SERIE" } )
//aAdd( aMap , {"FI_NUMREDZ"			,"PZX_CODRED" } )
aAdd( aMap , {"FI_NUMREDZ"			,"PZX_CRZ" } )
aAdd( aMap , {"FI_GTFINAL"			,"PZX_GT" } )
aAdd( aMap , {"FI_DTREDZ"			,"PZX_DTMOV" } )
aAdd( aMap , {"FI_DTMOVTO"			,"PZX_DTMOV" } )
aAdd( aMap , {"FI_COO"				,"PZX_REDUCZ" } )
aAdd( aMap , {"FI_YCODLOJ"			,"PZX_CODLOJ" } )

//U_WML05SFT()
SFI->(DbSetOrder(1))//FI_FILIAL+DTOS(FI_DTMOVTO)+FI_PDV+FI_NUMREDZ

For nYnd:=1 To Len(aRecnos)
	
	(cAliasPZX)->(DbGoTo(aRecnos[nYnd]))
	
	cMensagem:="Processando Movimento Reducao Z - Movimento do dia :"+Dtoc((cAliasPZX)->PZX_DTMOV)+" na Loja:"+AllTrim((cAliasPZX)->PZX_CODLOJ)
	IncProc(cMensagem)
	PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
	

	// -------------------------------------------
	// Caso nao exista reducao para o DIA e PDV
	
	Begin Transaction
	
	cPDV:=(cAliasPZX)->PZX_PDV
	
	If !(SLG->(MsSeek(xFilial("SLG")+PadR(AllTrim(cPDV),ntamPDV) )))
		RecLock(cAliasPZX,.F.)
		(cAliasPZX)->PZX_STATUS :=  STS_PROCER
		(cAliasPZX)->(MSUnLock())
	Else
		//cChave := DtoS((cAliasPZX)->PZX_DTMOV) + PadR(AllTrim((cAliasPZX)->PZX_PDV),nTamPDV) + PadR(AllTrim((cAliasPZX)->PZX_CODRED ),nTamReduz)
		cChave := DtoS((cAliasPZX)->PZX_DTMOV) + PadR(AllTrim((cAliasPZX)->PZX_PDV),nTamPDV) + PadR(AllTrim((cAliasPZX)->PZX_CRZ ),nTamReduz)
		
		If SFI->(MsSeek(xFilial("SFI")+cChave))//FI_FILIAL+DTOS(FI_DTMOVTO)+FI_PDV+FI_NUMREDZ
			RecLock("SFI",.F.)
		Else
			RecLock("SFI",.T.)
			SFI->FI_FILIAL:=xFilial("SFI")
		EndIf
		
		For nCont:=1 To Len(aMap)
			xInfo := (cAliasPZX)->(FieldGet( FieldPos(aMap[nCont,2]) ))
			SFI->( FieldPut( FieldPos(aMap[nCont,1]) , xInfo ) )
		Next nCont
		
		aCupom:={}
		GetCupom(SFI->FI_DTMOVTO,SLG->LG_CODIGO,SFI->FI_SERPDV,@aCupom)
		
		SFI->FI_PDV		:=SLG->LG_PDV
		SFI->FI_NUMINI	:=aCupom[1]
		SFI->FI_NUMFIM	:=aCupom[2]
		SFI->FI_GTFINAL	:=(cAliasPZX)->PZX_GT
		SFI->FI_NUMERO	:= GetCCF( (cAliasPZX)->PZX_CODLOJ,(cAliasPZX)->PZX_DTMOV,SLG->LG_PDV)
		SFI->FI_SERPDV	:=SLG->LG_SERPDV
		
	EndIf
	cTotaliz 	:= AllTrim((cAliasPZX)->PZX_TOTALI)
	If !cTotaliz=="0"
		aTotaliz	:= Separa(cTotaliz,";")
		
		For nCont:=1 To Len(aTotaliz)
			If Len(aInfo := Separa(aTotaliz[nCont],"|"))>0
				
				aInfo[2] := AllTrim(aInfo[2])
				cDec := Right(aInfo[2],2)
				aInfo[2] := SubStr(aInfo[2] , 1, Len(aInfo[2])-2  )
				aInfo[2] += "." + cDec
				aInfo[1]:=AllTrim(Upper(aInfo[1]))
				
				If "T07" $ aInfo[1]
					SFI->FI_BAS7 := Val(aInfo[2])
				ElseIf "T12" $ aInfo[1]
					SFI->FI_BAS12 := Val(aInfo[2])
				ElseIf "T18" $ aInfo[1]
					SFI->FI_BAS18 := Val(aInfo[2])
				ElseIf "T25" $ aInfo[1]
					SFI->FI_BAS25 := Val(aInfo[2])
				ElseIf "F1" $ aInfo[1]
					SFI->FI_SUBTRIB := Val(aInfo[2])
				ElseIf "T032" $ aInfo[1]
					SFI->FI_BAS032 := Val(aInfo[2])
				ElseIf "CAN-T" $ aInfo[1]
					SFI->FI_CANCEL := Val(aInfo[2])
				ElseIf "DT" $ aInfo[1]
					SFI->FI_DESC := Val(aInfo[2])
				ElseIf "N1" $ aInfo[1]
					SFI->FI_NTRIB += Val(aInfo[2])
				EndIf
				
			EndIf
			
		Next nCont
	EndIf
	nTotImp:=0
	SFI->FI_VALCON := (cAliasPZX)->PZX_VDBRT -SFI->(FI_DESC+FI_CANCEL)
	//Calcula o valor total dos impostos
	For nI:=1 to 9999
		cCampo := "FI_BAS"+Alltrim(Str(nI))
		cI	   := AllTrim(Str(nI))
		If SFI->(FieldPos( cCampo )) > 0
			If SFI->(FieldGet( FieldPos( cCampo ) )) > 0
				nTotImp += NoRound(SFI->(FieldGet(FieldPos(cCampo)))*Val(LJ300PerAliq(nI))/100,2)
			EndIf
		EndIf
	Next i
	
	
	SFI->FI_IMPDEBT	:= nTotImp
	SFI->(MsUnlock())
	// -------------------------
	// Grava Flag
	RecLock(cAliasPZX,.F.)
	(cAliasPZX)->PZX_STATUS :=  STS_PROCOK
	(cAliasPZX)->(MSUnLock())
	
	
	End Transaction
	
	RecLock("SFI",.F.)
	SFI->FI_GTINI	:=GetGtIni(SFI->FI_DTMOVTO-1,SFI->FI_PDV,SFI->FI_NUMREDZ)
	SFI->(MsUnLock())
	
	
	
Next nYnd
dDataBase:=dDataAtu
//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML05JOB", "Gravação da Redução Z", "FISCAL", MsDate(), "F" )


(cAliasPZX)->(dbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  06/22/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function GetCupom(dDtaMov,cPDV,cSeriePDV,aCupom)//GetCupom(SFI->FI_DTMOVTO,SLG->LG_CODIGO,SFI->FI_SERPDV)
Local aAreaAtu	:=GetArea()
Local cQryAlias	:=GetNextAlias()

BeginSQL Alias cQryAlias
	
	SELECT Min(D2_DOC) Primeiro ,Max(D2_DOC) Ultimo
	FROM  %table:SD2% SD2
	WHERE D2_FILIAL = %xfilial:SD2%
	AND D2_EMISSAO=%Exp:Dtos(dDtaMov)%
	AND D2_PDV=%Exp:cPDV%
	AND SD2.%notDel%	
EndSQL

aCupom:={"",""}

Do While (cQryAlias)->(!Eof())
	aCupom[1]:=(cQryAlias)->Primeiro
	aCupom[2]:=(cQryAlias)->Ultimo
	(cQryAlias)->(	DbSkip())
EndDo

(cQryAlias)->(	DbCloseArea())
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  06/29/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetGtIni(dDtaMov,cPDV,cCodRedz)
Local aAreaAtu	:=GetArea()
Local cQryAlias	:=GetNextAlias()

BeginSQL Alias cQryAlias
	SELECT FI_GTFINAL
	FROM  %table:SFI% SFI
	WHERE SFI.FI_FILIAL = %xfilial:SFI%
	AND SFI.FI_DTMOVTO=%Exp:Dtos(dDtaMov)%
	AND SFI.FI_PDV=%Exp:cPDV%
	AND SFI.%notDel%
EndSQL

nTotal:=(cQryAlias)->FI_GTFINAL

(cQryAlias)->(	DbCloseArea())
RestArea(aAreaAtu)
Return nTotal

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  08/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCCF(cCodLoja,dtMov,cPDV)
Local aAreaAtu:=GetArea()
Local cQryAlias		:=GetNextAlias()
Local cRetorno:=""
Local cTbPZ0		:= "%PZ0010 " + "PZ0%"

BeginSQL Alias cQryAlias
	SELECT PZ0_CCF
	FROM  %exp:cTbPZ0%
	WHERE PZ0_FILIAL = ' '
    AND PZ0.PZ0_CODLOJ=%Exp:cCodLoja%
    AND PZ0.PZ0_DTMOV=%Exp:Dtos(dtMov)%
    AND PZ0.PZ0_PDV=%Exp:cPDV%
	AND PZ0.%notDel%
EndSQL
                  
cRetorno:=(cQryAlias)->PZ0_CCF
(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return cRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  07/24/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function LJ300PerAliq( nAliq )
Local cAliq   := ""   			//percentual para retorno
Default nAliq := 0				//Valor da aliquota

If nAliq >= 100 .AND. nAliq <= 999 //Caso seja fracionaria com 3 digitos
	cAliq := AllTrim(Str( nAliq ))
	cAliq := SubStr( cAliq,1,1 )+ "." + SubStr( cAliq,2 )
ElseIf nAliq >= 1000 .AND. nAliq <= 9999 //Caso seja fracionaria com 4 digitos
	cAliq := AllTrim(Str( nAliq ))
	cAliq := SubStr( cAliq,1,2 )+ "." + SubStr( cAliq,3 )
Else
	cAliq := AllTrim(Str( nAliq ))
EndIf

Return cAliq

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  07/30/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WML05LF()
Local aAreaAtu	:=GetArea()
Local aAreaSF3	:=SF3->(GetArea())
Local aAreaSFT	:=SFT->(GetArea())
Local cQryAlias	:=GetNextAlias()
Local cFilSF3	:=xFilial("SF3")

BeginSQL Alias cQryAlias
	SELECT SFT.R_E_C_N_O_ RECSFT,D2_PDV
	FROM  %table:SFT% SFT,%table:SD2% SD2
	WHERE FT_FILIAL = %xfilial:SFT%
	AND SFT.FT_TIPOMOV='S'
	AND SFT.FT_SERIE='ECF'
	AND SFT.FT_NFISCAL Between '        ' AND 'ZZZZZZZZ'
	AND SFT.FT_CLIEFOR Between '        ' AND 'ZZZZZZZZ'
	AND SFT.FT_LOJA Between '        ' AND 'ZZZZZZZZ'
	AND SFT.%notDel%	
	AND SD2.D2_FILIAL=%xfilial:SD2%
	AND SD2.D2_DOC=SFT.FT_NFISCAL		
	AND SD2.D2_SERIE=SFT.FT_SERIE
	AND SD2.D2_CLIENTE=SFT.FT_CLIEFOR
	AND SD2.D2_LOJA=SFT.FT_LOJA
	AND SD2.D2_COD=SFT.FT_PRODUTO
	AND SD2.D2_ITEM=SFT.FT_ITEM
	AND SD2.%notDel%		
	AND SD2.D2_PDV<>' '	 
EndSQL            

SF3->(DbSetOrder(4))//F3_FILIAL+F3_CLIEFOR+F3_LOJA+F3_NFISCAL+F3_SERIE

Do While (cQryAlias)->(!Eof()) 

	SFT->(DbGoTo((cQryAlias)->RECSFT))
	SFT->(RecLock("SFT",.F.))
	SFT->FT_PDV:=(cQryAlias)->D2_PDV
	SFT->(MsUnLock())        
	
	If SF3->(MsSeek(cFilSF3+SFT->(FT_CLIEFOR+FT_LOJA+FT_NFISCAL+FT_SERIE))) .And. SF3->F3_PDV<>SFT->FT_PDV
		SF3->(RecLock("SF3",.F.))
		SF3->F3_PDV:=SFT->FT_PDV
		SF3->(MsUnLock())        
	EndIf	
	
	(cQryAlias)->(	DbSkip())
EndDo

(cQryAlias)->(DbCloseArea())
RestArea(aAreaSF3)
RestArea(aAreaSFT)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWML05  ºAutor  ³Microsiga           º Data ³  07/30/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SPDFCFPrfA(aRegC400	, aRegC405	, aRegC410	, aRegC420	,;
					aRegC425	, aRegC460	, aRegC470	, aRegC490	,;
					aRegC495	, aProdB1	, dDataDe	, dDataAte	,;
					cPerfil		, cAlias	, aReg0200	, aReg0190	,;
					lCstPis		, lCstCof	, aReg0220	, aReg1600	,;
					aReg0150	, aWizard	, lTop		, cUf		,;
					nQtReg0200 	, lJob  	, lLegisPer, cNrlivro)

Local 	nPos400		:= 0
Local 	nPos405		:= 0
Local 	aPos420		:= {}
Local 	aTotaliz	:= {}
Local 	nY 			:= 0
Local 	nValCof 	:= 0
Local	nValPis 	:= 0
Local 	cAliqISS  	:= ""
Local 	nAliqIss 	:= 0
Local 	aCmpAliICM 	:= {} 							// Campos de Aliquota de ICMS da tabela SFI
Local 	aCmpAliISS 	:= {} 							// Campos de Aliquota de ISS da tabela SFI
Local 	nVlBrtLj  	:= 0
Local 	lAnalLEG58 	:= LJAnalisaLEG(58)[1] 			// Para a Nota Fiscal Gaucha pega os dados do cupom
Local 	aAuxReg   	:= {}
Local 	nQuantD   	:= Min(TAMSX3("FT_QUANT")[2],3)
Local 	cFilB1		:= xFilial("SB1")
Local 	cFilSA1		:= xFilial("SA1")
Local 	cFilSL1		:= xFilial("SL1")
Local 	cQryAlias 	:= GetNextAlias() 				// Alias da Query
Local 	cQryFields 	:= ""  							// Campos da Query
Local 	cOrderBy	:= ""  							// Order By da Query
Local 	cChave  	:= ""
Local 	cPDV 		:= ""
Local 	sDTMOVTO	:= ""
Local 	lCancSft  	:= .F.
Local  	aSLX 		:= {}
Local 	lConcFil	:= SuperGetMv("MV_COFLSPD",.F.,.T.)
Local 	cConfFil 	:= Iif(lConcFil,cFilB1,"")
Local 	nPosC460 	:= 0
Local 	nPosC470 	:= 0
Local   cNfC460 	:= ""
Local 	aItensC470 	:= {}
Local 	cMVDTINCB1	:= AllTrim(GetNewPar("MV_DTINCB1","B1_DATREF"))
Local 	aSetField   := {} //Campos da query para efetuar conversao "TcSetField"
Local 	lIsBahia 	:= cUf == "BA"
Local 	aInfPart 	:= {"","","","",""}
Local 	cCpfCNPJ  	:= ""
Local 	cChvCliAnt 	:= ""
Local   lGer410		:= .t.//!lLegisPer .And. "1"$aWizard[1][15]
Local cFiltro:= ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Variaveis de relacionamento de registros atraves de posicao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local   nPosC110        := 	0
Local	nPosC300		:=	0
Local	nPosC600		:=	0
Local	nPosC700		:=	0
Local	nPosD300		:=	0
Local   nPosD600        :=  0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Variaveis de FLAG para gravacao de registrso³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local   lGrava0150      :=	.F.
Local   lGrava0200      :=	.F.
Local	lGrava1500		:=	.F.
Local	lGravaC500		:=	.F.
Local	lGravaC700		:=	.F.
Local	lGravaD500		:=	.F.
Local	lGravaG126		:=  .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Variaveis de registros³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local	aReg0150		:=	{}
Local	aReg0190		:=	{}
Local	aReg0200		:=	{}
Local	aReg0220		:=	{}
Local	aReg0400		:=	{}
Local	aReg0450		:=	{}
Local	aReg0460		:=	{}
Local	aRegC100		:=	{}
Local	aRegC110		:=	{}
Local	aRegC111		:=	{}
Local	aRegC112		:=	{}
Local	aRegC113		:=	{}
Local	aRegC114		:=	{}
Local	aRegC115		:=	{}
Local	aRegC130		:=	{"C130", 0, 0, 0, 0, 0, 0, 0}
Local	aRegC165		:=	{}
Local	aRegC170		:=	{}
Local	aRegC190		:=	{}
Local	aLancFis		:=	{} 
Local	aRegC300		:=	{}
Local	aRegC310		:=	{}
Local	aRegC320		:=	{}
Local	aRegC321		:=	{}
Local	aRegC390		:=	{}
Local   aRegC400		:=  {}
Local   aRegC405		:=  {}
Local   aRegC410		:=  {}
Local   aRegC420		:=  {}
Local   aRegC425		:=  {}
Local   aRegC460		:=  {}
Local   aRegC470		:=  {}
Local   aRegC490		:=  {}
Local   aRegC495		:=  {}
Local	aRegC500		:=	{}
Local	aRegC510		:=	{}
Local	aRegC590		:=	{}
Local	aRegC600		:=	{}
Local	aRegC601		:=	{}
Local	aRegC610		:=	{}
Local	aRegC690		:=	{}
Local	aRegC700		:=	{}
Local	aRegC790		:=	{}
Local	aRegC791		:=	{}   
Local	aRegD190		:=	{}
Local	aRegD300		:=	{}
Local	aRegD301		:=	{}
Local	aRegD310		:=	{}
Local	aRegD500		:=	{}
Local	aRegD510		:=	{}
Local	aRegD590		:=	{}
Local	aRegD610		:=	{}
Local	aRegD600		:=	{}
Local	aRegD695		:=	{}
Local	aRegD696		:=	{}
Local	aRegD697		:=	{}
Local	aRegE510		:=	{}
Local 	aReg1400		:=	{}
Local   aReg1600        :=  {} // Array para guardar os dados dos cartoes de Credito e Debito para o Bloco 1000 Registro 1600
Local   aReg1700		:=  {}
Local   aReg1710		:=  {}
Local	aRegD690		:=	{}
Local	aReg1010		:=	{}
Local 	aReg1300		:= {}
Local 	aReg1310		:= {}
Local 	aReg1320		:= {}
Local 	aReg1350		:= {}
Local 	aReg1360		:= {}
Local 	aReg1370		:= {}
Local	aLiv1900		:=	{}              
Local aReg0210		:= {}          
Local 	lCondC120		:= .F.        

Local 	lFTPautIPI		:= SFT->(FieldPos("FT_PAUTIPI"))>0     
Local 	lF4ObsSol		:= SF4->(FieldPos("F4_OBSSOL"))>0      
Local 	lFTVALPS3		:= SFT->(FieldPos("FT_VALPS3"))>0
Local 	lFTVALCF3		:= SFT->(FieldPos("FT_VALCF3"))>0    
Local 	lFTDESCZFR		:= SFT->(FieldPos("FT_DESCZFR"))>0        
Local 	lF4MovFis		:= SF4->(FieldPos("F4_MOVFIS"))>0   
Local 	lF4CSOSN		:= SF4->(FieldPos("F4_CSOSN"))>0  
Local 	lFTChvNFe		:= SFT->(FieldPos("FT_CHVNFE"))>0 
Local 	lFTMVALCOF		:= SFT->(FieldPos("FT_MVALCOF"))>0
Local	lPCLLOJA		:=	FindFunction("T_TpPcSped") .And. AliasIndic("LF1")   .AND. AliasIndic("LEG").AND. ;
							AliasIndic("LEJ") .AND. AliasIndic("LEI") .AND. !aExistBloc[07]
Local 	nQtReg0200 		:= 0 //Variavel auxiliar apenas para controlar a quantidde de registros existentes no array "aReg0200"
Local   nKeyCD2         := 1 
Local 	aMVRLCSPD		:= {}
Local lGr2001400    := .F.
Local 	lDUESol			:= DUE->(FieldPos("DUE_CODSOL"))>0  
Local   lRefazInd 		:= .F.


cMVDTINCB1 := If( Left(cMVDTINCB1,1)=="'" .Or. Left(cMVDTINCB1,1)=='"' , &(cMVDTINCB1) , cMVDTINCB1 )

//Legenda de ISS
cAliqISS := cValToChar(SuperGetMv("MV_ALIQISS",,0))
cAliqISS := AllTrim( StrTran(cAliqISS, ",", ".") )
cAliqISS := TransForm(cAliqISS, "@E 99.99")
nAliqIss := Val(SubStr(cAliqISS , 1, At(".", cAliqISS)))
cAliqISS := StrTran(cAliqISS, ".")
cAliqISS := AllTrim(cAliqISS)
If nAliqIss >= 10
	cAliqISS := "S" + PadR(cAliqISS, 4, "0")
Else
	cAliqISS := "S0" + PadR(cAliqISS, 3, "0")
EndIf

//Busca os campos das aliquotas de ICMS e ISS.
SPDFRetAli( @aCmpAliICM, @aCmpAliISS )

If !lIsBahia .OR. (lIsBahia .AND. cVersao >= '008')
	//Executa esta funcao separadamente para carregar Registros 0200 (este tratamento foi feito para melhorar a performance do processamento)
	//SPDFLj0200( cAlias, dDataDe, dDataAte, @aReg0200, @aReg0190, @aReg0220, @nQtReg0200, cFilB1, lConcFil, "C470")
EndIf

//-----------------------------------------
//CAMPOS DA TABELA SFT PARA MONTAR A QUERY
//-----------------------------------------
cQryFields := "SFT.FT_FILIAL,	SFT.FT_TIPOMOV,		SFT.FT_SERIE,	   		SFT.FT_NFISCAL,		SFT.FT_CLIEFOR,		"
cQryFields += "SFT.FT_LOJA,		SFT.FT_ITEM,		SFT.FT_PRODUTO,	   		SFT.FT_ENTRADA,		SFT.FT_NRLIVRO,		"
cQryFields += "SFT.FT_CFOP,		SFT.FT_ESPECIE,		SFT.FT_TIPO,	   		SFT.FT_EMISSAO,		SFT.FT_DTCANC,		"
cQryFields += "SFT.FT_FORMUL, 	SFT.FT_ALIQPIS,		SFT.FT_VALPIS,	   		SFT.FT_ALIQCOF,		SFT.FT_VALCOF,		"
cQryFields += "SFT.FT_VALCONT,	SFT.FT_BASEICM,		SFT.FT_VALICM,			SFT.FT_ISSST,	 	SFT.FT_BASERET,		"
cQryFields += "SFT.FT_ICMSRET,	SFT.FT_VALIPI,		SFT.FT_ISENICM,	   		SFT.FT_QUANT,		SFT.FT_DESCONT,		"
cQryFields += "SFT.FT_TOTAL,	SFT.FT_FRETE,  		SFT.FT_SEGURO,			SFT.FT_DESPESA,		SFT.FT_OUTRICM,		"
cQryFields += "SFT.FT_BASEIPI,	SFT.FT_ISENIPI,		SFT.FT_OUTRIPI,	   		SFT.FT_ICMSCOM,		SFT.FT_RECISS,		"
cQryFields += "SFT.FT_BASEIRR,	SFT.FT_ALIQICM,		SFT.FT_ALIQIPI,	   		SFT.FT_CTIPI,		SFT.FT_POSIPI,		"
cQryFields += "SFT.FT_CLASFIS,	SFT.FT_PRCUNIT,		SFT.FT_CFPS,	   		SFT.FT_ESTADO,		SFT.FT_CODISS,		"
cQryFields += "SFT.FT_ALIQIRR,	SFT.FT_VALIRR,		SFT.FT_BASEINS,			SFT.FT_VALINS,		SFT.FT_PDV,			"
cQryFields += "SFT.FT_ISSSUB,	SFT.FT_CREDST,		SFT.FT_ISENRET,	   		SFT.FT_OUTRRET,		SFT.FT_CONTA,		"
cQryFields += "SFT.FT_BASEPIS,	SFT.FT_BASECOF,		SFT.FT_VALPS3,	   		SFT.FT_VALCF3,		SFT.FT_PESO,	    "
cQryFields += "SFT.FT_SOLTRIB,	SFT.FT_CHVNFE, 		SFT.FT_CSTPIS,	   		SFT.FT_CSTCOF,		SFT.FT_INDNTFR, 	"
cQryFields += "SFT.FT_CODBCC,	SFT.FT_ALIQCF3,  	SFT.FT_VALCF3,	   		SFT.FT_BASEPS3, 	SFT.FT_ENTRADA AS DTMOVTO, "
cQryFields += "SFT.FT_ALIQPS3,  SFT.FT_VALPS3,		SFT.FT_BASECF3, "
If SFT->(FieldPos("FT_RGESPST")) > 0
	cQryFields += "	SFT.FT_RGESPST, "
EndIf

//-----------------------------------------
//CAMPOS DA TABELA SF3 PARA MONTAR A QUERY
//-----------------------------------------
If SF3->(FieldPos("F3_CODRSEF")) > 0
	cQryFields += "	SF3.F3_CODRSEF, "
EndIf

//-----------------------------------------
//CAMPOS DA TABELA SD2 PARA MONTAR A QUERY
//-----------------------------------------
cQryFields += " SD2.D2_SITTRIB, "

//-----------------------------------------
//CAMPOS DA TABELA SB1 PARA MONTAR A QUERY
//-----------------------------------------
cQryFields	+=	"SB1.B1_COD,		SB1.B1_DESC,		SB1.B1_VLR_PIS,		SB1.B1_VLR_COF,		SB1.B1_TNATREC,		"
cQryFields	+=  "SB1.B1_CNATREC, 	SB1.B1_GRPNATR, 	SB1.B1_DTFIMNT,		SB1.B1_TIPO,		SB1.B1_CODBAR,		"
cQryFields	+=  "SB1.B1_CODANT, 	SB1.B1_UM, 			SB1.B1_POSIPI,		SB1.B1_EX_NCM,		SB1.B1_CODISS,		"
cQryFields	+=  "SB1.B1_PICM, 		SB1.B1_FECP, 		SB1.B1_DATREF,		SB1.B1_TIPCONV, "
If !Empty(cMVDTINCB1) .And. cMVDTINCB1 <> "B1_DATREF" .And. !(cMVDTINCB1 $ cQryFields)
	cQryFields	+=  "SB1."+cMVDTINCB1+", "
	aAdd( aSetField, { cMVDTINCB1, "D" , 8, 0 } )
EndIf

//-----------------------------------------
//CAMPOS DA TABELA SB0 PARA MONTAR A QUERY
//-----------------------------------------
cQryFields	+=	"SB0.B0_ALIQRED, "

//-----------------------------------------
//CAMPOS DA TABELA SFI PARA MONTAR A QUERY
//-----------------------------------------
cQryFields += " SFI.FI_PDV, 		SFI.FI_DTMOVTO, 	SFI.FI_DESC,  		SFI.FI_SERPDV, 		SFI.FI_VALCON, 		"
cQryFields += "	SFI.FI_COO, 		SFI.FI_CRO, 		SFI.FI_NUMREDZ, 	SFI.FI_NUMFIM, 		SFI.FI_GTFINAL, 	"
cQryFields += "	SFI.FI_ISS, 		SFI.FI_CANCEL, 		SFI.FI_SUBTRIB, 	SFI.FI_ISENTO, 		SFI.FI_NTRIB, 		"
//Acrescenta os campos de tributacao de ICMS (Ex: FI_BAS7, FI_BAS12, FI_BAS18...)
For nY:=1 to Len(aCmpAliICM)
	cQryFields += "SFI." + aCmpAliICM[nY][1] + ", "
	If !Empty(aCmpAliICM[nY][2])
		cQryFields += "SFI." + aCmpAliICM[nY][2] + ", "
	EndIf
Next nY

//Acrescenta os campos de tributacao de ISS (Ex: FI_BIS0300, FI_BIS0500, FI_BIS0700...)
For nY:=1 to Len(aCmpAliISS)
	cQryFields += "SFI." + aCmpAliISS[nY][1] + ", "
	If !Empty(aCmpAliISS[nY][2])
		cQryFields += "SFI." + aCmpAliISS[nY][2] + ", "
	EndIf
Next nY

//-----------------------------------------
//CAMPOS DA TABELA SLG PARA MONTAR A QUERY
//-----------------------------------------
cQryFields += " SLG.LG_SERPDV, SLG.LG_IMPFISC, SLG.LG_PDV,  "

//-----------------------------------------
//CAMPOS DA TABELA SL1 PARA MONTAR A QUERY
//-----------------------------------------
If SL1->( FieldPos("L1_CGCCLI") ) > 0
	cQryFields += " L1_CGCCLI,  "
Else
	cQryFields += " '" + Space(11) + "' AS L1_CGCCLI,  "
EndIf

//-----------------------------------------
//CAMPOS (Sub-Query) Tabela SLX
//-----------------------------------------
cQryFields += " 		(SELECT SUM(LX_QTDE) "
cQryFields += " 		 FROM  " + RetSQLName("SLX") + " SLX "
cQryFields += " 		 WHERE 	SLX.LX_FILIAL 	= SFT.FT_FILIAL  AND "
cQryFields += " 		 		SLX.LX_PDV 		= SFT.FT_PDV 	 AND "
cQryFields += " 		 		SLX.LX_CUPOM 	= SFT.FT_NFISCAL AND "
cQryFields += " 		 		SLX.LX_SERIE 	= SFT.FT_SERIE 	 AND "
cQryFields += " 		 		SLX.LX_DTMOVTO	= SFT.FT_EMISSAO AND "
cQryFields += " 		 		SLX.LX_PRODUTO  = SFT.FT_PRODUTO AND "
cQryFields += " 		 		SLX.LX_ITEM		= SFT.FT_ITEM    AND "
cQryFields += "			    SLX.D_E_L_E_T_ =  ' ' ) AS LX_QTDCANC "
cQryFields	:=	"%"+cQryFields+"%"

cOrderBy  := "%ORDER BY SFI.FI_PDV, SFI.FI_DTMOVTO, SFT.FT_NFISCAL,  SFT.FT_SERIE, SFT.FT_ITEM  %"
      
dDataDe:=Ctod("01/07/2015")
dDataAte:=Ctod("27/07/2015")

cFiltro := "%"
//If cNrLivro <> "*"
//	cFiltro += " SFT.FT_NRLIVRO = '" +%Exp:(cNrLivro)% +"' AND "
//EndIf
cFiltro += "%"

BeginSql Alias cQryAlias

		COLUMN FT_EMISSAO 	AS DATE
    	COLUMN FT_ENTRADA 	AS DATE
    	COLUMN FT_DTCANC 	AS DATE
    	COLUMN FI_DTMOVTO 	AS DATE
    	COLUMN B1_DATREF 	AS DATE	
	SELECT 
		%Exp:cQryFields% 
	FROM 
		%Table:SFT% SFT 
		JOIN %Table:SFI% SFI ON (SFI.FI_FILIAL=%xFilial:SFI% AND SFI.FI_PDV=SFT.FT_PDV AND SFI.FI_DTMOVTO=SFT.FT_ENTRADA AND SFI.%NotDel%)
		JOIN %Table:SLG% SLG ON (SLG.LG_FILIAL=%xFilial:SLG% AND SLG.LG_PDV=SFT.FT_PDV AND SLG.%NotDel%)
		LEFT JOIN %Table:SB1% SB1 ON(SB1.B1_FILIAL=%xFilial:SB1%  AND SB1.B1_COD=SFT.FT_PRODUTO AND SB1.%NotDel%) 
		LEFT JOIN %Table:SB0% SB0 ON(SB0.B0_FILIAL=%xFilial:SB0%  AND SB0.B0_COD=SFT.FT_PRODUTO AND SB0.%NotDel%) 
		LEFT JOIN %Table:SD2% SD2 ON(SD2.D2_FILIAL=%xFilial:SD2%  AND SD2.D2_DOC=SFT.FT_NFISCAL AND SD2.D2_SERIE=SFT.FT_SERIE AND SD2.D2_CLIENTE=SFT.FT_CLIEFOR AND SD2.D2_LOJA=SFT.FT_LOJA AND SD2.D2_COD=SFT.FT_PRODUTO AND SD2.D2_ITEM=SFT.FT_ITEM AND SD2.D2_PDV=SFT.FT_PDV AND SD2.%NotDel%)
		LEFT JOIN %Table:SF3% SF3 ON(SF3.F3_FILIAL=%xFilial:SF3%  AND SF3.F3_ENTRADA=SFT.FT_ENTRADA AND SF3.F3_NFISCAL=SFT.FT_NFISCAL AND SF3.F3_SERIE=SFT.FT_SERIE AND SF3.F3_CLIEFOR=SFT.FT_CLIEFOR AND SF3.F3_LOJA=SFT.FT_LOJA AND SF3.F3_CFO=SFT.FT_CFOP AND SF3.F3_ALIQICM=SFT.FT_ALIQICM AND SF3.F3_PDV=SFT.FT_PDV AND SF3.F3_IDENTFT=SFT.FT_IDENTF3 AND SF3.%NotDel%)
		LEFT JOIN %Table:SL1% SL1 ON(SL1.L1_FILIAL=%xFilial:SL1%  AND SL1.L1_DOC=SFT.FT_NFISCAL AND SL1.L1_SERIE=SFT.FT_SERIE AND SL1.L1_CLIENTE=SFT.FT_CLIEFOR AND SL1.L1_LOJA=SFT.FT_LOJA AND SL1.%NotDel%)
	WHERE 
		SFT.FT_FILIAL=%xFilial:SFT% 		 	AND
		SFT.FT_TIPOMOV = 'S' 					AND
		SFT.FT_ENTRADA >= %Exp:DToS(dDataDe)% 	AND
		SFT.FT_ENTRADA <= %Exp:DToS(dDataAte)%  AND
		SFT.FT_ESPECIE = 'CF' 					AND
		%Exp:cFiltro%
		SFT.%NotDel%
		
	%Exp:cOrderBy%

EndSql
For nY := 1 To Len(aSetField)
	TcSetField(cQryAlias,aSetField[nY,1],aSetField[nY,2],aSetField[nY,3],aSetField[nY,4])
Next nY

//---------------------
// Processa Registros.
//---------------------
Do While !(cQryAlias)->(Eof())
	
    cPDV :=  (cQryAlias)->FT_PDV
    
    
	RegC400 (@aRegC400, (cQryAlias)->LG_IMPFISC, (cQryAlias)->LG_SERPDV, AllTrim((cQryAlias)->LG_PDV), @nPos400)
	
	//----------------------------
	// Laco por PDV
	//----------------------------
	While !(cQryAlias)->(Eof()) .AND. cPDV==(cQryAlias)->FT_PDV
		
		sDTMOVTO 	:= (cQryAlias)->DTMOVTO
		cChave 		:= cPDV + sDTMOVTO
		
		nVlBrtLj 	:= ( (cQryAlias)->FI_VALCON + (cQryAlias)->FI_ISS ) // Valor Bruto, FI_VALCON (Valor contabil) + FI_ISS (Valor de Servicos)
		
		RegC405 (@aRegC405				, nPos400				, (cQryAlias)->FI_DTMOVTO	, (cQryAlias)->FI_CRO	, ;
				(cQryAlias)->FI_NUMREDZ	, (cQryAlias)->FI_NUMFIM, (cQryAlias)->FI_GTFINAL	, nVlBrtLj   			, ;
				@nPos405				, (cQryAlias)->FI_DESC  , (cQryAlias)->FI_CANCEL)
		
		//Reinicia variaveis
		nValCof 	:= 0
		nValPis 	:= 0
		aAuxReg 	:= {}
		cNfC460		:= ""
		aItensC470  := {}
		
		//--------------------------------------------------------------------
		// Carrego todos os codigos e valores que foram contabilizados no SFI
		//--------------------------------------------------------------------
		aTotaliz 	:= SPDFTotSFI(.T., cAliqISS, cQryAlias, aCmpAliICM, Nil, aCmpAliISS)
		
		RegC420 (@aRegC420, 	nPos405,   	(cQryAlias)->FI_CRO, 		(cQryAlias)->FI_NUMREDZ,	 aTotaliz,		@aPos420)
		
		//-------------------------------------------
		// Laco por Reducao Z - Por data do Movimento
		//-------------------------------------------
		While !(cQryAlias)->(Eof())  .AND.  cChave == (cQryAlias)->FT_PDV+(cQryAlias)->DTMOVTO
	   		
	   		lCancSft := !Empty((cQryAlias)->FT_DTCANC) //Verifica se esta cancelado
	   		
			If !lIsBahia .OR. (lIsBahia .AND. cVersao >= '008')
				SPDFC460470(@aRegC460	, @aRegC470		, (cQryAlias)->FI_DTMOVTO	, (cQryAlias)->FI_PDV	,;
							@aProdB1 	, nPos405		, @aReg0200					, lCstPis				,;
					        lCstCof	   	, aWizard 		, nQuantD 					, cQryAlias   			,;
					        cFilB1	 	, cFilSA1  		, lCancSft					, @nPosC460				,;
					        @cNfC460 	, @aItensC470 	, @nPosC470					, lConcFil 				,;
					        cConfFil 	, @aInfPart		, @cCpfCNPJ					, @cChvCliAnt )
			EndIf
	   		
	  		(cQryAlias)->(dbSkip())
		EndDo
		
		
		SPDFRgC490 (@aRegC490	, sDTMOVTO		, nPos405  		, lCstPis	,;
				 	lCstCof  	, cPDV			, @aProdB1		, nPos405	,;
				 	@aReg0200	, @aReg0190 	, @aReg0220 	, @nValCof	,;
				 	@nValPis	)
		
		
		If lGer410 //Depois de ter os valores de PIS e COFINS gera o C410
			RegC410 (  @aRegC410	   	, nPos405 	, nValCof 	, nValPis  ,;
					   Nil 				, Nil 		, lTop )
		EndIf
		
	EndDo
	
	If lIsBahia .AND. cVersao < '008'
		//O Registro C495 somente deve ser gerado, caso tenha gerado tambem o Registro C400
		RegC495 (@aRegC495	, @aProdB1			, nPos400	, dDataDe	,;
				 dDataAte	, AllTrim(cPDV)		, @aReg0200	, cAlias 	,;
				 @aReg0190 	, @aReg0220 		, @aSLX 	, cFilB1)
	EndIf		
EndDo

DbSelectArea(cQryAlias)
(cQryAlias)->(DbCloseArea())

If "1"$aWizard[5][7]//Verifica se deve gerar registro 1600
	SPDFGr1600(@aReg1600,@aReg0150,dDataDe,dDataAte,cAlias,aWizard,Nil,lConcFil)
EndIf

Return

