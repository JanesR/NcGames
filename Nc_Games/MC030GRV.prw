
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO6     �Autor  �Microsiga           � Data �  12/29/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MC030GRV()

Local aTrbP:=ParamIxb[3]

//Custo gerencial Brasil
KDX->CMEDIOGBR	:=	aTrbP[14]
KDX->CTOTALGBR 	:=	aTrbP[15]
//KDX->CQUANTBR 	:=	aTrbP[16]

//Custo gerencial PP                   
KDX->CMEDIOG	:=aTrbP[17]
KDX->CTOTALG	:=aTrbP[18]
//KDX->CQUANT	:=aTrbP[20]

Return( Nil )
