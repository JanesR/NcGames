#INCLUDE "RWMAKE.CH"

User Function WsUsrField()

Local cAlias := PARAMIXB[1]
Local aReturn := {}

Do Case
	Case cAlias == "SC5"
		aAdd(aReturn, "C5_XSTAPED")	
		AAdd(aReturn, "C5_NOMCLI")
		aAdd(aReturn, "C5_MENSINT")
		aAdd(aReturn, "C5_PEDCLI")
		aAdd(aReturn, "C5_NOTA")
		aAdd(aReturn, "C5_SERIE")
		


	Case cAlias == "SC6"
		aAdd(aReturn, "C6_PRCTAB")
		aAdd(aReturn, "C6_VALDESC")
	End Case
	
	Return aReturn
