#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �NCGPR001� Rotina para efetuar o tratamento do ICMS-ST para o estado do   ���
���             �        � Paran� em rela��o aos produtos relacionados no NCM 8523.49.90  ���
���             �        � Jogos gravados em m�dia (CD ou DVD).                           ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �06/10/12� Almir Bandina                                                  ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  � ExpA1 - Item da do pedido de venda que esta sendo processado            ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     � ExpA2 - Array contendo 2 elementos                                      ���
���             �         [1] = Valor da Base de C�lculo ICMS Solid�rio                   ���
���             �         [2] = Valor da ICMS Solid�rio                                   ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es � Esta dispon�vel as vari�veis privates abaix para serem utilizadas no PE ���
���             � ICMSITEM - valor do ICMS normal do item                                 ���
���             � QUANTITEM - quantidade vendida no item                                  ���
���             � BASEICMRET - base de c�lculo do ICMS solid�rio                          ���
���             � MARGEMLUCR - Percentual da margem de lucro definida no produto ou na    ���
���             �              excess�o fiscal                                            ���
���             � Neste momento as tabelas abaixo est�o posicionadas:                     ���
���             � SC5 - Cabe�alho Pedido de Venda                                         ���
���             � SF4 - Tipo de Entrada e Sa�da                                           ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  � 99/99/99 - Consultor - Descri��o da altera��o                           ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
User Function NCGPR001( nItePed )
//�����������������������������������������������������������������������������������������Ŀ
//� Vari�veis utilizadas na rotina                                                          �
//�������������������������������������������������������������������������������������������
Local aAreaAtu	:= GetArea()
Local aAreaSB1	:= SB1->( GetArea() )
Local uRetorno	:= ""
Local lSTDif	:= SuperGetMV( "NCG_000015", , .F. )
Local nQdeIte	:= 0
Local nMargem	:= 0
Local nAlqSol	:= 0
Local nAlqICM	:= 0
//Local nVlrAux	:= 0
Local nBasOri	:= 0
Local nRetOri	:= 0
Local cCodPro	:= ""
Local cOperNF	:= ""
Local cEstOrig	:= ""
Local cEstDest	:= ""
Local cTES		:= ""
Local cFilIcmsSt	:=	U_MyNewSX6(	"NC_FICMSST", ;
									"03", ;
									"C", ;
									"Filial que utiliza tratamento especifico no ICMS-ST.Exemplo: 01|02|03",;
									"Filial que utiliza tratamento especifico no ICMS-ST.Exemplo: 01|02|03",;
									"Filial que utiliza tratamento especifico no ICMS-ST.Exemplo: 01|02|03",;
									.F. )

//�����������������������������������������������������������������������������������������Ŀ
//� Obtem os valores originais da rotina                                                    �
//�������������������������������������������������������������������������������������������
nQdeIte	:= MaFisRet( nItePed, "IT_QUANT" )
nMargem	:= MaFisRet( nItePed, "IT_MARGEM" )
nAlqSol	:= MaFisRet( nItePed, "IT_ALIQSOL" )
nAlqICM	:= MaFisRet( nItePed, "IT_ALIQICM" )
cCodPro	:= MaFisRet( nItePed, "IT_PRODUTO" )
nBasOri	:= MaFisRet( nItePed, "IT_BASESOL" )
nRetOri	:= MaFisRet( nItePed, "IT_VALSOL" )
cTES		:= MaFisRet( nItePed, "IT_TES" )
cOperNF	:= MaFisRet( , "NF_OPERNF" )
cEstOrig	:= MaFisRet( , "NF_UFORIGEM" )
cEstDest	:= MaFisRet( , "NF_UFDEST" )
//�������������������������������������������������������������������������������������Ŀ
//� Verifica se a opera��o n�o � de ST diferenciada                                     �
//���������������������������������������������������������������������������������������
If !(Alltrim(cFilAnt) $ Alltrim(cFilIcmsSt))//Verifica se o procedimento � efetuado para a filial corrente
	lStDif	:= .F.
	uRetorno	:= {	nBasOri,;
						nRetOri }
EndIf

If lStDif .And. cOperNF == "S" .And. cEstOrig == "SP" .And. cEstDest <> "PR
	lStDif	:= .F.
	uRetorno	:= {	nBasOri,;
						nRetOri }
	
ElseIf lStDif .And. cOperNF == "E" .And. MaFisRet(,"NF_TIPONF") == "D" .And. cEstOrig <> "PR" .And. cEstDest == "SP"
	lStDif		:= .F.
	uRetorno	:= .F.
EndIf
//�������������������������������������������������������������������������������������Ŀ
//� Posiciona no produto para obter o valor da m�dia definida para o produto            �
//���������������������������������������������������������������������������������������
dbSelectArea( "SB1" )
dbSetOrder( 1 )		// B1_FILIAL+B1_COD
If !MsSeek( xFilial( "SB1" ) + cCodPro )
	Aviso(	"NCGPR001-01",;
			"O Produto " + AllTrim( cCodPro ) + " n�o localizado na cadastro." + CRLF +;
			"Contate o Administrador do sistema informando o c�digo de erro informado no t�tulo.",;
			{ "&Retorna" },3,;
			"C�digo de Erro: ERRO NVGPR001-01" )
	lStDif	:= .F.
Else
	If SB1->B1_YVLMID <= 0
		lStDif	:= .F.
	EndIf
EndIf
//�������������������������������������������������������������������������������������Ŀ
//� Posiciona no produto para obter o valor da m�dia definida para o produto            �
//���������������������������������������������������������������������������������������
dbSelectArea( "SF4" )
dbSetOrder( 1 )		// F4_FILIAL+F4_CODIGO
If !MsSeek( xFilial( "SF4" ) + cTES )
	Aviso(	"NCGPR001-02",;
			"O Tipo de Entrada/Sa�da " + AllTrim( cTES ) + " n�o localizado no cadastro." + CRLF +;
			"Contate o Administrador do sistema informando o c�digo de erro informado no t�tulo.",;
			{ "&Retorna" },3,;
			"C�digo de Erro: ERRO NVGPR001-02" )
	lStDif	:= .F.
ElseIf !(SF4->F4_SITTRIB == "10") .or. SF4->F4_MKPCMP == "1" //se a Classifica��o fiscal n�o � de ST
	lStDif	:= .F.
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Tratamento para Documento de Sa�da                                                      �
//�������������������������������������������������������������������������������������������
If lStDif .And. cOperNF == "S"
	//�������������������������������������������������������������������������������������Ŀ
	//� Define o retorno original da rotina                                                 �
	//���������������������������������������������������������������������������������������
	uRetorno	:= {	MaFisRet( nItePed, "IT_BASESOL" ),;
						MaFisRet( nItePed, "IT_VALSOL" ) }
	//�����������������������������������������������������������������������������Ŀ
	//� Calcula o valor do  Suporte F�sico (Valor m�dia x quantidade vendida)       �
	//�������������������������������������������������������������������������������
	nSupFis	:= Round( nQdeIte * SB1->B1_YVLMID, TAMSX3( "D2_BRICMS" )[2] )
	//�����������������������������������������������������������������������������Ŀ
	//� Agrega o valor do frete, seguro e despesa de acordo com configura��o do TES �
	//� Conforme solicita��o por e-mail as despesas devem ser agregadas antes do IVA�
	//�������������������������������������������������������������������������������
	If SF4->F4_DESPICM <> "2" .Or. GetNewPar("MV_DESPICM",.T.)
		nSupFis	+= MaFisRet( nItePed, "IT_SEGURO" )
		nSupFis  += MaFisRet( nItePed, "IT_DESPESA" )
		nSupFis	+= MaFisRet( nItePed, "IT_FRETE" )
	EndIf
	//�����������������������������������������������������������������������������Ŀ
	//� Calcula a base de calculo para o icms substitui��o tribut�ria               �
	//�������������������������������������������������������������������������������
	nBasRet	:= nSupFis + Round( ( nSupFis * nMargem ) / 100, TAMSX3( "D2_BRICMS" )[2] )
	//�����������������������������������������������������������������������������Ŀ
	//� Calcula o icms substitui��o tribut�ria                                      �
	//�������������������������������������������������������������������������������
	// Conforme solicita��o em 28/12/12 a al�quota do ICMS passou a ser de 4% e esta esta cadastrada na exce��o fiscal
	// sendo recuperada pela rotina padr�o atrav�s da MaFisRet para o campo Aliquota do ICMS
	//nIcmRet	:= Round( ( nBasRet * nAlqSol ) / 100, TAMSX3( "D2_ICMSRET" )[2] ) - Round( ( nSupFis * nAlqSol ) / 100, TAMSX3( "D2_ICMSRET" )[2] )
	nIcmRet	:= Round( ( nBasRet * nAlqSol ) / 100, TAMSX3( "D2_ICMSRET" )[2] ) - Round( ( nSupFis * nAlqICM ) / 100, TAMSX3( "D2_ICMSRET" )[2] )
	//�����������������������������������������������������������������������������Ŀ
	//� Efetua o tratamento para c�lculo do diferenciado                            �
	//�������������������������������������������������������������������������������
	uRetorno[1]	:= nBasRet
	uRetorno[2]	:= nIcmRet
//�����������������������������������������������������������������������������������������Ŀ
//� Tratamento para Documento de Entrada - Devolu��o                                        �
//�������������������������������������������������������������������������������������������
ElseIf cOperNF == "E" .And. MaFisRet(,"NF_TIPONF") == "D" .And. lStDif
	//�������������������������������������������������������������������������������������Ŀ
	//� Define o retorno original da rotina                                                 �
	//���������������������������������������������������������������������������������������
	uRetorno	:= .T. 
	//�����������������������������������������������������������������������������Ŀ
	//� Calcula o valor do  Suporte F�sico (Valor m�dia x quantidade vendida)       �
	//�������������������������������������������������������������������������������
	nSupFis	:= Round( nQdeIte * SB1->B1_YVLMID, TAMSX3( "D2_BRICMS" )[2] )
	//�����������������������������������������������������������������������������Ŀ
	//� Agrega o valor do Frete, seguro e despesa de acordo com configura��o do TES �
	//� Conforme solicita��o por e-mail as despesas devem ser agregadas antes do IVA�
	//�������������������������������������������������������������������������������
	If SF4->F4_DESPICM <> "2" .Or. GetNewPar("MV_DESPICM",.T.)
		nSupFis	+= MaFisRet( nItePed, "IT_SEGURO" )
		nSupFis += MaFisRet( nItePed, "IT_DESPESA" )
		nSupFis	+= MaFisRet( nItePed, "IT_FRETE" )
	EndIf


	//�����������������������������������������������������������������������������Ŀ
	//� Calcula a base de calculo para o icms substitui��o tribut�ria               �
	//�������������������������������������������������������������������������������
	nBasRet	:= nSupFis + Round( ( nSupFis * nMargem ) / 100, TAMSX3( "D2_BRICMS" )[2] )
	//�����������������������������������������������������������������������������Ŀ
	//� Calcula o icms substitui��o tribut�ria                                      �
	//�������������������������������������������������������������������������������
	// Conforme solicita��o em 28/12/12 a al�quota do ICMS passou a ser de 4% e esta esta cadastrada na exce��o fiscal
	// sendo recuperada pela rotina padr�o atrav�s da MaFisRet para o campo Aliquota do ICMS
	//nIcmRet	:= Round( ( nBasRet * nAlqSol ) / 100, TAMSX3( "D2_ICMSRET" )[2] ) - Round( ( nSupFis * nAlqSol ) / 100, TAMSX3( "D2_ICMSRET" )[2] )
	nIcmRet	:= Round( ( nBasRet * nAlqSol ) / 100, TAMSX3( "D2_ICMSRET" )[2] ) - Round( ( nSupFis * nAlqICM ) / 100, TAMSX3( "D2_ICMSRET" )[2] )
	//�����������������������������������������������������������������������������Ŀ
	//� Atualiza os dados do aCols e atualiza as fun��es fiscais                    �
	//�������������������������������������������������������������������������������

	//Busca a nota fiscal de origem
	cNfOri 	:= GdFieldGet("D1_NFORI",nItePed)
	cIteOri := GdFieldGet("D1_ITEMORI",nItePed)
	cSeriOri:= GdFieldGet("D1_SERIORI",nItePed)
	cProd 	:= GdFieldGet("D1_COD",nItePed)

	cCliente:= Posicione("SD2",3,xFilial("SD2")+cNfOri+cSeriOri,"D2_CLIENTE")
	cLojacli:= Posicione("SD2",3,xFilial("SD2")+cNfOri+cSeriOri,"D2_LOJA")
	nQtdOri	:= Posicione("SD2",3,xFilial("SD2")+cNfOri+cSeriOri+cCliente+cLojacli+cProd+cIteOri,"D2_QUANT")
	nBasRet := Posicione("SD2",3,xFilial("SD2")+cNfOri+cSeriOri+cCliente+cLojacli+cProd+cIteOri,"D2_BRICMS")
	nValSol := Posicione("SD2",3,xFilial("SD2")+cNfOri+cSeriOri+cCliente+cLojacli+cProd+cIteOri,"D2_ICMSRET")
	nAliqRet:= Posicione("SD2",3,xFilial("SD2")+cNfOri+cSeriOri+cCliente+cLojacli+cProd+cIteOri,"D2_ALIQSOL")
	

	GdFieldPut( "D1_BRICMS", (nBasRet/nQtdOri)*nQdeIte, nItePed )
	MaFisAlt( "IT_BASESOL", (nBasRet/nQtdOri)*nQdeIte, nItePed, .F., Nil, Nil, "MT100", .F. )
	GdFieldPut( "D1_ICMSRET", (nValSol/nQtdOri)*nQdeIte, nItePed )
	MaFisAlt( "IT_VALSOL", (nValSol/nQtdOri)*nQdeIte, nItePed, .F., Nil, Nil, "MT100", .F. )
	MaFisAlt( "IT_ALIQSOL", nAliqRet , nItePed, .F., Nil, Nil, "MT100", .F. )

	//�����������������������������������������������������������������������������Ŀ
	//� Atualiza os dados dos t�tulos                                               �
	//�������������������������������������������������������������������������������
	//nVlrAux	:= MaFisRet( , "NF_BASEDUP" )
	//MaFisAlt( "NF_BASEDUP", nVlrAux - nRetOri + nIcmRet )
//�����������������������������������������������������������������������������������������Ŀ
//� N�o esta definido para exeutar o calculo de diferencial                                 �
//�������������������������������������������������������������������������������������������
Else
	If cOperNF == "S"
		//���������������������������������������������������������������������������������Ŀ
		//� Define o retorno original da rotina                                             �
		//�����������������������������������������������������������������������������������
		uRetorno	:= {	MaFisRet( nItePed, "IT_BASESOL" ),;
							MaFisRet( nItePed, "IT_VALSOL" ) }
	Else
		//���������������������������������������������������������������������������������Ŀ
		//� Define o retorno original da rotina                                             �
		//�����������������������������������������������������������������������������������
		uRetorno	:= .T.
	EndIf
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Restaura as �reas originais da rotina                                                   �
//�������������������������������������������������������������������������������������������
RestArea( aAreaSB1 )
RestArea( aAreaAtu )
//�����������������������������������������������������������������������������������������Ŀ
//� Efetua o retorno da fun��o                                                              �
//�������������������������������������������������������������������������������������������
Return( uRetorno )
