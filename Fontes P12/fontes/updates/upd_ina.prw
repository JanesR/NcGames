#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ UPD_INA  บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de update dos dicionแrios para compatibiliza็ใo     ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ UPD_INA    - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function UPD_INA( cEmpAmb, cFilAmb )

Local   aSay      := {}
Local   aButton   := {}
Local   aMarcadas := {}
Local   cTitulo   := "ATUALIZAวรO DE DICIONมRIOS E TABELAS"
Local   cDesc1    := "Esta rotina tem como fun็ใo fazer  a atualiza็ใo  dos dicionแrios do Sistema ( SX?/SIX )"
Local   cDesc2    := "Este processo deve ser executado em modo EXCLUSIVO, ou seja nใo podem haver outros"
Local   cDesc3    := "usuแrios  ou  jobs utilizando  o sistema.  ษ extremamente recomendav้l  que  se  fa็a um"
Local   cDesc4    := "BACKUP  dos DICIONมRIOS  e da  BASE DE DADOS antes desta atualiza็ใo, para que caso "
Local   cDesc5    := "ocorra eventuais falhas, esse backup seja ser restaurado."
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
		If lAuto .OR. MsgNoYes( "Confirma a atualiza็ใo dos dicionแrios ?", cTitulo )
			oProcess := MsNewProcess():New( { | lEnd | lOk := FSTProc( @lEnd, aMarcadas ) }, "Atualizando", "Aguarde, atualizando ...", .F. )
			oProcess:Activate()

		If lAuto
			If lOk
				MsgStop( "Atualiza็ใo Realizada.", "UPD_INA" )
				dbCloseAll()
			Else
				MsgStop( "Atualiza็ใo nใo Realizada.", "UPD_INA" )
				dbCloseAll()
			EndIf
		Else
			If lOk
				Final( "Atualiza็ใo Concluํda." )
			Else
				Final( "Atualiza็ใo nใo Realizada." )
			EndIf
		EndIf

		Else
			MsgStop( "Atualiza็ใo nใo Realizada.", "UPD_INA" )

		EndIf

	Else
		MsgStop( "Atualiza็ใo nใo Realizada.", "UPD_INA" )

	EndIf

EndIf

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSTProc  บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da grava็ใo dos arquivos           ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSTProc    - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
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
		// So adiciona no aRecnoSM0 se a empresa for diferente
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
				MsgStop( "Atualiza็ใo da empresa " + aRecnoSM0[nI][2] + " nใo efetuada." )
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


			oProcess:IncRegua1( "Dicionแrio de arquivos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX2( @cTexto )


			FSAtuSX3( @cTexto )


			oProcess:IncRegua1( "Dicionแrio de ํndices" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSIX( @cTexto )

			oProcess:IncRegua1( "Dicionแrio de dados" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			oProcess:IncRegua2( "Atualizando campos/ํndices" )

			// Alteracao fisica dos arquivos
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
					MsgStop( "Ocorreu um erro desconhecido durante a atualiza็ใo da tabela : " + aArqUpd[nX] + ". Verifique a integridade do dicionแrio e da tabela.", "ATENวรO" )
					cTexto += "Ocorreu um erro desconhecido durante a atualiza็ใo da estrutura da tabela : " + aArqUpd[nX] + CRLF
				EndIf

				If cTopBuild >= "20090811" .AND. TcInternal( 89 ) == "CLOB_SUPPORTED"
					TcInternal( 25, "OFF" )
				EndIf

			Next nX


			oProcess:IncRegua1( "Dicionแrio de parโmetros" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX6( @cTexto )


			oProcess:IncRegua1( "Dicionแrio de gatilhos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX7( @cTexto )


			oProcess:IncRegua1( "Dicionแrio de consultas padrใo" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSXB( @cTexto )

			RpcClearEnv()

		Next nI

		If MyOpenSm0(.T.)

			cAux += Replicate( "-", 128 ) + CRLF
			cAux += Replicate( " ", 128 ) + CRLF
			cAux += "LOG DA ATUALIZACAO DOS DICIONมRIOS" + CRLF
			cAux += Replicate( " ", 128 ) + CRLF
			cAux += Replicate( "-", 128 ) + CRLF
			cAux += CRLF
			cAux += " Dados Ambiente" + CRLF
			cAux += " --------------------"  + CRLF
			cAux += " Empresa / Filial...: " + cEmpAnt + "/" + cFilAnt  + CRLF
			cAux += " Nome Empresa.......: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_NOMECOM", cEmpAnt + cFilAnt, 1, "" ) ) ) + CRLF
			cAux += " Nome Filial........: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_FILIAL" , cEmpAnt + cFilAnt, 1, "" ) ) ) + CRLF
			cAux += " DataBase...........: " + DtoC( dDataBase )  + CRLF
			cAux += " Data / Hora Inicio.: " + DtoC( Date() )  + " / " + Time()  + CRLF
			cAux += " Environment........: " + GetEnvServer()  + CRLF
			cAux += " StartPath..........: " + GetSrvProfString( "StartPath", "" )  + CRLF
			cAux += " RootPath...........: " + GetSrvProfString( "RootPath" , "" )  + CRLF
			cAux += " Versao.............: " + GetVersao(.T.)  + CRLF
			cAux += " Usuario TOTVS .....: " + __cUserId + " " +  cUserName + CRLF
			cAux += " Computer Name......: " + GetComputerName() + CRLF

			aInfo   := GetUserInfo()
			If ( nPos    := aScan( aInfo,{ |x,y| x[3] == ThreadId() } ) ) > 0
				cAux += " "  + CRLF
				cAux += " Dados Thread" + CRLF
				cAux += " --------------------"  + CRLF
				cAux += " Usuario da Rede....: " + aInfo[nPos][1] + CRLF
				cAux += " Estacao............: " + aInfo[nPos][2] + CRLF
				cAux += " Programa Inicial...: " + aInfo[nPos][5] + CRLF
				cAux += " Environment........: " + aInfo[nPos][6] + CRLF
				cAux += " Conexao............: " + AllTrim( StrTran( StrTran( aInfo[nPos][7], Chr( 13 ), "" ), Chr( 10 ), "" ) )  + CRLF
			EndIf
			cAux += Replicate( "-", 128 ) + CRLF
			cAux += CRLF

			cTexto := cAux + cTexto + CRLF

			cTexto += Replicate( "-", 128 ) + CRLF
			cTexto += " Data / Hora Final.: " + DtoC( Date() ) + " / " + Time()  + CRLF
			cTexto += Replicate( "-", 128 ) + CRLF

			cFileLog := MemoWrite( CriaTrab( , .F. ) + ".log", cTexto )

			Define Font oFont Name "Mono AS" Size 5, 12

			Define MsDialog oDlg Title "Atualizacao concluida." From 3, 0 to 340, 417 Pixel

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


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSAtuSX2 บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SX2 - Arquivos      ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSX2   - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FSAtuSX2( cTexto )
Local aEstrut   := {}
Local aSX2      := {}
Local cAlias    := ""
Local cEmpr     := ""
Local cPath     := ""
Local nI        := 0
Local nJ        := 0

cTexto  += "Inicio da Atualizacao" + " SX2" + CRLF + CRLF

aEstrut := { "X2_CHAVE"  , "X2_PATH"   , "X2_ARQUIVO", "X2_NOME"  , "X2_NOMESPA", "X2_NOMEENG", ;
             "X2_DELET"  , "X2_MODO"   , "X2_TTS"    , "X2_ROTINA", "X2_PYME"   , "X2_UNICO"  , ;
             "X2_MODOEMP", "X2_MODOUN" , "X2_MODULO" }

dbSelectArea( "SX2" )
SX2->( dbSetOrder( 1 ) )
SX2->( dbGoTop() )
cPath := SX2->X2_PATH
cPath := IIf( Right( AllTrim( cPath ), 1 ) <> "\", PadR( AllTrim( cPath ) + "\", Len( cPath ) ), cPath )
cEmpr := Substr( SX2->X2_ARQUIVO, 4 )

aAdd( aSX2, {'ZZ4',cPath,'ZZ4'+cEmpr,'LOG ENVIO WF INADIMPLENCIA','LOG ENVIO WF INADIMPLENCIA','LOG ENVIO WF INADIMPLENCIA',0,'E','','','','','E','E',0} )
aAdd( aSX2, {'ZZ5',cPath,'ZZ5'+cEmpr,'REGRA ENVIO WORKFLOW','REGRA ENVIO WORKFLOW','REGRA ENVIO WORKFLOW',0,'E','','','','','E','E',0} )
//
// Atualizando dicionแrio
//
oProcess:SetRegua2( Len( aSX2 ) )

dbSelectArea( "SX2" )
dbSetOrder( 1 )

For nI := 1 To Len( aSX2 )

	oProcess:IncRegua2( "Atualizando Arquivos (SX2)..." )

	If !SX2->( dbSeek( aSX2[nI][1] ) )

		If !( aSX2[nI][1] $ cAlias )
			cAlias += aSX2[nI][1] + "/"
			cTexto += "Foi incluํda a tabela " + aSX2[nI][1] + CRLF
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

			cTexto += "Foi alterada chave unica da tabela " + aSX2[nI][1] + CRLF
		EndIf

	EndIf

Next nI

cTexto += CRLF + "Final da Atualizacao" + " SX2" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSAtuSX3 บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SX3 - Campos        ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSX3   - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
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
Local nSeqAtu   := 0
Local nTamSeek  := Len( SX3->X3_CAMPO )

cTexto  += "Inicio da Atualizacao" + " SX3" + CRLF + CRLF

aEstrut := { "X3_ARQUIVO", "X3_ORDEM"  , "X3_CAMPO"  , "X3_TIPO"   , "X3_TAMANHO", "X3_DECIMAL", ;
             "X3_TITULO" , "X3_TITSPA" , "X3_TITENG" , "X3_DESCRIC", "X3_DESCSPA", "X3_DESCENG", ;
             "X3_PICTURE", "X3_VALID"  , "X3_USADO"  , "X3_RELACAO", "X3_F3"     , "X3_NIVEL"  , ;
             "X3_RESERV" , "X3_CHECK"  , "X3_TRIGGER", "X3_PROPRI" , "X3_BROWSE" , "X3_VISUAL" , ;
             "X3_CONTEXT", "X3_OBRIGAT", "X3_VLDUSER", "X3_CBOX"   , "X3_CBOXSPA", "X3_CBOXENG", ;
             "X3_PICTVAR", "X3_WHEN"   , "X3_INIBRW" , "X3_GRPSXG" , "X3_FOLDER" , "X3_PYME"   }

aAdd( aSX3, {'ZZ4','01','ZZ4_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,	Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','',''} )
aAdd( aSX3, {'ZZ4','02','ZZ4_CANAL','C',6,0,'Canal','Canal','Canal','Canal','Canal','Canal','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','03','ZZ4_DESCAN','C',30,0,'Desc. Canal','Desc. Canal','Desc. Canal','Descri็ใo do Canal','Descri็ใo do Canal','Descri็ใo do Canal','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'IF(!INCLUI,POSICIONE("ACA",1,XFILIAL("ACA")+ ZZ4->ZZ4_CANAL,"ACA_DESCRI"),"")','',0,	Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','04','ZZ4_CLIENT','C',6,0,'Cliente','Cliente','Cliente','Cliente','Cliente','Cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','05','ZZ4_LOJA','C',2,0,'Loja','Loja','Loja','Loja','Loja','Loja','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','06','ZZ4_NOMCLI','C',30,0,'Nome Cliente','Nome Cliente','Nome Cliente','Nome Cliente','Nome Cliente','Nome Cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','07','ZZ4_PREFIX','C',3,0,'Prefixo','Prefixo','Prefixo','Prefixo','Prefixo','Prefixo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','08','ZZ4_NUM','C',9,0,'No. Titulo','No. Titulo','No. Titulo','Numero do Titulo','Numero do Titulo','Numero do Titulo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','09','ZZ4_PARCEL','C',1,0,'Parcela','Parcela','Parcela','Parcela','Parcela','Parcela','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','10','ZZ4_TIPOWF','C',2,0,'WorkFlow','WorkFlow','WorkFlow','WorkFlow','WorkFlow','WorkFlow','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','11','ZZ4_DTENVI','D',8,0,'Data Envio','Data Envio','Data Envio','Data Envio','Data Envio','Data Envio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','12','ZZ4_HORA','C',8,0,'Hora Envio','Hora Envio','Hora Envio','Hora Envio','Hora Envio','Hora Envio','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ4','13','ZZ4_MENSAG','C',300,0,'Mensagem','Mensagem','Mensagem','Mensagem','Mensagem','Mensagem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','01','ZZ5_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,	Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','',''} )
aAdd( aSX3, {'ZZ5','02','ZZ5_WF','C',2,0,'WorkFlow','WorkFlow','WorkFlow','WorkFlow','WorkFlow','WorkFlow','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','Z+',0,	Chr(254) + Chr(192),'','S','U','S','A','R','€','NaoVazio() .And. ExistCpo(' + SIMPLES + 'SX5' + SIMPLES + ',' + DUPLAS  + 'Z+' + DUPLAS  + ' + M->ZZ5_WF,1) .And. ExistChav(' + DUPLAS  + 'ZZ5' + DUPLAS  + ',M->ZZ5_WF+' + DUPLAS  + '0' + DUPLAS  + ',1)','','','','','INCLUI','','','',''} )
aAdd( aSX3, {'ZZ5','03','ZZ5_DESCWF','C',30,0,'Descricao','Descricao','Descricao','Descricao','Descricao','Descricao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'IF(!INCLUI,TABELA("Z+",M->ZZ5_WF),"")','',0,	Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','TABELA("Z+",ZZ5->ZZ5_WF)','','',''} )
aAdd( aSX3, {'ZZ5','04','ZZ5_CANAL','C',6,0,'Canal','Canal','Canal','Canal','Canal','Canal','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','ACA',0,	Chr(254) + Chr(192),'','S','U','N','A','R','','Vazio() .Or. ExistCpo("ACA",M->ZZ5_CANAL)','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','05','ZZ5_HTMARQ','C',200,0,'Nome HTML','Nome HTML','Nome HTML','Nome HTML','Nome HTML','Nome HTML','@s40','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','WFINAD',0,	Chr(254) + Chr(65),'','','U','N','A','R','€','','','','','','!Empty(M->ZZ5_WF) .And. INCLUI','','','',''} )
aAdd( aSX3, {'ZZ5','06','ZZ5_DESCAN','C',30,0,'Desc. Canal','Desc. Canal','Desc. Canal','Desc. Canal','Desc. Canal','Desc. Canal','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'IF(!INCLUI,POSICIONE("ACA",1,XFILIAL("ACA")+ ZZ5->ZZ5_CANAL,"ACA_DESCRI"),"")','',0,	Chr(254) + Chr(192),'','','U','N','V','V','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','07','ZZ5_CLIENT','C',6,0,'Cliente','Cliente','Cliente','Cliente','Cliente','Cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SA1',0,	Chr(254) + Chr(192),'','','U','N','A','R','','U_R702VAL()','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','08','ZZ5_LOJA','C',2,0,'Loja','Loja','Loja','Loja','Loja','Loja','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','N','A','R','','U_R702VAL()','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','09','ZZ5_NOMCLI','C',30,0,'Nome','Nome','Nome','Nome','Nome','Nome','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'IF(!INCLUI,POSICIONE("SA1",1,XFILIAL("SA1")+ ZZ5->(ZZ5_CLIENT+Alltrim(ZZ5_LOJA)),"A1_NREDUZ"),"")','',0,	Chr(254) + Chr(192),'','','U','N','V','V','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','10','ZZ5_FLAG','C',1,0,'Flag','Flag','Flag','Flag','Flag','Flag','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,	Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','11','ZZ5_EMAIL','C',40,0,'E-mail','E-mail','E-mail','E-mail','E-mail','E-mail','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','12','ZZ5_DIAS','N',4,0,'Dia p/ Venc.','Dia p/ Venc.','Dia p/ Venc.','Dia para o  vencimento','Dia para o  vencimento','Dia para o  vencimento','@E 9,999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,	Chr(254) + Chr(192),'','','U','N','A','R','','Positivo()','','','','','','','','',''} )
aAdd( aSX3, {'ZZ5','13','ZZ5_SITUAC','C',1,0,'Situa็ใo','Situa็ใo','Situa็ใo','Situa็ใo','Situa็ใo','Situa็ใo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'"1"','',0,	Chr(254) + Chr(192),'','','U','N','A','R','','Pertence("12")','1=Antes do Vencimento;2=Depois do Vencimento','','','','','','','',''} )
//
// Atualizando dicionแrio
//

nPosArq := aScan( aEstrut, { |x| AllTrim( x ) == "X3_ARQUIVO" } )
nPosOrd := aScan( aEstrut, { |x| AllTrim( x ) == "X3_ORDEM"   } )
nPosCpo := aScan( aEstrut, { |x| AllTrim( x ) == "X3_CAMPO"   } )
nPosTam := aScan( aEstrut, { |x| AllTrim( x ) == "X3_TAMANHO" } )
nPosSXG := aScan( aEstrut, { |x| AllTrim( x ) == "X3_GRPSXG"  } )

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
				cTexto += "O tamanho do campo " + aSX3[nI][nPosCpo] + " nao atualizado e foi mantido em ["
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

	Else

		//
		// Verifica se o campo faz parte de um grupo e ajsuta tamanho
		//
		If !Empty( SX3->X3_GRPSXG ) .AND. SX3->X3_GRPSXG <> aSX3[nI][nPosSXG]
			SXG->( dbSetOrder( 1 ) )
			If SXG->( MSSeek( SX3->X3_GRPSXG ) )
				If aSX3[nI][nPosTam] <> SXG->XG_SIZE
					aSX3[nI][nPosTam] := SXG->XG_SIZE
					cTexto +=  "O tamanho do campo " + aSX3[nI][nPosCpo] + " nao atualizado e foi mantido em ["
					cTexto += AllTrim( Str( SXG->XG_SIZE ) ) + "]"+ CRLF
					cTexto +=  "   por pertencer ao grupo de campos [" + SX3->X3_GRPSXG + "]" + CRLF + CRLF
				EndIf
			EndIf
		EndIf

		//
		// Verifica todos os campos
		//
		For nJ := 1 To Len( aSX3[nI] )

			//
			// Se o campo estiver diferente da estrutura
			//
			If aEstrut[nJ] == SX3->( FieldName( nJ ) ) .AND. ;
				PadR( StrTran( AllToChar( SX3->( FieldGet( nJ ) ) ), " ", "" ), 250 ) <> ;
				PadR( StrTran( AllToChar( aSX3[nI][nJ] )           , " ", "" ), 250 ) .AND. ;
				AllTrim( SX3->( FieldName( nJ ) ) ) <> "X3_ORDEM"

				cMsg := "O campo " + aSX3[nI][nPosCpo] + " estแ com o " + SX3->( FieldName( nJ ) ) + ;
				" com o conte๚do" + CRLF + ;
				"[" + RTrim( AllToChar( SX3->( FieldGet( nJ ) ) ) ) + "]" + CRLF + ;
				"que serแ substituido pelo NOVO conte๚do" + CRLF + ;
				"[" + RTrim( AllToChar( aSX3[nI][nJ] ) ) + "]" + CRLF + ;
				"Deseja substituir ? "

				If      lTodosSim
					nOpcA := 1
				ElseIf  lTodosNao
					nOpcA := 2
				Else
					nOpcA := Aviso( "ATUALIZAวรO DE DICIONมRIOS E TABELAS", cMsg, { "Sim", "Nใo", "Sim p/Todos", "Nใo p/Todos" }, 3, "Diferen็a de conte๚do - SX3" )
					lTodosSim := ( nOpcA == 3 )
					lTodosNao := ( nOpcA == 4 )

					If lTodosSim
						nOpcA := 1
						lTodosSim := MsgNoYes( "Foi selecionada a op็ใo de REALIZAR TODAS altera็๕es no SX3 e NรO MOSTRAR mais a tela de aviso." + CRLF + "Confirma a a็ใo [Sim p/Todos] ?" )
					EndIf

					If lTodosNao
						nOpcA := 2
						lTodosNao := MsgNoYes( "Foi selecionada a op็ใo de NรO REALIZAR nenhuma altera็ใo no SX3 que esteja diferente da base e NรO MOSTRAR mais a tela de aviso." + CRLF + "Confirma esta a็ใo [Nใo p/Todos]?" )
					EndIf

				EndIf

				If nOpcA == 1
					cTexto += "Alterado o campo " + aSX3[nI][nPosCpo] + CRLF
					cTexto += "   " + PadR( SX3->( FieldName( nJ ) ), 10 ) + " de [" + AllToChar( SX3->( FieldGet( nJ ) ) ) + "]" + CRLF
					cTexto += "            para [" + AllToChar( aSX3[nI][nJ] )          + "]" + CRLF + CRLF

					RecLock( "SX3", .F. )
					FieldPut( FieldPos( aEstrut[nJ] ), aSX3[nI][nJ] )
					dbCommit()
					MsUnLock()
				EndIf

			EndIf

		Next

	EndIf

	oProcess:IncRegua2( "Atualizando Campos de Tabelas (SX3)..." )

Next nI

cTexto += CRLF + "Final da Atualizacao" + " SX3" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSAtuSIX บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SIX - Indices       ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSIX   - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FSAtuSIX( cTexto )
Local aEstrut   := {}
Local aSIX      := {}
Local lAlt      := .F.
Local lDelInd   := .F.
Local nI        := 0
Local nJ        := 0

cTexto  += "Inicio da Atualizacao" + " SIX" + CRLF + CRLF

aEstrut := { "INDICE" , "ORDEM" , "CHAVE", "DESCRICAO", "DESCSPA"  , ;
             "DESCENG", "PROPRI", "F3"   , "NICKNAME" , "SHOWPESQ" }

aAdd( aSIX, {'ZZ4','1','ZZ4_FILIAL+ZZ4_CLIENT+ZZ4_LOJA+ZZ4_DTENVI','Cliente+Loja+Data Envio','Cliente+Loja+Data Envio','Cliente+Loja+Data Envio','U','','','N'} )
aAdd( aSIX, {'ZZ5','1','ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG','WorkFlow+Flag','WorkFlow+Flag','WorkFlow+Flag','U','','','S'} )
aAdd( aSIX, {'ZZ5','2','ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG+ZZ5_CANAL','WorkFlow+Flag+Canal','WorkFlow+Flag+Canal','WorkFlow+Flag+Canal','U','','','N'} )
//
// Atualizando dicionแrio
//
oProcess:SetRegua2( Len( aSIX ) )

dbSelectArea( "SIX" )
SIX->( dbSetOrder( 1 ) )

For nI := 1 To Len( aSIX )

	lAlt    := .F.
	lDelInd := .F.

	If !SIX->( dbSeek( aSIX[nI][1] + aSIX[nI][2] ) )
		cTexto += "อndice criado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] + CRLF
	Else
		lAlt := .T.
		aAdd( aArqUpd, aSIX[nI][1] )
		If !StrTran( Upper( AllTrim( CHAVE )       ), " ", "") == ;
		    StrTran( Upper( AllTrim( aSIX[nI][3] ) ), " ", "" )
			cTexto += "Chave do ํndice alterado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] + CRLF
			lDelInd := .T. // Se for alteracao precisa apagar o indice do banco
		Else
			cTexto += "Indice alterado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] + CRLF
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

	oProcess:IncRegua2( "Atualizando ํndices..." )

Next nI

cTexto += CRLF + "Final da Atualizacao" + " SIX" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSAtuSX6 บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SX6 - Parโmetros    ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSX6   - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
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

cTexto  += "Inicio da Atualizacao" + " SX6" + CRLF + CRLF

aEstrut := { "X6_FIL"    , "X6_VAR"  , "X6_TIPO"   , "X6_DESCRIC", "X6_DSCSPA" , "X6_DSCENG" , "X6_DESC1"  , "X6_DSCSPA1",;
             "X6_DSCENG1", "X6_DESC2", "X6_DSCSPA2", "X6_DSCENG2", "X6_CONTEUD", "X6_CONTSPA", "X6_CONTENG", "X6_PROPRI" , "X6_PYME" }

aAdd( aSX6, {'  ','DBM_DTFCES','N','Data de Fechamento comissใo Canal Regional','Data de Fechamento comissใo Canal Regional','Data de Fechamento comissใo Canal Regional','','','','','','','10','10','10','U',''} )
aAdd( aSX6, {'  ','DBM_DTFCKA','N','Data de Fechamento comissใo Canal Regional','Data de Fechamento comissใo Canal Regional','Data de Fechamento comissใo Canal Regional','','','','','','','15','15','15','U',''} )
aAdd( aSX6, {'  ','DBM_DTUCA1','C','Data Ultima compra a ser considerado Relat๓rio ind','Data Ultima compra a ser considerado Relat๓rio ind','Data Ultima compra a ser considerado Relat๓rio ind','icadores','icadores','icadores','','','','20110101','20110101','20110101','U',''} )
aAdd( aSX6, {'  ','DBM_ESPACC','C','Grupo Especializado','Grupo Especializado','Grupo Especializado','','','','','','','000002','000002','000001','U',''} )
aAdd( aSX6, {'  ','DBM_ESPGR1','C','Grupo Clientes Especializado','Grupo Clientes Especializado','Grupo Clientes Especializado','','','','','','','000009','000009','000009','U',''} )
aAdd( aSX6, {'  ','DBM_ESPGRP','C','Grupo Clientes Especializado','Grupo Clientes Especializado','Grupo Clientes Especializado','','','','','','','000002','000002','000002','U',''} )
aAdd( aSX6, {'  ','DBM_GRPVI2','C','Grupo de venda interna2','Grupo de venda interna2','Grupo de venda interna2','','','','','','','000007','000007','000007','U',''} )
aAdd( aSX6, {'  ','DBM_GRPVIN','C','Grupo de venda interna','Grupo de venda interna','Grupo de venda interna','','','','','','','000006','000003','000003','U',''} )
aAdd( aSX6, {'  ','DBM_KEYACC','C','Grupo Key Account','Grupo Key Account','Grupo Key Account','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','DBM_LMARK','N','','','','','','','','','','2.2','2.2','2.2','U',''} )
aAdd( aSX6, {'  ','DBM_RCOMNO','N','Percentual comissใo Cana Regional','Percentual comissใo Cana Regional','Percentual comissใo Cana Regional','','','','','','','3','3','3','U',''} )
aAdd( aSX6, {'  ','DBM_RCOMSV','N','Percentual de comissใo Canal Regional Super Varejo','Percentual de comissใo Canal Regional Super Varejo','Percentual de comissใo Canal Regional Super Varejo','','','','','','','1','1','1','U',''} )
aAdd( aSX6, {'  ','DBM_REMAIL','C','E-mails para envio da previa de vendas','E-mails para envio da previa de vendas','E-mails para envio da previa de vendas','','','','','','','apaula@ncgames.com.br;eramiro@ncgames.com.br;cmacedo@ncgames.com.br;dborges@ncgames.com.br;dnobre@ncgames.com.br;rciambarella@ncgames.com.br;dsapata@ncgames.com.br;lbrim@ncgames.com.br;mpadua@ncgames.com.br;ebrito@ncgames.com.br;','apaula@ncgames.com.br;eramiro@ncgames.com.br;cmacedo@ncgames.com.br;dborges@ncgames.com.br;roliveira@ncgames.com.br;dnobre@ncgames.com.br;rciambarella@ncgames.com.br;dsapata@ncgames.com.br;lbrim@ncgames.com.br;','apaula@ncgames.com.br;eramiro@ncgames.com.br;cmacedo@ncgames.com.br;dborges@ncgames.com.br;roliveira@ncgames.com.br;dnobre@ncgames.com.br;rciambarella@ncgames.com.br;dsapata@ncgames.com.br;lbrim@ncgames.com.br;','U','S'} )
aAdd( aSX6, {'  ','DBM_SUPERV','C','Grupo Clientes SuperVarejo','Grupo Clientes SuperVarejo','Grupo Clientes SuperVarejo','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','DB_COPMAIL','C','Copia oculta de previa de venda','','','','','','','','','cmacedo@ncgames.com.br;dsilva@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','DB_REMAIL1','C','E-mails para envio da previa de vendas 1','','','','','','','','','rvaz@ncgames.com.br;scussuara@ncgames.com.br;admvendas@ncgames.com.br;nhirano@ncgames.com.br;wtessari@ncgames.com.br;lfelipe@ncgames.com.br;tfernandes@ncgames.com.br;','rvaz@ncgames.com.br;ebuttner@ncgames.com.br;scussuara@ncgames.com.br;rjesus@ncgames.com.br;nhirano@ncgames.com.br;soliveira@ncgames.com.br;lfelipe@ncgames.com.br;','rvaz@ncgames.com.br;ebuttner@ncgames.com.br;scussuara@ncgames.com.br;rjesus@ncgames.com.br;nhirano@ncgames.com.br;soliveira@ncgames.com.br;lfelipe@ncgames.com.br;dsilva@ncgames.com.br;','U',''} )
aAdd( aSX6, {'  ','DB_REMAIL2','C','E-mails para envio da previa de vendas 2','','','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','KZ_ALTENV','C','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','os arquivos de altera็ใo pela Neogrid.','os arquivos de altera็ใo pela Neogrid.','os arquivos de altera็ใo pela Neogrid.','','','','\ncgames\receipt','\ncgames\receipt','\ncgames\receipt','U',''} )
aAdd( aSX6, {'  ','KZ_ALTPROC','C','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','os arquivos Altera็ใo processados pelo sistema','os arquivos Altera็ใo processados pelo sistema','os arquivos Altera็ใo processados pelo sistema','','','','\ncgames\dispatch\esc','\ncgames\dispatch\esc','\ncgames\dispatch\esc','U',''} )
aAdd( aSX6, {'  ','KZ_EDIENV','C','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','os arquivos enviados pela Neogrid.','os arquivos enviados pela Neogrid.','os arquivos enviados pela Neogrid.','','','','\ncgames\receipt','\ncgames\receipt','\ncgames\receipt','U',''} )
aAdd( aSX6, {'  ','KZ_EDIPROC','C','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','Informe o caminho onde serแ disponibilizado','os arquivos EDI processados pelo sistema','os arquivos EDI processados pelo sistema','os arquivos EDI processados pelo sistema','','','','\ncgames\dispatch\esc','\ncgames\dispatch\esc','\ncgames\dispatch\esc','U',''} )
aAdd( aSX6, {'  ','KZ_EXCALT','C','INFORMAR OS CAMPOS QUE TERรO EXCEวรO DE ALTERAวรO','','','NA TELA DE PEDIDO EDI, CAMPOS DOS ITENS','','','','','','ZAF_UM;ZAF_UNID2;ZAF_LOCAL;ZAF_DTENT;ZAF_QTD;ZAF_QTD2;ZAF_PRCUNI','ZAF_UM;ZAF_UNID2;ZAF_LOCAL;ZAF_DTENT;ZAF_QTD;ZAF_QTD2','ZAF_UM;ZAF_UNID2;ZAF_LOCAL;ZAF_DTENT;ZAF_QTD;ZAF_QTD2','U',''} )
aAdd( aSX6, {'  ','KZ_EXCCAB','C','INFORMAR OS CAMPOS QUE TERรO EXCEวรODE ALTERAวรO N','','','A TELA DO PEDIDO EDI, CAMPOS DO CABECALHO','','','','','','ZAE_TRANSP;ZAE_OBSNF','ZAE_TRANSP;ZAE_OBSNF','ZAE_TRANSP;ZAE_OBSNF','U',''} )
aAdd( aSX6, {'  ','KZ_INVFLD','C','Diretorio de gravacao das Invoices','Diretorio de gravacao das Invoices','Diretorio de gravacao das Invoices','','','','','','','\ncgames\dispatch','\ncgames\dispatch','\ncgames\dispatch','U',''} )
aAdd( aSX6, {'  ','KZ_MAILRES','C','Endere็o de E-mail dos Responsaveis da area','Endere็o de E-mail dos Responsaveis da area','Endere็o de E-mail dos Responsaveis da area','Separados por ";" (ponto e vํrgula)','Separados por ";" (ponto e vํrgula)','Separados por ";" (ponto e vํrgula)','','','','admvendas@ncgames.com.br','admvendas@ncgames.com.br','admvendas@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','KZ_PARCMIN','N','Parcela mํnima','Parcela mํnima','Parcela mํnima','','','','','','','500','500','500','U',''} )
aAdd( aSX6, {'  ','MV_ALMOX','C','','','','','','','','','','01/02/03/04/05/07/08/11/CV/99/06/98/31/95/XX','01/02/03/04/05/07/08','01/02/03/04/05/07/08','U',''} )
aAdd( aSX6, {'  ','MV_ARMWMAS','C','ARMAAZENS CONTROLADOS PELO SISTEMA STORE WMAS','','','','','','','','','01/02/03/06/51/31/04/32/33','01/02/03/06/51','01/02/03/06/51','U',''} )
aAdd( aSX6, {'  ','MV_AVG0175','C','Diretorio onde sera criado o arquivo TXT de','Directorio donde se creara el archivo TXT de','Directory in which TXT file of Fiscal','Integra็ใo Fiscal.','Integracion Fiscal.','Integration will be created.','','','','','','','U','N'} )
aAdd( aSX6, {'  ','MV_AVG0176','C','Ambiente responsavel por enviar as transacoes','Entorno responsable por enviar las transacciones','Environment that sends transactions','(Ex: Client 100, Client 200 etc)','(Ej: Client 100, Client 200 etc)','(Ex: Client 100, Client 200 etc).','','','','','','','U','N'} )
aAdd( aSX6, {'  ','MV_AVG0186','L','Define se as informa็๕es da Proforma virใo da','Define si informaciones de Pro forma vendran de la','It defines if Proforma information is from','tabela de proformas ou capa do Purchase Order','tabla de pro formas o portada del Purchase Order','proforma table or Purchase Order cover','','','','.F.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','MV_BLQPROD','C','Parametro que controla o acesso aos produtos','','','bloqueados para venda. Deverใo ser incluidos todos','','','os Consultores de vendas.','','','ANUNES/RCOSTA/LGALLI/ROGERIO/CPASSOS/AMOTA/EGARCIA/MPRUDENCIO/IMARTINS/LVASQUES/BSAMPAIO/JGEORGE/MSILVA/JMARQUEZINI/ROLIVEIRA/CMASIERO/ERAMIRO/DNOBRE/SUPERTECH/CFONSECA/NAIRES/RCOSTA/RMORAES/ROLIVEIRA','','','U',''} )
aAdd( aSX6, {'  ','MV_DESCFIN','C','Indica se o desconto financeiro sera aplicado inte','Indica si el descuento financiero se aplicara','It indicates whether the financial deduction is to','gral ("I") no primeiro pagamento, ou proporcional','integral  ("I") en el primer pago o proporcional','be paid fully (F) on the first payment or','("P") ao valor pago en cada parcela.','("P") al valor pagado en cada cuota.','proportional (P) to the amt. paid on each installm','I','I','I','U',''} )
aAdd( aSX6, {'  ','MV_DTAPURA','D','Data da ultima apuracao dos impostos','Data da ultima apuracao dos impostos','Data da ultima apuracao dos impostos','','','','','','','01/08/2009','30/04/2010','30/04/2010','U',''} )
aAdd( aSX6, {'  ','MV_ENVFAT','C','Endere็os de E-mail Utilizados na Rotina de Libera','','','็ใo de Pedidos Para Faturamento','','','','','','rodrigo@stch.com.br;jisidoro@ncgames.com.br;','','csantos@ncgames.com.br;jalves@ncgames.com.br; snunes@ncgames.com.br;farias@ncgames.com.br;wsilva@ncgames.com.br;madriano@ncgames.com.br','U',''} )
aAdd( aSX6, {'  ','MV_ENVFAT1','C','Endere็os de E-mail Utilizados na Rotina de Libera','','','็ใo de Pedidos Para Faturamento','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','MV_ESTETIQ','C','LIBERAวรO DE ACESSO A ESTORNO DE ETIQUETA DE NOTA','','','FISCAL','','','','','','EBRITO/ANETTO/NREIS/DOLIVEIRA/EBUTTNER/RCIAMBARELLA/SNUNES','','','U',''} )
aAdd( aSX6, {'  ','MV_ESTPICK','C','LIBERAวรO DE ESTORNO DE PICK LIST','','','','','','','','','EBUTTNER/RCIAMBARELLA/RSOUZA/csantos/SOLIVEIRA/FARIAS/WSILVA/MADRIANO','','','U',''} )
aAdd( aSX6, {'  ','MV_FINATFN','C','"1" = Fluxo Caixa On-Line,"2" = Fluxo Caixa Off-Li','','','ne','','','','','','1','1','1','U',''} )
aAdd( aSX6, {'  ','MV_IMPSB1','C','','','','','','','','','','BOLIVEIRA','','','U',''} )
aAdd( aSX6, {'  ','MV_INCREM','N','PARAMETRO UTILIZADO PARA INCREMENTAR A NUMERACAO D','','','O CNAB','','','','','','1','1','1','U',''} )
aAdd( aSX6, {'  ','MV_INC_PAG','C','Usuarios com permissao para movimentacao completa','Usuarios com permissao para movimentacao completa','Usuarios com permissao para movimentacao completa','no contas a pagar.','no contas a pagar.','no contas a pagar.','no contas a pagar.','','','agoncalves\rvelame\jalves\rsouza\lfelipe\marruda\rrocha\ksalha\RSOUZA\dbmsystem','agoncalves\rvelame\jalves\rsouza\lfelipe\marruda\rrocha\ksalha','agoncalves\rvelame\jalves\rsouza\lfelipe\marruda\rrocha\ksalha','U',''} )
aAdd( aSX6, {'  ','MV_INSDIPJ','C','Define o c๓digo da reten็ใo do INSS, gerar a DIPJ.','Define el codigo de retenc. del INSS, gerar DIPJ.','Establishes INSS withholding code, gen. DIPJ.','','','','','','','2100','','','U',''} )
aAdd( aSX6, {'  ','MV_ITEMCTA','C','ITEM CONTA PARA O PROJETO PCO','','','','','','','','','1111/1112/1212/1311/1313/1314/1319','','','U',''} )
aAdd( aSX6, {'  ','MV_ITNUM','N','QUANTIDADE DE ITENS PARA IMPRESSรO DE PICK LIST','','','','','','','','','80','','','U',''} )
aAdd( aSX6, {'  ','MV_LJLVFIS','N','Define se utiliza novo conceito para geracao SF3','Define si utiliza nuevo concepto para generac. SF3','Defines if new concept for SF3 generation is used','1= conceito antigo, 2= conceito novo','1= concepto antiguo, 2= concepto nuevo','1= old concept, 2= new concept','','','','2','','','U',''} )
aAdd( aSX6, {'  ','MV_LJTPDES','C','Tipo de desconto que serแ aplicado: 0=Default','Tipo de descuento que se aplicarแ: 0=Default','Tipo de desconto que serแ aplicado: 0=Default','1=Aplica็ใo do desconto no valor unitแrio','1= Aplicaci๓n de descuento en el valor unitario','1=Aplica็ใo do desconto no valor unitแrio','2=Cons. Desconto mais de duas casas decimais','2=Cons.Descuento mแs de dos casas decimales.','2=Cons. Desconto mais de duas casas decimais','1','1','1','U',''} )
aAdd( aSX6, {'  ','MV_MAXITPV','N','Quantidade Maxima','Quantidade Maxima','Quantidade Maxima','','','','','','','80','40','40','U',''} )
aAdd( aSX6, {'  ','MV_MNTTAB','C','Usuแrios que podem usar rotina de manuten็ใo de','','','tabela de pre็os via importa็ใo do excel','','','','','','LCARVALHO/EBUTTNER/LFELIPE/SOLIVEIRA','EMARIA/RRIBEIRO/WMELO/DSATYRO','EMARIA/RRIBEIRO/WMELO/DSATYRO','U',''} )
aAdd( aSX6, {'  ','MV_MUDATRT','L','Indica se devera alterar o nome fํsico das tabelas','Indica si se modifica el nombre fisico de tablas','It indicates if physical name of temporary tables','temporarias utilizadas nas SPs T=Alterar F=Nใo','temporarias utilizadas en las SP T=Modifica F=No','used in SPs must be changed.  T=Change F=Do Not','Alterar','Modificar','Change','.T.','.T.','.T.','U',''} )
aAdd( aSX6, {'  ','MV_NCAPTAB','C','Parโmetro com d๓digo do usuแrio que poderแ','','','aprovar/rejeitar a tabela de pre็o intermediแria','','','','','','000307','000307','000307','U',''} )
aAdd( aSX6, {'  ','MV_NCBANCO','C','Banco * Agencia # Conta Corrente','Banco * Agencia # Conta Corrente','Banco * Agencia # Conta Corrente','','','','','','','237*2332-9#777-3','237*2332-9#777-3','237*2332-9#777-3','U',''} )
aAdd( aSX6, {'  ','MV_NCGAMES','C','Codigos de NCM com incentivo de base reduzida','','Codigos de NCM com incentivo de base reduzida','','Codigos de NCM com incentivo de base reduzida','','','','','0000000','0000000','0000000','U',''} )
aAdd( aSX6, {'  ','MV_NCHRES','N','Horas que permanecera a reserva do pedido de venda','Horas que permanecera a reserva do pedido de venda','Horas que permanecera a reserva do pedido de venda','Apos essas horas sera excluida a reserva.','Apos essas horas sera excluida a reserva.','Apos essas horas sera excluida a reserva.','Ex. 36','Ex. 36','Ex. 36','36','','','U',''} )
aAdd( aSX6, {'  ','MV_NCMKPPV','N','MarkUp minimo para pedido de venda.','MarkUp minimo para pedido de venda.','MarkUp minimo para pedido de venda.','','','','','','','5.00','5.00','5.00','U',''} )
aAdd( aSX6, {'  ','MV_NCRESER','C','Condicoes de pagamento para geracao automatica','Condicoes de pagamento para geracao automatica','Condicoes de pagamento para geracao automatica','de reserva para os itens do pedido de venda.','de reserva para os itens do pedido de venda.','de reserva para os itens do pedido de venda.','Ex.: 027/028/029','Ex.: 027/028/029','Ex.: 027/028/029','027/028/029','027/028/029','027/028/029','U',''} )
aAdd( aSX6, {'  ','MV_NCTABPR','C','Tabelas a serem utilizadas para Pre็os','','','','','','','','','004;005;007;012;018;056;304;318;404;418;504;518;604;618','004;005;007;012;018;056;304;318;404;418;504;518;604;618;199','004;005;007;012;018;056;304;318;404;418;504;518;604;618','U',''} )
aAdd( aSX6, {'  ','MV_NCUSRLB','C','Usuarios permitidos para liberacao de itens de ped','Usuarios permitidos para liberacao de itens de ped','Usuarios permitidos para liberacao de itens de ped','ido de venda que ultrapassam o lvr. de desconto es','ido de venda que ultrapassam o lvr. de desconto es','ido de venda que ultrapassam o lvr. de desconto es','pecificado no grupo de produtos ou cadastro de cli','pecificado no grupo de produtos ou cadastro de cli','pecificado no grupo de produtos ou cadastro de cli','CMACEDO/RCIAMBARELLA/RJESUS/LFELIPE/LRIBEIRO/ISENA/dbmsystem/RSOUZA','CMACEDO/RCIAMBARELLA/RJESUS/LFELIPE/LRIBEIRO/ISENA','CMACEDO/RCIAMBARELLA/RJESUS/LFELIPE/LRIBEIRO/ISENA','U',''} )
aAdd( aSX6, {'  ','MV_NCVLRSC','N','Valor total para solicitacoes de compras que nao','','','serao Bloqueadas','','','','','','1500.00','','','U',''} )
aAdd( aSX6, {'  ','MV_NFECAEV','L','Ativar Cancelamento de NF-e como Evento:','','','T = Sim ou F = Nใo.','','','','','','T','','','U',''} )
aAdd( aSX6, {'  ','MV_PROCSP','L','Indica se a manuten็ใo de stored procedures serแ','','','realizada por processo (.T. = Sim / .F. = Nใo)','','','','','','.T.','.T.','.T.','U',''} )
aAdd( aSX6, {'  ','MV_PZREZER','N','Prazo padrao de validade das reservas (em dias).','','','','','','','','','1','','','U',''} )
aAdd( aSX6, {'  ','MV_REGSOC0','C','','','','','','','','','','{"105","02","28695011100","MADALENA COSTA MACEDO","SOCIO PESSOA FISICA DOMICILIADO NO BRASIL","1"}','','','U',''} )
aAdd( aSX6, {'  ','MV_TESALT','C','USUARIOS AUTORIZADOS PARA ALTERACAO DA TES NO PEDI','','','DO DE VENDAS','','','','','','RCIAMBARELLA\RSOUZA\IMATOS\BCOSTA\JALVES\nsilva\farias\lfelipe\SUPERTECH','EBUTTNER\RCIAMBARELLA\RSOUZA\ROLIVEIRA\CMASIERO\ROGERIO\VCOSTA\EMARIA\RNEIDE\LPORTO\SMASSI\RBALDUINO\CCAMPOS\IMATOS','EBUTTNER\RCIAMBARELLA\RSOUZA\ROLIVEIRA\CMASIERO\ROGERIO\VCOSTA\EMARIA\RNEIDE\LPORTO\SMASSI\RBALDUINO\CCAMPOS\IMATOS','U',''} )
aAdd( aSX6, {'  ','MV_ULDTDEV','D','parametro com a data do fechamento da devolu็ใo','','','','','','','','','01/11/12','','','U',''} )
aAdd( aSX6, {'  ','MV_ULUSDEV','C','usuarios autorizados a realizar o fechamento de de','','','volu็ใo','','','','','','LFELIPE/RJESUS/LRIBEIRO/RSOUZA','','','U',''} )
aAdd( aSX6, {'  ','MV_USMOTDE','C','usuarios autorizados a realizar manuten็ใo do moti','','','vos de devolu็ใo','','','','','','RSOUZA/RJESUS/LFELIPE/JALVES/LRIBEIRO/BCOSTA/ISENA/NSILVA/PSILVA/PSUELEN','','','U',''} )
aAdd( aSX6, {'  ','MV_USRFRIS','C','Nome dos usuarios que podem isentar o frete no','','','PEDIDO DE VENDA.','','','','','','000000/000266/000245/000129/000307','','','U',''} )
aAdd( aSX6, {'  ','MV_USRFRTN','C','NOME DOS USUARIOS QUE PODEM ALTERAR O VALOR','','','DO FRETE NO PEDIDO DE VENDA.','','','','','','000000/000266/000245/000129/000307','','','U',''} )
aAdd( aSX6, {'  ','MV_VLMAXFR','N','PEDIDOS COM VALOR TOTAL SUPERIOR AO PARAMETRO','','','ESTARA ISENTO DE FRETE.','','','','','','5000.00','','','U',''} )
aAdd( aSX6, {'  ','MV_VLMAXPV','N','Valor Maximo','Valor Maximo','Valor Maximo','','','','','','','400000','80000','80000','U',''} )
aAdd( aSX6, {'  ','MV_VLRMAX','N','VALOR MAXIMO PARA QUEBRA DE PICKLIST','','','','','','','','','400000','','','U',''} )
aAdd( aSX6, {'  ','MV_X_CBARR','N','Numero identificador (codigo de barras) referente','','','a numeracao que esta sendo gerada para os pacotes.','','','','','','549981','549981','549981','U',''} )
aAdd( aSX6, {'  ','MV_X_PPESO','N','Percentual que sera acrescentado como sendo uma','','','forma de nao haver erros com relacao a perdas com','','','peso dos produtos.','','','30','','','U',''} )
aAdd( aSX6, {'  ','MV_X_TES','C','TES utilizadas na venda para validar o desconto','','','Especifico NC Games','','','','','','503/505/549/586','','','U',''} )
aAdd( aSX6, {'  ','NCG_000001','C','Define o e-mail para envio de erros ocorridos nas','Define o e-mail para envio de erros ocorridos nas','Define o e-mail para envio de erros ocorridos nas','customiza็๕es do ERP Protheus.','customiza็๕es do ERP Protheus.','customiza็๕es do ERP Protheus.','','','','cleverson.silva@acpd.com.br','','','U',''} )
aAdd( aSX6, {'  ','NCG_000002','C','Define o e-mail em c๓pia para envio de erros ocorr','Define o e-mail em c๓pia para envio de erros ocorr','Define o e-mail em c๓pia para envio de erros ocorr','idos nas customiza็๕es do ERP Protheus.','idos nas customiza็๕es do ERP Protheus.','idos nas customiza็๕es do ERP Protheus.','','','','','','','U',''} )
aAdd( aSX6, {'  ','NCG_000003','C','Usuแrio do Banco de Dados Para Transfer๊ncia De Da','Usuแrio do Banco de Dados Para Transfer๊ncia De Da','Usuแrio do Banco de Dados Para Transfer๊ncia De Da','dos (Catแlogo de Produto)','dos (Catแlogo de Produto)','dos (Catแlogo de Produto)','','','','PORTAL','','','U',''} )
aAdd( aSX6, {'  ','NCG_000004','C','Define o diret๓rio para grava็ใo dos logs de erro','Define o diret๓rio para grava็ใo dos logs de erro','Define o diret๓rio para grava็ใo dos logs de erro','das rotinas customizadas.','das rotinas customizadas.','das rotinas customizadas.','','','','NCGAMESLOG','','','U',''} )
aAdd( aSX6, {'  ','NCG_000005','C',"Portas dos TopConnect's para conexใo no servidor C","Portas dos TopConnect's para conexใo no servidor C","Portas dos TopConnect's para conexใo no servidor C",'atแlogo de Produtos','atแlogo de Produtos','atแlogo de Produtos','','','','','','','U',''} )
aAdd( aSX6, {'  ','NCG_000006','C','Tipo Banco De Dados Para Transfer๊ncia De Dados (C','Tipo Banco De Dados Para Transfer๊ncia De Dados (C','Tipo Banco De Dados Para Transfer๊ncia De Dados (C','atแlogo de Produto)','atแlogo de Produto)','atแlogo de Produto)','','','','ORACLE','','','U',''} )
aAdd( aSX6, {'  ','NCG_000007','C','Nome do banco de dados para transferencia de dados','Nome do banco de dados para transferencia de dados','Nome do banco de dados para transferencia de dados','(Catแlogo de Produto)','(Catแlogo de Produto)','(Catแlogo de Produto)','','','','PORTAL','','','U',''} )
aAdd( aSX6, {'  ','NCG_000008','C','Servidor do top connect para transfer๊ncia de dado','Servidor do top connect para transfer๊ncia de dado','Servidor do top connect para transfer๊ncia de dado','s (Catแlogo de Produto)','s (Catแlogo de Produto)','s (Catแlogo de Produto)','','','','187.84.224.9','','','U',''} )
aAdd( aSX6, {'  ','NCG_000009','N','Porta do top connect para transferencia de dados (','Porta do top connect para transferencia de dados (','Porta do top connect para transferencia de dados (','Catแlogo de Produto)','Catแlogo de Produto)','Catแlogo de Produto)','','','','7890','0','0','U',''} )
aAdd( aSX6, {'  ','NCG_000010','N','Quantidade de tentativas que as rotinas de integra','Quantidade de tentativas que as rotinas de integra','Quantidade de tentativas que as rotinas de integra','็ใo Protheus X Catแlogo de Produtos executarใo em','็ใo Protheus X Catแlogo de Produtos executarใo em','็ใo Protheus X Catแlogo de Produtos executarใo em','casos em que nใo for possivel a conexao com o TopC','casos em que nใo for possivel a conexao com o TopC','casos em que nใo for possivel a conexao com o TopC','0','0','0','U',''} )
aAdd( aSX6, {'  ','NCG_000011','L','Define se aguardarแ a execu็ใo das demais instโnci','Define se aguardarแ a execu็ใo das demais instโnci','Define se aguardarแ a execu็ใo das demais instโnci','as no controle de semแforo das rotinas de exporta็','as no controle de semแforo das rotinas de exporta็','as no controle de semแforo das rotinas de exporta็','ใo e importa็ใo de dados','ใo e importa็ใo de dados','ใo e importa็ใo de dados','.F.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','NCG_000012','N','Define a quantidade de tentativas de execu็ใo no c','Define a quantidade de tentativas de execu็ใo no c','Define a quantidade de tentativas de execu็ใo no c','ontrole de semaf๓ro das rotinas de exporta็ใo e im','ontrole de semaf๓ro das rotinas de exporta็ใo e im','ontrole de semaf๓ro das rotinas de exporta็ใo e im','porta็ใo de dados','porta็ใo de dados','porta็ใo de dados','0','0','0','U',''} )
aAdd( aSX6, {'  ','NCG_000013','L','Define se envia ou nใo e-mail ao administrador qua','Define se envia ou nใo e-mail ao administrador qua','Define se envia ou nใo e-mail ao administrador qua','ndo a rotina entrar no semaforo vermelho','ndo a rotina entrar no semaforo vermelho','ndo a rotina entrar no semaforo vermelho','','','','.T.','.F.','.F.','U',''} )
aAdd( aSX6, {'  ','NCG_000014','C','IDENTIFICA QUAIS TIPOS DE OPERAวรO DEVEM SER CONSI','','','DERADOS NOS TRATAMENTOS','','','','','','01#03','','','U',''} )
aAdd( aSX6, {'  ','NCG_000015','L','','','','','','','','','','.T.','','','U',''} )
aAdd( aSX6, {'  ','NCG_000016','C','Prefixo para relacionamento do NCC com o VPC.','Prefixo para relacionamento do NCC com o VPC.','Prefixo para relacionamento do NCC com o VPC.','','','','','','','VPC','VPC','VPC','U',''} )
aAdd( aSX6, {'  ','NCG_000017','C','Prefixo para relacionamento do Titulo a pagar com','Prefixo para relacionamento do Titulo a pagar com','Prefixo para relacionamento do Titulo a pagar com','a Verba.','a Verba.','a Verba.','','','','VER','VER','VER','U',''} )
aAdd( aSX6, {'  ','NCG_000018','C','Tipo de tํtulo a considerar para o relacionamento','Tipo de tํtulo a considerar para o relacionamento','Tipo de tํtulo a considerar para o relacionamento','com VPC.','com VPC.','com VPC.','','','','NCC','NCC','NCC','U',''} )
aAdd( aSX6, {'  ','NCG_000019','C','Usuแrio para acessar a base do WMS','Usuแrio para acessar a base do WMS','Usuแrio para acessar a base do WMS','','','','','','','WMS','','','U',''} )
aAdd( aSX6, {'  ','NCG_000020','C','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -',"Endere็o interno (a clausula 'http://' ้ necessแr","Endere็o interno (a clausula 'http://' ้ necessแr","Endere็o interno (a clausula 'http://' ้ necessแr",'ia )','ia )','ia )','http://192.168.0.217:8094','','','U',''} )
aAdd( aSX6, {'  ','NCG_000021','C','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -','Server HTTP do Protheus: utilizado para WORKFLOW -',"Endere็o externo (a clausula 'http://' ้ necessแr","Endere็o externo (a clausula 'http://' ้ necessแr","Endere็o externo (a clausula 'http://' ้ necessแr",'ia )','ia )','ia )','http://186.215.160.178:8094','','','U',''} )
aAdd( aSX6, {'  ','NCG_000022','C','Diretorio dos Html do Workflow','Diretorio dos Html do Workflow','Diretorio dos Html do Workflow','','','','','','','\workflow\','\workflow\','\workflow\','U',''} )
aAdd( aSX6, {'  ','NCG_000023','C','Endere็o dos arquivos de workflow para acesso via','Endere็o dos arquivos de workflow para acesso via','Endere็o dos arquivos de workflow para acesso via','browser do Protheus (nใo incluir a pasta com o c๓d','browser do Protheus (nใo incluir a pasta com o c๓d','browser do Protheus (nใo incluir a pasta com o c๓d','igo da empresa, pois a rotina preencherแ automatic','igo da empresa, pois a rotina preencherแ automatic','igo da empresa, pois a rotina preencherแ automatic','/messenger/emp','/messenger/emp','/messenger/emp','U',''} )
aAdd( aSX6, {'  ','NCG_000024','C','Nome do arquivo de imagem do logo da NC GAMES que','Nome do arquivo de imagem do logo da NC GAMES que','Nome do arquivo de imagem do logo da NC GAMES que','serแ impresso no relat๓rio de Price Protection','serแ impresso no relat๓rio de Price Protection','serแ impresso no relat๓rio de Price Protection','','','','','','','U',''} )
aAdd( aSX6, {'  ','NCG_000025','C','Codigo do usuแrio do protheus que serแ o Aprovador','Codigo do usuแrio do protheus que serแ o Aprovador','Codigo do usuแrio do protheus que serแ o Aprovador','1 - Cadastro de Contrato VPC / VERBA','1 - Cadastro de Contrato VPC / VERBA','1 - Cadastro de Contrato VPC / VERBA','','','','000086;000307','','','U',''} )
aAdd( aSX6, {'  ','NCG_000026','C','Codigo do usuแrio do protheus que serแ o Aprovador','Codigo do usuแrio do protheus que serแ o Aprovador','Codigo do usuแrio do protheus que serแ o Aprovador','2 - Cadastro de Contrato VPC / VERBA','2 - Cadastro de Contrato VPC / VERBA','2 - Cadastro de Contrato VPC / VERBA','','','','000086;000307','','','U',''} )
aAdd( aSX6, {'  ','NCG_000027','C','Codigo do usuแrio do protheus que serแ o Aprovador','Codigo do usuแrio do protheus que serแ o Aprovador','Codigo do usuแrio do protheus que serแ o Aprovador','3 - Cadastro de Contrato VPC / VERBA','3 - Cadastro de Contrato VPC / VERBA','3 - Cadastro de Contrato VPC / VERBA','','','','000086;000307','','','U',''} )
aAdd( aSX6, {'  ','NCG_000028','D','Data do Ultimo fechamento de Apura็ใo','Data do Ultimo fechamento de Apura็ใo','Data do Ultimo fechamento de Apura็ใo','','','','','','','20130318','20130318','20130318','U',''} )
aAdd( aSX6, {'  ','NCG_000029','N','Custo do Boleto','Custo do Boleto','Custo do Boleto','','','','','','','5','5','5','U',''} )
aAdd( aSX6, {'  ','NCG_000031','C','Diret๓rio base visao de pedidos','Diret๓rio base visao de pedidos','Diret๓rio base visao de pedidos','','','','','','','XLSNC\','\\192.168.0.210\Company\มreas Comuns\Adm Planilha BD\Acompanhamento de Pedidos\Base de Dados','\\192.168.0.210\Company\มreas Comuns\Adm Planilha BD\Acompanhamento de Pedidos\Base de Dados','U',''} )
aAdd( aSX6, {'  ','NCG_000032','C','Diret๓rio base do usuario da visao de pedidos','Diret๓rio base visao de pedidos','Diret๓rio base visao de pedidos','','','','','','','C:\relatorios adm','C:\relatorios adm','C:\relatorios adm','U',''} )
aAdd( aSX6, {'  ','NCG_000033','C','Usuแrio para acessar a base de dados do Fretes','Usuแrio para acessar a base de dados do Fretes','Usuแrio para acessar a base de dados do Fretes','','','','','','','FRETES','FRETES','FRETES','U',''} )
aAdd( aSX6, {'  ','NCG_000033','C','Usuแrio para acessar a base de dados do Fretes','','','','','','','','','FRETES','','','U',''} )
aAdd( aSX6, {'  ','NCG_000034','C','Produto padrใo para inclusใo de NF Entrada','','','a partir do fretes','','','','','','080440730101','','','U',''} )
aAdd( aSX6, {'  ','NCG_000035','C','Produto padrใo de Pedagio para inclusใo de NF','','','Entrada a partir do fretes','','','','','','080440730101','','','U',''} )
aAdd( aSX6, {'  ','NCG_000036','C','CFOPs que devem ser considerados nas devolu็๕es','CFOPs que devem ser considerados nas devolu็๕es','CFOPs que devem ser considerados nas devolu็๕es','','','','','','','1202*2202*1411*2411','1202*2202*1411*2411','1202*2202*1411*2411','U',''} )
aAdd( aSX6, {'  ','NCG_000037','N','Percentual para cแlculo de margem de contribui็ao.','Percentual para cแlculo de margem de contribui็ao.','Percentual para cแlculo de margem de contribui็ao.','','','','','','','0.2725','0.2725','0.2725','U',''} )
aAdd( aSX6, {'  ','NCG_000038','C','Inicial de produto que deve ser considerados na pl','Inicial de produto que deve ser considerados na pl','Inicial de produto que deve ser considerados na pl','anilha SOP.','anilha SOP.','anilha SOP.','','','','01*02*03*04*05*CP','01*02*03*04*05*CP','01*02*03*04*05*CP','U',''} )
aAdd( aSX6, {'  ','NCG_000039','C','Usuแrio que pode alterar Budget do S&OP.','Usuแrio que pode alterar Budget do S&OP.','Usuแrio que pode alterar Budget do S&OP.','','','','','','','000108','000108','000108','U',''} )
aAdd( aSX6, {'  ','NCG_000107','C','Status que nao permite liberacao','','','','','','','','','00*05*20*35*40','00*05*20*35*40','00*05*20*35*40','U',''} )
aAdd( aSX6, {'  ','NCG_000108','C','Status que nao permite envio','','','','','','','','','20*35*40*05','20*35*40','20*35*40','U',''} )
aAdd( aSX6, {'  ','NCG_000700','C','Usuarios com direiro a Filtro na Aprova็ใo da Marg','Usuarios com direiro a Filtro na Aprova็ใo da Marg','Usuarios com direiro a Filtro na Aprova็ใo da Marg','em','em','em','','','','lfelipe*rciambarella*dbmsystem','lfelipe*rciambarella*dbmsystem','lfelipe*rciambarella*dbmsystem','U',''} )
aAdd( aSX6, {'  ','NC_CFOEIP1','C','CFOP de estorno de IPI entrada','CFOP de estorno de IPI entrada','CFOP de estorno de IPI entrada','','','','','','','1202|2202|1411|2411|1152|1913','1202|2202|1411|2411|1152|1913','1202|2202|1411|2411|1152|1913','U',''} )
aAdd( aSX6, {'  ','NC_CFOEIP2','C','CFOP de estorno de IPI entrada CFOP = 1949|2949 e','CFOP de estorno de IPI entrada CFOP = 1949|2949 e','CFOP de estorno de IPI entrada CFOP = 1949|2949 e','formulario proprio','formulario proprio','formulario proprio','','','','1949|2949','1949|2949','1949|2949','U',''} )
aAdd( aSX6, {'  ','NC_CFOEST2','C','CFOP de estorno de ICMS ST entrada','CFOP de estorno de ICMS ST entrada','CFOP de estorno de ICMS ST entrada','','','','','','','2411|1411','2411|1411','2411|1411','U',''} )
aAdd( aSX6, {'  ','NC_CFOPDEV','C','CFOP de Devolu็ใo (Calc. do Custo Medio Gerencial)','CFOP de Devolu็ใo (Calc. do Custo Medio Gerencial)','CFOP de Devolu็ใo (Calc. do Custo Medio Gerencial)','','','','','','','2949|1949','2949|1949','2949|1949','U',''} )
aAdd( aSX6, {'  ','NC_CFOPEST','C','CFOP de estorno de ICMS ST entrada CFOP = 2949|194','CFOP de estorno de ICMS ST entrada CFOP = 2949|194','CFOP de estorno de ICMS ST entrada CFOP = 2949|194','9 e formulario proprio','9 e formulario proprio','9 e formulario proprio','','','','2949|1949','2949|1949','2949|1949','U',''} )
aAdd( aSX6, {'  ','NC_CFOPSIP','C','CFOP de estorno de IPI saida','CFOP de estorno de IPI saida','CFOP de estorno de IPI saida','','','','','','','5102|5910|5912|5913|5949|5152|6108|6403|6910|6949|6102','5102|5910|5912|5913|5949|5152|6108|6403|6910|6949|6102','5102|5910|5912|5913|5949|5152|6108|6403|6910|6949|6102','U',''} )
aAdd( aSX6, {'  ','NC_CFOPSST','C','CFOP de estorno de ICMS ST saida','CFOP de estorno de ICMS ST saida','CFOP de estorno de ICMS ST saida','','','','','','','6403|6404','6403|6404','6403|6404','U',''} )
aAdd( aSX6, {'  ','NC_CGRL204','C','CAMINHO PARA SALVAR PLANILHA DE TABELA DE PREวOS','','','','','','','','','XLSNC\','\XLSNC\','\XLSNC\','U',''} )
aAdd( aSX6, {'  ','NC_CMVGCLI','C','C๓digo do cliente NC Games','C๓digo do cliente NC Games','C๓digo do cliente NC Games','','','','','','','000001','000001','000001','U',''} )
aAdd( aSX6, {'  ','NC_CMVGLJ','C','Loja do cliente NC Games','Loja do cliente NC Games','Loja do cliente NC Games','','','','','','','01','01','01','U',''} )
aAdd( aSX6, {'  ','NC_CMVGPAI','C','Pais do cliente NC Games','Pais do cliente NC Games','Pais do cliente NC Games','','','','','','','105','105','105','U',''} )
aAdd( aSX6, {'  ','NC_DESCAM','C','Informar a tabela de desconto por idade','Informar a tabela de desconto por idade','Informar a tabela de desconto por idade','','','','','','','S009','S009','S009','U',''} )
aAdd( aSX6, {'  ','NC_DESCAO','C','Informar a tabela de desconto AO','Informar a tabela de desconto AO','Informar a tabela de desconto AO','','','','','','','S013','S013','S013','U',''} )
aAdd( aSX6, {'  ','NC_ESTMUNE','C','Estado e municipio estorno de IPI de entrada','Estado e municipio estorno de IPI de entrada','Estado e municipio estorno de IPI de entrada','','','','','','','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','U',''} )
aAdd( aSX6, {'  ','NC_ESTMUNS','C','Estado e municipio estorno de IPI Saida','Estado e municipio estorno de IPI Saida','Estado e municipio estorno de IPI Saida','','','','','','','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','RO00106|AC00203|AC00104|AM04062|AM02603|AM03536|AM03569|RR00100|AP00303|AP00600','U',''} )
aAdd( aSX6, {'  ','NC_LAYTRA1','C','E-mail de Layout de Transportadora','','','','','','','','','msoares@ncgames.com.br;agomes@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NC_LAYTRA2','C','E-mail de Layout de Transportadora','','','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','NC_LAYTRAN','C','E-mail de Layout de Transportadora','','','','','','','','','mpadua@ncgames.com.br;ebrito@ncgames.com.br;fafonso@ncgames.com.br;tfernandes@ncgames.com.br;framos@ncgames.com.br;anetto@ncgames.com.br;snunes@ncgames.com.br;fgoncalves@ncgames.com.br;csantos@ncgames.com.br;wsilva@ncgames.com.br','','','U',''} )
aAdd( aSX6, {'  ','NC_PERCDES','N','Informar o percentual de desconto do funcionario','Informar o percentual de desconto do funcionario','Informar o percentual de desconto do funcionario','','','','','','','6','6','6','U',''} )
aAdd( aSX6, {'  ','NC_RMTCOMP','C','E-mail completo do remetente','E-mail completo do remetente','E-mail completo do remetente','','','','','','','','','','U',''} )
aAdd( aSX6, {'  ','NC_VLMDICM','C','Valor da midia do ICMS','Valor da midia do ICMS','Valor da midia do ICMS','','','','','','','9.6','9.6','9.6','U',''} )
aAdd( aSX6, {'  ','NC_VLMDIPI','C','Valor da midia do ICMS','Valor da midia do ICMS','Valor da midia do ICMS','','','','','','','4.8','4.8','4.8','U',''} )
aAdd( aSX6, {'01','MV_ALMOX','C','ARMAZENS VALIDOS','','','','','','','','','01/02/03/04/05/07/08/11/CV/99/06/98/31/95/XX','01/02/03/04/05/07/08/11','01/02/03/04/05/07/08/11','U',''} )
aAdd( aSX6, {'01','MV_FINA4ES','L','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','.F.','','','U',''} )
aAdd( aSX6, {'01','MV_R54CFOP','C','Indica quais CFOPs de Servi็os farใo parte dos lan','Indica cuales CFOP de Servicios formaran parte de','It indicates the service CFOPs to be a part of the','็amentos no Registro Tipo 54.','los asientos en el Archivo Tipo 54.','entries in the Registration Type 54.','','','','','','','U',''} )
aAdd( aSX6, {'01','MV_R54IPI','L','Habilita/desabilita a utiliza็ใo do IPI nas opera็','Habilita/deshabilita utilizacion del IPI en Oper.','Enables/disables IPI use in operations in which','๕es em que o TES ้ configurado com o campo "Calcul','en las que el TES se configura con el campo "Calcu','TIO is configured with "Calculate IPI" field','a IPI" atribuํdo com o conte๚do "R" Com. N. Atacad','la IPI" atribuido con contenido "R" Com. N. Mayor.','filled with "R" Com. N. Wholesale.','.F.','','','U',''} )
aAdd( aSX6, {'01','MV_SERIE','C','Configura็ใo da s้rie a ser apresentada pelas','Configuracion de la serie por presentarse por el','Series configuration to be presented by','Notas Fiscais emitidas.','Facturas emitidas.','Invoices issued.','','','','2  -002/2-002/1  -001/  1-001/','2  -002/2-002/1  -001/  1-001/','2  -002/2-002/1  -001/  1-001/','U',''} )
aAdd( aSX6, {'01','MV_SINTEG','C','Estabelece os CFOPs que serao desconsiderados na','Establece los CFOP que se ignoraran en la','It establishes the CFOPs that will not be consider','geracao dos registros 54 e 75 - SINTEGRA','generacion de los registros 54 y 75 - SINTEGRA','red when generating records 54 and 75 - SINTEGRA','( Portaria CAT Nบ 32/96 )','(Resolucion CAT Nro. 32/96 )','(Admin. rule CAT No. 32/96).','','','','U',''} )
aAdd( aSX6, {'01','MV_SINTIPC','L','Indica se o item 997 das NF de Complemento,deve-','Indica si el item 997 de las Fact. de Complemento,','It indicates if item 977 of complement inv. must','rใo acompanhar a quantidade de itens da NF (reg.','debe acompanar la cantidad de items de la Fact(reg','accompany the number of invoice items (reg.','tipo 54)','tipo 54)','type 54)','.F.','','','U',''} )
aAdd( aSX6, {'01','MV_STUF','C','Unidades Federativas que devem ser processadas na','Unidades Federativas que deben ser procesadas en','States that must be processed while','apura็ใo das entradas e das saํdas do ICMS Subst.','apura็ใo das entradas e das saํdas do ICMS Subst.','calculating inflows and outflows of ICMS Tax','Tributแria.','Tributaria.','Subst.','','','','U',''} )
aAdd( aSX6, {'01','MV_STUFS','C','Unidades Federativas que devem ser processadas na','Provincias que deben procesarse en el','States to be processed while calculating','apuracไo das saidas do ICMS Subst. Tributaria.','calculo de las salidas del ICMS Subst.Tributaria','Tax Replacem.ICMS outflow.','','','','','','','U',''} )
aAdd( aSX6, {'02','MV_ESTADO','C','Sigla do estado da empresa usuaria do Sistema, pa-','Abreviatura de la estado de la empresa usuaria','State abbreviation referring to the system user','ra efeito de calculo de ICMS (7, 12 ou 18%).','del sistema a efectos de calculo del ICMS','code, for the purpose of calculating the','','(7, 12 o 18%).','ICMS (7,12 OR 18%).','ES','ES','ES','U',''} )
aAdd( aSX6, {'02','MV_ICMPAD','N','Informar a aliquota de ICMS aplicada em  operacoes','Informar la alicuota de ICMS aplicada en operacio-','Inform the value added tax rate, applied in the','dentro do estado onde a empresa esta localizada.','nes dentro de la provincia donde se localiza la','operation within the states, in which the company','(17 ou 18) %','empresa. (17 o 18) %','is localized (17 or 18%).','17','17','17','U',''} )
aAdd( aSX6, {'03','MV_ALMOX','C','ARMAZENS VALIDOS','','','','','','','','','01/02/03/04/05/07/08/11/CV/99/06/98/31/95/XX','','','U',''} )
aAdd( aSX6, {'03','MV_FINA4ES','L','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','Indica se devera gerar o Sintegra com a finalidade','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','4 (Retificacao Corretiva), subst. da inf. relativa','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','a um documento ja informado para o estado do ES.','.F.','','','U',''} )
aAdd( aSX6, {'03','MV_R54CFOP','C','Indica quais CFOPs de Servi็os farใo parte dos lan','Indica cuales CFOP de Servicios formaran parte de','It indicates the service CFOPs to be a part of the','็amentos no Registro Tipo 54.','los asientos en el Archivo Tipo 54.','entries in the Registration Type 54.','','','','','','','U',''} )
aAdd( aSX6, {'03','MV_R54IPI','L','Habilita/desabilita a utiliza็ใo do IPI nas opera็','Habilita/deshabilita utilizacion del IPI en Oper.','Enables/disables IPI use in operations in which','๕es em que o TES ้ configurado com o campo "Calcul','en las que el TES se configura con el campo "Calcu','TIO is configured with "Calculate IPI" field','a IPI" atribuํdo com o conte๚do "R" Com. N. Atacad','la IPI" atribuido con contenido "R" Com. N. Mayor.','filled with "R" Com. N. Wholesale.','.F.','','','U',''} )
aAdd( aSX6, {'03','MV_SINTEG','C','Estabelece os CFOPs que serao desconsiderados na','Establece los CFOP que se ignoraran en la','It establishes the CFOPs that will not be consider','geracao dos registros 54 e 75 - SINTEGRA','generacion de los registros 54 y 75 - SINTEGRA','red when generating records 54 and 75 - SINTEGRA','( Portaria CAT Nบ 32/96 )','(Resolucion CAT Nro. 32/96 )','(Admin. rule CAT No. 32/96).','','','','U',''} )
aAdd( aSX6, {'03','MV_SINTIPC','L','Indica se o item 997 das NF de Complemento,deve-','Indica si el item 997 de las Fact. de Complemento,','It indicates if item 977 of complement inv. must','rใo acompanhar a quantidade de itens da NF (reg.','debe acompanar la cantidad de items de la Fact(reg','accompany the number of invoice items (reg.','tipo 54)','tipo 54)','type 54)','.F.','','','U',''} )
aAdd( aSX6, {'03','MV_SUBTRI1','C','Numero da Inscricao Estadual do contribuinte','Numero de Inscripcion Provincial del contribuyente','Taxpayer State Insc.number in another state when','em outro estado quando houver Substituicao','en otro estado cuando hubiera Sustitucion','there is Tax Override.','Tributaria','Tributaria','','CE065843207/SE271344369','','','U',''} )
aAdd( aSX6, {'04','MV_ULMES','D','Data ultimo fechamento do estoque.','Fecha del ultimo cierre de stock.','Inventory last closing date.','','','','','','','31/01/2012','','','U',''} )
//
// Atualizando dicionแrio
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
		cTexto += "Foi incluํdo o parโmetro " + aSX6[nI][1] + aSX6[nI][2] + " Conte๚do [" + AllTrim( aSX6[nI][13] ) + "]"+ CRLF
	Else
		lContinua := .T.
		lReclock  := .F.
		If !StrTran( SX6->X6_CONTEUD, " ", "" ) == StrTran( aSX6[nI][13], " ", "" )

			cMsg := "O parโmetro " + aSX6[nI][2] + " estแ com o conte๚do" + CRLF + ;
			"[" + RTrim( StrTran( SX6->X6_CONTEUD, " ", "" ) ) + "]" + CRLF + ;
			", que ้ serแ substituido pelo NOVO conte๚do " + CRLF + ;
			"[" + RTrim( StrTran( aSX6[nI][13]   , " ", "" ) ) + "]" + CRLF + ;
			"Deseja substituir ? "

			If      lTodosSim
				nOpcA := 1
			ElseIf  lTodosNao
				nOpcA := 2
			Else
				nOpcA := Aviso( "ATUALIZAวรO DE DICIONมRIOS E TABELAS", cMsg, { "Sim", "Nใo", "Sim p/Todos", "Nใo p/Todos" }, 3, "Diferen็a de conte๚do - SX6" )
				lTodosSim := ( nOpcA == 3 )
				lTodosNao := ( nOpcA == 4 )

				If lTodosSim
					nOpcA := 1
					lTodosSim := MsgNoYes( "Foi selecionada a op็ใo de REALIZAR TODAS altera็๕es no SX6 e NรO MOSTRAR mais a tela de aviso." + CRLF + "Confirma a a็ใo [Sim p/Todos] ?" )
				EndIf

				If lTodosNao
					nOpcA := 2
					lTodosNao := MsgNoYes( "Foi selecionada a op็ใo de NรO REALIZAR nenhuma altera็ใo no SX6 que esteja diferente da base e NรO MOSTRAR mais a tela de aviso." + CRLF + "Confirma esta a็ใo [Nใo p/Todos]?" )
				EndIf

			EndIf

			lContinua := ( nOpcA == 1 )

			If lContinua
				cTexto += "Foi alterado o parโmetro " + aSX6[nI][1] + aSX6[nI][2] + " de [" + ;
				AllTrim( SX6->X6_CONTEUD ) + "]" + " para [" + AllTrim( aSX6[nI][13] ) + "]" + CRLF
			EndIf

		Else
			lContinua := .F.
		EndIf
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

cTexto += CRLF + "Final da Atualizacao" + " SX6" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSAtuSX7 บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SX7 - Gatilhos      ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSX7   - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FSAtuSX7( cTexto )
Local aEstrut   := {}
Local aSX7      := {}
Local cAlias    := ""
Local nI        := 0
Local nJ        := 0
Local nTamSeek  := Len( SX7->X7_CAMPO )

cTexto  += "Inicio da Atualizacao" + " SX7" + CRLF + CRLF

aEstrut := { "X7_CAMPO", "X7_SEQUENC", "X7_REGRA", "X7_CDOMIN", "X7_TIPO", "X7_SEEK", ;
             "X7_ALIAS", "X7_ORDEM"  , "X7_CHAVE", "X7_PROPRI", "X7_CONDIC" }

aAdd( aSX7, {'ZZ5_CANAL','001','POSICIONE("ACA",1,XFILIAL("ACA")+ M->ZZ5_CANAL,"ACA_DESCRI")','ZZ5_DESCAN','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZZ5_WF','001','TABELA("Z+",M->ZZ5_WF)','ZZ5_DESCWF','P','N','',0,'','U',''} )
//
// Atualizando dicionแrio
//
oProcess:SetRegua2( Len( aSX7 ) )

dbSelectArea( "SX7" )
dbSetOrder( 1 )

For nI := 1 To Len( aSX7 )

	If !SX7->( dbSeek( PadR( aSX7[nI][1], nTamSeek ) + aSX7[nI][2] ) )

		If !( aSX7[nI][1] $ cAlias )
			cAlias += aSX7[nI][1] + "/"
			cTexto += "Foi incluํdo o gatilho " + aSX7[nI][1] + "/" + aSX7[nI][2] + CRLF
		EndIf

		RecLock( "SX7", .T. )
	Else

		If !( aSX7[nI][1] $ cAlias )
			cAlias += aSX7[nI][1] + "/"
			cTexto += "Foi alterado o gatilho " + aSX7[nI][1] + "/" + aSX7[nI][2] + CRLF
		EndIf

		RecLock( "SX7", .F. )
	EndIf

	For nJ := 1 To Len( aSX7[nI] )
		If FieldPos( aEstrut[nJ] ) > 0
			FieldPut( FieldPos( aEstrut[nJ] ), aSX7[nI][nJ] )
		EndIf
	Next nJ

	dbCommit()
	MsUnLock()

	oProcess:IncRegua2( "Atualizando Arquivos (SX7)..." )

Next nI

cTexto += CRLF + "Final da Atualizacao" + " SX7" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSAtuSXB บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SXB - Consultas Pad ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSXB   - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
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

cTexto  += "Inicio da Atualizacao" + " SXB" + CRLF + CRLF

aEstrut := { "XB_ALIAS",  "XB_TIPO"   , "XB_SEQ"    , "XB_COLUNA" , ;
             "XB_DESCRI", "XB_DESCSPA", "XB_DESCENG", "XB_CONTEM" }

aAdd( aSXB, {'ACA','1','01','DB','Grupo','Grupo','Group','ACA'} )
aAdd( aSXB, {'ACA','2','01','01','Grupo','Grupo','Group',''} )
aAdd( aSXB, {'ACA','3','01','01','Cadastra Novo','Registra Nuevo','Add New','01'} )
aAdd( aSXB, {'ACA','4','01','01','Grupo','Grupo','Group','ACA_GRPREP'} )
aAdd( aSXB, {'ACA','4','01','02','Descricao','Descripcion','Description','ACA_DESCRI'} )
aAdd( aSXB, {'ACA','5','01','','','','','ACA->ACA_GRPREP'} )
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
aAdd( aSXB, {'WFINAD','1','01','RE','Html','Html','Html','ZZ5'} )
aAdd( aSXB, {'WFINAD','2','01','01','','','','U_PR702SXB()'} )
aAdd( aSXB, {'WFINAD','5','01','','','','','M->ZZ5_HTMARQ'} )
//
// Atualizando dicionแrio
//
oProcess:SetRegua2( Len( aSXB ) )

dbSelectArea( "SXB" )
dbSetOrder( 1 )

For nI := 1 To Len( aSXB )

	If !Empty( aSXB[nI][1] )

		If !SXB->( dbSeek( PadR( aSXB[nI][1], Len( SXB->XB_ALIAS ) ) + aSXB[nI][2] + aSXB[nI][3] + aSXB[nI][4] ) )

			If !( aSXB[nI][1] $ cAlias )
				cAlias += aSXB[nI][1] + "/"
				cTexto += "Foi incluํda a consulta padrใo " + aSXB[nI][1] + CRLF
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

					cMsg := "A consulta padrao " + aSXB[nI][1] + " estแ com o " + SXB->( FieldName( nJ ) ) + ;
					" com o conte๚do" + CRLF + ;
					"[" + RTrim( AllToChar( SXB->( FieldGet( nJ ) ) ) ) + "]" + CRLF + ;
					", e este ้ diferente do conte๚do" + CRLF + ;
					"[" + RTrim( AllToChar( aSXB[nI][nJ] ) ) + "]" + CRLF +;
					"Deseja substituir ? "

					If      lTodosSim
						nOpcA := 1
					ElseIf  lTodosNao
						nOpcA := 2
					Else
						nOpcA := Aviso( "ATUALIZAวรO DE DICIONมRIOS E TABELAS", cMsg, { "Sim", "Nใo", "Sim p/Todos", "Nใo p/Todos" }, 3, "Diferen็a de conte๚do - SXB" )
						lTodosSim := ( nOpcA == 3 )
						lTodosNao := ( nOpcA == 4 )

						If lTodosSim
							nOpcA := 1
							lTodosSim := MsgNoYes( "Foi selecionada a op็ใo de REALIZAR TODAS altera็๕es no SXB e NรO MOSTRAR mais a tela de aviso." + CRLF + "Confirma a a็ใo [Sim p/Todos] ?" )
						EndIf

						If lTodosNao
							nOpcA := 2
							lTodosNao := MsgNoYes( "Foi selecionada a op็ใo de NรO REALIZAR nenhuma altera็ใo no SXB que esteja diferente da base e NรO MOSTRAR mais a tela de aviso." + CRLF + "Confirma esta a็ใo [Nใo p/Todos]?" )
						EndIf

					EndIf

					If nOpcA == 1
						RecLock( "SXB", .F. )
						FieldPut( FieldPos( aEstrut[nJ] ), aSXB[nI][nJ] )
						dbCommit()
						MsUnLock()

						If !( aSXB[nI][1] $ cAlias )
							cAlias += aSXB[nI][1] + "/"
							cTexto += "Foi Alterada a consulta padrao " + aSXB[nI][1] + CRLF
						EndIf

					EndIf

				EndIf

			Next

		EndIf

	EndIf

	oProcess:IncRegua2( "Atualizando Consultas Padroes (SXB)..." )

Next nI

cTexto += CRLF + "Final da Atualizacao" + " SXB" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณESCEMPRESAบAutor  ณ Ernani Forastieri  บ Data ณ  27/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao Generica para escolha de Empresa, montado pelo SM0_ บฑฑ
ฑฑบ          ณ Retorna vetor contendo as selecoes feitas.                 บฑฑ
ฑฑบ          ณ Se nao For marcada nenhuma o vetor volta vazio.            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EscEmpresa()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Parametro  nTipo                           ณ
//ณ 1  - Monta com Todas Empresas/Filiais      ณ
//ณ 2  - Monta so com Empresas                 ณ
//ณ 3  - Monta so com Filiais de uma Empresa   ณ
//ณ                                            ณ
//ณ Parametro  aMarcadas                       ณ
//ณ Vetor com Empresas/Filiais pre marcadas    ณ
//ณ                                            ณ
//ณ Parametro  cEmpSel                         ณ
//ณ Empresa que sera usada para montar selecao ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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

oDlg:cToolTip := "Tela para M๚ltiplas Sele็๕es de Empresas/Filiais"

oDlg:cTitle   := "Selecione a(s) Empresa(s) para Atualiza็ใo"

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
Message "Inverter Sele็ใo" Of oDlg

// Marca/Desmarca por mascara
@ 113, 51 Say  oSay Prompt "Empresa" Size  40, 08 Of oDlg Pixel
@ 112, 80 MSGet  oMascEmp Var  cMascEmp Size  05, 05 Pixel Picture "@!"  Valid (  cMascEmp := StrTran( cMascEmp, " ", "?" ), cMascFil := StrTran( cMascFil, " ", "?" ), oMascEmp:Refresh(), .T. ) ;
Message "Mแscara Empresa ( ?? )"  Of oDlg
@ 123, 50 Button oButMarc Prompt "&Marcar"    Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .T. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Marcar usando mแscara ( ?? )"    Of oDlg
@ 123, 80 Button oButDMar Prompt "&Desmarcar" Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .F. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Desmarcar usando mแscara ( ?? )" Of oDlg

Define SButton From 111, 125 Type 1 Action ( RetSelecao( @aRet, aVetor ), oDlg:End() ) OnStop "Confirma a Sele็ใo"  Enable Of oDlg
Define SButton From 111, 158 Type 2 Action ( IIf( lTeveMarc, aRet :=  aMarcadas, .T. ), oDlg:End() ) OnStop "Abandona a Sele็ใo" Enable Of oDlg
Activate MSDialog  oDlg Center

RestArea( aSalvAmb )
dbSelectArea( "SM0" )
dbCloseArea()

Return  aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณMARCATODOSบAutor  ณ Ernani Forastieri  บ Data ณ  27/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao Auxiliar para marcar/desmarcar todos os itens do    บฑฑ
ฑฑบ          ณ ListBox ativo                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MarcaTodos( lMarca, aVetor, oLbx )
Local  nI := 0

For nI := 1 To Len( aVetor )
	aVetor[nI][1] := lMarca
Next nI

oLbx:Refresh()

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณINVSELECAOบAutor  ณ Ernani Forastieri  บ Data ณ  27/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao Auxiliar para inverter selecao do ListBox Ativo     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function InvSelecao( aVetor, oLbx )
Local  nI := 0

For nI := 1 To Len( aVetor )
	aVetor[nI][1] := !aVetor[nI][1]
Next nI

oLbx:Refresh()

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณRETSELECAOบAutor  ณ Ernani Forastieri  บ Data ณ  27/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao Auxiliar que monta o retorno com as selecoes        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RetSelecao( aRet, aVetor )
Local  nI    := 0

aRet := {}
For nI := 1 To Len( aVetor )
	If aVetor[nI][1]
		aAdd( aRet, { aVetor[nI][2] , aVetor[nI][3], aVetor[nI][2] +  aVetor[nI][3] } )
	EndIf
Next nI

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณ MARCAMAS บAutor  ณ Ernani Forastieri  บ Data ณ  20/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao para marcar/desmarcar usando mascaras               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MarcaMas( oLbx, aVetor, cMascEmp, lMarDes )
Local cPos1 := SubStr( cMascEmp, 1, 1 )
Local cPos2 := SubStr( cMascEmp, 2, 1 )
Local nPos  := oLbx:nAt
Local nZ    := 0

For nZ := 1 To Len( aVetor )
	If cPos1 == "?" .or. SubStr( aVetor[nZ][2], 1, 1 ) == cPos1
		If cPos2 == "?" .or. SubStr( aVetor[nZ][2], 2, 1 ) == cPos2
			aVetor[nZ][1] :=  lMarDes
		EndIf
	EndIf
Next

oLbx:nAt := nPos
oLbx:Refresh()

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบRotina    ณ VERTODOS บAutor  ณ Ernani Forastieri  บ Data ณ  20/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Funcao auxiliar para verificar se estao todos marcardos    บฑฑ
ฑฑบ          ณ ou nao                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VerTodos( aVetor, lChk, oChkMar )
Local lTTrue := .T.
Local nI     := 0

For nI := 1 To Len( aVetor )
	lTTrue := IIf( !aVetor[nI][1], .F., lTTrue )
Next nI

lChk := IIf( lTTrue, .T., .F. )
oChkMar:Refresh()

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ MyOpenSM0บ Autor ณ TOTVS Protheus     บ Data ณ  22/07/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento abertura do SM0 modo exclusivo     ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ MyOpenSM0  - Gerado por EXPORDIC / Upd. V.4.10.8 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
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
	MsgStop( "Nใo foi possํvel a abertura da tabela " + ;
	IIf( lShared, "de empresas (SM0).", "de empresas (SM0) de forma exclusiva." ), "ATENวรO" )
EndIf

Return lOpen


/////////////////////////////////////////////////////////////////////////////


User Function xAcertP01()
Local aCpoADD:={'P01_VPCANU'}
Local nCont:=0
Local cMensagem:=""

RpcSetEnv("01","03")

aStructAtu:=P01->(DbStruct())
aStructNew:=aClone(aStructAtu)

SX3->(DbSetOrder(2))
For nInd:=1 To Len(aCpoADD)	
	If (nAscan:=Ascan(aStructNew,{|a| AllTrim(a[1])==aCpoADD[nInd]  }))==0 .And. SX3->(DbSeek(aCpoADD[nInd]))
   	SX3->( AADD(aStructNew,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL}) )
	EndIf
Next


nTopErr:=Nil
P01->(DbCloseArea())
cTabela:="P01010"
If Len(aStructAtu)<>Len(aStructNew)
	If TcAlter( cTabela , aStructAtu, aStructNew, @nTopErr )
		cMensagem+="Tabela "+cTabela+" Alterada"
	Else
		cMensagem+="Erro "+AllTrim(Str(nTopErr))+" ao alterar a tabela "+cTabela
		
	EndIf
EndIf
MsgInfo(cMensagem)

aCpoADD:={'C5_YPANUAL','C5_YVANUAL'}
nCont:=0
cMensagem:=""

RpcSetEnv("01","03")

aStructAtu:=SC5->(DbStruct())
aStructNew:=aClone(aStructAtu)

SX3->(DbSetOrder(2))
For nInd:=1 To Len(aCpoADD)	
	If (nAscan:=Ascan(aStructNew,{|a| AllTrim(a[1])==aCpoADD[nInd]  }))==0 .And. SX3->(DbSeek(aCpoADD[nInd]))
   	SX3->( AADD(aStructNew,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL}) )
	EndIf
Next


nTopErr:=Nil
SC5->(DbCloseArea())
cTabela:="SC5010"
If Len(aStructAtu)<>Len(aStructNew)
	If TcAlter( cTabela , aStructAtu, aStructNew, @nTopErr )
		cMensagem+="Tabela "+cTabela+" Alterada"
	Else
		cMensagem+="Erro "+AllTrim(Str(nTopErr))+" ao alterar a tabela "+cTabela
		
	EndIf
EndIf
MsgInfo(cMensagem)



aCpoADD:={'C6_YVANUAL'}
nCont:=0
cMensagem:=""

RpcSetEnv("01","03")

aStructAtu:=SC6->(DbStruct())
aStructNew:=aClone(aStructAtu)

SX3->(DbSetOrder(2))
For nInd:=1 To Len(aCpoADD)	
	If (nAscan:=Ascan(aStructNew,{|a| AllTrim(a[1])==aCpoADD[nInd]  }))==0 .And. SX3->(DbSeek(aCpoADD[nInd]))
   	SX3->( AADD(aStructNew,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL}) )
	EndIf
Next


nTopErr:=Nil
SC6->(DbCloseArea())
cTabela:="SC6010"
If Len(aStructAtu)<>Len(aStructNew)
	If TcAlter( cTabela , aStructAtu, aStructNew, @nTopErr )
		cMensagem+="Tabela "+cTabela+" Alterada"
	Else
		cMensagem+="Erro "+AllTrim(Str(nTopErr))+" ao alterar a tabela "+cTabela
		
	EndIf
EndIf
MsgInfo(cMensagem)



Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPD_INA   บAutor  ณMicrosiga           บ Data ณ  02/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xAcertZZS()
Local aCpoADD:={'ZZS_FONE','ZZS_DDD'}
Local nCont:=0
Local cMensagem:=""

RpcSetEnv("01","03")

aStructAtu:=ZZS->(DbStruct())
aStructNew:=aClone(aStructAtu)

SX3->(DbSetOrder(2))
For nInd:=1 To Len(aCpoADD)	
	If (nAscan:=Ascan(aStructNew,{|a| AllTrim(a[1])==aCpoADD[nInd]  }))==0 .And. SX3->(DbSeek(aCpoADD[nInd]))
     	SX3->( AADD(aStructNew,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL}) )
	EndIf
Next


nTopErr:=Nil
ZZS->(DbCloseArea())
cTabela:="ZZS010"
If Len(aStructAtu)<>Len(aStructNew)
	If TcAlter( cTabela , aStructAtu, aStructNew, @nTopErr )
		cMensagem+="Tabela "+cTabela+" Alterada"
	Else
		cMensagem+="Erro "+AllTrim(Str(nTopErr))+" ao alterar a tabela "+cTabela
		
	EndIf
EndIf
MsgInfo(cMensagem)    
Return 