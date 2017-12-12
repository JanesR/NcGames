#Include "PROTHEUS.CH "
//MV_DTLIMIT

#DEFINE STS_PROCOK   	"1"
#DEFINE STS_PROCER   	"E"

Static lRecalcular:=.F.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML03  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML03JOB(aDados)
Default aDados := {"03","02"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWML03()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML03  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWML03()
ChkFile("PZQ")
ChkFile("PZR")
Processa({|| ExecBlock("WML03GERAR") }, " Gera Cupons Fiscais ", "Interface de Dados")
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
User Function WML03Gerar()
Local aAreaAtu		:= GetArea()
Local cQryAlias		:= GetNextAlias()
Local aDados		:= {}
Local cModo			:= ""
Local cTbPZQ		:= "%PZQ010 " + "PZQ%"
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
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_NUMORC=' '
	AND PZQ_DOC<>'0'
	AND PZQ.PZQ_OPER IN ('VE','TRV','CA')
	AND PZQ.%notDel%
	ORDER BY PZQ_EMPDES,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV
	
EndSQL

ProcRegua(2)

Conout("")
Conout(AllTrim(GetLastQuery()[2]))
Conout("")

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
	//AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML03GRAVAR" ),nContar++, )   }  )

	Conout( Replicate("$",80) + CRLF + "   - Gerando WML03 - " + aDadosAux[1,1] + " / " + aDadosAux[1,2] + CRLF + Replicate("$",80))
	U_WML03Gravar(aDadosAux)
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
User Function WML03Gravar(aDados, lMultiT )
Local cModo
Local cAliasPZQ
Local cAliasPZR
Local cChavePZR
Local aRecnos			:=	aDados[2]
Local aItensAux			:= {}
Local aCabec			:= {}
Local aItens			:= {}
Local aSL4				:= {}
Local cChave
Local aProdNot
Local cPDV
Local cChaveDOC
Local cChaveSFT
Local aProdutos:={}
Local lMovSaida
Local aParam:={}
Local nTam     := 0
Local cProduto
Local cCliPadrao	:= Getmv("MV_CLIPAD",,"000001") 
Local cLojaPadrao	:= GetMv("MV_LOJAPAD",,"01")
Local cCodVend		:= GetMv("MV_VENDPAD",,"000001")
Local cNfSerie		:= GetMv("MV_LOJANF",,"CF")
Local cMsgErro		:= ""
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
Local cChaveSL2
Local cProdNEnc	:= ""//Produto nใo encontrado
Local lDuplicado
Local nAscan   
Local nLinha

Private aNCPrecos

Default lMultiT := .t.

// ----------------------------------------------
// Se for processamento em MultitThread - Prep.Env.
If lMultiT
	RpcClearEnv()
	RpcSettype(3)
	RpcSetEnv(aDados[1,1],aDados[1,2])
EndIf


u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML03JOB", "Grava็ใo dos Or็amentos (SL1 e SL2)  das Opera็๕es VE,TRV e CA", "FISCAL", MsDate() )

cAliasPZQ	:=GetNextAlias()
cAliasPZR	:=GetNextAlias()
nLenD2Item	:=AvSx3("D2_ITEM",3)
nLenD1Item	:=AvSx3("D1_ITEM",3)
nLenB1Cod	:=AvSx3("B1_COD",3)

dDataAtu		:=dDataBase

EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)
EmpOpenFile(cAliasPZR,"PZR",2,.T.,"01",@cModo)

ChkFile("SL1")
ChkFile("SB0")
SB0->(dbSetOrder(1))

aProdNot:={}
For nYnd:=1 To Len(aRecnos)
	  
	
	(cAliasPZQ)->(DbGoTo(aRecnos[nYnd]))
	
	cChavePZR:=(cAliasPZQ)->(PZQ_FILIAL+PZQ_OPER+PZQ_CODMOV)//PZR_FILIAL+PZR_OPER+PZR_CODMOV+PZR_SEQ
	If !(cAliasPZR)->(MsSeek(cChavePZR))
		Loop
	EndIf
	cCodWMMov	:=(cAliasPZQ)->PZQ_CODMOV
	cCodWMLoja	:=(cAliasPZQ)->PZQ_CODLOJ
	
	cPDV:=(cAliasPZR)->PZR_TERMIN
	cEspCupom:=(cAliasPZR)->PZR_CUPMOD
	
	U_WML03ERRO(cAliasPZQ,"","")
	
	PtInternal(1,"Empresa: "+cEmpAnt+" Filial: "+cFilAnt+" - "+(cAliasPZR)->PZR_DOC+" Emissao: "+DTOC((cAliasPZQ)->PZQ_EMISSA)+" Operacao:"+(cAliasPZQ)->PZQ_OPER+" Movimento:"+(cAliasPZQ)->PZQ_CODMOV  )
	
	If ValType(GetMv('MV_ICMPAD'))<>"N"
		U_WML03ERRO(cAliasPZQ,"Cadastro do parametro MV_ICMPAD incorreto para Empresa:"+cEmpAnt+" Filial:"+cFilAnt,"E")// Gravar Msg de Erro
		Loop
	EndIf
	
	If ValType(GetMv('MV_ESTADO'))<>"C"
		U_WML03ERRO(cAliasPZQ,"Cadastro do parametro MV_ESTADO incorreto para Empresa:"+cEmpAnt+" Filial:"+cFilAnt,"E")// Gravar Msg de Erro
		Loop
	EndIf
	
	// ------------------------------------------------------------------------
	// Funcao que verifica se existe pdv e cria se nao existir
	WML03PDV({ 		 (cAliasPZR)->PZR_FILDES /*"LG_FILIAL"*/ ,;
	(cAliasPZR)->PZR_TERMIN /*"LG_CODIGO"*/ ,;
	(cAliasPZR)->PZR_MODECF /*"LG_NOME" */ ,;
	(cAliasPZR)->PZR_MODECF /*"LG_IMPFISC"*/  ,;
	(cAliasPZR)->PZR_SERECF /*"LG_SERIE"*/ ,;
	(cAliasPZR)->PZR_TERMIN /*"LG_PDV"*/ ,;
	AllTRim(Str(Len((cAliasPZR)->PZR_SERECF)))/*"LG_TAMSER"*/ ,;
	(cAliasPZR)->PZR_SERECF /*"LG_SERPDV"*/ } )
	
	cCliForn 	:= ""
	cLojaCliFor	:= ""
	lMovSaida	:=(cAliasPZQ)->PZQ_OPER$"TRV*VE *CA "
	cErroAdic:=""
	// ------------------------------------------------------------------------
	// Funcao que verifica e cadastra cliente
	If !U_WML02CliFor(@cCliForn,@cLojaCliFor,cAliasPZR,cAliasPZQ,.T.,.F. )//PZR deve estar posicionado
		Loop
	EndIf	
	
	// Se nao encontra, utiliza cliente padrao.
	If Empty(cCliForn)
		cErroAdic+="Cliente/Fornecedor vazio" 	
	EndIf
	
	aItens		:= {}
	aSL4		:= {}
	aCabec		:= {}
	nTotItem 	:= 0
	dDataBase:=(cAliasPZQ)->PZQ_EMISSA
	cNfSerie:= "ECF"
	cNFiscalF2:=(cAliasPZQ)->PZQ_DOC //NxtSX5Nota(cNfSerie)
	If Empty(cNFiscalF2) .Or. AllTrim(cNFiscalF2)=="0"
		cNFiscalF2:=GetNota(cNfSerie)
	EndIf
	
	SA1->( DbSeek( xFilial("SA1") + cCliForn + cLojaCliFor ) )
	cCodVend:=U_WML02Vend(cAliasPZR,cAliasPZQ)
	
	SA3->( DbSeek( xFilial("SA3") + cCodVend ) )
	
	//----------- MONTA CABEC --------------
	aAdd(aCabec,{"LQ_VEND"			, PadR(cCodVend,TamSX3("LQ_VEND")[1])			,	Nil })	// Vendedor
	aAdd(aCabec,{"LQ_COMIS"			, 0														,	NIL })	// Comissใo
	aAdd(aCabec,{"LQ_CLIENTE"		, SA1->A1_COD											, 	Nil })	// Cliente
	aAdd(aCabec,{"LQ_LOJA"			, SA1->A1_LOJA											, 	Nil })	// Loja
	aAdd(aCabec,{"LQ_TIPOCLI"		, PadR("F",TamSx3("LQ_TIPOCLI")[1])				,	NIL })	// Tipo de Cliente
	// -------------------------------------
	

	cProdNEnc	:= ""
	lRecalcular:=.F.
	nLinha:=0
	aNCPrecos   :={}
	Do While (cAliasPZR)->(!Eof()) .And. (cAliasPZR)->(PZR_FILIAL+PZR_OPER+PZR_CODMOV)==cChavePZR
		
		aItem    	:= {}
		cProduto	:=Padr( (cAliasPZR)->PZR_PRODUT,nLenB1Cod)
		
		If !SB1->(MsSeek( xFilial("SB1") + cProduto  ))
			cErroAdic	+="Produto "+AllTrim(cProduto)+" nao encontrado.("+ProcName(0)+")" +CRLF
			cProdNEnc 	+= cProduto+CRLF
			
			If Ascan(aProdNot,cProduto)==0
				AADD(aProdNot,cProduto)
			EndIf
		EndIf
		
		nVlrProd:=(cAliasPZR)->PZR_VALOR
		
		nAscan:=Ascan( aNCPrecos,{|a| a[1]==cProduto })		
		AADD(aNCPrecos,{cProduto,nVlrProd,++nLinha} )
		
		If nAscan>0 .And. !lRecalcular .And. nVlrProd<> aNCPrecos[nAscan,2]
			lRecalcular:=.T.
		EndIf
		
		// -----------------------------------------------------
		// CRIA REGISTRO DE ESTOQUE POR FILIAL
		If !SB2->(DbSeek(xFilial("SB2")+cProduto+"01"))
			CriaSB2(cProduto,"01")
		EndIf
		
		// -----------------------------------------------------
		// CRIA PRODUTO NA TABELA DE PRECO - (USANDO SEMPRE TABELA 1 DO LOJA)
		If !( SB0->( MsSeek(xFilial("SB0") + SB1->B1_COD ) ) )
			FCriaSB0( SB1->B1_COD , nVlrProd,.T. )
		Else
			FCriaSB0( SB1->B1_COD , nVlrProd,.F. )
		Endif
		
		If nVlrProd<>SB0->B0_PRV1
			Conout("=============> Pre็o Cupom "+AllTrim(Str(nVlrProd))+" Pre็o SB0 "+AllTrim(Str(SB0->B0_PRV1)) )
		Endif
		
		cTESVenda:="783"
		If (cAliasPZR)->PZR_ALICMS==-2.00
			cTESVenda:="633"
		ElseIf (cAliasPZR)->PZR_ALICMS==-4.00
			cTESVenda:="805"
		EndIf
		
		aAdd(aItem,{"LR_PRODUTO"		,	PadR(AllTrim(cProduto), TamSX3("LR_PRODUTO")[1]),	Nil })	// Cod. do Produto
		aAdd(aItem,{"LR_QUANT"			,	(cAliasPZR)->PZR_QTD										,	Nil })	// Quant. Item
		aAdd(aItem,{"LR_UM"				,	PadR(SB1->B1_UM,TamSx3("LR_UM")[1])					,	NIL })	// Unidade de Medida
		aAdd(aItem,{"LR_DESC"			,	0    															,	NIL })	// Desconto
		aAdd(aItem,{"LR_VALDESC"		,	(cAliasPZR)->PZR_VLDESC									,	NIL })	// Valor de Desconto
		aAdd(aItem,{"LR_DOC"			,	cNFiscalF2             										,	NIL })
		aAdd(aItem,{"LR_SERIE"			,	cNfSerie		             								,	NIL })
		aAdd(aItem,{"LR_PDV" 			,	(cAliasPZR)->PZR_TERMIN              				,	NIL })
		aAdd(aItem,{"LR_TABELA"			,	SuperGetMV( "MV_TABPAD",,"1")							,	NIL })	// Tabela Padrใo
		aAdd(aItem,{"LR_DESCPRO"		,	0														  		,	NIL })	// Desconto do Produto
		aAdd(aItem,{"LR_FILIAL"			,	xFilial("SLR")												,	Nil })	// Filial
		aAdd(aItem,{"LR_VEND"			,	PadR(cCodVend,TamSx3("LR_VEND")[1])					,	Nil })	// Cod. do Vendedor
		aAdd(aItem,{"LR_TES"			,	cTesVenda	    												,	Nil })
		aAdd(aItem,{"LR_VRUNIT"			,	nVlrProd														,	Nil })	// Valor Unitแrio do Item
		aAdd(aItens,aItem)
		
		nTotItem += (nVlrProd*(cAliasPZR)->PZR_QTD)-(cAliasPZR)->PZR_VLDESC
		
		If SB2->B2_CM1==0
			SB2->(RecLock("SB2",.F.))
			SB2->B2_CM1:=(nVlrProd)/2
			SB2->(MsUnLock())
		EndIf
		U_WML02SB9(SB2->B2_COD,"01",SB2->B2_CM1)
		
		
		(cAliasPZR)->(DbSkip())
	EndDo

	If Len(aItens)>0
		// -------------------------------------------
		// FORMA DE PAGAMENTO
		// -------------------------------------------
		aSL4Aux := {}
		Aadd( aSL4Aux, {"L4_DATA"	, ddatabase								, NIL}	)	// L4_DATA
		Aadd( aSL4Aux, {"L4_VALOR"	, nTotItem								, NIL}	)	// L4_VALOR
		//Aadd( aSL4Aux, {"L4_FORMA"	, "R$"									, NIL}	)	// L4_FORMA
		Aadd( aSL4Aux, {"L4_FORMA"	, "BRL"									, NIL}	)	// L4_FORMA
		Aadd( aSL4Aux, {"L4_ADMINIS", ""									, NIL}	)	// L4_ADMINIS
		Aadd( aSL4Aux, {"L4_FORMAID", ""									, NIL} 	)	// L4_CGC
		Aadd( aSL4Aux, {"L4_MOEDA"	, 1										, NIL}	)	// L4_SITUA
		Aadd( aSL4, aSL4Aux )
		
		// -------------------------------------------
		// CABEวALHO
		// -------------------------------------------
		aAdd(aCabec,{"LQ_VLRTOT"	, A410Arred( nTotItem , "LQ_VLRTOT" )	, NIL }) 	// Valor Total
		aAdd(aCabec,{"LQ_DESCONT"	, 0												, NIL })	// Desconto, por enquanto, 0
		aAdd(aCabec,{"LQ_VLRLIQ"	, A410Arred( nTotItem , "LQ_VLRLIQ" )  , NIL })	// Valor Lํquido
		aAdd(aCabec,{"LQ_NROPCLI" 	, " " 											, NIL })
		aAdd(aCabec,{"LQ_DTLIM"		, ddatabase										, NIL })	// Data Limite
		aAdd(aCabec,{"LQ_EMISSAO"	, ddatabase										, Nil })	// Emissao
		
		aAdd(aCabec,{"LQ_DOC"		, cNFiscalF2									, Nil })
		aAdd(aCabec,{"LQ_SERIE"		, cNfSerie										, Nil })
		aAdd(aCabec,{"LQ_PDV"		, (cAliasPZR)->PZR_TERMIN     			, Nil })
		aAdd(aCabec,{"LQ_EMISNF"	, ddatabase										, Nil })	// Emissao
		aAdd(aCabec,{"LQ_NUMCFIS"	, cNFiscalF2									, Nil }) 	// Numero do cupom fiscal
		aAdd(aCabec,{"LQ_NUMMOV"	, 1												, Nil })
		
		If !Empty(cErroAdic)
			//Envia e-mail para cadastrar produto
			If !Empty(cProdNEnc)
				u_NCCadPrd(cProdNEnc)
			EndIf
			U_WML03ERRO(cAliasPZQ,cErroAdic,"E")// Gravar Msg de Erro
		Else
			SetFunName("LOJA701")
			lMsErroAuto	:= .F.
			cMsgErro	:= ""
			nOpcao:=3
			MSExecAuto({|a,b,c,d,e,f,g,h| LOJA701(a,b,c,d,e,f,g,h)},.F.,nOpcao,SA1->A1_COD,SA1->A1_LOJA,{},aCabec,aItens,aSL4)
			
			lDuplicado:=.F.
			If IsDuplic(SL1->L1_FILIAL,SL1->L1_NUM,cCodWMLoja)
				lDuplicado:=.T.
				lMsErroAuto:=.T.
			EndIf
			
			If lMsErroAuto
				If lDuplicado
					cMsgErro := "Orcamento "+SL1->L1_NUM+" duplicado no PZQ CodMov:"+(cAliasPZQ)->PZQ_CODMOV
					Conout(cMsgErro)
				Else
					cMsgErro := MemoRead( NomeAutoLog() )
					MostraErro('cPath',NomeAutoLog())//Apagar o arquivo atual
				EndIf
				U_WML03ERRO(cAliasPZQ,cMsgErro,"E")	// Gravar Msg de Erro
				RollBackSX8()
				
			Else
				ConfirmSx8()
				// ---------------------------------
				// Gravar dados adicionais
				Begin Transaction
				
				RecLock("SL1",.F.)
				SL1->L1_YCODMOV:=(cAliasPZQ)->PZQ_CODMOV
				SL1->L1_YLOJAWM:=(cAliasPZQ)->PZQ_CODLOJ
				SL1->L1_YTOPER	:=(cAliasPZQ)->PZQ_OPER
				SL1->L1_PDV 	:=cPDV
				
				SL1->(MsUnLock())
				
				SL2->(DbSetOrder(1))//L2_FILIAL+L2_NUM+L2_ITEM+L2_PRODUTO
				cChaveSL2:=xFilial("SL2")+SL1->L1_NUM
				SL2->(MsSeek(cChaveSL2))
				Do While SL2->(!Eof())  .And. SL2->(L2_FILIAL+L2_NUM)==cChaveSL2
					RecLock("SL2",.F.)
					SL2->L2_PRCTAB:=SL2->L2_VRUNIT
					SL2->L2_ESPECIE=cEspCupom
					SL2->(MsUnLock())
					SL2->(DbSkip())
				EndDo
				
				
				RecLock(cAliasPZQ,.F.)
				(cAliasPZQ)->PZQ_STATUS := STS_PROCOK
				(cAliasPZQ)->PZQ_TPOPER := "S"
				(cAliasPZQ)->PZQ_FILORC	:= SL1->L1_FILIAL
				(cAliasPZQ)->PZQ_NUMORC	:= SL1->L1_NUM
				(cAliasPZQ)->(MsUnLock())
				End Transaction
				
			EndIf
			
			
			
		EndIf
		
		
	EndIf
	
	
	
Next nYnd

dDataBase:=dDataAtu

u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML03JOB", "Grava็ใo dos Or็amentos (SL1 e SL2)  das Opera็๕es VE,TRV e CA", "FISCAL", MsDate(), "F" )

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
Local aRetorno	:={"","",""}
Local cQryAlias:=GetNextAlias()


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
	AND SD2.D2_COD=%Exp:cCodMov%
	AND SD2.%notDel%
EndSQL

If !(cQryAlias)->(Eof() .And. Bof())
	(cQryAlias)->( aRetorno:={D2_DOC,D2_SERIE,D2_ITEM} )
EndIf


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
User Function WML03NCM()
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
FT_FUSE('\Atualiza\PRODNCM.csv')  //ABRIR
FT_FGOTOP() //PONTO NO TOPO

Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	cBuffer := FT_FREADLN() //LENDO LINHA
	aLinhas :=Separa(cBuffer,";")
	
	cChaveSBZ:="02"+AllTrim(aLinhas[1])
	
	If !(cAliasSBZ)->(MsSeek(cChaveSBZ))
		Loop
	EndIf
	
	//For nInd:=1 To Len(aFiliais)
	
	//If aFiliais[nInd]=="02"
	//Loop
	//EndIf
	
	aConexoes:=GetUserInfoArray()
	nContar:=0
	AEVAL( aConexoes, {|a| IIf( (a[6]==GetEnvServer() .And. AllTrim(Upper(a[5]))=="U_WML02SBZ" ),nContar++, )   }  )
	aDadosAux:={"03","",aLinhas[2],AllTrim(aLinhas[1]),aLinhas[3]=="S",cAliasSBZ}
	StartJob( "U_WML02SBZ",GetEnvServer(), nContar>=20, aDadosAux)//
	//U_WML02SBZ(aDadosAux)
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
User Function WML03SBZ(aDados)
Local cQryAlias
Local cAliasSBZ:=aDados[6]
Local cWhere
Local lAppend
Local nInd
Local cModo:=""
Local aFiliais

RpcClearEnv()
RpcSettype(3)
RpcSetEnv("03","01")

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
ฑฑบPrograma  ณNCIWML02  บAutor  ณMicrosiga           บ Data ณ  05/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML03ACERT()
Local cQryAlias
Local cWhere

RpcClearEnv()
RpcSettype(3)
RpcSetEnv("03","01")
cQryAlias:=GetNextAlias()

cWhere:=" SF1.F1_FILIAL Between '  ' And '99'
cWhere+=" AND SF1.F1_YCODMOV<>' '"

cWhere:="%"+cWhere+"%"


BeginSQL Alias cQryAlias
	SELECT SF1.R_E_C_N_O_ RECSF1
	FROM %Table:SF1% SF1
	WHERE %Exp:cWhere%
	AND SF1.%notDel%
EndSQL

SD1->(DbSetOrder(1))//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
Do While (cQryAlias)->(!Eof())
	
	SF1->( DbGoTo((cQryAlias)->RECSF1) )
	cChave:=SF1->(F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
	SD1->(MsSeek(cChave))
	Do While SD1->(!Eof()) .And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA)==cChave
		SD1->(RecLock("SD1",.F.))
		SD1->(DbDelete())
		SD1->(MsUnLock())
		SD1->(DbSkip())
	EndDo
	
	SF1->(RecLock("SF1",.F.))
	SF1->(DbDelete())
	SF1->(MsUnLock())
	
	
	(cQryAlias)->(DbSkip())
EndDo


(cQryAlias)->(DbCloseArea())


cWhere:=" SF3.F3_FILIAL Between '  ' And '99'
cWhere+=" AND SF3.F3_EMISSAO>'20150501'"

cWhere:="%"+cWhere+"%"

BeginSQL Alias cQryAlias
	SELECT SF3.R_E_C_N_O_ RECSF3
	FROM %Table:SF3% SF3
	WHERE %Exp:cWhere%
EndSQL


SFT->(DbSetOrder(1)) //FT_FILIAL, FT_TIPOMOV, FT_SERIE, FT_NFISCAL, FT_CLIEFOR, FT_LOJA, FT_ITEM, FT_PRODUTO
Do While (cQryAlias)->(!Eof())
	SF3->( DbGoTo((cQryAlias)->RECSF3) )
	cChave:=SF3->(F3_FILIAL+"S"+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA)
	SFT->(MsSeek(cChave))
	Do While SFT->(!Eof())  .And. SFT->(FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA)==cChave
		RecLock("SFT",.F.)
		SFT->(DbDelete())
		SFT->(MSUnLock())
		SFT->(DBSkip())
	EndDo
	SF3->(RecLock("SF3",.F.))
	SF3->(DbDelete())
	SF3->(MsUnLock())
	
	(cQryAlias)->(DbSkip())
EndDo


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWML03PDV  บAutor  ณJeferson           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Funcao para gravar o PDV caso nao exista                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WML03PDV(aDados)

// Prepara aCols com todas as impressoras cadastradas

If SLG->( !MSSeek( aDados[1] + aDados[02] ) )
	
	SLG->( RecLock("SLG", .T.  ) )
	SLG->LG_FILIAL		:= aDados[01]	// Filial do PDV
	SLG->LG_CODIGO		:= aDados[02]	// Codigo do PDV
	SLG->LG_NOME		:= aDados[03]	// Nome do PDV
	SLG->LG_IMPFISC	    := aDados[04]	// C๓digo da Imp. Fiscal
	SLG->LG_SERIE		:= aDados[05]	// Serie
	SLG->LG_PDV			:= aDados[06]	// PDV
	SLG->LG_TAMSER		:= aDados[07]	// Tamanho da Serie
	SLG->LG_SERPDV		:= aDados[08]	// Serie PDV
	SLG->( MsUnLock() )
	
Endif

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFCriaSB0  บAutor  ณJeferson           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Funcao para gravar o produto na tabela de precos do loja  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FCriaSB0(cCod,nPrc,lAppend)

If RecLock("SB0",lAppend)
	SB0->B0_FILIAL	:= xFilial("SB0")
	SB0->B0_COD		:= cCod
	SB0->B0_PRV1	:= nPrc
	SB0->(MsUnlock())
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetNota  บAutor  ณMicrosiga           บ Data ณ  05/25/15   บฑฑ
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
cNumNota:=MA461NumNf(NIL,cNfSerie,NIL,NIL)
RestArea(aAreaAtu)
Return cNumNota

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML03  บAutor  ณMicrosiga           บ Data ณ  06/05/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML03ERRO(cAliasPZQ,cMsgErro,cCodErr)
Default cCodErr := STS_PROCER
//Begin Transaction
RecLock(cAliasPZQ,.F.)
(cAliasPZQ)->PZQ_STATUS := cCodErr
(cAliasPZQ)->PZQ_MSG    := cMsgErro
(cAliasPZQ)->(MsUnLock())

//End Transaction

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML03  บAutor  ณMicrosiga           บ Data ณ  06/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WL03Clear()
RpcSetEnv("03","01")


TcSqlExec("TRUNCATE TABLE PZQ010")
TcSqlExec("TRUNCATE TABLE PZR010")
TcSqlExec("TRUNCATE TABLE PZX010")
TcSqlExec("TRUNCATE TABLE PZK010")

//TcSqlExec("TRUNCATE TABLE SL1030")
//TcSqlExec("TRUNCATE TABLE SL2030")

//TcSqlExec("TRUNCATE TABLE SF1030")
//TcSqlExec("TRUNCATE TABLE SD1030")


//TcSqlExec("TRUNCATE TABLE SF2030")
//TcSqlExec("TRUNCATE TABLE SD2030")


//TcSqlExec("TRUNCATE TABLE SF3030")
//TcSqlExec("TRUNCATE TABLE SFT030")


//TcSqlExec("TRUNCATE TABLE SB1030")
//TcSqlExec("TRUNCATE TABLE SB5030")
//TcSqlExec("TRUNCATE TABLE SBZ030")



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML03  บAutor  ณMicrosiga           บ Data ณ  06/15/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function IsDuplic(cFilSL1,cOrcSL1,cCodLoja)
Local aAreaAtu	:=GetArea()
Local cQryAlias	:="_DUPLIC"
Local cTbPZQ	:= "%PZQ010 " + "PZQ%"
Local lDuplicado

BeginSQL Alias cQryAlias
	SELECT Count(1) Contar
	FROM  %exp:cTbPZQ%
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_NUMORC= %Exp:cOrcSL1%
	AND PZQ.PZQ_CODLOJ= %Exp:cCodLoja%
	AND PZQ.PZQ_OPER IN ('VE','TRV','CA')
	AND PZQ.%notDel%
EndSQL



lDuplicado:=(cQryAlias)->Contar>1
(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return lDuplicado


User Function LJ7061()
Local nAscan
Local cCodProd	:=GdFieldGet("LR_PRODUTO")
Local nPosPreco :=GdFieldPos("LR_VRUNIT")   	

If lRecalcular .And. (nAscan:=Ascan(aNcPrecos,{|a| a[3]==n .And. a[1]==cCodProd }  ))>0 .And. aNcPrecos[nAscan,2]<>aCols[n,nPosPreco]
	aCols[n,nPosPreco]:=aNcPrecos[nAscan,2]
EndIf

Return .T. 
