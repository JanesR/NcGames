/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTA416PV  �Autor  �Microsiga           � Data �  09/22/13   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para manipulacao do aHeader/aCols         ���
���          � do SC6                                                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MTA416PV()
Local nInd
Local aHeadAtu
Local aColsAtu

If Type("aHeader")=="A"
	aHeadAtu:=aClone(aHeader)
EndIf

If Type("aCols")=="A"
	aColsAtu:=aClone(aCols)
EndIf

//Variaveis _aHeader,_aCols criadas antes do Ponto de Entrada MTA416PV
aHeader	:=_aHeader
aCols	:=_aCols

M->C5_XSTAPED:="15"  
M->C5_TABELA:=""

SCK->(DbSetOrder(1))//CK_FILIAL+CK_NUM+CK_ITEM+CK_PRODUTO

For nInd:=1 To Len(_aCols)

	GDFieldPut("C6_OPER","01",nInd)
	GDFieldPut("C6_TPOPER" ,"01",nInd)    
	
	cChaveCK:=xFilial("SCK")+GdFieldGet("C6_NUMORC", nInd)+GdFieldGet("C6_PRODUTO", nInd)
	
	If SCK->(DbSeek(cChaveCK ) )	
		If Empty(M->C5_TABELA)
			M->C5_TABELA:=SCK->CK_YTABELA
		EndIf                            
		GDFieldPut("C6_PRCTAB ",SCK->CK_YPRCTAB ,nInd)		
	EndIf
Next


If Type("aHeadAtu")=="A"
	aHeader:=aClone(aHeadAtu)
EndIf

If Type("aColsAtu")=="A"
	aCols:=aClone(aColsAtu)
EndIf


Return .T.