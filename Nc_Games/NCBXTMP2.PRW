#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

#DEFINE NPREFIXOT	2 //Prefixo do titulo
#DEFINE NTITULO		3 //Tiutlo
#DEFINE NPARCELA	4 //Parcela	
#DEFINE NTIPO 		5 //Tipo        
#DEFINE NCODCLIENTE	14 //Codigo do Cliente
#DEFINE NLOJA		15 //Loja
#DEFINE NNOMEREDUZ	16 //Nome do cliente 
#DEFINE NVALORTIT	7 //Valor do titulo
#DEFINE NTAXAMOIP	8 //Taxa do moip
#DEFINE NVALORFIXO	9 //Valor fixo do moip   
#DEFINE NVALORBAIXA	12 //Valor baixa
#DEFINE NIDMOIP		21 //ID Moip
#DEFINE NPEDIDOCIA	17 //Pedido CIASHOP
#DEFINE NPVPROTHEUS	18 //Pedido no Protheus 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCBXTMP2		  บAutor  ณMicrosiga      บ Data ณ  18/11/14  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio para analise da baixa dos titulos processados	  บฑฑ
ฑฑบ          ณ pelo MOIP								 				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCBXTMP2(aDadosArq, lBxEcom)

Local aArea 		:= GetArea()
Local oReport

Private cNomeprog 	:= "NCBXTMP2"

Default aDadosArq 	:= {}             
Default lBxEcom 	:= .T.

//Rotina de impressใo do relat๓rio
oReport := ReportDef(aDadosArq, lBxEcom)
oReport:PrintDialog()


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
Static Function ReportDef(aDadosArq, lBxEcom)

Local oReport 
Local oSection1                      

Default lBxEcom := .T.

oReport:= TReport():New(cNomeprog,"Tํtulos processados pelo MOIP",;
							"", {|oReport| ReportPrint(oReport, aDadosArq, lBxEcom)},"Relat๓rio para analise dos tํtulos processados pelo MOIP")
oReport:SetLandscape(.F.)    
oreport:DisableOrientation()

oSection1 := TRSection():New(oReport,"Tํtulos processados pelo MOIP",/*(cArqTmp)*/)
oSection1:SetHeaderPage()
oSection1:lReadOnly := .T. 
oSection1:SetTotalInLine(.T.)  

TRCell():New(oSection1,"PREFIXO"	,/*Arq.Temp*/,"Prefixo"		,/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"TITULO"		,/*Arq.Temp*/,"Titulo"		,/*Picture*/,/*Tamanho*/50,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"PARCELA"	,/*Arq.Temp*/,"Parcela"		,/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"TIPO"		,/*Arq.Temp*/,"Tipo"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"CODCLI"		,/*Arq.Temp*/,"Cod.Cliente"	,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"LOJA"		,/*Arq.Temp*/,"Loja"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"NOMECLI"	,/*Arq.Temp*/,"Nome"		,/*Picture*/,/*Tamanho*/100,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VALORTIT"	,/*Arq.Temp*/,"Vlr.Titulo"	,"@E 999,999.99",/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"TXMOIP"		,/*Arq.Temp*/,"Tx.Moip"		,"@E 999,999.99",/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VLFIXOM"	,/*Arq.Temp*/,"Vlr.Fx.Moip" ,"@E 999,999.99",/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"VALORBX"	,/*Arq.Temp*/,"Vlr.Baixa"	,"@E 999,999.99",/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"IDMOIP"		,/*Arq.Temp*/,"Id.Moip"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"PVCIA"		,/*Arq.Temp*/,"Pv.CIASHOP"	,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"PVPRT"		,/*Arq.Temp*/,"Pv.Protheus"	,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)

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
Static Function ReportPrint(oReport, aDadosArq, lBxEcom)

Local aArea 	:= GetArea()
Local oSection1 := oReport:Section(1) 
Local nX		:= 0

Default aDadosArq 	:= {}                            
Default lBxEcom		:= .T.

oSection1:Init()

//Imprime os dados do relatorio
For nX := 1 To Len(aDadosArq)	 

	//Verifica se o status do MOIP esta concluido. Caso contrแrio, o titulo serแ desconsiderado na baixa
/*	If !SubStr(Alltrim(upper(aDadosArq[nX][STATUSMOIP])), 1,6) == "CONCLU" 
		loop
	EndIf	*/
	
	oSection1:Cell("PREFIXO"	):SetBlock({|| aDadosArq[nX][NPREFIXOT]		})
	oSection1:Cell("TITULO"		):SetBlock({|| aDadosArq[nX][NTITULO]		})
	oSection1:Cell("PARCELA"	):SetBlock({|| aDadosArq[nX][NPARCELA]		})
	oSection1:Cell("TIPO"		):SetBlock({|| aDadosArq[nX][NTIPO]			})
	oSection1:Cell("CODCLI"		):SetBlock({|| aDadosArq[nX][NCODCLIENTE]	})
	oSection1:Cell("LOJA"		):SetBlock({|| aDadosArq[nX][NLOJA]			})
	oSection1:Cell("NOMECLI"	):SetBlock({|| aDadosArq[nX][NNOMEREDUZ]	})
	oSection1:Cell("VALORTIT"	):SetBlock({|| aDadosArq[nX][NVALORTIT]		})
	oSection1:Cell("TXMOIP"		):SetBlock({|| aDadosArq[nX][NTAXAMOIP]		})
	oSection1:Cell("VLFIXOM"	):SetBlock({|| aDadosArq[nX][NVALORFIXO]	})
	oSection1:Cell("VALORBX"	):SetBlock({|| aDadosArq[nX][NVALORBAIXA] 	})
	oSection1:Cell("IDMOIP"		):SetBlock({|| aDadosArq[nX][NIDMOIP] 		}) 
	
	If lBxEcom
		oSection1:Cell("PVCIA"		):SetBlock({|| Alltrim(Str(aDadosArq[nX][NPEDIDOCIA])) })
	Else
		oSection1:Cell("PVCIA"		):SetBlock({|| ""})		
	EndIf

	oSection1:Cell("PVPRT"		):SetBlock({|| aDadosArq[nX][NPVPROTHEUS]	})	
	
	oSection1:PrintLine()
Next		

oSection1:Finish() 

RestArea(aArea)
Return NIL  
 

