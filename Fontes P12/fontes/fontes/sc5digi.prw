#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SC5DIGI   ºAutor  ³Lucas di Oliveira   º Data ³  10/31/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório desenvolvido, para ADM ter o controle de lança   º±±
±±º          ³ mento dos pedidos                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SC5Digi()

Local oReport 


oReport := ReportDef()
oReport:PrintDialog()

Return


Static Function ReportDef()

Local oReport
Local oNoAtend
Local aFiles := {}
Local cEmailTrack
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario


oReport := TReport():New("C5digit","Usuário de digitação de pedidos","C5digit", {|oReport| ReportPrint(oReport,oNoAtend)},"")

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSx1()
Pergunte(oReport:uParam,.F.)

oNoAtend := TRSection():New(oReport,"DigitaPed",{"SC6","SC5","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNoAtend:SetTotalInLine(.F.)

//TRCell():New(oNoAtend,"CODPRO"		,"cArqTRB",RetTitle("ZD_CODPRO"),PesqPict("SZD","ZD_CODPRO")	,TamSx3("ZD_CODPRO")  	[1]	,/*lPixel*/,/*{|| cVend }*/	)// "Codigo do Cliente"
TRCell():New(oNoAtend,"PEDIDO"		 	,"cArqTRB","Pedido"		 		,PesqPict("SC6","C6_NUM")		,TamSx3("C6_NUM")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"EMISSAO"	   	 	,"cArqTRB","Emissão"			,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")	[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"CODCLI" 	   	 	,"cArqTRB","Código"				,PesqPict("SC6","C6_CLI")		,TamSx3("C6_CLI")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"LOJA"   	     	,"cArqTRB","Loja"	 			,PesqPict("SC6","C6_LOJA")		,TamSx3("C6_LOJA")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"RAZAOSOCIAL"		,"cArqTRB","Razão Social"		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"UF"			 	,"cArqTRB","UF"	  				,PesqPict("SA1","A1_EST")		,TamSx3("A1_EST")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"cLInc"			,	   	  ,"Log Inclusão"		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"cLAlt"			,		  ,"Log Alteração"		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)



cEmailTrack:= "ebuttner@ncgames.com.br;lfelipe@ncgames.com.br"
U_ENVIAEMAIL(cEmailTrack, ,,"RELATORIO DE ALTERAÇÃO PEDIDO","FOI GERADO O RELATORIO."+DTOS(DDATABASE)+"-"+TIME()+"-"+ALLTRIM(Upper(cUsername)), aFiles)

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

Local cLogInc := 0
Local cLogAlt:= 0
Local cLInc := ""
Local cLAlt := ""

//oReport:Section(1):Cell("cLInc" ):SetBlock({|| cLInc })
//oReport:Section(1):Cell("cLAlt" ):SetBlock({|| cLAlt })

cQry := ""
cQry += CRLF+"SELECT C5_NUM PEDIDO, SUBSTR(C5_EMISSAO,7,2)||'/'||substr(C5_EMISSAO,5,2)||'/'||substr(C5_EMISSAO,1,4) EMISSAO,
cQry += CRLF+"C5_CLIENTE CODCLI, C5_LOJAENT LOJA, A1_NOME RAZAOSOCIAL, A1_EST UF, C5_USERLGI LOGINCLUI, C5_USERLGA LOGALTER
cQry += CRLF+"FROM SC5010 SC5, SA1010 SA1
cQry += CRLF+"WHERE SC5.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' '
cQry += CRLF+"AND SC5.C5_CLIENTE = SA1.A1_COD
cQry += CRLF+"AND SC5.C5_LOJAENT = SA1.A1_LOJA
cQry += CRLF+"AND SC5.C5_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"'

cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")
oReport:Section(1):Cell("cLInc" ):SetBlock({|| cLInc })
oReport:Section(1):Cell("cLAlt" ):SetBlock({|| cLAlt })
oReport:section(1):Init()
oReport:SetMeter(LastRec())

While cArqTRB->(!EOF())
	oReport:IncMeter()
	cLogInc := Subs(Embaralha( LOGINCLUI, 1), 1, 15)
	cLInc 	:= AllTrim(UsrFullName(SubStr(cLogInc,3,6)))
	cLogAlt := Subs(Embaralha( LOGALTER, 1), 1, 15)
	cLAlt 	:= AllTrim(UsrFullName(SubStr(cLogAlt,3,6)))
	
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

PutSx1("C5digit","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("C5digit","02","Data até" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")

RestArea(aArea)

Return

