#include "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"

Static aPos_A01:={}
Static aPos_A02:={}
Static aPos_A13:={}
Static aPos_A16:={}
Static aPos_A08:={}


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR113  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR114()
Local aAreaAtu	   :=GetArea()
Local cPerg  		:= 'NCGPR114'
Local cQryAlias 	:= GetNextAlias()
Local cTmpAlias 	:= GetNextAlias()
Local oReport
Local cNomeTmp

CriaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := ReportDef(cQryAlias,cTmpAlias, cPerg,@cNomeTmp)
oReport:PrintDialog()

If Select(cQryAlias)>0
	(cQryAlias)->(DbCloseArea())
EndIf

If Select(cTmpAlias)>0
	(cTmpAlias)->(E_EraseArq(cNomeTmp))
EndIf

RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR113  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(cQryAlias,cTmpAlias, cPerg,cNomeTmp)
Local cTitle  := "Relat๓rio Leitura Arquivos Envio/Retorno"
Local cHelp   := "Relat๓rio Leitura Arquivos Envio/Retorno"
Local oReport
Local oSection1
Local oSection2
Local aOrdem    := {}

oReport := TReport():New('NCGPR114',cTitle,cPerg,{|oReport| ReportPrint(oReport,cQryAlias,@cTmpAlias,aOrdem)},cHelp)
//TRCell():New(oSection2,"DH_CLIENTE"	,"SDH",STR0018+CRLF+STR0021	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(!Empty((cAliasSDH)->DH_CLIENTE),(cAliasSDH)->DH_CLIENTE,(cAliasSDH)->DH_FORNECE)})
oSection1 := TRSection():New(oReport,"Arquivos",{cTmpAlias},aOrdem)
TRCell():New(oSection1,"DESCTAB"   ,"","Tabela"			,,,/*lPixel*/,{|| (cTmpAlias)->ZZW_DESTAB 	})
TRCell():New(oSection1,"CHAVE"     ,"","Nr. Pedido"		,,06,/*lPixel*/,{|| (cTmpAlias)->DOCUMENTO	})
TRCell():New(oSection1,"ARQENV"    ,"","Arquivo Envio",,50,/*lPixel*/,{|| (cTmpAlias)->ZZW_ARQENV	})
TRCell():New(oSection1,"DATENV"    ,"","Data Envio"	,,15,/*lPixel*/,{|| (cTmpAlias)->ZZW_DATENV	})
TRCell():New(oSection1,"HORENV"    ,"","Hora Envio"	,,,/*lPixel*/,{|| (cTmpAlias)->ZZW_HORENV	})
TRCell():New(oSection1,"ARQRET"    ,"","Arquivo Envio",,50,/*lPixel*/,{|| (cTmpAlias)->ZZW_ARQRET	})
TRCell():New(oSection1,"DATRET"    ,"","Data Retorno"	,,15,/*lPixel*/,{|| (cTmpAlias)->ZZW_DATRET	})
TRCell():New(oSection1,"HORRET"    ,"","Hora Retorno"	,,,/*lPixel*/,{|| (cTmpAlias)->ZZW_HORRET	})


oSection2 := TRSection():New(oReport,"Dados",{cTmpAlias})
TRCell():New(oSection2,"Item"    	,"","Item"			,,AvSx3("C5_NUM"		,3),/*lPixel*/,{|| (cTmpAlias)->ITEM	 })
TRCell():New(oSection2,"PRODUTO"    ,"","Produto"			,,AvSx3("B1_COD"		,3),/*lPixel*/,{|| (cTmpAlias)->PRODUTO	 })
TRCell():New(oSection2,"DESCRICAO"  ,"","Descricao"		,,AvSx3("B1_XDESC",3),/*lPixel*/,{|| (cTmpAlias)->DESCRICAO})
TRCell():New(oSection2,"QTDENV" 	   ,"","Qtd. Enviada"	,AvSx3("D2_QUANT",6),AvSx3("D2_QUANT",3),/*lPixel*/,{|| (cTmpAlias)->QTDENV   })
TRCell():New(oSection2,"QTDRET" 	   ,"","Qtd. Retornada"	,AvSx3("D2_QUANT",6),AvSx3("D2_QUANT",3),/*lPixel*/,{|| (cTmpAlias)->QTDRET   })
Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR113  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport,cQryAlias,cTmpAlias,aOrdem)
Local oSecao1 		:= oReport:Section(1)
Local oSecao2 		:= oReport:Section(2)
Local cChaveTmp
Local cNomeTmp

GravaTmp(cTmpAlias,cQryAlias,@cNomeTmp)

(cTmpAlias)->(DbGoTop())

Do While (cTmpAlias)->(!Eof())
	oSecao1:Init()
	oSecao1:PrintLine()
	oSecao1:Finish()
	cChaveTmp:=(cTmpAlias)->DOCUMENTO
	oSecao2:Init()	
	Do While (cTmpAlias)->(!Eof()) .And. (cTmpAlias)->DOCUMENTO==cChaveTmp
		oSecao2:PrintLine()
		(cTmpAlias)->(DbSkip())
	EndDo
	oSecao2:Finish()
	oReport:EndPage() 
EndDo

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR113  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function criaSX1(cPerg)
PutSx1(cPerg,"01","Da Tabela?                    ","Da Tabela?                    ","Da Tabela?                    ","MV_CH1","N",1,0,0,"C","                                                            ","      ","   "," ","MV_PAR01","Pedido","","","                                                            ","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Data Envio de?                ","Data Envio de?                ","Data Envio de?                ","MV_CH2","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"03","Data Envio ate?               ","Data Envio ate?               ","Data Envio ate?               ","MV_CH3","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Data do Retorno de?           ","Data do Retorno de?           ","Data do Retorno de?           ","MV_CH4","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"05","Data Retorno ate?             ","Data Retorno ate?             ","Data Retorno ate?             ","MV_CH5","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"06","Chave? 				              ","Chave?             ","Chave?             ","MV_CH6","C",50,0,0,"G","                                                            ","      ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR114  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GravaTmp(cTmpAlias,cQryAlias,cNomeTmp)
Local aDbfStru:={}
Local cQuery
Local cPathArq	:=Alltrim(U_MyNewSX6("ES_NCG0004","\ARQ_WMS_STORE\","C","Diretorio Arquivos WMS Store","","",.F. ))
Local cArqEnv
Local cArqRet
Local aArquivos
Local lEnvio   
Local nLenItem	:=AvSx3("C5_NUM"		,3)
Local cFiltro:=""
Local nLenDoc
Local nLenProd



If Empty(aPos_A01)
	aPos_A01:=aClone( U_PR111RetLayout("A01") )//Documento
EndIf
If Empty(aPos_A02)
	aPos_A02:=aClone( U_PR111RetLayout("A02") )//Item Documento
EndIf

/*
If Empty(aPos_A16)
	aPos_A16:=aClone( U_PR111RetLayout("A16") )//Posi็ใo Estoque
EndIf

If Empty(aPos_A13)
	aPos_A13:=aClone( U_PR111RetLayout("A13") )//Lote Sequ๊ncia (Rela็ใo de Lotes Dependentes)
EndIf

If Empty(aPos_A08)
	aPos_A08:=aClone( U_PR111RetLayout("A08") )//Numero de Serie
EndIf
*/

                                      
AADD(aDbfStru,{"ITEM"		,"C",nLenItem,0})
AADD(aDbfStru,{"TIPOREG"	,"C",02,0})
AADD(aDbfStru,{"DOCUMENTO" ,"C",10,0})
AADD(aDbfStru,{"ZZW_TABELA" ,"C",AvSx3("ZZW_TABELA"	,3),AvSx3("ZZW_TABELA"	,4)})
AADD(aDbfStru,{"ZZW_DESTAB" ,"C",AvSx3("ZZW_DESTAB"	,3),AvSx3("ZZW_DESTAB"	,4)})
AADD(aDbfStru,{"ZZW_ARQENV" ,"C",AvSx3("ZZW_ARQENV"	,3),AvSx3("ZZW_ARQENV"	,4)})
AADD(aDbfStru,{"ZZW_DATENV" ,"D",AvSx3("ZZW_DATENV"	,3),AvSx3("ZZW_DATENV"	,4)})
AADD(aDbfStru,{"ZZW_HORENV" ,"C",AvSx3("ZZW_HORENV"	,3),AvSx3("ZZW_HORENV"	,4)})
AADD(aDbfStru,{"ZZW_ARQRET" ,"C",AvSx3("ZZW_ARQRET"	,3),AvSx3("ZZW_ARQRET"	,4)})
AADD(aDbfStru,{"ZZW_DATRET" ,"D",AvSx3("ZZW_DATRET"	,3),AvSx3("ZZW_DATRET"	,4)})
AADD(aDbfStru,{"ZZW_HORRET" ,"C",AvSx3("ZZW_HORRET"	,3),AvSx3("ZZW_HORRET"	,4)})

AADD(aDbfStru,{"PRODUTO" 	,"C",AvSx3("B1_COD"	,3),AvSx3("B1_COD"	,4)})
AADD(aDbfStru,{"DESCRICAO" ,"C",AvSx3("B1_XDESC",3),AvSx3("B1_XDESC"	,4)})
AADD(aDbfStru,{"QTDENV" 	,"N",AvSx3("D2_QUANT"  ,3),AvSx3("D2_QUANT"	,4)})
AADD(aDbfStru,{"QTDRET" 	,"N",AvSx3("D2_QUANT"  ,3),AvSx3("D2_QUANT"	,4)})

cNomeTmp:=E_CriaTrab(,aDbfStru,cTmpAlias)
IndRegua(cTmpAlias,cNomeTmp+OrdBagExt()    ,"DOCUMENTO+ITEM+PRODUTO", , , ,.F. )

nLenDoc	:=Len((cTmpAlias)->DOCUMENTO)
nLenProd :=Len((cTmpAlias)->PRODUTO)


/*
If mv_par01==1 .Or. mv_par01==5
	If !mv_par01=5
		cFiltro:="ZZW_TABELA In('SB1','SB2')"
	EndIf
EndIf

If mv_par01==2 .Or. mv_par01==5
	If !mv_par01=5
		cFiltro:="ZZW_TABELA='SF1'"
	EndIf
EndIf
*/

If mv_par01==1 .Or. mv_par01==5
	If !mv_par01=5
		cFiltro:="ZZW_TABELA='SC5'"
	EndIf
EndIf

/*
If mv_par01==4 .Or. mv_par01==5
	If !mv_par01=5
		cFiltro:="ZZW_TABELA='SF2'"
	EndIf
EndIf
*/

cQuery:=" Select ZZW.R_E_C_N_O_ RecZZW"+CRLF
cQuery+=" From "+RetSqlName("ZZW")+" ZZW"+CRLF
cQuery+=" Where ZZW.ZZW_FILIAL='"+xFilial("ZZW")+"'"+CRLF
cQuery+=" And ("+cFiltro+")"+CRLF
cQuery+=" And ZZW.ZZW_DATENV Between '"+Dtos(mv_par02)+"' And '"+Dtos(mv_par03)+"'"+CRLF
cQuery+=" And ZZW.ZZW_DATRET Between '"+Dtos(mv_par04)+"' And '"+Dtos(mv_par05)+"'"+CRLF
                               
If !Empty(mv_par06)
	cQuery+=" And ZZW.ZZW_CHAVE='"+mv_par06+"'"+CRLF
EndIf	

cQuery+=" And ZZW.D_E_L_E_T_=' '"+CRLF


DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias,.F.,.T.)


Do While (cQryAlias)->(!Eof())
	
	ZZW->(DbGoTo((cQryAlias)->RecZZW))
	
	
	If !Empty(ZZW->ZZW_ARQENV)
		cArqEnv:=cPathArq+AllTrim(ZZW->ZZW_ARQENV)
		If File( cPathArq+"Enviado\"+AllTrim(ZZW->ZZW_ARQENV ))
			cArqEnv:=cPathArq+"Enviado\"+AllTrim(ZZW->ZZW_ARQENV )
		ElseIf File(cArqEnv:=cPathArq+"Erro\"+AllTrim(ZZW->ZZW_ARQENV))
			cArqEnv:=cPathArq+"Erro\"+AllTrim(ZZW->ZZW_ARQENV)
		EndIf
	EndIf
	
	If !Empty(ZZW->ZZW_ARQRET)
		cArqRet:=cPathArq+"retornado\"+AllTrim(ZZW->ZZW_ARQRET)
		If File( cPathArq+"retornado\processado\"+AllTrim(ZZW->ZZW_ARQRET))
			cArqRet:=cPathArq+"retornado\processado\"+AllTrim(ZZW->ZZW_ARQRET)
		ElseIf File(cPathArq+"retornado\erro\"+AllTrim(ZZW->ZZW_ARQRET))
			cArqRet:=cPathArq+"retornado\erro\"+AllTrim(ZZW->ZZW_ARQRET)
		EndIf
	EndIf
	
	aArquivos:={cArqEnv,cArqRet}
	
	For nInd:=1 To Len(aArquivos)
		
		If !File(aArquivos[nInd])
			Loop
		EndIf            
		
		lEnvio:=(nInd==1)
		
		
		FT_FUSE(aArquivos[nInd] )
		FT_FGOTOP()
		Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
			cBuffer := FT_FREADLN() //LENDO LINHA
			aDados:={}
			
			SeparaDados(aDados,cBuffer)
			
			
			If Empty(aDados)
				FT_FSKIP();Loop
			EndIf    
			
			If aDados[01]$"01*03"
				FT_FSKIP();Loop
			EndIf    
			
			
			aDadosTemp:={"","",0,""}
			
			
			If aDados[01]$"01*03"
				aDadosTemp[1]:=SubStr(aDados[14],3)
			ElseIf aDados[01]$"04"//Item
				aDadosTemp[1]:=SubStr(aDados[05],3)
				aDadosTemp[2]:=aDados[07]
				aDadosTemp[3] :=Val(aDados[08])/10000
				aDadosTemp[4]:=StrZero( Val(aDados[18]),nLenItem)
			ElseIf aDados[01]$"08"//Numero de Serie
				aDadosTemp[1]:=SubStr(aDados[05],3)
				aDadosTemp[2]:=aDados[07]
			ElseIf aDados[01]=="55"
				aDadosTemp[1]:="ESTOQUE"
				aDadosTemp[2]  :=aDados[07]
				aDadosTemp[3]  :=Val(aDados[15])/10000
			EndIf
			   
			If lEnvio
				(cTmpAlias)->(DbAppend())			
				AvReplace("ZZW",cTmpAlias)		
			Else	                           
				If !(cTmpAlias)->(DbSeek(Padr(aDadosTemp[1],nLenDoc ) +Padr(aDadosTemp[4],nLenItem )+ Padr(aDadosTemp[2],nLenProd)))
					(cTmpAlias)->(DbAppend())							
				EndIf
			EndIf	                              
			(cTmpAlias)->DOCUMENTO	:=aDadosTemp[1]
			(cTmpAlias)->PRODUTO	 	:=aDadosTemp[2]
			(cTmpAlias)->ITEM	 		:=aDadosTemp[4]
			(cTmpAlias)->TIPOREG		 :=aDados[01]
			
			If !Empty((cTmpAlias)->PRODUTO)
				(cTmpAlias)->DESCRICAO:=Posicione("SB1",1,xFilial()+(cTmpAlias)->PRODUTO,"B1_XDESC")
			EndIf
			
			If lEnvio
				(cTmpAlias)->QTDENV:=aDadosTemp[3]
			Else
				(cTmpAlias)->QTDRET:=aDadosTemp[3]
			EndIf
			
			FT_FSKIP()   //pr๓ximo registro no arquivo txt
		EndDo
		
		FT_FUSE() //fecha o arquivo txt
		
	Next
	
	(cQryAlias)->(DbSkip())
	
EndDo


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR114  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SeparaDados(aDados,cBuffer,cArquivo)
Local aPosAux:={}
Local nInd

aDados:={}
If !Empty(cBuffer)
	If Left(cBuffer,2)$"01*03*23*33*35*53"
		aPosAux:=aPos_A01
	ElseIf Left(cBuffer,2)$"02*04"
		aPosAux:=aPos_A02
	ElseIf Left(cBuffer,2)$"08"
		aPosAux:=aPos_A08
	ElseIf Left(cBuffer,2)$"15*16"
		aPosAux:=aPos_A13
	ElseIf Left(cBuffer,2)$"55"
		aPosAux:=aPos_A16
	EndIf
	
EndIf

For nInd:=1 To Len(aPosAux)
	AADD(aDados,SubStr(cBuffer,aPosAux[nInd,3],aPosAux[nInd,4]))
Next


Return
                         



