#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NFatr02  º Autor ³ Reinaldo Caldas    º Data ³  02/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao de Etiquetas NC Games.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NFatr02
Local cDesc1        := "Este programa tem como objetivo imprimir Etiquetas  "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Etiquetas de Despacho"
Local cPict         := ""
Local titulo        := "Etiquetas de Despacho"
Local nLin          := 81
Local Cabec1        := "Etiquetas de despacho"
Local Cabec2        := ""
Local imprime       := .T.
Local aOrd          := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "P"
Private nomeprog    := "NFatr02" 
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "NFatr02" 
Private cString     := "SF2"
Private cPerg       := "FATR02"
Pergunte(cPerg,.F.)
dbSelectArea("SF2")
dbSetOrder(1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.T.)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
   Return
Endif
nTipo := If(aReturn[4]==1,15,18)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  02/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
dbSelectArea(cString)
dbSetOrder(1)
dbSeek(xFilial()+mv_par01+mv_par03)                                                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())
MSCBPRINTER("S600","LPT1",,85,.F.,,,,)
MSCBCHKSTATUS(.F.) //.T. -- seta o controle de status do sistema com a impressora
While !eof() .and. SF2->F2_DOC <= mv_par02 

	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif

	xNUM_NF  := SF2->F2_DOC			// Numero
	xSERIE   := SF2->F2_SERIE		// Serie
	xEMISSAO := SF2->F2_EMISSAO		// Data de Emissao
	xCliente := SF2->F2_CLIENTE		// CODIGO DO CLIENTE
	xLOJA    := SF2->F2_LOJA		// Loja do Cliente
	xTRANSP	 := SF2->F2_TRANSP		// TRANSPORTADORA
	dbSelectArea("SZ3")
	dbSetOrder(1)
//SE JA TIVER SIDO EMITIDO A ETIQUETA, É NECESSÁRIO CANCELAR PRIMEIRO
   /*	IF dbSeek(xFilial("SZ3")+xNum_NF+xSerie)
		MSGBOX("ETIQUETA JA EMITIDA!!! CANCELE A ETIQUETA PARA GERAR UMA NOVA.","ATENÇÃO","alert")	
		Return 
	EndIf 
	cPed	:= getadvfval("SD2","D2_PEDIDO",xFilial("SD2")+SF2->(F2_DOC+F2_SERIE),3,"")
	lverwms := VerWMS(cPed)
	If lverwms
	// não imprime o romaneio caso o processo esteja no WMS
			Alert("Etiqueta não será impressa para a NF: "+SF2->F2_DOC+" pois se encontra no WMS!")
			dbSelectArea("SF2")
			dbSkip()
			loop
	EndIf  */

    dbSelectArea("SA1")
    dbSetOrder(1)
    dbSeek(xFilial()+xCliente+xLoja)
    xEND_CLI := SA1->A1_ENDENT
    xCOMPLEM := SA1->A1_COMPLEM
    xBAIRRO  := SA1->A1_BAIRROE
    xCEP_CLI := SA1->A1_CEPE
    xNReduz  := SA1->A1_NOME
    xMunic   := SA1->A1_MUNE
    xEstado  := SA1->A1_ESTE
    dbSelectArea("SD2")                   // * Itens de Venda da N.F.
    dbSetOrder(3)
    dbSeek(xFilial()+xNUM_NF+xSERIE)
	 cPedAtu  := SD2->D2_PEDIDO
    cItemAtu := SD2->D2_ITEMPV
    cVend1	:= getadvfval("SC5","C5_VEND1",XFILIAL("SC5")+cPedAtu,1,"")
    dbSelectArea("SA4")
    dbSetOrder(1)
    dbSeek(xFilial()+SF2->F2_TRANSP)
    _cTransp := Alltrim(SA4->A4_NOME)
    dbSelectArea("SZ1")	
    dbSetOrder(1)
    IF ! dbSeek(xFilial("SZ1")+xNum_NF+xSerie)
		Reclock("SZ1",.T.)
		SZ1->Z1_FILIAL  := XFILIAL("SZ1")
		SZ1->Z1_DOC     := xNum_NF
		SZ1->Z1_SERIE   := xSerie
		SZ1->Z1_CLIENTE := xCliente
		SZ1->Z1_LOJA    := xLoja
		SZ1->Z1_NOMECLI := xNReduz
		SZ1->Z1_PEDIDO  := cPedAtu
		SZ1->Z1_DTEMISS := dDatabase
		SZ1->Z1_HORAET  := TIME()   //Horario de Etiquetagem
		SZ1->Z1_QTDVOL  := MV_PAR04
		MsUnlock()
	EndIF
	dbSelectArea("SZ7")
	dbSetOrder(1)
	Reclock("SZ7",.T.)
	SZ7->Z7_FILIAL	:= XFILIAL("SZ7")
	SZ7->Z7_DOC		:= xNum_NF
	SZ7->Z7_SERIE	:= xSerie
	SZ7->Z7_CODCLI	:= xCliente
	SZ7->Z7_NUM		:= cPedAtu
	SZ7->Z7_STAT	:= "000012"
	SZ7->Z7_STATUS	:= "ETIQUETA DE NOTA FISCAL EMITIDA"
	SZ7->Z7_DATA	:= dDatabase
	SZ7->Z7_HORA	:= TIME()   //Horario de Etiquetagem
	SZ7->Z7_USUARIO	:= Upper(cUsername) 
	MsUnlock()	
    For _i:=1 To mv_par04
		xCodBar:=GetMv("MV_X_CBARR")
		dbSelectArea("SX6")
		PutMv("MV_X_CBARR",Strzero(xCodBar+1,6))
		dbSelectArea("SZ3")
		dbSetOrder(1)
		IF ! dbSeek(xFilial("SZ3")+xNum_NF+xSerie+Alltrim(Strzero(_i,2)))
			RecLock("SZ3",.T.)
			SZ3->Z3_FILIAL  := XFILIAL("SZ3")
			SZ3->Z3_ITEM    := Alltrim(Strzero(_i,2))
			SZ3->Z3_DOC     := xNum_NF
			SZ3->Z3_SERIE   := xSerie
			SZ3->Z3_CLIENTE := xCliente
			SZ3->Z3_LOJA    := xLoja
			SZ3->Z3_CODPACK := Alltrim(Strzero(xCodBar,6))
			SZ3->Z3_EMISSOR := Upper(cUsername)
			MsUnlock()
		EndIF		
    Next
    For _j:=1 To mv_par04
        dbSelectArea("SZ3")
        dbSetOrder(1)
        dbSeek(xFilial("SZ3") + xNum_NF + xSerie + Alltrim(Strzero(_j,2)) )
		MSCBBEGIN(1,6,85)
		MSCBBOX(05,02,101,78,5)
		MSCBLineH(05,15,101,3,"B")
		MSCBLineH(05,40,101,3,"B")
		MSCBLineH(05,51,101,3,"B")
		MSCBLineH(05,62,101,3,"B")
		MSCBLineV(48,02,15,3,"B")
		MSCBSAY(06,04,"NOTA FISCAL","N","A","015,008")
		MSCBSAY(49,04,"VOLUME","N","A","015,008")		
	    MSCBSAY(06,09,xNUM_NF,"N","0","055,060")
		MSCBSAY(49,08,Alltrim(Strzero(_j,3))+"/"+Alltrim(Strzero(mv_par04,3)),"N","0","055,060")
		MSCBSAY(06,16,"CLIENTE","N","A","015,008")
		MSCBSAY(06,20,Alltrim(xNReduz),"N","0","025,030")
		MSCBSAY(06,25,"ENDERECO DE ENTREGA","N","A","015,008")
		MSCBSAY(06,29,Alltrim(xEND_CLI),"N","0","025,030")
		MSCBSAY(06,33,Alltrim(xCOMPLEM),"N","0","025,030")
		MSCBSAY(06,37,"CEP: "+SUBSTR(xCEP_CLI,1,5)+"-"+SUBSTR(xCEP_CLI,6,3)+" "+ALLTRIM(xBAIRRO)+" "+ALLTRIM(xMunic)+" "+xEstado,"N","0","025,030")
		MSCBSAY(06,41,"OBSERVACOES","N","A","015,008")
		MSCBSAY(06,45,ALLTRIM(MV_PAR05),"N","0","025,030")
		MSCBSAY(06,52,"TRANSPORTADORA","N","A","015,008")
		MSCBSAY(34,52,xTRANSP,"N","A","015,008")
		MSCBSAY(06,56,_cTransp,"N","0","025,030")
	 
	 /* MSCBBOX(05,02,99,78,5)
		MSCBLineH(05,15,99,3,"B")
		MSCBLineH(05,40,99,3,"B")
		MSCBLineH(05,51,99,3,"B")
		MSCBLineH(05,62,99,3,"B")
		MSCBLineV(48,02,15,3,"B")
		MSCBSAY(07,04,"NOTA FISCAL","N","A","015,008")
		MSCBSAY(50,04,"VOLUME","N","A","015,008")		
	    MSCBSAY(07,09,xNUM_NF,"N","0","055,060")
		MSCBSAY(50,08,Alltrim(Strzero(_j,3))+"/"+Alltrim(Strzero(mv_par04,3)),"N","0","055,060")
		MSCBSAY(07,16,"CLIENTE","N","A","015,008")
		MSCBSAY(07,20,Alltrim(xNReduz),"N","0","025,030")
		MSCBSAY(07,25,"ENDERECO DE ENTREGA","N","A","015,008")
		MSCBSAY(07,29,Alltrim(xEND_CLI),"N","0","025,030")
		MSCBSAY(07,33,Alltrim(xCOMPLEM),"N","0","025,030")
		MSCBSAY(07,37,"CEP: "+SUBSTR(xCEP_CLI,1,5)+"-"+SUBSTR(xCEP_CLI,6,3)+" "+ALLTRIM(xBAIRRO)+" "+ALLTRIM(xMunic)+" "+xEstado,"N","0","025,030")
		MSCBSAY(07,41,"OBSERVACOES","N","A","015,008")
		MSCBSAY(07,45,ALLTRIM(MV_PAR05),"N","0","025,030")
		MSCBSAY(07,52,"TRANSPORTADORA","N","A","015,008")
		MSCBSAY(35,52,xTRANSP,"N","A","015,008")
		MSCBSAY(07,56,_cTransp,"N","0","025,030")*/ 
		
/*
		MSCBBEGIN(1,6,80)
		MSCBBOX(05,02,99,78,5)
		MSCBLineH(05,15,99,3,"B")
		MSCBLineH(05,40,99,3,"B")
		MSCBLineH(05,51,99,3,"B")
		MSCBLineH(05,62,99,3,"B")
		MSCBLineV(48,02,15,3,"B")
		MSCBSAY(07,04,"NOTA FISCAL","N","A","015,008")
		MSCBSAY(50,04,"VOLUME","N","A","015,008")		
	    MSCBSAY(07,08,xNUM_NF,"N","0","055,060")
		MSCBSAY(50,08,Alltrim(Strzero(_j,3))+"/"+Alltrim(Strzero(mv_par04,3)),"N","0","055,060")
		MSCBSAY(07,16,"CLIENTE","N","A","015,008")
		MSCBSAY(07,20,Alltrim(xNReduz),"N","0","025,030")
		MSCBSAY(07,25,"ENDERECO DE ENTREGA","N","A","015,008")
		MSCBSAY(07,29,Alltrim(xEND_CLI),"N","0","025,030")
		MSCBSAY(07,33,"CEP: "+SUBSTR(xCEP_CLI,1,5)+"-"+SUBSTR(xCEP_CLI,6,3)+" "+ALLTRIM(xBAIRRO)+" "+ALLTRIM(xMunic)+" "+xEstado,"N","0","025,030")
		MSCBSAY(07,41,"OBSERVACOES","N","A","015,008")
		MSCBSAY(07,45,ALLTRIM(MV_PAR05),"N","0","025,030")
		MSCBSAY(07,52,"TRANSPORTADORA","N","A","015,008")
		MSCBSAY(35,52,xTRANSP,"N","A","015,008")
		MSCBSAY(07,56,_cTransp,"N","0","025,030")
*/
///////////////////////////////
		If cVend1 == "VN9900"
			cA3TEL:= GETADVFVAL("SA3","A3_TEL",XFILIAL("SA3")+cVend1,1,"")
			cA3DDD:= GETADVFVAL("SA3","A3_DDDTEL",XFILIAL("SA3")+cVend1,1,"")
			cTEL	:= "(SAC) ("+ALLTRIM(cA3DDD)+")"+SUBSTRING(cA3TEL,1,4)+"-"+SUBSTRING(cA3TEL,5,4)
			cEmp	:= "STAR"
		Else 
			cTEL	:= "F.:(0xx11) 4095-3100"
			cEmp	:= "NC "
		EndIf
		MSCBSAY(06,64,cEmp,"N","0","085,060")
		MSCBSAY(06,74,cTEL,"N","A","015,008")
//		MSCBSAY(07,86,".","N","A","015,008")
//		MSCBSAY(07,64,"NC ","N","0","085,060")
//		MSCBSAY(07,74,"F.:(0xx11) 2236-1157","N","A","015,008")
		MSCBSAYBAR(49,64,xNUM_NF,"N","C",10,.F.,.T.,.F.)
		MSCBEND() //Fim da imagem da etiqueta
		SZ3->(dbSkip())
   	Next _j	   	
	dbSelectArea("SF2")
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo
MSCBCLOSEPRINTER()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif
MS_FLUSH()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VerWMS  ºAutor  ³Microsiga           º Data ³  02/17/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function VerWMS(cPed)

	_cPEDWMAS := " SELECT max(DOC.SEQUENCIAINTEGRACAO) DOCINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG "
	_cPEDWMAS += " WHERE DOC.NUMERODOCUMENTO = '"+cPed+"'"
	_cPEDWMAS += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "

	_cPEDWMAS := ChangeQuery(_cPEDWMAS)
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS New Alias "TRWM"
	
	dbSelectArea("TRWM")
	
	_cPEDWMAS1 := " SELECT INTEG.TIPOINTEGRACAO TIPINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG
	_cPEDWMAS1 += " WHERE DOC.SEQUENCIAINTEGRACAO = '"+STR(TRWM->DOCINT)+"' "
	_cPEDWMAS1 += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "
	
	_cPEDWMAS1 := ChangeQuery(_cPEDWMAS1)
	
	If Select("TRWM1") >0
		dbSelectArea("TRWM1")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS1 New Alias "TRWM1"
	
	dbSelectArea("TRWM1")

	IF TRWM1->TIPINT <> 251 .AND. TRWM1->TIPINT <> 0 .AND. TRWM->DOCINT <> 0 
	  //	MSGBOX("NÃO É PERMITIDO A ALTERAÇÃO DO PEDIDO POIS ESTÁ NO WMAS."+CHR(13)+"SOLICITE O ESTORNO AO DEPARTAMENTO DE EXPEDIÇÃO")
		lWMS:= .T.
	ELSE
		lWMS:= .F.	
	ENDIF				
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	If Select("TRWM1") >0
		dbSelectArea("TRWM1")
		dbCloseArea()
	Endif
	
Return(lWMS)
