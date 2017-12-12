#INCLUDE "PROTHEUS.CH"


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GetTranNF ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o codigo e a transportadora de acordo com a NF	  ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GetTranNF(cNf)

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local cNfAux	:= ""

//Retira os Zeros a esquerda da nota fiscal, pois o WMS não considera.
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
                                               
