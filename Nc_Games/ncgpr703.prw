#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"
/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �NCGPR703� Rotina para envio de WF de Inadimplencia                       ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �08/06/13� ACPD                                                           ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es �                                                                         ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  �99/99/99 - Consultor - Descri��o da altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
User Function NCGPR703( aParam )
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������

//�����������������������������������������������������������������������������������������Ŀ
//� Se foi passado os par�metros � porque foi chamado pelo JOB                              �
//�������������������������������������������������������������������������������������������
If ValType( aParam ) == "A"
	//�������������������������������������������������������������������������������������Ŀ
	//� Inicializa o ambiente da empresa                                                    �
	//���������������������������������������������������������������������������������������
	RpcSetEnv(aParam[1],aParam[2])
	//�������������������������������������������������������������������������������������Ŀ
	//� Executa a rotina principal                                                          �
	//���������������������������������������������������������������������������������������
	U_PR703RUN( .T., aParam[3] )
	//�������������������������������������������������������������������������������������Ŀ
	//� Fecha o ambiente aberto                                                             �
	//���������������������������������������������������������������������������������������
	RpcClearEnv()
	//�����������������������������������������������������������������������������������������Ŀ
	//� Chamada da rotina pelo menu do usu�rio                                                  �
	//�������������������������������������������������������������������������������������������
Else
	//�������������������������������������������������������������������������������������Ŀ
	//� Executa a rotina principal                                                          �
	//���������������������������������������������������������������������������������������
	U_PR703RUN( .F., "2" )
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Retorno da fun��o                                                                       �
//�������������������������������������������������������������������������������������������
Return( Nil )


/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �PR703RUN� Rotina para envio de WF de Inadimplencia                       ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �08/06/13� ACPD                                                           ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �ExpL1 - Identifica se a rotina ser� executada via Job                    ���
���             �ExpC1 - C�digo da Regra de envio do WorkFlow                             ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es �A vari�vel a Dados ir� conter 4 elementos, sendo:                        ���
���             �aDados[n,1] - C�digo do Cliente                                          ���
���             �aDados[n,2] - Loja do Cliente                                            ���
���             �aDados[n,4] - Array contendo os dados dos t�tulos                        ���
���             �aDados[n,4,01] - Prefixo do t�tulo                                       ���
���             �aDados[n,4,02] - N�mero do t�tulo                                        ���
���             �aDados[n,4,03] - Parcela do t�tulo                                       ���
���             �aDados[n,4,04] - Tipo do t�tulo                                          ���
���             �aDados[n,4,05] - Valor do t�tulo                                         ���
���             �aDados[n,4,06] - Saldo do t�tulo                                         ���
���             �aDados[n,4,07] - Vencimento do t�tulo                                    ���
���             �aDados[n,4,08] - Emiss�o do t�tulo                                       ���
���             �aDados[n,4,09] - Descri��o da condi��o de pagamento                      ���
���             �aDados[n,4,10] - N�mero(s) do(s) pedido(s)                               ���
���             �Programa NCGPR701 - Log de Envio do WF                                   ���
���             �Programa NCGPR702 - Regras de Envio                                      ���
���             �Programa NCGPR703 - Wf de envio                                          ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  �99/99/99 - Consultor - Descri��o da altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
User Function PR703RUN( lJob, cCodReg )
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local aAreaAtu	:= GetArea()
Local aAreaReg	:= {}
Local aDados	:= {}
Local aRegra	:= { "", "", "", "", "" }
Local lProcessa	:= .T.
Local cMensag	:= ""

Private cCadastro	:= "WorkFlow de Inadimpl�ncia"
Private dDatIni		:= SuperGetMV( "NCG_PR7030", .F., CToD( "01/01/13" ) )

Default lJob	:= .F.
//�����������������������������������������������������������������������������������������Ŀ
//� Salva a area do arquivo de regras do wrokflow                                           �
//�������������������������������������������������������������������������������������������
If AliasInDic( "ZZ5" )
	aAreaReg	:= ZZ5->( GetArea() )
Endif
//�����������������������������������������������������������������������������������������Ŀ
//� Grava o log de processamento com o in�cio do workflow                                   �
//�������������������������������������������������������������������������������������������
//PR703Log(	MsDate(),//Time(),//cCodReg,//"",//"In�cio do processamento para a regra " + cCodReg + "." //)
//�����������������������������������������������������������������������������������������Ŀ
//� Posiciona no arquivo de regras do workflow para obter os dados da regra                 �
//�������������������������������������������������������������������������������������������
If AliasInDic( "ZZ5" )
	dbSelectArea( "ZZ5" )
	dbSetOrder( 1 )
	If !( MsSeek( xFilial( "ZZ5" ) + cCodReg ) )
		cMensag	:= "Regra do Workflow n�o localizado no cadastro."
		//PR703Log(	MsDate(),		Time(),		cCodReg,		"",		cMensag		)
		If !( lJob )
			Aviso(	"NCGPR703-01",;
			cMensag,;
			{ "&Retorna" },3,;
			cCadastro )
		EndIf
		lProcessa	:= .F.
		
		//�����������������������������������������������������������������������������������������Ŀ
		//� Cria o array com os dados da regra                                                      �
		//�������������������������������������������������������������������������������������������
	Else
		//�������������������������������������������������������������������������������������Ŀ
		//� Ajusta o diret�rio dos arquivos Html                                                �
		//���������������������������������������������������������������������������������������
		//If AliasInDic( "ZZ5" ) .And. ZZ5->( FieldPos( "ZZ5_HTMARQ" ) ) <> 0
		aRegra[1]	:= AllTrim( ZZ5->ZZ5_HTMARQ )
		//Else
		//	aRegra[1]	:= SuperGetMv( "NCG_PR7031",, "\workflow\" )
		//EndIf
		//aRegra[1]	+= If( Right( aRegra[1], 1 ) <> "\", "\","")
		//�������������������������������������������������������������������������������������Ŀ
		//� Obtem o nome do arquivo Html para o processo                                        �
		//���������������������������������������������������������������������������������������
		
		//If AliasInDic( "ZZ5" ) .And. ZZ5->( FieldPos( "ZZ5_HTMARQ" ) ) <> 0
		aRegra[2]	:= RetFileName(AllTrim( ZZ5->ZZ5_HTMARQ ))
		//Else
		//	aRegra[2]	:= SuperGetMv( "NCG_PR7032",, "AvisoProtesto.Html" )
		//EndIf
		//�������������������������������������������������������������������������������������Ŀ
		//� Obtem o assunto do e-mail                                                           �
		//���������������������������������������������������������������������������������������
		If AliasInDic( "ZZ5" ) .And. ZZ5->( FieldPos( "ZZ5_HTMASS" ) ) <> 0
			aRegra[3]	:= AllTrim( ZZ5->ZZ5_HTMASS )
		Else
			aRegra[3]	:= SuperGetMv( "NCG_PR7033",, cCadastro )
		EndIf
		//�������������������������������������������������������������������������������������Ŀ
		//� Obtem os textos de cabe�alho e rodap�                                               �
		//���������������������������������������������������������������������������������������
		If AliasInDic( "ZZ5" ) .And. ZZ5->( FieldPos( "ZZ5_HTMTXC" ) ) <> 0
			aRegra[4]	:= "."
		Else
			aRegra[4]	:= "."
		EndIf
		If AliasInDic( "ZZ5" ) .And. ZZ5->( FieldPos( "ZZ5_HTMTXR" ) ) <> 0
			aRegra[5]	:= "."
		Else
			aRegra[5]	:= "."
		EndIf
	EndIf
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Se n�o teve erro na leitura da regra processa o envio                                   �
//�������������������������������������������������������������������������������������������
If lProcessa
	//�������������������������������������������������������������������������������������Ŀ
	//� Procura pelo arquivo Html informado no cadastro                                     �
	//���������������������������������������������������������������������������������������
	If !( File( aRegra[1]  ) )
		cMensag	:= "Arquivo "+aRegra[1]+" nao localizado."
		//PR703Log(	MsDate(),		//Time(),		//cCodReg,		//"",		//cMensag;		//)
		If !( lJob )
			Aviso(	"NCGPR703-02",;
			cMensag,;
			{ "&Retorna" },3,;
			cCadastro )
		EndIf
		lProcessa	:= .F.
	EndIf
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Executa a chamada da fun��o para obter os dados a serem enviados no WF                  �
//�������������������������������������������������������������������������������������������
If lProcessa
	If lJob
		PR703Dat( lJob, cCodReg, @aDados )
	Else
		Processa( { || PR703Dat( lJob, cCodReg, @aDados ) }, "Selecionando T�tulos", cCadastro )
	EndIf
	//�����������������������������������������������������������������������������������������Ŀ
	//� N�o encontrou dados a serem processados                                                 �
	//�������������������������������������������������������������������������������������������
	If Len( aDados ) == 0
		cMensag	:= "N�o foram localizados t�tulos a serem processados para a data."
		//PR703Log(	MsDate(),		Time(),		cCodReg,		"",		cMensag		)
		
		If !( lJob )
			Aviso(	"NCGPR703-03",;
			cMensag,;
			{ "&Retorna" },3,;
			cCadastro )
		EndIf
	Else
		For nLoop := 1 To Len( aDados )
			//�������������������������������������������������������������������������������������Ŀ
			//� Alimenta array principal com os dados do cliente e t�tulo a serem enviados via WF   �
			//���������������������������������������������������������������������������������������
			PR703EWF( lJob, cCodReg, nLoop, aDados, aRegra )
		Next nLoop
	EndIf
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Grava log de final de processamento                                                     �
//�������������������������������������������������������������������������������������������
cMensag	:= "Final do processamento para a regra " + cCodReg + "."
//PR703Log(	MsDate(),//Time(),//cCodReg,//"",//cMensag//)
If !( lJob )
	Aviso(	"NCGPR703-04",;
	cMensag,;
	{ "&Retorna" },3,;
	cCadastro )
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Restaura �reas originais                                                                �
//�������������������������������������������������������������������������������������������
RestArea( aAreaAtu )
If AliasInDic( "ZZ5" )
	RestArea( aAreaReg )
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Retorno da fun��o                                                                       �
//�������������������������������������������������������������������������������������������
Return( Nil )


/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �PR703DAT� Rotina para obter os dados a serem enviados no WF              ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �06/06/13� ACPD                                                           ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �ExpL1 - Define se a chamada foi feita via Job                            ���
���             �ExpC1 - C�digo da Regra do WF                                            ���
���             �ExpA1 - Array recebido por refer�ncia para alimentar os dados            ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es �Alimenta array passado por refer�ncia                                    ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  �99/99/99 - Consultor - Descri��o da altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
Static Function PR703Dat( lJob, cCodReg, aDados )
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local aAreaAtu	:= GetArea()
Local aAux		:= {}
Local nTotReg	:= 0
Local nProcess	:= 0
Local cQry		:= ""
Local cArqQry	:= GetNextAlias()
Local cCodCli	:= ""
Local cLojCli	:= ""
Local cPortado	:= SuperGetMV( "NCG_PR7034", .F., "928;929;936;937;996;914" )


U_PR702Init()

//�����������������������������������������������������������������������������������������Ŀ
//� Monta a string da query de sele��o dos dados                                            �
//�������������������������������������������������������������������������������������������
cQry	+= " SELECT DISTINCT SE1.E1_CLIENTE,SE1.E1_LOJA,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA,SE1.E1_TIPO,"
cQry	+= " SE1.E1_VALOR,SE1.E1_SALDO,SE1.E1_VENCTO,SE1.E1_EMISSAO,SD2.D2_PEDIDO,SE4.E4_DESCRI,"
cQry	+= " SE1.E1_PORTADO,SE1.E1_AGEDEP,SE1.E1_CONTA"
cQry	+= " FROM " + RetSqlName( "SE1" ) + " SE1"
cQry	+= " LEFT JOIN " + RetSqlName( "SF2" ) + " SF2 ON SF2.F2_FILIAL = '" + xFilial( "SF2" ) + "'"
cQry	+= " AND SF2.F2_PREFIXO = SE1.E1_PREFIXO"
cQry	+= " AND SF2.F2_DOC = SE1.E1_NUM"
cQry	+= " AND SF2.F2_CLIENTE = SE1.E1_CLIENTE"
cQry	+= " AND SF2.F2_LOJA = SE1.E1_LOJA"
cQry	+= " AND SF2.D_E_L_E_T_ = ' '"
cQry	+= " LEFT JOIN " + RetSqlName( "SD2" ) + " SD2 ON SD2.D2_FILIAL  = '" + xFilial( "SD2" ) + "'"
cQry	+= " AND SD2.D2_SERIE = SF2.F2_SERIE"
cQry	+= " AND SD2.D2_DOC = SF2.F2_DOC"
cQry	+= " AND SD2.D2_CLIENTE = SF2.F2_CLIENTE"
cQry	+= " AND SD2.D2_LOJA = SF2.F2_LOJA"
cQry	+= " AND SD2.D_E_L_E_T_ = ' '"
cQry	+= " LEFT JOIN " + RetSqlName( "SE4" ) + " SE4 ON SE4.E4_FILIAL  = '" + xFilial( "SE4" ) + "'"
cQry	+= " AND SE4.E4_CODIGO = SF2.F2_COND"
cQry	+= " AND SE4.D_E_L_E_T_ = ' '"
cQry	+= " WHERE SE1.E1_FILIAL = '" + xFilial( "SE1" ) + "'"
cQry	+= " AND SE1.E1_EMISSAO >= '" + DToS( dDatIni ) + "'"
cQry	+= " AND SE1.E1_SALDO <> 0"
CqRY	+= " AND SE1.E1_PORTADO NOT IN "+FormatIn(cPortado,";")
cQry	+= " AND SE1.E1_TIPO = '" + MVNOTAFIS + "'"
cQry	+= " AND SE1.D_E_L_E_T_ = ' '"
cQry	+= " Order By SE1.E1_CLIENTE,SE1.E1_LOJA,SE1.E1_VENCTO,SE1.E1_PREFIXO,SE1.E1_NUM,SE1.E1_PARCELA,SE1.E1_TIPO"

//�����������������������������������������������������������������������������������������Ŀ
//� Executa a query para obter os dados                                                     �
//�������������������������������������������������������������������������������������������
dbUseArea( .T., __cRdd, TcGenQry(,,cQry), cArqQry, .F., .T. )
//�����������������������������������������������������������������������������������������Ŀ
//� Compatibiliza os dados com a topfield                                                   �
//�������������������������������������������������������������������������������������������
aEval( SE1->(dbStruct()),{|x| If(x[2]!="C", TcSetField(cArqQry,AllTrim(x[1]),x[2],x[3],x[4]),Nil)})
//�����������������������������������������������������������������������������������������Ŀ
//� Compatibiliza os dados com a topfield                                                   �
//�������������������������������������������������������������������������������������������
(cArqQry)->( dbEval( { || nTotReg++ },,{ || !Eof() } ) )
//�����������������������������������������������������������������������������������������Ŀ
//� Processa os dados localizados                                                           �
//�������������������������������������������������������������������������������������������
dbSelectArea( cArqQry )
dbGoTop()
//�����������������������������������������������������������������������������������������Ŀ
//� Alimenta o controle de progresso da interface com o usu�rio                             �
//�������������������������������������������������������������������������������������������
If !lJob
	ProcRegua( nTotReg )
EndIf

While !Eof()
	//�������������������������������������������������������������������������������������Ŀ
	//� Obtem a chave de quebra e inicializa as vari�veis para cada quebra                  �
	//���������������������������������������������������������������������������������������
	cCodCli	:= (cArqQry)->E1_CLIENTE
	cLojCli	:= (cArqQry)->E1_LOJA
	aAux	:= {}
	dbSelectArea( cArqQry )
	//�������������������������������������������������������������������������������������Ŀ
	//� Processa enquanto for o mesmo cliente e loja                                        �
	//���������������������������������������������������������������������������������������
	While !Eof() .And. (cArqQry)->( E1_CLIENTE + E1_LOJA ) == cCodCli + cLojCli
		//���������������������������������������������������������������������������������Ŀ
		//� Obtem a chave de quebra e inicializa as vari�veis para cada quebra              �
		//�����������������������������������������������������������������������������������
		cPrefixo:= (cArqQry)->E1_PREFIXO
		cNum	:= (cArqQry)->E1_NUM
		cParcela:= (cArqQry)->E1_PARCELA
		cTipo	:= (cArqQry)->E1_TIPO
		nValor	:= (cArqQry)->E1_VALOR
		nSaldo	:= (cArqQry)->E1_SALDO
		dVencto	:= (cArqQry)->E1_VENCTO
		dEmissao:= (cArqQry)->E1_EMISSAO
		cDescCP	:= (cArqQry)->E4_DESCRI
		cBcoCod	:= (cArqQry)->E1_PORTADO
		cBcoAge := (cArqQry)->E1_AGEDEP
		cBcoCon	:= (cArqQry)->E1_CONTA
		cPedido	:= ""
		//���������������������������������������������������������������������������������Ŀ
		//� Processa enquanto dor o mesmo cliente, loja, t�tulo                             �
		//�����������������������������������������������������������������������������������
		While !Eof() .And. (cArqQry)->( E1_CLIENTE + E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO ) == 	cCodCli + cLojCli + cPrefixo + cNum + cParcela + cTipo
			
			
			
			//�����������������������������������������������������������������������������Ŀ
			//� Movimenta a regua de processamento                                          �
			//�������������������������������������������������������������������������������
			If !lJob
				IncProc( "Cliente/Loja: " + cCodCli + "/" + cLojCli )
			EndIf
			//�����������������������������������������������������������������������������Ŀ
			//� Alimenta a vari�vel que conter� os pedidos associados ao t�tulo             �
			//�������������������������������������������������������������������������������
			
			dbSelectArea( "SC5" )
			dbSetOrder( 1 )
			If MsSeek( xFilial( "SC5" ) + (cArqQry)->D2_PEDIDO ) .And. !Empty(SC5->C5_PEDCLI)
				cPedido	+= AllTrim(SC5->C5_PEDCLI)+"-"
			EndIf
			
			//�����������������������������������������������������������������������������Ŀ
			//� Volta para o arquivo de trabalho para ir para o pr�ximo registro            �
			//�������������������������������������������������������������������������������
			dbSelectArea( cArqQry )
			dbSkip()
		End While
		//���������������������������������������������������������������������������������Ŀ
		//� Alimenta o array com os dados do t�tulo                                         �
		//�����������������������������������������������������������������������������������
		
		If !Empty(cPedido)
			cPedido:=SubStr(cPedido,1,Len(cPedido)-1)
		Else
			cPedido:="-"
		EndIf
		
		
		If U_R702TITVAL(cCodReg,cCodCli,cLojCli,dVencto,cPrefixo,cNum,cParcela) //Valida a regra do WF
			aAdd( aAux, {	cPrefixo,;		//01-Prefix0
			cNum,;			//02-Numero
			cParcela,;		//03-Parcela
			cTipo,;			//04-Tipo
			nValor,;		//05-Valor
			nSaldo,;		//06-Saldo
			dVencto,;		//07-Vencimento
			dEmissao,;		//08-Emiss�o
			cDescCP,;		//09-Descri��o Condi��o Pagamento
			cPedido,;		//10-N�mero(s) Pedido(s)
			cBcoCod,;		//11-Banco
			cBcoAge,;		//12-agencia
			cBcoCon } )		//13-Conta Corrente
		EndIf
	End While
	If Len(aAux)>0
		aAdd( aDados, {	cCodCli,		cLojCli,	aClone( aAux )	} )
	EndIf
End While
//�����������������������������������������������������������������������������������������Ŀ
//� Fecha o arquivo de trabalho                                                             �
//�������������������������������������������������������������������������������������������
dbSelectArea( cArqQry )
dbCloseArea()
//�����������������������������������������������������������������������������������������Ŀ
//� Restaura as �reas originais                                                             �
//�������������������������������������������������������������������������������������������
RestArea( aAreaAtu )
//�����������������������������������������������������������������������������������������Ŀ
//� Retorno da fun��o                                                                       �
//�������������������������������������������������������������������������������������������
Return( Nil )

/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �PR703EWF� Monta as vari�veis utilizadas no HTML e envia o WF             ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �06/06/13� ACPD                                                           ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �ExpL1 - Identifica se a rotina foi chamada pelo job                      ���
��� Par�metros  �ExpN1 - Linha em execu��o do array aDados                                ���
��� Par�metros  �ExpA1 - array aDados                                                     ���
��� Par�metros  �ExpA1 - array aRegra                                                     ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es �Alimenta array passado por refer�ncia                                    ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  �99/99/99 - Consultor - Descri��o da altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
Static Function PR703EWF( lJob, cCodReg, nLinha, aDados, aRegra )
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local aAreaAtu	:= GetArea()
Local aAreaSA1	:= SA1->( GetArea() )
Local aAreaAC8	:= AC8->( GetArea() )
Local aAreaSU5	:= SU5->( GetArea() )
Local nLoop		:= 0
Local nDias		:= 5
Local cMensag	:= ""
Local cMailDest	:= ""
Local cNivCont	:= SuperGetMV( "NGC_000001", .F., "06    " )	// N�vel do contato que deve ser enviado o WF
Local cTrata	:= ""									 		// Tratamento a ser utilizado no nome do contato
Local cCorLnh	:= ""
Local cErro		:= ""
Local cMailFin	:= SuperGetMv( "NCG_PR7031",.F.,"boletos@ncgames.com.br")
//�����������������������������������������������������������������������������������������Ŀ
//� Posiciona no arquivo de clientes                                                        �
//�������������������������������������������������������������������������������������������
dbSelectArea( "SA1" )
dbSetOrder( 1 )
If !( MsSeek( xFilial( "SA1" ) + aDados[nLinha,01] + aDados[nLinha,02] ) )
	cMensag	:= "Cliente/Loja [" + aDados[nLinha,01] + "/" + aDados[nLinha,02] + "] n�o localizado no cadastro."
	//PR703Log(	MsDate(),                                                                                 	//Time(),;	//cCodReg,;	//aDados[nLinha,01] + aDados[nLinha,02],;	//cMensag;	//)
	If !( lJob )
		Aviso(	"PR703EWF-01",;
		cMensag,;
		{ "&Retorna" },3,;
		"Cliente/Loja: " + aDados[nLinha,01] + "/" + aDados[nLinha,02] )
	EndIf
EndIf

If AllTrim(cCodReg)=="04"//Aviso de Protesto
	cMailDest:=Posicione("SA3",1,xFilial("SA3")+SA1->A1_VEND,"A3_EMAIL")
Else	
	//�����������������������������������������������������������������������������������������Ŀ
	//� Posiciona no arquivo de amarra��o cliente x contato                                     �
	//�������������������������������������������������������������������������������������������
	dbSelectArea( "AC8" )
	dbSetOrder( 2 )		// AC8_FILIAL+AC8_ENTIDA+AC8_FILENT+AC8_CODENT+AC8_CODCON
	MsSeek( xFilial( "AC8" ) + "SA1" + xFilial( "SA1" ) + PadR( SA1->A1_COD + SA1->A1_LOJA, TAMSX3( "AC8_CODENT" )[1] ) )
	//�����������������������������������������������������������������������������������������Ŀ
	//� Obtem os contatos associados ao cliente + loja                                          �
	//�������������������������������������������������������������������������������������������
	While !Eof() .And. AC8->AC8_FILIAL == xFilial( "AC8" ) .And.;
		AC8->AC8_ENTIDA == "SA1" .And.;
		AC8->AC8_FILENT == xFilial( "SA1" ) .And.;
		AC8->AC8_CODENT == PadR( SA1->A1_COD + SA1->A1_LOJA, TAMSX3( "AC8_CODENT" )[1] )
		//�������������������������������������������������������������������������������������Ŀ
		//� Posiciona no arquivo de contatos                                                    �
		//���������������������������������������������������������������������������������������
		dbSelectArea( "SU5" )
		dbSetOrder( 1 )
		If !( MsSeek( xFilial( "SU5" ) + AC8->AC8_CODCONT ) )
			cMensag	:= "Contato [" + AC8->AC8_CODCONT + "] associado ao cliente n�o localizado no cadastro."
			//PR703Log(	MsDate(),		Time(),		cCodReg,	aDados[nLinha,01] + aDados[nLinha,02],	cMensag	)
			If !( lJob )
				Aviso(	"PR703EWF-02",;
				cMensag,;
				{ "&Retorna" },3,;
				"Cliente/Loja: " + aDados[nLinha,01] + "/" + aDados[nLinha,02] )
			EndIf
		Else
			//���������������������������������������������������������������������������������Ŀ
			//� Avalia se o contato deve ser considerado no envio do WF                         �
			//�����������������������������������������������������������������������������������
			If SU5->U5_NIVEL $ cNivCont
				cMailDest	+= If( !Empty( cMailDest ), ";", "" ) +  AllTrim( SU5->U5_EMAIL )
				cTrata		:= AllTrim( Tabela( "AX", U5_TRATA, .F. ) )
			EndIf
		EndIf
		//�������������������������������������������������������������������������������������Ŀ
		//� Vai para a �pr�xima amarra��o                                                       �
		//���������������������������������������������������������������������������������������
		dbSelectArea( "AC8" )
		dbSkip()
	End While
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� N�o foi localizado nenhum e-mail para envio                                             �
//�������������������������������������������������������������������������������������������

If Empty( cMailDest )
	cMensag	:= "N�o foi localizado nenhum e-mail cadastrado para os contatos do cliente."
	PR703Log(	MsDate(),	Time(),	cCodReg,	aDados[nLinha,01] ,aDados[nLinha,02],	cMensag	)
	If !( lJob )
		Aviso(	"PR703EWF-03",;
		cMensag,;
		{ "&Retorna" },3,;
		"Cliente/Loja: " + aDados[nLinha,01] + "/" + aDados[nLinha,02] )
	EndIf
	//�����������������������������������������������������������������������������������������Ŀ
	//� Prepara os dados para preencher o Html                                                  �
	//�������������������������������������������������������������������������������������������
Else
	//�������������������������������������������������������������������������������������Ŀ
	//� Define o n�mero de dias em atraso a ser impresso no WF                              �
	//���������������������������������������������������������������������������������������
	If AliasInDic( "ZZ5" ) .And. !Empty( ZZ5->ZZ5_DIAS )
		nDias	:= ZZ5->ZZ5_DIAS
	EndIf
	//�������������������������������������������������������������������������������������Ŀ
	//� Instancia objeto da classe TWFProcess para inicializar WF                           �
	//���������������������������������������������������������������������������������������
	//oProcess := TWFProcess():New( aRegra[3], aRegra[3] )
	//�������������������������������������������������������������������������������������Ŀ
	//� Inicializa a tarefa                                                                 �
	//���������������������������������������������������������������������������������������
	//oProcess:NewTask( aRegra[3], aRegra[1] + aRegra[2] )
	//�������������������������������������������������������������������������������������Ŀ
	//� Alimenta os dados de envio do WF                                                    �
	//���������������������������������������������������������������������������������������
	//oProcess:cSubject	:= aRegra[3]
	//oProcess:cTo		:= cMailDest
	//oProcess:cCC		:= Nil
	//oProcess:cBCC		:= Nil
	//oProcess:bReturn	:= "U_WF102RET()"
	//�������������������������������������������������������������������������������������Ŀ
	//� Alimenta o objeto com os dados fixo a serem utilizados no Html                      �
	//���������������������������������������������������������������������������������������
	oHtml	:= TWFHTML():New( aRegra[1] )
	//oHtml	:= oProcess:oHtml
	oHtml:ValByName( "CAD_ANOINICIO",		StrZero( Year( dDatIni ), 4 ) )
	oHtml:ValByName( "CAD_NUMDIAATRASO",	AllTrim( Str( nDias ) ) )
	oHtml:ValByName( "CAD_EXTDIAATRASO",	AllTrim( Extenso( nDias, .T. ) ) )
	oHtml:ValByName( "TXT_CAB",				aRegra[4] )
	oHtml:ValByName( "TXT_ROD",				aRegra[5] )
	oHtml:ValByName( "CLI_COD",				SA1->A1_COD )
	oHtml:ValByName( "CLI_LOJA",			SA1->A1_LOJA )
	oHtml:ValByName( "CLI_NOME",			AllTrim( SA1->A1_NOME ) )
	oHtml:ValByName( "CLI_NREDUZ",			AllTrim( SA1->A1_NREDUZ ) )
	oHtml:ValByName( "CLI_END",				AllTrim( SA1->A1_END ) + " " + AllTrim( SA1->A1_COMPLEM ) )
	oHtml:ValByName( "CLI_BAIRRO",			AllTrim( SA1->A1_BAIRRO ) )
	oHtml:ValByName( "CLI_CEP",				Transform( SA1->A1_CEP, "@R 99999-999" ) )
	oHtml:ValByName( "CLI_CIDADE",			AllTrim( SA1->A1_MUN ) )
	oHtml:ValByName( "CLI_ESTADO",			AllTrim( SA1->A1_EST ) )
	oHtml:ValByName( "CLI_TRATA",			cTrata )
	oHtml:ValByName( "CLI_CONTATO",			AllTrim( SU5->U5_CONTAT ) )
	//�������������������������������������������������������������������������������������Ŀ
	//� Alimenta o objeto com os dados dos t�tulos a serem utilizados no Html               �
	//���������������������������������������������������������������������������������������
	aTitEnv:={}
	For nLoop := 1 To Len( aDados[nLinha,03] )
		//�����������������������������������������������������������������������������������������Ŀ
		//� Posiciona no arquivo de clientes                                                        �
		//�������������������������������������������������������������������������������������������
		dbSelectArea( "SA6" )
		dbSetOrder( 1 )
		If !Empty(aDados[nLinha,3,nLoop,11]) .And. !( MsSeek( xFilial( "SA6" ) + aDados[nLinha,3,nLoop,11] + aDados[nLinha,3,nLoop,12] + aDados[nLinha,3,nLoop,13] ) )
			cMensag	:= "Banco/Ag�ncia/Conta [" + aDados[nLinha,3,nLoop,11] + "/" + aDados[nLinha,3,nLoop,12] + "/" + aDados[nLinha,3,nLoop,13] + "] n�o localizado no cadastro."
			//PR703Log(	MsDate(),			Time(),			cCodReg,			aDados[nLinha,01] + aDados[nLinha,02],			cMensag			)
			If !( lJob )
				Aviso(	"PR703EWF-01",;
				cMensag,;
				{ "&Retorna" },3,;
				"Cliente/Loja: " + aDados[nLinha,01] + "/" + aDados[nLinha,02] )
			EndIf
		EndIf
		//���������������������������������������������������������������������������������Ŀ
		//� Obtem a cor da linha de acordo com o vencimento do t�tulo                       �
		//�����������������������������������������������������������������������������������
		cCorLnh	:= '"#000000"'
		If aDados[nLinha,03,nLoop,07] < MsDate()
			cCorLnh	:= '"#FF0000"'
		EndIf
		aAdd( ( oHtml:ValByName( "it.corlinha" ) ),			cCorLnh )
		aAdd( ( oHtml:ValByName( "it.notafiscal" ) ),		aDados[nLinha,03,nLoop,01]+"/"+aDados[nLinha,03,nLoop,02]+"/"+aDados[nLinha,03,nLoop,03] )
		aAdd( ( oHtml:ValByName( "it.pedido" ) ),	   		aDados[nLinha,03,nLoop,10] )
		aAdd( ( oHtml:ValByName( "it.datacompra" ) ),		DToC(aDados[nLinha,03,nLoop,08] ) )
		aAdd( ( oHtml:ValByName( "it.prazopagamento" ) ),	aDados[nLinha,03,nLoop,09] )
		aAdd( ( oHtml:ValByName( "it.datavencimento" ) ),	DToC( aDados[nLinha,03,nLoop,07] ) )
		aAdd( ( oHtml:ValByName( "it.valortitulo" ) ),		Transform( aDados[nLinha,03,nLoop,05], PesqPict( "SE1", "E1_VALOR" ) ) )
		aAdd( ( oHtml:ValByName( "it.saldotitulo" ) ),		Transform( aDados[nLinha,03,nLoop,06], PesqPict( "SE1", "E1_SALDO" ) ) )
		
		AADD(aTitEnv,{MsDate(), Time(), cCodReg, aDados[nLinha,01] , aDados[nLinha,02], "OK",aDados[nLinha,03,nLoop,01],aDados[nLinha,03,nLoop,02],aDados[nLinha,03,nLoop,03]})
	Next nLoop
	//�������������������������������������������������������������������������������������Ŀ
	//� Cria a mensagem padr�o para emiss�o 2a. via boleto                                  �
	//���������������������������������������������������������������������������������������
	If SA6->( FieldPos( "A6_YFAZBOL" ) ) <> 0 .And. SA6->A6_YFAZBOL == "1"
		//If SA6->( FieldPos( "A6_YSITE" ) ) <> 0 .And. !Empty( SA6->A6_YSITE )
		cTexto	:= "Para emiss�o da 2� via do boleto acessar o site " + AllTrim( SA6->A6_YSITE ) + " e seguir as instru��es de emiss�o."
		//Else
		//	cTexto	:= "Para solicita��o da 2� via do boleto enviar e-mail para boleto&#64ncgames.com.br."
		//EndIf
	Else
		cTexto	:= "Para solicita��o da 2� via do boleto enviar e-mail para " + AllTrim(cMailFin) + "."
	EndIf
	oHtml:ValByName( "BCO_MENSAGEM", cTexto )
	//�������������������������������������������������������������������������������������Ŀ
	//� Salva o Html gerado                                                                 �
	//���������������������������������������������������������������������������������������
	cNomeArq:=E_Create(,.F.)
	
	oHtml:SaveFile( cNomeArq+".htm" )
	oHtml:Free()
	cBody :=WFLoadFile(cNomeArq+".htm" )
	//�������������������������������������������������������������������������������������Ŀ
	//� Envia o Html por e-mail                                                             �
	//���������������������������������������������������������������������������������������
	//cMailDest:="cleverson.silva@acpd.com.br"
	cErro:=""
	lEnviou:=PR703SEND( aRegra[3],cBody,{}, cMailDest, "", @cErro )
	
	For nInd:=1 To Len(aTitEnv)
		PR703LOG( aTitEnv[nInd,1], aTitEnv[nInd,2], aTitEnv[nInd,3], aTitEnv[nInd,4],aTitEnv[nInd,5],IIf(lEnviou,aTitEnv[nInd,6],cErro),aTitEnv[nInd,7],aTitEnv[nInd,8],aTitEnv[nInd,9] )
	Next
	
	Ferase(cNomeArq+".htm")
	
EndIf

RestArea( aAreaSA1 )
RestArea( aAreaAC8 )
RestArea( aAreaSU5 )
RestArea( aAreaAtu )

Return( Nil )


/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �PR703LOG� Grava o Log de Processamento                                   ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �14/06/13� ACPD                                                           ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �ExpL1 - Identifica se a rotina foi chamada pelo job                      ���
��� Par�metros  �ExpN1 - Linha em execu��o do array aDados                                ���
��� Par�metros  �ExpA1 - array aDados                                                     ���
��� Par�metros  �ExpA1 - array aRegra                                                     ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es �Alimenta array passado por refer�ncia                                    ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  �99/99/99 - Consultor - Descri��o da altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
Static Function PR703LOG( dDatRef, cHora, cCodReg, cCodCli,cLojaCLi,cMensagem,cPrefixo,cNumero,cParcela )
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local aAreaAtu	:= GetArea()


Default cPrefixo:=""
Default cNumero:=""
Default cParcela:=""



ZZ4->(RecLock("ZZ4",.T.))

ZZ4->ZZ4_FILIAL	:=xFilial("ZZ4")

If !Empty(cCodCli)
	ZZ4->ZZ4_CANAL :=""
EndIf
ZZ4->ZZ4_CLIENT	:=cCodCli
ZZ4->ZZ4_LOJA  	:=cLojaCLi
ZZ4->ZZ4_PREFIX	:=cPrefixo
ZZ4->ZZ4_NUM   	:=cNumero
ZZ4->ZZ4_PARCEL	:=cParcela
ZZ4->ZZ4_TIPOWF	:=cCodReg
ZZ4->ZZ4_DTENVI	:=dDatRef
ZZ4->ZZ4_HORA    	:=cHora
ZZ4->ZZ4_MENSAG	:=cMensagem


//�����������������������������������������������������������������������������������������Ŀ
//� Restaura as �reas originais                                                             �
//�������������������������������������������������������������������������������������������
RestArea( aAreaAtu )
//�����������������������������������������������������������������������������������������Ŀ
//� Retorno da fun��o                                                                       �
//�������������������������������������������������������������������������������������������
Return( Nil )


/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �PR703LOG� Grava o Log de Processamento                                   ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �14/06/13� ACPD                                                           ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �ExpL1 - Identifica se a rotina foi chamada pelo job                      ���
��� Par�metros  �ExpN1 - Linha em execu��o do array aDados                                ���
��� Par�metros  �ExpA1 - array aDados                                                     ���
��� Par�metros  �ExpA1 - array aRegra                                                     ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     �Nil                                                                      ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es �Alimenta array passado por refer�ncia                                    ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  �99/99/99 - Consultor - Descri��o da altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
Static Function PR703SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local lRetorno	:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)

Default aAnexos		:= {}
Default cBody		:= ""
Default cAssunto	:= ""
Default cErro		:= ""

//cEmailCc:=cEmailTo

If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cBody)
	If MailSmtpOn( cServer, cAccount, cPassword )
		If lMailAuth
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
			EndIf
		Endif
		If lRetorno
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cBody,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
			EndIf
		Else
			cErro := "Erro na tentativa de autentica��o da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conex�o com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
Else
	If Empty(cEmailTo)
		cErro := "� neess�rio fornecedor o destin�tario para o e-mail. "
		lRetorno := .F.
	EndIf
	If Empty(cAssunto)
		cErro := "� neess�rio fornecer o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	If Empty(cBody)
		cErro := "� neess�rio fornecer o corpo do e-mail. "
		lRetorno := .F.
	EndIf
Endif

Return(lRetorno)
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR704  � Autor � AP6 IDE            � Data �  13/06/13   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function PR703LOG
Private cCadastro := 'Log de Envio do Workflow'

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('ZZ4')
oBrowse:SetDescription(cCadastro)
oBrowse:Activate()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO2     �Autor  �Microsiga           � Data �  06/13/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function Menudef()
Local  aRotina := {}

AADD(aRotina, {"Pesquisar","PesqBrw",0,1 })
AADD(aRotina, {"Visualizar","AxVisual",0,2})

Return aRotina
