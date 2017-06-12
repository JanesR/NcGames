#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA050B01  �Autor  �Hermes Ferreira     � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada na exclus�o do t�tulo a pagar,quando exclu-���
���          �ir um t�tulo, deleta os registros da tabela de controle de  ���
���          �al�ada   													  ���
�������������������������������������������������������������������������͹��
���Uso       � Nc games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA050B01()

	Local cSql := ""
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	cSql := " UPDATE "+ RetSqlName("P0B") + " P0B "
	cSql += " SET D_E_L_E_T_ = '*' "
	cSql += " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
	cSql += " AND P0B.P0B_CHVIND = '"+Padr(SE2->(E2_FORNECE + E2_LOJA + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO),TamSx3("P0B_CHVIND")[1])+"'"
	cSql += " AND P0B.P0B_TABORI = 'SE2' "
	cSql += " AND P0B.D_E_L_E_T_= ' ' "
	
	If TcSQLExec( cSql ) < 0
		Aviso("FA050B01 - 01","Ocorreu um erro, e n�o foi poss�vel limpar os registros na tabela de controle de al�adas.",{"Ok"},3)
		lRet	:= .F.
	Else
		TcSQLExec( "COMMIT" )
	EndIf		
		
Return