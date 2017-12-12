#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#DEFINE ITENSSC6 300

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �CPYRESIDUO� Autor � Rodrigo Okamoto       � Data �20/11/2010���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Prepara a funcao de copia para evitar que seja chamada a   ���
���          � janela de filiais                                          ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpC1: Alias do cabecalho do pedido de venda                ���
���          �ExpN2: Recno do cabecalho do pedido de venda                ���
���          �ExpN3: Opcao do arotina                                     ���
�������������������������������������������������������������������������Ĵ��
���Retorno   � Nenhum                                                     ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Function U_CPYRESIDUO(cAlias,nReg,nOpc)

Local aRotBkp := aClone(aRotina)

aRotina := { { OemToAnsi("Pesquisar"),"AxPesqui"  ,0,1},;		//"Pesquisar"
{ OemToAnsi("Visual"),"A410Visual",0,2},;		//"Visual"
{ OemToAnsi("Incluir"),"U_CPYRESD",0,3}}		//"Incluir"

lContCPY	:= u_ContCPY()

IF lContCPY
	U_CPYRESD(calias,nReg,3)
ENDIF

aRotina := aClone(aRotBkp)

Return(.T.)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �U_CPYRESD �Autor  �Rodrigo Okamoto        � Data �20.11.2010���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Copia do Pedido de Venda                                    ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpC1: Alias do cabecalho do pedido de venda                ���
���          �ExpN2: Recno do cabecalho do pedido de venda                ���
���          �ExpN3: Opcao do arotina                                     ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Esta rotina tem como objetivo efetuar a interface com o usua���
���          �rio e o pedido de vendas                                    ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Observacao�                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Materiais/Distribuicao/Logistica                           ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Function U_CPYRESD(cAlias,nReg,nOpc)

Local aArea     := GetArea()
Local aPosObj   := {}
Local aObjects  := {}
Local aSize     := {}
Local aPosGet   := {}
Local aRegSC6   := {}
Local aRegSCV   := {}
Local aInfo     := {}
Local lLiber 	:= .F.
Local lTransf	:= .F.
Local lGrade	:= MaGrade()
Local lQuery    := .F.
Local lContinua := .T.
Local lFreeze   := (SuperGetMv("MV_PEDFREZ",.F.,0) <> 0)
Local nOpcA		:= 0
Local nTotalPed := 0
Local nTotalDes := 0
Local nNumDec   := TamSX3("C6_VALOR")[2]
Local nGetLin   := 0
Local nStack    := GetSX8Len()
Local nColFreeze:= SuperGetMv("MV_PEDFREZ",.F.,0)
Local cArqQry   := "SC6"
Local cCadastro := OemToAnsi("Atualiza��o de Pedidos de Venda") //"Atualiza��o de Pedidos de Venda"
Local cTipoDat  := SuperGetMv("MV_TIPCPDT",.F.,"1")
Local oDlg
Local oGetd
Local dOrig     := Ctod("//")
Local dCopia    := Ctod("//")
Local oSAY1
Local oSAY2
Local oSAY3
Local oSAY4
Local lMt410Ace := Existblock("MT410ACE")

Local cSeek     := ""
Local aNoFields := {"C6_NUM","C6_QTDEMP","C6_QTDENT","C6_QTDEMP2","C6_QTDENT2"}		// Campos que nao devem entrar no aHeader e aCols
Local bWhile    := {|| }
Local cQuery    := ""
Local bCond     := {|| .T. }
Local bAction1  := {|| Mta410Cop(cArqQry,@nTotalPed,@nTotalDes,lGrade) }
Local bAction2  := {|| .T. }
Local lCopia    := .T.

PRIVATE cPedRes	:=	SC5->C5_NUM
//������������������������������������������������������Ŀ
//� Variaveis utilizadas na LinhaOk                      �
//��������������������������������������������������������
PRIVATE aCols      := {}
PRIVATE aHeader    := {}
PRIVATE aHeadFor   := {}
PRIVATE aColsFor   := {}
PRIVATE N          := 1

PRIVATE aGEMCVnd :={"",{},{}} //Template GEM - Condicao de Venda

//������������������������������������������������������Ŀ
//� Monta a entrada de dados do arquivo                  �
//��������������������������������������������������������
PRIVATE aTELA[0][0],aGETS[0]

//�����������������������������������������������������������Ŀ
//� Ponto de entrada para validar acesso do usuario na funcao �
//�������������������������������������������������������������
//If lMt410Ace
//	lContinua := Execblock("MT410ACE",.F.,.F.,{nOpc})
//Endif

//������������������������������������������������������Ŀ
//� Cria Ambiente/Objeto para tratamento de grade        �
//��������������������������������������������������������
If FindFunction("MsMatGrade") .And. IsAtNewGrd()
	//MsMatGrade():New(cObj,cProdRef,cCpo,cTudoOk,cVldCpoGrd,aSetKey,aCposCtrlGrd,lShowGrd)
	PRIVATE oGrade	  := MsMatGrade():New('oGrade',,"C6_QTDVEN",,"a410GValid()",;
	{ 	{VK_F4,{|| A440Saldo(.T.,oGrade:aColsAux[oGrade:nPosLinO][aScan(oGrade:aHeadAux,{|x| AllTrim(x[2])=="C6_LOCAL"})])}} },;
	{ 	{"C6_QTDVEN",.T.,{{"C6_UNSVEN",{|| ConvUm(AllTrim(oGrade:GetNameProd(,nLinha,nColuna)),aCols[nLinha][nColuna],0,2) } }} },;
	{"C6_QTDLIB",NIL,NIL},;
	{"C6_QTDENT",NIL,NIL},;
	{"C6_ITEM"	,NIL,NIL},;
	{"C6_UNSVEN", {{"C6_QTDVEN",{|| ConvUm(AllTrim(oGrade:GetNameProd(,nLinha,nColuna)),0,aCols[nLinha][nColuna],1) }}} },;
	{"C6_BLQ",NIL,NIL};
	})
Else
	PRIVATE aColsGrade := {}
	PRIVATE aHeadgrade := {}
EndIf

//������������������������������������������������������������������������Ŀ
//�Carrega perguntas do MATA440 e MATA410                                  �
//��������������������������������������������������������������������������
INCLUI := .T.
ALTERA := .F.

Pergunte("MTA440",.F.)
lLiber := MV_PAR02 == 1
lTransf:= MV_PAR01 == 1
Pergunte("MTA410",.F.)
//������������������������������������������������������Ŀ
//� Variavel utilizada p/definir Op. Triangulares.       �
//��������������������������������������������������������
IsTriangular( MV_PAR03==1 )
//������������������������������������������������������Ŀ
//� Salva a integridade dos campos de Bancos de Dados    �
//��������������������������������������������������������
dbSelectArea(cAlias)
IF ( (ExistBlock("M410ALOK")) )
	If (! ExecBlock("M410ALOK",.F.,.F.) )
		lContinua := .F.
	EndIf
EndIf
IF ( SC5->C5_FILIAL <> xFilial("SC5") )
	Help(" ",1,"A000FI")
	lContinua := .F.
EndIf
//������������������������������������������������������Ŀ
//| Se o Pedido foi originado no SIGATMS - Nao Copia     |
//��������������������������������������������������������
If SC5->(FieldPos("C5_SOLFRE")) > 0 .And. !Empty(SC5->C5_SOLFRE)
	Help(" ",1,"A410TMSNAO")
	lContinua := .F.
EndIf

//���������������������������������������������������������������������������Ŀ
//� Inicializa desta forma para criar uma nova instancia de variaveis private �
//�����������������������������������������������������������������������������
RegToMemory( "SC5", .F., .F. )

dOrig  := M->C5_EMISSAO
dCopia := CriaVar("C5_EMISSAO",.T.)

//���������������������������������������������������������������������������Ŀ
//� Limpa as variaveis que possuem amarracoes do pedido anterior              �
//�����������������������������������������������������������������������������
M->C5_NOTA  := Space(Len(SC5->C5_NOTA))
M->C5_SERIE := Space(Len(SC5->C5_SERIE))
M->C5_OS    := Space(Len(SC5->C5_OS))
M->C5_ORIGRES := cPedRes


If ( lContinua )
	dbSelectArea("SC6")
	dbSetOrder(1)
	#IFDEF TOP
		If TcSrvType()<>"AS/400" .And. !InTransact() .And. Ascan(aHeader,{|x| x[8] == "M"}) == 0
			lQuery  := .T.
			cQuery := "SELECT SC6.*,SC6.R_E_C_N_O_ SC6RECNO "
			cQuery += "FROM "+RetSqlName("SC6")+" SC6 "
			cQuery += "WHERE SC6.C6_FILIAL='"+xFilial("SC6")+"' AND "
			cQuery += "SC6.C6_NUM='"+SC5->C5_NUM+"' AND "
			cQuery += "SC6.D_E_L_E_T_<>'*' "
			cQuery += "ORDER BY "+SqlOrder(SC6->(IndexKey()))
			
			dbSelectArea("SC6")
			dbCloseArea()
		EndIf
	#ENDIF
	cSeek  := xFilial("SC6")+SC5->C5_NUM
	bWhile := {|| C6_FILIAL+C6_NUM }
	
//�������������������������������������������������������Ŀ
//� Montagem do aHeader e aCols                           �
//���������������������������������������������������������
//������������������������������������������������������������������������������������������������������������Ŀ
//�FillGetDados( nOpcx, cAlias, nOrder, cSeekKey, bSeekWhile, uSeekFor, aNoFields, aYesFields, lOnlyYes,       �
//�				  cQuery, bMountFile, lInclui )                                                                �
//�nOpcx			- Opcao (inclusao, exclusao, etc).                                                         �
//�cAlias		- Alias da tabela referente aos itens                                                          �
//�nOrder		- Ordem do SINDEX                                                                              �
//�cSeekKey		- Chave de pesquisa                                                                            �
//�bSeekWhile	- Loop na tabela cAlias                                                                        �
//�uSeekFor		- Valida cada registro da tabela cAlias (retornar .T. para considerar e .F. para desconsiderar �
//�				  o registro)                                                                                  �
//�aNoFields	- Array com nome dos campos que serao excluidos na montagem do aHeader                         �
//�aYesFields	- Array com nome dos campos que serao incluidos na montagem do aHeader                         �
//�lOnlyYes		- Flag indicando se considera somente os campos declarados no aYesFields + campos do usuario   �
//�cQuery		- Query para filtro da tabela cAlias (se for TOP e cQuery estiver preenchido, desconsidera     �
//�	           parametros cSeekKey e bSeekWhile)                                                              �
//�bMountFile	- Preenchimento do aCols pelo usuario (aHeader e aCols ja estarao criados)                     �
//�lInclui		- Se inclusao passar .T. para qua aCols seja incializada com 1 linha em branco                 �
//�aHeaderAux	-                                                                                              �
//�aColsAux		-                                                                                              �
//�bAfterCols	- Bloco executado apos inclusao de cada linha no aCols                                         �
//�bBeforeCols	- Bloco executado antes da inclusao de cada linha no aCols                                     �
//�bAfterHeader -                                                                                              �
//�cAliasQry	- Alias para a Query                                                                           �
//��������������������������������������������������������������������������������������������������������������
	FillGetDados(7,"SC6",1,cSeek,bWhile,{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,cQuery,/*bMontCols*/,.F.,/*aHeaderAux*/,/*aColsAux*/,{|| AfterCols(cArqQry,cTipoDat,dCopia,dOrig,lCopia) },/*bBeforeCols*/,/*bAfterHeader*/,"SC6")
	
	nTotalPed  -= M->C5_DESCONT
	nTotalDes  += M->C5_DESCONT
	nTotalDes  += A410Arred(nTotalPed*M->C5_PDESCAB/100,"C6_VALOR")
	nTotalPed  -= A410Arred(nTotalPed*M->C5_PDESCAB/100,"C6_VALOR")
	If ( lQuery )
		dbSelectArea(cArqQry)
		dbCloseArea()
		ChkFile("SC6",.F.)
		dbSelectArea("SC6")
	EndIf
EndIf
//�����������������������������������������������Ŀ
//�Monta o array com as formas de pagamento do SX5�
//�������������������������������������������������
Ma410MtFor(@aHeadFor,@aColsFor)
//������������������������������������������������������Ŀ
//� Caso nao ache nenhum item , abandona rotina.         �
//��������������������������������������������������������
If ( lContinua )
	If ( Len(aCols) == 0 )
		lContinua := .F.
	EndIf
EndIf
//���������������������������������������������������������������������������Ŀ
//� Ajusta as variaveis para copia                                            �
//�����������������������������������������������������������������������������
M->C5_NUM := CriaVar("C5_NUM",.T.)
M->C5_EMISSAO := CriaVar("C5_EMISSAO",.T.)
aRegSC6 := {}
aRegSCV := {}
//
// Template GEM - Gestao de Empreendimentos Imobiliarios
//
// Carrega a condicao de venda se a mesma tiver
// uma vinculacao com a pedido/condicao de pagamento
//
If ExistBlock("GEM410PV")
	aGEMCVnd := ExecBlock("GEM410PV",.F.,.F.,{ SC5->C5_NUM ,SC5->C5_CONDPAG ,M->C5_EMISSAO ,nTotalPed })
ElseIf ExistTemplate("GEM410PV")
	// Copia a condicao de venda
	aGEMCVnd := ExecTemplate("GEM410PV",.F.,.F.,{ SC5->C5_NUM ,SC5->C5_CONDPAG ,M->C5_EMISSAO ,nTotalPed })
EndIf

If ExistBlock("MT410CPY")
	ExecBlock("MT410CPY",.F.,.F.)
EndIf       

M->C5_YBLQPAL :=""
M->C5_YSTATUS :=""
M->C5_YAPROV  :="" 
M->C5_YULTMAR :=0

If ( lContinua )
	If ( Type("l410Auto") == "U" .OR. !l410Auto )
		//������������������������������������������������������Ŀ
		//� Faz o calculo automatico de dimensoes de objetos     �
		//��������������������������������������������������������
		aSize := MsAdvSize()
		aObjects := {}
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 015, .t., .f. } )
		aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
		aPosObj := MsObjSize( aInfo, aObjects )
		aPosGet := MsObjGetPos(aSize[3]-aSize[1],315,{{003,033,160,200,240,263}} )
		nGetLin := aPosObj[3,1]
		
		DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 to aSize[6],aSize[5] of oMainWnd PIXEL
		//������������������������������������������������������Ŀ
		//� Armazenar dados do Pedido anterior.                  �
		//��������������������������������������������������������
		IF M->C5_TIPO $ "DB"
			aTrocaF3 := {{"C5_CLIENTE","SA2"}}
		Else
			aTrocaF3 := {}
		EndIf
		EnChoice( "SC5", nReg, nOpc, , , , , aPosObj[1],,3,,,"A415VldTOk")
		@ nGetLin,aPosGet[1,1]  SAY OemToAnsi(IIF(M->C5_TIPO$"DB","Fornec.:","Cliente: ")) SIZE 020,09 PIXEL	//"Fornec.:"###"Cliente: "
		@ nGetLin,aPosGet[1,2]  SAY oSAY1 VAR Space(40)						SIZE 120,09 PICTURE "@!"	OF oDlg PIXEL
		@ nGetLin,aPosGet[1,3]  SAY OemToAnsi("Total :")						SIZE 020,09 OF oDlg PIXEL	//"Total :"
		@ nGetLin,aPosGet[1,4]  SAY oSAY2 VAR 0 PICTURE TM(0,16,Iif(cPaisloc=="CHI",NIL,nNumDec))	SIZE 050,09 OF oDlg PIXEL
		@ nGetLin,aPosGet[1,5]  SAY OemToAnsi("Desc. :")						SIZE 030,09 OF oDlg PIXEL 	//"Desc. :"
		@ nGetLin,aPosGet[1,6]  SAY oSAY3 VAR 0 PICTURE TM(0,16,Iif(cPaisloc=="CHI",NIL,nNumDec))		SIZE 050,09 OF oDlg PIXEL RIGHT
		@ nGetLin+10,aPosGet[1,5]  SAY OemToAnsi("=")							SIZE 020,09 OF oDlg PIXEL
		If cPaisLoc == "BRA"
			@ nGetLin+10,aPosGet[1,6]  SAY oSAY4 VAR 0								SIZE 050,09 PICTURE TM(0,16,2) OF oDlg PIXEL RIGHT
		Else
			@ nGetLin+10,aPosGet[1,6]  SAY oSAY4 VAR 0								SIZE 050,09 PICTURE TM(0,16,Iif(cPaisloc=="CHI",NIL,nNumDec)) OF oDlg PIXEL RIGHT
		EndIf
		oDlg:Cargo	:= {|c1,n2,n3,n4| oSay1:SetText(c1),;
		oSay2:SetText(n2),;
		oSay3:SetText(n3),;
		oSay4:SetText(n4) }
		Set Key VK_F4 to A440Stok(NIL,"A410")
		oGetd:=MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc,"A410LinOk","A410TudOk","+C6_ITEM/C6_Local/C6_TES/C6_CF/C6_PEDCLI",.T.,,nColFreeze,,ITENSSC6*IIF(MaGrade(),1,3.33),"A410Blq()",,,,,lFreeze)
		Private oGetDad:=oGetd
		A410Bonus(2)
		Ma410Rodap(oGetD,nTotalPed,nTotalDes)
//		ACTIVATE MSDIALOG oDlg ON INIT (A410Limpa(.F.,M->C5_TIPO),Ma410Bar(oDlg,{||nOpcA:=1,if(A410VldTOk(nOpc).And.oGetd:TudoOk(),If(!obrigatorio(aGets,aTela),nOpcA := 0,oDlg:End()),nOpcA := 0)},{||oDlg:End()},nOpc,oGetD))
		ACTIVATE MSDIALOG oDlg ON INIT (Ma410Bar(oDlg,{||nOpcA:=1,if(A410VldTOk(nOpc).And.oGetd:TudoOk(),If(!obrigatorio(aGets,aTela),nOpcA := 0,oDlg:End()),nOpcA := 0)},{||oDlg:End()},nOpc,oGetD))
		SetKey(VK_F4,)
	Else
		//��������������������������������������������������������������Ŀ
		//� validando dados pela rotina automatica                       �
		//����������������������������������������������������������������
		If EnchAuto(cAlias,aAutoCab,{|| Obrigatorio(aGets,aTela)},aRotina[nOpc][4]) .and. MsGetDAuto(aAutoItens,"A410LinOk",{|| A410VldTOk(nOpc) .and. A410TudOk()},aAutoCab)
			nOpcA := 1
		EndIf
	EndIf
	If ( nOpcA == 1 )
		A410Bonus(1)
		If Type("lOnUpDate") == "U" .Or. lOnUpdate
			//�����������������������������������������������������������Ŀ
			//� Inicializa a gravacao dos lancamentos do SIGAPCO          �
			//�������������������������������������������������������������
			PcoIniLan("000100")
			
			If !A410Grava(lLiber,lTransf,1,aHeadFor,aColsFor,aRegSC6,aRegSCV,nStack)
				Help(" ",1,"A410NAOREG")
			EndIf
			If ( (ExistBlock("M410STTS") ) )
				ExecBlock("M410STTS",.f.,.f.)
			EndIf
			
			//�����������������������������������������������������������Ŀ
			//� Finaliza a gravacao dos lancamentos do SIGAPCO            �
			//�������������������������������������������������������������
			PcoFinLan("000100")
			
		Else
			aAutoCab := MsAuto2Ench("SC5")
			aAutoItens := MsAuto2Gd(aHeader,aCols)
		EndIf
	Else
		While GetSX8Len() > nStack
			RollBackSX8()
		EndDo
		If ( (ExistBlock("M410ABN")) )
			ExecBlock("M410ABN",.f.,.f.)
		EndIf
	EndIf
EndIf
//������������������������������������������������������������������������Ŀ
//�Destrava Todos os Registros                                             �
//��������������������������������������������������������������������������
MsUnLockAll()
RestArea(aArea)
Return( nOpcA )


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �Mta410Cop � Autor � Marco Bianchi         � Data � 30/01/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao executada a partir da FillGetdados para validar cada ���
���          �registro da tabela. Se retornar .T. FILLGETDADOS considera  ���
���          �o registro, se .F. despreza o registro.                     ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �MColsCop()                                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametro �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � MATA410                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function Mta410Cop(cArqQry,nTotalPed,nTotalDes,lGrade)

Local lRet      := .T.
Local lCriaCols := .F.		// Nao permitir que a funcao A410Grade crie o aCols
Local nTamaCols :=Len(aCols)
Local nPosItem  := GDFieldPos("C6_ITEM")
Local nPosQtd   := GDFieldPos("C6_QTDVEN")
Local nPosQtd2  := GDFieldPos("C6_UNSVEN")
Local nPosVlr   := GDFieldPos("C6_VALOR")
Local nPosSld   := GDFieldPos("C6_SLDALIB")
Local nPosDesc  := GDFieldPos("C6_VALDESC")
                         
IF (cArqQry)->C6_QTDVEN == (cArqQry)->C6_QTDENT .OR. C6_BLQ == "R"
	lRet	:= .F.
	Return lRet
ENDIF

//������������������������������������������������������Ŀ
//� Verifica se este item foi digitada atraves de uma    �
//� grade, se for junta todos os itens da grade em uma   �
//� referencia , abrindo os itens so quando teclar enter �
//� na quantidade                                        �
//��������������������������������������������������������
If ( (cArqQry)->C6_GRADE == "S" .And. lGrade )
	a410Grade(.T.,,cArqQry,.F.,lCriaCols)
	If ( nTamAcols==0 .Or. aCols[nTamAcols][nPosItem] <> (cArqQry)->C6_ITEM )
		lRet := .T.	
	Else
		lRet := .F.	
		nQtdVenCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)
		nUnsVenCPY	:= (cArqQry)->(C6_UNSVEN - C6_QTDENT)
		aCols[nTamAcols][nPosQtd]  += nQtdVenCPY //(cArqQry)->(C6_QTDVEN)
		aCols[nTamAcols][nPosQtd2] += nUnsVenCPY //(cArqQry)->(C6_UNSVEN)
		nValDESCCPY := (cArqQry)->C6_VALDESC - ((cArqQry)->C6_QTDENT*(cArqQry)->C6_VALDESC)
		If ( nPosDesc > 0 )
			aCols[nTamAcols][nPosDesc] += nValDESCCPY //(cArqQry)->C6_VALDESC
		Endif
		If ( nPosSld > 0 )
			aCols[nTamAcols][nPosSld] += Ma440SaLib()
		EndIf
		nValTOTCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)*(cArqQry)->C6_PRCVEN
		aCols[nTamAcols][nPosVlr] += nValTOTCPY //(cArqQry)->C6_VALOR
	EndIf
EndIf

//CALCULA SOMENTE O VALOR DO RESIDUO PARA A INCLUSAO DO NOVO PEDIDO
nQtdVenCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)
nValDESCCPY := (cArqQry)->C6_VALDESC - ((cArqQry)->C6_QTDENT*(cArqQry)->C6_VALDESC)
nValTOTCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)*(cArqQry)->C6_PRCVEN
nTotalPed += nValTOTCPY //(cArqQry)->C6_VALOR
If ( (cArqQry)->C6_PRUNIT = 0 )
	nTotalDes += nValDESCCPY //(cArqQry)->C6_VALDESC
Else
	nTotalDes += A410Arred(((cArqQry)->C6_PRUNIT*nQtdVenCPY),"C6_VALOR")-A410Arred(((cArqQry)->C6_PRCVEN*nQtdVenCPY),"C6_VALOR")
EndIf

Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AfterCols � Autor � Marco Bianchi         � Data � 24/01/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao executada apos inclusao de nova linha no aCols pela  ���
���          �FillgetDados.                                               ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �AfterCols()                                                 ���
�������������������������������������������������������������������������Ĵ��
���Parametro �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � MATA410                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AfterCols(cArqQry,cTipoDat,dCopia,dOrig,lCopia)
           
Local nPosProd  := GDFieldPos("C6_PRODUTO")
Local nPosGrade := GDFieldPos("C6_GRADE")
Local cMascara  := SuperGetMv("MV_MASCGRD")
Local nTamRef   := Val(Substr(cMascara,1,2))
Local nPIdentB6 := GDFieldPos("C6_IDENTB6")
Local nPEntreg  := GDFieldPos("C6_ENTREG")
Local nPPedCli  := GDFieldPos("C6_PEDCLI")
Local nQtdLib   := GDFieldPos("C6_QTDLIB")
Local nQtdven   := GDFieldPos("C6_QTDVEN")
Local nQtdent   := GDFieldPos("C6_QTDENT")
Local nUnsven   := GDFieldPos("C6_UNSVEN")
Local nValor    := GDFieldPos("C6_VALOR")
Local nPrcven   := GDFieldPos("C6_PRCVEN")

Local nAux      := 0
Local aLiberado := {}
Local cCampo    := ""

DEFAULT lCopia  := .F.
                                 
If nPosGrade > 0 .And. aCols[Len(aCols)][nPosGrade] == "S"
	aCols[Len(aCols)][nPosProd] := SubStr((cArqQry)->C6_PRODUTO,1,nTamRef)
Else
	//��������������������������������������������������������������Ŀ
	//� Mesmo nao sendo um item digitado atraves de grade e' necessa-�
	//� rio criar o Array referente a este item para controle da     �
	//� grade                                                        �
	//����������������������������������������������������������������
	If FindFunction("MsMatGrade") .And. IsAtNewGrd()
		oGrade:MontaGrade(Len(aCols))
	Else
		MatGrdMont(Len(aCols))
	EndIf 
EndIf	

If Altera
	If ( SC5->C5_TIPO <> "D" )
		nAux := aScan(aLiberado,{|x| x[2] == aCols[Len(aCols)][nPIdentB6]})
		If ( nAux == 0 )
			aadd(aLiberado,{ (cArqQry)->C6_ITEM , aCols[Len(aCols)][nPIdentB6] , (cArqQry)->C6_QTDEMP, (cArqQry)->C6_QTDENT })
		Else
			aLiberado[nAux][3] += (cArqQry)->C6_QTDEMP
			aLiberado[nAux][4] += (cArqQry)->C6_QTDENT
		EndIf
	Else
		nAux := aScan(aLiberado,{|x| x[1] == (cArqQry)->C6_SERIORI .And.;
		x[2] == (cArqQry)->C6_NFORI   .And.;
		x[3] == (cArqQry)->C6_ITEMORI })
		If ( nAux == 0 )
			aadd(aLiberado,{ (cArqQry)->C6_SERIORI , (cArqQry)->C6_NFORI , (cArqQry)->C6_ITEMORI , (cArqQry)->C6_QTDEMP })
		Else
			aLiberado[nAux][4] += (cArqQry)->C6_QTDEMP
		EndIf
	EndIf
	// Necessario para disparar inicializador padrao
	aCols[Len(aCols)][nQtdLib] := CriaVar("C6_QTDLIB")
EndIf

If lCopia
	cCampo := Alltrim(aHeader[nPEntreg,2])           
	Do Case
		Case cTipoDat == "1"
			aCols[Len(aCols)][nPEntreg] := FieldGet(FieldPos(cCampo))
		Case cTipoDat == "2"
			aCols[Len(aCols)][nPEntreg] := If(FieldGet(FieldPos(cCampo)) < dCopia,dCopia,FieldGet(FieldPos(cCampo)) )
		Case cTipoDat == "3"
			aCols[Len(aCols)][nPEntreg] := dCopia + (FieldGet(FieldPos(cCampo)) - dOrig )
	EndCase

	If SubStr(aCols[Len(aCols)][nPPedCli],1,3)=="TMK"
		aCols[Len(aCols)][nPPedCli] := CriaVar(cCampo)
	EndIf	
//FAZ O CALCULO PARA A QUANTIDADE E VALOR DO NOVO ACOLS
	nNewQtd	:= (cArqQry)->C6_QTDVEN-(cArqQry)->C6_QTDENT
	nNewUns	:= ConvUM(padr(aCols[Len(aCols)][nPosProd],15), nNewQtd, 0, 2)
	nNewVal	:= nNewQtd * (cArqQry)->C6_PRCVEN
	aCols[Len(aCols)][nQtdven] := nNewQtd
	aCols[Len(aCols)][nUnsven] := nNewUns
	aCols[Len(aCols)][nValor] 	:= nNewVal

	//������������������������������������������������������Ŀ
	//� Estes campos nao podem ser copiados                  �
	//��������������������������������������������������������
	GDFieldPut("C6_QTDLIB"  ,CriaVar("C6_QTDLIB"  ))
	GDFieldPut("C6_RESERVA" ,CriaVar("C6_RESERVA" ))
	GDFieldPut("C6_CONTRAT" ,CriaVar("C6_CONTRAT" ))
	GDFieldPut("C6_ITEMCON" ,CriaVar("C6_ITEMCON" ))
	GDFieldPut("C6_PROJPMS" ,CriaVar("C6_PROJPMS" ))
	GDFieldPut("C6_EDTPMS"  ,CriaVar("C6_EDTPMS"  ))
	GDFieldPut("C6_TASKPMS" ,CriaVar("C6_TASKPMS" ))
	GDFieldPut("C6_LICITA"  ,CriaVar("C6_LICITA"  ))
	GDFieldPut("C6_PROJET"  ,CriaVar("C6_PROJET"  ))
	GDFieldPut("C6_ITPROJ"  ,CriaVar("C6_ITPROJ"  ))
	GDFieldPut("C6_CONTRT"  ,CriaVar("C6_CONTRT"  ))
	GDFieldPut("C6_TPCONTR" ,CriaVar("C6_TPCONTR" ))
	GDFieldPut("C6_ITCONTR" ,CriaVar("C6_ITCONTR" ))
	GDFieldPut("C6_NUMOS"   ,CriaVar("C6_NUMOS"   ))
	GDFieldPut("C6_NUMOSFAT",CriaVar("C6_NUMOSFAT"))
	GDFieldPut("C6_OP"      ,CriaVar("C6_OP"      ))
	GDFieldPut("C6_NUMOP"   ,CriaVar("C6_NUMOP"   ))
	GDFieldPut("C6_ITEMOP"  ,CriaVar("C6_ITEMOP"  ))
	GDFieldPut("C6_NUMORC"  ,CriaVar("C6_NUMORC"  ))
	GDFieldPut("C6_BLQ"     ,CriaVar("C6_BLQ"     ))
	GDFieldPut("C6_NOTA"    ,CriaVar("C6_NOTA"    ))
	GDFieldPut("C6_SERIE"   ,CriaVar("C6_SERIE"   ))
	
EndIf

Return(.T.) 


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �A410Bonus � Autor �Eduardo Riera          � Data �16.06.2001���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Rotina de tratamento da regra de bonificacao para interface ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpN1: Tipo de operacao                                     ���
���          �       [1] Inclusao do bonus                                ���
���          �       [2] Exclusao do bonus                                ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Esta rotina tem como objetivo avaliar a regra de bonificacao���
���          �e adicionar na respectiva interface                         ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Observacao�                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Materiais/Distribuicao/Logistica                           ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function A410Bonus(nTipo)

Local aArea     := GetArea()
Local aBonus    := {}
Local lA410BLCo := ExistBlock("A410BLCO")
Local nX        := 0
Local nY        := 0
Local nW        := 0 
Local nZ        := Len(aCols)
Local nUsado    := Len(aHeader)
Local nPProd    := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO" })
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN" })
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN" })
Local nPValor   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR" })
Local nPTES		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES" })
Local nPItem	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM" })
Local nPQtdLib  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDLIB" })
//��������������������������������������������������������Ŀ
//�Verifica os bonus                                       �
//����������������������������������������������������������
If nTipo == 1
	Ma410GraGr()
	If M->C5_TIPO=="N"
		//��������������������������������������������������������Ŀ
		//�Verifica os bonus por item de venda                     �
		//����������������������������������������������������������
		If ExistBlock('A410BONU')
			aBonus	:=	ExecBlock('A410BONU',.F.,.F.,{aCols,{nPProd,nPQtdVen,nPTES}})
		Else
			aBonus   := FtRgrBonus(aCols,{nPProd,nPQtdVen,nPTES},M->C5_CLIENTE,M->C5_LOJACLI,M->C5_TABELA,M->C5_CONDPAG)
		Endif
		//��������������������������������������������������������Ŀ
		//�Recupera os bonus ja existentes                         �
		//����������������������������������������������������������
		aBonus   := FtRecBonus(aCols,{nPProd,nPQtdVen,nPTES,nUsado+1},aBonus)
		//��������������������������������������������������������Ŀ
		//�Grava os novos bonus                                    �
		//����������������������������������������������������������
		nY := Len(aBonus)
		If nY > 0
			cItem := aCols[nZ,nPItem]
			For nX := 1 To nY
				cItem := Soma1(cItem)
				aadd(aCols,Array(nUsado+1))
				nZ++
				N := nZ
				For nW := 1 To nUsado
					If (aHeader[nW,2] <> "C6_REC_WT") .And. (aHeader[nW,2] <> "C6_ALI_WT")
						aCols[nZ,nW] := CriaVar(aHeader[nW,2],.T.)
					EndIf	
				Next nW
				aCols[nZ,nUsado+1] := .F.
				aCols[nZ,nPItem  ] := cItem
				A410Produto(aBonus[nX][1],.F.)
				A410MultT("M->C6_PRODUTO",aBonus[nX][1])
				A410MultT("M->C6_TES",aBonus[nX][3])
				aCols[nZ,nPProd  ] := aBonus[nX][1]
				
 				If ExistTrigger("C6_PRODUTO")
   					RunTrigger(2,Len(aCols))
				Endif

				aCols[nZ,nPQtdVen] := aBonus[nX][2]
				aCols[nZ,nPTES   ] := aBonus[nX][3]
				If ( aCols[nZ,nPPrcVen] == 0 )
					aCols[nZ,nPPrcVen] := 1
					aCols[nZ,nPValor ] := aCols[nZ,nPQtdVen]
				Else
					aCols[nZ,nPValor ] := A410Arred(aCols[nZ,nPQtdVen]*aCols[nZ,nPPrcVen],"C6_VALOR")
				EndIf
				
 				If ExistTrigger("C6_TES    ")
   					RunTrigger(2,Len(aCols))
				Endif

				If mv_par01 == 1 
					aCols[nZ,nPQtdLib ] := aCols[nZ,nPQtdVen ]
				Endif

				If lA410BLCo
					aCols[nZ] := ExecBlock("A410BLCO",.F.,.F.,{aHeader,aCols[nZ]})
				Endif
			Next nX
		EndIf
	EndIf
Else
	FtDelBonus(aCols,{nPProd,nPQtdVen,nPTES,nUsado+1})	
EndIf
RestArea(aArea)
Return(.T.)



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �Ma410Bar  � Autor � Eduardo Riera         � Data � 18.02.99 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � EnchoiceBar especifica do Mata410                          ���
�������������������������������������������������������������������������Ĵ��
���Retorno   � Nenhum                                                     ���
�������������������������������������������������������������������������Ĵ��
���Parametros� oDlg: 	Objeto Dialog                                     ���
���          � bOk:  	Code Block para o Evento Ok                       ���
���          � bCancel: Code Block para o Evento Cancel                   ���
���          � nOpc:    nOpc transmitido pela mbrowse                     ���
���          � aForma: Array com as formas de pagamento                   ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Ma410Bar(oDlg,bOk,bCancel,nOpc,oGetD)

Local aButtons  := {}
Local aButtonUsr:= {}
Local nI        := 0
LOCAL lOpcPadrao:= GetNewPar("MV_REPGOPC","N") == "N"
Local nPProduto	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local nPOpcional:= If(lOpcPadrao,aScan(aHeader,{|x| AllTrim(x[2])=="C6_OPC"}),aScan(aHeader,{|x| AllTrim(x[2])=="C6_MOPC"}))

If ( nOpc == 3 .Or. nOpc == 4 .Or. (nOpc == 2 .And. !AtIsRotina("A450F4CON")) )
	aadd(aButtons,{"POSCLI",{|| If(M->C5_TIPO=="N".And.!Empty(M->C5_CLIENTE),a450F4Con(),.F.),Pergunte("MTA410",.F.)},"Posi��o de Cliente","Posi��o de Cliente" }) 	//"Posi��o de Cliente"
EndIf
aadd(aButtons,{"BUDGET",{|| Ma410ForPg(nOpc)},"Formas de Pagamento", "Formas de Pagamento" }) //"Formas de Pagamento"
aadd(aButtons,{"RELATORIO",{||Ma410Impos(aRotina[ nOpc, 4 ])},"Planilha Financeira", "Planilha Financeira" })	//"Planilha Financeira"

//������������������������������������������������������������������������Ŀ
//�Ponto de entrada para verificar se o usuario pode acessar a formacao    �
//��������������������������������������������������������������������������
If VerSenha(107) //Permite consulta a Formacao de Precos
	If ExistBlock("A410BPRC")
		If ExecBlock("A410BPRC",.F.,.F.)
			aadd(aButtons,{"AUTOM",{||Ma410Forma()},"Formacao de Precos","Formacao de Precos" })	//"Formacao de Precos"
		Endif
	Else
		aadd(aButtons,{"AUTOM",{||Ma410Forma()},"Formacao de Precos","Formacao de Precos" })	//"Formacao de Precos"
	Endif
EndIf

If ( aRotina[ nOpc, 4 ] == 2 .Or. aRotina[ nOpc, 4 ] == 6 ) .And. !AtIsRotina("A410TRACK")
	AAdd(aButtons,{ "BMPVISUAL", {|| A410Track() }, "System Tracker", "System Tracker" } )  // "System Tracker"
EndIf
If !( nOpc == 2 .Or. nOpc == 5 ) .And. AtIsRotina("MATA410")
	If ExistBlock("A410BPRO")
		If ExecBlock("A410BPRO",.F.,.F.)
			Aadd(aButtons,{"PRODUTO", {|| Ma410BOM(aHeader,aCols,N) } ,"Estrutura de Produto","Estr.Prod."}) //"Estrutura de Produto"###"Estr.Prod."
		EndIf
	Else
		Aadd(aButtons,{"PRODUTO", {|| Ma410BOM(aHeader,aCols,N) } ,"Estrutura de Produto","Estr.Prod."}) //"Estrutura de Produto"###"Estr.Prod."	
	EndIf
EndIf
Aadd(aButtons,{"PESQUISA",{|| GdSeek(oGetD,"Pesquisar",,,.F.)},"Pesquisar","Pesquisar"}) //"Pesquisar"
If ( nOpc == 1 .Or. nOpc == 2 .Or. nOpc == 5 ) .And. nPOpcional > 0
	Aadd(aButtons,{"SDUCOUNT", {|| SeleOpc(2,,aCols[n][nPProduto],,,Ma410Opc(lOpcPadrao,nPOpcional),"M->C6_PRODUTO",.T.) } ,"Opcionais Selecionados","Opcionais"}) //"Opcionais Selecionados"###"Opcionais"
EndIf

//������������������������������������������������������������������������Ŀ
//�Pontos de Entrada 													   �
//��������������������������������������������������������������������������
If ExistTemplate("A410CONS",,.T.)
	aButtonUsr := ExecTemplate("A410CONS",.F.,.F.)
	If ValType(aButtonUsr) == "A" 
		For nI   := 1  To  Len(aButtonUsr)
			Aadd(aButtons,aClone(aButtonUsr[nI]))
		Next nI
	EndIf
EndIf
If ExistBlock("A410CONS",,.T.)
	aButtonUsr := ExecBlock("A410CONS",.F.,.F.)
	If ValType(aButtonUsr) == "A"
		For nI   := 1  To  Len(aButtonUsr)
			Aadd(aButtons,aClone(aButtonUsr[nI]))
		Next nI
	EndIf
EndIf

Return (EnchoiceBar(oDlg,bOK,bcancel,,aButtons))




//������������������������������������������������������������������������Ŀ
//�ContCPY - Programa para avaliar se continua a copia do residuo. 
//�N�o pode considerar o campo C5_NOTA pois o campo somente � gravado ap�s
//�o faturamento de todos os itens.
//��������������������������������������������������������������������������

User Function ContCPY

aAreaSC6	:= SC6->(GetArea())
cFaturado:= ""
lretCPY	:= .T.


IF !EMPTY(SC5->C5_NOTA)
	lretCPY := .F.
	Help(" ",1,"CPYRESID")
	RestArea(aAreaSC6)
	return(lretCPY)
ENDIF

DbSelectArea("SC6")
DbSetOrder(1)
DbSeek(xFilial("SC6")+SC5->C5_NUM)

Do While !eof() .and. xFilial("SC6")+SC5->C5_NUM == SC6->C6_FILIAL+SC6->C6_NUM
IF SC6->C6_QTDENT	> 0 .and. empty(SC6->C6_BLQ)
	cFaturado	+= "S"
ENDIF
	DbSelectArea("SC6")
	DbSkip()
EndDo

IF EMPTY(cFaturado)
	lretCPY := .F.
	Help(" ",1,"CPYRESID")
ENDIF

RestArea(aAreaSC6)

return(lretCPY)
