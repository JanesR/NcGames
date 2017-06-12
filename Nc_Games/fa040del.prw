#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA040DEL  บAutor  ณHermes Ferreira     บ Data ณ  08/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada na exclusใo do tํtulo a receber,quando ex- บฑฑ
ฑฑบ          ณcluir um tํtulo, deleta os registros da tabela de controle  บฑฑ
ฑฑบ          ณ de al็ada 												  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FA040DEL()

	Local cChaveTit := ""
	Local cSql		:= ""
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cChaveTit := U_FStatSE1()
	
	If !Empty(cChaveTit)
	
		cSql := " UPDATE "+ RetSqlName("P0B") + " P0B "
		cSql += " SET D_E_L_E_T_ = '*' "
		cSql += " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
		cSql += " AND P0B.P0B_CHVIND = '"+Padr( cChaveTit ,TamSx3("P0B_CHVIND")[1])+"'"
		cSql += " AND P0B.P0B_TABORI = 'SE1' "
		cSql += " AND P0B.D_E_L_E_T_= ' ' "
		
		If TcSQLExec( cSql ) < 0
			Aviso("FA040DEL - 01","Ocorreu um erro, e nใo foi possํvel limpar os registros na tabela de controle de al็adas.",{"Ok"},3)
			lRet	:= .F.
		Else
			TcSQLExec( "COMMIT" )
		EndIf
	EndIf
	
Return
