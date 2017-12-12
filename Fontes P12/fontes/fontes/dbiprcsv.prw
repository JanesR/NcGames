#Include "Protheus.ch"



User Function DBIPRCSV()
Private nOpc := 0
Private cCadastro := "Ler arquivo csv"
Private aSay := {}
Private aButton := {}

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
//Local clSeque	:= "00000001"


DbSelectArea("SUS")
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
		
		cUSCOD		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusLOJA		:= substr(cBuffer,1,At(";",cBuffer)-1)
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusNOME		:= substr(cBuffer,1,At(";",cBuffer)-1) 
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusNREDUZ	:= substr(cBuffer,1,At(";",cBuffer)-1)    
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusTIPO		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusEND		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusMUN		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusBAIRRO	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusCEP 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusEST 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusDDI 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusDDD 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusTEL 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusFAX 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusEMAIL	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusVEND		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusCGC 		:= substr(cBuffer,1,At(";",cBuffer)-1)               
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusSATIV	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusSTATUS	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusINSCR	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusTPESSOA	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))
		cusCODCLI	:= substr(cBuffer,1,At(";",cBuffer)-1)             //Lucas - NCgames
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))	//Lucas - NCgames
		cusLOJCLI	:= substr(cBuffer,1,At(";",cBuffer)-1)				//Lucas - NCgames
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer))	//Lucas - NCgames
		cusCONTRIB	:= substr(cBuffer,1,At(";",cBuffer)-1)           
		cBuffer		:= substr(cBuffer,At(";",cBuffer)+1,Len(cBuffer)) 
		If "," $ cBuffer
			nusLC := Val(Stuff(cBuffer, At(",",cBuffer), 1, ".")) 
		Else
			nusLC := Val(cBuffer)
		EndIf
			
		If RecLock("SUS",.T.) 
			
			US_FILIAL 	:= xFilial("SUS")    
			US_COD 		:=	cUSCOD
			US_LOJA		:=	cusLOJA 
			US_NOME		:=	cusNOME
			US_NREDUZ	:=	cusNREDUZ
			US_TIPO		:=	cusTIPO
			US_END 		:=	cusEND
			US_MUN 		:=	cusMUN
			US_BAIRRO	:=	cusBAIRRO
			US_CEP 		:=	cusCEP
			US_EST 		:=	cusEST
			US_DDI 		:=	cusDDI
			US_DDD 		:=	cusDDD
			US_TEL 		:=	cusTEL
			US_FAX		:=	cusFAX
			US_EMAIL	:=	cusEMAIL
			US_VEND		:=	cusVEND
			US_CGC 		:=	cusCGC
			US_SATIV	:=	cusSATIV
			US_STATUS	:=	cusSTATUS
			US_INSCR	:=	cusINSCR
			US_TPESSOA	:=	cusTPESSOA
			US_CODCLI 	:=	cusCODCLI	   		//Lucas - NCgames
			US_LOJACLI 	:= 	cusLOJCLI 		//Lucas - NCgames
			US_CONTRIB	:=	cusCONTRIB
			US_LC  		:=	nusLC 
			US_MOEDALC 	:= 1
			US_RECCOFI 	:= "N" 
			US_RECCSLL 	:= "N" 
			US_RECPIS 	:= "N" 
			SUS->(MsUnLock())	
		ELSE
			CONOUT("DBIprSV - RecLock")
			loop
			
		EndIf
		
		
		FT_FSKIP() //próximo registro no arquivo txt
	Else 
		FT_FSKIP()
		FT_FSKIP()
		llPrimer := .F.
	EndIf
	
EndDo
FT_FUSE() //fecha o arquivo txt
MsgInfo("Processo finalizada")
Return Nil