#include "rwmake.ch"

User Function C5WHEN01()
Private _aArea   := GetArea()
Private _lRet    := .F.
Private _cUsrAtu := AllTrim(RetCodUsr())
Private _cUsrFrt := GETMV("MV_USRFRTN")

If AllTrim(_cUsrAtu) $ AllTrim(_cUsrFrt)
    //If M->C5_MODAL == "2"
        _lRet := .T.
    //Else
   //     _lRet := .F.
    //EndIf
Else
    _lRet := .F.
EndIf

RestArea(_aArea)
Return(_lRet)