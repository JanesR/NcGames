#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"


User Function IMPDA1()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cArq,cInd
Local aStru1 := {}

Public nCont  := 00

OkLeTxt()

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

Private cPerg  := "IMPDA1"

IF !Pergunte(cPerg,.T.)
	RETURN
ENDIF

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

Local nPROD		:= aScan(aHeader,{|x| AllTrim(x[2]) == "DA1_CODPRO"})
Local nPRCVEN  := aScan(aHeader,{|x| AllTrim(x[2]) == "DA1_PRCVEN"})
Local nDATVIG  := aScan(aHeader,{|x| AllTrim(x[2]) == "DA1_DATVIG"})
Local nCODBAR  := aScan(aHeader,{|x| AllTrim(x[2]) == "DA1_CODBAR"})
Local nXDESC   := aScan(aHeader,{|x| AllTrim(x[2]) == "DA1_XDESC"})

PRIVATE lMsErroAuto := .F.

nTamFile := fSeek(nHdl,0,2)

ProcRegua(nTamFile) // Numero de registros a processar

ft_fuse(cArqTxt)

cProd := ""
While ! ft_feof()
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Incrementa a regua                                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	cBuffer := ft_freadln()
	
	
	cProd := alltrim(Substr(cBuffer,000,AT(CHR(9),CBUFFER))) //alltrim(Substr(cBuffer,000,013))
	cQtd  := alltrim(Substr(cBuffer,AT(CHR(9),CBUFFER)+1,14)) //Substr(cBuffer,013,10)
	
	IF ASC(SUBSTR(CPROD,12,1) ) == 9
		cProd := LEFT(LEFT(cPROD,11) + SPACE(15),15)
	ELSE
		cProd := LEFT(LEFT(cPROD,13) + SPACE(15),15)
	ENDIF
	
	IncProc("Processando produto : " + alltrim(cProd) + " Linha : " + strzero((nCont ),4))
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava os campos obtendo os valores da linha lida do arquivo texto.  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//	If EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+cProd,1,"")) //ExistCpo("SB1",cProd)
	//		cProd     := "0" + cProd
	//	endif
	
	if nCont >= 1
		If !EMPTY(GETADVFVAL("SB1","B1_COD",XFILIAL("SB1")+alltrim(cProd),1,"")) //ExistCpo("SB1",cProd)
			IF "," $ cQTD
				cQTD	:= ALLTRIM(cQTD)
				cQTDINT	:= SUBSTR(cQTD,1,AT(",",cQTD)-1)
				cQTDCENT	:= SUBSTR(cQTD,AT(",",cQTD)+1,LEN(cQTD))
				cQTD	:= cQTDINT+"."+cQTDCENT
			ENDIF
			IF VAL(cQTD) > 0
				AADD(aItens ,{cProd,val(cQtd)})
			ELSE
				ALERT("Valor ZERO para o Produto : " + alltrim(cProd) + " - Linha da Planilha : " + strzero((nCont + 1),4) )
			ENDIF
		ELSE
			ALERT("Produto Nao Existe : " + alltrim(cProd) + " - Linha da Planilha : " + strzero((nCont + 1),4) )
		ENDIF
	endif
	nCont := nCont + 1
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Leitura da proxima linha do arquivo texto.                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
	
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Adiciona os produtos no aCols                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nPItem := aScan(aHeader,{|x| AllTrim(x[2]) == "DA1_ITEM"})

ProcRegua(Len(aItens)) // Numero de registros a processar

For nX := 1 To Len(aItens)
	If aScan(aCols,{|x| x[nProd]==aItens[nX][1]})==0
		cItem := aCols[Len(aCols)][nPItem]
		aadd(aCOLS,Array(Len(aHeader)+1))
	Endif
	
	For nY	:= 1 To Len(aHeader)
		If ( AllTrim(aHeader[nY][2]) == "DA1_ITEM" )
			aCols[Len(aCols)][nY] := Soma1(cItem)
		Else
			If (aHeader[nY,2] <> "DA1_REC_WT") .And. (aHeader[nY,2] <> "DA1_ALI_WT")
				aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2])
			ENDIF
		EndIf
	Next nY
	
	N := Len(aCols)
	
	IncProc("Gravando dados do produto : " +  aItens[nX][1] )
	aCOLS[N][Len(aHeader)+1] 		:= .F.
	
	aCols[N][nProd]      			:= aItens[nX][1]
	aCols[n][nPRCVEN]  				:= aItens[nX][2]
	aCols[n][nDATVIG]  				:= DDATABASE
	aCols[n][nCODBAR]  				:= GETADVFVAL("SB1","B1_CODBAR",XFILIAL("SB1")+aItens[nX][1],1,"")
	aCols[n][nXDESC]  				:= GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+aItens[nX][1],1,"")
	
Next nX

fClose(nHdl)
// DELETA PRIMEIRA LINHA DO ACOLS
aCOLS[1][Len(aHeader)+1] := .T.

Return



User Function OS010BTN()

Local _aButtons  := {}
Private _cRotina := "OS010BTN"
_lRet   :=.T.


IF INCLUI
	AAdd(_aButtons,  {"VENDEDOR",{|| U_IMPDA1()},"Tabela Excel"})
ENDIF

Return(_aButtons)




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

Function U_SEL_ARQ2()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:=  "Arquivos Texto (*.TXT) |*.txt|"
Local cNewPathArq :=  cGetFile( cTipo , "Selecione o arquivo" )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณLimpa o parametro para a Carga do Novo Arquivo                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

DbSelectArea("SX1")
DBSETORDER(1)

IF lAchou := ( SX1->( dbSeek( "IMPDA1    " + "01" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 := cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	Mv_par01 := cNewPathArq
	MsUnLock()
EndIF

Return(.T.)



User Function OM010MNU()

_aArea := GetArea()

aADD(aRotina,{'Exp.Excel','U_exptab()',0,2}) //,0,NIL})
aADD(aRotina,{'Dif. Tabela','U_NCFATDA1()',0,2}) //,0,NIL})
aADD(aRotina,{'Imp.Excel','U_NCIMPDA1()',0,3}) //,0,NIL})
RestArea(_aArea)
Return



Function u_EXPTAB()

cPERG	:= "EXPTAB"

IF PERGUNTE(cPERG,.T.,"Confirme os parโmetros para gera็ใo do Excel")
	
	XTAB := DA0->DA0_CODTAB
	Processa({|| U_RunTAB() },"Processando...")
	
ENDIF

RETURN


FUNCTION U_RunTAB()

cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario
aDbStru := {}

cMVTab	:= getmv("MV_NCTABPR")
aMVTab	:= StrTokArr(alltrim(cMVTab),";")

//AADD(aDbStru,{"CATALOG","C",15,0})
AADD(aDbStru,{"CODIGONC","C",15,0})
AADD(aDbStru,{"CODBARRAS","C",20,0})
AADD(aDbStru,{"DESCRICAO","C",100,0})
AADD(aDbStru,{"PLATAFORMA","C",20,0})
AADD(aDbStru,{"GENERO","C",20,0})
AADD(aDbStru,{"TECNOLOGIA","C",20,0})
cQryTab	:= " "
cQryJoin:= " "
cQryCpo	:= " "
For nx:=1 to len(aMVTab)
	AADD(aDbStru,{"PRECO"+ALLTRIM(aMVTab[nx]),"N",17,2})
	cQryCpo  += " DA"+ALLTRIM(aMVTab[nx])+".DA1_PRCVEN PRECO"+ALLTRIM(aMVTab[nx])+", "
	cQryTab  += " (SELECT DA1.DA1_CODPRO, DA1.DA1_PRCVEN FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_FILIAL = ' ' AND DA1.DA1_CODTAB = '"+ALLTRIM(aMVTab[nx])+"') DA"+ALLTRIM(aMVTab[nx])+", "
	cQryJoin += " AND DA"+ALLTRIM(aMVTab[nx])+".DA1_CODPRO  = B1.B1_COD  "
Next nx
AADD(aDbStru,{"IPI","N",5,2})
AADD(aDbStru,{"DISPONIB","C",20,0})
AADD(aDbStru,{"STREETDATE","C",8,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
//CNOMEDBF := "TAB-NCGAMES"+substr(dtoc(ddatabase),1,2)+"-"+substr(dtoc(ddatabase),4,2)+substr(dtoc(ddatabase),7,2)+"-"+time()
CNOMEDBF := "TAB-NCGAMES"+alltrim(cusername)+"-"+time()
CNOMEDBF := StrTran(CNOMEDBF,":","-")
DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

cQuery2  := " SELECT "
cQuery2  += " B1.B1_COD CODIGONC, "
cQuery2  += " B1.B1_CODBAR CODBARRAS, "
cQuery2  += " B1.B1_XDESC DESCRICAO, "
cQuery2  += " B1.B1_DTLANC LANCTO, "
cQuery2  += " B1.B1_PLATAF PLATAFORMA, "
cQuery2  += " B1.B1_TECNOC TECNOLOGIA, "
cQuery2  += " GN.X5_DESCRI GENERO, "
/*cQuery2  += " DA18.DA1_PRCVEN PRECO18, "
cQuery2  += " DA12.DA1_PRCVEN PRECO12, "
cQuery2  += " DA07.DA1_PRCVEN PRECO07, "*/
cQuery2  += cQryCpo
cQuery2  += " B1.B1_IPI/100 IPI, "
cQuery2  += " B5.B5_DTLAN STREETDATE, "
cQuery2  += " ' ' DISPONIB "
cQuery2  += " FROM SB1010 B1, SB5010 B5,"
/*cQuery2  += " (SELECT DA1.DA1_CODPRO, DA1.DA1_PRCVEN FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_FILIAL = ' ' AND DA1.DA1_CODTAB = '018') DA18, "
cQuery2  += " (SELECT DA1.DA1_CODPRO, DA1.DA1_PRCVEN FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_FILIAL = ' ' AND DA1.DA1_CODTAB = '012') DA12, "
cQuery2  += " (SELECT DA1.DA1_CODPRO, DA1.DA1_PRCVEN FROM DA1010 DA1 WHERE DA1.D_E_L_E_T_ <> '*' AND DA1.DA1_FILIAL = ' ' AND DA1.DA1_CODTAB = '007') DA07, "*/
cQuery2  += cQryTab
cQuery2  += " (SELECT X5_CHAVE, X5_DESCRI FROM  SX5010 WHERE X5_TABELA='Z2' AND X5_FILIAL = ' ' AND D_E_L_E_T_!='*') GN "
cQuery2  += " WHERE B1.D_E_L_E_T_!='*'  "
cQuery2  += " AND B5.D_E_L_E_T_ != '*' "
cQuery2  += " AND B1.B1_COD = B5.B5_COD "
cQuery2  += " AND B1.B1_CODGEN  = GN.X5_CHAVE  "
cQuery2  += " AND B1_FILIAL = ' '
cQuery2  += " AND B5_FILIAL = ' '
/*cQuery2  += " AND DA18.DA1_CODPRO  = B1.B1_COD  "
cQuery2  += " AND DA12.DA1_CODPRO  = B1.B1_COD  "
cQuery2  += " AND DA07.DA1_CODPRO  = B1.B1_COD  "*/
cQuery2  += cQryJoin
cQuery2  += " AND B1.B1_PLATAF BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
cQuery2  += " AND B1.B1_CODGEN BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
cQuery2  += " AND B5.B5_DTLAN BETWEEN '" + DTOS(MV_PAR07) + "' AND '" + DTOS(MV_PAR08) + "' "
cQuery2  += " AND B1.B1_TIPO = 'PA' "
cQuery2  += " AND B1.B1_BLQVEND <> '1' "
cQuery2  += " AND B1.B1_MSBLQL <> '1' "
cQuery2  += " ORDER BY DESCRICAO "

MemoWrit("TABPRE.SQL",cQuery2)

TCQUERY cQuery2 NEW ALIAS cArqTRB

ProcRegua(cArqTRB->(Reccount()))

While !cArqTRB->(EOF())
	nQATU		:= GETADVFVAL("SB2","B2_QATU",XFILIAL("SB2")+PADR(cArqTRB->CODIGONC,15)+"01",1,0) - GETADVFVAL("SB2","B2_RESERVA",XFILIAL("SB2")+PADR(cArqTRB->CODIGONC,15)+"01",1,0)
	cPlataf		:= GETADVFVAL("SZ5","Z5_PLATRED",XFILIAL("SZ5")+PADR(cArqTRB->PLATAFORMA,6),1,"")
	lSB2		:= IIF(GETADVFVAL("SB2","B2_LOCAL",XFILIAL("SB2")+PADR(cArqTRB->CODIGONC,15)+"01",1,"")=="01",.T.,.F.)
	IF !lSB2
		cDispo := "PREVISTO"
	ELSEIF nQATU > 0
		cDispo := "DISPONIVEL"
	ELSE
		cDispo := "NAO DISPONIVEL"
	ENDIF
	//	cLBUY		:= U_LBUY(cArqTRB->CODIGONC) // RETORNA DATA DA ULTIMA COMPRA
	IncProc("Exportando Tabela...")
	//	IF (cLBUY >= MV_PAR07 .AND. cLBUY <= MV_PAR08) .AND. (STOD(cArqTRB->LANCTO) >= MV_PAR09 .AND. STOD(cArqTRB->LANCTO) <= MV_PAR10)
	//IF STOD(cArqTRB->LANCTO) >= MV_PAR09 .AND. STOD(cArqTRB->LANCTO) <= MV_PAR10 // VERIFICA DATA DE LANวAMENTO
	XLS->(RECLOCK("XLS",.T.))
	FOR I:=1 TO cArqTRB->(FCOUNT())
		IF (nPos:=XLS->(FIELDPOS(cArqTRB->(FIELDNAME(I))))) # 0
			IF FIELDNAME(I) == "DISPONIB"
				//XLS->(FIELDPUT(nPos,nQATU))
				XLS->(FIELDPUT(nPos,cDispo))
			ELSEIF FIELDNAME(I) == "LANCTO"
				XLS->LANCTO	:= STOD(cArqTRB->LANCTO)
			ELSEIF FIELDNAME(I) == "STREETDATE"
				XLS->STREETDATE	:= dtoc(STOD(cArqTRB->STREETDATE))
			ELSEIF FIELDNAME(I) == "PLATAFORMA"
				XLS->PLATAFORMA	:= cPlataf
			ELSE
				XLS->(FIELDPUT(nPos,cArqTRB->(FIELDGET(I))))
			ENDIF
		ENDIF
	NEXT
	//ENDIF
	cArqTRB->(DBSKIP())
EndDo
XLS->(DBGOTOP())
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\Relatorios\" + CNOMEDBF + ".DBF" )

If ! ApOleClient( 'MsExcel' )
  	If File("\SYSTEM\" + CNOMEDBF +".DBF")
		FErase("\SYSTEM\" + CNOMEDBF +".DBF")
	EndIf
	MsgStop( 'MsExcel nao instalado' )
	DbSelectArea("cArqTRB")
	DbCloseArea()
	XLS->(DBCLOSEAREA())
	Return
EndIf

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)
XLS->(DBCLOSEAREA())

DbSelectArea("cArqTRB")
DbCloseArea()

If File("\SYSTEM\" + CNOMEDBF +".DBF")
	FErase("\SYSTEM\" + CNOMEDBF +".DBF")
EndIf

Return


//Funcao para retornar a descricao na visualizacao da tabela de precos
Function U_DESCRI()

aArea1 := getarea()
//Pergunte("OMS010",.F.)	//FAZ A VERIFICACAO DO PARAMETRO
nPosCodpro  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "DA1_CODPRO"})
nPosCodTab  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "DA1_CODTAB"})
cRET := ""

IF nPosCodpro == 3 //MV_PAR01 == 1 //1=visualiza por tabela, 2=vializa por produto
	cCHAVE := ACOLS[LEN(ACOLS),3]
	If !Empty(cCHAVE)
		cRET := GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+cCHAVE,1,"")
	Endif
ELSEIF nPosCodTab = 3
	cRET := GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+MV_PAR02,1,"")
ENDIF
RestArea(aArea1)

Return cRET


//Funcao para retornar o codigo de barras na visualizacao da tabela de precos
Function U_CODBAR()


aArea1 := getarea()

//Pergunte("OMS010",.F.)	//FAZ A VERIFICACAO DO PARAMETRO
nPosCodpro  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "DA1_CODPRO"})
nPosCodTab  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "DA1_CODTAB"})
cRET := ""

IF nPosCodpro == 3 //MV_PAR01 == 1 //1=visualiza por tabela, 2=vializa por produto
	cCHAVE := ACOLS[LEN(ACOLS),3]
	If !Empty(cCHAVE)
		cRET := GETADVFVAL("SB1","B1_CODBAR",XFILIAL("SB1")+cCHAVE,1,"")
	Endif
ELSEIF nPosCodTab = 3
	cRET := GETADVFVAL("SB1","B1_CODBAR",XFILIAL("SB1")+MV_PAR02,1,"")
ENDIF

RestArea(aArea1)

Return cRET


//RETORNA DATA DA UMTIMA COMPRA
USER FUNCTION LBUY(cCOD)

ASD1 := GETAREA()
_NQTD := CTOD("")

cQry  :=" SELECT MAX(D1_EMISSAO) NQTDFAT  "
cQry  +=" FROM "+RetSqlName("SD1")+" D "
cQry  +=" WHERE  "
cQry  +=" D.D_E_L_E_T_=' ' "
cQry  +=" AND D.D1_COD = '" + cCOD + "' "
DbUseArea( .t., "TOPCONN", TcGenQry(,,cQry), "Pega" )
TcSetField( "Pega", "NQTDFAT", "D", 8, 0 )
_NQTD := Pega->NQTDFAT
Pega->(DbCloseArea())

dRET := _NQTD

RESTAREA(ASD1)

Return dRet
