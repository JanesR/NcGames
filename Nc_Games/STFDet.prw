#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#Include "tbiconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)

User Function SftDeta()

Local oReport
oReport := ReportDef()
oReport:PrintDialog()                                                                    

Return
                                                                   

Static Function ReportDef()


Local 	dEmissao := ctod("  /  /  ")
Local	dEntrada := ctod("  /  /  ")
Local oReport
Local oNoAtend
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario

oReport := TReport():New("SFTDeta","Relação de Notas Fiscais SFT","SFTDeta", {|oReport| ReportPrint(oReport,oNoAtend)},"")

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSx1()
Pergunte(oReport:uParam,.T.)

oNoAtend := TRSection():New(oReport,"SFTDetalhe",{"SFT","SD1","SA2","CT1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNoAtend:SetTotalInLine(.F.)

//TRCell():New(oNoAtend,"CODPRO"		,"cArqTRB",RetTitle("ZD_CODPRO"),PesqPict("SZD","ZD_CODPRO")	,TamSx3("ZD_CODPRO")  	[1]	,/*lPixel*/,/*{|| cVend }*/	)// "Codigo do Cliente"
TRCell():New(oNoAtend,"TIPONF"		,"cArqTRB","TIPONF"		,"@!"							,8							,/*lPixel*/,/*{|| cVend }*/ ) 
TRCell():New(oNoAtend,"FILIAL"		,"cArqTRB","Filial"		,PesqPict("SFT","FT_FILIAL")	,TamSx3("FT_FILIAL")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"DOC"			,"cArqTRB","Documento"	,PesqPict("SFT","FT_NFISCAL")	,TamSx3("FT_NFISCAL")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"SERIE"		,"cArqTRB","Serie"		,PesqPict("SFT","FT_SERIE")		,TamSx3("FT_SERIE")  	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CF"	 		,"cArqTRB","CF"			,PesqPict("SFT","FT_CFOP")		,TamSx3("FT_CFOP")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"dEmissao"	,		  ,"Emissao"	,                           	,TamSx3("FT_EMISSAO")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"dEntrada"	,         ,"Entrada"	,								,TamSx3("FT_EMISSAO")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"TES"			,"cArqTRB","TES"		,PesqPict("SD1","D1_TES")		,TamSx3("D1_TES")  		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CLI_FORN"	,"cArqTRB","CliFOR"		,PesqPict("SFT","FT_CLIEFOR")	,TamSx3("FT_CLIEFOR")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"LOJA"		,"cArqTRB","LJ"			,PesqPict("SFT","FT_LOJA")		,TamSx3("FT_LOJA")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"EST"			,"cArqTRB","EST"		,PesqPict("SFT","FT_ESTADO")	,TamSx3("FT_ESTADO")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"MUN"			,"cArqTRB","MUN"		,PesqPict("SA2","A2_MUN")		,TamSx3("A2_MUN")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CNPJ" 		,"cArqTRB","CNPJ"		,PesqPict("SA2","A2_CGC")		,TamSx3("A2_CGC")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"INSC"		,"cArqTRB","INSC"		,PesqPict("SA2","A2_INSCR")		,TamSx3("A2_INSCR")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"PROD"		,"cArqTRB","PROD"		,PesqPict("SFT","FT_PRODUTO")	,TamSx3("FT_PRODUTO")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"NCM"	  		,"cArqTRB","NCM"		,PesqPict("SFT","FT_POSIPI")	,TamSx3("FT_POSIPI")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"QTD"	  		,"cArqTRB","QTD"		,PesqPict("SD1","D1_QUANT")		,TamSx3("D1_QUANT")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VUNIT"		,"cArqTRB","VUNIT"		,PesqPict("SD1","D1_VUNIT")		,TamSx3("D1_VUNIT")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VCONT"		,"cArqTRB","VCONT"		,PesqPict("SFT","FT_VALCONT")	,TamSx3("FT_VALCONT")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"ALQ_ICM"		,"cArqTRB","ALQICM"		,PesqPict("SFT","FT_ALIQICM")	,TamSx3("FT_ALIQICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"BSICM"		,"cArqTRB","BSICM"		,PesqPict("SFT","FT_BASEICM")	,TamSx3("FT_BASEICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VICM"		,"cArqTRB","VICM"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"OUTICM"		,"cArqTRB","OUTICM"		,PesqPict("SFT","FT_OUTRICM")	,TamSx3("FT_OUTRICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"IS_ICM"		,"cArqTRB","ISICM"		,PesqPict("SFT","FT_ISENICM")	,TamSx3("FT_ISENICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"ALQ_IPI"		,"cArqTRB","ALQIPI"		,PesqPict("SFT","FT_ALIQICM")	,TamSx3("FT_ALIQICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"BSIPI"		,"cArqTRB","BSIPI"		,PesqPict("SFT","FT_BASEICM")	,TamSx3("FT_BASEICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VIPI"		,"cArqTRB","VIPI"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )//
TRCell():New(oNoAtend,"OUTIPI"		,"cArqTRB","OUTIPI"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"ISIPI"		,"cArqTRB","ISIPI"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"ICMST"		,"cArqTRB","ICMST"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"IRR"	 		,"cArqTRB","IRR"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"INSS"  		,"cArqTRB","INSS"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"COFINS" 		,"cArqTRB","COFINS"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"PIS" 			,"cArqTRB","PIS"		,PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )


TRCell():New(oNoAtend,"BASEPIS" 			,,"Base_Pis"		,	,TamSx3("FT_BASEICM")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"BASECONFIN" 			,,"Base_COFINS"	,	,TamSx3("FT_BASEICM")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VALORPIS" 			,,"Valor_Pis"		,	,TamSx3("FT_BASEICM")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VALORCONF" 			,,"Valor_Cofins"	,	,TamSx3("FT_BASEICM")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VALPIS" 				,,"Aliq_Pis"		,	,TamSx3("FT_BASEICM")[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VALCONF" 			,,"Aliq_Cofins"	,	,TamSx3("FT_BASEICM")[1] ,/*lPixel*/,/*{|| cVend }*/ )

TRCell():New(oNoAtend,"CSLL" 		,"cArqTRB","CSLL"		,	PesqPict("SFT","FT_VALICM")	,TamSx3("FT_VALICM")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"FRT"	  		,"cArqTRB","FRT"		,	PesqPict("SFT","FT_FRETE")		,TamSx3("FT_FRETE")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"SEG"	  		,"cArqTRB","SEG"		,	PesqPict("SFT","FT_SEGURO")	,TamSx3("FT_SEGURO")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"DESP"		,"cArqTRB","DESP"		,	PesqPict("SFT","FT_DESPESA")	,TamSx3("FT_DESPESA")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"ISS"	   		,"cArqTRB","ISS"		,	PesqPict("SD1","D1_VALISS")	,TamSx3("D1_VALISS")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"OBS"	  		,"cArqTRB","OBS"		,	PesqPict("SFT","FT_OBSERV")	,TamSx3("FT_OBSERV")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CTA"	  		,"cArqTRB","CTA"		,	PesqPict("SFT","FT_CONTA")		,TamSx3("FT_CONTA")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"DESCR"		,"cArqTRB","DESCR"	,	PesqPict("CT1","CT1_DESC01")	,TamSx3("CT1_DESC01")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Marco Bianchi          ³ Data ³ 26/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 31/10/12 ³ Lucas Oliveira³Alteração para criar relatório de log SC5   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,oNoAtend)

Local dEmissao := ctod("  /  /  ")
Local dEntrada := ctod("  /  /  ")
Local BASEPIS
Local BASECONFIN
Local VALORPIS
Local VALORCONF
Local VALPIS
Local VALCONF

cQry := ""
cQry += CRLF+"SELECT 'ENTRADA' AS TIPONF,FT_FILIAL FILIAL, FT_NFISCAL DOC, FT_SERIE SERIE, FT_CFOP CF, FT_EMISSAO EMIS,
cQry += CRLF+"FT_ENTRADA ENT, D1_TES TES, FT_CLIEFOR CLI_FORN, FT_LOJA LOJA, FT_ESTADO EST,
cQry += CRLF+"(CASE WHEN D1_TIPO = 'D' THEN SA1.A1_MUN ELSE A2_MUN END) MUN,
cQry += CRLF+"(CASE WHEN D1_TIPO = 'D' THEN SA1.A1_CGC ELSE A2_CGC END) CNPJ,
cQry += CRLF+"(CASE WHEN D1_TIPO = 'D' THEN SA1.A1_INSCR ELSE A2_INSCR END) INSC,  
cQry += CRLF+"FT_PRODUTO PROD, (CASE WHEN FT_POSIPI =' ' THEN 'SEM NCM' ELSE FT_POSIPI END) NCM, D1_QUANT QTD, D1_VUNIT VUNIT,
cQry += CRLF+"FT_VALCONT VCONT, FT_ALIQICM ALQ_ICM, FT_BASEICM BSICM, FT_VALICM VICM, FT_OUTRICM OUTICM, FT_ISENICM IS_ICM, 
cQry += CRLF+"FT_ALIQIPI ALQ_IPI, FT_BASEIPI BSIPI, FT_VALIPI VIPI, FT_OUTRIPI OUTIPI, FT_ISENIPI ISIPI, FT_ICMSRET ICMST,
cQry += CRLF+"D1_VALIRR IRR, D1_VALINS INSS, D1_VALCOF COFINS, D1_VALPIS PIS, 
cQry += CRLF+"FT_BASEPIS Base_Pis, FT_BASECOF Base_COFINS, FT_VALPIS Valor_Pis,FT_VALCOF Valor_Cofins,FT_ALIQPIS Aliq_Pis,FT_ALIQCOF Aliq_Cofins,
cQry += CRLF+"D1_VALCSL CSLL, 
cQry += CRLF+"FT_FRETE FRT, FT_SEGURO SEG, FT_DESPESA DESP, D1_VALISS ISS,FT_OBSERV OBS, FT_CONTA CTA, CT1_DESC01 DESCR
cQry += CRLF+"FROM SFT010 SFT
cQry += CRLF+"LEFT OUTER JOIN CT1010 CT1
cQry += CRLF+"ON SFT.FT_CONTA = CT1.CT1_CONTA
cQry += CRLF+"AND CT1.D_E_L_E_T_ = ' ', 
cQry += CRLF+"SD1010 SD1 
cQry += CRLF+"LEFT OUTER JOIN SA1010 SA1
cQry += CRLF+"ON SD1.D1_TIPO = 'D'
cQry += CRLF+"AND SD1.D1_FORNECE = SA1.A1_COD
cQry += CRLF+"AND SD1.D1_LOJA = SA1.A1_LOJA
cQry += CRLF+"AND SA1.D_E_L_E_T_ = ' '
cQry += CRLF+"LEFT OUTER JOIN SA2010 SA2
cQry += CRLF+"ON SD1.D1_TIPO <> 'D'
cQry += CRLF+"AND SD1.D1_FORNECE = SA2.A2_COD
cQry += CRLF+"AND SD1.D1_LOJA = SA2.A2_LOJA
cQry += CRLF+"AND SA2.D_E_L_E_T_ = ' '
cQry += CRLF+"WHERE SFT.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' 
cQry += CRLF+"AND SFT.FT_ENTRADA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"'
cQry += CRLF+"AND SFT.FT_TIPOMOV ='E'
cQry += CRLF+"AND SFT.FT_SERIE = SD1.D1_SERIE
cQry += CRLF+"AND SFT.FT_NFISCAL = SD1.D1_DOC
cQry += CRLF+"AND SFT.FT_CLIEFOR = SD1.D1_FORNECE
cQry += CRLF+"AND SFT.FT_LOJA = SD1.D1_LOJA
cQry += CRLF+"AND SFT.FT_ITEM = SD1.D1_ITEM
cQry += CRLF+"AND SFT.FT_PRODUTO = SD1.D1_COD
cQry += CRLF+"UNION
cQry += CRLF+"SELECT 'SAIDA' AS TIPONF,FT_FILIAL FILIAL, FT_NFISCAL DOC, FT_SERIE SERIE, FT_CFOP CF, FT_EMISSAO EMIS, FT_ENTRADA ENT,
cQry += CRLF+"D2_TES TES, FT_CLIEFOR CLI_FORN, FT_LOJA LOJA, FT_ESTADO EST, A1_MUN MUN, A1_CGC CNPJ, A1_INSCR INSC,
cQry += CRLF+"FT_PRODUTO PROD, (CASE WHEN FT_POSIPI =' ' THEN 'SEM NCM' ELSE FT_POSIPI END) NCM, D2_QUANT QTD, D2_PRCVEN VUNIT, 
cQry += CRLF+"FT_VALCONT VCONT, FT_ALIQICM ALQ_ICM, FT_BASEICM BSICM, FT_VALICM VICM, FT_OUTRICM OUTICM, FT_ISENICM IS_ICM, 
cQry += CRLF+"FT_ALIQIPI ALQ_IPI, FT_BASEIPI BSIPI, FT_VALIPI VIPI, FT_OUTRIPI OUTIPI, FT_ISENIPI ISIPI, FT_ICMSRET ICMST,
cQry += CRLF+"0 IRR, 0 INSS, 0 COFINS, 0 PIS, 
cQry += CRLF+"FT_BASEPIS Base_Pis, FT_BASECOF Base_COFINS, FT_VALPIS Valor_Pis,FT_VALCOF Valor_Cofins,FT_ALIQPIS Aliq_Pis,FT_ALIQCOF Aliq_Cofins,
cQry += CRLF+"0 CSLL,  
cQry += CRLF+"FT_FRETE FRT, FT_SEGURO SEG, FT_DESPESA DESP, D2_VALISS ISS, FT_OBSERV OBS, FT_CONTA CONTA, CT1_DESC01 DESCR
cQry += CRLF+"FROM SFT010 SFT
cQry += CRLF+"LEFT OUTER JOIN CT1010 CT1
cQry += CRLF+"ON SFT.FT_CONTA = CT1.CT1_CONTA
cQry += CRLF+"AND CT1.D_E_L_E_T_ = ' ', SD2010 SD2, SA1010 SA1
cQry += CRLF+"WHERE SFT.FT_TIPOMOV ='S'
cQry += CRLF+"AND SFT.FT_SERIE = SD2.D2_SERIE
cQry += CRLF+"AND SFT.FT_NFISCAL = SD2.D2_DOC
cQry += CRLF+"AND SFT.FT_CLIEFOR = SD2.D2_CLIENTE
cQry += CRLF+"AND SFT.FT_LOJA = SD2.D2_LOJA
cQry += CRLF+"AND SFT.FT_ITEM = SD2.D2_ITEM
cQry += CRLF+"AND SFT.FT_PRODUTO = SD2.D2_COD
cQry += CRLF+"AND SFT.FT_ENTRADA BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"'
cQry += CRLF+"AND SFT.D_E_L_E_T_ = ' '
cQry += CRLF+"AND SA1.D_E_L_E_T_ = ' '
cQry += CRLF+"AND SD2.D2_CLIENTE = SA1.A1_COD
cQry += CRLF+"AND SD2.D2_LOJA = SA1.A1_LOJA
cQry += CRLF+"AND SD2.D_E_L_E_T_ = ' '
cQry += CRLF+"ORDER BY TIPONF,ENT,DOC
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")

oReport:Section(1):Cell("dEmissao" ):SetBlock({|| dEmissao })
oReport:Section(1):Cell("dEntrada" ):SetBlock({|| dEntrada })


oReport:Section(1):Cell("BASEPIS" ):SetBlock({|| BASEPIS })
oReport:Section(1):Cell("BASECONFIN" ):SetBlock({|| BASECONFIN })
oReport:Section(1):Cell("VALORPIS" ):SetBlock({|| VALORPIS })
oReport:Section(1):Cell("VALORCONF" ):SetBlock({|| VALORCONF })
oReport:Section(1):Cell("VALPIS" ):SetBlock({|| VALPIS })
oReport:Section(1):Cell("VALCONF" ):SetBlock({|| VALCONF })
//FT_BASEPIS Base_Pis, FT_BASECOF Base_COFINS, FT_VALPIS Valor_Pis,FT_VALCOF Valor_Cofins,FT_ALIQPIS Aliq_Pis,FT_ALIQCOF Aliq_Cofins,
oReport:section(1):Init()
oReport:SetMeter(LastRec())
While cArqTRB->(!EOF())
	oReport:IncMeter()
	dEmissao	:= STOD(cArqTRB->EMIS)
	dEntrada	:= STOD(cArqTRB->ENT)
	BASEPIS:= cArqTRB->Base_Pis
	BASECONFIN:=cArqTRB-> Base_COFINS
	VALORPIS:=cArqTRB-> Valor_Pis
	VALORCONF:= cArqTRB->Valor_Cofins
	VALPIS:= cArqTRB->Aliq_Pis
	VALCONF:= cArqTRB->Aliq_Cofins
	oReport:section(1):PrintLine()
	
	
	dbskip()
EndDo
DbSelectArea("cArqTRB")

dbclosearea()                                                               	
oReport:Section(1):PageBreak()


Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Marco Bianchi          ³ Data ³10/11/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Acerta o arquivo de perguntas                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSx1()
Local aArea := GetArea()

PutSx1("SFTDeta","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("SFTDeta","02","Data até" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")

RestArea(aArea)

Return

