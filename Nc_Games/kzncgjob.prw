#INCLUDE "PROTHEUS.CH" 
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZNCGJOB	     �Autor  �Vinicius Almeida	  �Data  � 16/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Schedule para importar arquivos da Neogrid para o Protheus  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�aParam - array com a empresa e a filial.						  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/ 
User Function KZNCGJOB(aParam)   
	
	/*Local cPathNG 	:= "" //Diretorio do arquivo vindo da Neogrid
	Local cPathPT 	:= "" //Diretorio do arquivo apos o processamento no Protheus 
	Local aArqNG	:= {} //Array com todos os arquivos contidos no diretorio de origem
	Local nHandle 	:= 0	
	Local nx		:= 0	
	Local lContinua := .T.
	Local nTentativa:= 0  
	Local alPDCons	:= {} //Recebe PEDIDOS JA CONSISTIDOS
	Local nlI		:= {}  
	Local clCurDir	:= ""
	Local clCliente	:= ""
	Local alCli		:= {}
	Local clBloq 	:= ""
	Local llIgual	:= .F.
	Local alArea	:= {}
	Local alPed		:= {}
	Local alPerImp	:= {}
	Local llPerm	:= .F.
	
	Private apConsPD:= {} //Enviar pedidos que SERAO Consistidos
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
	Private cTpFrt	:= "" //Condi��o de Entrega (tipo de frete)
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
    Private cCgcFat := "" //CNPJ do Local da Cobran�a da Fatura   
    Private cCgcCob := "" //CNPJ do Local da Cobran�a da Fatura    
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
	Private nVlrIpi := 0  //Valor Unit�rio do IPI	
	Private nVlrDsp := 0  //Valor Unit�rio da Despesa Acess�ria Tributada	
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
	Private cDescri := "" //Descricao do produto
	Private lAuto := IIF(Select("SM0") > 0, .f., .t.)
	Private lpCdPgPar:= .F. // Condicao de pagamento parcelada ?
	Private apCondPag:= {}

	Default aParam := {"01","03"} 

	IF LAUTO
		QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
		PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1,ZAE,ZAC,ZAF,SM0,SE4,ZAK,SB1,SF4,SFM' //USER 'ADMIN' PASSWORD 'Ncg@m1' 
	ENDIF
	//aParam := {"01","01"} Usar este na NcGames
	//RpcSetType(3) // TRAVA NESTA FUN��O // ALTERADO POR ERICH BUTTNER 01/08/12
	//RpcSetEnv(aParam[1],aParam[2]) 

	cPathNG := SuperGetMV("KZ_EDIENV", .T., "")
	cPathPT := SuperGetMV("KZ_EDIPROC", .T., "")
	
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
		Conout("Parametro nao preenchido: KZ_EDIENV") 
		Return
	EndIf
	If Empty(cPathPT)
		Conout("Parametro nao preenchido: KZ_EDIPROC")  
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
	
	aArqNG := Directory (cPathNG+"\*.ped",,Nil,.F.)
	
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
			//���������������������������������������������������������������������Ŀ
			//� Abre o arquivo texto e valida se conseguiu efetuar a abertura       �
			//�����������������������������������������������������������������������
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
		If Select("SA1") == 0
			dbSelectArea("SA1")
		EndIf
		SA1->(dbSetOrder(3))
		
		apCondPag := {}
		lpCdPgPar := .F.
		//Fazer enquanto n�o for fim de Arquivo
		Do While !FT_FEof()		 
			If SubStr(FT_FReadLn(),0,2) == "01"// Cabecalho
				SA1->(dbGoTop())
				If SA1->(dbSeek(xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14))))
					clBloq 		:= SA1->A1_MSBLQL
					clCliente	:= "Cliente: " + SA1->A1_COD + " - Loja: " + SA1->A1_LOJA
				EndIf
				If clBloq == "2" .OR. EMPTY(clBloq)
					cPedCom	:= Alltrim(SubStr(FT_FReadLn(),9,20))
					//Numero do Pedido do Comprador 
					cCliFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_COD")
					//CNPJ do Comprador 
					cLjFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_LOJA")
					//CNPJ do Comprador
					
					llIgual := .F.
					
					alArea := GetArea()
					DbSelectArea("ZAE")
					ZAE->(DbSetOrder(2))
					ZAE->(DbGoTop())
					If ZAE->(DbSeek(xFilial("ZAE")+avKey(cPedCom,"ZAE_NUMCLI")+avKey(cCliFat,"ZAE_CLIFAT")+avKey(cLjFat,"ZAE_LJFAT") ))
						While AllTrim(cPedCom) ==  AllTrim(ZAE->ZAE_NUMCLI) .And. AllTrim(cCliFat) == AllTrim(ZAE->ZAE_CLIFAT) .And. AllTRim(cLjFat) == AllTRim(ZAE->ZAE_LJFAT)
							If  ZAE->ZAE_STATUS != '7'
								llIgual := .T.
								Exit
							EndIf
							ZAE->(DbSkip())
						EndDo
					EndIf
					
					llPerm := U_KZVlTDoc(cCliFat,cLjFat,"01") // 01 -> ORDERS
					
					RestArea(alArea)
					
					If !llIgual .And. llPerm
						KZImpCabec()
					EndIf
				Else
				Conout(clCliente + " est� bloqueado.")
				EndIf
			EndIf
	 		If	!llIgual .And. (clBloq == "2" .OR. EMPTY(clBloq)) .And. llPerm
				If SubStr(FT_FReadLn(),0,2) == "02"// Pagamento
					KZImpPag()
				EndIf
				// Entrar� nessa rotina apenas se a condicao de pagamento for parcelada e ja ter varrido todos os registros 02
				If SubStr(FT_FReadLn(),0,2) == "03" .AND. lpCdPgPar 
					KZCNDPGTO()
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
				If llIgual
					If aScan(alPed, AllTrim(cPedCom)+AllTrim(cCliFat)+AllTrim(cLjFat)) == 0
						Conout( ProcName(0) + " Pedido ja existente para esse Cliente/Loja: "+ AllTrim(cCliFat)+"/"+AllTrim(cLjFat)+". O pedido desse cliente nao foi importado." + Time() )
						aAdd(alPed,AllTrim(cPedCom)+AllTrim(cCliFat)+AllTrim(cLjFat))
					EndIf
				ElseIf !llPerm
					If aScan(alPerImp, AllTrim(cPedCom)+AllTrim(cCliFat)+AllTrim(cLjFat)+"P") == 0
						Conout( ProcName(0) + " Cliente/Loja: "+ AllTrim(cCliFat)+"/"+AllTrim(cLjFat)+" N�o permite Importa��o de ORDERS. O pedido desse cliente nao foi importado." + Time() )
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
	
	Conout( ProcName(0)+" Fim da Execucao da Rotina Importacao de Pedido EDI: "+Time() )
		
	// Apos Finalizar o processamento no arquivo
	// chama-se a rotina para consistir o pedido
	// alterando assim seu status
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"|=====================================|"))
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"|  Inicio da Consistencia de Pedidos  |"))
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"|=====================================|"))
	alPDCons := U_KZNCG24(apConsPD)
	If Len(alPDCons) == 0
		Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"N�o houve atualiza��o de status em nenhum Pedido."))
	Else
		DbSelectArea("ZAE")
		ZAE->(DbSetOrder(1))
		For nlI := 1 to Len(alPDCons)
			ZAE->(DbGoTop())
	   		If ZAE->(DbSeek(xFilial("ZAE")+PadR(alPDCons[nlI][1],TamSx3("ZAE_NUMEDI")[1])+PadR(alPDCons[nlI][2],TamSx3("ZAE_CLIFAT")[1])+PadR(alPDCons[nlI][3],TamSx3("ZAE_LJFAT")[1]) ))
				If RecLock("ZAE",.F.)
					ZAE->ZAE_STATUS := alPDCons[nlI][4]
					ZAE->(MsUnlock())
				EndIf
				Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"Pedido: " + alPDCons[nlI][1] + " - Status Atualizado"))
			EndIf
		Next nlI
	EndIf
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"|======================================|"))
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"|Inconsistencias geradas na tabela ZAG |"))
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"| Fim da Consistencia de Pedidos       |"))
	Conout(OemToAnsi(dtoc( Date() )+" "+Time()+" "+"|======================================|"))	
	//Importacao do pedido sempre tera a revis�o como 001
	U_KZNCG19(1,apCbCopy,apItCopy) // Efetua uma copia identica dos pedidos importados na ZAH e ZAI 
	
	//RpcClearEnv()*/
Return     
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZImpCabec    �Autor  �Vinicius Almeida	  �Data  � 16/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Importa o cabecalho para o pre-pedido.					  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil															  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/
Static Function KZImpCabec()   

	cNPdEDI	:= U_KZFNum("ZAE","ZAE_NUMEDI")
	//Numeracao Sequencial 
					
	cCliFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_COD")
	//CNPJ do Comprador 
	
	cLjFat	:= Posicione("SA1",3,xFilial("SA1")+Alltrim(SubStr(FT_FReadLn(),181,14)),"A1_LOJA")
	//CNPJ do Comprador
	
	cTpPed	:= Alltrim(SubStr(FT_FReadLn(),6,3))
	//Tipo de Pedido     
	
	cPedCom	:= Alltrim(SubStr(FT_FReadLn(),9,20))
	//Numero do Pedido do Comprador 
	  
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
	//CNPJ do COMPRADOR 
    
    cCgcCob := Alltrim(SubStr(FT_FReadLn(),195,14))
    //CNPJ do Local da Cobran�a da Fatura   
    
    cCgcFor := Alltrim(SubStr(FT_FReadLn(),167,14))
    //CNPJ do Fornecedor 
    
    If aScan(apConsPD, {|z| AllTrim(z[1]) == cNPdEDI .And. AllTrim(z[2]) == cCliFat .And. AllTrim(z[3]) == cLjFat }) == 0
		aAdd(apConsPD,{cNPdEDI,cCliFat,cLjFat})
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
	
	If Select("ZAE") == 0
		DbSelectArea("ZAE")
	EndIf
	ZAE->(DbSetOrder(1))
	ZAE->(dbGoTop())	

	If ZAE->(!DbSeek(xFilial("ZAE")+cNPdEDI+cCliFat+cLjFat)) 
	
		If RecLock("ZAE",.T.)
		  
			ZAE->ZAE_FILIAL	:= xFilial("ZAE")///OK 
			ZAE->ZAE_TIPPED := "N"	   	
	   		ZAE->ZAE_TPNGRD	:= cTpPed///OK
	   		ZAE->ZAE_NUMEDI	:= cNPdEDI///OK
	   		ZAE->ZAE_NUMCLI	:= cPedCom///OK	   		 
	   		ZAE->ZAE_CLIFAT	:= cCliFat///OK
	   		ZAE->ZAE_LJFAT	:= cLjFat ///OK	   		
	   		ZAE->ZAE_CLIENT	:= cCliEnt///OK
	   		ZAE->ZAE_LJENT	:= cLjEnt///OK	   		
	   		ZAE->ZAE_TIPOCL	:= cTpCli///OK	   		 
	   		ZAE->ZAE_VEND	:= cVend ///OK	   		
	   		ZAE->ZAE_TRANSP	:= cTransp///OK	 	   		  		
	   		ZAE->ZAE_TPFRET	:= cTpFrt///OK	   			   			   	
	   		ZAE->ZAE_TABPRC	:= cTabPrc///OK	   		
	   		ZAE->ZAE_DTIMP	:= dDataBase///OK	   			   		
	   		ZAE->ZAE_DTPVCL	:= dDtPvCl///OK
	   		ZAE->ZAE_DTIENT	:= dDtInEt///OK	   			   		
	   		ZAE->ZAE_DTENTR	:= dDtEntr///OK	   		  
	   		ZAE->ZAE_CGCENT	:= cCgcEnt///OK
	   		ZAE->ZAE_CGCFAT	:= cCgcCob//cCgcFat///OK
	   		ZAE->ZAE_CGCCOB	:= cCgcCob///OK
	   		ZAE->ZAE_CGCFOR	:= cCgcFor///OK	
	   		
	  		EnviEDI(cNPdEDI,cPedCom,cCliFat,cLjFat)	   	
		EndIf
		ZAE->(MsUnlock())	
	EndIf
	
Return 
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZImpPag	     �Autor  �Vinicius Almeida	  �Data  � 16/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Importa as condicoes de pagamento para o pre-pedido.		  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil															  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/
Static Function KZImpPag()
	
	Local clCondPg	:= ""
	Local clRefData	:= ""
	Local clRfTmpDt := ""
	Local clTipoPer	:= ""
	Local nlNumPer	:= 0
	Local llGrava	:= .F.	
	
//	Private lpCdPgPar:= .F. // Condicao de pagamento parcelada ?
//	Private apCondPag:= {}
    
	If cTpPed <> "002" //Pedidos de Mercadorias Bonificadas  	

		clCondPg := Alltrim(SubStr(FT_FReadLn(),3,3))

		If clCondPg == "1" .Or. clCondPg == "21"
			clRefData := Alltrim(SubStr(FT_FReadLn(),6,3))
			If clRefData == "5"
				clRfTmpDt := Alltrim(SubStr(FT_FReadLn(),9,3))
				If clRfTmpDt == "1"
			 		clTipoPer := Alltrim(SubStr(FT_FReadLn(),12,3))	
			        If clTipoPer == "CD"
			        	If clCondPg == "21" // PARCELADO
			        		lpCdPgPar := .T.
			        		nlNumPer := Val(Alltrim(SubStr(FT_FReadLn(),15,3)))
				        	aAdd(apCondPag, AllTrim(Str(nlNumPer)))
			        	Else //clCondPg == "1"
			        		nlNumPer := Val(Alltrim(SubStr(FT_FReadLn(),15,3)))
				        	aAdd(apCondPag, AllTrim(Str(nlNumPer)))
				        	KZCNDPGTO()
			        	EndIf			        
			        Else
						llGrava := .T.				        
			        EndIf			
				Else
					llGrava := .T.	
				EndIf		
			Else
				llGrava := .T.			
			EndIf			
		Else
			llGrava := .T.
		EndIf
	EndIf
	
	If llGrava
		cCondPag := Posicione("SA1",1,xFilial("SA1")+avKey(Alltrim(cCliFat),"A1_COD")+avKey(Alltrim(cLjFat),"A1_LOJA"),"A1_COND")
		
		If Select("ZAE") == 0
			DbSelectArea("ZAE")
		EndIf
		ZAE->(DbSetOrder(1))
		ZAE->(dbGoTop())
	
		If ZAE->(DbSeek(xFilial("ZAE")+cNPdEDI+cCliFat+cLjFat))
			If RecLock("ZAE",.F.)
				ZAE->ZAE_CONDPA	:= cCondPag///OK
			EndIf 
			ZAE->(MsUnlock())
		EndIf
	EndIf
	
	
//   		cCondPag := Posicione("SE4",1,xFilial("SE4")+AvKey(Alltrim(SubStr(FT_FReadLn(),3,3)),"E4_CODIGO"),"E4_CODIGO")	
   		
//		If Empty(cCondPag)	
//			cCondPag := Posicione("SA1",1,xFilial("SA1")+avKey(Alltrim(cCliFat),"A1_COD")+avKey(Alltrim(cLjFat),"A1_LOJA"),"A1_COND")
// 		EndIf	

Return

Static Function KZCNDPGTO()
//apCondPag
	Local clQry		:= ""
	Local nlI		:= 0
	Local clCond	:= ""
	Local clCod		:= ""
	
	clQry := " SELECT E4_CODIGO, E4_COND FROM " + RetSqlName("SE4") 
	clQry += " WHERE D_E_L_E_T_ <> '*' "
	clQry += " AND E4_FILIAL = '"+xFilial("SE4")+"' "
	clQry += " AND E4_XEDI = '1' "
	
	clQry := ChangeQuery(clQry)
	
	If Select("CONDPG") > 0
		CONDPG->(dbCloseArea())
	EndIf
	                                                                 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQry), "CONDPG" ,.T.,.F.)
	
	For nlI := 1 to Len(apCondPag)
		If Empty(clCond)
			clCond := AllTrim(apCondPag[nlI])
		Else
		    clCond := ","+AllTrim(apCondPag[nlI])
		EndIf
	Next nlI
	
	While CONDPG->(!Eof())
		If AllTrim(clCond) == AllTrim(CONDPG->E4_COND)
			clCod := CONDPG->E4_CODIGO
			Exit
		EndIf
		CONDPG->(DbSkip())
	EndDo
	CONDPG->(DbCloseArea())
	
	If !Empty(clCod)
		cCondPag := clCod
	Else
		cCondPag := Posicione("SA1",1,xFilial("SA1")+avKey(Alltrim(cCliFat),"A1_COD")+avKey(Alltrim(cLjFat),"A1_LOJA"),"A1_COND")
	EndIf

	If Select("ZAE") == 0
		DbSelectArea("ZAE")
	EndIf
	ZAE->(DbSetOrder(1))
	ZAE->(dbGoTop())
	
	If ZAE->(DbSeek(xFilial("ZAE")+cNPdEDI+cCliFat+cLjFat))
		If RecLock("ZAE",.F.)
			ZAE->ZAE_CONDPA	:= cCondPag///OK
		EndIf 
		ZAE->(MsUnlock())
	EndIf

Return 
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZImpDesc     �Autor  �Vinicius Almeida	  �Data  � 16/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Importa os descontos para o pre-pedido.  					  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil															  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/
Static Function KZImpDesc()  

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

	If Select("ZAE") == 0
		DbSelectArea("ZAE")
	EndIf
	ZAE->(DbSetOrder(1))
	ZAE->(dbGoTop())

	If ZAE->(DbSeek(xFilial("ZAE")+cNPdEDI+cCliFat+cLjFat))	
		If RecLock("ZAE",.F.)	
		     
	   		ZAE->ZAE_DESCFI:= nDesFin///OK 
			ZAE->ZAE_DESC1 := nDesc1 ///OK  
	   		ZAE->ZAE_DESC2 := nDesc2 ///OK
	   		ZAE->ZAE_DESC3 := nDesc3 ///OK
	   		ZAE->ZAE_DESC4 := nDesc4 ///OK		
			
		EndIf 
		ZAE->(MsUnlock())	
	EndIf
	
Return  
/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZImpItens    �Autor  �Vinicius Almeida	  �Data  � 16/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Importa os itens para o pre-pedido.						  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil															  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/
Static Function KZImpItens()
      
	cItem	:= Alltrim(SubStr(FT_FReadLn(),3,4))
	//Numero Sequencial da Linha de Item 
	cItem := RetAsc(cItem,TamSx3("ZAK_ITEM")[1],.T.)
	// Tratamento para que o valor do item se transforme em 2 caracteres, caso ultrapasse o 100 ele come�a a numera��o por: 100 = A0 e assim por diante

	cEan  	:= Alltrim(SubStr(FT_FReadLn(),18,14))
	//Codigo do Produto
	
	cCodPro := Posicione("SB1",5,xFilial("SB1")+Alltrim(SubStr(FT_FReadLn(),18,14)),"B1_COD")
	//Codigo do Produto
	
	cLocal	:= Posicione("SB1",5,xFilial("SB1")+Alltrim(SubStr(FT_FReadLn(),18,14)),"B1_LOCPAD")
	//Codigo do Produto	
	
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
	
	nTotIt	:= Val(Alltrim(SubStr(FT_FReadLn(),168,13)+"."+SubStr(FT_FReadLn(),181,2)))//(nPrcUni * nQtd)
	//Total do item = Preco Liquido Unitario * Quantidade do Item  
	
	dDtEnt := CTOD('  /  /  ')
	//Data de Entrega Nc Games  
	
	cOper  := cTipoOp
	//Tipo de Operacao  
	
	cTes := MaTesInt(2,cOper,cCliFat,cLjFat,"C",cCodPro,NIL)  
	//cTes := "501"
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
	
	//Valor Unit�rio do IPI	
	nVlrIpi := Val(Alltrim(SubStr(FT_FReadLn(),241,13)+"."+SubStr(FT_FReadLn(),254,2)))
	//nVlrIpi := Val(Alltrim(SubStr(FT_FReadLn(),241,15)))
	
	//Aliquota de IPI	
	nPrIpi  := Val(Alltrim(SubStr(FT_FReadLn(),256,3)+"."+SubStr(FT_FReadLn(),259,2)))
	//nPrIpi  := Val(Alltrim(SubStr(FT_FReadLn(),256,5)))

	
   	nVlrDsp := Val(Alltrim(SubStr(FT_FReadLn(),261,13)+"."+SubStr(FT_FReadLn(),274,2)))
	//nVlrDsp := Val(Alltrim(SubStr(FT_FReadLn(),261,15)))
	//Valor Unit�rio da Despesa Acess�ria Tributada	 
	
	nVlrFrt := Val(Alltrim(SubStr(FT_FReadLn(),291,13)+"."+SubStr(FT_FReadLn(),304,2)))
	//nVlrFrt := Val(Alltrim(SubStr(FT_FReadLn(),291,15)))
	//Valor de Encargo de Frete 
	
	nTotFrt += nVlrFrt 
	
	//���������������������������������������������Ŀ
	//�Inicializa a funcao fiscal                   �
	//�����������������������������������������������
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
  
	//nPerIcm := MaFisRet(1,'IT_ALIQICM')
	//nValIcm := MaFisRet(1,'IT_VALICM')
	
	nPerIcm := MaFisRet(1,'IT_ALIQSOL')
	nValIcm := MaFisRet(1,'IT_BASEICM')*(nPerIcm/100)
	nValIcm := MaFisRet(1,'IT_VALSOL')
	// Encerra a funcao fiscal
	MaFisEnd()
	MaFisRestore()  
	

	aAdd(aItens,{cItem,nTotIt})
	
	If aScan(apCbCopy, {|z| AllTrim(z[1]) == AllTrim(cNPdEDI) .And. AllTrim(z[2]) == AllTrim(cCliFat) .And. AllTrim(z[3]) == AllTrim(cLjFat)}) == 0
		aAdd(apCbCopy,{cNPdEDI,cCliFat,cLjFat})
	EndIf	 
	
	If aScan(apItCopy, {|z| AllTrim(z[1]) == AllTrim(cNPdEDI) .And. AllTrim(z[2]) == AllTrim(cCliFat) .And. AllTrim(z[3]) == AllTrim(cLjFat) .And. AllTrim(z[4]) == AllTrim(cItem)}) == 0
		aAdd(apItCopy,{cNPdEDI,cCliFat,cLjFat,cItem})
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

    cDescri := Alltrim(SubStr(FT_FReadLn(),32,40))

	If Select("ZAF") == 0
		DbSelectArea("ZAF")
	EndIf
	ZAF->(DbSetOrder(1))
	ZAF->(dbGoTop())  
	
	//'ZAF_FILIAL+ZAF_NUMEDI+ZAF_REVISA+ZAF_CLIFAT+ZAF_LJFAT+ZAF_ITEM'
	If ZAF->(!DbSeek(xFilial("ZAF")+avKey(cNPdEDI,"ZAF_NUMEDI")+PadR(" ",TamSx3("ZAF_REVISA")[1])+avKey(cCliFat,"ZAF_CLIFAT")+avKey(cLjFat,"ZAF_LJFAT")+avKey(cItem,"ZAF_ITEM"))) 	
  		If RecLock("ZAF",.T.)

			ZAF->ZAF_FILIAL		:= xFilial("ZAF")///OK  
			ZAF->ZAF_NUMEDI		:= cNPdEDI///OK 				
			ZAF->ZAF_CLIFAT		:= cCliFat///OK
			ZAF->ZAF_LJFAT		:= cLjFat///OK  						
			ZAF->ZAF_ITEM		:= cItem ///OK 			
			ZAF->ZAF_EAN		:= cEan///OK 			
			ZAF->ZAF_PRODUT		:= cCodPro///OK								
			ZAF->ZAF_LOCAL		:= cLocal///OK		
			ZAF->ZAF_UM			:= cUnid///OK			
			ZAF->ZAF_QTD		:= nQtd///OK   
			ZAF->ZAF_UNID2		:= cUM2
			//ZAF_QTD2						
			ZAF->ZAF_PRCUNI		:= nPrcUni///OK 
		   	ZAF->ZAF_TOTAL		:= nTotIt///OK		   	
			ZAF->ZAF_DTENT		:= dDtEnt///OK 	 
			ZAF->ZAF_NCM		:= cNcm
			ZAF->ZAF_OPER		:= cOper///OK  		
			ZAF->ZAF_TES		:= cTes///OK 		
			ZAF->ZAF_CFOP		:= cCfOp///OK			
			ZAF->ZAF_CST	  	:= cCst///OK			
			ZAF->ZAF_DESC		:= nDesc///OK 
			ZAF->ZAF_VLRDES		:= nVlrDes///OK
			ZAF->ZAF_PERCIP		:= nPrIpi///OK
			ZAF->ZAF_VLRIPI		:= nVlrIpi///OK
			ZAF->ZAF_VLRDSP		:= nVlrDsp///OK			
			ZAF->ZAF_VLRFRT		:= nVlrFrt///OK 
			ZAF->ZAF_PERICM		:= nPerIcm
			ZAF->ZAF_VLRICM		:= nValIcm
	   		ZAF->ZAF_DESCRI		:= cDescri
	   		ZAF->ZAF_SEQ		:= '001'
   		EndIf 
		ZAF->(MsUnlock())    
				
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
���Funcao    �KZFNum		 �Autor  �Rodrigo A. Tosin    � Data � 09/03/2011  ���
������������������������������������������������������������������������������͹��
���Desc.     �Gera numero sequencial da tabela especificada			 	   	   ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�cAlias,cCampo													   ���  
������������������������������������������������������������������������������͹��
���Retorno   �clNumero 							                               ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

User Function KZFNum(cAlias,cCampo) 

	Local alArea	:= GetArea()
	Local clNumero	:= ""
	cAlias 			:= UPPER(cAlias)        
	cCampo 			:= UPPER(cCampo) 
	
		If &(cAlias) -> (FieldPos(cCampo)) > 0
		 
			DBSelectArea(cAlias)
			
				&(cAlias) -> (DBSetOrder(1))
				&(cAlias) -> (DBGoBottom())
								
				If &(cAlias) -> (EOF())
					If ValType((cAlias) -> &(cCampo)) == "C"                                                                            
						clNumero := STRZERO(1,TAMSX3(cCampo)[1])
					ElseIf ValType((cAlias) -> &(cCampo)) == "N" 
						clNumero := 1					
					ElseIf ValType((cAlias) -> &(cCampo)) == "D"
						clNumero := Date()					 	
					Else
						ShowHelpDlg("Campo", {"Campo " + cCampo + " n�o suportado pela fun��o.",""},5,{"Escolha um campo que seja Caracter (C), Num�rico (N) ou Data (D)."	,""},5)			 				 		
						Return	
					EndIf									
				Else   
					If ValType((cAlias) -> &(cCampo)) == "C"
						clNumero := Soma1((cAlias) -> &(cCampo),TAMSX3(cCampo)[1]) 
					ElseIf ValType((cAlias) -> &(cCampo)) == "N"  
						clNumero := VAL(Soma1(cValToChar((cAlias) -> &(cCampo)),TAMSX3(cCampo)[1]))
					ElseIf ValType((cAlias) -> &(cCampo)) == "D"  
						clNumero := ((cAlias) -> &(cCampo) + 1)
					Else
						ShowHelpDlg("Campo", {"Campo " + cCampo + " n�o suportado pela fun��o.",""},5,{"Escolha um campo que seja Caracter (C), Num�rico (N) ou Data (D)."	,""},5)			 				 		
						Return	
					EndIf	
				EndIf 
				    		
		Else	
		
			ShowHelpDlg("Campo n�o existente", {"Campo " + cCampo + " n�o existe no sistema.",""},5,{"Escolha um campo v�lido.",""},5)			 				 		
			Return	
					  	
		EndIf 
				
	RestArea(alArea)

Return clNumero   

/*
���������������������������������������������������������������������������������
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������ͻ��
���                ___  "  ___                             					  ���
���              ( ___ \|/ ___ ) Kazoolo                   					  ���
���               ( __ /|\ __ )  Codefacttory 								  ���
�����������������������������������������������������������������������������͹��
���Funcao    � KZImpSum	     �Autor  �Vinicius Almeida	  �Data  � 16/05/2012 ���
�����������������������������������������������������������������������������͹��
���Desc.     �Importa o sumario para o pre-pedido.	 					  	  ���
�����������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                     	  ���
�����������������������������������������������������������������������������͹��
���Parametros�Nil															  ���
�����������������������������������������������������������������������������͹��
���Retorno   �Nil						   									  ���
�����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������� 
��������������������������������������������������������������������������������� 
*/
Static Function KZImpSum() 

	Local nx  := 0 	
    
	nTotPed := Val(Alltrim(SubStr(FT_FReadLn(),108,13)+"."+SubStr(FT_FReadLn(),121,2)))
    //nTotPed := Val(Alltrim(SubStr(FT_FReadLn(),108,15)))
    //Valor Total do Pedido 	

	If Select("ZAE") == 0
		DbSelectArea("ZAE")
	EndIf
	ZAE->(DbSetOrder(1))
	ZAE->(dbGoTop())
	
	If ZAE->(DbSeek(xFilial("ZAE")+cNPdEDI+cCliFat+cLjFat))
		If RecLock("ZAE",.F.)
			
			ZAE->ZAE_TOTFRT := nTotFrt
			ZAE->ZAE_TOTAL  := nTotPed///OK
			
		EndIf
		ZAE->(MsUnlock())
	EndIf
	
	nTotFrt := 0
	
	If Select("ZAF") == 0
		DbSelectArea("ZAF")
	EndIf
	ZAF->(DbSetOrder(1))
	ZAF->(dbGoTop())
	
	For nx := 1 to Len(aItens)
		
		nVlrSeg := (nVEncSeg*((aItens[nx][2]*100)/nTotPed)/100) 
		// Valor do Seguro
		
		If ZAF->(DbSeek(xFilial("ZAF")+cNPdEDI+PadR(" ",TamSx3("ZAF_REVISA")[1])+cCliFat+cLjFat+aItens[nx][1]))
			If RecLock("ZAF",.F.)
				
				ZAF->ZAF_VLRSEG := nVlrSeg///OK
				
			EndIf 
			ZAF->(MsUnlock())
			
		EndIf
	Next nx	
	aItens := {}

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �KZNCGJOB  �Autor  �Microsiga           � Data �  01/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function EnviEDI(cNPdEDI,cPedCom,cCliFat,cLjFat)  

Local cAreaAtu	:= GetArea()
Local cAreaSA1	:= SA1->(GetArea())
Local cHtml 	:= ""
Local cEmails 	:= "lfelipe@ncgames.com.br"
Local cAssunto 	:= "Inclus�o de EDI " + DtoC(Date()) + " - " + time()
Local cFrom		:= "workflow@ncgames.com.br"

SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+cCliFat+cLjFat))

cHtml +=" <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> "+CRLF
cHtml +=" <html xmlns='http://www.w3.org/1999/xhtml'>"+CRLF
cHtml +=" <head>"+CRLF
cHtml +=" <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"+CRLF
cHtml +=" <title>Documento sem título</title>"+CRLF
cHtml +=" <style type='text/css'>"+CRLF
cHtml +=" .CABEC {"+CRLF
cHtml +=" 	font-family: Tahoma;"+CRLF
cHtml +=" 	font-size: 36px;"+CRLF
cHtml +=" 	color: #999;"+CRLF
cHtml +=" }"+CRLF
cHtml +=" .CABEC {"+CRLF
cHtml +=" 	font-size: 36px;"+CRLF
cHtml +=" 	font-family: Tahoma;"+CRLF
cHtml +=" }"+CRLF
cHtml +=" .cabec_1 {"+CRLF
cHtml +=" 	font-family: 'Comic Sans MS', cursive;"+CRLF
cHtml +=" }"+CRLF
cHtml +=" </style>"+CRLF
cHtml +=" </head>"+CRLF
cHtml +=" <body><table width='95%'><tr><td><table width='95%'><tr><td class='CABEC'><p>WORKFLOW PROTHEUS NC GAMES</p></td></tr>"+CRLF
cHtml +=" <tr><td class='cabec_1'></td></tr>"+CRLF
cHtml +=" <tr><td class='cabec_1'>Aviso de inclus�o de pedido EDI</td></tr>"+CRLF
cHtml +=" <tr><td><hr /></td></tr>"+CRLF
cHtml +=" <tr><td><p>N�mero do Pedido EDI : "+cNPdEDI+"<br />"+CRLF
cHtml +="             N�mero do Pedido do Cliente : "+cPedCom+"<br />"+CRLF
cHtml +="             C�digo do Cliente : "+cCliFat+"<br />"+CRLF
cHtml +="             Loja do Cliente : "+cLjFat+"<br />"+CRLF
cHtml +="             Nome do Cliente : "+AllTrim(SA1->A1_NREDUZ)+"<br />"+CRLF
cHtml +="             Data da Ocorr�ncia : "+DtoS(MsDate())+"</p>"+CRLF
cHtml +=" <p>&nbsp;</p></td></tr>"+CRLF
cHtml +="     </table></td>"+CRLF
cHtml +="   </tr>"+CRLF
cHtml +=" </table>"+CRLF
cHtml +=" <p>&nbsp;</p>"+CRLF
cHtml +=" </body>"+CRLF
cHtml +=" </html>"+CRLF

cEmails:= Posicione("SA3",1,xFilial("SA3")+SA1->A1_VEND,"A3_EMAIL")

EdiSend(cFrom,cEmails,cAssunto,cHtml) 

RestArea(cAreaAtu)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �KZNCGJOB  �Autor  �Microsiga           � Data �  01/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static function EdiSend(cFrom,cPara,cAssunto,cBody)

Local cUser := GetNewPar("MV_RELACNT","")
Local cPass := GetNewPar("MV_RELAPSW","")
Local cSendSrv := GetNewPar("MV_RELSERV","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Local nSmtpPort := GetNewPar("MV_GCPPORT","")
Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)

Local xRet
Local oServer, oMessage

Default cFrom := "lfelipe@ncgames.com.br"
Default cPara := "lfelipe@ncgames.com.br"
Default cAssunto := "Teste Send"
Default cBody := "Teste send"  

If At(":",cSendSrv) > 0
	cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
EndIf
                          
oServer := TMailManager():New()
oServer:SetUseSSL( lSSL )
oServer:SetUseTLS( lTLS) //ADD 23/06/2016 -- configura��o de gmail
oServer:Init( "", cSendSrv, cUser, cPass, , nSmtpPort )

// estabilish the connection with the SMTP server
xRet := oServer:SMTPConnect()
if xRet <> 0
	cMsg := "Could not connect on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	return
endif

// authenticate on the SMTP server (if needed)
xRet := oServer:SmtpAuth( cUser, cPass )
if xRet <> 0
	cMsg := "Could not authenticate on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	oServer:SMTPDisconnect()
	return
endif

oMessage := TMailMessage():New()
oMessage:Clear()

//oMessage:cDate := cValToChar( Date() )
oMessage:cFrom		:= cFrom
oMessage:cTo		:= cPara
oMessage:cSubject	:= cAssunto
oMessage:cBody		:= cBody
// Adiciona um anexo, nesse caso a imagem esta no root
//oMessage:AttachFile( cStarFolder+cNameFile )

xRet := oMessage:Send( oServer )
if xRet <> 0
	cMsg := "Could not send message: " + oServer:GetErrorString( xRet )
	conout( cMsg )
endif

xRet := oServer:SMTPDisconnect()
if xRet <> 0
	cMsg := "Could not disconnect from SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
endif 

return
