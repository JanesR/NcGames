#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ				   ___  "  ___												   บฑฑ
ฑฑบ				 ( ___ \|/ ___ ) Kazoolo									   บฑฑ
ฑฑบ				  ( __ /|\ __ )  Codefacttory 								   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณMPE001		 บAutor  ณDanilo M.Oliveira   บ Data ณ  15/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPlanilha Maiores problemas de estoque		               	  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAME														   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 																   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MPE001()

Private _cArqTmp2		:= ""
Private _cIndTmp  		:= ""

fGeraRel()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ				   ___  "  ___												   บฑฑ
ฑฑบ				 ( ___ \|/ ___ ) Kazoolo									   บฑฑ
ฑฑบ				  ( __ /|\ __ )  Codefacttory 								   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณfGeraRel		 บAutor  ณDanilo M.Oliveira   บ Data ณ  15/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera planilha do Excel                                	  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES														   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 																   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fGeraRel()

Private cPergun := "MPEPP"

fGeraSX1()

Pergunte(cPergun,.t.)

If Empty(mv_par13)
	msgstop("Arquivo de saida nใo especificado ")
	Return
Endif

dbSelectArea("SX6")
SX6->(dbSetOrder(1))
SX6->(dbGoTop())

If SX6->(dbSeek(xFilial("SX6")+"KZ_ICMS18"))
	cICMS18 :=  SuperGetMv("KZ_ICMS18",.T.,"018")
Else
	ShowHelpDlg("Parโmetro",{"O parametro 'KZ_ICMS18' nใo existe!"},5,{"Crie o parโmetro 'KZ_ICMS18' no configurador e inclua c๓digo da tabela de pre็os."},5)
	Return
EndIf

If ApMsgYesNo("Confirma geracao da Planilha ??","Confirmar")
	fGeraTmp()
Else
	Return
EndIf

Processa({|| fAtuDados() },"Processando Planilha")

cFOpen := cGetFile("Todos os Arquivos|*.*",'Selecione o Diretorio',0,'C:\',.T.,GETF_LOCALFLOPPY+GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.F.)

mv_par13 := cfOpen+alltrim(mv_par13)+".XLS"//ALTERADO DE .DBF PARA .XLS

__CopyFile(_cArqTmp2+".DBF",mv_par13)

apmsgstop("Arquivo Gerado "+mv_par13,"ATENCAO")

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf
// abre arquivo temporario em excel.
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( mv_par13 ) // Abre uma planilha
oExcelApp:SetVisible(.T.)

Ferase(_cArqTmp2+".DBF")


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ				   ___  "  ___												   บฑฑ
ฑฑบ				 ( ___ \|/ ___ ) Kazoolo									   บฑฑ
ฑฑบ				  ( __ /|\ __ )  Codefacttory 								   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณfGeraSX1		 บAutor  ณDanilo M.Oliveira   บ Data ณ  15/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera perguntas do relatorio                           	  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES														   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 																   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fGeraSX1()

Local alEstrut 	:= 	{	"X1_GRUPO"			,"X1_ORDEM"	,"X1_PERGUNT"						,"X1_PERSPA"						,"X1_PERENG"						,"X1_VARIAVL"	,"X1_TIPO"	,"X1_TAMANHO"	,"X1_DECIMAL"	,"X1_PRESEL"	,"X1_GSC"	,"X1_VALID"	,"X1_F3"			,"X1_GRPSXG","X1_PYME"		,"X1_VAR01"			,"X1_DEF01"														,"X1_DEFSPA1"					,"X1_DEFENG1"		,"X1_CONT01"				,"X1_DEF0X"				,"X1_DEFSPAX"													,"X1_DEFENGX"						,"X1_HELPPOR"		,"X1_HELPSPA"		,"X1_HELPENG"		,"X1_HELP"				,"X1_VAR04"			,"X1_DEF04"			,"X1_DEFSPA4"		,"X1_DEFENG4"		,"X1_CNT04"														,"X1_VAR05"			,"X1_DEF05"			,"X1_DEFSPA5"		,"X1_DEFENG5"	,"X1_CNT05"														,"X1_F3"	,"X1_PYME"	,"X1_GRPSXG"	,"X1_HELP"			,"X1_PICTURE"								,"X1_IDFIL"	}

PutSX1(					cPergun				,"01"		,"Publisher de ? "   				,"Publisher de ? "					,"Publisher de ? "					,"mv_ch1"		,"C"		,15				,0				,1				,"G"		,""			,"CTD"				,""			,""				,"mv_par01"			,""																,""								,""					,""				   			,""						,""																,""									,""					,""					,""					,"","","","",""	,"")
PutSX1(					cPergun				,"02"		,"Publisher ate ? "   				,"Publisher ate ? "					,"Publisher ate ? "					,"mv_ch2"		,"C"		,15				,0				,1				,"G"		,""			,"CTD"				,""			,""				,"mv_par02"			,""																,""								,""					,""				   			,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"03"		,"Data de ? "   					,"Data de ? "						,"Data de ? "						,"mv_ch3"		,"D"		,8				,0				,1				,"G"		,""			,""					,""			,""				,"mv_par03"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"04"		,"Data ate? "  						,"Data ate ? "						,"Data ate ? "						,"mv_ch4"		,"D"		,8				,0				,1				,"G"		,""			,""					,""			,""				,"mv_par04"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"05"		,"Giro " 							,"Giro "							,"Giro "							,"mv_ch5"		,"C"		,3				,0				,1				,"C"		,""			,""					,""			,""				,"mv_par05"			,"Por perํodo"													,"Por perํodo"					,"Por perํodo"		,"Conf.๚ltimo m๊s"			,"Conf.๚ltimo m๊s"		,"Conf.๚ltimo m๊s"												,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"06"		,"Produto de ? "	   				,"Produto de ? "					,"Produto de ? "					,"mv_ch6"		,"C"		,80				,0				,1				,"G"		,""			,"SB1"				,""			,""				,"mv_par06"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"07"		,"Produto ate ? "   				,"Produto ate ? "					,"Produto ate ? "					,"mv_ch7"		,"C"		,80				,0				,1				,"G"		,""			,"SB1"				,""			,""				,"mv_par07"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"08"		,"Plataforma de ? "   				,"Plataforma de ? "					,"Plataforma de ? "					,"mv_ch8"		,"C"		,15				,0				,1				,"G"		,""			,"SZ5"				,""			,""				,"mv_par08"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"09"		,"Plataforma ate ? "   				,"Plataforma ate ? "				,"Plataforma ate ? "				,"mv_ch9"		,"C"		,15				,0				,1				,"G"		,""			,"SZ5"				,""			,""				,"mv_par09"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")
PutSX1(					cPergun				,"10"		,"Considera devolucoes ? " 			,"Considera devolucoes ? "			,"Considera devolucoes ? "			,"mv_ch10"		,"C"		,3				,0				,1				,"C"		,""			,""					,""			,""				,"mv_par10"			,"Sim"															,"Sim"							,"Sim"				,""							,"Nao"					,"Nao"															,"Nao"								,""					,""					,""					,"","","","","","")
PutSx1(					cPergun 			,"11"		,"TES qto estoque ? "				,"TES qto estoque ? "				,"TES qto estoque ? "				,"mv_ch11"		,"N"		,1				,0				,2				,"C"		,""			,""					,""			,""				,"mv_par11"			,"Movimenta"													,"Movimenta"					,"Movimenta"		,"Nao Movimenta"			,"Nao Movimenta"		,"Nao Movimenta"												,"Considera Ambas"					,"Considera Ambas"	,"Considera Ambas"	,""					,"","","","","","","","","")
PutSx1(					cPergun				,"12"		,"TES qto faturamento ? "			,"TES qto faturamento ? "			,"TES qto faturamento ?"			,"mv_ch12"		,"N"		,1				,0				,2				,"C"		,""			,""					,""			,""				,"mv_par12"			,"Gera financeiro"												,"Gera financeiro"				,"Gera financeiro"	,"Nao gera"					,"Nao gera"				,"Nao gera"														,"Considera Ambas"					,"Considera Ambas"	,"Considera Ambas"	,""					,"","","","","","","","","")
PutSX1(					cPergun 			,"13"		,"Arquivo ?    "   					,"Arquivo    ?"						,"Arquivo    ?"						,"mv_ch13"		,"C"		,80				,0				,1				,"G"		,""			,""					,""			,""				,"mv_par13"			,""																,""								,""					,""							,""						,""																,""									,""					,""					,""					,"","","","","","")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ				   ___  "  ___												   บฑฑ
ฑฑบ				 ( ___ \|/ ___ ) Kazoolo									   บฑฑ
ฑฑบ				  ( __ /|\ __ )  Codefacttory 								   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณfGeraTmp		 บAutor  ณDanilo M.Oliveira   บ Data ณ  15/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera o arquivos temporarios em branco                 	  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES														   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 																   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fGeraTmp()

Local _aCampos 		:= {}
//	Private _cArqTmp	:= ""

aAdd(_aCampos,{"Publisher"				,"C",30	,0})			//Base da tabela em excel
aAdd(_aCampos,{"Titulo"					,"C",40 ,0})
aAdd(_aCampos,{"Plat"					,"C",15	,00})
aAdd(_aCampos,{"Estoque"				,"N",16	,00})
aAdd(_aCampos,{"CMV"					,"N",16	,2})
aAdd(_aCampos,{"Vl_Est"					,"N",16	,2})
aAdd(_aCampos,{"Pr_Venda"				,"N",16	,2})
aAdd(_aCampos,{"Vl_Venda"				,"N",16	,2})
aAdd(_aCampos,{"Giro"					,"N",16	,2})
aAdd(_aCampos,{"Est_Meses"				,"N",16	,2})
aAdd(_aCampos,{"Markup"					,"N",16	,2})

_cArqTmp2	:= Criatrab(_aCampos,.T.)
//_cIndTmp	:= Criatrab(,.f.)

If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif

DbUseArea(.T.,,_cArqTmp2,"TMP",.T.,.F.)

//IndRegua("TMP",_cIndTmp,"TIPO+C_CUSTO",,,"Criando indice....")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ				   ___  "  ___												   บฑฑ
ฑฑบ				 ( ___ \|/ ___ ) Kazoolo									   บฑฑ
ฑฑบ				  ( __ /|\ __ )  Codefacttory 								   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณfAtuDados		 | Autor ณDanilo M. Oliveira  บ Data ณ  15/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera dados para a planilha do Excel                   	  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES														   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 																   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtuDados()

Local cICMS18 	:=  SuperGetMv("KZ_ICMS18",.T.,"018")
Local cControl	:= ""
Local cCont		:= 1

MV_PAR11 := cValToChar(MV_PAR11)
MV_PAR12 := cValToChar(MV_PAR12)

If MV_PAR11 == "1"
	MV_PAR11 := "S"
ElseIf MV_PAR11 == "2"
	MV_PAR11 := "N"
Else
	MV_PAR11 := "A"
EndIf

If MV_PAR12 == "1"
	MV_PAR12 := "S"
ElseIf MV_PAR12 == "2"
	MV_PAR12 := "N"
Else
	MV_PAR12 := "A"
EndIf

_cQuery := "SELECT"																+ CRLF
_cQuery	+= "		SB1.B1_PUBLISH"												+ CRLF
_cQuery	+= "		,SB1.B1_XDESC"												+ CRLF
_cQuery	+= "		,SB1.B1_PRV1"												+ CRLF
_cQuery	+= "		,SZ5.PLATAFORMA"											+ CRLF
_cQuery	+= "		,SB2.QUANTIDADE"											+ CRLF
_cQuery	+= "		,SB2.QEMP"													+ CRLF
_cQuery	+= "		,SB2.RESERVA"												+ CRLF
_cQuery	+= "		,ROUND(SB22.CM1,2) AS CM1 "									+ CRLF
_cQuery	+= "		,(SB2.QUANTIDADE - SB2.QEMP - SB2.RESERVA) AS ESTOQUE" 		+ CRLF
_cQuery	+= "		,(SB22.CM1 * SB2.QUANTIDADE) AS VL_EST "					+ CRLF
_cQuery	+= "		,(DA1.PR_VEND * SB2.QUANTIDADE) AS VL_VEND "				+ CRLF
_cQuery	+= "		,DA1.PR_VEND "												+ CRLF
_cQuery	+= "		,SD2.TOTGIRO "												+ CRLF
_cQuery	+= "	,((DA1.PR_VEND * SB2.QUANTIDADE) / SD2.TOTGIRO )AS MS_ESTOQUE " + CRLF
_cQuery	+= "FROM"																+ CRLF
_cQuery	+= "("																	+ CRLF
_cQuery	+= "	SELECT"															+ CRLF
_cQuery	+= "		B1_COD"														+ CRLF
_cQuery	+= "		,B1_PUBLISH"												+ CRLF
_cQuery	+= "		,B1_XDESC"													+ CRLF
_cQuery	+= "		,B1_PLATAF"													+ CRLF
_cQuery	+= "		,B1_PRV1"													+ CRLF
_cQuery	+= "		,B1_ITEMCC"													+ CRLF
_cQuery	+= "	FROM " + RetSQLName("SB1") 										+ CRLF
_cQuery	+= "	WHERE "															+ CRLF

_cQuery	+= "			D_E_L_E_T_ <> '*'"				 						+ CRLF
_cQuery	+= "		AND	B1_ITEMCC BETWEEN '"+ mv_par01 +"' AND '"+mv_par02+"'"	+ CRLF
_cQuery	+= "		AND	B1_COD BETWEEN '"+ mv_par06 +"' AND '" + mv_par07 +"'"	+ CRLF
_cQuery	+= "		AND	B1_PLATAF BETWEEN '"+ mv_par08 +"' AND '"+mv_par09+"'"	+ CRLF
_cQuery	+= ") SB1"																+ CRLF
_cQuery	+= "INNER JOIN"									  						+ CRLF
_cQuery	+= "("																	+ CRLF
_cQuery	+= "	 SELECT"														+ CRLF
_cQuery	+= "		Z5_COD"														+ CRLF
_cQuery	+= "		,Z5_PLATRED AS PLATAFORMA"									+ CRLF
_cQuery	+= "	 FROM " + RetSqlName("SZ5")										+ CRLF
_cQuery	+= "	 WHERE "														+ CRLF

_cQuery	+= "			D_E_L_E_T_ <> '*'"				 						+ CRLF
_cQuery	+= ") SZ5"																+ CRLF
_cQuery	+= "ON SZ5.Z5_COD = SB1.B1_PLATAF"										+ CRLF
_cQuery	+= "INNER JOIN "								   						+ CRLF
_cQuery	+= "("																	+ CRLF
_cQuery	+= "	SELECT"									   						+ CRLF
_cQuery	+= "		B2_COD"									 					+ CRLF
_cQuery	+= "		,SUM(B2_QATU) AS QUANTIDADE"								+ CRLF
_cQuery	+= "		,SUM(B2_QEMP) AS QEMP"										+ CRLF
_cQuery	+= "		,SUM(B2_RESERVA)AS RESERVA"									+ CRLF

_cQuery	+= "	FROM " + RetSQLName("SB2") 										+ CRLF
_cQuery	+= "	WHERE "										   					+ CRLF
_cQuery	+= "			B2_FILIAL = '" + xFilial("SB2") + "'"  					+ CRLF
_cQuery	+= "		AND	D_E_L_E_T_ <> '*' AND B2_QATU > 0 "                     + CRLF
_cQuery	+= "		AND B2_LOCAL = '01' "					   					+ CRLF
_cQuery	+= "		AND B2_QATU IS NOT NULL"									+ CRLF
_cQuery	+= "	GROUP BY B2_COD "												+ CRLF
_cQuery	+= ") SB2"																+ CRLF
_cQuery	+= "ON SB1.B1_COD = SB2.B2_COD" 										+ CRLF
_cQuery	+= "INNER JOIN " 														+ CRLF

_cQuery	+= "(	" 												 				+ CRLF
_cQuery	+= "	SELECT B2_COD,SOMAVALOR/SOMAQTD AS CM1 " 						+ CRLF
_cQuery	+= "	FROM" 															+ CRLF
_cQuery	+= "	(" 																+ CRLF
_cQuery	+= "		SELECT	 B2_FILIAL" 										+ CRLF
_cQuery	+= "				,B2_COD " 											+ CRLF
_cQuery	+= "				,SUM(B2_QATU - B2_QEMP - B2_RESERVA) AS SOMAQTD" 	+ CRLF
_cQuery	+= "				,SUM(B2_VATU1) AS SOMAVALOR" 						+ CRLF
_cQuery	+= "		FROM " + RetSqlName("SB2")									+ CRLF
_cQuery	+= "		WHERE B2_FILIAL = '" + xFilial("SB2") +	"' "				+ CRLF
_cQuery	+= "		AND B2_QATU > 0" 											+ CRLF
_cQuery	+= "		AND B2_VATU1 > 0 " 											+ CRLF	 
_cQuery	+= "		GROUP BY B2_FILIAL,B2_COD" 									+ CRLF
_cQuery	+= "	) SB2CONT" 														+ CRLF
_cQuery	+= "	WHERE SOMAQTD > 0" 												+ CRLF
_cQuery	+= ") SB22" 															+ CRLF
_cQuery	+= "ON SB2.B2_COD = SB22.B2_COD " 										+ CRLF

_cQuery	+= "LEFT JOIN "															+ CRLF
_cQuery	+= "("																	+ CRLF
_cQuery	+= "	SELECT"															+ CRLF
_cQuery	+= "		DA1_CODTAB"													+ CRLF
_cQuery	+= "		,DA1_CODPRO"												+ CRLF
_cQuery	+= "		,DA1_PRCVEN AS PR_VEND"										+ CRLF
_cQuery	+= "	FROM "+ RetSQLName("DA1")										+ CRLF
_cQuery	+= "	WHERE "										   					+ CRLF
_cQuery	+= "			D_E_L_E_T_ <> '*' AND DA1_PRCVEN > 0 "					+ CRLF
_cQuery += "		AND DA1_CODTAB = '" + cICMS18 + "'"							+ CRLF
_cQuery	+= ") DA1"																+ CRLF
_cQuery	+= "ON SB1.B1_COD = DA1_CODPRO"                                        	+ CRLF
_cQuery	+= "INNER JOIN "														+ CRLF
_cQuery += "("                                                                	+ CRLF
_cQuery += " SELECT SUM(GIRO) AS TOTGIRO, D2_COD FROM "							+ CRLF
_cQuery	+= "	("																+ CRLF
_cQuery	+= "		SELECT"														+ CRLF
_cQuery	+= "			SUM(D2_TOTAL) AS GIRO"									+ CRLF
_cQuery	+= "			,D2_COD"												+ CRLF
_cQuery	+= "			,D2_TES"												+ CRLF
_cQuery	+= "		FROM " + RetSQLName("SD2")									+ CRLF
_cQuery	+= "		WHERE "										   				+ CRLF
_cQuery	+= "				D2_FILIAL = '" + xFilial("SD2") + "'" 				+ CRLF
_cQuery	+= "			AND	D_E_L_E_T_ <> '*'"				 					+ CRLF
If MV_PAR05 == 1
	_cQuery	+= "			AND	D2_EMISSAO BETWEEN '"+ dToS(MV_PAR03) + "'"    	+ CRLF
	_cQuery += " 			AND '" + dToS(MV_PAR04) + "'"	                    + CRLF
Else
	MV_PAR05 := SubStr( dToS( Date() - 30 ),1,6 )
	_cQuery += "			AND D2_EMISSAO LIKE '" + MV_PAR05 + "%%'"			+ CRLF
EndIf

If MV_PAR10 != 1
	_cQuery += " 			AND D2_TIPO <> 'D'"				                    + CRLF
EndIf
_cQuery	+= "		GROUP BY D2_COD,D2_TES "		   							+ CRLF
_cQuery += "	) SD2I "                                                        + CRLF
_cQuery += "	INNER JOIN "													+ CRLF
_cQuery += "	("																+ CRLF
_cQuery += "		SELECT "													+ CRLF
_cQuery += "			F4_CODIGO "												+ CRLF
_cQuery += "			,F4_DUPLIC "											+ CRLF
_cQuery += "			,F4_ESTOQUE "											+ CRLF
_cQuery += "		FROM " + RetSQLName("SF4")									+ CRLF
_cQuery += "		WHERE D_E_L_E_T_ <> '*'"									+ CRLF

If MV_PAR11 <> 'A'
	_cQuery += "	AND F4_ESTOQUE = '" + MV_PAR11 + "'"						+ CRLF
EndIf
If MV_PAR12 <> 'A'
	_cQuery += "	AND F4_DUPLIC = '" + MV_PAR12 + "'"							+ CRLF
EndIf
_cQuery += "	) SF4"															+ CRLF
_cQuery += "	ON SD2I.D2_TES = SF4.F4_CODIGO "								+ CRLF
_cQuery += " 	GROUP BY D2_COD "												+ CRLF
_cQuery += ") SD2"																+ CRLF
_cQuery += "ON SB1.B1_COD = D2_COD "											+ CRLF
_cQuery += "ORDER BY B1_PUBLISH,VL_VEND DESC " 									+ CRLF //FALTA O DESC

_cQuery := ChangeQuery(_cQuery)

If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery), "QR1" ,.T.,.F.)

QR1->( dbGoTop() )

cPublisher := QR1->B1_PUBLISH
cContd := 1

While QR1->( !EOF() )
	
	If cPublisher == QR1->B1_PUBLISH .and. cContd > 10       //SINAL DE IGUALDADE
		QR1->( dbSkip() )
	ElseIf cPublisher <> QR1->B1_PUBLISH
		cPublisher := QR1->B1_PUBLISH
		cContd := 1
	EndIf
	
	While QR1->( !EOF() ) .and. cPublisher == QR1->B1_PUBLISH .and. cContd <= 10 //SINAL DE IGUALDADE
		
		If QR1->VL_VEND <> 0
			RecLock("TMP",.t.)
			TMP->Publisher		:=	QR1->B1_PUBLISH
			TMP->Titulo		 	:=	QR1->B1_XDESC
			TMP->Plat		   	:=  QR1->PLATAFORMA
			TMP->Estoque		:=  QR1->ESTOQUE
			TMP->CMV		   	:=  QR1->CM1
			TMP->Vl_Est   		:=  QR1->VL_EST
			TMP->Pr_Venda		:=  QR1->PR_VEND
			TMP->Vl_Venda  		:=  QR1->VL_VEND
			TMP->Giro			:= 	QR1->TOTGIRO
			TMP->Est_meses		:= 	QR1->MS_ESTOQUE
			TMP->Markup			:=  QR1->PR_VEND/QR1->CM1
			
			TMP->( MsUnlock() )
		EndIf
		cContd := cContd + 1
		QR1->( dbSkip() )
		
	EndDo
EndDo

If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif           

Return

