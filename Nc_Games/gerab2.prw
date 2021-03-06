#INCLUDE "rwmake.ch"


User Function GERAB2


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Private cPerg       := "SB2WIS"
Private oGeraTxt

Private cString := "SB2"

dbSelectArea("SB2")
dbSetOrder(1)
Pergunte(cPerg,.F.)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Montagem da tela de processamento.                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

@ 200,1 TO 380,450 DIALOG oGeraTxt TITLE OemToAnsi("Gera뇇 de Arquivo Texto - WISBBC")
@ 02,10 TO 080,190
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " SB2 para envio a WISBBC                                       "

@ 70,128 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 70,188 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴�"굇
굇튔un�"o    � OKGERATXT� Autor � AP5 IDE            � Data �  10/02/10   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri�"o � Funcao chamada pelo botao OK na tela inicial de processamen볍�
굇�          � to. Executa a geracao do arquivo texto.                    볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function OkGeraTxt

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Cria o arquivo texto                                                �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Private cArqTxt := "C:\Relatorios\estoques.TXT" //"C:\Relatorios\estoques.TXT"
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicializa a regua de processamento                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Processa({|| RunCont() },"Processando...")
Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴�"굇
굇튔un�"o    � RUNCONT  � Autor � AP5 IDE            � Data �  10/02/10   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri�"o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  볍�
굇�          � monta a janela com a regua de processamento.               볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function RunCont

Local nTamLin, cLin, cCpo


//� While !EOF() .And. xFilial() == A1_FILIAL .And. A1_COD <= mv_par02  �
//�                                                                     �
//�     If A1_EST <> mv_par03                                           �
//�         dbSkip()                                                    �
//�         Loop                                                        �
//�     Endif                                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

dbSelectArea(cString)
dbGoTop()

ProcRegua(RecCount()) // Numero de registros a processar

While !EOF() //.AND. xFilial() == B2_FILIAL  //B2_FILIAL > mv_par01 .AND. B2_FILIAL <= mv_par02
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Incrementa a regua                                                  �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	
	If B2_FILIAL < mv_par01 .or. B2_FILIAL > mv_par02 //.OR. B2_LOCAL > MV_PAR04 If B2_FILIAL < mv_par01 //.OR. B2_LOCAL > MV_PAR04
		dbSkip()
		Loop
	Endif
	
	
	
	If B2_LOCAL < mv_par03 .OR. B2_LOCAL > MV_PAR04
		dbSkip()
		Loop
	Endif
	
	
	If B2_COD < mv_par05 .OR. B2_COD > MV_PAR06
		dbSkip()
		Loop
	Endif
	
	
	IncProc()
	
	//�袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�"
	//� Lay-Out do arquivo Texto gerado:                                �
	//勁袴袴袴袴袴袴袴錮袴袴袴袴佶袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
	//튏ampo           � Inicio � Tamanho                               �
	//픔컴컴컴컴컴컴컴컵컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
	//� ??_FILIAL     � 01     � 02                                    �
	//훤袴袴袴袴袴袴袴賈袴袴袴袴鳩袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
	cDELIM := ";"
	nTamLin := 2
	cLin    := Space(nTamLin)+cEOL // Variavel para criacao da linha do registros para gravacao
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Substitui nas respectivas posicioes na variavel cLin pelo conteudo  �
	//� dos campos segundo o Lay-Out. Utiliza a funcao STUFF insere uma     �
	//� string dentro de outra string.                                      �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	/*
	B1_COD               15                           C             0
	B1_DESC             100                        C             0
	B1_XDESC           100                        C             0
	B1_LOCPAD       2                             C             0
	B1_MSBLQL       1                             C             0
	B1_CODBAR      15                           C             0
	B1_UM                2                             C             0
	*/
	
	
	/*
	cCpo := PADR(SB1->B1_COD+cDELIM,16) + ;
	PADR(SB1->B1_DESC+cDELIM,101) + ;
	PADR(SB1->B1_XDESC+cDELIM,101) + ;
	PADR(SB1->B1_LOCPAD+cDELIM,3) + ;
	PADR(SB1->B1_MSBLQL+cDELIM,2) + ;
	PADR(SB1->B1_CODBAR+cDELIM,16) + ;
	PADR(SB1->B1_UM+cDELIM,3)  + cEOL
	*/                                            
	




	cCpo := ALLTRIM(SB2->B2_FILIAL)+cDELIM + ;
	RIGHT(REPLICATE("0",15)+ALLTRIM(SB2->B2_COD),15)+cDELIM + ;
	RIGHT(REPLICATE("0",15)+ALLTRIM(GETADVFVAL('SB1','B1_CODBAR',XFILIAL('SB1')+SB2->B2_COD,1,'') ),15)+cDELIM + ;
	ALLTRIM(SB2->B2_LOCAL)+cDELIM + ;
	RIGHT(REPLICATE("0",14)+ALLTRIM(STR(SB2->B2_QATU*100)),14)+cDELIM + ;	//ALLTRIM(TRANSFORM(SB2->B2_QATU,'999,999,999.99'))+cDELIM + ;
	RIGHT(REPLICATE("0",14)+ALLTRIM(STR(SB2->B2_VATU1*100)),14)+cDELIM + ;//ALLTRIM(TRANSFORM(SB2->B2_VATU1,'999,999,999.99'))+cDELIM + ;
	RIGHT(REPLICATE("0",14)+ALLTRIM(STR(SB2->B2_CM1*10000)),14)+cDELIM +  cEOL//ALLTRIM(TRANSFORM(SB2->B2_CM1,'999,999,999.99'))+cDELIM +  cEOL
	
	cLin := Stuff(cLin,01,LEN(cCPO),cCpo)
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Gravacao no arquivo texto. Testa por erros durante a gravacao da    �
	//� linha montada.                                                      �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	
	If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Exit
		Endif
	Endif
	
	dbSkip()
EndDo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
//� cao anterior.                                                       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�


fClose(nHdl)
Close(oGeraTxt)
MSGBOX("Rotina Concluida com sucesso.", "FIM DE PROCESSAMENTO", "STOP")
Return
