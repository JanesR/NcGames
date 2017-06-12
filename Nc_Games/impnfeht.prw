#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
//ฑฑบPrograma  ณIMPNFEHT  บ Autor ณ Rafael Augusto     บ Data ณ  04/08/10   บฑฑ
//ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
//ฑฑบDescricao ณEste programa ira importar o arquivo de texto gerado pelo   บฑฑ
//ฑฑบ          ณvendedor em cima de um pedido de venda recebido do cliente. บฑฑ
//ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//ฑฑบUso       ณ P10.3 - NC GAMES - Supertech Consulting                    บฑฑ
//ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

User Function IMPNFEHT()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cArq,cInd
Local aStru1 := {}

Public nCont  := 00

Private oLeTxt


//IF EMPTY(M->C5_TABELA) .OR. EMPTY(M->C5_CLIENTE) .OR. EMPTY(M->C5_LOJACLI) .OR. EMPTY(M->C5_CONDPAG) .OR. EMPTY(M->C5_TIPO)
IF !Obrigatorio(aGets,aTela) //EMPTY(M->C5_CLIENTE) .OR. EMPTY(M->C5_LOJACLI) .OR. EMPTY(M->C5_CONDPAG) .OR. EMPTY(M->C5_TIPO)
	//MsgAlert("Preencha os campos do cabe็alho antes da importa็ใo do pedido!")
	Return
ENDIF


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Montagem da tela de processamento.                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Integra็ใo Vendas")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, conforme"
@ 018,018 Say " conforme os layout pre estabelecido, com os registros do      "
@ 026,018 Say " arquivo.                                                       "

@ 070,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 070,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return


//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
//ฑฑบFuno    ณ OKLETXT  บ Autor ณ Rafael Augusto     บ Data ณ  04/08/10   บฑฑ
//ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
//ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
//ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
//ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//ฑฑบUso       ณ Programa principal                                         บฑฑ
//ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿


Static Function OkLeTxt

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Abertura do arquivo texto                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Public nCont := 00

Private cPerg  := "IMPNFEHT"

ValidPerg()

Pergunte(cPerg)

Private cArqTxt := mv_par01
Private nHdl    := fOpen(mv_par01,68)
Private cEOL    := "CHR(13)+CHR(10)"
Private cPedido	:= M->C5_NUM
Private cTabela	:= M->C5_TABELA
Private nDesc1	:= M->C5_DESC1

If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

If nHdl == -1
	MsgAlert("O arquivo de nome " + mv_par01 + " nao pode ser aberto!","Atencao!")
	Return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inicializa a regua de processamento                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Processa({|| RunCont() },"Processando...")
Return

//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
//ฑฑบFuno    ณ RUNCONT  บ Autor ณ Rafael Augusto     บ Data ณ  04/08/10   บฑฑ
//ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
//ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
//ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
//ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//ฑฑบUso       ณ Programa principal                                         บฑฑ
//ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos
Local aItens := {}
Local aItens2:= {}
Local cDoc   := ""
Local lOk    := .T.

Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRODUTO"})
Local nPTES     := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_TES"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_QTDVEN"})
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRCVEN"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ITEM"})
Local nPTotal   := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_VALOR"})
Local nPosPRegDe := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_PREGDES'})
Local nPosRegDes := aScan(aHeader,{|x| AllTrim(x[2]) == 'C6_REGDESC'})
Local aAreaIMPHT	:= getarea()
Local nLenProd	:=AvSx3("C6_PRODUTO",3)
Local aC6Itens	:={}
Local aLinha	:={}
Local cItemC6

PRIVATE lMsErroAuto := .F.
aErros	:= {}
aDadosCfo	:= {}

nTamFile := fSeek(nHdl,0,2)

ProcRegua(nTamFile) // Numero de registros a processar

ft_fuse(cArqTxt)

cProd := ""
While ! ft_feof()
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Incrementa a regua                                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	cBuffer := ft_freadln()
	
	NPCOD := AT(CHR(9),CBUFFER)
	cProd := alltrim(Substr(cBuffer,001,NPCOD - 1))
	cQtd  := Substr(cBuffer,NPCOD+1,10)
	cOper	:= "01"
	//implementacao do TES inteligente 20/09/2010 - "ativar apos conclusao do trabalho de parametrizacao do TES inteligente" e desativar bloco acima
	//RETIRADO MESMO COM TES INTELIGENTE POIS FOI CHUMBADO O TIPO DE OPERAวรO 01 A PEDIDO DE RUBENS
	/*
	NPCOD := AT(CHR(9),CBUFFER)
	cProd := alltrim(Substr(cBuffer,001,NPCOD - 1))
	cREST := Substr(cBuffer,NPCOD+1,20)
	cQtd  := Substr(cREST,1,AT(CHR(9),cREST)-1)
	cOper := Substr(cREST,AT(CHR(9),cREST)+1,10)
	*/
	
	
	IncProc("Produto : " + cProd + " Linha : " + strzero((nCont ),4))
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava os campos obtendo os valores da linha lida do arquivo texto.  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+cProd,1,"",.F.)) //ExistCpo("SB1",cProd)
		cProd     := "0" + cProd
	endif
	
	if nCont >= 1
		lyy	:= .T.
		If !EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+cProd,1,"",.F.)) .AND. alltrim(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+cProd,1,"",.F.)) == alltrim(cProd) //ExistCpo("SB1",cProd)
			For yy:= 1 to len(aItens)
				If cProd == aItens[yy,1]
					cXDESC	:= GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+PADR(cProd,15),1,"")
					aadd(aErros,{PADR(cProd,15),cXDESC,val(cQtd),"C๓digo de produto repetido no pedido!"})
					yy:= len(aItens)
					lyy	:= .F.
				EndIf
			Next yy
			If lyy
				IF VAL(cQTD) > 0
					//AADD(aItens ,{cProd,cQtd})
					AADD(aItens ,{cProd,cQtd,cOPER}) //implementar apos conclusao da parametrizacao do TES inteligente
				ELSE
					cXDESC	:= GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+PADR(cProd,15),1,"")
					aadd(aErros,{PADR(cProd,15),cXDESC,val(cQtd),"Quantidade zero"})
					//	ALERT("Quantidade ZERO para o Produto : " + cProd + " - Linha da Planilha : " + strzero((nCont + 1),4) )
				ENDIF
			EndIf
		ELSE
			cXDESC	:= ""
			aadd(aErros,{PADR(cProd,15),"C๓digo nใo encontrado",val(cQtd),"Produto nใo encontrado"})
			// ALERT("Produto Nao Existe : " + cProd + " - Linha da Planilha : " + strzero((nCont + 1),4) )
		ENDIF
	endif
	nCont := nCont + 1
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Leitura da proxima linha do arquivo texto.                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
	
EndDo

RestArea(aAreaIMPHT)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Adiciona os produtos no aCols                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
_nPosPrReal	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCREAL'} )
_nPosPrTab	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCTAB'} )
_nPosPrUnit	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRUNIT'} )
_nPosPrcVen	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRCVEN'} )
_nPosValor	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VALOR'} )
_nPosVrTot	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_VRTOTAL'} )
_nPos2		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_CLASFIS'} )
_nPosTES		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
_nPosCF		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_CF'} )
_nPosDSC		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_DESCRI'} )
_nPosDOL		:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRDOLAR'} )
_nALM       := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_LOCAL'} )

_nPOS3      := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_UM'} )
_nPOS4      := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_SEGUM'} )
_nPOS5      := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_UNSVEN'} )
_nPOSOPER   := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_OPER'} )
_nPOSOPER2   := aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TPOPER'} )

ProcRegua(Len(aItens)) // Numero de registros a processar
      
cItemC6:=Replicate("0", AvSx3("C6_ITEM",3) )
nContItem	:= 0
nQtMax	:= supergetmv("MV_MAXITPV",.T.,40)
For nX := 1 To Len(aItens)
	lRet		:= .T.
	cPRODUTO	:= aItens[nX][1]
	//	cTabela FAZER A VERIFICAวรO SE O PRODUTO Jม EXISTE NA TABELA
	cTIPOPROD := GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+PADR(cPRODUTO,15),1,"")
	lRet	  := U_VLDTAB(cTabela,cPRODUTO,"A",cTIPOPROD)
	nPrcven := U_VLDTAB(cTabela,cPRODUTO,"B",cTIPOPROD)
	cTES	  := MaTesInt(2,aItens[nX][3],M->C5_CLIENT,M->C5_LOJAENT,If(M->C5_TIPO$'DB',"F","C"),aItens[nX][1],"C6_TES")
	IncProc("Realizando importa็ใo para o pedido: " + cPRODUTO )
	//alert("1) "+aItens[nX][1]+" "+cTES+str(nX))
	
	cDuplic := GETADVFVAL("SF4","F4_DUPLIC",XFILIAL("SF4")+cTES,1,"")
	cBlqVend:= GETADVFVAL("SB1","B1_BLQVEND",XFILIAL("SB1")+PADR(cPRODUTO,15),1,"")
	
	IF !lret
		cXDesc  := GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+PADR(cPRODUTO,15),1,"")
		aadd(aErros,{cPRODUTO,cXDesc,val(aItens[nX][2]),"Cadastro na Tabela de Pre็os"})
	ENDIF
	IF cDuplic == "S" .AND. cBlqVend == "1" .And. !(Alltrim(M->C5_YORIGEM) == 'SIMULAR' )  .And. (Alltrim(M->C5_XECOMER) != "C")//VERIFICA SE O PRODUTO ESTม BLOQUEADO PARA VENDAS
		lRet	:= .F.
		cXDesc  := GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+PADR(cPRODUTO,15),1,"")
		aadd(aErros,{cPRODUTO,cXDesc,val(aItens[nX][2]),"Bloqueado para Vendas"})
		//ALERT("PRODUTO "+cPRODUTO+" BLOQUEADO PARA VENDAS!")
	ENDIF
	
	If ++nContItem > nQtMax
		lRet	:= .F.
		cXDesc  := GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+PADR(cPRODUTO,15),1,"")
		aadd(aErros,{cPRODUTO,cXDesc,val(aItens[nX][2]),"Quantidade de itens excede ao limite permitido de"+transform(nQtMax,"@E 999,999")})
	
	Else
		cItemC6:=Soma1(cItemC6)
		aLinha := {}
		aadd(aLinha,{"C6_ITEM"			,cItemC6,Nil})
		aadd(aLinha,{"C6_PRODUTO"		,cPRODUTO,  })
		aadd(aLinha,{"C6_QTDVEN"		,Val(aItens[nX][2]),Nil})
		aadd(aLinha,{"C6_OPER"			,"01",Nil})
		aadd(aC6Itens,aLinha)		
	EndIf
	            
	
	
Next nX
aCabec:={}                       
For nInd:=1 To SC5->(FCount())
	If Type("M->"+SC5->(FieldName(nInd))  )<>"U"
		AADD(aCabec,{ "M->"+SC5->(FieldName(nInd)),&("M->"+SC5->(FieldName(nInd))) } )
	EndIf		
Next

MsGetDAuto(aC6Itens,"","",aCabec)    


// DELETA PRIMEIRA LINHA DO ACOLS
//aCOLS[1][Len(aHeader)+1] := .T.

// Alert("Foram importados  " + Alltrim(Str(nCont)) + "  Itens!")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ O arquivo texto deve ser fechado, bem como o dialogo criado na fun- ณ
//ณ cao anterior.                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
fClose(nHdl)
Close(oLeTxt)

/*
//rebate todos os itens do pedido novamente para validar TES, CFOP e Situa็ใo Tributแria - implantado em 24/02/2011 - Rodrigo Okamoto
ProcRegua(Len(acols)) // Numero de registros a processar

for nx := 1 to len(acols)
	aDadosCfo	:= {}
	If !GDDeleted(nx)
		aCols[nx,_nPosTES]	:= 	MaTesInt(2,"01",M->C5_CLIENT,M->C5_LOJAENT,If(M->C5_TIPO$'DB',"F","C"),aCols[nx,nPProduto],"C6_TES")
		
		IncProc("Valida็ใo Fiscal: " + aCols[nx][nPProduto] )
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณPosiciona os registros                                                  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea(IIF(M->C5_TIPO$"DB","SA2","SA1"))
		dbSetOrder(1)
		MsSeek(xFilial()+IIf(!Empty(M->C5_CLIENT),M->C5_CLIENT,M->C5_CLIENTE)+M->C5_LOJACLI)
		
		DBSELECTAREA("SF4")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SF4")+ aCols[nx,_nPosTES],.T.)
		
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SB1")+ aCols[nx][nPProduto],.T.)
		
		aCols[nx,_nPos2]  		:= Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB
		Aadd(aDadosCfo,{"OPERNF","S"})
		Aadd(aDadosCfo,{"TPCLIFOR",M->C5_TIPOCLI})
		Aadd(aDadosCfo,{"UFDEST",Iif(M->C5_TIPO $ "DB",SA2->A2_EST,SA1->A1_EST)})
		Aadd(aDadosCfo,{"INSCR" ,If(M->C5_TIPO$"DB",SA2->A2_INSCR,SA1->A1_INSCR)})
		aCols[nx,_nPosCF] := MaFisCfo(,SF4->F4_CF,aDadosCfo)
		
	EndIf
next
*/
// MOSTRA OS ITENS QUE DERAM ERROS DURANTE A IMPORTAวรO
IF len(aErros) > 0
	u_ERROSTMP(aErros)
ENDIF

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
	Ma410Rodap()
Endif


Return

//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
//ฑฑบPrograma  ณVALIDPERG บAutor  ณRafael Augusto      บ Data ณ  04/08/10   บฑฑ
//ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
//ฑฑบDesc.     ณ Valida se as perguntas estใo criadas no arquivo SX1 e caso บฑฑ
//ฑฑบ          ณ nใo as encontre ele as cria.                               บฑฑ
//ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//ฑฑบUso       ณ P10                                                        บฑฑ
//ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

Static Function ValidPerg()

_sAlias := Alias()

DbSelectArea("SX1")
DbSetOrder(1)

cPerg := PADR(cPerg,10)
aRegs :={}

AADD(aRegs,{cPerg,"01","Arquivo Base     ?","","","mv_ch1","C",80,0,0,"G","U_SEL_ARQ","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Else
				exit
			Endif
		Next
		MsUnlock()
	Endif
Next

DbSelectArea(_sAlias)

Return

//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
//ฑฑบPrograma  ณSEL_ARQ   บAutor  ณRafael Augusto      บ Data ณ  04/08/10   บฑฑ
//ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
//ฑฑบDesc.     ณ Abre tela no servidor para o usuario localizar o arquivo   บฑฑ
//ฑฑบ          ณ que sera utilizado.                                        บฑฑ
//ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
//ฑฑบUso       ณ P10                                                        บฑฑ
//ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
//ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
//฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿


User Function SEL_ARQ()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:=  "Arquivos Texto (*.TXT) |*.txt|"
Local cNewPathArq :=  cGetFile( cTipo , "Selecione o arquivo" )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLimpa o parametro para a Carga do Novo Arquivo                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

DbSelectArea("SX1")
DBSETORDER(1)

IF lAchou := ( SX1->( dbSeek( cPerg + "01" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 := cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	Mv_par01 := cNewPathArq
	MsUnLock()
EndIF

Return(.T.)


//PROGRAMA PARA VALIDAR SE O PRODUTO ESTม CADASTRADO NA TABELA DE PREวOS
//cIdent - variavel irแ definir se retorna o bloqueio ou pre็o de venda:
//"A" - RETORNA VALIDAวรO DA TABELA
//"B" - RETORNA PREวO DE TABELA

USER FUNCTION VLDTAB(cTabela,cPRODUTO,cIdent,cTIPOPROD)
aAREATB	:= GETAREA()
lRET	:= .T.
nPrVd := 0

IF ALLTRIM(cTIPOPROD) == "PA"
	IF M->C5_TIPO == "N"
		DBSELECTAREA("DA0")
		DBSETORDER(1)
		IF DBSEEK(XFILIAL("DA0")+cTabela,.T.)
			cATIVO	:= DA0->DA0_ATIVO
			dDTFIM	:= DA0->DA0_DATATE
			IF cATIVO == "1" .AND. (EMPTY(dDTFIM).OR.dDTFIM >= ddatabase)
				DBSELECTAREA("DA1")
				DBSETORDER(1)
				IF DBSEEK(XFILIAL("DA1")+cTabela+cPRODUTO,.T.)
					cVerifica	:= ""
					While !DA1->(EOF()) .AND. cTabela+PADR(cPRODUTO,15) == DA1->(DA1_CODTAB+DA1_CODPRO)
						IF DTOS(DA1->DA1_DATVIG) > DTOS(DDATABASE) .OR. DA1->DA1_ATIVO == "2"
							cVERIFICA	+= "F"
						ELSEIF DTOS(DA1->DA1_DATVIG) <= DTOS(DDATABASE) .AND. DA1->DA1_ATIVO == "1"
							nPrVd	:= DA1->DA1_PRCVEN
							cVERIFICA	+= "S"
						ELSE
							cVERIFICA	+= "F"
						ENDIF
						DBSELECTAREA("DA1")
						DBSKIP()
					END
					IF !"S" $ cVERIFICA
						//	ALERT("Verifique a validade da tabela de pre็os do Produto "+cPRODUTO)
						lRET	:= .F.
						RESTAREA(aAREATB)
						IF cIdent == "A"
							RETURN(lRET)
						ELSE
							RETURN(nPrVd)
						ENDIF
					ENDIF
				ELSE
					//	ALERT("Produto "+cPRODUTO+" nใo cadastrado na tabela de pre็os!!!")
					lRET	:= .F.
					RESTAREA(aAREATB)
					IF cIdent == "A"
						RETURN(lRET)
					ELSE
						RETURN(nPrVd)
					ENDIF
				ENDIF
			ELSE
				lRET	:= .F.
				RESTAREA(aAREATB)
				IF cIdent == "A"
					RETURN(lRET)
				ELSE
					RETURN(nPrVd)
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ELSE
	lRET	:= .T.
	nPrVd := GETADVFVAL("SB1","B1_PRV1",XFILIAL("SB1")+PADR(cPRODUTO,15),1,0)
	
ENDIF
RESTAREA(aAREATB)
IF cIdent == "A"
	RETURN(lRET)
ELSE
	RETURN(nPrVd)
ENDIF


//MONTA TELA DOS ITENS BLOQUEADOS DURANTE A IMPORTAวรO

USER FUNCTION ERROSTMP(aErros)

@ 001,001 To 400,600 Dialog oDlgLib Title "Alertas da importa็ใo - Pedido: " + M->C5_NUM
//@ 005,005 LISTBOX oItems VAR cItem Fields HEADER   	"",Padr("Produto",15),;
@ 005,005 LISTBOX oItems Fields Title PADR("Produto",20),;
PADR('Descri็ใo NC Games',50),;
PADR('Qtd',14),;
PADR('Mensagem',50) SIZE 290,155 PIXEL
oItems:SetArray(aErros)

oItems:bLine := { || {aErros[oItems:nAt,01] ,;
aErros[oItems:nAt,02] ,;
TRANSFORM(aErros[oItems:nAt,03],"@E 9,999,999.99") ,;
aErros[oItems:nAt,04]}}
@ 175,005 SAY "Nใo foram importados os itens acima, favor conferir!!!"
@ 180,200 BMPBUTTON TYPE 01 ACTION Close( oDlgLib )
@ 180,250 BMPBUTTON TYPE 11 ACTION ExpXls(aErros)
Activate Dialog oDlgLib Centered


RETURN



/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ8ฟ
//ณExporta็ใo dos registros com erro para Excelณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ8ู
*/

Static Function ExpXls(aErros)
Local aStru := {}

aAdd(aStru,{"CODIGONC","C",15,0})
aAdd(aStru,{"DESCRICAO","C",40,0})
aAdd(aStru,{"QUANTIDADE","N",14,2})
aAdd(aStru,{"MENSAGEM","C",60,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "IMPPED"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))

If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
EndIf

DBCREATE(CNOMEDBF,aStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

For nn:= 1 to len(aErros)
	
	XLS->(RECLOCK("XLS",.T.))
	
	XLS->CODIGONC	:= aErros[NN,1]
	XLS->DESCRICAO	:= aErros[NN,2]
	XLS->QUANTIDADE	:= aErros[NN,3]
	XLS->MENSAGEM	:= aErros[NN,4]
	
	XLS->(MSUNLOCK())
	
Next nn

//FAZ A ABERTURA DO EXCEL
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\Relatorios\" + CNOMEDBF + ".DBF" )

If !ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	XLS->(DBCLOSEAREA())
ELSE
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
EndIf



Close( oDlgLib )
Return