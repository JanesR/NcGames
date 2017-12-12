#Include "PROTHEUS.CH "
//('02','03','04','15')
//02==>3003
//03==>3004
//04==>3005
//15==>3064

User Function L01TST()
	U_WML01JOB()
Return

User Function WMLFJOBS()

StartJob( "U_WML01JOB",GetEnvServer(), .T.)
StartJob( "U_WML01CUPOM",GetEnvServer(), .T.)
StartJob( "U_WML01JCCF",GetEnvServer(), .T.)

StartJob( "U_WML01REDZ",GetEnvServer(), .T.)

StartJob( "U_WML02JOB",GetEnvServer(), .T.)
StartJob( "U_WML03JOB",GetEnvServer(), .T.)

StartJob( "U_WML04JOB" ,GetEnvServer(), .T.)
StartJob( "U_WML05JOB" ,GetEnvServer(), .T.)
StartJob( "U_WML06JOB" ,GetEnvServer(), .T.)


//WLJOBTABINT()//Tabelas Intermediarias
//WLJOBSENTRA()//Operacoes TRD(Troca Devolucao)-CDU(Compra de Usado)-TLS(Transferencia Saida)-TLE(Transferencia Entrada)-DV(Devolucao)
//WLJOBSCUPOM()//Operacoes de VE(Venda)-TRV(Troca Venda)-CA(Cancelamento)


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML01JOB(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
U_NCIWML01()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01 บAutor  ณMicrosiga 	          บ Data ณ 07/04/15  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados na base intermediaria (Processo Fiscal)	     บฑฑ
ฑฑบ          ณ  													  	                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWML01()
Local dData:=Stod('20171211')

//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML01JOB", "Preenchimento das tabelas intermediarias PZQ e PZR(Movimento Loja)", "FISCAL", MsDate() )

//Chama a rotina de cincroniza็ใo com a base intermediแria
//Processa({|| SincBsInt(dData-1,dData-1) }, "Integra็ใo Web Manager (Fiscal)", "Sincroniza็ใo de dados")
//Processa({|| SincBsInt(dData,dData) }, "Integra็ใo Web Manager (Fiscal)", "Sincroniza็ใo de dados")
//Processa({|| SincBsInt(Msdate()-15, dData) }, "Integra็ใo Web Manager (Fiscal)", "Sincroniza็ใo de dados")
Processa({|| SincBsInt(dData-3, dData) }, "Integra็ใo Web Manager (Fiscal)", "Sincroniza็ใo de dados")


//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_WML01JOB", "Preenchimento das tabelas intermediarias PZQ e PZR(Movimento Loja)", "FISCAL", MsDate(), "F" )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSincBsInt บAutor  ณMicrosiga 	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSincroniza็ใo com a base intermediแria					  บฑฑ
ฑฑบ          ณ  													  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SincBsInt(dDtIni, dDtFin)
Local aArea 	:= GetArea()
Local cMensagem:=""
Local cQuery    := ""
Local cArqTmp	:= ""
Local nCnt		:= 0
Local cCNPJAux	:= ""
Local aEmpFil	:= {}
Local cTotal
Local cCNPJOrig
Local aDadTranf:={"","","",""}
Local lAppend
Local nCodMov
Local dDataEmis
Local nCodLoja
Local aPZQ
Local nLenCodMov	:=TAMSX3("PZR_CODMOV")[1]
Local nLenCodLoj	:=TAMSX3("PZR_CODLOJ")[1]
Local nLenSequen	:=TAMSX3("PZR_SEQ")[1]
Local cLojaAux		:= ""
Local aEmpFilExc 	:= {}	
Local dDtaCorte		:=Stod("20170327")

Default dDtIni := CtoD("")
Default dDtFin := CtoD("")

If !GetQuery("MOVIMENTO_FISCAL","CONVERT(VARCHAR, DATA_EMISSAO, 112)  DATAEMISSAO,LF.*","DATAEMISSAO,COD_LOJA,COD_MOVIMENTO",dDtIni,dDtFin,@cArqTmp)
	RestArea(aArea)
	Return
EndIf


Do While (cArqTmp)->(!Eof())
	
	
	dDataEmis:=(cArqTmp)->DATAEMISSAO
	Do While (cArqTmp)->(!Eof()) .And. (cArqTmp)->DATAEMISSAO==dDataEmis
		
		nCodLoja:=(cArqTmp)->COD_LOJA
		cMensagem:=""
		
		Do While (cArqTmp)->(!Eof()) .And. (cArqTmp)->DATAEMISSAO==dDataEmis .And. (cArqTmp)->COD_LOJA==nCodLoja
		         
		
			If nCodLoja==3001 .And. Stod((cArqTmp)->DATAEMISSAO)<dDtaCorte
				(cArqTmp)->(DbSkip());Loop
			EndIf
		
			PZQ->(DbSetOrder(3))//PZQ_FILIAL+PZQ_CODMOV+PZQ_CODLOJ
			cChave:=xFilial("PZQ")+Padr(Alltrim(Str((cArqTmp)->COD_MOVIMENTO)),nLenCodMov)+Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)
			
			If PZQ->(DbSeek(cChave)) 
			
				If !Empty( PZQ->PZQ_DOCPRT) .Or. !Empty(PZQ->PZQ_NUMORC)        //Jแ tem numero de nota ou mumero de cupom fiscal no SL1
					(cArqTmp)->(DbSkip());Loop
				EndIf
					
			EndIf
			
			//Verifica se existe exce็ใo para a loja
			aEmpFilExc := {}
			aEmpFilExc := U_NCWMEXLJ(Alltrim(Str((cArqTmp)->COD_LOJA)), Stod((cArqTmp)->DATAEMISSAO))
			If Len(aEmpFilExc) >= 2       
				If aEmpFilExc[1] .And. Len(aEmpFilExc[2]) == 0
					(cArqTmp)->(DbSkip());Loop
				EndIf
			EndIf
    
		
		
			nCodMov:=(cArqTmp)->COD_MOVIMENTO
			aPZQ:={}
			AADD(aPZQ,Alltrim(Str((cArqTmp)->COD_USUARIO_CAIXA))			)
			AADD(aPZQ,Alltrim((cArqTmp)->NOME_USARIO_CAIXA))
			AADD(aPZQ,Alltrim(Str((cArqTmp)->COD_USUARIO_COMISSAO)))
			AADD(aPZQ,Alltrim((cArqTmp)->NOME_USUARIO_COMISSAO))
			AADD(aPZQ,(cArqTmp)->HORA_ATUALIZACAO)
			AADD(aPZQ,Alltrim(Str((cArqTmp)->COD_LOJA_ORIGEM)))
			AADD(aPZQ,Alltrim(Str((cArqTmp)->COD_LOJA_DESTINO)))
			
			Do While (cArqTmp)->(!Eof()) .And. (cArqTmp)->DATAEMISSAO==dDataEmis .And. (cArqTmp)->COD_LOJA==nCodLoja .And. (cArqTmp)->COD_MOVIMENTO==nCodMov
				cLojaAux		:= ""
				
				//cMensagem:="Processando Movimento ("+Alltrim(Str(nCodMov))+") PZR:"+StrZero(++nCnt,5)+" de "+cTotal+" Emissao:"+STOD((cArqTmp)->DATAEMISSAO)+" Loja:"+Alltrim(Str(nCodLoja))
				cMensagem:="Processando Movimento PZR ("+Alltrim(Str(nCodMov))+") -  Emissao:"+dtoc( Stod((cArqTmp)->DATAEMISSAO))+" Loja:"+Alltrim(Str(nCodLoja))+" Movimentos entre "+Dtoc(dDtIni)+" e "+Dtoc(dDtFin)
				IncProc(cMensagem)
				PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
				
				cCNPJOrig:=(cArqTmp)->CNPJ
				
				aDadTranf:={"","","",""}
				If "TL"$Alltrim((cArqTmp)->TIPO_OPERACAO)
					GetDadTransf(aDadTranf,Alltrim(Str((cArqTmp)->COD_LOJA_ORIGEM)),Alltrim(Str((cArqTmp)->COD_LOJA_DESTINO)))
					cCNPJOrig:=""
					If !Empty(aDadTranf[1])	.And. !Empty(aDadTranf[3])
						cCNPJOrig	:=Iif((cArqTmp)->TIPO_OPERACAO=="TLE" ,(cArqTmp)->CNPJ_DESTINO,(cArqTmp)->CNPJ_ORIGEM)
						cLojaAux  	:= Iif((cArqTmp)->TIPO_OPERACAO=="TLE" ,Alltrim(Str((cArqTmp)->COD_LOJA_ORIGEM)),Alltrim(Str((cArqTmp)->COD_LOJA_DESTINO)))
					Endif
				EndIf 
				
				If Empty(cLojaAux)
					cLojaAux := Alltrim(Str((cArqTmp)->COD_LOJA))
				EndIf
	
				/*If "TL"$Alltrim((cArqTmp)->TIPO_OPERACAO)
					GetDadTransf(aDadTranf,(cArqTmp)->CNPJ_ORIGEM,(cArqTmp)->CNPJ_DESTINO)  
					cCNPJOrig:=""
					If !Empty(aDadTranf[1])	.And. !Empty(aDadTranf[3])
						cCNPJOrig:=Iif((cArqTmp)->TIPO_OPERACAO=="TLE" ,(cArqTmp)->CNPJ_DESTINO,(cArqTmp)->CNPJ_ORIGEM)
					Endif
				EndIf*/
	
				
				cCNPJAux	:= U_NCGCNPJSP(cCNPJOrig)//Retorna o CNPJ sem pontua็ใo
				//aEmpFil	:= U_NCGEFORI(cCNPJAux,Alltrim(Str((cArqTmp)->COD_LOJA)))//Retorna a Empresa e Filial de origem
				aEmpFil		:= U_NCGEFORI(cCNPJAux,cLojaAux )//Retorna a Empresa e Filial de origem
				
				If Empty(aEmpFil)
					(cArqTmp)->(DbSkip());Loop
				EndIf

				//Verifica se existe exce็ใo para a loja
				aEmpFilExc := {}
				aEmpFilExc := U_NCWMEXLJ(Alltrim(Str((cArqTmp)->COD_LOJA)), Stod((cArqTmp)->DATAEMISSAO))
				
				If Len(aEmpFilExc) >= 2       
					If aEmpFilExc[1] .And. Len(aEmpFilExc[2]) == 0
						(cArqTmp)->(DbSkip());Loop
					
					ElseIf aEmpFilExc[1] .And. Len(aEmpFilExc[2]) != 0
						aEmpFil := aEmpFilExc[2]
					EndIf
				EndIf
				                
				
				PZR->(DbSetOrder(3))//PZR_FILIAL+PZR_CODMOV+PZR_CODLOJ+PZR_SEQ
				
				cChave:=xFilial("PZR")+Padr(Alltrim(Str((cArqTmp)->COD_MOVIMENTO)),nLenCodMov)+Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)+Padr(Alltrim(Str((cArqTmp)->SEQUENCIAL)),nLenSequen)
				lAppend:=.T.
				If PZR->(MsSeek(cChave))
					lAppend:=.F.
				ElseIf "TL"$Alltrim((cArqTmp)->TIPO_OPERACAO) .And.  Alltrim((cArqTmp)->STATUS_TRANSFERENCIA)=="E"
					(cArqTmp)->(DbSkip());Loop
				EndIf
				
				Reclock("PZR",lAppend)
				
				PZR->PZR_FILIAL := xFilial("PZR")//Filial
				PZR->PZR_OPER   := Alltrim((cArqTmp)->TIPO_OPERACAO) // Opera็ใo (VE, TRV, TRD, DV, CA , CDU, OS , TL )
				PZR->PZR_TPOPER := ""//E=Entrada e S=Saida
				PZR->PZR_CODMOV := Alltrim(Str((cArqTmp)->COD_MOVIMENTO)) //Codigo do movimento no sistema WM
				PZR->PZR_SEQ    := Alltrim(Str((cArqTmp)->SEQUENCIAL))//Sequencia dos itens
				PZR->PZR_ORICOM := Alltrim(Str((cArqTmp)->COD_ORIGEM_COMPRA))// Origem da Compra
				PZR->PZR_ORIVEN := Alltrim(Str((cArqTmp)->COD_ORIGEM_VENDA)) // Origem da venda
				PZR->PZR_CODOS  := Alltrim(Str((cArqTmp)->COD_ORDEM_SERVICO_TIPO)) //Codigo da Ordem de Servi็o
				PZR->PZR_DESCOS := Alltrim((cArqTmp)->DESC_ORDEM_SERVICO_TIPO) // Descri็ใo da OS
				PZR->PZR_LJORIG := Alltrim(Str((cArqTmp)->COD_LOJA_ORIGEM)) //Loja de Origem (No caso de transferencia)
				PZR->PZR_LJDEST := Alltrim(Str((cArqTmp)->COD_LOJA_DESTINO)) //Loja de Destino (No caso de transferencia)
				PZR->PZR_CODLOJ := Alltrim(Str((cArqTmp)->COD_LOJA)) //Codigo da loja
				PZR->PZR_CNPJ   := Alltrim(cCNPJAux) // CNPJ da Loja
				PZR->PZR_NUMECF := Alltrim(Str((cArqTmp)->NUMERO_ECF)) //Numero ECF
				PZR->PZR_REDUCZ := Alltrim(Str((cArqTmp)->CRZ)) //Numero da redu็ใo Z
				PZR->PZR_DOC    := Alltrim(Str((cArqTmp)->NUMERO_NOTA)) //Nota Fiscal WM
				PZR->PZR_SERIE  := Alltrim(Str((cArqTmp)->SERIE_NOTA)) // Serie da nota fiscal
				PZR->PZR_EMISSA := Stod((cArqTmp)->DATAEMISSAO) //Data de Emissใo WM
				PZR->PZR_CFOP   := Alltrim((cArqTmp)->CFOP)  //CFOP
				PZR->PZR_CST    := Alltrim((cArqTmp)->COD_CST)
				PZR->PZR_CUPMOD := Alltrim((cArqTmp)->COD_MODELO)//Modelo do cupom
				PZR->PZR_CODSF  := Alltrim((cArqTmp)->COD_SITUACAO_FISCAL) //Codigo da Situa็ใo Fiscal
				PZR->PZR_MODECF := Alltrim((cArqTmp)->MODELO_EQUIPAMENTO_ECF) //Modelo da impressora ECF
				PZR->PZR_SERECF := Alltrim((cArqTmp)->NUMERO_SERIE_ECF) //Serie da Impressora ECF
				PZR->PZR_TERMIN := Alltrim((cArqTmp)->NUMERO_TERMINAL) //Terminal				
				PZR->PZR_CHVACE := Alltrim(Str((cArqTmp)->CHAVE_ACESSO))
				PZR->PZR_CPFNF  := U_NCGCNPJSP((cArqTmp)->CPF_NOTAFISCAL) //CPF na nota fiscal
				PZR->PZR_CPFCGC := U_NCGCNPJSP((cArqTmp)->CPF_CNPJ_CLIENTE) //CPF ou CNPJ no cadastro do cliente
				PZR->PZR_TPCLI  := Alltrim((cArqTmp)->TIPO_CLIENTE) // Tipo de Cliente - J=Juridica ou F=Fisica
				PZR->PZR_IE     := Alltrim((cArqTmp)->INS_ESTADUAL) //Inscri็ใo Estadual
				PZR->PZR_NOMCLI := Alltrim((cArqTmp)->NOME) //Nome do cliente
				PZR->PZR_ENDCLI := Alltrim((cArqTmp)->ENDERECO) //Endere็o do cliente
				PZR->PZR_NUMEND := Alltrim((cArqTmp)->NUMERO) //Numero do endere็o
				PZR->PZR_COMPLE := Alltrim((cArqTmp)->COMPLEMENTO) //Complemento do endere็o
				PZR->PZR_CEP    := Alltrim((cArqTmp)->CEP) // CEP
				PZR->PZR_BAIRRO := Alltrim((cArqTmp)->BAIRRO) //Bairro
				PZR->PZR_CIDADE := Alltrim((cArqTmp)->CIDADE) // Cidade
				PZR->PZR_UF     := Alltrim((cArqTmp)->ESTADO) // Unidade Federativa
				PZR->PZR_EMAIL  := Alltrim((cArqTmp)->EMAIL) //E-mail do cliente
				PZR->PZR_CEL    := Alltrim((cArqTmp)->CELULAR) //Celular
				PZR->PZR_TEL    := Alltrim((cArqTmp)->TELEFONE) // Telefone
				PZR->PZR_ECFICM := (cArqTmp)->ECF_ICMS // ICMS cadastrado na ECF
				PZR->PZR_CBARRA := Alltrim((cArqTmp)->COD_BARRA) //Codigo de barras do produto
				PZR->PZR_PRODUT := Alltrim(Str((cArqTmp)->COD_PRODUTO))// Codigo do Produto
				PZR->PZR_QTD    := (cArqTmp)->QUANTIDADE //Quantidade
				PZR->PZR_VALOR  := (cArqTmp)->VALOR //Valor Unitario
				PZR->PZR_TOTAL  := (cArqTmp)->TOTAL //Valor Total
				PZR->PZR_DESCON := (cArqTmp)->DESCONTO // Percentual de desconto
				PZR->PZR_VLDESC := Iif((cArqTmp)->DESCONTO > 0 , (((cArqTmp)->TOTAL * (cArqTmp)->DESCONTO )/100), 0) // Valor de desconto
				PZR->PZR_ALICMS := (cArqTmp)->ICMS //Aliquota do ICMS
				PZR->PZR_VLICMS := (cArqTmp)->VALOR_ICMS //Valor do ICMS
				PZR->PZR_ALPIS  := (cArqTmp)->PIS //Aliquota PIS
				PZR->PZR_VLPIS  := (cArqTmp)->VALOR_PIS // Valor calculado
				PZR->PZR_ALCOFI := (cArqTmp)->COFINS //Aliquota COFINS
				PZR->PZR_VLCOFI := (cArqTmp)->VALOR_COFINS //Valor COFINS
				PZR->PZR_DOCORI := ""//Documento de origem
				PZR->PZR_EMPDES := aEmpFil[1]//Empresa origem Protheus
				PZR->PZR_FILDES := aEmpFil[2]//Filial de origem Protheus
				PZR->PZR_NOMLJ	 := aEmpFil[4]//Nome da loja
				PZR->PZR_EMPOTL := aDadTranf[1]//Empresa Origem Transferencia
				PZR->PZR_FILOTL := aDadTranf[2]//Filial Origem Transferencia
				PZR->PZR_EMPDTL := aDadTranf[3]//Empresa Destino Transferencia
				PZR->PZR_FILDTL := aDadTranf[4]//Filial Destino Transferencia
				                                                                 
				LM01SAT()
				
				PZR->(MsUnLock())
				(cArqTmp)->(DbSkip())
			EndDo
			GrvBsIntCb(Alltrim(Str(nCodMov)),Alltrim(Str(nCodLoja)),aPZQ)//Grava o cabe็alho
		EndDo
	EndDo
EndDo
SincSAT()//Gravacao da nota em caso de SAT - Somente VE,TRV e CA

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvBsIntCb บAutor  ณMicrosiga	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSincroniza็ใo com a base intermediแria (Cabe็alho)		  บฑฑ
ฑฑบ          ณ  													  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvBsIntCb(cCodMov,cCodLoja,aPZQ)
Local aArea  	:= GetArea()
Local nCnt:=0
Local cMensagem:=""
Local cTotal
Local cQuery 	:= ""
Local aDados
Local cArqTmp   := GetNextAlias()

cQuery 	:= "SELECT PZR_CODMOV, PZR_CODLOJ, PZR_CNPJ, PZR_OPER, PZR_TPOPER, PZR_EMPDES, PZR_FILDES, PZR_DOC, PZR_EMISSA, PZR_NOMLJ,PZR_EMPOTL,PZR_FILOTL,PZR_EMPDTL,PZR_FILDTL,SUM(PZR_VALOR) PZR_VALOR FROM "+RetSqlName("PZR")+" PZR "+CRLF
cQuery 	+= " WHERE PZR.PZR_FILIAL = '"+xFilial("PZR")+"' "+CRLF
cQuery 	+= " AND PZR.PZR_CODMOV='"+cCodMov+"'"+CRLF
cQuery 	+= " AND PZR.PZR_CODLOJ='"+cCodLoja+"'"+CRLF
cQuery 	+= " AND PZR.D_E_L_E_T_ = ' ' "+CRLF
cQuery 	+= " GROUP BY PZR_CODMOV, PZR_CODLOJ, PZR_CNPJ, PZR_OPER, PZR_TPOPER, PZR_EMPDES, PZR_FILDES, PZR_DOC, PZR_EMISSA, PZR_NOMLJ,PZR_EMPOTL,PZR_FILOTL,PZR_EMPDTL,PZR_FILDTL "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
TcSetField(cArqTmp,"PZR_EMISSA","D")


Do While (cArqTmp)->(!Eof())
	
	
	
	PZQ->(DbSetOrder(3))//PZQ_FILIAL+PZQ_CODMOV+PZQ_CODLOJ
	cChave:=xFilial("PZQ")+(cArqTmp)->(PZR_CODMOV+PZR_CODLOJ)
	lAppend:=.T.
	If PZQ->(MsSeek(cChave	))
		//(cArqTmp)->(DbSkip());Loop
		lAppend:=.F.
	EndIf
	
	Reclock("PZQ",lAppend)
	PZQ->PZQ_FILIAL := xFilial("PZQ")
	PZQ->PZQ_CODMOV := (cArqTmp)->PZR_CODMOV
	PZQ->PZQ_CODLOJ := (cArqTmp)->PZR_CODLOJ
	PZQ->PZQ_CNPJ   := (cArqTmp)->PZR_CNPJ
	PZQ->PZQ_OPER   := (cArqTmp)->PZR_OPER
	PZQ->PZQ_TPOPER := (cArqTmp)->PZR_TPOPER
	PZQ->PZQ_NOMLJ  := (cArqTmp)->PZR_NOMLJ
	PZQ->PZQ_EMPDES := (cArqTmp)->PZR_EMPDES
	PZQ->PZQ_FILDES := (cArqTmp)->PZR_FILDES
	PZQ->PZQ_DOC    := (cArqTmp)->PZR_DOC
	PZQ->PZQ_EMISSA := (cArqTmp)->PZR_EMISSA
	PZQ->PZQ_TOTAL  := (cArqTmp)->PZR_VALOR
	PZQ->PZQ_EMPOTL := (cArqTmp)->PZR_EMPOTL
	PZQ->PZQ_FILOTL := (cArqTmp)->PZR_FILOTL
	PZQ->PZQ_EMPDTL := (cArqTmp)->PZR_EMPDTL
	PZQ->PZQ_FILDTL := (cArqTmp)->PZR_FILDTL
	PZQ->PZQ_USRCAI := aPZQ[1]
	PZQ->PZQ_NOMCAI := aPZQ[2]
	PZQ->PZQ_USRCOM := aPZQ[3]
	PZQ->PZQ_NOMCOM := aPZQ[4]
	PZQ->PZQ_HORA   := aPZQ[5]
	PZQ->PZQ_LJORIG := aPZQ[6]
	PZQ->PZQ_LJDES  := aPZQ[7]
	
	
	
	
	//PZQ->PZQ_TPOPER := "X"
	PZQ->(MsUnLock())
	(cArqTmp)->(DbSkip())
EndDo
(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  05/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDadTransf(aDadTranf,cLojaOri,cLojaDes)
Local aEmpFil:={"",""}

aEmpFil:=U_NCGEFORI(,U_NCGCNPJSP(cLojaOri))//Retorna a Empresa e Filial de origem

If Empty(aEmpFil)
	aEmpFil:={"",""}
EndIf

aDadTranf[1]:=aEmpFil[1]
aDadTranf[2]:=aEmpFil[2]

aEmpFil:=U_NCGEFORI(,U_NCGCNPJSP(cLojaDes))//Retorna a Empresa e Filial de origem

If Empty(aEmpFil)
	aEmpFil:={"",""}
EndIf

aDadTranf[3]:=aEmpFil[1]
aDadTranf[4]:=aEmpFil[2]

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  06/11/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetQuery(cView,cCampos,cOrderBy,dDtIni,dDtFin,cArqTmp)
Local cQuery:=""


If cView=="MOVIMENTO_FISCAL"
	cQuery    := " SELECT "+cCampos+" FROM "+u_NCGetBWM("INTEGRACAO_MOVIMENTO_FISCAL")+" LF"
	cQuery    += " WHERE DATA_EMISSAO BETWEEN '"+WL01Trans(dDtIni,"D","I")+"' AND '"+WL01Trans(dDtFin,"D","F")+"' "
	//cQuery    += " AND COD_LOJA != '3001' "//Diferente de E-commerce    
	cQuery    += " AND TIPO_OPERACAO<>'OS'"      
	
	//cQuery    += " AND COD_LOJA in('3089','3091','3061') "//Retirar	
	//cQuery    += " AND COD_MOVIMENTO = 38533  " 
	//cQuery    += " AND TIPO_OPERACAO IN ('TLS','TLE')
	//cQuery    += " AND STATUS_TRANSFERENCIA='E'"
	//cQuery    += " AND COD_MOVIMENTO=1173580  "
ElseIf cView=="REDUCAO_Z"
	cQuery    := " SELECT "+cCampos+" FROM "+u_NCGetBWM("INTEGRACAO_REDUCAOZ")
	cQuery    += " WHERE DATA_MOVIMENTO_NUMERICO BETWEEN "+dTOS(dDtIni)+" AND "+dTOS(dDtFin)+" "

ElseIf cView=="INTEGRACAO_LOJASCNPJ"
	cQuery    := " SELECT "+cCampos+" FROM "+u_NCGetBWM("INTEGRACAO_LOJASCNPJ")
	cQuery    += " WHERE TIPO_LOJA='P' "
ElseIf cView=="CUPOM"
	cQuery    := " SELECT "+cCampos+" FROM "+u_NCGetBWM("INTEGRACAO_MOVIMENTO_FISCAL_CUPOM")+" CF"
	cQuery    += " WHERE DATA_EMISSAO BETWEEN '"+WL01Trans(dDtIni,"D","I")+"' AND '"+WL01Trans(dDtFin,"D","F")+"'"
ElseIf cView=="CCF"
	cQuery    := " SELECT "+cCampos+" FROM "+u_NCGetBWM("INTEGRACAO_CCF")+" CCF"
	cQuery    += " WHERE data_venda_numerico BETWEEN "+dTOS(dDtIni)+" AND "+dTOS(dDtFin)+" "
EndIf

If !Empty(cOrderBy)
	cQuery    += " ORDER BY "+cOrderBy
EndIf

PtInterna("Buscado dados entre "+DTOS(dDtIni)+" e "+DTOS(dDtFin)  )
cArqTmp		:= U_NCIWMF02(cQuery)


//Executa a query na base de dados do WEB MANAGER
//Verifica se a conexใo foi estabelecida com sucesso
If Empty(cArqTmp)
	If !IsBlind()
		Aviso("Aten็ใo","Nใo foi possํvel conectar-se a base de dados do Web Manager",{"Ok"},2)
	EndIf
	Return .F.
EndIf

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  06/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML01REDZ(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
NCIWML01Z()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01 บAutor  ณMicrosiga 	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados na base intermediaria (Processo Fiscal)	  บฑฑ
ฑฑบ          ณ  													  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCIWML01Z()
Local dData:=Msdate()-1
//Chama a rotina de cincroniza็ใo com a base intermediแria
//Processa({|| SincBsInt(dData-1,dData-1) }, "Integra็ใo Web Manager (Fiscal)", "Sincroniza็ใo de dados")


//Grava o log de processamento
u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCIWML01Z", "Preenchimento da tabela intermediaria PZX(Reducao Z)", "FISCAL", MsDate() )

Processa({|| SincRedZ(dData-20,dData) }, "Integra็ใo Web Manager Reducao Z(Fiscal)", "Sincroniza็ใo de dados")

u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCIWML01Z", "Preenchimento da tabela intermediaria PZX(Reducao Z)", "FISCAL", MsDate(),"F" )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  06/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SincRedZ(dDtIni, dDtFin)
Local aArea 	:= GetArea()
Local cMensagem:=""
Local cArqTmp	:= ""
Local cCNPJAux	:= ""
Local aEmpFil	:= {}
Local cCNPJOrig
Local dDatMov
Local lAppend
Local nLenDtCad	:=TAMSX3("PZX_DTCAD")[1]
Local nLenCodCx	:=TAMSX3("PZX_CAIXA")[1]
Local nLenSerie	:=TAMSX3("PZX_SERIE")[1]
Local nLenCodLj	:=TAMSX3("PZX_CODLOJ")[1]


If !GetQuery("REDUCAO_Z","*","DATA_CADASTROU,COD_LOJA,COD_REDUCAOZ_DETALHES",dDtIni,dDtFin,@cArqTmp)
	RestArea(aArea)
	Return
EndIf

Do While (cArqTmp)->(!Eof())
	
	dDatMov:=STOD( AllTrim(Str((cArqTmp)->DATA_MOVIMENTO_NUMERICO))	)
	
	cMensagem:="Processando Movimento Reducao Z - Movimento do dia :"+Dtoc(dDatMov)+" na Loja:"+AllTrim(Str((cArqTmp)->COD_LOJA))+" Movimentos entre "+Dtoc(dDtIni)+" e "+Dtoc(dDtFin)
	IncProc(cMensagem)
	PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
	
	
	PZX->(DbSetOrder(1))//PZX_FILIAL+PZX_DTCAD+PZX_CAIXA+PZX_SERIE	+PZX_CODLOJ
	cChave:=xFilial("PZX")+AllTrim(Str((cArqTmp)->DATA_MOVIMENTO_NUMERICO))+Padr(AllTrim(Str((cArqTmp)->COD_CAIXA)),nLenCodCx)+padr( AllTrim(((cArqTmp)->NUN_SERIE_IMPRESSORA)),nLenSerie)+padr( AllTrim(Str((cArqTmp)->COD_LOJA)),nLenCodLj)
	If PZX->(MsSeek(cChave))
		(cArqTmp)->(DbSkip());Loop
	EndIf
	
	cCNPJOrig:=(cArqTmp)->CNPJ
	cCNPJAux	:= U_NCGCNPJSP(cCNPJOrig)//Retorna o CNPJ sem pontua็ใo
	aEmpFil	:= U_NCGEFORI(cCNPJAux,AllTrim(Str((cArqTmp)->COD_LOJA)))//Retorna a Empresa e Filial de origem
	
	If !(Len(aEmpFil) > 0)
		(cArqTmp)->(DbSkip());Loop
	EndIf
	
	
	lAppend:=.T.
	Begin Transaction
	Reclock("PZX",lAppend)
	PZX->PZX_FILIAL	:=xFilial("PZX")
	PZX->PZX_DETALH	:=AllTrim(Str((cArqTmp)->COD_REDUCAOZ_DETALHES))
	PZX->PZX_CAIXA		:=AllTrim(Str((cArqTmp)->COD_CAIXA))
	PZX->PZX_SERIE		:=AllTrim(((cArqTmp)->NUN_SERIE_IMPRESSORA))
	PZX->PZX_TIPOR		:=AllTrim((cArqTmp)->TIPOR)
	//PZX->PZX_PARAM		:=AllTrim((cArqTmp)->PARAMETRO)
	PZX->PZX_DTCAD		:=STOD( AllTrim(Str((cArqTmp)->DATA_MOVIMENTO_NUMERICO))	)
	PZX->PZX_SESSAO	:=AllTrim(Str((cArqTmp)->SESSAO_CADASTROU))
	PZX->PZX_HASH		:=AllTrim((cArqTmp)->HASH)
	PZX->PZX_VENDA		:=AllTrim(Str((cArqTmp)->COD_VENDA))
	PZX->PZX_CODRED	:=AllTrim(Str((cArqTmp)->COD_REDUCAOZ_DADOS))
	PZX->PZX_CXLOJA	:=AllTrim(Str((cArqTmp)->COD_CAIXA_LOJA))
	PZX->PZX_CODLOJ  	:=AllTrim(Str((cArqTmp)->COD_LOJA))
	PZX->PZX_DTMOV		:=STOD( AllTrim(Str((cArqTmp)->DATA_MOVIMENTO_NUMERICO))	)
	PZX->PZX_CRO		:=AllTrim((cArqTmp)->CRO)
	PZX->PZX_CRZ		:=AllTrim((cArqTmp)->CRZ)
	PZX->PZX_REDUCZ	:=AllTrim((cArqTmp)->COO_REDUCAOZ)
	PZX->PZX_GT			:=Val( (cArqTmp)->GT ) /100
	PZX->PZX_VDBRT		:=Val( (cArqTmp)->VENDA_BRUTA) /100
	PZX->PZX_TOTALI 	:=AllTrim((cArqTmp)->TOTALIZADORES_PARCIAIS)
	PZX->PZX_EMPDES	:=aEmpFil[1]
	PZX->PZX_FILDES	:=aEmpFil[2]
	PZX->PZX_NOMLJ	 	:=aEmpFil[4]
	PZX->PZX_PDV	 	:=AllTrim((cArqTmp)->NUMERO_TERMINAL)
	
	PZX->(MsUnLock())
	
	End Transaction
	(cArqTmp)->(DbSkip())
EndDo
(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  06/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML01LOJA(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
ML01GetLOJA()

//ML01GetEMP()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  06/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ML01GetLOJA()
Local aAreaAtu:=GetArea()
Local cArqTmp	:= ""
Local cMensagem
Local cCNPJOrig
Local cChave
Local cTabela:="00005"
Local cFilZX5:=xFilial("ZX5")

If !GetQuery("INTEGRACAO_LOJASCNPJ","*","COD_LOJA",,,@cArqTmp)
	RestArea(aAreaAtu)
	Return
EndIf

ZX5->(DbSetOrder(2))//ZX5_FILIAL+ZX5_TABELA+ZX5_DESCRI
Do While (cArqTmp)->(!Eof())
	
	cMensagem:=""
	IncProc(cMensagem)
	PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
	cCNPJOrig:=(cArqTmp)->CNPJ
	cCNPJAux	:= AllTrim(U_NCGCNPJSP(cCNPJOrig))
	
	Begin Transaction
	ZX5->(Reclock("ZX5",!ZX5->(MsSeek(cFilZX5+cTabela+cCNPJAux))))
	ZX5->ZX5_FILIAL:=cFilZX5
	ZX5->ZX5_TABELA:=cTabela
	ZX5->ZX5_CHAVE:=AllTrim(Str((cArqTmp)->COD_LOJA))
	ZX5->ZX5_DESCRI:=cCNPJAux
	ZX5->(MsUnLock())
	End Transaction
	(cArqTmp)->(DbSkip())
EndDo
(cArqTmp)->(DbCloseArea())
RestArea(aAreaAtu)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  06/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ML01GetEMP()
Local aAreaAtu:=GetArea()
Local cArqTmp	:= ""
Local cMensagem
Local cCNPJOrig
Local cChave
Local cTabela:="00006"
Local cFilZX5:=xFilial("ZX5")

If !GetQuery("INTEGRACAO_LOJASCNPJ","*","COD_LOJA",,,@cArqTmp)
	RestArea(aAreaAtu)
	Return
EndIf

ZX5->(DbSetOrder(1))//ZX5_FILIAL+ZX5_TABELA+ZX5_CHAVE

Do While (cArqTmp)->(!Eof())
	
	cMensagem:=""
	IncProc(cMensagem)
	PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
	cCNPJOrig:=(cArqTmp)->CNPJ
	cCNPJAux	:= AllTrim(U_NCGCNPJSP(cCNPJOrig))
	aEmpFil	:= U_NCGEFORI(cCNPJAux)//Retorna a Empresa e Filial de origem
	
	If Len(aEmpFil)==0
		aEmpFil:={"",""}
	Endif
	
	Begin Transaction
	ZX5->(Reclock("ZX5",!ZX5->(MsSeek(cFilZX5+cTabela+cCNPJAux))))
	ZX5->ZX5_FILIAL:=cFilZX5
	ZX5->ZX5_TABELA:=cTabela
	ZX5->ZX5_CHAVE:=AllTrim(Str((cArqTmp)->COD_LOJA))
	ZX5->ZX5_DESCRI:=aEmpFil[1]+";"+aEmpFil[2]
	ZX5->(MsUnLock())
	End Transaction
	(cArqTmp)->(DbSkip())
EndDo
(cArqTmp)->(DbCloseArea())
RestArea(aAreaAtu)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  07/02/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WL01Trans(xDados,cTipo,cPeriodo)
If cTipo=="D"
	xReturn:=StrZero(Year(xDados),4)+"-"+StrZero(Month(xDados),2)+"-"+StrZero(Day(xDados),2)+" "+Iif(cPeriodo=="I","00:00:00","23:59:59")
EndIf
Return xReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  07/02/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WML01CUPOM(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
NCIWML0CF()
Return 

User Function WML01JCCF(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
WML01CCF() //Contador Cupom Fiscal

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01 บAutor  ณMicrosiga 	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados na base intermediaria (Processo Fiscal)	  บฑฑ
ฑฑบ          ณ  													  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCIWML0CF()
Local dData:=Msdate()-1
u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCIWML0CF", "Preenchimento da tabela intermediaria PZY", "FISCAL", MsDate() )
//Processa({|| SincCupom(ctod("01/01/2015"),MsDate()) }, "Integra็ใo Web Manager Cupom Fiscal", "Sincroniza็ใo de dados")
Processa({|| SincCupom(dData-1,dData) }, "Integra็ใo Web Manager Cupom Fiscal", "Sincroniza็ใo de dados")
u_NCGLogWM(cEmpAnt, cFilAnt, "U_NCIWML0CF", "Preenchimento da tabela intermediaria PZY", "FISCAL", MsDate(),"F" )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  07/02/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SincCupom(dDtIni, dDtFin)
Local aArea 		:= GetArea()                                                                      
Local cArqTmp		:= ""
Local nLenCodMov	:=AvSx3("PZY_CODMOV",3)
Local nLenDoc	 	:=AvSx3("PZY_DOC",3)
Local nLenCodLoj	:=AvSx3("PZY_CODLOJ",3)
Local cChave

If !GetQuery("CUPOM","CONVERT(VARCHAR, DATA_EMISSAO, 112)  DATAEMISSAO,CF.*","DATA_EMISSAO DESC",dDtIni,dDtFin,@cArqTmp)
	RestArea(aArea)
	Return
EndIf


Do While (cArqTmp)->(!Eof())
	
	
	cMensagem:="Processando Movimento PZY ("+PADR( AllTrim(Str((cArqTmp)->COD_MOVIMENTO)),nLenCodMov)+") -  Emissao:"+dtoc( Stod((cArqTmp)->DATAEMISSAO))+" Loja:"+Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)+" Movimentos entre "+Dtoc(dDtIni)+" e "+Dtoc(dDtFin)
	IncProc(cMensagem)
	PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
	cChave:=xFilial("PZY")+PADR( AllTrim(Str((cArqTmp)->COD_MOVIMENTO)),nLenCodMov)+Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)+PADR(AllTrim( Str((cArqTmp)->NUMERO_NOTA) ),nLenDoc)
	Reclock("PZY",!PZY->(MSSeek(cChave) ))
	PZY->PZY_FILIAL:=xFilial("PZY")
	PZY->PZY_CODMOV:=PADR( AllTrim(Str((cArqTmp)->COD_MOVIMENTO)),nLenCodMov)
	PZY->PZY_DOC	:=PADR(AllTrim( Str((cArqTmp)->NUMERO_NOTA) ),nLenDoc)
	PZY->PZY_PDV	:=AllTrim((cArqTmp)->NUMERO_TERMINAL)
	PZY->PZY_MODELO:=AllTrim((cArqTmp)->COD_MODELO)
	PZY->PZY_CODLOJ:=Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)
	PZY->PZY_DATA	:=	Stod((cArqTmp)->DATAEMISSAO)
	
	PZY->(MsUnLock())
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  07/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WLJOBSCUPOM()
StartJob( "U_WML03JOB",GetEnvServer(), .T.)//Gera Orcamento (SL1 e SL2)
StartJob( "U_WML04JOB" ,GetEnvServer(), .T.)//Gera Nota Fiscal
//StartJob( "U_WML05JOB" ,GetEnvServer(), .F.)  // Reducao Z
StartJob( "U_WML06JOB" ,GetEnvServer(), .T.)//Cancelamento de Cupom
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  07/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WLJOBSENTRA()
StartJob( "U_WML02JOB",GetEnvServer(), .F.)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  07/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WLJOBTABINT()
StartJob( "U_WML01CUPOM",GetEnvServer(), .F.)//Preenche tabela PZY -  
//StartJob( "U_WML01REDZ",GetEnvServer(), .F.)//Preenche tabela PZX  
StartJob( "U_WML01JOB",GetEnvServer(), .T.)//Prenche PZQ e PZR
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  08/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function WML01CCF()
Local dData:=Msdate()-1
u_NCGLogWM(cEmpAnt, cFilAnt, "WML01CCF", "Preenchimento da tabela intermediaria PZ0", "FISCAL", MsDate() )
Processa({|| SincCCF(dData-1,dData) }, "Integra็ใo Web Manager Cupom Fiscal", "Sincroniza็ใo de dados")
u_NCGLogWM(cEmpAnt, cFilAnt, "WML01CCF", "Preenchimento da tabela intermediaria PZ0", "FISCAL", MsDate(),"F" )
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  08/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SincCCF(dDtIni,dDtFin)
Local aArea 		:= GetArea()                                                                      
Local cArqTmp		:= ""
Local nLenCodLoj	:=AvSx3("PZ0_CODLOJ",3)
Local nLenPDV		:=AvSx3("PZ0_PDV",3)
Local nLenCCF		:=AvSx3("PZ0_CCF",3)
Local cChave
PtInternal(1,"Executando consulta no WebManager-Movimentos entre "+Dtoc(dDtIni)+" e "+Dtoc(dDtFin))
If !GetQuery("CCF","CCF.*","data_venda_numerico DESC",dDtIni,dDtFin,@cArqTmp)
	RestArea(aArea)
	Return
EndIf


PZ0->(DbSetOrder(1))//PZ0_FILIAL+PZ0_CODLOJ+PZ0_DTMOV+PZ0_PDV

Do While (cArqTmp)->(!Eof())
	
	
	cMensagem:="Processando Movimento PZ0 -  Emissao:"+dtoc( stod(AllTrim(Str((cArqTmp)->data_venda_numerico))))+" Loja:"+Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)+" Movimentos entre "+Dtoc(dDtIni)+" e "+Dtoc(dDtFin)
	IncProc(cMensagem)
	PtInternal(1,cMensagem)//Visualizar no Monitor do Protheus
	
	cChave:=xFilial("PZ0")+Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)+AllTrim(Str((cArqTmp)->data_venda_numerico))+Padr(AllTrim((cArqTmp)->NUMERO_TERMINAL),nLenPDV)
	
	Reclock("PZ0",!PZ0->(MSSeek(cChave) ))
	
	PZ0->PZ0_FILIAL	:=xFilial("PZY")
	PZ0->PZ0_PDV	:=AllTrim((cArqTmp)->NUMERO_TERMINAL)
	PZ0->PZ0_CODLOJ	:=Padr(Alltrim(Str((cArqTmp)->COD_LOJA)),nLenCodLoj)
	PZ0->PZ0_DTMOV	:=stod(AllTrim(Str((cArqTmp)->data_venda_numerico)))
	PZ0->PZ0_PDV	:=Padr(AllTrim((cArqTmp)->NUMERO_TERMINAL),nLenPDV)
	PZ0->PZ0_CCF	:=StrZero((cArqTmp)->CCF,nLenCCF)
	PZ0->(MsUnLock())
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  08/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xTesteWM(aDados)
Default aDados := {"01","03"}
RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])
//WML01CCF() //Contador Cupom Fiscal
SincSAT()

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWML01  บAutor  ณMicrosiga           บ Data ณ  12/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SincSAT()
Local aAreaAtu 	:= GetArea()
Local cArqTmp	:= GetNextAlias()
Local cQryAlias	:= GetNextAlias()
Local oConectDB:= U_DBWebManager() //Funcao encontrada no NCIWMF02
Local cQuery    := ""
Local cChavePZR


BeginSQL Alias cQryAlias
	SELECT PZQ.R_E_C_N_O_ RecPZQ,PZQ_TOTAL,PZQ_CODMOV,PZQ_DOC
	FROM  %Table:PZQ% PZQ
	WHERE PZQ_FILIAL = %xfilial:PZQ%
	AND PZQ.PZQ_DOCPRT=' '
	AND PZQ.PZQ_OPER IN ('VE','TRV','CA')
	AND PZQ.PZQ_DOC ='0' 	
	AND PZQ.%notDel%
	ORDER BY PZQ_EMPDES,PZQ_FILDES,PZQ_EMISSA,PZQ_CODMOV	
EndSQL
    
PZR->(DbSetOrder(3))

Do While (cQryAlias)->(!Eof())

	cQuery:=" Select pkbNF_nota.cod_nf_nota,pkbNF_nota.W16_vNF  "
	cQuery+=" FROM uzgames.dbo.pkbNF_nota"
	cQuery+=" Where COD="+AllTrim((cQryAlias)->PZQ_CODMOV)

	oConectDB:= U_DBWebManager() //Funcao encontrada no NCIWMF02
	If !oConectDB:OpenConnection()
		Return	
	EndIf             
	PZQ->(DbGoTo((cQryAlias)->RecPZQ ))
	oConectDB:NewAlias( cQuery, cArqTmp )
	
	
		
		PZQ->(RecLock("PZQ",.F.))
		PZQ->PZQ_DOC:=AllTrim(Str((cArqTmp)->cod_nf_nota))
		PZQ->(MsUnLock())
			
		cChavePZR:=PZQ->(PZQ_FILIAL+PZQ_CODMOV+PZQ_CODLOJ)
		PZR->(MsSeek(cChavePZR))//
		Do While PZR->(!Eof() ) .And. PZR->(PZR_FILIAL+PZR_CODMOV+PZR_CODLOJ)==cChavePZR
			PZR->(RecLock("PZR",.F.))
			PZR->PZR_DOC:=PZQ->PZQ_DOC
			PZR->(MsUnLock())
			PZR->(DbSkip())		
		EndDo

	
	
	oConectDB:CloseConnection() //Fecha Conexao e o cQryAlias
	oConectDB:Finish()
	cArqTmp	:= GetNextAlias()
	(cQryAlias)->(DbSkip())
EndDo 


(cQryAlias)->(DbCloseArea())

RestArea(aAreaAtu)
Return




Static Function LM01SAT()
   
If Empty(PZR->PZR_MODECF) .And. Empty(PZR->PZR_SERECF)
	PZR->PZR_TERMIN:="001"
EndIf	

Return