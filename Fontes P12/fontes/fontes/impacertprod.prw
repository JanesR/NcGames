#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �IMPACPRO  � Autor � Erich Buttner      � Data �  15/08/12   ���
�������������������������������������������������������������������������͹��
���Descricao � PROGRAMA PARA IMPORTAR OS DADOS E REALIZAR ALTERA��O NOS   ���
���          � CAMPOS CONFORME ARQUIVO DE TEXTO                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function IMPACPRO

//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

@ 200,001 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Importa��o Produtos")
@ 002,010 TO 080,190
@ 010,018 Say " Este programa ira ler o conteudo de um arquivo texto, ordenado  "
@ 018,018 Say " com as colunas na sequ�ncia e na primeira linha o nome do campo "
@ 026,018 Say ""

@ 070,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 070,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

Return


Static Function OkLeTxt

AjustaSx1()
//CRIAR PAR�METRO
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
	MsgAlert("Preencha todos os par�metros da rotina!")
	Return
Endif

Processa({|| EXECIMPSB1() },"Verificando tabelas...")

Return(.T.)


//Verifica��o das tabelas
Static Function EXECIMPSB1

Local nTamFile, nTamLin, cBuffer, nBtLidos
Local lOk    := .T.
Local aItens := {}
Local aHeadB5 := {}
Local aHeadB1 := {}
Local nRet := 0

PRIVATE lMsErroAuto := .F.

aErros	:= {}

nTamFile := fSeek(nHdl,0,2)

ProcRegua(nTamFile) // Numero de registros a processar

ft_fuse(cArqTxt)

cProd := ""
nCont := 1
nConta:= 1

While !ft_feof()
	
	cBuffer := ft_freadln()
	
	// Percorre a linha at� encontrar a ultima coluna da planilha
	IF  right(alltrim(cBuffer),6) == "FFIIMM" .AND. NCONTA == 1
		aRet := StrTokArr(cBuffer,";")
		ft_fskip() // Leitura da proxima linha do arquivo texto
		cBuffer := ft_freadln()
		NCONTA == 2
	ENDIF
	
	IF  right(alltrim(cBuffer),6) == "FFIIMM"
		aRet1 := StrTokArr(cBuffer,";")
		//ft_fskip() // Leitura da proxima linha do arquivo texto
		cBuffer := ft_freadln()
		
		
		IncProc("Lendo Refer�ncia : " + aRet1[1] + " Linha : " + strzero((nCont ),4))
		
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		If !DBSEEK(XFILIAL("SB1")+aRet1[1])
			cProd	:= "0"+aRet1[1]
		Else
			cProd	:= aRet1[1]
		Endif
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		DBGOTOP()
		IF DBSEEK(XFILIAL("SB1")+cProd)
			GravaRef(cProd,aRet1)
		ELSE
			ALERT("PRODUTO N�O ENCONTRADO! "+cProd)
		ENDIF
		nCont := nCont + 1
		
		//���������������������������������������������������������������������Ŀ
		//� Leitura da proxima linha do arquivo texto.                          �
		//�����������������������������������������������������������������������
		
	ENDIF
	ft_fskip() // Leitura da proxima linha do arquivo texto
EndDo

alert("Atualiza��o efetuada com sucesso!!!")

Close(oLeTxt)


Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �AjustaSX1 � Autor �Erich Buttner          � Data �15/08/2012���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Acerta o arquivo de perguntas                               ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSx1()

Local aArea := GetArea()
Local aHelpP	:= {}
Local aHelpE	:= {}
Local aHelpS	:= {}

Aadd( aHelpP, "Informe o local e nome do arquivo de origem dos dados a serem importados " )
PutSx1("IMPB1B5","01","Arquivo a ser importado ?     "  ,"Arquivo a ser importado ?     ","Arquivo a ser importado ?     ","mv_ch1","C",80,0,0,"G","U_SEL()","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
aHelpP	:= {}

RestArea(aArea)

Return



//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//�������������������������������������������������������������������������ͻ��
//���Programa  �SEL_ARQ   �Autor  �Erich Buttner       � Data �  15/08/12   ���
//�������������������������������������������������������������������������͹��
//���Desc.     � Abre tela no servidor para o usuario localizar o arquivo   ���
//���          � que sera utilizado.                                        ���
//�������������������������������������������������������������������������͹��
//���Uso       � P10                                                        ���
//�������������������������������������������������������������������������ͼ��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������


User Function SEL()

Local cSvAlias		:= Alias()
Local lAchou		:= .F.
Local cTipo			:=  "Arquivos CSV (*.csv) |*.csv|"
Local cNewPathArq :=  cGetFile( "Arquivos CSV (*.csv) |*.csv|" , "Selecione o arquivo" )
//�����������������������������������������������������������������������Ŀ
//�Limpa o parametro para a Carga do Novo Arquivo                         �
//�������������������������������������������������������������������������

DbSelectArea("SX1")
DBSETORDER(1)

IF lAchou := ( SX1->( dbSeek( PADR(cPerg,10) + "01" , .T. ) ) )
	RecLock("SX1",.F.,.T.)
	SX1->X1_CNT01 := cNewPathArq //Space( Len( SX1->X1_CNT01 ) )
	MV_PAR01 	  := cNewPathArq
	MsUnLock()
EndIF

Return(.T.)

//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//�������������������������������������������������������������������������ͻ��
//���Programa  �GRAVAREF  �Autor  �Erich Buttner       � Data �  15/08/12   ���
//�������������������������������������������������������������������������͹��
//���Desc.     � Grava Resultado na Tabela SB5 ou SB1                       ���
//���          �                                                            ���
//�������������������������������������������������������������������������͹��
//���Uso       � P10                                                        ���
//�������������������������������������������������������������������������ͼ��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������

Static Function GravaRef(cProd,aRet1)

For I:=2 to Len(aRet)
	cCampo:= aRet[I]
	IF aRet[I] <> "FFIIMM"
		dbSelectArea("SX3")
		dbSetOrder(2)
		IF DBSEEK(ALLTRIM(cCampo))
			IF "B1_"$ cCampo
				DBSELECTAREA("SB1")
				DBSETORDER(1)
				DBSEEK(XFILIAL("SB1")+padr(cProd,15))
				RECLOCK("SB1",.F.)
				IF  SX3->X3_TIPO == 'M'
					cInfo := aRet1[I]
					IF cInfo <> "CCC"
						MSMM( "SB1->"+ALLTRIM(cCampo),80,,cInfo, 1,,, "SB1","'"+cCampo+"'" )
				    ENDIF
				ELSEIF SX3->X3_TIPO == 'N'
					cInfo := ALLTRIM(STRTRAN(aRet1[I],",","."))
					cInfo := IIF(VALTYPE(cInfo) == 'C'.OR. cInfo<>"CCC",VAL(cInfo),IIF(cInfo=="CCC",1,IIF(cInfo=="BBB",2,cInfo)))
					IF cInfo <> 1
						Replace &cCampo WITH If(cInfo==2," ",cInfo)
				    ENDIF
				ELSEIF SX3->X3_TIPO == 'D'
					cInfo := aRet1[I]
					IF ALLTRIM(cInfo) <> "CCC" .OR. ALLTRIM(cInfo) <> "BBB" .OR. !EMPTY(cInfo)
						cInfo := IIF(VALTYPE(aRet1[I]) <> 'D',CTOD(aRet1[I]),aRet1[I])
						Replace &cCampo WITH cInfo
					ENDIF
				ELSE
					cInfo := aRet1[I]
					IF cInfo <> "CCC"
						Replace &cCampo WITH If(cInfo=="BBB"," ",cInfo)
				    ENDIF
				ENDIF
				MsUnlock()
			ELSEIF "B5_"$ cCampo
				
				DBSELECTAREA("SB5")
				DBSETORDER(1)
				IF DBSEEK(XFILIAL("SB5")+padr(cProd,15))
					RECLOCK("SB5",.F.)
					IF  SX3->X3_TIPO == 'M'
						cInfo := aRet1[I]
						MSMM( "SB5->"+ALLTRIM(cCampo),80,,cInfo, 1,,, "SB1","'"+cCampo+"'" )
					ELSEIF SX3->X3_TIPO == 'N'
						cInfo := STRTRAN(aRet1[I],",",".")
						cInfo := IIF(VALTYPE(cInfo) == 'C'.OR. cInfo<>"CCC",VAL(cInfo),IIF(cInfo=="CCC",1,IIF(cInfo=="BBB",2,cInfo)))
						IF cInfo <> 1
							Replace &cCampo WITH If(cInfo==2," ",cInfo)
						ENDIF	
					ELSEIF SX3->X3_TIPO == 'D'
						cInfo := aRet1[I]
						IF ALLTRIM(cInfo) <> "CCC" .OR. ALLTRIM(cInfo) <> "BBB" .OR. !EMPTY(cInfo)
							cInfo := IIF(VALTYPE(aRet1[I]) <> 'D',CTOD(aRet1[I]),aRet1[I])
							Replace &cCampo WITH cInfo
						ENDIF
					ELSE
						cInfo := aRet1[I]
						IF cInfo <> "CCC"
							Replace &cCampo WITH If(cInfo=="BBB"," ",cInfo)
						ENDIF	
					ENDIF
					MsUnlock()
				ELSE
					
					RECLOCK("SB5",.T.)
					Replace B5_FILIAL	WITH XFILIAL("SB5")
					Replace B5_COD		WITH padr(cProd,15)
					
					IF  SX3->X3_TIPO == 'M'
						cInfo := aRet1[I]
					    IF cInfo <> "CCC"
							MSMM( "SB5->"+ALLTRIM(cCampo),80,,cInfo, 1,,, "SB1","'"+cCampo+"'" )
					    ENDIF
					ELSEIF SX3->X3_TIPO == 'N'
						cInfo := STRTRAN(aRet1[I],",",".")
						cInfo := IIF(VALTYPE(cInfo) == 'C'.OR. cInfo<>"CCC",VAL(cInfo),IIF(cInfo=="CCC",1,IIF(cInfo=="BBB",2,cInfo)))
						IF cInfo <> 1
							Replace &cCampo WITH If(cInfo==2," ",cInfo)
					    ENDIF
					ELSEIF SX3->X3_TIPO == 'D'
						cInfo := aRet1[I]
						IF ALLTRIM(cInfo) <> "CCC" .OR. ALLTRIM(cInfo) <> "BBB" .OR. !EMPTY(cInfo)
							cInfo := IIF(VALTYPE(aRet1[I]) <> 'D',CTOD(aRet1[I]),aRet1[I])
							Replace &cCampo WITH cInfo
						ENDIF
					ELSE
						cInfo := aRet1[I]
						IF cInfo=="CCC"
							Replace &cCampo WITH If(cInfo=="BBB"," ",cInfo)
					    ENDIF
					ENDIF
					
					MsUnlock()
					
				ENDIF
			ENDIF
		ENDIF
	ENDIF
NEXT I

RETURN
