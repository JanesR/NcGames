#Include "PROTHEUS.CH "
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML06  บAutor  ณMicrosiga           บ Data ณ  06/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML06JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWML06()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML06  บAutor  ณMicrosiga           บ Data ณ  06/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWML06()
Processa({|| ExecBlock("WML06GERAR") }, " Gera Cancelamento Movimento Fiscal ", "Interface de Dados")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML06  บAutor  ณMicrosiga           บ Data ณ  06/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML06Gerar()
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


BeginSQL Alias cQryAlias
	SELECT PZQ.R_E_C_N_O_ RecPZQ,PZQ.PZQ_EMPDES,PZQ.PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
	FROM %Table:PZQ% PZQ
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT<>' '
	AND PZQ.PZQ_STATUS<>'X'
	AND PZQ.PZQ_OPER IN ('CA')
	//AND PZQ.PZQ_EMPDES='03'		
	AND PZQ.%notDel%
	ORDER BY PZQ_EMPDES,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
EndSQL

ProcRegua(2)

Do While (cQryAlias)->(!Eof())
	
	cEmpPZQ:=(cQryAlias)->PZQ_EMPDES
	cFilPZQ:=(cQryAlias)->PZQ_FILDES
	
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
	//AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML06GRAVAR" ),nContar++, )   }  )
	//StartJob( "U_WML06Gravar",GetEnvServer(), nContar>=5, aDadosAux)
	U_WML06Gravar(aDadosAux)
Next

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML06  บAutor  ณMicrosiga           บ Data ณ  06/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML06Gravar(aDados)
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
Local nRecNota
Local aRecSD2
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
Local cChaveSD2
Local cChaveSF2
Local nXnd

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1,1],aDados[1,2])

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML06JOB", "Cancelamento dos Cupons tipo Opera็ใo CA", "FISCAL", MsDate() )  

cAliasPZQ	:=GetNextAlias()
cAliasPZR	:=GetNextAlias()
nLenD2Item	:=AvSx3("D2_ITEM",3)
nLenD1Item	:=AvSx3("D1_ITEM",3)
nLenB1Cod	:=AvSx3("B1_COD",3)

dDataAtu		:=dDataBase

EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)
EmpOpenFile(cAliasPZR,"PZR",2,.T.,"01",@cModo)

For nYnd:=1 To Len(aRecnos)
	
	(cAliasPZQ)->(DbGoTo(aRecnos[nYnd]))
	
	lMovSaida	:=.t.
	
	If !FoundNota(cAliasPZQ,@nRecNota,lMovSaida)
		Loop
	EndIf
	
	
	Begin TransAction
	
	SF2->(DbGoTo(nRecNota))
	cChave:=xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
	SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM
	
	SD2->(MsSeek(cChave))
	aItens:={}
	aRecSD2:={}
	
	cCliForn		:=SF2->F2_CLIENTE
	cLojaCliFor	:=SF2->F2_LOJA
	
	Do While SD2->(!Eof())  .And. SD2->(D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)==cChave
		
		aadd(aRecSD2, SD2->(Recno()))
		
		SD2->(RecLock("SD2",.F.))
		SD2->D2_ORIGLAN:="LF"
		SD2->(MsUnLock())
		
		aItensAux:={}
		aadd(aItensAux,{"D2_ITEM"	,SD2->D2_ITEM			,Nil})
		AADD(aItensAux,{"D2_COD"	,SD2->D2_COD								,Nil})
		AADD(aItensAux,{"D2_LOCAL"	,SD2->D2_LOCAL								,Nil})
		AADD(aItensAux,{"D2_QUANT"	,SD2->D2_QUANT				,Nil})
		AADD(aItensAux,{"D2_PRCVEN",SD2->D2_PRCVEN				,Nil})
		AADD(aItensAux,{"D2_TOTAL"	,SD2->D2_TOTAL,Nil})
		AADD(aItensAux,{"D2_TES"	,SD2->D2_TES							,Nil})
		AADD(aItens, aItensAux)
		SD2->(DbSkip())
	EndDo
	
	aCabec:={}
		
	AADD(aCabec,{"F2_TIPO"   	,SF2->F2_TIPO										})
	AADD(aCabec,{"F2_FORMUL" 	,SF2->F2_FORMUL										})
	AADD(aCabec,{"F2_DOC"    	,SF2->F2_DOC  				})
	AADD(aCabec,{"F2_SERIE"  	,SF2->F2_SERIE				})
	AADD(aCabec,{"F2_EMISSAO"	,SF2->F2_EMISSAO			})
	AADD(aCabec,{"F2_CLIENTE"	,SF2->F2_CLIENTE								})
	AADD(aCabec,{"F2_LOJA"   	,SF2->F2_LOJA								})
	AADD(aCabec,{"F2_COND"		,SF2->F2_COND									})
	AADD(aCabec,{"F2_ESPECIE"	,SF2->F2_ESPECIE	})
	
	lMsErroAuto := .F.
	
	MATA920(aCabec,aItens,5)
	
	If lMsErroAuto
		DisarmTransaction()
		U_WML03ERRO(cAliasPZQ,MemoRead( NomeAutoLog() ),"E")			// Gravar Msg de Erro
	Else
		
		For nXnd:=1 To Len(aRecSD2)
			SD2->(DbGoTo(aRecSD2[nXnd]))
			SD2->(RecLock("SD2",.F.))
			SD2->D2_ORIGLAN:="LO"
			SD2->(MsUnLock())
		Next
		cChave:=xFilial("SFT")+"S"+(cAliasPZQ)->(PZQ_SERPRT+PZQ_DOCPRT)+cCliForn+cLojaCliFor
		SFT->(DbSetOrder(1)) //FT_FILIAL, FT_TIPOMOV, FT_SERIE, FT_NFISCAL, FT_CLIEFOR, FT_LOJA, FT_ITEM, FT_PRODUTO
		SFT->(MsSeek(cChave))
		Do While SFT->(!Eof())  .And. SFT->(FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA)==cChave
			RecLock("SFT",.F.)
			SFT->FT_OBSERV :="CF CANCELADA"
			SFT->(MSUnLock())
			SFT->(DBSkip())
		EndDo
		
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_DOCPRT:="XXXXXXXXX"
		(cAliasPZQ)->PZQ_SERPRT:="XXX"
		(cAliasPZQ)->PZQ_STATUS :="X"
		(cAliasPZQ)->(MsUnLock())
		
	EndIf
	
	
	
	End Transaction
Next
dDataBase:=dDataAtu 

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML06JOB", "Cancelamento dos Cupons tipo Opera็ใo CA", "FISCAL", MsDate(), "F" )


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML06  บAutor  ณMicrosiga           บ Data ณ  06/11/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FoundNota(cAliasPZQ,nRecNota,lMovSaida)
Local lRetorno:=.F.
Local aAreaAtu	:=GetArea()
Local cQryAlias:=GetNextAlias()
Local cTbSF2		:= "%SF2"+cEmpAnt+"0 SF2%"
Local cTbSF1		:= "%SF1"+cEmpAnt+"0 SF1%"

nRecNota:=0

If lMovSaida
	
	BeginSQL Alias cQryAlias
		SELECT R_E_C_N_O_ RECNF
		FROM  %exp:cTbSF2%
		WHERE F2_FILIAL =%Exp:cFilAnt%
		AND SF2.F2_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF2.F2_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF2.F2_CLIENTE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF2.F2_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF2.F2_YCODMOV=%Exp:(cAliasPZQ)->PZQ_CODMOV%
		AND SF2.%notDel%
	EndSQL
	
Else
	BeginSQL Alias cQryAlias
		SELECT R_E_C_N_O_ RECNF
		FROM  %exp:cTbSF1%
		WHERE F1_FILIAL =%Exp:cFilAnt%
		AND SF1.F1_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF1.F1_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF1.F1_FORNECE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF1.F1_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF1.F1_YCODMOV=%Exp:(cAliasPZQ)->PZQ_CODMOV%
		AND SF1.%notDel%
	EndSQL
EndIf

If !(cQryAlias)->(Eof() .And. Bof())
	nRecNota	:=(cQryAlias)->RECNF
	lRetorno	:=.T.
EndIf

(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)
Return lRetorno



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML06  บAutor  ณMicrosiga           บ Data ณ  06/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User  Function WML06BACA()
Local cAliasPZQ
Local cQryAlias:=GetNextAlias()
Local cTbSF2		:= "%SF2030 SF2%"
Local cTbSF1		:= "%SF1030 SF1%"
Local cTbPZQ		:= "%PZQ010 PZQ%"
Local cModo			:=""
Local cBaca			:="8"

RpcSetEnv("03","01")
//cAliasPZQ:=GetNextAlias()
//EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)

cTeste:="xx"

If cBaca=="1"
	
	BeginSQL Alias cQryAlias
		SELECT PZQ.R_E_C_N_O_ RECPZQ,SF2.F2_DOC,SF2.F2_SERIE,SF2.R_E_C_N_O_ RECSF2
		FROM  %exp:cTbSF2%,%exp:cTbPZQ%
		WHERE F2_FILIAL      BETWEEN '  ' 	AND 'ZZ'
		AND SF2.F2_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF2.F2_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF2.F2_CLIENTE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF2.F2_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF2.F2_YCODMOV=PZQ.PZQ_CODMOV
		//AND PZQ.PZQ_DOCPRT=' '
		AND PZQ.PZQ_OPER IN ('TLS')
		AND SF2.%notDel%
		AND PZQ.%notDel%
	EndSQL
	cQuery:=GetLastQuery()[2]
	
	Do While !(cQryAlias)->(Eof())
		SF2->(DbGoTo((cQryAlias)->RECSF2))
		(cAliasPZQ)->(DbGoTo((cQryAlias)->RECPZQ))
		RecLock("SF2",.F.)
		SF2->F2_YWMLJDE:=(cAliasPZQ)->PZQ_LJDES
		SF2->F2_YEMPFIL:=(cAliasPZQ)->(PZQ_EMPDTL+PZQ_FILDTL)
		SF2->(MsUnLock())
		
		/*(cAliasPZQ)->(DbGoTo((cQryAlias)->RECPZQ))
		RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_DOCPRT:=(cQryAlias)->F2_DOC
		(cAliasPZQ)->PZQ_SERPRT:=(cQryAlias)->F2_SERIE
		(cAliasPZQ)->PZQ_TPOPER:="S"
		(cAliasPZQ)->PZQ_STATUS :="2"
		(cAliasPZQ)->PZQ_NUMORC='REPRO'
		(cAliasPZQ)->(MsUnLock())*/
		
		
		(cQryAlias)->(DbSkip())
	EndDo
	
	(cQryAlias)->(DbCloseArea())
	
	BeginSQL Alias cQryAlias
		SELECT PZQ.R_E_C_N_O_ RECPZQ,SF1.F1_DOC,SF1.F1_SERIE,SF1.R_E_C_N_O_ RECSF1
		FROM  %exp:cTbSF1%,%exp:cTbPZQ%
		WHERE F1_FILIAL      BETWEEN '  ' 	AND 'ZZ'
		AND SF1.F1_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF1.F1_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF1.F1_FORNECE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF1.F1_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF1.F1_YCODMOV=PZQ.PZQ_CODMOV
		AND PZQ.PZQ_OPER IN ('TLE')
		//AND PZQ.PZQ_DOCPRT=' '
		//AND PZQ.PZQ_OPER NOT IN ('VE','TRV')
		AND SF1.%notDel%
		AND PZQ.%notDel%
	EndSQL
	
	cQuery:=GetLastQuery()[2]
	Do While !(cQryAlias)->(Eof())
		SF1->(DbGoTo((cQryAlias)->RECSF1))
		(cAliasPZQ)->(DbGoTo((cQryAlias)->RECPZQ))
		RecLock("SF1",.F.)
		SF1->F1_YWMLJOR:=(cAliasPZQ)->PZQ_LJORIG
		SF1->F1_YEMPFIL:=(cAliasPZQ)->(PZQ_EMPOTL+PZQ_FILOTL)
		SF1->(MsUnLock())
		/*RecLock(cAliasPZQ,.F.)
		(cAliasPZQ)->PZQ_DOCPRT:=(cQryAlias)->F1_DOC
		(cAliasPZQ)->PZQ_SERPRT:=(cQryAlias)->F1_SERIE
		(cAliasPZQ)->PZQ_TPOPER:="E"
		(cAliasPZQ)->PZQ_STATUS :="2"
		(cAliasPZQ)->PZQ_NUMORC='REPRO'
		(cAliasPZQ)->(MsUnLock())*/
		(cQryAlias)->(DbSkip())
	EndDo
	
	(cQryAlias)->(DbCloseArea())
	
ElseIf cBaca=="2"
	
	BeginSQL Alias cQryAlias
		SELECT F2_FILIAL,F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA,F2_YCODMOV,F2_YLOJAWM,F2_YTOPER
		FROM  %exp:cTbSF2%
		WHERE F2_FILIAL      BETWEEN '  ' 	AND 'ZZ'
		AND SF2.F2_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF2.F2_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF2.F2_CLIENTE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF2.F2_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF2.F2_YCODMOV<>' '
		AND SF2.%notDel%
	EndSQL
	SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM
	Do While !(cQryAlias)->(Eof())
		cChave:=(cQryAlias)->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA	)
		SD2->(MsSeek(cChave))
		Do While SD2->(!Eof())  .And. SD2->(D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)==cChave
			RecLock("SD2",.F.)
			SD2->D2_YCODMOV:=(cQryAlias)->F2_YCODMOV
			SD2->D2_YLOJAWM:=(cQryAlias)->F2_YLOJAWM
			SD2->D2_YTOPER	:=(cQryAlias)->F2_YTOPER
			
			SD2->(MSUnLock())
			SD2->(DBSkip())
		EndDo
		
		
		
		(cQryAlias)->(DbSkip())
	EndDo
	
ElseIf cBaca=="3"
	
	BeginSQL Alias cQryAlias
		SELECT SA2.R_E_C_N_O_ RECSA2
		FROM SA2030 SA2
		WHERE A2_FILIAL=' '
		AND SA2.A2_NATUREZ=' '
		AND SA2.D_E_L_E_T_=' '
		AND EXISTS ( SELECT 'X ' FROM SF1030 WHERE F1_FILIAL BETWEEN ' ' AND 'ZZ' AND F1_FORNECE=A2_COD AND SF1030.D_E_L_E_T_=' ' AND SF1030.F1_YCODMOV<>' ')
	EndSQL
	
	Do While (cQryAlias)->(!Eof())
		
		
		SA2->(DbGoTo( (cQryAlias)->RecSA2  ))
		
		cMun	  		:=Upper(SA2->A2_MUN)
		cEstado		:=SA2->A2_EST
		cCodMun		:=""
		
		
		cMun:=StrTran(cMun,"ร","A")
		cMun:=StrTran(cMun,"ี","O")
		cMun:=StrTran(cMun,"ว","C")
		cMun:=NoAcento(cMun)
		cMun:=Padr(cMun,Len(CC2->CC2_MUN))
		
		CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
		If CC2->(MsSeek(xFilial("CC2")+cMun))
			Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==cMun
				If CC2->CC2_EST==cEstado
					cCodMun	:= CC2->CC2_CODMUN
				EndIf
				CC2->(DbSkip())
			EndDo
		EndIf
		
		aVetor:={}
		AADD(aVetor,{"A2_COD" 		,SA2->A2_COD,Nil})
		AADD(aVetor,{"A2_LOJA" 		,SA2->A2_LOJA,Nil})
		AADD(aVetor,{"A2_COD_MUN" 	,cCodMun ,Nil})
		AADD(aVetor,{"A2_MUN" 		,cMun ,Nil})
		AADD(aVetor,{"A2_INSCR" 	,"ISENTO" ,Nil})
		
		
		cWhere:=" AND SA2.A2_EST='"+SA2->A2_EST+"'"
		cWhere+=" AND 	SA2.A2_LOJA='CF'"
		cWhere:="%"+cWhere+"%"
		
		BeginSQL Alias "SA2NEW"
			SELECT A2_NATUREZ,A2_CONTA,A2_TIPO,A2_CODPAIS,A2_PAIS
			FROM %Table:SA2% SA2
			WHERE SA2.A2_FILIAL = %xfilial:SA2%
			%Exp:cWhere%
			AND SA2.%notDel%
		EndSQL
		
		AADD(aVetor,{"A2_NATUREZ" 	,SA2NEW->A2_NATUREZ ,Nil})
		AADD(aVetor,{"A2_CONTA" 	,SA2NEW->A2_CONTA ,Nil})
		
		AADD(aVetor,{"A2_CODPAIS"	,SA2NEW->A2_CODPAIS ,Nil})
		AADD(aVetor,{"A2_PAIS"  	,SA2NEW->A2_PAIS ,Nil})
		
		BEGIN TRANSACTION
		
		lMsErroAuto:=.F.
		CC2->(DBSETORDER(1))
		MSExecAuto({|x,y| MATA020(x,y)},aVetor, 4)
		
		If lMsErroAuto
			U_WML03ERRO(cAliasPZQ,MemoRead( NomeAutoLog() ),"E")			// Gravar Msg de Erro
			RollBackSXe()
		Else
			cCliForn		:=SA2->A2_COD
			cLojaCliFor	:=SA2->A2_LOJA
		Endif
		END TRANSACTION
		
		
		SA2NEW->(DbCloseArea())
		
		(cQryAlias)->(DbSkip())
		
	EndDo
	
	
	(cQryAlias)->(DbCloseArea())
	
ElseIf cBaca=="4"
	
	BeginSQL Alias cQryAlias
		SELECT F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA
		FROM  %exp:cTbSF2%
		WHERE F2_FILIAL      BETWEEN '  ' 	AND 'ZZ'
		AND SF2.F2_DOC 		BETWEEN '     ' 	AND 'ZZZZZZZZZ'
		AND SF2.F2_SERIE 		BETWEEN ' '		 	AND 'ZZ'"
		AND SF2.F2_CLIENTE 	BETWEEN '      ' 	AND 'ZZZZZZ'
		AND SF2.F2_LOJA   	BETWEEN '  ' 		AND 'ZZ'
		AND SF2.F2_YTOPER='TLS'
		AND SF2.D_E_L_E_T_='*'
	EndSQL
	
	SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM
	SF3->(DbSetOrder(5)) //F3_FILIAL, F3_SERIE, F3_NFISCAL, F3_CLIEFOR, F3_LOJA, F3_IDENTFT
	SFT->(DbSetOrder(1)) //FT_FILIAL, FT_TIPOMOV, FT_SERIE, FT_NFISCAL, FT_CLIEFOR, FT_LOJA, FT_ITEM, FT_PRODUTO
	
	Do While !(cQryAlias)->(Eof())
		
		cChave:=(cQryAlias)->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
		If SF2->(MsSeek(cChave))
			RecLock("SF2",.F.)
			SF2->(DbDelete())
			SF2->(MSUnLock())
		EndIf
		SD2->(MsSeek(cChave))
		Do While SD2->(!Eof())  .And. SD2->(D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)==cChave
			RecLock("SD2",.F.)
			SD2->(DbDelete())
			SD2->(MSUnLock())
			SD2->(DBSkip())
		EndDo
		
		cChave:=(cQryAlias)->(F2_FILIAL+F2_SERIE+F2_DOC+F2_CLIENTE+F2_LOJA)
		If SF3->(MsSeek(cChave))
			RecLock("SF3",.F.)
			SF3->(DbDelete())
			SF3->(MSUnLock())
		EndIf
		
		cChave:=(cQryAlias)->F2_FILIAL+"S"+(cQryAlias)->(F2_SERIE+F2_DOC+F2_CLIENTE+F2_LOJA)
		SFT->(MsSeek(cChave))
		Do While SFT->(!Eof())  .And. SFT->(FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA)==cChave
			RecLock("SFT",.F.)
			SFT->(DbDelete())
			SFT->(MSUnLock())
			SFT->(DBSkip())
		EndDo
		(cQryAlias)->(DbSkip())
	EndDo
	
ElseIf cBaca=="5"
	
	BeginSQL Alias cQryAlias
		SELECT SA2.R_E_C_N_O_ RECSA2,F1_YCODMOV,F1_YTOPER
		FROM SA2030 SA2,SF1030 SF1
		WHERE A2_FILIAL=' '
		AND SA2.D_E_L_E_T_=' '
		AND F1_FILIAL BETWEEN ' ' AND 'ZZ'
		AND F1_FORNECE=A2_COD
		AND F1_LOJA=A2_LOJA
		AND SF1.F1_YCODMOV<>' '
		AND SF1.D_E_L_E_T_=' '
	EndSQL
	
	cAliasPZR	:=GetNextAlias()
	EmpOpenFile(cAliasPZR,"PZR",2,.T.,"01",@cModo)
	
	Do While (cQryAlias)->(!Eof())
		SA2->(DbGoTo( (cQryAlias)->RecSA2  ))
		
		If (cAliasPZR)->(MsSeek(Space(2)+(cQryAlias)->(F1_YTOPER+F1_YCODMOV)))
			
			cCep			:=AllTrim((cAliasPZR)->PZR_CEP)
			cTelefone	:=AllTrim((cAliasPZR)->PZR_TEL)
			
			cTelefone	:=StrTran(cTelefone,"(","")
			cTelefone	:=StrTran(cTelefone,")","")
			cTelefone	:=StrTran(cTelefone,"-","")
			cTelefone	:=StrTran(cTelefone," ","")
			
			cCep			:=StrTran(cCep,"-","")
			cCep			:=StrTran(cCep,".","")
			
			SA2->(RecLock("SA2",.F. ))
			SA2->A2_CEP:=cCep
			
			SA2->A2_DDD:=Left(cTelefone,2)
			SA2->A2_TEL:=SubStr(cTelefone,3)
			
			SA2->(MsUnLock())
		EndIf
		
		(cQryAlias)->(DbSkip())
	EndDo
	
	(cQryAlias)->(DbCloseArea())
	
	
ElseIf cBaca=="6"
	
	BeginSQL Alias cQryAlias
		SELECT SA1.R_E_C_N_O_ RECSA1,F2_YCODMOV,F2_YTOPER
		FROM SA1030 SA1,SF2030 SF2
		WHERE A1_FILIAL=' '
		AND SA1.D_E_L_E_T_=' '
		AND F2_FILIAL BETWEEN ' ' AND 'ZZ'
		AND F2_CLIENTE=A1_COD
		AND F2_LOJA=A1_LOJA
		AND SF2.F2_YCODMOV<>' '
		AND SF2.D_E_L_E_T_=' '
	EndSQL
	
	cAliasPZR	:=GetNextAlias()
	EmpOpenFile(cAliasPZR,"PZR",2,.T.,"01",@cModo)
	
	Do While (cQryAlias)->(!Eof())
		SA1->(DbGoTo( (cQryAlias)->RecSA1  ))
		
		If (cAliasPZR)->(MsSeek(Space(2)+(cQryAlias)->(F2_YTOPER+F2_YCODMOV)))
			
			cCep			:=AllTrim((cAliasPZR)->PZR_CEP)
			cTelefone	:=AllTrim((cAliasPZR)->PZR_TEL)
			
			
			cTelefone	:=StrTran(cTelefone,"(","")
			cTelefone	:=StrTran(cTelefone,")","")
			cTelefone	:=StrTran(cTelefone,"-","")
			cTelefone	:=StrTran(cTelefone," ","")
			
			cCep			:=StrTran(cCep,"-","")
			cCep			:=StrTran(cCep,".","")
			
			SA1->(RecLock("SA1",.F. ))
			
			If !Empty(cCep)
				SA1->A1_CEP:=cCep
			EndIf
			
			If !Empty(cTelefone)
				SA1->A1_DDD:=Left(cTelefone,2)
				SA1->A1_TEL:=SubStr(cTelefone,3)
			EndIf
			
			SA1->(MsUnLock())
		EndIf
		
		(cQryAlias)->(DbSkip())
	EndDo
	
	(cQryAlias)->(DbCloseArea())
	
ElseIf cBaca=="7"
	
	cDiretorio:="\BASE\"
	aDirectory:=Directory(cDiretorio+"*.DBF")
	aSort(aDirectory,,,{|x,y| x[1]<y[1]})
	For nInd:=1 To Len(aDirectory)
		cNomeArq:=RetArq(,aDirectory[nInd,1])
		cAliasProc:=cNomeArq
		DbUseArea( .T.,"DBFCDXADS" , cDiretorio+aDirectory[nInd,1], cAliasProc, .F. )
		
		If Select(cAliasProc)==0
			Loop
		EndIf
		
		(cAliasProc)->(__dBPack())
		lTemReg:=.F.
		(cAliasProc)->(DbGoTop())
		Do While (cAliasProc)->(!Eof())
			lTemReg:=.T.
			Exit
		EndDo
		
		(cAliasProc)->(DbCloseArea())
		
		If !lTemReg
			Ferase(cDiretorio+aDirectory[nInd,1])
			Ferase(cDiretorio+cAliasProc+".fpt")
		EndIf
	Next
	
ElseIf cBaca=="8"
	
	DbUseArea( .T.,"DBFCDXADS" , "\webmanager\prod.dbf", "Work", .F. )
	
	Do While Work->(!Eof())
		
		cCodProdCli	:=AllTrim(Work->WEBM)
		cCodSB1		:=AllTrim(Work->PROT)
		
		U_NCGRAVASA7("000000","01",cCodProdCli,"CARGA",cCodSB1)
		
		Work->(DbSkip())
		
	EndDo
	
	
EndIf


Return
