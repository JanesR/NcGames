#INCLUDE "PROTHEUS.CH"
#DEFINE FO_READWRITE 02
#DEFINE FO_EXCLUSIVE 16
#DEFINE X3_USADO_EMUSO "���������������"
#DEFINE X3_USADO_NAOUSADO "���������������"
#DEFINE X3_OBRIGAT "��"
#DEFINE X3_RESER "��"
#DEFINE X3_RESER_NUMERICO "��"
#DEFINE X3_RES	"��"

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �UPDNCG11		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � 														  		   ���
������������������������������������������������������������������������������͹��
���Uso       �NCGames	                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   � 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function UPDNCG11() 

	Local cMsg			:= ""
	
	Local nNum			:= 4 // Numero maximo de progresso da Regua(referente a qntd de atualizacoes - Sx2, Sx3, etc..) 
	Local llStart		:= .F.	
	Local aEmpresas		:= {}
	Local llAbertura	:= .F.	
	Local oError		:= ErrorBlock({|e| MsgStop("Erro encontrado: " + CRLF + e:Description + CRLF + "O Update ser� finalizado.","Erro"),lError := .T.}) 
	Local lError		:= .F. 

	
	Private oSayMsg		:= Nil
	Private cSayMsg		:= OemToAnsi("Preparando Atualiza��o...")
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
			cMsg += "Este programa tem como objetivo ajustar os dicion�rios de dados(campos"
			cMsg += " e parametros) para a implementa��o da melhoria"
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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �SelecEmp		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     �Monta tela de Selecao das empresas que o update ira atuar		   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�aEmpresas - array que ira conter as empresas selecionadas		   ���
������������������������������������������������������������������������������͹��
���Retorno   |llRet - Logico informando se foi cancelado ou esta tudo ok       ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
                                   
		@ 005,005 SAY oTitulo VAR OemToAnsi("Selecione as Empresas que o Update ir� atuar") OF oPanel3 PIXEL FONT (TFont():New('Arial',0,-13,.T.,.T.))

		oList := TWBrowse():New( 20, 10, 180, 80,,{ "", "C�digo", "Empresa","Filial", "Nome Filial" },,oPanel3,,,,,,,,,,,,.F.,,.T.,,.F.,,,)
		oList:SetArray(aEmpresas)
		oList:bLine      := { || { If( aEmpresas[oList:nAT,1], oOk, oNOk ), aEmpresas[oList:nAt,2], aEmpresas[oList:nAT,3],aEmpresas[oList:nAt,4], aEmpresas[oList:nAT,5] } }
		oList:bLDblClick := { || aEmpresas[oList:nAt,1] := !aEmpresas[oList:nAt,1] }

		@ 125,090 BUTTON oBtnCan PROMPT "&Cancelar"   SIZE 45, 14 ACTION (oDlgUpd:End()) OF oDlgUpd PIXEL
		@ 125,145 BUTTON oBtnFin PROMPT "&Iniciar"  SIZE 45, 14 ACTION (Iif(aScan(aEmpresas,{|x| x[1]}) > 0,(llRet := .T. ,oDlgUpd:End()), Alert("Selecione pelo menos uma empresa para prosseguir com o Update"))) OF oDlgUpd PIXEL

  ACTIVATE MSDIALOG oDlgUpd CENTERED 

Return llRet

/* 
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �FProc			 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao dos arquivos 	  		   ���
������������������������������������������������������������������������������͹��
���Uso       �		                                                           ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���  
������������������������������������������������������������������������������͹��
���Retorno   |.T.							                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
	
	Local oError		:= ErrorBlock({|e| MsgStop("Erro encontrado: " + CRLF + e:Description + CRLF + "O Update ser� finalizado.","Erro"),lError := .T.}) 
	Local lError		:= .F. 
		
	Private cPaisLoc := ""    
	
	For nlI := 1 to Len(aEmpresas)
		If aEmpresas[nlI][1]
			aAdd(alAtuEmp,AllTrim(aEmpresas[nlI][2])) 
		EndIf
	Next nlI
	
	/*============= Atualizacao da Regua de Progresso =================*/
	Sleep(2000) // 2 segundos                                          //
	oBarra:Set(0) // inicia a r�gua                                    //
	Conout( "Verificando integridade dos dicion�rios..." )             //
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
				//������������������������������������������Ŀ
				//�Atualiza as perguntas de relatorios.  SX1 �
				//��������������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Dicionario de Perguntas | " + clEmpFil))
				oBarra:Set(++nCurrent)
				
				cSayMsg := OemToAnsi("Atualizando Dicionario de Perguntas... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
					
				cTexto += AtuSX1()
				
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Dicionario de Perguntas | " + clEmpFil))	
            EndSequence*/
            /*
			Begin Sequence			
				//��������������������������������������Ŀ
				//�Atualiza o dicionario de arquivos. SX2�
				//����������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao Dicionario de Arquivos | " + clEmpFil))
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
				//�����������������������������������Ŀ
				//�Atualiza o dicionario de dados. SX3�
				//�������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao Dicionario de Dados | " + clEmpFil))
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
				//��������������������������������������Ŀ
				//�Atualiza tabelas genericas		. SX5�
				//����������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao Dicionario de Tabelas Temporarias| " + clEmpFil))
				oBarra:Set(++nCurrent)	
				
				cSayMsg := OemToAnsi("Atualizando Dicionario de Arquivos... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
			
				cTexto += AtuSX5()
			
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Dicionario de Tabelas Temporarias| " + clEmpFil))	
            EndSequence 
            */           
			Begin Sequence	
				//����������������������������������Ŀ
				//�Atualiza parametros. SX6          �
				//������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao de Parametros | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Par�metros... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				
				cTexto += AtuSX6()
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao de Parametros | " + clEmpFil))	
            EndSequence
            /*	
			Begin Sequence	
				//����������������������������������Ŀ
				//�Atualiza gatilhos. SX7	         �
				//������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao de Gatilhos | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Gatilhos... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				                                                                                                           
				cTexto += AtuSX7()
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao de Gatilhos  | " + clEmpFil))
            EndSequence
            */
			/*
			Begin Sequence	
				//����������������������������������Ŀ
				//�Atualiza as consultas padroes. SXA�
				//������������������������������������
				CONOUT(OEMTOANSI(DTOC( DATE() )+" "+TIME()+" "+ OEMTOANSI("In�cio - Atualiza��o de Folders | ") + clEmpFil))
				oBarra:SET(++nCurrent)	 
			
				cSayMsg := OEMTOANSI("Atualizando Folders... | " + clEmpFil)
				oSayMsg:REFRESH() 
				SLEEP(2000)
				PROCESSMESSAGES()
			
				cTexto += ATUSXA()
			
				CONOUT(OEMTOANSI(DTOC( DATE() )+" "+TIME()+" "+ OEMTOANSI("Fim - Atualiza��o de Folders | ") + clEmpFil))	
            EndSequence
            */			
			/*
			Begin Sequence	
				//����������������������������������Ŀ
				//�Atualiza as consultas padroes. SXB�
				//������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao Consultas Padroes | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando Consultas Padroes... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
			
				cTexto += AtuSXB()
			
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Consultas Padroes | " + clEmpFil))	 
            EndSequence
            */
            /*
			Begin Sequence		
				//������������������������������Ŀ
				//|Atualiza os indices.  SIX     |
				//��������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao �ndices | " + clEmpFil))
				oBarra:Set(++nCurrent)	 
				
				cSayMsg := OemToAnsi("Atualizando �ndices... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
				
				cTexto += AtuSIX()   
				
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao �ndices | " + clEmpFil))	
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
		
		//��������������������������������������������������������������������Ŀ
		//�Chamar o alias de todas as tabelas alteradas para for�ar a cria��o  �
		//����������������������������������������������������������������������
				
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
		
		/*
		Begin Sequence	
			//������������������������������Ŀ
			//�Atualiza Menu.                �
			//��������������������������������
			//������������������������������Ŀ
			Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Atualizacao Menu  "))
			oBarra:Set(++nCurrent)	 
			
			cSayMsg := OemToAnsi("Atualizando Menus...  ")
			oSayMsg:Refresh() 
			Sleep(2000)
			ProcessMessages()
		
			cTexto += AtuMenu()
			Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Atualizacao Menu  "))	
			//�������������������������������		
  		EndSequence
  		*/
  			
		Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Atualiza��o Conclu�da."))
		oBarra:Set(++nCurrent) 
		
		cSayMsg := "Atualiza��o Conclu�da."
		oSayMsg:Refresh() 
		Sleep(2000)
		ProcessMessages()
	
		cTexto += "Atualiza��o Conclu�da."
		
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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSIX		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SIX 			  		   ���
������������������������������������������������������������������������������͹��
���Uso       �SigaFin                                                          ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���  
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
/*  
Static Function AtuSIX()
	Local alSix      		:= {}			//Array que armazenara os �ndices
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
	Local alSetDeleted		:= {"SZ1"}

	Local clAliAtu	:= " "
	Local nlPos		:= 0  

	Local clTexto	 := ""
     
	alEstrut:= {"INDICE"		,"ORDEM"	,"CHAVE"																																							,"DESCRICAO"																,"DESCSPA"																	,"DESCENG"																	,"PROPRI"	,"F3"																																								,"NICKNAME"		,"SHOWPESQ"}	

	alDeleta := {} 	

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
*/

/* 
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSX1		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao dos SX1 					   ���
������������������������������������������������������������������������������͹��
���Uso       �SigaCtb                                                          ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���  
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������

Static Function AtuSX1()

	Local nlI := 0
	Local nlJ := 0
    Local clTexto	:= ""

	Local alSX1	:= {}
	Local alEstrut 	:= 	{"X1_GRUPO"			,"X1_ORDEM"	,"X1_PERGUNT"						,"X1_PERSPA"						,"X1_PERENG"						,"X1_VARIAVL"	,"X1_TIPO"	,"X1_TAMANHO"	,"X1_DECIMAL"	,"X1_PRESEL"	,"X1_GSC"	,"X1_VALID"														,"X1_VAR01"			,"X1_DEF01"			,"X1_DEFSPA1"		,"X1_DEFENG1"		,"X1_CNT01"														,"X1_VAR02"			,"X1_DEF02"			,"X1_DEFSPA2"		,"X1_DEFENG2"		,"X1_CNT02"														,"X1_VAR03"			,"X1_DEF03"			,"X1_DEFSPA3"		,"X1_DEFENG3"		,"X1_CNT03"														,"X1_VAR04"			,"X1_DEF04"			,"X1_DEFSPA4"		,"X1_DEFENG4"		,"X1_CNT04"														,"X1_VAR05"			,"X1_DEF05"			,"X1_DEFSPA5"		,"X1_DEFENG5"	,"X1_CNT05"														,"X1_F3"	,"X1_PYME"	,"X1_GRPSXG"	,"X1_HELP"			,"X1_PICTURE"								,"X1_IDFIL"	}    

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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSX2		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SX2					   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
/* 
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
/* 
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSX3		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SX3					   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
  	
  	alEstrut:=  {	"X3_ARQUIVO"	,"X3_ORDEM" ,"X3_CAMPO"    	,"X3_TIPO" 	,"X3_TAMANHO"  	,"X3_DECIMAL"  	,"X3_TITULO"    			,"X3_TITSPA"   				,"X3_TITENG"   			 	,"X3_DESCRIC"                 			,"X3_DESCSPA"                  	   		,"X3_DESCENG"                 			,"X3_PICTURE"                                  	 	,"X3_VALID"                                                                                                                    		,"X3_USADO"        	,"X3_RELACAO"                                                                                                                 	,"X3_F3"   	,"X3_NIVEL" ,"X3_RESERV"  	,"X3_CHECK"	,"X3_TRIGGER"  	,"X3_PROPRI"  	,"X3_BROWSE" 	,"X3_VISUAL"  	,"X3_CONTEXT" 	,"X3_OBRIGAT"   ,"X3_VLDUSER"                                                                                                                     	,"X3_CBOX"                                                                                                                       	,"X3_CBOXSPA"                                                                                                                      	,"X3_CBOXENG"                                                                                                                      	,"X3_PICTVAR"       	,"X3_WHEN"                                                  	,"X3_INIBRW"                                                           				,"X3_GRPSXG"  	,"X3_FOLDER"	,"X3_PYME" 	,"X3_CONDSQL"                                                                                                                                                                                                                                                  ,"X3_CHKSQL"                                                                                                                                                                                                                                                   	,"X3_IDXSRV"	,"X3_ORTOGRA"  	,"X3_IDXFLD"	,"X3_TELA"         		}
    
    aAdd(alAlias,"SC5")
	aAdd(alSX3,	{	'SC5'       	,''    		,'C5_NUMEDI'	,'C'      	,20           	,0           	,'Num Ped EDI'  			,'Num Ped EDI'  			,'Num Ped EDI'  			,'Num Ped EDI' 	   						,'Num Ped EDI'    						,'Num Ped EDI'    						,'@!'                                        	   	,''                                                                                                                                	,X3_USADO_EMUSO		,''                                                                                                                            	,''      	,1         	,'��'       	,''        	,''          	,'U'        	,'S'        	,'V'        	,'R'         	,''   			,''                                                                                                                                	,''                                                                                                                     		  	,''                                                                                                           			        	 ,''                                                                                                                     			,''                    	,''                                                            	,''                                                                                	,''         	,''         	,''       	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''         	,'N'         	,'N'        	,''              		}) 
    
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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSX5		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SX5 - Tab.Generica	   ���
������������������������������������������������������������������������������͹��
���Uso       �		                                                           ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSX6		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SX6 - Parametros	       ���
������������������������������������������������������������������������������͹��
���Uso       �		                                                           ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function AtuSX6()

	Local alSx6       := {}						//Array que armazenara os �ndices
	Local alEstrut    := {}				        //Array com a estrutura da tabela SX6
	Local nlI         := 0 						//Contador para laco
	Local nlJ         := 0 						//Contador para laco
	Local clTexto	  := ""	        

    alEstrut :=		{	'X6_FIL'	,'X6_VAR'    	,'X6_TIPO'	,'X6_DESCRIC'                                        	,'X6_DSCSPA'                                         	,'X6_DSCENG'                                         	,'X6_DESC1'                                          	,'X6_DSCSPA1'                                        	,'X6_DSCENG1'                                        	,'X6_DESC2'                                          	,'X6_DSCSPA2'                                        	,'X6_DSCENG2'                                        	,'X6_CONTEUD'                                                 	,'X6_CONTSPA'                                              	,'X6_CONTENG'                                                  	,'X6_PROPRI'	,'X6_PYME'	,'X6_VALID'                                                                                                                        	,'X6_INIT'                                                                                                                         	,'X6_DEFPOR'                                                                                                                                                                                                                                                 	,'X6_DEFSPA'                                                                                                                                                                                                                                                 	,'X6_DEFENG'                                                                                                                                                                                                                                                 		}
	
	aAdd(alSX6,		{	''      	,'KZ_PARCMIN'	,'N'      	,'Parcela m�nima'	 									,'Parcela m�nima'	 									,'Parcela m�nima'										,''				 										,''				 										,''	 													,''                                                  	,''                                                  	,''                                                  	,'500'                  										,'500'                  									,'500'                  										,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})

	// Parametro ja existente nos SX's da NCGames
	
	aAdd(alSX6,		{	''      	,'MV_VLMAXPV'	,'N'      	,'Valor Maximo'				 							,'Valor Maximo'						 					,'Valor Maximo'						  					,''				 										,''				 										,''				 										,''                                                  	,''                                                  	,''                                                  	,'80000' 			   											,'80000' 			   										,'80000' 			   											,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
	aAdd(alSX6,		{	''      	,'MV_MAXITPV'	,'N'      	,'Quantidade Maxima'		 							,'Quantidade Maxima'		 							,'Quantidade Maxima'		 							,''				 										,''				 										,''				 										,''                                                  	,''                                                  	,''                                                  	,'40' 				   											,'40' 	   			   										,'40' 			   												,'U'        	,''       	,''                                                                                                                                	,''                                                                                                                                	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          	,''                                                                                                                                                                                                                                                          		})
		
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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSX7		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SX7 - Gatilhos	  	   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuMenu		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da atualizacao do(s) menu(s)			   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
	Local clMenu		:= 'R�guas de Cobran�a'		   	// nome do grupo de menu   
	Local clMenu2		:= 'Cadastros'	   				// nome do grupo de menu de relat�rios
	Local clMenu3		:= 'Relat�rios'
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
		clRet	:=	"N�o foi poss�vel abrir o arquivo de menu."
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
					                            
	aAdd(alMenuInc,{{OemToAnsi("Cartas de Cobran�as")   ,OemToAnsi("Cartas de Cobran�as")		,OemToAnsi("Cartas de Cobran�as")   	},"U_KZURC100" 		}) 
	aAdd(alMenuInc,{{OemToAnsi("Tabela de Notifica��o") ,OemToAnsi("Tabela de Notifica��o")		,OemToAnsi("Tabela de Notifica��o")   	},"U_KZURC102" 		}) 				
	aAdd(alMenuInc,{{OemToAnsi("Cadastro de R�guas")   	,OemToAnsi("Cadastro de R�guas")		,OemToAnsi("Cadastro de Reguas")		},"U_KZURC200" 		}) 				
	aAdd(alMenuInc,{{OemToAnsi("Fases de Cobran�a")   	,OemToAnsi("Fases de Cobran�a")			,OemToAnsi("Fases de Cobran�a") 		},"U_KZURC300" 		})
	aAdd(alMenuInc,{{"Feriados"			   	   			,"Feriados"			   	   				,"Feriados"  	 			   			},"U_KZURC400" 		})   
	aAdd(alMenuInc,{{"Filtros Por Fatura"		   	   	,"Filtros Por Fatura"					,"Filtros Por Fatura"	 				},"U_KZURC700"		}) 	  	
	aAdd(alMenuInc,{{"Cadastro Gestores"			   	,"Cadastro Gestores"					,"Cadastro Gestores"	 				},"U_KZURC800"		}) 	  
	aAdd(alMenuInc,{{"Cadastro de Equipes"			   	,"Cadastro de Equipes"					,"Cadastro de Equipes"	 				},"U_KZURC900"		}) 	  
	aAdd(alMenuInc,{{OemToAnsi("Reatribui��o Gestor")  	,OemToAnsi("Reatribui��o de Gestor")	,OemToAnsi("Reatribui��o de Gestor")	},"U_KZURC010"		}) 	  	
	aAdd(alMenuInc,{{"Filtro de Clientes"		   		,"Filtro de Clientes"					,"Filtro de Clientes"					},"U_KZURC600"		})
	aAdd(alMenuInc,{{"Motivo Filtro"					,"Motivo Filtro"						,"Motivo Filtro"						},"U_KZURC018"		})
	aAdd(alMenuInc,{{"Modelo de Cartas"	 				,"Modelo de Cartas"	 					,"Modelo de Cartas"	 					},"U_KZURC019"	 	})		
	aAdd(alMenuInc,{{OemToAnsi("Tabela de Pend�ncias")	,OemToAnsi("Tabela de Pend�ncias")		,OemToAnsi("Tabela de Pend�ncias")		},"U_KZURC012"		}) 
	aAdd(alMenuInc,{{OemToAnsi("Consulta de T�tulo")	,OemToAnsi("Consulta de T�tulo")		,OemToAnsi("Consulta de T�tulo")		},"U_KZURC015"		}) 
	aAdd(alMenuInc,{{OemToAnsi("Resumo de T�tulo")		,OemToAnsi("Resumo de T�tulo")	   		,OemToAnsi("Resumo de T�tulo")	   		},"U_KZURC014"		}) 	
	
	aAdd(alMenuRel,{{OemToAnsi("Pend�ncias")	 		,OemToAnsi("Pend�ncias")	   			,OemToAnsi("Pend�ncias")			   	},"U_KZURC021"		}) 
	aAdd(alMenuRel,{{OemToAnsi("Baixas X Pend�ncias")	,OemToAnsi("Baixas X Pend�ncias")		,OemToAnsi("Baixas X Pend�ncias")		},"U_KZURCR270"		})
	aAdd(alMenuRel,{{OemToAnsi("Filtros de Clientes")	,OemToAnsi("Filtros de Clientes")		,OemToAnsi("Filtros de Clientes")		},"U_KZURC016"		})
	aAdd(alMenuRel,{{OemToAnsi("R�gua Por Per�odo")		,OemToAnsi("R�gua Por Per�odo")	  		,OemToAnsi("R�gua Por Per�odo")		   	},"U_KZURC023"		})
	aAdd(alMenuRel,{{OemToAnsi("Clientes VIPs")	   		,OemToAnsi("Clientes VIPs")		   		,OemToAnsi("Clientes VIPs")		  		},"U_KZURC025"		})
	aAdd(alMenuRel,{{OemToAnsi("Clientes Bloqueados")	,OemToAnsi("Clientes Bloqueados")		,OemToAnsi("Clientes Bloqueados")		},"U_KZURC022"		}) 	  	 	  		
	aAdd(alMenuRel,{{OemToAnsi("Situa��o de T�tulos")	,OemToAnsi("Situa��o de T�tulos") 		,OemToAnsi("Situa��o de T�tulos")		},"U_KZURC020"		}) 	  	 	  		
	aAdd(alMenuRel,{{OemToAnsi("Filtros Por Fatura") 	,OemToAnsi("Filtros Por Fatura")  		,OemToAnsi("Filtros Por Fatura")		},"U_KZURC017"		}) 	  	 	  		
	aAdd(alMenuRel,{{OemToAnsi("Hist�rico Cobran�a")	,OemToAnsi("Hist�rico Cobran�a") 		,OemToAnsi("Hist�rico Cobran�a") 		},"U_KZURC028"		}) 	  	 	  			 	  	
						
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
	
	clRet := 'O menu do m�dulo SigaFIN foi atualizado. Arquivo de backup gerado: "' + clBackup + '"' + CRLF 

		
Return clRet*/ 
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSXA		 �Autor  �Denis S. Naves	  � Data � 12/08/11    ���
������������������������������������������������������������������������������͹��
���Desc.     �Atualiza Folders 												   ���
������������������������������������������������������������������������������͹��
���Uso       �		                                                           ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���  
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������

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
	AADD(alSXA,{"SA1","5",OEMTOANSI("R�gua")	,OEMTOANSI("R�gua")		,OEMTOANSI("R�gua")		,"U"})		
	
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
	clTxt := OEMTOANSI("Conclu�da a atualiza��o da SXA") + CRLF	
RETURN clTxt*/	

/* 
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �AtuSXB		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao de processamento da gravacao do SXB					   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   | 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
 
Static Function AtuSXB()  

	Local alSXB      := {}						//Array que armazenara os indices
	Local alEstrut   := {}				        //Array com a estrutura da tabela SXB
	Local alAlias	 := {}						//Array que contera o Alias da consulta padrao 
	Local nlI        := 0 						//Contador para laco
	Local nlJ        := 0 						//Contador para laco
	Local clTexto	 := ""
	
	alEstrut:= 			{"XB_ALIAS"		, "XB_TIPO"	, "XB_SEQ"	, "XB_COLUNA"	, "XB_DESCRI"																	, "XB_DESCSPA"																	, "XB_DESCENG"																		, "XB_CONTEM"																	, "XB_WCONTEM"	}

	aAdd(alSXB,			{'SE1TIT'		,'1'		,'01'		,'DB'			,'Titulo vencido'																,'Titulo vencido'																,'Titulo vencido'																	,'SE1'																			,''				})
	aAdd(alSXB,			{'SE1TIT'		,'2'		,'01'		,'01'			,'No. Titulo'																	,'Num. Titulo'																	,'Bill Number'																		,''																				,''				})
	aAdd(alSXB,			{'SE1TIT'		,'4'		,'01'		,'01'			,'No. Titulo'																	,'Num. Titulo'																	,'Bill Number'																		,'E1_NUM'																		,''				})
	aAdd(alSXB,			{'SE1TIT'		,'4'		,'01'		,'02'			,'Prefixo'																		,'Prefijo'																		,'Prefix'																			,'E1_PREFIXO'																	,''				})
	aAdd(alSXB,			{'SE1TIT'		,'5'		,'01'		,''				,''																				,''																				,''																					,'SE1->E1_NUM'																	,''				})
	aAdd(alSXB,			{'SE1TIT'		,'5'		,'02'		,''				,''																				,''																				,''																					,'SE1->E1_PREFIXO'																,''				})
	
	aAdd(alSXB,			{'Z03'			,'1'		,'01'		,'DB'			,'C�digo da R�gua'																,'C�digo da R�gua'																,'C�digo da R�gua'																	,'Z03'																			,''				})
	aAdd(alSXB,			{'Z03'	   		,'2'		,'01'		,'01'			,'Cod.Regua'																	,'Cod.Regua'																	,'Cod.Regua'																		,''																				,''				})
   	aAdd(alSXB,			{'Z03'			,'3'		,'01'		,'01'			,'Cadastra Novo'	   															,'Cadastra Novo'																,'Cadastra Novo'							  										,'01'																			,''				})    
	aAdd(alSXB,			{'Z03'	   		,'4'		,'01'		,'01'			,'Cod.Regua'																	,'Cod.Regua'																	,'Cod.Regua'																		,'Z03_CODREG'																	,''				})
	aAdd(alSXB,			{'Z03'			,'4'		,'01'		,'02'			,'Nome'																			,'Nome'																	   		,'Nome'																		   		,'Z03_NOME'																   		,''				})
	aAdd(alSXB,			{'Z03'	   		,'5'		,'01'		,''				,''																				,''																				,''																					,'Z03->Z03_CODREG'																,''				})
	
	aAdd(alSXB,			{'KFTIT'		,'1'		,'01'		,'DB'			,'titulos'						  												,'titulos'															  			,'titulos'																 			,'SE1'																			,''				})
	aAdd(alSXB,			{'KFTIT'   		,'2'		,'01'		,'01'			,'Prefixo + No. Titulo'															,'Prefijo + Num. Titul'															,'Prefix + Bill Number'																,''																				,''				})
	aAdd(alSXB,			{'KFTIT'   		,'4'		,'01'		,'01'			,'Filial'  																		,'Sucursal'																		,'Branch'																			,'E1_FILIAL'																	,''				})
	aAdd(alSXB,			{'KFTIT'		,'4'		,'01'		,'02'			,'No. Titulo'																	,'Num. Titulo'																	,'Bill Number'																		,'E1_NUM'																   		,''				})
	aAdd(alSXB,			{'KFTIT'		,'4'		,'01'		,'03'			,'Prefixo'																		,'Prefijo'																	   	,'Prefix'																		   	,'E1_PREFIXO'															   		,''				})
	aAdd(alSXB,			{'KFTIT'   		,'5'		,'01'		,''				,''																				,''																				,''																					,'SE1->E1_NUM'																	,''				})
	
	aAdd(alSXB,			{'Z12'			,'1'		,'01'		,'DB'			,'Gestores'						  												,'Gestores'															  			,'Gestores'																 			,'Z12'																			,''				})	
	aAdd(alSXB,			{'Z12'   		,'2'		,'01'		,'03'			,'Cpf do Gestor'																,'Cpf do Gestor'																,'Cpf do Gestor'																	,''																				,''				})
	aAdd(alSXB,			{'Z12'   		,'2'		,'02'		,'02'			,'Nome do Gestor'  																,'Nome do Gestor'																,'Nome do Gestor'																	,''																				,''				})
	aAdd(alSXB,			{'Z12'			,'4'		,'01'		,'01'			,'Cod. Gestor'																	,'Cod. Gestor'																	,'Cod. Gestor'																		,'Z12_CODIGO'																   	,''				})
	aAdd(alSXB,			{'Z12'			,'4'		,'01'		,'02'			,'Nome'																			,'Nome'																		   	,'Nome'																			   	,'Z12_NOME'																   		,''				})
	aAdd(alSXB,			{'Z12'   		,'4'		,'01'		,'03'			,'CPF'																			,'CPF'																			,'CPF'																				,'Z12_CPF'																		,''				})
	aAdd(alSXB,			{'Z12'   		,'4'		,'02'		,'01'			,'Filial'																		,'Filial'																		,'Filial'																			,'Z12_FILIAL'																	,''				})	
	aAdd(alSXB,			{'Z12'   		,'4'		,'02'		,'02'			,'Nome'																			,'Nome'																			,'Nome'																				,'Z12_NOME'																		,''				})
	aAdd(alSXB,			{'Z12'   		,'4'		,'02'		,'03'			,'CPF'																			,'CPF'																			,'CPF'																				,'Z12_CPF'																		,''				})		
	aAdd(alSXB,			{'Z12'   		,'5'		,'01'		,''				,''																		   		,''																				,''																					,'Z12->Z12_CPF'																	,''				})			
	aAdd(alSXB,			{'Z12'   		,'5'		,'02'		,''				,''																		   		,''																				,''																					,'Z12->Z12_NOME'																,''				})
	
	aAdd(alSXB,			{'SA1CPF'		,'1'		,'01'		,'DB'			,'CPF'			  	   															,'CPF'														   					,'CPF'	   																			,'SA1'																			,''				})
	aAdd(alSXB,			{'SA1CPF'  		,'2'		,'01'		,'03'			,'Cnpj/Cpf'		  																,'Cnpj/Cpf'										   								,'Cnpj/Cpf'												   							,''																				,''				})
	aAdd(alSXB,			{'SA1CPF'  		,'2'		,'02'		,'01'			,'Codigo + Loja'  																,'Codigo + Tienda'																,'Code + Unit' 																		,''																  				,''				})
	aAdd(alSXB,			{'SA1CPF'  		,'2'		,'03'		,'02'			,'Nome'		   	 																,'Nome'								  											,'Nome'																			,''																				,''				})
	aAdd(alSXB,			{'SA1CPF'  		,'4'		,'01'		,'01'			,'Codigo'  												  						,'Codigo'																		,'Codigo'															   				,'A1_COD'																		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'01'		,'02'			,'Loja'	   												   						,'Tienda'  																		,'Unit'										  										,'A1_LOJA'										   	   							,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'01'		,'03'			,'Nome'																  			,'Nombre'  												   						,'Unit'																				,'A1_NOME'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'01'		,'04'			,'CNPJ/CPF'																		,'CNPJ/CPF'												   						,'CNPJ/CPF'										   									,'A1_CGC'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'02'		,'01'			,'Codigo'  																  		,'Codigo'  														   				,'Code'											 									,'A1_COD'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'02'		,'02'			,'Loja'	   																 		,'Tienda'																		,'Unit'	   										  									,'A1_LOJA'										   	   							,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'02'		,'03'			,'Nome'	   														  	   			,'Nombre'  							   											,'Unit'											   									,'A1_NOME'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'02'		,'04'			,'CNPJ/CPF'												   						,'CNPJ/CPF'												 						,'CNPJ/CPF'																			,'A1_CGC'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'03'		,'01'			,'Codigo'																		,'Codigo'												 						,'Code'														 						,'A1_COD'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'03'		,'02'			,'Loja'																			,'Tienda'										 								,'Unit'																				,'A1_LOJA'										   	   							,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'03'		,'03'			,'Nome'	   																		,'Nombre'											 							,'Unit'												   	   							,'A1_NOME'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'		,'4'		,'03'		,'04'			,'CNPJ/CPF'											 							,'CNPJ/CPF'											 							,'CNPJ/CPF'											 								,'A1_CGC'		 														   		,''				})
	aAdd(alSXB,			{'SA1CPF'  		,'5'		,'01'		,''				,''		   																		,''		   																		,''		   																			,'SA1->A1_CGC'																	,''				})
                                                                                                                                   		
	aAdd(alSXB,			{'Z12NOM'		,'1'		,'01'		,'DB'			,'Nome do Gestor'						  							  			,'Nome do Gestor'																,'Nome do Gestor'													   				,'Z12'																			,''				})
	aAdd(alSXB,			{'Z12NOM'  		,'2'		,'01'		,'02'			,'Nome do Gestor'																,'Nome do Gestor'														   		,'Nome do Gestor'															 		,''																				,''				})
	aAdd(alSXB,			{'Z12NOM'  		,'2'		,'01'		,'03'			,'Cpf do Gestor'																,'Cpf do Gestor'														   		,'Cpf do Gestor'															 		,''																				,''				})
	aAdd(alSXB,			{'Z12NOM'  		,'4'		,'01'		,'01'			,'Cod.Gestor'  																	,'Cod.Gestor'																	,'Cod.Gestor'																		,'Z12_CODIGO'																	,''				})
	aAdd(alSXB,			{'Z12NOM'		,'4'		,'01'		,'02'			,'Nome'															   				,'Nome'																   			,'Nome'																	   			,'Z12_NOME'																   		,''				})
	aAdd(alSXB,			{'Z12NOM'		,'4'		,'01'		,'03'			,'CPF'																			,'CPF'																	   		,'CPF'																		   		,'Z12_CPF'		 														   		,''				})
	aAdd(alSXB,			{'Z12NOM'  		,'4'		,'02'		,'01'			,'Cod.Gestor'  																	,'Cod.Gestor'																	,'Cod.Gestor'																		,'Z12_CODIGO'																	,''				})
	aAdd(alSXB,			{'Z12NOM'		,'4'		,'02'		,'02'			,'Nome'															   				,'Nome'																   			,'Nome'																	   			,'Z12_NOME'																   		,''				})
	aAdd(alSXB,			{'Z12NOM'		,'4'		,'02'		,'03'			,'CPF'																			,'CPF'																	   		,'CPF'																		   		,'Z12_CPF'		 														   		,''				})
	aAdd(alSXB,			{'Z12NOM'  		,'5'		,'01'		,''				,''																				,''																				,''																					,'Z12->Z12_CPF'																	,''				})
	
	aAdd(alSXB,			{'Z16'	     	,'1'      	,'01'    	,'DB'       	,'Motivos de Filtros'  															,'Motivos de Filtros'  															,'Motivos de Filtros'  																,'Z16'                                                                         	,''            	})
	aAdd(alSXB,			{'Z16'  	   	,'2'      	,'01'    	,'01'       	,'Codigo'             														 	,'Codigo'              															,'Codigo'              																,''                                                                            	,''            	})
	aAdd(alSXB,			{'Z16'     		,'4'      	,'01'    	,'01'       	,'Codigo'              															,'Codigo'              															,'Codigo'              																,'Z16_CODIGO'                                                                   ,''  			})
	aAdd(alSXB,			{'Z16'     		,'4'      	,'01'    	,'02'       	,'Motivo'              															,'Motivo'              															,'Motivo'              																,'Z16_MOTIVO'                                                                  	,''   			})
	aAdd(alSXB,			{'Z16'     		,'5'      	,'01'    	,''         	,''                    															,''                    															,''                    																,'Z16->Z16_CODIGO'                                                            	,'' 			})

//	alEstrutura :=		{'XB_ALIAS'		,'XB_TIPO'	,'XB_SEQ'	,'XB_COLUNA'	,'XB_DESCRI'           															,'XB_DESCSPA'          															,'XB_DESCENG'          														  		,'XB_CONTEM'                                                                    ,'XB_WCONTEM'   }
   
	aAdd(alSXB,			{'Z11'     		,'1'      	,'01'    	,'DB'       	,'Codigo do Filtro'    															,'Codigo do Filtro'    															,'Codigo do Filtro'    														 		,'Z11'                                                                          ,''             })
	aAdd(alSXB,			{'Z11'     		,'2'      	,'01'    	,'01'       	,'Codigo'              															,'Codigo'              															,'Codigo'              														 		,''                                                                             ,''             })
	aAdd(alSXB,			{'Z11'     		,'4'      	,'01'    	,'01'       	,'Filial'              															,'Sucursal'            															,'Branch'              														 		,'Z11_FILIAL'                                                                   ,''             })
	aAdd(alSXB,			{'Z11'    	 	,'4'      	,'01'    	,'02'       	,'Codigo'              															,'Codigo'              															,'Codigo'              																,'Z11_CODIGO'                                                                   ,'O'            })
	aAdd(alSXB,			{'Z11'    	 	,'4'      	,'01'    	,'03'       	,'Nome'                															,'Nome'                															,'Nome'                																,'Z11_NOME'                                                                     ,'ME'           })
	aAdd(alSXB,			{'Z11'	     	,'5'      	,'01'    	,''         	,''                    															,''                    															,''                   														 		,'Z11->Z11_CODIGO'                                                              ,''             })

	aAdd(alSXB,			{'SE1PRE'  		,'1'      	,'01'    	,'DB'       	,'Prefixo'             															,'Prefixo'             															,'Prefixo'             													  			,'SE1'                                                                          ,''             })
	aAdd(alSXB,			{'SE1PRE'  		,'2'      	,'01'    	,'01'       	,'Prefixo + No. Titulo'															,'Prefijo + Num. Titul'															,'Prefix + Bill Number'													   			,''                                                                             ,''             })
	aAdd(alSXB,			{'SE1PRE'  		,'4'      	,'01'    	,'01'       	,'Filial'              															,'Sucursal'            															,'Branch'              														 		,'E1_FILIAL'                                                                    ,''             })
	aAdd(alSXB,			{'SE1PRE'  		,'4'      	,'01'    	,'02'       	,'Prefixo'             															,'Prefijo'             															,'Prefix'              																,'E1_PREFIXO'                                                                   ,'O'            })
	aAdd(alSXB,			{'SE1PRE'  		,'4'      	,'01'    	,'03'       	,'No. Titulo'          															,'Num. Titulo'         															,'Bill Number'         														  		,'E1_NUM'                                                                       ,'UM'           })
	aAdd(alSXB,			{'SE1PRE'  		,'5'      	,'01'    	,''         	,''                    															,''                    															,''                    														  		,'SE1->E1_PREFIXO'                                                              ,''             })

	aAdd(alSXB,			{'Z04'   		,'1'		,'01'		,'DB'			,'Fases'               															,'Fases'               															,'Fases'               																,'Z04'                                                                 			,''             })
	aAdd(alSXB,			{'Z04'   		,'2'		,'01'		,'02'			,'Cod.regua+cod.fase'  															,'Cod.regua+cod.fase'  															,'Cod.regua+cod.fase'  																,''                                                                             ,''             })
	aAdd(alSXB,			{'Z04'   		,'4'		,'01'		,'01'			,'Cod.Regua'           															,'Cod.Regua'           															,'Cod.Regua'           																,'Z04_CODREG'                                                                   ,''             })
	aAdd(alSXB,			{'Z04'   		,'4'		,'01'		,'02'			,'Cod.Fase'            															,'Cod.Fase'            															,'Cod.Fase'            														   		,'Z04_CODFAS'                                                                   ,''             })
	aAdd(alSXB,			{'Z04'   		,'4'		,'01'		,'03'			,'Nome'                															,'Nome'                															,'Nome'                														   		,'Z04_NOME'                                                                     ,''             })
	aAdd(alSXB,			{'Z04'   		,'5'		,'01'		,''  			,''                    															,''                    															,''                    														   		,'Z04->Z04_CODFAS'                                                              ,''             })
	aAdd(alSXB,			{'Z04'   		,'5'		,'02'		,''  			,''                    															,''                    															,''                    														   		,'Z04->Z04_CODREG'                                                              ,''             })	
	
	aAdd(alSXB,			{'Z06'   		,'1'		,'01'		,'DB'			,'Historico de Filtros' 														,'Historico de Filtros'               											,'Historico de Filtros'               												,'Z06'                                                                 			,''             })
	aAdd(alSXB,			{'Z06'   		,'2'		,'01'		,'01'			,'Codigo+titulo+prefix' 														,'Codigo+titulo+prefix'  														,'Codigo+titulo+prefix'  															,''                                                         	                ,''             })
	aAdd(alSXB,			{'Z06'   		,'4'		,'01'		,'01'			,'Codigo'           															,'Codigo'           															,'Codigo'           																,'Z06_CODIGO'                                                                   ,''             })
	aAdd(alSXB,			{'Z06'   		,'4'		,'01'		,'02'			,'Data Inicial'         														,'Data Inicial'            														,'Data Inicial'            													   		,'Z06_DTINI'                                            	                    ,''             })
	aAdd(alSXB,			{'Z06'   		,'4'		,'01'		,'03'			,'Data Final'          															,'Data Final'                													,'Data Final'                												   		,'Z06_DTFIM'                                         	                        ,''             })
	aAdd(alSXB,			{'Z06'   		,'4'		,'01'		,'04'			,'Titulo'              															,'Titulo'                														,'Titulo'                													   		,'Z06_TITULO'                                                                	,''             })
	aAdd(alSXB,			{'Z06'   		,'4'		,'01'		,'05'			,'Prefixo'             															,'Prefixo'                														,'Prefixo'                													   		,'Z06_PREFIX'                                                                   ,''             })
	aAdd(alSXB,			{'Z06'   		,'5'		,'01'		,''  			,''                    															,''                    															,''                    														   		,'Z06->Z06_CODIGO'                                                              ,''             })
		
	aAdd(alSXB,			{'SA1COD'		,'1'		,'01'		,'DB'			,'Codigo Cliente'						  							  			,'Codigo Cliente'																,'Codigo Cliente'													   				,'SA1'																			,''				})
	aAdd(alSXB,			{'SA1COD'  		,'2'		,'01'		,'01'			,'Codigo + Loja'																,'Codigo + Tienda'												   				,'Code + Unit'																 		,''																				,''				})
	aAdd(alSXB,			{'SA1COD'  		,'2'		,'02'		,'02'			,'Nome + Loja'																	,'Nombre + Tienda'												   				,'Name + Unit'																 		,''																				,''				})
	aAdd(alSXB,			{'SA1COD'  		,'4'		,'01'		,'01'			,'Codigo'  																		,'Codigo'																		,'Code'																				,'A1_COD'																		,''				})
	aAdd(alSXB,			{'SA1COD'		,'4'		,'01'		,'02'			,'Loja'															   				,'Tienda'																   		,'Unit'																	   			,'A1_LOJA'																   		,''				})
	aAdd(alSXB,			{'SA1COD'		,'4'		,'01'		,'03'			,'Nome'																			,'Nome'																	   		,'Nome'																		   		,'A1_NOME'		 														   		,''				})
	aAdd(alSXB,			{'SA1COD'		,'4'		,'01'		,'04'			,'CNPJ/CPF'																		,'CNPJ/CPF'																	   	,'CNPJ/CPF'																		   	,'A1_CGC'		 														   		,''				})
	aAdd(alSXB,			{'SA1COD'  		,'4'		,'02'		,'01'			,'Codigo'  																		,'Codigo'																		,'Code'																				,'A1_COD'																		,''				})
	aAdd(alSXB,			{'SA1COD'		,'4'		,'02'		,'02'			,'Loja'															   				,'Tienda'																   		,'Unit'																	   			,'A1_LOJA'																   		,''				})
	aAdd(alSXB,			{'SA1COD'		,'4'		,'02'		,'03'			,'Nome'																			,'Nome'																	   		,'Nome'																		   		,'A1_NOME'		 														   		,''				})
	aAdd(alSXB,			{'SA1COD'		,'4'		,'02'		,'04'			,'CNPJ/CPF'																		,'CNPJ/CPF'																	   	,'CNPJ/CPF'																		   	,'A1_CGC'		 														   		,''				})
	aAdd(alSXB,			{'SA1COD'  		,'5'		,'01'		,''				,''																				,''																				,''																					,'SA1->A1_COD'																	,''				})
	
	aAdd(alSXB,			{'Z12COD'		,'1'		,'01'		,'DB'			,'Gestores'						  												,'Gestores'															  			,'Gestores'																 			,'Z12'																			,''				})
	aAdd(alSXB,			{'Z12COD'  		,'2'		,'01'		,'03'			,'Cpf do Gestor'																,'Cpf do Gestor'																,'Cpf do Gestor'																	,''																				,''				})
	aAdd(alSXB,			{'Z12COD'  		,'4'		,'01'		,'01'			,'Cod. Gestor'  																,'Cod. Gestor'																	,'Cod. Gestor' 																		,'Z12_CODIGO'																	,''				})
	aAdd(alSXB,			{'Z12COD'		,'4'		,'01'		,'02'			,'Nome'																			,'Nome'																			,'Nome'																				,'Z12_NOME'																   		,''				})
	aAdd(alSXB,			{'Z12COD'		,'4'		,'01'		,'03'			,'CPF'																			,'CPF'																		   	,'CPF'																			   	,'Z12_CPF'																   		,''				})
	aAdd(alSXB,			{'Z12COD'  		,'5'		,'01'		,''				,''																				,''																				,''																					,'Z12->Z12_CODIGO'																,''				})

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

Return clTexto*/

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �MyOpenSM0		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � Realiza abertura do SIGAMAT.EMP de forma exclusiva   		   ���
������������������������������������������������������������������������������͹��
���Uso       �SigaFin                                                          ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   |lOpen							                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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