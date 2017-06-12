#INCLUDE "RWMAKE.CH"
#INCLUDE "FIVEWIN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ NFATR07  ³ Autor ³ Aristoteles           ³ Data ³ 02.02.05  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Notas Fiscais com Desconto                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NFATR07()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL CbTxt
LOCAL CbCont,wnrel
LOCAL nOrdem,cFiltro := ""
LOCAL tamanho:= "G"
LOCAL limite := 220
LOCAL titulo := "Relacao de Notas Fiscais com desconto"
LOCAL cDesc1 := "Este programa ira emitir a relacao de descontos concedidos."
LOCAL cDesc2 := ""
LOCAL cDesc3 := ""
LOCAL cString:= "SF2"

Public _aCampos := {}
Public aCabec	:= {}
Public aItensExcel	:= {}

PRIVATE aReturn := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
PRIVATE nomeprog:="NFATR07"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="FATR07"
PRIVATE cQuebra1:=" "
PRIVATE cQuebra2:=" "
Private _cArqTmp	:= ""
Private _cIndTmp	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt 	:= SPACE(10)
cbcont 	:= 0
li 		:= 80
m_pag 	:= 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte("FATR07",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Nota                              ³
//³ mv_par02             // Ate a Nota                           ³
//³ mv_par03             // De Data                              ³
//³ mv_par04             // Ate a Data                           ³
//³ mv_par05             // De Produto                           ³
//³ mv_par06             // Ate o Produto                        ³
//³ mv_par07             // Da Serie                             ³
//³ mv_par08             // Da Serie                             ³
//³ mv_par09             // De  Grupo                            ³
//³ mv_par10             // Ate Grupo                            ³
//³ mv_par11             // De  Tipo                             ³
//³ mv_par12             // Ate Tipo                             ³
//³ mv_par13             // So diferencas ?                      ³
//³ mv_par14             // moeda?                               ³
//³ mv_par15             // De Cliente                           ³
//³ mv_par16             // Ate Cliente
//³ mv_par17
//³ mv_par18
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="NFATR07"

// Foi retirado o filtro somente para Localizacoes
// Sergio Fuzinaka - 19.10.01
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey==27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| C550Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C550IMP  ³ Autor ³ Rosane Luciane Chene  ³ Data ³ 09.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR550			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function C550Imp(lEnd,WnRel,cString)

LOCAL nCt := 0
LOCAL dDatAnt:= CTOD('  /  /  ')
LOCAL nAcD1  := 0, nAcD2 := 0, nAcD3 := 0, nAcD4 := 0, nAcD5 := 0, nAcD6:= 0, nAcD7 := 0
LOCAL nAcN1  := 0, nAcN2 := 0, nAcN3 := 0, nAcN4 := 0, nAcN5 := 0
LOCAL nAcN6  := 0, nAcG1 := 0, nAcG2 := 0, nAcG3 := 0, nAcG4 := 0
LOCAL nAcG5  := 0, nAcG6 := 0, nAcG7 := 0, nVlrISS := 0,nCompIcm := 0
LOCAL _nPorcDifDia	 := 0
LOCAL _nPorcDif		 := 0
LOCAL _nPorcDifGeral := 0
LOCAL nPorcDifGeral2 := 0
LOCAL lContinua	:= .T., dEmisAnt
LOCAL cCondicao
LOCAL nReg     	:=0
LOCAL nTotQuant	:=0
LOCAL nTotal   	:=0
LOCAL nTotIcm  	:=0
LOCAL nTotIPI  	:=0
LOCAL cCf      	:=""
LOCAL cTes    	:=""
LOCAL cLocal   	:=""
LOCAL cItemPv  	:=""
LOCAL cNumPed  	:=""
LOCAL nPrcVen  	:=0
LOCAL tamanho	:= "G"
LOCAL limite 	:= 220
LOCAL cabec1,cabec2,cabec3
Local dEmiDia     := dDataBase
Local nValEst     :=0
Local nVTotG:=0
Local nVTotDia:=0
Local _nPorcDifTot:=0
Local nTotalMer   :=0
Local nTotMDia    :=0
Local nValTotal   :=0
Local nTotMg      :=0
Local nTotBrut  := 0
Local nTotTabBr := 0
Local nTotPrLiq := 0
Local nTotCust  := 0
Local nTotDesp  := 0
Local nTotMC    := 0
Local nDiaBrut  := 0
Local nDiaTabBr	:= 0
Local nDiaPrLiq := 0
Local nDiaCust  := 0
Local nDiaDesp  := 0
Local nDiaMC	:= 0
Local nGerBrut  := 0
Local nGerTabBr := 0
Local nGerPrLiq := 0
Local nGerCust  := 0
Local nGerDesp  := 0
Local nGerMC	:= 0

/*
aAdd(aCabec,{"CODCLI","C",6,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"LOJACLI","C",2,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"NOMCLI","C",60,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"EST","C",2,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"EMISSAO","D",8,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"TIPONF","C",1,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"CFOP","C",5,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"VEND","C",6,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"NOMVEND","C",40,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"YCANAL","C",15,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"YDCANAL","C",15,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"CODPRO","C",15,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"DESCR","C",100,00})	//Descricao NG B1_XDESC
aAdd(aCabec,{"QTDVEN","N",12,2})	//Quantidade de venda
aAdd(aCabec,{"CMVUNIT","C",12,2})	//Custo unitário 
aAdd(aCabec,{"PRCVEN","N",12,2})	//C6_PRCVEN
aAdd(aCabec,{"PRCTAB","N",12,2})		//C6_PRCTAB
aAdd(aCabec,{"CMVTOT","N",12,2})	//Custo total da movimentação
aAdd(aCabec,{"VMRGBRUT","N",12,2})		//Margem Bruta Valor
aAdd(aCabec,{"PMRGBRUT","N",12,2})		//Margem Bruta Valor
aAdd(aCabec,{"MKPVEND","N",12,2})		//Mark-Up Venda
aAdd(aCabec,{"MKPTAB","N",12,2})		//Mark-Up Tabela
aAdd(aCabec,{"DESPVAR","N",12,2})		//Despesa Variável
aAdd(aCabec,{"VMRGMC","N",12,2})		//Margem Contribuição R$
aAdd(aCabec,{"PMRGMC","N",12,2})		//Margem Contribuição %
aAdd(aCabec,{"PDIFREA","N",12,2})		//% Dif Real
aAdd(aCabec,{"PRCSIMP","N",12,2})		//Preço sem Imposto Unit
aAdd(aCabec,{"USRLIB","C",15,0})		//Usuário Lib
aAdd(aCabec,{"PEDIDO","C",6,0})		//Número do pedido de vendas
aAdd(aCabec,{"NOTA","C",9,0})		//Número do pedido de vendas
aAdd(aCabec,{"SERIE","C",3,0})		//Número do pedido de vendas
aAdd(aCabec,{"CONDPAG","C",3,0})		//Número do pedido de vendas
aAdd(aCabec,{"DCONDPAG","C",3,0})		//Número do pedido de vendas
*/

aAdd(_aCampos,{"Cod. Cliente","C",6,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Loja Cliente","C",2,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Nome Cliente","C",60,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Estado","C",2,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Emissão","D",8,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Tipo da Nota","C",1,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"CFOP","C",5,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Vendedor","C",6,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Nome Vendedor","C",40,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Cod. Canal","C",15,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Descrição Canal","C",15,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Cod. Produto","C",15,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"Descrição","C",100,00})	//Descricao NG B1_XDESC
aAdd(_aCampos,{"Quantidade","N",12,2})	//Quantidade de venda
aAdd(_aCampos,{"Custo Unit","C",12,2})	//Custo unitário 
aAdd(_aCampos,{"Prc Venda s/ IPI","N",12,2})	//C6_PRCVEN
aAdd(_aCampos,{"Preço Tabela","N",12,2})		//C6_PRCTAB
aAdd(_aCampos,{"Custo Total","N",12,2})	//Custo total da movimentação
aAdd(_aCampos,{"Margem Bruta R$","N",12,2})		//Margem Bruta Valor
aAdd(_aCampos,{"Margem Bruta %","N",12,2})		//Margem Bruta Valor
aAdd(_aCampos,{"Mark-Up Venda","N",12,2})		//Mark-Up Venda
aAdd(_aCampos,{"Mark-Up Tabela","N",12,2})		//Mark-Up Tabela
aAdd(_aCampos,{"Despesa Variável","N",12,2})		//Despesa Variável
aAdd(_aCampos,{"Margem Contribuição R$","N",12,2})		//Margem Contribuição R$
aAdd(_aCampos,{"Margem Contribuição %","N",12,2})		//Margem Contribuição %
aAdd(_aCampos,{"% Dif Real","N",12,2})		//% Dif Real
aAdd(_aCampos,{"Preço sem Imposto Unit","N",12,2})		//Preço sem Imposto Unit
aAdd(_aCampos,{"Usuário Lib","C",15,0})		//Usuário Lib
aAdd(_aCampos,{"Pedido","C",6,0})		//Número do pedido de vendas
aAdd(_aCampos,{"Nota Fiscal","C",9,0})		//Número do pedido de vendas
aAdd(_aCampos,{"Série","C",3,0})		//Número do pedido de vendas
aAdd(_aCampos,{"Cond Pgto","C",3,0})		//Número do pedido de vendas
aAdd(_aCampos,{"Descr Cond Pgto","C",3,0})		//Número do pedido de vendas
aAdd(_aCampos,{"","C",1,0})		//Número do pedido de vendas

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Imporessao do Cabecalho e Rodape   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := Space(10)
cbcont   := 00
li       := 80
m_pag    := 01
imprime  := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Cabecalho de acordo com o tipo de emissao            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := "RELACAO DAS DIFERENCAS ENTRE VALOR DE VENDA E TABELA FATURADOS "

//Cabec1 := "                                                                VALOR UNITARIO                       M A R K U P            Margem Bruta               Preço sem   DESCONTO MAX                     "
//Cabec2 := "PRODUTO          DESCRICAO                       QUANTIDADE  CUSTO UNIT  VENDA S/IPI   TABELA       VENDA   TABELA         Valor       %    % DIF REAL  Imposto   %GRUPO %CLIENTE USUARIO LIB.    CUSTO TOTAL   PEDIDO"

Cabec1 := "                                                                VALOR UNITARIO                                      Margem Bruta         M A R K U P     DESPESA     Margem Contrib               Preço sem"
// 0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
Cabec2 := "PRODUTO       DESCRICAO                       QUANTIDADE  CUSTO UNIT   VENDA S/IPI     TABELA     CUSTO TOTAL      Valor       %        VENDA   TABELA   VARIAVEL    Valor       %      %DIF REAL Imposto  USER LIB  PEDIDO "


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Indice de Trabalho                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SF2")
cIndex := CriaTrab("",.F.)
cKey := 'F2_FILIAL+DTOS(F2_EMISSAO)+F2_DOC+F2_SERIE'

cCondicao := 'F2_FILIAL=="'+xFilial("SF2")+'".And.F2_DOC>="'+mv_par01+'"'
cCondicao += '.And.F2_DOC<="'+mv_par02+'".And.DTOS(F2_EMISSAO)>="'+DTOS(mv_par03)+'"'
cCondicao += '.And.DTOS(F2_EMISSAO)<="'+DTOS(mv_par04)+'".And. F2_SERIE>="'+mv_par07+'".And.F2_SERIE<= "'+mv_par08+'"'
cCondicao += '.And.F2_CLIENTE>="'+mv_par15+'".And.F2_CLIENTE<="'+mv_par16+'"'

#IFDEF TOP
	IF !Empty(aReturn[7])   // Coloca expressao do filtro
		cCondicao += '.And.'+aReturn[7]
	Endif
#ENDIF
IndRegua("SF2",cIndex,cKey,,cCondicao)
nIndex := RetIndex("SF2")

#IFNDEF TOP
	IF !Empty(aReturn[7])   // Coloca expressao do filtro
		Set Filter to &( aReturn[7] )
	Endif
#ENDIF

dbSelectArea("SF2")
#IFNDEF TOP
	dbSetIndex(cIndex+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGoTop()

SetRegua(RecCount())		// Total de Elementos da regua

IF MV_PAR19 == 1
	
	While !Eof() .and. lContinua
		
		IF lEnd
			@Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		Endif
		
		IncRegua()
		
		dEmisAnt := SF2->F2_EMISSAO
		dbSelectArea("SD2")
		dbSetOrder(3)
		dbSeek(XFILIAL("SF2")+SF2->F2_DOC+SF2->F2_SERIE)
		
		nCt := 1
		_nCont := 0
		nTotalMer :=0
		NTotalEst :=0
		nTotBrut  := 0
		nTotCust  := 0
		nTotTabBr := 0
		nTotPrLiq := 0
		nTotDesp  := 0
		nTotMC	  := 0

		
//		IF (ALLTRIM(POSICIONE("SA3",1,xFilial("SA3")+SF2->F2_VEND1,"A3_GRPREP")) $ ALLTRIM(MV_PAR18).OR. EMPTY(MV_PAR18))
		IF (ALLTRIM(SF2->F2_YCANAL) $ ALLTRIM(MV_PAR18).OR. EMPTY(MV_PAR18))
			
			While !Eof() .and. SD2->D2_DOC+SD2->D2_SERIE  == SF2->F2_DOC+SF2->F2_SERIE
				
				If SD2->D2_COD < mv_par05 .Or. SD2->D2_COD > mv_par06 .Or. SD2->D2_GRUPO < mv_par09 .Or. ;
					SD2->D2_GRUPO > mv_par10 .Or. SD2->D2_TP < mv_par11 .Or. SD2->D2_TP > mv_par12 .Or. ;
					SD2->D2_SERIE < mv_par07 .Or. SD2->D2_SERIE > mv_par08
					dbSkip()
					Loop
				Endif
				
				If li > 52
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
				EndIf
				
				sf4->(dbSetOrder(1))
				sf4->(dbSeek(xFilial("SF4")+SD2->D2_TES))
				
				/* Checa se a tes é tes de venda se não for pula o registro */
				
				if sf4->f4_venda!='S'
					DbSkip()//sf2->(DbSkip())
					Loop
				Endif
				
				
				
				cItemPv  :=SD2->D2_ITEMPV
				cNumPed  :=SD2->D2_PEDIDO
				dbSelectArea("SC5")
				dbSetOrder(1)
				dbSeek(xFilial("SC5")+cNumPed)
				cCodTab	:= SC5->C5_TABELA
				nDscCabec:= SC5->C5_DESC1
				
				dbSelectArea("SC6")
				dbSetOrder(2)
				dbSeek(xFilial("SC6")+SD2->D2_COD+cNumPed+cItemPv,.F.)
				
				_nVlrTabela := SC6->C6_PRCTAB
				nValEst  	:=_nVlrTabela
				nDescRegra	:= SC6->C6_PREGDES
				cRegraDesc	:= SC6->C6_REGDESC
				nValBrut	:= SD2->D2_VALBRUT
				nCusto		:= SD2->D2_CUSTO1
				
				_nPorcDif   := ROUND(((SD2->D2_PRCVEN/_nVlrTabela)*100) - 100,2) //ROUND((((SD2->D2_PRCVEN+(SD2->D2_VALIPI/SD2->D2_QUANT))/nValEst)*100) - 100,2)
				
				If MV_PAR13 == 1 .and. _nPorcDif > (MV_PAR17*(-1)) //(_nPorcDif < MV_PAR17 .OR. _nPorcDif > (MV_PAR17*(-1)))
					dbSelectArea("SD2")
					SD2->(dbSkip())
					Loop
				EndIf
				// regra do mark-up mínimo
				If MV_PAR20 == 1 .and. SD2->(D2_VALBRUT/D2_CUSTO1) > MV_PAR21 //
					dbSelectArea("SD2")
					SD2->(dbSkip())
					Loop
				EndIf
				
				dbSelectArea("SA3")
				dbSetOrder(1)
				dbSeek(xFilial("SA3")+SF2->F2_VEND1)
				
				If nCt == 1
					If SD2->D2_TIPO $ "BD"
						dbSelectArea("SA2")
						dbSetOrder(1)
						dbSeek(xFilial()+SD2->D2_CLIENTE+SD2->D2_LOJA)
						@Li ,   0 PSAY "FORNECEDOR : " +A2_COD+" "+A2_LOJA+" - "+A2_NOME+" "+"EMISSAO : "+DTOC(SF2->F2_EMISSAO)+" TIPO DA NOTA : "+SD2->D2_TIPO+" CFOP : " +SD2->D2_CF
					Else
						dbSelectArea("SA1")
						dbSetOrder(1)
						dbSeek(xFilial()+SD2->D2_CLIENTE+SD2->D2_LOJA)
						
//						@Li ,   0 PSAY "CLIENTE: "+A1_COD+" "+A1_LOJA+" - "+A1_NOME+" ESTADO : "+SD2->D2_EST+" EMISSAO : "+DTOC(SF2->F2_EMISSAO)+" TIPO DA NOTA : "+SD2->D2_TIPO+" CFOP: " +SD2->D2_CF+"  VENDEDOR : "+ALLTRIM(SF2->F2_VEND1)+" - "+ALLTRIM(SUBSTR(SA3->A3_NOME,1,30))+"  GRP VEND: "+ALLTRIM(SA3->A3_GRPREP)+" - "+ALLTRIM(POSICIONE("ACA",1,XFILIAL("ACA")+SA3->A3_GRPREP,"ACA_DESCRI"))
						@Li ,   0 PSAY "CLIENTE: "+A1_COD+" "+A1_LOJA+" - "+A1_NOME+" ESTADO : "+SD2->D2_EST+" EMISSAO : "+DTOC(SF2->F2_EMISSAO)+" TIPO DA NOTA : "+SD2->D2_TIPO+" CFOP: " +SD2->D2_CF+"  VENDEDOR : "+ALLTRIM(SF2->F2_VEND1)+" - "+ALLTRIM(SUBSTR(SA3->A3_NOME,1,30))+"  GRP VEND: "+ALLTRIM(SF2->F2_YCANAL)+" - "+ALLTRIM(POSICIONE("ACA",1,XFILIAL("ACA")+SF2->F2_YCANAL,"ACA_DESCRI"))
					EndIf
					nCt++
					Li++
					dbSelectArea("SD2")
				EndIf
				
				dbSelectArea("SB1")
				dbSetOrder(1)
				dbSeek(xFilial()+SD2->D2_COD,.F.)
				
				dbSelectArea("SBM")
				dbSetOrder(1)
				dbSeek(xFilial("SBM")+SB1->B1_GRUPO,.F.)
				
				nFatVar	:= 0
				
				cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario
				
				cQry	:= " SELECT ZE_FILIAL, ZE_COD, ZE_CLIENTE, ZE_LOJA, ZE_CANAL, ZE_DTINI, ZE_DTFIM, 
				cQry	+= " SUM(ZE_DESP01+ZE_DESP02+ZE_DESP03+ZE_DESP04+ZE_DESP05+ZE_DESP06+ZE_DESP07) TOTALDESP
				cQry	+= " FROM SZE010 SZE
				cQry	+= " WHERE SZE.D_E_L_E_T_ = ' '
				cQry	+= " AND SZE.ZE_FILIAL = '"+xFilial("SZE")+"'
				cQry	+= " AND SZE.ZE_DTFIM >= '"+dtos(ddatabase)+"'
				cQry	+= " AND SZE.ZE_DTINI <= '"+dtos(ddatabase)+"'
				cQry	+= " AND ((SZE.ZE_CLIENTE = ' ' AND SZE.ZE_LOJA = ' ' AND SZE.ZE_CANAL = '"+SF2->F2_YCANAL+"')
				cQry	+= " OR (SZE.ZE_CLIENTE = '"+SD2->D2_CLIENTE+"' AND SZE.ZE_LOJA = ' ' AND SZE.ZE_CANAL = '"+SF2->F2_YCANAL+"')
				cQry	+= " OR (SZE.ZE_CLIENTE = '"+SD2->D2_CLIENTE+"' AND SZE.ZE_LOJA = '"+SD2->D2_LOJA+"' AND SZE.ZE_CANAL = '"+SF2->F2_YCANAL+"'))
				cQry	+= " GROUP BY ZE_FILIAL, ZE_COD, ZE_CLIENTE, ZE_LOJA, ZE_CANAL, ZE_DTINI, ZE_DTFIM
				cQry	+= " ORDER BY ZE_CLIENTE DESC, ZE_LOJA DESC, ZE_CANAL DESC
				cQry := ChangeQuery(cQry)
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)
				
				DbSelectArea("cArqTRB")
				cArqTRB->(dbgotop())
				While !Eof() 
					If cArqTRB->TOTALDESP > 0 
						nFatVar := cArqTRB->TOTALDESP
						Exit
					EndIf			
				End
				DbSelectArea("cArqTRB")
				dbclosearea()

				dbSelectArea("SD2")
				nTabVdIPI	:= round(((_nVlrTabela*SD2->D2_QUANT)*(SD2->D2_IPI/100)),2)+(_nVlrTabela*SD2->D2_QUANT)+SD2->(D2_VALFRE+D2_SEGURO+D2_DESPESA) // VALOR VENDA TABELA COM IPI  + frete + seguro + despesa
				nVlIVA		:= nTabVdIPI+round((nTabVdIPI*(SD2->D2_MARGEM/100)),2) // BASE ICMS-ST TABELA
				nVlSol		:= IF(SD2->D2_ICMSRET>0,round((nVlIVA*(SD2->D2_ALIQSOL/100))-((_nVlrTabela*SD2->D2_QUANT)*SD2->D2_PICM/100),2),0) //VALOR DO ICMS-ST TABELA
				nVlTabTot	:= nTabVdIPI+nVlSol // valor tabela + icms-st + ipi
				
				nMrgBrut	:= SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)-SD2->D2_CUSTO1 //margem bruta
				nPmrgbrut	:= (nMrgBrut/SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6))*100 // % margem Bruta
				nDespvar	:= nValBrut*(nFatVar/100)
				
				@Li ,000 PSAY SD2->D2_COD
				@li ,015 PSAY Substr(SB1->B1_XDESC,1,29)
				@Li ,044 PSAY SD2->D2_QUANT     	PICTURE PESQPICTQT("D2_QUANT",11)
				@Li ,057 PSAY SD2->(D2_CUSTO1/D2_QUANT) 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				@Li ,069 PSAY SD2->D2_PRCVEN		PICTURE PESQPICT("SD2","D2_PRCVEN",12)//((SD2->D2_PRCVEN+(SD2->D2_VALIPI/SD2->D2_QUANT)))	PICTURE PESQPICT("SD2","D2_PRCVEN",16)
				@Li ,082 PSAY _nVlrTabela			PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				@Li ,095 PSAY SD2->D2_CUSTO1 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				//margem Bruta (Valor)
				@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				//margem Bruta (%)
				@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//mark-up venda
				@Li ,133 PSAY SD2->(D2_VALBRUT/D2_CUSTO1)	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//mark-up tabela
				@Li ,141 PSAY nVlTabTot/SD2->D2_CUSTO1	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//despesas variáveis
				@Li ,151 PSAY nDespVar 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
				//Margem líquida MC
				@Li ,160 PSAY nMrgBrut-nDespVar		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				@Li ,172 PSAY (nMrgBrut-nDespVar)/SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)		PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				@Li ,182 PSAY IIF(_nPorcDif<mv_par17.or._nPorcDif>(mv_par17*(-1)),_nPorcDif,0)	PICTURE PESQPICT("SD2","D2_DESC",7)//"999.99"
				@Li ,192 PSAY SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)/SD2->D2_QUANT	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				@Li ,204 PSAY alltrim(SC6->C6_X_USRLB)
				@Li ,215 PSAY cNumPed 				PICTURE PESQPICT("SC6","C6_NUM")
				
				nAcN1 += SD2->D2_QUANT
			
				aItem := Array(Len(_aCampos))				

				aItem[01] := CHR(160) + SD2->D2_CLIENTE		//Codigo Nc B1_COD
				aItem[02] := CHR(160) + SD2->D2_LOJA		//Codigo Nc B1_COD
				aItem[03] := iif(SD2->D2_TIPO $ "BD",SA2->A2_NOME,SA1->A1_NOME)		//Codigo Nc B1_COD
				aItem[04] := SD2->D2_EST		//Codigo Nc B1_COD
				aItem[05] := SD2->D2_EMISSAO		//Codigo Nc B1_COD
				aItem[06] := SD2->D2_TIPO		//Codigo Nc B1_COD
				aItem[07] := SD2->D2_CF		//Codigo Nc B1_COD
				aItem[08] := SA3->A3_COD		//Codigo Nc B1_COD
				aItem[09] := SA3->A3_NOME		//Codigo Nc B1_COD
				aItem[10] := CHR(160) + SF2->F2_YCANAL		//Codigo Nc B1_COD
				aItem[11] := POSICIONE("ACA",1,XFILIAL("ACA")+SF2->F2_YCANAL,"ACA_DESCRI")		//Codigo Nc B1_COD
				aItem[12] := CHR(160) + SD2->D2_COD		//Codigo Nc B1_COD
				aItem[13] := SB1->B1_XDESC	//Descricao NG B1_XDESC
				aItem[14] := SD2->D2_QUANT	//Quantidade de venda
				aItem[15] := round(SD2->(D2_CUSTO1/D2_QUANT),2)	//Custo unitário 
				aItem[16] := SD2->D2_PRCVEN	//C6_PRCVEN
				aItem[17] := _nVlrTabela		//C6_PRCTAB
				aItem[18] := SD2->D2_CUSTO1	//Custo total da movimentação
				aItem[19] := round(nMrgBrut,2)		//Margem Bruta Valor
				aItem[20] := round(nPmrgbrut,2)		//Margem Bruta Percentual
				aItem[21] := round(SD2->(D2_VALBRUT/D2_CUSTO1),2)		//Mark-Up Venda
				aItem[22] := round(nVlTabTot/SD2->D2_CUSTO1,2)		//Mark-Up Tabela
				aItem[23] := round(nDespVar,2)		//Despesa Variável
				aItem[24] := round(nMrgBrut-nDespVar,2)		//Margem Contribuição R$
				aItem[25] := round((nMrgBrut-nDespVar)/SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6),2)		//Margem Contribuição %
				aItem[26] := IIF(_nPorcDif<mv_par17.or._nPorcDif>(mv_par17*(-1)),_nPorcDif,0)		//% Dif Real
				aItem[27] := round(SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)/SD2->D2_QUANT,2)		//Preço sem Imposto Unit
				aItem[28] := alltrim(SC6->C6_X_USRLB)		//Usuário Lib
				aItem[29] := SD2->D2_PEDIDO		//Número do pedido de vendas
				aItem[30] := CHR(160) + SD2->D2_DOC		//Número do pedido de vendas
				aItem[31] := SD2->D2_SERIE		//Número do pedido de vendas
				aItem[32] := CHR(160) + SF2->F2_COND		//Número do pedido de vendas
				aItem[33] := POSICIONE("SE4",1,XFILIAL("SE4")+SF2->F2_COND,"E4_DESCRI")		//Número do pedido de vendas


				AADD(aItensExcel,aItem)
				aItem := {}

				
				If SF4->F4_AGREG <> "N"
					nAcN2     += SD2->D2_TOTAL //((SD2->D2_TOTAL+SD2->D2_VALIPI))
					nTotalMer += SD2->D2_TOTAL //((SD2->D2_TOTAL+SD2->D2_VALIPI))
					nTotBrut  += SD2->D2_VALBRUT
					nTotCust  += SD2->D2_CUSTO1
					nTotPrLiq += SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)
					nTotTabBr += nVlTabTot
					nTotDesp  += nDespVar
					nTotMC	  += nMrgBrut-nDespVar

					nAcN3 += _nVlrTabela * SD2->D2_QUANT
				Endif
				
				Li++
				
				dEmiDia := SD2->D2_EMISSAO
				_nCont := _nCont +1
				dbSkip()
				
			EndDo // Nota
			
			If _nCont > 0
				
				//    		_nPorcDifTot := ((nTotalMer/nTotalEst)*100) - 100
				_nPorcDifTot := ((nTotalMer/nAcN3)*100) - 100
				nTotMDia   +=nTotalMer
				
				//nVTotDia+=nTotalEst
				nVTotDia+=nAcN3
				
				
				@Li ,000 PSAY "TOTAL DA NOTA - "+SF2->F2_DOC+" / "+SF2->F2_SERIE+" ---->"
				@Li ,044 PSAY nAcN1    								PICTURE PESQPICTQT("D2_QUANT",11)
				@Li ,069 PSAY nAcN2    								PICTURE TM(nAcN2    ,12)
				@Li ,082 PSAY nAcN3    								PICTURE TM(nAcN3    ,12)
				@Li ,095 PSAY nTotCust		 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				//margem Bruta (Valor)
				nMrgBrut	:= nTotPrLiq-nTotCust //margem bruta
				@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				//margem Bruta (%)
				nPmrgbrut	:= (nMrgBrut/nTotPrLiq)*100 // % margem Bruta
				@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//mark-up venda
				@Li ,133 PSAY nTotBrut/nTotCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//mark-up tabela
				@Li ,141 PSAY nTotTabBr/nTotCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				@Li ,151 PSAY nTotDesp 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
				//Margem líquida MC
				@Li ,160 PSAY nTotMC 				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				@Li ,172 PSAY (nTotMC)/nTotPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				@Li ,182 PSAY IIF(Round(_nPorcDifTot,2)<mv_par17.or.Round(_nPorcDifTot,2)>(mv_par17*(-1)),Round(_nPorcDifTot,2),0)					PICTURE PESQPICT("SD2","D2_DESC",7) //"99,999.99"

				@Li ,192 PSAY nTotPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				Li++
				@Li ,000 PSAY "COND: "+SF2->F2_COND+" - "+ALLTRIM(POSICIONE("SE4",1,XFILIAL("SE4")+SF2->F2_COND,"E4_DESCRI"))
				Li++
				@Li ,  0 PSAY __PrtThinLine()
				Li++
				nAcG1 += nAcN1
				nAcG2 += nAcN2
				nAcG3 += nAcN3
				nTotalEst:=0
				nAcD1 += nAcN1
				nAcD2 += nAcN2
				nAcD3 += nAcN3
				nAcn1 := 0
				nAcn2 := 0
				nAcn3 := 0

				//acumula valores diários 
				nDiaBrut  += nTotBrut
				nDiaCust  += nTotCust
				nDiaTabBr += nTotTabBr								
				nDiaPrLiq += nTotPrLiq
				nDiaDesp  += nTotDesp
				nDiaMC	  += nTotMC
				//acumula valores diários 
				nGerBrut  += nTotBrut
				nGerCust  += nTotCust
				nGerTabBr += nTotTabBr								
				nGerPrLiq += nTotPrLiq
				nGerDesp  += nTotDesp
				nGerMC	  += nTotMC
				//zera os valores nf
				nTotBrut  := 0
				nTotCust  := 0
				nTotTabBr := 0
				nTotPrLiq := 0
				nTotDesp  := 0
				nTotMC	  := 0


			EndIf
			_nCont := 0
		ENDIF
		dbSelectArea("SF2")
		dbSkip()
		
		
		If nAcd1 > 0 .And. ( dEmisAnt != SF2->F2_EMISSAO .Or. Eof() )
			Li++
			
			_nPorcDifDia := ((nTotMDia/nVTotDia)*100) - 100
			
			@Li ,  0 PSAY "TOTAL DO DIA  ----> "+dtoc(dEmisAnt)
			@Li ,044 PSAY nAcD1    								PICTURE PESQPICTQT("D2_QUANT",11)
			@Li ,069 PSAY nAcD2    								PICTURE TM(nAcN2    ,12)
			@Li ,082 PSAY nAcD3    								PICTURE TM(nAcN3    ,12)
			@Li ,095 PSAY nDiaCust		 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			//margem Bruta (Valor)
			nMrgBrut	:= nDiaPrLiq-nDiaCust //margem bruta
			@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			//margem Bruta (%)
			nPmrgbrut	:= (nMrgBrut/nDiaPrLiq)*100 // % margem Bruta
			@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			//mark-up venda
			@Li ,133 PSAY nDiaBrut/nDiaCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			//mark-up tabela
			@Li ,141 PSAY nDiaTabBr/nDiaCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			@Li ,151 PSAY nDiaDesp 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
			//Margem líquida MC
			@Li ,160 PSAY nDiaMC				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			@Li ,172 PSAY (nDiaMC)/nDiaPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			@Li ,182 PSAY IIF(Round(_nPorcDifDia,2)<mv_par17.or.Round(_nPorcDifDia,2)>(mv_par17*(-1)),Round(_nPorcDifDia,2),0)					PICTURE PESQPICT("SD2","D2_DESC",7) //"99,999.99"
			@Li ,192 PSAY nDiaPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			Li++
			@Li ,  0 PSAY __PrtThinLine()
			Li+=2
			nAcD1 := 0
			nAcD2 := 0
			nAcD3 := 0
			//zera valores diários 
			nDiaBrut  := 0
			nDiaCust  := 0
			nDiaTabBr := 0
			nDiaPrLiq := 0
			nDiaDesp  := 0
			nDiaMC	  := 0

			nVTotG+=nVTotDia
			nVTotDia:=0
			nTotMg+=nTotMDia
			nTotMDia:=0
		Endif
	EndDo
	
	IF li != 80
		
		_nPorcDifGeral := ((nTotMg/nVTotG)*100) - 100 // Essa variável pega a diferença por estado.
		nPorcDifGeral2 := ((nAcG2/nAcG3)*100) - 100   // Essa variável pega a diferença no total.
		
		@Li ,  0 PSAY "TOTAL GERAL            ---->"
		@Li ,044 PSAY nAcG1    								PICTURE PESQPICTQT("D2_QUANT",11)
		@Li ,069 PSAY nAcG2    								PICTURE TM(nAcN2    ,12)
		@Li ,082 PSAY nAcG3    								PICTURE TM(nAcN3    ,12)
		@Li ,095 PSAY nGerCust		 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
		//margem Bruta (Valor)
		nMrgBrut	:= nGerPrLiq-nGerCust //margem bruta
		@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
		//margem Bruta (%)
		nPmrgbrut	:= (nMrgBrut/nGerPrLiq)*100 // % margem Bruta
		@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		//mark-up venda
		@Li ,133 PSAY nGerBrut/nGerCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		//mark-up tabela
		@Li ,141 PSAY nGerTabBr/nGerCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		@Li ,151 PSAY nGerDesp 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
		//Margem líquida MC
		@Li ,160 PSAY nGerMC				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
		@Li ,172 PSAY (nGerMC)/nGerPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		@Li ,182 PSAY IIF(Round(_nPorcDifGeral,2)<mv_par17.or.Round(_nPorcDifGeral,2)>(mv_par17*(-1)),Round(_nPorcDifGeral,2),0)					PICTURE PESQPICT("SD2","D2_DESC",7) //"99,999.99"
		@Li ,192 PSAY nGerPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",12)


		Li++
		roda(cbcont,cbtxt,tamanho)
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve condicao original ao SF2 e apaga arquivo de trabalho.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RetIndex("SF2")
	dbSelectArea("SF2")
	Set Filter To
	dbSetOrder(1)
	
	#IFNDEF TOP
		cIndex += OrdBagExt()
		If File(cIndex)
			Ferase(cIndex)
		Endif
	#ENDIF

	dbSelectArea("SD2")
	dbSetOrder(1)

	IF MSGYESNO("Deseja exportar para Excel") 
		MsgRun ("Favor aguardar ...", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","Dif Venda x Tabela",_aCampos,aItensExcel}})})	
	EndIf


	If aReturn[5] = 1
		Set Printer TO
		dbcommitAll()
		ourspool(wnrel)
	Endif
	
	MS_FLUSH()
	
	Return .T.
	// Inicio da Alteração de Erich Buttner - 31/05/10
ELSE
	While !Eof() .and. lContinua
		
		
		IF lEnd
			@Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		Endif
		
		IncRegua()
		
		dEmisAnt := SF2->F2_EMISSAO
		dbSelectArea("SD2")
		dbSetOrder(3)
		dbSeek(cFilial+SF2->F2_DOC+SF2->F2_SERIE)
		
		nCt := 1
		_nCont := 0
		nTotalMer :=0
		nTotBrut  := 0
		nTotCust  := 0
		nTotTabBr := 0
		nTotPrLiq := 0
		nTotDesp  := 0
		nTotMC    := 0

		IF (ALLTRIM(SF2->F2_YCANAL) $ ALLTRIM(MV_PAR18).OR. EMPTY(MV_PAR18))
			While !Eof() .and. SD2->D2_DOC+SD2->D2_SERIE  == SF2->F2_DOC+SF2->F2_SERIE //.and. (ALLTRIM(SA3->A3_GRPREP) $ ALLTRIM(MV_PAR18).OR. ALLTRIM(MV_PAR18)=="")
				
				If li > 52
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
				EndIf
				
				sf4->(dbSetOrder(1))
				sf4->(dbSeek(xFilial("SF4")+SD2->D2_TES))
				
				/* Checa se a tes é tes de venda se não for pula o registro */
				
				if sf4->f4_venda!='S'
					DbSkip()//sf2->(DbSkip())
					Loop
				Endif
				cItemPv  :=SD2->D2_ITEMPV
				cNumPed  :=SD2->D2_PEDIDO
				
				dbSelectArea("SC6")
				dbSetOrder(2)
				dbSeek(xFilial("SC6")+SD2->D2_COD+cNumPed+cItemPv,.F.)
				
				_nVlrTabela := SC6->C6_PRCTAB
				nValEst := _nVlrTabela
				
				_nPorcDif   := ROUND(((SD2->D2_PRCVEN/_nVlrTabela)*100) - 100,2) //ROUND((((SD2->D2_PRCVEN+(SD2->D2_VALIPI/SD2->D2_QUANT))/nValEst)*100) - 100,2)
/*				If MV_PAR13 == 1 .and. (_nPorcDif < MV_PAR17 .OR. _nPorcDif > (MV_PAR17*(-1)))
					dbSelectArea("SD2")
					SD2->(dbSkip())
					Loop
				EndIf*/

				If MV_PAR13 == 1 .and. _nPorcDif > (MV_PAR17*(-1)) //(_nPorcDif < MV_PAR17 .OR. _nPorcDif > (MV_PAR17*(-1)))
					dbSelectArea("SD2")
					SD2->(dbSkip())
					Loop
				EndIf
				// regra do mark-up mínimo
				If MV_PAR20 == 1 .and. SD2->(D2_VALBRUT/D2_CUSTO1) > MV_PAR21 //
					dbSelectArea("SD2")
					SD2->(dbSkip())
					Loop
				EndIf



				
				If nCt == 1
					If SD2->D2_TIPO $ "BD"
						dbSelectArea("SA2")
						dbSetOrder(1)
						dbSeek(xFilial()+SD2->D2_CLIENTE+SD2->D2_LOJA)
						@Li ,   0 PSAY "FORNECEDOR : " +A2_COD+" "+A2_LOJA+" - "+A2_NOME+" "+"EMISSAO : "+DTOC(SF2->F2_EMISSAO)+" TIPO DA NOTA : "+SD2->D2_TIPO+" CFOP : " +SD2->D2_CF
					Else
						dbSelectArea("SA1")
						dbSetOrder(1)
						dbSeek(xFilial()+SD2->D2_CLIENTE+SD2->D2_LOJA)
						@Li ,   0 PSAY "CLIENTE    : "+A1_COD+" "+A1_LOJA+" - "+A1_NOME+" "+" ESTADO : "+SD2->D2_EST+" EMISSAO : "+DTOC(SF2->F2_EMISSAO)+" TIPO DA NOTA : "+SD2->D2_TIPO+" CFOP: " +SD2->D2_CF+"  VENDEDOR : "+SF2->F2_VEND1+" - "+SUBSTR(SA3->A3_NOME,1,30)+"  GRUPO VENDAS : "+ALLTRIM(SF2->F2_YCANAL)+" - "+ALLTRIM(POSICIONE("ACA",1,XFILIAL("ACA")+SF2->F2_YCANAL,"ACA_DESCRI"))
					EndIf
					nCt++
					Li++
					dbSelectArea("SD2")
				EndIf
				
				dbSelectArea("SB1")
				dbSetOrder(1)
				dbSeek(xFilial()+SD2->D2_COD,.F.)
				
				dbSelectArea("SBM")
				dbSetOrder(1)
				dbSeek(xFilial("SBM")+SB1->B1_GRUPO,.F.)
				nTabVdIPI	:= round(((_nVlrTabela*SD2->D2_QUANT)*(SD2->D2_IPI/100)),2)+(_nVlrTabela*SD2->D2_QUANT)+SD2->(D2_VALFRE+D2_SEGURO+D2_DESPESA) // VALOR VENDA TABELA COM IPI  + frete + seguro + despesa
				nVlIVA		:= nTabVdIPI+round((nTabVdIPI*(SD2->D2_MARGEM/100)),2) // BASE ICMS-ST TABELA
				nVlSol		:= IF(SD2->D2_ICMSRET>0,round((nVlIVA*(SD2->D2_ALIQSOL/100))-((_nVlrTabela*SD2->D2_QUANT)*SD2->D2_PICM/100),2),0) //VALOR DO ICMS-ST TABELA
				nVlTabTot	:= nTabVdIPI+nVlSol // valor tabela + icms-st + ipi
				

				cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario
				
				cQry	:= " SELECT ZE_FILIAL, ZE_COD, ZE_CLIENTE, ZE_LOJA, ZE_CANAL, ZE_DTINI, ZE_DTFIM, 
				cQry	+= " SUM(ZE_DESP01+ZE_DESP02+ZE_DESP03+ZE_DESP04+ZE_DESP05+ZE_DESP06+ZE_DESP07) TOTALDESP
				cQry	+= " FROM SZE010 SZE
				cQry	+= " WHERE SZE.D_E_L_E_T_ = ' '
				cQry	+= " AND SZE.ZE_FILIAL = '"+xFilial("SZE")+"'
				cQry	+= " AND SZE.ZE_DTFIM >= '"+dtos(ddatabase)+"'
				cQry	+= " AND SZE.ZE_DTINI <= '"+dtos(ddatabase)+"'
				cQry	+= " AND ((SZE.ZE_CLIENTE = ' ' AND SZE.ZE_LOJA = ' ' AND SZE.ZE_CANAL = '"+SF2->F2_YCANAL+"')
				cQry	+= " OR (SZE.ZE_CLIENTE = '"+SD2->D2_CLIENTE+"' AND SZE.ZE_LOJA = ' ' AND SZE.ZE_CANAL = '"+SF2->F2_YCANAL+"')
				cQry	+= " OR (SZE.ZE_CLIENTE = '"+SD2->D2_CLIENTE+"' AND SZE.ZE_LOJA = '"+SD2->D2_LOJA+"' AND SZE.ZE_CANAL = '"+SF2->F2_YCANAL+"'))
				cQry	+= " GROUP BY ZE_FILIAL, ZE_COD, ZE_CLIENTE, ZE_LOJA, ZE_CANAL, ZE_DTINI, ZE_DTFIM
				cQry	+= " ORDER BY ZE_CLIENTE DESC, ZE_LOJA DESC, ZE_CANAL DESC
				cQry := ChangeQuery(cQry)
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)
				
				DbSelectArea("cArqTRB")
				cArqTRB->(dbgotop())
				While !Eof() 
					If cArqTRB->TOTALDESP > 0 
						nFatVar := cArqTRB->TOTALDESP
						Exit
					EndIf			
				End
				DbSelectArea("cArqTRB")
				dbclosearea()


				dbSelectArea("SD2")
				
				nAcN1 += SD2->D2_QUANT
				If SF4->F4_AGREG <> "N"
					nAcN2     += SD2->D2_TOTAL	//((SD2->D2_TOTAL+SD2->D2_VALIPI))
					nTotalMer += SD2->D2_TOTAL	//((SD2->D2_TOTAL+SD2->D2_VALIPI))
					nTotBrut  += SD2->D2_VALBRUT
					nTotCust  += SD2->D2_CUSTO1
					nTotPrLiq += SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)
					nTotTabBr += nVlTabTot
					nTotDesp  += SD2->D2_VALBRUT*(nFatVar/100)
					nTotMC    += SD2->(D2_TOTAL-D2_VALICM-D2_VALIMP5-D2_VALIMP6)-SD2->D2_CUSTO1-nDespVar

					nAcN3 += _nVlrTabela * SD2->D2_QUANT
					
				Endif
				
				dEmiDia := SD2->D2_EMISSAO
				_nCont := _nCont +1
				dbSkip()
				
			EndDo // Nota
			If _nCont > 0
				
				_nPorcDifTot := ((nTotalMer/nAcN3)*100) - 100
				nTotMDia   +=nTotalMer
				
				nVTotDia+=nAcN3
				@Li ,000 PSAY "TOTAL DA NOTA - "+SF2->F2_DOC+" / "+SF2->F2_SERIE+" ---->"
				@Li ,044 PSAY nAcN1    								PICTURE PESQPICTQT("D2_QUANT",11)
				@Li ,069 PSAY nAcN2    								PICTURE TM(nAcN2    ,12)
				@Li ,082 PSAY nAcN3    								PICTURE TM(nAcN3    ,12)
				@Li ,095 PSAY nTotCust		 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				//margem Bruta (Valor)
				nMrgBrut	:= nTotPrLiq-nTotCust //margem bruta
				@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				//margem Bruta (%)
				nPmrgbrut	:= (nMrgBrut/nTotPrLiq)*100 // % margem Bruta
				@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//mark-up venda
				@Li ,133 PSAY nTotBrut/nTotCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				//mark-up tabela
				@Li ,141 PSAY nTotTabBr/nTotCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				@Li ,151 PSAY nTotDesp 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
				//Margem líquida MC
				@Li ,160 PSAY nTotMC 				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				@Li ,172 PSAY (nTotMC)/nTotPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
				@Li ,182 PSAY IIF(Round(_nPorcDifTot,2)<mv_par17.or.Round(_nPorcDifTot,2)>(mv_par17*(-1)),Round(_nPorcDifTot,2),0)					PICTURE PESQPICT("SD2","D2_DESC",7) //"99,999.99"

				@Li ,192 PSAY nTotPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",12)
				
				Li++
				@Li ,  0 PSAY __PrtThinLine()
				Li++
				nAcG1 += nAcN1
				nAcG2 += nAcN2
				nAcG3 += nAcN3
				nTotalEst:=0
				nAcD1 += nAcN1
				nAcD2 += nAcN2
				nAcD3 += nAcN3
				nAcn1 := 0
				nAcn2 := 0
				nAcn3 := 0
				//acumula valores diários 
				nDiaBrut  += nTotBrut
				nDiaCust  += nTotCust
				nDiaTabBr += nTotTabBr								
				nDiaPrLiq += nTotPrLiq
				nDiaDesp  += nTotDesp
				nDiaMC    += nTotMC
				//acumula valores diários 
				nGerBrut  += nTotBrut
				nGerCust  += nTotCust
				nGerTabBr += nTotTabBr								
				nGerPrLiq += nTotPrLiq
				nGerDesp  += nTotDesp
				nGerMC    += nTotMC
				//zera os valores nf
				nTotBrut  := 0
				nTotCust  := 0
				nTotTabBr := 0
				nTotPrLiq := 0
				nTotDesp  := 0
				nTotMC    := 0
			EndIf
			_nCont := 0
		ENDIF
		dbSelectArea("SF2")
		dbSkip()
		
		If nAcd1 > 0 .And. ( dEmisAnt != SF2->F2_EMISSAO .Or. Eof() )
			Li++
			
			_nPorcDifDia := ((nTotMDia/nVTotDia)*100) - 100
			
			@Li ,  0 PSAY "TOTAL DO DIA  ----> "+dtoc(dEmisAnt)
			@Li ,044 PSAY nAcD1    								PICTURE PESQPICTQT("D2_QUANT",11)
			@Li ,069 PSAY nAcD2    								PICTURE TM(nAcN2    ,12)
			@Li ,082 PSAY nAcD3    								PICTURE TM(nAcN3    ,12)
			@Li ,095 PSAY nDiaCust		 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			//margem Bruta (Valor)
			nMrgBrut	:= nDiaPrLiq-nDiaCust //margem bruta
			@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			//margem Bruta (%)
			nPmrgbrut	:= (nMrgBrut/nDiaPrLiq)*100 // % margem Bruta
			@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			//mark-up venda
			@Li ,133 PSAY nDiaBrut/nDiaCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			//mark-up tabela
			@Li ,141 PSAY nDiaTabBr/nDiaCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			@Li ,151 PSAY nDiaDesp 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
			//Margem líquida MC
			@Li ,160 PSAY nDiaMC				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
			@Li ,172 PSAY (nDiaMC)/nDiaPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
			@Li ,182 PSAY IIF(Round(_nPorcDifDia,2)<mv_par17.or.Round(_nPorcDifDia,2)>(mv_par17*(-1)),Round(_nPorcDifDia,2),0)					PICTURE PESQPICT("SD2","D2_DESC",7) //"99,999.99"
			@Li ,192 PSAY nDiaPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",12)

			Li++
			@Li ,  0 PSAY __PrtThinLine()
			Li+=2
			nAcD1 := 0
			nAcD2 := 0
			nAcD3 := 0
			//zera valores diários 
			nDiaBrut  := 0
			nDiaCust  := 0
			nDiaTabBr := 0
			nDiaPrLiq := 0

			nVTotG+=nVTotDia
			nVTotDia:=0
			nTotMg+=nTotMDia
			nTotMDia:=0
		Endif
	EndDo
	
	IF li != 80
		
		_nPorcDifGeral := ((nTotMg/nVTotG)*100) - 100 // Essa variável pega a diferença por estado.
		nPorcDifGeral2 := ((nAcG2/nAcG3)*100) - 100   // Essa variável pega a diferença no total.
		
		@Li ,  0 PSAY "TOTAL GERAL            ---->"
		@Li ,044 PSAY nAcG1    								PICTURE PESQPICTQT("D2_QUANT",11)
		@Li ,069 PSAY nAcG2    								PICTURE TM(nAcN2    ,12)
		@Li ,082 PSAY nAcG3    								PICTURE TM(nAcN3    ,12)
		@Li ,095 PSAY nGerCust		 		PICTURE PESQPICT("SD2","D2_PRCVEN",12)
		//margem Bruta (Valor)
		nMrgBrut	:= nGerPrLiq-nGerCust //margem bruta
		@Li ,108 PSAY nMrgBrut				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
		//margem Bruta (%)
		nPmrgbrut	:= (nMrgBrut/nGerPrLiq)*100 // % margem Bruta
		@Li ,122 PSAY nPmrgbrut				PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		//mark-up venda
		@Li ,133 PSAY nGerBrut/nGerCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		//mark-up tabela
		@Li ,141 PSAY nGerTabBr/nGerCust						PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		@Li ,151 PSAY nGerDesp 				PICTURE PESQPICT("SD2","D2_PRCVEN",8)				
		//Margem líquida MC
		@Li ,160 PSAY nGerMC				PICTURE PESQPICT("SD2","D2_PRCVEN",12)
		@Li ,172 PSAY (nGerMC)/nGerPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",8)
		@Li ,182 PSAY IIF(Round(_nPorcDifGeral,2)<mv_par17.or.Round(_nPorcDifGeral,2)>(mv_par17*(-1)),Round(_nPorcDifGeral,2),0)					PICTURE PESQPICT("SD2","D2_DESC",7) //"99,999.99"
		@Li ,192 PSAY nGerPrLiq	PICTURE PESQPICT("SD2","D2_PRCVEN",12)

		Li++
		roda(cbcont,cbtxt,tamanho)
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve condicao original ao SF2 e apaga arquivo de trabalho.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RetIndex("SF2")
	dbSelectArea("SF2")
	Set Filter To
	dbSetOrder(1)
	
	#IFNDEF TOP
		cIndex += OrdBagExt()
		If File(cIndex)
			Ferase(cIndex)
		Endif
	#ENDIF
	
	dbSelectArea("SD2")
	dbSetOrder(1)
	
	If aReturn[5] = 1
		Set Printer TO
		dbcommitAll()
		ourspool(wnrel)
	Endif
	
	MS_FLUSH()
	
	Return .T.
EndIf // Termino da alteração feita por Erich Buttner - 31/05/10

RETURN 
