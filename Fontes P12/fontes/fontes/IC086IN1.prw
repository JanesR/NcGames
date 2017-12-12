//+-----------------------------------------------------------------------------------//
//|Empresa...: Supertech
//|Cliente...: NCGames
//|Funcao....: U_IC086IN1()
//|Autor.....: Norival Júnior
//|Data......: 07 de Agosto de 2013
//|Uso.......: SIGAEIC
//|Versao....: Protheus - 11
//|Descricao.: Ponto de entrada utilizado na integração do Despachante
//|Observação:
//------------------------------------------------------------------------------------// 

User Function IC086IN1()
dbSelectArea("SW6")
RecLock("SW6",.F.)

SW6->W6_PRVDESE 	:= 		W6_DTREG_D + 9
SW6->W6_PRVENTR 	:= 		W6_DT_DESE + 1
MSUnLock()

Return Nil        
