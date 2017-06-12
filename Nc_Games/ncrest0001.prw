#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRST0001 บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPlanilha de Pricing.                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES.                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCRST0001()

Private _cArqTmp	:= ""
Private _cIndTmp	:= ""


fRelato()

Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRelato   บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao da chamada do relatorio.                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fRelato()

Private cPerg := "REST01" 

fCriaSx1()

Pergunte(cPerg,.t.)

If ApMsgYesNo("Confirma geracao da Planilha ??","Confirmar")
	fGeraTmp()
Else
	Return
EndIf

Processa({|| fAtuDados() },"Processando Planilha")


__CopyFile(_cArqTmp+".DBF",mv_par05)

apmsgstop("Arquivo Gerado "+mv_par05,"ATENCAO")

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf
// abre arquivo temporario em excel.
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( mv_par05 ) // Abre uma planilha
oExcelApp:SetVisible(.T.)             

Ferase(_cArqTmp+".DBF")



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriacao de perguntas do relatorio.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

PutSX1(cPerg,"01","Produto de?  "   ,"Produto de? "		,"Produto de ?"		,"mv_ch1","C",15,0,1,"G","","SB1","","","mv_par01","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"02","Produto ate? "   ,"Produto ate?"		,"Produto ate?"		,"mv_ch2","C",15,0,1,"G","","SB1","","","mv_par02","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"03","Item cc de?  "   ,"Item cc de? "		,"Item cc de ?"		,"mv_ch3","C",09,0,1,"G","","CTD","","","mv_par03","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"04","Item cc ate? "   ,"Item cc ate?"		,"Item cc ate?"		,"mv_ch4","C",09,0,1,"G","","CTD","","","mv_par04","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"05","Arquivo ?    "   ,"Arquivo    ?"		,"Arquivo    ?"		,"mv_ch5","C",80,0,1,"G","","","","","mv_par05","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"06","Somente Ativos ?","Ativos     ?"		,"Ativos     ?"		,"mv_ch6","N",1 ,0,1,"C","","","","","mv_par06","Sim","Sim","Sim","Nใo","Nใo","Nใo","","","","","","","","","","")
PutSX1(cPerg,"07","Bloq Venda ? "   ,"Bloq Venda ?"		,"Bloq Venda ?"		,"mv_ch7","N",1 ,0,1,"C","","","","","mv_par07","Nใo","Nใo","Nใo","Ambos","Ambos","Ambos","","","","","","","","","","")
PutSX1(cPerg,"08","Armazem de ? "   ,"Armazem de ? "	,"Armazem de ? "	,"mv_ch8","C",2 ,0,1,"G","","ZZ","","","mv_par08","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"09","Armazem at้ ?"   ,"Armazem at้ ?"	,"Armazem at้ ?"	,"mv_ch9","C",2 ,0,1,"G","","ZZ","","","mv_par09","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"10","Tipo de ?    "   ,"Tipo de ?    "	,"Tipo de ?    "	,"mv_cha","C",2 ,0,1,"G","","02","","","mv_par10","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"11","Tipo at้ ?   "   ,"Tipo at้ ?   "	,"Tipo at้ ?   "	,"mv_chb","C",2 ,0,1,"G","","02","","","mv_par11","","","","","","","","","","","","","","","","")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGeraTmp  บAutor  ณAdriano Luis Brandaoบ Data ณ  15/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar arquivo temporario em branco.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - TISHMAN.                                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fGeraTmp()

Local _aCampos := {}

aAdd(_aCampos,{"CODIGO","C",15,0})			// D=DEVEDORA (CONTAS PAGAR) / C=CREDORA (CONTAS A RECEBER).
aAdd(_aCampos,{"DESC_NCG","C",100,0})			// NUMERO CENTRO DE CUSTOS
aAdd(_aCampos,{"PUBLISH","C",40,00})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"PLATAF","C",30,00})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"EST_QTD","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"EST_VAL","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"CMV","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"CMV_ATU","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"PRECO","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"PRC_CONS","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"FAT","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS
aAdd(_aCampos,{"MARK_UP","N",16,2})		// DESCRICAO DO CENTRO DE CUSTOS


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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtuDados บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar dados para o arquivo Excel               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtuDados()  

Private nQatu 	:= 0                                                               
Private nVatu 	:= 0                                                               
Private nCMV  	:= 0                                                               
Private nuCMVS  := 0           
Private cPlataf := space(30)                                                    

IF EMPTY(MV_PAR02)
	MV_PAR02 = 'ZZZZZZZZZZZZZZZ'
Endif	

IF EMPTY(MV_PAR04)
	MV_PAR04 = 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
Endif	

_cQuery := "SELECT count(*) total FROM "+RETSQLNAME("SB1")+ " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "             AND B1_ITEMCC BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_TIPO BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR11 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "
If MV_PAR07 = 1
	_cQuery += "             AND B1.B1_BLQVEND <> '1' "
EndIf
If MV_PAR06 = 1
	_cQuery += "             AND B1.B1_MSBLQL  <> '1' "
Endif               


If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif
	
TcQuery _cQuery New Alias "QR1"
dbSelectArea("QR1") 
dbGotop()

nTotal := QR1->total                                

If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif






_cQuery := "SELECT * FROM "+RETSQLNAME("SB1")+ " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "             AND B1_ITEMCC BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_TIPO BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR11 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "
If MV_PAR07 = 1
	_cQuery += "             AND B1.B1_BLQVEND <> '1' "
EndIf
If MV_PAR06 = 1
	_cQuery += "             AND B1.B1_MSBLQL  <> '1' "
Endif               
_cQuery += "ORDER BY B1_COD "                


If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif
	
TcQuery _cQuery New Alias "QR1"


dbSelectArea("QR1")
dbGotop()

ProcRegua(nTotal)

While QR1->(!EOF())

    IncProc()
    
	nQatu 	:= 0
	nVatu	:= 0
	dbSelectArea("SB2")
	dbSetOrder(1)
	If dbSeek(xfilial("SB2")+QR1->B1_COD+MV_PAR08)
		While SB2->(!eof()) .and. QR1->B1_COD == SB2->B2_COD .and. B2_LOCAL <= MV_PAR09
			nQatu += SB2->B2_QATU
			nVatu += SB2->B2_VATU1
			DBSKIP()
		END
	Else
		nQatu 	:= 0
		nVatu	:= 0
	Endif	


//		cQuery := "SELECT TOP 1 * FROM "+RETSQLNAME("SD2")+" SD2, "+CHR(13) + CHR(10)
		cQuery := "SELECT  * FROM "+RETSQLNAME("SD2")+" SD2, "+CHR(13) + CHR(10)
		cQuery += RETSQLNAME("SF4")+ " SF4  WHERE SD2.D_E_L_E_T_ <> '*' " + CHR(13) + CHR(10)
		cQuery += "AND SF4.D_E_L_E_T_ <> '*' " + CHR(13) + CHR(10)
		cQuery += "AND D2_TES = F4_CODIGO " + CHR(13) + CHR(10)
		cQuery += "AND F4_ESTOQUE = 'S' " + CHR(13) + CHR(10)
		cQuery += "AND D2_COD = '"+QR1->B1_COD+"' "+ CHR(13) +CHR(10)
//		cQuery += "AND D2_LOCAL = '"+QR1->B1_LOCPAD+"' "+ CHR(13) +CHR(10)
		cQuery += "AND D2_LOCAL BETWEEN '" + MV_PAR08 + "' AND '" + MV_PAR09 + "' "+ CHR(13) +CHR(10)
		cQuery += "AND D2_FILIAL = '"+XFILIAL("SD2")+"' "+ CHR(13) +CHR(10)
		cQuery += "AND F4_FILIAL = '"+XFILIAL("SF4")+"' "+ CHR(13) +CHR(10)
		cQuery += "AND Rownum < 2 "+ CHR(13) +CHR(10)
		cQuery += "ORDER BY SD2.D2_FILIAL, SD2.D2_EMISSAO DESC "+CHR(13) + CHR(10)
		If Select("TMP1") > 0
			TMP1->(dbCloseArea())
		Endif
			
		TcQuery cQuery New Alias "TMP1" 
		dbSelectArea("TMP1")
		dbGotop()         
		IF !EOF() .AND. TMP1->D2_QUANT <> 0
			nuCmvs := TMP1->D2_CUSTO1 / TMP1->D2_QUANT   
		Else
			nuCmvs := 0		
		Endif
				
	    If nQatu <= 0
	    	nCmv := nuCmvs
	    Else
			nCmv := nVatu / nQatu
        Endif                         
        
    dbSelectArea("SZ5") 
    dbSetOrder(1)
    If dbSeek(xFilial("SZ5")+QR1->B1_PLATAF)
    	cPlataf := SZ5->Z5_PLATRED
    Else
		cPlataf := "NAO CADASTRADO"
	Endif
	
		
	RecLock("TMP",.T.)
	TMP->CODIGO		:=	QR1->B1_COD
	TMP->DESC_NCG 	:=	QR1->B1_XDESC
	TMP->PUBLISH   	:=	QR1->B1_PUBLISH
	TMP->PLATAF		:=	cPlataf
	TMP->EST_QTD   	:=	nQatu
	TMP->EST_VAL   	:=	nVatu
	TMP->CMV		:=	nCmv
	TMP->CMV_ATU   	:=	nuCmvs
	TMP->PRECO		:=	QR1->B1_PRV1
	TMP->PRC_CONS	:=	QR1->B1_PRV1 /  0.73
	TMP->FAT		:=	nQatu * QR1->B1_PRV1
	If nCmv <> 0
		TMP->MARK_UP	:= QR1->B1_PRV1 / nCmv
	Else
		TMP->MARK_UP	:= 0
	Endif				
	
	MsUnlock()
	QR1->(DbSkip())

EndDo 


If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif


Return


