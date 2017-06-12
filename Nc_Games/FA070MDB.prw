#INCLUDE "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA070MDB  บAutor  ณDBM                 บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada utilizado na valida็ใo do motivo da baixa  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FA070MDB()

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local lMvMult   := U_MyNewSX6(	"NC_ALTMULT", ;
									".F.", ;
									"L", ;
									"Verifica se o campo multa poderแ ser alterado, na baixa do titulo a receber (FINA070).",;
									"Verifica se o campo multa poderแ ser alterado, na baixa do titulo a receber (FINA070).",;
									"Verifica se o campo multa poderแ ser alterado, na baixa do titulo a receber (FINA070).",;
									.F. )

Local cMotBxOk   := U_MyNewSX6(	"NC_MTBXAR", ;
									"NORMAL", ;
									"C", ;
									"Motivo de baixa que poderแ ser utilizado na baixa do titulo a receber (FINA070).",;
									"Motivo de baixa que poderแ ser utilizado na baixa do titulo a receber (FINA070).",;
									"Motivo de baixa que poderแ ser utilizado na baixa do titulo a receber (FINA070).",;
									.F. )

//Verifica se o valor da multa foi preenchido. 
//Obs. Altera็ใo efetuada conforme o chamado 001243
If (nMulta != 0) .And. (!lMvMult)
	lRet := .F.
	Aviso("ERRMULTA", "O valor da multa nใo pode ser preenchido. Verificar a utiliza็ใo do campo com o Depto. Contแbil."+CRLF+CRLF+; 
						"Obs. Em caso de utiliza็ใo do campo, o parโmetro NC_ALTMULT deverแ ser alterado para .T..",{"Ok"},3)
EndIf 

If !(alltrim(cMotBx) $ cMotBxOk) .and. lRet
	lRet := .F.
	Aviso("ERRMOTBX", "Motivo de baixa nใo autorizado. Verificar a utiliza็ใo do campo com o Depto. Contแbil."+CRLF+CRLF+; 
						"Obs. Em caso de utiliza็ใo do motivo, atualizar o parโmetro NC_MTBXAR.",{"Ok"},3)
EndIf

RestArea(aArea)

Return lRet