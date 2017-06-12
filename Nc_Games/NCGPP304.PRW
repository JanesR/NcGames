#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPP304		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio credit note pendente							  บฑฑ
ฑฑบ          ณ 											 				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPP304()

Local aArea 	:= GetArea()
Local cPerg 	:= "NCGPP304"
Local oReport


Private cArqTmp   := ""
Private cNomeProg 	:= "NCGPP304"

//Cria as perguntas do relatorio
CriaSX1(cPerg)     

//Tela de perguntas
Pergunte(cPerg,.T.)

//Arquivo temporario com os dados do relatorio
cArqTmp := GetDRel()

//Rotinas de impressใo do relat๓rio
oReport := ReportDef()
oReport:PrintDialog()

//Fecha a tabela temporaria
(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return                           


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณElton C.            บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefinicao do objeto do relatorio personalizavel e das		  บฑฑ
ฑฑบ          ณsecoes que serao utilizadas                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport 
Local oSection1                      
Local oBreak1	
Local oBreak2	
Local oTotal1
Local oTotal2

oReport:= TReport():New(cNomeprog,"Credit Note",;
							"", {|oReport| ReportPrint(oReport)},"Relat๓rio de credit note")
oReport:SetLandscape(.F.)    
oreport:DisableOrientation()

oSection1 := TRSection():New(oReport,"Credit Note",/*(cArqTmp)*/)
oSection1:SetHeaderPage()
oSection1:lReadOnly := .T. 
oSection1:SetTotalInLine(.T.)  


TRCell():New(oSection1,"TPMOV"		,,"Tp.Repasse"		,/*Picture*/		,/*Tamanho*/10							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CODCLI"		,,"Cod.Cli"			,/*Picture*/		,/*Tamanho*/TAMSX3("A1_COD")[1]			,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"LOJA"		,,"Loja"			,/*Picture*/		,/*Tamanho*/TAMSX3("A1_LOJA")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"NOME"		,,"Nome"			,/*Picture*/		,/*Tamanho*/TAMSX3("A1_NREDUZ")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CODPP"		,,"Cod.PP\VP"		,/*Picture*/		,/*Tamanho*/TAMSX3("P05_CODPP")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CAMPANHA"	,,"Campanha"		,/*Picture*/		,/*Tamanho*/TAMSX3("P05_PPPUB")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"PUBLISHER"	,,"Publisher"		,/*Picture*/		,/*Tamanho*/TAMSX3("P05_PUBLIS")[1]-15	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CREDITNOT"	,,"Credit Note"		,/*Picture*/		,/*Tamanho*/TAMSX3("P05_CREDNO")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"DTAPLIC"	,,"Dt.Aplic."		,/*Picture*/		,/*Tamanho*/TAMSX3("P05_DTAPLI")[1]+2	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"DTEFET"		,,"Dt.Efetiv."		,/*Picture*/		,/*Tamanho*/TAMSX3("P05_DTEFET")[1]+2	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CODPRO"		,,"Cod.Prod."		,/*Picture*/		,/*Tamanho*/TAMSX3("B1_COD")[1]			,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"DESCPRO"	,,"Descri็ใo"		,/*Picture*/		,/*Tamanho*/40							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"TXDOLA"		,,"Tx.Dolar"		,"@E 999.99"		,/*Tamanho*/TAMSX3("P05_TXDOLA")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VLTOTAL"	,,"Valor Total"		,"@E 999,999,999.99",/*Tamanho*/TAMSX3("P05_VALOR")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VLTOTDOLA"	,,"Vl Total $"	,"@E 999,999,999.99",/*Tamanho*/TAMSX3("P05_VALOR")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)

oBreak1 := TRBreak():New( oSection1, {|| (cArqTmp)->TPMOV }, "Total: ") 
oTotal1	:= TRFunction():New(oSection1:Cell("VLTOTAL"),,"SUM",oBreak1,"Total por Tp.Repasse: "		,"@E 999,999,999.99",,.F.,.F.,.F.)
oTotal2	:= TRFunction():New(oSection1:Cell("VLTOTDOLA"),,"SUM",oBreak1,"Total por Tp.Repasse: "	,"@E 999,999,999.99",,.F.,.F.,.F.)

oBreak2 := TRBreak():New( oSection1, {|| }, "Total Geral: ") 
oTotal1	:= TRFunction():New(oSection1:Cell("VLTOTAL"),,"SUM",oBreak2,"Total Geral: "		,"@E 999,999,999.99",,.F.,.F.,.F.)
oTotal2	:= TRFunction():New(oSection1:Cell("VLTOTDOLA"),,"SUM",oBreak2,"Total Geral: "	,"@E 999,999,999.99",,.F.,.F.,.F.)

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor  ณElton C.          บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPreenchimento dos dados a ser impresso no relat๓rio		  บฑฑ
ฑฑบ          ณ                                 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)

Local aArea 	:= GetArea()
Local oSection1 := oReport:Section(1) 
Local nX		:= 0

oSection1:Init()

//Imprime os dados do relatorio
While (cArqTmp)->(!Eof())

	oSection1:Cell("TPMOV"		):SetBlock({|| (cArqTmp)->TPMOV					})
	oSection1:Cell("CODCLI"		):SetBlock({|| (cArqTmp)->CODCLI				})
	oSection1:Cell("LOJA"		):SetBlock({|| (cArqTmp)->LOJA					})
	oSection1:Cell("NOME"		):SetBlock({|| (cArqTmp)->NOME					})
	oSection1:Cell("CODPP"		):SetBlock({|| (cArqTmp)->CODPP					})
	oSection1:Cell("CAMPANHA"	):SetBlock({|| (cArqTmp)->CAMPANHA				})
	oSection1:Cell("PUBLISHER"	):SetBlock({|| (cArqTmp)->PUBLISHER				})
	oSection1:Cell("CREDITNOT"	):SetBlock({|| (cArqTmp)->CREDITNOT				})	
	oSection1:Cell("DTAPLIC"	):SetBlock({|| STOD((cArqTmp)->DTAPLIC)			})
	oSection1:Cell("DTEFET"		):SetBlock({|| STOD((cArqTmp)->DTEFET)			})
	oSection1:Cell("CODPRO"		):SetBlock({|| (cArqTmp)->CODPRO				})
	oSection1:Cell("DESCPRO"	):SetBlock({|| SubStr((cArqTmp)->DESCPRO,1,40)	})
	oSection1:Cell("TXDOLA"		):SetBlock({|| (cArqTmp)->TXDOLA				})
	oSection1:Cell("VLTOTAL"	):SetBlock({|| (cArqTmp)->VLTOTAL 				})
	oSection1:Cell("VLTOTDOLA"	):SetBlock({|| IIf( (cArqTmp)->TXDOLA != 0, (cArqTmp)->VLTOTAL / (cArqTmp)->TXDOLA,0) })
	
	oSection1:PrintLine()
	
	(cArqTmp)->(DbSkip())
EndDo		
                    
oSection1:Finish() 

RestArea(aArea)
Return NIL  
 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDRel	  บAutor  ณElton C.          บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o arquivo temporario com os dados do relatorio	  บฑฑ
ฑฑบ          ณ                                 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDRel()

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpRet   	:= GetNextAlias()
Local cCliente		:= U_MyNewSX6("NC_CMVGCLI",;
									"000001",;
									"C",;
									"C๓digo do cliente NC Games",;
									"C๓digo do cliente NC Games",;
									"C๓digo do cliente NC Games",;
									.F. )
Local cLojaCli		:= U_MyNewSX6("NC_CMVGLJ",;
									"01",;
									"C",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									"Loja do cliente NC Games",;
									.F. )


cQuery	:= " SELECT 'PP Est.NC' TPMOV, '"+cCliente+"' CODCLI, '"+cLojaCli+"' LOJA, A1_NREDUZ NOME, P05_CODPP CODPP, "+CRLF
cQuery	+= " P05_PPPUB CAMPANHA, P05_PUBLIS PUBLISHER, P05_CREDNO CREDITNOT, "+CRLF
cQuery	+= " P05_DTAPLI DTAPLIC, P05_DTEFET DTEFET, P06_CODPRO CODPRO, P06_DESC DESCPRO, P05_TXDOLA TXDOLA, "+CRLF
cQuery	+= "  P06_TOTAL VLTOTAL, P06_DLCONV VLTOTDOLA "+CRLF
cQuery	+= " FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery	+= " ON P06.P06_FILIAL = P05.P05_FILIAL "+CRLF
cQuery	+= " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQuery	+= " AND P06.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery	+= " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery	+= " AND SA1.A1_COD = '"+cCliente+"' "+CRLF
cQuery	+= " AND SA1.A1_LOJA = '"+cLojaCli+"' "+CRLF
cQuery	+= " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery	+= " ON P0C.P0C_FILIAL = P05.P05_FILIAL "+CRLF
cQuery	+= " AND P0C.P0C_PPPUB = P05.P05_PPPUB "+CRLF
cQuery	+= " AND P0C.P0C_PUBLIS BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery	+= " AND P0C.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery	+= " AND P05.P05_DTAPLI BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+CRLF
cQuery	+= " AND P05.P05_DTEFET != ' ' "+CRLF
cQuery	+= " AND P05.P05_PPPUB  BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+CRLF

If MV_PAR07 == 1 //Imprime documentos pendentes de credit note
	cQuery	+= " AND P05.P05_CREDNO = ' ' "+CRLF

ElseIf MV_PAR07 == 2//Imprime documentos com credit note

	cQuery	+= " AND P05.P05_CREDNO != ' ' "+CRLF
EndIf 
cQuery	+= " AND P05.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " UNION ALL "+CRLF
cQuery	+= " SELECT 'PP Est.Cli' TPMOV, PZD_CLIENT CODCLI, PZD_LOJA LOJA, PZD_NOME NOME, PZD_CODPP CODPP, "+CRLF
cQuery	+= " PZC_PPPUB CAMPANHA, PZC_PUBLIS PUBLISHER, PZC_CREDNO CREDITNOT, PZC_DTAPLI DTAPLIC, PZC_DTEFET DTEFET, "+CRLF
cQuery	+= " PZD_CODPRO CODPRO, PZD_DESC DESCPRO, PZC_TXDOLA TXDOLA, PZD_TOTPUB VLTOTAL, PZD_CDOLAR VLTOTDOLA  "+CRLF
cQuery	+= " FROM "+RetSqlName("PZC")+" PZC "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("PZD")+" PZD "+CRLF
cQuery	+= " ON PZD.PZD_FILIAL = PZC.PZC_FILIAL "+CRLF
cQuery	+= " AND PZD.PZD_CODPP = PZC.PZC_CODPP "+CRLF
cQuery	+= " AND PZD.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery	+= " ON P0C.P0C_FILIAL = PZC.PZC_FILIAL "+CRLF
cQuery	+= " AND P0C.P0C_PPPUB = PZC.PZC_PPPUB "+CRLF
cQuery	+= " AND P0C.P0C_PUBLIS BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery	+= " AND P0C.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE PZC.PZC_FILIAL = '"+xFilial("PZC")+"' "+CRLF 
cQuery	+= " AND PZC.PZC_DTAPLI BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+CRLF
cQuery	+= " AND PZC.PZC_DTEFET != ' ' "+CRLF
cQuery	+= " AND PZC.PZC_PPPUB  BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+CRLF

If MV_PAR07 == 1 //Imprime documentos pendentes de credit note
	cQuery	+= " AND PZC.PZC_CREDNO = ' ' "+CRLF

ElseIf MV_PAR07 == 2//Imprime documentos com credit note

	cQuery	+= " AND PZC.PZC_CREDNO != ' ' "+CRLF
EndIf 
cQuery	+= " AND PZC.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " UNION ALL "+CRLF
cQuery	+= " SELECT 'Verba Publis.' TPMOV, PZF_CLIENT CODCLI, PZF_LOJA LOJA, PZF_NOME NOME, PZE_CODVP CODPP, "+CRLF
cQuery	+= " PZE_PPPUB CAMPANHA, PZE_PUBLIS PUBLISHER, PZE_CREDNO CREDITNOT, PZE_DTDIGI DTAPLIC, PZE_DTEFET DTEFET, "+CRLF
cQuery	+= " ' ' CODPRO, ' ' DESCPRO, PZE_TXDOLA TXDOLA, PZF_VALOR VLTOTAL, PZF_VLDOLA VLTOTDOLA "+CRLF
cQuery	+= " FROM "+RetSqlName("PZE")+" PZE "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("PZF")+" PZF "+CRLF
cQuery	+= " ON PZF.PZF_FILIAL = PZE.PZE_FILIAL "+CRLF
cQuery	+= " AND PZF.PZF_CODVP = PZE.PZE_CODVP "+CRLF
cQuery	+= " AND PZF.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery	+= " ON P0C.P0C_FILIAL = PZE.PZE_FILIAL "+CRLF
cQuery	+= " AND P0C.P0C_PPPUB = PZE.PZE_PPPUB "+CRLF
cQuery	+= " AND P0C.P0C_PUBLIS BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "+CRLF
cQuery	+= " AND P0C.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE PZE.PZE_FILIAL = '"+xFilial("PZE")+"' "+CRLF
cQuery	+= " AND PZE.PZE_DTDIGI BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "+CRLF
cQuery	+= " AND PZE.PZE_DTEFET != ' ' "+CRLF
cQuery	+= " AND PZE.PZE_PPPUB  BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "+CRLF

If MV_PAR07 == 1 //Imprime documentos pendentes de credit note
	cQuery	+= " AND PZE.PZE_CREDNO = ' ' "+CRLF

ElseIf MV_PAR07 == 2//Imprime documentos com credit note

	cQuery	+= " AND PZE.PZE_CREDNO != ' ' "+CRLF
EndIf 
cQuery	+= " AND PZE.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmpRet,.T.,.T.)

RestArea(aArea)
Return cArqTmpRet                                                     


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma   ณ CriaSX1   ณ Autor ณ Microsiga - PLS      ณ Data ณ 27.01.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao  ณ Atualiza SX1                                               ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ*/
Static Function CriaSX1(cPerg)
	
Default cPerg := ""

PutSx1(cPerg, "01", "Dt.Aplica็ใo de"  ,"Dt.Aplica็ใo de","Dt.Aplica็ใo de"	,"mv_ch1","D",08,0,1,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "02", "Dt.Aplica็ใo at้"  ,"Dt.Repasse at้","Dt.Repasse at้"	,"mv_ch2","D",08,0,1,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "03", "Camp.Publisher de","Camp.Publisher de","Camp.Publisher de","mv_ch3","C",TAMSX3("PZC_PPPUB")[1],0,1,"G","","P0C","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "04", "Camp.Publisher at้ ","Camp.Publisher at้ ","Camp.Publisher at้ ","mv_ch4","C",TAMSX3("PZC_PPPUB")[1],0,1,"G","","P0C","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "05", "Publisher de","Publisher de","Publisher de","mv_ch5","C",TAMSX3("P0C_PUBLIS")[1],0,1,"G","","CTD","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "06", "Publisher at้ ","Publisher at้ ","Publisher at้ ","mv_ch6","C",TAMSX3("P0C_PUBLIS")[1],0,1,"G","","CTD","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg, "07",	"Credit Note"	,"",""	,"mv_ch7","N",01,0,2,"C","","","","","mv_par07","Pendente","","","","Aplicado","","","Todos","" )	

Return                





