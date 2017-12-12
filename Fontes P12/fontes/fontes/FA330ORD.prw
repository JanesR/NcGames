#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA330ORD �Autor  �Microsiga           � Data �  07/29/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Ponto de Entrada permite alterar o indice que              �
���          �sera aplicado no Markbrowse                                 ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA330ORD
Local nRetorno	  :=IndexOrd() 	
Local cBloquear :=AllTrim(U_MyNewSX6(	"NCG_000065","S"		,"C","Bloquear Compensa��es de Clientes Diferentes","","",.F. ))


//Chamado 005963 Bloqueio nas Compensa��es de Clientes Diferentes
If MV_PAR02==2  .And. cBloquear=="S"	.And. (MV_PAR03<>cCliente .Or.  MV_PAR04<>cCliente)
	MsgInfo("Bloqueado pela �rea Contabil Compensa��es de Clientes Diferentes."+CRLF+"Ser� filtrado somente titulo(s) do cliente "+cCliente+".")
	MV_PAR03:=cCliente
	MV_PAR04:=cCliente
EndIf 


If nRetorno==0 .Or. nRetorno==Nil
	nRetorno:=1
EndIf	


Return  nRetorno