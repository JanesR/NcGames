Static nLinha	:=0
Static lExecutar:=.F.

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FT080DSC   �Autor  �Microsiga          � Data �  05/20/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�����������������������������������������#��������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FT080DSC()
Local aDados	:=ParamIxb
Local nPrcVen	:=aDados[2]
Local lPV_EDI	:= IsInCallStack("U_KZNCG11")//Pedidos de Venda originario do EDI
Local lPedidoSite	:= Iif(M->C5_XECOMER=="C",.T.,.F.)
Local nLine:=n
Local lExecutar

Local nVlrDesc := 0

If __ReadVar $ "M->C5_DESC2*M->C6_DESCONT"
	U_M001Prc(nLine,@nPrcVen,aDados[1])
EndIf

If IsInCallStack("A410ReCalc")
	If !lExecutar
		
		nPrcVen := Round(nPrcVen,2)
		
		Return nPrcVen
	Else
		nLine:=++nLinha
	EndIf
EndIf

If lPV_EDI
	
	lExecutar:=.T.
	
	If GdFieldGet( "C6_PRUNIT", nLine)>GdFieldGet("C6_PRCVEN", nLine)
		GdFieldPut("C6_PRCVEN",GdFieldGet("C6_PRUNIT", nLine),nLine)
	EndIf
	
	If GdFieldGet( "C6_PRCTAB", nLine)<GdFieldGet("C6_PRCVEN", nLine)
		lExecutar:=.F.
		GdFieldPut('C6_YPTABOR',GdFieldGet( "C6_PRCTAB", nLine),nLine)
		GdFieldPut('C6_PRCTAB',GdFieldGet("C6_PRCVEN", nLine),nLine)
	EndIf
	
	If GdFieldGet( "C6_PRUNIT", nLine)<>GdFieldGet("C6_PRCTAB", nLine)
		GdFieldPut('C6_PRUNIT',GdFieldGet("C6_PRCTAB", nLine),nLine)
	EndIf
	
	If lExecutar
		U_M001Prc(nLine,@nPrcVen,aDados[1])
	EndIf
	
ElseIf	!lPedidoSite
	U_M001Prc(nLine,@nPrcVen,aDados[1])
EndIf

nPrcVen := Round(nPrcVen,2)

Return nPrcVen

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FT080DSC  �Autor  �Microsiga           � Data �  05/23/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SetExecDesc(aSet)
lExecutar:=aSet[1]
nLinha:=aSet[2]
Return
