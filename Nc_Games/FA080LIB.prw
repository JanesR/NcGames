#INCLUDE "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA080LIB  บAutor  ณ                    บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada utilizado na valida็ใo do motivo da baixa do contas a pagar บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FA080LIB()

Local aArea 	:= GetArea()
Local lRet		:= .T.

Local cMotBxOk   := U_MyNewSX6(	"NC_MTBXAP", ;
									"DEBITO CC", ;
									"C", ;
									"Motivo de baixa que poderแ ser utilizado na baixa do titulo a receber (FINA080).",;
									"Motivo de baixa que poderแ ser utilizado na baixa do titulo a receber (FINA080).",;
									"Motivo de baixa que poderแ ser utilizado na baixa do titulo a receber (FINA080).",;
									.F. )


If !(alltrim(cMotBx) $ cMotBxOk) .and. lRet
	lRet := .F.
	Aviso("ERRMOTBX", "Motivo de baixa nใo autorizado. Verificar a utiliza็ใo do campo com o Depto. Contแbil."+CRLF+CRLF+; 
						"Obs. Em caso de utiliza็ใo do motivo, atualizar o parโmetro NC_MTBXAP.",{"Ok"},3)
EndIf

RestArea(aArea)

Return lRet