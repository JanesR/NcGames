
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

//Custo medio gerencial Brasil
aCols[ Len(aCols),GdFieldPos('CMVUNITBR') ]:=KDX->CMEDIOGBR
aCols[ Len(aCols),GdFieldPos('CMVTOTBR') ] :=KDX->CTOTALGBR
//aCols[ Len(aCols),GdFieldPos('CMQUANTBR') ] :=KDX->CQUANTBR

//Custo medio gerencial Price Protection
aCols[ Len(aCols),GdFieldPos('CMVUNIT') ]:=KDX->CMEDIOG
aCols[ Len(aCols),GdFieldPos('CMVTOT') ] :=KDX->CTOTALG
//aCols[ Len(aCols),GdFieldPos('CMQUANT') ] :=KDX->CQUANT

Return( Nil )
               
