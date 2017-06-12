#INCLUDE "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GERAGNRE  �Autor  �Rogerio - STCH      � Data �  06/28/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Programa criado para gerar arquivo txt para importar para   ���
���          �programa da GNRE - ST                                       ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function GERAGNRE

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Private cPerg       := "GERAGNRE"
Private oGeraTxt
Private cString := "SF6"

dbSelectArea("SF6")
dbSetOrder(1)

//���������������������������������������������������������������������Ŀ
//� Montagem da tela de processamento.                                  �
//�����������������������������������������������������������������������

@ 200,1 TO 380,450 DIALOG oGeraTxt TITLE OemToAnsi("Gera�o de Arquivo Texto - NC GAMES")
@ 02,10 TO 080,190
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " SF6 para envio a GNRE                                       "

@ 70,128 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 70,188 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
��������������������������������������������������������������������������"��
���Fun�"o    � OKGERATXT� Autor � AP5 IDE            � Data �  10/02/10   ���
�������������������������������������������������������������������������͹��
���Descri�"o � Funcao chamada pelo botao OK na tela inicial de processamen���
���          � to. Executa a geracao do arquivo texto.                    ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function OkGeraTxt

//���������������������������������������������������������������������Ŀ
//� Cria o arquivo texto                                                �
//�����������������������������������������������������������������������

Private cArqTxt := "C:\RELATORIOS\GNRE.TXT" 
Private nHdl    := fCreate(cArqTxt)

Private cEOL    := "CHR(13)+CHR(10)"
If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

If nHdl == -1
	MsgAlert("O arquivo de nome "+cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
	Return
Endif

//���������������������������������������������������������������������Ŀ
//� Inicializa a regua de processamento                                 �
//�����������������������������������������������������������������������

Processa({|| RunCont() },"Processando...")
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
��������������������������������������������������������������������������"��
���Fun�"o    � RUNCONT  � Autor � AP5 IDE            � Data �  10/02/10   ���
�������������������������������������������������������������������������͹��
���Descri�"o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunCont

Local nTamLin, cLin, cCpo

dbSelectArea("SF6")
dbSetOrder(1)
dbGoTop()

cDELIM 	:= ";"
cLin   	:= ""
cCpo	:= ""

While !EOF()
	//���������������������������������������������������������������������Ŀ
	//� Incrementa a regua                                                  �
	//�����������������������������������������������������������������������
	IncProc()
	//������������������������������������������������������������������"
	//� Lay-Out do arquivo Texto gerado:                                �
	//�����������������������������������������������������������������͹
	//�Campo           � Inicio � Tamanho                               �
	//������������������������������������������������������������������
	//� ??_FILIAL     � 01     � 02                                    �
	//�����������������������������������������������������������������ͼ
	If SF6->F6_DOC >=MV_PAR01 .AND. SF6->F6_DOC <= MV_PAR02 .AND. SF6->F6_SERIE == MV_PAR03
		
		cMesRef:= "1"+ALLTRIM(STR(SF6->F6_MESREF))
		
		If SF6->F6_MESREF<10
			cMesRef:="10"+ALLTRIM(STR(SF6->F6_MESREF))
		End If

		cCpo += SF6->F6_EST+CHR(09)+ ;
		ALLTRIM(SF6->F6_CODREC)+CHR(09)+ ;
		ALLTRIM(SF6->F6_CNPJ)+CHR(09)+ ;
		ALLTRIM(SF6->F6_DOC)+CHR(09)+ ;
		ALLTRIM(cMesRef)+ALLTRIM(STR(SF6->F6_ANOREF))+CHR(09)+ ;
		ALLTRIM(Transform(SF6->F6_VALOR,"@E 999999999.99"))+CHR(09)+ ;
		ALLTRIM(Transform(SF6->F6_ATMON,"@E 999999999.99"))+CHR(09)+ ;
		ALLTRIM(Transform(SF6->F6_JUROS,"@E 999999999.99"))+CHR(09)+ ;
		ALLTRIM(Transform(SF6->F6_MULTA,"@E 999999999.99"))+CHR(09)+ ;
		ALLTRIM(Transform(SF6->F6_VALOR,"@E 999999999.99"))+CHR(09)+ ;
		DTOC(SF6->F6_DTVENC)+CHR(09)+ ;
		ALLTRIM(SF6->F6_NUMCONV)+CHR(09)+ ;
		ALLTRIM(SF6->F6_NOMECOM)+CHR(09)+ ;
		SPACE(15)+CHR(09)+ ;
		ALLTRIM(SF6->F6_ENDENT)+CHR(09)+ ;
		ALLTRIM(SF6->F6_CIDENT)+CHR(09)+ ;
		ALLTRIM(SF6->F6_ESTENT)+CHR(09)+ ;
		ALLTRIM(Transform(SF6->F6_CEPENT,"@R 99999-999"))+CHR(09)+ ;
		SF6->F6_TEL+CHR(09)+ ;
		"PROD.C/SUBS. TRIB. CLASSIF. 85234029/95041010 NFF "+ALLTRIM(SF6->F6_DOC)+" DE "+DTOC(SF6->F6_DTARREC)+" "+ ;
		Getadvfval("SA1","A1_NOME",xFILIAL("SA1")+SF6->F6_CLIFOR+SF6->F6_LOJA,1)+"TIT N. "+SF6->F6_NUMERO +CHR(09)+ ;
		"99"+CHR(10)
	End If
	
	cLin := cCpo
	
	dbSkip()
	Loop

EndDo

//���������������������������������������������������������������������Ŀ
//� Gravacao no arquivo texto. Testa por erros durante a gravacao da    �
//� linha montada.                                                      �
//�����������������������������������������������������������������������

If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
		Return
	Endif
Endif

//���������������������������������������������������������������������Ŀ
//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
//� cao anterior.                                                       �
//�����������������������������������������������������������������������

fClose(nHdl)
Close(oGeraTxt)
MSGBOX("Rotina Concluida com sucesso. Arquivo criado no diretorio:"+cArqTxt+" ", "FIM DE PROCESSAMENTO", "STOP")
//MSGBOX("Arquivo criado no diretorio ", + cArqTxt +, "STOP")
Return

//���������������������������������������������������������������������Ŀ
//� Perguntas criadas manualmente no SX1								�
//�����������������������������������������������������������������������
//AADD(aRegs,{cPerg,"01","Da Nota    ?","","","mv_ch1","N",06,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SF2","",""})
//AADD(aRegs,{cPerg,"01","Ate a Nota    ?","","","mv_ch2","N",06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SF2","",""})