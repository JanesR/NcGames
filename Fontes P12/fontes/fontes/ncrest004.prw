#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCRST004  ºAutor  ³Mauricio Mendes     º Data ³  07/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Giro Por Publish                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES.                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCRST004()

Private _cArqTmp	:= ""
Private _cIndTmp	:= ""

fRelato()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fRelato   ºAutor  ³Mauricio Mendes     º Data ³  23/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao da chamada do relatorio.                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NCGAMES                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fRelato()

Private cPerg := "REST04"

fCriaSx1()

Pergunte(cPerg,.t.)

If Empty(MV_PAR12)
	MSGAlert("Arquivo de saida não especificado ")
	Return
Endif

If MsgYesNo("Confirma geracao da Planilha?","CONFIRMAR")
	fGeraTmp()
Else
	Return
EndIf

Processa({|| fAtuDados() },"Processando Planilha")


__CopyFile(_cArqTmp+".DBF",MV_PAR12)

MSGInfo("Arquivo com sucesso '"+MV_PAR12,"Arquivo Gerado")

If ! ApOleClient( 'MsExcel' )
	MsgAlert("MsExcel nao instalado", "Atenção!")
	Return
EndIf
// abre arquivo temporario em excel.
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( mv_par12 ) // Abre uma planilha
oExcelApp:SetVisible(.T.)

Ferase(_cArqTmp+".DBF")



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCriaSx1  ºAutor  ³Mauricio Mendes     º Data ³  23/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Criacao de perguntas do relatorio.                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCriaSx1()

PutSX1(cPerg,"01","Publisher de?"   ,"Publisher de?"	,"Publisher de ?"	,"mv_ch1","C",09,0,1,"G","","CTD","","","mv_par01","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"02","Publisher Ate"   ,"Publisher Ate?"	,"Publisher ate?"	,"mv_ch2","C",09,0,1,"G","","CTD","","","mv_par02","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"03","Data de      "   ,"Data de     "		,"Data de     "		,"mv_ch3","D",08,0,1,"G","","","",""	,"mv_par03mv_par03","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"04","Data Ate     "   ,"Data ate    "		,"Data ate    "		,"mv_ch4","D",08,0,1,"G","","","",""	,"mv_par04","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"05","Produto de?  "   ,"Produto de? "		,"Produto de ?"		,"mv_ch5","C",15,0,1,"G","","SB1","","","mv_par05","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"06","Produto ate? "   ,"Produto ate?"		,"Produto ate?"		,"mv_ch6","C",15,0,1,"G","","SB1","","","mv_par06","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"07","Plataf de?  "   ,"Plataf de? "		,"Plataf de ?"		,"mv_ch7","C",10,0,1,"G","","SZ5","","","mv_par07","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"08","Plataf ate? "   ,"Plataf  ate?"		,"Plataf ate?"		,"mv_ch8","C",10,0,1,"G","","SZ5","","","mv_par08","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"09","Considerar Dev?" ,"Considerar Dev?"	,"Considerar Dev?"	,"mv_ch9","N",01,0,1,"C","","","",""	,"mv_par09","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","")
PutSx1(cPerg,"10","TES Qto Faturamento ?" ,"",""							,"mv_chA","N",1,0,1,"C","","","",""	,"mv_par10","Gera","Gera","Gera","","Não gera","Não gera","Não gera","Considera Ambas","Considera Ambas","Considera Ambas","","","","","","")
PutSx1(cPerg,"11","TES Qto Estoque ?" ,"",""								,"mv_chB","N",1,0,1,"C","","","",""	,"mv_par11","Movimenta","Movimenta","Movimenta","","Não movimenta","Não movimenta","Não movimenta","Considera Ambas","Considera Ambas","Considera Ambas","","","","","","")
PutSX1(cPerg,"12","Arquivo ?    "   ,"Arquivo    ?"		,"Arquivo    ?"		,"mv_chC","C",80,0,1,"G","","","",""	,"mv_par12","","","","","","","","","","","","","","","","")


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGeraTmp  ºAutor  ³Adriano Luis Brandaoº Data ³  15/04/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gerar arquivo temporario em branco.            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGeraTmp()

Local _aCampos := {}

aAdd(_aCampos,{"PUBLISHE","C",40,0})		
aAdd(_aCampos,{"ESTOQUEC","N",16,2})		
aAdd(_aCampos,{"ESTOQUEV","N",16,2})		
aAdd(_aCampos,{"MARK_CTB","N",8,2})		
aAdd(_aCampos,{"GIRO_UME","N",16,2})		
aAdd(_aCampos,{"GIRO"	 ,"N",8,2})		
aAdd(_aCampos,{"EST_EM_M","N",08,2})		


_cArqTmp	:= Criatrab(_aCampos,.t.)
_cIndTmp	:= Criatrab(,.f.)

If Select("TRB") > 0
	TRB->(dbCloseArea())
Endif

DbUseArea(.T.,,_cArqTmp,"TRB",.T.,.F.)

IndRegua("TRB",_cIndTmp,"PUBLISHE",,,"Criando indice....")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAtuDados ºAutor  ³Mauricio Mendes     º Data ³  23/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gerar dados para o arquivo Excel               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fAtuDados()

Local aDtas := {}
Local nCnt  := 0 
Local aTot  := {"TOTAIS", 0,0,0,0,0,0,0}

IF EMPTY(MV_PAR02)
	MV_PAR02 = 'ZZZZZZZZZ'
Endif

IF EMPTY(MV_PAR06)
	MV_PAR06 = 'ZZZZZZZZZZZZZZZ'
Endif

IF EMPTY(MV_PAR08)
	MV_PAR08 = 'ZZZZZZZZZZ'
Endif
        
cQry := "SELECT "
cQry += "	B1_ITEMCC, "
cQry += "	CTD_DESC01, "
cQry += "	SUM(B2_CM1 * (B2_QATU - B2_QEMP - B2_RESERVA)) ESTCUS, "
cQry += "	SUM(DA1_PRCVEN  * ( B2_QATU - B2_QEMP - B2_RESERVA )) ESTVEN "
cQry += "FROM "+RetSqlName("SB2")+" B2, "+RetSqlName("CTD")+" CTD, "+RetSqlName("SB1")+" B1 " 
cQry += "	LEFT JOIN "+RetSqlName("DA1")+" DA1 ON DA1_CODTAB = '018' AND DA1_CODPRO = B1_COD AND DA1.D_E_L_E_T_ = ' ' 
cQry += "WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
cQry += "	AND B1_COD BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
cQry += "	AND B1_ITEMCC BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
cQry += "	AND B1_PLATAF BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
cQry += "	AND B2_FILIAL = '" + xFilial("SB2") + "' "
cQry += "	AND B2_COD = B1_COD  "  
cQry += "	AND CTD_ITEM = B1_ITEMCC  "     
cQry += "	AND B1.D_E_L_E_T_ = ' ' "
cQry += "GROUP BY B1_ITEMCC, CTD_DESC01	" 
cQry += "ORDER BY B1_ITEMCC	"

TCQUERY cQry NEW ALIAS "TMP"

dbSelectArea("TMP")
TMP->(dbGotop())   

While TMP->(!Eof())
	nCnt++
	TMP->(dbSkip())		
EndDo
TMP->(dbGotop()) 

ProcRegua(nCnt)

While TMP->(!Eof())
	
	IncProc("Processando Publisher: "+TMP->CTD_DESC01)
    
	//aDtas := RetDatas(CToD("01/"+StrZero(Month(MV_PAR04)-1,2)+"/"+StrZero(Year(MV_PAR04),4)))                  
    nGiro := RetCusto(TMP->B1_ITEMCC,MV_PAR03, MV_PAR04)   
       
	dbSelectArea("TRB")
	RecLock("TRB", .T.)
	TRB->PUBLISHE	:= TMP->CTD_DESC01
	TRB->ESTOQUEC 	:= TMP->ESTCUS
	TRB->ESTOQUEV  	:= TMP->ESTVEN
	TRB->MARK_CTB   := TMP->ESTVEN/TMP->ESTCUS
	TRB->GIRO_UME	:= nGiro 
	TRB->GIRO		:= (nGiro/(TMP->ESTVEN+nGiro))*100
	TRB->EST_EM_M	:= TMP->ESTVEN/nGiro
	TRB->(MsUnlock())   
	
	aTot[2]  += TMP->ESTCUS  
	aTot[3]  += TMP->ESTVEN
	aTot[4]  += TMP->ESTCUS/TMP->ESTVEN
	aTot[5]  += nGiro 
	aTot[6]  += nGiro/(TMP->ESTVEN+nGiro)
	aTot[7]  += TMP->ESTVEN/nGiro
	aTot[7]  += 1
	
	TMP->(dbSkip())
		
EndDo 

//-- Totais
RecLock("TRB", .T.)
TRB->PUBLISHE	:= aTot[1]
TRB->ESTOQUEC 	:= aTot[2]
TRB->ESTOQUEV  	:= aTot[3]
TRB->MARK_CTB   := aTot[4]/aTot[8]
TRB->GIRO_UME	:= aTot[5] 
TRB->GIRO		:= aTot[6]/aTot[8] 
TRB->EST_EM_M	:= aTot[7]/aTot[8]
TRB->(MsUnlock())   

TMP->(dbCloseArea())
TRB->(dbCloseArea())        

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCREST003 ºAutor  ³Microsiga           º Data ³  05/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RetCusto(cIt, dDtaDe, dDtaAte)

Local nRet		:= 0
Local cQuery 	:= ""

Local cEstoq 	:= If( (MV_PAR10 == 1),"'S'",If( (MV_PAR10 == 2),"'N'","'S','N'" ) )
Local cDupli 	:= If( (MV_PAR11 == 1),"'S'",If( (MV_PAR11 == 2),"'N'","'S','N'" ) )

cQuery := " SELECT "
cQuery += "		B1_ITEMCC, " 
cQuery += "		SUM(D2_TOTAL)+SUM(D2_VALIPI)+SUM(D2_ICMSRET)+SUM(D2_VALFRE+D2_SEGURO+D2_DESPESA) CUSTO "
cQuery += " FROM " +RetSqlName("SD2")+ " SD2, " +RetSqlName("SF4")+ " SF4, " +RetSqlName("SB1")+ " B1  "
cQuery += " WHERE D2_FILIAL  = '" + XFilial("SD2") + "' "
cQuery += " 	AND D2_EMISSAO BETWEEN '" + DToS(MV_PAR03) + "' AND '"+DToS(MV_PAR04)+"' "
cQuery += " 	AND D2_TIPO = 'N' "  
cQuery += " 	AND F4_ESTOQUE IN ("+cEstoq+") "   
cQuery += " 	AND F4_DUPLIC IN ("+cDupli+") " 
cQuery += " 	AND F4_FILIAL  = '"+XFilial("SF4")+ "' " 
cQuery += "		AND B1_ITEMCC = '"+cIt+"' " 
cQuery += " 	AND F4_CODIGO  = D2_TES "  
cQuery += "		AND B1_COD = D2_COD "
cQuery += "		AND D2_LOCAL = B1_LOCPAD "
cQuery += " 	AND SD2.D_E_L_E_T_ = ' ' "
cQuery += " 	AND SF4.D_E_L_E_T_ = ' ' "
cQuery += " GROUP BY B1_ITEMCC "

TCQUERY cQuery NEW ALIAS "QR11"

QR11->(dbGotop())

While QR11->(!Eof())
	nRet := QR11->CUSTO
	QR11->(dbSkip())
EndDo

QR11->(dbCloseArea())
                  
// Considera devolucoes 
If MV_PAR09 == 1  
	                   
	cQuery := "SELECT " 
	cQuery += "		B1_ITEMCC, "
	cQuery += "		SUM(D1_TOTAL)+SUM(D1_VALIPI)+SUM(D1_ICMSRET) CUSTO "
	cQuery += " FROM " + RetSqlName("SD1") + " SD1, " + RetSqlName("SF4") + " SF4, "+RetSqlName("SB1")+" B1 "
	cQuery += " WHERE D1_FILIAL  = '" + xFilial("SD1") + "'"
	cQuery += " 	AND D1_DTDIGIT BETWEEN '" + DTOS(MV_PAR03) + "' AND '"+dtos(MV_PAR04)+"' "
	cQuery += " 	AND D1_COD  = B1_COD "
	//cQuery += "		AND D1_LOCAL  = B1_LOCPAD "
	cQuery += " 	AND D1_TIPO = 'D' "  
	cQuery += "		AND B1_ITEMCC = '"+cIt+"' " 
	cQuery += " 	AND F4_FILIAL  = '" + xFilial("SF4") + "' "
	cQuery += " 	AND F4_CODIGO  = D1_TES " 
	cQuery += " 	AND F4_ESTOQUE IN ("+cEstoq+") "   
	cQuery += " 	AND F4_DUPLIC IN ("+cDupli+") " 
	cQuery += " 	AND SD1.D_E_L_E_T_ = ' ' "
	cQuery += " 	AND SF4.D_E_L_E_T_ = ' ' "
	cQuery += " GROUP BY B1_ITEMCC "
	
	TCQUERY cQuery NEW ALIAS "QR12"

	QR12->(dbGotop())                
	
	While QR12->(!Eof())
		
		nRet -= QR12->CUSTO 
		QR12->(dbSkip())
	EndDo
	
	QR12->(dbCloseArea())

Endif

Return(nRet)    

Static Function RetDatas(dDta)
     
Local lVal := .F.
Local aRet := {} 
       
While !lVal
	If !Empty(CTOD("31/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
	
		AAdd(aRet, CTOD("01/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
		AAdd(aRet, CTOD("31/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
		
		lVal := .T.
		Loop
		
	ElseIf !Empty(CTOD("30/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))	
		
		AAdd(aRet, CTOD("01/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
		AAdd(aRet, CTOD("30/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta))))) 
		    
		lVal := .T.
		Loop
		
	ElseIf !Empty(CTOD("29/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))	
		
		AAdd(aRet, CTOD("01/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
		AAdd(aRet, CTOD("29/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
	
		lVal := .T.
		Loop    
	
	ElseIf !Empty(CTOD("28/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))	
		
		AAdd(aRet, CTOD("01/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta)))))
		AAdd(aRet, CTOD("28/"+AllTrim(Str(Month(dDta)))+"/"+AllTrim(Str(Year(dDta))))) 
		
		lVal := .T.
		Loop
	EndIf
EndDo		
	    
Return aRet                 
