#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
Static cChvIndE1
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA040B01  บAutor  ณHermes Ferreira     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTratamento na exclusใo do titulo. Caso tenha al็ada VPC nใo บฑฑ
ฑฑบ          ณpoderแ excluir                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FA040B01()

	Local lRet := .T.
	Local cSql 		:= ""
	Local cAlias	:= GetNextAlias()
	Local cPrefixoVPC	:= Alltrim(U_MyNewSX6(	"NCG_000016"							,;
										"VPC"											,;
										"C"												,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										.F. ))

	Local cTipoTIT	:= Alltrim(U_MyNewSX6(	"NCG_000018"		 						,;
										"NCC"											,;
										"C"												,;
										"Tipo de tํtulo a considerar para o relacionamento com VPC."	,;
										"Tipo de tํtulo a considerar para o relacionamento com VPC."	,;
										"Tipo de tํtulo a considerar para o relacionamento com VPC."	,;
										.F. ))
												
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If Alltrim(SE1->E1_TIPO) $ cTipoTIT .AND. Alltrim(SE1->E1_PREFIXO) == Alltrim(cPrefixoVPC)
		
		cChvIndE1 := SE1->(E1_CLIENTE+ E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)
		
		cSql := " SELECT "
		cSql += " P0B_NUM "
		cSql += " FROM "+ RetSqlName("P0B") + " P0B "
		cSql += " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
		cSql += " AND P0B.P0B_CHVIND = '"+Padr( cChvIndE1 ,TamSx3("P0B_CHVIND")[1])+"'"
		cSql += " AND P0B.P0B_STATUS NOT IN ('05')"
		cSql += " AND P0B.D_E_L_E_T_= ' '"
		
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)
		
		(cAlias)->(dbGoTop())
		
		If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
		
		    Aviso("FA040B01 - 01","Existe processo de controle de al็ada em andamento para este tํtulo e o mesmo nใo poderแ ser excluํdo.",{"Ok"},3)
			lRet := .F.
			
		EndIf
		
		(cAlias)->(dbCloseArea())
		
	EndIf
	
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFStatSE1  บAutor  ณHermes Ferreira     บ Data ณ  08/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo para retornar o conteudo da variavel static	      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FStatSE1()

	Local cMyChave := cChvIndE1

	cChvIndE1 := ""

Return(cMyChave)
