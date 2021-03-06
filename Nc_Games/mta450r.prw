#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MTA450R   �Autor  �Rodrigo Okamoto    � Data �  11/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MTA450R()

Local aArea		:= GetArea()
Local cPed		:= SC9->C9_PEDIDO

Private cCliAtu	:= SC9->C9_CLIENTE
Private cLojaAtu:= SC9->C9_LOJA
Private	cObsfin	:= space(354)
Private cTexto	:= ""
Private dData	:= ctod("  /  /  ")

//// LIMPA A LEGENDA QUANDO O PEDIDO � REJEITADO
dbSelectArea("SA1")
dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
dbseek(xFilial("SA1")+cCliAtu+cLojaAtu)
RECLOCK("SA1",.F.)
SA1->A1_YLEGEND := ""
MSUNLOCK()
////////////////////////////////////////////////////////////////////////////////////

DbSelectArea("SZR")
DbSetOrder(1)
If DbSeek(xFilial("SZR")+SC9->C9_PEDIDO)
	While !eof() .and. SC9->C9_PEDIDO == SZR->ZR_PEDIDO
		If SZR->ZR_TIPO == "2" .AND. SZR->ZR_DTOCORR == DDATABASE
			//se j� foi registrada a rejei��o, n�o abrir� novamente a tela para digita��o do motivo
			RestArea(aArea)
			Return
		EndIf
		SZR->(DbSkip())
	End
EndIf

@ 100,001 To 550,800 Dialog oDlg Title "Rejei��o do cr�dito do cliente: " + SA1->A1_NOME + " " + cCliAtu+" / "+cLojaAtu
//@ 003,010 To 375,500
@ 014,014 Say OemToAnsi("Descreva o motivo da rejei��o do cr�dito")
@ 034,014 Get cObsfin PICTURE "@e" Size 300,10 valid naovazio()
@ 054,014 Say OemToAnsi("Informa��es Adicionais Cr�dito")
@ 074,010 GET cTexto   Size 300,080  MEMO                // Object oMemo
//@ 160,014 Say OemToAnsi("Data Limite?")
//@ 180,014 Get dData Size 50,10 valid naovazio()

@ 204,130 BMPBUTTON TYPE 01 ACTION ObsFin()
//@ 204,160 BmpButton Type 02 Action Close(oDlg)
Activate Dialog oDlg Centered

RestArea(aArea)

Return


/*
//���������������������������������������������������������Ŀ
//�Bloco para execu��o das observa��es da analise do cr�dito�
//�����������������������������������������������������������
*/

Static Function ObsFin

Local aAreaSC5:= SC5->(getarea())
Local cVend1	:= ""

cTMPPeds	:= ""

Begin Transaction

If Funname() == "MATA450A"
	
	DbSelectArea("TMP")
	DbGotop()
	While !eof()
		
		RECLOCK("TMP",.F.)
		TMP->C5_YOBSFIN	:= cObsfin
		TMP->C5_YTEMOBS	:= "3"
		MSUNLOCK()
		cTMPPeds	+= " "+TMP->C5_NUM+","
		
		DbSelectArea("SC5")
		DbSetOrder(1)
		If DbSeek(xFilial("SC5")+TMP->C5_NUM)
			cVend1	:= SC5->C5_VEND1
			//		alert(cObsfin)
			RECLOCK("SC5",.F.)
			SC5->C5_YOBSFIN	:= cObsfin
			SC5->C5_YTEMOBS	:= "3"
			SC5->C5_YFINOBS	:= cTexto
			MSUNLOCK()
			
			//Realiza a grava��o na tabela de ocorr�ncias da analise do cr�dito
			DbSelectArea("SZR")
			SET FILTER TO SZR->ZR_FILIAL+SZR->ZR_PEDIDO == xFilial("SZR")+TMP->C5_NUM
			DbSetOrder(1)
			If DbSeek(xFilial("SZR")+TMP->C5_NUM)
				While !eof() .and. TMP->C5_NUM == SZR->ZR_PEDIDO
					cSequen	:= SZR->ZR_ITEM
					SZR->(DbSkip())
				End
				cSequen := SOMA1(cSequen)
			Else
				cSequen	:= "000001"
			EndIf
			
			RECLOCK("SZR",.T.)
			SZR->ZR_FILIAL	:= xFilial("SZR")
			SZR->ZR_ITEM	:= cSequen
			SZR->ZR_PEDIDO	:= TMP->C5_NUM
			SZR->ZR_TEXTO	:= cObsfin
			//		SZR->ZR_DTLIMIT	:= dData
			SZR->ZR_DTOCORR	:= dDatabase
			SZR->ZR_HORA	:= Time()
			SZR->ZR_INFADIC := cTexto
			SZR->ZR_TIPO 	:= "2"
			SZR->ZR_CLIENTE := TMP->C5_CLIENTE
			SZR->ZR_LOJA	:= TMP->C5_LOJACLI
			SZR->ZR_USER	:= cUsername
			MSUNLOCK()
			SET FILTER TO
			SZR->(DBCLOSEAREA())
			
		EndIf
		
		DbSelectArea("TMP")
		DbSkip()
	End
	
Else
	cTMPPeds	:= SC9->C9_PEDIDO+","
	DbSelectArea("SC5")
	DbSetOrder(1)
	If DbSeek(xFilial("SC5")+SC9->C9_PEDIDO)
		cVend1	:= SC5->C5_VEND1
		//		alert(cObsfin)
		RECLOCK("SC5",.F.)
		SC5->C5_YOBSFIN	:= cObsfin
		SC5->C5_YTEMOBS	:= "3"
		SC5->C5_YFINOBS	:= cTexto
		MSUNLOCK()
	EndIf
	
	//Realiza a grava��o na tabela de ocorr�ncias da analise do cr�dito
	DbSelectArea("SZR")
	SET FILTER TO SZR->ZR_FILIAL+SZR->ZR_PEDIDO == xFilial("SZR")+SC9->C9_PEDIDO
	DbSetOrder(1)
	If DbSeek(xFilial("SZR")+SC9->C9_PEDIDO)
		While !eof() .and. SC9->C9_PEDIDO == SZR->ZR_PEDIDO
			cSequen	:= SZR->ZR_ITEM
			SZR->(DbSkip())
		End
		cSequen := SOMA1(cSequen)
	Else
		cSequen	:= "000001"
	EndIf
	
	RECLOCK("SZR",.T.)
	SZR->ZR_FILIAL	:= xFilial("SZR")
	SZR->ZR_ITEM	:= cSequen
	SZR->ZR_PEDIDO	:= SC9->C9_PEDIDO
	SZR->ZR_TEXTO	:= cObsfin
	//		SZR->ZR_DTLIMIT	:= dData
	SZR->ZR_DTOCORR	:= dDatabase
	SZR->ZR_HORA	:= Time()
	SZR->ZR_INFADIC := cTexto
	SZR->ZR_TIPO 	:= "2"
	SZR->ZR_CLIENTE := SC9->C9_CLIENTE
	SZR->ZR_LOJA	:= SC9->C9_LOJA
	SZR->ZR_USER	:= cUsername
	MSUNLOCK()
	SET FILTER TO
	SZR->(DBCLOSEAREA())
	
EndIf
//QUANDO FOR IMPLANTAR EM AMBIENTE OFICIAL, SUBSTITUIR A LINHA DO E-MAIL cTO
//cTO	 := getadvfval("SA3","A3_EMAIL",xFilial("SA3")+cVend1,1,"")
cTO	 := Posicione("SA3",1,xFilial("SA3")+cVend1,"A3_EMAIL")
//cTO	 := "pcesar@ncgames.com.br;halves@ncgames.com.br"
cCC	 := ""
cBCC	 := ""

DbSelectArea("ZC5")
DbSetOrder(2)

If DbSeek(xFilial("ZC5")+SC9->C9_PEDIDO)
	IF AllTrim(ZC5->ZC5_COND) == "FAT" .And. AllTrim(ZC5->ZC5_CODPAG) == "54" .And. AllTrim(ZC5->ZC5_NUMPV) != ""
		cSUBJECT := "[NC GAMES] Rejei��o de Cr�dito do cliente: "+alltrim(posicione("SA1",1,xFilial("SA1")+cCliAtu+cLojaAtu,"A1_NOME"))+"( "+cCliAtu+"/"+cLojaAtu+" ) - E-Commerce Faturado"
		cBODY	:= "Pedidos rejeitados pelo cr�dito: "+ AllTrim(Str(ZC5->ZC5_NUM)) +"\" +substr(cTMPPeds,1,len(cTMPPeds)-1)+chr(13)+chr(10)+chr(13)+chr(10)
		cBODY	+= "Prezado Vendedor: "+getadvfval("SA3","A3_NOME",xFilial("SA3")+cVend1,1,"")+","+chr(13)+chr(10)+"Os pedidos informados foram rejeitados pelo departamento de cr�dito:"+chr(13)+chr(10)+chr(13)+chr(10)
		cBODY	+= alltrim(cObsfin)+chr(13)+chr(10)+ctexto+chr(13)+chr(10)+chr(13)+chr(10)
		cBODY	+= "Esta notifica��o tamb�m est� dispon�vel para visualiza��o no monitor de pedidos."
		//cBODY	+= "Data limite para retorno das informa��es: "+dtoc(dData)
		aFiles	:= {}
		/*Else
		cSUBJECT := "[NC GAMES] Rejei��o de Cr�dito do cliente: "+alltrim(posicione("SA1",1,xFilial("SA1")+cCliAtu+cLojaAtu,"A1_NOME"))+"( "+cCliAtu+"/"+cLojaAtu+" )"
		cBODY	:= "Pedidos rejeitados pelo cr�dito: "+substr(cTMPPeds,1,len(cTMPPeds)-1)+chr(13)+chr(10)+chr(13)+chr(10)
		cBODY	+= "Prezado Vendedor: "+getadvfval("SA3","A3_NOME",xFilial("SA3")+cVend1,1,"")+","+chr(13)+chr(10)+"Os pedidos informados foram rejeitados pelo departamento de cr�dito:"+chr(13)+chr(10)+chr(13)+chr(10)
		cBODY	+= alltrim(cObsfin)+chr(13)+chr(10)+ctexto+chr(13)+chr(10)+chr(13)+chr(10)
		cBODY	+= "Esta notifica��o tamb�m est� dispon�vel para visualiza��o no seu pedido de vendas."
		//cBODY	+= "Data limite para retorno das informa��es: "+dtoc(dData)
		aFiles	:= {}	*/
	EndIf
Else
	cSUBJECT := "[NC GAMES] Rejei��o de Cr�dito do cliente: "+alltrim(posicione("SA1",1,xFilial("SA1")+cCliAtu+cLojaAtu,"A1_NOME"))+"( "+cCliAtu+"/"+cLojaAtu+" )"
	cBODY	:= "Pedidos rejeitados pelo cr�dito: "+substr(cTMPPeds,1,len(cTMPPeds)-1)+chr(13)+chr(10)+chr(13)+chr(10)
	cBODY	+= "Prezado Vendedor: "+getadvfval("SA3","A3_NOME",xFilial("SA3")+cVend1,1,"")+","+chr(13)+chr(10)+"Os pedidos informados foram rejeitados pelo departamento de cr�dito:"+chr(13)+chr(10)+chr(13)+chr(10)
	cBODY	+= alltrim(cObsfin)+chr(13)+chr(10)+ctexto+chr(13)+chr(10)+chr(13)+chr(10)
	cBODY	+= "Esta notifica��o tamb�m est� dispon�vel para visualiza��o no seu pedido de vendas."
	//cBODY	+= "Data limite para retorno das informa��es: "+dtoc(dData)
	aFiles	:= {}
EndIf
End Transaction



Close(oDlg)


If AllTrim(SC5->C5_YORIGEM)=="WM"
	U_WM001Cred("R")
Else
	u_ENVIAEMAIL(cTO, cCC, cBCC, cSUBJECT, cBODY, aFiles)
	alert("E-mail de notifica��o enviado para: "+cTO)
EndIf

RestArea(aAreaSC5)
Return

