/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M103FILB  �Autor  �Microsiga           � Data �  05/25/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M103FILB()
Local cFiltroSF1	:=""
Local aParamBox	:= {}
Local aStatus		:={}   
Local aParams		:={}

If IsInCallStack("U_WML02NFE")
	
	cFiltroSF1+="( F1_YCODMOV<>' ' OR 	F1_XORIG='NCGPR100' )"

	AADD(aStatus,"01=N�o Classificadas")
	AADD(aStatus,"02=Classificadas")
	AADD(aStatus,"03=Todas")
	aAdd(aParamBox,{2,"Status"			,"1"	, aStatus	,120,".T."					,.F.})
	
	
	If ParamBox(aParamBox, "Par�metros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)
		
		cFiltroSF1+="And Exists("
		cFiltroSF1+=" Select 'X' From "+RetSqlName("SD1")+" SD1 "
		cFiltroSF1+=" Where D1_FILIAL=F1_FILIAL"
		cFiltroSF1+=" And D1_DOC=F1_DOC"
		cFiltroSF1+=" And D1_SERIE=F1_SERIE"
		cFiltroSF1+=" And D1_FORNECE=F1_FORNECE"
		cFiltroSF1+=" And D1_LOJA=F1_LOJA"
		
		If aParams[1]=="01"
			cFiltroSF1+=" And D1_TES=' '"
		ElseIf aParams[1]=="02"
			cFiltroSF1+=" And D1_TES<>' '"
		EndIf
		cFiltroSF1+=" And SD1.D_E_L_E_T_=' '
		cFiltroSF1+=")"
		
	Else
		MsgInfo("Ser�o apresentadas todas as notas.","Nc Games")
	EndIf
	
	
EndIf


Return cFiltroSF1
