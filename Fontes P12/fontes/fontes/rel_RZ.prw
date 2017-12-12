#include "protheus.ch"
#include "rwmake.ch"

User Function rel_ReduzZ()

Local aArea := GetArea()
Local oReport

ajustasx1()
Pergunte("REDUZ", .F.)

oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)
Return


Static Function ReportDef()

Local aArea := GetArea()
Local cAliasSFI := "SFI"

Private cFil
Private cFilweb
Private dData
Private nMovimento
Private nCancelado
Private nDesconto
Private nVCont
Private nBVCont
Private nT07
Private nT12
Private nT18
Private nT25
Private nFonte
Private nIsento
Private nImposto

Private cFil2
Private cFilweb2
Private nMov2
Private nCancel2
Private nDesconto2
Private nVCont2
Private nBVCont2
Private nT072
Private nT122
Private nT182
Private nT252
Private nFonte2
Private nIsento2
Private nImposto2


oReport := TReport():New("REDUZ","MAPA RESUMO","REDUZ",{|oReport| PrintReport(oReport,cAliasSFI)},"Relatorio consolidado por data e Loja")
oReport :SetLandscape()
oSection1 := TRSection():New(oReport,"MAPA RESUMO"		,{"SFI"})
oSection1:SetPageBreak(.T.)
oSection1:SetTotalInLine(.F.)
oSection1:TotalInLine()

oSection2 := TRSection():New(oReport,"TOTAL GERAL"		,{"SFI"})
oSection2:SetPageBreak(.T.)
oSection2:SetTotalInLine(.F.)
oSection2:TotalInLine()


//TRCell():New(oSection1,"cFil"     	  ,/*Tabela*/,"Filial Protheus"       ,""                           ,TamSX3("FI_FILIAL")[1] ,/*lPixel*/,{||cFil			})//Filial Protheus
//TRCell():New(oSection1,"cFilweb"     ,/*Tabela*/,"Filial Web"       		,""                             ,TamSX3("FI_YCODLOJ")[1],/*lPixel*/,{||cFilweb		})//Filial Webmanager

TRCell():New(oSection1,"cFil"     	  ,/*Tabela*/,"Filial/Loja"       ,""                           , 50 ,/*lPixel*/,{||cFil			})//Filial Protheus
TRCell():New(oSection1,"dData"       ,/*Tabela*/,"Data"       				,""                             ,TamSX3("FI_DTMOVTO")[1],/*lPixel*/,{||dData			})//Data
TRCell():New(oSection1,"nMovimento"  ,/*Tabela*/,"Mov. Dia"       			,"@E 999,999.99"                          ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nMovimento	})//Movimento do Dia
TRCell():New(oSection1,"nCancelado"  ,/*Tabela*/,"Cancelamentos"       	,"@E 999,999.99"                             ,TamSX3("FI_CANCEL")[1] ,/*lPixel*/,{||nCancelado	})//Cancelamentos
TRCell():New(oSection1,"nDesconto"   ,/*Tabela*/,"Descontos"       		,"@E 999,999.99"                             ,TamSX3("FI_DESC")[1]   ,/*lPixel*/,{||nDesconto})//Descontos
TRCell():New(oSection1,"nVCont"      ,/*Tabela*/,"Val. Contabil"       	,"@E 999,999.99"                             ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nVCont})//Valor Contábil
TRCell():New(oSection1,"nBVCont"     ,/*Tabela*/,"Base Calculo"       	,"@E 999,999.99"                             ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nBVCont})//Base de Cálculo
TRCell():New(oSection1,"nT07"        ,/*Tabela*/,"T07"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS7")[1],/*lPixel*/,{||nT07})//T07
TRCell():New(oSection1,"nT12"        ,/*Tabela*/,"T12"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS12")[1]   ,/*lPixel*/,{||nT12})//T12
TRCell():New(oSection1,"nT18"        ,/*Tabela*/,"T18"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS18")[1]  ,/*lPixel*/,{||nT18	})//T18
TRCell():New(oSection1,"nT25"        ,/*Tabela*/,"T25"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS25")[1]  ,/*lPixel*/,{||nT25	})//T25
TRCell():New(oSection1,"nFonte"      ,/*Tabela*/,"Fonte"       			,"@E 999,999.99"                             ,TamSX3("FI_SUBTRIB")[1],/*lPixel*/,{||nFonte})//Fonte
TRCell():New(oSection1,"nIsento"     ,/*Tabela*/,"Isento"       			,"@E 999,999.99"                             ,TamSX3("FI_ISENTO")[1] ,/*lPixel*/,{||nIsento		})//Isento
TRCell():New(oSection1,"nImposto"    ,/*Tabela*/,"Impostos"       		,"@E 999,999.99"	                          ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nImposto		})//Impostos

oBreak1 := TRBreak():New(oSection1,{|| cFil },"Total:",.F.)
TRFunction():New(oSection1:Cell("nMovimento" ), "TOT1", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nCancelado" ), "TOT2", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nDesconto" ), "TOT3", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nVCont" ), "TOT4", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nBVCont" ), "TOT5", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nT07" ), "TOT6", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nT12" ), "TOT7", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nT18" ), "TOT8", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nT25" ), "TOT9", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nFonte" ), "TOT10", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nIsento" ), "TOT11", "SUM", oBreak1,,,, .F., .F.)
TRFunction():New(oSection1:Cell("nImposto" ), "TOT12", "SUM", oBreak1,,,, .F., .F.)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//TRCell():New(oSection2,"cFil2"     	  ,/*Tabela*/,"Filial Protheus"       ,""                           ,TamSX3("FI_FILIAL")[1] ,/*lPixel*/,{||cFil2			})//Filial Protheus
//TRCell():New(oSection2,"cFilweb2"     ,/*Tabela*/,"Filial Web"       		,""                             ,TamSX3("FI_YCODLOJ")[1],/*lPixel*/,{||cFilweb2		})//Filial Webmanager
TRCell():New(oSection2,"cFil2"     	  ,/*Tabela*/,"Filial/Loja"       ,""                           ,50,/*lPixel*/,{||cFil2			})//Filial Protheus
TRCell():New(oSection2,"nMov2"  ,/*Tabela*/,"Mov. Dia"       			,"@E 999,999.99"                          ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nMov2	})//Movimento do Dia
TRCell():New(oSection2,"nCancel2"  ,/*Tabela*/,"Cancelamentos"       	,"@E 999,999.99"                             ,TamSX3("FI_CANCEL")[1] ,/*lPixel*/,{||nCancel2	})//Cancelamentos
TRCell():New(oSection2,"nDesconto2"   ,/*Tabela*/,"Descontos"       		,"@E 999,999.99"                             ,TamSX3("FI_DESC")[1]   ,/*lPixel*/,{||nDesconto2		})//Descontos
TRCell():New(oSection2,"nVCont2"      ,/*Tabela*/,"Val. Contabil"       	,"@E 999,999.99"                             ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nVCont2		})//Valor Contábil
TRCell():New(oSection2,"nBVCont2"     ,/*Tabela*/,"Base Calculo"       	,"@E 999,999.99"                             ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nBVCont2		})//Base de Cálculo
TRCell():New(oSection2,"nT072"        ,/*Tabela*/,"T07"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS7")[1],/*lPixel*/,{||nT072			})//T07
TRCell():New(oSection2,"nT122"        ,/*Tabela*/,"T12"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS12")[1]   ,/*lPixel*/,{||nT122			})//T12
TRCell():New(oSection2,"nT182"        ,/*Tabela*/,"T18"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS18")[1]  ,/*lPixel*/,{||nT182			})//T18
TRCell():New(oSection2,"nT252"        ,/*Tabela*/,"T25"       				,"@E 999,999.99"                             ,TamSX3("FI_BAS25")[1]  ,/*lPixel*/,{||nT252			})//T25
TRCell():New(oSection2,"nFonte2"      ,/*Tabela*/,"Fonte"       			,"@E 999,999.99"                             ,TamSX3("FI_SUBTRIB")[1],/*lPixel*/,{||nFonte2		})//Fonte
TRCell():New(oSection2,"nIsento2"     ,/*Tabela*/,"Isento"       			,"@E 999,999.99"                             ,TamSX3("FI_ISENTO")[1] ,/*lPixel*/,{||nIsento2		})//Isento
TRCell():New(oSection2,"nImposto2"    ,/*Tabela*/,"Impostos"       		,"@E 999,999.99"	                          ,TamSX3("FI_VALCON")[1] ,/*lPixel*/,{||nImposto2		})//Impostos

oBreak2= TRBreak():New(oSection2,{|| },"Total Geral:",.F.)
TRFunction():New(oSection2:Cell("nMov2" ), "TOT1", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nCancel2" ), "TOT2", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nDesconto2" ), "TOT3", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nVCont2" ), "TOT4", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nBVCont2" ), "TOT5", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nT072" ), "TOT6", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nT122" ), "TOT7", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nT182" ), "TOT8", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nT252" ), "TOT9", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nFonte2" ), "TOT10", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nIsento2" ), "TOT11", "SUM", oBreak2,,,, .F., .F.)
TRFunction():New(oSection2:Cell("nImposto2" ), "TOT12", "SUM", oBreak2,,,, .F., .F.)



RestArea(aArea)
Return oReport


Static Function PrintReport(oReport,cAliasSFI)

Local aArea := GetArea()
Local oSection1 := oReport:Section(1)
Local cQuery01 :=""
Local cQuery02 :=""

//////////////////////definição de dados que serão gravados
oReport:Section(1):Cell("cFil"  		):SetBlock({|| cFil })//Filial Protheus
//oReport:Section(1):Cell("cFilweb"  	):SetBlock({|| cFilweb })//Filial Webmanager
oReport:Section(1):Cell("dData"  	   ):SetBlock({|| dData })//Data
oReport:Section(1):Cell("nMovimento"  ):SetBlock({|| nMovimento })//Movimento do Dia
oReport:Section(1):Cell("nCancelado"  ):SetBlock({|| nCancelado })//Cancelamentos
oReport:Section(1):Cell("nDesconto"  ):SetBlock({|| nDesconto })//Descontos
oReport:Section(1):Cell("nVCont" ):SetBlock({|| nVCont })//Valor Contábil
oReport:Section(1):Cell("nBVCont"  ):SetBlock({|| nBVCont })//Base de Cálculo
oReport:Section(1):Cell("nT07"  ):SetBlock({|| nT07 })//T07
oReport:Section(1):Cell("nT12"  ):SetBlock({|| nT12	 })//T12
oReport:Section(1):Cell("nT18"  ):SetBlock({|| nT18	 })//T18
oReport:Section(1):Cell("nT25"  ):SetBlock({|| nT25 })//T25
oReport:Section(1):Cell("nFonte"  ):SetBlock({|| nFonte })//Fonte
oReport:Section(1):Cell("nIsento"  ):SetBlock({|| nIsento })//Isento
oReport:Section(1):Cell("nImposto"  ):SetBlock({|| nImposto })//Impostos
/////////////////////////////////////////////////////////////////////////////////////////
oReport:Section(2):Cell("cFil2"  		):SetBlock({|| cFil2 })//Filial Protheus
//oReport:Section(2):Cell("cFilweb2"  	):SetBlock({|| cFilweb2 })//Filial Webmanager
//oReport:Section(2):Cell("dData2"  	   ):SetBlock({|| dData2 })//Data
oReport:Section(2):Cell("nMov2"  ):SetBlock({|| nMov2 })//Movimento do Dia
oReport:Section(2):Cell("nCancel2"  ):SetBlock({|| nCancel2 })//Cancelamentos
oReport:Section(2):Cell("nDesconto2"  ):SetBlock({|| nDesconto2 })//Descontos
oReport:Section(2):Cell("nVCont2" ):SetBlock({|| nVCont2 })//Valor Contábil
oReport:Section(2):Cell("nBVCont2"  ):SetBlock({|| nBVCont2 })//Base de Cálculo
oReport:Section(2):Cell("nT072"  ):SetBlock({|| nT072 })//T07
oReport:Section(2):Cell("nT122"  ):SetBlock({|| nT122	 })//T12
oReport:Section(2):Cell("nT182"  ):SetBlock({|| nT182	 })//T18
oReport:Section(2):Cell("nT252"  ):SetBlock({|| nT252 })//T25
oReport:Section(2):Cell("nFonte2"  ):SetBlock({|| nFonte2 })//Fonte
oReport:Section(2):Cell("nIsento2"  ):SetBlock({|| nIsento2 })//Isento
oReport:Section(2):Cell("nImposto2"  ):SetBlock({|| nImposto2 })//Impostos
/////////////////////////////////////////////////////////////////////////////////////////
                                                                
//////////////////////definição de alinhamento
oReport:Section(1):Cell("cFil"  		):SetHeaderAlign("RIGTH")//Filial Protheus
//oReport:Section(1):Cell("cFilweb"  	):SetAlign("RIGTH")//Filial Webmanager
oReport:Section(1):Cell("dData"  	   ):SetHeaderAlign("RIGTH")//Data
oReport:Section(1):Cell("nMovimento"):SetHeaderAlign("RIGTH")//Movimento do Dia
oReport:Section(1):Cell("nCancelado"  ):SetHeaderAlign("RIGTH")//Cancelamentos
oReport:Section(1):Cell("nDesconto"  ):SetHeaderAlign("RIGTH")//Descontos
oReport:Section(1):Cell("nVCont" ):SetHeaderAlign("RIGTH")//Valor Contábil
oReport:Section(1):Cell("nBVCont"  ):SetHeaderAlign("RIGTH")//Base de Cálculo
oReport:Section(1):Cell("nT07"  ):SetHeaderAlign("RIGTH")//T07
oReport:Section(1):Cell("nT12"  ):SetHeaderAlign("RIGTH")//T12
oReport:Section(1):Cell("nT18"  ):SetHeaderAlign("RIGTH")//T18
oReport:Section(1):Cell("nT25"  ):SetHeaderAlign("RIGTH")//T25
oReport:Section(1):Cell("nFonte"  ):SetHeaderAlign("RIGTH")//Fonte
oReport:Section(1):Cell("nIsento"  ):SetHeaderAlign("RIGTH")//Isento
oReport:Section(1):Cell("nImposto"  ):SetHeaderAlign("RIGTH")//Impostos
/////////////////////////////////////////////////////////////////////////////////////////
oReport:Section(2):Cell("cFil2"  		):SetHeaderAlign("RIGTH")//Filial Protheus
//oReport:Section(2):Cell("cFilweb2"  	):SetAlign("RIGTH")//Filial Webmanager
//oReport:Section(2):Cell("dData2"  	   ):SetBlock({|| dData2 })//Data
oReport:Section(2):Cell("nMov2"  ):SetHeaderAlign("RIGTH")//Movimento do Dia
oReport:Section(2):Cell("nCancel2"  ):SetHeaderAlign("RIGTH")//Cancelamentos
oReport:Section(2):Cell("nDesconto2"  ):SetHeaderAlign("RIGTH")//Descontos
oReport:Section(2):Cell("nVCont2" ):SetHeaderAlign("RIGTH")//Valor Contábil
oReport:Section(2):Cell("nBVCont2"  ):SetHeaderAlign("RIGTH")//Base de Cálculo
oReport:Section(2):Cell("nT072"  ):SetHeaderAlign("RIGTH")//T07
oReport:Section(2):Cell("nT122"  ):SetHeaderAlign("RIGTH")//T12
oReport:Section(2):Cell("nT182"  ):SetHeaderAlign("RIGTH")//T18
oReport:Section(2):Cell("nT252"  ):SetHeaderAlign("RIGTH")//T25
oReport:Section(2):Cell("nFonte2"  ):SetHeaderAlign("RIGTH")//Fonte
oReport:Section(2):Cell("nIsento2"  ):SetHeaderAlign("RIGTH")//Isento
oReport:Section(2):Cell("nImposto2"  ):SetHeaderAlign("RIGTH")//Impostos
/////////////////////////////////////////////////////////////////////////////////////////


/*/////////////////////definição de alinhamento
oReport:Section(1):Cell("cFil"  		):SetAlign("RIGTH")//Filial Protheus
//oReport:Section(1):Cell("cFilweb"  	):SetAlign("RIGTH")//Filial Webmanager
oReport:Section(1):Cell("dData"  	   ):SetAlign("RIGTH")//Data
oReport:Section(1):Cell("nMovimento"):SetAlign("RIGTH")//Movimento do Dia
oReport:Section(1):Cell("nCancelado"  ):SetAlign("RIGTH")//Cancelamentos
oReport:Section(1):Cell("nDesconto"  ):SetAlign("RIGTH")//Descontos
oReport:Section(1):Cell("nVCont" ):SetAlign("RIGTH")//Valor Contábil
oReport:Section(1):Cell("nBVCont"  ):SetAlign("RIGTH")//Base de Cálculo
oReport:Section(1):Cell("nT07"  ):SetAlign("RIGTH")//T07
oReport:Section(1):Cell("nT12"  ):SetAlign("RIGTH")//T12
oReport:Section(1):Cell("nT18"  ):SetAlign("RIGTH")//T18
oReport:Section(1):Cell("nT25"  ):SetAlign("RIGTH")//T25
oReport:Section(1):Cell("nFonte"  ):SetAlign("RIGTH")//Fonte
oReport:Section(1):Cell("nIsento"  ):SetAlign("RIGTH")//Isento
oReport:Section(1):Cell("nImposto"  ):SetAlign("RIGTH")//Impostos
/////////////////////////////////////////////////////////////////////////////////////////
oReport:Section(2):Cell("cFil2"  		):SetAlign("RIGTH")//Filial Protheus
//oReport:Section(2):Cell("cFilweb2"  	):SetAlign("RIGTH")//Filial Webmanager
//oReport:Section(2):Cell("dData2"  	   ):SetBlock({|| dData2 })//Data
oReport:Section(2):Cell("nMov2"  ):SetAlign("RIGTH")//Movimento do Dia
oReport:Section(2):Cell("nCancel2"  ):SetAlign("RIGTH")//Cancelamentos
oReport:Section(2):Cell("nDesconto2"  ):SetAlign("RIGTH")//Descontos
oReport:Section(2):Cell("nVCont2" ):SetAlign("RIGTH")//Valor Contábil
oReport:Section(2):Cell("nBVCont2"  ):SetAlign("RIGTH")//Base de Cálculo
oReport:Section(2):Cell("nT072"  ):SetAlign("RIGTH")//T07
oReport:Section(2):Cell("nT122"  ):SetAlign("RIGTH")//T12
oReport:Section(2):Cell("nT182"  ):SetAlign("RIGTH")//T18
oReport:Section(2):Cell("nT252"  ):SetAlign("RIGTH")//T25
oReport:Section(2):Cell("nFonte2"  ):SetAlign("RIGTH")//Fonte
oReport:Section(2):Cell("nIsento2"  ):SetAlign("RIGTH")//Isento
oReport:Section(2):Cell("nImposto2"  ):SetAlign("RIGTH")//Impostos
////////////////////////////////////////////////////////////////////////////////////////*/





If Select(cAliasSFI) > 0
	(cAliasSFI)->(DbCloseArea())
EndIf

cQuery01:="SELECT FI_FILIAL FILIALPRT, "
cQuery01+="FI_YCODLOJ LOJAWM, "
cQuery01+="FI_DTMOVTO DATAMOV, "
cQuery01+="ROUND(FI_VALCON+FI_CANCEL+FI_DESC, 2) MOVIMENTO, "
cQuery01+="ROUND(FI_CANCEL, 2) CANCELADO,"
cQuery01+="ROUND(FI_DESC, 2) DESCONTO, "
cQuery01+="ROUND(FI_VALCON, 2) VALCONTABIL, "
cQuery01+="ROUND(FI_BAS7, 2) BAS7 ,"
cQuery01+="ROUND(FI_BAS12, 2) BAS12, "
cQuery01+="ROUND(FI_BAS18, 2) BAS18, "
cQuery01+="ROUND(FI_BAS25, 2) BAS25, "
cQuery01+="ROUND(FI_SUBTRIB, 2) SUBTRIB, "
cQuery01+="ROUND(FI_ISENTO, 2) ISENTO, "
cQuery01+="ROUND((FI_BAS7*0.7)+(FI_BAS12*0.12)+(FI_BAS18*0.18)+(FI_BAS25*0.25), 2) TIMPOSTO  "
cQuery01+="FROM "+RetSqlName("SFI")+" "
cQuery01+="WHERE FI_FILIAL BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'  "
cQuery01+="  AND FI_DTMOVTO BETWEEN '"+DtoS(mv_par03)+"' AND '"+DtoS(mv_par04)+"' "
cQuery01+="  AND D_E_L_E_T_ = ' '  ORDER BY 1,2,3 "            

cQuery01 := ChangeQuery(cQuery01)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery01),cAliasSFI,.T.,.T.)

dbselectArea(cAliasSFI)

oReport:SetMeter((cAliasSFI)->(LastRec()))
oReport:Section(1):Init()

While !oReport:Cancel() .And. !(cAliasSFI)->(EOF())
	
	If oReport:Cancel()
		Exit
	EndIf
	
	cFil	  						:= trim((cAliasSFI)->FILIALPRT)+"/"+ substr( Posicione("XX8",2,PADR(SM0->M0_CODIGO, 12 )+(cAliasSFI)->FILIALPRT,"XX8_DESCRI"),0,40)//Filial Protheus
//	cFilweb 					:= (cAliasSFI)->LOJAWM//Filial Webmanager
	dData	 					:= StoD((cAliasSFI)->DATAMOV)//Data
	nMovimento		:= (cAliasSFI)->MOVIMENTO//Movimento do Dia
	nCancelado		:= (cAliasSFI)->CANCELADO //Cancelamentos
	nDesconto			:=(cAliasSFI)->DESCONTO//Descontos
	nVCont 					:=(cAliasSFI)->VALCONTABIL//Valor Contábil
	nBVCont 				:=(cAliasSFI)->VALCONTABIL//Base de Cálculo
	nT07 	 					:=(cAliasSFI)->BAS7//T07
	nT12 	 					:=(cAliasSFI)->BAS12//T12
	nT18 	 					:=(cAliasSFI)->BAS18//T18
	nT25 	 					:=(cAliasSFI)->BAS25//T25
	nFonte 					:=(cAliasSFI)->SUBTRIB//Fonte
	nIsento 					:=(cAliasSFI)->ISENTO//Isento
	nImposto 			:= (cAliasSFI)->TIMPOSTO//Impostos

//	Posicione("XX8",2,PADR(SM0->M0_CODIGO, 12 )+(cAliasSFI)->FILIALPRT,"XX8_DESCRI")
	
	oReport:IncMeter()
	oReport:Section(1):PrintLine()
	
	                                                                                                     
	(cAliasSFI)->(DbSkip())
endDo
(cAliasSFI)->(DbCloseArea())

oReport:Section(1):Finish()

cQuery02:="SELECT  "
cQuery02+="  FI_FILIAL FILIALPRT, "
cQuery02+="  FI_YCODLOJ LOJAWM, "          
cQuery02+=" SUM(ROUND(FI_VALCON+FI_CANCEL+FI_DESC, 2)) MOVIMENTO, "
cQuery02+=" SUM(ROUND(FI_CANCEL, 2)) CANCELADO, "
cQuery02+=" SUM(ROUND(FI_DESC, 2)) DESCONTO, "
cQuery02+=" SUM(ROUND(FI_VALCON, 2)) VALCONTABIL, "
cQuery02+=" SUM(ROUND(FI_BAS7, 2)) BAS7 , "
cQuery02+=" SUM(ROUND(FI_BAS12, 2)) BAS12, "
cQuery02+=" SUM(ROUND(FI_BAS18, 2)) BAS18, "
cQuery02+=" SUM(ROUND(FI_BAS25, 2)) BAS25, "
cQuery02+=" SUM(ROUND(FI_SUBTRIB, 2)) SUBTRIB, "
cQuery02+=" SUM(ROUND(FI_ISENTO, 2)) ISENTO, "
cQuery02+=" SUM(ROUND((FI_BAS7*0.7)+(FI_BAS12*0.12)+(FI_BAS18*0.18)+(FI_BAS25*0.25), 2)) TIMPOSTO  "
cQuery02+=" FROM  "+RetSqlName("SFI")+" "
cQuery02+="WHERE FI_FILIAL BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'  "
cQuery02+="  AND FI_DTMOVTO BETWEEN '"+DtoS(mv_par03)+"' AND '"+DtoS(mv_par04)+"' "
cQuery02+="  AND D_E_L_E_T_ = ' '  GROUP BY FI_FILIAL, FI_YCODLOJ  "
cQuery02+="   ORDER BY 1,2   "      

cQuery02 := ChangeQuery(cQuery02)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery02),cAliasSFI,.T.,.T.)

dbselectArea(cAliasSFI)

oReport:Section(2):Init()

While !oReport:Cancel() .And. !(cAliasSFI)->(EOF())
	
	If oReport:Cancel()
		Exit
	EndIf
	//DADOS PARA A SEGUNDA SECTION
	cFil2	  							:= trim((cAliasSFI)->FILIALPRT)+"/"+ substr( Posicione("XX8",2,PADR(SM0->M0_CODIGO, 12 )+(cAliasSFI)->FILIALPRT,"XX8_DESCRI"),0,40)  //Filial Protheus
//	cFilweb2 					:= (cAliasSFI)->LOJAWM//Filial Webmanager
	nMov2						:=  (cAliasSFI)->MOVIMENTO//Movimento do Dia
	nCancel2					:= (cAliasSFI)->CANCELADO//Cancelamentos
	nDesconto2			:= (cAliasSFI)->DESCONTO//Descontos
	nVCont2 					:= (cAliasSFI)->VALCONTABIL//Valor Contábil
	nBVCont2 				:= (cAliasSFI)->VALCONTABIL//Base de Cálculo
	nT072 	 					:= (cAliasSFI)->BAS7//T07
	nT122	 						:= (cAliasSFI)->BAS12//T12
	nT182 	 					:= (cAliasSFI)->BAS18//T18
	nT252 	 					:=(cAliasSFI)->BAS25//T25
	nFonte2 					:=(cAliasSFI)->SUBTRIB//Fonte
	nIsento2 					:=(cAliasSFI)->ISENTO//Isento
	nImposto2 				:= (cAliasSFI)->TIMPOSTO//Impostos

	oReport:IncMeter()
	oReport:Section(2):PrintLine()
	
	                                                                                                     
	(cAliasSFI)->(DbSkip())
endDo
(cAliasSFI)->(DbCloseArea())

oReport:Section(2):Finish()

RestArea(aArea)
Return



Static Function ajustasx1()

Local aArea := GetArea()
Local aCampo :={}

AADD(aCampo, "Filial de:")
PutSX1("REDUZ","01","Filial de ?     "  ,"Filial de ?     ","Filial de ?     ","mv_ch1","C",2,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aCampo)

aCampo :={}
AADD(aCampo, "Filial Até:")
PutSX1("REDUZ","02","Filial Até ?     "  ,"Filial Até ?     ","Filial Até ?     ","mv_ch2","C",2,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aCampo)

aCampo :={}
AADD(aCampo, "Data de:")
PutSx1("REDUZ","03","Data Inicial:    "  ,"Data Inicial    ","Data Inicial    	","mv_ch3","D",8,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aCampo)

aCampo :={}
AADD(aCampo, "Data Até:")
PutSx1("REDUZ","04","Data Final:    "  ,"Data Final    ","Data Final    	","mv_ch4","D",8,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aCampo)


RestArea(aArea)
Return



