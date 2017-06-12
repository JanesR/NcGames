#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³MbrwInv	     ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para criar a MarkBrowse da tela de geraão de Invoice	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function MbrwInv()
	
	Local alCampos	:= {}
	Local clArq		:= ""	

	Private cPerg	:= "KZMRKBRW"		
	Private aRotina 	:= {}   
	Private cCadastro	:= "Geração de Invoice" 
	Private cMark		:= GetMark()
	Private aCores		:= {}
	Private cNomArq1	:= ""
	Private cNomArq2	:= ""
	Private cNomArq3	:= ""
	
	AADD(aRotina,	{ "Pesquisar" 		,"U_KZPesq" 		,0, 3,1})
	AADD(aRotina,	{ "Marcar Todos"	,"U_KZMarkAll()"	,0, 3,2})
	AADD(aRotina,	{ "Inverter"		,"u_KZInvMark()"	,0, 3,2})
   	AADD(aRotina,	{ "Gerar Invoice" 	,"U_KZGeraInv"		,0, 3,2})
	AADD(aRotina,	{ "Legenda"		 	,"U_KzLeg()"		,0, 3,3})
	AADD(aRotina,	{ "Filtro"		 	,"u_KzGeraTB()"		,0, 3,3})

    dbSelectArea("SF2")
    If SF2->(FieldPos("F2_XENVINV")) == 0
    	ShowHelpDlg("INEXISTETE",{"A tabela SF2 está desatualizada, o campo F2_XENVINV não foi criado no dicionário de dados."},5,{"Executar o compatibilizador UPDNCG12 ou criar o campo manualmente."},5)
    	Return
    EndIf
	AjustaSx1(cPerg)	
	If Pergunte(cPerg,.T.)
		u_KzGeraTB(.F.)

		//Inlcui as legendas no array de cores
		AADD(aCores,{"TB_STATUS == '6'", "BR_VERMELHO"})
		AADD(aCores,{"TB_STATUS <> '6'", "BR_VERDE"})
		
		//Cria o array com os campos que serão apresentados na markbrowse
		AADD(alCampos,{"TB_OK"		,Nil,"",""})
		AADD(alCampos,{"TB_CODCLI"	,Nil,"Cliente",""})
		AADD(alCampos,{"TB_LOJA"	,Nil,"Loja",""})
		AADD(alCampos,{"TB_NOMCLI"	,Nil,"Nome Cli.",""})
		AADD(alCampos,{"TB_CODNF"	,Nil,"Num Nota",""})
		AADD(alCampos,{"TB_SERIE"	,Nil,"Serie",""})
		AADD(alCampos,{"TB_EMISSAO"	,Nil,"Emissao",""})
		AADD(alCampos,{"TB_NUMEDI"	,Nil,"Num Ped EDI",""})
		AADD(alCampos,{"TB_VEND"	,Nil,"Vendedor",""})
		AADD(alCampos,{"TB_NOMVEN"	,Nil,"Nome Vend",""})
		
		dbSelectArea("TRB")
		TRB->(dbGoTop())
		MarkBrow( 'TRB', "TB_OK",,alCampos,, cMark,,,,,"u_KzMark()",/*{||}*/,,,aCores)
		
		TRB->(dbCloseArea())
		// apaga a tabela temporária 
		MsErase(clArq+GetDBExtension(),,"DBFCDX") 
	EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZGeraTB	     ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para criar a tabela temporaria que será usada na		  º±± 
±±ºRetorno   ³MarkBrowse de geração de arquivo Invoice.						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZGeraTB(lFilt)

	Local alStruct	:= {}
	Local alTam		:= {}
	Local clWhere	:= ""
	
	Default lFilt	:= .T.
    
	If lFilt
		Pergunte(cPerg,.T.)
	EndIf
	Aadd(alStruct,{"TB_OK","C",2,0})
	
	alTam := TamSx3("ZAE_STATUS")
	Aadd(alStruct,{"TB_STATUS","C",alTam[1],alTam[2]})
	       
	alTam := TamSx3("ZAE_NUMEDI")
	Aadd(alStruct,{"TB_NUMEDI","C",alTam[1],alTam[2]})
	   	
	alTam := TamSx3("A1_COD")
	Aadd(alStruct,{"TB_CODCLI","C",alTam[1],alTam[2]})
	   
	alTam := TamSx3("A1_LOJA")
	Aadd(alStruct,{"TB_LOJA","C",alTam[1],alTam[2]})
	alTam := TamSx3("A1_NREDUZ")
	Aadd(alStruct,{"TB_NOMCLI","C",alTam[1],alTam[2]})
	   
	alTam := TamSx3("F2_DOC")
	Aadd(alStruct,{"TB_CODNF","C",alTam[1],alTam[2]})
	   
	alTam := TamSx3("F2_SERIE")
	Aadd(alStruct,{"TB_SERIE","C",alTam[1],alTam[2]})
	   
	alTam := TamSx3("F2_EMISSAO")
	Aadd(alStruct,{"TB_EMISSAO","D",alTam[1],alTam[2]})   
	alTam := TamSx3("A3_COD")
	Aadd(alStruct,{"TB_VEND","C",alTam[1],alTam[2]})

	alTam := TamSx3("A3_NOME")
	Aadd(alStruct,{"TB_NOMVEN","C",alTam[1],alTam[2]})	
	
	clArq:=Criatrab(,.F.)
	MsCreate(clArq,alStruct,"DBFCDX")
	Sleep(1000)
	
	If Select("TRB") > 0
		TRB->(dbCloseArea())
	EndIf
	
	// atribui a tabela temporária ao alias TRB
	dbUseArea(.T.,"DBFCDX",clArq,"TRB",.T.,.F.)
			
	//cria os indices da tabela temporaria
	cNomArq1 := Subs(clArq,1,7)+"A"
	IndRegua("TRB",cNomArq1,"TB_CODCLI+TB_LOJA+TB_CODNF+TB_SERIE+DTOS(TB_EMISSAO)",,,"Selecionando Registros...")	
	cNomArq2 := Subs(clArq,1,7)+"B"
	IndRegua("TRB",cNomArq2,"TB_CODNF+TB_SERIE",,,"Selecionando Registros...")	
	cNomArq3 := Subs(clArq,1,7)+"C"
	IndRegua("TRB",cNomArq3,"TB_NUMEDI",,,"Selecionando Registros...")	
	
	dbClearIndex()	
	
	dbSetIndex(cNomArq1+OrdBagExt())
	dbSetIndex(cNomArq2+OrdBagExt())
	dbSetIndex(cNomArq3+OrdBagExt())
	
	If Mv_Par01 == 1
		clWhere := "'5'"
	Else
		clWhere := "'5','6'"
	EndIf
		
	clQuery := " SELECT	F2_DOC," + CRLF
	clQuery += " 		F2_SERIE," + CRLF
	clQuery += " 		F2_CLIENTE," + CRLF
	clQuery += " 		F2_LOJA," + CRLF
	clQuery += " 		F2_EMISSAO," + CRLF
	clQuery += " 		ZAE_NUMEDI," + CRLF
	clQuery += " 		ZAE_STATUS," + CRLF
	clQuery += " 		ZAE_VEND " + CRLF
	clQuery += " FROM" + CRLF
	clQuery += " 	(" + CRLF
	clQuery += " 		SELECT	F2_DOC," + CRLF
	clQuery += " 				F2_SERIE," + CRLF
	clQuery += " 				F2_CLIENTE," + CRLF
	clQuery += " 				F2_LOJA," + CRLF
	clQuery += " 				F2_EMISSAO" + CRLF
	clQuery += " 		FROM " + RETSQLNAME("SF2") + CRLF
	clQuery += " 		WHERE	D_E_L_E_T_ <> '*'" + CRLF
	clQuery += " 				AND F2_FILIAL = '" + xFilial("SF2") + "'" + CRLF
	clQuery += " 	)SF2" + CRLF
	clQuery += " INNER JOIN " + CRLF
	clQuery += " (" + CRLF
	clQuery += " 			SELECT	D2_DOC," + CRLF
	clQuery += " 					D2_SERIE," + CRLF
	clQuery += " 					D2_PEDIDO" + CRLF
	clQuery += " 			FROM " + RETSQLNAME("SD2") + CRLF
	clQuery += " 			WHERE	D_E_L_E_T_ <> '*'" + CRLF
	clQuery += " 					AND D2_FILIAL = '" + xFilial("SD2") + "'" + CRLF
	clQuery += " 			GROUP BY D2_DOC,D2_SERIE,D2_PEDIDO" + CRLF		
	clQuery += " )SD2 ON SD2.D2_DOC = SF2.F2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE" + CRLF
	clQuery += " INNER JOIN (" + CRLF
	clQuery += " 			SELECT	C5_NUM," + CRLF
	clQuery += " 					C5_NUMEDI" + CRLF
	clQuery += " 			FROM " + RETSQLNAME("SC5") + CRLF
	clQuery += " 			WHERE	D_E_L_E_T_ <> '*'" + CRLF
	clQuery += " 					AND C5_FILIAL = '" + xFilial("SC5") + "'" + CRLF
	clQuery += " )SC5 ON SD2.D2_PEDIDO = SC5.C5_NUM" + CRLF
	clQuery += " INNER JOIN (" + CRLF
	clQuery += " 			SELECT	ZAE_NUMEDI," + CRLF
	clQuery += " 					ZAE_STATUS," + CRLF
	clQuery += " 					ZAE_VEND" + CRLF
	clQuery += " 			FROM " + RETSQLNAME("ZAE") + CRLF
	clQuery += " 			WHERE	D_E_L_E_T_ <> '*'" + CRLF
	clQuery += " 					AND ZAE_FILIAL = '" + xFilial("ZAE") + "'" + CRLF
	clQuery += " 					AND ZAE_STATUS IN (" + clWhere + ")" + CRLF
	clQuery += " ) ZAE ON ZAE.ZAE_NUMEDI = SC5.C5_NUMEDI" + CRLF
	clQuery += " ORDER BY F2_CLIENTE,ZAE_NUMEDI" + CRLF
	
	//Change query para ajustar a query para oracle
	clQuery := ChangeQuery(clQuery)
	
	If Select("TMP1") > 0
		TMP1->(dbCloseArea())
	EndIf
	
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "TMP1", .F., .F. )
	//Preenche a tabela temporaria com as notas que foram geradas a partir de pedidos de venda com pedidos EDI
	While TMP1->(!Eof())
		If !Empty(Posicione("ZAA",1,xFilial("ZAA")+TMP1->F2_CLIENTE+TMP1->F2_LOJA+"04","ZAA_TPDOC"))
			RecLock("TRB",.T.)
			
			Replace TB_OK		with ""
			Replace TB_STATUS	with TMP1->ZAE_STATUS
			Replace TB_CODCLI	with TMP1->F2_CLIENTE
			Replace TB_LOJA		with TMP1->F2_LOJA
			Replace TB_NOMCLI	with Posicione("SA1",1,xFilial("SA1")+avKey(TMP1->F2_CLIENTE,"A1_COD")+avKey(TMP1->F2_LOJA,"A1_LOJA"),"A1_NREDUZ")
			Replace TB_CODNF	with TMP1->F2_DOC
			Replace TB_SERIE	with TMP1->F2_SERIE
			Replace TB_EMISSAO	with StoD(TMP1->F2_EMISSAO)
			Replace TB_NUMEDI	with TMP1->ZAE_NUMEDI
			Replace TB_VEND 	with TMP1->ZAE_VEND
			Replace TB_NOMVEN	with Posicione("SA3",1,xFilial("SA3")+TMP1->ZAE_VEND,"A3_NOME")
			
			TRB->(msUnlock())
		EndIf
		TMP1->(dbSkip())
	EndDo
	TMP1->(dbCloseArea())
	TRB->(dbGoTop())

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZLeg		     ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para criar a tela de legenda.							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZLeg()
	Local aLegenda := {}

	AADD(aLegenda,{"BR_VERDE"		,"Invoice não gerada." })
	AADD(aLegenda,{"BR_VERMELHO"	,"Invoice gerada." })

	BrwLegenda(cCadastro, "Legenda", aLegenda)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZMarkAll	     ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para marcar todos os itens da markbrowse				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZMarkAll()
	Local oMark := GetMarkBrow()

	dbSelectArea('TRB')
	dbGotop()
	While !Eof()
        RecLock( 'TRB', .F. )
        	Replace TB_OK With cMark
        MsUnLock()
        TRB->(dbSkip())
	End
	MarkBRefresh( )
	// força o posicionamento do browse no primeiro registro
	oMark:oBrowse:Gotop()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZMark	     ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para marcar o item posicionado na markbrowse			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KzMark()
	If TRB->(!Eof())
		If IsMark( 'TB_OK', cMark )
	        RecLock( 'TRB', .F. )
	                Replace TB_OK With Space(2)
	        MsUnLock()
		Else
	        RecLock( 'TRB', .F. )
	                Replace TB_OK With cMark
	        MsUnLock()
		EndIf
	EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZInvMark	     ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para inverter a seleção na markbrowse					  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZInvMark()
	Local oMark := GetMarkBrow()
	TRB->(dbGoTop())
	While TRB->(!Eof())
		u_KzMark()
		TRB->(dbSkip())
	EndDo
	MarkBRefresh()
	// força o posicionamento do browse no primeiro registro
	oMark:oBrowse:Gotop()
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZGeraInv      ºAutor  ³Alfredo A. MagalhaesºData  ³19/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para o arquivo invoice dos registros marcados.			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZGeraInv()
//	Local oMark		:= GetMarkBrow()	
	Local alItens	:= {}
	Local alNfs		:= {}
//	Private apNotas	:= {}
	
	dbSelectArea("ZAA")
	ZAA->(dbSetOrder(1))
	If MsgYesNo("Deseja realmente gerar o arquivo invoice para as notas selecionadas?","Deseja Continuar?")
		TRB->(dbGoTop())
		While TRB->(!EOF())			
			If TRB->TB_OK == cMark
				If ZAA->(dbSeek(xFilial("ZAA")+TRB->TB_CODCLI+TRB->TB_LOJA+"04"))
					AADD(alItens,{TRB->TB_CODCLI,TRB->TB_LOJA,TRB->TB_CODNF,TRB->TB_SERIE,TRB->TB_NUMEDI,TRB->TB_EMISSAO})
				EndIf
			EndIf
			TRB->(dbSkip())
		EndDo
		If Len(alItens) == 0
			MsgInfo("Nenhum item foi marcado!","Atenção!")
		Else
			LjMsgRun("Aguarde... Criando Invoices","NC GAMES",{|| alNfs := u_KZGrInv(alItens, .F.)	})
			If Len(alNfs) > 0
				LjMsgRun("Aguarde... Atualizando pedidos EDI.","NC GAMES",{|| u_KZAtuEdi(alNfs),	u_KzGeraTb(.F.)	})
				
//				LjMsgRun("Aguarde... Gerando XML.","NC GAMES",{|| KzGetXml()	})
			EndIf
		EndIf
	EndIf
	TRB->(dbGoTop())
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZAtuEdi	     ºAutor  ³Alfredo A. MagalhaesºData  ³04/06/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para atualizar o status dos pedido EDI.				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³aAtu - Array com numero dos pedidos EDI a serem atualizados	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZAtuEdi(aAtu)
	
	Local nx		:= 0
	Local clNumCli	:= ""
//	Local clQuery	:= ""
	
	If Select("ZAE") == 0
		dbSelectArea("ZAE")
	EndIf
	ZAE->(dbSetOrder(1)) // Filial+numero do pedido EDI
	ZAE->(dbGoTop())
	If Select("SF2") == 0
		dbSelectArea("SF2")
	EndIf
	SF2->(dbSetOrder(2))
	SF2->(dbGoTop())
	
	If Select("ZAH") == 0
		dbSelectArea("ZAH")
	EndIf
	ZAH->(dbSetOrder(1))
	ZAH->(dbGoTop())
	
	If Select("ZAJ") == 0
		dbSelectArea("ZAJ")
	EndIf
	ZAJ->(dbSetOrder(2))
	ZAJ->(dbGoTop())
	
	For nx:= 1 to len(aAtu)
		Begin Transaction
			If ZAE->(dbSeek(xFilial("ZAE")+aAtu[nx][1]+aAtu[nx][4]+aAtu[nx][5]))
				// Alimenta array para geracao do XML
				// 				[1 -Saida]	,[Serie]   		,[Numero NF]	, [Cliente]			, [Loja]
//				aAdd(apNotas, {"1"			,aAtu[nx][3]	,aAtu[nx][2]	,aAtu[nx][4]		,aAtu[nx][5] })
				
				If RecLock("ZAE",.F.)
					ZAE->ZAE_STATUS	:= "6"
//					ZAE->ZAE_NUMNF	:= aAtu[nx][2]
//					ZAE->ZAE_NFSERI	:= aAtu[nx][3]
//					ZAE->ZAE_DTINV	:= aAtu[nx][6] 
					
					//Salva a informação em uma variavel caso haja um desposicionamento da tabela
					clNumCli		:= ZAE->ZAE_NUMCLI
					ZAE->(msUnlock())
					
					If SF2->(dbSeek(xFilial("SF2")+aAtu[nx][4]+aAtu[nx][5]+aAtu[nx][2]+aAtu[nx][3]))
						If RecLock("SF2",.F.)
							SF2->F2_XENVINV := "1"
							SF2->F2_DTINV	:= dDatabase							
							SF2->(msUnlock())
							                                         
							/*
							//Atualiza a tabela de revisao do pedido.
							clQuery := " SELECT	ZAH_NUMEDI, " + CRLF
							clQuery += " 		ZAH_CLIFAT, " + CRLF
							clQuery += " 		ZAH_LJFAT " + CRLF
							clQuery += " FROM " + RETSQLNAME("ZAH") + CRLF
							clQuery += " WHERE	D_E_L_E_T_ <> '*' " + CRLF
							clQuery += " 		AND ZAH_FILIAL = '" + xFilial("ZAH")+"' " + CRLF
							clQuery += " 		AND ZAH_VERSAO =	( " + CRLF
							clQuery += " 								SELECT MAX(ZAH_VERSAO) FROM " + RETSQLNAME("ZAH") + CRLF
							clQuery += " 								WHERE	D_E_L_E_T_ <> '*' " + CRLF
							clQuery += " 								AND ZAH_FILIAL = '" + xFilial("ZAH")+ "' " + CRLF
							clQuery += " 								AND ZAH_NUMEDI = '" + aAtu[nx][1] + "' " + CRLF
							clQuery += " 								AND ZAH_CLIFAT = '" + aAtu[nx][4] + "' " + CRLF
 							clQuery += " 								AND ZAH_LJFAT  = '" + aAtu[nx][5] + "' " + CRLF
							clQuery += " 							) " + CRLF
							clQuery += " 		AND ZAH_NUMEDI = '" + aAtu[nx][1] + "' " + CRLF
							clQuery += " 		AND ZAH_CLIFAT = '" + aAtu[nx][4] + "' " + CRLF
 							clQuery += " 		AND ZAH_LJFAT  = '" + aAtu[nx][5] + "' " + CRLF
							
							clQuery := ChangeQuery(clQuery)
							
							If Select("TMP1") > 0
								TMP1->(dbCloseArea())
							EndIf
							dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "TMP1", .F., .F. )
							If TMP1->(!EOF())
								If ZAH->(dbSeek(xFilial("ZAH")+TMP1->ZAH_NUMEDI+TMP1->ZAH_CLIFAT+TMP1->ZAH_LJFAT))
									If RecLock("ZAH",.F.)
										ZAH->ZAH_NUMINV	:= aAtu[nx][2]
										ZAH->ZAH_NFSERI	:= aAtu[nx][3]
										ZAH->ZAH_DTINV	:= aAtu[nx][6]
										ZAH->(msUnlock())
									EndIf
								EndIf
							EndIf
							TMP1->(dbCloseArea())
							
							clQuery := " SELECT R_E_C_N_O_ AS REC " + CRLF
							clQuery += " FROM " + RETSQLNAME("ZAJ") + CRLF
							clQuery += " WHERE ZAJ_DTAALT+ZAJ_HRALT =  " + CRLF
							clQuery += " ( " + CRLF
							clQuery += " 	SELECT	MAX(ZAJ_DTAALT) || " + CRLF
							clQuery += " 			MAX(ZAJ_HRALT)  " + CRLF
							clQuery += " 	FROM " + RETSQLNAME("ZAJ") + CRLF
							clQuery += " 	WHERE	D_E_L_E_T_ <> '*' " + CRLF
							clQuery += " 			AND ZAJ_FILIAL = '" + xFilial("ZAJ") + "' " + CRLF
							clQuery += " 			AND ZAJ_NUMCLI = '" + clNumCli + "' " + CRLF
							clQuery += " 			AND ZAJ_STATUS = '2' " + CRLF
							clQuery += " )" + CRLF
							
							clQuery := ChangeQuery(clQuery)
							
							If Select("TMP1") > 0
								TMP1->(dbCloseArea())
							EndIf
							dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "TMP1", .F., .F. )							
							
							//Atualiza a tabela de alteração de pedido
							If TMP1->(!EOF())
								ZAJ->(dbGoTo(TMP1->REC))
								If RecLock("ZAJ",.F.)
//									ZAJ->ZAJ_NUMNF	:= aAtu[nx][2]
//									ZAJ->ZAJ_NFSERI	:= aAtu[nx][3]
//									ZAJ->ZAJ_DTINV	:= aAtu[nx][6]
									ZAJ->(msUnlock())
								EndIf
							EndIf
							TMP1->(dbCloseArea())
						*/
						Else
							DisarmTransaction()
						EndIf
					Else
						DisarmTransaction()
					EndIf
				Else
					DisarmTransaction()
				EndIf
			EndIf
		End Transaction
	Next nx

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³AjustaSx1	     ºAutor  ³Alfredo A. MagalhaesºData  ³27/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria as perguntas da markbrowse de gerar invoice				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
Static Function AjustaSx1(cPerg)

	Local aArea := GetArea()
	Local aHelpPor	:= {}
	Local aHelpEng	:= {}
	Local aHelpSpa	:= {}
		

		//
		aHelpPor := {}
		Aadd( aHelpPor, "Informar como as notas" )
		Aadd( aHelpPor, "serão buscadas." )
		PutSx1(cPerg,"01","Apenas não enviadas ?" ,"","","mv_ch01","N",1,0,1,"C","","","","","mv_par01","Sim","Sim","Sim","","Não","Não","Não","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
					
		RestArea(aArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZPesq	     ºAutor  ³Alfredo A. MagalhaesºData  ³30/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria a tela de pesquisar.										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³Nenhum					   									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
User Function KZPesq()

	Local oDlg		:= Nil
	Local olDesc	:= Nil
	Local clCombo	:= ""
	Local alItems	:= {"1=Cli+Loj+NF+Serie+Emissao","2=NF+Serie","3=Num EDI"}
	Local clTitulo	:= "Pesquisar"
	Local clDesc	:= Space(100)
		
	DEFINE MSDIALOG oDlg TITLE clTitulo FROM  15,6 TO 150,366 PIXEL OF oMainWnd

		@ 4, 2 TO 48, 179 OF oDlg  PIXEL
		
		@ 11,05 SAY     OemToAnsi("Chave")			SIZE 22, 07 OF oDlg PIXEL
		//@ 07,53 MSGET   clChave Picture "@!"		SIZE 21, 10 OF oDlg PIXEL When (nOpc == 1)
		oCombo:= tComboBox():New(09,25,{|u|if(PCount()>0,clCombo:=u,clCombo)},alItems,100,20,oDlg,,{||},,,,.T.,,,,,,,,,'clCombo')
		@ 26,05 SAY     OemToAnsi("Buscar")    SIZE 80, 07 OF oDlg PIXEL
		

		@ 25,25 MSGET  olDesc  VAR clDesc Picture "@!" SIZE 80, 10 OF oDlg PIXEL 

		
		DEFINE SBUTTON FROM 51,124 TYPE 1 ENABLE OF oDlg ACTION {|| KZDbSeek(clCombo,clDesc),oDlg:End()} 
		DEFINE SBUTTON FROM 51,152 TYPE 2 ENABLE OF oDlg ACTION {|| oDlg:End() }

	ACTIVATE MSDIALOG oDlg CENTERED
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             					  º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					  º±±
±±º               ( __ /|\ __ )  Codefacttory 								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZDbSeek	     ºAutor  ³Alfredo A. MagalhaesºData  ³30/05/12	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função para pesquisar o registro na tabela temporaria			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cOpc - opcao do combo box, numero do indice					  º±±
±±º			 ³cSearch - chave de busca na tabela temporaria					  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³																  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± 
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
*/
Static Function KZDbSeek(cOpc,cSearch)

	If Select("TRB") == 0
		dbSelectArea("TRB")
	EndIf
	
	cSearch := AllTrim(cSearch)
	TRB->(dbSetOrder(Val(cOpc)))
	
	If !TRB->(dbSeek(cSearch))
		TRB->(dbGoTop())
	EndIf
	MarkbRefresh()
Return


Static Function KzGetXml() 	
    Local clReturn	:= ""
    Local nlI 		:= 1
    
	For nlI := 1 To Len(apNotas)
		clReturn := XmlNfeSef(apNotas[nlI][1],apNotas[nlI][2],apNotas[nlI][3],apNotas[nlI][4],apNotas[nlI][5])
	Next nlI
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³XmlNFeSef ³ Autor ³ Eduardo Riera         ³ Data ³13.02.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rdmake de exemplo para geracao da Nota Fiscal Eletronica do ³±±
±±³          ³SEFAZ - Versao T01.00                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³String da Nota Fiscal Eletronica                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Tipo da NF                                           ³±±
±±³          ³       [0] Entrada                                          ³±±
±±³          ³       [1] Saida                                            ³±±
±±³          ³ExpC2: Serie da NF                                          ³±±
±±³          ³ExpC3: Numero da nota fiscal                                ³±±
±±³          ³ExpC4: Codigo do cliente ou fornecedor                      ³±±
±±³          ³ExpC5: Loja do cliente ou fornecedor                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

static Function XmlNfeSef(cTipo,cSerie,cNota,cClieFor,cLoja)

Local nX        := 0

Local cString    := ""
Local cAliasSD1  := "SD1"
Local cAliasSD2  := "SD2"
Local cNatOper   := ""
Local cModFrete  := ""
Local cScan      := ""
Local cEspecie   := ""
Local cMensCli   := ""
Local cMensFis   := ""
Local cNFe       := ""

Local lQuery    := .F.

Local aNota     := {}
Local aDupl     := {}
Local aDest     := {}
Local aEntrega  := {}
Local aProd     := {}
Local aICMS     := {}
Local aICMSST   := {}
Local aIPI      := {}
Local aPIS      := {}
Local aCOFINS   := {}
Local aPISST    := {}
Local aCOFINSST := {}
Local aISSQN    := {}

Local aCST      := {}
Local aRetido   := {}
Local aTransp   := {}
Local aImp      := {}
Local aVeiculo  := {}
Local aReboque  := {}
Local aEspVol   := {}
Local aNfVinc   := {}
Local aPedido   := {}
Local aTotal    := {0,0}
Local aOldReg   := {}
Local aOldReg2  := {}

Private aUF     := {}

DEFAULT cTipo   := PARAMIXB[1]
DEFAULT cSerie  := PARAMIXB[3]
DEFAULT cNota   := PARAMIXB[4]
DEFAULT cClieFor:= PARAMIXB[5]
DEFAULT cLoja   := ""//PARAMIXB[6]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Preenchimento do Array de UF                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aadd(aUF,{"RO","11"})
aadd(aUF,{"AC","12"})
aadd(aUF,{"AM","13"})
aadd(aUF,{"RR","14"})
aadd(aUF,{"PA","15"})
aadd(aUF,{"AP","16"})
aadd(aUF,{"TO","17"})
aadd(aUF,{"MA","21"})
aadd(aUF,{"PI","22"})
aadd(aUF,{"CE","23"})
aadd(aUF,{"RN","24"})
aadd(aUF,{"PB","25"})
aadd(aUF,{"PE","26"})
aadd(aUF,{"AL","27"})
aadd(aUF,{"MG","31"})
aadd(aUF,{"ES","32"})
aadd(aUF,{"RJ","33"})
aadd(aUF,{"SP","35"})
aadd(aUF,{"PR","41"})
aadd(aUF,{"SC","42"})
aadd(aUF,{"RS","43"})
aadd(aUF,{"MS","50"})
aadd(aUF,{"MT","51"})
aadd(aUF,{"GO","52"})
aadd(aUF,{"DF","53"})
aadd(aUF,{"SE","28"})
aadd(aUF,{"BA","29"})
aadd(aUF,{"EX","99"})

If cTipo == "1"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Posiciona NF                                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SF2")
	dbSetOrder(1)
	If MsSeek(xFilial("SF2")+cNota+cSerie+cClieFor)	
		aadd(aNota,SF2->F2_SERIE)
		aadd(aNota,IIF(Len(SF2->F2_DOC)==6,"000","")+SF2->F2_DOC)
		aadd(aNota,SF2->F2_EMISSAO)
		aadd(aNota,cTipo)
		aadd(aNota,SF2->F2_TIPO)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona cliente ou fornecedor                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		If !SF2->F2_TIPO $ "DB" 
		    dbSelectArea("SA1")
			dbSetOrder(1)
			MsSeek(xFilial("SA1")+avKey(SF2->F2_CLIENTE,"A1_COD")+avKey(SF2->F2_LOJA,"A1_LOJA"))
			
			//aadd(aDest,AllTrim(SA1->A1_CGC))
			aadd(aDest,AllTrim(SA1->A1_CGC))
			aadd(aDest,SA1->A1_NOME)
			aadd(aDest,FisGetEnd(SA1->A1_END)[1])
			aadd(aDest,ConvType(IIF(FisGetEnd(SA1->A1_END)[2]<>0,FisGetEnd(SA1->A1_END)[2],"SN")))
			aadd(aDest,FisGetEnd(SA1->A1_END)[4])
			aadd(aDest,SA1->A1_BAIRRO)
			If !Upper(SA1->A1_EST) == "EX"
				aadd(aDest,SA1->A1_COD_MUN)
				aadd(aDest,SA1->A1_MUN)				
			Else
				aadd(aDest,"99999")			
				aadd(aDest,"EXTERIOR")
			EndIf
			aadd(aDest,Upper(SA1->A1_EST))
			aadd(aDest,SA1->A1_CEP)
			aadd(aDest,"1058") //IIF(Empty(SA1->A1_PAIS),"1058"  ,Posicione("SYA",1,xFilial("SYA")+SA1->A1_PAIS,"YA_SISEXP")))
			aadd(aDest,"BRASIL") //IIF(Empty(SA1->A1_PAIS),"BRASIL",Posicione("SYA",1,xFilial("SYA")+SA1->A1_PAIS,"YA_DESCR" )))
			aadd(aDest,SA1->A1_TEL)
			aadd(aDest,VldIE(SA1->A1_INSCR,IIF(SA1->(FIELDPOS("A1_CONTRIB"))>0,SA1->A1_CONTRIB<>"2",.T.)))
			aadd(aDest,"")//SA1->A1_SUFRAMA
			aadd(aDest,SA1->A1_EMAIL)
			
			If SF2->(FieldPos("F2_CLIENT"))<>0 .And. !Empty(SF2->F2_CLIENT+SF2->F2_LOJENT) .And. SF2->F2_CLIENT+SF2->F2_LOJENT<>SF2->F2_CLIENTE+SF2->F2_LOJA
			    dbSelectArea("SA1")
				dbSetOrder(1)
				MsSeek(xFilial("SA1")+SF2->F2_CLIENT+SF2->F2_LOJENT)
				
				aadd(aEntrega,AllTrim(SA1->A1_CGC))
				aadd(aEntrega,FisGetEnd(SA1->A1_END)[1])
				aadd(aEntrega,ConvType(IIF(FisGetEnd(SA1->A1_END)[2]<>0,FisGetEnd(SA1->A1_END)[2],"SN")))
				aadd(aEntrega,FisGetEnd(SA1->A1_END)[4])
				aadd(aEntrega,SA1->A1_BAIRRO)
				aadd(aEntrega,SA1->A1_COD_MUN)
				aadd(aEntrega,SA1->A1_MUN)
				aadd(aEntrega,Upper(SA1->A1_EST))
				
			EndIf
					
		EndIf
		
		dbSelectArea("SF2")
		aadd(aEspVol,{ cEspecie, FieldGet(FieldPos("F2_VOLUME"+cScan)) , SF2->F2_PLIQUI , SF2->F2_PBRUTO})
		aDupl := {}
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Analisa os impostos de retencao                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SF2->(FieldPos("F2_VALPIS"))<>0 .and. SF2->F2_VALPIS>0
			aadd(aRetido,{"PIS",0,SF2->F2_VALPIS})
		EndIf
		If SF2->(FieldPos("F2_VALCOFI"))<>0 .and. SF2->F2_VALCOFI>0
			aadd(aRetido,{"COFINS",0,SF2->F2_VALCOFI})
		EndIf
		If SF2->(FieldPos("F2_VALCSLL"))<>0 .and. SF2->F2_VALCSLL>0
			aadd(aRetido,{"CSLL",0,SF2->F2_VALCSLL})
		EndIf
		If SF2->(FieldPos("F2_VALIRRF"))<>0 .and. SF2->F2_VALIRRF>0
			aadd(aRetido,{"IRRF",0,SF2->F2_VALIRRF})
		EndIf	
		If SF2->(FieldPos("F2_BASEINS"))<>0 .and. SF2->F2_BASEINS>0
			aadd(aRetido,{"INSS",SF2->F2_BASEINS,SF2->F2_VALINSS})
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Pesquisa itens de nota                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		dbSelectArea("SD2")
		//dbSetOrder(3)	
		dbSetOrder(1)	
		MsSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA+"")
		While !Eof() .And. xFilial("SD2") == (cAliasSD2)->D2_FILIAL .And.;
			SF2->F2_SERIE == (cAliasSD2)->D2_SERIE .And.;
			SF2->F2_DOC == (cAliasSD2)->D2_DOC
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica a natureza da operacao                                         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SF4")
			dbSetOrder(1)
			MsSeek(xFilial("SF4")+(cAliasSD2)->D2_TES)				
			If Empty(cNatOper)
				cNatOper := SF4->F4_DESCRI //SF4->F4_TEXTO
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica as notas vinculadas                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty((cAliasSD2)->D2_NFORI) 
				If (cAliasSD2)->D2_TIPO $ "DB"
					dbSelectArea("SD1")
					dbSetOrder(1)
					If MsSeek(xFilial("SD1")+(cAliasSD2)->D2_NFORI+(cAliasSD2)->D2_SERIORI+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_CODPROD+(cAliasSD2)->D2_ITEMORI)
						dbSelectArea("SF1")
						dbSetOrder(1)
						MsSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_PESSOA+SD1->D1_TIPO)
						If SD1->D1_TIPO $ "DB"
							dbSelectArea("SA1")
							dbSetOrder(1)
							MsSeek(xFilial("SA1")+SD1->D1_PESSOA)
						Else
							dbSelectArea("SA2")
							dbSetOrder(1)
							MsSeek(xFilial("SA2")+SD1->D1_PESSOA+SD1)
						EndIf
						
						aadd(aNfVinc,{SD1->D1_EMISSAO,SD1->D1_SERIE,SD1->D1_DOC,IIF(SD1->D1_TIPO $ "DB",IIF(SD1->D1_FORMUL=="S",SM0->M0_CGC,SA1->A1_CGC),IIF(SD1->D1_FORMUL=="S",SM0->M0_CGC,SA2->A2_CGC)),SF1->F1_EST,SF1->F1_ESPECIE})
					EndIf
				Else
					aOldReg  := SD2->(GetArea())
					aOldReg2 := SF2->(GetArea())
					dbSelectArea("SD2")
					dbSetOrder(1)
					If MsSeek(xFilial("SD2")+(cAliasSD2)->D2_NFORI+(cAliasSD2)->D2_SERIORI+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_CODPROD+(cAliasSD2)->D2_ITEMORI)
						dbSelectArea("SF2")
						dbSetOrder(1)
						MsSeek(xFilial("SF2")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE)
						If !SD2->D2_TIPO $ "DB"
							dbSelectArea("SA1")
							dbSetOrder(1)
							MsSeek(xFilial("SA1")+SD2->D2_CLIENTE)
						Else
							dbSelectArea("SA2")
							dbSetOrder(1)
							MsSeek(xFilial("SA2")+SD2->D2_CLIENTE)
						EndIf
						
						aadd(aNfVinc,{SF2->F2_EMISSAO,SD2->D2_SERIE,SD2->D2_DOC,SM0->M0_CGC,SM0->M0_ESTCOB,SF2->F2_ESPECIE})
					EndIf
					RestArea(aOldReg)
					RestArea(aOldReg2)
				EndIf
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Obtem os dados do produto                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			dbSelectArea("SB1")
			dbSetOrder(1)
			MsSeek(xFilial("SB1")+(cAliasSD2)->D2_CODPROD)
		
			dbSelectArea("SC5")
			dbSetOrder(1)
			MsSeek(xFilial("SC5")+SF2->F2_PEDCLI)			
			
			dbSelectArea("SC6")
			dbSetOrder(1)
			MsSeek(xFilial("SC6")+SF2->F2_PEDCLI+(cAliasSD2)->D2_ITEMPV+(cAliasSD2)->D2_CODPROD)
			
			If !AllTrim(SC5->C5_MENNOTA) $ cMensCli
				cMensCli += AllTrim(SC5->C5_MENNOTA)
			EndIf
			If !Empty(SC5->C5_MENNOTA) .And. !AllTrim(FORMULA(SC5->C5_MENNOTA)) $ cMensFis
				cMensFis += AllTrim(FORMULA(SC5->C5_MENNOTA))
			EndIf
						
			cModFrete := IIF(SC5->C5_TPFRETE=="C","0","1")
			
			If Empty(aPedido)
				aPedido := {"",AllTrim(SC6->C6_NUM),""}
			EndIf
						
			aadd(aProd,	{Len(aProd)+1,;
							(cAliasSD2)->D2_CODPROD,;
							IIf(Val(SB1->B1_CODBAR)==0,"",Str(Val(SB1->B1_CODBAR),Len(SB1->B1_CODBAR),0)),;
							SB1->B1_DESCRI,;
							"",;
							"",;      
							Posicione("SF4",1,(cAliasSD2)->D2_TES,"F4_CF"),;
							SB1->B1_CODUM,;
							(cAliasSD2)->D2_QUANT,;
							IIF(!(cAliasSD2)->D2_TIPO$"IP",(cAliasSD2)->D2_TOTAL,0),;
							SB1->B1_CODUM,;
							(cAliasSD2)->D2_QUANT,;
							0,;
							0,;
							0,;
							IIF(!(cAliasSD2)->D2_TIPO$"IP",(cAliasSD2)->D2_PRCUNI,0),;
							"",; //codigo ANP do combustivel
							""}) //CODIF
			aadd(aCST,{IIF(!Empty((cAliasSD2)->D2_CLASFIS),SubStr((cAliasSD2)->D2_CLASFIS,2,2),'50')})
			aadd(aICMS,{})
			aadd(aIPI,{})
			aadd(aICMSST,{})
			aadd(aPIS,{})
			aadd(aPISST,{})
			aadd(aCOFINS,{})
			aadd(aCOFINSST,{})
			aadd(aISSQN,{})
						
			aTotal[01] += (cAliasSD2)->D2_DESPESA
			aTotal[02] += (cAliasSD2)->D2_TOTAL	
									
			dbSelectArea(cAliasSD2)
			dbSkip()
	    EndDo	
	    If lQuery
	    	dbSelectArea(cAliasSD2)
	    	dbCloseArea()
	    	dbSelectArea("SD2")
	    EndIf
	EndIf
Else
	dbSelectArea("SF1")
	dbSetOrder(1)
	If MsSeek(xFilial("SF1")+cNota+cSerie+cClieFor)
	
		aadd(aNota,SF1->F1_SERIE)
		aadd(aNota,IIF(Len(SF1->F1_DOC)==6,"000","")+SF1->F1_DOC)
		aadd(aNota,SF1->F1_EMISSAO)
		aadd(aNota,cTipo)
		aadd(aNota,SF1->F1_TIPO)
		
		If SF1->F1_TIPO $ "DB" 
		    dbSelectArea("SA1")
			dbSetOrder(1)
			MsSeek(xFilial("SA1")+cClieFor)
			
			aadd(aDest,AllTrim(SA1->A1_CGC))
			aadd(aDest,SA1->A1_NOME)
			aadd(aDest,FisGetEnd(SA1->A1_END)[1])
			aadd(aDest,ConvType(IIF(FisGetEnd(SA1->A1_END)[2]<>0,FisGetEnd(SA1->A1_END)[2],FisGetEnd(SA1->A1_END)[3])))
			aadd(aDest,FisGetEnd(SA1->A1_END)[4])
			aadd(aDest,SA1->A1_BAIRRO)
			aadd(aDest,SA1->A1_COD_MUN)
			aadd(aDest,SA1->A1_MUN)
			aadd(aDest,Upper(SA1->A1_EST))
			aadd(aDest,SA1->A1_CEP)
			aadd(aDest,"1058")//IIF(Empty(SA1->A1_PAIS),"1058"  ,Posicione("SYA",1,xFilial("SYA")+SA1->A1_PAIS,"YA_SISEXP")))
			aadd(aDest,"BRASIL")//IIF(Empty(SA1->A1_PAIS),"BRASIL",Posicione("SYA",1,xFilial("SYA")+SA1->A1_PAIS,"YA_DESCR" )))
			aadd(aDest,SA1->A1_TEL)
			aadd(aDest,VldIE(SA1->A1_INSCR,IIF(SA1->(FIELDPOS("A1_CONTRIB"))>0,SA1->A1_CONTRIB<>"2",.T.)))
			aadd(aDest,"")//SA1->A1_SUFRAMA
			aadd(aDest,SA1->A1_EMAIL)
								
		Else
			
		    dbSelectArea("SA1")
			dbSetOrder(1)
			MsSeek(xFilial("SA1")+cClieFor+cLoja)
	
			aadd(aDest,AllTrim(SA1->A1_CGC))
			aadd(aDest,SA1->A1_NOME)
			aadd(aDest,FisGetEnd(SA1->A1_END)[1])
			aadd(aDest,ConvType(IIF(FisGetEnd(SA1->A1_END)[2]<>0,FisGetEnd(SA1->A1_END)[2],FisGetEnd(SA1->A1_END)[3])))
			aadd(aDest,FisGetEnd(SA1->A1_END)[4])
			aadd(aDest,SA1->A1_BAIRRO)
			aadd(aDest,SA1->A1_COD_MUN)
			aadd(aDest,SA1->A1_MUN)
			aadd(aDest,Upper(SA1->A1_EST))
			aadd(aDest,SA1->A1_CEP)
			aadd(aDest,"1058")//IIF(Empty(SA2->A2_PAIS),"1058"  ,Posicione("SYA",1,xFilial("SYA")+SA2->A2_PAIS,"YA_SISEXP")))
			aadd(aDest,"BRASIL") //IIF(Empty(SA2->A2_PAIS),"BRASIL",Posicione("SYA",1,xFilial("SYA")+SA2->A2_PAIS,"YA_DESCR")))
			aadd(aDest,SA1->A1_TEL)
			aadd(aDest,VldIE(SA1->A1_INSCR))
			aadd(aDest,"")//SA2->A2_SUFRAMA
			aadd(aDest,SA1->A1_EMAIL)
	
		EndIf
				
		If SF1->F1_TIPO $ "DB" 
		    dbSelectArea("SA1")
			dbSetOrder(1)
			MsSeek(xFilial("SA1")+SF1->F1_PESSOA)

		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Analisa os impostos de retencao                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SF1->(FieldPos("F1_VALPIS"))<>0 .And. SF1->F1_VALPIS>0
			aadd(aRetido,{"PIS",0,SF1->F1_VALPIS})
		EndIf
		If SF1->(FieldPos("F1_VALCOFI"))<>0 .And. SF1->F1_VALCOFI>0
			aadd(aRetido,{"COFINS",0,SF1->F1_VALCOFI})
		EndIf
		If SF1->(FieldPos("F1_VALCSLL"))<>0 .And. SF1->F1_VALCSLL>0
			aadd(aRetido,{"CSLL",0,SF1->F1_VALCSLL})
		EndIf
		If SF1->(FieldPos("F1_IRRF"))<>0 .And. SF1->F1_IRRF>0
			aadd(aRetido,{"IRRF",0,SF1->F1_IRRF})
		EndIf	
		If SF1->(FieldPos("F1_INSS"))<>0 .and. SF1->F1_INSS>0
				aadd(aRetido,{"INSS",SF1->F1_BASEINS,SF1->F1_INSS})
		EndIf
		dbSelectArea("SD1")
		dbSetOrder(1)	
		MsSeek(xFilial("SD1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_PESSOA)

		While !Eof() .And. xFilial("SD1") == (cAliasSD1)->D1_FILIAL .And.;
			SF1->F1_SERIE == (cAliasSD1)->D1_SERIE .And.;
			SF1->F1_DOC == (cAliasSD1)->D1_DOC .And.;
			SF1->F1_PESSOA == (cAliasSD1)->D1_PESSOA 
			

			dbSelectArea("SF4")
			dbSetOrder(1)
			MsSeek(xFilial("SF4")+(cAliasSD1)->D1_TES)
			If Empty(cNatOper)
				cNatOper := SF4->F4_DESCRI
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica as notas vinculadas                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If !Empty((cAliasSD1)->D1_NFORI) 
				If !(cAliasSD1)->D1_TIPO $ "DB"
					aOldReg  := SD1->(GetArea())
					aOldReg2 := SF1->(GetArea())
					dbSelectArea("SD1")
					dbSetOrder(1)
					If MsSeek(xFilial("SD1")+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI+(cAliasSD1)->D1_PESSOA+(cAliasSD1)->D1_CODPROD+(cAliasSD1)->D1_ITEMORI)
						dbSelectArea("SF1")
						dbSetOrder(1)
						MsSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_PESSOA+SD1->D1_TIPO)
						If SD1->D1_TIPO $ "DB"
							dbSelectArea("SA1")
							dbSetOrder(1)
							MsSeek(xFilial("SA1")+SD1->D1_PESSOA)
						Else
							dbSelectArea("SA1")
							dbSetOrder(1)
							MsSeek(xFilial("SA1")+SD1->D1_PESSOA)
						EndIf
						
						aadd(aNfVinc,{SD1->D1_EMISSAO,SD1->D1_SERIE,SD1->D1_DOC,IIF(SD1->D1_TIPO $ "DB",IIF(SD1->D1_FORMUL=="S",SM0->M0_CGC,SA1->A1_CGC),IIF(SD1->D1_FORMUL=="S",SM0->M0_CGC,SA1->A1_CGC)),SF1->F1_EST,SF1->F1_ESPECIE})
					EndIf
					RestArea(aOldReg)
					RestArea(aOldReg2)
				Else					
					dbSelectArea("SD2")
					dbSetOrder(1)
					If MsSeek(xFilial("SD2")+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI+(cAliasSD1)->D1_PESSOA+(cAliasSD1)->D1_CODPROD+(cAliasSD1)->D1_ITEMORI)
						dbSelectArea("SF2")
						dbSetOrder(1)
						MsSeek(xFilial("SF2")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE)
						If !SD2->D2_TIPO $ "DB"
							dbSelectArea("SA1")
							dbSetOrder(1)
							MsSeek(xFilial("SA1")+SD2->D2_CLIENTE)
						Else
							dbSelectArea("SA2")
							dbSetOrder(1)
							MsSeek(xFilial("SA2")+SD2->D2_CLIENTE)
						EndIf
						
						aadd(aNfVinc,{SD2->D2_EMISSAO,SD2->D2_SERIE,SD2->D2_DOC,SM0->M0_CGC,SM0->M0_ESTCOB,SF2->F2_ESPECIE})
						
					EndIf
				EndIf
			
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Obtem os dados do produto                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			dbSelectArea("SB1")
			dbSetOrder(1)
			MsSeek(xFilial("SB1")+(cAliasSD1)->D1_CODPROD)
									
			cModFrete := IIF(SF1->F1_FRETE>0,"0","1")
						
			aadd(aProd,	{Len(aProd)+1,;
							(cAliasSD1)->D1_CODPROD,;
							IIf(Val(SB1->B1_CODBAR)==0,"",Str(Val(SB1->B1_CODBAR),Len(SB1->B1_CODBAR),0)),;
							SB1->B1_DESCRI,;
							"",;
							"",;
							(cAliasSD1)->D1_CFOP,;
							SB1->B1_CODUM,;
							(cAliasSD1)->D1_QUANT,;
							IIF(!(cAliasSD1)->D1_TIPO$"IP",(cAliasSD1)->D1_TOTAL+(cAliasSD1)->D1_VALDESC,0),;
							SB1->B1_CODUM,;
							(cAliasSD1)->D1_QUANT,;
							SF1->F1_FRETE,;
							0,;
							(cAliasSD1)->D1_VALDESC,;
							IIF(!(cAliasSD1)->D1_TIPO$"IP",(cAliasSD1)->D1_PRCUNI,0),;
							"",; //codigo ANP do combustivel
							""}) //CODIF
			aadd(aCST,{IIF(!Empty((cAliasSD1)->D1_CLASFIS),SubStr((cAliasSD1)->D1_CLASFIS,2,2),'50')})
			aadd(aICMS,{})
			aadd(aIPI,{})
			aadd(aICMSST,{})
			aadd(aPIS,{})
			aadd(aPISST,{})
			aadd(aCOFINS,{})
			aadd(aCOFINSST,{})
			aadd(aISSQN,{})
						
			aTotal[01] += (cAliasSD1)->D1_DESPESA
			aTotal[02] += (cAliasSD1)->D1_TOTAL-(cAliasSD1)->D1_VALDESC+SF1->F1_FRETE+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_VALIPI+(cAliasSD1)->D1_ICMSRET;
						   +IIF(SF4->F4_AGREG$"I",(cAliasSD1)->D1_VALICM,0)			
			dbSelectArea(cAliasSD1)
			dbSkip()
	    EndDo	
	    If lQuery
	    	dbSelectArea(cAliasSD1)
	    	dbCloseArea()
	    	dbSelectArea("SD1")
	    EndIf
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Geracao do arquivo XML                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(aNota)
	cString := ""
	cString += NfeIde(@cNFe,aNota,cNatOper,aDupl,aNfVinc)
	cString += NfeEmit()
	cString += NfeDest(aDest)
	cString += NfeLocalEntrega(aEntrega)
	For nX := 1 To Len(aProd)
		cString += NfeItem(aProd[nX],aICMS[nX],aICMSST[nX],aIPI[nX],aPIS[nX],aPISST[nX],aCOFINS[nX],aCOFINSST[nX],aISSQN[nX],aCST[nX])
	Next nX
	cString += NfeTotal(aTotal,aRetido)
	cString += NfeTransp(cModFrete,aTransp,aImp,aVeiculo,aReboque,aEspVol)
	cString += NfeCob(aDupl)
	cString += NfeInfAd(cMensCli,cMensFis,aPedido)
	cString += "</infNFe>"
EndIf	
Return({cNfe,EncodeUTF8(cString)})


Static Function NfeIde(cChave,aNota,cNatOper,aDupl,aNfVinc)

Local cString:= ""
Local cNFVinc:= ""
Local lAvista:= Len(aDupl)==1 .And. aDupl[01][02]<=DataValida(aNota[03]+1,.T.)
Local nX     := 0
Local aCadFil := FWFilManut( cFilAnt )//Filiais First. Rafael 18/07/2008	

Local cFilCnpj := AllTrim(aCadFil[3][1][4])	//CNPJ 
Local cFilIE	 := aCadFil[3][1][11]	//IE 
Local cFilIM	 := aCadFil[3][1][15]//SM0->M0_INSCM		
Local cFilNome := aCadFil[3][1][1]	//Nome 
Local cFilFant := aCadFil[3][1][14]				//Fantasia
Local cFilEnd	 := FisGetEnd(aCadFil[3][1][3])[1]	//Endereco
Local cFilNum  := FisGetEnd(aCadFil[3][1][3])[3]	//Numero 
Local cFilCmp	 := FisGetEnd(aCadFil[3][1][3])[4]	//Complemento
Local cFilEst	 := aCadFil[3][1][8]	//Estado
Local cFilCep	 := aCadFil[3][1][10]	//CEP
Local cFilCodMun := aCadFil[3][1][16]				//Criar no CADFIL o campo de Codigo Municipal
Local cFilPais   := "1058"
Local cFilBai		:= aCadFil[3][1][9]	//Bairro
Local cFilCid 	:= aCadFil[3][1][8]	//Cidade
Local cFilDDD := Str(FisGetTel(aCadFil[3][1][5])[2],3)	//DDD
Local cFilFone	:= AllTrim(Str(FisGetTel(aCadFil[3][1][5])[3],15)) //Telefone
Local cFilFax	:= AllTrim(Str(FisGetTel(aCadFil[3][1][5])[3],15)) //Fax
Local cFilEmail	:= "rafaelalmeida@totvs.com.br"//UsrRetMail(RetCodUsr())"michelle-kenia@plantar.com.br"//
Local cFilNIRE	:= aCadFil[3][1][17]				//NIRE
Local cFilDtNIRE	:= aCadFil[3][1][18]				//DTRE  
Local cCnae			:= AllTrim(aCadFil[3][1][19]) //CNAE

cChave := aUF[aScan(aUF,{|x| x[1] == cFilEst})][02]+FsDateConv(aNota[03],"YYMM")+cFilCnpj+"55"+StrZero(Val(aNota[01]),3)+StrZero(Val(aNota[02]),9)+Inverte(StrZero(Val(aNota[02]),9))

cString += '<infNFe versao="T01.00">'
cString += '<ide>'
cString += '<cUF>'+ConvType(aUF[aScan(aUF,{|x| x[1] == cFilEst})][02],02)+'</cUF>'
cString += '<cNF>'+ConvType(Inverte(StrZero(Val(aNota[02]),Len(aNota[02]))),09)+'</cNF>'
cString += '<natOp>'+ConvType(cNatOper)+'</natOp>'
cString += '<indPag>'+IIF(lAVista,"0",IIf(Len(aDupl)==0,"2","1"))+'</indPag>'
cString += '<serie>'+ConvType(Val(aNota[01]),3)+'</serie>'
cString += '<nNF>'+ConvType(Val(aNota[02]),9)+'</nNF>'
cString += '<dEmi>'+ConvType(aNota[03])+'</dEmi>
cString += NfeTag('<dSaiEnt>',ConvType(aNota[03]))
cString += '<tpNF>'+aNota[04]+'</tpNF>'
If !Empty(aNfVinc)
	cString += '<NFRef>'
	For nX := 1 To Len(aNfVinc)
		If !(ConvType(aUF[aScan(aUF,{|x| x[1] == aNfVinc[nX][05]})][02],02)+;
				FsDateConv(aNfVinc[nX][01],"YYMM")+;
				aNfVinc[nX][04]+;
				AModNot(aNfVinc[nX][06])+;
				ConvType(Val(aNfVinc[nX][02]),3)+;
				ConvType(Val(aNfVinc[nX][03]),9) $ cNFVinc )
			cString += '<RefNF>'
			cString += '<cUF>'+ConvType(aUF[aScan(aUF,{|x| x[1] == aNfVinc[nX][05]})][02],02)+'</cUF>'
			cString += '<AAMM>'+FsDateConv(aNfVinc[nX][01],"YYMM")+'</AAMM>'
			cString += '<CNPJ>'+aNfVinc[nX][04]+'</CNPJ>'
			cString += '<mod>'+AModNot(aNfVinc[nX][06])+'</mod>'
			cString += '<serie>'+ConvType(Val(aNfVinc[nX][02]),3)+'</serie>'
			cString += '<nNF>'+ConvType(Val(aNfVinc[nX][03]),9)+'</nNF>'
			cString += '<cNF>'+Inverte(StrZero(Val(aNfVinc[nX][03]),9))+'</cNF>'
			cString += '</RefNF>'
	
			cNFVinc += ConvType(aUF[aScan(aUF,{|x| x[1] == aNfVinc[nX][05]})][02],02)+;
				FsDateConv(aNfVinc[nX][01],"YYMM")+;
				aNfVinc[nX][04]+;
				AModNot(aNfVinc[nX][06])+;
				ConvType(Val(aNfVinc[nX][02]),3)+;
				ConvType(Val(aNfVinc[nX][03]),9)
		EndIf						
	Next nX
	cString += '</NFRef>'
EndIf
cString += '<tpNFe>'+IIF(aNota[05]$"CPI","2","1")+'</tpNFe>'
cString += '</ide>'

Return( cString )

Static Function NfeEmit()

Local cString:= ""     
Local aCadFil := FWFilManut( cFilAnt )//Filiais First. Rafael 18/07/2008	

Local cFilCnpj := AllTrim(aCadFil[3][1][4])	//CNPJ 
Local cFilIE	 := aCadFil[3][1][11]	//IE 
Local cFilIM	 := aCadFil[3][1][15]//SM0->M0_INSCM		
Local cFilNome := aCadFil[3][1][4]	//Nome 
Local cFilEnd	 := FisGetEnd(aCadFil[3][1][3])[1]	//Endereco
Local cFilEst	 := aCadFil[3][1][8]	//Estado
Local cFilCodMun := aCadFil[3][1][16]				//Criar no CADFIL o campo de Codigo Municipal
Local cFilBai		:= aCadFil[3][1][9]	//Bairro
Local cFilCid 	:= aCadFil[3][1][8]	//Cidade
Local cFilFone	:= AllTrim(Str(FisGetTel(aCadFil[3][1][5])[3],15)) //Telefone
Local cCnae			:= AllTrim(aCadFil[3][1][19]) //CNAE

cString := '<emit>'
cString += '<CNPJ>'+cFilCnpj+'</CNPJ>
cString += '<Nome>'+ConvType(cFilNome)+'</Nome>'
cString += NfeTag('<Fant>',ConvType(cFilNome))
cString += '<enderEmit>'
cString += '<Lgr>'+ConvType(FisGetEnd(cFilEnd)[1])+'</Lgr>'
cString += '<nro>'+ConvType(IIF(FisGetEnd(cFilEnd)[2]<>0,FisGetEnd(cFilEnd)[2],"SN"))+'</nro>'
cString += NfeTag('<Cpl>',ConvType(FisGetEnd(cFilEnd)[4]))
cString += '<Bairro>'+ConvType(cFilBai)+'</Bairro>'
cString += '<cMun>'+ConvType(cFilCodMun)+'</cMun>'
cString += '<Mun>'+ConvType(cFilCid)+'</Mun>'
cString += '<UF>'+ConvType(cFilEst)+'</UF>'
cString += NfeTag('<CEP>',ConvType(""))
cString += NfeTag('<cPais>',"1058")
cString += NfeTag('<Pais>',"BRASIL")
cString += NfeTag('<fone>',ConvType(FisGetTel(cFilFone)[3],18))
cString += '</enderEmit>'
cString += '<IE>'+ConvType(VldIE(cFilIE))+'</IE>'
cString += NfeTag('<IEST>',"")
cString += NfeTag('<IM>',cFilIM)
cString += NfeTag('<CNAE>',ConvType(cCnae))
cString += '</emit>'
Return(cString)

Static Function NfeDest(aDest)

Local cString:= ""

cString := '<dest>'
If Len(AllTrim(aDest[01]))==14
	cString += '<CNPJ>'+AllTrim(aDest[01])+'</CNPJ>'
ElseIf Len(AllTrim(aDest[01]))<>0
	cString += '<CPF>' +AllTrim(aDest[01])+'</CPF>'
Else
	cString += '<CNPJ></CNPJ>'
EndIf
cString += '<Nome>'+ConvType(aDest[02])+'</Nome>'
cString += '<enderDest>'
cString += '<Lgr>'+ConvType(aDest[03])+'</Lgr>'
cString += '<nro>'+ConvType(aDest[04])+'</nro>'
cString += NfeTag('<Cpl>',ConvType(aDest[05]))
cString += '<Bairro>'+ConvType(aDest[06])+'</Bairro>'
cString += '<cMun>'+ConvType(aUF[aScan(aUF,{|x| x[1] == aDest[09]})][02]+aDest[07])+'</cMun>'
cString += '<Mun>'+ConvType(aDest[08])+'</Mun>'
cString += '<UF>'+ConvType(aDest[09])+'</UF>'
cString += NfeTag('<CEP>',aDest[10])
cString += NfeTag('<cPais>',aDest[11])
cString += NfeTag('<Pais>',aDest[12])
cString += NfeTag('<fone>',ConvType(FisGetTel(aDest[13])[3],18))
cString += '</enderDest>'
cString += '<IE>'+ConvType(aDest[14])+'</IE>'
cString += NfeTag('<ISUF>',aDest[15])
cString += NfeTag('<EMAIL>',aDest[16])
cString += '</dest>'
Return(cString)

Static Function NfeLocalEntrega(aEntrega)

Local cString:= ""

If !Empty(aEntrega) .And. Len(AllTrim(aEntrega[01]))==14
	cString := '<entrega>'
	cString += '<CNPJ>'+AllTrim(aEntrega[01])+'</CNPJ>'
	cString += '<Lgr>'+ConvType(aEntrega[02])+'</Lgr>'
	cString += '<nro>'+ConvType(aEntrega[03])+'</nro>'
	cString += NfeTag('<Cpl>',ConvType(aEntrega[04]))
	cString += '<Bairro>'+ConvType(aEntrega[05])+'</Bairro>'
	cString += '<cMun>'+ConvType(aUF[aScan(aUF,{|x| x[1] == aEntrega[08]})][02]+aEntrega[06])+'</cMun>'
	cString += '<Mun>'+ConvType(aEntrega[07])+'</Mun>'
	cString += '<UF>'+ConvType(aEntrega[08])+'</UF>'
	cString += '</entrega>'
EndIf
Return(cString)

Static Function NfeItem(aProd,aICMS,aICMSST,aIPI,aPIS,aPISST,aCOFINS,aCOFINSST,aISSQN,aCST)

Local cString    := ""
DEFAULT aICMS    := {}
DEFAULT aICMSST  := {}
DEFAULT aIPI     := {}
DEFAULT aPIS     := {}
DEFAULT aPISST   := {}
DEFAULT aCOFINS  := {}
DEFAULT aCOFINSST:= {}
DEFAULT aISSQN   := {}

cString += '<det nItem="'+ConvType(aProd[01])+'">'
cString += '<prod>'
cString += '<cProd>'+ConvType(aProd[02])+'</cProd>'
cString += '<ean>'+ConvType(aProd[03])+'</ean>'
cString += '<Prod>'+ConvType(aProd[04],120)+'</Prod>'
cString += NfeTag('<NCM>',ConvType(aProd[05]))
cString += NfeTag('<EXTIPI>',ConvType(aProd[06]))
cString += '<CFOP>'+ConvType(aProd[07])+'</CFOP>'
cString += '<uCom>'+ConvType(aProd[08])+'</uCom>'
cString += '<qCom>'+ConvType(aProd[09],12,4)+'</qCom>'
cString += '<vUnCom>'+ConvType(aProd[16],16,4)+'</vUnCom>'
cString += '<vProd>' +ConvType(aProd[10],15,2)+'</vProd>'
cString += '<eantrib>'+ConvType(aProd[03])+'</eantrib>'
cString += '<uTrib>'+ConvType(aProd[11])+'</uTrib>'
cString += '<qTrib>'+ConvType(aProd[12],12,4)+'</qTrib>'
cString += '<vUnTrib>'+ConvType(aProd[10]/aProd[12],16,4)+'</vUnTrib>'
cString += NfeTag('<vFrete>',ConvType(aProd[13],15,2))
cString += NfeTag('<vSeg>'  ,ConvType(aProd[14],15,2))
cString += NfeTag('<vDesc>' ,ConvType(aProd[15],15,2))
//Ver II - Average
If !Empty(aProd[17])
	cString += '<comb>'	
	cString += NfeTag('<cprodanp>',ConvType(aProd[17]))
	cString += NfeTag('<codif>',ConvType(aProd[18]))
	cString += '</comb>'                            
	//Tratamento da CIDE - Ver com a Average
	//Tratamento de ICMS-ST - Ver com fisco
EndIf
cString += '</prod>'
cString += '<imposto>'
cString += '<codigo>ICMS</codigo>'
If Len(aIcms)>0	
	cString += '<cpl>'
	cString += '<orig>'+ConvType(aICMS[01])+'</orig>'
	cString += '</cpl>'
	cString += '<Tributo>'
	cString += '<CST>'+ConvType(aICMS[02])+'</CST>'	
	cString += '<modBC>'+ConvType(aICMS[03])+'</modBC>'
	cString += '<pRedBC>'+ConvType(aICMS[04],5,2)+'</pRedBC>'
	cString += '<vBC>'+ConvType(aICMS[05],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aICMS[06],5,2)+'</aliquota>'
	cString += '<valor>'+ConvType(aICMS[07],15,2)+'</valor>'
	cString += '<qtrib>'+ConvType(aICMS[09],16,4)+'</qtrib>'
	cString += '<vltrib>'+ConvType(aICMS[10],15,4)+'</vltrib>'
	cString += '</Tributo>'
Else
	cString += '<cpl>'
	cString += '<orig>0</orig>'
	cString += '</cpl>'
	cString += '<Tributo>'
	cString += '<CST>'+ConvType(aCST[01])+'</CST>'	
	cString += '<modBC>'+ConvType(3)+'</modBC>'
	cString += '<pRedBC>'+ConvType(0,5,2)+'</pRedBC>'
	cString += '<vBC>'+ConvType(0,15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(0,5,2)+'</aliquota>'
	cString += '<valor>'+ConvType(0,15,2)+'</valor>'
	cString += '<qtrib>'+ConvType(0,16,4)+'</qtrib>'
	cString += '<vltrib>'+ConvType(0,15,4)+'</vltrib>'
	cString += '</Tributo>'
EndIf
cString += '</imposto>'
If Len(aIcmsST)>0	
	Do Case
		Case aICMSST[03] == "0"
			aICMSST[03] := "4"
		Case aICMSST[03] == "1"
			aICMSST[03] := "5"
		OtherWise
			aICMSST[03] := "0"
	EndCase
	cString += '<imposto>'
	cString += '<codigo>ICMSST</codigo>'
	cString += '<cpl>'
	cString += '<pmvast>'+ConvType(aICMSST[08],5,2)+'</pmvast>'
	cString += '</cpl>'
	cString += '<Tributo>'
	cString += '<CST>'+ConvType(aICMSST[02])+'</CST>'	
	cString += '<modBC>'+ConvType(aICMSST[03])+'</modBC>'
	cString += '<pRedBC>'+ConvType(aICMSST[04],5,2)+'</pRedBC>'
	cString += '<vBC>'+ConvType(aICMSST[05],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aICMSST[06],5,2)+'</aliquota>'
	cString += '<valor>'+ConvType(aICMSST[07],15,2)+'</valor>'
	cString += '<qtrib>'+ConvType(aICMSST[09],16,4)+'</qtrib>'
	cString += '<vltrib>'+ConvType(aICMSST[10],15,4)+'</vltrib>'
	cString += '</Tributo>'
	cString += '</imposto>'
ELse
	cString += '<imposto>'
	cString += '<codigo>ICMSST</codigo>'
	cString += '<cpl>'
	cString += '<pmvast>0</pmvast>'
	cString += '</cpl>'
	cString += '<Tributo>'
	cString += '<CST>'+ConvType(aCST[01])+'</CST>'          
	cString += '<modBC>0</modBC>'
	cString += '<pRedBC>'+ConvType(0,5,2)+'</pRedBC>'
	cString += '<vBC>'+ConvType(0,15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(0,5,2)+'</aliquota>'
	cString += '<valor>'+ConvType(0,15,2)+'</valor>'
	cString += '<qtrib>'+ConvType(0,16,4)+'</qtrib>'
	cString += '<vltrib>'+ConvType(0,15,4)+'</vltrib>'
	cString += '</Tributo>'
	cString += '</imposto>'
EndIf
If Len(aIPI)>0 
	cString += '<imposto>'
	cString += '<codigo>IPI</codigo>'
	cString += '<cpl>'
	cString += NfeTag('<clEnq>',ConvType(AIPI[01]))
	cString += NfeTag('<cSelo>',ConvType(AIPI[02]))
	cString += NfeTag('<qSelo>',ConvType(AIPI[03]))
	cString += NfeTag('<cEnq>' ,ConvType(AIPI[04]))
	cString += '</cpl>'
	cString += '<Tributo>'
	cString += '<CST>'+ConvType(AIPI[05])+'</CST>'
	cString += '<modBC>'+ConvType(AIPI[11])+'</modBC>'
	cString += '<pRedBC>'+ConvType(AIPI[12],5,2)+'</pRedBC>'
	cString += '<vBC>'  +ConvType(AIPI[06],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(AIPI[09],5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(AIPI[08],15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(AIPI[07],16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(AIPI[10],15,2)+'</valor>'
	cString += '</Tributo>'
	cString += '</imposto>'
EndIf
cString += '<imposto>'
cString += '<codigo>PIS</codigo>'
If Len(aPIS)>0
	cString += '<Tributo>'
	cString += '<CST>'+aPIS[01]+'</CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(aPIS[02],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aPIS[03],5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(aPIS[06],15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(aPIS[05],16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(aPIS[04],15,2)+'</valor>'
	cString += '</Tributo>'
Else
	cString += '<Tributo>'
	cString += '<CST>08</CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(0,15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(0,5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(0,15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(0,16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(0,15,2)+'</valor>'
	cString += '</Tributo>'
EndIf
cString += '</imposto>'
If Len(aPISST)>0
	cString += '<imposto>'
	cString += '<codigo>PISST</codigo>'
	cString += '<Tributo>'
	cString += '<CST>'+aPISST[01]+'</CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(aPISST[02],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aPISST[03],5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(aPISST[06],15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(aPISST[05],16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(aPISST[04],15,2)+'</valor>'
	cString += '</Tributo>'
	cString += '</imposto>'
EndIf
cString += '<imposto>'
cString += '<codigo>COFINS</codigo>'
If Len(aCOFINS)>0
	cString += '<Tributo>'
	cString += '<CST>'+aCOFINS[01]+'</CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(aCOFINS[02],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aCOFINS[03],5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(aCOFINS[06],15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(aCOFINS[05],16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(aCOFINS[04],15,2)+'</valor>'
	cString += '</Tributo>'
Else
	cString += '<Tributo>'
	cString += '<CST>08</CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(0,15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(0,5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(0,15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(0,16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(0,15,2)+'</valor>'
	cString += '</Tributo>'
EndIf
cString += '</imposto>'
If Len(aCOFINSST)>0
	cString += '<imposto>'
	cString += '<codigo>COFINSST</codigo>'	
	cString += '<Tributo>'
	cString += '<CST>'+aCOFINSST[01]+'</CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(aCOFINSST[02],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aCOFINSST[03],5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(aCOFINSST[06],15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(aCOFINSST[05],16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(aCOFINSST[04],15,2)+'</valor>'
	cString += '</Tributo>'
	cString += '</imposto>'
EndIf
If Len(aISSQN)>0
	cString += '<cpl>'
	cString += '<cmunfg>'+aISSQN[04]+'</cmunfg>'
	cString += '<clistserv>'+aISSQN[05]+'</clistserv>'
	cString += '</cpl>'
	cString += '<imposto>'
	cString += '<codigo>ISS</codigo>'	
	cString += '<Tributo>'
	cString += '<CST></CST>'
	cString += '<modBC></modBC>'
	cString += '<pRedBC></pRedBC>'
	cString += '<vBC>'+ConvType(aISSQN[01],15,2)+'</vBC>'
	cString += '<aliquota>'+ConvType(aISSQN[02],5,2)+'</aliquota>'
	cString += '<vlTrib>'+ConvType(0,15,4)+'</vlTrib>'
	cString += '<qTrib>'+ConvType(0,16,4)+'</qTrib>'
	cString += '<valor>'+ConvType(aISSQN[03],15,2)+'</valor>'
	cString += '</Tributo>'
	cString += '</imposto>'
EndIf
cString += NfeTag('<infadprod>',ConvType(""))
cString += '</det>'

Static Function NfeTotal(aTotal,aRet)

Local cString:=""
Local nX     := 0

cString += '<total>'
cString += '<despesa>'+ConvType(aTotal[01],15,2)+'</despesa>'
cString += '<vNF>'+ConvType(aTotal[02],15,2)+'</vNF>'
If Len(aRet)>0
	For nX := 1 To Len(aRet)
		cString += '<TributoRetido>'
		cString += NfeTag('<codigo>' ,ConvType(aRet[nX,01],15,2))
		cString += NfeTag('<BC>'     ,ConvType(aRet[nX,02],15,2))
		cString += NfeTag('<valor>',ConvType(aRet[nX,03],15,2))
		cString += '</TributoRetido>'
	Next nX
EndIf
cString += '</total>'
Return(cString)

Static Function NfeTransp(cModFrete,aTransp,aImp,aVeiculo,aReboque,aVol)
           
Local nX := 0
Local cString := ""

DEFAULT aTransp := {}
DEFAULT aImp    := {}
DEFAULT aVeiculo:= {}
DEFAULT aReboque:= {}
DEFAULT aVol    := {}

cString += '<transp>'
cString += '<modFrete>'+cModFrete+'</modFrete>'
If Len(aTransp)>0
	cString += '<transporta>'
		If Len(aTransp[01])==14
			cString += NfeTag('<CNPJ>',aTransp[01])
		ElseIf Len(aTransp[01])<>0
			cString += NfeTag('<CPF>',aTransp[01])
		EndIf
		cString += NfeTag('<Nome>' ,ConvType(aTransp[02]))
		cString += NfeTag('<IE>'    ,aTransp[03])
		cString += NfeTag('<Ender>',ConvType(aTransp[04]))
		cString += NfeTag('<Mun>'  ,ConvType(aTransp[05]))
		cString += NfeTag('<UF>'    ,ConvType(aTransp[06]))
	cString += '</transporta>'
	If Len(aImp)>0 //Ver Fisco
		cString += '<retTransp>'
		cString += '<codigo>ICMS<codigo>'
		cString += '<Cpl>'
		cString += '<vServ>'+ConvType(aImp[01],15,2)+'</vServ>'
		cString += '<CFOP>'+ConvType(aImp[02])+'</CFOP>'
		cString += '<cMunFG>'+aImp[03]+'</cMunFG>'		
		cString += '</Cpl>'
		cString += '<CST>'+aImp[04]+'</CST>'
		cString += '<MODBC>'+aImp[05]+'</MODBC>'
		cString += '<PREDBC>'+ConvType(aImp[06],5,2)+'</PREDBC>'
		cString += '<VBC>'+ConvType(aImp[07],15,2)+'</VBC>'
		cString += '<aliquota>'+ConvType(aImp[08],5,2)+'</aliquota>'
		cString += '<vltrib>'+ConvType(aImp[09],15,4)+'</vltrib>'
		cString += '<qtrib>'+ConvType(aImp[10],16,4)+'</qtrib>'
		cString += '<valor>'+ConvType(aImp[11],15,2)+'</valor>'
		cString += '</retTransp>'
	EndIf
	If Len(aVeiculo)>0
		cString += '<veicTransp>'
			cString += '<placa>'+ConvType(aVeiculo[01])+'</placa>'
			cString += '<UF>'   +ConvType(aVeiculo[02])+'</UF>'
			cString += NfeTag('<RNTC>',ConvType(aVeiculo[03]))
		cString += '</veicTransp>'
	EndIf
	If Len(aReboque)>0
		cString += '<reboque>'
			cString += '<placa>'+ConvType(aReboque[01])+'</placa>'
			cString += '<UF>'   +ConvType(aReboque[02])+'</UF>'
			cString += NfeTag('<RNTC>',ConvType(aReboque[03]))
		cString += '</reboque>'
	EndIf	
	For nX := 1 To Len(aVol)		
		cString += '<vol>'
			cString += NfeTag('<qVol>',ConvType(aVol[nX][02]))
			cString += NfeTag('<esp>' ,ConvType(aVol[nX][01],15,0))
			//cString += '<marca>' +aVol[03]+'</marca>'
			//cString += '<nVol>'  +aVol[04]+'</nVol>'
			cString += NfeTag('<pesoL>' ,ConvType(aVol[nX][03],15,3))
			cString += NfeTag('<pesoB>' ,ConvType(aVol[nX][04],15,3))
			//cString += '<nLacre>'+aVol[07]+'</nLacre>'
		cString += '</vol>
	Next nX
EndIf
cString += '</transp>'
Return(cString)

Static Function NfeCob(aDupl)

Local cString := ""

Local nX := 0                  
If Len(aDupl)>0
	cString += '<cobr>'
	For nX := 1 To Len(aDupl)
		cString += '<dup>'
		cString += '<Dup>'+ConvType(aDupl[nX][01])+'</Dup>'
		cString += '<dtVenc>'+ConvType(aDupl[nX][02])+'</dtVenc>'
		cString += '<vDup>'+ConvType(aDupl[nX][03],15,2)+'</vDup>'
		cString += '</dup>'
	Next nX	
	cString += '</cobr>'
EndIf

Return(cString)

Static Function NfeInfAd(cMsgCli,cMsgFis,aPedido)

Local cString   := ""
DEFAULT aPedido := {}

If Len(cMsgFis)>0 .Or. Len(cMsgCli)>0
	cString += '<infAdic>'
	If Len(cMsgFis)>0
		cString += '<Fisco>'+ConvType(cMsgFis,Len(cMsgFis))+'</Fisco>'
	EndIf
	If Len(cMsgCli)>0
		cString += '<Cpl>'+ConvType(cMsgCli,Len(cMsgCli))+'</Cpl>'
	EndIf
	cString += '</infAdic>'
EndIf
If Len(aPedido)>0
	cString += '<compra>'
	cString += '<nEmp>'+aPedido[01]+'</nEmp>'
	cString += '<Pedido>'+aPedido[02]+'</Pedido>'
	cString += '<Contrato>'+aPedido[03]+'</Contrato>'
	cString += '</compra>'
EndIf	

Return(cString)

Static Function ConvType(xValor,nTam,nDec)

Local cNovo := ""
DEFAULT nDec := 0
Do Case
	Case ValType(xValor)=="N"
		If xValor <> 0
			cNovo := AllTrim(Str(xValor,nTam,nDec))	
		Else
			cNovo := "0"
		EndIf
	Case ValType(xValor)=="D"
		cNovo := FsDateConv(xValor,"YYYYMMDD")
		cNovo := SubStr(cNovo,1,4)+"-"+SubStr(cNovo,5,2)+"-"+SubStr(cNovo,7)
	Case ValType(xValor)=="C"
		If nTam==Nil
			xValor := AllTrim(xValor)
		EndIf
		DEFAULT nTam := 60
		cNovo := AllTrim(EnCodeUtf8(NoAcento(SubStr(xValor,1,nTam))))
EndCase
Return(cNovo)

Static Function Inverte(uCpo)

Local cCpo	:= uCpo
Local cRet	:= ""
Local cByte	:= ""
Local nAsc	:= 0
Local nI		:= 0
Local aChar	:= {}
Local nDiv	:= 0


Aadd(aChar,	{"0", "9"})
Aadd(aChar,	{"1", "8"})
Aadd(aChar,	{"2", "7"})
Aadd(aChar,	{"3", "6"})
Aadd(aChar,	{"4", "5"})
Aadd(aChar,	{"5", "4"})
Aadd(aChar,	{"6", "3"})
Aadd(aChar,	{"7", "2"})
Aadd(aChar,	{"8", "1"})
Aadd(aChar,	{"9", "0"})

For nI:= 1 to Len(cCpo)
   cByte := Upper(Subs(cCpo,nI,1))
   If (Asc(cByte) >= 48 .And. Asc(cByte) <= 57) .Or. ;	// 0 a 9
   		(Asc(cByte) >= 65 .And. Asc(cByte) <= 90) .Or. ;	// A a Z
   		Empty(cByte)	// " "
	   nAsc	:= Ascan(aChar,{|x| x[1] == cByte})
   	If nAsc > 0
   		cRet := cRet + aChar[nAsc,2]	// Funcao Inverte e chamada pelo rdmake de conversao
	   EndIf
	Else
		// Caracteres <> letras e numeros: mantem o caracter
		cRet := cRet + cByte
	EndIf
Next
Return(cRet)

Static Function NfeTag(cTag,cConteudo)

Local cRetorno := ""
If (!Empty(AllTrim(cConteudo)) .And. IsAlpha(AllTrim(cConteudo))) .Or. Val(AllTrim(cConteudo))<>0
	cRetorno := cTag+AllTrim(cConteudo)+SubStr(cTag,1,1)+"/"+SubStr(cTag,2)
EndIf
Return(cRetorno)

Static Function VldIE(cInsc,lContr)

Local cRet	:=	""
Local nI	:=	1
DEFAULT lContr  :=      .T.
For nI:=1 To Len(cInsc)
	If Isdigit(Subs(cInsc,nI,1)) .Or. IsAlpha(Subs(cInsc,nI,1))
		cRet+=Subs(cInsc,nI,1)
	Endif
Next
cRet := AllTrim(cRet)
If "ISENT"$Upper(cRet)
	cRet := ""
EndIf
If !(lContr) .And. !Empty(cRet)
	cRet := "ISENTA"
EndIf
Return(cRet)


static FUNCTION NoAcento(cString)
Local cChar  := ""
Local nX     := 0 
Local nY     := 0
Local cVogal := "aeiouAEIOU"
Local cAgudo := "áéíóú"+"ÁÉÍÓÚ"
Local cCircu := "âêîôû"+"ÂÊÎÔÛ"
Local cTrema := "äëïöü"+"ÄËÏÖÜ"
Local cCrase := "àèìòù"+"ÀÈÌÒÙ" 
Local cTio   := "ãõ"
Local cCecid := "çÇ"

For nX:= 1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
		nY:= At(cChar,cAgudo)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCircu)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cTrema)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf
		nY:= At(cChar,cCrase)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
		EndIf		
		nY:= At(cChar,cTio)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("ao",nY,1))
		EndIf		
		nY:= At(cChar,cCecid)
		If nY > 0
			cString := StrTran(cString,cChar,SubStr("cC",nY,1))
		EndIf
	Endif
Next
For nX:=1 To Len(cString)
	cChar:=SubStr(cString, nX, 1)
	If Asc(cChar) < 32 .Or. Asc(cChar) > 123 .Or. cChar $ '&'
		cString:=StrTran(cString,cChar,".")
	Endif
Next nX
cString := _NoTags(cString)
Return cString



/*
Static Function GetIdEnt()

Local aArea  := GetArea()
Local cIdEnt := ""
Local cURL   := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local oWs
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obtem o codigo da entidade                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"
	
oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")	
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM		
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""
oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
Else
	Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"OK"},3)
EndIf

RestArea(aArea)
Return(cIdEnt)

Static Function GetXML(cIdEnt,aIdNFe,cModalidade)

Local cURL       := PadR(GetNewPar("MV_SPEDURL","http://localhost:8080/sped"),250)
Local oWS
Local cRetorno   := ""
Local cProtocolo := ""
Local cRetDPEC   := ""
Local cProtDPEC  := ""
Local nX         := 0
Local nY         := 0
Local nL		 := 0
Local aRetorno   := {}
Local aResposta  := {}
Local aFalta     := {}
Local aExecute   := {}
Local nLenNFe
Local nLenWS
Local cDHRecbto  := ""
Local cDtHrRec   := ""
Local cDtHrRec1	 := ""
Local nDtHrRec1  := 0
Local lFlag      := .T.
Local dDtRecib	:=	CToD("")

Private oDHRecbto

If Empty(cModalidade)
	oWS := WsSpedCfgNFe():New()
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:nModalidade:= 0
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWS:CFGModalidade()
		cModalidade    := SubStr(oWS:cCfgModalidadeResult,1,1)
	Else
		cModalidade    := ""
	EndIf
EndIf
oWS:= WSNFeSBRA():New()
oWS:cUSERTOKEN        := "TOTVS"
oWS:cID_ENT           := cIdEnt
oWS:oWSNFEID          := NFESBRA_NFES2():New()
oWS:oWSNFEID:oWSNotas := NFESBRA_ARRAYOFNFESID2():New()
nLenNFe := Len(aIdNFe)
For nX := 1 To nLenNFe
	aadd(aRetorno,{"","",aIdNfe[nX][4]+aIdNfe[nX][5],"","","",CToD("")})
	aadd(oWS:oWSNFEID:oWSNotas:oWSNFESID2,NFESBRA_NFESID2():New())
	Atail(oWS:oWSNFEID:oWSNotas:oWSNFESID2):cID := aIdNfe[nX][4]+aIdNfe[nX][5]
Next nX
oWS:nDIASPARAEXCLUSAO := 0
oWS:_URL := AllTrim(cURL)+"/NFeSBRA.apw"

If oWS:RETORNANOTASNX()
	If Len(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5) > 0
		For nX := 1 To Len(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5)
			cRetorno        := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CXML
			cProtocolo      := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CPROTOCOLO
			cDHRecbto  		:= oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CXMLPROT
			If ValType(oWs:OWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:OWSDPEC)=="O"
				cRetDPEC        := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSDPEC:CXML
				cProtDPEC       := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSDPEC:CPROTOCOLO
			EndIf
			//Tratamento para gravar a hora da transmissao da NFe
			If !Empty(cProtocolo)
				oDHRecbto		:= XmlParser(cDHRecbto,"","","")
				cDtHrRec		:= IIf(Type("oDHRecbto:_ProtNFE:_INFPROT:_DHRECBTO:TEXT")<>"U",oDHRecbto:_ProtNFE:_INFPROT:_DHRECBTO:TEXT,"")
				nDtHrRec1		:= RAT("T",cDtHrRec)
				
				If nDtHrRec1 <> 0
					cDtHrRec1   :=	SubStr(cDtHrRec,nDtHrRec1+1)
					dDtRecib	:=	SToD(StrTran(SubStr(cDtHrRec,1,AT("T",cDtHrRec)-1),"-",""))
				EndIf
				dbSelectArea("SF2")
				dbSetOrder(1)
				If MsSeek(xFilial("SF2")+aIdNFe[nX][5]+aIdNFe[nX][4]+aIdNFe[nX][6]+aIdNFe[nX][7])
					If SF2->(FieldPos("F2_HORA"))<>0 .And. Empty(SF2->F2_HORA)
						RecLock("SF2")
						SF2->F2_HORA := cDtHrRec1
						MsUnlock()
					EndIf
				EndIf
				dbSelectArea("SF1")
				dbSetOrder(1)
				If MsSeek(xFilial("SF1")+aIdNFe[nX][5]+aIdNFe[nX][4]+aIdNFe[nX][6]+aIdNFe[nX][7])
					If SF1->(FieldPos("F1_HORA"))<>0 .And. Empty(SF1->F1_HORA)
						RecLock("SF1")
						SF1->F1_HORA := cDtHrRec1
						MsUnlock()
					EndIf
				EndIf
			EndIf
			nY := aScan(aIdNfe,{|x| x[4]+x[5] == SubStr(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:CID,1,Len(x[4]+x[5]))})
			If nY > 0
				aRetorno[nY][1] := cProtocolo
				aRetorno[nY][2] := cRetorno
				aRetorno[nY][4] := cRetDPEC
				aRetorno[nY][5] := cProtDPEC
				aRetorno[nY][6] := cDtHrRec1
				aRetorno[nY][7] := dDtRecib
				
				aadd(aResposta,aIdNfe[nY])
			EndIf
			cRetDPEC := ""
			cProtDPEC:= ""
		Next nX
		For nX := 1 To Len(aIdNfe)
			If aScan(aResposta,{|x| x[4] == aIdNfe[nX,04] .And. x[5] == aIdNfe[nX,05] })==0
					aadd(aFalta,aIdNfe[nX])
			EndIf
		Next nX
		If Len(aFalta)>0
			aExecute := GetXML(cIdEnt,aFalta,@cModalidade)
		Else
			aExecute := {}
		EndIf
		For nX := 1 To Len(aExecute)
			nY := aScan(aRetorno,{|x| x[3] == aExecute[nX][03]})
			If nY == 0
				aadd(aRetorno,{aExecute[nX][01],aExecute[nX][02],aExecute[nX][03]})
			Else
				aRetorno[nY][01] := aExecute[nX][01]
				aRetorno[nY][02] := aExecute[nX][02]
			EndIf
		Next nX
	EndIf
Else
	Aviso("DANFE",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"OK"},3)
EndIf

Return(aRetorno)

Static Function ConvDate(cData)

Local dData
cData  := StrTran(cData,"-","")
dData  := Stod(cData)
Return PadR(StrZero(Day(dData),2)+ "/" + StrZero(Month(dData),2)+ "/" + StrZero(Year(dData),4),15)