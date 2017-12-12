#INCLUDE "RWMAKE.CH"


User Function MTA450LIB

If alltrim(upper(FUNNAME())) == "MATA450" .and. paramixb[3] == 1
	alert("Opção não permitida!")
	Return(.F.)
EndIf

Return .T.