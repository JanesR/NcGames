#INCLUDE "rwmake.ch"
#include "colors.ch"  
#include "protheus.ch"

user function descLi()

Local aArea := GetArea()
Local cPerg := "LI_PROD"
Local aCab := {}
Local aItens := {}
Local cPINI
Local cPFIM
Local cTIPO

ajustaSX1(cPerg)
if !Pergunte(cPerg, .T.)
	alert("Operacao cancelada!")
    return
endIf

MsgAlert("O sistema Iniciara as buscas, por favor aguardar.", "Atenção")

cPINI := MV_PAR01
cPFIM := MV_PAR02
cTipo := MV_PAR03

aCab := montaHead()
aItens := montaDados(cPINI, cPFIM, cTIPO)
/*
CNOMEDBF := "Desc-LI-"+DTOS(DDATABASE)
DBCREATE(CNOMEDBF,aCab,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

if(Len(aItens) > 0)

for nX:= 1 to Len(aItens)
   
	XLS->(RECLOCK("XLS",.T.))
	
	XLS->COD_NC 		:=aItens[nX][1]
	XLS->COD_BARRAS		:=aItens[nX][2]
	XLS->DESC_NC		:=aItens[nX][3]
	XLS->TIPO			:=aItens[nX][4]
	XLS->COD_LI			:=aItens[nX][5]     
	XLS->DESC_LI		:=aItens[nX][6]     
  
next nX


If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)
XLS->(DBCLOSEAREA())
endIF
*/

If !EMPTY(aItens)
	MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCab,aItens}})})
Else
	Alert("Nenhum dado encontrado!")
EndIf

MsgAlert("Busca de Produtos Finalizado!", "Busca de Produtos")


restArea(aArea)
return

static function montaHead()
Local aArea := GetArea()
Local aCab:= {}

aadd(aCab, {"COD_NC"		,"C",15,0})
aadd(aCab, {"COD_BARRAS"	,"C",15,0})
aadd(aCab, {"DESC_NC"		,"C",30,0})
aadd(aCab, {"TIPO"			,"C",02,0})
aadd(aCab, {"COD_LI"		,"C",15,0})
aadd(aCab, {"DESC_LI"		,"C",300,0})
aadd(aCab, {" 		"		,"C",02,0})
restArea(aArea)
return aCab


static function montaDados(cPINI, cPFIM, cTIPO)

Local aArea 	:= GetArea()
Local aItens 	:= {}
Local aItensRet := {}
Local cQry 		:= ""
Local cQry2		:= ""
Local cAliasB1	:= "SB1"
Local cAliasYP	:= "SYP"
Local cTxtAux	:= ""
     
cQry += "select B1_COD, B1_CODBAR, B1_DESC, B1_TIPO, B1_DESC_GI from "+ RetSqlName("SB1")+" where b1_filial = '"+ xFilial("SB1")+"' "
cQry += "and D_E_L_E_T_ = ' ' "
cQry += "and b1_tipo = '"+cTIPO+"' "
cQry += "and b1_COD BETWEEN '"+cPINI+"'  AND '"+cPFIM+"' "

cQry := ChangeQuery(cQry)

If Select(cAliasB1) > 0
	dbSelectArea(cAliasB1)
	dbCloseArea(cAliasB1)
Endif


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasB1,.T.,.T.)

dbSelectArea("SB1")

While (cAliasB1)->(!EOF())
	
	AADD(aItens, (cAliasB1)->B1_COD)     
	AADD(aItens, (cAliasB1)->B1_CODBAR)     
	AADD(aItens, (cAliasB1)->B1_DESC)     
	AADD(aItens, (cAliasB1)->B1_TIPO)     
	AADD(aItens, (cAliasB1)->B1_DESC_GI)     
	
		cQry2 := ""
		cQry2 += "SELECT YP_TEXTO FROM "+retSqlName("SYP")+" WHERE YP_FILIAL = '"+xFilial("SYP")+"' "
		cQry2 += " AND D_E_L_E_T_ = ' ' AND YP_CHAVE = '"+ (cAliasB1)->B1_DESC_GI +"' "
		cQry2 += " AND YP_CAMPO = 'B1_DESC_GI' ORDER BY YP_CHAVE, YP_SEQ "         
		cQry2 := ChangeQuery(cQry2)
		
		If Select(cAliasYP) > 0
			dbSelectArea(cAliasYP)
			dbCloseArea(cAliasYP)
		Endif

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry2),cAliasYP,.T.,.T.)
		                                                                      
		dbSelectArea("SYP")
		
		While (cAliasYP)->(!Eof())
            
            	cTxtAux += RTrim((cAliasYP)->YP_TEXTO)
            	cTxtAux += " "

			(cAliasYP)->(DbSkip())
		EndDo
        
		dbCloseArea(cAliasYP)
		
	AADD(aItens, cTxtAux) 
	AADD(aItens, "  ") 
	AADD(aItensRet, aItens)

	cTxtAux := " "	
	aItens:= {}
	
	(cAliasB1)->(DbSkip())  
	
	Loop
EndDo

dbCloseArea(cAliasB1)
restArea(aArea)
return aItensRet

Static Function AjustaSx1(cPerg)
Local aArea := GetArea()
Local aHelpP11	:= {}
Local aHelpE11	:= {}
Local aHelpS11	:= {}

Aadd( aHelpP11, "Produto de:" )
PutSx1(cPerg,"01","Produto de: ?" ,"","","mv_ch1","C",15,0,,"G","","SB1","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Produto até: ?" )
PutSx1(cPerg,"02","Produto até: ?" ,"","","mv_ch2","C",15,0,,"G","","SB1","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Tipo: ?" )
PutSx1(cPerg,"03","Tipo: ?" ,"","","mv_ch3","C",2,0,,"G","","02","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

RestArea(aArea)

Return
