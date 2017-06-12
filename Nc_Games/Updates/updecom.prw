#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

//--------------------------------------------------------------------
/*/{Protheus.doc} UPDECOM
Função de update de dicionários para compatibilização

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
User Function UPDECOM( cEmpAmb, cFilAmb )

Local   aSay      := {}
Local   aButton   := {}
Local   aMarcadas := {}
Local   cTitulo   := "ATUALIZAÇÃO DE DICIONÁRIOS E TABELAS"
Local   cDesc1    := "Esta rotina tem como função fazer  a atualização  dos dicionários do Sistema ( SX?/SIX )"
Local   cDesc2    := "Este processo deve ser executado em modo EXCLUSIVO, ou seja não podem haver outros"
Local   cDesc3    := "usuários  ou  jobs utilizando  o sistema.  É EXTREMAMENTE recomendavél  que  se  faça um"
Local   cDesc4    := "BACKUP  dos DICIONÁRIOS  e da  BASE DE DADOS antes desta atualização, para que caso "
Local   cDesc5    := "ocorram eventuais falhas, esse backup possa ser restaurado."
Local   cDesc6    := ""
Local   cDesc7    := ""
Local   lOk       := .F.
Local   lAuto     := ( cEmpAmb <> NIL .or. cFilAmb <> NIL )

Private oMainWnd  := NIL
Private oProcess  := NIL

#IFDEF TOP
    TCInternal( 5, "*OFF" ) // Desliga Refresh no Lock do Top
#ENDIF

__cInterNet := NIL
__lPYME     := .F.

Set Dele On

// Mensagens de Tela Inicial
aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aSay, cDesc3 )
aAdd( aSay, cDesc4 )
aAdd( aSay, cDesc5 )
//aAdd( aSay, cDesc6 )
//aAdd( aSay, cDesc7 )

// Botoes Tela Inicial
aAdd(  aButton, {  1, .T., { || lOk := .T., FechaBatch() } } )
aAdd(  aButton, {  2, .T., { || lOk := .F., FechaBatch() } } )

If lAuto
	lOk := .T.
Else
	FormBatch(  cTitulo,  aSay,  aButton )
EndIf

If lOk
	If lAuto
		aMarcadas :={{ cEmpAmb, cFilAmb, "" }}
	Else
		aMarcadas := EscEmpresa()
	EndIf

	If !Empty( aMarcadas )
		If lAuto .OR. MsgNoYes( "Confirma a atualização dos dicionários ?", cTitulo )
			oProcess := MsNewProcess():New( { | lEnd | lOk := FSTProc( @lEnd, aMarcadas ) }, "Atualizando", "Aguarde, atualizando ...", .F. )
			oProcess:Activate()

			If lAuto
				If lOk
					MsgStop( "Atualização Realizada.", "UPDECOM" )
				Else
					MsgStop( "Atualização não Realizada.", "UPDECOM" )
				EndIf
				dbCloseAll()
			Else
				If lOk
					Final( "Atualização Concluída." )
				Else
					Final( "Atualização não Realizada." )
				EndIf
			EndIf

		Else
			MsgStop( "Atualização não Realizada.", "UPDECOM" )

		EndIf

	Else
		MsgStop( "Atualização não Realizada.", "UPDECOM" )

	EndIf

EndIf

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSTProc
Função de processamento da gravação dos arquivos

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSTProc( lEnd, aMarcadas )
Local   aInfo     := {}
Local   aRecnoSM0 := {}
Local   cAux      := ""
Local   cFile     := ""
Local   cFileLog  := ""
Local   cMask     := "Arquivos Texto" + "(*.TXT)|*.txt|"
Local   cTCBuild  := "TCGetBuild"
Local   cTexto    := ""
Local   cTopBuild := ""
Local   lOpen     := .F.
Local   lRet      := .T.
Local   nI        := 0
Local   nPos      := 0
Local   nRecno    := 0
Local   nX        := 0
Local   oDlg      := NIL
Local   oFont     := NIL
Local   oMemo     := NIL

Private aArqUpd   := {}

If ( lOpen := MyOpenSm0(.T.) )

	dbSelectArea( "SM0" )
	dbGoTop()

	While !SM0->( EOF() )
		// Só adiciona no aRecnoSM0 se a empresa for diferente
		If aScan( aRecnoSM0, { |x| x[2] == SM0->M0_CODIGO } ) == 0 ;
		   .AND. aScan( aMarcadas, { |x| x[1] == SM0->M0_CODIGO } ) > 0
			aAdd( aRecnoSM0, { Recno(), SM0->M0_CODIGO } )
		EndIf
		SM0->( dbSkip() )
	End

	SM0->( dbCloseArea() )

	If lOpen

		For nI := 1 To Len( aRecnoSM0 )

			If !( lOpen := MyOpenSm0(.F.) )
				MsgStop( "Atualização da empresa " + aRecnoSM0[nI][2] + " não efetuada." )
				Exit
			EndIf

			SM0->( dbGoTo( aRecnoSM0[nI][1] ) )

			RpcSetType( 3 )
			RpcSetEnv( SM0->M0_CODIGO, SM0->M0_CODFIL )

			lMsFinalAuto := .F.
			lMsHelpAuto  := .F.

			cTexto += Replicate( "-", 128 ) + CRLF
			cTexto += "Empresa : " + SM0->M0_CODIGO + "/" + SM0->M0_NOME + CRLF + CRLF

			oProcess:SetRegua1( 8 )


			oProcess:IncRegua1( "Dicionário de arquivos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX2( @cTexto )


			FSAtuSX3( @cTexto )


			oProcess:IncRegua1( "Dicionário de índices" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSIX( @cTexto )

			oProcess:IncRegua1( "Dicionário de dados" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			oProcess:IncRegua2( "Atualizando campos/índices" )

			// Alteração física dos arquivos
			__SetX31Mode( .F. )

			If FindFunction(cTCBuild)
				cTopBuild := &cTCBuild.()
			EndIf

			For nX := 1 To Len( aArqUpd )

				If cTopBuild >= "20090811" .AND. TcInternal( 89 ) == "CLOB_SUPPORTED"
					If ( ( aArqUpd[nX] >= "NQ " .AND. aArqUpd[nX] <= "NZZ" ) .OR. ( aArqUpd[nX] >= "O0 " .AND. aArqUpd[nX] <= "NZZ" ) ) .AND.;
						!aArqUpd[nX] $ "NQD,NQF,NQP,NQT"
						TcInternal( 25, "CLOB" )
					EndIf
				EndIf

				If Select( aArqUpd[nX] ) > 0
					dbSelectArea( aArqUpd[nX] )
					dbCloseArea()
				EndIf

				X31UpdTable( aArqUpd[nX] )

				If __GetX31Error()
					Alert( __GetX31Trace() )
					MsgStop( "Ocorreu um erro desconhecido durante a atualização da tabela : " + aArqUpd[nX] + ". Verifique a integridade do dicionário e da tabela.", "ATENÇÃO" )
					cTexto += "Ocorreu um erro desconhecido durante a atualização da estrutura da tabela : " + aArqUpd[nX] + CRLF
				EndIf

				If cTopBuild >= "20090811" .AND. TcInternal( 89 ) == "CLOB_SUPPORTED"
					TcInternal( 25, "OFF" )
				EndIf

			Next nX


			oProcess:IncRegua1( "Dicionário de parâmetros" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX6( @cTexto )


			oProcess:IncRegua1( "Dicionário de pastas" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSXA( @cTexto )


			oProcess:IncRegua1( "Dicionário de consultas padrão" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSXB( @cTexto )


			oProcess:IncRegua1( "Helps de Campo" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuHlp( @cTexto )

			RpcClearEnv()

		Next nI

		If MyOpenSm0(.T.)

			cAux += Replicate( "-", 128 ) + CRLF
			cAux += Replicate( " ", 128 ) + CRLF
			cAux += "LOG DA ATUALIZAÇÃO DOS DICIONÁRIOS" + CRLF
			cAux += Replicate( " ", 128 ) + CRLF
			cAux += Replicate( "-", 128 ) + CRLF
			cAux += CRLF
			cAux += " Dados Ambiente" + CRLF
			cAux += " --------------------"  + CRLF
			cAux += " Empresa / Filial...: " + cEmpAnt + "/" + cFilAnt  + CRLF
			cAux += " Nome Empresa.......: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_NOMECOM", cEmpAnt + cFilAnt, 1, "" ) ) ) + CRLF
			cAux += " Nome Filial........: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_FILIAL" , cEmpAnt + cFilAnt, 1, "" ) ) ) + CRLF
			cAux += " DataBase...........: " + DtoC( dDataBase )  + CRLF
			cAux += " Data / Hora Ínicio.: " + DtoC( Date() )  + " / " + Time()  + CRLF
			cAux += " Environment........: " + GetEnvServer()  + CRLF
			cAux += " StartPath..........: " + GetSrvProfString( "StartPath", "" )  + CRLF
			cAux += " RootPath...........: " + GetSrvProfString( "RootPath" , "" )  + CRLF
			cAux += " Versão.............: " + GetVersao(.T.)  + CRLF
			cAux += " Usuário TOTVS .....: " + __cUserId + " " +  cUserName + CRLF
			cAux += " Computer Name......: " + GetComputerName() + CRLF

			aInfo   := GetUserInfo()
			If ( nPos    := aScan( aInfo,{ |x,y| x[3] == ThreadId() } ) ) > 0
				cAux += " "  + CRLF
				cAux += " Dados Thread" + CRLF
				cAux += " --------------------"  + CRLF
				cAux += " Usuário da Rede....: " + aInfo[nPos][1] + CRLF
				cAux += " Estação............: " + aInfo[nPos][2] + CRLF
				cAux += " Programa Inicial...: " + aInfo[nPos][5] + CRLF
				cAux += " Environment........: " + aInfo[nPos][6] + CRLF
				cAux += " Conexão............: " + AllTrim( StrTran( StrTran( aInfo[nPos][7], Chr( 13 ), "" ), Chr( 10 ), "" ) )  + CRLF
			EndIf
			cAux += Replicate( "-", 128 ) + CRLF
			cAux += CRLF

			cTexto := cAux + cTexto + CRLF

			cTexto += Replicate( "-", 128 ) + CRLF
			cTexto += " Data / Hora Final.: " + DtoC( Date() ) + " / " + Time()  + CRLF
			cTexto += Replicate( "-", 128 ) + CRLF

			cFileLog := MemoWrite( CriaTrab( , .F. ) + ".log", cTexto )

			Define Font oFont Name "Mono AS" Size 5, 12

			Define MsDialog oDlg Title "Atualização concluida." From 3, 0 to 340, 417 Pixel

			@ 5, 5 Get oMemo Var cTexto Memo Size 200, 145 Of oDlg Pixel
			oMemo:bRClicked := { || AllwaysTrue() }
			oMemo:oFont     := oFont

			Define SButton From 153, 175 Type  1 Action oDlg:End() Enable Of oDlg Pixel // Apaga
			Define SButton From 153, 145 Type 13 Action ( cFile := cGetFile( cMask, "" ), If( cFile == "", .T., ;
			MemoWrite( cFile, cTexto ) ) ) Enable Of oDlg Pixel

			Activate MsDialog oDlg Center

		EndIf

	EndIf

Else

	lRet := .F.

EndIf

Return lRet


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX2
Função de processamento da gravação do SX2 - Arquivos

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX2( cTexto )
Local aEstrut   := {}
Local aSX2      := {}
Local cAlias    := ""
Local cEmpr     := ""
Local cPath     := ""
Local nI        := 0
Local nJ        := 0

cTexto  += "Ínicio da Atualização" + " SX2" + CRLF + CRLF

aEstrut := { "X2_CHAVE"  , "X2_PATH"   , "X2_ARQUIVO", "X2_NOME"  , "X2_NOMESPA", "X2_NOMEENG", ;
             "X2_DELET"  , "X2_MODO"   , "X2_TTS"    , "X2_ROTINA", "X2_PYME"   , "X2_UNICO"  , ;
             "X2_MODOEMP", "X2_MODOUN" , "X2_MODULO" }

dbSelectArea( "SX2" )
SX2->( dbSetOrder( 1 ) )
SX2->( dbGoTop() )
cPath := SX2->X2_PATH
cPath := IIf( Right( AllTrim( cPath ), 1 ) <> "\", PadR( AllTrim( cPath ) + "\", Len( cPath ) ), cPath )
cEmpr := Substr( SX2->X2_ARQUIVO, 4 )

aAdd( aSX2, {'ZC1',cPath,'ZC1'+cEmpr,'RASTREAMENTO E-COMMERCE','RASTREAMENTO E-COMMERCE','RASTREAMENTO E-COMMERCE',0,'E','','','','','E','E',0} )
aAdd( aSX2, {'ZC3',cPath,'ZC3'+cEmpr,'PRODUTOS P/ SITE','PRODUTOS P/ SITE','PRODUTOS P/ SITE',0,'C','','','','','C','C',0} )
aAdd( aSX2, {'ZC4',cPath,'ZC4'+cEmpr,'TAB PRECO ECOMMERCE','TAB PRECO ECOMMERCE','TAB PRECO ECOMMERCE',0,'C','','','','','C','C',0} )
aAdd( aSX2, {'ZC5',cPath,'ZC5'+cEmpr,'PEDIDO VENDA PROVISORIO','PEDIDO VENDA PROVISORIO','PEDIDO VENDA PROVISORIO',0,'E','','','','','E','E',0} )
aAdd( aSX2, {'ZC6',cPath,'ZC6'+cEmpr,'ITEM PV PROVISORIO','ITEM PV PROVISORIO','ITEM PV PROVISORIO',0,'E','','','','','E','E',0} )
aAdd( aSX2, {'ZC7',cPath,'ZC7'+cEmpr,'LOG PROCESSAMENTO ECOMMERCE','LOG PROCESSAMENTO ECOMMERCE','LOG PROCESSAMENTO ECOMMERCE',0,'E','','','','','E','E',0} )
aAdd( aSX2, {'ZC8',cPath,'ZC8'+cEmpr,'TITULOS A RECEBER E-COMMERCE','TITULOS A RECEBER E-COMMERCE','TITULOS A RECEBER E-COMMERCE',0,'E','','','','','E','E',0} )
//
// Atualizando dicionário
//
oProcess:SetRegua2( Len( aSX2 ) )

dbSelectArea( "SX2" )
dbSetOrder( 1 )

For nI := 1 To Len( aSX2 )

	oProcess:IncRegua2( "Atualizando Arquivos (SX2)..." )

	If !SX2->( dbSeek( aSX2[nI][1] ) )

		If !( aSX2[nI][1] $ cAlias )
			cAlias += aSX2[nI][1] + "/"
			cTexto += "Foi incluída a tabela " + aSX2[nI][1] + CRLF
		EndIf

		RecLock( "SX2", .T. )
		For nJ := 1 To Len( aSX2[nI] )
			If FieldPos( aEstrut[nJ] ) > 0
				If AllTrim( aEstrut[nJ] ) == "X2_ARQUIVO"
					FieldPut( FieldPos( aEstrut[nJ] ), SubStr( aSX2[nI][nJ], 1, 3 ) + cEmpAnt +  "0" )
				Else
					FieldPut( FieldPos( aEstrut[nJ] ), aSX2[nI][nJ] )
				EndIf
			EndIf
		Next nJ
		MsUnLock()

	Else

		If  !( StrTran( Upper( AllTrim( SX2->X2_UNICO ) ), " ", "" ) == StrTran( Upper( AllTrim( aSX2[nI][12]  ) ), " ", "" ) )
			RecLock( "SX2", .F. )
			SX2->X2_UNICO := aSX2[nI][12]
			MsUnlock()

			If MSFILE( RetSqlName( aSX2[nI][1] ),RetSqlName( aSX2[nI][1] ) + "_UNQ"  )
				TcInternal( 60, RetSqlName( aSX2[nI][1] ) + "|" + RetSqlName( aSX2[nI][1] ) + "_UNQ" )
			EndIf

			cTexto += "Foi alterada a chave única da tabela " + aSX2[nI][1] + CRLF
		EndIf

	EndIf

Next nI

cTexto += CRLF + "Final da Atualização" + " SX2" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX3
Função de processamento da gravação do SX3 - Campos

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX3( cTexto )
Local aEstrut   := {}
Local aSX3      := {}
Local cAlias    := ""
Local cAliasAtu := ""
Local cMsg      := ""
Local cSeqAtu   := ""
Local lTodosNao := .F.
Local lTodosSim := .F.
Local nI        := 0
Local nJ        := 0
Local nOpcA     := 0
Local nPosArq   := 0
Local nPosCpo   := 0
Local nPosOrd   := 0
Local nPosSXG   := 0
Local nPosTam   := 0
Local nPosVld   := 0
Local nSeqAtu   := 0
Local nTamSeek  := Len( SX3->X3_CAMPO )

cTexto  += "Ínicio da Atualização" + " SX3" + CRLF + CRLF

aEstrut := { { "X3_ARQUIVO", 0 }, { "X3_ORDEM"  , 0 }, { "X3_CAMPO"  , 0 }, { "X3_TIPO"   , 0 }, { "X3_TAMANHO", 0 }, { "X3_DECIMAL", 0 }, ;
             { "X3_TITULO" , 0 }, { "X3_TITSPA" , 0 }, { "X3_TITENG" , 0 }, { "X3_DESCRIC", 0 }, { "X3_DESCSPA", 0 }, { "X3_DESCENG", 0 }, ;
             { "X3_PICTURE", 0 }, { "X3_VALID"  , 0 }, { "X3_USADO"  , 0 }, { "X3_RELACAO", 0 }, { "X3_F3"     , 0 }, { "X3_NIVEL"  , 0 }, ;
             { "X3_RESERV" , 0 }, { "X3_CHECK"  , 0 }, { "X3_TRIGGER", 0 }, { "X3_PROPRI" , 0 }, { "X3_BROWSE" , 0 }, { "X3_VISUAL" , 0 }, ;
             { "X3_CONTEXT", 0 }, { "X3_OBRIGAT", 0 }, { "X3_VLDUSER", 0 }, { "X3_CBOX"   , 0 }, { "X3_CBOXSPA", 0 }, { "X3_CBOXENG", 0 }, ;
             { "X3_PICTVAR", 0 }, { "X3_WHEN"   , 0 }, { "X3_INIBRW" , 0 }, { "X3_GRPSXG" , 0 }, { "X3_FOLDER" , 0 }, { "X3_PYME"   , 0 }, ;
             { "X3_AGRUP"  , 0 } }

aEval( aEstrut, { |x| x[2] := SX3->( FieldPos( x[1] ) ) } )


aAdd( aSX3, {'SA1','Q8','A1_ZCODCIA','N',4,0,'Cod CiaShop','Cod CiaShop','Cod CiaShop','Cod CiaShop','Cod CiaShop','Cod CiaShop','@E 9999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'SA1','Q9','A1_ZSEXO','C',1,0,'Sexo','Sexo','Sexo','Sexo','Sexo','Sexo','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Pertence("FM")','M=Masculino;F=Feminino','M=Masculino;F=Feminino','M=Masculino;F=Feminino','','','','','','',''} )
aAdd( aSX3, {'SA1','R0','A1_ZESTCIV','C',1,0,'Estado Civil','Estado Civil','Estado Civil','Estado Civil','Estado Civil','Estado Civil','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Pertence("SCDVUJ")','S=Solteiro(a);C=Casado(a);D=Divorciado(a);V=Viuvo(a);U=Uniao Estavel;J=Separado(a) Judicialmente','S=Solteiro(a);C=Casado(a);D=Divorciado(a);V=Viuvo(a);U=Uniao Estavel;J=Separado(a) Judicialmente','S=Solteiro(a);C=Casado(a);D=Divorciado(a);V=Viuvo(a);U=Uniao Estavel;J=Separado(a) Judicialmente','','','','','','',''} )
aAdd( aSX3, {'SA1','R1','A1_ZCODTAB','C',3,0,'Tab Ciashop','Tab Ciashop','Tab Ciashop','Tabela Ciashop','Tabela Ciashop','Tabela Ciashop','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'SA4','39','A4_ZCODCIA','N',4,0,'Cod Ciashop','Cod Ciashop','Cod Ciashop','Cod Ciashop','Cod Ciashop','Cod Ciashop','@R 9999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'SB1','Y1','B1_ZSALCIA','N',14,2,'SaldoCiashop','SaldoCiashop','SaldoCiashop','Saldo Ciashop','Saldo Ciashop','Saldo Ciashop','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'SC5','38','C5_XFORMPG','C',6,0,'Form.Pagto','Forma Pago','Paym. Mode','Forma de Pagamento','Forma de Pago','Payment Mode','@!','Vazio().Or.ExistCpo("SX5","24"+M->C5_XFORMPG)',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','24',1,Chr(134) + Chr(128),'','','U','N','','','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','B1','C5_NUMPV','N',5,0,'NUM PED','NUM PED','NUM PED','','','','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','1','',''} )
aAdd( aSX3, {'SC5','N4','C5_PARC5','N',12,2,'Parcela 5','Parcela 5','Parcela 5','Valor da Parcela 5','Valor da Parcela 5','Valor da Parcela 5','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','N5','C5_DATA5','D',8,0,'Vencimento 5','Vencimento 5','Vencimento 5','Vencimento da Parcela 5','Vencimento da Parcela 5','Vencimento da Parcela 5','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','N6','C5_PARC6','N',12,2,'Parcela 6','Parcela 6','Parcela 6','Valor da Parcela 6','Valor da Parcela 6','Valor da Parcela 6','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','N7','C5_DATA6','D',8,0,'Vencimento 6','Vencimento 6','Vencimento 6','Vencimento da Parcela 6','Vencimento da Parcela 6','Vencimento da Parcela 6','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','N8','C5_PARC7','N',12,2,'Parcela 7','Parcela 7','Parcela 7','Valor da Parcela 7','Valor da Parcela 7','Valor da Parcela 7','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','N9','C5_DATA7','D',8,0,'Vencimento 7','Vencimento 7','Vencimento 7','Vencimento da Parcela 7','Vencimento da Parcela 7','Vencimento da Parcela 7','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O0','C5_PARC8','N',12,2,'Parcela 8','Parcela 8','Parcela 8','Valor da Parcela 8','Valor da Parcela 8','Valor da Parcela 8','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O1','C5_DATA8','D',8,0,'Vencimento 8','Vencimento 8','Vencimento 8','Vencimento da Parcela 8','Vencimento da Parcela 8','Vencimento da Parcela 8','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O2','C5_PARC9','N',12,2,'Parcela 9','Parcela 9','Parcela 9','Valor da Parcela 9','Valor da Parcela 9','Valor da Parcela 9','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O3','C5_DATA9','D',8,0,'Vencimento 9','Vencimento 9','Vencimento 9','Vencimento da Parcela 9','Vencimento da Parcela 9','Vencimento da Parcela 9','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O4','C5_PARCA','N',12,2,'Parcela 10','Parcela 10','Parcela 10','Valor da Parcela 10','Valor da Parcela 10','Valor da Parcela 10','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O5','C5_DATAA','D',8,0,'Vencimento10','Vencimento10','Vencimento10','Vencimento da Parcela 10','Vencimento da Parcela 10','Vencimento da Parcela 10','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O6','C5_PARCB','N',12,2,'Parcela 11','Parcela 11','Parcela 11','Valor da Parcela 11','Valor da Parcela 11','Valor da Parcela 11','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O7','C5_DATAB','D',8,0,'Vencimento11','Vencimento11','Vencimento11','Vencimento da Parcela 11','Vencimento da Parcela 11','Vencimento da Parcela 11','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O8','C5_PARCC','N',12,2,'Parcela 12','Parcela 12','Parcela 12','Valor da Parcela 12','Valor da Parcela 12','Valor da Parcela 12','@E 999,999,999.99','positivo() .or. vazio()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(154) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O8','C5_DATAC','D',8,0,'Vencimento12','Vencimento12','Vencimento12','Vencimento da Parcela 12','Vencimento da Parcela 12','Vencimento da Parcela 12','','A410Venc()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','U','N','A','R','','','','','','','M->C5_XECOMER<>"C"','','','7','S',''} )
aAdd( aSX3, {'SC5','O8','C5_XOPPAC','C',5,0,'Def.Oper PAC','Def.Oper PAC','Def.Oper PAC','Def.Oper PAC','Def.Oper PAC','Def.Oper PAC','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'SC5','O9','C5_XCODENT','C',5,0,'Form.Entreg','Form.Entreg','Form.Entreg','Form.Entreg','Form.Entreg','Form.Entreg','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','01','ZC1_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC1','02','ZC1_DATAX','D',8,0,'Data','Data','Data','Data','Data','Data','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','03','ZC1_DESCRI','C',50,0,'Descricao','Descricao','Descricao','Descricao','Descricao','Descricao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','04','ZC1_DESTIN','C',50,0,'Destinatario','Destinatario','Destinatario','Destinatario','Destinatario','Destinatario','@S25','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','05','ZC1_CEP','C',8,0,'CEP','CEP','CEP','CEP','CEP','CEP','@R 99999-999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','06','ZC1_UF','C',2,0,'Estado','Estado','Estado','Estado','Estado','Estado','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','07','ZC1_PESO','N',10,2,'Peso(g)','Peso','Peso','Peso','Peso','Peso','@E 9,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','08','ZC1_CUBICO','N',10,2,'Cub.(g)','Cubico','Cubico','Cubico','Cubico','Cubico','@E 9,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','09','ZC1_QUANT','N',10,2,'Quantidade','Quantidade','Quantidade','Quantidade','Quantidade','Quantidade','@E 9,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','10','ZC1_REGIST','C',25,0,'Cod.Rastreio','Cod.Rastreio','Cod.Rastreio','Cod.Rastreio','Cod.Rastreio','Cod.Rastreio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','11','ZC1_ADICIO','C',5,0,'Adicionais','Adicionais','Adicionais','Adicionais','Adicionais','Adicionais','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','12','ZC1_OBS','C',50,0,'Observacao','Observacao','Observacao','Observacao','Observacao','Observacao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','13','ZC1_NF','C',15,0,'NF','NF','NF','Nota Fsical','Nota Fsical','Nota Fsical','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','14','ZC1_CLASSI','C',30,0,'Classific.','Classific.','Classific.','Classificação.','Classificação.','Classificação.','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','V','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','15','ZC1_CONTAL','C',50,0,'Conta Lote','Conta Lote','Conta Lote','Conta Lote','Conta Lote','Conta Lote','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','16','ZC1_DECLAR','N',10,2,'Declarado','Declarado','Declarado','Declarado','Declarado','Declarado','@E 9,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','17','ZC1_UNITAR','N',10,2,'Unitário','Unitário','Unitário','Unitário','Unitário','Unitário','@E 9,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','18','ZC1_VALOR','N',14,2,'Valor','Valor','Valor','Valor','Valor','Valor','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','19','ZC1_DTIMPO','D',8,0,'Dt.Importa','Dt.Importa','Dt.Importa','Data Importacao','Data Importacao','Data Importacao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','20','ZC1_HIMPOR','C',8,0,'Hora Importa','Hora Importa','Hora Importa','Hora Importação','Hora Importação','Hora Importação','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','21','ZC1_USUARI','C',25,0,'Usuário','Usuário','Usuário','Usuário','Usuário','Usuário','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','22','ZC1_USERGA','C',17,0,'Log de Alter','Log de Alter','Log de Alter','Log de Alteracao','Log de Alteracao','Log de Alteracao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',9,Chr(254) + Chr(192),'','','L','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC1','23','ZC1_ERRO','L',1,0,'Contem Erro','Contem Erro','Contem Erro','Contem Erro','Contem Erro','Contem Erro','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','01','ZC3_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC3','02','ZC3_OK','C',2,0,'Ok','Ok','Ok','Ok','Ok','Ok','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','03','ZC3_STATUS','C',2,0,'Vai p/ Site?','Vai p/ Site','Vai p/ Site','Vai p/ Site?','Vai p/ Site','Vai p/ Site','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','01=Sim;02=Nao;03=Pend. Alteracao;04=Pendente','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','04','ZC3_CODPRO','C',15,0,'Produto','Produto','Produto','Produto','Produto','Produto','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','ExistCpo("ZC3")','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','05','ZC3_DESCRI','C',50,0,'Descrição','Descrição','Descrição','Descrição','Descrição','Descrição','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','01','ZC4_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC4','02','ZC4_CODTAB','C',3,0,'Cód. Tabela','Cód. Tabela','Cód. Tabela','Código Tabela','Código Tabela','Código Tabela','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'GETSXENUM("ZC4","ZC4_CODTAB")','',0,Chr(254) + Chr(192),'','','U','S','V','R','','NaoVazio().And.ExistChav("ZC4")','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','03','ZC4_TABDES','C',30,0,'Desc. Tabela','Desc. Tabela','Desc. Tabela','Desc. Tabela','Desc. Tabela','Desc. Tabela','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','04','ZC4_PESSOA','C',1,0,'Fisica/Jurid','Fisica/Jurid','Fisica/Jurid','Pessoa Fisica/Juridica','Pessoa Fisica/Juridica','Pessoa Fisica/Juridica','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','J=Juridica;F=Fisica','J=Juridica;F=Fisica','J=Juridica;F=Fisica','','','','','','',''} )
aAdd( aSX3, {'ZC4','05','ZC4_TCONSU','C',1,0,'Tp Consumido','Tp Consumido','Tp Consumido','Tp Consumidor','Tp Consumidor','Tp Consumidor','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','1=Cliente;2=Funcionario','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','06','ZC4_TABBAS','C',3,0,'Tabela Base','Tabela Base','Tabela Base','Tabela Base','Tabela Base','Tabela Base','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','DA0',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','07','ZC4_EST','C',2,0,'Estado','Estado','Estado','Estado destino','Estado destino','Estado destino','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','12',0,Chr(254) + Chr(192),'','','U','S','A','R','','M->ZC4_EST$"**" .OR. ExistCpo("SX5","12"+M->ZC4_EST)','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','08','ZC4_ITEM','C',4,0,'Item','Item','Item','Item','Item','Item','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','09','ZC4_CODPRO','C',15,0,'Produto','Produto','Produto','Produto','Produto','Produto','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SB1',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','10','ZC4_DESCRI','C',30,0,'Desc. Prod.','Desc. Prod.','Desc. Prod.','Descri Produto','Descri Produto','Descri Produto','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','11','ZC4_PRCBAS','N',9,2,'Preço Base','Preço Base','Preço Base','Preço Base','Preço Base','Preço Base','@E 999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','12','ZC4_PRCCIA','N',9,2,'Prc CiaShop','Prc CiaShop','Prc CiaShop','Preço CiaShop','Preço CiaShop','Preço CiaShop','@E 999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','13','ZC4_PERFRT','N',5,2,'% Frete','% Frete','% Frete','% Frete','% Frete','% Frete','@E 99.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','14','ZC4_PERIPI','N',5,2,'% IPI','% IPI','% IPI','% IPI','% IPI','% IPI','@E 99.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','15','ZC4_ALIINT','N',5,2,'Aliq.Interna','Aliq.Interna','Aliq.Interna','Aliq. de ICMS interna','Aliq. de ICMS interna','Aliq. de ICMS interna','@E 99.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','16','ZC4_ALIEXT','N',5,2,'Aliq.Externa','Aliq.Externa','Aliq.Externa','Aliq. de ICMS Externa','Aliq. de ICMS Externa','Aliq. de ICMS Externa','@E 99.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','17','ZC4_MARGEM','N',6,2,'Margem Lucro','Margem Lucro','Margem Lucro','Margem Lucro Presumido','Margem Lucro Presumido','Margem Lucro Presumido','@E 999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','18','ZC4_ALIDST','N',5,2,'Al.ICMS Dest','Al.ICMS Dest','Al.ICMS Dest','Aliquota ICMS no Destino','Aliquota ICMS no Destino','Aliquota ICMS no Destino','@E 99.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','19','ZC4_FLAG','C',1,0,'Flag','Flag','Flag','Flag','Flag','Flag','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','20','ZC4_DESP','N',5,2,'Despesas','Despesas','Despesas','Despesas Variaveis','Despesas Variaveis','Despesas Variaveis','@E 99.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','21','ZC4_BSICM','N',6,2,'%B Redu ICM','%B. Redu ICM','%B. Redu ICM','%Base Reducao ICM','%Base Reducao ICM','%Base Reducao ICM','@E 999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','22','ZC4_BICMST','N',6,2,'%B Redu ST','%B Redu. ST','%B Redu. ST','%Base Reducao ST','%Base Reducao ST','%Base Reducao ST','@E 999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC4','23','ZC4_TESINT','C',3,0,'TES intelig.','TES intelig.','TES intelig.','TES inteligente','TES inteligente','TES inteligente','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','01','ZC5_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','S','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC5','02','ZC5_NUM','N',6,0,'PV Chiashop','NumeroPedido','NumeroPedido','NumeroPedido Ciashop','NumeroPedido Ciashop','NumeroPedido Ciashop','@E 999999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','03','ZC5_NUMPV','C',6,0,'PV Protheus','Pedido Proth','Pedido Proth','Numero PV Protheus','Numero PV Protheus','Numero PV Protheus','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','04','ZC5_CLIENT','C',6,0,'Cliente','Cliente','Cliente','Cliente','Cliente','Cliente','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SA1',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','05','ZC5_LOJA','C',2,0,'Loja','Loja','Loja','Loja','Loja','Loja','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','06','ZC5_NOME','C',50,0,'Nome Cliente','Nome Cliente','Nome Cliente','Nome do cliente','Nome do cliente','Nome do cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','Posicione("SA1",1,xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA,"A1_NOME")','','','',''} )
aAdd( aSX3, {'ZC5','07','ZC5_COND','C',3,0,'Forma Pagto','Forma Pagto','Forma Pagto','Forma Pagamento','Forma Pagamento','Forma Pagamento','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','24',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','08','ZC5_STATUS','C',2,0,'Status PV','Status PV','Status PV','Status PV','Status PV','Status PV','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','09','ZC5_ATUALI','C',1,0,'Atualiza','Atualiza','Atualiza','Atualiza Status','Atualiza Status','Atualiza Status','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'"N"','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','S=Sim;N=Nao','S=Sim;N=Nao','S=Sim;N=Nao','','','','','','',''} )
aAdd( aSX3, {'ZC5','10','ZC5_NOTA','C',9,0,'Nota Fiscal','Nota Fiscal','Nota Fiscal','Nota Fiscal','Nota Fiscal','Nota Fiscal','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','11','ZC5_SERIE','C',3,0,'Serie','Serie','Serie','Serie','Serie','Serie','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','12','ZC5_TOTAL','N',14,2,'Total Pedido','Total Pedido','Total Pedido','Total Pedido','Total Pedido','Total Pedido','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','13','ZC5_QTDPAR','N',3,0,'Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','@E 999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','14','ZC5_ESTORN','C',1,0,'Estorno','Estorno','Estorno','Estorno','Estorno','Estorno','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','N=Não;S=Sim','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','15','ZC5_FRETE','N',14,4,'Frete Pedido','Frete Pedido','Frete Pedido','Frete Pedido','Frete Pedido','Frete Pedido','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','16','ZC5_DOCDEV','C',9,0,'Doc.Devol.','Doc.Devol.','Doc.Devol.','Documento de devoluçao','Documento de devoluçao','Documento de devoluçao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','17','ZC5_SERDEV','C',3,0,'Serie Dev.','Serie Dev.','Serie Dev.','Serie de devoluçao','Serie de devoluçao','Serie de devoluçao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','18','ZC5_IDTRAN','C',50,0,'Id Transacao','Id Transacao','Id Transacao','Id Transacao','Id Transacao','Id Transacao','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','19','ZC5_CODENT','C',5,0,'Form. Entreg','Form. Entreg','Form. Entreg','Form. Entreg','Form. Entreg','Form. Entreg','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','20','ZC5_FLAG','C',1,0,'Flag','Flag','Flag','Flag','Flag','Flag','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','21','ZC5_CADAST','C',10,0,'Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','22','ZC5_CODCIA','C',10,0,'Cod. CIASHOP','Cod. CIASHOP','Cod. CIASHOP','Codigo CIASHOP','Codigo CIASHOP','Codigo CIASHOP','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','23','ZC5_NOMCIA','C',50,0,'Nome','Nome','Nome','Nome','Nome','Nome','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','24','ZC5_VDESCO','N',12,2,'Vlr.Desconto','Vlr.Desconto','Vlr.Desconto','Valor do Desconto','Valor do Desconto','Valor do Desconto','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','25','ZC5_PDESCO','N',6,2,'% Desconto','% Desconto','% Desconto','Percentual de Desconto','Percentual de Desconto','Percentual de Desconto','@E 999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','26','ZC5_PAGTO','C',1,0,'Pagamento','Pagamento','Pagamento','Pagamento','Pagamento','Pagamento','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','1=Aguard.Pagamento;2=Pago','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','27','ZC5_RASTRE','C',25,0,'Cod.Rastreio','Cod.Rastreio','Cod.Rastreio','Codigo Rastreio','Codigo Rastreio','Codigo Rastreio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','28','ZC5_MSEXP','C',8,0,'Ident.Exp.','Ident.Exp.','Ident.Exp.','Ident.Exp.Dados','Ident.Exp.Dados','Ident.Exp.Dados','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',9,Chr(254) + Chr(192),'','','L','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','01','ZC6_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC6','02','ZC6_NUM','N',6,0,'Numero PV','Numero PV','Numero PV','Numero PV','Numero PV','Numero PV','@E 999999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','03','ZC6_ITEM','C',2,0,'Item PV','Item PV','Item PV','Item PV','Item PV','Item PV','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','04','ZC6_PRODUT','C',15,0,'Produto','Produto','Produto','Produto','Produto','Produto','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SB1',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','05','ZC6_QTDVEN','N',12,2,'Qtd Vendida','Qtd Vendida','Qtd Vendida','Qtd Vendida','Qtd Vendida','Qtd Vendida','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','06','ZC6_VLRUNI','N',12,2,'Valor Unit','Valor Unit','Valor Unit','Valor Unitario','Valor Unitario','Valor Unitario','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','07','ZC6_VLRTOT','N',12,2,'Valor Total','Valor Total','Valor Total','Valor Total','Valor Total','Valor Total','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','08','ZC6_QTDRES','N',12,2,'Qtd Reserva','Qtd Reserva','Qtd Reserva','Qtd Reserva','Qtd Reserva','Qtd Reserva','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','09','ZC6_LOCAL','C',2,0,'Local','Local','Local','Local','Local','Local','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','01','ZC7_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC7','02','ZC7_NUM','C',6,0,'Pedido','Pedido','Pedido','Numero do pedido','Numero do pedido','Numero do pedido','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','03','ZC7_ACAO','C',70,0,'Processo','Processo','Processo','Descricao do processo','Descricao do processo','Descricao do processo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','04','ZC7_DATA','D',8,0,'Dt.Log','Dt.Log','Dt.Log','Data do log','Data do log','Data do log','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','05','ZC7_HORA','C',10,0,'Hora','Hora','Hora','Hora','Hora','Hora','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','06','ZC7_USUARI','C',50,0,'Usuario','Usuario','Usuario','Usuario','Usuario','Usuario','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','07','ZC7_OBS','M',10,0,'Observacao','Observacao','Observacao','Observacao','Observacao','Observacao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','08','ZC7_ERRO','C',2,0,'Flag','Flag','Flag','Flag','Flag','Flag','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','09','ZC7_PVECOM','N',6,0,'Pedido Site','Pedido Site','Pedido Site','Pedido Site','Pedido Site','Pedido Site','@E 999,999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','10','ZC7_STATPV','C',2,0,'Status PV','Status PV','Status PV','Status PV','Status PV','Status PV','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','11','ZC7_CADAST','C',10,0,'Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','12','ZC7_CODCIA','C',10,0,'Cod. CIASHOP','Cod. CIASHOP','Cod. CIASHOP','Codigo CIASHOP','Codigo CIASHOP','Codigo CIASHOP','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','01','ZC8_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC8','02','ZC8_PVECOM','N',6,0,'Pedido E-com','Pedido E-com','Pedido E-com','Pedido de venda E-commerc','Pedido de venda E-commerc','Pedido de venda E-commerc','@E 999,999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','03','ZC8_PEDIDO','C',6,0,'Pedido Proth','Pedido Proth','Pedido Proth','Pedido de venda Protheus','Pedido de venda Protheus','Pedido de venda Protheus','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','04','ZC8_PREFIX','C',3,0,'Prefixo','Prefixo','Prefixo','Prefixo','Prefixo','Prefixo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','05','ZC8_TITULO','C',9,0,'Titulo','Titulo','Titulo','Titulo','Titulo','Titulo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','06','ZC8_PARCEL','C',2,0,'Parcela','Parcela','Parcela','Parcela','Parcela','Parcela','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','07','ZC8_TIPO','C',3,0,'Tipo','Tipo','Tipo','Tipo','Tipo','Tipo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','08','ZC8_STATUS','C',2,0,'Status','Status','Status','Status','Status','Status','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','01=Baixado;02=Erro ao baixar titulo;03=Baixado parcialmente;04=Excluido','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','09','ZC8_OBS','M',10,0,'Observação','Observação','Observação','Observação','Observação','Observação','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','10','ZC8_VALOR','N',15,2,'Valor','Valor','Valor','Valor do titulo','Valor do titulo','Valor do titulo','@E 999,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','11','ZC8_SALDO','N',15,2,'Saldo','Saldo','Saldo','Saldo do titulo','Saldo do titulo','Saldo do titulo','@E 999,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','12','ZC8_VENCTO','D',8,0,'Data Vencto.','Data Vencto.','Data Vencto.','Data Vencto.','Data Vencto.','Data Vencto.','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC8','13','ZC8_VENREA','D',8,0,'Vencto. Real','Vencto. Real','Vencto. Real','Vencimento real','Vencimento real','Vencimento real','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
//
// Atualizando dicionário
//

nPosArq := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_ARQUIVO" } )
nPosOrd := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_ORDEM"   } )
nPosCpo := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_CAMPO"   } )
nPosTam := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_TAMANHO" } )
nPosSXG := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_GRPSXG"  } )
nPosVld := aScan( aEstrut, { |x| AllTrim( x[1] ) == "X3_VALID"   } )

aSort( aSX3,,, { |x,y| x[nPosArq]+x[nPosOrd]+x[nPosCpo] < y[nPosArq]+y[nPosOrd]+y[nPosCpo] } )

oProcess:SetRegua2( Len( aSX3 ) )

dbSelectArea( "SX3" )
dbSetOrder( 2 )
cAliasAtu := ""

For nI := 1 To Len( aSX3 )

	//
	// Verifica se o campo faz parte de um grupo e ajsuta tamanho
	//
	If !Empty( aSX3[nI][nPosSXG] )
		SXG->( dbSetOrder( 1 ) )
		If SXG->( MSSeek( aSX3[nI][nPosSXG] ) )
			If aSX3[nI][nPosTam] <> SXG->XG_SIZE
				aSX3[nI][nPosTam] := SXG->XG_SIZE
				cTexto += "O tamanho do campo " + aSX3[nI][nPosCpo] + " NÃO atualizado e foi mantido em ["
				cTexto += AllTrim( Str( SXG->XG_SIZE ) ) + "]" + CRLF
				cTexto += "   por pertencer ao grupo de campos [" + SX3->X3_GRPSXG + "]" + CRLF + CRLF
			EndIf
		EndIf
	EndIf

	SX3->( dbSetOrder( 2 ) )

	If !( aSX3[nI][nPosArq] $ cAlias )
		cAlias += aSX3[nI][nPosArq] + "/"
		aAdd( aArqUpd, aSX3[nI][nPosArq] )
	EndIf

	If !SX3->( dbSeek( PadR( aSX3[nI][nPosCpo], nTamSeek ) ) )

		//
		// Busca ultima ocorrencia do alias
		//
		If ( aSX3[nI][nPosArq] <> cAliasAtu )
			cSeqAtu   := "00"
			cAliasAtu := aSX3[nI][nPosArq]

			dbSetOrder( 1 )
			SX3->( dbSeek( cAliasAtu + "ZZ", .T. ) )
			dbSkip( -1 )

			If ( SX3->X3_ARQUIVO == cAliasAtu )
				cSeqAtu := SX3->X3_ORDEM
			EndIf

			nSeqAtu := Val( RetAsc( cSeqAtu, 3, .F. ) )
		EndIf

		nSeqAtu++
		cSeqAtu := RetAsc( Str( nSeqAtu ), 2, .T. )

		RecLock( "SX3", .T. )
		For nJ := 1 To Len( aSX3[nI] )
			If     nJ == nPosOrd  // Ordem
				SX3->( FieldPut( FieldPos( aEstrut[nJ][1] ), cSeqAtu ) )

			ElseIf aEstrut[nJ][2] > 0
				SX3->( FieldPut( FieldPos( aEstrut[nJ][1] ), aSX3[nI][nJ] ) )

			EndIf
		Next nJ

		dbCommit()
		MsUnLock()

		cTexto += "Criado o campo " + aSX3[nI][nPosCpo] + CRLF

	EndIf

	oProcess:IncRegua2( "Atualizando Campos de Tabelas (SX3)..." )

Next nI

cTexto += CRLF + "Final da Atualização" + " SX3" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSIX
Função de processamento da gravação do SIX - Indices

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSIX( cTexto )
Local aEstrut   := {}
Local aSIX      := {}
Local lAlt      := .F.
Local lDelInd   := .F.
Local nI        := 0
Local nJ        := 0

cTexto  += "Ínicio da Atualização" + " SIX" + CRLF + CRLF

aEstrut := { "INDICE" , "ORDEM" , "CHAVE", "DESCRICAO", "DESCSPA"  , ;
             "DESCENG", "PROPRI", "F3"   , "NICKNAME" , "SHOWPESQ" }

aAdd( aSIX, {'SA4','A','A4_FILIAL+A4_YCODWMS','Codigo WMS','Codigo WMS','Codigo WMS','U','','CODWMS','N'} )
aAdd( aSIX, {'SB1','B','B1_FILIAL+B1_XDESC','Descricao NC Games','Descricao NC Games','Descricao NC Games','U','','',''} )
aAdd( aSIX, {'SB1','C','B1_FILIAL+B1_ITEMCC+B1_COD','Item Conta+Codigo NC','Item Cuenta+Codigo','Account Item+Codigo','U','','B1ITEMCC','S'} )
aAdd( aSIX, {'SC5','5','C5_FILIAL+C5_TIPAGEN','Tipo Agend.','Tipo Agend.','Tipo Agend.','U','','','S'} )
aAdd( aSIX, {'SC5','6','C5_FILIAL+C5_DTAGEND','Dt. Agend','Dt. Agend','Dt. Agend','U','','','S'} )
aAdd( aSIX, {'ZC1','1','ZC1_FILIAL+ZC1_DATAX+ZC1_DESCRI+ZC1_REGIST','Data+Descricao+Cod.Rastreio','Data+Descricao+Cod.Rastreio','Data+Descricao+Cod.Rastreio','U','','','S'} )
aAdd( aSIX, {'ZC1','2','ZC1_FILIAL+ZC1_REGIST+ZC1_DATAX','Cod.Rastreio+Data','Cod.Rastreio+Data','Cod.Rastreio+Data','U','','','S'} )
aAdd( aSIX, {'ZC3','1','ZC3_FILIAL+ZC3_STATUS','Vai p/ Site','Vai p/ Site','Vai p/ Site','U','','','N'} )
aAdd( aSIX, {'ZC3','2','ZC3_FILIAL+ZC3_CODPRO','Produto','Produto','Produto','U','','','N'} )
aAdd( aSIX, {'ZC4','1','ZC4_FILIAL+ZC4_ITEM+ZC4_CODPRO','Item+Produto','Item+Produto','Item+Produto','U','','','N'} )
aAdd( aSIX, {'ZC4','2','ZC4_FILIAL+ZC4_CODTAB+ZC4_CODPRO','Cód. Tabela+Produto','Cód. Tabela+Produto','Cód. Tabela+Produto','U','','','N'} )
aAdd( aSIX, {'ZC4','3','ZC4_FILIAL+ZC4_CODTAB+ZC4_TABBAS+ZC4_EST','Cód. Tabela+Tabela Base+Estado','Cód. Tabela+Tabela Base+Estado','Cód. Tabela+Tabela Base+Estado','U','','','N'} )
aAdd( aSIX, {'ZC4','4','ZC4_FILIAL+ZC4_CODTAB+ZC4_FLAG','Cód. Tabela+Flag','Cód. Tabela+Flag','Cód. Tabela+Flag','U','','','N'} )
aAdd( aSIX, {'ZC5','1','ZC5_FILIAL+ZC5_NUM','NumeroPedido','NumeroPedido','NumeroPedido','U','','','S'} )
aAdd( aSIX, {'ZC5','2','ZC5_FILIAL+ZC5_NUMPV','Num PV','Num PV','Num PV','U','','','S'} )
aAdd( aSIX, {'ZC5','3','ZC5_FILIAL+ZC5_CADAST+ZC5_CODCIA','Cadastro+Cod. CIASHOP','Cadastro+Cod. CIASHOP','Cadastro+Cod. CIASHOP','U','','','N'} )
aAdd( aSIX, {'ZC5','4','ZC5_FILIAL+ZC5_NOTA+ZC5_SERIE+ZC5_CLIENT+ZC5_LOJA','Nota Fiscal+Serie+Cliente+Loja','Nota Fiscal+Serie+Cliente+Loja','Nota Fiscal+Serie+Cliente+Loja','U','','','N'} )
aAdd( aSIX, {'ZC6','1','ZC6_FILIAL+ZC6_NUM+ZC6_ITEM','Numero PV+Item PV','Numero PV+Item PV','Numero PV+Item PV','U','','','S'} )
aAdd( aSIX, {'ZC6','2','ZC6_FILIAL+ZC6_NUM+ZC6_PRODUT','Numero PV+Produto','Numero PV+Produto','Numero PV+Produto','U','','','S'} )
aAdd( aSIX, {'ZC7','1','ZC7_FILIAL+ZC7_PVECOM+ZC7_NUM','Pedido Site+Pedido','Pedido Site+Pedido','Pedido Site+Pedido','U','','','N'} )
aAdd( aSIX, {'ZC7','2','ZC7_FILIAL+ZC7_NUM+ZC7_PVECOM','Pedido+Pedido Site','Pedido+Pedido Site','Pedido+Pedido Site','U','','','N'} )
aAdd( aSIX, {'ZC8','1','ZC8_FILIAL+ZC8_PVECOM+ZC8_PEDIDO+ZC8_PREFIX+ZC8_TITULO+ZC8_PARCEL+ZC8_TIPO','Pedido E-com+Pedido Proth+Prefixo+Titulo+Parcela+Tipo','Pedido E-com+Pedido Proth+Prefixo+Titulo+Parcela+Tipo','Pedido E-com+Pedido Proth+Prefixo+Titulo+Parcela+Tipo','U','','','N'} )
aAdd( aSIX, {'ZC8','2','ZC8_PREFIX+ZC8_TITULO+ZC8_PARCEL+ZC8_TIPO+ZC8_PVECOM+ZC8_PEDIDO','Prefixo+Titulo+Parcela+Tipo+Pedido E-com+Pedido Proth','Prefixo+Titulo+Parcela+Tipo+Pedido E-com+Pedido Proth','Prefixo+Titulo+Parcela+Tipo+Pedido E-com+Pedido Proth','U','','','N'} )
//
// Atualizando dicionário
//
oProcess:SetRegua2( Len( aSIX ) )

dbSelectArea( "SIX" )
SIX->( dbSetOrder( 1 ) )

For nI := 1 To Len( aSIX )

	lAlt    := .F.
	lDelInd := .F.

	If !SIX->( dbSeek( aSIX[nI][1] + aSIX[nI][2] ) )
		cTexto += "Índice criado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] + CRLF
	Else
		lAlt := .T.
		aAdd( aArqUpd, aSIX[nI][1] )
		If !StrTran( Upper( AllTrim( CHAVE )       ), " ", "") == ;
		    StrTran( Upper( AllTrim( aSIX[nI][3] ) ), " ", "" )
			cTexto += "Chave do índice alterado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] + CRLF
			lDelInd := .T. // Se for alteração precisa apagar o indice do banco
		EndIf
	EndIf

	RecLock( "SIX", !lAlt )
	For nJ := 1 To Len( aSIX[nI] )
		If FieldPos( aEstrut[nJ] ) > 0
			FieldPut( FieldPos( aEstrut[nJ] ), aSIX[nI][nJ] )
		EndIf
	Next nJ
	MsUnLock()

	dbCommit()

	If lDelInd
		TcInternal( 60, RetSqlName( aSIX[nI][1] ) + "|" + RetSqlName( aSIX[nI][1] ) + aSIX[nI][2] )
	EndIf

	oProcess:IncRegua2( "Atualizando índices..." )

Next nI

cTexto += CRLF + "Final da Atualização" + " SIX" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX6
Função de processamento da gravação do SX6 - Parâmetros

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX6( cTexto )
Local aEstrut   := {}
Local aSX6      := {}
Local cAlias    := ""
Local cMsg      := ""
Local lContinua := .T.
Local lReclock  := .T.
Local lTodosNao := .F.
Local lTodosSim := .F.
Local nI        := 0
Local nJ        := 0
Local nOpcA     := 0
Local nTamFil   := Len( SX6->X6_FIL )
Local nTamVar   := Len( SX6->X6_VAR )

cTexto  += "Ínicio da Atualização" + " SX6" + CRLF + CRLF

aEstrut := { "X6_FIL"    , "X6_VAR"  , "X6_TIPO"   , "X6_DESCRIC", "X6_DSCSPA" , "X6_DSCENG" , "X6_DESC1"  , "X6_DSCSPA1",;
             "X6_DSCENG1", "X6_DESC2", "X6_DSCSPA2", "X6_DSCENG2", "X6_CONTEUD", "X6_CONTSPA", "X6_CONTENG", "X6_PROPRI" , "X6_PYME" }

aAdd( aSX6, {'  ','DBM_DTFCES','N','Data de Fechamento comissão Canal Regional','Data de Fechamento comissão Canal Regional','Data de Fechamento comissão Canal Regional','','','','','','','10','10','10','U',''} )
aAdd( aSX6, {'  ','DBM_DTFCKA','N','Data de Fechamento comissão Canal Regional','Data de Fechamento comissão Canal Regional','Data de Fechamento comissão Canal Regional','','','','','','','15','15','15','U',''} )
aAdd( aSX6, {'  ','DBM_DTUCA1','C','Data Ultima compra a ser considerado Relatório ind','Data Ultima compra a ser considerado Relatório ind','Data Ultima compra a ser considerado Relatório ind','icadores','icadores','icadores','','','','20110101','20110101','20110101','U',''} )
aAdd( aSX6, {'  ','DBM_ESPACC','C','Grupo Especializado','Grupo Especializado','Grupo Especializado','','','','','','','000002','000002','000001','U',''} )
aAdd( aSX6, {'  ','DBM_ESPGR1','C','Grupo Clientes Especializado','Grupo Clientes Especializado','Grupo Clientes Especializado','','','','','','','000009','000009','000009','U',''} )
aAdd( aSX6, {'  ','DBM_ESPGRP','C','Grupo Clientes Especializado','Grupo Clientes Especializado','Grupo Clientes Especializado','','','','','','','000002','000002','000002','U',''} )
aAdd( aSX6, {'  ','DBM_GRPVI2','C','Grupo de venda interna2','Grupo de venda interna2','Grupo de venda interna2','','','','','','','000007','000007','000007','U',''} )
aAdd( aSX6, {'  ','DBM_GRPVIN','C','Grupo de venda interna','Grupo de venda interna','Grupo de venda interna','','','','','','','000006','000003','000003','U',''} )
aAdd( aSX6, {'  ','DBM_KEYACC','C','Grupo Key Account','Grupo Key Account','Grupo Key Account','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','DBM_LMARK','N','','','','','','','','','','1.0','1.0','1.0','U',''} )
aAdd( aSX6, {'  ','DBM_RCOMNO','N','Percentual comissão Cana Regional','Percentual comissão Cana Regional','Percentual comissão Cana Regional','','','','','','','3','3','3','U',''} )
aAdd( aSX6, {'  ','DBM_RCOMSV','N','Percentual de comissão Canal Regional Super Varejo','Percentual de comissão Canal Regional Super Varejo','Percentual de comissão Canal Regional Super Varejo','','','','','','','1','1','1','U',''} )
aAdd( aSX6, {'  ','DBM_REMAIL','C','E-mails para envio da previa de vendas','E-mails para envio da previa de vendas','E-mails para envio da previa de vendas','','','','','','','previadevendas@ncgames.com.br','previadevendas@ncgames.com.br','previadevendas@ncgames.com.br','U','S'} )
aAdd( aSX6, {'  ','DBM_SUPERV','C','Grupo Clientes SuperVarejo','Grupo Clientes SuperVarejo','Grupo Clientes SuperVarejo','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','DB_COPMAIL','C','Copia oculta de previa de venda','','','','','','','','','cmacedo@ncgames.com.br;dsilva@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','DB_REMAIL1','C','E-mails para envio da previa de vendas 1','','','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','DB_REMAIL2','C','E-mails para envio da previa de vendas 2','','','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','EC_NCG0001','C','TES do Pedido de Venda Site','TES do Pedido de Venda Site','TES do Pedido de Venda Site','','','','','','','578','578','578','U',''} )
aAdd( aSX6, {'  ','EC_NCG0002','C','Status PV que não deve ser importado','Status PV que não deve ser importado','Condicao Status PV que não deve ser importado','','','','','','','96','96','96','U',''} )
aAdd( aSX6, {'  ','EC_NCG0003','C','Operacao Pedido de Venda Site','Operacao do Pedido de Venda Site','Operacao do Pedido de Venda Site','','','','','','','01','01','01','U',''} )
aAdd( aSX6, {'  ','EC_NCG0004','C','Status para cancelamento do PV','Status para cancelamento do PV','Status para cancelamento do PV','','','','','','','96;90','96','96','U',''} )
aAdd( aSX6, {'  ','EC_NCG0005','C','Status para liberação do PV','Status para liberação do PV','Status para liberação do PV','','','','','','','10','10','10','U',''} )
aAdd( aSX6, {'  ','EC_NCG0006','C','E-mail do responsavél do PV Site','E-mail do responsavél do PV Site','E-mail do responsavél do PV Site','','','','','','','cleverson.silva@acpd.com.br;lfelipe@ncgames.com.br;rciambarella@ncgames.com.br;elton_csantana@hotmail.com','cleverson.silva@acpd.com.br','cleverson.silva@acpd.com.br','U',''} )
aAdd( aSX6, {'  ','EC_NCG0007','C','Condicaço de Pagamento E-commerce','Condicaço de Pagamento E-commerce','Condicaço de Pagamento E-commerce','','','','','','','WEB','WEB','WEB','U',''} )
aAdd( aSX6, {'  ','EC_NCG0008','C','E-mail do responsavél WMS do PV Site','E-mail do responsavél WMS do PV Site','E-mail do responsavél WMS do PV Site','','','','','','','cleverson.silva@acpd.com.br;lfelipe@ncgames.com.br;rciambarella@ncgames.com.br;elton_csantana@hotmail.com','cleverson.silva@acpd.com.br','cleverson.silva@acpd.com.br','U',''} )
aAdd( aSX6, {'  ','EC_NCG0009','C','Usuario Adm. produtos E-commerce','','','','','','','','','000307;000086','000307;000086','000307;000086','U',''} )
aAdd( aSX6, {'  ','EC_NCG0010','C','Usuário com acesso a Integração(WS)','Usuário com acesso a Integração(WS)','Usuário com acesso a Integração(WS)','','','','','','','wsncgames','wsncgames','wsncgames','U',''} )
aAdd( aSX6, {'  ','EC_NCG0011','C','Senha do Usuário com acesso a Integração(WS)','Senha do Usuário com acesso a Integração(WS)','Senha do Usuário com acesso a Integração(WS)','','','','','','','apeei.1453','apeei.1453','apeei.1453','U',''} )
aAdd( aSX6, {'  ','EC_NCG0012','N','Numeros de dias de antecedencia para envio de WF d','Numeros de dias de antecedencia para envio de WF d','Numeros de dias de antecedencia para envio de WF d','e expiração data de entrega','e expiração data de entrega','e expiração data de entrega','','','','2','2','2','U',''} )
aAdd( aSX6, {'  ','EC_NCG0013','C','Codigos Transportadora','Codigos Transportadora','Codigos Transportadora','','','','','','','864','864','864','U',''} )
aAdd( aSX6, {'  ','HD_ACCOUNT','C','Usuário da conta recebimento do e-mail do Helpdesk','Usuário da conta do e-mail do Helpdesk','Usuário da conta do e-mail do Helpdesk','','','','','','','ncgames\helpdesk','helpdesk','helpdesk','U',''} )
aAdd( aSX6, {'  ','HD_ACCPSW','C','Senha de autenticação recebimento do e-mail do Hel','Senha de autenticação do e-mail do Helpdesk','Senha de autenticação do e-mail do Helpdesk','pdesk','','','','','','O_chamado','O_chamado','O_chamado','U',''} )
aAdd( aSX6, {'  ','HD_DIRANX','C','Diretório dos arquivos anexos do HD','Diretório dos arquivos anexos do HD','Diretório dos arquivos anexos do HD','','','','','','','\HELPDESK\Anexos\','\HELPDESK\Anexos\','\HELPDESK\Anexos\','U',''} )
aAdd( aSX6, {'  ','HD_DIRCHM','C','Diretório dos arquivos de chamados do HD','Diretório dos arquivos de chamados do HD','Diretório dos arquivos de chamados do HD','','','','','','','\HelpDesk\Chamados\','\HelpDesk\Chamados\','\HelpDesk\Chamados\','U',''} )
aAdd( aSX6, {'  ','HD_DIRTMP','C','Diretório dos arquivos temporários do HD','Diretório dos arquivos temporários do HD','Diretório dos arquivos temporários do HD','','','','','','','\HELPDESK\temp\','\HELPDESK\temp\','\HELPDESK\temp\','U',''} )
aAdd( aSX6, {'  ','HD_ENVPSW','C','Senha de autenticação SMTP do e-mail do HD','Senha de autenticação SMTP do e-mail do HD','Senha de autenticação SMTP do e-mail do HD','','','','','','','W.2ncgames','W.2ncgames','W.2ncgames','U',''} )
aAdd( aSX6, {'  ','HD_POPSERV','C','Servidor Pop do HelpDesk','Servidor Pop do HelpDesk','Servidor Pop do HelpDesk','','','','','','','ncmail.ncgames.local','ncsrvsbs','ncsrvsbs','U',''} )
aAdd( aSX6, {'  ','HD_RELACNT','C','Conta a ser utilizada no envio de E-Mail do HD','Conta a ser utilizada no envio de E-Mail do HD','Conta a ser utilizada no envio de E-Mail do HD','','','','','','','workflow@ncgames.com.br','workflow@ncgames.com.br','workflow@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','HD_SMTPSRV','C','Servidor SMTP do HD','Servidor SMTP do HD','Servidor SMTP do HD','','','','','','','ncmail','ncsrvsbs','ncsrvsbs','U',''} )
aAdd( aSX6, {'  ','KZ_ALTENV','C','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','os arquivos de alteração pela Neogrid.','os arquivos de alteração pela Neogrid.','os arquivos de alteração pela Neogrid.','','','','\ncgames\receipt','\ncgames\receipt','\ncgames\receipt','U',''} )
aAdd( aSX6, {'  ','KZ_ALTPROC','C','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','os arquivos Alteração processados pelo sistema','os arquivos Alteração processados pelo sistema','os arquivos Alteração processados pelo sistema','','','','\ncgames\dispatch\esc','\ncgames\dispatch\esc','\ncgames\dispatch\esc','U',''} )
aAdd( aSX6, {'  ','KZ_EDIENV','C','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','os arquivos enviados pela Neogrid.','os arquivos enviados pela Neogrid.','os arquivos enviados pela Neogrid.','','','','\ncgames\receipt','\ncgames\receipt','\ncgames\receipt','U',''} )
aAdd( aSX6, {'  ','KZ_EDIPROC','C','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','Informe o caminho onde será disponibilizado','os arquivos EDI processados pelo sistema','os arquivos EDI processados pelo sistema','os arquivos EDI processados pelo sistema','','','','\ncgames\dispatch\esc','\ncgames\dispatch\esc','\ncgames\dispatch\esc','U',''} )
aAdd( aSX6, {'  ','KZ_EXCALT','C','INFORMAR OS CAMPOS QUE TERÃO EXCEÇÃO DE ALTERAÇÃO','','','NA TELA DE PEDIDO EDI, CAMPOS DOS ITENS','','','','','','ZAF_UM;ZAF_UNID2;ZAF_LOCAL;ZAF_DTENT;ZAF_QTD;ZAF_QTD2;ZAF_PRCUNI','ZAF_UM;ZAF_UNID2;ZAF_LOCAL;ZAF_DTENT;ZAF_QTD;ZAF_QTD2','ZAF_UM;ZAF_UNID2;ZAF_LOCAL;ZAF_DTENT;ZAF_QTD;ZAF_QTD2','U',''} )
aAdd( aSX6, {'  ','KZ_EXCCAB','C','INFORMAR OS CAMPOS QUE TERÃO EXCEÇÃODE ALTERAÇÃO N','','','A TELA DO PEDIDO EDI, CAMPOS DO CABECALHO','','','','','','ZAE_TRANSP;ZAE_OBSNF','ZAE_TRANSP;ZAE_OBSNF','ZAE_TRANSP;ZAE_OBSNF','U',''} )
aAdd( aSX6, {'  ','KZ_INVFLD','C','Diretorio de gravacao das Invoices','Diretorio de gravacao das Invoices','Diretorio de gravacao das Invoices','','','','','','','\ncgames\dispatch','\ncgames\dispatch','\ncgames\dispatch','U',''} )
aAdd( aSX6, {'  ','KZ_MAILRES','C','Endereço de E-mail dos Responsaveis da area','Endereço de E-mail dos Responsaveis da area','Endereço de E-mail dos Responsaveis da area','Separados por ";" (ponto e vírgula)','Separados por ";" (ponto e vírgula)','Separados por ";" (ponto e vírgula)','','','','admvendas@ncgames.com.br','admvendas@ncgames.com.br','admvendas@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','KZ_PARCMIN','N','Parcela mínima','Parcela mínima','Parcela mínima','','','','','','','50','50','50','U',''} )
aAdd( aSX6, {'  ','MV_ALMOX','C','','','','','','','','','','01/02/03/04/05/07/08/11/CV/99/06/98/31/95/XX','01/02/03/04/05/07/08','01/02/03/04/05/07/08','U',''} )
aAdd( aSX6, {'  ','MV_ARMWMAS','C','ARMAAZENS CONTROLADOS PELO SISTEMA STORE WMAS','','','','','','','','','01/02/03/04/05/06/31/32/33/51/98','01/02/03/04/05/06/31/32/33/51/98','01/02/03/06/51','U',''} )
aAdd( aSX6, {'  ','MV_AVG0175','C','Diretorio onde sera criado o arquivo TXT de','Directorio donde se creara el archivo TXT de','Directory in which TXT file of Fiscal','Integração Fiscal.','Integracion Fiscal.','Integration will be created.','','','','','','','U','N'} )
aAdd( aSX6, {'  ','MV_AVG0176','C','Ambiente responsavel por enviar as transacoes','Entorno responsable por enviar las transacciones','Environment that sends transactions','(Ex: Client 100, Client 200 etc)','(Ej: Client 100, Client 200 etc)','(Ex: Client 100, Client 200 etc).','','','','','','','U','N'} )
aAdd( aSX6, {'  ','MV_AVG0186','L','Define se as informações da Proforma virão da','Define si informaciones de Pro forma vendran de la','It defines if Proforma information is from','tabela de proformas ou capa do Purchase Order','tabla de pro formas o portada del Purchase Order','proforma table or Purchase Order cover','','','','.F.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','MV_BLQPROD','C','Parametro que controla o acesso aos produtos','','','bloqueados para venda. Deverão ser incluidos todos','','','os Consultores de vendas.','','','ANUNES/RCOSTA/LGALLI/ROGERIO/CPASSOS/AMOTA/EGARCIA/MPRUDENCIO/IMARTINS/LVASQUES/BSAMPAIO/JGEORGE/MSILVA/JMARQUEZINI/ROLIVEIRA/CMASIERO/ERAMIRO/SUPERTECH/CFONSECA/NAIRES/RCOSTA/RMORAES/ROLIVEIRA','','','U',''} )
aAdd( aSX6, {'  ','MV_CIASHOP','C','Usuário com acesso a Integração(WS)','','','','','','','','','wsncgames','wsncgames','wsncgames','U',''} )
aAdd( aSX6, {'  ','MV_DESCFIN','C','Indica se o desconto financeiro sera aplicado inte','Indica si el descuento financiero se aplicara','It indicates whether the financial deduction is to','gral ("I") no primeiro pagamento, ou proporcional','integral  ("I") en el primer pago o proporcional','be paid fully (F) on the first payment or','("P") ao valor pago en cada parcela.','("P") al valor pagado en cada cuota.','proportional (P) to the amt. paid on each installm','I','I','I','U',''} )
aAdd( aSX6, {'  ','MV_DTAPURA','D','Data da ultima apuracao dos impostos','Data da ultima apuracao dos impostos','Data da ultima apuracao dos impostos','','','','','','','01/08/2009','30/04/2010','30/04/2010','U',''} )
aAdd( aSX6, {'  ','MV_ENVFAT','C','Endereços de E-mail Utilizados na Rotina de Libera','','','ção de Pedidos Para Faturamento','','','','','','elton_csantana@hotmail.com;lfelipe@ncgames.com.br','csantos@ncgames.com.br;jalves@ncgames.com.br; snunes@ncgames.com.br;bcarvalho@ncgames.com.br;rpinheiro@ncgames.com.br','csantos@ncgames.com.br;jalves@ncgames.com.br; snunes@ncgames.com.br;bcarvalho@ncgames.com.br;rpinheiro@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','MV_ENVFAT1','C','Endereços de E-mail Utilizados na Rotina de Libera','','','ção de Pedidos Para Faturamento','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','MV_ESTETIQ','C','LIBERAÇÃO DE ACESSO A ESTORNO DE ETIQUETA DE NOTA','','','FISCAL','','','','','','EBRITO/DOLIVEIRA/LFELIPE/RCIAMBARELLA/SNUNES','','','U',''} )
aAdd( aSX6, {'  ','MV_ESTPICK','C','LIBERAÇÃO DE ESTORNO DE PICK LIST','','','','','','','','','LFELIPE/RCIAMBARELLA/RSOUZA/csantos/SOLIVEIRA/WSILVA/MADRIANO/rpinheiros','','','U',''} )
aAdd( aSX6, {'  ','MV_FINATFN','C','"1" = Fluxo Caixa On-Line,"2" = Fluxo Caixa Off-Li','','','ne','','','','','','1','1','1','U',''} )
aAdd( aSX6, {'  ','MV_IMPSB1','C','','','','','','','','','','BOLIVEIRA','','','U',''} )
aAdd( aSX6, {'  ','MV_INCREM','N','PARAMETRO UTILIZADO PARA INCREMENTAR A NUMERACAO D','','','O CNAB','','','','','','1','1','1','U',''} )
aAdd( aSX6, {'  ','MV_INC_PAG','C','Usuarios com permissao para movimentacao completa','Usuarios com permissao para movimentacao completa','Usuarios com permissao para movimentacao completa','no contas a pagar.','no contas a pagar.','no contas a pagar.','no contas a pagar.','','','rvelame\jalves\rokamoto\lfelipe\marruda\kgabriela\imatos\agoncalves\mlima\tbarros\jisidoro\dbmsystem\eferreira\acruz\esantana','rvelame\jalves\rokamoto\lfelipe\marruda\kgabriela\imatos\agoncalves\mlima\tbarros\jisidoro\dbmsystem\eferreira\acruz\esantana','rvelame\jalves\rokamoto\lfelipe\marruda\kgabriela\imatos\agoncalves\mlima\tbarros\jisidoro\dbmsystem\eferreira\acruz\esantana','U',''} )
aAdd( aSX6, {'  ','MV_INSDIPJ','C','Define o código da retenção do INSS, gerar a DIPJ.','Define el codigo de retenc. del INSS, gerar DIPJ.','Establishes INSS withholding code, gen. DIPJ.','','','','','','','2100','','','U',''} )
aAdd( aSX6, {'  ','MV_ITEMCTA','C','ITEM CONTA PARA O PROJETO PCO','','','','','','','','','1111/1112/1212/1311/1313/1314/1319','','','U',''} )
aAdd( aSX6, {'  ','MV_ITNUM','N','QUANTIDADE DE ITENS PARA IMPRESSÃO DE PICK LIST','','','','','','','','','80','','','U',''} )
aAdd( aSX6, {'  ','MV_LJLVFIS','N','Define se utiliza novo conceito para geracao SF3','Define si utiliza nuevo concepto para generac. SF3','Defines if new concept for SF3 generation is used','1= conceito antigo, 2= conceito novo','1= concepto antiguo, 2= concepto nuevo','1= old concept, 2= new concept','','','','2','','','U',''} )
aAdd( aSX6, {'  ','MV_LJTPDES','C','Tipo de desconto que será aplicado: 0=Default','Tipo de descuento que se aplicará: 0=Default','Tipo de desconto que será aplicado: 0=Default','1=Aplicação do desconto no valor unitário','1= Aplicación de descuento en el valor unitario','1=Aplicação do desconto no valor unitário','2=Cons. Desconto mais de duas casas decimais','2=Cons.Descuento más de dos casas decimales.','2=Cons. Desconto mais de duas casas decimais','1','1','1','U',''} )
aAdd( aSX6, {'  ','MV_MAXITPV','N','Quantidade Maxima','Quantidade Maxima','Quantidade Maxima','','','','','','','120','40','40','U',''} )
aAdd( aSX6, {'  ','MV_MNTTAB','C','Usuários que podem usar rotina de manutenção de','','','tabela de preços via importação do excel','','','','','','LCARVALHO/EBUTTNER/LFELIPE/SOLIVEIRA','EMARIA/RRIBEIRO/WMELO/DSATYRO','EMARIA/RRIBEIRO/WMELO/DSATYRO','U',''} )
aAdd( aSX6, {'  ','MV_MUDATRT','L','Indica se devera alterar o nome físico das tabelas','Indica si se modifica el nombre fisico de tablas','It indicates if physical name of temporary tables','temporarias utilizadas nas SPs T=Alterar F=Não','temporarias utilizadas en las SP T=Modifica F=No','used in SPs must be changed.  T=Change F=Do Not','Alterar','Modificar','Change','.T.','.T.','.T.','U',''} )
aAdd( aSX6, {'  ','MV_NCAPTAB','C','Parâmetro com Código do usuário que poderá','','','aprovar/rejeitar a tabela de preço intermediária','','','','','','000359;000061','000359;000307;000061','000359;000307;000061','U',''} )
aAdd( aSX6, {'  ','MV_NCBANCO','C','Banco * Agencia # Conta Corrente','Banco * Agencia # Conta Corrente','Banco * Agencia # Conta Corrente','','','','','','','237*3390-1#777-3','237*3390-1#777-3','237*3390-1#777-3','U',''} )
aAdd( aSX6, {'  ','MV_NCGAMES','C','Codigos de NCM com incentivo de base reduzida','','Codigos de NCM com incentivo de base reduzida','','Codigos de NCM com incentivo de base reduzida','','','','','0000000','0000000','0000000','U',''} )
aAdd( aSX6, {'  ','MV_NCHALER','N','Horas para avisar o cliente que sua reserva ira','','','Vencer','','','Ex.14','','','24','','','U',''} )
aAdd( aSX6, {'  ','MV_NCHRES','N','Horas que permanecera a reserva do pedido de venda','Horas que permanecera a reserva do pedido de venda','Horas que permanecera a reserva do pedido de venda','Apos essas horas sera excluida a reserva.','Apos essas horas sera excluida a reserva.','Apos essas horas sera excluida a reserva.','Ex. 36','Ex. 36','Ex. 36','48','','','U',''} )
aAdd( aSX6, {'  ','MV_NCRESER','C','Condicoes de pagamento para geracao automatica','Condicoes de pagamento para geracao automatica','Condicoes de pagamento para geracao automatica','de reserva para os itens do pedido de venda.','de reserva para os itens do pedido de venda.','de reserva para os itens do pedido de venda.','Ex.: 027/028/029','Ex.: 027/028/029','Ex.: 027/028/029','027/028/029/618','027/028/029/618','027/028/029/618','U',''} )
aAdd( aSX6, {'  ','MV_NCTABCO','C','Tabela de Preço consumidor','','','','','','','','','CON','CON','CON','U',''} )
aAdd( aSX6, {'  ','MV_NCTABPR','C','Tabelas a serem utilizadas para Preços','','','','','','','','','018;004;318;304;418;404;518;504;007;012;013','018;012;007;318;312;307;407;412;418;507;512;518;013','018;004;318;304;418;404;518;504;007;012','U',''} )
aAdd( aSX6, {'  ','MV_NCUSRLB','C','Usuarios permitidos para liberacao de itens de ped','Usuarios permitidos para liberacao de itens de ped','Usuarios permitidos para liberacao de itens de ped','ido de venda que ultrapassam o lvr. de desconto es','ido de venda que ultrapassam o lvr. de desconto es','ido de venda que ultrapassam o lvr. de desconto es','pecificado no grupo de produtos ou cadastro de cli','pecificado no grupo de produtos ou cadastro de cli','pecificado no grupo de produtos ou cadastro de cli','CMACEDO/RCIAMBARELLA/LFELIPE/ISENA/dbmsystem/PSILVA/KSILVA/AGOMES/KSALHA/JISIDORO/FMARINHO/PALVES','CMACEDO/RCIAMBARELLA/LFELIPE/ISENA/dbmsystem/PSILVA/KSILVA/AGOMES\ksalha\jisidoro','CMACEDO/RCIAMBARELLA/LFELIPE/ISENA/dbmsystem/PSILVA/KSILVA/AGOMES\ksalha\jisidoro','U',''} )
aAdd( aSX6, {'  ','MV_NCVLRSC','N','Valor total para solicitacoes de compras que nao','','','serao Bloqueadas','','','','','','1500.00','','','U',''} )
aAdd( aSX6, {'  ','MV_NFECAEV','L','Ativar Cancelamento de NF-e como Evento:','','','T = Sim ou F = Não.','','','','','','T','','','U',''} )
aAdd( aSX6, {'  ','MV_PROCSP','L','Indica se a manutenção de stored procedures será','','','realizada por processo (.T. = Sim / .F. = Não)','','','','','','.T.','.T.','.T.','U',''} )
aAdd( aSX6, {'  ','MV_PRODES1','C','Produto Exceção','Produto Exceção','Produto Exceção','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','MV_PRODESP','C','Produtos que serao tratados como excecao no calc.','Produtos que serao tratados como excecao no calc.','Produtos que serao tratados como excecao no calc.','de margem liquida(mesmo sem estoque)','de margem liquida(mesmo sem estoque)','de margem liquida(mesmo sem estoque)','','','','0226180118801;0226180118901;0226180119001;0226180119101;0226180119201;0226180119301;0226180120301;0226180120401;0226180119401;0226180119501;0226180119601;0226180119701;0226180119801;0226180119901;0226180120001;0226180120101;0226180120201','','','U',''} )
aAdd( aSX6, {'  ','MV_PZREZER','N','Prazo padrao de validade das reservas (em dias).','','','','','','','','','1','','','U',''} )
aAdd( aSX6, {'  ','MV_REGSOC0','C','','','','','','','','','','{"105","02","28695011100","MADALENA COSTA MACEDO","SOCIO PESSOA FISICA DOMICILIADO NO BRASIL","1"}','','','U',''} )
aAdd( aSX6, {'  ','MV_TESALT','C','USUARIOS AUTORIZADOS PARA ALTERACAO DA TES NO PEDI','','','DO DE VENDAS','','','','','','EBUTTNER\RCIAMBARELLA\ROKAMOTO\IMATOS\BCOSTA\JALVES\lfelipe\gsilva','EBUTTNER\RCIAMBARELLA\RSOUZA\ROLIVEIRA\CMASIERO\ROGERIO\VCOSTA\EMARIA\RNEIDE\LPORTO\SMASSI\RBALDUINO\CCAMPOS\IMATOS\gsilva','EBUTTNER\RCIAMBARELLA\RSOUZA\ROLIVEIRA\CMASIERO\ROGERIO\VCOSTA\EMARIA\RNEIDE\LPORTO\SMASSI\RBALDUINO\CCAMPOS\IMATOS\gsilva','U',''} )
aAdd( aSX6, {'  ','MV_ULDTDEV','D','parametro com a data do fechamento da devolução','','','','','','','','','28/06/13','','','U',''} )
aAdd( aSX6, {'  ','MV_ULUSDEV','C','usuarios autorizados a realizar o fechamento de de','','','volução','','','','','','LFELIPE/PSILVA/RSOUZA','','','U',''} )
aAdd( aSX6, {'  ','MV_USMOTDE','C','usuarios autorizados a realizar manutenção do moti','','','vos de devolução','','','','','','RSOUZA/LFELIPE/JALVES/BCOSTA/ISENA/NSILVA/PSILVA/KSILVA','','','U',''} )
aAdd( aSX6, {'  ','MV_USRFRIS','C','Nome dos usuarios que podem isentar o frete no','','','PEDIDO DE VENDA.','','','','','','000000/000114/000245/000129/000307/000352/000356/000125/000264/000399/000182','000000/000114/000245/000129/000307/000352/000356/000125/000264/000399/000182','000000/000114/000245/000129/000307/000352/000356/000125/000264/000399/000182','U',''} )
aAdd( aSX6, {'  ','MV_USRFRTN','C','NOME DOS USUARIOS QUE PODEM ALTERAR O VALOR','','','DO FRETE NO PEDIDO DE VENDA.','','','','','','000000/000114/000245/000129/000307/000352/000356/000125/000264/000399/000182','000000/000114/000245/000129/000307/000352/000356/000125/000264/000399/000182','000000/000114/000245/000129/000307/000352/000356/000125/000264/000399/000182','U',''} )
aAdd( aSX6, {'  ','MV_UTMODAL','C','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','Usuários com acesso ao Tem Modal SA1','FAFONSO;DOLIVEIRA;MSOARES;EBRITO;KSALHA;LFELIPE','FAFONSO;DOLIVEIRA;MSOARES;EBRITO;KSALHA;LFELIPE','FAFONSO;DOLIVEIRA;MSOARES;EBRITO;KSALHA;LFELIPE','U',''} )
aAdd( aSX6, {'  ','MV_VLMAXFR','N','PEDIDOS COM VALOR TOTAL SUPERIOR AO PARAMETRO','','','ESTARA ISENTO DE FRETE.','','','','','','5000.00','','','U',''} )
aAdd( aSX6, {'  ','MV_VLMAXPV','N','Valor Maximo','Valor Maximo','Valor Maximo','','','','','','','400000','80000','80000','U',''} )
aAdd( aSX6, {'  ','MV_VLRMAX','N','VALOR MAXIMO PARA QUEBRA DE PICKLIST','','','','','','','','','400000','','','U',''} )
aAdd( aSX6, {'  ','MV_WFWMSFR','C','E-mail de usr que recebem avisos do fretes','E-mail de usr que recebem avisos do fretes','E-mail de usr que recebem avisos do fretes','','','','','','','fafonso@ncgames.com.br;jisidoro@ncgames.com.br','fafonso@ncgames.com.br;jisidoro@ncgames.com.br','fafonso@ncgames.com.br;jisidoro@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','MV_X_CBARR','N','Numero identificador (codigo de barras) referente','','','a numeracao que esta sendo gerada para os pacotes.','','','','','','590966','590966','590966','U',''} )
aAdd( aSX6, {'  ','MV_X_PPESO','N','Percentual que sera acrescentado como sendo uma','','','forma de nao haver erros com relacao a perdas com','','','peso dos produtos.','','','30','','','U',''} )
aAdd( aSX6, {'  ','MV_X_TES','C','TES utilizadas na venda para validar o desconto','','','Especifico NC Games','','','','','','503/505/549/586','','','U',''} )
aAdd( aSX6, {'  ','NCG_000000','L','Define se utilizará a UF destino para a emissão do','','','conhecimento de fretes. (.T. = Sim ou .F. = Não ut','','','iliza). Programa u_FFRTSISF1','','','.F.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','NCG_000001','C','Define o e-mail para envio de erros ocorridos nas','Define o e-mail para envio de erros ocorridos nas','Define o e-mail para envio de erros ocorridos nas','customizações do ERP Protheus.','customizações do ERP Protheus.','customizações do ERP Protheus.','','','','helpdesk@ncgames.com.br;','','','U',''} )
aAdd( aSX6, {'  ','NCG_000002','C','Define o e-mail em cópia para envio de erros ocorr','Define o e-mail em cópia para envio de erros ocorr','Define o e-mail em cópia para envio de erros ocorr','idos nas customizações do ERP Protheus.','idos nas customizações do ERP Protheus.','idos nas customizações do ERP Protheus.','','','','rciambarella@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NCG_000003','C','Usuário do Banco de Dados Para Transferência De Da','Usuário do Banco de Dados Para Transferência De Da','Usuário do Banco de Dados Para Transferência De Da','dos (Catálogo de Produto)','dos (Catálogo de Produto)','dos (Catálogo de Produto)','','','','PORTAL','','','U',''} )
aAdd( aSX6, {'  ','NCG_000004','C','Define o diretório para gravação dos logs de erro','Define o diretório para gravação dos logs de erro','Define o diretório para gravação dos logs de erro','das rotinas customizadas.','das rotinas customizadas.','das rotinas customizadas.','','','','NCGAMESLOG','','','U',''} )
aAdd( aSX6, {'  ','NCG_000005','C',"Portas dos TopConnect's para conexão no servidor C","Portas dos TopConnect's para conexão no servidor C","Portas dos TopConnect's para conexão no servidor C",'atálogo de Produtos','atálogo de Produtos','atálogo de Produtos','','','','','','','U',''} )
aAdd( aSX6, {'  ','NCG_000006','C','Tipo Banco De Dados Para Transferência De Dados (C','Tipo Banco De Dados Para Transferência De Dados (C','Tipo Banco De Dados Para Transferência De Dados (C','atálogo de Produto)','atálogo de Produto)','atálogo de Produto)','','','','ORACLE','','','U',''} )
aAdd( aSX6, {'  ','NCG_000007','C','Nome do banco de dados para transferencia de dados','Nome do banco de dados para transferencia de dados','Nome do banco de dados para transferencia de dados','(Catálogo de Produto)','(Catálogo de Produto)','(Catálogo de Produto)','','','','PORTAL','','','U',''} )
aAdd( aSX6, {'  ','NCG_000008','C','Servidor do top connect para transferência de dado','Servidor do top connect para transferência de dado','Servidor do top connect para transferência de dado','s (Catálogo de Produto)','s (Catálogo de Produto)','s (Catálogo de Produto)','','','','187.84.224.9','','','U',''} )
aAdd( aSX6, {'  ','NCG_000009','N','Porta do top connect para transferencia de dados (','Porta do top connect para transferencia de dados (','Porta do top connect para transferencia de dados (','Catálogo de Produto)','Catálogo de Produto)','Catálogo de Produto)','','','','7890','0','0','U',''} )
aAdd( aSX6, {'  ','NCG_000010','N','Quantidade de tentativas que as rotinas de integra','Quantidade de tentativas que as rotinas de integra','Quantidade de tentativas que as rotinas de integra','ção Protheus X Catálogo de Produtos executarão em','ção Protheus X Catálogo de Produtos executarão em','ção Protheus X Catálogo de Produtos executarão em','casos em que não for possivel a conexao com o TopC','casos em que não for possivel a conexao com o TopC','casos em que não for possivel a conexao com o TopC','0','0','0','U',''} )
aAdd( aSX6, {'  ','NCG_000011','L','Define se aguardará a execução das demais instânci','Define se aguardará a execução das demais instânci','Define se aguardará a execução das demais instânci','as no controle de semáforo das rotinas de exportaç','as no controle de semáforo das rotinas de exportaç','as no controle de semáforo das rotinas de exportaç','ão e importação de dados','ão e importação de dados','ão e importação de dados','.F.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','NCG_000012','N','Define a quantidade de tentativas de execução no c','Define a quantidade de tentativas de execução no c','Define a quantidade de tentativas de execução no c','ontrole de semafóro das rotinas de exportação e im','ontrole de semafóro das rotinas de exportação e im','ontrole de semafóro das rotinas de exportação e im','portação de dados','portação de dados','portação de dados','0','0','0','U',''} )
aAdd( aSX6, {'  ','NCG_000013','L','Define se envia ou não e-mail ao administrador qua','Define se envia ou não e-mail ao administrador qua','Define se envia ou não e-mail ao administrador qua','ndo a rotina entrar no semaforo vermelho','ndo a rotina entrar no semaforo vermelho','ndo a rotina entrar no semaforo vermelho','','','','.T.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','NCG_000014','C','IDENTIFICA QUAIS TIPOS DE OPERAÇÃO DEVEM SER CONSI','','','DERADOS NOS TRATAMENTOS','','','','','','01#03','','','U',''} )
aAdd( aSX6, {'  ','NCG_000015','L','','','','','','','','','','.T.','','','U',''} )
aAdd( aSX6, {'  ','NCG_000016','C','Prefixo para relacionamento do NCC com o VPC.','Prefixo para relacionamento do NCC com o VPC.','Prefixo para relacionamento do NCC com o VPC.','','','','','','','VPC','VPC','VPC','U',''} )
aAdd( aSX6, {'  ','NCG_000017','C','Prefixo para relacionamento do Titulo a pagar com','Prefixo para relacionamento do Titulo a pagar com','Prefixo para relacionamento do Titulo a pagar com','a Verba.','a Verba.','a Verba.','','','','VER','VER','VER','U',''} )
aAdd( aSX6, {'  ','NCG_000018','C','Tipo de título a considerar para o relacionamento','Tipo de título a considerar para o relacionamento','Tipo de título a considerar para o relacionamento','com VPC.','com VPC.','com VPC.','','','','NCC','NCC','NCC','U',''} )
aAdd( aSX6, {'  ','NCG_000019','C','Usuário para acessar a base do WMS','Usuário para acessar a base do WMS','Usuário para acessar a base do WMS','','','','','','','WMS','','','U',''} )
aAdd( aSX6, {'  ','NCG_000020','C','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -',"Endereço interno (a clausula 'http://' é necessár","Endereço interno (a clausula 'http://' é necessár","Endereço interno (a clausula 'http://' é necessár",'ia )','ia )','ia )','http://192.168.0.200:8092','','','U',''} )
aAdd( aSX6, {'  ','NCG_000021','C','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -',"Endereço externo (a clausula 'http://' é necessár","Endereço externo (a clausula 'http://' é necessár","Endereço externo (a clausula 'http://' é necessár",'ia )','ia )','ia )','http://186.215.160.178:8092','http://186.215.160.178:8092','http://186.215.160.178:8092','U',''} )
aAdd( aSX6, {'  ','NCG_000022','C','Diretorio dos Html do Workflow','Diretorio dos Html do Workflow','Diretorio dos Html do Workflow','','','','','','','\workflow\','\workflow\','\workflow\','U',''} )
aAdd( aSX6, {'  ','NCG_000023','C','Endereço dos arquivos de workflow para acesso via','Endereço dos arquivos de workflow para acesso via','Endereço dos arquivos de workflow para acesso via','browser do Protheus (não incluir a pasta com o cód','browser do Protheus (não incluir a pasta com o cód','browser do Protheus (não incluir a pasta com o cód','igo da empresa, pois a rotina preencherá automatic','igo da empresa, pois a rotina preencherá automatic','igo da empresa, pois a rotina preencherá automatic','/messenger/emp','/messenger/emp','/messenger/emp','U',''} )
aAdd( aSX6, {'  ','NCG_000024','C','Nome do arquivo de imagem do logo da NC GAMES que','Nome do arquivo de imagem do logo da NC GAMES que','Nome do arquivo de imagem do logo da NC GAMES que','será impresso no relatório de Price Protection','será impresso no relatório de Price Protection','será impresso no relatório de Price Protection','','','','','','','U',''} )
aAdd( aSX6, {'  ','NCG_000025','C','Codigo do usuário do protheus que será o Aprovador','Codigo do usuário do protheus que será o Aprovador','Codigo do usuário do protheus que será o Aprovador','1 - Cadastro de Contrato VPC / VERBA','1 - Cadastro de Contrato VPC / VERBA','1 - Cadastro de Contrato VPC / VERBA','','','','000307;000086;000274;000082;000369','000307;000086;000274;000082;000369','000307;000086;000274;000082;000369','U',''} )
aAdd( aSX6, {'  ','NCG_000026','C','Codigo do usuário do protheus que será o Aprovador','Codigo do usuário do protheus que será o Aprovador','Codigo do usuário do protheus que será o Aprovador','2 - Cadastro de Contrato VPC / VERBA','2 - Cadastro de Contrato VPC / VERBA','2 - Cadastro de Contrato VPC / VERBA','','','','000307;000086;000267','000307;000086;000267','000307;000086;000267','U',''} )
aAdd( aSX6, {'  ','NCG_000027','C','Codigo do usuário do protheus que será o Aprovador','Codigo do usuário do protheus que será o Aprovador','Codigo do usuário do protheus que será o Aprovador','3 - Cadastro de Contrato VPC / VERBA','3 - Cadastro de Contrato VPC / VERBA','3 - Cadastro de Contrato VPC / VERBA','','','','000307;000086;000189','000307;000086;000189','000307;000086;000189','U',''} )
aAdd( aSX6, {'  ','NCG_000028','D','Data do Ultimo fechamento de Apuração','Data do Ultimo fechamento de Apuração','Data do Ultimo fechamento de Apuração','','','','','','','20130605','20130605','20130605','U',''} )
aAdd( aSX6, {'  ','NCG_000030','C','Filiais aceitas na integração do WMS,','Filiais aceitas na integração do WMS,','Filiais aceitas na integração do WMS,','separadas por |','separadas por |','separadas por |','','','','03','03','03','U',''} )
aAdd( aSX6, {'  ','NCG_000031','C','Diretório base visao de pedidos','Diretório base visao de pedidos','Diretório base visao de pedidos','','','','','','','XLSNC\','\\192.168.0.210\Company\Áreas Comuns\Adm Planilha BD\Acompanhamento de Pedidos\Base de Dados','\\192.168.0.210\Company\Áreas Comuns\Adm Planilha BD\Acompanhamento de Pedidos\Base de Dados','U',''} )
aAdd( aSX6, {'  ','NCG_000032','C','Diretório base do usuario da visao de pedidos','Diretório base visao de pedidos','Diretório base visao de pedidos','','','','','','','C:\relatorios adm','C:\relatorios adm','C:\relatorios adm','U',''} )
aAdd( aSX6, {'  ','NCG_000033','C','Usuário para acessar a base de dados do Fretes','Usuário para acessar a base de dados do Fretes','Usuário para acessar a base de dados do Fretes','','','','','','','FRETES','FRETES','FRETES','U',''} )
aAdd( aSX6, {'  ','NCG_000034','C','Produto padrão para inclusão de NF Entrada','','','a partir do fretes','','','','','','080440730101','','','U',''} )
aAdd( aSX6, {'  ','NCG_000035','C','Produto padrão de Pedagio para inclusão de NF','','','Entrada a partir do fretes','','','','','','080440730101','','','U',''} )
aAdd( aSX6, {'  ','NCG_000036','C','CFOPs que devem ser considerados nas devoluções','','','','','','','','','1202*2202*1411*2411','1202*2202*1411*2411','1202*2202*1411*2411','U',''} )
aAdd( aSX6, {'  ','NCG_000037','N','Percentual para cálculo de margem de contribuiçao.','Percentual para cálculo de margem de contribuiçao.','Percentual para cálculo de margem de contribuiçao.','','','','','','','0.2725','0.2725','0.2725','U',''} )
aAdd( aSX6, {'  ','NCG_000038','C','Inicial de produto que deve ser considerados na pl','Inicial de produto que deve ser considerados na pl','Inicial de produto que deve ser considerados na pl','anilha SOP.','anilha SOP.','anilha SOP.','','','','01*02*03*04*05*CP','01*02*03*04*05*CP','01*02*03*04*05*CP','U',''} )
aAdd( aSX6, {'  ','NCG_000039','C','Usuário que pode alterar Budget do S&OP.','Usuário que pode alterar Budget do S&OP.','Usuário que pode alterar Budget do S&OP.','','','','','','','000108','000108','000108','U',''} )
aAdd( aSX6, {'  ','NCG_000040','C','Canal especial para liberacao de margem','Canal especial para liberacao de margem','Canal especial para liberacao de margem','dos produtos do Parm. MV_PRODESP','dos produtos do Parm. MV_PRODESP','dos produtos do Parm. MV_PRODESP','','','','999998','','','U',''} )
aAdd( aSX6, {'  ','NCG_000042','C','NCM de produtos que não deverão','','','sair na tabela de preço.','','','','','','99999999','85171231;84713019;99999999','85171231;84713019;99999999','U',''} )
aAdd( aSX6, {'  ','NCG_000043','C','NCM de produtos que deverão aparecer com o','','','IPI zerado na tabela de preço automatica.','','','','','','85234990','','','U',''} )
aAdd( aSX6, {'  ','NCG_000044','C','Local onde será salvo o Arquivo.CSV para','','','Importar para Site','','','','','','\XLSNC\','\XLSNC\','\XLSNC\','U',''} )
aAdd( aSX6, {'  ','NCG_000045','C','Email dos contatos do financeiro que ira receber o','','','email de venda a vista','','','','','','jbrito@ncgames.com.br;halves@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NCG_000046','N','Percentual que o frete de transferencia será calcu','','','lado no pedido','','','','','','1.0','','','U',''} )
aAdd( aSX6, {'  ','NCG_000047','N','Percentual de Seguro para transferencia entre','','','Filiais','','','','','','0.5','','','U',''} )
aAdd( aSX6, {'  ','NCG_000048','C','Canal de excessão 2','','','','','','','','','999997','','','U',''} )
aAdd( aSX6, {'  ','NCG_000050','C','Produto Excecao Adicional ao NCG_000049','','','','','','','','','0321240112501;0321240112601;0321240112701;0321240112801;0321240112901','','','U',''} )
aAdd( aSX6, {'  ','NCG_000051','C','Produto Exceção','Produto Exceção','Produto Exceção','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','NCG_000052','N','Valor maximo para alteração no Mrg','Valor maximo para alteracao no Mrg','Valor maximo para alteracao no Mrg','','','','','','','1','','','U',''} )
aAdd( aSX6, {'  ','NCG_000053','C','FABRICANTE FORNECEDOR MICROSOFT','','','','','','','','','002089','002089','002089','U',''} )
aAdd( aSX6, {'  ','NCG_000054','C','Email Workflow Previa','Email Workflow Previa','Email Workflow Previa','','','','','','','000307;000086','000307;000086','000307;000086','U',''} )
aAdd( aSX6, {'  ','NCG_000057','C','Email de Adm. Site','','','','','','','','','lfelipe@ncgames.com.br','lfelipe@ncgames.com','lfelipe@ncgames.com','U',''} )
aAdd( aSX6, {'  ','NCG_000107','C','Status que nao permite liberacao','','','','','','','','','00*05*20*35*40','00*05*20*35*40','00*05*20*35*40','U',''} )
aAdd( aSX6, {'  ','NCG_000108','C','Status que nao permite envio','','','','','','','','','05*20*35*40','05*20*35*40','05*20*35*40','U',''} )
aAdd( aSX6, {'  ','NCG_000700','C','Usuarios com direito a Filtro na Aprovação da Marg','Usuarios com direito a Filtro na Aprovação da Marg','Usuarios com direito a Filtro na Aprovação da Marg','em','em','em','','','','rciambarella*dbmsystem*ksilva*isena*apaula*psilva*asalete*agomes','rciambarella*dbmsystem*ksilva*isena*apaula*psilva*asalete*agomes','rciambarella*dbmsystem*ksilva*isena*apaula*psilva*asalete*agomes','U',''} )
aAdd( aSX6, {'  ','NCG_100000','C','Gerar Pedido de Transferencia na Matriz','Gerar Pedido de Transferencia na Matriz','Gerar Pedido de Transferencia na Matriz','','','','','','','S','S','S','U',''} )
aAdd( aSX6, {'  ','NCG_100001','C','Filiais que devem gerar Pedido de Transferencia','Filiais que devem gerar Pedido de Transferencia','Filiais que devem gerar Pedido de Transferencia','','','','','','','05','04;05','04;05','U',''} )
aAdd( aSX6, {'  ','NCG_100002','C','Filiais que realizam o tratamento de mídia e softw','Filiais que realizam o tratamento de mídia e softw','Filiais que realizam o tratamento de mídia e softw','are','are','are','','','','05','05','05','U',''} )
aAdd( aSX6, {'  ','NCG_100003','C','Filial Destino PV Transferencia','Filial Destino PV Transferencia','Filial Destino PV Transferencia','','','','','','','03','03','03','U',''} )
aAdd( aSX6, {'  ','NCG_100004','C','TES do Pedido de Transferencia','TES do Pedido de Transferencia','TES do Pedido de Transferencia','','','','','','','546','998','998','U',''} )
aAdd( aSX6, {'  ','NCG_100005','N','Preço da mídia (se for maior que 0 será o valor do','Preço da mídia (se for maior que 0 será o valor do','Preço da mídia (se for maior que 0 será o valor do','parâmetro. Se igual a 0 será o valor do preço na','parâmetro. Se igual a 0 será o valor do preço na','parâmetro. Se igual a 0 será o valor do preço na','tabela de preços)','tabela de preços)','tabela de preços)','4.8','6','6','U',''} )
aAdd( aSX6, {'  ','NCG_100006','C','Cliente do Pedido de Transferencia','Cliente do Pedido de Transferencia','Cliente do Pedido de Transferencia','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','NCG_100007','C','Loja do Cliente do Pedido de Transferencia','Loja do Cliente do Pedido de Transferencia','Loja do Cliente do Pedido de Transferencia','','','','','','','28','04','04','U',''} )
aAdd( aSX6, {'  ','NCG_100008','C','Condicao de pagamento do Pedido de Transferencia','Condicao de pagamento do Pedido de Transferencia','Condicao de pagamento do Pedido de Transferencia','','','','','','','175','175','175','U',''} )
aAdd( aSX6, {'  ','NCG_100009','C','TES do Software no Pedido de Transferencia','TES do Software no Pedido de Transferencia','TES do Software no Pedido de Transferencia','','','','','','','572','997','997','U',''} )
aAdd( aSX6, {'  ','NCG_100010','C','Código da transportadora padrão para o pedido de t','Código da transportadora padrão para o pedido de t','Código da transportadora padrão para o pedido de t','ransferência','ransferência','ransferência','','','','000034','000034','000034','U',''} )
aAdd( aSX6, {'  ','NCG_100011','C','Natureza para ser utilizada na inclusão do título','Natureza para ser utilizada na inclusão do título','Natureza para ser utilizada na inclusão do título','a pagar da fatura do frete','a pagar da fatura do frete','a pagar da fatura do frete','','','','12101','234','234','U',''} )
aAdd( aSX6, {'  ','NCG_NCMCEL','C','NCM de Celular','NCM de Celular','NCM de Celular','','','','','','','84713019*85171231','84713019*85171231','84713019*85171231','U',''} )
aAdd( aSX6, {'  ','NCG_PR7030','D','Prj inadimplencia - Data de inicio de envio de','','','cobranças','','','','','','01/06/13','','','U',''} )
aAdd( aSX6, {'  ','NCG_PR7031','C','Prj inadimplencia - email de contato do financeiro','','','que ira aparecer no email do workflow','','','','','','cobranca@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NCG_PR7034','C','Prj inadimplencia - Codigos de portador que','','','não irão receber o Workflow','','','','','','928;937;936;929;996;914;998','928;937;936;929;996;914;998','928;937;936;929;996;914;998','U',''} )
aAdd( aSX6, {'  ','NCG_PR705A','N','Numero de dias do vencimento do contrato','Numero de dias do vencimento do contrato','Numero de dias do vencimento do contrato','','','','','','','5','5','5','U',''} )
aAdd( aSX6, {'  ','NCG_PR705E','C','E-mail do responsavel pelos contratos VPC','E-mail do responsavel pelos contratos VPC','E-mail do responsavel pelos contratos VPC','','','','','','','lfelipe@ncgames.com.br','lfelipe@ncgames.com.br','lfelipe@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','NCG_PR708A','L','Agrega Verba Extra - NCC Periodica','Agrega Verba Extra - NCC Periodica','Agrega Verba Extra - NCC Periodica','','','','','','','.F.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','NCG_PR7091','C','Natureza da NCC VPC','Natureza da NCC VPC','Natureza da NCC VPC','','','','','','','253','253','253','U',''} )
aAdd( aSX6, {'  ','NCG_PR7101','C','Natureza da Verba Extra','Natureza da Verba Extra','Natureza da Verba Extra','','','','','','','259','259','259','U',''} )
aAdd( aSX6, {'  ','NCG_PR7102','C','Prefixo Verba Extra','Prefixo Verba Extra','Prefixo Verba Extra','','','','','','','VER','VER','VER','U',''} )
aAdd( aSX6, {'  ','NCG_PR7103','C','Tipo Verba Extra','Tipo Verba Extra','Tipo Verba Extra','','','','','','','BOL','BOL','BOL','U',''} )
aAdd( aSX6, {'  ','NCG_TP_PAG','C','Prefixo++Tipo de título válido para lançamento man','Prefixo++Tipo de título válido para lançamento man','Prefixo++Tipo de título válido para lançamento man','ual.','ual.','ual.','','','','-TX/-BOL/UNI-PA/RMB-RC','-TX/-BOL/UNI-PA/RMB-RC','-TX/-BOL/UNI-PA/RMB-RC','U',''} )
aAdd( aSX6, {'  ','NC_ALTMULT','L','Verifica se o campo multa poderá ser alterado, na','Verifica se o campo multa poderá ser alterado, na','Verifica se o campo multa poderá ser alterado, na','baixa do titulo a receber (FINA070).','baixa do titulo a receber (FINA070).','baixa do titulo a receber (FINA070).','','','','.T.','.T.','.T.','U',''} )
aAdd( aSX6, {'  ','NC_CFGRCTB','C','CFOP´s que permitem a gravação do campo Grupo Cont','CFOP´s que permitem a gravação do campo Grupo Cont','CFOP´s que permitem a gravação do campo Grupo Cont','ábil.','ábil.','ábil.','','','','1949;2949;3102;5949;6949','1949;2949;3102;5949;6949','1949;2949;3102;5949;6949','U',''} )
aAdd( aSX6, {'  ','NC_CFOEIP1','C','CFOP de estorno de IPI entrada','CFOP de estorno de IPI entrada','CFOP de estorno de IPI entrada','','','','','','','1202|2202|1411|2411|1152|1913','1202|2202|1411|2411|1152|1913','1202|2202|1411|2411|1152|1913','U',''} )
aAdd( aSX6, {'  ','NC_CFOEIP2','C','CFOP de estorno de IPI entrada CFOP = 1949|2949 e','CFOP de estorno de IPI entrada CFOP = 1949|2949 e','CFOP de estorno de IPI entrada CFOP = 1949|2949 e','formulario proprio','formulario proprio','formulario proprio','','','','1949|2949','1949|2949','1949|2949','U',''} )
aAdd( aSX6, {'  ','NC_CFOEST2','C','CFOP de estorno de ICMS ST entrada','CFOP de estorno de ICMS ST entrada','CFOP de estorno de ICMS ST entrada','','','','','','','2411|1411','2411|1411','2411|1411','U',''} )
aAdd( aSX6, {'  ','NC_CFOPDEV','C','CFOP de Devolução (Calc. do Custo Medio Gerencial)','CFOP de Devolução (Calc. do Custo Medio Gerencial)','CFOP de Devolução (Calc. do Custo Medio Gerencial)','','','','','','','2949|1949','2949|1949','2949|1949','U',''} )
aAdd( aSX6, {'  ','NC_CFOPEST','C','CFOP de estorno de ICMS ST entrada CFOP = 2949|194','CFOP de estorno de ICMS ST entrada CFOP = 2949|194','CFOP de estorno de ICMS ST entrada CFOP = 2949|194','9 e formulario proprio','9 e formulario proprio','9 e formulario proprio','','','','2949|1949','2949|1949','2949|1949','U',''} )
aAdd( aSX6, {'  ','NC_CFOPSIP','C','CFOP de estorno de IPI saida','CFOP de estorno de IPI saida','CFOP de estorno de IPI saida','','','','','','','5102|5910|5912|5913|5949|5152|6108|6403|6910|6949|6102','5102|5910|5912|5913|5949|5152|6108|6403|6910|6949|6102','5102|5910|5912|5913|5949|5152|6108|6403|6910|6949|6102','U',''} )
aAdd( aSX6, {'  ','NC_CFOPSST','C','CFOP de estorno de ICMS ST saida','CFOP de estorno de ICMS ST saida','CFOP de estorno de ICMS ST saida','','','','','','','6403|6404','6403|6404','6403|6404','U',''} )
aAdd( aSX6, {'  ','NC_CGRL204','C','CAMINHO PARA SALVAR PLANILHA DE TABELA DE PREÇOS','','','','','','','','','XLSNC\','\XLSNC\','\XLSNC\','U',''} )
aAdd( aSX6, {'  ','NC_CMVGCLI','C','Código do cliente NC Games','Código do cliente NC Games','Código do cliente NC Games','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','NC_CMVGLJ','C','Loja do cliente NC Games','Loja do cliente NC Games','Loja do cliente NC Games','','','','','','','01','01','01','U',''} )
aAdd( aSX6, {'  ','NC_CMVGPAI','C','Pais do cliente NC Games','Pais do cliente NC Games','Pais do cliente NC Games','','','','','','','105','105','105','U',''} )
aAdd( aSX6, {'  ','NC_CNBCITI','L','Verifica se esta ativo o CNAB do banco CITI','Verifica se esta ativo o CNAB do banco CITI','Verifica se esta ativo o CNAB do banco CITI','','','','','','','.T.','.T.','.T.','U',''} )
aAdd( aSX6, {'  ','NC_COMSOFT','C','Complemento do código do produto na réplica para s','Complemento do código do produto na réplica para s','Complemento do código do produto na réplica para s','oftware','oftware','oftware','','','','99','99','99','U',''} )
aAdd( aSX6, {'  ','NC_DESCAM','C','Informar a tabela de desconto por idade na importa','','','ção da Assist. Média. Por padrão esse parâmetro se','','','será preenchido com o valor "S009".','','','S009','','','U',''} )
aAdd( aSX6, {'  ','NC_DESCAO','C','Informar a tabela de desconto na importação da Ass','','','Odontológica. Por padrão esse parâmetro será','','','preenchido com o valor "S013"','','','S013','','','U',''} )
aAdd( aSX6, {'  ','NC_DTIMGBR','D','Data inicial do CMG BR','Data inicial do CMG BR','Data inicial do CMG BR','','','','','','','20130801','20130801','20130801','U',''} )
aAdd( aSX6, {'  ','NC_ESTMUNE','C','Estado e municipio estorno de IPI de entrada','Estado e municipio estorno de IPI de entrada','Estado e municipio estorno de IPI de entrada','','','','','','','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','U',''} )
aAdd( aSX6, {'  ','NC_ESTMUNS','C','Estado e municipio estorno de IPI Saida','Estado e municipio estorno de IPI Saida','Estado e municipio estorno de IPI Saida','','','','','','','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','U',''} )
aAdd( aSX6, {'  ','NC_FICMSST','C','Filial que utiliza tratamento especifico no ICMS-S','Filial que utiliza tratamento especifico no ICMS-S','Filial que utiliza tratamento especifico no ICMS-S','T.Exemplo: 01|02|03','T.Exemplo: 01|02|03','T.Exemplo: 01|02|03','','','','03','03','03','U',''} )
aAdd( aSX6, {'  ','NC_FORNMS','C','Fornecedor utilizado no documento de entrada (Midi','Fornecedor utilizado no documento de entrada (Midi','Fornecedor utilizado no documento de entrada (Midi','a x Software)','a x Software)','a x Software)','','','','000184','000184','000184','U',''} )
aAdd( aSX6, {'  ','NC_GRPTRIB','C','Grupo de tributação do produto software','Grupo de tributação do produto software','Grupo de tributação do produto software','','','','','','','000040','000040','000040','U',''} )
aAdd( aSX6, {'  ','NC_HNCCPP','C','Historico NCC Price Protection','Historico NCC Price Protection','Historico NCC Price Protection','','','','','','','PP','PP','PP','U',''} )
aAdd( aSX6, {'  ','NC_HRAECO','C','Historico da RA para E-commerce','Historico da RA para E-commerce','Historico da RA para E-commerce','','','','','','','RA E-commerce','RA E-commerce','RA E-commerce','U',''} )
aAdd( aSX6, {'  ','NC_LAYTRA1','C','E-mail de Layout de Transportadora','','','','','','','','','msoares@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NC_LAYTRA2','C','E-mail de Layout de Transportadora','','','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','NC_LAYTRAN','C','E-mail de Layout de Transportadora','','','','','','','','','ebrito@ncgames.com.br;snunes@ncgames.com.br;fgoncalves@ncgames.com.br;csantos@ncgames.com.br;madriano@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NC_LOJAMS','C','Loja utilizado no documento de entrada (Midia x So','Loja utilizado no documento de entrada (Midia x So','Loja utilizado no documento de entrada (Midia x So','ftware)','ftware)','ftware)','','','','01','','','U',''} )
aAdd( aSX6, {'  ','NC_MTBXAP','C','Motivo de baixa que poderá ser utilizado na baixa','Motivo de baixa que poderá ser utilizado na baixa','Motivo de baixa que poderá ser utilizado na baixa','do titulo a receber (FINA080).','do titulo a receber (FINA080).','do titulo a receber (FINA080).','','','','DEBITO CC','DEBITO CC','DEBITO CC','U',''} )
aAdd( aSX6, {'  ','NC_MTBXAR','C','Motivo de baixa que poderá ser utilizado na baixa','Motivo de baixa que poderá ser utilizado na baixa','Motivo de baixa que poderá ser utilizado na baixa','do titulo a receber (FINA070).','do titulo a receber (FINA070).','do titulo a receber (FINA070).','','','','NORMAL','NORMAL','NORMAL','U',''} )
aAdd( aSX6, {'  ','NC_NATECO','C','Natureza da RA para E-commerce','Natureza da RA para E-commerce','Natureza da RA para E-commerce','','','','','','','WEB','WEB','WEB','U',''} )
aAdd( aSX6, {'  ','NC_NATURPP','C','Natureza da NCC de Price Protection','Natureza da NCC de Price Protection','Natureza da NCC de Price Protection','','','','','','','PP','PP','PP','U',''} )
aAdd( aSX6, {'  ','NC_NCMMDSW','C','Lista dos NCMs separados por ; que tem tratamento','Lista dos NCMs separados por ; que tem tratamento','Lista dos NCMs separados por ; que tem tratamento','de mídia e software','de mídia e software','de mídia e software','','','','85234990','85234990','85234990','U',''} )
aAdd( aSX6, {'  ','NC_NCMSOFT','C','NCM utilizado no produto software','NCM utilizado no produto software','NCM utilizado no produto software','','','','','','','99999999','99999999','99999999','U',''} )
aAdd( aSX6, {'  ','NC_PCMGBR','N','Percentual para compor o valor do CMG BR','Percentual para compor o valor do CMG BR','Percentual para compor o valor do CMG BR','','','','','','','-7','-7','-7','U',''} )
aAdd( aSX6, {'  ','NC_PERCDES','N','Informar o percentual de desconto do funcionário,','','','na importação do VT, VR e VA.','','','','','','6','','','U',''} )
aAdd( aSX6, {'  ','NC_PREFECO','C','Prefixo utilizado na RA do E-commerce','Prefixo utilizado na RA do E-commerce','Prefixo utilizado na RA do E-commerce','','','','','','','WEB','WEB','WEB','U',''} )
aAdd( aSX6, {'  ','NC_PREFIPP','C','Prefixo utilizado na criação da NCC do Price Prote','Prefixo utilizado na criação da NCC do Price Prote','Prefixo utilizado na criação da NCC do Price Prote','ction','ction','ction','','','','PP','PP','PP','U',''} )
aAdd( aSX6, {'  ','NC_RMTCOMP','C','E-mail completo do remetente','E-mail completo do remetente','E-mail completo do remetente','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','NC_SERMS','C','Serie utilizada no documento de saída (Midia x Sof','Serie utilizada no documento de saída (Midia x Sof','Serie utilizada no documento de saída (Midia x Sof','tware)','tware)','tware)','','','','5','','','U',''} )
aAdd( aSX6, {'  ','NC_TAMDLI','N','Tamanho do campo para descrição LI, na geração do','Tamanho do campo para descrição LI, na geração do','Tamanho do campo para descrição LI, na geração do','arquivo para despachante','arquivo para despachante','arquivo para despachante','','','','2000','2000','2000','U',''} )
aAdd( aSX6, {'  ','NC_VBPUBLI','C','Codigo do produto utilizado na verba publisher','Codigo do produto utilizado na verba publisher','Codigo do produto utilizado na verba publisher','','','','','','','VERBAPUBLIS','VERBAPUBLIS','VERBAPUBLIS','U',''} )
aAdd( aSX6, {'  ','NC_VLMDICM','C','Valor da midia do ICMS','Valor da midia do ICMS','Valor da midia do ICMS','','','','','','','9.6','9.6','9.6','U',''} )
aAdd( aSX6, {'  ','NC_VLMDIPI','C','Valor da midia do ICMS','Valor da midia do ICMS','Valor da midia do ICMS','','','','','','','4.8','4.8','4.8','U',''} )
aAdd( aSX6, {'  ','NC_VPCATE','N','Dias de informativo de VPC a vencer','','','','','','','','','60','60','60','U',''} )
aAdd( aSX6, {'  ','NC_VPCEMAI','C','Email de pessoas que iram receber o aviso de venci','','','mento do VPC','','','','','','lfelipe@ncgames.com.br;nhirano@ncgames.com.br;admvendas@ncgames.com.br;ebasolli@ncgames.com.br;rciambarella@ncgames.com.br;cmacedo@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','SAC_ACCOUN','C','Usuário da conta recebimento do e-mail do SAC','Usuário da conta recebimento do e-mail do SAC','Usuário da conta recebimento do e-mail do SAC','','','','','','','sactst','sactst','sactst','U',''} )
aAdd( aSX6, {'  ','SAC_ACCPSW','C','Senha de autenticação recebimento do e-mail do SAC','Senha de autenticação recebimento do e-mail do SAC','Senha de autenticação recebimento do e-mail do SAC','','','','','','','Teste.123','Teste.123','Teste.123','U',''} )
aAdd( aSX6, {'  ','SAC_DIRAIZ','C','Diretório raiz dos arquivos temporários do SAC','Diretório raiz dos arquivos temporários do SAC','Diretório raiz dos arquivos temporários do SAC','','','','','','','\\192.168.0.200\protheus11\Protheus_Data','\\192.168.0.187\totvsteste\Protheus_Data','\\192.168.0.187\totvsteste\Protheus_Data','U',''} )
aAdd( aSX6, {'  ','SAC_DIRANX','C','Diretório dos arquivos anexos do SAC','Diretório dos arquivos anexos do SAC','Diretório dos arquivos anexos do SAC','','','','','','','\SAC\Anexos\','\SAC\Anexos\','\SAC\Anexos\','U',''} )
aAdd( aSX6, {'  ','SAC_DIRCHM','C','Diretório dos arquivos de chamados do SAC','Diretório dos arquivos de chamados do SAC','Diretório dos arquivos de chamados do SAC','','','','','','','\SAC\Chamados\','\SAC\Chamados\','\SAC\Chamados\','U',''} )
aAdd( aSX6, {'  ','SAC_DIRFUL','C','Diretório dos arquivos de chamados do SAC','Diretório dos arquivos de chamados do SAC','Diretório dos arquivos de chamados do SAC','','','','','','','\\192.168.0.200\protheus11\Protheus_Data\SAC\chamados\','\\192.168.0.187\totvsteste\Protheus_Data\SAC\chamados\','\\192.168.0.187\totvsteste\Protheus_Data\SAC\chamados\','U',''} )
aAdd( aSX6, {'  ','SAC_DIRTMP','C','Diretório dos arquivos temporários do SAC','Diretório dos arquivos temporários do SAC','Diretório dos arquivos temporários do SAC','','','','','','','\SAC\Temp\','\SAC\Temp\','\SAC\Temp\','U',''} )
aAdd( aSX6, {'  ','SAC_MAILBO','C','MAIL BOX SAC','MAIL BOX SAC','MAIL BOX SAC','','','','','','','SAC','SAC','SAC','U',''} )
aAdd( aSX6, {'  ','SAC_POPSER','C','Servidor Pop do SAC','Servidor Pop do SAC','Servidor Pop do SAC','','','','','','','ncmail','ncmail','ncmail','U',''} )
aAdd( aSX6, {'  ','SA_ENVPSW','C','Senha de autenticação SMTP do e-mail do SAC','Senha de autenticação SMTP do e-mail do SAC','Senha de autenticação SMTP do e-mail do SAC','','','','','','','S4c.123','S4c.123','S4c.123','U',''} )
aAdd( aSX6, {'  ','SA_RELACNT','C','Conta a ser utilizada no envio de E-Mail do SAC','Conta a ser utilizada no envio de E-Mail do SAC','Conta a ser utilizada no envio de E-Mail do SAC','','','','','','','sac@ncgames.com.br','sac@ncgames.com.br','sac@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','SA_SMTPSRV','C','Servidor SMTP do SAC','Servidor SMTP do SAC','Servidor SMTP do SAC','','','','','','','ncmail','ncmail','ncmail','U',''} )
aAdd( aSX6, {'01','MV_ALMOX','C','ARMAZENS VALIDOS','','','','','','','','','01/02/03/04/05/07/08/11/CV/99/06/98/31/95/XX','01/02/03/04/05/07/08/11','01/02/03/04/05/07/08/11','U',''} )
aAdd( aSX6, {'01','MV_FINA4ES','L','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','.F.','','','U',''} )
aAdd( aSX6, {'01','MV_R54CFOP','C','Indica quais CFOPs de Serviços farão parte dos lan','Indica cuales CFOP de Servicios formaran parte de','It indicates the service CFOPs to be a part of the','çamentos no Registro Tipo 54.','los asientos en el Archivo Tipo 54.','entries in the Registration Type 54.','','','','','','','U',''} )
aAdd( aSX6, {'01','MV_R54IPI','L','Habilita/desabilita a utilização do IPI nas operaç','Habilita/deshabilita utilizacion del IPI en Oper.','Enables/disables IPI use in operations in which','ões em que o TES é configurado com o campo "Calcul','en las que el TES se configura con el campo "Calcu','TIO is configured with "Calculate IPI" field','a IPI" atribuído com o conteúdo "R" Com. N. Atacad','la IPI" atribuido con contenido "R" Com. N. Mayor.','filled with "R" Com. N. Wholesale.','.F.','','','U',''} )
aAdd( aSX6, {'01','MV_SERIE','C','Configuração da série a ser apresentada pelas','Configuracion de la serie por presentarse por el','Series configuration to be presented by','Notas Fiscais emitidas.','Facturas emitidas.','Invoices issued.','','','','2  -002/2-002/1  -001/  1-001/','2  -002/2-002/1  -001/  1-001/','2  -002/2-002/1  -001/  1-001/','U',''} )
aAdd( aSX6, {'01','MV_SINTEG','C','Estabelece os CFOPs que serao desconsiderados na','Establece los CFOP que se ignoraran en la','It establishes the CFOPs that will not be consider','geracao dos registros 54 e 75 - SINTEGRA','generacion de los registros 54 y 75 - SINTEGRA','red when generating records 54 and 75 - SINTEGRA','( Portaria CAT Nº 32/96 )','(Resolucion CAT Nro. 32/96 )','(Admin. rule CAT No. 32/96).','','','','U',''} )
aAdd( aSX6, {'01','MV_SINTIPC','L','Indica se o item 997 das NF de Complemento,deve-','Indica si el item 997 de las Fact. de Complemento,','It indicates if item 977 of complement inv. must','rão acompanhar a quantidade de itens da NF (reg.','debe acompanar la cantidad de items de la Fact(reg','accompany the number of invoice items (reg.','tipo 54)','tipo 54)','type 54)','.F.','','','U',''} )
aAdd( aSX6, {'01','MV_STUF','C','Unidades Federativas que devem ser processadas na','Unidades Federativas que deben ser procesadas en','States that must be processed while','apuração das entradas e das saídas do ICMS Subst.','apuração das entradas e das saídas do ICMS Subst.','calculating inflows and outflows of ICMS Tax','Tributária.','Tributaria.','Subst.','','','','U',''} )
aAdd( aSX6, {'01','MV_STUFS','C','Unidades Federativas que devem ser processadas na','Provincias que deben procesarse en el','States to be processed while calculating','apuracäo das saidas do ICMS Subst. Tributaria.','calculo de las salidas del ICMS Subst.Tributaria','Tax Replacem.ICMS outflow.','','','','','','','U',''} )
aAdd( aSX6, {'02','MV_ESTADO','C','Sigla do estado da empresa usuaria do Sistema, pa-','Abreviatura de la estado de la empresa usuaria','State abbreviation referring to the system user','ra efeito de calculo de ICMS (7, 12 ou 18%).','del sistema a efectos de calculo del ICMS','code, for the purpose of calculating the','','(7, 12 o 18%).','ICMS (7,12 OR 18%).','ES','ES','ES','U',''} )
aAdd( aSX6, {'02','MV_ICMPAD','N','Informar a aliquota de ICMS aplicada em  operacoes','Informar la alicuota de ICMS aplicada en operacio-','Inform the value added tax rate, applied in the','dentro do estado onde a empresa esta localizada.','nes dentro de la provincia donde se localiza la','operation within the states, in which the company','(17 ou 18) %','empresa. (17 o 18) %','is localized (17 or 18%).','17','17','17','U',''} )
aAdd( aSX6, {'02','MV_MUNIC','C','Utilizado para identificar o codigo dado a secre-','','','taria das financas do municipio para recolher o','','','ISS.','','','MUNIC','','','U',''} )
aAdd( aSX6, {'03','MV_ALMOX','C','ARMAZENS VALIDOS','','','','','','','','','01/02/03/04/05/07/08/11/CV/99/06/98/31/95/XX/32/33','','','U',''} )
aAdd( aSX6, {'03','MV_FINA4ES','L','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','.F.','','','U',''} )
aAdd( aSX6, {'03','MV_MUNIC','C','Utilizado para identificar o codigo dado a secre-','','','taria das financas do municipio para recolher o','','','ISS.','','','MUN03','MUN03','MUN03','U',''} )
aAdd( aSX6, {'03','MV_R54CFOP','C','Indica quais CFOPs de Serviços farão parte dos lan','Indica cuales CFOP de Servicios formaran parte de','It indicates the service CFOPs to be a part of the','çamentos no Registro Tipo 54.','los asientos en el Archivo Tipo 54.','entries in the Registration Type 54.','','','','','','','U',''} )
aAdd( aSX6, {'03','MV_R54IPI','L','Habilita/desabilita a utilização do IPI nas operaç','Habilita/deshabilita utilizacion del IPI en Oper.','Enables/disables IPI use in operations in which','ões em que o TES é configurado com o campo "Calcul','en las que el TES se configura con el campo "Calcu','TIO is configured with "Calculate IPI" field','a IPI" atribuído com o conteúdo "R" Com. N. Atacad','la IPI" atribuido con contenido "R" Com. N. Mayor.','filled with "R" Com. N. Wholesale.','.F.','','','U',''} )
aAdd( aSX6, {'03','MV_SINTEG','C','Estabelece os CFOPs que serao desconsiderados na','Establece los CFOP que se ignoraran en la','It establishes the CFOPs that will not be consider','geracao dos registros 54 e 75 - SINTEGRA','generacion de los registros 54 y 75 - SINTEGRA','red when generating records 54 and 75 - SINTEGRA','( Portaria CAT Nº 32/96 )','(Resolucion CAT Nro. 32/96 )','(Admin. rule CAT No. 32/96).','','','','U',''} )
aAdd( aSX6, {'03','MV_SINTIPC','L','Indica se o item 997 das NF de Complemento,deve-','Indica si el item 997 de las Fact. de Complemento,','It indicates if item 977 of complement inv. must','rão acompanhar a quantidade de itens da NF (reg.','debe acompanar la cantidad de items de la Fact(reg','accompany the number of invoice items (reg.','tipo 54)','tipo 54)','type 54)','.F.','','','U',''} )
aAdd( aSX6, {'03','MV_SUBTRI1','C','Numero da Inscricao Estadual do contribuinte','Numero de Inscripcion Provincial del contribuyente','Taxpayer State Insc.number in another state when','em outro estado quando houver Substituicao','en otro estado cuando hubiera Sustitucion','there is Tax Override.','Tributaria','Tributaria','','CE065843207/SE271344369','','','U',''} )
aAdd( aSX6, {'04','MV_ESTADO','C','Sigla do estado da empresa usuaria do Sistema, pa-','','','ra efeito de calculo de ICMS (7, 12 ou 18%).','','','','','','PE','','','U',''} )
aAdd( aSX6, {'04','MV_MUNIC','C','Utilizado para identificar o codigo dado a secre-','','','taria das financas do municipio para recolher o','','','ISS.','','','MUNIC','','','U',''} )
aAdd( aSX6, {'04','MV_ULMES','D','Data ultimo fechamento do estoque.','Fecha del ultimo cierre de stock.','Inventory last closing date.','','','','','','','31/01/2013','31/01/2013','31/01/2013','U',''} )
aAdd( aSX6, {'05','MV_ESTADO','C','Sigla do estado da empresa usuaria do Sistema, pa-','','','ra efeito de calculo de ICMS (7, 12 ou 18%).','','','','','','PR','PR','PR','U',''} )
aAdd( aSX6, {'05','MV_MUNIC','C','Utilizado para identificar o codigo dado a secre-','','','taria das financas do municipio para recolher o','','','ISS.','','','MUNIC','MUNIC','MUNIC','U',''} )
aAdd( aSX6, {'05','MV_SUBTRIB','C','','','','','','','','','','','','','U',''} )
aAdd( aSX6, {'05','MV_ULMES','D','Data ultimo fechamento do estoque.','','','','','','','','','31/01/14','31/01/14','31/01/14','U',''} )
//
// Atualizando dicionário
//
oProcess:SetRegua2( Len( aSX6 ) )

dbSelectArea( "SX6" )
dbSetOrder( 1 )

For nI := 1 To Len( aSX6 )
	lContinua := .F.
	lReclock  := .F.

	If !SX6->( dbSeek( PadR( aSX6[nI][1], nTamFil ) + PadR( aSX6[nI][2], nTamVar ) ) )
		lContinua := .T.
		lReclock  := .T.
		cTexto += "Foi incluído o parâmetro " + aSX6[nI][1] + aSX6[nI][2] + " Conteúdo [" + AllTrim( aSX6[nI][13] ) + "]"+ CRLF
	EndIf

	If lContinua
		If !( aSX6[nI][1] $ cAlias )
			cAlias += aSX6[nI][1] + "/"
		EndIf

		RecLock( "SX6", lReclock )
		For nJ := 1 To Len( aSX6[nI] )
			If FieldPos( aEstrut[nJ] ) > 0
				FieldPut( FieldPos( aEstrut[nJ] ), aSX6[nI][nJ] )
			EndIf
		Next nJ
		dbCommit()
		MsUnLock()
	EndIf

	oProcess:IncRegua2( "Atualizando Arquivos (SX6)..." )

Next nI

cTexto += CRLF + "Final da Atualização" + " SX6" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSXA
Função de processamento da gravação do SXA - Pastas

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSXA( cTexto )
Local aEstrut   := {}
Local aSXA      := {}
Local cAlias    := ""
Local nI        := 0
Local nJ        := 0

cTexto  += "Ínicio da Atualização" + " SXA" + CRLF + CRLF

aEstrut := { "XA_ALIAS"  , "XA_ORDEM"  , "XA_DESCRIC", "XA_DESCSPA", ;
             "XA_DESCENG", "XA_PROPRI" , "XA_AGRUP"  , "XA_TIPO"     }

aAdd( aSXA, {'SC5','1','Faturamento','Faturamento','Faturamento','U','',''} )
aAdd( aSXA, {'SC5','2','Frete','Frete','Frete','U','',''} )
aAdd( aSXA, {'SC5','3','Analise Credito','Analise Credito','Analise Credito','U','',''} )
aAdd( aSXA, {'SC5','4','Orcamento em Negociacao','Orcamento em Negociacao','Orcamento em Negociacao','U','',''} )
aAdd( aSXA, {'SC5','5','VPC/Verba Extra','VPC/Verba Extra','VPC/Verba Extra','U','',''} )
aAdd( aSXA, {'SC5','6','Dados Pedido Pai','Dados Pedido Pai','Dados Pedido Pai','U','',''} )
aAdd( aSXA, {'SC5','7','E-Commerce','E-Commerce','E-Commerce','U','',''} )
//
// Atualizando dicionário
//
oProcess:SetRegua2( Len( aSXA ) )

dbSelectArea( "SXA" )
dbSetOrder( 1 )

For nI := 1 To Len( aSXA )

	If !SXA->( dbSeek( aSXA[nI][1] + aSXA[nI][2] ) )

		If !( aSXA[nI][1] $ cAlias )
			cAlias += aSXA[nI][1] + "/"
		EndIf

		RecLock( "SXA", .T. )
		For nJ := 1 To Len( aSXA[nI] )
			If FieldPos( aEstrut[nJ] ) > 0
				FieldPut( FieldPos( aEstrut[nJ] ), aSXA[nI][nJ] )
			EndIf
		Next nJ
		dbCommit()
		MsUnLock()

		cTexto += "Foi incluída a pasta " + aSXA[nI][1] + "/" + aSXA[nI][2] + "  " + aSXA[nI][3] + CRLF

		oProcess:IncRegua2( "Atualizando Arquivos (SXA)..." )

	EndIf

Next nI

cTexto += CRLF + "Final da Atualização" + " SXA" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSXB
Função de processamento da gravação do SXB - Consultas Padrao

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSXB( cTexto )
Local aEstrut   := {}
Local aSXB      := {}
Local cAlias    := ""
Local cMsg      := ""
Local lTodosNao := .F.
Local lTodosSim := .F.
Local nI        := 0
Local nJ        := 0
Local nOpcA     := 0

cTexto  += "Ínicio da Atualização" + " SXB" + CRLF + CRLF

aEstrut := { "XB_ALIAS",  "XB_TIPO"   , "XB_SEQ"    , "XB_COLUNA" , ;
             "XB_DESCRI", "XB_DESCSPA", "XB_DESCENG", "XB_CONTEM" }

aAdd( aSXB, {'SA1','1','01','DB','Cliente','Cliente','Customer','SA1'} )
aAdd( aSXB, {'SA1','2','01','01','Codigo','Codigo','Code',''} )
aAdd( aSXB, {'SA1','2','02','02','Nome','Nombre','Name',''} )
aAdd( aSXB, {'SA1','2','03','03','CNPJ/CPF','CNPJ/CPF','CNPJ/CPF',''} )
aAdd( aSXB, {'SA1','2','04','05','N Fantasia','Nom Fantasia','Trade Name',''} )
aAdd( aSXB, {'SA1','3','01','01','Cadastra Novo','Incluye Nuevo','Add New','01'} )
aAdd( aSXB, {'SA1','4','01','01','Codigo','Codigo','Code','A1_COD'} )
aAdd( aSXB, {'SA1','4','01','02','Loja','Tienda','Store','A1_LOJA'} )
aAdd( aSXB, {'SA1','4','01','03','Nome','Nombre','Name','A1_NOME'} )
aAdd( aSXB, {'SA1','4','02','01','Codigo','Codigo','Code','A1_COD'} )
aAdd( aSXB, {'SA1','4','02','02','Loja','Tienda','Store','A1_LOJA'} )
aAdd( aSXB, {'SA1','4','02','03','Nome','Nombre','Name','A1_NOME'} )
aAdd( aSXB, {'SA1','4','03','01','CNPJ/CPF','CNPJ/CPF','CNPJ/CPF','A1_CGC'} )
aAdd( aSXB, {'SA1','4','03','02','Nome','Nombre','Name','A1_NOME'} )
aAdd( aSXB, {'SA1','4','04','01','Codigo','Codigo','Code','A1_COD'} )
aAdd( aSXB, {'SA1','4','04','02','Loja','Tienda','Unit','A1_LOJA'} )
aAdd( aSXB, {'SA1','4','04','03','N Fantasia','Nom Fantasia','Trade Name','A1_NREDUZ'} )
aAdd( aSXB, {'SA1','5','01','','','','','SA1->A1_COD'} )
aAdd( aSXB, {'SA1','5','02','','','','','SA1->A1_LOJA'} )
//
// Atualizando dicionário
//
oProcess:SetRegua2( Len( aSXB ) )

dbSelectArea( "SXB" )
dbSetOrder( 1 )

For nI := 1 To Len( aSXB )

	If !Empty( aSXB[nI][1] )

		If !SXB->( dbSeek( PadR( aSXB[nI][1], Len( SXB->XB_ALIAS ) ) + aSXB[nI][2] + aSXB[nI][3] + aSXB[nI][4] ) )

			If !( aSXB[nI][1] $ cAlias )
				cAlias += aSXB[nI][1] + "/"
				cTexto += "Foi incluída a consulta padrão " + aSXB[nI][1] + CRLF
			EndIf

			RecLock( "SXB", .T. )

			For nJ := 1 To Len( aSXB[nI] )
				If !Empty( FieldName( FieldPos( aEstrut[nJ] ) ) )
					FieldPut( FieldPos( aEstrut[nJ] ), aSXB[nI][nJ] )
				EndIf
			Next nJ

			dbCommit()
			MsUnLock()

		Else

			//
			// Verifica todos os campos
			//
			For nJ := 1 To Len( aSXB[nI] )

				//
				// Se o campo estiver diferente da estrutura
				//
				If aEstrut[nJ] == SXB->( FieldName( nJ ) ) .AND. ;
					!StrTran( AllToChar( SXB->( FieldGet( nJ ) ) ), " ", "" ) == ;
					 StrTran( AllToChar( aSXB[nI][nJ]            ), " ", "" )

					cMsg := "A consulta padrão " + aSXB[nI][1] + " está com o " + SXB->( FieldName( nJ ) ) + ;
					" com o conteúdo" + CRLF + ;
					"[" + RTrim( AllToChar( SXB->( FieldGet( nJ ) ) ) ) + "]" + CRLF + ;
					", e este é diferente do conteúdo" + CRLF + ;
					"[" + RTrim( AllToChar( aSXB[nI][nJ] ) ) + "]" + CRLF +;
					"Deseja substituir ? "

					If      lTodosSim
						nOpcA := 1
					ElseIf  lTodosNao
						nOpcA := 2
					Else
						nOpcA := Aviso( "ATUALIZAÇÃO DE DICIONÁRIOS E TABELAS", cMsg, { "Sim", "Não", "Sim p/Todos", "Não p/Todos" }, 3, "Diferença de conteúdo - SXB" )
						lTodosSim := ( nOpcA == 3 )
						lTodosNao := ( nOpcA == 4 )

						If lTodosSim
							nOpcA := 1
							lTodosSim := MsgNoYes( "Foi selecionada a opção de REALIZAR TODAS alterações no SXB e NÃO MOSTRAR mais a tela de aviso." + CRLF + "Confirma a ação [Sim p/Todos] ?" )
						EndIf

						If lTodosNao
							nOpcA := 2
							lTodosNao := MsgNoYes( "Foi selecionada a opção de NÃO REALIZAR nenhuma alteração no SXB que esteja diferente da base e NÃO MOSTRAR mais a tela de aviso." + CRLF + "Confirma esta ação [Não p/Todos]?" )
						EndIf

					EndIf

					If nOpcA == 1
						RecLock( "SXB", .F. )
						FieldPut( FieldPos( aEstrut[nJ] ), aSXB[nI][nJ] )
						dbCommit()
						MsUnLock()

						If !( aSXB[nI][1] $ cAlias )
							cAlias += aSXB[nI][1] + "/"
							cTexto += "Foi alterada a consulta padrão " + aSXB[nI][1] + CRLF
						EndIf

					EndIf

				EndIf

			Next

		EndIf

	EndIf

	oProcess:IncRegua2( "Atualizando Consultas Padrões (SXB)..." )

Next nI

cTexto += CRLF + "Final da Atualização" + " SXB" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuHlp
Função de processamento da gravação dos Helps de Campos

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuHlp( cTexto )
Local aHlpPor   := {}
Local aHlpEng   := {}
Local aHlpSpa   := {}

cTexto  += "Ínicio da Atualização" + " " + "Helps de Campos" + CRLF + CRLF


oProcess:IncRegua2( "Atualizando Helps de Campos ..." )

aHlpPor := {}
aAdd( aHlpPor, 'Def.Oper PAC' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PC5_XOPPAC ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "C5_XOPPAC" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Form.Entreg' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PC5_XCODENT", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "C5_XCODENT" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Ok' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_OK    ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_OK" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Vai p/ Site' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_STATUS" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Produto' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_CODPRO", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_CODPRO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Descrição' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_DESCRI", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_DESCRI" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Código Tabela' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_CODTAB", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_CODTAB" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Desc. Tabela' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_TABDES", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_TABDES" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Pessoa Fisica/Juridica' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_PESSOA", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_PESSOA" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Tp Consumidor' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_TCONSU", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_TCONSU" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Tabela Base' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_TABBAS", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_TABBAS" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Estado destino' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_EST   ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_EST" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Item' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_ITEM  ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_ITEM" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Produto' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_CODPRO", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_CODPRO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Descrição Produto' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_DESCRI", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_DESCRI" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Preço da tabela Base' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_PRCBAS", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_PRCBAS" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Preço CiaShop' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_PRCCIA", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_PRCCIA" + CRLF

aHlpPor := {}
aAdd( aHlpPor, '% Frete para o Produto' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_PERFRT", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_PERFRT" + CRLF

aHlpPor := {}
aAdd( aHlpPor, '% IPI' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_PERIPI", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_PERIPI" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Aliq. de ICMS interna' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_ALIINT", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_ALIINT" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Aliq. de ICMS Externa' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_ALIEXT", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_ALIEXT" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Margem Lucro Presumido' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_MARGEM", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_MARGEM" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Aliquota ICMS no Destino' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_ALIDST", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_ALIDST" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Flag' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_FLAG  ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_FLAG" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Despesas Variaveis' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_DESP  ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_DESP" + CRLF

aHlpPor := {}
aAdd( aHlpPor, '%Base Reducao ICM' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_BSICM ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_BSICM" + CRLF

aHlpPor := {}
aAdd( aHlpPor, '%Base Reducao ST' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_BICMST", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_BICMST" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'TES inteligente' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC4_TESINT", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC4_TESINT" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Nome do cliente' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC5_NOME  ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC5_NOME" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Estorno' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC5_ESTORN", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC5_ESTORN" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Numero do documento de devolução' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC5_DOCDEV", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC5_DOCDEV" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Serie de devolução' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC5_SERDEV", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC5_SERDEV" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Flag' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC5_FLAG  ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC5_FLAG" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Pagamento' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC5_PAGTO ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC5_PAGTO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Pedido de venda E-commerce' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_PVECOM", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_PVECOM" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Pedido de venda Protheus' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_PEDIDO", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_PEDIDO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Prefixo' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_PREFIX", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_PREFIX" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Numero do titulo' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_TITULO", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_TITULO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Parcela' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_PARCEL", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_PARCEL" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Tipo do titulo' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_TIPO  ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_TIPO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Status:' )
aAdd( aHlpPor, '01-Titulo baixado com sucesso;' )
aAdd( aHlpPor, '02-Erro ao baixar titulo;' )
aAdd( aHlpPor, '03- Baixado parcialmente.' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_STATUS", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_STATUS" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Observação' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_OBS   ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_OBS" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Valor do titulo' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_VALOR ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_VALOR" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Saldo do titulo' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_SALDO ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_SALDO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Data Vencto.' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_VENCTO", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_VENCTO" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Vencimento real' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC8_VENREA", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC8_VENREA" + CRLF

cTexto += CRLF + "Final da Atualização" + " " + "Helps de Campos" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return {}


//--------------------------------------------------------------------
/*/{Protheus.doc} EscEmpresa
Função genérica para escolha de Empresa, montada pelo SM0

@return aRet Vetor contendo as seleções feitas.
             Se não for marcada nenhuma o vetor volta vazio

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function EscEmpresa()

//---------------------------------------------
// Parâmetro  nTipo
// 1 - Monta com Todas Empresas/Filiais
// 2 - Monta só com Empresas
// 3 - Monta só com Filiais de uma Empresa
//
// Parâmetro  aMarcadas
// Vetor com Empresas/Filiais pré marcadas
//
// Parâmetro  cEmpSel
// Empresa que será usada para montar seleção
//---------------------------------------------
Local   aSalvAmb := GetArea()
Local   aSalvSM0 := {}
Local   aRet     := {}
Local   aVetor   := {}
Local   oDlg     := NIL
Local   oChkMar  := NIL
Local   oLbx     := NIL
Local   oMascEmp := NIL
Local   oMascFil := NIL
Local   oButMarc := NIL
Local   oButDMar := NIL
Local   oButInv  := NIL
Local   oSay     := NIL
Local   oOk      := LoadBitmap( GetResources(), "LBOK" )
Local   oNo      := LoadBitmap( GetResources(), "LBNO" )
Local   lChk     := .F.
Local   lOk      := .F.
Local   lTeveMarc:= .F.
Local   cVar     := ""
Local   cNomEmp  := ""
Local   cMascEmp := "??"
Local   cMascFil := "??"

Local   aMarcadas  := {}


If !MyOpenSm0(.F.)
	Return aRet
EndIf


dbSelectArea( "SM0" )
aSalvSM0 := SM0->( GetArea() )
dbSetOrder( 1 )
dbGoTop()

While !SM0->( EOF() )

	If aScan( aVetor, {|x| x[2] == SM0->M0_CODIGO} ) == 0
		aAdd(  aVetor, { aScan( aMarcadas, {|x| x[1] == SM0->M0_CODIGO .and. x[2] == SM0->M0_CODFIL} ) > 0, SM0->M0_CODIGO, SM0->M0_CODFIL, SM0->M0_NOME, SM0->M0_FILIAL } )
	EndIf

	dbSkip()
End

RestArea( aSalvSM0 )

Define MSDialog  oDlg Title "" From 0, 0 To 270, 396 Pixel

oDlg:cToolTip := "Tela para Múltiplas Seleções de Empresas/Filiais"

oDlg:cTitle   := "Selecione a(s) Empresa(s) para Atualização"

@ 10, 10 Listbox  oLbx Var  cVar Fields Header " ", " ", "Empresa" Size 178, 095 Of oDlg Pixel
oLbx:SetArray(  aVetor )
oLbx:bLine := {|| {IIf( aVetor[oLbx:nAt, 1], oOk, oNo ), ;
aVetor[oLbx:nAt, 2], ;
aVetor[oLbx:nAt, 4]}}
oLbx:BlDblClick := { || aVetor[oLbx:nAt, 1] := !aVetor[oLbx:nAt, 1], VerTodos( aVetor, @lChk, oChkMar ), oChkMar:Refresh(), oLbx:Refresh()}
oLbx:cToolTip   :=  oDlg:cTitle
oLbx:lHScroll   := .F. // NoScroll

@ 112, 10 CheckBox oChkMar Var  lChk Prompt "Todos"   Message  Size 40, 007 Pixel Of oDlg;
on Click MarcaTodos( lChk, @aVetor, oLbx )

@ 123, 10 Button oButInv Prompt "&Inverter"  Size 32, 12 Pixel Action ( InvSelecao( @aVetor, oLbx, @lChk, oChkMar ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Inverter Seleção" Of oDlg

// Marca/Desmarca por mascara
@ 113, 51 Say  oSay Prompt "Empresa" Size  40, 08 Of oDlg Pixel
@ 112, 80 MSGet  oMascEmp Var  cMascEmp Size  05, 05 Pixel Picture "@!"  Valid (  cMascEmp := StrTran( cMascEmp, " ", "?" ), cMascFil := StrTran( cMascFil, " ", "?" ), oMascEmp:Refresh(), .T. ) ;
Message "Máscara Empresa ( ?? )"  Of oDlg
@ 123, 50 Button oButMarc Prompt "&Marcar"    Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .T. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Marcar usando máscara ( ?? )"    Of oDlg
@ 123, 80 Button oButDMar Prompt "&Desmarcar" Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .F. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Desmarcar usando máscara ( ?? )" Of oDlg

Define SButton From 111, 125 Type 1 Action ( RetSelecao( @aRet, aVetor ), oDlg:End() ) OnStop "Confirma a Seleção"  Enable Of oDlg
Define SButton From 111, 158 Type 2 Action ( IIf( lTeveMarc, aRet :=  aMarcadas, .T. ), oDlg:End() ) OnStop "Abandona a Seleção" Enable Of oDlg
Activate MSDialog  oDlg Center

RestArea( aSalvAmb )
dbSelectArea( "SM0" )
dbCloseArea()

Return  aRet


//--------------------------------------------------------------------
/*/{Protheus.doc} MarcaTodos
Função auxiliar para marcar/desmarcar todos os ítens do ListBox ativo

@param lMarca  Contéudo para marca .T./.F.
@param aVetor  Vetor do ListBox
@param oLbx    Objeto do ListBox

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function MarcaTodos( lMarca, aVetor, oLbx )
Local  nI := 0

For nI := 1 To Len( aVetor )
	aVetor[nI][1] := lMarca
Next nI

oLbx:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} InvSelecao
Função auxiliar para inverter a seleção do ListBox ativo

@param aVetor  Vetor do ListBox
@param oLbx    Objeto do ListBox

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function InvSelecao( aVetor, oLbx )
Local  nI := 0

For nI := 1 To Len( aVetor )
	aVetor[nI][1] := !aVetor[nI][1]
Next nI

oLbx:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} RetSelecao
Função auxiliar que monta o retorno com as seleções

@param aRet    Array que terá o retorno das seleções (é alterado internamente)
@param aVetor  Vetor do ListBox

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function RetSelecao( aRet, aVetor )
Local  nI    := 0

aRet := {}
For nI := 1 To Len( aVetor )
	If aVetor[nI][1]
		aAdd( aRet, { aVetor[nI][2] , aVetor[nI][3], aVetor[nI][2] +  aVetor[nI][3] } )
	EndIf
Next nI

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} MarcaMas
Função para marcar/desmarcar usando máscaras

@param oLbx     Objeto do ListBox
@param aVetor   Vetor do ListBox
@param cMascEmp Campo com a máscara (???)
@param lMarDes  Marca a ser atribuída .T./.F.

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function MarcaMas( oLbx, aVetor, cMascEmp, lMarDes )
Local cPos1 := SubStr( cMascEmp, 1, 1 )
Local cPos2 := SubStr( cMascEmp, 2, 1 )
Local nPos  := oLbx:nAt
Local nZ    := 0

For nZ := 1 To Len( aVetor )
	If cPos1 == "?" .or. SubStr( aVetor[nZ][2], 1, 1 ) == cPos1
		If cPos2 == "?" .or. SubStr( aVetor[nZ][2], 2, 1 ) == cPos2
			aVetor[nZ][1] := lMarDes
		EndIf
	EndIf
Next

oLbx:nAt := nPos
oLbx:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} VerTodos
Função auxiliar para verificar se estão todos marcados ou não

@param aVetor   Vetor do ListBox
@param lChk     Marca do CheckBox do marca todos (referncia)
@param oChkMar  Objeto de CheckBox do marca todos

@author Ernani Forastieri
@since  27/09/2004
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function VerTodos( aVetor, lChk, oChkMar )
Local lTTrue := .T.
Local nI     := 0

For nI := 1 To Len( aVetor )
	lTTrue := IIf( !aVetor[nI][1], .F., lTTrue )
Next nI

lChk := IIf( lTTrue, .T., .F. )
oChkMar:Refresh()

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} MyOpenSM0
Função de processamento abertura do SM0 modo exclusivo

@author TOTVS Protheus
@since  01/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function MyOpenSM0(lShared)

Local lOpen := .F.
Local nLoop := 0

For nLoop := 1 To 20
	dbUseArea( .T., , "SIGAMAT.EMP", "SM0", lShared, .F. )

	If !Empty( Select( "SM0" ) )
		lOpen := .T.
		dbSetIndex( "SIGAMAT.IND" )
		Exit
	EndIf

	Sleep( 500 )

Next nLoop

If !lOpen
	MsgStop( "Não foi possível a abertura da tabela " + ;
	IIf( lShared, "de empresas (SM0).", "de empresas (SM0) de forma exclusiva." ), "ATENÇÃO" )
EndIf

Return lOpen


/////////////////////////////////////////////////////////////////////////////
