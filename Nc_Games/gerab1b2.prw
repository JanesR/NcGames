#INCLUDE "rwmake.ch"


User Function GERAB1B2


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Private cPerg       := "SB1WIS"
Private oGeraTxt

Private cString := "SB1"

Pergunte(cPerg,.F.)

dbSelectArea("SB1")
dbSetOrder(1)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Montagem da tela de processamento.                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

@ 200,1 TO 380,450 DIALOG oGeraTxt TITLE OemToAnsi("Gera뇙o de Arquivo Texto")
@ 02,10 TO 080,190
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " SB1 para envio a WISBBC                                       "

@ 70,128 BMPBUTTON TYPE 01 ACTION OkGeraTxt()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 70,188 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)

Activate Dialog oGeraTxt Centered

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    � OKGERATXT� Autor � AP5 IDE            � Data �  10/02/10   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Funcao chamada pelo botao OK na tela inicial de processamen볍�
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

Private cArqTxt := "C:\Relatorios\produtos.TXT"
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
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    � RUNCONT  � Autor � AP5 IDE            � Data �  10/02/10   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  볍�
굇�          � monta a janela com a regua de processamento.               볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function RunCont

Local nTamLin, cLin, cCpo


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Posicionamento do primeiro registro e loop principal. Pode-se criar �
//� a logica da seguinte maneira: Posiciona-se na filial corrente e pro �
//� cessa enquanto a filial do registro for a filial corrente. Por exem �
//� plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    �
//�                                                                     �
//� dbSeek(xFilial())                                                   �
//� While !EOF() .And. xFilial() == A1_FILIAL                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� O tratamento dos parametros deve ser feito dentro da logica do seu  �
//� programa.  Geralmente a chave principal e a filial (isto vale prin- �
//� cipalmente se o arquivo for um arquivo padrao). Posiciona-se o pri- �
//� meiro registro pela filial + pela chave secundaria (codigo por exem �
//� plo), e processa enquanto estes valores estiverem dentro dos parame �
//� tros definidos. Suponha por exemplo o uso de dois parametros:       �
//� mv_par01 -> Indica o codigo inicial a processar                     �
//� mv_par02 -> Indica o codigo final a processar                       �
//�                                                                     �
//� dbSeek(xFilial()+mv_par01,.T.) // Posiciona no 1o.reg. satisfatorio �
//� While !EOF() .And. xFilial() == A1_FILIAL .And. A1_COD <= mv_par02  �
//�                                                                     �
//� Assim o processamento ocorrera enquanto o codigo do registro posicio�
//� nado for menor ou igual ao parametro mv_par02, que indica o codigo  �
//� limite para o processamento. Caso existam outros parametros a serem �
//� checados, isto deve ser feito dentro da estrutura de la�o (WHILE):  �
//�                                                                     �
//� mv_par01 -> Indica o codigo inicial a processar                     �
//� mv_par02 -> Indica o codigo final a processar                       �
//� mv_par03 -> Considera qual estado?                                  �
//�                                                                     �
//� dbSeek(xFilial()+mv_par01,.T.) // Posiciona no 1o.reg. satisfatorio �
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

While !EOF()
	
	IF MV_PAR01 <> 1
		LMOVTO := FMOVTO(B1_COD)
		
		If mv_par01 == 2 .AND. !LMOVTO
			dbSkip()
			Loop
		Endif
		
		If mv_par01 == 3 .AND. LMOVTO
			dbSkip()
			Loop
		Endif
	ENDIF
	
	If SB1->B1_LOCPAD < mv_par02 .OR. SB1->B1_LOCPAD > MV_PAR03
		dbSkip()
		Loop
	Endif
	
	
	If SB1->B1_COD < mv_par04 .OR. SB1->B1_COD > MV_PAR05
		dbSkip()
		Loop
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Incrementa a regua                                                  �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	
	IncProc()
	
	//�袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴敲
	//� Lay-Out do arquivo Texto gerado:                                �
	//勁袴袴袴袴袴袴袴錮袴袴袴袴佶袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
	//튏ampo           � Inicio � Tamanho                               �
	//픔컴컴컴컴컴컴컴컵컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
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
	cCpo := SB1->B1_COD+cDELIM + ;
	LEFT(SB1->B1_DESC,100)+cDELIM + ;
	LEFT(SB1->B1_XDESC,100)+cDELIM + ;
	SB1->B1_LOCPAD+cDELIM + ;
	SB1->B1_MSBLQL+cDELIM + ;
	SB1->B1_CODBAR+cDELIM + ;
	SB1->B1_UM+cDELIM  + cEOL
	
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

Static Function FMOVTO(ccod)
ASB1 := GETAREA()
lRet := .f.

nTOTREC := 0
cCmd := ChangeQuery("SELECT COUNT(*) AS NCOUNT FROM " +RetSqlName("SD1")+" WHERE D1_COD = '" + cCOD + "' AND D_E_L_E_T_ <> '*' ")
dbUseArea(.T., "TOPCONN", TCGENQRY(,,cCmd), "QRYTEMP", .F., .T.)
nTOTREC += QRYTEMP->NCOUNT
QRYTEMP->(DBCLOSEAREA())

cCmd := ChangeQuery("SELECT COUNT(*) AS NCOUNT FROM " +RetSqlName("SD2")+" WHERE D2_COD = '" + cCOD + "' AND D_E_L_E_T_ <> '*' ")
dbUseArea(.T., "TOPCONN", TCGENQRY(,,cCmd), "QRYTEMP", .F., .T.)
nTOTREC += QRYTEMP->NCOUNT
QRYTEMP->(DBCLOSEAREA())

cCmd := ChangeQuery("SELECT COUNT(*) AS NCOUNT FROM " +RetSqlName("SD3")+" WHERE D3_COD = '" + cCOD + "' AND D_E_L_E_T_ <> '*' ")
dbUseArea(.T., "TOPCONN", TCGENQRY(,,cCmd), "QRYTEMP", .F., .T.)
nTOTREC += QRYTEMP->NCOUNT
QRYTEMP->(DBCLOSEAREA())

IF nTOTREC > 0
	lRet := .T.
ENDIF
RESTAREA(aSB1)
Return lRet


