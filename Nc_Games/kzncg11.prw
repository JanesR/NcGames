#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "FILEIO.CH"

#DEFINE X3_USADO_EMUSO "���������������"

/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZNCG11	     �Autor  �Rodrigo A. Tosin	  �Data  � 18/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao para gerar mBrowse da tabela ZAE					  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �NCGames                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil						   									  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
*/

User Function KZNCG11()

Local 	alArea 		:= GetARea()
Local 	clAlias     := "ZAE"
Local 	alAlias		:= {"ZAJ","ZAK"}
Local 	nlX 		:= 1
Local 	llRet 		:= .T.

Private cCadastro 	:= "Quebrar Pedido EDI"
Private aRotina  	:= {}

dbSelectArea("SX2")
SX2->(dbSetOrder(1))
For nlX := 1 to Len(alAlias)
	SX2->(dbGoTop())
	
	If SX2->(!dbSeek(alAlias[nlX]))
		llRet := .F.
		ShowHelpDlg(alAlias[nlX], {"A tabela '" + alAlias[nlX] + "' n�o existe no Dicion�rio de Arquivos"},5,{"Execute o update U_UPDNCG15."},5)
		Exit
	EndIf
Next nlX

If llRet
	dbSelectArea("SX2")
	SX2->(dbSetOrder(1))
	SX2->(dbGoTop())
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Pesquisa tabela ZAE na tabela SX2. Se nao existir, exibe mensagem ao usuario.																   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	
	If SX2->(dbSeek(clAlias))
		SX2->(dbGoTop())
		//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
		//�Pesquisa tabela ZAF na tabela SX2. Se nao existir, exibe mensagem ao usuario.																   �
		//��������������������������������������������������������������������������������������������������������������������������������������������������
		
		If SX2->(dbSeek("ZAF"))
			U_KZNC11()
		Else
			//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
			//�Exibe mensagem ao usuario informando que a tabela ZAF nao existe.																			   �
			//��������������������������������������������������������������������������������������������������������������������������������������������������
			
			ShowHelpDlg(clAlias, {"A tabela ZAF n�o existe no Dicion�rio de Arquivos"},5,{"Execute o update U_UPDNCG06."},5)
			llRet := .F.
		EndIf
	Else
		//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
		//�Exibe mensagem ao usuario informando que a tabela ZAE nao existe.																			   �
		//��������������������������������������������������������������������������������������������������������������������������������������������������
		
		ShowHelpDlg(clAlias, {"A tabela " + clAlias + " n�o existe no Dicion�rio de Arquivos"},5,{"Execute o update U_UPDNCG06."},5)
		llRet := .F.
	EndIf
EndIf
RestArea(alArea)
Return

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KZNC11		 �Autor  �Rodrigo A. Tosin    � Data � 17/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Rotina para gerar tela com cabecalho e itens da SZ1			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�cAlias - Tabela posicionada - SZ1 							   ���
���  		 �nReg   - Numero do registro posicionado   					   ���
���  		 �nOpc	 - Opcao da MBrowse									       ���
������������������������������������������������������������������������������͹��
���Retorno   �Nil  							                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

User Function KZNC11(cAlias,nReg,nOpc)

Local oDlgZAE  	 	:= Nil
Local llRet			:= .T.

Private oGetDados
Private aHeader 	:= {}
Private aCols 		:= {}

Private cpGetEDI    := Space(20)
Private cpGetPCl    := Space(6)
Private cpGetEmi   	:= Space(8)
Private cpGetEnt   	:= Space(8)
Private cpGetCli  	:= Space(8)
Private cpGetCon  	:= Space(3)
Private cpGetLoj  	:= Space(2)
Private cpGetTab  	:= Space(3)
Private cpGetClE  	:= Space(6)
Private cpGetLoE  	:= Space(2)
Private cpGetFre  	:= Space(8)
Private cpGetTot 	:= Space(14)
Private cpGetObs	:= ""
Private apProdutos 	:= {}
Private apAlter		:= {}
Private apPVEstr	:= {}
Private npTDesp		:= 0
Private npDesc1		:= 0
Private npDesc2		:= 0
Private npDesc3		:= 0
Private npDesc4		:= 0
Private npDescF		:= 0
Private npTFrete	:= 0
Private npSeguro	:= 0
Private cpVend		:= ""
Private cpTransp	:= ""

Private oOk 		:= LoadBitmap( GetResources(), "LBOK")
Private oNo 		:= LoadBitmap( GetResources(), "LBNO")

//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Verifica se pedido EDI esta com status 1 - Apto a gerar pedido de venda ou 2 - Apto a gerar pedido de venda com advertencia.					   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
If ZAE->ZAE_STATUS $ "1|2"
	//������������������������������������������������������������Ŀ
	//�Altera��o para verificar se existem altera��es do pedido EDI�
	//�pendentes na tabela ZAJ.                                    �
	//�                                                            �
	//�Alfredo A. Magalhaes                                        �
	//��������������������������������������������������������������
	If !KZVeriAlt()
		cpGetTot:= 0.00
		llRet	:= MontaGrid()
		If llRet
			NCG11Head()
			oGetDados    				:= MsNewGetDados():New(103,002,300,400,GD_INSERT+GD_UPDATE+GD_DELETE,'U_LinOk'/*cLinOk */,/*cTudoOk*/,,apAlter,,999 ,'U_OGDField'/*cFieldOk*/,,,oDlgZAE,aHeader,aCols,/*{|| U_OGDChange()}*/)
			oGetDados:oBrowse:lVisible	:= .F.
			MsgRun("Gerando Pedidos de Venda...","Aguarde...",{|| GeraPV()})
		Else
			//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
			//�Pedido EDI nao possui informacoes. Exibe mensagem ao usuario avisando.		 																   �
			//��������������������������������������������������������������������������������������������������������������������������������������������������
			ShowHelpDlg("SemInfo",{"Pedido EDI: " + ALLTRIM(ZAE->ZAE_NUMEDI) + " n�o possui informa��es para gerar os pedidos de venda."},5,{"Selecione um pedido EDI que contenha informacoes."},5)
		EndIf
	Else
		ShowHelpDlg("SEMPERMISSAO", {"Existem altera��es pendentes para este pedido."},5,{"Aprovar ou rejeitar as altera��es pendentes para este pedido." + CRLF + " - Tabela ZAJ."},5)
	EndIf
Else
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Pedido EDI nao esta apto a gerar pedido de vendas. Exibe mensagem ao usuario avisando.														   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	ShowHelpDlg("N�oApto",{"Pedido EDI: " + ALLTRIM(ZAE->ZAE_NUMEDI) + " n�o est� apto a gerar um pedido de vendas."},5,{"Selecione um pedido EDI que esteja apto a gerar pedido de vendas."},5)
EndIf

Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �NCG11Head		 �Autor  �Rodrigo A. Tosin    � Data �  19/05/2012 ���
������������������������������������������������������������������������������͹��
���Desc.     �Rotina para montar o vetor aHeader					  		   ���
������������������������������������������������������������������������������͹��
���Uso       �Nil		                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil 							                                   ���
������������������������������������������������������������������������������͹��
���Retorno   �Nil 							                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function NCG11Head()
Local aArea  	:= GetArea()
Local nlX    	:= 1
Local clParam 	:= ""
Local alCampos 	:= {"ZAF_SEQ","ZAF_ITEM","ZAF_EAN","ZAF_PRODUT","B1_DESC","ZAF_QTD","ZAF_PRCUNI","ZAF_TOTAL","ZAF_DESC","F4_BASEICM","ZAF_PERCIP","ZAF_VLRDSP","ZAF_VLRFRT","ZAF_VLRSEG"}
Local nlPosQt	:= 0
Local nlPosPU	:= 0
Local nlPosTo	:= 0
Local nPosIte	:= 0
Local nPosICM	:= 0

Local clCbox	:= ""
Local nlPosPr	:= 0

apAlter	:= {"ZAF_SEQ","ZAF_PRODUT","ZAF_QTD","ZAF_PRCUNI","ZAF_TOTAL"}

dbSelectArea("SX3")
SX3 -> (dbSetOrder(2))
SX3 -> (dbGoTop())

//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Pesquisa campos na SX3 e adiciona no cabecalho.																								   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
For nlX := 1 to Len(alCampos)
	If SX3->(dbSeek(alCampos[nlX]))
		AADD( aHeader, {SX3->X3_TITULO,SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,'',X3_USADO_EMUSO,SX3->X3_TIPO,SX3->X3_F3,'R'			 ,SX3->X3_CBOX,SX3->X3_RELACAO})
	EndIf
Next nlX
nPosIte	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_ITEM") 		})
nPosICM	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("F4_BASEICM") 		})
//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Altera nome dos campos ZAF_ITEM E F4_BASEICM.																									   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
/*
If nPosIte > 0
aHeader[nPosIte][1] := "Sequencia"
EndIf
*/
If nPosICM > 0
	aHeader[nPosICM][1] := "% ICMS"
EndIf

//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Acrescenta validacao nos campos Quantidade, Preco unitario e Total.																			   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
nlPosQt	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_QTD") 			})
nlPosPU	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRCUNI") 		})
nlPosTo	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_TOTAL") 		})

If nlPosQt > 0
	aHeader[nlPosQt][6] := 'Positivo() .AND. U_ValTot()'
EndIf
If nlPosPU > 0
	aHeader[nlPosPU][6] := 'Positivo() .AND. U_ValTot()'
EndIf
If nlPosTo > 0
	aHeader[nlPosTo][6] := 'Positivo() .AND. U_ValTot()'
EndIf

For nlX := 1 to Len(apProdutos)
	If Empty(clCbox)
		clCbox := "'" + ALLTRIM(apProdutos[nlX][2]) + "'=" + ALLTRIM(apProdutos[nlX][2])
	Else
		clCbox += ";'" + ALLTRIM(apProdutos[nlX][2]) + "'=" + ALLTRIM(apProdutos[nlX][2])
	EndIf
Next nlX

nlPosPr :=  aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRODUT") 		})
If nlPosPr > 0
	aHeader[nlPosPr][11] := clCbox
EndIf

RestArea(aArea)
Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �MontaGrid		 �Autor  �Rodrigo A. Tosin    � Data � 17/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Rotina para montar grid de informacoes de tipos de documentos	   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil															   ���
������������������������������������������������������������������������������͹��
���Retorno   �Nil  							                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function MontaGrid()
Local clQuery 	:= ""
Local llRet		:= .T.

clQuery := "SELECT * FROM"											+ CRLF
clQuery += "("														+ CRLF
clQuery += "	SELECT "											+ CRLF
clQuery += "		ZAE_NUMEDI"										+ CRLF
clQuery += "		,ZAE_NUMCLI"									+ CRLF
clQuery += "		,ZAE_DTPVCL"									+ CRLF
clQuery += "		,ZAE_DTENTR"									+ CRLF
clQuery += "		,ZAE_CLIFAT"									+ CRLF
clQuery += "		,ZAE_LJFAT"										+ CRLF
clQuery += "		,ZAE_CONDPA"									+ CRLF
clQuery += "		,ZAE_TABPRC"									+ CRLF
clQuery += "		,ZAE_CLIENT"									+ CRLF
clQuery += "		,ZAE_LJENT"										+ CRLF
clQuery += "		,ZAE_TPFRET"									+ CRLF
clQuery += "		,ZAE_TOTAL"										+ CRLF
clQuery += "		,ZAE_OBSNF"										+ CRLF
clQuery += "		,ZAE_DESC1"										+ CRLF
clQuery += "		,ZAE_DESC2"										+ CRLF
clQuery += "		,ZAE_DESC3"										+ CRLF
clQuery += "		,ZAE_DESC4"										+ CRLF
clQuery += "		,ZAE_DESCFI"									+ CRLF
clQuery += "		,ZAE_VEND"										+ CRLF
clQuery += "		,ZAE_TRANSP"									+ CRLF
clQuery += "	FROM " + RetSQLName('ZAE')							+ CRLF
clQuery += "	WHERE"							  					+ CRLF
clQuery += "			ZAE_NUMEDI = '" + ZAE->ZAE_NUMEDI + "'"		+ CRLF
clQuery += "	 	AND	D_E_L_E_T_<>'*'"							+ CRLF
clQuery += ") ZAE"							   						+ CRLF
clQuery += "INNER JOIN"							 					+ CRLF
clQuery += "("														+ CRLF
clQuery += "	SELECT"						   	 					+ CRLF
clQuery += "		ZAF_ITEM"										+ CRLF
clQuery += "		,ZAF_NUMEDI"									+ CRLF
clQuery += "		,ZAF_EAN"										+ CRLF
clQuery += "		,ZAF_PRODUT"									+ CRLF
clQuery += "		,ZAF_QTD"										+ CRLF
clQuery += "		,ZAF_PRCUNI"									+ CRLF
clQuery += "		,ZAF_TOTAL"										+ CRLF
clQuery += "		,ZAF_DESC"	 									+ CRLF
clQuery += "		,ZAF_DESCRI"									+ CRLF
clQuery += "		,ZAF_PERCIP"									+ CRLF
clQuery += "		,ZAF_UM"			  							+ CRLF
clQuery += "		,ZAF_TES"										+ CRLF
clQuery += "		,ZAF_LOCAL"										+ CRLF
clQuery += "		,ZAF_VLRDSP"									+ CRLF
clQuery += "		,ZAF_VLRFRT"									+ CRLF
clQuery += "		,ZAF_VLRSEG"									+ CRLF
clQuery += "		,ZAF_SEQ"										+ CRLF
clQuery += "		,ZAF_OPER"										+ CRLF
clQuery += "	FROM " + RetSQLName('ZAF')							+ CRLF
clQuery += "	WHERE"						  						+ CRLF
clQuery += "		D_E_L_E_T_<>'*'"								+ CRLF
clQuery += ") ZAF"													+ CRLF
clQuery += "ON ZAE.ZAE_NUMEDI = ZAF.ZAF_NUMEDI" 					+ CRLF
/*
clQuery += "INNER JOIN"							 					+ CRLF
clQuery += "("														+ CRLF
clQuery += "	SELECT"						   	 					+ CRLF
clQuery += "		B1_COD,B1_DESC"									+ CRLF
clQuery += "	FROM " + RetSQLName('SB1')							+ CRLF
clQuery += "	WHERE"						  						+ CRLF
clQuery += "		D_E_L_E_T_<>'*'"								+ CRLF
clQuery += ") SB1"													+ CRLF
clQuery += "ON SB1.B1_COD = ZAF.ZAF_PRODUT" 						+ CRLF
*/
clQuery += "INNER JOIN" 					  						+ CRLF
clQuery += "(" 														+ CRLF
clQuery += "	SELECT" 											+ CRLF
clQuery += "		F4_CODIGO,F4_BASEICM" 					   		+ CRLF
clQuery += "	FROM " + RetSQLName("SF4")							+ CRLF
clQuery += "	WHERE" 												+ CRLF
clQuery += "		D_E_L_E_T_<>'*'" 					 			+ CRLF
clQuery += "		AND F4_FILIAL = '"+xFilial("SF4")+"'" 			+ CRLF
clQuery += ") SF4" 					   								+ CRLF
clQuery += "ON SF4.F4_CODIGO = ZAF.ZAF_TES" 					  	+ CRLF //Pesquisar diretamente na SF4, segundo Murilo em 22/05/2012 - 15:56
clQuery += " Order By ZAF_SEQ, ZAF_ITEM "							+ CRLF

clQuery := ChangeQuery(clQuery)

If Select("ZAEQRY") > 0
	ZAEQRY->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "ZAEQRY" ,.T.,.F.)

If ZAEQRY->(!EOF())
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Preenche campos do pedido EDI na tela 'Quebrar pedido EDI'																					   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	cpGetEDI    := ZAEQRY->ZAE_NUMEDI
	cpGetPCl    := ZAEQRY->ZAE_NUMCLI
	cpGetEmi   	:= dToC(sToD(ZAEQRY->ZAE_DTPVCL))
	cpGetEnt   	:= dToC(sToD(ZAEQRY->ZAE_DTENTR))
	cpGetCli  	:= ZAEQRY->ZAE_CLIFAT
	cpGetCon  	:= ZAEQRY->ZAE_CONDPA
	cpGetLoj  	:= ZAEQRY->ZAE_LJFAT
	cpGetTab  	:= ZAEQRY->ZAE_TABPRC
	cpGetClE  	:= ZAEQRY->ZAE_CLIENT
	cpGetLoE  	:= ZAEQRY->ZAE_LJENT
	cpGetFre  	:= ZAEQRY->ZAE_TPFRET
	cpGetTot 	:= ZAEQRY->ZAE_TOTAL
	cpGetObs	:= ZAEQRY->ZAE_OBSNF
	npDesc1		:= ZAEQRY->ZAE_DESC1
	npDesc2		:= ZAEQRY->ZAE_DESC2
	npDesc3		:= ZAEQRY->ZAE_DESC3
	npDesc4		:= ZAEQRY->ZAE_DESC4
	npDescF		:= ZAEQRY->ZAE_DESCFI
	cpVend		:= ZAEQRY->ZAE_VEND
	cpTransp	:= ZAEQRY->ZAE_TRANSP
	
	While ZAEQRY->(!EOF())
		aADD(aCols,{ZAEQRY->ZAF_SEQ,ZAEQRY->ZAF_ITEM,ZAEQRY->ZAF_EAN,"'" + ALLTRIM(ZAEQRY->ZAF_PRODUT) + "'",ZAEQRY->ZAF_DESCRI,ZAEQRY->ZAF_QTD,ZAEQRY->ZAF_PRCUNI,ZAEQRY->ZAF_TOTAL,ZAEQRY->ZAF_DESC,ZAEQRY->F4_BASEICM,ZAEQRY->ZAF_PERCIP,ZAEQRY->ZAF_VLRDSP,ZAEQRY->ZAF_VLRFRT,ZAEQRY->ZAF_VLRSEG,.F.})
		AADD(apProdutos,{ZAEQRY->ZAF_SEQ,ZAEQRY->ZAF_EAN,ZAEQRY->ZAF_PRODUT,ZAEQRY->ZAF_DESCRI,ZAEQRY->ZAF_UM,ZAEQRY->ZAF_TES,ZAEQRY->ZAF_LOCAL,ZAEQRY->ZAF_DESC,ZAEQRY->ZAF_PERCIP,ZAEQRY->F4_BASEICM,ZAEQRY->ZAF_OPER})
		
		ZAEQRY->(dbSkip())
	EndDo
Else
	llRet	:= .F.
EndIf
Return llRet
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �GeraPV		 �Autor  �Rodrigo A. Tosin    � Data � 17/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Rotina para gerar pedidos de venda atraves de um pedido EDI	   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil															   ���
������������������������������������������������������������������������������͹��
���Retorno   �llRet - .T. se criou os pedidos corretamente                     ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function GeraPV()

Local alArea 	:= GetArea()
Local clNum 	:= ''
Local alPVEstr 	:= {}
Local nlX 		:= 1
Local clSeq 	:= ""
Local nlPosPr	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRODUT")	})
Local nlPos		:= 0
//	Local clItem	:= '01'
Local nlPosItm	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_ITEM") 	 })
Local nlPosPU	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRCUNI")	})
Local nlPosQt	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_QTD") 		})
Local nlPosTo	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_TOTAL") 	})
Local nPosSeq	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_SEQ") 		})
Local clProd	:= ""
Local llRet		:= .T.
Local clQry		:= ""

//	Local clLetra	:= "C" //Tratamento para acrescentar letra quando filial for igual a "03"

Local nlCont    := 0
Local nSomaTot	:= 0

Local nlQtdMax	:= SuperGetMv("MV_MAXITPV",.F.,40)
Local nlParcMi	:= SuperGetMv("KZ_PARCMIN",.F.,500)
Local nlValMax	:= SuperGetMv("MV_VLMAXPV",.F.,80000)
Local alItens	:= ACLONE(oGetDados:aCols)

Private cpMsg	:= ""
Private cpSeq	:= ""
Private npXtotal:= 0
Private cpPvSq1 := ""
//	Private cpQtdPv	:= Replicate("0",TamSx3("ZAE_QTDPV")[1])


oGetDados:Refresh()


If aScan(alItens, {|x| Empty(x[nPosSeq]) }) > 0
	llRet := .F.
	ShowHelpDlg("Seq Branco",{"N�o � poss�vel gerar o Pedido de Venda, pois existe sequencia em Branco."},5,{"Realizar Manuten��o do Pedido EDI"},5)
	Return llRet
EndIf
//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Verifica quantidade de itens por sequencia no pedido EDI.																					   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
If Empty(nlQtdMax)
	llRet 	:= .F.
	ShowHelpDlg("MV_MAXITPV",{"Quantidade m�xima de itens n�o foi informada no par�metro MV_MAXITPV."},5,{"Preencha o valor da quantidade m�xima de itens por sequ�ncia no par�metro MV_MAXITPV"},5)
EndIf
If llRet
	clSeq := alItens[1][nPosSeq]
	For nlX := 1 to Len(alItens)
		If clSeq == alItens[nlX][nPosSeq]
			nlCont++
		Else
			clSeq 	:= alItens[nlX][nPosSeq]
			nlCont 	:= 1
		Endif
		If nlCont > nlQtdMax
			llRet 	:= .F.
			ShowHelpDlg("Itens",{"Quantidade de itens na sequ�ncia " + clSeq + " foi ultrapassada."},5,{"Altere o valor da sequ�ncia para adequar o total de itens, sendo at� " + cValToChar(nlQtdMax) + " itens (no m�ximo) em cada sequ�ncia, clicando em 'Manuten��o'."},5)
			Exit
		EndIf
	Next nlX
	clSeq := alItens[1][nPosSeq]
EndIf
//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Verifica valor m�ximo dos itens do pedido.																									   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
If Empty(nlValMax)
	ShowHelpDlg("MV_VLMAXPV",{"Valor m�ximo do pedido n�o foi informado."},5,{"Preencha o par�metro MV_VLMAXPV com o valor m�ximo que o pedido pode atingir, clicando em 'Manuten��o'."},5)
	llRet 	:= .F.
EndIf

If llRet
	For nlX := 1 to Len(alItens)
		If clSeq == alItens[nlX][nPosSeq]
			nSomaTot += alItens[nlX][nlPosTo]// VAL(STRTRAN(alItens[nlX][nlPosTo],".",""))
			M->&(cTabEDI + "_TOTAL") := nSomaTot
		Else
			clSeq 	 := alItens[nlX][nPosSeq]
			nSomaTot := alItens[nlX][nlPosTo]//VAL(STRTRAN(alItens[nlX][nlPosTo],".",""))
		Endif
	Next nlX
	If nSomaTot > nlValMax
		ShowHelpDlg("ValorM�x",{"Valor m�ximo do pedido foi ultrapassado."},5,{"Altere o valor dos itens para que o valor do pedido fique menor que R$" + cValToChar(nlValMax) + ", clicando em 'Manuten��o'."},5)
		llRet 	:= .F.
	EndIf
	nSomaTot := 0
EndIf

//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Verifica valor de parcela minima 																											   �
//��������������������������������������������������������������������������������������������������������������������������������������������������
If Empty(nlParcMi)
	ShowHelpDlg("KZ_PARCMIN",{"Valor da parcela n�o foi informado no par�metro KZ_PARCMIN."},5,{"Preencha o valor m�nimo do pedido no par�metro KZ_PARCMIN."},5)
	llRet 	:= .F.
EndIf
If llRet
	
	clQuery	 := "SELECT E4_CODIGO FROM " + RetSQLName('SE4') + " WHERE E4_FILIAL = '" + xFilial("SE4") + "' AND E4_CODIGO = '" + (cTabEDI)->&(cTabEDI + "_CONDPA") + "' AND D_E_L_E_T_ <> '*'"
	
	clQuery := ChangeQuery(clQuery)
	
	If Select("SE4QRY") > 0
		SE4QRY->(dbCloseArea())
	EndIf
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "SE4QRY",.T.,.F.)
	If SE4QRY->(!EOF())
		
		alParcel := Condicao((cTabEDI)->&(cTabEDI + "_TOTAL"),(cTabEDI)->&(cTabEDI + "_CONDPA"),0,dDataBase,0)
		
		If Len(alParcel) > 0
			nlValPar := alParcel[1][2]
		Else
			nlValPar := 0
		EndIf
		
		If  nlValPar < nlParcMi
			llRet 	:= .F.
			ShowHelpDlg("ValorM�n",{"Valor da parcela n�o atingiu valor m�nimo de R$" + cValToChar(nlParcMi) +"."},5,{"Altere o valor do pedido para que o valor atinja a parcela m�nima exigida, clicando em 'Manuten��o'."},5)
			
		EndIf
	Else
		ShowHelpDlg("CondPag",{"Condi��o de pagamento '" + ALLTRIM((cTabEDI)->&(cTabEDI + "_CONDPA")) + "' n�o existe no sistema."},5,{"Verifique o cadastro de condi��es de pagamento."},5)
		llRet 	:= .F.
	EndIf
EndIf
If llRet
	clSeq	:=	alItens[1][nPosSeq]
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Retorna o proximo numero do pedido de vendas na SC5.	  																						   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	
	dbSelectArea("SC5")
	SC5->(dbSetOrder(1))
	SC5->(dbGoBottom())
	
	//		If Empty(SC5->C5_NUM)
	//			clNum := STRZERO(1,6)
	//		Else
	//			clNum := Soma1(SC5->C5_NUM)
	//		EndIf
	
	//clNum	:=	IIF(xFilial("SC5")=="03",clLetra,"") + GETSXENUM("SC5", SC5->C5_NUM,, 1)
	cpPvSq1:= clNum	:=	U_NCGNUMPV()
	
	//		cpQtdPv := Soma1(cpQtdPv)
	
	For nlX := 1 to Len(oGetDados:aCols)
		//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
		//�Verifica se item da GetDados esta ativo																										   �
		//��������������������������������������������������������������������������������������������������������������������������������������������������
		
		If llRet .AND. !oGetDados:aCols[nlX][Len(aHeader)+1]
			
			//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
			//�Verifica se sequencia igual a anterior. Gera um pedido de venda na SC5 para cada sequencia diferente encontrada.								   �
			//��������������������������������������������������������������������������������������������������������������������������������������������������
			
			If llRet .AND. clSeq == oGetDados:aCols[nlX][1]
				//��������������������������������������������������������������Ŀ
				//�Faz a somatoria do total de despesas, frete e seguro para     �
				//�incluir no cabecalho do pedido de venda.                      �
				//�                                                              �
				//�Alfredo A. Magalhaes                                          �
				//����������������������������������������������������������������
				npTDesp	:= 0//npTDesp	+= oGetDados:aCols[nlX][11]
				npTFrete+= oGetDados:aCols[nlX][13]
				npSeguro+= oGetDados:aCols[nlX][14]
				npXTotal+= oGetDados:aCols[nlX][nlPosTo]
				
				cpSeq := clSeq
				clProd	:= STRTRAN(ALLTRIM(oGetDados:aCols[nlX][nlPosPr]),"'","")
				nlPos := aScan(apProdutos,{|x| ALLTRIM(x[1]) == clSeq .AND. ALLTRIM(x[3]) == clProd})
				If nlPos > 0
					aItemPV(clNum,oGetDados:aCols[nlX][nlPosItm],apProdutos[nlPos][3],apProdutos[nlPos][4],apProdutos[nlPos][5],oGetDados:aCols[nlX][nlPosQt],oGetDados:aCols[nlX][nlPosPU],oGetDados:aCols[nlX][nlPosTo],apProdutos[nlPos][6],cpGetCli,cpGetLoj,apProdutos[nlPos][7],apProdutos[nlPos][8],apProdutos[nlPos][11])
					//aItemPV(clNum,clItem,apProdutos[nlPos][3],apProdutos[nlPos][4],apProdutos[nlPos][5],oGetDados:aCols[nlX][nlPosQt],oGetDados:aCols[nlX][nlPosPU],oGetDados:aCols[nlX][nlPosTo],apProdutos[nlPos][6],cpGetCli,cpGetLoj,apProdutos[nlPos][7],apProdutos[nlPos][8],apProdutos[nlPos][11])
					//clItem := Soma1(clItem)
				EndIf
			Else
				//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
				//�Sequencia diferente encontrada. Grava o pedido para a sequencia antiga e substitui a variavel pela sequencia nova para continuar o processo.	   �
				//��������������������������������������������������������������������������������������������������������������������������������������������������
				
				llRet 	:= !CabecPV(clNum)
				If llRet
					//��������������������������������������������������������������Ŀ
					//�Faz a somatoria do total de despesas, frete e seguro para     �
					//�incluir no cabecalho do pedido de venda.                      �
					//�                                                              �
					//�Alfredo A. Magalhaes                                          �
					//����������������������������������������������������������������
					npTDesp	:= 0
					npTFrete:= 0
					npSeguro:= 0
					npXTotal:= 0
					npTDesp	:= 0//npTDesp	+= oGetDados:aCols[nlX][11]
					npTFrete+= oGetDados:aCols[nlX][13]
					npSeguro+= oGetDados:aCols[nlX][14]
					npXTotal+= oGetDados:aCols[nlX][nlPosTo]
					clSeq 	:= oGetDados:aCols[nlX][1]
					cpSeq 	:= clSeq
					
					//			CONFIRMSXE(.F.) //se gravou novo pedido, entao atualizar controle de numeracao
					
					clNum	:=	U_NCGNUMPV()
					//Acrescenta a quantidade de Pedidos que ser�o gerados
					//						cpQtdPv := Soma1(cpQtdPv)
					
					clProd	:= STRTRAN(ALLTRIM(oGetDados:aCols[nlX][nlPosPr]),"'","")
					nlPos 	:= aScan(apProdutos,{|x| ALLTRIM(x[1]) == clSeq .AND. ALLTRIM(x[3]) == clProd})
					If nlPos > 0
						aItemPV(clNum,oGetDados:aCols[nlX][nlPosItm],apProdutos[nlPos][3],apProdutos[nlPos][4],apProdutos[nlPos][5],oGetDados:aCols[nlX][nlPosQt],oGetDados:aCols[nlX][nlPosPU],oGetDados:aCols[nlX][nlPosTo],apProdutos[nlPos][6],cpGetCli,cpGetLoj,apProdutos[nlPos][7],apProdutos[nlPos][8],apProdutos[nlPos][11])
						//aItemPV(clNum,clItem,apProdutos[nlPos][3],apProdutos[nlPos][4],apProdutos[nlPos][5],oGetDados:aCols[nlX][nlPosQt],oGetDados:aCols[nlX][nlPosPU],oGetDados:aCols[nlX][nlPosTo],apProdutos[nlPos][6],cpGetCli,cpGetLoj,apProdutos[nlPos][7],apProdutos[nlPos][8],apProdutos[nlPos][11])
						//clItem := '01'
					EndIf
				Else
					ROLLBACKSXE() //se nao gravou novo pedido, entao voltar numeracao para novo uso
				EndIf
			EndIf
		EndIf
	Next nlX
	
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Gera pedido de venda na SC5.																													   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	llRet 	:= !CabecPV(clNum)
	
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Altera Status do pedido EDI para '5 - Encerrado, pedido de venda gerado'																		   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	If llRet
		
		dbSelectArea("ZAE")
		ZAE->(dbSetOrder(1))
		ZAE->(dbGoTop())
		If ZAE->(dbSeek(xFilial("ZAE")+cpGetEDI+cpGetCli+cpGetLoj))
			If RecLock("ZAE",.F.)
				ZAE->ZAE_STATUS := '5'
				//					ZAE->ZAE_NUMPV	:= cpPvSq1
				//					ZAE->ZAE_DTPV	:= dDataBase
				//					ZAE->ZAE_QTDPV	:= cpQtdPv
			EndIf
			ZAE->(MsUnlock())
		EndIf
		/*
		//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
		//�Altera o status, insere o numero do pedido de venda, a data em que foi gerado e a observacao para a NF da tabela de Revisoes de Versoes		   �
		//��������������������������������������������������������������������������������������������������������������������������������������������������
		clQry := " SELECT MAX(ZAH_VERSAO),ZAH_VERSAO,ZAH_NUMEDI, ZAH_CLIFAT, ZAH_LJFAT FROM "+RETSQLNAME("ZAH")+CRLF
		clQry += " WHERE ZAH_FILIAL = '"+xFilial("ZAH")+"'"+CRLF
		clQry += " AND ZAH_NUMEDI = '"+cpGetEDI+"' "+CRLF
		clQry += " AND ZAH_CLIFAT = '"+cpGetCli+"' "+CRLF
		clQry += " AND ZAH_LJFAT = '"+cpGetLoj+"' "+CRLF
		clQry += " AND D_E_L_E_T_ <> '*'" +CRLF
		clQry += " GROUP BY ZAH_VERSAO, ZAH_NUMEDI, ZAH_CLIFAT, ZAH_LJFAT " +CRLF
		
		clQry := ChangeQuery(clQry)
		
		If Select("ZAHQRY") > 0
		ZAHQRY->(dbCloseArea())
		EndIf
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQry), "ZAHQRY" ,.T.,.F.)
		
		If ZAHQRY->(!EOF())
		dbSelectArea("ZAH")
		ZAH->(dbSetOrder(2))
		ZAH->(dbGoTop())
		If ZAH->(dbSeek(xFilial("ZAH")+ZAHQRY->ZAH_NUMEDI+ZAHQRY->ZAH_CLIFAT+ZAHQRY->ZAH_LJFAT+ZAHQRY->ZAH_VERSAO))
		If RecLock("ZAH",.F.)
		//ZAH->ZAH_STATUS := '5'
		ZAH->ZAH_NUMPV	:= clNum
		ZAH->ZAH_DTPV	:= dDataBase
		ZAH->ZAH_OBSNF	:= cpGetObs
		EndIf
		ZAH->(MsUnlock())
		EndIf
		EndIf
		
		//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
		//�Altera o status, insere o numero do pedido de venda, a data em que foi gerado e a observacao para a NF da tabela de Importacao de Pedido EDI	   �
		//��������������������������������������������������������������������������������������������������������������������������������������������������
		
		clQry := " SELECT ZAJ_NUMALT, ZAJ_CLIFAT, ZAJ_LJFAT FROM "+RETSQLNAME("ZAJ")+CRLF
		clQry += " WHERE ZAJ_FILIAL = '"+xFilial("ZAJ")+"'"+CRLF
		clQry += " AND ZAJ_NUMCLI = '"+cpGetPCl+"' "+CRLF
		clQry += " AND ZAJ_STATUS = '2' "+CRLF
		clQry += " AND D_E_L_E_T_ <> '*'" +CRLF
		clQry += " GROUP BY ZAJ_NUMEDI, ZAJ_CLIFAT, ZAJ_LJFAT " +CRLF
		
		clQry := ChangeQuery(clQry)
		
		If Select("ZAJQRY") > 0
		ZAJQRY->(dbCloseArea())
		EndIf
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQry), "ZAJQRY" ,.T.,.F.)
		
		dbSelectArea("ZAJ")
		ZAJ->(dbSetOrder(1))
		ZAJ->(dbGoTop())
		If ZAJ->(dbSeek(xFilial("ZAJ")+ZAJQRY->ZAJ_NUMALT+ZAJQRY->ZAJ_CLIFAT+ZAJQRY->ZAJ_LJFAT))
		If RecLock("ZAJ",.F.)
		//ZAJ->ZAJ_STATUS := '5'
		ZAJ->ZAJ_NUMPV	:= clNum
		ZAJ->ZAJ_DTPV	:= dDataBase
		ZAJ->ZAJ_OBSNF	:= cpGetObs
		EndIf
		ZAJ->(MsUnlock())
		EndIf
		*/
		MsgInfo("Pedido EDI: " + cpGetEDI + CRLF + "Pedidos de Venda gerados:" + cpMsg,"Pedido Gerado!")
		
	Else
		MsgStop("Ocorreu um ou mais erros durante a gera��o do Pedido de Vendas." + CRLF + "Nenhum pedido de venda foi gerado.","Erro")
		ROLLBACKSXE() //se nao gravou novo pedido, entao voltar numeracao para novo uso
	EndIf
	
EndIf
RestArea(alArea)
Return llRet
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �ValTot         �Autor  �Rodrigo A. Tosin    � Data � 21/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Valida total do produto						    			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil															   ���
������������������������������������������������������������������������������͹��
���Retorno   �llRet - .T. se validou corretamente, .F. se nao validou          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function ValTot()
Local nlPosPU	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRCUNI") 		})
Local nlPosQt	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_QTD") 			})
Local nlPosTo	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_TOTAL") 		})

oGetDados:Refresh()
ProcessMessages()
//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Multiplica o valor da quantidade pelo preco do produto para resultar no valor total.															   �
//��������������������������������������������������������������������������������������������������������������������������������������������������

oGetDados:aCols[oGetDados:nAt][nlPosTo]	 := oGetDados:aCols[oGetDados:nAt][nlPosPU] * oGetDados:aCols[oGetDados:nAt][nlPosQt]
Return .T.
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �LinOk	         �Autor  �Rodrigo A. Tosin    � Data � 21/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Valida linha da GetDados						    			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil															   ���
������������������������������������������������������������������������������͹��
���Retorno   �U_OGDField() - .T. se validou corretamente, .F. se nao validou   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function LinOk()
Return U_OGDField()
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �OGDField       �Autor  �Rodrigo A. Tosin    � Data � 21/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Valida campo da GetDados						    			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil															   ���
������������������������������������������������������������������������������͹��
���Retorno   �llRet - .T. se validou corretamente, .F. se nao validou          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function OGDField()
Local nlPosEA 	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_EAN") 			})
Local nlPosPr 	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRODUT") 		})
Local nlPosDe	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("B1_DESC") 		})
Local nlPosPU	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRCUNI") 		})
Local nlPosQt	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_QTD") 			})
Local nlPosTo	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_TOTAL") 		})
Local nPosDes	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_DESC") 		})
Local nPosIPI	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PERCIP") 		})
Local nPosICM	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("F4_BASEICM") 		})
Local nlPos 	:= 0
Local llRet		:= .T.

oGetDados:Refresh()
//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Verifica se item da GetDados esta ativo																										   �
//��������������������������������������������������������������������������������������������������������������������������������������������������

If !oGetDados:aCols[oGetDados:nAt][Len(aHeader)+1]
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Verifica se codigo do produto esta preenchido e se o codigo EAN esta em branco e se descricao de produto esta em branco.						   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	If !EMPTY(STRTRAN(ALLTRIM(oGetDados:aCols[oGetDados:nAt][nlPosPr]),"'","")) //.AND. EMPTY(oGetDados:aCols[oGetDados:nAt][nlPosDe]) .AND.EMPTY(oGetDados:aCols[oGetDados:nAt][nlPosEA])
		nlPos := aScan(apProdutos,{|x| ALLTRIM(x[2]) == STRTRAN(ALLTRIM(oGetDados:aCols[oGetDados:nAt][nlPosPr]),"'","")})
		//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
		//�Verifica se produto informado esta originalmente no pedido EDI. Se nao estiver, exibe mensagem ao usuario informando.						   �
		//��������������������������������������������������������������������������������������������������������������������������������������������������
		
		If nlPos == 0
			ShowHelpDlg("Inv�lido",{"Produto " + STRTRAN(ALLTRIM(oGetDados:aCols[oGetDados:nAt][nlPosPr]),"'","") + " n�o pertence ao Pedido EDI original."},5,{"Altere o c�digo do produto para um produto que j� esteja no pedido EDI originalmente."},5)
			oGetDados:oBrowse:ColPos :=  nlPosPr
			llRet := .F.
		Else
			//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
			//�Pesquisa informacao do produto informado na GetDados, campos de Codigo EAN, Descricao do produto, % desconto e % IPI.						   �
			//��������������������������������������������������������������������������������������������������������������������������������������������������
			
			oGetDados:aCols[oGetDados:nAt][nlPosDe]	 := apProdutos[nlPos][3]
			oGetDados:aCols[oGetDados:nAt][nlPosEA] := apProdutos[nlPos][1]
			oGetDados:aCols[oGetDados:nAt][nPosDes] := apProdutos[nlPos][7]
			oGetDados:aCols[oGetDados:nAt][nPosIPI] := apProdutos[nlPos][8]
			oGetDados:aCols[oGetDados:nAt][nPosICM] := apProdutos[nlPos][9]
		EndIf
	EndIf
	//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�Multiplica o valor da quantidade pelo preco do produto para resultar no valor total.															   �
	//��������������������������������������������������������������������������������������������������������������������������������������������������
	
	oGetDados:aCols[oGetDados:nAt][nlPosTo]	 := oGetDados:aCols[oGetDados:nAt][nlPosPU] * oGetDados:aCols[oGetDados:nAt][nlPosQt]
EndIf
Return llRet

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �OGDChange      �Autor  �Rodrigo A. Tosin    � Data � 21/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �AO mudar foco da GetDados, atualiza valor total    			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�Nil															   ���
������������������������������������������������������������������������������͹��
���Retorno   �Nil                                                              ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

User Function OGDChange()
Local nlPosPU	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_PRCUNI") 		})
Local nlPosQt	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_QTD") 			})
Local nlPosTo	:= aScan(aHeader, {|x| ALLTRIM(x[2]) == ALLTRIM("ZAF_TOTAL") 		})
oGetDados:Refresh()
//������������������������������������������������������������������������������������������������������������������������������������������������Ŀ
//�Multiplica o valor da quantidade pelo preco do produto para resultar no valor total.															   �
//��������������������������������������������������������������������������������������������������������������������������������������������������

oGetDados:aCols[oGetDados:nAt][nlPosTo]	 := oGetDados:aCols[oGetDados:nAt][nlPosPU] * oGetDados:aCols[oGetDados:nAt][nlPosQt]
Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �CabecPV        �Autor  �Rodrigo A. Tosin    � Data � 19/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Gera pedido de venda 							    			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   �                                                                 ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function CabecPV(clNum)

Local alHeadPv 		:= {}
Local nlOpc   		:= 3
Local clNumAnt		:= clNum //STRZERO(Val(clNum)-1,3)

Private lMsErroAuto	:= .F.

aAdd(alHeadPv,{"C5_FILIAL"	,xFilial("SC5")																		,nil})	//Filial
aAdd(alHeadPv,{"C5_NUM"		,clNum  	   																		,nil})	//Nro do Pedido
aAdd(alHeadPv,{"C5_TIPO"	,"N"   		   																		,nil}) 	//Tipo de Pedido
aAdd(alHeadPv,{"C5_CLIENTE"	,cpGetCli	   																		,nil})	//Codigo de Cliente
aAdd(alHeadPv,{"C5_LOJACLI"	,cpGetLoj																			,nil})	//loja do Cliente

// 	26/10/2012	Veronica de Almeida
// 	alterado para buscar o tipo de cliente do cadastro SA1
// 	aAdd(alHeadPv,{"C5_TIPOCLI"	,"F"																				,nil}) 	//Tipo de Cliente
aAdd(alHeadPv,{"C5_TIPOCLI"	,Posicione("SA1",1,xFilial("SA1")+Alltrim(cpGetCli)+AllTrim(cpGetLoj),"A1_TIPO")	,nil}) 	//Tipo de Cliente
// 	final das alteracoes

aAdd(alHeadPv,{"C5_XSTAPED"	,"15"     	   																		,nil})	//Status do SF
aAdd(alHeadPv,{"C5_CONDPAG"	,cpGetCon 	   																		,nil})	//Condicao de Pagamento
aAdd(alHeadPv,{"C5_TABELA"	,cpGetTab																			,nil})	//Tabela de Preco
aAdd(alHeadPv,{"C5_EMISSAO"	,dDataBase																			,nil})	//Data de Emissao
aAdd(alHeadPv,{"C5_TPFRETE"	,cpGetFre																			,nil})	//Tipo de frete
aAdd(alHeadPv,{"C5_ENTREG"	,ctoD(cpGetEnt)																		,nil})	//Data de entrega
aAdd(alHeadPv,{"C5_MENNOTA"	,cpGetObs																			,nil})	//Observacao para a NF
aAdd(alHeadPv,{"C5_NUMEDI"	,cpGetEDI																			,nil})	//Numero do pedido EDI
aAdd(alHeadPv,{"C5_DESPESA"	,npTDesp																			,nil})	//Valor das Despesas dos itens.
aAdd(alHeadPv,{"C5_DESC1"	,npDesc1																			,nil})	//Valor do desconto 1
aAdd(alHeadPv,{"C5_DESC2"	,npDesc2																			,nil})	//Valor do desconto 2
aAdd(alHeadPv,{"C5_DESC3"	,npDesc3																			,nil})	//Valor do desconto 3
aAdd(alHeadPv,{"C5_DESC4"	,npDesc4																			,nil})	//Valor do desconto 4
aAdd(alHeadPv,{"C5_DESCFI"	,npDescF																			,nil})	//Valor do desconto financeiro
aAdd(alHeadPv,{"C5_VEND1"	,cpVend																				,nil})	//Codigo do vendedor
aAdd(alHeadPv,{"C5_TRANSP"	,cpTransp																			,nil})	//Codigo da transportadora
aAdd(alHeadPv,{"C5_FRETE"	,npTFrete																			,nil})	//Valor total do frete
aAdd(alHeadPv,{"C5_SEGURO"	,npSeguro																			,nil})	//Valor total do seguro
aAdd(alHeadPv,{"C5_SEQ"		,cpSeq	  																			,nil})	//Valor da sequencia

BEGIN TRANSACTION
	MsExecAuto({|x,y,z| mata410(x,y,z)},alHeadPv,apPVEstr,nlOpc)

If lMsErroAuto
	MostraErro()
	lpTransacao := .F.
	DisarmTransaction()
Else
	alArea := GetArea()
	DbSelectArea("SC5")
	SC5->(DbSetOrder(1))
	SC5->(DbGoTop())
	If SC5->(DbSeek(xFilial("SC5")+clNum))
		If RecLock("SC5", .F.)
			SC5->C5_DESC4	:= npDesc4
			SC5->C5_LOJAENT	:= cpGetLoE
			SC5->C5_CLIENT	:= cpGetClE
			SC5->C5_PEDCLI	:= cpGetPCl
			SC5->(MsUnlock())
		EndIf
	EndIf
	RestArea(alArea)
	
	// FUNCAO COMENTADA pois o campo C5_XTOTAL (customizado NCGAMES) � VIRTUAL
	/*			alArea := GetArea()
	DbSelectArea("SC5")
	If SC5->(FieldPos("C5_XTOTAL")) > 0
	SC5->(DbSetOrder(1))
	SC5->(DbGoTop())
	If SC5->(DbSeek(xFilial("SC5")+clNum))
	If RecLock("SC5", .F.)
	SC5->C5_XTOTAL := npXTotal
	SC5->(MsUnlock())
	EndIf
	EndIf
	EndIf
	
	*/
	cpMsg += CRLF + " - " + clNum
	
EndIf
apPVEstr :=	{}
END TRANSACTION
Return lMsErroAuto

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �aItemPV	     �Autor  �Rodrigo A. Tosin    � Data � 19/05/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Inclui os itens do pedido de venda			    			   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames                                                          ���
������������������������������������������������������������������������������͹��
���Parametros�clItem, clCod,clUM,nlQuant,nlPrcVen,nlTotal,clTES,clCodCli,	   ���
���			 �clLojCli,clDoc,clSerie,alItemPv								   ���
������������������������������������������������������������������������������͹��
���Retorno   �                                                                 ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/                     //  1   2      3      4      5    6       7        8       9     10       11         12      13      14
Static Function aItemPV(clNum,clItem,clCod,clDesc,clUM,nlQuant,nlPrcVen,nlTotal,clTES,clCodCli,clLojCli,clLocal,clDescon,clOper)
/*
aItemPV(clNum,                              1
clItem,                             2
apProdutos[nlPos][3],               3
apProdutos[nlPos][4],               4
apProdutos[nlPos][5],               5
oGetDados:aCols[nlX][nlPosQt],      6
oGetDados:aCols[nlX][nlPosPU],      7
oGetDados:aCols[nlX][nlPosTo],      8
apProdutos[nlPos][6],               9
cpGetCli,                           10
cpGetLoj,                           11
apProdutos[nlPos][7],      			12
apProdutos[nlPos][8],               13
apProdutos[nlPos][11])              14


AADD(apProdutos,{	ZAEQRY->ZAF_SEQ,   1
ZAEQRY->ZAF_EAN,   2
ZAEQRY->ZAF_PRODUT,3
ZAEQRY->ZAF_DESCRI,4
ZAEQRY->ZAF_UM,     5
ZAEQRY->ZAF_TES,     6
ZAEQRY->ZAF_LOCAL,    7
ZAEQRY->ZAF_DESC,      8                             
ZAEQRY->ZAF_PERCIP,     9
ZAEQRY->F4_BASEICM,      10
ZAEQRY->ZAF_OPER})	11
*/

Local alItemPv	 := {}

aAdd(alItemPv,{"C6_FILIAL"	,xFilial("SC6")		,nil})
aAdd(alItemPv,{"C6_ITEM"	,clItem				,nil}) //Item do pedido: Obrigatorio
aAdd(alItemPv,{"C6_PRODUTO"	,clCod				,nil}) //Codigo do produto: Obrigatorio
aAdd(alItemPv,{"C6_UM"		,clUM 				,nil}) //Unidade de medida
aAdd(alItemPv,{"C6_QTDVEN"	,nlQuant   			,nil}) //Quantidade: Obrigatorio
aAdd(alItemPv,{"C6_PRCVEN"	,nlPrcVen  			,nil}) //Valor de Venda
aAdd(alItemPv,{"C6_PRUNIT"	,nlPrcVen  			,nil}) //Valor de Venda
aAdd(alItemPv,{"C6_VALOR"	,nlTotal			,nil}) //Valor Total: Obrigatorio
aAdd(alItemPv,{"C6_QTDLIB"	,0					,nil}) //Quantidade Liberada: Obrigatorio
aAdd(alItemPv,{"C6_OPER"	,clOper				,nil}) //Tipo de Operacao
aAdd(alItemPv,{"C6_TES"		,clTES		   		,nil}) //TES: Obrigatorio
aAdd(alItemPv,{"C6_LOCAL"	,clLocal			,nil}) //Armazem: Obrigatorio
aAdd(alItemPv,{"C6_CLI"		,clCodCli	   		,nil}) //Codigo do Cliente: Obrigatorio
aAdd(alItemPv,{"C6_LOJA"	,clLojCli	   		,nil}) //Loja do cliente: Obrigatorio
aAdd(alItemPv,{"C6_NUM"		,clNum		   		,nil}) 	//Numero do Pedido
aAdd(alItemPv,{"C6_DESCONT"	,clDescon	   		,nil}) 	//% Desconto
aAdd(alItemPv,{"C6_DESCRI"	,clDesc				,nil}) //Descricao do produto

AADD(apPVEstr,alItemPv)
alItemPv:= {}
Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KZVeriAlt	     �Autor  �Alfredo A. Magalh�es� Data � 14/06/2012  ���
������������������������������������������������������������������������������͹��
���Desc.     �Fun��o para verificar se existem altera��es pendentes para o	   ���
���			 �pedido EDI na tabela ZAJ.                                        ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames                                                          ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   �llRet - .F. se n�o existe, .T. se existe                         ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KZVeriAlt()

Local llRet		:= .F.
Local clQuery	:= ""

clQuery	:= " SELECT ZAJ_STATUS FROM " + RETSQLNAME("ZAJ") + CRLF
clQuery	+= " 		WHERE	D_E_L_E_T_ <> '*' " + CRLF
clQuery	+= " 				AND ZAJ_FILIAL = '" + xFilial("ZAJ") + "' " + CRLF
clQuery	+= " 				AND ZAJ_STATUS = '1' " + CRLF
clQuery	+= " 				AND ZAJ_NUMCLI = '" + ZAE->ZAE_NUMCLI+ "' " + CRLF

clQuery := ChangeQuery(clQuery)

If Select("QRY1") > 0
	QRY1->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "QRY1" ,.T.,.F.)

If QRY1->(!EOF())//QRY1->(!EOF())
	llRet := .T.
EndIf
QRY1->(dbCloseArea())
Return llRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �KZNCG11   �Autor  �ERICH BUTTNER       � Data �  26/06/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao que retorna proximo numero do pedido de venda       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGNUMPV()
Local _NUMPED := ""
_NUMPED := &(POSICIONE("SX3",2,"C5_NUM","X3_RELACAO"))
CONFIRMSX8() // ALTERADO 27/06/12
Return _NUMPED