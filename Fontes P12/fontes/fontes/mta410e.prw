#INCLUDE "rwmake.ch"

//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGAMES
//|Funcao....: MTA410E()
//|Autor.....: Palhares
//|Data......: Ago/2009
//|Uso.......: Ponto de Entrada que atualizará o Traking  no momento da exclusão do Pedido de Venda
//|Versao....: Protheus 10
//|Descricao.: Atualiza o traking ao excluir um pedido
//|Observação:
//+-----------------------------------------------------------------------------------//

*------------------------------------*
User Function MTA410E()
*------------------------------------*
Local cxArea := GetArea()
Local lRet  := .T.
Local lCondPag 		:= M->C5_CONDPAG $ AllTrim(SuperGetMv("MV_NCRESER",.F.,""))

TcSqlExec("update sz7010 set D_E_L_E_T_='*' where z7_filial='"+xFilial("SZ7")+"' and z7_num='"+sc5->c5_num+"'")
TCSQLEXEC("COMMIT")

//PROJETO VENDA A VISTA
//If lRet
//	If lCondPag .And. M->C5_XSTAPED == "15"
//		cNumPed	:= M->C5_NUM
//		U_NC110Del(cNumPed)
//		U_NC110Mail()
//	EndIf
//EndIf
      
If AllTrim(SC5->C5_YORIGEM)=="WM"
	U_WM001Exc({"PV",SC5->C5_NUM})
EndIf



RestArea(cxArea)

Return lRet
