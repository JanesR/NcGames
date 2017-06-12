#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P_MT440LIBºAutor  ³Aristoteles         º Data ³  14/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para validar o desconto cedido no PV.,    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MT440LIB()

Local _aArea       := GetArea()
Local _nQtdLib		:= SC6->C6_QTDVEN -  (SC6->C6_QTDEMP + SC6->C6_QTDENT) 

If SC5->C5_TIPO == "N" .AND. ALLTRIM(SC6->C6_TES) $ GetMv("MV_X_TES")
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(XFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI,.F.)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(XFilial("SB1")+SC6->C6_PRODUTO,.F.)
	
	DbSelectArea("SBM")
	DbSetOrder(1)
	DbSeek(XFilial("SBM")+SB1->B1_GRUPO,.F.)
	
	If SA1->A1_X_DESC <> 0
		_nVlrDesc := SA1->A1_X_DESC
	Else
		_nVlrDesc := SBM->BM_X_DESC
	EndIf
	
	_nVlrDescPed := 100 - ((SC6->C6_PRCVEN / SC6->C6_PRCTAB) * 100)
	
	If _nVlrDescPed <= _nVlrDesc .OR. UPPER(Alltrim(cUsername)) $ UPPER(GetMv("MV_NCUSRLB")) .or. _nVlrDesc == 0
		_nQtdLib := ( SC6->C6_QTDVEN - (SC6->C6_QTDEMP + SC6->C6_QTDENT ) )
		If Empty(SC6->C6_X_USRLB) .AND. SC6->C6_OP == '02' .AND. SC6->C6_QTDEMP > 0
			RecLock("SC6")
			SC6->C6_X_USRLB := UPPER(Alltrim(cUsername))
			MsUnLock()
		EndIf
	Else
		MsgBox("Desconto concedido no item "+SC6->C6_ITEM+" supera o limite permitido. Verifique.","PEDIDO BLOQUEADO","ALERT")
		_nQtdLib := 0
		RecLock("SC6")
		SC6->C6_X_USRLB := ""
		MsUnLock()
	EndIf
	
EndIf

RestArea(_aArea)

RETURN _nQtdLib

