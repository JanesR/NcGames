#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "protheus.ch"


#DEFINE NMARK			1
#DEFINE PREFIXO 		2
#DEFINE CHAVEDM 		3
#DEFINE TIPO			4
#DEFINE NATUREZA		5
#DEFINE FORNECEDOR	6
#DEFINE LOJA 			7
#DEFINE NOME	 		8
#DEFINE EMISSAO 		9
#DEFINE VENCREA 		10
#DEFINE VALOR 		11
#DEFINE CHAVEREG 		12


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPGPE2  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function IMPGPE2()
Local aBotoes		:= {}
Local aSays		:= {}
Local aPergunt	:= {}
Local nOpcao		:= 0   
Local oRegua    	:= Nil
Local alPerg		:= {}
Local llImp		:= .T.

Private alMsgErro	:= {} 


//Tela de aviso e acesso aos parametros
AAdd(aSays,"[Importa็ใo de planilha]")
AAdd(aSays,"Esse programa efetuara a importa็ใo de dados  ")
AAdd(aSays,"referente a integra็ใo com o sistema Datamace")


AAdd(aBotoes,{ 5,.T.,{|| alPerg := PergFile() 		}} )
AAdd(aBotoes,{ 1,.T.,{|| nOpcao := 1, FechaBatch() 	}} )
AAdd(aBotoes,{ 2,.T.,{|| FechaBatch() 				}} )        
FormBatch( "[Importa็ใo]", aSays, aBotoes )

//Verifica se o parametro com o endere็o do arquivo foi preenchido
If Len(alPerg) > 0

	If alPerg[1]
		If nOpcao == 1
			//Processa({|| llImp := ImpArqPla(alPerg) })
			//MsgRun( 'Importando dados...' ,  '', { || ImpArqPla(alPerg)} )
			Processa( {|| ImpArqPla(alPerg) },"","" )
		EndIf
	Else
		MsgAlert("Erro ao ler arquivo...")
	EndIf
Else
	MsgAlert("O parโmetro com o nome do arquivo nใo foi preenchido ! ")
EndIf

Return(Nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPGPE2  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFile()

Local aArea 			:= GetArea()
Local alRetPath  		:= {}
Local alParamBox		:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere็o de arquivo","","","File(&(ReadVar()))","",100,.T.,"Arquivos .CVS |*.CVS","",GETF_LOCALHARD+GETF_NETWORKDRIVE})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere็o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpArqPla บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpArqPla(aParam)

Local aArquivo 		:= {}
Local cLinha   		:= "" 
Local alLinha  		:= {}
Local lRetImp			:= .T.
Local clArq 			:= aParam[2][1]
Local cNomeArq		:= RetFileName( clArq )
Local cTipoProc		:= SubStr(cNomeArq, 1,3)
Local cMes 			:= SubStr(cNomeArq,8,2) 
Local cAno 			:= SubStr(cNomeArq,11,4)

FT_FUse(clArq)
FT_FGoTop()
ProcRegua(FT_FLastRec())
FT_FGoTop()

While !FT_FEof() 
   
	IncProc("Efetuando a leitura do arquivo...")
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	alLinha := {}
	
	cLinha   	:= FT_FReadLn()   
	alLinha		:= Separa(StrTran(cLinha,'"',""),"|") //Quebra a linha em colunas de acordo com o delimitador ';'
	
	//Verifica se o arquivo esta com a quantidade de colunas correta
	If (Len(alLinha) >= 14 .And. Alltrim(cTipoProc) == "GPE") .Or. (Len(alLinha) >= 10 .And. Alltrim(cTipoProc) == "FIN")
	
		//Adiciona a linha ao arquivo
		aAdd(aArquivo,alLinha )
	
	Else
		Aviso("ERROLAYOUT","Formato de arquivo inesperado, verifique se o layout estแ correto",{"Ok"},2)
		lRetImp := .F.
		
		Exit
		Return
	EndIf
	
	FT_FSkip()
EndDo 

If Len(aArquivo) > 0 
	
	If Alltrim(cTipoProc) == "GPE"
		GrvGPE(aArquivo, cMes, cAno)	

	ElseIf Alltrim(cTipoProc) == "FIN"
		GrvFin(aArquivo, cMes, cAno)	
	EndIf

Else
	Aviso("ARQVAZIO", "Nใo existe dados a serem importados", {"Ok"})
	lRetImp := .F.
EndIf

Return lRetImp  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvGPE บAutor  ณMicrosiga           บ Data ณ  05/14/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        	บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvGPE(aArquivo, cMes, cAno)

Local aArea 		:= GetArea()
Local dDtLancto	:= LastDay(STOD(cAno+cMes+"01"))

//Grava os dados na tabela intermediaria
GrvP0D(aArquivo, cMes, cAno)

//Grava os dados na tabela SRZ
GrvSRZ(Alltrim(cMes)+ Alltrim(cAno))

//Grava Lan็amento contabil
GrvLctoCont(dDtLancto)

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvP0D บAutor  ณMicrosiga           บ Data ณ  05/14/15   	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava os dados na tabela intermediaria                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvP0D(aArquivo, cMes, cAno)
Local aArea	:= GetArea()    
Local nX	:= 0

Default aArquivo	:= {} 
Default cMes		:= "" 
Default cAno		:= ""                                            

//Limpa a tabela de resumo da folha
TCSQLExec("TRUNCATE TABLE "+RetSqlName("P0D"))


//Grava os dados na tabela intermediaria
ProcRegua(Len(aArquivo))
For nX := 1 To Len(aArquivo)
	
	IncProc("Gravando tabela intermediaria...")

	dbSelectArea("P0D")
	dbSetOrder(1)
	
				
	RecLock("P0D",.T.)
	P0D->P0D_FILIAL	:= xFilial("P0D")
	P0D->P0D_CC		:= aArquivo[nX][10]
	P0D->P0D_MAT		:= aArquivo[nX][02]
	P0D->P0D_PD		:= Alltrim(STR(Val(aArquivo[nX][03]),TAMSX3("P0D_PD")[1]) )
	P0D->P0D_HRS		:= NCONVVAL(aArquivo[nX][06])
	P0D->P0D_VAL		:= NCONVVAL(aArquivo[nX][07])
	P0D->P0D_TIPO		:= aArquivo[nX][13]
	P0D->P0D_TPC		:= aArquivo[nX][14]
	P0D->P0D_CLVL		:= GetClVlFil(Alltrim(aArquivo[nX][01]))
	P0D->P0D_DTARQ	:= Alltrim(cMes)+ Alltrim(cAno)
	MsUnlock()
	
Next

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvSRZ บAutor  ณMicrosiga           บ Data ณ  05/14/15   	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava os dados na tabela SRZ-		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvSRZ(cMesAno)

Local aArea 		:= GetArea()
Local cArqTmp		:= GetNextAlias()
Local cQuery 		:= ""
Local nCnt			:= 0
Local nContAux	:= 0

Default cMesAno	:= ""
                                  
//Limpa a tabela de resumo da folha
TCSQLExec("TRUNCATE TABLE "+RetSqlName("SRZ"))

cQuery 	:= " SELECT P0D_CC, P0D_CLVL, P0D_PD, P0D_TPC, SUM(P0D_VAL) P0D_VAL FROM "+RetSqlName("P0D")+" P0D "+CRLF
cQuery 	+= "  WHERE P0D.P0D_FILIAL = '"+xFilial("P0D")+"'  "+CRLF
cQuery 	+= "  AND P0D.P0D_DTARQ = '"+cMesAno+"' "
cQuery 	+= "  AND P0D.D_E_L_E_T_ = ' ' "+CRLF
cQuery 	+= "  GROUP BY P0D_CC, P0D_CLVL, P0D_PD, P0D_TPC "+CRLF
cQuery 	+= "  ORDER BY P0D_PD, P0D_CC, P0D_CLVL  "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)	

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )


ProcRegua(nCnt)                    

dbSelectArea("SRZ")
dbSetOrder(1)

While (cArqTmp)->(!Eof())
	
	IncProc("Processando Resumo da Folha...")
	
	++nContAux
	
	RecLock("SRZ",.T.)
	SRZ->RZ_FILIAL	:= (cArqTmp)->P0D_CLVL//xFilial("SRZ") Filial utilizara o mesmo registro da classe de valor.
	SRZ->RZ_MAT 	:= Alltrim(Str(nContAux))
	SRZ->RZ_CC		:= (cArqTmp)->P0D_CC
	SRZ->RZ_PD		:= (cArqTmp)->P0D_PD
	SRZ->RZ_VAL		:= (cArqTmp)->P0D_VAL
	SRZ->RZ_TPC		:= (cArqTmp)->P0D_TPC
	SRZ->RZ_CLVL	:= (cArqTmp)->P0D_CLVL
	MsUnlock()
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvLctoCont บAutor  ณMicrosiga      บ Data ณ  05/14/15   	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava lan็amento contabil				                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvLctoCont(dDtLancto)

Local aArea 		:= GetArea()
Local cArqTmp 	:= GetNextAlias()
Local cQuery 		:= ""
Local aCab 		:= {}
Local aItens  	:= {}
Local aItenAux	:= {}
Local cNumLote	:= Alltrim(U_MyNewSX6("NC_LOTEIDM",;
									"008890",;
									"C",;
									"Lote utilizado na integra็ใo da folha com Datamace",;
									"Lote utilizado na integra็ใo da folha com Datamace",;
									"Lote utilizado na integra็ใo da folha com Datamace",;
									.F. ))
Local cNumSubLot	:= Alltrim(U_MyNewSX6("NC_SUBLIDM",;
									"001",;
									"C",;
									"Sublote utilizado na integra็ใo da folha com Datamace",;
									"Sublote utilizado na integra็ใo da folha com Datamace",;
									"Sublote utilizado na integra็ใo da folha com Datamace",;
									.F. )) 
Local cMoedaMov	:= 	Alltrim(U_MyNewSX6("NC_MOEDIDM",;
									"01",;
									"C",;
									"Moeda utilizado na integra็ใo da folha com Datamace",;
									"Moeda utilizado na integra็ใo da folha com Datamace",;
									"Moeda utilizado na integra็ใo da folha com Datamace",;
									.F. )) 
Local cNumDoc		:= "000001"
Local CTF_LOCK	:= 0
Local nCnt			:= 0
Local cMsgLog		:= ""

cQuery 	:= " SELECT RZ_FILIAL, RZ_CC, RZ_CLVL, RZ_PD, SUM(RZ_VAL) RZ_VAL, RV_LCTOP, SRV.R_E_C_N_O_ RECNOSRV, SRZ.R_E_C_N_O_ RECNOSRZ FROM "+RetSqlName("SRZ")+" SRZ "+CRLF

cQuery 	+= " INNER JOIN "+RetSqlName("SRV")+" SRV "+CRLF
cQuery 	+= " ON SRV.RV_COD = SRZ.RZ_PD "+CRLF
cQuery 	+= " AND SRV.D_E_L_E_T_ = ' ' "+CRLF

//Retirado o filtro de filial (Processamento serแ realizado para todas as filiais)
cQuery 	+= " WHERE SRZ.D_E_L_E_T_ = ' ' "+CRLF
cQuery 	+= " GROUP BY RZ_FILIAL, RZ_CC, RZ_CLVL, RZ_PD, RV_LCTOP, SRV.R_E_C_N_O_, SRZ.R_E_C_N_O_ "+CRLF
cQuery 	+= " ORDER BY RZ_FILIAL, RV_LCTOP, RZ_PD, RZ_CC "+CRLF  

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)                    



DbSelectArea("SRV")
DbSetOrder(1)

DbSelectArea("SRZ")
DbSetOrder(1)

DbSelectArea("CT5")
DbSetOrder(1)

While (cArqTmp)->(!Eof())
	
	IncProc("Contabilizando...")
	
	SRV->(DbGoTo((cArqTmp)->RECNOSRV))
	SRZ->(DbGoTo((cArqTmp)->RECNOSRZ))
	
	
	 
	If CT5->(MsSeek(xFilial("CT5") + (cArqTmp)->RV_LCTOP))
		aCab	:= {}
		aItens	:= {}
		cMsgLog	:= ""
		aItenAux 	:= {}
		nLinMov	:= 0
			
		//Preenchimento do cabe็alho
		Aadd(aCab ,{"dDataLanc"	,dDtLancto		,	Nil})
		Aadd(aCab ,{"cLote"		,cNumLote		,	Nil})
		Aadd(aCab ,{"cSubLote"	,cNumSubLot	,	Nil})
				
		//Verifica o proximo documento
		ProxDoc(dDtLancto, cNumLote, cNumSubLote, @cNumDoc,@CTF_LOCK)
		Aadd(aCab ,{"cDoc"		,cNumDoc,	Nil})
				
				
				
		//Preenchimento dos itens			
		++nLinMov
		Aadd(aItenAux,{"CT2_FILIAL"	,xFilial("CT2")		, NIL})
		Aadd(aItenAux,{"CT2_LINHA"	,StrZero(nLinMov,3)	, NIL})
		Aadd(aItenAux,{"CT2_MOEDLC"	,cMoedaMov				, NIL})
				
				
		If CT5->CT5_DC == "1"//Debito
			Aadd(aItenAux,	{"CT2_DC"		, &(CT5->CT5_DC)		, NIL})
			Aadd(aItenAux,	{"CT2_DEBITO"	, &(CT5->CT5_DEBITO)	, NIL})
			Aadd(aItenAux,	{"CT2_CREDIT"	, ""					, NIL})
			Aadd(aItenAux,	{"CT2_CCD"		, &(CT5->CT5_CCD)		, NIL})
			Aadd(aItenAux,	{"CT2_ITEMD"	, &(CT5->CT5_ITEMD)	, NIL})
			Aadd(aItenAux,	{"CT2_CLVLDB"	, &(CT5->CT5_CLVLDB)	, NIL})
			Aadd(aItenAux,	{"CT2_VALOR"	, &(CT5->CT5_VLR01) 	, NIL})
	
		ElseIf CT5->CT5_DC == "2"//Credito
			Aadd(aItenAux,	{"CT2_DC"		, &(CT5->CT5_DC)		, NIL})
			Aadd(aItenAux,	{"CT2_DEBITO"	, ""					, NIL})
			Aadd(aItenAux,	{"CT2_CREDIT"	, &(CT5->CT5_CREDIT)	, NIL})
			Aadd(aItenAux,	{"CT2_CCC"		, &(CT5->CT5_CCC)		, NIL})
			Aadd(aItenAux,	{"CT2_ITEMC"	, &(CT5->CT5_ITEMC)	, NIL})
			Aadd(aItenAux,	{"CT2_CLVLCR"	, &(CT5->CT5_CLVLCR)	, NIL})
			Aadd(aItenAux,	{"CT2_VALOR"	, &(CT5->CT5_VLR01)	, NIL})
	
		Else//Partida Dobrada

			Aadd(aItenAux,	{"CT2_DC"		, &(CT5->CT5_DC)		, NIL})
			Aadd(aItenAux,	{"CT2_DEBITO"	, &(CT5->CT5_DEBITO)	, NIL})
			Aadd(aItenAux,	{"CT2_CREDIT"	, &(CT5->CT5_CREDIT)	, NIL})
			Aadd(aItenAux,	{"CT2_CCD"		, &(CT5->CT5_CCD)		, NIL})
			Aadd(aItenAux,	{"CT2_ITEMD"	, &(CT5->CT5_ITEMD)	, NIL})
			Aadd(aItenAux,	{"CT2_CLVLDB"	, &(CT5->CT5_CLVLDB)	, NIL})
			Aadd(aItenAux,	{"CT2_CCC"		, &(CT5->CT5_CCC)		, NIL})
			Aadd(aItenAux,	{"CT2_ITEMC"	, &(CT5->CT5_ITEMC)	, NIL})
			Aadd(aItenAux,	{"CT2_CLVLCR"	, &(CT5->CT5_CLVLCR)	, NIL})
			Aadd(aItenAux,	{"CT2_VALOR"	, &(CT5->CT5_VLR01)	, NIL})
	
		EndIf
				
		Aadd(aItenAux,	{"CT2_ORIGEM"	, &(CT5->CT5_ORIGEM)		, NIL})
		Aadd(aItenAux,	{"CT2_HORLAN" , Time()            		, NIL})
		Aadd(aItenAux,	{"CT2_HP"		, ""						, NIL})
		Aadd(aItenAux,	{"CT2_HIST"	, &(CT5->CT5_HIST)		, NIL})
		Aadd(aItenAux,	{"CT2_TPSALD"	, &(CT5->CT5_TPSALD)		, NIL})
				
		Aadd(aItens,aItenAux)
		
		cMsgLog := RunMovCont(aCab, aItens, 3 )
		If !Empty(cMsgLog)
			Aviso("Erro","Erro ao tentar contabilizar o documento: "+cNumDoc+CRLF+cMsgLog,{"Ok"},3)
		EndIf
		
	EndIf
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunMovContบAutor  ณMicrosiga           บ Data ณ  07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta a gera็ใo do movimento contabil     					 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunMovCont(aCab, aItens, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aCab 	:= {}
Default aItens:= {} 
Default nOpc	:= 3//Inclusใo

//Inicio da transa็ใo
Begin Transaction

//Verifica se os dados foram informados
If Len(aCab) > 0 .And. Len(aItens) > 0 
	
	//Chama a rotina automatica para gravar os dados
	MSExecAuto({|x,y,Z| Ctba102(x,y,Z)},aCab,aItens,nOpc)

	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa็ใo
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados nใo informados"
EndIf

//Finalisa a transa็ใo
End Transaction

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvFin บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvFin(aArquivo, cMes, cAno)
Local aArea := GetArea()
Local oDlg
Local oWin01
Local oFWLayer
Local oSize 		:= Nil
Local oFont 		:= TFont():New("CALIBRI",,-14,.T.)	
Local oButtGTit
Local oButtSaid                  
Local oScr
Local oLst                                                                      
Local aCab			:= {" ","Prefixo","Chave Data Mace", "Tipo","Natureza","Fornecedor","Loja", "Nome", "Emissใo", "Vencto.","Valor", "Chave Registro"}
Local oOk			:= LoadBitMap( GetResources(), "LBTIK" )
Local oNo			:= LoadBitMap( GetResources(), "LBNO" )
Local aDTit		:= {}
Local nTotSel		:= 0
Local oTotSel		:= Nil

Default aArquivo	:= {} 
Default cMes		:= ""
Default cAno		:= "" 

//-----------------------------------------
// Cria็ใo de classe para defini็ใo da propor็ใo da interface
//-----------------------------------------
oSize := FWDefSize():New(.T., , nOr(WS_VISIBLE,WS_POPUP) )
oSize:AddObject("TOP", 100, 100, .T., .T.)
oSize:aMargins := {0,0,0,0}
oSize:Process()


DEFINE DIALOG oDlg TITLE "Gerar titulo no Financeiro" FROM oSize:aWindSize[1],oSize:aWindSize[2] TO oSize:aWindSize[3],oSize:aWindSize[4]-10 PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro ้ para
//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )
                                                                                 

// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Sele็ใo de itens", 100, .F., .T., ,,)

oWin01 := oFWLayer:getWinPanel('Col01','Win01')

//Scroll dos parametros
oScr		:= TScrollBox():New(oWin01,00,00,oWin01:NCLIENTHEIGHT*.45,oWin01:NCLIENTWIDTH*.50,.T.,.T.,.T.)
oScr:Align 	:= CONTROL_ALIGN_ALLCLIENT

//Total selecionado
TSay():New(010,(oWin01:nClientWidth/2)-140,{||"Total Selecionado: "},oWin01,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,010)
oTotSel := TGet():New(010,(oWin01:nClientWidth/2)-80,bSetGet(nTotSel),oWin01,75,009, "@E 999,999,999,999.99",,0,,,.F.,,.T.,,.F.,{||.F.},.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )


oLst := TWBrowse():New( 030, 005, oWin01:nClientWidth/2-10,oWin01:nClientHeight/2-45,,aCab,,oWin01,,,,,,,,,,,,.F.,,.T.,,.F.,,, ) 
oLst:aColSizes 		:= { 10, 40, 30, 70, 40, 30, 40, 30, 70, 30, 50, 40, 150 }
oLst:bHeaderClick 	:= {|| InvMark(@oLst, @aDTit, @oTotSel, @nTotSel)   }

//Preenchimento dos itens para sele็ใo
GetTmpSel(aArquivo, cMes, cAno,.F., @oLst, @oTotSel, @nTotSel, @aDTit)

//Adiciona as barras dos bot๕es                                                                                                                   
DEFINE BUTTONBAR oBarTree SIZE 10,10 3D BOTTOM OF oWin01 

oButtBxTit	:= thButton():New(01,01, "Gerar Titulo(s)"	, oBarTree,  {|| Processa( {|| GerTitFin(aArquivo,cMes, cAno, @aDTit, @oLst, @oTotSel, @nTotSel) },"","" )  },35,20,)


oButtSaid			:= thButton():New(01,01, "Sair"				, oBarTree,  {|| oDlg:End()},25,20,)

oButtSaid:Align 	:= CONTROL_ALIGN_RIGHT 
oButtBxTit:Align 	:= CONTROL_ALIGN_RIGHT

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerTmpSel บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza็ใo da grid                                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTmpSel(aArquivo, cMes, cAno ,lAtualiza, oLst, oTotSel, nTotSel, aDadosSel)

Local aArea		:= GetArea()
Local cSeqProc	:= ""
Local oOk			:= LoadBitMap( GetResources(), "LBTIK" )
Local oNo			:= LoadBitMap( GetResources(), "LBNO" )
Local nX			:= 0


Default aArquivo	:= {}
Default cMes		:= "" 
Default cAno		:= "" 
Default lAtualiza	:= .F.
Default oLst		:= Nil 
Default oTotSel	:= Nil 
Default nTotSel	:= 0
Default aDadosSel	:= {}

//Grava os dados na tabela intermediaria, antes de montar a tela de sele็ใo
If !lAtualiza
	cSeqProc  := GrvP08(aArquivo, cMes, cAno)
EndIf

DbSelectArea("P08")
DbSetOrder(2)
If !Empty(cSeqProc) .Or. lAtualiza

		
	ProcRegua(Len(aArquivo))   
	
	aDadosSel := {}	
	For nX := 1 To Len(aArquivo)   
       
       cChave		:= ""
		cChave		:= Alltrim(aArquivo[nX][3])+"|"+; 	//Chave datamace
					Alltrim(aArquivo[nX][4])+"|"+;		//Tipo
					Alltrim(aArquivo[nX][5])+"|"+;		//Natureza
					Alltrim(aArquivo[nX][6])+"|"+;		//Fornecedor
					Alltrim(aArquivo[nX][7])+"|"+;		//Loja
					Alltrim(cMes)+ Alltrim(cAno)+"|"+;	//Mes e Ano
					Alltrim(aArquivo[nX][10])+"|"		//Valor

        
		IncProc("Processando...")
		
		//Verifica se o titulo ja foi gerado para este registro
		If P08->(DbSeek(xFilial("P08") + Alltrim(cChave) ))
			If Empty(P08->P08_NUM)
				Aadd(aDadosSel, {.F.,;//Flag
								"GPE",;//Prefixo
								aArquivo[nX][3],;//Chave do DM
								aArquivo[nX][4],;//Tipo do titulo
								aArquivo[nX][5],;//Natureza
								aArquivo[nX][6],;//Fornecedor							
								aArquivo[nX][7],;//Loja
								Posicione("SA2",1,xFilial("SA2")+aArquivo[nX][6]+aArquivo[nX][7],"A2_NREDUZ"),;//Nome fornecedor
								CTOD(Alltrim(aArquivo[nX][8])),;//Emissao
								CTOD(Alltrim(aArquivo[nX][9])),;//Vencimento
								Transform(Val(aArquivo[nX][10]), X3Picture("P08_VALOR")),;//Valor
								cChave;//Chave
								};
					)			
			
			EndIf		
		Else	
			Aadd(aDadosSel, {.F.,;//Flag
							"GPE",;//Prefixo
							aArquivo[nX][3],;//Chave do DM
							aArquivo[nX][4],;//Tipo do titulo
							aArquivo[nX][5],;//Natureza
							aArquivo[nX][6],;//Fornecedor							
							aArquivo[nX][7],;//Loja
							Posicione("SA2",1,xFilial("SA2")+aArquivo[nX][6]+aArquivo[nX][7],"A2_NREDUZ"),;//Nome fornecedor
							CTOD(Alltrim(aArquivo[nX][8])),;//Emissao
							CTOD(Alltrim(aArquivo[nX][9])),;//Vencimento
							Transform(Val(aArquivo[nX][10]), X3Picture("P08_VALOR")),;//Valor
							cChave;//Chave
							};
				)
		
		EndIf
	Next	
	
EndIf


oLst:SetArray( aDadosSel )

If Len(aDadosSel) > 0
	oLst:bLine:={||{	If(aDadosSel[oLst:nAt,NMARK],oOk,oNo ),;
						aDadosSel[oLst:nAt,PREFIXO],;
						Alltrim(aDadosSel[oLst:nAt,CHAVEDM]),;
						aDadosSel[oLst:nAt,TIPO],;
						aDadosSel[oLst:nAt,NATUREZA],;
						aDadosSel[oLst:nAt,FORNECEDOR],;
						aDadosSel[oLst:nAt,LOJA],;
						aDadosSel[oLst:nAt,NOME],;
						aDadosSel[oLst:nAt,EMISSAO],;
						aDadosSel[oLst:nAt,VENCREA],;
						aDadosSel[oLst:nAt,VALOR],;
						aDadosSel[oLst:nAt,CHAVEREG];
					} }
		
			
	oLst:bLDblClick 	:= {|| aDadosSel[oLst:nAt,NMARK] := !aDadosSel[oLst:nAt,NMARK],;//Altera็ใo da flag
							Iif(aDadosSel[oLst:nAt,NMARK], nTotSel += NCONVVAL(aDadosSel[oLst:nAt,VALOR]), nTotSel -= NCONVVAL(aDadosSel[oLst:nAt,VALOR]) ),;//Atualiza็ใo do valor selecionado
								oTotSel:Refresh(),;//Atualiza็ใo do objeto total selecionado (Tget)
								oLst:Refresh() }//Atualiza็ใo do objeto Twbrowse
							 
	nTotSel := 0
Else
	oLst:bLine				:= {|| {.F.,,,,,,,,,,,}}	
	oLst:bLDblClick 		:= {||}
	oLst:bHeaderClick 	:= {||} 
	nTotSel := 0	
EndIf

oLst:Refresh()
oTotSel:Refresh()

RestArea(aArea)
Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerTitFin บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera titulos no financeiro                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP																	 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerTitFin(aArquivo,cMes, cAno, aDadosSel, oLst, oTotSel, nTotSel)

Local aArea 	:= GetArea()
Local nX		:= 0
Local cMsgAux := ""
Local cNumTit := GetSx8Num("RC1","RC1_NUMTIT",,RetOrdem( "RC1" , "RC1_FILIAL+RC1_NUMTIT" ))//GetSXENum("SE2","E2_NUM")
Local aTitulo := {}
Local aErros	:= {}
Local lGrvTit	:= .F.
Local aDadTit	:= {}

Default aArquivo		:= {}
Default cMes			:= "" 
Default cAno			:= ""
Default aDadosSel 	:= {}
Default oLst			:= Nil 
Default oTotSel		:= Nil
Default nTotSel		:= 0

//Titulos selecionados e aglutinados para gerar o titulo no financeiro
aDadTit := GetAgluTit(aDadosSel)

ProcRegua(Len(aDadTit)+1)
IncProc("Gerando tํtulos no financeiro...")

For nX := 1 To Len(aDadTit)
	IncProc("Gerando tํtulos no financeiro...")

	
	cNumTit := ""	
	cMsgAux := ""
	
	cNumTit := GetSx8Num("RC1","RC1_NUMTIT",,RetOrdem( "RC1" , "RC1_FILIAL+RC1_NUMTIT" ))//GetSXENum("SE2","E2_NUM")
	aTitulo := {}
	ConfirmSX8()

	AADD(aTitulo,	{"E2_PREFIXO"	,aDadTit[nX][PREFIXO]	,Nil})
	AADD(aTitulo,	{"E2_NUM"		,cNumTit					,Nil})
	AADD(aTitulo,	{"E2_TIPO"		,aDadTit[nX][TIPO]		,Nil})
	AADD(aTitulo,	{"E2_NATUREZ"	,aDadTit[nX][NATUREZA]	,Nil})
	AADD(aTitulo,	{"E2_FORNECE"	,aDadTit[nX][FORNECEDOR]	,Nil})
	AADD(aTitulo,	{"E2_LOJA"	   	,aDadTit[nX][LOJA]		,Nil})
	AADD(aTitulo,	{"E2_NOMFOR"	,aDadTit[nX][NOME]		,Nil})
	AADD(aTitulo,	{"E2_EMISSAO" ,aDadTit[nX][EMISSAO]	,Nil})
	AADD(aTitulo,	{"E2_VENCTO" 	,aDadTit[nX][VENCREA]	,Nil})
	AADD(aTitulo,	{"E2_VALOR"	,aDadTit[nX][VALOR]		,Nil})
	AADD(aTitulo,	{"E2_HIST"		,"Integra็ใo com Datamace "+DTOC(MsDate()) ,Nil})
	AADD(aTitulo,	{"E2_ORIGEM"	,"FINA050" 				,Nil})
	
	cMsgAux := RunGerTit(aTitulo)
		
	If !Empty(cMsgAux)
		Aadd(aErros,	"------------------------------------------------------------------------------------------------------")
		Aadd(aErros,	cMsgAux)
		Aadd(aErros,	"------------------------------------------------------------------------------------------------------")
	Else
  			
		lGrvTit	:= .T.
			
  		//Grava os dados do titulo na tabela P08
		GrvP08Comp(aDadTit[nX][PREFIXO], cNumTit, aDadTit[nX][TIPO], aDadTit[nX][CHAVEREG])
			
		//Grava os dados na tabela do RH
		DbSelectArea("RC1")
		DbSetOrder(1)
		
		RecLock("RC1", .T.)
		RC1->RC1_FILIAL	:= xFilial("RC1")
		RC1->RC1_FILTIT 	:= cFilAnt
		RC1->RC1_PREFIX	:= aDadTit[nX][PREFIXO]
		RC1->RC1_NUMTIT	:= cNumTit
		RC1->RC1_INTEGR	:= "1"
		RC1->RC1_DESCRI	:= "DATAMACE"
		RC1->RC1_VALOR	:=	aDadTit[nX][VALOR]
		RC1->RC1_EMISSA	:= aDadTit[nX][EMISSAO]
		RC1->RC1_VENCTO	:= aDadTit[nX][VENCREA]
		RC1->RC1_VENREA	:= aDadTit[nX][VENCREA]
		RC1->RC1_TIPO		:= aDadTit[nX][TIPO]
		RC1->RC1_NATURE	:= aDadTit[nX][NATUREZA]
		RC1->RC1_FORNEC	:= aDadTit[nX][FORNECEDOR]
		RC1->RC1_LOJA		:= aDadTit[nX][LOJA]
		RC1->RC1_DTBUSI 	:= FirstDay( MsDate() )
		RC1->RC1_DTBUSF	:= LastDay( MsDate() )
		RC1->(MsUnLock())
	EndIf
	
			
Next


If Len(aErros) > 0
	If Aviso("Erro","Alguns erros ocorreram no processamento. Deseja visualizar o log ?",{"Sim","Nใo"},2) == 1
    	ViewLogErr(aErros)			
	EndIf
ElseIf lGrvTit 
	Aviso("Exito","Processamento realizado com sucesso.",{"Ok"},2)	
Else 	
	Aviso("","Nenhum registro importado",{"Ok"},2)	
EndIf 

//Atualiza a grid
GetTmpSel(aArquivo,cMes,cAno,.T., @oLst, @oTotSel, @nTotSel,@aDadosSel)

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetAgluTit บAutor  ณMicrosiga         บ Data ณ  05/14/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAglutina os titulos a serem gerados no Financeiro           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetAgluTit(aDadosSel)

Local aArea 		:= GetArea()
Local nX			:= 0
Local nY			:= 0
Local aRet			:= {}
Local lExiste		:= .F.
Local cChaveAux	:= ""

Default aDadosSel := {}

			
For nX := 1 To Len(aDadosSel)
	
	
	lExiste	:= .F.
	cChaveAux	:= ""
	
	cChaveAux := aDadosSel[nX][PREFIXO]+aDadosSel[nX][TIPO]+aDadosSel[nX][NATUREZA]+aDadosSel[nX][FORNECEDOR]+aDadosSel[nX][LOJA]
		
	//Verifica se o item foi marcado
	If aDadosSel[nX][NMARK]
		
		//Verifica se ja existe o item no array de retorno
		For nY	:= 1 To Len(aRet)
			
			If (aRet[nY][PREFIXO] + aRet[nY][TIPO] + aRet[nY][NATUREZA] + aRet[nY][FORNECEDOR] + aRet[nY][LOJA]) == cChaveAux 
				
				lExiste := .T.
				aRet[nY][VALOR] += NCONVVAL(aDadosSel[nX][VALOR])
				Aadd(aRet[nY][CHAVEREG],aDadosSel[nX][CHAVEREG] )
			EndIf
			
		Next
		
		//Senใo existir serแ adicionado
		If !lExiste
				Aadd(aRet, {	aDadosSel[nX,NMARK],;
									aDadosSel[nX,PREFIXO],;
									"",;
									aDadosSel[nX,TIPO],;
									aDadosSel[nX,NATUREZA],;
									aDadosSel[nX,FORNECEDOR],;
									aDadosSel[nX,LOJA],;
									aDadosSel[nX,NOME],;
									aDadosSel[nX,EMISSAO],;
									aDadosSel[nX,VENCREA],;
									NCONVVAL(aDadosSel[nX][VALOR]),;
									{aDadosSel[nX,CHAVEREG]};
									})
		
		
		EndIf
					
	EndIf
Next

RestArea(aArea)
Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvP08Comp บAutor  ณMicrosiga          บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados complementar na tabela P08                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvP08Comp(cPrefixo, cNumTit, cTipo, aChave)

Local aArea 	:= GetArea()
Local nX		:= 0

Default cPrefixo	:= "" 
Default cNumTit	:= "" 
Default cTipo		:= "" 
Default aChave	:= {}

DbSelectArea("P08")
DbSetOrder(2)

For nX := 1 To Len(aChave)
	If P08->(DbSeek(xFilial("P08") + Alltrim(aChave[nX]) ))
		RecLock("P08", .F.)
		P08->P08_PREFIX	:= cPrefixo
		P08->P08_NUM    	:= cNumTit
		P08->P08_TIPO   	:= cTipo
		P08->(MsUnLock())
	EndIf
Next
	
RestArea(aArea)
Return
    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunGerTit บAutor  ณMicrosiga           บ Data ณ  07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecuta a gera็ใo de titulos							      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunGerTit(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclusใo

//Inicio da transa็ใo
Begin Transaction

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados
	If nOpc != 5
		MsExecAuto({|x,y| Fina050(x,y)}, aTitulo, nOpc)
	Else
		MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aTitulo,,5)
	EndIf
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa็ใo 
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados nใo informados"
EndIf

//Finalisa a transa็ใo
End Transaction

RestArea(aArea)
Return cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvP08 บAutor  ณMicrosiga		         บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados em tabela intermediaria                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvP08(aArquivo, cMes, cAno)

Local aArea 		:= GetArea()
Local nX			:= 1
Local aErros    	:= {}
Local cSeqProc	:= ""
Local cChave		:= ""

Default aArquivo	:= {} 
Default cMes		:= "" 
Default cAno		:= ""

//Realiza a valida็ใo do arquivo
aErros := VldFin(aArquivo)
If Len(aErros) > 0
	If Aviso("Erro","Nใo foi possํvel validar o arquivo. Deseja visualizar o log de erros ?",{"Sim","Nใo"},2) == 1
    	ViewLogErr(aErros)			
	EndIf
	Return cSeqProc 
EndIf 

cSeqProc 	:= GetSXENum("P08","P08_CODSEQ")
ConfirmSX8()


DbSelectArea("P08")
DbSetOrder(2)
For nX := 1 To Len(aArquivo)
	
	cChave		:= ""
	cChave		:= Alltrim(aArquivo[nX][3])+"|"+; 
					Alltrim(aArquivo[nX][4])+"|"+;
					Alltrim(aArquivo[nX][5])+"|"+;
					Alltrim(aArquivo[nX][6])+"|"+;
					Alltrim(aArquivo[nX][7])+"|"+;
					Alltrim(cMes)+ Alltrim(cAno)+"|"+;
					Alltrim(aArquivo[nX][10])+"|"
	
	If !P08->(DbSeek(xFilial("P08") + cChave ))								
					
		Reclock("P08", .T.)
		P08->P08_FILIAL 	:= xFilial("P08")
		P08->P08_CODSEQ	:= cSeqProc
		P08->P08_CODDM  	:= Alltrim(aArquivo[nX][3])
		P08->P08_TPOPER	:= Alltrim(aArquivo[nX][4])
		P08->P08_NATURE 	:= Alltrim(aArquivo[nX][5])
		P08->P08_CODFOR 	:= Alltrim(aArquivo[nX][6])
		P08->P08_LOJA   	:= Alltrim(aArquivo[nX][7])
		P08->P08_EMISDM 	:= CTOD(Alltrim(aArquivo[nX][8]))
		P08->P08_VENCDM 	:= CTOD(Alltrim(aArquivo[nX][9]))
		P08->P08_VALOR  	:= Val(aArquivo[nX][10]) 
		P08->P08_DTIMP  	:= MsDate()
		P08->P08_CHV		:= cChave
		P08->(MsUnLock())
	
	EndIf                  
Next


RestArea(aArea)
Return cSeqProc


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldFin บAutor  ณMicrosiga		         บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida o arquivo do financeiro		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ViewLogErr(aMsg)

Default aMsg := {}


If !Empty(aMsg)

    //Imprime o relatorio com os erros da importa็ใo
	CtRConOut(aMsg)

EndIf

Return 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldFin บAutor  ณMicrosiga		         บ Data ณ  05/14/15  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida o arquivo do financeiro		                      	บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldFin(aArquivo)

Local aArea 	:= GetArea()
Local nX		:= 0
Local aRetErro	:= {}

Default aArquivo	:= {} 


For nX := 1 To Len(aArquivo)
	
	//Verifica se o numero do prefixo foi preenchido
	If Empty(aArquivo[nX][2])
	 	Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Prefixo nใo preenchido")
	EndIf               
	
	
	//Verifica se o numero do titulo foi preenchido
	If Empty(aArquivo[nX][3])
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Titulo nใo preenchido")
	EndIf
            
                           
	//Valida็ใo do tipo do titulo
	dbSelectArea("SX5")
	If Empty(aArquivo[nX][4])
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Tipo do titulo nใo preenchido")
	
	ElseIf !(dbSeek(xFilial("SE2")+"05"+Padr(aArquivo[nX][4], TAMSX3("E2_TIPO")[1]) ))		
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Tipo do titulo nใo encontrado: "+aArquivo[nX][4])					
	EndIf	

	            
	//Valida็ใo da natureza
	DbSelectArea("SED")
    DbSetOrder(1)
    If Empty(aArquivo[nX][5])
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Natureza financeira nใo preenchida")    
	
	Elseif  !(dbSeek(xFilial("SED")+Padr(aArquivo[nX][5], TAMSX3("ED_CODIGO")[1]) ))		
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Natureza financeira nใo encontrada: "+aArquivo[nX][5])
    EndIf
                          
	//Valida็ใo do fornecedor
	DbSelectArea("SA2")
	DbSetOrder(1)
	If Empty(aArquivo[nX][6]) .Or. Empty(aArquivo[nX][7])
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Codigo fornecedor ou loja nใo preenchido ")    	
	
	ElseIf !(dbSeek(xFilial("SA2")+ Padr(aArquivo[nX][6], TAMSX3("A2_COD")[1]) + Padr(aArquivo[nX][7], TAMSX3("A2_LOJA")[1]) ))		
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Fornecedor nใo encontrado "+Alltrim(aArquivo[nX][6])+"/"+Alltrim(aArquivo[nX][7])  )    			
	EndIf

	//Valida็ใo da data de emissao
	If Empty(aArquivo[nX][8])
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Data de emissใo nใo preenchida")
	EndIf
	
	//Valida็ใo da data de vencto
	If Empty(aArquivo[nX][9])
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Data de vencimento nใo preenchido")
	EndIf


	/*If Empty(aArquivo[nX][10]) .Or. (  NCONVVAL(aArquivo[nX][10]) <= 0)
		Aadd(aRetErro, "Linha: "+Alltrim(Str(nX))+" - Valor menor ou igual a zero")
	EndIf*/
Next   

If Len(aRetErro) > 0
	Aadd(aRetErro, "----------------------------------------------------------------------------------")	
EndIf

RestArea(aArea)
Return aRetErro 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCONVVAL บAutor  ณMicrosiga      		 บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCONVVAL(cValor)

Local aArea 	:= GetArea()
Local nRet		:= ""
Local cValorAux	:= ""

Default cValor := ""

cValorAux := STRTRAN(cValor,"R$","")
cValorAux := STRTRAN(cValorAux,".","")
cValorAux := STRTRAN(cValorAux,",",".")

nRet := Val(cValorAux)

RestArea(aArea)
Return nRet 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetClVlFil  บAutor  ณMicrosiga         บ Data ณ  26/01/2016 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a classe de valor				                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetClVlFil(cFilDM)

Local aArea 	:= GetArea()
Local cRet		:= ""

Default cFilDM	:= "" 


DbSelectArea("PZW")
DbSetOrder(1)
If PZW->(DbSeek(xFilial("PZW") + PADR(cFilDM,TAMSX3("PZW_FILDM")[1])  ))
	cRet := PZW->PZW_FILPRT
Else 
	cRet := cFilDM
EndIf



RestArea(aArea)
Return cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณInvMark บAutor  ณMicrosiga 	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณInverte a marca็ใo										  บฑฑ
ฑฑบ          ณ												    		  บฑฑ
ฑฑบ          ณ												    		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function InvMark(oLst, aDPesq, oTotSel, nTotSel)
Local aArea := GetArea()
Local nX	:= 0

Default oLst 	:= Nil
Default aDPesq  := {}                       
Default oTotSel	:= Nil 
Default nTotSel	:= 0

For nX := 1 To Len(aDPesq)
	If aDPesq[nX, NMARK]
		aDPesq[nX, NMARK] := .F.
		nTotSel -= NCONVVAL(aDPesq[nX,VALOR])
	Else
		aDPesq[nX, NMARK] := .T.     
		nTotSel += NCONVVAL(aDPesq[nX,VALOR])
	EndIf  	
Next

oTotSel:Refresh()
oLst:Refresh()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIDMF	บAutor  ณMicrosiga           บ Data ณ  07/04/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclui titulo do contas a pagar	   							    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIDMF()

Local aArea := GetArea()
Local aParam		:= {}

If PergExcTit(@aParam)
	Processa( {|| RunExcTit(aParam) },"","" )
EndIf

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunExcTit	บAutor  ณMicrosiga         บ Data ณ  07/04/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento da rotina de exclusใo de titulos			    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunExcTit(aParam)

Local aArea 		:= GetArea()
Local aTitulo   	:= {}
Local cQuery		:= ""
Local cArqTmp		:= ""
Local cMsgAux		:= ""
Local nCnt			:= 1

Default aParam := {}
	
cArqTmp		:= GetNextAlias()
	
cQuery		:= " SELECT E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_NATUREZ, E2_EMISSAO FROM "+RetSqlName("SE2")+" SE2 "+CRLF
	
cQuery		+= " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' "+CRLF
cQuery		+= " AND SE2.E2_PREFIXO = 'GPE' "+CRLF
cQuery		+= " AND SE2.E2_NUM BETWEEN '"+aParam[1]+"' AND '"+aParam[2]+"' "+CRLF
cQuery		+= " AND SE2.E2_EMISSAO BETWEEN '"+dtos(aParam[3])+"' AND '"+dtos(aParam[4])+"' "+CRLF
cQuery		+= " AND SE2.D_E_L_E_T_ = ' ' "+CRLF
cQuery		+= " AND EXISTS ( SELECT * FROM "+RetSqlName("P08")+" P08 "+CRLF
cQuery		+= " 				WHERE P08.P08_FILIAL = '"+xFilial("P08")+"' "+CRLF
cQuery		+= " 				AND P08.P08_PREFIX = SE2.E2_PREFIXO "+CRLF
cQuery		+= " 				AND P08.P08_NUM = SE2.E2_NUM "+CRLF
cQuery		+= " 				AND P08.P08_TIPO = SE2.E2_TIPO "+CRLF
cQuery		+= " 				AND P08.D_E_L_E_T_ = ' ' "+CRLF
cQuery		+= "				)"+CRLF
	 							
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )	
	
DbSelectArea("SE2")
DbSetOrder(1)
	
ProcRegua(nCnt)
	
While (cArqTmp)->(!Eof())
	
	IncProc("Excluindo...")
		
	aTitulo 	:= {}
	cMsgAux	:= ""
	
	AADD(aTitulo,	{"E2_FILIAL"	, xFilial("SE2") 			,Nil } )		
	AADD(aTitulo,	{"E2_PREFIXO"	,(cArqTmp)->E2_PREFIXO 	,Nil } )
	AADD(aTitulo,	{"E2_NUM"		,(cArqTmp)->E2_NUM		,Nil } )
	AADD(aTitulo,	{"E2_PARCELA"	,(cArqTmp)->E2_PARCELA	,Nil } )
	AADD(aTitulo,	{"E2_TIPO"		,(cArqTmp)->E2_TIPO		,Nil } )
	AADD(aTitulo,	{"E2_FORNECE"	,(cArqTmp)->E2_FORNECE	,Nil } )
	AADD(aTitulo,	{"E2_LOJA"		,(cArqTmp)->E2_LOJA		,Nil } )		
		
		//Executa a rotina automatica para exclusใo dos titulos
	cMsgAux := RunGerTit(aTitulo, 5 )
		
	If Empty(cMsgAux)
		
		//Limpa flag da tabela intermediaria
		ClearFlP08((cArqTmp)->E2_PREFIXO, (cArqTmp)->E2_NUM, (cArqTmp)->E2_TIPO)
		
		//Exclui o titulo da tabela RC1
		ClearFlRC1((cArqTmp)->E2_PREFIXO, (cArqTmp)->E2_NUM, (cArqTmp)->E2_TIPO, (cArqTmp)->E2_NATUREZ, (cArqTmp)->E2_FORNECE, (cArqTmp)->E2_LOJA, (cArqTmp)->E2_EMISSAO)
	Else
		Aviso("Aten็ใo","Nใo foi possํvel excluir o titulo "+(cArqTmp)->E2_PREFIXO+" "+CRLF+cMsgAux,{"Ok"},3)
	EndIf
		
	(cArqTmp)->(DbSkip())
EndDo
	
(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergExcTit	บAutor  ณMicrosiga         บ Data ณ  07/04/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPergunta para exclusใo de titulos do RH					    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergExcTit(aParam)

Local aArea 		:= GetArea()
Local aParamBox		:= {} 
Local lRet			:= .F.

Default aParam :={}		

AADD( aParamBox ,{1,"Titulo de:"	,Space(TAMSX3("E2_NUM")[1])		,"@!"	,"","","",70,.F.})
AADD( aParamBox ,{1,"Titulo At้:"	,Space(TAMSX3("E2_NUM")[1])		,"@!"	,"","","",70,.T.})
AADD( aParamBox ,{1,"Emissใo de: "	,CtoD("//")						,"@D"	,"","","",70,.T.})
AADD( aParamBox ,{1,"Emissใo at้: ",CtoD("//")						,"@D"	,"","","",70,.T.})

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Parโmetros",@aParam,,,.T.,50,50,,,.T.,.T.)

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณClearFlP08 บAutor  ณMicrosiga       บ Data ณ  07/04/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLimpa a flag da tabela intermediaria						    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ClearFlP08(cPrefixo, cNum, cTipo) 

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cPrefixo	:= "" 
Default cNum		:= "" 
Default cTipo		:= ""

cQuery		+= " SELECT R_E_C_N_O_ RECNOP08 FROM "+RetSqlName("P08")+" P08 "+CRLF
cQuery		+= " WHERE P08.P08_FILIAL = '"+xFilial("P08")+"' "+CRLF
cQuery		+= " AND P08.P08_PREFIX = '"+cPrefixo+"' "+CRLF
cQuery		+= " AND P08.P08_NUM = '"+cNum+"' "+CRLF
cQuery		+= " AND P08.P08_TIPO = '"+cTipo+"' "+CRLF
cQuery		+= " AND P08.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

DbSelectArea("P08")
DbSetOrder(1)
While (cArqTmp)->(!Eof())

	P08->(DbGoTo((cArqTmp)->RECNOP08))
				
	RecLock("P08",.F.)
	P08->P08_PREFIX 	:= ""
	P08->P08_NUM 		:= ""
	P08->P08_TIPO 	:= ""
	P08->(MsUnLock())

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณClearFlRC1 บAutor  ณMicrosiga       บ Data ณ  07/04/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLimpa a flag da tabela intermediaria						    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ClearFlRC1(cPrefixo, cNum, cTipo, cNature, cFornece, cLoja, cEmissao) 

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cPrefixo	:= "" 
Default cNum		:= "" 
Default cTipo		:= ""
Default cNature	:= "" 
Default cFornece	:= "" 
Default cLoja		:= ""
Default cEmissao	:= ""

cQuery		+= " SELECT R_E_C_N_O_ RECNORC1 FROM "+RetSqlName("RC1")+" RC1 "+CRLF
cQuery		+= " WHERE RC1.RC1_FILIAL = '"+xFilial("RC1")+"' "+CRLF
cQuery		+= " AND RC1.RC1_PREFIX = '"+cPrefixo+"' "+CRLF
cQuery		+= " AND RC1.RC1_NUMTIT = '"+cNum+"' "+CRLF
cQuery		+= " AND RC1.RC1_TIPO = '"+cTipo+"' "+CRLF
cQuery		+= " AND RC1.RC1_NATURE = '"+cNature+"' "+CRLF
cQuery		+= " AND RC1.RC1_FORNEC = '"+cFornece+"' "+CRLF
cQuery		+= " AND RC1.RC1_LOJA = '"+cLoja+"' "+CRLF
cQuery		+= " AND RC1.RC1_EMISSA = '"+cEmissao+"' "+CRLF
cQuery		+= " AND RC1.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

DbSelectArea("RC1")
DbSetOrder(1)
While (cArqTmp)->(!Eof())

	RC1->(DbGoTo((cArqTmp)->RECNORC1))
				
	RecLock("RC1",.F.)
	RC1->(DbDelete())
	RC1->(MsUnLock())

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return
