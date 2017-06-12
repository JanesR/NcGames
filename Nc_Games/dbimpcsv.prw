#Include "Protheus.ch"



User Function DBIMPCSV(cliniseq)
Private nOpc := 0
Private cCadastro := "Ler arquivo csv"
Private aSay := {}
Private aButton := {}
Private ciniseq	:= cliniseq
AADD( aSay, "O objetivo desta rotina e efetuar a leitura em um arquivo texto" )
AADD( aButton, { 1,.T.,{|| nOpc := 1,FechaBatch()}})
AADD( aButton, { 2,.T.,{|| FechaBatch() }} )
FormBatch( cCadastro, aSay, aButton )
If nOpc == 1
Processa( {|| Import() }, "Processando..." )
Endif
Return Nil

//+-------------------------------------------
//| Função - Import()
//+-------------------------------------------
Static Function Import()
Local cBuffer := ""
Local cFileOpen := ""
Local cTitulo1 := "Selecione o arquivo"
Local cExtens := "Arquivo CSV | *.csv"
Local cMainPath := "C:\" 
Local llPrimer := .T.
Local clSeque	:= "00000001"

clSeque := allTrim(Str(ciniseq)) + clSeque


DbSelectArea("SCT")
DbSetOrder(1)
/***
* _________________________________________________________
* cGetFile(<ExpC1>,<ExpC2>,<ExpN1>,<ExpC3>,<ExpL1>,<ExpN2>)
* ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
* <ExpC1> - Expressão de filtro
* <ExpC2> - Titulo da janela
* <ExpN1> - Numero de mascara default 1 para *.Exe
* <ExpC3> - Diretório inicial se necessário
* <ExpL1> - .F. botão salvar - .T. botão abrir
* <ExpN2> - Mascara de bits para escolher as opções de visualização do objeto
* (prconst.ch)
*/
cFileOpen := cGetFile(cExtens,cTitulo1,,cMainPath,.T.)
If !File(cFileOpen)
	MsgAlert("Arquivo csv: "+cFileOpen+" não localizado",cCadastro)
	Return
Endif
FT_FUSE(cFileOpen) //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER  


While !FT_FEOF() //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	IncProc()
	// Capturar dados
	If !llPrimer
		cBuffer := FT_FREADLN() //LENDO LINHA

		clFilial	:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxTipo		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clproduto	:= substr(cBuffer,1,At(";",cBuffer)-1) 
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cldoc		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clregiao	:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clquarte		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxmes		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clsemana		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxcanal		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxdcanal		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxgrpcl		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxDesGrp		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clQuant		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxprcuni		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxfatur		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		clxconmar		:= cBuffer
	
		
	
		//cMsg := "Filial: " +SubStr(cBuffer,01,02) + Chr(13)+Chr(10)
		//cMsg += "Código: " +SubStr(cBuffer,03,06) + Chr(13)+Chr(10)
		//cMsg +dbmsystem	= "Loja: " +SubStr(cBuffer,09,02) + Chr(13)+Chr(10)
		//cMsg += "Nome fantasia: " +SubStr(cBuffer,11,15) + Chr(13)+Chr(10)
		//cMsg += "Valor: " +SubStr(cBuffer,26,14) + Chr(13)+Chr(10)
		//cMsg += "Data: " +SubStr(cBuffer,40,08) + Chr(13)+Chr(10)
		//MsgInfo(cMsg)
		
		//clSeque := GetSxENum("SCT","CT_SEQUEN")
		//ConfirmSX8()
		
		//cldoc := "FORE2012"  
		clDoc := "BUDG2012" 
		If RecLock("SCT",.T.) 
		
			SCT->CT_FILIAL	:= STRZERO(VAL(clFilial),2)
			SCT->CT_SEQUEN	:= clSeque
			SCT->CT_XTIPO	:= clxTipo
			If Len(AllTrim(clProduto)) <= 11
				SCT->CT_PRODUTO := STRZERO(VAL(clproduto),11)
			Else
				SCT->CT_PRODUTO := clproduto
			EndIf
			SCT->CT_DOC	:= cldoc
			SCT->CT_REGIAO := clregiao
			SCT->CT_XQUARTE := clquarte
			SCT->CT_XMES := PADL(AllTrim(clxmes),2,"0")
			SCT->CT_XSEMANA := clsemana
			SCT->CT_XCANAL	:= 	PADL(AllTrim(clxcanal),6,"0")
			SCT->CT_XDCANAL := clxdcanal
			SCT->CT_XGRPCLI	:= clxgrpcl
			SCT->CT_XDGRPCL	:= clxDesGrp
			If "," $ clQuant
				SCT->CT_QUANT	:= Val(Stuff(clQuant, At(",",clQuant), 1, "."))
			Else
				SCT->CT_QUANT	:= Val(clQuant)
			EndIf
			If "," $ clxprcuni
				SCT->CT_XPRCUNI := Val(Stuff(clxprcuni, At(",",clxprcuni), 1, ".")) 
			Else
				SCT->CT_XPRCUNI := Val(clxprcuni)
			EndIf
			If "," $ clxFatur
				SCT->CT_XFATUR	:= Val(Stuff(clxFatur, At(",",clxfatur), 1, ".")) 
			Else
				SCT->CT_XFATUR	:= Val(clxFatur)
			EndIf
			If "," $ clxconmar
				SCT->CT_XCONMAR	:= Val(Stuff(clxconmar, At(",",clxconmar), 1, "."))
			Else
				SCT->CT_XCONMAR	:= Val(clxconmar)
			EndIf			
			SCT->CT_XDTINI	:= CtoD("01/07/2012")
			SCT->CT_XDTFIM	:= CtoD("31/12/2012")
	
			SCT->(MsUnLock()) 
	
			clSeque := Soma1(clSeque)
		ELSE
			CONOUT("DBIMPCSV - RecLock")
			loop
			
		EndIf
		
		
		FT_FSKIP() //próximo registro no arquivo txt
	Else 
		FT_FSKIP()
		llPrimer := .F.
	EndIf
	
EndDo
FT_FUSE() //fecha o arquivo txt
MsgInfo("Processo finalizada")
Return Nil