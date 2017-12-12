#include "TOTVS.ch"          
#include "TOPCONN.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DPZZC     �Autor  �Jorge Heitor        � Data �  26/03/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que faz um DE/PARA na tabela ZZC, de maneira que os  ���
���          �itens numerados como 001 passem para 0001 e 99A para 1000   ���
�������������������������������������������������������������������������͹��
���Uso       �Especifico NC GAMES                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function DPZZC()

	Local cQuery := ""
	                  
	
	RpcSetType(3)
	RpcSetEnv("01","03")
	
	//Leitura de Todos os pedidos na tabela ZZC
	cQuery := " SELECT DISTINCT ZZC_FILIAL,ZZC_PEDIDO FROM ZZC010 WHERE D_E_L_E_T_ = ' ' "
	
	cQuery := ChangeQuery(cQuery)
	
	If Select("TRB") > 0 
		TRB->(dbCloseArea())
	EndIf
	
	TcQuery cQuery Alias "TRB" NEW
	
	dbSelectArea("TRB")  
	
	If !Eof()
	
		//Leitura e altera��o de todos os itens relacionados a cada pedido
		Processa({|| DePara() },"Processando registros...","Aguarde... Processando registros...")
	
	EndIf 
	
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DPZZC     �Autor  �Microsiga           � Data �  03/26/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function DePara()

	Local cPedido

	dbSelectArea("TRB")
	dbGoTop()
	While !TRB->(Eof())
	
		cFilial := TRB->ZZC_FILIAL
		cPedido := TRB->ZZC_PEDIDO
		nContador := 1
		
		IncProc("Processando Pedido "+cPedido)
		
		dbSelectArea("ZZC")
		dbSetOrder(1)
		dbSeek(cFilial+cPedido)
		If Found()
			While !ZZC->(Eof()) .And. ZZC->ZZC_FILIAL == cFilial .And. ZZC->ZZC_PEDIDO == cPedido
			
				//Atualiza ZZC
				RecLock("ZZC",.F.)
					
					ZZC->ZZC_ITEM := StrZero(nContador,TamSx3("ZZC_ITEM")[1])
					
				MsUnlock()
				
				ZZC->(dbSkip())
				nContador ++
				
			End
		EndIf
		
		TRB->(dbSkip())
		
	End
	
Return .T.