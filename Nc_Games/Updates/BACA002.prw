#INCLUDE "PROTHEUS.CH"
STATIC nContAuxNC := 0
STATIC __aDePara := NIL

User Function BACA002()
Local cTabela
Local cAliasTab
Local cAliasQry:=GetNextAlias()
Local cArquivo:=""
Local aTabelas:={'CVG','CVI','CVJ','SBZ','SF4','SF7','SFM','SLG'}//'SZF',
Local cArqInd 	:= CriaTrab(,.F.)		//Nome do arq. temporario

RpcSetEnv("01","06")

For nInd:=1 To Len(aTabelas)
	
	SX2->(DbSeek(aTabelas[nInd]))
	
	cTabela:=AllTrim(SX2->X2_ARQUIVO)
	cAliasTab:=SX2->X2_CHAVE
	ChkFile(cAliasTab)
	cQuery:="Select * From "+cTabela+" Where "+PrefixoCpo(cAliasTab)+"_FILIAL='03' And D_E_L_E_T_=' ' ORDER BY R_E_C_N_O_"
	
	FechaArea(cAliasQry)
	DbUseArea( .T. , 'TOPCONN', TCGENQRY(,,cQuery),cAliasQry, .T., .F. )
	aEval( (cAliasTab)->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cAliasQry,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
	cChaveUnico:=AllTrim(SX2->X2_UNICO)
	bSeek:={||.F.}
	
	cPrefixo:=PrefixoCpo(cAliasTab)
	If !Empty(cChaveUnico)
		DbSelectArea(cAliasTab)
		IndRegua(cAliasTab,cArqInd,cChaveUnico )
		cChave:=StrTran( cChaveUnico,cPrefixo+"_FILIAL+")
		cChave:=StrTran( cChave,"+"+cPrefixo+"_FILIAL")
		
		bSeek:={|| (cAliasTab)->(DbSeek(xFilial(cAliasTab)+(cAliasQry)->&(cChave)))}
	EndIf
	
	nPosicao:=(cAliasTab)->(FieldPos(PrefixoCpo(cAliasTab)+"_FILIAL"))
	
	Begin Transaction
	
	Do While (cAliasQry)->(!Eof())
		
		If !Eval(bSeek)
			(cAliasTab)->(RecLock(cAliasTab,.T.))
			AvReplace(cAliasQry,cAliasTab)
			(cAliasTab)->(FieldPut(nPosicao,"06"))
			(cAliasTab)->(MsUnLock())
		EndIf
		(cAliasQry)->(DbSkip())
	EndDo
	
	
	End Transaction
	FechaArea(cAliasQry)
	FechaArea(cAliasTab)
	Ferase(cArqInd+OrdBagExt())
	
	
	
	
Next


/*
SX2->(DbGoTop())
Do While SX2->(!Eof())

PtInternal(1,SX2->X2_ARQUIVO)
If SX2->X2_MODO<>"E"
SX2->(DbSkip());Loop
EndIf

cTabela:=AllTrim(SX2->X2_ARQUIVO)

If !TcCanOpen(cTabela)
SX2->(DbSkip());Loop
EndIf

cAliasTab:=SX2->X2_CHAVE
FechaArea(cAliasQry)
DbUseArea( .T. , 'TOPCONN', cTabela,cAliasQry, .T., .F. )

If Select(cAliasQry)==0
SX2->(DbSkip());Loop
EndIf

(cAliasQry)->(DbGoTop())
lTemReg:=.F.
Do While (cAliasQry)->(!Eof())
lTemReg:=.T.
Exit
EndDo

If !lTemReg
SX2->(DbSkip());Loop
EndIf

cPrefixo:=PrefixoCpo(cAliasTab)
If cPrefixo=="PDZ"
cPrefixo:="DZ"
EndIf



cQuery:="Select Count(1) Total From (Select Distinct "+cPrefixo+"_FILIAL Contar From "+cTabela+") Tab1"

FechaArea(cAliasQry)
DbUseArea( .T. , 'TOPCONN', TCGENQRY(,,cQuery),cAliasQry, .T., .F. )
If (cAliasQry)->Total>1
cArquivo+=cTabela+"-"+AllTrim(SX2->X2_NOME)+CRLF
EndIf

FechaArea(cAliasQry)

SX2->(DbSkip())
EndDo
*/

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  06/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FechaArea(cAliasTemp)

If Select(cAliasTemp)>0
	(cAliasTemp)->(DbCloseArea())
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  06/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function xVend()
Local cQuery:=""
Local cAliasQry:=GetNextAlias()
Local nHdl := FCreate("\_Lucas\Vendedores.txt")
Local cSeparador:=";"

RpcSetEnv("01","03")
cQuery+=" SELECT DISTINCT D2_PEDIDO,F2_VEND1,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,C5_LOJACLI,C5_NOMCLI,F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_FORMUL,F2_TIPO "
cQuery+=" FROM SC5010 SC5,SF2010 SF2,SD2010 SD2"
cQuery+=" WHERE C5_FILIAL='03'"
cQuery+=" AND C5_XECOMER='C'"
cQuery+=" AND SC5.D_E_L_E_T_=' '"
cQuery+=" AND F2_FILIAL ='03'"
cQuery+=" AND F2_DOC BETWEEN '         ' AND 'ZZZZZZZZZ'"
cQuery+=" AND F2_SERIE BETWEEN '   ' AND 'ZZZ'"
cQuery+=" AND F2_CLIENTE BETWEEN '        ' AND 'ZZZZZZ'"
cQuery+=" AND F2_LOJA BETWEEN '  ' AND 'ZZ'"
cQuery+=" AND F2_TIPO BETWEEN '  ' AND 'ZZ'"
cQuery+=" AND F2_DOC=D2_DOC"
cQuery+=" AND F2_SERIE=D2_SERIE"
cQuery+=" AND F2_CLIENTE=D2_CLIENTE"
cQuery+=" AND SF2.D_E_L_E_T_=' '"
cQuery+=" AND F2_LOJA=D2_LOJA"
cQuery+=" AND F2_TIPO=D2_TIPO"
cQuery+=" AND D2_FILIAL ='03'"
cQuery+=" AND D2_PEDIDO=C5_NUM"
cQuery+=" AND SD2.D_E_L_E_T_=' '"

cQuery:=ChangeQuery(cQuery)
DbUseArea( .T. , 'TOPCONN', TCGENQRY(,,cQuery),cAliasQry, .T., .F. )


SA1->(DbSetOrder(1))
SF2->(DbSetOrder(1))
SE1->(DbSetOrder(1))//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO

cLinha:='D2_PEDIDO;F2_VEND1;D2_DOC;D2_SERIE;D2_CLIENTE;D2_LOJA;C5_LOJACLI;C5_NOMCLI;A1_YCANAL;A1_YDCANAL;A1_VEND;A1_DTNASC'+Chr(13)+Chr(10)
Write(@cLinha,nHdl)
Do While (cAliasQry)->(!Eof())
	SA1->(DbSeek(xFilial("SA1")+(cAliasQry)->(D2_CLIENTE+D2_LOJA)))
	
	cLinha:=(cAliasQry)->(D2_PEDIDO+cSeparador+F2_VEND1+cSeparador+D2_DOC+cSeparador+D2_SERIE+cSeparador+D2_CLIENTE+cSeparador+D2_LOJA+cSeparador+C5_LOJACLI+cSeparador+C5_NOMCLI)+cSeparador
	cLinha+=SA1->(A1_YCANAL+cSeparador+A1_YDCANAL+cSeparador+A1_VEND+cSeparador+DTOS(A1_DTNASC))
	cLinha+=Chr(13)+Chr(10)
	
	
	Write(@cLinha,nHdl)
	
	If !SA1->A1_VEND=="VN9901" .And. SF2->(DbSeek((cAliasQry)->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO)))
		
		If SF2->F2_VEND1<>SA1->A1_VEND
			SF2->(RecLock("SF2",.F.))
			SF2->F2_VEND1:=SA1->A1_VEND
			SF2->(MsUnLock())
		EndIf
		
		If SE1->(DbSeek(xFilial("SE1")+"ECO"+SF2->F2_DOC ))
			Do While SE1->(!Eof() ) .And. SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM)==xFilial("SE1")+"ECO"+SF2->F2_DOC
				If SE1->E1_VEND1<>SA1->A1_VEND
					SE1->(RecLock("SE1",.F.))
					SE1->E1_VEND1:=SA1->A1_VEND
					SE1->(MsUnLock())
				EndIf
				SE1->(DbSkip())
			EndDo
		EndIf
	EndIf
	
	
	(cAliasQry)->(DbSkip())
	
EndDo
FClose(nHdl)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  08/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BACANFS()
Local cQryAlias
Local cModo:=""

RpcSetEnv("03","02")

cQryAlias:=GetNextAlias()
cAliasPZQ:=GetNextAlias()

BeginSQL Alias cQryAlias
	
	SELECT PZQ.R_E_C_N_O_ PZQRECNO,SF2.R_E_C_N_O_ SF2RECNO
	FROM PZQ010 PZQ,SF2030 SF2
	WHERE PZQ_FILIAL=' '
	AND PZQ_CODLOJ IN ('3071','3046')
	AND PZQ_OPER='VE'
	AND PZQ.D_E_L_E_T_=' '
	AND SF2.F2_FILIAL=PZQ.PZQ_FILDES
	AND SF2.F2_DOC=PZQ.PZQ_DOC
	AND SF2.F2_YCODMOV=PZQ_CODMOV
	AND SF2.F2_EMISSAO=PZQ.PZQ_EMISSA
	AND SF2.D_E_L_E_T_='*'
	
EndSql

EmpOpenFile(cAliasPZQ,"PZQ",1,.T.,"01",@cModo)

Do While (cQryAlias)->(!Eof())
	
	SF2->(DbGoTo((cQryAlias)->SF2RECNO))
	(cAliasPZQ)->(DbGoTo((cQryAlias)->PZQRECNO))
	//ExcluiNF(cAliasPZQ)
	ExcluiLF()
	
	(cQryAlias)->(DbSkip())
EndDo

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  08/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCConsNF()
Local aNotasTra	:={}
Local aNotasExc	:={}
Local cQuery 	:= ""
Local cQryAlias := ""
Local nContar:=0
Local cTotal

Private lUsaColab := .F.
RpcSetEnv("40","08")
//RpcSetEnv("03","02")

cQryAlias:=GetNextAlias()

BeginSQL Alias cQryAlias
	SELECT Count(1) Contar  fROM %table:SF2%
	WHERE F2_FILIAL = '08'
	AND F2_YCODMOV IN('49226','49124')
	AND F2_CHVNFE = 0
	AND F2_FIMP = ' '
	AND D_E_L_E_T_ = ' '
	Order by F2_DOC, F2_SERIE
EndSql
cTotal:=StrZero( (cQryAlias)->Contar,5 )


(cQryAlias)->(DbCloseArea())
BeginSQL Alias cQryAlias
	SELECT F2_DOC, F2_SERIE, F2_FIMP, F2_CHVNFE, R_E_C_N_O_ RECNOSF2
	fROM %table:SF2%
	WHERE F2_FILIAL = '08'
	AND F2_YCODMOV IN('49226','49124')
	AND F2_CHVNFE = 0
	AND F2_FIMP = ' '
	AND D_E_L_E_T_ = ' '
	Order by F2_DOC, F2_SERIE
EndSql

Do While (cQryAlias)->(!Eof())
	SF2->(DbGoTo((cQryAlias)->RECNOSF2))
	cMensagem:="Registro:"+StrZero(++nContar,5)+"/"+cTotal
	PtInternal(1,cMensagem )
	SpedNFe4Mnt("SF2")
	If Empty(SF2->F2_FIMP)
		AADD(aNotasExc,SF2->F2_DOC)
		Begin Transaction
		ExcluiNF()
		End Transaction
	Else
		AADD(aNotasTra,SF2->F2_DOC)
	EndIf
	
	(cQryAlias)->(DbSkip())
EndDo

MemoWrite("nc_nf_excluida.txt", VarInfo("UZ NF EXCLUIDA->", aNotasExc, , .F.))
MemoWrite("nc_nf_nao_excluida.txt", VarInfo("UX NF NรO EXCLUIDA->", aNotasTra, , .F.))

(cQryAlias)->(DbCloseArea())

MsgStop("Fim")
Return



User Function nxc()
Local aDados3 := {}

RpcSetEnv("03","02")

Aadd(aDados3,"000000501")
Aadd(aDados3,"000000502")
Aadd(aDados3,"000000503")

MemoWrite("nc_excluida.txt", VarInfo("UZ NF EXCLUIDA->  ", aDados3, , .F.))
MemoWrite("nc_excluida.txt", VarInfo("UX NF NรO EXCLUIDA->  ", aDados3, , .F.))

Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  08/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ExcluiNF(cAliasPZQ)
Local	cMv1Dupref := GetMv("MV_1DUPREF")
Local	cPrefixo		:=&(cMV1DUPREF)


Begin TransAction

cChaveSF3:=SF2->(F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE)
cChaveSFT:=SF2->(F2_SERIE+F2_DOC+F2_CLIENTE+F2_LOJA)

dDataBase:=SF2->F2_EMISSAO
cChave:=xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM

SD2->(MsSeek(cChave))
aItens:={}
aRecSD2:={}

cCliForn	:=SF2->F2_CLIENTE
cLojaCliFor	:=SF2->F2_LOJA



Do While SD2->(!Eof())  .And. SD2->(D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)==cChave
	
	aadd(aRecSD2, SD2->(Recno()))
	
	SD2->(RecLock("SD2",.F.))
	SD2->D2_ORIGLAN:="LF"
	SD2->(MsUnLock())
	lDuplic:=AvalTes(SD2->D2_TES ,/*cEstoq*/,"S")
	
	
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
	//U_WML03ERRO(cAliasPZQ,MemoRead( NomeAutoLog() ),"E")			// Gravar Msg de Erro
Else
	/*
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
	*/
	ExcluiLF(cChaveSF3,cChaveSFT)
	SE1->(DbSetOrder(1))//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	
	If lDuplic .And. SE1->(DbSeek(xFilial("SE1") +cPrefixo+SF2->F2_DOC )) .And. SE1->(E1_CLIENTE+E1_LOJA)==SF2->(F2_CLIENTE+F2_LOJA)
		
		aTitulo:={}
		AADD(aTitulo,	{"E1_PREFIXO"	,SE1->E1_PREFIXO				,Nil})
		AADD(aTitulo,	{"E1_NUM"		,SE1->E1_NUM	    			,Nil})
		AADD(aTitulo,	{"E1_PARCELA"	,SE1->E1_PARCELA				,Nil})
		AADD(aTitulo,	{"E1_TIPO"		,SE1->E1_TIPO					,Nil})
		AADD(aTitulo,	{"E1_NATUREZ"	,SE1->E1_NATUREZ				,Nil})
		AADD(aTitulo,	{"E1_CLIENTE"	,SE1->E1_CLIENTE				,Nil})
		AADD(aTitulo,	{"E1_LOJA"	    ,SE1->E1_LOJA					,Nil})
		AADD(aTitulo,	{"E1_NOMCLI"	,SE1->E1_NOMCLI					,Nil})
		AADD(aTitulo,	{"E1_EMISSAO" 	,SE1->E1_EMISSAO		 		,Nil})
		AADD(aTitulo,	{"E1_VENCTO" 	,SE1->E1_VENCTO		    		,Nil})
		AADD(aTitulo,	{"E1_VALOR"		,SE1->E1_VALOR					,Nil})
		lMsErroAuto := .F.
		MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, 5)
	EndIf
	
	
EndIf



End Transaction

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  08/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ExcluiLF(cChaveSF3,cChaveSFT)


SF3->(DbSetOrder(4)) //F3_FILIAL+F3_CLIEFOR+F3_LOJA+F3_NFISCAL+F3_SERIE
cChave:=xFilial("SF3")+cChaveSF3
If SF3->(MsSeek(cChave))
	RecLock("SF3",.F.)
	SF3->(DbDelete())
	SF3->(MSUnLock())
EndIf




cChave:=xFilial("SFT")+"S"+cChaveSFT
SFT->(DbSetOrder(1)) //FT_FILIAL, FT_TIPOMOV, FT_SERIE, FT_NFISCAL, FT_CLIEFOR, FT_LOJA, FT_ITEM, FT_PRODUTO
SFT->(MsSeek(cChave))
Do While SFT->(!Eof())  .And. SFT->(FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA)==cChave
	RecLock("SFT",.F.)
	SFT->(DbDelete())
	SFT->(MSUnLock())
	SFT->(DBSkip())
EndDo


//ExecBlock("MACALCICMS",.f.,.f.,{aNfCab[NF_OPERNF],nItem,aNfItem[nItem][IT_BASEICM],aNfItem[nItem][IT_ALIQICM],aNfItem[nItem][IT_VALICM]})
//User Function MACALCICMS()
//Local aDadosRet:={}

//AADD(aDadosRet,ParamIxb[3])
//AADD(aDadosRet,ParamIxb[4])
//AADD(aDadosRet,ParamIxb[5])





//Return aDadosRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  08/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BACA_LF()

For nInd:=1 To 2
	
	RpcSetType(3)
	If nInd==1
		RpcSetEnv("03","02")
	Else
		RpcSetEnv("40","01")
	EndIf
	GravaLF()
	RpcClearEnv()
Next

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  12/03/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	GravaLF()
Local cQryAlias

cQryAlias:=GetNextAlias()

BeginSQL Alias cQryAlias
	
	COLUMN D2_EMISSAO AS DATE
	
	SELECT DISTINCT D2_FILIAL,D2_EMISSAO
	From(
	SELECT D2_CLIENTE,D2_LOJA,D2_FILIAL,D2_EMISSAO,D2_DOC,D2_SERIE,D2_ITEM,D2_VALICM,NVL(FT_VALICM,0)FT_VALICM ,(Tab1.D2_VALICM-NVL(Tab2.FT_VALICM,0)) DIFERENCA
	From
	(SELECT *
	FROM  %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN  '01' AND  '21'
	And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
	And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
	And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
	And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
	AND SD2.D2_EMISSAO BETWEEN  '20151101' AND  '20151130'
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_= ' ') Tab1
	LEFT OUTER JOIN
	(SELECT *
	FROM  %Table:SFT% SFT
	WHERE FT_FILIAL BETWEEN  '01' AND  '21'
	AND FT_TIPOMOV='S'
	AND FT_ENTRADA BETWEEN  '20151101' AND  '20151130'
	And FT_SERIE BETWEEN '  ' And 'ZZ'
	And FT_NFISCAL BETWEEN '      ' And 'ZZZZZZ'
	And FT_CLIEFOR BETWEEN '  ' And 'ZZ'
	And FT_LOJA BETWEEN '  ' And 'ZZ'
	And FT_ITEM BETWEEN '  ' And 'ZZ'
	And FT_PRODUTO BETWEEN '  ' And 'ZZ'
	AND FT_DTCANC=' '
	AND D_E_L_E_T_=' '
	AND FT_ESPECIE='CF' ) Tab2
	On Tab1.D2_FILIAL=Tab2.FT_FILIAL
	And Tab1.D2_EMISSAO=Tab2.FT_ENTRADA
	And Tab1.D2_PDV=Tab2.FT_PDV
	And Tab1.D2_DOC=Tab2.FT_NFISCAL
	And Tab1.D2_SERIE=FT_SERIE
	And Tab1.D2_COD=Tab2.FT_PRODUTO
	And D2_ITEM=FT_ITEM
	) TAB3
	WHERE TAB3.DIFERENCA>0
	ORDER BY 1,2
	
EndSql


Do While (cQryAlias)->(!Eof())
	
	PTINTERNAL(1,"Filial:"+(cQryAlias)->D2_FILIAL+" Emissao:"+Dtoc((cQryAlias)->D2_EMISSAO)  )
	
	aParam:={}
	AADD(aParam,Dtoc((cQryAlias)->D2_EMISSAO))	//Data Inicial ?
	AADD(aParam,Dtoc((cQryAlias)->D2_EMISSAO))	//Data Final ?
	AADD(aParam,2)				//Livro de ?  1=Entrada 2=Saida 3=Ambos
	AADD(aParam,"         ")		//Da Nota Fiscal ?
	AADD(aParam,"ZZZZZZZZZ")		//Ate a Nota Fiscal ?
	AADD(aParam,"   ")			//Serie de ?
	AADD(aParam,"ZZZZ")			//Serie Ate ?
	AADD(aParam,"         ")		//Do Cliente/Forn. ?
	AADD(aParam,"ZZZZZ")		//Ate o Cliente/Forn. ?
	AADD(aParam,"      ")			//Da Loja ?
	AADD(aParam,"ZZZZZ")			//Ate a Loja ?
	//AADD(aParam,(cQryAlias)->D2_FILIAL)			//Da Filial ?
	//AADD(aParam,(cQryAlias)->D2_FILIAL)			//Ate a Filial ?
	//AADD(aParam,"  ")			//Utilizar Hist. Oper. Fiscal ?
	cFilAnt:=(cQryAlias)->D2_FILIAL
	
	MATA930(.T.,aParam) 		//Reprocessamento Livros Fiscais
	(cQryAlias)->(DbSkip())
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  08/13/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


#INCLUDE "TOTVS.CH"
#DEFINE SEMAFORO 'IDUNICOTESTE' // Semแforo para teste

// Inicia programa para teste do IPC
User Function IPCLe()
RpcSetEnv("03","02")
MsgRun("Teste de IPCWaitEX","Esperando ... ",{|| IPCLE() } )
Return
// ---------------------------------------------------------------------------
// Fun็ใo prepara o IPC para ser utilizado
// ---------------------------------------------------------------------------
STATIC function IPCLE()
Local cPar := '' , lRec
conout('Iniciando...')
While !killapp()
	// Espera por 5 segundos ...
	lRec := IpcWaitEx(SEMAFORO,5000,@cPar)
	// Se recebeu chamada via IPC
	If lRec
		MsgStop(cPar,"Mensagem Recebida...")
		exit
	Else
		conout("Esperando...")
	Endif
Enddo
Conout('Finalizando...')
Return
// ---------------------------------------------------------------------------
// Fun็ใo enviarแ dados para o IPC, trocando informa็๕es entre as Threads
// ---------------------------------------------------------------------------
User Function IpcGrava()
Local lGoOk := .F.
Local cEcho,nFree := IpcCount(SEMAFORO)
cEcho := "IPCs em Espera : "+str(nFree,4)+CRLF
// Envia dados via IPC entre as Threads
lGoOk := IpcGo( SEMAFORO, "Enviando dados via IPC - a hora ้: " + time() )
If lGoOk
	cEcho += "Hora atual enviada para " +SEMAFORO
Else
	cEcho += "Nao foi possํvel enviar a hora atual para " +SEMAFORO
Endif
MsgStop(cEcho)
Return











#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

#DEFINE CSSBOTAO	"QPushButton { color: #024670; "+;
"    border-image: url(rpo:fwstd_btn_nml.png) 3 3 3 3 stretch; "+;
"    border-top-width: 3px; "+;
"    border-left-width: 3px; "+;
"    border-right-width: 3px; "+;
"    border-bottom-width: 3px }"+;
"QPushButton:pressed {	color: #FFFFFF; "+;
"    border-image: url(rpo:fwstd_btn_prd.png) 3 3 3 3 stretch; "+;
"    border-top-width: 3px; "+;
"    border-left-width: 3px; "+;
"    border-right-width: 3px; "+;
"    border-bottom-width: 3px }"

//--------------------------------------------------------------------
/*/{Protheus.doc} UPDOVER
Fun็ใo de update de dicionแrios para compatibiliza็ใo

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
User Function UPDOVER( cEmpAmb, cFilAmb )

Local   aSay      := {}
Local   aButton   := {}
Local   aMarcadas := {}
Local   cTitulo   := "ATUALIZAวรO DE DICIONมRIOS E TABELAS"
Local   cDesc1    := "Esta rotina tem como fun็ใo fazer  a atualiza็ใo  dos dicionแrios do Sistema ( SX?/SIX )"
Local   cDesc2    := "Este processo deve ser executado em modo EXCLUSIVO, ou seja nใo podem haver outros"
Local   cDesc3    := "usuแrios  ou  jobs utilizando  o sistema.  ษ EXTREMAMENTE recomendav้l  que  se  fa็a um"
Local   cDesc4    := "BACKUP  dos DICIONมRIOS  e da  BASE DE DADOS antes desta atualiza็ใo, para que caso "
Local   cDesc5    := "ocorram eventuais falhas, esse backup possa ser restaurado."
Local   cDesc6    := ""
Local   cDesc7    := ""
Local   lOk       := .F.
Local   lAuto     := ( cEmpAmb <> NIL .or. cFilAmb <> NIL )

Private oMainWnd  := NIL
Private oProcess  := NIL

#IFDEF TOP
	TCInternal( 5, "*OFF" ) // Desliga Refresh no Lock do Top
#ENDIF

__cInterNet := NIL
__lPYME     := .F.

Set Dele On

// Mensagens de Tela Inicial
aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aSay, cDesc3 )
aAdd( aSay, cDesc4 )
aAdd( aSay, cDesc5 )
//aAdd( aSay, cDesc6 )
//aAdd( aSay, cDesc7 )

// Botoes Tela Inicial
aAdd(  aButton, {  1, .T., { || lOk := .T., FechaBatch() } } )
aAdd(  aButton, {  2, .T., { || lOk := .F., FechaBatch() } } )

If lAuto
	lOk := .T.
Else
	FormBatch(  cTitulo,  aSay,  aButton )
EndIf

If lOk
	If lAuto
		aMarcadas :={{ cEmpAmb, cFilAmb, "" }}
	Else
		aMarcadas := EscEmpresa()
	EndIf
	
	If !Empty( aMarcadas )
		If lAuto .OR. MsgNoYes( "Confirma a atualiza็ใo dos dicionแrios ?", cTitulo )
			oProcess := MsNewProcess():New( { | lEnd | lOk := FSTProc( @lEnd, aMarcadas, lAuto ) }, "Atualizando", "Aguarde, atualizando ...", .F. )
			oProcess:Activate()
			
			If lAuto
				If lOk
					MsgStop( "Atualiza็ใo Realizada.", "UPDOVER" )
				Else
					MsgStop( "Atualiza็ใo nใo Realizada.", "UPDOVER" )
				EndIf
				dbCloseAll()
			Else
				If lOk
					Final( "Atualiza็ใo Concluํda." )
				Else
					Final( "Atualiza็ใo nใo Realizada." )
				EndIf
			EndIf
			
		Else
			MsgStop( "Atualiza็ใo nใo Realizada.", "UPDOVER" )
			
		EndIf
		
	Else
		MsgStop( "Atualiza็ใo nใo Realizada.", "UPDOVER" )
		
	EndIf
	
EndIf

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSTProc
Fun็ใo de processamento da grava็ใo dos arquivos

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSTProc( lEnd, aMarcadas, lAuto )
Local   aInfo     := {}
Local   aRecnoSM0 := {}
Local   cAux      := ""
Local   cFile     := ""
Local   cFileLog  := ""
Local   cMask     := "Arquivos Texto" + "(*.TXT)|*.txt|"
Local   cTCBuild  := "TCGetBuild"
Local   cTexto    := ""
Local   cTopBuild := ""
Local   lOpen     := .F.
Local   lRet      := .T.
Local   nI        := 0
Local   nPos      := 0
Local   nRecno    := 0
Local   nX        := 0
Local   oDlg      := NIL
Local   oFont     := NIL
Local   oMemo     := NIL

Private aArqUpd   := {}

If ( lOpen := MyOpenSm0(.T.) )
	
	dbSelectArea( "SM0" )
	dbGoTop()
	
	While !SM0->( EOF() )
		// S๓ adiciona no aRecnoSM0 se a empresa for diferente
		If aScan( aRecnoSM0, { |x| x[2] == SM0->M0_CODIGO } ) == 0 ;
			.AND. aScan( aMarcadas, { |x| x[1] == SM0->M0_CODIGO } ) > 0
			aAdd( aRecnoSM0, { Recno(), SM0->M0_CODIGO } )
		EndIf
		SM0->( dbSkip() )
	End
	
	SM0->( dbCloseArea() )
	
	If lOpen
		
		For nI := 1 To Len( aRecnoSM0 )
			
			If !( lOpen := MyOpenSm0(.F.) )
				MsgStop( "Atualiza็ใo da empresa " + aRecnoSM0[nI][2] + " nใo efetuada." )
				Exit
			EndIf
			
			SM0->( dbGoTo( aRecnoSM0[nI][1] ) )
			
			RpcSetType( 3 )
			RpcSetEnv( SM0->M0_CODIGO, SM0->M0_CODFIL )
			
			lMsFinalAuto := .F.
			lMsHelpAuto  := .F.
			
			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( Replicate( " ", 128 ) )
			AutoGrLog( "LOG DA ATUALIZAวรO DOS DICIONมRIOS" )
			AutoGrLog( Replicate( " ", 128 ) )
			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( " " )
			AutoGrLog( " Dados Ambiente" )
			AutoGrLog( " --------------------" )
			AutoGrLog( " Empresa / Filial...: " + cEmpAnt + "/" + cFilAnt )
			AutoGrLog( " Nome Empresa.......: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_NOMECOM", cEmpAnt + cFilAnt, 1, "" ) ) ) )
			AutoGrLog( " Nome Filial........: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_FILIAL" , cEmpAnt + cFilAnt, 1, "" ) ) ) )
			AutoGrLog( " DataBase...........: " + DtoC( dDataBase ) )
			AutoGrLog( " Data / Hora อnicio.: " + DtoC( Date() )  + " / " + Time() )
			AutoGrLog( " Environment........: " + GetEnvServer()  )
			AutoGrLog( " StartPath..........: " + GetSrvProfString( "StartPath", "" ) )
			AutoGrLog( " RootPath...........: " + GetSrvProfString( "RootPath" , "" ) )
			AutoGrLog( " Versใo.............: " + GetVersao(.T.) )
			AutoGrLog( " Usuแrio TOTVS .....: " + __cUserId + " " +  cUserName )
			AutoGrLog( " Computer Name......: " + GetComputerName() )
			
			aInfo   := GetUserInfo()
			If ( nPos    := aScan( aInfo,{ |x,y| x[3] == ThreadId() } ) ) > 0
				AutoGrLog( " " )
				AutoGrLog( " Dados Thread" )
				AutoGrLog( " --------------------" )
				AutoGrLog( " Usuแrio da Rede....: " + aInfo[nPos][1] )
				AutoGrLog( " Esta็ใo............: " + aInfo[nPos][2] )
				AutoGrLog( " Programa Inicial...: " + aInfo[nPos][5] )
				AutoGrLog( " Environment........: " + aInfo[nPos][6] )
				AutoGrLog( " Conexใo............: " + AllTrim( StrTran( StrTran( aInfo[nPos][7], Chr( 13 ), "" ), Chr( 10 ), "" ) ) )
			EndIf
			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( " " )
			
			If !lAuto
				AutoGrLog( Replicate( "-", 128 ) )
				AutoGrLog( "Empresa : " + SM0->M0_CODIGO + "/" + SM0->M0_NOME + CRLF )
			EndIf
			
			oProcess:SetRegua1( 8 )
			
			
			oProcess:IncRegua1( "Dicionแrio de arquivos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX2()
			
			
			FSAtuSX3()
			
			
			oProcess:IncRegua1( "Dicionแrio de ํndices" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSIX()
			
			oProcess:IncRegua1( "Dicionแrio de dados" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			oProcess:IncRegua2( "Atualizando campos/ํndices" )
			
			// Altera็ใo fํsica dos arquivos
			__SetX31Mode( .F. )
			
			If FindFunction(cTCBuild)
				cTopBuild := &cTCBuild.()
			EndIf
			
			For nX := 1 To Len( aArqUpd )
				
				If cTopBuild >= "20090811" .AND. TcInternal( 89 ) == "CLOB_SUPPORTED"
					If ( ( aArqUpd[nX] >= "NQ " .AND. aArqUpd[nX] <= "NZZ" ) .OR. ( aArqUpd[nX] >= "O0 " .AND. aArqUpd[nX] <= "NZZ" ) ) .AND.;
						!aArqUpd[nX] $ "NQD,NQF,NQP,NQT"
						TcInternal( 25, "CLOB" )
					EndIf
				EndIf
				
				If Select( aArqUpd[nX] ) > 0
					dbSelectArea( aArqUpd[nX] )
					dbCloseArea()
				EndIf
				
				X31UpdTable( aArqUpd[nX] )
				
				If __GetX31Error()
					Alert( __GetX31Trace() )
					MsgStop( "Ocorreu um erro desconhecido durante a atualiza็ใo da tabela : " + aArqUpd[nX] + ". Verifique a integridade do dicionแrio e da tabela.", "ATENวรO" )
					AutoGrLog( "Ocorreu um erro desconhecido durante a atualiza็ใo da estrutura da tabela : " + aArqUpd[nX] )
				EndIf
				
				If cTopBuild >= "20090811" .AND. TcInternal( 89 ) == "CLOB_SUPPORTED"
					TcInternal( 25, "OFF" )
				EndIf
				
			Next nX
			
			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( " Data / Hora Final.: " + DtoC( Date() ) + " / " + Time() )
			AutoGrLog( Replicate( "-", 128 ) )
			
			RpcClearEnv()
			
		Next nI
		
		If !lAuto
			
			cTexto := LeLog()
			
			Define Font oFont Name "Mono AS" Size 5, 12
			
			Define MsDialog oDlg Title "Atualiza็ใo concluida." From 3, 0 to 340, 417 Pixel
			
			@ 5, 5 Get oMemo Var cTexto Memo Size 200, 145 Of oDlg Pixel
			oMemo:bRClicked := { || AllwaysTrue() }
			oMemo:oFont     := oFont
			
			Define SButton From 153, 175 Type  1 Action oDlg:End() Enable Of oDlg Pixel // Apaga
			Define SButton From 153, 145 Type 13 Action ( cFile := cGetFile( cMask, "" ), If( cFile == "", .T., ;
			MemoWrite( cFile, cTexto ) ) ) Enable Of oDlg Pixel
			
			Activate MsDialog oDlg Center
			
		EndIf
		
	EndIf
	
Else
	
	lRet := .F.
	
EndIf

Return lRet


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX2
Fun็ใo de processamento da grava็ใo do SX2 - Arquivos

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX2()
Local aEstrut   := {}
Local aSX2      := {}
Local cAlias    := ""
Local cEmpr     := ""
Local cPath     := ""
Local nI        := 0
Local nJ        := 0

AutoGrLog( "อnicio da Atualiza็ใo" + " SX2" + CRLF )

aEstrut := { "X2_CHAVE"  , "X2_PATH"   , "X2_ARQUIVO", "X2_NOME"   , "X2_NOMESPA", "X2_NOMEENG", "X2_MODO"   , ;
"X2_TTS"    , "X2_ROTINA" , "X2_PYME"   , "X2_UNICO"  , "X2_DISPLAY", "X2_SYSOBJ" , "X2_USROBJ" , ;
"X2_POSLGT" , "X2_MODOEMP", "X2_MODOUN" , "X2_MODULO" }


dbSelectArea( "SX2" )
SX2->( dbSetOrder( 1 ) )
SX2->( dbGoTop() )
cPath := SX2->X2_PATH
cPath := IIf( Right( AllTrim( cPath ), 1 ) <> "\", PadR( AllTrim( cPath ) + "\", Len( cPath ) ), cPath )
cEmpr := Substr( SX2->X2_ARQUIVO, 4 )

aAdd( aSX2, {'P00',cPath,'P00'+cEmpr,'TIPO DE VPC/VERBA','TIPO DE VPC/VERBA','TIPO DE VPC/VERBA','C','','','','','','','','','C','C',0} )
//
// Atualizando dicionแrio
//
oProcess:SetRegua2( Len( aSX2 ) )

dbSelectArea( "SX2" )
dbSetOrder( 1 )

For nI := 1 To Len( aSX2 )
	
	oProcess:IncRegua2( "Atualizando Arquivos (SX2)..." )
	
	If !SX2->( dbSeek( aSX2[nI][1] ) )
		
		If !( aSX2[nI][1] $ cAlias )
			cAlias += aSX2[nI][1] + "/"
			AutoGrLog( "Foi incluํda a tabela " + aSX2[nI][1] )
		EndIf
		
		RecLock( "SX2", .T. )
		For nJ := 1 To Len( aSX2[nI] )
			If FieldPos( aEstrut[nJ] ) > 0
				If AllTrim( aEstrut[nJ] ) == "X2_ARQUIVO"
					FieldPut( FieldPos( aEstrut[nJ] ), SubStr( aSX2[nI][nJ], 1, 3 ) + cEmpAnt +  "0" )
				Else
					FieldPut( FieldPos( aEstrut[nJ] ), aSX2[nI][nJ] )
				EndIf
			EndIf
		Next nJ
		MsUnLock()
		
	EndIf
	
Next nI

AutoGrLog( CRLF + "Final da Atualiza็ใo" + " SX2" + CRLF + Replicate( "-", 128 ) + CRLF )

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX3
Fun็ใo de processamento da grava็ใo do SX3 - Campos

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX3()
Local aEstrut   := {}
Local aSX3      := {}
Local cAlias    := ""
Local cAliasAtu := ""
Local cMsg      := ""
Local cSeqAtu   := ""
Local cX3Campo  := ""
Local cX3Dado   := ""
Local lTodosNao := .F.
Local lTodosSim := .F.
Local nI        := 0
Local nJ        := 0
Local nOpcA     := 0
Local nPosArq   := 0
Local nPosCpo   := 0
Local nPosOrd   := 0
Local nPosSXG   := 0
Local nPosTam   := 0
Local nPosVld   := 0
Local nSeqAtu   := 0
Local nTamSeek  := Len( SX3->X3_CAMPO )

AutoGrLog( "อnicio da Atualiza็ใo" + " SX3" + CRLF )

aEstrut := { { "X3_ARQUIVO", 0 }, { "X3_ORDEM"  , 0 }, { "X3_CAMPO"  , 0 }, { "X3_TIPO"   , 0 }, { "X3_TAMANHO", 0 }, { "X3_DECIMAL", 0 }, { "X3_TITULO" , 0 }, ;
{ "X3_TITSPA" , 0 }, { "X3_TITENG" , 0 }, { "X3_DESCRIC", 0 }, { "X3_DESCSPA", 0 }, { "X3_DESCENG", 0 }, { "X3_PICTURE", 0 }, { "X3_VALID"  , 0 }, ;
{ "X3_USADO"  , 0 }, { "X3_RELACAO", 0 }, { "X3_F3"     , 0 }, { "X3_NIVEL"  , 0 }, { "X3_RESERV" , 0 }, { "X3_CHECK"  , 0 }, { "X3_TRIGGER", 0 }, ;
{ "X3_PROPRI" , 0 }, { "X3_BROWSE" , 0 }, { "X3_VISUAL" , 0 }, { "X3_CONTEXT", 0 }, { "X3_OBRIGAT", 0 }, { "X3_VLDUSER", 0 }, { "X3_CBOX"   , 0 }, ;
{ "X3_CBOXSPA", 0 }, { "X3_CBOXENG", 0 }, { "X3_PICTVAR", 0 }, { "X3_WHEN"   , 0 }, { "X3_INIBRW" , 0 }, { "X3_GRPSXG" , 0 }, { "X3_FOLDER" , 0 }, ;
{ "X3_CONDSQL", 0 }, { "X3_CHKSQL" , 0 }, { "X3_IDXSRV" , 0 }, { "X3_ORTOGRA", 0 }, { "X3_TELA"   , 0 }, { "X3_POSLGT" , 0 }, { "X3_IDXFLD" , 0 }, ;
{ "X3_AGRUP"  , 0 }, { "X3_PYME"   , 0 } }

aEval( aEstrut, { |x| x[2] := SX3->( FieldPos( x[1] ) ) } )


aAdd( aSX3, {'P00','04','P00_TIPO','C',1,0,'Tipo','Tipo','Tipo','Tipo VPC ou Verba','Tipo VPC ou Verba','Tipo VPC ou Verba','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','1=VPC;2=Verba Extra;3=VPC Over Price','1=VPC;2=Verba Extra','1=VPC;2=Verba Extra','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'SC6','L5','C6_YVPCOVE','N',6,2,'%VPC Over','%VPC Over','%VPC Over','%VPC Over','%VPC Over','%VPC Over','@E 999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )

//
// Atualizando dicionแrio
//
nPosArq := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_ARQUIVO" } )
nPosOrd := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_ORDEM"   } )
nPosCpo := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_CAMPO"   } )
nPosTam := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_TAMANHO" } )
nPosSXG := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_GRPSXG"  } )
nPosVld := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_VALID"   } )

aSort( aSX3,,, { |x,y| x[nPosArq]+x[nPosOrd]+x[nPosCpo] < y[nPosArq]+y[nPosOrd]+y[nPosCpo] } )

oProcess:SetRegua2( Len( aSX3 ) )

dbSelectArea( "SX3" )
dbSetOrder( 2 )
cAliasAtu := ""

For nI := 1 To Len( aSX3 )
	
	//
	// Verifica se o campo faz parte de um grupo e ajusta tamanho
	//
	If !Empty( aSX3[nI][nPosSXG] )
		SXG->( dbSetOrder( 1 ) )
		If SXG->( MSSeek( aSX3[nI][nPosSXG] ) )
			If aSX3[nI][nPosTam] <> SXG->XG_SIZE
				aSX3[nI][nPosTam] := SXG->XG_SIZE
				AutoGrLog( "O tamanho do campo " + aSX3[nI][nPosCpo] + " NรO atualizado e foi mantido em [" + ;
				AllTrim( Str( SXG->XG_SIZE ) ) + "]" + CRLF + ;
				" por pertencer ao grupo de campos [" + SXG->XG_GRUPO + "]" + CRLF )
			EndIf
		EndIf
	EndIf
	
	SX3->( dbSetOrder( 2 ) )
	
	If !( aSX3[nI][nPosArq] $ cAlias )
		cAlias += aSX3[nI][nPosArq] + "/"
		aAdd( aArqUpd, aSX3[nI][nPosArq] )
	EndIf
	
	If !SX3->( dbSeek( PadR( aSX3[nI][nPosCpo], nTamSeek ) ) )
		
		//
		// Busca ultima ocorrencia do alias
		//
		If ( aSX3[nI][nPosArq] <> cAliasAtu )
			cSeqAtu   := "00"
			cAliasAtu := aSX3[nI][nPosArq]
			
			dbSetOrder( 1 )
			SX3->( dbSeek( cAliasAtu + "ZZ", .T. ) )
			dbSkip( -1 )
			
			If ( SX3->X3_ARQUIVO == cAliasAtu )
				cSeqAtu := SX3->X3_ORDEM
			EndIf
			
			nSeqAtu := Val( RetAsc( cSeqAtu, 3, .F. ) )
		EndIf
		
		nSeqAtu++
		cSeqAtu := RetAsc( Str( nSeqAtu ), 2, .T. )
		
		RecLock( "SX3", .T. )
		For nJ := 1 To Len( aSX3[nI] )
			If     nJ == nPosOrd  // Ordem
				SX3->( FieldPut( FieldPos( aEstrut[nJ][1] ), cSeqAtu ) )
				
			ElseIf aEstrut[nJ][2] > 0
				SX3->( FieldPut( FieldPos( aEstrut[nJ][1] ), aSX3[nI][nJ] ) )
				
			EndIf
		Next nJ
		
		dbCommit()
		MsUnLock()
		
		AutoGrLog( "Criado campo " + aSX3[nI][nPosCpo] )
		
	EndIf
	
	oProcess:IncRegua2( "Atualizando Campos de Tabelas (SX3)..." )
	
Next nI

AutoGrLog( CRLF + "Final da Atualiza็ใo" + " SX3" + CRLF + Replicate( "-", 128 ) + CRLF )

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSIX
Fun็ใo de processamento da grava็ใo do SIX - Indices

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSIX()
Local aEstrut   := {}
Local aSIX      := {}
Local lAlt      := .F.
Local lDelInd   := .F.
Local nI        := 0
Local nJ        := 0

AutoGrLog( "อnicio da Atualiza็ใo" + " SIX" + CRLF )

aEstrut := { "INDICE" , "ORDEM" , "CHAVE", "DESCRICAO", "DESCSPA"  , ;
"DESCENG", "PROPRI", "F3"   , "NICKNAME" , "SHOWPESQ" }

aAdd( aSIX, {'P00','1','P00_FILIAL+P00_CODIGO+P00_TIPO','Codigo+Tipo','Codigo+Tipo','Codigo+Tipo','U','','','S'} )
aAdd( aSIX, {'P00','2','P00_FILIAL+P00_DESC','Descri็ใo','Descri็ใo','Descri็ใo','U','','','S'} )
aAdd( aSIX, {'SC6','C','C6_FILIAL+C6_NUM+C6_SEQCAR','Num. Pedido+SEQ CARGA','Nro Pedido+SEQ CARGA','Order Number+SEQ CARGA','U','','SEQCAR','S'} )
//
// Atualizando dicionแrio
//
oProcess:SetRegua2( Len( aSIX ) )

dbSelectArea( "SIX" )
SIX->( dbSetOrder( 1 ) )

For nI := 1 To Len( aSIX )
	
	lAlt    := .F.
	lDelInd := .F.
	
	If !SIX->( dbSeek( aSIX[nI][1] + aSIX[nI][2] ) )
		AutoGrLog( "อndice criado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] )
	Else
		lAlt := .T.
		aAdd( aArqUpd, aSIX[nI][1] )
		If !StrTran( Upper( AllTrim( CHAVE )       ), " ", "" ) == ;
			StrTran( Upper( AllTrim( aSIX[nI][3] ) ), " ", "" )
			AutoGrLog( "Chave do ํndice alterado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] )
			lDelInd := .T. // Se for altera็ใo precisa apagar o indice do banco
		EndIf
	EndIf
	
	RecLock( "SIX", !lAlt )
	For nJ := 1 To Len( aSIX[nI] )
		If FieldPos( aEstrut[nJ] ) > 0
			FieldPut( FieldPos( aEstrut[nJ] ), aSIX[nI][nJ] )
		EndIf
	Next nJ
	MsUnLock()
	
	dbCommit()
	
	If lDelInd
		TcInternal( 60, RetSqlName( aSIX[nI][1] ) + "|" + RetSqlName( aSIX[nI][1] ) + aSIX[nI][2] )
	EndIf
	
	oProcess:IncRegua2( "Atualizando ํndices..." )
	
Next nI

AutoGrLog( CRLF + "Final da Atualiza็ใo" + " SIX" + CRLF + Replicate( "-", 128 ) + CRLF )

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} EscEmpresa
Fun็ใo gen้rica para escolha de Empresa, montada pelo SM0

@return aRet Vetor contendo as sele็๕es feitas.
Se nใo for marcada nenhuma o vetor volta vazio

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function EscEmpresa()

//---------------------------------------------
// Parโmetro  nTipo
// 1 - Monta com Todas Empresas/Filiais
// 2 - Monta s๓ com Empresas
// 3 - Monta s๓ com Filiais de uma Empresa
//
// Parโmetro  aMarcadas
// Vetor com Empresas/Filiais pr้ marcadas
//
// Parโmetro  cEmpSel
// Empresa que serแ usada para montar sele็ใo
//---------------------------------------------
Local   aRet      := {}
Local   aSalvAmb  := GetArea()
Local   aSalvSM0  := {}
Local   aVetor    := {}
Local   cMascEmp  := "??"
Local   cVar      := ""
Local   lChk      := .F.
Local   lOk       := .F.
Local   lTeveMarc := .F.
Local   oNo       := LoadBitmap( GetResources(), "LBNO" )
Local   oOk       := LoadBitmap( GetResources(), "LBOK" )
Local   oDlg, oChkMar, oLbx, oMascEmp, oSay
Local   oButDMar, oButInv, oButMarc, oButOk, oButCanc

Local   aMarcadas := {}


If !MyOpenSm0(.F.)
	Return aRet
EndIf


dbSelectArea( "SM0" )
aSalvSM0 := SM0->( GetArea() )
dbSetOrder( 1 )
dbGoTop()

While !SM0->( EOF() )
	
	If aScan( aVetor, {|x| x[2] == SM0->M0_CODIGO} ) == 0
		aAdd(  aVetor, { aScan( aMarcadas, {|x| x[1] == SM0->M0_CODIGO .and. x[2] == SM0->M0_CODFIL} ) > 0, SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_NOME, SM0->M0_FILIAL } )
	EndIf
	
	dbSkip()
End

RestArea( aSalvSM0 )

Define MSDialog  oDlg Title "" From 0, 0 To 280, 395 Pixel

oDlg:cToolTip := "Tela para M๚ltiplas Sele็๕es de Empresas/Filiais"

oDlg:cTitle   := "Selecione a(s) Empresa(s) para Atualiza็ใo"

@ 10, 10 Listbox  oLbx Var  cVar Fields Header " ", " ", "Empresa" Size 178, 095 Of oDlg Pixel
oLbx:SetArray(  aVetor )
oLbx:bLine := {|| {IIf( aVetor[oLbx:nAt, 1], oOk, oNo ), ;
aVetor[oLbx:nAt, 2], ;
aVetor[oLbx:nAt, 4]}}
oLbx:BlDblClick := { || aVetor[oLbx:nAt, 1] := !aVetor[oLbx:nAt, 1], VerTodos( aVetor, @lChk, oChkMar ), oChkMar:Refresh(), oLbx:Refresh()}
oLbx:cToolTip   :=  oDlg:cTitle
oLbx:lHScroll   := .F. // NoScroll

@ 112, 10 CheckBox oChkMar Var  lChk Prompt "Todos" Message "Marca / Desmarca"+ CRLF + "Todos" Size 40, 007 Pixel Of oDlg;
on Click MarcaTodos( lChk, @aVetor, oLbx )

// Marca/Desmarca por mascara
@ 113, 51 Say   oSay Prompt "Empresa" Size  40, 08 Of oDlg Pixel
@ 112, 80 MSGet oMascEmp Var  cMascEmp Size  05, 05 Pixel Picture "@!"  Valid (  cMascEmp := StrTran( cMascEmp, " ", "?" ), oMascEmp:Refresh(), .T. ) ;
Message "Mแscara Empresa ( ?? )"  Of oDlg
oSay:cToolTip := oMascEmp:cToolTip

@ 128, 10 Button oButInv    Prompt "&Inverter"  Size 32, 12 Pixel Action ( InvSelecao( @aVetor, oLbx, @lChk, oChkMar ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Inverter Sele็ใo" Of oDlg
oButInv:SetCss( CSSBOTAO )
@ 128, 50 Button oButMarc   Prompt "&Marcar"    Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .T. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Marcar usando" + CRLF + "mแscara ( ?? )"    Of oDlg
oButMarc:SetCss( CSSBOTAO )
@ 128, 80 Button oButDMar   Prompt "&Desmarcar" Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .F. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Desmarcar usando" + CRLF + "mแscara ( ?? )" Of oDlg
oButDMar:SetCss( CSSBOTAO )
@ 112, 157  Button oButOk   Prompt "Processar"  Size 32, 12 Pixel Action (  RetSelecao( @aRet, aVetor ), oDlg:End()  ) ;
Message "Confirma a sele็ใo e efetua" + CRLF + "o processamento" Of oDlg
oButOk:SetCss( CSSBOTAO )
@ 128, 157  Button oButCanc Prompt "Cancelar"   Size 32, 12 Pixel Action ( IIf( lTeveMarc, aRet :=  aMarcadas, .T. ), oDlg:End() ) ;
Message "Cancela o processamento" + CRLF + "e abandona a aplica็ใo" Of oDlg
oButCanc:SetCss( CSSBOTAO )

Activate MSDialog  oDlg Center

RestArea( aSalvAmb )
dbSelectArea( "SM0" )
dbCloseArea()

Return  aRet


//--------------------------------------------------------------------
/*/{Protheus.doc} MarcaTodos
Fun็ใo auxiliar para marcar/desmarcar todos os ํtens do ListBox ativo

@param lMarca  Cont้udo para marca .T./.F.
@param aVetor  Vetor do ListBox
@param oLbx    Objeto do ListBox

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function MarcaTodos( lMarca, aVetor, oLbx )
Local  nI := 0

For nI := 1 To Len( aVetor )
	aVetor[nI][1] := lMarca
Next nI

oLbx:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} InvSelecao
Fun็ใo auxiliar para inverter a sele็ใo do ListBox ativo

@param aVetor  Vetor do ListBox
@param oLbx    Objeto do ListBox

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function InvSelecao( aVetor, oLbx )
Local  nI := 0

For nI := 1 To Len( aVetor )
	aVetor[nI][1] := !aVetor[nI][1]
Next nI

oLbx:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} RetSelecao
Fun็ใo auxiliar que monta o retorno com as sele็๕es

@param aRet    Array que terแ o retorno das sele็๕es (้ alterado internamente)
@param aVetor  Vetor do ListBox

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function RetSelecao( aRet, aVetor )
Local  nI    := 0

aRet := {}
For nI := 1 To Len( aVetor )
	If aVetor[nI][1]
		aAdd( aRet, { aVetor[nI][2] , aVetor[nI][3], aVetor[nI][2] +  aVetor[nI][3] } )
	EndIf
Next nI

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} MarcaMas
Fun็ใo para marcar/desmarcar usando mแscaras

@param oLbx     Objeto do ListBox
@param aVetor   Vetor do ListBox
@param cMascEmp Campo com a mแscara (???)
@param lMarDes  Marca a ser atribuํda .T./.F.

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function MarcaMas( oLbx, aVetor, cMascEmp, lMarDes )
Local cPos1 := SubStr( cMascEmp, 1, 1 )
Local cPos2 := SubStr( cMascEmp, 2, 1 )
Local nPos  := oLbx:nAt
Local nZ    := 0

For nZ := 1 To Len( aVetor )
	If cPos1 == "?" .or. SubStr( aVetor[nZ][2], 1, 1 ) == cPos1
		If cPos2 == "?" .or. SubStr( aVetor[nZ][2], 2, 1 ) == cPos2
			aVetor[nZ][1] := lMarDes
		EndIf
	EndIf
Next

oLbx:nAt := nPos
oLbx:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} VerTodos
Fun็ใo auxiliar para verificar se estใo todos marcados ou nใo

@param aVetor   Vetor do ListBox
@param lChk     Marca do CheckBox do marca todos (referncia)
@param oChkMar  Objeto de CheckBox do marca todos

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function VerTodos( aVetor, lChk, oChkMar )
Local lTTrue := .T.
Local nI     := 0

For nI := 1 To Len( aVetor )
	lTTrue := IIf( !aVetor[nI][1], .F., lTTrue )
Next nI

lChk := IIf( lTTrue, .T., .F. )
oChkMar:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} MyOpenSM0
Fun็ใo de processamento abertura do SM0 modo exclusivo

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function MyOpenSM0(lShared)

Local lOpen := .F.
Local nLoop := 0

For nLoop := 1 To 20
	dbUseArea( .T., , "SIGAMAT.EMP", "SM0", lShared, .F. )
	
	If !Empty( Select( "SM0" ) )
		lOpen := .T.
		dbSetIndex( "SIGAMAT.IND" )
		Exit
	EndIf
	
	Sleep( 500 )
	
Next nLoop

If !lOpen
	MsgStop( "Nใo foi possํvel a abertura da tabela " + ;
	IIf( lShared, "de empresas (SM0).", "de empresas (SM0) de forma exclusiva." ), "ATENวรO" )
EndIf

Return lOpen


//--------------------------------------------------------------------
/*/{Protheus.doc} LeLog
Fun็ใo de leitura do LOG gerado com limitacao de string

@author TOTVS Protheus
@since  15/12/2015
@obs    Gerado por EXPORDIC - V.4.25.11.9 EFS / Upd. V.4.20.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function LeLog()
Local cRet  := ""
Local cFile := NomeAutoLog()
Local cAux  := ""

FT_FUSE( cFile )
FT_FGOTOP()

While !FT_FEOF()
	
	cAux := FT_FREADLN()
	
	If Len( cRet ) + Len( cAux ) < 1048000
		cRet += cAux + CRLF
	Else
		cRet += CRLF
		cRet += Replicate( "=" , 128 ) + CRLF
		cRet += "Tamanho de exibi็ใo maxima do LOG alcan็ado." + CRLF
		cRet += "LOG Completo no arquivo " + cFile + CRLF
		cRet += Replicate( "=" , 128 ) + CRLF
		Exit
	EndIf
	
	FT_FSKIP()
End

FT_FUSE()

Return cRet


/////////////////////////////////////////////////////////////////////////////


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  12/16/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xCopyProd()
Local cFile := "C:\temp\SA7_SB1.csv"
Local cAux  := ""
Local cCodCli:="000000"
Local cLojaCli:="01"
Local cModo:=""
Local cQryAlias:="SA7010"

RpcSetType(3)
RpcSetEnv("01","03")
nLenSB1		:=AvSx3("B1_COD"	,3)
nLenA7CODCLI:=AvSx3("A7_CODCLI",3)

SA7->(DbSetOrder(1)) //A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
SB1->(DbSetOrder(1))

EmpOpenFile("SB1030","SB1",1,.T.,"03",@cModo)
EmpOpenFile("SB1400","SB1",1,.T.,"40",@cModo)


//FT_FUSE( cFile )
//FT_FGOTOP()

BeginSQL Alias cQryAlias
	SELECT *
	FROM SA7010 SA7
	WHERE SA7.A7_FILIAL=' '
	AND SA7.A7_CLIENTE='000000'
	AND SA7.A7_LOJA='01'
	AND SA7.D_E_L_E_T_=' '
	AND A7_PRODUTO IN ('01122650191    ','99999900631    ','0641370021861  ')
	Order By A7_PRODUTO
EndSql

While (cQryAlias)->(!Eof()) //!FT_FEOF()
	
	//cAux := FT_FREADLN()
	//aDados:=Separa(cAux,";")
	
	//If Empty(aDados[3])
	//FT_FSKIP();Loop
	//EndIf
	
	cProduto:=Padr( SA7010->A7_PRODUTO ,nLenSB1)
	cProdCli :=Padr(SA7010->A7_CODCLI,nLenA7CODCLI)
	lCopiar:=.F.
	
	If !SB1030->(DbSeek(xFilial("SB1")+cProdCli ))
		lCopiar:=.T.
	EndIf
	
	If !SB1400->(DbSeek(xFilial("SB1")+cProdCli ))
		lCopiar:=.T.
	EndIf
	
	If !SB1->(DbSeek(xFilial("SB1")+cProduto ))
		(cQryAlias)->(DbSkip());Loop
	EndIf
	
	If lCopiar
		U_PR117Copia(.F.)
	EndIf
	
	(cQryAlias)->(DbSkip())
End



Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  12/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BACADELSF1()
Local	aCabec := {}
Local	aItens := {}
Local	cQryAlias:=GetNextAlias()
Local nInd
Local cMensagem:=""

nHdl := FCreate("c:\temp\baca\BACADELSF1_"+StrTran(Time(),":","")+".txt")

RpcSetEnv("40","08")


BeginSQL Alias cQryAlias
	SELECT '40' As Empresa, F1_FILIAL,SF1.F1_YCODMOV,SF1.F1_YLOJAWM,COUNT(1)
	FROM SF1400 SF1
	WHERE F1_FILIAL BETWEEN '  ' AND 'ZZ'
	AND F1_YCODMOV<>' '
	AND D_E_L_E_T_=' '
	AND F1_EMISSAO>='20150112'
	GROUP BY F1_FILIAL,SF1.F1_YCODMOV,SF1.F1_YLOJAWM
	having COUNT(1)>100
EndSQL

SD1->(DbSetOrder(1))//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
ChkFile("SF1")

Do While (cQryAlias)->(!Eof())
	
	
	SF1->(DbOrderNickName("F1WM"))//F1_FILIAL+F1_YCODMOV+F1_YLOJAWM
	If !SF1->(MsSeek(xFilial("SF1")+(cQryAlias)->(F1_YCODMOV+F1_YLOJAWM) )  )
		(cQryAlias)->(DbSkip());Loop
	EndIf
	cMovimento:=SF1->F1_YCODMOV
	cChaveSF1:=SF1->(F1_FILIAL+F1_YCODMOV+F1_YLOJAWM)
	
	R007Write("Inicio Movimento "+cMovimento+CRLF+"*******"+Time()+"***********************************"+CRLF)
	
	SF1->(DbSkip())
	
	Do While SF1->(!Eof()) .And. SF1->(F1_FILIAL+F1_YCODMOV+F1_YLOJAWM)==cChaveSF1
		
		PtInternal(1,"Movimento "+cMovimento+" Nota "+SF1->F1_DOC)
		aCabec := {}
		aItens := {}
		
		aadd(aCabec,{"F1_TIPO"   ,SF1->F1_TIPO})
		aadd(aCabec,{"F1_FORMUL" ,SF1->F1_FORMUL})
		aadd(aCabec,{"F1_DOC"    ,SF1->F1_DOC})
		aadd(aCabec,{"F1_SERIE"  ,SF1->F1_SERIE})
		aadd(aCabec,{"F1_EMISSAO",SF1->F1_EMISSAO})
		aadd(aCabec,{"F1_FORNECE",SF1->F1_FORNECE})
		aadd(aCabec,{"F1_LOJA"   ,SF1->F1_LOJA})
		aadd(aCabec,{"F1_ESPECIE",SF1->F1_ESPECIE})
		
		SD1->(DbSeek(SF1->(F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)))
		lPreNota:=Empty(SD1->D1_TES)
		aLinha := {}
		aadd(aLinha,{"D1_ITEM"	,SD1->D1_ITEM	,Nil})
		aadd(aLinha,{"D1_COD"	,SD1->D1_COD	,Nil})
		aadd(aLinha,{"D1_QUANT"	,SD1->D1_QUANT	,Nil})
		aadd(aLinha,{"D1_VUNIT"	,SD1->D1_VUNIT	,Nil})
		aadd(aLinha,{"D1_TOTAL"	,SD1->D1_TOTAL	,Nil})
		aadd(aItens,aLinha)
		
		cChaveSF3:=xFilial("SF3")+SF1->(F1_SERIE+F1_DOC+F1_FORNECE+F1_LOJA)
		cChaveSFT:=xFilial("SFT")+"E"+SF1->(F1_SERIE+F1_DOC+F1_FORNECE+F1_LOJA)
		lMsErroAuto := .F.
		
		Begin Transaction
		
		If lPreNota
			MATA140(aCabec,aItens,5)
		Else
			MATA103(aCabec,aItens,5)
		EndIf
		If lMsErroAuto
			R007Write("Nota "+SF1->F1_DOC+" com erro  "+CRLF)
		Else
			R007Write("Nota "+SF1->F1_DOC+" excluida com sucesso "+CRLF)
			SF3->(DbSetOrder(5))//F3_FILIAL+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA+F3_IDENTFT
			If SF3->(MsSeek(cChaveSF3))
				RecLock("SF3",.F.)
				SF3->(DbDelete())
				SF3->(MsUnLock())
			EndIf
			SFT->(DbSetOrder(1))//FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO
			SFT->(MsSeek(cChaveSFT))
			Do While SFT->(!Eof()) .And. SFT->(FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA)==cChaveSFT
				RecLock("SFT",.F.)
				SFT->(DbDelete())
				SFT->(MsUnLock())
				SFT->(MsUnLock())
				SFT->(DbSkip())
			EndDo
			
		EndIf
		End Transaction
		
		SF1->(DbSkip())
	EndDo
	R007Write("Fim Movimento "+cMovimento+CRLF+"*******"+Time()+"***********************************"+CRLF)
	
	(cQryAlias)->(DbSkip())
	
	
EndDo


Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  12/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BACADEL3061
Local aCabec	:= {}
Local aItens	:= {}
Local cModo		:=""

Local cQryAlias
Local cAliasPZQ
Local cAliasPZR
Local nInd

RpcSetEnv("03","01")
cQryAlias:=GetNextAlias()
cAliasPZQ:=GetNextAlias()
cAliasPZR:=GetNextAlias()

nHdl := FCreate("c:\temp\baca\BACADELDUP_"+cEmpAnt+StrTran(Time(),":","")+".txt")

EmpOpenFile(cAliasPZQ,"PZQ",3,.T.,"01",@cModo)
EmpOpenFile(cAliasPZR,"PZR",3,.T.,"01",@cModo)

BeginSQL Alias cQryAlias
	SELECT R_E_C_N_O_ RECPZQ FROM PZQ010
	WHERE PZQ_FILIAL=' '
	//AND PZQ_CODMOV IN ('1487160','1487191' ,'1487277' ,'1487308' ,'1487313' ,'1487330' ,'1487403' ,'1487412' ,'1487416 ','1487438 ','1487463 ','1487520 ','1487540 ','1487542 ','1487628 ','1487639 ','1487644 ','1487690 ','1487718 ','1487763 ','1487803 ','1487812 ','1487818 ','1487838 ','1487857 ','1487896 ','1487905 ','1487963 ','1487966 ','1488097 ','1488122 ','1488126 ','1488141 ','1488166 ','1488167 ','1488184 ','1488213 ','1488216 ','1488269 ','1488289 ','1488304 ','1488312 ','1488353 ','1488359 ','1488361 ','1488387 ','1488435 ','1488511 ','1488641 ','1488659 ','1488674 ','1488690 ','1488699 ','1488777 ','1488876 ','1488905 ','1488956 ','1488982 ','1489149 ','1489171 ','1489221 ','1489283 ','1489300 ','1489312 ','1489370 ','1489399 ','1489413 ','1489467 ','1489481 ','1489511 ','1489518 ','1489523 ','1489540 ','1489583 ','1489588 ','1489593 ','1489609 ','1489613 ','1489614 ','1489617 ','1489629 ','1489636 ','1489641 ','1489657 ','1489692 ','1489714 ','1489784 ','1489852 ','1489881 ','1489924 ','1489954 ','1489964 ','1490001 ','1490007 ','1490085 ','1490106 ','1490129 ','1490233 ','1490261 ')
	//AND PZQ_CODMOV IN ('1487159 ','1487175 ','1487180 ','1487213 ','1487216 ','1487238 ','1487335 ','1487349 ','1487388 ','1487400 ','1487509 ','1487626 ','1487652 ','1487654 ','1487666 ','1487672 ','1487685 ','1487686 ','1487720 ','1487754 ','1487789 ','1487816 ','1487817 ','1487840 ','1487862 ','1487863 ','1487868 ','1487882 ','1487903 ','1487909 ','1487916 ','1487925 ','1487983 ','1488002 ','1488032 ','1488056 ','1488102 ','1488137 ','1488150 ','1488154 ','1488156 ','1488250 ','1488280 ','1488294 ','1488363 ','1488366 ','1488380 ','1488382 ','1488397 ','1488414 ','1488495 ','1488537 ','1488852 ','1489051 ','1489078 ','1489581 ','1489620 ','1489680 ','1489724 ','1489730 ','1489818 ','1489856 ','1489905 ','1490124 ')
	//AND PZQ_CODMOV IN ('1486955','1489364','1489642','1488670' ,'1489022' ,'1490127' )
	
	
	//AND PZQ_CODMOV IN ('1461923 ','1461232 ','1461519 ','1461872 ','1462033 ','1462315 ','1462586 ','1462764 ','1463611 ','1463625 ','1461252 ','1461590 ','1462225 ','1462235 ','1462324 ','1462336 ','1462522 ','1462633 ','1463399 ','1463450 ','1463618 ','1463716 ','1461163 ','1461410 ','1462048 ','1462333 ','1462409 ','1462511 ','1462970 ','1463529 ','1463749 ','1463776 ','1461112 ','1461419 ','1461438 ','1461939 ','1462278 ','1462646 ','1462827 ','1463666 ','1461511 ','1462170 ','1462392 ','1462748 ','1461156 ','1461579 ','1462374 ','1462536 ','1462557 ','1462584 ','1463326 ','1463599 ','1463623 ','1463791 ','1461181 ','1461915 ','1462241 ','1462894 ','1461451 ','1461551 ','1461720 ','1461850 ','1462206 ','1462444 ','1462902 ','1463806 ')
	AND PZQ_CODMOV IN ('1274315 ','1274673 ','1274866 ','1274963 ','1275369 ','1275526 ','1274234 ','1274587 ','1274133 ','1275450 ','1275041 ','1274676 ','1274967 ','1275138 ','1275299 ','1275377 ','1274574 ','1275358 ','1274566 ','1274143 ','1274666 ','1274835 ','1275053 ','1275134 ','1274736 ','1274236 ','1275536 ','1274142 ','1274303 ','1274983 ','1274996 ','1274245 ','1274374 ','1275072 ')
	AND PZQ_OPER IN ('VE','TRV','CA')
	AND D_E_L_E_T_=' '
EndSQL



SL1->(DbSetOrder(1))
SL2->(DbSetOrder(1))
Do While (cQryAlias)->(!Eof())
	
	(cAliasPZQ)->(DbGoTo((cQryAlias)->RECPZQ))
	cFilAnt:=(cAliasPZQ)->PZQ_FILDES
	
	
	Begin Transaction
	
	If SL1->(MsSeek(xFilial("SL1")+(cAliasPZQ)->PZQ_NUMORC))
		cChaveSL2:=xFilial("SL2")+SL1->L1_NUM
		SL2->(MsSeek(cChaveSL2))
		Do While SL2->(!Eof()) .And. SL2->(L2_FILIAL+L2_NUM)==cChaveSL2
			DelReg("SL2")
			SL2->(DbSkip())
		EndDo
		DelReg("SL1")
	EndIf
	
	R007Write((cAliasPZQ)->PZQ_CODMOV+CRLF)
	
	SF2->(DbOrderNickName("F2WM"))//F2_FILIAL+F2_YCODMOV+F2_YLOJAWM
	
	If SF2->(MsSeek(xFilial("SF2")+(cAliasPZQ)->(PZQ_CODMOV+PZQ_CODLOJ) )  )
		
		
		
		cMovimento:=SF2->F2_YCODMOV
		
		
		PtInternal(1,"Movimento "+cMovimento+" Nota "+SF2->F2_DOC)
		cChave:=xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
		SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM
		
		SD2->(MsSeek(cChave))
		aItens:={}
		aRecSD2:={}
		
		cCliForn	:=SF2->F2_CLIENTE
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
		Else
			
			For nXnd:=1 To Len(aRecSD2)
				SD2->(DbGoTo(aRecSD2[nXnd]))
				SD2->(RecLock("SD2",.F.))
				SD2->D2_ORIGLAN:="LO"
				SD2->(MsUnLock())
			Next
			
			cChave:=xFilial("SF3")+(cAliasPZQ)->(PZQ_SERPRT+PZQ_DOCPRT)+cCliForn+cLojaCliFor
			SF3->(DbSetOrder(5))//F3_FILIAL+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA+F3_IDENTFT
			If SF3->(MsSeek(cChave))
				DelReg("SF3")
			EndIf
			
			cChave:=xFilial("SFT")+"S"+(cAliasPZQ)->(PZQ_SERPRT+PZQ_DOCPRT)+cCliForn+cLojaCliFor
			SFT->(DbSetOrder(1)) //FT_FILIAL, FT_TIPOMOV, FT_SERIE, FT_NFISCAL, FT_CLIEFOR, FT_LOJA, FT_ITEM, FT_PRODUTO
			SFT->(MsSeek(cChave))
			Do While SFT->(!Eof())  .And. SFT->(FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL+SFT->FT_CLIEFOR+SFT->FT_LOJA)==cChave
				DelReg("SFT")
				SFT->(DBSkip())
			EndDo
			
			
		EndIf
	EndIf
	
	cChavePZR:=(cAliasPZQ)->(PZQ_FILIAL+PZQ_CODMOV+PZQ_CODLOJ)
	(cAliasPZR)->(MsSeek(cChavePZR))//
	Do While (cAliasPZR)->(!Eof() ) .And. (cAliasPZR)->(PZR_FILIAL+PZR_CODMOV+PZR_CODLOJ)==cChavePZR
		DelReg(cAliasPZR)
		(cAliasPZR)->(DbSkip())
	EndDo
	DelReg(cAliasPZQ)
	
	
	
	End Transaction
	
	//R007Write("Fim Movimento "+cMovimento+CRLF+"*******"+Time()+"***********************************"+CRLF)
	
	(cQryAlias)->(DbSkip())
	
	
EndDo
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  12/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DelReg(cAliasTab)
RecLock(cAliasTab,.F.)
(cAliasTab)->(DbDelete())
(cAliasTab)->(MsUnLock())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  01/06/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xDelCFDupl()
Local aAreaAtu 	:= GetArea()
Local cArqTmp	:= GetNextAlias()
Local cQryAlias	:= GetNextAlias()
Local cQuery    := ""
Local cChavePZR


RPCSETENV("01","03")
BeginSQL Alias cQryAlias
	SELECT PZQ_CODMOV,PZQ_CODLOJ,SUBSTR(PZQ_EMISSA,1,6),  Count(1)
	FROM PZQ010 PZQ
	WHERE PZQ_FILIAL=' '
	AND PZQ_CODMOV BETWEEN '     ' AND '99999'
	and PZQ.D_E_L_E_T_=' '
	and PZQ.PZQ_NUMORC=' '
	AND PZQ_OPER IN ('VE','TRV','CA')
	group by PZQ_CODMOV,PZQ_CODLOJ,SUBSTR(PZQ_EMISSA,1,6)
	having count(1)>1
	order by 3
EndSQL


PZQ->(DbSetOrder(3))
PZR->(DbSetOrder(3))

Do While (cQryAlias)->(!Eof())
	
	If PZQ->(DbSeek(xFilial("PZQ")+(cQryAlias)->(PZQ_CODMOV+PZQ_CODLOJ) ))
		cChavePZR:=PZQ->(PZQ_FILIAL+PZQ_CODMOV+PZQ_CODLOJ)
		PZR->(MsSeek(cChavePZR))//
		Do While PZR->(!Eof() ) .And. PZR->(PZR_FILIAL+PZR_CODMOV+PZR_CODLOJ)==cChavePZR
			PZR->(RecLock("PZR",.F.))
			PZR->(DbDelete())
			PZR->(MsUnLock())
			PZR->(DbSkip())
		EndDo
		PZQ->(RecLock("PZQ",.F.))
		PZQ->(DbDelete())
		PZQ->(MsUnLock())
	EndIf
	(cQryAlias)->(DbSkip())
EndDo


(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  01/07/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function XVerDuplic()
Local cQryAlias	:= GetNextAlias()
Local cArqTmp	:= GetNextAlias()
Local cVerificar:=""

RPCSETENV("40","01")


BeginSQL Alias cQryAlias
	SELECT D2_FILIAL,D2_EMISSAO, D2_DOC,D2_SERIE,D2_COD,D2_QUANT,D2_PRCVEN,D2_TOTAL,D2_CLIENTE,D2_LOJA,Count(1) Contar
	FROM %table:SD2% SD2
	WHERE D2_FILIAL BETWEEN '01' and '99'
	AND D2_EMISSAO BETWEEN '20151201' AND '20151231'
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_=' '
	group by D2_FILIAL,D2_EMISSAO, D2_DOC,D2_SERIE,D2_COD,D2_QUANT,D2_PRCVEN,D2_TOTAL,D2_CLIENTE,D2_LOJA
	having Count(1)> 1
	Order by D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA
EndSQL

SF2->(DbSetOrder(1))
Do While (cQryAlias)->(!Eof())
	
	cChave:=(cQryAlias)->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)
	If !SF2->(DbSeek(cChave))
		(cQryAlias)->(DbSkip());Loop
	EndIf
	
	Do While (cQryAlias)->(!Eof()) .And. (cQryAlias)->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==cChave
		
		cQuery:=" SELECT  COD_PRODUTO,QUANTIDADE,TOTAL,VALOR,Count(1) ContarWM"
		cQuery+=" FROM INTEGRACAO_MOVIMENTO_FISCAL
		cQuery+=" WHERE COD_MOVIMENTO="+SF2->F2_YCODMOV
		cQuery+=" AND NUMERO_NOTA="+SF2->F2_DOC
		cQuery+=" AND COD_PRODUTO="+(cQryAlias)->D2_COD
		cQuery+=" Group by COD_PRODUTO,QUANTIDADE,TOTAL,VALOR"
		
		oConectDB:= U_DBWebManager() //Funcao encontrada no NCIWMF02
		If !oConectDB:OpenConnection()
			Return
		EndIf
		
		oConectDB:NewAlias( cQuery, cArqTmp )
		
		If (cArqTmp)->ContarWM>0 .And. (cArqTmp)->ContarWM<(cQryAlias)->Contar
			cVerificar+="'"+SF2->F2_YCODMOV+"',"
		EndIf
		
		
		oConectDB:CloseConnection() //Fecha Conexao e o cQryAlias
		oConectDB:Finish()
		cArqTmp	:= GetNextAlias()
		
		(cQryAlias)->(DbSkip())
		
	EndDo
	
EndDo

Return

Static Function R007Write(cLine)
FWrite(nHdl,cLine,Len(cLine))
cLine:=""
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  01/12/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function XVerChave()
Local aUF	:={}
Local cLog  := ""
Local aLog	:= {}
Local cIdEnt	:= ""
Local cQuery 	:= ""
Local cQryAlias := ""
Local nContar:=0
Local cTotal

Private lUsaColab := .F.

aadd(aUF,{"RO","11"})
aadd(aUF,{"AC","12"})
aadd(aUF,{"AM","13"})
aadd(aUF,{"RR","14"})
aadd(aUF,{"PA","15"})
aadd(aUF,{"AP","16"})
aadd(aUF,{"TO","17"})
aadd(aUF,{"MA","21"})
aadd(aUF,{"PI","22"})
aadd(aUF,{"CE","23"})
aadd(aUF,{"RN","24"})
aadd(aUF,{"PB","25"})
aadd(aUF,{"PE","26"})
aadd(aUF,{"AL","27"})
aadd(aUF,{"MG","31"})
aadd(aUF,{"ES","32"})
aadd(aUF,{"RJ","33"})
aadd(aUF,{"SP","35"})
aadd(aUF,{"PR","41"})
aadd(aUF,{"SC","42"})
aadd(aUF,{"RS","43"})
aadd(aUF,{"MS","50"})
aadd(aUF,{"MT","51"})
aadd(aUF,{"GO","52"})
aadd(aUF,{"DF","53"})
aadd(aUF,{"SE","28"})
aadd(aUF,{"BA","29"})
aadd(aUF,{"EX","99"})

aVerificar:={}

//RpcSetEnv("40","08")
RpcSetEnv("01","03")

cQryAlias:=GetNextAlias()

BeginSQL Alias cQryAlias
	SELECT Count(1) Contar  fROM %table:SF2%
	WHERE F2_FILIAL = '03'
	AND F2_DOC IN('000177847','000200850')
	AND F2_SERIE = '3' 
	AND D_E_L_E_T_ = ' '
	Order by F2_DOC, F2_SERIE
EndSql
cTotal:=StrZero( (cQryAlias)->Contar,5 )

(cQryAlias)->(DbCloseArea())
BeginSQL Alias cQryAlias
	SELECT F2_DOC, F2_SERIE, F2_FIMP, F2_CHVNFE, R_E_C_N_O_ RECNOSF2
	fROM %table:SF2%
	WHERE F2_FILIAL = '03'
	AND F2_DOC IN('000177847','000200850')
	AND F2_SERIE = '3' 
	AND D_E_L_E_T_ = ' '
	Order by F2_DOC, F2_SERIE
EndSql



/*BeginSQL Alias cQryAlias
	SELECT Count(1) Contar  fROM %table:SF2%
	WHERE F2_FILIAL = '08'
	AND F2_YCODMOV IN('49226','49124')
	AND D_E_L_E_T_ = ' '
	Order by F2_DOC, F2_SERIE
EndSql
cTotal:=StrZero( (cQryAlias)->Contar,5 )


(cQryAlias)->(DbCloseArea())
BeginSQL Alias cQryAlias
	SELECT F2_DOC, F2_SERIE, F2_FIMP, F2_CHVNFE, R_E_C_N_O_ RECNOSF2
	fROM %table:SF2%
	WHERE F2_FILIAL = '08'
	AND F2_YCODMOV IN('49226','49124')
	AND D_E_L_E_T_ = ' '
	Order by F2_DOC, F2_SERIE
EndSql*/

cIdEnt	:= ""
cIdEnt 	:= GetIdEnt()

Do While (cQryAlias)->(!Eof())
	
	SF2->(DbGoTo((cQryAlias)->RECNOSF2))
	cMensagem:="Registro:"+StrZero(++nContar,5)+"/"+cTotal
	PtInternal(1,cMensagem )
	
	cLog	:= ""
	aNota	:={}
	
	aadd(aNota,SF2->F2_SERIE)
	aadd(aNota,IIf(Len(SF2->F2_DOC)==6,"000","")+SF2->F2_DOC)
	aadd(aNota,SF2->F2_EMISSAO)
	
	cChave := aUF[aScan(aUF,{|x| x[1] == SM0->M0_ESTCOB})][02]+FsDateConv(aNota[03],"YYMM")+SM0->M0_CGC+"55"+StrZero(Val(aNota[01]),3)+StrZero(Val(aNota[02]),9)+"1"
	cChave+=Inverte(StrZero(Val(aNota[02]),8))
	
	//Finaliza a chave de acesso
	cChave := SubStr(cChave,1,43) + Modulo11(SubStr(cChave,1,43) )
	cLog := ""
	
	
	//Consulta NFe pela chave
	cLog := ConsNFeChave(cChave,cIdEnt)
	cLog := "Doc: "+SF2->F2_DOC+"  Chave: "+cChave+"  msg: "+cLog
	
	Aadd(aLog, cLog)
	
	
	(cQryAlias)->(DbSkip())
EndDo


(cQryAlias)->(DbCloseArea())
//MemoWrite("nc_consulta_chave_nfe_40_08.txt", VarInfo(" ", aLog, , .F.))

Return




//Realiza a consulta da NFE
Static Function ConsNFeChave(cChaveNFe,cIdEnt)

Local cURL     := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local cMensagem:= ""
Local oWS

oWs:= WsNFeSBra():New()
oWs:cUserToken   := "TOTVS"
oWs:cID_ENT    	 := cIdEnt
ows:cCHVNFE		 := cChaveNFe
oWs:_URL         := AllTrim(cURL)+"/NFeSBRA.apw"

If oWs:ConsultaChaveNFE()
	cMensagem := ""
	/*	If !Empty(oWs:oWSCONSULTACHAVENFERESULT:cVERSAO)
	cMensagem += "Versใo: "+oWs:oWSCONSULTACHAVENFERESULT:cVERSAO+CRLF
	EndIf
	cMensagem += "Ambiente: "+IIf(oWs:oWSCONSULTACHAVENFERESULT:nAMBIENTE==1,"Produ็ใo","Homologa็ใo")+CRLF //"Produ็ใo"###"Homologa็ใo"
	cMensagem += "Cod.Ret.NF: "+oWs:oWSCONSULTACHAVENFERESULT:cCODRETNFE+CRLF
	cMensagem += "Msg.Ret.NFe: "+oWs:oWSCONSULTACHAVENFERESULT:cMSGRETNFE+CRLF
	If !Empty(oWs:oWSCONSULTACHAVENFERESULT:cPROTOCOLO)
	cMensagem += "Protocolo : "+oWs:oWSCONSULTACHAVENFERESULT:cPROTOCOLO+CRLF
	EndIf
	If !Empty(oWs:oWSCONSULTACHAVENFERESULT:cDIGVAL)
	cMensagem += "Digest Value: "+oWs:oWSCONSULTACHAVENFERESULT:cDIGVAL+CRLF
	EndIf
	*/
	cMensagem += Alltrim("  Protocolo : "+oWs:oWSCONSULTACHAVENFERESULT:cPROTOCOLO )
	cMensagem += Alltrim("  Msg.Ret.NFe: "+oWs:oWSCONSULTACHAVENFERESULT:cMSGRETNFE)
	
Else
	cMensagem := ""
EndIf

Return cMensagem


Static Function GetIdEnt()

Local aArea  := GetArea()
Local cIdEnt := ""
Local cURL   := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local oWs
Local lUsaGesEmp := IIF(FindFunction("FWFilialName") .And. FindFunction("FWSizeFilial") .And. FWSizeFilial() > 2,.T.,.F.)
Local lEnvCodEmp := GetNewPar("MV_ENVCDGE",.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem o codigo da entidade                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := IIF(lUsaGesEmp,FWFilialName(),Alltrim(SM0->M0_NOME))
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""

If lUsaGesEmp .And. lEnvCodEmp
	oWS:oWSEMPRESA:CIDEMPRESA:= FwGrpCompany()+FwCodFil()
EndIf

oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
Else
	cIdEnt  := ""
EndIf

RestArea(aArea)
Return(cIdEnt)



Static Function Inverte(uCpo, nDig)
Local cRet	:= ""
Default nDig := 9
cRet	:=	GCifra(Val(uCpo),nDig)

Return(cRet)


/*Static Function GCifra(nNum, nDig)
Local cNumNF := strzero(nNum,9)
Local nDV := val(right(cNumNF,1)) // Tabela de-para de acordo com o ultimo digito
Local cNumCheck := ''
Local nI

DEFAULT	nDig	:=	9

nIniFor	:=	Iif(nDig==8,4,3)

If __aDePara == NIL

__aDePara := {}
aadd(__aDePara,"3247015698")
aadd(__aDePara,"8762341509")
aadd(__aDePara,"1350924687")
aadd(__aDePara,"6420875931")
aadd(__aDePara,"2345678901")
aadd(__aDePara,"5398712460")
aadd(__aDePara,"1470258369")
aadd(__aDePara,"5647382901")
aadd(__aDePara,"9123765408")
aadd(__aDePara,"1973820564")

Endif

// Fase 1 : Pega do terceiro ao oitavo digito
// E realiza a troca pela tabela de-para
For nI := nIniFor to 8
nOrig := asc(substr(cNumNF,nI,1))-47
cNumCheck += substr( __aDePara[nDV+1], nOrig , 1)
Next

// Fase 2: Desloca o numero gerado um pouco ...
For nI := 0 to nDV+1
cNumCheck := substr(cNumCheck,2)+left(cNumCheck,1)
Next

// Fase 3 : Copia os 2 primeiros digitos, mais o numero criptografado,
// mais o ultimo numero, que foi o indice usado para fazer as trocas !

Return left(cNumNF,2)+cNumCheck+right(cNumNF,1)
*/


User Function NCGTECO()

Local aNf		:= {}
Local nX 		:= 0
Local aTitulo	:= {}
Local cLogRet	:= ""

RpcSetEnv("01","03")

Aadd(aNf, '000156533')
Aadd(aNf, '000156591')
Aadd(aNf, '000161556')

DbSelectArea("SF2")
DbSetOrder(1)


For nX := 1 To Len(aNf)
	cLogRet	:= ""
	aTitulo := {}
	If SF2->(MsSeek(xFilial("SF2") + aNf[nX]))
		
		AADD(aTitulo,	{"E1_PREFIXO"	,"ECO"					,Nil})
		AADD(aTitulo,	{"E1_NUM"		,SF2->F2_DOC			,Nil})
		AADD(aTitulo,	{"E1_PARCELA"	,"1"					,Nil})
		AADD(aTitulo,	{"E1_TIPO"		,"NF"					,Nil})
		AADD(aTitulo,	{"E1_NATUREZ"	,"19101"				,Nil})
		AADD(aTitulo,	{"E1_CLIENTE"	,SF2->F2_CLIENTE		,Nil})
		AADD(aTitulo,	{"E1_LOJA"	    ,SF2->F2_LOJA			,Nil})
		AADD(aTitulo,	{"E1_NOMCLI"	,Posicione("SA1",1,xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA,"A1_NREDUZ")		,Nil})
		AADD(aTitulo,	{"E1_EMISSAO" 	,MsDate()		 		,Nil})
		AADD(aTitulo,	{"E1_VENCTO" 	,MsDate()+30	  		,Nil})
		AADD(aTitulo,	{"E1_VALOR"		,SF2->F2_VALBRUT		,Nil})
		AADD(aTitulo,	{"E1_ORIGEM"	,"MATA460"				,Nil})
		
		cLogRet := GerTitEco(aTitulo, 3 )
		If Empty(cLogRet)
			Reclock("SF2",.F.)
			SF2->F2_PREFIXO := "ECO"
			SF2->F2_DUPL 	:= SF2->F2_DOC
			SF2->(MsUnLock())
			
		EndIf
		
	EndIf
Next


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerTitEco บAutor  ณMicrosiga           บ Data ณ  07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera็ใo de titulos do E-commerce						      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerTitEco(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {}
Default nOpc	:= 3//Inclusใo

//Inicio da transa็ใo
Begin Transaction

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, nOpc)
	//Fina040(aTitulo,nOpc)
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa็ใo
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados nใo informados"
EndIf

//Finalisa a transa็ใo
End Transaction

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  01/27/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function DELSA1
Local cQryAlias
Local aMensagem:={}
Local aDelSA1:={}
//	//AND A1_XEMAIL2 LIKE '%@ct.vtex.com.br%'
RpcSetEnv("01","03")

cQryAlias:=GetNextAlias()

BeginSQL Alias cQryAlias
	SELECT SA1.A1_CGC,SA1.R_E_C_N_O_ RECSA1
	FROM SA1010 SA1,(
	SELECT A1_CGC,COUNT(1) CONTAR
	FROM SA1010
	WHERE A1_FILIAL=' '
	AND A1_CGC<>' '
	AND A1_YDCANAL='E-COMMERCE B2C                '
	AND D_E_L_E_T_=' '
	GROUP BY A1_CGC
	HAVING COUNT(1)>1) TAB1
	WHERE SA1.A1_FILIAL=' '
	AND SA1.A1_CGC=TAB1.A1_CGC
	AND D_E_L_E_T_=' '
	ORDER BY 1
EndSql

Do While (cQryAlias)->(!Eof())
	
	SA1->( DbGoTo(  (cQryAlias)->RECSA1 ) )
	aVetor:={}
	AADD(aVetor,{"A1_FILIAL" 	,SA1->A1_FILIAL ,Nil})
	AADD(aVetor,{"A1_COD" 		,SA1->A1_COD,Nil})
	AADD(aVetor,{"A1_LOJA" 		,SA1->A1_LOJA ,Nil})
	
	cGrupo:=SA1->A1_GRPVEN
	
	//Begin Transaction
	GrupoCli(cGrupo,.T.)
	
	lMsErroAuto:=.F.
	MSExecAuto({|x,y| MATA030(x,y)},aVetor, 5)
	//A02CF3
	If lMsErroAuto
		GrupoCli(cGrupo,.F.)	
		MostraErro('cPath',NomeAutoLog())//Apagar o arquivo atual
	Else
		GrupoCli("XXXXXX",.F.)
	Endif
	MsUnLockAll()
	//End Transaction
	(cQryAlias)->(DbSkip())
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  01/27/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrupoCli(cGrupo,lLimpa)
SA1->(RecLock("SA1",.F.))
SA1->A1_GRPVEN:=IIf(lLimpa,"",cGrupo)
SA1->(MsUnLock())
Return
 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBACA002   บAutor  ณMicrosiga           บ Data ณ  01/27/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Plc()

Local cPlacaAux := "AAA"
Local cPlaca	:= ""
Local aLog		:= {}
Local nX		:= 1                              
Local nHandle	:= 0
Local nY		:= 0
Local lContinua	:= .T.
Local nContLin	:= 0
Local cLinAux	:= ""

While UPPER(cPlacaAux) >= "AAA" .And. UPPER(cPlacaAux) <= "ZZZ"
	
	lContinua := .T.
	cPlacaAux 	:= soma1(cPlacaAux)
	For nX := 1 To 10
		If UPPER(Alltrim(Str(nX))) $ Upper(cPlacaAux)
			lContinua := .F.
			Exit
		EndIf
	Next
	
	If lContinua
		cPlaca		:= UPPER(cPlacaAux)+"-4545" 
		Aadd(aLog, cPlaca)
	EndIf
EndDo

For nX := 1 To Len(aLog)
	
	++nContLin
	cLinAux += aLog[nX]+";"
	If nContLin >= 10
		nHandle 	:= GrvTxtArq( "teste.txt", cLinAux, "\IMPNFE\", nHandle)
		
		nContLin 	:= 0
		cLinAux		:= ""
	EndIf
Next

//Fecha o arquivo
If nHandle != 0 
	FClose( nHandle )
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvTxtArq  บAutor  ณMicrosiga          บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava o texto no final do arquivo                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvTxtArq( cArq, cTexto, cDir, nHandle)

Local alArea	:= GetArea()
Local cPathAbs	:= cDir + cArq

Default cArq 		:= ""
Default cTexto 	:= ""
Default cDir 		:= ""
Default nHandle	:= 0 

If !Empty(cDir) .And. !Empty(cArq)

	If !ExistDir(cDir)
		
		If MakeDir( cDir ) < 0
			conout( 'Erro na cria็ใo da pasta ' + Alltrim( cDir ) )
			Return NIL
		EndIf

	EndIf
	 
	If !File(cPathAbs)
		nHandle := FCreate( cPathAbs )
		FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
		FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 )		
	Else
		FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
		FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 ) 
	Endif

EndIf

RestArea(alArea)
Return nHandle  
                   
User Function TestCTE01()

	Local aArea := GetArea()
	Local oWsdl
	Local xRet
	Local cMsg := ""
	Local cRet := ""


	oWsdl := TWsdlManager():New()

	xRet := oWsdl:ParseURL( "http://192.168.0.200:8080/NFESBRA.apw?WSDL" )
	if xRet == .F.
		alert( "Erro: " + oWsdl:cError )
		RestArea(aArea)
		Return
	endif

	// Define a opera็ใo
	lRet := oWsdl:SetOperation("CONSULTACHAVENFE")
	If lRet == .F.
		conout("Erro SetOperation: " + oWsdl:cError)
		return
	EndIf

	cMsg += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:nfs="http://webservices.totvs.com.br/nfsebra.apw">
	cMsg += '<soapenv:Header/>
	cMsg += '<soapenv:Body>
	cMsg += '<nfs:CONSULTACHAVENFE>
	cMsg += '<nfs:USERTOKEN>TOTVS</nfs:USERTOKEN>
	cMsg += '<nfs:ID_ENT>000002</nfs:ID_ENT>
	cMsg += '<nfs:CHVNFE>35170301455929000330550030002872151009649358</nfs:CHVNFE>
	cMsg += '</nfs:CONSULTACHAVENFE>
	cMsg += '</soapenv:Body>
	cMsg += '</soapenv:Envelope>

	// Envia uma mensagem SOAP personalizada ao servidor
	xRet := oWsdl:SendSoapMsg( cMsg )
	if xRet == .F.
		alert( "Erro: " + oWsdl:cError )
		RestArea(aArea)
		Return
	endif

	cRet := oWsdl:GetSoapResponse()
    cRet
	alert(cRet)
	oWsdl := NIL
	RestArea(aArea)
Return

user function notImportCli(aDados)

Local aArea := GetArea()
Local cQuery := "select a1_zcodcia from sa1010 where a1_zcodcia != 0"
Local cAlias := GetNextAlias()
Local aCli := {}

Default aDados:={"01","03"}
RpcSetType(3)
RpcSetEnv(aDados[1],aDados[2])

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .T., .F.)

Do while !((cAlias)->(Eof()))

aadd(aCli,{ iif( ValType( (cAlias)->a1_zcodcia) == "N",alltrim(str((cAlias)->a1_zcodcia)),(cAlias)->a1_zcodcia)  ,"1"})
(cAlias)->(dbSkip())
EndDo

U_NCECOM02(aCli)

RestArea(aArea)
return