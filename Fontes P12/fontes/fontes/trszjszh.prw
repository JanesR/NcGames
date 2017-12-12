#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TRSZJSZH  ºAutor  ³Lucas Oliveira      º Data ³  11/28/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório para tabela de preço intermediaria.              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TRSZJSZH()

Local oReport


oReport := ReportDef()
oReport:PrintDialog()

Return


Static Function ReportDef()

Local oReport
Local oNoAtend
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario


oReport := TReport():New("TRSZJSZH","Tabela de Preço Intermediaria","TRSZJSZH", {|oReport| ReportPrint(oReport,oNoAtend)},"")

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSx1()
Pergunte(oReport:uParam,.t.)

oNoAtend := TRSection():New(oReport,"TabPreIn",{"SZH","SZJ","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNoAtend:SetTotalInLine(.F.)

//TRCell():New(oNoAtend,"CODPRO"		,"cArqTRB",RetTitle("ZD_CODPRO"),PesqPict("SZD","ZD_CODPRO")	,TamSx3("ZD_CODPRO")  	[1]	,/*lPixel*/,/*{|| cVend }*/	)// "Codigo do Cliente"
TRCell():New(oNoAtend,"COD_TABELA"	 	,"cArqTRB","Num Tabela"		 	,PesqPict("SZJ","ZJ_CODIGO")	,TamSx3("ZJ_CODIGO")	[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"DATA_PROGRAM" 	,"cArqTRB","Data Programada"	,PesqPict("SZJ","ZJ_DTPROG")	,TamSx3("ZJ_DTPROG")	[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"ITEM" 	   		,"cArqTRB","Item"				,PesqPict("SZH","ZH_ITEM")		,TamSx3("ZH_ITEM")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"PRODUTO"   	   	,"cArqTRB","Código"	 			,PesqPict("SZH","ZH_PRODUTO")	,15							,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"DESCRICAO"		,"cArqTRB","Descrição"			,PesqPict("SZH","ZH_XDESC")		,60							,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"CUSTO"			,"cArqTRB","Custo"	  			,PesqPict("SZH","ZH_CM1")		,TamSx3("ZH_CM1")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"MARKUP_0"		,"cArqTRB","Markup 0"			,PesqPict("SZH","ZH_MKUP00")	,TamSx3("ZH_MKUP00")	[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"PRECO_0"			,"cArqTRB","Preço 0"	  		,PesqPict("SZH","ZH_PRV0")		,TamSx3("ZH_PRV0")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"PRECO_18"		,"cArqTRB","Preço 18"	  		,PesqPict("SZH","ZH_PRV0")		,TamSx3("ZH_PRV0")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"PRECO_12"		,"cArqTRB","Preço 12"	  		,PesqPict("SZH","ZH_PRV0")		,TamSx3("ZH_PRV0")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"PRECO_7"			,"cArqTRB","Preço 07"	  		,PesqPict("SZH","ZH_PRV0")		,TamSx3("ZH_PRV0")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"cUser"			,		  ,"Usuário"			,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)

// Alinhamento das colunas de valor a direita
oNoAtend:Cell("PRECO_0"):SetHeaderAlign("RIGHT")
oNoAtend:Cell("PRECO_18"):SetHeaderAlign("RIGHT")
oNoAtend:Cell("PRECO_12"):SetHeaderAlign("RIGHT")
oNoAtend:Cell("PRECO_7"):SetHeaderAlign("RIGHT")
oNoAtend:Cell("CUSTO"):SetHeaderAlign("RIGHT")

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

Local cUser := ""

cQry := ""
cQry += CRLF+"SELECT ZJ_CODIGO COD_TABELA, ZJ_CODUSR USUARIO, SUBSTR(ZJ_DTPROG,7,2)||'/'||substr(ZJ_DTPROG,5,2)||'/'||substr(ZJ_DTPROG,1,4) DATA_PROGRAM, 
cQry += CRLF+"ZH_ITEM ITEM, ZH_PRODUTO PRODUTO, ZH_XDESC DESCRICAO, ZH_CM1 CUSTO, ZH_PRV0 PRECO_0, ZH_MKUP00 MARKUP_0, ZH_PRECO18 PRECO_18, ZH_PRECO12 PRECO_12, ZH_PRECO07 PRECO_7
cQry += CRLF+"FROM SZJ010 SZJ, SZH010 SZH
cQry += CRLF+"WHERE SZJ.D_E_L_E_T_ = ' ' AND SZH.D_E_L_E_T_ = ' '
cQry += CRLF+"AND SZJ.ZJ_CODIGO = SZH.ZH_CODIGO
cQry += CRLF+"AND SZJ.ZJ_STATUS = '1'
cQry += CRLF+"AND SZJ.ZJ_DTPROG BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"'
cQry += CRLF+"AND SZJ.ZJ_CODIGO >= '"+MV_PAR03+"'
cQry += CRLF+"AND SZJ.ZJ_CODIGO <= '"+MV_PAR04+"'

cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")
oReport:Section(1):Cell("cUser" ):SetBlock({|| cUser })

oReport:section(1):Init()
oReport:SetMeter(LastRec())

While cArqTRB->(!EOF())
	oReport:IncMeter()      
	cUser 	:= AllTrim(UsrFullName(USUARIO))
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

PutSx1("TRSZJSZH","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("TRSZJSZH","02","Data até" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSx1("TRSZJSZH","03","Da Tabela?" ,"","","mv_ch3","C",6,0,,"G","","","","","mv_par03","","","","","","","","","","","","","","","","")
PutSx1("TRSZJSZH","04","Até Tabela?" ,"","","mv_ch4","C",6,0,,"G","","","","","mv_par04","","","","","","","","","","","","","","","","")

RestArea(aArea)

Return

