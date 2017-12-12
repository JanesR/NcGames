#INCLUDE "rwmake.ch"
#INCLUDE "TopConn.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NFatr02W  � Autor � Reinaldo Caldas    � Data �  02/11/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Impressao de Etiquetas NC Games.                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function NFatr02W

Private cString     := "SF2"
Private cPerg       := "FATR02"
If Pergunte(cPerg,.T.)
	dbSelectArea("SF2")
	dbSetOrder(1)

	Processa( {|| RunEtiq() } )
//RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)


EndIf

Return
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  02/11/04   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function RunEtiq

Local nOrdem

dbSelectArea(cString)
dbSetOrder(1)
dbSeek(xFilial()+mv_par01+mv_par03)                                                   
//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������

ProcRegua(RECCOUNT()) // Numero de registros a processar

While !eof() .and. SF2->F2_DOC <= mv_par02 

	incproc()

	xNUM_NF  := SF2->F2_DOC			// Numero
	xSERIE   := SF2->F2_SERIE		// Serie
	xEMISSAO := SF2->F2_EMISSAO		// Data de Emissao
	xCliente := SF2->F2_CLIENTE		// CODIGO DO CLIENTE
	xLOJA    := SF2->F2_LOJA		// Loja do Cliente
	xTRANSP	 := SF2->F2_TRANSP		// TRANSPORTADORA
	xQtVolume:= SF2->F2_VOLUME1
	dbSelectArea("SZ3")
	dbSetOrder(1)

	//SE JA TIVER SIDO EMITIDO A ETIQUETA, � NECESS�RIO CANCELAR PRIMEIRO
	IF dbSeek(xFilial("SZ3")+xNum_NF+xSerie)
		MSGBOX("Romaneio j� confirmado!!! Cancele o registro de confirma��o do romaneio para realizar a opera��o.","ATEN��O","alert")
		Return
	EndIf

    dbSelectArea("SA1")
    dbSetOrder(1)
    dbSeek(xFilial()+xCliente+xLoja)
    xEND_CLI := SA1->A1_ENDENT
    xBAIRRO  := SA1->A1_BAIRROE
    xCEP_CLI := SA1->A1_CEPE
    xNReduz  := SA1->A1_NOME
    xMunic   := SA1->A1_MUNE
    xEstado  := SA1->A1_ESTE

    dbSelectArea("SD2")                   
    dbSetOrder(3)
    dbSeek(xFilial()+xNUM_NF+xSERIE)
   	cPedAtu  := SD2->D2_PEDIDO
    cItemAtu := SD2->D2_ITEMPV

    dbSelectArea("SA4")
    dbSetOrder(1)
    dbSeek(xFilial()+SF2->F2_TRANSP)
    _cTransp := Alltrim(SA4->A4_NOME)

	//Busca o n�mero do romaneio no WMS
	_cQryWMS := " SELECT ROM.CODIGOROMANEIO CODROM, ROM.NUMEROROMANEIO FROM WMAS.ROMANEIO ROM "
	_cQryWMS += " WHERE ROM.TIPOROMANEIO = 'S' "
	_cQryWMS += " AND ROM.NUMEROROMANEIO = '"+cPedAtu+"' "
	_cQryWMS := ChangeQuery(_cQryWMS)
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	TCQUERY _cQryWMS New Alias "TRWM"
	
	nCodRom	:= TRWM->CODROM
	TRWM->(dbclosearea())
	If empty(nCodRom)
		alert("N�o existe romaneio no WMS. N�o ser� confirmado o romaneio para a NF: "+xNUM_NF)
		dbSelectArea("SF2")
		dbSkip() // Avanca o ponteiro do registro no arquivo
		loop
	ElseIf xQtVolume == 0
		alert("N�o ser� confirmado o romaneio da NF "+xNUM_NF+"."+chr(13)+" Quantidade de volumes igual a 0 no WMS")
		dbSelectArea("SF2")
		dbSkip() // Avanca o ponteiro do registro no arquivo	
		loop
	EndIf
	If !msgyesno("Confirma rela��o Nota fiscal x romaneio?"+chr(13)+"NF: "+xNUM_NF+chr(13)+"Romaneio: "+alltrim(str(nCodRom))+chr(13)+"com "+alltrim(str(xQtVolume))+" volumes")
		alert("Romaneio n�o confirmado!")
		dbSelectArea("SF2")
		dbSkip() // Avanca o ponteiro do registro no arquivo	
		loop
	EndIf

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
		SZ1->Z1_QTDVOL  := xQtVolume //MV_PAR04
		SZ1->Z1_ROMANEI := nCodRom
		MsUnlock()
	EndIF	

    For _i:=1 To xQtVolume //mv_par04
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
			SZ3->Z3_ROMANEI := nCodRom
			MsUnlock()
		EndIF		
    Next
    
	dbSelectArea("SF2")
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo

Return