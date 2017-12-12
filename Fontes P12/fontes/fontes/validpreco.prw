#include "rwmake.ch"
User Function ValidPreco(_nQtd)

Local _aArea :=GetArea()
Local _lRet  :=_nQtd

MsgAlert("O campo codigo de produto deve ser confirmado,retorne ao campo codigo do produto e pressione<ENTER>, assim o valor em reais sera atualizado","Alerta")

RestArea(_aArea)
Return(_lRet)