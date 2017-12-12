#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function G01ZHPROD()
Private _aArea      := GetArea()
Private _cRet       := M->ZH_PRODUTO
Private _cPublisher := Space(06)

dbSelectArea("SB1")
dbSetOrder(1)
If dbSeek(xFilial("SB1")+M->ZH_PRODUTO)
	_cPublisher := GETADVFVAL("CTD","CTD_CODUSR",XFILIAL("CTD")+SB1->B1_ITEMCC,1,SPACE(06))
EndIf
//
// Alterado em 05/12/2012 por solicitacao do Sr. Lucas
// Retirada a concistencia.
// If AllTrim(_cPublisher) != AllTrim(RetCodUsr())
//	   Alert("A manutencao desse produto NAO Pertence ao seu Usuario. Usuario Responsavel: "+AllTrim(_cPublisher))
//	   _cRet := Space(15)
// EndIf
//
//
RestArea(_aArea)
Return(_cRet)