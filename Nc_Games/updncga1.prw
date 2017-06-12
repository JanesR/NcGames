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
���Funcao    �UPDNCGA1		 �Autor  �Kazoolo             � Data �    /  /     ���
������������������������������������������������������������������������������͹��
���Desc.     � 														  		   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 																   ���
������������������������������������������������������������������������������͹��
���Retorno   � 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function UPDNCGA1() 

	Local cMsg			:= ""
	
	Local nNum			:= 1 // Numero maximo de progresso da Regua(referente a qntd de atualizacoes - Sx2, Sx3, etc..) 
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
			cMsg += "Este programa tem como objetivo ajustar o cadastro de Clientes X Tipos de Documentos"
			cMsg += " para a implementa��o da melhoria"
			cMsg += " relacionada a Interface entre PROTHEUS e NCGames."
			
			lHistorico 	:= MsgYesNo("Deseja efetuar a atualizacao da ZAA?" + CRLF + cMsg, "Atencao !") 
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
			If aScan(alAtuEmp, AllTrim(aSM0[nCFil][1])) > 0
				RpcSetType(3)
				RpcSetEnv(aSM0[nCFil][1], aSM0[nCFil][2] )
			
				RpcClearEnv()
				OpenSm0Excl()
			EndIf	
		Next nCFil
		
		For nCFil := 1 to Len(aSM0)
			If aScan(alAtuEmp, AllTrim(aSM0[nCFil][1])) == 0
				Loop
			EndIf		
			RpcSetType(3)
			RpcSetEnv(aSM0[nCFil][1], aSM0[nCFil][2] )
			
			cTexto += Replicate("-",128)+CRLF
			cTexto += "Empresa : "+aSM0[nCFil][1]+" Filial : "+aSM0[nCFil][2]+"-"+aSM0[nCFil][7]+CRLF 
			
			clEmpFil := "Empresa : "+aSM0[nCFil][1]+" Filial : "+aSM0[nCFil][2]+"-"+aSM0[nCFil][7]
			
			/*============= Atualizacao da Regua de Progresso =================*/
			
			ProcessMessages() // atualiza a pintura da janela, processa mensagens do windows
			nCurrent:= 0
			nCurrent:= Eval(oBarra:bSetGet) // pega valor corrente da regua  
			 
			/*=================================================================*/
			Begin Sequence
				//���������������������������������������������������Ŀ
				//�Atualiza Tipos de Documento para TODOS OS CLIENTES.�
				//�����������������������������������������������������
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"In�cio - Analisando Tabela ZAA...| " + clEmpFil))
				oBarra:Set(++nCurrent)
				
				cSayMsg := OemToAnsi("Atualizando Tabela ZAA... | " + clEmpFil)
				oSayMsg:Refresh() 
				Sleep(2000)
				ProcessMessages()
					
				cTexto += AtuSA1()
				
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Fim - Tabela ZAA | " + clEmpFil))	
            EndSequence
			
			Begin Sequence	            		
				RpcClearEnv()
				OpenSm0Excl()
            EndSequence			
			
		Next nCFil
	EndIf

	If !lError	
		RpcSetEnv(aSM0[1][1],aSM0[1][2],,,,, { "AE1" })  
		
  			
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
*/
Static Function AtuSA1()
	Local clQuery 	:= ""
	Local nlX     	:= 1	
    Local alTipos 	:= {'01','04'}
    Local clAlias	:= "ZAA"
	Local clFilial 	:= xFilial(clAlias) 
	                                                                    	
	clQuery := "SELECT A1_COD,A1_LOJA,A1_NREDUZ "				   		+ CRLF	 
	clQuery += "FROM " + RetSQLName("SA1") 								+ CRLF
	clQuery += "WHERE"													+ CRLF
	clQuery += "   		A1_FILIAL = '" + xFilial("SA1") + "'"			+ CRLF	 			
	clQuery += "   	AND D_E_L_E_T_ <> '*'"
	clQuery := ChangeQuery(clQuery)
	
	If Select(clAlias) == 0
		dbSelectArea(clAlias)
	EndIf
	(clAlias)->(dbSetOrder(1))
	(clAlias)->(dbGoTop())
		
	If Select("SA1QRY") > 0
		SA1QRY->(dbCloseArea())
	EndIf 
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "SA1QRY" ,.T.,.F.)
	
	While SA1QRY->(!EOF())
		cSayMsg := "Atualizando - Cliente '" + SA1QRY->A1_COD + "' Loja '" + SA1QRY->A1_LOJA + "' Nome '"+AllTrim(SA1QRY->A1_NREDUZ)+"' "
		oSayMsg:Refresh()
		ProcessMessages()
		For nlX := 1 to Len(alTipos)
			If RecLock(clAlias,(clAlias)->(!dbSeek(clFilial+SA1QRY->A1_COD+SA1QRY->A1_LOJA+alTipos[nlX])))
				(clAlias)->ZAA_FILIAL 	:= clFilial
				(clAlias)->ZAA_CLIENT 	:= SA1QRY->A1_COD
				(clAlias)->ZAA_LOJA		:= SA1QRY->A1_LOJA
				(clAlias)->ZAA_NOME		:= SA1QRY->A1_NREDUZ
				(clAlias)->ZAA_TPDOC	:= alTipos[nlX]
			EndIf
			(clAlias)->(MsUnlock())	
		Next nlX	
		SA1QRY->(dbSkip())
	EndDo
		
	clTexto := "Concluida a atualizacao da " + clAlias + CRLF

Return clTexto 

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