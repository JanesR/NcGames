#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGrInv	     บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar o arquivo invoice.							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 				  			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณalNfOk - informa็๕es da(s) nota(s) dos arquivos invoice         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function KZGrInv(aInfo, lAuto)

	Local alNfOk		:= {}
	Local clQuery		:= ""
	
	Default aInfo		:= {}
	Default lAuto		:= .F.


	//Verifica se foi chamado via tela de gera็ใo de invoice ou via job
	If !lAuto
		//Chama a fun็ใo que ira se basear no array aInfo		
		alNfOk := KzBuscaInfo(aInfo)
	Else
		clQuery := " SELECT * " + CRLF
		clQuery += " FROM" + CRLF
		clQuery += " 	(" + CRLF
		clQuery += " 		SELECT	F2_DOC," + CRLF
		clQuery += " 				F2_SERIE, " + CRLF
		clQuery += " 				F2_CLIENTE," + CRLF
		clQuery += " 				F2_LOJA, " + CRLF
		clQuery += " 				F2_EMISSAO " + CRLF
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
		clQuery += " 					ZAE_STATUS" + CRLF
		clQuery += " 			FROM " + RETSQLNAME("ZAE") + CRLF
		clQuery += " 			WHERE	D_E_L_E_T_ <> '*'" + CRLF
		clQuery += " 					AND ZAE_FILIAL = '" + xFilial("ZAE") + "'" + CRLF
		clQuery += " 					AND ZAE_STATUS <> '6'" + CRLF
		clQuery += " ) ZAE ON ZAE.ZAE_NUMEDI = SC5.C5_NUMEDI" + CRLF
		clQuery += " ORDER BY F2_CLIENTE,ZAE_NUMEDI" + CRLF
		
		//Change query para ajustar a query para oracle
		clQuery := ChangeQuery(clQuery)
		
		If Select("TMP1") > 0
			TMP1->(dbCloseArea())
		EndIf
		
		dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "TMP1", .F., .F. )
		//TABELA SELECIONADA PARA VERIFICAR SE O CLIENTE PODERA RECEER ARQUIVO INVOICE
		dbSelectArea("ZAA")
		ZAA->(dbSetOrder(1))
		If TMP1->(!EOF())
			While TMP1->(!EOF())
				If ZAA->(dbSeek(xFilial("ZAA")+TMP1->F2_CLIENTE+TMP1->F2_LOJA+"04"))
					AADD(aInfo,{TMP1->F2_CLIENTE,TMP1->F2_LOJA,TMP1->F2_DOC,TMP1->F2_SERIE,TMP1->ZAE_NUMEDI,StoD(TMP1->F2_EMISSAO)})
				EndIf
				TMP1->(dbSkip())
			EndDo
			//Chama a fun็ใo que executa via job
			alNfOk := KzBuscaInfo(aInfo)
		Else
			Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")
			Conout(dtoc( Date() ) + " " + Time() + " " + "|=========NAO EXISTEM INVOICES A SEREM GERADAS=========|")
			Conout(dtoc( Date() ) + " " + Time() + " " + "========================================================")	
		EndIf
	EndIf

	
Return alNfOk
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZBuscaInfo    บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar o arquivo invoice.							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaInfo - array com informa็๕es do pedido EDI e nota fiscal		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 			                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZBuscaInfo(aInfo)

	Local clCamin		:= SuperGetMv("KZ_INVFLD",.F.,"")
	Local clDir			:= CurDir()
	Local clNomCli		:= ""
	Local clNomArq		:= ""
	Local nx			:= 0
	Local clQuery		:= ""
	Local lCria			:= .T.
	Local alNfOk		:= {}
	Local alNoPerm		:= {}
	Local clMsg			:= ""
	
	Private npHandle	:= 0
	Private npTotLi		:= 0
	Private npTPBrut	:= 0
	Private npTPLiq		:= 0
	Private npQtdFat	:= 0
		
	If Empty(clCamin)
		ShowHelpDlg("EMBRANCO",{"O parametro KZ_INVFLD nใo estแ preenchido! Nใo serแ possivel gerar o arquivo invoice"},5,{"Preencher o parametro com o caminho da pasta onde deseja salvar os arquivos invoice."},5)
		Return alNfOk
	EndIf
	//Retira a barra para verificar se o caminho existe
	If Rat("\",clCamin) == Len(AllTrim(clCamin))
		clCamin := SubStr(clCamin,1,Len(clCamin)-1)
	EndIf
	If Rat("\",clDir) == Len(AllTrim(clDir))
		clDir := SubStr(clDir,1,Len(clDir)-1)
	EndIf
	If !File(clDir+clCamin)
		ShowHelpDlg("NAOEXISTE",{"O caminho especificado no parametro KZ_INVFLD nใo existe, o arquivo invoice nใo poderแ ser gerado."},5,{"Alterar o parametro e informar um caminho vแlido."})
		Return alNfOk
	EndIf
	//inclui a barra para a funcao de criar o arquivo.
	clCamin += "\"
	For nx:= 1 to Len(aInfo)
		// Verifica se O cliente + Loja tem permissao de gerar invoice
		If !(U_KZVlTDoc(AllTrim(aInfo[nx][1]),AllTrim(aInfo[nx][2]),"04")) // 04 -> Invoice
			If aScan(alNoPerm, AllTrim(aInfo[nx][1])+"/"+AllTrim(aInfo[nx][2])) == 0
				aAdd(alNoPerm,AllTrim(aInfo[nx][1])+"/"+AllTrim(aInfo[nx][2]))
			EndIf
			Loop
		EndIf
		
		clQuery	:= " SELECT * " + CRLF
		clQuery	+= " FROM " + CRLF
		clQuery	+= " ( " + CRLF
		clQuery	+= " 	SELECT	F2_DOC, " + CRLF
		clQuery	+= " 			F2_SERIE, " + CRLF
		clQuery	+= " 			F2_TIPO, " + CRLF
		clQuery	+= " 			F2_EMISSAO, " + CRLF
		clQuery	+= " 			F2_EST, " + CRLF
		clQuery	+= " 			F2_COND, " + CRLF
		clQuery	+= " 			F2_ESPECIE, " + CRLF
		clQuery	+= " 			F2_DTENTR, " + CRLF
		clQuery	+= " 			F2_CLIENTE, " + CRLF
		clQuery	+= " 			F2_LOJA, " + CRLF
		clQuery	+= " 			F2_VALBRUT, " + CRLF
		clQuery	+= " 			F2_DUPL, " + CRLF
		clQuery	+= " 			F2_FILIAL, " + CRLF
		clQuery	+= " 			F2_DESCONT, " + CRLF
		clQuery	+= " 			F2_FRETE, " + CRLF
		clQuery	+= " 			F2_SEGURO, " + CRLF
		clQuery	+= " 			F2_BASEICM, " + CRLF
		clQuery	+= " 			F2_VALICM, " + CRLF
		clQuery	+= " 			F2_BASEIPI, " + CRLF
		clQuery	+= " 			F2_VALIPI, " + CRLF
		clQuery	+= " 			F2_VALCOFI, " + CRLF
		clQuery	+= " 			F2_VALPIS, " + CRLF
		clQuery	+= " 			F2_CHVNFE, " + CRLF
		clQuery	+= " 			F2_VOLUME1 " + CRLF
		clQuery	+= " 	FROM " + RETSQLNAME("SF2") + CRLF
		clQuery	+= " 	WHERE	D_E_L_E_T_ <> '*' " + CRLF
		clQuery	+= " 	AND		F2_FILIAL = '" + xFilial("SF2")+ "' " + CRLF
		clQuery	+= " 	AND		F2_CLIENTE = '" + aInfo[nx][1] + "' " + CRLF
		clQuery	+= " 	AND		F2_LOJA = '" + aInfo[nx][2] + "' " + CRLF
		clQuery	+= " 	AND		F2_DOC = '" + aInfo[nx][3] + "' "  + CRLF
		clQuery	+= " 	AND		F2_SERIE = '" + aInfo[nx][4] + "' "  + CRLF
		clQuery	+= " )SF2 " + CRLF
		clQuery	+= " INNER JOIN (" + CRLF
		clQuery	+= " 			SELECT	D2_DOC, " + CRLF
		clQuery	+= " 					D2_SERIE, " + CRLF
		clQuery	+= " 					D2_CF, " + CRLF
		clQuery	+= " 					D2_PEDIDO " + CRLF
		clQuery	+= " 			FROM " + RETSQLNAME("SD2") + CRLF
		clQuery	+= " 			WHERE	D_E_L_E_T_ <> '*' " + CRLF
		clQuery	+= " 			AND D2_FILIAL = '" + xFilial("SD2") + "'" + CRLF
		clQuery += " 			GROUP BY D2_DOC,D2_SERIE,D2_CF,D2_PEDIDO" + CRLF
		clQuery	+= " ) SD2 ON SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE " + CRLF
		clQuery	+= " LEFT JOIN ( " + CRLF
		clQuery	+= " 		SELECT E1_FILIAL, E1_NUM, E1_CLIENTE, E1_LOJA, E1_PORCJUR " + CRLF
		clQuery	+= " 		FROM " + RETSQLNAME("SE1") + CRLF
		clQuery	+= " 		WHERE	D_E_L_E_T_ <> '*' " + CRLF
		clQuery	+= " ) SE1 ON SF2.F2_FILIAL = SE1.E1_FILIAL AND SF2.F2_DOC = SE1.E1_NUM " + CRLF
		clQuery	+= " 	  AND SF2.F2_CLIENTE = SE1.E1_CLIENTE AND SF2.F2_LOJA = SE1.E1_LOJA " + CRLF
		clQuery	+= " INNER JOIN ( " + CRLF
		clQuery	+= " 			SELECT	C5_NUM, " + CRLF
		clQuery	+= " 					C5_NUMEDI " + CRLF
		clQuery	+= " 			FROM " + RETSQLNAME("SC5") + CRLF
		clQuery	+= " 			WHERE	D_E_L_E_T_ <> '*' " + CRLF
		clQuery	+= " 					AND C5_FILIAL = '" + xFilial("SC5") + "'" + CRLF
		clQuery	+= " ) SC5 ON SC5.C5_NUM = SD2.D2_PEDIDO " + CRLF
		clQuery	+= " INNER JOIN (" + CRLF
		clQuery	+= " 			SELECT	ZAE_NUMEDI, " + CRLF
		clQuery	+= " 					ZAE_CGCFOR, " + CRLF
		clQuery	+= " 					ZAE_CGCCOB, " + CRLF
		clQuery	+= " 					ZAE_CGCFAT, " + CRLF
		clQuery	+= " 					ZAE_CGCENT, " + CRLF
		clQuery	+= " 					ZAE_NUMCLI, " + CRLF
		clQuery	+= " 					ZAE_TPFRET, " + CRLF
		clQuery	+= " 					ZAE_TRANSP " + CRLF
		clQuery	+= " 					 " + CRLF
		clQuery	+= " 			FROM " + RETSQLNAME("ZAE") + CRLF
		clQuery	+= " 			WHERE	D_E_L_E_T_ <> '*' " + CRLF
		clQuery	+= " 					AND ZAE_STATUS IN ('5','6') " + CRLF
		clQuery	+= " 					AND ZAE_NUMEDI = '" + aInfo[nx][5] + "' " + CRLF
		clQuery	+= " )ZAE ON ZAE.ZAE_NUMEDI = SC5.C5_NUMEDI " + CRLF
//		clQuery	+= " LEFT JOIN (" + CRLF
//		clQuery	+= "	 	SELECT * " + CRLF
//		clQuery	+= " 		FROM " + RETSQLNAME("ZAH") + CRLF
//		clQuery	+= " 		WHERE D_E_L_E_T_ <> '*' " + CRLF
//		clQuery	+= " 		AND ZAH_NUMALT = '' " + CRLF
//		clQuery	+= " 		) ZAH ON ZAE.ZAE_NUMEDI = ZAH.ZAH_NUMEDI " + CRLF
		clQuery	+= "  LEFT JOIN (" + CRLF
		clQuery	+= "        SELECT A4_COD, A4_CGC " + CRLF
		clQuery	+= " 		FROM " + RETSQLNAME("SA4") + CRLF
		clQuery	+= "        WHERE D_E_L_E_T_ <> '*' " + CRLF
		clQuery	+= "  ) SA4 ON ZAE.ZAE_TRANSP = SA4.A4_COD " + CRLF   
		
		clQuery := ChangeQuery(clQuery)
		
		If Select("CABNF") > 0
			CABNF->(dbCloseArea())
		EndIf
		
		dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "CABNF", .F., .F. )
		If CABNF->(!EOF())

			If lCria
				//Gera o nome do arquivo baseado nas informa็๕es do cliente e da nota.
				clNomCli := Posicione("SA1",1,xFilial("SA1")+aInfo[nx][1] +  aInfo[nx][2],"A1_NREDUZ")
				clNomArq := "NFInvoice" + "_" + STRTRAN(AllTrim(clNomCli)," ", "_") + "_" + DtoS(dDataBase) + StrTran(Time(),":")
				clNomArq += ".inv"
				
				//Tenta criar o arquivo na pasta especificada.
				npHandle := FCreate(clDir+clCamin + clNomArq )
				
				If npHandle < 0
					MsgStop("Nใo foi possํvel criar o arquivo para o cliente: " + aInfo[nx][1] + "/" + aInfo[nx][2] + " - " + clNomCli,"Erro")
					loop
				EndIf
			EndIf
		EndIf
		While CABNF->(!EOF())
			npTotLi		:= 0
			npTPBrut	:= 0
			npTPLiq		:= 0
			npQtdFat	:= 0
			//Grava o cabecalho da nota
			KZGrvCab()
			//Grava as informa็๕es de pagamento
			KZGrvPag()
			//Grava os encargos e descontos da nota
			KZGrvDsc()
			//Grava os itens da nota fiscal
			KZGrvItem()
			//Grava o sumario da nota fiscal
			KZGrvSum()
			AADD(alNfOk,{aInfo[nx][5],aInfo[nx][3],aInfo[nx][4],aInfo[nx][1], aInfo[nx][2],aInfo[nx][6] })
			CABNF->(dbSkip())
		EndDo
		CABNF->(dbCloseArea())
		If (nx + 1) > Len(aInfo)
			//Fecha o arquivo ap๓s a grava็ใo das informa็๕es
			FClose(npHandle)
		Else
			If aInfo[nx][1] != aInfo[nx+1][1] .And. aInfo[nx][2] != aInfo[nx+1][2]
				//Fecha o arquivo ap๓s a grava็ใo das informa็๕es
				FClose(npHandle)
				lCria := .T.
			Else
				lCria := .F.
			EndIF
		EndIf
	Next nx
	
	If Len(alNoPerm) > 0
		For nx := 1 To Len(alNoPerm)
			Conout(dtoc( Date() ) + " " + Time() + " " + "Cliente/Loja: " + alNoPerm[nx] + " - Nใo permite gerar invoice." )
			clMsg += "- " + alNoPerm[nx] + CRLF
		Next nx
		Alert("Cliente(s)/Loja(s) abaixo nใo permite(m) gera็ใo de invoice:" + CRLF + clMsg	)
	EndIf

Return alNfOk
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGrvCab	     บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar a linha do cabe็alho							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 				  			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 			                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZGrvCab()

	Local clTexto	:= ""
	Local clMsg		:= ""
	Local clCgcComp	:= ""
	Local clNomeTr	:= ""
	Local clTpFrete	:= ""
	

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณCabe็alho da nota fiscalณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
    //Tipo do registro 0-1
	clTexto := "01"
	
	//Fun็ใo Mensagem 2-4
	If CABNF->F2_ESPECIE $ "CTA|CTF|CTR|CA"
		clMsg := "42 "
	ElseIf AllTrim(CABNF->F2_TIPO) == "N"
		clMsg := "9  "
	ElseIf AllTrim(CABNF->F2_TIPO) $ "I|P|C"
		clMsg := "2  "
	EndIf
	clTexto += clMsg //SubStr(PadR(clMsg,3," "),1,3)
	
	//tipo de nota 5-7
	clTexto += SubStr(PadR("325",3," "),1,3)
	
	//Numero da nota 8-16
	clTexto += SubStr(Padl(AllTrim(CABNF->F2_DOC),9,"0"),1,9)	
	
	//Serie da nota 17-19
	clTexto += SubStr(PadR(AllTrim(CABNF->F2_SERIE),3," "),1,3)

	//Sub-serie de nota fiscal 20-21
	clTexto += "01"

	//Data - Hora de emissใo da Nota Fiscal 22-33
	clTexto += CABNF->F2_EMISSAO + "0000"
	
	//Data - Hora de Despacho ou Saida 34-45
	clTexto += Replicate("0",12)//DtoS() + "0000"
	
	//Data - Hora de Entrega 46-57
	clTexto += IIF(Empty(CABNF->F2_DTENTR),Replicate("0",12), CABNF->F2_DTENTR + "0000")
	
	//C๓digo fiscal de Opera็๕e e Presta็๕es 58-62
	clTexto += PadR(CABNF->D2_CF,5) //SubStr(Padl("",5," "),1,5)
	
	//Numero do pedido do comprador 63-82 (A)
	//clTexto += SubStr(PadL(CABNF->ZAE_NUMCLI,20,"0"),1,20)
	clTexto += PadR(Alltrim(CABNF->ZAE_NUMCLI),20)
	
	//Numero do pedido do sistema de emissใo 83-102
	//clTexto += SubStr(PadL(CABNF->C5_NUM,20,"0"),1,20)
	clTexto += PadR(Alltrim(CABNF->C5_NUM),20)
	
	//numero do contrato 103-117
	clTexto += Replicate(" ", 15) //Padl("0",15,"0")
	//Lista de pre็oes 118-132
	clTexto += Replicate(" ", 15) //Padl("0",15,"0")
	//EAN de localiza็ใo do comprador 133-145
	clTexto += Replicate("0",13) //Padl("0",13,"0")
	//EAN de Localiza็ใo da Cobran็a da Fatura 146-158
	clTexto += Replicate("0",13) //Padl("0",13,"0")
	//EAN de Localiza็ใo do Local de Entrega 159-171
	clTexto += Replicate("0",13) //Padl("0",13,"0")
	//EAN de Localiza็ใo do Fornecedor 172-184
	clTexto += Replicate("0",13) //Padl("0",13,"0")
	//EAN de Localiza็ใo do Emissor da Nota 185-197
	clTexto += Replicate("0",13) //Padl("0",13,"0")
	
	//CNPJ  do comprador 198-211
	clCgcComp	:= Posicione("SA1",1,xFilial("SA1")+CABNF->F2_CLIENTE+CABNF->F2_LOJA,"A1_CGC")
	clTexto += PadL(Alltrim(clCgcComp),14,"0")
	
	//CNPJ  do Local de Cobran็a da fatura 212-225
	clTexto += PadL(Alltrim(CABNF->ZAE_CGCCOB),14,"0")
	
	//CNPJ  do Local de Entrega 226-239
	clTexto += PadL(Alltrim(CABNF->ZAE_CGCENT),14,"0")
	
	//CNPJ  do Local do Fornecedor 240-253
	clTexto += PadL(Alltrim(CABNF->ZAE_CGCFOR),14,"0")
	
	//CNPJ do Emissor da Nota 254-267
	clTexto += PadL(Alltrim(SM0->M0_CGC),14,"0")
	
	//Estado emissor da nota 268-269
	clTexto += PadR(Alltrim(SM0->M0_ESTCOB),2)
	
	//Inscricao Estadual do Emissor da Nota 270-289
	clTexto += PadR(Alltrim(SM0->M0_INSC),20)
	
	//Tipo de c๓digo da transportador 290-292
	clTexto += "251"
	
	//Codigo da transportadora 293-306
	clTexto += PadL(AllTrim(CABNF->A4_CGC),14,"0")
	
	//Nome da Transportadore 307-336
	clNomeTr := Posicione("SA4",1,xFilial("SA4")+CABNF->ZAE_TRANSP,"A4_NOME")
	clTexto	 += PadR(clNomeTr,30)
	
	//Condi็ใo de Entrega (tipo de frete) 337-339
	clTpFrete := Iif(CABNF->ZAE_TPFRET == "C", "CIF", "FOB")
	clTexto += SubStr(clTpFrete,1,3)

	//Chave de Acesso NF-E (tipo de frete) 340-383
	clTexto += PadR(Alltrim(CABNF->F2_CHVNFE),44)
	
	clTexto += CRLF
	//Grava o texto no arquivo.
	FWrite(npHandle,clTexto)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGrvPag	     บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar a(s) linha(s) do Pagamento					  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 				  			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 			                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZGrvPag()
	
	Local clTexto	:= ""
	Local alParc	:= {}
	Local nx		:= 0
	Local clTipCnd	:= ""
	Local clRefDt	:= ""
	Local clRefTp	:= ""
	Local clDDD		:= ""
	Local nlPerc	:= 0
	
	
	alParc := Condicao(/*valortotal*/CABNF->F2_VALBRUT,/*condicao de pagamento*/CABNF->F2_COND,0,/*data emissao*/StoD(CABNF->F2_EMISSAO),0)
	If len(alParc) > 1
		clTipCnd	:= "21"//Pagamento Parcelado
		nlPerc		:= 100/Len(alParc)
	ElseIf len(alParc) == 1
		clTipCnd	:= "1"//Basico
		nlPerc		:= 100
	EndIf
	clDDD := Posicione("SE4",1,xFilial("SE4")+CABNF->F2_COND,"E4_DDD")
	If clDDD == "D"
		clRefTp := "1" //NA DATA DE REFERNCIA
	ElseIf clDDD == "L"
		clRefTp := "3" //APOS DATA DE REFERENCIA
	ElseIf clDDD == "Z"
		clRefTp := "4" //Final do perํodo de dez dias contendo a data de refer๊ncia (fora a dezena)
	ElseIf clDDD == "F"
		clRefTp := "6"  //Final do m๊s contendo a data de refer๊ncia (fora o m๊s)
	ElseIf clDDD == "S"
		clRefTp := "10" //Final da semana contendo a data de refer๊ncia (fora a semana)
	ElseIf clDDD == "Q"
		clRefTp := "10E" //Final da quinzena contendo a data de refer๊ncia (fora quinzena)
	EndIf
	 
	//referencia de data sempre serแ data da fatura
	clRefDt := "5"
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณRegistro 02 - Pagamento ( de 0 a N ocorrencias)ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
    For nx:= 1 to len(alParc)
	    //Tipo de Registro 0-1
	    clTexto := "02"
	    
	    //Condi็ใo de Pagamento 2-4
	    clTexto += PadR(clTipCnd,3)
	    
	    //Referencia da data 5-7
	    clTexto += PadR(clRefDt,3)
	    
	    //Referencia de Tempo 8-10
	    clTexto += PadR(clRefTp,3)
	    
	    //Tipo de Periodo 11-13
	    clTexto += PadR("WD ",3) //Dias Uteis (excluindo fins-de-semana e feriados)
	    
	    //Numero de Periodo 14-16  (N 3,0)
	    clTexto += PadL(StrZero(Len(alParc)),3,"0")
	    
	    //Data de vencimento 17-24  (D 8)
	    clTexto += DtoS(alParc[nx][1])
	    
	    //Tipo de Percentual da Condi็ใo de Pagamento 25-27
	    clTexto += SubStr(Padl("12E",3," "),1,3) //Percentual do Valor Devido ou Valor da Parcela
	    //clTexto += "16 " //Juros
	    
	    //Percentual da Condi็ใo de Pagamento 28-32 numerico 2 decimais
	    //clTexto += PadL(Alltrim(Replace(Transform(CABNF->E1_PORCJUR,"999.99"),".","")),5,"0") //SubStr(STRZERO(0,5),1,5)
	    clTexto += PadL(StrTran(AllTrim(Str(nlPerc,6,2)),"."),5,"0")

	    //Tipo de Valor da Condi็ใo de Pagamento 33-35
	    clTexto += "262"
	    
	    //Valor da condi็ao de pagamento 36-50 (N 15,2)
	    clTexto += PadL(Alltrim(Replace(Transform(alParc[nx][2],"9999999999999.99"),".","")),15,"0")
/*		
   	    //Numero do Titulo 51-60
	    clTexto += PADL(CABNF->F2_DUPL,10,"0")
		
	    //Local de Pagamento 61-64
	    clTexto += PadL("",4)
	    
	    //Data de antecipa็ใo 65-72
	    clTexto += Padl("",8)
	    
	    //Percentual do desconto Antecipado 73-76 numerico 2 decimais
	    clTexto += Padl("",4)
	    
	    //Percentual do desconto Limite 77-80 numerico 2 decimais
	    clTexto += Padl("",4)
*/	    
	    clTexto += CRLF
	   	//Grava o texto no arquivo.
	    FWrite(nPHandle,clTexto)
	    
	Next nx

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGrvDsc	     บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar a(s) linha(s) de descontos e encargos			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 				  			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 			                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZGrvDsc()
	
	Local clTexto	:= ""
	Local clQuery	:= ""
	Local nlPDes	:= 0
	
	
	clQuery	:= " SELECT SUM(D2_DESCON) AS TOTDESC ,SUM(D2_TOTAL) AS VALTOT " + CRLF
	clQuery	+= " FROM " + RETSQLNAME("SD2") + CRLF
	clQuery	+= " WHERE	D2_FILIAL = '" + xFilial("SD2") + "' " + CRLF
	clQuery	+= " 		AND D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 		AND D2_DOC = '" + CABNF->F2_DOC + "' " + CRLF
	clQuery	+= " 		AND D2_SERIE = '" + CABNF->F2_SERIE + "' " + CRLF
	
	clQuery := ChangeQuery(clQuery)
	
	If Select("TRBDSC") > 0
		TRBDSC->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "TRBDSC", .F., .F. )
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณRegistro 03 - Descontos e encargos da nota fiscalณ
	//ณ(de zero a uma ocorrencia)                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !Empty(TRBDSC->TOTDESC) //.Or. !Empty(CABNF->F2_?) -- campo de percentual de encargos financeiros
		//Tipo do registro 0-1
		clTexto := "03"
		//Percentual de Desconto Financeiro 2-6 numerico(5,2)
		clTexto += Padl("0",5,"0")
		//Valor do Desconto Financeiro 7-21 numerico(15,2)
		clTexto += Padl("0",15,"0")	
		
		nlPdes := NOROUND(( (TRBDSC->TOTDESC * 100) / TRBDSC->VALTOT ),2)
		//Percentual de Desconto Comercial 22-26 numerico(5,2)
		clTexto += STRZERO(nlPdes,5)
		
		//Valor do Desconto Comercial 27-41 numerico(15,2)
		//clTexto += SubStr(STRZERO(TRBDSC->TOTDESC,15),1,15)
		clTexto += PadL(Alltrim(Replace(Transform(TRBDSC->TOTDESC,15,"9999999999999.99"),".","")),15,"0")
		
		//Percentual de Desconto Promocional 42-46 numerico(5,2)
		clTexto += Padl("0",5,"0")
		
		//Valor do Desconto Promocional 47-61 numerico(15,2)
		clTexto += Padl("0",15,"0")
		
		//Percentual de Encargos financeiro 62-66 numerico(5,2)
		clTexto += Padl("0",5,"0")
		
		//Valor dos Encargos Financeiros 67-81 numerico(15,2)
		clTexto += Padl("0",15,"0")
		
		//Percentual de Encargos de Frete 82-86 numerico(5,2)
		clTexto += Padl("0",5,"0")
		
		//Valor do Encargos de frete 87-101 numerico(15,2)
		//clTexto += SubStr(STRZERO(CABNF->F2_FRETE,15),1,15)
		clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_FRETE,15,"9999999999999.99"),".","")),15,"0")
		
		//Percentual de Encargos de Seguro 102-106 numerico(5,2)
		clTexto += Padl("0",5,"0")
		
		//Valor do Encargos de Seguro 107-121 numerico(15,2)
		//clTexto += SubStr(STRZERO(CABNF->F2_SEGURO,15),1,15)
		clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_SEGURO,15,"9999999999999.99"),".","")),15,"0")
		
	    clTexto += CRLF
	   	//Grava o texto no arquivo.
	    FWrite(npHandle,clTexto)
	    
	 EndIf

    
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGrvItem	     บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar a(s) linha(s) dos itens da nota				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 				  			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 			                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZGrvItem()
	
	Local clTexto	:= ""
	Local clQuery	:= ""
	Local clNumIt	:= ""
	Local nlValIpi	:= 0
	Local nBrutUnit	:= 0
	Local nLiqUnit	:= 0
	
	
	clQuery	:= " SELECT * " + CRLF
	clQuery	+= " FROM ( " + CRLF
	clQuery	+= " 		SELECT	D2_ITEM, " + CRLF
	clQuery	+= " 				D2_ITEMPV, " + CRLF
	clQuery	+= " 				D2_UM, " + CRLF
	clQuery	+= " 				D2_QUANT, " + CRLF
	clQuery	+= " 				D2_PRCVEN, " + CRLF
	clQuery	+= " 				D2_TOTAL, " + CRLF
	clQuery	+= " 				D2_COD, " + CRLF
	clQuery	+= " 				D2_BASEICM, " + CRLF
	clQuery	+= " 				D2_VALICM, " + CRLF
	clQuery	+= " 				D2_VALIPI, " + CRLF
	clQuery	+= " 				D2_DESC, " + CRLF
	clQuery	+= " 				D2_DESCON, " + CRLF
	clQuery	+= " 				D2_IPI, " + CRLF
	clQuery	+= " 				D2_PICM, " + CRLF
	clQuery	+= " 				D2_ALQPIS, " + CRLF
	clQuery	+= " 				D2_ALQCOF, " + CRLF
	clQuery	+= " 				D2_TES, " + CRLF
	clQuery	+= " 				D2_NUMLOTE, " + CRLF
	clQuery	+= " 				D2_PESO, " + CRLF
	clQuery	+= " 				D2_CF, " + CRLF
	clQuery	+= " 				D2_CLASFIS " + CRLF	
	clQuery	+= " 		FROM " + RETSQLNAME("SD2") + CRLF
	clQuery	+= " 		WHERE	D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 				AND D2_FILIAL = '" + xFilial("SD2") + "' " + CRLF
	clQuery	+= " 				AND D2_DOC = '" + CABNF->F2_DOC + "' " + CRLF
	clQuery	+= " 				AND D2_SERIE = '" + CABNF->F2_SERIE + "' " + CRLF
	clQuery	+= " 	)SD2 " + CRLF
	clQuery	+= " INNER JOIN " + CRLF
	clQuery	+= " ( " + CRLF
	clQuery	+= " 	SELECT	B1_COD, " + CRLF
	clQuery	+= " 			B1_CODBAR, " + CRLF
	clQuery	+= " 			B1_PESO, " + CRLF
	clQuery	+= " 			B1_PESBRU, " + CRLF
	clQuery	+= " 			B1_UM, " + CRLF
	clQuery	+= " 			B1_SEGUM, " + CRLF
	clQuery	+= " 			B1_IPI, " + CRLF
	clQuery	+= " 			B1_EX_NCM, " + CRLF	
	clQuery	+= " 			B1_PICMRET, " + CRLF	
	clQuery	+= " 			B1_POSIPI " + CRLF		
	clQuery	+= " 	FROM " + RETSQLNAME("SB1") + CRLF
	clQuery	+= " 	WHERE	D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 			AND B1_FILIAL = '" + xFilial("SB1") + "' " + CRLF
	clQuery	+= " )SB1 ON SD2.D2_COD = SB1.B1_COD " + CRLF
	clQuery	+= " ORDER BY D2_ITEM " + CRLF
	
	clQuery := ChangeQuery(clQuery)
	If Select("ITMNF") > 0
		ITMNF->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "ITMNF", .F., .F. )
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณRegistro 04 - ITENS ( de uma a N ocorrencias )ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	While ITMNF->(!EOF())
		//[1] - Tipo do Registro 0-1
		clTexto := "04"
		
		//[2] - Numero sequencial da Lina de Item 2-5
		clNumIt := Soma1(clNumIt)
		clTexto += PadL(clNumIt,4,"0")
		
		//[3] - Numero do item no pedido 6-10
		clTexto += PadL(AllTrim(ITMNF->D2_ITEMPV),5,"0")
		
		//[4] - Tipo do codigo do Produto 11-13
		clTexto += "EN "

		//[5] - Codigo do Produto 14-27                                                                                           
		clTexto += SubStr(PadR(ITMNF->B1_CODBAR,14),1,14)

		//[6] - Referencia do Produto 28-47
		clTexto += PadR(AllTrim(""),20)

		//[7] - Unidade de Medida 48-50
		clTexto += SubStr(PadR(KzConvUM(ITMNF->B1_UM),3," "),1,3)

		//[8] - Numero Unidades Consumo na Embalagem 51-55
		clTexto += PadL(AllTrim(Str(Posicione("SA7",1,xFilial("SA7")+avKey(CABNF->F2_CLIENTE,"A7_CLIENTE")+avKey(CABNF->F2_LOJA,"A7_LOJA")+avKey(ITMNF->D2_COD,"A7_PRODUTO"),"A7_UNIEMB"),5,0)),5,"0")

		//[9] - Quantidade 56-70 numerico(15,2)
		//clTexto += PadL(STRZERO(ITMNF->D2_QUANT,15),15,"0")
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_QUANT,"999999999999.99"),".","")),15,"0")

		npQtdFat+= ITMNF->D2_QUANT

		//[10] - Tipo de Embalagem 71-73
		clTexto += "BX "

		//[11] - Valor Bruto Linha Item 74-88 numerico(15,2)
		//clTexto += SubStr(STRZERO(ITMNF->D2_TOTAL,15),1,15)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_TOTAL,"999999999999.99"),".","")),15,"0")

		//[12] - Valor Liquido Linha Item 89-103 numerico(15,2)
		//clTexto += SubStr(STRZERO(ITMNF->D2_TOTAL,15),1,15)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_BASEICM,"999999999999.99"),".","")),15,"0")

		//[13] - Preco Bruto Unitario 104-118 numerico(15,2)
		//clTexto += SubStr(STRZERO(ITMNF->D2_PRCVEN,15),1,15)
		nBrutUnit := ITMNF->D2_PRCVEN
		clTexto += PadL(Alltrim(Replace(Transform(nBrutUnit,"999999999999.99"),".","")),15,"0")

		//[14] - Preco Liquido Unitario 119-133 numerico(15,2)
		//clTexto += SubStr(STRZERO(ITMNF->D2_PRCVEN,15),1,15)
		nLiqUnit := ( ( ITMNF->D2_BASEICM - ITMNF->D2_VALICM - ITMNF->D2_VALIPI ) / ITMNF->D2_QUANT )
		clTexto += PadL(Alltrim(Replace(Transform(nLiqUnit,"999999999999.99"),".","")),15,"0")

		//[15] - Numero do Lote 134-153
		//clTexto += SubStr(Padl(CABNF->ZAE_NUMCLI,20," "),1,20)
		clTexto += PadR(AllTrim(ITMNF->D2_NUMLOTE),20," ")

		//[16] - Numero do pedido do comprador 154-173
		//clTexto += SubStr(Padl(CABNF->ZAE_NUMCLI,20," "),1,20)
		clTexto += PadR(AllTrim(CABNF->ZAE_NUMCLI),20," ")

		//[17] - Peso Bruto do Item 174-188 numerico(15,2)
		//clTexto += SubStr(STRZERO((ITMNF->B1_PESBRU * ITMNF->D2_QUANT),15),1,15)
		//clTexto += PadL(Replace(Alltrim(Str(ITMNF->B1_PESBRU * ITMNF->D2_QUANT)),".",""),15,"0")
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_PESO * ITMNF->D2_QUANT,"999999999999.99"),".","")),15,"0")

		npTPBrut	+= ITMNF->B1_PESBRU * ITMNF->D2_QUANT
		npTPLiq		+= ITMNF->B1_PESO * ITMNF->D2_QUANT
		
		//[18] - Volume Bruto do Item 189-203 numerico(15,2)
		clTexto += PADL("0",15,"0")//SubStr(STRZERO((ITMNF->B1_PESO * ITMNF->D2_QUANT),15),1,15)

		//Codigo de Classifica็ใo Fiscal 204-217
		clTexto += PadR(AllTrim(ITMNF->B1_POSIPI),14)  //Ana Paula solicitou utilizar o NCM - 18.08.2012 - 15.30

		//C๓digo da situa็ใo tributaria 218-222
		clTexto += PadR(AllTrim(ITMNF->D2_CLASFIS),5) //Erich solicitou utilizar a informacao da nota fiscal - ITEM - 18.08.2012 - 15.30

		//C๓digo Fiscal de Opera็๕es e Presta็๕es 223,227 (CFOP)
		clTexto += PadR(AllTrim(ITMNF->D2_CF),5)  //Erich solicitou utilizar a informacao da nota fiscal - ITEM - 18.08.2012 - 15.30

		//[21] - Percentual de Desconto Financeiro 228-232 numerico (5,2)
		clTexto += Replicate("0",5)

		//[22] - Valor de Desconto Financeiro 233-247 numerico(15,2)
		clTexto += Replicate("0",15)

		//[23] - Percentual de Desconto Comercial 248-252 numerico (5,2)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_DESC,"99.99"),".","")),5,"0")

		//[24] - Valor de Desconto Comercial 253-267 numerico(15,2)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_DESCON,"999999999999.99"),".","")),15,"0")

		//[25] - Percentual de Desconto Promocional 268-272 numerico (5,2)
		clTexto += Replicate(" ",5)

		//[26] - Valor de Desconto Promocional 273-287 numerico(15,2)
		clTexto += Replicate(" ",15)

		//[27] - Percentual de Encargos Financeiros 288-292 numerico (5,2)
		clTexto += Replicate(" ",5)

		//[28] - Valor de Encargos Financeiros 293-307 numerico(15,2)
		clTexto += Replicate(" ",15)

		//[29] - Aliquota IPI 308-312 numerico(5,2)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_IPI,"99.99"),".","")),5,"0")
        
		//[30] - Valor Unitario de IPI 313-327numerico(15,2)
		//clTexto += SubStr(STRZERO(nlValIpi,15),1,15)
		nlValIpi := NoRound((ITMNF->D2_PRCVEN * (ITMNF->D2_IPI /100)),2)
		clTexto += PadL(Alltrim(Replace(Transform(nlValIpi,"999999999999.99"),".","")),15,"0")

		//[31] - Aliquota ICMS 328-332 numerico(5,2)
		//clTexto += SubStr(STRZERO(ITMNF->D2_PICM,5),1,5)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_PICM,"99.99"),".","")),5,"0")

		//[32] - Valor de ICMS 333-347numerico(15,2)
		//clTexto += SubStr(STRZERO(ITMNF->D2_VALICM,15),1,15)
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_VALICM,"999999999999.99"),".","")),15,"0")

		//[33] - Aliquota ICMS com SubsTitui็ใo Tributaria 348-352 numerico(5,2)
		clTexto += Replicate("0",5)

		//[34] - Valor de ICMS com SubsTitui็ใo Tributaria 353-367numerico(15,2)
		clTexto += Replicate("0",15)

		//[35] - Aliquota de redu็ใo da Base de ICMS 368-372 numerico(5,2)
		clTexto += Replicate("0",5)
		
		//[36] - Valor de redu็ใo da Base de  ICMS 373-387 numerico(15,2)
		clTexto += Replicate("0",15)

		//[37] - Percentual de Desconto do repasse de ICMS 388-392 numerico(5,2)
		clTexto += Replicate("0",5)

		//[38] - Valor de Desconto do Repasse de ICMS 393-407numerico(15,2)
		clTexto += Replicate("0",15)

/*		//[39] - Percentual de Desconto 388-392 numerico(5,2)
		clTexto += Replicate(" ",5)

		//[40] - Valor de Desconto 393-407 numerico(15,2)
		clTexto += Replicate(" ",15)	

		//[41] - Valor Despesa Acessoria 408-422 numerico(15,2)
		clTexto += Replicate(" ",15)

		//[42] - Valor Despesa Embalagem 423-437 numerico(15,2)
		clTexto += Replicate(" ",15)
*/

		// Codigo NCM EX - 408-409
//		clTexto += Replicate(" ",2)
		clTexto += PadL(AllTrim(ITMNF->B1_EX_NCM),2,"0")

		// Codigo CST PIS - 410-414
		clTexto += PadR(Posicione("SF4",1,xFilial("SF4")+ITMNF->D2_TES,"F4_CSTPIS"),5)

		// Codigo CST Cofins - 415-419
		clTexto += PadR(Posicione("SF4",1,xFilial("SF4")+ITMNF->D2_TES,"F4_CSTCOF"),5)

		// Codigo CST IPI - 420-424
		clTexto += PadR(Posicione("SF4",1,xFilial("SF4")+ITMNF->D2_TES,"F4_CTIPI"),5)

		// Taxa Aliquota PIS - 425-429
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_ALQPIS,"99.99"),".","")),5,"0")

		// Taxa Aliquota Cofins - 430- 434
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->D2_ALQCOF,"99.99"),".","")),5,"0")
		
		// Taxa Aliquota Cofins - 430- 434
		clTexto += PadL(Alltrim(Replace(Transform(ITMNF->B1_PICMRET,"99.99"),".","")),5,"0")

	    clTexto += CRLF
	   	//Grava o texto no arquivo.
	    FWrite(npHandle,clTexto)

	    clTexto := ""
	    npTotLi ++
	    ITMNF->(dbSkip())
	EndDo
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZGrvSum	     บAutor  ณAlfredo A. MagalhใesบData  ณ 27/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de gerar a linha de sumario da nota.					  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ 				  			   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ 			                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZGrvSum()
	
	Local clTexto	:= ""
	Local cVolume 	:= ("CABNF")->F2_VOLUME1	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณRegistro 09 - SUMARIO ( umas unica ocorrencia )ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
    
	//Tipo do registro 0-1
	clTexto := "09"
	
	//Numero de linhas da nota 2-5
	clTexto += SubStr(STRZERO(npTotLi,4),1,4)
	
	//Quantida Total de embalagens 6-20 numerico(15,2)
	clTexto += PadL(Alltrim(Transform(cVolume,"999999999999999")),15,"0")//Padl("0",15,"0")//
	
	//Peso Bruto Total 21-35 numerico(15,2)
	//clTexto += SubStr(STRZERO(npTPBrut,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(npTPBrut,"9999999999999.99"),".","")),15,"0")
	
	//Peso liquido total 36-50 numerico(15,2)
	//clTexto += SubStr(STRZERO(npTPLiq,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(npTPLiq,"9999999999999.99"),".","")),15,"0")
	
	//Cubagem total 51-65 numerico(15,2)
	clTexto += Replicate("0",15)
	
	//Valor total das linhas da Nota 66-80 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_VALBRUT,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_VALBRUT,"9999999999999.99"),".","")),15,"0")
	
	//Valor total de Descontos 81-95 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor total de Encargos 95-110 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor total de Abatimentos 111-125 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor total Frete 126-140 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_FRETE,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_FRETE,"9999999999999.99"),".","")),15,"0")
	
	//Valor total Seguro 141-155 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_SEGURO,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_SEGURO,"9999999999999.99"),".","")),15,"0")
	
	//Valor total Despesas Acessorias 156-170 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor Base de calculo do ICMS 171-185 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_BASEICM,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_BASEICM,"9999999999999.99"),".","")),15,"0")
	
	//Valor total ICMS 186-200 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_VALICM,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_VALICM,"9999999999999.99"),".","")),15,"0")
	
	//Valor Base de Calculo ICMS com Substituicao Tributaria 201-215 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor total de ICMS com Substitui็ใo Tributaria 216-230 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor Base de Calculo do ICMS com redu็ใo tributaria 231-245 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor total de ICMS com Redu็ใo Tributaria 246-260 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor Base de calculo do IPI 261-275 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_BASEIPI,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_BASEIPI,"9999999999999.99"),".","")),15,"0")
	
	//Valor Total de IPI 276-290 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_VALIPI,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_VALIPI,"9999999999999.99"),".","")),15,"0")
	
	//Valor Total da Nota 290-305 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_VALBRUT,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_VALBRUT,"9999999999999.99"),".","")),15,"0")
/*	
	//Valor Base de ICMS Retido na Fonte 306-320 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor Total do ICMS Retido 321-335 numerico(15,2)
	clTexto += Padl("0",15,"0")
	
	//Valor Total de unidades faturadas 336-346 numerico(11,3)
	//clTexto += SubStr(STRZERO(npQtdFat,11),1,11)
	clTexto += PadL(Alltrim(Replace(Transform(npQtdFat,"9999999999.99"),".","")),11,"0")
	
	//Valor de Desconto do ICMS 347-361 numerico(15,2)
	clTexto += Padl("0",15,"0")	
	
	//Valor de Desconto do Pis 362-376 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_VALPIS,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_VALPIS,"9999999999999.99"),".","")),15,"0")
	
	//Valor de Desconto do Cofins 377-391 numerico(15,2)
	//clTexto += SubStr(STRZERO(CABNF->F2_VALCOFI,15),1,15)
	clTexto += PadL(Alltrim(Replace(Transform(CABNF->F2_VALCOFI,"9999999999999.99"),".","")),15,"0")
	
	nlNotas := KzGetNotas(CABNF->D2_PEDIDO)
	//Total de Notas para o pedido 392-397 numerico(6)
	clTexto += SubStr(STRZERO(nlNotas,6),1,6)
 */	
    clTexto += CRLF
   	
   	//Grava o texto no arquivo.
    FWrite(npHandle,clTexto)
    clTexto := ""
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKZConvUM	     บAutor  ณAlfredo A. MagalhใesบData  ณ 30/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para "converter" a unidade de medida do Protheus para	  บฑฑ
ฑฑบ			 ณa unidade de medida da NeoGrid.                              	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclPar - Unidade de medido do Protheus							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณclUm - Unidade de medido da NeoGrid                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZConvUM(clPar)
	
	Local clUm	:= ""
		
	If AllTrim(clPar) $ "UN|JG" 
		clUm := "EA"
	ElseIf AllTrim(clPar) == "G"
		clUm := "GRM"
	ElseIf AllTrim(clPar) == "KG"
		clUm := "KGM"
	ElseIf AllTrim(clPar) == "L"
		clUm := "LTR"
	ElseIf AllTrim(clPar) == "MT"
		clUm := "MTR"
	ElseIf AllTrim(clPar) == "M2"
		clUm := "MTK"
	ElseIf AllTrim(clPar) == "M3"
		clUm := "MTQ"
	ElseIf AllTrim(clPar) == "ML"
		clUm := "MLT"
	ElseIf AllTrim(clPar) == "TL"
		clUm := "TNE"
	ElseIf AllTrim(clPar) == 'PC"
		clUm := "PCE"
	EndIf
	
Return clUm
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณKzGetNotas     บAutor  ณAlfredo A. MagalhใesบData  ณ 30/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para buscar a quantidade de notas que o pedido posiconadoบฑฑ
ฑฑบ			 ณpossui						                             	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclPar - numero do pedido de venda a ser buscado nas notas		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณnlNotas - Quantidade de notas para aquele pedido                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KzGetNotas(cPed)

	Local nlNotas	:= 0
	Local clQuery	:= ""
	
	clQuery := " SELECT D2_DOC, D2_SERIE " + CRLF
	clQuery += " FROM " + RETSQLNAME("SD2") + CRLF
	clQuery += " WHERE	D2_FILIAL = '" + xFilial("SD2") + "' " + CRLF
	clQuery += " 		AND D_E_L_E_T_ <> '*' " + CRLF
	clQuery += " 		AND D2_PEDIDO = '" + cPed + "' " + CRLF
	clQuery += " GROUP BY D2_DOC, D2_SERIE " + CRLF
	
	clQuery := ChangeQuery(clQuery)
	
	If Select("TRBNF") > 0
		TRBNF->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "TRBNF", .F., .F. )
	
	While TRBNF->(!EOF())
		nlNotas ++
		TRBNF->(dbSkip())
	EndDo

	TRBNF->(dbCloseArea())
Return nlNotas
