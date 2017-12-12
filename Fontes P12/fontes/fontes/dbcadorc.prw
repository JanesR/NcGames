#INCLUDE "Protheus.ch"

User Function DBCADORC() 

	Private cFiltro := ""
	Private aIndex := {}
	Private cFiltro := ""  	
	Private cCadastro 	:= "Orcamentos"
	Private aRotina 	:= { { "Pesquisar"	,"AxPesqui" 	 ,0,1},; //"Pesquisar"
						   {   "Visualizar"	,"U_DBMORCAM"    ,0,2},; //"Visual"
				           {   "Incluir"	,"U_DBMORCAM"    ,0,3},; //"Incluir"
						   {   "Alterar"	,"U_DBMORCAM"    ,0,4},; //"Alterar"
						   {   "Rejeitar"  	,"U_DBMORCAM"    ,0,5},; //"Rejeitar"
						   {   "Aprovar"  	,"U_DBMORCAM"    ,0,6},; //"Aprovar"
		   				   {   "Apagar"   	,"U_DBMORCAM"    ,0,7},; //"Deletar"
		   				   {   "Imprimir"   ,"U_DBRORCAM"   ,0,8},; //""
		   				   {   "Legenda"    ,"u_dbLegend" 	 ,0,9}}  //"Legenda"
		   				   
		   				 
	Private apCores 	:= {{"ZZ1_STATUS == '1'"  ,'BR_AMARELO'     },;//Em Aberto
	 						{"ZZ1_STATUS == '0'"  ,'BR_VERDE'  },;//Aprovado
		               	   {"ZZ1_STATUS == '2'"  ,'BR_AZUL'  },;//Atendido
		               	   {"ZZ1_STATUS == '3'"  ,'BR_VERMELHO'     }}//Rejeitado
		               	  
	DbselectArea("SA3")
	DbSetOrder(7) // por codigo de usuário 
	/*
	If !SA3->(dbSeek(xFilial("SA3") + __cuserid )) 
		MSGALERT("Somente vendedores podem incluir orcamentos","Atencao")
		Return
	EndIf 
	
	
	cFiltro := "ZZ1->ZZ1_VEND1 =='" + SA3->A3_COD + "'"
	If !Empty(cFiltro)
		bFiltraBrw := {|| FilBrowse("ZZ1",@aIndex,@cFiltro) }
		Eval(bFiltraBrw)
	EndIf 
	*/
		               						 
	MBrowse( 6, 1,22,75,"ZZ1",,,,,,apCores)
	
Return()    

User Function dbLegend()
        
	BrwLegenda(cCadastro,"Legenda",{ {"BR_AMARELO"     ,"Em Aberto"         },;  
									{"BR_VERDE" ,"Aprovado " },;
                                     {"BR_AZUL" ,"Atendido " },;
                                     {"BR_VERMELHO"    ,"Rejeitado"            }})
                                     
Return()                           
              


User Function DBMORCAM(cAlias,nReg,nOpc) 

    Local nlCntFor 		:= 0  // Contador dos campos que receberão valor na MSMGET
                                                       
    Local aAlter1  		:= {"ZZ1_","ZZ1_VEND1"  ,"ZZ1_UF" , "ZZ1_CLASSE"   ; //Campos que poderão ser alterados na MSMGET na
	    			       ,"ZZ1_OBSERV", "ZZ1_PROSPC","ZZ1_LJPROS","ZZ1_ACRESC","ZZ1_VLRAPR"} 
	Local aAlter2 		:= {}
	    			       
	Private apAlter     := {"ZZ2_CODPRO","ZZ2_QUANT"}
	                                        
	If nOpc == 4
    	aAlter2 :={"ZZ1_OBSERV", "ZZ1_CLIENT", "ZZ1_ACRESC"}
    EndIf    				
    				
	      				                                           
    Private aHeadProd  	:= {} // pertencente a Getdados de produtos por orcamento (ZZ2)
    Private aColProd 	:= {} // pertencente a Getdados de produtos por orcamento (ZZ2)
    Private apPos		:= {(015),(003),(065),(505)}          
	Private apSize		:= MsAdvSize(.T.)
	Private npUsado		:= 0
	Private nOption	:= 0

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
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 100, .t., .t. } ) 
		
	Private	aSize := MsAdvSize()
	   //	AAdd( aObjects, { 100, 020, .t., .f. } ) 
	Private	   	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
		
	Private aPosObj := MsObjSize( aInfo, aObjects )
	
	Private aPosGet := MsObjGetPos(aSize[3]-aSize[1],315,{{003,033,160,200,240,263}} )       
	DbselectArea("SA3")
	DbSetOrder(7) // por codigo de usuário 
	/*
	If nOpc == 3 
		If !SA3->(dbSeek(xFilial("SA3") + __cuserid )) 
			MSGALERT("Somente vendedores podem incluir orcamentos","Atencao")
			Return
		EndIf
	EndIf
	*/
	If nOpc == 4
		If ZZ1->ZZ1_STATUS == "2" 
			//If !SA3->(dbSeek(xFilial("SA3") + __cuserid )) 
				MSGALERT("Orcamento com pedido, nao pode ser alterado","Atencao")
				Return
			//EndIf
		EndIf  
		
		If ZZ1->ZZ1_STATUS == "3" 
			MSGALERT("Pedido rejeitado e nao pode ser alterado" ,"Atencao")
			Return
		EndIf  
		
		If ZZ1->ZZ1_STATUS == "0" 
			MSGALERT("Orcamento aprovado nao pode ser alterado" ,"Atencao")
			Return
		EndIf 
	EndIf
	If nOpc == 5
		If ZZ1->ZZ1_STATUS == "2" 
		//If !SA3->(dbSeek(xFilial("SA3") + __cuserid )) 
			MSGALERT("Orcamento com pedido, nao pode ser rejeitado","Atencao")
			Return
		EndIf
		//EndIf  
		
		If ZZ1->ZZ1_STATUS == "3" 
			MSGALERT("O orcamento ja esta com rejeicao" ,"Atencao")
			Return
		EndIf
		If ZZ1->ZZ1_STATUS == "0" 
			MSGALERT("Orcamento aprovado nao pode ser rejeitado" ,"Atencao")
			Return
		EndIf 
		
	
	EndIf
	
	If nOpc == 7
		If ZZ1->ZZ1_STATUS == "2" 
			If !SA3->(dbSeek(xFilial("SA3") + __cuserid )) 
				MSGALERT("Orcamento com pedido, nao pode ser apagado","Atencao")
				Return
			EndIf
		EndIf  
		
		If ZZ1->ZZ1_STATUS == "3" 
			MSGALERT("O orcamento rejeitado nao pode ser apagado" ,"Atencao")
			Return
		EndIf 
	EndIf
	
	If nOpc == 6
		DbSelectArea("SUS")
		DbSetOrder(1)
		 
		If ZZ1->ZZ1_STATUS == "2" 
			If !SA3->(dbSeek(xFilial("SA3") + __cuserid )) 
				MSGALERT("Orcamento com pedido","Atencao")
				Return
			EndIf
		EndIf  
		
		If ZZ1->ZZ1_STATUS == "3" 
			MSGALERT("O orcamento rejeitado nao pode ser aprovado" ,"Atencao")
			Return
		EndIf 
		
		If ZZ1->ZZ1_STATUS == "4" 
			MSGALERT("O orcamento atendido nao pode ser aprovado" ,"Atencao")
			Return
		EndIf 
		
		
		
	EndIf
		
	
	
	DbSelectArea("DA1")
	DbSetOrder(1)
	

	
	//incluisx5()
	
	FillGetDd(nOpc)
	                                                      
       
	Define Msdialog opDlg Title "Orcamentos" From aSize[7],000 To aSize[6],aSize[5] Of oMainWnd Pixel
	
		RegToMemory("ZZ1",.T.)//Criação de variáveis de memória para serem usadas na MSMGET
		                                                                    
		If nOpc == 2 .Or. nOpc == 4 .Or. nOpc == 5 .Or. nOpc == 6 .Or. nOpc == 7// Visualização ou Alteração
			DbSelectArea("ZZ1")
		    DbSetOrder(1)
		    		
			//No caso de alteração ou visualização as variáveis de memória virão preenchidas
   		    For nlCntFor := 1 To FCount()
				M->&(FieldName(nlCntFor)) := &("ZZ1->"+(FieldName(nlCntFor)))
			Next nlCntFor      
			       
	        //Criação da MSMGET
	        	                      
			opMsmget :=	Msmget():New("ZZ1",0,3,,,,,aPosObj[1],aAlter2,,opDlg,,.T.,,,.T.)      
			
		ElseIf nOpc == 3 //Inclusão                                                                 
			//Criação da MSMGET	
			M->ZZ1_NUMORC := GetSxenum("ZZ1","ZZ1_NUMORC") 
			SA3->(dbSeek(xFilial("SA3") + __cuserid ))
			//M->ZZ1_VEND1	:= SA3->A3_COD
			//M->ZZ1_NVEND1	:= SA3->A3_NOME
			opMsmget :=	Msmget():New("ZZ1",0,3,,,,,aPosObj[1],aAlter1,,opDlg,,.T.,,,.T.)		
				
		EndIf

	
		DbSelectArea("ZZ2")		
		//Criação da GetDados 
		//MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc,,,"",,aCpos1,nColFreeze,,,"A410FldOk(1)",,,,,lFreeze)
		//oGetD:=     MsNewGetDados():New(nSuperior   , nEsquerda  , nInferior  , nDireita   ,nOpc     ,cLinOk        ,cTudoOk       , cIniCpos  , aAlterGDa, nFreeze, nMax,cFieldOk,cSuperDel,cDelOk, oDLG, aHeader, aCols)	       
		If nOpc > 4
			apAlter := {}
		EndIf
		opGetProd := MsNewGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpcNewGD,"U_VldLinOk()","u_CALCTOTAL()()","+ZZ2_ITEM" ,apAlter   ,        ,     ,"u_dbmvldcpo()","U_CalcTotal()","U_CALCTODE()",opDlg               ,aHeadProd,aColProd)

	

	Activate Msdialog opDlg On Init EnchoiceBar(opDlg, {|| Iif(U_VldTdOk(nOpc) ,Eval( {|| U_RecZZ2(nOpc),IIf(nOpc==3,ConfirmSX8(),nil),opDlg:End() }),Nil)  },{||RollBackSX8(),opDlg:End()},,{{"SIMULACA",{|| U_CalcZZ2(nOpc)}      ,"Simula Orcamento"}})
	
    
Return()
 


/*##########################################################
#                 ___#######################
# Função :     #  REC_ZZ2(nlChoice)                        #
############################################################
# Descrição :  #  ROTINA PARA GRAVAÇÃO OU ALTERAÇÃO DOS    #
#			   #  DADOS DA TABELA ZZ2                      #
############################################################
# Autor :      #  Alberto   	  	           #
############################################################
# Parâmetros : #  nlchoice:numérico -  é recebido pela 	   #
#			   #  função RECZZ2 para alterar o processo    #
#			   #  de gravação para alteração ou inclusão   #
############################################################
# Data :       #  26/02/2009                               #
###########################################################
# Palavras Chaves : #                                      #
##########################################################*/

User Function RecZZ2(nlChoice)
    Local nlY 		:= 1 // Percorre as linhas do aColProd
    Local nlX 		:= 1 // Percorre as colunas do aColProd
    Local nlItem    := aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_ITEM"}) // Indice do aColProd do campo ZZ2_ITEM
    Local nlTotCus	:= 0
	Local nlCusto	:= 0
	
    
    DbSelectArea("SB2")
    DbSetOrder(1)
                    
    // Inclusão
	If nlChoice == 3
		BeginTran()

		For nlY := 1 To Len(opGetProd:aCols)
			DbSelectArea("ZZ2")
			If opGetProd:aCols[nlY][Len(opGetProd:aCols[nlY])] == .F.
				nlCusto := 0
				If  SB2->(DbSeek(xFilial("SB2") + opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})] + "01")) 
					If SB2->B2_QATU <> 0 
						nlCusto :=  SB2->B2_VATU1 / SB2->B2_QATU 
					EndIf
				EndIf
				If RecLock("ZZ2",.T.)
					ZZ2->ZZ2_FILIAL := xFilial("ZZ2")
					ZZ2->ZZ2_NUMORC := M->ZZ1_NUMORC
		
					
					For nlX := 1 To Len(aHeadProd)          
						&(aHeadProd[nlX][2]) := opGetProd:aCols[nlY][nlX]
					Next nlX 
				
			   		ZZ2->ZZ2_CUSTO := nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]
			   		ZZ2->ZZ2_MARGEM := opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] - (nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]) 
			   		ZZ2->ZZ2_PERMRG := (opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] - (nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})])) / opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] 	
			   		nlTotCus += nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]	          
					//Grava o preço de custo separadamente, pois o campo é omitido e não aparece na GETDADOS
					//ZZ2_PRCUST := POSICIONE("SB1",1,XFilial("SB1")+opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PROD"})],"B1_CUSTD")										
					ZZ2->(MsUnlock())
				EndIf
			EndIf
		Next nlY
	
	// Alteração
	ElseIf nlChoice == 4
		BeginTran()
	
		For nlY := 1 To Len(opGetProd:aCols)
			DbSelectArea("ZZ2")
			DbSetOrder(1)
			If DbSeek(xFilial("ZZ2")+M->ZZ1_NUMORC + opGetProd:aCols[nlY][nlItem] )			
				If opGetProd:aCols[nlY][Len(opGetProd:aCols[nlY])] == .F. 
					nlCusto := 0
					If  SB2->(DbSeek(xFilial("SB2") + opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})] + "01")) 
						If SB2->B2_QATU <> 0 
							nlCusto :=  SB2->B2_VATU1 / SB2->B2_QATU 
						EndIf
					EndIf					
					If RecLock("ZZ2",.F.)
						ZZ2_FILIAL := xFilial("ZZ2")
											
						For nlX := 1 To Len(aHeadProd)          
							&(aHeadProd[nlX][2]) := opGetProd:aCols[nlY][nlX]
						Next nlX 
						ZZ2->ZZ2_CUSTO := nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]
						ZZ2->ZZ2_MARGEM := opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] - (nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})])	
			   			ZZ2->ZZ2_PERMRG := (opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] - (nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})])) / opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] 
			   			nlTotCus += nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]                                         

						//Grava o preço de custo separadamente, pois o campo é omitido e não aparece na GETDADOS						
						//ZZ2_PRCUST := POSICIONE("SB1",1,XFilial("SB1")+opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PROD"})],"B1_CUSTD")
						
						MsUnlock()
					EndIf
				Else
					If RecLock("ZZ2",.F.)
							DbDelete()
							MsUnlock()
					EndIf								
				EndIf
			Else	
				If opGetProd:aCols[nlY][Len(opGetProd:aCols[nlY])] == .F.
					nlCusto := 0
					If  SB2->(DbSeek(xFilial("SB2") + opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})] + "01")) 
						If SB2->B2_QATU <> 0 
							nlCusto :=  SB2->B2_VATU1 / SB2->B2_QATU 
						EndIf
					EndIf					
					If RecLock("ZZ2",.T.)
						
						For nlX := 1 To Len(aHeadProd)          
							&(aHeadProd[nlX][2]) := opGetProd:aCols[nlY][nlX]
						Next nlX 
						ZZ2->ZZ2_NUMORC := M->ZZ1_NUMORC
						ZZ2->ZZ2_FILIAL := xFilial("ZZ2")
						ZZ2->ZZ2_CUSTO := nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]
						ZZ2->ZZ2_MARGEM := opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] - (nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})])
			   			ZZ2->ZZ2_PERMRG := (opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] - (nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})])) / opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] 
			   			nlTotCus += nlCusto * opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})] 
						
						//ZZ2_PRCUST := POSICIONE("SB1",1,XFilial("SB1")+opGetProd:aCols[nlY][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PROD"})],"B1_CUSTD")						
						MsUnlock()
					EndIf                        
				EndIf
			EndIf
		Next nlY
		
	EndIf 
	
	If nlChoice == 3

		If RecLock("ZZ1",.T.)
	
		    For nlCont := 1 To FCount()
		    	&("ZZ1->"+(FieldName(nlCont))) := M->&(FieldName(nlCont))  
			Next nlCont     
			ZZ1->ZZ1_FILIAL := xFilial("ZZ1")                                                 
			ZZ1->ZZ1_VEND1 := M->ZZ1_VEND1 //Posicione("SA3",7,xFilial("SA3")+__cUserId,"A3_COD") // Gravação do vendedor que efetua a inclusão do contrato
            ZZ1->ZZ1_STATUS := "1" //em Aberto
            
            ZZ1->ZZ1_MARGEM := M->ZZ1_TOTAL - nlTotCus 
            ZZ1->ZZ1_PERMRG := (M->ZZ1_TOTAL - nlTotCus) / M->ZZ1_TOTAL
			MsUnlock()
		EndIf 
		EndTran()        
		
	//Alteração			
	ElseIf nlChoice == 4

		DbSelectArea("ZZ1")
		DbSetOrder(1)
		If DbSeek(xFilial("ZZ1")+M->ZZ1_NUMORC)		
			If RecLock("ZZ1",.F.)
		
			    For nlCont := 1 To FCount()                             
			    	&("ZZ1->"+(FieldName(nlCont))) := M->&(FieldName(nlCont)) 			
				Next nlCont                                                      
				
				ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
				ZZ1->ZZ1_MARGEM := M->ZZ1_TOTAL - nlTotCus 
				ZZ1->ZZ1_PERMRG := (M->ZZ1_TOTAL - nlTotCus) / M->ZZ1_TOTAL
			
				MsUnlock()		
			EndIf
		EndIf  
		EndTran() 
	ElseIf nlChoice == 6 
	
	
		If ZZ1->(RecLock("ZZ1",.F.))
			ZZ1->ZZ1_STATUS := M->ZZ1_STATUS 
			ZZ1->ZZ1_CODCLI := M->ZZ1_CODCLI
			ZZ1->ZZ1_LOJACL := M->ZZ1_LOJACL
			ZZ1->(MSUnLock())
		EndIf
		
	EndIf
	                                       
	If nlChoice == 7
		BeginTran()
		DbSelectArea("ZZ2")
		DbSetorder(1) 
		While DbSeek(xFilial("ZZ2")+M->ZZ1_NUMORC)
			If RecLock("ZZ2",.F.)
				DbDelete()
				MsUnlock()
			EndIf
		End
		DbSelectArea("ZZ1")
		DbSetOrder(1)
		If DbSeek(xFilial("ZZ1")+M->ZZ1_NUMORC)
			If RecLock("ZZ1",.F.)
				DbDelete()
				MsUnLock()
			EndIf
		EndIf
		EndTran() 
	EndIf
		

Return()
                                                     


Static Function FillGetDd(nlChoice)
    Local nlUsado		:= 0
	Local nlI			:= 1    
	               
	//Preenchimento do aHeadProd
	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("ZZ2")
	While !(Eof()) .And. SX3->X3_ARQUIVO == "ZZ2"
	    If SX3->X3_CONTEXT <> "V" .And. !(AllTrim(SX3->X3_CAMPO) $ "ZZ2_FILIAL*ZZ2_NUMORC*ZZ2_MARGEM*ZZ2_CUSTO*ZZ2_PERMRG")
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
	//Item inicial
	aColProd[1,1] 						:= "001"	    
	
	//Se for alteração ou visualização o aColProd é preenchido pela função DadosZZ2   
    If nlChoice == 2 .Or. nlChoice == 4 .Or. nlChoice == 5 .Or. nlChoice == 6   .Or. nlChoice == 7                        
		DadosZZ2(nlChoice)
	EndIf
	
Return()             
                
/*##########################################################
#                             #
############################################################
# Função :     #  DADOSZZ2(nlChoice)                       #
############################################################
# Descrição :  #  ROTINA PARA PREENCHIMENTO DO aColProd NO    #
#			   #  CASO DE INCLUSÃO OU ALTERAÇÃO            #
############################################################
# Autor :      #  Alberto  	  	           #
############################################################
# Parâmetros : #  nlchoice:numérico -  é recebido pela 	   #
#			   #  função DADOSZZ2 para alterar o processo  #
#			   #  para alteração/inclusão				   #	
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/

Static Function DADOSZZ2(nlChoice)    
    Local clSql      := ""
    Local nlLin		 := 1
	Local nlCont     := 1
	Local clAlias	:= GetNextAlias() 
	 
	
                                   
    //Query que traz todos os produtos de um determinado contrato já existente
	clSql += " SELECT * "
	
	/*ZZ2_FILIAL "
	clSql += 		",ZZ2_NUMORC"	
	clSql += 		",ZZ2_ITEM"
	clSql += 		",ZZ2_CODPRO"
	clSql += 		",ZZ2_EAN"			
	clSql += 		",ZZ2_DESCRI"		
	clSql += 		",ZZ2_PLATF"
	clSql += 		",ZZ2_PUBLIS"
	clSql += 		",ZZ2_GENERO"
	clSql += 		",ZZ2_PRCVEN"
	clSql += 		",ZZ2_QUANT"
	clSql += 		",ZZ2_TOTAL"
	clSql += 		",ZZ2_MARKUP"
	*/	
	clSql += " FROM " + RetSqlName("ZZ2") + " ZZ2 "
	          
	clSql += " WHERE ZZ2.D_E_L_E_T_ = ' ' "
	clSql += " AND ZZ2_FILIAL = '" + xFilial("ZZ2")	+ "' "
	clSql += " AND ZZ2_NUMORC = '" + ZZ1->ZZ1_NUMORC + "' "
	clSql += " ORDER BY ZZ2_FILIAL, ZZ2_NUMORC, ZZ2_ITEM"		
	
	//TCquery clSql New Alias clAlias
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,clSql),clAlias, .F., .T.)
	 	
	TcSetField(clAlias,"ZZ2_QUANT","N",11,2)
	TcSetField(clAlias,"ZZ2_PRCVEN","N",14,2)	
	TcSetField(clAlias,"ZZ2_TOTAL","N",14,2)	
				
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
# Função :     #  VLDLINOK()		                       #
############################################################
# Descrição :  #  ROTINA QUE VALIDA A LINHA DA GETDADOS    #
############################################################
# Autor :      #  Alberto  	  	           #
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/

User Function VLDLINOK()
	Local llOk     	:= .T.  
	Local nlCont	:= 1
	Local nlAcols	:= opGetProd:oBrowse:nAt
	
	For nlCont := 1 To Len(aHeadProd)
	    
		If Empty(opGetProd:aCols[nlAcols][nlCont])	.And. AllTrim(aHeadProd[nlCont][2]) <> "ZZ2_MARKUP"	.And. AllTrim(aHeadProd[nlCont][2]) <> "ZZ2_GENERO" .And. AllTrim(aHeadProd[nlCont][2]) <> "ZZ2_PEDIDO" .And. AllTrim(aHeadProd[nlCont][2]) <> "ZZ2_ITEMPD" .And. opGetProd:aCols[nlAcols][Len(aHeadProd)+1] == .F.
			Alert("O Campo " + aHeadProd[nlCont][1] + " está vazio !")
			llOk := .F.
			Exit
		EndIf
	
	Next nlCont
	
	If llOk
		U_CalcTotal()
	EndIf

Return(llOk)       

/*##########################################################
#                 ___  "  ___                              #
#                          #
############################################################
# Função :     #  VLDTDOK()			                       #
############################################################
# Descrição :  #  ROTINA QUE VALIDA TODA A GETDADOS		   #
############################################################
# Autor :      #  Alberto  	  	           #
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/
                        
User Function VLDTDOK(nlChoice)
	Local llOk     	:= .T.  
	Local clOk	   	:= ""
	Local nlCont   	:= 1      
	Local nlCont2  	:= 1   
	Local alVld	    := {}
	Local aParam	:= {} 
	Local nLimMkp	:= 0 	

	For nlCont := 1 To Len(opGetProd:aCols)

		If !(opGetProd:aCols[nlCont][Len(aHeadProd)+1])
		    clOk += "T"
			For nlCont2 := 1 To Len(aHeadProd)
			
				If !Empty(opGetProd:aCols[nlCont][nlCont2]) .And. !(Alltrim(aHeadProd[nlCont2][2]) $ "ZZ2_ITEM")
					aAdd(alVld,.T.)
				ElseIf Empty(opGetProd:aCols[nlCont][nlCont2]) .And. !(Alltrim(aHeadProd[nlCont2][2]) $ "ZZ2_ITEM/ZZ2_MARKUP/ZZ2_GENERO/ZZ2_PEDIDO/ZZ2_ITEMPD")
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
	
	If llOk 
		U_CalcTotal()
		If nlChoice == 3 .or. nlChoice == 4
			If M->ZZ1_TOTAL < 500
				llOk := .F.
				MSGALERT("O orcamento deve ter valor mínimo de R$ 500,00.","Atencao")
			EndIf
		EndIf
			
	EndIf
	
	If nlChoice == 5
		 llOk := PergRej(aParam)
		 If llOk
		 	If ZZ1->(RecLock("ZZ1",.F.))
		 		ZZ1->ZZ1_MOTREJ := aParam[1]
		 		ZZ1->ZZ1_STATUS := "3" //Rejeitado
		 		ZZ1->(MsUnLock())
		 	EndIf 
		 Else
		 	MSGALERT("Confirme o motivo de rejeicao para que o pedido seja rejeitado","Pedido nao rejeitado")
		 EndIf 
	EndIf 
	
	If llOk
		If nlChoice == 6 
			DbSelectArea("SUS")
			DbSetOrder(1)
			
			If SUS->(dbSeek(xFilial("SUS") + M->ZZ1_PROSPC + M->ZZ1_LJPROS))
				If Empty(SUS->US_CODCLI) .Or. Empty(SUS->US_LOJACLI)
					llOk := .F. 
					MSGALERT("Prospect sem cliente cadastrado não pode ser aprovado!" ,"Atencao")
				endIf 
				M->ZZ1_CODCLI := SUS->US_CODCLI
				M->ZZ1_LOJACL	:= SUS->US_LOJACLI
				
			Else
				MSGALERT("Prospect nao encontrado não pode ser aprovado!" ,"Atencao")
				llOk := .F.
			EndIf 
			If llOk  
				M->ZZ1_STATUS := "0" //Aprovado
			EndIf
		EndIf
	EndIf
	
	If llOk
		nLimMkp	:= supergetmv("DBM_LMARK",.T.,2.2)
		If M->ZZ1_MRGMU < nLimMkp
			llOk := .F.
			MSGALERT("Mark-up inferior ao limite cadastrado " + transform(nLimMkp,"@E 99.99") + ". DBM_LMARK.","Mark Up baixo")
		EndIf
	EndIf 
			

Return(llOk)  

/*##########################################################
#                #
############################################################
# Função :     #  CALCTOTAL()		                       #
############################################################
# Descrição :  #  ROTINA QUE EFETUA O CALCULO DO VALOR     #
#			   #  TOTAL DO ORCAMENTO E ATUALIZA O CAMPO     #
#			   #  ZZ1_total								   #	 
############################################################
# Autor :      #  Alberto  	  	           #
############################################################
# Data :       #  26/02/2009                               #
############################################################
# Palavras Chaves : #                                      #
##########################################################*/

User Function CALCTOTAL()
	Local llOk 		:= .T.
	Local nlTot1	:= 0   //QUANTIDADE
	Local nlTot2	:= 0  //VALOR
	Local nlTot3	:= 0	//mARGEM	
	Local nlCont	:= 1  
	Local nlQtdItem := 0
	

	
	For nlCont := 1 To Len(opGetProd:aCols)                       
	
		If opGetProd:aCols[nlCont][Len(aHeadProd)+1] = .F.
			If ! Empty(opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO" })] ) 
				nlQtdItem += 1
	
			EndIf
				
			nlTot1 := nlTot1 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT" })]  
			nlTot2 := nlTot2 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL" })] 
			nlTot3 := nlTot3 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP" })]	 * opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT" })]  		    		    		
	    EndIf                                  
	    
	Next nlCont             
	
	//nlTot2 := Posicione("PB1",2,XFILIAL("PB1")+M->ZZ1_TIPO,"PB1_VALOR")
	

	M->ZZ1_MRGMU := nlTot3/nlTot1 
	M->ZZ1_TOTAL := nlTot2
	M->ZZ1_QTDTOT := nlTot1 
	M->ZZ1_QTITEM := nlQtdItem
	
	
 
	opMsmget:Refresh() 
	opGetProd:Refresh() 
	opDlg:Refresh()  

Return(llOk)  

User Function CALCTODE()
	Local llOk 		:= .T.
	Local nlTot1	:= 0   //QUANTIDADE
	Local nlTot2	:= 0  //VALOR
	Local nlTot3	:= 0	//mARGEM	
	Local nlCont	:= 1  
	Local nlQtdItem := 0
	

	
	For nlCont := 1 To Len(opGetProd:aCols)
		If nlCont <> N                        
	
			If opGetProd:aCols[nlCont][Len(aHeadProd)+1] = .F.
				If ! Empty(opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO" })] ) 
					nlQtdItem += 1
					
				EndIf
				
				nlTot1 := nlTot1 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT" })]  
				nlTot2 := nlTot2 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL" })] 
				nlTot3 := nlTot3 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP" })]	 * opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT" })]  		    		    		
	   		EndIf
	   	Else
	   		If opGetProd:aCols[nlCont][Len(aHeadProd)+1] = .T.
				If ! Empty(opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO" })] ) 
					nlQtdItem += 1
					
				EndIf
				
				nlTot1 := nlTot1 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT" })]  
				nlTot2 := nlTot2 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL" })] 
				nlTot3 := nlTot3 + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP" })]	 * opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT" })]  		    		    		
	   		EndIf
	   EndIf
	   		 
		                                   
	    
	Next nlCont             
	
	//nlTot2 := Posicione("PB1",2,XFILIAL("PB1")+M->ZZ1_TIPO,"PB1_VALOR")
	

	M->ZZ1_MRGMU := nlTot3/nlTot1 
	M->ZZ1_TOTAL := nlTot2
	M->ZZ1_QTDTOT := nlTot1 
	M->ZZ1_QTITEM := nlQtdItem
	
	
 
	opMsmget:Refresh() 
	opGetProd:Refresh() 
	opDlg:Refresh()  

Return(llOk) 



Static Function incluisx5() 
Local nli := 0
/*
Local alFaixa := {{"01","DE   R$500  A   R$1.000"},;
				{"02","DE   R$ 1.000,01  A   R$ 1.500"},;
				{"03","DE   R$ 1.500,01  A   R$ 3.000"},;
				{"04","DE   R$ 3.000,01  A   R$ 6.000"},;
				{"05","DE   R$ 6.000,01  A  R$ 10.000"},;
				{"06","DE R$ 10.000,01  A  R$ 20.000"},;
				{"07","DE R$ 20.000,01  A  R$ 30.000"},;
				{"08","ACIMA DE R$ 30.000"}} 
*/				
Local alEstado := {{"AC","7"},;
					{"AL",	"7"},;                       
					{"AM",	"7"},;
					{"AP",	"7"},;
					{"BA",	"7"},;
					{"CE",	"7"},;
					{"DF",	"7"},;
					{"ES",	"7"},;
					{"GO",	"7"},;
					{"MA",	"7"},;
					{"MT",	"7"},;
					{"MS",	"7"},;
					{"MG",	"12"},;
					{"PA",	"7"},;
					{"PB",	"7"},;
					{"PR",	"12"},;
					{"PE",	"7"},;
					{"PI",	"7"},;
					{"RN",	"7"},;
					{"RS",	"12"},;
					{"RJ",	"12"},;
					{"RO",	"7"},;
					{"RR",	"7"},;
					{"SC",	"12"},;
					{"SP",	"18"},;
					{"SE",	"7"},;
					{"TO",	"7"}}
					
					
	DbSelectArea("SX5")
	DbSetOrder(1)
	
    /*
	For nli := 1 to Len(alFaixa)
		If !SX5->(dbSeek(xFilial("SX5") + "_1" + alFaixa[nli,1]))
	
			If RecLock("SX5",.T.)                         
				SX5->X5_FILIAL := xFilial("SX5")
				SX5->X5_TABELA := "_1"
				SX5->X5_CHAVE	:= alFaixa[nli,1]
				SX5->X5_DESCRI	:= alFaixa[nli,2]
				SX5->X5_DESCSPA := alFaixa[nli,2]
				SX5->X5_DESCENG := alFaixa[nli,2]
				SX5->(MsUnLock())
			EndIf
		EndIf
	Next
	*/
	For nli := 1 to Len(alEstado)
		If !SX5->(dbSeek(xFilial("SX5") + "_2" + alEstado[nli,1]))
	
			If RecLock("SX5",.T.)                         
				SX5->X5_FILIAL := xFilial("SX5")
				SX5->X5_TABELA := "_2"
				SX5->X5_CHAVE	:= alEstado[nli,1]
				SX5->X5_DESCRI	:= alEstado[nli,2]
				SX5->X5_DESCSPA := alEstado[nli,2]
				SX5->X5_DESCENG := alEstado[nli,2]
				SX5->(MsUnLock())
			EndIf
		EndIf
	Next
		

Return

User Function dbmvldcpo() 
Local llret := .T.
Local clCodTab := "" 
DbSelectArea("SX5")
DbSetOrder(1)

DbSelectArea("SB2")
DbSetOrder(1)

If Empty(aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PEDIDO"})])
	If !Empty(M->ZZ1_UF)
		If SX5->(DbSeek(xFilial("SX5") + "_2" + M->ZZ1_UF)) 
			If Val(SX5->X5_DESCRI) == 7 
				clCodTab := "007"
			ElseIf Val(SX5->X5_DESCRI) == 12 
				clCodTab := "012"
			ElseIf Val(SX5->X5_DESCRI) == 18
				clCodTab := "018"
			EndIf 
		EndIf
		If AllTrim(ReadVar()) == "M->ZZ2_CODPRO" 
			DbSelectArea("SB1")
			DbSetOrder(1)
			If SB1->(DbSeek(xFilial("SB1") + M->ZZ2_CODPRO))
			 
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PUBLIS"})] := SB1->B1_PUBLISH
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_EAN"})]	:= SB1->B1_CODBAR
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_DESCRI"})] := SB1->B1_XDESC
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PLATF"})] := SB1->B1_PLATEXT 
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})] := 2 // Verificar
				If DA1->(DbSeek(xFilial("DA1") + clCodTab + M->ZZ2_CODPRO))
					aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})] := DA1->DA1_PRCVEN
					ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]	:=  opGetProd:aCols[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})] * ((M->ZZ1_ACRESC/100)+1) 
					If SB2->(dbSeek(xFilial("SB2") + M->ZZ2_CODPRO + "01")) 
						If SB2->B2_QATU > 2
							ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]	:= ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]/(SB2->B2_VATU1/SB2->B2_QATU ) 
						Else
							MSGALERT("Quantidade insuficiente em estoque", "Atencao")  
							llret := .F.
						EndIf 
					Else
						MSGALERT("Produto sem saldo", "Atencao")
						llRet := .F.
					EndIf
				Else
					MsgAlert("Produto sem tabela de preco cadastrado!","Atencao")
					llRet := .F.
				EndIf
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] := aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})] * aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]
			
				If SX5->(DbSeek(xFilial("SX5") + "Z2" + SB1->B1_CODGEN))
			   		aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_GENERO"})] := SX5->X5_DESCRI
			 	EndIf
			 	
	
				ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]	:=  aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]
	
			EndIf
		EndIf
		If AllTrim(ReadVar()) == "M->ZZ2_QUANT"
			If SX5->(DbSeek(xFilial("SX5") + "_2" + M->ZZ1_UF)) 
				If AllTrim(SX5->X5_DESCRI) == "7" 
					clCodTab := "007"
				ElseIf AllTrim(SX5->X5_DESCRI) == "12" 
					clCodTab := "012"
				ElseIf AllTrim(SX5->X5_DESCRI) == "18"
					clCodTab := "018"
				EndIf
				If DA1->(DbSeek(xFilial("DA1") + clCodTab + aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})]))
					aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})] := DA1->DA1_PRCVEN
					ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]	:=  opGetProd:aCols[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})] * ((M->ZZ1_ACRESC/100)+1) 
					If SB2->(dbSeek(xFilial("SB2") + ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})] + "01")) 
						If SB2->B2_QATU >= M->ZZ2_QUANT
							ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]	:= ACOLS[N][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]/(SB2->B2_VATU1/SB2->B2_QATU ) 
						Else
							MSGALERT("Quantidade insuficiente em estoque. Saldo " + Alltrim(Str(SB2->B2_QATU)) , "Atencao")  
							llret := .F.
						EndIf 
					Else
						MSGALERT("Produto sem saldo", "Atencao")
						llRet := .F.
					EndIf
				Else
					MsgAlert("Produto sem tabela de preco cadastrado!","Atencao")
					llRet := .F.
				EndIf
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] := aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})] * aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]
			
					
				aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})] := aCols[N,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})] * M->ZZ2_QUANT
			EndIf
		EndIf
	Else
		llRet := .F. 
		MsgAlert("Preencher UF no cabeçalho primeiro!", "Atenção")
	EndIf
Else
	llRet := .F. 
	MsgAlert("Item com pedido não pode ser alterado!", "Atenção")
EndIf
     
u_calctotal()  //Atualiza totais do cabecalho
Return llRet

User Function CalcZZ2(nOpc)
Local llret := .T.
Local clSql      := ""
Local alCatProd  := {}
Local nlTipo	:= 0
Local clTipo := ""
Local clAliaS	:= GetNextAlias() 
Local clCateg := ""
Local alCateg := {}
Local nSeed := 0
Local nAleat := 0
Local nPosCateg := 0
Local nLin := 0 
Local clCodTab := ""
Local nlmedmrg := 0
//Local nltfaixa := 0 
Local alSimCol := {} 
Local nli := 1



 

DbSelectArea("ZZ2")
DbSetOrder(1)




If nOpc == 3 
	If Empty(M->ZZ1_CLASSE) .Or. Empty(M->ZZ1_UF)
		llRet := .F.
		MSGALERT("Campo Classe e Estado são obrigatório!","Atenção")
	EndIf
Else 
	llRet := .F.
	MSGALERT("Simulação somente na inclusão de Orcamento!","Atencão!")
EndIf 
If llRet 
	If SX5->(DbSeek(xFilial("SX5") + "_2" + M->ZZ1_UF)) 
		If Val(SX5->X5_DESCRI) == 7 
			clCodTab := "007"
		ElseIf Val(SX5->X5_DESCRI) == 12 
			clCodTab := "012"
		ElseIf Val(SX5->X5_DESCRI) == 18
			clCodTab := "018"
		EndIf 
			//Criação do aColProd
			
		opGetProd:ACOLS := {}
		Aadd(opGetProd:ACOLS,Array(Len(aHeadProd) + 1))
		//Criação do registro inicial do aColProd                 	
		For nli := 1 To Len(aHeadProd) 
			opGetProd:ACOLS[Len(aColProd)][nlI]  := CriaVar(aHeadProd[nlI,2])
		Next
			
		opGetProd:ACOLS[Len(aColProd),Len(aHeadProd) +1] := .F.	
		opGetProd:Refresh()
		//Item inicial
		//opGetProd:ACOLS[1,1] 						:= "001"
	Else
		MsgAlert("Estado não existe digite um novo ou cadastre", "Atenção")
		llRet := .F.        
	EndIf
EndIf

If llRet

	clSql := " SELECT B1_COD, B1_XDESC, B1_PUBLISH, B1_CODBAR, B1_DTLANC, B1_LANC, B1_XCURABC, B1_PLATEXT,"
	clSql += " SX5.X5_DESCRI AS GENERO, SX5A.X5_DESCRI AS SUBTIPO, B2_LOCAL, DA1_PRCVEN,"
	clSql += " B2_VATU1/B2_QATU as CUSTO, (DA1_PRCVEN/(B2_VATU1/B2_QATU )) as MARKUP, B1_XSUBCLA,"

	clSql += " CASE"
	clSql += " WHEN B1_LANC = '1' AND B1_XCURABC = '1'"
	clSql += " THEN 'TOP LANCAMENTO'"
	clSql += " WHEN B1_LANC = '1' AND B1_XCURABC = '3' 
	clSql += " THEN 'LANCAMENTO' "
	clSql += " WHEN B1_LANC <> '1' AND B1_XCURABC = '1' 
	clSql += " THEN 'TOP CATALOGO' 
	clSql += " ELSE 'CATALOGO' "
	clSql += " END CATEGORIA"


	clSql += " FROM " + RetSqlName("SB1") + " SB1" 
	clSql += " JOIN " + RetSqlName("SB2") + " SB2"
	clSql += " ON B2_FILIAL = '" + xFilial("SB2") + "'"
	clSql += " AND B2_COD = B1_COD "
	clSql += " AND SB2.D_E_L_E_T_ = ' '"
	 
	clSql += " LEFT JOIN " + RetSqlName("SX5") + " SX5"
	clSql += " ON SX5.X5_CHAVE = B1_CODGEN"
	clSql += " AND SX5.X5_TABELA = 'Z2'"
	clSql += " AND SX5.D_E_L_E_T_ = ' '" 

	clSql += " LEFT JOIN " + RetSqlName("SX5") + " SX5A"
	clSql += " ON SX5A.X5_CHAVE = B1_XSUBCLA"
	clSql += " AND SX5A.X5_TABELA = 'ZT'"
	clSql += " AND SX5A.D_E_L_E_T_ = ' '"
	
	clSql += " INNER JOIN " + RetSqlName("DA1") + " DA1"
	clSql += " ON DA1_FILIAL = '" + xFilial("DA1") + "'"
	clSql += " AND DA1_CODTAB = '" + clCodTab + "'"
	clSql += " AND DA1_CODPRO = B1_COD"
	clSql += " AND DA1.D_E_L_E_T_ = ' '"
	 
	clSql += " WHERE B2_LOCAL = '01'"
	clSql += " AND B2_QATU > 1"
	clSql += " AND B2_VATU1 > 0 "
	clSql += " AND B1_TIPO = 'PA'"
	clsql += " AND B1_CODGEN <> '40'"
	clSql += " AND B1_BLQVEND = '2'" 
	clSql += " AND B1_MSBLQL = '2'"
	clSql += " AND B1_PLATAF <> '999999'" 
	clSql += " AND B1_XSUBCLA <> '  '"
	clSql += " AND B1_PUBLISH <> 'DIVERSOS'"
	clSql += " ORDER BY B1_XSUBCLA, CATEGORIA, MARKUP DESC"
	
	
	clSql := ChangeQuery(clSql)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,clSql),clAlias, .F., .T.) 
	
	DbSelectArea("SZA")
	DbSetOrder(1)
	
	DbSelectArea("ZZ3")
	DbSetOrder(1)
	
	
	
	DbSelectArea(clAlias) 
	DbGoTop()
	(clAlias)->(dbGoTop())
	clTipo := (clAlias)->B1_XSUBCLA
	nlTipo := 1
	AAdd(alCatProd,{}) 
	AADD(alCateg,(clAlias)->B1_XSUBCLA)
	
		
	While !(clAlias)->(EOF()) 
		If !Empty((clAlias)->B1_XSUBCLA) //<> "Z" 
			If clTipo <> (clAlias)->B1_XSUBCLA
				nlTipo += 1
				AAdd(alCatProd,{}) 
				clTipo := (clAlias)->B1_XSUBCLA
				AADD(alCateg,(clAlias)->B1_XSUBCLA)
			EndIf
			
			AADD(alcatProd[nlTipo] , {(clAlias)->B1_COD, (clAlias)->B1_XSUBCLA,(clAlias)->B1_XDESC,(clAlias)->B1_PUBLISH,(clAlias)->B1_CODBAR,(clAlias)->B1_PLATEXT, (clAlias)->GENERO, (clAlias)->DA1_PRCVEN, (clAlias)->CUSTO,(clAlias)->DA1_PRCVEN*((M->ZZ1_ACRESC/100)+1),"" }) 

			//(clAlias)->(dbSkip())
		/*Else
			clCateg := (clAlias)->CATEGORIA
			nlTipo += 1
			AAdd(alCatProd,{})
			AADD(alCateg,(clAlias)->CATEGORIA)
			Do While !(clAlias)->(EOF()) .And. clCateg == (clAlias)->CATEGORIA 
				AADD(alcatProd[nlTipo] , {(clAlias)->B1_COD, (clAlias)->CATEGORIA ,(clAlias)->B1_XDESC,(clAlias)->B1_PUBLISH,(clAlias)->B1_CODBAR,(clAlias)->B1_PLATEXT, (clAlias)->GENERO, (clAlias)->DA1_PRCVEN, (clAlias)->CUSTO,(clAlias)->DA1_PRCVEN*((M->ZZ1_ACRESC/100)+1),"" }) 
				(clAlias)->(dbSkip())
			EndDo */
		EndIf
		(clAlias)->(dbSkip())
	End
	If ZZ3->(DbSeek(xFilial("ZZ3") + M->ZZ1_CLASSE)) 
		//nSeed := 1 
		alSimCol := FILACOLMRG(alcatProd, alCateg) 
		
		
		For nli := 1  to Len(alSimCol)
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_ITEM"})]	:= alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_ITEM"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_EAN"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_EAN"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_DESCRI"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_DESCRI"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})] 
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PLATF"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PLATF"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PUBLIS"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PUBLIS"})]
			opGetProd:ACOLS[nli][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_GENERO"})]	:=  alSimCol[nli,aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_GENERO"})]  
			opGetProd:ACOLS[nli][Len(aHeadProd)+1]  := .F.
			If nli <> Len(alSimCol)
				aAdd(opGetProd:ACOLS,Array(Len(aHeadProd)+1		)) 
			EndIf
		
		
		Next
		 /*
		While !ZZ3->(EOF()) .And. M->ZZ1_CLASSE == ZZ3->ZZ3_CLASSE 
			nPosCateg := aScan(alCateg,{|x| AllTrim(x) == AllTrim(ZZ3->ZZ3_CODTIP) })
			 
			nAleat := RANDOMIZE ( 1 ,Len(alcatProd[nPosCateg]) )  
			
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_ITEM"})]	:= StrZero(nLin,3) 
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})]	:=  alcatProd[nPosCateg,nAleat,1]
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_EAN"})]	:=  alcatProd[nPosCateg,nAleat,5] 
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_DESCRI"})]	:=  alcatProd[nPosCateg,nAleat,3]
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]	:=  ZZ3->ZZ3_QUANT   
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})]	:=  alcatProd[nPosCateg,nAleat,8]
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})]	:=  ZZ3->ZZ3_QUANT * alcatProd[nPosCateg,nAleat,8]
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARGEM"})]	:=  alcatProd[nPosCateg,nAleat,8] / alcatProd[nPosCateg,nAleat,9] 
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PLATF"})]	:=  AllTrim(alcatProd[nPosCateg,nAleat,6])
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PUBLIS"})]	:=  alcatProd[nPosCateg,nAleat,4]
			opGetProd:ACOLS[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_GENERO"})]	:=  alcatProd[nPosCateg,nAleat,7]
			                                 	
			opGetProd:ACOLS[nLin][Len(aHeadProd)+1]  := .F. 
			
		    nLin++
			                                              													
			ZZ3->(DbSkip())                              
			
			If !ZZ3->(Eof()) .And. M->ZZ1_CLASSE == ZZ3->ZZ3_CLASSE
				aAdd(opGetProd:ACOLS,Array(Len(aHeadProd)+1		))
			EndIf		

		End
		*/  
	Else
		MSGALERT("Classe " +  AllTrim(M->ZZ1_CLASSE) + " nao encontrado na tabela ZZ3, favor verificar.", "Atenção!")
	EndIf
opGetProd:Refresh()
u_CALCTOTAL()
	
EndIf
	

Return 
       

Static Function FILACOLMRG(alcatProd, alCateg)

Local nLimInf := 0 
Local nLimSup := 0 
Local nTotal := 0
Local nTotMrg := 0 
Local ntotQtd := 0
Local alSimCol := {}
Local nMargem := 0 
Local nLin := 0
Local nAleat := 0
Local nli := 0


alSimCol := {}


If ZZ3->(DbSeek(xFilial("ZZ3") + M->ZZ1_CLASSE)) 
	//nSeed := 1
	nLin := 1
	nTotQtd := 0
	nTotMrg := 0
	nTotal := 0 
	
	While !ZZ3->(EOF()) .And. M->ZZ1_CLASSE == ZZ3->ZZ3_CLASSE  .And. nTotal <= M->ZZ1_VLRAPR
		nPosCateg := aScan(alCateg,{|x| AllTrim(x) == AllTrim(ZZ3->ZZ3_CODTIP) })
		
		If nPosCateg <> 0  
			//nAleat := RANDOMIZE ( 1 ,Len(alcatProd[nPosCateg]) ) 
			nAleat := 0
			For nli := 1 to Len(alcatProd[nPosCateg])  
				If alcatProd[nPosCateg,nli,11] == ""
					nAleat := nli
					alcatProd[nPosCateg,nli,11] := "U"
					exit
				EndIf
			Next
			
			If nAleat == 0
				ZZ3->(DbSkip())
				Loop
			EndIf 
			aAdd(alSimCol,Array(Len(aHeadProd)+1		))
			
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_ITEM"})]	:= StrZero(nLin,3) 
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})]	:=  alcatProd[nPosCateg,nAleat,1]
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_EAN"})]	:=  alcatProd[nPosCateg,nAleat,5] 
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_DESCRI"})]	:=  alcatProd[nPosCateg,nAleat,3]
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})]	:=  ZZ3->ZZ3_QUANT  
			nTotQtd += ZZ3->ZZ3_QUANT 
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})]	:=  alcatProd[nPosCateg,nAleat,8]
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]	:=  alcatProd[nPosCateg,nAleat,10]
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})]	:=  ZZ3->ZZ3_QUANT * alcatProd[nPosCateg,nAleat,10]
			nTotal += ZZ3->ZZ3_QUANT * alcatProd[nPosCateg,nAleat,8] 
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]	:=  alcatProd[nPosCateg,nAleat,10] / alcatProd[nPosCateg,nAleat,9]
			nTotMrg += ((alcatProd[nPosCateg,nAleat,10] / alcatProd[nPosCateg,nAleat,9]) * ZZ3->ZZ3_QUANT)
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PLATF"})]	:=  AllTrim(alcatProd[nPosCateg,nAleat,6])
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PUBLIS"})]	:=  alcatProd[nPosCateg,nAleat,4]
			alSimCol[nLin][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_GENERO"})]	:=  alcatProd[nPosCateg,nAleat,7]
			                                 	
		
			
		    nLin++
		EndIF
		                                              													
		ZZ3->(DbSkip()) 
		If ZZ3->(Eof()) .or. M->ZZ1_CLASSE <> ZZ3->ZZ3_CLASSE
			ZZ3->(DbSeek(xFilial("ZZ3") + M->ZZ1_CLASSE))
		EndIf                          
		
		
	End
	nMargem := nTotMrg / nTotQtd 
EndIf

 
Return alSimCol



User Function DBCALCAJ()
	Local llOk 		:= .T.
	Local nlTot1	:= 0   //QUANTIDADE
	Local nlTot2	:= 0  //VALOR
	Local nlTot3	:= 0	//mARGEM	
	Local nlCont	:= 1  
	Local nlQtdItem := 0  
	
	DbselectArea("SB2")
	DbSetOrder(1)
	
	For nlCont := 1 To Len(opGetProd:aCols)                       
	
		If opGetProd:aCols[nlCont][Len(aHeadProd)+1] = .F.  
			If SB2->(dbSeek(xFilial("SB2") + opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_CODPRO"})] + "01"))

				opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]	:=  opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRCVEN"})] * ((M->ZZ1_ACRESC/100)+1)
				opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_TOTAL"})]	:=  opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_QUANT"})] * opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})]		    		
		    	opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_MARKUP"})]	:=  opGetProd:aCols[nlCont][aScan(aHeadProd,{|x| AllTrim(x[2])=="ZZ2_PRVACR"})] / (SB2->B2_VATU1/SB2->B2_QATU)
		  	EndIf
	    EndIf                                  
	    
	Next nlCont             
	
	//nlTot2 := Posicione("PB1",2,XFILIAL("PB1")+M->ZZ1_TIPO,"PB1_VALOR")
	u_calctotal()

Return(llOk)   

                

User Function DBSC6PRO()

Local nli := 1 
Local nQtdMax	:= supergetmv("MV_MAXITPV",.T.,40) 
Local nQtditem  := 0
Local nY := 0 
Local clCodTab := ""
Local llSkip := .F.
Local nx := 0
Local nITEM    := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ITEM"})
Local nPRODUTO := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRODUTO"})
Local nUM      := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_UM"})
Local nQTDVEN  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_QTDVEN"})
Local nPRCVEN  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRCVEN"})
Local nVALOR   := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_VALOR"})
Local nSEGUM   := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_SEGUM"})
Local nTES     := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_TES"})
Local nUNSVEN  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_UNSVEN"})
Local nLOCAL   := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_LOCAL"})
Local nCF      := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_CF"})
Local nENTREG  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ENTREG"})
Local nDESCRI  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_DESCRI"})
Local nPRUNIT  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_PRUNIT"})
Local nSUGENTR := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_SUGENTR"})
Local nITEMED  := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_ITEMED"})
Local nDESCONT := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_DESCONT"})
Local nVALDESC := aScan(aHeader,{|x| AllTrim(x[2]) == "C6_VALDESC"})

Local alArea := GetArea()
Private aParam	:= {} 
                     

	DbSelectArea("SB1")
	DbSetORder(1)

	DbSelectArea("SUS")
	DbSetOrder(1)
	
	DbSelectArea("SA1")
	DbSetOrder(1)

	DbSelectArea("ZZ2")
	DbSetOrder(1)
	
	DbSelectArea("ZZ1")
	DbSetOrder(1) 
	N := Len(aCols)
	
	
	
	If Empty(AllTrim(ACOLS[nli][aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})]))
		If PergRel(aParam)
			If ZZ1->(dbSeek(xFilial("ZZ1") + aParam[1]))
				If SUS->(dbSeek(xFilial("SUS") + ZZ1->ZZ1_PROSPC + ZZ1->ZZ1_LJPROS))
					If !Empty(SUS->US_CODCLI) .And.  !Empty(SUS->US_LOJACLI)
						//M->C5_CLIENTE := SUS->US_CODCLI
						//M->C5_LOJACLI	:= SUS->US_LOJACLI
						//M->C5_CLIENT := SUS->US_CODCLI
						//M->C5_LOJAENT	:= SUS->US_LOJACLI
					EndIf
				EndIf 
				If SX5->(DbSeek(xFilial("SX5") + "_2" + ZZ1->ZZ1_UF)) 
					clCodTab := StrZero(Val(SX5->X5_DESCRI),3) 
				EndIf
				//M->C5_TABELA := clCodTab
				//M->C5_VEND1	:= M->ZZ1_VEND1 // caso precisar preenchimento automático pelo vendedor do orcamento.
				
				
		        If SA1->(dbSeek(xFilial("SA1") + M->C5_CLIENTE + M->C5_LOJACLI))
		        	//M->C5_TIPOCLI := SA1->A1_TIPO
		        	//M->C5_YCANAL	:= SA1->A1_YCANAL
		        	//M->C5_YDCANAL	:= SA1->A1_YDCANAL
				    If ZZ2->(dbSeek(xFilial("ZZ2") + aParam[1]))
				    	While !ZZ2->(EOF()) .And. AllTrim(ZZ2->ZZ2_NUMORC) == Alltrim(aParam[1]) .And. nQtditem < nQtdMax
				    		
				    	   //	A410Produto(ZZ2->ZZ2_CODPRO,.F.) 
				    	   llSkip := .F.
				    	   If Empty(ZZ2->ZZ2_PEDIDO) .AND. Empty(ZZ2->ZZ2_ITEMPD)
				    	   		nQtditem++ 
				    	
								//cTES	  := MaTesInt(2,"01" ,M->C5_CLIENT,M->C5_LOJAENT,If(M->C5_TIPO$'DB',"F","C"),ZZ2->ZZ2_CODPRO,"C6_TES")
								/*
								For nY	:= 1 To Len(aHeader) 
									If (aHeader[nY,2] <> "C6_REC_WT") .And. (aHeader[nY,2] <> "C6_ALI_WT")
										aCols[Len(aCols)][nY] := CriaVar(aHeader[nY][2])
									EndIf
		
								Next nY
								*/ 
								
								For nX :=1 to Len(aHeader)
									If !(IsHeadRec(aHeader[nX,2]) .OR. IsHeadAlias(aHeader[nX,2]))
										aCols[Len(aCols),nX] := CriaVar(aHeader[nX,2])
									EndIf
								Next nX 
								
								SB1->(dbSeek(xFilial("SB1")+ZZ2->ZZ2_CODPRO)) 
								
								aCols[Len(aCols),nITEM]    := STRZERO(Len(aCols),2)
								//aCols[Len(aCols),nITEMED]  := PadL(Right(CNB->CNB_ITEM,TamSX3("C6_ITEMED")[1]),TamSX3("C6_ITEMED")[1],"0")
								aCols[Len(aCols),nPRODUTO] := ZZ2->ZZ2_CODPRO
								aCols[Len(aCols),nUM]		:= SB1->B1_UM
								aCOls[Len(aCols),nSEGUM]	:= SB1->B1_SEGUM
								aCOls[Len(aCols),nLOCAL]	:= SB1->B1_LOCPAD
								aCols[Len(aCols),nTES]     := SB1->B1_TS
								aCols[Len(aCols),nDESCRI]  := SB1->B1_XDESC
								aCols[Len(aCols),nCF]	    := Posicione("SF4",1,xFilial("SF4")+SB1->B1_TS,"F4_CF")
								aCols[Len(aCols),nPRUNIT]  := A410Arred(ZZ2->ZZ2_PRVACR,"C6_PRUNIT")
								aCols[Len(aCols),nPRCVEN]  := A410Arred(aCols[Len(aCols),nPRUNIT],"C6_PRCVEN")
								aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCTAB"})]	:=  A410Arred(ZZ2->ZZ2_PRCVEN,"C6_PRCVEN")
								aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})]	:=  ZZ2->ZZ2_PRVACR * ZZ2->ZZ2_QUANT
								aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_XORCAM"})]	:=  ZZ2->ZZ2_NUMORC
								aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_XITORC"})]	:=  ZZ2->ZZ2_ITEM  
								/*
								If !Empty(CNB->CNB_DESC)
									aCols[len(aCols),nDESCONT] := A410Arred(CNB->CNB_DESC,"C6_DESCONT")
									aCols[Len(aCols),nPRCVEN]  -= A410Arred((CNB->CNB_VLUNIT * CNB->CNB_DESC) / 100,"C6_PRCVEN")
								EndIf
								*/
								
								//ACOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_OPER"})]	:=  "01" //Tipo Operacao
								aCols[Len(aCols),nQTDVEN] := A410Arred(ZZ2->ZZ2_QUANT,"C6_QTDVEN")
								aCols[Len(aCols),nUNSVEN] := ConvUM(ZZ2->ZZ2_CODPRO,aCols[Len(aCols),nQTDVEN],0,2) 
								
								aCols[Len(aCols),nVALOR] := A410Arred(aCols[Len(aCols),nQTDVEN] * aCols[Len(aCols),nPRCVEN],"C6_VALOR")
								//aCols[len(aCols),nVALDESC] := A410Arred((aCols[Len(aCols),nQTDVEN] * aCols[Len(aCols),nPRUNIT]) - aCols[Len(aCols),nVALOR],"C6_VALDESC")
								aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_XORCAM"})]	:=  ZZ2->ZZ2_NUMORC
								aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_XITORC"})]	:=  ZZ2->ZZ2_ITEM
								aCols[Len(aCols),nENTREG]  := dDataBase
				   				aCols[Len(aCols),nSUGENTR] := dDataBase
					    	
								//aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})]	:=  ZZ2->ZZ2_QUANT
								//aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCTAB"})]	:=  ZZ2->ZZ2_PRCVEN 
								//aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})]	:=  ZZ2->ZZ2_PRVACR
								//aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})]	:=  "01" 
								//aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})]	:=  ZZ2->ZZ2_PRVACR * ZZ2->ZZ2_QUANT
								
								//A410MultT("M->C6_PRODUTO",ACOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})])   //Ira atualizar os codigos dos produtos.
								//A410MultT("M->C6_QTDVEN", aCOLS[Len(aCols)][aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})])  //Ira atualizar as quantidades dos produtos.	
							
						
								ZZ2->(dbSkip())
								llSkip := .T.
									
						
								nli++                              
							
								If !ZZ2->(EOF()) .And. AllTrim(ZZ2->ZZ2_NUMORC) == Alltrim(aParam[1]) .And. nQtditem < nQtdMax
									aAdd(aCols,Array(Len(aHeader)+1))
				   					aCols[Len(aCols),Len(aHeader)+1] := .F.
									N := Len(aCols)
								EndIf 
								//loop
							EndIf
							If !llSkip
								ZZ2->(dbSkip())
							EndIf 
						End
						Ma410Rodap()
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	
If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif
	 
//oGetDad:refresh()	
RestArea(alArea)	
Return
	
Static Function PergRel(aParam)

//Local alParamBox := {}
Local llRet      := .T. 
Local cCodigo 	:= Space(TAMSX3("ZZ1_NUMORC")[1])
Local oDlg
Local oTpanel1 
Local nlOpc := 0
Local clCadastro := "Codigo do Orcamento" 

                                                 
DEFINE MSDIALOG oDlg TITLE clCadastro From 100,0 To 300,250 PIXEL OF oMainWnd
	oTPanel1 := TPanel():New(0,0,"",oDlg,NIL,.T.,.F.,NIL,NIL,170,240,.T.,.F.)
	oTPanel1:Align := CONTROL_ALIGN_TOP
	@ 015, 010 SAY "Orcamento:" SIZE 70,7 PIXEL OF oTPanel1
	@ 015, 065 MSGET cCodigo F3 "ZZ1" PICTURE "@!" VALID u_DBVLDORC(cCodigo) SIZE 030,7 PIXEL OF oTPanel1 
	
	DEFINE SBUTTON FROM 050,010 TYPE 1 ACTION (Iif(u_DBVLDORC(cCodigo),(nlOpc:=1,oDlg:End()),nil)) ENABLE OF oTPanel1 PIXEL
	DEFINE SBUTTON FROM 050,065 TYPE 2 ACTION (nlOpc:= 0,oDlg:End()) ENABLE OF oTPanel1 PIXEL
	

ACTIVATE MSDIALOG oDlg CENTER 

If nlOpc == 1
	aParam := {cCodigo}  
	llRet := .T.
Else
	llret := .F.
EndIf
//AADD(alParamBox,{1,"Digite Orcamento "				,Space(TAMSX3("ZZ1_NUMORC")[1])		, "@!"									,""		,"ZZ1"	,"U_DBVLDORC()",70,.F.	})

//llRet := ParamBox(alParamBox, "Parâmetros", aParam, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)
                  
Return llRet 

Static Function PergRej(aParam)

Local alParamBox := {}
Local llRet      := .T.



AADD(alParamBox,{1,"Digite motivo de Rejeicao "				,Space(TAMSX3("ZZ1_MOTREJ")[1])		, "@!"									,""		,""	,"",100,.F.	})

llRet := ParamBox(alParamBox, "Parâmetros", aParam, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)
                  
Return llRet 

User Function DBVLDORC(clcodigo)
Local llRet := .T. 

DbSelectArea("ZZ1")
DbSetOrder(1)

DbSelectArea("SUS")
DbSetOrder(1)


If ZZ1->(dbSeek(xFilial("ZZ1") + clcodigo))
	If SUS->(dbSeek(xFilial("SUS") + ZZ1->ZZ1_PROSPC + ZZ1->ZZ1_LJPROS))
		If Empty(SUS->US_CODCLI) .Or.  Empty(SUS->US_LOJACLI)
			llRet := .F.   
			MSGALERT("Orcamento com prospect sem codigo de cliente cadastrado." , "Cadastrar cliente" )
		EndIf
	EndIf
Else
	llRet := .F.
	MSGALERT("Orcamento nao encontrado. " , "Orcamento invalido" )
EndIf
			

Return llRet 


