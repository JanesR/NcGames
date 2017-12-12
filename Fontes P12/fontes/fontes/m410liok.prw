
#include "rwmake.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M410liok  �Autor  �Rogerio - STCH      � Data �  22/11/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada validador da linha do pedido de venda      ���
���          � 1-> Retorna a situa��o tribut�ria do ICMS	  	 		        ���
���          � 2-> Valida almoxarifado de acordo com cadastro do vendedor ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M410liok()

Local lRet	:= .t.
Local _cst		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_CLASFIS'} )
Local _pProduto	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
Local _pTES		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
Local _pLocal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_LOCAL'} )
Local cVend1	:= M->C5_VEND1
Local dDtPed	:= M->C5_EMISSAO                 

If !Gddeleted(n) .And. U_GetCMVGer(GdFieldGet("C6_PRODUTO", n),GdFieldGet("C6_LOCAL", n),"")==0 .And. AvalTes( GdFieldGet("C6_TES",n) ,/*cEstoq*/,"S") .and. !(substr(GdFieldGet("C6_CF",n),2,3) $ '99 /933') //cfop 1933/2933 para notas fiscais de servi�os
	HELP("",1,"Nc_Produto_Sem_Custo",,"Produto sem custo cadastrado",1,1)
	Return(.F.)
EndIf		
                     


nCont	:= 0
nQtMax	:= supergetmv("MV_MAXITPV",.T.,40)
If dDtPed < ctod("22/02/12") //data de corte
	//pedidos com data anterior a 22/02/12 n�o ter�o restri��o � quantidade
ElseIf M->C5_XSTAPED<>"00"
	For nx:=1 to len(aCols)
		If !Gddeleted(nx)
			nCont++
		EndIf
	Next nx
	If nCont > nQtMax 
		alert("Quantidade de itens supera ao limite permitido!!!")
		Return(.F.)
	EndIf
EndIf


cConteudo 	:= aCols[n,_cst]

cProduto	:= aCols[n,_pProduto]
cTES		:= aCols[n,_pTES]
cOrigem	:= getadvfval("SB1","B1_ORIGEM",XFILIAL("SB1")+cProduto,1,"")
cSitTrib	:= getadvfval("SF4","F4_SITTRIB",XFILIAL("SF4")+cTES,1,"")

_clasfis:= SUBSTR(cOrigem,1,1)+cSitTrib

IF cConteudo <> _clasfis
	aCols[n,_cst] := _clasfis
	IF cConteudo <> _clasfis
		lRet:=.F.
	EndIf
EndIf

if !lRet
	Return(lRet)
Endif

/*
//��������������������������������������������������������������
//�Valida��o do Almoxarifado de acordo com cadastro do Vendedor�
//��������������������������������������������������������������
*/

cLocValid	:= getadvfval("SA3","A3_LOCPAD",XFILIAL("SA3")+cVend1,1,"")
cLocal		:= aCols[n,_pLocal]
IF M->C5_TIPO == "N"
	If !alltrim(cLocal) $ alltrim(cLocValid)
		If !GDDeleted(n)
			lRet	:= .F.
			alert("Digite um armazem v�lido. Local informado n�o permitido!!!")
			Return(lRet)
		EndIf
	EndIf
ENDIF
Return(lRet)

