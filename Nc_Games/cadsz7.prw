#INCLUDE "rwmake.ch"

//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGAMES
//|Funcao....: U_CADSZ7()
//|Autor.....: Armando (Vulgo Poliana)
//|Data......: 15 de Novembro de 2007, 17:50
//|Uso.......: Geral
//|Versao....: Protheus 10
//|Descricao.: Traking
//|Observa��o:
//+-----------------------------------------------------------------------------------//

*------------------------------------*
User Function CADSZ7()
*------------------------------------*

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
//Local aButtons := {}

Local aRotAdic :={}
Local bPre := {||MsgAlert('Chamada antes da fun��o')}
Local bOK  := {||MsgAlert('Chamada ao clicar em OK'), .T.}
Local bTTS  := {||MsgAlert('Chamada durante transacao')}
Local bNoTTS  := {||MsgAlert('Chamada ap�s transacao')}
Local aButtons := {}
Private cString := "SZ7"


aadd(aRotAdic,{ "EXP. EXCEL","U_EXPSZ7", 0 , 6 })


dbSelectArea("SZ7")
SZ7->(dbSetOrder(1))


AxCadastro(cString,  "Cadastro de Traking", cVldAlt, cVldExc, aRotAdic, bPre, bOK, bTTS, bNoTTS, , , aButtons, , )


Return  (.T.)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CADSZ7    �Autor  �Palhares	         � Data �  20/08/2009 ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
//�Fonte alterado para melhorar o controle na gera��o de linhas na tabela SZ7�
//����������������������������������������������������������������������������
*/



User Function Z7Status(cxFilVen,cxPedVen,cxCodSt,cxStat,cxCliente,xcLjCliente)
cxArea 		:= GetArea()
cAreaSZ7	:= SZ7->(GetArea())
lTem		:= .F.

if cxCodSt='000001'
	TcSqlExec("update sz7010 set D_E_L_E_T_='*' where z7_filial='"+xFilial("SZ7")+"' and z7_num='"+cxPedVen+"'")
	TCSQLEXEC("COMMIT")
Endif

SZ7->(DbSetOrder(1))
lTem:= SZ7->(DbSeek(cxFilVen+cxPedVen+cxCodSt))

SZ7->(RecLock("SZ7", !lTem))

SZ7->Z7_FILIAL	:= cxFilVen
SZ7->Z7_NUM		:= cxPedVen
SZ7->Z7_STAT	:= cxCodSt
SZ7->Z7_STATUS 	:= cxStat
SZ7->Z7_CODCLI 	:= cxCliente
SZ7->Z7_DATA   	:= MsDate()
SZ7->Z7_HORA   	:= TIME()
SZ7->Z7_USUARIO	:= Upper(cUserName)

SZ7->(MsUnLock())
 

RestArea(cAreaSZ7)
RestArea(cxArea) 

Return
