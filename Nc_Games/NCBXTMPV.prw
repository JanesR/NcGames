#Include 'Protheus.ch'

#DEFINE PREFIXO 		1
#DEFINE TITULO 		2
#DEFINE PARCELA		3
#DEFINE TIPO			4
#DEFINE DESCONTO		5
#DEFINE VALOR			6
#DEFINE HISTORICO		7
#DEFINE STATUS		8
#DEFINE OBSERVACAO	9


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCBXTMPV  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Baixa de titulos MOIP Market Place 			 				บฑฑ
ฑฑบ          ณ                              									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCBXTMPV()

Local aArea 	:= GetArea()
Local aParam	:= {}

//Perguntas da importa็ใo
If U_NCPBXMP(aParam)
    
	//Valida็ใo dos parametros
	If U_NCVPBXMP(aParam)     
		
		//Processamento da rotina de importa็ใo
		Processa({|| ProcLrArq(aParam[1], aParam[2], aParam[3], aParam[4]) })			
	EndIf

EndIf



RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณProcLrArq  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImporta็ใo do arquivo para baixa de tํtulos MOIP 			บฑฑ
ฑฑบ          ณ (Market Place)                									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ProcLrArq(cArqImport, cBco, cAgencia, cContaBc)

Local aArquivo 	:= {}
Local cLinha   	:= "" 
Local alLinha  	:= {}
Local nX			:= 0
Local nlCont		:= 1
Local aItensBx	:= {}//Itens da baixa
Local cMsgErro	:= ""
Local aErr			:= {}


Default cArqImport 	:= ""                    
Default cBco		:= ""
Default cAgencia	:= "" 
Default cContaBc	:= ""

If !File(cArqImport)
	Aviso("Aten็ใo", "O arquivo informado nใo foi localizado.",{"Ok"},2)
EndIf     

FT_FUse(cArqImport)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo (Cabe็alho)
    If nlCont == 1
    	nlCont++
    	FT_FSkip()
       loop
    EndIf
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	alLinha := {}
	
	cLinha   	:= FT_FReadLn() //Le alinha    
	alLinha	:= Separa(cLinha,";") //Quebra a linha em colunas de acordo com o delimitador ';'
	
	//Verifica se o arquivo esta com a quantidade de colunas correta
	If Len(alLinha) >= 7
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha ) 
	Else
		Aviso("Formado invแlido","Formato do arquivo invแlido, verifique o layout correto",{"Ok"},2)
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 

If Len(aArquivo) > 0
	
	ProcRegua(Len(aArquivo))
	
	For nX := 1 TO Len(aArquivo)
		
		IncProc("Valida็ใo do arquivo...")
			
		cMsgErro	:= ""
		//Valida็ใo do arquivo importado
		If VldImpIt(aArquivo[nX], nX, @cMsgErro)
	
			Aadd(aItensBx, {aArquivo[nX][PREFIXO],;
								 aArquivo[nX][TITULO],;
								 aArquivo[nX][PARCELA],;
								 aArquivo[nX][TIPO],;
								 GetVlFmt(aArquivo[nX][DESCONTO]),;
								 GetVlFmt(aArquivo[nX][VALOR]),;
								 aArquivo[nX][HISTORICO],;
								 "",;
								 "";						 
								 })
		Else
			
			//Preenchimento do log de processamento
			Aadd(aErr, {aArquivo[nX][PREFIXO],;
								 aArquivo[nX][TITULO],;
								 aArquivo[nX][PARCELA],;
								 aArquivo[nX][TIPO],;
								 GetVlFmt(aArquivo[nX][DESCONTO]),;
								 GetVlFmt(aArquivo[nX][VALOR]),;
								 aArquivo[nX][HISTORICO],;
								 "ERRO",;
								 cMsgErro;						 
								 })		
		EndIf		
	Next
	
	
	//Realiza a baixa dos titulos
	If Len(aItensBx) > 0
		ProcRegua(Len(aItensBx))
		
		For nX := 1 To Len(aItensBx)
			
			IncProc("Processando a baixa dos tํtulos...")
			
			cMsgErro	:= ""
			
			//Executa a rotina automatica para realizar a baixa dos titulos
			cMsgErro	:= BxTitMoip(aItensBx[nX][PREFIXO],;
										 aItensBx[nX][TITULO],; 
										 aItensBx[nX][PARCELA],; 
										 aItensBx[nX][TIPO],; 
										 aItensBx[nX][VALOR],; 
										 aItensBx[nX][DESCONTO],; 
										 cBco,; 
										 cAgencia,; 
										 cContaBc,; 
										 aItensBx[nX][HISTORICO])
			

				
			
			//Verifica se houve erro para preencher o log de baixa
			If Empty(cMsgErro)
			
				//Preenchimento do log de processamento
				Aadd(aErr, {aItensBx[nX][PREFIXO],;
								 aItensBx[nX][TITULO],;
								 aItensBx[nX][PARCELA],;
								 aItensBx[nX][TIPO],;
								 aItensBx[nX][DESCONTO],;
								 aItensBx[nX][VALOR],;
								 aItensBx[nX][HISTORICO],;
								 "BAIXADO",;
								 cMsgErro;						 
								 })
			Else
				//Preenchimento do log de processamento
				Aadd(aErr, {aItensBx[nX][PREFIXO],;
								 aItensBx[nX][TITULO],;
								 aItensBx[nX][PARCELA],;
								 aItensBx[nX][TIPO],;
								 aItensBx[nX][DESCONTO],;
								 aItensBx[nX][VALOR],;
								 aItensBx[nX][HISTORICO],;
								 "ERRO",;
								 cMsgErro;						 
								 })					
			EndIf
		Next
						
	EndIf
	
	
	If Aviso("Aten็ใo", "Deseja visualizar o log de processamento ? ", {"Sim","Nใo"}, 2) == 1
	
		//Log de processamento
   		GerLogProc(aErr)
	EndIf
	
EndIf

Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldImpIt  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo do arquivo importado						 			บฑฑ
ฑฑบ          ณ				                									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldImpIt(aArqImp, nLin, cMsgErro)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux	:= ""

Default aArqImp	:= {} 
Default nLin		:= 0
     

//Verifica se o titulo existe
DbSelectArea("SE1")
DbSetOrder(1)
If SE1->(MsSeek(xFilial("SE1");
		+ PADR(aArqImp[PREFIXO]	,TAMSX3("E1_PREFIXO")[1]);
		+ PADR(aArqImp[TITULO]	,TAMSX3("E1_NUM")[1]);
		+ PADR(aArqImp[PARCELA]	,TAMSX3("E1_PARCELA")[1]);
		+ PADR(aArqImp[TIPO]		,TAMSX3("E1_TIPO")[1]);
		))

	If SE1->E1_SALDO == 0 .And. !Empty(SE1->E1_BAIXA)
		cMsgAux	:= "Tํtulo baixado anteriormente (Dt.Baixa: "+DTOC(SE1->E1_BAIXA)+";"+CRLF
		lRet 		:= .F.
	EndIf
Else
	cMsgAux	:= "Titulo nao Encontrado;"+CRLF
	lRet 		:= .F.
EndIf        

If GetVlFmt(aArqImp[VALOR]) == 0
	cMsgAux	:= "Valor invalido;"+CRLF
	lRet 		:= .F.
EndIf

If !lRet
	cMsgErro := cMsgAux 
EndIf

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBxTitMoip  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBaixa de titulos MOIP								 			บฑฑ
ฑฑบ          ณ				                									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BxTitMoip(cPrefixo, cNumTit, cParcela, cTipo, nValor, nDescont, cBco, cAgencia, cContaBc, cHist)

Local aArea 	:= GetArea()
Local aTitulo := {}
Local cRet		:= ""

Default cPrefixo	:= "" 
Default cNumTit	:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default nValor	:= 0 
Default nDescont	:= 0
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""
Default cHist		:= ""

AADD(aTitulo,	{"E1_PREFIXO"		, PADR(cPrefixo	,TAMSX3("E1_PREFIXO")[1])		,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	, PADR(cNumTit	,TAMSX3("E1_NUM")[1])   			,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	, PADR(cParcela	,TAMSX3("E1_PARCELA")[1])   	,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	, PADR(cTipo		,TAMSX3("E1_TIPO")[1])     		,Nil } )
AADD(aTitulo,	{"AUTMOTBX"	    ,"NOR"           									,Nil } )
AADD(aTitulo,	{"AUTBANCO"		,PADR(Alltrim(cBco)		, TAMSX3("E8_BANCO")[1]) 	,Nil } )
AADD(aTitulo,	{"AUTAGENCIA"		,PADR(Alltrim(cAgencia)	, TAMSX3("E8_AGENCIA")[1])	,Nil } )
AADD(aTitulo,	{"AUTCONTA"		,PADR(Alltrim(cContaBc)	, TAMSX3("E8_CONTA")[1])		,Nil } )
AADD(aTitulo,	{"AUTDTBAIXA"	 	,dDataBase       	,Nil } )
AADD(aTitulo,	{"AUTHIST"	    	,cHist				,Nil })
AADD(aTitulo,	{"AUTDESCONT"		,nDescont			,Nil } )
AADD(aTitulo,	{"AUTVALREC"	 	,nValor-nDescont	,Nil } )

//Chama a rotina para efetuar a baixa do titulo 
cRet := RunBxTitM(aTitulo, 3 )

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunBxTitM  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta a rotina automatica para realizar a baixa do titulo	บฑฑ
ฑฑบ          ณ				                									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunBxTitM(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Baixa

Begin Transaction
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MSExecAuto({|x,y| FINA070(x,y)},aTitulo,nOpc)
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Os dados informados estใo incorretos. Verifique o preenchimento do mesmo."
EndIf

End Transaction

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetVlFmt  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConverte o valor para numerico									บฑฑ
ฑฑบ          ณ				                									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetVlFmt(cVlPlanil)

Local nRet		:= 0 
Local cVlAux    := ""

Default cVlPlanil := ""                         


cVlAux	:= Strtran( cVlPlanil, "R$", "" )
cVlAux	:= Strtran( cVlAux, "-", "" )
cVlAux	:= Strtran( cVlAux, ".", "" )
cVlAux	:= Strtran( cVlAux , ",", "." )

If !Empty(cVlAux)
	nRet := Val(cVlAux)
Else
	nRet := 0
EndIf     

Return nRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerLogProc  บAutor  ณMicrosiga		    บ Data ณ  06/16/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera log de processamento										บฑฑ
ฑฑบ          ณ				                									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerLogProc(aArqProc)

Local aArea 	:= GetArea()
Local nX		:= 0
Local apExcel	:= {}  
Local cNameArq	:= "LogBxMoip_"+ DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"

Default aArqProc := {}

//Cabe็alho
WrTXMLArq(1, @apExcel, Len(aArqProc)+1)//+1 para considerar o cabe็alho

ProcRegua(Len(aArqProc))
For nX := 1 To Len(aArqProc)
    
   IncProc("Processando o log...")
	
	WrTXMLArq(2,;								//Op็ใo para preenchimento dos itens 
				@apExcel,; 					//Dados da planilha
				Len(aArqProc)+1,;				//Qtd.Linha
				aArqProc[nX][PREFIXO],; 		//Prefixo
				aArqProc[nX][TITULO],; 		//Titulo
				aArqProc[nX][PARCELA],; 		//Parcela
				aArqProc[nX][TIPO],; 		//Tipo
				aArqProc[nX][DESCONTO],;		//Valor de desconto 
				aArqProc[nX][VALOR],;		//Valor 
				aArqProc[nX][HISTORICO],;	//Historico 
				aArqProc[nX][STATUS],;		//Status 
				aArqProc[nX][OBSERVACAO] )	//Observa็ใo

Next

WrTXMLArq(3, @apExcel, Len(aArqProc))//Rodap้

//Chama a rotina para gerar a planilha do Excel
GeraExcel(apExcel, cNameArq)

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWrTXMLArq  บAutor  ณMicrosiga         บ Data ณ  01/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os dados do XML a ser gravado no relat๓rio do Excelบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                  	      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
Static Function WrTXMLArq(nOpc, apExcel, nQtdReg, cPrefixo, cTitulo, cParcela, cTipo, nDescont, nValor, cHist, cStatus, cObs )
								

Default nOpc		:= 0 
Default apExcel	:= {} 
Default nQtdReg	:= 0 
Default cPrefixo	:= "" 
Default cTitulo	:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default nDescont	:= 0 
Default nValor	:= 0 
Default cHist		:= "" 
Default cStatus	:= "" 
Default cObs		:= ""

If nOpc == 1//Cabe็alho

	Aadd(apExcel, '  <?xml version="1.0"?>'+CRLF)
	Aadd(apExcel, '  <?mso-application progid="Excel.Sheet"?>'+CRLF)
	Aadd(apExcel, '  <Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, '   xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF)
	Aadd(apExcel, '   xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF)
	Aadd(apExcel, '   xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, '   xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF)
	Aadd(apExcel, '   <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '    <Author>Elton Santana</Author>'+CRLF)
	Aadd(apExcel, '    <LastAuthor>Elton Santana</LastAuthor>'+CRLF)
	Aadd(apExcel, '    <Created>2016-04-25T13:32:46Z</Created>'+CRLF)
	Aadd(apExcel, '    <LastSaved>2016-04-25T17:17:36Z</LastSaved>'+CRLF)
	Aadd(apExcel, '    <Version>15.00</Version>'+CRLF)
	Aadd(apExcel, '   </DocumentProperties>'+CRLF)
	Aadd(apExcel, '   <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '    <AllowPNG/>'+CRLF)
	Aadd(apExcel, '   </OfficeDocumentSettings>'+CRLF)
	Aadd(apExcel, '   <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '    <WindowHeight>3255</WindowHeight>'+CRLF)
	Aadd(apExcel, '    <WindowWidth>20085</WindowWidth>'+CRLF)
	Aadd(apExcel, '    <WindowTopX>0</WindowTopX>'+CRLF)
	Aadd(apExcel, '    <WindowTopY>0</WindowTopY>'+CRLF)
	Aadd(apExcel, '    <ProtectStructure>False</ProtectStructure>'+CRLF)
	Aadd(apExcel, '    <ProtectWindows>False</ProtectWindows>'+CRLF)
	Aadd(apExcel, '   </ExcelWorkbook>'+CRLF)
	Aadd(apExcel, '   <Styles>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="Default" ss:Name="Normal">'+CRLF)
	Aadd(apExcel, '     <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '     <Borders/>'+CRLF)
	Aadd(apExcel, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '     <Interior/>'+CRLF)
	Aadd(apExcel, '     <NumberFormat/>'+CRLF)
	Aadd(apExcel, '     <Protection/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s16" ss:Name="Vํrgula">'+CRLF)
	Aadd(apExcel, '     <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s17">'+CRLF)
	Aadd(apExcel, '     <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s18" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s19" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s20" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '     <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '     <Font ss:FontName="Courier New" x:Family="Modern" ss:Size="8"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s21">'+CRLF)
	Aadd(apExcel, '     <NumberFormat/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s77">'+CRLF)
	Aadd(apExcel, '     <Interior ss:Color="#AEAAAA" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s78">'+CRLF)
	Aadd(apExcel, '     <Interior ss:Color="#AEAAAA" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '     <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s79" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '     <Interior ss:Color="#AEAAAA" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s80" ss:Parent="s16">'+CRLF)
	Aadd(apExcel, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11"/>'+CRLF)
	Aadd(apExcel, '     <Interior ss:Color="#AEAAAA" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '    <Style ss:ID="s81">'+CRLF)
	Aadd(apExcel, '     <Interior ss:Color="#AEAAAA" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '     <NumberFormat/>'+CRLF)
	Aadd(apExcel, '    </Style>'+CRLF)
	Aadd(apExcel, '   </Styles>'+CRLF)
	Aadd(apExcel, '   <Worksheet ss:Name="Plan1">'+CRLF)
	Aadd(apExcel, '    <Table ss:ExpandedColumnCount="9" ss:ExpandedRowCount="'+Alltrim(Str(nQtdReg))+'" x:FullColumns="1"'+CRLF)
	Aadd(apExcel, '     x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF)
	Aadd(apExcel, '     <Column ss:Index="2" ss:StyleID="s17" ss:Width="52.5"/>'+CRLF)
	Aadd(apExcel, '     <Column ss:StyleID="s17" ss:AutoFitWidth="0" ss:Span="1"/>'+CRLF)
	Aadd(apExcel, '     <Column ss:Index="5" ss:StyleID="s18" ss:Width="56.25"/>'+CRLF)
	Aadd(apExcel, '     <Column ss:StyleID="s19" ss:Width="57.75"/>'+CRLF)
	Aadd(apExcel, '     <Column ss:StyleID="s21" ss:AutoFitWidth="0" ss:Width="369.75"/>'+CRLF)
	Aadd(apExcel, '     <Column ss:AutoFitWidth="0" ss:Width="62.25"/>'+CRLF)
	Aadd(apExcel, '     <Column ss:AutoFitWidth="0" ss:Width="339"/>'+CRLF)
	Aadd(apExcel, '     <Row>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s77"><Data ss:Type="String">Prefixo </Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s78"><Data ss:Type="String">Titulo</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s78"><Data ss:Type="String">Parcela</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s78"><Data ss:Type="String">Tipo</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s79"><Data ss:Type="String">Desconto</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s80"><Data ss:Type="String">Valor</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s81"><Data ss:Type="String">Historico</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s77"><Data ss:Type="String">Status</Data></Cell>'+CRLF)
	Aadd(apExcel, '      <Cell ss:StyleID="s77"><Data ss:Type="String">Obs.</Data></Cell>'+CRLF)
	Aadd(apExcel, '     </Row>'+CRLF)
	
ElseIf nOpc == 2//Conteudo

	Aadd(apExcel, '   <Row>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+cPrefixo+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+cTitulo+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+cParcela+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+cTipo+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="Number">'+Alltrim(Str(nDescont))+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s20"><Data ss:Type="Number">'+Alltrim(Str(nValor))+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:Formula="=&quot;Teste &quot;&amp;RC[-5]"><Data ss:Type="String">'+cHist+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+cStatus+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell><Data ss:Type="String">'+cObs+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)	

ElseIf nOpc == 3//Rodap้

	Aadd(apExcel, '  </Table>'+CRLF)
	Aadd(apExcel, '<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '   <PageSetup>'+CRLF)
	Aadd(apExcel, '    <Header x:Margin="0.31496062000000002"/>'+CRLF)
	Aadd(apExcel, '    <Footer x:Margin="0.31496062000000002"/>'+CRLF)
	Aadd(apExcel, '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF)
	Aadd(apExcel, '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF)
	Aadd(apExcel, '   </PageSetup>'+CRLF)
	Aadd(apExcel, '   <Selected/>'+CRLF)
	Aadd(apExcel, '   <Panes>'+CRLF)
	Aadd(apExcel, '    <Pane>'+CRLF)
	Aadd(apExcel, '     <Number>3</Number>'+CRLF)
	Aadd(apExcel, '     <ActiveRow>2</ActiveRow>'+CRLF)
	Aadd(apExcel, '    </Pane>'+CRLF)
	Aadd(apExcel, '   </Panes>'+CRLF)
	Aadd(apExcel, '   <ProtectObjects>False</ProtectObjects>'+CRLF)
	Aadd(apExcel, '   <ProtectScenarios>False</ProtectScenarios>'+CRLF)
	Aadd(apExcel, '  </WorksheetOptions>'+CRLF)
	Aadd(apExcel, ' </Worksheet>'+CRLF)
	Aadd(apExcel, '</Workbook>'+CRLF)
	
EndIf

Return 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGeraExcel บAutor  ณMicrosiga		    บ Data ณ  11/07/2011 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que cria e escreve o arquivo excel.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraExcel(aPlanilha, cNameArq)
	
Local nlHandle
Local clLocal 	:= ""
Local olExcelApp
Local aPerg		:= {}
Local lRet		:= .T.

Default aPlanilha	:= {}               
Default cNameArq	:= ""

aPerg	:= PergFileEx()//Pergunta com o endere็o do arquivo

If Len(aPerg[2] ) > 0
	If !aPerg[1]
		Return
	EndIf
Else
	return
EndIf
clDir := Alltrim(aPerg[2][1])
clLocal := clDir + cNameArq

nlHandle  := FCREATE(clLocal)

If nlHandle == -1
	Aviso("Aten็ใo","Nใo foi possํvel criar o arquivo em: " + CRLF + clLocal,{"Ok"},2)
Else
	AEVAL(aPlanilha, {|x| FWRITE(nlHandle, x)} )
	FCLOSE(nlHandle)
	
	If File(clLocal)
		
		If Aviso("OPENARQ","Deseja abrir o arquivo gerado no Excel ?",{"Sim","Nใo"},2) == 1
			olExcelApp	:= MsExcel():New()
			olExcelApp:WorkBooks:Open(clLocal)
			olExcelApp:SetVisible(.T.)
			olExcelApp:Destroy()
		EndIf
	Else
		Aviso("Aten็ใo","Erro ao criar o arquivo em: " +CRLF+ clLocal,{"Ok"},2)
	Endif
endif

Return lRet     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFile	บAutor  ณMicrosiga			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta com o endere็o do arquivo					          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFileEx()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local aParamBox	:= {} 
Local lRet			:= .F.
Local alRet			:= {}		

aAdd( aParamBox ,{6,"Endere็o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {lRet, alRetPath}

RestArea(aArea)
Return alRet  



