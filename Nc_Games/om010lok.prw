/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Fun��o    �OM010LOK  � Autor � Rodrigo Okamoto       � Data � 10/01/2011 ���
���������������������������������������������������������������������������Ĵ��
���Descri��o �Rotina de Validacao da linha Ok                               ���
���������������������������������������������������������������������������Ĵ��
���Sintaxe   �OM010LOK                                                      ���
���������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                        ���
���          �                                                              ���
���������������������������������������������������������������������������Ĵ��
���Uso       � Materiais/Distribuicao/Logistica                             ���
���������������������������������������������������������������������������Ĵ��
��� Atualizacoes sofridas desde a Construcao Inicial.                       ���
���������������������������������������������������������������������������Ĵ��
��� Programador  � Data   � BOPS �  Motivo da Alteracao                     ���
���������������������������������������������������������������������������Ĵ��
���              �        �      �                                          ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
User Function OM010LOK

Local aArea     := GetArea()
Local lRetorno  := .T.
Local nPosProd  := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_CODPRO"})
Local nPosGrupo := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_GRUPO"})
Local nPosFaixa := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_QTDLOT"})
Local nPosPrcVen:= aScan(aHeader,{|x| AllTrim(x[2])=="DA1_PRCVEN"})
Local nPosTab   := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_CODTAB"})
Local nPosUF    := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_ESTADO"})
Local nPosTpOpe := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_TPOPER"})
Local nPosDtVig := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_DATVIG"})
Local nPosRefGr := aScan(aHeader,{|x| AllTrim(x[2])=="DA1_REFGRD"})
Local nUsado    := Len(aHeader)
Local nX        := 0
//������������������������������������������������������������������������Ŀ
//�Verifica os campos obrigatorios                                         �
//��������������������������������������������������������������������������
If !aCols[n][nUsado+1]
	If lRetorno
		If nPosTab == 0
			For nX := 1 To Len(aCols)
				If nX <> N .And. !aCols[nX][nUsado+1]
					If (nPosProd == 0 .Or. (aCols[nX][nPosProd] == aCols[N][nPosProd] .And. !Empty(aCols[N][nPosProd])))
						lRetorno := .F.
						Help(" ",1,"JAGRAVADO")
					EndIf
				EndIf
			Next nX
		EndIf
	EndIf
EndIf
//If !aCols[n][nUsado+1]
//	IF aCols[n][nPosPrcVen] = 0
//		lRetorno	:= .F.
//	ENDIF
//EndIf

RestArea(aArea)
Return(lRetorno)
