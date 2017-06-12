#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"

// Variável de controle para avaliar o PP no pr
STATIC dDatRef		:= mv_par01
STATIC cCodPro		:= ""
STATIC nQdeAuxBR	:= 0
STATIC nVlrAuxBR	:= 0      
STATIC nQdeAuxPP	:= 0
STATIC nVlrAuxPP	:= 0      
STATIC cCodPPUsad	:= " "//Armazena os dados do PP já utilizados   
STATIC l1PP			:= .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MC030ARR  ºAutor  ³Microsiga           º Data ³  16/03/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponte de entrada para incluir dados do custo gerencial     º±±
±±º          ³ no Kardex                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP       	                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MC030ARR()

Local aParam1	:= PARAMIXB[1]//Array com os dados da linha a ser listada no kardex
Local aParam2	:= PARAMIXB[2]//Nome da tabela posicionada
Local aSaldos	:= {}
							

//Apura o saldo gerencial na data
If Len( aTrbTmp ) == 0
    
	//Zera as variaveis staticas
	nQdeAuxBR	:= 0
	nVlrAuxBR	:= 0      
	nQdeAuxPP	:= 0
	nVlrAuxPP	:= 0      
	cCodPPUsad	:= ""    
	l1PP		:= .T.    

	//Saldo inicial no dia (CMG)
	aSaldos		:= u_GetEstBR(SB2->B2_COD, mv_par03, mv_par01)
	nQdeAuxBR	:= aSaldos[1]
	nVlrAuxBR	:= aSaldos[2]
	cCodPro		:= SB2->B2_COD
		
Endif


//Inclui as colunas do CMG BR no array do Kardex
aAdd( aParam1, "" )
aAdd( aParam1, 0 )
aAdd( aParam1, 0 )

//Inclui as colunas do CMG PP no array do Kardex
aAdd( aParam1, "" )
aAdd( aParam1, 0 )
aAdd( aParam1, 0 )


//Efetua o preenchimento do custo gerencial
aParam1 := GetCMGBR(aParam1, aParam2)

//Atualiza o array de retorno com os dados
aRetorno	:= aParam1

Return( aRetorno )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetCMGBR  ºAutor  ³Microsiga           º Data ³  16/03/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para retornar o Custo Gerencial 		  º±±
±±º          ³ 				                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP       	                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCMGBR(aParam1, cAliasMov)

Local aArea := GetArea()
Local aRet	:= {}
Local aPP	:= {}
Local nX	:= 0
Local nY	:= 0
Local aAux	:= {}


Default aRet 		:= {}
Default cAliasMov   := "" 

//Recebe o Array com os dados do Kardex
aRet := aParam1

//Preenchimento da linha do Kardex, com os dados movimento
If ValType( aRet[1] ) == "D"
	
	aPP	:= {}

	//Verifica se Existe PP para a data
	aPP		:= U_GetPP( cCodPro, mv_par03, mv_par01, aRet[1], cCodPPUsad )
	
	//Preenche o kardex com os dados do Price Protection
	If Len(aPP) > 0 
		
		For nX := 1 To Len(aPP)
			
			//Atualiza a variave statica com os numeros de documento do Price Protection já utilizados no Kardex
			cCodPPUsad	+= aPP[nX][1]+mv_par03+"|"
			
			//Guarda a linha com o ultimo saldo
			aAux :=  Aclone(aTrbTmp[Len( aTrbTmp )])
			
			//Adiciona a linha com o Price Protection
			aAdd( aTrbTmp	, {aPP[nX][4],;																					// 01-Data da Digitação
								" ",;																							// 02-Código da TES
								" ",;																							// 03-CFOP do movimento
								aPP[nX][1],;																					// 04-Número do documento (Alterar para o número do PP)
								" ",;																							// 05-Vazio
								" ",;																							// 06-Vazio
								"P.Protection",;			 																	// 07-Id do Movimento
								Transform( 0, cPictQT ),;																		// 08-Quantidade do Movimento no formato caracter
								Transform( 0, PesqPict( "SB2", "B2_CM1" ) ),; 													// 09-Valor Custo Médio Unitário no formato caracter
								Transform( 0, PesqPict( "SD1", "D1_CUSTO" ) ),;													// 10-Valor Custo Médio Total no formato caracter
								"",;																							// 11-Lote de Controle
								"",;																							// 12-Sub-Lote de Controle
								"",;																							// 13-Flag BR
								Transform( 0, PesqPict( "SD1", "D1_CUSTO" ) )	,; 												// 14-Custo Unitario BR
								Transform( 0, PesqPict( "SD1", "D1_CUSTO" ) ), ;												// 15-Custo Total BR
								"",;	                                                                                        // 16-Flag PP
								Transform( aPP[nX][3], PesqPict( "SD1", "D1_CUSTO" ) ),; 										// 17-Custo Unitario PP
								Transform( aPP[nX][3] * aPP[nX][2], PesqPict( "SD1", "D1_CUSTO" ) ),;                           // 18-Custo Total PP
							} )
							
			//Efetua o calculo do CMG PP
			If l1PP //Verifica se é o primeiro PP
				nVlrAuxPP	:= nVlrAuxBR //Recebe o valor do CMG BR
				nVlrAuxPP	-= round((aPP[nX][3] * aPP[nX][2]), TAMSX3("B2_YTCMGBR")[2])//Aplica Price Protection (CMG BR - CMG PP)
				l1PP		:= .F.
			Else
				nVlrAuxPP	-= round((aPP[nX][3] * aPP[nX][2]), TAMSX3("B2_YTCMGBR")[2])//Aplica o Price Protection
			EndIf
			
			//Adiciona a linha de saldos considerando o CMG
			If mv_par04 == 1
				
				//Adicona dados no final do array caso se necessário
				If Len(aAux) < 15
					For nY := 1 To Len(aAux)
						Aadd(aAux, "")
					Next
				EndIf
				
				aAdd( aTrbTmp, aAux )
				
				//Linha de saldos CMG BR
				aTrbTmp[Len( aTrbTmp ), 14]	:= Transform( nVlrAuxBR / nQdeAuxBR , PesqPict( "SB2", "B2_CM1" ) )
				aTrbTmp[Len( aTrbTmp ), 15]	:= Transform( nVlrAuxBR, PesqPict( "SD1", "D1_CUSTO" ) )


				//Linha de saldos CMG PP
				aTrbTmp[Len( aTrbTmp ), 17]	:= Transform( nVlrAuxPP / nQdeAuxPP , PesqPict( "SB2", "B2_CM1" ) )
				aTrbTmp[Len( aTrbTmp ), 18]	:= Transform( nVlrAuxPP, PesqPict( "SD1", "D1_CUSTO" ) )
				
			EndIf
			
		Next
		
	EndIf
	
	
	If Alltrim(cAliasMov) == "SD1"   
		//CMG BR
		aRet[14]	:= Transform( SD1->D1_YCMGBR / SD1->D1_QUANT, PesqPict( "SB2", "B2_CM1" ) )
		aRet[15]	:= Transform( SD1->D1_YCMGBR, PesqPict( "SD1", "D1_CUSTO" ) )
		
		nQdeAuxBR	+= SD1->D1_QUANT
		nVlrAuxBR	+= SD1->D1_YCMGBR
        
	    
		//CMG PP
		aRet[17]	:= Transform( SD1->D1_YCUSGER / SD1->D1_QUANT, PesqPict( "SB2", "B2_CM1" ) )
		aRet[18]	:= Transform( SD1->D1_YCUSGER, PesqPict( "SD1", "D1_CUSTO" ) )
		
		nQdeAuxPP	+= SD1->D1_QUANT
		nVlrAuxPP	+= SD1->D1_YCUSGER

		
	ElseIf Alltrim(cAliasMov) == "SD2"
		
		//CMG BR
		aRet[14]	:= Transform( SD2->D2_YCMGBR / SD2->D2_QUANT, PesqPict( "SB2", "B2_CM1" ) )
		aRet[15]	:= Transform( SD2->D2_YCMGBR, PesqPict( "SD2", "D2_CUSTO1" ) )
        
        If nQdeAuxBR != 0
			nVlrAuxBR	-= (nVlrAuxBR / nQdeAuxBR) * SD2->D2_QUANT
			nQdeAuxBR	-= SD2->D2_QUANT
		Else
			nVlrAuxBR	-= SD2->D2_YCMGBR
			nQdeAuxBR	-= SD2->D2_QUANT
		EndIf
		
		
		//CMG PP
		aRet[17]	:= Transform( SD2->D2_YCMVG / SD2->D2_QUANT, PesqPict( "SB2", "B2_CM1" ) )
		aRet[18]	:= Transform( SD2->D2_YCMVG, PesqPict( "SD2", "D2_CUSTO1" ) )
        
        If nQdeAuxPP != 0
			nVlrAuxPP	-= (nVlrAuxPP / nQdeAuxPP) * SD2->D2_QUANT
			nQdeAuxPP	-= SD2->D2_QUANT
		Else
			nVlrAuxPP	-= SD2->D2_YCMVG
			nQdeAuxPP	-= SD2->D2_QUANT
		EndIf

		
		
	ElseIf Alltrim(cAliasMov) == "SD3"
		
		//CMG BR
		If SD3->D3_QUANT != 0
			aRet[14]	:= Transform( SD3->D3_YCMGBR / SD3->D3_QUANT, PesqPict( "SB2", "B2_CM1" ) )
		Else                                                                                       
			aRet[14]	:= Transform( SD3->D3_YCMGBR, PesqPict( "SB2", "B2_CM1" ) )
		EndIf

		aRet[15]	:= Transform( SD3->D3_YCMGBR, PesqPict( "SD3", "D3_CUSTO1" ) )

		
		If SD3->D3_TM > "500"//Saida  
			
			If nQdeAuxBR != 0
				If SD3->D3_QUANT != 0
					nVlrAuxBR	-= (nVlrAuxBR / nQdeAuxBR) * SD3->D3_QUANT
					nQdeAuxBR	-= SD3->D3_QUANT
				Else
					nVlrAuxBR	-= SD3->D3_CUSTO1
				EndIf
            Else
				nVlrAuxBR	-= SD3->D3_YCMGBR
				nQdeAuxBR	-= SD3->D3_QUANT
            EndIf	

		Else//Entrada
			nQdeAuxBR	+= SD3->D3_QUANT
			nVlrAuxBR	+= SD3->D3_YCMGBR
		EndIf


		
		//CMG PP
		If SD3->D3_QUANT != 0
			aRet[17]	:= Transform( SD3->D3_YCUSGER / SD3->D3_QUANT, PesqPict( "SB2", "B2_CM1" ) )
		Else
			aRet[17]	:= Transform( SD3->D3_YCUSGER, PesqPict( "SB2", "B2_CM1" ) )		
		EndIf

		aRet[18]	:= Transform( SD3->D3_YCUSGER, PesqPict( "SD3", "D3_CUSTO1" ) )
		
		If SD3->D3_TM > "500"//Saida  
			
			If nQdeAuxPP != 0
				If SD3->D3_QUANT
					nVlrAuxPP	-= (nVlrAuxPP / nQdeAuxPP) * SD3->D3_QUANT 
					nQdeAuxPP	-= SD3->D3_QUANT
				Else
					nVlrAuxPP	-= SD3->D3_YCMGBR
				EndIf
            Else
				nVlrAuxPP	-= SD3->D3_YCUSGER
				nQdeAuxPP	-= SD3->D3_QUANT
            EndIf	

		Else//Entrada
			nQdeAuxPP	+= SD3->D3_QUANT
			nVlrAuxPP	+= SD3->D3_YCUSGER
			
		EndIf
		
		
	EndIf
	
Else
	//Linha de saldos CMG BR
	aRet[14]	:= Transform( nVlrAuxBR / nQdeAuxBR , PesqPict( "SB2", "B2_CM1" ) )
	aRet[15]	:= Transform( nVlrAuxBR, PesqPict( "SD1", "D1_CUSTO" ) )
	
	//Linha de saldos CMG PP
	aRet[17]	:= Transform( nVlrAuxPP / nQdeAuxPP , PesqPict( "SB2", "B2_CM1" ) )
	aRet[18]	:= Transform( nVlrAuxPP, PesqPict( "SD1", "D1_CUSTO" ) )	
EndIf

RestArea(aArea)
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetEstBR  ºAutor  ³Microsiga           º Data ³  16/03/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para retornar o Custo Gerencial BR 		  º±±
±±º          ³ de acordo com a data informada                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP       	                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GetEstBR(cCodPro, cLocal, dDtRef)

Local aArea	:= GetArea()
Local aFechAux	:= {}                           
Local dDataIni	:= CTOD('')
Local aRet		:= {}
Local dDtIniCMGBR 	:= U_MyNewSX6("NC_DTIMGBR",;
								"20130801",;
								"D",;
								"Data inicial do CMG BR",;
								"Data inicial do CMG BR",;
								"Data inicial do CMG BR",;
								.F. )


If dDtRef >= dDtIniCMGBR 
	dDataIni := dDtIniCMGBR 
Else 
	dDataIni := dDtRef 
EndIf

aFechAux := CalcEst( cCodPro, cLocal, dDataIni )
aRet := GetCEstBr( dDataIni, dDtRef-1, cCodPro, cLocal, aFechAux[1], aFechAux[2])

If Len(aRet) < 3
	aRet := {0,0,0}
EndIf

RestArea(aArea)
Return aRet


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GetCEstBr	  ³ Autor ³ELTON SANTANA	   ³ Data ³ 11/10/11  ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o valor do custo medio gerencial BR na data		  ³±±
±±³			 ³ 												  			  ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetCEstBr( dDatIni, dDatFin, cCodPro, cLocal, nQdeIni, nVlrIni)

Local aAreaAtu	:= GetArea()
Local cQry		:= ""
Local cArqQry	:= GetNextAlias()
Local nQuant	:= 0
Local nCusto	:= 0
Local aRet		:= {}

Default dDatIni := CTOD('')
Default dDatFin := CTOD('')
Default cCodPro	:= "" 
Default cLocal	:= "" 
Default nQdeIni	:= 0 
Default nVlrIni	:= 0 



cQry	:= " SELECT SD1.D1_DTDIGIT DATMOV,SD1.D1_SEQCALC SEQUEN,SD1.D1_QUANT QDEENT,0 QDESAI,SD1.D1_CUSTO CUSFIS, "+CRLF

cQry	+= " (CASE WHEN SD1.D1_YCMGBR != 0 "+CRLF
cQry	+= " 			THEN SD1.D1_YCMGBR "+CRLF
cQry	+= " 		ELSE SD1.D1_CUSTO   "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF

cQry	+= " 0 CUSSAIBR,'SD1' TIPO,SD1.D1_TES TIPMOV,'1' SEQPROC, SD1.D1_LOCAL ARMAZEM, SD1.R_E_C_N_O_ NC_RECNO "+CRLF


cQry	+= " FROM " + RetSqlName( "SD1" ) + " SD1, "+RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD1.D1_FILIAL = '" + xFilial( "SD1" ) + "'"+CRLF
cQry	+= " 		AND SD1.D1_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD1.D1_LOCAL = '" + cLocal + "' "+CRLF
cQry	+= " 		AND SD1.D1_DTDIGIT  BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD1.D1_ORIGLAN <> 'LF' "+CRLF
cQry	+= " 		AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD1.D1_TES "+CRLF
cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' "+CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF 
cQry	+= " SELECT SD2.D2_EMISSAO DATMOV,SD2.D2_SEQCALC SEQUEN,0 QDEENT,SD2.D2_QUANT QDESAI,SD2.D2_CUSTO1 CUSFIS, 0 CUSENTBR, " +CRLF

cQry	+= " (CASE WHEN SD2.D2_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD2.D2_YCMGBR "+CRLF
cQry	+= " 	ELSE SD2.D2_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF

cQry	+= " 'SD2' TIPO,SD2.D2_TES TIPMOV,'3' SEQPROC, SD2.D2_LOCAL ARMAZEM, SD2.R_E_C_N_O_ NC_RECNO  "+CRLF

cQry	+= " FROM " + RetSqlName( "SD2" ) + " SD2, "+ RetSqlName( "SF4" ) + " SF4 "+CRLF
cQry	+= " 		WHERE SD2.D2_FILIAL = '" + xFilial( "SD2" ) + "' "+CRLF
cQry	+= " 		AND SD2.D2_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD2.D2_LOCAL = '" + cLocal + "' "+CRLF
cQry	+= " 		AND SD2.D2_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD2.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " 		AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "' "+CRLF
cQry	+= " 		AND SF4.F4_CODIGO = SD2.D2_TES " +CRLF
cQry	+= " 		AND SF4.F4_ESTOQUE = 'S' " +CRLF
cQry	+= " 		AND SF4.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL "+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,SD3.D3_QUANT QDEENT,0 SAIDA,SD3.D3_CUSTO1 CUSFIS, "+CRLF


cQry	+= " (CASE WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSENTBR, "+CRLF

cQry	+= " 0 CUSSAIBR,'SD3E' TIPO,SD3.D3_TM TIPMOV,'2' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3 "+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "'"+CRLF
cQry	+= " 		AND SD3.D3_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "' "
cQry	+= " 		AND SD3.D3_TM <= '500' "+CRLF
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S' "+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF

cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,0 QDEENT,SD3.D3_QUANT QDESAI,SD3.D3_CUSTO1 CUSFIS, 0 CUSENTBR,"+CRLF

cQry	+= " (CASE WHEN SD3.D3_YCMGBR != 0 "+CRLF
cQry	+= " 		THEN SD3.D3_YCMGBR "+CRLF
cQry	+= " 	ELSE SD3.D3_CUSTO1 "+CRLF
cQry	+= " END) CUSSAIBR, "+CRLF
cQry	+= " 'SD3S' TIPO,SD3.D3_TM TIPMOV,'4' SEQPROC, SD3.D3_LOCAL ARMAZEM, SD3.R_E_C_N_O_ NC_RECNO  "+CRLF

cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3"+CRLF
cQry	+= " 		WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "' "+CRLF
cQry	+= " 		AND SD3.D3_COD = '" + cCodPro + "' "+CRLF
cQry	+= " 		AND SD3.D3_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " 		AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"
cQry	+= " 		AND SD3.D3_TM > '500'"+CRLF

If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " 		AND D3_ESTORNO <> 'S'"+CRLF
EndIf
cQry	+= " 		AND SD3.D_E_L_E_T_ = ' ' "+CRLF
cQry	+= " ORDER BY SEQUEN "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQry), cArqQry , .F., .T.)

TcSetField( cArqQry, "DATMOV", "D", 08, 00 )
TcSetField( cArqQry, "CUSFIS", "N", 18, 02 )
TcSetField( cArqQry, "QDEENT", "N", 18, 02 )
TcSetField( cArqQry, "QDESAI", "N", 18, 02 )
TcSetField( cArqQry, "CUSENTBR", "N", 18, 02 )
TcSetField( cArqQry, "CUSSAIBR", "N", 18, 02 )

//Preenchiemnto do valores iniciais
nQuant	:= nQdeIni
nCusto	:= nVlrIni

While (cArqQry)->(!Eof())
	
	//Calculo do custo gerencial
	nQuant	+= ( (cArqQry)->QDEENT - (cArqQry)->QDESAI )
	nCusto	+= ((cArqQry)->CUSENTBR - (cArqQry)->CUSSAIBR )

	(cArqQry)->(DbSkip())
EndDo

If nQuant != 0
	aRet := {nQuant, nCusto, round(nCusto / nQuant, TAMSX3("B2_YCMGBR")[2])}
Else
	aRet := {0, 0, round(0, TAMSX3("B2_YCMGBR")[2])}
EndIf

(cArqQry)->(DbCloseArea())

RestArea( aAreaAtu )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetPP		ºAutor  ³Microsiga           º Data ³  16/03/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina utilizada para retornar o Custo Gerencial 		  º±±
±±º          ³ 				                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP       	                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GetPP( cCodPro, cArmazem, dDtIni, dDtFin, cCodPPUsad )

Local aAreaAtu 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}


Default cCodPro		:= ""
Default cArmazem	:= "" 
Default dDtIni		:= CTOD('')
Default dDtFin		:= CTOD('')
Default cCodPPUsad	:= ""

cQuery := " SELECT P05_DTAPLI, P05_CODPP, P06_LOCAL, P06_VLUNIT, P06_QUANT "+CRLF
cQuery += " FROM "+RetSqlName("P05")+" P05"+CRLF

cQuery += " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQuery += " ON P06.P06_FILIAL = '" + xFilial( "P06" ) + "' "+CRLF
cQuery += " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF 
cQuery += " AND P06.P06_CODPRO = '"+cCodPro+"' "+CRLF
cQuery += " AND P06.P06_LOCAL = '"+cArmazem+"' "+CRLF

If !Empty(cCodPPUsad)
	cQuery += " AND (P06.P06_CODPP || P06.P06_LOCAL) NOT IN"+FormatIn(cCodPPUsad, "|")+CRLF 
EndIf

cQuery += " AND P06.D_E_L_E_T_ = ' ' "+CRLF


cQuery += " WHERE P05.P05_FILIAL = '" + xFilial( "P05" ) + "' "+CRLF
cQuery += " AND P05.P05_DTAPLI BETWEEN '"+dtos(dDtIni)+"' AND  '"+dtos(dDtFin)+"' "+CRLF
cQuery += " AND P05.P05_DTEFET != ' ' " +CRLF
cQuery += " AND P05.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " ORDER BY P05_DTAPLI "+CRLF

cQuery := ChangeQuery(cQuery) 

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

While (cArqTmp)->(!Eof())
	Aadd(aRet ,{ (cArqTmp)->P05_CODPP, (cArqTmp)->P06_QUANT, (cArqTmp)->P06_VLUNIT, SToD( P05_DTAPLI ) })

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea( aAreaAtu )
Return aRet
