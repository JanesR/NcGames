#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/09/00



User Function Pagide()

IF SA2->A2_TIPO == "J"
	_cCgc := "0" + Left(SA2->A2_CGC,8) + Substr(SA2->A2_CGC,9,4) + SubStr(SA2->A2_CGC,13,2)
ELse
   _cCgc :=  Left(SA2->A2_CGC,9) + "0000" + Substr(SA2->A2_CGC,8,2)
Endif

Return(_cCgc)

