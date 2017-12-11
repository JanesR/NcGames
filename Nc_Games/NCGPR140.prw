#include 'protheus.ch'
#include 'parmtype.ch'
//#include 'FUNCOES.PRW'

#define MB_OK 0

/*==================================================================================================================================================================================================
===== Função para reprocessamnento dos pedidos liberados colocando-os devolta na tela de liberação para faturamento ================================================================================
===== Data de criação: 25/09/2017 ==================================================================================================================================================================
===== Autor: Flavio de Brito Borges ================================================================================================================================================================
====================================================================================================================================================================================================
====================================================================================================================================================================================================
====================================================================================================================================================================================================
====================================================================================================================================================================================================*/
	
User function NCGPR140()
	
	Local cQuery
	Local oFuncoes
	Local bChave
	
	Local cRet
	Local nRet
	
	Local aDados:={}
	Local aCabeca:={}
		
	//Criar um novo objeto FuncoesDiversas
	oFuncoes := FuncoesDiversas():New()
	
	//Seta o nome da planilha para listar os pedidos enviados para o monitor
	oFuncoes:setNomeExcel("Pedidos enviados para o monitor")
	
	//Seta o nome da tabela dos pedidos
	oFuncoes:setNomeTabela("Pedidos")
	
	bChave := .F.
	
	//Monta o array do primeiro cabeçalho
	//Primeira posição = Nome da coluna
	//Segunda posição  = Alinhamento da coluna ( 1-Left,2-Center,3-Right )
	//Terceira posição  = Codigo de formatação ( 1-General,2-Number,3-Monetário,4-DateTime )
	Aadd(aCabeca,{"PEDIDOS",1,1})
	Aadd(aCabeca,{"STATUS",1,1})
	
	
	//Montagem da query que executara toda a verificação dos pedidos pendentes de faturamento e que se encontram na tabela de conferencia de separação.
	cQuery:=" SELECT C9_PEDIDO FROM " + RetSqlName("SC9") + " where  "+CRLF
	cQuery+=" D_E_L_E_T_=' ' "+CRLF
	cQuery+=" and C9_FILIAL='" + xFilial("SC9") + "' "+CRLF
	cQuery+=" and C9_BLCRED =' ' "+CRLF
	cQuery+=" and C9_BLEST =' ' "+CRLF
	cQuery+=" and C9_BLWMS =' ' "+CRLF
	cQuery+=" and C9_PEDIDO in ( "+CRLF
	cQuery+=" select CS_NUM_DOCUMENTO from WMS.TB_WMSINTERF_CONF_SEPARACAO where CS_NUM_DOCUMENTO not in ( "+CRLF
	cQuery+="  select RNVI_NUM_DOCUMENTO from WMS.TB_FRTINTERFITENSNOTAS  "+CRLF
	cQuery+=" )  "+CRLF
	cQuery+=" )group by C9_PEDIDO "
	cQuery+="  order by C9_PEDIDO"+CRLF
	
		cRet:= oFuncoes:executaQuery(cQuery)
		
	While(cRet)->(!Eof())
		
		
		If oFuncoes:executaQuery("UPDATE WMS.TB_WMSINTERF_CONF_SEPARACAO SET STATUS='NP' WHERE CS_NUM_DOCUMENTO='" + AllTrim((cRet)->C9_PEDIDO) + "' "+CRLF,"Exec") == "Ok"
			cQuery:=" UPDATE SC9010 SET C9_BLWMS='02' 
			cQuery+="WHERE C9_FILIAL = '" + xFilial("SC9") + "' "
			cQuery+="AND D_E_L_E_T_=' ' "
			cQuery+="AND C9_PEDIDO = '" + AllTrim((cRet)->C9_PEDIDO) + "' "+CRLF
			cQuery+=" and C9_BLCRED =' ' "+CRLF
			cQuery+=" and C9_BLEST =' ' "+CRLF
			cQuery+=" and C9_BLWMS =' ' "+CRLF
		
			If oFuncoes:executaQuery(cQuery,"Exec") == "Ok"
				bChave := .T.
				Aadd(aDados,{AllTrim((cRet)->C9_PEDIDO),"ATUALIZADO"})
			
			EndIF		
		EndIF
		(cRet)->(DbSkip())
	EndDo
	
	If bChave
	
		nRet := MessageBox("Pedidos atualizados com sucesso, uma lista será gerada aguarde...!", "", MB_OK)
		If oFuncoes:criaExcelSimples(aCabeca,aDados)
			nRet := MessageBox("Arquivo gerado com sucesso!", "", MB_OK)
		End If
		
	Else
		nRet := MessageBox("Não foram encontrados pedidos para atualizar!", "", MB_OK)
	end If
return