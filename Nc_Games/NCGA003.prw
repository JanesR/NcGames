#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"

//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//�������������������������������������������������������������������������ͻ��
//���Programa  �NCGA003   � Autor �                    � Data �  03/09/13   ���
//�������������������������������������������������������������������������͹��
//���Descricao �Programa para realizar o estorno do split autom�tico dos    ���
//���          �itens m�dia e software no pedido de vendas.                 ���
//�������������������������������������������������������������������������͹��
//���Uso       � NC GAMES  - m410get                                        ���
//�������������������������������������������������������������������������ͼ��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������

User Function NCGA003()

Local aArea		:= Getarea()
Local cFilMDSW	:=	U_MyNewSX6(	"NCG_100002",;
"05",;
"C",;
"Filiais que realizam o tratamento de m�dia e software",;
"Filiais que realizam o tratamento de m�dia e software",;
"Filiais que realizam o tratamento de m�dia e software",;
.F. )

If CFILANT $ cFilMDSW
	//Processa o split de m�dia e software somente para as filiais contidas no par�metro NCG_100002
	Processa({|| GA003Split() },"Aglutinando os itens m�dia e software para manuten��o do pedido...")

	If Type('oGetDad:oBrowse')<>"U"
		oGetDad:oBrowse:ForceRefresh()
	Endif
	
EndIf

RestArea(aArea)

Return


/*
//���������������������������������������������Ŀ
//�Processamento do estorno do split dos itens�
//�����������������������������������������������
*/

Static Function GA003Split

Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRODUTO"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_QTDVEN"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ITEM"})
Local nPTotal   := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_VALOR"})
Local nPosPrTab	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRCTAB'} )
Local nPosPrUnit:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRUNIT'} )
Local nPosPrcVen:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PRCVEN'} )
Local nPosValor	:= aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_VALOR'} )
Local nPosYMIDP := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_YMIDPAI'} )
Local cItem		:= "00"
Local aItens	:= {}

ProcRegua(len(aCols)) // Numero de registros a processar

For nx:=1 to len(aCols)
	
	If !GDDeleted(nx)
		If substr(aCols[nx,nPosYMIDP],1,2) == "MD" //Verifica se o � m�dia
			//���������������������������������������������������������������������Ŀ
			//� Incrementa a regua                                                  �
			//�����������������������������������������������������������������������
			IncProc("Verificando: " + aCols[nx,nPProduto] )
			
			nPosSW	:= aScan(aCols,{|x| x[nPItem] == substr(aCols[nx,nPosYMIDP],3,2) })
			
			nPrcVen	:= aCols[nx,nPosPrcVen]+aCols[nPosSW,nPosPrcVen]
			nPrcTab	:= aCols[nx,nPosPrTab]+aCols[nPosSW,nPosPrTab]
			nPrUnit	:= aCols[nx,nPosPrUnit]+aCols[nPosSW,nPosPrUnit]
			nQtdVen	:= aCols[nx,nPQtdVen]
			
			AADD(aItens , aCols[nx] )
			
			
			cItem	:= Soma1(cItem)
			aItens[Len(aItens),nPItem]		:= cItem
			aItens[Len(aItens),nPosPrcVen]	:= nPrcVen
			aItens[Len(aItens),nPosPrTab]	:= nPrcTab
			aItens[Len(aItens),nPosPrUnit]	:= nPrUnit
			aItens[Len(aItens),nPosValor]	:= nPrcVen*nQtdVen
			
		ElseIf substr(aCols[nx,nPosYMIDP],1,2) == "SW" //Verifica se o � software
			//n�o adiciona o produto software no grid
		Else
			AADD(aItens , aCols[nx] )
			
			
			cItem	:= Soma1(cItem)
			aItens[Len(aItens),nPItem]		:= cItem		
		EndIf
	EndIf
Next nx

//������������������������������������������������������Ŀ
//� Adiciona os produtos no aCols                        �
//��������������������������������������������������������

aCols	:= {}
If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif

aCols	:= aClone(aItens)

N := LEN(aCols)

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif


