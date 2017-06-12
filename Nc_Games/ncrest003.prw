#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCRST003  ºAutor  ³Mauricio Mendes     º Data ³  07/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Planilha de Pricing.                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES.                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCRST003()

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

Private cPerg := "REST03"
Private cFOpen := ""
fCriaSx1()

Pergunte(cPerg,.t.)

If Empty(mv_par10)
	msgstop("Arquivo de saida não especificado ")
	Return
Endif


If ApMsgYesNo("Confirma geracao da Planilha ??","Confirmar")
	fGeraTmp()
Else
	Return
EndIf

Processa({|| fAtuDados() },"Processando Planilha")
   
cFOpen := cGetFile("Todos os Arquivos|*.*",'Selecione o Diretorio',0,'C:\',.T.,GETF_LOCALFLOPPY+GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.F.)

mv_par10 := cfOpen+alltrim(mv_par10)+".XLS"

__CopyFile(_cArqTmp+".DBF",alltrim(mv_par10))

apmsgstop("Arquivo Gerado "+mv_par10,"ATENCAO")

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf
// abre arquivo temporario em excel.
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( mv_par10 ) // Abre uma planilha
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

PutSX1(cPerg,"01","Considerar?  "   ,"Considerar? "		,"Considerar ?"		,"mv_ch1","N",01,0,1,"C","","","","","mv_par01","Fechamento","Fechamento","Fechamento","","Movimento","Movimento","Movimento","","","","","","","","","")
PutSX1(cPerg,"02","Data Ref.    "   ,"Data Ref.   "		,"Data Ref.   "		,"mv_ch2","D",08,0,1,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"03","Dias         "   ,"Dias        "		,"Dias        "		,"mv_ch3","N",08,0,1,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"04","Publisher de?"   ,"Publisher de?"	,"Publisher de ?"	,"mv_ch4","C",09,0,1,"G","","CTD","","","mv_par04","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"05","Publisher Ate"   ,"Publisher Ate?"	,"Publisher ate?"	,"mv_ch5","C",09,0,1,"G","","CTD","","","mv_par05","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"06","Produto de?  "   ,"Produto de? "		,"Produto de ?"		,"mv_ch6","C",15,0,1,"G","","SB1","","","mv_par06","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"07","Produto ate? "   ,"Produto ate?"		,"Produto ate?"		,"mv_ch7","C",15,0,1,"G","","SB1","","","mv_par07","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"08","Plataf de?  "   ,"Plataf de? "		,"Plataf de ?"		,"mv_ch8","C",10,0,1,"G","","SZ5","","","mv_par08","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"09","Plataf ate? "   ,"Plataf  ate?"		,"Plataf ate?"		,"mv_ch9","C",10,0,1,"G","","SZ5","","","mv_par09","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"10","Arquivo ?    "   ,"Arquivo    ?"		,"Arquivo    ?"		,"mv_chA","C",80,0,1,"G","","","","","mv_par10","","","","","","","","","","","","","","","","")

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
±±ºUso       ³ AP - TISHMAN.                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGeraTmp()

Local _aCampos := {}

aAdd(_aCampos,{"CODIGONC","C",15,0})		// D=DEVEDORA (CONTAS PAGAR) / C=CREDORA (CONTAS A RECEBER).
aAdd(_aCampos,{"DESC_NCG","C",100,0})		// B1_XDESC
aAdd(_aCampos,{"PUBLISH","C",40,00})		// CTD_DESC01
aAdd(_aCampos,{"PLATAF","C",30,00})		// SZ5->Z5_PLATRED
aAdd(_aCampos,{"CLASSIF","C",30,0})		// B1_DESCCLA
aAdd(_aCampos,{"STATUS_C","C",30,0})		// BUSCAR DESCRICAO TABELA ZX
aAdd(_aCampos,{"SLD_QT_DT","N",16,2})		// SALDO EM QUANTIDADE  DATA REFERENCIA
aAdd(_aCampos,{"SLD_VL_DT","N",16,2})		// SALDO EM VALOR DATA REFERENCIA
aAdd(_aCampos,{"QT_VEN","N",16,2})			// QUANTIDADE VENDIDA
aAdd(_aCampos,{"QT_VEN_CMV","N",16,2})		// QUANTIDADE VENDIDA CMV
aAdd(_aCampos,{"GIRO","N",16,2})			// GIRO


_cArqTmp	:= Criatrab(_aCampos,.t.)
//_cIndTmp	:= Criatrab(,.f.)

If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif

DbUseArea(.T.,,_cArqTmp,"TMP",.T.,.F.)

//IndRegua("TMP",_cIndTmp,"TIPO+C_CUSTO",,,"Criando indice....")

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
          
Local nTotal := 0
Private cPlataf := space(30)
Private _aRet := {}

IF EMPTY(MV_PAR05)
	MV_PAR05 = 'ZZZZZZZZZ'
Endif

IF EMPTY(MV_PAR07)
	MV_PAR07 = 'ZZZZZZZZZZZZZZZ'
Endif

IF EMPTY(MV_PAR09)
	MV_PAR09 = 'ZZZZZZZZZZ'
Endif

_cQuery := "SELECT B1_COD,B1_LOCPAD,B1_STACMLD,B1_PLATAF,B1_XDESC,B1_DESCCLA  FROM "+RETSQLNAME("SB1")+ " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "' "
_cQuery += "             AND B1_ITEMCC BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "
_cQuery += "             AND B1_PLATAF BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "ORDER BY B1_COD "


If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif

TcQuery _cQuery New Alias "QR1"


dbSelectArea("QR1")
dbGotop()

While QR1->(!EOF())
	nTotal++
	QR1->(dbSkip())
EndDo

dbSelectArea("QR1")
dbGotop()

ProcRegua(nTotal)

While QR1->(!EOF())
	
	IncProc("Processando produto: "+QR1->B1_COD)
	
	dbSelectArea("SB1") 
	SB1->(dbSetOrder(1))
	SB1->(dbSeek(XFilial("SB1")+QR1->B1_COD+QR1->B1_LOCPAD))
	
	dbSelectArea("SB2")
	dbSetOrder(1)
	If !(dbSeek(xfilial("SB2")+QR1->B1_COD+QR1->B1_LOCPAD))
		QR1->(dbSkip())
		Loop
	Endif
	
	// 1 Data de Fechamento, onde a data do mv_par02 vai ser procurado o proximo fechamento, caso nao encontre utilizara o saldo B2_QATU
	// 2 se for movimento utilizara o calcest.
	If mv_par01 == 1
		
		dbSelectArea("SB9")
		dbSetOrder(1)
		nQtd := 0
		nVal := 0
		
		If dbSeek(xfilial("SB9")+QR1->B1_COD+QR1->B1_LOCPAD+DTOS(MV_PAR02))
			
			nQtd := SB9->B9_QINI
			nVal := SB9->B9_VINI1
			
		Else
			
			nQtd := CalcEst( SB2->B2_COD,SB2->B2_LOCAL,MV_PAR02+1,SB2->B2_FILIAL )[ 1 ]
			nVal := CalcEst( SB2->B2_COD,SB2->B2_LOCAL,MV_PAR02+1,SB2->B2_FILIAL )[ 2 ]
			
		Endif
	ELSE
		nQtd := CalcEst( SB2->B2_COD,SB2->B2_LOCAL,MV_PAR02+1,SB2->B2_FILIAL )[ 1 ]
		nVal := CalcEst( SB2->B2_COD,SB2->B2_LOCAL,MV_PAR02+1,SB2->B2_FILIAL )[ 2 ]
		
	Endif
	
	/*
	cStatus := Space(30)
	dbSelectArea("SX5")
	dbSetOrder(1)
	If dbSeek(xFilial("SX5")+"ZX"+QR1->B1_STACMLD)
		cStatus := SX5->X5_DESCRI
	Endif
	*/  
	cStatus := QR1->B1_STACMLD
	
	dbSelectArea("SZ5")
	SZ5->(dbSetOrder(1))
	SZ5->(dbSeek(XFilial("SZ5")+SB1->B1_PLATAF))
	
	dbSelectArea("CTD")
	CTD->(dbSetOrder(1)) 
	CTD->(dbSeek(XFilial("CTD")+SB1->B1_ITEMCC))
	
	_aRet := Calcval(MV_PAR02,_aRet)
	
	_cCODIGONC		:= 	QR1->B1_COD				// B1_COD
	_cDESC_NCG		:=	QR1->B1_XDESC			// B1_XDESC
	_cPUBLISH		:= 	CTD->CTD_DESC01			// CTD_DESC01
	_cPLATAF		:= 	SZ5->Z5_PLATRED			// SZ5->Z5_PLATRED
	_cCLASSIF		:=	QR1->B1_DESCCLA			// B1_DESCCLA
	_cSTATUS_C		:=	cStatus					// BUSCAR DESCRICAO TABELA ZX
	_nSLD_QT_DT		:= 	nQtd					// SALDO EM QUANTIDADE  DATA REFERENCIA
	_nSLD_VL_DT		:= 	nVal					// SALDO EM VALOR DATA REFERENCIA
	_nQT_VEN		:=	_aRet[2]				// QUANTIDADE VENDIDA
	_nQT_VEN_CMV	:= 	_aRet[3]				// QUANTIDADE VENDIDA CMV
	_nGIRO			:=	nQtd / _aRet[2]			// GIRO
	
	
	RecLock("TMP",.t.)
	TMP->CODIGONC	:=	_cCODIGONC
	TMP->DESC_NCG	:=	_cDESC_NCG
	TMP->PUBLISH	:=	_cPUBLISH
	TMP->PLATAF		:=	_cPLATAF
	TMP->CLASSIF	:=	_cCLASSIF
	TMP->STATUS_C	:=	_cSTATUS_C
	TMP->SLD_QT_DT	:=	_nSLD_QT_DT
	TMP->SLD_VL_DT	:=	_nSLD_VL_DT
	TMP->QT_VEN		:=	_nQT_VEN
	TMP->QT_VEN_CMV	:=	_nQT_VEN_CMV
	TMP->GIRO		:=	_nGIRO
	MsUnlock()
	
	QR1->(DbSkip())
	
EndDo


dbSelectarea("TMP")
dbGotop()

ntotvcmv 	:= 0
ntotvcmdven := 0
ntotGiro	:= 0

while TMP->(!EOF())
	
	ntotvcmv 	+= TMP->SLD_VL_DT
	ntotvcmdven += TMP->QT_VEN_CMV
	ntotGiro	+= TMP->GIRO
	
	TMP->(dbskip())
End

RecLock("TMP",.t.)
TMP->CODIGONC	:=	"TOTAL"
TMP->SLD_VL_DT	:=	ntotvcmv
TMP->QT_VEN_CMV	:=	ntotvcmdven
TMP->GIRO		:=	ntotGiro
MsUnlock()

//GERACSV()

If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif


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

Static Function CalcVal(_dData,_aRet)
Local _a 		:= _aRet
Local _dD 		:= _dData
Local _dDATE	:= _dData - MV_PAR03
Local cQuery 	:= ''
Local cNameSD1 	:= RetSqlName("SD1")
Local cNameSD2 	:= RetSqlName("SD2")
Local cNameSF4 	:= RetSqlName("SF4")
Local _nTotQ := 0
Local _nTotV := 0
Local _aNotas := {}

cQuery := "SELECT D2_DOC,D2_SERIE,D2_COD,D2_CLIENTE,D2_LOJA,D2_QUANT,D2_CUSTO1,F4_ESTOQUE,F4_DUPLIC "
cQuery += " FROM " + cNameSD2 + " SD2, " + cNameSF4 + " SF4 "
cQuery += " where D2_FILIAL  = '" + xFilial("SD2") + "'"
cQuery += " and D2_EMISSAO BETWEEN '" + DTOS(_dDate) + "' AND '"+dtos(_dD)+"' "
cQuery += " and D2_COD = '" + QR1->B1_COD + "'"
cQuery += " and D2_LOCAL = '" + QR1->B1_LOCPAD + "'"
cQuery += " and D2_TIPO NOT IN ('D', 'B') "
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "' "
cQuery += " and F4_CODIGO  = D2_TES "
cQuery += " and SD2.D_E_L_E_T_ <> '*' "
cQuery += " and SF4.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY " + SQLORDER (SD2->(INDEXKEY()))+" "

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

_nTotQ := 0
_nTotV := 0
_aNotas := {}

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		_nTotQ += QR11->D2_QUANT
		_nTotV += QR11->D2_CUSTO1
		aAdd(_aNotas,QR11->D2_DOC+QR11->D2_SERIE+QR11->D2_COD+QR11->D2_CLIENTE+QR11->D2_LOJA)
	Endif
	QR11->(dbSkip())
End

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

cQuery := "select D1_NFORI, D1_SERIORI,D1_COD,D1_FORNECE,D1_LOJA,F4_ESTOQUE,F4_DUPLIC, D1_CUSTO, D1_QUANT "
cQuery += " from " + cNameSD1 + " SD1, " + cNameSF4 + " SF4 "
cQuery += " where D1_FILIAL  = '" + xFilial("SD1") + "'"
cQuery += " and D1_DTDIGIT BETWEEN '" + DTOS(_dDate) + "' AND '"+dtos(_dD)+"' "
cQuery += " and D1_COD  = '" + QR1->B1_COD + "' "
cQuery += " and D1_TIPO = 'D'"
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "'"
cQuery += " and F4_CODIGO  = D1_TES"
cQuery += " and SD1.D_E_L_E_T_ = ' '"
cQuery += " and SF4.D_E_L_E_T_ = ' '"

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		If Ascan(_aNotas,QR11->D1_NFORI+QR11->D1_SERIORI+QR11->D1_COD+QR11->D1_FORNECE+QR11->D1_LOJA) > 0
			_nTotQ -= QR11->D1_QUANT
			_nTotV -= QR11->D1_CUSTO
		Endif
	Endif
	QR11->(dbSkip())
End


If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif


_a := {QR1->B1_COD,_nTotQ,_nTotv}


Return(_a)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCREST003 ºAutor  ³Microsiga           º Data ³  05/26/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Static Function geracsv()
nHandle	:= 0

If (nHandle := FCREATE(mv_par10, 1)) == -1
	lSucess	:= .F.
	MsgAlert("Nao foi possivel criar arquivo "+mv_par10, FERROR()  )
Endif


dbSelectarea("TMP")
dbGotop()                  

FWRITE(nHandle,"CODIGONC;DESCRICAO NCGAMES;PUBLISHER;PLATAFORMA;CLASSIFICACAO;STATUS CML;SALDO QTD;SALDO CMV;QTD VENDIDA;CMV VENDIDO VALOR;GIRO EM MESES"+CHR(13)+CHR(10))

While TMP->(!EOF())
	FWRITE(nHandle,TMP->CODIGONC+";"+TMP->DESC_NCG+";"+TMP->PUBLISH+";"+TMP->CLASSIF+";"+TMP->STATUS_C+";"+STR(TMP->SLD_QT_DT,16,2)+";"+STR(TMP->SLD_VL_DT,16,2)+";"+STR(TMP->QT_VEN,16,2)+";"+STR(TMP->QT_VEN_CMV,16,2)+";"+STR(TMP->GIRO,16,2)+CHR(13)+CHR(10))
	TMP->(dbSkip())
End

FCLOSE(nHandle)



Return
