#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M450ABRW  �Autor  �Microsiga  	        � Data �  09/04/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para filtro do Browse da rotina			 	  ���
���          �analise de credito de cliente MATA450A                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M450ABRW()
Local aArea 	:= GetArea()
Local cRetFil	:= ""
Local cQuery 	:= PARAMIXB[1]
Local lPvSite	:= IsInCallStack("U_ECAnCred")
Local cBloqLib :=AllTrim(U_MyNewSX6(	"NCG_000067", "S", "C", 	"Bloquear Liberacao do PV S=Sim ou N=Nao","","",	.F. ))
Local cCanUser	:=AllTrim(U_MyNewSX6(	"NCG_000068", "", "C", 	"ID do usuario com permissao de liberacao mesmo que o paramatro NCG_000067=S(separado por ;)","","",	.F. ))


If cBloqLib=="S" .And. !__cUserID$cCanUser
	MsgStop("Processo de libera��o bloqueado.","NcGames")
	cRetFil:=" And 1=2"//Retorno uma condicao falsa para n�o aparecer nenhum resgistro no Browse
Else	
	If lPvSite
		cRetFil	+=" AND SC5.C5_XECOMER = 'C' "
	Else
		cRetFil	+=" AND SC5.C5_XECOMER <> 'C' "
	EndIf
	
	cRetFil	+=" AND C9_FILIAL BETWEEN '  ' AND 'ZZ'"
	cRetFil	+=" AND C9_PEDIDO BETWEEN '      ' AND 'ZZZZZZ'"
	
EndIf                                                       

cRetFil := cQuery += cRetFil
	
	
RestArea(aArea)
Return  cRetFil
