
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO6     �Autor  �Microsiga           � Data �  12/29/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Grava os valores do custo gerencial no acols              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MC030PRJ()
Local cAliasTmp	:=ParamIxb[1]
//Custo medio gerencial Brasil
aCols[ Len(aCols),GdFieldPos('CMVUNITBR') ]:=(cAliasTmp)->CMEDIOGBR
aCols[ Len(aCols),GdFieldPos('CMVTOTBR') ] :=(cAliasTmp)->CTOTALGBR
//aCols[ Len(aCols),GdFieldPos('CMQUANTBR') ] :=KDX->CQUANTBR

//Custo medio gerencial Price Protection
aCols[ Len(aCols),GdFieldPos('CMVUNIT') ]:=(cAliasTmp)->CMEDIOG
aCols[ Len(aCols),GdFieldPos('CMVTOT') ] :=(cAliasTmp)->CTOTALG
//aCols[ Len(aCols),GdFieldPos('CMQUANT') ] :=KDX->CQUANT

Return( Nil )
               
