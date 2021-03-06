#INCLUDE "PROTHEUS.CH"

/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砇ProdSoft  � Autor 矱LTON SANTANA		    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Chama a rotina para criar os produtos Software		      潮�
北�			 � quando existir produto que tem midia			  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
User Function RProdSoft()

Processa( {|| u_NCProdSoft() }, "Aguarde...", "Processando as informa珲es...",.F.)

Return

/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砃CProdSoft  � Autor 矱LTON SANTANA	    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Retotina utilizada para criar o produto Software		      潮�
北�			 � para os produtos que tem midia				  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
User Function NCProdSoft() 

Local aArea 		:= GetArea()          
Local aCpoB1Aux		:= {}//Campos utilizados na query SB1
Local aCpoB5Aux		:= {}//Campos utilizados na query SB5
Local aCamposB1 	:= {}
Local aCamposB5 	:= {}
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()           
Local aProdRep		:= {}
Local aCompProd		:= {}
Local nX			:= 0
Local nCnt			:= 0//Quantidade de registro encontrado na query
Local oProcess	
Local cCompCodSft	:= GetCtParam("NC_COMSOFT",;
								"99",;
								"C",;
								"Complemento do c骴igo do produto na r閜lica para software",;
								"Complemento do c骴igo do produto na r閜lica para software",;
								"Complemento do c骴igo do produto na r閜lica para software",;
								.F. )
Local cNCMSft		:= GetCtParam("NC_NCMSOFT",;
								"99999999",;
								"C",;
								"NCM utilizado no produto software",;
								"NCM utilizado no produto software",;
								"NCM utilizado no produto software",;
								.F. )

Local cGrpTrib		:= GetCtParam("NC_GRPTRIB",;
								"000040",;
								"C",;
								"Grupo de tributa玢o do produto software",;
								"Grupo de tributa玢o do produto software",;
								"Grupo de tributa玢o do produto software",;
								.F. )

                 
//Query utilizada para filtrar os produtos que devem ser replicados (Software e Midia)
cQuery := " SELECT * FROM "+RetSqlName("SB1")+" SB1 "+CRLF

cQuery += " LEFT JOIN "+RetSqlName("SB5")+" SB5 "+CRLF
cQuery += " ON SB5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SB5.B5_FILIAL = SB1.B1_FILIAL "+CRLF
cQuery += " AND SB5.B5_COD = SB1.B1_COD "+CRLF

cQuery += " WHERE SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SB1.B1_MIDIA = '1' "+CRLF
cQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF


//N鉶 busca os codigos ja existentes
cQuery += " AND SB1.B1_COD != TRIM(SB1.B1_COD) || "+cCompCodSft
cQuery += " AND NOT EXISTS(SELECT X FROM "+RetSqlName("SB5")+" SB5_2 "+CRLF
cQuery += " 				WHERE SB5_2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " 				AND SB5_2.B5_FILIAL = SB1.B1_FILIAL "+CRLF
cQuery += "                 AND TRIM(SB5_2.B5_COD) = TRIM(SB1.B1_COD) "+CRLF
cQuery += " 				AND B5_YSOFTW = '1' "
cQuery += "                 ) "+CRLF
cQuery += " ORDER BY B1_COD "+CRLF

cQuery	:=	ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DBSelectArea(cArqTmp)             
//Preenche o array com os campos da tabela SB1
aCpoB1Aux := {}
FOR nX := 1 TO FCount()
	If (SubStr(FieldName(nX),1,2) == "B1")
   		AADD(aCpoB1Aux,FieldName(nX))
  	EndIf
Next 

//Preenche o array com os campos da tabela SB5
aCpoB5Aux := {}
FOR nX := 1 TO FCount()
	If (SubStr(FieldName(nX),1,2) == "B5")
   		AADD(aCpoB5Aux,FieldName(nX))
  	EndIf
Next 

//Recebe os campos que ser鉶 utilizados no Execauto (ordenado de acordo com SX3)
aCamposB1 := GetCpoAuto(aCpoB1Aux, "SB1")
aCamposB5 := GetCpoAuto(aCpoB5Aux, "SB5")

DbSelectArea("SB1")
DbSetOrder(1)

DbSelectArea("SB5")
DbSetOrder(1)

//Verifica a quantidade de linhas retornada da query
(cArqTmp)->(dbGoTop())
(cArqTmp)->(dbEval({||nCnt++ }))                    

//Indicador de processamento
ProcRegua(nCnt)

(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
    
    IncProc()

	aProdRep	:= {}//Zera a variavel com o produto
	aCompProd	:= {}//Zera a variavel com o complemento do produto
	
	//Verifica se o produto (Software) ja existe na base de dados. Se existir, n鉶 ser� criado
	If !VldExisSB1(Alltrim((cArqTmp)->B1_COD) + cCompCodSft)
	
		//Grava os dados da tabela SB1
		RECLOCK("SB1",.T.)       
	
		//Preenche os campos do produto
		For nX := 1 To Len(aCamposB1)
		
			If Alltrim(aCamposB1[nX]) == "B1_COD"//Codigo do produto
				SB1->&(aCamposB1[nX]) := Alltrim((cArqTmp)->&(aCamposB1[nX]))+cCompCodSft

   			ElseIf Alltrim(aCamposB1[nX]) == "B1_POSIPI"//NCM 
				SB1->&(aCamposB1[nX]) := Alltrim(cNCMSft)

   			ElseIf Alltrim(aCamposB1[nX]) == "B1_GRTRIB"//Grupo de tributa玢o
				SB1->&(aCamposB1[nX]) := Alltrim(cGrpTrib)
	
			ElseIf (Alltrim(aCamposB1[nX]) == "B1_DESC") .Or. (Alltrim(aCamposB1[nX]) == "B1_XDESC")//Descri玢o original e descri玢o NC Games
				SB1->&(aCamposB1[nX]) := "SOFTWARE "+Alltrim((cArqTmp)->&(aCamposB1[nX]))	

			ElseIf Alltrim(aCamposB1[nX]) == "B1_INTEGRA"//Integra玢o com SAP sempre SIM
				SB1->&(aCamposB1[nX]) := "S"         

			ElseIf Alltrim(aCamposB1[nX]) == "B1_PESO"//Peso L韖uido do software
				SB1->&(aCamposB1[nX]) := 0

			ElseIf Alltrim(aCamposB1[nX]) == "B1_PESBRU"//Peso Bruto do software
				SB1->&(aCamposB1[nX]) := 0

			ElseIf Alltrim(aCamposB1[nX]) == "B1_XMOSTSI"//Mostra Site
				SB1->&(aCamposB1[nX]) := "2"

			Else                        
			
				If !Empty((cArqTmp)->&(aCamposB1[nX]))
				
					If TpCpoSX3(aCamposB1[nX]) == "D"
						SB1->&(aCamposB1[nX]) := (cArqTmp)->&(aCamposB1[nX]) //STOD((cArqTmp)->&(aCamposB1[nX]))

   					Else
						SB1->&(aCamposB1[nX]) := (cArqTmp)->&(aCamposB1[nX])

   					EndIf
				EndIf
			
			EndIf
		Next                       
		SB1->(MsUnLock())    
    
		//Verifica se o complemento do produto (Software) ja existe na base de dados. Se existir, n鉶 ser� criado.        
    	If !VldExisSB5(Alltrim((cArqTmp)->B1_COD) + cCompCodSft)
			
			//Grava os dados da tabela SB1
			RECLOCK("SB5",.T.)       

   			//Preenche os campos do complemente do produto
   			For nX := 1 To Len(aCamposB5)

					If Alltrim(aCamposB5[nX]) == "B5_COD"//Codigo
						SB5->&(aCamposB5[nX]) :=  Alltrim((cArqTmp)->&(aCamposB5[nX]))+cCompCodSft

					ElseIf TpCpoSX3(aCamposB5[nX]) == "D"//Convers鉶 de campos data
						SB5->&(aCamposB5[nX]) := (cArqTmp)->&(aCamposB5[nX]) //Stod((cArqTmp)->&(aCamposB5[nX]))
					
					Else 
						If !Empty((cArqTmp)->&(aCamposB5[nX]))
							SB5->&(aCamposB5[nX]) := (cArqTmp)->&(aCamposB5[nX]) 
						EndIf
	   	
					EndIf

       	
	   		Next                       
	
	   		SB5->(MsUnLock())
	
			//Atualiza o produto com o c骴igo do produto filho 
			AtuComProd((cArqTmp)->B1_COD, Alltrim((cArqTmp)->B1_COD) + cCompCodSft,"2")
			
			
			//Atualiza o produto com o c骴igo do produto pai
			AtuComProd(Alltrim((cArqTmp)->B1_COD) + cCompCodSft, (cArqTmp)->B1_COD,"1")

         EndIf
     EndIf
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return



/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砅EProdSoft  � Autor 矱LTON SANTANA	    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Rotina utilizada pelos pontos de entrada para Incluir,     潮�
北�			 � Alterar e Excluir							  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
User Function PEProdSoft(cCodProd, nOpc)
Local aArea 		:= GetArea()
Local aCamposB1 	:= {}
Local aCamposB5 	:= {}
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()           
Local aProdRep		:= {}
Local aCompProd		:= {}
Local nX			:= 0
Local cCodSfw		:= ""
Local cCompCodSft	:= GetCtParam("NC_COMSOFT",;
								"99",;
								"C",;
								"Complemento do c骴igo do produto na r閜lica para software",;
								"Complemento do c骴igo do produto na r閜lica para software",;
								"Complemento do c骴igo do produto na r閜lica para software",;
								.F. )
Local cNCMSft		:= GetCtParam("NC_NCMSOFT",;
								"99999999",;
								"C",;
								"NCM utilizado no produto software",;
								"NCM utilizado no produto software",;
								"NCM utilizado no produto software",;
								.F. )


Local cGrpTrib		:= GetCtParam("NC_GRPTRIB",;
								"000040",;
								"C",;
								"Grupo de tributa玢o do produto software",;
								"Grupo de tributa玢o do produto software",;
								"Grupo de tributa玢o do produto software",;
								.F. )
Local dDataTmp

Default cCodProd	:= ""
Default nOpc		:= 0

//Query utilizada para filtrar o produto que n鉶 tem r閜lica (Software e Midia)
cQuery := " SELECT * FROM "+RetSqlName("SB1")+" SB1 "+CRLF

cQuery += " LEFT JOIN "+RetSqlName("SB5")+" SB5 "+CRLF
cQuery += " ON SB5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SB5.B5_FILIAL = SB1.B1_FILIAL "+CRLF
cQuery += " AND SB5.B5_COD = SB1.B1_COD "+CRLF

cQuery += " WHERE SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SB1.B1_MIDIA = '1' "+CRLF
cQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery += " AND SB1.B1_COD = '"+cCodProd+"' "+CRLF

//Filtro efetuado apenas na inclus鉶
If nOpc == 3
	
	cQuery += " AND NOT EXISTS(SELECT X FROM "+RetSqlName("SB5")+" SB5_2 "+CRLF
	cQuery += " 				WHERE SB5_2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " 				AND SB5_2.B5_FILIAL = SB1.B1_FILIAL "+CRLF
	cQuery += "                 AND TRIM(SB5_2.B5_YCODMS) = TRIM(SB1.B1_COD) "+CRLF
	cQuery += " 				AND B5_YSOFTW = '1' "+CRLF
	cQuery += "                 ) "+CRLF
	
EndIf

cQuery	:=	ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
aEval( SB5->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cArqTmp,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
aEval( SB1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cArqTmp,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})

DBSelectArea(cArqTmp)             

//Preenche o array com os campos da tabela SB1 retornados na query
aCpoB1Aux := {}
FOR nX := 1 TO FCount()
	If (SubStr(FieldName(nX),1,2) == "B1")
   		AADD(aCpoB1Aux,FieldName(nX))
  	EndIf
Next 

//Preenche o array com os campos da tabela SB5 retornados na query
aCpoB5Aux := {}
FOR nX := 1 TO FCount()
	If (SubStr(FieldName(nX),1,2) == "B5")
   		AADD(aCpoB5Aux,FieldName(nX))
  	EndIf
Next 

//Recebe os campos que ser鉶 utilizados no Execauto (ordenado de acordo com SX3)
aCamposB1 := GetCpoAuto(aCpoB1Aux, "SB1")
aCamposB5 := GetCpoAuto(aCpoB5Aux, "SB5")

DbSelectArea("SB1")
DbSetOrder(1)

DbSelectArea("SB5")
DbSetOrder(1)


If nOpc == 3//Inclus鉶
	
	(cArqTmp)->(DbGoTop())
	While (cArqTmp)->(!Eof())
		
		aProdRep	:= {}//Zera a variavel com o produto
		aCompProd	:= {}//Zera a variavel com o complemento do produto
		
		//Verifica se o produto (Software) ja existe na base de dados
		If !VldExisSB1(Alltrim((cArqTmp)->B1_COD) + cCompCodSft)
			
			//Grava os dados da tabela SB1
			RECLOCK("SB1",.T.)
			
			//Preenche os campos do produto
			For nX := 1 To Len(aCamposB1)
				
				If Alltrim(aCamposB1[nX]) == "B1_COD"//Codigo do produto
					SB1->&(aCamposB1[nX]) := Alltrim((cArqTmp)->&(aCamposB1[nX]))+cCompCodSft
					
				ElseIf Alltrim(aCamposB1[nX]) == "B1_POSIPI"//NCM
					SB1->&(aCamposB1[nX]) := Alltrim(cNCMSft)
	   	
	   			ElseIf Alltrim(aCamposB1[nX]) == "B1_GRTRIB"//Grupo de tributa玢o
					SB1->&(aCamposB1[nX]) := Alltrim(cGrpTrib)
			
				ElseIf (Alltrim(aCamposB1[nX]) == "B1_DESC") .Or. (Alltrim(aCamposB1[nX]) == "B1_XDESC")//Descri玢o original e descri玢o NC Games
					SB1->&(aCamposB1[nX]) := "SOFTWARE "+Alltrim((cArqTmp)->&(aCamposB1[nX]))
					
				ElseIf Alltrim(aCamposB1[nX]) == "B1_INTEGRA"//Integra玢o com SAP sempre SIM
					SB1->&(aCamposB1[nX]) := "S"
					
				ElseIf Alltrim(aCamposB1[nX]) == "B1_PESO"//Peso L韖uido do software
					SB1->&(aCamposB1[nX]) := 0

				ElseIf Alltrim(aCamposB1[nX]) == "B1_PESBRU"//Peso Bruto do software
					SB1->&(aCamposB1[nX]) := 0

				ElseIf Alltrim(aCamposB1[nX]) == "B1_XMOSTSI"//Mostra Site
					SB1->&(aCamposB1[nX]) := "2"
				Else
					
					If !Empty((cArqTmp)->&(aCamposB1[nX]))
						If TpCpoSX3(aCamposB1[nX]) == "D"
							SB1->&(aCamposB1[nX]) := (cArqTmp)->&(aCamposB1[nX])
							
						Else
							SB1->&(aCamposB1[nX]) := (cArqTmp)->&(aCamposB1[nX])
							
						EndIf
					EndIf
					
				EndIf
			Next
			SB1->(MsUnLock())
			
			
			If !VldExisSB5(Alltrim((cArqTmp)->B1_COD) + cCompCodSft)
				//Grava os dados da tabela SB1
				RECLOCK("SB5",.T.)
				
				//Preenche os campos do complemente do produto
				For nX := 1 To Len(aCamposB5)
					
					If Alltrim(aCamposB5[nX]) == "B5_COD"
						SB5->&(aCamposB5[nX]) :=  Alltrim((cArqTmp)->&(aCamposB5[nX]))+cCompCodSft
						
					ElseIf Alltrim(aCamposB1[nX]) == "B5_YSOFTW"//Campo flag para informar que o produto e software
						SB1->&(aCamposB1[nX]) := "1"
						
					ElseIf TpCpoSX3(aCamposB5[nX]) == "D"
						SB5->&(aCamposB5[nX]) :=  (cArqTmp)->&(aCamposB5[nX])
						
					Else
						If !Empty((cArqTmp)->&(aCamposB5[nX]))
							SB5->&(aCamposB5[nX]) := (cArqTmp)->&(aCamposB5[nX])
						EndIf
						
					EndIf
					
					
				Next
				
				SB5->(MsUnLock())
				
				//Atualiza o complemento do produto com o c骴igo do produto filho
				AtuComProd((cArqTmp)->B1_COD, Alltrim((cArqTmp)->B1_COD) + cCompCodSft,"2")
				
				
				//Atualiza o complemento do produto com o c骴igo do produto pai
				AtuComProd(Alltrim((cArqTmp)->B1_COD) + cCompCodSft, (cArqTmp)->B1_COD,"1")
				
			EndIf
		EndIf
		(cArqTmp)->(DbSkip())
	EndDo
	
	(cArqTmp)->(DbCloseArea())
	
	
ElseIf nOpc == 4//Altera玢o
	
	
	(cArqTmp)->(DbGoTop())
	While (cArqTmp)->(!Eof())
		
		cCodSfw 	:= ""
		cCodSfw 	:= GetCodSfw(Alltrim((cArqTmp)->B1_COD))//Recupera o c骴igo do produto produto SFW
		
		If !Empty(cCodSfw)//Verifica se o produto Software foi encontrado
		
			aProdRep	:= {}//Zera a variavel com o produto
			aCompProd	:= {}//Zera a variavel com o complemento do produto
			
			//Verifica se o produto (Software) ja existe na base de dados
			If VldExisSB1(cCodSfw)
				
				If SB1->(DbSeek(xFilial("SB1") + cCodSfw))
					
					//Grava os dados da tabela SB1
					RECLOCK("SB1",.F.)
					
					//Preenche os campos do produto
					For nX := 1 To Len(aCamposB1)
						
						If "B1_COD" != Alltrim(aCamposB1[nX])//O c骴igo do produto n鉶 poder� sofrer altera珲es
							
							
							If Alltrim(aCamposB1[nX]) == "B1_POSIPI"//NCM
								SB1->&(aCamposB1[nX]) := Alltrim(cNCMSft)
								
							ElseIf (Alltrim(aCamposB1[nX]) == "B1_DESC") .Or. (Alltrim(aCamposB1[nX]) == "B1_XDESC")//Descri玢o original e descri玢o NC Games
								SB1->&(aCamposB1[nX]) := "SOFTWARE "+Alltrim((cArqTmp)->&(aCamposB1[nX]))
								
				   			ElseIf Alltrim(aCamposB1[nX]) == "B1_GRTRIB"//Grupo de tributa玢o
								SB1->&(aCamposB1[nX]) := Alltrim(cGrpTrib)

							ElseIf Alltrim(aCamposB1[nX]) == "B1_INTEGRA"//Integra玢o com SAP sempre SIM
								SB1->&(aCamposB1[nX]) := "S"
								
							ElseIf Alltrim(aCamposB1[nX]) == "B1_PESO"//Peso L韖uido do software
								SB1->&(aCamposB1[nX]) := 0

							ElseIf Alltrim(aCamposB1[nX]) == "B1_PESBRU"//Peso Bruto do software
								SB1->&(aCamposB1[nX]) := 0

							ElseIf Alltrim(aCamposB1[nX]) == "B1_XMOSTSI"//Mostra Site
								SB1->&(aCamposB1[nX]) := "2"
							Else
								
								If TpCpoSX3(aCamposB1[nX]) == "D"
								   
									If ValType((cArqTmp)->&(aCamposB1[nX])) == "C"

										dDataTmp := STOD( (cArqTmp)->&(aCamposB1[nX]) )
										
									ElseIf ValType((cArqTmp)->&(aCamposB1[nX])) == "D"  
										
										dDataTmp := (cArqTmp)->&(aCamposB1[nX])
									
									EndIf
								
									SB1->&(aCamposB1[nX]) := dDataTmp
									
								Else
									SB1->&(aCamposB1[nX]) := (cArqTmp)->&(aCamposB1[nX])
									
								EndIf
								
							EndIf
						EndIf
					Next
					
					SB1->(MsUnLock())
				EndIf
				
				//Verfica se existe o registro na base
				If VldExisSB5(Alltrim((cArqTmp)->B1_COD) + cCompCodSft)
					
					If SB5->(DbSeek(xFilial("SB5") + cCodSfw))
						
						//Grava os dados da tabela SB5
						RECLOCK("SB5",.F.)
						
						//Preenche os campos do complemente do produto
						For nX := 1 To Len(aCamposB5)
							
							If !(Alltrim(aCamposB5[nX]) $ "B5_COD|B5_YCODMS|B5_YSOFTW")//Esses campos n鉶 poder� sofrer altera珲es
								
								If TpCpoSX3(aCamposB5[nX]) == "D"
									SB5->&(aCamposB5[nX]) :=  (cArqTmp)->&(aCamposB5[nX])
									
								Else
									SB5->&(aCamposB5[nX]) := (cArqTmp)->&(aCamposB5[nX])
									
								EndIf
								
							EndIf
						Next
						
						SB5->(MsUnLock())
					EndIf
				EndIf
			EndIf
		Else 
			//Se o produto software n鉶 existir na altera玢o ent鉶 ser� criado
			MsgRun("Efetuando o cadastro do produto Software... ",;
					"Aguarde..",{|| U_PEProdSoft((cArqTmp)->B1_COD, 3)  })

		EndIF

		(cArqTmp)->(DbSkip())
	EndDo
	
	(cArqTmp)->(DbCloseArea())
	
	
ElseIf  nOpc == 5//Exclus鉶
	
	cCodSfw 	:= ""
	cCodSfw 	:= GetCodSfw(Alltrim(cCodProd))//Recupera o c骴igo do produto produto SFW
	
	If !Empty(cCodSfw)
		//Exclui o item Sfw do cadastro de produto sb1
		If SB1->(DbSeek(xFilial("SB1") + cCodSfw))
			RecLock("SB1",.F.)
			SB1->(DBDelete())
			SB1->(MsUnlock())
		EndIf
		
		//Exclui o item Sfw do complemento do produto sb5
		If SB5->(DbSeek(xFilial("SB5") + cCodSfw))
			RecLock("SB5",.F.)
			SB5->(DBDelete())
			SB5->(MsUnlock())
		EndIf
	EndIf
	
EndIf


RestArea(aArea)
Return




/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴etCpoSx3  � Autor 矱LTON SANTANA		    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Retorna os campos da tabela de acordo com o SX3		      潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GetCpoSx3(cAliasTb)

Local aArea := GetArea()
Local aRet	:= {}

Default cAliasTb := ""

If !Empty(cAliasTb)
	DbSelectArea("SX3")
	DbSetOrder(1)
	
	If SX3->(DbSeek(cAliasTb))//VERIFICA SE O ALIAS EXISTE
		
		While SX3->(!Eof()) .And. (Alltrim(SX3->X3_ARQUIVO) == Alltrim(cAliasTb))
			
			//Adiciona apenas campos reais 			
			If UPPER(Alltrim(SX3->X3_CONTEXT)) != 'V'
				Aadd(aRet,Alltrim(SX3->X3_CAMPO))
			EndIf
			
			SX3->(DbSkip())
		EndDo
		
	EndIf
	
	
EndIf
RestArea(aArea)
Return aRet
                   

/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砊pCpoSX3 � Autor 矱LTON SANTANA		    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Retorna o tipo de cmapo no SX3						      潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/
Static Function TpCpoSX3(cCpo)

Local aArea := GetArea()
Local cRet	:= ""

Default cCpo := ""

DbSelectArea("SX3")
DbSetOrder(2)
If SX3->(DbSeek(cCpo))
	cRet := SX3->X3_TIPO
EndIf

RestArea(aArea)
Return cRet



/*
苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘苘�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北赏屯屯屯屯脱屯屯屯屯屯送屯屯屯淹屯屯屯屯屯屯屯屯屯退屯屯屯淹屯屯屯屯屯屯槐�
北篜rograma  矴etCtParam篈utor  矱lton C.		     � Data �  03/13/09   罕�
北掏屯屯屯屯拓屯屯屯屯屯释屯屯屯贤屯屯屯屯屯屯屯屯屯褪屯屯屯贤屯屯屯屯屯屯贡�
北篋esc.     砇etorna o conteudo do parametro e ou cria o parametro       罕�
北�          砪aso n鉶 exista                                             罕�
北掏屯屯屯屯拓屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯贡�
北篣so       � AP                                              	          罕�
北韧屯屯屯屯拖屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯屯急�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GetCtParam( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)
lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
RecLock( "SX6", lRecLock )
FieldPut( FieldPos( "X6_VAR" ), cMvPar )
FieldPut( FieldPos( "X6_TIPO" ), cTipo )
FieldPut( FieldPos( "X6_PROPRI" ), "U" )
If !Empty( cDescP )
	FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
	FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
	FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
EndIf
If !Empty( cDescS )
	FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
	FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
	FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
EndIf
If !Empty( cDescE )
	FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
	FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
	FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
EndIf
If lRecLock .Or. lAlter
	FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
	FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
	FieldPut( FieldPos( "X6_CONTENG" ), xValor )
EndIf

MsUnlock()

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn) 


/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矨tuComProd  � Autor 矱LTON SANTANA	    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Atualiza o c骴igo de amarra玢o entre a midia e software    潮�
北�			 � no complemento do produto					  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function AtuComProd(cCodProd, cCodCompMS, cIsSoftware)

Local aArea := GetArea()
Local lRet	:= .T.

Default cCodProd	:= ""//Codigo do produto 
Default cCodCompMS	:= ""//Codigo de amrra玢o da midia e software (pai e filho)
Default cIsSoftware	:= ""

DbSelectArea("SB5")
DbSetOrder(1)
If SB5->(DbSeek(xFilial("SB5") + cCodProd ))
	
	If RECLOCK("SB5",.F.)
		SB5->B5_YCODMS := cCodCompMS
		SB5->B5_YSOFTW := cIsSoftware
		SB5->(MsUnLock())	
		lRet	:= .T.
	Else
		lRet	:= .F.
	EndIf
EndIf

RestArea(aArea)
Return lRet

/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砎ldExisSB1  � Autor 矱LTON SANTANA	    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Verifica se o registro ja existe na tabela SB1		      潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function VldExisSB1(cCod)

Local aArea := GetArea()
Local lRet	:= .F.

Default cCod := ""

DbSelectArea("SB1")
DbSetOrder(1)
If SB1->(DbSeek(xFilial("SB1") + cCod))
	lRet	:= .T.
EndIf

RestArea(aArea)
Return lRet


/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砎ldExisSB5  � Autor 矱LTON SANTANA	    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Verifica se o registro ja existe na tabela SB5		      潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function VldExisSB5(cCod)

Local aArea := GetArea()
Local lRet	:= .F.

Default cCod := ""

DbSelectArea("SB5")
DbSetOrder(1)
If SB5->(DbSeek(xFilial("SB5") + cCod))
	lRet	:= .T.
EndIf

RestArea(aArea)
Return lRet


/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴etCpoAuto  � Autor 矱LTON SANTANA	    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Rotina utilizada para retornar os campos utilizados na     潮�
北�			 � de acordo com a sequencia do SX3				  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GetCpoAuto(aCpo, cTbSx3)

Local aArea 	:= GetArea()
Local aCpoB1SX3	:= {}
Local aRet		:= {}
Local nX		:= 0
Local nY		:= 0

Default aCpo	:= {} 
Default cTbSx3	:= ""

aCpoB1SX3	:= GetCpoSx3(cTbSx3)//Campos do SX3

For nX := 1 To Len(aCpoB1SX3)
	
    For nY := 1 To Len(aCpo)
    	If Alltrim(aCpo[nY]) == Alltrim(aCpoB1SX3[nX])
			Aadd(aRet, aCpoB1SX3[nX])	
			Exit
		EndIf
	Next
	
Next 

RestArea(aArea)
Return aRet


/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    矴etCodSfw  � 	Autor 矱LTON SANTANA	    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Retorna o c骴igo do produto software						  潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/
Static Function GetCodSfw(cCod)

Local aArea := GetArea()
Local cRet	:= ""

Default cCod := ""

If !Empty(cCod)
	DbSelectArea("SB5")
	DbSetOrdeR(1)
	If SB5->(DbSeek(xFilial("SB5") + cCod))	
		cRet := SB5->B5_YCODMS 
	EndIf
EndIf

RestArea(aArea)
Return cRet
