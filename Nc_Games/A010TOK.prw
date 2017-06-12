#INCLUDE "PROTHEUS.CH"

Static aCmps := {}
/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �A010TOK  � Autor �ELTON SANTANA		    � Data � 02/09/13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ponto de entrada na valida��o do TUDOOK				      ���
���			 � 												  			  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function A010TOK()

Local aArea := GetArea()
Local lRet	:= .T.
Local bCampoSB1 := { |x| SB1->(Field(x)) }

//Verifica se o produto e do tipo software. Se for n�o poder� ser alterado
//Essa valida��o dever� ser efetuada na Altera��o e/ou Exclus�o
If !INCLUI
	lRet	:= U_VldSftw(M->B1_COD)
EndIf

If Altera
	//aCmps :=  RetCmps("SB1",bCampoSB1)
	GetCpos()
EndIf

If M->B1_TIPO == "PA" .And. M->B1_CONSUMI == 0
	MsgAlert("Para produtos do Tipo PA � obrigatorio o preenchimento do campo ConsumidorR$","Prc_Consumidor")
	lRet:= .F.
EndIf
RestArea(aArea)
Return lRet

/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �VldSftw  � Autor �ELTON SANTANA		    � Data � 02/09/13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Verifica se o produto e software. Se for software o produto���
���			 � n�o poder� ser alterado						  			  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VldSftw(cCod)

Local aArea := GetArea()
Local lRet	:= .T.

Default cCod := ""

DbSelectArea("SB5")
DbSetOrder(1)
If !Empty(cCod)
	If SB5->(DbSeek(xFilial("SB5") + cCod))
		If Alltrim(SB5->B5_YSOFTW) == "1"
			lRet := .F.
			
			If !IsBlind()//Verifica se a chamada est� sendo efetuado por job
				
				Aviso("VLD - Produto Software",;
				"O produto � software e n�o poder� sofrer altera��es. A manuten��o deve ser efetuado pelo produto origem (Cod.: "+Alltrim(SB5->B5_YCODMS)+")",;
				{"Ok"},2)
			EndIf
		EndIf
	EndIf
EndIf

RestArea(aArea)
Return lRet
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A010TOK   �Autor  �Microsiga           � Data �  02/25/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function GetCmpsB1()
Return aCmps


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A010TOK   �Autor  �Microsiga           � Data �  05/06/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetCpos()
Local aAreaAtu:=GetArea()
Local aAreaSX3:=SX3->(GetArea())
Local nInd
Local cNomeCpo
Local aAltCpo:={}
Local cAliasTab

SX3->(DbSetOrder(2))

aAdd(aAltCpo,"B1_COD")
aAdd(aAltCpo,"B1_PUBLISH")
aAdd(aAltCpo,"B1_CATEG")
aAdd(aAltCpo,"B1_CODGEN")
aAdd(aAltCpo,"B5_DTLAN")
aAdd(aAltCpo,"B1_OLD")
aAdd(aAltCpo,"B1_PAISPRO")
aAdd(aAltCpo,"B1_CODBAR")
aAdd(aAltCpo,"B1_ALT")
aAdd(aAltCpo,"B1_LARGURA")
aAdd(aAltCpo,"B1_PROF")
aAdd(aAltCpo,"B5_NUMJOG")
aAdd(aAltCpo,"B5_TAG1")
aAdd(aAltCpo,"B5_TAG2")

aCmps := {}
For nInd := 1 to Len(aAltCpo)
	cNomeCpo	:=aAltCpo[nInd]
	If !SX3->(DbSeek(cNomeCpo))
		Loop
	EndIf
		
	cAliasTab	:=SX3->X3_ARQUIVO
	
	If !&('M->'+cNomeCpo)==&(cAliasTab+'->'+cNomeCpo)
		aAdd( aCmps, {cNomeCpo,AllTrim(AvSx3(cNomeCpo,5)),AvSx3(cNomeCpo,2),&(cAliasTab+'->'+cNomeCpo),&('M->'+cNomeCpo)})
	EndIf
Next nInd


RestArea(aAreaSX3)
RestArea(aAreaAtu)
Return 

