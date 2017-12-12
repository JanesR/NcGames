#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOM14  �Autor  �Microsiga           � Data �  03/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Schedule a cada 5 min                                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������                            
�����������������������������������������������������������������������������
*/
User Function NCECOM14(aDados)

Default aDados := {"01","03"}//Empresa e filial

RpcClearEnv() 
RpcSetType(3) 

PtInternal(1,"U_ECOM03JOB - Importa��o de Estoque" )
U_ECOM03JOB(aDados)//Importa��o de Estoque

PtInternal(1,"U_ECOM05JOB - Importa��o de pedido" )
U_ECOM05JOB(aDados)//Importa��o de pedido

PtInternal(1,"U_ECOM07JOB - Importa��o de Status" )
U_ECOM07JOB(aDados)//Importa��o de Status 

//PtInternal(1,"ECOM08 - VERIFICA_CANCELAMENTO" )
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_CANCELAMENTO",.T.})  

PtInternal(1,"ECOM08 - VERIFICA_PAGAMENTO" )
U_NCECOM08({aDados[1],aDados[2],"VERIFICA_PAGAMENTO",.T.}) //Rotina ser� executada manualmente(Pre-venda What dogs). - 16/04/2014   

//PtInternal(1,"ECOM08 - VERIFICA_ENTREGA" )
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_ENTREGA",.T.})   // Retirado para execu��o diferenciada. - 16/04/2014     

//PtInternal(1,"ECOM08 - VERIFICA_EXPEDICAO" )                                 
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_EXPEDICAO",.T.})  

//PtInternal(1,"ECOM08 - VERIFICA_RASTREIO..." )
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_RASTREIO",.T.}) 

PtInternal(1,"ECOM08 - VERIFICA_ESTORNO..." )
U_NCECOM08({aDados[1],aDados[2],"VERIFICA_ESTORNO",.T.})

Return