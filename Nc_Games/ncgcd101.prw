#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH' 
#INCLUDE 'TopConn.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGCD101  �Autor  �Hermes Ferreira     � Data �  03/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina de Cadastro de Tipo de VPC                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NCGCD101()

	Private aRotina		:= MenuDef()
	Private cCadastro	:= "Tipo de VPC/Verba"
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	Begin Sequence

		dbSelectArea("P00")
		P00->(dbSetOrder(1))
			
		mBrowse( 6, 1,22,75,'P00')
		
	End Sequence	
Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MenuDef   �Autor  �Hermes Ferreira     � Data �  03/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Menu da rotina de cadastro                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MenuDef()
	Local alRotina := {  {"Pesquisar"	,"AxPesqui",0,1} ,;
			             {"Visualizar"	,"AxVisual",0,2} ,;
			             {"Incluir"		,"AxInclui",0,3} ,;
			             {"Alterar"		,"AxAltera",0,4} ,;
			             {"Excluir"		,"u_EXCL001",0,5} }
			             
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
Return alRotina


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EXCL001   �Autor  �Hermes Ferreira     � Data �  03/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o antes de excluir o cadastro de tipo de VPC.So pode���
���          �r� ser exclu�do caso nenhum registro de movimenta��o o tenha���
���          �utilizado                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function EXCL001()

	Local cQry 		:= ""
	Local clAlias	:= GetNextAlias()
	Local nCnt		:= 0
	Local llOk		:= .T.
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	cQry	:= " SELECT P02_CODTP "
	cQry	+= " FROM "+RetSqlName("P02")+ " P02 "
	cQry	+= " WHERE P02.P02_FILIAL = '"+xFilial("P02")+"'"
	cQry	+= " AND P02.P02_CODTP = '"+P00->P00_CODIGO+"'"
	cQry	+= " AND P02.P02_TPCAD = '"+P00->P00_TIPO+"'"
	cQry	+= " AND P02.D_E_L_E_T_= ' ' "

	TcQuery cQry NEW Alias &clAlias

	(clAlias)->( dbGoTop() )
	
	If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
		llOk := .F.
	EndIf

	(clAlias)->(dbCloseArea())
	
	If llOk
		P00->(RecLock("P00",.F.))
		P00->(dbDelete())
		P00->(MsUnLock())
	Else
		Aviso("EXCL001 - 01","N�o � permitido excluir este Tipo de VPC/Verba, pois o mesmo j� est� sendo utilizado em um VPC/Verba.",{"Ok"},3)
	EndIf
	
Return