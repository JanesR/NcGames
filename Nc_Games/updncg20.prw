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
ฑฑบFuncao    ณUPDNCG20		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ 														  		   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames	                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function UPDNCG20() 

	Local cMsg			:= ""
	
	Local nNum			:= 5 // Numero maximo de progresso da Regua(referente a qntd de atualizacoes - Sx2, Sx3, etc..) 
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
			cMsg += "Este programa tem como objetivo ajustar os dicionแrios de dados(tabelas,campos"
			cMsg += " e indices) para a implementa็ใo da melhoria"
			cMsg += " relacionada a Interface entre PROTHEUS e NCGames."
			
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
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza as perguntas de relatorios.  SX1 ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Dicionario de Perguntas | " + clEmpFil))
				oBarra:Set(++nCurrent)
				
				cSayMsg := OemToAnsi("Atualizando Dicionario de Perguntas... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
					
				cTexto += AtuSX1()
				
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Dicionario de Perguntas | " + clEmpFil))	
            EndSequence*/
			Begin Sequence			
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
			/*            
            Begin Sequence			
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza tabelas genericas		. SX5ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao Dicionario de Tabelas Temporarias| " + clEmpFil))
				oBarra:Set(++nCurrent)	
				
				cSayMsg := OemToAnsi("Atualizando Dicionario de Arquivos... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
			
				cTexto += AtuSX5()
			
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Dicionario de Tabelas Temporarias| " + clEmpFil))	
            EndSequence
			*/                        
			/*Begin Sequence	
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
            EndSequence*//*	
			Begin Sequence	
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza gatilhos. SX7	         ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao de Gatilhos | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Gatilhos... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				                                                                                                           
				cTexto += AtuSX7()
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao de Gatilhos  | " + clEmpFil))
            EndSequence*/
			/*Begin Sequence	
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza as consultas padroes. SXAณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				CONOUT(OEMTOANSI(DTOC( DATE() )+" "+TIME()+" "+ OEMTOANSI("Inํcio - Atualiza็ใo de Folders | ") + clEmpFil))
				oBarra:SET(++nCurrent)	 
			
				cSayMsg := OEMTOANSI("Atualizando Folders... | " + clEmpFil)
				oSayMsg:REFRESH() 
				SLEEP(2000)
				PROCESSMESSAGES()
			
				cTexto += ATUSXA()
			
				CONOUT(OEMTOANSI(DTOC( DATE() )+" "+TIME()+" "+ OEMTOANSI("Fim - Atualiza็ใo de Folders | ") + clEmpFil))	
            EndSequence*/			
			Begin Sequence	
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณAtualiza as consultas padroes. SXBณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao Consultas Padroes | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Consultas Padroes... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
			
				cTexto += AtuSXB()
			
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Consultas Padroes | " + clEmpFil))	 
            EndSequence
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
		/*Begin Sequence	
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza Menu.                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			//ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Inํcio - Atualizacao Menu  "))
			oBarra:Set(++nCurrent)	 
			
			cSayMsg := OemToAnsi("Atualizando Menus...  ")
			oSayMsg:Refresh() 
			Sleep(2000)
			ProcessMessages()
		
			cTexto += AtuMenu()
			Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Menu  "))	
			//ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
  		EndSequence*/
  			
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
	Local alSetDeleted		:= {"ZAC"}

	Local clAliAtu	:= " "
	Local nlPos		:= 0  

	Local clTexto	 := ""
     
	alEstrut:= {"INDICE"		,"ORDEM"	,"CHAVE"																																							,"DESCRICAO"																,"DESCSPA"																	,"DESCENG"																	,"PROPRI"	,"F3"																																								,"NICKNAME"		,"SHOWPESQ"}	

	alDeleta := {} 	
    
	aAdd(alAlias,"ZAC")
	aAdd(alSix,{	'ZAC'		,'1'		,"ZAC_FILIAL+ZAC_TPNRGD+ZAC_OPTES"                                                                                                                        			,"Filial+Tp Pedido Neogrid+Opera็ใo Tes Inteligente"                     	,"Filial+Tp Pedido Neogrid+Opera็ใo Tes Inteligente"                     	,"Filial+Tp Pedido Neogrid+Opera็ใo Tes Inteligente"                     	,'U'		,''																																									,'' 			,'S'			})
	aAdd(alSix,{	'ZAC'		,'2'		,"ZAC_FILIAL+ZAC_TPNRGD"                                                                                                                        		 			,"Filial+Tp Pedido Neogrid"             						        	,"Filial+Tp Pedido Neogrid"                      							,"Filial+Tp Pedido Neogrid"                       							,'U'		,''																																									,'' 			,'S'			})

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
ฑฑบFuncao    ณAtuSX1		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao dos SX1 					   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaCtb                                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

Static Function AtuSX1()

	Local nlI := 0
	Local nlJ := 0
    Local clTexto	:= ""

	Local alSX1	:= {}
	Local alEstrut 	:= 	{"X1_GRUPO"			,"X1_ORDEM"	,"X1_PERGUNT"						,"X1_PERSPA"						,"X1_PERENG"						,"X1_VARIAVL"	,"X1_TIPO"	,"X1_TAMANHO"	,"X1_DECIMAL"	,"X1_PRESEL"	,"X1_GSC"	,"X1_VALID"														,"X1_VAR01"			,"X1_DEF01"			,"X1_DEFSPA1"		,"X1_DEFENG1"		,"X1_CNT01"														,"X1_VAR02"			,"X1_DEF02"			,"X1_DEFSPA2"		,"X1_DEFENG2"		,"X1_CNT02"														,"X1_VAR03"			,"X1_DEF03"			,"X1_DEFSPA3"		,"X1_DEFENG3"		,"X1_CNT03"														,"X1_VAR04"			,"X1_DEF04"			,"X1_DEFSPA4"		,"X1_DEFENG4"		,"X1_CNT04"														,"X1_VAR05"			,"X1_DEF05"			,"X1_DEFSPA5"		,"X1_DEFENG5"	,"X1_CNT05"														,"X1_F3"	,"X1_PYME"	,"X1_GRPSXG"	,"X1_HELP"			,"X1_PICTURE"								,"X1_IDFIL"	}    

    aAdd(alSX1,		{	'KZFILT'		,"01"		,"Cliente De:" 			 			,"Cliente De:"						,"Cliente De:" 				   		,"MV_CH0"		,"C"		,6				,0				,0				,"G"		,""																,"MV_PAR01"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"CLI"		,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"02"		,"Cliente Ate:"						,"Cliente Ate:"	   					,"Cliente Ate:"	   					,"MV_CH0"		,"C"		,6				,0				,0				,"G"		,""																,"MV_PAR02"			,""					,""					,""					,""																,""					,""	  				,""					,""			  		,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"CLI"		,""			,""				,""					,""											,""				})
	aAdd(alSX1,		{	'KZFILT'		,"03"		,"CNPJ/CPF De:"						,"CNPJ/CPF De:"			   			,"CNPJ/CPF De:?"   					,"MV_CH0"		,"C"		,14				,0				,0				,"G"		,""																,"MV_PAR03"			,""					,""					,""					,""																,""					,""					,""					,""		 			,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"SA1CPF"	,""			,""				,"" 				,""											,""				})
	aAdd(alSX1,		{	'KZFILT'		,"04"		,"CNPJ/CPF Ate:" 			 		,"CNPJ/CPF Ate:"					,"CNPJ/CPF Ate:" 					,"MV_CH0"		,"C"		,14				,0				,0				,"G"		,""																,"MV_PAR04"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"SA1CPF"	,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"05"		,"Natureza De:" 			 		,"Natureza De:"						,"Natureza De:" 					,"MV_CH0"		,"C"		,10				,0				,0				,"G"		,""																,"MV_PAR05"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"SED"		,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"06"		,"Natureza Ate:" 			 		,"Natureza Ate:"					,"Natureza Ate:" 					,"MV_CH0"		,"C"		,10				,0				,0				,"G"		,""																,"MV_PAR06"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"SED"		,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"07"		,"Titulos De:"	 			 		,"Titulos De:"						,"Titulos De:" 		  				,"MV_CH0"		,"C"		,9				,0				,0				,"G"		,""																,"MV_PAR07"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"KFTIT"	,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"08"		,"Titulos Ate:" 			 		,"Titulos Ate:"						,"Titulos Ate:" 					,"MV_CH0"		,"C"		,9				,0				,0				,"G"		,""																,"MV_PAR08"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"KFTIT"	,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"09"		,"Validade De:" 			 		,"Validade De:"						,"Validade De:" 					,"MV_CH0"		,"D"		,8				,0				,0				,"G"		,""				  												,"MV_PAR09"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,""			,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"10"		,"Validade Ate:" 			 		,"Validade Ate:"					,"Validade Ate:" 					,"MV_CH0"		,"D"		,8				,0				,0				,"G"		,""																,"MV_PAR10"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,""			,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILT'		,"11"		,"Somente filtrados?"		 		,"Somente filtrados?"				,"Somente filtrados?" 				,"MV_CH0"		,"C"		,3				,0				,2				,"C"		,""																,"MV_PAR11"			,"Sim"				,"Sim"				,"Sim"				,""																,""					,"Nใo"				,"Nใo"				,"Nใo"				,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,""			,""			,""				,""					,"@!"										,""				})    	
	
	aAdd(alSX1,		{	'KZFILCLI'		,"01"		,"Cliente De:" 			 			,"Cliente De:"						,"Cliente De:" 				   		,"MV_CH0"		,"C"		,6				,0				,0				,"G"		,""																,"MV_PAR01"			,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"CLI"		,""			,""				,""					,"@!"										,""				})    
	aAdd(alSX1,		{	'KZFILCLI'		,"02"		,"Cliente Ate:"						,"Cliente Ate:"	   					,"Cliente Ate:"	   					,"MV_CH0"		,"C"		,6				,0				,0				,"G"		,""																,"MV_PAR02"			,""					,""					,""					,"ZZZZZZ"														,""					,""	  				,""					,""			  		,""																,""					,""					,""					,""					,""																,""					,""					,""					,""					,""																,""					,""					,""					,""				,""																,"CLI"		,""			,""				,""					,"@!"										,""				})
	
//	alEstrutura :=	{	'X1_GRUPO'  	,'X1_ORDEM'	,'X1_PERGUNT'                    	,'X1_PERSPA'                     	,'X1_PERENG'                     	,'X1_VARIAVL'	,'X1_TIPO'	,'X1_TAMANHO'	,'X1_DECIMAL'	,'X1_PRESEL'	,'X1_GSC'	,'X1_VALID'                                                    	,'X1_VAR01'       	,'X1_DEF01'       	,'X1_DEFSPA1'     	,'X1_DEFENG1'     	,'X1_CNT01'                                                    	,'X1_VAR02'       	,'X1_DEF02'       	,'X1_DEFSPA2'     	,'X1_DEFENG2'     	,'X1_CNT02'                                                    	,'X1_VAR03'       	,'X1_DEF03'       	,'X1_DEFSPA3'     	,'X1_DEFENG3'     	,'X1_CNT03'                                                    	,'X1_VAR04'       	,'X1_DEF04'       	,'X1_DEFSPA4'     	,'X1_DEFENG4'     	,'X1_CNT04'                                                    	,'X1_VAR05'       	,'X1_DEF05'       	,'X1_DEFSPA5'     	,'X1_DEFENG5'	,'X1_CNT05'                                                    	,'X1_F3' 	,'X1_PYME'	,'X1_GRPSXG'	,'X1_HELP'       	,'X1_PICTURE'                              	,'X1_IDFIL'		}
	aAdd(alSX1,		{	'KZRFILGE'    	,'01'      	,'Gerar Excel?'                  	,'Gerar Excel?'                  	,'Gerar Excel?'                  	,'MV_CH1'    	,'C'      	,1           	,0           	,1          	,'C'     	,''                                                            	,'MV_PAR01'       	,'1=Sim'          	,'1=Sim'          	,'1=Sim'          	,''                                                            	,''               	,'2=Nใo'          	,'2=Nใo'          	,'2=Nใo'          	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''          	,''                                                            	,''      	,'S'      	,''         	,''              	,''                                        	,''        		})
	aAdd(alSX1,		{	'KZRFILGE'    	,'02'      	,'Filtro de?'                    	,'Filtro de?'                    	,'Filtro de?'                    	,'MV_CH2'    	,'C'      	,10          	,0           	,0          	,'G'     	,''                                                            	,'MV_PAR02'       	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''          	,''                                                            	,'Z11'   	,'S'      	,''         	,''              	,''                                        	,''        		})
	aAdd(alSX1,		{	'KZRFILGE'    	,'03'      	,'Filtro at้?'                   	,'Filtro at้?'                   	,'Filtro at้?'                   	,'MV_CH3'    	,'C'      	,10          	,0           	,0          	,'G'     	,''                                                            	,'MV_PAR03'       	,''               	,''               	,''               	,'ZZZZZZZZZZ'                                                  	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''          	,''                                                            	,'Z11'   	,'S'      	,''         	,''              	,''                                        	,''        		})
	aAdd(alSX1,		{	'KZRFILGE'    	,'04'      	,'Itens?'                        	,'Itens?'                        	,'Itens?'                        	,'MV_CH4'    	,'C'      	,1           	,0           	,1          	,'C'     	,''                                                            	,'MV_PAR04'       	,'1=Ativos'     	,'1=Ativos'     	,'1=Ativos'     	,''                                                            	,''               	,'2=Excluํdo'     	,'2=Excluํdo'     	,'2=Excluํdo'     	,''                                                            	,''               	,'3=Ambos'        	,'3=Ambos'        	,'3=Ambos'        	,''                                                            	,''               	,''               	,''               	,''               	,''                                                            	,''               	,''               	,''               	,''          	,''                                                            	,''      	,'S'      	,''         	,''              	,''                                        	,''        		})

	dbSelectArea("SX1")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
	SX1->(DBSetOrder(1))
	SX1->(DBGoTop())

	For nlI :=1 To Len(alSX1)
		SX1->(RecLock("SX1",!(DbSeek(PADR(alSX1[nlI][1],10)+alSX1[nlI][2]))))

		For nlJ :=1 To Len (alSX1[nlI])
			If FieldPos(alEstrut[nlJ]) > 0
				FieldPut(FieldPos(alEstrut[nlJ]),alSX1[nlI][nlJ])
			EndIf
		Next nlJ

		SX1->(MsUnLock())
		SX1->(DBGoTop())
	Next nlI

	clTexto := "Concluida a atualizacao da SX1" + CRLF

Return clTexto*/ 

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

	aAdd(alSX2,	{	'ZAC'      	,''                                        	,'ZAC'+ clFilial       	,'Tp Pedido Neogrid X Tp Opera็ใo' 	,'Tp Pedido Neogrid X Tp Opera็ใo'  ,'Tp Pedido Neogrid X Tp Opera็ใo' 	,''                                        	,'E'       	,0         	,''      	,''                                                                                                                                                                                                                                                          	,'N'       	,0          	,''                                                                                                                                                                                                                                                              		})
	
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
	Local alSetDeleted	:= {"ZAC"}
	Local nlI 			:= 0
  	
  	alEstrut:=  {	"X3_ARQUIVO"	,"X3_ORDEM" ,"X3_CAMPO"    	,"X3_TIPO" 	,"X3_TAMANHO"  	,"X3_DECIMAL"  	,"X3_TITULO"    			,"X3_TITSPA"   				,"X3_TITENG"   			 	,"X3_DESCRIC"                 			,"X3_DESCSPA"                  	   		,"X3_DESCENG"                 			,"X3_PICTURE"                                  	 	,"X3_VALID"                                                                                                                    		,"X3_USADO"        	,"X3_RELACAO"                                                                                                                 	,"X3_F3"   	,"X3_NIVEL" ,"X3_RESERV"  	,"X3_CHECK"	,"X3_TRIGGER"  	,"X3_PROPRI"  	,"X3_BROWSE" 	,"X3_VISUAL"  	,"X3_CONTEXT" 	,"X3_OBRIGAT"   ,"X3_VLDUSER"                                                                                                                     	,"X3_CBOX"                                                                                                                       	,"X3_CBOXSPA"                                                                                                                      	,"X3_CBOXENG"                                                                                                                      	,"X3_PICTVAR"       	,"X3_WHEN"                                                  	,"X3_INIBRW"                                                           				,"X3_GRPSXG"  	,"X3_FOLDER"	,"X3_PYME" 	,"X3_CONDSQL"                                                                                                                                                                                                                                                  ,"X3_CHKSQL"                                                                                                                                                                                                                                                   	,"X3_IDXSRV"	,"X3_ORTOGRA"  	,"X3_IDXFLD"	,"X3_TELA"         		}
      
	aAdd(alAlias,"ZAC")
	aAdd(alSX3,{	"ZAC"			,''			,'ZAC_FILIAL'	,'C'		,2				,0				,'Filial'					,'Sucursal'					,'Branch'					,'Filial do Sistema'					,'Sucursal'								,'Branch of the System'					,'@!'												,''																																	,X3_USADO_NAOUSADO	,""																																,""			,0			,'þภ'			,''			,''				,'U'			,'N'			,''				,''				,''				,"" 																																,''			   																														,''																																	,''																																	,''						,''																,''																					,'033'			,''				,''			,''																																																																,''																																																																,''		  		,''				,''		   		,"" 					})
	aAdd(alSX3,{	"ZAC" 	   		,''			,"ZAC_TPNRGD" 	,"C" 		,3  			,0				,"Tp.Ped.NGrid" 			,"Tp.Ped.NGrid" 			,"Tp.Ped.NGrid" 			,"Tp Pedido Neogrid" 					,"Tp Pedido Neogrid" 					,"Tp Pedido Neogrid" 					,"@!"                                            	,""                                                                                                                             	,X3_USADO_EMUSO		,""                                                                                                                             ,""	 		,0			,'þภ'			,''			,''				,'U'			,"S" 			,"A" 			,"R" 			,X3_OBRIGAT    	,"Pertence('000001002003004005006')"																	                           	,"000=Cond especiais;001=Normal;002=Bonificado;003=Consignado;004=Vendor;005=Compror;006=Demonstra็ใo"                             	,"000=Cond especiais;001=Normal;002=Bonificado;003=Consignado;004=Vendor;005=Compror;006=Demonstra็ใo"                             	,"000=Cond especiais;001=Normal;002=Bonificado;003=Consignado;004=Vendor;005=Compror;006=Demonstra็ใo"                             	,""                 	,""                                                         	,""                                                                             	,''				,''		   		,''			,""                                                                                                                                                                                                                                                           	,""                                                                                                                                                                                                                                                           	,''		  		,''				,''		  		,""                		})
	aAdd(alSX3,{	"ZAC" 			,''			,"ZAC_OPTES" 	,"C" 		,2	 			,0				,"Op.TES.Int" 				,"Op.TES.Int" 				,"Op.TES.Int" 				,"Opera็ใo Tes Inteligente"   			,"Opera็ใo Tes Inteligente"    	 		,"Opera็ใo Tes Inteligente"				,"@!"                                            	,""                                                                                                                             	,X3_USADO_EMUSO		,""                                                                                                                             ,"SFM"     	,0			,'þภ'			,''			,''				,'U'			,"S" 			,"A" 			,"R" 			,X3_OBRIGAT   	,"IIF(!Empty(M->ZAC_OPTES),ExistCPO('SFM'),)"                                                         			   		   			,""                                                                                                                                 ,""                                                                                                                                 ,""                                                                                                                             	,""                     ,""                                                         	,""                                                                                	,''				,''		   		,''			,""                                                                                                                                                                                                                                                           	,""                                                                                                                                                                                                                                                           	,''		  		,''				,''		  		,""                		})

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
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SX5 - Tab.Generica	   บฑฑ
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
/*
Static Function AtuSx5()

	Local alArea	:= GetArea()
	Local alEstrut	:= {}
	Local alSX5		:= {}
	Local clFilX5 	:= xFilial( 'SX5' )
	Local clTexto	:= ""
	Local nlI		:= 0
	Local nlJ		:= 0
	
	alEstrut:= { "X5_FILIAL","X5_TABELA","X5_CHAVE","X5_DESCRI"														,"X5_DESCSPA"														,"X5_DESCENG"															}
				
	DbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	
	For nlI:= 1 To Len(alSX5)
		If SX5->(!DbSeek(alSX5[nlI,1]+alSX5[nlI,2]+alSX5[nlI,3]))
			If RecLock("SX5",.T.)
			    For nlJ := 1 to Len(alSx5[nlI])
			    	If !Empty(FieldName(FieldPos(alEstrut[nlJ])))
						FieldPut(FieldPos(alEstrut[nlJ]),alSX5[nlI,nlJ])
					EndIf
			    Next nlJ
				SX5->(MsUnlock())
			EndIf
		Else
			If RecLock("SX5",.F.)
				DbDelete()
				SX5->(MsUnLock())
			EndIf
			If RecLock("SX5",.T.)
			    For nlJ := 1 to Len(alSx5[nlI])
			    	If !Empty(FieldName(FieldPos(alEstrut[nlJ])))
						FieldPut(FieldPos(alEstrut[nlJ]),alSX5[nlI,nlJ])
					EndIf
			    Next nlJ
				SX5->(MsUnlock())
			EndIf
		EndIf
	Next nlI
	
	RestArea(alArea)
	
	clTexto := "Concluida a atualizacao da SX5" + CRLF

Return clTexto
*/  
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

Static Function AtuSX6()

	Local alSx6       := {}						//Array que armazenara os ํndices
	Local alEstrut    := {}				        //Array com a estrutura da tabela SX6
	Local nlI         := 0 						//Contador para laco
	Local nlJ         := 0 						//Contador para laco
	Local clTexto	  := ""	        

    alEstrut :=		{	'X6_FIL'	,'X6_VAR'    	,'X6_TIPO'	,'X6_DESCRIC'                                        	,'X6_DSCSPA'                                         	,'X6_DSCENG'                                         	,'X6_DESC1'                                          	,'X6_DSCSPA1'                                        	,'X6_DSCENG1'                                        	,'X6_DESC2'                                          	,'X6_DSCSPA2'                                        	,'X6_DSCENG2'                                        	,'X6_CONTEUD'                                                 	,'X6_CONTSPA'                                              	,'X6_CONTENG'                                                  	,'X6_PROPRI'	,'X6_PYME'	,'X6_VALID'                                                                                                                        	,'X6_INIT'                                                                                                                         	,'X6_DEFPOR'                                                                                                                                                                                                                                                 	,'X6_DEFSPA'                                                                                                                                                                                                                                                 	,'X6_DEFENG'                                                                                                                                                                                                                                                 		}
	
	aAdd(alSX6,		{	''      	,'ES_QTCOBR'	,'N'      	,'Numero de passos para o envio das catas de cobrancas.','Numero de passos para o envio das catas de cobrancas.','Numero de passos para o envio das catas de cobrancas.','' 													,'' 													,'' 													,''                                                  	,''                                                  	,''                                                  	,'3'                                                           	,''                                                      	,''                                                            	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'ES_CARTAS'	,'C'      	,'Caminho ou pasta para gravacao das cartas'			,''														,''														,'de cobranca a serem enviadas ' 						,'' 													,'' 													,''                                                  	,''                                                  	,''                                                  	,''                                                            	,''                                                      	,''                                                            	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		}) 
	aAdd(alSX6,		{	''      	,'ES_COBREG'	,'C'      	,'Caminho ou pasta para gravacao dos titulos'			,'Caminho ou pasta para gravacao dos titulos'			,'Caminho ou pasta para gravacao dos titulos'			,'sem cobranca' 										,'sem cobranca' 										,'sem cobranca' 										,''                                                  	,''                                                  	,''                                                  	,''                                                            	,''                                                      	,''                                                            	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	

	aAdd(alSX6,		{	''      	,'KZ_TELCOB1'	,'C'      	,'Telefone do setor de cobranca'						,'Telefone do setor de cobranca'						,'Telefone do setor de cobranca'						,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'(11) 3909–1000'                                              	,'(11) 3909–1000'                                          	,'(11) 3909–1000'                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'KZ_TELCOB2'	,'C'      	,'Telefone 2 do setor de cobranca'						,'Telefone 2 do setor de cobranca'						,'Telefone 2 do setor de cobranca'						,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'(11) 4004-1131'                                              	,'(11) 4004-1131'                                          	,'(11) 4004-1131'                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_TPCARTA'	,'C'      	,'Tipo da carta, 1- com boleto, 2 - sem boleto'			,'Tipo da carta, 1- com boleto, 2 - sem boleto'			,'Tipo da carta, 1- com boleto, 2 - sem boleto'			,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'1'			                                              	,'1'			                                          	,'1'			                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_MODCART'	,'C'      	,'Modelo da Carta'										,'Modelo da Carta'										,'Modelo da Carta'										,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''				                                              	,''				                                          	,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_LCPAG'		,'C'      	,'Local de Pagamento do boleto'							,'Local de Pagamento do boleto'		   					,'Local de Pagamento do boleto'							,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'Pagavel em qualquer banco ate o vencimento'                  	,'Pagavel em qualquer banco ate o vencimento'             	,'Pagavel em qualquer banco ate o vencimento'                  	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_CEDENTE'	,'C'      	,'Nome do cedente do boleto'							,'Nome do cedente do boleto'		   					,'Nome do cedente do boleto'							,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'UNIDAS S.A.'	                                              	,'UNIDAS S.A.'                                          	,'UNIDAS S.A.'                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_CEDCNPJ'	,'C'      	,'CNPJ da empresa cedente do boleto'					,'CNPJ da empresa cedente do boleto'					,'CNPJ da empresa cedente do boleto' 					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'04437534000130'                                              	,'04437534000130'                                          	,'04437534000130'                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_AGNCED'	,'C'      	,'Agencia do cedente'									,'Agencia do cedente'									,'Agencia do cedente'									,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
    aAdd(alSX6,		{	''      	,'KZ_CODCED'	,'C'      	,'Codigo do cedente'									,'Codigo do cedente'									,'Codigo do cedente'									,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'4002040'	                                              		,'4002040'			                                   		,'4002040'		                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_NOSSNUM'	,'C'      	,'Nosso numero'											,'Nosso numero'											,'Nosso numero'		 									,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'00000000001'                                             		,'00000000001'                                         		,'00000000001'	                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_CART'		,'C'      	,'Nome da carteira de cobranca'							,'Nome da carteira de cobranca'							,'Nome da carteira de cobranca'							,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'NCR'		                                              		,'NCR'		                                          		,'NCR'			                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST1'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'Nao Receber apos data de vencimento'                     		,'Nao Receber apos data de vencimento'                		,'Nao Receber apos data de vencimento'                         	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST2'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST3'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST4'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST5'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST6'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST7'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_INST8'		,'C'      	,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,'Instrucoes de recebimento do boleto'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,''			                                              		,''			                                          		,''				                                              	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})	
	aAdd(alSX6,		{	''      	,'KZ_NTCOB'		,'C'      	,'CNPJS que nao serao cobrados'							,'CNPJS que nao seram cobrados'							,'CNPJS que nao seram cobrados'							,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'004437534000130;007462626000169'                        		,'004437534000130;007462626000169'                     		,'004437534000130;007462626000169'                             	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'KZ_TIPCOB'	,'C'      	,'Tipos de cobranca que nao serao cobrados'				,'Tipos de cobranca que nao serao cobrados'				,'Tipos de cobranca que nao serao cobrados'				,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'CAR;BV;CLA;EST;FRQ;JUR;TER;COM;FIL;SAC'                  		,'CAR;BV;CLA;EST;FRQ;JUR;TER;COM;FIL;SAC'              		,'CAR;BV;CLA;EST;FRQ;JUR;TER;COM;FIL;SAC'                      	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'KZ_TPTIT'		,'C'      	,'Tipos de titulos que nใo serใo cobrados'				,'Tipos de titulos que nใo serใo cobrados'				,'Tipos de titulos que nใo serใo cobrados'				,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'RA;TAC;RF;CMF'						                  		,'RA;TAC;RF;CMF'						              		,'RA;TAC;RF;CMF'						                      	,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	
	aAdd(alSX6,		{	''      	,'KZ_BANCO1'	,'C'      	,'Empresa em que serแ usado o banco Bradesco'			,'Empresa que serแ usado o banco Bradesco'				,'Empresa que serแ usado o banco Bradesco'				,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'99'									                  		,'99'              											,'99'                      										,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'KZ_BANCO2'	,'C'      	,'Empresa em que serแ usado o banco HSBC'				,'Empresa que serแ usado o banco HSBC'					,'Empresa que serแ usado o banco HSBC'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'01'                  											,'01'              											,'01'                      										,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})

	aAdd(alSX6,		{	''      	,'KZ_ENDMOD'	,'C'      	,'Caminho do modelo'									,'Caminho do modelo'									,'Caminho do modelo'									,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'C:\'                  										,'C:\'                  									,'C:\'                  										,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'MV_TPREG'		,'C'      	,'Tipos de Tํtulos a serem cobrados'					,'Tipos de Tํtulos a serem cobrados'					,'Tipos de Tํtulos a serem cobrados'					,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'NF;EC;NDC'                  									,'NF;EC;NDC'                  								,'NF;EC;NDC'                  									,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
 
	aAdd(alSX6,		{	''      	,'ES_ANODEB'	,'C'      	,'Qntd de anos para o titulo nao ser cobrado'			,'Qntd de anos para o titulo nao ser cobrado'			,'Qntd de anos para o titulo nao ser cobrado'			,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'5'  		                									,'5'                  							   			,'5'                  											,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'ES_DEBCAR'	,'C'      	,'Info. se deve continua enviando cartas'				,'Info. se deve continua enviando cartas'				,'Info. se deve continua enviando cartas'				,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'S'                  											,'S'	                  									,'S'                  											,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})

	aAdd(alSX6,		{	''      	,'ES_VALCOB'	,'N'      	,'Valor mํnimo para realizar cobran็a de tํtulos'		,'Valor mํnimo para realizar cobran็a de tํtulos'		,'Valor mํnimo para realizar cobran็a de tํtulos'		,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'20'                  											,'20'	                  									,'20'                  											,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})

	// parametro ja existente nos SX's da unidas
	
	aAdd(alSX6,		{	''      	,'MV_XBOLBCO'	,'C'      	,'Banco do boleto'										,'Banco do boleto'										,'Banco do boleto'										,'apos periodo informado no ES_ANODEB '				 	,'apos periodo informado no ES_ANODEB '					,'apos periodo informado no ES_ANODEB '					,''                                                  	,''                                                  	,''                                                  	,'1239876544444444'    											,'1239876544444444'											,'1239876544444444'        										,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	
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

Return clTexto*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSX7		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SX7 - Gatilhos	  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ /*
Static Function AtuSX7() 
  
	Local alSX7   	:= {}	//Array que contera os dados dos gatilhos
	Local alEstrut	:= {}	//Array que contem a estrutura da tabela SX7
	Local nlI      	:= 0	//Contador para laco
	Local nlJ      	:= 0	//Contador para laco
	Local alSetDeleted      := {}
    Local 			:= ""

	alEstrut:= { "X7_CAMPO"			,"X7_SEQUENC"	,"X7_REGRA"						   						,"X7_CDOMIN"	,"X7_TIPO"	,"X7_SEEK"	,"X7_ALIAS"		,"X7_ORDEM"		,"X7_CHAVE"							,"X7_CONDIC"		,"X7_PROPRI"	} 
	dbSelectArea("SX7")
	SX7->(dbSetOrder(1))
	SX7->(dbGoTop())
	For nlI := 1 To Len(alSetDeleted)
		If SX7->(dbSeek(PadR(alSetDeleted[nlI],10)))
			While AllTrim(SX7->X7_CAMPO) == AllTrim(alSetDeleted[nlI])
				SX7->(RecLock("SX7",.F.))
				SX7->(dbDelete())
				SX7->(MSUnlock())
				SX7->(dbSkip())
			EndDo
		EndIf
		SX7->(dbGoTop())
	Next nlI
	
	dbSelectArea("SX7")
	SX7->(DbSetOrder(1))	                                                    
	For nlI := 1 To Len(alSX7)
		If !Empty(alSX7[nlI][1])
			RecLock("SX7",!(DbSeek(PADR(alSX7 [nlI,1],10)+ PADR(alSX7[nlI,2],3))))
			For nlJ :=1 To Len(alSX7[nlI])
				If !Empty(FieldName(FieldPos(alEstrut[nlJ])))
					FieldPut(FieldPos(alEstrut[nlJ]),alSX7[nlI,nlJ])
				EndIf
			Next nlJ		
			MsUnLock()
		EndIf
	Next nlI 

	clTexto := "Concluida a atualizacao da SX7" + CRLF

Return clTexto
*/
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuMenu		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da atualizacao do(s) menu(s)			   บฑฑ
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
/*Static Function AtuMenu()

	Local nlI			:= 1							// contador de laco
	Local alMenuInc		:= {}                         	// variavel com os itens do menu
	Local alMenuRel		:= {}                         	// variavel com os itens do menu de relatorio
	Local clFile		:= GetSrvProfString('StartPath','')+ 'sigafin.XNU'		// arquivo de menu
	Local clBackup      := GetSrvProfString('StartPath','')+ 'sigafin_bkp.XNU'  // arquivo onde sera gerado backup

	Local hlFile                                       	// handle de arquivo 1
	Local hlFile2									   	// handle de arquivo 2
	Local hlFile3            						   	// handle de arquivo 3
	Local nlSize                                       	// variavel para determinar o tamanho do buffer
	Local clBuffer		:= ""                          	// buffer de arquivo
	Local clBufferAux	:= ""                          	// buffer de arquivo auxiliar
	Local clBufferBackup:= ""                          	// buffer para arquivo de backup
	Local nlPos			:= 0                           	// variavel auxiliar para a insercao do menu
	Local nlPos2		:= 0                           	// variavel auxiliar para a insercao do menu
	Local clGrupo		:= ""                           // contem as tags do grupo
	Local clItens		:= ""                           // contem as tags dos itens
	Local clItens2		:= ""                           // contem as tags dos itens do relatorio
	Local clMenu		:= 'R้guas de Cobran็a'		   	// nome do grupo de menu   
	Local clMenu2		:= 'Cadastros'	   				// nome do grupo de menu de relat๓rios
	Local clMenu3		:= 'Relat๓rios'
	Local clRet			:= ""                          	// texto de retorno 
	Local nlTam1 		:= 0                            // contador de espacos
	Local nlTam2		:= 0							// contador de espacos
	Local nlTam3 									   	// contador de espacos
	Local clTam1		:= ""                          	// contem tabs para serem adicionados nas tags
	Local clTam2		:= ""						   	// contem tabs para serem adicionados nas tags
	Local clTam3		:= ""						   	// contem tabs para serem adicionados nas tags      
	Local clGrupo2 		:= "" 
	Local clGrupo3		:= ""
		                        
	//abre o arquivo para leitura e gravacao em modo exclusivo   
	hlFile := fOpen(clFile,FO_READWRITE+FO_EXCLUSIVE,,.F.)
    
	//verifica se foi possivel abrir o arquivo   
	If fError() != 0
		clRet	:=	"Nใo foi possํvel abrir o arquivo de menu."
		Break
	EndIf
    
	//verifica o tamanho total do arquivo
	nlSize := fSeek(hlFile,0,2)
   
	//posiciona no inicio do arquivo
	fSeek(hlFile,0)      

	// aloca buffer   
 	clBuffer  := Space(nlSize)    
	// efetua leitura
	fRead(hlFile,@clBuffer,nlSize)
    // salva o buffer atual num buffer de backup
    clBufferBackup	:=	clBuffer
	// fecha o arquivo
	fClose(hlFile)	   
    
    // verifica os espacos no menu
	nlTam1		:= (At('<Title lang="pt">',clBuffer)-1)-(At('<Menu Status="Enable">',clBuffer)+Len('<Menu Status="Enable">'))-1
	clBufferAux	:= SubStr(clBuffer,At('<Title lang="pt">',clBuffer))
	clBufferAux	:= SubStr(clBufferAux,At('<Menu Status="Enable">',clBufferAux))
	nlTam2		:= (At('<Title lang="pt">',clBufferAux)-1)-(At('<Menu Status="Enable">',clBufferAux)+Len('<Menu Status="Enable">'))-1
	clBufferAux := SubStr(clBufferAux,At('<MenuItem Status="Enable">',clBufferAux))
	nlTam3		:= (At('<Title lang="pt">',clBufferAux)-1)-(At('<MenuItem Status="Enable">',clBufferAux)+Len('<MenuItem Status="Enable">'))-1
	
	// aloca a quantidade de tab nas variaveis
	For nlI := 1 to nlTam1
		clTam1	:=	clTam1 + CHR(9)
	Next nlI    
	
	For nlI := 1 to nlTam2
		clTam2	:=	clTam2 + CHR(9)
	Next nlI
	
	For nlI := 1 to nlTam3
		clTam3	:=	clTam3 + CHR(9)
	Next nlI
	
	
	// adiciona as tags completas nas variaveis
	clGrupo	:=	"<Menu Status="+CHR(34)+"Enable"+CHR(34)+">"							 +CRLF	+;
				clTam2 + "<Title lang="+CHR(34)+"pt"+CHR(34)+">"+clMenu+"</Title>"     +CRLF	+;
				clTam2 + "<Title lang="+CHR(34)+"es"+CHR(34)+">"+clMenu+"</Title>"     +CRLF	+;
				clTam2 + "<Title lang="+CHR(34)+"en"+CHR(34)+">"+clMenu+"</Title>"     +CRLF	
		                                                                                        
	clGrupo2 :=	clTam2 + "<Menu Status="+CHR(34)+"Enable"+CHR(34)+">"					 +CRLF	+;
				clTam3 + "<Title lang="+CHR(34)+"pt"+CHR(34)+">"+clMenu2+"</Title>"     +CRLF	+;
				clTam3 + "<Title lang="+CHR(34)+"es"+CHR(34)+">"+clMenu2+"</Title>"     +CRLF	+;
				clTam3 + "<Title lang="+CHR(34)+"en"+CHR(34)+">"+clMenu2+"</Title>"     +CRLF	   
				
	clGrupo3 :=	clTam2 + "<Menu Status="+CHR(34)+"Enable"+CHR(34)+">"					 +CRLF	+;
				clTam3 + "<Title lang="+CHR(34)+"pt"+CHR(34)+">"+clMenu3+"</Title>"     +CRLF	+;
				clTam3 + "<Title lang="+CHR(34)+"es"+CHR(34)+">"+clMenu3+"</Title>"     +CRLF	+;
				clTam3 + "<Title lang="+CHR(34)+"en"+CHR(34)+">"+clMenu3+"</Title>"     +CRLF	   
					                            
	aAdd(alMenuInc,{{OemToAnsi("Cartas de Cobran็as")   ,OemToAnsi("Cartas de Cobran็as")		,OemToAnsi("Cartas de Cobran็as")   	},"U_KZURC100" 		}) 
	aAdd(alMenuInc,{{OemToAnsi("Tabela de Notifica็ใo") ,OemToAnsi("Tabela de Notifica็ใo")		,OemToAnsi("Tabela de Notifica็ใo")   	},"U_KZURC102" 		}) 				
	aAdd(alMenuInc,{{OemToAnsi("Cadastro de R้guas")   	,OemToAnsi("Cadastro de R้guas")		,OemToAnsi("Cadastro de Reguas")		},"U_KZURC200" 		}) 				
	aAdd(alMenuInc,{{OemToAnsi("Fases de Cobran็a")   	,OemToAnsi("Fases de Cobran็a")			,OemToAnsi("Fases de Cobran็a") 		},"U_KZURC300" 		})
	aAdd(alMenuInc,{{"Feriados"			   	   			,"Feriados"			   	   				,"Feriados"  	 			   			},"U_KZURC400" 		})   
	aAdd(alMenuInc,{{"Filtros Por Fatura"		   	   	,"Filtros Por Fatura"					,"Filtros Por Fatura"	 				},"U_KZURC700"		}) 	  	
	aAdd(alMenuInc,{{"Cadastro Gestores"			   	,"Cadastro Gestores"					,"Cadastro Gestores"	 				},"U_KZURC800"		}) 	  
	aAdd(alMenuInc,{{"Cadastro de Equipes"			   	,"Cadastro de Equipes"					,"Cadastro de Equipes"	 				},"U_KZURC900"		}) 	  
	aAdd(alMenuInc,{{OemToAnsi("Reatribui็ใo Gestor")  	,OemToAnsi("Reatribui็ใo de Gestor")	,OemToAnsi("Reatribui็ใo de Gestor")	},"U_KZURC010"		}) 	  	
	aAdd(alMenuInc,{{"Filtro de Clientes"		   		,"Filtro de Clientes"					,"Filtro de Clientes"					},"U_KZURC600"		})
	aAdd(alMenuInc,{{"Motivo Filtro"					,"Motivo Filtro"						,"Motivo Filtro"						},"U_KZURC018"		})
	aAdd(alMenuInc,{{"Modelo de Cartas"	 				,"Modelo de Cartas"	 					,"Modelo de Cartas"	 					},"U_KZURC019"	 	})		
	aAdd(alMenuInc,{{OemToAnsi("Tabela de Pend๊ncias")	,OemToAnsi("Tabela de Pend๊ncias")		,OemToAnsi("Tabela de Pend๊ncias")		},"U_KZURC012"		}) 
	aAdd(alMenuInc,{{OemToAnsi("Consulta de Tํtulo")	,OemToAnsi("Consulta de Tํtulo")		,OemToAnsi("Consulta de Tํtulo")		},"U_KZURC015"		}) 
	aAdd(alMenuInc,{{OemToAnsi("Resumo de Tํtulo")		,OemToAnsi("Resumo de Tํtulo")	   		,OemToAnsi("Resumo de Tํtulo")	   		},"U_KZURC014"		}) 	
	
	aAdd(alMenuRel,{{OemToAnsi("Pend๊ncias")	 		,OemToAnsi("Pend๊ncias")	   			,OemToAnsi("Pend๊ncias")			   	},"U_KZURC021"		}) 
	aAdd(alMenuRel,{{OemToAnsi("Baixas X Pend๊ncias")	,OemToAnsi("Baixas X Pend๊ncias")		,OemToAnsi("Baixas X Pend๊ncias")		},"U_KZURCR270"		})
	aAdd(alMenuRel,{{OemToAnsi("Filtros de Clientes")	,OemToAnsi("Filtros de Clientes")		,OemToAnsi("Filtros de Clientes")		},"U_KZURC016"		})
	aAdd(alMenuRel,{{OemToAnsi("R้gua Por Perํodo")		,OemToAnsi("R้gua Por Perํodo")	  		,OemToAnsi("R้gua Por Perํodo")		   	},"U_KZURC023"		})
	aAdd(alMenuRel,{{OemToAnsi("Clientes VIPs")	   		,OemToAnsi("Clientes VIPs")		   		,OemToAnsi("Clientes VIPs")		  		},"U_KZURC025"		})
	aAdd(alMenuRel,{{OemToAnsi("Clientes Bloqueados")	,OemToAnsi("Clientes Bloqueados")		,OemToAnsi("Clientes Bloqueados")		},"U_KZURC022"		}) 	  	 	  		
	aAdd(alMenuRel,{{OemToAnsi("Situa็ใo de Tํtulos")	,OemToAnsi("Situa็ใo de Tํtulos") 		,OemToAnsi("Situa็ใo de Tํtulos")		},"U_KZURC020"		}) 	  	 	  		
	aAdd(alMenuRel,{{OemToAnsi("Filtros Por Fatura") 	,OemToAnsi("Filtros Por Fatura")  		,OemToAnsi("Filtros Por Fatura")		},"U_KZURC017"		}) 	  	 	  		
	aAdd(alMenuRel,{{OemToAnsi("Hist๓rico Cobran็a")	,OemToAnsi("Hist๓rico Cobran็a") 		,OemToAnsi("Hist๓rico Cobran็a") 		},"U_KZURC028"		}) 	  	 	  			 	  	
						
	For nlI	:= 1 To Len(alMenuInc)
		clItens +=	clTam3 + "<MenuItem Status="+CHR(34)+"Enable"+CHR(34)+">"          							+CRLF +;
				  	clTam3+ CHR(9) + "<Title lang="+CHR(34)+"pt"+CHR(34)+">"+alMenuInc[nlI][1][1]+"</Title>" 				+CRLF +;
				  	clTam3+ CHR(9) + "<Title lang="+CHR(34)+"es"+CHR(34)+">"+alMenuInc[nlI][1][2]+"</Title>" 				+CRLF +;
				  	clTam3+ CHR(9) + "<Title lang="+CHR(34)+"en"+CHR(34)+">"+alMenuInc[nlI][1][3]+"</Title>" 				+CRLF +;
					clTam3+ CHR(9) + "<Function>"+alMenuInc[nlI][2]+"</Function>"                          	   				+CRLF +;
				   	clTam3+ CHR(9) + "<Type>1</Type>"                                           			   				+CRLF +;
				   	clTam3+ CHR(9) + "<Access>xxxxxxxxxx</Access>"                                      	   				+CRLF +;
				   	clTam3+ CHR(9) + "<Module>06</Module>"																	+CRLF +;
				   	clTam3 + "</MenuItem>"																			+CRLF
	Next nlI

	
	For nlI	:= 1 To Len(alMenuRel)
		clItens2 +=	clTam3 + "<MenuItem Status="+CHR(34)+"Enable"+CHR(34)+">"          							+CRLF +;
				  	clTam3+ CHR(9) +"<Title lang="+CHR(34)+"pt"+CHR(34)+">"+alMenuRel[nlI][1][1]+"</Title>" 		+CRLF +;
				  	clTam3+ CHR(9) +"<Title lang="+CHR(34)+"es"+CHR(34)+">"+alMenuRel[nlI][1][2]+"</Title>" 		+CRLF +;
				  	clTam3+ CHR(9) +"<Title lang="+CHR(34)+"en"+CHR(34)+">"+alMenuRel[nlI][1][3]+"</Title>" 		+CRLF +;
					clTam3+ CHR(9) +"<Function>"+alMenuRel[nlI][2]+"</Function>"                          	   	+CRLF +;
				   	clTam3+ CHR(9) +"<Type>1</Type>"                                           			   		+CRLF +;
				   	clTam3+ CHR(9) +"<Access>xxxxxxxxxx</Access>"                                      	   		+CRLF +;
				   	clTam3+ CHR(9) +"<Module>06</Module>"															+CRLF +;
				   	clTam3 +"</MenuItem>"																			+CRLF
	Next nlI
	
	// verifica se o grupo de menu ja existe
	// se existir e estiver no local correto, sera apagado e criado de novo
	// se existir mas estiver em outro local, sera criado no local correto e o antigo sera mantido
	// se nao existir sera criado no local correto                                                                                                     
	If (At(Upper(clMenu),Upper(clBuffer))-1 > At(Upper('<Title lang="pt">Cadastro'),Upper(clBuffer))-1) .And. (At(Upper(clMenu),Upper(clBuffer))-1 < At(Upper('<Title lang="pt">Contas a Pagar'),Upper(clBuffer))-1)  
		nlPos 		:= At(Upper(clMenu),Upper(clBuffer))-1
		clBufferAux	:= SubStr(clBuffer,1,nlPos) 
		nlPos		:= RAT('<Menu Status="Enable">',clBufferAux)-1
		clBufferAux	:= SubStr(clBuffer,nlPos,Len(clBuffer)-nlPos)
		nlPos2 		:= At('</Menu>',clBufferAux)-1+Len('</Menu>')
		// ================= Tratamento para pegar o grupo de cadastro + relatorio =========================		
		nlTam1 		:= Len(clBufferAux)
		clBufferAux := SubStr(clBufferAux, nlPos2+1, Len(clBufferAux)-nlPos2+1)
		nlTam2 		:= Len(clBufferAux)
		nlPos2 		:= At('</Menu>',clBufferAux)-1+Len('</Menu>')+(nlTam1-nlTam2)
		clBufferAux	:= SubStr(clBuffer,nlPos,Len(clBuffer)-nlPos)
		// =================================================================================================				
		clBuffer	:= Stuff(clBuffer,nlPos+nlPos2,0,CRLF+clTam1+clGrupo + clGrupo2 + clItens + clTam2 + "</Menu>"  + CRLF + clTam1 + clGrupo3 + clItens2 + clTam2 + "</Menu>"/*+ clTam2+ CRLF + clTam1 + "</Menu>")
		clBuffer	:= Stuff(clBuffer,nlPos,nlPos2,"")
		
		//corrige os espacos entre o </Menu> e o <Menu Status="Enable">
		nlPos		:= At(Upper(clMenu),Upper(clBuffer))-1
		clBufferAux := SubStr(clBuffer,1,nlPos)
		nlPos		:= RAT('<Menu Status="Enable">',clBufferAux)-1
		clBufferAux	:= SubStr(clBuffer,1,nlPos)
		nlPos2 		:= RAT('</Menu>',clBufferAux)-1+Len('</Menu>')
		clBufferAux	:= SubStr(clBuffer,1,nlPos2) + CRLF + clTam1
		clBuffer	:= SubStr(clBuffer,nlPos+1)
		clBuffer	:= clBufferAux+clBuffer
	Else 
		nlPos		:= At(Upper('</Menu>'),Upper(clBuffer)) + 7
		clBufferAux	:= SubStr(clBuffer,nlPos)
		nlPos		:= nlPos + (At(Upper('</Menu>'),Upper(clBufferAux))) + 7
		clBufferAux	:= SubStr(clBuffer,nlPos)
  		clBuffer	:= SubStr(clBuffer,1,nlPos) + clTam1 +clGrupo + clGrupo2 + clItens + clTam2 + "</Menu>"  + CRLF + clTam1 + clGrupo3 + clItens2 + clTam2 + "</Menu>"+ clTam2+ CRLF + clTam1 + "</Menu>" + CRLF + clBufferAux
	EndIf 
    
    //verifica se o nome sigafat_bkp esta disponivel
	hlFile2	:= fOpen(clBackup,FO_READWRITE+FO_EXCLUSIVE,,.F.)  
	//se nao existir sigafat_bkp, renomeia o XNU antigo para este nome, senao sobreescreve o antigo
	If fError() == 161
		fRename(clFile,clBackup)
	Else
		fWrite(hlFile2,clBufferBackup,Len(clBufferBackup))
	EndIf
	fClose(hlFile2)
	
	//cria o novo XNU com o nome do antigo
	hlFile3 := FCreate(clFile,0)
    
 	//grava as informacoes no novo XNU
	fWrite(hlFile3,clBuffer,Len(clBuffer))  
	   
	//fecha o arquivo
	fClose(hlFile3)  
	
	clRet := 'O menu do m๓dulo SigaFIN foi atualizado. Arquivo de backup gerado: "' + clBackup + '"' + CRLF 

		
Return clRet*/ 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSXA		 บAutor  ณDenis S. Naves	  บ Data ณ 12/08/11    บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza Folders 												   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ		                                                           บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 																   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | 								                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

STATIC FUNCTION ATUSXA()

	LOCAL alSXA   	:= {}                                       
	LOCAL alEstrut	:= {}
	LOCAL alAlias   := {}
	LOCAL nlA := 0, nlB := 0, nlC := 0
	LOCAL clOrdem   := "0" 
	LOCAL clTxt		:= " "
	
	alEstrut:= {"XA_ALIAS","XA_ORDEM","XA_DESCRIC","XA_DESCSPA","XA_DESCENG","XA_PROPRI"}
	
	AADD(alAlias,"SA1")
	
	AADD(alSXA,{"SA1","1","Cadastrais"			,"De registro"			,"Records"				,"S"})
	AADD(alSXA,{"SA1","2","Adm/Fin."			,"Adm/Fin."				,"Adm/Fin."				,"S"})
	AADD(alSXA,{"SA1","3","Fiscais"				,"Fiscales"				,"Fiscal"				,"S"})
	AADD(alSXA,{"SA1","4","Vendas"				,"Ventas"				,"Sales"				,"S"})
	AADD(alSXA,{"SA1","5",OEMTOANSI("R้gua")	,OEMTOANSI("R้gua")		,OEMTOANSI("R้gua")		,"U"})		
	
	DBSELECTAREA("SXA")
	
	FOR nlA := 1 TO LEN(alAlias)    
		SXA->(DBSETORDER(1))  
		SXA->(DBGOTOP()) 	
		IF SXA->(DBSEEK(alAlias[nlA]))  						
			SXA->(DBSEEK(alAlias[nlA]+"Z",.T.))
			SXA->(DBSKIP(-1))				
			IF SXA->(!EOF()) .AND. SXA->XA_ALIAS == alAlias[nlA]
				clOrdem	:=	RETASC(SXA->XA_ORDEM,1,.F.)
				clOrdem	:= 	SOMA1(clOrdem)
				clOrdem	:=	RETASC(clOrdem,1,.F.)			
			ENDIF 		
			FOR nlB := 1 TO LEN(alSXA)		   		    
				IF alSXA[nlB][1] == alAlias[nlA] 						
					SXA->(DBSETORDER(1))  		
					IF DBSEEK(alSXA[nlB][1] + alSXA[nlB][2])			
						alSXA[nlB][2]	:= SXA->XA_ORDEM									
	    			ELSE           		      			
	      				alSXA[nlB][2]	:= 	clOrdem   	
	   					clOrdem 		:=	RETASC(clOrdem,2,.F.)
	       				clOrdem 		:= 	SOMA1(clOrdem)
	       				clOrdem 		:=	RETASC(clOrdem,1,.T.)		       			
	       			ENDIF       			
				ENDIF
			NEXT nlB		  							
		ELSE
			clOrdem := "1"  		
			FOR nlC := 1 TO LEN(alSXA) 		  
				IF alSXA[nlC][1] == alAlias[nlA]									
	   				alSXA[nlC][2]	:= 	clOrdem     				
	   				clOrdem 		:=	RETASC(clOrdem,2,.F.)
	       			clOrdem 		:=	SOMA1(clOrdem)
	       			clOrdem 		:=	RETASC(clOrdem,1,.T.) 
	  			ENDIF   						 						
			NEXT nlC								
		ENDIF		
	NEXT alAlias
	
	SXA->(DBSETORDER(1))
	
	FOR nlA:= 1 TO LEN(alSXA)	
		IF !EMPTY(alSXA[nlA][1])			
			IF RECLOCK("SXA",!(DBSEEK(alSXA[nlA,1]+alSXA[nlA,2])))	
				FOR nlB:=1 TO LEN(alSXA[nlA])					
					IF !EMPTY(FIELDNAME(FIELDPOS(alEstrut[nlB])))
						FIELDPUT(FIELDPOS(alEstrut[nlB]),alSXA[nlA,nlB])
					ENDIF
				NEXT SXA->nlB	  
				SXA->(DBCOMMIT())
				SXA->(MSUNLOCK())
			ENDIF
		ENDIF         	
	NEXT nlA 
	clTxt := OEMTOANSI("Concluํda a atualiza็ใo da SXA") + CRLF	
RETURN clTxt*/	

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณAtuSXB		 บAutor  ณKazoolo             บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da gravacao do SXB					   บฑฑ
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
Static Function AtuSXB()  

	Local alSXB      := {}						//Array que armazenara os indices
	Local alEstrut   := {}				        //Array com a estrutura da tabela SXB
	Local alAlias	 := {}						//Array que contera o Alias da consulta padrao 
	Local nlI        := 0 						//Contador para laco
	Local nlJ        := 0 						//Contador para laco
	Local clTexto	 := ""
	
	alEstrut:= 			{"XB_ALIAS"		, "XB_TIPO"	, "XB_SEQ"	, "XB_COLUNA"	, "XB_DESCRI"																	, "XB_DESCSPA"																	, "XB_DESCENG"																		, "XB_CONTEM"																	, "XB_WCONTEM"	}
	
	//alEstrut:={	"XB_ALIAS"		, "XB_TIPO"	, "XB_SEQ"		, "XB_COLUNA"	, "XB_DESCRI"						, "XB_DESCSPA"						, "XB_DESCENG"						, "XB_CONTEM"																																																															, "XB_WCONTEM"																																																															 	}
	aAdd(alSXB,	{	'SFM'   		,'1'		,'01'			,'DB'			,'Op TES Inteligente'  				,'Op TES Inteligente'  				,'Op TES Inteligente'  				,'SFM'                                                                                                                                                                                                                                                       			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'2'		,'01'			,'01'			,'Tp. Operacao + Produ'				,'Tp.operacion + Produ'				,'Oper. Type + Product'				,''                                                                                                                                                                                                                                                          			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'3'		,'01'			,'01'			,'Cadastra Novo'       				,'Incluye Nuevo'       				,'Add New'             				,'01'                                                                                                                                                                                                                                                        			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'01'			,'Tp. Operacao'        				,'Tp.Operacion'        				,'Oper. Type'          				,'FM_TIPO'                                                                                                                                                                                                                                                   			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'02'			,'Tes Entrada'         				,'Tes Entrada'         				,'Inflow TES'          				,'FM_TE'                                                                                                                                                                                                                                                     			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'03'			,'Tes de Saida'        				,'Tes Salida'          				,'Outflow TES'         				,'FM_TS'                                                                                                                                                                                                                                                     			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'04'			,'Cliente'             				,'Cliente'             				,'Customer'            				,'FM_CLIENTE'                                                                                                                                                                                                                                                			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'05'			,'Loja Cliente'        				,'Tda. Cliente'        				,'Cust. Unit'          				,'FM_LOJACLI'                                                                                                                                                                                                                                                			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'06'			,'Fornecedor'          				,'Proveedor'           				,'Supplier'            				,'FM_FORNECE'                                                                                                                                                                                                                                                			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'4'		,'01'			,'07'			,'Loja Forn.'          				,'Tienda Prov.'        				,'Supplier Uni'        				,'FM_LOJAFOR'                                                                                                                                                                                                                                                			,''                                                                                                                                                                                                                                                          				})
	aAdd(alSXB,	{	'SFM'   		,'5'		,'01'			,''  			,''                    				,''                    				,''                    				,'SFM->FM_TIPO'                                                                                                                                                                                                                                              			,''                                                                                                                                                                                                                                                          				})


	For nlI := 1 To Len(alSXB)
   		If nlI != Len(alSXB)
	   		If AllTrim(alSXB[nlI][1]) <> AllTrim(alSXB[(nlI+1)][1])
		  		aAdd(alAlias,{alSXB[nlI][1]})
			EndIf
		Else
			aAdd(alAlias,{alSXB[nlI][1]})
		EndIf
	Next nlI

	dbSelectArea("SXB")
	SXB->(dbSetOrder(1))
	SXB->(dbGoTop())
	For nlI := 1 To Len(alAlias)
		If SXB->(dbSeek(PadR(alAlias[nlI][1],6)))
			While AllTrim(SXB->XB_ALIAS) == AllTrim(alAlias[nlI][1])
				SXB->(RecLock("SXB",.F.))
					SXB->(dbDelete())
				SXB->(MSUnlock())
				SXB->(dbSkip())
			EndDo
		EndIf
		SXB->(dbGoTop())
	Next nlI

	dbSelectArea("SXB")
	SXB->(dbSetOrder(1))
	For nlI := 1 To Len(alSXB)
		If !Empty(alSXB[nlI,1])	
			RecLock("SXB",!(DbSeek(PadR(alSXB[nlI,1],6)+alSXB[nlI,2]+alSXB[nlI,3]+alSXB[nlI,4])))

			For nlJ :=1 To Len(alSXB[nlI])
				If FieldPos(alEstrut[nlJ]) > 0
					FieldPut(FieldPos(alEstrut[nlJ]),alSXB[nlI,nlJ])
				EndIf
			Next nlJ
			MsUnLock()
		EndIf
	Next nlI

	clTexto := "Concluida a atualizacao da SXB" + CRLF

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