#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MT260TOK �Autor  � CARLOS N. PUERTA   � Data �  Jul/2011   ���
�������������������������������������������������������������������������͹��
���Desc.     � PONTO DE ENTRADA UTILIZADO NO OK DA TRANSFERENCIA (MOD.1)  ���
���			 �                                                       	  ���
���			 �                                                      	  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT260TOK()
Private _aArea    := GetArea()
Private _aAreaZ0  := {}
Private _lRet     := .T.
Private _cNumSeq  := "0000000000"

If AllTrim(FunName()) == "MOVIM351"
    RestArea(_aArea)
    Return(_lRet)
EndIf
//
//  Verifica se LOCAL ORIGEM e LOCAL DESTINO estao cadastrados no SZ0 para impossibilitar transferencia.
//
dbSelectArea("SZ0")
_aAreaZ0 := GetArea()
dbSetOrder(3)            // Z0_FILIAL+Z0_ARM+Z0_ARMDEST
If dbSeek(xFilial("SZ0")+cLocOrig+cLocDest)
	Alert("Transferencias entre esses armazens s� podem ser realizadas no WMAS.")
	_lRet := .F.
EndIf
RestArea(_aAreaZ0)
 
RestArea(_aArea)
Return(_lRet)
