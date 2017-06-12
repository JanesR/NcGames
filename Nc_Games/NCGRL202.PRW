#INCLUDE "PROTHEUS.CH"

#Define Enter Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL202  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß  
*/

User Function NCGRL202()
Local aSays:={}
Local aButtons:={}
Local cPerg:="NCGRL202"
Local lOk:=.F.
Local cCadastro:="Relatorio Estorno "

Private nHdl
Private cPathExcel  := ""
Private cExtExcel   := ".xml"       

Private cValMidICM	:= GetCtParam("NC_VLMDICM",;
  										"9.6",;
										"C",;
										"Valor da midia do ICMS",;
										"Valor da midia do ICMS",;
										"Valor da midia do ICMS",;
										.F. )

Private cValMidIPI	:= GetCtParam("NC_VLMDIPI",;
  										"4.8",;
										"C",;
										"Valor da midia do ICMS",;
										"Valor da midia do ICMS",;
										"Valor da midia do ICMS",;
										.F. )


PutSx1(cPerg,"01","Filial De?                    ","Filial De?                    ","Filial De?                    ","MV_CH1","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20201.")
PutSx1(cPerg,"02","Filial Até?                   ","Filial Até?                   ","Filial Até?                   ","MV_CH2","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20202.")
PutSx1(cPerg,"03","Data Entrada De?              ","Data Entrada De?              ","Data Entrada De?              ","MV_CH3","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20203.")
PutSx1(cPerg,"04","Data Entrada Até?             ","Data Entrada Até?             ","Data Entrada Até?             ","MV_CH4","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20204.")
PutSx1(cPerg,"05","Da Emissão De?                ","Da Emissão De?                ","Da Emissão De?                ","MV_CH5","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20205.")
PutSx1(cPerg,"06","Da Emissão Até?               ","Da Emissão Até?               ","Da Emissão Até?               ","MV_CH6","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20206.")
PutSx1(cPerg,"07","Da NCM De?                    ","Da NCM De?                    ","Da NCM De?                    ","MV_CH7","C",10,0,0,"G","                                                            ","SYD   ","   "," ","MV_PAR07","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20207.")
PutSx1(cPerg,"08","Da NCM Até?                   ","Da NCM Até?                   ","Da NCM Até?                   ","MV_CH8","C",10,0,0,"G","                                                            ","SYD   ","   "," ","MV_PAR08","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20208.")
PutSx1(cPerg,"09","Estorno Software              ","Estorno Software              ","Estorno Software              ","MV_CH9","N",1,0,1,"C","                                                            ","      ","   "," ","MV_PAR09","Estorno IPI    ","               ","               ","                                                            ","Estorno ICMS   ","               ","               ","Estorno ICMS ST","               ","               ","               ","               ","               ","               ","               ","          ",{},"","",".NCGRL20209.")



Pergunte(cPerg, .f.)

AADD( aSays, "Estorno Software de Entrada IPI,ICMS e ICMS-ST             " )

aAdd( aButtons, { 05, .T., {|| Pergunte( cPerg, .t. ) } } )
AADD( aButtons, { 01, .T., {|| lOk := .T.,(cPathExcel:=cGetFile( "Defina o diretório | ",OemToAnsi("Selecione Diretorio de Gravação da Planilha"), ,"" ,.f.,GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE) ) ,Iif( !Empty(cPathExcel), FechaBatch(), msgStop("Informe o diretorio de gravaçao da planilha") ) } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )

;FormBatch( cCadastro, aSays, aButtons )

If lOk
	Processa({ || RL202Filter()})
EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL202  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL202Filter()
Local cAliasQry:=GetNextAlias()
Local cQuery
Local dDataEmiss:=CTOD("01/02/2011")
Local cLine:=""
Local nContTot
Local cCpoQry
Local aTotal:={}
Local nInd
Local cAliasQry2 := ""
Local cCFOPAtu	 := ""
Local aCFOP		 := {}        
Local aEstado	 := {}
Local cEstAtu	 := ""
Local nX		 := 0
Local nAliqInt	 := 0
Local nIVA		 := 0


Private cPathArq:=StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Private cArqXls:=E_Create(,.F.)


cQuery:=RL202Query("Count(1) Contar","")
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)
nContTot:=(cAliasQry)->Contar
(cAliasQry)->(DbCloseArea())
ProcRegua(nContTot+2)

nHdl := FCreate(cPathArq+cArqXls+cExtExcel)

//Preenchimento do cabeçalho
cLine:=RL202Cabec({nContTot})

//Escreve o cabeçalho no arquivo
RL202Write(cLine)


cCpoQry:="FT_FILIAL,FT_MARGEM,FT_ENTRADA,FT_EMISSAO,FT_NFISCAL,FT_SERIE,FT_ESTADO,FT_CFOP,FT_ALIQICM,FT_VALCONT,FT_BASEICM,FT_VALICM,FT_BASEIPI,FT_VALIPI"
cCpoQry+=",FT_BASERET,FT_ICMSRET,FT_DTCANC,FT_DESPESA,FT_POSIPI,FT_QUANT,FT_PRCUNIT,FT_DESCONT,FT_TOTAL,FT_NFORI,FT_SERORI,FT_ITEMORI,"
cCpoQry+="FT_CLIEFOR,FT_LOJA,FT_PRODUTO, B1_GRTRIB, B1_ORIGEM "
cQuery:=RL202Query(cCpoQry," Order By SFT.FT_ENTRADA,SFT.FT_NFISCAL,SFT.FT_SERIE")
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)

TcSetField( cAliasQry, "FT_ENTRADA", "D", 8, 0 )
TcSetField( cAliasQry, "FT_EMISSAO", "D", 8, 0 )
TcSetField( cAliasQry, "FT_DTCANC", "D", 8, 0 )

If mv_par09==1
	SF2->(DbSetOrder(1))
	Do While (cAliasQry)->(!Eof())
		
		IncProc("Processando...")
		
		
		If !SF2->(DbSeek ( (cAliasQry)->( FT_FILIAL+FT_NFORI+FT_SERORI+FT_CLIEFOR+FT_LOJA)  )  )
			SF2->(DbSeek ( (cAliasQry)->( FT_FILIAL+FT_NFORI+Padr( Val((cAliasQry)->FT_SERORI),Len((cAliasQry)->FT_SERORI))+FT_CLIEFOR+FT_LOJA)  )  )
		EndIf
		
		cLine:='   <Row ss:AutoFitHeight="0">'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_FILIAL+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry)->FT_ENTRADA)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry)->FT_EMISSAO)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_NFISCAL+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_ESTADO+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_CFOP+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_ALIQICM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALCONT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASEICM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALICM)+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASEIPI)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALIPI)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASERET)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_ICMSRET)+'</Data></Cell>'+Enter
		
		If Empty ( (cAliasQry)->FT_DTCANC )
			cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
		Else
			cLine+='    <Cell><Data ss:Type="String">'+RL202Trans((cAliasQry)->FT_DTCANC)+'</Data></Cell>'+Enter
		EndIf
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_PRODUTO+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_DESPESA)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_POSIPI+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_QUANT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_PRCUNIT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_DESCONT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_TOTAL)+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_NFORI+'</Data></Cell>'+Enter
		
		If Empty(SF2->F2_EMISSAO)
			cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
		Else
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans(SF2->F2_EMISSAO)+'</Data></Cell>'+Enter
		EndIf
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_MARGEM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+cValMidICM+'</Data></Cell>'+Enter
		
		cLine+='    <Cell ss:Formula="=IF(RC[-7]&lt;RC[-1],(RC[-7]/2)*RC[-8],RC[-1]*RC[-8])"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-20]-RC[-7]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-23]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-24]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-25]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-10]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-29]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-30]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[8]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		
		cLine+='    <Cell ss:Index="40"><Data ss:Type="Number">0.15</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+cValMidIPI+'</Data></Cell>'+Enter
		
		
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=IF(RC[-22]&lt;RC[-1],(RC[-22]/2)*RC[-23],RC[-1]*RC[-23])"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-21]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-4]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-5]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String"></Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->B1_GRTRIB+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->B1_ORIGEM+'</Data></Cell>'+Enter
		cLine+='   </Row>'+Enter
		
		RL202Write(cLine)
		
		If mv_par09==1
			If Ascan(aTotal,(cAliasQry)->FT_POSIPI)==0
				AAdd(aTotal,(cAliasQry)->FT_POSIPI)
			EndIf
		EndIf
		
		(cAliasQry)->(DbSkip())
	EndDo
	
	
ElseIf mv_par09==2
	
	//Preenche os dados da aba original
	SF2->(DbSetOrder(1))
	Do While (cAliasQry)->(!Eof())
		
		IncProc("Processando...")

		If !SF2->(DbSeek ( (cAliasQry)->( FT_FILIAL+FT_NFORI+FT_SERORI)  )  )
			SF2->(DbSeek ( (cAliasQry)->( FT_FILIAL+FT_NFORI+Padr( Val((cAliasQry)->FT_SERORI),Len((cAliasQry)->FT_SERORI)))  )  )
		EndIf
		
		
		If  !Empty(SF2->F2_EMISSAO) .And. !SF2->F2_EMISSAO >= dDataEmiss
			(cAliasQry)->(DbSkip())
			Loop
		EndIf

		cLine:='   <Row ss:AutoFitHeight="0">'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_FILIAL+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry)->FT_ENTRADA)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry)->FT_EMISSAO)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_NFISCAL+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_ESTADO+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_CFOP+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_ALIQICM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALCONT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASEICM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALICM)+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASEIPI)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALIPI)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASERET)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_ICMSRET)+'</Data></Cell>'+Enter
		
		If Empty ( (cAliasQry)->FT_DTCANC )
			cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
		Else
			cLine+='    <Cell><Data ss:Type="String">'+RL202Trans((cAliasQry)->FT_DTCANC)+'</Data></Cell>'+Enter
		EndIf
		
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_PRODUTO+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_DESPESA)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_POSIPI+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_QUANT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_PRCUNIT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_DESCONT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_TOTAL)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_NFORI+'</Data></Cell>'+Enter
		
		If Empty(SF2->F2_EMISSAO)
			cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
		Else
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans(SF2->F2_EMISSAO)+'</Data></Cell>'+Enter
		EndIf
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_MARGEM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+cValMidICM+'</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=IF(RC[-7]&lt;RC[-1],(RC[-7]/2)*RC[-8],RC[-1]*RC[-8])"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-20]-RC[-7]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-23]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-24]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-25]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-10]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-29]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-30]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[8]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Index="40"><Data ss:Type="Number">0.15</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+cValMidIPI+'</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=IF(RC[-22]&lt;RC[-1],(RC[-22]/2)*RC[-23],RC[-1]*RC[-23])"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-21]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-4]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-5]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String"></Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->B1_GRTRIB+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->B1_ORIGEM+'</Data></Cell>'+Enter
		cLine+='   </Row>'+Enter
		
		RL202Write(cLine)
		
		(cAliasQry)->(DbSkip())
	EndDo
	
	cLine:='   </Table>'+Enter
	cLine+='   <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
	cLine+='    <PageSetup>'+Enter
	cLine+='     <Header x:Margin="0.31496062000000002"/>'+Enter
	cLine+='     <Footer x:Margin="0.31496062000000002"/>'+Enter
	cLine+='     <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
	cLine+='      x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
	cLine+='    </PageSetup>'+Enter
	cLine+='    <Unsynced/>'+Enter
	cLine+='    <Print>'+Enter
	cLine+='     <ValidPrinterInfo/>'+Enter
	cLine+='     <PaperSizeIndex>9</PaperSizeIndex>'+Enter
	cLine+='     <HorizontalResolution>600</HorizontalResolution>'+Enter
	cLine+='     <VerticalResolution>600</VerticalResolution>'+Enter
	cLine+='    </Print>'+Enter
	cLine+='    <Panes>'+Enter
	cLine+='     <Pane>'+Enter
	cLine+='      <Number>3</Number>'+Enter
	cLine+='      <ActiveRow>11</ActiveRow>'+Enter
	cLine+='      <ActiveCol>2</ActiveCol>'+Enter
	cLine+='     </Pane>'+Enter
	cLine+='    </Panes>'+Enter
	cLine+='    <ProtectObjects>False</ProtectObjects>'+Enter
	cLine+='    <ProtectScenarios>False</ProtectScenarios>'+Enter
	cLine+='   </WorksheetOptions>'+Enter
	cLine+='   <AutoFilter x:Range="R1C1:R2C44"'+Enter
	cLine+='    xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
	cLine+='   </AutoFilter>'+Enter
	cLine+='  </Worksheet>'+Enter
	RL202Write(cLine)
	
	
	
	cAliasQry2 := GetNextAlias()
	
	cCpoQry:="FT_FILIAL,FT_MARGEM,FT_ENTRADA,FT_EMISSAO,FT_NFISCAL,FT_SERIE,FT_ESTADO,FT_CFOP,FT_ALIQICM,FT_VALCONT,FT_BASEICM,FT_VALICM,FT_BASEIPI,FT_VALIPI"
	cCpoQry+=",FT_BASERET,FT_ICMSRET,FT_DTCANC,FT_DESPESA,FT_POSIPI,FT_QUANT,FT_PRCUNIT,FT_DESCONT,FT_TOTAL,FT_NFORI,FT_SERORI,FT_ITEMORI,"
	cCpoQry+="FT_CLIEFOR,FT_LOJA,FT_PRODUTO, B1_GRTRIB, B1_ORIGEM "
	cQuery :=RL202Query(cCpoQry," Order By SFT.FT_CFOP, SFT.FT_ENTRADA,SFT.FT_NFISCAL,SFT.FT_SERIE")
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry2 , .F., .T.)
	
	TcSetField( cAliasQry2, "FT_ENTRADA", "D", 8, 0 )
	TcSetField( cAliasQry2, "FT_EMISSAO", "D", 8, 0 )
	TcSetField( cAliasQry2, "FT_DTCANC", "D", 8, 0 )
	
	
	SF2->(DbSetOrder(1))
	Do While (cAliasQry2)->(!Eof())
		
		cCFOPAtu := ""
		cCFOPAtu := (cAliasQry2)->FT_CFOP
		AADD(aCFOP, cCFOPAtu)
		
		cLine:='  <Worksheet ss:Name="'+Alltrim((cAliasQry2)->FT_CFOP)+'">'+Enter
		cLine+='      <Table ss:ExpandedColumnCount="45" ss:ExpandedRowCount="99999" x:FullColumns="1"'+Enter
		cLine+='       x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:AutoFitWidth="0"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="80.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="79.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="67.5" ss:Span="1"/>'+Enter
		cLine+='       <Column ss:Index="6" ss:StyleID="s64" ss:Width="66.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="67.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="84.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="80.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="84"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="89.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="72"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="90"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="96.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="72"/>'+Enter
		cLine+='      <Column ss:StyleID="s64" ss:Width="78.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="76.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="62.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="68.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="83.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="90.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="69"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="69"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="78.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="28.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="58.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="95.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="123"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="111"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="95.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="123"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="111"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="115.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="143.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="126"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="116.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="144"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="126.75"/>'+Enter
		cLine+='       <Column ss:Index="40" ss:Width="50.25"/>'+Enter
		cLine+='       <Column ss:Width="45"/>'+Enter
		cLine+='       <Column ss:Width="81"/>'+Enter
		cLine+='       <Column ss:Width="108.75"/>'+Enter
		cLine+='       <Column ss:Width="68.25"/>'+Enter
		cLine+='       <Column ss:Width="96.75"/>'+Enter
		
		cLine+='   <Row ss:AutoFitHeight="0" ss:Height="18">'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Filial</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data Entrada</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data EmissÃ£o</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Doc. Fiscal</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Estado Ref</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Cod. Fiscal</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">AlÃ­q. ICMS</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr ContÃ¡bil</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Base ICMS</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Valor ICMS</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Base IPI</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Valor IPI</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Base Ret</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr ICMS Ret</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data Cancel</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Cod. Produto</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Vlr Despesas</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">CÃ³d. NCM</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Quantidade</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">PreÃ§o Unit.</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Desconto</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Total</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">NF Original</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s72"><Data ss:Type="String">Data emissÃ£o</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s73"><Data ss:Type="String">IVA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR FRE/SEG.</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS FRE/SEG.</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST FRE/SEG</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST FRE/SEG</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"/>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ALI IPI</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">IPI MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">IPI SOFTWARE</Data></Cell>'+Enter
		cLine+='   </Row>    '+Enter
		RL202Write(cLine)
		
		
		Do While ( (cAliasQry2)->(!Eof()) ) .And. (cCFOPAtu == (cAliasQry2)->FT_CFOP)
			
			cLine:='   <Row ss:AutoFitHeight="0">'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_FILIAL+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry2)->FT_ENTRADA)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry2)->FT_EMISSAO)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_NFISCAL+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_ESTADO+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_CFOP+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_ALIQICM)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_VALCONT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_BASEICM)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_VALICM)+'</Data></Cell>'+Enter
			
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_BASEIPI)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_VALIPI)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_BASERET)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_ICMSRET)+'</Data></Cell>'+Enter
			
			If Empty ( (cAliasQry2)->FT_DTCANC )
				cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
			Else
				cLine+='    <Cell><Data ss:Type="String">'+RL202Trans((cAliasQry2)->FT_DTCANC)+'</Data></Cell>'+Enter
			EndIf
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_PRODUTO+'</Data></Cell>'+Enter
			
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_DESPESA)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_POSIPI+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_QUANT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_PRCUNIT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_DESCONT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_TOTAL)+'</Data></Cell>'+Enter
			
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_NFORI+'</Data></Cell>'+Enter
			
			If Empty(SF2->F2_EMISSAO)
				cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
			Else
				cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans(SF2->F2_EMISSAO)+'</Data></Cell>'+Enter
			EndIf
			
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_MARGEM)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+cValMidICM+'</Data></Cell>'+Enter
			
			cLine+='    <Cell ss:Formula="=IF(RC[-7]&lt;RC[-1],(RC[-7]/2)*RC[-8],RC[-1]*RC[-8])"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-6]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-20]-RC[-7]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-23]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-24]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-25]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
			
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-10]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			
			
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-29]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-30]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[8]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			
			
			cLine+='    <Cell ss:Index="40"><Data ss:Type="Number">0.15</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+cValMidIPI+'</Data></Cell>'+Enter
			
			
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=IF(RC[-22]&lt;RC[-1],(RC[-22]/2)*RC[-23],RC[-1]*RC[-23])"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-21]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-4]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-5]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='   </Row>'+Enter
			
			RL202Write(cLine)
			
			
			(cAliasQry2)->(DbSkip())
			
		EndDo
		
		cLine:='   </Table>'+Enter
		cLine+='   <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
		cLine+='    <PageSetup>'+Enter
		cLine+='     <Header x:Margin="0.31496062000000002"/>'+Enter
		cLine+='     <Footer x:Margin="0.31496062000000002"/>'+Enter
		cLine+='     <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
		cLine+='      x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
		cLine+='    </PageSetup>'+Enter
		cLine+='    <Unsynced/>'+Enter
		cLine+='    <Print>'+Enter
		cLine+='     <ValidPrinterInfo/>'+Enter
		cLine+='     <PaperSizeIndex>9</PaperSizeIndex>'+Enter
		cLine+='     <HorizontalResolution>600</HorizontalResolution>'+Enter
		cLine+='     <VerticalResolution>600</VerticalResolution>'+Enter
		cLine+='    </Print>'+Enter
		cLine+='    <Selected/>'+Enter
		cLine+='    <FreezePanes/>'+Enter
		cLine+='    <FrozenNoSplit/>'+Enter
		cLine+='    <SplitHorizontal>1</SplitHorizontal>'+Enter
		cLine+='    <TopRowBottomPane>1</TopRowBottomPane>'+Enter
		cLine+='    <ActivePane>2</ActivePane>'+Enter
		cLine+='    <Panes>'+Enter
		cLine+='     <Pane>'+Enter
		cLine+='      <Number>3</Number>'+Enter
		cLine+='     </Pane>'+Enter
		cLine+='     <Pane>'+Enter
		cLine+='      <Number>2</Number>'+Enter
		cLine+='      <ActiveRow>0</ActiveRow>'+Enter
		cLine+='      <ActiveCol>1</ActiveCol>'+Enter
		cLine+='     </Pane>'+Enter
		cLine+='    </Panes>'+Enter
		cLine+='    <ProtectObjects>False</ProtectObjects>'+Enter
		cLine+='    <ProtectScenarios>False</ProtectScenarios>'+Enter
		cLine+='   </WorksheetOptions>'+Enter
		cLine+='  </Worksheet>'+Enter
		
		 
		RL202Write(cLine)
		
	EndDo

ElseIf mv_par09==3
	
	//Preenche os dados da aba original
	SF2->(DbSetOrder(1))
	Do While (cAliasQry)->(!Eof())
		
		IncProc("Processando...")
		
		cLine:='   <Row ss:AutoFitHeight="0">'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_FILIAL+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry)->FT_ENTRADA)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry)->FT_EMISSAO)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_NFISCAL+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_ESTADO+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_CFOP+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_ALIQICM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALCONT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASEICM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALICM)+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASEIPI)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_VALIPI)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_BASERET)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_ICMSRET)+'</Data></Cell>'+Enter
		
		If Empty ( (cAliasQry)->FT_DTCANC )
			cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
		Else
			cLine+='    <Cell><Data ss:Type="String">'+RL202Trans((cAliasQry)->FT_DTCANC)+'</Data></Cell>'+Enter
		EndIf
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_PRODUTO+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_DESPESA)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_POSIPI+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_QUANT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_PRCUNIT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_DESCONT)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_TOTAL)+'</Data></Cell>'+Enter
		
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->FT_NFORI+'</Data></Cell>'+Enter
		
		If Empty(SF2->F2_EMISSAO)
			cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
		Else
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans(SF2->F2_EMISSAO)+'</Data></Cell>'+Enter
		EndIf
		
		cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry)->FT_MARGEM)+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+cValMidICM+'</Data></Cell>'+Enter
		
		cLine+='    <Cell ss:Formula="=IF(RC[-7]&lt;RC[-1],(RC[-7]/2)*RC[-8],RC[-1]*RC[-8])"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-6]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-20]-RC[-7]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-23]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-24]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-25]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		If (cAliasQry)->FT_ESTADO $ 'BA|AL'
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]*0.4118"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]*0.4118"><Data ss:Type="Number">0</Data></Cell>'+Enter
		Else
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]"><Data ss:Type="Number">0</Data></Cell>'+Enter		
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		EndIf
		

		cLine+='    <Cell ss:Formula="=RC[-6]*RC[-10]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[10]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[-30]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:Formula="=RC[-3]*RC[8]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		
		cLine+='    <Cell ss:Index="40"><Data ss:Type="Number">0.15</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="Number">'+cValMidIPI+'</Data></Cell>'+Enter
		
		
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=IF(RC[-22]&lt;RC[-1],(RC[-22]/2)*RC[-23],RC[-1]*RC[-23])"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-21]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-4]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-5]"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String"></Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->B1_GRTRIB+'</Data></Cell>'+Enter
		cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry)->B1_ORIGEM+'</Data></Cell>'+Enter
		cLine+='   </Row>'+Enter
		
		RL202Write(cLine)
		
		(cAliasQry)->(DbSkip())
    	
	EndDo
	
	cLine:='   </Table>'+Enter
	cLine+='   <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
	cLine+='    <PageSetup>'+Enter
	cLine+='     <Header x:Margin="0.31496062000000002"/>'+Enter
	cLine+='     <Footer x:Margin="0.31496062000000002"/>'+Enter
	cLine+='     <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
	cLine+='      x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
	cLine+='    </PageSetup>'+Enter
	cLine+='    <Unsynced/>'+Enter
	cLine+='    <Print>'+Enter
	cLine+='     <ValidPrinterInfo/>'+Enter
	cLine+='     <PaperSizeIndex>9</PaperSizeIndex>'+Enter
	cLine+='     <HorizontalResolution>600</HorizontalResolution>'+Enter
	cLine+='     <VerticalResolution>600</VerticalResolution>'+Enter
	cLine+='    </Print>'+Enter
	cLine+='    <Panes>'+Enter
	cLine+='     <Pane>'+Enter  
	cLine+='      <Number>3</Number>'+Enter
	cLine+='      <ActiveRow>11</ActiveRow>'+Enter
	cLine+='      <ActiveCol>2</ActiveCol>'+Enter
	cLine+='     </Pane>'+Enter
	cLine+='    </Panes>'+Enter
	cLine+='    <ProtectObjects>False</ProtectObjects>'+Enter
	cLine+='    <ProtectScenarios>False</ProtectScenarios>'+Enter
	cLine+='   </WorksheetOptions>'+Enter
	cLine+='   <AutoFilter x:Range="R1C1:R2C44"'+Enter
	cLine+='    xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
	cLine+='   </AutoFilter>'+Enter
	cLine+='  </Worksheet>'+Enter
	RL202Write(cLine)
	
	
	
	cAliasQry2 := GetNextAlias()
	
	cCpoQry:="FT_FILIAL,FT_MARGEM,FT_ENTRADA,FT_EMISSAO,FT_NFISCAL,FT_SERIE,FT_ESTADO,FT_CFOP,FT_ALIQICM,FT_VALCONT,FT_BASEICM,FT_VALICM,FT_BASEIPI,FT_VALIPI"
	cCpoQry+=",FT_BASERET,FT_ICMSRET,FT_DTCANC,FT_DESPESA,FT_POSIPI,FT_QUANT,FT_PRCUNIT,FT_DESCONT,FT_TOTAL,FT_NFORI,FT_SERORI,FT_ITEMORI,"
	cCpoQry+="FT_CLIEFOR,FT_LOJA,FT_PRODUTO, B1_GRTRIB, B1_ORIGEM "
	cQuery :=RL202Query(cCpoQry," Order By SFT.FT_ESTADO, SFT.FT_ENTRADA,SFT.FT_NFISCAL,SFT.FT_SERIE")
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry2 , .F., .T.)
	
	TcSetField( cAliasQry2, "FT_ENTRADA", "D", 8, 0 )
	TcSetField( cAliasQry2, "FT_EMISSAO", "D", 8, 0 )
	TcSetField( cAliasQry2, "FT_DTCANC", "D", 8, 0 )
	
	
	SF2->(DbSetOrder(1))
	Do While (cAliasQry2)->(!Eof())
		
		cEstAtu := ""
		cEstAtu := (cAliasQry2)->FT_ESTADO
		AADD(aEstado, (cAliasQry2)->FT_ESTADO)      
		
		nAliqInt := 0
		
		//Busca o valor da aliq. interna do campo F7_ALIQDST caso o estado seja PE, senão busca do campo F7_ALIQINT
		If Alltrim(cEstAtu) == "PE"
			nAliqInt := GetExcFisc(cEstAtu,(cAliasQry2)->FT_FILIAL, (cAliasQry2)->FT_PRODUTO, "F7_ALIQDST",dtos((cAliasQry2)->FT_ENTRADA))
		Else
			nAliqInt := GetExcFisc(cEstAtu,(cAliasQry2)->FT_FILIAL, (cAliasQry2)->FT_PRODUTO, "F7_ALIQINT",dtos((cAliasQry2)->FT_ENTRADA))		
		EndIF

		
		//Caso não encontre o IVA na nota fiscal, será verificado no historico de IVA senão será utilizado o IVA atual
		nIVA	 := 0
		nIVA	 := (cAliasQry2)->FT_MARGEM
		
		If nIVA == 0
			nIVA	 := GetExcFisc(cEstAtu,(cAliasQry2)->FT_FILIAL, (cAliasQry2)->FT_PRODUTO, "F7_MARGEM", dtos((cAliasQry2)->FT_ENTRADA))
		Endif
		
		cLine:='  <Worksheet ss:Name="'+Alltrim((cAliasQry2)->FT_ESTADO)+'">'+Enter
		cLine+='      <Table ss:ExpandedColumnCount="46" ss:ExpandedRowCount="99999" x:FullColumns="1"'+Enter
		cLine+='       x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:AutoFitWidth="0"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="80.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="79.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="67.5" ss:Span="1"/>'+Enter
		cLine+='       <Column ss:Index="6" ss:StyleID="s64" ss:Width="66.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="67.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="84.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="80.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="84"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="89.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="72"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="90"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="96.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="72"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="78.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="76.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="62.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="68.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="83.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="90.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="69"/>'+Enter
		cLine+='       <Column ss:StyleID="s64" ss:Width="69"/>'+Enter
		cLine+='       <Column ss:StyleID="s65" ss:Width="78.75"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="28.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="58.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="95.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="123"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="111"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="95.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="123"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="111"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="115.5"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="143.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="126"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="116.25"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="144"/>'+Enter
		cLine+='       <Column ss:StyleID="s66" ss:Width="126.75"/>'+Enter
		cLine+='       <Column ss:Index="40" ss:Width="50.25"/>'+Enter
		cLine+='       <Column ss:Width="45"/>'+Enter
		cLine+='       <Column ss:Width="81"/>'+Enter
		cLine+='       <Column ss:Width="108.75"/>'+Enter
		cLine+='       <Column ss:Width="68.25"/>'+Enter
		cLine+='       <Column ss:Width="96.75"/>'+Enter
		cLine+='       <Column ss:Width="110.75"/>'+Enter		
		
		cLine+='   <Row ss:AutoFitHeight="0" ss:Height="18">'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Filial</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data Entrada</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data EmissÃ£o</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Doc. Fiscal</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Estado Ref</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Cod. Fiscal</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">AlÃ­q. ICMS</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr ContÃ¡bil</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Base ICMS</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Valor ICMS</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Base IPI</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Valor IPI</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Base Ret</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr ICMS Ret</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data Cancel</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Cod. Produto</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Vlr Despesas</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">CÃ³d. NCM</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Quantidade</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">PreÃ§o Unit.</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Desconto</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Total</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s67"><Data ss:Type="String">NF Original</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s72"><Data ss:Type="String">Data emissÃ£o</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s73"><Data ss:Type="String">IVA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR FRE/SEG.</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS FRE/SEG.</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST FRE/SEG</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST FRE/SEG</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"/>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ALI IPI</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">IPI MIDIA</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">IPI SOFTWARE</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ALIQ. INTERN.</Data></Cell>'+Enter		
		cLine+='   </Row>    '+Enter
		RL202Write(cLine)
		
		
		Do While ( (cAliasQry2)->(!Eof()) ) .And. (cEstAtu == (cAliasQry2)->FT_ESTADO)
			
			cLine:='   <Row ss:AutoFitHeight="0">'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_FILIAL+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry2)->FT_ENTRADA)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans((cAliasQry2)->FT_EMISSAO)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_NFISCAL+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_ESTADO+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_CFOP+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_ALIQICM)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_VALCONT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_BASEICM)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_VALICM)+'</Data></Cell>'+Enter
			
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_BASEIPI)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_VALIPI)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_BASERET)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_ICMSRET)+'</Data></Cell>'+Enter
			
			If Empty ( (cAliasQry2)->FT_DTCANC )
				cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
			Else
				cLine+='    <Cell><Data ss:Type="String">'+RL202Trans((cAliasQry2)->FT_DTCANC)+'</Data></Cell>'+Enter
			EndIf
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_PRODUTO+'</Data></Cell>'+Enter
			
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_DESPESA)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_POSIPI+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_QUANT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_PRCUNIT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_DESCONT)+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+RL202Trans((cAliasQry2)->FT_TOTAL)+'</Data></Cell>'+Enter
			
			cLine+='    <Cell><Data ss:Type="String">'+(cAliasQry2)->FT_NFORI+'</Data></Cell>'+Enter
			
			If Empty(SF2->F2_EMISSAO)
				cLine+='    <Cell><Data ss:Type="String">  /  /  </Data></Cell>'+Enter
			Else
				cLine+='    <Cell><Data ss:Type="DateTime">'+RL202Trans(SF2->F2_EMISSAO)+'</Data></Cell>'+Enter
			EndIf
			
			cLine+='    <Cell><Data ss:Type="Number">'+Alltrim(Str( (nIVA/100)+1  ))+'</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+cValMidICM+'</Data></Cell>'+Enter
			
			cLine+='    <Cell ss:Formula="=IF(RC[-7]&lt;RC[-1],(RC[-7]/2)*RC[-8],RC[-1]*RC[-8])"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-6]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-20]-RC[-7]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-23]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-24]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[-25]%"><Data ss:Type="Number">0</Data></Cell>'+Enter
			
			If cEstAtu $ 'BA|AL'
				cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]*0.4118"><Data ss:Type="Number">0</Data></Cell>'+Enter
				cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]*0.4118"><Data ss:Type="Number">0</Data></Cell>'+Enter
			Else
				cLine+='    <Cell ss:Formula="=RC[-6]*RC[-8]"><Data ss:Type="Number">0</Data></Cell>'+Enter			
				cLine+='    <Cell ss:Formula="=RC[-6]*RC[-9]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			EndIf
			
			cLine+='    <Cell ss:Formula="=RC[-6]*RC[-10]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			
			
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[10]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[9]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:Formula="=RC[-3]*RC[8]%-RC[-6]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			
			
			cLine+='    <Cell ss:Index="40"><Data ss:Type="Number">0.15</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+cValMidIPI+'</Data></Cell>'+Enter
			
			
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=IF(RC[-22]&lt;RC[-1],(RC[-22]/2)*RC[-23],RC[-1]*RC[-23])"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-21]-RC[-1]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-4]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s66" ss:Formula="=RC[-2]*RC[-5]"><Data ss:Type="Number">0</Data></Cell>'+Enter
			cLine+='    <Cell><Data ss:Type="Number">'+Alltrim(Str( nAliqInt))+'</Data></Cell>'+Enter
			cLine+='   </Row>'+Enter
			
			RL202Write(cLine)
			
			
			(cAliasQry2)->(DbSkip())
			
		EndDo
		
		cLine:='   </Table>'+Enter
		cLine+='   <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
		cLine+='    <PageSetup>'+Enter
		cLine+='     <Header x:Margin="0.31496062000000002"/>'+Enter
		cLine+='     <Footer x:Margin="0.31496062000000002"/>'+Enter
		cLine+='     <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
		cLine+='      x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
		cLine+='    </PageSetup>'+Enter
		cLine+='    <Unsynced/>'+Enter
		cLine+='    <Print>'+Enter
		cLine+='     <ValidPrinterInfo/>'+Enter
		cLine+='     <PaperSizeIndex>9</PaperSizeIndex>'+Enter
		cLine+='     <HorizontalResolution>600</HorizontalResolution>'+Enter
		cLine+='     <VerticalResolution>600</VerticalResolution>'+Enter
		cLine+='    </Print>'+Enter
		cLine+='    <Selected/>'+Enter
		cLine+='    <FreezePanes/>'+Enter
		cLine+='    <FrozenNoSplit/>'+Enter
		cLine+='    <SplitHorizontal>1</SplitHorizontal>'+Enter
		cLine+='    <TopRowBottomPane>1</TopRowBottomPane>'+Enter
		cLine+='    <ActivePane>2</ActivePane>'+Enter
		cLine+='    <Panes>'+Enter
		cLine+='     <Pane>'+Enter
		cLine+='      <Number>3</Number>'+Enter
		cLine+='     </Pane>'+Enter
		cLine+='     <Pane>'+Enter
		cLine+='      <Number>2</Number>'+Enter
		cLine+='      <ActiveRow>0</ActiveRow>'+Enter
		cLine+='      <ActiveCol>1</ActiveCol>'+Enter
		cLine+='     </Pane>'+Enter
		cLine+='    </Panes>'+Enter
		cLine+='    <ProtectObjects>False</ProtectObjects>'+Enter
		cLine+='    <ProtectScenarios>False</ProtectScenarios>'+Enter
		cLine+='   </WorksheetOptions>'+Enter
		cLine+='  </Worksheet>'+Enter
		
		
		RL202Write(cLine)
		
	EndDo                

	
EndIf


If mv_par09==1
	cLine:='  </Table>'+Enter
	cLine+='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
	cLine+='   <PageSetup>'+Enter
	cLine+='    <Header x:Margin="0.31496062000000002"/>'+Enter
	cLine+='    <Footer x:Margin="0.31496062000000002"/>'+Enter
	cLine+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
	cLine+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
	cLine+='   </PageSetup>'+Enter
	cLine+='   <Unsynced/>'+Enter
	cLine+='   <LeftColumnVisible>35</LeftColumnVisible>'+Enter
	cLine+='   <Panes>'+Enter
	cLine+='    <Pane>'+Enter
	cLine+='     <Number>3</Number>'+Enter
	cLine+='     <ActiveRow>1</ActiveRow>'+Enter
	cLine+='    </Pane>'+Enter
	cLine+='   </Panes>'+Enter
	cLine+='   <ProtectObjects>False</ProtectObjects>'+Enter
	cLine+='   <ProtectScenarios>False</ProtectScenarios>'+Enter
	cLine+='  </WorksheetOptions>'+Enter
	cLine+=' </Worksheet>'+Enter
	RL202Write(cLine)
	
	nTotline:=Len(aTotal)
	cLine:=' <Worksheet ss:Name="IPI">'+CRLF
	cLine+='  <Table ss:ExpandedColumnCount="3" ss:ExpandedRowCount="99999" x:FullColumns="1"'+CRLF
	cLine+='   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF
	cLine+='    <Column ss:StyleID="s64" ss:Width="96.75" ss:Span="1"/>'+CRLF
	cLine+='   <Column ss:Index="3" ss:Width="72"/>'+CRLF
	cLine+='   <Row ss:AutoFitHeight="0">'+CRLF
	cLine+='    <Cell ss:StyleID="s76"><Data ss:Type="String">NCM</Data></Cell>'+CRLF
	cLine+='    <Cell ss:StyleID="s76"><Data ss:Type="String">IPI</Data></Cell>'+CRLF
	cLine+='    <Cell ss:StyleID="s78"><Data ss:Type="String">IPI MÃDIA</Data></Cell>'+CRLF
	cLine+='   </Row>'+CRLF
	
	For nInd:=1 To nTotline
		cLine+='      <Row ss:AutoFitHeight="0">'+CRLF
		cLine+='   <Cell ss:StyleID="s79"><Data ss:Type="String">'+aTotal[1]+'</Data></Cell>'+CRLF
		cLine+='   <Cell ss:StyleID="s80" ss:Formula="=SUMIF(Original!C18,IPI!R2C1,Original!C12)"><Data'+CRLF
		cLine+='     ss:Type="Number">0</Data></Cell>'+CRLF
		cLine+='   <Cell ss:StyleID="s80" ss:Formula="=SUMIF(Original!C18,IPI!R2C1,Original!C44)"><Data'+CRLF
		cLine+='     ss:Type="Number">0</Data></Cell>'+CRLF
		cLine+='   </Row>'+CRLF
	Next
	
	cLine+='   <Row ss:AutoFitHeight="0">'+CRLF
	cLine+='    <Cell ss:StyleID="s79"/>'+CRLF
	cLine+='    <Cell ss:StyleID="s80"/>'+CRLF
	cLine+='   </Row>'+CRLF
	
	
	cLine+='   <Row ss:AutoFitHeight="0">'+CRLF
	cLine+='    <Cell ss:StyleID="s81"><Data ss:Type="String">TOTAL</Data></Cell>'+CRLF
	cLine+='	<Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+AllTrim(Str(nTotline+1))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'
	cLine+='	<Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+AllTrim(Str(nTotline+1))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'
	cLine+='   </Row>'+CRLF
	
	
	cLine+='  </Table>'+CRLF
	cLine+='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cLine+='   <PageSetup>'+CRLF
	cLine+='    <Header x:Margin="0.31496062000000002"/>'+CRLF
	cLine+='    <Footer x:Margin="0.31496062000000002"/>'+CRLF
	cLine+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
	cLine+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
	cLine+='   </PageSetup>'+CRLF
	cLine+='   <Unsynced/>'+CRLF
	cLine+='   <Selected/>'+CRLF
	cLine+='   <Panes>'+CRLF
	cLine+='    <Pane>'+CRLF
	cLine+='     <Number>3</Number>'+CRLF
	cLine+='     <ActiveRow>3</ActiveRow>'+CRLF
	cLine+='     <ActiveCol>1</ActiveCol>'+CRLF
	cLine+='    </Pane>'+CRLF
	cLine+='   </Panes>'+CRLF
	cLine+='   <ProtectObjects>False</ProtectObjects>'+CRLF
	cLine+='   <ProtectScenarios>False</ProtectScenarios>'+CRLF
	cLine+='  </WorksheetOptions>'+CRLF
	cLine+=' </Worksheet>'+CRLF
	cLine+='</Workbook>'
	
	
	RL202Write(cLine)
ElseIf mv_par09==2
	
	cLine:=' <Worksheet ss:Name="ICMS">'+CRLF
	cLine+='  <Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="99999" x:FullColumns="1"'+CRLF
	cLine+='   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF
	
	cLine+=' <Column ss:Width="50.75"/>'+CRLF
	cLine+=' <Column ss:Width="125.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	
	
	cLine+=' <Row ss:AutoFitHeight="0">'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">CFOP</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">ICMS MIDIA+SOFTWARE</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"/>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">ICMS MIDIA</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">ICMS SOFTWARE</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s78"><Data ss:Type="String">FRETE/SEGURO</Data></Cell>'+CRLF
	cLine+=' </Row>'+CRLF
	
	For nX := 1 To Len(aCFOP)
		cLine+=' <Row ss:AutoFitHeight="0">'+CRLF
		cLine+='     <Cell ss:StyleID="s79"><Data ss:Type="Number">'+Alltrim(aCFOP[nX])+'</Data></Cell>'+CRLF
		cLine+='     <Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aCFOP[nX])+'!C[8])"><Data ss:Type="Number">34.130000000000003</Data></Cell>'+CRLF
		cLine+='     <Cell ss:StyleID="s80"><Data ss:Type="String">=</Data></Cell>'+CRLF
		cLine+='     <Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aCFOP[nX])+'!C[26])"><Data ss:Type="Number">3.456</Data></Cell>'+CRLF
		cLine+='     <Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aCFOP[nX])+'!C[26])"><Data ss:Type="Number">30.679199999999998</Data></Cell>'+CRLF
		cLine+='     <Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aCFOP[nX])+'!C[26])"><Data ss:Type="Number">0</Data></Cell>'+CRLF
		cLine+=' </Row>'+CRLF
	Next

   cLine+=' <Row ss:AutoFitHeight="0">'+CRLF
   cLine+='  <Cell ss:StyleID="s81"/>'+CRLF
   cLine+='  <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aCFOP)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
   cLine+='  <Cell ss:StyleID="s81"/>'+CRLF
   cLine+='  <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aCFOP)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
   cLine+='  <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aCFOP)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
   cLine+='  <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aCFOP)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
   cLine+=' </Row>'+CRLF
	
	cLine+='   </Table>'+CRLF
	cLine+='   <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cLine+='    <PageSetup>'+CRLF
	cLine+='     <Header x:Margin="0.31496062000000002"/>'+CRLF
	cLine+='     <Footer x:Margin="0.31496062000000002"/>'+CRLF
	cLine+='     <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
	cLine+='      x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
	cLine+='    </PageSetup>'+CRLF
	cLine+='    <Unsynced/>'+CRLF
	cLine+='    <Selected/>'+CRLF
	cLine+='    <Panes>'+CRLF
	cLine+='     <Pane>'+CRLF
	cLine+='      <Number>3</Number>'+CRLF
	cLine+='      <ActiveCol>1</ActiveCol>'+CRLF
	cLine+='     </Pane>'+CRLF
	cLine+='    </Panes>'+CRLF
	cLine+='    <ProtectObjects>False</ProtectObjects>'+CRLF
	cLine+='    <ProtectScenarios>False</ProtectScenarios>'+CRLF
	cLine+='   </WorksheetOptions>'+CRLF
	cLine+='  </Worksheet>'+CRLF
	RL202Write(cLine)
	
	cLine :=' </Workbook>'+Enter
	RL202Write(cLine)
	
	
ElseIf mv_par09 == 3
	
	cLine:=' <Worksheet ss:Name="ICMS-ST">'+CRLF
	cLine+='  <Table ss:ExpandedColumnCount="7" ss:ExpandedRowCount="99999" x:FullColumns="1"'+CRLF
	cLine+='   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF
	
	cLine+=' <Column ss:Width="50.75"/>'+CRLF
	cLine+=' <Column ss:Width="125.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	cLine+=' <Column ss:Width="100.5"/>'+CRLF
	
	
	cLine+=' <Row ss:AutoFitHeight="0">'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">Estado</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">ICMS MIDIA+SOFTWARE</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"/>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">ICMS MIDIA</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s76"><Data ss:Type="String">ICMS SOFTWARE</Data></Cell>'+CRLF
	cLine+='  <Cell ss:StyleID="s78"><Data ss:Type="String">FRETE/SEGURO</Data></Cell>'+CRLF
	cLine+=' </Row>'+CRLF
	
	For nX := 1 To Len(aEstado)
		cLine+=' <Row ss:AutoFitHeight="0">'+CRLF
		cLine+=' 	<Cell ss:StyleID="s79"><Data ss:Type="String">'+Alltrim(aEstado[nX])+'</Data></Cell>'+CRLF
		cLine+=' 	<Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aEstado[nX])+'!C[12])"><Data ss:Type="Number">528.80999999999995</Data></Cell>'+CRLF
		cLine+=' 	<Cell ss:StyleID="s80"><Data ss:Type="String">=</Data></Cell>'+CRLF
		cLine+=' 	<Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aEstado[nX])+'!C[32])"><Data ss:Type="Number">45.52800000000002</Data></Cell>'+CRLF
		cLine+=' 	<Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aEstado[nX])+'!C[32])"><Data ss:Type="Number">284.38830000000013</Data></Cell>'+CRLF
		cLine+=' 	<Cell ss:StyleID="s80" ss:Formula="=SUM('+Alltrim(aEstado[nX])+'!C[32])"><Data ss:Type="Number">0</Data></Cell>'+CRLF
		cLine+=' </Row>'+CRLF
		
	Next

	cLine+=' <Row ss:AutoFitHeight="0">'+CRLF
	cLine+='   <Cell ss:StyleID="s81"/>'+CRLF
	cLine+='   <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aEstado)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
	cLine+='   <Cell ss:StyleID="s81"/>'+CRLF
	cLine+='   <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aEstado)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
	cLine+='   <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aEstado)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
	cLine+='   <Cell ss:StyleID="s81" ss:Formula="=SUM(R[-'+Alltrim(Str(Len(aEstado)))+']C:R[-1]C)"><Data ss:Type="Number">0</Data></Cell>'+CRLF
	cLine+='  </Row>'+CRLF
	
	cLine+='   </Table>'+CRLF
	cLine+='   <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cLine+='    <PageSetup>'+CRLF
	cLine+='     <Header x:Margin="0.31496062000000002"/>'+CRLF
	cLine+='     <Footer x:Margin="0.31496062000000002"/>'+CRLF
	cLine+='     <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
	cLine+='      x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
	cLine+='    </PageSetup>'+CRLF
	cLine+='    <Unsynced/>'+CRLF
	cLine+='    <Selected/>'+CRLF
	cLine+='    <Panes>'+CRLF
	cLine+='     <Pane>'+CRLF
	cLine+='      <Number>3</Number>'+CRLF
	cLine+='      <ActiveCol>1</ActiveCol>'+CRLF
	cLine+='     </Pane>'+CRLF
	cLine+='    </Panes>'+CRLF
	cLine+='    <ProtectObjects>False</ProtectObjects>'+CRLF
	cLine+='    <ProtectScenarios>False</ProtectScenarios>'+CRLF
	cLine+='   </WorksheetOptions>'+CRLF
	cLine+='  </Worksheet>'+CRLF
	RL202Write(cLine)
	
	cLine :=' </Workbook>'+Enter
	RL202Write(cLine)
	
	
EndIf


FClose(nHdl)

If mv_par09==1
	cNomArq:="ESTORNO_IPI_ENTRADA"+DtoS(MsDate())+STRTRAN(Time(), ":", "")
ElseIf mv_par09==2
	cNomArq:="ESTORNO_ICM_ENTRADA_"+DtoS(MsDate())+STRTRAN(Time(), ":", "")
ElseIf mv_par09==3
	cNomArq:="ESTORNO_ICM_ST_ENTRADA_"+DtoS(MsDate())+STRTRAN(Time(), ":", "")		
EndIf

IncProc("Copiando planilha "+cNomArq+" para "+cPathExcel)

If __CopyFile(cPathArq+cArqXls+cExtExcel, cPathExcel+cArqXls)
	Ferase(cPathArq+cArqXls)
	
	
	fRename( cPathExcel+cArqXls, cPathExcel+cNomArq+cExtExcel )
	If !ApOleCliente( "MsExcel" )
		MsgStop( "Microsoft Excel não Instalado... Contate o Administrador do Sistema!" )
	Else
		If MsgYesNo("Abrir o Microsoft Excel?")
			oExcelApp:=MsExcel():New()
			oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
			oExcelApp:SetVisible( .T. )
			oExcelApp:Destroy()
		EndIf
	EndIf
EndIf

Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL202  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL202Trans(xDados)
Local xRetorno

If ValType(xDados)=="N"
	xRetorno:=AllTrim(Str(xDados))
ElseIf ValType(xDados)=="D"
	xRetorno:=StrZero(Year(xDados),4)+"-"+StrZero(Month(xDados),2)+"-"+StrZero(Day(xDados),2)+'T00:00:00.000'
EndIf


Return xRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL202  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL202Query(cCpoQry,cOrdenar)

Local cQuery:=""
Local cCFOPIPI	:= GetCtParam("NC_CFOEIP1",;
  								  		"1202|2202|1411|2411|1152|1913",;
										"C",;
										"CFOP de estorno de IPI entrada",;
										"CFOP de estorno de IPI entrada",;
										"CFOP de estorno de IPI entrada",;
										.F. )

Local cCFOPIPI2	:= GetCtParam("NC_CFOEIP2",;
  								  		"1949|2949",;
										"C",;
										"CFOP de estorno de IPI entrada CFOP = 1949|2949 e formulario proprio",;
										"CFOP de estorno de IPI entrada CFOP = 1949|2949 e formulario proprio",;
										"CFOP de estorno de IPI entrada CFOP = 1949|2949 e formulario proprio ",;
										.F. ) 
										
Local cCFOPICMSST	:= GetCtParam("NC_CFOPEST",;
  								  		"2949|1949",;
										"C",;
										"CFOP de estorno de ICMS ST entrada CFOP = 2949|1949 e formulario proprio",;
										"CFOP de estorno de ICMS ST entrada CFOP = 2949|1949 e formulario proprio",;
										"CFOP de estorno de ICMS ST entrada CFOP = 2949|1949 e formulario proprio",;
										.F. )

Local cCFOPICST2	:= GetCtParam("NC_CFOEST2",;
  								  		"2411|1411",;
										"C",;
										"CFOP de estorno de ICMS ST entrada",;
										"CFOP de estorno de ICMS ST entrada",;
										"CFOP de estorno de ICMS ST entrada",;
										.F. )										

Local cEstMun	:= GetCtParam("NC_ESTMUNE",;
  										"RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600",;
										"C",;
										"Estado e municipio estorno de IPI de entrada",;
										"Estado e municipio estorno de IPI de entrada",;
										"Estado e municipio estorno de IPI de entrada",;
										.F. )

Local cPosIpi	:= GetCtParam("NC_POSIPI",;
  										"SB1",;
										"C",;
										"Verifica o NCM a partir do produto (SB1) ou livros fiscais (SFT) ",;
										"Verifica o NCM a partir do produto (SB1) ou livros fiscais (SFT) ",;
										"Verifica o NCM a partir do produto (SB1) ou livros fiscais (SFT) ",;
										.F. )


Default cCpoQry:="*"
Default cOrdenar:=""

If mv_par09==2

	cQuery := " SELECT "+cCpoQry+CRLF
	cQuery += " FROM "+RetSqlName("SFT")+" SFT "+CRLF
	
	cQuery += " INNER JOIN "+RetSqlName("SD1")+" SD1 "+CRLF
	cQuery += " ON SD1.D1_FILIAL  = SFT.FT_FILIAL "+CRLF
	cQuery += " AND SD1.D1_DOC    = SFT.FT_NFISCAL "+CRLF
	cQuery += " AND SD1.D1_SERIE  = SFT.FT_SERIE "+CRLF
	cQuery += " AND SD1.D1_FORNECE= SFT.FT_CLIEFOR "+CRLF
	cQuery += " AND SD1.D1_COD    = SFT.FT_PRODUTO "+CRLF
	cQuery += " AND SD1.D1_ITEM   = SFT.FT_ITEM "+CRLF
	cQuery += " AND SD1.D_E_L_E_T_ = ' ' "+CRLF
	
	cQuery += " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
	cQuery += " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
	cQuery += " AND SB1.B1_COD  = SFT.FT_PRODUTO "+CRLF    
	
	If Alltrim(cPosIpi) == "SB1"
		cQuery += " AND SB1.B1_POSIPI  BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"+CRLF
	EndIf
	
	cQuery += " AND SB1.D_E_L_E_T_ = ' ' "+CRLF
	
	
	cQuery += " WHERE SFT.FT_FILIAL BETWEEN '"+mv_par01+"' AND '"+mv_par02+"' "+CRLF
	cQuery += " AND SFT.FT_VALICM > 0  "+CRLF
	cQuery += " AND SFT.FT_ESTADO != 'EX' "+CRLF
	cQuery += " AND SFT.FT_ENTRADA BETWEEN '"+Dtos(mv_par03)+"' AND '"+Dtos(mv_par04)+"'"+CRLF
	cQuery += " AND SFT.FT_EMISSAO BETWEEN '"+Dtos(mv_par05)+"' AND '"+Dtos(mv_par06)+"'"+CRLF

	If Alltrim(cPosIpi) == "SFT"
		cQuery += " AND SFT.FT_POSIPI BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"+CRLF
	EndIf                       
	
	//Verifica se a nota não foi cancelada e/ou inutilizada
	cQuery += " AND EXISTS (SELECT 'X' FROM "+RetSqlName("SF3")+" SF3  "+CRLF
	cQuery += "                    WHERE SF3.F3_FILIAL = SFT.FT_FILIAL "+CRLF
	cQuery += "                    AND SF3.F3_NFISCAL = SFT.FT_NFISCAL  "+CRLF
	cQuery += "                    AND SF3.F3_SERIE = SFT.FT_SERIE  "+CRLF
	cQuery += "                    AND SF3.F3_CODRSEF NOT IN('102','103') "+CRLF
	cQuery += "                    AND SF3.D_E_L_E_T_=' ' "+CRLF
	cQuery += "                                            )"+CRLF
	cQuery += " AND SFT.D_E_L_E_T_ = ' ' "+CRLF
	
	
Else
	cQuery:=" Select "+cCpoQry+CRLF
	cQuery+=" From "+RetSqlName("SFT")+" SFT,"+RetSqlName("SD1")+" SD1,"+RetSqlName("SA1")+" SA1,"+RetSqlName("SB1")+" SB1"+CRLF
	
	cQuery+=" Where SFT.FT_FILIAL Between '"+mv_par01+"' And '"+mv_par02+"'"+CRLF
	
	If mv_par09==1
		cQuery+=" And ( SFT.FT_CFOP In "+FormatIn(cCFOPIPI, "|")+" Or (   (SFT.FT_CFOP In"+FormatIn(cCFOPIPI2, "|")+" and SFT.FT_FORMUL='S') OR SFT.FT_CFOP In "+FormatIn(cCFOPIPI2, "|")+" AND D1_TIPO = 'B'   )  )"+CRLF
	ElseIf mv_par09==3
		cQuery+=" And ( (SFT.FT_CFOP IN"+FormatIn(cCFOPICMSST, "|")+"  and SFT.FT_FORMUL='S') Or (SFT.FT_CFOP IN"+FormatIn(cCFOPICST2, "|")+"  )      )"+CRLF
		cQuery+=" And SFT.FT_ICMSRET > 0 "
	EndIf
	
	cQuery+=" And SD1.D1_FILIAL=SFT.FT_FILIAL"+CRLF
	cQuery+=" And SD1.D1_DOC=SFT.FT_NFISCAL"+CRLF
	cQuery+=" And SD1.D1_SERIE=SFT.FT_SERIE"+CRLF
	cQuery+=" And SD1.D1_FORNECE=SFT.FT_CLIEFOR"+CRLF
	cQuery+=" And SD1.D1_COD=SFT.FT_PRODUTO"+CRLF
	cQuery+=" And SD1.D1_ITEM=SFT.FT_ITEM"+CRLF
	cQuery+=" And SA1.A1_FILIAL='"+xFilial("SA1")+"'"+CRLF
	cQuery+=" And SB1.B1_FILIAL='"+xFilial("SB1")+"'"+CRLF
	cQuery+=" And SA1.A1_COD=SD1.D1_FORNECE"+CRLF
	cQuery+=" And SA1.A1_LOJA=SD1.D1_LOJA"+CRLF
	cQuery+=" And SB1.B1_COD=SD1.D1_COD"+CRLF

	If Alltrim(cPosIpi) == "SB1"
		cQuery += " And SB1.B1_POSIPI  BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"+CRLF
	EndIf
	
	
	cQuery+=" And SB1.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SA1.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SFT.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SD1.D_E_L_E_T_=' '"+CRLF
	
	cQuery+=" And SFT.FT_ENTRADA between '"+Dtos(mv_par03)+"' And '"+Dtos(mv_par04)+"'"+CRLF
	cQuery+=" And SFT.FT_EMISSAO between '"+Dtos(mv_par05)+"' And '"+Dtos(mv_par06)+"'"+CRLF
	
	If mv_par09==1
		//If Dtos(mv_par04)>="20121101"
		cQuery+=" And ((SFT.FT_ESTADO || SA1.A1_COD_MUN) NOT IN"+FormatIn(cEstMun, "|")+") "+CRLF
		//EndIf
	EndIf
	
	
	If Alltrim(cPosIpi) == "SFT"
		cQuery+=" And  SFT.FT_POSIPI  between '"+mv_par07+"' And '"+mv_par08+"'"+CRLF
	EndIf
	
	//Verifica se a nota não foi cancelada e/ou inutilizada
	cQuery+=" And EXISTS (SELECT 'X' FROM "+RetSqlName("SF3")+" SF3 "+CRLF
	cQuery+="                   WHERE SF3.F3_FILIAL = SFT.FT_FILIAL "+CRLF
	cQuery+="                   AND SF3.F3_NFISCAL = SFT.FT_NFISCAL "+CRLF
	cQuery+="                   AND SF3.F3_SERIE = SFT.FT_SERIE "+CRLF
	cQuery+="                   AND SF3.F3_CODRSEF NOT IN('102','103')"+CRLF
	cQuery+="                   AND SF3.D_E_L_E_T_=' ' "+CRLF
	cQuery+="                                           )"+CRLF

EndIf

If !Empty(cOrdenar)
	cQuery+=cOrdenar
EndIf


Return cQuery

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetExcFisc  ºAutor  ³Microsiga         º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o valor da execeção fiscal do campo solicitado.     º±±
±±º          ³Obs. passar apenas 1 campo                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetExcFisc(cEst, cYFil, cProd, cCampo, cDtEntrada)

Local aArea		:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cArqTmpPdz:= GetNextAlias()
Local xRet	
Local cCampoAux	:= ""

Default cEst		:= ""        
Default cYFil		:= ""                    
Default cProd		:= ""                      
Default cCampo		:= ""                                         
Default cDtEntrada	:= ""

DbSelectArea("SB1")
DbSetOrder(1)
If SB1->(MsSeek(xFilial("SB1") + cProd))


	cCampoAux := Replace(cCampo,"F7_","DZ_")
	cQuery := " SELECT "+cCampoAux+", DZ_DTVALID FROM "+RetSqlName("PDZ")+" PDZ "+CRLF
	cQuery += " WHERE PDZ.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND PDZ.DZ_FILIAL = '"+cYFil+"' "+CRLF
	cQuery += " AND PDZ.DZ_GRTRIB = '"+SB1->B1_GRTRIB+"' "+CRLF
	cQuery += " AND PDZ.DZ_EST = '"+cEst+"' "+CRLF
	cQuery += " AND PDZ.DZ_DTVALID >= '"+cDtEntrada+"' "+CRLF
	cQuery += " ORDER BY DZ_DTVALID "
	
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpPdz , .F., .T.)
	
	(cArqTmpPdz)->(DbGoTop())
	If (cArqTmpPdz)->(!eof())
		xRet := (cArqTmpPdz)->&cCampoAux
	Else
		xRet := 0
	EndIf
	
	(cArqTmpPdz)->(DbCloseArea())

    
	//Verifica se encontrou o registro no historico de exceções fiscais
	//senão senão encontrou será utilizado a exceção fiscal atual
    If Empty(xRet)
		cQuery := " SELECT "+cCampo+" FROM "+RetSqlName("SF7")+" SF7 "+CRLF
		cQuery += " WHERE SF7.D_E_L_E_T_ = ' ' "+CRLF
		cQuery += " AND SF7.F7_FILIAL = '"+cYFil+"' "+CRLF
		cQuery += " AND SF7.F7_GRTRIB = '"+SB1->B1_GRTRIB+"' "+CRLF
		cQuery += " AND SF7.F7_EST = '"+cEst+"' "+CRLF
		
		dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
		
		(cArqTmp)->(DbGoTop())
		If (cArqTmp)->(!eof())
			xRet := (cArqTmp)->&cCampo
		Else
			xRet := 0
		EndIf
		
		(cArqTmp)->(DbCloseArea())
	EndIf
EndIf

RestArea(aArea) 

Return xRet





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL202  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RL202Write(cLine)
FWrite(nHdl,cLine,Len(cLine))

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL202  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL202Cabec(aAux)
Local cCabec:=""
Default aAux:={}

cCabec:='<?xml version="1.0"?>'+CRLF
cCabec+='<?mso-application progid="Excel.Sheet"?>'+CRLF
cCabec+='<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cCabec+=' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF
cCabec+=' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF
cCabec+=' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
cCabec+=' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
cCabec+=' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cCabec+='  <Author>Cleverson Silva</Author>'+CRLF
cCabec+='  <LastAuthor>Cleverson Silva</LastAuthor>'+CRLF
cCabec+='  <Created>2012-12-04T13:54:33Z</Created>'+CRLF
cCabec+='  <Version>14.00</Version>'+CRLF
cCabec+=' </DocumentProperties>'+CRLF
cCabec+=' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
cCabec+='  <AllowPNG/>'+CRLF
cCabec+=' </OfficeDocumentSettings>'+CRLF
cCabec+=' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
cCabec+='  <WindowHeight>7440</WindowHeight>'+CRLF
cCabec+='  <WindowWidth>20115</WindowWidth>'+CRLF
cCabec+='  <WindowTopX>240</WindowTopX>'+CRLF
cCabec+='  <WindowTopY>375</WindowTopY>'+CRLF
cCabec+='  <ActiveSheet>1</ActiveSheet>'+CRLF
cCabec+='  <ProtectStructure>False</ProtectStructure>'+CRLF
cCabec+='  <ProtectWindows>False</ProtectWindows>'+CRLF
cCabec+=' </ExcelWorkbook>'+CRLF
cCabec+=' <Styles>'+CRLF
cCabec+='  <Style ss:ID="Default" ss:Name="Normal">'+CRLF
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+CRLF
cCabec+='   <Borders/>'+CRLF
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
cCabec+='   <Interior/>'+CRLF
cCabec+='   <NumberFormat/>'+CRLF
cCabec+='   <Protection/>'+CRLF
cCabec+='  </Style>'+CRLF
cCabec+='  <Style ss:ID="s62" ss:Name="Normal 2">'+CRLF
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+CRLF
cCabec+='   <Borders/>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Swiss" ss:Color="#000000"/>'+CRLF
cCabec+='   <Interior/>'+CRLF
cCabec+='   <NumberFormat/>'+CRLF
cCabec+='   <Protection/>'+CRLF
cCabec+='  </Style>'+CRLF
cCabec+='  <Style ss:ID="s63" ss:Name="Separador de milhares 2">'+CRLF
cCabec+='   <NumberFormat ss:Format="_(* #,##0.00_);_(* \(#,##0.00\);_(* &quot;-&quot;??_);_(@_)"/>'+CRLF
cCabec+='  </Style>'+CRLF
cCabec+='  <Style ss:ID="s16" ss:Name="VÃ­rgula">'+CRLF
cCabec+='   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF
cCabec+='  </Style>'+CRLF
cCabec+='  <Style ss:ID="s64">'+CRLF
cCabec+='   <NumberFormat ss:Format="@"/>'+CRLF
cCabec+='  </Style>'+CRLF
cCabec+='  <Style ss:ID="s65">'+CRLF
cCabec+='   <NumberFormat ss:Format="Short Date"/>'+CRLF
cCabec+='  </Style>'+CRLF
cCabec+='  <Style ss:ID="s66">'+CRLF
cCabec+='   <NumberFormat ss:Format="Standard"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s67">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="@"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s68">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="Short Date"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s69">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="Standard"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s71" ss:Parent="s16">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="Standard"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s72" ss:Parent="s16">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="Short Date"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s73">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11"'+CRLF
cCabec+='    ss:Color="#000000" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="Standard"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s74" ss:Parent="s16">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Comic Sans MS" x:Family="Script" ss:Size="11"'+CRLF
cCabec+='    ss:Color="#000000" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="Standard"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s76" ss:Parent="s62">'+CRLF
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Courier New" x:Family="Modern"/>'+CRLF
cCabec+='   <Interior ss:Color="#CCC0DA" ss:Pattern="Solid"/>'+CRLF
cCabec+='   <NumberFormat ss:Format="@"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s78" ss:Parent="s63">'+CRLF
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Courier New" x:Family="Modern"/>'+CRLF
cCabec+='   <Interior ss:Color="#CCC0DA" ss:Pattern="Solid"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s79">'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <NumberFormat ss:Format="@"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s80" ss:Parent="s63">'+CRLF
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Courier New" x:Family="Modern"/>'+CRLF
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+='  <Style ss:ID="s81" ss:Parent="s63">'+CRLF
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
cCabec+='   <Borders>'+CRLF
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
cCabec+='   </Borders>'+CRLF
cCabec+='   <Font ss:FontName="Courier New" x:Family="Modern" ss:Bold="1"/>'+CRLF
cCabec+='   <Interior ss:Color="#FABF8F" ss:Pattern="Solid"/>'+CRLF
cCabec+='  </Style>'+CRLF

cCabec+=' </Styles>'+CRLF
cCabec+=' <Worksheet ss:Name="Original">'+Enter
cCabec+='  <Table ss:ExpandedColumnCount="48" ss:ExpandedRowCount="99999" x:FullColumns="1"'+Enter
cCabec+='   x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0"/>'+Enter
cCabec+='   <Column ss:StyleID="s65" ss:Width="80.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s65" ss:Width="79.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="67.5" ss:Span="1"/>'+Enter
cCabec+='   <Column ss:Index="6" ss:StyleID="s64" ss:Width="66.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="67.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="84.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="80.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="84"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="89.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="72"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="90"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="96.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s65" ss:Width="72"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="78.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="76.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="62.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="68.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="83.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="90.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="69"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="69"/>'+Enter
cCabec+='   <Column ss:StyleID="s65" ss:Width="78.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="28.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="58.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="95.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="123"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="111"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="95.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="123"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="111"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="115.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="143.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="126"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="116.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="144"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:Width="126.75"/>'+Enter
cCabec+='   <Column ss:Index="40" ss:Width="50.25"/>'+Enter
cCabec+='   <Column ss:Width="45"/>'+Enter
cCabec+='   <Column ss:Width="81"/>'+Enter
cCabec+='   <Column ss:Width="108.75"/>'+Enter
cCabec+='   <Column ss:Width="68.25"/>'+Enter
cCabec+='   <Column ss:Width="96.75"/>'+Enter

cCabec+='   <Column ss:Width="96.75"/>'+Enter
cCabec+='   <Column ss:Width="96.75"/>'+Enter
cCabec+='   <Column ss:Width="96.75"/>'+Enter

cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="18">'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Filial</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data Entrada</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data EmissÃ£o</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Doc. Fiscal</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Estado Ref</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Cod. Fiscal</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">AlÃ­q. ICMS</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr ContÃ¡bil</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Base ICMS</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Valor ICMS</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Base IPI</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Valor IPI</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Base Ret</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr ICMS Ret</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s68"><Data ss:Type="String">Data Cancel</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">Cod. Produto</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Vlr Despesas</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">CÃ³d. NCM</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Quantidade</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">PreÃ§o Unit.</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Desconto</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"><Data ss:Type="String">Vlr Total</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s67"><Data ss:Type="String">NF Original</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s72"><Data ss:Type="String">Data emissÃ£o</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s73"><Data ss:Type="String">IVA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR SOFTWARE</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR FRE/SEG.</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS SOFTWARE</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS FRE/SEG.</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST SOFTWARE</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">BASE ST FRE/SEG</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST SOFTWARE</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ICMS ST FRE/SEG</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"/>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ALI IPI</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">VLOR SOFTWARE</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">IPI MIDIA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">IPI SOFTWARE</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ALIQ. INTERN.</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">GRP.TRIBUTACAO</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="String">ORIGEM PRODUTO</Data></Cell>'+Enter
cCabec+='   </Row>    '+Enter


Return cCabec
     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetCtParamºAutor  ³Elton C.		     º Data ³  03/13/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o conteudo do parametro e ou cria o parametro       º±±
±±º          ³caso não exista                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                              	          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCtParam( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)
lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
RecLock( "SX6", lRecLock )
FieldPut( FieldPos( "X6_VAR" ), cMvPar )
FieldPut( FieldPos( "X6_TIPO" ), cTipo )
FieldPut( FieldPos( "X6_PROPRI" ), "U" )
If !Empty( cDescP )
	FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
	FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
	FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
EndIf
If !Empty( cDescS )
	FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
	FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
	FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
EndIf
If !Empty( cDescE )
	FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
	FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
	FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
EndIf
If lRecLock .Or. lAlter
	FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
	FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
	FieldPut( FieldPos( "X6_CONTENG" ), xValor )
EndIf

MsUnlock()

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn)

