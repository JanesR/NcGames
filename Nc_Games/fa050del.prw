#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA050DEL  � Autor � Rafael Augusto     � Data �  08/12/2010 ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de Entrada para validar a exclus�o de um titulo no   ���
���          � contas a pagar, somente ser� liberado a inclusao para      ���
���          � para usuarios que estejam dentro do parametro.             ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 R1.3 - NC GAMES - Supertech Consulting LTDA.		  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function FA050DEL

Local lRet := .F.
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()
Local cPrefxVerba	:= U_MyNewSX6(	"NCG_000017"	 								,;
									"VER"											,;
									"C"												,;
									"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
									"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
									"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
									.F. )

If ALLTRIM(UPPER(cUsername)) $ (ALLTRIM(UPPER(GETMV("MV_INC_PAG"))))
	lRet := .T.
Else
	If (M->E2_TIPO <> "PA")
		lRet := .F.
		ALERT("Usuario sem acesso para incluir esse tipo de titulo, favor consultar o Administrador do sistema ")
	Else
		lRet := .T.
	EndIf
EndIf

if lRet

    //Tratamento na exclus�o do titulo. Caso tenha al�ada VPC n�o poder� excluir 
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	If Alltrim(SE2->E2_PREFIXO) == Alltrim(cPrefxVerba)

		cSql := " SELECT "
		cSql += " P0B_NUM "
		cSql += " FROM "+ RetSqlName("P0B") + " P0B "
		cSql += " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
		cSql += " AND P0B.P0B_CHVIND = '"+Padr(SE2->(E2_FORNECE + E2_LOJA + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO),TamSx3("P0B_CHVIND")[1])+"'"
		cSql += " AND P0B.P0B_STATUS NOT IN ('05')"
		cSql += " AND P0B.D_E_L_E_T_= ' '"

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

		(cAlias)->(dbGoTop())

		If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())

		    Aviso("FA050DEL - 01","Existe processo de controle de al�ada em andamento para este t�tulo e o mesmo n�o poder� ser exclu�do.",{"Ok"},3)
			lRet := .F.
		Else
			lRet := .T.
		EndIf

		(cAlias)->(dbCloseArea())

	EndIf

EndIf

Return lRet
