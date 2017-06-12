#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)

User Function TRNOATE()

Local oReport
oReport := ReportDef()
oReport:PrintDialog()
Return


Static Function ReportDef()

Local oReport
Local oNoAte
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario


oReport := TReport():New("TRNOATE","Pedidos Não Atendidos","TRNOATE", {|oReport| ReportPrint(oReport,oNoAte)},"")
//oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSx1()
Pergunte(oReport:uParam,.f.)

oNoAte := TRSection():New(oReport,"NaoAtendidos",{"SC6","SC5","SA1","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNoAte:SetTotalInLine(.F.)

//TRCell():New(oNoAte,"CODPRO" 		,"cArqTRB",RetTitle("ZD_CODPRO")		,PesqPict("SZD","ZD_CODPRO")   	,TamSx3("ZD_CODPRO")   	 		[1]	,/*lPixel*/,/*{|| cVend }*/ )		// "Codigo do Cliente"
TRCell():New(oNoAte,"PEDIDOFAT"	    ,"cArqTRB","Pedido Faturado")
TRCell():New(oNoAte,"CANAL" 		,"cArqTRB","Canal de Vendas"	   		,PesqPict("SC6","C6_FILIAL")	,TamSx3("C6_FILIAL")			[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"FILIAL" 		,"cArqTRB","Filial"				   		,PesqPict("SC6","C6_FILIAL")	,TamSx3("C6_FILIAL")			[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"PEDIDO"		,"cArqTRB","Pedido"				   		,PesqPict("SC6","C6_NUM")		,TamSx3("C6_NUM")				[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"EMISSAO"		,"cArqTRB","Emissão"					,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")			[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"NOTA" 	  		,"cArqTRB","Nota"	 					,PesqPict("C6","C6_NOTA")		,TamSx3("C6_NOTA")		   		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"CFOP"  		,"cArqTRB","CFOP"						,PesqPict("SC6","C6_CF")		,TamSx3("C6_CF")				[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"CODCLI" 		,"cArqTRB","Código"						,PesqPict("SC6","C6_CLI")		,TamSx3("C6_CLI")				[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"LOJA"   		,"cArqTRB","Loja"	 	   				,PesqPict("SC6","C6_LOJA")		,TamSx3("C6_LOJA")		 		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"RAZAOSOCIAL"	,"cArqTRB","Razão Social"				,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")				[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"UF"			,"cArqTRB","UF"	  						,PesqPict("SA1","A1_EST")		,TamSx3("A1_EST")				[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"PLATAFORMA"	,"cArqTRB","Plataforma"					,PesqPict("SB1","B1_PLATEXT")	,20									,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"SKU"			,"cArqTRB","Produto"					,PesqPict("SC6","C6_PRODUTO")	,TamSx3("C6_PRODUTO")			[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"DESCRICAO"		,"cArqTRB","Descrição"					,PesqPict("SB1","B1_XDESC")		,60	   			 			   		,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"QTDPEDIDO"		,"cArqTRB","Quant. Do Pedido"			,"@E 999,999,999"	            ,15									,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"QTDFATURADA"	,"cArqTRB","Quant. Faturada"	    	,"@E 999,999,999"	            ,15									,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"PRECOVENDA"	,"cArqTRB","Preço de Venda"				,PesqPict("SC6","C6_PRCVEN")	,TamSx3("C6_PRCVEN")			[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"NAOATENDIDO"	,"cArqTRB","Quant. Não Atendida"		,"@E 999,999,999"	            ,15									,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"RESIDUO"		,"cArqTRB","Resíduo"					,PesqPict("SC6","C6_BLQ")		,TamSx3("C6_BLQ")				[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAte,"NAOFATURADO"	,"cArqTRB","Total Não Faturado"			,"@E 999,999,999.99"	        ,20									,/*lPixel*/,/*{|| cVend }*/	)

// Alinhamento das colunas de valor a direita
oNoAte:Cell("QTDPEDIDO"):SetHeaderAlign("RIGHT")
oNoAte:Cell("QTDFATURADA"):SetHeaderAlign("RIGHT")
oNoAte:Cell("PRECOVENDA"):SetHeaderAlign("RIGHT")
oNoAte:Cell("NAOATENDIDO"):SetHeaderAlign("RIGHT")
oNoAte:Cell("NAOFATURADO"):SetHeaderAlign("RIGHT")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Lucas Felipe           ³ Data ³ 18/09/12 ³±±
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
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,oNoAte)

cQry := ""  
cQry += CRLF+"SELECT CASE WHEN PEDNOTA.NOTA IS NULL THEN 'NAO' ELSE 'SIM' END PEDIDOFAT , "
cQry += CRLF+"A1_YDCANAL CANAL, C6_FILIAL FILIAL, C6_NUM PEDIDO, C5_EMISSAO EMISSAO, C6_NOTA NOTA, C6_CF CFOP, C6_CLI CODCLI, C6_LOJA LOJA, A1_NOME RAZAOSOCIAL,"
cQry += CRLF+"A1_EST UF, B1_PLATEXT PLATAFORMA, C6_PRODUTO SKU, B1_XDESC DESCRICAO, C6_QTDVEN QTDPEDIDO, C6_QTDENT QTDFATURADA, C6_PRCVEN PRECOVENDA, "
cQry += CRLF+"C6_QTDVEN-C6_QTDENT NAOATENDIDO, C6_BLQ RESIDUO, (C6_QTDVEN-C6_QTDENT)*C6_PRCVEN NAOFATURADO  "
cQry += CRLF+"FROM SC6010 SC6, SC5010 SC5, SF4010 SF4, SA1010 SA1, SB1010 SB1, "
cQry += CRLF+"(SELECT DISTINCT(C6_NOTA) NOTA, C6_NUM PEDIDO "
cQry += CRLF+"FROM SC6010 SC6, SC5010 SC5, SF4010 SF4, SA1010 SA1, SB1010 SB1 "
cQry += CRLF+"WHERE SC6.D_E_L_E_T_ = ' ' AND SC5.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' ' "
cQry += CRLF+"AND SA1.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' "
cQry += CRLF+"AND SC6.C6_NUM = SC5.C5_NUM "
cQry += CRLF+"AND SC6.C6_FILIAL = SC5.C5_FILIAL "
cQry += CRLF+"AND SC6.C6_TES = SF4.F4_CODIGO "
cQry += CRLF+"AND SF4.F4_DUPLIC = 'S' "
cQry += CRLF+"AND SC5.C5_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' "
cQry += CRLF+"AND SC6.C6_CLI <> '000001' "
cQry += CRLF+"AND SC5.C5_TIPO = 'N' "
cQry += CRLF+"AND SC5.C5_LIBEROK <> ' ' "
cQry += CRLF+"AND SC5.C5_CLIENTE = SA1.A1_COD "
cQry += CRLF+"AND SC5.C5_LOJACLI = SA1.A1_LOJA "
cQry += CRLF+"AND SB1.B1_COD = SC6.C6_PRODUTO "
cQry += CRLF+"AND SC6.C6_FILIAL = '03' "
cQry += CRLF+"AND SB1.B1_FILIAL = ' ' "
cQry += CRLF+"AND SA1.A1_FILIAL = ' ' "
cQry += CRLF+"AND SC5.C5_FILIAL = '03' "
cQry += CRLF+"AND SC6.C6_NOTA <> ' ') PEDNOTA "
cQry += CRLF+"WHERE SC6.D_E_L_E_T_ = ' ' AND SC5.D_E_L_E_T_ = ' ' AND SF4.D_E_L_E_T_ = ' ' "
cQry += CRLF+"AND SA1.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' "
cQry += CRLF+"AND SC6.C6_NUM = SC5.C5_NUM "
cQry += CRLF+"AND SC6.C6_NUM = PEDNOTA.PEDIDO(+) "
cQry += CRLF+"AND SC6.C6_FILIAL = SC5.C5_FILIAL "
cQry += CRLF+"AND SC6.C6_TES = SF4.F4_CODIGO "
cQry += CRLF+"AND SF4.F4_DUPLIC = 'S' "
cQry += CRLF+"AND SC5.C5_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"' "
cQry += CRLF+"AND SC6.C6_CLI <> '000001' "
cQry += CRLF+"AND SC5.C5_TIPO = 'N' "
cQry += CRLF+"AND SC5.C5_LIBEROK <> ' ' "
cQry += CRLF+"AND SC5.C5_CLIENTE = SA1.A1_COD "
cQry += CRLF+"AND SC5.C5_LOJACLI = SA1.A1_LOJA "
cQry += CRLF+"AND SB1.B1_COD = SC6.C6_PRODUTO "
cQry += CRLF+"AND SC6.C6_FILIAL = '03' "
cQry += CRLF+"AND SB1.B1_FILIAL = ' ' "
cQry += CRLF+"AND SA1.A1_FILIAL = ' ' "
cQry += CRLF+"AND SC5.C5_FILIAL = '03' "
cQry += CRLF+"ORDER BY SC6.C6_FILIAL, SC6.C6_NUM "
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")    
oReport:section(1):Init()

oReport:SetMeter(LastRec())
While cArqTRB->(!EOF())
	
	oReport:IncMeter()
	
	oReport:section(1):PrintLine()
	
	dbSkip()
EndDo

DbSelectArea("cArqTRB")
dbclosearea()

oReport:Section(1):PageBreak()


Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Lucas Felipe           ³ Data ³18/09/2012³±±
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

PutSx1("TRNOATE","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("TRNOATE","02","Data até" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","") 

RestArea(aArea) 

Return 
