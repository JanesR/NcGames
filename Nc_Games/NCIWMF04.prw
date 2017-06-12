#Include "PROTHEUS.CH "


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWMF04 ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava os dados na base intermediaria 						  º±±
±±º          ³  													  	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCIWMF04()
	
//Chama a rotina de cincronização com a base intermediária
Processa({|| SincBsInt(Msdate()-15, Msdate()-1) }, "Integração Web Manager", "Sincronização de dados") 

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WMF04JOB  ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WMF04JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
SincBsInt(Msdate()-15,Msdate()-1)
Return

      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SincBsInt ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Sincronização com a base intermediária					  º±±
±±º          ³  													  	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SincBsInt(dDtIni, dDtFin)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= ""
Local nCnt		:= 0
Local cCNPJAux	:= ""
Local aEmpFil	:= {}

Local cDtIniAux	:= ""
Local cDtFinAux	:= ""


Default dDtIni := CtoD("")
Default dDtFin := CtoD("")


cDtIniAux	:= DTOS(dDtIni)
cDtFinAux	:= DTOS(dDtFin)
cDtIniAux 	:= SubStr(cDtIniAux,1,4)+"-"+SubStr(cDtIniAux,5,2)+"-"+SubStr(cDtIniAux,7,2)
cDtFinAux	:= SubStr(cDtFinAux,1,4)+"-"+SubStr(cDtFinAux,5,2)+"-"+SubStr(cDtFinAux,7,2)


//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCIWMF04", "Gravacao dos dados na tabela intermediaria (Web manager x Protheus)", "FINANCEIRO", MsDate() )  


cQuery    := " SELECT IMF.*,  CONVERT(VARCHAR, IMF.DATA_MOVIMENTO, 112) AS DATA_MOVIMENTO_CONV FROM "+u_NCGetBWM("INTEGRACAO_MOVIMENTO_FINANCEIRO")+" IMF  "+CRLF
cQuery    += " WHERE DATA_MOVIMENTO >= '"+cDtIniAux+" 00:00:00' AND DATA_MOVIMENTO <= '"+cDtFinAux+" 23:59:59' "+CRLF
cQuery    += " AND TIPO_OPERACAO NOT IN('CA', 'TRD')  "+CRLF

/*cQuery    := " SELECT IMF.*,  CONVERT(VARCHAR, IMF.DATA_MOVIMENTO, 112) AS DATA_MOVIMENTO_CONV FROM "+u_NCGetBWM("INTEGRACAO_MOVIMENTO_FINANCEIRO")+" IMF  "+CRLF
cQuery    += " WHERE TIPO_OPERACAO NOT IN('CA', 'TRD')  "+CRLF*/


//Executa a query na base de dados do WEB MANAGER
cArqTmp		:= U_NCIWMF02(cQuery)

//Verifica se a conexão foi estabelecida com sucesso
If !Empty(cArqTmp)
	
	(cArqTmp)->( DbGoTop() )
	(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
	(cArqTmp)->( DbGoTop() )
	
	ProcRegua(nCnt)
	
	While (cArqTmp)->(!Eof())
		
		IncProc("Processando...")
		
		
		//Compra de usado (ou produtos para consumo) com dinheiro
		/*If Alltrim((cArqTmp)->TIPO_OPERACAO)+Alltrim(Str((cArqTmp)->COD_FINANCEIRO_TIPO)) == "CDU8"
			(cArqTmp)->(DbSkip())
			Loop		
		EndIf*/
		If Alltrim((cArqTmp)->TIPO_OPERACAO) == "CDU"
			(cArqTmp)->(DbSkip())
			Loop		
		EndIf
		
		
		cCNPJAux	:= U_NCGCNPJSP((cArqTmp)->CNPJ_LOJA)//Retorna o CNPJ sem pontuação
		aEmpFil		:= U_NCGEFORI(cCNPJAux, Alltrim(Str((cArqTmp)->COD_LOJA)))
		
		If Len(aEmpFil) > 0

			//Executa a rotina de gravação dos dados na tabela intermediária
			GrvBsInt((cArqTmp)->TIPO_OPERACAO,;//Operação
						Alltrim(Str((cArqTmp)->COD_MOVIMENTO)),;//Cod.Movimento
						Alltrim(Str((cArqTmp)->COD_TIPO_MOVIMENTACAO)),; //Tipo do Movimento
						(cArqTmp)->DESC_TIPO_MOVIMENTACAO,; //Descrição do movimento
						Alltrim(Str((cArqTmp)->COD_FINANCEIRO_TIPO)),; //Codigo financeiro
						(cArqTmp)->DESC_FINANCEIRO_TIPO,; //Descrição financeira
						Alltrim(Str((cArqTmp)->PARCELA)),; //Parcela
						(cArqTmp)->TOTAL_PARCELA,;//Quantidade de parcela
						Alltrim(Str((cArqTmp)->COD_LOJA)),; //Loja
						aEmpFil[5],; //Nome da filial 
						Alltrim(Str((cArqTmp)->COD_BANCO)),; //Banco
						(cArqTmp)->NOME_BANCO,; //Nome do banco
						(cArqTmp)->AGENCIA,; //Agencia
						(cArqTmp)->CONTA_CORRENTE,; //Conta Corrente
						(cArqTmp)->NUM_DOCUMENTO,; //Nomero do documento
						(cArqTmp)->NUMERO_ECF,; //Numero da ECF
						Alltrim(Str((cArqTmp)->COD_IDENTIFICADOR)),; //Codigo identificador
						STOD((cArqTmp)->DATA_MOVIMENTO_CONV),; // Dt.Movimento
						(cArqTmp)->HORA_CADASTROU,; //Hora do movimento
						STOD((cArqTmp)->DATA_VENCIMENTO),; //Data do movimento
						(cArqTmp)->HORA_VENCIMENTO,; //Hora do movimento
						(cArqTmp)->TOTAL_OPERACAO,; //Total da operação
						(cArqTmp)->VALOR_OPERACAO,;//Valor da operação
						Alltrim(Str((cArqTmp)->SEQUENCIAL)),;//Codigo sequencial
						cCNPJAux,; //Cnpj
						aEmpFil[1],; //Codigo da Empresa
						aEmpFil[2],;	//Filial
						Iif((cArqTmp)->NUMERO_NOTA != 0, Alltrim(Str((cArqTmp)->NUMERO_NOTA)), ""),;//Nota
						Alltrim(Str((cArqTmp)->SERIE_NOTA)),;//Serie
						Alltrim((cArqTmp)->TIPO_OS),;//Tipo da OS
						Iif((cArqTmp)->COD_TIPO_OS != 0, Alltrim(Str((cArqTmp)->COD_TIPO_OS)), ""),;//Codigo d OS
						Alltrim(Str((cArqTmp)->COD_USUARIO_CAIXA)),;//Codigo do usuario do caixa
						Alltrim((cArqTmp)->NOME_USUARIO_CAIXA),;//Nome do usuario do caixa
						Alltrim(Str((cArqTmp)->COD_USUARIO_COMISSAO)),;//Codigo do usuario da comissão
						Alltrim((cArqTmp)->NOME_USUARIO_COMISSAO);//Nome do usuario da comissão
						 )
		
		EndIf

		(cArqTmp)->(DbSkip())
	EndDo

	//Grava o log de processamento
	u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCIWMF04", "Gravacao dos dados na tabela intermediaria (Web manager x Protheus)", "FINANCEIRO", MsDate(), "F" )

    
	//Atualiza o cadastro do tipo financeiro
	//u_NCIWMF09()
	
	//Executa a rotina para gerar os titulos no contas a receber
	u_NCIWMF01()
Else
	If !IsBlind()
		Aviso("Atenção","Não foi possível conectar-se a base de dados do Web Manager",{"Ok"},2)
	EndIf
EndIf

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvBsInt ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Sincronização com a base intermediária					  º±±
±±º          ³  													  	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvBsInt(cOper, cCodMov, cTpMov, cDescTpMov, cCodFin, cDescFin, cQtdParcWM, nTQtdParc,;
							cCodLoja, cNomeLoja, cCodBanco, cNomeBanco, cAgencia, cContaCorr, cNumDoc, cNumECF,;
							cIdent, dDtMovimento, cHoraMovim, dDtVencto, cHoraVencto, nTotOper, nValorOper, cSeq,;
							cCNPJ, cEmpOrigem, cFilOrigem, cNota, cSerie, cTpOs, cCodOs, cCodUsuCx, cNomUsuCx, cCodUsuComis, cNomUsuComis)

Local aArea := GetArea()

Default cOper			:= "" 
Default cCodMov			:= "" 
Default cTpMov			:= "" 
Default cDescTpMov		:= "" 
Default cCodFin			:= "" 
Default cDescFin		:= "" 
Default cQtdParcWM		:= "" 
Default nTQtdParc		:= 0
Default cCodLoja		:= ""
Default cNomeLoja		:= ""
Default cCodBanco		:= "" 
Default cNomeBanco		:= "" 
Default cAgencia		:= "" 
Default cContaCorr		:= "" 
Default cNumDoc			:= "" 
Default cNumECF			:= ""
Default cIdent			:= "" 
Default dDtMovimento	:= CTOD('')
Default cHoraMovim		:= "" 
Default dDtVencto		:= CTOD('') 
Default cHoraVencto		:= "" 
Default nTotOper		:= "" 
Default nValorOper		:= 0
Default cSeq			:= ""
Default cCNPJ			:= ""
Default cEmpOrigem		:= ""
Default cFilOrigem		:= ""
Default cNota			:= "" 
Default cSerie			:= ""
Default cTpOs			:= ""
Default cCodOs			:= ""
Default cCodUsuCx		:= ""
Default cNomUsuCx		:= ""
Default cCodUsuComis	:= ""
Default cNomUsuComis	:= ""

DbSelectArea("PZP")
DbSetOrder(1)

If !PZP->(MsSeek(xFilial("PZP");
					+Padr(cCodMov,TAMSX3("PZP_CODMOV")[1]);
					+Padr(cCodFin,TAMSX3("PZP_CODFIN")[1]);
					+Padr(cQtdParcWM,TAMSX3("PZP_PARCWM")[1]);
					+Padr(cSeq,TAMSX3("PZP_SEQ")[1]);
					+Padr(cCodLoja,TAMSX3("PZP_CODLJ")[1])))
					
	Reclock("PZP",.T.)
	PZP->PZP_FILIAL	:= xFilial("PZP")
	PZP->PZP_OPER   := cOper
	PZP->PZP_CODMOV := cCodMov
	PZP->PZP_TPMOVI := cTpMov
	PZP->PZP_DESTPM	:= cDescTpMov
	PZP->PZP_CODFIN	:= cCodFin
	PZP->PZP_DESCFI	:= cDescFin
	PZP->PZP_PARCWM	:= cQtdParcWM
	PZP->PZP_QTDPAR	:= nTQtdParc
	PZP->PZP_CODLJ  := cCodLoja
	PZP->PZP_NOMELJ	:= cNomeLoja
	PZP->PZP_CODBCO := cCodBanco
	PZP->PZP_NOMBCO := cNomeBanco
	PZP->PZP_AGENCI := cAgencia
	PZP->PZP_CTACOR	:= cContaCorr
	PZP->PZP_NUMDOC	:= cNumDoc
	PZP->PZP_NUMECF	:= cNumECF
	PZP->PZP_CIDENT	:= cIdent
	PZP->PZP_DTMOVI	:= dDtMovimento
	PZP->PZP_HORAMV	:= cHoraMovim
	PZP->PZP_DTVCTO	:= dDtVencto
	PZP->PZP_HRVCTO	:= cHoraVencto
	PZP->PZP_TOTOPE := nTotOper
	PZP->PZP_VLOPER	:= nValorOper
	PZP->PZP_SEQ	:= cSeq
	PZP->PZP_CNPJ  	:= cCNPJ
	PZP->PZP_EMPORI	:= cEmpOrigem
	PZP->PZP_FILORI := cFilOrigem
	PZP->PZP_NOTA	:= cNota
	PZP->PZP_SERIE	:= cSerie
	PZP->PZP_TPOS  	:= cTpOs
	PZP->PZP_CODOS	:= cCodOs
	PZP->PZP_CODUCX	:= cCodUsuCx
	PZP->PZP_NOMUCX := cNomUsuCx
	PZP->PZP_CODUCO := cCodUsuComis
	PZP->PZP_NOUCOM := cNomUsuComis	
	PZP->(MsUnLock())
EndIf


RestArea(aArea)
Return