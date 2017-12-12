#INCLUDE "PROTHEUS.CH"

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

#DEFINE CSSBOTAO	"QPushButton { color: #024670; "+;
"    border-image: url(rpo:fwstd_btn_nml.png) 3 3 3 3 stretch; "+;
"    border-top-width: 3px; "+;
"    border-left-width: 3px; "+;
"    border-right-width: 3px; "+;
"    border-bottom-width: 3px }"+;
"QPushButton:pressed {	color: #FFFFFF; "+;
"    border-image: url(rpo:fwstd_btn_prd.png) 3 3 3 3 stretch; "+;
"    border-top-width: 3px; "+;
"    border-left-width: 3px; "+;
"    border-right-width: 3px; "+;
"    border-bottom-width: 3px }"

//--------------------------------------------------------------------
/*/{Protheus.doc} UPDVTEX
Função de update de dicionários para compatibilização

@author TOTVS Protheus
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
User Function UPDVTEX( cEmpAmb, cFilAmb )

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
			oProcess := MsNewProcess():New( { | lEnd | lOk := FSTProc( @lEnd, aMarcadas, lAuto ) }, "Atualizando", "Aguarde, atualizando ...", .F. )
			oProcess:Activate()

			If lAuto
				If lOk
					MsgStop( "Atualização Realizada.", "UPDVTEX" )
				Else
					MsgStop( "Atualização não Realizada.", "UPDVTEX" )
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
			MsgStop( "Atualização não Realizada.", "UPDVTEX" )

		EndIf

	Else
		MsgStop( "Atualização não Realizada.", "UPDVTEX" )

	EndIf

EndIf

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSTProc
Função de processamento da gravação dos arquivos

@author TOTVS Protheus
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSTProc( lEnd, aMarcadas, lAuto )
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

			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( Replicate( " ", 128 ) )
			AutoGrLog( "LOG DA ATUALIZAÇÃO DOS DICIONÁRIOS" )
			AutoGrLog( Replicate( " ", 128 ) )
			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( " " )
			AutoGrLog( " Dados Ambiente" )
			AutoGrLog( " --------------------" )
			AutoGrLog( " Empresa / Filial...: " + cEmpAnt + "/" + cFilAnt )
			AutoGrLog( " Nome Empresa.......: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_NOMECOM", cEmpAnt + cFilAnt, 1, "" ) ) ) )
			AutoGrLog( " Nome Filial........: " + Capital( AllTrim( GetAdvFVal( "SM0", "M0_FILIAL" , cEmpAnt + cFilAnt, 1, "" ) ) ) )
			AutoGrLog( " DataBase...........: " + DtoC( dDataBase ) )
			AutoGrLog( " Data / Hora Ínicio.: " + DtoC( Date() )  + " / " + Time() )
			AutoGrLog( " Environment........: " + GetEnvServer()  )
			AutoGrLog( " StartPath..........: " + GetSrvProfString( "StartPath", "" ) )
			AutoGrLog( " RootPath...........: " + GetSrvProfString( "RootPath" , "" ) )
			AutoGrLog( " Versão.............: " + GetVersao(.T.) )
			AutoGrLog( " Usuário TOTVS .....: " + __cUserId + " " +  cUserName )
			AutoGrLog( " Computer Name......: " + GetComputerName() )

			aInfo   := GetUserInfo()
			If ( nPos    := aScan( aInfo,{ |x,y| x[3] == ThreadId() } ) ) > 0
				AutoGrLog( " " )
				AutoGrLog( " Dados Thread" )
				AutoGrLog( " --------------------" )
				AutoGrLog( " Usuário da Rede....: " + aInfo[nPos][1] )
				AutoGrLog( " Estação............: " + aInfo[nPos][2] )
				AutoGrLog( " Programa Inicial...: " + aInfo[nPos][5] )
				AutoGrLog( " Environment........: " + aInfo[nPos][6] )
				AutoGrLog( " Conexão............: " + AllTrim( StrTran( StrTran( aInfo[nPos][7], Chr( 13 ), "" ), Chr( 10 ), "" ) ) )
			EndIf
			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( " " )

			If !lAuto
				AutoGrLog( Replicate( "-", 128 ) )
				AutoGrLog( "Empresa : " + SM0->M0_CODIGO + "/" + SM0->M0_NOME + CRLF )
			EndIf

			oProcess:SetRegua1( 8 )


			oProcess:IncRegua1( "Dicionário de arquivos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX2()


			FSAtuSX3()


			oProcess:IncRegua1( "Dicionário de índices" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSIX()

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
					AutoGrLog( "Ocorreu um erro desconhecido durante a atualização da estrutura da tabela : " + aArqUpd[nX] )
				EndIf

				If cTopBuild >= "20090811" .AND. TcInternal( 89 ) == "CLOB_SUPPORTED"
					TcInternal( 25, "OFF" )
				EndIf

			Next nX


			oProcess:IncRegua1( "Dicionário de gatilhos" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSX7()

			AutoGrLog( Replicate( "-", 128 ) )
			AutoGrLog( " Data / Hora Final.: " + DtoC( Date() ) + " / " + Time() )
			AutoGrLog( Replicate( "-", 128 ) )

			RpcClearEnv()

		Next nI

		If !lAuto

			cTexto := LeLog()

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
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX2()
Local aEstrut   := {}
Local aSX2      := {}
Local cAlias    := ""
Local cEmpr     := ""
Local cPath     := ""
Local nI        := 0
Local nJ        := 0

AutoGrLog( "Ínicio da Atualização" + " SX2" + CRLF )

aEstrut := { "X2_CHAVE"  , "X2_PATH"   , "X2_ARQUIVO", "X2_NOME"   , "X2_NOMESPA", "X2_NOMEENG", "X2_MODO"   , ;
             "X2_TTS"    , "X2_ROTINA" , "X2_PYME"   , "X2_UNICO"  , "X2_DISPLAY", "X2_SYSOBJ" , "X2_USROBJ" , ;
             "X2_POSLGT" , "X2_MODOEMP", "X2_MODOUN" , "X2_MODULO" }


dbSelectArea( "SX2" )
SX2->( dbSetOrder( 1 ) )
SX2->( dbGoTop() )
cPath := SX2->X2_PATH
cPath := IIf( Right( AllTrim( cPath ), 1 ) <> "\", PadR( AllTrim( cPath ) + "\", Len( cPath ) ), cPath )
cEmpr := Substr( SX2->X2_ARQUIVO, 4 )

aAdd( aSX2, {'ZA1',cPath,'ZA1'+cEmpr,'CADASTRO CLIENTE E-COMMERCE','CADASTRO CLIENTE E-COMMERCE','CADASTRO CLIENTE E-COMMERCE','E','','','','','','','','','E','E',0} )
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
			AutoGrLog( "Foi incluída a tabela " + aSX2[nI][1] )
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

	EndIf

Next nI

AutoGrLog( CRLF + "Final da Atualização" + " SX2" + CRLF + Replicate( "-", 128 ) + CRLF )

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX3
Função de processamento da gravação do SX3 - Campos

@author TOTVS Protheus
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX3()
Local aEstrut   := {}
Local aSX3      := {}
Local cAlias    := ""
Local cAliasAtu := ""
Local cMsg      := ""
Local cSeqAtu   := ""
Local cX3Campo  := ""
Local cX3Dado   := ""
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

AutoGrLog( "Ínicio da Atualização" + " SX3" + CRLF )

aEstrut := { { "X3_ARQUIVO", 0 }, { "X3_ORDEM"  , 0 }, { "X3_CAMPO"  , 0 }, { "X3_TIPO"   , 0 }, { "X3_TAMANHO", 0 }, { "X3_DECIMAL", 0 }, { "X3_TITULO" , 0 }, ;
             { "X3_TITSPA" , 0 }, { "X3_TITENG" , 0 }, { "X3_DESCRIC", 0 }, { "X3_DESCSPA", 0 }, { "X3_DESCENG", 0 }, { "X3_PICTURE", 0 }, { "X3_VALID"  , 0 }, ;
             { "X3_USADO"  , 0 }, { "X3_RELACAO", 0 }, { "X3_F3"     , 0 }, { "X3_NIVEL"  , 0 }, { "X3_RESERV" , 0 }, { "X3_CHECK"  , 0 }, { "X3_TRIGGER", 0 }, ;
             { "X3_PROPRI" , 0 }, { "X3_BROWSE" , 0 }, { "X3_VISUAL" , 0 }, { "X3_CONTEXT", 0 }, { "X3_OBRIGAT", 0 }, { "X3_VLDUSER", 0 }, { "X3_CBOX"   , 0 }, ;
             { "X3_CBOXSPA", 0 }, { "X3_CBOXENG", 0 }, { "X3_PICTVAR", 0 }, { "X3_WHEN"   , 0 }, { "X3_INIBRW" , 0 }, { "X3_GRPSXG" , 0 }, { "X3_FOLDER" , 0 }, ;
             { "X3_CONDSQL", 0 }, { "X3_CHKSQL" , 0 }, { "X3_IDXSRV" , 0 }, { "X3_ORTOGRA", 0 }, { "X3_TELA"   , 0 }, { "X3_POSLGT" , 0 }, { "X3_IDXFLD" , 0 }, ;
             { "X3_AGRUP"  , 0 }, { "X3_PYME"   , 0 } }

aEval( aEstrut, { |x| x[2] := SX3->( FieldPos( x[1] ) ) } )


aAdd( aSX3, {'SA1','S1','A1_YSALES','C',3,0,'Sales Chanel','Sales Chanel','Sales Chanel','Sales Chanel','Sales Chanel','Sales Chanel','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'SA1','S2','A1_LJECOME','C',2,0,'Loja Ecomm','Loja Ecomm','Loja Ecomm','Loja E-commerce','Loja E-commerce','Loja E-commerce','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','01','ZA1_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal del Sistema','System Branch','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(128) + Chr(128),'','','','N','','','','','','','','','','','033','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','02','ZA1_ERRO','M',10,0,'Erro','Erro','Erro','Erro','Erro','Erro','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','03','ZA1_NOME','C',40,0,'Nome','Nombre','Name','Nome do cliente','Nombre del cliente','Client Name','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(147) + Chr(128),'','','','S','A','R','','','','','','','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','04','ZA1_END','C',50,0,'Endereco','Direccion','Address','Endereco do cliente','Direccion do cliente','Customer´s address','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(147) + Chr(128),'','S','','N','A','R','€','','','','','','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','05','ZA1_PESSOA','C',1,0,'Fisica/Jurid','Fisic/Jurid.','Natur./Legal','Pessoa Fisica/Juridica','Persona Fisica/Juridica','Nat. Person/Legal Entity','@!','Pertence(" FJ")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(147) + Chr(128),'','','','N','A','R','€','','F=Fisica;J=Juridica','F=Fisica;J=Juridica','F=Natural;J=Legal','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','06','ZA1_NREDUZ','C',30,0,'N Fantasia','Nom Fantasia','Trade Name','Nome Reduzido do cliente','Nom. Reducido del Cliente','Customer Short Name','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(147) + Chr(128),'','','','S','A','R','','','','','','','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','07','ZA1_TIPO','C',1,0,'Tipo','Tipo','Type','Tipo do Cliente','Tipo de Cliente','Type of Customer','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(135) + Chr(128),'','S','','S','','','','','F=Cons.Final;L=Produtor Rural;R=Revendedor;S=Solidario;X=Exportacao','F=Cons.Final;L=Productor Rural;R=Revendedor;S=Solidario;X=Exportacion','F=Final Consumer;L=Rural Producer;R=Reseller;S=Solidary;X=Export','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','08','ZA1_EST','C',2,0,'Estado','Est.Cliente','State','Estado do cliente','Estado del Cliente','Customer State','@!','ExistCpo("SX5","12"+M->ZA1_EST) .AND. IE(M->A1_INSCR,M->ZA1_EST)',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','12',1,Chr(151) + Chr(128),'','S','','N','','','€','','','','','','','','010','1','','','S','N','','','','','S'} )
aAdd( aSX3, {'ZA1','09','ZA1_NATURE','C',10,0,'Natureza','Modalidad','Class','Codigo da Nat Financeira','Cod de la Mod Financiera','Financ.Class Code','@!','FinVldNat( .T., , 1 )',Chr(255) + Chr(255) + Chr(236) + Chr(129) + Chr(128) +Chr(139) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','SED',1,Chr(130) + Chr(192),'','','','N','V','R','€','','','','','','','','','2','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','10','ZA1_COD_MU','C',5,0,'Cd.Municipio','Cd.Municipio','City Code','Código do Municipio','Codigo del Municipio','City Code','@99999','ExistCpo("CC2",M->ZA1_EST+M->ZA1_COD_MU)',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','CC2SA1',1,Chr(154) + Chr(192),'','S','','N','','','€','','','','','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','11','ZA1_MUN','C',25,0,'Municipio','Municipio','Municipality','Municipio do cliente','Municipio del cliente','Customer Municipality','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(147) + Chr(128),'','S','','N','A','R','€','','','','','','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','12','ZA1_BAIRRO','C',30,0,'Bairro','Barrio','District','Bairro do cliente','Barrio del cliente','Customer District','@S15','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','S','','N','A','R','€','','','','','','','','','1','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','13','ZA1_CEP','C',8,0,'CEP','CP','Zip Code','Cod Enderecamento Postal','Cod Direccion Postal','Zip Code','@R 99999-999','A030Cep()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','S','','N','A','R','€','','','','','','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','14','ZA1_TEL','C',15,0,'Telefone','Telefono','Phone','Telefone do cliente','Telefono del cliente','Customer Phone','@R 9999999999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','','N','A','R','€','','','','','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','15','ZA1_ENDCOB','C',40,0,'End.Cobranca','Dir.Cobranza','Collec.Addr.','End.de cobr. do cliente','Dir. de cobr. del cliente','Custm.Collec.Address','@!','',Chr(255) + Chr(255) + Chr(236) + Chr(128) + Chr(128) +Chr(139) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','',1,Chr(146) + Chr(192),'','','','N','A','R','€','','','','','','','','','2','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','16','ZA1_DDD','C',3,0,'DDD','DDN','DDD','Codigo do DDD','Codigo del DDN','DDD Code','999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(147) + Chr(128),'','','','N','A','R','€','','','','','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','17','ZA1_BAIRRC','C',20,0,'Bairro Cobr','Barrio Cob','Coll. Distr.','Bairro de Cobranca','Barrio del Cobranza','District for collection','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(128),'','','','N','A','R','€','','','','','','','','','','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','18','ZA1_CEPC','C',8,0,'Cep de Cobr.','CP de Cobr.','Coll. Zip Cd','Cep de Cobranca','CP de Cobranza','Collection Zip Code','@R 99999-999','A030Cep("C")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','','2','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','19','ZA1_MUNC','C',15,0,'Mun. Cobr.','Ciud.Cobr.','Coll. City','Municipio de Cobranca','Municipio de Cobro','Collection City','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','','2','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','20','ZA1_ESTC','C',2,0,'Uf de Cobr.','Estad.Cobro','State f/ Inv','Uf de Cobranca','Est. de Cobro','State for Invoicing','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','010','2','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','21','ZA1_ENDENT','C',50,0,'End.Entrega','Direcc.Entre','Dil.Address','End.de entr. do cliente','Dir.de entr. del cliente','Customer del.address','@!','',Chr(255) + Chr(255) + Chr(236) + Chr(128) + Chr(128) +Chr(139) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','',1,Chr(146) + Chr(192),'','','','N','A','R','€','','','','','','','','','3','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','22','ZA1_BAIRRE','C',20,0,'Bairro Entr.','Barrio Entr.','Deliv.Distr.','Bairro de Entrega','Barrio de Entrega','District for delivery','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','','3','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','23','ZA1_CEPE','C',8,0,'Cep Entr','CP Entr','Del. Zip Cd.','Cep de Entrega','CP de Entrega','Delivery Zip Code','@R 99999-999','A030Cep("E")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','','3','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','24','ZA1_MUNE','C',15,0,'Mun. entr','Ciud.Entr.','Del. City','Municipio de Entrega','Ciudad de Entrega','City for Delivery','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','','3','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','25','ZA1_X_LOCZ','C',1,0,'Localidade','Localidade','Localidade','Localidade','Localidade','Localidade','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','C=Capital;I=Interior;D=Divisa','','','','','','','2','','','','','','','','',''} )
aAdd( aSX3, {'ZA1','26','ZA1_ESTE','C',2,0,'Uf Entr','E/P/R Entreg','Deliv.State','Estado de Entrega','Estado de Entrega','State of Delivery','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','R','€','','','','','','','','010','3','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','27','ZA1_CGC','C',14,0,'CNPJ/CPF','CNPJ/CPF','CNPJ/CPF','CNPJ/CPF do cliente','CNPJ/CPF del cliente','Customer`s CNPJ/CPF','@R 99.999.999/9999-99','Vazio() .Or. IIF( M->A1_TIPO == "X", .T., (CGC(M->A1_CGC) .And. A030CGC(M->ZA1_PESSO, M->ZA1_CGC)))',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(130) + Chr(192),'','S','','N','A','R','','','','','','U_COM11PICT()','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','28','ZA1_INSCR','C',18,0,'Ins. Estad.','Insc.Estat.','State Regist','Inscricao Estadual','Registro Estatal','State Tax Registration Nr','@!','IE(M->ZA1_INSCR,M->ZA1_EST)',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','S','','N','A','R','€','','','','','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','29','ZA1_VEND','C',6,0,'Vendedor','Vendedor','Seller','Codigo do Vendedor','Codigo del Vendedor','Seller Code','@!','vazio().or.existcpo("SA3")',Chr(255) + Chr(255) + Chr(239) + Chr(253) + Chr(143) +Chr(255) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','SA3',1,Chr(130) + Chr(192),'','S','','N','A','R','€','','','','','','','','','2','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','30','ZA1_REGIAO','C',3,0,'Regiao','Region','Area','Regiao do Cliente','Region del Cliente','Customer Region','@!','',Chr(255) + Chr(255) + Chr(239) + Chr(253) + Chr(143) +Chr(255) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','A2',1,Chr(146) + Chr(192),'','','','S','','','','','','','','','','','','4','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','31','ZA1_CONTA','C',20,0,'C. Contabil','C. Contable','Ledger Acc.','Conta Contabil do cliente','Cta. Contable del cliente','Customer Ledger Account','@!','vazio().or. Ctb105Cta()',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','CT1',1,Chr(130) + Chr(192),'','','','N','V','R','€','','','','','','','','003','2','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','32','ZA1_TRANSP','C',6,0,'Transp.','Transp.','Carrier','Codigo da Transportadora','Codigo de Transportadora','Carrier Code','@!','vazio().or.existcpo("SA4")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SA4',1,Chr(130) + Chr(192),'','','','N','A','R','€','','','','','','','','','4','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','33','ZA1_TPFRET','C',1,0,'Tipo Frete','Tipo Flete','Freight Type','Tipo de Frete do cliente','Tipo de Flete del cliente','Freight Type','!','',Chr(255) + Chr(255) + Chr(239) + Chr(253) + Chr(128) +Chr(139) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','',1,Chr(130) + Chr(192),'','','','N','A','R','€','','C=CIF;F=FOB','C=CIF;F=FOB','C=CIF;F=FOB','','','','','3','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','34','ZA1_COND','C',3,0,'Cond. Pagto','Cond. Pago','Payment Mode','Condicao de Pagamento','Condicion de Pago','Payment Term','@!','Vazio().Or.ExistCpo("SE4")',Chr(255) + Chr(255) + Chr(239) + Chr(253) + Chr(143) +Chr(255) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','SE41',8,Chr(134) + Chr(192),'','','','S','A','R','','','','','','','','','','4','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','35','ZA1_TABELA','C',3,0,'Tabela Preco','Lista Precio','Price List','Tabela de preco padrao','Lista Estandar de Precio','Standard Price List','','Vazio().Or.ExistCpo("DA0")',Chr(255) + Chr(255) + Chr(239) + Chr(253) + Chr(128) +Chr(139) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','DA0',1,Chr(134) + Chr(192),'','','','N','A','R','€','','','','','','','','','4','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','36','ZA1_DTNASC','D',8,0,'Dt.Aber/Nasc','Fch Nacimien','Birth Date','Data de Abertura ou Nasc.','Fecha de Nacimiento','Date of Birth','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(134) + Chr(192),'','','','N','','','','','','','','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','37','ZA1_GRPTRI','C',3,0,'Grp.Trib.Cli','Grp.Clientes','Customer.Grp','Gr. de tributacao cliente','Grupo de Clientes','Customer Group','@!','',Chr(255) + Chr(255) + Chr(239) + Chr(253) + Chr(143) +Chr(255) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','Z-',1,Chr(130) + Chr(192),'','','','N','A','R','','','','','','','','','','3','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','38','ZA1_SATIV1','C',6,0,'Segmento 1','Segmento 1','Segment 1','Segmentacao de Ativid. 1','Ramo de Actividad 1','Segmentation of Activity1','999999','ExistCpo("SX5","T3"+M->ZA1_SATIV1)',Chr(132) + Chr(143) + Chr(128) + Chr(161) + Chr(136) +Chr(138) + Chr(240) + Chr(128) + Chr(128) + Chr(128) +Chr(131) + Chr(128) + Chr(128) + Chr(131) + Chr(128),'','T3',1,Chr(134) + Chr(128),'','S','','N','A','R','€','','','','','','','','','4','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','39','ZA1_EMAIL','C',60,0,'E-Mail','E-mail','e-mail','E-Mail','E-mail','e-mail','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(146) + Chr(192),'','','','N','A','R','','','','','','','','','','1','','','S','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','40','ZA1_GRPVEN','C',6,0,'Grp.Clientes','Grp.Ventas','Sale Group','Grupo de clientes','Grupo de Ventas.','Sale group','@!','Vazio() .or. ExistCpo("ACY")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','ACY',1,Chr(130) + Chr(192),'','','','N','A','R','€','','','','','','','','','4','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','41','ZA1_MSBLQL','C',1,0,'Bloqueado','Bloqueado','Locked','Bloqueia o Cliente','Bloquea el cliente','Lock Customer','@!','pertence("12")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',7,Chr(134) + Chr(192),'','','','','','','','','1=Sim;2=Näo','1=Si;2=No','1=Yes;2=No','','','','','1','','','N','N','','','','','S'} )
aAdd( aSX3, {'ZA1','42','ZA1_CODPAI','C',5,0,'Pais Bacen.','Pais Bacen.','C.Bk.Country','Cód. país Banco Central','Cod. pais Banco Central','Central Bank Country Code','@R 99999','ExistCpo("CCH")',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','CCH',1,Chr(158) + Chr(128),'','','','N','A','R','€','','','','','','','','','3','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','43','ZA1_COMPLE','C',50,0,'Complemento','Complemento','Complement','Complemento do endereço','Complemento de la direcc.','Address complement','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(150) + Chr(192),'','','','N','A','','','','','','','','','','','1','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','44','ZA1_CONTRI','C',1,0,'Contribuinte','Contribuyen.','Taxpayer','Contribuinte do ICMS','Contribuy. del ICMS','ICMS Taxpayer','@!',"Pertence(' 12')",Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(134) + Chr(192),'','','S','N','A','R','','','1=Sim;2=Não','1=Si;2=No','1=Yes;2=No','','','','','3','','','N','N','','','N','','S'} )
aAdd( aSX3, {'ZA1','45','ZA1_AGEND','C',1,0,'Tem Agendam?','Tem Agendam?','Tem Agendam?','','','','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','1=Sim;2=Nao','','','','','','','1','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','46','ZA1_FRETE','C',1,0,'Paga Frete?','Paga Frete?','Paga Frete?','Cliente Paga Frete?','Cliente Paga Frete?','Cliente Paga Frete?','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','€','','1=Sim;2=Nao','1=Sim;2=Nao','1=Sim;2=Nao','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','47','ZA1_TEMODA','C',1,0,'Tem Modal?','Tem Modal?','Tem Modal?','Cliente tem modal proprio','Cliente tem modal proprio','Cliente tem modal proprio','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','€','','1=Sim;2=Nao','1=Sim;2=Nao','1=Sim;2=Nao','','UPPER(CUSERNAME) $ UPPER(GETMV("MV_UTMODAL"))','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','48','ZA1_OPER','C',3,0,'Operacao PCO','Operacao PCO','Operacao PCO','Operacao PCO','Operacao PCO','Operacao PCO','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','1','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','49','ZA1_YCANAL','C',6,0,'Canal Vendas','Canal Vendas','Canal Vendas','Canal Vendas','Canal Vendas','Canal Vendas','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','ACA',0,Chr(254) + Chr(192),'','S','U','N','A','R','€','','','','','','','','','4','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','50','ZA1_XGRPCO','C',6,0,'Grupo Comex','Grupo Comex','Grupo Comex','Grupo Comex','Grupo Comex','Grupo Comex','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','ZS',1,Chr(254) + Chr(192),'','','U','N','A','R','€','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','51','ZA1_XSORTE','C',1,0,'Sorter?','Sorter?','Sorter?','Sorter?','Sorter?','Sorter?','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(32),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','1=Sim;2=Nao','1=Sim;2=Nao','1=Sim;2=Nao','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZA1','52','ZA1_PVVTEX','C',50,0,'PV Vtex','PV Vtex','PV Vtex','PV Vtex','PV Vtex','PV Vtex','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZA1','53','ZA1_CODSA1','C',6,0,'Cod.Cliente','Cod.Cliente','Cod.Cliente','Cod.Cliente','Cod.Cliente','Cod.Cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )

aAdd( aSX3, {'ZC5','01','ZC5_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',1,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','033','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','02','ZC5_NUM','N',6,0,'PV Chiashop','NumeroPedido','NumeroPedido','NumeroPedido Ciashop','NumeroPedido Ciashop','NumeroPedido Ciashop','@E 999999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','03','ZC5_NUMPV','C',6,0,'PV Protheus','Pedido Proth','Pedido Proth','Numero PV Protheus','Numero PV Protheus','Numero PV Protheus','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','04','ZC5_PVVTEX','C',50,0,'Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','@S25','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','05','ZC5_DTVTEX','D',8,0,'Data Vtex','Data Vtex','Data Vtex','Data Vtex','Data Vtex','Data Vtex','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','06','ZC5_PREVEN','C',1,0,'Pre Venda?','Pre Venda?','Pre Venda?','Pre Venda?','Pre Venda?','Pre Venda?','!@','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','S=Sim;N=Não','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','07','ZC5_CLIENT','C',6,0,'Cliente','Cliente','Cliente','Cliente','Cliente','Cliente','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SA1',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','08','ZC5_LOJA','C',2,0,'Loja','Loja','Loja','Loja','Loja','Loja','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','09','ZC5_NOME','C',50,0,'Nome Cliente','Nome Cliente','Nome Cliente','Nome do cliente','Nome do cliente','Nome do cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'Posicione("SA1",1,xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA,"A1_NOME")','',0,Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','Posicione("SA1",1,xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA,"A1_NOME")','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','10','ZC5_NOECOM','C',30,0,'Nome Loja','Nome Loja','Nome Loja','Nome Loja','Nome Loja','Nome Loja','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','11','ZC5_COND','C',3,0,'Forma Pagto','Forma Pagto','Forma Pagto','Forma Pagamento','Forma Pagamento','Forma Pagamento','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','24',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','12','ZC5_TPPGTO','C',2,0,'Tp Pagamento','Tp Pagamento','Tp Pagamento','Tipo Pagamento','Tipo Pagamento','Tipo Pagamento','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','S','V','R','','','#U_VTEX00TP("00002")','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','13','ZC5_STATUS','C',2,0,'Status PV','Status PV','Status PV','Status PV','Status PV','Status PV','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','14','ZC5_DTWMS','D',8,0,'Dt.Env.WMS','Dt.Env.WMS','Dt.Env.WMS','Data Envio WMS','Data Envio WMS','Data Envio WMS','@D','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'IIF(FINDFUNCTION("U_M011DTWMS"),U_M011DTWMS(),CTOD("  /  /"))','',0,Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','IIF(FINDFUNCTION("U_M011DTWMS"),U_M011DTWMS(),CTOD(""))','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','15','ZC5_ATUALI','C',1,0,'Atualiza','Atualiza','Atualiza','Atualiza Status','Atualiza Status','Atualiza Status','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'"N"','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','S=Sim;N=Nao','S=Sim;N=Nao','S=Sim;N=Nao','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','16','ZC5_NOTA','C',9,0,'Nota Fiscal','Nota Fiscal','Nota Fiscal','Nota Fiscal','Nota Fiscal','Nota Fiscal','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','17','ZC5_SERIE','C',3,0,'Serie','Serie','Serie','Serie','Serie','Serie','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','18','ZC5_EMISNF','D',8,0,'Emissao NF','Emissao NF','Emissao NF','Emissao NF','Emissao NF','Emissao NF','@D','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','Posicione("SF2",1,xFilial("SF2")+ZC5->(ZC5_NOTA+ZC5_SERIE),"F2_EMISSAO")','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','19','ZC5_DTSAID','D',8,0,'Dt. Saida NF','Dt. Saida NF','Dt. Saida NF','Dt. Saida NF','Dt. Saida NF','Dt. Saida NF','@D','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','Posicione("SZ1",1,xFilial("SZ1")+ZC5->(ZC5_NOTA+ZC5_SERIE),"Z1_DTSAIDA")','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','20','ZC5_DTENTR','D',8,0,'Dt.EntregaNF','Dt.EntregaNF','Dt.EntregaNF','Dt.EntregaNF','Dt.EntregaNF','Dt.EntregaNF','@D','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','V','','','','','','','','Posicione("SZ1",1,xFilial("SZ1")+ZC5->(ZC5_NOTA+ZC5_SERIE),"Z1_DTENTRE")','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','21','ZC5_TOTAL','N',14,2,'Total Pedido','Total Pedido','Total Pedido','Total Pedido','Total Pedido','Total Pedido','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','22','ZC5_QTDPAR','N',3,0,'Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','Qtd Parcelas','@E 999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','23','ZC5_ESTORN','C',1,0,'Estorno','Estorno','Estorno','Estorno','Estorno','Estorno','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','N=Não;S=Sim','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','24','ZC5_FRETE','N',14,4,'Frete Pedido','Frete Pedido','Frete Pedido','Frete Pedido','Frete Pedido','Frete Pedido','@E 99,999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','25','ZC5_DOCDEV','C',9,0,'Doc.Devol.','Doc.Devol.','Doc.Devol.','Documento de devoluçao','Documento de devoluçao','Documento de devoluçao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','26','ZC5_SERDEV','C',3,0,'Serie Dev.','Serie Dev.','Serie Dev.','Serie de devoluçao','Serie de devoluçao','Serie de devoluçao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','27','ZC5_IDTRAN','C',50,0,'Id Transacao','Id Transacao','Id Transacao','Id Transacao','Id Transacao','Id Transacao','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','28','ZC5_CODENT','C',5,0,'Form. Entreg','Form. Entreg','Form. Entreg','Form. Entreg','Form. Entreg','Form. Entreg','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','29','ZC5_FLAG','C',1,0,'Flag','Flag','Flag','Flag','Flag','Flag','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','30','ZC5_CADAST','C',10,0,'Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','31','ZC5_CODCIA','C',10,0,'Cod. CIASHOP','Cod. CIASHOP','Cod. CIASHOP','Codigo CIASHOP','Codigo CIASHOP','Codigo CIASHOP','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','32','ZC5_NOMCIA','C',50,0,'Nome','Nome','Nome','Nome','Nome','Nome','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','33','ZC5_VDESCO','N',12,2,'Vlr.Desconto','Vlr.Desconto','Vlr.Desconto','Valor do Desconto','Valor do Desconto','Valor do Desconto','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','34','ZC5_PDESCO','N',6,2,'% Desconto','% Desconto','% Desconto','Percentual de Desconto','Percentual de Desconto','Percentual de Desconto','@E 999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','35','ZC5_PAGTO','C',1,0,'Pagamento','Pagamento','Pagamento','Pagamento','Pagamento','Pagamento','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','1=Aguard.Pagamento;2=Pago','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','36','ZC5_RASTRE','C',25,0,'Cod.Rastreio','Cod.Rastreio','Cod.Rastreio','Codigo Rastreio','Codigo Rastreio','Codigo Rastreio','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','S','U','S','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','37','ZC5_MSEXP','C',8,0,'Ident.Exp.','Ident.Exp.','Ident.Exp.','Ident.Exp.Dados','Ident.Exp.Dados','Ident.Exp.Dados','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',9,Chr(254) + Chr(192),'','','L','S','V','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','38','ZC5_CODINT','C',3,0,'Cod.Int.Sts','Cod.Int.Sts','Cod.Int.Sts','Cod.Int.Sts','Cod.Int.Sts','Cod.Int.Sts','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','39','ZC5_YMSEXP','D',8,0,'Data exporta','Data exporta','Data exporta','Data exportacao','Data exportacao','Data exportacao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','40','ZC5_ENDENT','C',50,0,'End.Entrega','End.Entrega','End.Entrega','End.de entr. do cliente','End.de entr. do cliente','End.de entr. do cliente','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','41','ZC5_BAIROE','C',20,0,'Bairro Entr.','Bairro Entr.','Bairro Entr.','Bairro de Entrega','Bairro de Entrega','Bairro de Entrega','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','42','ZC5_CEPE','C',8,0,'Cep Entr','Cep Entr','Cep Entr','Cep Entrega','Cep Entrega','Cep Entrega','@R 99999-999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','43','ZC5_MUNE','C',60,0,'Mun. entr','Mun. entr','Mun. entr','Municipio de Entrega','Municipio de Entrega','Municipio de Entrega','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','44','ZC5_CODMUE','C',5,0,'Cod.Mun.Entr','Cod.Mun.Entr','Cod.Mun.Entr','Codigo Municipio Entrega','Codigo Municipio Entrega','Codigo Municipio Entrega','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','45','ZC5_ESTE','C',2,0,'Uf Entr','Uf Entr','Uf Entr','Estado de Entrega','Estado de Entrega','Estado de Entrega','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','46','ZC5_COMPLE','C',50,0,'Compl.Entreg','Compl.Entreg','Compl.Entreg','Complemento Entrega','Complemento Entrega','Complemento Entrega','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','47','ZC5_PLATAF','C',2,0,'Plataforma','Plataforma','Plataforma','Plataforma','Plataforma','Plataforma','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','01=CiaShop;02=ProximoGames;03=UzGames','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','48','ZC5_ORIGEM','C',25,0,'Origem','Origem','Origem','Origem','Origem','Origem','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(65),'','','U','N','V','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC5','49','ZC5_SALES','C',3,0,'Sales','Sales','Sales','Sales','Sales','Sales','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','50','ZC5_CONDPG','C',3,0,'Cond. Pagto','Cond. Pagto','Cond. Pagto','Cond. de Pagamento','Cond. de Pagamento','Cond. de Pagamento','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC5','51','ZC5_LJECOM','C',2,0,'Loja Ecomme','Loja Ecomme','Loja Ecomme','Loja do E-commerce','Loja do E-commerce','Loja do E-commerce','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )

aAdd( aSX3, {'ZC6','01','ZC6_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','02','ZC6_NUM','N',6,0,'Numero PV','Numero PV','Numero PV','Numero PV','Numero PV','Numero PV','@E 999999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','03','ZC6_ITEM','C',2,0,'Item PV','Item PV','Item PV','Item PV','Item PV','Item PV','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','04','ZC6_PRODUT','C',15,0,'Produto','Produto','Produto','Produto','Produto','Produto','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','SB1',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','05','ZC6_QTDVEN','N',12,2,'Qtd Vendida','Qtd Vendida','Qtd Vendida','Qtd Vendida','Qtd Vendida','Qtd Vendida','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','S','U','S','A','R','€','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC6','06','ZC6_VLRUNI','N',12,2,'Valor Unit','Valor Unit','Valor Unit','Valor Unitario','Valor Unitario','Valor Unitario','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','S','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','07','ZC6_VLRTOT','N',12,2,'Valor Total','Valor Total','Valor Total','Valor Total','Valor Total','Valor Total','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','A','R','€','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','08','ZC6_QTDRES','N',12,2,'Qtd Reserva','Qtd Reserva','Qtd Reserva','Qtd Reserva','Qtd Reserva','Qtd Reserva','@E 999,999,999.99','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','09','ZC6_LOCAL','C',2,0,'Local','Local','Local','Local','Local','Local','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC6','10','ZC6_EAN','C',15,0,'EAN','EAN','EAN','EAN','EAN','EAN','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','S','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC6','11','ZC6_IDPROD','C',25,0,'Id Prod Site','Id Prod Site','Id Prod Site','Id Prod Site','Id Prod Site','Id Prod Site','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC6','12','ZC6_PVVTEX','C',30,0,'Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC6','13','ZC6_DESCRI','C',50,0,'Desc.Produto','Desc.Produto','Desc.Produto','Descricao do Produto Site','Descricao do Produto Site','Descricao do Produto Site','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )
aAdd( aSX3, {'ZC7','01','ZC7_FILIAL','C',2,0,'Filial','Sucursal','Branch','Filial do Sistema','Sucursal','Branch of the System','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',1,Chr(254) + Chr(192),'','','U','N','','','','','','','','','','','033','','','','','','','','','',''} )

aAdd( aSX3, {'ZC7','02','ZC7_NUM','C',6,0,'Pedido','Pedido','Pedido','Numero do pedido','Numero do pedido','Numero do pedido','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','03','ZC7_ACAO','C',70,0,'Processo','Processo','Processo','Descricao do processo','Descricao do processo','Descricao do processo','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','04','ZC7_DATA','D',8,0,'Dt.Log','Dt.Log','Dt.Log','Data do log','Data do log','Data do log','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','05','ZC7_HORA','C',10,0,'Hora','Hora','Hora','Hora','Hora','Hora','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','06','ZC7_USUARI','C',50,0,'Usuario','Usuario','Usuario','Usuario','Usuario','Usuario','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','07','ZC7_OBS','M',10,0,'Observacao','Observacao','Observacao','Observacao','Observacao','Observacao','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','08','ZC7_ERRO','C',2,0,'Flag','Flag','Flag','Flag','Flag','Flag','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','09','ZC7_PVECOM','N',6,0,'Pedido Site','Pedido Site','Pedido Site','Pedido Site','Pedido Site','Pedido Site','@E 999,999','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','10','ZC7_STATPV','C',2,0,'Status PV','Status PV','Status PV','Status PV','Status PV','Status PV','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','11','ZC7_CADAST','C',10,0,'Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','Cadastro','@!','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','12','ZC7_CODCIA','C',10,0,'Cod. CIASHOP','Cod. CIASHOP','Cod. CIASHOP','Codigo CIASHOP','Codigo CIASHOP','Codigo CIASHOP','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','A','R','','','','','','','','','','','','','','','','','','',''} )
aAdd( aSX3, {'ZC7','13','ZC7_PVVTEX','C',50,0,'Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','Pedido Vtex','','',Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) +Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160),'','',0,Chr(254) + Chr(192),'','','U','N','V','R','','','','','','','','','','','','','','N','','','N','',''} )

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
	// Verifica se o campo faz parte de um grupo e ajusta tamanho
	//
	If !Empty( aSX3[nI][nPosSXG] )
		SXG->( dbSetOrder( 1 ) )
		If SXG->( MSSeek( aSX3[nI][nPosSXG] ) )
			If aSX3[nI][nPosTam] <> SXG->XG_SIZE
				aSX3[nI][nPosTam] := SXG->XG_SIZE
				AutoGrLog( "O tamanho do campo " + aSX3[nI][nPosCpo] + " NÃO atualizado e foi mantido em [" + ;
				AllTrim( Str( SXG->XG_SIZE ) ) + "]" + CRLF + ;
				" por pertencer ao grupo de campos [" + SXG->XG_GRUPO + "]" + CRLF )
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

		AutoGrLog( "Criado campo " + aSX3[nI][nPosCpo] )

	EndIf

	oProcess:IncRegua2( "Atualizando Campos de Tabelas (SX3)..." )

Next nI

AutoGrLog( CRLF + "Final da Atualização" + " SX3" + CRLF + Replicate( "-", 128 ) + CRLF )

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSIX
Função de processamento da gravação do SIX - Indices

@author TOTVS Protheus
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSIX()
Local aEstrut   := {}
Local aSIX      := {}
Local lAlt      := .F.
Local lDelInd   := .F.
Local nI        := 0
Local nJ        := 0

AutoGrLog( "Ínicio da Atualização" + " SIX" + CRLF )

aEstrut := { "INDICE" , "ORDEM" , "CHAVE", "DESCRICAO", "DESCSPA"  , ;
             "DESCENG", "PROPRI", "F3"   , "NICKNAME" , "SHOWPESQ" }

aAdd( aSIX, {'SA1','A','A1_FILIAL+A1_COD+A1_LJECOME+A1_YSALES','Codigo+Loja Ecomm+Sales Chanel','Codigo+Loja Ecomm+Sales Chanel','Codigo+Loja Ecomm+Sales Chanel','U','','SA1SALES','N'} )
aAdd( aSIX, {'ZA1','1','ZA1_FILIAL+ZA1_PVVTEX','PV Vtex','PV Vtex','PV Vtex','U','','','S'} )
aAdd( aSIX, {'ZC5','5','ZC5_FILIAL+ZC5_PLATAF+ZC5_PVVTEX','Plataforma+Pedido Vtex','Origem+Pedido Vtex','Origem+Pedido Vtex','U','','','S'} )
aAdd( aSIX, {'ZC5','6','ZC5_FILIAL+ZC5_PVVTEX','Pedido Vtex','Pedido Vtex','Pedido Vtex','U','','','S'} )
aAdd( aSIX, {'ZC6','3','ZC6_FILIAL+ZC6_PVVTEX','Pedido Vtex','Pedido Vtex','Pedido Vtex','U','','','S'} )
aAdd( aSIX, {'ZC7','3','ZC7_FILIAL+ZC7_PVVTEX+ZC7_ACAO','Pedido Vtex+Acao','Pedido Vtex+Acao','Pedido Vtex+Acao','U','','','N'} )
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
		AutoGrLog( "Índice criado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] )
	Else
		lAlt := .T.
		aAdd( aArqUpd, aSIX[nI][1] )
		If !StrTran( Upper( AllTrim( CHAVE )       ), " ", "" ) == ;
		    StrTran( Upper( AllTrim( aSIX[nI][3] ) ), " ", "" )
			AutoGrLog( "Chave do índice alterado " + aSIX[nI][1] + "/" + aSIX[nI][2] + " - " + aSIX[nI][3] )
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

AutoGrLog( CRLF + "Final da Atualização" + " SIX" + CRLF + Replicate( "-", 128 ) + CRLF )

Return NIL


//--------------------------------------------------------------------
/*/{Protheus.doc} FSAtuSX7
Função de processamento da gravação do SX7 - Gatilhos

@author TOTVS Protheus
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function FSAtuSX7()
Local aEstrut   := {}
Local aAreaSX3  := SX3->( GetArea() )
Local aSX7      := {}
Local cAlias    := ""
Local nI        := 0
Local nJ        := 0
Local nTamSeek  := Len( SX7->X7_CAMPO )

AutoGrLog( "Ínicio da Atualização" + " SX7" + CRLF )

aEstrut := { "X7_CAMPO", "X7_SEQUENC", "X7_REGRA", "X7_CDOMIN", "X7_TIPO", "X7_SEEK", ;
             "X7_ALIAS", "X7_ORDEM"  , "X7_CHAVE", "X7_PROPRI", "X7_CONDIC" }

aAdd( aSX7, {'ZA1_BAIRRO','001','M->ZA1_BAIRRO','ZA1_BAIRRE','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_BAIRRO','002','M->ZA1_BAIRRO','ZA1_BAIRRC','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_CEP','001','M->ZA1_CEP','ZA1_CEPE','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_CEP','002','M->ZA1_CEP','ZA1_CEPC','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_END','001','U_M001END(M->ZA1_END )','ZA1_END','P','N','',0,'','U','FindFunction("U_M001END")'} )
aAdd( aSX7, {'ZA1_END','002','M->ZA1_END','ZA1_ENDCOB','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_END','003','M->ZA1_END','ZA1_ENDENT','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_INSCR','001','U_VALIDIE(M->ZA1_INSCR,M->ZA1_PESSOA)','ZA1_INSCR','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_INSCR','002','IF(M->ZA1_INSCR=="ISENTO","CFIE","CFIE")','ZA1_GRPTRI','P','N','',0,'','U','M->ZA1_TIPO=="F"'} )
aAdd( aSX7, {'ZA1_MUN','001','M->ZA1_MUN','ZA1_MUNE','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_MUN','002','M->ZA1_MUN','ZA1_MUNC','P','N','',0,'','U',''} )
aAdd( aSX7, {'ZA1_YCANAL','001','GETADVFVAL("ACA","ACA_DESCRI",xFilial("ACA")+M->A1_YCANAL,1,"")','ZA1_YDCANA','P','N','',0,'','U',''} )
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
			AutoGrLog( "Foi incluído o gatilho " + aSX7[nI][1] + "/" + aSX7[nI][2] )
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

AutoGrLog( CRLF + "Final da Atualização" + " SX7" + CRLF + Replicate( "-", 128 ) + CRLF )

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
Local   aRet      := {}
Local   aSalvAmb  := GetArea()
Local   aSalvSM0  := {}
Local   aVetor    := {}
Local   cMascEmp  := "??"
Local   cVar      := ""
Local   lChk      := .F.
Local   lOk       := .F.
Local   lTeveMarc := .F.
Local   oNo       := LoadBitmap( GetResources(), "LBNO" )
Local   oOk       := LoadBitmap( GetResources(), "LBOK" )
Local   oDlg, oChkMar, oLbx, oMascEmp, oSay
Local   oButDMar, oButInv, oButMarc, oButOk, oButCanc

Local   aMarcadas := {}


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

Define MSDialog  oDlg Title "" From 0, 0 To 280, 395 Pixel

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

@ 112, 10 CheckBox oChkMar Var  lChk Prompt "Todos" Message "Marca / Desmarca"+ CRLF + "Todos" Size 40, 007 Pixel Of oDlg;
on Click MarcaTodos( lChk, @aVetor, oLbx )

// Marca/Desmarca por mascara
@ 113, 51 Say   oSay Prompt "Empresa" Size  40, 08 Of oDlg Pixel
@ 112, 80 MSGet oMascEmp Var  cMascEmp Size  05, 05 Pixel Picture "@!"  Valid (  cMascEmp := StrTran( cMascEmp, " ", "?" ), oMascEmp:Refresh(), .T. ) ;
Message "Máscara Empresa ( ?? )"  Of oDlg
oSay:cToolTip := oMascEmp:cToolTip

@ 128, 10 Button oButInv    Prompt "&Inverter"  Size 32, 12 Pixel Action ( InvSelecao( @aVetor, oLbx, @lChk, oChkMar ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Inverter Seleção" Of oDlg
oButInv:SetCss( CSSBOTAO )
@ 128, 50 Button oButMarc   Prompt "&Marcar"    Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .T. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Marcar usando" + CRLF + "máscara ( ?? )"    Of oDlg
oButMarc:SetCss( CSSBOTAO )
@ 128, 80 Button oButDMar   Prompt "&Desmarcar" Size 32, 12 Pixel Action ( MarcaMas( oLbx, aVetor, cMascEmp, .F. ), VerTodos( aVetor, @lChk, oChkMar ) ) ;
Message "Desmarcar usando" + CRLF + "máscara ( ?? )" Of oDlg
oButDMar:SetCss( CSSBOTAO )
@ 112, 157  Button oButOk   Prompt "Processar"  Size 32, 12 Pixel Action (  RetSelecao( @aRet, aVetor ), oDlg:End()  ) ;
Message "Confirma a seleção e efetua" + CRLF + "o processamento" Of oDlg
oButOk:SetCss( CSSBOTAO )
@ 128, 157  Button oButCanc Prompt "Cancelar"   Size 32, 12 Pixel Action ( IIf( lTeveMarc, aRet :=  aMarcadas, .T. ), oDlg:End() ) ;
Message "Cancela o processamento" + CRLF + "e abandona a aplicação" Of oDlg
oButCanc:SetCss( CSSBOTAO )

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
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
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


//--------------------------------------------------------------------
/*/{Protheus.doc} LeLog
Função de leitura do LOG gerado com limitacao de string

@author TOTVS Protheus
@since  01/05/2015
@obs    Gerado por EXPORDIC - V.4.22.10.8 EFS / Upd. V.4.19.13 EFS
@version 1.0
/*/
//--------------------------------------------------------------------
Static Function LeLog()
Local cRet  := ""
Local cFile := NomeAutoLog()
Local cAux  := ""

FT_FUSE( cFile )
FT_FGOTOP()

While !FT_FEOF()

	cAux := FT_FREADLN()

	If Len( cRet ) + Len( cAux ) < 1048000
		cRet += cAux + CRLF
	Else
		cRet += CRLF
		cRet += Replicate( "=" , 128 ) + CRLF
		cRet += "Tamanho de exibição maxima do LOG alcançado." + CRLF
		cRet += "LOG Completo no arquivo " + cFile + CRLF
		cRet += Replicate( "=" , 128 ) + CRLF
		Exit
	EndIf

	FT_FSKIP()
End

FT_FUSE()

Return cRet


/////////////////////////////////////////////////////////////////////////////
