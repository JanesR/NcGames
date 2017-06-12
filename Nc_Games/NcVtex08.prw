#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NcVtex08  �Autor  �Lucas Felipe	     � Data �  05/28/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fonte responsavel pela execu��o centralizadas dos jobs vtex���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NcVtex08(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

U_NCVTEX03()								//Job de estoque 

U_NCVTEX05()								//Job de importa��o de PV
U_VTEX05Cli()								//Job de Importa��o de PV
U_VTEX05Prod()								//Job de Importa��o de PV 

U_NCECOM08({"01","03","GRAVA_PEDIDO",.T.})	//Job de grava��o do PV 


RpcClearEnv()	

Return
