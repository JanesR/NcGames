#INCLUDE "PROTHEUS.CH"
#DEFINE FO_READWRITE 02
#DEFINE FO_EXCLUSIVE 16
#DEFINE X3_USADO_EMUSO "€€€€€€€€€€€€€€ "
#DEFINE X3_USADO_NAOUSADO "€€€€€€€€€€€€€€€"
#DEFINE X3_OBRIGAT "ม€"
#DEFINE X3_RESER "þภ"
#DEFINE X3_RESER_NUMERICO "๘ว"
#DEFINE X3_RES	"€€"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณUPDNCG06		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ 														  		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function UPDNCG12()  

	Local cMsg			:= ""
	
	Local nNum			:= 2 // Numero maximo de progresso da Regua(referente a qntd de atualizacoes - Sx2, Sx3, etc..) 
	Local llStart		:= .F.	
	Local aEmpresas		:= {}
	Local llAbertura	:= .F.	
	Local oError		:= ErrorBlock({|e| MsgStop("Erro encontrado: " + CRLF + e:Description + CRLF + "O Update serแ finalizado.","Erro"),lError := .T.}) 
	Local lError		:= .F. 

	
	Private oSayMsg		:= Nil
	Private cSayMsg		:= OemToAnsi("Preparando Atualiza็ใo...")
	Private nCurrent	:= 0
	Private oBarra		:= Nil
 
	cArqEmp	   	 		:= "SigaMat.Emp"
	nModulo	   	 		:= 06 // 06 = SIGAFIN
	__cInterNet	 		:= Nil
	
	#IFDEF TOP
		TCInternal(5,'*OFF') //-- Desliga Refresh no Lock do Top
	#ENDIF
	
	Set Delete On
	
	Begin Sequence	
		llAbertura	:= MyOpenSm0()  
	EndSequence	
	
	DbGoTop()  

	If !lError
		If llAbertura
			cMsg += "Este programa tem como objetivo ajustar os dicionแrios de dados(perguntas,tabelas,campos"
			cMsg += " parโmetros,gatilhos,consulta padr๕es e indices) para a implementa็ใo da melhoria"
			cMsg += " relacionada a Interface entre PROTHEUS e NcGames."
			
			lHistorico 	:= MsgYesNo("Deseja efetuar a atualizacao do Dicionario de Dados ?" + CRLF + cMsg, "Atencao !") 
			lEmpenho	:= .F.
			lAtuMnu		:= .F. 
			
		    If lHistorico 
		    
				llStart := SelecEmp(@aEmpresas) 
			    
				If llStart  
					oMainWnd := MSDialog():New(0,0,100,540,'Atualizador de Base',,,,,,,,,.T.)
						@ 010,010 SAY oSayMsg  VAR 	cSayMsg SIZE 300,010 OF oMainWnd PIXEL
						@ 023,010 METER oBarra VAR nCurrent SIZE 250,010 OF oMainWnd TOTAL nNum COLORS 12345678,12345678 PIXEL
					oMainWnd:Activate(,,,.T.,,,{||Iif(lHistorico,(FProc(aEmpresas), oMainWnd:End()),oMainWnd:End())})
			 	EndIf 
			 	
		    EndIf
    	EndIf
    EndIf        	
Return

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณSelecEmp		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta tela de Selecao das empresas que o update ira atuar		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaEmpresas - array que ira conter as empresas selecionadas		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   |llRet - Logico informando se foi cancelado ou esta tudo ok       บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/     
Static Function SelecEmp(aEmpresas)

	Local oDlgUpd	:= Nil    
	Local oPanel3	:= Nil
	Local oList		:= Nil 
	Local oBmp		:= Nil 
	Local oTitulo	:= Nil  
	Local oBtnCan	:= Nil
	Local oBtnFin	:= Nil
	
	Local oOk		:= LoadBitmap( GetResources(), "LBOK" )
	Local oNOk		:= LoadBitmap( GetResources(), "LBNO" )
		                      
	Local llRet		:= .F.
		
	If Select("SM0") == 0
		DbSelectArea("SM0")
		SM0->(DbGoTop())	
	EndIf           
	    
	aEmpresas := {}     
	
	While SM0->(!EOF())
		aAdd(aEmpresas, {.F.,SM0->M0_CODIGO,SM0->M0_NOME,SM0->M0_CODFIL,SM0->M0_FILIAL})
		SM0->(DbSkip())
	EndDo

	DEFINE DIALOG oDlgUpd TITLE "UPDATE" FROM 0, 0 TO 22, 75 SIZE 395, 289 PIXEL

		oPanel3 := TPanel():New( 000, 000, ,oDlgUpd, , , , , , 200, 120, .F.,.T. )
                                   
		@ 005,005 SAY oTitulo VAR OemToAnsi("Selecione as Empresas que o Update irแ atuar") OF oPanel3 PIXEL FONT (TFont():New('Arial',0,-13,.T.,.T.))

		oList := TWBrowse():New( 20, 10, 180, 80,,{ "", "C๓digo", "Empresa","Filial", "Nome Filial" },,oPanel3,,,,,,,,,,,,.F.,,.T.,,.F.,,,)
		oList:SetArray(aEmpresas)
		oList:bLine      := { || { If( aEmpresas[oList:nAT,1], oOk, oNOk ), aEmpresas[oList:nAt,2], aEmpresas[oList:nAT,3],aEmpresas[oList:nAt,4], aEmpresas[oList:nAT,5] } }
		oList:bLDblClick := { || aEmpresas[oList:nAt,1] := !aEmpresas[oList:nAt,1] }

		@ 125,090 BUTTON oBtnCan PROMPT "&Cancelar"   SIZE 45, 14 ACTION (oDlgUpd:End()) OF oDlgUpd PIXEL
		@ 125,145 BUTTON oBtnFin PROMPT "&Iniciar"  SIZE 45, 14 ACTION (Iif(aScan(aEmpresas,{|x| x[1]}) > 0,(llRet := .T. ,oDlgUpd:End()), Alert("Selecione pelo menos uma empresa para prosseguir com o Update"))) OF oDlgUpd PIXEL

  ACTIVATE MSDIALOG oDlgUpd CENTERED 

Return llRet

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณFProc			 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao dos arquivos 	  		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ		                                                           บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ																   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   |.T.							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function FProc(aEmpresas)
	Local cTexto   := ''
	Local cFile    := ""
	Local cMask    := "Arquivos Texto (*.TXT) |*.txt|" 
	Local nRecno   := 0
	Local nX       := 0
	Local nlI	   := 0
	Local nRecAtu
	Local aAreaSM0
	Local lAbriu
	Local nCFil		:= 0
	Local aSM0		:= {}
	Local clEmpFil	:= ""
	
	Local alAtuEmp	:= {}
	Local alAlias   := {}
	
	Local oError		:= ErrorBlock({|e| MsgStop("Erro encontrado: " + CRLF + e:Description + CRLF + "O Update serแ finalizado.","Erro"),lError := .T.}) 
	Local lError		:= .F. 
		
	Private cPaisLoc := ""    
	
	For nlI := 1 to Len(aEmpresas)
		If aEmpresas[nlI][1]
			aAdd(alAtuEmp,AllTrim(aEmpresas[nlI][2])) 
		EndIf
	Next nlI
	
	/*============= Atualizacao da Regua de Progresso =================*/
	Sleep(2000) // 2 segundos                                          //
	oBarra:Set(0) // inicia a r้gua                                    //
	Conout( "Verificando integridade dos dicionแrios..." )             //
	/*=================================================================*/ 
	
	Begin Sequence		
		OpenSm0Excl()
	EndSequence 
		
	If !lError
		aSM0 := AdmAbreSM0()
	
		For nCFil := 1 to Len(aSM0)
			If aScan(alAtuEmp, AllTrim(aSM0[nCFil][SM0_GRPEMP])) > 0
				RpcSetType(3)
				RpcSetEnv(aSM0[nCFil][SM0_GRPEMP], aSM0[nCFil][SM0_CODFIL] )
			
				RpcClearEnv()
				OpenSm0Excl()
			EndIf	
		Next nCFil
		
		For nCFil := 1 to Len(aSM0)
			If aScan(alAtuEmp, AllTrim(aSM0[nCFil][SM0_GRPEMP])) == 0
				Loop
			EndIf		
			RpcSetType(3)
			RpcSetEnv(aSM0[nCFil][SM0_GRPEMP], aSM0[nCFil][SM0_CODFIL] )
			
			cTexto += Replicate("-",128)+CRLF
			cTexto += "Empresa : "+aSM0[nCFil][SM0_GRPEMP]+" Filial : "+aSM0[nCFil][SM0_CODFIL]+"-"+aSM0[nCFil][7]+CRLF 
			
			clEmpFil := "Empresa : "+aSM0[nCFil][SM0_GRPEMP]+" Filial : "+aSM0[nCFil][SM0_CODFIL]+"-"+aSM0[nCFil][7]
			
			/*============= Atualizacao da Regua de Progresso =================*/
			
			ProcessMessages() // atualiza a pintura da janela, processa mensagens do windows
			nCurrent:= 0
			nCurrent:= Eval(oBarra:bSetGet) // pega valor corrente da regua  
			 
			/*=================================================================*/
			
			/*Begin Sequence			
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza o dicionario de arquivos. SX2ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao Dicionario de Arquivos | " + clEmpFil))
				oBarra:Set(++nCurrent)	
				
				cSayMsg := OemToAnsi("Atualizando Dicionario de Arquivos... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
			
				cTexto += AtuSX2()
			
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Dicionario de Arquivos | " + clEmpFil))	
            EndSequence
            */
			Begin Sequence				
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza o dicionario de dados. SX3ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao Dicionario de Dados | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Dicionario de Dados... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				
				alAlias := AtuSX3()
			
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Dicionario de Dados | " + clEmpFil))	
            EndSequence
               
            Begin Sequence	
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza parametros. SX6          ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao de Parametros | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Parโmetros... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				
				cTexto += AtuSX6()
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao de Parametros | " + clEmpFil))	
            EndSequence
            /*	
			Begin Sequence		
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//|Atualiza os indices.  SIX     |
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao อndices | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando อndices... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				
				cTexto += AtuSIX()   
				
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao อndices | " + clEmpFil))	
            EndSequence
            */
			Begin Sequence	            		
				RpcClearEnv()
				OpenSm0Excl()
            EndSequence			
			
		Next nCFil
	EndIf

	If !lError	
		RpcSetEnv(aSM0[1][SM0_GRPEMP],aSM0[1][SM0_CODFIL],,,,, { "AE1" })  
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณChamar o alias de todas as tabelas alteradas para for็ar a cria็ใo  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				
		oBarra:Set(++nCurrent)	 
		
		cSayMsg := OemToAnsi("Atualizando Estruturas... | " + clEmpFil)
		oSayMsg:Refresh() 	
		Sleep(2000)      	
		ProcessMessages() 
		
		__SetX31Mode(.F.) 
		 	
		For nX := 1 To Len(alAlias) 
		
			Conout( dtoc( Date() )+" "+Time()+" "+ "Inicio Atualizando Estruturas " +alAlias[nX])
			cTexto += "Atualizando estruturas. Aguarde... ["+alAlias[nX]+"]"+CHR(13)+CHR(10)
	       
	  		X31UpdTable(alAlias[nX])

			DbSelectArea(alAlias[nx])
			(alAlias[nX])->(DbCloseArea())
	  
			If __GetX31Error()
				Alert(__GetX31Trace())
				Aviso("Atencao!", "Ocorreu um erro desconhecido durante a atualizacao da tabela : " + alAlias[nX] + ". Verifique a integridade do dicionario e da tabela." ,{"Continuar"},2)
				cTexto += "Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : " +alAlias[nX] +CHR(13)+CHR(10)
			EndIf
	         
	
			cTexto += "Concluida a atualizacao de estrutura da tabela " + alAlias[nX] + CRLF
			
			Conout( dtoc( Date() )+" "+Time()+" "+"Fim Atualizando Estruturas "+alAlias[nX])
	
		Next nX
		Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Atualiza็ใo Concluํda."))
		oBarra:Set(++nCurrent) 
		
		cSayMsg := "Atualiza็ใo Concluํda."
		oSayMsg:Refresh() 
		Sleep(2000)
		ProcessMessages()
	
		cTexto += "Atualiza็ใo Concluํda."
		
		cTexto     := 	"Log da atualizacao "+CRLF+cTexto	//	"Log da atualizacao "
		__cFileLog := MemoWrite(Criatrab(,.f.)+".LOG",cTexto)
		
		DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
		DEFINE MSDIALOG oDlg TITLE "Atualizacao concluida." From 3,0 to 340,417 PIXEL
			@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
			oMemo:bRClicked := {||AllwaysTrue()}
			oMemo:oFont:=oFont
		
		DEFINE SBUTTON  FROM 153,175 TYPE  1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
		DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."
		
		
		ACTIVATE MSDIALOG oDlg CENTER
	EndIf	
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSIX		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SIX 			  		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFin                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
Static Function AtuSIX()
	Local alSix      		:= {}			//Array que armazenara os ํndices
	Local alEstrut   		:= {}			//Array com a estrutura da tabela SiX
	Local nlI				:= 0
	Local nlJ				:= 0
	Local nlA				:= 0	
	Local nlCont	 		:= 0
	Local clAuxAlias 		:= ''
	Local clOrdem 	 		:= '0'  

	Local alFinal			:= {}
	Local alBkpSix 			:= {}
	Local alAlias			:= {}
	Local alDeleta			:= {} 
	Local alSetDeleted		:= {"ZAE","ZAF"}

	Local clAliAtu	:= " "
	Local nlPos		:= 0  

	Local clTexto	 := ""
     
	alEstrut:= {"INDICE"		,"ORDEM"	,"CHAVE"																																							,"DESCRICAO"																,"DESCSPA"																	,"DESCENG"																	,"PROPRI"	,"F3"																																								,"NICKNAME"		,"SHOWPESQ"}	

	alDeleta := {}  
	
/*	aAdd(alAlias, "ZAE")
    aAdd(alSIX,	{	'ZAE'   	,'1'    	,'ZAE_FILIAL+ZAE_NUMEDI+ZAE_CLIFAT+ZAE_LJFAT'                                                                                                                           ,'Num.Ped EDI+Cli.Fat+Loj.Fat'                                             	,'Num.Ped EDI+Cli.Fat+Loj.Fat'                                             	,'Num.Ped EDI+Cli.Fat+Loj.Fat'                                             	,'U'     	,''                                                                                                                                                                	,''          	,'S'      		})
    aAdd(alSIX,	{	'ZAE'   	,'2'    	,'ZAE_FILIAL+ZAE_NUMCLI'                                                                                                                          						,'Num.Ped Cliente'                                             				,'Num.Ped Cliente'                                            				,'Num.Ped Cliente'			                                            	,'U'     	,''                                                                                                                                                                	,''          	,'S'      		})

	aAdd(alAlias, "ZAF")
    aAdd(alSIX,	{	'ZAF'   	,'1'    	,'ZAF_FILIAL+ZAF_NUMEDI+ZAF_REVISA+ZAF_CLIFAT+ZAF_LJFAT+ZAF_ITEM'                                                                                                        ,'Num.Ped EDI+Revisao+Cli.Fat+Item'                                        	,'Num.Ped EDI+Revisao+Cli.Fat+Item'                                         ,'Num.Ped EDI+Revisao+Cli.Fat+Item'                                       	,'U'     	,''                                                                                                                                                                	,''          	,'S'      		})
	*/
    dbSelectArea("SIX")
	SIX->(dbSetOrder(1))
	SIX->(dbGoTop())
	For nlI := 1 To Len(alSetDeleted)
		If SIX->(dbSeek(PadR(alSetDeleted[nlI],3)))
			While AllTrim(SIX->INDICE) == AllTrim(alSetDeleted[nlI])
				SIX->(RecLock("SIX",.F.))
				SIX->(dbDelete())                  
				SIX->(MSUnlock())
				SIX->(dbSkip())
			EndDo
		EndIf
		SIX->(dbGoTop())
	Next nlI
	
	dbSelectArea("SIX")
	SIX->(DbSetOrder(1))	// Indice + Ordem 
	SIX->(DbGoTop())
	While SIX->(!EOF())
		If aScan(alAlias, AllTrim(SIX->INDICE)) > 0 
	  		aAdd(alBkpSix, {SIX->INDICE, SIX->ORDEM, AllTrim(SIX->CHAVE)}) 
		EndIf
		SIX->(DbSkip())
	EndDo 
	
	For nlI :=  1 to Len(alSix)
		nlPos := aScan(alBkpSix,{|x| x[3]== AllTrim(alSix[nlI][3]) })
		If nlPos > 0 
			aAdd(alDeleta, alSix[nlI])
			alDeleta[Len(alDeleta)][2] := alBkpSix[nlPos][2]
		Else 
			aAdd(alFinal, alSix[nlI])
			If clAliAtu != alSix[nlI][1]
				clAliAtu := alSix[nlI][1] 
				SIX->(DbGoTop())
				If SIX->(DbSeek(alSix[nlI][1]))
					clOrdem := '0'
					While SIX->(!EOF()) .AND. AllTrim(SIX->INDICE) == AllTrim(alSix[nlI][1])
						clOrdem := Soma1(clOrdem)				
						SIX->(DbSkip())     			
					EndDo  
					clOrdem := Soma1(clOrdem)
				Else
					clOrdem := '0'
					clOrdem := Soma1(clOrdem)		
				EndIf
			Else
				clOrdem := Soma1(clOrdem)
			EndIf
			alFinal[Len(alFinal)][2] := clOrdem
			
		EndIf				
	Next nlI
	
	For nlI := 1 to Len(alDeleta)
		
		SIX->(DbGoTop())
		
		If SIX->(DbSeek(alDeleta[nlI][1]+alDeleta[nlI][2]))
	   		RecLock("SIX",.F.)
			For nlJ := 1 To Len(alEstrut)
				If FieldPos(alEstrut[nlJ])>0
					FieldPut(FieldPos(alEstrut[nlJ]),alDeleta[nlI,nlJ])
				EndIf
			Next nlJ
	   		SIX->(MsUnLock())
		   
			#IFDEF TOP
				TcInternal(60,RetSqlName(alDeleta[nlI][1]) + "|" + RetSqlName(alDeleta[nlI][1]) +alDeleta[nlI][2]) //Exclui sem precisar baixar o TOP	
			#ENDIF
		EndIf  
		
	Next nlI
	
	For nlI := 1 To Len(alFinal)	
		RecLock("SIX",.T.)
		For nlJ :=1 To Len(alEstrut)
			FieldPut(FieldPos(alEstrut[nlJ]),alFinal[nlI,nlJ])
		Next nlJ 
		SIX->(MsUnLock())	
	Next nlI  
	

	clTexto := "Concluida a atualizacao da SIX" + CRLF
	
Return clTexto        
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSX2		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SX2					   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function AtuSX2()

	Local alSX2   	:= {}
	Local alEstrut	:= {}
	Local nlI 		:= 0
	Local nlJ 		:= 0
	Local clFilial := SM0->M0_CODIGO + '0'
	
	Local clTexto	:= ""

	dbSelectArea("SX2")
	SX2->(DbSetOrder(1))	

	alEstrut:=	{	"X2_CHAVE"  ,"X2_PATH"                              	,"X2_ARQUIVO"       	,"X2_NOME"                         	,"X2_NOMESPA"                      	,"X2_NOMEENG"                      	,"X2_ROTINA"                               	,"X2_MODO" 	,"X2_DELET" ,"X2_TTS"  	,"X2_UNICO"                                                                                                                                                                                                                                                    	,"X2_PYME" 	,"X2_MODULO"  	,"X2_DISPLAY"                                                                                                                                                                                                                                                      		}


	For nlI := 1 To Len(alSX2)
		If !Empty(alSX2[nlI][1])
			If RecLock("SX2",!(SX2->(DbSeek(alSX2[nlI,1]))))
				For nlJ :=1 To Len(alSX2[nlI])
					If FieldPos(alEstrut[nlJ]) > 0
						FieldPut(FieldPos(alEstrut[nlJ]),alSX2[nlI,nlJ])
					EndIf
				Next nlJ
				MsUnLock()
			EndIf
		EndIf
	Next nlI

	clTexto := "Concluida a atualizacao da SX2" + CRLF

Return clTexto

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSX3		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SX3					   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function AtuSX3()

	Local nlA			:=0
	Local nlB			:=0
	Local nlC			:=0 		//variaveis para loop na insersao do campo
	Local alPHelpPor 	:= {}
	Local alPHelpEng 	:= {}
	Local alPHelpSpa 	:= {}
	Local alEstrut		:= {}	//Array com a estrutura do SX3
	Local alSX3			:= {}	//Array com os campos a incluir no SX3 
	Local alAlias       := {}
	Local clOrdem       := ""   
	Local alSetDeleted	:= {}
	Local nlI 			:= 0
  	
  	alEstrut:=  {	"X3_ARQUIVO"	,"X3_ORDEM" ,"X3_CAMPO"    	,"X3_TIPO" 	,"X3_TAMANHO"  	,"X3_DECIMAL"  	,"X3_TITULO"    			,"X3_TITSPA"   				,"X3_TITENG"   			 	,"X3_DESCRIC"                 			,"X3_DESCSPA"                  	   		,"X3_DESCENG"                 			,"X3_PICTURE"                                  	 	,"X3_VALID"                                                                                                                    		,"X3_USADO"        	,"X3_RELACAO"                                                                                                                 	,"X3_F3"   	,"X3_NIVEL" ,"X3_RESERV"  	,"X3_CHECK"	,"X3_TRIGGER"  	,"X3_PROPRI"  	,"X3_BROWSE" 	,"X3_VISUAL"  	,"X3_CONTEXT" 	,"X3_OBRIGAT"   ,"X3_VLDUSER"                                                                                                                     	,"X3_CBOX"                                                                                                                  ,"X3_CBOXSPA"                                                                                                            ,"X3_CBOXENG"                                                                                                            ,"X3_PICTVAR"       		,"X3_WHEN"                                                  	,"X3_INIBRW"                                                           				,"X3_GRPSXG"  	,"X3_FOLDER"	,"X3_PYME" 	,"X3_CONDSQL"                                                                                                                                                                                                                                                  ,"X3_CHKSQL"                                                                                                                                                                                                                                                   	,"X3_IDXSRV"	,"X3_ORTOGRA"  	,"X3_IDXFLD"	,"X3_TELA"         		}
 	        
    aAdd(alAlias,"SF2") 

   	aAdd(alSX3,	{	'SF2'       	,	     	,'F2_XENVINV' 	,'C'      	,1           	,0           	,'Invoice Enviada'     		,'Invoice Enviada'     		,'Invoice Enviada'     		,'Invoice Enviada'     					,'Invoice Enviada'     					,'Invoice Enviada'     					,''                                             	,''                                                                                                                                	,X3_USADO_NAOUSADO 	,''                                                                                                             			    ,''    		,1         	,'þภ'          	,''       	,''          	,'U'       		,'N'        	,'A'          	,'R'       		,''   			,''                                            				                                                                    	,'1=Sim;2=Nใo'                                                                                                             	,'1=Sim;2=Nใo'                                                                                                           ,'1=Sim;2=Nใo'                                                                                                           ,''                    	,''			                                                    ,''                                                                                 ,''          	,''         	,''      	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''        		,'N'         	,'N'         	,''               		})
   	
   		
	For nlA := 1 to Len(alSX3)  
		alPHelpPor := {alSX3[nlA][10]}
		alPHelpEng := {alSX3[nlA][11]}
		alPHelpSpa := {alSX3[nlA][12]}
		PutHelp('P'+ AllTrim(alSX3[nlA][3]),alPHelpPor,alPHelpEng,alPHelpSpa,.T.)

		alPHelpPor	:= {}
		alPHelpEng	:= {}
		alPHelpSpa 	:= {}
	Next nlA

	dbSelectArea("SX3")
	SX3->(dbSetOrder(1))
	SX3->(dbGoTop())
	For nlI := 1 To Len(alSetDeleted)
		If SX3->(dbSeek(PadR(alSetDeleted[nlI],3)))
			While AllTrim(SX3->X3_ARQUIVO) == AllTrim(alSetDeleted[nlI])
				SX3->(RecLock("SX3",.F.))
				SX3->(dbDelete())
				SX3->(MSUnlock())
				SX3->(dbSkip())
			EndDo
		EndIf
		SX3->(dbGoTop())
	Next nlI

	DbSelectArea('SX3')

	For nlA := 1 to Len(alAlias)
		SX3->(dbSetOrder(1))
		SX3->(DbGoTop())
		If SX3->(dbSeek(alAlias[nlA]))
			SX3->(dbSeek(alAlias[nlA]+"Z",.T.))
			SX3->(dbSkip(-1))

			If SX3->(!Eof()) .AND. SX3->X3_ARQUIVO == alAlias[nlA]
				clOrdem 	:=	RETASC(SX3->X3_ORDEM,3,.F.)
				clOrdem  	:= 	Soma1(clOrdem)
				clOrdem 	:=	RETASC(clOrdem,2,.T.)
			EndIf 

			For nlB := 1 to Len(alSX3)
				If alSX3[nlB][1] == alAlias[nlA]
					SX3->(dbSetOrder(2))
					SX3->(DbGoTop())
					If SX3->(dbSeek(alSX3[nlB][3]))
	                	alSX3[nlB][2] := SX3->X3_ORDEM
	                Else
	                	alSX3[nlB][2] := clOrdem 
	                	clOrdem 	:=	RETASC(clOrdem,3,.F.)
	                	clOrdem 	:= 	Soma1(clOrdem)
	                	clOrdem 	:=	RETASC(clOrdem,2,.T.)
					EndIf
				EndIf
			Next nlB 
				
		Else        
	       	clOrdem := "01"
			For nlC := 1 to Len(alSX3)   
				If alSX3[nlC][1] == alAlias[nlA] 			
	   				alSX3[nlC][2] 	:= clOrdem
	   				clOrdem 		:=	RETASC(clOrdem,2,.T.)
	       			clOrdem 		:= Soma1(clOrdem)
	  			EndIf 			 						
			Next nlC
		EndIf	
	Next nlA
	
	dbSelectArea("SX3")
	SX3->(DbSetOrder(2))
	
	For nlA := 1 To Len(alSX3)
		If !Empty(alSX3[nlA][1])  
	   		If RecLock("SX3", !(SX3->(DbSeek(PadR(alSX3[nlA,3],10," ")))) )					
				For nlB:=1 To Len(alSX3[nlA])							
					If FieldPos(alEstrut[nlB])>0 .And. alSX3[nlA,nlB] <> NIL 				
						FieldPut(FieldPos(alEstrut[nlB]),alSX3[nlA,nlB])
					EndIf				
				Next nlB			
				MsUnLock()						 			
			Endif		
		EndIf
	Next nlA

Return alAlias      
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSX6		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SX6 - Parametros	       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ		                                                           บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuSX6()

	Local alSx6       := {}						//Array que armazenara os ํndices
	Local alEstrut    := {}				        //Array com a estrutura da tabela SX6
	Local nlI         := 0 						//Contador para laco
	Local nlJ         := 0 						//Contador para laco
	Local clTexto	  := ""	        

    alEstrut :=		{	'X6_FIL'	,'X6_VAR'    	,'X6_TIPO'	,'X6_DESCRIC'                                        	,'X6_DSCSPA'                                         	,'X6_DSCENG'                                         	,'X6_DESC1'                                          	,'X6_DSCSPA1'                                        	,'X6_DSCENG1'                                        	,'X6_DESC2'                                          	,'X6_DSCSPA2'                                        	,'X6_DSCENG2'                                        	,'X6_CONTEUD'                                                 	,'X6_CONTSPA'                                              	,'X6_CONTENG'                                                  	,'X6_PROPRI'	,'X6_PYME'	,'X6_VALID'                                                                                                                        	,'X6_INIT'                                                                                                                         	,'X6_DEFPOR'                                                                                                                                                                                                                                                 	,'X6_DEFSPA'                                                                                                                                                                                                                                                 	,'X6_DEFENG'                                                                                                                                                                                                                                                 		}
	
	aAdd(alSX6,		{	''      	,'KZ_INVFLD'	,'C'      	,'Parametro para informar o caminho onde os'			,'Parametro para informar o caminho onde os'			,'Parametro para informar o caminho onde os'			,'arquivos invoices serao gravados' 					,'arquivos invoices serao gravados'						,'arquivos invoices serao gravados'						,''                                                  	,''                                                  	,''                                                  	,''                                                           	,''                                                      	,''                                                            	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})

	dbSelectArea("SX6")
	SX6->(DbSetOrder(1))	
	
	For nlI := 1 To Len(alSx6)
		If !Empty(alSx6[nlI,2])
			RecLock("SX6",!(DbSeek("  " + alSx6[nlI,2])))
			For nlJ :=1 To Len(alSx6[nlI])
				If FieldPos(alEstrut[nlJ])>0
					FieldPut(FieldPos(alEstrut[nlJ]),alSx6[nlI,nlJ])
				EndIf
			Next nlJ
			MsUnLock()
		EndIf
	Next nlI 

	clTexto := "Concluida a atualizacao da SX6" + CRLF

Return clTexto
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณMyOpenSM0		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Realiza abertura do SIGAMAT.EMP de forma exclusiva   		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFin                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   |lOpen							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function MyOpenSM0()

Local nLoop := 0	

For nLoop := 1 To 20
	dbUseArea(.T., , "SIGAMAT.EMP", "SM0", .T., .F.)
	If !Empty(Select("SM0"))
		lOpen := .T.
		dbSetIndex("SIGAMAT.IND")
		Exit
	EndIf
	Sleep(500)
Next nLoop

If !lOpen
	Aviso( "Atencao!", "Nao foi possivel a abertura da tabela de empresas de forma exclusiva!" , {"Finalizar"}, 2)	
EndIf

Return lOpen