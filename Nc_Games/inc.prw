#INCLUDE "PROTHEUS.CH"

User Function Inc(cNum)
nseq:=nqtdtottit
If PCOUNT()==0
	cNum:=StrZero(nqtdtottit,6)
EndIf

Return 1+Val(cNum)
