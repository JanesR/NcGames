#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
Static cChvIndE1
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA040B01  �Autor  �Hermes Ferreira     � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Tratamento na exclus�o do titulo. Caso tenha al�ada VPC n�o ���
���          �poder� excluir                                              ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA040B01()

	Local lRet := .T.
	Local cSql 		:= ""
	Local cAlias	:= GetNextAlias()
	Local cPrefixoVPC	:= Alltrim(U_MyNewSX6(	"NCG_000016"							,;
										"VPC"											,;
										"C"												,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										.F. ))

	Local cTipoTIT	:= Alltrim(U_MyNewSX6(	"NCG_000018"		 						,;
										"NCC"											,;
										"C"												,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										.F. ))
												
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If Alltrim(SE1->E1_TIPO) $ cTipoTIT .AND. Alltrim(SE1->E1_PREFIXO) == Alltrim(cPrefixoVPC)
		
		cChvIndE1 := SE1->(E1_CLIENTE+ E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)
		
		cSql := " SELECT "
		cSql += " P0B_NUM "
		cSql += " FROM "+ RetSqlName("P0B") + " P0B "
		cSql += " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
		cSql += " AND P0B.P0B_CHVIND = '"+Padr( cChvIndE1 ,TamSx3("P0B_CHVIND")[1])+"'"
		cSql += " AND P0B.P0B_STATUS NOT IN ('05')"
		cSql += " AND P0B.D_E_L_E_T_= ' '"
		
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)
		
		(cAlias)->(dbGoTop())
		
		If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
		
		    Aviso("FA040B01 - 01","Existe processo de controle de al�ada em andamento para este t�tulo e o mesmo n�o poder� ser exclu�do.",{"Ok"},3)
			lRet := .F.
			
		EndIf
		
		(cAlias)->(dbCloseArea())
		
	EndIf
	
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FStatSE1  �Autor  �Hermes Ferreira     � Data �  08/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o para retornar o conteudo da variavel static	      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Nc games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FStatSE1()

	Local cMyChave := cChvIndE1

	cChvIndE1 := ""

Return(cMyChave)
