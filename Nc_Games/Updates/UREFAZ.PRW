#INCLUDE "MATA215.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE MAXPASSO 16

User Function MATA215(lBat)
Local cCadastro:= OemtoAnsi(STR0001)  		//"Refaz Acumulados"
Local bBlNewProc := {|oCenterPanel|MA215Do(lBat,oCenterPanel)}
Local lUsaNewPrc := If(FindFunction('UsaNewPrc'),UsaNewPrc(),.F.)
Local aSays      :={}
Local aButtons   :={}

DEFAULT lBat := .F.

#IFDEF TOP
	TCInternal(5,"*OFF")   // Desliga Refresh no Lock do Top
#ENDIF

AADD(aSays,STR0017) //"Este programa tem como objetivo refazer os Saldos de Pedidos, Solicita?es e Ordens"
AADD(aSays,STR0018) //"de Produ?o dos Produtos com base nos seus respectivos movimentos."
AADD(aSays," ")
AADD(aSays,STR0019) //"ATEN?O - Esta rotina ser?executada em MODO EXCLUSIVO, portanto somente esta esta?o"
AADD(aSays,STR0020) //"poder?estar ativa enquanto estiver processando a rotina de Refaz Acumulado."

AADD(aButtons, { 1,.T.,{|| If(MA215Do(lBat),FechaBatch(),.F.) }} )
AADD(aButtons, { 2,.T.,{|| FechaBatch() }} )

ProcLogIni(aButtons)

If IsBlind()
	BatchProcess(cCadastro,STR0002+CRLF+STR0008,NIL,{|| MA215Do(.T.)})
ElseIf !lBat
	If (GetRPORelease() >= "R1.1" .And. lUsaNewPrc)
		tNewProcess():New("MATA215",cCadastro,bBlNewProc,OemtoAnsi(STR0002)+chr(13)+chr(13)+OemtoAnsi(STR0008),"")
	Else
		FormBatch(cCadastro,aSays,aButtons,,220,560)		
	EndIf
Else
	Ma215Do(lBat)
EndIf         
Return 


/*
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?a215Do   ?utor  ?odrigo de A. Sartorio ?Data ?4.07.2002 ??
???????????????????????????????????????
??         ?otina de chamada do MATA215                                 ??
???????????????????????????????????????
??intaxe   ?a215Do(ExpL1)							                   ??
???????????????????????????????????????
??arametros?xpL1: Indica se o processo sera' Batch                      ??
???????????????????????????????????????
??etorno   ?enhum                                                       ??
???????????????????????????????????????
??so       ?Materiais                                                   ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
*/
Function MA215Do(lBat,oCenterPanel)
Local oObj
Local lNewProc := .F. 

If oCenterPanel <> NIL
	oObj     := oCenterPanel
	lNewProc := .T.
EndIf

If lBat
	Ma215Proc(lBat,oObj)
Else
	If !lNewProc
		oObj := MsNewProcess():New({|lEnd| Ma215Proc(lBat,oObj,lNewProc)},"","",.F.)
		oObj :Activate()
	Else
		Ma215Proc(lBat,oObj,lNewProc)
	EndIf
EndIf	
Return .T.


/*
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?a215Proc ?Rev   ?Eduardo Riera         ?Data ?0.03.2001 ??
???????????????????????????????????????
??         ?otina de Processamento do MATA215                           ??
??         ?                                                            ??
???????????????????????????????????????
??intaxe   ?a215Proc(ExpL1,ExpO1)					                   ??
???????????????????????????????????????
??arametros?xpL1: Indica se o processo sera' Batch                      ??
??         ?xpO1: nome do obj da regua de processamento                 ??
??         ?xpL2: define se esta utilizando tNewProcess()               ??
???????????????????????????????????????
??etorno   ?enhum                                                       ??
???????????????????????????????????????
??escri?o ?sta rotina tem como objetivo processar os acumulados do MRP-??
??         ?                                                            ??
???????????????????????????????????????
??so       ?Materiais                                                   ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
*/
Static Function Ma215Proc(lBat,oObj,lNewProc)
Local aStru     := {}
Local aSaldos   := {}
Local aTravas   := {}
Local aAreaSB8  := {}
Local aAreaSB6  := {}
Local cQuery    := ""
Local cChave    := ""
Local lQuery    := .F.
Local lContinua := .F.
Local lLiberOk	:= .T.
Local lResidOk	:= .T.
Local lFaturOk	:= .F.
Local lAchou    := .F.
Local lSC6Ok    := .F.
Local cQuebra   := ""
Local cAliasSB2 := "SB2"
Local cAliasSB6 := "SB6"
Local cAliasSB8 := "SB8"
Local cAliasSBF := "SBF"
Local cAliasSC0 := "SC0"
Local cAliasSC1 := "SC1"
Local cAliasSC2 := "SC2"
Local cAliasSC6 := "SC6"
Local cAliasSC7 := "SC7"
Local cAliasSC9 := "SC9"
Local cAliasSD4 := "SD4"
Local cAliasAFJ := "AFJ"
Local cAliasSDC := "SDC"
Local cAliasSD1 := "SD1"
Local caliasSD2 := "SD2"
Local cAliasSL2 := "SL2"									// Alias do arquivo SL2
Local cSavFil   := cFilAnt
Local cFirst    := ""
Local nX        := 0
Local nMax      := 0
Local nMin      := 0
Local nQtdLib2  := 0 
Local nRegSB6	:= 0

Local nEmpenho  := 0 
Local nEmpenh2  := 0
Local nBaixaEmp := 0 
Local nBaixaEm2 := 0 
Local nQuantDc  := 0
Local nQtdDifDc := 0

Local cSeek     := ""
Local cSeekSDC  := ""
Local cCompara  := ""
Local cMensagem := ""
Local cEstoque  := ""
Local nTempoIni := 0,nTempoFim:=0,cTempo:=""
Local cLocOriSB6:= ""
Local lEmpPrev  := If(SuperGetMV("MV_QTDPREV")== "S",.T.,.F.)
Local lNegEstr  := SuperGetMV("MV_NEGESTR",.F.,.F.)
Local lPCFilEnt := SuperGetMv("MV_PCFILEN",.F.,.F.)
Local aTabs     := {}
Local lLockTabs := .T.
Local lAtuRes   := .T.                       // Define se atualiza a reserva (TPL OTC)

DEFAULT lNewProc := .F.

//??????????????????????????????????
//?emaforo para controle de execucao da rotina                      ?
//??????????????????????????????????
If !MA215Lock(cEmpAnt)
	Return
EndIf

//??????????????????????????????????
//?onto de entrada para controlar execucao da rotina de acumuladores?
//??????????????????????????????????
If ExistBlock( "MT215PRO" )
   lRet := ExecBlock("MT215PRO",.F.,.F.)
   If ValType(lRet) <> "L"
     	lRet:=.T.
   EndIf  
   
   If !lRet
    	Return
   EndIf 
Endif

//???????????????????
//?Atualiza o log de processamento   ?
//???????????????????
ProcLogAtu("INICIO")

//????????????????????????????????
//?Abre todos os arquivos de forma exclusiva                    ?
//????????????????????????????????
AADD(aTabs,"SA1");AADD(aTabs,"SB1");AADD(aTabs,"SB2");AADD(aTabs,"SB8");AADD(aTabs,"SC0");AADD(aTabs,"SC6")
AADD(aTabs,"SC7");AADD(aTabs,"SC9");AADD(aTabs,"SD2");AADD(aTabs,"SD1");AADD(aTabs,"SD4");AADD(aTabs,"SDC")
AADD(aTabs,"SDD");AADD(aTabs,"SC1");AADD(aTabs,"SC2");AADD(aTabs,"SB6");AADD(aTabs,"SBF");AADD(aTabs,"SDA")
AADD(aTabs,"SL2");AADD(aTabs,"SCQ")

For nX := 1 To Len(aTabs)
	If !MA280FLock(aTabs[nX],,!IsBlind())
		lLockTabs := .F.
		Exit
	Endif	
Next	

If !lLockTabs
	//????????????????????????????????
	//?Fecha todos os arquivos e reabre-os de forma compartilhada   ?
	//????????????????????????????????
	For nX := 1 To Len(aTabs)
		dbSelectArea(aTabs[nX])
		dbCloseArea()
	Next	
	OpenFile(SubStr(cNumEmp,1,2),"")
	If IsBlind()
		Conout(STR0011) //"MATA215:N? foi possivel abrir todas as tabelas de forma exclusiva" 
	EndIf	
	Return
Else
	For nX := 1 To Len(aTabs)
		OpenIndx(aTabs[nX])
	Next
EndIf

//????????????????????????????????
//?Posiciona na Primeira Filial                                 ?
//????????????????????????????????
nTempoIni:=Seconds()
dbSelectArea("SM0")
dbSetOrder(1)
If Empty(xFilial("SA1")) .Or. Empty(xFilial("SB2")) .Or. lPCFilEnt
	MsSeek(cEmpAnt)
	cFirst := FWGETCODFILIAL
Else
	MsSeek(cEmpAnt+cFilAnt)
	cFirst := FWGETCODFILIAL
EndIf
While !Eof() .And. cEmpAnt == SM0->M0_CODIGO
	If !lBat
		oObj:SetRegua2(MAXPASSO)
		oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
	EndIf
	//????????????????????????????????
	//?Altera a Filial do Sistema                                   ?
	//????????????????????????????????
	cFilAnt := FWGETCODFILIAL
	If !lBat
		If (oObj <> NIL) .And. lNewProc
			oObj:SaveLog(OemToAnsi(STR0009))
		EndIf
	EndIf
	//????????????????????????
	//?Atualiza o log de processamento             ?
	//????????????????????????
	ProcLogAtu("MENSAGEM",STR0012+cFilAnt,STR0012+cFilAnt) // "Inicio Filial: "
	//????????????????????????????????
	//?Verifica se h?registros pendentes no SC9                    ?
	//????????????????????????????????
	If FtVldJobFt()
		//????????????????????????????????
		//?Zerar os dados a ser atualizado                              ?
		//????????????????????????????????
		If (!Empty(xFilial("SA1")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SA1")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSA1 := "SA1MA215PROC"
					
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SA1")+" "
					cQuery += "WHERE A1_FILIAL='"+xFilial("SA1")+"' AND "
					cQuery += "D_E_L_E_T_=' '"
					cQuery := ChangeQuery(cQuery)
			
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSA1)
					nMax := (cAliasSA1)->MAXRECNO
					nMin := (cAliasSA1)->MINRECNO
					dbCloseArea()
					dbSelectArea("SA1")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SA1")+" "	
					cQuery += "SET A1_SALPED = 0, "
					cQuery += "A1_SALPEDL = 0, "
					cQuery += "A1_SALPEDB = 0 "
					cQuery += "WHERE A1_FILIAL='"+xFilial("SA1")+"' AND "
					cQuery += "D_E_L_E_T_=' ' AND "
					If !lBat
						oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//?????????????????????????????
					//? tabela eh fechada para restaurar o buffer da aplicacao?
					//?????????????????????????????
					dbSelectArea("SA1")
					dbCloseArea()
					ChkFile("SA1",.T.)
				Else
			#ENDIF
				If !lBat
					oObj:SetRegua1(SA1->(LastRec()))
				EndIf	
				dbSelectArea("SA1")
				dbSetOrder(1)
				MsSeek(xFilial("SA1"))
				While !Eof() .And. SA1->A1_FILIAL == xFilial("SA1")
					RecLock("SA1",.F.)
					Replace A1_SALPED  With 0
					Replace A1_SALPEDL With 0
					Replace A1_SALPEDB With 0
					MsUnLock()
					dbSelectArea("SA1")
					dbSkip()
					If !lBat
						oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf
			#ENDIF
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (IIf(lPCFilEnt,.F.,!Empty(xFilial("SB2"))) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SB2")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSB2 := "SB2MA215PROC"
					
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SB2")+" "
					If lPCFilEnt
						cQuery += "WHERE "
					Else
						cQuery += "WHERE B2_FILIAL='"+xFilial("SB2")+"' AND "
					EndIf	
					cQuery += "D_E_L_E_T_=' '"
					cQuery := ChangeQuery(cQuery)
				
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB2)
					nMax := (cAliasSB2)->MAXRECNO
					nMin := (cAliasSB2)->MINRECNO
					dbCloseArea()
					dbSelectArea("SB2")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SB2")+" "
					cQuery += "SET B2_RESERVA = 0,"
					cQuery += "B2_RESERV2 = 0,"								
					cQuery += "B2_QEMP    = 0,"
					cQuery += "B2_QEMP2   = 0,"	
					cQuery += "B2_QEMPN   = 0,"
					cQuery += "B2_QEMPN2  = 0,"	
					cQuery += "B2_NAOCLAS = 0,"
					cQuery += "B2_SALPEDI = 0,"
					cQuery += "B2_SALPED2 = 0,"	
					cQuery += "B2_QPEDVEN = 0,"
					cQuery += "B2_QPEDVE2 = 0,"
					cQuery += "B2_QTNP    = 0,"
					cQuery += "B2_QNPT    = 0,"
					cQuery += "B2_QTER    = 0,"
					cQuery += "B2_QEMPPRE = 0,"
					cQuery += "B2_SALPPRE = 0,"
					cQuery += "B2_QACLASS = 0,"
					cQuery += "B2_QEMPPRJ = 0,"
					cQuery += "B2_QEMPPR2 = 0,"	
					cQuery += "B2_QEMPSA  = 0 "
					If lPCFilEnt
						cQuery += "WHERE "
					Else
						cQuery += "WHERE B2_FILIAL='"+xFilial("SB2")+"' AND "
					EndIf	
					cQuery += "D_E_L_E_T_=' ' AND "
					If !lBat
						oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//?????????????????????????????
					//? tabela eh fechada para restaurar o buffer da aplicacao?
					//?????????????????????????????
					dbSelectArea("SB2")
					dbCloseArea()
					ChkFile("SB2",.T.)
				Else
			#ENDIF
				If !lBat
					oObj:SetRegua1(SB2->(LastRec()))
				EndIf	
				dbSelectArea("SB2")
				dbSetOrder(1)
				MsSeek(xFilial("SB2"),.T.)
				While !Eof() .And. SB2->B2_FILIAL == xFilial("SB2")
					RecLock("SB2",.F.)
					Replace B2_RESERVA With 0
					Replace B2_RESERV2 With 0			
					Replace B2_QEMPPRJ WITH 0
					Replace B2_QEMPPR2 WITH 0
					Replace B2_QEMP    WITH 0
					Replace B2_QEMP2   WITH 0			
					Replace B2_QEMPN   With 0
					Replace B2_QEMPN2  With 0			
					Replace B2_NAOCLAS With 0
					Replace B2_SALPEDI With 0
					Replace B2_SALPED2 With 0
					Replace B2_QPEDVEN With 0
					Replace B2_QPEDVE2 With 0			
					Replace B2_QTNP    With 0
					Replace B2_QNPT    With 0
					Replace B2_QTER    With 0
					Replace B2_QEMPPRE With 0
					Replace B2_QEPRE2  With 0
					Replace B2_SALPPRE With 0
					Replace B2_QACLASS With 0
					Replace B2_QEMPSA  With 0
					MsUnLock()
					dbSelectArea("SB2")
					dbSkip()
					If !lBat
						oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf 
			#ENDIF
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SB8")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SB8")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSB8 := "SB8MA215PROC"
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SB8")+" "
					cQuery += "WHERE B8_FILIAL='"+xFilial("SB8")+"' AND "
					cQuery += "D_E_L_E_T_=' '"
					cQuery := ChangeQuery(cQuery)
				
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB8)
					nMax := (cAliasSB8)->MAXRECNO
					nMin := (cAliasSB8)->MINRECNO
					dbCloseArea()
					dbSelectArea("SB8")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SB8")+" "	
					cQuery += "SET B8_EMPENHO = 0, "
					cQuery += "B8_EMPENH2 = 0, "	
					cQuery += "B8_QACLASS = 0, "
					cQuery += "B8_QACLAS2 = 0, "								
					cQuery += "B8_QEMPPRE = 0 "
					cQuery += "WHERE B8_FILIAL='"+xFilial("SB8")+"' AND "
					cQuery += "D_E_L_E_T_=' ' AND "
					If !lBat
						oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//?????????????????????????????
					//? tabela eh fechada para restaurar o buffer da aplicacao?
					//?????????????????????????????
					dbSelectArea("SB8")
					dbCloseArea()
					ChkFile("SB8",.T.)
				Else
			#ENDIF
				If !lBat
					oObj:SetRegua1(SB8->(LastRec()))
				EndIf	
			 	dbSelectArea("SB8")
				dbSetOrder(1)
				MsSeek(xFilial("SB8"),.T.)
				While !Eof() .And. SB8->B8_FILIAL == xFilial("SB8")
					RecLock("SB8",.F.)
					Replace B8_EMPENHO With 0
					Replace B8_EMPENH2 With 0		
					Replace B8_QACLASS With 0
					Replace B8_QACLAS2 With 0								
					Replace B8_QEMPPRE With 0
					Replace B8_QEPRE2  With 0
					MsUnLock()
					dbSelectArea("SB8")
					dbSkip()
					If !lBat
						oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf
			#ENDIF
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SBF")) .Or. cFilAnt == cFirst )
			dbSelectArea("SBF")
			dbSetOrder(1)
			MsSeek("SBF")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSBF := "SBFMA215PROC"
				
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SBF")+" "
					cQuery += "WHERE BF_FILIAL='"+xFilial("SBF")+"' AND "
					cQuery += "D_E_L_E_T_=' '"
					cQuery := ChangeQuery(cQuery)
				
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSBF)
					nMax := (cAliasSBF)->MAXRECNO
					nMin := (cAliasSBF)->MINRECNO
					dbCloseArea()
					dbSelectArea("SBF")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SBF")+" "
					cQuery += "SET BF_EMPENHO = 0, "
					cQuery += "BF_EMPEN2 = 0, "	
					cQuery += "BF_QEMPPRE = 0, "
					cQuery += "BF_QEPRE2 = 0 "
					cQuery += "WHERE BF_FILIAL='"+xFilial("SBF")+"' AND "
					cQuery += "D_E_L_E_T_=' ' AND "
					If !lBat
						oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//?????????????????????????????
					//? tabela eh fechada para restaurar o buffer da aplicacao?
					//?????????????????????????????
					dbSelectArea("SBF")
					dbCloseArea()
					ChkFile("SBF",.T.)
				Else
			#ENDIF
				If !lBat
					oObj:SetRegua1(SBF->(LastRec()))
				EndIf	
				dbSelectArea("SBF")
				dbSetOrder(1)
				MsSeek(xFilial("SBF"))
				While !Eof() .And. SBF->BF_FILIAL == xFilial("SBF")
					RecLock("SBF",.F.)
					Replace BF_EMPENHO With 0
					Replace BF_EMPEN2  With 0		
					Replace BF_QEMPPRE With 0
					Replace BF_QEPRE2  With 0
					MsUnLock()
					dbSelectArea("SBF")
					dbSkip()
					If !lBat
						oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf
			#ENDIF
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//????????????????????????????????
		//?tualiza os dados acumulados da Solicitacao de Compra         ?
		//????????????????????????????????
		If (!Empty(xFilial("SC1")) .Or. cFilAnt == cFirst )	
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC1")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SC1")
			dbSetOrder(1)
			If !lBat
				oObj:SetRegua1(SC1->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			#IFDEF TOP
				aStru	  := SC1->(dbStruct())
				lQuery    := .T.
				cAliasSC1 := "SC1MA215PROC"

				cQuery := ""				
				For nX := 1 To Len(aStru)
					cQuery += ","+aStru[nX][1]
				Next nX
				cQuery := "SELECT SB1.B1_FILIAL,"+SubStr(cQuery,2)+",SC1.D_E_L_E_T_,SC1.R_E_C_N_O_ SC1RECNO "
				cQuery += "FROM "+RetSqlName("SC1")+" SC1,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC1.C1_FILIAL='"+xFilial("SC1")+"' AND "
				cQuery += "SC1.C1_QUJE < SC1.C1_QUANT AND "
				cQuery += "SC1.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC1.C1_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY SC1.C1_FILIAL,SC1.C1_PRODUTO,SC1.C1_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC1,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" ) 
						TcSetField(cAliasSC1,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf		
				Next nX	
			#ELSE
				cQuery := "C1_FILIAL=='"+xFilial("SC1")+"' .And. "
				cQuery += "C1_QUJE < C1_QUANT "
				Set Filter To &cQuery 
				MsSeek(xFilial("SC1"))
			#ENDIF
			//????????????????????????????????
			//?tualiza os dados acumulados da Solicitacao de compra         ?
			//????????????????????????????????
			While !Eof() .And. (cAliasSC1)->C1_FILIAL == xFilial("SC1")
				lContinua := .T.
				If !lQuery
					//????????????????????????????
					//?erifica a existencia de Cotacoes e filial do produto?
					//????????????????????????????
					If (cAliasSC1)->C1_QUJE >= (cAliasSC1)->C1_QUANT .Or. !A215FilOk((cAliasSC1)->C1_PRODUTO)
						lContinua := .F.
					EndIf
				Else
					lContinua := .T.
				EndIf
				//????????????????????????????
				//?Ponto de Entrada para Tratamentos Especiais         ?
				//????????????????????????????	
				If ExistBlock("M215SC")
					If lQuery
						dbSelectArea("SC1")
						dbGoto((cAliasSC1)->SC1RECNO)
					EndIf
					If ExecBlock("M215SC",.f.,.f.)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					MaAvalSC(cAliasSC1,1,,,.T.)
				EndIf
				a215Skip(cAliasSC1)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSC1)
				dbCloseArea()
				dbSelectArea("SC1")
			Else
				dbClearFilter()
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//????????????????????????????????
		//?tualiza os dados acumulados do Pedido de Compra              ?
		//????????????????????????????????
		If (!Empty(xFilial("SC7")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC7")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("SC7")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SC7->(dbStruct())
				lQuery    := .T.
				cAliasSC7 := "SC7MA215PROC"
				
				cQuery := "SELECT C7_FILIAL,C7_PRODUTO,C7_LOCAL,C7_QUJE,C7_QUANT,C7_RESIDUO,C7_FILENT,C7_TPOP,C7_QTSEGUM,C7_FORNECE,C7_LOJA,C7_NUM,C7_ITEM,C7_OP,C7_SEQMRP,C7_DATPRF,C7_TIPO,C7_NUMCOT,C7_TES,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC7")+" SC7,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC7.C7_FILIAL='"+xFilial("SC7")+"' AND "
				cQuery += "SC7.C7_FILENT IN('  ','"+xFilial("SC7")+"') AND "
				cQuery += "SC7.C7_QUJE < C7_QUANT AND "
				cQuery += "SC7.C7_RESIDUO='"+Space(Len(SC7->C7_RESIDUO))+"' AND "
				cQuery += "SC7.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC7.C7_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "UNION ALL "
				cQuery += "SELECT C7_FILIAL,C7_PRODUTO,C7_LOCAL,C7_QUJE,C7_QUANT,C7_RESIDUO,C7_FILENT,C7_TPOP,C7_QTSEGUM,C7_FORNECE,C7_LOJA,C7_NUM,C7_ITEM,C7_OP,C7_SEQMRP,C7_DATPRF,C7_TIPO,C7_NUMCOT,C7_TES,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC7")+" SC7,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC7.C7_FILENT='"+xFilial("SC7")+"' AND "
				cQuery += "SC7.C7_FILIAL<>'"+xFilial("SC7")+"' AND "			
				cQuery += "SC7.C7_QUJE < C7_QUANT AND "
				cQuery += "SC7.C7_RESIDUO='"+Space(Len(SC7->C7_RESIDUO))+"' AND "
				cQuery += "SC7.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC7.C7_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY 1,2,3 "
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC7,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
						TcSetField(cAliasSC7,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				cQuery := "((C7_FILIAL=='"+xFilial("SC7")+"' .And. C7_FILENT$'  #"+xFilial("SC7")+"') .Or. (C7_FILIAL<>'"+xFilial("SC7")+"' .And. C7_FILENT=='"+xFilial("SC7")+"')) .And. "
				cQuery += "C7_QUJE < C7_QUANT .And. "
				cQuery += "C7_RESIDUO='"+Space(Len(SC7->C7_RESIDUO))+"'"
				Set Filter To &cQuery	
				MsSeek(xFilial("SC7"))
			#ENDIF
			If !lBat
				oObj:SetRegua1(SC7->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof()
				lContinua := .T.
				If !lQuery
					If ( (cAliasSC7)->C7_QUJE >= C7_QUANT ) .Or.;
							!Empty((cAliasSC7)->C7_RESIDUO) .Or.;
							!A215FilOk((cAliasSC7)->C7_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					MaAvalPC(cAliasSC7,1,,.T.)
				EndIf
				a215Skip(cAliasSC7)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSC7)
				dbCloseArea()
				dbSelectArea("SC7")
			Else
				dbClearFilter()
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SC2")) .Or. cFilAnt == cFirst )
			//????????????????????????????????
			//?tualiza os dados acumulados das Ordens de Producao           ?
			//????????????????????????????????
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC2")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("SC2")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SC2->(dbStruct())
				lQuery    := .T.
				cAliasSC2 := "SC2MA215PROC"
				
				cQuery := "SELECT SC2.C2_FILIAL,SC2.C2_DATRF,SC2.C2_QUANT,SC2.C2_QUJE,SC2.C2_PERDA,SC2.C2_PRODUTO,SC2.C2_LOCAL,SC2.C2_TPOP,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC2")+" SC2,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC2.C2_FILIAL='"+xFilial("SC2")+"' AND "
				cQuery += "((SC2.C2_DATRF='"+Dtos(Ctod(""))+"' AND "
				cQuery += "SC2.C2_QUANT-SC2.C2_QUJE-SC2.C2_PERDA>0) OR "
				cQuery += "(SC2.C2_DATRF<>'"+Dtos(Ctod(""))+"')) AND "
				cQuery += "SC2.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC2.C2_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY C2_FILIAL,C2_PRODUTO,C2_LOCAL "
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC2,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
						TcSetField(cAliasSC2,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				lQuery := .F.
				MsSeek(xFilial("SC2"))
			#ENDIF
			If !lBat
				oObj:SetRegua1(SC2->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While ( !Eof() .And. (cAliasSC2)->C2_FILIAL == xFilial("SC2") )
				lContinua := .T.
				If !lQuery 
					If aSC2Sld(cAliasSC2) <= 0 .Or. !A215FilOk(SC2->C2_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					dbSelectArea("SB2")
					dbSetOrder(1)
					If !MsSeek(xFilial("SB2")+(cAliasSC2)->C2_PRODUTO+(cAliasSC2)->C2_LOCAL)
						CriaSB2((cAliasSC2)->C2_PRODUTO,(cAliasSC2)->C2_LOCAL)
					EndIf
					GravaB2Pre("+",IF(Empty((cAliasSC2)->C2_DATRF),aSC2Sld(cAliasSC2),0),(cAliasSC2)->C2_TPOP)
				EndIf
				a215Skip(cAliasSC2)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSC2)
				dbCloseArea()
				dbSelectArea("SC2")
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//????????????????????????????????
		//?tualiza os dados acumulados dos empenhos da OP               ?
		//????????????????????????????????
		If (!Empty(xFilial("SD4")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SD4")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("SD4")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SD4->(dbStruct())
				lQuery    := .T.
				cAliasSD4 := "SD4MA215PROC"
				
				cQuery := "SELECT SD4.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SD4")+" SD4,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SD4.D4_FILIAL='"+xFilial("SD4")+"' AND "
				// MV_NEGESTR - Parametro utilizado para considerar empenho negativo
				If lNegEstr
					cQuery += " SD4.D4_QUANT <> 0 AND "
				Else
					cQuery += "SD4.D4_QUANT > 0 AND "
				EndIf	
				cQuery += "SD4.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SD4.D4_COD AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY D4_FILIAL,D4_COD,D4_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD4,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSD4,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("SD4"))
			#ENDIF
			If !lBat
				oObj:SetRegua1(SD4->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasSD4)->D4_FILIAL == xFilial("SD4")
			nQuantDc :=0
			nQtdDifDc:=0
				lContinua := .T.
				If !lQuery
					If !A215FilOk((cAliasSD4)->D4_COD) .Or. (cAliasSD4)->D4_QUANT <= 0
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
			 		If Localiza((cAliasSD4)->D4_COD)
						#IFDEF TOP
							lQuery := .T.
							aStru     := SDC->(dbStruct())
							lQuery    := .T.
							cAliasSDC := "SDCMA215PROC1"
				
							cQuery := "SELECT * "
							cQuery += "FROM "+RetSqlName("SDC")+" SDC "
							cQuery += "WHERE SDC.DC_FILIAL='"+xFilial("SDC")+"' AND "
							cQuery += "SDC.DC_PRODUTO='"+(cAliasSD4)->D4_COD+"' AND "
							cQuery += "SDC.DC_LOCAL='"+(cAliasSD4)->D4_LOCAL+"' AND "
							cQuery += "SDC.DC_OP='"+(cAliasSD4)->D4_OP+"' AND "
							cQuery += "SDC.DC_TRT='"+(cAliasSD4)->D4_TRT+"' AND "
							cQuery += "SDC.DC_LOTECTL='"+(cAliasSD4)->D4_LOTECTL+"' AND "
							cQuery += "SDC.DC_NUMLOTE='"+(cAliasSD4)->D4_NUMLOTE+"' AND "
							cQuery += "SDC.D_E_L_E_T_=' ' "
							cQuery += "ORDER BY "+SqlOrder(SDC->(IndexKey()))
			
							cQuery := ChangeQuery(cQuery)
				
							dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDC,.T.,.T.)
							For nX := 1 To Len(aStru)
								If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
									TcSetField(cAliasSDC,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
								EndIf
							Next nX
						#ELSE
							dbSelectArea("SDC")
							dbSetOrder(2)
							MsSeek(xFilial("SDC")+(cAliasSD4)->D4_COD+(cAliasSD4)->D4_LOCAL+(cAliasSD4)->D4_OP+(cAliasSD4)->D4_TRT+(cAliasSD4)->D4_LOTECTL+(cAliasSD4)->D4_NUMLOTE)
						#ENDIF
						lAchou := .F.
						While !Eof() .And. (cAliasSDC)->DC_FILIAL == xFilial("SDC") .And.;
											(cAliasSDC)->DC_PRODUTO == (cAliasSD4)->D4_COD .And.;
											(cAliasSDC)->DC_LOCAL == (cAliasSD4)->D4_LOCAL .And.;
											(cAliasSDC)->DC_OP == (cAliasSD4)->D4_OP .And.;
											(cAliasSDC)->DC_TRT == (cAliasSD4)->D4_TRT .And.;
											(cAliasSDC)->DC_LOTECTL == (cAliasSD4)->D4_LOTECTL .And.;
											(cAliasSDC)->DC_NUMLOTE == (cAliasSD4)->D4_NUMLOTE
							//???????????????????????
							//?Atualiza arquivo de empenhos               ?
							//??????????????????????? 
							nQuantDc+=(cAliasSDC)->DC_QUANT
							lAchou := .T.
							GravaEmp((cAliasSDC)->DC_PRODUTO,;
								(cAliasSDC)->DC_LOCAL,;
								(cAliasSDC)->DC_QUANT,;
								(cAliasSDC)->DC_QTSEGUM,;
								(cAliasSDC)->DC_LOTECTL,;
								(cAliasSDC)->DC_NUMLOTE,;
								(cAliasSDC)->DC_LOCALIZ,;
								(cAliasSDC)->DC_NUMSERIE,;
								(cAliasSDC)->DC_OP,;
								(cAliasSDC)->DC_TRT,;
								NIL,;
								NIL,;
								"SC2",;
								NIL,;
								NIL,;
								NIL,;
								.F.,;
								.F.,;
								.T.,;
								.F.,;
								NIL,;
								.T.,;
								.F.)
							a215Skip(cAliasSDC)
						EndDo 
						
						//??????????????????????????????????????
						//?ratamento para verificar se existe diference entre valores da SDC e SD4 ?
						//??????????????????????????????????????
						If nQuantDc < (cAliasSD4)->D4_QUANT 
							nQtdDifDc := (cAliasSD4)->D4_QUANT - nQuantDc
					   		lAchou :=.F. 
						EndIf 

						
						If lQuery
							dbSelectArea(cAliasSDC)
							dbCloseArea()
							dbSelectArea("SDC")
						EndIf
						If !lAchou
							//???????????????????????
							//?Atualiza arquivo de empenhos               ?
							//???????????????????????
							GravaEmp((cAliasSD4)->D4_COD,;
								(cAliasSD4)->D4_LOCAL,;
								IIf(QtdComp((cAliasSD4)->D4_QUANT) <> QtdComp(nQuantDc),nQtdDifDc,(cAliasSD4)->D4_QUANT),;
								(cAliasSD4)->D4_QTSEGUM,;
								(cAliasSD4)->D4_LOTECTL,;
								(cAliasSD4)->D4_NUMLOTE,;
								NIL,;
								NIL,;
								(cAliasSD4)->D4_OP,;
								(cAliasSD4)->D4_TRT,;
								NIL,;
								NIL,;
								"SC2",;
								(cAliasSD4)->D4_OPORIG,;
								(cAliasSD4)->D4_DATA,;
								@aTravas,;
								.F.,;
								.F.,;
								.T.,;
								.F.,;
								NIL,;
								.T.,;
								.F.)
						EndIf
					Else
						//???????????????????????
						//?Atualiza arquivo de empenhos               ?
						//???????????????????????
						GravaEmp((cAliasSD4)->D4_COD,;
							(cAliasSD4)->D4_LOCAL,;
							(cAliasSD4)->D4_QUANT,;
							(cAliasSD4)->D4_QTSEGUM,;
							(cAliasSD4)->D4_LOTECTL,;
							(cAliasSD4)->D4_NUMLOTE,;
							NIL,;
							NIL,;
							(cAliasSD4)->D4_OP,;
							(cAliasSD4)->D4_TRT,;
							NIL,;
							NIL,;
							"SC2",;
							(cAliasSD4)->D4_OPORIG,;
							(cAliasSD4)->D4_DATA,;
							NIL,;
							.F.,;
							.F.,;
							.T.,;
							.F.,;
							NIL,;
							.T.,;
							.F.)
					EndIf
				EndIf
				a215Skip(cAliasSD4)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSD4)
				dbCloseArea()
				dbSelectArea("SD4")
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//???????????????????????????????
		//?Varre o SDD e refaz os bloqueios existentes                ?
		//???????????????????????????????
		If (!Empty(xFilial("SDD")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SDD")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SDD")
			dbSetOrder(1)
			MsSeek(xFilial())
			If !lBat
				oObj:SetRegua1(SDD->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. DD_FILIAL == xFilial()
				If DD_SALDO > 0 .And. A215FilOk(SDD->DD_PRODUTO)
					Reclock("SDD",.F.)
					Replace DD_QUANT With DD_SALDO
					MsUnlock()
					cSeekSDC := xFilial("SDC")+SDD->DD_PRODUTO+SDD->DD_LOCAL+"SDD"+;
						SDD->DD_DOC+Criavar("DC_ITEM")+Criavar("DC_SEQ")+;
						SDD->DD_LOTECTL+SDD->DD_NUMLOTE+If(!Empty(SDD->DD_LOCALIZ),SDD->DD_LOCALIZ,"")+;
						If(!Empty(SDD->DD_NUMSERI),SDD->DD_NUMSERI,"")
					SDC->(dbSetOrder(1))
					aTravas  := {}
					If Localiza(SDD->DD_PRODUTO) .And. SDC->(MsSeek(cSeekSDC))
						dbSelectArea("SDC")
						While !Eof() .And. DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+;
								DC_PEDIDO+DC_ITEM+DC_SEQ+DC_LOTECTL+DC_NUMLOTE+;
								If(!Empty(SDD->DD_LOCALIZ),SDC->DC_LOCALIZ,"")+If(!Empty(SDD->DD_NUMSERI),SDC->DC_NUMSERI,"") == cSeekSDC
							//???????????????????????
							//?Atualiza arquivo de empenhos               ?
							//???????????????????????
							GravaEmp(SDC->DC_PRODUTO,;
								SDC->DC_LOCAL,;
								SDC->DC_QUANT,;
								SDC->DC_QTSEGUM,;
								SDC->DC_LOTECTL,;
								SDC->DC_NUMLOTE,;
								SDC->DC_LOCALIZ,;
								SDC->DC_NUMSERI,;
								Nil,;
								Nil,;
								SDC->DC_PEDIDO,;
								Nil,;
								"SDD",;
								Nil,;
								Nil,;
								Nil,;
								.F.,;
								.F.,;
								.T.,;
								.F.,;
								.T.,;
								.T.,;
								.F.)
							a215Skip('SDC')
						EndDo
					Else
						ProcSDD(.F.)
					EndIf
				EndIf		
				a215Skip('SDD')
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SCQ")) .Or. cFilAnt == cFirst )
			//????????????????????????????????
			//?Corre SCQ para Atualizar B2_QEMP  em Produtos SB2.           ?
			//????????????????????????????????
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SCQ")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SCQ")
			#IFDEF TOP
				cFilSCQ := 'CQ_QTDISP > 0'
				MsFilter(cFIlSCQ)
			#ENDIF
			dbSetOrder(1)
			MsSeek(xFilial())
			If !lBat
				oObj:SetRegua1(SCQ->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. CQ_FILIAL == xFilial()
				//????????????????????????????
				//?Atualizar Qtde Empenhada  em Produtos SB2.          ?
				//????????????????????????????
				If SCQ->CQ_QTDISP > 0 .And. Empty(SCQ->CQ_NUMREQ) .And. A215FilOk(SCQ->CQ_PRODUTO)
					dbSelectArea("SB2")
					cSeek := xFilial()+SCQ->CQ_PRODUTO+SCQ->CQ_LOCAL
					MsSeek(cSeek)
					If Eof()
						CriaSB2(SCQ->CQ_PRODUTO,SCQ->CQ_LOCAL)
					Else
						RecLock("SB2",.F.)
					EndIf
					Replace B2_QEMPSA     With B2_QEMPSA + (SCQ->CQ_QTDISP)
					MsUnLock()
				EndIf
				a215Skip('SCQ')
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			RETINDEX("SCQ")
			dbClearFilter()
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SDA")) .Or. cFilAnt == cFirst )
			//????????????????????????????????
			//?A partir do SDA atualiza B2_QACLASS e B8_QACLASS             ?
			//????????????????????????????????
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SDA")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SDA")
			#IFDEF TOP
				cFilSDA := 'DA_SALDO > 0'
				MsFilter(cFilSDA)
			#ENDIF
			dbSetOrder(1)
			MsSeek(xFilial())
			If !lBat
				oObj:SetRegua1(SDA->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. DA_FILIAL == xFilial()
				//????????????????????????????
				//?Atualizar Qtde Prevista de Produtos SB2.            ?
				//????????????????????????????
				If DA_SALDO > 0 .And. A215FilOk(SDA->DA_PRODUTO)
					dbSelectArea("SB2")
					cSeek := xFilial()+SDA->DA_PRODUTO+SDA->DA_LOCAL
					MsSeek(cSeek)
					If Eof()
						CriaSB2(SDA->DA_PRODUTO,SDA->DA_LOCAL)
					EndIf
					Reclock("SB2",.F.)
					Replace B2_QACLASS With B2_QACLASS + SDA->DA_SALDO
					MsUnlock()
					//?????????????????????????????
					//?Caso use rastreabilidade, GRAVA a quantidade do SDA   ?
					//?no SB8 para que o Saldo por Sub-Lote fique bloqueado  ?
					//?????????????????????????????
					If Rastro(SDA->DA_PRODUTO)
						dbSelectArea("SB8")
						aAreaSB8:=GetArea()
						dbSetOrder(3)
						If Rastro(SDA->DA_PRODUTO,"S")
							cSeek:=xFilial()+SDA->DA_PRODUTO+SDA->DA_LOCAL+SDA->DA_LOTECTL+SDA->DA_NUMLOTE
							cCompara:="B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+B8_NUMLOTE"
						Else
							cSeek:=xFilial()+SDA->DA_PRODUTO+SDA->DA_LOCAL+SDA->DA_LOTECTL
							cCompara:="B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL"
						EndIf
						MsSeek(cSeek)
						nEmpenho:=SDA->DA_SALDO
						nEmpenh2:=SDA->DA_QTSEGUM  
						Do While !Eof() .And. nEmpenho > 0 .And. cSeek == &(cCompara)
							nBaixaEmp:=Min(nEmpenho,SB8Saldo(Nil,.T.,Nil,Nil,Nil,lEmpPrev))
							nBaixaEm2:=Min(nEmpenh2,SB8Saldo(Nil,.T.,Nil,.T.,Nil,lEmpPrev))
							RecLock("SB8",.F.)
							Replace B8_QACLASS With B8_QACLASS + nBaixaEmp
							Replace B8_QACLAS2 With B8_QACLAS2 + nBaixaEm2						
							nEmpenho -= nBaixaEmp   
							nEmpenh2 -= nBaixaEm2 
							MsUnlock()
							a215Skip()
						EndDo
						RestArea(aAreaSB8)
					EndIf
				EndIf
				a215Skip('SDA')
			 	If !lBat
			 		oObj:IncRegua1(cMensagem)
			 	EndIf	
			EndDo
			RETINDEX("SDA")
			dbClearFilter()
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SD1")) .Or. cFilAnt == cFirst )
			//????????????????????????????????
			//?tualiza os dados acumulados da Pre-Nota de Entrada           ?
			//????????????????????????????????
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SD1")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SD1")
			dbSetOrder(1)
			#IFDEF TOP
			If TcSrvType()<>"AS/400"
				cAliasSD1 := "SD1MA215PROC"

				cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
				cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
				cQuery += "FROM "+RetSqlName("SD1")+" SD1 "
				cQuery += "WHERE SD1.D1_FILIAL='"+xFilial("SD1")+"' AND "
				cQuery += "SD1.D1_IDENTB6<>'"+Space(Len(SD1->D1_IDENTB6))+"' AND "
				cQuery += "( SD1.D1_QTDEDEV > 0 OR SD1.D1_VALDEV > 0 ) AND "
				cQuery += "SD1.D_E_L_E_T_=' ' "
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD1)
				nMax := (cAliasSD1)->MAXRECNO
				nMin := (cAliasSD1)->MINRECNO
				dbCloseArea()
				dbSelectArea("SD1")
				cQuery := "UPDATE "
				cQuery += RetSqlName("SD1")+" "
				cQuery += "SET D1_QTDEDEV = 0, D1_VALDEV = 0 "
				cQuery += "WHERE D1_FILIAL='"+xFilial("SD1")+"' AND "
				cQuery += "D1_IDENTB6<>'"+Space(Len(SD1->D1_IDENTB6))+"' AND "
				cQuery += "( D1_QTDEDEV > 0 OR D1_VALDEV > 0 ) AND "
				cQuery += "D_E_L_E_T_=' ' AND "
				For nX := nMin To nMax+4096 STEP 4096
					cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
					TcSqlExec(cQuery+cChave)
				Next nX
				//?????????????????????????????
				//? tabela eh fechada para restaurar o buffer da aplicacao?
				//?????????????????????????????
				dbSelectArea("SD1")
				dbCloseArea()
				ChkFile("SD1",.T.)

				aStru     := SD1->(dbStruct())
				lQuery    := .T.
				cAliasSD1 := "SD1MA215PROC"
				
				cQuery := "SELECT SD1.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SD1")+" SD1,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SD1.D1_FILIAL='"+xFilial("SD1")+"' AND "
				cQuery += "SD1.D1_TES = '"+Space(Len(SD1->D1_TES))+"' AND "
				#IFDEF SHELL
					cQuery += "SD1.D1_CANCEL = 'S' AND "
				#ENDIF
				cQuery += "SD1.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SD1.D1_COD AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				
				If ExistBlock("MA215SD1")
					cQuery := ExecBlock("MA215SD1",.F.,.F.,cQuery)
				EndIf
				
				cQuery += "ORDER BY D1_FILIAL,D1_COD,D1_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD1,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSD1,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			Else
			#ENDIF
				MsSeek(xFilial("SD1"))
			#IFDEF TOP
			EndIf
			#ENDIF
				
			If !lBat
				oObj:SetRegua1(SD1->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasSD1)->D1_FILIAL == xFilial("SD1")
				lContinua := .T.
				If !lQuery
					If !Empty((cAliasSD1)->D1_IDENTB6) .And. ((cAliasSD1)->D1_QTDEDEV > 0 .Or. (cAliasSD1)->D1_VALDEV > 0)
						RecLock(cAliasSD1,.F.)
						(cAliasSD1)->D1_QTDEDEV := 0
						(cAliasSD1)->D1_VALDEV  := 0
						MsUnLock()
					EndIf				
					#IFDEF SHELL
						If D1_CANCEL == "S"
							lContinua := .F.
						EndIf
					#ENDIF
					//????????????????????????????
					//?Atualizar Qtde Nao Classificada  em Saldos SB2.     ?
					//????????????????????????????
					If !Empty((cAliasSD1)->D1_TES) .Or. !A215FilOk((cAliasSD1)->D1_COD)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					dbSelectArea("SB2")
					dbSetOrder(1)
					If !MsSeek(xFilial("SB2")+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_LOCAL)
						CriaSB2((cAliasSD1)->D1_COD,(cAliasSD1)->D1_LOCAL)
					EndIf
					RecLock("SB2",.F.)
					Replace B2_NAOCLAS With B2_NAOCLAS + (cAliasSD1)->D1_QUANT
					MsUnLock()
				EndIf
				a215Skip(cAliasSD1)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSD1)
				dbCloseArea()
				dbSelectArea("SD1")
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SC0")) .Or. cFilAnt == cFirst )
			//????????????????????????????????
			//?tualiza os dados acumulados das Reserva de Faturamento       ?
			//????????????????????????????????
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC0")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SC0")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SC0->(dbStruct())
				lQuery    := .T.
				cAliasSC0 := "SC0MA215PROC"
				
				cQuery := "SELECT SC0.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC0")+" SC0,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC0.C0_FILIAL='"+xFilial("SC0")+"' AND "
				If !HasTemplate("OTC")
				   cQuery += "SC0.C0_QUANT > 0 AND "
				Endif   
				cQuery += "SC0.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC0.C0_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY C0_FILIAL,C0_PRODUTO,C0_LOCAL "
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC0,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSC0,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("SC0"))
			#ENDIF
			If !lBat
				oObj:SetRegua1(SC0->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasSC0)->C0_FILIAL == xFilial("SC0")
				lContinua := .T.
				If !lQuery
					If !( (cAliasSC0)->C0_QUANT > 0 ) .And. A215FilOk((cAliasSC0)->C0_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				
				If lContinua   
					Ma215Res(cAliasSC0, (cAliasSC0)->C0_QUANT, (cAliasSC0)->C0_QTDPED)
				EndIf
				
				a215Skip(cAliasSC0)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			
			If lQuery
				dbSelectArea(cAliasSC0)
				dbCloseArea()
				dbSelectArea("SC0")
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If ( !Empty(xFilial("SC6")) .Or. cFilAnt == cFirst )
			//????????????????????????????????
			//?tualiza os dados acumulados do PV e seus anexos              ?
			//????????????????????????????????
			lQuery := .F.
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC6")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SC6")
			dbSetOrder(1)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
				cAliasSC6 := "SC6MA215PROC"
				
				cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
				cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
				cQuery += "FROM "+RetSqlName("SC6")+" SC6 "
				cQuery += "WHERE SC6.C6_FILIAL='"+xFilial("SC6")+"' AND "
				cQuery += "C6_BLQ <> 'S"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "C6_BLQ <> 'R"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "(C6_QTDVEN > C6_QTDENT OR (C6_QTDVEN <= C6_QTDENT AND C6_ENTREG>='"+DTOS(dDataBase-31)+"')) AND "
				cQuery += "SC6.D_E_L_E_T_=' ' "
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6)
				nMax := (cAliasSC6)->MAXRECNO
				nMin := (cAliasSC6)->MINRECNO
				dbCloseArea()
				dbSelectArea("SC6")
				cQuery := "UPDATE "
				cQuery += RetSqlName("SC6")+" "
				cQuery += "SET C6_QTDEMP = 0, C6_QTDENT = 0, C6_QTDEMP2 = 0, C6_QTDENT2 = 0 "
				cQuery += "WHERE C6_FILIAL='"+xFilial("SC6")+"' AND "
				cQuery += "C6_BLQ <> 'S"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "C6_BLQ <> 'R"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "(C6_QTDVEN > C6_QTDENT OR (C6_QTDVEN <= C6_QTDENT AND C6_ENTREG>='"+Dtos(dDataBase-31)+"')) AND "
				cQuery += "D_E_L_E_T_=' ' AND "
				For nX := nMin To nMax+4096 STEP 4096
					cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
					TcSqlExec(cQuery+cChave)
				Next nX
				//?????????????????????????????
				//? tabela eh fechada para restaurar o buffer da aplicacao?
				//?????????????????????????????
				dbSelectArea("SC6")
				dbCloseArea()
				ChkFile("SC6",.T.)
			
				aStru     := SC6->(dbStruct())
				lQuery    := .T.
				cAliasSC6 := "SC6MA215PROC"
			
				cQuery := "SELECT SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_ITEM,SC6.C6_PRODUTO,SC6.C6_BLQ,"
				cQuery += "SC6.C6_NUMOS,SC6.C6_QTDEMP,SC6.C6_NUMOSFA,"
				cQuery += "SC6.C6_QTDENT,SC6.C6_RESERVA,SC6.C6_TES,SC6.C6_NUMLOTE,"
				cQuery += "SC6.C6_CLI,SC6.C6_LOCAL,SC6.C6_LOTECTL,SC6.C6_LOJA,SC6.C6_QTDVEN,"
				cQuery += "SC6.C6_OP,SC6.C6_NUMSERI,SC6.C6_LOCALIZ,SC6.C6_QTDRESE,SC6.C6_DTVALID,"
				cQuery += "SC6.C6_QTDLIB,SC6.C6_PRCVEN,"
				cQuery += "SC6.C6_PRUNIT,SC6.C6_VALDESC,"
				cQuery += "SC6.C6_VALOR,SC6.C6_UNSVEN,SC6.C6_ENTREG,SC6.C6_DATFAT, "
				cQuery += "SC6.C6_DESCONT,SC6.C6_QTDLIB2,"
				cQuery += "SC6.R_E_C_N_O_ SC6RECNO,SB1.B1_FILIAL "
				
				If SC6->(FieldPos("C6_QTDEMP2")) > 0
					cQuery += ",SC6.C6_QTDEMP2 "
				Endif                       
				
				If SC6->(FieldPos("C6_QTDENT2")) > 0
					cQuery += ",SC6.C6_QTDENT2 "
				Endif                       
				If cPaisLoc <> "BRA"
					cQuery += ",SC6.C6_GERANF,SC6.C6_CONTRAT,SC6.C6_ITEMCON "
				EndIf
				cQuery += "FROM "+RetSqlName("SC6")+" SC6, "+RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC6.C6_FILIAL='" + xFilial( "SC6" ) + "' AND "
				cQuery += "SC6.C6_BLQ <> 'S ' AND SC6.C6_BLQ <> 'R ' AND "
				cQuery += "(SC6.C6_QTDVEN > SC6.C6_QTDENT OR (SC6.C6_QTDVEN <= SC6.C6_QTDENT AND SC6.C6_ENTREG>='"+DTOS(dDataBase-31)+"')) AND "
				cQuery += "SC6.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='" + xFilial( "SB1" ) + "' AND "
				cQuery += "SB1.B1_COD=SC6.C6_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY C6_FILIAL,C6_NUM,C6_ITEM,C6_PRODUTO "
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
						TcSetField(cAliasSC6,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
				Else
			#ENDIF
					MsSeek(xFilial("SC6"))
			#IFDEF TOP
				EndIf
			#ENDIF
			lLiberOk  := .T.
			lResidOk  := .T.
			lFaturOk  := .F.
			If !lBat
				oObj:SetRegua1(SC6->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !(cAliasSC6)->( Eof() ) .And. (cAliasSC6)->C6_FILIAL == xFilial("SC6")
				lContinua := .T.
				cQuebra   := (cAliasSC6)->C6_NUM
				BEGIN TRANSACTION
				If !lQuery 
					If !A215FilOk(SC6->C6_PRODUTO) .And. AllTrim(SC6->C6_BLQ)$"RS"
						lContinua := .F.
					EndIf
					If lContinua 
						RecLock("SC6",.F.)
						SC6->C6_QTDEMP  := 0
						SC6->C6_QTDENT  := 0
						SC6->C6_QTDEMP2 := 0
						SC6->C6_QTDENT2 := 0										
						MsUnlock()
					EndIf
				EndIf
				If lContinua
					//????????????????????????????????
					//?tualiza os acumulados dos pedidos de venda entregue          ?
					//????????????????????????????????
					If cAliasSC6<>"SC6"
						lSC6Ok := .F.
					Else
						lSC6Ok := .T.
					EndIf
					dbSelectArea("SD2")
					dbSetOrder(8)
					#IFDEF TOP
						If TcSrvType()<>"AS/400"
							aStru     := SD2->(dbStruct())
							lQuery    := .T.
							cAliasSD2 := "SD2MA215PROC1"
					
							cQuery := "SELECT D2_FILIAL,D2_PEDIDO,D2_ITEMPV,D2_QUANT,D2_QTSEGUM,D2_COD,D2_DOC,D2_SERIE,D2_EMISSAO,D2_REMITO "
							cQuery += "FROM "+RetSqlName("SD2")+" SD2 "
							
							If !Empty(xFilial("SC6"))
								cQuery += "WHERE SD2.D2_FILIAL='"+xFilial("SD2")+"' AND "
							Else
								cQuery += "WHERE "
							EndIf
							
							cQuery += "SD2.D2_PEDIDO = '"+(cAliasSC6)->C6_NUM+"' AND "
							cQuery += "SD2.D2_ITEMPV = '"+(cAliasSC6)->C6_ITEM+"' AND "
							cQuery += "SD2.D2_COD = '"+(cAliasSC6)->C6_PRODUTO+"' AND "
							cQuery += "SD2.D_E_L_E_T_=' ' "	
							If ExistBlock("MA215SD2")
								cQuery := ExecBlock("MA215SD2",.F.,.F.,cQuery)
							EndIf
						
							cQuery += "ORDER BY "+SqlOrder(SD2->(IndexKey()))
							cQuery := ChangeQuery(cQuery)
				
							dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD2,.T.,.T.)
							For nX := 1 To Len(aStru)
								If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
									TcSetField(cAliasSD2,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
								EndIf
							Next nX	
						Else
					#ENDIF
							MsSeek(IIf(!Empty(xFilial("SC6")),xFilial("SD2"),xFilial("SC6"))+(cAliasSC6)->C6_NUM+(cAliasSC6)->C6_ITEM)
					#IFDEF TOP
						EndIf
					#ENDIF
					While !Eof() .And. (IIF(!Empty(xFilial("SC6")), xFilial("SD2") == (cAliasSD2)->D2_FILIAL, .T.)) .And.;
						(cAliasSC6)->C6_NUM == (cAliasSD2)->D2_PEDIDO .And.	(cAliasSC6)->C6_ITEM == (cAliasSD2)->D2_ITEMPV
						If (cAliasSD2)->D2_COD == (cAliasSC6)->C6_PRODUTO
							If lQuery
								SC6->(MsGoto((cAliasSC6)->SC6RECNO))
								lSC6Ok := .T.
							EndIf
							MaAvalSC6("SC6",5,"SC5",.F.,.F.,@lLiberOk,@lResidOk,@lFaturOk,.T.,,cAliasSD2)
						EndIf					
						dbSelectArea(cAliasSD2)
						dbSkip()
					EndDo
					If lQuery
						dbSelectArea(cAliasSD2)
						dbCloseArea()
						dbSelectArea("SD2")
					EndIf							
	
					If lQuery
						SC6->(MsGoto((cAliasSC6)->SC6RECNO))
						lSC6Ok := .T.
					EndIf          
					
					//?????????????????????????????????????????????????
					//?Passa as variaveis lLiberok, lResidOk e lFaturOk sem referencia para nao modificar o conteudo ?
					//?????????????????????????????????????????????????
					
					If !Empty((cAliasSC6)->C6_RESERVA) .And.(cAliasSC6)->C6_QTDRESE > 0
						SC0->(dbSetOrder(1))
						If SC0->(MsSeek(xFilial("SC0")+(cAliasSC6)->C6_RESERVA+(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_LOCAL))
							Ma215Res("SC0",(cAliasSC6)->C6_QTDRESE)
						Endif	
					Endif					
					
					MaAvalSC6(IIf(lSC6Ok,"SC6",cAliasSC6),1,"SC5",.F.,.F.,lLiberOk,lResidOk,lFaturOk,.T.)
					
					dbSelectArea("SC9")
					dbSetOrder(1)
					#IFDEF TOP
						If TcSrvType()<>"AS/400"
						aStru     := SC9->(dbStruct())
						lQuery    := .T.
						cAliasSC9 := "SC9MA215PROC1"
				
						cQuery := "SELECT * "
						cQuery += "FROM "+RetSqlName("SC9")+" SC9 "
						cQuery += "WHERE SC9.C9_FILIAL='"+xFilial("SC9")+"' AND "
						cQuery += "SC9.C9_PEDIDO = '"+(cAliasSC6)->C6_NUM+"' AND "
						cQuery += "SC9.C9_ITEM = '"+(cAliasSC6)->C6_ITEM+"' AND "
						cQuery += "SC9.C9_PRODUTO = '"+(cAliasSC6)->C6_PRODUTO+"' AND "
						cQuery += "SC9.C9_NFISCAL = '"+Space(Len(SC9->C9_NFISCAL))+"' AND "
						cQuery += "SC9.C9_REMITO = '"+Space(Len(SC9->C9_REMITO))+"' AND "
						cQuery += "SC9.D_E_L_E_T_=' ' "	
						cQuery += "ORDER BY "+SqlOrder(SC9->(IndexKey()))
						cQuery := ChangeQuery(cQuery)
				
						dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC9,.T.,.T.)
						For nX := 1 To Len(aStru)
							If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
								TcSetField(cAliasSC9,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
							EndIf
						Next nX	
						Else
					#ENDIF
							MsSeek(xFilial("SC9")+(cAliasSC6)->C6_NUM+(cAliasSC6)->C6_ITEM)
					#IFDEF TOP
						EndIf
					#ENDIF
					While !Eof() .And. xFilial("SC9") == (cAliasSC9)->C9_FILIAL .And.;
						(cAliasSC6)->C6_NUM == (cAliasSC9)->C9_PEDIDO .And. ;
						(cAliasSC6)->C6_ITEM == (cAliasSC9)->C9_ITEM
							
						If Empty((cAliasSC9)->C9_NFISCAL) .And. Empty((cAliasSC9)->C9_REMITO)		
							If  (cAliasSC9)->C9_PRODUTO == (cAliasSC6)->C6_PRODUTO
								aSaldos := {}
								If Localiza((cAliasSC9)->C9_PRODUTO) .And. ;
									(!IntDL((cAliasSC9)->C9_PRODUTO) .Or. !((cAliasSC9)->C9_BLWMS$'01;02;03'))
									cAliasSDC := "SDC"
									dbSelectArea("SDC")
									dbSetOrder(1)
									cSeekSDC := xFilial("SDC")+;
												(cAliasSC9)->C9_PRODUTO+;
												(cAliasSC9)->C9_LOCAL+;
												"SC6"+;
												(cAliasSC9)->C9_PEDIDO+;
												(cAliasSC9)->C9_ITEM
									#IFDEF TOP
										If TcSrvType()<>"AS/400"
										aStru     := SDC->(dbStruct())
										lQuery    := .T.
										cAliasSDC := "SDCMA215PROC2"
															
										cQuery := "SELECT * "
										cQuery += "FROM "+RetSqlName("SDC")+" SDC "
										cQuery += "WHERE SDC.DC_FILIAL='"+xFilial("SDC")+"' AND "
										cQuery += "SDC.DC_PRODUTO = '"+(cAliasSC9)->C9_PRODUTO+"' AND "
										cQuery += "SDC.DC_LOCAL = '"+(cAliasSC9)->C9_LOCAL+"' AND "
										cQuery += "SDC.DC_ORIGEM = 'SC6' AND "
										cQuery += "SDC.DC_PEDIDO = '"+(cAliasSC9)->C9_PEDIDO+"' AND "
										cQuery += "SDC.DC_ITEM = '"+(cAliasSC9)->C9_ITEM+"' AND "
										cQuery += "SDC.DC_SEQ = '"+(cAliasSC9)->C9_SEQUEN+"' AND "
										cQuery += "SDC.D_E_L_E_T_=' ' "	
										cQuery += "ORDER BY "+SqlOrder(SDC->(IndexKey()))
										cQuery := ChangeQuery(cQuery)
								
										dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDC,.T.,.T.)
										For nX := 1 To Len(aStru)
											If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
												TcSetField(cAliasSDC,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
											EndIf
										Next nX	
										Else
									#ENDIF
											MsSeek(cSeekSDC)
									#IFDEF TOP
										EndIf
									#ENDIF
									While !Eof() .And. DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+DC_PEDIDO+DC_ITEM == cSeekSDC
										//???????????????????????
										//?Atualiza arquivo de empenhos               ?
										//???????????????????????
										
										If (cAliasSDC)->DC_SEQ == (cAliasSC9)->C9_SEQUEN
	
											aadd(aSaldos,{	(cAliasSDC)->DC_LOTECTL,;
															(cAliasSDC)->DC_NUMLOTE,;
															(cAliasSDC)->DC_LOCALIZ,;
															(cAliasSDC)->DC_NUMSERI,;
															(cAliasSDC)->DC_QUANT,;
															If( Empty( (cAliasSDC)->DC_QTSEGUM ), ConvUm((cAliasSDC)->DC_PRODUTO,(cAliasSDC)->DC_QUANT,0,2),(cAliasSDC)->DC_QTSEGUM ),;
															(cAliasSC9)->C9_DTVALID,;
															"",;
															"",;
															"",;
															(cAliasSDC)->DC_LOCAL})
	
															
										EndIf
										dbSelectArea(cAliasSDC)
										dbSkip()
									EndDo
									If lQuery
										dbSelectArea(cAliasSDC)
										dbCloseArea()
										dbSelectArea("SDC")
									EndIf						
								Else
									nQtdLib2 := If(Empty((cAliasSC9)->C9_QTDLIB2),ConvUm((cAliasSC9)->C9_PRODUTO,(cAliasSC9)->C9_QTDLIB,0,2),(cAliasSC9)->C9_QTDLIB2)
									aSaldos := {{ "","","","",(cAliasSC9)->C9_QTDLIB,nQtdLib2,	Ctod(""),"","","",(cAliasSC9)->C9_LOCAL}}
								EndIf
								//????????????????????????????????
								//?tualiza os acumulados da liberacao do pedido de venda        ?
								//????????????????????????????????
	
								MaAvalSC9(cAliasSC9,1,aSaldos,,.T.)
							EndIf
						EndIf
						dbSelectArea(cAliasSC9)
						dbSkip()
					EndDo    
					
					//????????????????????????????????
					//?tualiza os acumulados do item do pedido de venda             ?
					//????????????????????????????????
					If lQuery
						SC6->(MsGoto((cAliasSC6)->SC6RECNO))
						lSC6Ok := .T.
					EndIf		
			
					//?????????????????????????????????????
					//?Verificacao dos acumulados do SC5                                      ?
					//?????????????????????????????????????
					If ( SC6->C6_QTDVEN > (SC6->C6_QTDEMP+SC6->C6_QTDENT) .And. AllTrim(SC6->C6_BLQ)<>"R")
						lLiberOk := .F.
					EndIf
					If (! "R" $ SC6->C6_BLQ )
						lResidOk := .F.
					EndIf
					If ( SC6->C6_QTDVEN > SC6->C6_QTDENT .And. AllTrim(SC6->C6_BLQ)<>"R")
						lFaturOk := .T.
					EndIf
					
					If lQuery
						dbSelectArea(cAliasSC9)
						dbCloseArea()
						dbSelectArea("SC9")
					EndIf
				EndIf
				dbSelectArea(cAliasSC6)
				dbSkip()
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
				If cQuebra <> (cAliasSC6)->C6_NUM
					dbSelectArea("SC5")
					dbSetOrder(1)
					If MsSeek(xFilial("SC5")+cQuebra)
						MaAvalSC5("SC5",1,.F.,.F.,@lLiberOk,@lResidOk,@lFaturOk,.T.)
					EndIf
					lLiberOk  := .T.
					lResidOk  := .T.
					lFaturOk  := .F.
				EndIf
				End Transaction
			EndDo
			If lQuery
				dbSelectArea(cAliasSC6)
				dbCloseArea()
				dbSelectArea("SC6")
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//????????????????????????????????
		//?tualiza os dados acumulados do PODER de 3 e EM 3.            ?
		//????????????????????????????????
		If ( !Empty(xFilial("SB6")) .Or. cFilAnt == cFirst )	
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SB6")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SB6")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SB6->(dbStruct())
				lQuery    := .T.
				cAliasSB6 := "SB6MA215PROC"
			
				cQuery := "SELECT SB6.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SB6")+" SB6, "
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SB6.B6_FILIAL='"+xFilial("SB6")+"' AND "
				cQuery += "SB6.B6_QUANT > 0 AND "
				cQuery += "SB6.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "	
				cQuery += "SB1.B1_COD=SB6.B6_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY B6_FILIAL,B6_PRODUTO,B6_LOCAL "
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB6,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSB6,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("SB6"))
			#ENDIF
			If !lBat
				oObj:SetRegua1(SB6->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. xFilial("SB6") == (cAliasSB6)->B6_FILIAL
				lContinua := .T.
				cLocOriSB6:= ""
				If !lQuery
					If !A215FilOk((cAliasSB6)->B6_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				
				dbSelectArea("SF4")
				dbSetOrder(1)
				MsSeek(xFilial("SF4")+(cAliasSB6)->B6_TES)
					
				//????????????????????????????????
				//?uando for devolucao de material que estava em terceiros,     ?
				//|posicionar sempre no local de origem da remessa. 			 |
				//????????????????????????????????
				If SF4->F4_PODER3 == "D" .And. (cAliasSB6)->B6_TES < "501"
					nRegSB6 := SB6->(RecNo())
					aAreaSB6:= SB6->(GetArea())
					dbSelectArea("SB6")
					dbSetOrder(3)
					If SB6->(MsSeek(xFilial("SB6")+(cAliasSB6)->B6_IDENT+(cAliasSB6)->B6_PRODUTO+"R"))
						cLocOriSB6 := SB6->B6_LOCAL //Local de Origem
					EndIf	
					RestArea(aAreaSB6)
					SB6->(MsGoto(nRegSB6))
				EndIf	

				dbSelectArea("SB2")
				dbSetOrder(1)
				If MsSeek(xFilial("SB2")+(cAliasSB6)->B6_PRODUTO+IIf(Empty(cLocOriSB6),(cAliasSB6)->B6_LOCAL,cLocOriSB6))
					RecLock("SB2",.F.)
				Else
					CriaSB2((cAliasSB6)->B6_PRODUTO,(cAliasSB6)->B6_LOCAL)
				EndIf
	            RecLock("SB2")
	
			    cEstoque := (cAliasSB6)->B6_ESTOQUE
	
	 	       //????????????????????????????????
	 	       //?tualiza os Campos B2_QTER, B2_QNPT, B2_QTNP.                 ?
		       //????????????????????????????????
	            
	            IF SF4->F4_CODIGO <= "500"   // Documentos de Entrada.
	               If ( SF4->F4_PODER3 $ "DR" )
	                  If ( SF4->F4_PODER3 == "D" ) // Devolucoes.
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
					        Replace B2_QTER with B2_QTER - (cAliasSB6)->B6_QUANT
				         Else
					        Replace B2_QNPT With B2_QNPT - (cAliasSB6)->B6_QUANT
				         EndIf
			          Else  // Remessas.
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
					        Replace B2_QTER With B2_QTER + (cAliasSB6)->B6_QUANT
				         Else
					        Replace B2_QTNP With B2_QTNP + (cAliasSB6)->B6_QUANT
				         EndIf
			          EndIf
		           EndIf
	   		    Else  // Doucmentos de Saida.
		           If ( SF4->F4_PODER3 $ "DR" )
			          If ( SF4->F4_PODER3 == "D" )  // Devolucoes.
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
				            Replace B2_QTER With B2_QTER - (cAliasSB6)->B6_QUANT
				         Else
				            Replace B2_QTNP With B2_QTNP - (cAliasSB6)->B6_QUANT
				         EndIf
			          Else  //Remessas
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
					        Replace B2_QTER With B2_QTER + (cAliasSB6)->B6_QUANT
				         Else
					        Replace B2_QNPT With B2_QNPT + (cAliasSB6)->B6_QUANT
				         EndIf
			          EndIf
		           EndIf
			    Endif  
	
	            SB2->(MsUnLock())
				a215Skip(cAliasSB6)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSB6)
				dbCloseArea()
				dbSelectArea("SB6")
			EndIf
		EndIf
		If !lBat
			oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//????????????????????????????????
		//?tualiza os dados acumulados dos empenhos do SIGAPMS          ?
		//????????????????????????????????
		If (!Empty(xFilial("AFJ")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("AFJ")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("AFJ")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := AFJ->(dbStruct())
				lQuery    := .T.
				cAliasAFJ := "AFJMA215PROC"
				
				cQuery := "SELECT AFJ.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("AFJ")+" AFJ,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE AFJ.AFJ_FILIAL='"+xFilial("AFJ")+"' AND "
   			If FieldPos("AFJ_EMPEST") > 0
					cQuery += "AFJ.AFJ_QEMP > (AFJ.AFJ_QATU + AFJ.AFJ_EMPEST) AND "
				Else
					cQuery += "AFJ.AFJ_QEMP > AFJ.AFJ_QATU AND "
				EndIf					
				cQuery += "AFJ.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=AFJ.AFJ_COD AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += "ORDER BY AFJ_FILIAL,AFJ_COD,AFJ_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasAFJ,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasAFJ,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("AFJ"))
			#ENDIF
			If !lBat
				oObj:SetRegua1(AFJ->(LastRec()))
				oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasAFJ)->AFJ_FILIAL == xFilial("AFJ")
				lContinua := .T.
				If !lQuery
					If !A215FilOk((cAliasAFJ)->AFJ_COD) .Or. ((cAliasAFJ)->AFJ_QEMP <= (cAliasAFJ)->AFJ_QATU .And. (AFJ->(FieldPos("AFJ_QEMPPR")) > 0 .And. Empty(AFJ->AFJ_QEMPPR)))
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					//???????????????????????
					//?Atualiza arquivo de empenhos               ?
					//???????????????????????
					PmsAtuEmp(	(cAliasAFJ)->AFJ_PROJET,;
								(cAliasAFJ)->AFJ_TAREFA,;
								(cAliasAFJ)->AFJ_COD,;
								(cAliasAFJ)->AFJ_LOCAL,;
								(cAliasAFJ)->AFJ_QEMP-((cAliasAFJ)->AFJ_QATU + IIf(FieldPos("AFJ_EMPEST") > 0,(cAliasAFJ)->AFJ_EMPEST,0)),;
								"+",;
								.F.,;
								(cAliasAFJ)->AFJ_QEMP2-((cAliasAFJ)->AFJ_QATU2 + IIf(FieldPos("AFJ_EMPES2") > 0,(cAliasAFJ)->AFJ_EMPES2,0)),;
								(cAliasAFJ)->AFJ_TRT)
					If AFJ->(FieldPos("AFJ_QEMPPR")) > 0
						PmsAtuEmp(	(cAliasAFJ)->AFJ_PROJET,;
									(cAliasAFJ)->AFJ_TAREFA,;
									(cAliasAFJ)->AFJ_COD,;
									(cAliasAFJ)->AFJ_LOCAL,;
									(cAliasAFJ)->AFJ_QEMPPR,;
									"+",;
									.F.,;
									(cAliasAFJ)->AFJ_QEMPP2,;
									(cAliasAFJ)->AFJ_TRT,;
									,,,;
									.T.)
					EndIf
				EndIf
				a215Skip(cAliasAFJ)
				If !lBat
					oObj:IncRegua1(cMensagem)
				EndIf
			EndDo
			If lQuery
				dbSelectArea(cAliasAFJ)
				dbCloseArea()
				dbSelectArea("AFJ")
			EndIf
		EndIf
	EndIf
	If !lBat
		oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
	EndIf	
	If (!Empty(xFilial("SL2")) .Or. cFilAnt == cFirst )
		//????????????????????????????????
		//?tualiza os dados acumulados das Reservas do SigaLoja         ?
		//????????????????????????????????
		dbSelectArea("SX2")
		dbSetOrder(1)
		DbSeek("SL2")
		cMensagem := AllTrim(X2Nome())
		cMensagem := Lower(cMensagem)
		cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
		dbSelectArea("SL2")
		dbSetOrder(1)
		#IFDEF TOP
			cAliasSL2 := "SL2RES"
			SX3->(DbSetOrder(2))
			If SX3->(DbSeek("L2_QUANT"))
				aStru := { SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL }
			EndIf
			lQuery    := .T.
			cQuery := "SELECT SUM(L2_QUANT) L2_QUANT, L2_PRODUTO, L2_FILIAL, L2_LOCAL "
  			cQuery += "FROM " + RetSqlName("SL2") +  " SL2 "
 			cQuery += "WHERE SL2.L2_FILIAL = '" + xFilial("SL2") + "' "
 			cQuery += "AND SL2.L2_PDV = '' "
 			cQuery += "AND SL2.L2_RESERVA <> '' "
 			cQuery += "AND SL2.L2_ORCRES = '' "
 			cQuery += "AND SL2.L2_PEDRES = ' '"
 			cQuery += "AND SL2.L2_VENDIDO <> 'S'"
 			cQuery += "AND D_E_L_E_T_=' ' "
			cQuery += "GROUP BY SL2.L2_FILIAL, SL2.L2_PRODUTO, SL2.L2_LOCAL"
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSL2,.T.,.T.)
			If Len(aStru) > 0
				TcSetField( cAliasSL2, aStru[1], aStru[2], aStru[3], aStru[4] ) 
			EndIf
		#ELSE
			DbSeek(xFilial("SL2"), .T.)
		#ENDIF
		If !lBat
			oObj:SetRegua1(SL2->(LastRec()))
			oObj:IncRegua1(cMensagem)
		EndIf	
		While !Eof() .And. (cAliasSL2)->L2_FILIAL == xFilial("SL2")
			lContinua := .T.
			lAtuRes   := .T.
			If !lQuery
				If !A215FilOk((cAliasSL2)->L2_PRODUTO) .OR. !Empty((cAliasSL2)->L2_PDV);
					.OR. Empty((cAliasSL2)->L2_RESERVA) .OR. !Empty((cAliasSL2)->L2_ORCRES)
					lContinua := .F.
				EndIf
			EndIf
			
			If HasTemplate("OTC")
				DbSelectArea("SB1")
				DbSetOrder(1)
	            DbSeek( xFilial("SB1") + (cAliasSL2)->L2_PRODUTO )
				If SB1->B1_TIPO == "LG"
				   lAtuRes  := .F.
				EndIf 
			EndIf
			
			If lContinua .AND. lAtuRes 
                Ma215LjAtuRes( cAliasSL2 )
			EndIf
			
			a215Skip(cAliasSL2)
			If !lBat
				oObj:IncRegua1(cMensagem)
			EndIf	
		End
		
		If lQuery
			dbSelectArea(cAliasSL2)
			dbCloseArea()
			dbSelectArea("SM0")
		EndIf
	EndIf
	If !lBat
		oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
	EndIf	
	
	If !lBat
		If (oObj <> NIL) .And. lNewProc
			oObj:SaveLog(OemToAnsi(STR0010))
		EndIf
	EndIf
	//????????????????????????
	//?Atualiza o log de processamento             ?
	//????????????????????????
	ProcLogAtu("MENSAGEM",STR0013+cFilAnt,STR0013+cFilAnt) //"Final Filial: "
	//????????????????????????????????
	//?Verifica se deve continuar a atualizar as demais filiais     ?
	//????????????????????????????????
	If (!Empty(xFilial("SA1")) .And. !Empty(xFilial("SB2")) .And. !lPCFilEnt)
		Exit
	EndIf
    
	//Ponto de entrada executado ap? o calculo para valida?es
	If ExistBlock("MT215EXC")
		ExecBlock("MT215EXC",.F.,.F.)   
	EndIf 
	
	dbSelectArea("SM0")	
	dbSkip()
EndDo

//????????????????????????????????
//?Fecha todos os arquivos e reabre-os de forma compartilhada   ?
//????????????????????????????????
nTempoFim:=Seconds()
cFilAnt := cSavFil
For nX := 1 To Len(aTabs)
	dbSelectArea(aTabs[nX])
	dbCloseArea()
Next	
OpenFile(SubStr(cNumEmp,1,2),"")

//????????????????????????????????
//?Envia mensagem de aviso apos termino da rotina               ?
//????????????????????????????????
cTempo:=StrZero((nTempoFim-nTempoIni)/60,5,0)
MEnviaMail("021",{CUSERNAME,SubStr(cNumEmp,1,2),SubStr(cNumEmp,3,2),cTempo})

//????????????????????????????????
//?Fecha o semaforo de execucao da rotina                       ?
//????????????????????????????????
MA215UnLock(cEmpAnt)

//???????????????????
//?Atualiza o log de processamento   ?
//???????????????????
ProcLogAtu("FIM")

Return


/*
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?215FilOk   ?Autor ?odrigo de A Sartorio?Data ?01/03/00 ??
???????????????????????????????????????
??escri?o ?Verifica no SB1 a existencia do produto                    ??
???????????????????????????????????????
??intaxe   ?A215FilOk(ExpC1)                                           ??
???????????????????????????????????????
??arametros?ExpC1 := Codigo do produto a ser pesquisado                ??
???????????????????????????????????????
??etorno   ?.T. = encontrou o produto em SB1, .F.= nao encontrou       ??
???????????????????????????????????????
??Uso      ?MATA215                                                    ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
*/
Function A215FilOk(cProd)
Return SB1->(MsSeek(xFilial("SB1")+cProd))


/*
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?215Skip    ?Autor ?ernando Joly Siquini?Data ?26/03/02 ??
???????????????????????????????????????
??escri?o ?Se apos o dbSkip um dos Campos Chave (Filial, Produto ou   ??
??         ?Armazem) for alterado, a funcao MsUnlockAll() e executada. ??
??         ?Este procedimento evita a sobrecarga de LOCKS em ambientes ??
??         ?CDX e ADS(Em ambientes TOP a funcao nunca sera executada). ??
???????????????????????????????????????
??intaxe   ?A215Skip(ExpC1)                                            ??
???????????????????????????????????????
??arametros?ExpC1 := Alias no qual o "dbSkip" sera executado.          ??
???????????????????????????????????????
??etorno   ?.T. caso o MsUnlockAll() seja executado, .F. caso contrario??
???????????????????????????????????????
??Uso      ?MATA215                                                    ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????/
Function a215Skip(c215Alias)

//????????????????????????????????
//?Define Variaveis Locais                                      ?
//????????????????????????????????
Local cChaveA    := ''
Local cChaveB    := ''
Local cPrefix    := ''
Local cCpoFil    := ''
Local cCpoCod    := ''
Local cCpoLoc    := ''
Local lRet       := .F.

//????????????????????????????????
//?Redefine Variaveis passadas como parametros                  ?
//????????????????????????????????
Default c215Alias  := Alias()

If Select(c215Alias) > 0
	dbSelectArea(c215Alias)
	//????????????????????????????????
	//?Monta Strings com nomes dos campos FILIAL, PRODUTO e LOCAL   ?
	//????????????????????????????????
	cPrefix := If(SubStr(Upper(c215Alias),1,1)=='S',SubStr(Upper(c215Alias),2,2),SubStr(Upper(c215Alias),1,3))+'_'
	cCpoFil := If(FieldPos(cCpoFil:=cPrefix+'FILIAL')>0,cCpoFil,'')
	cCpoCod := If(FieldPos(cCpoCod:=cPrefix+'PRODUTO')>0,cCpoCod,If(FieldPos(cCpoCod:=cPrefix+'COD')>0,cCpoCod,''))
	cCpoLoc := If(FieldPos(cCpoLoc:=cPrefix+'LOCAL')>0,cCpoLoc,If(FieldPos(cCpoLoc:=cPrefix+'ALMOX')>0,cCpoLoc,''))
	If !((cCpoFil+cCpoCod+cCpoLoc)=='')
		cChaveA  := IIf(!Empty(cCpoFil),FieldGet(FieldPos(cCpoFil)),'')
		cChaveA  += IIf(!Empty(cCpoCod),FieldGet(FieldPos(cCpoCod)),'')
		cChaveA  += IIf(!Empty(cCpoLoc),FieldGet(FieldPos(cCpoLoc)),'')
		dbSkip()
		cChaveB := IIf(!Empty(cCpoFil),FieldGet(FieldPos(cCpoFil)),'')
		cChaveB += IIf(!Empty(cCpoCod),FieldGet(FieldPos(cCpoCod)),'')
		cChaveB += IIf(!Empty(cCpoLoc),FieldGet(FieldPos(cCpoLoc)),'')
		//????????????????????????????????
		//?Executa o MsUnlockAll caso o dbSkip tenha alterado a Chave   ?
		//????????????????????????????????
		If !(cChaveA==cChaveB)
			MsUnLockall()
			lRet := .T.
		EndIf
	Else
		dbSkip()
	EndIf	
EndIf
Return lRet


/*
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?Ma215Res   ?Autor ?enry Fila           ?Data ?19/05/03 ??
???????????????????????????????????????
??escri?o ?Avaliacao da reserva por pedido de venda ou SC9            ??
???????????????????????????????????????
??intaxe   ?Ma215Res(ExpC1,ExpN1)                                      ??
???????????????????????????????????????
??arametros?ExpC1 = Alias do SC0 		                              ??
??         ?ExpN2-Quantidade a reservar  			                  ??
???????????????????????????????????????
??etorno   ?Nenhum                                                     ??
???????????????????????????????????????
??Uso      ?MATA215                                                    ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????/

Static Function Ma215Res(cAliasSC0,nQtdRes,nQtdPed)

Local aArea    := GetArea()
Local aAreaSC0 := SC0->(GetArea())
Local aAreaSDC := SDC->(GetArea())

Local cSeekSDC := ""
Local cAliasSDC:= "SDC"
#IFDEF TOP
	Local aStru    := {}
	Local nX       := 0
	Local cQuery   := ""
#ENDIF
Local lQuery   := .F.

DEFAULT nQtdPed  := 0

If HasTemplate("OTC")
   nQtdRes  := nQtdPed   
EndIf
If Localiza((cAliasSC0)->C0_PRODUTO) .And. !IntDL((cAliasSC0)->C0_PRODUTO)
	cSeekSDC := xFilial("SDC")+;
		(cAliasSC0)->C0_PRODUTO+;
		(cAliasSC0)->C0_LOCAL+"SC0"+;
		(cAliasSC0)->C0_NUM+;
		Criavar("DC_ITEM")+;
		Criavar("DC_SEQ")+;
		(cAliasSC0)->C0_LOTECTL+;
		(cAliasSC0)->C0_NUMLOTE+;
		(cAliasSC0)->C0_LOCALIZ+;
		(cAliasSC0)->C0_NUMSERI
		
	dbSelectArea("SDC")
	dbSetOrder(1)
	#IFDEF TOP
		aStru     := SDC->(dbStruct())
		lQuery    := .T.
		cAliasSDC := "SDCMA215PROC1"

		cQuery := "SELECT * "
		cQuery += "FROM "+RetSqlName("SDC")+" SDC "
		cQuery += "WHERE SDC.DC_FILIAL='"+xFilial("SDC")+"' AND "
		cQuery += "SDC.DC_PRODUTO='"+(cAliasSC0)->C0_PRODUTO+"' AND "
		cQuery += "SDC.DC_LOCAL='"+(cAliasSC0)->C0_LOCAL+"' AND "
		cQuery += "SDC.DC_ORIGEM='SC0' AND "
		cQuery += "SDC.DC_PEDIDO='"+(cAliasSC0)->C0_NUM+"' AND "
		cQuery += "SDC.DC_ITEM='"+Criavar("DC_ITEM")+"' AND "
		cQuery += "SDC.DC_SEQ='"+Criavar("DC_SEQ")+"' AND "
		cQuery += "SDC.DC_LOTECTL='"+(cAliasSC0)->C0_LOTECTL+"' AND "
		cQuery += "SDC.DC_NUMLOTE='"+(cAliasSC0)->C0_NUMLOTE+"' AND "
		cQuery += "SDC.DC_LOCALIZ='"+(cAliasSC0)->C0_LOCALIZ+"' AND "
		cQuery += "SDC.DC_NUMSERI='"+(cAliasSC0)->C0_NUMSERI+"' AND "
		cQuery += "SDC.D_E_L_E_T_=' ' "
		cQuery += "ORDER BY "+SqlOrder(SDC->(IndexKey()))

		cQuery := ChangeQuery(cQuery)

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDC,.T.,.T.)
		For nX := 1 To Len(aStru)
			If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
				TcSetField(cAliasSDC,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
			EndIf
		Next nX
	#ELSE		
		MsSeek(cSeekSDC)
	#ENDIF			
	While !Eof() .And. DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+DC_PEDIDO+DC_ITEM+DC_SEQ+DC_LOTECTL+DC_NUMLOTE+DC_LOCALIZ+DC_NUMSERI == cSeekSDC
		GravaEmp((cAliasSDC)->DC_PRODUTO,;
			(cAliasSDC)->DC_LOCAL,;
			(cAliasSDC)->DC_QUANT,;
			(cAliasSDC)->DC_QTSEGUM,;
			(cAliasSDC)->DC_LOTECTL,;
			(cAliasSDC)->DC_NUMLOTE,;
			(cAliasSDC)->DC_LOCALIZ,;
			(cAliasSDC)->DC_NUMSERI,;
			Nil,;
			Nil,;
			(cAliasSDC)->DC_PEDIDO,;
			Nil,;
			"SC0",;
			Nil,;
			Nil,;
			Nil,;
			.F.,;
			.F.,;
			.T.,;
			.F.,;
			NIL,;
			.T.,;
			.F.)
		a215Skip(cAliasSDC)
	EndDo
	If lQuery
		dbSelectArea(cAliasSDC)
		dbCloseArea()
		dbSelectArea("SDC")
	EndIf
Else
	GravaEmp((cAliasSC0)->C0_PRODUTO,;
		(cAliasSC0)->C0_LOCAL,;
		nQtdRes,;
		NIL,;
		(cAliasSC0)->C0_LOTECTL,;
		(cAliasSC0)->C0_NUMLOTE,;
		(cAliasSC0)->C0_LOCALIZ,;
		(cAliasSC0)->C0_NUMSERI,;
		Nil,;
		Nil,;
		(cAliasSC0)->C0_NUM,;
		Nil,;
		"SC0",;
		Nil,;
		Nil,;
		Nil,;
		.F.,;
		.F.,;
		.T.,;
		.F.,;
		Nil,;
		!Empty((cAliasSC0)->C0_LOTECTL+(cAliasSC0)->C0_NUMLOTE+(cAliasSC0)->C0_LOCALIZ+(cAliasSC0)->C0_NUMSERI),; //22
		.F.)
EndIf

RestArea(aAreaSC0)
RestArea(aAreaSDC)
RestArea(aArea)

Return

/*
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
??rograma  ?a215LjAtuRes?utor  ?arcio Lopes        ?Data ? 15/05/07   ??
????????????????????????????????????????
??esc.     ?Realiza a atualizacao do campo B2_RESERVA, para o modulo      ??
??         ?SIGALOJA.                                                     ??
????????????????????????????????????????
??arametro ?ExpC1 -> Alias do arquivos a ser utilizado                    ??
????????????????????????????????????????
??so       ?Generico                                                      ??
????????????????????????????????????????
??etorno   ?Nenhum                                                        ??
????????????????????????????????????????
????????????????????????????????????????
????????????????????????????????????????
*/
Static Function Ma215LjAtuRes( cAliasSL2 )

Local aAreaSB2 := SB2->(GetArea())			// Guarda a area atual do SB2

SB2->(dbSetOrder(1))
If SB2->( dbSeek(xFilial("SB2") + (cAliasSL2)->L2_PRODUTO + (cAliasSL2)->L2_LOCAL ) )
	//?????????????????????????????
	//?erifica se o produto ?uma reserva na base do SIGALOJA?
	//?????????????????????????????
	RecLock("SB2", .F.)
	SB2->B2_RESERVA += (cAliasSL2)->L2_QUANT
	MsUnlock()
EndIf
Restarea(aAreaSB2)
dbSelectArea(cAliasSL2)

Return(.T.)                                                                              

/*
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?Ma215Check ?Autor ?OTVS S/A            ?Data ?17/01/14 ??
???????????????????????????????????????
??escri?o ?Avalia se a rotina MATA215 esta em execucao.               ??
???????????????????????????????????????
??intaxe   ?Ma215Check()                                               ??
???????????????????????????????????????
??etorno   ?Nenhum                                                     ??
???????????????????????????????????????
??Uso      ?GENERICO                                                   ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????/

Function Ma215Check()
Local aTabs     := {}
Local nX        := 0
Local lContinua := .T.
Local cAliasTab := ""

//??????????????????????????????????????
//?omente validar se as tabelas estao exclusivas se a rotina 'Refaz        |
//|Acumulados (MATA215)' estiver em execucao.                               |
//|O parametro MV_A215CHK devera ser utilizado somente para contingencia.   |
//??????????????????????????????????????
If !LockByName("MT215"+AllTrim(cEmpAnt),.T.,.F.) .And. SuperGetMv("MV_A215CHK",.F.,.T.)

	//Tabelas utilizadas pela rotina
	AADD(aTabs,"SA1");AADD(aTabs,"SB1");AADD(aTabs,"SB2")
	AADD(aTabs,"SB8");AADD(aTabs,"SC0");AADD(aTabs,"SC6")
	AADD(aTabs,"SC7");AADD(aTabs,"SC9");AADD(aTabs,"SD2")
	AADD(aTabs,"SD1");AADD(aTabs,"SD4");AADD(aTabs,"SDC")
	AADD(aTabs,"SDD");AADD(aTabs,"SC1");AADD(aTabs,"SC2")
	AADD(aTabs,"SB6");AADD(aTabs,"SBF");AADD(aTabs,"SDA")
	AADD(aTabs,"SL2");AADD(aTabs,"SCQ")
	
	//Verifica se as tabelas estao em modo exclusivo
	For nX := 1 to Len(aTabs)
		If !(ChkFile(aTabs[nX],.T.))
			cAliasTab := aTabs[nX]
			lContinua := .F.
			Exit
		EndIf
		(aTabs[nX])->(dbCloseArea())
		ChkFile(aTabs[nX],.F.)
	Next nX
	
	//Mensagem para o usuario
	If !lContinua
		If IsBlind()
			Conout(STR0014 + Space(1) + cAliasTab) //"MA215CHECK: N? foi possivel a abertura da tabela"
		Else
	
			//-- Grava Help MA215CHK
			aHlpPorP    := {"Existe tabelas que est? abertas em "		,;
			 				"modo exclusivo e por este motivo nao "		,;
			 				"sera possivel a abertura do modulo."		}
			aHlpIngP    := {"There are tables that are open "			,;
			 				"exclusively and for this reason will "		,;
			 				"not be possible to open the module."		}
			aHlpEspP    := {"Hay mesas que est? abiertos exclusi-"		,;
			 				"vamente y por este motivo no ser?"		,;
			 				"posible abrir el m?ulo."					}
			PutHelp("PMA215CHK",aHlpPorP,aHlpIngP,aHlpEspP,.F.)
			//-- Grava Help MA215CHK
			aHlpPorP    := {"Caso a rotina Refaz Acumulados(MATA215) "	,;
			                "esteja em execu?o aguarde sua finaliza-"	,;
			                "?o para utiliza?o do modulo ou verifi-"	,;
			                "que a rotina que esta travando a tabela "	,;
			                "em quest?."								}
			aHlpIngP    := {"If the Accumulated Remakes (MATA215)"		,;
			                "routine is running its finalization wait"	,;
			                "to use the module or routine check that"	,;
			                "locking the table in question."			}
			aHlpEspP    := {"Si el Collected Redo (MATA215) rutina"		,;
			                "est?ejecutando su estrategia de esperar"	,;
			                "la finalizaci? de utilizar el m?ulo o"	,;
			                "la tabla en cuesti?. "					}
			PutHelp("SMA215CHK",aHlpPorP,aHlpIngP,aHlpEspP,.F.)

			Help(" ",1,"MA215CHK")

			FINAL(STR0014 + Space(1) + cAliasTab,,.F.)	//"MA215CHECK: N? foi possivel a abertura da tabela"

		EndIf
		
	EndIf

Else

	// Desbloqueia o Lock
	MA215UnLock(cEmpAnt)

EndIf	
Return

/*
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?A215Lock   ?Autor ?TOTVS S/A           ?Data ?20.01.14 ??
???????????????????????????????????????
??escri?o ?Bloqueio de Empresas para o processamento da rotina        ??
???????????????????????????????????????
??arametros?ExpC1 = Codigo da Empresa                                  ??
???????????????????????????????????????
??Uso      ?MATA215                                                    ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
*/
Static Function MA215Lock(cEmpresa)
Local lRet       := .T.
Local nTentativa := 0

nTentativa := 0
// Trava arquivo para somente este usuario utilizar rotina
While !LockByName("MT215"+AllTrim(cEmpresa),.T.,.F.) .And. nTentativa <= 50
	nTentativa++
	Sleep(100)
End

// Tenta travar somente 50 vezes, e se nao conseguir coloca na lista de filiais com concorrencia
If nTentativa > 50
	If !IsBlind()
		Aviso(STR0015,STR0016+cEmpresa,{"Ok"},2) // ##"Concorr?cia"##"A empresa corrente j?esta sendo utilizadas no processo de refaz acumulados: "
	EndIf	
	lRet := .F. 
EndIf

Return lRet

/*
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
??un?o    ?A215UnLock ?Autor ?TOTVS S/A           ?Data ?20.01.14 ??
???????????????????????????????????????
??escri?o ?Desbloqueio de Empresa                                     ??
???????????????????????????????????????
??arametros?ExpC1 = Codigo da Empresa                                  ??
???????????????????????????????????????
??Uso      ?MATA215                                                    ??
???????????????????????????????????????
???????????????????????????????????????
???????????????????????????????????????
*/
Static Function MA215UnLock(cEmpresa)

// Destrava o bloqueio de filiais
UnLockByName("MT215"+AllTrim(cEmpresa),.T.,.F.)

Return