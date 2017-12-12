//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGames
//|Funcao....: U_MT112IT()
//|Autor.....: Norival Júnior
//|Data......: 07 de Agosto de 2013
//|Uso.......: SIGAEIC
//|Versao....: Protheus - 11
//|Descricao.: Ponto de entrada utilizado apos a gravacao de cada item da SC como SI
//|Observação:
//------------------------------------------------------------------------------------//

User Function MT112IT()

dbSelectArea("SW1")
RecLock("SW1",.F.)

SW1->W1_FABR 		:= 		Posicione("SA5", 2, xFilial("SA5") + SC1->C1_PRODUTO, "A5_FABR")
SW1->W1_FABLOJ 	:= 		Posicione("SA5", 2, xFilial("SA5") + SC1->C1_PRODUTO, "A5_FALOJA")
SW1->W1_FORN 		:= 		Posicione("SA5", 2, xFilial("SA5") + SC1->C1_PRODUTO, "A5_FORNECE")
SW1->W1_FORLOJ 	:= 		Posicione("SA5", 2, xFilial("SA5") + SC1->C1_PRODUTO, "A5_LOJA")

MSUnLock()
Return NIL

