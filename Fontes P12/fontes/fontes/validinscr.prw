#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VALIDIE  บAutor  ณErich Buttner		 บ Data ณ 20/12/10    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Tratamento da inscri็ใo estadual 			              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlteracoesณ Erich Buttner em 20/12/10                                  บฑฑ
ฑฑบ          ณ - Tratamento da inscri็ใo estadual    					  บฑฑ
ฑฑบ          ณ 														      บฑฑ
ฑฑบ          ณ 															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VALIDIE(_INSCR, cPessoa)

                      
IF ALLTRIM(_INSCR) <> "ISENTO"
   IF cPessoa == 'F'
   		Alert (" A inscri็ใo Estadual nใo Necessita de Pontua็ใo (.,-/) "+CHR(13)+"Ou deve Estar preenchido ISENTO")
		_INSCR:= "ISENTO"
    ELSE
    	IF ALLTRIM(_INSCR) == "ISENT".OR.ALLTRIM(_INSCR) == "ISENTA"
    		Alert (" A inscri็ใo Estadual nใo Necessita de Pontua็ใo (.,-/) "+CHR(13)+"Ou deve Estar preenchido ISENTO")
	    	_INSCR:= "ISENTO"
	    ELSE
    		Alert (" A inscri็ใo Estadual nใo Necessita de Pontua็ใo (.,-/) "+CHR(13)+"Ou deve Estar preenchido ISENTO")
			_INSCR:= ALLTRIM(STRTRAN(STRTRAN(STRTRAN(STRTRAN(_INSCR,".",""),"-",""),"/",""),",","")) 
	    ENDIF
	ENDIF
EndIf

		
Return (_INSCR)

