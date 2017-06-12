#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

//--------------------------------------------------------------------
/*/{Protheus.doc} PRJFILIA
Função de update de dicionários para compatibilização

@author TOTVS Protheus
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
User Function UPD_FILIAL( cEmpAmb, cFilAmb )

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
				MsgStop( "Atualização Realizada.", "PRJFILIA" )
				dbCloseAll()
			Else
				MsgStop( "Atualização não Realizada.", "PRJFILIA" )
				dbCloseAll()
			EndIf
		Else
			If lOk
				Final( "Atualização Concluída." )
			Else
				Final( "Atualização não Realizada." )
			EndIf
		EndIf

		Else
			MsgStop( "Atualização não Realizada.", "PRJFILIA" )

		EndIf

	Else
		MsgStop( "Atualização não Realizada.", "PRJFILIA" )

	EndIf

EndIf

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSTProc
Função de processamento da gravação dos arquivos

@author TOTVS Protheus
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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


			oProcess:IncRegua1( "Dicionário de gatilhos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX7( @cTexto )


			oProcess:IncRegua1( "Dicionário de consultas padrão" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSXB( @cTexto )

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
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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

aAdd( aSX2, {'PZ1',cPath,'PZ1'+cEmpr,'TABELA INTERMEDIARIA FILIAL','TABELA INTERMEDIARIA FILIAL','TABELA INTERMEDIARIA FILIAL',0,'C','','','','','C','C',0} )
aAdd( aSX2, {'PZ2',cPath,'PZ2'+cEmpr,'LOG TABELA INTERMEDIARIA','LOG TABELA INTERMEDIARIA','LOG TABELA INTERMEDIARIA',0,'C','','','','','C','C',0} )
aAdd( aSX2, {'PZ3',cPath,'PZ3'+cEmpr,'PRIORIZAÇÃO PARA FATURAMENTO','PRIORIZAÇÃO PARA FATURAMENTO','PRIORIZAÇÃO PARA FATURAMENTO',0,'C','','','','','E','E',0} )
aAdd( aSX2, {'ZZC',cPath,'ZZC'+cEmpr,'RELACAO DE IMEI CELULAR','RELACAO DE IMEI CELULAR','RELACAO DE IMEI CELULAR',0,'E','','','','','E','E',0} )
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
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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

aEstrut := { "X3_ARQUIVO", "X3_ORDEM"  , "X3_CAMPO"  , "X3_TIPO"   , "X3_TAMANHO", "X3_DECIMAL", ;
             "X3_TITULO" , "X3_TITSPA" , "X3_TITENG" , "X3_DESCRIC", "X3_DESCSPA", "X3_DESCENG", ;
             "X3_PICTURE", "X3_VALID"  , "X3_USADO"  , "X3_RELACAO", "X3_F3"     , "X3_NIVEL"  , ;
             "X3_RESERV" , "X3_CHECK"  , "X3_TRIGGER", "X3_PROPRI" , "X3_BROWSE" , "X3_VISUAL" , ;
             "X3_CONTEXT", "X3_OBRIGAT", "X3_VLDUSER", "X3_CBOX"   , "X3_CBOXSPA", "X3_CBOXENG", ;
             "X3_PICTVAR", "X3_WHEN"   , "X3_INIBRW" , "X3_GRPSXG" , "X3_FOLDER" , "X3_PYME"   }


aAdd( aSX3, {'PZ1','01','PZ1_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','',''} )
aAdd( aSX3, {'PZ1','02','PZ1_FILORI','C',2,0,'FilialOrigem','FilialOrigem','FilialOrigem','Filial Origem','Filial Origem','Filial Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','03','PZ1_ORCAME','C',6,0,'Orcamento','Orcamento','Orcamento','Orcamento','Orcamento','Orcamento','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','04','PZ1_PVORIG','C',6,0,'PV Origem','PV Origem','PV Origem','PV Origem','PV Origem','PV Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','05','PZ1_CLIORI','C',6,0,'Cli Origem','Cli Origem','Cli Origem','Cliente Origem','Cliente Origem','Cliente Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','06','PZ1_LJORIG','C',2,0,'Loja Origem','Loja Origem','Loja Origem','Loja Origem','Loja Origem','Loja Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','07','PZ1_FILDES','C',2,0,'FilialDestin','FilialDestin','FilialDestin','Filial Destino','Filial Destino','Filial Destino','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','08','PZ1_PVDEST','C',6,0,'PV Destino','PV Destino','PV Destino','PV Destino','PV Destino','PV Destino','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','09','PZ1_CLIDES','C',6,0,'Cli Destino','Cli Destino','Cli Destino','Cliente no destino','Cliente no destino','Cliente no destino','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','10','PZ1_LJDEST','C',2,0,'Loja Destino','Loja Destino','Loja Destino','Loja Destino','Loja Destino','Loja Destino','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','11','PZ1_DOCSF2','C',9,0,'Doc. Saida','Doc. Saida','Doc. Saida','Doc. Saida','Doc. Saida','Doc. Saida','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','12','PZ1_SERSF2','C',3,0,'Serie Saida','Serie Saida','Serie Saida','Serie Saida','Serie Saida','Serie Saida','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','13','PZ1_DOCSF1','C',9,0,'Doc. Entrada','Doc. Entrada','Doc. Entrada','Doc. Entrada','Doc. Entrada','Doc. Entrada','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','14','PZ1_SERSF1','C',3,0,'SerieEntrada','SerieEntrada','SerieEntrada','SerieEntrada','SerieEntrada','SerieEntrada','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','15','PZ1_DTWMS','D',8,0,'Dt Lib WMS','Dt Lib WMS','Dt Lib WMS','Dt Lib WMS','Dt Lib WMS','Dt Lib WMS','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','16','PZ1_DTEXPE','D',8,0,'Dt Expedicao','Dt Expedicao','Dt Expedicao','Dt Expedicao','Dt Expedicao','Dt Expedicao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','17','PZ1_EXCLUI','C',1,0,'Excluido','Excluido','Excluido','Excluido','Excluido','Excluido','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','18','PZ1_DTEXCL','D',8,0,'Dt.Exclusao','Dt.Exclusao','Dt.Exclusao','Dt.Exclusao','Dt.Exclusao','Dt.Exclusao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','19','PZ1_DSF2OR','C',9,0,'Doc.Saida Or','Doc.Saida Or','Doc.Saida Or','Documento de saida origem','Documento de saida origem','Documento de saida origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','20','PZ1_SSF2OR','C',3,0,'Serie Orig.','Serie Orig.','Serie Orig.','Serie do documento origem','Serie do documento origem','Serie do documento origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','21','PZ1_ROMAN','C',6,0,'Romaneio','Romaneio','Romaneio','Romaneio Carga','Romaneio Carga','Romaneio Carga','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ1','22','PZ1_EXCLPV','C',1,0,'Excluir PV','Excluir PV','Excluir PV','Excluir PV','Excluir PV','Excluir PV','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','01','PZ2_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','',''} )
aAdd( aSX3, {'PZ2','02','PZ2_PVORIG','C',6,0,'PedidoOrigem','PedidoOrigem','PedidoOrigem','Pedido de Origem','Pedido de Origem','Pedido de Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','03','PZ2_FILORI','C',2,0,'FilialOrigem','FilialOrigem','FilialOrigem','Filial de Origem','Filial de Origem','Filial de Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','04','PZ2_ACAO','C',30,0,'ACAO','ACAO','ACAO','ACAO','ACAO','ACAO','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','05','PZ2_DATA','D',8,0,'Data','Data','Data','Data','Data','Data','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','06','PZ2_HORA','C',8,0,'Hora','Hora','Hora','Hora','Hora','Hora','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','07','PZ2_USUARI','C',15,0,'Usuario','Usuario','Usuario','Usuario','Usuario','Usuario','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','08','PZ2_OBS','M',10,0,'Observacao','Observacao','Observacao','Observacao','Observacao','Observacao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ2','09','PZ2_ERRO','C',1,0,'Erro','Erro','Erro','Erro','Erro','Erro','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ3','01','PZ3_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','',''} )
aAdd( aSX3, {'PZ3','02','PZ3_GRPCLI','C',6,0,'Grp Cliente','Grp Cliente','Grp Cliente','Grupo do cliente','Grupo do cliente','Grupo do cliente','@!','Vazio() .or. ExistCpo("ACY")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'M->ACY_GRPVEN','ACY',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','.F.','','','',''} )
aAdd( aSX3, {'PZ3','03','PZ3_CODCLI','C',6,0,'Cod. Cliente','Cod. Cliente','Cod. Cliente','Codigo do cliente','Codigo do cliente','Codigo do cliente','@!','vazio() .or. existcpo("SA1")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SA1MS',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ3','04','PZ3_LOJA','C',2,0,'Loja','Loja','Loja','Loja','Loja','Loja','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'PZ3','05','PZ3_POSIPI','C',10,0,'N.C.M','N.C.M','N.C.M','N.C.M','N.C.M','N.C.M','@R 9999.99.99','existcpo("SYD")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SYD',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','',''} )
aAdd( aSX3, {'PZ3','06','PZ3_FILFAT','C',2,0,'Fat p Filial','Fat p Filial','Fat p Filial','Fat pela Filial?','Fat pela Filial?','Fat pela Filial?','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SM0',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','',''} )
aAdd( aSX3, {'SA1','Q7','A1_YTAB05','C',3,0,'Tab Filial05','Tab Filial05','Tab Filial05','Tabela Filial 05','Tabela Filial 05','Tabela Filial 05','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','DA0',0,Chr(254) + Chr(192),'','','U','N','A','R','','Vazio().Or.ExistCpo("DA0")','','','','','','','','',''} )
aAdd( aSX3, {'SB5','G4','B5_YCODMS','C',15,0,'Cod MS','Cod MS','Cod MS','Cod. Midia ou Software','Cod. Midia ou Software','Cod. Midia ou Software','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'SB5','G5','B5_YSOFTW','C',1,0,'Software','Software','Software','Produto software','Produto software','Produto software','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','1=Sim;2=Não','','','','','','','',''} )
aAdd( aSX3, {'SC6','J6','C6_YMIDPAI','C',6,0,'Item Relacio','Item Relacio','Item Relacio','Item Relacionado','Item Relacionado','Item Relacionado','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'SC6','J7','C6_YITORIG','C',2,2,'Item Orig','Item Orig','Item Orig','Item Orig','Item Orig','Item Orig','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','V','','','','','','','','','','',''} )
aAdd( aSX3, {'SC6','J8','C6_YPRMDSO','N',11,2,'Prc MId+Soft','Prc MId+Soft','Prc MId+Soft','Preco Mida+Software','Preco Mida+Software','Preco Mida+Software','@E 99,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'SF4','M4','F4_YTESENT','C',3,0,'TES Entrada','TES Entrada','TES Entrada','TES Entrada','TES Entrada','TES Entrada','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'SYD','51','YD_YFILFAT','C',2,0,'Fat Filial','Fat Filial','Fat Filial','Prioriza fat pela filial?','Prioriza fat pela filial?','Prioriza fat pela filial?','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SM0',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','1','S'} )
aAdd( aSX3, {'ZZC','01','ZZC_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','',''} )
aAdd( aSX3, {'ZZC','02','ZZC_PEDIDO','C',6,0,'Pedido Venda','Pedido Venda','Pedido Venda','Pedido Venda','Pedido Venda','Pedido Venda','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','03','ZZC_ITEM','C',3,0,'Item','Item','Item','','','','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','04','ZZC_CODBAR','C',15,0,'Cod Barras','Cod Barras','Cod Barras','Codigo de Barras','Codigo de Barras','Codigo de Barras','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','05','ZZC_IMEI_1','C',15,0,'IMEI 1','IMEI 1','IMEI 1','IMEI 1','IMEI 1','IMEI 1','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','06','ZZC_IMEI_2','C',15,0,'IMEI 2','IMEI 2','IMEI 2','IMEI 2','IMEI 2','IMEI 2','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','07','ZZC_CLIENT','C',6,0,'Cliente','Cliente','Cliente','Cliente','Cliente','Cliente','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','08','ZZC_LOJA','C',2,0,'Loja','Loja','Loja','','','','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZC','09','ZZC_NOMCLI','C',40,0,'Nome Cliente','Nome Cliente','Nome Cliente','','','','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
//
// Atualizando dicionário
//

nPosArq := aScan( aEstrut, { |x| AllTrim( x ) == "X3_ARQUIVO" } )
nPosOrd := aScan( aEstrut, { |x| AllTrim( x ) == "X3_ORDEM"   } )
nPosCpo := aScan( aEstrut, { |x| AllTrim( x ) == "X3_CAMPO"   } )
nPosTam := aScan( aEstrut, { |x| AllTrim( x ) == "X3_TAMANHO" } )
nPosSXG := aScan( aEstrut, { |x| AllTrim( x ) == "X3_GRPSXG"  } )
nPosVld := aScan( aEstrut, { |x| AllTrim( x ) == "X3_VALID"   } )

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
				FieldPut( FieldPos( aEstrut[nJ] ), cSeqAtu )

			ElseIf FieldPos( aEstrut[nJ] ) > 0
				FieldPut( FieldPos( aEstrut[nJ] ), aSX3[nI][nJ] )

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
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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

aAdd( aSIX, {'PZ1','1','PZ1_FILIAL+PZ1_FILORI+PZ1_PVORIG+PZ1_FILDES','FilialOrigem + PV Origem + Filial Destino','FilialOrigem + PV Origem + Filial Destino','FilialOrigem + PV Origem + Filial Destino','U','','','S'} )
aAdd( aSIX, {'PZ1','2','PZ1_FILIAL+PZ1_FILDES+PZ1_PVDEST','Filial Destino+PV Destino','Filial Destino+PV Destino','Filial Destino+PV Destino','U','','','S'} )
aAdd( aSIX, {'PZ1','3','PZ1_FILIAL+PZ1_FILDES+PZ1_DOCSF2+PZ1_SERSF2+PZ1_CLIDES+PZ1_LJDEST','Filial Destino + Doc. Saida  + Serie Saida +Cli Destino +Loja Destino','Filial Destino + Doc. Saida  + Serie Saida +Cli Destino +Loja Destino','Filial Destino + Doc. Saida  + Serie Saida +Cli Destino +Loja Destino','U','','','S'} )
aAdd( aSIX, {'PZ2','1','PZ2_FILIAL+PZ2_FILORI','FilialOrigem','FilialOrigem','FilialOrigem','U','','','N'} )
aAdd( aSIX, {'PZ3','1','PZ3_FILIAL+PZ3_GRPCLI+PZ3_CODCLI+PZ3_LOJA+PZ3_POSIPI','Grp Cliente+Cod. Cliente+Loja+N.C.M','Grp Cliente+Cod. Cliente+Loja+N.C.M','Grp Cliente+Cod. Cliente+Loja+N.C.M','U','','','S'} )
aAdd( aSIX, {'PZ3','2','PZ3_FILIAL+PZ3_POSIPI+PZ3_GRPCLI+PZ3_CODCLI+PZ3_LOJA','N.C.M+Grp Cliente+Cod. Cliente+Loja','N.C.M+Grp Cliente+Cod. Cliente+Loja','N.C.M+Grp Cliente+Cod. Cliente+Loja','U','','','S'} )
aAdd( aSIX, {'ZZC','1','ZZC_FILIAL+ZZC_PEDIDO+ZZC_ITEM','Pedido Venda+Item','Pedido Venda+Item','Pedido Venda+Item','U','','','S'} )
aAdd( aSIX, {'ZZC','2','ZZC_FILIAL+ZZC_CODBAR+ZZC_IMEI_1','Cod Barras+IMEI 1','Cod Barras+IMEI 1','Cod Barras+IMEI 1','U','','','S'} )
aAdd( aSIX, {'ZZC','3','ZZC_FILIAL+ZZC_CODBAR+ZZC_IMEI_2','Cod Barras+IMEI 2','Cod Barras+IMEI 2','Cod Barras+IMEI 2','U','','','N'} )
aAdd( aSIX, {'ZZC','4','ZZC_FILIAL+ZZC_IMEI_1','IMEI 1','IMEI 1','IMEI 1','U','','','S'} )
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
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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

aAdd( aSX6, {'  ','NCG_100000','C','Gerar Pedido de Transferencia na Matriz','Gerar Pedido de Transferencia na Matriz','Gerar Pedido de Transferencia na Matriz','','','','','','','S','S','S','U',''} )
aAdd( aSX6, {'  ','NCG_100001','C','Filiais que devem gerar Pedido de Transferencia','Filiais que devem gerar Pedido de Transferencia','Filiais que devem gerar Pedido de Transferencia','','','','','','','04;05','04;05','04;05','U',''} )
aAdd( aSX6, {'  ','NCG_100002','C','Filiais que realizam o tratamento de mídia e softw','Filiais que realizam o tratamento de mídia e softw','Filiais que realizam o tratamento de mídia e softw','are','are','are','','','','05','05','05','U',''} )
aAdd( aSX6, {'  ','NCG_100003','C','Filial Destino PV Transferencia','Filial Destino PV Transferencia','Filial Destino PV Transferencia','','','','','','','03','03','03','U',''} )
aAdd( aSX6, {'  ','NCG_100004','C','TES do Pedido de Transferencia','TES do Pedido de Transferencia','TES do Pedido de Transferencia','','','','','','','546','998','998','U',''} )
aAdd( aSX6, {'  ','NCG_100005','N','Preço da mídia (se for maior que 0 será o valor do','Preço da mídia (se for maior que 0 será o valor do','Preço da mídia (se for maior que 0 será o valor do','parâmetro. Se igual a 0 será o valor do preço na','parâmetro. Se igual a 0 será o valor do preço na','parâmetro. Se igual a 0 será o valor do preço na','tabela de preços)','tabela de preços)','tabela de preços)','6','6','6','U',''} )
aAdd( aSX6, {'  ','NCG_100006','C','Cliente do Pedido de Transferencia','Cliente do Pedido de Transferencia','Cliente do Pedido de Transferencia','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','NCG_100007','C','Loja do Cliente do Pedido de Transferencia','Loja do Cliente do Pedido de Transferencia','Loja do Cliente do Pedido de Transferencia','','','','','','','27','04','04','U',''} )
aAdd( aSX6, {'  ','NCG_100008','C','Condicao de pagamento do Pedido de Transferencia','Condicao de pagamento do Pedido de Transferencia','Condicao de pagamento do Pedido de Transferencia','','','','','','','175','175','175','U',''} )
aAdd( aSX6, {'  ','NCG_100009','C','TES do Software no Pedido de Transferencia','TES do Software no Pedido de Transferencia','TES do Software no Pedido de Transferencia','','','','','','','572','997','997','U',''} )
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
/*/{Protheus.doc} FSAtuSX7
Função de processamento da gravação do SX7 - Gatilhos

@author TOTVS Protheus
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX7( cTexto )
Local aEstrut   := {}
Local aAreaSX3  := SX3->( GetArea() )
Local aSX7      := {}
Local cAlias    := ""
Local nI        := 0
Local nJ        := 0
Local nTamSeek  := Len( SX7->X7_CAMPO )

cTexto  += "Ínicio da Atualização" + " SX7" + CRLF + CRLF

aEstrut := { "X7_CAMPO", "X7_SEQUENC", "X7_REGRA", "X7_CDOMIN", "X7_TIPO", "X7_SEEK", ;
             "X7_ALIAS", "X7_ORDEM"  , "X7_CHAVE", "X7_PROPRI", "X7_CONDIC" }

aAdd( aSX7, {'A1_BAIRRO','001','M->A1_BAIRRO','A1_BAIRROE','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_BAIRRO','002','M->A1_BAIRRO','A1_BAIRROC','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_CEP','001','M->A1_CEP','A1_CEPE','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_CEP','002','M->A1_CEP','A1_CEPC','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_END','001','M->A1_END','A1_ENDCOB','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_END','002','M->A1_END','A1_ENDENT','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_INSCR','001','U_VALIDIE(M->A1_INSCR,M->A1_PESSOA)','A1_INSCR','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_INSCR','002','IF(M->A1_INSCR=="ISENTO","CFIE","CFIE")','A1_GRPTRIB','P','N','',0,'','U','M->A1_TIPO=="F"'} )
aAdd( aSX7, {'A1_LIMINAR','001','"LIM"','A1_GRPTRIB','P','N','',0,'','U','M->A1_TIPO=="R".AND.M->A1_LIMINAR =="1"'} )
aAdd( aSX7, {'A1_LIMINAR','002','"REV"','A1_GRPTRIB','P','N','',0,'','U','M->A1_TIPO=="R".AND.M->A1_LIMINAR =="2"'} )
aAdd( aSX7, {'A1_MUN','001','M->A1_MUN','A1_MUNE','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_MUN','002','M->A1_MUN','A1_MUNC','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_TIPO','001','"CFS"','A1_GRPTRIB','P','N','',0,'','U','M->A1_TIPO == "F"'} )
aAdd( aSX7, {'A1_TIPO','002','"REV"','A1_GRPTRIB','P','N','',0,'','U','M->A1_TIPO == "R"'} )
aAdd( aSX7, {'A1_TIPO','003','"SOL"','A1_GRPTRIB','P','N','',0,'','U','M->A1_TIPO == "S"'} )
aAdd( aSX7, {'A1_VEND','001','GETADVFVAL("SA3","A3_GRPREP",XFILIAL("SA3")+M->A1_VEND,1,"")','A1_YCANAL','P','N','',0,'','U',''} )
aAdd( aSX7, {'A1_VEND','002','ACA->ACA_DESCRI','A1_YDCANAL','P','S','ACA',1,'xfilial("ACA")+M->A1_YCANAL','U',''} )
aAdd( aSX7, {'A1_VEND','003','" "','A1_XGRPCOM','P','N','',0,'','U',''} )
aAdd( aSX7, {'B5_COD','001','SB1->B1_DESC','B5_CEME','P','N','',0,'','U',''} )
aAdd( aSX7, {'B5_TITULO','001','M->B5_TITULO','B5_CEME','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_DESCONT','001','u_PR107Gat()','C6_DESCONT','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_OPER','004','U_PEDBLQPROD("C6_OPER")','C6_TES','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_OPER','005','M->C6_OPER','C6_TPOPER','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_PRCVEN','001','u_PR107Gat()','C6_PRCVEN','P','N','',0,'','U','!IsInCallStack("U_KZNCG11")'} )
aAdd( aSX7, {'C6_PRODUTO','003','SB1->B1_XDESC','C6_DESCRI','P','S','SB1',1,'xFilial("SB1")+M->C6_PRODUTO','U',''} )
aAdd( aSX7, {'C6_PRODUTO','004','DA1->DA1_PRCVEN','C6_PRCTAB','P','S','DA1',1,'XFILIAL("DA1")+M->C5_TABELA+M->C6_PRODUTO','U',''} )
aAdd( aSX7, {'C6_PRODUTO','005','U_PEDBLQPROD("C6_PRODUTO")','C6_TES','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_PRODUTO','006','IF(SB1->B1_TIPO<>"PA",SB1->B1_PRV1,M->C6_PRCTAB)','C6_PRCTAB','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_PRODUTO','007','"51"','C6_LOCAL','P','N','',0,'','U','M->C5_VEND1=="VN9900"'} )
aAdd( aSX7, {'C6_PRODUTO','008','u_PR107Gat()','C6_PRODUTO','P','N','',0,'','U','!IsInCallStack("U_KZNCG11")'} )
aAdd( aSX7, {'C6_QTDVEN','001','U_GAT_MARGR()','C6_PREGDES','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_QTDVEN','003','u_PR107Gat()','C6_QTDVEN','P','S','SF4',1,'xFilial()+M->C6_TES','U','SF4->F4_PODER3<>"D"'} )
aAdd( aSX7, {'C6_YPEOVER','001','u_PR107Gat()','C6_YPEOVER','P','N','',0,'','U',''} )
aAdd( aSX7, {'C6_YVLOVER','001','u_PR107Gat()','C6_YVLOVER','P','N','',0,'','U',''} )
//
// Atualizando dicionário
//
oProcess:SetRegua2( Len( aSX7 ) )

dbSelectArea( "SX3" )
dbSetOrder( 2 )

dbSelectArea( "SX7" )
dbSetOrder( 1 )

For nI := 1 To Len( aSX7 )

	If !SX7->( dbSeek( PadR( aSX7[nI][1], nTamSeek ) + aSX7[nI][2] ) )

		If !( aSX7[nI][1] $ cAlias )
			cAlias += aSX7[nI][1] + "/"
			cTexto += "Foi incluído o gatilho " + aSX7[nI][1] + "/" + aSX7[nI][2] + CRLF
		EndIf

		RecLock( "SX7", .T. )
		For nJ := 1 To Len( aSX7[nI] )
			If FieldPos( aEstrut[nJ] ) > 0
				FieldPut( FieldPos( aEstrut[nJ] ), aSX7[nI][nJ] )
			EndIf
		Next nJ

		dbCommit()
		MsUnLock()

		If SX3->( dbSeek( SX7->X7_CAMPO ) )
			RecLock( "SX3", .F. )
			SX3->X3_TRIGGER := "S"
			MsUnLock()
		EndIf

	EndIf
	oProcess:IncRegua2( "Atualizando Arquivos (SX7)..." )

Next nI

RestArea( aAreaSX3 )

cTexto += CRLF + "Final da Atualização" + " SX7" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSXB
Função de processamento da gravação do SXB - Consultas Padrao

@author TOTVS Protheus
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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

aAdd( aSXB, {'ACY','1','01','DB','Grupos de Clientes','Grupos de Clientes','Customer Groups','ACY'} )
aAdd( aSXB, {'ACY','2','01','01','Grupo','Grupo','Group','01'} )
aAdd( aSXB, {'ACY','3','01','01','Cadastra Novo','Registra Nuevo','Add New','01'} )
aAdd( aSXB, {'ACY','4','01','01','Grupo','Grupo','Group','ACY_GRPVEN'} )
aAdd( aSXB, {'ACY','4','01','02','Descricao','Descripcion','Description','ACY_DESCRI'} )
aAdd( aSXB, {'ACY','5','01','','','','','ACY->ACY_GRPVEN'} )
aAdd( aSXB, {'SA1MS','1','01','DB','Clientes por grupo','Clientes por grupo','Clientes por grupo','SA1'} )
aAdd( aSXB, {'SA1MS','2','01','01','Codigo + Loja','Codigo + Tienda','Code + Unit',''} )
aAdd( aSXB, {'SA1MS','4','01','01','Codigo','Codigo','Code','A1_COD'} )
aAdd( aSXB, {'SA1MS','4','01','02','Loja','Tienda','Unit','A1_LOJA'} )
aAdd( aSXB, {'SA1MS','4','01','03','Nome','Nombre','Name','A1_NOME'} )
aAdd( aSXB, {'SA1MS','5','01','','','','','SA1->A1_COD'} )
aAdd( aSXB, {'SA1MS','5','02','','','','','SA1->A1_LOJA'} )
aAdd( aSXB, {'SA1MS','6','01','','','','','#u_FilClxGr()'} )
aAdd( aSXB, {'SM0','1','01','DB','Filiais','Sucursales','Branches','SM0'} )
aAdd( aSXB, {'SM0','2','01','01','Código','Codigo','Code',''} )
aAdd( aSXB, {'SM0','2','02','02','Nome','Nombre','Name',''} )
aAdd( aSXB, {'SM0','4','01','01','Código','Codigo','Code','M0_CODFIL'} )
aAdd( aSXB, {'SM0','4','01','02','Filial','Sucursal','Branch','M0_FILIAL'} )
aAdd( aSXB, {'SM0','4','01','03','Município','Ciudad','City','M0_CIDENT'} )
aAdd( aSXB, {'SM0','4','02','04','Empresa','Empresa','Company','M0_NOME'} )
aAdd( aSXB, {'SM0','4','02','05','Filial','Sucursal','Branch','M0_FILIAL'} )
aAdd( aSXB, {'SM0','5','01','','','','','FWCodFil()'} )
aAdd( aSXB, {'SYD','1','01','DB','TEC','TEC','TEC','SYD'} )
aAdd( aSXB, {'SYD','2','01','01','Codigo','Codigo','Code',''} )
aAdd( aSXB, {'SYD','2','02','02','Descricao','Descripcion','Description',''} )
aAdd( aSXB, {'SYD','4','01','01','Codigo','Codigo','Code','YD_TEC'} )
aAdd( aSXB, {'SYD','4','01','02','Descricao','Descripcion','Description','YD_DESC_P'} )
aAdd( aSXB, {'SYD','4','01','03','EX-NCM','EX-NCM','EX-NCM','YD_EX_NCM'} )
aAdd( aSXB, {'SYD','4','01','04','EX-NBM','EX-NBM','EX-NBM','YD_EX_NBM'} )
aAdd( aSXB, {'SYD','4','02','05','Descricao','Descripcion','Description','YD_DESC_P'} )
aAdd( aSXB, {'SYD','4','02','06','Codigo','Codigo','Code','YD_TEC'} )
aAdd( aSXB, {'SYD','4','02','07','EX-NCM','EX-NCM','EX-NCM','YD_EX_NCM'} )
aAdd( aSXB, {'SYD','4','02','08','EX-NBM','EX-NBM','EX-NBM','YD_EX_NBM'} )
aAdd( aSXB, {'SYD','5','01','','','','','SYD->YD_TEC'} )
aAdd( aSXB, {'SYD','5','02','','','','','SYD->YD_EX_NCM'} )
aAdd( aSXB, {'SYD','5','03','','','','','SYD->YD_EX_NBM'} )
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
@since  28/09/2013
@obs    Gerado por EXPORDIC - V.4.19.8l EFS / Upd. V.4.16.7 EFS
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
