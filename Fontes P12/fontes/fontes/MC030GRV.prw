
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

Local aTrbP		:=ParamIxb[3]
Local cAliasTmp	:=ParamIxb[1]
//Custo gerencial Brasil
(cAliasTmp)->CMEDIOGBR	:=	aTrbP[14]
(cAliasTmp)->CTOTALGBR 	:=	aTrbP[15]
//KDX->CQUANTBR 	:=	aTrbP[16]

//Custo gerencial PP                   
(cAliasTmp)->CMEDIOG	:=aTrbP[17]
(cAliasTmp)->CTOTALG	:=aTrbP[18]
//KDX->CQUANT	:=aTrbP[20]

Return( Nil )
