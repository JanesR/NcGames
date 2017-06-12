#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MS520DEL  �Autor  � 				     � Data �  17/10/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada na exclusao da nota de saida               ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MS520DEL()
Local nInd
Local aPedidos:=U_D2520GetPV()
Local nRecPZ1

If SF2->( U_M001TemNF(xFilial("SF2"),F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,@nRecPZ1) )
	PZ1->(DbGoTo(nRecPZ1))
	PZ1->(RecLock("PZ1"))
	PZ1->PZ1_EXCLPV:="S"
	PZ1->(MsUnLock())
	
	
	StartJob("U_NCGJ001", GetEnvServer(), .F. , {cEmpAnt, cFilAnt, "ESTORNA_LIBERACAO_DESTINO", .T. })
	
	
	
	
	
EndIf



U_D2520IniPv()
Return
