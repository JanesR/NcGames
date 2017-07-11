#include "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"


user Function envPedWMS(CNUM)

Local aArea := GetArea()
Local cQuery :=""
Local cAlias01 := GetNextAlias()

cQuery := "select * from sc9010 where c9_pedido = '"+CNUM+"' and D_E_L_E_T_ = ' ' "
cQuery += "and C9_BLCRED = ' ' and C9_BLEST = ' ' "

cQuery := ChangeQuery(cQuery)
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias01, .T., .F.)

(cAlias01)->(DbGoTop())
While (cAlias01)->(!EOF())
    If P0A->(RecLock("P0A",.T.))
        P0A->P0A_FILIAL	:= xFilial("P0A")
        P0A->P0A_CHAVE	:= xFilial("P0A") + (cAlias01)->c9_pedido + (cAlias01)->C9_ITEM + (cAlias01)->c9_PRODUTO
        P0A->P0A_TABELA	:= "SC6"
        P0A->P0A_EXPORT := '2'
        P0A->P0A_INDICE	:= 'C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO'
        P0A->P0A_TIPO	:= '1'
        P0A->(MsUnlock())
    EndIF
    (cAlias01)->(DbSkip())
EndDo

If P0A->(RecLock("P0A",.T.))
    P0A->P0A_FILIAL	:= xFilial("P0A")
    P0A->P0A_CHAVE	:= xFilial("P0A") + CNUM
    P0A->P0A_TABELA	:= "SC5"
    P0A->P0A_EXPORT := '2'
    P0A->P0A_INDICE	:= 'C5_FILIAL+C5_NUM'
    P0A->P0A_TIPO	:= '1'
    P0A->(MsUnlock())
EndIF

RestArea(aArea)
Return 
