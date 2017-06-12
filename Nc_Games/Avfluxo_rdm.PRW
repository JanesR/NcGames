#INCLUDE "Rwmake.ch"
#INCLUDE "Average.ch"

//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGames
//|Funcao....: U_AvFluxo()
//|Autor.....: Luiz Fernando
//|Data......: 26 de Junho de 2013 - 13:42
//|Uso.......: SIGAEIC
//|Versao....: Protheus - 10
//|Descricao.: Ajusta Vencimento do Titulo Previsoes para Midias
//|Observação:
//------------------------------------------------------------------------------------//

*-----------------------------*
User Function AVFLUXO()
*-----------------------------*
Public cDespesaWH
Public cMoeda1New:=GETMV("MV_SIMB1")
Public cMoeda2New:=GETMV("MV_SIMB2")
Public nValDesp //:= 0
Public nValorOld
Public nTotalII :=0
Public nTotalIPI:= 0
Public nFrePrev := 0               //SW2->W2_XFRPREV // Frete  Moeda Previsto
Public nSegPrev := 0               //SW2->W2_XSGPREV // Seguro Moeda Previsto
Public nPTPrev  := SW2->W2_PESO_B  //SW2->W2_XTPLIQ  // Seguro Moeda Previsto
Public cDescEIC //:= ""
Public cDescEMB //:= " "
Public aDespGer :={}
Public nD
Public nGDup := 0
Public cNumTit := ""
Public nVrCif := 0
Public nValSE2Old := 0
Public nQtdeSald := 0
Public lFinal
Public nTxSisc  := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"415","WI_VALOR") //Posicione("SYB",1,xFilial("SYB")+"415","YB_VALOR")
Public aRet       := {}
Public nTaxa:=BuscaTaxa(cMoeda2New,dDataBase,.T.,.F.,.T.)
Public dDtentPrev := CtoD("  /  /  ")

If Alltrim(FUNNAME()) == "EICIN100"
	Return
Endif

Do Case
	//S.1upertech
	*****************************************************************
	************ Corrige valores apos Previsoes EMB  ****************
	*****************************************************************
	
	Case ParamIxb == "VALOR_TIT_PRE_POS" //.AND. lExiste_Midia
		cDescEMB := "Proc."+ALLTRIM(SW6->W6_HAWB)+' '+"-"+cDescFB
		If upper(Substr(SE2->E2_HIST,1,3)) == "PRO" //$ "102|103|201|202|203|204|205|415"
			//alltrim(SE2->E2_HIST) == alltrim(cDescEMB) .AND. cDespesaWH $"102|103|201|202|203|204|205|415"
			SE2->(RecLock("SE2",.F.))
			Delete
			nDup := nDup - 1
			SE2->(MsUnlock())
			//cDespesaWH := " "
		Endif
		
		*****************************************************************
		************ Recalculo de Impostos Midia Fase PO ****************
		*****************************************************************
		
	Case ParamIxb == "APOS_EICTP25A" .and. Alltrim(FUNNAME()) != "EICDI502"    //.AND. lExiste_Midia .and. Alltrim(FUNNAME()) != "EICDI502"
		
		
		//cFornec := Posicione("SY4",1,xFilial("SY4")+SW2->W2_DESP,"Y4_FORN")
		//cLoja		:= SY4->Y4_LOJA
		
		SE2->(DbSetorder(1))
		SE2->(DbgoTop())
		If SE2->(DbSeek(xFilial("SE2")+"EIC"+"000"+SW2->W2_PO_SIGA))
			While !SE2->(Eof()).AND.("000"+SW2->W2_PO_SIGA)==SE2->E2_NUM .AND. "EIC"==SE2->E2_PREFIXO
				If SE2->E2_NUM == "000"+SW2->W2_PO_SIGA
					SE2->(Reclock("SE2"),.F.)
					SE2->(dbDelete())
					SE2->(MsUnlock())
				Endif
				SE2->(Dbskip())
			Enddo
		Endif
		
		lFinal := .F.
		nDup := 1
		
		//IF !lExiste_Midia
		//	Return
		//Endif
		
		If nValorOld != Nil .and. nValorOld != 0 .AND. nValDesp != Nil .and. nValDesp != 0
			If Round(nValorOld,2) == SE2->E2_VALOR
				SE2->(Reclock("SE2",.F.))
				SE2->E2_VALOR := nValDesp
				SE2->E2_SALDO := nValDesp
				SE2->E2_VLCRUZ:= nValDesp
				If cDespesaWH > "415"
					SE2->E2_HIST   :=  "Ped "+ALLTRIM(SW2->W2_PO_NUM)+' '+ "-"+cDescEIC //Historico da geracao
				Endif
				SE2->(MsUnlock("SE2"))
				nValDesp := 0
				nValorOld:= 0
			Endif
		Endif
		
		BuscaDesp()
		
		For nD := 1 to Len(aDespGer)
			
			cDespesaWH := aDespGer[nD,1]
			nValorOld := nValorRdm
			
			Do Case
				
				Case aDespGer[nD,1] == "101" // "FOB"
					nSegPrev := (SW2->W2_FOB_TOT*nTaxa)
				Case aDespGer[nD,1] == "102" // "FRE"
					AchaValDes("FRE")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "FRETE"
					nValorOld := nValorRdm
					nSegPrev := (nSegPrev + nValDesp)*(Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"103","WI_PERCAPL"))
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "103" // "SEG"
					AchaValDes("SEG")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "SEGURO"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "201" // "I.I"
					AchaValDes("II")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "II"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "202" // "IPI"
					nTotalII  := 0
					nTotalIPI := 0
					AchaValDes("IPI")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "IPI"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "203" // "ICMS"
					nTotalII  := 0
					nTotalIPI := 0
					AchaValDes("ICMS")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "ICMS"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "204" // "PIS"
					AchaValDes("PIS")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "PIS"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "205" // "COFINS"
					AchaValDes("COF")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "COF"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case aDespGer[nD,1] == "415" // "TX Siscomex"
					AchaValDes("TXS")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "Tx Sisc"
					nValorOld := nValorRdm
					GrvSE2("PO")
					nValDesp := 0
				Case !aDespGer[nD,1] $ "101|102|104|103|201|202|203|204|205|415"
					cDespesaWH := aDespGer[nD,1] //	"333" //calcular
					cDescEIC   := alltrim(Posicione("SYB",1,xFilial("SYB")+cDespesaWH,"YB_DESCR"))
					If cDespesaWH == "333"
						nValDesp := (nFrePrev*10)/100
					ElseIf cDespesaWH == "417"
						//AchaValDes("417")
						nVlPer417 := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+cDespesaWH,"WI_PERCAPL")
						nValDesp := (((nFrePrev + nSegPrev + (nVrCif))*nTaxa)*nVlPer417)/100  //(nCIF*3)/100
					Else
						nValDesp   := Posicione("SWI",1,xFilial("SWI")+SW6->W6_TAB_PC+cDespesaWH,"WI_VALOR")
					endif
					GrvSE2("PO")
					nValDesp := 0
			EndCase
			
		Next
		lSair := .T.
		
		*****************************************************************
		******* Recalculo de Impostos Midia Fase Embarque/Desemb ********
		*****************************************************************
		
	Case ParamIxb == "VALOR_TIT_PRE" .and. (lFinal == Nil .OR. !lFinal) //.AND. lExiste_Midia .and. (lFinal == Nil .OR. !lFinal)
		lFinal := .F.
		cArqSw := Posicione("SW7",1,xFilial("SW7")+SW6->W6_HAWB,"W7_PO_NUM")
		
		//IF !lExiste_Midia
		//	Return
		//Endif
		
		BuscaDesp(cArqSw)
		
		For nD := 1 to Len(aDespGer)
			
			cDespesaWH := aDespGer[nD,1]
			
			Do Case
				
				Case aDespGer[nD,1] == "101" // "FOB"
					nSegPrev := (SW2->W2_FOB_TOT*nTaxa)
				Case aDespGer[nD,1] == "102" // "FRE"
					AchVaEmb("FRE")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "FRETE"
					nValorOld := nValorRdm
					nSegPrev := (nSegPrev + nValDesp)*(Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"103","WI_PERCAPL"))
					GrvSE2()
					nValDesp := 0
				Case aDespGer[nD,1] == "103" // "SEG"
					AchVaEmb("SEG")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "SEGURO"
					nValorOld := nValorRdm
					GrvSE2()
					nValDesp := 0
				Case aDespGer[nD,1] == "201" // "I.I"
					AchVaEmb("II")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "II"
					nValorOld := nValorRdm
					GrvSE2()
				Case aDespGer[nD,1] == "202" // "IPI"
					nTotalII  := 0
					nTotalIPI := 0
					AchVaEmb("IPI")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "IPI"
					nValorOld := nValorRdm
					GrvSE2()
				Case aDespGer[nD,1] == "203" // "ICMS"
					nTotalII  := 0
					nTotalIPI := 0
					AchVaEmb("ICMS")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "ICMS"
					nValorOld := nValorRdm
					GrvSE2()
				Case aDespGer[nD,1] == "204" // "PIS"
					AchVaEmb("PIS")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "PIS"
					nValorOld := nValorRdm
					GrvSE2()
				Case aDespGer[nD,1] == "205" // "COFINS"
					AchVaEmb("COF")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "COF"
					nValorOld := nValorRdm
					GrvSE2()
				Case aDespGer[nD,1] == "415" // "TX Siscomex"
					AchVaEmb("TXS")
					cDespesaWH := aDespGer[nD,1]
					cDescEIC := "Tx Sisc"
					nValorOld := nValorRdm
					GrvSE2()
				Case !aDespGer[nD,1] $ "101|102|104|103|201|202|203|204|205|415"
					cDespesaWH := aDespGer[nD,1] //	"333" //calcular
					nDup := nGDup
					cDescEIC   := alltrim(Posicione("SYB",1,xFilial("SYB")+cDespesaWH,"YB_DESCR"))
					If cDespesaWH == "333"
						cDescEIC   := alltrim(Posicione("SYB",1,xFilial("SYB")+cDespesaWH,"YB_DESCR"))
						nValDesp := (nFrePrev*10)/100
					ElseIf cDespesaWH == "417"
						//AchVaEmb("417")
						cDescEIC   := alltrim(Posicione("SYB",1,xFilial("SYB")+cDespesaWH,"YB_DESCR"))
						nVlPer417 := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+cDespesaWH,"WI_PERCAPL")
						nValDesp := (((nFrePrev + nSegPrev + (nVrCif))*nTaxa)*nVlPer417)/100  //(nCIF*3)/100
					Else //iF !cDespesaWH $ "101|102|104|103|201|202|203|204|205|415|333|417"
						cDescEIC   := alltrim(Posicione("SYB",1,xFilial("SYB")+cDespesaWH,"YB_DESCR"))
						nValDesp   := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+cDespesaWH,"WI_VALOR")
					endif
					GrvSE2()
					
			EndCase
			
		Next nD
		
		lFinal := .T.
		
EndCase

Return

****************************************
*** Gera Despesa Finan Embarque ********
****************************************
Static Function GrvSE2(cFase,cParcela)
**************************************

Local aOldSW7 := GetArea()
Local cFil		:= ""
Local cPrefixo	:= ""
Local cNum		:= ""
Local cTipo		:= ""
Local cFornec	:= ""
Local cLoja		:= ""
//Local nChr:=Asc(Alltrim(GetMv("MV_1DUP"))) - 1


If !lFinal .and. nValDesp != 0 .AND. nValSE2Old != nValDesp
	
	
	SE2->(DbSelectArea("SE2"))
	nDup := nDup + 1
	
	IF !(cParcela <> NIL )
		Public cParcela:=chr(asc(GetMV("MV_1DUP"))-1)
	Else
		cParcela:= Soma1(cParcela,, .T. )
	ENDIF
	
	cFil		:= xFilial("SE2")
	cPrefixo	:= "EIC"
	
	If cFase == "PO"
		//AvExistHist(xFilial("SE2"),"EIC","PR" ,Posicione("SY4",1,xFilial("SY4")+SW2->W2_DESP,"Y4_FORN"),SA2->A2_LOJA,cDespesaWH+"-"+ALLTRIM(SW2->W2_PO_NUM)+' '+ "-"+cDescEIC)
	Else
		AvExistHist(xFilial("SE2"),"EIC","PRE" ,SA2->A2_COD,cLojaF,cDespesaWH+"-"+ALLTRIM(SW6->W6_HAWB)+' '+ "-"+cDescEIC)
	EndIf
	
	
	SE2->(RecLock("SE2",.T.))
	SE2->E2_FILIAL 	:=  xFilial("SE2")
	SE2->E2_EMISSAO 	:=  dDataBase
	SE2->E2_EMIS1	   :=  dDataBase
	SE2->E2_PREFIXO 	:=  "EIC"
	If cFase == "PO"
		cNum		:= "000"+SW2->W2_PO_SIGA
		SE2->E2_HIST   :=  cDespesaWH+"-"+ALLTRIM(SW2->W2_PO_NUM)+' '+ "-"+cDescEIC //Historico da geracao
		cTipo		:= "PR"
		SE2->E2_TIPO   :=  cTipo
		SE2->E2_NUM    :=	 cNum
		cFornec := Posicione("SY4",1,xFilial("SY4")+SW2->W2_DESP,"Y4_FORN")
		SE2->E2_FORNECE:=  cFornec
		SE2->E2_NOMFOR :=  Posicione("SA2",1,xFilial("SA2")+cFornec+"01","A2_NREDUZ")
		cLoja		:= SA2->A2_LOJA
		SE2->E2_LOJA   :=  cLoja
	Else
		SE2->E2_HIST   :=  cDespesaWH+"-"+ALLTRIM(SW6->W6_HAWB)+' '+ "-"+cDescEIC //Historico da geracao
		cTipo	:= "PRE"
		SE2->E2_TIPO   :=  cTipo
		cNum			:= SW6->W6_NUMDUP
		SE2->E2_NUM    :=  cNum
		cFornec:= SA2->A2_COD
		SE2->E2_FORNECE :=  cFornec
		SE2->E2_NOMFOR 	:=  SA2->A2_NREDUZ
		SE2->E2_LOJA    :=  cLojaF
		cLoja		:= cLojaF
	Endif
	SE2->E2_MOEDA   	:=  1
	SE2->E2_PARCELA 	:=  xParc(cFil,cPrefixo,cNum,cTipo,cFornec,cLoja) //cParcela //Str(nDup,1)
	SE2->E2_VENCORI  	:=  aDespGer[nD,5]
	SE2->E2_VENCTO   	:=  aDespGer[nD,5]
	SE2->E2_VENCREA   :=  DataValida(aDespGer[nD,5],.T.)
	SE2->E2_VALOR   	:=  nValDesp
	SE2->E2_VLCRUZ 	:=  nValDesp
	SE2->E2_TXMOEDA 	:=  0.00
	SE2->E2_SALDO   	:=  nValDesp
	SE2->E2_NATUREZ   :=  "33911"
	SE2->E2_OCORREN 	:=  "01"
	SE2->E2_ORIGEM  	:=  "SIGAEIC"
	SE2->E2_LA		   :=  "S"
	nValDesp   := 0
	SE2->(MsUnLock())
	
	nGDup := nDup
	nValSE2Old := SE2->E2_VALOR
	
Endif

RestArea(aOldSW7)

Return

****************************************
*** Cal. No PO *************************
****************************************
Static Function AchaValDes(nTrasDes)
****************************************
Local nII_Acumulado  := 0
Local nIPI_Acumulado := 0
Local nICMS_Acumulado:= 0
Local nPIS_Acumulado := 0
Local nCOF_Acumulado := 0
//Local	nTxSisc  := Posicione("SYB",1,xFilial("SYB")+"415","YB_VALOR")
//Local nTaxa:=BuscaTaxa(cMoeda2New,dDataBase,.T.,.F.,.T.)
Local cChPOSIPI:=Busca_NCM("SW3")

SYD->(DBSEEK(xFilial()+cChPOSIPI))

Private MPerc_II   :=SYD->YD_PER_II
Private MPerc_IPI  :=SYD->YD_PER_IPI
Private MPerc_PIS  :=SYD->YD_PER_PIS
Private MPerc_COF  :=SYD->YD_PER_COF
Private MPerc_ICMS :=SYD->YD_ICMS_RE

nFrePrev := SW2->W2_PESO_B * (Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"102","WI_VALOR1"))  //SW2->W2_XFRPREV // Frete  Moeda Previsto
//nSegPrev := SW2->W2_XSGPREV // Seguro Moeda Previsto

nFrePrev := nFrePrev * nTaxa
//nSegPrev := nSegPrev * nTaxa

//IF lExiste_Midia

cSw3Area := GetArea()

SW3->(DBSEEK(xFilial("SW3")+SW2->W2_PO_NUM))
DO WHILE !SW3->(EOF()) .AND. SW3->W3_PO_NUM == SW2->W2_PO_NUM
	
	dDtentPrev := SW3->W3_DT_ENTR
	
	SB1->(DbSeek(xFilial("SB1")+SW3->W3_COD_I))
	
	nSld_Gi:= 0
	nQtd_Gi:= 0
	Po420_IgPos("3")
	IF SW3->W3_FLUXO == "7"
		nQtde := nSld_Gi
	ELSE
		nQtde := SW3->W3_SALDO_Q + nSld_Gi
	ENDIF
	IF nQtde <= 0 .or. SW3->W3_SEQ == 1
		SW3->(DBSKIP())
		LOOP
	ENDIF
	
	cChPOSIPI:=Busca_NCM("SW3")
	
	SYD->(DBSEEK(xFilial()+cChPOSIPI))
	
	MPerc_II   :=SYD->YD_PER_II
	MPerc_IPI  :=SYD->YD_PER_IPI
	MPerc_PIS  :=SYD->YD_PER_PIS
	MPerc_COF  :=SYD->YD_PER_COF
	MPerc_ICMS :=SYD->YD_ICMS_RE
	
	*** Desenvolvido com Anelise em 30/07/2013 In company
	nPesUnit := SW3->W3_QTDE * SW3->W3_PESO_BR
	nVPesoTab := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"102","WI_VALOR1")
	nRatfret := ((nPesUnit/nPTPrev)*(nPTPrev*nVPesoTab))*nTaxa
	*********************************************************************
	
	*****************************************************************************************
	nQtdeSald:= nQtde
	*****************************************************************************************
	
	If SW2->W2_VLMIDIA > 0  //lExiste_Midia
		If  SB1->B1_MIDIA == "1"
			nVrCif := (SB1->B1_QTMIDIA * nQtdeSald * SW2->W2_VLMIDIA)
		Else
			nVrCif := (nQtdeSald * SW3->W3_PRECO)
		Endif
	Else
		nVrCif := (nQtdeSald * SW3->W3_PRECO)
	Endif
	
	****************************
	/// Calculo FRE_Midia PO
	****************************
	If nTrasDes == "FRE"
		nValDesp := nFrePrev
	Endif
	
	****************************
	/// Calculo SEG_Midia PO
	****************************
	If nTrasDes == "SEG"
		nValDesp := nSegPrev
	Endif
	
	****************************
	/// Calculo II_Midia PO
	****************************
	If nTrasDes == "II" .and. MPerc_II > 0
		***************************
		*** Calcula Impostos ******
		***************************
		If nValDesp == Nil
			nValDesp := 0
		Endif
		nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
		***************************
		nValDesp 		:= nValDesp + aRet[2]
	Endif
	
	***************************
	/// Calculo IPI_Midia PO
	***************************
	If nTrasDes == "IPI" .and. MPerc_IPI > 0
		***************************
		*** Calcula Impostos ******
		***************************
		If nValDesp == Nil
			nValDesp := 0
		Endif
		nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
		***************************
		nValDesp 		:= nValDesp + aRet[4]
	Endif
	
	***************************
	/// Calculo PIS_Midia PO
	***************************
	If nTrasDes == "PIS" .and. MPerc_PIS > 0
		***************************
		*** Calcula Impostos ******
		***************************
		If nValDesp == Nil
			nValDesp := 0
		Endif
		nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
		***************************
		nValDesp 		:= nValDesp + aRet[6]
	Endif
	
	***************************
	/// Calculo COF_Midia PO
	***************************
	If nTrasDes == "COF" .and. MPerc_COF > 0
		***************************
		*** Calcula Impostos ******
		***************************
		If nValDesp == Nil
			nValDesp := 0
		Endif
		nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
		***************************
		nValDesp 		:= nValDesp + aRet[7]
	Endif
	
	***************************
	/// Calculo ICMS_Midia PO
	***************************
	If nTrasDes == "ICMS" .and. MPerc_ICMS > 0
		***************************
		*** Calcula Impostos ******
		***************************
		If nValDesp == Nil
			nValDesp := 0
		Endif
		nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
		***************************
		nValDesp 		:= nValDesp + aRet[9]
	Endif
	
	****************************
	/// Calculo Siscomex PO
	****************************
	If nTrasDes == "TXS"
		nValDesp := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"415","WI_VALOR") //Posicione("SYB",1,xFilial("SYB")+"415","YB_VALOR")
		cDescEIC := "Tx Siscomex"
		lFinal := .F.
		GrvSE2("PO")
	Endif
	
	SW3->(DBSKIP())
	
ENDDO

//ENDIF

RestArea(cSw3Area)

Return(nValDesp)

****************************************
*** Cal. No Embarque *******************
****************************************
Static Function AchVaEmb(nTrasDes)
****************************************
Local nII_Acumulado  := 0
Local nIPI_Acumulado := 0
Local nICMS_Acumulado:= 0
Local nPIS_Acumulado := 0
Local nCOF_Acumulado := 0
//Local	nTxSisc  := Posicione("SYB",1,xFilial("SYB")+"415","YB_VALOR")
Local nTaxa    := IIf(!Empty(SW6->W6_TX_US_D),SW6->W6_TX_US_D,BuscaTaxa(cMoeda2New,dDataBase,.T.,.F.,.T.))
Local	cChPOSIPI:= Busca_NCM("SW7")

If !lFinal
	SYD->(DBSEEK(xFilial()+cChPOSIPI))
	
	Private MPerc_II   :=SYD->YD_PER_II
	Private MPerc_IPI  :=SYD->YD_PER_IPI
	Private MPerc_PIS  :=SYD->YD_PER_PIS
	Private MPerc_COF  :=SYD->YD_PER_COF
	Private MPerc_ICMS :=SYD->YD_ICMS_RE
	
	If (SW6->W6_VLFREPP + SW6->W6_VLFRECC ) > 0
		nFrePrev := (SW6->W6_VLFREPP + SW6->W6_VLFRECC) * nTaxa
	Else
		nFrePrev := SW2->W2_PESO_B * (Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"102","WI_VALOR1"))  //XFRPREV // Frete  Moeda Previsto
	Endif
	If SW6->W6_VL_USSE > 0
		nSegPrev := SW6->W6_VL_USSE  * nTaxa
		//Else
		//	nSegPrev := //SW2->W2_XSGPREV // Seguro Moeda Previsto
	Endif
	
	nTxS := Posicione("SWD",1,xFilial("SWD")+SW6->W6_HAWB+"415","WD_VALOR_R")
	If nTxS != 0
		nTxSisc := nTxS
	Endif
	
	//IF lExiste_Midia
	
	cSw7Area := GetArea()
	
	SW7->(DbSetOrder(4))
	SW7->(DBSEEK(xFilial("SW7")+SW6->W6_HAWB))
	DO WHILE !SW7->(EOF()) .AND. SW7->W7_HAWB == SW6->W6_HAWB
		IF Empty(SW6->W6_DT_ETA)
			dDtentPrev := SW3->W3_DT_ENTR
		Else
			dDtentPrev := SW6->W6_DT_ETA
		Endif
		SB1->(DbSeek(xFilial("SB1")+SW7->W7_COD_I))
		nSld_Gi:= 0
		nQtd_Gi:= 0
		
		nQtde := SW7->W7_SALDO_Q // + nSld_Gi
		
		IF nQtde <= 0 .or. SW7->W7_SEQ == 1
			SW7->(DBSKIP())
			LOOP
		ENDIF
		
		cChPOSIPI:= Busca_NCM("SW7")
		
		SYD->(DBSEEK(xFilial()+cChPOSIPI))
		
		MPerc_II   :=SYD->YD_PER_II
		MPerc_IPI  :=SYD->YD_PER_IPI
		MPerc_PIS  :=SYD->YD_PER_PIS
		MPerc_COF  :=SYD->YD_PER_COF
		MPerc_ICMS :=SYD->YD_ICMS_RE
		
		nPTPrev := SW6->W6_PESO_BR
		*** Desenvolvido com Anelise em 30/07/2013 In company
		nPesUnit := SW7->W7_QTDE * SW7->W7_PESO_BR
		nVPesoTab := Posicione("SWI",1,xFilial("SWI")+SW2->W2_TAB_PC+"102","WI_VALOR1")
		nRatfret := ((nPesUnit/nPTPrev)*(nPTPrev*nVPesoTab))*nTaxa
		*********************************************************************
		
		*****************************************************************************************
		nQtdeSald:= nQtde
		*****************************************************************************************
		
		If SW2->W2_VLMIDIA > 0 //lExiste_Midia
			If  SB1->B1_MIDIA == "1"
				nVrCif := (SB1->B1_QTMIDIA * nQtdeSald * SW2->W2_VLMIDIA)
			Else
				nVrCif := (nQtdeSald * SW7->W7_PRECO)
			Endif
		Else
			nVrCif := (nQtdeSald * SW7->W7_PRECO)
		Endif
		
		****************************
		/// Calculo FRE_Midia Emb
		****************************
		If nTrasDes == "FRE"
			nValDesp := nFrePrev
		Endif
		
		****************************
		/// Calculo SEG_Midia Emb
		****************************
		If nTrasDes == "SEG"
			nValDesp := nSegPrev
		Endif
		
		*******************************
		/// Calculo II_Midia Embarque
		*******************************
		If nTrasDes == "II" .and. MPerc_II > 0
			***************************
			*** Calcula Impostos ******
			***************************
			If nValDesp == Nil
				nValDesp := 0
			Endif
			nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
			***************************
			nValDesp 		:= nValDesp + aRet[2]
		Endif
		
		********************************
		/// Calculo IPI_Midia Embarque
		********************************
		If nTrasDes == "IPI" .and. MPerc_IPI > 0
			***************************
			*** Calcula Impostos ******
			***************************
			If nValDesp == Nil
				nValDesp := 0
			Endif
			nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
			***************************
			nValDesp 		:= nValDesp + aRet[4]
		Endif
		
		********************************
		/// Calculo PIS_Midia Embarque
		********************************
		If nTrasDes == "PIS" .and. MPerc_PIS > 0
			***************************
			*** Calcula Impostos ******
			***************************
			If nValDesp == Nil
				nValDesp := 0
			Endif
			nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
			***************************
			nValDesp 		:= nValDesp + aRet[6]
		Endif
		
		********************************
		/// Calculo COF_Midia Embarque
		********************************
		If nTrasDes == "COF" .and. MPerc_COF > 0
			***************************
			*** Calcula Impostos ******
			***************************
			If nValDesp == Nil
				nValDesp := 0
			Endif
			nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
			***************************
			nValDesp 		:= nValDesp + aRet[7]
		Endif
		
		*********************************
		/// Calculo ICMS_Midia Embarque
		*********************************
		If nTrasDes == "ICMS" .and. MPerc_ICMS > 0
			***************************
			*** Calcula Impostos ******
			***************************
			If nValDesp == Nil
				nValDesp := 0
			Endif
			nvII := CalcImp((((nVrCif)*nTaxa)+(nRatfret)),MPerc_II,MPerc_IPI,MPerc_ICMS,MPerc_PIS,MPerc_COF,nTxSisc,0,cChPOSIPI,Space(03))
			***************************
			nValDesp 		:= nValDesp + aRet[9]
		Endif
		
		****************************
		/// Calculo Siscomex Emb
		****************************
		If nTrasDes == "TXS"
			nValDesp := Posicione("SWI",1,xFilial("SWI")+SW6->W6_TAB_PC+"415","WI_VALOR") //Posicione("SYB",1,xFilial("SYB")+"415","YB_VALOR")
		Endif
		
		SW7->(DBSKIP())
		
	ENDDO
	
	//ENDIF
	
	RestArea(cSw7Area)
Endif

Return(nValDesp)

****************************************
Static Function BuscaDesp()
****************************************
Local dDtVectoTit := CTOD('')
If ParamIxb == "APOS_EICTP25A"
	
	SWI->(DBSETORDER(1))
	SWI->(DBSEEK(XFILIAL("SWI")+SW2->W2_TAB_PC))
	
	DO WHILE  !SWI->(EOF()) .AND. XFILIAL("SWI")+SW2->W2_TAB_PC == SWI->WI_FILIAL+SW2->W2_TAB_PC
		
		// Verifica Despesa
		//IF SWI->WI_DESP$'101' .OR. (SWI->WI_DESP$'102'.AND. UPPER(SW6->W6_FREPPCC)=="PP")
		IF SWI->WI_DESP$'102'.AND. UPPER(SW6->W6_FREPPCC)=="PP"
			SWI->(DBSKIP())
			LOOP
		ENDIF
		
		// Verifica Saldo em Quantidade
		SW3->(DBSEEk(XFILIAL("SW3")+SWH->WH_PO_NUM+STR(0,2)+STR(SWH->WH_NR_CONT,3)))
		
		If !Empty(SW2->W2_DT_IMP)
			dDtVectoTit := SW2->W2_DT_IMP
		Else
			dDtVectoTit := SW3->W3_DT_ENTR 
		EndIf
		dDtentPrev := SW3->W3_DT_ENTR
		
		nSld_Gi:= 0
		nQtd_Gi:= 0
		TPO_NUM:= SW2->W2_PO_NUM
		Po420_IgPos("3")
		IF SW3->W3_FLUXO == "7"
			nQtde := nSld_Gi
		ELSE
			nQtde := SW3->W3_SALDO_Q + nSld_Gi
		ENDIF
		IF nQtde <= 0
			SWI->(DBSKIP())
			LOOP
		ENDIF
		// Posiciona Tabela de Pre-Calculo
		SYB->(DBSEEk(XFILIAL("SYB")+SWI->WI_DESP ))
		
		nTaxa:=BuscaTaxa(cMoeda2New,dDataBase,.T.,.F.,.T.)
		nTaxa:=IF(nTaxa=0,1,nTaxa)
		
		nValPgNew:=SWI->WI_VALOR //*nTaxa
		
		//AADD(aDespGer,{SWI->WI_DESP,cMoeda1New,SWI->WI_PERCAPL,nValPgNew,dDtentPrev+SWI->WI_QTDDIAS,SYB->YB_DESCR,SWI->WI_DESC  })
		AADD(aDespGer,{SWI->WI_DESP,cMoeda1New,SWI->WI_PERCAPL,nValPgNew,dDtVectoTit+SWI->WI_QTDDIAS,SYB->YB_DESCR,SWI->WI_DESC  })		
		
		SWI->(DBSKIP())
		
	ENDDO
	
Endif

If ParamIxb == "VALOR_TIT_PRE"
	
	SWI->(DBSETORDER(1))
	SWI->(DBSEEK(XFILIAL("SWI")+SW6->W6_TAB_PC))
	
	DO WHILE  !SWI->(EOF()) .AND. XFILIAL("SWI")+SW6->W6_TAB_PC == SWI->WI_FILIAL+SW6->W6_TAB_PC
		// Verifica Despesa
		//IF SWI->WI_DESP$'101' .OR. (SWI->WI_DESP$'102'.AND. UPPER(SW6->W6_FREPPCC)=="PP")
		IF SWI->WI_DESP$'102'.AND. UPPER(SW6->W6_FREPPCC)=="PP"
			SWI->(DBSKIP())
			LOOP
		ENDIF
		
		nSld_Gi:= 0
		nQtd_Gi:= 0
		TPO_NUM:= SW7->W7_PO_NUM
		Po420_IgPos("3")
		
		nQtde := SW7->W7_SALDO_Q + nSld_Gi
		
		IF nQtde <= 0
			SWI->(DBSKIP())
			LOOP
		ENDIF
		
		// Posiciona Tabela de Pre-Calculo
		SYB->(DBSEEk(XFILIAL("SYB")+SWI->WI_DESP ))
		
		nTaxa:=BuscaTaxa(cMoeda2New,dDataBase,.T.,.F.,.T.)
		nTaxa:=IF(nTaxa=0,1,nTaxa)
		
		nValPgNew:=SWI->WI_VALOR //*nTaxa
		
		nAsc:=ASCAN(aDespGer, {|cAsc| cAsc[1]==SWI->WI_DESP } )
		
		//Verifica se a data de embarque esta preenchida, para efetuar o calculo do vencimento do titulo 
		If !Empty(SW6->W6_DT_EMB)
			AADD(aDespGer,{SWI->WI_DESP,cMoeda1New,SWI->WI_PERCAPL,nValPgNew,SW6->W6_DT_EMB+SWI->WI_QTDDIAS,SYB->YB_DESCR,SWI->WI_DESC  })
		Else                                                                                                                           
			AADD(aDespGer,{SWI->WI_DESP,cMoeda1New,SWI->WI_PERCAPL,nValPgNew,dDataBase+SWI->WI_QTDDIAS,SYB->YB_DESCR,SWI->WI_DESC  })
		EndIf
		
		SWI->(DBSKIP())
		
	ENDDO
	
Endif

Return

//+-----------------------------------------------------------------------------------//
//|Funcao....: CalcImp()
//|Autor.....: Carioca
//|Data......: 25 de julho de 2013, 10:30
//|Descricao.: Calcula todos os impostos
//|Parametros: nxCIF     = Cif para calculo
//|            nxPERII   = Aliquota de II
//|            nxPERIPI  = Aliquota de IPI
//|            nxPERICMS = Aliquota de ICMS
//|            nxPERPIS  = Aliquota de PIS
//|            nxPERCOF  = Aliquota de COFINS
//|            nxDespICM = Despesa base de ICMS
//|            nxDespIMP = Despesa base de Imposto
//|            cxNCM     = NCM para calculo de informar os impostos
//|            cxEX      = EX da NCM para Calculo
//|
//|Retorno...: aRet[1] = Base do II
//|            aRet[2] = Valor do II
//|            aRet[3] = Base do IPI
//|            aRet[4] = Valor do IPI
//|            aRet[5] = Base do PIS COFINS
//|            aRet[6] = Valor do PIS
//|            aRet[7] = Valor do COFINS
//|            aRet[8] = Base do ICMS
//|            aRet[9] = Valor do ICMS
//|
//|Observação: Totas as aliquotas devem vir dividas por 100
//+-----------------------------------------------------------------------------------//
*-------------------------------------------------------------------------------------------------------------------------------------*
Static Function CalcImp(nxCIF,nxPERII,nxPERIPI,nxPERICMS,nxPERPIS,nxPERCOF,nxDespICM,nxDespIMP,cxNCM,cxEX)
*-------------------------------------------------------------------------------------------------------------------------------------*

//Local aRet       := {}
Local nxPerRED   := 1
Local nxICMPCO   := nxPERICMS
Local nxBasDif   := 0
Local nxValDif   := 0
Local nScTrib    := 0
Local nxICMDif   := 0
Local nxEqui     := 0
Local nValRedEQV := 0
Local nIcmPres   := 0
Local nICMCalc   := 0
Local nPerICMPre := 0
Local nPerICMMax := 0
Local nPerICMMin := 0
Local nBasCalcICM:= 0

nxDespICM := Iif(Empty(nxDespICM),0,nxDespICM)
nxDespIMP := Iif(Empty(nxDespIMP),0,nxDespIMP)

If !Empty(cxNCM)
	SYD->(dbSetOrder(1))
	If SYD->(dbSeek(xFilial("SYD")+cxNCM+cxEX))
		nxPerII  := SYD->YD_PER_II/100
		nxPerIPI := SYD->YD_PER_IPI/100
		nxPerPIS := SYD->YD_PER_PIS/100
		nxPerCOF := SYD->(YD_PER_COF+YD_MAJ_COF)/100
		nxPERICMS:= SYD->YD_ICMS_RE/100
	EndIf
EndIf

nxBaseII   := nxCIF+nxDespIMP
nxII       := nxBaseII*nxPerII
nxBaseIPI  := nxBaseII+nxII
nxIPI      := nxBaseIPI*nxPerIPI

*************************************************************************************************
// nFatX :=(1+ALIQ ICMS*(ALIQ II + ALIQ IPI * (1+ ALIQ II )))/((1-ALIQ PIS - ALIQ COF)*(1-ALIQ ICMS))
*************************************************************************************************

nFatX := (1+nxPERICMS*(nxPerII + nxPerIPI * (1+ nxPerII )))/((1-nxPerPIS - nxPerCOF)*(1-nxPerICMS))

nxBaseIC   := ((nxBaseII+nxII+nxIPI)/(1-nxICMPCO))*nxICMPCO
nxBasePCOF := (nxBaseII+nxBaseIC)/(1-(nxPerPIS+nxPerCof))//*(-1)

nxPIS      := (nxCIF*nFatX) * nxPerPIS //nxBasePCOF*nxPerPIS
nxCOFINS   := (nxCIF*nFatX) * nxPerCOF //nxBasePCOF*(nxPerCOF)

*************************************************************************************************
//BASE ICM =((CIF + VALOR II + VALOR IPI + VALOR PIS + VALOR COF)/(1-ALIQ ICMS))
*************************************************************************************************
nxBaseICMS := nxBaseII+nxII+nxIPI+nxPIS+nxCOFINS //+nxDespICM
nBasCalcICM:= (nxBaseICMS/((1-nxPERICMS)/100)/100)
nICMCalc   := nBasCalcICM*nxPERICMS
nxBaseICMS := ((nxBaseICMS*nxPerRED)/((1-nxPERICMS)/100)/100)
nxICMS     := nxBaseICMS*nxPERICMS

aRet := {nxBaseII,nxII,nxBaseIPI,nxIPI,nxBasePCOF,nxPIS,nxCOFINS,nxBaseICMS,nxICMS}

Return(aRet)




Static Function xParc(cFil,cPrefixo,cNum,cTipo,cFornece,cLoja)

Local aArea   	:= GetArea()
Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local cParc		:= ""
Local nParc		:= ""
Local cParcela	:= Chr(Asc(GetMV("MV_1DUP"))-1)
Local nTamParc	:= TAMSX3("E2_PARCELA")[1]

cQry	:= " SELECT MAX(E2_PARCELA) ULTPARC FROM SE2010 WHERE D_E_L_E_T_ = ' '
cQry	+= " AND E2_FILIAL = '"+cFil+"'
cQry	+= " AND E2_PREFIXO = '"+cPrefixo+"'
cQry	+= " AND E2_NUM = '"+cNum+"'
cQry	+= " AND E2_TIPO = '"+cTipo+"'
cQry	+= " AND E2_FORNECE = '"+cFornece+"'
cQry	+= " AND E2_LOJA = '"+cLoja+"'
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias  ,.F.,.T.)

//nParc	:= val(RetAsc((cAlias)->ULTPARC,1,.F.))+1
//cParc	:= RetAsc(alltrim(str(nParc)),1,.T.)


cParc:= Soma1((cAlias)->ULTPARC,nTamParc, .T. )

(cAlias)->(dbCloseArea())

RestArea(aArea)

Return(cParc)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AVFLUXO_RDMºAutor  ³Microsiga           º Data ³  08/30/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AvExistHist(cFil,cPrefixo,cTipo,cFornece,cLoja,cHistorico)
Local aArea   	:= GetArea()
Local cAlias	:= GetNextAlias()
Local cQry		:= ""




cQry	:= " SELECT SE2.R_E_C_N_O_ RecSE2" 
cQry	+= " FROM "+RetSqlname("SE2")+" SE2 "
cQry	+= " WHERE E2_FILIAL = '"+cFil+"'
cQry	+= " AND E2_PREFIXO = '"+cPrefixo+"'
cQry	+= " AND E2_TIPO = '"+cTipo+"'
cQry	+= " AND E2_FORNECE = '"+cFornece+"'
cQry	+= " AND E2_LOJA = '"+cLoja+"'
cQry	+= " And E2_HIST='"+cHistorico+"'"
cQry	+= " And E2_ORIGEM='SIGAEIC'"
cQry	+= " AND D_E_L_E_T_ = ' '"

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias  ,.F.,.T.)

Do While (cAlias)->(!Eof())
	SE2->(DbGoTo(  (cAlias)->RecSE2 ) )
	SE2->(RecLock("SE2",.F.))
	SE2->(DbDelete())
	SE2->(MsUnlock())	
	(cAlias)->(DbSkip())
EndDo


(cAlias)->(dbCloseArea())

RestArea(aArea)

Return
