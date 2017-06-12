#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

//--------------------------------------------------------------------
/*/{Protheus.doc} PRJ_ES
Função de update de dicionários para compatibilização

@author TOTVS Protheus
@since  17/11/2014
@obs    Gerado por EXPORDIC - V.4.19.8.1 EFS / Upd. V.4.17.7 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
User Function UPD_PRJ_ES( cEmpAmb, cFilAmb )

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
					MsgStop( "Atualização Realizada.", "PRJ_ES" )
				Else
					MsgStop( "Atualização não Realizada.", "PRJ_ES" )
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
			MsgStop( "Atualização não Realizada.", "PRJ_ES" )

		EndIf

	Else
		MsgStop( "Atualização não Realizada.", "PRJ_ES" )

	EndIf

EndIf

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSTProc
Função de processamento da gravação dos arquivos

@author TOTVS Protheus
@since  17/11/2014
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


			oProcess:IncRegua1( "Dicionário de pastas" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSXA( @cTexto )

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
@since  17/11/2014
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

aAdd( aSX2, {'ZAM',cPath,'ZAM'+cEmpr,'CLIENTE/FORNECEDOR FRANCHISING','CLIENTE/FORNECEDOR FRANCHISING','CLIENTE/FORNECEDOR FRANCHISING',0,'C','','','','','C','C',0} )
aAdd( aSX2, {'ZZW',cPath,'ZZW'+cEmpr,'MONITOR INTERFACE STORE WMAS','MONITOR INTERFACE STORE WMAS','MONITOR INTERFACE STORE WMAS',0,'E','','','','','E','E',0} )
aAdd( aSX2, {'ZZX',cPath,'ZZX'+cEmpr,'POSICAO ESTOQUE WMAS STORE','POSICAO ESTOQUE WMAS STORE','POSICAO ESTOQUE WMAS STORE',0,'E','','','','','E','E',0} )
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
@since  17/11/2014
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


aAdd( aSX3, {'SB1','Y8','B1_YSERIE','C',1,0,'Necess.Serie','Necess.Serie','Necess.Serie','Necessario Serie','Necessario Serie','Necessario Serie','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'"1"','',0,Chr(254) + Chr(192),'','','U','N','A','R','€','','1=Nao Necessario;2=Numero de Serie;3=IME1;4=IMEI1 e IMEI2','','','','','','','','',''} )
aAdd( aSX3, {'SB5','K8','B5_YFRANCH','C',1,0,'Franchising?','Franchising?','Franchising?','Franchising?','Franchising?','Franchising?','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'"N"','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','S=Sim;N=Nao','','','','','','','9','',''} )
aAdd( aSX3, {'SC5','P4','C5_YTRANSP','C',6,0,'Transp.Orig','Transp.Orig','Transp.Orig','Transp.Original','Transp.Original','Transp.Original','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZAM','01','ZAM_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZAM','02','ZAM_TIPO','C',1,0,'Tipo','Tipo','Tipo','Tipo','Tipo','Tipo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'"C"','',0,Chr(254) + Chr(192),'','','U','N','A','R','','U_PR112Valid()','C=Cliente;F=Fornecedor','','','','','','','','',''} )
aAdd( aSX3, {'ZAM','03','ZAM_CNPJ','C',14,0,'CNPJ','CNPJ','CNPJ','CNPJ','CNPJ','CNPJ','@R 99.999.999/9999-99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','ZAMCLI',0,Chr(254) + Chr(192),'','','U','S','A','R','€','U_PR112Valid()','','','','','','','','','',''} )
aAdd( aSX3, {'ZAM','04','ZAM_CLIFOR','C',6,0,'Codigo','Codigo','Codigo','Codigo','Codigo','Codigo','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SA1',0,Chr(254) + Chr(192),'','','U','S','A','R','€','U_PR112Valid()','','','','','','','','','',''} )
aAdd( aSX3, {'ZAM','05','ZAM_LOJA','C',2,0,'Loja','Loja','Loja','Loja','Loja','Loja','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','U_PR112Valid()','','','','','','','','','',''} )
aAdd( aSX3, {'ZAM','06','ZAM_NOME','C',30,0,'Nome','Nome','Nome','Nome','Nome','Nome','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','01','ZZW_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZZW','02','ZZW_CHAVE','C',100,0,'Chave','Chave','Chave','Chave','Chave','Chave','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','03','ZZW_TABELA','C',3,0,'Tabela','Tabela','Tabela','Tabela','Tabela','Tabela','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','04','ZZW_DESTAB','C',20,0,'Desc.Tabela','Desc.Tabela','Desc.Tabela','Desc.Tabela','Desc.Tabela','Desc.Tabela','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','05','ZZW_TIPO','C',1,0,'Tipo','Tipo','Tipo','Tipo','Tipo','Tipo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','3=Inclusao;4=Alteracao;5=Exclusao','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','06','ZZW_ARQENV','C',70,0,'Arq. Envio','Arq. Envio','Arq. Envio','Arquivo de Envio','Arquivo de Envio','Arquivo de Envio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','07','ZZW_DATENV','D',8,0,'Data Envio','Data Envio','Data Envio','Data Envio','Data Envio','Data Envio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','08','ZZW_HORENV','C',8,0,'Hora Envio','Hora Envio','Hora Envio','Hora Envio','Hora Envio','Hora Envio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','09','ZZW_ARQRET','C',70,0,'Arq. Retorno','Arq. Retorno','Arq. Retorno','Arquivo de Retorno','Arquivo de Retorno','Arquivo de Retorno','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','10','ZZW_DATRET','D',8,0,'Data Retorno','Data Retorno','Data Retorno','Data Retorno','Data Retorno','Data Retorno','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','11','ZZW_HORRET','C',8,0,'Hora Retorno','Hora Retorno','Hora Retorno','Hora Retorno','Hora Retorno','Hora Retorno','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','12','ZZW_ESTORN','C',1,0,'Estornado','Estornado','Estornado','','','','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','13','ZZW_ERRO','C',1,0,'Com Erro?','Com Erro?','Com Erro?','Com Erro?','Com Erro?','Com Erro?','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','S=Sim;N=Nao','','','','','','','','',''} )
aAdd( aSX3, {'ZZW','14','ZZW_DSERRO','M',10,0,'Desc. Erro','Desc. Erro','Desc. Erro','Descrição do erro','Descrição do erro','Descrição do erro','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZX','01','ZZX_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','',''} )
aAdd( aSX3, {'ZZX','02','ZZX_PRODUT','C',15,0,'Produto','Produto','Produto','Produto','Produto','Produto','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZX','03','ZZX_LOCAL','C',2,0,'Local','Local','Local','Local','Local','Local','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZX','04','ZZX_QUANT','N',14,2,'Quantidade','Quantidade','Quantidade','Quantidade','Quantidade','Quantidade','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZX','05','ZZX_DATA','D',8,0,'Data','Data','Data','Data','Data','Data','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZX','06','ZZX_UM','C',2,0,'Unid. Medida','Unid. Medida','Unid. Medida','Unid. Medida','Unid. Medida','Unid. Medida','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZX','07','ZZX_SLDSB2','N',14,2,'SaldoEstoque','SaldoEstoque','SaldoEstoque','SaldoEstoque','SaldoEstoque','SaldoEstoque','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','N','V','R','','','','','','','','','','','',''} )
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
@since  17/11/2014
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

aAdd( aSIX, {'ZAM','1','ZAM_FILIAL+ZAM_CNPJ','CNPJ','CNPJ','CNPJ','U','','','S'} )
aAdd( aSIX, {'ZAM','2','ZAM_FILIAL+ZAM_CLIFOR+ZAM_LOJA','Cliente+Loja','Cliente+Loja','Cliente+Loja','U','','','S'} )

aAdd( aSIX, {'ZZW','1','ZZW_FILIAL+ZZW_TABELA+ZZW_CHAVE','Tabela+Chave','Tabela+Chave','Tabela+Chave','U','','','S'} )
aAdd( aSIX, {'ZZW','2','ZZW_ARQRET','Arq. Retorno','Arq. Retorno','Arq. Retorno','U','','','N'} )

aAdd( aSIX, {'ZZX','1','ZZX_FILIAL+ZZX_PRODUT+ZZX_LOCAL+ZZX_DATA','Produto+Local+Data','Produto+Local+Data','Produto+Local+Data','U','','','S'} )

aAdd( aSIX, {'ZZC','5','ZZC_FILIAL+ZZC_PEDIDO+ZZC_CODBAR+ZZC_IMEI_1','Pedido Venda+Cod Barras+IMEI/Serie 1','Pedido Venda+Cod Barras+IMEI/Serie 1','Pedido Venda+Cod Barras+IMEI/Serie 1','U','','','N'} )
aAdd( aSIX, {'ZZC','6','ZZC_FILIAL+ZZC_PEDIDO+ZZC_IMEI_2','Pedido Venda+IMEI/Serie 2','Pedido Venda+IMEI/Serie 2','Pedido Venda+IMEI/Serie 2','U','','','N'} )




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
/*/{Protheus.doc} FSAtuSXA
Função de processamento da gravação do SXA - Pastas

@author TOTVS Protheus
@since  17/11/2014
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

aAdd( aSXA, {'SB5','9','Franchising','Franchising','Franchising','U','',''} )
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
@since  17/11/2014
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

User  Function B1_IMEI()
Local aProd:={}
Local nInd
Local cFilSB1
Local cTipoSerie:=""   //1=Nao Necessario;2=Numero de Serie,3=IME1;4=IMEI1 e IMEI2
 
AADD(aProd,{'317180011101','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180011115','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180011118','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180011123','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180011122','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113521','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113519','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113518','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113522','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113625','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113619','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113621','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113618','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113622','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113602','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114224','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114230','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114229','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114228','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114227','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114226','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010315','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010301','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007701','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009201','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113319','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113318','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113323','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180112215','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008801','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008701','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010705','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008601','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180112319','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010518','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180112305','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010503','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180011015','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113322','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009601','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009701','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009501','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009401','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009101','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010424','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010415','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010406','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010402','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010815','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010802','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008501','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008401','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008301','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008201','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180114525','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010621','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010603','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010606','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010602','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008001','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007901','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007801','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113422','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113725','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008101','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113722','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180113702','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007601','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007501','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007401','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009001','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180008901','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180112201','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180112301','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180009301','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180011002','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180010905','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007201','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007301','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007218','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007223','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'317180007222','NECESSARIO IMEI 1 E IMEI 2'})
AADD(aProd,{'324270114615','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'323270114402','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'322270114302','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307150004301','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307100003620','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140002102','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'308040001902','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'308040004402','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'319230112001','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'422080022001','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'298010071101','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140004502','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140111601','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140111301','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306110010201','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306110004201','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140003801','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140002801','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306010004103','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306010004801','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306010004901','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306200005601','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306250113001','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306250113102','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307150003015','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306010004101','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307210114801','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307210114701','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307150111401','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307150003115','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307170113901','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307170114001','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307170113801','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307100009901','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307100010101','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307100010001','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307100003619','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'307100003201','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140004501','NECESSARIO NUMERO DE SERIE'})
AADD(aProd,{'306140111501','NECESSARIO NUMERO DE SERIE'})

RpcSetEnv("01","03")

SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD
cFilSB1:=xFilial("SB1")

For nInd:=1 To Len(aProd)

	If ! ( SB1->(DbSeek(cFilSB1+aProd[nInd,1])) .Or. SB1->(DbSeek(cFilSB1+"0"+aProd[nInd,1])) )
		Loop
	EndIf	
	 	   
	cTipoSerie:="4"   //1=Nao Necessario;2=Numero de Serie,3=IME1;4=IMEI1 e IMEI2
	
	If aProd[nInd,2]=='NECESSARIO NUMERO DE SERIE'
		cTipoSerie:="2"	 	
	EndIf
	
	SB1->(RecLock("SB1",.F.))
	SB1->B1_YSERIE:=cTipoSerie
	SB1->(MsUnLock())
Next                



Return


User Function B5YFRAN()
Local aProd:={}
Local nInd
Local cFilSB5

AADD(aProd,{'1201449541'})
AADD(aProd,{'1202549541'})
AADD(aProd,{'1202649541'})
AADD(aProd,{'1151449518'})
AADD(aProd,{'1152549518'})
AADD(aProd,{'1151349518'})
AADD(aProd,{'1152649518'})
AADD(aProd,{'1311449542'})
AADD(aProd,{'1311349542'})
AADD(aProd,{'1311449543'})
AADD(aProd,{'1311349543'})
AADD(aProd,{'1311449544'})
AADD(aProd,{'1311349544'})
AADD(aProd,{'1191403927'})
AADD(aProd,{'1191303927'})
AADD(aProd,{'1051649568'})
AADD(aProd,{'1051449535'})
AADD(aProd,{'1052549535'})
AADD(aProd,{'1051349535'})
AADD(aProd,{'1052649535'})
AADD(aProd,{'1011449044'})
AADD(aProd,{'1041349044'})
AADD(aProd,{'1041347851'})
AADD(aProd,{'1041449545'})
AADD(aProd,{'1311449546'})
AADD(aProd,{'1311349546'})
AADD(aProd,{'1041449547'})
AADD(aProd,{'1041349547'})
AADD(aProd,{'1051449538'})
AADD(aProd,{'1052549538'})
AADD(aProd,{'1051349538'})
AADD(aProd,{'1052649538'})
AADD(aProd,{'1171449548'})
AADD(aProd,{'1171349548'})
AADD(aProd,{'1171402048'})
AADD(aProd,{'1171449549'})
AADD(aProd,{'1171349549'})
AADD(aProd,{'423100021201'})
AADD(aProd,{'1171449550'})
AADD(aProd,{'1171349550'})
AADD(aProd,{'1171447728'})
AADD(aProd,{'1172549551'})
AADD(aProd,{'1172649551'})
AADD(aProd,{'1082649519'})
AADD(aProd,{'1311449552'})
AADD(aProd,{'1311349552'})
AADD(aProd,{'1311441435'})
AADD(aProd,{'1311347731'})
AADD(aProd,{'1311449149'})
AADD(aProd,{'1311449149'})
AADD(aProd,{'1171449553'})
AADD(aProd,{'1171349553'})
AADD(aProd,{'1441649567'})
AADD(aProd,{'1442349567'})
AADD(aProd,{'1442449567'})
AADD(aProd,{'1441449534'})
AADD(aProd,{'1442549534'})
AADD(aProd,{'1441349534'})
AADD(aProd,{'1442649534'})
AADD(aProd,{'1311449554'})
AADD(aProd,{'1311349554'})
AADD(aProd,{'1061449566'})
AADD(aProd,{'1062549566'})
AADD(aProd,{'1171449555'})
AADD(aProd,{'1082649565'})
AADD(aProd,{'1041449345'})
AADD(aProd,{'1042549345'})
AADD(aProd,{'1041349481'})
AADD(aProd,{'1041441610'})
AADD(aProd,{'1041449556'})
AADD(aProd,{'1041349556'})
AADD(aProd,{'1031449563'})
AADD(aProd,{'1032549563'})
AADD(aProd,{'1031349536'})
AADD(aProd,{'1032649536'})
AADD(aProd,{'1171449557'})
AADD(aProd,{'1171349557'})
AADD(aProd,{'1171403535'})
AADD(aProd,{'1171303535'})
AADD(aProd,{'1041449040'})
AADD(aProd,{'1311449558'})
AADD(aProd,{'1311349558'})
AADD(aProd,{'1312549559'})
AADD(aProd,{'1312649559'})
AADD(aProd,{'1311449560'})
AADD(aProd,{'1311349560'})
AADD(aProd,{'1201449561'})
AADD(aProd,{'1201349561'})
AADD(aProd,{'1082649537'})
AADD(aProd,{'1441449569'})
AADD(aProd,{'1442549569'})
AADD(aProd,{'1441349569'})
AADD(aProd,{'1442649569'})
AADD(aProd,{'1171449562'})
AADD(aProd,{'1172549562'})
AADD(aProd,{'1171349562'})
AADD(aProd,{'1172649562'})


RpcSetEnv("01","03")

SB5->(DbSetOrder(1))
cFilSB5:=xFilial("SB5")

For nInd:=1 To Len(aProd)

	If ! ( SB5->(DbSeek(cFilSB5+aProd[nInd,1])) .Or. SB5->(DbSeek(cFilSB5+"0"+aProd[nInd,1])) )
		Loop
	EndIf	
	
	SB5->(RecLock("SB5",.F.))
	SB5->B5_YFRANCH:="S"
	SB5->(MsUnLock())
Next                



Return
