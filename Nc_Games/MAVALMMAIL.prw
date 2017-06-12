/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMAVALMMAILบAutor  ณMicrosiga           บ Data ณ  09/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que envia e-mail de acordo com evento pre-cadastrado บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MAVALMMAIL()  //ParamIXB={cEvento,aDados,cParUsuario,cParGrUsuario,cParEmails,lEvRH}
Local lEnviar:=.T.  


If ParamIXB[1]=="021" //ณ"021" - "Log de Processamento - Refaz Acumulados"
	If IsIncallStack("A003Exec")	
		U_A003LOG()
	ElseIf IsIncallStack("A004Exec")
		U_A004LOG()
	EndIf
ElseIf ParamIXB[1]=="022"//ณ"022" - "Log de Processamento - Saldo Atual"                            ณ
	If IsIncallStack("A003Exec")	
		U_A003LOG()
	ElseIf IsIncallStack("A004Exec")
		U_A004LOG()
	EndIf
ElseIf ParamIXB[1]=="023"//ณ"023" - "Log de Processamento - Recalculo do Custo Medio"               ณ	
	If IsIncallStack("A003Exec")	
		U_A003LOG()
	ElseIf IsIncallStack("A004Exec")
		U_A004LOG()
	EndIf
EndIf

	


Return lEnviar 