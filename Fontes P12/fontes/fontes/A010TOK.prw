#INCLUDE "PROTHEUS.CH"

Static aCmps := {}
/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矨010TOK  � Autor 矱LTON SANTANA		    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Ponto de entrada na valida玢o do TUDOOK				      潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
User Function A010TOK()

Local aArea := GetArea()
Local lRet	:= .T.
Local bCampoSB1 := { |x| SB1->(Field(x)) }

//Verifica se o produto e do tipo software. Se for n鉶 poder� ser alterado
//Essa valida玢o dever� ser efetuada na Altera玢o e/ou Exclus鉶
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
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砎ldSftw  � Autor 矱LTON SANTANA		    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Verifica se o produto e software. Se for software o produto潮�
北�			 � n鉶 poder� ser alterado						  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
				"O produto � software e n鉶 poder� sofrer altera珲es. A manuten玢o deve ser efetuado pelo produto origem (Cod.: "+Alltrim(SB5->B5_YCODMS)+")",;
				{"Ok"},2)
			EndIf
		EndIf
	EndIf
EndIf

RestArea(aArea)
Return lRet
/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矨010TOK   篈utor  矼icrosiga           � Data �  02/25/14   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     �                                                            罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP                                                        罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/

User Function GetCmpsB1()
Return aCmps


/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矨010TOK   篈utor  矼icrosiga           � Data �  05/06/14   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     �                                                            罕�
北�          �                                                            罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP                                                        罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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

