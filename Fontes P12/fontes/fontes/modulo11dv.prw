#include "rwmake.ch"

User Function Modulo11DV

Local _aArea   :=GetArea()
Local _cDV     :=""
Local _cPesos  :="78923456789"
Local _aModPeso:={}
Local _nMult   :=0
Local _nSoma   :=0

IF Mod(SEE->EE_SEQ,2) == 0 .and. SEE->EE_SEQ != 0
	_nSoma:=Strzero((SEE->EE_SEQ-1)+Val(Substr(SEE->EE_ULTDSK,2,5)),5)
ElseIF Mod(SEE->EE_SEQ,2) != 0 .and. SEE->EE_SEQ !=1 .and. SEE->EE_SEQ != 0
	_nSoma:=Strzero(INT(SEE->EE_SEQ/2)+Val(Substr(SEE->EE_ULTDSK,2,5)),5)
Else
	_nSoma:=Substr(SEE->EE_ULTDSK,2,5)
EndIF

For _j:=1 To 11
	aAdd(_aModPeso,Val(Substr(_cPesos,_j,1)))
Next
dbSelectArea("SEE")

Reclock("SEE",.F.)
	SEE->EE_X_ULTD:=Strzero(Val(_nSoma),6)
MsUnlock()

_cBase:=Alltrim(SEE->EE_CODEMP)+_nSoma

For _i:=1 To Len(_cBase)
	_nMult+=_aModPeso[_i]*Val(Substr(_cBase,_i,1))	
Next 
_cResto:=Alltrim(Str(Mod(_nMult,11)))
IF _cResto == "10"
	_cDV:="X"
Else
	_cDV:=_cResto
EndIF
_lRet:=_cBase+_cDV

RestArea(_aArea)
Return(_lRet)