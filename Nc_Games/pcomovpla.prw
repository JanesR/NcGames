#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ UPDPLARV	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de importacao de planilha					          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function UPPLAORC()
Local aBotoes	:= {}
Local aSays		:= {}
Local aPergunt	:= {}
Local nOpcao	:= 0   
Local oRegua    := Nil
Local alPerg	:= {}
Local llImp		:= .T.

Private aMsgLog	:= {} 

//Tela de aviso e acesso aos parametros
AAdd(aSays,"[Importa็ใo de planilha or็amentแria]")
AAdd(aSays,"Esse programa efetuara a importa็ใo dos movimentos  ")
AAdd(aSays,"or็amentแrios de acordo com a planilha informada...")


AAdd(aBotoes,{ 5,.T.,{|| alPerg := PergFile() 		}} )
AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )        
FormBatch( "[Importa็ใo de planilha or็amentแria]", aSays, aBotoes )

//Verifica se o parametro com o endere็o do arquivo foi preenchido
If Len(alPerg) > 0

	If alPerg[1]
		If nOpcao == 1
			Processa({ || ImpArqPla(alPerg)} )
			
			If aviso("Imp. Log","Deseja imprimir o log de processamento ?",{"Sim","Nใo"})  == 1
				GetMsgErr(aMsgLog)
			EndIf
		EndIf
	Else
		Aviso("ERR-READFILE","Erro ao ler arquivo...", {"Ok"},2)
	EndIf
	
Else
	Aviso("ERR-NOPARAM","O parโmetro com o nome do arquivo nใo foi preenchido ! ", {"Ok"},2)
EndIf



Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpArqPla บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento da rotina de importacao                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpArqPla(aParam)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local nlCont		:= 1
Local lRetImp		:= .T.
Local clArq 		:= aParam[2][1]
Local aAnoAux		:= {}
Local cAno			:= ""

Private uConteudo := Nil

Aadd(aMsgLog,"--------------------------------------------------------------------------------------------------")
Aadd(aMsgLog,"Iniciando a importa็ใo do arquivo...")

FT_FUse(clArq)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()
Aadd(aMsgLog,"Efetuando a leitura do arquivo...")
While !FT_FEof() 
    
	IncProc("Efetuando a leitura do arquivo...")
    
    //Pula a primeira linha do arquivo
    If nlCont == 1
    	nlCont++ 
		
		//Le alinha    
		cLinha   	:= FT_FReadLn() 
		    	
    	//Linha com o cabe็alho
    	aAnoAux := Separa(cLinha,";")
    	
    	//Verifica se existe a coluna com o m๊s e ano
    	If Len(aAnoAux) >= 15
    		cAno	:= aAnoAux[15]
    		aAnoAux := Separa(cAno,"/")
    		
    		//Verifica se encontrou o formado correto do ano  Exemplo 01/2013
    		If Len(aAnoAux) >= 2
    			cAno 	:= aAnoAux[2]//Preenchimento do ano
    		Endif
    	EndIF
    	
    	FT_FSkip()
       loop
    EndIf
    
    ++nlCont
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	alLinha := {}
	
	cLinha   	:= FT_FReadLn() //Le alinha    
	alLinha		:= Separa(cLinha,";") //Quebra a linha em colunas de acordo com o delimitador ';'
	
	//Verifica se o arquivo esta com a quantidade de colunas correta
	If Len(alLinha) >= 11
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha )
	
	Else            
	
	   	Aadd(aMsgLog,"Erro com o layout da linha:  "+Alltrim(Str(nlCont)))
		Aviso("ERROLAYOUT","Formato de arquivo inesperado, verifique se o layout estแ correto",{"Ok"},2)
		lRetImp := .F.
		
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 


If Len(aArquivo) > 0 

	//Efetua aimporta็ใo do arquivo de acordo com a empresa e filial preenchida
	lRetImp := ImpPlaEF(aArquivo, cAno)	

Else
	
	Aviso("ARQVAZIO", "Nใo existe dados a serem importados", {"Ok"},2)
	lRetImp := .F.
EndIf

Return lRetImp


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpPlaEF	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEfetua a importa็ใo da planilha de acordo com a empresa e   บฑฑ
ฑฑบ          ณfilial                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function ImpPlaEF(aArquivo, cAno)

Local aArea 	:= GetArea()
Local nX		:= 1

Default aArquivo	:= {}     
Default cAno		:= ""


Aadd(aMsgLog," - Inicio do processo de importa็ใo da planilha or็amentแria")

ProcRegua(Len(aArquivo))
For nX := 1 To Len(aArquivo)
	IncProc("Importando dados..." )
	   
	ImpPla(aArquivo[nX], cAno, nX) 
Next

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpPla	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Importa็ใo da planilha			          				  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpPla(aImpArq, cAno, nLinha)

Local aPlImp   	:= {}
Local cLinha	:= ""
Local nValAux	:= 0
Local cValAux	:= ""
Local nX		:= 0
Local aArea 	:= GetArea()
Local dPerMov	:= CTOD('')

Default aImpArq	:= {} 
Default cAno	:= ""

//Verifica se o arquivo esta vazio
If Len(aImpArq) < 0
	Return
Else
	aPlImp   	:= aImpArq
EndIf

Aadd(aMsgLog," - Validando movimento (Linha: "+Alltrim(Str(nLinha))+")...")

If VldLinArq(aPlImp, cLinha)

	Aadd(aMsgLog,"------------------------------------------Linha: "+Alltrim(Str(nLinha))+"------------------------------------------")
	Aadd(aMsgLog," - Gerando movimento...")
	Aadd(aMsgLog," Planilha: "+aPlImp[3])
	Aadd(aMsgLog," Conta Orc. :"+aPlImp[7])
	Aadd(aMsgLog," Centro de Custo: "+aPlImp[11])
	Aadd(aMsgLog," Classe: "+aPlImp[8])


	//Faz a grava็ใo por periodo
	For nX	:= 1 To 12
		
		
		//Valor referente o periodo
		cValAux := ""
		nValAux := 0
		cValAux := STRTRAN(aPlImp[14 + nX], ".", "")
		cValAux := STRTRAN(cValAux, ",", ".")
		nValAux := Val(cValAux)
		                     
		//Preenchimento do periodo
		dPerMov	:= CTOD('')
		dPerMov := GetDtPer(nX,cAno)
		
		If nValAux > 0
	
			Aadd(aMsgLog," - Processando perํodo: "+dtoc(dPerMov))
			BEGIN TRANSACTION
	
				 //GerMovAkd(cTipo   , cPlanilha, dPeriodo, cContaOrc,cCusto, cVerba, cHistorico, nValor, cTipoOper, cTpSald, cClVlr, cVersaoPla)			
			If u_GerMovAkd(aPlImp[28], aPlImp[3], dPerMov, aPlImp[7],STRTRAN(aPlImp[11], ".", ""),;
				aPlImp[8], aPlImp[13]/*Verificar*/, nValAux,,aPlImp[5], aPlImp[6],  aPlImp[4])
				
				Aadd(aMsgLog," Sucesso na importa็ใo do movimento...")
			Else                                                      
				Aadd(aMsgLog," Erro na importa็ใo do mivimento...")

				DisarmTransaction()
			EndIf
			END TRANSACTION   		
	
		Else
			Aadd(aMsgLog," - O item esta com o valor zero e nใo serแ processado...Periodo: "+dtoc(dPerMov))
		EndIf
	Next
	
EndIf


RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑษออออออออออัออออออออออออหอออออออัอออออออออออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDtPer  บ Autor ณ Elton C.						บ Data ณ  26/02/13   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯอออออออออออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ retornar a data de acordo com o periodo 						         บฑฑ
ฑฑบ          ณ                                                                       บฑฑ      
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/    
Static Function GetDtPer(nPer,cAno)
Local dRet	:= CTOD('')

Default cAno := ""

If nPer == 1
	dRet := CTOD('01/01/'+cAno)
ElseIf nPer == 2
	dRet := CTOD('01/02/'+cAno)
ElseIf nPer == 3
	dRet := CTOD('01/03/'+cAno)
ElseIf nPer == 4
	dRet := CTOD('01/04/'+cAno)
ElseIf nPer == 5
	dRet := CTOD('01/05/'+cAno)
ElseIf nPer == 6
	dRet := CTOD('01/06/'+cAno)
ElseIf nPer == 7
	dRet := CTOD('01/07/'+cAno)
ElseIf nPer == 8
	dRet := CTOD('01/08/'+cAno)
ElseIf nPer == 9
	dRet := CTOD('01/09/'+cAno)
ElseIf nPer == 10
	dRet := CTOD('01/10/'+cAno)
ElseIf nPer == 11
	dRet := CTOD('01/11/'+cAno)
ElseIf nPer == 12
	dRet := CTOD('01/12/'+cAno)
EndIf


Return dRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    |GerMovAkd บAutor  ณElton C.            บ Data ณ 10/04/12	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera os movimentos sem revisใo  							  บฑฑ
ฑฑบ          ณ															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GerMovAkd(cTipo, cPlanilha, dPeriodo, cContaOrc,cCusto, cVerba, cHistorico, nValor, cTipoOper, cTpSald, cClVlr, cVersaoPla)

Local aArea := GetArea()           

Local lRet			:= .T.
Local cNumLote 		:= ""
Local cNumId		:= ""
Local cAkdProces	:= ""
Local cAkdItem		:= ""
Local cUserAkd		:= ""                                              
Local cAkdCodSup 	:= ""
Local cChaveAkd 	:= ""
Local cTipoAux		:= ""

Default cPlanilha	:= ""
Default dPeriodo	:= CTOD('') 
Default cContaOrc	:= ""
Default cCusto		:= ""
Default cVerba		:= ""
Default cHistorico	:= ""
Default nValor		:= 0
Default cTipoOper	:= ""
Default cTipo		:= ""
Default cTpSald		:= ""
Default cClVlr		:= ""
Default cVersaoPla	:= ""

//Preenchimento dos parametrso obrigatorios
cNumLote 	:= GetSX8Num("AKD","AKD_LOTE")//Retorna a sequencia do lote
cNumId	    := GetIdAkd(cPlanilha)//Retorna o proximo id da planilha
cAkdProces	:= Replicate( "0", Len(AKD->AKD_PROCES) )
cAkdItem	:= StrZero( 2 , 1 )
cUserAkd	:= ""                                              
cTipoAux	:= Iif(Alltrim(cTipo) == 'C', '1', '2') 	

Aadd(aMsgLog," Numero do lote: "+cNumLote)
Aadd(aMsgLog," Id Planilha: "+cNumId)

DBSelectArea("AK5")
AK5->(DBSetOrder(1))
If AK5->(DBSeek(xFilial("AK5") + PADR(cContaOrc, TAMSX3("AK5_CODIGO")[1] ) ))
	cAkdCodSup := AK5->AK5_COSUP
Else
	cAkdCodSup := CriaVar("AK5_COSUP",.F.)
EndIf 

cChaveAkd := "AK2 "+dtos(dPeriodo) + cPlanilha + cContaOrc + cCusto + cTipoOper

lRet := GeraAKD("1"	,cNumLote,cNumId,dPeriodo/*MsDate()*/,cContaOrc	,;
				cVerba,cTpSald ,cTipoAux ,cHistorico	,nValor, cAkdProces	,;
				cAkdItem,cUserAkd,cAkdCodSup,cPlanilha,cCusto,cTipoOper,;
				cChaveAkd, cClVlr, cVersaoPla )
If lRet
	ConfirmSX8()
	
EndIf
RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGeraAKD   บAutor  ณElton C.            บ Data ณ 10/04/12	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera movimento na tabela AKD.  							  บฑฑ
ฑฑบ          ณ															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GeraAKD(cAKDSTATUS	,cAKDLOTE	,cAKDID		,dAKDDATA	,cAKDCO		,;
						 cAKDCLASSE	,cAKDTPSALD	,cAKDTIPO	,cAKDHIST	,nAKDVALOR1	,cAKDPROCES	,;
						 cAKDITEM	,cAKDUSER	,cAKDCOSUP	,cAKDCODPLA	,cAKDCC		,cAKDTPOPER ,;
						 cAKDCHAVE, cAKDCLVR, cAKDVERSAO	)

Local aArea := GetArea()
Local lRet := .T.

DBSelectArea("AKD")
DbSetOrder(1)
If  AKD->(RecLock("AKD",.T.))
	AKD->AKD_FILIAL := xFilial("AKD")
	AKD->AKD_STATUS := cAKDSTATUS
	AKD->AKD_LOTE   := cAKDLOTE
	AKD->AKD_ID  	:= cAKDID
	AKD->AKD_DATA  	:= dAKDDATA
	AKD->AKD_CO    	:= cAKDCO
	AKD->AKD_CLASSE := cAKDCLASSE
	AKD->AKD_TPSALD := cAKDTPSALD
	AKD->AKD_TIPO  	:= cAKDTIPO
	AKD->AKD_OPER	:= cAKDTPOPER
	AKD->AKD_HIST   := cAKDHIST
	
	nAKDVALOR1 		:= PCOPlanCel(nAKDVALOR1,AKD->AKD_CLASSE)
	AKD->AKD_VALOR1	:= PcoPlanVal(nAKDVALOR1,AKD->AKD_CLASSE)
	
	AKD->AKD_PROCES := cAKDPROCES
	AKD->AKD_CHAVE  := cAKDCHAVE
  	AKD->AKD_ITEM  	:= cAKDITEM
	AKD->AKD_USER  	:= cAKDUSER
	AKD->AKD_COSUP 	:= cAKDCOSUP
	AKD->AKD_CODPLA := cAKDCODPLA
	AKD->AKD_CC   	:= cAKDCC
	AKD->AKD_CLVLR	:= cAKDCLVR
	AKD->AKD_VERSAO	:= cAKDVERSAO
	AKD->(MsUnLock())
Else
	lRet := .F.
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Realiza a atualizacao de Saldos.										 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PcoAtuSld(If(AKD->AKD_TIPO=="1","C","D"),"AKD",{AKD->AKD_VALOR1,AKD->AKD_VALOR2,AKD->AKD_VALOR3,AKD->AKD_VALOR4,AKD->AKD_VALOR5},AKD->AKD_DATA)

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณGetIdAkd  บAutor  ณElton C.            บ Data ณ 10/04/12	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o proximo ID da planilha 							  บฑฑ
ฑฑบ          ณ															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetIdAkd(cPlanilha)

Local aArea := GetArea()
Local cQuery		:= ""
Local cArq			:= ""      
Local cRet			:= ""

Default cPlanilha := ""


cArq := GetNextAlias()


cQuery := "SELECT MAX(AKD_ID) ID FROM "+RetSqlName("AKD")+" AKD "+CRLF
cQuery += " WHERE AKD.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND AKD.AKD_FILIAL = '"+xFilial("AKD")+"' "+CRLF
cQuery += " AND AKD.AKD_CODPLA = '"+cPlanilha+"' "+CRLF

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArq,.T.,.F.)


(cArq)->(DbGoTop())

If (cArq)->(!EOF())
	cRet := soma1( (cArq)->ID )
EndIf

If ( Select ( cArq ) <> 0 )
	dbSelectArea ( cArq)
	(cArq)->(dbCloseArea())
Endif                                                                                       

RestArea(aArea)
Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldLinArq	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEfetua a valida็ใo da linha do arquivo			          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldLinArq(alArq, cLinha)

Local alArea	:= GetArea()
Local lErrAux	:= .T.
Local clMsgAux	:= ""

Default alArq 		:= {}
Default cLinha		:= ""                 

lErrAux		:= .T.
clMsgAux    := ""

//Valida็ใo especica para itens sem revisใo
If Len(alArq) < 11
	

	Aadd(aMsgLog,"- Formato da linha incorreto ")
	lErrAux	:= .F.
	return
EndIf

If Empty(alArq[28])

	Aadd(aMsgLog,"- O tipo do movimento nใo foi preenchida ")
	lErrAux	:= .F.
ElseIf !(Alltrim(alArq[28]) $ "C|D|E")

	Aadd(aMsgLog,"- O tipo do movimento ้ diferente do esperado ")
	lErrAux	:= .F.
EndIf


If Empty(alArq[3]) .Or. Empty(alArq[4])
	Aadd(aMsgLog,"- C๓digo da planilha\versใo nใo preenchido ")	
	lErrAux	:= .F.
Elseif !Vldplanilha(alArq[3], alArq[4])
	Aadd(aMsgLog,"- C๓digo da planilha\versใo incorreto ")		
	lErrAux	:= .F.
EndIf

If Empty(alArq[5])

	Aadd(aMsgLog,"- Tipo de saldo incorreto ")					
	lErrAux	:= .F.
ElseIf !VldTpSald(alArq[5])

	Aadd(aMsgLog,"- ")						
	lErrAux	:= .F.
EndIf



If Empty(alArq[7])

	Aadd(aMsgLog,"- C๓digo da conta or็amentแria nใo preenchido")			
	lErrAux	:= .F.
ElseIf !VldCtaOrc(alArq[7])

	Aadd(aMsgLog,"- C๓digo da conta or็amentแria incorreto ")				
	lErrAux	:= .F.
EndIf


If Empty(alArq[8])

	Aadd(aMsgLog,"- C๓digo da classe nใo preenchido ")					
	lErrAux	:= .F.
ElseIf !VldVerba(alArq[8])

	Aadd(aMsgLog,"- C๓digo da classe incorreto")						
	lErrAux	:= .F.
EndIf

If Empty(alArq[11])

	Aadd(aMsgLog,"- C๓digo do centro de custo nใo preenchido")
	lErrAux	:= .F.
ElseIf !VldCCusto(alArq[11])

	Aadd(aMsgLog,"- C๓digo do centro de custo incorreto ")
	lErrAux	:= .F.
EndIf

If lErrAux
	Aadd(aMsgLog,"- Item validado com sucesso... ")	
EndIf

RestArea(alArea)
Return lErrAux


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldTpSald	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo do tipo de saldo						          บฑฑ
ฑฑบ          ณ                                                			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function VldTpSald(cTpSaldo)

Local aArea := GetArea()
Local lRet	:= .F.        

Default cTpSaldo := ""

DbSelectArea("AL2")
DbSetOrder(1)
If AL2->(DbSeek(xFilial("AL2") + cTpSaldo)) 
	lRet := .T.
EndIf

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldChvAK2	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe a chave no cadastro da planilha          บฑฑ
ฑฑบ          ณor็amentแria                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function VldChvAK2(cCodPla, cContaOrc, cCusto, cVerba, cPeriodo)

Local aArea := GetArea()

Local cQuery		:= ""
Local cArq			:= ""      
Local lRet			:= .T.

Default cCodPla 	:= "" 
Default cVersao		:= "" 
Default cContaOrc	:= "" 
Default cCusto		:= "" 
Default cVerba		:= ""
Default cPeriodo	:= ""


//Query utilizada para buscar os dados da AK2 de acordo com a chave unica passada no arquivo
cArq := GetNextAlias()
cQuery := "SELECT COUNT(*) CONTADOR FROM "+RetSqlName("AK2")+" AK2 "+CRLF
cQuery += " WHERE AK2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND AK2.AK2_FILIAL = '"+xFilial("AK2")+"' "+CRLF
cQuery += " AND AK2.AK2_ORCAME = '"+cCodPla+"' "+CRLF
cQuery += " AND AK2.AK2_CO	= '"+cContaOrc+"' "+CRLF
cQuery += " AND AK2.AK2_CC = '"+cCusto+"' "+CRLF
cQuery += " AND AK2.AK2_CLASSE = '"+cVerba+"' "+CRLF
cQuery += " AND AK2.AK2_PERIOD = '"+DTOS(CTOD(cPeriodo))+"' "

//cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArq,.T.,.F.)

(cArq)->(DbGoTop())

//Verifica se a chave existe na AK2
If (cArq)->CONTADOR
	lRet := .T.
EndIf

If ( Select ( cArq ) <> 0 )
	dbSelectArea ( cArq)
	(cArq)->(dbCloseArea())
Endif                                                                                       


RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCCusto   บAutor  ณElton C.		     บ Data ณ 25/05/2010  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o centro de custo existe						  บฑฑ
ฑฑบ          ณ														      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 					                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldCCusto(cCusto)

Local aArea := GetArea()
Local lRet 	:= .F.

Default cCusto := ""

cCusto := STRTRAN(cCusto, ".", "")

DbSelectArea("CTT")
DbSetOrder(1)
If CTT->(DbSeek(xFilial("CTT") + Padr(cCusto, TAMSX3("CTT_CUSTO")[1]) ))
	lRet := .T.	
EndIf

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldVerba    บAutor  ณElton C.		     บ Data ณ 25/05/2010  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se a classe existe								  บฑฑ
ฑฑบ          ณ														      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 					                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldVerba(cVerba)

Local aArea := GetArea()
Local lRet	:= .F.

Default cVerba := ""

DbSelectArea("AK6")
DbSetOrder(1)
If AK6->(DbSeek(xFilial("AK6") + Padr(cVerba,TAMSX3("AK6_CODIGO")[1]) ))
	lRet := .T.
EndIf 


RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCtaOrc   บAutor  ณElton C.		     บ Data ณ 25/05/2010  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se a conta or็amentaria existe					  บฑฑ
ฑฑบ          ณ														      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 					                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldCtaOrc(cContaOrc)

Local aArea := GetArea()
Local lRet	:= .F. 

Default cContaOrc := ""

DbSelectArea("AK5")
DbSetOrder(1)
If AK5->(DbSeek(xFilial("AK5") + Padr(cContaOrc,TAMSX3("AK5_CODIGO")[1]) ))
	lRet := .T.
EndIf

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldplanilha บAutor  ณElton C.		     บ Data ณ 25/05/2010  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se a planilha existe								  บฑฑ
ฑฑบ          ณ														      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 					                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Vldplanilha(cCodPla, cVersao)

Local aArea :=  GetArea()
Local lRet	:= .F.     

Default cCodPla := ""
Default cVersao := ""

DbSelectArea("AK1")
DbSetOrder(1)
If AK1->(	DbSeek(xFilial("AK1") + Padr(cCodPla, TAMSX3("AK1_CODIGO")[1]) + Padr(cVersao, TAMSX3("AK1_VERSAO")[1]) )	)
	 lRet	:= .T.
EndIf

RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFile	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta com o endere็o do arquivo				          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CSV |*.CSV","",GETF_LOCALHARD+GETF_NETWORKDRIVE})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetMsgErr	บAutor  ณElton C.			 บ Data ณ  05/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo utilizada para apresentar as mensagens de log        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetMsgErr(alMsg)

Default alMsg := {}


If !Empty(alMsg)

    //Imprime o relatorio com os erros da importa็ใo
	CtRConOut(alMsg)

EndIf

Return 

