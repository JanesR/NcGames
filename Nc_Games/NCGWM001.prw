#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/27/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001Menu()

Processa({||U_WM001JOB({"01","03",.F.}) })

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM001JB1  �Autor  �Microsiga           � Data �  06/09/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Job responsavel pela atualiza��o de pre�o/estoque de forma  ���
���          � automatica.                                                ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001JB1(aDados)

Default aDados:={"01","03"}

RpcSetType(3)
RpcSetEnv(aDados[1],aDados[2])

WM001Update()

RpcClearEnv()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM001JB2  �Autor  �Microsiga           � Data �  06/09/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Job responsavel pela importa��o de pedidos de forma        ���
���          � automatica.                                                ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001JB2(aDados)

Default aDados:={"01","03"}

RpcSetType(3)
RpcSetEnv(aDados[1],aDados[2])

U_WM001GETPC()

RpcClearEnv()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM001PV   �Autor  �Microsiga           � Data �  02/17/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina responsavel pela abertura do broswer MATA410-pedidos���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001PV()

MATA410()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM001PV   �Autor  �Microsiga           � Data �  02/17/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina responsavel pela abertura do broswer MATA440-pedidos���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001LB()

MATA440()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WM001Update()

Local aAreaAtu		:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local aAreaSA7		:= SA7->(GetArea())
Local aAreaSB2		:= SB2->(GetArea())
Local aAreaSB1		:= SB1->(GetArea())

Local cFilSA7		:= xFilial("SA7")
Local cFilSB2		:= xFilial("SB2")
Local cFilSB1 		:= xFilial("SB1")

Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local aArmazem		:= Separa(  AllTrim( SuperGetmv("WM_ARMAZEM",,"01"  )),";" )
Local aNotFound	:= {}
Local cProduto
Local cCpoQry
Local cCodTab
Local aUf
Local cUpdate
Local lFound
Local nSaldo
Local nInd
Local cProdSIPI 	:= Alltrim(SuperGetMv("NCG_000043",.t.,"85234990")) //NCM de produtos que devem aparecer com o IPI 0 para S�o Paulo
Local cChaveSA7	:= cFilSA7+"00000001"
Local cProdNot		:= ""
Local cPrevenda
Local cProdExcl

If !oConectDB:OpenConnection()
	Return
EndIf

_SetOwnerPrvt( "cParTab" , Alltrim(U_MyNewSX6("NCG_000063","018;107;112","C","Tabela de pre�os que aparecem no relat�rio","","",.F. )   ) )

cCpoQry	:= "SB1.B1_COD,"
cCpoQry	+= " SB1.B1_CODBAR,"
cCpoQry	+= " SB1.B1_XDESC,"
cCpoQry	+= " SB1.B1_PUBLISH,"
cCpoQry	+= " SB1.B1_PLATEXT,"
cCpoQry	+= " SB1.B1_CODGEN,"
cCpoQry	+= " SB1.B1_TECNOC,"
cCpoQry	+= " SB1.B1_CONSUMI,"
cCpoQry	+= " SB1.B1_IPI,"
cCpoQry	+= " SB1.B1_POSIPI,"
cCpoQry	+= " B5_YPREVEN,"
cCpoQry	+= " B1_LANC,"
cCpoQry	+= " DA1.DA1_CODTAB,"
cCpoQry	+= " DA1.DA1_PRCVEN,"
cCpoQry	+= " SB5.B5_YFRANCH "

cQuery	:= U_RL204Query(cCpoQry," Order By B1_COD,DA1_CODTAB",.F.,.F.)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)

cUpdate:="UPDATE [dbo].[produto_preco_uf] SET  [Ativo] =0"  // 0=Desabilita todos os produtos, 1=Habilita
u_WM001Exec(cUpdate,oConectDB)

SA7->(DbSetOrder(1))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
SB2->(DbSetOrder(1))//B2_FILIAL+B2_COD+B2_LOCAL
SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD

Do While (cAliasQry)->(!Eof())
	
	cProduto		:= (cAliasQry)->B1_COD
	cSriptPreco	:= ""
	cProdExcl	:= (cAliasQry)->B5_YFRANCH
	
	If !SA7->(MsSeek(cChaveSA7+cProduto))
		If Ascan(aNotFound,cProduto)==0
			AADD(aNotFound,cProduto)
		EndIf
		(cAliasQry)->(DbSkip());Loop
	EndIf
	SB1->(DbSeek(cFilSB1+cProduto))
	
	Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->B1_COD==cProduto
		
		cPrevenda	:= (cAliasQry)->B5_YPREVEN
		cCodTab		:= (cAliasQry)->DA1_CODTAB
		
		If cCodTab=="018"
			aUf:={"SP"}
		ElseIf cCodTab=="107"
			aUf:={"AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MT","MS","PA","PB","PE","PI","RN","RO","RR","SE","TO"}
		ElseIf cCodTab=="112"
			aUf:={"MG","PR","RS","RJ","SC"}
		EndIf
		
		Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->B1_COD==cProduto .And. (cAliasQry)->DA1_CODTAB==cCodTab
			MyMensagem("Produto "+cProduto)
			cSriptPreco+=WM001Preco(aUf,cAliasQry)
			(cAliasQry)->(DbSkip())
		EndDo
		
	EndDo
	
	nSaldo:=0
	
	If cPrevenda<>"S"
		For nInd:=1 To Len(aArmazem)
			If SB2->(MsSeek(cFilSB2+cProduto+AllTrim(aArmazem)))
				nSaldo+=SaldoSB2()
			EndIf
		Next
	EndIf
	
	cUpdate := WM001Dados(cAliasQry,cSriptPreco,nSaldo,cProdSIPI,cPreVenda,cProdExcl)
	U_WM001Exec(cUpdate,oConectDB)
	
EndDo

(cAliasQry)->(DbCloseArea())

oConectDB:CloseConnection()
oConectDB:Finish()


RestArea(aAreaSA7)
RestArea(aAreaSB1)
RestArea(aAreaSB2)
RestArea(aAreaAtu)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function WM001Preco(aUf,cAliasQry)
Local cScript:=""
Local nInd
Local cValor:=AllTrim( Str((cAliasQry)->DA1_PRCVEN) )

For nInd:=1 To Len(aUf)
	cScript+="["+aUf[nInd]+"]="+cValor+","+CRLF
Next


Return cScript
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WM001Dados(cAliasQry,cSriptPreco,nSaldo,cProdSIPI,cPreVenda,cProdExcl)
Local cScript:=""
Local nVlrIPI

Default cPreVenda	:= "N"
Default cProdExcl := "N"

If SB1->B1_POSIPI $ cProdSIPI  	//Adicionado para atender a exce��o de Curitiba - Lucas Felipe - 30/09
	nVlrIPI:=0
Else
	nVlrIPI:=SB1->B1_IPI //Adicionado para atender a exce��o de Curitiba - Lucas Felipe - 30/09
EndIf
//nVlrIPI/=100

cScript :=" UPDATE [dbo].[produto_preco_uf]"+CRLF
cScript +=" SET "+CRLF
cScript += cSriptPreco
cScript +="  [Tipo] 					= '"+IIf(SB1->B1_LANC=="1","Lan�amento","Cat�logo"  )+" '"+CRLF
cScript +=" ,[Cod_produto_NC] 	= '"+SA7->A7_PRODUTO+"'"+CRLF
cScript +=" ,[Cod_tabela]			= '"+(cAliasQry)->DA1_CODTAB+"'"+CRLF
cScript +=" ,[Cod_barras]	  		= '"+SB1->B1_CODBAR+"'"+CRLF
cScript +=" ,[Descricao] 	  		= '"+SB1->B1_XDESC+"'"+CRLF
cScript +=" ,[Publisher] 			= '"+SB1->B1_PUBLISH+"'"+CRLF
cScript +=" ,[Plataforma] 			= '"+SB1->B1_PLATEXT+"'"+CRLF
cScript +=" ,[Genero] 		  		= '"+Tabela('Z2',SB1->B1_CODGEN,.F.)+"'"+CRLF
cScript +=" ,[Tecnologia] 			= '"+SB1->B1_TECNOC+"'"+CRLF
cScript +=" ,[Preco_consumidor] 	= "+AllTrim(Str( SB1->B1_CONSUMI ))+CRLF
cScript +=" ,[IPI] 			  		= "+AllTrim( Str(nVlrIPI)  )+CRLF
cScript +=" ,[Pre_venda] 			= "+IIf( cPreVenda=="S" ,"1","0" )+CRLF
cScript +=" ,[Estoque] 		  		= "+AllTrim(Str(nSaldo))+CRLF
cScript +=" ,[Ativo]					= 1"+CRLF
cScript +=" ,[Produto_exclusivo]	= "+IIf( cProdExcl=="S" ,"1","0" )+CRLF
cScript +=" WHERE [Cod_produto] ="+AllTrim(SA7->A7_CODCLI)+CRLF

Return cScript

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MyMensagem(cMensagem)
PtInternal(1,cMensagem)
TcInternal(1,cMensagem)
Conout(cMensagem)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001GETPC()

Local aAreaAtu	:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local aAreaSA7	:= SA7->(GetArea())
Local aAreaSB1	:= SB1->(GetArea())
Local aAreaZC5	:= ZC5->(GetArea())
Local aAreaZC6	:= ZC6->(GetArea())

Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local cQryAlias	:= GetNextAlias()

Local cFilSA1		:= xFilial("SA1")
Local cFilSA7		:= xFilial("SA7")
Local cFilSB1		:= xFilial("SB1")
Local cFilZC5		:= xFilial("ZC5")
Local cFilZC6		:= xFilial("ZC6")

Local nLenCod		:= AvSx3("A7_CODCLI",3)
Local cCliWM		:= "000000"
Local cLojaWM		:= "01"
Local cQuery
Local nPedido
Local nItem
Local nTotal
Local lNotFound
Local cCodCLiProd
Local cLocalERP	:= Alltrim(U_MyNewSX6("WM_ARMAZEM","01" ,"C","Armaz�m de Venda Protheus para Pedido WM","","",.F. ))

If !oConectDB:OpenConnection()
	Return
EndIf

WM001Client(oConectDB) //Verifica pedido que est�o com erro de cliente n�o encontrado

cQuery:="SELECT  "
cQuery+="Pedido.[Cod_pedido]"+CRLF
cQuery+=",Pedido.[Cod_loja]"+CRLF
cQuery+=",Pedido.[Pre_venda]"+CRLF
cQuery+=",Pedido.[Data_pedido_numerico] "+CRLF
cQuery+=",Pedido.[Total]"+CRLF
cQuery+=",Pedido.[Total_atendido]"+CRLF
cQuery+=",Item.[Cod_produto]"+CRLF
cQuery+=",Item.[Qtde]"+CRLF
cQuery+=",Item.[Qtde_atendida]"+CRLF
cQuery+=",Item.[Valor]"+CRLF
cQuery+=" From [uzgames_nc].[dbo].[Pedido] Pedido ,[uzgames_nc].[dbo].[Pedido_hex] Item"+CRLF
cQuery+=" Where Pedido.Cod_pedido=item.Cod_pedido"+CRLF
cQuery+=" And Pedido.Estado='C'"+CRLF
cQuery+=" And (Cod_pedido_NC IS NULL OR Cod_pedido_NC =' ')"


oConectDB:NewAlias( cQuery, cQryAlias )


SA1->(dbOrderNickName("SA1CODWM"))
SB1->(DbSetOrder(1))
SA7->(DbSetOrder(3))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_CODCLI
ZC5->(DbSetOrder(1))//ZC5_FILIAL+STR(ZC5_NUM, 6, 0)+ZC5_PLATAF

Do While (cQryAlias)->(!Eof() )
	
	If ZC5->(DbSeek(cFilZC5+Str((cQryAlias)->Cod_pedido,6,0) +"WM"))
		U_WM001PcStat(oConectDB,ZC5->ZC5_NUM,"C")
		U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F","Recebido na distribuidora, sujeito a anal�se de cr�dito")
		(cQryAlias)->(DbSkip());Loop
	EndIf
	
	Begin Transaction
	
	ZC5->(Reclock("ZC5",.T.))
	
	ZC5->ZC5_FILIAL	:= cFilZC5
	ZC5->ZC5_NUM    	:= (cQryAlias)->Cod_pedido
	
	ZC5->ZC5_FLAG	:= "2"
	ZC5->ZC5_PLATAF	:="WM"
	ZC5->ZC5_ORIGEM	:="WM"
	ZC5->ZC5_LJECOM :="WM"
	ZC5->ZC5_QTDPAR	:= 1
	ZC5->ZC5_PREVEN :=IIf((cQryAlias)->Pre_venda=1 ,"S","N")
	ZC5->ZC5_CODENT:="863"
	ZC5->ZC5_STATUS := "4"
	ZC5->ZC5_DTVTEX := STOD( AllTrim(Str((cQryAlias)->Data_pedido_numerico)) )
	
	If !SA1->(MsSeek(cFilSA1+Alltrim(Str((cQryAlias)->Cod_loja)) ) )
		ZC5->ZC5_FLAG	 := "4"
	Else
		ZC5->ZC5_FLAG	:= '3'
		ZC5->ZC5_CLIENT	:= SA1->A1_COD
		ZC5->ZC5_LOJA	:= SA1->A1_LOJA
		ZC5->ZC5_CONDPG	:= SA1->A1_COND
		ZC5->ZC5_ENDENT	:= SA1->A1_ENDENT
		ZC5->ZC5_BAIROE	:= SA1->A1_BAIRROE
		ZC5->ZC5_CEPE	:= SA1->A1_CEPE
		ZC5->ZC5_MUNE	:= SA1->A1_MUNE
		ZC5->ZC5_ESTE  	:= SA1->A1_ESTE
		ZC5->ZC5_COMPLE	:= SA1->A1_COMPLEM
		ZC5->ZC5_CODMUE	:= SA1->A1_COD_MUN
		ZC5->ZC5_EMAIL	:= SA1->A1_EMAIL
		ZC5->ZC5_CONDPG :=SA1->A1_COND
	EndIf
	ZC5->(MsUnlock())
	
	nTotal	:=0
	nItem	:=0
	nPedido	:=(cQryAlias)->Cod_pedido
	cProdNot:=""
	
	Do While (cQryAlias)->(!Eof() ) .And. (cQryAlias)->Cod_pedido==nPedido
		
		ZC6->(RecLock("ZC6",.T.))
		
		ZC6->ZC6_FILIAL	:= cFilZC6
		ZC6->ZC6_NUM	:= ZC5->ZC5_NUM
		ZC6->ZC6_ITEM  	:= StrZero(++nItem,2)
		ZC6->ZC6_VLRUNI	:= (cQryAlias)->Valor
		ZC6->ZC6_IDPROD	:= AllTrim(Str((cQryAlias)->Cod_produto))
		ZC6->ZC6_QTDVEN	:= (cQryAlias)->Qtde
		ZC6->ZC6_VLRTOT	:= (cQryAlias)->Valor*(cQryAlias)->Qtde
		ZC6->ZC6_LOCAL	:= cLocalERP
		
		cProduto:=""
		BuscaProd(@cProduto,oConectDB,cQryAlias,cCliWM,cLojaWM,nLenCod)
		
		ZC6->ZC6_PRODUTO:=cProduto
		ZC6->ZC6_PLATAF :='WM'
		
		nTotal+=ZC6->ZC6_VLRTOT
		
		
		If !Empty(ZC6->ZC6_PRODUTO) .And. SB1->(MsSeek(cFilSB1+ZC6->ZC6_PRODUTO))
			ZC6->ZC6_DESCRI	:= SB1->B1_XDESC
			ZC6->ZC6_EAN	:= SB1->B1_CODBAR
		Else
			cProdNot+="Produto "+AllTrim(ZC6->ZC6_PRODUTO)+" nao encontrado"
		EndIf
		
		
		ZC6->(MsUnlock())
		
		(cQryAlias)->(DbSkip())
		
	EndDo
	
	ZC5->(RecLock("ZC5",.F.))
	If ZC5->ZC5_FLAG<>"4"
		ZC5->ZC5_FLAG := IIf(  !Empty(cProdNot) ,"5", "" )
	EndIf
	ZC5->ZC5_TOTAL:=nTotal
	ZC5->(MsUnlock())
	
	If !Empty(cProdNot)
		
	EndIf
	
	End Transaction
	
	oConectDB:TransBegin()
	U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F","Recebido na distribuidora, sujeito a anal�se de cr�dito")
	cNumPV:="."
	cUpdate:="UPDATE [dbo].[Pedido]
	cUpdate+="   SET [Cod_pedido_NC] = '"+cNumPV+"'"+CRLF
	cUpdate+="      ,[Data_pedido_NC] = '"+FWTimeStamp ( 3, MsDate(), Time() )+"'"+CRLF
	cUpdate+=" WHERE  [Cod_pedido] = "+AllTrim(Str(ZC5->ZC5_NUM))+CRLF
	u_WM001Exec(cUpdate,oConectDB)
	oConectDB:TransEnd()
	
EndDo


RestArea(aAreaSA1)
RestArea(aAreaSB1)
RestArea(aAreaZC5)
RestArea(aAreaZC6)
RestArea(aAreaAtu)

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001PcLog(oConectDB,nPedWM,cStatus,cObservacao,nCodUser,dDtEvento)
Local cInsert:=""
Default nCodUser	:=0
Default dDtEvento	:=MsDate()

If Type('oConectDB')<>"O"
	oConectDB:=WM001IniDB()
EndIf

/*
aStatusTst:={}
AADD(aStatusTst,{"'A'","'Recebido na distribuidora, sujeito a anal�se de cr�dito'"} )
AADD(aStatusTst,{"'A'","'Pedido Inclu�do na Carteira de Vendas em 10/10/2015'"} )
AADD(aStatusTst,{"'A'","'Pedido Aprovado ou Reprovado no Cr�dito em 10/10/2015'"} )
AADD(aStatusTst,{"'F'","'Pedido Preparando Entrega em 11/10/2015'"} )
AADD(aStatusTst,{"'F'","'Pedido Faturado em 12/10/2015'"} )
AADD(aStatusTst,{"'F","'Pedido Empacotado em 12/10/2015'"} )
#AADD(aStatusTst,{"'F'","'Pedido Expedido em 13/102015 - Despachado Transportadora XPTO'"} )
*/


cInsert+="INSERT INTO [dbo].[Pedido_log]"+CRLF
cInsert+="([Cod_pedido]"+CRLF
cInsert+=",[Cod_usuario]"+CRLF
cInsert+=",[Estado]"+CRLF
cInsert+=",[Observacao]"+CRLF
cInsert+=",[Data_cadastrou]
cInsert+=",[Sessao_cadastrou])

cInsert+="VALUES"+CRLF
cInsert+="("+CRLF
cInsert+=AllTrim(Str(nPedWM))+CRLF
cInsert+=","+AllTrim(Str(nCodUser))+CRLF
cInsert+=",'"+cStatus+"'"+CRLF
cInsert+=",'"+cObservacao+"'"+CRLF
cInsert+=",'"+FWTimeStamp ( 3, MsDate(), Time() )+"'"+CRLF
cInsert+=",0"+CRLF
cInsert+=")

U_WM001Exec(cInsert,oConectDB)
oConectDB:CloseConnection()
oConectDB:Finish()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/12/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001PcStat(oConectDB,nPedWM,cStatus,nCodUser)
Local cUpdate:=""

cUpdate+=" UPDATE [dbo].[Pedido] "+CRLF
cUpdate+=" SET [Estado] = '"+cStatus+"'"+CRLF
cUpdate+=" WHERE [Cod_pedido]="+AllTrim(Str(nPedWM))+CRLF
u_WM001Exec(cUpdate,oConectDB)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/17/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
������������������������������?�������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001StatPV(cNumPV,nPedWM,lPvParcial,lPrevenda)
Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaZC6	:= ZC6->(GetArea())
Local aAreaSC9	:= SC9->(GetArea())
Local cChaveSC9:= xFilial("SC9")+cNumPV
Local nTotal	:= 0
Local oConectDB:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local cUpdate
Local lBloqCred
Local lEnvWMS	:= IsIncallStack("ENVWMS")
Local cErro := ""

If !oConectDB:OpenConnection()
	Return
EndIf

SC5->(DbSetOrder(1))//ZC5_FILIAL+ZC5_NUM
SC5->(MsSeek(xFilial("SC5")+cNumPV  ))


ZC5->(DbSetOrder(1))//ZC5_FILIAL+ZC5_NUM
ZC5->(MsSeek(xFilial("ZC5")+AllTrim(Str(nPedWM))  ))


ZC6->(DbSetOrder(1))//ZC6_FILIAL+ZC6_NUM+ZC6_ITEM
ZC6->(MsSeek(xFilial("ZC6")+AllTrim(Str(nPedWM))  ))
Do While ZC6->(!Eof()) .And. ZC6->(ZC6_FILIAL+AllTrim(Str(ZC6_NUM)))==xFilial("ZC6")+AllTrim(Str(nPedWM))
	
	If ZC6->ZC6_PLATAF=='WM'
		
		cUpdate:=" UPDATE [dbo].[Pedido_hex]"+CRLF
		cUpdate+=" SET 	[Qtde_atendida] = "+AllTrim(Str(ZC6->ZC6_QTDRES))+CRLF
		cUpdate+="  	   ,[Valor_atendido] = "+AllTrim(Str(ZC6->(ZC6_VLRUNI*ZC6_QTDRES)))+CRLF
		cUpdate+=" WHERE	[Cod_pedido] = "+AllTrim(Str(nPedWM))+CRLF
		cUpdate+=" And		[Cod_produto] = "+AllTrim(ZC6->ZC6_IDPROD)+CRLF
		
		u_WM001Exec(cUpdate,oConectDB)
		
		//pegar dados do SC6
		nTotal+=ZC6->(ZC6_VLRUNI*ZC6_QTDRES)
		
	EndIf
	
	ZC6->(DbSkip())
EndDo

cUpdate:="UPDATE [dbo].[Pedido]
cUpdate+="   SET [Cod_pedido_NC] = '"+cNumPV+"'"+CRLF
cUpdate+="      ,[Data_pedido_NC] = '"+FWTimeStamp ( 3, SC5->C5_EMISSAO, Time() )+"'"+CRLF
cUpdate+="      ,[Total_atendido] = "+AllTrim(Str(nTotal))+CRLF
cUpdate+=" WHERE [Cod_pedido] = "+AllTrim(Str(nPedWM))+CRLF

u_WM001Exec(cUpdate,oConectDB)

If !lEnvWMS
	U_WM001PcLog(oConectDB,nPedWM,"F","Pedido "+IIf(lEnvWMS,"Liberado","Inclu�do")+"  na Carteira de Vendas"+IIf(lPvParcial .And. !lPrevenda,"(Parcialmente)",""),,SC5->C5_EMISSAO )
EndIf

ZC5->(RecLock("ZC5",.F.))
ZC5->ZC5_STATUS:='5'
ZC5->(MsUnLock())

SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO

If SC9->(DbSeek(cChaveSC9))
	
	lBloqCred:=.F.
	
	Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==cChaveSC9
		
		If !Empty(SC9->C9_BLCRED)
			lBloqCred:=.T.
			Exit
		EndIf
		SC9->(DbSkip())
	EndDo
	U_WM001PcLog(oConectDB,nPedWM,"F","Pedido "+Iif(lBloqCred,"em analise do cr�dito","aprovado no cr�dito") )
	
	If lEnvWMS
		U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido liberado no Cr�dito Automaticamente(Risco A)","",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX) 
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_STATUS:='10'
		ZC5->ZC5_FLAG := ' '
		ZC5->(MsUnLock())
	EndIf
	
	If !lBloqCred
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_STATUS:='10'
		ZC5->ZC5_FLAG := ' '
		ZC5->(MsUnLock())
	Else
		If ZC5->ZC5_PLATAF = 'WM'
			ZC5->(RecLock("ZC5",.F.))
			ZC5->ZC5_FLAG := '1'
			ZC5->(MsUnLock())
			
			cBody 	:= U_ECOMHTMI(ZC5->(Recno()),.t.)
			cToLoja	:=	Alltrim(U_MyNewSX6("NCG_000088","rciambarella@ncgames.com.br","C","E-mail dos usu�rios que ir�o receber as infoma��es do credito","","",.F. ))
			cAssunto	:= "Pedido de loja aguardando an�lise de cr�dito."
			If !U_COM08SEND(cAssunto, cBody, , cToLoja,, @cErro)
				U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,'Erro ao enviar e-mail para '+ cToLoja,cErro,ZC5->ZC5_STATUS,.T.)
			EndIf
		EndIf
	EndIf
	
EndIf

If lEnvWMS .And. ZC5->ZC5_STATUS=='10'
	If ZC5->ZC5_PLATAF == 'WM'
		U_WM001Send("PEDIDO",ZC5->ZC5_NUMPV)
	EndIf
EndIf


RestArea(aAreaSC5)
RestArea(aAreaZC5)
RestArea(aAreaZC6)
RestArea(aAreaSC9)
RestArea(aAreaAtu)

Return lBloqCred

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/12/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001Exec(cUpdate,oConectDB)

oConectDB:TransBegin()
If !oConectDB:SQLExec(cUpdate)
	oConectDB:TransDisarm()
	
EndIf
oConectDB:TransEnd()
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/18/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001Cred(cCampo,cNumPV)
Local aAreaAtu	:=GetArea()
Local aAreaZC5	:=ZC5->(GetArea())
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local nRecnoZC5
Local cMensagem
Local cStatusCred
Local lAlterar:=.F.

Default cNumPV	:=SC5->C5_NUM


If !oConectDB:OpenConnection()
	Return
EndIf

nRecnoZC5:=U_WM001ZC5REC(cNumPV)

If nRecnoZC5>0
	
	ZC5->(DbGoTo(nRecnoZC5))
	
	If cCampo=="R
		cMensagem	:="Reprovado no Cr�dito"
		cStatusCred:='96'
		lAlterar:=ZC5->ZC5_STATUS=='10'
	Else
		cMensagem	:="Aprovado no Cr�dito"
		cStatusCred:='10'
		lAlterar:=ZC5->ZC5_STATUS=='96'
	EndIf
	
	If !ZC5->ZC5_STATUS$'96*10' .Or. lAlterar
		U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F",cMensagem+" "+AllTrim(SC5->C5_YOBSFIN) )
		U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,cMensagem,AllTrim(SC5->C5_YOBSFIN),ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_STATUS:=cStatusCred
		ZC5->(MsUnLock())
		
		If cStatusCred=='10'
			U_WM001Send("PEDIDO",cNumPV)
		EndIf
		
	EndIf
	
EndIf


RestArea(aAreaZC5)
RestArea(aAreaAtu)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/24/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001WMS(cNumPV)
Local aAreaAtu	:=GetArea()
Local aAreaSC9	:=SC9->(GetArea())
Local cChaveSC9	:=xFilial("SC9")+cNumPV
Local cChaveZC5	:=xFilial("ZC5")+cNumPV
Local lEnvWMS:=.F.
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local nRecnoZC5

If !oConectDB:OpenConnection()
	Return
EndIf


SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC9->(DbSeek(cChaveSC9))

Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==cChaveSC9
	If !Empty(SC9->C9_BLWMS)
		lEnvWMS:=.T.
		Exit
	EndIf
	SC9->(DbSkip())
EndDo


nRecnoZC5:=U_WM001ZC5REC(cNumPV)

If nRecnoZC5>0 .And. lEnvWMS
	ZC5->(DbGoTo(nRecnoZC5)) 
	
	ZC5->(RecLock("ZC5",.F.)) 
	ZC5->ZC5_STATUS := "10"
	ZC5->(MsUnlock())   
	
	U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Preparando Entrega","",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
	U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F","Pedido Preparando Entrega" )    
	
EndIf

RestArea(aAreaSC9)
RestArea(aAreaAtu)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/24/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001ZC5REC(cNumPV)
Local nRecnoZC5:=0
Local cChaveZC5:=xFilial("ZC5")+cNumPV

ZC5->(DbSetOrder(2))//ZC5_FILIAL+ZC5_NUMPV

ZC5->( MsSeek(cChaveZC5)  )

Do While ZC5->( !Eof() ) .And. ZC5->(ZC5_FILIAL+ZC5_NUMPV)==cChaveZC5
	If Empty(ZC5->ZC5_ESTORN)
		nRecnoZC5:=ZC5->(Recno())
	EndIf
	ZC5->(DbSkip())
EndDo


Return nRecnoZC5

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/24/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM01GrvNF(cNumDoc,dtEmissao)
Local cUpdate
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02

If !oConectDB:OpenConnection()
	Return
EndIf


cUpdate:=" UPDATE [dbo].[Pedido]
cUpdate+=" SET [Numero_nota_NC] = '"+cNumDoc+"'"+CRLF
cUpdate+="     ,[Data_nota_NC] = '"+FWTimeStamp ( 3, dtEmissao, "00:00:00" )+"'"+CRLF
cUpdate+=" WHERE  [Cod_pedido] = "+AllTrim(Str(ZC5->ZC5_NUM))+CRLF
u_WM001Exec(cUpdate,oConectDB)
U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F","Nota Fiscal Emitida" ,,dtEmissao)

Return .T.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/24/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM01GrvExp()
Local cUpdate
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02

If !oConectDB:OpenConnection()
	Return
EndIf

U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F","Pedido empacotado preparando expedicao da mercadoria." )

Return .T.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/24/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM01GrvCan(cMsg)
Local cUpdate
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02

Default cMsg 		:= ""

If !oConectDB:OpenConnection()
	Return
EndIf

U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F","Pedido cancelado, motivo: "+cMsg )

Return .T.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM01rastr �Autor  �Microsiga           � Data �  02/25/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM01rastr()

Local cUpdate
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local cMensagem	:= ""

If !oConectDB:OpenConnection()
	oConectDB	:= DbWmConnect()
	If !oConectDB:OpenConnection()
		Return
	EndIf
EndIf

cUpdate := " UPDATE [dbo].[Pedido] "+CRLF
cUpdate += " SET [Estado] = 'F' "+CRLF
cUpdate += " WHERE  [Cod_pedido] = "+AllTrim(Str(ZC5->ZC5_NUM))+CRLF

U_WM001Exec(cUpdate,oConectDB) //Rotina responsavel pelo envio da atualiza��o para o Dbo Web

cMensagem += "Transportadora:"+SF2->F2_TRANSP+"-"+AllTrim(Posicione("SA4",1,xFilial("SA4")+SF2->F2_TRANSP,"A4_NOME"))
cMensagem += "-Codigo de Rastreio "+AllTrim(ZC5->ZC5_RASTRE)

U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F",cMensagem ) //Rotina responsavel pelo envio do log dos pedidos

oConectDB:CloseConnection()
oConectDB:Finish()

Return .T.

/*
�����������������������������������������������������������������������������
�������������������������������������������������T����������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  02/26/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001Send(cParam,cNumPv)
Local aAeraAtu:=GetArea()
Local lEnviar := .F.

If cParam=="PEDIDO" .And. lEnviar//BLOQUEAR O ENVIO DE PRE-NOTA
	Processa({|| U_110MTR730() },"Processando Pr�-Nota.")
	DbSelectArea("SC5")
	Processa({|| U_NC110Mail(cNumPv) })
EndIf

RestArea(aAeraAtu)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  03/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001ZC6REC(cNumPV,cProduto)
Local aAreaAtu	:=GetArea()
Local cAliasQry	:=GetNextAlias()
Local nRecnoZC6	:=0

BeginSql Alias cAliasQry
	
	Select ZC6.R_E_C_N_O_ RECZC6
	From %table:ZC5% ZC5,%table:ZC6% ZC6
	Where ZC5.ZC5_FILIAL = %xFilial:ZC5%
	And ZC5.ZC5_NUMPV=%exp:cNumPV%
	And ZC5.ZC5_ESTORN=' '
	And ZC5.ZC5_PLATAF='WM'
	And ZC5.%notdel%
	And ZC6.ZC6_FILIAL=ZC5.ZC5_FILIAL
	And ZC6.ZC6_NUM=ZC5.ZC5_NUM
	And ZC6.ZC6_PRODUT=%exp:cProduto%
	And ZC6.ZC6_PLATAF='WM'
	And ZC6.%notdel%
EndSQl

nRecnoZC6:=(cAliasQry)->RECZC6
(cAliasQry)->(DbCloseArea())

RestArea(aAreaAtu)

Return nRecnoZC6


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  03/04/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BuscaProd(cProduto,oConectDB,cQryAlias,cCliWM,cLojaWM,nLenCod)

Local cAliasQry	:=GetNextAlias()
Local cCodCLiProd
Local cQuery

cQuery:="SELECT Item.[Cod_produto_NC] "
cQuery+=" From [uzgames_nc].[dbo].[Pedido_hex] Item"+CRLF
cQuery+=" Where item.Cod_pedido="+AllTrim( Str((cQryAlias)->Cod_pedido))
cQuery+=" And item.Cod_produto="+AllTrim( Str((cQryAlias)->Cod_produto))

oConectDB:NewAlias( cQuery, cAliasQry )
cProduto:=(cAliasQry)->Cod_produto_NC

(cAliasQry)->(DbCloseArea())


If Empty(cProduto)
	cCodCLiProd:=Padr( AllTrim(Str((cQryAlias)->Cod_produto)),nLenCod)
	If SA7->(MsSeek(xFilial("SA7")+cCliWM+cLojaWM+cCodCLiProd))
		cProduto:=SA7->A7_PRODUTO
	EndIf
EndIf
DbSelectArea(cQryAlias)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  03/10/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WM001Exc(aDados)

Local aAreaAtu:=GetArea()
Local nRecnoZC5
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local cMensagem
Local cUpdate
Local cMotivo:=Space(300)
Local aParamBox:={}
Local aRet
Local mvpar01Atu:=mv_par01


If !oConectDB:OpenConnection()
	Return
EndIf


If aDados[1]=="PV"
	
	If (nRecnoZC5:=U_WM001ZC5REC(aDados[2]))>0
		
		aAdd(aParamBox,{11,"Informe o motivo",cMotivo,"","",.T.})
					
		If !ParamBox(aParamBox,"Parametros",@aRet,,,,,,,,.F.)  //(aParametros,cTitle,aRet,bOk,aButtons,lCentered,nPosx,nPosy, oDlgWizard, cLoad, lCanSave,lUserSave)
			MsgInfo("Motivo obrigat�rio.")
		EndIf
			
		cMotivo:=aRet[1]
		
		cMensagem:="Pedido Cancelado na Distribuidora"
		
		U_WM001PcLog(oConectDB,ZC5->ZC5_NUM,"F",cMensagem )
		U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,cMensagem,cMotivo,ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
		
		oConectDB:TransBegin()
		
		cUpdate:="UPDATE [dbo].[Pedido]
		cUpdate+="   SET [Motivo_estornou] = '"+cMotivo+"'"+CRLF
		cUpdate+="      ,[Data_estornou] = '"+FWTimeStamp ( 3, MsDate(), Time() )+"'"+CRLF
		cUpdate+=" WHERE  [Cod_pedido] = "+AllTrim(Str(ZC5->ZC5_NUM))+CRLF
		u_WM001Exec(cUpdate,oConectDB)
		oConectDB:TransEnd()
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_STATUS:='90'
		ZC5->(MsUnLock())
		
	EndIf
EndIf

mv_par01:=mvpar01Atu
RestArea(aAreaAtu)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  03/18/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WM001IniDB()

Local oDb:=U_DBWebManager() //Funcao encontrada no NCIWMF02

oDb:OpenConnection()

Return oDb

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWM001  �Autor  �Microsiga           � Data �  03/31/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WM001Client(oConectDB)

Local aAreaAtu	:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local cAliasZC5	:= GetNextAlias()
Local cQryAlias	:= GetNextAlias()
Local cFilSA1		:= xFilial("SA1")
Local nRecnoZC5	:= 0


BeginSql Alias cAliasZC5
	
	Select ZC5.R_E_C_N_O_ RECZC5
	From %table:ZC5% ZC5
	Where ZC5.ZC5_FILIAL = %xFilial:ZC5%
	And ZC5.ZC5_FLAG='4'
	And ZC5.ZC5_CLIENT=' '
	And ZC5.ZC5_LOJA=' '
	And ZC5.ZC5_ESTORN=' '
	And ZC5.ZC5_PLATAF='WM'
	And ZC5.%notdel%
	
EndSql

SA1->(dbOrderNickName("SA1CODWM"))

Do While (cAliasZC5)->(!Eof())
	
	ZC5->(DbGoTo( (cAliasZC5)->RECZC5))
	
	cQuery:=" Select Pedido.[Cod_loja]"+CRLF
	cQuery+=" From 	 [uzgames_nc].[dbo].[Pedido] Pedido "+CRLF
	cQuery+=" Where  [Cod_pedido] = "+AllTrim(Str(ZC5->ZC5_NUM))+CRLF
	
	oConectDB:NewAlias( cQuery, cQryAlias )
	
	If 	SA1->(MsSeek(cFilSA1+Alltrim(Str((cQryAlias)->Cod_loja)) ) )
		
		Begin Transaction
		
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_FLAG	:= ''
		ZC5->ZC5_CLIENT	:= SA1->A1_COD
		ZC5->ZC5_LOJA	:= SA1->A1_LOJA
		ZC5->ZC5_CONDPG	:= SA1->A1_COND
		ZC5->ZC5_ENDENT	:= SA1->A1_ENDENT
		ZC5->ZC5_BAIROE	:= SA1->A1_BAIRROE
		ZC5->ZC5_CEPE	:= SA1->A1_CEPE
		ZC5->ZC5_MUNE	:= SA1->A1_MUNE
		ZC5->ZC5_ESTE  	:= SA1->A1_ESTE
		ZC5->ZC5_COMPLE	:= SA1->A1_COMPLEM
		ZC5->ZC5_CODMUE	:= SA1->A1_COD_MUN
		ZC5->ZC5_EMAIL	:= SA1->A1_EMAIL
		ZC5->ZC5_CONDPG := SA1->A1_COND
		
		ZC5->(MsUnLock())
		
		End Transaction
		
	EndIf
	
	(cQryAlias)->(DbCloseArea())
	
	(cAliasZC5)->(DbSkip())
EndDo

RestArea(aAreaSA1)
RestArea(aAreaAtu)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM001Est  �Autor  �Lucas Felip         � Data �  06/09/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina responsavel pela atualiza��o de estoque e pre�o     ���
���          � para o WebManager.                                         ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WM001Est()
Local cMsgYes := "A Rotina de atualiza��o de pre�os/Estoque pode demorar alguns minutos. Deseja Prosseguir?"

If MsgYesno(cMsgYes)
	Processa({|| WM001Update() }, "Aguarde...", "Processando Exporta��o dos produtos...",.F.)
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WM001ImpV �Autor  �Microsiga           � Data �  06/09/16   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina responsavel importa��o dos pedidos digitados na     ���
���          � plataforma.                                                ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WM001ImpV()

Local cMsgYes := "A Rotina � respons�vel pela importa��o dos pedidos WM, a execu��o pode demorar alguns minutos. Deseja Prosseguir?"

If MsgYesno(cMsgYes)
	Processa({|| U_WM001GETPC() }, "Aguarde...", "Processando Importa��o...",.F.)
EndIf

Return

/*------------------------------------------------------------------------//
//
//
//
//------------------------------------------------------------------------*/
Static Function DbWmConnect()

Local oConect
Local cConectStr	:= U_MyNewSX6("NC_NBCABWM","","C","Nome do Banco e ambiente. Exemplo:  'MSSQL7/WebManager'","MSSQL/WebManager","",.F. )
Local cServer		:= U_MyNewSX6("NC_IPSRVWM","","C","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.217 ","192.168.0.202","",.F. )
Local nPortConect	:= U_MyNewSX6("NC_PORTWM","","N","Porta de acesso p/ comunica��o com o banco de dados. Exemplo: 7890","","",.F. )

oConect:=FWDBAccess():New( cConectStr, cServer,nPortConect )

Return oConect
