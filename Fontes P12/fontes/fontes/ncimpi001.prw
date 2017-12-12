#Define Enter chr(13)+chr(10)
#include "protheus.ch"
#include "topconn.ch"

User Function NCIMPI001()
Processa({ || I001Txt() } )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIMPI001  ºAutor  ³Microsiga           º Data ³  12/16/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function I001Txt()
Local cArquivo	 :=cGetFile("Arquivo TXT | *.txt","Selecione o arquivo do Price ",,,.T.)
Local cNomeWork  :=""
Local nJobs		 :=0
Local nTotLinha	 :=0
Local nCont		 :=0
Local nNomeArq	 :=SubStr( cArquivo, Rat("\",cArquivo) +1)
Local cStartPath :=Upper(AllTrim(GetSrvProfString("StartPath","")))
Local nLenCod:=AvSx3("B2_COD",3)
Private lCopiaOk:=.F.
Private cSepara:=";"



__PtWaitRun("Copiando Arquivo -"+nNomeArq,"Copia",{ || lCopiaOk:=CpyT2S(cArquivo,cStartPath,.T.) }  )

If !lCopiaOk
	MsgStop("Erro ao copiar o arquivo "+cArquivo+" para o Server!!!")
	Return
Endif
cArquivo:=cStartPath+nNomeArq



If File(cArquivo)
	
	SB2->(DbSetOrder(1))
	
	
	FT_FUSE(cArquivo)  //ABRIR
	FT_FGOTOP() //PONTO NO TOPO
	nTotLinha:=(FT_FLASTREC())
	nRegAtua	:= 0
	ProcRegua(nTotLinha) //QTOS REGISTROS LER
	
	cMensagem:="Linha:"+StrZero(1,5)+" de "+StrZero(nTotLinha,5)
	IncProc(cMensagem)
	
	
	FT_FGOTOP()
	While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
		
		// Capturar dados
		cBuffer := FT_FREADLN() //LENDO 1 LINHA
		cMensagem:="Linha:"+StrZero(++nCont,5)+" de "+StrZero(nTotLinha,5)
		PtInternal(1,cMensagem )
		Conout(cMensagem)
		aDados:=Strtokarr(cBuffer,cSepara)  
		If Type("aDados")=="A" .And. !Empty(aDados[1]) .And. SB2->(DbSeek(xFilial("SB2")+ "0"+aDados[1]  ))     
			SB2->(DbRLock())			 
			cValor:=StrTran(aDados[5],"R$","") 
			cValor:=StrTran(cValor,",","") 
			cValor:=StrTran(cValor,".","") 
			cValor:=AllTrim(cValor)			
			
			SB2->B2_YCMVG:=  Val(cValor)/100
			SB2->(DbrUnLock())			
		EndIf		
		FT_FSKIP()   //próximo registro no arquivo txt
	EndDo
	FT_FUSE() //fecha o arquivo txt
Else
	MsgAlert("Arquivo texto: "+cArquivo+" não localizado")
EndIf




Ferase(cNomeWork)
Ferase(cStartPath+nNomeArq)

Return 