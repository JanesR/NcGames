#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NFatr02  บ Autor ณ Reinaldo Caldas    บ Data ณ  02/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao de Etiquetas NC Games.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NETIEMB
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
Private nomeprog    := "NETIEMB" 
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
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.T.)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
   Return
Endif
nTipo := If(aReturn[4]==1,15,18)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  02/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
dbSelectArea(cString)
dbSetOrder(1)
dbSeek(xFilial()+mv_par01+mv_par03)                                                   
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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

	cPed	:= getadvfval("SD2","D2_PEDIDO",xFilial("SD2")+SF2->(F2_DOC+F2_SERIE),3,"")
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
	If Posicione("SC5",1,xFilial("SC5")+SD2->D2_PEDIDO,"C5_XECOMER")=="C"
		U_COM05EndEnt(SD2->D2_PEDIDO,@xEND_CLI,@xBAIRRO,@xCEP_CLI,@xMunic,@xEstado)
	EndIf
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
	SZ7->Z7_USUARIO	:= Upper(Substr(cUsuario,7,15)) 
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
			SZ3->Z3_EMISSOR := Upper(Substr(cUsuario,7,15))
			MsUnlock()
		EndIF		
    Next
    For _j:=1 To mv_par04
        dbSelectArea("SZ3")
        dbSetOrder(1)
        dbSeek(xFilial("SZ3") + xNum_NF + xSerie + Alltrim(Strzero(_j,2)) )
		MSCBBEGIN(1,6,85)
		MSCBBOX(05,02,99,78,5)
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
		MSCBSAY(07,56,_cTransp,"N","0","025,030")
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
		MSCBSAY(07,64,cEmp,"N","0","085,060")
		MSCBSAY(07,74,cTEL,"N","A","015,008")
//		MSCBSAY(07,86,".","N","A","015,008")
//		MSCBSAY(07,64,"NC ","N","0","085,060")
//		MSCBSAY(07,74,"F.:(0xx11) 2236-1157","N","A","015,008")
		MSCBSAYBAR(50,64,xNUM_NF,"N","C",10,.F.,.T.,.F.)
		MSCBEND() //Fim da imagem da etiqueta
		SZ3->(dbSkip())
   	Next _j	   	
	dbSelectArea("SF2")
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo
MSCBCLOSEPRINTER()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SET DEVICE TO SCREEN
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif
MS_FLUSH()
Return
