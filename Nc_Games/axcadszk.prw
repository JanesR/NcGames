#include "rwmake.ch"

#DEFINE CRLF Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AXCADSZK  ºAutor  ³Lucas Felipe        º Data ³  05/25/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AXCADSZK()

Private cCadastro := "Cadastro de Tab Over"
Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Incluir","AxInclui",0,3} ,;
{"Alterar","AxAltera",0,4} ,;
{"Recalcular Over","U_SZKRecal()",0,6} ,;
{"Excluir","AxDeleta",0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

dbSelectArea("SZK")
dbSetOrder(1)

dbSelectArea("SZK")
mBrowse( 6,1,22,75,"SZK")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AXCADSZK  ºAutor  ³Lucas Felipe        º Data ³  05/25/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SZKRecal()

Local cQry 		:= ""
Local cAliasQry := GetNextAlias()

Local nPrcVen  	:= 0
Local cItem		:= strzero(0,4)
Local dDataAtu	:= MsDate()
Local cTabBase	:= SZK->ZK_TABBASE
Local cTabAtu	:= SZK->ZK_TABAATU
Local nIndAcre	:= SZK->ZK_INDICE

Local cAliasSZK := SZK->(GetArea())
Local cAliasDA1	:= DA1->(GetArea())


cQry += " SELECT DA1.* "+CRLF
cQry += " FROM "+RetSqlName("DA1")+" DA1 "+CRLF
cQry += " 	INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQry += " 	ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQry += " 	AND SB1.B1_COD = DA1.DA1_CODPRO "+CRLF
cQry += " 	AND SB1.B1_TIPO = 'PA' "+CRLF
cQry += " 	AND SB1.B1_MSBLQL = '2' "+CRLF
cQry += " WHERE DA1.D_E_L_E_T_ = ' ' "+CRLF
cQry += " AND DA1.DA1_CODTAB = '"+cTabBase+"' "+CRLF

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)
                                     
DA1->(DbSetOrder(1))                                     
DA1->(DbSeek(xFilial("DA1")+cTabAtu))
cItem := StrZero(0,Len(DA1->DA1_ITEM))

Do While (cAliasQry)->(!Eof())
	
	cCodPro := (cAliasQry)->DA1_CODPRO
	nPrcVen := (cAliasQry)->DA1_PRCVEN
	
	If DA1->(DbSeek(xFilial("DA1")+cTabAtu+cCodPro))
		
		DA1->(RecLock("DA1",.F.))
		
		DA1->DA1_PRCVEN := Round(nPrcVen + (nPrcVen * (nIndAcre / 100)),2)
		DA1->DA1_DATVIG := dDataAtu
		
		DA1->(MsUnlock())
		
	Else
		
		DA1->(DbSeek(xFilial("DA1")+cTabAtu))

		
		cItem := Soma1(cItem)
		
		DA1->(RecLock("DA1",.T.))
		
		DA1->DA1_ITEM   := cItem
		DA1->DA1_CODTAB := cTabAtu
		DA1->DA1_CODPRO := cCodPro
		DA1->DA1_PRCVEN := Round(nPrcVen + (nPrcVen * (nIndAcre / 100)),2)
		DA1->DA1_ATIVO  := "1"
		DA1->DA1_TPOPER := "4"
		DA1->DA1_QTDLOT := 999999.99
		DA1->DA1_MOEDA  := 1
		DA1->DA1_DATVIG := dDataAtu
		
		DA1->(MsUnlock())
		
	EndIf 
	
	(cAliasQry)->(DbSkip())
	
EndDo


RestArea(cAliasDA1)
RestArea(cAliasSZK)
 
MsgAlert("A Atualização da tabela foi concluida com sucesso")

Return
