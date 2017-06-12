#INCLUDE "PROTHEUS.CH"
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KZNCG21		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � MarkBrowse referente as alteracoes de pedidos EDI			   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   � 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KZNCG21() 
                         
	Local alCabStru	:= {}
	Local aCabecBrw := {}
	Local alStruc	:= {}
	Local alCores	:= {}
		                 
	Private apStru	:= {}
	Private cAlias	:= ""
	Private aRotina	:= {}
	Private apCheck	:= {}
	Private cCadastro 	:= "Altera�oes de Pedidos EDI"

	If Pergunte("KZFILTALT",.T.)	
		//Chamada de Cria��o do Menu
		KzOpcZAJ()
		
		//Recebe as cores de legenda
		alCores := KzCores()
			
		// Recebe cabecalho e Structura 
		alCabStru := KzCabStru() 
	
		// Recebe o Cabecalho
		aCabecBrw := alCabStru[1]
	
		// Recebe a Estrutura
		alStruc := apStru := alCabStru[2]
	
		// Monta a Tab temp 
		cAlias	:= KzAreaZAJ(alStruc)
	
		// Recebe marca para utiliza��o no borwse
		cMarca := GetMark(,cAlias,"ZAJ_OK") 
	
		// Abre markbrowse na area temporaria
		MarkBrow(cAlias,"ZAJ_OK",,aCabecBrw,,/*cMarca*/,"U_KzUnUse()",,,,"U_KzMrkZAJ()",,,,alCores)
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
���Funcao    �KzUnUse		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao realmente em branco para que o titulo de flag 		   ���
���			 �	do markbrowse nao marque nenhum item sem realizar os devidos   ���
���			 �	controles													   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   � 								                                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzUnUse()
//funcao realmente em branco para que o titulo de flag
// do markbrowse nao marque nenhum item sem realizar os devidos controles
Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzCabStru		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Array que monta o cabecalho da mkbrow e a estrutura da tab temp  ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�																   ���
������������������������������������������������������������������������������͹��
���Retorno   � Array - [1]- Cabecalho e [2]- Estrutura                         ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzCabStru() 

	Local aArea		:= GetArea()
	Local alCabec	:= {}
	// Variavel contendo os campos que irao aparecer no browse
	Local clCpoPer	:= "ZAJ_NUMALT|ZAJ_TIPPED|ZAJ_NUMEDI|ZAJ_NUMCLI|ZAJ_CLIFAT|ZAJ_LJFAT|ZAJ_CLIENT|ZAJ_LJENT|ZAJ_VEND|ZAJ_TRANSP|ZAJ_CONDPA|ZAJ_DTIMP|ZAJ_DTPVCL|ZAJ_DTPV|ZAJ_TOTAL|ZAJ_NUMPV|ZAJ_DTIENT|ZAJ_DTENTR"

	//Variavel usada para criar a estrutura da tab tempor�ria
	Local alStruct	:= {}

	If Select("SX3") != 0
		DbSelectArea("SX3")
	EndIf 
	SX3->(DbSetOrder(2))
	SX3->(DbGoTop())
	If SX3->(DbSeek("ZAJ_OK"))
 		aAdd(alCabec,{SX3->X3_CAMPO,"","",SX3->X3_PICTURE })
		aAdd(alStruct,{SX3->X3_CAMPO,SX3->X3_TIPO, SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	EndIf

	SX3->(DbSetOrder(2))
	SX3->(DbGoTop())
	If SX3->(DbSeek("ZAJ_STATUS"))
		aAdd(alStruct,{SX3->X3_CAMPO,SX3->X3_TIPO, SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	EndIf

	SX3->(DbSetOrder(1))
	SX3->(DbGoTop())
	SX3->(DbSeek("ZAJ"))
	While SX3->(!EOF()) .And. SX3->X3_ARQUIVO == "ZAJ" 
		If x3Uso(X3_USADO) .And. cNivel >= X3_NIVEL .And. (AllTrim(SX3->X3_CAMPO) $ clCpoPer)			
			If AllTrim(SX3->X3_CAMPO) == "ZAJ_TIPPED"
				aAdd(alCabec,{SX3->X3_CAMPO,"",SX3->(X3Titulo()),SX3->X3_PICTURE })
				aAdd(alStruct,{SX3->X3_CAMPO,SX3->X3_TIPO, 20,SX3->X3_DECIMAL})			
			ElseIf AllTrim(SX3->X3_CAMPO) == "ZAJ_TOTAL"
				aAdd(alCabec,{SX3->X3_CAMPO,"",SX3->(X3Titulo()),"@!"})
				aAdd(alStruct,{SX3->X3_CAMPO,"C",SX3->X3_TAMANHO,0})				
			Else
				aAdd(alCabec,{SX3->X3_CAMPO,"",SX3->(X3Titulo()),SX3->X3_PICTURE })
				aAdd(alStruct,{SX3->X3_CAMPO,SX3->X3_TIPO, SX3->X3_TAMANHO,SX3->X3_DECIMAL})
				If AllTrim(SX3->X3_CAMPO) == "ZAJ_LJFAT"
					aAdd(alCabec,{"ZAJ_NOMCLI","","Nome CliFat","@!" })
					aAdd(alStruct,{"ZAJ_NOMCLI","C", 40,0})
				EndIf
				If AllTrim(SX3->X3_CAMPO) == "ZAJ_VEND"
					aAdd(alCabec,{"ZAJ_NOMVEN","","Nome Vend","@!" })
					aAdd(alStruct,{"ZAJ_NOMVEN","C", 40,0})
				EndIf
			EndIf
		EndIf
		SX3->(DbSkip())			
	EndDo

	// Campo do Check                                       
	alStruct[1][2] := "C" 
	alStruct[1][3] := 1
	alStruct[1][4] := 0

	RestArea(aArea)

Return {alCabec,alStruct}
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzAreaZAJ		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Monta Tabela Temporaria NCGTB, para apresentar o markbrowse     ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� alStruc - Array com estrutura da tabela						   ���
������������������������������������������������������������������������������͹��
���Retorno   � clAlias - nome do Alias criado, no caso "NCGTB"                 ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzAreaZAJ(alStruc) 

	Local clAlias	:= "NCGTB"
	Local clQuery	:= ""
	Local clTabTmp	:= "" 
	Local cIndTmp	:= ""
	Local nlI 		:= 1
	Local clCliFat	:= ""
	Local clLjFat	:= ""
	Local clVend	:= ""
	
	// Limpa array de Checkados
	apCheck := {}
	
	clQuery := "SELECT " 		+CRLF
	clQuery += " ZAJ_OK "	+CRLF
	For nlI := 2 to Len(alStruc) // da posicao 2 porque a primeira contem o ZAJ_OK
		If !(AllTrim(alStruc[nlI][1]) $ "ZAJ_NOMCLI|ZAJ_NOMVEN")
			clQuery += " ," + alStruc[nlI][1] + CRLF
		EndIf	
	Next nlI
	clQuery += " From "+ RetSqlName("ZAJ")+CRLF
	clQuery += " WHERE ZAJ_FILIAL = '" + xFilial("ZAJ") + "' " + CRLF
	clQuery += " AND D_E_L_E_T_ <> '*' " + CRLF	
	
	If MV_PAR01 == 1
		clQuery += " AND ZAJ_STATUS = '1'  " + CRLF	
	ElseIf MV_PAR01 == 2
		clQuery += " AND ZAJ_STATUS = '2'  " + CRLF	
	ElseIf MV_PAR01 == 3		
		clQuery += " AND ZAJ_STATUS = '3'  " + CRLF
	EndIf
	
	If !Empty(MV_PAR02) .Or. !Empty(MV_PAR03)
		clQuery += " AND ZAJ_NUMALT BETWEEN '"+AllTrim(MV_PAR02)+"'  AND '" +AllTrim(MV_PAR03)+ "' "+ CRLF
	EndIf

	If !Empty(MV_PAR04) .Or. !Empty(MV_PAR05)
		clQuery += " AND ZAJ_CLIFAT BETWEEN '"+AllTrim(MV_PAR04)+"'  AND '" +AllTrim(MV_PAR05)+ "' "+ CRLF	
	EndIf

	If !Empty(MV_PAR06) .Or. !Empty(MV_PAR07)
		clQuery += " AND ZAJ_LJFAT BETWEEN '"+AllTrim(MV_PAR06)+"'  AND '" +AllTrim(MV_PAR07)+ "' "+ CRLF
	EndIf

	If !Empty(MV_PAR08) .Or. !Empty(MV_PAR09)
		clQuery += " AND ZAJ_DTIMP BETWEEN '"+ DtoS(MV_PAR08)+"'  AND '" +DtoS(MV_PAR09)+ "' "+ CRLF
	EndIf

	If Select("TEMP") > 0
		TEMP->(DbcloseArea())
	EndIf

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery),"TEMP",.F.,.F.)
	
	clTabTmp := CriaTrab(alStruc, .T.)
     
	dbSelectArea("TEMP")
	TEMP->(dbGoTop())
//	COPY TO &clTabTmp
	
	If Select(clAlias) > 0
  		(clAlias)->(DbCloseArea())
	EndIF
	
	DbUseArea(.T.,,clTabTmp,clAlias,.F.,.F.)
	cIndTmp := CriaTrab(Nil,.F.)
	IndRegua(clAlias,cIndTmp,"ZAJ_NUMALT+ZAJ_CLIFAT+ZAJ_LJFAT")

	DbSelectArea(clAlias)
	(clAlias)->(DbSetOrder(1))
	(clAlias)->(DbGoTop())

	While TEMP->(!Eof())
		If RecLock(clAlias, .T.)
			For nlI := 1 To Len(alStruc)
				If AllTrim(alStruc[nlI][1]) == "ZAJ_TIPPED"
					If AllTrim(&("TEMP->"+alStruc[nlI][1])) == "N"
						&(clAlias+"->"+alStruc[nlI][1]) := "Normal"
					Else
						&(clAlias+"->"+alStruc[nlI][1]) := &("TEMP->"+alStruc[nlI][1])
					EndIf
				ElseIf AllTrim(alStruc[nlI][1]) == "ZAJ_NOMCLI
					&(clAlias+"->"+alStruc[nlI][1]) := Posicione("SA1",1,xFilial("SA1")+avKey(clCliFat,"A1_COD")+avKey(clLjFat,"A1_LOJA"),"A1_NREDUZ")
				ElseIf AllTrim(alStruc[nlI][1]) == "ZAJ_NOMVEN"
			   		&(clAlias+"->"+alStruc[nlI][1]) := Posicione("SA3",1,xFilial("SA3")+clVend,"A3_NOME")
				ElseIf AllTrim(alStruc[nlI][1]) == "ZAJ_TOTAL"
			   		&(clAlias+"->"+alStruc[nlI][1]) := AllTrim(Str(&("TEMP->"+alStruc[nlI][1])))
				Else
					If alStruc[nlI][2] != "D"
						&(clAlias+"->"+alStruc[nlI][1]) := &("TEMP->"+alStruc[nlI][1])
						
						If AllTrim(alStruc[nlI][1]) == "ZAJ_CLIFAT"
							clCliFat := &("TEMP->"+alStruc[nlI][1])
						ElseIf AllTrim(alStruc[nlI][1]) == "ZAJ_LJFAT"
							clLjFat	:= &("TEMP->"+alStruc[nlI][1])
						ElseIf AllTrim(alStruc[nlI][1]) == "ZAJ_VEND"
							clVend	:= &("TEMP->"+alStruc[nlI][1])
						EndIf
					Else
						&(clAlias+"->"+alStruc[nlI][1]) := STOD(&("TEMP->"+alStruc[nlI][1]))
					EndIf
				EndIf
			Next nlI
			(clAlias)->(MsUnlock())
		EndIf
		
		TEMP->(DbSkip())
	EndDo

	If Select("TEMP") > 0
  		TEMP->(DbCloseArea())
	EndIF

	(clAlias)->(DbGoTop())
	
Return clAlias

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzCores		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Monta array com as regras de legenda, definindo as cores	       ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � alCores - Array com regras e cores definidas                    ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzCores()

	Local alCores	:= {}

	aAdd(alCores,{'Empty((cAlias)->ZAJ_STATUS).Or. (cAlias)->ZAJ_STATUS == "1" '	,'BR_VERDE'		})	// "PENDENTE"
	aAdd(alCores,{'(cAlias)->ZAJ_STATUS == "2"'										,'BR_AZUL'		})	// "APROVADA"
	aAdd(alCores,{'(cAlias)->ZAJ_STATUS == "3"'		   								,'BR_VERMELHO'	})	// "REJEITADA"

Return alCores

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzOpcZAJ		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Monta o Menu da MarkBrose	   								   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � Nenhum, porem altera a variavel aRotina que eh private do mkbrow���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzOpcZAJ()

 	aAdd(aRotina, {"Pesquisar"			,"U_KZPESQ1"	,3,1})
	aAdd(aRotina, {"Visualizar"			,"U_KzVisu"		,3,2})
	aAdd(aRotina, {"Marcar Todos"		,"U_KzSelAll"	,3,2})
	aAdd(aRotina, {"Inverte Todos"		,"U_KzInvSel"	,3,2})
	aAdd(aRotina, {"Aprovar"			,"U_KzApAlt"	,3,2})
	aAdd(aRotina, {"Rejeitar"			,"U_KzRejAlt"	,3,2})
	aAdd(aRotina, {"Filtro"				,"U_KzFilt"		,3,3})
	aAdd(aRotina, {"Legenda"			,"U_KzLegnd"	,3,3})

Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzLegnd		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao que realiza amostra de legenda						   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � 																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzLegnd()

	Local aCores	:= {}

	Aadd( aCores , { "BR_VERDE"			, "Pendente"	})
	Aadd( aCores , { "BR_AZUL" 			, "Aprovada"	})
	Aadd( aCores , { "BR_VERMELHO"		, "Rejeitada"	})
	
	BrwLegenda("Status da Altera��o de Pedidos EDI","Legenda",aCores)

Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzSelAll		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao que realiza a selecao de todos os elementos do mkbrowse  ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � 																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzSelAll()

	Local alArea	:= GetArea()
	apCheck := {}
	(cAlias)->(DbgoTop())
	While (cAlias)->(!Eof())
		If RecLock(cAlias,.F.)
			(cAlias)->ZAJ_OK := Space(2)
			(cAlias)->(MsUnlock())
		EndIf
		U_KzMrkZAJ()
		(cAlias)->(DbSkip())			
	EndDO
	MarkBRefresh()
	RestArea(alArea)
	
Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzInvSel		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao que inverte todas as selecoes do MkBrowse				   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � 																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzInvSel()

	Local alArea	:= GetArea()

	(cAlias)->(DbgoTop())
	While (cAlias)->(!Eof())
		U_KzMrkZAJ()
		(cAlias)->(DbSkip())			
	EndDO
	MarkBRefresh()	
	RestArea(alArea)
	
Return

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzMrkZAJ		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao que Efetiva as marcacoes de check na markbrowse		   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � .T.															   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzMrkZAJ()

	Local cMarca 	:= ThisMark()
	Local nlPos		:= 0

	If RecLock(cAlias,.F.)
		If (cAlias)->(IsMark("ZAJ_OK",cMarca))
			(cAlias)->ZAJ_OK := Space(2)
			
			nlPos := aScan(apCheck,{ |x| x == (cAlias)->ZAJ_NUMALT } )
			If nlPos > 0
				aDel(apCheck,nlPos)
				aSize(apCheck,Len(apCheck)-1)
			EndIf
		Else
			(cAlias)->ZAJ_OK := cMarca
			aAdd(apCheck,(cAlias)->ZAJ_NUMALT  )
		EndIf
		(cAlias)->(MsUnlock())
	EndIf
		
	MarkBRefresh()

Return .T. 
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzVisu		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Rotina que realiza a amostra do cabecalho e itens da alteracao  ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � 																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzVisu()
      
	Local aSize	:= MsAdvSize()
	                          
	Local oDlg			:= Nil
	Local oGet			:= Nil
	Local oMsMGet		:= Nil
	Local oPanel1		:= Nil
	Local oPanel2		:= Nil

	Private aHeader		:= {}
	Private aCols		:= {}
	
	If KzVrChk()
		KZCRIAHEAD()
		KzMtaCols()
	
		DEFINE MSDIALOG oDlg TITLE "Visualizar Altera��o de Pedido EDI" FROM aSize[7],0 TO aSize[6],aSize[5] PIXEL OF oDlg
			
			oDlg:lMaximized := .T.
			
			RegToMemory("ZAJ",.F.)

			M->ZAJ_NOMCLI := Posicione("SA1",1,xFilial("SA1")+avKey(M->ZAJ_CLIFAT,"A1_COD")+avKey(M->ZAJ_LJFAT,"A1_LOJA"),"A1_NREDUZ")
			M->ZAJ_NOMVEN := Posicione("SA3",1,xFilial("SA3")+M->ZAJ_VEND,"A3_NOME")

			@ 000, 000 MSPANEL oPanel1 PROMPT "Cabe�alho de Altera��o Pedido EDI" SIZE 000, 012 OF oDlg /*COLORS RGB(255,255,255),RGB(000,000,045)*/  CENTERED RAISED
			oPanel1:Align := CONTROL_ALIGN_TOP
			
			oMsMGet:= MsMget():New("ZAJ",0,2,,,,,{0,0,(aSize[6]*0.4)*0.67,0},,,,.T.,,oDlg,,.T.,,,.F.)
			oMsMGet:oBox:Align:= CONTROL_ALIGN_TOP
			
		    @ 000, 000 MSPANEL oPanel2 PROMPT "Itens de Altera��o Pedido EDI" SIZE 000, 012 OF oDlg /*COLORS RGB(255,255,255),RGB(000,000,045)*/  CENTERED RAISED
		    oPanel2:Align := CONTROL_ALIGN_BOTTOM
	
		    oGet:= MsNewGetDados():New(0,0,(aSize[6]*0.43)*0.43,0,0,,,,,,,,,,oDlg,aHeader,aCols)
			oGet:oBrowse:Align:= CONTROL_ALIGN_BOTTOM
	
		ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{|| oDlg:End()},{|| oDlg:End()},,)

	EndIf

Return
/*�������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    �KZCRIAHEAD	 �Autor  �Adam Diniz Lima 	  �Data  � 25/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Funcao que cria cabecalho da linha dos itens (GetDados)         ���
�����������������������������������������������������������������������������͹��
���Uso       �SIGAFAT                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nulo                                                            ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nulo															  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
�������������������������������������������������������������������������������*/       
Static Function KZCRIAHEAD()
	
	SX3->(DbSetOrder(1))
	If SX3->(DbSeek("ZAK"))
		While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "ZAK"
			If cNivel >= SX3->X3_NIVEL .And. !(Alltrim(SX3->X3_CAMPO) $ "ZAK_FILIAL|ZAK_NUMALT|ZAK_NUMEDI|ZAK_REVISA|ZAK_CLIFAT|ZAK_LJFAT|ZAK_DESCRI")
				
				AAdd(aHeader,	{AllTrim(X3Titulo())	,;
								SX3->X3_CAMPO			,;
								SX3->X3_PICTURE			,;
								SX3->X3_TAMANHO			,;
 								SX3->X3_DECIMAL			,;
								SX3->X3_VALID			,;
								SX3->X3_USADO			,;
								SX3->X3_TIPO			,;
								SX3->X3_F3				,;
								SX3->X3_CONTEXT			})
			EndIf
			SX3->(dbSkip())
		EndDo	
	EndIf
	
Return()

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzVrChk		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Valida se apenas um item foi selecionado para funcao Visualizar ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   � Logico, informa se abre a tela de visualizacao ou nao		   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzVrChk()
            
	Local llRet := .F.

	If Len(apCheck) == 1
		llRet := .T.
	Else
		ShowHelpDlg(OEMTOANSI("Aten��o"), {OEMTOANSI("Selecione um registro para visualiza��o")},5,{OEMTOANSI("Verifique se foi selecionado apenas um registro para ser visualizado")},5)
	EndIf

Return llRet
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzVrChk		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao que monta o acols do grid dos itens da alteracao 		   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzMtaCols()

	Local alArea := GetArea()
	Local alInfo := {}
	Local nlI	 := 1
	
	DbSelectArea("ZAJ")
	ZAJ->(DbSetOrder(1))
	If ZAJ->(DbSeek(xFilial("ZAJ")+apCheck[1] ))
		DbSelectArea("ZAK")
		ZAK->(DbSetOrder(1))	
		If ZAK->(DbSeek(xFilial("ZAK")+ZAJ->ZAJ_NUMALT))
			While ZAK->(!Eof()) .And. ZAK->ZAK_NUMALT == ZAJ->ZAJ_NUMALT
				alInfo := {}
				For nlI := 1 to Len(aHeader)
			   		aAdd(alInfo,&("ZAK->"+aHeader[nlI][2]))
				Next nlI
				aAdd(alInfo,.F.)
				aAdd(aCols,alInfo)
				ZAK->(DbSkip())
			EndDO	
		EndIf
	EndIf

	RestArea(alArea)
Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KZPESQ1		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � Funcao que monta tela para pesquisa e posicionamento na mkbrowse���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� 										    					   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KZPESQ1()

Local oDlg		:= Nil
Local olChav	:= NIl
Local clChave	:= Space(400)
Local clSet		:= ""
Local clTitulo	:= "Pesquisar Altera��o"
Local alResp	:= {"1=Num.Alt.Ped.+ Cliente Fat + Loja Cli Fat","2=Num Ped Cliente"}

DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 170,436 COLORS 0,16777215 PIXEL //OF oMainWnd 

	@ 4, 2 TO 48, 209 OF oDlg  PIXEL
	
   	@ 08,05 SAY     OemToAnsi("Chave de Pesquisa")    SIZE 46, 07 OF oDlg PIXEL
	olChav:= TComboBox():New(07,053,{|u| if(PCount()>0,clSet:=u,clSet)},alResp,150,010,oDlg,,{||  },,,,.T.,,,,{|| },,,,,'clSet')

	@ 21,05 SAY     OemToAnsi("Procurar:")    SIZE 46, 07 OF oDlg PIXEL
	@ 20,53 MSGET   clChave  Picture "@!" SIZE 150, 10 OF oDlg PIXEL 

	DEFINE SBUTTON FROM 51,154 TYPE 1 ENABLE OF oDlg ACTION {|| KzSeek(Val(clSet),AllTrim(clChave)), oDlg:End() }
	DEFINE SBUTTON FROM 51,182 TYPE 2 ENABLE OF oDlg ACTION {|| oDlg:End() }

ACTIVATE MSDIALOG oDlg CENTERED 


Return 

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzSeek		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Funcao que posiciona na markbrowse							   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�  nlSet - Indice												   ���
���			 �	clChave - Conteudo a procurar		    					   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzSeek(nlSet,clChave)

(cAlias)->(DbSetOrder(nlSet))
(cAlias)->(DbGoTop())
If (cAlias)->(!DbSeek(AllTrim(clChave)))
	(cAlias)->(DbGoTop())
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
���Funcao    �KzFilt		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Funcao chama o pergunte e realiza um filtro de resultados na tela���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�  															   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzFilt()
	
If Pergunte("KZFILTALT",.T.)
	KzAreaZAJ(apStru,.T.)
	MarkBRefresh()
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
���Funcao    �KzRejAlt		 �Autor  �Adam Diniz Lima	  � Data � 26/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Funcao que marca como rejeitado uma alteracao de pedido		   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�  															   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzRejAlt()

Local nlI	:= 1
Local alRej	:= {} 

For nlI := 1 To Len(apCheck)
	(cAlias)->(DbgoTop())
	(cAlias)->(DbSeek(apCheck[nlI]))
	If (cAlias)->ZAJ_STATUS == "1"
		aAdd(alRej,	(cAlias)->ZAJ_NUMALT)
	EndIf
Next nlI

If Len(alRej) == 0
	ShowHelpDlg(OEMTOANSI("Aten��o"), {OEMTOANSI("Rejei��o dispon�vel apenas para Altera��es Pendentes")},5,{OEMTOANSI("Selecione uma altera��o de pedido EDI pendente para realizar a Rejei��o")},5)
Else
	If MsgNoYes("Deseja Realmente Rejeitar todas as altera��es Pendentes selecionadas?")
		DbSelectArea("ZAJ")
		ZAJ->(DbSetOrder(1))
		
		For nlI := 1 to Len(alRej)
			ZAJ->(DbGoTop())			        
			If ZAJ->(DbSeek(xFilial("ZAJ")+alRej[nlI]))
				If RecLock("ZAJ", .F.)
				    ZAJ->ZAJ_STATUS := "3"
					ZAJ->(MsUnlock())
				EndIf
			EndIf
		Next nlI	
		KzAreaZAJ(apStru)
		MarkBRefresh()
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
���Funcao    �KzApAlt		 �Autor  �Adam Diniz Lima	  � Data � 31/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Funcao que Aprova a alteracao de pedido EDI					   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�  															   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
User Function KzApAlt()

Local nlI		:= 1
Local alAprv	:= {}
Local alInfo	:= {}
Local llExOk	:= .F.
Local llInOk	:= .F.
Local clMotivo	:= ""
Local clNumEdi	:= ""
Local alCabRev	:= {}
Local alItmRev	:= {}
Local clQuery	:= ""

DbSelectAreA("ZAJ")
ZAJ->(DBSetOrder(1))
DbSelectAreA("ZAE")
ZAE->(DBSetOrder(1))

For nlI := 1 To Len(apCheck)
	(cAlias)->(DbgoTop())
	(cAlias)->(DbSeek(apCheck[nlI]))
	If (cAlias)->ZAJ_STATUS != "2"
		aAdd(alAprv,{(cAlias)->ZAJ_NUMALT,(cAlias)->ZAJ_CLIFAT, (cAlias)->ZAJ_LJFAT})
	EndIf
Next nlI

If Len(alAprv) == 0
	ShowHelpDlg(OEMTOANSI("Aten��o"), {OEMTOANSI("Aprova��o dispon�vel apenas para Altera��es Pendentes ou Rejeitadas")},5,{OEMTOANSI("Selecione uma altera��o de pedido EDI Pendente ou Rejeitada para realizar a Aprova��o")},5)
Else
	If MsgYesNO("A Aprova��o ir� sobrescrever o Pedido EDI e ser� consistido novamente"+CRLF+"Deseja realmente continuar?")
		For nlI := 1 To Len(alAprv)
			ZAJ->(DbGoTop())
			If ZAJ->(DbSeek(xFilial("ZAJ")+AllTRim(alAprv[nlI][1])))
				ZAE->(DbGoTop())
				If ZAE->(DbSeek(xFilial("ZAE")+ZAJ->ZAJ_NUMEDI))				
    				If ZAE->ZAE_STATUS <> '7'
						// Exclui os registro de cabelho e item
						llExOk := KzExcEF(alAprv[nlI][1],@clNumEdi)
						If llExOk
							// Inclui a altera��o
							alInfo := KzInAlt(alAprv[nlI][1],clNumEdi)
							If Len(alInfo) > 0
								llInOk := .T.
								ZAE->(DbGoTop())
								If ZAE->(DbSeek(xFilial("ZAE")+clNumEdi))
									If RecLock("ZAE",.F.)	
										ZAE->ZAE_STATUS := U_KZNCG24(alInfo)[1][4] //Chama funcao para verificar inconsistencias
										ZAE->(MsUnlock())
									EndIf
									// Ap�s aprovar uma altera��o gera-se a revisao
       
									clQuery := " SELECT 					"+CRLF
									clQuery += "  ZAK_ITEM 					"+CRLF
									clQuery += " FROM " +RetSqlName("ZAK") + CRLF
									clQuery += " WHERE ZAK_NUMALT = '"+ AllTRim(alAprv[nlI][1]) +"' " +CRLF
									clQuery += " AND ZAK_FILIAL = '"+xFilial("ZAK")+"' " +CRLF
									clQuery += " AND D_E_L_E_T_ <> '*' " +CRLF
									clQuery += " Order By ZAK_ITEM" +CRLF																								
								    clQuery := ChangeQuery(clQuery)
						
									If Select("NCGITM") > 0
										NCGITM->(DbcloseArea())
									EndIf
							    	DbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery),"NCGITM",.F.,.F.)
						            
						            // Array do Cabecalho
						            aAdd(alCabRev,{alAprv[nlI][1],alAprv[nlI][2],alAprv[nlI][3]})
									                                                    
									While NCGITM->(!EOF())
										// Array de Itens
										aAdd(alItmRev,{alAprv[nlI][1],alAprv[nlI][2],alAprv[nlI][3],NCGITM->ZAK_ITEM})
										NCGITM->(DbSkip())
									EndDo
									NCGITM->(DbcloseArea())
									
									//Gera Revisao 
									U_KZNCG19(2,alCabRev,alItmRev)									
								EndIf
							Else
								clMotivo += "- N�o foi possivel sobrescrever o Pedido EDI " + CRLF
							EndIf
						Else
							clMotivo += "- Pedido EDI correspondente encontra-se 'Encerrado' ou 'Cancelado'" + CRLF
						EndIf
					Else
						clMotivo += "- Pedido EDI correspondente encontra-se 'Cancelado'" + CRLF				
					EndIf
				Else
					clMotivo += "- N�o foi possivel sobrescrever o Pedido EDI " + CRLF				
				EndIf
			EndIf
		Next nlI

		If !llExOk .Or. !llInOk
			
			Aviso("Aten��o",; // Titulo da Janela
			"Houve problemas no processo de Aprova��o de altera��o:"+CRLF+ clMotivo,; // Conteudo do aviso
			{"Ok"})
		EndIf
		KzAreaZAJ(apStru)
		MarkBRefresh()
	EndIf
EndIF

Return
/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzExcEF		 �Autor  �Adam Diniz Lima	  � Data � 31/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Exclui tabelas ZAE E ZAF para realizar a gravacao da alteracao   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� clNumAlt - num de alteracao do pedido						   ���
���			 � clNumEdi - Variavel que RECEBERA dessa funcao numero edi da alt ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzExcEF(clNumAlt,clNumEdi)

Local alArea	:= GetAreA()
Local llOk		:= .T.
Local clQuery	:= ""
Local clPedEDI	:= ""
 
DbSelectAreA("ZAJ")
ZAJ->(DBSetOrder(1))
DbSelectAreA("ZAK")
ZAK->(DBSetOrder(1))

DbSelectAreA("ZAE")
ZAE->(DBSetOrder(1))
DbSelectAreA("ZAF")
ZAF->(DBSetOrder(1))

Begin Transaction
	ZAJ->(DbGoTop())
	If ZAJ->(DbSeek(xFilial("ZAJ")+AllTRim(clNumAlt)))
		ZAK->(DbGoTop())
		If ZAK->(DbSeek(xFilial("ZAK")+AllTRim(clNumAlt)))
			// Caso tenha conseguido se posicionar em todas as tabelas 
			// comeca a realizar a exclusao dos registros
			clQuery := " SELECT 									"+CRLF
			clQuery += "  ZAE_NUMCLI, ZAF_NUMEDI,ZAF_REVISA,ZAF_CLIFAT,ZAF_LJFAT,ZAF_ITEM "+CRLF
			clQuery += " FROM " + RetSqlName("ZAE") + " ZAE 		"+CRLF
			clQuery += "  INNER JOIN 								"+CRLF
			clQuery += " "+RetSqlName("ZAF") + " ZAF 				"+CRLF
			clQuery += "  ON ZAE_NUMEDI = ZAF_NUMEDI				"+CRLF
			clQuery += " WHERE ZAE_FILIAL = '"+xFilial("ZAE")+"' 	"+CRLF
			clQuery += " 	AND ZAE.D_E_L_E_T_ = ''					"+CRLF
			clQuery += "    AND ZAF_FILIAL = '"+xFilial("ZAF")+"'  	"+CRLF
			clQuery += " 	AND ZAF.D_E_L_E_T_ = ''					"+CRLF
			clQuery += " 	AND ZAE.ZAE_NUMCLI = '"+PadR(ZAJ->ZAJ_NUMCLI,TamSx3("ZAE_NUMCLI")[1])+"'	"+CRLF
			clQuery += " 	AND ZAE.ZAE_CLIFAT = '"+ZAJ->ZAJ_CLIFAT+"'					"+CRLF
			clQuery += " 	AND ZAE.ZAE_LJFAT  = '"+ZAJ->ZAJ_LJFAT+"'					"+CRLF
			clQuery += " 	AND ZAE_STATUS IN ('1','2','3','4') "+CRLF		

		    clQuery := ChangeQuery(clQuery)

			If Select("NCGEA") > 0
				NCGEA->(DbcloseArea())
			EndIf
	    
			DbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery),"NCGEA",.F.,.F.)
			
			If NCGEA->(Eof())
				llOk := .F.
			Else
				clNumEdi := AllTrim(NCGEA->ZAF_NUMEDI)
			EndIf
			If llOk
				While NCGEA->(!Eof())
					If AllTrim(NCGEA->ZAF_NUMEDI) != AllTrim(clPedEDI)
						If !Empty(clPedEDI)
							ZAE->(DbGoTop())
							If ZAE->(DbSeek(xFilial("ZAE")+AllTrim(clPedEDI)))
								// Exclui os registros de inconsistencia desse pedido que sera excluido
								U_ExIncons(clPedEDI,ZAE->ZAE_CLIFAT,ZAE->ZAE_LJFAT)
								// Exclui o pedido EDI para ser Incluido a alteracao no lugar
								If RecLock("ZAE",.F.)
									ZAE->(DbDelete())
									ZAE->(MsUnlock())
								EndIf
							EndIf
							clPedEDI := AllTrim(NCGEA->ZAF_NUMEDI)
						Else
							clPedEDI := AllTrim(NCGEA->ZAF_NUMEDI)
						EndIf
					EndIf
					ZAF->(DbGoTop())
					If ZAF->(DbSeek(xFilial("ZAF")+avKey(NCGEA->ZAF_NUMEDI,"ZAF_NUMEDI")+avKey(NCGEA->ZAF_REVISA,"ZAF_REVISA")+avKey(NCGEA->ZAF_CLIFAT,"ZAF_CLIFAT")+avKey(NCGEA->ZAF_LJFAT,"ZAF_LJFAT")+avKey(NCGEA->ZAF_ITEM,"ZAF_ITEM")))
						If RecLock("ZAF",.F.)
							ZAF->(DbDelete())
							ZAF->(MsUnlock())
						EndIf
					EndIf
					NCGEA->(DbSkip())
				EndDo
				// Deleta o ultimo registro do cabecalho
				ZAE->(DbGoTop())
				If ZAE->(DbSeek(xFilial("ZAE")+AllTrim(clPedEDI)))
					// Exclui os registros de inconsistencia desse pedido que sera excluido
					U_ExIncons(clPedEDI,ZAE->ZAE_CLIFAT,ZAE->ZAE_LJFAT)
					// Exclui o pedido EDI para ser Incluido a alteracao no lugar			
					If RecLock("ZAE",.F.)
						ZAE->(DbDelete())
						ZAE->(MsUnlock())
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
End Transaction

RestArea(alArea)
Return llOk


/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KzInAlt		 �Autor  �Adam Diniz Lima	  � Data � 31/05/12    ���
������������������������������������������������������������������������������͹��
���Desc.     �Realiza gravacao da alteracao   								   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros� clNumAlt - num de alteracao do pedido						   ���
���			 � clNumEdi - Numero do Pedido EDI								   ���
������������������������������������������������������������������������������͹��
���Retorno   �																   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function KzInAlt(clNumAlt,clNumEdi)

Local alArea	:= GetAreA()
Local clNum		:= clNumEdi //U_KZFNum("ZAE","ZAE_NUMEDI")
Local llOk		:= .F.
Local alInfo	:= {}

DbSelectAreA("ZAJ")
ZAJ->(DBSetOrder(1))
DbSelectAreA("ZAK")
ZAK->(DBSetOrder(1))

ZAJ->(DbGoTop())
If ZAJ->(DbSeek(xFilial("ZAJ")+AllTRim(clNumAlt)))
	ZAK->(DbGoTop())
	If ZAK->(DbSeek(xFilial("ZAK")+AllTRim(clNumAlt)))

		Begin Transaction
			If RecLock("ZAE",.T.)
			    ZAE->ZAE_FILIAL	:=	ZAJ->ZAJ_FILIAL
				ZAE->ZAE_TIPPED	:=	ZAJ->ZAJ_TIPPED 
				ZAE->ZAE_TPNGRD	:=	ZAJ->ZAJ_TPNGRD
				ZAE->ZAE_NUMEDI	:=	clNum
				ZAE->ZAE_NUMCLI	:=	ZAJ->ZAJ_NUMCLI
				ZAE->ZAE_CLIFAT	:=	ZAJ->ZAJ_CLIFAT
				ZAE->ZAE_LJFAT	:=	ZAJ->ZAJ_LJFAT
				ZAE->ZAE_CLIENT	:=	ZAJ->ZAJ_CLIENT
				ZAE->ZAE_LJENT	:=	ZAJ->ZAJ_LJENT
				ZAE->ZAE_TIPOCL	:=	ZAJ->ZAJ_TIPOCL
				ZAE->ZAE_VEND	:=	ZAJ->ZAJ_VEND
				ZAE->ZAE_TRANSP	:=	ZAJ->ZAJ_TRANSP
				ZAE->ZAE_TPFRET	:=	ZAJ->ZAJ_TPFRET
				ZAE->ZAE_TABPRC	:=	ZAJ->ZAJ_TABPRC
				ZAE->ZAE_DTIMP	:=	ZAJ->ZAJ_DTIMP
				ZAE->ZAE_DTPVCL	:=	ZAJ->ZAJ_DTPVCL
				ZAE->ZAE_DTIENT	:=	ZAJ->ZAJ_DTIENT
				ZAE->ZAE_DTENTR	:=	ZAJ->ZAJ_DTENTR
				ZAE->ZAE_CGCENT	:=	ZAJ->ZAJ_CGCENT
				ZAE->ZAE_CGCFAT	:=	ZAJ->ZAJ_CGCFAT
				ZAE->ZAE_CGCCOB	:=	ZAJ->ZAJ_CGCCOB
				ZAE->ZAE_CGCFOR	:=	ZAJ->ZAJ_CGCFOR
				ZAE->ZAE_DESCFI	:=	ZAJ->ZAJ_DESCFI
				ZAE->ZAE_DESC1 	:=	ZAJ->ZAJ_DESC1
				ZAE->ZAE_DESC2	:=	ZAJ->ZAJ_DESC2
				ZAE->ZAE_DESC3	:=	ZAJ->ZAJ_DESC3 
				ZAE->ZAE_DESC4	:=	ZAJ->ZAJ_DESC4
				ZAE->ZAE_TOTFRT	:=	ZAJ->ZAJ_TOTFRT 
				ZAE->ZAE_TOTAL 	:=	ZAJ->ZAJ_TOTAL
				ZAE->ZAE_CONDPA	:=	ZAJ->ZAJ_CONDPA

				ZAE->(MsUnlock())
			EndIf
			While ZAK->(!EOF()) .And. AllTrim(ZAK->ZAK_NUMALT) == AllTrim(clNumAlt)
				If RecLock("ZAF",.T.)
					ZAF->ZAF_FILIAL	:=	ZAK->ZAK_FILIAL
					ZAF->ZAF_NUMEDI	:=	clNum
					ZAF->ZAF_CLIFAT	:=	ZAK->ZAK_CLIFAT
					ZAF->ZAF_LJFAT	:=	ZAK->ZAK_LJFAT
					ZAF->ZAF_ITEM	:=	ZAK->ZAK_ITEM
					ZAF->ZAF_EAN	:=	ZAK->ZAK_EAN
					ZAF->ZAF_PRODUT	:=	ZAK->ZAK_PRODUT
					ZAF->ZAF_LOCAL	:=	ZAK->ZAK_LOCAL
					ZAF->ZAF_UM		:=	ZAK->ZAK_UM
					ZAF->ZAF_QTD	:=	ZAK->ZAK_QTD
					ZAF->ZAF_UNID2	:=	ZAK->ZAK_UNID2
					ZAF->ZAF_PRCUNI	:=	ZAK->ZAK_PRCUNI
					ZAF->ZAF_TOTAL	:=	ZAK->ZAK_TOTAL
					ZAF->ZAF_DTENT	:=	ZAK->ZAK_DTENT
					ZAF->ZAF_NCM	:=	ZAK->ZAK_NCM
					ZAF->ZAF_OPER	:=	ZAK->ZAK_OPER
					ZAF->ZAF_TES	:=	ZAK->ZAK_TES
					ZAF->ZAF_CFOP	:=	ZAK->ZAK_CFOP
					ZAF->ZAF_CST	:=	ZAK->ZAK_CST
					ZAF->ZAF_DESC	:=	ZAK->ZAK_DESC
					ZAF->ZAF_VLRDES	:=	ZAK->ZAK_VLRDES
					ZAF->ZAF_PERCIP	:=	ZAK->ZAK_PERCIP
					ZAF->ZAF_VLRIPI	:=	ZAK->ZAK_VLRIPI
					ZAF->ZAF_VLRDSP	:=	ZAK->ZAK_VLRDSP
					ZAF->ZAF_VLRFRT	:=	ZAK->ZAK_VLRFRT
					ZAF->ZAF_VLRSEG	:=	ZAK->ZAK_VLRSEG
					ZAF->ZAF_PERICM	:=	ZAK->ZAK_PERICM
					ZAF->ZAF_VLRICM	:=	ZAK->ZAK_VLRICM
					ZAF->ZAF_SEQ	:=	"001"
					
					ZAF->(MsUnlock())
				EndIF
				ZAK->(DbSkip())
			EndDo
			
			If RecLock("ZAJ", .F.)
				ZAJ->ZAJ_STATUS 	:= "2"
				ZAJ->ZAJ_USRALT		:= cUserName
				ZAJ->ZAJ_DTAALT		:= dDataBase
				ZAJ->ZAJ_HORALT		:= Time()
				ZAJ->(MsUnlock())
			EndIf
			
			llOk := .T.
		End Transaction
		
	EndIf
EndIF

If llOk
	aAdd(alInfo, {clNum,ZAJ->ZAJ_CLIFAT,ZAJ->ZAJ_LJFAT})
EndIf

RestArea(alArea)
Return alInfo