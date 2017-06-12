
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M450FLB   �Autor  �Microsiga           � Data �  09/18/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para filtro do SC9 na liberacao do PV     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M450FLB() //ParamIXB{cCondicao}
Local cFiltro:=ParamIxb[1]                   
Local cBloqLib :=AllTrim(U_MyNewSX6(	"NCG_000067", "S", "C", 	"Bloquear Liberacao do PV S=Sim ou N=Nao","","",	.F. ))
Local cCanUser	:=AllTrim(U_MyNewSX6(	"NCG_000068", "", "C", 	"ID do usuario com permissao de liberacao mesmo que o paramatro NCG_000067=S(separado por ;)","","",	.F. ))


If cBloqLib=="S" .And. !__cUserID$cCanUser
	MsgStop("Processo de libera��o bloqueado.","NcGames")     
	cFiltro+=IIf(!Empty(cFiltro) ,".And.","")+"1=2"//Retorno uma condicao falsa para n�o aparecer nenhum resgistro no Browse
EndIf


Return cFiltro 