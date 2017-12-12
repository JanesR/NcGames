#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออัออออออออัออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ Programa    ณMA330FIMณ Ponto de entrada no final do processamento do recalculo custo  บฑฑ
ฑฑบ             ณ        ณ para executar a rotina de gera็ใo do custo m้dio gerencial PB9 บฑฑ
ฑฑฬอออออออออออออุออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Autor       ณ08/05/13ณ Almir Bandina                                                  บฑฑ
ฑฑฬอออออออออออออุออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Parโmetros  ณNil                                                                      บฑฑ
ฑฑฬอออออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Retorno     ณNil                                                                      บฑฑ
ฑฑฬอออออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Observa็๕es ณ                                                                         บฑฑ
ฑฑฬอออออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Altera็๕es  ณ99/99/99 - Consultor - Descri็ใo da altera็ใo                            บฑฑ
ฑฑศอออออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function RecCMVG()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define as variแveis da rotina                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aAreaAtu	:= GetArea()
Local cQry		:= ""
Local cArqQry	:= ""
Local dDatFec	:= GetMv("MV_ULMES")
Local cQueryPP	:= ""            
Local cArqPP	:= GetNextAlias()
Local aPP		:= {}

 
cQueryPP := " SELECT P05_CODPP, P05_DTAPLI, P05_DTEFET, P05_CODPRO, P06_LOCAL, P06_QUANT, P06_VLUNIT FROM "+RetSqlName("P05")+" P05 "+CRLF

cQueryPP += " INNER JOIN "+RetSqlName("P06")+" P06 "+CRLF
cQueryPP += " ON P06.D_E_L_E_T_ = ' ' "+CRLF
cQueryPP += " AND P06.P06_FILIAL = '"+xFilial("P06")+"' "+CRLF
cQueryPP += " AND P06.P06_CODPP = P05.P05_CODPP "+CRLF
cQueryPP += " AND P06.P06_LOCAL != ' ' "+CRLF

cQueryPP += " WHERE P05.D_E_L_E_T_ = ' ' "+CRLF
cQueryPP += " AND P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQueryPP += " AND P05.P05_DTEFET != ' ' "+CRLF
cQueryPP += " ORDER BY P05_CODPP, P06_LOCAL "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQueryPP), cArqPP , .F., .T.)


While (cArqPP)->(!Eof())
	
	//Executa a rotina para recalcular o Custo medio gerencial a partir do ultimo Processamento do CMVG na tabela PB9
	//U_ExisCMGPP( (cArqPP)->P05_CODPRO, (cArqPP)->P06_LOCAL, stod((cArqPP)->P05_DTAPLI), (cArqPP)->P06_VLUNIT, (cArqPP)->P05_CODPP, (cArqPP)->P06_QUANT )
	U_RExisCMGPP( (cArqPP)->P05_CODPRO, (cArqPP)->P06_LOCAL, (stod((cArqPP)->P05_DTAPLI)), (cArqPP)->P06_VLUNIT, (cArqPP)->P05_CODPP, (cArqPP)->P06_QUANT )
		
	(cArqPP)->(DbSkip())
EndDo

dbSelectArea(cArqPP) 
(cArqPP)->(DbCloseArea())


RestArea( aAreaAtu )
Return( Nil )


User Function ApuCusGer( cCodPro, cLocal, dDatIni, dDatFin, nQdeIni, nVlrIni, aPP, lEfetiva )

Local aAreaAtu	:= GetArea()
Local lAplPP	:= .F.
Local cQry		:= ""
Local cArqQry	:= GetNextAlias()
Local dDatAux	:= CToD( "  /  /  " )
Local nQuant	:= 0
Local nCusto	:= 0
Local nCMedio	:= 0

Default lEfetiva:= .T.

cQry	:= " SELECT SD1.D1_DTDIGIT DATMOV,SD1.D1_SEQCALC SEQUEN,SD1.D1_QUANT QDEENT,0 QDESAI,SD1.D1_CUSTO CUSFIS,"+CRLF
cQry	+= " (CASE WHEN SD1.D1_YCUSGER = 0 THEN SD1.D1_CUSTO ELSE SD1.D1_YCUSGER END) CUSENT,0 CUSSAI,'SD1' TIPO,SD1.D1_TES TIPMOV,'1' SEQPROC"+CRLF
cQry	+= " FROM " + RetSqlName( "SD1" ) + " SD1,"+CRLF
cQry	+= " " + RetSqlName( "SF4" ) + " SF4"+CRLF
cQry	+= " WHERE SD1.D1_FILIAL = '" + xFilial( "SD1" ) + "'"+CRLF
cQry	+= " AND SD1.D1_COD = '" + cCodPro + "'"+CRLF
cQry	+= " AND SD1.D1_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " AND SD1.D1_DTDIGIT BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"+CRLF
cQry	+= " AND SD1.D1_ORIGLAN <> 'LF'"+CRLF
cQry	+= " AND SD1.D_E_L_E_T_ = ' '"+CRLF
cQry	+= " AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "'"+CRLF
cQry	+= " AND SF4.F4_CODIGO = SD1.D1_TES"+CRLF
cQry	+= " AND SF4.F4_ESTOQUE = 'S'"+CRLF
cQry	+= " AND SF4.D_E_L_E_T_ = ' '"+CRLF
cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD2.D2_EMISSAO DATMOV,SD2.D2_SEQCALC SEQUEN,0 QDEENT,SD2.D2_QUANT QDESAI,SD2.D2_CUSTO1 CUSFIS,0 CUSENT,"+CRLF
cQry	+= " (CASE WHEN SD2.D2_YCMVG = 0 THEN SD2.D2_CUSTO1 ELSE SD2.D2_YCMVG END) CUSSAI, 'SD2' TIPO,SD2.D2_TES TIPMOV,'3' SEQPROC"+CRLF
cQry	+= " FROM " + RetSqlName( "SD2" ) + " SD2,"+CRLF
cQry	+= " " + RetSqlName( "SF4" ) + " SF4"+CRLF
cQry	+= " WHERE SD2.D2_FILIAL = '" + xFilial( "SD2" ) + "'"+CRLF
cQry	+= " AND SD2.D2_COD = '" + cCodPro + "'"+CRLF
cQry	+= " AND SD2.D2_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " AND SD2.D2_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"+CRLF
cQry	+= " AND SD2.D_E_L_E_T_ = ' '"+CRLF
cQry	+= " AND SF4.F4_FILIAL = '" + xFilial( "SF4" ) + "'"+CRLF
cQry	+= " AND SF4.F4_CODIGO = SD2.D2_TES"+CRLF
cQry	+= " AND SF4.F4_ESTOQUE = 'S'"+CRLF
cQry	+= " AND SF4.D_E_L_E_T_ = ' '"+CRLF
cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,SD3.D3_QUANT QDEENT,0 SAIDA,SD3.D3_CUSTO1 CUSFIS,"+CRLF
cQry	+= " (CASE WHEN SD3.D3_YCUSGER = 0 THEN SD3.D3_CUSTO1 ELSE SD3.D3_YCUSGER END) CUSENT,0 CUSSAI,'SD3E' TIPO,SD3.D3_TM TIPMOV,'2' SEQPROC"+CRLF
cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3"+CRLF
cQry	+= " WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "'"+CRLF
cQry	+= " AND SD3.D3_COD = '" + cCodPro + "'"+CRLF
cQry	+= " AND SD3.D3_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"+CRLF
cQry	+= " AND SD3.D3_TM <= '500'"+CRLF
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " AND D3_ESTORNO <> 'S'"+CRLF
EndIf
cQry	+= " AND SD3.D_E_L_E_T_ = ' '"+CRLF
cQry	+= " UNION ALL"+CRLF
cQry	+= " SELECT SD3.D3_EMISSAO DATMOV,SD3.D3_SEQCALC SEQUEN,0 QDEENT,SD3.D3_QUANT QDESAI,SD3.D3_CUSTO1 CUSFIS,0 CUSENT,"+CRLF
cQry	+= " (CASE WHEN SD3.D3_YCUSGER = 0 THEN SD3.D3_CUSTO1 ELSE SD3.D3_YCUSGER END) CUSSAI,'SD3S' TIPO,SD3.D3_TM TIPMOV,'4' SEQPROC"+CRLF
cQry	+= " FROM " + RetSqlName( "SD3" ) + " SD3"+CRLF
cQry	+= " WHERE SD3.D3_FILIAL = '" + xFilial( "SD3" ) + "'"+CRLF
cQry	+= " AND SD3.D3_COD = '" + cCodPro + "'"+CRLF
cQry	+= " AND SD3.D3_LOCAL = '" + cLocal + "'"+CRLF
cQry	+= " AND SD3.D3_EMISSAO BETWEEN '" + DToS( dDatIni ) + "' AND '" + DToS( dDatFin ) + "'"+CRLF
cQry	+= " AND SD3.D3_TM > '500'"+CRLF
If SuperGetMV('MV_D3ESTOR', .F., 'N') == 'N'
	cQry += " AND D3_ESTORNO <> 'S'"+CRLF
EndIf
cQry	+= " AND SD3.D_E_L_E_T_ = ' '"+CRLF
cQry	+= " ORDER BY DATMOV,SEQPROC"+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQry), cArqQry , .F., .T.)
TcSetField( cArqQry, "DATMOV", "D", 08, 00 )
TcSetField( cArqQry, "QDEENT", "N", 18, 02 )
TcSetField( cArqQry, "QDESAI", "N", 18, 02 )
TcSetField( cArqQry, "CUSENT", "N", 18, 02 )
TcSetField( cArqQry, "CUSSAI", "N", 18, 02 )

dbSelectArea( cArqQry )

nQuant	:= nQdeIni
nCusto	:= nVlrIni

While !Eof()
	dDatAux	:= (cArqQry)->DATMOV
	If !lAplPP
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se existe um PP para a data                                        ณ
		//ณ [1] = C๓digo do PP                                                          ณ
		//ณ [2] = Quantidade do PP                                                      ณ
		//ณ [3] = Valor Unitแrio do PP                                                  ณ
		//ณ [4] = Data de Aplica็ใo                                                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aPP	:= U_GetPP( cCodPro, cLocal, (cArqQry)->DATMOV, lEfetiva )
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Foi encontrato um Price Protection para o produto, local e data                 ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If Len( aPP ) <> 0 .And. aPP[3] <> 0
			lAplPP	:= .T.
			nCusto	-= Round( aPP[2] * aPP[3], TAMSX3("D1_CUSTO")[1] )
		EndIf
	EndIf
	nQuant	+= ( (cArqQry)->QDEENT - (cArqQry)->QDESAI )
	nCusto	+= ( (cArqQry)->CUSENT - (cArqQry)->CUSSAI )
	nCMedio	:= Round( nCusto / nQuant, TAMSX3( "B2_CM1" )[2] )
	dbSelectArea( "SB2" )
	dbSetOrder( 1 )
	If MsSeek( xFilial( "SB2" ) + cCodPro + cLocal )
		RecLock( "SB2" )
			SB2->B2_YCMVG	:= nCMedio
		MsUnLock()
	EndIf
	dbSelectArea( cArqQry )
	dbSkip()
	If ( !Eof() .And. (cArqQry)->DATMOV <> dDatAux .And. (cArqQry)->DATMOV > LastDay( dDatAux ) ) .Or.;
		( Eof() .And. dDatAux >= LastDay( dDatAux ) )
	
		GravaPB9( cCodPro, cLocal, dDatAux, nQuant, nCusto, nCMedio )
		
		lAplPP := .F.
	EndIf
	dbSelectArea( cArqQry )
End While

//Grava os saldos na tabela PB9 no ultimo dia do m๊s
While dDatAux <= dDatFin

	If (dDatAux == LastDay(dDatAux))
		GravaPB9( cCodPro, cLocal, dDatAux, nQuant, nCusto, nCMedio )
   	EndIf
	
	dDatAux := dDatAux + 1
EndDo		


RestArea( aAreaAtu )
Return( nCMedio )



Static Function GravaPB9( cCodPro, cLocal, dData, nQuant, nCusto, nCMedio )

Local aAreaAtu	:= GetArea()

dbSelectArea("PB9")
dbSetOrder(1)
If !MsSeek( xFilial("PB9") + cCodPro + cLocal + DToS( dData ) )
	Reclock( "PB9", .T. )
	PB9->PB9_FILIAL := xFilial("PB9")
	PB9->PB9_COD	:= cCodPro
	PB9->PB9_LOCAL	:= cLocal
	PB9->PB9_DATA	:= dData
Else
	RecLock( "PB9", .F. )
EndIf

PB9->PB9_QINI   := nQuant
PB9->PB9_CM1 	:= nCMedio
PB9->PB9_VINI1	:= nCusto

PB9->(MsUnLock())	

RestArea( aAreaAtu )

Return( Nil )
