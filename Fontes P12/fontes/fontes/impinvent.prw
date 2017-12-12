#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �IMPINVENT � Autor � REINALDO CALDAS    � Data �  04/11/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC GAMES                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function ImpInvent()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local _aArea:=GetArea()
Private oLeTxt

Private cString := "SB1"
Private cPerg   := "INVENT"


dbSelectArea("SB1")
dbSetOrder(5)

//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Leitura de Arquivo Texto")
@ 02,10 TO 080,190
@ 10,018 Say " Este programa ira ler o conteudo de um arquivo texto, conforme"
@ 18,018 Say " os parametros definidos pelo usuario, com os registros do arquivo"
@ 26,018 Say " SB1                                                           "
@ 70,090 BMPBUTTON TYPE 05 ACTION Pergunte("INVENT",.T.) 
@ 70,128 BMPBUTTON TYPE 01 ACTION OkLeTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered

RestArea(_aArea)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � OKLETXT  � Autor � AP6 IDE            � Data �  04/11/04   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a leitura do arquivo texto.                    ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function OkLeTxt

//���������������������������������������������������������������������Ŀ
//� Abertura do arquivo texto                                           �
//�����������������������������������������������������������������������

Private nHdl    := fOpen(mv_par01)

Private cEOL    := "CHR(13)+CHR(10)"
If Empty(cEOL)
    cEOL := CHR(13)+CHR(10)
Else
    cEOL := Trim(cEOL)
    cEOL := &cEOL
Endif

If nHdl == -1
    MsgAlert("O arquivo de nome "+mv_par01+" nao pode ser aberto! Verifique os parametros.","Atencao!")
    Return
Endif

//���������������������������������������������������������������������Ŀ
//� Inicializa a regua de processamento                                 �
//�����������������������������������������������������������������������

Processa({|| RunCont() },"Processando...")

MsgAlert("Rotina finalizada com sucesso.")

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � RUNCONT  � Autor � AP5 IDE            � Data �  04/11/04   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos
Local _aArea :=GetArea()

//�����������������������������������������������������������������ͻ
//� Lay-Out do arquivo Texto gerado:                                �
//�����������������������������������������������������������������͹
//�Campo           � Inicio � Tamanho                               �
//�����������������������������������������������������������������Ķ
//� ??_FILIAL     � 01     � 15                                �
//� CCC     � 16  � 12                                �
//�����������������������������������������������������������������ͼ

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)
nTamLin  := 32 //+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

ProcRegua(nTamFile) // Numero de registros a processar

_nTeste	:= 0

While nBtLidos >= 30 //nTamLin
    
/*
	_nTeste++
	
	If _nTeste == 10
		Exit
	EndIf
*/
	
    //���������������������������������������������������������������������Ŀ
    //� Incrementa a regua                                                  �
    //�����������������������������������������������������������������������
    IncProc()
    
    _lProd	:= .F.
    dbSelectArea(cString)
    dbSetOrder(5)

	_cBusca	:= ALLTRIM(Substr(cBuffer,01,15))
	If dbSeek(xFilial("SB1")+_cBusca,.F.)
    		_lProd	:= .T.
    EndIF		
	//_nBusca	:= Val(_cBusca)
	//_cBusca := AllTrim(Str(_nBusca,15,0))
	/*
    While !_lProd .and. Len(_cBusca) <= 14

    	If dbSeek(xFilial("SB1")+_cBusca,.F.)
    		_lProd	:= .T.
    		Exit
    	Else
			_cBusca	:= "0"+_cBusca
	    EndIf

	EndDo 
	*/
	
    //���������������������������������������������������������������������Ŀ
    //� Grava os campos obtendo os valores da linha lida do arquivo texto.  �
    //�����������������������������������������������������������������������
	dbSelectArea("SB7")

	RecLock("SB7",.T.)

    SB7->B7_FILIAL :=xFilial("SB1")
    SB7->B7_COD    :=iif(_lProd, SB1->B1_COD, _CBUSCA )
    SB7->B7_LOCAL  :=iif(_lProd, SB1->B1_LOCPAD, "XX")
    SB7->B7_TIPO   :=IIF(_lProd, SB1->B1_TIPO, "XX" )
    SB7->B7_DOC    :="INVENT"
    SB7->B7_QUANT  :=NoRound(Val(Substr(cBuffer,16,12)),2)
    SB7->B7_QTSEGUM:=IIF(_lProd, NoRound(Val(Substr(cBuffer,16,12)),2)*SB1->B1_CONV, 0)
    SB7->B7_DATA   :=dDatabase

	MSUnLock()

    //���������������������������������������������������������������������Ŀ
    //� Leitura da proxima linha do arquivo texto.                          �
    //�����������������������������������������������������������������������

    nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto

    dbSkip()
EndDo

//���������������������������������������������������������������������Ŀ
//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
//� cao anterior.                                                       �
//�����������������������������������������������������������������������

fClose(nHdl)

RestArea(_aArea)

Return
