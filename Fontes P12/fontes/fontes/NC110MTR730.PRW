#INCLUDE "MATR730.CH" 
#INCLUDE "PROTHEUS.CH"
#INCLUDE "rptdef.ch"
Static _cArq :=""
Static nTotal:=0

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR730  ³ Autor ³ Marco Bianchi         ³ Data ³ 10/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT-R4                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function 110MTR730(aDados)
Local nInd
Local lJob

Private lPedidoWM:=FWIsInCallStack("U_WM001SEND") 
Private nRecnoZC5

Default aDados:={, , , .F.}

If aDados[4]
	RpcSetEnv(aDados[1],aDados[2])
	SC5->(DbGoTo(aDados[3]))
EndIf	

If lPedidoWM
	_cArq := "CONFIRMACAO_DO_PEDIDO_VENDA_"+SC5->C5_NUM
Else
	_cArq := "CONFIRMACAO_DO_PEDIDO_VENDA_A_VISTA_"+SC5->C5_NUM
EndIf	

	//-- Interface de impressao
oReport := ReportDef()
oReport:nDevice 			:= 6
oReport:PrintType 			:= 1
oReport:oReport:nDevice 	:= 6
oReport:oReport:PrintType 	:= 1
	
oReport:cPathPdf 			   := "\spool\"
oReport:oReport:cPathPdf 	:= "\spool\"

oReport:cFile 				   := _cArq
oReport:oReport:cFile 		:= _cArq

Ferase(oReport:cPathPdf+oReport:cFile+".pdf")
Ferase(GETTEMPPATH()+"totvsprinter\"+_cArq+".pdf" )

oReport:lPreview 		 := .f.
oReport:oReport:lPreview := .f.
oReport:oReport:SetPreview(.f.)
oReport:SetPreview(.f.)
oReport:lparampage:=.F.
oReport:Print(.f.,"",!lPedidoWM)     

cOrigem:= GETTEMPPATH()+"totvsprinter\"+_cArq+".pdf" 
cDestino:= "\spool\"	
CpyT2S ( cOrigem, cDestino)   	
//FErase(cOrigem)	
   


	
Return 
/*/

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 10/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(_cArq)

Local oReport
Local oPreNota
Local nValImp  	:= 0
Local nUltLib  	:= 0
Local aCabPed		:= {}
Local aItemPed  	:= {}
Local nItem 		:= 0
Local nTamData  	:= Len(DTOC(MsDate()))
Local lPedidoWM:=FWIsInCallStack("U_WM001SEND") 

Private aCodImps	:= {}
Private nI			:= 0
Private nTotQtd 	:= 0
Private nTotVal 	:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MTR730",STR0050,"MTR730", {|oReport| ReportPrint(oReport,oPreNota,@nItem,aItemPed,aCabPed)},STR0051 + " " + STR0052)	// "Emissao da Confirmacao do Pedido"###"Emissao da confirmacao dos pedidos de venda, de acordo com"###"intervalo informado na opcaoo Parametros."
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

If FWIsInCallStack("U_WM001SEND") 
	oReport:SetPreview(.F.)
EndIf	

Pergunte(oReport:uParam,.F.)

MV_PAR01 := SC5->C5_NUM
MV_PAR02 := SC5->C5_NUM


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao dos itens do Pedido de Vendas                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPreNota := TRSection():New(oReport,STR0108,{"SC5","SC6"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Emissao da Confirmacao do Pedido"
oPreNota:SetTotalInLine(.F.)
oPreNota:SetPreview(.F.)

TRCell():New(oPreNota,"AITEM01",/*Tabela*/,STR0053					 	,PesqPict("SC6","C6_ITEM"		),TamSx3("C6_ITEM"		)[1],/*lPixel*/,{|| aItemPed[nItem][01] 																	})	// "IT"
TRCell():New(oPreNota,"AITEM02",/*Tabela*/,RetTitle("C6_PRODUTO"	),PesqPict("SC6","C6_PRODUTO"	),TamSx3("C6_PRODUTO"	)[1],/*lPixel*/,{|| aItemPed[nItem][02] 																	})	// Codigo do Produto
If lPedidoWM
	TRCell():New(oPreNota,"AITEM23",/*Tabela*/,"Cod. WM",PesqPict("SC6","C6_PRODUTO"	),6,/*lPixel*/,{|| aItemPed[nItem][23] 																	})	// Codigo do Produto
EndIf	


TRCell():New(oPreNota,"AITEM03",/*Tabela*/,RetTitle("C6_DESCRI"	),PesqPict("SC6","C6_DESCRI"	),TamSx3("C6_DESCRI"	)[1],/*lPixel*/,{|| SUBSTR(IIF(Empty(aItemPed[nItem][03]),SB1->B1_DESC, aItemPed[nItem][03]),1,Iif(lPedidoWM,60,30) )						})	// Descricao do Produto
TRCell():New(oPreNota,"PLATAF",/*Tabela*/,"Plataforma",PesqPict("SB1","B1_PLATEXT"	),30 /*TamSx3("B1_PLATEXT")[1]*/,/*lPixel*/,{|| substr(aItemPed[nItem][21],1,20)						})										// Plataforma
If !lPedidoWM
	TRCell():New(oPreNota,"AITEM04",/*Tabela*/,STR0054					 	,PesqPict("SC6","C6_TES"		),TamSx3("C6_TES"		)[1],/*lPixel*/,{|| aItemPed[nItem][04] 																	})	// "TES"
EndIf
	
TRCell():New(oPreNota,"AITEM05",/*Tabela*/,STR0055					 	,PesqPict("SC6","C6_CF"		),TamSx3("C6_CF"		)[1],/*lPixel*/,{|| aItemPed[nItem][05] 																	})	// "CF"
TRCell():New(oPreNota,"AITEM06",/*Tabela*/,STR0056					 	,PesqPict("SC6","C6_UM"		),TamSx3("C6_UM"		)[1],/*lPixel*/,{|| aItemPed[nItem][06] 																	})	// "UM"

If lPedidoWM
	TRCell():New(oPreNota,"AITEM22",/*Tabela*/,"Solicitado"				 	,PesqPictQt("C6_QTDVEN"	    ),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][22] 																	})	// "Quant."
	TRCell():New(oPreNota,"AITEM07",/*Tabela*/,"Reservado"				 	,PesqPictQt("C6_QTDVEN"	    ),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][07] 																	})	// "Quant."	
	TRCell():New(oPreNota,"AITEM24",/*Tabela*/,RetTitle("C6_PRCTAB"	),"@E 99,999,999.99",TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][24] 																	})	// Preco Unitario	
Else
	TRCell():New(oPreNota,"AITEM07",/*Tabela*/,STR0057					 	,PesqPictQt("C6_QTDVEN"	    ),TamSx3("C6_QTDVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][07] 																	})	// "Quant."
EndIf	



TRCell():New(oPreNota,"AITEM08",/*Tabela*/,RetTitle("C6_PRCVEN"	),"@E 99,999,999.99",TamSx3("C6_PRCVEN"	)[1],/*lPixel*/,{|| aItemPed[nItem][08] 																	})	// Preco Unitario
If cPaisLoc == "BRA"
	TRCell():New(oPreNota,"NALIQIPI",/*Tabela*/	,"% IPI","@e 99.99"				,5,/*lPixel*/,{|| MaFisRet(nItem,"IT_ALIQIPI") 																											})	// "IPI"
	TRCell():New(oPreNota,"NALIQICM",/*Tabela*/	,STR0059,"@e 99.99"				,5,/*lPixel*/,{|| MaFisRet(nItem,"IT_ALIQICM") 																											})	// "ICM"
	If !lPedidoWM
		TRCell():New(oPreNota,"NALIQISS",/*Tabela*/	,STR0060,"@e 99.99"				,5,/*lPixel*/,{|| MaFisRet(nItem,"IT_ALIQISS") 																											})	// "ISS"
	EndIf	
Else
	TRCell():New(oPreNota,"NVALIMP"	,/*Tabela*/	,STR0058,Tm(nValImp,10,2)	,5,/*lPixel*/,{|| Tm(nValImp,10,2) 																														})	// "IPI"
EndIf
TRCell():New(oPreNota,"AITEM13",/*Tabela*/,STR0061						,PesqPict("SC6","C6_VALOR"		),TamSx3("C6_VALOR"		)[1],/*lPixel*/,{|| aItemPed[nItem][13]+nValImp 														})	// "Vl.Tot.C/IPI"
If !lPedidoWM
	TRCell():New(oPreNota,"AITEM14",/*Tabela*/,RetTitle("C6_ENTREG"	)	,PesqPict("SC6","C6_ENTREG"		),nTamData					,/*lPixel*/,{|| aItemPed[nItem][14] 																},,,,,,.F.)	// Data de Entrega
EndIf
	                                                            
If 	lPedidoWM
	TRCell():New(oPreNota,"AITEM15",/*Tabela*/,"Desconto"	,"@E 99,999,999.99",7,/*lPixel*/,{|| aItemPed[nItem][15] 																})	// % Desconto  
Else
	TRCell():New(oPreNota,"AITEM15",/*Tabela*/,RetTitle("C6_DESCONT")	,PesqPict("SC6","C6_DESCONT"	),TamSx3("C6_DESCONT"	)[1],/*lPixel*/,{|| aItemPed[nItem][15] 																})	// % Desconto  
EndIf	



If !lPedidoWM
	TRCell():New(oPreNota,"AITEM16",/*Tabela*/,STR0062						,PesqPict("SC6","C6_LOCAL"		),TamSx3("C6_LOCAL"		)[1],/*lPixel*/,{|| aItemPed[nItem][16] 																})	// "Loc."
	TRCell():New(oPreNota,"AITEM17",/*Tabela*/,STR0063						,PesqPictQt("C6_QTDLIB"		    ),TamSx3("C6_QTDLIB"	)[1],/*lPixel*/,{|| aItemPed[nItem][17] 												  				})	// "Qtd.a Fat."
	TRCell():New(oPreNota,"NSALDO" ,/*Tabela*/,STR0064						,PesqPictQt("C6_QTDLIB"		    ),TamSx3("C6_QTDLIB"	)[1],/*lPixel*/,{|| aItemPed[nItem][07]-aItemPed[nItem][17]+aItemPed[nItem][18]-aItemPed[nItem][19]	})	// "Saldo"
	TRCell():New(oPreNota,"NULTLIB",/*Tabela*/,STR0065						,PesqPictQt("D2_QUANT",10	    ),TamSx3("D2_QUANT"		)[1],/*lPixel*/,{|| nUltLib 																			})	// "Ult.Fat."  
EndIf	

TRCell():New(oPreNota,"VLRST" ,/*Tabela*/,"Vlr. ST"						,PesqPictQt("F2_ICMSRET"    ),TamSx3("F2_ICMSRET"	)[1],/*lPixel*/,{|| MaFisRet(nItem,"IT_VALSOL")	})							// "ICMS ST"
TRCell():New(oPreNota,"CST",/*Tabela*/,"CST"						,PesqPictQt("C6_CLASFIS" 				),TamSx3("C6_CLASFIS"		)[1],/*lPixel*/,{|| aItemPed[nItem][20] 																			})	// "CST"

TRFunction():New(oPreNota:Cell("AITEM07"),"AITEM07"/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,PesqPict("SC6","C6_QTDVEN",20),{|| nTotQtd }/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oPreNota:Cell("AITEM13"),"AITEM13"/* cID */,"ONPRINT",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nTotVal }/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao dos Impostos                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oImpostos := TRSection():New(oReport,STR0109,{"SC5","SC6","SD1","SB1","SD2","SA1","SA2","SA4","SE4","SA3","SX3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Emissao da Confirmacao do Pedido"
oImpostos:SetTotalInLine(.F.)
If cPaisLoc == "BRA"
	TRCell():New(oImpostos,"NF_BASEICM"	,/*Tabela*/,STR0087,PesqPict("SF2","F2_BASEICM"),TamSx3("F2_BASEICM")[1],/*lPixel*/,{|| MaFisRet(,"NF_BASEICM") 	})	// "Base Icms"
	TRCell():New(oImpostos,"NF_VALICM"	,/*Tabela*/,STR0088,PesqPict("SF2","F2_VALICM") ,TamSx3("F2_VALICM"	)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALICM"	) 	})	// "Valor Icms"
	TRCell():New(oImpostos,"NF_BASEIPI"	,/*Tabela*/,STR0089,PesqPict("SF2","F2_BASEIPI"),TamSx3("F2_BASEIPI")[1],/*lPixel*/,{|| MaFisRet(,"NF_BASEIPI") 	})	// "Base Ipi"
	TRCell():New(oImpostos,"NF_VALIPI"	,/*Tabela*/,STR0090,PesqPict("SF2","F2_VALIPI") ,TamSx3("F2_VALIPI"	)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALIPI"	) 	})	// "Valor Ipi"
	TRCell():New(oImpostos,"NF_BASESOL"	,/*Tabela*/,STR0091,PesqPict("SF2","F2_BRICMS") ,TamSx3("F2_BRICMS"	)[1],/*lPixel*/,{|| MaFisRet(,"NF_BASESOL") 	})	// "Base Retido"
	TRCell():New(oImpostos,"NF_VALSOL"	,/*Tabela*/,STR0092,PesqPict("SF2","F2_ICMSRET"),TamSx3("F2_ICMSRET")[1],/*lPixel*/,{|| MaFisRet(,"NF_VALSOL"	) 	})	// "Valor Retido"
	TRCell():New(oImpostos,"NF_TOTAL"	,/*Tabela*/,STR0093,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")[1],/*lPixel*/,{|| MaFisRet(,"NF_TOTAL"	) 	})	// "Valor Total"
	TRCell():New(oImpostos,"NF_BASEISS"	,/*Tabela*/,STR0094,PesqPict("SF2","F2_BASEISS"),TamSx3("F2_BASEISS")[1],/*lPixel*/,{|| MaFisRet(,"NF_BASEISS") 	})	// "Base Iss"
	TRCell():New(oImpostos,"NF_VALISS"	,/*Tabela*/,STR0095,PesqPict("SF2","F2_VALISS") ,TamSx3("F2_VALISS"	)[1],/*lPixel*/,{|| MaFisRet(,"NF_VALISS"	) 	})	// "Valor Iss"
Else
	TRCell():New(oImpostos,"aCodImps2"	,/*Tabela*/,STR0096,/*Picture*/			,13,/*lPixel*/,{|| aCodImps[nI][2]	})	// "Imposto"
	TRCell():New(oImpostos,"aCodImps3"	,/*Tabela*/,STR0097,"@E 99,999,999.99"	,13,/*lPixel*/,{|| aCodImps[nI][3]	})	// "Base"
	TRCell():New(oImpostos,"aCodImps4"	,/*Tabela*/,STR0098,"@E 99,999,999.99"	,13,/*lPixel*/,{|| aCodImps[nI][4]	})	// "Aliquota"
	TRCell():New(oImpostos,"aCodImps5"	,/*Tabela*/,STR0099,"@E 99,999,999.99"	,13,/*lPixel*/,{|| aCodImps[nI][5]	})	// "Valor"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Troca descricao do total dos itens                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetTotalText(STR0085)	// "T O T A I S "

TRPosition():New(oPreNota,"SC6",1,{|| xFilial("SC5") + aCabPed[07]+aItemPed[nItem][01]})
TRPosition():New(oPreNota,"SC5",1,{|| xFilial("SC6") + aCabPed[07]+aItemPed[nItem][01]})

oReport:Section(2):SetEdit(.F.) 
oReport:Section(1):SetUseQuery(.F.) // Novo compomente tReport para adcionar campos de usuario no relatorio qdo utiliza query

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alinhamento a direita as colunas de valor                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPreNota:Cell("AITEM07"):SetHeaderAlign("RIGHT")
oPreNota:Cell("AITEM08"):SetHeaderAlign("RIGHT")
If cPaisLoc == "BRA"
	oPreNota:Cell("NALIQIPI"):SetHeaderAlign("RIGHT")
	oPreNota:Cell("NALIQICM"):SetHeaderAlign("RIGHT")
	If !lPedidoWM
		oPreNota:Cell("NALIQISS"):SetHeaderAlign("RIGHT")
	EndIf	

	oImpostos:Cell("NF_BASEICM"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALICM"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_BASEIPI"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALIPI"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_BASESOL"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALSOL"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_TOTAL"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_BASEISS"):SetHeaderAlign("RIGHT")
	oImpostos:Cell("NF_VALISS"):SetHeaderAlign("RIGHT")

Else
	oPreNota:Cell("NVALIMP"):SetHeaderAlign("RIGHT")	

	oImpostos:Cell("aCodImps2"):SetHeaderAlign("RIGHT")	
	oImpostos:Cell("aCodImps3"):SetHeaderAlign("RIGHT")	
	oImpostos:Cell("aCodImps4"):SetHeaderAlign("RIGHT")	
	oImpostos:Cell("aCodImps5"):SetHeaderAlign("RIGHT")	
EndIf
oPreNota:Cell("AITEM13"):SetHeaderAlign("RIGHT")	
If !lPedidoWM	
	oPreNota:Cell("AITEM17"):SetHeaderAlign("RIGHT")	
	oPreNota:Cell("NSALDO"):SetHeaderAlign("RIGHT")	
	oPreNota:Cell("NULTLIB"):SetHeaderAlign("RIGHT")	              
EndIf	
oPreNota:Cell("VLRST"):SetHeaderAlign("RIGHT")	
oPreNota:Cell("CST"):SetHeaderAlign("RIGHT")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 10/07/06 ³±±
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
Static Function ReportPrint(oReport,oPreNota,nItem,aItemPed,aCabPed)

Local lQuery    := .F.
#IFNDEF TOP
	Local cCondicao := ""
#ENDIF

Local aPedCli    	:= {}
Local aC5Rodape  	:= {}
Local aRelImp    	:= MaFisRelImp("MT100",{"SF2","SD2"})
Local aFisGet    	:= Nil
Local aFisGetSC5 	:= Nil
Local cKey 	     	:= ""
Local cAliasSC5  	:= "SC5"
Local cAliasSC6  	:= "SC6"
Local cQryAd     	:= ""
Local cPedido    	:= ""
Local cCliEnt	 	:= ""
Local cNfOri     	:= Nil
Local cSeriOri   	:= Nil
Local nDesconto  	:= 0
Local nPesLiq    	:= 0
Local nRecnoSD1  	:= Nil
Local nG		 	:= 0
Local nFrete	 	:= 0
Local nSeguro	 	:= 0
Local nFretAut	 	:= 0
Local nDespesa	 	:= 0
Local nDescCab	 	:= 0
Local nPDesCab	 	:= 0
Local nY        	:= 0
Local nValMerc   	:= 0
Local nPrcLista  	:= 0
Local nAcresFin  	:= 0
Local nCont		 	:= 0
Local lPedidoWM		:=FWIsInCallStack("U_WM001SEND") 	    	    
Local cAddTable
Local lTemSC9
Local cProdWM
FisGetInit(@aFisGet,@aFisGetSC5)
SC9->(DbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	If TcSrvType() <> "AS/400"
	
		cQryAd := "%"
		For nY := 1 To Len(aFisGet)
			cQryAd += ","+aFisGet[nY][2]
		Next nY
		For nY := 1 To Len(aFisGetSC5)
			cQryAd += ","+aFisGetSC5[nY][2]
		Next nY		
		cAddTable:=""	
			
		If lPedidoWM
			cQryAd 	+= ",Nvl(SC9.R_E_C_N_O_,0) SC9REC "
			cAddTable:=","+RetSqlName("SC9")+" SC9"
		EndIf
		cAddTable:="%"+cAddTable+"%"
		
		cQryAd += "%"
	        
	    cFiltroSC6:=""
	    If lPedidoWM
			cFiltroSC6+="  AND SC9.C9_FILIAL(+)=SC6.C6_FILIAL "
			cFiltroSC6+="  And SC9.C9_PEDIDO(+)=SC6.C6_NUM"
			cFiltroSC6+="  And SC9.C9_ITEM(+)=SC6.C6_ITEM"
			cFiltroSC6+="  AND SC9.C9_PRODUTO(+)=SC6.C6_PRODUTO"
			cFiltroSC6+="  And SC9.D_E_L_E_T_(+)=SC6.D_E_L_E_T_
	    Else
			cFiltroSC6:=" AND SC6.C6_QTDRESE>0"
		Endif                     
		
		cFiltroSC6:="%"+cFiltroSC6+"%"	
		
		cAliasSC5:= cAliasSC6:= GetNextAlias()
		lQuery    := .T.
		
		oReport:Section(1):BeginQuery()
		BeginSql Alias cAliasSC5
		SELECT SC5.R_E_C_N_O_ SC5REC,SC6.R_E_C_N_O_ SC6REC,
		SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,
		SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_PBRUTO,SC5.C5_PESOL,SC5.C5_DESC1,
		SC5.C5_DESC2,SC5.C5_DESC3,SC5.C5_DESC4,SC5.C5_MENNOTA,SC5.C5_EMISSAO,
		SC5.C5_CONDPAG,SC5.C5_FRETE,SC5.C5_DESPESA,SC5.C5_FRETAUT,SC5.C5_TPFRETE,SC5.C5_SEGURO,SC5.C5_TABELA,
		SC5.C5_VOLUME1,SC5.C5_ESPECI1,SC5.C5_MOEDA,SC5.C5_REAJUST,SC5.C5_BANCO,
		SC5.C5_ACRSFIN,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,
		SC5.C5_COMIS1,SC5.C5_COMIS2,SC5.C5_COMIS3,SC5.C5_COMIS4,SC5.C5_COMIS5,SC5.C5_PDESCAB,SC5.C5_DESCONT,C5_INCISS,
		SC5.C5_CLIENT,
		SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PEDCLI,SC6.C6_PRODUTO,
		SC6.C6_TES,SC6.C6_CF,SC6.C6_QTDRESE C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,
		SC6.C6_PRCVEN*SC6.C6_QTDRESE  C6_VALOR,SC6.C6_ITEM,SC6.C6_DESCRI,SC6.C6_UM,
		SC6.C6_PRCVEN,SC6.C6_NOTA,SC6.C6_SERIE,SC6.C6_CLI,
		SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_DESCONT,SC6.C6_LOCAL,
		SC6.C6_QTDEMP,SC6.C6_QTDLIB,SC6.C6_QTDENT,SC6.C6_NFORI,SC6.C6_SERIORI,SC6.C6_ITEMORI,
		SC6.C6_CLASFIS,SB1.B1_PLATEXT,SC6.C6_QTDRESE,B1_XDESC,C6_PRCTAB
		%Exp:cQryAd%
		FROM %Table:SC5% SC5, %Table:SC6% SC6,%Table:SB1% SB1 
		%Exp:cAddTable%
		WHERE
		SC5.C5_FILIAL = %xFilial:SC5% AND
		SC5.C5_NUM >= %Exp:mv_par01% AND
		SC5.C5_NUM <= %Exp:mv_par02% AND
		SC5.%notdel% AND
		SC6.C6_FILIAL = %xFilial:SC6% AND
		SC6.C6_NUM   = SC5.C5_NUM AND                        
		SC6.%notdel% AND 
		SC6.C6_PRODUTO = SB1.B1_COD AND
		SB1.%notdel% 
		%Exp:cFiltroSC6%
		ORDER BY SC5.C5_NUM,SC6.C6_ITEM    
		EndSql
		oReport:section(1):endQuery()

	Else
#ENDIF	
	cAliasSC5 := "SC5"
	dbSelectArea(cAliasSC5)
	cKey := IndexKey()	
	cCondicao := 'C5_FILIAL == "'+xFilial("SC5")+'" .And. (C5_NUM >= "'+mv_par01+'" .And. C5_NUM <= "'+mv_par02+'")'
	oReport:Section(1):SetFilter(cCondicao,"",,cAliasSC5)	
	(cAliasSC5)->( dbGoTop() )
	
	#IFDEF TOP
	Endif
	#ENDIF	
	(cAliasSC5)->( dbEval( {|| nCont++ } ) )
	(cAliasSC5)->( dbGoTop() )
	oReport:SetMeter(nCont)		// Total de Elementos da regua

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !oReport:Cancel() .And. !((cAliasSC5)->(Eof())) .and. xFilial("SC5")==(cAliasSC5)->C5_FILIAL

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao dos filtros do usuario           	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSC5)

	cCliEnt := IIf(!Empty((cAliasSC5)->(FieldGet(FieldPos("C5_CLIENT")))),(cAliasSC5)->C5_CLIENT,(cAliasSC5)->C5_CLIENTE)
	aCabPed := {}

	MaFisIni(cCliEnt,;						// 1-Codigo Cliente/Fornecedor
		(cAliasSC5)->C5_LOJACLI,;			// 2-Loja do Cliente/Fornecedor
		If((cAliasSC5)->C5_TIPO$'DB',"F","C"),;	// 3-C:Cliente , F:Fornecedor
		(cAliasSC5)->C5_TIPO,;				// 4-Tipo da NF
		(cAliasSC5)->C5_TIPOCLI,;			// 5-Tipo do Cliente/Fornecedor
		aRelImp,;							// 6-Relacao de Impostos que suportados no arquivo
		,;						   			// 7-Tipo de complemento
		,;									// 8-Permite Incluir Impostos no Rodape .T./.F.
		"SB1",;								// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
		"MATA461")							// 10-Nome da rotina que esta utilizando a funcao
	//Na argentina o calculo de impostos depende da serie.
	If cPaisLoc == 'ARG'
		SA1->(DbSetOrder(1))
		SA1->(MsSeek(xFilial()+(cAliasSC5)->C5_CLIENTE+(cAliasSC5)->C5_LOJACLI))
		MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
	Endif

	nFrete		:= (cAliasSC5)->C5_FRETE
	nSeguro		:= (cAliasSC5)->C5_SEGURO
	nFretAut	:= (cAliasSC5)->C5_FRETAUT
	nDespesa	:= (cAliasSC5)->C5_DESPESA
	nDescCab	:= (cAliasSC5)->C5_DESCONT
	nPDesCab	:= (cAliasSC5)->C5_PDESCAB

	aItemPed:= {}
	aCabPed := {	(cAliasSC5)->C5_TIPO	,;
		(cAliasSC5)->C5_CLIENTE				,;
		(cAliasSC5)->C5_LOJACLI				,;
		(cAliasSC5)->C5_TRANSP				,;
		(cAliasSC5)->C5_CONDPAG				,;
		(cAliasSC5)->C5_EMISSAO				,;
		(cAliasSC5)->C5_NUM					,;
		(cAliasSC5)->C5_VEND1				,;
		(cAliasSC5)->C5_VEND2				,;
		(cAliasSC5)->C5_VEND3				,;
		(cAliasSC5)->C5_VEND4				,;
		(cAliasSC5)->C5_VEND5				,;
		(cAliasSC5)->C5_COMIS1				,;
		(cAliasSC5)->C5_COMIS2				,;
		(cAliasSC5)->C5_COMIS3				,;
		(cAliasSC5)->C5_COMIS4				,;
		(cAliasSC5)->C5_COMIS5				,;
		(cAliasSC5)->C5_FRETE				,;
		(cAliasSC5)->C5_TPFRETE				,;
		(cAliasSC5)->C5_SEGURO				,;
		(cAliasSC5)->C5_TABELA				,;
		(cAliasSC5)->C5_VOLUME1				,;
		(cAliasSC5)->C5_ESPECI1				,;
		(cAliasSC5)->C5_MOEDA				,;
		(cAliasSC5)->C5_REAJUST				,;
		(cAliasSC5)->C5_BANCO				,;
		(cAliasSC5)->C5_ACRSFIN				 ;
		}
	nTotQtd := 0
	nTotVal := 0
	nPesBru	:= 0
	nPesLiq	:= 0
	aPedCli	:= {}
	If !lQuery
		dbSelectArea(cAliasSC6)
		dbSetOrder(1)
		dbSeek(xFilial("SC6")+(cAliasSC5)->C5_NUM)
	EndIf
	cPedido    := (cAliasSC5)->C5_NUM
	aC5Rodape  := {}
	aadd(aC5Rodape,{(cAliasSC5)->C5_PBRUTO,(cAliasSC5)->C5_PESOL,(cAliasSC5)->C5_DESC1,(cAliasSC5)->C5_DESC2,;
		(cAliasSC5)->C5_DESC3,(cAliasSC5)->C5_DESC4,(cAliasSC5)->C5_MENNOTA})

	aPedCli := Mtr730Cli(cPedido)

	dbSelectArea(cAliasSC5)
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&(aFisGetSC5[ny][2]))
			If aFisGetSC5[ny][1] == "NF_SUFRAMA"
				MaFisAlt(aFisGetSC5[ny][1],Iif(&(aFisGetSC5[ny][2]) == "1",.T.,.F.),Len(aItemPed),.T.)		
			Else
				MaFisAlt(aFisGetSC5[ny][1],&(aFisGetSC5[ny][2]),Len(aItemPed),.T.)
			Endif	
		EndIf
	Next nY

	While !oReport:Cancel() .And. !((cAliasSC6)->(Eof())) .And. xFilial("SC6")==(cAliasSC6)->C6_FILIAL .And.;
			(cAliasSC6)->C6_NUM == cPedido
		lTemSC9:=.F.
		If lPedidoWM  
			If (cAliasSC6)->SC9REC>0
				lTemSC9:=.T.
				SC9->(DbGoTo( (cAliasSC6)->SC9REC ))
			EndIf	
		EndIf

		oReport:IncMeter()
	
		cNfOri     := Nil
		cSeriOri   := Nil
		nRecnoSD1  := Nil
		nDesconto  := 0

		If !Empty((cAliasSC6)->C6_NFORI)
			dbSelectArea("SD1")
			dbSetOrder(1)
			dbSeek(xFilial("SC6")+(cAliasSC6)->C6_NFORI+(cAliasSC6)->C6_SERIORI+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA+;
				(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_ITEMORI)
			cNfOri     := (cAliasSC6)->C6_NFORI
			cSeriOri   := (cAliasSC6)->C6_SERIORI
			nRecnoSD1  := SD1->(RECNO())
		EndIf
		dbSelectArea(cAliasSC6)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula o preco de lista                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTemSC9
			nValMerc  := SC9->(C9_PRCVEN*C9_QTDLIB)
			nQuantPV  := SC9->C9_QTDLIB
		Else
			nValMerc  := (cAliasSC6)->C6_VALOR			
			nQuantPV:=(cAliasSC6)->C6_QTDRESE
		EndIf	
		nPrcLista := (cAliasSC6)->C6_PRUNIT
		If ( nPrcLista == 0 )
			nPrcLista := NoRound(nValMerc/nQuantPV,TamSX3("C6_PRCVEN")[2])
		EndIf
		
		
		nAcresFin := A410Arred((cAliasSC6)->C6_PRCVEN*(cAliasSC5)->C5_ACRSFIN/100,"D2_PRCVEN")
		nValMerc  += A410Arred(nQuantPV*nAcresFin,"D2_TOTAL")		
		nDesconto := a410Arred(nPrcLista*nQuantPV,"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto==0,(cAliasSC6)->C6_VALDESC,nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresFin
		If cPaisLoc=="BRA"
			nValMerc  += nDesconto
		EndIf			
		
		MaFisAdd((cAliasSC6)->C6_PRODUTO	,;	// 1-Codigo do Produto ( Obrigatorio )
			(cAliasSC6)->C6_TES				,;	// 2-Codigo do TES ( Opcional )
			nQuantPV			,;	// 3-Quantidade ( Obrigatorio )
			nPrcLista						,;	// 4-Preco Unitario ( Obrigatorio )
			nDesconto						,;	// 5-Valor do Desconto ( Opcional )
			cNfOri							,;	// 6-Numero da NF Original ( Devolucao/Benef )
			cSeriOri						,;	// 7-Serie da NF Original ( Devolucao/Benef )
			nRecnoSD1						,;	// 8-RecNo da NF Original no arq SD1/SD2
			0								,;	// 9-Valor do Frete do Item ( Opcional )
			0								,;	// 10-Valor da Despesa do item ( Opcional )
			0								,;	// 11-Valor do Seguro do item ( Opcional )
			0								,;	// 12-Valor do Frete Autonomo ( Opcional )
			nValMerc						,;	// 13-Valor da Mercadoria ( Obrigatorio )
			0								,;	// 14-Valor da Embalagem ( Opiconal )
			0								,;	// 15-RecNo do SB1
			0								)	// 16-RecNo do SF4
	
		SC6->(DbGoTo( (cAliasSC6)->SC6REC ) )				
		

		cProdWM:=""
		cDescricao:=(cAliasSC6)->C6_DESCRI
		nValDesc  :=(cAliasSC6)->C6_DESCONT
		If lPedidoWM 
			If (nRecZC6:=U_WM001ZC6REC(SC6->C6_NUM,SC6->C6_PRODUTO))>0
				ZC6->(DbGoTo(nRecZC6))
				cProdWM:=AllTrim(ZC6->ZC6_IDPROD		)
			EndIf
			cDescricao:=(cAliasSC6)->B1_XDESC
			nValDesc:=(SC6->C6_PRCTAB-SC6->C6_PRCVEN)*nQuantPV			
		EndIf
		
		aadd(aItemPed,	{ ;
			(cAliasSC6)->C6_ITEM	,;
			(cAliasSC6)->C6_PRODUTO					,;
			cDescricao					,;
			(cAliasSC6)->C6_TES						,;
			(cAliasSC6)->C6_CF						,;
			(cAliasSC6)->C6_UM						,;
			nQuantPV					,;
			(cAliasSC6)->C6_PRCVEN					,;
			(cAliasSC6)->C6_NOTA					,;
			(cAliasSC6)->C6_SERIE					,;
			(cAliasSC6)->C6_CLI						,;
			(cAliasSC6)->C6_LOJA					,;
			nValMerc					,;
			(cAliasSC6)->C6_ENTREG					,;
			nValDesc					,;
			(cAliasSC6)->C6_LOCAL					,;
			(cAliasSC6)->C6_QTDEMP					,;
			(cAliasSC6)->C6_QTDLIB					,;
			(cAliasSC6)->C6_QTDENT					,; 
			(cAliasSC6)->C6_CLASFIS,;
			(cAliasSC6)->B1_PLATEXT,;
			SC6->C6_QTDVEN,;
			cProdWM,;
			SC6->C6_PRCTAB,;
			})							
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Forca os valores de impostos que foram informados no SC6.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		For nY := 1 to Len(aFisGet)
			If !Empty(&(aFisGet[ny][2]))
				MaFisAlt(aFisGet[ny][1],&(aFisGet[ny][2]),Len(aItemPed))
			EndIf
		Next nY

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calculo do ISS                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+(cAliasSC6)->C6_TES))
		If ( (cAliasSC5)->C5_INCISS == "N" .And. (cAliasSC5)->C5_TIPO == "N")
			If ( SF4->F4_ISS=="S" )
				nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
				nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
				MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
				MaFisAlt("IT_VALMERC",nValMerc,Len(aItemPed))
			EndIf
		EndIf	
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera peso para calcular frete              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(dbSetOrder(1))
		SB1->(MsSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))			
		MaFisAlt("IT_PESO",nQuantPV*SB1->B1_PESO,Len(aItemPed))
		MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
		MaFisAlt("IT_VALMERC",nValMerc,Len(aItemPed))
	
		aRetorno	:= U_NCGPR001( Len(aItemPed) )	
		//If Len(aRetorno)>0
		//	MaFisAlt( "IT_VALSOL",  aRetorno[2], ,Len(aItemPed) )
		//EndIf	
		
			
		If !lQuery
			dbSelectArea(cAliasSC6)
		EndIf

		(cAliasSC6)->(dbSkip())
	EndDo
	MaFisAlt("NF_FRETE"   ,nFrete)
	MaFisAlt("NF_SEGURO"  ,nSeguro)
	MaFisAlt("NF_AUTONOMO",nFretAut)
	MaFisAlt("NF_DESPESA" ,nDespesa)
	


	If nDescCab > 0
		MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nDescCab+MaFisRet(,"NF_DESCONTO")))
	EndIf
	If nPDesCab > 0
		MaFisAlt("NF_DESCONTO",A410Arred(MaFisRet(,"NF_VALMERC")*nPDesCab/100,"C6_VALOR")+MaFisRet(,"NF_DESCONTO"))
	EndIf

	ImpCabecR4(aPedCli,oReport,aCabPed)

	oReport:Section(1):Init()
	nItem := 0
	For nG := 1 To Len(aItemPed)
		nItem += 1
		If oReport:Row() > 1500
			oReport:Section(1):Finish()
			ImpRodapR4(nPesLiq,nPesBru,aC5Rodape,.F.,oReport)
			oReport:EndPage(.T.)
			oReport:Section(1):Init()
		 	ImpCabecR4(aPedCli,oReport,aCabPed)
		Endif
		ImpItemR4(nItem,@nPesLiq,@nPesBru,oReport,oPreNota,aCabPed,aItemPed)
	Next
	oReport:Section(1):Finish()
	ImpRodapR4(nPesLiq,nPesBru,aC5Rodape,.T.,oReport)
	oReport:EndPage(.T.)		// Finaliza pagina de impressao (zeras as linhas e colunas)

	nTotal:=MaFisRet(,"NF_TOTAL"	)
	MaFisEnd()

	If !lQuery
		dbSelectArea(cAliasSC5)
		dbSkip()
	Endif

EndDo


Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpCabecR4³ Autor ³ Marco Bianchi         ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpCabec(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCabecR4(aPedCli,oReport,aCabPed)

Local nPed		:= 0
Local i         := 0
Local cMoeda	:= ""
Local cPedCli   := ""
Local cPictCgc  := ""
Local oBox
Local nPrinLin  := 0
Local nInicio   := 20
Local lPedidoWM:=FWIsInCallStack("U_WM001SEND") 	    	     
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  array acabped                                              ³
//³  -------------                                              ³
//³  01 C5_TIPO           10 C5_VEND3     	19 C5_TPFRETE       ³
//³  02 C5_CLIENTE        11 C5_VEND4     	20 C5_SEGURO        ³
//³  03 C5_LOJACLI        12 C5_VEND5     	21 C5_TABELA        ³
//³  04 C5_TRANSP         13 C5_COMIS1    	22 C5_VOLUME1       ³
//³  05 C5_CONDPAG        14 C5_COMIS2    	23 C5_ESPECI1       ³
//³  06 C5_EMISSAO        15 C5_COMIS3    	24 C5_MOEDA         ³
//³  07 C5_NUM            16 C5_COMIS4    	25 C5_REAJUST       ³
//³  08 C5_VEND1          17 C5_COMIS5    	26 C5_BANCO         ³
//³  09 C5_VEND2          18 C5_FRETE     	27 C5_ACRSFIN       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona registro no cliente do pedido                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF !(aCabPed[1]$"DB")   //C5_TIPO
	dbSelectArea("SA1")
	dbSeek(xFilial("SA1")+aCabped[2]+aCabped[3])  //C5_CLIENTE + C5_LOJACLI
	cPictCgc := PesqPict("SA1","A1_CGC")	
Else
	dbSelectArea("SA2")
	dbSeek(xFilial("SA2")+aCabPed[2]+aCabPed[3])  // C5_CLIENTE + C5_LOJACLI
	cPictCgc := PesqPict("SA2","A2_CGC")	
Endif

dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xFilial("SA4")+aCabPed[4])	   				// C5_TRANSP
dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(xFilial("SE4")+aCabPed[5])	  				// C5_CONDPAG
aSort(aPedCli)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa impressao do cabecalho                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:HideHeader()			// Nao imprime cabecalho padrao do Protheus
oReport:SkipLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desenha as caixas do cabecalho                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Box(20,10,200,750,oBox)
oReport:Box(20,750,200,1800,oBox)
oReport:Box(20,1800,200,3000,oBox)

IF !(aCabPed[1]$"DB")		//C5_TIPO
   nPrinLin := nInicio
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes do Quadro 1: Dados da Empresa                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:PrintText("",nPrinLin,10)
	oReport:PrintText(SM0->M0_NOME,nPrinLin,20)
	nPrinLin += 30
	oReport:PrintText(SM0->M0_ENDCOB,nPrinLin,20)
	nPrinLin += 30
	oReport:PrintText(STR0067+SM0->M0_TEL,nPrinLin,20)	// "TEL: "
	nPrinLin += 30
	oReport:PrintText(Iif(cPaisLoc=="BRA",STR0071,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")+;	// "CGC: "
						Transform(SM0->M0_CGC,cPictCgc)+ " " +Subs(SM0->M0_CIDCOB,1,15),nPrinLin,20)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes do Quadro 2: Dados do Cliente                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   nPrinLin := nInicio
	oReport:PrintText(SA1->A1_COD+"/"+SA1->A1_LOJA+" "+SA1->A1_NOME,nPrinLin,760)	
	nPrinLin += 30
	
	cEndSA1:=IF( !Empty(SA1->A1_ENDENT).And. SA1->A1_ENDENT # SA1->A1_END,SA1->A1_ENDENT, SA1->A1_END )
  	cCepSA1:=IF( !Empty(SA1->A1_CEPE)  .And. SA1->A1_CEPE # SA1->A1_CEP,SA1->A1_CEPE, SA1->A1_CEP )
  	cMumSA1:=IF( !Empty(SA1->A1_MUNE)  .And. SA1->A1_MUNE # SA1->A1_MUN,SA1->A1_MUNE, SA1->A1_MUN )
  	cEstSA1:=IF( !Empty(SA1->A1_ESTE)  .And. SA1->A1_ESTE # SA1->A1_EST,SA1->A1_ESTE, SA1->A1_EST )
  	cBairSA1:=""
                         
  	If Posicione("SC5",1,xFilial("SC5")+aCabPed[7],"C5_XECOMER")=="C" 
		U_COM05EndEnt(aCabPed[7],@cEndSA1,@cBairSA1,@cCepSA1,@cMumSA1,@cEstSA1)  	
  	Endif
  	
  		
	oReport:PrintText(cEndSA1,nPrinLin,760)
	nPrinLin += 30
	oReport:PrintText(cCepSA1+" "+cMumSA1+" "+cEstSA1,nPrinLin,760)
	nPrinLin += 30
	oReport:PrintText(subs(transform(SA1->A1_CGC,PicPesFJ(RetPessoa(SA1->A1_CGC))),1,at("%",transform(SA1->A1_CGC,PicPes(RetPessoa(SA1->A1_CGC))))-1),nPrinLin,760)
	If cPaisLoc == "BRA"	
		oReport:PrintText(STR0069+SA1->A1_INSCR,nPrinLin,1050)		// "IE: "
	Endif
	If AllTrim(SC5->C5_YORIGEM)=="WM" .And. (nRecnoZC5:=U_WM001ZC5REC(SC5->C5_NUM))>0
       ZC5->(DbGoTo(nRecnoZC5))
	   nPrinLin += 30                  	   
	   oReport:PrintText("NR. LOJA "+AllTrim(SA1->A1_YCODWM),nPrinLin,760)			// "PEDIDO N. "   
   EndIf

	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes do Quadro 3: Dados do Pedido                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   nPrinLin := nInicio
   oReport:PrintText(IIf(lPedidoWM,"","VENDA A VISTA -" )+" CONFIRMACAO DO PEDIDO",nPrinLin,1810)							// 
	nPrinLin += 60
	oReport:PrintText(STR0068+DTOC(aCabPed[6]),nPrinLin,1810)		// "EMISSAO: "
	nPrinLin += 30
	oReport:PrintText(STR0070+aCabPed[7],nPrinLin,1810)			// "PEDIDO N. "
   If AllTrim(SC5->C5_YORIGEM)=="WM" .And. (nRecnoZC5:=U_WM001ZC5REC(SC5->C5_NUM))>0
       ZC5->(DbGoTo(nRecnoZC5))
	   nPrinLin += 30                  	   
	   oReport:PrintText("NR. PEDIDO "+AllTrim(Str(ZC5->ZC5_NUM)),nPrinLin,1810)			// "PEDIDO N. "   
   EndIf
   
	
Else

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes do Quadro 1: Dados da Empresa                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   nPrinLin := nInicio
   
	oReport:PrintText(SM0->M0_NOME,nPrinLin,20)
	nPrinLin += 30
	oReport:PrintText(SM0->M0_ENDCOB,nPrinLin,20)
	nPrinLin += 30
	oReport:PrintText(STR0067+SM0->M0_TEL,nPrinLin,20)														// "TEL: "
	nPrinLin += 30
	oReport:PrintText(Iif(cPaisLoc=="BRA",STR0071,Alltrim(Posicione('SX3',2,'A1_CGC','SX3->X3_TITULO'))+":")+;	// "CGC: "
						Transform(SM0->M0_CGC,cPictCgc)+ " " +Subs(SM0->M0_CIDCOB,1,15),nPrinLin,20)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes do Quadro 2: Dados do Cliente                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPrinLin := nInicio
	oReport:PrintText(SA2->A2_COD+"/"+SA2->A2_LOJA+" "+SA2->A2_NOME,nPrinLin,760)	
	nPrinLin += 30
	oReport:PrintText(SA2->A2_END,nPrinLin,760)
	nPrinLin += 30
	oReport:PrintText(SA2->A2_CEP + " " + SA2->A2_MUN + " " + SA2->A2_EST,nPrinLin,760)
	nPrinLin += 30
	oReport:PrintText(subs(transform(SA2->A2_CGC,PicPesFJ(RetPessoa(SA2->A2_CGC))),1,at("%",transform(SA2->A2_CGC,PicPes(RetPessoa(SA2->A2_CGC))))-1),nPrinLin,760)
	nPrinLin += 30
	If cPaisLoc == "BRA"	
		oReport:PrintText(STR0069+SA2->A2_INSCR,nPrinLin,1050)		// "IE: "
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Informacoes do Quadro 3: Dados do Pedido                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPrinLin := nInicio
	//oReport:PrintText("VENDA A VISTA - CONFIRMACAO DO PEDIDO",nPrinLin,1810)							// "CONFIRMACAO DO PEDIDO"
	 oReport:PrintText(IIf(lPedidoWM,"","VENDA A VISTA -" )+" CONFIRMACAO DO PEDIDO",nPrinLin,1810)							// 
	nPrinLin += 60
	oReport:PrintText(STR0068+DTOC(aCabPed[6]),nPrinLin,1810)		// "EMISSAO: "
	nPrinLin += 30
	oReport:PrintText(STR0070+aCabPed[7],nPrinLin,1810)			// "PEDIDO N. "

Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pedidos do Cliente                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine(6)
If Len(aPedCli) > 0
	oReport:PrintText("PEDIDO(S) DO CLIENTE: ",oReport:Row(),20)
	cPedCli:=""
	For nPed := 1 To Len(aPedCli)
		cPedCli += aPedCli[nPed]+Space(02)
		If Len(cPedCli) > 100 .or. nPed == Len(aPedCli)
			oReport:PrintText(cPedCli,oReport:Row(),350)
			cPedCli:=""
 		   oReport:SkipLine(2)
		Endif
	Next
	oReport:Line(oReport:Row(),10,oReport:Row()+5,3000)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transportadora                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine()
oReport:PrintText(STR0072+aCabPed[4]+" - "+AllTrim(SA4->A4_NOME)+IIf(lPedidoWM,"-(Previsto)",""),oReport:Row(),20)		// "TRANSP...: "		//C5_TRANSP

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vendedores                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine()
For i := 8 to 12
	dbSelectArea("SA3")
	dbSetOrder(1)
	If dbSeek(xFilial("SA3")+aCabPed[i])														// C5_VENDi
		If i == 8
			oReport:PrintText(STR0073,oReport:Row(),20)										// "VENDEDOR.: "
			If !lPedidoWM
				oReport:PrintText(STR0074,oReport:Row(),1000)										// "COMISSAO: "
			EndIf	
		EndIf
		oReport:PrintText(aCabPed[i] + " - "+SA3->A3_NOME,oReport:Row(),300)
		oReport:PrintText(Transform(aCabPed[i+5],"99.99"),oReport:Row(),1150)
		oReport:SkipLine()
	EndIf	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condicao de Pagto, Frete e Seguro                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText(STR0075+aCabPed[5]+" - "+SE4->E4_DESCRI,oReport:Row(),20)					// "COND.PGTO: "		//C5_CONDPAG
oReport:PrintText(STR0076,oReport:Row(),1000)													// "FRETE...: "
oReport:PrintText(Transform(aCabPed[18],"@EZ 999,999,999.99"),oReport:Row(),1050)				// C5_FRETE
oReport:PrintText(IIF(aCabPed[19]="C","(CIF)","(FOB)"),oReport:Row(),1300)					// C5_TPFRETE
oReport:PrintText(STR0077,oReport:Row(),2000)													// "SEGURO: "
oReport:PrintText(Transform(aCabPed[20],"@EZ 999,999,999.99"),oReport:Row(),2050)				// C5_SEGURO
oReport:SkipLine()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tabela, Volume e Especie                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText(STR0078+aCabPed[21],oReport:Row(),20)										// "TABELA...: "	// C5_TABELA
oReport:PrintText(STR0079+Transform(aCabPed[22],"@EZ 999,999"),oReport:Row(),1000)				// "VOLUMES.: "		// C5_VOLUME1s
oReport:PrintText(STR0080+aCabPed[23],oReport:Row(),2000) 										// "ESPECIE: "		// C5_ESPECIE1
oReport:SkipLine()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Reajuste, Moeda, Banco e Acrescimo Financeiro               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMoeda:=Strzero(aCabPed[24],1,0)																// C5_MOEDA
oReport:PrintText(STR0081+aCabPed[25]+STR0082 +IIF(cMoeda < "2","1",cMoeda),oReport:Row(),20)	// "REAJUSTE.: "###"   Moeda : " 	//C5_REAJUST
oReport:PrintText(STR0083 + aCabPed[26],oReport:Row(),1000)				   					// "BANCO: "		//C5_BANCO
oReport:PrintText(STR0084 + Str(aCabPed[27],6,2),oReport:Row(),2000)							// "ACRES.FIN.: "	//C5_ACRSFIN
oReport:SkipLine()
oReport:Line(oReport:Row(),10,oReport:Row()+5,3000)

Return( .T. )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpItemR4³ Autor ³ Marco Bianchi         ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpItem(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpItemR4(nItem,nPesLiq,nPesBru,oReport,oPreNota,aCabPed,aItemPed)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  array aitemped                                             ³
//³  --------------                                             ³
//³  01 c6_item           08 c6_prcven         15 c6_descont    ³
//³  02 c6_produto        09 c6_nota           16 c6_local      ³
//³  03 c6_descri         10 c6_serie          17 c6_qtdemp     ³
//³  04 c6_tes            11 c6_cli            18 c6_qtdlib     ³
//³  05 c6_cf             12 c6_loja           19 c6_qtdent     ³
//³  06 c6_um             13 c6_valor                           ³
//³  07 c6_qtdven         14 c6_entreg                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cChaveD2	:= ""
Local nDecs	    := MsDecimais(Max(1,aCabPed[24]))  //C5_MOEDA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser                   ³
//³ utilizadas em outras funcoes nao precisando declara-las                ³
//³ como private.                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc <> "BRA"
	oReport:Section(1):Cell("NVALIMP"):SetBlock({|| nValImp})
Else	
	oReport:Section(1):Cell("AITEM13"):SetBlock({|| aItemPed[nItem][13]+nValImp})
EndIf
If !lPedidoWM
	oReport:Section(1):Cell("NULTLIB"):SetBlock({|| nUltLib})
EndIf	
nValImp := 0
nUltLib := 0
If cPaisLoc == "BRA"
	If aCabPed[1] == "P"
		nValImp := 0
	Else
		nValImp	:=	MaFisRet(nItem,"IT_VALIPI")
	Endif
Else
	nValImp	:=	MaRetIncIV(nItem,"2")
Endif

dbSelectArea("SB1")
dbSeek(xFilial("SB1")+aItemPed[nItem][2])  //C6_PRODUTO

//c6_nota c6_serie c6_cli c6_loja c6_produto
cChaveD2 := xFilial("SD2")+aItemPed[nItem][09]+aItemPed[nItem][10]+aItemPed[nItem][11]+aItemPed[nItem][12]+aItemPed[nItem][02]
dbSelectArea("SD2")
dbSetOrder(3)
dbSeek(cChaveD2)
While !Eof() .and. cChaveD2 = xFilial("SD2")+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD
	nUltLib := D2_QUANT
	dbSkip()
EndDo

oReport:Section(1):PrintLine()

nTotQtd += aItemPed[nItem][07]						//C6_QTDVEN
nTotVal += aItemPed[nItem][13]+nValImp				//C6_VALOR
nPesLiq	+= SB1->B1_PESO * aItemPed[nItem][07]		//C6_QTDVEN
nPesBru += SB1->B1_PESBRU * aItemPed[nItem][07]	//C6_QTDVEN

Return (Nil)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpRodapR4³ Autor ³ Marco Bianchi         ³ Data ³ 11/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpRoadpe(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRodapR4(nPesLiq,nPesBru,aC5Rodape,lFinal,oReport)

Local I     := 0
DEFAULT lFinal := .F.

If lFinal

	oReport:SkipLine()
	oReport:Line(oReport:Row(),10,oReport:Row(),3000)

	If cPaisLoc == 'BRA'
		oReport:SkipLine()
		oReport:PrintText(SubStr(STR0038,1,15))
		oReport:Section(2):Init()
		oReport:Section(2):PrintLine()
		oReport:Section(2):Finish()
	Else
		aCodImps	:=	{}
		aCodImps := MaFisRet(,"NF_IMPOSTOS") //Descricao / /Aliquota / Valor / Base
		oReport:Section(2):Init()
		For I:=1 To Len(aCodImps)// Vetor com os impostos
			nI := I
			oReport:Section(2):PrintLine()
		Next
		oReport:Section(2):Finish()
	Endif
Endif	

oReport:SkipLine()
oReport:PrintText(STR0100+STR(If(aC5Rodape[1][1] > 0,aC5Rodape[1][1],nPesBru)),1880,30)	// "PESO BRUTO ------>"
oReport:PrintText(STR0101+STR(If(aC5Rodape[1][2] > 0,aC5Rodape[1][2],nPesLiq)),1910,30)	// "PESO LIQUIDO ---->"
oReport:PrintText(STR0102,1940,30)															// "VOLUMES --------->"
oReport:PrintText(STR0103,1970,30)															// "SEPARADO POR ---->"
oReport:PrintText(STR0104,2000,30)															// "CONFERIDO POR --->"
oReport:PrintText(STR0105,2030,30)															// "D A T A --------->"

oReport:PrintText(STR0106,2090,30)															// "DESCONTOS: "
oReport:PrintText(Transform(aC5Rodape[1][3],"99.99"),2090,200)
oReport:PrintText(Transform(aC5Rodape[1][4],"99.99"),2090,300)
oReport:PrintText(Transform(aC5Rodape[1][5],"99.99"),2090,400)
oReport:PrintText(Transform(aC5Rodape[1][6],"99.99"),2090,500)

oReport:PrintText(STR0107+AllTrim(aC5Rodape[1][7]),2150,30)								// "MENSAGEM PARA NOTA FISCAL: "

Return( NIL )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FisGetInit³ Autor ³Eduardo Riera          ³ Data ³17.11.2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Inicializa as variaveis utilizadas no Programa              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FisGetInit(aFisGet,aFisGetSC5)

Local cValid      := ""
Local cReferencia := ""
Local nPosIni     := 0
Local nLen        := 0

If aFisGet == Nil
	aFisGet	:= {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SC6")
	While !Eof().And.X3_ARQUIVO=="SC6"
		cValid := UPPER(X3_VALID+X3_VLDUSER)
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		dbSkip()
	EndDo
	aSort(aFisGet,,,{|x,y| x[3]<y[3]})
EndIf

If aFisGetSC5 == Nil
	aFisGetSC5	:= {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SC5")
	While !Eof().And.X3_ARQUIVO=="SC5"
		cValid := UPPER(X3_VALID+X3_VLDUSER)
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		dbSkip()
	EndDo
	aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})
EndIf
MaFisEnd()
Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Mtr730Cli ³ Autor ³ Henry Fila            ³ Data ³ 26.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Função que retorna os pedidos do cliente                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Mtr730Cli(cPedido)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1: Numero do pedido                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mtr730Cli(cPedido)

Local aPedidos := {}
Local aArea    := GetArea()
Local aAreaSC6 := SC6->(GetArea())

SC6->(dbSetOrder(1))
SC6->(MsSeek(xFilial("SC6")+cPedido))

While !(SC6->(Eof())) .And. xFilial("SC6")==SC6->C6_FILIAL .And.;
		SC6->C6_NUM == cPedido

	If !Empty(SC6->C6_PEDCLI) .and. Ascan(aPedidos,SC6->C6_PEDCLI) = 0
		Aadd(aPedidos, SC6->C6_PEDCLI )
	Endif		

	SC6->(dbSkip())
Enddo

RestArea(aAreaSC6)
RestArea(aArea)

Return(aPedidos)
User Function NC110GetArq()
Return _cArq 
             
User Function NC110Total()
Return nTotal 


//User Function XFISLF()
//Local nItem:=ParamIxb[1]
//aRetorno	:= U_NCGPR001( Len(nItem) )	
//MaFisAlt( "IT_BASESOL", aRetorno[1], ,nItem )
//MaFisAlt( "IT_VALSOL",  aRetorno[2], ,nItem )

Return 
