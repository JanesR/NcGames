#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#define clr Chr(13)+Chr(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M410GET   �Autor  �Hermes Ferreira     � Data �  04/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada na altera��o do pedido de venda.� verifica-���
���          �do se o Pedido de venda usar� Verba extra e se existe verba ���
���          �extra cadastrada para este pedido. Caso sim, ser� carregado ���
���          �o valor do contrato de verba extra no campo C5_DESCONT	  ���
�������������������������������������������������������������������������͹��
��� 05/09/13 �Utilizado tamb�m para estornar o split autom�tico dos itens ���
���          �m�dia esoftware no pedido de vendas.                        ���
���          �Utilizado na altera��o do pedido de vendas                  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M410GET()

Local cFilMDSW	:=	U_MyNewSX6(	"NCG_100002",;
								"05",;
								"C",;
								"Filiais que realizam o tratamento de m�dia e software",;
								"Filiais que realizam o tratamento de m�dia e software",;
								"Filiais que realizam o tratamento de m�dia e software",;
								.F. )

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If SC5->C5_YUSAVER == '1'
	FExtVerba(SC5->C5_CLIENTE,SC5->C5_LOJACLI,DtoS(SC5->C5_EMISSAO),SC5->C5_NUM)
EndIf
If CFILANT $ cFilMDSW 
    //separa��o de m�dia e software
	If ExistBlock("NCGA003")
		ExecBlock("NCGA003",.F.,.F.)
	EndIf       
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FExtVerba �Autor  �Hermes Ferreira     � Data �  04/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a consulta se existe verba extra aprovada para o pe-���
���          �dido e retorna os dados do contrato nos campos do pedido de ���
���          �venda														  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function FExtVerba(cCliente,cLoja,cEmissao,cNumPed)

Local cSql 		:= ""
Local clAlias 	:= GetNextAlias()
Local aRet		:= {}
Local aArea		:= SC5->(GetArea())
Local llUsado	:= .F.

Default cCliente	:= ""
Default cLoja		:= ""
Default cEmissao	:= MsDate()


//ErrorBlock( { |oErro| U_MySndError(oErro) } )

// Verifica por codigo de cliente

cSql := " SELECT P01_TOTVAL,P01_CODIGO, P01_VERSAO "		+ clr
cSql += " FROM "+RetSqlName("P01")+ " P01 "					+ clr
cSql += " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"		+ clr
cSql += " AND P01.P01_CODCLI = '"+cCliente+"'"				+ clr
cSql += " AND P01.P01_LOJCLI = CASE WHEN P01.P01_LOJCLI = '  ' THEN  '  '  ELSE '"+cLoja+"' END "+ clr
cSql += " AND P01.P01_DTVINI <= '"+cEmissao+"'"				+ clr
cSql += " AND P01.P01_DTVFIM >= '"+cEmissao+"'"  			+ clr
cSql += " AND P01.P01_TPCAD = '2'"							+ clr // SOMENTE TIPO VPC
cSql += " AND P01.P01_REPASS = '2'"							+ clr // SOMENTE DE PEDIDO DE VENDA

If Empty(SC5->C5_YCODVPC) .AND. Empty(SC5->C5_YVERVPC)
	cSql += " AND P01.P01_STATUS = '1'"				 			+ clr // ATIVO
EndIf

cSql += " AND P01.P01_STSAPR = '1'"				 			+ clr // aprovado

cSql += " AND P01.P01_FILPED = '"+xFilial("SC5")+"'"		+ clr // Filial do Pedido de Venda
cSql += " AND P01.P01_PEDVEN = '"+Alltrim(cNumPed)+"'" 		+ clr // Numero do Pedido de Venda


cSql += " AND NOT EXISTS (SELECT C5_YCODVPC "							+ clr
cSql += " 					FROM "+RetSqlName("SC5")+ " SC5 "			+ clr
cSql += " 					WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"	+ clr
cSql += " 					AND SC5.C5_YCODVPC = P01_CODIGO "			+ clr
cSql += " 					AND SC5.C5_YVERVPC = P01_VERSAO "			+ clr
cSql += " 					AND SC5.C5_YUSAVER = '1'"					+ clr  
cSql += " 					AND SC5.C5_NUM <> '"+Alltrim(cNumPed)+"'"	+ clr
cSql += " 					AND SC5.D_E_L_E_T_= ' '"					+ clr
cSql += " 				) "												+ clr

cSql += " AND P01.D_E_L_E_T_= ' '"					 					+ clr

TcQuery cSql New Alias &(clAlias)

(clAlias)->(dbGoTop())

IF !((clAlias)->(!Eof()) .AND. (clAlias)->(!Bof()))
	
	// Se n�o achar, procura por Grupo
	(clAlias)->(dbCloseArea())
	
	clAlias 	:= GetNextAlias()
	
	cSql := ""
	cSql := " SELECT P01_TOTVAL,P01_CODIGO, P01_VERSAO "	+ clr
	cSql += " FROM "+RetSqlName("P01")+ " P01 "				+ clr
	
	cSql += " JOIN "+RetSqlName("SA1")+" SA1 "		   		+ clr
	cSql += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"		+ clr
	cSql += " AND SA1.A1_COD = '"+cCliente+"'"				+ clr
	cSql += " AND SA1.A1_LOJA = '"+cLoja+"'"				+ clr
	cSql += " AND A1_GRPVEN <> ' ' "						+ clr
	cSql += " AND SA1.D_E_L_E_T_= ' '"						+ clr
	
	cSql += " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"	+ clr
	cSql += " AND P01.P01_DTVINI <= '"+cEmissao+"'"			+ clr
	cSql += " AND P01.P01_DTVFIM >= '"+cEmissao+"'"  		+ clr
	cSql += " AND P01.P01_GRPCLI = A1_GRPVEN "				+ clr
	cSql += " AND P01.P01_TPCAD = '2'"						+ clr
	cSql += " AND P01.P01_REPASS = '2'"						+ clr
	cSql += " AND P01.P01_STATUS = '1'"						+ clr
	cSql += " AND P01.P01_STSAPR = '1'"						+ clr
	cSql += " AND P01.D_E_L_E_T_= ' '"						+ clr
	cSql += " AND P01.P01_FILPED = '"+xFilial("SC5")+"'"	+ clr // Filial do Pedido de Venda
	cSql += " AND P01.P01_PEDVEN = '"+Alltrim(cNumPed)+"'"	+ clr // Numero do Pedido de Venda
	cSql += " AND NOT EXISTS (SELECT C5_YCODVPC "							+ clr
	cSql += " 					FROM "+RetSqlName("SC5")+ " SC5 "			+ clr
	cSql += " 					WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"	+ clr
	cSql += " 					AND SC5.C5_YCODVPC = P01_CODIGO "			+ clr
	cSql += " 					AND SC5.C5_YVERVPC = P01_VERSAO "			+ clr
	cSql += " 					AND SC5.C5_YUSAVER = '1'"					+ clr
	cSql += " 					AND SC5.C5_NUM <> '"+Alltrim(cNumPed)+"'"	+ clr
	cSql += " 					AND SC5.D_E_L_E_T_= ' '"					+ clr
	cSql += " 				) "												+ clr
	
	TcQuery cSql New Alias &(clAlias)
	(clAlias)->(dbGoTop())
	
EndIf

If (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
	
	If .T. //Aviso("M410GET -01","Foi localizado de contrato de verba aprovada para este cliente. Deseja aplica-lo?"+clr+"Contrato de Verba - Vers�o:"+Alltrim((clAlias)->P01_CODIGO)+"-"+Alltrim((clAlias)->P01_VERSAO)+" no valor "+AllTrim(TransForm( (clAlias)->P01_TOTVAL,"@E 99,999,999,999.99"))+".",{"Sim","N�o"},3)== 1
		M->C5_YVEPVCO := (clAlias)->P01_CODIGO
		M->C5_YVEPVVE := (clAlias)->P01_VERSAO
		M->C5_DESCONT := (clAlias)->P01_TOTVAL    		
		M->C5_YDSCVER := M->C5_DESCONT			 // Desconto Verba EXTRA
	Else
		M->C5_YVEPVCO := ""
		M->C5_YVEPVVE := ""
		M->C5_DESCONT := 0
		M->C5_YDSCVER := 0
	EndIf
	
EndIf
(clAlias)->(DbCloseArea())

U_DisVPCC6(4)


RestArea(aArea)

Return
