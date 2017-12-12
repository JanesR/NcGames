#INCLUDE "PROTHEUS.CH"


User Function DBMCDCLA()

Local alArea := {}

dbSelectArea("ZZ1")
DbSetOrder(1)
DbSelectArea("ZZ2")
DbSetOrder(1)
DbSelectArea("ZZ3")                                     
DbSetOrder(1)  


Private aFixe := {{"CLASSE PEDIDO","X5_CHAVE"},{"DESCRICAO","X5_DESCRI"}} 
Private cCadastro 	:= "Contratos" 
Private cFiltro := ""
Private aIndex := {} 

Private aRotina 	:= { { "Pesquisar"	,"AxPesqui" 	 ,0,1},; //"Pesquisar"
					   {   "Visualizar"	,"U_DBMCICLA"    ,0,2},; //"Visual"
			           {   "Incluir"	,"U_DBMCICLA"    ,0,3},; //"Incluir"
					   {   "Alterar"	,"U_DBMCICLA"    ,0,4},; //"Alterar"
	   				   {   "Excluir"   ,"U_DBMCICLA"    ,0,5}} //"Deletar" 
	   				   
	cFiltro := "SX5->X5_FILIAL=='"+xFilial("SX5")+"'.And. SX5->X5_TABELA == '_0' "
	If !Empty(cFiltro)
		bFiltraBrw := {|| FilBrowse("SX5",@aIndex,@cFiltro) }
		Eval(bFiltraBrw)
	EndIf
	
	alArea := GetArea()
	MBrowse( 6, 1,22,75,"SX5",aFixe,,,,,)
	
	RestArea(alArea)
	
	If ( Len(aIndex)>0 )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Finaliza o uso da FilBrowse e retorna os indices padroes.  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		EndFilBrw("SX5",aIndex)
	EndIf			


Return

User Function DBMCICLA(cAlias,nReg,nOpc)
	Local alArea := Getarea() 
	
    Local nlCntFor 		:= 0  // Contador dos campos que receberão valor na MSMGET
                                                       
    Local aAlter1  		:= {"X5_CHAVE", "X5_DESCRI"}
	Local aAlter2 		:= {}

	    			       		
	      				                                           
    Private aHeadProd  	:= {} // pertencente a Getdados de produtos por festa (ZZ3)
    Private aColProd 	:= {} // pertencente a Getdados de produtos por festa (ZZ3)
    Private apPos		:= {(015),(003),(065),(505)}          
	Private apSize		:= MsAdvSize(.T.)
	Private npUsado		:= 0
	Private nOption	:= 0 
	Private aacho := {"X5_CHAVE", "X5_DESCRI", "NOUSER"}

	Private npLen	:= 0	//Quantidade de registro da apColsFi Inicial. 
	Private nOpcNewGD := Iif(nOpc==2,1,GD_INSERT + GD_UPDATE + GD_DELETE)    
    
    //Objetos da tela       
   	Private opDlg 
    Private opMsmget  
    Private opGetProd 
    Private opGet1
    Private opGet2
    Private opFolder
    Private opTemp	
    
	Private aTela[0][0]
	Private aGets[0]      
	Private nOpcNewGD := Iif(nOpc==2,1,GD_INSERT + GD_UPDATE + GD_DELETE) 

	
	Private aObjects := {}
		AAdd( aObjects, { 100, 020, .t., .t. } )
		AAdd( aObjects, { 100, 100, .t., .t. } ) 
		
	Private	aSize := MsAdvSize()
	   //	AAdd( aObjects, { 100, 020, .t., .f. } ) 
	Private	   	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
		
	Private aPosObj := MsObjSize( aInfo, aObjects )
	
	Private aPosGet := MsObjGetPos(aSize[3]-aSize[1],315,{{003,033,160,200,240,263}} ) 
	
	DbSelectArea("DA1")
	DbSetOrder(1)
	
	
	
	FillGetDd(nOpc)
	
	EndFilBrw("SX5",aIndex)                                                      
       
	Define Msdialog opDlg Title "Classe Orcamento" From aSize[7],000 To aSize[6],aSize[5] Of oMainWnd Pixel
	
		RegToMemory("SX5",.T.)//Criação de variáveis de memória para serem usadas na MSMGET
		                                                                    
		If nOpc == 2 .Or. nOpc == 4 .Or. nOpc == 5// Visualização ou Alteração
			DbSelectArea("SX5")
		    DbSetOrder(1)
		    
		    
		    
		
			//No caso de alteração ou visualização as variáveis de memória virão preenchidas
   		    For nlCntFor := 1 To FCount()
				M->&(FieldName(nlCntFor)) := &("SX5->"+(FieldName(nlCntFor)))
			Next nlCntFor      
			       
	        //Criação da MSMGET
	        	                      
			opMsmget :=	Msmget():New("SX5",0,3,,,,aAcho,aPosObj[1],aAlter2,,opDlg,,.T.,,,.T.)      
			
		ElseIf nOpc == 3 //Inclusão                                                                 
			//Criação da MSMGET	
			opMsmget :=	Msmget():New("SX5",0    ,3    ,       ,     ,       ,aAcho,aPosObj[1],aAlter1,,opDlg,,.T.,,,.T.)  
		                        		
				
		EndIf

	
		DbSelectArea("ZZ3")		
		//Criação da GetDados 
		//MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc,,,"",,aCpos1,nColFreeze,,,"A410FldOk(1)",,,,,lFreeze)
		//oGetD:=     MsNewGetDados():New(nSuperior   , nEsquerda  , nInferior  , nDireita   ,nOpc     ,cLinOk        ,cTudoOk       , cIniCpos  , aAlterGDa, nFreeze, nMax,cFieldOk,cSuperDel,cDelOk, oDLG, aHeader, aCols)	       
		opGetProd := MsNewGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpcNewGD,"U_claLinOk()","AllwaysTrue()","+ZZ3_ORDEM",   ,        ,     ,"AllwaysTrue()",,,opDlg               ,aHeadProd,aColProd)

	

	Activate Msdialog opDlg On Init EnchoiceBar(opDlg, {|| Iif(U_claTdOk(nOpc) ,Eval( {||U_DBRECSX5(nOpc),U_dbRecZZ3(nOpc),,,opDlg:End() }),Nil)  },{||opDlg:End()},,)
	Eval(bFiltraBrw)
    
Return()
 
/*##########################################################
#                 ___  "  ___                              #
#                    #
############################################################
# Função :     #  REC_X5(nlChoice)                        #
############################################################
# Descrição :  #  ROTINA PARA GRAVAÇÃO OU ALTERAÇÃO DOS    #
#			   #  DADOS DA TABELA X5                      #
############################################################                                      
# Autor :      #  Felipe Volcov Nambara  	  	           #
############################################################
# Parâmetros : #  nlchoice:numérico -  é recebido pela 	   #
#			   #  função DBRECSX5 para alterar o processo    #
#			   #  de gravação para alteração ou inclusão   #	
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/
                
User Function DBRECSX5(nlChoice)
Local alArea := Getarea() 
    Local nlCont // Variável para alterar o nome do campo que receberá valor
    
	// Inclusão
	If nlChoice == 3

		If RecLock("SX5",.T.)
	        SX5->X5_TABELA := "_0"
			SX5->X5_FILIAL := xFilial("SX5")                                                 
			SX5->X5_CHAVE := M->X5_CHAVE 
            SX5->X5_DESCRI := "CLASSE ORCAMENTO" 
			MsUnlock()
		EndIf         	
	EndIf
	If nlChoice == 5
		u_DBMDELCL()
		
	EndIf   
	
Return()     

/*##########################################################
#                 ___#######################
# Função :     #  REC_ZZ3(nlChoice)                        #
############################################################
# Descrição :  #  ROTINA PARA GRAVAÇÃO OU ALTERAÇÃO DOS    #
#			   #  DADOS DA TABELA ZZ3                      #
############################################################
# Autor :      #  Felipe Volcov Nambara  	  	           #
############################################################
# Parâmetros : #  nlchoice:numérico -  é recebido pela 	   #
#			   #  função dbRecZZ3 para alterar o processo    #
#			   #  de gravação para alteração ou inclusão   #
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/

User Function dbRecZZ3(nlChoice)
	Local alArea := Getarea() 
    Local nlY 		:= 1 // Percorre as linhas do aColProd
    Local nlX 		:= 1 // Percorre as colunas do aColProd
    Local nlItem    := aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ3_ORDEM"}) // Indice do aColProd do campo `ZZ3_ORDEM
                    
    // Inclusão
	If nlChoice == 3
		For nlY := 1 To Len(opGetProd:aCols)
		DbSelectArea("ZZ3")
		If opGetProd:aCols[nlY][Len(opGetProd:aCols[nlY])] == .F.
			If RecLock("ZZ3",.T.)
				ZZ3->ZZ3_FILIAL := xFilial("ZZ3")
				For nlX := 1 To Len(aHeadProd)          
					&(aHeadProd[nlX][2]) := opGetProd:aCols[nlY][nlX]
				Next nlX  
				ZZ3->ZZ3_CLASSE := M->X5_CHAVE           
				//Grava o preço de custo separadamente, pois o campo é omitido e não aparece na GETDADOS
				//ZZ3_PRCUST := POSICIONE("SB1",1,XFilial("SB1")+opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ3_PROD"})],"B1_CUSTD")										
				ZZ3->(MsUnlock())
			EndIf
		EndIf
		Next nlY
	
	// Alteração
	ElseIf nlChoice == 4
	
		For nlY := 1 To Len(opGetProd:aCols)
			DbSelectArea("ZZ3")
			DbSetOrder(1)
			If DbSeek(xFilial("ZZ3")+ M->X5_CHAVE + opGetProd:aCols[nlY][nlItem] )			
				If opGetProd:aCols[nlY][Len(opGetProd:aCols[nlY])] == .F.					
					If RecLock("ZZ3",.F.)						
						For nlX := 1 To Len(aHeadProd)          
							&(aHeadProd[nlX][2]) := opGetProd:aCols[nlY][nlX]
						Next nlX 
						ZZ3->ZZ3_FILIAL := xFilial("SX5")
						ZZ3->ZZ3_CLASSE := M->X5_CHAVE                                          

						//Grava o preço de custo separadamente, pois o campo é omitido e não aparece na GETDADOS						
						//ZZ3_PRCUST := POSICIONE("SB1",1,XFilial("SB1")+opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ3_PROD"})],"B1_CUSTD")
						
						MsUnlock()
					EndIf
				Else
					If RecLock("ZZ3",.F.)
							DbDelete()
							MsUnlock()
					EndIf								
				EndIf
			Else	
				If opGetProd:aCols[nlY][Len(opGetProd:aCols[nlY])] == .F.					
					If RecLock("ZZ3",.T.)
						
						For nlX := 1 To Len(aHeadProd)          
							&(aHeadProd[nlX][2]) := opGetProd:aCols[nlY][nlX]
						Next nlX 
						ZZ3->ZZ3_FILIAL := xFilial("ZZ3")
						ZZ3->ZZ3_CLASSE := M->X5_CHAVE 
						
						//ZZ3_PRCUST := POSICIONE("SB1",1,XFilial("SB1")+opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ3_PROD"})],"B1_CUSTD")						
						MsUnlock()
					EndIf
				EndIf
			EndIf
		Next nlY
	
	EndIf

Return()
                                                     


Static Function FillGetDd(nlChoice)
    Local nlUsado		:= 0
	Local nlI			:= 1    
	               
	//Preenchimento do aHeadProd
	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("ZZ3")
	While !(Eof()) .And. SX3->X3_ARQUIVO == "ZZ3"
	    If SX3->X3_CONTEXT <> "V" .And. !(SX3->X3_CAMPO $ "ZZ3_FILIAL*ZZ3_CLASSE")
			aAdd(aHeadProd,{Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,;
							 SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3,SX3->X3_CONTEXT  })
			nlUsado++
	    EndIf
	    DbSkip()
	EndDo
                              
	//Criação do aColProd
	Aadd(aColProd,Array(nlUsado + 1))
	//Criação do registro inicial do aColProd                 	
	For nlI := 1 To nlUsado
		aColProd[Len(aColProd)][nlI]  := CriaVar(aHeadProd[nlI,2])
	Next
	
	aColProd[Len(aColProd),nlUsado+1] := .F.	
	//Item inicial  aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ3_ORDEM"})
	aColProd[1,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ3_ORDEM"})] 						:= "001"	    
	
	//Se for alteração ou visualização o aColProd é preenchido pela função DadosZZ3   
    If nlChoice == 2 .Or. nlChoice == 4   .Or. nlChoice == 5                            
		DadosZZ3(nlChoice)
	EndIf
	
Return()             
                
/*##########################################################
#                             #
############################################################
# Função :     #  DADOSZZ3(nlChoice)                       #
############################################################
# Descrição :  #  ROTINA PARA PREENCHIMENTO DO aColProd NO    #
#			   #  CASO DE INCLUSÃO OU ALTERAÇÃO            #
############################################################
# Autor :      #  Felipe Volcov Nambara  	  	           #
############################################################
# Parâmetros : #  nlchoice:numérico -  é recebido pela 	   #
#			   #  função DADOSZZ3 para alterar o processo  #
#			   #  para alteração/inclusão				   #	
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/

Static Function DADOSZZ3(nlChoice)    
    Local clSql      := ""
    Local nlLin		 := 1
	Local nlCont     := 1
	Local clAlias	:= GetNextAlias()    
	
                                   
    //Query que traz todos os produtos de um determinado contrato já existente
	clSql += " SELECT * "
	
	/*ZZ3_FILIAL "
	clSql += 		",ZZ3_NUMORC"	
	clSql += 		",ZZ3_ORDEM"
	clSql += 		",ZZ3_CODPRO"
	clSql += 		",ZZ3_EAN"			
	clSql += 		",ZZ3_DESCRI"		
	clSql += 		",ZZ3_PLATF"
	clSql += 		",ZZ3_PUBLIS"
	clSql += 		",ZZ3_GENERO"
	clSql += 		",ZZ3_PRCVEN"
	clSql += 		",ZZ3_QUANT"
	clSql += 		",ZZ3_TOTAL"
	clSql += 		",ZZ3_MARGEM"
	*/	
	clSql += " FROM " + RetSqlName("ZZ3") + " ZZ3 "
	          
	clSql += " WHERE ZZ3.D_E_L_E_T_ = ' ' "
	clSql += " AND ZZ3_FILIAL = '" + xFilial("ZZ3")	+ "' "
	clSql += " AND ZZ3_CLASSE = '" + SX5->X5_CHAVE + "' "
	clSql += " ORDER BY ZZ3_FILIAL, ZZ3_CLASSE, ZZ3_ORDEM"		
	
	//TCquery clSql New Alias clAlias
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,clSql),clAlias, .F., .T.)
	 	
	TcSetField(clAlias,"ZZ3_QUANT","N",11,2)	
				
	DbSelectArea(clAlias)
	DbGoTop()
	
 	While !(Eof()) 
	    //Preenchimento do aColProd             
		For nlCont := 1 To Len(aHeadProd)
			aColProd[nlLin][nlCont]	   := (clAlias)->&(aHeadProd[nlcont][2])	
		Next nlCont	                                                    	
		aColProd[nlLin][ Len(aHeadProd)+1]  := .F.		
	
		nlLin++														
		DbSkip()                              
		
		If !(Eof())
			aAdd(aColProd,Array(Len(aHeadProd)+1		))
		EndIf
		
	Enddo
	
    (clAlias)->(DbCloseArea())
    
Return()    

/*##########################################################
#                #
############################################################
# Função :     #  claLINOK()		                       #
############################################################
# Descrição :  #  ROTINA QUE VALIDA A LINHA DA GETDADOS    #
############################################################
# Autor :      #  Felipe Volcov Nambara  	  	           #
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/

User Function claLINOK()
	Local alArea := Getarea() 
	Local llOk     	:= .T.  
	Local nlCont	:= 1
	Local nlAcols	:= opGetProd:oBrowse:nAt
	
	For nlCont := 1 To Len(aHeadProd)
	    
		If Empty(opGetProd:aCols[nlAcols][nlCont]) .And. opGetProd:aCols[nlAcols][Len(aHeadProd)+1] == .F.
			Alert("O Campo " + aHeadProd[nlCont][1] + " está vazio !")
			llOk := .F.
			Exit
		EndIf
	
	Next nlCont
	

Return(llOk)       

/*##########################################################
#                 ___  "  ___                              #
#                          #
############################################################
# Função :     #  claTDOK()			                       #
############################################################
# Descrição :  #  ROTINA QUE VALIDA TODA A GETDADOS		   #
############################################################
# Autor :      #  Felipe Volcov Nambara  	  	           #
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/
                        
User Function claTDOK(nOpc)  
Local alArea := Getarea() 
	Local llOk     	:= .T.  
	Local clOk	   	:= ""
	Local nlCont   	:= 1      
	Local nlCont2  	:= 1   
	Local alVld	    := {}

	If nOpc == 5
		Return .T.
	EndIF
	
	 	

	For nlCont := 1 To Len(opGetProd:aCols)

		If !(opGetProd:aCols[nlCont][Len(aHeadProd)+1])
		    clOk += "T"
			For nlCont2 := 1 To Len(aHeadProd)
			
				If !Empty(opGetProd:aCols[nlCont][nlCont2]) .And. !(Alltrim(aHeadProd[nlCont2][2]) $ "ZZ3_ORDEM")
					aAdd(alVld,.T.)
				ElseIf Empty(opGetProd:aCols[nlCont][nlCont2]) .And. !(Alltrim(aHeadProd[nlCont2][2]) $ "ZZ3_ORDEM")
					aAdd(alVld,.F.)                                                                                              
				EndIf
					
			Next nlCont2
		Else
			clOk += "F"
		EndIf
						
	Next            
	
	If !Obrigatorio(aGets,aTela)
		llOk := .F.	
	EndIf		    
		                                             
	If aScan(alVld,.F.) <> 0 .And. llOk
		Alert("Existe algum campo obrigatório que está em branco ou zerado no grid de produtos!")
		llOk := .F.
	ElseIf clOk == Replicate("F",Len(opGetProd:aCols)) .And. llOk  
		Alert("Todos os itens de produtos foram deletados !")
		llOk := .F.	
	EndIf 

	     
	RestArea(alArea)
Return(llOk)  



User Function DBMDELCL() 
Local alArea := Getarea() 

	dbSelectArea("ZZ3")
	DbSetOrder(1) 
	If ZZ3->(DbSeek(xFilial("ZZ3") + SX5->X5_CHAVE))
	
		While !EOF() .And. ZZ3->ZZ3_CLASSE == SX5->X5_CHAVE 
			If RecLock("ZZ3",.F.)
				dbDelete()
				MsUnLock()
			EndIF
			ZZ3->(dbSkip())
		End 
	EndIf
	DbSelectArea("SX5")
	DbSetOrder(1)
	
	If SX5->(dbSeek(xFilial("SX5") + "_0" + M->X5_CHAVE))
		If RecLock("SX5",.F.)
			dbDelete()
			MsUnLock()
		EndIF
	EndIf
	
	RestArea(alArea)
Return





	
	
	
	




