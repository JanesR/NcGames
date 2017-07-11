#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM14  บAutor  ณMicrosiga           บ Data ณ  03/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Schedule a cada 5 min                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ                            
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCECOM14(aDados)

Default aDados := {"01","03"}//Empresa e filial

RpcClearEnv() 
RpcSetType(3) 

PtInternal(1,"U_ECOM03JOB - Importa็ใo de Estoque" )
U_ECOM03JOB(aDados)//Importa็ใo de Estoque

PtInternal(1,"U_ECOM05JOB - Importa็ใo de pedido" )
U_ECOM05JOB(aDados)//Importa็ใo de pedido

PtInternal(1,"U_ECOM07JOB - Importa็ใo de Status" )
U_ECOM07JOB(aDados)//Importa็ใo de Status 

//PtInternal(1,"ECOM08 - VERIFICA_CANCELAMENTO" )
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_CANCELAMENTO",.T.})  

PtInternal(1,"ECOM08 - VERIFICA_PAGAMENTO" )
U_NCECOM08({aDados[1],aDados[2],"VERIFICA_PAGAMENTO",.T.}) //Rotina serแ executada manualmente(Pre-venda What dogs). - 16/04/2014   

//PtInternal(1,"ECOM08 - VERIFICA_ENTREGA" )
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_ENTREGA",.T.})   // Retirado para execu็ใo diferenciada. - 16/04/2014     

//PtInternal(1,"ECOM08 - VERIFICA_EXPEDICAO" )                                 
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_EXPEDICAO",.T.})  

//PtInternal(1,"ECOM08 - VERIFICA_RASTREIO..." )
//U_NCECOM08({aDados[1],aDados[2],"VERIFICA_RASTREIO",.T.}) 

PtInternal(1,"ECOM08 - VERIFICA_ESTORNO..." )
U_NCECOM08({aDados[1],aDados[2],"VERIFICA_ESTORNO",.T.})

Return