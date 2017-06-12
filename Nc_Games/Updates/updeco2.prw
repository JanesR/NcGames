#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

//--------------------------------------------------------------------
/*/{Protheus.doc} UPDECO2
Função de update de dicionários para compatibilização

@author TOTVS Protheus
@since  07/04/14
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
User Function UPDECO2( cEmpAmb, cFilAmb )

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
					MsgStop( "Atualização Realizada.", "UPDECO2" )
				Else
					MsgStop( "Atualização não Realizada.", "UPDECO2" )
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
			MsgStop( "Atualização não Realizada.", "UPDECO2" )

		EndIf

	Else
		MsgStop( "Atualização não Realizada.", "UPDECO2" )

	EndIf

EndIf

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSTProc
Função de processamento da gravação dos arquivos

@author TOTVS Protheus
@since  07/04/14
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
@since  07/04/14
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

aAdd( aSX2, {'ZC3',cPath,'ZC3'+cEmpr,'PRODUTOS P/ SITE','PRODUTOS P/ SITE','PRODUTOS P/ SITE',0,'C','','','','','C','C',0} )
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
@since  07/04/14
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


aAdd( aSX3, {'ZC3','01','ZC3_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZC3','02','ZC3_OK','C',2,0,'Ok','Ok','Ok','Ok','Ok','Ok','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','03','ZC3_STATUS','C',2,0,'Vai p/ Site?','Vai p/ Site','Vai p/ Site','Vai p/ Site?','Vai p/ Site','Vai p/ Site','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(254) + Chr(192),'','','U','S','A','R','','U_valid121()','01=Sim;02=Nao;03=Pend. Alteracao;04=Pendente','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','04','ZC3_CODPRO','C',15,0,'Produto','Produto','Produto','Produto','Produto','Produto','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','ExistCpo("ZC3")','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','05','ZC3_DESCRI','C',50,0,'Descrição','Descrição','Descrição','Descrição','Descrição','Descrição','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','06','ZC3_INATIV','C',1,0,'Inativo?','Inativo?','Inativo?','Inativo?','Inativo?','Inativo?','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','1=Sim;2=Não','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','07','ZC3_BLQVEN','C',1,0,'Blq. Vendas?','Blq. Vendas?','Blq. Vendas?','Blq. Vendas?','Blq. Vendas?','Blq. Vendas?','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','1=Sim;2=Não','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','08','ZC3_PRV18','N',8,2,'Preço tab 18','Preço tab 18','Preço tab 18','Preço tab 18','Preço tab 18','Preço tab 18','@E 99,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','09','ZC3_PRV04','N',8,2,'Preço tab 04','Preço tab 04','Preço tab 04','Preço tab 04','Preço tab 04','Preço tab 04','@E 99,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','10','ZC3_OBS','C',20,0,'Observação','Observação','Observação','Observação','Observação','Observação','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','11','ZC3_DTLIB','D',8,0,'Data Lib.','Data Lib.','Data Lib.','Data Lib. Site','Data Lib. Site','Data Lib. Site','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC3','12','ZC3_HRLIB','C',5,0,'Hora Lib.','Hora Lib.','Hora Lib.','Hora Lib. para site','Hora Lib. para site','Hora Lib. para site','@R 99:99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
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
@since  07/04/14
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

aAdd( aSIX, {'ZC3','1','ZC3_FILIAL+ZC3_STATUS','Vai p/ Site','Vai p/ Site','Vai p/ Site','U','','','S'} )
aAdd( aSIX, {'ZC3','2','ZC3_FILIAL+ZC3_CODPRO','Produto','Produto','Produto','U','','','S'} )
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
@since  07/04/14
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
aAdd( aSX6, {'  ','NCG_e00001','C','Usuário para acessar a base do WMS','Usuário para acessar a base do WMS','Usuário para acessar a base do WMS','','','','','','','','','','U',''} )
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
/*/{Protheus.doc} FSAtuHlp
Função de processamento da gravação dos Helps de Campos

@author TOTVS Protheus
@since  07/04/14
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
aAdd( aHlpPor, 'Produtos que estão inativos no B1' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_INATIV", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_INATIV" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Produto Bloqueado para vendas?' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_BLQVEN", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_BLQVEN" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Preço na tabela de preço 018' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_PRV18 ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_PRV18" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Preço tab 04' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_PRV04 ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_PRV04" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Observações do usuário' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_OBS   ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_OBS" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Data de liberação do Produto para o site' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_DTLIB ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_DTLIB" + CRLF

aHlpPor := {}
aAdd( aHlpPor, 'Hora de liberação de produtos para o' )
aAdd( aHlpPor, 'site' )
aHlpEng := {}
aHlpSpa := {}

PutHelp( "PZC3_HRLIB ", aHlpPor, aHlpEng, aHlpSpa, .T. )
cTexto += "Atualizado o Help do campo " + "ZC3_HRLIB" + CRLF

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
@since  07/04/14
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
