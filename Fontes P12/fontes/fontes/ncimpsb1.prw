#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIMPSB1  º Autor ³ Rodrigo Okamoto    º Data ³  14/01/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ PROGRAMA PARA IMPORTAR OS DADOS E REALIZAR ALTERAÇÃO NOS   º±±
±±º          ³ PREÇOS DO CADASTRO DE PRODUTOS                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NCIMPSB1


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ALLTRIM(upper(CUSERNAME)) $ alltrim(UPPER(getmv("MV_IMPSB1")))

	ALERT("Usuário não autorizado a utilizar a rotina!")

	Return
ENDIF
@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Importação de Preços no cadastro de Produtos")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, conforme"
@ 018,018 Say " conforme os layout pre estabelecido, com os registros do      "
@ 026,018 Say " arquivo.                                                      "

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

Processa({|| EXECIMPSB1() },"Verificando tabelas...")

Return


//Verificação das tabelas
Static Function EXECIMPSB1

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

While ! ft_feof()
	
	cBuffer := ft_freadln()

	aRet := StrTokArr(cBuffer,CHR(9))
	If len(aret) == 0
		ft_fskip() // Leitura da proxima linha do arquivo texto
		loop
	EndIf

	cProd 	:= aRet[1] //alltrim(Substr(cBuffer,1,AT(CHR(9),CBUFFER)-1))	// codigo do produto
	cPrv1 	:= aRet[2] //alltrim(Substr(cBuffer,AT(CHR(9),CBUFFER)+1,1000))
	cPrCons := aRet[3] //ALLTRIM(cREST)
	
	IncProc("Lendo Produto : " + padr(cProd,15) + " Linha : " + strzero((nCont ),4))

	IF "," $ cPrv1
		cPrv1		:= ALLTRIM(cPrv1)
		cPrv1INT	:= SUBSTR(cPrv1,1,AT(",",cPrv1)-1)
		cPrv1CENT	:= SUBSTR(cPrv1,AT(",",cPrv1)+1,LEN(cPrv1))
		cPrv1		:= cPrv1INT+"."+cPrv1CENT
	ENDIF
	IF "," $ cPrCons
		cPrCons		:= ALLTRIM(cPrCons)
		cPrConsINT	:= SUBSTR(cPrCons,1,AT(",",cPrCons)-1)
		cPrConsCENT	:= SUBSTR(cPrCons,AT(",",cPrCons)+1,LEN(cPrCons))
		cPrCons		:= cPrConsINT+"."+cPrConsCENT
	ENDIF


	if nCont > 1
		If EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+alltrim(cProd),1,""))
			cProd     := "0" + alltrim(cProd)
		endif

		If !EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+alltrim(cProd),1,""))
			AADD(aItens,{cProd,cPrv1,cPrCons})
		Else
			ALERT("Produto Nao Existe : " + alltrim(cProd) + " - Linha da Planilha : " + strzero(nCont,4))
		Endif
	endif
	nCont := nCont + 1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Leitura da proxima linha do arquivo texto.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
	
EndDo

ProcRegua(Len(aItens)) // Numero de registros a processar

For nx := 1 to len(aItens)
	
	IncProc("Gravando dados do produto : " +  aItens[nX,1] )
	//VERIFICA TABELA 018
	DbSelectArea("SB1")
	DbSetOrder(1)
	If Dbseek(xFilial("SB1")+padr(aItens[nx,1],15))
		
		Reclock("SB1",.F.)
		Replace SB1->B1_PRV1 	WITH val(aItens[nx,2])
		Replace SB1->B1_CONSUMI	WITH val(aItens[nx,3])
		MsUnlock()
		
	EndIf
	
Next

SB1->(DbCloseArea())

Close(oLeTxt)

alert("Atualização efetuada com sucesso!!!")

Return




