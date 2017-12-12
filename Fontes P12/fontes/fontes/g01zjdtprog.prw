#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function G01ZJDTPROG()
Private _aArea      := GetArea()
Private _dRet       := M->ZJ_DTPROG

If M->ZJ_DTPROG  < (DDATABASE+1)
    Alert("Data Programada NAO pode ser anterior a Data Base + 1 dia...")
    _dRet := Ctod("")
EndIf

RestArea(_aArea)
Return(_dRet)
