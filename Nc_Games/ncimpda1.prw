#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIMPDA1  º Autor ³ Rodrigo Okamoto    º Data ³  14/01/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ PROGRAMA PARA IMPORTAR OS DADOS E REALIZAR ALTERAÇÃO NOS   º±±
±±º          ³ PREÇOS DAS TABELAS PADRÕES                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NCIMPDA1


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_MNTTAB")))
	
	ALERT("Usuário não autorizado a utilizar a rotina!")
	
	Return
ENDIF
@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Importação tabela de Preços")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, conforme"
@ 018,018 Say " conforme os layout pre estabelecido, com os registros do      "
@ 026,018 Say " arquivo.                                                       "

@ 070,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 070,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return


Static Function OkLeTxt

if !Pergunte("IMPDA1",.t.)
	Return
Endif
Private cArqTxt  := mv_par01
Private nHdl     := fOpen(mv_par01,68)
Private cEOL     := "CHR(13)+CHR(10)"

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

Processa({|| EXECIMPDA1() },"Verificando tabelas...")

Return


//Verificação das tabelas
Static Function EXECIMPDA1

Local nTamFile, nTamLin, cBuffer, nBtLidos
Local lOk    := .T.
Local aItens := {}

PRIVATE lMsErroAuto := .F.

aErros	:= {}

nTamFile := fSeek(nHdl,0,2)

ProcRegua(nTamFile) // Numero de registros a processar

ft_fuse(cArqTxt)

cProd := ""
nCont := 1
cMVTab	:= getmv("MV_NCTABPR")
aMVTab	:= StrTokArr(alltrim(cMVTab),";")

While ! ft_feof()
	
	cBuffer := ft_freadln()
	
	aIteBuf	:= 	StrTokArr(cBuffer,CHR(9))

	if nCont > 1
		IncProc("Lendo Produto : " + padr(aIteBuf[1],15) + " Linha : " + strzero((nCont ),4))
		
		//atualização das tabelas
		If EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+alltrim(aIteBuf[1]),1,""))
			ALERT("Produto Nao Existe : " + alltrim(aIteBuf[1]) + " - Linha da Planilha : " + strzero(nCont,4))
		Else
			
			For ny:= 1 to len(aMVTab)
				cPreco	:= strtran(aIteBuf[ny+3],",",".")
				//VERIFICA TABELA ny
				DbSelectArea("DA1")
				DbSetOrder(1)
				If Dbseek(xFilial("DA1")+aMVTab[ny]+padr(aIteBuf[1],15))
					
					Reclock("DA1",.F.)
					Replace DA1->DA1_PRCVEN WITH val(cPreco)
					MsUnlock()
					
				Else
					
					cQuery	:= " SELECT MAX(DA1_ITEM) MAX FROM DA1010 WHERE D_E_L_E_T_ <> '*' "
					cQuery	+= " AND DA1_CODTAB = '"+aMVTab[ny]+"' "
					DbUseArea( .t., "TOPCONN", TcGenQry(,,cQuery), "Pega" )
					TcSetField( "Pega", "MAX", "C", 4, 0 )
					
					cRET := Pega->MAX
					
					Pega->(DbCloseArea())
					
					Reclock("DA1",.T.)
					
					DA1->DA1_FILIAL := XFILIAL("DA1")
					DA1->DA1_ITEM 	:= strzero(val(cRET)+1,4)
					DA1->DA1_CODTAB	:= aMVTab[ny]
					DA1->DA1_CODPRO	:= aIteBuf[1]
					DA1->DA1_PRCVEN := val(cPreco)
					DA1->DA1_ATIVO 	:= "1"
					DA1->DA1_TPOPER	:= "4"
					DA1->DA1_QTDLOT	:= 999999.99
					DA1->DA1_INDLOT	:= "000000000999999.99"
					DA1->DA1_MOEDA		:= 1
					DA1->DA1_DATVIG	:= DDATABASE
					
					MsUnlock()
					
				Endif
			Next ny
			
		Endif
	EndIf
	nCont := nCont + 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Leitura da proxima linha do arquivo texto.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
	
EndDo

DA1->(DbCloseArea())

Close(oLeTxt)

alert("Atualização efetuada com sucesso!!!")

Return
