#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � MA261LIN �Autor  � CARLOS N. PUERTA   � Data �  Jul/2011   ���
�������������������������������������������������������������������������͹��
���Desc.     � PONTO DE ENTRADA UTILIZADO NA TROCA DE LINHA DA            ���
���			 � TRANSFERENCIA (MOD.2)                                      ���
���			 �                                                      	  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MA261LIN()
Local _aArea    := GetArea()
Local _aAreaZ0 := SZ0->(GetArea())
Local clExcArmz	:= AllTrim(U_MyNewSX6("NC_WMSEXEC","51"		,"C","Armaz�ns de exce��o do WMS "	,"","",	.F. ))
Local cLocalOrig
Local cLocalDest
Private _lRet        := .T.
Private _nPosOrigLoc := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="D3_LOCAL"})
Private _nPosDestLoc := 9

If AllTrim(FunName()) == "MOVIM351" .Or. lAutoma261
    RestArea(_aArea)
    Return(_lRet)
EndIf
//
//  Verifica se LOCAL ORIGEM e LOCAL DESTINO estao cadastrados no SZ0 para impossibilitar transferencia.
//
cLocalOrig  :=aCols[N,_nPosOrigLoc]
cLocalDest	:=aCols[N,_nPosDestLoc]

If cLocalOrig$clExcArmz
	cLocalOrig:="__"
EndIf	

If cLocalDest$clExcArmz
	cLocalOrig:="__"
EndIf	

SZ0->(dbSetOrder(3))            // Z0_FILIAL+Z0_ARM+Z0_ARMDEST
If SZ0->(dbSeek(xFilial("SZ0")+cLocalOrig+cLocalDest)) 
	Alert("Transferencias entre esses armazens s� podem ser realizadas no WMAS.")
	_lRet := .F.
EndIf

RestArea(_aAreaZ0)
RestArea(_aArea)
Return(_lRet)
