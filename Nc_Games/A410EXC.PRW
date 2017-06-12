#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A410EXC   ºAutor  ³Microsiga           º Data ³  10/29/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para excluir a RESERVA (SC0) na exclusao  º±±
±±º          ³ do PEDIDO DE VENDA (SC5 e SC6).                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function A410EXC()      

Local aAreaSC5 := SC5->(GetArea())
Local _cCondPag := M->C5_CONDPAG 
Local lCondPag := AllTrim(_cCondPag) $ AllTrim(SuperGetMv("MV_NCRESER",.F.,""))

Private _aArea    := GetArea()
Private _aAreaC0  := {}
Private _aAreaB2  := {}
Private _lRet     := .T.
Private _lReserva := .T.
 
If _lRet
	If lCondPag .And. M->C5_XSTAPED == "15"
		Private _nI := 0
		For _nI := 1 To Len(aCols)
			Private _cProduto  := ACOLS[_nI][aScan(AHEADER,{|e|Trim(e[2])=="C6_PRODUTO"})]
			Private _cLocal    := ACOLS[_nI][aScan(AHEADER,{|e|Trim(e[2])=="C6_LOCAL"})]
			Private _nQtdVen   := ACOLS[_nI][aScan(AHEADER,{|e|Trim(e[2])=="C6_QTDVEN"})]
			If !(ACOLS[_nI,Len(aHeader) + 1])
				dbSelectArea("SC0")
				_aAreaC0 := GetArea()
				dbSetOrder(1)             // C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
				If dbSeek(xFilial("SC0")+M->C5_NUM+_cProduto+_cLocal)
					RecLock("SC0",.F.)
					dbDelete()
					MsUnlock()
					
					dbSelectArea("SB2")
					_aAreaB2 := GetArea()
					dbSetOrder(1)
					If ( !MsSeek(xFilial("SB2")+_cProduto+_cLocal) )
						Help(" ",1,"A430LOCAL")
						_lRet := .T.
					Else
						RecLock("SB2",.F.)
						SB2->B2_RESERVA := SB2->B2_RESERVA - _nQtdVen
						MsUnlock()
					EndIf
					RestArea(_aAreaB2)
				EndIf
			EndIf
		Next
		U_NC110Mail()
	EndIf
EndIf

	RestArea(aAreaSC5)
//
//    VENDAAVISTA - FIM
//                     

RestArea(_aArea)
Return(_lRet)
