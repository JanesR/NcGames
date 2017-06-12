#include "rwmake.ch"

//User Function MT160WF(cNumCotac)
User Function XMT160WF(cNumCotac)

dbSelectArea("SC8")
dbSetOrder(1)
dbSeek(xFilial("SC8")+ParamIXB[1])

Do While !Eof() .and. xFilial("SC8")+ParamIXB[1] == C8_FILIAL+C8_NUM
	if C8_NUMPED <> "XXXXXX"
		Exit
	else
		dbSkip()
	Endif
EndDO

dbSelectArea("SC7")
dbSetOrder(1)
If dbSeek(xFilial("SC7")+SC8->C8_NUMPED)
	//U_WFW120P()
	U_SPCIniciar("","")
else
	ConOut("Pedido para a Cotação "+PARAMIXB[1]+" não encontrado")
Endif


Return .T.
