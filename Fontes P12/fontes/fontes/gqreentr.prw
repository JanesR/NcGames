#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Programa    ³GQREENTR³ Ponto de entrada ao final da gravação do documento de entrada  º±±
±±º             ³        ³ para regravar os valores de Base e Icms Retido Substituição    º±±
±±º             ³        ³ tributária.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Autor       ³09/10/12³ Almir Bandina                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Parâmetros  ³ Nil                                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Retorno     ³ Nil                                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Observações ³                                                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Alterações  ³ 99/99/99 - Consultor - Descrição da alteração                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GQREENTR()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variáveis utilizadas na rotina                                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aAreaAtu	:= GetArea()
Local aAreaSD1	:= SD1->( GetArea() )
Local aAreaSFT	:= SFT->( GetArea() )
Local aAreaSF3	:= SF3->( GetArea() )
Local aRetorno	:= {}
Local aDadSF3	:= {}
Local aDadCD2	:= {}
Local nBasTot	:= 0
Local nIcmTot	:= 0
Local nIcmOri	:= 0
Local nLoop		:= 0
Local nElem		:= 0
Local nRecAux	:= 0
Local nIndAux	:= 0
Local nVlrAux	:= 0
Local lHasCalc	:= .F.
Local cAliasPB	:= GetNextAlias()
Local lSTDif	:= SuperGetMV( "NCG_000015", , .F. )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se efetua o tratamento ICMS-ST Diferenciado                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lSTDif .And. SF1->F1_TIPO == "D" .And. SF1->F1_EST $ "PR" .And. SM0->M0_ESTENT == "SP"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona nos itens do documento de entrada                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea( "SD1" )
	dbSetOrder( 1 )			//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
	MsSeek( xFilial( "SD1" ) + SF1->( F1_DOC + F1_SERIE + F1_FORNECE + F1_LOJA ) )
	While !Eof() .And. SD1->D1_FILIAL == xFilial( "SD1" ) .And.;
						SD1->D1_DOC == SF1->F1_DOC .And.;
						SD1->D1_SERIE == SF1->F1_SERIE .And.;
						SD1->D1_FORNECE == SF1->F1_FORNECE .And.;
						SD1->D1_LOJA == SF1->F1_LOJA
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializa cariável com cálculo do processo                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lSTDif	:= .T.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se a nota original efetuou o cálculo do ST Diferenciado                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
		dbSelectArea( "SD2" )
		dbSetOrder ( 3 )		//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
		If !MsSeek( xFilial( "SD1" ) + SD1->( D1_NFORI + D1_SERIORI + D1_FORNECE + D1_LOJA + D1_COD + D1_ITEMORI ) )
			lSTDif	:= .F.
		Else
			If SD2->D2_YSPFIS <= 0
				lSTDif	:= .F.
			EndIf
		EndIf
		If !lSTDif
			dbSelectArea( "SD1" )
			dbSkip()
			Loop
		EndIf		
*/
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define os valores de base e icms substituição tributária                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nBasTot		+= SD1->D1_BRICMS
		nIcmTot		+= SD1->D1_ICMSRET
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ acumula array para ajuste do cabeçalho do livro fiscal                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nElem	:= aScan( aDadSF3, { |x| x[1] + Str( x[2], 5, 2 ) == SD1->D1_CF + Str( SD1->D1_PICM, 5, 2 ) } )
		If nElem == 0
			aAdd( aDadSF3, {	SD1->D1_CF,;
								SD1->D1_PICM,;
								SD1->D1_BRICMS,;
								SD1->D1_ICMSRET } )
		Else
			aDadSF3[nElem,03]	+= SD1->D1_BRICMS
			aDadSF3[nElem,04]	+= SD1->D1_ICMSRET
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ acumula array para ajuste do resumo do imposto                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nElem	:= aScan( aDadCD2, { |x| x[1] + x[2] == SD1->D1_ITEM + SD1->D1_COD } )
		If nElem == 0
			aAdd( aDadCD2, {	SD1->D1_ITEM,;
								SD1->D1_COD,;
								SD1->D1_BRICMS,;
								SD1->D1_ICMSRET,;
								SD1->D1_ALIQSOL,;
								SD1->D1_MARGEM,;
								SD1->D1_CLASFIS} )
		Else
			aDadCD2[nElem,03]	+= SD1->D1_BRICMS
			aDadCD2[nElem,04]	+= SD1->D1_ICMSRET
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Regrava os dados do item do livro fiscal                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "SFT" )
		dbSetOrder( 1 )		// FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO
		MsSeek( xFilial( "SFT" ) + "E" + SD1->( D1_SERIE + D1_DOC + D1_FORNECE + D1_LOJA + D1_ITEM + D1_COD ) )
		While !Eof() .And. SFT->FT_FILIAL == xFilial( "SFT" ) .And.;
							SFT->FT_TIPOMOV == "E" .And.;
							SFT->FT_SERIE == SD1->D1_SERIE .And.;
							SFT->FT_NFISCAL == SD1->D1_DOC .And.;
							SFT->FT_CLIEFOR == SD1->D1_FORNECE .And.;
							SFT->FT_LOJA == SD1->D1_LOJA .And.;
							SFT->FT_ITEM == SD1->D1_ITEM .And.;
							SFT->FT_PRODUTO == SD1->D1_COD
			nIcmOri			+= SFT->FT_ICMSRET
			dbSelectArea( "SFT" )
			RecLock( "SFT", .F. )
				SFT->FT_VALCONT	:= ( SFT->FT_VALCONT - SFT->FT_ICMSRET + SD1->D1_ICMSRET )
				SFT->FT_BASERET	:= SD1->D1_BRICMS
				SFT->FT_ICMSRET	:= SD1->D1_ICMSRET
			MsUnLock()
			dbSkip()
		End While						
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Houve o calculo para algum item                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lHasCalc	:= .T.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Proximo item da nota fiscal                                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "SD1" )
		dbSkip()
	End While
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Só executa se houve tratamento na nota fiscal de saída                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lHasCalc
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Regrava os dados do cabeçalho do livro fiscal                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "SF3" )
		dbSetOrder( 1 )		//F3_FILIAL+DTOS(F3_ENTRADA)+F3_NFISCAL+F3_SERIE+F3_CLIEFOR+F3_LOJA+F3_CFO+STR(F3_ALIQICM,5,2)
		For nLoop := 1 To Len ( aDadSF3 )
			If MsSeek( xFilial( "SF3" ) + DToS( SF1->F1_DTDIGIT ) + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA + aDadSF3[nLoop,1] + Str( aDadSF3[nLoop,2], 5, 2 ) )
				RecLock( "SF3", .F. )
					SF3->F3_VALCONT	:= ( SF3->F3_VALCONT - SF3->F3_ICMSRET + aDadSF3[nLoop,4] )
					SF3->F3_BASERET	:= aDadSF3[nLoop,3]
					SF3->F3_ICMSRET	:= aDadSF3[nLoop,4]
				MsUnLock()
			EndIf
		Next nLoop
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Regrava os dados do cabeçalho do livro fiscal                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "CD2" )
		dbSetOrder( 1 )		//CD2_FILIAL+CD2_TPMOV+CD2_SERIE+CD2_DOC+CD2_CODCLI+CD2_LOJCLI+CD2_ITEM+CD2_CODPRO+CD2_IMP
		For nLoop := 1 To Len ( aDadCD2 )
			If MsSeek( xFilial( "CD2" ) + "E" + SF1->F1_SERIE + SF1->F1_DOC + SF1->F1_FORNECE + SF1->F1_LOJA + aDadCD2[nLoop,1] + aDadCD2[nLoop,2] + "SOL" )
				RecLock( "CD2", .F. )
					CD2->CD2_BC		:= aDadCD2[nLoop,3]
					CD2->CD2_VLTRIB	:= aDadCD2[nLoop,4]
				MsUnLock()
			Else
				RecLock( "CD2", .T. )
					CD2->CD2_FILIAL	:= xFilial("SB2") 
					CD2->CD2_TPMOV	:= "E"
					CD2->CD2_SERIE	:= SF1->F1_SERIE
					CD2->CD2_CODCLI	:= SF1->F1_FORNECE
					CD2->CD2_LOJCLI	:= SF1->F1_LOJA
					CD2->CD2_ITEM	:= aDadCD2[nLoop,1]
					CD2->CD2_CODPRO	:= aDadCD2[nLoop,2]
					CD2->CD2_IMP	:= "SOL"
					CD2->CD2_ORIGEM	:= Substr(aDadCD2[nLoop,7],1,1) //Substr(D1_CLASFIS,1,1)
					CD2->CD2_CST	:= Substr(aDadCD2[nLoop,7],2,2) //Substr(D1_CLASFIS,2,2)
					CD2->CD2_MVA	:= aDadCD2[nLoop,6] //D1_MARGEM
					CD2->CD2_ALIQ	:= aDadCD2[nLoop,5] //D1_ALIQSOL
					CD2->CD2_DOC	:= SF1->F1_DOC
					CD2->CD2_FORMU	:= SF1->F1_FORMUL
					CD2->CD2_BC		:= aDadCD2[nLoop,3]
					CD2->CD2_VLTRIB	:= aDadCD2[nLoop,4]
				MsUnLock()
			EndIf
		Next nLoop
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Regrava os dados do cabeçalho do documento de entrada                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nVlrAux	:= SF1->F1_VALBRUT - nIcmOri + nIcmTot
		dbSelectArea( "SE1" )
		dbSetOrder( 1 )
		If MsSeek( xFilial( "SE1" ) + SF1->F1_PREFIXO + SF1->F1_DOC )
		While !Eof() .And. SE1->E1_FILIAL == xFilial( "SE1" ) .And.;
							SE1->E1_PREFIXO == SF1->F1_PREFIXO .And.;
							SE1->E1_NUM = SF1->F1_DOC
			If SE1->E1_TIPO == PadR( "NCC", TAMSX3( "E1_TIPO" )[1] )
				nRecAux	:= SE1->( RecNo() )
				nIndAux	:= SE1->E1_VALOR / SF1->F1_VALBRUT
				RecLock( "SE1", .F. )
					SE1->E1_VALOR	:= Round( ( SF1->F1_VALBRUT - nIcmOri + nIcmTot ) * nIndAux, TAMSX3( "E1_VALOR" )[1] )
					SE1->E1_SALDO	:= Round( ( SF1->F1_VALBRUT - nIcmOri + nIcmTot ) * nIndAux, TAMSX3( "E1_VALOR" )[1] )
					SE1->E1_VLCRUZ	:= Round( ( SF1->F1_VALBRUT - nIcmOri + nIcmTot ) * nIndAux, TAMSX3( "E1_VALOR" )[1] )
				MsUnLock()
				nVlrAux -= Round( ( SF1->F1_VALBRUT - nIcmOri + nIcmTot ) * nIndAux, TAMSX3( "E1_VALOR" )[1] )
			EndIf
			dbSelectArea( "SE1" )
			dbSkip()
		End While
		If nVlrAux <> 0
			dbSelectArea( "SE1" )
			dbGoTo( nRecAux )
			RecLock( "SE1", .F. )
				SE1->E1_VALOR	+= nVlrAux
				SE1->E1_SALDO	+= nVlrAux
				SE1->E1_VLCRUZ	+= nVlrAux
			MsUnLock()		
		EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Regrava os dados do cabeçalho do documento de entrada                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "SF1" )
		RecLock( "SF1", .F. )
			SF1->F1_VALBRUT	:= ( SF1->F1_VALBRUT - nIcmOri + nIcmTot )
		MsUnLock()
	EndIf
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravação do peso líquido e peso bruto                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SF1->F1_PBRUTO > 0
	//assume peso digitado
ELSE	
	cQry	:= " SELECT SUM(D1_QUANT*B1_PESO) PLIQUI, SUM(D1_QUANT*B1_PESBRU) PBRUT
	cQry	+= " FROM "+RetSqlname("SD1")+" A, "+RetSqlname("SB1")+" B
	cQry	+= " WHERE A.D_E_L_E_T_ = ' ' AND B.D_E_L_E_T_ = ' '
	cQry	+= " AND D1_FILIAL = '"+xFilial("SD1")+"' AND B1_FILIAL = '"+xFilial("SB1")+"'
	cQry	+= " AND D1_DOC = '"+SF1->F1_DOC+"' AND D1_SERIE = '"+SF1->F1_SERIE+"'
	cQry	+= " AND D1_FORNECE = '"+SF1->F1_FORNECE+"' AND D1_LOJA = '"+SF1->F1_LOJA+"' 
	cQry	+= " AND D1_COD = B1_COD
	IIf(Select(cAliasPB) > 0,(cAliasPB)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasPB  ,.F.,.T.)
	RECLOCK("SF1",.F.)
	SF1->F1_PBRUTO	:= iif( (cAliasPB)->PLIQUI>(cAliasPB)->PBRUT , (cAliasPB)->PLIQUI , (cAliasPB)->PBRUT )
	SF1->F1_PLIQUI	:= (cAliasPB)->PLIQUI
	MSUNLOCK()
	(cAliasPB)->(dbCloseArea())
EndIf

//Chama a rotina para efetuar o calculo do custo medio gerencial
u_GrvCMG(SF1->F1_DOC, SF1->F1_SERIE, SF1->F1_FORNECE, SF1->F1_LOJA)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura as areas originais                                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea( aAreaSD1 )
RestArea( aAreaSF3 )
RestArea( aAreaSFT )
RestArea( aAreaAtu )

Return( Nil )
