#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F340LIBT  �Autor  �Microsiga           � Data �  08/22/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � N�o permite compensa��o de titulos nao liberados            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F340LIBT()
Local lRetorno:=.T.
Local cBloquear :=AllTrim(U_MyNewSX6(	"NCG_000066","S"		,"C","Bloquear Compensa��es de Fornecedores Diferentes","","",.F. ))

If IsInCallStack("FA340TIT") .And. MV_PAR02==2  .And. cBloquear=="S"	
	MsgInfo("Bloqueado pela �rea Contabil Compensa��es de Forneceedores Diferentes."+CRLF+"Ser� filtrado somente titulo(s) do fornecedor "+cFornece+".")
	MV_PAR03:=cFornece
	MV_PAR04:=cFornece
EndIf 
                         

Return lRetorno