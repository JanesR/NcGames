#INCLUDE "PROTHEUS.CH" 
#Include "TBICONN.CH"
#INCLUDE "FILEIO.CH"    

/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZNCG20	     �Autor  �Rodrigo A. Tosin	  �Data  � 18/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao para gerar mBrowse da tabela ZAC					  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �NCGames                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil						   									  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/ 

User Function KZNCG20() 
	Local alArea 	:= GetARea() 
	Local llRet		:= .T.
	Local alIndice	:= {}
    Local nlX 		:= 1 
    Local clOrdem	:= "2"
	Private cCadastro 	:= "Tipo Pedido Neogrid X Tipo Opera��o TES Inteligente"
	Private aRotina  	:= {} 
	Private	cpAlias     := "ZAC"	
	Private cpIndice	:= ""
			
	dbSelectArea("SX2")
		SX2->(dbSetOrder(1))
		SX2->(dbGoTop())
		
		If SX2->(dbSeek(cpAlias))	

			dbSelectArea("SIX")
				SIX->(dbSetOrder(1))
				SIX->(dbGoTop())
				If SIX->(dbSeek(cpAlias+clOrdem))
					
					alIndice := SEPARA(SIX->CHAVE,"+")
				Else
					ShowHelpDlg(cpAlias, {"N�o existe �ndice " + clOrdem + " para a tabela " + cpAlias + "."},5,{"Execute o update U_UPDNCG20."},5)
					llRet := .F.
				EndIf
			If llRet	
				dbSelectArea("SX3")
					SX3->(dbSetOrder(2))
					SX3->(dbGoTop())
					For nlX := 1 to Len(alIndice)
						If SX3->(!dbSeek(alIndice[nlX]))
							ShowHelpDlg(cpAlias, {"O campo" + alIndice[nlX] + " n�o existe no Dicion�rio de Dados"},5,{"Execute o update U_UPDNCG20."},5)
							llRet := .F.
							Exit
						Else
							If Empty(cpIndice)
								cpIndice := "M->" + alIndice[nlX]
							Else						 	
								cpIndice += "+M->" + alIndice[nlX]
							EndIf	 	
						EndIf
					Next nlX
					If "FILIAL" $ alIndice[1]
						cpIndice := STRTRAN(cpIndice,"M->"+alIndice[1],"'" + xFilial(cpAlias) + "'")
					EndIf
					
				If llRet	 					
					AADD(aRotina,{"Pesquisar"	,"AxPesqui"		,0,1})
					AADD(aRotina,{"Visualizar"	,"AxVisual"		,0,2})
					AADD(aRotina,{"Incluir" 	,"U_KZINC20"	,0,3})   
					AADD(aRotina,{"Alterar" 	,"U_KZALT20"	,0,4})
					AADD(aRotina,{"Excluir" 	,"AxDeleta"		,0,5})	
							
					dbSelectArea(cpAlias)
					dbSetOrder(1)
					mBrowse(,,,,cpAlias)
				EndIf 
			EndIf 			
		Else  
			ShowHelpDlg(cpAlias, {"A tabela " + cpAlias + " n�o existe no Dicion�rio de Arquivos"},5,{"Execute o update U_UPDNCG20."},5)	
		EndIf
	RestArea(alArea)
Return
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZINC20	     �Autor  �Rodrigo A. Tosin	  �Data  � 18/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao para validar inclusao da tabela ZAC				  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �NCGames                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�cAlias - Tabela posicionada - ZAC 							  ���
���  		 �nReg   - Numero do registro posicionado   					  ���
���  		 �nOpc	 - Opcao de Inclusao = 3								  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/ 
User Function KZINC20(cAlias,nReg,nOpc)
	  Private  aButtons := {}
	  Private  aParam	:= {}
	      
	//adiciona codeblock a ser executado no inicio, meio e fim
		aAdd( aParam,  {||  } )  				 //antes da abertura
		aAdd( aParam,  {|| U_TudoOK20() } ) 		 //ao clicar no botao ok
		aAdd( aParam,  {||  } )  				//durante a transacao
		aAdd( aParam,  {|| 	} )      //termino da transacao										

  //AxInclui( cAlias, nReg, nOpc, aAcho, cFunc, aCpos, cTudoOk						, lF3, cTransact, aButtons, aParam, aAuto, lVirtual, lMaximized, cTela, lPanelFin, oFather, aDim, uArea) 
	AxInclui(cAlias,nReg,nOpc ,      ,      ,      , 				       	 		, .F.,         , aButtons, aParam ,      ,        ,            , 	  , 		 , 		  , 	, 	  )	
   
Return
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � TudoOK20	     �Autor  �Rodrigo A. Tosin	  �Data  � 18/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao para validar inclusao da tabela ZAC				  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �NCGames                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�cAlias - Tabela posicionada - ZAC								  ���
���  		 �nReg   - Numero do registro posicionado   					  ���
���  		 �nOpc	 - Opcao de Inclusao = 3								  ���
�����������������������������������������������������������������������������͹��
���Retorno   �llRet - .T. se validou corretamente, .F. se nao validou		  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/ 
User Function TudoOK20()
	Local llRet := .T.
	
	(cpAlias)->(dbSetOrder(1))
	(cpAlias)->(dbGoTop())
	
	If (cpAlias)->(dbSeek(&(cpIndice)))
		ShowHelpDlg("JaExiste",{"J� existe o Tipo de Pedido NeoGrid " + ALLTRIM(M->ZAC_TPNRGD) + " cadastrado no sistema."},5,{"Cadastre outro Tipo de Pedido NeoGrid."},5)
		llRet := .F.
	EndIf 
Return llRet

/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZALT01	     �Autor  �Rodrigo A. Tosin	  �Data  � 18/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao para validar alteracao da tabela ZAC				  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �NCGames                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�cAlias - Tabela posicionada - ZAC 							  ���
���  		 �nReg   - Numero do registro posicionado   					  ���
���  		 �nOpc	 - Opcao de Alteracao = 4								  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/ 
User Function KZALT20(cAlias,nReg,nOpc)
	  Private  aButtons := {}
	  Private  aParam	:= {}
	      
	//adiciona codeblock a ser executado no inicio, meio e fim
		aAdd( aParam,  {||  } )  				//antes da abertura
		aAdd( aParam,  {|| U_TudOK20() } ) 	 //ao clicar no botao ok
		aAdd( aParam,  {||  } )  				//durante a transacao
		aAdd( aParam,  {|| 	} )      			//termino da transacao 
        
   //AxAltera(cAlias,nReg,nOpc ,aAcho ,aCpos ,nColMens,cMensagem,cTudoOk,cTransact,cFunc,aButtons,aParam,aAuto,lVirtual,lMaximized,cTela,lPanelFin,oFather,aDim,uArea ] )
	AxAltera(cAlias,nReg,nOpc ,, ,,,,,,aButtons,aParam,,,,,,,,)

Return
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � TudOK01	     �Autor  �Rodrigo A. Tosin	  �Data  � 18/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao para validar botao de OK na alteracao da ZAC 			  ���
�����������������������������������������������������������������������������͹��
���Uso       �NCGames                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil															  ���
�����������������������������������������������������������������������������͹��
���Retorno   �llRet - .T. se validou corretamente, .F. se nao validou		  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/ 
User Function TudOK20()
	Local llRet 	:= .T.
	Local nlRecno	:= (cpAlias)->(RecNo())
	
	(cpAlias)->(dbSetOrder(1))
	(cpAlias)->(dbGoTop())
	
	If (cpAlias)->(dbSeek(&(cpIndice)))
		If nlRecno <> (cpAlias)->(RecNo()) 
			ShowHelpDlg("JaExiste",{"J� existe o Tipo de Pedido NeoGrid " + ALLTRIM(M->ZAC_TPNRGD) + " cadastrado no sistema."},5,{"Cadastre outro Tipo de Pedido NeoGrid."},5)
			llRet := .F.
		EndIf
	EndIf 
Return llRet