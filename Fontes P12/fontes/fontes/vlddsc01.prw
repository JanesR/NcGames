#include "rwmake.ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldDsc01  �Autor  �Rodrigo Okamoto     � Data �  22/09/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada validador do pedido de venda               ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function VldDsc01

Local lRet	:= .t.
Local _cst		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_CLASFIS'} )
Local _pProduto	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
Local _pTES		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
Local _pLocal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_LOCAL'} )
Local _pQuant	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_QTDVEN'} )
Local _pPrcven	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCVEN'} )
Local _pPrcTab	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCTAB'} )
Local _pTotal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VALOR'} )
Local _pRegDes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PREGDES'} )
Local cVend1	:= M->C5_VEND1
Local dDtPed	:= M->C5_EMISSAO

cFunc	:= getadvfval("SA1","A1_SATIV1",XFILIAL("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,"")
IF cFunc == "000061" //se o cliente for funcion�rio, n�o far� valida��o do desconto
	RETURN(lRet)
ENDIF


cProduto	:= aCols[n,_pProduto]
cTES		:= aCols[n,_pTES]

cDuplic		:= getadvfval("SF4","F4_DUPLIC",XFILIAL("SF4")+cTES,1,"")
cDescok		:= getadvfval("SB1","B1_DESC_OK",XFILIAL("SB1")+cProduto,1,"")
If cDescok == "2" .and.  M->C6_PRCVEN < aCols[n,_pPrcven] .and. M->C5_TIPO == "N"//.and. aCols[n,_pRegDes] <> 0
	lRet	:= .F.
	alert("N�o permitido altera��o no valor deste produto!!!"+CRLF+;
	"O pre�o dever� seguir conforme pre�o de tabela.")
	If aCols[n,_pRegDes] == 0
		aCols[n,_pPrcven] := aCols[n,_pPrcTab]
		aCols[n,_pTotal]  := round(aCols[n,_pPrcven]*aCols[n,_pQuant],2)
	ElseIf aCols[n,_pRegDes] <> 0
		aCols[n,_pPrcven] := aCols[n,_pPrcven] //round(aCols[n,_pPrcTab]-(aCols[n,_pPrcTab]*(aCols[n,_pRegDes]/100)),2)
		aCols[n,_pTotal]  := round(aCols[n,_pPrcven]*aCols[n,_pQuant],2)
	EndIf
	If Type('oGetDad:oBrowse')<>"U"
		oGetDad:oBrowse:Refresh()
	Endif
	
	Return(lRet)
EndIf

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif

Return(lRet)




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VLDDSC02  �Autor  �Microsiga           � Data �  22/09/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Gatilho no campo C5_DESC1 para validar altera��o do        ���
���          � desconto no pedido de vendas conforme cadastro do produto  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function VldDsc02

Local lRet	:= .t.
Local _cst		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_CLASFIS'} )
Local _pProduto	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
Local _pTES		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
Local _pLocal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_LOCAL'} )
Local _pQuant	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_QTDVEN'} )
Local _pPrcven	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCVEN'} )
Local _pPrcTab	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCTAB'} )
Local _pTotal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VALOR'} )
Local _pRegDes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PREGDES'} )
Local nDesc1	:= M->C5_DESC1
Local dDtPed	:= M->C5_EMISSAO


cFunc	:= getadvfval("SA1","A1_SATIV1",XFILIAL("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,"")

IF M->C5_TIPO == "N" .and. alltrim(cFunc) <> "000061" //se o cliente for funcion�rio, n�o far� valida��o do desconto
	
	For nx:=1 to len(aCols)
		
		cProduto	:= aCols[nx,_pProduto]
		cTES		:= aCols[nx,_pTES]
		cDuplic		:= getadvfval("SF4","F4_DUPLIC",XFILIAL("SF4")+cTES,1,"")
		cDescok		:= getadvfval("SB1","B1_DESC_OK",XFILIAL("SB1")+cProduto,1,"")
		If cDescok == "2" .and. aCols[nx,_pRegDes] == 0
			aCols[nx,_pPrcven] := aCols[nx,_pPrcTab]
			aCols[nx,_pTotal]  := round(aCols[nx,_pPrcven]*aCols[nx,_pQuant],2)
		ElseIf aCols[nx,_pRegDes] <> 0 .and. cDescok == "2"
			aCols[nx,_pPrcven] := round(aCols[nx,_pPrcTab]-(aCols[nx,_pPrcTab]*(aCols[nx,_pRegDes]/100)),2)
			aCols[nx,_pTotal]  := round(aCols[nx,_pPrcven]*aCols[nx,_pQuant],2)
		EndIf
	Next nx
	
	If Type('oGetDad:oBrowse')<>"U"
		oGetDad:oBrowse:Refresh()
	Endif
	
EndIf

Return(nDesc1)




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldDsc03  �Autor  �Rodrigo Okamoto     � Data �  22/09/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �X3_WHEN dos campos C6_DESCONT e C6_VALDESC                  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function VldDsc03

Local lRet	:= .t.
Local _pProduto	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )

cProduto	:= aCols[n,_pProduto]
cDescok		:= getadvfval("SB1","B1_DESC_OK",XFILIAL("SB1")+cProduto,1,"")

cFunc	:= getadvfval("SA1","A1_SATIV1",XFILIAL("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,"")

IF M->C5_TIPO == "N" .and. alltrim(cFunc) <> "000061" //se o cliente for funcion�rio, n�o far� valida��o do desconto
	
	If cDescok == "2" //.and. aCols[n,_pRegDes] <> 0
		lRet	:= .F.
		Return(lRet)
	EndIf
	
EndIf

Return(lRet)



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VLDDSC04  �Autor  �Microsiga           � Data �  22/09/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Validador do campo C6_QUANT para considerar o desconto n�o ���
���          � aplicavel conforme o cadastro do produto                   ���
�������������������������������������������������������������������������͹��
���Uso       � C6_QTDVEN - Gatilho seq 002 U_VldDsc04()                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function VldDsc04

Local lRet	:= .t.
Local _pProduto	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
Local _pTES		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
Local _pQuant	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_QTDVEN'} )
Local _pPrcven	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCVEN'} )
Local _pPrcTab	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCTAB'} )
Local _pTotal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VALOR'} )
Local _pRegDes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PREGDES'} )

cFunc	:= getadvfval("SA1","A1_SATIV1",XFILIAL("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,"")

IF M->C5_TIPO == "N" .and. alltrim(cFunc) <> "000061" //se o cliente for funcion�rio, n�o far� valida��o do desconto
	cProduto	:= aCols[n,_pProduto]
	cTES		:= aCols[n,_pTES]
	cDuplic		:= getadvfval("SF4","F4_DUPLIC",XFILIAL("SF4")+cTES,1,"")
	cDescok		:= getadvfval("SB1","B1_DESC_OK",XFILIAL("SB1")+cProduto,1,"")
	If cDescok == "2" .and. aCols[n,_pRegDes] == 0
		aCols[n,_pPrcven] := aCols[n,_pPrcTab]
		aCols[n,_pTotal]  := round(aCols[n,_pPrcven]*aCols[n,_pQuant],2)
	ElseIf aCols[n,_pRegDes] <> 0 .and. cDescok == "2"
		aCols[n,_pPrcven] := round(aCols[n,_pPrcTab]-(aCols[n,_pPrcTab]*(aCols[n,_pRegDes]/100)),2)
		aCols[n,_pTotal]  := round(aCols[n,_pPrcven]*aCols[n,_pQuant],2)
	EndIf
EndIf

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif


Return(aCols[n,_pQuant])

