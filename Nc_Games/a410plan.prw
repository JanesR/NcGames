
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR107  �Autor  �Microsiga           � Data �  12/15/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function A410PLAN()
Local i,nInd
Local oDlg:=GetWndDefault()
Local bReadVar := MemVarBlock("__ReadVar")
Local lRecalcula:=M->C5_DESC2>0
Local nVlrPreco

If !INCLUI
	If U_M001TemPV(xFilial("SC5"),SC5->C5_NUM,2)
		oGetPV:Disable()
		oGetPV:EnchRefreshAll()
		
		If TYPE("oGetDad:lActive") != "U" 
			oGetDad:lActive:=.F.
		EndIf
	EndIf
EndIf

For i:=1 To Len(oDlg:aControls)

	If !ValType(oDlg:aControls[i])=="O" 
		Loop
	EndIf	

	If INCLUI .OR. ALTERA
		If oDlg:aControls[i]:ClassName()=="TFOLDER"
			If ExistBlock("PR108FOLDER")
				oDlg:aControls[i]:BSETOPTION:={|nAtu|  U_PR108Folder(nAtu,i) }			
			Else
				oDlg:aControls[i]:BSETOPTION:={|nAtu|  U_PR107Folder(nAtu,i) }
			EndIf	
		EndIf
	Endif
	
	If oDlg:aControls[i]:cSX1Hlp$"C5_DESC1*C5_DESC2"
		Eval(bReadVar,oDlg:aControls[i]:cReadVar)
		If ValType(oDlg:aControls[i]:bValid) == "B"
			Eval(oDlg:aControls[i]:bValid,oDlg:aControls[i])
		EndIf
	EndIf
	
	
	If oDlg:aControls[i]:cSX1Hlp$"C5_YLINHA1*C5_YLINHA2*C5_YLINHA3*C5_YLINHA4*C5_YLINHA5*C5_YLINHA6"
		oDlg:aControls[i]:LVISIBLE:=.F.
	EndIf
Next

If ALTERA
	For nInd:=1 To Len(aCols)
		If (nVlrPreco:=GdFieldGet("C6_YPRCORI",nInd))>0
			If SC5->C5_YLIBC9
				lRecalcula:=.F.
//				GdFieldPut('C6_PRUNIT',nVlrPreco,nInd)
			ElseIf Empty(SC5->C5_NUMEDI)
				lRecalcula:=.T.
  //				GdFieldPut('C6_PRUNIT',GdFieldGet( "C6_PRCTAB", nInd),nInd)
			EndIf
		EndIf
		
		If GdFieldGet("C6_YVLOVER",nInd) >0
			lRecalcular:=.F.
		EndIf
		
	Next
	
	If SC5->C5_YLIBC9
		M->C5_YSTATUS:=""
		M->C5_YULTMAR:=0
		U_PR107VAL()
	ElseIf M->C5_YSTATUS=="06"
		M->C5_YULTMAR:= Round(M->C5_YPERLIQ,2)
	EndIf
	
EndIf

//If lRecalcula
//	a410Recalc(.T.)//Refresh para caso de descontos
//EndIf

Return .T.
