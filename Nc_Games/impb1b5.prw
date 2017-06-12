#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPB1B5   º Autor ³ Rodrigo Okamoto    º Data ³  08/07/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ PROGRAMA PARA IMPORTAR OS DADOS E REALIZAR ALTERAÇÃO NOS   º±±
±±º          ³ CAMPOS CONFORME PARÂMETROS                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function IMPB1B5

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Importação Produtos")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, ordenado  "
@ 018,018 Say " com as colunas na sequência e na primeira linha o nome do campo "
@ 026,018 Say ""

@ 070,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 070,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return


Static Function OkLeTxt

AjustaSx1()
//CRIAR PARÂMETRO
Private cPerg	:= "IMPB1B5"

if !Pergunte(cPerg,.t.)
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

if empty(MV_PAR01) //.OR. EMPTY(MV_PAR02)
	MsgAlert("Preencha todos os parâmetros da rotina!")
	Return
Endif

Processa({|| EXECIMPSB1() },"Verificando tabelas...")

Return(.T.)


//Verificação das tabelas
Static Function EXECIMPSB1

Local nTamFile, nTamLin, cBuffer, nBtLidos
Local lOk    := .T.
Local aItens := {}
Local aHeadB5 := {}
Local aHeadB1 := {}

PRIVATE lMsErroAuto := .F.

aErros	:= {}

nTamFile := fSeek(nHdl,0,2)

ProcRegua(nTamFile) // Numero de registros a processar

ft_fuse(cArqTxt)

cProd := ""
nCont := 1

While !ft_feof()
	
	cBuffer := ft_freadln()
	
	// Percorre a linha até encontrar a ultima coluna da planilha
	While right(alltrim(cBuffer),6) <> "FFIIMM"
		ft_fskip() // Leitura da proxima linha do arquivo texto
		cBuf1 	:= ft_freadln()
		cBuffer	:= cBuffer+cBuf1
	End
	
	aRet := StrTokArr(cBuffer,";")
	
	IncProc("Lendo Referência : " + aRet[1] + " Linha : " + strzero((nCont ),4))

	if nCont > 1
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		If !DBSEEK(XFILIAL("SB1")+aRet[1])
			cProd	:= "0"+aRet[1]
		Else
			cProd	:= aRet[1]
		Endif
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		DBGOTOP()
		IF DBSEEK(XFILIAL("SB1")+cProd)
			GravaRef(cProd,aRet)
		ELSE
			ALERT("PRODUTO NÃO ENCONTRADO! "+cProd)
		ENDIF
	endif
	nCont := nCont + 1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Leitura da proxima linha do arquivo texto.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	ft_fskip() // Leitura da proxima linha do arquivo texto
	
EndDo

alert("Atualização efetuada com sucesso!!!")

Close(oLeTxt)


Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Rodrigo Okamoto        ³ Data ³14/03/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Acerta o arquivo de perguntas                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSx1()

Local aArea := GetArea()
Local aHelpP	:= {}
Local aHelpE	:= {}
Local aHelpS	:= {}

Aadd( aHelpP, "Informe o local e nome do arquivo de origem dos dados a serem importados " )
PutSx1("IMPB1B5","01","Arquivo a ser importado ?     "  ,"Arquivo a ser importado ?     ","Arquivo a ser importado ?     ","mv_ch1","C",80,0,0,"G","U_SELB1B5()","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par01        // Data de                  		         ³
aHelpP	:= {}
//Aadd( aHelpP, "Informe a tabela a ser atualizada " )
//PutSx1("IMPDA1","02","Tabela de preços ?"  ,"Tabela de preços ?","Tabela de preços ?","mv_ch2","C",3,0,0,"G","NAOVAZIO().AND.EXISTCPO('DA0')","DA0","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par02        // Data ate  					       		 ³

RestArea(aArea)

Return



//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³SEL_ARQ   ºAutor  ³Rafael Augusto      º Data ³  04/08/10   º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDesc.     ³ Abre tela no servidor para o usuario localizar o arquivo   º±±
//±±º          ³ que sera utilizado.                                        º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ P10                                                        º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß


User Function SELB1B5()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:=  "Arquivos CSV (*.csv) |*.csv|"
Local cNewPathArq :=  cGetFile( "Arquivos CSV (*.csv) |*.csv|" , "Selecione o arquivo" )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Limpa o parametro para a Carga do Novo Arquivo                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SX1")
DBSETORDER(1)

IF lAchou := ( SX1->( dbSeek( PADR(cPerg,10) + "01" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 := cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	MV_PAR01 	  := cNewPathArq
	MsUnLock()
EndIF

Return(.T.)


Static Function GravaRef(cProd,aRet)


DBSELECTAREA("SB1")
DBSETORDER(1)
DBSEEK(XFILIAL("SB1")+padr(cProd,15))
RECLOCK("SB1",.F.)

Replace B1_PLATAF	WITH if(aRet[3]=="CCC","",strzero(val(aRet[3]),6)) //strzero(val(aRet[3]),6)
Replace B1_ALT		WITH if(aRet[6]=="CCC",0,val(STRTRAN(aRet[6],",",".")))
Replace B1_LARGURA	WITH if(aRet[7]=="CCC",0,val(STRTRAN(aRet[7],",",".")))
Replace B1_PROF		WITH if(aRet[8]=="CCC",0,val(STRTRAN(aRet[8],",",".")))
Replace B1_PESO		WITH if(aRet[9]=="CCC",0,val(STRTRAN(aRet[9],",",".")))
Replace B1_CODGEN	WITH if(aRet[10]=="CCC","",if(len(aRet[10])==1,"0"+aRet[10],aRet[10])) 
Replace B1_OLD		WITH if(aRet[14]=="CCC","",aRet[14])
Replace B1_ECIV		WITH if(aRet[15]=="CCC","",aRet[15])
Replace B1_PLATEXT	WITH if(aRet[34]=="CCC","",aRet[34])
Replace B1_CONSUMI	WITH if(aRet[44]=="CCC",0,val(STRTRAN(aRet[44],",",".")))
Replace B1_XDESC	WITH if(aRet[45]=="CCC","",aRet[45])

MsUnlock()

DBSELECTAREA("SB5")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SB5")+padr(cProd,15))
	
	RECLOCK("SB5",.F.)
	
	Replace B5_TITULO	WITH if(aRet[2]=="CCC","",aRet[2])
	Replace B5_CEME		WITH if(aRet[2]=="CCC","",aRet[2])
	Replace B5_PUBLISH	WITH if(aRet[4]=="CCC","",aRet[4])
//	Replace B5_VBUNDLE	WITH if(aRet[5]=="CCC","",aRet[5])
	Replace B5_GENERO1	WITH if(aRet[11]=="CCC","",if(len(aRet[11])==1,"0"+aRet[11],aRet[11]))
	Replace B5_GENERO2	WITH if(aRet[12]=="CCC","",if(len(aRet[12])==1,"0"+aRet[12],aRet[12]))
	Replace B5_GENERO3	WITH if(aRet[13]=="CCC","",if(len(aRet[13])==1,"0"+aRet[13],aRet[13]))
	Replace B5_VREQSIS	WITH if(aRet[16]=="CCC","",aRet[16])
	Replace B5_SINOPS	WITH if(aRet[17]=="CCC","",aRet[17])
	Replace B5_SINOPSE	WITH if(aRet[18]=="CCC","",aRet[18])
	Replace B5_LINKA	WITH if(aRet[19]=="CCC","",aRet[19])
	Replace B5_TAG1		WITH if(aRet[20]=="CCC","",aRet[20])
	Replace B5_TAG2		WITH if(aRet[21]=="CCC","",aRet[21])
	Replace B5_TAG3		WITH if(aRet[22]=="CCC","",aRet[22])
	Replace B5_TAG4		WITH if(aRet[23]=="CCC","",aRet[23])
	Replace B5_TAG5		WITH if(aRet[24]=="CCC","",aRet[24])
	Replace B5_TAG6		WITH if(aRet[25]=="CCC","",aRet[25])
	Replace B5_TAG7		WITH if(aRet[26]=="CCC","",aRet[26])
	Replace B5_TAG8		WITH if(aRet[27]=="CCC","",aRet[27])
	Replace B5_TAG9		WITH if(aRet[28]=="CCC","",aRet[28])
	Replace B5_TAG10	WITH if(aRet[29]=="CCC","",aRet[29])
	Replace B5_INFCONS	WITH if(aRet[30]=="CCC","",aRet[30])
	Replace B5_INFREV	WITH if(aRet[31]=="CCC","",aRet[31])
	Replace B5_GRPSITE	WITH if(aRet[32]=="CCC","",aRet[32])
	Replace B5_DTBUSCA	WITH if(aRet[33]=="CCC",CTOD("  /  /  "),ctod(aRet[33])) //DATA
	Replace B5_NUMVID	WITH if(aRet[35]=="CCC","",aRet[35])
	Replace B5_OUTVER	WITH if(aRet[36]=="CCC","",aRet[36])
	Replace B5_VSINTIT	WITH if(aRet[37]=="CCC","",aRet[37])
	Replace B5_PREVCHE	WITH if(aRet[38]=="CCC",CTOD("  /  /  "),ctod(aRet[38])) //DATA
	Replace B5_FOCO		WITH if(aRet[39]=="CCC","",aRet[39])
	Replace B5_DTLAN	WITH if(aRet[40]=="CCC",CTOD("  /  /  "),ctod(aRet[40])) //DATA
	Replace B5_LANCSIM	WITH if(aRet[41]=="CCC","",aRet[41])
	Replace B5_NUMJOG	WITH if(aRet[42]=="CCC","",aRet[42])
	Replace B5_PROMFER	WITH if(aRet[43]=="CCC","",aRet[43])
	Replace B5_TARGET	WITH if(aRet[46]=="CCC","",aRet[46])	
	MsUnlock()
	
ELSE
	
	RECLOCK("SB5",.T.)
	
	Replace B5_FILIAL	WITH XFILIAL("SB5")
	Replace B5_COD		WITH padr(cProd,15)
	Replace B5_TITULO	WITH if(aRet[2]=="CCC","",aRet[2])
	Replace B5_CEME		WITH if(aRet[2]=="CCC","",aRet[2])
	Replace B5_PUBLISH	WITH if(aRet[4]=="CCC","",aRet[4])
 //	Replace B5_VBUNDLE	WITH if(aRet[5]=="CCC","",aRet[5])
	Replace B5_GENERO1	WITH if(aRet[11]=="CCC","",if(len(aRet[11])==1,"0"+aRet[11],aRet[11]))
	Replace B5_GENERO2	WITH if(aRet[12]=="CCC","",if(len(aRet[12])==1,"0"+aRet[12],aRet[12]))
	Replace B5_GENERO3	WITH if(aRet[13]=="CCC","",if(len(aRet[13])==1,"0"+aRet[13],aRet[13]))
	Replace B5_VREQSIS	WITH if(aRet[16]=="CCC","",aRet[16])
	Replace B5_SINOPS	WITH if(aRet[17]=="CCC","",aRet[17])
	Replace B5_SINOPSE	WITH if(aRet[18]=="CCC","",aRet[18])
	Replace B5_LINKA	WITH if(aRet[19]=="CCC","",aRet[19])
	Replace B5_TAG1		WITH if(aRet[20]=="CCC","",aRet[20])
	Replace B5_TAG2		WITH if(aRet[21]=="CCC","",aRet[21])
	Replace B5_TAG3		WITH if(aRet[22]=="CCC","",aRet[22])
	Replace B5_TAG4		WITH if(aRet[23]=="CCC","",aRet[23])
	Replace B5_TAG5		WITH if(aRet[24]=="CCC","",aRet[24])
	Replace B5_TAG6		WITH if(aRet[25]=="CCC","",aRet[25])
	Replace B5_TAG7		WITH if(aRet[26]=="CCC","",aRet[26])
	Replace B5_TAG8		WITH if(aRet[27]=="CCC","",aRet[27])
	Replace B5_TAG9		WITH if(aRet[28]=="CCC","",aRet[28])
	Replace B5_TAG10	WITH if(aRet[29]=="CCC","",aRet[29])
	Replace B5_INFCONS	WITH if(aRet[30]=="CCC","",aRet[30])
	Replace B5_INFREV	WITH if(aRet[31]=="CCC","",aRet[31])
	Replace B5_GRPSITE	WITH if(aRet[32]=="CCC","",aRet[32])
	Replace B5_DTBUSCA	WITH if(aRet[33]=="CCC",CTOD("  /  /  "),ctod(aRet[33])) //DATA
	Replace B5_NUMVID	WITH if(aRet[35]=="CCC","",aRet[35])
	Replace B5_OUTVER	WITH if(aRet[36]=="CCC","",aRet[36])
	Replace B5_VSINTIT	WITH if(aRet[37]=="CCC","",aRet[37])
	Replace B5_PREVCHE	WITH if(aRet[38]=="CCC",CTOD("  /  /  "),ctod(aRet[38])) //DATA
	Replace B5_FOCO		WITH if(aRet[39]=="CCC","",aRet[39])
	Replace B5_DTLAN	WITH if(aRet[40]=="CCC",CTOD("  /  /  "),ctod(aRet[40])) //DATA
	Replace B5_LANCSIM	WITH if(aRet[41]=="CCC","",aRet[41])
	Replace B5_NUMJOG	WITH if(aRet[42]=="CCC","",aRet[42])
	Replace B5_PROMFER	WITH if(aRet[43]=="CCC","",aRet[43])
	Replace B5_TARGET	WITH if(aRet[46]=="CCC","",aRet[46])	
			
	MsUnlock()
	
ENDIF

RETURN
