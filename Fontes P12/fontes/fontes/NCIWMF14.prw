#Include 'Protheus.ch'
#INCLUDE "PROTHEUS.CH"
#define STR0001 If( cPaisLoc $ "ANG|PTG", "Emiss�o De Factura Para Cart�o De Contribuinte", "Emiss�o de Nota Fiscal para Cupom Fiscal" )
#define STR0002 If( cPaisLoc $ "ANG|PTG", "Este programa tem a fun��o de emitir Factura com base em um Tal�o Fiscal j�", "Este programa tem a fun��o de emitir Nota Fiscal com base em um Cupom Fiscal j�" )
#define STR0003 If( cPaisLoc $ "ANG|PTG", "Emitido na venda, tendo em conta o decreto 4.373-n de 02/12/1998. para tal, ser�", "emitido na Venda atendendo ao Decreto 4.373-N de 02/12/1998. Para tanto, ser�" )
#define STR0004 If( cPaisLoc $ "ANG|PTG", "Utilizado o script de factura gravado no par�metro  mv_scrnfcp (" + getmv ( "mv_scrnfcp" ) + ")", "utilizado o script de Nota Fiscal gravado no Parametro MV_SCRNFCP (" + GetMv ( "MV_SCRNFCP" ) + ")" )
#define STR0005 "Especial"
#define STR0006 If( cPaisLoc $ "ANG|PTG", "Administra��o", "Administracao" )
#define STR0007 If( cPaisLoc $ "ANG|PTG", "Factura", "Nota Fiscal" )
#define STR0008 If( cPaisLoc $ "ANG|PTG", "N�o se pode gerar uma factura para um cart�o que j� pertence a uma factura global (", "Nao se pode gerar uma nota fiscal para um cupom que ja pertence a uma nota fiscal global (" )
#define STR0009 If( cPaisLoc $ "ANG|PTG", "J� existe uma factura (", "Ja existe uma Nota Fiscal (" )
#define STR0010 If( cPaisLoc $ "ANG|PTG", ") gerada para o cart�o ", ") gerada para o Cupom " )
#define STR0011 If( cPaisLoc $ "ANG|PTG", " N�o E Poss�vel Gerar Outra Factura Para O Mesmo Cart�o De Contribuinte", " Nao e possivel gerar outra Nota Fiscal para o mesmo Cupom Fiscal" )
#define STR0012 If( cPaisLoc $ "ANG|PTG", "Aten��o", "Atenc�o" )
#define STR0013 If( cPaisLoc $ "ANG|PTG", "J� foi criada uma factura para esse cart�o de contribuinte.", "Ja foi gerado uma nota fiscal para esse cupom fiscal." )
#define STR0014 "Ok"
#define STR0015 If( cPaisLoc $ "ANG|PTG", "Digite o cliente para a notifica��o", "Digite o cliente para a nota" )
#define STR0016 "Cliente    ?"
#define STR0017 If( cPaisLoc $ "ANG|PTG", "O cliente n�o tem rcf.; n�o ser� poss�vel passar factura.", "Cliente n�o tem RCF. N�o sera poss�vel realizar a fatura." )
#define STR0018 "Aten��o"
#define STR0019 If( cPaisLoc $ "ANG|PTG", "Cliente N�o Digitado Ou N�o Existe No Registo De Clientes", "Cliente n�o informado ou n�o existe no cadastro de Clientes" )
#define STR0020 If( cPaisLoc $ "ANG|PTG", "Digite a loja para notifica��o", "Digite a loja para a nota" )
#define STR0021 "Loja       ?"
#define STR0022 "A f�rmula (F4_FORMULA) utilizada na TES ("
#define STR0023 If( cPaisLoc $ "ANG|PTG", ") de artigo, informado no par�metro MV_TESNOTA,", ") de produto, informado no par�metro MV_TESNOTA," )
#define STR0024 " deve ter o conte�do de 'S' ou em branco."
#define STR0025 If( cPaisLoc $ "ANG|PTG", "O campo de F�rmula (F4_FORMULA), do registo de TES (", "O campo de Formula (F4_FORMULA) do cadastro de TES (" )
#define STR0026 " deve ter uma f�rmula cadastrada."
#define STR0027 If( cPaisLoc $ "ANG|PTG", "O campo L.Fisc. ICMS (F4_LFICM) do registo da TES (", "O campo L.Fisc. ICMS (F4_LFICM) do cadastro da TES (" )
#define STR0028 " deve ser diferente de 'N'."
#define STR0029 If( cPaisLoc $ "ANG|PTG", "TES, ", "TES " )
#define STR0030 If( cPaisLoc $ "ANG|PTG", "informado no par�metro MV_TESNOTA, n�o est� cadastrada na tabela de Tipos de Entrada e Sa�das.", ", informado no par�metro MV_TESNOTA, n�o est� cadastrada na tabela de Tipos de Entrada e Sa�das." )
#define STR0031 If( cPaisLoc $ "ANG|PTG", ") de artigo, informado no par�metro MV_LJNCUPS, ", ") de servi�o, informado no par�metro MV_LJNCUPS, " )
#define STR0032 "O campo C�lcula ISS (F4_ISS) do cadastro da TES ("
#define STR0033 " deve estar como 'S'."
#define STR0034 If( cPaisLoc $ "ANG|PTG", "O campo L.Fisc. ISS (F4_LFISS) do registo da TES (", "O campo L.Fisc. ISS (F4_LFISS) do cadastro da TES (" )
#define STR0035 If( cPaisLoc $ "ANG|PTG", "informado no par�metro MV_LJNCUPS, n�o est� registrada na tabela de Tipos de Entrada e Sa�das.", ", informado no par�metro MV_LJNCUPS, n�o est� cadastrada na tabela de Tipos de Entrada e Sa�das." )
#define STR0036 If( cPaisLoc $ "ANG|PTG", "Os par�metros MV_TESNOTA e MV_LJNCUPS n�o est�o preenchidos correctamente.", "Os par�metros MV_TESNOTA e MV_LJNCUPS n�o est�o preenchidos corretamente." )
#define STR0037 If( cPaisLoc $ "ANG|PTG", "A configura��o das TES de artigo e servi�o n�o est�o corretas. Verificar:", "A configuracao das TES de produto e servi�o n�o est�o corretas. Verificar:" )
#define STR0038 If( cPaisLoc $ "ANG|PTG", "Por favor, regularize as situa��es acima para prosseguir na emiss�o da fact.sobre cupom.", "Por favor, regularize as situa��es acima para prosseguir na emiss�o da nota sobre cupom." )
#define STR0039 If( cPaisLoc $ "ANG|PTG", "Emiss�o de nota sobre cupom - Livro Fiscal OnLine", "Emiss�o de Nota sobre Cupom - Livro Fiscal OnLine" )
#define STR0040 If( cPaisLoc $ "ANG|PTG", "Emiss�o de Factura Sobre Tal�o", "Emiss�o de Nota Sobre Cupom" )
#define STR0041 "Pesquisar"
#define STR0042 "Processar"
#define STR0043 If( cPaisLoc $ "ANG|PTG", "N�o existem registos para serem apresentados com esses par�metros.", "N�o existem registros para serem apresentados com esses par�metros." )
#define STR0044 If( cPaisLoc $ "ANG|PTG", "Gerar Factura Sobre Tal�o", "Gerar Nota Sobre Cupom" )
#define STR0045 If( cPaisLoc $ "ANG|PTG", "Estornar Factura Sobre Tal�o", "Estornar Nota Sobre Cupom" )
#define STR0046 "Deseja realmente executar: "
#define STR0047 If( cPaisLoc $ "ANG|PTG", "Aguarde...a executar processo...", "Aguarde...executando processo..." )
#define STR0048 If( cPaisLoc $ "ANG|PTG", "Nenhum registo seleccionado...", "Nenhum registro selecionado..." )
#define STR0049 If( cPaisLoc $ "ANG|PTG", "Confirma a gera��o do comprovante fiscal digital ?", "Confirma a geracao do comprovante fiscal digital ?" )
#define STR0050 If( cPaisLoc $ "ANG|PTG", " - Deseja estornar/excluir esta Fact. sobre Cup�o?", " - Deseja estornar/excluir esta NF sobre Cupom?" )
#define STR0051 "Exclus�o conclu�da"
#define STR0052 If( cPaisLoc $ "ANG|PTG", "Factura sobre Cup�o exclu�da com Sucesso !", "Nota Fiscal sobre Cupom exclu�da com Sucesso !" )
#define STR0053 If( cPaisLoc $ "ANG|PTG", "Por favor, informe o cliente e a loja referentes ao n�mero do cup�o fiscal: ", "Favor informar o cliente e a loja referentes ao n�mero do cupom fiscal: " )
#define STR0054 If( cPaisLoc $ "ANG|PTG", " Somente � poss�vel alterar o cliente e a loja caso o cup�o fiscal tenha sido gerado para o cliente e loja padr�o. ", " Somente � poss�vel alterar o cliente e a loja caso o cupom fiscal tenha sido gerado para o cliente e loja padr�o. " )
#define STR0055 "Para o cliente"
#define STR0056 "Para a loja"
#define STR0057 If( cPaisLoc $ "ANG|PTG", "N�o � permitida a impress�o de Factura para o cliente padr�o", "N�o � permitido a impress�o de Nota Fiscal para o cliente padr�o" )
#define STR0058 If( cPaisLoc $ "ANG|PTG", "N�o foi poss�vel excluir a factura pois o prazo definido para cancelamento foi de ", "N�o foi poss�vel excluir a nota, pois o prazo definido para cancelamento foi de " )
#define STR0059 " hora(s)."
#define STR0060 "Deseja realizar a impress�o da fatura de venda?"
#define STR0061 "Aguarde...Restaurando os registros."


//Posicoes do array aLivro
#DEFINE _LFTES     1
#DEFINE _LFCF      2
#DEFINE _LFALQIMP  3
#DEFINE _LFVALCONT 4

STATIC lFisLivro	:= (SuperGetMV("MV_LJLVFIS",,1) == 2)		// Utiliza novo conceito para geracao do SF3
STATIC lMultiplo	:= (SuperGetMV("MV_LJ130MN",,.F.) == .T.)		// Permite gerar uma nota para multiplos cupons
STATIC lLegislacao	:= (((LjAnalisaLeg(43)[1] .OR. lMultiplo) .AND. cPaisLoc == "BRA") .OR. (cPaisLoc  == "MEX" .AND. SA1->(FieldPos("A1_MODCFD")) > 0 )) .AND. AliasInDic("MDL")
Static lIsMexico	:= cPaisLoc == "MEX"
Static lRelMacroMex	:= cPaisLoc == "MEX" .AND. (Substr(SuperGetMV("MV_SCRNFCP"),1,1) == "&")
Static cMexNota		:= ""									//Numero da nota para impress�o da nota no Mexico
Static cMexSerie	:= ""									//Serie da nota no Mexico
Static aMexRegSF2	:= {}									//Contem registros da SF2 para o Mexico
Static lConfProc	:= .F.									//Variavel que controla se foi confirmado o processamento das notas



User Function NCIWMF14()
	Local oBrowse:=FwMbrowse():New()
	Local cFiltro:="@ L1_SERIE='ECF' "
	Private cCadastro:=OemToAnsi(" NF sobre Cupom")
	Private aRotina := {}
	
	
	AADD(aRotina,{"Pesquisar"			,"AxPesqui"	   ,0,1})
	AADD(aRotina,{"Visualizar"			,"AxVisual" ,0,2})
	AADD(aRotina,{"Gerar NF"			,"U_WMF14NF()" ,0,4})
	
	oBrowse:SetAlias("SL1")
	oBrowse:SetDescription(cCadastro)
	oBrowse:SetFilterDefault(cFiltro)
	oBrowse:Activate()
	
	
Return

User Function WMF14NF()
	Local aAreaAtu:=GetArea()
	
	Local aMvs:={mv_par01,mv_par02}
	Local aParamBox:={}
	Local aParams  :={}
	Local cFunName
	Local aParam   := {{"","","",""}}            //Array do Cabe�alho do Or�amento
	
	Private lMsErroAuto := .F.            // Variavel que informa a ocorr�ncia de erros no ExecAuto
	
	Private cCodCli:=SL1->L1_CLIENTE
	Private cLojCLi:=SL1->L1_LOJA
	Private cNumProxNf:=""
	
	
	AADD(aParamBox,{1,"Cliente"		,cCodCli	,"@!"	,"IIf(ExistCpo('SA1'),(mv_par02:=SA1->A1_LOJA,.T.),.F.)","SA1","",35,.T.})
	AADD(aParamBox,{1,"Loja"		,cLojCLi	,"@!"	,,,"",35,.T.})
	
	Do While .T.
		
		If !ParamBox(aParamBox, "Par�metros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .f., .f.)
			Return
		EndIf
		
		If !ExistCpo('SA1',aParams[1]+aParams[2])
			Loop
		EndIf
		
		cCodCli:=aParams[1]
		cLojCLi:=aParams[2]
		
		
		Exit
		
	EndDo
	mv_par01:=aMvs[1]
	mv_par02:=aMvs[2]
	
	//Indica inclus�o
	lMsHelpAuto := .T.
	lMsErroAuto := .F.
	
	aParam[1][1] := SL1->L1_DOC
	aParam[1][2] := SL1->L1_SERIE
	aParam[1][3] := cCodCli
	aParam[1][4] := cLojCLi
	                   
	cFunName:=FunName()              
	SetFunName("LOJR130")
	lRetorno:=Lojr130(aParam)
	SetFunName(cFunName)
	
	If lRetorno              
		
		Alert("Nota Fiscal "+cNumProxNf+" gerada com sucesso","NcGames") 
		
		If !Empty(cNumProxNf)
			SF2->(DbSetOrder(1))
			If SF2->(DbSeek(xFilial("SF2")+cNumProxNf+"1") ) .And. MsgYesNo("Transmitir Nota "+SF2->F2_DOC+" Serie:" +SF2->F2_SERIE+" para SEFAZ?")
				AutoNfeEnv(cEmpAnt,cFilAnt,"60","3",SF2->F2_SERIE,SF2->F2_DOC,SF2->F2_DOC)
			EndIf
		EndIf	
		
	Else
		MostraErro()
		DisarmTransaction()
		RollBackSx8()
	EndIf
	
	MsUnLockAll()
	
	RestArea(aAreaAtu)
Return

Static Function LojR130(aParam, lNota, cCliNF, cLojNF)
	
	Local cTesNota 		:= SuperGetMV("MV_TESNOTA")                              	// Parametro que indica Tipo de Saida para geracao de Nota Fiscal s/Cupom
	Local cTesServ		:= SuperGetMV("MV_LJNCUPS",,"")								// TES de servico para nota sobre cupom (F3 OnLine)
	Local lRet			:= .T.
	
	Private aReturn  := { 	STR0005,;												// [1] Reservado para Formulario	"Zebrado,Especial"
	1,;														// [2] Reservado para N� de Vias
	STR0006,;												// [3] Destinatario					"Administracao"
	2,;														// [4] Formato => 1-Comprimido 2-Normal
	2,;														// [5] Midia   => 1-Disco 2-Impressora
	1,;														// [6] Porta ou Arquivo 1-LPT1... 4-COM1...
	"",;													// [7] Expressao do Filtro
	1 }														// [8] Ordem a ser selecionada
	// [9]..[10]..[n] Campos a Processar (se houver)
	//��������������������������������������������������������������Ŀ
	//� Variaveis utilizadas para Impressao do Cabecalho e Rodape	 �
	//����������������������������������������������������������������
	Private nLastKey := 0															// Controla o cancelamento da SetPrint e SetDefault
	Private cPerg	 := "LJR130"													// Pergunte do Relatorio - SX1
	Private cSerie   := SuperGetMV("MV_LOJANF")										// Serie da Nota Fiscal - SIGALOJA
	Private cNumNota := CriaVar("L1_DOC",.F.)										// Numero da NF
	Private oDlgLoja
	
	Static lExecAt	:= .F.
	Static lExecAtM := .F.
	Static lEstorno := .F.
	Static cCliExec := ""
	Static cLojExec := ""
	
	Default aParam	:= {}
	Default lNota	:= .T.
	Default cCliNF	:= Alltrim(SuperGetMV("MV_CLIPAD",,"000001"))
	Default cLojNF	:= Alltrim(SuperGetMV("MV_LOJAPAD",,"01"))
	
	If !lNota
		lEstorno := .T.
		mv_par09 := 2
	EndIf
	
	If Len(aParam) > 0
		lExecAt	:= .T.	// Indica que eh execauto
	EndIf
	
	If Len(aParam) > 0 .AND. lLegislacao
		lExecAtM := .T.	// Indica que eh execauto para multiplas notas
	EndIf
	
	//�����������������������������Ŀ
	//�Adiciona parametro localizado�
	//�������������������������������
	Lj130AjuSX1()
	
	If !lExecAt .AND. lLegislacao
		cPerg := "LJR131"
	EndIf
	
	lRet := LjR130Val(cTesNota,cTesServ)
	
	If !lRet
		If lExecAt
			lMsErroAuto := .T.
		EndIf
		lRet := .F.
	EndIf
	
	If lRet
		If 	lExecAt
			MV_PAR01	:= aParam[1][1] // Doc Cupom
			MV_PAR02	:= aParam[1][2] // Serie Cupom
			MV_PAR03	:= aParam[1][3] // Cliente
			MV_PAR04	:= aParam[1][4] // Loja
		Else
			If !Pergunte(cPerg,.T.)
				lRet := .F.
			Else
				If !LjR130Cli()
					lRet := .F.
				EndIf
			Endif
		EndIf
		
		If lRet
			//��������������������������������������������������������������Ŀ
			//� Valida se o processo deve ou nao continuar                   �
			//����������������������������������������������������������������
			If nModulo == 72
				If !KEXF560()
					lRet := .F.
				Endif
			EndIf
			
			If lRet
				If ExistBlock("LJR130")
					If !ExecBlock("LJR130", .F., .F.,{lExecAt})
						lRet := .F.
					Endif
				Endif
				
				If lRet
					If lLegislacao .AND. !lExecAtM
						LjR130MkBrw()
					ElseIf lExecAtM .AND. lLegislacao
						cCliExec := cCliNF
						cLojExec := cLojNF
						If Empty(Mv_par10)
							Mv_par10 := cCliExec
						EndIf
						If Empty(Mv_par11)
							Mv_par11 := cLojExec
						EndIf
						LJ131ProcM(aParam)
					Else
						lRet := LjR130VerInf()
					EndIf
					
					If !lRet .AND. lExecAt
						lMsErroAuto := .T.
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    LjR130VerInf�Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Validacao dos dados antes do processamento                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LjR130VerInf(aNfsSF2)
	
	Local cString  		:= "SL1"													// Alias principal para a impressao do relatorio
	Local titulo   		:= STR0001													// "Emiss�o de Nota Fiscal para Cupom Fiscal"
	Local cDesc1   		:= STR0002													// "Este programa tem a fun��o de emitir Nota Fiscal com base em um Cupom Fiscal j�"
	Local cDesc2   		:= STR0003 													// "emitido na Venda atendendo ao Decreto 4.373-N de 02/12/1998. Para tanto, ser�"
	Local cDesc3   		:= STR0004										  			// "utilizado o script de Nota Fiscal gravado no Par�metro MV_SCRNFCP (" +GetMV("MV_SCRNFCP")+")"
	Local aAreaSX3   	:= SX3->(GetArea())										// Salva area do SX3
	Local lRet			:= .F.														// Retorno da funcao
	Local lOk	   		:= .T.														// Flag de validacao para continuar a gravacao
	Local wnrel			:= "NFISCAL"            									// Nome DEFAULT do relatorio em Disco
	Local aHeader  		:= {}														// aHeader auxiliar para gravacao da tabela SF2
	Local aHeader1		:= {}														// aHeader auxiliar para gravacao da tabela SD2
	Local cLojaNF  		:= Alltrim(SuperGetMV("MV_LOJANF"))							// Parametro com a serie da Nota Fiscal - Somente para o SIGALOJA
	Local aSeekNF		:= {}
	Local nX 			:= 0
	Local nTamSerie     := TamSx3("F2_SERIE")[1]                                  	// Tamanho do campo F2_SERIE
	Local cTesNota 		:= SuperGetMV("MV_TESNOTA")                              	// Parametro que indica Tipo de Saida para geracao de Nota Fiscal s/Cupom
	Local cTesServ		:= SuperGetMV("MV_LJNCUPS",,"")								// TES de servico para nota sobre cupom (F3 OnLine)
	Local nTam_L1Doc    :=  TamSx3("L1_DOC")[1]                                    //Tamanho do campo L1_DOC
	Local lNfeMex       := If(cPaisLoc  == "MEX" .AND. SA1->(FieldPos("A1_MODCFD")) > 0 .AND. AliasInDic("MDL"),.T.,.F.)
	Local cTiposDoc 	:= AllTrim( SuperGetMv( 'MV_ESPECIE' ) )   					// Tipos de documento (busca no param. MV_ESPECIE)
	Local cTpEspecie    := ""								                        // Tipo da especie
	Local nCount        := 0                                                        // Variavel contador
	Local nPosSign      := 0 														// Contador de posicao dentro de sring
	Local cEspecie      := PadR("SPED",Len(SF1->F1_ESPECIE))                        // Especie igual a SPED
	Local lSped         := .F.                                                      // Verifica se a especie eh SPED
	Local lEstor   		:= SL1->(FieldPos("L1_STATUES")) > 0      					// Verifica se a rotina estorno de venda est� implantada
	Local cCliente		:= If(Empty(Mv_Par03),"",Mv_Par03)							//Cliente
	Local cLoja			:= If(Empty(Mv_Par04),"",Mv_Par04)							//Loja
	Local cCliPad   	:= Alltrim(SuperGetMV("MV_CLIPAD",,"000001"))               //Cliente padrao
	Local cLojPad 		:= Alltrim(SuperGetMV("MV_LOJAPAD",,"01"))					//Loja padrao
	Local lAlterou   	:= .F.                                                      //Verifica se o cliente ou a loja foram alterados.
	Local lClLjPad      := .F. 														//Verifica se e cliente e loja padrao.
	
	Default aNfsSF2 := {}
	
	//������������������������������������������������������������������Ŀ
	//�Verifica se existe um sinal de & (macro substituicao), dessa forma�
	//�possibilita ao usuario executar uma customizacao.                 �
	//�Foi necessario fazer dessa forma, pois caso contrario acarretaria �
	//�erro na base de clientes ja implantada.                           �
	//�Solicitado por: Projeto Kodak                                     �
	//��������������������������������������������������������������������
	If LEFT(cLojaNF,1) == "&"
		cLojaNF := &( SUBSTR(cLojaNF,2,LEN(cLojaNF)) )
	Endif
	
	//�������������������������������������������������������������������
	//�Incluido a funcao PadR, para que, a variavel fique com o mesmo   �
	//�tamanho do campo L1_SERIE evitando problemas com DbSeek.         �
	//�������������������������������������������������������������������
	cLojaNF := PadR(cLojaNF,nTamSerie)
	cSerie  := cLojaNF
	
	If !lLegislacao
		Aadd(aSeekNF,{Mv_par01,Mv_par02})
	Else
		aSeekNF		:= aClone(aNfsSF2)
		cCliente 	:= If(Empty(Mv_Par10),"",Mv_Par10) //carregar a partir do array
		cLoja 		:= If(Empty(Mv_Par11),"",Mv_Par11) //carregar a partir do array
	EndIf
	
	If lExecAtM
		If Empty(cCliente)
			cCliente :=	cCliExec
		EndIf
		
		If Empty(cLoja)
			cLoja := cLojExec
		EndIf
	EndIf
	
	//���������������������������������������������������Ŀ
	//� Variaveis utilizadas para parametros			  �
	//� mv_par01				// Numero do Cupom Fiscal �
	//� mv_par02				// Serie 				  �
	//�����������������������������������������������������
	For nX := 1 To Len(aSeekNF)
		DbSelectArea("SL1")
		SL1->(DbSetOrder(2))
		lOk := SL1->(DbSeek(xFilial("SL1") + aSeekNF[nX][2] +  aSeekNF[nX][1]))
		
		If lOk
			
			lAlterou := Alltrim(SL1->L1_CLIENTE) <> Alltrim(cCliente) .OR. Alltrim(SL1->L1_LOJA) <> Alltrim(cLoja)
			lClLjPad := Alltrim(SL1->L1_CLIENTE) == cClipad .AND. Alltrim(SL1->L1_LOJA) == cLojPad
			
			If lAlterou .AND. !lClLjPad				//Nao permite alterar o cliente se o cupom nao foi gerado para o cliente e loja padrao.
				Ljr130Msg(STR0053+SL1->L1_DOC+STR0054, NIL, 1)//Favor informar o cliente e a loja referentes ao numero do cupom fiscal:
				//Somente e possivel alterar o cliente e a loja caso o cupom fiscal tenha sido gerado para o cliente e loja padrao.
				//�����������������������������������������������������������������Ŀ
				//� Limpa F2_OK para poder escolher o registro posteriormente.		�
				//�������������������������������������������������������������������
				If lLegislacao
					Lj130F2OK(aSeekNF)
				EndIf
				Return .F.
			EndIf
			
			// Nao permite a impressao de Nota sobre cupom para o cliente padrao
			If !lLegislacao .AND. AllTrim(cCliente+cLoja) == AllTrim(cCliPad+cLojPad)
				Ljr130Msg(STR0057, NIL ,1)			//"N�o � permitido a impress�o de Nota Fiscal para o cliente  padr�o"
				Return .F.
			EndIf
			
			If Empty( SL1->L1_PDV )
				lOk := .F.
				Exit
			EndIf
			
			If lEstor
				If !Empty(SL1->L1_STATUES)
					Help(" ","1", "CUPESTORN")  //"Este cupom j� foi estornado."
					Return lRet
				Endif
			Endif
			
			//�����������������������������������������������Ŀ
			//� Verifica se tem SF2 se n�o tiver da mensagem  |
			//�������������������������������������������������
			DbSelectArea("SF2")
			SF2->(DbSetOrder(1))
			lOk  := SF2->(DbSeek(xFilial("SF2") + SL1->L1_DOC + SL1->L1_SERIE ))
		Endif
	Next nX
	
	If !lLegislacao
		aSeekNF := {}
	EndIf
	
	If !lOk
		Help(" ","1","CUPFISCAL")
		Return lRet
	Endif
	
	//���������������������������������������������������������Ŀ
	//� Funcao para verificar se ja existe a nota sobre cupom	�
	//� Caso ja exista oferece a opcao de excluir-la  			�
	//�����������������������������������������������������������
	
	If !lNfeMex
		lOk := !Lj130ChkNf(SL1->L1_DOC , SL1->L1_SERIE , cCliente , cLoja)
	EndIf
	
	If !lOk
		lMsErroAuto := .T.
		Return(.T.)
	Endif
	// Verifica atraves do parametro MV_ESPECIE se a especie eh SPED
	If cTiposDoc <> NIL
		cTiposDoc := StrTran( cTiposDoc, ";", CHR(13)+CHR(10))
		For nCount := 1 TO MLCount( cTiposDoc )
			cTpEspecie := ALLTRIM( StrTran( MemoLine( cTiposDoc,, nCount ), CHR(13), CHR(10) ) )
			nPosSign := Rat( "=", cTpEspecie)
			If nPosSign > 0 .AND. ALLTRIM( cSerie ) == ALLTRIM( SUBSTR( cTpEspecie, 1, nPosSign - 1 ) ) .AND.;
					Alltrim(cEspecie) == AllTrim( SubStr( cTpEspecie, nPosSign + 1 ))
				lSped := .T.
			EndIf
		Next nCount
	EndIf
	
	If !lIsMexico //Para o Mexico a impress�o deste comprvante � depois da impress�o do CFD
		If !( lSped .OR. lExecAt ) // Para NF-e e Rotina Aut. nao imprime
			//��������������������������������������������������������������Ŀ
			//� Envia controle para a funcao SETPRINT 						 �
			//����������������������������������������������������������������
			SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"")
		EndIf
		
		If nLastKey == 27
			Return lRet
		EndIf
	EndIf
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(DbSeek("SF2"))
	While !SX3->(Eof()) .AND. (SX3->X3_ARQUIVO == "SF2")
		If SX3->X3_CONTEXT <> "V"
			AADD( aHeader,{	TRIM(x3titulo())	,;		// 1
			SX3->X3_CAMPO		,;		// 2
			SX3->X3_PICTURE		,;		// 3
			SX3->X3_TAMANHO		,;		// 4
			SX3->X3_DECIMAL		,;		// 5
			SX3->X3_VALID		,;		// 6
			SX3->X3_USADO		,;		// 7
			SX3->X3_TIPO		,;		// 8
			SX3->X3_ARQUIVO } )			// 9
		Endif
		SX3->( DbSkip() )
	End
	
	SX3->(DbSeek("SD2"))
	While !SX3->(Eof()) .AND. ( SX3->X3_ARQUIVO == "SD2" )
		
		//�������������������������������Ŀ
		//�Carrega somente os campos REAIS�
		//���������������������������������
		If SX3->X3_CONTEXT <> "V"
			AADD( aHeader1,{	TRIM(x3titulo())	,;	// 1
			SX3->X3_CAMPO		,;	// 2
			SX3->X3_PICTURE		,;	// 3
			SX3->X3_TAMANHO		,;	// 4
			SX3->X3_DECIMAL		,;	// 5
			SX3->X3_VALID		,;	// 6
			SX3->X3_USADO		,;	// 7
			SX3->X3_TIPO		,;	// 8
			SX3->X3_ARQUIVO		,;	// 9
			SX3->X3_CONTEXT } )		// 10
		Endif
		SX3->( DbSkip() )
	End
	RestArea(aAreaSX3) //Retorna o SX3 para a posicao original...
	
	If !lIsMexico	//Para o Mexico a impress�o deste comprvante � depois da impress�o do CFD
		If !( lSped .OR. lExecAt) // Para NF-e e Rotina Aut. nao imprime
			SetDefault(aReturn,cString)
		EndIf
		
		If nLastKey == 27
			lOk := .F.
		Endif
	EndIf
	
	LjR130Nota( @lOk     , @lRet   	, @wnrel 	, @aHeader	,;
		@aHeader1, @cLojaNF	, aSeekNF	, cString	,;
		@titulo  , cDesc1  	, cDesc2 	, cDesc3 )
	
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LjR130Nota �Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Geracao da nota no fiscal				                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LjR130Nota( lOk     	, lRet   	, wnrel  	, aHeader ,;
		aHeader1	, cLojaNF	, aSeekNF 	, cString ,;
		titulo  	, cDesc1 	, cDesc2 	, cDesc3 )
	
	Local aAreaSL2   	:= {}														// Salva a area especifica para o SL2 - Livros Fiscais
	Local nItensVenda	:= 0														// Quantidade de itens da NF
	Local nMaxItens  	:= 0 														// Determina o numero maximo de itens que uma nf pode conter...
	Local nQtdNotas		:= 1														// Contador com o numero de NF's
	Local aTotNfs    	:= {}														// Array com os totalizadores para o SF2
	Local aRegSF2    	:= {}														// Salva uma posicao de registro do SF2
	Local cEstCF		:= ""														// Estado do Cupom Fiscal
	Local cStrNfCup  	:= ""														// Associa o numero da NF ao cupom fiscal
	Local nTamDoc       := TamSx3("F2_DOC")[1]                                    	// Tamanho do campo F2_DOC
	Local nTamSerie     := TamSx3("F2_SERIE")[1]                                  	// Tamanho do campo F2_SERIE
	
	Local aNotas		:={}														// Array com a numeracao das NF's
	Local cNfOri     	:= ""														// Numero da NF de origem
	Local cSerOri    	:= ""														// Serie da NF de origem
	Local nX			:= 1
	Local nFatNGlob		:= 0
	Local aSeekNfG		:= {}
	Local aSeekNfNG		:= {}
	Local aBkpNotas		:= {}
	Local lPergunta		:= .F.
	Local abkpRegSF2   	:= {}
	Local aMsgCert		:= {}
	Local aSF2			:= {}
	Local aAliasSF2		:= {}
	Local lMsgFG		:= .T.
	Local lGerCfd		:= .F.
	
	Default lOk			:= .F.
	Default lRet		:= .F.
	Default wnrel		:= "NFISCAL"
	Default aHeader		:= {}
	Default aHeader1	:= {}
	Default cString  	:= "SL1"													// Alias principal para a impressao do relatorio
	Default titulo   	:= STR0001													// "Emiss�o de Nota Fiscal para Cupom Fiscal"
	Default cDesc1   	:= STR0002													// "Este programa tem a fun��o de emitir Nota Fiscal com base em um Cupom Fiscal j�"
	Default cDesc2   	:= STR0003 													// "emitido na Venda atendendo ao Decreto 4.373-N de 02/12/1998. Para tanto, ser�"
	Default cDesc3   	:= STR0004										  			// "utilizado o script de Nota Fiscal gravado no Par�metro MV_SCRNFCP (" +GetMV("MV_SCRNFCP")+")"
	
	
	//�������������������������Ŀ
	//�Strutura - aGravaFT      �
	//�1 - Filial               �
	//�2 - Data Entrada         �
	//�3 - Data de emissao      �
	//�4 - Nota Fiscal          �
	//�5 - Serie                �
	//�6 - Cliente              �
	//�7 - Loja                 �
	//�8 - Estado               �
	//�9 - PDV                  �
	//�10 - Especie             �
	//�11 - Produto             �
	//�12 - Item                �
	//�13 - Tipo movimento      �
	//�14 - CFOP                �
	//�15 - Aliquota de ICMS    �
	//�16 - Valor contabil      �
	//�17 - Base ICMS           �
	//�18 - Valor ICMS          �
	//�19 - Isencao ICMS        �
	//�20 - Outro ICMS          �
	//�21 - Base IPI            �
	//�22 - Valor IPI           �
	//�23 - Isencao IPI         �
	//�24 - Outro IPI           �
	//�25 - Observacao          �
	//�26 - ICMS retido         �
	//�27 - TIPO                �
	//�28 - ICMS Com            �
	//�29 - Codigo ISS          �
	//�30 - Obs IPI             �
	//�31 - Numero Livro        �
	//�32 - Icms auto           �
	//�33 - Base retencao       �
	//�34 - Formula             �
	//�35 - Formula             �
	//�36 - Despesas            �
	//�37 - Diferenca Icms      �
	//�38 - Trf Icms            �
	//�39 - Observacao Icms     �
	//�40 - Observacao solidario�
	//�41 - Sol. trib.          �
	//�42 - CFOExt              �
	//�43 - IssSt               �
	//�44 - Rec Iss             �
	//�45 - Iss Sub             �
	//�46 - Livro de ISS no ICMS�
	//�47 - Credito estatual    �
	//�48 - CRDEst              �
	//�49 - Identificao SF3     �
	//�50 - Aliquota IPI        �
	//�51 - Base PS3            �
	//�52 - Aliq PS3            �
	//�53 - Val PS3             �
	//�54 - Base CF3            �
	//�55 - Aliq CF3            �
	//�56 - Val CF3             �
	//�57 - Desconto            �
	//���������������������������
	If lOk
		//Pesquisa o Cupom Original...
		If !lLegislacao
			DbSelectArea("SF2")
			DbSetOrder(1)
			If DbSeek( xFilial("SF2") + SL1->L1_DOC + SL1->L1_SERIE + SL1->L1_CLIENTE + SL1->L1_LOJA )
				Aadd(aSeekNF,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})
				Aadd(aRegSF2,SF2->(RecNo()))
				cEstCF	:= SF2->F2_EST
			Endif
		Else
			For nX := 1 To Len(aSeekNF)
				Aadd(aRegSF2,aSeekNF[nX][6])
				cEstCF	:= SF2->F2_EST
			Next nX
			
		EndIf
		
		//�������������������������������Ŀ
		//�Verifica se ha multiplas notas �
		//���������������������������������
		aAreaSL2 := SL2->(GetArea())
		
		DbSelectArea("SL2")
		SL2->(DbSetOrder(1))
		If SL2->(DbSeek( xFilial("SL2") + SL1->L1_NUM ))
			While 	!SL2->(Eof())				.AND.;
					L2_FILIAL == xFilial("SL2")	.AND.;
					L2_NUM == SL1->L1_NUM
				
				nItensVenda ++
				SL2->(DbSkip())
			End
		Endif
		RestArea(aAreaSL2)
		
		//Determina o numero maximo de itens que uma nf pode conter...
		If cPaisLoc <> "CHI"
			nMaxItens := SuperGetMV("MV_SER"+cSerie,.F.,SuperGetMV("MV_NUMITEN"))
		Else
			nMaxItens := SuperGetMV("MV_NUMITEN")
		Endif
		
		//Determina a qtde de notas que serao geradas...
		If  lIsMexico .AND. lLegislacao
			nX	:= 1
			aAliasSF2	:= SF2->(GetArea())
			While nX <= Len(aSeekNF)
				If !Empty(aSeekNF[nX][8]).AND. !aSeekNF[nX][9]
					DBSelectArea("SF2")
					DBSetOrder(1)
					If DBSeek(xFilial("SF2") + aSeekNF[nX][8])
						If Empty(SF2->F2_APROFOL)
							nFatGlob	+=	aSeekNF[nX][7]
							AADD( aSeekNfG , aSeekNF[nX] )
							lMsgFG	:= .F.
						Else
							ADel(aSeekNF ,nX)
							ASize(aSeekNF , Len(aSeekNF) -1 )
							If nX > 1
								nX --
							Else
								nX := 0
							EndIf
						EndIf
					EndIf
				ElseIf !aSeekNF[nX][9]
					nFatNGlob	+=	aSeekNF[nX][7]
					AADD( aSeekNfNG , aSeekNF[nX] )
					lMsgFG	:= .F.
				ElseIf aSeekNF[nX][9]
					ADel(aSeekNF ,nX)
					ASize(aSeekNK , Len(aSeekNK) -1 )
					If nX > 1
						nX --
					Else
						nX := 0
					EndIf
				EndIf
				nX ++
			End
		ElseIf nItensVenda > nMaxItens
			nQtdNotas := Int(nItensVenda/nMaxItens) + Iif(Mod(nItensVenda,nMaxItens) > 0,1,0)
			
			If nQtdNotas > 1
				Lj130CalcNFs(@aTotNfs,nMaxItens,Nil)
			Endif
		Endif
		
		
		If Len(aAliasSF2) > 0
			RestArea(aAliasSF2)
		EndIf
		
		If !Empty(SF2->F2_NFORI) .AND. lIsMexico .AND. lMsgFG
			cNfOri := SF2->F2_NFORI
			cSerOri:= SF2->F2_SERIORI
			
			If SF2->(DbSeek(xFilial("SF2") + cNfOri + cSerOri))
				If SF2->F2_GLOBAL == "1"
					Ljr130Msg(STR0008+SF2->F2_DOC+" "+SF2->F2_SERIE+")", NIL, 4) //"Nao se pode gerar uma nota fiscal para um cupom que ja pertence a uma nota fiscal global ("")
					If Len(aRegSF2) > 0
						SF2->(DbGoTo(aRegSF2[1]))
					EndIf
					lOk := .F.
				Endif
			Endif
		Endif
		
		If lOk
			If Len(aRegSF2) > 0
				SF2->(DbGoTo(aRegSF2[1]))
			EndIf
			If !Empty(SF2->F2_NFCUPOM)
				cStrNfCup := SubStr(SF2->F2_NFCUPOM,4,nTamDoc)+" "+SubStr(SF2->F2_NFCUPOM,1,nTamSerie)
				//"Ja existe uma Nota Fiscal ("") gerada para o Cupom "" Nao e possivel gerar outra Nota Fiscal para o mesmo Cupom Fiscal"
				Ljr130Msg(STR0009 + cStrNfCup + STR0010 + SF2->F2_DOC + STR0011, NIL ,4)
				lOk := .F.
			Endif
		Endif
		
	Endif
	
	If 	lLegislacao .AND. lIsMexico .AND. lOK
		
		If Len(aSeekNfG) > 0
			If 	nFatGlob > nMaxItens
				nQtdNotas	:=	Int( (nFatGlob) /nMaxItens) + Iif(Mod( (nFatGlob) ,nMaxItens) > 0,1,0)
				
			EndIf
			
			Lj130CalcNFs(@aTotNfs,nMaxItens,aSeekNfG)
			
			aRegSF2	:= Array(Len(aSeekNfG))
			
			For nX := 1 to Len(aSeekNfG)
				aRegSF2[nx] := aSeekNfG[nX][6]
			Next nX
			abkpRegSF2	:= aRegSF2
			
			If lOk
				If !LjxDNota(@cLojaNF, 2, NIL , nQtdNotas, @aNotas)
					lOk := .F.
				Endif
			Endif
			
			LjR130Exec(	@aNotas ,	@cLojaNF	,	@nTamDoc	,@nTamSerie		,;
				@aRegSF2,	@aHeader	,	aTotNfs		,@nFatGlob	,;
				@aHeader1,	@cEstCF		,	@wnrel		,@lRet			,;
				@aSeekNfG, 	@lOk		,	Len(aSeekNfNG) > 0	)
			
			aBkpNotas	:= aNotas
		EndIf
		
		If Len(aSeekNfNG) > 0
			If nFatNGlob > nMaxItens
				nQtdNotas	:=	Int( (nFatNGlob) /nMaxItens) + Iif(Mod( (nFatNGlob) ,nMaxItens) > 0,1,0)
			Else
				nQtdNotas	:= 1
			EndIf
			aTotNfs	:= {}
			Lj130CalcNFs(@aTotNfs,nMaxItens,aSeekNfNG)
			
			aRegSF2	:= Array(Len(aSeekNfNG))
			
			For nX := 1 to Len(aSeekNfNG)
				aRegSF2[nx] := aSeekNfNG[nX][6]
				AADD(aBkpRegSF2 , aSeekNfNG[nX][6])
			Next nX
			
			aNotas	:= {}
			
			If lOk
				If !Lj010Nota(@cLojaNF, 2, NIL , nQtdNotas, @aNotas)
					lOk := .F.
				Endif
			Endif
			
			LjR130Exec(	@aNotas	,	@cLojaNF	,	@nTamDoc	,@nTamSerie		,;
				@aRegSF2,	@aHeader	,	aTotNfs		,@nFatNGlob	,;
				@aHeader1,	@cEstCF		,	@wnrel		,@lRet			,;
				@aSeekNfNG, @lOk		)
			
			For	nX := 1 To Len(aNotas)
			AADD(aBkpNotas , aNotas[nX])
		Next nX
	EndIf
	
	lGerCfd	:= Ljr130Msg(STR0049,NIL,3)			// "Confirma a geracao do comprovante fiscal digital ?"
	
	If lGerCfd
		For nX := 1 To Len(aBkpNotas)
			DBSelectArea("SF2")
			SF2->(DBSetOrder(1))
			aSf2	:= SF2->(getArea())
			If SF2->(DBSeek( xFilial("SF2") + aBkpNotas[nX][2] + aBkpNotas[nX][1]))
				LOJXGERCFD(.F. , lPergunta , @aMsgCert)
				lPergunta	:= .F.
			EndIf
			RestArea(aSF2)
		Next nX
		
		LJXListFol(aMsgCert)
	EndIf
	
	If lIsMexico //No Mexico a impress�o do Script deve ser ap�s a gera��o do CFD
		If !(lExecAt .OR. lRelMacroMex) // Para NF-e e Rotina Aut. nao imprime
			//��������������������������������������������������������������Ŀ
			//� Envia controle para a funcao SETPRINT 						 �
			//����������������������������������������������������������������
			SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"")
		EndIf
		
		If nLastKey == 27
			lOk := .F.
		EndIf
		
		If lOK .AND. !(lExecAt .OR. lRelMacroMex) // Para NF-e e Rotina Aut. nao imprime
			SetDefault(aReturn,cString)
		EndIf
		
		If nLastKey == 27
			lOk := .F.
		EndIf
		
		If lOk
			LjImpScript(cMexNota,cMexSerie,aMexRegSF2,wnrel)
			cMexNota	:= ""
			cMexSerie	:= ""
			aMexRegSF2	:= {}
		EndIf
	EndIf
	
ElseIf lOK
	
	//If !LjxDNota(@cLojaNF, 2, NIL , nQtdNotas, @aNotas)
	//lOk := .F.
	//Endif
	cNfSerie:=Padr("1",Len(SF2->F2_SERIE))
	GetNota(cNfSerie,aNotas)
	
	LjR130Exec(	@aNotas	,	@cLojaNF	,	@nTamDoc	,@nTamSerie		,;
		@aRegSF2,	@aHeader	,	@aTotNfs	,@nItensVenda	,;
		@aHeader1,	@cEstCF		,	@wnrel		,@lRet			,;
		@aSeekNF,	@lOk		,	nQtdNotas)
EndIf

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 �LjR130Exec� Autor � Vendas Clientes		� Data � 14/02/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Emissao de NF de Cupom Fiscal (Decreto 4.373-N de 02/12/98)���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � LOJR130(void)											  ���
�������������������������������������������������������������������������Ĵ��
��� Uso		 � SIGALOJA 												  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function LjR130Exec(	aNotas	,	cLojaNF	,	nTamDoc	,nTamSerie	,;
		aRegSF2	,	aHeader	,	aTotNfs	,nItensVenda,;
		aHeader1,	cEstCF	,	wnrel	,lRet		,;
		aSeekNF	,	lOk		,	nQtdNotas			)
	
	Local nI := 0																	// Contador de For
	Local nX := 0																	// Contador de For
	Local aAreaSF3   	:= {}														// Salva a area especifica para o SF3 - Livros Fiscais
	Local lGeraLivro 	:= .T.														// Flag que indica se o livro sera gerada ou nao
	Local nCount        := 0 														// Contador auxiliar
	Local cVar 			:= ""														// Variavel auxiliar para macro na gravacao dos registros
	Local aRegsSF2 		:= {} 														// Registros do SF2 - Cabecalho das NF's de saida
	Local cEspecie  	:= SPACE(5)													// Especie da NF
	Local cTiposDoc  	:= ALLTRIM( SuperGetMV( 'MV_ESPECIE' ) )					// Conten tipos de documentos fiscais utilizados na emissao de notas fiscais
	Local nPosSign		:= 0 														// Contador de posicao dentro de sring
	LocaL nTamItem      := TamSx3("D2_ITEM")[1]                                    // Tamanho do campo D2_ITEM
	Local cItem      	:= REPLICATE( "0", nTamItem )					            // Contador de itens para o SD2
	Local cTesNota 		:= SuperGetMV("MV_TESNOTA")                              	// Parametro que indica Tipo de Saida para geracao de Nota Fiscal s/Cupom
	Local cCodISS		:= ""														// Codigo de servico
	Local lExisteFT		:= AliasInDic("SFT")										// Se existe o indice do SFT
	Local aImpVarSD2 	:= {}														// Array com os itens do SD2
	Local aLivro     	:= {}														// Array para geracao do Livro Fiscal
	Local aGetBook		:= {}														// Array
	Local nTaxaMoeda 	:= 1														// Moeda utilizada
	Local nLinFT		:= 1														// Linha do Array
	Local aRegsSD2 		:= {}														// Registros do SD2 - Itens de venda da NF de saida
	Local nRegSD2    	:= 0														// Variavel auxiliar para armazenar o recno do SD2
	Local aStruSF3      := {}                                                      // Estrutura do arquivo SF3
	Local aGravaFT		:= {}														// Campos do SFT para serem gravados.
	Local nRecnoSF2		:= 0
	Local nSaveSx8      := GetSx8Len()                                             // Controle da numeracao sequencial
	Local aArea		   	:= GetArea()												// Salva a area atual
	Local cMV_TPNRNFS	:= LjTpNrNFS()												// Retorno do parametro MV_TPNRNFS, utilizado pela Sx5NumNota() de onde serah controlado o numero da NF  1=SX5  2=SXE/SXF  3=SD9
	Local cTesServ		:= SuperGetMV("MV_LJNCUPS",,"")								// TES de servico para nota sobre cupom (F3 OnLine)
	Local cFormula		:= ""														// Formula que esta gravada no SF4
	Local aAreaSF2		:= {}
	Local cPadrao		:= "703"                                    				// Contabilizacao - Codigo Padrao (Lancamento Padrao: 703=Nota Sobre Cupom)
	Local lPadrao  		:= VerPadrao(cPadrao)										// Contabilizacao - Verifica se o codigo Padronizado existe
	Local nHdlPrv  		:= 0														// Contabilizacao
	Local nTotal   		:= 0														// Contabilizacao
	Local cArquivo 		:= ""														// Contabilizacao
	Local lAglutina 	:= .T.														// Contabilizacao (Aglutina Lancamentos)
	Local aLancCtb 		:= {} 														// Contabilizacao
	Local aEstruSF2     := {}                                                       //Array contendo a estrutura da tabela SF2
	Local aEstruSD2     := {}                                                       //Array contendo a estrutura da tabela SD2
	Local aSF2			:= {}                                                       //Array com os valores da SF2
	Local aSD2			:= {}                                                       //Array com os valores da SD2
	Local nInd 			:= 0                                                        //Variavel contador
	Local nRecAntSD2 	:= 0                                                        //Guarda o ultimo recno da SD2
	Local nMaxItens  	:= 0 														// Determina o numero maximo de itens que uma nf pode conter...
	Local cArqSD2       := CriaTrab(Nil,.F.)                                        //Tabela temporaria com os registros da SD2
	Local cFiltro       := ""                                                       //Filtro por item na SD2
	Local nIndex        := 0                                                        //Indice por item na SD2
	Local nItem         := 0                                                        //Item na tabela SD2
	Local cCF 			:= ""														//CFOP
	
	Default aNotas		:= {}
	Default cLojaNF		:= ""
	Default nTamDoc		:= 0
	Default nTamSerie	:= 0
	Default aRegSF2		:= 0
	Default aHeader		:= {}
	Default aTotNfs		:= {}
	Default nItensVenda	:= 0
	Default aHeader1	:= {}
	Default cEstCF		:= ""
	Default wnrel		:= ""
	Default lRet		:= .F.
	Default nQtdNotas	:=	1
	
	//Determina o numero maximo de itens que uma nf pode conter...
	If cPaisLoc <> "CHI"
		nMaxItens := SuperGetMV("MV_SER" + cSerie, .F., SuperGetMV("MV_NUMITEN"))
	Else
		nMaxItens := SuperGetMV("MV_NUMITEN")
	Endif
	
	If lOk
		BEGIN TRANSACTION
			
			//����������������������������������������������������������������������Ŀ
			//� Verifica se eh para fazer o controle do numero da nota pelo SD9 (qdo �
			//� cMV_TPNRNFS = "3" e o numero de notas > 1							 �
			//������������������������������������������������������������������������
			If cMV_TPNRNFS == "3" .AND. nQtdnotas > 1
				For nI := 1 To nQtdNotas
					aAdd( aNotas, { cLojaNF,  MA461NumNf( .T., cLojaNF ) } )
					cSerie 		:= aNotas[1][1]
					cNumNota 	:= aNotas[1][2]
					cNumNota    := PadR( cNumNota ,nTamDoc )
				End
			Endif
			
			DbSelectArea("SA1")
			SA1->( DbSetOrder(1) )
			
			For nI := 1 To Len(aNotas)
				//����������������������������������������������������������������������Ŀ
				//� Verifica se eh para fazer o controle do numero da nota pelo SD9 (qdo �
				//� cMV_TPNRNFS for igual a "3"                                          �
				//������������������������������������������������������������������������
				If cMV_TPNRNFS <> "3"
					cSerie 	 := Padr(aNotas[nI][1],nTamSerie)
					cNumNota := Padr(aNotas[nI][2],nTamDoc)
					cNumNota := PadR( cNumNota , nTamDoc )
				Endif
				
				If nI == 1
					If cPaisLoc <> "BRA"
						//�������������������������������������������������������������������������������Ŀ
						//�Verifica se foi gerado o registro no SF3 para o cupom original, caso tenha sido�
						//�gerado nao existe necessidade de gerar livro para a factura que sera gerada    �
						//���������������������������������������������������������������������������������
						aAreaSF3 := SF3->(GetArea())
						DbSelectArea("SF3")
						DbSetOrder(4)
						If DbSeek( xFilial("SF3") + SL1->L1_CLIENTE + SL1->L1_LOJA + SL1->L1_DOC + SL1->L1_SERIE )
							If AllTrim(SF3->F3_ESPECIE) == "CF"
								lGeraLivro := .F.
							Endif
						Endif
						RestArea(aAreaSF3)
					Endif
					
					//�������������������������������������������������������������Ŀ
					//�Posiciona o arquivo SF2 no cupom para o qual sera gerada nf e�
					//�faz a amaracao entre o cupom original e a nf gerada          �
					//���������������������������������������������������������������
					DbSelectArea("SF2")
					SF2->(DbSetOrder(1))
					For nX := 1 To Len(aRegSF2)
						SF2->(DbGoTo(aRegSF2[nX]))
						Reclock("SF2",.F.)
						SF2->F2_NFCUPOM	:= cSerie + cNumNota
						SF2->F2_OK 		:= ""
						SF2->(MsUnlock())
						SF2->(FKCommit())
						aAreaSF2 := SF2->(GetArea())
						If lLegislacao
							DbSelectArea("MDL")
							MDL->(DbSetOrder(2))
							If !MDL->(DbSeek(xFilial("MDL") + SF2->F2_DOC + SF2->F2_SERIE + cNumNota + cSerie))
								Reclock("MDL",.T.)
								
								Replace MDL->MDL_FILIAL With xFilial("MDL")
								Replace MDL->MDL_NFCUP	With cNumNota
								Replace MDL->MDL_SERIE	With cSerie
								Replace MDL->MDL_CUPOM	With SF2->F2_DOC
								Replace MDL->MDL_SERCUP	With SF2->F2_SERIE
								Replace MDL->MDL_F2RECN	With SF2->(Recno())
								
								MDL->(MsUnLock())
							EndIf
						EndIf
						RestArea(aAreaSF2)
					Next nX
					
					//Armazena os campos e os seus respectivos valores para posterior gravacao...
					For nCount := 1 TO LEN( aHeader )
						cVar := TRIM( aHeader[ nCount ][2] )
						AADD( aRegsSF2, Eval( FielDblock( cVar ) ) )
					Next nCount
				Endif
				
				//��������������������������������������������������������������������������������Ŀ
				//�	Antes de gerar o SF2 da NF carrega o array aSF2 com os valores do SF2 do Cupom �
				//����������������������������������������������������������������������������������
				DbSelectArea("SF2")
				SF2->(DBSetOrder(1)) //F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA
				If !SF2->(DbSeek( xFilial() + cNumNota + cSerie )) //verifica se a nota corrente ja nao esta em transacao
					aEstruSF2  := SF2->(DbStruct())
					For  nInd  := 1 To Len(aEstruSF2)
						If aEstruSF2[nInd,2] == "N"
							aADD(aSF2,{aEstruSF2[nInd,1], &(aEstruSF2[nInd,1]) })
						EndIf
					Next nInd
				Else
					Loop
				EndIf
				
				//�������������������������������������������������������������������������������Ŀ
				//�Gravando Registro no SF2 zerado conforme legisla�ao, qdo pais igual a Brasil   �
				//���������������������������������������������������������������������������������
				RecLock("SF2",.T.)
				// LjAnalisaLeg == 52 // SC ou RN nao zera campos para geracao da tabela SF3
				If !LjAnalisaLeg(52)[1]
					For nCount := 1 TO LEN( aHeader )
						cVar := TRIM( aHeader[ nCount ][2] )
						REPLACE &("SF2->"+cVar) WITH aRegsSF2[nCount]
					Next nCount
				Endif
				
				
				//���������������������������������������������������������Ŀ
				//�Para o Mexico, grava o cliente e loja conforme informado �
				//�nos parametro de pergunta                                �
				//�����������������������������������������������������������
				If lLegislacao .AND. lIsMexico
					SF2->F2_CLIENTE	:= Mv_par10
					SF2->F2_LOJA 	:= Mv_par11
				ElseIf lLegislacao
					SF2->F2_CLIENTE	:= Mv_par10
					SF2->F2_LOJA 	:= Mv_par11
				Else
					SF2->F2_CLIENTE	:= Mv_par03
					SF2->F2_LOJA 	:= Mv_par04
				EndIf
				
				SF2->F2_DOC 	:= cNumNota
				SF2->F2_SERIE 	:= cSerie
				
				SA1->( DbSeek(xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA) )
				
				If lFisLivro
					//Reinicia a funcao fiscal
					If MaFisFound("NF")
						MaFisEnd()
					EndIf
					//Cria novos acumuladores de impostos para iniciar a nota
					MaFisIni( 	SF2->F2_CLIENTE, SF2->F2_LOJA,IIF(SF2->F2_TIPO$'DB',"F","C"),SF2->F2_TIPO ,;
						SF2->F2_TIPOCLI, {},,,"SB1","LOJR130",,,,,IIF(SF2->(FieldPos("F2_RECISS"))>0,SF2->F2_RECISS,"") ,;
						SF2->F2_CLIENT , SF2->F2_LOJENT )
					
				EndIf
				
				//������������������������������������������������������
				//�Inicializa com "NF" se estiver fora do PAIS atualiza�
				//������������������������������������������������������
				cEspecie := "NF"
				If cPaisLoc == "BRA"
					If cTiposDoc <> NIL
						cTiposDoc := StrTran( cTiposDoc, ";", CHR(13)+CHR(10))
						
						For nCount := 1 TO MLCount( cTiposDoc )
							cEspecie := ALLTRIM( StrTran( MemoLine( cTiposDoc,, nCount ), CHR(13), CHR(10) ) )
							nPosSign := Rat( "=", cEspecie)
							
							If nPosSign > 0 .AND. ALLTRIM( cSerie ) == ALLTRIM( SUBSTR( cEspecie, 1, nPosSign - 1 ) )
								DbSelectArea("SX5")
								DbSetOrder(1)
								If DbSeek( xFilial("SX5") + "42" + SUBSTR(cEspecie, nPosSign + 1) )
									cEspecie := SUBSTR( cEspecie, nPosSign + 1 )
								Else
									cEspecie := SPACE(5)
								Endif
								
								Exit
							Else
								cEspecie := SPACE(5)
							Endif
						Next nCount
						
					Endif
				Endif
				
				SF2->F2_ESPECIE 	:= cEspecie
				SF2->F2_PDV   		:= ""
				SF2->F2_ECF   		:= ""
				
				If !(lLegislacao)
					SF2->F2_NFCUPOM 	:= SL1->L1_SERIE+SL1->L1_DOC	// Aqui grava o numero do cupom na nota fiscal gerada
				Else
					SF2->F2_NFCUPOM 	:= "MDL-RECORDED"
					SF2->F2_OK 			:= ""
				EndIf
				
				
				//������������������������������������������������������������������������
				//� Se o parametro MV_TPNRNFS for igual a 3 (controle de numeracao de NF �
				//� pelo SD9) grava o F2_NEXTDOC no final da rotina pq a numeracao das   �
				//� notas sao solicitadas apenas dentro da transacao.                    �
				//������������������������������������������������������������������������
				If cMV_TPNRNFS <> "3"
					If Len(aNotas) > 1 .AND. nI < Len(aNotas)
						SF2->F2_NEXTDOC := Padr( aNotas[nI+1][2], nTamDoc ) //Numero da Prox. Nota
					Else
						SF2->F2_NEXTDOC :=	""
					Endif
				Endif
				
				SF2->F2_PREFIXO 	:= cSerie
				SF2->F2_EMISSAO  	:= dDataBase
				SF2->F2_HORA		:= SubStr(Time(),1,TamSx3("F2_HORA")[1])
				

				If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]// SC ou RN nao zera campos para geracao da tabela SF3
					SF2->F2_DUPL 	:= ""
					SF2->F2_VALBRUT	:= 0
					SF2->F2_VALMERC	:= 0
					SF2->F2_VALFAT 	:= 0
					SF2->F2_DESCONT	:= 0
				Endif
				
				If cPaisLoc <> "BRA"
					//�����������������������������������������������������Ŀ
					//�E necessario gravar os campo F2_NFORI e F2_SERIORI   �
					//�para que essa factura nao seja considerada na geracao�
					//�da fatura global                                     �
					//�������������������������������������������������������
					SF2->F2_NFORI	:= SL1->L1_DOC
					SF2->F2_SERIORI	:= SL1->L1_SERIE
					SF2->F2_HORA	:= SubStr(Time(),1,5)
					SF2->F2_TIPODOC	:= "01"
					If !Empty(aTotNfs)
						SF2->F2_VALBRUT := aTotNfs[nI][3]
						SF2->F2_VALMERC := aTotNfs[nI][1]
						SF2->F2_VALFAT  := aTotNfs[nI][2]
						SF2->F2_DESCONT := aTotNfs[nI][4]
						
						For nCount := 1 To Len(aTotNfs[nI][5])
							//Base do Imposto
							cVar := Trim(aTotNfs[ nI ][5][ nCount ][2])
							REPLACE &("SF2->"+cVar) WITH aTotNfs[ nI ][5][ nCount ][3]
							
							//Valor do Imposto
							cVar := Trim(aTotNfs[ nI ][5][ nCount ][4])
							REPLACE &("SF2->"+cVar) WITH aTotNfs[ nI ][5][ nCount ][5]
						Next nCount
					Endif
				Endif
				
				// LjAnalisaLeg == 52 // SC ou RN nao zera campos para geracao da tabela SF3
				If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
					SF2->F2_ICMFRET		:= 0
					SF2->F2_FRETE		:= 0
					SF2->F2_SEGURO		:= 0
					SF2->F2_DESPESA		:= 0
					SF2->F2_VALICM		:= 0
					SF2->F2_BASEICM		:= 0
					SF2->F2_VALIPI		:= 0
					SF2->F2_BASEIPI		:= 0
					SF2->F2_ICMSRET		:= 0
					SF2->F2_BASEISS		:= 0
					SF2->F2_VALISS 		:= 0
					SF2->F2_BRICMS 		:= 0
					SF2->F2_ICMAUTO 	:= 0
					SF2->F2_VALINSS		:= 0
					SF2->F2_BASEINS		:= 0
					SF2->F2_VALIMP1		:= 0
					SF2->F2_VALIMP2		:= 0
					SF2->F2_VALIMP3		:= 0
					SF2->F2_VALIMP4		:= 0
					SF2->F2_VALIMP5		:= 0
					SF2->F2_VALIMP6		:= 0
					SF2->F2_VALPIS		:= 0
					SF2->F2_VALIRRF		:= 0
					If SF2->(FieldPos('F2_BASIMP5')) > 0 .And. SF2->(FieldPos('F2_BASIMP6')) > 0
						SF2->F2_BASIMP5		:= 0
						SF2->F2_BASIMP6		:= 0
					Endif
				Endif
				
				SF2->(MsUnlock())
				SF2->(FKCommit())
				
				// verica se faz contabiliza��o
				If lPadrao .AND. lIsMexico
					
					aLancCtb := {{"F2_DTLANC",dDataBase,"SF2",SF2->(Recno()),0,0,0}} //Campo Flag de Contabilizacao a ser atualizado
					
					nHdlPrv:=HeadProva("","LOJR130",Substr(cUsername,1,6),@cArquivo)
					
					If  nHdlPrv > 0
						nTotal+=DetProva(nHdlPrv,cPadrao,"LOJR130","")
					EndIf
					
					If  nTotal > 0
						RodaProva(nHdlPrv,nTotal)
						cA100Incl(cArquivo,nHdlPrv,3,"",.F.,lAglutina,,,,aLancCtb)
					EndIf
					
				EndIf
				
				//Gravando Registro no SD2 zerado conforme legislacao, qdo pais igual a Brasil...
				nItensVenda := 0
				cFiltro		:= "D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_ITEM+D2_COD"
				
				For nX := 1 To Len(aSeekNF)
					
					If lLegislacao
						nRegSD2 := 0
					EndIf
					
					DbSelectArea("SD2")
					IndRegua("SD2",cArqSD2,cFiltro)
					
					DbSelectArea("SD2")
					#IFNDEF TOP
						DbSetIndex(cArqSD2+OrdBagExt())
					#ENDIF
					nIndex	:= RetIndex("SD2")
					SD2->(DbSetOrder(nIndex+1))
					If nRegSD2 == 0
						SD2->(DbSeek(xFilial("SD2") + aSeekNF[nX][1] + aSeekNF[nX][2] + aSeekNF[nX][3] + aSeekNF[nX][4]))
					Else
						SD2->(DbGoTo(nRegSD2))
					EndIf
					
					While 	SD2->(!Eof()) 					    .AND.;
							SD2->D2_FILIAL	== xFilial("SD2") 	.AND.;
							SD2->D2_DOC	== aSeekNF[nX][1]	.AND.;
							SD2->D2_SERIE	== aSeekNF[nX][2] 	.AND.;
							SD2->D2_LOJA	== aSeekNF[nX][4]
						
						If Len(aNotas) > 1
							nItensVenda ++
							cItem := Soma1(cItem,Len(cItem))
							
							If nItensVenda > nMaxItens
								nItensVenda := 0
								cItem       := Replicate( "0", nTamItem )
								Exit
							Endif
						Endif
						
						If (cPaisLoc == "BRA" .OR. lIsMexico) .AND. lLegislacao
							cItem := Soma1(cItem,Len(cItem))
						Endif
						
						//���������������������������������������������������������������������������Ŀ
						//�Armazena os campos e os seus respectivos valores para posterior gravacao   �
						//�����������������������������������������������������������������������������
						If !lLegislacao
							For nCount := 1 TO LEN( aHeader1 )
								cVar := TRIM( aHeader1[ nCount ][2] )
								AADD( aRegsSD2, Eval( FielDblock( cVar ) ) )
							Next nCount
						Else
							For nCount := 1 TO LEN( aHeader1 )
								cVar := TRIM( aHeader1[ nCount ][2] )
								If cVar <> "D2_ITEM"
									AADD( aRegsSD2, Eval( FielDblock( cVar ) ) )
								Else
									AADD( aRegsSD2, cItem )
								EndIf
							Next nCount
						EndIf
						
						If cPaisLoc == "BRA"
							If !Empty(SD2->D2_CODISS)
								cCodIss 	:= SD2->D2_CODISS
							EndIf
						EndIf
						
						nRegSD2 := SD2->(Recno())
						
						//�������������������������������������������������������������������������������Ŀ
						//�Antes de gerar o SD2 da NF carrega o array aSD2 com os valores do SD2 do Cupom �
						//���������������������������������������������������������������������������������
						aAdd( aSD2, {0, {}} )
						aEstruSD2 := SD2->(DbStruct())
						For  nInd  := 1 To Len(aEstruSD2)
							If aEstruSD2[nInd,2] == "N"
								aADD(aSD2[Len(aSD2)][2],{aEstruSD2[nInd,1],&(aEstruSD2[nInd,1])})
							EndIf
						Next nInd
						
						Reclock("SD2",.T.)
						For nCount := 1 TO LEN( aHeader1 )
							cVar := TRIM( aHeader1[ nCount ][2] )
							REPLACE &("SD2->"+cVar) WITH aRegsSD2[ nCount ]
						Next nCount
						
						//���������������������������������������������������������Ŀ
						//�Para o Mexico, grava o cliente e loja conforme informado �
						//�nos parametro de pergunta                                �
						//�����������������������������������������������������������
						If lLegislacao .AND. lIsMexico
							SD2->D2_CLIENTE	:= Mv_par10
							SD2->D2_LOJA 	:= Mv_par11
						ElseIf lLegislacao
							SD2->D2_CLIENTE	:= Mv_par10
							SD2->D2_LOJA 	:= Mv_par11
						Else
							SD2->D2_CLIENTE	:= Mv_par03
							SD2->D2_LOJA 	:= Mv_par04
						EndIf
						
						SD2->D2_DOC     := cNumNota
						SD2->D2_SERIE   := cSerie
						SD2->D2_EMISSAO := dDatabase
						
						SD2->D2_PDV    	:= ""
						
						// LjAnalisaLeg == 52 // SC ou RN nao zera campos para geracao da tabela SF3
						If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
							SD2->D2_VALFRE	:= 0
							SD2->D2_DESPESA	:= 0
							SD2->D2_SEGURO	:= 0
							SD2->D2_VALICM	:= 0
							SD2->D2_VALIPI	:= 0
							SD2->D2_BASEICM	:= 0
							SD2->D2_PICM	:= 0
							SD2->D2_IPI		:= 0
							SD2->D2_PICM	:= 0
							SD2->D2_BRICMS	:= 0
							SD2->D2_BASEORI	:= 0
							SD2->D2_CODISS 	:= ""
							SD2->D2_ICMSRET	:= 0
							SD2->D2_BASIMP1	:= 0
							SD2->D2_BASIMP2	:= 0
							SD2->D2_BASIMP3	:= 0
							SD2->D2_BASIMP4	:= 0
							SD2->D2_BASIMP5	:= 0
							SD2->D2_BASIMP6	:= 0
							SD2->D2_VALIMP1	:= 0
							SD2->D2_VALIMP2	:= 0
							SD2->D2_VALIMP3	:= 0
							SD2->D2_VALIMP4	:= 0
							SD2->D2_VALIMP5	:= 0
							SD2->D2_VALIMP6	:= 0
							SD2->D2_ALIQINS	:= 0
							SD2->D2_BASEIPI	:= 0
							SD2->D2_BASEISS	:= 0
							SD2->D2_BASEINS	:= 0
							SD2->D2_BASEISS	:= 0
							SD2->D2_VALISS 	:= 0
							SD2->D2_ICMFRET	:= 0
							SD2->D2_VALINS	:= 0
							SD2->D2_SERIORI	:= SL1->L1_SERIE //Campos de amarracao entre nota fiscal e cupom fiscal.
							SD2->D2_ITEMORI := SD2->D2_ITEM
							If SD2->(FieldPos("D2_NFCUP")) > 0
								SD2->D2_NFCUP := SL1->L1_DOC
							EndIf
							If Len(aNotas) >  1
								SD2->D2_ITEM	:= cItem
								SD2->D2_ITEMPV 	:= cItem
							Endif
						Else
							If Len(aNotas) >  1
								SD2->D2_ITEM	:= cItem
								SD2->D2_ITEMPV 	:= cItem
							Endif
							SD2->D2_REMITO	:= "NFCUP" //Gravar este campo para ser ignorado nos recalculos.
							SD2->D2_NUMSEQ	:= ProxNum()
							SD2->D2_NFORI	:= SL1->L1_DOC
							SD2->D2_SERIORI	:= SL1->L1_SERIE
							SD2->D2_ESPECIE	:= "NF"
							SD2->D2_TIPODOC	:= "01"
						Endif
						
						nItem := FR271BPegaIT(SD2->D2_ITEM, .T. )
						
						// LjAnalisaLeg == 52 // SC ou RN nao zera campos para geracao da tabela SF3
						If cPaisLoc == "BRA" .AND. !LjAnalisaLeg(52)[1]
							SD2->D2_CUSTO1  	:= 0
							SD2->D2_CUSTO2		:= 0
							SD2->D2_CUSTO3		:= 0
							SD2->D2_CUSTO4		:= 0
							SD2->D2_CUSTO5		:= 0    
							SD2->D2_COMIS1   	:= 0
							SD2->D2_COMIS2   	:= 0
							SD2->D2_COMIS3   	:= 0
							SD2->D2_COMIS4   	:= 0
							SD2->D2_COMIS5   	:= 0						
							SD2->D2_PRUNIT 		:= 0
							SD2->D2_DESCON 		:= 0					
							SD2->D2_PRCVEN  	:= 0
							SD2->D2_TOTAL		:= 0
							SD2->D2_DESC		:= 0
							If SD2->(FieldPos('D2_ALQIMP5')) > 0 .And. SD2->(FieldPos('D2_ALQIMP6')) > 0
								SD2->D2_ALQIMP5		:= 0
								SD2->D2_ALQIMP6		:= 0
							Endif
						Endif
						
						If (cPaisLoc == "BRA" .OR. lIsMexico) .AND. !Empty(cTesNota)
							
							DbSelectArea("SB1")
							SB1->(DbSetOrder(1))
							SB1->(DbSeek(xFilial("SB1") + SD2->D2_COD))
							
							DbSelectArea("SF4")
							SF4->(DbSetOrder(1))
							SF4->(DbSeek(xFilial()+cTesNota))
							
							If !Empty(SF4->F4_FORMULA)
								cFormula := SF4->F4_FORMULA
							EndIf
							
							If Empty(cCodIss)
								SD2->D2_TES		:= cTesNota
								SD2->D2_CLASFIS	:= ( SubStr(SB1->B1_ORIGEM, 1, 1) + SF4->F4_SITTRIB )
							EndIf
							
							If cPaisLoc == "BRA"
								Posicione("SA1",1,xFilial("SA1")+SD2->D2_CLIENTE+SD2->D2_LOJA,"A1_EST")
								cCF := "5929"
								If SA1->A1_EST == SuperGetMV("MV_ESTADO") .AND. SA1->A1_TIPO # "X"
									cCF := "5" + Subs(cCF,2,3)
								ElseIf SA1->A1_TIPO # "X"
									cCF := "6" + Subs(cCF,2,3)
								Else
									cCF := "7" + Subs(cCF,2,3)
								Endif
								SD2->D2_CF	:= cCF
							EndIf
						Endif
						
						//�������������������������Ŀ
						//�Grava o codigo de servico�
						//���������������������������
						If !Empty(cCodIss)
							SD2->D2_CODISS 	:= cCodIss
							SD2->D2_TES		:= Alltrim(cTesServ)
							cCodIss 		:= ""
							SF4->(DbSetOrder(1))
							SF4->(DbSeek(xFilial()+Alltrim(cTesServ)))
						EndIf
						
						//�������������������������������������������������������������������������������������������������������������������Ŀ
						//�Caso o parametro MV_LJLVFIS esteja como 1, realizada o tratamento no SF3 e SFT como no modo antigo (via MV_MAPARES)�
						//���������������������������������������������������������������������������������������������������������������������
						If lExisteFT .AND. cPaisLoc == "BRA" .AND. !lFisLivro
							
							Aadd(aGravaFT,(LjxCpsSft()))
							
							aGravaFT[nLinFT][1][2]  := xFilial("SD2")
							aGravaFT[nLinFT][2][2]  := dDatabase
							aGravaFT[nLinFT][3][2]  := dDatabase
							aGravaFT[nLinFT][4][2]  := cNumNota
							aGravaFT[nLinFT][5][2]  := cSerie
							aGravaFT[nLinFT][6][2]  := SD2->D2_CLIENTE
							aGravaFT[nLinFT][7][2]  := SD2->D2_LOJA
							aGravaFT[nLinFT][8][2]  := SuperGetMV("MV_ESTADO")
							aGravaFT[nLinFT][9][2]  := SD2->D2_PDV
							aGravaFT[nLinFT][10][2] := "NF"
							aGravaFT[nLinFT][11][2] := SD2->D2_COD
							aGravaFT[nLinFT][12][2] := SD2->D2_ITEM
							
							If !(lLegislacao)
								aGravaFT[nLinFT][25][2] := "NF/SERIE:" + SL1->L1_DOC + "/" + SL1->L1_SERIE +  " ECF:" + SL1->L1_PDV
							Else
								aGravaFT[nLinFT][25][2] := "F - Simples Faturamento"
							EndIf
							aGravaFT[nLinFT][14][2] := If(cPaisLoc == "BRA",cCf,"")
							aGravaFT[nLinFT][34][2] := "S"
							aGravaFT[nLinFT][13][2] := "S"
							
						Endif
						
						SD2->(MsUnlock())
						SD2->(FKCommit())
						
						If lFisLivro
							//Inicializa as funcoes
							MaFisIniLoad(nItem,{ SD2->D2_COD,;	 //IT_PRODUTO
							SD2->D2_TES,; 	 //IT_TES
							SD2->D2_CODISS,;//IT_CODISS
							SD2->D2_QUANT,; //IT_QUANT
							Nil,; 			 //IT_NFORI
							Nil,; 			 //IT_SERIORI
							SB1->(RecNo()),;//IT_RECNOSB1
							SF4->(RecNo()),;//IT_RECNOSF4
							0,; 			 //IT_RECORI
							Nil,;  		 //IT_LOTECTL
							Nil } ) 		 //IT_NUMLOTE
							
							MaFisRecal("",nItem)
							If !Empty(cCF)
								MaFisLoad("IT_CF" ,cCF,nItem)      	//Ajusta o CFOP
								MaFisLoad("LF_CFO",cCF,nItem)       //Ajusta o CFOP
								MaFisLoad("IT_VALMERC"	,SD2->D2_TOTAL	, nItem)
								MaFisLoad("IT_PRCUNI"	,SD2->D2_PRCVEN , nItem)
								MaFisLoad("IT_DESCONTO"	,SD2->D2_DESCON , nItem)
							EndIf
							MaFisEndLoad(nItem,2)               //Finaliza a carga do item
						EndIf
						
						//Guarda o Recno do Registro SD2 que devera ser atualizado
						aSD2[Len(aSD2)][1] := SD2->(Recno())
						
						//Prepara os dados para a geracao do livro fiscal...
						If cPaisLoc <> "BRA"
							DbSelectArea("SF4")
							SF4->(DbSetOrder(1))
							SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
							
							If !Empty(SF4->F4_FORMULA)
								cFormula := SF4->F4_FORMULA
							EndIf
							
							aImpVarSD2 := Lj130SimSD2(SD2->D2_TES,"SD2")
							aLivro     := GetBook(@aGetBook,aImpVarSD2,"V",nTaxaMoeda,aLivro,"S",,lGeraLivro)
						EndIf
						
						If nModulo == 72
							KEXF570()
						Endif
						
						If ExistBlock("LJR130IT")
							ExecBlock("LJR130IT",.F.,.F.)
						Endif
						
						nLinFT++
						
						DbSelectArea("SD2")
						SD2->(DbGoto(nRegSD2))
						
						//Campos de amarracao entre nota fiscal e cupom fiscal.
						RecLock( "SD2", .F. )
						SD2->D2_SERIORI	:= cSerie
						SD2->D2_ITEMORI := cItem
						If SD2->(FieldPos("D2_NFCUP")) > 0
							SD2->D2_NFCUP	:= cNumNota
						EndIf
						
						SD2->(DbSkip())
						aRegsSD2:= {}
						nRegSD2 := SD2->(RecNo())
					End
					
					DbSelectArea("SD2")
					RetIndex("SD2")
					FErase(cArqSD2+OrdBagExt())
					Set Filter To
				Next nX
				
				//Grava o Livro Fiscal
				If cPaisLoc <> "BRA"
					Lj130Livro("NF",dDataBase,aLivro)
					aLivro     := {}
					aGetBook   := {}
					aImpVarSD2 := {}
				Else
					//�������������������������������������Ŀ
					//�Executa a gravacao do SF3 via MATXFIS�
					//���������������������������������������
					If lFisLivro
						MaFisAtuSF3(1,"S",SF2->(Recno()),"SF2",NIL,NIL,"LOJR130")
						MaFisEnd()
					EndIf
					
				EndIf
				
				// Apos geracao da tabela SF3 zera as tabelas SF2 e SD2
				If lFisLivro .AND. LjAnalisaLeg(52)[1]
					
					DBSelectArea("SF2") 						//Posicionado no SF2 da NF e atualiza os campos de valores com os dados do CF referenciado
					SF2->(DBSetOrder(1))
					Lj7GeraSL( "SF2", aSF2, .F., .T.)
					
					RecLock("SF2",.F.)
					SF2->F2_ICMFRET		:= 0
					SF2->F2_FRETE		:= 0
					SF2->F2_SEGURO		:= 0
					SF2->F2_DESPESA		:= 0
					SF2->F2_VALICM		:= 0
					SF2->F2_BASEICM		:= 0
					SF2->F2_VALIPI		:= 0
					SF2->F2_BASEIPI		:= 0
					SF2->F2_ICMSRET		:= 0
					SF2->F2_BASEISS		:= 0
					SF2->F2_VALISS 		:= 0
					SF2->F2_BRICMS 		:= 0
					SF2->F2_ICMAUTO 	:= 0
					SF2->F2_VALINSS		:= 0
					SF2->F2_BASEINS		:= 0
					SF2->F2_VALIMP1		:= 0
					SF2->F2_VALIMP2		:= 0
					SF2->F2_VALIMP3		:= 0
					SF2->F2_VALIMP4		:= 0
					SF2->F2_VALIMP5		:= 0
					SF2->F2_VALIMP6		:= 0
					SF2->F2_VALPIS		:= 0
					SF2->F2_VALIRRF		:= 0
					If SF2->(FieldPos('F2_BASIMP5')) > 0 .And. SF2->(FieldPos('F2_BASIMP6')) > 0
						SF2->F2_BASIMP5		:= 0
						SF2->F2_BASIMP6		:= 0
					Endif
					SF2->(MsUnlock())
					nRecAntSD2 := SD2->(Recno())
					
					DBSelectArea("SD2")                         //Percorre Itens da NF para atualizar valores do CF referenciado
					DBSetOrder(1)
					For  nInd := 1 to Len(aSD2)
						SD2->( dbGoTo ( aSD2[nInd][1] ) )
						Lj7GeraSL( "SD2", aSD2[nInd][2], .F., .T.)
						RecLock("SD2",.F.)
						SD2->D2_VALFRE	:= 0
						SD2->D2_DESPESA	:= 0
						SD2->D2_SEGURO	:= 0
						SD2->D2_VALICM	:= 0
						SD2->D2_VALIPI	:= 0
						SD2->D2_BASEICM	:= 0
						SD2->D2_PICM	:= 0
						SD2->D2_IPI		:= 0
						SD2->D2_PICM	:= 0
						SD2->D2_BRICMS	:= 0
						SD2->D2_BASEORI	:= 0
						SD2->D2_CODISS 	:= ""
						SD2->D2_ICMSRET	:= 0
						SD2->D2_BASIMP1	:= 0
						SD2->D2_BASIMP2	:= 0
						SD2->D2_BASIMP3	:= 0
						SD2->D2_BASIMP4	:= 0
						SD2->D2_BASIMP5	:= 0
						SD2->D2_BASIMP6	:= 0
						SD2->D2_VALIMP1	:= 0
						SD2->D2_VALIMP2	:= 0
						SD2->D2_VALIMP3	:= 0
						SD2->D2_VALIMP4	:= 0
						SD2->D2_VALIMP5	:= 0
						SD2->D2_VALIMP6	:= 0
						SD2->D2_ALIQINS	:= 0
						SD2->D2_BASEIPI	:= 0
						SD2->D2_BASEISS	:= 0
						SD2->D2_BASEINS	:= 0
						SD2->D2_BASEISS	:= 0
						SD2->D2_VALISS 	:= 0
						SD2->D2_ICMFRET	:= 0
						SD2->D2_VALINS	:= 0
						SD2->(MsUnlock())
					Next nInd
					SD2->( dbGoTo ( nRecAntSD2 ) )
					
				EndIf
				
				//����������������������������������������������������������Ŀ
				//� Grava o reg. no SF3 (Livro Fiscal) ref. a NF sobre cupom �
				//������������������������������������������������������������
				If cPaisLoc == "BRA" .AND. !lFisLivro
					//���������������������������������������������������������
					//� Se MV_MAPARES = N, gera o registro do livro fiscal    �
					//� correspondente com valores zerados				     �
					//���������������������������������������������������������

					If SuperGetMV("MV_MAPARES") == "N"
						RecLock("SF3",.T.)
						aStruSF3 := SF3->(dbStruct())
						For nX := 1 To Len(aStruSF3)
							If aStruSF3[nX][2] <> "N"
								FieldPut(FieldPos(aStruSF3[nX][1]),CriaVar(aStruSF3[nX][1]))
							EndIf
						Next nX
						REPLACE SF3->F3_FILIAL	WITH xFilial("SF3")
						REPLACE SF3->F3_ENTRADA	WITH dDatabase
						REPLACE SF3->F3_EMISSAO	WITH dDatabase
						REPLACE SF3->F3_CLIEFOR	WITH cCodCli//SL1->L1_CLIENTE
						REPLACE SF3->F3_LOJA	WITH cLojCLi//SL1->L1_LOJA
						REPLACE SF3->F3_CFO		WITH cCf
						REPLACE SF3->F3_NFISCAL	WITH cNumNota
						REPLACE SF3->F3_SERIE  	WITH cSerie
						REPLACE SF3->F3_ESPECIE	WITH "NF"
						REPLACE SF3->F3_FORMUL	WITH "N"
						
						If !(lLegislacao)
							REPLACE SF3->F3_OBSERV	WITH "CF/SERIE:" + SL1->L1_DOC + "/" + SL1->L1_SERIE +  " ECF:" + SL1->L1_PDV
						Else
							REPLACE SF3->F3_OBSERV	WITH "F - Simples Faturamento"
						EndIf
						REPLACE SF3->F3_TIPO	    WITH ""
						REPLACE SF3->F3_ESTADO	WITH If(!Empty(cEstCF),cEstCF,SuperGetMV("MV_ESTADO"))
						REPLACE SF3->F3_FORMULA	WITH cFormula
						MsUnLock()
						//���������Ŀ
						//�Gerao SFT�
						//�����������
						If lExisteFT
							LjxGerSft(aGravaFT)
						EndIf
					EndIf
					
				EndIf
				If ExistBlock("LJR130GR")
					ExecBlock("LJR130GR",.F.,.F.)
				Endif
				
			Next nI
			
			//����������������������������������������������������������������������Ŀ
			//� Faz a gravacao do F2_NEXTDOC quando o parametro MV_TPNRNFS == "3"    �
			//������������������������������������������������������������������������
			If cMV_TPNRNFS == "3" .AND. Len( aNotas ) > 1
				nRecnoSF2 := SF2->( Recno() )
				SF2->( DbSetOrder( 1 ) )
				For nX := 1 to Len( aNotas ) - 1
					If DbSeek( xFilial("SF2") + aNotas[nX][2] + aNotas[nX][1] )
						RecLock( "SF2", .F. )
						SF2->F2_NEXTDOC := aNotas[ nX + 1 ][2]
						SF2->( MsUnlock() )
					Endif
				Next nX
				SF2->( dbGoTo ( nRecnoSF2 ) )
			Endif
			
			While (GetSX8Len() > nSaveSx8)
				ConfirmSX8()
			End
		END TRANSACTION
		
		If lIsMexico //Para o M�xico a impress�o do Script deve ser ap�s a gera��o do CFD
			cMexNota	:= cNumNota
			cMexSerie	:= cSerie
			aMexRegSF2	:= aRegSF2
		Else
			LjImpScript( cNumNota,cSerie,aRegSF2,wnrel)
		EndIf
		
	EndIf
	
	lRet := .T.
	
	//Retorna a Area Original...
	RestArea(aArea)
	
Return lRet



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
��� Fun��o   �Lj130Livro   � Autor � Vendas Clientes	� Data � 12.11.02 ���
�������������������������������������������������������������������������Ĵ��
��� Descri�ao� Gerar os registros do Livro Fiscal                         ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � LOJR130                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Lj130Livro(cEspecie,dData,aLivro)
	Local cEspec        := Padr(cEspecie,len(criavar("F3_ESPECIE",.f.)))
	Local cEspTmp	    := MVNOTAFIS+"|"+GetSESNew('NDC',"1")+"|"+GetSESNew('NDI',"2")+"|"+GetSESNew('NCI',"2")+"|"+GetSESNew('NCC',"2")
	Local cTipContNF    := If(ValType(lFiscal)== "L" .AND. lFiscal ,SuperGetMV("MV_CONTNFI",,"I"),SuperGetMV("MV_CONTNF"))
	Local nX, nY
	
	cNumNota := PadR(cNumNota,TamSX3("F3_NFISCAL")[1])
	
	DbSelectArea("SF3")
	DbSetOrder(5)
	//Exclui os registros de mesma numeracao que estao cancelados
	If DbSeek( xFilial("SF3")+cSerie+cNumNota)
		While !Eof() .AND. (xFilial("SF3")+cSerie+cNumNota) == (SF3->F3_FILIAL+SF3->F3_SERIE+SF3->F3_NFISCAL)
			If !Empty(SF3->F3_DTCANC)
				If cTipContNF == "M" .AND. Alltrim(F3_ESPECIE)$ cEspTmp .OR. (cTipContNF == "I" .AND. Alltrim(F3_ESPECIE)==	Alltrim(cEspec))
					RecLock("SF3",.F.)
					DbDelete()
					MsUnLock()
					SF3->(FKCommit()) //-- Atualiza as gravacoes pendentes na tabela
				Endif
			Endif
			DbSkip()
		End
	Endif
	
	For nX := 2 To Len( aLivro )
		RecLock( "SF3",.T. )
		For nY := 1 To Len( aLivro[1] )
			SF3->( FieldPut(FieldPos(aLivro[1,nY]),aLivro[nX,nY]) )
		Next nY
		SF3->F3_FILIAL	:= xFilial("SF3")
		SF3->F3_NFISCAL	:= cNumNota
		SF3->F3_SERIE	:= cSerie
		SF3->F3_ENTRADA	:= dData
		MsUnLock()
		SF3->(FKCommit()) //-- Atualiza as gravacoes pendentes na tabela
	Next nX
	
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Lj130SimSD2�Autor  �Vendas Clientes  	 � Data �  20/11/02   ���
�������������������������������������������������������������������������͹��
���Descricao �Preparacao de array para geracao do livro                   ���
�������������������������������������������������������������������������͹��
���Uso       � LOJR130                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Lj130SimSD2(cTes,cAliasSD2)
	Local nX								// Contador de For
	Local cCampoBase:= ""					// Campo Base
	Local cCampoVlr := ""					// Valor de campo
	Local cCampoAliq:= ""					// Aliquota de campo
	Local aInfo	    :=	TesImpInf(cTes)		// Informcao TES
	Local aReturn	:=	{0,0,0,0,0,{}}		// Retorna da funcao
	
	aReturn[1]	:=	(cAliasSD2)->D2_QUANT
	aReturn[2]	:=	(cAliasSD2)->D2_PRCVEN
	aReturn[3]	:=	(cAliasSD2)->D2_TOTAL
	aReturn[4]	:=	0
	aReturn[5]	:=	0
	
	For nX	:=	1	To	Len(aInfo)
		cCampoBase  := (cAliasSD2)+"->"+aInfo[nX][7]
		cCampoVlr   := (cAliasSD2)+"->"+aInfo[nX][2]
		cCampoAliq  := (cAliasSD2)+"->"+aInfo[nX][10]
		
		AAdd(aReturn[6],Array(18))
		aReturn[6][nX][1]	:= aInfo[nX][1]
		aReturn[6][nX][2]	:= &(cCampoAliq)
		aReturn[6][nX][3]	:= &(cCampoBase)
		aReturn[6][nX][4]	:= &(cCampoVlr)
		aReturn[6][nX][5]	:= aInfo[nX][3]+aInfo[nX][4]+aInfo[nX][5]
		aReturn[6][nX][6]	:= "D2_VALIMP"+Substr(aInfo[nX][2],10)
		aReturn[6][nX][7]	:= "D2_BASIMP"+Substr(aInfo[nX][2],10)
		aReturn[6][nX][8]	:= "F2_VALIMP"+Substr(aInfo[nX][2],10)
		aReturn[6][nX][9]	:= "F2_BASIMP"+Substr(aInfo[nX][2],10)
		aReturn[6][nX][17] := Substr(aInfo[nX][2],10)
	Next nX
	
Return(aReturn)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Lj130CalcNF�Autor  �Vendas Clientes	 � Data �  12/03/03   ���
�������������������������������������������������������������������������͹��
���Descricao �Cria array com as diversas nfs criadas para o cupom.        ���
�������������������������������������������������������������������������͹��
���Uso       � LOJR130                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Lj130CalcNFs(aTotNfs,nMaxItens)
	Local aAreaAtu    := GetArea()				// GetArea
	Local aAreaSD2    := SD2->(GetArea())		// GetArea do SD2
	Local nItensVenda := 0						// Itens da venda
	Local aImpsInf    := {}						// Impostos
	Local nI          := 0						// Contador de For
	Local aImps       := {}						// Impostos
	Local nTotImp     := 0						// Total de impostos
	Local nPosImp     := 0						// Posicao no Ascan
	
	Private cCpoBase  := ""
	Private cCpoVal   := ""
	
	//////////////////////////////////////////////////////////
	//Estrutura do array aTotNfs                            //
	//1 - F2_VALMERC										//
	//2 - F2_VALFAT											//
	//3 - F2_VALBRUT										//
	//4 - F2_DESCONT										//
	//5 - Array com a sumarizacao dos impostos variaveis	//
	//////////////////////////////////////////////////////////
	
	DbSelectArea("SD2")
	SD2->(DbSetOrder(3))
	If SD2->(DbSeek(xFilial("SD2")+SL1->(L1_DOC+L1_SERIE+L1_CLIENTE+L1_LOJA)))
		While !SD2->(Eof()) .AND.	SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA) == ;
				(xFilial("SD2")+SL1->(L1_DOC+L1_SERIE+L1_CLIENTE+L1_LOJA))
			
			nItensVenda++
			If (nItensVenda > nMaxItens)
				nItensVenda := 1
				aImps       := {}
			Endif
			
			nTotImp  := 0
			aImpsInf := TesImpInf(D2_TES)
			For nI := 1 To Len(aImpsInf)
				cCpoBase := aImpsInf[nI][7]
				cCpoVal  := aImpsInf[nI][2]
				If (nPosImp := aScan(aImps,{|x| Trim(x[1])==aImpsInf[nI][1]})) == 0
					Aadd(aImps,{aImpsInf[nI][1],aImpsInf[nI][8],&cCpoBase.,;
						aImpsInf[nI][6],&cCpoVal.,aImpsInf[nI][3]})
				Else
					aImps[nPosImp][3] += &cCpoBase.
					aImps[nPosImp][5] += &cCpoVal.
				Endif
				
				If aImpsInf[nI][3] == "1"
					nTotImp += &cCpoVal.
				Endif
			Next nI
			
			If (nItensVenda == 1)
				Aadd(aTotNfs,{D2_TOTAL,D2_TOTAL+nTotImp,D2_TOTAL+nTotImp,D2_DESCON,aClone(aImps)})
			Else
				aTotNfs[Len(aTotNfs)][1] += D2_TOTAL
				aTotNfs[Len(aTotNfs)][2] += D2_TOTAL+nTotImp
				aTotNfs[Len(aTotNfs)][3] += D2_TOTAL+nTotImp
				aTotNfs[Len(aTotNfs)][4] += D2_DESCON
				aTotNfs[Len(aTotNfs)][5] := aClone(aImps)
			Endif
			DbSkip()
		End
		RestArea(aAreaSD2)
	Endif
	RestArea(aAreaAtu)
	
Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �Lj130AjuSX1�Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Inclui perguntas no SX1 caso nao existe                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Lj130AjuSX1()
	Local cPerg := PADR("LJR130",6) 		//Grupo de perguntas
	Local aHelpPor := {}					//Array com o Help do PutSx1
	Local aHelpEsp := {}					//Array com o Help do PutSx1
	Local aHelpIng := {}					//Array com o Help do PutSx1
	Local nTamLoja := TamSx3("A1_LOJA")[1]
	Local nTamCli  := TamSx3("A1_COD")[1]
	Local nTamDoc  := TamSx3("F2_DOC")[1]
	Local nTamSX1  := 0
	
	If lLegislacao
		cPerg := PADR("LJR131",6)
		
		//"Digite o cliente para a nota"
		Aadd(aHelpPor,STR0015)
		Aadd(aHelpEsp,STR0015)
		Aadd(aHelpIng,STR0015)
		
		//���������������������������������������������������������Ŀ
		//�Se existir as perguntas "De/Ate Fact?", atribui o tamanho|
		//�do campo SF2->F2_DOC aos parametros MV_PAR03 e MV_PAR05.	�
		//�����������������������������������������������������������
		DbSelectArea("SX1")
		DbSetOrder(1)
		nTamSX1   := Len(SX1->X1_GRUPO)
		If DbSeek(PADR(cPerg,nTamSX1) + "03")
			If SX1->X1_TAMANHO <> nTamDoc
				RecLock("SX1",.F.)
				REPLACE X1_TAMANHO WITH nTamDoc
				MsUnLock()
			EndIf
		EndIf
		
		If DbSeek(Padr(cPerg,nTamSX1) + "05")
			If SX1->X1_TAMANHO <> nTamDoc
				RecLock("SX1",.F.)
				REPLACE X1_TAMANHO WITH nTamDoc
				MsUnLock()
			EndIf
		EndIf
		
		//�������������������Ŀ
		//�Busca a pergunta 3 �
		//���������������������
		DbSelectArea("SX1")
		DbSetOrder(1)
		nTamSX1   := Len(SX1->X1_GRUPO)
		If DbSeek(Padr(cPerg,nTamSX1) + "10")
			
			//���������������������������������������������������������Ŀ
			//�Se a resposta padrao para esta pergunta estiver for      �
			//�positiva, utiliza o Tamalho do campo cadastrado no grupo �
			//�de campos                                                �
			//�����������������������������������������������������������
			If SX1->X1_TAMANHO <> nTamCli
				RecLock("SX1",.F.)
				REPLACE X1_TAMANHO WITH nTamCli
				MsUnLock()
			EndIf
			//����������������������������������Ŀ
			//�Se nao existir, cria esta pergunta�
			//������������������������������������
		Else
			//�����������������������������������Ŀ
			//�Inclui a pergunta para qual cliente�
			//�������������������������������������
			//"Para o cliente: "
			PutSx1( cPerg  	,   "10"   	,   STR0055	,   STR0055		,	;
				STR0055	,"Mv_par10"	,	"C"		,	nTamCli		,	;
				0		,	0		,	"G"		,"LjR130Cli()"	,	;
				"SA1"	,	""		,	""		,"Mv_par10"		,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				aHelpPor,  aHelpIng	,  aHelpEsp	,	""				)
		EndIf
		
		aHelpPor := {}
		aHelpEsp := {}
		aHelpIng := {}
		
		//"Digite a loja para a nota"
		Aadd(aHelpPor,STR0020)
		Aadd(aHelpEsp,STR0020)
		Aadd(aHelpIng,STR0020)
		
		//�������������������Ŀ
		//�Busca a pergunta 4 �
		//���������������������
		DbSelectArea("SX1")
		DbSetOrder(1)
		nTamSX1   := Len(SX1->X1_GRUPO)
		If DbSeek(Padr(cPerg,nTamSX1) + "11")
			
			//���������������������������������������������������������Ŀ
			//�Se a resposta padrao para esta pergunta estiver for      �
			//�positiva, utiliza o Tamalho do campo cadastrado no grupo �
			//�de campos                                                �
			//�����������������������������������������������������������
			If SX1->X1_TAMANHO <> nTamLoja
				RecLock("SX1",.F.)
				REPLACE X1_TAMANHO WITH nTamLoja
				MsUnLock()
			EndIf
			//����������������������������������Ŀ
			//�Se nao existir, cria esta pergunta�
			//������������������������������������
		Else
			
			//����������������������������������Ŀ
			//�Inclui a a pergunta para qual loja�
			//������������������������������������
			//"Para a loja: "
			PutSx1( cPerg  	,   "11"   	,   STR0056	,   STR0056		,	;
				STR0056	,"Mv_par11"	,	"C"		,	nTamLoja 	,	;
				0		,	0		,	"G"		,	""			,	;
				""		,	""		,	""		,"Mv_par11"		,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				aHelpPor,  aHelpIng	,  aHelpEsp	,	""				)
		EndIf
		
	Else
		
		//"Digite o cliente para a nota"
		Aadd(aHelpPor,STR0015)
		Aadd(aHelpEsp,STR0015)
		Aadd(aHelpIng,STR0015)
		
		//�������������������Ŀ
		//�Busca a pergunta 3 �
		//���������������������
		DbSelectArea("SX1")
		DbSetOrder(1)
		nTamSX1   := Len(SX1->X1_GRUPO)
		If DbSeek(Padr(cPerg,nTamSX1) + "03")
			
			//���������������������������������������������������������Ŀ
			//�Se a resposta padrao para esta pergunta estiver for      �
			//�positiva, utiliza o Tamalho do campo cadastrado no grupo �
			//�de campos                                                �
			//�����������������������������������������������������������
			If SX1->X1_TAMANHO <> nTamCli
				RecLock("SX1",.F.)
				REPLACE X1_TAMANHO WITH nTamCli
				MsUnLock()
			EndIf
			//����������������������������������Ŀ
			//�Se nao existir, cria esta pergunta�
			//������������������������������������
		Else
			//������������������Ŀ
			//�Inclui a pergunta �
			//��������������������
			//"Cliente    ?"
			PutSx1( cPerg  	,   "03"   	,   STR0016	,   STR0016		,	;
				STR0016	,"Mv_par03"	,	"C"		,	nTamCli		,	;
				0		,	0		,	"G"		,"LjR130Cli()"	,	;
				"SA1"	,	""		,	""		,"Mv_par03"		,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				aHelpPor,  aHelpIng	,  aHelpEsp	,	""				)
		EndIf
		
		aHelpPor := {}
		aHelpEsp := {}
		aHelpIng := {}
		
		//"Digite a loja para a nota"
		Aadd(aHelpPor,STR0020)
		Aadd(aHelpEsp,STR0020)
		Aadd(aHelpIng,STR0020)
		
		//�������������������Ŀ
		//�Busca a pergunta 4 �
		//���������������������
		DbSelectArea("SX1")
		DbSetOrder(1)
		nTamSX1   := Len(SX1->X1_GRUPO)
		If DbSeek(Padr(cPerg,nTamSX1) + "04")
			
			//���������������������������������������������������������Ŀ
			//�Se a resposta padrao para esta pergunta estiver for      �
			//�positiva, utiliza o Tamalho do campo cadastrado no grupo �
			//�de campos                                                �
			//�����������������������������������������������������������
			If SX1->X1_TAMANHO <> nTamLoja
				RecLock("SX1",.F.)
				REPLACE X1_TAMANHO WITH nTamLoja
				MsUnLock()
			EndIf
			
			If Alltrim(SX1->X1_VALID) <> "LjR130Cli()"
				RecLock("SX1",.F.)
				REPLACE X1_VALID WITH "LjR130Cli()" //Inclui validacao para a loja digitada.
				MsUnLock()
			EndIf
			
			//����������������������������������Ŀ
			//�Se nao existir, cria esta pergunta�
			//������������������������������������
		Else
			//��������������������������Ŀ
			//�Inclui a segunda pergunta �
			//����������������������������
			//"Loja       ?"
			PutSx1( cPerg  	,   "04"   	,   STR0021	,   STR0021		,	;
				STR0021	,"Mv_par04"	,	"C"		,	nTamLoja	,	;
				0		,	0		,	"G"		,	""			,	;
				""		,	""		,	""		,"Mv_par04"		,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				""		,	""		,	""		,	""			,	;
				aHelpPor,  aHelpIng	,  aHelpEsp	,	""				)
		EndIf
	EndIf
	
Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LjR130Cli  �Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida o codigo do cliente - localizacoes.                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LjR130Cli()
	
	Local lRet 		:= .T.															//Retorno da funcao
	Local cCliPad   := Alltrim(SuperGetMV("MV_CLIPAD",,"000001"))                   //Cliente padrao
	Local cLojPad   := Alltrim(SuperGetMV("MV_LOJAPAD",,"01"))                      //Loja padrao
	Local lAlterou  := .F.                                                          //Verifica se alterou o cliente ou a loja
	Local cCliente  := ""                                                           //Cliente
	Local cLoja     := ""                                                           //Loja
	Local cMvPar01	:= If(Empty(Mv_Par01),"",Mv_Par01)                              //Numero do cupom fiscal.
	Local cMvPar02	:= If(Empty(Mv_Par02),"",Mv_Par02)                              //Serie do cupom fiscal.
	Local cMvPar03	:= If(Empty(Mv_Par03),"",Mv_Par03)								//Cliente
	Local cMvPar04	:= If(Empty(Mv_Par04),SuperGetMV("MV_LOJAPAD",,"01"),Mv_Par04)	//Loja
	Local cMvPar10	:= If(Empty(Mv_Par10),"",Mv_Par10)								//Para o cliente
	Local cMvPar11	:= If(Empty(Mv_Par11),SuperGetMV("MV_LOJAPAD",,"01"),Mv_Par11)	//Para a loja
	Local lClLjPad  := .F.                                                          //Verifica se e cliente e loja padrao
	
	If lLegislacao
		cCliente 	:= cMvPar10
		cLoja    	:= cMvPar11
	Else
		cCliente := cMvPar03
		cLoja    := cMvPar04
	EndIf
	
	//�������������������������������������������������������Ŀ
	//�Realiza a busca no SA1 para validar o codigo do cliente�
	//���������������������������������������������������������
	DbSelectArea("SA1")
	DbSetOrder(1)
	If DbSeek(xFilial("SA1") + cCliente + cLoja)
		If lLegislacao
			If Empty(SA1->A1_CGC)
				//"Cliente n�o tem RCF. N�o sera poss�vel realizar a fatura."+"Aten��o"
				Ljr130Msg(STR0017,STR0018,1)
				
				lRet := .F.
			EndIf
		ElseIf cPaisLoc == "BRA"
			DbSelectArea("SL1")
			DbSetOrder(2)
			If DbSeek(xFilial("SL1")+ cMvPar02 + cMvPar01 ) //L1_FILIAL + L1_SERIE + L1_DOC
				
				lAlterou := Alltrim(SL1->L1_CLIENTE) <> Alltrim(cCliente) .OR. Alltrim(SL1->L1_LOJA) <> Alltrim(cLoja)
				lClLjPad := Alltrim(SL1->L1_CLIENTE) == cCliPad .AND. Alltrim(SL1->L1_LOJA) == cLojPad
				
				If lAlterou .AND. !lClLjPad 			//Nao permite alterar o cliente se o cupom nao foi gerado para o cliente e loja padrao.
					Ljr130Msg(STR0053+SL1->L1_DOC+STR0054,NIL,1)//Favor informar o cliente e a loja referentes ao numero do cupom fiscal:
					lRet := .F.							//Somente e possivel alterar o cliente e a loja caso o cupom fiscal tenha sido gerado para o cliente e loja padrao.
				EndIf
			EndIf
		EndIf
	Else
		//"Cliente n�o informado ou n�o existe no cadastro de Clientes"+"Aten��o"
		Ljr130Msg(STR0019,STR0018,1)
		lRet := .F.
	EndIf
	
	
	
	
	
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LjR130Val  �Autor  �Vendas e CRM       � Data �  18/07/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida se as TES estao configuradas corretamente no caso de���
���          � SF3 onLine.                                                ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LjR130Val(cTesNota,cTesServ)
	
	Local lRet 			:= .T.		// Retorno da funcao
	Local lVerTesProd 	:= .F.		// Se a TES de produto esta verificada
	Local lVerTesServ 	:= .F.		// Se a TES de servico esta verificada
	Local cMsgForm		:= ""		// Conteudo da formula utilizada
	Local aMsg130Erro	:= {}		// Mensagens de erro na configuracao de TES
	Local cMsgErro		:= ""		// Mensagem de erro
	Local nX			:= 0		// Variavel de for.
	Local oFont						// Objeto para apresentacao da tela
	Local oDlg						// Objeto para apresentacao da tela
	Local oMemo						// Objeto para apresentacao da tela
	
	Default cTesNota := ""			// Parametro MV_TESNOTA
	Default cTesServ := ""			// Parametro MV_LJNCUPS
	
	If lFisLivro
		
		lRet := .F.
		
		If !Empty(cTesServ) .AND. !Empty(cTesNota)
			
			DbSelectArea("SF4")
			DbSetOrder(1)
			If DbSeek(xFilial("SF4") + cTesNota)
				
				If cPaisLoc == "BRA"
					If !Empty(SF4->F4_LFICM) .AND. SF4->F4_LFICM <> "N"
						
						If !Empty(SF4->F4_FORMULA)
							
							cMsgForm := Alltrim(Formula(SF4->F4_FORMULA))
							
							If Alltrim(cMsgForm) == "S" .OR. Empty(cMsgForm)
								lVerTesProd := .T.
							Else
								//"A f�rmula (F4_FORMULA) utilizada na TES ("+ Alltrim(cTesNota) + ") de produto, informado no par�metro MV_TESNOTA, deve ter o conte�do de 'S' ou em branco."
								Aadd(aMsg130Erro,STR0022 + Alltrim(cTesNota) + STR0023 + STR0024)
							EndIf
							
						Else
							//"O campo de Formula (F4_FORMULA) do cadastro de TES ("+ Alltrim(cTesNota) + ") de produto,informado no par�metro MV_TESNOTA, deve ter uma f�rmula cadastrada."
							Aadd(aMsg130Erro,STR0025+ Alltrim(cTesNota) + STR0023 + STR0026)
						EndIf
						
					Else
						//"O campo L.Fisc. ICMS (F4_LFICM) do cadastro da TES ("+ Alltrim(cTesNota) + ") de produto, informado no par�metro MV_TESNOTA, deve ser diferente de 'N'."
						Aadd(aMsg130Erro,STR0027 + Alltrim(cTesNota) + STR0023 + STR0028)
					EndIf
				Else
					lVerTesProd := .T.
				EndIf
				
			Else
				//"TES " + Alltrim(cTesNota) + ", informado no par�metro MV_TESNOTA, n�o est� cadastrada na tabela de Tipos de Entrada e Sa�das."
				Aadd(aMsg130Erro,STR0029 + Alltrim(cTesNota) + STR0030)
			EndIf
			
			DbSelectArea("SF4")
			DbSetOrder(1)
			If DbSeek(xFilial("SF4") + cTesServ)
				
				If cPaisLoc == "BRA"
					If !Empty(SF4->F4_LFISS) .AND. SF4->F4_LFISS <> "N"
						
						If SF4->F4_ISS == "S"
							
							If !Empty(SF4->F4_FORMULA)
								
								cMsgForm := Alltrim(Formula(SF4->F4_FORMULA))
								
								If Alltrim(cMsgForm) == "S" .OR. Empty(cMsgForm)
									lVerTesServ := .T.
								Else
									//"A f�rmula (F4_FORMULA) utilizada na TES (" + Alltrim(cTesServ) + ") de servi�o, informado no par�metro MV_LJNCUPS, deve ter o conte�do de 'S' ou em branco."
									Aadd(aMsg130Erro,STR0022 + Alltrim(cTesServ) + STR0031 + STR0024)
								EndIf
							Else
								//"O campo de Formula (F4_FORMULA) do cadastro de TES (" + Alltrim(cTesServ) + ") de servi�o, informado no par�metro MV_LJNCUPS, deve ter uma f�rmula cadastrada."
								Aadd(aMsg130Erro,STR0025 + Alltrim(cTesServ) + STR0031 + STR0026)
							EndIf
						Else
							//"O campo C�lcula ISS (F4_ISS) do cadastro da TES (" + Alltrim(cTesServ) + ") de servi�o, informado no par�metro MV_LJNCUPS, deve estar como 'S'."
							Aadd(aMsg130Erro,STR0032 + Alltrim(cTesServ) + STR0031 + STR0033)
						EndIf
					Else
						//"O campo L.Fisc. ISS (F4_LFISS) do cadastro da TES (" + Alltrim(cTesServ) + ") de servi�o, informado no par�metro MV_LJNCUPS, deve ser diferente de 'N'."
						Aadd(aMsg130Erro,STR0034 + Alltrim(cTesServ) + STR0031 + STR0028)
					EndIf
				Else
					lVerTesServ := .T.
				EndIf
				
			Else
				//"TES " + Alltrim(cTesServ) + ", informado no par�metro MV_LJNCUPS, n�o est� cadastrada na tabela de Tipos de Entrada e Sa�das."
				Aadd(aMsg130Erro,STR0029 + Alltrim(cTesServ) + STR0035)
			EndIf
		Else
			//"Os par�metros MV_TESNOTA e MV_LJNCUPS n�o est�o preenchidos corretamente."
			Aadd(aMsg130Erro,STR0036)
		EndIf
		
		If lVerTesProd .AND. lVerTesServ
			lRet := .T.
		EndIf
	EndIf
	
	If !lRet
		//"A configuracao das TES de produto e servi�o n�o est�o corretas. Verificar:"
		cMsgErro := STR0037 + Chr(10)
		
		For nX := 1 To Len(aMsg130Erro)
			cMsgErro += Chr(10) + "- " +  aMsg130Erro[nX] + Chr(10)
		Next nX
		//"Por favor, regularize as situa��es acima para prosseguir na emiss�o da nota sobre cupom."
		cMsgErro +=	Chr(10) + STR0038
		
		If !lExecAt
			//����������������������������������������������������������Ŀ
			//�Monta tela com as informacoes do erro de configuracao     �
			//������������������������������������������������������������
			DEFINE FONT oFont NAME "ARIAL" SIZE 6,16
			//"Emiss�o de Nota sobre Cupom - Livro Fiscal OnLine"
			DEFINE MSDIALOG oDlg TITLE STR0039 From 3,0 to 340,417 PIXEL
			@ 5,5 GET oMemo  VAR cMsgErro MEMO SIZE 200,145 OF oDlg PIXEL
			oMemo:oFont:=oFont
			DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL
			ACTIVATE MSDIALOG oDlg CENTER
		Else
			Conout(cMsgErro)
			Aviso(cMsgErro)
		EndIf
	EndIf
	
	If !lRet .AND. lExecAt
		lMsErroAuto := .T.
	EndIf
	
Return lRet

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LjR130MkBrw�Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Tela para selecao dos cupons para geracao da nota          ���
���          � somente para emissao para multiplos cupons                 ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function LjR130MkBrw()
	
	Local cFiltraSF2 	:= ""
	Local cQrySF1		:= ""
	Local aIndexSF2	 	:= {}
	Local nTamF2NF      := Space(TamSx3("F2_NFCUPOM")[1])
	Local cMvPar03      := If(Empty(Mv_Par03),"",Mv_Par03)
	Local cMvPar05      := If(Empty(Mv_Par05),"",Mv_Par05)
	Local cCliente      := ""
	Local cLoja         := ""
	Local cEspecie 		:= LjRetEspec() //Retorna a Especie da NF para efetuar o filtro
	Local lInTran		:= InTransact()
	
	Private bFiltraBrw
	Private cCadastro 	:= STR0040 //"Emiss�o de Nota Sobre Cupom"
	Private aRotina		:= { 	{STR0041, "AxPesqui"	, 0, 1 , , .F.},;   //Pesquisar
	{STR0042, "LJ131Proc"	, 0, 2 , , .T.}		}//Processar
	
	DbSelectArea("SF2")
	SF2->(dbSetOrder(1))
	
	If !lExecAt
		
		cMvPar03 := PadL(cMvPar03,TamSx3("F2_DOC")[1],"0")
		cMvPar05 := PadL(cMvPar05,TamSx3("F2_DOC")[1],"0")
		
		cLoja 		:= Mv_Par08
		cCliente 	:= Mv_Par07
		
		cFiltraSF2	:= 'F2_FILIAL=="' + xFilial("SF2") + '".And. '
		cQrySF2     := "F2_FILIAL='"  + xFilial("SF2") + "' AND "
		
		If !Empty(cCliente) .And. !Empty(cLoja)
			cFiltraSF2	+= ' F2_CLIENTE=="' + cCliente + '".And.F2_LOJA=="' + cLoja + '" .And. '
			cQrySF2     += " F2_CLIENTE='" + cCliente + "' AND F2_LOJA = '" + cLoja + "' AND "
		Endif
		
		cFiltraSF2 += 'DTOS(F2_EMISSAO)>="' + DTOS(mv_par01) + '".And.DTOS(F2_EMISSAO)<="' + DTOS(mv_par02) + '".And.'
		cQrySF2    += "F2_EMISSAO>='" + DTOS(mv_par01) + "' AND F2_EMISSAO <= '" + DTOS(mv_par02) + "' AND "
		
		cFiltraSF2 += 'F2_DOC>="' + cMvPar03 + '".And.F2_DOC<="'   + cMvPar05 + '".And. '
		cQrySF2    += "F2_DOC>='" + cMvPar03 + "' AND F2_DOC <= '" + cMvPar05 + "' AND "
		
		/*	If lIsMexico
		cFiltraSF2 += 'Empty(F2_NFORI) .And. '
		cQrySF2	   += "F2_NFORI = '' AND "
	EndIf */
	
	cFiltraSF2 += 'F2_SERIE>="' + mv_par04 + '".And.F2_SERIE<="' + mv_par06 + '".And. '
	cQrySF2    += "F2_SERIE>='" + mv_par04 + "' AND F2_SERIE <= '" + mv_par06 + "' AND "
	
	If mv_par09 == 1
		cFiltraSF2 += 'Empty(F2_NFCUPOM) .And. F2_ESPECIE="CF"'
		cQrySF2    += "F2_NFCUPOM = '" + nTamF2NF + "' AND F2_ESPECIE ='CF'"
	Else
		cFiltraSF2 += '!Empty(F2_NFCUPOM) .And. F2_ESPECIE="'+cEspecie+'"'
		cQrySF2    += "F2_NFCUPOM <> '" + nTamF2NF + "' AND F2_ESPECIE ='"+cEspecie+"'"
	EndIf
	
Else
	/*
	MV_PAR01	:= aParam[1][1] // Doc Cupom
	MV_PAR02	:= aParam[1][2] // Serie Cupom
	MV_PAR03	:= aParam[1][3] // Cliente
	MV_PAR04	:= aParam[1][4] // Loja
	*/
	cLoja 		:= MV_PAR04
	cCliente 	:= MV_PAR03
	
	cFiltraSF2	:= 'F2_FILIAL=="' + xFilial("SF2") + '".And. '
	cQrySF2     := "F2_FILIAL='"  + xFilial("SF2") + "' AND "
	
	If !Empty(AllTrim(cCliente)) .And. !Empty(AllTrim(cLoja))
		cFiltraSF2	+= ' F2_CLIENTE=="' + cCliente + '".And.F2_LOJA=="' + cLoja + '" .And. '
		cQrySF2     += " F2_CLIENTE='" + cCliente + "' AND F2_LOJA = '" + cLoja + "' AND "
	Endif
	
	cFiltraSF2 += 'F2_DOC>="' + PadL(MV_PAR01,TamSx3("F2_DOC")[1],"0") + '" .And. '
	cQrySF2    += "F2_DOC>='" + PadL(MV_PAR01,TamSx3("F2_DOC")[1],"0") + "' AND "
	
	If lIsMexico
		cFiltraSF2 += 'Empty(F2_NFORI) .And. '
		cQrySF2	   += "F2_NFORI = '' AND "
	EndIf
	
	cFiltraSF2 += 'F2_SERIE="' + MV_PAR02 + '" '
	cQrySF2    += "F2_SERIE='" + MV_PAR02 + "' "
EndIf

bFiltraBrw 	:= {|x| IIf(x==Nil,FilBrowse("SF2",@aIndexSF2,@cFiltraSF2),cQrySF2)}

If !lInTran
	Eval(bFiltraBrw)
EndIf

DbSelectArea("SF2")
If SF2->(BOF()) .And. SF2->(EOF())
	//"N�o existem registros para serem apresentados com esses par�metros."
	Ljr130Msg(STR0043,NIL,1)
Else
	MarkBrow("SF2","F2_OK","",,,GetMark(,"SF2","F2_OK"))
	
	// Se nao foi feito o processamento de nenhuma nota, faz a verificacao da tabela SF2 e limpa o campo F2_OK
	If !lConfProc
		LjMsgRun( STR0061,,{|| Lj130RLimpa()} )		//
	Endif
	
EndIf

//������������������������������������������������������������������������Ŀ
//� Finaliza o uso da funcao FilBrowse e retorna os indices padroes.       �
//��������������������������������������������������������������������������
If !lInTran
EndFilBrw("SF2",aIndexSF2)
RetIndex("SF2")
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LJ131Proc  �Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Preparacao dos dados para processamento                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LJ131Proc(cAlias,nRecno,nOpcX)
	
	Local cLjExec 	:= IIf(lExecAt,STR0045,IIF(mv_par09 == 1, STR0044, STR0045))//"Gerar Nota Sobre Cupom", "Estornar Nota Sobre Cupom"
	Local aNfsSF2 	:= {}
	Local cArqSF2	:=CriaTrab(NIL,.F.)
	Local cIndice	:= ""
	Local cCondicao	:= ""
	Local nIndex	:= 0
	Local cEspecie 	:= AllTrim(LjRetEspec()) //Retorna a Especie da NF para efetuar o filtro
	
	//"Deseja realmente executar: "
	If Ljr130Msg(STR0046 + cLjExec + "?" , NIL , 3)
		
		dbSelectArea("SF2")
		cIndice:="F2_FILIAL+F2_OK+F2_NFCUPOM+F2_ESPECIE"
		
		If !lExecAt
			If mv_par09 == 1
				cCondicao := "!Empty(SF2->F2_OK) .AND. Empty(SF2->F2_NFCUPOM) .And. Alltrim(SF2->F2_ESPECIE) == 'CF'"
			Else
				cCondicao := "!Empty(SF2->F2_OK) .AND. !Empty(SF2->F2_NFCUPOM) .And. Alltrim(SF2->F2_ESPECIE) =='"+cEspecie+"'"
			EndIf
		Else
			cCondicao := "!Empty(SF2->F2_OK) .AND. Empty(SF2->F2_NFCUPOM) .And. Alltrim(SF2->F2_ESPECIE) == 'CF'"
		EndIf
		
		IndRegua("SF2",cArqSF2,cIndice,,cCondicao) //"Selecionando Registros..."
		
		nIndex := RetIndex("SF2")
		
		#IFNDEF TOP
			dbSetIndex(cArqSF2+OrdBagExt())
		#ENDIF
		
		DbSelectArea("SF2")
		SF2->(dbSetOrder(nIndex + 1))
		SF2->(DbSeek(xFilial("SF2"),.T.))
		
		While !SF2->(EOF())
			If Empty(SF2->F2_OK) .OR. Empty(SF2->F2_DOC + SF2->F2_SERIE)
				SF2->(DbSkip())
				Loop
			Endif
			
			If lLegislacao .AND. lIsMexico
				nQtdItens := 0
				DBSelectarea("SD2")
				SD2->(DBSetOrder(3))
				If SD2->(DBSeek(xFilial("SF2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA))
					While !SD2->(EOF()) .AND. (xFilial("SF2") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_CLIENTE + SD2->D2_LOJA == ;
							xFilial("SF2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA)
						nQtdItens ++
						SD2->(DBSkip())
					End
				EndIf
				Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno()),	;
					nQtdItens , SF2->F2_NFORI , IIf(!Empty(SF2->F2_APROFOL), .T. , .F. ) })
			Else
				Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})
			EndIf
			SF2->(DbSkip())
			Loop
		End
		
		dbSelectArea("SF2")
		RetIndex("SF2")
		FErase( cArqSF2+OrdBagExt())
		
		#IFDEF TOP
			SF2->(DbClearFilter())
		#ENDIF
		
		If Len(aNfsSF2) > 0
			If mv_par09 == 1
				If lExecAt
					LjR130VerInf(aNfsSF2)
				Else
					Processa( {|lEnd| LjR130VerInf(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'
				EndIf
			Else
				If lExecAt
					LjR130Estorn(aNfsSF2)
				Else
					Processa( {|lEnd| LjR130Estorn(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'
				EndIf
			EndIf
			// Altera valor para confirmado processamento
			lConfProc := .T.
		Else
			//Nenhum registro selecionado
			Ljr130Msg(STR0048,NIL,1)
		EndIf
		
		CloseBrowse(.T.)
	EndIf
	
Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao   LjR130Estorn �Autor  �Vendas Clientes	 � Data �  03/05/07   ���
�������������������������������������������������������������������������͹��
���Desc.     � Estorno da nota sobre cupom				                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LjR130Estorn(aNfsSF2)
	
	Local nX 		:= 0
	Local lLj7072	:= ExistBlock("LJ7072")			// Ponto de entrada LJ7072 que permite realizar tratamentos antes do estorno.
	
	If lLj7072	// Permite realizar tratamentos antes do estorno.
		ExecBlock( "LJ7072", .F., .F., { aNfsSF2 } )
	EndIf
	
	For nX := 1 To Len(aNfsSF2)
		
		DbSelectArea("MDL")
		MDL->(DbSetOrder(1))
		If MDL->(DbSeek(xFilial("MDL") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
			While !MDL->(EOF()) .AND. (MDL->MDL_FILIAL + MDL->MDL_NFCUP + MDL->MDL_SERIE) == (xFilial("MDL") + aNfsSF2[nX][1] + aNfsSF2[nX][2])
				
				DbSelectArea("SF2")
				SF2->(DbSetOrder(1))
				If SF2->(DbSeek(xFilial("SF2") + Padr(MDL->MDL_CUPOM,TamSx3("F2_DOC")[1]) + Padr(MDL->MDL_SERCUP,TamSx3("F2_SERIE")[1])))
					Reclock("SF2",.F.)
					Replace SF2->F2_NFCUPOM With ""
					Replace SF2->F2_OK 		With ""
					SF2->(MsUnLock())
				EndIf
				
				Reclock("MDL",.F.)
				MDL->(dbDelete())
				MDL->(MsUnLock())
				
				MDL->(DbSkip())
				Loop
			End
			
			
			DbSelectArea("SF3")
			SF3->(DbSetOrder(6))
			If SF3->(DbSeek(xFilial("SF3") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
				While !SF3->(EOF()) .AND. (SF3->F3_FILIAL + SF3->F3_NFISCAL + SF3->F3_SERIE) == (xFilial("SF3") + aNfsSF2[nX][1] + aNfsSF2[nX][2])
					
					Reclock("SF3",.F.)
					Replace SF3->F3_DTCANC With dDataBase
					Replace SF3->F3_OBSERV With "NF CANCELADA"
					SF3->(MsUnLock())
					
					SF3->(DbSkip())
					Loop
				End
			EndIf
			
			DbSelectArea("SFT")
			SFT->(DbSetOrder(1))
			If SFT->(DbSeek(xFilial("SFT") + "S" + aNfsSF2[nX][2] + aNfsSF2[nX][1]))
				While !SFT->(EOF()) .AND. (	SFT->FT_FILIAL + SFT->FT_TIPOMOV + SFT->FT_NFISCAL + SFT->FT_SERIE) == ;
						(	xFilial("SFT") + "S" + aNfsSF2[nX][1] + aNfsSF2[nX][2]		)
					
					Reclock("SFT",.F.)
					Replace SFT->FT_DTCANC With dDataBase
					Replace SFT->FT_OBSERV With "NF CANCELADA"
					SFT->(MsUnLock())
					
					SFT->(DbSkip())
					Loop
				End
			EndIf
			
			DbSelectArea("SD2")
			SD2->(DbSetOrder(3))
			If SD2->(DbSeek(xFilial("SD2") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
				While !SD2->(EOF()) .AND. (SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE) == (xFilial("SD2") + aNfsSF2[nX][1] + aNfsSF2[nX][2])
					
					Reclock("SD2",.F.)
					SD2->(dbDelete())
					SD2->(MsUnLock())
					
					SD2->(DbSkip())
					Loop
				End
			EndIf
			
			DbSelectArea("SF2")
			SF2->(DbSetOrder(1))
			If SF2->(DbSeek(xFilial("SF2") + aNfsSF2[nX][1] + aNfsSF2[nX][2]))
				
				Reclock("SF2",.F.)
				SF2->(dbDelete())
				SF2->(MsUnLock())
			EndIf
		EndIf
	Next nX
	
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �Lj130ChkNf �Autor  �Vendas e CRM       � Data �  19/08/09   ���
�������������������������������������������������������������������������͹��
���Desc.     � Verifica se ja existe uma Nf sobre cupom , caso exista     ���
���          � pergunt se deve excluir                                    ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Lj130ChkNf( cDoc , cSerie , cCliente , cLoja)
	
	Local lRet		 := .F.
	Local cStrNfCup	 := ""
	Local lDelet     := .F.
	Local cCliSF2    := ""
	Local cLjSF2     := ""
	Local nTamF2Doc  := TamSx3("F2_DOC")[1]
	Local nTamF2Ser  := TamSx3("F2_SERIE")[1]
	Local lContinua  := .T.
	Local cDocStrNf  := ""
	Local cSerStrNf  := ""
	Local cNextDoc   := ""
	Local cEspecie   := ""                              // Especie da nota fiscal sobre cupom.
	Local nQtdHoras  := 0                            	// Quantidade de horas em relacao a hora atual.
	Local dDtDigit 	 := dDataBase					    // Data da emissao da nota.
	Local nMvSpedExc := SuperGetMV("MV_SPEDEXC",,72)	// Indica a quantidade de horas que a NF ainda pode ser cancelada.
	
	DEFAULT cDoc     := ""
	DEFAULT cSerie   := ""
	DEFAULT cCliente := ""
	DEFAULT cLoja    := ""
	
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	If SF2->(DbSeek( xFilial("SF2") + cDoc + cSerie )) .And. !Empty(SF2->F2_NFCUPOM)
		cStrNfCup := Padr(SubStr(SF2->F2_NFCUPOM,nTamF2Ser+1,nTamF2Doc),nTamF2Doc) + SubStr(SF2->F2_NFCUPOM,1,nTamF2Ser)
		If !Ljr130Msg(STR0009 + cStrNfCup + STR0010 + cDoc + STR0050 , STR0018,3)		//"Ja existe uma Nota Fiscal ("xxx") gerada para o Cupom "xxx" - Deseja estornar/excluir esta NF sobre Cupom?" , Atencao
			lRet:=.T.
		Else		
				//Validacao do F2_NEXTDOC antes de excluir
				cDocStrNf := Substr(cStrNfCup, 1			,nTamF2Doc)
				cSerStrNf := Substr(cStrNfCup, nTamF2Doc+1	,nTamF2Ser)
				
				While lContinua
					DbSelectArea("SF2")
					SF2->( DbSetOrder(1) )
					If SF2->( DbSeek(xFilial("SF2") + cDocStrNf + cSerStrNf) )
						
						cEspecie := SF2->F2_ESPECIE
						cCliSF2  := SF2->F2_CLIENTE
						cLjSF2   := SF2->F2_LOJA
						//���������������������������������������������������������������������������������������������������Ŀ
						//� Verifica a quantidade de horas indicada no parametro MV_SPEDEXC e valida se a NF pode ser excluida�
						//�����������������������������������������������������������������������������������������������������
						If SF2->(FieldPos("F2_DAUTNFE")) > 0 .And. !Empty(SF2->F2_DAUTNFE)
							dDtDigit := SF2->F2_DAUTNFE
						ElseIf SF2->(FieldPos('F2_DTDIGIT')) > 0 .AND. !Empty(SF2->F2_DTDIGIT)
							dDtDigit := SF2->F2_DTDIGIT
						Else
							dDtDigit := SF2->F2_EMISSAO
						EndIf
						nQtdHoras := SubtHoras( dDtDigit, iIf( SF2->(FieldPos("F2_HAUTNFE")) > 0 .And. !Empty(SF2->F2_HAUTNFE),SF2->F2_HAUTNFE,SF2->F2_HORA ), dDataBase, SubStr(Time(),1,2)+":"+SubStr(Time(),4,2) )
						If "SPED"$cEspecie .AND. (SF2->F2_FIMP$"TS") //Verifica apenas a especie como SPED e notas que foram transmitidas ou impresso o DANFE
							If nQtdHoras > nMvSpedExc
								Ljr130Msg(STR0058+Alltrim(Str(nMvSpedExc))+STR0059,NIL,4)//"Nao foi possivel excluir a nota, pois o prazo definido para cancelamento foi de "#" hora(s)."
								lRet := .T.
								Return(lRet)
							EndIf
						EndIf
						
						cNextDoc := SF2->F2_NEXTDOC
						Reclock("SF2",.F.)
						dbDelete()
						MsUnLock()
						lDelet := .T.
						
						//�����������������������������������Ŀ
						//�Exclusao dos SD2 da NF sobre cupom.�
						//�������������������������������������
						DbSelectArea("SD2")
						DbSetOrder(3)
						If DbSeek(xFilial("SD2") + cDocStrNf + cSerStrNf)
							While !EOF() .AND. (SD2->D2_FILIAL + SD2->D2_DOC + SD2->D2_SERIE) == (xFilial("SD2") + cDocStrNf + cSerStrNf)
								Reclock("SD2",.F.)
								dbDelete()
								MsUnLock()
								DbSkip()
								Loop
							End
						EndIf
						
						//Limpa os campos do Cupom Fiscal
						DbSelectArea("SF2")
						DbSetOrder(1)
						If DbSeek(xFilial("SF2") + cDoc + cSerie )
							Reclock("SF2",.F.)
							Replace SF2->F2_NFCUPOM With ""
							Replace SF2->F2_OK 		With ""
							MsUnLock()
						EndIf
						
						//�����������������������������������Ŀ
						//�Exclusao dos SF3 da NF sobre cupom.�
						//�������������������������������������
						DbSelectArea("SF3")
						DbSetOrder(5)//F3_FILIAL+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA
						If DbSeek(xFilial("SF3") + cSerStrNf + cDocStrNf + cCliSF2 + cLjSF2)
							While !EOF() .AND. (SF3->F3_FILIAL + SF3->F3_SERIE + SF3->F3_NFISCAL + SF3->F3_CLIEFOR + SF3->F3_LOJA) == (xFilial("SF3") + cSerStrNf + cDocStrNf + cCliSF2 + cLjSF2)
								Reclock("SF3",.F.)
								Replace SF3->F3_DTCANC With dDataBase
								Replace SF3->F3_OBSERV With "NF CANCELADA"
								MsUnLock()
								DbSkip()
								Loop
							End
						EndIf
						
						//�����������������������������������Ŀ
						//�Exclusao dos SFT da NF sobre cupom.�
						//�������������������������������������
						DbSelectArea("SFT")
						DbSetOrder(4) //FT_FILIAL+FT_TIPOMOV+FT_CLIEFOR+FT_LOJA+FT_SERIE+FT_NFISCAL+FT_CFOP
						If DbSeek(xFilial("SFT") + "S" + cCliSF2 + cLjSF2 + cSerStrNf + cDocStrNf )
							While !EOF() .AND. 	(SFT->FT_FILIAL + SFT->FT_TIPOMOV + SFT->FT_CLIEFOR + SFT->FT_LOJA + SFT->FT_SERIE + SFT->FT_NFISCAL) == (xFilial("SFT") + "S" + cCliSF2 + cLjSF2 + cSerStrNf + cDocStrNf)
								Reclock("SFT",.F.)
								Replace SFT->FT_DTCANC With dDataBase
								Replace SFT->FT_OBSERV With "NF CANCELADA"
								MsUnLock()
								DbSkip()
								Loop
							End
						EndIf
						
						cDocStrNf := cNextDoc
						
						If Empty(cDocStrNf)
							lcontinua := .F.
						EndIf
					EndIf
				End
				
				If lDelet
					If lExecAt
						Conout(STR0052)
						Aviso(STR0051,STR0052,{STR0014})
					Else
						Aviso(STR0051,STR0052,{STR0014})
						//"Exclus�o conclu�da" , "Nota Fiscal sobre Cupom exclu�da com Sucesso!!!" , OK
					EndIf
				EndIf
				
			EndIf			
		
	Endif
	
	If !lRet .AND. lExecAt
		lMsErroAuto := .T.
	EndIf
	
Return( lRet )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Lj130F2OK	 �Autor  �Vendas Clientes  	 � Data �  14/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao �Limpa F2_OK                    							  ���
�������������������������������������������������������������������������͹��
���Uso       � LOJR130                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Lj130F2OK(aSeekNF)
	Local nX		:= 0			// Contador de For
	Local aAreaAtu	:= GetArea() 	// armazena a area local
	
	DbSelectArea("SF2")
	SF2->( DbSetOrder(1) )	//F2_FILIAL + F2_DOC + F2_SERIE + F2_CLIENTE + F2_LOJA
	
	For nX := 1 To Len(aSeekNF)
		If SF2->( DbSeek(xFilial("SF2") + aSeekNF[nX][1] + aSeekNF[nX][2]) )
			Reclock("SF2",.F.)
			Replace SF2->F2_OK With ""
			MsUnlock()
			SF2->(FKCommit())
		EndIf
	Next nX
	
	RestArea(aAreaAtu)
	
Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Ljr130Msg	 �Autor  �Vendas Clientes  	 � Data �  14/04/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Mostra a mensagem na tela com tratamento de execauto       ���
�������������������������������������������������������������������������͹��
���Uso       � LOJR130                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Ljr130Msg(cMsgShow,cMsgCab, nTipo)
	
	Local lRet := .T.
	
	DEFAULT cMsgShow := ""
	DEFAULT nTipo	 := 1
	DEFAULT cMsgCab	 := ""
	
	If lExecAt
		Conout(cMsgShow)
	EndIf
	
	Do Case
	Case nTipo == 1
		MsgStop(cMsgShow,cMsgCab)
	Case nTipo == 2
		MsgInfo(cMsgShow,cMsgCab)
	Case nTipo == 3
		lRet := MsgYesNo(cMsgShow,cMsgCab)
	OtherWise
		MsgAlert(cMsgShow,cMsgCab)
	EndCase
	
	
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LjRetEspec �Autor  � Varejo          	 � Data � 05/05/2014  ���
�������������������������������������������������������������������������͹��
���Descricao � Retorna a Especie a ser utilizada de acordo com a configu- ���
���          � racao dos parametros MV_LOJANF e MV_ESPECIE.               ���
�������������������������������������������������������������������������͹��
���Uso       � LOJR130                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LjRetEspec()
	Local cEspecie 	:= "NF" // Especie da NF
	Local cTiposDoc	:= "" 	// Tipos de documentos fiscais utilizados na emissao de notas fiscais
	Local nCount 	:= 0
	Local nPosSign	:= 0
	
	If cPaisLoc == "BRA"
		cTiposDoc := AllTrim( SuperGetMV( 'MV_ESPECIE' ) ) // Tipos de documentos fiscais utilizados na emissao de notas fiscais
		DbSelectArea("SX5")
		SX5->( DbSetOrder(1) )
		If cTiposDoc <> NIL
			cTiposDoc := StrTran( cTiposDoc, ";", CHR(13)+CHR(10))
			
			For nCount := 1 TO MLCount( cTiposDoc )
				cEspecie := ALLTRIM( StrTran( MemoLine( cTiposDoc,, nCount ), CHR(13), CHR(10) ) )
				nPosSign := Rat( "=", cEspecie)
				
				If nPosSign > 0 .AND. ALLTRIM( cSerie ) == ALLTRIM( SUBSTR( cEspecie, 1, nPosSign - 1 ) )
					If SX5->( DbSeek( xFilial("SX5") + "42" + SUBSTR(cEspecie, nPosSign + 1) ) )
						cEspecie := SUBSTR( cEspecie, nPosSign + 1 )
					Else
						cEspecie := SPACE(5)
					Endif
					Exit
				Else
					cEspecie := SPACE(5)
				Endif
			Next nCount
			
		Endif
	Endif
	
Return cEspecie


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �LjImpScript�Autor  � Varejo          	 � Data � 07/05/2014  ���
�������������������������������������������������������������������������͹��
���Descricao � Efetua a impress�o do Script de Impress�o da Nota          ���
�������������������������������������������������������������������������͹��
���Uso       � LOJR130                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
Static Function LjImpScript(cNumNota,cSerie,aRegSF2,wnrel)
	//ImprScipt(cNumNota,cSerie,aRegSF2,wnrel)
Return

Static Function  ImprScipt(cNumNota,cSerie,aRegSF2,wnrel)
	Local cScript  		:= SuperGetMV("MV_SCRNFCP")									// Parametro que indica o Arquivo de Script de impressao de NF para Cupom Fiscal
	Local cMV_LJIMPFA	:= SuperGetMV("MV_LJIMPFA",.F.,"1")							//Verifica se pergunta se deseja imprimir a nota
	Local lImprime		:= .T.
	
	//��������������������������������������������������������������Ŀ
	//�Chama o script de impress�o da nota depois da grava��o        �
	//�de todas as informacoes da NF                                 �
	//����������������������������������������������������������������
	DbSelectArea("SF2")
	SF2->(DbSetOrder(1))
	SF2->(DbGoTo(aRegSF2[1]))
	If lIsMexico
		If cMV_LJIMPFA == "1"
			lImprime := MsgYesNo(STR0060) //"Deseja realizar a impress�o da fatura de venda?"
		ElseIf cMV_LJIMPFA == "2"
			lImprime := .T.
		Else
			lImprime := .F.
		EndIf
	EndIf
	
	If lImprime
		If lRelMacroMex
			cScript := SubStr(cScript,At("&",cScript) + 1,Len(cScript))
			
			If At("(",cScript) > 0
				cScript := SubStr(cScript,At("(",cScript) + 1,Len(cScript)) //Pega somente o conteudo entre o parenteses
			EndIf
			
			If At(")",cScript) > 0
				cScript := SubStr(cScript,1,At(")",cScript)-1) //Pega somente o conteudo entre o parenteses
			EndIf
			
			//aParam[1] =
			// [1] Doc Cupom
			// [2] Serie Cupom
			// [3] aRegSF2
			ExecBlock(cScript, .F., .F.,{cNumNota,cSerie,aRegSF2})
		Else
			ExecBlock(cScript, .F., .F.,{cNumNota,cSerie,aRegSF2})
		EndIf
	EndIf
	
	If !lExecAt .OR. !lRelMacroMex
		Set Device To Screen
		
		DbSelectArea("SL1")
		SL1->( DbSetOrder(1) )
		Set Filter To
		
		If aReturn[5] == 1
			Set Printer To
			DbCommitAll()
			OurSpool(wnrel)
		Endif
		
		MS_FLUSH()
	Else
		DbCommitAll()
	EndIf
	
Return .T.

//--------------------------------------------------------
/*
Funcao responsavel por limpar o campo F2_OK quando o processamento nao for confirmado
@param   Sem parametro
@author  Varejo
@version P11.8
@since   04/12/2014
@return  Nil
/*/
//-------------------------------------------------------

Static Function Lj130RLimpa()
	
	SF2->(DbGoTop())
	Do While !SF2->(Eof())
		If !Empty(SF2->F2_OK)
			// Se encontrar um registro que esteja preenchido, realiza a limpeza
			Reclock("SF2",.F.)
			SF2->F2_OK 	:= ""
			SF2->(MsUnlock())
		Endif
		SF2->(DbSkip())
	Enddo
	// Volta o valor de lConfProc para .F.
	lConfProc := .F.
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �LJ131ProcM �Autor  �Vendas Clientes	 � Data �  28/01/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Processamento nota sobre multiplos cupons via execauto     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �LOJR130                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function LJ131ProcM(aNFAuto)
	
	Local cLjExec 	:= IIf(lExecAt,STR0045,IIF(mv_par09 == 1, STR0044, STR0045))//"Gerar Nota Sobre Cupom", "Estornar Nota Sobre Cupom"
	Local aNfsSF2 	:= {}
	Local cArqSF2	:= CriaTrab(NIL,.F.)
	Local cIndice	:= ""
	Local cCondicao	:= ""
	Local nIndex	:= 0
	Local cEspecie 	:= AllTrim(LjRetEspec()) //Retorna a Especie da NF para efetuar o filtro
	Local nX		:= 0
	
	Default aNFAuto := {}
	
	If Len(aNFAuto) > 0
		
		For nX := 1 To Len(aNFAuto)
			DbSelectArea("SF2")
			DbSetOrder(1)
			If SF2->(DbSeek( xFilial("SF2") + PadR(aNFAuto[nX][1] ,TamSx3("F2_DOC")[1]) + aNFAuto[nX][2]))
				If !lEstorno
					If Empty(SF2->F2_NFCUPOM) .AND. AllTrim(SF2->F2_ESPECIE) == "CF"
						Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})
					EndIf
				Else
					If !Empty(SF2->F2_NFCUPOM) .AND. Alltrim(SF2->F2_ESPECIE) == cEspecie
						Aadd(aNfsSF2,{SF2->F2_DOC,SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_EST,SF2->(Recno())})
					EndIf
				EndIf
			EndIf
			
		Next Nx
		
		If Len(aNfsSF2) > 0
			If !lEstorno
				If lExecAt
					LjR130VerInf(aNfsSF2)
				Else
					Processa( {|lEnd| LjR130VerInf(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'
				EndIf
			Else
				If lExecAt
					LjR130Estorn(aNfsSF2)
				Else
					Processa( {|lEnd| LjR130Estorn(aNfsSF2) } ,STR0047,,.T. ) //'Aguarde restaurando'
				EndIf
			EndIf
			// Altera valor para confirmado processamento
			lConfProc := .T.
		Else
			//Nenhum registro selecionado
			Ljr130Msg("LOJR130 - LJ131ProcM: " + STR0048,NIL,1)
		EndIf
		
	EndIf
	
Return Nil

Static Function GetNota(cNfSerie,aNotas)
	Local aAreaAtu:=GetArea()
	cNumProxNf := NxtSX5Nota(cNfSerie)//'000000905'//
	
	AAdd(aNotas,{cNfSerie,cNumProxNf})
	
	RestArea(aAreaAtu)
Return
