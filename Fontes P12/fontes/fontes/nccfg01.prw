#include "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao³ NfeMsg        ³ Por: Adalberto Moreno Batista    ³ Data ³            ³±±
±±ÃÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Retorna mensagens configuradas para a geracao do XML e impressao ³±±
±±³          ³ do DANFE.                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function nfeMsg(cTipo)

Local _aAreaItem
Local _cNFD									//variavel auxiliar na montagem das notas fiscais de devolucao na variavel _cnfdevol
Local _aiMSG			:= {}				//multidimensional {1o.elemento cod.formula, 2o.elemento texto da mensagem}
Local _aSD1MSG			:= {}
Local _ciTIPONF			:= " "
Local _ciNFCompl		:= " "				//variavel para armazenar numero / serie e data de notas complementares
Local _ciNFDevol		:= " "				//armazena numero/serie e data da nota original
Local _aiNFDevol		:= {0,0,0,0}		//armazena Vl.ICMS, Base ST, Val.ICMR e Val.IPI da nota original em notas de devolucao
Local _cObs				:= ""
Local _aiPEDCLI			:= {}
Local _aiPEDEMP			:= {}
Local _aiVEND			:= {}
Local _cEntrega			:= ""
Local _cMsgST			:= ""
Local _cCrosDock		:= ""
Local _cPvTran			:= ""
Local _nK
Local aStDifPR	:= { 0, 0 }

Local aArea		:= GetArea()
Local aAreaSA1	:= SD2->(GetArea())
Local aAreaSD2	:= SD2->(GetArea())
Local aAreaSD1	:= SD1->(GetArea())
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaSC6	:= SC6->(GetArea())
Local aAreaSD1	:= SD1->(GetArea())
Local aAreaSD2	:= SD2->(GetArea())
Local aAreaSF4	:= SF4->(GetArea())

//Setando as ordens das tabelas a serem utilizadas na nota fiscal
dbselectarea("SA1")
dbSetOrder(1)
dbselectarea("SC5")
dbSetOrder(1)
dbselectarea("SC6")
dbSetOrder(1)
dbselectarea("SD1")
dbsetorder(1)
dbselectarea("SD2")
dbsetorder(3)
dbSelectArea("SF4")
dbSetOrder(1)
dbSelectArea("SZ1")
dbSetOrder(1)

if  cTipo == "1"
	
	_ciTIPONF		:= SF2->F2_TIPO
	
	//endereco de entrega
	//retirado tratamento em 28/01/2014 - conforme reunião com depto fiscal, comercial e logística
/*	if _ciTIPONF $ "N"
		if SA1->(dbSeek(xFilial("SA1")+SF2->(F2_CLIENTE+F2_LOJA)))
			_cEntrega := Alltrim(SA1->A1_ENDENT)+" "+Alltrim(SA1->A1_BAIRROE)+" "+Alltrim(SA1->A1_CEPE)+" "+Alltrim(SA1->A1_MUNE)+" "+SA1->A1_ESTE
		endif
	endif*/
	
	//dados dos itens da nota
	dbSelectArea("SD2")
	if dbSeek(xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA))
		
		
		do while SD2->(!eof() .and. D2_FILIAL == xFilial("SD2") .and.;
			D2_DOC == SF2->F2_DOC .and.;
			D2_SERIE == SF2->F2_SERIE .and.;
			D2_CLIENTE == SF2->F2_CLIENTE .and.;
			D2_LOJA == SF2->F2_LOJA)
			
			SC5->(dbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			SC6->(dbSeek(xFilial("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV))
			SF4->(dbSeek(xFilial("SF4")+SD2->D2_TES))
			SZ1->(dbSeek(xFilial("SZ1")+SF2->(F2_DOC+F2_SERIE)))
			SB1->(dbSeek(xFilial("SB1")+SD2->D2_COD))
			
			_cCrosDock	:= SC5->C5_YCHCROS
			_cPvTran	:= SC5->C5_YTRANS
			
			//numeros de pedidos Empresa
			cPEDEMP	:= SC5->C5_NUM
			cNumRom	:= alltrim(TRANSFORM(SZ1->Z1_ROMANEI, "@E 9,999,999,999"))
			If !Empty(cNumRom)
				cPEDEMP	:= cPEDEMP+" - Romaneio: "+cNumRom
			EndIf
			if aScan(_aiPEDEMP,cPEDEMP)=0
				
				aAdd(_aiPEDEMP,cPEDEMP)
				
				//dados das mensagens da nota
				if !empty(SC5->C5_MENNOTA)
					aAdd(_aiMSG, {" ",SC5->C5_MENNOTA} )	//Mensagem digitada
				endif
			endif
			
			if aScan(_aiMSG,{ |x| x[1]=SC5->C5_MENPAD }) = 0 .and. !empty(SC5->C5_MENPAD)
				aAdd(_aiMSG,{ SC5->C5_MENPAD, Formula(SC5->C5_MENPAD) })	//Mensagem Padrao
			endif
			
			//numeros de pedidos Cliente
			if aScan(_aiPEDCLI,SC5->C5_PEDCLI)=0 .and. !empty(SC5->C5_PEDCLI)
				aAdd(_aiPEDCLI,SC5->C5_PEDCLI)
			endif
			
			//codigo de vendedores (somente o vendedor1)
			if aScan(_aiVEND,SC5->C5_VEND1)=0 .and. !empty(SC5->C5_VEND1)
				aAdd(_aiVEND,SC5->C5_VEND1)
			endif
			
			//Mensagens nos TES
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG1 }) = 0 .and. !empty(SF4->F4_X_MSG1)
				aAdd(_aiMSG,{ SF4->F4_X_MSG1, Formula(SF4->F4_X_MSG1) })	//Mensagem Padrao no TES
			endif
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG2 }) = 0 .and. !empty(SF4->F4_X_MSG2)
				aAdd(_aiMSG,{ SF4->F4_X_MSG2, Formula(SF4->F4_X_MSG2) })	//Mensagem Padrao no TES
			endif
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG3 }) = 0 .and. !empty(SF4->F4_X_MSG3)
				aAdd(_aiMSG,{ SF4->F4_X_MSG3, Formula(SF4->F4_X_MSG3) })	//Mensagem Padrao no TES
			endif
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG4 }) = 0 .and. !empty(SF4->F4_X_MSG4)
				aAdd(_aiMSG,{ SF4->F4_X_MSG4, Formula(SF4->F4_X_MSG4) })	//Mensagem Padrao no TES
			endif
			
			//armazenando em _ciNFDevol as notas fiscais, series e dt.emissao originais
			if !empty(SD2->D2_NFORI) .and. SD2->D2_TIPO$"BD"
				
				SD1->(dbSeek(xFilial("SD1")+SD2->(D2_NFORI+D2_SERIORI+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEMORI)))
				_cNFD = AllTrim(SD2->D2_NFORI)+"/"+AllTrim(SD2->D2_SERIORI)+" de "+dtoc(SD1->D1_EMISSAO)
				//Pergunta para nao repetir mesma nota/serie/data
				if !_cNFD $ _ciNFDevol
					_ciNFDevol += iif(empty(_ciNFDevol),"",", ")+_cNFD
				endif
				
				//Alimentando array de notas de devolucao para destaque de ICMR e Base
				_aiNFDevol[1] += SD2->D2_VALICM		//NoRound(_nProp*SD1->D1_VALICM)	//[1] - Valor do ICMS (proporcional)
				_aiNFDevol[2] += SD2->D2_BRICMS		//NoRound(_nProp*SD1->D1_BRICMS)	//[2] - Base do ICMR (proporcional)
				_aiNFDevol[3] += SD2->D2_ICMSRET	//NoRound(_nProp*SD1->D1_ICMSRET)	//[3] - Valor do ICMR (proporcional)
				_aiNFDevol[4] += SD2->D2_VALIPI		//NoRound(_nProp*SD1->D1_VALIPI)	//[4] - Valor do IPI (proporcional)
				
			endif
			
			//armazenando em _ciNFCompl as notas fiscais, series e dt.emissao originais
			if !empty(SD2->D2_NFORI) .and. SD2->D2_TIPO$"CIP"
				_aAreaItem := SD2->(GetArea())
				_cNFD = AllTrim(SD2->D2_NFORI)+"/"+AllTrim(SD2->D2_SERIORI)+" de "+dtoc(GetAdvFVal("SD2","D2_EMISSAO",xFilial("SD2")+SD2->(D2_NFORI+D2_SERIORI+D2_CLIENTE+D2_LOJA),3))
				SD2->(RestArea(_aAreaItem))
				
				//Pergunta para nao repetir mesma nota/serie/data
				if !_cNFD $ _ciNFCompl
					_ciNFCompl += iif(Empty(_ciNFCompl),"",", ")+_cNFD
				endif
			endif
			
			// MENSAGEM AUTOMÁTICA PARA ICMS-ST  
			IF !SD2->D2_TIPO $ "DB"
				cUFmsg	:= SA1->A1_EST
				cMensST	:= getadvfval("SZ6","Z6_MENSAGE",XFILIAL("SZ6")+SB1->B1_GRTRIB+cUFmsg,1,"")
				If !Empty(cMensST) .And. !AllTrim(cMensST) $ _cMsgST .AND. SUBSTR(SD2->D2_CLASFIS,2,1) $ "1/3"
					If Len(_cMsgST) > 0 .And. SubStr(_cMsgST, Len(_cMsgST), 1) <> " "
						_cMsgST += " "
					EndIf
					_cMsgST += AllTrim(cMensST)
				EndIf
			EndIf
			
			// MENSAGEM AUTOMÁTICA PARA ICMS-ST COM CONSULTA DOS ESTADOS DE SP E RJ
			IF !SD2->D2_TIPO $ "DB" .AND. ALLTRIM(SB1->B1_POSIPI) == "85234990"
				cUFmsg	:= SA1->A1_EST
				cMensST	:= if(cUFmsg == "SP",FORMULA("040"),if(cUFmsg == "RJ",FORMULA("041"),""))
				If !Empty(cMensST) .And. !AllTrim(cMensST) $ _cMsgST .AND. !SUBSTR(SD2->D2_CLASFIS,2,1) $ "1/3"
					If Len(_cMsgST) > 0 .And. SubStr(_cMsgST, Len(_cMsgST), 1) <> " "
						_cMsgST += " "
					EndIf
					_cMsgST += AllTrim(cMensST)
				EndIf
			EndIf
			
			// 13/10/12 - Almir Bandina - DBM SYSTEM LTDA
			// Avalia se é necessário efetuar a impressão da mensagem de ICMS-ST diferenciado entre SP e PR
			cUfDest	:= Posicione("SA1",1,xFilial("SA1")+SF2->F2_CLIENT+SF2->F2_LOJENT,"A1_EST") //incluido tratamento para buscar a UF do cliente destino - 20/01/2014
			If SD2->D2_YSPFIS <> 0 .and. cUfDest == "PR"//SA1->A1_EST == "PR"
				aStDifPR[1]	+= SD2->D2_YSPFIS
				aStDifPR[2]	+= SD2->D2_TOTAL-SD2->D2_YSPFIS
			EndIf
			//
			
			
			dbSelectArea("SD2")
			dbSkip()
		enddo
		
	endif
	
else
	
	_ciTIPONF		:= SF1->F1_TIPO
	
	if !empty(SF1->F1_X_MSG)
		aAdd(_aiMSG,{ '', SF1->F1_X_MSG })
	endif
	
	//dados dos itens da nota
	if SD1->(dbSeek(xFilial("SD1")+SF1->(F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)))
		
		
		do while SD1->(!eof() .and. D1_FILIAL == xFilial("SD1") .and.;
			D1_DOC == SF1->F1_DOC .and.;
			D1_SERIE == SF1->F1_SERIE .and.;
			D1_FORNECE == SF1->F1_FORNECE .and.;
			D1_LOJA == SF1->F1_LOJA)
			
			//buscando mensagens no cadastro de TES
			SF4->(dbSeek(xFilial("SF4")+SD1->D1_TES))
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG1 }) = 0 .and. !empty(SF4->F4_X_MSG1)
				aAdd(_aiMSG,{ SF4->F4_X_MSG1, Formula(SF4->F4_X_MSG1) })	//Mensagem Padrao no TES
			endif
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG2 }) = 0 .and. !empty(SF4->F4_X_MSG2)
				aAdd(_aiMSG,{ SF4->F4_X_MSG2, Formula(SF4->F4_X_MSG2) })	//Mensagem Padrao no TES
			endif
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG3 }) = 0 .and. !empty(SF4->F4_X_MSG3)
				aAdd(_aiMSG,{ SF4->F4_X_MSG3, Formula(SF4->F4_X_MSG3) })	//Mensagem Padrao no TES
			endif
			if aScan(_aiMSG,{ |x| x[1]=SF4->F4_X_MSG4 }) = 0 .and. !empty(SF4->F4_X_MSG4)
				aAdd(_aiMSG,{ SF4->F4_X_MSG4, Formula(SF4->F4_X_MSG4) })	//Mensagem Padrao no TES
			endif
			
			//armazenando em _ciNFDevol as notas fiscais, series e dt.emissao originais
			if !empty(SD1->D1_NFORI) .and. SD1->D1_TIPO$"BD"
				
				SD2->(dbSeek(xFilial("SD2")+SD1->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEMORI)))
				_cNFD = AllTrim(SD1->D1_NFORI)+"/"+AllTrim(SD1->D1_SERIORI)+" de "+dtoc(SD2->D2_EMISSAO)
				//Pergunta para nao repetir mesma nota/serie/data
				if !_cNFD $ _ciNFDevol
					_ciNFDevol += _cNFD+", "
				endif
				
				//Alimentando array de notas de devolucao para destaque de ICMR e Base
				_aiNFDevol[1] += SD1->D1_VALICM		//NoRound(_nProp*SD2->D2_VALICM)			//[1] - Valor do ICMS (proporcional)
				_aiNFDevol[2] += SD1->D1_BRICMS		//NoRound(_nProp*SD2->D2_BRICMS)			//[2] - Base do ICMR (proporcional)
				_aiNFDevol[3] += SD1->D1_ICMSRET	//NoRound(_nProp*SD2->D2_ICMSRET)			//[3] - Valor do ICMR (proporcional)
				_aiNFDevol[4] += SD1->D1_VALIPI		//NoRound(_nProp*SD2->D2_VALIPI)			//[4] - Valor do IPI (proporcional)
				
			endif
			
			//armazenando em _ciNFCompl as notas fiscais, series e dt.emissao originais
			if !empty(SD1->D1_NFORI) .and. SD1->D1_TIPO$"CIP"
				_aAreaItem := SD1->(GetArea())
				_cNFD = AllTrim(SD1->D1_NFORI)+"/"+AllTrim(SD1->D1_SERIORI)+" de "+dtoc(GetAdvFVal("SD1","D1_EMISSAO",xFilial("SD1")+SD1->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA),1))
				SD1->(RestArea(_aAreaItem))
				
				//Pergunta para nao repetir mesma nota/serie/data
				if !_cNFD $ _ciNFCompl
					_ciNFCompl += _cNFD+", "
				endif
			endif
			
			If SD1->D1_TIPO $ "DBN"
				dbSelectArea("SD2")
				dbSetOrder(3)
				IF SD1->D1_ORIGLAN =="LO"
					cMsSeek	:=(xFilial("SD2")+SD1->(D1_NFORI+D1_SERIORI))
				ELSE
					cMsSeek	:=(xFilial("SD2")+SD1->(D1_NFORI+D1_SERIORI+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEMORI))
				EndIF
				
				IF MsSeek (cMsSeek)
					// 13/10/12 - Almir Bandina - DBM SYSTEM LTDA
					// Avalia se é necessário efetuar a impressão da mensagem de ICMS-ST diferenciado entre SP e PR
					If SD2->D2_YSPFIS <> 0 .and. SF1->F1_EST == "PR"
						aStDifPR[1]	+= Round( SD1->D1_QUANT * GetAdvFVal( "SB1", "B1_YVLMID", xFilial( "SB1" ) + SD1->D1_COD, 1, "" ), TAMSX3( "D1_BRICMS" )[2] )
						aStDifPR[2]	+= SD1->D1_TOTAL-aStDifPR[1]
					EndIf
					//
				EndIf
			EndIf
			
			SD1->(dbSkip())
		enddo
		
	endif
	
endif

//Mensagens para notas complementares
if _ciTIPONF = "C"
	_cObs += "Complemento de PRECO destacado a menor em N.NF/Serie "+_ciNFCompl
elseif _ciTIPONF = "I"
	_cObs += "Complemento de ICMS destacado a menor em N.NF/Serie "+_ciNFCompl
elseif _ciTIPONF = "P"
	_cObs += "Complemento de IPI destacado a menor em N.NF/Serie "+_ciNFCompl
endif

//endereco de entrega
/*
if !empty(_cEntrega)
	_cObs += "End.Entrega: "+_cEntrega
endif
*/
//Montando observacoes da nota fiscal
for _i := 1 to Len(_aiMSG)
	if !empty(AllTrim(_aiMSG[_i,2]))
		_cObs += iif(empty(_cObs),"","  /*/  ")+AllTrim(_aiMSG[_i,2])
	endif
next

//Mensagens especificas para DEVOLUCAO
if _ciTIPONF $ "BD"
	if !empty(_ciNFDevol)
		_cObs += iif(empty(_cObs),"","  /*/  ")+"Devol. Ref. S/NF "+_ciNFDevol
	endif
	if _aiNFDevol[2] > 0
		_cObs += iif(empty(_cObs),"","  /*/  ")+"ICMS Destacado: "+AllTrim(Transf(_aiNFDevol[1],"@E 999,999,999.99"))
		_cObs += iif(empty(_cObs),"","  /*/  ")+"Base ICMS ST: "+AllTrim(Transf(_aiNFDevol[2],"@E 999,999,999.99"))
		_cObs += iif(empty(_cObs),"","  /*/  ")+"Valor ICMS ST: "+AllTrim(Transf(_aiNFDevol[3],"@E 999,999,999.99"))
	endif
	if _aiNFDevol[4] > 0
		_cObs += iif(empty(_cObs),"","  /*/  ")+"Valor IPI: "+AllTrim(Transf(_aiNFDevol[4],"@E 999,999,999.99"))
	endif
endif

//Montando observacoes de pedidos NC (SC5)
if len(_aiPEDEMP) > 0
	//Pedidos da empresa
	_cObs += iif(empty(_cObs),"","  /*/  ")+"Pedido NC: "
	for nK := 1 to Len(_aiPEDEMP)
		if !empty(AllTrim(_aiPEDEMP[nK]))
			_cObs += AllTrim(_aiPEDEMP[nK])+", " //+"/PARTE:0"+ALLTRIM(POSICIONE("SC9",6,XFILIAL("SC9")+SF2->F2_SERIE+SF2->F2_DOC,"C9_SEQCAR"))+", "
		endif
	next
endif

//Montando observacoes de pedidos do cliente (SC5)
if len(_aiPEDCLI) > 0
	_cObs += iif(empty(_cObs),"","  /*/  ")+"Seu Pedido: "
	for nK := 1 to Len(_aiPEDCLI)
		if !empty(AllTrim(_aiPEDCLI[nK]))
			_cObs += AllTrim(_aiPEDCLI[nK])+", "
		endif
	next
endif

//Montando observacoes dos vendedores (SC5)
if len(_aiVEND) > 0
	_cObs += iif(empty(_cObs),"","  /*/  ")+"Vendedor: "
	for nK := 1 to Len(_aiVEND)
		if !empty(AllTrim(_aiVEND[nK]))
			_cObs += AllTrim(_aiVEND[nK])+", "
		endif
	next
endif

// 13/10/12 - Almir Bandina - DBM SYSTEM LTDA
// Tratamento para ICMS-ST Diferenciado - Entre SP e PR
If ( aStDifPR[1] + aStDifPR[2] ) <> 0
	If Len( _cObs ) > 0 .And. SubStr( _cObs, Len( _cObs ), 1) <> " "
		_cObs += " "
	EndIf
	_cObs	+= "Software - Isento de ICM Conforme Art.130-Anexo I-RICMS/PR-NF Emitida conf.Solução de Consulta 47/2012"
	_cObs	+= " Valor Suporte Fisico R$ " + AllTrim( Transform( aStDifPR[1], "@E 999,999,999,999.99" ) )
	_cObs	+= " Valor Software R$ " + AllTrim( Transform( aStDifPR[2], "@E 999,999,999,999.99" ) ) + "."
EndIf
//
If !Empty(_cMsgST)
	_cObs += _cMsgST
endif

If alltrim(_cPvTran) $ "1/S"
	_cObs+= " Pedido de Venda da Filial: "+ _cCrosDock
EndIf



RestArea(aAreaSA1)
RestArea(aAreaSD2)
RestArea(aAreaSD1)
RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aAreaSD1)
RestArea(aAreaSD2)
RestArea(aAreaSF4)
RestArea(aArea)

Return(_cObs)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao³ AMBSX1         ³ Por: Adalberto Moreno Batista     ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AMBSX1(aRegs,aCampo)
Local _aArea := GetArea()
Local i, j

dbSelectArea("SX1")
dbSetOrder(1)

For I := 01 to Len(aRegs)
	If !dbSeek(aRegs[i,1]+aRegs[i,2])
		RecLock("SX1",.T.)
		For J := 1 to len(aCampo)
			FieldPut(FieldPos(aCampo[j]),aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aArea)
Return()
