#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA040DEL  �Autor  �Hermes Ferreira     � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada na exclus�o do t�tulo a receber,quando ex- ���
���          �cluir um t�tulo, deleta os registros da tabela de controle  ���
���          � de al�ada 												  ���
�������������������������������������������������������������������������͹��
���Uso       � Nc games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
			Aviso("FA040DEL - 01","Ocorreu um erro, e n�o foi poss�vel limpar os registros na tabela de controle de al�adas.",{"Ok"},3)
			lRet	:= .F.
		Else
			TcSQLExec( "COMMIT" )
		EndIf
	EndIf
	
Return
