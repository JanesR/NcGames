#INCLUDE "PROTHEUS.CH" 
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZNCG15	     บAutor  ณAdam Diniz Lima	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณSchedule para importar arquivos da Neogrid para o Protheus  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณaParam - array com a empresa e a filial.						  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function KZNCG15(aParam)

	Local cPathNG 	:= "" //Diretorio do arquivo vindo da Neogrid                                           
	Local cPathPT 	:= "" //Diretorio do arquivo apos o processamento no Protheus 
	Local aArqNG	:= {} //Array com todos os arquivos contidos no diretorio de origem
	Local nHandle 	:= 0
	Local nx		:= 0
	Local nlI		:= 0
	Local lContinua := .T.
	Local nTentativa:= 0
	Local clCurDir	:= ""
	Local clCliente	:= ""
	Local alCli		:= {}
	Local clBloq 	:= ""
	Local llPerm	:= .F.
	Local alPerImp	:= {}
	
	Private cpNumAlt:=""
	Private ap4Email:= {} //Array com informacoes referente ao codigo do comprador, cliente, loja e vendedor -> realizara o envio de email no final da rotina
	Private apCbCopy:= {} //Recebe os pedidos para efetuar uma copia
	Private apItCopy:= {} //Recebe os itens dos pedidos para efetuar uma copia 
	Private cNPdEDI	:= "" //Numero do Pedido EDI
	Private cCliFat	:= "" //Cliente de Faturamento
	Private cLjFat	:= "" //Loja de Faturamento		
	Private cTpPed	:= "" //Tipo de Pedido  
	Private cTipoOp	:= "" //Tipo de Operacao da Tes
	Private cPedCom := "" //Numero do Pedido do Comprador 
	Private cCliEnt := "" //Cliente de Entrega
	Private cLjEnt	:= "" //Loja de Entrega 
	Private cTpCli	:= "" //Tipo de Cliente
	Private cVend	:= "" //Vendedor 
	Private cTpFrt	:= "" //Condi็ใo de Entrega (tipo de frete)
	Private nDesFin := 0  //Percentual de Desconto Financeiro
	Private nDesc1  := 0  //Percentual de Desconto Comercial
	Private nDesc2  := 0  //Percentual de Desconto Promocional
	Private nDesc3  := 0 
	Private nDesc4  := 0 
	Private cTabPrc := "" //Tabela de precos
	Private dDtPvCl	:= "" //Data de Emissao do Pedido	
	Private dDtInEt := "" //Data Inicial do Periodo de Entrega
	Private dDtEntr	:= "" //Data Final do Periodo de Entrega  	
	Private nTotPed	:= 0  //Valor Total do Pedido  
	Private cCgcEnt := "" //CNPJ do Local de Entrega   
    Private cCgcFat := "" //CNPJ do Local da Cobran็a da Fatura   
    Private cCgcCob := "" //CNPJ do Local da Cobran็a da Fatura    
    Private cCgcFor := "" //CNPJ do Fornecedor 
    
    Private cItem	:= "" //Numero Sequencial da Linha de Item  
    Private cEan 	:= "" //EAN do Produto
    Private cCodPro	:= "" //Codigo do Produto 
    Private cLocal	:= "" //Armazem do Produto     
    Private cUnid	:= "" //Unidade de Medida do Produto   
    Private nQtd 	:= 0  //Quantidade do item do pedido 
    Private	nPrcUni := 0  //Preco Liquido Unitario 
    Private	nTotIt	:= 0  //Total do item = Preco Liquido Unitario * Quantidade do Item do Pedido      
    Private dDtEnt  := "" //Data de Entrega Nc Games   
	Private cOper   := "" //Tipo de Operacao da Tes  	
	Private cTes 	:= "" //Tes Inteligente a ser utilizada na geracao do pre-pedido 	
	Private cCfOp 	:= "" //Busca o CFOP pela Tes		
	Private cCst  	:= "" //Codigo de Situacao Tributaria 	
	Private nDesc 	:= 0  //Percentual do Desconto Comercial	
	Private nVlrDes := 0  //Valor Unitario do Desconto Comercial	
	Private nPrIpi  := 0  //Aliquota de IPI	
	Private nVlrIpi := 0  //Valor Unitแrio do IPI	
	Private nVlrDsp := 0  //Valor Unitแrio da Despesa Acess๓ria Tributada	
	Private nVEncSeg:= 0  //Valor de Encargos de Seguro 	
	Private nVlrFrt := 0  //Valor de Encargo de Frete 
	Private nTotFrt	:= 0  //Valor Total do Frete 
	Private nVlrSeg	:= 0  //Valor do Seguro no Item   
	Private aItens	:= {}
	Private cCdTran := "" //CGC  da transportadora do cliente    
	Private cNcm	:= "" //Nomenclatura Mercosul
	Private cUM2	:= "" //Segunda Unidade de Medida
	Private nValIcm := 0  
	Private nPerIcm := 0
	Private cpDescri:= ""
	Private lAuto := IIF(Select("SM0") > 0, .f., .t.)
	
	Default aParam := {"01","03"} 
	IF LAUTO
		QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
		PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1,ZAE,ZAC,ZAF,SM0,SE4,ZAK,SB1,SF4,SFM' //USER 'ADMIN' PASSWORD 'Ncg@m1' 
	ENDIF
	//aParam := {"01","01"} Usar este na NcGames
	//RpcSetType(3) // TRAVA NESTA FUNวรO // ALTERADO POR ERICH BUTTNER 01/08/12
	//RpcSetEnv(aParam[1],aParam[2]) 

	cPathNG := SuperGetMV("KZ_ALTENV", .T., "")     
	cPathPT := SuperGetMV("KZ_ALTPROC", .T., "")
	
	clCurDir := CurDir()
	If SubStr(clCurDir,Len(clCurDir),1) == "\"
		clCurDir := SubStr(clCurDir,1,Len(clCurDir)-1)
	EndIf
	If SubStr(clCurDir,1,1) != "\"
		clCurDir := "\"+ clCurDir
	EndIf

	If !Empty(cPathNG)
		cPathNG := clCurDir + cPathNG
	EndIf
	If !Empty(cPathPT)		
		cPathPT := clCurDir + cPathPT
	EndIf
	
	If Empty(cPathNG)
		Conout("Parametro nao preenchido: KZ_ALTENV") 
		Return
	EndIf
	If Empty(cPathPT)
		Conout("Parametro nao preenchido: KZ_ALTPROC")  
		Return
	EndIf 
	If !ExistDir(cPathNG)
		Conout("Diretorio nao existente: "+cPathNG)
		Return
	EndIf 
	If !ExistDir(cPathPT)
		Conout("Diretorio nao existente: "+cPathPT)
		Return
	EndIf
	
	aArqNG := Directory (cPathNG+"\*.alp",,Nil,.F.)   
	
	If Empty(aArqNG)
		Conout("Nao existem arquivos a serem processados no diretorio "+cPathNG)  
		Return
	EndIf	
	
	Conout( ProcName(0)+" Inicio da Execucao da Rotina Importacao de Pedido EDI: "+Time() )	                  
	
	For nx := 1 to Len(aArqNG)
		lContinua  := .T.
		nTentativa := 0  
	                     
	    // Tenta abrir o arquivo 10 vezes
		While lContinua
			nTentativa++
			
			If nTentativa > 10
				lContinua := .F.
				Exit
			EndIf
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Abre o arquivo texto e valida se conseguiu efetuar a abertura       ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If (nHandle := FT_Fuse(cPathNG+"\"+aArqNG[nx][1])) <> -1
				lContinua := .F.
			Else
				FT_Fuse()
				nHandle := -1
				Sleep( 2000 ) //Espera 2 segundos para poder reprocessar
			EndIf
		EndDo	 
		
		If nHandle == -1
			Loop
		EndIf
		
		//Vai para a Primeira Linha do Arquivo
		FT_FGoTop()
		
		//Fazer enquanto nใo for fim de Arquivo
		Do While !FT_FEof()		 

			If SubStr(FT_FReadLn(),0,2) == "01"// Cabecalho
				SA1->(dbGoTop())
				If SA1->(dbSeek(xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14))))	
					clBloq 		:= SA1->A1_MSBLQL
					clCliente	:= "Cliente: " + SA1->A1_COD + " - Loja: " + SA1->A1_LOJA
				EndIf
					
				If clBloq == "2" .OR. EMPTY(clBloq)
					cCliFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_COD")
					cLjFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_LOJA")
					
					llPerm := U_KZVlTDoc(cCliFat,cLjFat,"02") // 02 -> ORDCHG - Alteracao de pedido
					
					If llPerm
						KZImpCabec()
					EndIf
				EndIf
			EndIf
	 		If (clBloq == "2" .OR. EMPTY(clBloq)) .And. llPerm
				If SubStr(FT_FReadLn(),0,2) == "02"// Pagamento
					KZImpPag()
				EndIf
				
				If SubStr(FT_FReadLn(),0,2) == "03"// Descontos e Encargos do Pedido
					KZImpDesc()
				EndIf
				
				If SubStr(FT_FReadLn(),0,2) == "04"// Itens
					KZImpItens()
				EndIf
				
				If SubStr(FT_FReadLn(),0,2) == "09" // Sumario
					KZImpSum()
				EndIf
			Else
				If !llPerm
					If aScan(alPerImp, AllTrim(cPedCom)+AllTrim(cCliFat)+AllTrim(cLjFat)+"P") == 0
						Conout( ProcName(0) + " Cliente/Loja: "+ AllTrim(cCliFat)+"/"+AllTrim(cLjFat)+" Nใo permite Importa็ใo de Alteracoes. O pedido desse cliente nao foi importado." + Time() )
						aAdd(alPerImp,AllTrim(cPedCom)+AllTrim(cCliFat)+AllTrim(cLjFat)+"P")
					EndIf
				Else
					If aScan(alCli,clCliente) == 0
		   				Conout( ProcName(0) + " " + clCliente + " nao esta ativo. O pedido desse cliente nao foi importado." + Time() )
		   		   		aADD(alCli,clCliente)
		   		   	EndIf
				EndIf
		    EndIf
		    //Vai para a Proxima Linha
		 	FT_FSkip()
		EndDo

		//Fecha o Arquivo
		FT_FUse()

		// Faz a transferencia do arquivo da pasta de origem para a pasta de destino
		If __CopyFile(cPathNG+"\"+aArqNG[nx][1],cPathPT+"\"+SubStr(aArqNG[nx][1],1,Len(aArqNG[nx][1])-4)+".esc")
	   		FErase(cPathNG+"\"+aArqNG[nx][1])
	   	EndIf 
	   	
	   	Conout( ProcName(0)+" Fim do processamento do arquivo: "+aArqNG[nx][1]+" "+Time() )
	Next nx
	
	// Realiza envio de email para alertar os vendedores e os responsaveis da area
	For nlI := 1 To Len(ap4Email)
		KZENVMAIL(nlI)	
	Next nlI
	
	Conout( ProcName(0)+" Fim da Execucao da Importacao de Alteracao de Pedido EDI: "+Time() )
	
//	U_KZNCG19(2,apCbCopy,apItCopy) // Efetua uma copia identica dos pedidos importados na ZAH e ZAI 

	RpcClearEnv()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZImpCabec    บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImporta o cabecalho para o pre-pedido.					  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZImpCabec()

	Local clQuery	:= ""

	cCliFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_COD")
	//CNPJ do Comprador 
	
	cLjFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_LOJA")
	//CNPJ do Comprador
	
	cpNumAlt :=	U_KZFNum("ZAJ","ZAJ_NUMALT")
	//Numero Sequencial 
	
	cTpPed	:= Alltrim(SubStr(FT_FReadLn(),6,3))
	//Tipo de Pedido     
	
	cPedCom	:= Alltrim(SubStr(FT_FReadLn(),9,20))
	//Numero do Pedido do Comprador 

	/********************************************************************************/
 	//Numero do Pedido EDI eh buscado na tabela ZAE e que o status seja diferente de CANCELADO ('7')

	clQuery	+= " SELECT ZAE_NUMEDI " + CRLF
	clQuery	+= " FROM " + RETSQLNAME("ZAE") + CRLF
	clQuery	+= " WHERE	D_E_L_E_T_ <> '*' " + CRLF
	clQuery	+= " 		AND ZAE_FILIAL = '" + xFilial("ZAE") + "' " + CRLF
	clQuery	+= " 		AND ZAE_NUMCLI = '" + cPedCom + "' " + CRLF
	clQuery	+= " 		AND ZAE_CLIFAT = '" + cCliFat + "' " + CRLF
	clQuery	+= " 		AND ZAE_LJFAT = '" + cLjFat + "' " + CRLF
	clQuery	+= " 		AND ZAE_STATUS <> '7' " + CRLF
	
	clQuery := ChangeQuery(clQuery)
	
	If Select("QRYEDI") > 0
		QRYEDI->(dbCloseArea())
	EndIf
	dbUseArea( .T., "TopConn", TCGenQry(,,clQuery), "QRYEDI", .F., .F. )	

	cNPdEDI	:= QRYEDI->ZAE_NUMEDI
	
	QRYEDI->(dbCloseArea())

	//Posicione("ZAE",2,xFilial("ZAE")+avKey(cPedCom,"ZAE_NUMCLI")+avKey(cCliFat,"ZAE_CLIFAT")+avKey(cLjFat,"ZAE_LJFAT"),"ZAE_NUMEDI")
	/********************************************************************************/

	cCliEnt := Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),209,14)),"A1_COD")
	//CNPJ do Local de Entrega
	
	cLjEnt	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),209,14)),"A1_LOJA")
	//CNPJ do Local de Entrega
	 
	cTpCli	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_TIPO")
	//CNPJ do Comprador
	
	cVend	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_VEND")
	//CNPJ do Comprador      
	
	cTransp := Posicione("SA4",3,xFilial("SA4")+Alltrim(SubStr(FT_FReadLn(),226,14)),"A4_COD")
	//CNPJ da Transportadora   
	
	If Empty(cTransp)// Se nao existir a transportadora informada no arquivo, sera buscada a transportadora do cliente em questao	
		cTransp := Posicione("SA1",1,xFilial("SA1")+Alltrim(cCliFat)+Alltrim(cLjFat),"A1_TRANSP")	
	EndIf	
	
	cTpFrt	:= Iif (Alltrim(SubStr(FT_FReadLn(),270,3))=="CIF","C",(Iif (Alltrim(SubStr(FT_FReadLn(),270,3))=="FOB","F","")))
	//Condicao de Entrega (tipo de frete)
	
    cTabPrc	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_TABELA")
    //CNPJ do Comprador       
    
    dDtPvCl	:= STOD(Alltrim(SubStr(FT_FReadLn(),49,8)))
    //Data de Emissao do Pedido 
    
    dDtInEt := STOD(Alltrim(SubStr(FT_FReadLn(),61,8)))
    //Data Inicial do Periodo de Entrega 
    dDtEntr := STOD(Alltrim(SubStr(FT_FReadLn(),73,8)))
    //Data Final do Periodo de Entrega 
        
    cCgcEnt := Alltrim(SubStr(FT_FReadLn(),209,14))
    //CNPJ do Local de Entrega       
    
    cCgcFat := Alltrim(SubStr(FT_FReadLn(),181,14))
    //CNPJ do comprador  
    
    cCgcCob := Alltrim(SubStr(FT_FReadLn(),195,14))
    //CNPJ do Local da Cobran็a da Fatura   
    
    cCgcFor := Alltrim(SubStr(FT_FReadLn(),167,14))
    //CNPJ do Fornecedor 
    
    If aScan(ap4Email, {|z| AllTrim(z[1]) == cPedCom .And. AllTrim(z[2]) == cCliFat .And. AllTrim(z[3]) == cLjFat }) == 0
		aAdd(ap4Email,{cPedCom,cCliFat,cLjFat,cVend})
	EndIf
	    
	If Select("ZAC") == 0
		DbSelectArea("ZAC")
	EndIf
	ZAC->(DbSetOrder(1))
	ZAC->(dbGoTop())  
	
	If ZAC->(DbSeek(xFilial("ZAC")+cTpPed)) 
		cTipoOp := ZAC->ZAC_OPTES	
	Else
		cTipoOp := ""
	EndIf
	
	If Select("ZAJ") == 0
		DbSelectArea("ZAJ")
	EndIf
	ZAJ->(DbSetOrder(1))
	ZAJ->(dbGoTop())	

	If ZAJ->(!DbSeek(xFilial("ZAJ")+cpNumAlt+cCliFat+cLjFat)) 
	
		If RecLock("ZAJ",.T.)
		  
			ZAJ->ZAJ_FILIAL	:= xFilial("ZAJ")///OK
			ZAJ->ZAJ_STATUS	:= "1"
			ZAJ->ZAJ_TIPPED := "N"		   	
	   		ZAJ->ZAJ_TPNGRD	:= cTpPed///OK
	   		ZAJ->ZAJ_NUMEDI	:= cNPdEDI///OK
	   		ZAJ->ZAJ_NUMALT	:= cpNumAlt//OK
	   		ZAJ->ZAJ_NUMCLI	:= cPedCom///OK	   		 
	   		ZAJ->ZAJ_CLIFAT	:= cCliFat///OK
	   		ZAJ->ZAJ_LJFAT	:= cLjFat ///OK	   		
	   		ZAJ->ZAJ_CLIENT	:= cCliEnt///OK
	   		ZAJ->ZAJ_LJENT	:= cLjEnt///OK	   		
	   		ZAJ->ZAJ_TIPOCL	:= cTpCli///OK	   		 
	   		ZAJ->ZAJ_VEND	:= cVend ///OK	   		
	   		ZAJ->ZAJ_TRANSP	:= cTransp///OK	 	   		  		
	   		ZAJ->ZAJ_TPFRET	:= cTpFrt///OK	   			   			   	
	   		ZAJ->ZAJ_TABPRC	:= cTabPrc///OK	   		
	   		ZAJ->ZAJ_DTIMP	:= dDataBase///OK	   			   		
	   		ZAJ->ZAJ_DTIENT	:= dDtInEt///OK	   			   		
	   		ZAJ->ZAJ_DTPVCL	:= dDtPvCl///OK	   			   		
	   		ZAJ->ZAJ_DTENTR	:= dDtEntr///OK	   		  
	   		ZAJ->ZAJ_CGCENT	:= cCgcEnt///OK
	   		ZAJ->ZAJ_CGCFAT	:= cCgcFat///OK
	   		ZAJ->ZAJ_CGCCOB	:= cCgcCob///OK
	   		ZAJ->ZAJ_CGCFOR	:= cCgcFor///OK		   	
		
		EndIf
		ZAJ->(MsUnlock())	
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
ฑฑบFuncao    ณ KZImpPag	     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImporta as condicoes de pagamento para o pre-pedido.		  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZImpPag()	
    
	If cTpPed <> "002" //Pedidos de Mercadorias Bonificadas  	
	
   		cCondPag := Posicione("SE4",1,xFilial("SE4")+avKey(Alltrim(SubStr(FT_FReadLn(),3,3)),"E4_CODIGO"),"E4_CODIGO")	
   		
//   		If Empty(cCondPag)	
//   			cCondPag := Posicione("SA1",1,xFilial("SA1")+Alltrim(cCliFat)+Alltrim(cLjFat),"A1_COND")
//   		EndIf
	 	
		If Select("ZAJ") == 0
			DbSelectArea("ZAJ")
		EndIf
		ZAJ->(DbSetOrder(1))
		ZAJ->(dbGoTop())
	
		If ZAJ->(DbSeek(xFilial("ZAJ")+cpNumAlt+cCliFat+cLjFat)) 	
			If RecLock("ZAJ",.F.)                  
			
				ZAJ->ZAJ_CONDPA	:= cCondPag///OK 			
			
			EndIf 
			ZAJ->(MsUnlock())	
		EndIf
	
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
ฑฑบFuncao    ณ KZImpDesc     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImporta os descontos para o pre-pedido.  					  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZImpDesc()
//	Local nlPerAce	:= 0
//	Local nlPerPro	:= 0

    nDesFin := Val(Alltrim(SubStr(FT_FReadLn(),3,3)+"."+SubStr(FT_FReadLn(),6,2)))
	//nDesFin := Val(Alltrim(SubStr(FT_FReadLn(),3,5)))
	//Percentual de Desconto Financeiro           
	
   	nDesc1 := Val(Alltrim(SubStr(FT_FReadLn(),23,3)+"."+SubStr(FT_FReadLn(),26,2)))
	//nDesc1 := Val(Alltrim(SubStr(FT_FReadLn(),23,5)))
	//Percentual de Desconto Comercial  
	
	nDesc2 := Val(Alltrim(SubStr(FT_FReadLn(),43,3)+"."+SubStr(FT_FReadLn(),46,2)))
	//nDesc2 := Val(Alltrim(SubStr(FT_FReadLn(),43,5)))
	//Percentual de Desconto Promocional
	
	nDesc3 := 0
	//Se houver outros descontos
	  
	nDesc4 := 0
	//Se houver outros descontos
	
   	nVEncSeg := Val(Alltrim(SubStr(FT_FReadLn(),108,13)+"."+SubStr(FT_FReadLn(),121,2)))
	//nVEncSeg := Val(Alltrim(SubStr(FT_FReadLn(),108,15))) 
	//Valor de Encargos de Seguro

/*	nlPerAce := Val(Alltrim(SubStr(FT_FReadLn(),123,3))+"."+Alltrim(SubStr(FT_FReadLn(),126,2))) 
	//nlPerAce := Val(Alltrim(SubStr(FT_FReadLn(),123,5))) 
	//Percentual de Acessoria
                                 
	nlPerPro := Val(Alltrim(SubStr(FT_FReadLn(),128,3))+"."+Alltrim(SubStr(FT_FReadLn(),131,2))) 
	//nlPerPro := Val(Alltrim(SubStr(FT_FReadLn(),128,5))) 
	//Percentual de Propaganda
*/	
	If Select("ZAJ") == 0
		DbSelectArea("ZAJ")
	EndIf
	ZAJ->(DbSetOrder(1))
	ZAJ->(dbGoTop())

	If ZAJ->(DbSeek(xFilial("ZAJ")+cpNumAlt+cCliFat+cLjFat))	
		If RecLock("ZAJ",.F.)	
	   		ZAJ->ZAJ_DESCFI:= nDesFin///OK 
			ZAJ->ZAJ_DESC1 := nDesc1 ///OK  
	   		ZAJ->ZAJ_DESC2 := nDesc2 ///OK
	   		ZAJ->ZAJ_DESC3 := nDesc3 ///OK
	   		ZAJ->ZAJ_DESC4 := nDesc4 ///OK		
//			ZAJ->ZAJ_PERACE	:= nlPerAce	
//			ZAJ->ZAJ_PERPRO	:= nlPerPro	
		EndIf 
		ZAJ->(MsUnlock())	
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
ฑฑบFuncao    ณ KZImpPag	     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImporta os itens para o pre-pedido.						  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZImpItens()
      
	cItem	:= Alltrim(SubStr(FT_FReadLn(),3,4))
	//Numero Sequencial da Linha de Item 
	cItem := RetAsc(cItem,TamSx3("ZAF_ITEM")[1],.T.)
	// Tratamento para que o valor do item se transforme em 2 caracteres, caso ultrapasse o 100 ele come็a a numera็ใo por: 100 = A0 e assim por diante
	
	cEan  	:= Alltrim(SubStr(FT_FReadLn(),18,14))
	//Codigo do Produto
	
	cCodPro := Posicione("SB1",5,xFilial("SB1")+Alltrim(SubStr(FT_FReadLn(),18,14)),"B1_COD")
	//Codigo do Produto
	
	cLocal	:= Posicione("SB1",5,xFilial("SB1")+Alltrim(SubStr(FT_FReadLn(),18,14)),"B1_LOCPAD")
	//Codigo do Produto	
	
	cpDescri := Alltrim(SubStr(FT_FReadLn(),32,40))
	// Descricao do produto
	
	cUnid 	:= Alltrim(SubStr(FT_FReadLn(),92,3))
	//Unidade de Medida   
	
	cUM2	:= Posicione("SB1",1,xFilial("SB1")+cCodPro,"B1_SEGUM")
	
	If cTpPed == "002"//Pedido de Mercadorias Bonificadas 
	
		nQtd :=	Val(Alltrim(SubStr(FT_FReadLn(),115,13)+"."+SubStr(FT_FReadLn(),128,2)))
		//nQtd := Val(Alltrim(SubStr(FT_FReadLn(),115,15)))
		//Quantidade Bonificada       
	Else  
   		nQtd :=	Val(Alltrim(SubStr(FT_FReadLn(),100,13)+"."+SubStr(FT_FReadLn(),113,2)))
		//nQtd := Val(Alltrim(SubStr(FT_FReadLn(),100,15)))
		//Quantidade Pedida         
	EndIf	 
	 
	nPrcUni := Val(Alltrim(SubStr(FT_FReadLn(),198,13)+"."+SubStr(FT_FReadLn(),211,2)))
	//nPrcUni := Val(Alltrim(SubStr(FT_FReadLn(),198,15)))
	//Preco Liquido Unitario
	
	nTotIt	:= (nPrcUni * nQtd)
	//Total do item = Preco Liquido Unitario * Quantidade do Item  
	
	dDtEnt := CTOD('  /  /  ')
	//Data de Entrega Nc Games  
	
	cOper  := cTipoOp
	//Tipo de Operacao  
	
	cTes := MaTesInt(2,cOper,cCliFat,cLjFat,"C",cCodPro,NIL)
	//Retorna a Tes Inteligente a ser utilizada na geracao do pre-pedido  
	
	cCfOp := Posicione("SF4",1,xFilial("SF4")+cTes,"F4_CF")
	//Busca o CFOP pela Tes	
	
	cCst  := Posicione("SF4",1,xFilial("SF4")+cTes,"F4_CSTPIS")
	//Busca o CST pela Tes 
	If Empty(cCst)
		cCst  := Posicione("SF4",1,xFilial("SF4")+cTes,"F4_CSTCOF")  
	EndIf  
	
	cNcm := Posicione("SFM",1,xFilial("SFM")+cOper+cCodPro+cCliFat+cLjFat,"FM_POSIPI")	
	
	If Empty(cNcm)  
   		cNcm :=	Posicione("SB1",1,xFilial("SB1")+cCodPro,"B1_POSIPI")	
	EndIf		
	 
 	nDesc :=   Val(Alltrim(SubStr(FT_FReadLn(),236,3)+"."+SubStr(FT_FReadLn(),239,2)))
	//nDesc := Val(Alltrim(SubStr(FT_FReadLn(),236,5)))
	//Percentual do Desconto Comercial 
	
	nVlrDes := Val(Alltrim(SubStr(FT_FReadLn(),221,13)+"."+SubStr(FT_FReadLn(),234,2)))
	//nVlrDes := Val(Alltrim(SubStr(FT_FReadLn(),221,15)))
	//Valor Unitario do Desconto Comercial
	
	nPrIpi  := Val(Alltrim(SubStr(FT_FReadLn(),256,3)+"."+SubStr(FT_FReadLn(),259,2)))
	//nPrIpi  := Val(Alltrim(SubStr(FT_FReadLn(),256,5)))
	//Aliquota de IPI
	
	nVlrIpi := Val(Alltrim(SubStr(FT_FReadLn(),241,13)+"."+SubStr(FT_FReadLn(),254,2)))
	//nVlrIpi := Val(Alltrim(SubStr(FT_FReadLn(),241,15)))
	//Valor Unitแrio do IPI
	
   	nVlrDsp := Val(Alltrim(SubStr(FT_FReadLn(),261,13)+"."+SubStr(FT_FReadLn(),274,2)))
	//nVlrDsp := Val(Alltrim(SubStr(FT_FReadLn(),261,15)))
	//Valor Unitแrio da Despesa Acess๓ria Tributada	 
	
	nVlrFrt := Val(Alltrim(SubStr(FT_FReadLn(),291,13)+"."+SubStr(FT_FReadLn(),304,2)))
	//nVlrFrt := Val(Alltrim(SubStr(FT_FReadLn(),291,15)))
	//Valor de Encargo de Frete 
	
	nTotFrt += nVlrFrt    
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicializa a funcao fiscal                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	MaFisSave()
	MaFisEnd()  
	
	//MaFisIni(SA1->A1_COD, SA1->A1_LOJA, "C", "S", cTipoCli,,, .F., "SB1")
   	MaFisIni(cCliFat,cLjFat,"C","N",cTpCli,,,.F.,)   	  
	
	//MaFisAdd(SB1->B1_COD, SF4->F4_CODIGO, nQuant,nVlUnit, 0, "", "",, 0, 0, 0, 0, nVlrTotItem, 0, SB1->(RecNo())) 
	
	MaFisAdd(cCodPro,cTes,nQtd,nPrcUni,0,"","",,0,0,0,0,nTotIt,0,)
 
	// Calcula os valores do IPI
	//nBasIPI := MaFisRet(1,'IT_BASEIPI')
	//nValIPI := MaFisRet(1,'IT_VALIPI')
	//nAlqIPI := MaFisRet(1,'IT_ALIQIPI')	
  
	nPerIcm := MaFisRet(1,'IT_ALIQICM' )  
	nValIcm := MaFisRet(1,'IT_VALICM' )	
	 
	// Encerra a funcao fiscal
	MaFisEnd()
	MaFisRestore()  
	aAdd(aItens,{cItem,nTotIt})
//cpNumAlt guarda a informacao correta do numero do numero da alteracao - indice da ZAJ - Adam
	If aScan(apCbCopy, {|z| AllTrim(z[1]) == AllTrim(cpNumAlt) .And. AllTrim(z[2]) == AllTrim(cCliFat) .And. AllTrim(z[3]) == AllTrim(cLjFat)}) == 0
		aAdd(apCbCopy,{cpNumAlt,cCliFat,cLjFat})
	EndIf
	
	If aScan(apItCopy, {|z| AllTrim(z[1]) == AllTrim(cpNumAlt) .And. AllTrim(z[2]) == AllTrim(cCliFat) .And. AllTrim(z[3]) == AllTrim(cLjFat) .And. AllTrim(z[4]) == AllTrim(cItem)}) == 0
		aAdd(apItCopy,{cpNumAlt,cCliFat,cLjFat,cItem})
	EndIf
	
	If cUnid == "EA"
   		cUnid := "UN"
   	ElseIf cUnid == "GRM"
   		cUnid := "G"
   	ElseIf cUnid == "KGM"
   		cUnid := "KG"
   	ElseIf cUnid == "LTR"
   		cUnid := "L"
   	ElseIf cUnid == "MTR"
   		cUnid := "MT"
   	ElseIf cUnid == "MTK"
   		cUnid := "M2"
   	ElseIf cUnid == "MTQ"
   		cUnid := "M3"
   	ElseIf cUnid == "MGM"
   		nQtd := (nQtd/1000) // Converte a Quantidade de Miligrama para Grama   	
   		cUnid := "G" 
   	ElseIf cUnid == "MLT"
   		cUnid := "ML" 
   	ElseIf cUnid == "TNE"
   		cUnid := "TL" 
   	ElseIf cUnid == "PCE"
   		cUnid := "PC" 
   	ElseIf Empty(cUnid)
   		cUnid := ""
   	EndIf   	

	If Select("ZAK") == 0
		DbSelectArea("ZAK")
	EndIf
	ZAK->(DbSetOrder(1))
	ZAK->(dbGoTop())  
	
	//'ZAK_FILIAL+ZAK_NUMALT+ZAK_CLIFAT+ZAK_LJFAT+ZAK_ITEM'
	If ZAK->(!DbSeek(xFilial("ZAK")+avKey(cpNumAlt,"ZAK_NUMALT")+avKey(cCliFat,"ZAK_CLIFAT")+avKey(cLjFat,"ZAK_LJFAT")+avKey(cItem,"ZAK_ITEM")))
		If RecLock("ZAK",.T.)
			
			ZAK->ZAK_FILIAL		:= xFilial("ZAK")///OK
			ZAK->ZAK_NUMEDI		:= cNPdEDI///OK
			ZAK->ZAK_NUMALT		:= cpNumAlt///OK
			ZAK->ZAK_CLIFAT		:= cCliFat///OK
			ZAK->ZAK_LJFAT		:= cLjFat///OK
			ZAK->ZAK_ITEM		:= cItem ///OK
			ZAK->ZAK_EAN		:= cEan///OK
			ZAK->ZAK_PRODUT		:= cCodPro///OK
			ZAK->ZAK_LOCAL		:= cLocal///OK
			ZAK->ZAK_UM			:= cUnid///OK
			ZAK->ZAK_QTD		:= nQtd///OK
			ZAK->ZAK_UNID2		:= cUM2
			ZAK->ZAK_PRCUNI		:= nPrcUni///OK
			ZAK->ZAK_TOTAL		:= nTotIt///OK
			ZAK->ZAK_DTENT		:= dDtEnt///OK
			ZAK->ZAK_OPER		:= cOper///OK  		
			ZAK->ZAK_NCM		:= cNcm
			ZAK->ZAK_TES		:= cTes///OK 		
			ZAK->ZAK_CFOP		:= cCfOp///OK			
			ZAK->ZAK_CST	  	:= cCst///OK			
			ZAK->ZAK_DESC		:= nDesc///OK 
			ZAK->ZAK_VLRDES		:= nVlrDes///OK
			ZAK->ZAK_PERCIP		:= nPrIpi///OK
			ZAK->ZAK_VLRIPI		:= nVlrIpi///OK
			ZAK->ZAK_VLRDSP		:= nVlrDsp///OK			
			ZAK->ZAK_VLRFRT		:= nVlrFrt///OK
			ZAK->ZAK_PERICM		:= nPerIcm
			ZAK->ZAK_VLRICM		:= nValIcm
			ZAK->ZAK_DESCRI		:= cpDescri
					  					
   		EndIf 
		ZAK->(MsUnlock())    
				
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
ฑฑบFuncao    ณ KZImpSum	     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณImporta o sumario para o pre-pedido.	 					  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZImpSum() 

	Local nx  := 0 	

	nTotPed := Val(Alltrim(SubStr(FT_FReadLn(),108,13)+"."+SubStr(FT_FReadLn(),121,2)))
    //nTotPed := Val(Alltrim(SubStr(FT_FReadLn(),108,15)))
    //Valor Total do Pedido 	

	If Select("ZAJ") == 0
		DbSelectArea("ZAJ")
	EndIf
	ZAJ->(DbSetOrder(1))
	ZAJ->(dbGoTop())

	If ZAJ->(DbSeek(xFilial("ZAJ")+cpNumAlt+cCliFat+cLjFat))	
		If RecLock("ZAJ",.F.)	
		
			ZAJ->ZAJ_TOTFRT := nTotFrt
			ZAJ->ZAJ_TOTAL	:= nTotPed///OK 
						
		EndIf 
		ZAJ->(MsUnlock())	
	EndIf    	
	
	nTotFrt := 0
	If Select("ZAK") == 0 
		DbSelectArea("ZAK")
	EndIf
	ZAK->(DbSetOrder(1))  
	ZAK->(dbGoTop()) 
	
	For nx := 1 to Len(aItens)
		
   		nVlrSeg := (nVEncSeg*((aItens[nx][2]*100)/nTotPed)/100) 
		// Valor do Seguro	   
		
		If ZAK->(DbSeek(xFilial("ZAK")+cpNumAlt+cCliFat+cLjFat+aItens[nx][1]))
	  		If RecLock("ZAK",.F.)	
	  					
				ZAK->ZAK_VLRSEG := nVlrSeg///OK				
			  					
	   		EndIf 
			ZAK->(MsUnlock())    
					
		EndIf 
	Next nx		
	aItens := {}

Return
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZENVMAIL		 บAutor  ณAdam Diniz Lima 	  บ Data ณ24/05/2011   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia email para o vendedores e resp. da area sobre a alteracao  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ nlPos - Posicao do array de Email							   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | llRet - logico, informando sucesso no envio do email		       บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function KZENVMAIL(nlPos)

Local clMailServ	:= SuperGetMV("MV_RELSERV", .F., "") 	//servidor de envio de e-mails
Local llSmtpAuth  	:= SuperGetMV("MV_RELAUTH", .F., "")	//determina se o servidor requer autenticacao
Local clMailCont	:= SuperGetMV("MV_RELACNT", .F., "") 	//conta que enviara o e-mail
Local clMailSenh	:= SuperGetMV("MV_RELAPSW", .F., "")	//senha da conta que enviara o e-mail
Local clMailResp	:= SuperGetMV("KZ_MAILRES", .F., "")	//Endereco de Email separados por ";" dos responsaveis da area
Local llOk 			:= .F.
Local llAutOk 		:= .F.
Local llSendOk		:= .F.
Local llRet 		:= .F. 
Local llCond		:= .T.
Local alEmail		:= {}
Local clTitle		:= ""
Local clEmail		:= ""
Local nlTotal		:= 0
Local llFirst  		:= .T.
Local clMVend		:= Posicione("SA3",1,xFilial("SA3")+ap4Email[nlPos][4],"A3_EMAIL")  // Email do Vendedor

If Empty(clMailServ)
	Conout(dtoc( Date() ) + " " + Time() + " O servidor de e-mails nใo estแ preenchido no parโmetro MV_RELSERV.")
	llCond	:= .F.
ElseIf ValType(llSmtpAuth) <> "L"
	Conout(dtoc( Date() ) + " " + Time() + " Nใo foi informado se o servidor requer autentica็ใo no parโmetro MV_RELAUTH.")
	llCond	:= .F.
ElseIf Empty(clMailCont)
	Conout(dtoc( Date() ) + " " + Time() + " A conta de envio de e-mails nใo estแ preenchida no parโmetro MV_RELACNT.")
	llCond	:= .F.
ElseIf Empty(clMailSenh)
	Conout(dtoc( Date() ) + " " + Time() + " A senha da conta de envio de e-mails nใo estแ preenchida no parโmetro MV_RELAPSW.")
	llCond	:= .F.
Else
	llOk := .T.
EndIf

alEmail := Separa(clMailResp,";")
nlTotal := Len(alEmail)

While .T.
	If llFirst
		If !Empty(clMVend)
			clEmail := clMVend
		Else
			llFirst := .F.
		EndIf
	EndIf

	If !llFirst
		If nlTotal == 0 .Or. nlTotal == 1 .And. Empty(alEmail[nlTotal])
			Exit
		Else
			clEmail := alEmail[nlTotal]
			nlTotal--
		EndIf
	EndIf

	// Titulo do Email
	clTitle	:= "Importa็ใo de Altera็ใo Pedido EDI"

	//Monta corpo do ema
	clBody := "<b>Houve uma Importa็ใo realizada de uma Altera็ใo de determinado Pedido EDI, acesse a rotina de altera็ใo de pedidos EDI</b>" + CRLF
	clBody += "<b>Seguem Abaixo os Dados: </b> " + CRLF+ CRLF

	clBody += "N๚mero do Pedido EDI  		: " + Posicione("ZAE",2,xFilial("ZAE")+avKey(ap4Email[nlPos][1],"ZAE_NUMCLI")+avKey(ap4Email[nlPos][2],"ZAE_CLIFAT")+avKey(ap4Email[nlPos][3],"ZAE_LJFAT"),"ZAE_NUMEDI") 	+ CRLF
	clBody += "N๚mero do Pedido do Cliente 	: " + Posicione("ZAE",2,xFilial("ZAE")+avKey(ap4Email[nlPos][1],"ZAE_NUMCLI")+avKey(ap4Email[nlPos][2],"ZAE_CLIFAT")+avKey(ap4Email[nlPos][3],"ZAE_LJFAT"),"ZAE_NUMCLI") 	+ CRLF
	clBody += "C๓digo do Cliente			: " + ap4Email[nlPos][2]			+ CRLF
	clBody += "Loja do Cliente		 		: " + ap4Email[nlPos][3]			+ CRLF
	clBody += "Nome do Cliente		 		: " + Posicione("SA1",1,xFilial("SA1")+avKey(ap4Email[nlPos][2],"A1_COD")+avKey(ap4Email[nlPos][3],"A1_LOJA"),"A1_NREDUZ")	+ CRLF
	clBody += "Data da Ocorr๊ncia	 		: " + DtoC(dDataBase)	+ CRLF 	+ CRLF	+ CRLF
	clBody += "____________________________________________ " + CRLF
	clBody += "E-Mail Automแtico via Protheus  " + CRLF
	clBody += "Favor Nใo Responder  " + CRLF
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//| conecta uma vez com o servidor de e-mails                                        |
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
	If llCond
		If llOk
			CONNECT SMTP SERVER clMailServ ACCOUNT clMailCont PASSWORD clMailSenh RESULT llOk
		Else
			Conout(dtoc( Date() ) + " " + Time() + " Nใo foi possํvel estabelecer a conexใo com o servidor de e-mails. Parโmetro relacionado: MV_RELSERV.")
			llCond	:= .F.
		EndIf 
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//| efetua a autenticacao, conforme parametro                                        |
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
	If llCond
		If llSmtpAuth
			llAutOk := MailAuth(clMailCont, clMailSenh)
			If !llAutOK
				Conout(dtoc( Date() ) + " " + Time() + " Falha na autentica็ใo do usuแrio no servidor de e-mails. Parโmetro relacionado: MV_RELACNT.")
				llCond	:= .F.			
			EndIf
		Else
			llAutOk := .T.
		EndIf 
	EndIf	
	
	If llCond 		
		If llOk .And. llAutOk 
			SEND MAIL FROM clMailCont to clEmail SUBJECT clTitle BODY clBody RESULT llSendOk
			If !llSendOk
				Conout(dtoc( Date() ) + " " + Time() + " Nใo foi possํvel enviar o e-mail.")
				llCond	:= .F.
	    	Else
	    		llRet := .T.
			EndIf
		EndIf  
	EndIf	
		
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณdesconecta o servidor de e-mails	                                       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If llOk
		DISCONNECT SMTP SERVER
	EndIf 
	
	If llFirst
		llFirst := .F.
	EndIf
EndDo

Return llRet