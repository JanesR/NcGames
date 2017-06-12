#include "rwmake.ch"

User Function ValCodBar(cCod)

Local _lRet:=.T.
Local _aArea:=GetArea()
Local _cCodVal:=cCod

dbSelectArea("SB1")
dbSetOrder(5)
IF dbSeek(xFilial()+_cCodVal,.F.)
	_lRet:=.F.
	MsgAlert("Codigo de barras ja existente","Atencao!")
EndIF

RestArea(_aArea)

Return(_lRet)
