#INCLUDE "PROTHEUS.CH"


/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴etTranNF � Autor 矱LTON SANTANA		    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Retorna o codigo e a transportadora de acordo com a NF	  潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
User Function GetTranNF(cNf)

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local cNfAux	:= ""

//Retira os Zeros a esquerda da nota fiscal, pois o WMS n鉶 considera.
cNfAux := Alltrim(Str(Val(cNf)))

//Query, utilizada para buscar a transportadora de acordo com o numero da nota fiscal
cQuery	:= " SELECT A4_COD, A4_NOME FROM "+RetSqlName("SA4")+" "
cQuery	+= " WHERE A4_CGC = (SELECT CNPJ_FILIAISTRANSPORTE FROM FRETES.TB_FRTNFDESPACHADAS "
cQuery	+= "                   WHERE NUMNF_NFDESPACHADAS = '"+cNfAux+"') "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())

If (cArqTmp)->(!Eof())
	cRet := (cArqTmp)->A4_COD+" - "+(cArqTmp)->A4_NOME
Else
	cRet := ""
EndIf           

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return cRet 
                                               
