#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCAWFPFV		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina para cadastro dos e-mail a serem enviados por WF	  ���
���          � referente os pedidos faturados sem agendmaneto por 		  ���
���          � vendedor													  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCAWFPFV()

Local aArea := GetArea()

Private cCadastro	:= "E-mail para envio do WF (PV faturado sem agendamento)"


AxCadastro( "PZG", cCadastro)

RestArea(aArea)
Return