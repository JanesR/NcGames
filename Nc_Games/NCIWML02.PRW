#Include "PROTHEUS.CH "
Static cArmazem
Static cProdRefaz
//If !Empty(cTpOper)
//			cTES := MaTESInt(2,cTpOper,ME1->ME1_CODCLI,ME1->ME1_LOJCLI,"C",SD2->D2_COD)
//		Else
//			cTES := cTESPad
//		EndIf
//EndIf
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWML02()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWML02()
Processa({|| ExecBlock("WML02GERAR") }, " Gera Movimento Fiscal ", "Interface de Dados")
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02Gerar()
Local aAreaAtu		:=GetArea()
Local cQryAlias	:=GetNextAlias()
Local aDados		:={}
Local cModo			:=""
Local cEmpPZQ
Local cFilPZQ
Local nInd
Local nYnd
Local aConexoes
Local aDadosAux
Local nContar
Local lWait
Local cAliasPZQ
Local cTbPZQ		:= "%PZQ010 " + "PZQ%"
Local cModo

cAliasPZQ	:=GetNextAlias()
EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)

BeginSQL Alias cQryAlias
	SELECT PZQ.R_E_C_N_O_ RecPZQ,PZQ.PZQ_EMPDES,PZQ.PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT=' '
	AND PZQ.PZQ_OPER IN ('TRD','CDU')
	AND PZQ.%notDel%
	//AND PZQ_CODMOV='X85755XXX'
	
	UNION ALL
	
	SELECT PZQ.R_E_C_N_O_ RecPZQ,PZQ.PZQ_EMPOTL AS PZQ_EMPDES,PZQ.PZQ_FILOTL AS PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT=' '
	AND PZQ.PZQ_OPER IN ('TLS')
	AND PZQ.%notDel%
	//AND PZQ_CODMOV in ('86121','86134','86138')
	
	ORDER BY PZQ_EMPDES,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
EndSQL

ProcRegua(2)

Do While (cQryAlias)->(!Eof())
	
	cEmpPZQ:=(cQryAlias)->PZQ_EMPDES
	cFilPZQ:=(cQryAlias)->PZQ_FILDES
	
	If Empty(cEmpPZQ) .Or. Empty(cFilPZQ)
		(cAliasPZQ)->(DbGoTo( 		(cQryAlias)->RecPZQ   ))
		U_WML03ERRO(cAliasPZQ,"Nao foi possivel identificar a Empresa ["+cEmpPZQ+"] e Filial ["+cFilPZQ+"]","E")
		(cQryAlias)->(DbSkip());Loop
	EndIf
	
	AADD(aDados,{ {cEmpPZQ,cFilPZQ},{} } )
	aDadosAux:=aDados[Len(aDados),2]
	
	Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->PZQ_EMPDES==cEmpPZQ .And. (cQryAlias)->PZQ_FILDES==cFilPZQ
		AADD(aDadosAux,(cQryAlias)->RecPZQ)
		(cQryAlias)->(DbSkip())
	EndDo
	
EndDo
(cQryAlias)->(DbCloseArea())


For nInd:=1 To Len(aDados)
	aDadosAux:=aDados[nInd]
	//aConexoes:=GetUserInfoArray()
	//nContar:=0
	//AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML02GRAVAR" ),nContar++, )   }  )
	//	StartJob( "U_WML02Gravar",GetEnvServer(), .T., aDadosAux)
	U_WML02Gravar(aDadosAux)
Next

//Entrada da Transferecnia e Devolucoes

cAliasPZQ	:=GetNextAlias()
EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)


BeginSQL Alias cQryAlias
	SELECT PZQ.R_E_C_N_O_ RecPZQ,PZQ.PZQ_EMPDTL,PZQ_EMPDES,PZQ.PZQ_FILDTL,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV,PZQ_OPER, PZQ_EMPOTL, PZQ_FILOTL
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT=' '
	AND PZQ.PZQ_OPER IN ('TLE','DV')
	AND PZQ.%notDel%
	ORDER BY PZQ_EMPDES,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
EndSQL

ProcRegua(2)

aDados:={}
Do While (cQryAlias)->(!Eof())
	
	cEmpPZQ:=(cQryAlias)->PZQ_EMPDES
	cFilPZQ:=(cQryAlias)->PZQ_FILDES
	
	If Empty(cEmpPZQ) .Or. Empty(cFilPZQ)
		(cAliasPZQ)->(DbGoTo( 		(cQryAlias)->RecPZQ   ))
		U_WML03ERRO(cAliasPZQ,"Nao foi possivel identificar a Empresa ["+cEmpPZQ+"] e Filial ["+cFilPZQ+"]","E")
		(cQryAlias)->(DbSkip());Loop
	EndIf
	
	If (cQryAlias)->PZQ_OPER=="TLE"
		
		cEmpPZQ:=(cQryAlias)->PZQ_EMPDTL
		cFilPZQ:=(cQryAlias)->PZQ_FILDTL
		nAscan:=Ascan(aDados,{|a| a[1][1]+a[1][2]==(cQryAlias)->(PZQ_EMPOTL+PZQ_FILOTL) })
		If nAscan==0
			AADD(aDados,{ {(cQryAlias)->PZQ_EMPOTL,(cQryAlias)->PZQ_FILOTL},{} } )
			nAscan:=Len(aDados)
		EndIf
		
		aDadosAux:=aDados[nAscan,2]
		
		AADD(aDadosAux,(cQryAlias)->RecPZQ)
		(cQryAlias)->(DbSkip())
		
	Else
		
		AADD(aDados,{ {cEmpPZQ,cFilPZQ},{} } )
		aDadosAux:=aDados[Len(aDados),2]
		
		Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->PZQ_EMPDES==cEmpPZQ .And. (cQryAlias)->PZQ_FILDES==cFilPZQ
			AADD(aDadosAux,(cQryAlias)->RecPZQ)
			(cQryAlias)->(DbSkip())
		EndDo
	EndIf
	
EndDo

(cQryAlias)->(DbCloseArea())
For nInd:=1 To Len(aDados)
	aDadosAux:=aDados[nInd]
	//aConexoes:=GetUserInfoArray()
	//nContar:=0
	//AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML02GRAVAR" ),nContar++, )   }  )
	//StartJob( "U_WML02Gravar",GetEnvServer(), .T., aDadosAux)
	U_WML02Gravar(aDadosAux)
Next

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02Gravar(aDados)
Local cModo
Local cAliasPZQ
Local cAliasPZR
Local cChavePZR
Local aRecnos:=aDados[2]
Local aItensAux
Local aCabec
Local aItens
Local nLenD2Item
Local nItemSD2
Local nItemSD1
Local cChave

Local cPDV
Local cChaveDOC
Local cChaveSFT
Local aProdutos:={}
Local lMovSaida
Local aParam:={}
Local nTam     := 0
Local cCliForn
Local cLojaCliFor
Local cProduto

Local cEspec
Local cSerie
Local dDtMenor:=""
Local dDtMaior:=""
Local nYnd
Local nXnd
Local nLenD2Item
Local nLenD1Item
Local nLenB1Cod
Local cCodWMMov
Local cCodWMLoja
Local cTESVenda
Local aNfeOrig
Local lTransf
Local dDataAtu
Local lDevolucao
Local lEntreEmp
Local cCodVend
Local lCancelar
Local aVenc
Local nVlrBrut
Local cCond
Local nXnd
Local lDuplic
Local nRecSF2
Local cMv1Dupref
Local cNatureza
Local cPrefixo
Local cErroAdici
Local cCodMovVen:=""
Local nPosNf	:= 0
Local nPosSer	:= 0
Local cProdNEnc	:= ""//Produto nใo encontrado
Local cLocalPad

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1,1],aDados[1,2])

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML02JOB", "Grava็ใo das Notas Fiscais das Opera็๕es TRD,CDU,TLS,TLE e DV", "FISCAL", MsDate() )

cAliasPZQ	:=GetNextAlias()
cAliasPZR	:=GetNextAlias()
cAliasPZY	:=GetNextAlias()

nLenD2Item	:=AvSx3("D2_ITEM",3)
nLenD1Item	:=AvSx3("D1_ITEM",3)
nLenB1Cod	:=AvSx3("B1_COD",3)

dDataAtu		:=dDataBase

EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)
EmpOpenFile(cAliasPZR,"PZR",2,.T.,"01",@cModo)
EmpOpenFile(cAliasPZY,"PZY",1,.T.,"01",@cModo)


ChkFile("SD1")
ChkFile("SD2")
ChkFile("SD3")

cMv1Dupref := GetMv("MV_1DUPREF")
cMV1DUPNAT := GetMv("MV_1DUPNAT")
For nYnd:=1 To Len(aRecnos)
	
	
	(cAliasPZQ)->(DbGoTo(aRecnos[nYnd]))
	
	cChavePZR:=(cAliasPZQ)->(PZQ_FILIAL+PZQ_OPER+PZQ_CODMOV)//PZR_FILIAL+PZR_OPER+PZR_CODMOV+PZR_SEQ
	(cAliasPZR)->(MsSeek(cChavePZR))
	cCodWMMov	:=(cAliasPZQ)->PZQ_CODMOV
	cCodWMLoja	:=(cAliasPZQ)->PZQ_CODLOJ
	
	
	cCodMovVen:=""
	cPDV:=(cAliasPZR)->PZR_TERMIN
	If !Empty((cAliasPZR)->PZR_ORIVEN)
		cCodMovVen:=(cAliasPZR)->PZR_ORIVEN
	EndIf
	PtInternal(1,"Empresa: "+cEmpAnt+" Filial: "+cFilAnt+" - "+(cAliasPZR)->PZR_DOC+" Emissao: "+DTOC((cAliasPZQ)->PZQ_EMISSA)+" Operacao:"+(cAliasPZQ)->PZQ_OPER+" Movimento:"+(cAliasPZQ)->PZQ_CODMOV  )
	
	cCliForn 	:= ""
	cLojaCliFor	:= ""
	
	lMovSaida	:=(cAliasPZQ)->PZQ_OPER$"TLS*CA "
	lTransf		:="TL"$(cAliasPZQ)->PZQ_OPER
	lDevolucao	:=(cAliasPZQ)->PZQ_OPER$"DV *TRD"
	lEntreEmp	:=.F.
	
	If !MWL02ValChave(lMovSaida,cCodWMMov,cCodWMLoja,cAliasPZQ)
		U_MySndMail("Chave Duplicada", "Duplicidade Movimento "+cCodWMMov, , "", , )
		Loop
	EndIf
	
	If lTransf
		If Alltrim((cAliasPZQ)->PZQ_OPER) == "TLE"
			lMovSaida	:= ( cFilAnt==(cAliasPZQ)->PZQ_FILDTL .And. cEmpAnt==(cAliasPZQ)->PZQ_EMPDTL )
			lEntreEmp	:=(cAliasPZQ)->PZQ_EMPOTL<>(cAliasPZQ)->PZQ_EMPDTL
		Else
			lMovSaida	:= ( cFilAnt==(cAliasPZQ)->PZQ_FILOTL .And. cEmpAnt==(cAliasPZQ)->PZQ_EMPOTL )
			lEntreEmp	:=(cAliasPZQ)->PZQ_EMPOTL<>(cAliasPZQ)->PZQ_EMPDTL
		EndIf
	EndIf
	
	If !U_WML02CliFor(@cCliForn,@cLojaCliFor,cAliasPZR,cAliasPZQ,lMovSaida,lTransf,lDevolucao)//PZR deve estar posicionado
		Loop
	EndIf
	
	cCodVend:=U_WML02Vend(cAliasPZR,cAliasPZQ)
	
	If Empty(dDtMenor)
		dDtMenor:=(cAliasPZQ)->PZQ_EMISSA
	EndIf
	
	If Empty(dDtMaior)
		dDtMaior:=(cAliasPZQ)->PZQ_EMISSA
	EndIf
	
	dDtMenor:= Min( (cAliasPZQ)->PZQ_EMISSA,dDtMenor  )
	dDtMaior:= Max( (cAliasPZQ)->PZQ_EMISSA,dDtMaior  )
	
	aItens:={}
	nItemSD2:=0
	nItemSD1:=0
	dDataBase:=GetDtEmiss((cAliasPZQ)->PZQ_EMISSA)//(cAliasPZQ)->PZQ_EMISSA
	cErroAdici:=""
	
	If Empty(cCliForn)
		cErroAdici+="Cliente/Fornecedor nใo vazio."
	EndIf
	
	cProdNEnc	:= ""
	Do While (cAliasPZR)->(!Eof()) .And. (cAliasPZR)->(PZR_FILIAL+PZR_OPER+PZR_CODMOV)==cChavePZR
		
		cProduto:=Padr( (cAliasPZR)->PZR_PRODUT,nLenB1Cod)
		aItensAux := {}
		
		If !SB1->(MsSeek(xFilial("SB1")+cProduto  ))
			cErroAdici 	+= " Produto "+cProduto+" nao encontrado."+CRLF
			cProdNEnc 	+= cProduto+CRLF
		EndIf
		
		If !SB2->(DbSeek(xFilial("SB2")+cProduto+"01"))
			CriaSB2(cProduto,"01")
		EndIf
		
		nVlrProd:=(cAliasPZR)->PZR_VALOR
		
		If lMovSaida
			
			cTESVenda:="783"
			If (cAliasPZR)->PZR_ALICMS==-2.00
				cTESVenda:="633"
			EndIf
			
			If lTransf
				cTESVenda:="546"
				If (cAliasPZR)->PZR_ALICMS==-2.00
					cTESVenda:="792"
				EndIf
			EndIf
			
			If lEntreEmp  //Venda
				cTESVenda:="578"
				If (cAliasPZR)->PZR_ALICMS==-2.00
					cTESVenda:="574"
				EndIf
			EndIf
			
			//If nVlrProd==0
			//nVlrProd:=SB2->B2_CM1
			//EndIf
			
			L02VlrProd(@nVlrProd,cAliasPZR,cProduto,"S")
			
			If nVlrProd == 0
				//nVlrProd:=1
				cErroAdici 	+= " Produto "+ ALLTRIM(cProduto) + " com valor zero."+CRLF
			EndIf
			
			
			lDuplic:=AvalTes(cTESVenda ,/*cEstoq*/,"S")
			
			aadd(aItensAux,{"D2_ITEM"	,StrZero(++nItemSD2,nLenD2Item)			,Nil})
			AADD(aItensAux,{"D2_COD"	,cProduto								,Nil})
			AADD(aItensAux,{"D2_LOCAL"	,"01"								,Nil})
			AADD(aItensAux,{"D2_QUANT"	,(cAliasPZR)->PZR_QTD				,Nil})
			AADD(aItensAux,{"D2_PRCVEN",nVlrProd				,Nil})
			AADD(aItensAux,{"D2_TOTAL"	,nVlrProd*(cAliasPZR)->PZR_QTD,Nil})
			AADD(aItensAux,{"D2_TES"	,cTESVenda							,Nil})
			AADD(aItensAux,{"D2_PDV"	,(cAliasPZR)->PZR_TERMIN			,Nil})
		Else
			
			nVlrProd:=(cAliasPZR)->PZR_VALOR
			If nVlrProd==0
				nVlrProd:=SB2->B2_CM1
			EndIf
			
			If nVlrProd==0
				cErroAdici 	+= " Produto "+ ALLTRIM(cProduto) +" com valor zero."+CRLF
			EndIf
			cLocalPad:="01"
			
			If (cAliasPZR)->PZR_LJDEST=="3001"
				cLocalPad:="90"
				If !SB2->(DbSeek(xFilial("SB2")+cProduto+"90"))
					CriaSB2(cProduto,"90")
				EndIf
			EndIf
			                                            
			L02VlrProd(@nVlrProd,cAliasPZR,cProduto,"E")
			aadd(aItensAux,{"D1_ITEM"	,StrZero(++nItemSD1,nLenD1Item)			,Nil})
			AADD(aItensAux,{"D1_COD"	,cProduto										,Nil})
			AADD(aItensAux,{"D1_LOCAL"	,cLocalPad												,Nil})
			AADD(aItensAux,{"D1_QUANT"	,(cAliasPZR)->PZR_QTD						,Nil})
			AADD(aItensAux,{"D1_VUNIT"	,nVlrProd						,Nil})
			AADD(aItensAux,{"D1_TOTAL"	,nVlrProd*(cAliasPZR)->PZR_QTD	   ,Nil})
			
			
			If lDevolucao
				aNfeOrig:={}
				If (cAliasPZQ)->PZQ_OPER=="TRD"
					aNfeOrig:=GetCupom((cAliasPZR)->PZR_ORIVEN, (cAliasPZQ)->PZQ_CODLOJ ,cAliasPZY)
				Else
					aNfeOrig:=GetNFSaida((cAliasPZR)->PZR_ORIVEN, cProduto )
				EndIf
				
				If !Empty(aNfeOrig[1])
					AADD(aItensAux,{"D1_NFORI"	,aNfeOrig[1]								,Nil})
				EndIf
				
				If !Empty(aNfeOrig[2])
					AADD(aItensAux,{"D1_SERIORI"	,aNfeOrig[2]								,Nil})
				EndIf
				
				If !Empty(aNfeOrig[3])
					AADD(aItensAux,{"D1_ITEMORI"	,aNfeOrig[3]								,Nil})
				EndIf
			EndIf
			
		EndIf
		AADD(aItens, aItensAux)
		(cAliasPZR)->(DbSkip())
	EndDo
	
	(cAliasPZR)->(MsSeek(cChavePZR))
	aCabec:={}
	
	
	If lMovSaida
		cNfSerie	:=	"1"
		
		AADD(aCabec,{"F2_TIPO"   	,"N"										})
		AADD(aCabec,{"F2_FORMUL" 	," "										})
		AADD(aCabec,{"F2_DOC"    	,"XXXXXXXXX"			  				})
		AADD(aCabec,{"F2_SERIE"  	,cNfSerie								})//(cAliasPZR)->PZR_SERIE
		AADD(aCabec,{"F2_EMISSAO"	,GetDtEmiss((cAliasPZQ)->PZQ_EMISSA)			})
		AADD(aCabec,{"F2_CLIENTE"	,cCliForn								})
		AADD(aCabec,{"F2_LOJA"   	,cLojaCliFor								})
		AADD(aCabec,{"F2_COND"		,"026"									})
		AADD(aCabec,{"F2_VEND1"		,cCodVend   							})
		
		AADD(aCabec,{"F2_ESPECIE"	, "SPED"	})
		AADD(aCabec,{"F2_DESCONT"	,0											})
		AADD(aCabec,{"F2_DESPESA"	,0											})
		AADD(aCabec,{"F2_FRETE"		,0											})
		AADD(aCabec,{"F2_SEGURO"	,0											})
		
		AADD(aCabec,{"F2_PDV"		,(cAliasPZR)->PZR_TERMIN			})
		AADD(aCabec,{"F2_ECF"		,(cAliasPZR)->PZR_NUMECF			})
		AADD(aCabec,{"F2_CHVNFE"	,(cAliasPZR)->PZR_CHVACE			})
		
		cNFiscalF2:=""
		
		
		//Efetua a simula็ใo da NF
		If Empty(cErroAdici)
			cErroAdici :=  NCVLDNFWM(lMovSaida, aCabec, aItens, 3)
		EndIf
		
		//Senใo houve erro na simula็ใo, serแ utilizado a numera็ใo correta da NF.
		//Obs. Procedimento utilizado para evitar a perda de numera็ใo no caso de formulario proprio
		If Empty(cErroAdici)
			cNFiscalF2:=GetNota(cNfSerie)
			nPosNf 		:= Ascan( aCabec, { |x| UPPER( AllTrim( x[1] ) ) == "F2_DOC" } )
			aCabec[nPosNf][2] := cNFiscalF2//Altera para a numera็ใo correta da NF
		EndIf
		
		
	Else
		
		If lTransf
			cFormul 		:="N"
			cNfSerie		:="1"
		Else
			cNfSerie		:="1"
			cFormul 		:="S"
		EndIf
		
		
		AADD(aCabec,{"F1_TIPO"   	,IIf(lDevolucao,"D","N")})
		AADD(aCabec,{"F1_FORMUL" 	,cFormul								})
		AADD(aCabec,{"F1_DOC"    	,"XXXXXXXXX"  				})
		AADD(aCabec,{"F1_SERIE"  	,cNfSerie				})//(cAliasPZR)->PZR_SERIE
		AADD(aCabec,{"F1_EMISSAO"	,GetDtEmiss((cAliasPZQ)->PZQ_EMISSA)			})
		AADD(aCabec,{"F1_FORNECE"	,cCliForn								})
		AADD(aCabec,{"F1_LOJA"   	,cLojaCliFor								})
		AADD(aCabec,{"F1_COND"		,"001"									})
		AADD(aCabec,{"F1_ESPECIE"	,"SPED"	})
		AADD(aCabec,{"F1_DESCONT"	,0											})
		AADD(aCabec,{"F1_DESPESA"	,0											})
		AADD(aCabec,{"F1_FRETE"		,0											})
		AADD(aCabec,{"F1_SEGURO"	,0											})
		AADD(aCabec,{"F1_YCODMOV"   ,(cAliasPZQ)->PZQ_CODMOV			})
		AADD(aCabec,{"F1_YLOJAWM"   ,(cAliasPZQ)->PZQ_CODLOJ			})
		AADD(aCabec,{"F1_YTOPER"   , (cAliasPZQ)->PZQ_OPER			})
		AADD(aCabec,{"F1_CHVNFE"	,(cAliasPZR)->PZR_CHVACE			})
		
		//Efetua a simula็ใo da NF
		If Empty(cErroAdici)
			cErroAdici :=  NCVLDNFWM(lMovSaida, aCabec, aItens, 3)
		EndIf
		
		//Senใo houve erro na simula็ใo, serแ utilizado a numera็ใo correta da NF.
		//Obs. Procedimento utilizado para evitar a perda de numera็ใo no caso de formulario proprio
		If Empty(cErroAdici)
			cNfSerie		:=Padr("1",Len(SF1->F1_SERIE))
			cNFiscalF1	:=Padr("",Len(SF1->F1_DOC))
			
			If lTransf
				GetNfeTLS(@cNfSerie,@cNFiscalF1,(cAliasPZQ)->PZQ_EMPOTL,AllTrim((cAliasPZQ)->PZQ_FILOTL),(cAliasPZQ)->PZQ_CODMOV)
				If Empty(cNFiscalF1)
					U_WML03ERRO(cAliasPZQ,"Nota de Saida nao encontrada","E")
					Loop
				EndIf
				
				nPosNf 				:= Ascan( aCabec, { |x| UPPER( AllTrim( x[1] ) ) == "F1_DOC" } )
				nPosSer				:= Ascan( aCabec, { |x| UPPER( AllTrim( x[1] ) ) == "F1_SERIE" } )
				aCabec[nPosNf][2] := cNFiscalF1//Altera para a numera็ใo correta da NF
				aCabec[nPosSer][2]:= cNfSerie
				
			Else
				cNFiscalF1	:= GetNota(cNfSerie)
				nPosNf 		:= Ascan( aCabec, { |x| UPPER( AllTrim( x[1] ) ) == "F1_DOC" } )
				aCabec[nPosNf][2] := cNFiscalF1//Altera para a numera็ใo correta da NF
			EndIf
			
		EndIf
	EndIf
	
	
	Begin TransAction
	
	If !Empty(cErroAdici)
		lMsErroAuto:=.T.
		
		//Envia e-mail para cadastrar produto
		If !Empty(cProdNEnc)
			u_NCCadPrd(cProdNEnc)
		EndIf
		
	Else
		lMsErroAuto := .F.
		If lMovSaida
			MATA920(aCabec,aItens)
		Else
			MATA140(aCabec,aItens)
		EndIf
	EndIf
	
	If lMsErroAuto
		cFileLog:=NomeAutoLog()
		cErroLog:="Erro nao identificado."
		If ValType(cFileLog)<>"U"
			cErroLog:=MemoRead(cFileLog)
			MostraErro('cPath',cFileLog)//Apagar o arquivo atual
		EndIf
		
		DisarmTransaction()
		U_WML03ERRO(cAliasPZQ,IIf(!Empty(cErroAdici),cErroAdici,cErroLog),"E")			// Gravar Msg de Erro
	ElseIf lMovSaida
		(cAliasPZQ)->(DbGoTo(aRecnos[nYnd]))
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_TPOPER:="S"
		(cAliasPZQ)->PZQ_DOCPRT:=cNFiscalF2
		(cAliasPZQ)->PZQ_SERPRT:=cNfSerie
		(cAliasPZQ)->PZQ_STATUS := ""
		(cAliasPZQ)->(MsUnLock())
		
		cChaveDOC:=(cAliasPZQ)->(PZQ_DOCPRT+PZQ_SERPRT)+cCliForn+cLojaCliFor
		cChave	:=xFilial("SF2")+cChaveDOC
		
		SF2->(DbSetOrder(1)) //F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO
		
		If SF2->(MsSeek(cChave))
			
			If lDuplic
				aVenc	:= SF2->(Condicao(SF2->F2_VALBRUT,"026",,dDataBase))
				cParcela:="0"
				For nYnd:=1 To Len(aVenc)
					aTitulo:={}
					cParcela:=Soma1(cParcela)
					SA1->(MsSeek(xFilial('SA1') +SF2->F2_CLIENTE+SF2->F2_LOJA ))
					
					cPrefixo		:=&(cMV1DUPREF)
					cNatureza	:=&(cMV1DUPNAT)
					
					AADD(aTitulo,	{"E1_PREFIXO"	,cPrefixo				,Nil})
					AADD(aTitulo,	{"E1_NUM"		,SF2->F2_DOC		   ,Nil})
					AADD(aTitulo,	{"E1_PARCELA"	,cParcela				,Nil})
					AADD(aTitulo,	{"E1_TIPO"		,MVNOTAFIS				,Nil})
					AADD(aTitulo,	{"E1_NATUREZ"	,cNatureza 			,Nil})
					AADD(aTitulo,	{"E1_CLIENTE"	,SF2->F2_CLIENTE		,Nil})
					AADD(aTitulo,	{"E1_LOJA"	   ,SF2->F2_LOJA			,Nil})
					AADD(aTitulo,	{"E1_NOMCLI"	,IIF(Empty(SA1->A1_NREDUZ),SA1->A1_NOME,SA1->A1_NREDUZ),Nil})
					AADD(aTitulo,	{"E1_EMISSAO" 	,dDataBase   	 		,Nil})
					AADD(aTitulo,	{"E1_VENCTO" 	,aVenc[nYnd,1]	  		,Nil})
					AADD(aTitulo,	{"E1_VALOR"		,aVenc[nYnd,2]			,Nil})
					AADD(aTitulo,	{"E1_ORIGEM"	,"NCIWML02" 			,Nil})
					AADD(aTitulo,	{"E1_YCODWM"	,cCodWMMov				,Nil})
					AADD(aTitulo,	{"E1_SERIE"		,SF2->F2_SERIE			,Nil})
					If !Empty( cErroAdici:=WL02GrvTit(aTitulo, 3 ) )
						WML03ERRO(cAliasPZQ,cErroAdici,"E")
					EndIf
				Next
			EndIf
			
			SF2->(RecLock("SF2",.F.))
			SF2->F2_PDV := cPDV
			SF2->F2_YCODMOV:=cCodWMMov
			SF2->F2_YLOJAWM:=cCodWMLoja
			SF2->F2_YTOPER:=(cAliasPZQ)->PZQ_OPER
			If lDuplic
				SF2->F2_DUPL:=SF2->F2_DOC
			EndIf
			SF2->F2_HORA:=(cAliasPZQ)->PZQ_HORA
			SF2->(MSUnLock())
		EndIf
		
		
		cChave:=xFilial("SD2")+cChaveDOC
		SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM
		SD2->(MsSeek(cChave))
		Do While SD2->(!Eof())  .And. SD2->(D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)==cChave
			
			RecLock("SD2",.F.)
			SD2->D2_PDV			:= cPDV
			If !lCancelar
				SD2->D2_ORIGLAN	:=""
			EndIf
			
			SD2->D2_YCODMOV:=cCodWMMov
			SD2->D2_YLOJAWM:=cCodWMLoja
			SD2->D2_YTOPER:=(cAliasPZQ)->PZQ_OPER
			
			If !lCancelar .And. SB2->(MsSeek(xFilial("SB2")+SD2->D2_COD+SD2->D2_LOCAL))
				SB2->(RecLock("SB2",.F.))
				SB2->B2_QATU:=SB2->B2_QATU-SD2->D2_QUANT
				SB2->(MsUnLock())
			EndIf
			
			SD2->(MSUnLock())
			SD2->(DBSkip())
		EndDo
		
		If !lCancelar
			aParam:={}
			AADD(aParam,DTOC(dDtMenor))//Data Inicial ?
			AADD(aParam,DTOC(dDtMaior))//Data Final ?
			AADD(aParam,2)					//Livro de ?  1=Entrada 2=Saida 3=Ambos
			AADD(aParam,cNFiscalF2)		//Da Nota Fiscal ?
			AADD(aParam,cNFiscalF2)		//Ate a Nota Fiscal ?
			AADD(aParam,cNfSerie)		//Serie de ?
			AADD(aParam,cNfSerie)		//Serie Ate ?
			AADD(aParam,"      ")		//Do Cliente/Forn. ?
			AADD(aParam,"ZZZZZZ")		//Ate o Cliente/Forn. ?
			AADD(aParam,"  ")				//Da Loja ?
			AADD(aParam,"ZZZ")			//Ate a Loja ?
			MATA930(.T.,aParam) 			//Reprocessamento Livros Fiscais
		EndIf
	Else
		(cAliasPZQ)->(DbGoTo(aRecnos[nYnd]))
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_TPOPER:="E"
		(cAliasPZQ)->PZQ_DOCPRT:=cNFiscalF1
		(cAliasPZQ)->PZQ_SERPRT:=cNfSerie
		(cAliasPZQ)->PZQ_STATUS := ""
		(cAliasPZQ)->(MsUnLock())
		
		cChaveDOC:=(cAliasPZQ)->(PZQ_DOCPRT+PZQ_SERPRT)+cCliForn+cLojaCliFor
		cChave:=xFilial("SF1")+cChaveDOC
		SF1->(DbSetOrder(1)) //F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
		If SF1->(MsSeek(cChave))
			SF1->(RecLock("SF1",.F.))
			SF1->F1_YCODMOV		:=cCodWMMov
			SF1->F1_YLOJAWM		:=cCodWMLoja
			SF1->F1_YTOPER			:=(cAliasPZQ)->PZQ_OPER
			
			If lDevolucao
				SF1->F1_YMOVVEN  :=cCodMovVen
			EndIf
			
			SF1->(MSUnLock())
		EndIf
		SD1->(DbSetOrder(1))
		cChave:=SF1->(F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
		SD1->(MsSeek(cChave))
		Do While SD1->(!Eof()) .And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)==cChave
			SD1->(RecLock("SD1",.F.))
			SD1->D1_YCODMOV:=cCodWMMov
			SD1->D1_YLOJAWM:=cCodWMLoja
			SD1->D1_YTOPER	:=(cAliasPZQ)->PZQ_OPER
			SD1->(MsUnLock())
			SD1->(DbSkip())
		EndDo
	EndIf
	
	
	
	End Transaction
	
Next

dDataBase:=dDataAtu

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML02JOB", "Grava็ใo das Notas Fiscais das Opera็๕es TRD,CDU,TLS,TLE e DV", "FISCAL", MsDate(), "F" )

MsUnLockAll()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/15/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function WML02Saldo()
mv_par01:=cArmazem
mv_par02:=cArmazem

mv_par03:=cProdRefaz
mv_par04:=cProdRefaz
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/16/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02CliFor(cCliForn,cLojaCliFor,cAliasPZR,cAliasPZQ,lMovSaida,lTransf,lDevolucao)
Local aAreaAtu	:=GetArea()
Local aAreaSM0	:=SM0->(GetArea())
Local aAreaSA1	:=SA1->(GetArea())
Local aAreaSA2	:=SA2->(GetArea())
Local cQryAlias	:=GetNextAlias()
Local cLojaCF	:="CF"
Local cCodigo
Local cWhere	:=""
Local cCPF_CNPJ
Local lRetorno	:=.T.
Default lDevolucao:=.F.

If lTransf
	If lMovSaida
		SA1->(DbSetOrder(3))
		If SM0->(MsSeek((cAliasPZQ)->(PZQ_EMPDTL+PZQ_FILDTL))) .And. SA1->(MsSeek(xFilial("SA1")+U_NCGCNPJSP(SM0->M0_CGC)))
			cCliForn:=SA1->A1_COD
			cLojaCliFor:=SA1->A1_LOJA
		EndIf
	Else
		SA2->(DbSetOrder(3))
		If SM0->(MsSeek((cAliasPZQ)->(PZQ_EMPDTL+PZQ_FILDTL))) .And. SA2->(MsSeek(xFilial("SA2")+U_NCGCNPJSP(SM0->M0_CGC)))
			cCliForn:=SA2->A2_COD
			cLojaCliFor:=SA2->A2_LOJA
		EndIf
	EndIf
ElseIf AllTrim( (cAliasPZR)->PZR_NOMCLI)=="CONSUMIDOR"
	
	If lMovSaida  .Or. lDevolucao
		
		cWhere+=" AND SA1.A1_TIPO='"+(cAliasPZR)->PZR_TPCLI+"'"
		cWhere+=" AND SA1.A1_EST='"+Iif( Empty((cAliasPZR)->PZR_UF) ,SM0->M0_ESTENT,(cAliasPZR)->PZR_UF)+"'"
		cWhere+=" AND 	SA1.A1_LOJA='"+cLojaCF+"'"
		
		cWhere:="%"+cWhere+"%"
		BeginSQL Alias cQryAlias
			SELECT SA1.A1_COD,SA1.A1_LOJA
			FROM %Table:SA1% SA1
			WHERE SA1.A1_FILIAL = %xfilial:SA1%
			%Exp:cWhere%
			AND SA1.%notDel%
		EndSQL
		
		
		cCliForn		:=(cQryAlias)->A1_COD
		cLojaCliFor	:=(cQryAlias)->A1_LOJA
		
	Else
		
		cWhere+=" AND SA2.A2_TIPO='"+(cAliasPZR)->PZR_TPCLI+"'"
		cWhere+=" AND SA2.A2_EST='"+Iif( Empty((cAliasPZR)->PZR_UF) ,SM0->M0_ESTENT,(cAliasPZR)->PZR_UF)+"'"
		cWhere+=" AND 	SA2.A2_LOJA='"+cLojaCF+"'"
		
		cWhere:="%"+cWhere+"%"
		BeginSQL Alias cQryAlias
			SELECT SA2.A2_COD,SA2.A2_LOJA
			FROM %Table:SA2% SA2
			WHERE SA2.A2_FILIAL = %xfilial:SA2%
			%Exp:cWhere%
			AND SA2.%notDel%
		EndSQL
		
		cCliForn		:=(cQryAlias)->A2_COD
		cLojaCliFor:=(cQryAlias)->A2_LOJA
	EndIf
	(cQryAlias)->(DbCloseArea())
	
Else
	cCPF_CNPJ:=AllTrim((cAliasPZR)->PZR_CPFCGC)
	
	If lMovSaida  .Or. lDevolucao
		SA1->(DbSetOrder(3))
		If !SA1->(MsSeek(xFilial("SA1")+cCPF_CNPJ))
			lRetorno:=GeraSA1(cAliasPZR,cAliasPZQ,@cCliForn,@cLojaCliFor)
		Else
			cCliForn		:=SA1->A1_COD
			cLojaCliFor	:=SA1->A1_LOJA
		EndIf
	Else
		SA2->(DbSetOrder(3))
		If !SA2->(MsSeek(xFilial("SA2")+(cAliasPZR)->PZR_CPFCGC))
			lRetorno:=GeraSA2(cAliasPZR,cAliasPZQ,@cCliForn,@cLojaCliFor)
		Else
			cCliForn		:=SA2->A2_COD
			cLojaCliFor	:=SA2->A2_LOJA
		EndIf
	EndIf
	
EndIf
RestArea(aAreaSA2)
RestArea(aAreaSA1)
RestArea(aAreaSm0)
RestArea(aAreaAtu)
Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xWML02()
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetNota(cNfSerie)
Local aAreaAtu:=GetArea()
cNumNota := NxtSX5Nota(cNfSerie)
RestArea(aAreaAtu)
Return cNumNota


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02PRENFE()
MATA140()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02NFE()
MATA103()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetNFSaida(cCodMov, cProduto )
Local aAreaAtu	:=GetArea()
Local aRetorno	:={"XXX","XXX",""}
Local cQryAlias:=GetNextAlias()


If !Empty(cProduto)
	cProduto:=AllTrim(cProduto)
	BeginSQL Alias cQryAlias
		SELECT D2_DOC,D2_SERIE,D2_ITEM
		FROM %Table:SF2% SF2 ,%Table:SD2% SD2
		WHERE F2_FILIAL = %xfilial:SF2%
		AND SF2.F2_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF2.F2_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF2.F2_CLIENTE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF2.F2_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF2.F2_YCODMOV=%Exp:cCodMov%
		AND SF2.%notDel%
		AND SD2.D2_FILIAL = %xfilial:SD2%
		AND SD2.D2_DOC=SF2.F2_DOC
		AND SD2.D2_SERIE =SF2.F2_SERIE
		And SD2.D2_CLIENTE=SF2.F2_CLIENTE
		And SD2.D2_LOJA=SF2.F2_LOJA
		And SD2.D2_COD=%Exp:cProduto%
		AND SD2.%notDel%
	EndSQL
	
	If !(cQryAlias)->(Eof() .And. Bof())
		(cQryAlias)->( aRetorno:={D2_DOC,D2_SERIE,D2_ITEM} )
	EndIf
	
Else
	BeginSQL Alias cQryAlias
		SELECT F2_DOC,F2_SERIE
		FROM %Table:SF2% SF2
		WHERE F2_FILIAL = %xfilial:SF2%
		AND SF2.F2_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF2.F2_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF2.F2_CLIENTE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF2.F2_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF2.F2_YCODMOV=%Exp:cCodMov%
		AND SF2.%notDel%
	EndSQL
	If !(cQryAlias)->(Eof() .And. Bof())
		(cQryAlias)->( aRetorno:={F2_DOC,F2_SERIE,''} )
	EndIf
	
EndIf



(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return aRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02NCM()
Local aFiliais
Local aConexoes
Local aDadosAux
Local nInd
Local nContar
Local aLinhas
Local cBuffer
Local cAliasSBZ
Local cModo:=""

RpcSetEnv("03","01")


cAliasSBZ:=GetNextAlias()
EmpOpenFile(cAliasSBZ,"SBZ",1,.T.,"03",@cModo)
FT_FUSE('\Atualiza\PRODNCMPR.csv')  //ABRIR
FT_FGOTOP() //PONTO NO TOPO

Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	cBuffer := FT_FREADLN() //LENDO LINHA
	aLinhas :=Separa(cBuffer,";")
	
	//cChaveSBZ:="02"+AllTrim(aLinhas[1])
	
	//If !(cAliasSBZ)->(MsSeek(cChaveSBZ))
	//Loop
	//EndIf
	
	//For nInd:=1 To Len(aFiliais)
	
	//If aFiliais[nInd]=="02"
	//Loop
	//EndIf
	
	aConexoes:=GetUserInfoArray()
	nContar:=0
	AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML02SBZ" ),nContar++, )   }  )
	aDadosAux:={"40","",aLinhas[2],AllTrim(aLinhas[1]),aLinhas[3]=="S",cAliasSBZ}
	//StartJob( "U_WML02SBZ",GetEnvServer(), nContar>=20, aDadosAux)//
	U_WML02SBZ(aDadosAux)
	//Next
	FT_FSKIP()   //pr๓ximo registro no arquivo txt
EndDo
FT_FUSE() //fecha o arquivo txt
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02SBZ(aDados)
Local cQryAlias
Local cAliasSBZ:=aDados[6]
Local cWhere
Local lAppend
Local nInd
Local cModo:=""
Local aFiliais

//RpcClearEnv()
//RpcSettype(3)
//RpcSetEnv("03","01")

cAliasSBZ:=GetNextAlias()
EmpOpenFile(cAliasSBZ,"SBZ",1,.T.,"03",@cModo)
cChaveSBZ:="02"+AllTrim(aDados[4])
If !(cAliasSBZ)->(MsSeek(cChaveSBZ))
	Return
EndIf

aFiliais:=FWAllFilial()
cQryAlias:=GetNextAlias()

cWhere:=" B1_FILIAL = '"+xFilial("SB1")+"'"
cWhere+=" AND SB1.B1_POSIPI='"+AllTrim(aDados[3])+"'"
cWhere+=" AND B1_COD<>'"+aDados[4]+"'"
cWhere+=" AND Length(rtrim(LTRIM(B1_COD)))<6"
//cWhere+=" AND B1_COD='25203'

If aDados[5]
	cWhere+=" AND SB1.B1_XUSADO='S'"
EndIf
cWhere:="%"+cWhere+"%"

BeginSQL Alias cQryAlias
	SELECT SB1.B1_COD,SB1.B1_POSIPI
	FROM %Table:SB1% SB1
	WHERE %Exp:cWhere%
	AND SB1.%notDel%
	ORDER BY 1
EndSQL

Do While !(cQryAlias)->(Eof())
	
	
	PtInternal(1,"Empresa:"+cEmpAnt+" Produto:"+(cQryAlias)->B1_COD+" NCM:"+(cQryAlias)->B1_POSIPI)
	
	For nInd:=1 To Len(aFiliais)
		
		cFilSBZ:=aFiliais[nInd]
		PtInternal(1,"Empresa:"+cEmpAnt+" Filial:"+cFilSBZ+" Produto:"+(cQryAlias)->B1_COD+" NCM:"+(cQryAlias)->B1_POSIPI)
		
		If SBZ->(DbSeek(cFilSBZ+(cQryAlias)->B1_COD))
			Loop
		EndIf
		
		lAppend:=!SBZ->(DbSeek(cFilSBZ+(cQryAlias)->B1_COD))
		
		Begin Transaction
		SBZ->(RecLock("SBZ",lAppend))
		AvReplace(cAliasSBZ,"SBZ")
		SBZ->BZ_COD		:=(cQryAlias)->B1_COD
		SBZ->BZ_FILIAL	:=cFilSBZ
		SBZ->(MsUnLock())
		End Transaction
		
	Next
	(cQryAlias)->(DbSkip())
EndDo




(cQryAlias)->(DbCloseArea())


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  06/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetNfeTLS(cNfSerie,cNFiscalF1,cEmpOrig,cFilOrig,cCodMov)
Local aAreaAtu	:=GetArea()
Local cQryAlias:=GetNextAlias()
Local cTbPZQ		:= "%PZQ010 PZQ%"

BeginSQL Alias cQryAlias
	SELECT PZQ_DOCPRT, PZQ_SERPRT
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL =%xfilial:PZQ%
	AND PZQ.PZQ_CODMOV=%Exp:cCodMov%
	AND PZQ.PZQ_OPER = 'TLS'
	AND PZQ.PZQ_EMPDTL = %Exp:cEmpOrig%
	AND PZQ.PZQ_FILDTL = %Exp:cFilOrig%
	AND PZQ.%notDel%
EndSQL

If !(cQryAlias)->(Eof() .And. Bof())
	cNFiscalF1	:=(cQryAlias)->PZQ_DOCPRT
	cNfSerie		:= (cQryAlias)->PZQ_SERPRT
EndIf

(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  06/11/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraSA1(cAliasPZR,cAliasPZQ,cCliForn,cLojaCliFor)
Local aAreaAtu	:=GetArea()
Local cQryAlias:=GetNextAlias()
Local cLojaCF	:="CF"
Local cWhere	:=""
Local aVetor	:={}
Local cNome
Local cEndereco
Local cEstado
Local cMun
Local cBairro
Local cCep
Local cTelefone
Local cCodMun
Local cCodCli
Local lRet		:= .F.

Private A1_YBLQFIN := ""

cCodCli := GETSXENUM("SA1","A1_COD")
SA1->(DbSetOrder(1))
Do While SA1->(DbSeek(xFilial("SA1") +cCodCli+"01" ))
	ConfirmSX8()
	cCodCli := GETSXENUM("SA1","A1_COD")
EndDo

cWhere+=" AND SA1.A1_TIPO='"+(cAliasPZR)->PZR_TPCLI+"'"
cWhere+=" AND SA1.A1_EST='"+Iif( Empty((cAliasPZR)->PZR_UF) ,SM0->M0_ESTENT,(cAliasPZR)->PZR_UF)+"'"
cWhere+=" AND 	SA1.A1_LOJA='"+cLojaCF+"'"
cWhere:="%"+cWhere+"%"
BeginSQL Alias cQryAlias
	SELECT SA1.R_E_C_N_O_ RecSA1
	FROM %Table:SA1% SA1
	WHERE SA1.A1_FILIAL = %xfilial:SA1%
	%Exp:cWhere%
	AND SA1.%notDel%
EndSQL

cNome	  	:= u_NCNoCEsp(Upper((cAliasPZR)->PZR_NOMCLI))
cEndereco	:= u_NCNoCEsp(Upper(AllTrim((cAliasPZR)->PZR_ENDCLI)+","+AllTrim((cAliasPZR)->PZR_NUMEND)))
cEstado 	:= u_NCNoCEsp(Upper((cAliasPZR)->PZR_UF))
cMun	  	:= u_NCNoCEsp(Upper((cAliasPZR)->PZR_CIDADE))
cBairro		:= u_NCNoCEsp(Upper((cAliasPZR)->PZR_BAIRRO))



cCep		:= AllTrim((cAliasPZR)->PZR_CEP)
cTelefone	:= AllTrim((cAliasPZR)->PZR_TEL)

cTelefone	:=StrTran(cTelefone,"(","")
cTelefone	:=StrTran(cTelefone,")","")
cTelefone	:=StrTran(cTelefone,"-","")
cTelefone	:=StrTran(cTelefone," ","")

cCep			:=StrTran(cCep,"-","")
cCep			:=StrTran(cCep,".","")

cCodMun		:=""
cMun:=Padr(cMun,Len(CC2->CC2_MUN))

CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
If CC2->(DbSeek(xFilial("CC2")+cMun))
	Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==cMun
		If CC2->CC2_EST==cEstado
			cCodMun	:= CC2->CC2_CODMUN
		EndIf
		CC2->(DbSkip())
	EndDo
Else
	DbSelectArea("SM0")
	SM0->(DbSetOrder(1))
	If SM0->(DbSeek(cEmpAnt+cFilAnt)) .And. Empty(cCodMun)
		cCodMun := SubStr(SM0->M0_CODMUN, 3,Len(SM0->M0_CODMUN) )
	Else
		cErroAdiconal:="Codigo Municipio nใo encontrado para o Municipio "+cMun
	EndIf
EndIf

If Empty(cBairro)
	cBairro:=cMun
EndIf

If Empty(cCep)
	cCep:="000000"
EndIf

If Empty(cTelefone)
	cTelefone:="0000000000"
EndIf


SA1->(DbGoTo( (cQryAlias)->RecSA1  ))
AADD(aVetor,{"A1_FILIAL" 	,xFilial("SA1") ,Nil})
AADD(aVetor,{"A1_COD" 		,cCodCli,Nil})
AADD(aVetor,{"A1_LOJA" 		,"01" ,Nil})
AADD(aVetor,{"A1_PESSOA" 	,"F" ,Nil})
AADD(aVetor,{"A1_NOME" 		,cNome ,Nil})
AADD(aVetor,{"A1_NREDUZ" 	,cNome ,Nil})
AADD(aVetor,{"A1_END" 		,cEndereco  ,Nil})
AADD(aVetor,{"A1_EST" 		,cEstado ,Nil})
AADD(aVetor,{"A1_COD_MUN" 	,cCodMun ,Nil})
AADD(aVetor,{"A1_MUN" 		,cMun ,Nil})
AADD(aVetor,{"A1_BAIRRO" 	,cBairro ,Nil})
AADD(aVetor,{"A1_CEP" 		,cCep,Nil})
AADD(aVetor,{"A1_DDD" 		,Left(cTelefone,2) ,Nil})
AADD(aVetor,{"A1_TEL" 		,SubStr(cTelefone,3) ,Nil})
AADD(aVetor,{"A1_ESTC" 		,cEstado ,Nil})
AADD(aVetor,{"A1_ENDCOB" 	,cEndereco ,Nil})
AADD(aVetor,{"A1_BAIRROC"	,cBairro ,Nil})
AADD(aVetor,{"A1_CEPC" 		,cCep ,Nil})
AADD(aVetor,{"A1_MUNC" 		,cMun ,Nil})

AADD(aVetor,{"A1_ESTE" 		,cEstado 	,Nil})
AADD(aVetor,{"A1_ENDENT" 	,cEndereco ,Nil})
AADD(aVetor,{"A1_BAIRROE"	,cBairro ,Nil})
AADD(aVetor,{"A1_CEPE" 		,cCep ,Nil})
AADD(aVetor,{"A1_MUNE" 		,cMun ,Nil})
AADD(aVetor,{"A1_EMAIL" 	,(cAliasPZR)->PZR_EMAIL ,Nil})
AADD(aVetor,{"A1_COMPLEM" 	,Upper(AllTrim((cAliasPZR)->PZR_COMPLE)),Nil})

AADD(aVetor,{"A1_DTNASC" 	,MsDate() ,Nil})
AADD(aVetor,{"A1_CGC" 		,(cAliasPZR)->PZR_CPFCGC ,Nil})
AADD(aVetor,{"A1_INSCR" 	,IIf(!Empty((cAliasPZR)->PZR_IE),(cAliasPZR)->PZR_IE,"ISENTO"  ) ,Nil})


AADD(aVetor,{"A1_NATUREZ" 	,SA1->A1_NATUREZ ,Nil})
AADD(aVetor,{"A1_VEND" 		,SA1->A1_VEND ,Nil})
AADD(aVetor,{"A1_CONTA" 	,SA1->A1_CONTA ,Nil})
AADD(aVetor,{"A1_TRANSP" 	,SA1->A1_TRANSP ,Nil})
AADD(aVetor,{"A1_TPFRET" 	,SA1->A1_TPFRET ,Nil})
AADD(aVetor,{"A1_GRPTRIB"	,SA1->A1_GRPTRIB ,Nil})
AADD(aVetor,{"A1_X_LOCZ" 	,SA1->A1_X_LOCZ,Nil})
AADD(aVetor,{"A1_SATIV1" 	,SA1->A1_SATIV1 ,Nil})
AADD(aVetor,{"A1_GRPVEN" 	,SA1->A1_GRPVEN ,Nil})
AADD(aVetor,{"A1_CODPAIS"	,SA1->A1_CODPAIS ,Nil})
AADD(aVetor,{"A1_PAIS" 		,SA1->A1_PAIS,Nil})
AADD(aVetor,{"A1_FRETE" 	,SA1->A1_FRETE ,Nil})
AADD(aVetor,{"A1_TEMODAL" 	,SA1->A1_TEMODAL ,Nil})
AADD(aVetor,{"A1_YCANAL" 	,SA1->A1_YCANAL,Nil})
AADD(aVetor,{"A1_CONTRIB" 	,SA1->A1_CONTRIB,Nil})
AADD(aVetor,{"A1_TABELA" 	,SA1->A1_TABELA,Nil})
AADD(aVetor,{"A1_COND" 		,SA1->A1_COND ,Nil})
AADD(aVetor,{"A1_XSORTER"	,SA1->A1_XSORTER,Nil})
AADD(aVetor,{"A1_AGEND" 	,SA1->A1_AGEND ,Nil})
AADD(aVetor,{"A1_OPER" 		,SA1->A1_OPER ,Nil})
AADD(aVetor,{"A1_TIPO" 		,SA1->A1_TIPO ,Nil})
AADD(aVetor,{"A1_SATIV1" 	,SA1->A1_SATIV1 ,Nil})
AADD(aVetor,{"A1_XGRPCOM" 	,SA1->A1_XGRPCOM ,Nil})

AADD(aVetor,{"A1_REGIAO" 	,U_AchaReg(cEstado) ,Nil})

BEGIN TRANSACTION

lMsErroAuto:=.F.
CC2->(DBSETORDER(1))
MSExecAuto({|x,y| MATA030(x,y)},aVetor, 3)

If !lMsErroAuto
	cCliForn		:=SA1->A1_COD
	cLojaCliFor		:=SA1->A1_LOJA
Else
	U_WML03ERRO(cAliasPZQ,MemoRead( NomeAutoLog() ),"E")			// Gravar Msg de Erro
	MostraErro('cPath',NomeAutoLog())//Apagar o arquivo atua
	RollBackSXe()
Endif

END TRANSACTION


(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return !lMsErroAuto

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  06/11/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraSA2(cAliasPZR,cAliasPZQ,cCliForn,cLojaCliFor)
Local aAreaAtu	:=GetArea()
Local cQryAlias:=GetNextAlias()
Local cLojaCF	:="CF"
Local cWhere	:=""
Local aVetor	:={}
Local cCodFor
Local cNome
Local cEndereco
Local cEstado
Local cMun
Local cBairro
Local cCep
Local cTelefone
Local cCodMun

cCodFor := GETSXENUM("SA2","A2_COD")
SA2->(DbSetOrder(1))
Do While SA2->(DbSeek(xFilial("SA2") +cCodFor+"01" ))
	ConfirmSX8()
	cCodFor := GETSXENUM("SA2","A2_COD")
EndDo

//cWhere+=" AND SA2.A2_TIPO='"+(cAliasPZR)->PZR_TPCLI+"'"
cWhere+=" AND SA2.A2_EST='"+Iif( Empty((cAliasPZR)->PZR_UF) ,SM0->M0_ESTENT,(cAliasPZR)->PZR_UF)+"'"
cWhere+=" AND 	SA2.A2_LOJA='"+cLojaCF+"'"

cWhere:="%"+cWhere+"%"
BeginSQL Alias cQryAlias
	SELECT SA2.R_E_C_N_O_ RecSA2
	FROM %Table:SA2% SA2
	WHERE SA2.A2_FILIAL = %xfilial:SA2%
	%Exp:cWhere%
	AND SA2.%notDel%
EndSQL

SA2->(DbGoTo( (cQryAlias)->RecSA2  ))

cNome	  	:= u_NCNoCEsp(Upper((cAliasPZR)->PZR_NOMCLI))
cEndereco	:= u_NCNoCEsp(Upper(AllTrim((cAliasPZR)->PZR_ENDCLI)+","+AllTrim((cAliasPZR)->PZR_NUMEND)))
cEstado 	:= u_NCNoCEsp(UPPER((cAliasPZR)->PZR_UF))
cMun	  	:= u_NCNoCEsp(Upper(AllTrim((cAliasPZR)->PZR_CIDADE)))
cBairro		:= u_NCNoCEsp(UPPER((cAliasPZR)->PZR_BAIRRO))

cCodMun		:=""

cCep			:=AllTrim((cAliasPZR)->PZR_CEP)
cTelefone	:=AllTrim((cAliasPZR)->PZR_TEL)

cTelefone	:=StrTran(cTelefone,"(","")
cTelefone	:=StrTran(cTelefone,")","")
cTelefone	:=StrTran(cTelefone,"-","")
cTelefone	:=StrTran(cTelefone," ","")

cCep			:=StrTran(cCep,"-","")
cCep			:=StrTran(cCep,".","")

cMun:=Padr(cMun,Len(CC2->CC2_MUN))

CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
If CC2->(MsSeek(xFilial("CC2")+cMun))
	Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==cMun
		If CC2->CC2_EST==cEstado
			cCodMun	:= CC2->CC2_CODMUN
		EndIf
		CC2->(DbSkip())
	EndDo
Else
	DbSelectArea("SM0")
	SM0->(DbSetOrder(1))
	If SM0->(DbSeek(cEmpAnt+cFilAnt)) .And. Empty(cCodMun)
		cCodMun := SubStr(SM0->M0_CODMUN, 3,Len(SM0->M0_CODMUN) )
	Else
		cErroAdiconal:="Codigo Municipio nใo encontrado para o Municipio "+cMun
	EndIf
EndIf

If Empty(cBairro)
	cBairro:=cMun
EndIf

If Empty(cCep)
	cCep:="000000"
EndIf


AADD(aVetor,{"A2_FILIAL" 	,xFilial("SA2") ,Nil})
AADD(aVetor,{"A2_COD" 		,cCodFor,Nil})
AADD(aVetor,{"A2_LOJA" 		,"01" ,Nil})
AADD(aVetor,{"A2_TIPO" 	,(cAliasPZR)->PZR_TPCLI ,Nil})
AADD(aVetor,{"A2_NOME" 		,cNome ,Nil})
AADD(aVetor,{"A2_NREDUZ" 	,cNome ,Nil})
AADD(aVetor,{"A2_END" 		,cEndereco  ,Nil})
AADD(aVetor,{"A2_EST" 		,cEstado ,Nil})
AADD(aVetor,{"A2_COD_MUN" 	,cCodMun ,Nil})
AADD(aVetor,{"A2_MUN" 		,cMun ,Nil})
AADD(aVetor,{"A2_BAIRRO" 	,cBairro ,Nil})
AADD(aVetor,{"A2_CEP" 		,cCep,Nil})
AADD(aVetor,{"A2_DDD" 		,Left(cTelefone,2) ,Nil})
AADD(aVetor,{"A2_TEL" 		,SubStr(cTelefone,3) ,Nil})
AADD(aVetor,{"A2_EMAIL" 	,(cAliasPZR)->PZR_EMAIL ,Nil})
AADD(aVetor,{"A2_COMPLEM" 	,Upper(AllTrim((cAliasPZR)->PZR_COMPLE)),Nil})
AADD(aVetor,{"A2_CGC" 		,(cAliasPZR)->PZR_CPFCGC ,Nil})
AADD(aVetor,{"A2_INSCR" 	,IIf(!Empty((cAliasPZR)->PZR_IE),(cAliasPZR)->PZR_IE,"ISENTO"  ) ,Nil})

AADD(aVetor,{"A2_CONTRIB" 	,IIf(!Empty((cAliasPZR)->PZR_IE),"1","2"  ) ,Nil})
AADD(aVetor,{"A2_GRPTRIB" 	,IIf(!Empty((cAliasPZR)->PZR_IE),"CFI","CFS"  ) ,Nil})

AADD(aVetor,{"A2_NATUREZ" 	,SA2->A2_NATUREZ ,Nil})
AADD(aVetor,{"A2_CONTA" 	,SA2->A2_CONTA ,Nil})
AADD(aVetor,{"A2_CODPAIS"	,SA2->A2_CODPAIS ,Nil})
AADD(aVetor,{"A2_PAIS"  	,SA2->A2_PAIS ,Nil})



BEGIN TRANSACTION

lMsErroAuto:=.F.
CC2->(DBSETORDER(1))
MSExecAuto({|x,y| MATA020(x,y)},aVetor, 3)

If lMsErroAuto
	U_WML03ERRO(cAliasPZQ,MemoRead( NomeAutoLog() ),"E")			// Gravar Msg de Erro
	MostraErro('cPath',NomeAutoLog())//Apagar o arquivo atua
	RollBackSXe()
Else
	cCliForn		:=SA2->A2_COD
	cLojaCliFor	:=SA2->A2_LOJA
Endif

END TRANSACTION


(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return !lMsErroAuto



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  06/11/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML02Vend(cAliasPZR,cAliasPZQ)
Local aAeaAtu:=GetArea()
Local cVendedor:=""
Local cCodVendWM:=(cAliasPZQ)->PZQ_USRCAI
Local cNome		 :=(cAliasPZQ)->PZQ_NOMCAI
Local aDados

If !Empty((cAliasPZQ)->PZQ_USRCOM)
	cCodVendWM	:=(cAliasPZQ)->PZQ_USRCOM
	cNome			:=(cAliasPZQ)->PZQ_NOMCOM
EndIf

aDados:=U_NCIFW2VEND(cCodVendWM, cNome, "01")
cVendedor:=aDados[1]

If Empty(aDados[1])
	U_WML03ERRO(cAliasPZQ,aDados[2],"E")// Gravar Msg de Erro
EndIf

RestArea(aAeaAtu)

Return cVendedor

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  06/19/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WL02GrvTit(aTitulo, nOpc )
Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {}
Default nOpc	:= 3//Inclusใo

//Inicio da transa็ใo

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	
	MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, nOpc)
	If lMSErroAuto
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		cRet := cMsgErro
		DisarmTransaction()
	EndIf
Else
	cRet := "Dados nใo informados"
EndIf


RestArea(aArea)
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  06/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCupom(cCodMov,cCodLoja,cAliasPZY)
Local aAreaAtu	:=GetArea()
Local cQuery
Local aNfeOrig:={"XXXX","",""}
Local nLenCodMov:=AvSx3("PZY_CODMOV",3)
Local nLenDoc	 :=AvSx3("PZY_DOC",3)
Local nLenCodLoj :=AvSx3("PZY_CODLOJ",3)
Local cChave:=xFilial("PZY")+PADR( AllTrim(cCodMov),nLenCodMov)+Padr(Alltrim(cCodLoja),nLenCodLoj)

If (cAliasPZY)->(MsSeek(cChave)  )
	(cAliasPZY)->(aNfeOrig:={PZY_DOC,"ECF",""}	)
EndIf

RestArea(aAreaAtu)
Return aNfeOrig


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDtEmiss  บAutor  ณMicrosiga         บ Data ณ  05/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a data emissใo da NF                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDtEmiss(dDtEmiss)

Local dDtAux	:= MsDate()

Default dDtEmiss :=  CTOD("")

If (  Alltrim(Str(month(MsDate())))  + " / " + Alltrim(str(year( MsDate() ))) ) == ( Alltrim(Str(month(dDtEmiss))) + " / " + Alltrim(str(year( dDtEmiss ))) )
	dDtAux := MsDate()
ElseIf MsDate() <= LastDay(dDtEmiss)
	dDtAux := MsDate()
Else
	dDtAux := LastDay(dDtEmiss)
EndIf

Return dDtAux


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVLDNFWM  บAutor  ณMicrosiga           บ Data ณ  05/15/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Simula็ใo de inclusใo de notas fiscias. Utilizado para nใo บฑฑ
ฑฑบ          ณ perder numera็ใo (Formulario Proprio)                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCVLDNFWM(lMovSaida, aCabec, aItens, nOpc)
Local aDados
Local aArea 	:= GetArea()
Local cMsgRet	:= ""
Local nInd
Private lMsErroAuto := .F.

Default lMovSaida 	:= .F.
Default aCabec		:= {}
Default aItens		:= {}
Default nOpc		:= 3

//Inicio da transa็ใo
Begin Transaction

//Chama a rotina automatica para gravar os dados da nota de entrada
If lMovSaida
	MsExecAuto({|x,y,z| MATA920(x,y,z)}, aCabec, aItens, nOpc)
Else
	MsExecAuto({|x,y,z| MATA140(x,y,z)}, aCabec, aItens, nOpc)
EndIf

//Verifica se ocorreru algum erro no processamento
If lMSErroAuto
	
	//Captura a mensagem de erro
	cMsgRet := AllTrim(MemoRead(NomeAutoLog()))
	aDados:=Separa(cMsgRet,CRLF)
	
	For nInd:=1 To Len(aDados)
		If "INVALIDO"$Upper(aDados[nInd])
			cMsgRet:=aDados[nInd]
			Exit
		EndIf
	Next
	
	
	MemoWrite(NomeAutoLog()," ")
	
	cRet := cMsgRet
	
EndIf

//Rollback da transa็ใo. (Esse processo nใo deve ser gravado no banco de dados)
DisarmTransaction()

//Finalisa a transa็ใo
End Transaction


RestArea(aArea)
Return cMsgRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  12/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MWL02ValChave(lMovSaida,cCodWMMov,cCodWMLoja,cAliasPZQ)
Local aAreaAtu:=GetArea()
Local aAreaSF1:=SF1->(GetArea())
Local aAreaSF2:=SF2->(GetArea())
Local lRetorno:=.T.

If lMovSaida
	SF2->(DbOrderNickName("F2WM"))//F2_FILIAL+F2_YCODMOV+F2_YLOJAWM
	If SF2->(MsSeek(xFilial("SF2")+cCodWMMov+cCodWMLoja )  )
		lRetorno:=.F.
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_TPOPER:="S"
		(cAliasPZQ)->PZQ_DOCPRT:=SF2->F2_DOC
		(cAliasPZQ)->PZQ_SERPRT:=SF2->F2_SERIE
		(cAliasPZQ)->PZQ_STATUS := ""
		(cAliasPZQ)->(MsUnLock())
	EndIf
Else
	SF1->(DbOrderNickName("F1WM"))//F1_FILIAL+F1_YCODMOV+F1_YLOJAWM
	If SF1->(MsSeek(xFilial("SF1")+cCodWMMov+cCodWMLoja )  )
		lRetorno:=.F.
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_TPOPER:="E"
		(cAliasPZQ)->PZQ_DOCPRT:=SF1->F1_DOC
		(cAliasPZQ)->PZQ_SERPRT:=SF1->F1_SERIE
		(cAliasPZQ)->PZQ_STATUS := ""
		(cAliasPZQ)->(MsUnLock())
	EndIf
EndIf





RestArea(aAreaSF1)
RestArea(aAreaSF2)
RestArea(aAreaAtu)
Return lRetorno




User Function L02TST()
Local cQryAlias:="TMP"
aDados := {"03","01"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])

BeginSQL Alias cQryAlias
	SELECT DIstinct D2_FILIAL,D2_COD
	FROM SD2030 SD2,SB1030 SB1
	WHERE D2_FILIAL Between '  ' AND 'ZZZZZ' 
	AND D2_EMISSAO>='20170520'
	AND D2_CUSTO1=0
	AND D2_COD=B1_COD
	AND SD2.%notdel%
	AND SB1.%notdel%
	Order By 1
EndSQL


Do While (cQryAlias)->(!Eof())
	cFilAnt:=(cQryAlias)->D2_FILIAL
	Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->D2_FILIAL==cFilAnt
		L02VlrProd(0,"",(cQryAlias)->D2_COD,"S")
		(cQryAlias)->(DbSkip())
	EndDo
EndDo



(cQryAlias)->(DbCloseArea())

Return



Static Function CheckSeque()
Local cNext
Local cNum,cGreat := Space(Len(Criavar("D1_NUMSEQ")))
Local cText
Local cAlias := Alias()
Local aAreaSD1
Local aAreaSD2
Local aAreaSD3
Local lRet := .T.
Local __lD1D2D3

If lxProxNum == Nil
	lxProxNum := ExistBlock("XPROXNUM")
EndIf

If lxProxNum
	__lNoErro := .t.
	lRet := .F.
	__lNoErro:=.F.
EndIf

If lRet
	
	__lD1D2D3 := (Select('SD1')>0) .And. (Select('SD2')>0) .And. (Select('SD3')>0)
	
	If __lD1D2D3
		dbSelectArea("SD1")
		aAreaSD1 := GetArea()
		dbSetOrder(4)
		dbSeek(xFilial("SD1")+"zzzzzz",.T.)
		dbSkip(-1)
		If D1_FILIAL == xFilial("SD1")
			cNum := D1_NUMSEQ
		Else
			cNum := Space(Len(D1_NUMSEQ))
		EndIf
		If cNum > cGreat
			cGreat := cNum
		EndIf
		RestArea(aAreaSD1)
		
		dbSelectArea("SD2")
		aAreaSD2 := GetArea()
		dbSetOrder(4)
		dbSeek(xFilial("SD2")+"zzzzzz",.T.)
		dbSkip(-1)
		If D2_FILIAL == xFilial("SD2")
			cNum := D2_NUMSEQ
		Else
			cNum := Space(Len(D2_NUMSEQ))
		EndIf
		If cNum > cGreat
			cGreat := cNum
		EndIf
		RestArea(aAreaSD2)
		
		dbSelectArea("SD3")
		aAreaSD3 := GetArea()
		dbSetOrder(4)
		dbSeek(xFilial("SD3")+"zzzzzz",.T.)
		dbSkip(-1)
		If D3_FILIAL == xFilial("SD3")
			cNum := D3_NUMSEQ
		Else
			cNum := Space(Len(D3_NUMSEQ))
		EndIf
		If cNum > cGreat
			cGreat := cNum
		EndIf
		RestArea(aAreaSD3)
		
		cNext := ProxNum(.f.)
		
		If cGreat >= cNext
			Aviso("DOCSEQ","Problema no parametro MV_DOCSEQ",{"Ok"}) //
			__lNoErro := .F.
		Else
			__lNoErro := .T.
		EndIf
	EndIf
EndIf

If !Empty(cAlias)
	dbSelectArea(cAlias)
EndIf

Return __lNoErro




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  04/13/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function L02VlrProd(nVlrProd,cAliasPZR,cProduto,cTipoNota)
Local aAreaAtu:=GetArea()
Local aAreaSB2:=SB2->(GetArea())
Local aAreaSB1:=SB1->(GetArea())
Local cAliasQry:=GetNextAlias()
Local aSaldo
Local nVlrTrans:=nVlrProd
Local lAtualizaSB2:=.F.

If cTipoNota=="S"
	SB1->(DbSetOrder(1))
	SB2->(DbSetOrder(1))
	
	If SB1->(DbSeek(xFilial("SB1")+cProduto ))
		
		nVlrProd:=0
		//Regra 1 - Os valores das transfer๊ncia tem que ser o ultimo custo da mercadoria conforme Saldo de Estoque - SB2, da Filial de origem movimento TLS
		If SB2->(DbSeek(xFilial("SB2")+cProduto+"01" ))
			nVlrProd:=SB2->B2_CM1
		Else
			CriaSB2(cProduto,"01")
		Endif
		
		If nVlrProd<=0
			lAtualizaSB2:=.T.
		EndIf
		
		
		//Regra 2 - Caso o Produto nใo tenha custo, pegar o custo da primeira filial que encontrar no Saldo de Estoque (SB2)
		If nVlrProd<=0
			BeginSql Alias cAliasQry
				Select SB2.B2_CM1
				From %Table:SB2% SB2
				Where SB2.B2_FILIAL Between '   ' And 'ZZZ'
				And SB2.B2_COD=%Exp:cProduto%
				And SB2.B2_LOCAL='01'
				And SB2.B2_CM1>0
				And SB2.%notDel%
				Order By B2_FILIAL
			EndSql
			
			If (cAliasQry)->(!Eof())
				nVlrProd:=(cAliasQry)->B2_CM1
			EndIf
			(cAliasQry)->(DbCloseArea())
		EndIf
		
		If nVlrProd<=0 //Regra 3 - Se o valor zerado do WebManager pegar o custo do produto
			nVlrProd:=SB1->B1_YCUSTPR
		Endif
		
		
		If  nVlrProd<=0//Regra 4 - Caso Nใo tenha em nenhuma filial, pegar o pre็o de compra ("pre็o de transfer๊ncia") do Web Manager e aplicar redu็ใo de 20%. Exemplo: o item no registro TLs no WEb, esta no valor de R$ 100,00, reduzir 20%, R$ 100,00 - 20% = R$ 80,00 - Aplicar R$ 80,00 no item com pre็o psara a nota fiscal de transfer๊ncia
			nVlrProd:=0.8*nVlrTrans
		EndIf
		
		If nVlrProd<=0//Regra 5 - Caso se mantenha zerado colocar 10
			nVlrProd:=10
		EndIf
		
		If lAtualizaSB2 .And. SB2->(DbSeek(xFilial("SB2")+cProduto+"01" ))
			SB2->(RecLock("SB2",.F.))
			SB2->B2_CM1:=nVlrProd
			SB2->(MsUnLock())
		Endif
		
		//SB1->(RecLock("SB1",.F.))
		//SB1->B1_YCUSTPR:=nVlrProd
		//SB1->(MsUnLock())      
		
		If nVlrProd>nVlrTrans .And. nVlrTrans > 0
			nVlrProd:=0.8*nVlrTrans
		EndIf
		
		U_WML02SB9(cProduto,"01",nVlrProd)
		
		
	EndIf
	
Else
	BeginSql Alias cAliasQry
		Select SD2.D2_PRCVEN
		From %Table:SD2% SD2
		WHERE SD2.D2_FILIAL Between '  ' And 'ZZZ'
		AND SD2.D2_DOC  Between '  ' And 'ZZZ'
		AND SD2.D2_SERIE  Between '  ' And 'ZZZ'
		AND SD2.D2_CLIENTE  Between '  ' And 'ZZZ'
		AND SD2.D2_LOJA  Between '  ' And 'ZZZ'
		AND SD2.D2_COD=%Exp:cProduto%
		AND SD2.D2_YCODMOV=%Exp:(cAliasPZR)->PZR_CODMOV%
		AND SD2.D2_YLOJAWM=%Exp:(cAliasPZR)->PZR_LJDEST%
		AND SD2.D_E_L_E_T_=' '
	EndSql
	
	If (cAliasQry)->(!Eof())
		nVlrProd:=(cAliasQry)->D2_PRCVEN
	EndIf
	(cAliasQry)->(DbCloseArea())
	
	
EndIf

RestArea(aAreaSB1)
RestArea(aAreaSB2)
RestArea(aAreaAtu)
Return nVlrProd


User Function WML02SB9(cProduto,cLocal,nVlrProd)
Local aAreaAtu:=GetArea()
Local aAreaSB9:=SB9->(GetArea())
Local dtFecha:=GetMv("MV_ULMES")

SB9->(DbSetOrder(1))//B9_FILIAL+B9_COD+B9_LOCAL+DTOS(B9_DATA)
If !SB9->(DbSeek(xFilial("SB9")+cProduto+cLocal+Dtos(dtFecha) ))
	SB9->(RecLock("SB9",.T.))
	SB9->B9_FILIAL:=xFilial("SB9")
	SB9->B9_COD:=cProduto
	SB9->B9_LOCAL:=cLocal
	SB9->B9_DATA:=dtFecha
	SB9->B9_CM1:=nVlrProd
	SB9->(MsUnLock())	
ElseIf SB9->B9_CM1==0
	SB9->(RecLock("SB9",.F.))
	SB9->B9_CM1:=nVlrProd
	SB9->(MsUnLock())	
EndIf



RestArea(aAreaSB9)
RestArea(aAreaAtu)
Return nVlrProd
