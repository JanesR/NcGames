#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZRINC18	     ºAutor  ³Alfredo A. MagalhãesºData  ³ 18/05/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do relatorio de Inconsistencias de pedidos			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                     	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 				  		 `	   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 			                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function KZRINC18(lManut)
	
	Local clPerg	:= "KZRINC"
	Local oReport	:= Nil
	Default	lManut	:= .F.
	
	If lManut
		clPerg := "KZR2INC"
	EndIf
	AjustaSx1(clPerg,lManut)
	
	If Pergunte(clPerg)
		oReport := ReportDef(clPerg,lManut)
		oReport :PrintDialog()	
	EndIf
	
Return

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³ReportDef		 ºAutor  ³Alfredo A. Magalhãesº Data ³ 22/05/2012  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de Inconsistencias de Pedidos		 TReport  		   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³clPerg														   º±±  
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   | 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(clPerg,lManut)
	Local oReport
	Local oSection
	
	oReport := TReport():New(OEMTOANSI("Inconsistencias de Pedidos"),OEMTOANSI("Relatório de Inconsistencias de Pedidos"),clPerg,{|oReport| PrintReport(oReport,lManut)},OEMTOANSI("Relatorio de Inconsistencias de Pedidos"))
	oReport:SetLandscape()
	oSection := TRSection():New(oReport ,"",{"CANBF"})
Return oReport
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³PrintReport	 ºAutor  ³Alfredo A. Magalhãesº Data ³ 22/05/2012  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de Inconsistencias de Pedidos		 TReport  		   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³SigaFin                                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport														   º±±  
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   | 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport,lManut)

	Local oSection	:= oReport:Section(1)
	Local oSection1	:= oReport:Section(1):Section(1)
	Local oSection2	:= oReport:Section(1):Section(2)
	Local oSection3 := oReport:Section(1):Section(3)
	Local oSection4	:= oReport:Section(1):Section(4)
	Local oSection5	:= oReport:Section(1):Section(5)
	Local oSection6 := oReport:Section(1):Section(6)
	Local oSection7	:= oReport:Section(1):Section(7)
	Local oSection8	:= oReport:Section(1):Section(8)
	Local oSection9	:= oReport:Section(1):Section(9)
	Local oBreak
	Local clQuery	:= ""
    Local alDesc	:= {}
    Local alIncon	:= {}
    Local aArea		:= GetArea()
    Local clTipo	:= ""
    Local clTabPrc	:= ""
    Local clTransp	:= ""
    Local clCndPag	:= ""
    Local clNomVnd	:= ""
    Local clAuxItm	:= ""
    Local nlPos		:= 0
    Local clCGC		:= ""
    Local clIncon	:= ""
    Local clTes		:= ""
    Local cltpOpr	:= ""
    Local nlBIpiC	:= 0
    Local nlValIpi	:= 0
    Local nlBIpiT	:= 0
    Local nlValIpiT	:= 0
    Local nlValDes	:= 0
    Local nlTNC		:= 0
    Local nlTCLI	:= 0
    Local nlBNC		:= 0
    Local nlValNC	:= 0
    Local nlPesB	:= 0
    Local nlPesL	:= 0
    Local nlDscNC	:= 0
	Local nlTQuant	:= 0
	Local nx 		:= 0
	Local nPerIcm	:= 0
	Local nValIcm	:= 0

    
	//Pega a descrição do combo box do campo A1_TIPO
	SX3->(dbSetOrder(2))
	SX3->(DbSeek("A1_TIPO"))
	alDesc := Separa(SX3->X3_CBOX,";")
	For nx:= 1 to Len(alDesc)
		alDesc[nx] := Separa(alDesc[nx] ,"=")
	Next nx
	dbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	If SX5->(DbSeek(xFilial("SX5")+"ZC"))
		While SX5->(!EoF()) .And. SX5->X5_TABELA == "ZC"
			If Val(SX5->X5_CHAVE) <= 11
				AADD(alIncon,{SX5->X5_CHAVE,SX5->X5_DESCRI})
			EndIf
			SX5->(dbSkip())
		EndDo
	EndIf
	
	
	RestArea(aArea)
	dbSelectArea("SE4")   
	//Query	
	clQuery	:= " SELECT * " + CRLF
	clQuery	+= " FROM( " + CRLF
	clQuery	+= "	SELECT 	A1_COD, " + CRLF
	clQuery	+= " 			A1_LOJA, " + CRLF
	clQuery	+= " 			A1_TIPO, " + CRLF
	clQuery	+= " 			A1_NOME, " + CRLF
	clQuery	+= " 			A1_ENDCOB, " + CRLF
	clQuery	+= " 			A1_CEPC, " + CRLF
	clQuery	+= " 			A1_MUNC, " + CRLF
	clQuery	+= " 			A1_ESTC, " + CRLF
	clQuery	+= " 			A1_CGC, " + CRLF
	clQuery	+= " 			A1_INSCR, " + CRLF
	clQuery	+= " 			A1_TEL, " + CRLF
	clQuery	+= " 			A1_ENDENT, " + CRLF
	clQuery	+= " 			A1_CEPE, " + CRLF
	clQuery	+= " 			A1_MUNE, " + CRLF
	clQuery	+= " 			A1_ESTE, " + CRLF
	clQuery	+= " 			A1_TABELA " + CRLF
	clQuery	+= " 	FROM " + RETSQLNAME("SA1") + CRLF
	clQuery	+= " 	WHERE	D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 			AND A1_FILIAL = '" + xFilial("SA1")+ "' " + CRLF
	If lManut
		clQuery	+= " 			AND A1_COD = '" + M->ZAE_CLIFAT + "' " + CRLF
		clQuery	+= " 			AND A1_LOJA = '" + M->ZAE_LJFAT + "' " + CRLF		
	Else
		clQuery	+= " 			AND A1_COD BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' " + CRLF
		clQuery	+= " 			AND A1_LOJA BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' " + CRLF
	EndIf
	clQuery	+= " )SA1 " + CRLF
	clQuery	+= " INNER JOIN ( " + CRLF
	clQuery	+= " 			SELECT	ZAE_FILIAL, " + CRLF
	clQuery	+= " 					ZAE_NUMEDI, " + CRLF
	clQuery	+= " 					ZAE_DTIMP, " + CRLF
	clQuery	+= " 					ZAE_DTENTR, " + CRLF
	clQuery	+= " 					ZAE_CONDPA, " + CRLF
	clQuery	+= " 					ZAE_TABPRC, " + CRLF
	clQuery	+= " 					CASE " + CRLF
	clQuery	+= " 						WHEN ZAE_TPFRET = 'C' THEN 'CIF' " + CRLF
	clQuery	+= " 						WHEN ZAE_TPFRET = 'F' THEN 'FOB' " + CRLF
	clQuery	+= " 					END AS ZAE_TPFRET," + CRLF
	clQuery	+= " 					ZAE_TRANSP, " + CRLF
	clQuery	+= " 					ZAE_CLIFAT, " + CRLF
	clQuery	+= " 					ZAE_LJFAT, " + CRLF
	clQuery	+= " 					ZAE_VEND, " + CRLF
	clQuery	+= " 					ZAE_TPNGRD, " + CRLF
	clQuery	+= " 					ZAE_OBSNF, " + CRLF
	clQuery	+= " 					ZAE_TOTFRT " + CRLF
	clQuery	+= " 			FROM " + RETSQLNAME("ZAE") + CRLF
	clQuery	+= " 			WHERE	D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 					AND ZAE_FILIAL = '" + xFilial("ZAE") + "' " + CRLF
	clQuery	+= " 					AND (ZAE_STATUS = '2' OR ZAE_STATUS = '4') " + CRLF
	If lManut
		clQuery	+= " 					AND ZAE_NUMEDI = '" + M->ZAE_NUMEDI + "' " + CRLF
	Else
		clQuery	+= " 					AND ZAE_DTIMP BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02)+ "' " + CRLF
		clQuery	+= " 					AND ZAE_NUMEDI BETWEEN '" + Mv_Par03 + "' AND '" + Mv_Par04 + "' " + CRLF
		clQuery	+= " 					AND ZAE_VEND BETWEEN '" + Mv_Par09 + "' AND '" + Mv_Par10 + "' " + CRLF
	EndIf
	clQuery	+= " ) ZAE ON ZAE.ZAE_CLIFAT = SA1.A1_COD AND ZAE.ZAE_LJFAT = SA1.A1_LOJA" + CRLF
	
	clQuery := ChangeQuery(clQuery)
	
	If Select("CABNF") > 0
		CABNF->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "CABNF", .F., .F. )
	
	oReport:SetMeter( CABNF->(LastRec() ))
	
	//SEÇÃO DOS DADOS DO CLIENTE
	TRCell():New(oSection,"CLIENTE"			,		,OEMTOANSI("Cliente"				),PesqPict("SA1","A1_COD")		,(TamSx3("A1_COD")[1]+TamSx3("A1_LOJA")[1]+TamSx3("A1_NOME")[1])+10	,/*lPixel*/,/*{||  }*/						)		// "Codigo+loja+nome do Cliente"
	TRCell():New(oSection,"TIPOCLI"			,		,OEMTOANSI("Tipo do Cliente"		),"@!"							,20																		,/*lPixel*/,/*{||  }*/						)		// "Tipo do Cliente"
	
	//DADOS DE FATURAMENTO
	oSection1 := TRSection():New(oSection,"",{""})
	
	TRCell():New(oSection1,"DADOS"			,		,OEMTOANSI(""						),"@!"							,25																		,/*lPixel*/,/*{||  }*/						)		// "Tipo dos dados Dados"
	TRCell():New(oSection1,"END"			,		,OEMTOANSI("Endereço"				),PesqPict("SA1","A1_ENDCOB")	,TamSx3("A1_ENDCOB")[1]													,/*lPixel*/,/*{||  }*/						)		// "Endereço do Cliente"
	TRCell():New(oSection1,"CEP"			,		,OEMTOANSI("CEP"					),PesqPict("SA1","A1_CEPC")		,TamSx3("A1_CEPC")[1]													,/*lPixel*/,/*{||  }*/						)		// "CEP do Cliente"	
	TRCell():New(oSection1,"CIT"			,		,OEMTOANSI("Cidade"					),PesqPict("SA1","A1_MUNC")		,TamSx3("A1_MUNC")[1]													,/*lPixel*/,/*{||  }*/						)		// "Cidade do Cliente"
	TRCell():New(oSection1,"EST"			,		,OEMTOANSI("UF"						),PesqPict("SA1","A1_ESTC")		,TamSx3("A1_ESTC")[1]													,/*lPixel*/,/*{||  }*/						)		// "Estado do Cliente"	
	TRCell():New(oSection1,"CPF"			,		,OEMTOANSI("CNPJ"					),""							,25																		,/*lPixel*/,/*{||  }*/						)		// "CNPJ do Cliente"	
	TRCell():New(oSection1,"IE"				,		,OEMTOANSI("I.E."					),PesqPict("SA1","A1_INSCR")	,TamSx3("A1_INSCR")[1]													,/*lPixel*/,/*{||  }*/						)		// "I.E do Cliente"			
	TRCell():New(oSection1,"TEL"			,		,OEMTOANSI("Fone:"					),PesqPict("SA1","A1_TEL")		,TamSx3("A1_TEL")[1]													,/*lPixel*/,/*{||  }*/						)		// "Telefone do Cliente"

	//VENDEDOR	
	TRCell():New(oSection1,"VEND"			,		,OEMTOANSI("Vendedor"				),PesqPict("SA3","A3_COD")		,(TamSx3("A3_COD")[1]+TamSx3("A3_NOME")[1])+10							,/*lPixel*/,/*{||  }*/						)		// "Codigo+nome do Vendedor"
	oSection1:Cell("VEND"):SetLineBreak()
	
	//OBS. DO CLIENTE
	
	oSection3 := TRSection():New(oSection,"",{""})
	//DADOS DO PEDIDO
	TRCell():New(oSection3,"TIPPED"			,		,OEMTOANSI(""						),"@!"							,15																		,/*lPixel*/,/*{||  }*/						)		// "Tipo do Pedido"	
	TRCell():New(oSection3,"NUMPED"			,		,OEMTOANSI("Nº Pedido"				),PesqPict("SC5","C5_NUM")		,TamSx3("C5_NUM")[1]													,/*lPixel*/,/*{||  }*/						)		// "Numero do pedido"
	TRCell():New(oSection3,"EMISSAO"		,		,OEMTOANSI("Dt. Emissão"			),PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")[1]												,/*lPixel*/,/*{||  }*/						)		// "Data Emissao"
	TRCell():New(oSection3,"ENTREG"			,		,OEMTOANSI("Dt. Entrega"			),PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")[1]												,/*lPixel*/,/*{||  }*/						)		// "Data Entrega"
	TRCell():New(oSection3,"CONDPG"			,		,OEMTOANSI("Cond. Pag"				),PesqPict("SE4","E4_DESCRI")	,TamSx3("E4_DESCRI")[1]													,/*lPixel*/,/*{||  }*/						)		// "Condição de Pagamento"
	TRCell():New(oSection3,"TABPRC"			,		,OEMTOANSI("Tab. Preco"				),PesqPict("DA0","DA0_COD")		,TamSx3("DA0_CODTAB")[1]												,/*lPixel*/,/*{||  }*/						)		// "tabela de Preco"
	TRCell():New(oSection3,"FRETE"			,		,OEMTOANSI("Frete"					),"@!"							,3																		,/*lPixel*/,/*{||  }*/						)		// "FRETE"
	TRCell():New(oSection3,"VALFRT"			,		,OEMTOANSI("Valor Frete"			),PesqPict("SC5","C5_FRETE")	,TamSx3("C5_FRETE")[1]													,/*lPixel*/,/*{||  }*/						)		// "Preco do frete"	
	TRCell():New(oSection3,"TRANSP"			,		,OEMTOANSI("Transportadora"			),PesqPict("SA4","A4_COD")		,(TamSx3("A4_COD")[1]+TamSx3("A4_COD")[1]+5)							,/*lPixel*/,/*{||  }*/						)		// "Transportadora"	
	
	oSection3:Cell("VALFRT"):SetHeaderAlign("RIGHT")
	oSection3:Cell("TRANSP"):SetLineBreak()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Quebra a pagina												 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	oBreak := TRBreak():New(oSection,{||CABNF->ZAE_NUMEDI},"Nº Pedido") //Calcula o total por cliente.   
	oBreak:SetPageBreak(.T.)

	If Iif(lManut,Mv_Par01 == 1,Mv_Par11 == 1) //Analitico
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Altera o Titulo do Relatorio de acordo com o Tipo escolhido  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:SetTitle(oReport:Title() + " - Analítico")
		
		oSection4 := TRSection():New(oSection,"",{""})
		//DADOS DOS ITENS
		TRCell():New(oSection4,"DESCITM"		,		,OEMTOANSI(""						),"@!"							,12																	,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODITEM"		,		,OEMTOANSI("Item "					),"9999"						,TamSx3("ZAF_ITEM")[1]+3												,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODPRO"			,		,OEMTOANSI("Cod.Prod."				),PesqPict("SB1","B1_COD")		,TamSx3("B1_COD")[1]+10												,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODEAN"			,		,OEMTOANSI("Cod.EAN"					),PesqPict("ZAF","ZAF_EAN")		,TamSx3("ZAF_EAN")[1]+13													,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"DESCPRD"		,		,OEMTOANSI("Descri. NC"					),PesqPict("SB1","B1_DESC")		,/*TamSx3("B1_DESC")[1]*/44													,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODTES"			,		,OEMTOANSI("TES"					),PesqPict("SF4","F4_CODIGO")	,TamSx3("B1_TS")[1]											   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CFOP"			,		,OEMTOANSI("CFOP"					),PesqPict("SF4","F4_CF")		,TamSx3("F4_CF")[1]											   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODEMB"			,		,OEMTOANSI("EMB."					),PesqPict("SB1","B1_UM")		,TamSx3("B1_UM")[1]											   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"QUANT"			,		,OEMTOANSI("Quant."					),PesqPict("SC6","C6_QTDVEN")	,TamSx3("C6_QTDVEN")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"VALUNT"			,		,OEMTOANSI("Vlr.Unit."				),PesqPict("SB1","B1_PRV1")		,TamSx3("B1_PRV1")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"PRCIPI"			,		,OEMTOANSI("%IPI"					),PesqPict("SB1","B1_IPI")		,TamSx3("B1_IPI")[1]							  			   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"PRCCIPI"		,		,OEMTOANSI("VlUnit+IPI"				),PesqPict("SC6","C6_VALOR")	,TamSx3("B1_IPI")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"TOTCIPI"		,		,OEMTOANSI("Vl.Tot+IPI"				),PesqPict("SC6","C6_VALOR")	,TamSx3("B1_IPI")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"DTENTR"			,		,OEMTOANSI("Dt.Entrega"				),PesqPict("SC6","C6_ENTREG")	,TamSx3("C6_ENTREG")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"DESCONT"		,		,OEMTOANSI("%Desc."					),"99.99"						,5															   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"VALDESC"		,		,OEMTOANSI("Vlr.Desc"				),PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"LOCPAD"			,		,OEMTOANSI("Local"					),PesqPict("SB1","B1_LOCPAD")	,TamSx3("B1_LOCPAD")[1]										   			,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODNCM"			,		,OEMTOANSI("NCM"					),"@!"/*PesqPict("SB1","B1_POSIPI")*/	,TamSx3("B1_POSIPI")[1]											   		,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"VALST"			,		,OEMTOANSI("Vlr.St"					),PesqPict("SC6","C6_VALOR")	, TamSx3("ZAF_VLRICM")[1]									,.T./*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"CODCST"			,		,OEMTOANSI("CST"					),PesqPict("SF4","F4_CSTPIS")	,TamSx3("F4_CSTPIS")[1]											   		,.T./*lPixel*/,/*{||  }*/						)

		oSection4:Cell("QUANT"):SetHeaderAlign("RIGHT")
		oSection4:Cell("VALUNT"):SetHeaderAlign("RIGHT")
		oSection4:Cell("PRCIPI"):SetHeaderAlign("RIGHT")
		oSection4:Cell("PRCCIPI"):SetHeaderAlign("RIGHT")
		oSection4:Cell("TOTCIPI"):SetHeaderAlign("RIGHT")
		oSection4:Cell("VALDESC"):SetHeaderAlign("RIGHT")
		oSection4:Cell("VALST"):SetHeaderAlign("RIGHT")

		oSection5 := TRSection():New(oSection,"",{""})
		
		TRCell():New(oSection5,"DESCTOT"		,		,OEMTOANSI(""						),"@!"							,20																		,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection5,"QNTTOT"			,		,OEMTOANSI("Quant."					),PesqPict("SC6","C6_QTDVEN")	,TamSx3("C6_QTDVEN")[1]										   			,/*lPixel*/,/*{||  }*/						)		
		TRCell():New(oSection5,"TOTCIPI"		,		,OEMTOANSI("Vlr.Tot c/IPI"			),PesqPict("SC6","C6_VALOR")	,TamSx3("B1_IPI")[1]										   			,/*lPixel*/,/*{||  }*/						)

		oSection5:Cell("QNTTOT"):SetHeaderAlign("RIGHT")
		oSection5:Cell("TOTCIPI"):SetHeaderAlign("RIGHT")
		//IMPOSTOS
		oSection6 := TRSection():New(oSection,"",{""})
		TRCell():New(oSection6,"TIPIMP"			,		,OEMTOANSI("Impostos"				),"@!"							,20																		,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection6,"BASIPI"			,		,OEMTOANSI("Base IPI"				),PesqPict("SD2","D2_BASEIPI")	,TamSx3("D2_BASEIPI")[1]												,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection6,"VALIPI"			,		,OEMTOANSI("Valor IPI"				),PesqPict("SD2","D2_VALIPI")	,TamSx3("D2_VALIPI")[1]													,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection6,"VALTOT"			,		,OEMTOANSI("Valor Total"			),PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]													,/*lPixel*/,/*{||  }*/						)
		
		oSection6:Cell("BASIPI"):SetHeaderAlign("RIGHT")
		oSection6:Cell("VALIPI"):SetHeaderAlign("RIGHT")
		oSection6:Cell("VALTOT"):SetHeaderAlign("RIGHT")
		
		oSection7 := TRSection():New(oSection,"",{""})
		TRCell():New(oSection7,"TIPPES"			,		,OEMTOANSI(""						),"@!"							,20																		,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection7,"VALPES"			,		,OEMTOANSI(""						),PesqPict("SB1","B1_PESO")		,TamSx3("B1_PESO")[1]													,/*lPixel*/,/*{||  }*/						)
		
		oSection7:Cell("VALPES"):SetHeaderAlign("RIGHT")

		//DESCONTOS
		oSection8 := TRSection():New(oSection,"",{""})
		TRCell():New(oSection8,"DSCTOT"			,		,OEMTOANSI("Descontos"	),"@!"							,20													,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection8,"VALDSC"			,		,OEMTOANSI(""			),PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]													,/*lPixel*/,/*{||  }*/						)	

		oSection8:Cell("VALDSC"):SetHeaderAlign("RIGHT")
		
		oSection9 := TRSection():New(oSection,"",{""})
		//MENSAGEM PARA NOTA FISCAL
		TRCell():New(oSection9,"MSGNF"			,		,OEMTOANSI("Mensagem para Nota Fiscal"),PesqPict("ZAE","ZAE_OBSNF")	,TamSx3("ZAE_OBSNF")[1]													,/*lPixel*/,/*{||  }*/						)				

		
		While CABNF->(!EOF())
			//zera as variaveis de controle de totais
			nlVlToT		:= 0
			nlTNC  		:= 0
			nlBNC  		:= 0
			nlValNC		:= 0
			nlPesB 		:= 0
			nlPesL 		:= 0
			nlBIpiT		:= 0
			nlValIpiT	:= 0
			nlValDes	:= 0
			nlDscNC		:= 0
			nlTQuant	:= 0
			nlTCLI		:= 0

			//Começa a imprimir linha a linha do relatorio
			oSection:Init()
			oReport:IncMeter()
			
		    clTipo	:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_TIPO")
		    clTabPrc:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_TABELA")
		    clTransp:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_TRANSP")
		    clTransp:= clTransp + " - " + Posicione("SA4",1,xFilial("SA4")+clTransp,"A4_NOME")
   		    clCndPag:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_COND")
   		    clCndPag:= Posicione("SE4",1,xFilial("SE4")+clCndPag,"E4_DESCRI")
	    	nlPos	:= aScan(alDesc,{|x| Alltrim(x[1]) == AllTrim(clTipo)})
		    clNomVnd:= Posicione("SA3",1,xFilial("SA3")+CABNF->ZAE_VEND,"A3_NOME")
		    clCgc	:= Iif(Len(AllTrim(CABNF->A1_CGC)) == 11,Transform(CABNF->A1_CGC,"@R 999.999.999-99"),Transform(CABNF->A1_CGC,"@R 99.999.999/9999-99"))

		    //DADOS DO CLIENTE
			oSection:Cell("CLIENTE"):SetValue(CABNF->A1_COD + "/" + CABNF->A1_LOJA + "  " + CABNF->A1_NOME)
			
			oSection:Cell("TIPOCLI"):SetValue(alDesc[nlPos][2])
			
			oSection:PrintLine()
			
			oSection1:Init()
			
			oSection1:Cell("DADOS"):SetValue(UPPER("Dados faturamento"))
			oSection1:Cell("END"):SetValue(CABNF->A1_ENDCOB)
			oSection1:Cell("CEP"):SetValue(CABNF->A1_CEPC)
			oSection1:Cell("CIT"):SetValue(CABNF->A1_MUNC)
			oSection1:Cell("EST"):SetValue(CABNF->A1_ESTC)
			oSection1:Cell("CPF"):SetValue(clCgc)
			oSection1:Cell("IE"):SetValue(CABNF->A1_INSCR)
			oSection1:Cell("TEL"):SetValue(CABNF->A1_TEL)
			oSection1:Cell("VEND"):SetValue(CABNF->ZAE_VEND + " - " + clNomVnd)
			
			
			oSection1:PrintLine()
			
			oSection1:Cell("DADOS"):SetValue(UPPER("Dados Entrega"))
			oSection1:Cell("END"):SetValue(CABNF->A1_ENDENT)
			oSection1:Cell("CEP"):SetValue(CABNF->A1_CEPE)
			oSection1:Cell("CIT"):SetValue(CABNF->A1_MUNE)
			oSection1:Cell("EST"):SetValue(CABNF->A1_ESTE)
			oSection1:Cell("CPF"):SetValue(clCgc)
			oSection1:Cell("IE"):SetValue(CABNF->A1_INSCR)
			oSection1:Cell("TEL"):SetValue(CABNF->A1_TEL + " / " + CABNF->A1_TEL)
			oSection1:Cell("VEND"):SetValue(CABNF->ZAE_VEND + " - " + clNomVnd)
						
			oSection1:PrintLine()
			oSection1:Finish()
			oSection3:Init()
			//OBS. DO CLIENTE
			
			//DADOS DO PEDIDO
			oSection3:Cell("TIPPED"):SetValue("NC GAMES")
			oSection3:Cell("NUMPED"):SetValue(CABNF->ZAE_NUMEDI)
			oSection3:Cell("EMISSAO"):SetValue(StoD(CABNF->ZAE_DTIMP))
			oSection3:Cell("ENTREG"):SetValue(StoD(CABNF->ZAE_DTENTR))
			oSection3:Cell("CONDPG"):SetValue(clCndPag)
			oSection3:Cell("TABPRC"):SetValue(clTabPrc)
			oSection3:Cell("FRETE"):SetValue(CABNF->ZAE_TPFRET)
			oSection3:Cell("VALFRT"):SetValue(CABNF->ZAE_TOTFRT)
			oSection3:Cell("TRANSP"):SetValue(clTransp)
			
			
			oSection3:PrintLine()
			
			oSection3:Cell("TIPPED"):SetValue("CLIENTE")
			oSection3:Cell("NUMPED"):SetValue(CABNF->ZAE_NUMEDI)
			oSection3:Cell("EMISSAO"):SetValue(StoD(CABNF->ZAE_DTIMP))
			oSection3:Cell("ENTREG"):SetValue(StoD(CABNF->ZAE_DTENTR))
			oSection3:Cell("CONDPG"):SetValue(Posicione("SE4",1,xFilial("SE4")+CABNF->ZAE_CONDPA,"E4_DESCRI"))
			oSection3:Cell("TABPRC"):SetValue(CABNF->ZAE_TABPRC)
			oSection3:Cell("FRETE"):SetValue(CABNF->ZAE_TPFRET)
			oSection3:Cell("VALFRT"):SetValue(CABNF->ZAE_TOTFRT)
			oSection3:Cell("TRANSP"):SetValue(CABNF->ZAE_TRANSP+ " - " + Posicione("SA4",1,xFilial("SA4")+clTransp,"A4_NOME"))

			oSection3:PrintLine()
			oSection3:Finish()
			
			//Monta a query para busca as informações dos produtos caso estejam cadastrados no sistema
			clQuery := " SELECT * " + CRLF
			clQuery += " FROM ( " + CRLF
			clQuery += " 		SELECT	ZAF_NUMEDI, " + CRLF
			clQuery += " 				ZAF_EAN, " + CRLF
			clQuery += " 				ZAF_DESCRI, " + CRLF
			clQuery += " 				ZAF_ITEM, " + CRLF
			clQuery += " 				ZAF_UM, " + CRLF
			clQuery += " 				ZAF_QTD, " + CRLF
			clQuery += " 				ZAF_PRCUNI, " + CRLF
			clQuery += " 				ZAF_VLRIPI, " + CRLF
			clQuery += " 				ZAF_PERCIP, " + CRLF
			clQuery += " 				ZAF_DTENT, " + CRLF
			clQuery += " 				ZAF_TOTAL, " + CRLF
			clQuery += " 				ZAF_VLRDES, " + CRLF
			clQuery += " 				ZAF_TES, " + CRLF
			clQuery += " 				ZAF_CFOP, " + CRLF
			clQuery += " 				ZAF_LOCAL, " + CRLF
			clQuery += " 				ZAF_NCM, " + CRLF					
			clQuery += " 				ZAF_CST, " + CRLF			
			clQuery += " 				ZAF_VLRICM " + CRLF			
			clQuery += " 		FROM " + RETSQLNAME("ZAF") + CRLF
			clQuery += " 		WHERE	D_E_L_E_T_ <> '*' " + CRLF
			clQuery += " 				AND ZAF_FILIAL = '" + xFilial("ZAF") + "' " + CRLF
			clQuery += " 				AND ZAF_NUMEDI = '" + CABNF->ZAE_NUMEDI + "' " + CRLF
			clQuery += " ) ZAF " + CRLF
			clQuery += " LEFT JOIN ( " + CRLF
			clQuery += " 			SELECT	B1_COD, " + CRLF
			clQuery += " 					B1_CODBAR, " + CRLF
			clQuery += " 					B1_DESC, " + CRLF
			clQuery += " 					B1_LOCPAD, " + CRLF
			clQuery += " 					B1_UM, " + CRLF
			clQuery += " 					B1_IPI, " + CRLF
			clQuery += " 					B1_EX_NCM, " + CRLF
			clQuery += " 					B1_PESO, " + CRLF
			clQuery += " 					B1_PESBRU " + CRLF
			clQuery += " 			FROM " + RETSQLNAME("SB1")  + CRLF
			clQuery += " 			WHERE	D_E_L_E_T_ <> '*' " + CRLF
			clQuery += " 					AND B1_FILIAL = '" + xFilial("SB1") + "' " + CRLF
			clQuery += " )SB1 ON ZAF.ZAF_EAN = SB1.B1_CODBAR " + CRLF
			clQuery += " Order By ZAF_ITEM " + CRLF
			
			clQuery := ChangeQuery(clQuery)
			
			If Select("ITMPED") > 0
				ITMPED->(dbCloseArea())
			EndIf
			dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "ITMPED", .F., .F. )
			oSection4:Init()
			While ITMPED->(!EOF())
				
				For nx:= 1 to 2
					If nx == 1
						clTexto := "NC GAMES"
						clItem	:= ITMPED->ZAF_ITEM
						clCodP	:= IIf(Empty(ITMPED->B1_COD),"Não Cadastrado",ITMPED->B1_COD)
						clEan	:= IIf(Empty(ITMPED->B1_COD),"Não Cadastrado",ITMPED->B1_CODBAR)
						clDesc	:= IIf(Empty(ITMPED->B1_COD),"Produto não cadastrado",ITMPED->B1_DESC)
					    clNCM	:= IIf(Empty(ITMPED->B1_COD),"",Posicione("SB1",1,xFilial("SB1")+clCodP,"B1_POSIPI"))
						cltpOpr := IIf(Empty(ITMPED->B1_COD),"",KzBuscaOp(CABNF->ZAE_TPNGRD)	)
						
						//Busca TES retornada pela função de TES inteligente
						clTes	:= IIf(Empty(ITMPED->B1_COD),"",MaTesInt(2,cltpOpr,CABNF->ZAE_CLIFAT,CABNF->ZAE_LJFAT,"C",clCodP,NIL))
						clCfop	:= IIf(Empty(ITMPED->B1_COD),"",Posicione("SF4",1,xFilial("SF4")+clTes,"F4_CF"))
						clUm	:= IIf(Empty(ITMPED->B1_COD),"",ITMPED->B1_UM)
						nlPrcU	:= IIf(Empty(ITMPED->B1_COD),0,Posicione("DA1",1,xFilial("DA1")+CABNF->A1_TABELA+clCodP,"DA1_PRCVEN"))
						nlPerIPI:= IIf(Empty(ITMPED->B1_COD),0,ITMPED->B1_IPI)
						nlValIPI:= IIf(Empty(ITMPED->B1_COD),0,(nlPrcU + (nlPrcU * (nlPerIPI/100))))
						nlVlToT	:= IIf(Empty(ITMPED->B1_COD),0,(ITMPED->ZAF_QTD * nlPrcU ))
						//nlVlToT	+= ( nlVlToT * (nlPerIPI/100) )
						//recebe vazio para nao aprecer no relatorio
						dlEntr	:= ""
						nlDcT	:= IIf(Empty(ITMPED->B1_COD),0,Posicione("DA1",1,xFilial("DA1")+CABNF->A1_TABELA+clCodP,"DA1_VLRDES"))
						nlValDc	:= ((100 * nlDcT) / nlPrcU)
						nlDcT	:= ITMPED->ZAF_QTD * nlDcT
						clLocPad:= IIf(Empty(ITMPED->B1_COD),"",ITMPED->B1_LOCPAD)
						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Inicializa a funcao fiscal                   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						MaFisSave()
						MaFisEnd()  
						
						//MaFisIni(CABNF->A1_COD, CABNF->A1_LOJA, "C", "S", cTipoCli,,, .F., "SB1")
					   	MaFisIni(CABNF->A1_COD, CABNF->A1_LOJA,"C","N",CABNF->A1_TIPO,,,.F.,)   	  
						
						//MaFisAdd(SB1->B1_COD, SF4->F4_CODIGO, nQuant,nVlUnit, 0, "", "",, 0, 0, 0, 0, nVlrTotItem, 0, SB1->(RecNo())) 
						
						MaFisAdd(clCodP,clTes,ITMPED->ZAF_QTD,nlPrcU,0,"","",,0,0,0,0,(ITMPED->ZAF_QTD*nlPrcU),0,)
	
						nPerIcm := MaFisRet(1,'IT_ALIQSOL')
						nValIcm := MaFisRet(1,'IT_BASEICM')*(nPerIcm/100)
						nValIcm := MaFisRet(1,'IT_VALSOL')
						// Encerra a funcao fiscal
						MaFisEnd()
						MaFisRestore()  
						
						nlVlrSt	:= nValIcm
						/////////////////////////////////////////////////////
						
						clCST	:= Posicione("SF4",1,xFilial("SF4")+clTes,"F4_CSTPIS")
						If Empty(clCST)
							clCST	:= Posicione("SF4",1,xFilial("SF4")+clTes,"F4_CSTCOF")
						EndIf
						nlTNC	+= nlVlToT //+(nlVlToT * (nlPerIPI/100) )
						//NC Games
						nlBNC	+= nlPrcU * ITMPED->ZAF_QTD
					    nlValNC	+= (nlVlToT * (nlPerIPI/100) )
						nlPesB	+= ITMPED->B1_PESBRU
						nlPesL	+= ITMPED->B1_PESO
						nlDscNC	+= nlDcT
					else
						clTexto := "CLIENTE"
						clItem	:= ITMPED->ZAF_ITEM
						clCodP	:= ""
						clEan	:= ITMPED->ZAF_EAN
						clDesc	:= ITMPED->ZAF_DESCRI
						cltpOpr := ""
						//Busca TES retornada pela função de TES inteligente
						clTes	:= ITMPED->ZAF_TES
						clCfop	:= ITMPED->ZAF_CFOP
						clUm	:= ITMPED->ZAF_UM
						nlPrcU	:= ITMPED->ZAF_PRCUNI
						//nlValIPI:= ITMPED->ZAF_VLRIPI
						nlVlToT	:= ( ITMPED->ZAF_QTD * nlPrcU ) + ITMPED->ZAF_VLRIPI
						nlPerIPI:= ITMPED->ZAF_PERCIP //( (100*ITMPED->ZAF_VLRIPI) / nlVlToT )
						//nlVlToT	+= ( nlVlToT * (nlPerIPI/100) )
						dlEntr	:= StoD(ITMPED->ZAF_DTENT) 
						nlDcT	:= 0
						nlValDc	:= ITMPED->ZAF_VLRDESC
						clLocPad:= ITMPED->ZAF_LOCAL
						clNCM	:= ITMPED->ZAF_NCM
						nlVlrSt	:= ITMPED->ZAF_VLRICM
						clCST	:= ITMPED->ZAF_CST
						nlTCLI	+= nlVlToT //nlPrcU +(nlPrcU * (nlPerIPI/100) )
						//Cliente
						//nlBIpi := 
						//nlValIpi := (ITMPED->ZAF_TOTAL * (ITMPED->B1_IPI/100))
						nlBIpiT		+= ITMPED->ZAF_TOTAL
						nlValIpiT	+= ITMPED->ZAF_VLRIPI
						nlValDes	+= ITMPED->ZAF_VLRDESC
						nlTQuant	+= ITMPED->ZAF_QTD
					EndIf
					//Atribui os valores nas celulas
   					oSection4:Cell("DESCITM"):SetValue(clTexto)
					oSection4:Cell("CODITEM"):SetValue(clItem)
					oSection4:Cell("CODPRO"):SetValue(clCodP)
					oSection4:Cell("CODEAN"):SetValue(clEan)
					oSection4:Cell("DESCPRD"):SetValue(clDesc)
					oSection4:Cell("CODTES"):SetValue(clTes)
					oSection4:Cell("CFOP"):SetValue(clCfop)
					oSection4:Cell("CODEMB"):SetValue(clUm)
					oSection4:Cell("QUANT"):SetValue(ITMPED->ZAF_QTD)
					oSection4:Cell("VALUNT"):SetValue(nlPrcU)
					oSection4:Cell("PRCIPI"):SetValue(nlPerIPI)
					oSection4:Cell("PRCCIPI"):SetValue(nlPrcU +(nlPrcU * (nlPerIPI/100) ))
					oSection4:Cell("TOTCIPI"):SetValue(nlVlToT)
					oSection4:Cell("DTENTR"):SetValue(dlEntr)
					oSection4:Cell("DESCONT"):SetValue(nlValDc)
					oSection4:Cell("VALDESC"):SetValue(nlDcT)
					oSection4:Cell("LOCPAD"):SetValue(clLocPad)
					oSection4:Cell("CODNCM"):SetValue(clNCM)
					oSection4:Cell("VALST"):SetValue(nlVlrSt)
					oSection4:Cell("CODCST"):SetValue(clCST)
					
					oSection4:PrintLine()
				Next nx
				oReport:SkipLine()
				ITMPED->(dbSkip())
			EndDo
			oSection4:Finish()
			
			//TOTAIS
			oSection5:Init()
			For nx:= 1 to 2
				If nx == 1
					oSection5:Cell("DESCTOT"):SetValue("NC GAMES")
					oSection5:Cell("TOTCIPI"):SetValue(NOROUND(nlTNC+nlValNC,2))
				Else
					oSection5:Cell("DESCTOT"):SetValue("CLIENTE")
					oSection5:Cell("TOTCIPI"):SetValue(nlTCLI)
				EndIf
				
				oSection5:Cell("QNTTOT"):SetValue(nlTQuant)

				oSection5:PrintLine()
			Next nx
			
			oSection5:Finish()
			
			//Impostos
			oSection6:Init()
		
				oSection6:Cell("TIPIMP"):SetValue("NC GAMES")
				oSection6:Cell("BASIPI"):SetValue(nlBNC)	
				oSection6:Cell("VALIPI"):SetValue(nlValNC)
				oSection6:Cell("VALTOT"):SetValue(NOROUND(nlTNC+nlValNC,2))
				
				oSection6:PrintLine()	
				oSection6:Cell("TIPIMP"):SetValue("CLIENTE")
				oSection6:Cell("BASIPI"):SetValue(nlBIpiT)	
				oSection6:Cell("VALIPI"):SetValue(nlValIpiT)
				oSection6:Cell("VALTOT"):SetValue(nlTCLI)
					
				oSection6:PrintLine()	
			
			oSection6:Finish()
			
			oSection7:Init()
				oSection7:Cell("TIPPES"):SetValue("Peso Bruto")
				oSection7:Cell("VALPES"):SetValue(nlPesB)
				oSection7:PrintLine()
				oSection7:Cell("TIPPES"):SetValue("Peso Liquido")
				oSection7:Cell("VALPES"):SetValue(nlPesL)
				oSection7:PrintLine()
			oSection7:Finish()
			
			oSection8:Init()
			
				oSection8:Cell("DSCTOT"):SetValue("Total Desc.")
				oSection8:Cell("VALDSC"):SetValue(nlDscNC)
				oSection8:PrintLine()
				
				oSection8:Cell("DSCTOT"):SetValue("% Medio Desc")
				oSection8:Cell("VALDSC"):SetValue( ( ( 100 * nlDscNC) / nlBNC ) )				
				oSection8:PrintLine()
			oSection8:Finish()
			
			oSection9:Init()
				oSection9:Cell("MSGNF"):SetValue(CABNF->ZAE_OBSNF)
				oSection9:PrintLine()				
			oSection9:Finish()
			oSection:Finish()
			
			CABNF->(dbSkip())
			
			/*If CABNF->(!EOF())
				oReport:PageBreak()
			EndIf*/
		EndDo
	Else//Sintetico
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Altera o Titulo do Relatorio de acordo com o Tipo escolhido  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:SetTitle(oReport:Title() + " - Sintético")
		oSection4 := TRSection():New(oSection,"",{""})
		//INCONSISTENCIAS
		TRCell():New(oSection4,"TIPINC"			,		,OEMTOANSI(""						),"@!"							,20																		,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection4,"DESCINC"		,		,OEMTOANSI(""						),"@!"							,110																	,/*lPixel*/,/*{||  }*/						)
		
		//IMPOSTOS
		oSection5 := TRSection():New(oSection,"",{""})
		TRCell():New(oSection5,"TIPIMP"			,		,OEMTOANSI(""						),"@!"							,20																		,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection5,"BASIPI"			,		,OEMTOANSI("Base IPI"				),PesqPict("SD2","D2_BASEIPI")	,TamSx3("D2_BASEIPI")[1]												,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection5,"VALIPI"			,		,OEMTOANSI("Valor IPI"				),PesqPict("SD2","D2_VALIPI")	,TamSx3("D2_VALIPI")[1]													,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection5,"VALTOT"			,		,OEMTOANSI("Valor Total"			),PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]													,/*lPixel*/,/*{||  }*/						)
		
		oSection5:Cell("BASIPI"):SetHeaderAlign("RIGHT")
		oSection5:Cell("VALIPI"):SetHeaderAlign("RIGHT")		
		oSection5:Cell("VALTOT"):SetHeaderAlign("RIGHT")
		
		//DESCONTOS
		oSection6 := TRSection():New(oSection,"",{""})
		TRCell():New(oSection6,"DSCTOT"			,		,OEMTOANSI("Descontos")			,"@!"						,TamSx3("C6_VALOR")[1]													,/*lPixel*/,/*{||  }*/						)
		TRCell():New(oSection6,"VALDSC"			,		,OEMTOANSI()					,PesqPict("SC6","C6_VALOR")	,TamSx3("C6_VALOR")[1]													,/*lPixel*/,/*{||  }*/						)	
		oSection6:Cell("DSCTOT"):SetHeaderAlign("RIGHT")
		oSection6:Cell("VALDSC"):SetHeaderAlign("RIGHT")
		
		oSection7 := TRSection():New(oSection,"",{""})
		//MENSAGEM PARA NOTA FISCAL
		TRCell():New(oSection7,"MSGNF"			,		,OEMTOANSI("Mensagem para Nota Fiscal"),PesqPict("ZAE","ZAE_OBSNF")	,TamSx3("ZAE_OBSNF")[1]													,/*lPixel*/,/*{||  }*/						)
		

		While CABNF->(!EOF())
			//zera as variaveis de controle de totais
			nlVlToT		:= 0
			nlTNC  		:= 0
			nlBNC  		:= 0
			nlValNC		:= 0
			nlPesB 		:= 0
			nlPesL 		:= 0
			nlBIpiT		:= 0
			nlValIpiT	:= 0
			nlValDes	:= 0
			
			//Começa a imprimir linha a linha do relatorio
			oSection:Init()
			oReport:IncMeter()
			
		    clTipo	:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_TIPO")
			clTabPrc:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_TABELA")
		    clTransp:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_TRANSP")
		    clTransp:= clTransp + " - " + Posicione("SA4",1,xFilial("SA4")+clTransp,"A4_NOME")
		    clCndPag:= Posicione("SA1",1,xFilial("SA1")+CABNF->A1_COD + CABNF->A1_LOJA,"A1_COND")
   		    clCndPag:= Posicione("SE4",1,xFilial("SE4")+clCndPag,"E4_DESCRI")
	    	nlPos	:= aScan(alDesc,{|x| Alltrim(x[1]) == AllTrim(clTipo)})
		    clNomVnd:= Posicione("SA3",1,xFilial("SA3")+CABNF->ZAE_VEND,"A3_NOME")
		    clCgc	:= Iif(Len(AllTrim(CABNF->A1_CGC)) == 11,Transform(CABNF->A1_CGC,"@R 999.999.999-99"),Transform(CABNF->A1_CGC,"@R 99.999.999/9999-99"))
		    //DADOS DO CLIENTE
			oSection:Cell("CLIENTE"):SetValue(CABNF->A1_COD + "/" + CABNF->A1_LOJA + "  " + CABNF->A1_NOME)
			
			oSection:Cell("TIPOCLI"):SetValue(alDesc[nlPos][2])
			
			oSection:PrintLine()
			oSection1:Init()
			oSection1:Cell("DADOS"):SetValue(UPPER("Dados faturamento"))
			oSection1:Cell("END"):SetValue(CABNF->A1_ENDCOB)
			oSection1:Cell("CEP"):SetValue(CABNF->A1_CEPC)
			oSection1:Cell("CIT"):SetValue(CABNF->A1_MUNC)
			oSection1:Cell("EST"):SetValue(CABNF->A1_ESTC)
			oSection1:Cell("CPF"):SetValue(clCgc)
			oSection1:Cell("IE"):SetValue(CABNF->A1_INSCR)
			oSection1:Cell("TEL"):SetValue(CABNF->A1_TEL + " / " + CABNF->A1_TEL)
			oSection1:Cell("VEND"):SetValue(CABNF->ZAE_VEND + " - " + clNomVnd)
			
			
			oSection1:PrintLine()
			
			oSection1:Cell("DADOS"):SetValue(UPPER("Dados Entrega"))
			oSection1:Cell("END"):SetValue(CABNF->A1_ENDENT)
			oSection1:Cell("CEP"):SetValue(CABNF->A1_CEPE)
			oSection1:Cell("CIT"):SetValue(CABNF->A1_MUNE)
			oSection1:Cell("EST"):SetValue(CABNF->A1_ESTE)
			oSection1:Cell("CPF"):SetValue(clCgc)
			oSection1:Cell("IE"):SetValue(CABNF->A1_INSCR)
			oSection1:Cell("TEL"):SetValue(CABNF->A1_TEL + " / " + CABNF->A1_TEL)
			oSection1:Cell("VEND"):SetValue(CABNF->ZAE_VEND + " - " + clNomVnd)
						
			oSection1:PrintLine()
			oSection3:Finish()
			oSection3:Init()
			//OBS. DO CLIENTE
			
			//DADOS DO PEDIDO
			oSection3:Cell("TIPPED"):SetValue("NC GAMES")
			oSection3:Cell("NUMPED"):SetValue(CABNF->ZAE_NUMEDI)
			oSection3:Cell("EMISSAO"):SetValue(StoD(CABNF->ZAE_DTIMP))
			oSection3:Cell("ENTREG"):SetValue(StoD(CABNF->ZAE_DTENTR))
			oSection3:Cell("CONDPG"):SetValue(clCndPag)
			oSection3:Cell("TABPRC"):SetValue(clTabPrc)
			oSection3:Cell("FRETE"):SetValue(CABNF->ZAE_TPFRET)
			oSection3:Cell("VALFRT"):SetValue(CABNF->ZAE_TOTFRT)
			oSection3:Cell("TRANSP"):SetValue(clTransp)
			
			
			oSection3:PrintLine()
			
			oSection3:Cell("TIPPED"):SetValue("CLIENTE")
			oSection3:Cell("NUMPED"):SetValue(CABNF->ZAE_NUMEDI)
			oSection3:Cell("EMISSAO"):SetValue(StoD(CABNF->ZAE_DTIMP))
			oSection3:Cell("ENTREG"):SetValue(StoD(CABNF->ZAE_DTENTR))
			oSection3:Cell("CONDPG"):SetValue(CABNF->ZAE_CONDPA)
			oSection3:Cell("TABPRC"):SetValue(CABNF->ZAE_TABPRC)
			oSection3:Cell("FRETE"):SetValue(CABNF->ZAE_TPFRET)
			oSection3:Cell("VALFRT"):SetValue(CABNF->ZAE_TOTFRT)
			oSection3:Cell("TRANSP"):SetValue(CABNF->ZAE_TRANSP)

			oSection3:PrintLine()
			oSection3:Finish()
			
			
			//Busca se há algum item com inconsistencia do pedido!
/*			
			clQuery := " SELECT	ZAG_ITEM, " +CRLF
			clQuery += " 		ZAG_INCONS " +CRLF
			clQuery += " FROM " + RETSQLNAME("ZAG") +CRLF
			clQuery += " WHERE	D_E_L_E_T_ <> '*' " +CRLF
			clQuery += " 		AND ZAG_FILIAL = '" + xFilial("ZAG") + "' " +CRLF
			clQuery += " 		AND ZAG_NUMEDI = '" + CABNF->ZAE_NUMEDI+ "' " +CRLF
*/
			clQuery := "SELECT ZAG_ITEM," 									   		+ CRLF
			clQuery += " 		ZAG_INCONS," 								   		+ CRLF
			clQuery += "		ZAF_EAN," 							   		   		+ CRLF 
			clQuery += " 		ZAF_DESCRI" 							   	   		+ CRLF 
			clQuery += " FROM" 							   					   		+ CRLF 
			clQuery += " (" 							   					   		+ CRLF 		  		 
			clQuery += "	 SELECT	ZAG_NUMEDI" 							   		+ CRLF 
			clQuery += "			,ZAG_ITEM " 							   		+ CRLF 
			clQuery += " 			,ZAG_INCONS" 							   		+ CRLF  
			clQuery += "	 FROM " + RetSQLName("ZAG")				   		   		+ CRLF 
			clQuery += "	 WHERE	D_E_L_E_T_ <> '*'" 						   		+ CRLF  
			clQuery += " 		AND ZAG_FILIAL = '" + xFilial("ZAG") + "'" 	   		+ CRLF  
			clQuery += " 		AND ZAG_NUMEDI = '" + CABNF->ZAE_NUMEDI+ "' "  		+ CRLF  
			clQuery += ") ZAG" 							   					   		+ CRLF 
			clQuery += "INNER JOIN " 							   					+ CRLF 
			clQuery += "(" 							   								+ CRLF  		
			clQuery += "	SELECT	ZAF_NUMEDI " 							   		+ CRLF 	
			clQuery += "			,ZAF_EAN" 							   	   		+ CRLF  
			clQuery += " 			,ZAF_DESCRI" 							   		+ CRLF
			clQuery += " 			,ZAF_ITEM"     									+ CRLF
			clQuery += "	 FROM " + RetSQLName("ZAF")				   		   		+ CRLF 
			clQuery += "	 WHERE	D_E_L_E_T_ <> '*'" 						   		+ CRLF  
			clQuery += " 		AND ZAF_FILIAL = '" + xFilial("ZAF") + "'" 	 		+ CRLF  
			clQuery += " 		AND ZAF_NUMEDI = '" + CABNF->ZAE_NUMEDI+ "' " 		+ CRLF  
			clQuery += ") ZAF" 							   							+ CRLF 
			clQuery += "ON 	 ZAG.ZAG_NUMEDI = ZAF.ZAF_NUMEDI" 						+ CRLF
			clQuery += "AND  ZAG.ZAG_ITEM = ZAF.ZAF_ITEM" 
			clQuery += " ORDER BY ZAG.ZAG_ITEM " + CRLF
						 			
			clQuery := ChangeQuery(clQuery)
			
			If Select("ITEMNF") > 0
				ITEMNF->(dbCloseArea())
			EndIf
			
			dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "ITEMNF", .F., .F. )
			
			oSection4:Init()
			oSection4:Cell("TIPINC"):SetValue("STATUS DO PEDIDO EDI: ")
			If ITEMNF->(EOF())
				//se a query retornar vazio, o pedido nao contem inconsistencias.
				oSection4:Cell("DESCINC"):SetValue("Sem Inconsistencia")
	
			Else
				oSection4:Cell("DESCINC"):SetValue("Com Inconsistencia")	
			EndIf
			oSection4:PrintLine()
			oReport:SkipLine()
			
			// CABECALHO MANUAL - 		   									
			clIncon := PadR("Item",TamSx3("ZAG_ITEM")[1]+6) + Padr("CÓDIGO DO PRODUTO",TamSx3("B1_COD")[1]+6)+ PadR("DESCRIÇÃO PRODUTO",40+6)+ "DESCRIÇÃO INCONSISTÊNCIA"

			oSection4:Cell("TIPINC"):SetValue("")	
			oSection4:Cell("DESCINC"):SetValue(clIncon)
				
			oSection4:PrintLine()
			
			While ITEMNF->(!Eof())
				nlPos := aScan(alIncon,{|x| x[1] == ITEMNF->ZAG_INCONS})
				If nlPos > 0
					clCodPro := Posicione("SB1",5,xFilial("SB1")+ITEMNF->ZAF_EAN,"B1_COD") 
					If Empty(clCodPro)
						clCodPro := "NÃO CADASTRADO"
						clDesPro := ITEMNF->ZAF_DESCRI
					Else
						clDesPro := Posicione("SB1",5,xFilial("SB1")+ITEMNF->ZAF_EAN,"B1_DESC") 
					EndIf
					clIncon := PadR(ITEMNF->ZAG_ITEM,TamSx3("ZAG_ITEM")[1]+6) +  PadR(clCodPro,TamSx3("B1_COD")[1]+6) + PadR(clDesPro,40)+Replicate(" ",6)+ alIncon[nlPos][2]
				EndIf
				
				oSection4:Cell("TIPINC"):SetValue("")	
				oSection4:Cell("DESCINC"):SetValue(clIncon)
				
				oSection4:PrintLine()
				clAuxItm := ITEMNF->ZAG_ITEM
				ITEMNF->(dbSkip())
				If clAuxItm != ITEMNF->ZAG_ITEM
					oReport:SkipLine()
				EndIf
			EndDo
			ITEMNF->(dbCloseArea())
			oSection4:Finish()

			clQuery := " SELECT ZAF_EAN, " + CRLF
			clQuery += " 		ZAF_QTD, " + CRLF
			clQuery += " 		ZAF_PRCUNI, " + CRLF
			clQuery += " 		ZAF_TOTAL, " + CRLF
			clQuery += " 		ZAF_VLRIPI, " + CRLF
			clQuery += " 		ZAF_VLRDES, " + CRLF
			clQuery += " 		ZAF_PERCIP, " + CRLF
			clQuery += " 		B1_CODBAR, " + CRLF
			clQuery += "  		B1_IPI, " + CRLF
			clQuery += "  		PRCVEN, " + CRLF
			clQuery += " 		(ZAF.ZAF_QTD * SB1.PRCVEN) AS B1_TOTAL " + CRLF
			clQuery += " FROM ( " + CRLF
			clQuery += " 		SELECT	ZAF_EAN, " + CRLF
			clQuery += " 				ZAF_QTD, " + CRLF
			clQuery += " 				ZAF_PRCUNI, " + CRLF
			clQuery += " 				ZAF_TOTAL, " + CRLF
			clQuery += " 				ZAF_VLRIPI, " + CRLF
			clQuery += " 				ZAF_VLRDES, " + CRLF
			clQuery += " 				ZAF_PERCIP " + CRLF			
			clQuery += " 		FROM " + RETSQLNAME("ZAF") + CRLF
			clQuery += " 		WHERE	D_E_L_E_T_ <> '*' " + CRLF
			clQuery += " 				AND ZAF_FILIAL = '" + xFilial("ZAF") + "' " + CRLF
			clQuery += " 				AND ZAF_NUMEDI = '" + CABNF->ZAE_NUMEDI + "' " + CRLF
			clQuery += " ) ZAF " + CRLF
			clQuery += " LEFT JOIN ( " + CRLF
			clQuery += "  			SELECT	B1_CODBAR, " + CRLF
			clQuery += "  					B1_IPI, " + CRLF
			clQuery += "  					( " + CRLF
			clQuery += "  						SELECT	DA1_PRCVEN " + CRLF
			clQuery += "  						FROM " + RETSQLNAME("DA1") + CRLF
			clQuery += "  						WHERE	DA1_CODPRO = B1_COD " + CRLF
			clQuery += "  								AND DA1_CODTAB = '" + clTabPrc + "' " + CRLF
			clQuery += "  								AND DA1_FILIAL = '" + xFilial("DA1") + "'" + CRLF
			clQuery += "  								AND D_E_L_E_T_ <> '*' " + CRLF
			clQuery += "  					) AS PRCVEN " + CRLF
			clQuery += "  			FROM " + RETSQLNAME("SB1") + CRLF
			clQuery += "  			WHERE	D_E_L_E_T_ <> '*'  " + CRLF
			clQuery += "  					AND B1_FILIAL = '" + xFilial("SB1")+ "'  " + CRLF
			clQuery += " )SB1 ON ZAF.ZAF_EAN = SB1.B1_CODBAR   " + CRLF

			clQuery := ChangeQuery(clQuery)
			
			If Select("ITEMNF") > 0
				ITEMNF->(dbCloseArea())
			EndIf
			
			dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "ITEMNF", .F., .F. )
						
			While ITEMNF->(!EOF())
				nlBNC += ITEMNF->B1_TOTAL
				nlValNC += (ITEMNF->B1_TOTAL * (ITEMNF->B1_IPI/100) )
				nlBIpiT += ITEMNF->ZAF_TOTAL
				nlValIpiT += ITEMNF->ZAF_VLRIPI
				nlValDes += ITEMNF->ZAF_VLRDES
				ITEMNF->(dbSkip())
			EndDo
			ITEMNF->(dbCloseArea()) 
			oSection5:Init()
			For nx:= 1 to 2
				If nx == 1
					oSection5:Cell("TIPIMP"):SetValue("NC GAMES")	
					oSection5:Cell("BASIPI"):SetValue(nlBNC	)	
					oSection5:Cell("VALIPI"):SetValue(nlValNC)
					oSection5:Cell("VALTOT"):SetValue(nlBNC+nlValNC)
				Else
					oSection5:Cell("TIPIMP"):SetValue("CLIENTE")	
					oSection5:Cell("BASIPI"):SetValue(nlBIpiT)	
					oSection5:Cell("VALIPI"):SetValue(nlValIpiT)
					oSection5:Cell("VALTOT"):SetValue(nlBIpiT+nlValIpiT)
				EndIf
				
				
				oSection5:PrintLine()	
			Next nx
			oSection5:Finish()
			oSection6:Init()
			oSection6:Cell("DSCTOT"):SetValue("Total Desc.")
			oSection6:Cell("VALDSC"):SetValue( nlValDes)
			oSection6:PrintLine()
			oSection6:Cell("DSCTOT"):SetValue("% Medio Desc.")
			oSection6:Cell("VALDSC"):SetValue( ( (nlValDes * 100 ) / nlBIpiT ) )
			oSection6:PrintLine()
			oSection6:Finish()
						
			oSection7:Init() 
			oSection7:Cell("MSGNF"):SetValue(CABNF->ZAE_OBSNF)
			oSection7:PrintLine()
			oSection7:Finish()
			
			CABNF->(dbSkip())
			
			
			oSection:Finish()
			If CABNF->(!EOF())
				oReport:PageBreak()
			EndIf
		EndDo
		
		CABNF->(dbCloseArea()) 
	EndIf
Return

Static Function KzBuscaOp(cTipTit)

	Local clTipoOp	:= ""
	
	If Select("ZAC") == 0
		dbSelectArea("ZAC")
	EndIf
	
	ZAC->(dbsetOrder(1))
	If ZAC->(dbSeek(xFilial("ZAC")+AllTrim(cTipTit)))
		clTipoOp := ZAC->ZAC_OPTES
	EndIf
	
Return clTipoOp

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³AjustaSx1	     ºAutor  ³Alfredo A. MagalhaesºData  ³09/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas do relatorio no dicionario de dados			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
Static Function AjustaSx1(cPerg,lManut)

	Local aArea := GetArea()
	Local aHelpPor	:= {}
	Local aHelpEng	:= {}
	Local aHelpSpa	:= {}

	If lManut
	
		//Sintetico/Analitico
		aHelpPor := {}
		Aadd( aHelpPor, "Escolha a opção em que " )
		Aadd( aHelpPor, "o relatorio será impresso." )
		PutSx1(cPerg,"01","Tipo do relatório ?" ,"","","mv_ch01","N",1,0,1,"C","","","","","mv_par01","Analítico","Analítico","Analítico","","Sintético","Sintético","Sintético","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
		
	Else
		//Data Inicial
		Aadd( aHelpPor, 'Informe a data inicial de')
		Aadd( aHelpPor, 'importação dos pedidos.')
		PutSx1(cPerg,"01","Dt Importação de ","Dt Importação de: ","Dt Importação de: ","mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
		
		//Data Final
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe a data final de')
		Aadd( aHelpPor, 'importação dos pedidos.')
		PutSx1(cPerg,"02","Dt Importação até ","Dt Importação até: ","Dt Importação até: ","mv_ch2","D",08,0,0,"G","(Mv_Par02 >= Mv_Par01)","","","","mv_par0","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
		
	
		//Pedido EDI de
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe o codigo inicial')
		Aadd( aHelpPor, 'para os pedidos EDI.')
		PutSx1(cPerg,"03","Pedido EDI de ","Pedido EDI de: ","Pedido EDI de: ","mv_ch3","C",6,0,0,"G","","ZAE","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)	
	
		//Pedido EDI até
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe o codigo final')
		Aadd( aHelpPor, 'para os pedidos EDI.')
		PutSx1(cPerg,"04","Pedido EDI até ","Pedido EDI até: ","Pedido EDI até: ","mv_ch4","C",6,0,0,"G","","ZAE","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)	
	
		//Cliente de
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe o codigo inicial')
		Aadd( aHelpPor, 'do cliente.')
		PutSx1(cPerg,"05","Cliente de ","Cliente de: ","Cliente de: ","mv_ch5","C",6,0,0,"G","","CLI","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)	
	
		//Cliente até
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe o codigo final')
		Aadd( aHelpPor, 'do cliente.')
		PutSx1(cPerg,"06","Cliente até ","Cliente até: ","Cliente até: ","mv_ch6","C",6,0,0,"G","","CLI","","","mv_par06","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)		
	
		//Loja de
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe a Loja inicial.')
		PutSx1(cPerg,"07","Loja de ","Loja de: ","Loja de: ","mv_ch7","C",2,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)	
	
		//Loja até
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe a Loja final.')
		PutSx1(cPerg,"08","Loja até ","Loja até: ","Loja até: ","mv_ch8","C",2,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)		
	
		//Vendedor
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe o Vendedor inicial.')
		PutSx1(cPerg,"09","Vendedor de ","Vendedor de: ","Vendedor de: ","mv_ch9","C",6,0,0,"G","","SA3","","","mv_par09","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)	
	
		//Vendedor
		aHelpPor := {}
		Aadd( aHelpPor, 'Informe o Vendedor final.')
		PutSx1(cPerg,"10","Vendedor até ","Vendedor até: ","Vendedor até: ","mv_ch10","C",6,0,0,"G","","SA3","","","mv_par10","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)		
	
	
		//Sintetico/Analitico
		aHelpPor := {}
		Aadd( aHelpPor, "Escolha a opção em que " )
		Aadd( aHelpPor, "o relatorio será impresso." )
		PutSx1(cPerg,"11","Tipo do relatório ?" ,"","","mv_ch11","N",1,0,1,"C","","","","","mv_par11","Analítico","Analítico","Analítico","","Sintético","Sintético","Sintético","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
		
	EndIf
	
	RestArea(aArea)
Return