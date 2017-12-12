#INCLUDE "PROTHEUS.CH"
#ifdef SPANISH
	#define STR0001 "Rehace Acumulados"
	#define STR0002 "El objetivo de este programa es rehacer Saldos de Pedidos, Solicitudes y Ordenes de Produccion de Productos, basado en sus respectivos movimientos."
	#define STR0005 "ฟConfirma Rehace Acumulados?"
	#define STR0006 "Atencion"
	#define STR0007 "Act."
	#define STR0008 "ATENCION - Esta rutina se ejecutara en MODO EXCLUSIVO, por lo tanto solo esta estacion podra estar activa mientras se procese la rutina de Rehacer Acumulado."
	#define STR0009 "Inicio del procesamiento."
	#define STR0010 "Final del procesamiento."
	#define STR0011 "MATA215:No fue posible abrir todas las tablas de manera exclusiva."
	#define STR0012 "Inicio sucursal: "
	#define STR0013 "Final sucursal: "
	#define STR0014 "MA215CHECK: No fue posible la apertura de la tabla"
	#define STR0015 "Competencia"
	#define STR0016 "La empresa corriente ya esta siendo utilizada en el proceso de rehace acumulados: "
	#define STR0017 "Este programa tiene como objetivo rehacer los saldos de pedidos, solicitaciones y ordenes"
	#define STR0018 "de produccion de los productos con base en sus respectivos movimientos."
	#define STR0019 "ATENCION - Esta rutina se ejecutara en MODO EXCLUSIVO, por lo tanto solo esta estacion"
	#define STR0020 "podra estar activa mientras este procesando la rutina de Rehace Acumulado."
#else
	#ifdef ENGLISH
		#define STR0001 "Redo Accumulated"
		#define STR0002 "The purpose of this program is to remake the Order Balances, Requisitions and Production Orders based on their respective movements."
		#define STR0005 "Confirm Redo Accumulated ?"
		#define STR0006 "Attention"
		#define STR0007 "Upd."
		#define STR0008 "WARNING - This routine will run in EXCLUSIVE MODE, therefore only this workstation can be active while the Redo Accrued routine is being processed."
		#define STR0009 "Beginning of processing."
		#define STR0010 "End of processing."
		#define STR0011 "MATA215:It was not possible to open all tables exclusively."
		#define STR0012 "Branch Start: "
		#define STR0013 "Branch End: "
		#define STR0014 "MA215CHECK: The opening of table was not possible"
		#define STR0015 "Competition"
		#define STR0016 "Current company is used in accrued refaz process: "
		#define STR0017 "Este programa tem como objetivo refazer os Saldos de Pedidos, Solicita็๕es e Ordens"
		#define STR0018 "de Produ็ใo dos Produtos com base nos seus respectivos movimentos."
		#define STR0019 "ATENวรO - Esta rotina serแ executada em MODO EXCLUSIVO, portanto somente esta esta็ใo"
		#define STR0020 "poderแ estar ativa enquanto estiver processando a rotina de Refaz Acumulado."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Refazer A Acumula็ใo", "Refaz Acumulados" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Este programa tem como objectivo refazer os saldos de pedidos, solicita็๕es e ordens de produ็ใo dos artigos com base nos seus respectivos movimentos.", "Este programa tem como objetivo refazer os Saldos de Pedidos, Solicitacoes e Ordens de Producao dos Produtos com base nos seus respectivos movimentos." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Confirmar a nova opera็ใo de acumular       ?", "Confirma Refaz Acumulados       ?" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Aten็ใo", "Aten็ไo" )
		#define STR0007 "Proc."
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Aten็ใo - este procedimento serแ executado em modo exclusivo, portanto apenas esta esta็ใo poderแ estar activa enquanto estiver a processar o procedimento de refazer acumulado.", "ATENวรO - Esta rotina serแ executada em MODO EXCLUSIVO, portanto somente esta esta็ใo podera estar ativa enquanto estiver processando a rotina de Refaz Acumulado." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Fim do processamento.", "Inํcio do processamento." )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Fim do processamento.", "T้rmino do processamento." )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "MATA215:Nใo foi possํvel abrir todas as tabelas de forma exclusiva.", "MATA215:Nใo foi possivel abrir todas as tabelas de forma exclusiva." )
		#define STR0012 "Inicio Filial: "
		#define STR0013 "Final Filial: "
		#define STR0014 "MA215CHECK: Nใo foi possivel a abertura da tabela"
		#define STR0015 "Concorr๊ncia"
		#define STR0016 "A empresa corrente jแ esta sendo utilizadas no processo de refaz acumulados: "
		#define STR0017 "Este programa tem como objetivo refazer os Saldos de Pedidos, Solicita็๕es e Ordens"
		#define STR0018 "de Produ็ใo dos Produtos com base nos seus respectivos movimentos."
		#define STR0019 "ATENวรO - Esta rotina serแ executada em MODO EXCLUSIVO, portanto somente esta esta็ใo"
		#define STR0020 "poderแ estar ativa enquanto estiver processando a rotina de Refaz Acumulado."
	#endif
#endif

#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ compsx   บ Autor ณ TOTVS Protheus     บ Data ณ  14/06/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de update dos dicionแrios para compatibiliza็ใo     ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ compsx     - Gerado por COMPADIC / Upd. V.4.10.6 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function updpr700( cEmpAmb, cFilAmb )

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
					MsgStop( "Atualiza็ใo Realizada.", "COMPSX" )
					dbCloseAll()
				Else
					MsgStop( "Atualiza็ใo nใo Realizada.", "COMPSX" )
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
			MsgStop( "Atualiza็ใo nใo Realizada.", "COMPSX" )
			
		EndIf
		
	Else
		MsgStop( "Atualiza็ใo nใo Realizada.", "COMPSX" )
		
	EndIf
	
EndIf

Return NIL


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Programa ณ FSTProc  บ Autor ณ TOTVS Protheus     บ Data ณ  14/06/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da grava็ใo dos arquivos           ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSTProc    - Gerado por COMPADIC / Upd. V.4.10.6 EFS       ณฑฑ
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
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza o dicionแrio SX3         ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			FSAtuSX3( @cTexto )
			
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
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza o dicionแrio SXA         ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			oProcess:IncRegua1( "Dicionแrio de pastas" + " - " + SM0->M0_CODIGO + " " + SM0->M0_NOME + " ..." )
			FSAtuSXA( @cTexto )
			
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
ฑฑบ Programa ณ FSAtuSX3 บ Autor ณ TOTVS Protheus     บ Data ณ  14/06/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SX3 - Campos        ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSX3   - Gerado por COMPADIC / Upd. V.4.10.6 EFS       ณฑฑ
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

//
// Tabela SC5
//

aAdd( aSX3, { ;
'SC5'																	, ; //X3_ARQUIVO
'L3'																	, ; //X3_ORDEM
'C5_YPEDPAI'															, ; //X3_CAMPO
'C'																		, ; //X3_TIPO
6																		, ; //X3_TAMANHO
0																		, ; //X3_DECIMAL
'Pedido Pai'															, ; //X3_TITULO
'Pedido Pai'															, ; //X3_TITSPA
'Pedido Pai'															, ; //X3_TITENG
'Pedido Pai'															, ; //X3_DESCRIC
'Pedido Pai'															, ; //X3_DESCSPA
'Pedido Pai'															, ; //X3_DESCENG
''																		, ; //X3_PICTURE
'Vazio() .Or. U_PR700VAL()'												, ; //X3_VALID
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160)					, ; //X3_USADO
''																		, ; //X3_RELACAO
'PVPAI'																	, ; //X3_F3
0																		, ; //X3_NIVEL
Chr(254) + Chr(192)														, ; //X3_RESERV
''																		, ; //X3_CHECK
''																		, ; //X3_TRIGGER
'U'																		, ; //X3_PROPRI
'N'																		, ; //X3_BROWSE
'A'																		, ; //X3_VISUAL
'R'																		, ; //X3_CONTEXT
''																		, ; //X3_OBRIGAT
''																		, ; //X3_VLDUSER
''																		, ; //X3_CBOX
''																		, ; //X3_CBOXSPA
''																		, ; //X3_CBOXENG
''																		, ; //X3_PICTVAR
'!Empty(M->C5_XSTAPED) .And. M->C5_XSTAPED<>"00"'						, ; //X3_WHEN
''																		, ; //X3_INIBRW
''																		, ; //X3_GRPSXG
'6'																		, ; //X3_FOLDER
''																		} ) //X3_PYME

aAdd( aSX3, { ;
'SC5'																	, ; //X3_ARQUIVO
'L4'																	, ; //X3_ORDEM
'C5_YPERIOD'															, ; //X3_CAMPO
'C'																		, ; //X3_TIPO
1																		, ; //X3_TAMANHO
0																		, ; //X3_DECIMAL
'Periodo'																, ; //X3_TITULO
'Periodo'																, ; //X3_TITSPA
'Periodo'																, ; //X3_TITENG
'Perido'																, ; //X3_DESCRIC
'Perido'																, ; //X3_DESCSPA
'Perido'																, ; //X3_DESCENG
'@!'																	, ; //X3_PICTURE
''																		, ; //X3_VALID
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160)					, ; //X3_USADO
'"M"'																	, ; //X3_RELACAO
''																		, ; //X3_F3
0																		, ; //X3_NIVEL
Chr(254) + Chr(192)														, ; //X3_RESERV
''																		, ; //X3_CHECK
'S'																		, ; //X3_TRIGGER
'U'																		, ; //X3_PROPRI
'N'																		, ; //X3_BROWSE
'A'																		, ; //X3_VISUAL
'R'																		, ; //X3_CONTEXT
''																		, ; //X3_OBRIGAT
'Pertence("MBT")'														, ; //X3_VLDUSER
'M=Mensal;B=Bimestral;T=Trimestral'										, ; //X3_CBOX
''																		, ; //X3_CBOXSPA
''																		, ; //X3_CBOXENG
''																		, ; //X3_PICTVAR
'M->C5_XSTAPED=="00"'													, ; //X3_WHEN
''																		, ; //X3_INIBRW
''																		, ; //X3_GRPSXG
'6'																		, ; //X3_FOLDER
''																		} ) //X3_PYME

aAdd( aSX3, { ;
'SC5'																	, ; //X3_ARQUIVO
'L5'																	, ; //X3_ORDEM
'C5_YDTINIC'															, ; //X3_CAMPO
'D'																		, ; //X3_TIPO
8																		, ; //X3_TAMANHO
0																		, ; //X3_DECIMAL
'Data Inicio'															, ; //X3_TITULO
'Data Inicio'															, ; //X3_TITSPA
'Data Inicio'															, ; //X3_TITENG
'Data Inicio'															, ; //X3_DESCRIC
'Data Inicio'															, ; //X3_DESCSPA
'Data Inicio'															, ; //X3_DESCENG
'@D 99/99/9999'															, ; //X3_PICTURE
''																		, ; //X3_VALID
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160)					, ; //X3_USADO
''																		, ; //X3_RELACAO
''																		, ; //X3_F3
0																		, ; //X3_NIVEL
Chr(254) + Chr(192)														, ; //X3_RESERV
''																		, ; //X3_CHECK
'S'																		, ; //X3_TRIGGER
'U'																		, ; //X3_PROPRI
'N'																		, ; //X3_BROWSE
'A'																		, ; //X3_VISUAL
'R'																		, ; //X3_CONTEXT
''																		, ; //X3_OBRIGAT
'Vazio() .Or. U_PR700VAL()'												, ; //X3_VLDUSER
''																		, ; //X3_CBOX
''																		, ; //X3_CBOXSPA
''																		, ; //X3_CBOXENG
''																		, ; //X3_PICTVAR
'Empty(M->C5_YPEDPAI)'													, ; //X3_WHEN
''																		, ; //X3_INIBRW
''																		, ; //X3_GRPSXG
'6'																		, ; //X3_FOLDER
''																		} ) //X3_PYME

aAdd( aSX3, { ;
'SC5'																	, ; //X3_ARQUIVO
'L6'																	, ; //X3_ORDEM
'C5_YDTFIM'																, ; //X3_CAMPO
'D'																		, ; //X3_TIPO
8																		, ; //X3_TAMANHO
0																		, ; //X3_DECIMAL
'Data Final'															, ; //X3_TITULO
'Data Final'															, ; //X3_TITSPA
'Data Final'															, ; //X3_TITENG
'Data Final'															, ; //X3_DESCRIC
'Data Final'															, ; //X3_DESCSPA
'Data Final'															, ; //X3_DESCENG
'@D 99/99/99'															, ; //X3_PICTURE
''																		, ; //X3_VALID
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160)					, ; //X3_USADO
''																		, ; //X3_RELACAO
''																		, ; //X3_F3
0																		, ; //X3_NIVEL
Chr(254) + Chr(192)														, ; //X3_RESERV
''																		, ; //X3_CHECK
''																		, ; //X3_TRIGGER
'U'																		, ; //X3_PROPRI
'N'																		, ; //X3_BROWSE
'V'																		, ; //X3_VISUAL
'R'																		, ; //X3_CONTEXT
''																		, ; //X3_OBRIGAT
''																		, ; //X3_VLDUSER
''																		, ; //X3_CBOX
''																		, ; //X3_CBOXSPA
''																		, ; //X3_CBOXENG
''																		, ; //X3_PICTVAR
''																		, ; //X3_WHEN
''																		, ; //X3_INIBRW
''																		, ; //X3_GRPSXG
'6'																		, ; //X3_FOLDER
''																		} ) //X3_PYME

aAdd( aSX3, { ;
'SC5'																	, ; //X3_ARQUIVO
'L7'																	, ; //X3_ORDEM
'C5_YVALLOJ'															, ; //X3_CAMPO
'C'																		, ; //X3_TIPO
1																		, ; //X3_TAMANHO
0																		, ; //X3_DECIMAL
'ValidadeLoja'															, ; //X3_TITULO
'ValidadeLoja'															, ; //X3_TITSPA
'ValidadeLoja'															, ; //X3_TITENG
'ValidadeLoja'															, ; //X3_DESCRIC
'ValidadeLoja'															, ; //X3_DESCSPA
'ValidadeLoja'															, ; //X3_DESCENG
''																		, ; //X3_PICTURE
''																		, ; //X3_VALID
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(160)					, ; //X3_USADO
'"1"'																	, ; //X3_RELACAO
''																		, ; //X3_F3
0																		, ; //X3_NIVEL
Chr(254) + Chr(192)														, ; //X3_RESERV
''																		, ; //X3_CHECK
''																		, ; //X3_TRIGGER
'U'																		, ; //X3_PROPRI
'N'																		, ; //X3_BROWSE
'A'																		, ; //X3_VISUAL
'R'																		, ; //X3_CONTEXT
''																		, ; //X3_OBRIGAT
'Pertence("12")'														, ; //X3_VLDUSER
'1=Somente para Loja do Cliente;2=Todas as Lojas do Cliente'			, ; //X3_CBOX
''																		, ; //X3_CBOXSPA
''																		, ; //X3_CBOXENG
''																		, ; //X3_PICTVAR
'M->C5_XSTAPED=="00"'													, ; //X3_WHEN
''																		, ; //X3_INIBRW
''																		, ; //X3_GRPSXG
'6'																		, ; //X3_FOLDER
''																		} ) //X3_PYME

aAdd( aSX3, { ;
'SC5'																	, ; //X3_ARQUIVO
'L8'																	, ; //X3_ORDEM
'C5_YVLVPCP'															, ; //X3_CAMPO
'N'																		, ; //X3_TIPO
14																		, ; //X3_TAMANHO
2																		, ; //X3_DECIMAL
'Vlr.VPC noPV'															, ; //X3_TITULO
'Vlr.VPC noPV'															, ; //X3_TITSPA
'Vlr.VPC noPV'															, ; //X3_TITENG
'Vlr.VPC noPV'															, ; //X3_DESCRIC
'Vlr.VPC noPV'															, ; //X3_DESCSPA
'Vlr.VPC noPV'															, ; //X3_DESCENG
'@E 99,999,999,999.99'													, ; //X3_PICTURE
''																		, ; //X3_VALID
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128) + ;
Chr(128) + Chr(128) + Chr(128) + Chr(128) + Chr(128)					, ; //X3_USADO
''																		, ; //X3_RELACAO
''																		, ; //X3_F3
0																		, ; //X3_NIVEL
Chr(254) + Chr(192)														, ; //X3_RESERV
''																		, ; //X3_CHECK
''																		, ; //X3_TRIGGER
'U'																		, ; //X3_PROPRI
'N'																		, ; //X3_BROWSE
'V'																		, ; //X3_VISUAL
'R'																		, ; //X3_CONTEXT
''																		, ; //X3_OBRIGAT
''																		, ; //X3_VLDUSER
''																		, ; //X3_CBOX
''																		, ; //X3_CBOXSPA
''																		, ; //X3_CBOXENG
''																		, ; //X3_PICTVAR
''																		, ; //X3_WHEN
''																		, ; //X3_INIBRW
''																		, ; //X3_GRPSXG
''																		, ; //X3_FOLDER
''																		} ) //X3_PYME


//
// Tabela SC6
//

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
ฑฑบ Programa ณ FSAtuSXA บ Autor ณ TOTVS Protheus     บ Data ณ  14/06/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento da gravacao do SXA - Pastas        ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ FSAtuSXA   - Gerado por COMPADIC / Upd. V.4.10.6 EFS       ณฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FSAtuSXA( cTexto )
Local aEstrut   := {}
Local aSXA      := {}
Local cAlias    := ""
Local nI        := 0
Local nJ        := 0

cTexto  += "Inicio da Atualizacao" + " SXA" + CRLF + CRLF

aEstrut := { "XA_ALIAS", "XA_ORDEM", "XA_DESCRIC", "XA_DESCSPA", "XA_DESCENG", "XA_PROPRI" }

//
// Tabela SC5
//
aAdd( aSXA, { ;
'SC5'																	, ; //XA_ALIAS
'6'																		, ; //XA_ORDEM
'Dados Pedido Pai'														, ; //XA_DESCRIC
'Dados Pedido Pai'														, ; //XA_DESCSPA
'Dados Pedido Pai'														, ; //XA_DESCENG
'U'																		} ) //XA_PROPRI

//
// Atualizando dicionแrio
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
		
		cTexto += "Foi incluํda a pasta " + aSXA[nI][1] + "/" + aSXA[nI][2]  + CRLF
		
		oProcess:IncRegua2( "Atualizando Arquivos (SXA)..." )
		
	EndIf
	
Next nI

cTexto += CRLF + "Final da Atualizacao" + " SXA" + CRLF + Replicate( "-", 128 ) + CRLF + CRLF

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
ฑฑบ Programa ณ MyOpenSM0บ Autor ณ TOTVS Protheus     บ Data ณ  14/06/2013 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ Descricaoณ Funcao de processamento abertura do SM0 modo exclusivo     ณฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ MyOpenSM0  - Gerado por COMPADIC / Upd. V.4.10.6 EFS       ณฑฑ
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



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  05/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xContrato()
Local cQuery:=""
rpcsettype(3)
rpcsetenv("01","03")
cQuery+=" SELECT P01_CODIGO,"
cQuery+="   P01_DESC,"
cQuery+="   P01_VERSAO,"
cQuery+="   P01_GRPCLI,"
cQuery+="   P01_CODCLI,"
cQuery+="   P01_LOJCLI,"
cQuery+="   P01_REPASS,"
cQuery+="   P01_TPFAT,"
cQuery+="   P01_DTVINI,"
cQuery+="   P01_DTVFIM,"
cQuery+="   P00_CODIGO,"
cQuery+="   P00_DESC,"
cQuery+="   P02_PERCEN"
cQuery+=" FROM P01010 P01"
cQuery+=" LEFT OUTER JOIN P02010 P02"
cQuery+=" ON P02.P02_CODVPC = P01_CODIGO"
cQuery+=" AND P02.D_E_L_E_T_ = ' '"
cQuery+=" LEFT OUTER JOIN P00010 P00"
cQuery+=" ON P00.P00_CODIGO = P02_CODTP"
cQuery+=" AND P00.D_E_L_E_T_ = ' '"
cQuery+=" WHERE P01_STATUS = '1'"
cQuery+=" AND P01_TPCAD = '1'"
cQuery+=" AND P01_STSAPR = '1'"
cQuery+=" AND P01_GRPCLI<>' '"
cQuery+=" ORDER BY P01.P01_GRPCLI,P01.P01_CODIGO""
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"P01OLD"  ,.F.,.T.)
TcSetField("P01OLD","P01_DTVINI","D")
TcSetField("P01OLD","P01_DTVFIM","D")

Do While P01OLD->(!Eof())
	
	Begin Transaction
	
	ZZ7->(RecLock("ZZ7",.T.))
	ZZ7->ZZ7_FILIAL	:=xFilial("ZZ7")
	ZZ7->ZZ7_CODIGO	:=P01OLD->P01_CODIGO
	ZZ7->ZZ7_VERSAO	:=P01OLD->P01_VERSAO
	ZZ7->ZZ7_DESC	:=P01OLD->P01_DESC
	ZZ7->ZZ7_GRPCLI	:=P01OLD->P01_GRPCLI
	ZZ7->ZZ7_CLIENT	:=P01OLD->P01_CODCLI
	ZZ7->ZZ7_LOJA	:=P01OLD->P01_LOJCLI
	ZZ7->ZZ7_RENOVA	:="N"
	ZZ7->ZZ7_STATUS	:="3"
	ZZ7->ZZ7_FLAG	:="1"
	
	M->ZZ7_DTVINI	:=P01OLD->P01_DTVINI
	M->ZZ7_DTVFIM	:=P01OLD->P01_DTVFIM
	
	
	If !Empty(ZZ7->ZZ7_GRPCLI)
		ACY->(DbSeek(xFilial("ACY")+ZZ7->ZZ7_GRPCLI))
		ZZ7->ZZ7_DESGRU	:=ACY->ACY_DESCRI
	Else
		SA1->(DbSeek(xFilial("SA1")+ZZ7->ZZ7_CLIENT+Trim(ZZ7->ZZ7_LOJA)))
		ZZ7->ZZ7_DESCLI	:=SA1->A1_NOME
	EndIf
	
	
	ZZ9->(RecLock("ZZ9",.T.))
	ZZ9->ZZ9_FILIAL	:=xFilial("ZZ9")
	ZZ9->ZZ9_CODIGO	:=ZZ7->ZZ7_CODIGO
	ZZ9->ZZ9_VERSAO	:=ZZ7->ZZ7_VERSAO
	ZZ9->ZZ9_FLAG	:="3"
	ZZ9->ZZ9_CLASSE	:="01"
	ZZ9->ZZ9_DESCLA:="JOGOS E ACESSORIOS"
	ZZ9->(MsUnLock())
	
	cChave:=P01OLD->P01_GRPCLI
	
	Do While P01OLD->(!Eof()) .And. P01OLD->P01_GRPCLI==cChave
		
		
		M->ZZ7_DTVINI	:=Min(P01OLD->P01_DTVINI,M->ZZ7_DTVINI)
		M->ZZ7_DTVFIM	:=Max(P01OLD->P01_DTVFIM,M->ZZ7_DTVFIM)
		
		ZZ8->(RecLock("ZZ8",.T.))
		ZZ8->ZZ8_FILIAL	:=xFilial("ZZ8")
		ZZ8->ZZ8_CODIGO	:=ZZ7->ZZ7_CODIGO
		ZZ8->ZZ8_VERSAO	:=ZZ7->ZZ7_VERSAO
		ZZ8->ZZ8_TIPO	:=P01OLD->P00_CODIGO
		ZZ8->ZZ8_DESCTI	:=P01OLD->P00_DESC
		ZZ8->ZZ8_TPFAT	:=P01OLD->P01_TPFAT
		ZZ8->ZZ8_REPASS	:=P01OLD->P01_REPASS
		ZZ8->ZZ8_PERCEN :=P01OLD->P02_PERCEN
		
		If P01OLD->P01_TPFAT=="1"
			ZZ7->ZZ7_TPERBR+=ZZ8->ZZ8_PERCEN
		Else
			ZZ7->ZZ7_TPERLI+=ZZ8->ZZ8_PERCEN
		EndIf
		
		
		If ZZ8->ZZ8_REPASS=="1"
			ZZ8->ZZ8_PERIOD:="1"
			ZZ8->ZZ8_MES01:="X"
			ZZ8->ZZ8_MES02:="X"
			ZZ8->ZZ8_MES03:="X"
			ZZ8->ZZ8_MES04:="X"
			ZZ8->ZZ8_MES05:="X"
			ZZ8->ZZ8_MES06:="X"
			ZZ8->ZZ8_MES07:="X"
			ZZ8->ZZ8_MES08:="X"
			ZZ8->ZZ8_MES09:="X"
			ZZ8->ZZ8_MES10:="X"
			ZZ8->ZZ8_MES11:="X"
			ZZ8->ZZ8_MES12:="X"
		EndIf
		ZZ8->(MsUnLock())
		
		ZZ7->ZZ7_DTVINI	:=M->ZZ7_DTVINI
		ZZ7->ZZ7_DTVFIM	:=M->ZZ7_DTVFIM
		
		
		
		
		ZZ7->(MsUnLock())
		
		P01OLD->(DbSkip())
	EndDo
	End Transaction
	
EndDo


//Cliente
P01OLD->(DbCloseArea())

cQuery:=" SELECT P01_CODIGO,"
cQuery+="   P01_DESC,"
cQuery+="   P01_VERSAO,"
cQuery+="   P01_GRPCLI,"
cQuery+="   P01_CODCLI,"
cQuery+="   P01_LOJCLI,"
cQuery+="   P01_REPASS,"
cQuery+="   P01_TPFAT,"
cQuery+="   P01_DTVINI,"
cQuery+="   P01_DTVFIM,"
cQuery+="   P00_CODIGO,"
cQuery+="   P00_DESC,"
cQuery+="   P02_PERCEN"
cQuery+=" FROM P01010 P01"
cQuery+=" LEFT OUTER JOIN P02010 P02"
cQuery+=" ON P02.P02_CODVPC = P01_CODIGO"
cQuery+=" AND P02.D_E_L_E_T_ = ' '"
cQuery+=" LEFT OUTER JOIN P00010 P00"
cQuery+=" ON P00.P00_CODIGO = P02_CODTP"
cQuery+=" AND P00.D_E_L_E_T_ = ' '"
cQuery+=" WHERE P01_STATUS = '1'"
cQuery+=" AND P01_TPCAD = '1'"
cQuery+=" AND P01_STSAPR = '1'"
cQuery+=" AND P01_GRPCLI=' '"
cQuery+=" ORDER BY P01.P01_CODCLI,P01.P01_CODIGO""
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"P01OLD"  ,.F.,.T.)
TcSetField("P01OLD","P01_DTVINI","D")
TcSetField("P01OLD","P01_DTVFIM","D")

Do While P01OLD->(!Eof())
	
	Begin Transaction
	
	ZZ7->(RecLock("ZZ7",.T.))
	ZZ7->ZZ7_FILIAL	:=xFilial("ZZ7")
	ZZ7->ZZ7_CODIGO	:=P01OLD->P01_CODIGO
	ZZ7->ZZ7_VERSAO	:=P01OLD->P01_VERSAO
	ZZ7->ZZ7_DESC	:=P01OLD->P01_DESC
	ZZ7->ZZ7_GRPCLI	:=P01OLD->P01_GRPCLI
	ZZ7->ZZ7_CLIENT	:=P01OLD->P01_CODCLI
	ZZ7->ZZ7_LOJA	:=P01OLD->P01_LOJCLI
	ZZ7->ZZ7_RENOVA	:="N"
	ZZ7->ZZ7_STATUS	:="3"
	ZZ7->ZZ7_FLAG	:="1"
	
	M->ZZ7_DTVINI	:=P01OLD->P01_DTVINI
	M->ZZ7_DTVFIM	:=P01OLD->P01_DTVFIM
	
	
	If !Empty(ZZ7->ZZ7_GRPCLI)
		ACY->(DbSeek(xFilial("ACY")+ZZ7->ZZ7_GRPCLI))
		ZZ7->ZZ7_DESGRU	:=ACY->ACY_DESCRI
	Else
		SA1->(DbSeek(xFilial("SA1")+ZZ7->ZZ7_CLIENT+Trim(ZZ7->ZZ7_LOJA)))
		ZZ7->ZZ7_DESCLI	:=SA1->A1_NOME
	EndIf
	
	
	ZZ9->(RecLock("ZZ9",.T.))
	ZZ9->ZZ9_FILIAL	:=xFilial("ZZ9")
	ZZ9->ZZ9_CODIGO	:=ZZ7->ZZ7_CODIGO
	ZZ9->ZZ9_VERSAO	:=ZZ7->ZZ7_VERSAO
	ZZ9->ZZ9_FLAG	:="3"
	ZZ9->ZZ9_CLASSE	:="01"
	ZZ9->ZZ9_DESCLA:="JOGOS E ACESSORIOS"
	ZZ9->(MsUnLock())
	
	cChave:=P01OLD->P01_CODCLI
	
	Do While P01OLD->(!Eof()) .And. P01OLD->P01_CODCLI==cChave
		
		
		M->ZZ7_DTVINI	:=Min(P01OLD->P01_DTVINI,M->ZZ7_DTVINI)
		M->ZZ7_DTVFIM	:=Max(P01OLD->P01_DTVFIM,M->ZZ7_DTVFIM)
		
		ZZ8->(RecLock("ZZ8",.T.))
		ZZ8->ZZ8_FILIAL	:=xFilial("ZZ8")
		ZZ8->ZZ8_CODIGO	:=ZZ7->ZZ7_CODIGO
		ZZ8->ZZ8_VERSAO	:=ZZ7->ZZ7_VERSAO
		ZZ8->ZZ8_TIPO	:=P01OLD->P00_CODIGO
		ZZ8->ZZ8_DESCTI	:=P01OLD->P00_DESC
		ZZ8->ZZ8_TPFAT	:=P01OLD->P01_TPFAT
		ZZ8->ZZ8_REPASS	:=P01OLD->P01_REPASS
		ZZ8->ZZ8_PERCEN :=P01OLD->P02_PERCEN
		
		If P01OLD->P01_TPFAT=="1"
			ZZ7->ZZ7_TPERBR+=ZZ8->ZZ8_PERCEN
		Else
			ZZ7->ZZ7_TPERLI+=ZZ8->ZZ8_PERCEN
		EndIf
		
		
		If ZZ8->ZZ8_REPASS=="1"
			ZZ8->ZZ8_PERIOD:="1"
			ZZ8->ZZ8_MES01:="X"
			ZZ8->ZZ8_MES02:="X"
			ZZ8->ZZ8_MES03:="X"
			ZZ8->ZZ8_MES04:="X"
			ZZ8->ZZ8_MES05:="X"
			ZZ8->ZZ8_MES06:="X"
			ZZ8->ZZ8_MES07:="X"
			ZZ8->ZZ8_MES08:="X"
			ZZ8->ZZ8_MES09:="X"
			ZZ8->ZZ8_MES10:="X"
			ZZ8->ZZ8_MES11:="X"
			ZZ8->ZZ8_MES12:="X"
		EndIf
		ZZ8->(MsUnLock())
		
		ZZ7->ZZ7_DTVINI	:=M->ZZ7_DTVINI
		ZZ7->ZZ7_DTVFIM	:=M->ZZ7_DTVFIM
		
		
		
		
		ZZ7->(MsUnLock())
		
		P01OLD->(DbSkip())
	EndDo
	End Transaction
	
EndDo


Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  05/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AppendZZ9()
Local cQuery:="Select Distinct ZZ7_CODIGO,ZZ7_VERSAO FROM ZZ7010 WHERE ZZ7_FILIAL=' ' AND D_E_L_E_T_=' '"

rpcsettype(3)
rpcsetenv("01","03")

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"ZZ7NEW"  ,.F.,.T.)


Do While ZZ7NEW->(!Eof())
	
	//ZZ9->(RecLock("ZZ9",.T.))
	//ZZ9->ZZ9_FILIAL	:=xFilial("ZZ9")
	//ZZ9->ZZ9_CODIGO	:=ZZ7NEW->ZZ7_CODIGO
	//ZZ9->ZZ9_VERSAO	:=ZZ7NEW->ZZ7_VERSAO
	//ZZ9->ZZ9_FLAG	:="3"
	//ZZ9->ZZ9_CLASSE	:="01"
	//ZZ9->ZZ9_DESCLA:="JOGOS E ACESSORIOS"
	//ZZ9->(MsUnLock())
	
	Begin Transaction
	SX5->(DbSeek("  _Y"))
	Do While SX5->(!Eof()) .And. SX5->(X5_FILIAL+X5_TABELA)=="  _Y"
		ZZ9->(RecLock("ZZ9",.T.))
		ZZ9->ZZ9_FILIAL	:=xFilial("ZZ9")
		ZZ9->ZZ9_CODIGO	:=ZZ7NEW->ZZ7_CODIGO
		ZZ9->ZZ9_VERSAO	:=ZZ7NEW->ZZ7_VERSAO
		ZZ9->ZZ9_FLAG	:="3"
		ZZ9->ZZ9_CLASSE	:=SX5->X5_CHAVE
		ZZ9->ZZ9_DESCLA:=SX5->X5_DESCRI
		ZZ9->(MsUnLock())
		
		SX5->(DbSkip())
	EndDO
	End Transaction
	ZZ7NEW->(DbSkip())
EndDo


User Function EMISSAOBORDERO()
Static lFWCodFil := FindFunction("FWCodFil")

FINR170R3()

Return

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ MsModoFil บ Autor  ณ Jose Lucas       บ Data ณ17.06.2011   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retornar o modo de compartilhamento de cada tabela.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSintaxe   ณ ExpA1 := MsModoFil(ExpC1)                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ ExpC1 := Alias da tabela a pesquisar.                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR170                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MsModoFil(cAlias)
Local aSavArea := GetArea()
Local aModo := {"","",""}

SX2->(dbSetOrder(1))
If SX2->(dbSeek(cAlias))
	aModo[1] := SX2->X2_MODO
	aModo[2] := SX2->X2_MODOUN
	aModo[3] := SX2->X2_MODOEMP
EndIf
RestArea(aSavArea)
Return aModo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ  AjustaSX1 บ Autor  ณ Jose Lucas       บ Data ณ17.06.2011  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Incluir F3 nas perguntas para Filial e Bordero.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบSintaxe   ณ Void AjustaSX1(ExpC1)	                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ ExpC1 := Nome do grupo de perguntas.                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR170                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)
Local aSavArea := GetArea()

SX1->(dbSetOrder(1))
If SX1->(dbSeek(cPerg))
	While SX1->(!Eof()) .and. AllTrim(SX1->X1_GRUPO) == AllTrim(cPerg)
		If SX1->X1_ORDEM $ "05|06" .and. Empty(SX1->X1_F3)
			RecLock("SX1",.F.)
			SX1->X1_F3 := "SM0"
			MsUnLock()
		EndIf
		SX1->(dbSkip())
	End
EndIf
RestArea(aSavArea)
Return


Return


User Function xtestes()

RpcSetEnv("01","03")
u_NCECOM05()


//U_NcEcom07( "031763" )//U_NCECOM08(aDados:={"01","03","VERIFICA_EXPEDICAO",.F.})

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  08/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xTabComp()
Local cArquivo:=""
Local cAliasQry:=GetNextAlias()
Local nHdl := FCreate("\_Lucas\TabelasComp.txt")

RpcSetEnv("01","03")

SX2->(DbGoTop())
Do While SX2->(!Eof())
	
	PtInternal(1,SX2->X2_ARQUIVO)
	
	If SX2->X2_MODO<>"C"
		SX2->(DbSkip());Loop
	EndIf
	
	cTabela:=AllTrim(SX2->X2_ARQUIVO)
	
	If !TcCanOpen(cTabela)
		SX2->(DbSkip());Loop
	EndIf
	
	cAliasTab:=SX2->X2_CHAVE
	FechaArea(cAliasQry)
	DbUseArea( .T. , 'TOPCONN', cTabela,cAliasQry, .T., .F. )
	
	If Select(cAliasQry)==0
		SX2->(DbSkip());Loop
	EndIf
	
	(cAliasQry)->(DbGoTop())
	lTemReg:=.F.
	Do While (cAliasQry)->(!Eof())
		lTemReg:=.T.
		Exit
	EndDo
	
	If !lTemReg
		SX2->(DbSkip());Loop
	EndIf
	
	cQuery:="Select Count(1) Total From "+cTabela
	
	FechaArea(cAliasQry)
	DbUseArea( .T. , 'TOPCONN', TCGENQRY(,,cQuery),cAliasQry, .T., .F. )
	cLinha:=cTabela+";"+AllTrim(SX2->X2_NOME)+";"+StrZero((cAliasQry)->Total,5)+CRLF
	Write(@cLinha,nHdl)
	
	
	FechaArea(cAliasQry)
	
	SX2->(DbSkip())
EndDo

FClose(nHdl)

Return

Static Function FechaArea(cAliasTemp)

If Select(cAliasTemp)>0
	(cAliasTemp)->(DbCloseArea())
EndIf

Return


Static Function Write(cLine,nHdl)
FWrite(nHdl,cLine,Len(cLine))
cLine:=""
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  09/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xDifSB2()
Local aLocal:={"01","05"}
Local dDataRef:=MsDate()
Local cProdutos:=""
Local Enter:=Chr(10)+Chr(13)
Local cQuery:=""
RpcSetEnv("01","03")

CHKFILE("SB2")
cQuery:=" Select R_E_C_N_O_ SB2RECNO"
cQuery+=" From "+RetSqlName("SB2")
cQuery+=" Where B2_FILIAL='03'"
cQuery+=" And B2_LOCAL IN ('01')"
cQuery+=" And D_E_L_E_T_=' '"     
cQuery+=" And B2_COD='0501010003732'"
cQuery+=" And D_E_L_E_T_ = ' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"SB2OLD"  ,.F.,.T.)

Ma215Proc(.F.)

Do While SB2OLD->(!Eof() )

	SB2->( DbGOTo( SB2OLD->SB2RECNO ) )
	nSaldoSB2:=SB2->( SaldoSB2() )
	                  
	cProd    :=SB2->B2_COD
	cLocal 	:=SB2->B2_LOCAL
	nB2QATU	:=SB2->B2_QATU
	nQuant	:=CalcEst( SB2->B2_COD,SB2->B2_LOCAL,dDataRef+1,SB2->B2_FILIAL )[ 1 ]
	
	If nB2QATU<>nQuant
		cProdutos+=cProd+";"+cLocal+Transform(nB2QATU,'@E 99999')+";"+Transform(nQuant,'@E 99999')+Enter
	EndIf
	SB2OLD->(DbSkip())
EndDo

MsYesNo(cProdutos)

Return

Static Function CalcEst(cCod,cLocal,dData,cFilAux,lConsTesTerc,lCusRep)

#define F_SB9  1
#define F_SD1  2
#define F_SD2  3
#define F_SD3  4
#define F_SF4  5
#define F_SF5  6

Local nReg,nReg1,nOrd,nOrd1,dDtVai

#ifdef TOP
	Local lHasRec := .F.
#endif

Local aSaldo     := { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 }
Local cLocProc   := GETMV("MV_LOCPROC")
Local cArq       := Alias()
Local nCnt01     := 0

Local aFilial  := { xFilial( "SB9" ),;
                    xFilial( "SD1" ),;
                    xFilial( "SD2" ),;
                    xFilial( "SD3" ),;
                    xFilial( "SF4" ),;
                    xFilial( "SF5" ) }

Local lRemInt  := SuperGetMv("MV_REMINT",.F.,.F.)
Local nSizeFil := 2 
Local lUsaD2DIG  := IIf(FindFunction("UsaD2DTDIG"), UsaD2DTDIG(), .F.)
Local cFiltroSF5 :=	SF5->(DbFilter())

DEFAULT lConsTesTerc := .F.
DEFAULT lCusRep      := .F.
DEFAULT dData        := dDataBase
SF5->(DBClearFilter())

dData	 := If(Empty(dData),Ctod( "01/01/80","ddmmyy" ),dData)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ponto de partida para compor o saldo inicial.        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea( "SB9" )

#ifndef TOP
	DbSeek( aFilial[ F_SB9 ]+cCod+cLocal+DtoS( dData ),.T. ) ; DbSkip(-1)
#else
	If TCSrvType() == "AS/400"
		DbSeek( aFilial[ F_SB9 ]+cCod+cLocal+DtoS( dData ),.T. ) ; DbSkip(-1)
	Else
		DbSeek(aFilial[ F_SB9 ]+cCod+cLocal)
		lHasRec := .f.
		While !Eof() .and. (aFilial[ F_SB9 ]+cCod+cLocal == B9_FILIAL + B9_COD+B9_Local)
			If B9_DATA >= dData .and. lHasRec
				Exit
			Else
				lHasRec := .t.
			EndIf
			DbSkip()
		End
		If lHasRec
			DbSkip(-1)
		EndIf
	End
#endif

If ((aFilial[ F_SB9 ]+cCod+cLocal == SB9->B9_FILIAL+SB9->B9_COD+SB9->B9_Local) .And. ;
	(SB9->B9_DATA < dData))

	aSaldo[01] := SB9->B9_QINI
	aSaldo[02] := SB9->B9_VINI1
	aSaldo[03] := SB9->B9_VINI2
	aSaldo[04] := SB9->B9_VINI3
	aSaldo[05] := SB9->B9_VINI4
	aSaldo[06] := SB9->B9_VINI5
	aSaldo[07] := SB9->B9_QISEGUM
	If SB9->(FieldPos("B9_CM1")) <> 0 .And. SB9->(FieldPos("B9_CM2")) <> 0 .And. ;
	   SB9->(FieldPos("B9_CM3")) <> 0 .And. SB9->(FieldPos("B9_CM4")) <> 0 .And. ;
	   SB9->(FieldPos("B9_CM5")) <> 0
		aSaldo[08] := SB9->B9_CM1
		aSaldo[09] := SB9->B9_CM2
		aSaldo[10] := SB9->B9_CM3
		aSaldo[11] := SB9->B9_CM4
		aSaldo[12] := SB9->B9_CM5
	EndIf	
	If lCusRep
		aSaldo[13] := SB9->B9_CMRP1
		aSaldo[14] := SB9->B9_CMRP2
		aSaldo[15] := SB9->B9_CMRP3
		aSaldo[16] := SB9->B9_CMRP4
		aSaldo[17] := SB9->B9_CMRP5
		aSaldo[18] := SB9->B9_VINIRP1
		aSaldo[19] := SB9->B9_VINIRP2
		aSaldo[20] := SB9->B9_VINIRP3
		aSaldo[21] := SB9->B9_VINIRP4
		aSaldo[22] := SB9->B9_VINIRP5
	EndIf
	dDtVai    := SB9->B9_DATA+1
Else
	dDtVai    := Ctod( "01/01/80","ddmmyy" )
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Correr SD1, SD2 e SD3 para  obter o saldo na Data desejada. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea( "SF4" )
nReg1 := Recno()
nOrd1 := Indexord()

DbSelectArea( "SD1" )
nReg := Recno()
nOrd := IndexOrd()
DbSetOrder( 7 )

DbSeek( aFilial[ F_SD1 ]+cCod+cLocal+Dtos(dDtVai),.T. )

While (!Eof() .And. ;
	(aFilial[ F_SD1 ]+cCod+cLocal) == (SD1->D1_FILIAL+SD1->D1_COD+SD1->D1_Local) .And.;
	(SD1->D1_DTDIGIT < dData))

	#ifdef SHELL
		If SD1->D1_CANCEL == "S"
			SD1->(DbSkip())
			Loop
		EndIf
	#endif

	If cPaisLoc != "BRA"
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Desconsiderar notas de remito e notas geradas pelo EIC       ณ
		//| com excecao da nota de FOB.									 |
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If !Empty(SD1->D1_REMITO) .Or. SD1->D1_TIPO_NF $ '6789AB'
			SD1->(DbSkip())
			Loop
		EndIf

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Desconsiderar notas de entrada tipo 10 quando o cliente uti_ |
		//| lizar o conceito de remito interno com importacao (SIGAEIC)  |
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If lRemInt
		  	If !Empty(SD1->D1_CONHEC) .And. SD1->D1_TIPO_NF $ '5' .And. SD1->D1_TIPODOC $ '10'
				SD1->(DbSkip())
				Loop
			EndIf
		EndIf	

	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Somente Notas Fiscais Nao Lancadas No Modulo do Livro Fiscal ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !(SD1->D1_ORIGLAN == "LF")
		DbSelectArea( "SF4" )
//		If ((SF4->F4_FILIAL+SF4->F4_CODIGO == aFilial[ F_SF4 ]+SD1->D1_TES ) .Or. ;
//			DbSeek( aFilial[ F_SF4 ]+SD1->D1_TES,.F. ))
		If (iif (FWModeAccess("SF4") == "E",(SF4->F4_FILIAL+SF4->F4_CODIGO == aFilial[ F_SF4 ]+SD1->D1_TES ), ;
				(SF4->F4_FILIAL+SF4->F4_CODIGO == substr(aFilial[ 4 ],1,len(SF4->F4_FILIAL)-len(FWFilial("SF4")))+FWFilial("SF4")+SD1->D1_TES)).Or. ;
			DbSeek( aFilial[ F_SF4 ]+SD1->D1_TES,.F. ))
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Somente TES Que Movimenta Estoque Deve Ser Considerada ณ
			//ณ ou TES de poder de terceiros com parametro ligado      ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If (SF4->F4_ESTOQUE == "S") .Or. (lConsTesTerc .And. SF4->F4_PODER3 $ "RD")
				aSaldo[1] += SD1->D1_QUANT
				aSaldo[2] += SD1->D1_CUSTO
				aSaldo[3] += SD1->D1_CUSTO2
				aSaldo[4] += SD1->D1_CUSTO3
				aSaldo[5] += SD1->D1_CUSTO4
				aSaldo[6] += SD1->D1_CUSTO5
				aSaldo[7] += SD1->D1_QTSEGUM
				If lCusRep
					aSaldo[18] += SD1->D1_CUSRP1
					aSaldo[19] += SD1->D1_CUSRP2
					aSaldo[20] += SD1->D1_CUSRP3
					aSaldo[21] += SD1->D1_CUSRP4
					aSaldo[22] += SD1->D1_CUSRP5
				EndIf			
			EndIf
		EndIf
		DbSelectArea( "SD1" )
	EndIf
	DbSkip(1)
End

DbSetOrder( nOrd ) ; DbGoTo( nReg )

DbSelectArea( "SD2" )
nReg := Recno()
nOrd := IndexOrd()
// Verifica se usa o campo D2_DTDIGIT ou nao, de acordo com a funcao UsaD2DTDIG
DbSetOrder( IIf(lUsaD2DIG, 11, 6) )

DbSeek( aFilial[ F_SD2 ]+cCod+cLocal+DtoS( dDtVai ),.T. )

While (!Eof() .And. ;
	(aFilial[ F_SD2 ]+cCod+cLocal == SD2->D2_FILIAL+SD2->D2_COD+SD2->D2_Local) .And. ;
	IIf(lUsaD2DIG, (SD2->D2_DTDIGIT < dData), (SD2->D2_EMISSAO < dData)) )

	#ifdef SHELL
		If SD2->D2_CANCEL == "S"
			SD2->(DbSkip())]
			Loop
		EndIf
	#endif

	If !Empty(SD2->D2_REMITO) .And. !(SD2->D2_TPDCENV $ "A1")
		SD2->(DbSkip())
		Loop
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Despreza Notas Fiscais Lancadas Pelo Modulo do Livro Fiscal  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If !(SD2->D2_ORIGLAN == "LF")
		DbSelectArea("SF4")
		If ((SF4->F4_FILIAL+SF4->F4_CODIGO == aFilial[ F_SF4 ]+SD2->D2_TES ) .Or. ;
			DbSeek( aFilial[ F_SF4 ]+SD2->D2_TES,.F. ))
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณ Somente TES Que Movimenta Estoque Deve Ser Considerada ณ
			//ณ ou TES de poder de terceiros com parametro ligado      ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			If (SF4->F4_ESTOQUE == "S") .Or. (lConsTesTerc .And. SF4->F4_PODER3 $ "RD")
				aSaldo[1] -= SD2->D2_QUANT
				aSaldo[2] -= SD2->D2_CUSTO1
				aSaldo[3] -= SD2->D2_CUSTO2
				aSaldo[4] -= SD2->D2_CUSTO3
				aSaldo[5] -= SD2->D2_CUSTO4
				aSaldo[6] -= SD2->D2_CUSTO5
				aSaldo[7] -= SD2->D2_QTSEGUM
				If lCusRep
					aSaldo[18] -= SD2->D2_CUSRP1
					aSaldo[19] -= SD2->D2_CUSRP2
					aSaldo[20] -= SD2->D2_CUSRP3
					aSaldo[21] -= SD2->D2_CUSRP4
					aSaldo[22] -= SD2->D2_CUSRP5
				EndIf			
			EndIf
		EndIf
		DbSelectArea( "SD2" )
	EndIf
	DbSkip(1)
End

DbSetOrder( nOrd ) ; DbGoTo( nReg )


DbSetOrder( nOrd ) ; DbGoTo( nReg )

DbSelectArea( "SF4" )
DbSetOrder( nOrd1 ) ; DbGoTo( nReg1 )

DbSelectArea( "SF5" )
nReg1 := Recno()
nOrd1 := IndexOrd()

DbSelectArea( "SD3" )
nReg := Recno()
nOrd := IndexOrd()
DbSetOrder( 7 )

DbSeek( aFilial[ F_SD3 ]+cCod+cLocal+DtoS( dDtVai ),.T. )

While (!Eof() .And. ;
	(aFilial[ F_SD3 ]+cCod+cLocal == SD3->D3_FILIAL+SD3->D3_COD+SD3->D3_Local) .And. ;
	(SD3->D3_EMISSAO < dData))
	If !D3Valido()
		DbSkip()
		Loop
	EndIf
	DbSelectArea( "SF5" )
	If ((SF5->F5_FILIAL+SF5->F5_CODIGO == aFilial[ F_SF5 ]+SD3->D3_TM) .Or. ;
		(SD3->D3_TM == "499") .Or. ;
		(SD3->D3_TM == "999") .Or. ;
		DbSeek( aFilial[ F_SF5 ]+SD3->D3_TM,.F. ))
		If SD3->D3_TM >"500"
			aSaldo[1] -= SD3->D3_QUANT
			aSaldo[2] -= SD3->D3_CUSTO1
			aSaldo[3] -= SD3->D3_CUSTO2
			aSaldo[4] -= SD3->D3_CUSTO3
			aSaldo[5] -= SD3->D3_CUSTO4
			aSaldo[6] -= SD3->D3_CUSTO5
			aSaldo[7] -= SD3->D3_QTSEGUM
			If lCusRep
				aSaldo[18] -= SD3->D3_CUSRP1
				aSaldo[19] -= SD3->D3_CUSRP2
				aSaldo[20] -= SD3->D3_CUSRP3
				aSaldo[21] -= SD3->D3_CUSRP4
				aSaldo[22] -= SD3->D3_CUSRP5
			EndIf			
		Else
			aSaldo[1] += SD3->D3_QUANT
			aSaldo[2] += SD3->D3_CUSTO1
			aSaldo[3] += SD3->D3_CUSTO2
			aSaldo[4] += SD3->D3_CUSTO3
			aSaldo[5] += SD3->D3_CUSTO4
			aSaldo[6] += SD3->D3_CUSTO5
			aSaldo[7] += SD3->D3_QTSEGUM
			If lCusRep
				aSaldo[18] += SD3->D3_CUSRP1
				aSaldo[19] += SD3->D3_CUSRP2
				aSaldo[20] += SD3->D3_CUSRP3
				aSaldo[21] += SD3->D3_CUSRP4
				aSaldo[22] += SD3->D3_CUSRP5
			EndIf			
		EndIf
	EndIf
	DbSelectArea( "SD3" ) ; DbSkip(1)
End

If AllTrim(cLocal) == AllTrim(cLocProc)

	DbSetOrder( 7 )

	DbSeek( aFilial[ F_SD3 ]+cCod,.T. )

	While (!Eof() .And. ;
		(aFilial[ F_SD3 ]+cCod == SD3->D3_FILIAL+SD3->D3_COD))
		
		If SD3->D3_EMISSAO >= dData
			SD3->(dbSkip())
			Loop
		EndIf

		While (!Eof() .And. ;
			(aFilial[ F_SD3 ]+cCod == SD3->D3_FILIAL+SD3->D3_COD) .And. ;
			(SD3->D3_EMISSAO < dData))
	
			If ((SD3->D3_EMISSAO <  dData)      .And. ;
				(SD3->D3_EMISSAO >= dDtVai)     .And. ;
				(SubS( SD3->D3_CF,2 ) == "E3")  .And. ;
				!(alltrim(SD3->D3_Local) == alltrim(cLocProc)))
	
				If !D3Valido()
					DbSkip()
					Loop
				EndIf
				
				DbSelectArea( "SF5" )
				If ((SF5->F5_FILIAL+SF5->F5_CODIGO == aFilial[ F_SF5 ]+SD3->D3_TM) .Or. ;
					(SD3->D3_TM == "499") .Or. ;
					(SD3->D3_TM == "999") .Or. ;
					DbSeek( aFilial[ F_SF5 ]+SD3->D3_TM,.F. ))
	
					If SD3->D3_CF = "RE3"
	
						aSaldo[1] += SD3->D3_QUANT
						aSaldo[2] += SD3->D3_CUSTO1
						aSaldo[3] += SD3->D3_CUSTO2
						aSaldo[4] += SD3->D3_CUSTO3
						aSaldo[5] += SD3->D3_CUSTO4
						aSaldo[6] += SD3->D3_CUSTO5
						aSaldo[7] += SD3->D3_QTSEGUM
						If lCusRep
							aSaldo[18] += SD3->D3_CUSRP1
							aSaldo[19] += SD3->D3_CUSRP2
							aSaldo[20] += SD3->D3_CUSRP3
							aSaldo[21] += SD3->D3_CUSRP4
							aSaldo[22] += SD3->D3_CUSRP5
						EndIf			
					ElseIf SD3->D3_CF = "DE3"
						aSaldo[1] -= SD3->D3_QUANT
						aSaldo[2] -= SD3->D3_CUSTO1
						aSaldo[3] -= SD3->D3_CUSTO2
						aSaldo[4] -= SD3->D3_CUSTO3
						aSaldo[5] -= SD3->D3_CUSTO4
						aSaldo[6] -= SD3->D3_CUSTO5
						aSaldo[7] -= SD3->D3_QTSEGUM
						If lCusRep
							aSaldo[18] -= SD3->D3_CUSRP1
							aSaldo[19] -= SD3->D3_CUSRP2
							aSaldo[20] -= SD3->D3_CUSRP3
							aSaldo[21] -= SD3->D3_CUSRP4
							aSaldo[22] -= SD3->D3_CUSRP5
						EndIf			
					EndIf
				EndIf
			EndIf
	
			DbSelectArea("SD3")
			DbSkip()
		End
	End
EndIf

DbSetOrder( nOrd ) ; DbGoTo( nReg )


DbSelectArea("SF5")
DbSetOrder( nOrd1 ) ; DbGoTo( nReg1 )  
If !Empty (cFiltroSF5)
	dbSetFilter({||&cFiltroSF5},cFiltroSF5)
EndIf

DbSelectArea( cArq )

Return( aSaldo )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  09/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  09/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ma215Proc(lBat,oObj,lNewProc)
Local aStru     := {}
Local aSaldos   := {}
Local aTravas   := {}
Local aAreaSB8  := {}
Local aAreaSB6  := {}
Local cQuery    := ""
Local cChave    := ""
Local lQuery    := .F.
Local lContinua := .F.
Local lLiberOk	:= .T.
Local lResidOk	:= .T.
Local lFaturOk	:= .F.
Local lAchou    := .F.
Local lSC6Ok    := .F.
Local cQuebra   := ""
Local cAliasSB2 := "SB2"
Local cAliasSB6 := "SB6"
Local cAliasSB8 := "SB8"
Local cAliasSBF := "SBF"
Local cAliasSC0 := "SC0"
Local cAliasSC1 := "SC1"
Local cAliasSC2 := "SC2"
Local cAliasSC6 := "SC6"
Local cAliasSC7 := "SC7"
Local cAliasSC9 := "SC9"
Local cAliasSD4 := "SD4"
Local cAliasAFJ := "AFJ"
Local cAliasSDC := "SDC"
Local cAliasSD1 := "SD1"
Local caliasSD2 := "SD2"
Local cAliasSL2 := "SL2"									// Alias do arquivo SL2
Local cSavFil   := cFilAnt
Local cFirst    := ""
Local nX        := 0
Local nMax      := 0
Local nMin      := 0
Local nQtdLib2  := 0 
Local nRegSB6	:= 0

Local nEmpenho  := 0 
Local nEmpenh2  := 0
Local nBaixaEmp := 0 
Local nBaixaEm2 := 0 
Local nQuantDc  := 0
Local nQtdDifDc := 0

Local cSeek     := ""
Local cSeekSDC  := ""
Local cCompara  := ""
Local cMensagem := ""
Local cEstoque  := ""
Local nTempoIni := 0,nTempoFim:=0,cTempo:=""
Local cLocOriSB6:= ""
Local lEmpPrev  := If(SuperGetMV("MV_QTDPREV")== "S",.T.,.F.)
Local lNegEstr  := SuperGetMV("MV_NEGESTR",.F.,.F.)
Local lPCFilEnt := SuperGetMv("MV_PCFILEN",.F.,.F.)
Local aTabs     := {}
Local lLockTabs := .T.
Local lAtuRes   := .T.                       // Define se atualiza a reserva (TPL OTC)

DEFAULT lNewProc := .F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSemaforo para controle de execucao da rotina                      ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !MA215Lock(cEmpAnt)
	Return
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPonto de entrada para controlar execucao da rotina de acumuladores?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If ExistBlock( "MT215PRO" )
   lRet := ExecBlock("MT215PRO",.F.,.F.)
   If ValType(lRet) <> "L"
     	lRet:=.T.
   EndIf  
   
   If !lRet
    	Return
   EndIf 
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
//?Atualiza o log de processamento   ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
ProcLogAtu("INICIO")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Abre todos os arquivos de forma exclusiva                    ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//AADD(aTabs,"SA1");AADD(aTabs,"SB1");AADD(aTabs,"SB2");AADD(aTabs,"SB8");AADD(aTabs,"SC0");AADD(aTabs,"SC6")
//AADD(aTabs,"SC7");AADD(aTabs,"SC9");AADD(aTabs,"SD2");AADD(aTabs,"SD1");AADD(aTabs,"SD4");AADD(aTabs,"SDC")
//AADD(aTabs,"SDD");AADD(aTabs,"SC1");AADD(aTabs,"SC2");AADD(aTabs,"SB6");AADD(aTabs,"SBF");AADD(aTabs,"SDA")
//AADD(aTabs,"SL2");AADD(aTabs,"SCQ")

For nX := 1 To Len(aTabs)
	If !MA280FLock(aTabs[nX],,!IsBlind())
		lLockTabs := .F.
		Exit
	Endif	
Next	

If !lLockTabs
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//?Fecha todos os arquivos e reabre-os de forma compartilhada   ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	For nX := 1 To Len(aTabs)
		dbSelectArea(aTabs[nX])
		dbCloseArea()
	Next	
	OpenFile(SubStr(cNumEmp,1,2),"")
	If IsBlind()
		Conout(STR0011) //"MATA215:Nใo foi possivel abrir todas as tabelas de forma exclusiva" 
	EndIf	
	Return
Else
	For nX := 1 To Len(aTabs)
		OpenIndx(aTabs[nX])
	Next
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Posiciona na Primeira Filial                                 ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nTempoIni:=Seconds()
dbSelectArea("SM0")
dbSetOrder(1)
If Empty(xFilial("SA1")) .Or. Empty(xFilial("SB2")) .Or. lPCFilEnt
	MsSeek(cEmpAnt)
	cFirst := FWGETCODFILIAL
Else
	MsSeek(cEmpAnt+cFilAnt)
	cFirst := FWGETCODFILIAL
EndIf

While !Eof() .And. cEmpAnt == SM0->M0_CODIGO
	If !lBat
		//oObj:SetRegua2(MAXPASSO)
		//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//?Altera a Filial do Sistema                                   ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cFilAnt := FWGETCODFILIAL
	//cFirst  :='03'
	If !lBat
		If (oObj <> NIL) .And. lNewProc
			//oObj:SaveLog(OemToAnsi(STR0009))
		EndIf
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
	//?Atualiza o log de processamento             ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
	ProcLogAtu("MENSAGEM",STR0012+cFilAnt,STR0012+cFilAnt) // "Inicio Filial: "
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//?Verifica se h?registros pendentes no SC9                    ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If FtVldJobFt()
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//?Zerar os dados a ser atualizado                              ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If (!Empty(xFilial("SA1")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SA1")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSA1 := "SA1MA215PROC"
					
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SA1")+" "
					cQuery += "WHERE A1_FILIAL='"+xFilial("SA1")+"' AND "
					cQuery += "D_E_L_E_T_=' '"
					cQuery += " AND 1=2"					
					cQuery := ChangeQuery(cQuery)
			
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSA1)
					nMax := (cAliasSA1)->MAXRECNO
					nMin := (cAliasSA1)->MINRECNO
					dbCloseArea()
					dbSelectArea("SA1")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SA1")+" "	
					cQuery += "SET A1_SALPED = 0, "
					cQuery += "A1_SALPEDL = 0, "
					cQuery += "A1_SALPEDB = 0 "
					cQuery += "WHERE A1_FILIAL='"+xFilial("SA1")+"' AND "
					cQuery += "D_E_L_E_T_=' ' AND 1=2 AND "
					If !lBat
						//oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							//oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณA tabela eh fechada para restaurar o buffer da aplicacao?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					dbSelectArea("SA1")
					dbCloseArea()
					ChkFile("SA1",.T.)
				Else
			#ENDIF
				If !lBat
					//oObj:SetRegua1(SA1->(LastRec()))
				EndIf	
				dbSelectArea("SA1")
				dbSetOrder(1)
				MsSeek(xFilial("SA1"))
				While !Eof() .And. SA1->A1_FILIAL == xFilial("SA1")
					RecLock("SA1",.F.)
					Replace A1_SALPED  With 0
					Replace A1_SALPEDL With 0
					Replace A1_SALPEDB With 0
					MsUnLock()
					dbSelectArea("SA1")
					dbSkip()
					If !lBat
						//oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf
			#ENDIF
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (IIf(lPCFilEnt,.F.,!Empty(xFilial("SB2"))) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SB2")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSB2 := "SB2MA215PROC"
					
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SB2")+" "
					If lPCFilEnt
						cQuery += "WHERE "
					Else
						cQuery += "WHERE B2_FILIAL='"+xFilial("SB2")+"' AND "
					EndIf	
					cQuery += "D_E_L_E_T_=' '"
					cQuery+=" And B2_COD='0501010003732'"
					cQuery+=" And B2_LOCAL='01'"
					cQuery := ChangeQuery(cQuery)
				
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB2)
					nMax := (cAliasSB2)->MAXRECNO
					nMin := (cAliasSB2)->MINRECNO
					dbCloseArea()
					dbSelectArea("SB2")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SB2")+" "
					cQuery += "SET B2_RESERVA = 0,"
					cQuery += "B2_RESERV2 = 0,"								
					cQuery += "B2_QEMP    = 0,"
					cQuery += "B2_QEMP2   = 0,"	
					cQuery += "B2_QEMPN   = 0,"
					cQuery += "B2_QEMPN2  = 0,"	
					cQuery += "B2_NAOCLAS = 0,"
					cQuery += "B2_SALPEDI = 0,"
					cQuery += "B2_SALPED2 = 0,"	
					cQuery += "B2_QPEDVEN = 0,"
					cQuery += "B2_QPEDVE2 = 0,"
					cQuery += "B2_QTNP    = 0,"
					cQuery += "B2_QNPT    = 0,"
					cQuery += "B2_QTER    = 0,"
					cQuery += "B2_QEMPPRE = 0,"
					cQuery += "B2_SALPPRE = 0,"
					cQuery += "B2_QACLASS = 0,"
					cQuery += "B2_QEMPPRJ = 0,"
					cQuery += "B2_QEMPPR2 = 0,"	
					cQuery += "B2_QEMPSA  = 0 "
					If lPCFilEnt
						cQuery += "WHERE "
					Else
						cQuery += "WHERE B2_FILIAL='"+xFilial("SB2")+"' AND "
					EndIf	
					
					cQuery+=" B2_COD='0501010003732' And B2_LOCAL='01'AND "
					
					cQuery += "D_E_L_E_T_=' ' AND "
					

					If !lBat
						//oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							//oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณA tabela eh fechada para restaurar o buffer da aplicacao?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					dbSelectArea("SB2")
					dbCloseArea()
					ChkFile("SB2",.T.)
				Else
			#ENDIF
				If !lBat
					//oObj:SetRegua1(SB2->(LastRec()))
				EndIf	
				dbSelectArea("SB2")
				dbSetOrder(1)
				MsSeek(xFilial("SB2"),.T.)
				While !Eof() .And. SB2->B2_FILIAL == xFilial("SB2")
					RecLock("SB2",.F.)
					Replace B2_RESERVA With 0
					Replace B2_RESERV2 With 0			
					Replace B2_QEMPPRJ WITH 0
					Replace B2_QEMPPR2 WITH 0
					Replace B2_QEMP    WITH 0
					Replace B2_QEMP2   WITH 0			
					Replace B2_QEMPN   With 0
					Replace B2_QEMPN2  With 0			
					Replace B2_NAOCLAS With 0
					Replace B2_SALPEDI With 0
					Replace B2_SALPED2 With 0
					Replace B2_QPEDVEN With 0
					Replace B2_QPEDVE2 With 0			
					Replace B2_QTNP    With 0
					Replace B2_QNPT    With 0
					Replace B2_QTER    With 0
					Replace B2_QEMPPRE With 0
					Replace B2_QEPRE2  With 0
					Replace B2_SALPPRE With 0
					Replace B2_QACLASS With 0
					Replace B2_QEMPSA  With 0
					MsUnLock()
					dbSelectArea("SB2")
					dbSkip()
					If !lBat
						//oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf 
			#ENDIF
		EndIf       

		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SB8")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SB8")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSB8 := "SB8MA215PROC"
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SB8")+" "
					cQuery += "WHERE B8_FILIAL='"+xFilial("SB8")+"' AND "
					cQuery += "D_E_L_E_T_=' '"         
					cQuery+=" And B8_PRODUTO='0501010003732'"
					cQuery+=" And B8_LOCAL='01'"

					cQuery := ChangeQuery(cQuery)
				
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB8)
					nMax := (cAliasSB8)->MAXRECNO
					nMin := (cAliasSB8)->MINRECNO
					dbCloseArea()
					dbSelectArea("SB8")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SB8")+" "	
					cQuery += "SET B8_EMPENHO = 0, "
					cQuery += "B8_EMPENH2 = 0, "	
					cQuery += "B8_QACLASS = 0, "
					cQuery += "B8_QACLAS2 = 0, "								
					cQuery += "B8_QEMPPRE = 0 "
					cQuery += "WHERE B8_FILIAL='"+xFilial("SB8")+"' AND "
					cQuery += "D_E_L_E_T_=' ' AND "
					cQuery += " B8_PRODUTO='0501010003732' And B8_LOCAL='01'AND "
					If !lBat
						//oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							//oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณA tabela eh fechada para restaurar o buffer da aplicacao?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					dbSelectArea("SB8")
					dbCloseArea()
					ChkFile("SB8",.T.)
				Else
			#ENDIF
				If !lBat
					//oObj:SetRegua1(SB8->(LastRec()))
				EndIf	
			 	dbSelectArea("SB8")
				dbSetOrder(1)
				MsSeek(xFilial("SB8"),.T.)
				While !Eof() .And. SB8->B8_FILIAL == xFilial("SB8")
					RecLock("SB8",.F.)
					Replace B8_EMPENHO With 0
					Replace B8_EMPENH2 With 0		
					Replace B8_QACLASS With 0
					Replace B8_QACLAS2 With 0								
					Replace B8_QEMPPRE With 0
					Replace B8_QEPRE2  With 0
					MsUnLock()
					dbSelectArea("SB8")
					dbSkip()
					If !lBat
						//oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf
			#ENDIF
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SBF")) .Or. cFilAnt == cFirst )
			dbSelectArea("SBF")
			dbSetOrder(1)
			MsSeek("SBF")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
					cAliasSBF := "SBFMA215PROC"
				
					cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
					cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
					cQuery += "FROM "+RetSqlName("SBF")+" "
					cQuery += "WHERE BF_FILIAL='"+xFilial("SBF")+"' AND "
					cQuery += "D_E_L_E_T_=' '"     
					cQuery += " AND BF_PRODUTO='0501010003732' And BF_LOCAL='01'"
					cQuery := ChangeQuery(cQuery)
				
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSBF)
					nMax := (cAliasSBF)->MAXRECNO
					nMin := (cAliasSBF)->MINRECNO
					dbCloseArea()
					dbSelectArea("SBF")
					cQuery := "UPDATE "
					cQuery += RetSqlName("SBF")+" "
					cQuery += "SET BF_EMPENHO = 0, "
					cQuery += "BF_EMPEN2 = 0, "	
					cQuery += "BF_QEMPPRE = 0, "
					cQuery += "BF_QEPRE2 = 0 "
					cQuery += "WHERE BF_FILIAL='"+xFilial("SBF")+"' AND "
					cQuery += "D_E_L_E_T_=' ' AND "
					cQuery += " BF_PRODUTO='0501010003732' And BF_LOCAL='01'AND "					
					
					If !lBat
						//oObj:SetRegua1(Int(nMax/4096)+1)
					EndIf	
					For nX := nMin To nMax+4096 STEP 4096
						cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
						TcSqlExec(cQuery+cChave)
						If !lBat
							//oObj:IncRegua1(cMensagem)
						EndIf	
					Next nX
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณA tabela eh fechada para restaurar o buffer da aplicacao?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					dbSelectArea("SBF")
					dbCloseArea()
					ChkFile("SBF",.T.)
				Else
			#ENDIF
				If !lBat
					//oObj:SetRegua1(SBF->(LastRec()))
				EndIf	
				dbSelectArea("SBF")
				dbSetOrder(1)
				MsSeek(xFilial("SBF"))
				While !Eof() .And. SBF->BF_FILIAL == xFilial("SBF")
					RecLock("SBF",.F.)
					Replace BF_EMPENHO With 0
					Replace BF_EMPEN2  With 0		
					Replace BF_QEMPPRE With 0
					Replace BF_QEPRE2  With 0
					MsUnLock()
					dbSelectArea("SBF")
					dbSkip()
					If !lBat
						//oObj:IncRegua1(cMensagem)
					EndIf	
				EndDo
			#IFDEF TOP
				EndIf
			#ENDIF
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAtualiza os dados acumulados da Solicitacao de Compra         ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If (!Empty(xFilial("SC1")) .Or. cFilAnt == cFirst )	
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC1")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SC1")
			dbSetOrder(1)
			If !lBat
				//oObj:SetRegua1(SC1->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			#IFDEF TOP
				aStru	  := SC1->(dbStruct())
				lQuery    := .T.
				cAliasSC1 := "SC1MA215PROC"

				cQuery := ""				
				For nX := 1 To Len(aStru)
					cQuery += ","+aStru[nX][1]
				Next nX
				cQuery := "SELECT SB1.B1_FILIAL,"+SubStr(cQuery,2)+",SC1.D_E_L_E_T_,SC1.R_E_C_N_O_ SC1RECNO "
				cQuery += "FROM "+RetSqlName("SC1")+" SC1,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC1.C1_FILIAL='"+xFilial("SC1")+"' AND "
				cQuery += "SC1.C1_QUJE < SC1.C1_QUANT AND "
				cQuery += "SC1.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC1.C1_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery += " AND C1_PRODUTO='0501010003732' AND C1_LOCAL='01'"
				cQuery += "ORDER BY SC1.C1_FILIAL,SC1.C1_PRODUTO,SC1.C1_LOCAL"

				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC1,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" ) 
						TcSetField(cAliasSC1,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf		
				Next nX	
			#ELSE
				cQuery := "C1_FILIAL=='"+xFilial("SC1")+"' .And. "
				cQuery += "C1_QUJE < C1_QUANT "
				Set Filter To &cQuery 
				MsSeek(xFilial("SC1"))
			#ENDIF
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza os dados acumulados da Solicitacao de compra         ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			While !Eof() .And. (cAliasSC1)->C1_FILIAL == xFilial("SC1")
				lContinua := .T.
				If !lQuery
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					//ณVerifica a existencia de Cotacoes e filial do produto?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					If (cAliasSC1)->C1_QUJE >= (cAliasSC1)->C1_QUANT .Or. !A215FilOk((cAliasSC1)->C1_PRODUTO)
						lContinua := .F.
					EndIf
				Else
					lContinua := .T.
				EndIf
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
				//?Ponto de Entrada para Tratamentos Especiais         ?
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?	
				
				//IsProd((cAliasSC1)->C1_PRODUTO)
				If ExistBlock("M215SC")
					If lQuery
						dbSelectArea("SC1")
						dbGoto((cAliasSC1)->SC1RECNO)
					EndIf
					If ExecBlock("M215SC",.f.,.f.)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					MaAvalSC(cAliasSC1,1,,,.T.)
				EndIf
				a215Skip(cAliasSC1)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSC1)
				dbCloseArea()
				dbSelectArea("SC1")
			Else
				dbClearFilter()
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAtualiza os dados acumulados do Pedido de Compra              ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If (!Empty(xFilial("SC7")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC7")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("SC7")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SC7->(dbStruct())
				lQuery    := .T.
				cAliasSC7 := "SC7MA215PROC"
				
				cQuery := "SELECT C7_FILIAL,C7_PRODUTO,C7_LOCAL,C7_QUJE,C7_QUANT,C7_RESIDUO,C7_FILENT,C7_TPOP,C7_QTSEGUM,C7_FORNECE,C7_LOJA,C7_NUM,C7_ITEM,C7_OP,C7_SEQMRP,C7_DATPRF,C7_TIPO,C7_NUMCOT,C7_TES,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC7")+" SC7,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC7.C7_FILIAL='"+xFilial("SC7")+"' AND "
				cQuery += "SC7.C7_FILENT IN('  ','"+xFilial("SC7")+"') AND "
				cQuery += "SC7.C7_QUJE < C7_QUANT AND "
				cQuery += "SC7.C7_RESIDUO='"+Space(Len(SC7->C7_RESIDUO))+"' AND "
				cQuery += "SC7.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC7.C7_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "    
				cQuery+= " And C7_PRODUTO='0501010003732' AND C7_LOCAL='01'				"
				cQuery += "UNION ALL "
				cQuery += "SELECT C7_FILIAL,C7_PRODUTO,C7_LOCAL,C7_QUJE,C7_QUANT,C7_RESIDUO,C7_FILENT,C7_TPOP,C7_QTSEGUM,C7_FORNECE,C7_LOJA,C7_NUM,C7_ITEM,C7_OP,C7_SEQMRP,C7_DATPRF,C7_TIPO,C7_NUMCOT,C7_TES,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC7")+" SC7,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC7.C7_FILENT='"+xFilial("SC7")+"' AND "
				cQuery += "SC7.C7_FILIAL<>'"+xFilial("SC7")+"' AND "			
				cQuery += "SC7.C7_QUJE < C7_QUANT AND "
				cQuery += "SC7.C7_RESIDUO='"+Space(Len(SC7->C7_RESIDUO))+"' AND "
				cQuery += "SC7.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC7.C7_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery+= " And C7_PRODUTO='0501010003732' AND C7_LOCAL='01'	"			
				cQuery += "ORDER BY 1,2,3 "
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC7,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
						TcSetField(cAliasSC7,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				cQuery := "((C7_FILIAL=='"+xFilial("SC7")+"' .And. C7_FILENT$'  #"+xFilial("SC7")+"') .Or. (C7_FILIAL<>'"+xFilial("SC7")+"' .And. C7_FILENT=='"+xFilial("SC7")+"')) .And. "
				cQuery += "C7_QUJE < C7_QUANT .And. "
				cQuery += "C7_RESIDUO='"+Space(Len(SC7->C7_RESIDUO))+"'"
				Set Filter To &cQuery	
				MsSeek(xFilial("SC7"))
			#ENDIF
			If !lBat
				//oObj:SetRegua1(SC7->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof()
				lContinua := .T.
				If !lQuery
					If ( (cAliasSC7)->C7_QUJE >= C7_QUANT ) .Or.;
							!Empty((cAliasSC7)->C7_RESIDUO) .Or.;
							!A215FilOk((cAliasSC7)->C7_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf                          
				//IsProd((cAliasSC7)->C7_PRODUTO)
								
				If lContinua
					MaAvalPC(cAliasSC7,1,,.T.)
				EndIf
				a215Skip(cAliasSC7)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSC7)
				dbCloseArea()
				dbSelectArea("SC7")
			Else
				dbClearFilter()
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SC2")) .Or. cFilAnt == cFirst )
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza os dados acumulados das Ordens de Producao           ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC2")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("SC2")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SC2->(dbStruct())
				lQuery    := .T.
				cAliasSC2 := "SC2MA215PROC"
				
				cQuery := "SELECT SC2.C2_FILIAL,SC2.C2_DATRF,SC2.C2_QUANT,SC2.C2_QUJE,SC2.C2_PERDA,SC2.C2_PRODUTO,SC2.C2_LOCAL,SC2.C2_TPOP,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC2")+" SC2,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC2.C2_FILIAL='"+xFilial("SC2")+"' AND "
				cQuery += "((SC2.C2_DATRF='"+Dtos(Ctod(""))+"' AND "
				cQuery += "SC2.C2_QUANT-SC2.C2_QUJE-SC2.C2_PERDA>0) OR "
				cQuery += "(SC2.C2_DATRF<>'"+Dtos(Ctod(""))+"')) AND "
				cQuery += "SC2.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC2.C2_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "    
				cQuery+= " And C2_PRODUTO='0501010003732' AND C2_LOCAL='01'"
				cQuery += "ORDER BY C2_FILIAL,C2_PRODUTO,C2_LOCAL "
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC2,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
						TcSetField(cAliasSC2,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				lQuery := .F.
				MsSeek(xFilial("SC2"))
			#ENDIF
			If !lBat
				//oObj:SetRegua1(SC2->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While ( !Eof() .And. (cAliasSC2)->C2_FILIAL == xFilial("SC2") )
				lContinua := .T.
				If !lQuery 
					If aSC2Sld(cAliasSC2) <= 0 .Or. !A215FilOk(SC2->C2_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					dbSelectArea("SB2")
					dbSetOrder(1)               
					IsProd((cAliasSC2)->C2_PRODUTO,(cAliasSC2)->C2_LOCAL)
									
					If !MsSeek(xFilial("SB2")+(cAliasSC2)->C2_PRODUTO+(cAliasSC2)->C2_LOCAL)
						CriaSB2((cAliasSC2)->C2_PRODUTO,(cAliasSC2)->C2_LOCAL)
					EndIf
					GravaB2Pre("+",IF(Empty((cAliasSC2)->C2_DATRF),aSC2Sld(cAliasSC2),0),(cAliasSC2)->C2_TPOP)
				EndIf
				a215Skip(cAliasSC2)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSC2)
				dbCloseArea()
				dbSelectArea("SC2")
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAtualiza os dados acumulados dos empenhos da OP               ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If (!Empty(xFilial("SD4")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SD4")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("SD4")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SD4->(dbStruct())
				lQuery    := .T.
				cAliasSD4 := "SD4MA215PROC"
				
				cQuery := "SELECT SD4.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SD4")+" SD4,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SD4.D4_FILIAL='"+xFilial("SD4")+"' AND "
				// MV_NEGESTR - Parametro utilizado para considerar empenho negativo
				If lNegEstr
					cQuery += " SD4.D4_QUANT <> 0 AND "
				Else
					cQuery += "SD4.D4_QUANT > 0 AND "
				EndIf	
				cQuery += "SD4.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SD4.D4_COD AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery+= " And D4_COD='0501010003732' AND D4_LOCAL='01'"
				cQuery += "ORDER BY D4_FILIAL,D4_COD,D4_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD4,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSD4,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("SD4"))
			#ENDIF
			If !lBat
				//oObj:SetRegua1(SD4->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasSD4)->D4_FILIAL == xFilial("SD4")
			nQuantDc :=0
			nQtdDifDc:=0
				lContinua := .T.
				IsProd((cAliasSD4)->D4_COD,(cAliasSD4)->D4_LOCAL)
									               
				If !lQuery
					If !A215FilOk((cAliasSD4)->D4_COD) .Or. (cAliasSD4)->D4_QUANT <= 0
						lContinua := .F.
					EndIf
				EndIf                             
				
				If lContinua
			 		If Localiza((cAliasSD4)->D4_COD)
						#IFDEF TOP
							lQuery := .T.
							aStru     := SDC->(dbStruct())
							lQuery    := .T.
							cAliasSDC := "SDCMA215PROC1"
				
							cQuery := "SELECT * "
							cQuery += "FROM "+RetSqlName("SDC")+" SDC "
							cQuery += "WHERE SDC.DC_FILIAL='"+xFilial("SDC")+"' AND "
							cQuery += "SDC.DC_PRODUTO='"+(cAliasSD4)->D4_COD+"' AND "
							cQuery += "SDC.DC_LOCAL='"+(cAliasSD4)->D4_LOCAL+"' AND "
							cQuery += "SDC.DC_OP='"+(cAliasSD4)->D4_OP+"' AND "
							cQuery += "SDC.DC_TRT='"+(cAliasSD4)->D4_TRT+"' AND "
							cQuery += "SDC.DC_LOTECTL='"+(cAliasSD4)->D4_LOTECTL+"' AND "
							cQuery += "SDC.DC_NUMLOTE='"+(cAliasSD4)->D4_NUMLOTE+"' AND "
							cQuery += "SDC.D_E_L_E_T_=' ' "
							cQuery += "ORDER BY "+SqlOrder(SDC->(IndexKey()))
			
							cQuery := ChangeQuery(cQuery)
				
							dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDC,.T.,.T.)
							For nX := 1 To Len(aStru)
								If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
									TcSetField(cAliasSDC,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
								EndIf
							Next nX
						#ELSE
							dbSelectArea("SDC")
							dbSetOrder(2)
							MsSeek(xFilial("SDC")+(cAliasSD4)->D4_COD+(cAliasSD4)->D4_LOCAL+(cAliasSD4)->D4_OP+(cAliasSD4)->D4_TRT+(cAliasSD4)->D4_LOTECTL+(cAliasSD4)->D4_NUMLOTE)
						#ENDIF
						lAchou := .F.
						While !Eof() .And. (cAliasSDC)->DC_FILIAL == xFilial("SDC") .And.;
											(cAliasSDC)->DC_PRODUTO == (cAliasSD4)->D4_COD .And.;
											(cAliasSDC)->DC_LOCAL == (cAliasSD4)->D4_LOCAL .And.;
											(cAliasSDC)->DC_OP == (cAliasSD4)->D4_OP .And.;
											(cAliasSDC)->DC_TRT == (cAliasSD4)->D4_TRT .And.;
											(cAliasSDC)->DC_LOTECTL == (cAliasSD4)->D4_LOTECTL .And.;
											(cAliasSDC)->DC_NUMLOTE == (cAliasSD4)->D4_NUMLOTE
							//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
							//?Atualiza arquivo de empenhos               ?
							//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
							nQuantDc+=(cAliasSDC)->DC_QUANT
							lAchou := .T.
							GravaEmp((cAliasSDC)->DC_PRODUTO,;
								(cAliasSDC)->DC_LOCAL,;
								(cAliasSDC)->DC_QUANT,;
								(cAliasSDC)->DC_QTSEGUM,;
								(cAliasSDC)->DC_LOTECTL,;
								(cAliasSDC)->DC_NUMLOTE,;
								(cAliasSDC)->DC_LOCALIZ,;
								(cAliasSDC)->DC_NUMSERIE,;
								(cAliasSDC)->DC_OP,;
								(cAliasSDC)->DC_TRT,;
								NIL,;
								NIL,;
								"SC2",;
								NIL,;
								NIL,;
								NIL,;
								.F.,;
								.F.,;
								.T.,;
								.F.,;
								NIL,;
								.T.,;
								.F.)
							a215Skip(cAliasSDC)
						EndDo 
						
						//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
						//ณTratamento para verificar se existe diference entre valores da SDC e SD4 ?
						//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
						If nQuantDc < (cAliasSD4)->D4_QUANT 
							nQtdDifDc := (cAliasSD4)->D4_QUANT - nQuantDc
					   		lAchou :=.F. 
						EndIf 

						
						If lQuery
							dbSelectArea(cAliasSDC)
							dbCloseArea()
							dbSelectArea("SDC")
						EndIf
						If !lAchou
							//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
							//?Atualiza arquivo de empenhos               ?
							//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
							GravaEmp((cAliasSD4)->D4_COD,;
								(cAliasSD4)->D4_LOCAL,;
								IIf(QtdComp((cAliasSD4)->D4_QUANT) <> QtdComp(nQuantDc),nQtdDifDc,(cAliasSD4)->D4_QUANT),;
								(cAliasSD4)->D4_QTSEGUM,;
								(cAliasSD4)->D4_LOTECTL,;
								(cAliasSD4)->D4_NUMLOTE,;
								NIL,;
								NIL,;
								(cAliasSD4)->D4_OP,;
								(cAliasSD4)->D4_TRT,;
								NIL,;
								NIL,;
								"SC2",;
								(cAliasSD4)->D4_OPORIG,;
								(cAliasSD4)->D4_DATA,;
								@aTravas,;
								.F.,;
								.F.,;
								.T.,;
								.F.,;
								NIL,;
								.T.,;
								.F.)
						EndIf
					Else
						//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
						//?Atualiza arquivo de empenhos               ?
						//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
						GravaEmp((cAliasSD4)->D4_COD,;
							(cAliasSD4)->D4_LOCAL,;
							(cAliasSD4)->D4_QUANT,;
							(cAliasSD4)->D4_QTSEGUM,;
							(cAliasSD4)->D4_LOTECTL,;
							(cAliasSD4)->D4_NUMLOTE,;
							NIL,;
							NIL,;
							(cAliasSD4)->D4_OP,;
							(cAliasSD4)->D4_TRT,;
							NIL,;
							NIL,;
							"SC2",;
							(cAliasSD4)->D4_OPORIG,;
							(cAliasSD4)->D4_DATA,;
							NIL,;
							.F.,;
							.F.,;
							.T.,;
							.F.,;
							NIL,;
							.T.,;
							.F.)
					EndIf
				EndIf
				a215Skip(cAliasSD4)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSD4)
				dbCloseArea()
				dbSelectArea("SD4")
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//?Varre o SDD e refaz os bloqueios existentes                ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If (!Empty(xFilial("SDD")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SDD")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SDD")
			dbSetOrder(1)
			MsSeek(xFilial())
			If !lBat
				//oObj:SetRegua1(SDD->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. DD_FILIAL == xFilial()
				IsProd(SDD->DD_PRODUTO,SDD->DD_LOCAL)
				If DD_SALDO > 0 .And. A215FilOk(SDD->DD_PRODUTO)
					Reclock("SDD",.F.)
					Replace DD_QUANT With DD_SALDO
					MsUnlock()
					cSeekSDC := xFilial("SDC")+SDD->DD_PRODUTO+SDD->DD_LOCAL+"SDD"+;
						SDD->DD_DOC+Criavar("DC_ITEM")+Criavar("DC_SEQ")+;
						SDD->DD_LOTECTL+SDD->DD_NUMLOTE+If(!Empty(SDD->DD_LOCALIZ),SDD->DD_LOCALIZ,"")+;
						If(!Empty(SDD->DD_NUMSERI),SDD->DD_NUMSERI,"")
					SDC->(dbSetOrder(1))
					aTravas  := {}
					If Localiza(SDD->DD_PRODUTO) .And. SDC->(MsSeek(cSeekSDC))
						dbSelectArea("SDC")
						While !Eof() .And. DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+;
								DC_PEDIDO+DC_ITEM+DC_SEQ+DC_LOTECTL+DC_NUMLOTE+;
								If(!Empty(SDD->DD_LOCALIZ),SDC->DC_LOCALIZ,"")+If(!Empty(SDD->DD_NUMSERI),SDC->DC_NUMSERI,"") == cSeekSDC
							//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
							//?Atualiza arquivo de empenhos               ?
							//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
							GravaEmp(SDC->DC_PRODUTO,;
								SDC->DC_LOCAL,;
								SDC->DC_QUANT,;
								SDC->DC_QTSEGUM,;
								SDC->DC_LOTECTL,;
								SDC->DC_NUMLOTE,;
								SDC->DC_LOCALIZ,;
								SDC->DC_NUMSERI,;
								Nil,;
								Nil,;
								SDC->DC_PEDIDO,;
								Nil,;
								"SDD",;
								Nil,;
								Nil,;
								Nil,;
								.F.,;
								.F.,;
								.T.,;
								.F.,;
								.T.,;
								.T.,;
								.F.)
							a215Skip('SDC')
						EndDo
					Else
						ProcSDD(.F.)
					EndIf
				EndIf		
				a215Skip('SDD')
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SCQ")) .Or. cFilAnt == cFirst )
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//?Corre SCQ para Atualizar B2_QEMP  em Produtos SB2.           ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SCQ")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SCQ")
			#IFDEF TOP
				cFilSCQ := 'CQ_QTDISP > 0'
				MsFilter(cFIlSCQ)
			#ENDIF
			dbSetOrder(1)
			MsSeek(xFilial())
			If !lBat
				//oObj:SetRegua1(SCQ->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. CQ_FILIAL == xFilial()
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
				//?Atualizar Qtde Empenhada  em Produtos SB2.          ?
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
				
				IsProd(SCQ->CQ_PRODUTO,SCQ->CQ_LOCAL)
				If SCQ->CQ_QTDISP > 0 .And. Empty(SCQ->CQ_NUMREQ) .And. A215FilOk(SCQ->CQ_PRODUTO)
					dbSelectArea("SB2")
					cSeek := xFilial()+SCQ->CQ_PRODUTO+SCQ->CQ_LOCAL
					MsSeek(cSeek)
					If Eof()
						CriaSB2(SCQ->CQ_PRODUTO,SCQ->CQ_LOCAL)
					Else
						RecLock("SB2",.F.)
					EndIf
					Replace B2_QEMPSA     With B2_QEMPSA + (SCQ->CQ_QTDISP)
					MsUnLock()
				EndIf
				a215Skip('SCQ')
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			RETINDEX("SCQ")
			dbClearFilter()
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SDA")) .Or. cFilAnt == cFirst )
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//?A partir do SDA atualiza B2_QACLASS e B8_QACLASS             ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SDA")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SDA")
			#IFDEF TOP
				cFilSDA := 'DA_SALDO > 0'
				MsFilter(cFilSDA)
			#ENDIF
			dbSetOrder(1)
			MsSeek(xFilial())
			If !lBat
				//oObj:SetRegua1(SDA->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. DA_FILIAL == xFilial()
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
				//?Atualizar Qtde Prevista de Produtos SB2.            ?
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
				
				IsProd(SDA->DA_PRODUTO,SDA->DA_LOCAL)
				If DA_SALDO > 0 .And. A215FilOk(SDA->DA_PRODUTO)
					dbSelectArea("SB2")
					cSeek := xFilial()+SDA->DA_PRODUTO+SDA->DA_LOCAL
					MsSeek(cSeek)
					If Eof()
						CriaSB2(SDA->DA_PRODUTO,SDA->DA_LOCAL)
					EndIf
					Reclock("SB2",.F.)
					Replace B2_QACLASS With B2_QACLASS + SDA->DA_SALDO
					MsUnlock()
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					//?Caso use rastreabilidade, GRAVA a quantidade do SDA   ?
					//?no SB8 para que o Saldo por Sub-Lote fique bloqueado  ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					If Rastro(SDA->DA_PRODUTO)
						dbSelectArea("SB8")
						aAreaSB8:=GetArea()
						dbSetOrder(3)
						If Rastro(SDA->DA_PRODUTO,"S")
							cSeek:=xFilial()+SDA->DA_PRODUTO+SDA->DA_LOCAL+SDA->DA_LOTECTL+SDA->DA_NUMLOTE
							cCompara:="B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+B8_NUMLOTE"
						Else
							cSeek:=xFilial()+SDA->DA_PRODUTO+SDA->DA_LOCAL+SDA->DA_LOTECTL
							cCompara:="B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL"
						EndIf
						MsSeek(cSeek)
						nEmpenho:=SDA->DA_SALDO
						nEmpenh2:=SDA->DA_QTSEGUM  
						Do While !Eof() .And. nEmpenho > 0 .And. cSeek == &(cCompara)
							nBaixaEmp:=Min(nEmpenho,SB8Saldo(Nil,.T.,Nil,Nil,Nil,lEmpPrev))
							nBaixaEm2:=Min(nEmpenh2,SB8Saldo(Nil,.T.,Nil,.T.,Nil,lEmpPrev))
							RecLock("SB8",.F.)
							Replace B8_QACLASS With B8_QACLASS + nBaixaEmp
							Replace B8_QACLAS2 With B8_QACLAS2 + nBaixaEm2						
							nEmpenho -= nBaixaEmp   
							nEmpenh2 -= nBaixaEm2 
							MsUnlock()
							a215Skip()
						EndDo
						RestArea(aAreaSB8)
					EndIf
				EndIf
				a215Skip('SDA')
			 	If !lBat
			 		//oObj:IncRegua1(cMensagem)
			 	EndIf	
			EndDo
			RETINDEX("SDA")
			dbClearFilter()
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SD1")) .Or. cFilAnt == cFirst )
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza os dados acumulados da Pre-Nota de Entrada           ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SD1")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SD1")
			dbSetOrder(1)
			#IFDEF TOP
			If TcSrvType()<>"AS/400"
				cAliasSD1 := "SD1MA215PROC"

				cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
				cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
				cQuery += "FROM "+RetSqlName("SD1")+" SD1 "
				cQuery += "WHERE SD1.D1_FILIAL='"+xFilial("SD1")+"' AND "
				cQuery += "SD1.D1_IDENTB6<>'"+Space(Len(SD1->D1_IDENTB6))+"' AND "
				cQuery += "( SD1.D1_QTDEDEV > 0 OR SD1.D1_VALDEV > 0 ) AND "
				cQuery += "SD1.D_E_L_E_T_=' ' "    
				cQuery+= " And D1_COD='0501010003732' AND D1_LOCAL='01'"
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD1)
				nMax := (cAliasSD1)->MAXRECNO
				nMin := (cAliasSD1)->MINRECNO
				dbCloseArea()
				dbSelectArea("SD1")
				cQuery := "UPDATE "
				cQuery += RetSqlName("SD1")+" "
				cQuery += "SET D1_QTDEDEV = 0, D1_VALDEV = 0 "
				cQuery += "WHERE D1_FILIAL='"+xFilial("SD1")+"' AND "
				cQuery += "D1_IDENTB6<>'"+Space(Len(SD1->D1_IDENTB6))+"' AND "
				cQuery += "( D1_QTDEDEV > 0 OR D1_VALDEV > 0 ) AND "
				cQuery += "D_E_L_E_T_=' ' AND "           
				cQuery+= " D1_COD='0501010003732' AND D1_LOCAL='01' AND"				
				
				For nX := nMin To nMax+4096 STEP 4096
					cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
					TcSqlExec(cQuery+cChave)
				Next nX
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณA tabela eh fechada para restaurar o buffer da aplicacao?
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				dbSelectArea("SD1")
				dbCloseArea()
				ChkFile("SD1",.T.)

				aStru     := SD1->(dbStruct())
				lQuery    := .T.
				cAliasSD1 := "SD1MA215PROC"
				
				cQuery := "SELECT SD1.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SD1")+" SD1,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SD1.D1_FILIAL='"+xFilial("SD1")+"' AND "
				cQuery += "SD1.D1_TES = '"+Space(Len(SD1->D1_TES))+"' AND "
				#IFDEF SHELL
					cQuery += "SD1.D1_CANCEL = 'S' AND "
				#ENDIF
				cQuery += "SD1.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SD1.D1_COD AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery+= " And D1_COD='0501010003732' AND D1_LOCAL='01'"
				
				If ExistBlock("MA215SD1")
					cQuery := ExecBlock("MA215SD1",.F.,.F.,cQuery)
				EndIf
				
				cQuery += "ORDER BY D1_FILIAL,D1_COD,D1_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD1,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSD1,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			Else
			#ENDIF
				MsSeek(xFilial("SD1"))
			#IFDEF TOP
			EndIf
			#ENDIF
				
			If !lBat
				//oObj:SetRegua1(SD1->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasSD1)->D1_FILIAL == xFilial("SD1")
				lContinua := .T.       
				IsProd((cAliasSD1)->D1_COD,(cAliasSD1)->D1_LOCAL)
				
				If !lQuery
					If !Empty((cAliasSD1)->D1_IDENTB6) .And. ((cAliasSD1)->D1_QTDEDEV > 0 .Or. (cAliasSD1)->D1_VALDEV > 0)
						RecLock(cAliasSD1,.F.)
						(cAliasSD1)->D1_QTDEDEV := 0
						(cAliasSD1)->D1_VALDEV  := 0
						MsUnLock()
					EndIf				
					#IFDEF SHELL
						If D1_CANCEL == "S"
							lContinua := .F.
						EndIf
					#ENDIF
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					//?Atualizar Qtde Nao Classificada  em Saldos SB2.     ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					If !Empty((cAliasSD1)->D1_TES) .Or. !A215FilOk((cAliasSD1)->D1_COD)
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					dbSelectArea("SB2")
					dbSetOrder(1)
					If !MsSeek(xFilial("SB2")+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_LOCAL)
						CriaSB2((cAliasSD1)->D1_COD,(cAliasSD1)->D1_LOCAL)
					EndIf
					RecLock("SB2",.F.)
					Replace B2_NAOCLAS With B2_NAOCLAS + (cAliasSD1)->D1_QUANT
					MsUnLock()
				EndIf
				a215Skip(cAliasSD1)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSD1)
				dbCloseArea()
				dbSelectArea("SD1")
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If (!Empty(xFilial("SC0")) .Or. cFilAnt == cFirst )
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza os dados acumulados das Reserva de Faturamento       ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC0")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SC0")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SC0->(dbStruct())
				lQuery    := .T.
				cAliasSC0 := "SC0MA215PROC"
				
				cQuery := "SELECT SC0.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SC0")+" SC0,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC0.C0_FILIAL='"+xFilial("SC0")+"' AND "
				If !HasTemplate("OTC")
				   cQuery += "SC0.C0_QUANT > 0 AND "
				Endif   
				cQuery += "SC0.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=SC0.C0_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery+= " And C0_PRODUTO='0501010003732' AND C0_LOCAL='01'"
				cQuery += "ORDER BY C0_FILIAL,C0_PRODUTO,C0_LOCAL "
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC0,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSC0,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("SC0"))
			#ENDIF
			If !lBat
				//oObj:SetRegua1(SC0->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasSC0)->C0_FILIAL == xFilial("SC0")
			
				IsProd((cAliasSC0)->C0_PRODUTO,(cAliasSC0)->C0_LOCAL)
				lContinua := .T.
				If !lQuery
					If !( (cAliasSC0)->C0_QUANT > 0 ) .And. A215FilOk((cAliasSC0)->C0_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				
				If lContinua   
					Ma215Res(cAliasSC0, (cAliasSC0)->C0_QUANT, (cAliasSC0)->C0_QTDPED)
				EndIf
				
				a215Skip(cAliasSC0)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			
			If lQuery
				dbSelectArea(cAliasSC0)
				dbCloseArea()
				dbSelectArea("SC0")
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		If ( !Empty(xFilial("SC6")) .Or. cFilAnt == cFirst )
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณAtualiza os dados acumulados do PV e seus anexos              ?
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			lQuery := .F.
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SC6")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SC6")
			dbSetOrder(1)
			#IFDEF TOP
				If TcSrvType()<>"AS/400"
				cAliasSC6 := "SC6MA215PROC"
				
				cQuery := "SELECT MIN(R_E_C_N_O_) MINRECNO,"
				cQuery += "MAX(R_E_C_N_O_) MAXRECNO "
				cQuery += "FROM "+RetSqlName("SC6")+" SC6 "
				cQuery += "WHERE SC6.C6_FILIAL='"+xFilial("SC6")+"' AND "
				cQuery += "C6_BLQ <> 'S"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "C6_BLQ <> 'R"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "(C6_QTDVEN > C6_QTDENT OR (C6_QTDVEN <= C6_QTDENT AND C6_ENTREG>='"+DTOS(dDataBase-31)+"')) AND "
				cQuery += "SC6.D_E_L_E_T_=' ' "
				cQuery+= " And C6_PRODUTO='0501010003732' AND C6_LOCAL='01'"
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6)
				nMax := (cAliasSC6)->MAXRECNO
				nMin := (cAliasSC6)->MINRECNO
				dbCloseArea()
				dbSelectArea("SC6")
				cQuery := "UPDATE "
				cQuery += RetSqlName("SC6")+" "
				cQuery += "SET C6_QTDEMP = 0, C6_QTDENT = 0, C6_QTDEMP2 = 0, C6_QTDENT2 = 0 "
				cQuery += "WHERE C6_FILIAL='"+xFilial("SC6")+"' AND "
				cQuery += "C6_BLQ <> 'S"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "C6_BLQ <> 'R"+Space(Len(SC6->C6_BLQ)-1)+"' AND "
				cQuery += "(C6_QTDVEN > C6_QTDENT OR (C6_QTDVEN <= C6_QTDENT AND C6_ENTREG>='"+Dtos(dDataBase-31)+"')) AND "
				cQuery += "D_E_L_E_T_=' ' AND "
				cQuery+= " C6_PRODUTO='0501010003732' AND C6_LOCAL='01' AND"				
				For nX := nMin To nMax+4096 STEP 4096                     
				
					cChave := "R_E_C_N_O_>="+Str(nX,10,0)+" AND R_E_C_N_O_<="+Str(nX+4096,10,0)+""
					TcSqlExec(cQuery+cChave)
				Next nX
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณA tabela eh fechada para restaurar o buffer da aplicacao?
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				dbSelectArea("SC6")
				dbCloseArea()
				ChkFile("SC6",.T.)
			
				aStru     := SC6->(dbStruct())
				lQuery    := .T.
				cAliasSC6 := "SC6MA215PROC"
			
				cQuery := "SELECT SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_ITEM,SC6.C6_PRODUTO,SC6.C6_BLQ,"
				cQuery += "SC6.C6_NUMOS,SC6.C6_QTDEMP,SC6.C6_NUMOSFA,"
				cQuery += "SC6.C6_QTDENT,SC6.C6_RESERVA,SC6.C6_TES,SC6.C6_NUMLOTE,"
				cQuery += "SC6.C6_CLI,SC6.C6_LOCAL,SC6.C6_LOTECTL,SC6.C6_LOJA,SC6.C6_QTDVEN,"
				cQuery += "SC6.C6_OP,SC6.C6_NUMSERI,SC6.C6_LOCALIZ,SC6.C6_QTDRESE,SC6.C6_DTVALID,"
				cQuery += "SC6.C6_QTDLIB,SC6.C6_PRCVEN,"
				cQuery += "SC6.C6_PRUNIT,SC6.C6_VALDESC,"
				cQuery += "SC6.C6_VALOR,SC6.C6_UNSVEN,SC6.C6_ENTREG,SC6.C6_DATFAT, "
				cQuery += "SC6.C6_DESCONT,SC6.C6_QTDLIB2,"
				cQuery += "SC6.R_E_C_N_O_ SC6RECNO,SB1.B1_FILIAL "
				
				If SC6->(FieldPos("C6_QTDEMP2")) > 0
					cQuery += ",SC6.C6_QTDEMP2 "
				Endif                       
				
				If SC6->(FieldPos("C6_QTDENT2")) > 0
					cQuery += ",SC6.C6_QTDENT2 "
				Endif                       
				If cPaisLoc <> "BRA"
					cQuery += ",SC6.C6_GERANF,SC6.C6_CONTRAT,SC6.C6_ITEMCON "
				EndIf
				cQuery += "FROM "+RetSqlName("SC6")+" SC6, "+RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SC6.C6_FILIAL='" + xFilial( "SC6" ) + "' AND "
				cQuery += "SC6.C6_BLQ <> 'S ' AND SC6.C6_BLQ <> 'R ' AND "
				cQuery += "(SC6.C6_QTDVEN > SC6.C6_QTDENT OR (SC6.C6_QTDVEN <= SC6.C6_QTDENT AND SC6.C6_ENTREG>='"+DTOS(dDataBase-31)+"')) AND "
				cQuery += "SC6.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='" + xFilial( "SB1" ) + "' AND "
				cQuery += "SB1.B1_COD=SC6.C6_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery+= " AND C6_PRODUTO='0501010003732' AND C6_LOCAL='01'"
				cQuery += "ORDER BY C6_FILIAL,C6_NUM,C6_ITEM,C6_PRODUTO "
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
						TcSetField(cAliasSC6,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
				Else
			#ENDIF
					MsSeek(xFilial("SC6"))
			#IFDEF TOP
				EndIf
			#ENDIF
			lLiberOk  := .T.
			lResidOk  := .T.
			lFaturOk  := .F.
			If !lBat
				//oObj:SetRegua1(SC6->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !(cAliasSC6)->( Eof() ) .And. (cAliasSC6)->C6_FILIAL == xFilial("SC6")
				lContinua := .T.
				cQuebra   := (cAliasSC6)->C6_NUM
				IsProd((cAliasSC6)->C6_PRODUTO,(cAliasSC6)->C6_LOCAL)							
				BEGIN TRANSACTION
				If !lQuery 
					If !A215FilOk(SC6->C6_PRODUTO) .And. AllTrim(SC6->C6_BLQ)$"RS"
						lContinua := .F.
					EndIf
					If lContinua 
						RecLock("SC6",.F.)
						SC6->C6_QTDEMP  := 0
						SC6->C6_QTDENT  := 0
						SC6->C6_QTDEMP2 := 0
						SC6->C6_QTDENT2 := 0										
						MsUnlock()
					EndIf
				EndIf
				If lContinua
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณAtualiza os acumulados dos pedidos de venda entregue          ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If cAliasSC6<>"SC6"
						lSC6Ok := .F.
					Else
						lSC6Ok := .T.
					EndIf
					dbSelectArea("SD2")
					dbSetOrder(8)
					#IFDEF TOP
						If TcSrvType()<>"AS/400"
							aStru     := SD2->(dbStruct())
							lQuery    := .T.
							cAliasSD2 := "SD2MA215PROC1"
					
							cQuery := "SELECT D2_FILIAL,D2_PEDIDO,D2_ITEMPV,D2_QUANT,D2_QTSEGUM,D2_COD,D2_DOC,D2_SERIE,D2_EMISSAO,D2_REMITO "
							cQuery += "FROM "+RetSqlName("SD2")+" SD2 "
							
							If !Empty(xFilial("SC6"))
								cQuery += "WHERE SD2.D2_FILIAL='"+xFilial("SD2")+"' AND "
							Else
								cQuery += "WHERE "
							EndIf
							
							cQuery += "SD2.D2_PEDIDO = '"+(cAliasSC6)->C6_NUM+"' AND "
							cQuery += "SD2.D2_ITEMPV = '"+(cAliasSC6)->C6_ITEM+"' AND "
							cQuery += "SD2.D2_COD = '"+(cAliasSC6)->C6_PRODUTO+"' AND "
							cQuery += "SD2.D_E_L_E_T_=' ' "	
							If ExistBlock("MA215SD2")
								cQuery := ExecBlock("MA215SD2",.F.,.F.,cQuery)
							EndIf
						
							cQuery += "ORDER BY "+SqlOrder(SD2->(IndexKey()))
							cQuery := ChangeQuery(cQuery)
				
							dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD2,.T.,.T.)
							For nX := 1 To Len(aStru)
								If ( aStru[nX][2] <> "C" .And. FieldPos(aStru[nX][1])<>0 )
									TcSetField(cAliasSD2,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
								EndIf
							Next nX	
						Else
					#ENDIF
							MsSeek(IIf(!Empty(xFilial("SC6")),xFilial("SD2"),xFilial("SC6"))+(cAliasSC6)->C6_NUM+(cAliasSC6)->C6_ITEM)
					#IFDEF TOP
						EndIf
					#ENDIF
					While !Eof() .And. (IIF(!Empty(xFilial("SC6")), xFilial("SD2") == (cAliasSD2)->D2_FILIAL, .T.)) .And.;
						(cAliasSC6)->C6_NUM == (cAliasSD2)->D2_PEDIDO .And.	(cAliasSC6)->C6_ITEM == (cAliasSD2)->D2_ITEMPV
						
						IsProd((cAliasSD2)->D2_COD,(cAliasSC6)->C6_LOCAL)
						If (cAliasSD2)->D2_COD == (cAliasSC6)->C6_PRODUTO
							If lQuery
								SC6->(MsGoto((cAliasSC6)->SC6RECNO))
								lSC6Ok := .T.
							EndIf
							MaAvalSC6("SC6",5,"SC5",.F.,.F.,@lLiberOk,@lResidOk,@lFaturOk,.T.,,cAliasSD2)
						EndIf					
						dbSelectArea(cAliasSD2)
						dbSkip()
					EndDo
					If lQuery
						dbSelectArea(cAliasSD2)
						dbCloseArea()
						dbSelectArea("SD2")
					EndIf							
	
					If lQuery
						SC6->(MsGoto((cAliasSC6)->SC6RECNO))
						lSC6Ok := .T.
					EndIf          
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					//?Passa as variaveis lLiberok, lResidOk e lFaturOk sem referencia para nao modificar o conteudo ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
					
					If !Empty((cAliasSC6)->C6_RESERVA) .And.(cAliasSC6)->C6_QTDRESE > 0
						SC0->(dbSetOrder(1))
						If SC0->(MsSeek(xFilial("SC0")+(cAliasSC6)->C6_RESERVA+(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_LOCAL))
							Ma215Res("SC0",(cAliasSC6)->C6_QTDRESE)
						Endif	
					Endif					
					
					MaAvalSC6(IIf(lSC6Ok,"SC6",cAliasSC6),1,"SC5",.F.,.F.,lLiberOk,lResidOk,lFaturOk,.T.)
					
					dbSelectArea("SC9")
					dbSetOrder(1)
					#IFDEF TOP
						If TcSrvType()<>"AS/400"
						aStru     := SC9->(dbStruct())
						lQuery    := .T.
						cAliasSC9 := "SC9MA215PROC1"
				
						cQuery := "SELECT * "
						cQuery += "FROM "+RetSqlName("SC9")+" SC9 "
						cQuery += "WHERE SC9.C9_FILIAL='"+xFilial("SC9")+"' AND "
						cQuery += "SC9.C9_PEDIDO = '"+(cAliasSC6)->C6_NUM+"' AND "
						cQuery += "SC9.C9_ITEM = '"+(cAliasSC6)->C6_ITEM+"' AND "
						cQuery += "SC9.C9_PRODUTO = '"+(cAliasSC6)->C6_PRODUTO+"' AND "
						cQuery += "SC9.C9_NFISCAL = '"+Space(Len(SC9->C9_NFISCAL))+"' AND "
						cQuery += "SC9.C9_REMITO = '"+Space(Len(SC9->C9_REMITO))+"' AND "
						cQuery += "SC9.D_E_L_E_T_=' ' "	
						cQuery += "ORDER BY "+SqlOrder(SC9->(IndexKey()))
						cQuery := ChangeQuery(cQuery)
				
						dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC9,.T.,.T.)
						For nX := 1 To Len(aStru)
							If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
								TcSetField(cAliasSC9,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
							EndIf
						Next nX	
						Else
					#ENDIF
							MsSeek(xFilial("SC9")+(cAliasSC6)->C6_NUM+(cAliasSC6)->C6_ITEM)
					#IFDEF TOP
						EndIf
					#ENDIF
					While !Eof() .And. xFilial("SC9") == (cAliasSC9)->C9_FILIAL .And.;
						(cAliasSC6)->C6_NUM == (cAliasSC9)->C9_PEDIDO .And. ;
						(cAliasSC6)->C6_ITEM == (cAliasSC9)->C9_ITEM
							
						If Empty((cAliasSC9)->C9_NFISCAL) .And. Empty((cAliasSC9)->C9_REMITO)		
							If  (cAliasSC9)->C9_PRODUTO == (cAliasSC6)->C6_PRODUTO
								aSaldos := {}       
								IsProd((cAliasSC9)->C9_PRODUTO,(cAliasSC9)->C9_LOCAL)
								
								If Localiza((cAliasSC9)->C9_PRODUTO) .And. ;
									(!IntDL((cAliasSC9)->C9_PRODUTO) .Or. !((cAliasSC9)->C9_BLWMS$'01;02;03'))
									cAliasSDC := "SDC"
									dbSelectArea("SDC")
									dbSetOrder(1)
									cSeekSDC := xFilial("SDC")+;
												(cAliasSC9)->C9_PRODUTO+;
												(cAliasSC9)->C9_LOCAL+;
												"SC6"+;
												(cAliasSC9)->C9_PEDIDO+;
												(cAliasSC9)->C9_ITEM
									#IFDEF TOP
										If TcSrvType()<>"AS/400"
										aStru     := SDC->(dbStruct())
										lQuery    := .T.
										cAliasSDC := "SDCMA215PROC2"
															
										cQuery := "SELECT * "
										cQuery += "FROM "+RetSqlName("SDC")+" SDC "
										cQuery += "WHERE SDC.DC_FILIAL='"+xFilial("SDC")+"' AND "
										cQuery += "SDC.DC_PRODUTO = '"+(cAliasSC9)->C9_PRODUTO+"' AND "
										cQuery += "SDC.DC_LOCAL = '"+(cAliasSC9)->C9_LOCAL+"' AND "
										cQuery += "SDC.DC_ORIGEM = 'SC6' AND "
										cQuery += "SDC.DC_PEDIDO = '"+(cAliasSC9)->C9_PEDIDO+"' AND "
										cQuery += "SDC.DC_ITEM = '"+(cAliasSC9)->C9_ITEM+"' AND "
										cQuery += "SDC.DC_SEQ = '"+(cAliasSC9)->C9_SEQUEN+"' AND "
										cQuery += "SDC.D_E_L_E_T_=' ' "	
										cQuery += "ORDER BY "+SqlOrder(SDC->(IndexKey()))
										cQuery := ChangeQuery(cQuery)
								
										dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDC,.T.,.T.)
										For nX := 1 To Len(aStru)
											If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
												TcSetField(cAliasSDC,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
											EndIf
										Next nX	
										Else
									#ENDIF
											MsSeek(cSeekSDC)
									#IFDEF TOP
										EndIf
									#ENDIF
									While !Eof() .And. DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+DC_PEDIDO+DC_ITEM == cSeekSDC
										//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
										//?Atualiza arquivo de empenhos               ?
										//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
										
										If (cAliasSDC)->DC_SEQ == (cAliasSC9)->C9_SEQUEN
	
											aadd(aSaldos,{	(cAliasSDC)->DC_LOTECTL,;
															(cAliasSDC)->DC_NUMLOTE,;
															(cAliasSDC)->DC_LOCALIZ,;
															(cAliasSDC)->DC_NUMSERI,;
															(cAliasSDC)->DC_QUANT,;
															If( Empty( (cAliasSDC)->DC_QTSEGUM ), ConvUm((cAliasSDC)->DC_PRODUTO,(cAliasSDC)->DC_QUANT,0,2),(cAliasSDC)->DC_QTSEGUM ),;
															(cAliasSC9)->C9_DTVALID,;
															"",;
															"",;
															"",;
															(cAliasSDC)->DC_LOCAL})
	
															
										EndIf
										dbSelectArea(cAliasSDC)
										dbSkip()
									EndDo
									If lQuery
										dbSelectArea(cAliasSDC)
										dbCloseArea()
										dbSelectArea("SDC")
									EndIf						
								Else
									nQtdLib2 := If(Empty((cAliasSC9)->C9_QTDLIB2),ConvUm((cAliasSC9)->C9_PRODUTO,(cAliasSC9)->C9_QTDLIB,0,2),(cAliasSC9)->C9_QTDLIB2)
									aSaldos := {{ "","","","",(cAliasSC9)->C9_QTDLIB,nQtdLib2,	Ctod(""),"","","",(cAliasSC9)->C9_LOCAL}}
								EndIf
								//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
								//ณAtualiza os acumulados da liberacao do pedido de venda        ?
								//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
								MaAvalSC9(cAliasSC9,1,aSaldos,,.T.)
							EndIf
						EndIf
						dbSelectArea(cAliasSC9)
						dbSkip()
					EndDo    
					
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณAtualiza os acumulados do item do pedido de venda             ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If lQuery
						SC6->(MsGoto((cAliasSC6)->SC6RECNO))
						lSC6Ok := .T.
					EndIf		
			
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//?Verificacao dos acumulados do SC5                                      ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					If ( SC6->C6_QTDVEN > (SC6->C6_QTDEMP+SC6->C6_QTDENT) .And. AllTrim(SC6->C6_BLQ)<>"R")
						lLiberOk := .F.
					EndIf
					If (! "R" $ SC6->C6_BLQ )
						lResidOk := .F.
					EndIf
					If ( SC6->C6_QTDVEN > SC6->C6_QTDENT .And. AllTrim(SC6->C6_BLQ)<>"R")
						lFaturOk := .T.
					EndIf
					
					If lQuery
						dbSelectArea(cAliasSC9)
						dbCloseArea()
						dbSelectArea("SC9")
					EndIf
				EndIf
				dbSelectArea(cAliasSC6)
				dbSkip()
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
				If cQuebra <> (cAliasSC6)->C6_NUM
					dbSelectArea("SC5")
					dbSetOrder(1)
					If MsSeek(xFilial("SC5")+cQuebra)
						MaAvalSC5("SC5",1,.F.,.F.,@lLiberOk,@lResidOk,@lFaturOk,.T.)
					EndIf
					lLiberOk  := .T.
					lResidOk  := .T.
					lFaturOk  := .F.
				EndIf
				End Transaction
			EndDo
			If lQuery
				dbSelectArea(cAliasSC6)
				dbCloseArea()
				dbSelectArea("SC6")
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAtualiza os dados acumulados do PODER de 3 e EM 3.            ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If ( !Empty(xFilial("SB6")) .Or. cFilAnt == cFirst )	
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("SB6")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			dbSelectArea("SB6")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := SB6->(dbStruct())
				lQuery    := .T.
				cAliasSB6 := "SB6MA215PROC"
			
				cQuery := "SELECT SB6.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("SB6")+" SB6, "
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE SB6.B6_FILIAL='"+xFilial("SB6")+"' AND "
				cQuery += "SB6.B6_QUANT > 0 AND "
				cQuery += "SB6.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "	
				cQuery += "SB1.B1_COD=SB6.B6_PRODUTO AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "                    
				cQuery+= " AND B6_PRODUTO='0501010003732' AND B6_LOCAL='01'"				
				cQuery += "ORDER BY B6_FILIAL,B6_PRODUTO,B6_LOCAL "
				cQuery := ChangeQuery(cQuery)
			
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB6,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasSB6,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("SB6"))
			#ENDIF
			If !lBat
				//oObj:SetRegua1(SB6->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. xFilial("SB6") == (cAliasSB6)->B6_FILIAL
				lContinua := .T.
				cLocOriSB6:= ""
				If !lQuery
					If !A215FilOk((cAliasSB6)->B6_PRODUTO)
						lContinua := .F.
					EndIf
				EndIf
				
				dbSelectArea("SF4")
				dbSetOrder(1)
				MsSeek(xFilial("SF4")+(cAliasSB6)->B6_TES)
					
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณQuando for devolucao de material que estava em terceiros,     ?
				//|posicionar sempre no local de origem da remessa. 			 |
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If SF4->F4_PODER3 == "D" .And. (cAliasSB6)->B6_TES < "501"
					nRegSB6 := SB6->(RecNo())
					aAreaSB6:= SB6->(GetArea())
					dbSelectArea("SB6")
					dbSetOrder(3)
					If SB6->(MsSeek(xFilial("SB6")+(cAliasSB6)->B6_IDENT+(cAliasSB6)->B6_PRODUTO+"R"))
						cLocOriSB6 := SB6->B6_LOCAL //Local de Origem
					EndIf	
					RestArea(aAreaSB6)
					SB6->(MsGoto(nRegSB6))
				EndIf	

				dbSelectArea("SB2")
				dbSetOrder(1)
				If MsSeek(xFilial("SB2")+(cAliasSB6)->B6_PRODUTO+IIf(Empty(cLocOriSB6),(cAliasSB6)->B6_LOCAL,cLocOriSB6))
					RecLock("SB2",.F.)
				Else
					CriaSB2((cAliasSB6)->B6_PRODUTO,(cAliasSB6)->B6_LOCAL)
				EndIf
	            RecLock("SB2")
	
			    cEstoque := (cAliasSB6)->B6_ESTOQUE
	
	 	       //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	 	       //ณAtualiza os Campos B2_QTER, B2_QNPT, B2_QTNP.                 ?
		       //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	            
	            IF SF4->F4_CODIGO <= "500"   // Documentos de Entrada.
	               If ( SF4->F4_PODER3 $ "DR" )
	                  If ( SF4->F4_PODER3 == "D" ) // Devolucoes.
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
					        Replace B2_QTER with B2_QTER - (cAliasSB6)->B6_QUANT
				         Else
					        Replace B2_QNPT With B2_QNPT - (cAliasSB6)->B6_QUANT
				         EndIf
			          Else  // Remessas.
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
					        Replace B2_QTER With B2_QTER + (cAliasSB6)->B6_QUANT
				         Else
					        Replace B2_QTNP With B2_QTNP + (cAliasSB6)->B6_QUANT
				         EndIf
			          EndIf
		           EndIf
	   		    Else  // Doucmentos de Saida.
		           If ( SF4->F4_PODER3 $ "DR" )
			          If ( SF4->F4_PODER3 == "D" )  // Devolucoes.
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
				            Replace B2_QTER With B2_QTER - (cAliasSB6)->B6_QUANT
				         Else
				            Replace B2_QTNP With B2_QTNP - (cAliasSB6)->B6_QUANT
				         EndIf
			          Else  //Remessas
				         If IIf(Empty(cEstoque),SF4->F4_ESTOQUE,cEstoque)=="N"
					        Replace B2_QTER With B2_QTER + (cAliasSB6)->B6_QUANT
				         Else
					        Replace B2_QNPT With B2_QNPT + (cAliasSB6)->B6_QUANT
				         EndIf
			          EndIf
		           EndIf
			    Endif  
	
	            SB2->(MsUnLock())
				a215Skip(cAliasSB6)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf	
			EndDo
			If lQuery
				dbSelectArea(cAliasSB6)
				dbCloseArea()
				dbSelectArea("SB6")
			EndIf
		EndIf
		If !lBat
			//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
		EndIf	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAtualiza os dados acumulados dos empenhos do SIGAPMS          ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If (!Empty(xFilial("AFJ")) .Or. cFilAnt == cFirst )
			dbSelectArea("SX2")
			dbSetOrder(1)
			MsSeek("AFJ")
			cMensagem := AllTrim(X2Nome())
			cMensagem := Lower(cMensagem)
			cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
			
			dbSelectArea("AFJ")
			dbSetOrder(1)
			#IFDEF TOP
				aStru     := AFJ->(dbStruct())
				lQuery    := .T.
				cAliasAFJ := "AFJMA215PROC"
				
				cQuery := "SELECT AFJ.*,SB1.B1_FILIAL "
				cQuery += "FROM "+RetSqlName("AFJ")+" AFJ,"
				cQuery += RetSqlName("SB1")+" SB1 "
				cQuery += "WHERE AFJ.AFJ_FILIAL='"+xFilial("AFJ")+"' AND "
   			If FieldPos("AFJ_EMPEST") > 0
					cQuery += "AFJ.AFJ_QEMP > (AFJ.AFJ_QATU + AFJ.AFJ_EMPEST) AND "
				Else
					cQuery += "AFJ.AFJ_QEMP > AFJ.AFJ_QATU AND "
				EndIf					
				cQuery += "AFJ.D_E_L_E_T_=' ' AND "
				cQuery += "SB1.B1_FILIAL='"+xFilial("SB1")+"' AND "
				cQuery += "SB1.B1_COD=AFJ.AFJ_COD AND "
				cQuery += "SB1.D_E_L_E_T_=' ' "
				cQuery+=" And B1_COD='0501010003732' "				
				cQuery += "ORDER BY AFJ_FILIAL,AFJ_COD,AFJ_LOCAL"
			
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasAFJ,.T.,.T.)
				For nX := 1 To Len(aStru)
					If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
						TcSetField(cAliasAFJ,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
					EndIf
				Next nX
			#ELSE
				MsSeek(xFilial("AFJ"))
			#ENDIF
			If !lBat
				//oObj:SetRegua1(AFJ->(LastRec()))
				//oObj:IncRegua1(cMensagem)
			EndIf	
			While !Eof() .And. (cAliasAFJ)->AFJ_FILIAL == xFilial("AFJ")
				lContinua := .T.
				If !lQuery
					If !A215FilOk((cAliasAFJ)->AFJ_COD) .Or. ((cAliasAFJ)->AFJ_QEMP <= (cAliasAFJ)->AFJ_QATU .And. (AFJ->(FieldPos("AFJ_QEMPPR")) > 0 .And. Empty(AFJ->AFJ_QEMPPR)))
						lContinua := .F.
					EndIf
				EndIf
				If lContinua
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//?Atualiza arquivo de empenhos               ?
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
					PmsAtuEmp(	(cAliasAFJ)->AFJ_PROJET,;
								(cAliasAFJ)->AFJ_TAREFA,;
								(cAliasAFJ)->AFJ_COD,;
								(cAliasAFJ)->AFJ_LOCAL,;
								(cAliasAFJ)->AFJ_QEMP-((cAliasAFJ)->AFJ_QATU + IIf(FieldPos("AFJ_EMPEST") > 0,(cAliasAFJ)->AFJ_EMPEST,0)),;
								"+",;
								.F.,;
								(cAliasAFJ)->AFJ_QEMP2-((cAliasAFJ)->AFJ_QATU2 + IIf(FieldPos("AFJ_EMPES2") > 0,(cAliasAFJ)->AFJ_EMPES2,0)),;
								(cAliasAFJ)->AFJ_TRT)
					If AFJ->(FieldPos("AFJ_QEMPPR")) > 0
						PmsAtuEmp(	(cAliasAFJ)->AFJ_PROJET,;
									(cAliasAFJ)->AFJ_TAREFA,;
									(cAliasAFJ)->AFJ_COD,;
									(cAliasAFJ)->AFJ_LOCAL,;
									(cAliasAFJ)->AFJ_QEMPPR,;
									"+",;
									.F.,;
									(cAliasAFJ)->AFJ_QEMPP2,;
									(cAliasAFJ)->AFJ_TRT,;
									,,,;
									.T.)
					EndIf
				EndIf
				a215Skip(cAliasAFJ)
				If !lBat
					//oObj:IncRegua1(cMensagem)
				EndIf
			EndDo
			If lQuery
				dbSelectArea(cAliasAFJ)
				dbCloseArea()
				dbSelectArea("AFJ")
			EndIf
		EndIf
	EndIf
	If !lBat
		//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
	EndIf	
	If (!Empty(xFilial("SL2")) .Or. cFilAnt == cFirst )
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAtualiza os dados acumulados das Reservas do SigaLoja         ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		dbSelectArea("SX2")
		dbSetOrder(1)
		DbSeek("SL2")
		cMensagem := AllTrim(X2Nome())
		cMensagem := Lower(cMensagem)
		cMensagem := Upper(SubStr(cMensagem,1,1))+SubStr(cMensagem,2)
		dbSelectArea("SL2")
		dbSetOrder(1)
		#IFDEF TOP
			cAliasSL2 := "SL2RES"
			SX3->(DbSetOrder(2))
			If SX3->(DbSeek("L2_QUANT"))
				aStru := { SX3->X3_CAMPO, SX3->X3_TIPO, SX3->X3_TAMANHO, SX3->X3_DECIMAL }
			EndIf
			lQuery    := .T.
			cQuery := "SELECT SUM(L2_QUANT) L2_QUANT, L2_PRODUTO, L2_FILIAL, L2_LOCAL "
  			cQuery += "FROM " + RetSqlName("SL2") +  " SL2 "
 			cQuery += "WHERE SL2.L2_FILIAL = '" + xFilial("SL2") + "' "
 			cQuery += "AND SL2.L2_PDV = '' "
 			cQuery += "AND SL2.L2_RESERVA <> '' "
 			cQuery += "AND SL2.L2_ORCRES = '' "
 			cQuery += "AND SL2.L2_PEDRES = ' '"
 			cQuery += "AND SL2.L2_VENDIDO <> 'S'"
 			cQuery += "AND D_E_L_E_T_=' ' "
			cQuery += "GROUP BY SL2.L2_FILIAL, SL2.L2_PRODUTO, SL2.L2_LOCAL"
			cQuery := ChangeQuery(cQuery)
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSL2,.T.,.T.)
			If Len(aStru) > 0
				TcSetField( cAliasSL2, aStru[1], aStru[2], aStru[3], aStru[4] ) 
			EndIf
		#ELSE
			DbSeek(xFilial("SL2"), .T.)
		#ENDIF
		If !lBat
			//oObj:SetRegua1(SL2->(LastRec()))
			//oObj:IncRegua1(cMensagem)
		EndIf	
		While !Eof() .And. (cAliasSL2)->L2_FILIAL == xFilial("SL2")
			lContinua := .T.
			lAtuRes   := .T.
			If !lQuery
				If !A215FilOk((cAliasSL2)->L2_PRODUTO) .OR. !Empty((cAliasSL2)->L2_PDV);
					.OR. Empty((cAliasSL2)->L2_RESERVA) .OR. !Empty((cAliasSL2)->L2_ORCRES)
					lContinua := .F.
				EndIf
			EndIf
			
			If HasTemplate("OTC")
				DbSelectArea("SB1")
				DbSetOrder(1)
	            DbSeek( xFilial("SB1") + (cAliasSL2)->L2_PRODUTO )
				If SB1->B1_TIPO == "LG"
				   lAtuRes  := .F.
				EndIf 
			EndIf
			
			If lContinua .AND. lAtuRes 
                Ma215LjAtuRes( cAliasSL2 )
			EndIf
			
			a215Skip(cAliasSL2)
			If !lBat
				//oObj:IncRegua1(cMensagem)
			EndIf	
		End
		
		If lQuery
			dbSelectArea(cAliasSL2)
			dbCloseArea()
			dbSelectArea("SM0")
		EndIf
	EndIf
	If !lBat
		//oObj:IncRegua2(STR0007+" - "+AllTrim(SM0->M0_NOME)+"/"+SM0->M0_FILIAL) //"Atualizando acumulados"
	EndIf	
	
	If !lBat
		If (oObj <> NIL) .And. lNewProc
			//oObj:SaveLog(OemToAnsi(STR0010))
		EndIf
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
	//?Atualiza o log de processamento             ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
	ProcLogAtu("MENSAGEM",STR0013+cFilAnt,STR0013+cFilAnt) //"Final Filial: "
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//?Verifica se deve continuar a atualizar as demais filiais     ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If (!Empty(xFilial("SA1")) .And. !Empty(xFilial("SB2")) .And. !lPCFilEnt)
		Exit
	EndIf
    
	//Ponto de entrada executado ap๓s o calculo para valida็๕es
	If ExistBlock("MT215EXC")
		ExecBlock("MT215EXC",.F.,.F.)   
	EndIf 
	
	dbSelectArea("SM0")	
	dbSkip()
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Fecha todos os arquivos e reabre-os de forma compartilhada   ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nTempoFim:=Seconds()
cFilAnt := cSavFil
For nX := 1 To Len(aTabs)
	dbSelectArea(aTabs[nX])
	dbCloseArea()
Next	
OpenFile(SubStr(cNumEmp,1,2),"")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Envia mensagem de aviso apos termino da rotina               ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cTempo:=StrZero((nTempoFim-nTempoIni)/60,5,0)
MEnviaMail("021",{CUSERNAME,SubStr(cNumEmp,1,2),SubStr(cNumEmp,3,2),cTempo})

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Fecha o semaforo de execucao da rotina                       ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MA215UnLock(cEmpAnt)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
//?Atualiza o log de processamento   ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
ProcLogAtu("FIM")

Return


/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑ?
ฑฑณFun…o    ณA215FilOk   ?Autor ณRodrigo de A Sartorio?Data ?01/03/00 ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณDescri…o ?Verifica no SB1 a existencia do produto                    ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณSintaxe   ?A215FilOk(ExpC1)                                           ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณParametros?ExpC1 := Codigo do produto a ser pesquisado                ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณRetorno   ?.T. = encontrou o produto em SB1, .F.= nao encontrou       ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑ?Uso      ?MATA215                                                    ณฑ?
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿?
*/
Static Function A215FilOk(cProd)
Return SB1->(MsSeek(xFilial("SB1")+cProd))


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑ?
ฑฑณFunao    ณA215Skip    ?Autor ณFernando Joly Siquini?Data ?26/03/02 ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณDescriao ?Se apos o dbSkip um dos Campos Chave (Filial, Produto ou   ณฑ?
ฑฑ?         ?Armazem) for alterado, a funcao MsUnlockAll() e executada. ณฑ?
ฑฑ?         ?Este procedimento evita a sobrecarga de LOCKS em ambientes ณฑ?
ฑฑ?         ?CDX e ADS(Em ambientes TOP a funcao nunca sera executada). ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณSintaxe   ?A215Skip(ExpC1)                                            ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณParametros?ExpC1 := Alias no qual o "dbSkip" sera executado.          ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณRetorno   ?.T. caso o MsUnlockAll() seja executado, .F. caso contrarioณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑ?Uso      ?MATA215                                                    ณฑ?
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿?/
Function a215Skip(c215Alias)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Define Variaveis Locais                                      ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cChaveA    := ''
Local cChaveB    := ''
Local cPrefix    := ''
Local cCpoFil    := ''
Local cCpoCod    := ''
Local cCpoLoc    := ''
Local lRet       := .F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//?Redefine Variaveis passadas como parametros                  ?
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Default c215Alias  := Alias()

If Select(c215Alias) > 0
	dbSelectArea(c215Alias)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//?Monta Strings com nomes dos campos FILIAL, PRODUTO e LOCAL   ?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cPrefix := If(SubStr(Upper(c215Alias),1,1)=='S',SubStr(Upper(c215Alias),2,2),SubStr(Upper(c215Alias),1,3))+'_'
	cCpoFil := If(FieldPos(cCpoFil:=cPrefix+'FILIAL')>0,cCpoFil,'')
	cCpoCod := If(FieldPos(cCpoCod:=cPrefix+'PRODUTO')>0,cCpoCod,If(FieldPos(cCpoCod:=cPrefix+'COD')>0,cCpoCod,''))
	cCpoLoc := If(FieldPos(cCpoLoc:=cPrefix+'LOCAL')>0,cCpoLoc,If(FieldPos(cCpoLoc:=cPrefix+'ALMOX')>0,cCpoLoc,''))
	If !((cCpoFil+cCpoCod+cCpoLoc)=='')
		cChaveA  := IIf(!Empty(cCpoFil),FieldGet(FieldPos(cCpoFil)),'')
		cChaveA  += IIf(!Empty(cCpoCod),FieldGet(FieldPos(cCpoCod)),'')
		cChaveA  += IIf(!Empty(cCpoLoc),FieldGet(FieldPos(cCpoLoc)),'')
		dbSkip()
		cChaveB := IIf(!Empty(cCpoFil),FieldGet(FieldPos(cCpoFil)),'')
		cChaveB += IIf(!Empty(cCpoCod),FieldGet(FieldPos(cCpoCod)),'')
		cChaveB += IIf(!Empty(cCpoLoc),FieldGet(FieldPos(cCpoLoc)),'')
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//?Executa o MsUnlockAll caso o dbSkip tenha alterado a Chave   ?
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If !(cChaveA==cChaveB)
			MsUnLockall()
			lRet := .T.
		EndIf
	Else
		dbSkip()
	EndIf	
EndIf
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑ?
ฑฑณFunao    ?Ma215Res   ?Autor ณHenry Fila           ?Data ?19/05/03 ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณDescriao ?Avaliacao da reserva por pedido de venda ou SC9            ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณSintaxe   ?Ma215Res(ExpC1,ExpN1)                                      ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณParametros?ExpC1 = Alias do SC0 		                              ณฑ?
ฑฑ?         ?ExpN2-Quantidade a reservar  			                  ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณRetorno   ?Nenhum                                                     ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑ?Uso      ?MATA215                                                    ณฑ?
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿?/

Static Function Ma215Res(cAliasSC0,nQtdRes,nQtdPed)

Local aArea    := GetArea()
Local aAreaSC0 := SC0->(GetArea())
Local aAreaSDC := SDC->(GetArea())

Local cSeekSDC := ""
Local cAliasSDC:= "SDC"
#IFDEF TOP
	Local aStru    := {}
	Local nX       := 0
	Local cQuery   := ""
#ENDIF
Local lQuery   := .F.

DEFAULT nQtdPed  := 0

If HasTemplate("OTC")
   nQtdRes  := nQtdPed   
EndIf
If Localiza((cAliasSC0)->C0_PRODUTO) .And. !IntDL((cAliasSC0)->C0_PRODUTO)
	cSeekSDC := xFilial("SDC")+;
		(cAliasSC0)->C0_PRODUTO+;
		(cAliasSC0)->C0_LOCAL+"SC0"+;
		(cAliasSC0)->C0_NUM+;
		Criavar("DC_ITEM")+;
		Criavar("DC_SEQ")+;
		(cAliasSC0)->C0_LOTECTL+;
		(cAliasSC0)->C0_NUMLOTE+;
		(cAliasSC0)->C0_LOCALIZ+;
		(cAliasSC0)->C0_NUMSERI
		
	dbSelectArea("SDC")
	dbSetOrder(1)
	#IFDEF TOP
		aStru     := SDC->(dbStruct())
		lQuery    := .T.
		cAliasSDC := "SDCMA215PROC1"

		cQuery := "SELECT * "
		cQuery += "FROM "+RetSqlName("SDC")+" SDC "
		cQuery += "WHERE SDC.DC_FILIAL='"+xFilial("SDC")+"' AND "
		cQuery += "SDC.DC_PRODUTO='"+(cAliasSC0)->C0_PRODUTO+"' AND "
		cQuery += "SDC.DC_LOCAL='"+(cAliasSC0)->C0_LOCAL+"' AND "
		cQuery += "SDC.DC_ORIGEM='SC0' AND "
		cQuery += "SDC.DC_PEDIDO='"+(cAliasSC0)->C0_NUM+"' AND "
		cQuery += "SDC.DC_ITEM='"+Criavar("DC_ITEM")+"' AND "
		cQuery += "SDC.DC_SEQ='"+Criavar("DC_SEQ")+"' AND "
		cQuery += "SDC.DC_LOTECTL='"+(cAliasSC0)->C0_LOTECTL+"' AND "
		cQuery += "SDC.DC_NUMLOTE='"+(cAliasSC0)->C0_NUMLOTE+"' AND "
		cQuery += "SDC.DC_LOCALIZ='"+(cAliasSC0)->C0_LOCALIZ+"' AND "
		cQuery += "SDC.DC_NUMSERI='"+(cAliasSC0)->C0_NUMSERI+"' AND "
		cQuery += "SDC.D_E_L_E_T_=' ' "
		cQuery += "ORDER BY "+SqlOrder(SDC->(IndexKey()))

		cQuery := ChangeQuery(cQuery)

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDC,.T.,.T.)
		For nX := 1 To Len(aStru)
			If ( aStru[nX][2] <> "C" .And. aStru[nX][2] <> "M" )
				TcSetField(cAliasSDC,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
			EndIf
		Next nX
	#ELSE		
		MsSeek(cSeekSDC)
	#ENDIF			
	While !Eof() .And. DC_FILIAL+DC_PRODUTO+DC_LOCAL+DC_ORIGEM+DC_PEDIDO+DC_ITEM+DC_SEQ+DC_LOTECTL+DC_NUMLOTE+DC_LOCALIZ+DC_NUMSERI == cSeekSDC
		GravaEmp((cAliasSDC)->DC_PRODUTO,;
			(cAliasSDC)->DC_LOCAL,;
			(cAliasSDC)->DC_QUANT,;
			(cAliasSDC)->DC_QTSEGUM,;
			(cAliasSDC)->DC_LOTECTL,;
			(cAliasSDC)->DC_NUMLOTE,;
			(cAliasSDC)->DC_LOCALIZ,;
			(cAliasSDC)->DC_NUMSERI,;
			Nil,;
			Nil,;
			(cAliasSDC)->DC_PEDIDO,;
			Nil,;
			"SC0",;
			Nil,;
			Nil,;
			Nil,;
			.F.,;
			.F.,;
			.T.,;
			.F.,;
			NIL,;
			.T.,;
			.F.)
		a215Skip(cAliasSDC)
	EndDo
	If lQuery
		dbSelectArea(cAliasSDC)
		dbCloseArea()
		dbSelectArea("SDC")
	EndIf
Else
	GravaEmp((cAliasSC0)->C0_PRODUTO,;
		(cAliasSC0)->C0_LOCAL,;
		nQtdRes,;
		NIL,;
		(cAliasSC0)->C0_LOTECTL,;
		(cAliasSC0)->C0_NUMLOTE,;
		(cAliasSC0)->C0_LOCALIZ,;
		(cAliasSC0)->C0_NUMSERI,;
		Nil,;
		Nil,;
		(cAliasSC0)->C0_NUM,;
		Nil,;
		"SC0",;
		Nil,;
		Nil,;
		Nil,;
		.F.,;
		.F.,;
		.T.,;
		.F.,;
		Nil,;
		!Empty((cAliasSC0)->C0_LOTECTL+(cAliasSC0)->C0_NUMLOTE+(cAliasSC0)->C0_LOCALIZ+(cAliasSC0)->C0_NUMSERI),; //22
		.F.)
EndIf

RestArea(aAreaSC0)
RestArea(aAreaSDC)
RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMa215LjAtuResบAutor  ณMarcio Lopes        ?Data ? 15/05/07   บฑ?
ฑฑฬออออออออออุอออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ?Realiza a atualizacao do campo B2_RESERVA, para o modulo      บฑ?
ฑฑ?         ?SIGALOJA.                                                     บฑ?
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ?ExpC1 -> Alias do arquivos a ser utilizado                    บฑ?
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ?Generico                                                      บฑ?
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ?Nenhum                                                        ณฑ?
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ma215LjAtuRes( cAliasSL2 )

Local aAreaSB2 := SB2->(GetArea())			// Guarda a area atual do SB2

SB2->(dbSetOrder(1))
If SB2->( dbSeek(xFilial("SB2") + (cAliasSL2)->L2_PRODUTO + (cAliasSL2)->L2_LOCAL ) )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
	//ณVerifica se o produto ?uma reserva na base do SIGALOJA?
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
	RecLock("SB2", .F.)
	SB2->B2_RESERVA += (cAliasSL2)->L2_QUANT
	MsUnlock()
EndIf
Restarea(aAreaSB2)
dbSelectArea(cAliasSL2)

Return(.T.)                                                                              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑ?
ฑฑณFunao    ?Ma215Check ?Autor ณTOTVS S/A            ?Data ?17/01/14 ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณDescriao ?Avalia se a rotina MATA215 esta em execucao.               ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณSintaxe   ?Ma215Check()                                               ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณRetorno   ?Nenhum                                                     ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑ?Uso      ?GENERICO                                                   ณฑ?
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿?/

Function Ma215Check()
Local aTabs     := {}
Local nX        := 0
Local lContinua := .T.
Local cAliasTab := ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
//ณSomente validar se as tabelas estao exclusivas se a rotina 'Refaz        |
//|Acumulados (MATA215)' estiver em execucao.                               |
//|O parametro MV_A215CHK devera ser utilizado somente para contingencia.   |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ?
If !LockByName("MT215"+AllTrim(cEmpAnt),.T.,.F.) .And. SuperGetMv("MV_A215CHK",.F.,.T.)

	//Tabelas utilizadas pela rotina
	AADD(aTabs,"SA1");AADD(aTabs,"SB1");AADD(aTabs,"SB2")
	AADD(aTabs,"SB8");AADD(aTabs,"SC0");AADD(aTabs,"SC6")
	AADD(aTabs,"SC7");AADD(aTabs,"SC9");AADD(aTabs,"SD2")
	AADD(aTabs,"SD1");AADD(aTabs,"SD4");AADD(aTabs,"SDC")
	AADD(aTabs,"SDD");AADD(aTabs,"SC1");AADD(aTabs,"SC2")
	AADD(aTabs,"SB6");AADD(aTabs,"SBF");AADD(aTabs,"SDA")
	AADD(aTabs,"SL2");AADD(aTabs,"SCQ")
	
	//Verifica se as tabelas estao em modo exclusivo
	For nX := 1 to Len(aTabs)
		If !(ChkFile(aTabs[nX],.T.))
			cAliasTab := aTabs[nX]
			lContinua := .F.
			Exit
		EndIf
		(aTabs[nX])->(dbCloseArea())
		ChkFile(aTabs[nX],.F.)
	Next nX
	
	//Mensagem para o usuario
	If !lContinua
		If IsBlind()
			Conout(STR0014 + Space(1) + cAliasTab) //"MA215CHECK: Nใo foi possivel a abertura da tabela"
		Else
	
			//-- Grava Help MA215CHK
			aHlpPorP    := {"Existe tabelas que estใo abertas em "		,;
			 				"modo exclusivo e por este motivo nao "		,;
			 				"sera possivel a abertura do modulo."		}
			aHlpIngP    := {"There are tables that are open "			,;
			 				"exclusively and for this reason will "		,;
			 				"not be possible to open the module."		}
			aHlpEspP    := {"Hay mesas que estแn abiertos exclusi-"		,;
			 				"vamente y por este motivo no ser?"		,;
			 				"posible abrir el m๓dulo."					}
			PutHelp("PMA215CHK",aHlpPorP,aHlpIngP,aHlpEspP,.F.)
			//-- Grava Help MA215CHK
			aHlpPorP    := {"Caso a rotina Refaz Acumulados(MATA215) "	,;
			                "esteja em execu็ใo aguarde sua finaliza-"	,;
			                "็ใo para utiliza็ใo do modulo ou verifi-"	,;
			                "que a rotina que esta travando a tabela "	,;
			                "em questใo."								}
			aHlpIngP    := {"If the Accumulated Remakes (MATA215)"		,;
			                "routine is running its finalization wait"	,;
			                "to use the module or routine check that"	,;
			                "locking the table in question."			}
			aHlpEspP    := {"Si el Collected Redo (MATA215) rutina"		,;
			                "est?ejecutando su estrategia de esperar"	,;
			                "la finalizaci๓n de utilizar el m๓dulo o"	,;
			                "la tabla en cuesti๓n. "					}
			PutHelp("SMA215CHK",aHlpPorP,aHlpIngP,aHlpEspP,.F.)

			Help(" ",1,"MA215CHK")

			FINAL(STR0014 + Space(1) + cAliasTab,,.F.)	//"MA215CHECK: Nใo foi possivel a abertura da tabela"

		EndIf
		
	EndIf

Else

	// Desbloqueia o Lock
	MA215UnLock(cEmpAnt)

EndIf	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑ?
ฑฑณFunao    ณMA215Lock   ?Autor ?TOTVS S/A           ?Data ?20.01.14 ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณDescri…o ?Bloqueio de Empresas para o processamento da rotina        ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณParametros?ExpC1 = Codigo da Empresa                                  ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑ?Uso      ?MATA215                                                    ณฑ?
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿?
*/
Static Function MA215Lock(cEmpresa)
Local lRet       := .T.
Local nTentativa := 0

nTentativa := 0
// Trava arquivo para somente este usuario utilizar rotina
While !LockByName("MT215"+AllTrim(cEmpresa),.T.,.F.) .And. nTentativa <= 50
	nTentativa++
	Sleep(100)
End

// Tenta travar somente 50 vezes, e se nao conseguir coloca na lista de filiais com concorrencia
If nTentativa > 50
	If !IsBlind()
		Aviso(STR0015,STR0016+cEmpresa,{"Ok"},2) // ##"Concorr๊ncia"##"A empresa corrente j?esta sendo utilizadas no processo de refaz acumulados: "
	EndIf	
	lRet := .F. 
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑ?
ฑฑณFun…o    ณMA215UnLock ?Autor ?TOTVS S/A           ?Data ?20.01.14 ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณDescri…o ?Desbloqueio de Empresa                                     ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑณParametros?ExpC1 = Codigo da Empresa                                  ณฑ?
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑ?
ฑฑ?Uso      ?MATA215                                                    ณฑ?
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑ?
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ?
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿?
*/
Static Function MA215UnLock(cEmpresa)

// Destrava o bloqueio de filiais
UnLockByName("MT215"+AllTrim(cEmpresa),.T.,.F.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  09/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function IsProd(cProduto,cLocal)
                                
Default cLocal:=""
If AllTrim(cProduto)='0501010003732' //.And. cLocal ='01'
	//If !MsgYesNo("Produto:"+cProduto+" Local "+cLocal+":"+StrZero(ProcLine(1),5 )  )
     //	x:=msdate()+{}
//   EndIf	
EndIf	

//x:=""


Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  09/22/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xDifSc6()
rpcsetenv("01","03")                        

cQuery:=" SELECT DISTINCT SC6.C6_FILIAL,  SC6.C6_NUM"
cQuery+=" FROM SC6010 SC6,
cQuery+=" SB1010 SB1
cQuery+=" WHERE SC6.C6_FILIAL='03'
cQuery+=" AND SC6.C6_BLQ <> 'S '
cQuery+=" AND SC6.C6_BLQ <> 'R '
cQuery+=" AND (SC6.C6_QTDVEN > SC6.C6_QTDENT       OR (SC6.C6_QTDVEN <= SC6.C6_QTDENT          AND SC6.C6_ENTREG>='20140822'))
cQuery+=" AND SC6.D_E_L_E_T_=' '
cQuery+="   AND SB1.B1_FILIAL='  '
cQuery+=" AND SB1.B1_COD=SC6.C6_PRODUTO
cQuery+=" AND SB1.D_E_L_E_T_=' '  
//cQuery+=" AND C6_LOCAL='01'
cQuery+=" ORDER BY C6_FILIAL, C6_NUM
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"SC6OLD"  ,.F.,.T.)    

Do While !SC6OLD->(Eof())
                   
	
	If !SC5->(MsSeek(SC6OLD->(C6_FILIAL+C6_NUM) ) )
		SC6->(DbSeek(SC6OLD->(C6_FILIAL+C6_NUM) ))
		Do While sc6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==SC6OLD->(C6_FILIAL+C6_NUM)
			SC6->(RecLock("SC6",.F.))	
			SC6->(DbDelete())
			SC6->(MsUnLock())
			SC6->(DbSkip())		
		EndDo
	EndIf	


	SC6OLD->(DbSkip())
EndDo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  09/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function BloqProd()
Local aProdBlq:={}
Local cFilSB1
Local nInd          

RpcSetEnv("01","03")

If !MsgYesNo("Deseja bloquear os produtos nใo encontrados no inventario WMS?")
	Return
EndIf


AADD(aProdBlq,{'01031341224','PRO EVOLUTION SOCCER 2013 X360 KON'})
AADD(aProdBlq,{'0405090024401','UNCHARTED ULTIMATE COMBO PACK PS3 SON'})
AADD(aProdBlq,{'01121441545','ASSASSINดS CREED 3 (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01121341545','ASSASSINดS CREED 3 (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01031441521','ZONE OF THE ENDERS HD COLLECTION PS3 KON'})
AADD(aProdBlq,{'01031341520','ZONE OF THE ENDERS HD COLLECTION X360 KON'})
AADD(aProdBlq,{'01011441191','TRUTH OR LIES (EUR) PS3 THQ'})
AADD(aProdBlq,{'0206270105201','PS VITA CARD HOLDER (LATAM) PSV SON'})
AADD(aProdBlq,{'01211541522','ZUMBA FITNESS CORE WII MAJ'})
AADD(aProdBlq,{'01991441215','RISEN 2: DARK WATERS PS3 DEE'})
AADD(aProdBlq,{'01121441555','ROCKSMITH WITH BASS PS3 UBI'})
AADD(aProdBlq,{'01121341555','ROCKSMITH WITH BASS X360 UBI'})
AADD(aProdBlq,{'0292250091701','UNIVERSAL CHARGER REVOLUTION LEV'})
AADD(aProdBlq,{'01142341377','STREET FIGHTER X TEKKEN PSV CAP'})
AADD(aProdBlq,{'01122341228','ASSASSINดS CREED 3: LIBERATION PSV UBI'})
AADD(aProdBlq,{'01011341530','UFC UNDISPUTED 2009 CLASSIC (EUR) X360 THQ'})
AADD(aProdBlq,{'01031441224','PRO EVOLUTION SOCCER 2013 PS3 KON'})
AADD(aProdBlq,{'01030141224','PRO EVOLUTION SOCCER 2013 PS2 KON'})
AADD(aProdBlq,{'01031241224','PRO EVOLUTION SOCCER 2013 PSP KON'})
AADD(aProdBlq,{'01032241224','PRO EVOLUTION SOCCER 2013 3DS KON'})
AADD(aProdBlq,{'0418010024701','GUITAR HERO 5 (COM GUITARRA) PS2 ACT'})
AADD(aProdBlq,{'0292250091401','STORAGE TOWER BLADE LEV'})
AADD(aProdBlq,{'0292250091501','EDGE STORAGE TOWER LEV'})
AADD(aProdBlq,{'01021441466','DEAD OR ALIVE 5 PS3 TCM'})
AADD(aProdBlq,{'0292250091601','GAME/DVD STORAGE TOWER EVOLUTION LEV'})
AADD(aProdBlq,{'01151441336','CALL OF DUTY: BLACK OPS 2 PS3 ACT'})
AADD(aProdBlq,{'01121348953','RAYMAN LEGENDS SIGNATURE EDITION (VERSรO EM PORTUGUสS) UBI X360'})
AADD(aProdBlq,{'01031448941','METAL GEAR SOLID: THE LEGACY COLLECTION PS3 KON'})
AADD(aProdBlq,{'01141348963','DRAGON`S DOGMA (EUA) X360 CAP'})
AADD(aProdBlq,{'01151341660','CALL OF DUTY: BLACK OPS 2 (PORTUGUสS) X360 ACT'})
AADD(aProdBlq,{'01121447823','TOM CLANCY`S GHOST RECON ANTHOLOGY (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01011441705','DARKSIDERS II LIMITED EDITION (UK) PS3 THQ'})
AADD(aProdBlq,{'01041441697','CLASH OF THE TITANS PS3 NAM'})
AADD(aProdBlq,{'01871341712','SNIPER: GHOST WARRIOR 2 LIMITED EDITION X360 CIT'})
AADD(aProdBlq,{'01871441712','SNIPER: GHOST WARRIOR 2 LIMITED EDITION PS3 CI'})
AADD(aProdBlq,{'01061441687','TRI-PLAY AVENTURA  PS3 SONY'})
AADD(aProdBlq,{'01781441683','HEAVY FIRE SHATTERED SPEAR PS3 MAS'})
AADD(aProdBlq,{'01122441633','MARVEL AVENGERS: BATTLE FOR EARTH WIIU UBI'})
AADD(aProdBlq,{'01102441341','DISNEY EPIC MICKEY: POWER OF TWO DIS WII U'})
AADD(aProdBlq,{'01061441078','GRAN TURISMO 5 PLATINUM (ESP) PS3 SON'})
AADD(aProdBlq,{'01061441133','RIDGE RACER 7 (EUR) PS3 NAM'})
AADD(aProdBlq,{'0245150092201','STREET FIGHTER IV FIGHT STICK TOURNAMENT EDITION MAD'})
AADD(aProdBlq,{'0245140092001','WIRELESS FFB RACING WHEEL MAD'})
AADD(aProdBlq,{'01222241088','MADAGASCAR 3: THE GAME 3DS D3'})
AADD(aProdBlq,{'01311441100','DEUS EX HUMAM REVOLUTION (EUR) PS3 SQU'})
AADD(aProdBlq,{'01201341207','LONDON 2012 OLYMPICS X360 SEG'})
AADD(aProdBlq,{'0254250091101','PS3 MOVE HANDGUN'})
AADD(aProdBlq,{'01071102869','NINTENDOGS DALMATIAN AND FRIENDS NDS NIN'})
AADD(aProdBlq,{'01361341001',' CARNIVAL GAMES IN ACTION X360 2K (EUR)'})
AADD(aProdBlq,{'01141340984','DARK VOID X360 CAP (EUR)'})
AADD(aProdBlq,{'01141341003','BIONIC COMMANDO X360 CAP (UK)'})
AADD(aProdBlq,{'01871441039','SNIPER: GHOST WARRIOR PS3 CITY'})
AADD(aProdBlq,{'01061441221','UNCHARTED 3: DRAKES DECEPTION (LATAM) PS3 SON'})
AADD(aProdBlq,{'01171341033','THE DARKNESS II X360 T2'})
AADD(aProdBlq,{'01271341656','THE WALKING DEAD X360 TEL'})
AADD(aProdBlq,{'01121341538','ASSASSINดS CREED 3 SIGNATURE EDITION (VERSAO EM PORTUGUES) X360 UBI'})
AADD(aProdBlq,{'01211341025','ZUMBA FITNESS RUSH X360 MAJ'})
AADD(aProdBlq,{'01062341026','WIPEOUT 2048 (EUR) PSV SON'})
AADD(aProdBlq,{'01151441043','PROTOTYPE 2 PS3 ACT'})
AADD(aProdBlq,{'01141340983','BIONIC COMMANDO X360 CAP (EUR)'})
AADD(aProdBlq,{'01071541163','FLINGSMASH (BUNDLE) WII NIN'})
AADD(aProdBlq,{'01071140847','POKษMON MYSTERY DUNGEON: EXPLORERS OF SKY DS NIN'})
AADD(aProdBlq,{'01081340873','PROJECT GOTHAM RACING (EUR) X360 MIC'})
AADD(aProdBlq,{'01121340862','TOM CLANCYดS END WAR X360 (EUR) UBI'})
AADD(aProdBlq,{'01202340925','SUPER MONKEY BALL BANANA SPLITZ PSV SEG'})
AADD(aProdBlq,{'01051440966','BATTLEFIELD 3 (UK) PS3 EA'})
AADD(aProdBlq,{'01151441557','GUITAR HERO III: LEGENDS OF ROCK PS3 ACT'})
AADD(aProdBlq,{'01010500632','SCOOBY DOO AND THE CYBER PSX THQ'})
AADD(aProdBlq,{'01151441560','GUITAR HERO: WARRIORS OF ROCK PS3 ACT'})
AADD(aProdBlq,{'01151341557','GUITAR HERO III: LEGENDS OF ROCK X360 ACT'})
AADD(aProdBlq,{'01150141557','GUITAR HERO III: LEGENDS OF ROCK PS2 ACT'})
AADD(aProdBlq,{'01010103389','WWE SMACKDOWN VS. RAW 2010 PS2 THQ'})
AADD(aProdBlq,{'01051340896','MASS EFFECT 3  X360 EA'})
AADD(aProdBlq,{'01011340859','RIO X360 (ESP) THQ'})
AADD(aProdBlq,{'01010101618','RATATOUILLE PS2 THQ'})
AADD(aProdBlq,{'01121540815','THE BLACK EYED PEAS EXPERIENCE LIMITED EDITION WII UBI'})
AADD(aProdBlq,{'0260160076801','SOFT SPORTS KIT  WII DG'})
AADD(aProdBlq,{'0287130074101',' PROTECTIVE GLOVE  PSP  PDP'})
AADD(aProdBlq,{'0281160076701','SPORTS PACK 8 IN 1 WII CTA'})
AADD(aProdBlq,{'01121441550','JUST DANCE 4 (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01121341550','JUST DANCE 4 (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'0253160076601','SPORTS RESORT BUNDLE WII GAMEON'})
AADD(aProdBlq,{'01121541550','JUST DANCE 4 (VERSรO EM PORTUGUสS) WII UBI'})
AADD(aProdBlq,{'0297120077201','SCREEN PROTECTOR XL NDS EAGLE'})
AADD(aProdBlq,{'01121341551','THE HIP HOP DANCE EXPERIENCE X360 UBI'})
AADD(aProdBlq,{'0287160077501','REMOTE MOTION SENSING CONTROLLER NERF WII PDP'})
AADD(aProdBlq,{'0298170073401','ADAPTADOR DUPLO PLAYSTATION- PC VTREX'})
AADD(aProdBlq,{'0281160073201','AEROBIC STEP WII  CTA'})
AADD(aProdBlq,{'0298010073301','ADAPTADOR USB DUPLO PARA CONTROLE DE PLAYSTATION 2 PS2  VTREX'})
AADD(aProdBlq,{'0287150074901','VERSUS FIGHTING PAD  PS3 PDP'})
AADD(aProdBlq,{'01030101459','WINNING ELEVEN PES 2007 PS2 KON'})
AADD(aProdBlq,{'01030101955','PRO EVOLUTION SOCCER 2008 PS2 KON'})
AADD(aProdBlq,{'01030102329','PRO EVOLUTION SOCCER 2009 PS2 KON'})
AADD(aProdBlq,{'01030103288','PRO EVOLUTION SOCCER 2010 PS2 KON'})
AADD(aProdBlq,{'01030103775','PRO EVOLUTION SOCCER 2011 PS2 KON'})
AADD(aProdBlq,{'01031101459','WINNING ELEVEN PES 2007 NDS KON'})
AADD(aProdBlq,{'01031201041','TWISTED METAL: HEAD ON PSP SON'})
AADD(aProdBlq,{'01030100936','METAL GEAR SOLID 3: SNAKE EATER PS2 KON'})
AADD(aProdBlq,{'01030101119','CASTLEVANIA C OF DARKNESS PS2 KON'})
AADD(aProdBlq,{'01011301771','CLIVE BARKERดS JERICHO X360 COD'})
AADD(aProdBlq,{'01011302475','DESTROY ALL HUMANS! PATH OF THE FURON X360 THQ'})
AADD(aProdBlq,{'01011302581','SAINTS ROW 2: PLATINUM HITS X360 THQ'})
AADD(aProdBlq,{'01011303537','UFC UNDISPUTED 2010 X360 THQ'})
AADD(aProdBlq,{'01011401837','MX VS ATV UNTAMED PS3 THQ'})
AADD(aProdBlq,{'01011501837','MX VS ATV UNTAMED WII THQ'})
AADD(aProdBlq,{'01011402095','WALL-E PS3 THQ'})
AADD(aProdBlq,{'01011402581','SAINTS ROW 2: GREATEST HITS PS3 THQ'})
AADD(aProdBlq,{'01011503712','WWE SMACKDOWN VS. RAW 2011 WII THQ'})
AADD(aProdBlq,{'01011402846','RED FACTION: GUERRILLA PS3 THQ'})
AADD(aProdBlq,{'01011502515','AVATAR: THE LAST AIRBENDER INTO THE INFERNO WII THQ'})
AADD(aProdBlq,{'01011601675','TWO WORLDS EPIC EDITION PC STPK'})
AADD(aProdBlq,{'01011403143','CARS RACE O RAMA PS3 THQ'})
AADD(aProdBlq,{'01011403338','DARKSIDERS PS3 THQ'})
AADD(aProdBlq,{'01011703591','SPONGEBOB BOATING BASH DSI THQ'})
AADD(aProdBlq,{'01011403537','UFC UNDISPUTED 2010 PS3 THQ'})
AADD(aProdBlq,{'01011503143','CARS: RACE-O-RAMA WII THQ'})
AADD(aProdBlq,{'01011501163','DESTROY ALL HUMANS! BIG WILLY UNLEASHED WII THQ'})
AADD(aProdBlq,{'01011103769','MEGAMIND - THE BLUE DEFENDER DS THQ'})
AADD(aProdBlq,{'01011203235','MARVEL SUPER HERO SQUAD PSP THQ'})
AADD(aProdBlq,{'01011203389','WWE SMACKDOWN VS. RAW 2010 PSP THQ'})
AADD(aProdBlq,{'01011201467','JUICED: ELIMINATOR PSP THQ'})
AADD(aProdBlq,{'01041203211','NARUTO SHIPPUDEN: LEGENDS: AKATSUKI RISING PSP NAM'})
AADD(aProdBlq,{'01041203236','TEKKEN 6 PSP NAM'})
AADD(aProdBlq,{'01041303236','TEKKEN 6 X360 NAM'})
AADD(aProdBlq,{'01041502173','WE CHEER WII NAM'})
AADD(aProdBlq,{'01041502364','TALES OF SYMPHONIA: DAWN OF THE NEW WORLD WII NAM'})
AADD(aProdBlq,{'01041502888','THE MUNCHABLES WII NAM'})
AADD(aProdBlq,{'01050100097','HARRY POTTER QUIDDITCH WO PS2 EA'})
AADD(aProdBlq,{'01050100099','HARRY POTTER AND THE CHAMBER OF SECRETS PS2 EA'})
AADD(aProdBlq,{'01050100125','THE LORD OF THE RINGS: THE RETURN OF THE KING PS2 EA'})
AADD(aProdBlq,{'01050100152','NEED FOR SPEED UNDERGROUN PS2 EA'})
AADD(aProdBlq,{'01050101066','F1 CHAMPIONSHIP SEASON 2000 PS2 EA'})
AADD(aProdBlq,{'01050101784','THE SIMPSONS PS2 EA'})
AADD(aProdBlq,{'01050100233','THE SIMS PS2 EA'})
AADD(aProdBlq,{'01050101083','BLACK PS2 EA'})
AADD(aProdBlq,{'01050101949','ROCK BAND BUNDLE PS2 EA'})
AADD(aProdBlq,{'01050101101','FIFA STREET 2 PS2 EA'})
AADD(aProdBlq,{'01050101193','FIFA SOCCER 2007 PS2 EA'})
AADD(aProdBlq,{'01050100926','THE LORD OF THE RINGS: THE THIRD AGE PS2 EA'})
AADD(aProdBlq,{'01050101304','FIGHT NIGHT ROUND 3 PS2 EA'})
AADD(aProdBlq,{'01050101595','HARRY POTTER ORDER OF PHOENIX PS2 EA'})
AADD(aProdBlq,{'01050103146','FIFA SOCCER 2010 PS2 EA'})
AADD(aProdBlq,{'01041403236','TEKKEN 6 PS3 NAM'})
AADD(aProdBlq,{'01041403270','DRAGON BALL: RAGING BLAST 2 PS3 NAM'})
AADD(aProdBlq,{'01041201310','ACE COMBAT X PSP NAM'})
AADD(aProdBlq,{'01041303679','NARUTO SHIPPUDEN: ULTIMATE NINJA STORM 2 X360 NAM'})
AADD(aProdBlq,{'01041303703','ENSLAVED: ODYSSEY TO THE WEST X360 NAM'})
AADD(aProdBlq,{'01041403475','DEAD TO RIGHTS: RETRIBUTION PS3 NAM'})
AADD(aProdBlq,{'01041302119','SOULCALIBUR IV X360 NAM'})
AADD(aProdBlq,{'01041403703','ENSLAVED: ODYSSEY TO THE WEST PS3 NAM'})
AADD(aProdBlq,{'01041403710','SPLATTERHOUSE PS3 NAM'})
AADD(aProdBlq,{'01041201700','TEKKEN: DARK RESURRECTION PSP NAM'})
AADD(aProdBlq,{'01041203062','SOULCALIBUR: BROKEN DESTINY  PSP  NAM'})
AADD(aProdBlq,{'01041402338','NARUTO: ULTIMATE NINJA STORM PS3 NAM'})
AADD(aProdBlq,{'01031303775','PRO EVOLUTION SOCCER 2011 X360 KON'})
AADD(aProdBlq,{'01031403775','PRO EVOLUTION SOCCER 2011 PS3 KON'})
AADD(aProdBlq,{'01031503288','PRO EVOLUTION SOCCER 2010 WII KON'})
AADD(aProdBlq,{'01031503775','PRO EVOLUTION SOCCER 2011 WII KON'})
AADD(aProdBlq,{'01031601955','PRO EVOLUTION SOCCER 2008 PC KON'})
AADD(aProdBlq,{'01031603288','PRO EVOLUTION SOCCER 2010 PC KON'})
AADD(aProdBlq,{'01031603775','PRO EVOLUTION SOCCER 2011 PC KON'})
AADD(aProdBlq,{'01122341548','ASSASSINดS CREED 3: LIBERATION (VERSรO EM PORTUGUสS) PSV UBI'})
AADD(aProdBlq,{'01040101608','NARUTO: ULTIMATE NINJA 2 PS2 NAM'})
AADD(aProdBlq,{'01040200206','SOUL CALIBUR 2 GC NAM'})
AADD(aProdBlq,{'01031301955','PRO EVOLUTION SOCCER 2008 X360 KON'})
AADD(aProdBlq,{'01031401858','PRO EVOLUTION SOCCER 2008 EURO PS3 KON'})
AADD(aProdBlq,{'01031401955','PRO EVOLUTION SOCCER 2008 PS3 KON'})
AADD(aProdBlq,{'01031201955','PRO EVOLUTION SOCCER 2008 PSP KON'})
AADD(aProdBlq,{'01031302329','PRO EVOLUTION SOCCER 2009 X360 KON'})
AADD(aProdBlq,{'01031402084','METAL GEAR SOLID 4: GUNS OF THE PATRIOTS PS3 KON'})
AADD(aProdBlq,{'01031202329','PRO EVOLUTION SOCCER 2009 PSP KON'})
AADD(aProdBlq,{'01031402329','PRO EVOLUTION SOCCER 2009 PS3 KON'})
AADD(aProdBlq,{'01031203288','PRO EVOLUTION SOCCER 2010 PSP KON'})
AADD(aProdBlq,{'01031303288','PRO EVOLUTION SOCCER 2010 X360 KON'})
AADD(aProdBlq,{'01031403288','PRO EVOLUTION SOCCER 2010 PS3 KON'})
AADD(aProdBlq,{'01031203775','PRO EVOLUTION SOCCER 2011 PSP KON'})
AADD(aProdBlq,{'01051201595','HARRY POTTER AND THE ORDER OF THE PHOENIX PSP EA'})
AADD(aProdBlq,{'01051201756','FIFA 2008 PSP EA'})
AADD(aProdBlq,{'01051202927','HARRY POTTER AND THE HALF-BLOOD PRINCE PSP EA'})
AADD(aProdBlq,{'01051203058','NEED FOR SPEED SHIFT PSP EA'})
AADD(aProdBlq,{'01051203146','FIFA SOCCER 10 PSP EA'})
AADD(aProdBlq,{'01051203440','DANTEดS INFERNO PSP EA'})
AADD(aProdBlq,{'01051203796','FIFA SOCCER 11 PSP EA'})
AADD(aProdBlq,{'01051300866','GREEN DAY: ROCK BAND X360 EA'})
AADD(aProdBlq,{'01051301929','ROCK BAND X360 EA'})
AADD(aProdBlq,{'01051301949','ROCK BAND (BUNDLE) X360 EA'})
AADD(aProdBlq,{'01051302929','FIGHT NIGHT ROUND 4 X360 EA'})
AADD(aProdBlq,{'01051302964','G.I. JOE: THE RISE OF COBRA X360 EA'})
AADD(aProdBlq,{'01051301969','FIFA STREET 3 X360 EA'})
AADD(aProdBlq,{'01051303146','FIFA SOCCER 10 X360 EA'})
AADD(aProdBlq,{'01051303187','DRAGON AGE: ORIGINS X360 EA'})
AADD(aProdBlq,{'01051302128','MADDEN NFL 09 X360 EA'})
AADD(aProdBlq,{'01051302142','MERCENARIES 2: WORLD IN FLAMES X360 EA'})
AADD(aProdBlq,{'01051302218','ROCK BAND 2 X360 MTV'})
AADD(aProdBlq,{'01051302307','FIFA 09 X360 EA'})
AADD(aProdBlq,{'01051303511','MASS EFFECT 2 X360 EA'})
AADD(aProdBlq,{'01051303515','BATTLEFIELD: BAD COMPANY 2 X360 EA'})
AADD(aProdBlq,{'01051303539','2010 FIFA WORLD CUP SOUTH AFRICA X360 EA'})
AADD(aProdBlq,{'01051303548','EA SPORTS MMA X360 EA'})
AADD(aProdBlq,{'01051303557','MEDAL OF HONOR X360 EA'})
AADD(aProdBlq,{'01051103810','HARRY POTTER AND THE DEATHLY HALLOWS – PART 1: THE VIDEOGAME DS EA'})
AADD(aProdBlq,{'01121341556','FAR CRY 3 SIGNATURE EDITION (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01050401046','HARRY POTTER G OF FIRE XB EA'})
AADD(aProdBlq,{'01050200004','007 NIGHTFIRE GC EA'})
AADD(aProdBlq,{'01050200099','HARRY POTTER CHAMBER SECR GC EA'})
AADD(aProdBlq,{'01050200296','FIFA SOCCER 2003 GC EA'})
AADD(aProdBlq,{'01061202707','LOCOROCO 2 PSP SON'})
AADD(aProdBlq,{'01061202788','NBA 09: THE INSIDE PSP SON'})
AADD(aProdBlq,{'01061202862','RESISTANCE RETRIBUTION PSP SON'})
AADD(aProdBlq,{'01061203195','GRAN TURISMO PSP SON'})
AADD(aProdBlq,{'01121441553','FAR CRY 3 (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01121341553','FAR CRY 3 (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01061401148','UNTOLD LEGENDS: DARK KINGDOM PS3 SON'})
AADD(aProdBlq,{'01061403424','GOD OF WAR III PS3 SON'})
AADD(aProdBlq,{'01061401528','MOTORSTORM PS3 SON'})
AADD(aProdBlq,{'01061403516','WHITE KNIGHT CHRONICLES: INTERNATIONAL EDITION PS3 SON'})
AADD(aProdBlq,{'01121541554','JUST DANCE DISNEY PARTY (VERSรO EM PORTUGUสS) WII UBI'})
AADD(aProdBlq,{'01061403812','EYEPET PS3 SON'})
AADD(aProdBlq,{'01070200350','SUPER SMASH BROTHERS GC NIN'})
AADD(aProdBlq,{'01061401782','RATCHET & CLANK FUTURE: TOOLS OF DESTRUCTION PS3 SON'})
AADD(aProdBlq,{'01061403834','GRAN TURISMO 5 PS3 SON'})
AADD(aProdBlq,{'01061401848','UNCHARTED: DRAKEดS FORTUNE PS3 SON'})
AADD(aProdBlq,{'01061402039','GRAN TURISMO 5: PROLOGUE PS3 SON'})
AADD(aProdBlq,{'01061403841','THE SLY COLLECTION PS3 SON'})
AADD(aProdBlq,{'01070200816','DONKEY KONGA C/ BONGO GC NIN'})
AADD(aProdBlq,{'01061402301','LITTLEBIGPLANET PS3 SON'})
AADD(aProdBlq,{'01061402434','RESISTANCE 2 PS3 SON'})
AADD(aProdBlq,{'01061403017','SINGSTAR QUEEN PS3 SON'})
AADD(aProdBlq,{'01061403240','UNCHARTED 2: AMONG THIEVES PS3 SON'})
AADD(aProdBlq,{'01061403362','RATCHET & CLANK FUTURE: A CRACK IN TIME  PS3 SON'})
AADD(aProdBlq,{'01061403411','GOD OF WAR COLLECTION PS3 SON'})
AADD(aProdBlq,{'01070200313','MARIO PARTY 4 GC NIN'})
AADD(aProdBlq,{'01060101311','SYPHON FILTER: DARK MIRROR PS2 SON'})
AADD(aProdBlq,{'01060101346','SOCOM: U.S. NAVY SEALS COMBINED ASSAULT PS2 SON'})
AADD(aProdBlq,{'01060101493','GOD OF WAR II PS2 SON'})
AADD(aProdBlq,{'01060101671','ATV OFFROAD FURY 4 PS2 SON'})
AADD(aProdBlq,{'01061201025','WIPEOUT PURE PSP SON'})
AADD(aProdBlq,{'01060103465','NEOPETS DARKEST FAERIE PS2 SON'})
AADD(aProdBlq,{'01060101932','RATCHET & CLANK PS2 SON'})
AADD(aProdBlq,{'01051403171','BRUTAL LEGEND PS3 EA'})
AADD(aProdBlq,{'01051403796','FIFA SOCCER 11 PS3 EA'})
AADD(aProdBlq,{'01051501595','HARRY POTTER ORDER OF PHOENIX WII EA'})
AADD(aProdBlq,{'01051503539','2010 FIFA WORLD CUP SOUTH AFRICA WII EA'})
AADD(aProdBlq,{'01060100203','SOCOM II: U.S. NAVY SEALS PS2 SON'})
AADD(aProdBlq,{'01060100204','SOCOM: U.S. NAVY SEALS PS2 SON'})
AADD(aProdBlq,{'01051503796','FIFA SOCCER 11 WII EA'})
AADD(aProdBlq,{'01051502718','SIMANIMALS WII EA'})
AADD(aProdBlq,{'01051503803','ROCK BAND 3 WII EA'})
AADD(aProdBlq,{'01060100844','SLY 2: BAND OF THIEVES PS2 SON'})
AADD(aProdBlq,{'01060100937','JAK 3 PS2 SON'})
AADD(aProdBlq,{'01060100067','EVERQUEST ONLINE ADVENTUR PS2 SON'})
AADD(aProdBlq,{'01060101019','GOD OF WAR PS2 SON'})
AADD(aProdBlq,{'01060100109','JAK II PS2 SON'})
AADD(aProdBlq,{'01060101146','SOCOM 3: U.S. NAVY SEALS PS2 SON'})
AADD(aProdBlq,{'01060101156','SLY 3: HONOR AMONG THIEVES PS2 SON'})
AADD(aProdBlq,{'01060101092','SHADOW OF THE COLOSSUS PS2 SON'})
AADD(aProdBlq,{'01060100198','SLY COOPER AND THE THIEVIUS RACOONUS PS2 SON'})
AADD(aProdBlq,{'01060101202','JAK X: COMBAT RACING PS2 SON'})
AADD(aProdBlq,{'01051503341','EA SPORTS ACTIVE: MORE WORKOUTS WII EA'})
AADD(aProdBlq,{'01051503348','NEED FOR SPEED: NITRO WII EA'})
AADD(aProdBlq,{'01051401929','ROCK BAND PS3 EA'})
AADD(aProdBlq,{'01051401949','ROCK BAND (BUNDLE) PS3 EA'})
AADD(aProdBlq,{'01051403438','ARMY OF TWO: THE 40TH DAY PS3 EA'})
AADD(aProdBlq,{'01051403464','NCAA MARCH MADNESS 08 PS3 EA'})
AADD(aProdBlq,{'01051403515','BATTLEFIELD: BAD COMPANY 2 PS3 EA'})
AADD(aProdBlq,{'01051403539','2010 FIFA WORLD CUP SOUTH AFRICA PS3 EA'})
AADD(aProdBlq,{'01051402142','MERCENARIES 2: WORLD IN FLAMES PS3 EA'})
AADD(aProdBlq,{'01051402151','FACEBREAKER PS3 EA'})
AADD(aProdBlq,{'01051403024','MADDEN NFL 10 PS3  EA'})
AADD(aProdBlq,{'01051403546','DEAD SPACE 2 PS3 EA'})
AADD(aProdBlq,{'01051403058','NEED FOR SPEED SHIFT PS3 EA'})
AADD(aProdBlq,{'01051403146','FIFA SOCCER 10 PS3 EA'})
AADD(aProdBlq,{'01051403564','SKATE 3  PS3 EA'})
AADD(aProdBlq,{'01051401756','FIFA 2008 PS3 EA'})
AADD(aProdBlq,{'01081303121','BLUE DRAGON X360 MIC'})
AADD(aProdBlq,{'01081303124','FUZION FRENZY 2 X360 MIC'})
AADD(aProdBlq,{'01081303125','KAMEO: ELEMENTS OF POWER X360 MIC'})
AADD(aProdBlq,{'01081303127','NINETY-NINE NIGHTS X360 MIC'})
AADD(aProdBlq,{'01081303130','TENCHU Z X360 MIC'})
AADD(aProdBlq,{'01100101571','PIRATES OF THE CARIBBEAN: AT WORLDดS END PS2 DIS'})
AADD(aProdBlq,{'01100101639','HIGH SCHOOL MUSICAL: SING IT! (BUNDLE) PS2 DIS'})
AADD(aProdBlq,{'01100102062','THE CHRONICLES OF NARNIA: PRINCE CASPIAN PS2 DIS'})
AADD(aProdBlq,{'01100102260','DISNEY SING IT PS2 DIS'})
AADD(aProdBlq,{'01071502267','WII MUSIC WII NIN'})
AADD(aProdBlq,{'01071503407','NEW SUPER MARIO BROS. WII WII NIN'})
AADD(aProdBlq,{'01071501575','MARIO PARTY 8 WII NIN'})
AADD(aProdBlq,{'01071502366','METROID: OTHER M WII NIN'})
AADD(aProdBlq,{'01071502428','ANIMAL CROSSING: CITY FOLK WII NIN'})
AADD(aProdBlq,{'01071503605','SUPER MARIO GALAXY 2 WII NIN'})
AADD(aProdBlq,{'01071503657','SIN AND PUNISHMENT: STAR SUCCESSOR WII NIN'})
AADD(aProdBlq,{'01071503811','KIRBYดS EPIC YARN WII NIN'})
AADD(aProdBlq,{'01071501624','MARIO STRIKERS CHARGED WII NIN'})
AADD(aProdBlq,{'01071503831','DONKEY KONG COUNTRY RETURNS WII NIN'})
AADD(aProdBlq,{'01071501852','SUPER MARIO GALAXY WII NIN'})
AADD(aProdBlq,{'01071502750','NEW PLAY CONTROL! MARIO POWER TENNIS WII NIN'})
AADD(aProdBlq,{'01071502013','SUPER SMASH BROS. BRAWL WII NIN'})
AADD(aProdBlq,{'01071502916','EXCITEBOTS: TRICK RACING WII NIN'})
AADD(aProdBlq,{'01071102666','MYSTERY CASES FILES: MILLIONHEIR NDS NIN'})
AADD(aProdBlq,{'01071101547','POKEMON PEARL NDS NIN'})
AADD(aProdBlq,{'01071103032','FOSSIL FIGHTERS NDS  NIN'})
AADD(aProdBlq,{'01071101124','BRAIN AGE NDS NIN'})
AADD(aProdBlq,{'01071103088','MARIO & LUIGI BOWSERS INSIDE STORY NDS NIN'})
AADD(aProdBlq,{'01071103409','STYLE SAVVY NDS NIN'})
AADD(aProdBlq,{'01071101727','THE LEGEND OF ZELDA PHANTON HOURGLASS NDS NIN'})
AADD(aProdBlq,{'01071102041','POKEMON MYSTERY DUNGEON EXPLORERS OF TIME NDS NIN'})
AADD(aProdBlq,{'01071501143','BIG BRAIN AGE  ACADEMY WII DEGREE WII NIN'})
AADD(aProdBlq,{'01071501360','THE LEGEND OF ZELDA: TWILIGHT PRINCESS WII NIN'})
AADD(aProdBlq,{'01070300384','DONKEY KONG CONTRY GBA NIN (JG)'})
AADD(aProdBlq,{'01111402081','DRAGON BALL Z: BURST LIMIT PS3 ATA'})
AADD(aProdBlq,{'01111402397','ALONE IN THE DARK INFERNO PS3 ATA'})
AADD(aProdBlq,{'01120101525','TMNT PS2 UBI'})
AADD(aProdBlq,{'01120102569','NITROBIKE PS2 UBI'})
AADD(aProdBlq,{'01120103065','TEENAGE MUTANT NINJA TURTLES: SMASH-UP  PS2  UBI'})
AADD(aProdBlq,{'01120200214','SPLINTER CELL PANDORA TOM GC UBI'})
AADD(aProdBlq,{'01121101812','ASSASSINดS CREED NDS UBI'})
AADD(aProdBlq,{'01111402833','THE CHRONICLES OF RIDDICK: ASSAULT ON DARK ATHENA PS3 ATA'})
AADD(aProdBlq,{'01110600724','METAL GEAR SOLID GB KON (JG)'})
AADD(aProdBlq,{'01111200967','DRAGON BALL Z: SHIN BUDOKAI PSP ATA'})
AADD(aProdBlq,{'01111201741','DRAGON BALL Z: SHIN BUDOKAI - ANOTHER ROAD PSP ATA'})
AADD(aProdBlq,{'01101502361','ULTIMATE BAND WII DIS'})
AADD(aProdBlq,{'01101502824','DISNEY SING IT HIGH SCHOOL 3 SENIOR YEAR WII DIS'})
AADD(aProdBlq,{'01101502965','G-FORCE WII DIS'})
AADD(aProdBlq,{'01101503324','HIGH SCHOOL MUSICAL: SING IT WII DIS'})
AADD(aProdBlq,{'01101503332','DISNEY THE PRINCESS AND THE FROG WII DIS'})
AADD(aProdBlq,{'01101503540','ALICE IN WONDERLAND WII DIS'})
AADD(aProdBlq,{'01101503607','TOY STORY 3: THE VIDEO GAME WII DIS'})
AADD(aProdBlq,{'01101503753','DISNEY SING IT: FAMILY HITS WII DIS'})
AADD(aProdBlq,{'01101503830','DISNEY EPIC MICKEY WII DIS'})
AADD(aProdBlq,{'01110101074','MATRIX PATH OF NEO PS2 ATA'})
AADD(aProdBlq,{'01110101211','SUPER DRAGON BALL Z PS2 ATA'})
AADD(aProdBlq,{'01110102001','MARC ECKO’S GETTING UP: CONTENTS UNDER PRESSURE LIMITED EDITION PS2 ATA'})
AADD(aProdBlq,{'01110102096','ALONE IN THE DARK PS2 ATA'})
AADD(aProdBlq,{'01101103750','CAMP ROCK: THE FINAL JAM DS DIS'})
AADD(aProdBlq,{'01101103774','PHINEAS AND FERB: RIDE AGAIN DS DIS'})
AADD(aProdBlq,{'01101403588','SPLIT/SECOND PS3 DIS'})
AADD(aProdBlq,{'01101302965','G-FORCE X360 DIS'})
AADD(aProdBlq,{'01101303588','SPLIT/SECOND X360 DIS'})
AADD(aProdBlq,{'01101403875','TRON: EVOLUTION PS3 DIS'})
AADD(aProdBlq,{'01101303875','TRON: EVOLUTION X360 DIS'})
AADD(aProdBlq,{'01101501639','HIGH SCHOOL MUSICAL: SING IT! (BUNDLE) WII DIS'})
AADD(aProdBlq,{'01121503279','JAMES CAMERONดS AVATAR: THE GAME WII UBI'})
AADD(aProdBlq,{'01121503799','JUST DANCE 2 WII UBI'})
AADD(aProdBlq,{'01121503835','JUST DANCE KIDS WII UBI'})
AADD(aProdBlq,{'01121503856','MICHAEL JACKSON: THE EXPERIENCE WII UBI'})
AADD(aProdBlq,{'01130101933','CRASH OF THE TITANS PS2 SIER'})
AADD(aProdBlq,{'01130102113','THE MUMMY: TOMB OF THE DRAGON EMPEROR PS2 ACT'})
AADD(aProdBlq,{'01130103448','L.A. RUSH PS2 MID'})
AADD(aProdBlq,{'01130103451','CORVETTE EVOLUTION GT PS2 VALC'})
AADD(aProdBlq,{'01121403561','PRINCE OF PERSIA: THE FORGOTTEN SANDS PS3 UBI'})
AADD(aProdBlq,{'01121402345','TOM CLANCYดS ENDWAR PS3 UBI'})
AADD(aProdBlq,{'01121403756','TOM CLANCYดS H.A.W.X. 2 PS3 UBI'})
AADD(aProdBlq,{'01121403808','ASSASSINดS CREED BROTHERHOOD PS3 UBI'})
AADD(aProdBlq,{'01121501278','SPLINTER CELL DOUBLE AGEN WII UBI'})
AADD(aProdBlq,{'01121501821','CRANIUM KABOOKII WII UBI'})
AADD(aProdBlq,{'01121403279','JAMES CAMERONดS AVATAR: THE GAME PS3 UBI'})
AADD(aProdBlq,{'01121103865','PETZ: CATZ PLAYGROUND DS UBI'})
AADD(aProdBlq,{'01121303262','ASSASSINดS CREED II X360 UBI'})
AADD(aProdBlq,{'01121303279','JAMES CAMERONดS AVATAR: THE GAME X360 UBI'})
AADD(aProdBlq,{'01121301559','ENCHANTED ARMS X360 UBI'})
AADD(aProdBlq,{'01121303433','TOM CLANCYดS SPLINTER CELL: CONVICTION X360 UBI'})
AADD(aProdBlq,{'01121201626','TOM CLANCYดS RAINBOW SIX VEGAS PSP UBI'})
AADD(aProdBlq,{'01121303561','PRINCE OF PERSIA: THE FORGOTTEN SANDS X360 UBI'})
AADD(aProdBlq,{'01121303604','PURE FUTBOL X360 UBI'})
AADD(aProdBlq,{'01121301812','ASSASSINดS CREED X360 UBI'})
AADD(aProdBlq,{'01121303808','ASSASSINดS CREED BROTHERHOOD X360 UBI'})
AADD(aProdBlq,{'01121302022','TOM CLANCYดS RAINBOW SIX VEGAS 2 X360 UBI'})
AADD(aProdBlq,{'01121303843','YOUR SHAPE: FITNESS EVOLVED X360 UBI'})
AADD(aProdBlq,{'01121203263','ASSASSINดS CREED: BLOODLINES PSP UBI'})
AADD(aProdBlq,{'01121203279','JAMES CAMERONดS AVATAR: THE GAME PSP UBI'})
AADD(aProdBlq,{'01121302345','TOM CLANCYดS ENDWAR X360 UBI'})
AADD(aProdBlq,{'01121203561','PRINCE OF PERSIA : THE FORGOTTEN SANDS PSP UBI'})
AADD(aProdBlq,{'01121401531','TOM CLANCYดS GHOST RECON ADVANCED WARFIGHTER 2 PS3 UBI'})
AADD(aProdBlq,{'01121401812','ASSASSINดS CREED PS3 UBI'})
AADD(aProdBlq,{'01121102360','RAYMAN RAVING RABBIDS TV NDS UBI'})
AADD(aProdBlq,{'01150101307','MARVEL: ULTIMATE ALLIANCE PS2 ACT'})
AADD(aProdBlq,{'01150102596','THE LEGEND OF SPYRO: DAWN OF THE DRAGON PS2 ACT'})
AADD(aProdBlq,{'01150102635','GUITAR HERO WORLD TOUR PS2 ACT'})
AADD(aProdBlq,{'01150102775','GUITAR HERO: METALLICA PS2 ACT'})
AADD(aProdBlq,{'01150102854','X-MEN ORIGINS: WOLVERINE PS2 ACT'})
AADD(aProdBlq,{'01150103043','GUITAR HERO 5 PS2 ACT'})
AADD(aProdBlq,{'01150103327','GUITAR HERO 3 PS2 ACT'})
AADD(aProdBlq,{'01150103412','BAND HERO PS2 ACT'})
AADD(aProdBlq,{'01150102067','KUNG FU PANDA PS2 ACT'})
AADD(aProdBlq,{'01150102100','GUITAR HERO: AEROSMITH PS2 ACT'})
AADD(aProdBlq,{'01150102331','QUANTUM OF SOLACE PS2 ACT'})
AADD(aProdBlq,{'01150100196','SHREK 2 PS2 ACT'})
AADD(aProdBlq,{'01150101773','GUITAR HERO III: LEGENDS OF ROCK (BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'01140200177','RESIDENTE EVIL CODE VERON GC CAP'})
AADD(aProdBlq,{'01140200978','RESIDENT EVIL 4 GC CAP'})
AADD(aProdBlq,{'01141401462','LOST PLANET: EXTREME CONDITION PS3 CAP'})
AADD(aProdBlq,{'01141402728','STREET FIGHTER IV PS3 CAP'})
AADD(aProdBlq,{'01141402731','RESIDENT EVIL 5 PS3 CAP'})
AADD(aProdBlq,{'01141201293','CAPCOM CLASSICS COLLECTION RELOADED PSP CAP'})
AADD(aProdBlq,{'01141403428','MOTOGP 09/10 PS3 CAP'})
AADD(aProdBlq,{'01141403525','RESIDENT EVIL 5: GOLD EDITION PS3 CAP'})
AADD(aProdBlq,{'01141403569','SUPER STREET FIGHTER IV  PS3 CAP'})
AADD(aProdBlq,{'01141302728','STREET FIGHTER IV X360 CAP'})
AADD(aProdBlq,{'01141501845','RESIDENT EVIL UMBRELLA CH WII CAP'})
AADD(aProdBlq,{'01141302731','RESIDENT EVIL 5 X360 CAP'})
AADD(aProdBlq,{'01141503335','RESIDENT EVIL: THE DARKSIDE CHRONICLES WII CAP'})
AADD(aProdBlq,{'01141303525','RESIDENT EVIL 5: GOLD EDITION X360 CAP'})
AADD(aProdBlq,{'01141303569','SUPER STREET FIGHTER IV  X360 CAP'})
AADD(aProdBlq,{'01140100978','RESIDENT EVIL 4 PS2 CAP'})
AADD(aProdBlq,{'01140100175','RESIDENTE EVIL OUTBREAK PS2 CAP'})
AADD(aProdBlq,{'01140100177','RESIDENTE EVIL CODE VERON PS2 CAP'})
AADD(aProdBlq,{'01131301957','THE SPIDERWICK CHRONICLES X360 ACT'})
AADD(aProdBlq,{'01140100836','STREET FIGHTER ANIVERSARY PS2 CAP'})
AADD(aProdBlq,{'01140101387','CAPCOM CLASSICS VOL 2 PS2 CAP'})
AADD(aProdBlq,{'01151403729','DJ HERO 2 PS3 ACT'})
AADD(aProdBlq,{'01151502100','GUITAR HERO: AEROSMITH WII ACT'})
AADD(aProdBlq,{'01151502101','GUITAR HERO AEROSMITH C/G WII ACT'})
AADD(aProdBlq,{'01151502331','QUANTUM OF SOLACE WII ACT'})
AADD(aProdBlq,{'01151502333','CALL OF DUTY: WORLD AT WAR WII ACT'})
AADD(aProdBlq,{'01151502605','CRASH: MIND OVER MUTANT WII ACT'})
AADD(aProdBlq,{'01151502635','GUITAR HERO WORLD TOUR TRILINGUAL WII ACT'})
AADD(aProdBlq,{'01151602067','KUNG FU PANDA PC ACT'})
AADD(aProdBlq,{'01151602073','ENEMY TERRITORY: QUAKE WARS PC ACT'})
AADD(aProdBlq,{'01151602335','MADAGASCAR 2: ESCAPE 2 AFRICA PC ACT'})
AADD(aProdBlq,{'01151502840','GUITAR HERO: SMASH HITS WII ACT'})
AADD(aProdBlq,{'01151502847','TRANSFORMERS: REVENGE OF THE FALLEN WII ACT'})
AADD(aProdBlq,{'01151503301','GUITAR HERO: VAN HALEN WII ACT'})
AADD(aProdBlq,{'01151503412','BAND HERO WII ACT'})
AADD(aProdBlq,{'01151503592','SHREK: FOREVER AFTER WII ACT'})
AADD(aProdBlq,{'01151503043','GUITAR HERO 5 WII ACT'})
AADD(aProdBlq,{'01170100091','GRAND THEFT AUTO III PS2 T2'})
AADD(aProdBlq,{'01151503141','BAKUGAN: BATTLE BRAWLERS WII ACT'})
AADD(aProdBlq,{'01151402857','PROTOTYPE PS3 ACT'})
AADD(aProdBlq,{'01151403281','JURASSIC: THE HUNTED PS3 ACT'})
AADD(aProdBlq,{'01151403765','BLOOD STONE 007 PS3 ACT'})
AADD(aProdBlq,{'01151403043','GUITAR HERO 5 PS3 ACT'})
AADD(aProdBlq,{'01151403592','SHREK: FOREVER AFTER PS3 ACT'})
AADD(aProdBlq,{'01151403781','TONY HAWK: SHRED PS3 ACT'})
AADD(aProdBlq,{'01151402335','MADAGASCAR: ESCAPE 2 AFRICA PS3 ACT'})
AADD(aProdBlq,{'01151402355','NPPL CHAMPIONSHIP PAINTBALL 2009 PS3 ACT'})
AADD(aProdBlq,{'01151403055','MARVEL: ULTIMATE ALLIANCE 2 PS3 ACT'})
AADD(aProdBlq,{'01151402589','SPIDER-MAN: WEB OF SHADOWS PS3 ACT'})
AADD(aProdBlq,{'01151403120','CALL OF DUTY: MODERN WARFARE 2 PS3 ACT'})
AADD(aProdBlq,{'01151403701','CALL OF DUTY: BLACK OPS  PS3 ACT'})
AADD(aProdBlq,{'01151403704','GUITAR HERO: WARRIORS OF ROCK PS3 ACT'})
AADD(aProdBlq,{'01151403708','RAPALA PRO BASS FISHING PS3 ACT'})
AADD(aProdBlq,{'01151402775','GUITAR HERO: METALLICA PS3 ACT'})
AADD(aProdBlq,{'01151403169','BLUR PS3 ACT'})
AADD(aProdBlq,{'01151403709','SPIDER-MAN SHATTERED DIMENSIONS  PS3 ACT'})
AADD(aProdBlq,{'01151403727','CABELAดS DANGEROUS HUNTS 2011 PS3 ACT'})
AADD(aProdBlq,{'01151202854','X-MEN ORIGINS: WOLVERINE PSP ACT'})
AADD(aProdBlq,{'01151301437','GUITAR HERO II (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'01151301755','SPIDER-MAN: FRIEND OR FOE X360 ACT'})
AADD(aProdBlq,{'01151301773','GUITAR HERO III COM GUITARRA COM FIO X360 ACT'})
AADD(aProdBlq,{'01151301787','GUITAR HERO 3 X360 ACT'})
AADD(aProdBlq,{'01151301792','BEE MOVIE X360 ACT'})
AADD(aProdBlq,{'01151301802','CALL OF DUTY 4: MODERN WARFARE GAME OF THE YEAR EDITION X360 ACT'})
AADD(aProdBlq,{'01151301954','GUITAR HERO II (BUNDLE) + GUITAR HERO III: LEGENDS OF ROCK X360 ACT'})
AADD(aProdBlq,{'01151302067','KUNG FU PANDA X360 ACT'})
AADD(aProdBlq,{'01151303043','GUITAR HERO 5 X360 ACT'})
AADD(aProdBlq,{'01151303056','SINGULARITY X360 ACT'})
AADD(aProdBlq,{'01151303709','SPIDER-MAN SHATTERED DIMENSIONS  X360 ACT'})
AADD(aProdBlq,{'01151302100','GUITAR HERO AEROSMITH X360 ACT'})
AADD(aProdBlq,{'01151303120','CALL OF DUTY: MODERN WARFARE 2 X360 ACT'})
AADD(aProdBlq,{'01151303169','BLUR X360 ACT'})
AADD(aProdBlq,{'01151302333','CALL OF DUTY: WORLD AT WAR X360 ACT'})
AADD(aProdBlq,{'01151303781','TONY HAWK: SHRED X360 ACT'})
AADD(aProdBlq,{'01151303301','GUITAR HERO: VAN HALEN X360 ACT'})
AADD(aProdBlq,{'01151303412','BAND HERO X360 ACT'})
AADD(aProdBlq,{'01151303582','MARVEL ULTIMATE ALLIANCE + FORZA MOTORSPORT 2 X360 MIC/ACT'})
AADD(aProdBlq,{'01151303592','SHREK: FOREVER AFTER X360 ACT'})
AADD(aProdBlq,{'01151401802','CALL OF DUTY 4: MODERN WARFARE GREATEST HITS PS3 ACT'})
AADD(aProdBlq,{'01151302840','GUITAR HERO: SMASH HITS X360 ACT'})
AADD(aProdBlq,{'01151303654','CALL OF DUTY: THE WAR COLLECTION X360 ACT'})
AADD(aProdBlq,{'01151401587','TRANSFORMERS PS3 ACT'})
AADD(aProdBlq,{'01151303701','CALL OF DUTY: BLACK OPS  X360 ACT'})
AADD(aProdBlq,{'01151303704','GUITAR HERO: WARRIORS OF ROCK X360 ACT'})
AADD(aProdBlq,{'01151302930','GHOSTBUSTERS: THE VIDEO GAME X360 ATA'})
AADD(aProdBlq,{'01151302979','WOLFENSTEIN X360 ACT'})
AADD(aProdBlq,{'01151103690','DREAMWORKS 2-IN-1 PARTY PACK DS ACT'})
AADD(aProdBlq,{'01151102842','GUITAR HERO ON TOUR: MODERN HITS NDS ACT'})
AADD(aProdBlq,{'01200101940','SONIC RIDERS: ZERO GRAVITY PS2 SEG'})
AADD(aProdBlq,{'01191602836','BATMAN: ARKHAM ASYLUM PC WAR'})
AADD(aProdBlq,{'01200102161','YAKUZA 2 PS2 SEG'})
AADD(aProdBlq,{'01200102336','SONIC UNLEASHED PS2 SEG'})
AADD(aProdBlq,{'01200101147','SHADOW THE HEDGEHOG PS2 SEG'})
AADD(aProdBlq,{'01171603672','SID MEIERดS PIRATES! PC T2'})
AADD(aProdBlq,{'01180100129','MANHUNT PS2 T2'})
AADD(aProdBlq,{'01170101913','MIDNIGHT CLUB II PS2 T2'})
AADD(aProdBlq,{'01171201337','GRAND THEFT AUTO: VICE CITY STORIES PSP T2'})
AADD(aProdBlq,{'01171201794','MANHUNT 2 PSP T2'})
AADD(aProdBlq,{'01171302048','GRAND THEFT AUTO IV X360 T2'})
AADD(aProdBlq,{'01171303497','MAX PAYNE 3  X360 T2'})
AADD(aProdBlq,{'01171303534','MAFIA II X360 T2'})
AADD(aProdBlq,{'01171303535','RED DEAD REDEMPTION  X360 T2'})
AADD(aProdBlq,{'01171503584','MAJOR LEAGUE BASEBALL 2K10  WII T2'})
AADD(aProdBlq,{'01171401598','FANTASTIC FOUR: RISE OF THE SILVER SURFER PS3 T2'})
AADD(aProdBlq,{'01171501484','SID MEIERดS PIRATES! WII T2'})
AADD(aProdBlq,{'01171402048','GRAND THEFT AUTO IV PS3 T2'})
AADD(aProdBlq,{'01171603663','AGE OF SAIL II: PRIVATEERดS BOUNTY PC T2'})
AADD(aProdBlq,{'01171603664','CIVILIZATION III GOLD EDITION / CIV CITY ROME BONUS 2 (BUNDLE) PC T2'})
AADD(aProdBlq,{'01171403419','BIOSHOCK 2 PS3 T2'})
AADD(aProdBlq,{'01171403497','MAX PAYNE 3  PS3 T2'})
AADD(aProdBlq,{'01171201071','THE WARRIORS PSP TAK'})
AADD(aProdBlq,{'01170101887','MOTOCROSS MANIA 3 PS2 TAK'})
AADD(aProdBlq,{'01231301834','LEGO STAR WARS: THE COMPLETE SAGA X360 DIS'})
AADD(aProdBlq,{'01211502290','COOKING MAMA WORLD KITCHE WII MAJ'})
AADD(aProdBlq,{'01201203741','PHANTASY STAR PORTABLE 2 PSP SEG'})
AADD(aProdBlq,{'01201301430','SONIC THE HEDGEHOG X360 SEG'})
AADD(aProdBlq,{'01201302076','THE INCREDIBLE HULK X360 SEG'})
AADD(aProdBlq,{'01201302336','SONIC UNLEASHED X360 SEG'})
AADD(aProdBlq,{'01201403553','RESONANCE OF FATE PS3 SEG'})
AADD(aProdBlq,{'01201401430','SONIC THE HEDGEHOG PS3 SEG'})
AADD(aProdBlq,{'01201401444','FULL AUTO 2: BATTLELINES PS3 SEG'})
AADD(aProdBlq,{'01201503421','SONIC & SEGA ALL-STARS RACING WII SEG'})
AADD(aProdBlq,{'01201503459','SUPER MONKEY BALL: STEP & ROLL WII SEG'})
AADD(aProdBlq,{'01201503573','IRON MAN 2 WII SEG'})
AADD(aProdBlq,{'01201602076','THE INCREDIBLE HULK PC SEG'})
AADD(aProdBlq,{'01201103573','IRON MAN 2 (HOMEM DE FERRO) NDS SEG'})
AADD(aProdBlq,{'01201103743','SONIC COLORS DS SEG'})
AADD(aProdBlq,{'01311301850','FINAL FANTASY XI WINGS X360 SQU'})
AADD(aProdBlq,{'01311303492','FINAL FANTASY XIII X360 SQU'})
AADD(aProdBlq,{'01311403492','FINAL FANTASY XIII PS3 SQU'})
AADD(aProdBlq,{'01320101878','ART OF FIGHTING ANTHOLOGY PS2 SNK'})
AADD(aProdBlq,{'01260101566','RAIDEN 3 PS2 HIP'})
AADD(aProdBlq,{'01271203117','UNDEAD KNIGHTS PSP TEC'})
AADD(aProdBlq,{'01271403510','DYNASTY WARRIORS: STRIKEFORCE  PS3 TEC'})
AADD(aProdBlq,{'01280102148','TNA IMPACT! PS2 MID'})
AADD(aProdBlq,{'01281401856','BLACKSITE: AREA 51 PS3 MID'})
AADD(aProdBlq,{'01281402148','TNA IMPACT! PS3 MID'})
AADD(aProdBlq,{'01281402416','MORTAL KOMBAT VS. DC UNIVERSE PS3 MID'})
AADD(aProdBlq,{'01281502148','TNA IMPACT! WII MID'})
AADD(aProdBlq,{'01231303395','LEGO INDIANA JONES 2: THE ADVENTURE CONTINUES X360 DIS'})
AADD(aProdBlq,{'01231503395','LEGO INDIANA JONES 2: THE ADVENTURE CONTINUES WII DIS'})
AADD(aProdBlq,{'01231402209','STAR WARS: THE FORCE UNLEASHED PS3 DIS'})
AADD(aProdBlq,{'01481603479','TWO WORLDS PC STPK'})
AADD(aProdBlq,{'01551402249','SBK 08: SUPERBIKE WORLD CHAMPIONSHIP PS3 CONS'})
AADD(aProdBlq,{'01661302575','RAVEN SQUAD: OPERATION HIDDEN DAGGER X360 STPK'})
AADD(aProdBlq,{'01601202271','KING OF FIGHTERS: OROCHI PSP CRAVE'})
AADD(aProdBlq,{'01481302613','FUEL X360 COD'})
AADD(aProdBlq,{'01481303016','SECTION 8 X360 STPK'})
AADD(aProdBlq,{'01421103693','BEN 10 ULTIMATE ALIEN: COSMIC DESTRUCTION DS D3'})
AADD(aProdBlq,{'01421203142','BEN 10 ALIEN FORCE: VILGAX ATTACKS PSP D3'})
AADD(aProdBlq,{'01421203693','BEN 10 ULTIMATE ALIEN: COSMIC DESTRUCTION PSP D3'})
AADD(aProdBlq,{'01421303693','BEN 10 ULTIMATE ALIEN: COSMIC DESTRUCTION X360 D3'})
AADD(aProdBlq,{'01421503693','BEN 10 ULTIMATE ALIEN: COSMIC DESTRUCTION WII D3'})
AADD(aProdBlq,{'01421503801','KIDZ BOP DANCE PARTY WII D3'})
AADD(aProdBlq,{'01441403794','F1 2010 PS3 COD'})
AADD(aProdBlq,{'01421101857','BEN 10 PROTECTOR OF EARTH NDS D3'})
AADD(aProdBlq,{'01420103142','BEN 10 ALIEN FORCE: VILGAX ATTACKS PS2 D3'})
AADD(aProdBlq,{'01341303730','FALLOUT: NEW VEGAS X360 BET'})
AADD(aProdBlq,{'01341403226','ROGUE WARRIOR PS3 BET'})
AADD(aProdBlq,{'0207160028001','ESTOJO WII FIT DO WII BALANCE BOARD SLEEVE WII NIN'})
AADD(aProdBlq,{'0235020003301','VOLANTE VTHUNDER . GC INTERACT'})
AADD(aProdBlq,{'0235020004301','MOBILE MONITOR . GC INTERACT'})
AADD(aProdBlq,{'0235010002701','CABO SVIDEO . PS2 INTERACT'})
AADD(aProdBlq,{'0207120027401','ESTOJO DO NINTENDO DSI SYSTEM WALLET NDS NIN'})
AADD(aProdBlq,{'0207120025801','ESTOJO NINTENDO DS MINI FOLIO BLACK NDS NIN'})
AADD(aProdBlq,{'01991202938','MYTRAN WARS PSP DEEP'})
AADD(aProdBlq,{'01991303739','NAILดD  X360 DEEP'})
AADD(aProdBlq,{'01991403739','NAILดD  PS3 DEEP'})
AADD(aProdBlq,{'0206010008001','STORM CHASER . PS2 SONY'})
AADD(aProdBlq,{'0281120035901','BOOK CASE DS CTA'})
AADD(aProdBlq,{'0283160037701','BATERIA RECARREGมVEL PARA BALANวA PARA WII FIT BALANCE BOARD MEMOREX'})
AADD(aProdBlq,{'0283200037901','CARREGADOR AUTOMOTIVO PARA DS LITE, DSI  S DSI XL MEMOREX'})
AADD(aProdBlq,{'0306010004901','AP SONY CONSOLE PS2 PRETO SLIM'})
AADD(aProdBlq,{'0281160035201','DUMBBELL SET WII CTA'})
AADD(aProdBlq,{'0306140003801','CONSOLE PS3 (NACIONAL)'})
AADD(aProdBlq,{'0282160036401','CHARGE BASE STANDING WHITE WII NYKO'})
AADD(aProdBlq,{'0283160037103','VOLANTE PARA WII (VERDE) MEMOREX'})
AADD(aProdBlq,{'0283160037109','VOLANTE PARA WII (ROXO) MEMOREX'})
AADD(aProdBlq,{'0283160037603','CAPA DE SILICONE PARA CONTROLE DO WII COM MOTION PLUS E NUNCHUK (AZUL) MEMOREX'})
AADD(aProdBlq,{'0283160037609','CAPA DE SILICONE PARA CONTROLE DO WII COM MOTION PLUS E NUNCHUK (VERDE) MEMOREX'})
AADD(aProdBlq,{'0306010004701','SUPERBUNDLE COM PS2 PRETO SLIM SONY'})
AADD(aProdBlq,{'0268140039801','BATERIA ROCK BAND X360 EA'})
AADD(aProdBlq,{'0266010019101','GUITARRA DO GUITAR HERO WORLD TOUR PS2 ACT'})
AADD(aProdBlq,{'0262160013001','MEMORY CARD SD 2GB . WII SANDISK'})
AADD(aProdBlq,{'0266140019001','ESTRUTURA - BATERIA DO GUITAR HERO WORLD TOUR X360 ACT'})
AADD(aProdBlq,{'0235040006501','CONTROLE POWER PAD . XBOX INTERACT'})
AADD(aProdBlq,{'0236010000701','CONTROLE . PS2 PELICAN'})
AADD(aProdBlq,{'0418090010301','GUITAR HERO 5 (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0307150003115','CONSOLE NINTENDO WII'})
AADD(aProdBlq,{'0405090007201','EYE OF JUDGEMENT (JOGO + CAMERA) PS3 SON'})
AADD(aProdBlq,{'0418010010301','GUITAR HERO 5 (BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0414080012101','DISNEY SING IT: POP HITS (BUNDLE) WII DIS'})
AADD(aProdBlq,{'0414080018901','DISNEY SING IT: FAMILY HITS (BUNDLE) WII DIS'})
AADD(aProdBlq,{'0418010012401','GUITAR HERO III: LEGENDS OF ROCK (BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0416080013201','ULTIMATE PARTY CHALLENGE (BUNDLE) WII KON'})
AADD(aProdBlq,{'0414100002801','DISNEY SING IT (BUNDLE) X360 DIS'})
AADD(aProdBlq,{'0416090021001','DANCEDANCEREVOLUTION (BUNDLE) PS3 KON'})
AADD(aProdBlq,{'0415120012501','WARHAMMER: MARK OF CHAOS - BATTLE MARCH PC NAM'})
AADD(aProdBlq,{'0418090005301','GUITAR HERO WORLD TOUR (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0407080009901','WII SPORTS RESORT (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0407080013401','WII SPORTS RESORT (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0307070000701','NINTENDO 64 . NINTENDO'})
AADD(aProdBlq,{'0407080015801','ENDLESS OCEAN: BLUE WORLD (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0407110013811','NINTENDO DS LITE STARTER BLUE NDS NIN'})
AADD(aProdBlq,{'0307100003301','NINTENDO DSI AZUL'})
AADD(aProdBlq,{'0407080007001','MARIO KART (BUNDLE) WII NIN'})
AADD(aProdBlq,{'01151103887','GOLDENEYE 007 DS ACT'})
AADD(aProdBlq,{'01151503887','GOLDENEYE 007 WII ACT'})
AADD(aProdBlq,{'01011303897','THE BIGGEST LOSER ULTIMATE WORKOUT X360 THQ'})
AADD(aProdBlq,{'01121103898','IMAGINE: FASHION STYLIST DS UBI'})
AADD(aProdBlq,{'01151103701','CALL OF DUTY: BLACK OPS  DS ACT'})
AADD(aProdBlq,{'01151503701','CALL OF DUTY: BLACK OPS  WII ACT'})
AADD(aProdBlq,{'0285160046001','ESTOJO PARA CONTROLE DO WII TEMA STAR WARS THE FORCE UNLEASHED LAT'})
AADD(aProdBlq,{'01071503880','POKEPARK WII: PIKACHUดS ADVENTURE WII NIN'})
AADD(aProdBlq,{'01171103982','GRAND THEFT AUTO: CHINATOWN WARS DS T2'})
AADD(aProdBlq,{'01071103977','POKษMON WHITE VERSION DS NIN'})
AADD(aProdBlq,{'01051403979','DRAGON AGE II PS3 EA'})
AADD(aProdBlq,{'01061403983','KILLZONE 3 PS3 SON'})
AADD(aProdBlq,{'01101403984','LEGO PIRATES OF THE CARIBBEAN: THE VIDEO GAME PS3 DIS'})
AADD(aProdBlq,{'0286120047511','BOLSA FEMININA PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS AZUL ESCURO DS RDS'})
AADD(aProdBlq,{'0286120047711','GAMETRAVELLER ESSENTIALS - KIT DE CANETAS STYLUS E ESTOJOS COLORIDOS PARA JOGOS DE DS RDS'})
AADD(aProdBlq,{'01141404019','MOTOGP 10/11 PS3 CAP'})
AADD(aProdBlq,{'01141404008','MARVEL VS CAPCOM 3: FATE OF TWO WORLDS LATAM PS3 CAP'})
AADD(aProdBlq,{'01141103999','SUPER STREET FIGHTER IV: 3D EDITION 3DS CAP'})
AADD(aProdBlq,{'01101404009','DISNEY SING IT PS3 DIS'})
AADD(aProdBlq,{'01171403991','L.A. NOIRE PS3 T2'})
AADD(aProdBlq,{'01171303991','L.A. NOIRE X360 T2'})
AADD(aProdBlq,{'01201504029','THOR: GOD OF THUNDER WII SEG'})
AADD(aProdBlq,{'01201104026','SUPER MONKEY BALL 3D 3DS SEG'})
AADD(aProdBlq,{'01421303963','EARTH DEFENSE FORCE: INSECT ARMAGEDDON X360 D3'})
AADD(aProdBlq,{'01151103944','GUITAR HERO ON TOUR: DECADES  DS ACT'})
AADD(aProdBlq,{'01041303945','BODY AND BRAIN CONNECTION X360 NAM'})
AADD(aProdBlq,{'0285240046308','MINI FOLIO (ESTOJO PARA DS E DSI ROSA) LAT'})
AADD(aProdBlq,{'01101103905','CLUB PENGUIN: ELITE PENGUIN FORCE: HERBERTดS REVENGE DS DIS'})
AADD(aProdBlq,{'01421103906','BEN 10 ALIEN FORCE: VILGAX ATTACKS DS D3'})
AADD(aProdBlq,{'01071103912','MARIO KART NDS NIN'})
AADD(aProdBlq,{'01071103913','MARIO PARTY DS DS NIN'})
AADD(aProdBlq,{'01071103914','NEW SUPER MARIO BROS. DS NIN'})
AADD(aProdBlq,{'01071103916','SUPER MARIO NDS NIN'})
AADD(aProdBlq,{'01011503919','DE BLOB 2 WII THQ'})
AADD(aProdBlq,{'01011403921','HOMEFRONT PS3 THQ'})
AADD(aProdBlq,{'01231403922','LEGO STAR WARS III: THE CLONE WARS PS3 DIS'})
AADD(aProdBlq,{'0286160047405','DELUXE GAME TRAVELLER - BOLSA DE TRANSPORTE PARA WII BRANCA RDS'})
AADD(aProdBlq,{'0286120047503','GAMETRAVELLER - BOLSA FEMININA PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS AZUL DS RDS'})
AADD(aProdBlq,{'0286120047611','GAMETRAVELLER - ESTOJO PARA NINTENDO DS PRETO DO MARIO DS RDS'})
AADD(aProdBlq,{'01101103936','CLUB PENGUIN: ELITE PENGUIN FORCE DS DIS'})
AADD(aProdBlq,{'0286120047508','GAMETRAVELLER - BOLSA FEMININA PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS ROSA ESCURO DS RDS'})
AADD(aProdBlq,{'01141403930','MARVEL VS. CAPCOM 3: FATE OF TWO WORLDS PS3 CAP'})
AADD(aProdBlq,{'01141303930','MARVEL VS. CAPCOM 3: FATE OF TWO WORLDS X360 CAP'})
AADD(aProdBlq,{'0286120047510','GAMETRAVELLER - BOLSA FEMININA PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS ROXA  DS RDS'})
AADD(aProdBlq,{'01231503922','LEGO STAR WARS III: THE CLONE WARS WII DIS'})
AADD(aProdBlq,{'01171103923','MAJOR LEAGUE BASEBALL 2K11 DS T2'})
AADD(aProdBlq,{'0286120047613','GAMETRAVELLER - ESTOJO PARA NINTENDO DS AZUL DO MARIO DS RDS'})
AADD(aProdBlq,{'0286120047605','GAMETRAVELLER - ESTOJO PARA NINTENDO DS PRETO COM PERSONAGENS DO MARIO DS RDS'})
AADD(aProdBlq,{'01051403937','BULLETSTORM PS3 EA'})
AADD(aProdBlq,{'0286120047608','GAMETRAVELLER - ESTOJO PARA NINTENDO DS ROSA DS RDS'})
AADD(aProdBlq,{'01121303939','DRIVER: SAN FRANCISCO X360 UBI'})
AADD(aProdBlq,{'01121403939','DRIVER: SAN FRANCISCO PS3 UBI'})
AADD(aProdBlq,{'01121303856','MICHAEL JACKSON: THE EXPERIENCE X360 UBI'})
AADD(aProdBlq,{'0286120047812','GAMETRAVELLER - ESTOJO PARA NINTENDO DSI XL MARROM DS RDS'})
AADD(aProdBlq,{'0286120047804','GAMETRAVELLER - ESTOJO PARA NINTENDO DS BRANCO DO PRINCESS PEACH DS RDS'})
AADD(aProdBlq,{'0286120047903','GAMETRAVELLER ESSENTIALS - KIT DE CANETAS STYLUS E ESTOJOS AZUIS PARA JOGOS DE DS RDS'})
AADD(aProdBlq,{'01051303900','NEED FOR SPEED HOT PURSUIT X360 EA'})
AADD(aProdBlq,{'01051503900','NEED FOR SPEED HOT PURSUIT WII EA'})
AADD(aProdBlq,{'0285240045912','KIT COM 2 CANETAS TOUCH STYLUS SET MARROM PARA DSI XL LAT'})
AADD(aProdBlq,{'01201103908','SONIC RUSH DS SEG'})
AADD(aProdBlq,{'0285120046101','LIGHTSABER STYLUS 3 PACK FOR NDS (CANETA STYLUS EM FORMA DE SABRE DE LUZ DO STAR WARS PARA NDS) LAT'})
AADD(aProdBlq,{'01121103904','PRINCE OF PERSIA: THE FORGOTTEN SANDS DS UBI'})
AADD(aProdBlq,{'0241140053301','STORAGE TOWER GENERATION XBOX'})
AADD(aProdBlq,{'0282260051401','POWER PACK BATTERY RECHARGEABLE 3DS NYKO'})
AADD(aProdBlq,{'0288160059901','GCUBE/WII WIRELESS MICROCON'})
AADD(aProdBlq,{'0287140057701','KINECT TV MOUNT X360 PDP'})
AADD(aProdBlq,{'0287140057301','XB360 AFTERGLOW CONTROLLER X360 PDP'})
AADD(aProdBlq,{'0287160058601','WII NERF WHEEL WII PDP'})
AADD(aProdBlq,{'0287160058501','WII NERF REMOTE WII PDP'})
AADD(aProdBlq,{'0287160057201','WII AFTERGLOW NUNCHUCK PDP WII'})
AADD(aProdBlq,{'0287160057101','WII AFTERGLOW CONTROLLER WII PDP'})
AADD(aProdBlq,{'0287140057601','KINECT WALL MOUNT X360 PDP'})
AADD(aProdBlq,{'0287120055601','NDS LPS TOPPERS KIT'})
AADD(aProdBlq,{'0287120058301','NDS UNIVERSAL NERF CASE'})
AADD(aProdBlq,{'0287120059301','NERF STYLUS PACK'})
AADD(aProdBlq,{'0287150056601','ENERGIZER CHARGE CABLE PDP'})
AADD(aProdBlq,{'0287150056501','ENERGIZER CHARGING SYSTEM PDP'})
AADD(aProdBlq,{'0287150058001','PS3 MOVE TV CLIP'})
AADD(aProdBlq,{'01441304457','BATMAN ARKHAM CITY X360 WAR'})
AADD(aProdBlq,{'01121304482','RABBIDS: ALIVE & KICKING X360 UBI'})
AADD(aProdBlq,{'0287150057001','UNIV ENERGIZER 2:1 AC/DC ADAPTER'})
AADD(aProdBlq,{'0287260059201','3DS WRITE & PROTECT 3DS PDP'})
AADD(aProdBlq,{'01151104132','CALL OF DUTY: WORLD AT WAR DS ACT'})
AADD(aProdBlq,{'01141404454','SUPER STREET FIGHTER IV: ARCADE EDITION PS3 CAP'})
AADD(aProdBlq,{'01141304454','SUPER STREET FIGHTER IV: ARCADE EDITION X360 CAP'})
AADD(aProdBlq,{'01061404472','INFAMOUS 2 PS3 SON'})
AADD(aProdBlq,{'01101504455','CARS 2: THE VIDEO GAME WII DIS'})
AADD(aProdBlq,{'01151104364','SHREK: FOREVER AFTER DS ACT'})
AADD(aProdBlq,{'01151104283','MONSTERS VS ALIENS DS ACT'})
AADD(aProdBlq,{'0281150051801','QUADRUPLE PORT CHARGING STATION FOR PLAYSTATION MOVE CONTROLLERS PS3 CTA'})
AADD(aProdBlq,{'01141204452','MONSTER HUNTER FREEDOM 2 PSP CAP'})
AADD(aProdBlq,{'0287260058901','3DS CAR CHARGER PDP'})
AADD(aProdBlq,{'0287120058401','DSI XL NERF ARMOR PDP DS'})
AADD(aProdBlq,{'0282140049401','CHARGE BASE 360 S X360'})
AADD(aProdBlq,{'0282160054301','CHARGE BASE STANDING  BLACK WII'})
AADD(aProdBlq,{'01121304444','ASSASSINดS CREED: REVELATIONS X360 UBI'})
AADD(aProdBlq,{'01121404444','ASSASSINดS CREED: REVELATIONS LIMITED EDITION PS3 UBI'})
AADD(aProdBlq,{'0287260059101','3DS RAINBOW SLIDE STYLUS PACK 3DS PDP'})
AADD(aProdBlq,{'0287160058701','WII NERF SPORTS PACK'})
AADD(aProdBlq,{'0288140060201','X360 AMPX AMPLIFIED GAMING HEADSET'})
AADD(aProdBlq,{'0282150052901','RAVEN MOTION SENSING PS3'})
AADD(aProdBlq,{'0282150052701','SKILL SHOT PS3 NYK'})
AADD(aProdBlq,{'0287260059701','3DS TRANSFORMERS 3 CYBERTANIUM CASE'})
AADD(aProdBlq,{'0288010060401','PS2 WIRELESS MICROCON'})
AADD(aProdBlq,{'01121304449','ROCKSMITH X360 UBI'})
AADD(aProdBlq,{'01121504448','RAYMAN ORIGINS WII UBI'})
AADD(aProdBlq,{'0287150054801','PES PS3 CONSOLE COVER'})
AADD(aProdBlq,{'01121404448','RAYMAN ORIGINS PS3 UBI'})
AADD(aProdBlq,{'01121404449','ROCKSMITH PS3 UBI'})
AADD(aProdBlq,{'0288150060601','PS3 HEADCOM PRO PREMIUM WIRED HEADSET'})
AADD(aProdBlq,{'0287120058101','DSI NERF ARMOR DS PDP'})
AADD(aProdBlq,{'01201604045','TOTAL WAR: SHOGUN 2 PC SEG'})
AADD(aProdBlq,{'01041504062','EXERBEAT WII NAM'})
AADD(aProdBlq,{'01141204073','HARVEY BIRDMAN: ATTORNEY AT LAW PSP CAP'})
AADD(aProdBlq,{'01201304074','CAPTAIN AMERICA: SUPER SOLDIER X360 SEG'})
AADD(aProdBlq,{'01151304439','X-MEN: DESTINY X360 ACT'})
AADD(aProdBlq,{'0281150051601','PROFESSIONAL SPORTS KIT FOR SPORT CHAMPIONS / PLAYSTATION MOVE. INCLUDES: SWORD, KNIFE, SHIELD, BOW,'})
AADD(aProdBlq,{'01071104253','THE LEGEND OF ZELDA: SPIRIT TRACKS DS NIN'})
AADD(aProdBlq,{'0281150052401','RACING WHEEL FOR PLAYSTATION MOVE & DUAL SHOCK CONTROLLERS'})
AADD(aProdBlq,{'0281150052501','RACING WHEEL WITH STAND FOR PLAYSTATION MOVE & DUAL SHOCK CONTROLLERS'})
AADD(aProdBlq,{'0281150053601','TENNIS RACKET FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281150048301','14 IN 1 FAMILY PACK FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281150048701','6 IN 1 COMPETITION SPORTS KIT FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281140053901','VERTICAL INDUCTION CHARGER FOR XBOX 360 CONTROLLERS WITH AC ADAPTER AND 3 RECHARGEABLE BATTERIES'})
AADD(aProdBlq,{'0281140054001','VERTICAL INDUCTION CHARGER FOR XBOX 360 CONTROLLERS WITH AC ADAPTER AND 3 RECHARGEABLE BATTERIES (BL'})
AADD(aProdBlq,{'0260160048401','3 IN 1 FIT BOARD BUNDLE'})
AADD(aProdBlq,{'01121404111','ASSASSINดS CREED (MANUAL EM PORTUGUES) PS3 UBI'})
AADD(aProdBlq,{'0281150048901','ASSAULT RIFLE CONTROLLER FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281160049101','BLAST SABER COMBO FOR WII'})
AADD(aProdBlq,{'0260160050301','DUAL GLOW SABERS COM JOGO STAR WAS THE CLONE WAS WII'})
AADD(aProdBlq,{'01121304111','ASSASSINดS CREED (MANUAL EM PORTUGUES) X360 UBI'})
AADD(aProdBlq,{'01121404236','ASSASSINดS CREED BROTHERHOOD (MANUAL EM PORTUGUES) PS3 UBI'})
AADD(aProdBlq,{'01121304236','ASSASSINดS CREED BROTHERHOOD (MANUAL EM PORTUGUES) X360 UBI'})
AADD(aProdBlq,{'0260150052601','RADIUM WIRELESS CONTROLLER'})
AADD(aProdBlq,{'0237150048601','4 IN 1 WIRELESS GAMING SOLUTION'})
AADD(aProdBlq,{'01121404248','ASSASSINดS CREED II (MANUAL EM PORTUGUES) PS3 UBI'})
AADD(aProdBlq,{'01121304248','ASSASSINดS CREED II (MANUAL EM PORTUGUES) X360 UBI'})
AADD(aProdBlq,{'01121504310','DRIVER: SAN FRANCISCO WII UBI'})
AADD(aProdBlq,{'0281160050501','DUAL VERTICAL INDUCTION CHARGER FOR WII, DSI AND DSIXL'})
AADD(aProdBlq,{'0281150050601','ELITE QUAD CHARGING BAY FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0260160052101','QUICK SHOT PLUS DUAL TRIGGER LIGHT GUN COM JOGO NERF ARENA WII'})
AADD(aProdBlq,{'0237160049701','CHARGING DOCK & TURBO CENTER'})
AADD(aProdBlq,{'0237150049801','CHARGING MATT'})
AADD(aProdBlq,{'01061404050','PLAYSTATION MOVE HEROES PS3 SON'})
AADD(aProdBlq,{'01481304067','MONSTER MADNESS: BATTLE FOR SUBURBIA X360 STPK'})
AADD(aProdBlq,{'01051104037','NEED FOR SPEED: NITRO DS EA'})
AADD(aProdBlq,{'01031103775','PRO EVOLUTION SOCCER 2011 3D 3DS KON'})
AADD(aProdBlq,{'01131404051','PORTAL 2 PS3 VALV'})
AADD(aProdBlq,{'01151604040','X-MEN ORIGINS: WOLVERINE UNCAGED EDITION PC ACT'})
AADD(aProdBlq,{'01101104203','HIGH SCHOOL MUSICAL 2: WORK THIS OUT! DS DIS'})
AADD(aProdBlq,{'01101104204','HIGH SCHOOL MUSICAL 3: SENIOR YEAR DS DIS'})
AADD(aProdBlq,{'01101104329','PIRATES OF THE CARIBBEAN: AT WORLDดS END DS DIS'})
AADD(aProdBlq,{'01101104386','THE CHEETAH GIRLS: PASSPORT TO STARDOM DS DIS'})
AADD(aProdBlq,{'01101104387','THE CHEETAH GIRLS: POP STAR SENSATIONS DS DIS'})
AADD(aProdBlq,{'01101104393','DISNEY THE PRINCESS AND THE FROG DS DIS'})
AADD(aProdBlq,{'01121104101','CLUBHOUSE GAMES DS NIN'})
AADD(aProdBlq,{'01071104143','CROSSWORDS DS NIN'})
AADD(aProdBlq,{'01881104124','NINTENDOGS CHIHUAHUA & FRIENDS DS NIN'})
AADD(aProdBlq,{'01071104332','POKษMON DIAMOND VERSION DS NIN'})
AADD(aProdBlq,{'01071104334','POKษMON PLATINUM VERSION DS NIN'})
AADD(aProdBlq,{'01071104335','POKษMON RANGER: SHADOWS OF ALMIA DS NIN'})
AADD(aProdBlq,{'01071104339','PROFESSOR LAYTON AND THE DIABOLICAL BOX DS NIN'})
AADD(aProdBlq,{'01821404496','ALICE: MADNESS RETURNS (EUR) PS3 EA'})
AADD(aProdBlq,{'01441340529','FORZA MOTORSPORT 3 X360 MIC'})
AADD(aProdBlq,{'01061440535','MOTORSTORM APOCALYPSE (EUR) PS3 SON'})
AADD(aProdBlq,{'01421104109','ASTRO BOY: THE VIDEO GAME DS D3'})
AADD(aProdBlq,{'01061440514','LORD OF THE RINGS ARAGORNดS QUEST (EUR) SON PS3'})
AADD(aProdBlq,{'01041340556','ACE COMBAT: ASSAULT HORIZON X360 NAM'})
AADD(aProdBlq,{'01121104215','SKATE IT DS EA'})
AADD(aProdBlq,{'01121340525','JUST DANCE KIDS 2 X360 UBI'})
AADD(aProdBlq,{'0289150061101','GALLARDO STEERING WHEEL AC PS3 ATC'})
AADD(aProdBlq,{'0289150061201','SUPER SPORT STEERING WHEEL AC PS3 ATC'})
AADD(aProdBlq,{'01121104227','IMAGINE: GYMNAST DS UBI'})
AADD(aProdBlq,{'01121104336','PRINCE OF PERSIA: THE FALLEN KING DS UBI'})
AADD(aProdBlq,{'01101104142','THE CHRONICLES OF NARNIA: PRINCE CASPIAN DS DIS'})
AADD(aProdBlq,{'01101104154','DISNEY FAIRIES: TINKER BELL AND THE LOST TREASURE DS DIS'})
AADD(aProdBlq,{'01121104229','IMAGINE: PARTY PLANNER DS UBI'})
AADD(aProdBlq,{'01121104230','IMAGINE: REPORTER DS UBI'})
AADD(aProdBlq,{'01121104345','RABBIDS GO HOME DS UBI'})
AADD(aProdBlq,{'01101104202','HIGH SCHOOL MUSICAL: MAKINด THE CUT DS DIS'})
AADD(aProdBlq,{'01011104391','THE LAST AIRBENDER DS THQ'})
AADD(aProdBlq,{'01421104299','NARUTO: PATH OF NINJA 2 DS TOM'})
AADD(aProdBlq,{'01121104114','BATTLE OF GIANTS: MUTANT INSECTS DS UBI'})
AADD(aProdBlq,{'01051104182','FIFA SOCCER 09 DS EA'})
AADD(aProdBlq,{'01121104176','ENER-G: DANCE SQUAD DS UBI'})
AADD(aProdBlq,{'01051104258','LITTLEST PET SHOP: WINTER DS EA'})
AADD(aProdBlq,{'01031104351','ROCK REVOLUTION DS KON'})
AADD(aProdBlq,{'01121104108','ASSASSINดS CREED II: DISCOVERY DS UBI'})
AADD(aProdBlq,{'01011104419','WOMENดS MURDER CLUB: GAMES OF PASSION DS THQ'})
AADD(aProdBlq,{'01151104400','TONY HAWKS MOTION NDS ACT'})
AADD(aProdBlq,{'01011104267','MARVEL SUPER HERO SQUAD DS THQ'})
AADD(aProdBlq,{'01151104406','TRANSFORMERS: REVENGE OF THE FALLEN - DECEPTICONS DS ACT'})
AADD(aProdBlq,{'01151104424','X-MEN ORIGINS: WOLVERINE DS ACT'})
AADD(aProdBlq,{'01011104285','MX VS. ATV REFLEX DS THQ'})
AADD(aProdBlq,{'01141104274','MEGA MAN STAR FORCE 2: ZERKER X SAURION DS CAP'})
AADD(aProdBlq,{'01011104107','ARE YOU SMARTER THAN A 5TH GRADER? GAME TIME DS THQ'})
AADD(aProdBlq,{'01201104123','BLEACH: THE 3RD PHANTOM DS SEG'})
AADD(aProdBlq,{'01041104165','DRAGON BALL: ORIGINS 2 DS NAM'})
AADD(aProdBlq,{'01071104162','DRAGON QUEST IV: CHAPTERS OF THE CHOSEN DS SQU'})
AADD(aProdBlq,{'01061440712','RESISTANCE 2 (UK) PS3 SON'})
AADD(aProdBlq,{'0281150062312','SUBMACHINE GUN PS3 CTA'})
AADD(aProdBlq,{'0260160063001','QUICK SHOT PRO DUAL TRIGGER BLASTER WII DG'})
AADD(aProdBlq,{'01441440745','F.E.A.R. 3 (EUR) PS3 WAR'})
AADD(aProdBlq,{'01031640690','PRO EVOLUTION SOCCER 2012 PC KON'})
AADD(aProdBlq,{'01051440720','DEAD SPACE 2 LIMITED EDITION (EUR) PS3 EA'})
AADD(aProdBlq,{'01051440739','DEAD SPACE 2 (UK) PS3 EA'})
AADD(aProdBlq,{'01051340740','BULLETSTORM (EUR) X360 EA'})
AADD(aProdBlq,{'01051440750','FIFA SOCCER 12 PS3 EA'})
AADD(aProdBlq,{'01151440754','WIPEOUT 2 PS3 ACT'})
AADD(aProdBlq,{'01171440728','NBA 2K12 PS3 T2'})
AADD(aProdBlq,{'01151440752','CALL OF DUTY MODERN WARFARE 3 PS3 ACT'})
AADD(aProdBlq,{'01151340752','CALL OF DUTY MODERN WARFARE 3 X360 ACT'})
AADD(aProdBlq,{'01031340697','METAL GEAR SOLID HD COLLECTION X360 KON'})
AADD(aProdBlq,{'01021540709','JG X WII PROMOCAO 99,90'})
AADD(aProdBlq,{'01041340585','DARK SOULS X360 NAM'})
AADD(aProdBlq,{'01141340586','DEAD RISING 2: OFF THE RECORD X360 CAP'})
AADD(aProdBlq,{'01042240634','TEKKEN 3DS 3DS NAM'})
AADD(aProdBlq,{'01331440679','BODYCOUNT (EUR) PS3 COD'})
AADD(aProdBlq,{'01030140690','PRO EVOLUTION SOCCER 2012 PS2 KON'})
AADD(aProdBlq,{'01121540662','JUST DANCE 3 WII UBI'})
AADD(aProdBlq,{'01121340662','JUST DANCE 3 X360 UBI'})
AADD(aProdBlq,{'01441440701','LEGO: ROCK BAND (MEX) PS3 WAR'})
AADD(aProdBlq,{'01031440690','PRO EVOLUTION SOCCER 2012 PS3 KON'})
AADD(aProdBlq,{'01031340690','PRO EVOLUTION SOCCER 2012 X360 KON'})
AADD(aProdBlq,{'01151340704','CALL OF DUTY: WORLD AT WAR - PLATINUM HITS X360 ACT'})
AADD(aProdBlq,{'01151340706','CALL OF DUTY 4: MODERN WARFARE - PLATINUM HITS X360 ACT'})
AADD(aProdBlq,{'01041440564','ARMORED CORE V PS3 NAM'})
AADD(aProdBlq,{'01041440600','INVERSION PS3 NAM'})
AADD(aProdBlq,{'01041340601','INVERSION X360 NAM'})
AADD(aProdBlq,{'01141340592','DRAGONดS DOGMA X360 CAP'})
AADD(aProdBlq,{'01201540602','MARIO & SONIC AT THE LONDON 2012 OLYMPIC GAMES WII SEG'})
AADD(aProdBlq,{'01041340604','NARUTO SHIPPUDEN: ULTIMATE STORM GENERATIONS X360 NAM'})
AADD(aProdBlq,{'01141340630','STREET FIGHTER X TEKKEN X360 CAP'})
AADD(aProdBlq,{'01141440631','STREET FIGHTER X TEKKEN PS3 CAP'})
AADD(aProdBlq,{'01421540569','BEN 10 GALACTIC RACING WII D3'})
AADD(aProdBlq,{'01141440616','RESIDENT EVIL: OPERATION RACCOON CITY PS3 CAP'})
AADD(aProdBlq,{'01041440584','DARK SOULS PS3 NAM'})
AADD(aProdBlq,{'0287120080801','LITTLEST PET SHOP CHARACTER KIT CASE FOR  NDS PDP'})
AADD(aProdBlq,{'0283010071801','CD&DVD TRAVEL CASE PS2   MEM'})
AADD(aProdBlq,{'0287120072001','CARS SYSTEM CASE NDS  PDP'})
AADD(aProdBlq,{'0287120072201','BUZZ LIGHTYEAR STARTER KIT FOR  NDS  PDP'})
AADD(aProdBlq,{'0281160072401','BOWLING BALL  WII CTA'})
AADD(aProdBlq,{'0287120076901','SHOWดN GO FOLIO FOR  NDS'})
AADD(aProdBlq,{'0287120079101','PRINCESS CONSOLE CLUTCH NDS PDP'})
AADD(aProdBlq,{'0281160075701','SUPREME KIT 9 IN 1 WII CTA'})
AADD(aProdBlq,{'01121441192','DANCE ON BROADWAY (EUR) PS3 UBI'})
AADD(aProdBlq,{'0283120076401','STARTER KI  NDS MEM'})
AADD(aProdBlq,{'0283120078801','PROTECTIVE CASE NDS MEM'})
AADD(aProdBlq,{'0294150078901','PRO EX CONTROLLER  PS3 POWER A'})
AADD(aProdBlq,{'0294150079001','PRO ELITE WIRELESS CONTROLLER  PS3 POWER A'})
AADD(aProdBlq,{'0283160077301','REMOTE SLEEVE WII MEM'})
AADD(aProdBlq,{'0283160077601','RECHARGEALE BATTERY KIT FIT WII MEM'})
AADD(aProdBlq,{'0281160078201','PUSH UP BARS WII CTA'})
AADD(aProdBlq,{'0289120076201','STARTER KIT  PSP ATC'})
AADD(aProdBlq,{'01341440822','THE ELDER SCROLLS V: SKYRIM (EUA) PS3 BET'})
AADD(aProdBlq,{'0283120069301','DELUXE STARTER KIT  NDS MEM'})
AADD(aProdBlq,{'0286120083301','GAME TRAVELER MODELO 251 NDS RDS'})
AADD(aProdBlq,{'0282160081301','KAMA CONTROLLER FOR NUNCHUCK WII  NIK'})
AADD(aProdBlq,{'0298010070501','CONTROLE PLAYSTATION PS1 E COM FIO PS2 VTREX'})
AADD(aProdBlq,{'0287120083901','FITTED JACKET NDS PDP'})
AADD(aProdBlq,{'0286120082601','GAME TRAVELER MODELO XL501 NDS RDS'})
AADD(aProdBlq,{'0287120080401','MINIBACKPACK FOR  NDS PDP'})
AADD(aProdBlq,{'0287120071401','CLUB PENGUIN SYSTEM CASEB PEN NDS  PDP'})
AADD(aProdBlq,{'0281160080601','MASTER EXERCISE KIT WII CTA'})
AADD(aProdBlq,{'0207160080701','MARIO KART WHEEL  WII NIN'})
AADD(aProdBlq,{'0298170070801','CONTROLE DUPLO PARA COMPUTADOR COM VIBRAวรO PC VTREX'})
AADD(aProdBlq,{'01151440762','GENERATOR REX PS3 ACT'})
AADD(aProdBlq,{'01121340785','ASSASSINดS CREED: REVELATIONS SIGNATURE EDITION X360 UBI'})
AADD(aProdBlq,{'01121440785','ASSASSINดS CREED: REVELATIONS SIGNATURE EDITION PS3 UBI'})
AADD(aProdBlq,{'01121341217','MARVEL AVENGERS: BATTLE FOR EARTH UBI X360'})
AADD(aProdBlq,{'01121440814','ASSASSINดS CREED: REVELATIONS PS3 UBI'})
AADD(aProdBlq,{'01171241179','DUNGEON SIEGE THRONE (CAN) PSP T2'})
AADD(aProdBlq,{'01051440793','NEED FOR SPEED: THE RUN  PS3 EA'})
AADD(aProdBlq,{'01101440805','DISNEY UNIVERSE PS3 DISNEY'})
AADD(aProdBlq,{'01101340805','DISNEY UNIVERSE X360 DISNEY'})
AADD(aProdBlq,{'01101540805','DISNEY UNIVERSE  WII DISNEY'})
AADD(aProdBlq,{'01201441012','YAKUZA DEAD SOULS PS3 SEG'})
AADD(aProdBlq,{'0288170090201','ECLIPSE TOUCH MOUSE MAD'})
AADD(aProdBlq,{'0267140090401','EA SPORTS WIRELESS CONTROLLER SILICON SLEEVE SUN'})
AADD(aProdBlq,{'0283160079201','PREMIUM STARTER KIT  WII MEM'})
AADD(aProdBlq,{'01441440800','BATMAN ARKHAM CITY PS3  WAR'})
AADD(aProdBlq,{'0281160069201','DUAL CHARGE STATIOON  WII CTA'})
AADD(aProdBlq,{'01021340972','NINJA GAIDEN 2 X360 TEC (EUR)'})
AADD(aProdBlq,{'01081340973','GEARS OF WAR  X360 MIC (EUR)'})
AADD(aProdBlq,{'01121340758','THE BLACK EYED PEAS EXPERIENCE X360 UBI'})
AADD(aProdBlq,{'01121540758','THE BLACK EYED PEAS EXPERIENCE WII UBI'})
AADD(aProdBlq,{'01041341013','NARUTO SHIPPUDEN: ULTIMATE STORM GENERATIONS REGULAR X360 NAM'})
AADD(aProdBlq,{'01031140901','METAL GEAR SOLID 3D 3DS KON'})
AADD(aProdBlq,{'0281250095901','INFLATABLE CUBE FOR IPAD CTA'})
AADD(aProdBlq,{'0287140093501','ENERGIZER CHARGE STATION X360 PDP'})
AADD(aProdBlq,{'0288150093001','GRIP-IT COM'})
AADD(aProdBlq,{'0288150093101','G155-GAMING AND ENTERTAINMENT MOBILE SYSTEM COM'})
AADD(aProdBlq,{'01061340954','GOD OF WAR III PLATINUM (PORTUGUสS) PS3 SON'})
AADD(aProdBlq,{'01122340917','RAYMAN ORIGINS PSV UBI'})
AADD(aProdBlq,{'01051340930','BATTLEFIELD 3 (EUR) X360 EA'})
AADD(aProdBlq,{'01141340931','ULTIMATE MARVEL VS CAPCOM 3 US X360 CAP'})
AADD(aProdBlq,{'01951640969','HEARTS OF IRON III PC PAR'})
AADD(aProdBlq,{'01081340882','KINECT ADVENTURES X360 (SUE) MIC'})
AADD(aProdBlq,{'01081340867','FORZA MOTORSPORT 2 X360 (EUR) MIC'})
AADD(aProdBlq,{'01121440885','TOM CLANCYดS GHOST RECON: FUTURE SOLDIER PS3 UBI'})
AADD(aProdBlq,{'01121340885','TOM CLANCYดS GHOST RECON: FUTURE SOLDIER X360 UBI'})
AADD(aProdBlq,{'01081340869','HALO 3 CLASSIC X360 (EUR) X360 MIC'})
AADD(aProdBlq,{'01441441149','MORTAL KOMBAT (ESP) PS3 WAR'})
AADD(aProdBlq,{'01012341168','RESISTANCE: BURNING SKIES PSV SON'})
AADD(aProdBlq,{'01011441105','DE BLOB 2 (EUR) PS3 THQ'})
AADD(aProdBlq,{'01122341628','RAYMAN LEGENDS UBI PSV'})
AADD(aProdBlq,{'01122448961','JUST DANCE 4 WIIU UBI'})
AADD(aProdBlq,{'01141448984','CAPCOM ESSENTIALS PS3 CAP'})
AADD(aProdBlq,{'01051348981','FIFA 14 X360 EA'})
AADD(aProdBlq,{'01061441131','MOTORSTORM PACIFIC RIFT PLATINUM (EUR) PS3 SON'})
AADD(aProdBlq,{'01051441099','MIRRORดS EDGE (EUR) PS3 EA'})
AADD(aProdBlq,{'0267250088101','SNAKEBYTE PS3 MOVE SHOOTER SUN'})
AADD(aProdBlq,{'01311441159','DEUS EX: HUMAN REVOLUTION (EUR) PS3 SQU'})
AADD(aProdBlq,{'0267250088401','SNAKEBYTE PS3 WIRELESS CONTROLLER SUN'})
AADD(aProdBlq,{'0267250088501','SNAKEBYTE PS3 WIRED CONTROLLER SUN'})
AADD(aProdBlq,{'0267250088601','EA SPORTS REMOTE XL BLUE-WHITE-RED SUN'})
AADD(aProdBlq,{'0267250088801','SNAKEBYTE WII MINIMOTE - BLUE SUN'})
AADD(aProdBlq,{'0267250088901','SNAKEBYTE WII PREMIUM REMOTE XL - WHITE SUN'})
AADD(aProdBlq,{'0267250089001','SNAKEBYTE WII REMOTE XS CONTROLLER - PINK  SUN'})
AADD(aProdBlq,{'0267250089301','FINAL FANTASY PC FFXIV ONLINE USB GAME CONTROLLER SUN'})
AADD(aProdBlq,{'01032248959','CASTLEVANIA LORDS OF SHADOW (LATAM) 3DS KON'})
AADD(aProdBlq,{'01141441097','LOST PLANET 2 (EUR) PS3 CAP'})
AADD(aProdBlq,{'01011441090','UFC PERSONAL TRAINER COM LEG STRAP (EUR) PS3 THQ'})
AADD(aProdBlq,{'01421441088','MADAGASCAR 3: THE GAME PS3 D3'})
AADD(aProdBlq,{'0306110006301','BUNDLE PSP (GRAN TURISMO + LITTLE BIG PLANET)'})
AADD(aProdBlq,{'0405090026901','FIFA SOCCER 13 GAMER KIT PS3'})
AADD(aProdBlq,{'01151441606','CALL OF DUTY BLACK OPS (ESP) PS3 ACT'})
AADD(aProdBlq,{'01051441679','FIFA 12 (EUR) PS3'})
AADD(aProdBlq,{'01121147795','THE SMURFS 2 UBI NDS'})
AADD(aProdBlq,{'01041447739','DEFIANCE PS3 NAM'})
AADD(aProdBlq,{'01041347739','DEFIANCE X360 NAM'})
AADD(aProdBlq,{'01971447738','SNIPER ELITE V2 - SILVER STAR EDITION PS3 505'})
AADD(aProdBlq,{'01121448946','TOM CLANCY`S SPLINTER CELL: BLACKLIST SIGNATURE EDITION (VERSรO EM PORTUGUสS) UBI PS3'})
AADD(aProdBlq,{'01121348946','TOM CLANCYดS SPLINTER CELL: BLACKLIST SIGNATURE EDITION (VERSรO EM PORTUGUสS) UBI X360'})
AADD(aProdBlq,{'01121348977','RAYMAN LEGENDS (VERSรO EM PORTUGUสS) UBI X360'})
AADD(aProdBlq,{'01051448909','NEED FOR SPEED UNDERCOVER (LATAM) PS3 EA'})
AADD(aProdBlq,{'01121349008','JUST DANCE KIDS 2014 (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01122549012','WATCH DOGS (VERSรO EM PORTUGUสS) PS4 UBI'})
AADD(aProdBlq,{'01122649012','WATCH DOGS (VERSรO EM PORTUGUสS) XONE UBI'})
AADD(aProdBlq,{'01122549014','WATCH DOGS SIGNATURE EDITION (VERSรO EM PORTUGUสS) PS4 UBI'})
AADD(aProdBlq,{'01122649014','WATCH DOGS SIGNATURE EDITION (VERSรO EM PORTUGUสS) XONE UBI'})
AADD(aProdBlq,{'0317180008601','CELULAR BLU SPARK TV BLUE'})
AADD(aProdBlq,{'01121349003','ASSASSIN`S  CREED IV: BLACK FLAG SIGNATURE EDITION (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01121449004','ASSASSIN`S  CREED IV: BLACK FLAG LIMITED EDITION PS3 UBI'})
AADD(aProdBlq,{'01121349004','ASSASSIN`S  CREED IV: BLACK FLAG LIMITED EDITION X360 UBI'})
AADD(aProdBlq,{'01121648999','ASSASSIN`S  CREED IV: BLACK FLAG PC UBI'})
AADD(aProdBlq,{'01121649011','WATCH DOGS PC UBI'})
AADD(aProdBlq,{'0317180007201','CELULAR BLU SAMBA JR Q53 RED'})
AADD(aProdBlq,{'01121347724','ASSASSINS CREED: EZIO TRILOGY (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01122649000','ASSASSIN`S  CREED IV: BLACK FLAG (VERSรO EM PORTUGUสS) XONE UBI'})
AADD(aProdBlq,{'01121449003','ASSASSIN`S  CREED IV: BLACK FLAG SIGNATURE EDITION (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01121449017','SOUTH PARK STICK OF TRUTH (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'0317180009701','SMARTPHONE BLU VIVO 4.3 D910I WHITE'})
AADD(aProdBlq,{'01051449034','FIFA 14 (ESP) PS3 EA'})
AADD(aProdBlq,{'01051349034','FIFA 14 (ESP) X360 EA'})
AADD(aProdBlq,{'01121449019','SOUTH PARK STICK OF TRUTH SIGNATURE EDITION (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01121349019','SOUTH PARK STICK OF TRUTH SIGNATURE EDITION (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01122549005','ASSASSIN`S  CREED IV: BLACK FLAG LIMITED EDITION PS4 UBI'})
AADD(aProdBlq,{'01121349020','SOUTH PARK STICK OF TRUTH GRAND WIZARD EDITION X360 UBI'})
AADD(aProdBlq,{'01031348987','PRO EVOLUTION SOCCER 2014 (BR) X360 KON'})
AADD(aProdBlq,{'01121348995','JUST DANCE 2014 X360 UBI'})
AADD(aProdBlq,{'01121449014','WATCH DOGS SIGNATURE EDITION (VERSรO EM PORTUGUสS) PS3 UBI'})
AADD(aProdBlq,{'01121349014','WATCH DOGS SIGNATURE EDITION (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'01121348997','ROCKSMITH 2014 X360 UBI'})
AADD(aProdBlq,{'01211349060','ZUMBA FITNESS WORLD PARTY X360 MAJ'})
AADD(aProdBlq,{'01211349061','ZUMBA KIDS X360 MAJ'})
AADD(aProdBlq,{'01121449052','ASSASSIN`S CREED IV: BLACK FLAG LIMITED EDITION SIGNATURE PS3 UBI'})
AADD(aProdBlq,{'0317180112215','SMARTPHONE BLU DASH 4.0 D270I WHITE'})
AADD(aProdBlq,{'01121349052','ASSASSIN`S CREED IV: BLACK FLAG LIMITED EDITION SIGNATURE X360 UBI'})
AADD(aProdBlq,{'0317180010815','SMARTPHONE BLU STUDIO 5.0 D530 ANATEL/GENERIC DUAL SIM 3G WHITE'})
AADD(aProdBlq,{'01331349082','F1 2013 (PTBR) X360'})
AADD(aProdBlq,{'0317180011118','SMARTPHONE BLU LIFE PLAY L100I QBAND DUAL SIM 3G 850/2100 PINK'})
AADD(aProdBlq,{'01151349104','CALL OF DUTY GHOSTS (BRA) X360 ACT'})
AADD(aProdBlq,{'01231349113','STAR WARS THE FORCE UNLEASHED II (DISNEY) X360 DIS'})
AADD(aProdBlq,{'01442249054','BATMAN ARKHAM ORIGINS BLACKGATE 3DS WAR'})
AADD(aProdBlq,{'01021349050','YAIBA: NINJA GAIDEN Z X360 TEC'})
AADD(aProdBlq,{'01231349116','LEGO STAR WARS THE COMPLETE SAGA (DISNEY) X360 DIS'})
AADD(aProdBlq,{'01051449220','NEED FOR SPEED THE RUN (LATAM) PS3 EA'})
AADD(aProdBlq,{'01972649237','SNIPER ELITE 3 COLLECTORS EDITION XONE 505'})
AADD(aProdBlq,{'01122449184','JUST DANCE KIDS 2014 (USA) WIIU UBI'})
AADD(aProdBlq,{'01122548996','JUST DANCE 2014 (VERSรO EM PORTUGUสS) PS4 UBI'})
AADD(aProdBlq,{'0308260113202','CONSOLE XBOX ONE 500 GB MIC'})
AADD(aProdBlq,{'01031349192','CASTLEVANIA: LORDS OF SHADOW 2 (BRA) X360 KON'})
AADD(aProdBlq,{'01212449059','BARBIE DREAMHOUSE PARTY WIIU MAJ'})
AADD(aProdBlq,{'01022349146','DECEPTION IV: BLOOD TIES PSV TEC'})
AADD(aProdBlq,{'01151449076','CALL OF DUTY GHOSTS PS3 ACT'})
AADD(aProdBlq,{'01022349218','DYNASTY WARRIORS 8 XTREME LEGENDS COMPLETE EDITION PSV TEC'})
AADD(aProdBlq,{'0317180113622','SMARTPHONE BLU DASH JR D140X BLUE'})
AADD(aProdBlq,{'01031349067','CASTLEVANIA: LORDS OF SHADOWS COLLECTION X360 KON'})
AADD(aProdBlq,{'01021449239','DYNASTY WARRIORS 8 XTREME LEGENDS PS3 TEC'})
AADD(aProdBlq,{'01061349313','EVERYBODY DANCE PS3 SON'})
AADD(aProdBlq,{'0323270114402','TABLET ZAGG Z - 7 POLEGADAS'})
AADD(aProdBlq,{'01051449267','COPA DO MUNDO DA FIFA BRASIL 2014 BR PS3 EA'})
AADD(aProdBlq,{'0214180127608','FONE DE OUVIDO INTRAAURICULAR ROSA SHE2100PK/28 PHILIPS'})
AADD(aProdBlq,{'01011349243','RESIDENT EVIL 6 (BRA) X360 CAP'})
AADD(aProdBlq,{'0214180127405','FONE DE OUVIDO DJ BRANCO SHL3000WT/00 PHILIPS'})
AADD(aProdBlq,{'0214180128501','FONE DE OUVIDO HEADBAND SHP2000/10 PHILIPS'})
AADD(aProdBlq,{'0214180128101','HEADSET PARA JOGOS NO PC SHG7210/10 PHILIPS'})
AADD(aProdBlq,{'0271250126201','BONECO UFC QUINTON JACKSON ULTIMATE COLLECTOR SERIE B'})
AADD(aProdBlq,{'0271250126501','BONECO UFC ANTONIO NOGUEIRA ULTIMATE COLLECTOR SERIE B'})
AADD(aProdBlq,{'0271250126601','BONECO UFC MAURICIO RUA ULTIMATE COLLECTOR SERIE A'})
AADD(aProdBlq,{'0271250126801','BONECO UFC ROYCE GRACIE ULTIMATE COLLECTOR SERIE B'})
AADD(aProdBlq,{'0214180127603','FONE DE OUVIDO INTRAAURICULAR AZUL SHE2100BL/28 PHILIPS'})
AADD(aProdBlq,{'0214180128205','FONE DE OUVIDO COM GANCHO BRANCO SHS3201/10 PHILIPS'})
AADD(aProdBlq,{'0214180128601','HEADSET PARA JOGOS NO PC SHG7980/10 PHILIPS'})
AADD(aProdBlq,{'01121349297','FAR CRY COMPILATION (VERSรO EM PORTUGUสS) X360 UBI'})
AADD(aProdBlq,{'0317180114227','CELULAR BLU JENNY TV 2.8 T176T BLACK-RED'})
AADD(aProdBlq,{'0306200005802','PLAYSTATION VITA WI-FI (LATAM) PSV SON'})
AADD(aProdBlq,{'01221441364','DRAGONS CROWN PS3 ATL'})
AADD(aProdBlq,{'0418090024701','GUITAR HERO 5 (COM GUITARRA) PS3 ACT'})
AADD(aProdBlq,{'01341341664','FALLOUT 3 PLATINUM HITS (ENGLISH) X360 BET'})
AADD(aProdBlq,{'01201341634','SONIC & ALL STAR RACING TRANSFORMED BONUS EDITION (PTBR) X360 SEGA'})
AADD(aProdBlq,{'01201341635','SONIC & ALL STAR RACING TRANSFORMED BONUS EDITION (ESP) X360 SEGA'})
AADD(aProdBlq,{'01201441635','SONIC & ALL STAR RACING TRANSFORMED BONUS EDITION (ESP) PS3 SEGA'})
AADD(aProdBlq,{'01441441162','F.E.A.R. 3 (ESP) PS3 WAR'})
AADD(aProdBlq,{'0245140091901','MICROCON RACING WHEEL MAD'})
AADD(aProdBlq,{'01441341139','MORTAL KOMBAT (EUR) X360 WAR'})
AADD(aProdBlq,{'01971340998','TOP GUN HARDLOCK X360 505'})
AADD(aProdBlq,{'01221141088','MADAGASCAR 3: THE GAME NDS D3'})
AADD(aProdBlq,{'01441341140','GREEN LANTERN: RISE OF THE MANHUNTERS (EUR) X360 WAR'})
AADD(aProdBlq,{'0281250095501','IPHONE 4 / IPAD RADIATION SAFE TELEPHONE HANDSET WHITE CTA'})
AADD(aProdBlq,{'0254250091201','MICRO REMOTE AND HDMI CABLE BUNDLE'})
AADD(aProdBlq,{'0265250091301','MOVE/KINECT CAMERA MOUNT'})
AADD(aProdBlq,{'0267010090801','SNAKEBYTE PS2 WIRELESS CONTROLLER 2.4G SUN'})
AADD(aProdBlq,{'0293250097601','FRUIT NINJA – 2.5 – MINI PLUSH WITH BOMB JAZ'})
AADD(aProdBlq,{'01341441031','THE ELDER SCROLLS V: SKYRIM (ESP) PS3 BET'})
AADD(aProdBlq,{'0293250097801','FRUIT NINJA – 2.5 – MINI PLUSH WITH ORANGE JAZ'})
AADD(aProdBlq,{'0206150105901','DUALSHOCK 3 WIRELESS CONTROLLER (LATAM) PS3 SON'})
AADD(aProdBlq,{'0267160090501','SNAKEBYTE WII MOTION XS CONTROLLER - WHITE SUN'})
AADD(aProdBlq,{'0267160090601','SNAKEBYTE WII REMOTE XS CONTROLLER - WHITE SUN'})
AADD(aProdBlq,{'0267010090701','SNAKEBYTE PS2 WIRED CONTROLLER - BLACK SUN'})
AADD(aProdBlq,{'01331441094','OPERATION FLASHPOINT RED RIVER (EUR) PS3 COD'})
AADD(aProdBlq,{'01311441157','STAR OCEAN: THE LAST HOPE INTERNATIONAL (EUR) PS3 SQU'})
AADD(aProdBlq,{'01171440839','THE DARKNESS II: LIMITED EDITION PS3 T2'})
AADD(aProdBlq,{'01341640888','FALLOUT: NEW VEGAS - UTIMATE EDITION PC BET'})
AADD(aProdBlq,{'01191440855','HITMAN ABSOLUTION PS3 EID'})
AADD(aProdBlq,{'0297120073901','23 IN 1 KIT XL NDS  EAGLE'})
AADD(aProdBlq,{'0297160076501','SPORTS RESORT PACK WII'})
AADD(aProdBlq,{'0281130073601','9 IN 1 KIT FOR GO  PSP  CTA'})
AADD(aProdBlq,{'0297120075001','UNIVERSAL POWERKIT NDS EAGLE'})
AADD(aProdBlq,{'0287160076301','STARTER KIT NERF WII EAGLE'})
AADD(aProdBlq,{'0287160075401','TOY STORY 3 REMOTE LABELS WII PDP'})
AADD(aProdBlq,{'01170100093','GRAND THEFT AUTO: VICE CITY PS2 T2'})
AADD(aProdBlq,{'01170100132','MAX PAYNE PS2 T2'})
AADD(aProdBlq,{'01170100917','GRAND THEFT AUTO: SAN ANDREAS PS2 T2'})
AADD(aProdBlq,{'01170101069','MIDNIGHT CLUB 3: DUB EDITION REMIX PS2 T2'})
AADD(aProdBlq,{'01170100211','SMUGGLER`S RUN 2 PS2 TAK'})
AADD(aProdBlq,{'01191103089','MINI NINJAS NDS WAR'})
AADD(aProdBlq,{'01191503089','MINI NINJAS WII EID'})
AADD(aProdBlq,{'01200102056','IRON MAN PS2 SEG'})
AADD(aProdBlq,{'01191403089','MINI NINJAS PS3 EID'})
AADD(aProdBlq,{'01171203196','GRAND THEFT AUTO: CHINATOWN WARS PSP T2'})
AADD(aProdBlq,{'01171203655','NBA 2K11 PSP T2'})
AADD(aProdBlq,{'01171302004','BULLY: SCHOLARSHIP EDITION X360 T2'})
AADD(aProdBlq,{'01171303396','GRAND THEFT AUTO: EPISODES FROM LIBERTY CITY X360 T2'})
AADD(aProdBlq,{'01171403535','RED DEAD REDEMPTION  PS3 T2'})
AADD(aProdBlq,{'01171403571','GRAND THEFT AUTO: EPISODES FROM LIBERTY CITY PS3 TAK'})
AADD(aProdBlq,{'01171503655','NBA 2K11 WII TAK'})
AADD(aProdBlq,{'01171501480','ROCKSTAR GAMES PRESENTS TABLE TENNIS WII T2'})
AADD(aProdBlq,{'01171503740','NEW CARNIVAL GAMES WII T2'})
AADD(aProdBlq,{'01171401634','BIOSHOCK PS3 T2'})
AADD(aProdBlq,{'01171602334','GRAND THEFT AUTO IV PC T2'})
AADD(aProdBlq,{'01171603667','SID MEIERดS CIVILIZATION IV: BEYOND THE SWORD PC T2'})
AADD(aProdBlq,{'01171403137','BORDERLANDS PS3 T2'})
AADD(aProdBlq,{'01170101110','GRAND THEFT AUTO: LIBERTY CITY STORIES PS2 T2'})
AADD(aProdBlq,{'01170101265','BULLY PS2 T2'})
AADD(aProdBlq,{'01170102639','MIDNIGHT CLUB: STREET RACING PS2 T2'})
AADD(aProdBlq,{'01170101337','GRAND THEFT AUTO: VICE CITY STORIES PS2 T2'})
AADD(aProdBlq,{'01170101520','GHOST RIDER PS2 T2'})
AADD(aProdBlq,{'01171201069','MIDNIGHT CLUB 3: DUB EDITION PSP T2'})
AADD(aProdBlq,{'01171201110','GRAND THEFT AUTO: LIBERTY CITY STORIES PSP T2'})
AADD(aProdBlq,{'01221103860','NARUTO SHIPPUDEN: NARUTO VS. SASUKE DS TOM'})
AADD(aProdBlq,{'01231201195','LEGO STAR WARS II: THE ORIGINAL TRILOGY PSP DIS'})
AADD(aProdBlq,{'01231302075','LEGO INDIANA JONES: THE ORIGINAL ADVENTURES X360 DIS'})
AADD(aProdBlq,{'01221402212','DISGAEA 3: ABSENCE OF JUSTICE PS3 NIS'})
AADD(aProdBlq,{'01211101283','AGE OF EMPIRE KINGS NDS MAJ'})
AADD(aProdBlq,{'01201303417','ALIENS VS. PREDATOR X360 SEG'})
AADD(aProdBlq,{'01201303421','SONIC & SEGA ALL-STARS RACING X360 SEG'})
AADD(aProdBlq,{'01201502803','SONIC AND THE BLACK KNIGHT WII SEG'})
AADD(aProdBlq,{'01201303583','SEGA SUPERSTARS TENNIS + LIVE ARCADE COMPILATION X360 SEGA/MIC'})
AADD(aProdBlq,{'01201403573','IRON MAN 2 PS3 SEG'})
AADD(aProdBlq,{'01201403748','VANQUISH PS3 SEG'})
AADD(aProdBlq,{'01201503349','PLANET 51 WII SEG'})
AADD(aProdBlq,{'01201501853','MARIO & SONIC AT THE OLYMPIC GAMES WII SEG'})
AADD(aProdBlq,{'01201402808','STORMRISE PS3 SEG'})
AADD(aProdBlq,{'01201103421','SONIC & SEGA ALL-STARS RACING NDS SEG'})
AADD(aProdBlq,{'01311502017','FINAL FANTASY CRYSTAL CHRONICLES: THE CRYSTAL BEARERS WII SQU'})
AADD(aProdBlq,{'01311602176','JUST CAUSE 2 PC SQU'})
AADD(aProdBlq,{'01331102074','GRID NDS COD'})
AADD(aProdBlq,{'01331402701','DAMNATION PS3 COD'})
AADD(aProdBlq,{'01331602074','GRID PC COD'})
AADD(aProdBlq,{'01331203259','DIRT 2 PSP COD'})
AADD(aProdBlq,{'01331301976','TURNING POINT: FALL OF LIBERTY X360 COD'})
AADD(aProdBlq,{'01311101851','FINAL FANTASY XII REVENAN NDS SQU'})
AADD(aProdBlq,{'01281201568','MORTAL KOMBAT: UNCHAINED PSP MID'})
AADD(aProdBlq,{'01280100144','MORTAL KOMBAT 5 DEADLY ALLIANCE PS2 MID'})
AADD(aProdBlq,{'01280100892','MORTAL KOMBAT: DECEPTION PS2 MID'})
AADD(aProdBlq,{'01231503061','STAR WARS THE CLONE WARS: REPUBLIC HEROES WII DIS'})
AADD(aProdBlq,{'01231403395','LEGO INDIANA JONES 2: THE ADVENTURE CONTINUES PS3 DIS'})
AADD(aProdBlq,{'01481403845','GRID PLATINUM PS3 SPK'})
AADD(aProdBlq,{'01481602472','X-BLADES PC STPK'})
AADD(aProdBlq,{'01481603016','SECTION 8 PC STPK'})
AADD(aProdBlq,{'01481603506','LEGENDARY PC SPK'})
AADD(aProdBlq,{'01691603682','TRINE PC STPK'})
AADD(aProdBlq,{'01341403730','FALLOUT: NEW VEGAS PS3 BET'})
AADD(aProdBlq,{'01391201649','HARVEST MOON: BOY & GIRL PSP NAT'})
AADD(aProdBlq,{'01421201857','BEN 10: PROTECTOR OF EARTH PSP D3'})
AADD(aProdBlq,{'01421302033','DARK SECTOR X360 D3'})
AADD(aProdBlq,{'01421402033','DARK SECTOR PS3 D3'})
AADD(aProdBlq,{'01421403693','BEN 10 ULTIMATE ALIEN: COSMIC DESTRUCTION PS3 D3'})
AADD(aProdBlq,{'01440103778','SCOOBY-DOO! AND THE SPOOKY SWAMP PS2 WAR'})
AADD(aProdBlq,{'01341603372','FALLOUT 3: GAME OF THE YEAR EDITION PC BET'})
AADD(aProdBlq,{'01341302211','FALLOUT 3 X360 BET'})
AADD(aProdBlq,{'01420101857','BEN 10 PROTECTOR OF EARTH  PS2 D3'})
AADD(aProdBlq,{'01341303372','FALLOUT 3: GAME OF THE YEAR EDITION X360 BET'})
AADD(aProdBlq,{'01420102522','BEN 10: ALIEN FORCE - THE GAME PS2 D3'})
AADD(aProdBlq,{'01420103140','ASTRO BOY: THE VIDEO GAME   PS2 D3'})
AADD(aProdBlq,{'01341402211','FALLOUT 3 PS3 BET'})
AADD(aProdBlq,{'0207160012701','POWER GRIP ADVANCE . WII NINTENDO'})
AADD(aProdBlq,{'0207160013301','WII REMOTE(CONTROLE) WII NIN'})
AADD(aProdBlq,{'0235010001301','GAME SHARK . PS2 INTERACT'})
AADD(aProdBlq,{'0207120019801','FONE DE OUVIDO MAXELL'})
AADD(aProdBlq,{'0207060000301','CABO LINK . GB NINTENDO'})
AADD(aProdBlq,{'01801303044','THE BEATLES: ROCK BAND X360 EA'})
AADD(aProdBlq,{'01801403044','THE BEATLES: ROCK BAND PS3 EA'})
AADD(aProdBlq,{'0280180033401','PEN DRIVE DO IRON MAN 2 FUNKO'})
AADD(aProdBlq,{'0281120035701','JUMBO TOUCH PEN SET DS CTA'})
AADD(aProdBlq,{'0283200037801','ESTOJO ACRอLICO DE PROTEวรO PARA DSI'})
AADD(aProdBlq,{'0281160035301','MULTIFUNCTION CARRY BAG WII CTA'})
AADD(aProdBlq,{'0281160035501','COMPONENT CABLE WII CTA'})
AADD(aProdBlq,{'0283200038001','KIT COM ESTOJO E ACESSำRIOS PARA DSI  MEMOREX'})
AADD(aProdBlq,{'0306110004201','CONSOLE PSP (NACIONAL) SONY'})
AADD(aProdBlq,{'0282150036801','CHARGE BASE 2 FOR PS3 NYKO'})
AADD(aProdBlq,{'0282150037001','INTERCOOLER SLIM FOR PS3 NYKO'})
AADD(aProdBlq,{'0282160036001','NINTENDO WII CHARGE STATION NYKO'})
AADD(aProdBlq,{'0283160037101','KIT COM 3 VOLANTES PARA WII MEMOREX'})
AADD(aProdBlq,{'0307030000604','GAME BOY ADVANCE SP PRATA NINTENDO'})
AADD(aProdBlq,{'0283160037106','VOLANTE PARA WII (AZUL) MEMOREX'})
AADD(aProdBlq,{'0283160037110','VOLANTE PARA WII (VERMELHO) MEMOREX'})
AADD(aProdBlq,{'0283160037201','BARRA SENSORA WIRELESS PARA WII MEMOREX'})
AADD(aProdBlq,{'0283160037608','CAPA DE SILICONE PARA CONTROLE DO WII COM MOTION PLUS E NUNCHUK (ROSA) MEMOREX'})
AADD(aProdBlq,{'0306010004801','AP SONY PS2 CONSOLE PS2 PRATA'})
AADD(aProdBlq,{'0269140019901','THE BEATLES: ROCK BAND WIRELESS GRETSCH GUITAR (SO GUITARRA DO GEORGE HARRISON) X360 EA'})
AADD(aProdBlq,{'0249010009101','THUNDER CHIP . PS2 VTEC'})
AADD(aProdBlq,{'0418090019701','TONY HAWK: SHRED (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418100018101','DJ HERO 2 (PARTY BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0421080009301','EA SPORTS ACTIVE (KIT) WII EA'})
AADD(aProdBlq,{'0423090017601','MAFIA II COLLECTORดS EDITION PS3 T2'})
AADD(aProdBlq,{'0423100015701','BIOSHOCK 2 SPECIAL EDITION X360 T2'})
AADD(aProdBlq,{'0424090008401','BATMAN: ARKHAM ASYLUM COLLECTORดS EDITION PS3 WAR'})
AADD(aProdBlq,{'0427080016601','ATV QUAD KINGS (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0427080016901','GLACIER 3 THE MELTDOWN (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0427080017001','JEEP THRILLS (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0501010003911','YU-GI-OH! ASCENCAO DO DESTINO CX C/24 BOOSTER (PORT)'})
AADD(aProdBlq,{'0501010003923','YU-GI-OH! ASCENCAO DO DESTINO CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0427080017101','MONSTER TRUCKS MAYHEM (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0427080017201','SPEED (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0501010000632','YU-GI-OH! STARTER DECK YUGI/KAIBA CX C/10 DECK (ING)'})
AADD(aProdBlq,{'0501010000636','YU-GI-OH! YUGI & KAIBA DECK UN'})
AADD(aProdBlq,{'0427080018201','FORD RACING: OFF ROAD (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0501010004023','YU-GI-OH! ETERNIDADE FLAMEJANTE CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0427080019901','KEVIN VAN DAMดS BIG BASS CHALLENGE (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'0501010004123','YU-GI-OH! REVELACAO NEGRA VOLUME 1 CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0501010004342','YU-GI-OH! ASCENCAO DO DESTINO EDICAO ESPECIAL CX C/10 DECK (PORT)'})
AADD(aProdBlq,{'0429090020501','DEAD RISING 2 COLLECTORดS EDITION PS3 CAP'})
AADD(aProdBlq,{'0501010001332','YU-GI-OH! JOEY & PEGASUS (PORT) DECK CX C/ 10'})
AADD(aProdBlq,{'0501010004536','YU-GI-OH! DECK INICIAL JOEY/PEGASUS CX C/10 DECK (PORT)'})
AADD(aProdBlq,{'0501010003132','YU-GI-OH! DECK INICIAL YUGI/KAIBA EVOLUCAO CX C/10 DECK (PORT)'})
AADD(aProdBlq,{'0501010003211','YU-GI-OH! PREDADORES METALICOS CX C/24 BOOSTER (PORT)'})
AADD(aProdBlq,{'0432080019401','KART INFLมVEL COM VOLANTE WII CTA'})
AADD(aProdBlq,{'0501010005423','YU-GI-OH! REVOLUCAO CIBERNETICA CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0433120019501','KANE & LYNCH 2: DOG DAYS (KIT) PC SQU'})
AADD(aProdBlq,{'0501010003323','YU-GI-OH! ALMA DO DUELISTA CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0501010004823','YU-GI-OH! O MILENIO PERDIDO CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0501010004932','YU-GI-OH! DECK ESTRUTURA - CHAMA DE DESTRUICAO/FURIA DAS PROFUNDIDADES CX C/10 DECK (PORT)'})
AADD(aProdBlq,{'0501010004936','YU-GI-OH! ESTRUTURA CHAMA E FURIA DECK UN'})
AADD(aProdBlq,{'0501010003611','YU-GI-OH! A LENDA DO DRAGAO BRANCO DE OLHOS AZUIS CX C/24 BOOSTER (PORT)'})
AADD(aProdBlq,{'0501010005911','YU-GI-OH! FORCE OF THE BREAKER CX C/24 BOOSTER (ING)'})
AADD(aProdBlq,{'0501010000232','YU-GI-OH! STARTER DECK JOEY/PEGASUS CX C/10 DECK (ING)'})
AADD(aProdBlq,{'0501010003732','YU-GI-OH! DECK ESTRUTURA RUGIDO DO DRAGAO/ INSANIDADE ZUMBI CX C/10 DECK (PORT)'})
AADD(aProdBlq,{'0501010005032','YU-GI-OH! O MILENIO PERDIDO EDICAO ESPECIAL CX C/10 DECK (PORT)'})
AADD(aProdBlq,{'0418090005401','GUITAR HERO WORLD TOUR (SUPER BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418100005301','GUITAR HERO WORLD TOUR (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418100005401','GUITAR HERO WORLD TOUR (SUPER BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418100010301','GUITAR HERO 5 (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418090011201','DJ HERO (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418100011201','DJ HERO (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418110012701','BAND HERO (SUPER BUNDLE) NDS ACT'})
AADD(aProdBlq,{'0418090012601','GUITAR HERO III: LEGENDS OF ROCK (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418090012701','BAND HERO (SUPER BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418100011801','TONY HAWK: RIDE (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418100012301','GUITAR HERO: AEROSMITH SPECIAL EDITION (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418100012401','GUITAR HERO III: LEGENDS OF ROCK (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418090017401','GUITAR HERO WARRIORS OF ROCK (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418090017501','GUITAR HERO: WARRIORS OF ROCK (SUPER BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418090017701','RAPALA PRO BASS FISHING 2010 (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418100012701','BAND HERO (SUPER BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418090017901','CABELAดS DANGEROUS HUNTS 2011 (BUNDLE) PS3 ACT'})
AADD(aProdBlq,{'0418100017401','GUITAR HERO WARRIORS OF ROCK (BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0418100017501','GUITAR HERO: WARRIORS OF ROCK (SUPER BUNDLE) X360 ACT'})
AADD(aProdBlq,{'0307150004301','CONSOLE X360 (NACIONAL) MICROSOFT'})
AADD(aProdBlq,{'0407080007401','WII PLAY (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0407080007501','WII FIT (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0407110014011','KIT NINTENDO DSI EVA SLEEVE BLUE NDS NIN'})
AADD(aProdBlq,{'0418010011201','DJ HERO (BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0418010012301','GUITAR HERO AEROSMITH (BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0418010012701','BAND HERO (SUPER BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0418080005401','GUITAR HERO WORLD TOUR (SUPER BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418080005501','GUITAR HERO WORLD TOUR (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418080010201','RAPALA WE FISH (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0416080020801','KARAOKE REVOLUTION GLEE (BUNDLE) WII KON'})
AADD(aProdBlq,{'0418080010301','GUITAR HERO 5 (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418080011601','DJ HERO RENEGADE EDITION (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0414090020001','DISNEY SING IT: PARTY HITS (BUNDLE) PS3 DIS'})
AADD(aProdBlq,{'0416090004401','ROCK REVOLUTION (BUNDLE) PS3 KON'})
AADD(aProdBlq,{'0418080011801','TONY HAWK: RIDE (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418080012001','GUITAR HERO III: LEGENDS OF ROCK (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418080018301','GUITAR HERO WARRIORS OF ROCK (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418080018401','GUITAR HERO: WARRIORS OF ROCK (SUPER BUNDLE) WII ACT'})
AADD(aProdBlq,{'0415080020201','ACTIVE LIFE: EXPLORER (BUNDLE) WII NAM'})
AADD(aProdBlq,{'0416100012801','KARAOKE REVOLUTION 2009 (BUNDLE) X360 KON'})
AADD(aProdBlq,{'0418080018001','DJ HERO 2 (BUNDLE) WII ACT'})
AADD(aProdBlq,{'0418010005301','GUITAR HERO WORLD TOUR (BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0418010005401','GUITAR HERO WORLD TOUR (SUPER BUNDLE) PS2 ACT'})
AADD(aProdBlq,{'0407080013001','WII FIT PLUS (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0307100003401','NINTENDO DSI PRETO'})
AADD(aProdBlq,{'0407080006501','WII ZAPPER (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0501010007736','YU-GI-OH! DECK INICIAL DO JOEY DECK UPPER DECK CARD'})
AADD(aProdBlq,{'0501060008636','SPIDERMAN VS DOC OCK DECK PARA 2 JOGADORES DECK UPPER DECK CARD'})
AADD(aProdBlq,{'0501010008246','YU-GI-OH! PREDADORES METALICOS PACK UPPERDECK CARD'})
AADD(aProdBlq,{'0501010006319','YU-GI-OH! DUELIST PACK - JADEN YUKI 2 CX C/30 BOOSTER (ING)'})
AADD(aProdBlq,{'0501010008436','YU-GI-OH! ASCENCAO DO DESTINO DECK UPPER DECK CARD'})
AADD(aProdBlq,{'0501050004223','E-CARD DC COMICS ORIGINS BLISTER CX C/ 20'})
AADD(aProdBlq,{'0507070009116','YU-GI-OH! LABIRINTH OF NIGHTMARES CX C/36 BOOSTER (ING)'})
AADD(aProdBlq,{'0507110009316','CARD IMPORTWAY RAGE THE WEREWOLF - THE APOCALIPSETRADING BOOSTER'})
AADD(aProdBlq,{'0507110009416','CARD IMPORTWAY RAGE LIMITED EDITION SUPPLEMENT THE WYRM BOOSTER'})
AADD(aProdBlq,{'0507110009551','RAGE - THE WEREWOLF CX C/24 BOOSTER (ING)'})
AADD(aProdBlq,{'0507110009651','THE WYRM LIMITED EDITION CX C/24 BOOSTER (ING)'})
AADD(aProdBlq,{'0501060003523','VS SYSTEM MARVEL ORIGINS CX C/20 BLISTER (PORT)'})
AADD(aProdBlq,{'0501060003838','VS SYSTEM DC BATMAN VS. O JOKER CX C/6 DECK (PORT)'})
AADD(aProdBlq,{'0501010007111','YU-GI-OH! THE DARK EMPEROR STRUCTURE DECK CX C/8 DECK (ING)'})
AADD(aProdBlq,{'0501060008536','BATMAN VS O JOKER DECK PARA 2 JOGADORES DECK UPPER DECK CARD'})
AADD(aProdBlq,{'0501010007536','YU-GI-OH! O MILENIO PERDIDO EDICAO ESPECIAL DECK UPPER DECK CARD'})
AADD(aProdBlq,{'0418080021701','MONSTER JAM: PATH OF DESTRUCTION (BUNDLE) WII ACT'})
AADD(aProdBlq,{'01461503800','KEVIN VAN DAMดS BIG BASS CHALLENGE WII ZOO'})
AADD(aProdBlq,{'0423090021201','GRAND THEFT AUTO IV: THE COMPLETE EDITION PS3 T2'})
AADD(aProdBlq,{'0423100021201','GRAND THEFT AUTO IV: THE COMPLETE EDITION X360 T2'})
AADD(aProdBlq,{'0421080021401','FLINGMASH (BUNDLE) WII NIN'})
AADD(aProdBlq,{'0285240045311','DSI UTILITY CASE ORANGE (ESTOJO PARA DSI LARANJA) LAT'})
AADD(aProdBlq,{'0427080022501','PIRATE BLAST (BUNDLE) WII ZOO'})
AADD(aProdBlq,{'01171403978','TOP SPIN 4 PS3 T2'})
AADD(aProdBlq,{'01171303978','TOP SPIN 4 X360 T2'})
AADD(aProdBlq,{'0286120047602','GAMETRAVELLER - ESTOJO PARA NINTENDO DS BRANCO COM PERSONAGENS DO MARIO DS RDS'})
AADD(aProdBlq,{'01421104002','BEN 10: ALIEN FORCE - THE GAME DS D3'})
AADD(aProdBlq,{'01201104004','MARIO & SONIC AT THE OLYMPIC WINTER GAMES DS SEG'})
AADD(aProdBlq,{'0286120000106','BOLSA FEMININA PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS ROSA CLARO DS RDS'})
AADD(aProdBlq,{'01971304018','MICHAEL PHELPS: PUSH THE LIMIT X360 505'})
AADD(aProdBlq,{'01171103987','DUKE NUKEM FOREVER X360 T2'})
AADD(aProdBlq,{'01201303956','DREAMCAST COLLECTION X360 SEG'})
AADD(aProdBlq,{'01171403911','MIDNIGHT CLUB: LOS ANGELES - COMPLETE EDITION PS3 T2'})
AADD(aProdBlq,{'01171303474','MIDNIGHT CLUB LA COMPLETE EDITION X360 TAK'})
AADD(aProdBlq,{'0407110021801','POKษMON HEARTGOLD VERSION (BUNDLE) DS NIN'})
AADD(aProdBlq,{'0407110021901','POKEMON SOULSILVER (BUNDLE) NDS NIN'})
AADD(aProdBlq,{'0422080022001','UDRAW GAMETABLET (BUNDLE) WII THQ'})
AADD(aProdBlq,{'0286160047404','DELUXE GAME TRAVELLER - BOLSA DE TRANSPORTE PARA WII PRETA WII RDS'})
AADD(aProdBlq,{'0286120047509','GAMETRAVELLER - BOLSA FEMININA PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS VERDE DS RDS'})
AADD(aProdBlq,{'01231303922','LEGO STAR WARS III: THE CLONE WARS X360 DIS'})
AADD(aProdBlq,{'0286120047603','GAMETRAVELLER - ESTOJO PARA NINTENDO DS AZUL DS RDS'})
AADD(aProdBlq,{'01171203923','MAJOR LEAGUE BASEBALL 2K11 PSP T2'})
AADD(aProdBlq,{'0286120047604','GAMETRAVELLER - ESTOJO PARA NINTENDO DS PRETO DS RDS'})
AADD(aProdBlq,{'0286120047703','GAMETRAVELLER - ESTOJO PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS AZUL DS RDS'})
AADD(aProdBlq,{'0286120047712','GAMETRAVELLER - ESTOJO PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS MARROM DS RDS'})
AADD(aProdBlq,{'0286120047704','GAMETRAVELLER - ESTOJO PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS PRETO DS RDS'})
AADD(aProdBlq,{'0286120047708','GAMETRAVELLER - ESTOJO PARA NINTENDO DS, CARTUCHOS E ACESSำRIOS ROSAESCURO DS RDS'})
AADD(aProdBlq,{'0286120047713','GAMETRAVELLER - ESTOJO PARA NINTENDO DS LARANJA DO YOSHI DS RDS'})
AADD(aProdBlq,{'0286120047810','GAMETRAVELLER - ESTOJO PARA NINTENDO DSI XL VINHO DS RDS'})
AADD(aProdBlq,{'0286120047802','GAMETRAVELLER ESSENTIALS - KIT COM 6 CANETAS STYLUS DS RDS'})
AADD(aProdBlq,{'0286120047904','GAMETRAVELLER ESSENTIALS - KIT DE CANETAS STYLUS E ESTOJOS PRETOS PARA JOGOS DE DS  RDS'})
AADD(aProdBlq,{'0285160047201','MALETA DE VIAGEM DE TECIDO SINTETICO, P/ TRANSPORTE DE APARELHOS DE VIDEO GAME WII E SEUS ACESSORIOS'})
AADD(aProdBlq,{'0285120046204','MEMORY FOAM PLAYTHRU (ESTOJO PARA NDS PRETO) LAT'})
AADD(aProdBlq,{'0241160053201','STORAGE TOWER FACTOR WII'})
AADD(aProdBlq,{'01261604451','GAME STOCK CAR PC REIZA'})
AADD(aProdBlq,{'0288150060801','TRITTON AX180 UNIVERSAL GAMING HEADSET'})
AADD(aProdBlq,{'0287120055401','DSI/DSL MEGA GAME CASE DS PDP'})
AADD(aProdBlq,{'0287120055101','DSI/DSL MULTI-STYLUS PACK DS PDP'})
AADD(aProdBlq,{'0287120055301','DSI/DSL RAINBOW STYLUS PACK DS PDP'})
AADD(aProdBlq,{'0287120055001','DSL INVISI-SHIELDS DS PDP'})
AADD(aProdBlq,{'0287120058201','DSL NERF ARMOR DS PDP'})
AADD(aProdBlq,{'0287140059601','KINECT TV CLIP X360 PDP'})
AADD(aProdBlq,{'0287140059501','XB360 VERSUS CONTROLLER X360 PDP'})
AADD(aProdBlq,{'0287140056301','XB360 ENERGIZER CHRGING SYSTEM X360 PDP'})
AADD(aProdBlq,{'0287140056401','XB360 ENERGIZER CHARGE CABLE PDP'})
AADD(aProdBlq,{'0287160056701','WII ENERGIZER 2X INDUCTION CHARGE STATION WII PDP'})
AADD(aProdBlq,{'0287160056801','ENERGIZER 2X CONDUCTIVE CHARGER PDP'})
AADD(aProdBlq,{'0287160056901','ENERGIZER 2X CHARGE STATION PDP'})
AADD(aProdBlq,{'0287160057501','WII CORDED HEADSET WII PDP'})
AADD(aProdBlq,{'0287120056201','UNIVERSAL SUPER MARIO DENIM CASE DS PDP'})
AADD(aProdBlq,{'0287120055901','UNIVERSAL PULL & GO FOLIO PINK DS PDP'})
AADD(aProdBlq,{'0287150057901','PS3 MOVE ENERGIZER 2X CONDUCTIVE CHARGER'})
AADD(aProdBlq,{'0287150059401','PS3 VERSUS CONTROLLER'})
AADD(aProdBlq,{'0287150057401','PS3 WIRED AFTERGLOW CONTROLLER'})
AADD(aProdBlq,{'0287120056101','UNIVERSAL PULL & GO FOLIO BLUE'})
AADD(aProdBlq,{'01421104459','BEN 10 TRIPLE PACK DS D3'})
AADD(aProdBlq,{'01221304463','CATHERINE (ALTERNATE COVER) X360 ATL'})
AADD(aProdBlq,{'0237140050001','CHARGING MODULES X360'})
AADD(aProdBlq,{'0237150052301','QUICKSHOT GUN PS3'})
AADD(aProdBlq,{'0241140053401','STORAGE TOWER ZIG ZAGXBOX'})
AADD(aProdBlq,{'0282150052905','RAVEN MOTION SENSING VERSAO 2 PS3 NYKO'})
AADD(aProdBlq,{'0282150049601','CHARGE STATION FAMILY 4 PORT CHARGE PS3M'})
AADD(aProdBlq,{'0287260059001','3DS PULL & GO FOLIO (2 BLACK & 1 BLUE)'})
AADD(aProdBlq,{'0288140060001','X360 WIRELESS RACING WHEEL'})
AADD(aProdBlq,{'0288140060101','X360 CONTROL PAD'})
AADD(aProdBlq,{'0282160051301','PERFECT SHOT GUN GRIP WII'})
AADD(aProdBlq,{'0288140060301','X360 HEADCOM PRO'})
AADD(aProdBlq,{'0287120055501','DSI XL NINTENDO SHOW AND GO DSI XL PDP'})
AADD(aProdBlq,{'0287120055701','DSI XL POWER PACK PDP'})
AADD(aProdBlq,{'0287120055801','DSI XL WRITE & PROTECT DS PDP'})
AADD(aProdBlq,{'0287120055201','DSI/DSL FASHION FOLIO DS PDP'})
AADD(aProdBlq,{'0281160054404','QUADRUPLE VERTICAL INDUCTION CHARGER FOR WII, DSI AND DSIXL ( BLACK) CTA WII'})
AADD(aProdBlq,{'0282260049501','CHARGE BASE 3DS NYKO'})
AADD(aProdBlq,{'0307100003315','AP NINTENDO DS NINTENDO DSI BRANCO'})
AADD(aProdBlq,{'0281150051201','PERFECT AIM PISTOL FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281150051501','PREMIUM TENNIS RACKET FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281150051701','PROTECTIVE GRIPS FOR PLAYSTATION MOVE CONTROLLERS'})
AADD(aProdBlq,{'0281160054401','QUADRUPLE VERTICAL INDUCTION CHARGER FOR WII, DSI AND DSIXL'})
AADD(aProdBlq,{'0281150053001','SNIPER RIFLE FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281150053501','SUBMACHINE GUN FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281160050101','CROSSBOW FOR WII CTA'})
AADD(aProdBlq,{'0281150053701','TRIPLE PORT CHARGING STATION FOR PLAYSTATION MOVE CONTROLLERS & SIXAXIS CONTROLLER'})
AADD(aProdBlq,{'0260150048801','6 IN 1 STARTER KIT'})
AADD(aProdBlq,{'0281150049301','BOWLING BALL FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0281160050201','DUAL CHARGE STATION WITH DUAL NUNCHUK HOLDERS FOR WII'})
AADD(aProdBlq,{'0281150050401','DUAL PORT CHARGING STATION FOR PLAYSTATION MOVE CONTROLLERS'})
AADD(aProdBlq,{'0281160050801','LIGHT SWORD FOR WII'})
AADD(aProdBlq,{'0281160050901','SNIPER RIFLE WII CTA'})
AADD(aProdBlq,{'0281150051001','MOVE & DUAL SCHOCK CONTROLLERS CHARGING STATION WITH STAND FOR PS3 SLIM'})
AADD(aProdBlq,{'0281150051101','PERFECT AIM PISTOL COMBO FOR PLAYSTATION MOVE'})
AADD(aProdBlq,{'0237150049901','CHARGING MODULES PS3'})
AADD(aProdBlq,{'01171603571','GRAND THEFT AUTO: EPISODES FROM LIBERTY CITY PC T2'})
AADD(aProdBlq,{'0289160061601','SUPER FAMILY FOUR WII ATC'})
AADD(aProdBlq,{'01821440540','ARMY OF TWO: THE 40TH DAY (EUR) PS3 EA'})
AADD(aProdBlq,{'0289140061001','MOTOR FORCE STEERING WHEEL X360 ATC'})
AADD(aProdBlq,{'0289160061501','THE PUNISHER KILLER RIFLE WII ATC'})
AADD(aProdBlq,{'01311104187','FRONT MISSION DS SQU'})
AADD(aProdBlq,{'01211104302','NIGHT AT THE MUSEUM: BATTLE OF THE SMITHSONIAN THE VIDEO GAME DS MAJ'})
AADD(aProdBlq,{'01231104376','STAR WARS: THE CLONE WARS - JEDI ALLIANCE DS DIS'})
AADD(aProdBlq,{'01201104237','THE INCREDIBLE HULK DS SEG'})
AADD(aProdBlq,{'0292160062705','STORAGE TOWER ZIG ZAG WII LEVEL'})
AADD(aProdBlq,{'0260150062901','MOTION EQUALIZER PS3 DG'})
AADD(aProdBlq,{'0260150063101','MOTION BLASTER PS3 DG'})
AADD(aProdBlq,{'0260150063201','BLASTER COMBO PACK PS3 DG'})
AADD(aProdBlq,{'0292150062501','ICON STORAGE TOWER'})
AADD(aProdBlq,{'01171340729','RED DEAD REDEMPTION GAME OF THE YEAR X360 T2'})
AADD(aProdBlq,{'01331340680','F1 2011 (EUR) X360 COD'})
AADD(aProdBlq,{'0283140063301','DUAL CONTROLLER CHARGING KIT X360 MEM'})
AADD(aProdBlq,{'0283160063601','WIRELESS SIDEKICK GAMING CONTROLLER WII MEM'})
AADD(aProdBlq,{'0245140063701','WIRELESS RACING WHEEL X360 MAD CATZ'})
AADD(aProdBlq,{'01421140573','BEN 10 GALACTIC RACING NDS D3'})
AADD(aProdBlq,{'01201440561','ANARCHY REIGNS PS3 SEG'})
AADD(aProdBlq,{'01271440607','NINJA GAIDEN 3 PS3 TEC'})
AADD(aProdBlq,{'01271340608','NINJA GAIDEN 3 X360 TEC'})
AADD(aProdBlq,{'01201440636','THE HOUSE OF THE DEAD: OVERKILL EXTENDED CUT PS3 SEG'})
AADD(aProdBlq,{'01221440637','THE KING OF FIGHTERS XIII  PS3 ATL'})
AADD(aProdBlq,{'0282150069601','CORE CONTROLLER WIRED  PS3 NYK'})
AADD(aProdBlq,{'0295160071001','CONTROLE CLมSSICO SEM FIO PARA  WII  VTC'})
AADD(aProdBlq,{'0283160084301','DUAL CONTROLLER CHARGING KIT  WII MEM'})
AADD(aProdBlq,{'0282160071601','CHARGE STATION  WII  NYK'})
AADD(aProdBlq,{'0282140071701','CHARGE BASE  X360  NYK'})
AADD(aProdBlq,{'0282160072301','BUILT IN MOTION PPLUS COMPATIBILITY WII  NYK'})
AADD(aProdBlq,{'0287120072501','BOSS BIG OVERSIZED SUPER SHELL  NDS  PDP'})
AADD(aProdBlq,{'0283120075901','STYLUS UPGRADE KIT NDS MEM'})
AADD(aProdBlq,{'0203160077001','SHOT BLASTER RESIDENT EVIL WII CAP'})
AADD(aProdBlq,{'0282160074301','WIRELESS SENSOR BAR  WII NYK'})
AADD(aProdBlq,{'0283160077801','RACING WHEELS (PACK W/ 3)  WII MEM'})
AADD(aProdBlq,{'0298010071101','CONSOLE TRAVEL CASE PS2 VTREX'})
AADD(aProdBlq,{'0283160077901','RACING WHEEL  WII MEM'})
AADD(aProdBlq,{'0283160078701','PROTECTIVE COVER FOR BALANCE WII MEM'})
AADD(aProdBlq,{'01341340822','THE ELDER SCROLLS V: SKYRIM (EUA) X360 BET'})
AADD(aProdBlq,{'0281120076001','STYLUS FOR  NDS CTA'})
AADD(aProdBlq,{'0281120076101','STEERING WHEEL IPOD/ITOUCH NDS CTA'})
AADD(aProdBlq,{'0295130079701','PERFECT GAME KIT FOR  PSP PER'})
AADD(aProdBlq,{'0298010070401','CONTROLE PLAYSTATION PS1 E  PS2 VTREX'})
AADD(aProdBlq,{'0286120083401','GAME TRAVELER MODELO 126 NDS RDS'})
AADD(aProdBlq,{'0286120083501','GAME TRAVELER MODELO 1010 NDS RDS'})
AADD(aProdBlq,{'0287010079801','PELICAN CONTROLLER WIRELESS  PS2 PDP'})
AADD(aProdBlq,{'0287010079901','PELICAN CONTROLLER CORDED  PS2 PDP'})
AADD(aProdBlq,{'0287160080001','NERF SPORTS PACK WII PDP'})
AADD(aProdBlq,{'0295120081201','KIT DE ACESSำRIOS DS LITE 20 EM 1 NDS PER'})
AADD(aProdBlq,{'0294150069801','CONTROLLER CHARGING CABLE  PS3  POWER A'})
AADD(aProdBlq,{'0281010083601','GAME CONTROLLER GRIP IPHONE/IPOD TOUCH PS2 CTA'})
AADD(aProdBlq,{'0283160084001','FITNESS STARTER KIT WII MEM'})
AADD(aProdBlq,{'0296160069401','DANCE PERFORMANCE  WII TOPWAY'})
AADD(aProdBlq,{'0281120081801','INDUCTION CHARGING PAD  NDS CTA'})
AADD(aProdBlq,{'0298010070801','CONTROLE PARA  PS2  VTREX'})
AADD(aProdBlq,{'0287150084201','DUAL TRIGGERS ENHANCEMENTS FOR  PS3 PDP'})
AADD(aProdBlq,{'0297120069501','CRYSTAL CASE NDS EAGLE'})
AADD(aProdBlq,{'0282160081901','HD-LINK COMPONENT AUDIO/VIDEO CABLE  WII NYK'})
AADD(aProdBlq,{'01171140788','NICKELODEON TEAM UMIZOOMI NDS T2'})
AADD(aProdBlq,{'01341340790','THE ELDER SCROLLS V: SKYRIM X360 BET'})
AADD(aProdBlq,{'01311340979','FRONT MISSION EVOLVED X360 SQU (EUR)'})
AADD(aProdBlq,{'0267150090301','SNAKEBYTE PS3 BASIC CONTROLLER - BLUE SUN'})
AADD(aProdBlq,{'01341340797','RAGE EUA X360 BET'})
AADD(aProdBlq,{'0294140079301','POWER STAND CHARGER  X360 POWER A'})
AADD(aProdBlq,{'0281250096301','DOUBLE CHARGE STATION CTA'})
AADD(aProdBlq,{'0281250096001','US ARMY SNIPER ACTION RIFLE CTA'})
AADD(aProdBlq,{'01202340905','VIRTUA TENNIS 4 WORLD TOUR PSV SEG'})
AADD(aProdBlq,{'0281250095701','IPHONE 4 / IPAD RADIATION SAFE TELEPHONE HANDSET PINK CTA'})
AADD(aProdBlq,{'0288150093301','XJACKER PS3 KIT GAME SOUND PSN CHAT WITH YOUR PC HEADSET ON YOUR PS3 COM'})
AADD(aProdBlq,{'01441441150','GREEN LANTERN: RISE OF THE MANHUNTERS (EUR) PS3 WAR'})
AADD(aProdBlq,{'01341440888','FALLOUT: NEW VEGAS - UTIMATE EDITION PS3 BET'})
AADD(aProdBlq,{'0267250087901','SNAKEBYTE PS3 MOVE POWER STATION SUN'})
AADD(aProdBlq,{'0267250088001','SNAKEBYTE PS3 MOVIE PACK SUN'})
AADD(aProdBlq,{'0267250088301','SNAKEBYTE PS3 PREMIUM BLUETOOTH CONTROLLER SUN'})
AADD(aProdBlq,{'0267250088701','EA SPORTS REMOTE XL BLUE-WHITE SUN'})
AADD(aProdBlq,{'0429100024201','RESIDENT EVIL: OPERATION RACCOON CITY SPECIAL EDITION X360 CAP'})
AADD(aProdBlq,{'01171347728','GRAND THEFT AUTO V X360 T2'})
AADD(aProdBlq,{'01971347738','SNIPER ELITE V2 - SILVER STAR EDITION X360 505'})
AADD(aProdBlq,{'01311347731','HITMAN: ABSOLUTION X360 SQU'})
AADD(aProdBlq,{'01171349025','GRAND THEFT AUTO V X360 T2 (BRA)'})
AADD(aProdBlq,{'0317180008801','CELULAR BLU SPARK TV SILVER'})
AADD(aProdBlq,{'0317180008201',' CELULAR BLU DIVA T272T BLACK'})
AADD(aProdBlq,{'01161348989','DIABLO III X360 BLI'})
AADD(aProdBlq,{'0317180007301','CELULAR BLU SAMBA JR Q53 SILVER'})
AADD(aProdBlq,{'01171449037','BORDERLANDS 2: GAME OF THE YEAR EDITION PS3 TAK'})
AADD(aProdBlq,{'01211549060','ZUMBA FITNESS WORLD PARTY WII MAJ'})
AADD(aProdBlq,{'0317180010402','CELULAR BLU SAMBA TV Q170T ANATEL/GENERIC QBAND DUAL SIM BLACK/BLUE'})
AADD(aProdBlq,{'01441449086','BATTLEFIELD 4 EDIวรO LIMITADA (BR) PS3 EA'})
AADD(aProdBlq,{'0317180010603','CELULAR BLU ARIA T174I ANATEL/GENERIC QUAD BAND DUAL SIM BLUE'})
AADD(aProdBlq,{'01441449083','BATMAN ARKHAM ORIGINS (BR) PS3 WAR'})
AADD(aProdBlq,{'0317180011115','SMARTPHONE BLU LIFE PLAY L100I QBAND DUAL SIM 3G 850/2100 WHITE'})
AADD(aProdBlq,{'01231349117','LEGO INDIANA JONES 2 THE ADVENTURE CONTINUES (DISNEY) X360 DIS'})
AADD(aProdBlq,{'01262349204','PUTTY SQUAD PSV MAX'})
AADD(aProdBlq,{'01271349078','THE WALKING DEAD: GAME OF THE YEAR EDITION X360 TEL'})
AADD(aProdBlq,{'01341349107','THE ELDER SCROLLS IV: OBLIVION GAME OF THE YEAR EDITION X360 BET'})
AADD(aProdBlq,{'0317180113619','SMARTPHONE BLU DASH JR D140X SILVER'})
AADD(aProdBlq,{'01972549237','SNIPER ELITE 3 COLLECTORS EDITION PS4 505'})
AADD(aProdBlq,{'0322270114302','TABLET PHASER FUNTAB - 5 POLEGADAS'})
AADD(aProdBlq,{'0214180127614','FONE DE OUVIDO INTRAAURICULAR CINZA SHE2100GY/28 PHILIPS'})
AADD(aProdBlq,{'0271250126101','BONECO UFC ANDERSON SILVA ULTIMATE COLLECTOR SERIE A'})
AADD(aProdBlq,{'0214180128001','HEADSET PARA PC SHM3550/10 PHILIPS'})
AADD(aProdBlq,{'0271250126701','BONECO UFC JUNIOR DOS SANTOS ULTIMATE COLLECTOR SERIE B'})
AADD(aProdBlq,{'0214180127602','FONE DE OUVIDO INTRAAURICULAR SHE8000/10 PHILIPS'})
AADD(aProdBlq,{'01972649298','SNIPER ELITE 3 (BRA) XONE 505'})
AADD(aProdBlq,{'01331349312','DIRT SHOWDOWN (EUR) X360 COD'})
AADD(aProdBlq,{'0317180114226','CELULAR BLU JENNY TV 2.8 T176T BLACK-BLUE'})
AADD(aProdBlq,{'01331649280','OPERATION FLASHPOINT: RED RIVER PC COD'})


cFilSB1:=xFilial("SB1")
For nInd:=1 To Len(aProdBlq)
                
	cMensagem:="Bloqueando Produto:"+aProdBlq[nInd,2]
	PtInternal(1,cMensagem )//Mensagem para o Monitor
	Conout(cMensagem)//Mensagem Console do Server
	If SB1->(DbSeek(cFilSB1))
		SB1->(RecLock("SB1",.F.))
		SB1->B1_MSBLQL 	 :="1"
		SB1->B1_BLQVEND	:="1" 
		SB1->B1_CORPRI 	:="-1" //Nenhum
		SB1->(MsUnLock())
	EndIf	

Next


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  01/13/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xOpenSB1
Local cQuery
Local aProdutos:={{}}
Local cModo			:="C"
Local nLinha:=1
RpcSetEnv("01","03")


cQuery:=" SELECT B1_FILIAL,B1_COD FROM SB1010 WHERE B1_FILIAL='  ' AND B1_TIPO='PA' AND D_E_L_E_T_=' '"
//cQuery+=" MINUS"
//cQuery+=" SELECT B1_COD FROM SB1020 WHERE B1_FILIAL='  ' AND B1_TIPO='PA' AND D_E_L_E_T_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"SB1OLD"  ,.F.,.T.)
   
EmpOpenFile("SB1_NCSOTORE","SB1",1,.T.,"03",@cModo)

Do While SB1OLD->(!Eof())
                                                
	PtInternal(1,"SB1OLD Produto:"+SB1OLD->B1_COD)
	
	If SB1_NCSOTORE->(DbSeek(SB1OLD->(B1_FILIAL+B1_COD)))
		SB1OLD->(DbSkip());Loop
	EndIf	

	If Len(aProdutos[nLinha])>=1000
		AADD(aProdutos,{})
		nLinha:=Len(aProdutos)		
	EndIf	
	
	AADD(aProdutos[nLinha],SB1OLD->B1_COD )		
	PtInternal(1,"Array Produto:"+SB1OLD->B1_COD)
	SB1OLD->(DbSkip())
EndDo 

For nInd:=1 To Len(aProdutos)
	StartJob( "U_xGrvB1", "COMPILA", .F., aProdutos[nInd])
Next	

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xAcertNF(dDataIni,dDataFim)
Local nInd:=1
Local cQryAlias     
Local aEmps:={{"03","01"},{"40","01"}}
Local cFiltro:=""
                       
default dDataIni:=ctod("01/07/2015")
default dDataFim:=LastDay(MsDate())
      
//RpcSetEnv(aEmps[nInd,1],aEmps[nInd,2],,,,,{"SF2"})
// U_NCIWMF02('cQuery','cTipo','cMensagem')
//return 


For nInd:=1 To Len(aEmps)
    
	RpcClearEnv()
	RpcSetType(3)
	RpcSetEnv(aEmps[nInd,1],aEmps[nInd,2],,,,,{"SF2"})
	            
               
	cQryAlias:=GetNextAlias()

	PtInternal(1,"Empresa"+cEmpAnt+" Delete SF3")	
	TcSqlExec("Delete From "+RetSqlName("SF3")+" Where D_E_L_E_T_='*'")
	
	
	PtInternal(1,"Empresa"+cEmpAnt+" Delete SFT")
	TcSqlExec("Delete From "+RetSqlName("SFT")+" Where D_E_L_E_T_='*'")
	
	
  
	cUpdate:=" UPDATE "+RetSqlName("SD2")+" SD2 SET D2_PDV=(SELECT DISTINCT L1_PDV FROM "+RetSqlName("SL1")+" SL1 WHERE L1_FILIAL=D2_FILIAL AND L1_DOC=D2_DOC AND L1_SERIE=D2_SERIE AND L1_CLIENTE=D2_CLIENTE AND L1_EMISNF=D2_EMISSAO AND D2_PDV<>L1_PDV AND SL1.D_E_L_E_T_=' ')"
	cUpdate+=" WHERE D2_FILIAL='21'"   
	//cUpdate+=" AND D2_EMISSAO BETWEEN '"+Dtos(dDataIni)+"' And '"+Dtos(dDataFim)+"'"
	cUpdate+=" AND SD2.D2_ESPECIE='2D'"
	cUpdate+=" AND D_E_L_E_T_=' '"
	TcSqlExec(cUpdate)
	
	cUpdate:=" UPDATE "+RetSqlName("SFT")+" SFT SET FT_PDV=(SELECT DISTINCT L1_PDV FROM "+RetSqlName("SL1")+" SL1 WHERE L1_FILIAL=FT_FILIAL AND L1_DOC=FT_NFISCAL AND L1_SERIE=FT_SERIE AND L1_CLIENTE=FT_CLIEFOR AND L1_EMISNF=FT_ENTRADA AND FT_PDV<>L1_PDV AND SL1.D_E_L_E_T_=' ')"
	cUpdate+=" WHERE D2_FILIAL='21'"   
	//cUpdate+=" AND D2_EMISSAO BETWEEN '"+Dtos(dDataIni)+"' And '"+Dtos(dDataFim)+"'"
	cUpdate+=" AND SFT.FT_TIPOMOV='S'"
	cUpdate+=" AND FT_DTCANC=' '"
	cUpdate+=" AND FT_ESPECIE='CF'"
	cUpdate+=" AND D_E_L_E_T_=' '"
	TcSqlExec(cUpdate)
	
	             
  //	cFiltro:="AND D2_DOC='7491'"
	
	//cFiltro:="%"+cFiltro+"%"
	BeginSQL Alias cQryAlias
	
	SELECT * 
	From (
	SELECT SD2.R_E_C_N_O_ RECSD2,D2_DOC,D2_SERIE,SD2.D2_CF,D2_FILIAL FILIAL,(SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET+SD2.D2_SEGURO+SD2.D2_DESPESA+SD2.D2_VALFRE) Nota_Val_Cont,SD2.D2_BASEICM,
	SD2.D2_PICM,SD2.D2_VALICM,Round((SD2.D2_BASEICM*SD2.D2_PICM)/100,2) Valor
	FROM %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN '01' And '99'
	And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
	And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
	And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
	And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
	//AND SD2.D2_EMISSAO BETWEEN %Exp:Dtos(dDataIni)% AND %Exp:Dtos(dDataFim)%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_=' '
	//%Exp:cFiltro%
	) Tab1
	Where Valor<>Tab1.D2_VALICM
	
	
	EndSql
	
	PtInternal(1,"Empresa"+cEmpAnt+" Acerta D2_VALICM")
	  
	Do While (cQryAlias)->(!Eof())
	
		SD2->(DbGoTo((cQryAlias)->RECSD2)) 
		                    
		nVlrICM:=Round((SD2->D2_BASEICM*SD2->D2_PICM)/100,2)
		
		If SD2->D2_VALICM<>nVlrICM
			RecLock("SD2",.F.)
			SD2->D2_VALICM=nVlrICM
			SD2->(MsUnLock())
		EndIf
		(cQryAlias)->(DbSkip())
	EndDo
	    
	
	(cQryAlias)->(DbCloseArea())
	
	PtInternal(1,"Empresa"+cEmpAnt+" Acerta F2_VALICM")
		
	BeginSQL Alias cQryAlias
	
	SELECT SF2.R_E_C_N_O_ RECSF2, F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_EMISSAO,SF2.F2_VALICM,SD2.D2_VALICM
	
	From %Table:SF2% SF2,
	(SELECT D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,SUM(D2_VALICM) D2_VALICM
	FROM %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN '01' And '99'
	And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
	And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
	And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
	And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
	//AND SD2.D2_EMISSAO BETWEEN %Exp:Dtos(dDataIni)% AND %Exp:Dtos(dDataFim)%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.D_E_L_E_T_=' '
	GROUP BY D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO) SD2
	
	WHERE SF2.F2_FILIAL=SD2.D2_FILIAL
	And SF2.F2_DOC=SD2.D2_DOC
	And SF2.F2_SERIE=SD2.D2_SERIE
	And SF2.F2_CLIENTE=SD2.D2_CLIENTE
	And SF2.F2_LOJA=SD2.D2_LOJA
	And SF2.F2_VALICM<>D2_VALICM
	Order By 1
	
	EndSql
	  
	Do While (cQryAlias)->(!Eof())
	
		SF2->(DbGoTo((cQryAlias)->RECSF2)) 
		If SF2->F2_VALICM<>(cQryAlias)->D2_VALICM
			RecLock("SF2",.F.)
			SF2->F2_VALICM:=(cQryAlias)->D2_VALICM
			SF2->(MsUnLock())
		EndIf
		
	
		(cQryAlias)->(DbSkip())
	EndDo
	/*
	(cQryAlias)->(DbCloseArea())
	PtInternal(1,"Empresa"+cEmpAnt+" Acerta F2_VALICM")
	
		
	BeginSQL Alias cQryAlias
	

	 SELECT FT_FILIAL||FT_TIPOMOV||FT_SERIE||FT_NFISCAL||FT_CLIEFOR||FT_LOJA||FT_ITEM||FT_PRODUTO CHAVE,Count(1) Contar
	 FROM SFT030
	 WHERE FT_FILIAL='21'
	 AND D_E_L_E_T_=' '
	 GROUP BY FT_FILIAL||FT_TIPOMOV||FT_SERIE||FT_NFISCAL||FT_CLIEFOR||FT_LOJA||FT_ITEM||FT_PRODUTO
	 HAVING Count(1)>1
	 
	EndSql
	    
	SFT->(DbSetOrder(1)) //FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO
	Do While (cQryAlias)->(!Eof())
		cChave:=(cQryAlias)->CHAVE
		SFT->(DbSeek(cChave))
		SFT->(DbSkip())
		Do While SFT->(!Eof()) .And. SFT->(FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO)==(cQryAlias)->CHAVE
			SFT->(RecLock("SFT",.F.))		
			SFT->(DbDelete())
			SFT->(MsUnLock())
			SFT->(DbSkip())
		EndDo
		(cQryAlias)->(DbSkip())
	EndDo
	TcSqlExec("Delete From SFT030 Where D_E_L_E_T_='*'")
    */
Next

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  10/02/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function xVerPV()
Local cQryAlias:=GetNextAlias()
Local cPictqtd:="@E 999999999"
RpcClearEnv()
RpcSetType(3)
RpcSetEnv("01","03",,,,,{"SC5"})

BeginSQL Alias cQryAlias
	
	SELECT SC5.R_E_C_N_O_ RECSC5
	FROM %Table:SC5% SC5
	WHERE SC5.C5_FILIAL='03'
	And SC5.C5_NUM BETWEEN '      ' And 'ZZZZZZ'
	//And SC5.C5_NUM 	='106843'
	AND SC5.D_E_L_E_T_=' '
	//AND SC5.C5_PEDRES<>' '
	AND SC5.C5_ORIGRES<>' '
	AND EXISTS (SELECT 'X ' FROM %Table:SC6% SC6 WHERE SC6.C6_FILIAL='03' AND SC6.C6_NUM=SC5.C5_NUM AND C6_PRODUTO='01152550320    ' AND SC6.D_E_L_E_T_=' ')
	ORDER BY C5_ORIGRES
EndSql

SC6->(DbSetOrder(1))
SD2->(DbSetOrder(8))//D2_FILIAL+D2_PEDIDO+D2_ITEMPV
cLinha:="Pedido;Emissao;Cliente;Nome;Produto;Item;QuantPV;Nota;Serie;Emissao;QuantNF;Pedido Residuo;Emissao;Item;QuantPV;Nota;Serie;Emissao;QuantNF"+CRLF
Do While (cQryAlias)->(!Eof())
	
	SC5->(DbGoTo((cQryAlias)->RECSC5))
	
	cChaveSC6:=xFilial("SC6")+SC5->C5_ORIGRES
	SC6->(DbSeek(cChaveSC6))
	Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==cChaveSC6
		cLinha+=SC6->C6_NUM+";"
		cLinha+=DTOC(SC5->C5_EMISSAO) +";"
		cLinha+=SC5->C5_CLIENTE+";"
		cLinha+=SC5->C5_NOMCLI+";"
		cLinha+=SC6->C6_PRODUTO+";"
		cLinha+=SC6->C6_ITEM+";"
		cLinha+=AllTrim(TransForm(SC6->C6_QTDVEN,cPictqtd))+";"
		If SD2->(DbSeek(xFilial("SD2")+SC6->(C6_NUM+C6_ITEM)   ))
			cLinha+=SD2->D2_DOC+";"
			cLinha+=SD2->D2_SERIE+";"
			cLinha+=DTOC(SD2->D2_EMISSAO)+";"
			cLinha+=AllTrim(TransForm(SD2->D2_QUANT,cPictqtd))+";"
		Else
			cLinha+=";;;;"	
		EndIf
		aAreaSC6:=SC6->(GetArea())
		
		SC6->(DbSetOrder(2))//C6_FILIAL+C6_PRODUTO+C6_NUM+C6_ITEM
		cChaveRes:=xFilial("SC6")+SC6->C6_PRODUTO+SC5->C5_NUM
		If SC6->(DbSeek(cChaveRes))
			cLinha+=SC6->C6_NUM+";"
			cLinha+=DTOC(SC5->C5_EMISSAO) +";"
			cLinha+=SC6->C6_ITEM+";
			cLinha+=AllTrim(TransForm(SC6->C6_QTDVEN,cPictqtd))+";"
			If SD2->(DbSeek(xFilial("SD2")+SC6->(C6_NUM+C6_ITEM)   ))
				cLinha+=SD2->D2_DOC+";"
				cLinha+=SD2->D2_SERIE+";"
				cLinha+=DTOC(SD2->D2_EMISSAO)+";"
				cLinha+=AllTrim(TransForm(SD2->D2_QUANT,cPictqtd))+";"
			EndIf
		EndIf
		RestArea(aAreaSC6)
		cLinha+=CRLF
		SC6->(DbSkip())		
	EndDo
	
	
	
	(cQryAlias)->(DbSkip())
EndDo

MemoWrite( "d:\CES\pedidos.txt", cLinha )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUPDPR700  บAutor  ณMicrosiga           บ Data ณ  12/16/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xLeSA7()
Local cProduto
Local cCaracter
Local nInd
Local cProduto :="" 
Local cProdErro:="" 
Local cChaveSA7
Local cCodCli:="000000"
Local cLojaCli:="01"


RpcSetEnv("01","03")
ChkFile("SA7")  
SA7->(DbSetOrder(1)) //A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
cChaveSA7:=xFilial("SA7")+cCodCli+cLojaCli

SA7->(MsSeek(cChaveSA7))



Do While SA7->(!Eof()) .And. SA7->(A7_FILIAL+A7_CLIENTE+A7_LOJA)==cChaveSA7

	cProduto:=AllTrim(SA7->A7_CODCLI)
	PtInternal(1,"Produto:"+SA7->A7_PRODUTO)
	
	For nInd:=1 To Len(cProduto)
		
		cCaracter:=SubStr(cProduto,1,nInd) 
		
		If Asc(cCaracter)>=48 .And. Asc(cCaracter)<=57  .Or. Asc(cCaracter)>=65 .And. Asc(cCaracter)<=90
			Loop
		EndIf	
		
	    cProdErro+=SA7->A7_PRODUTO+";"+SA7->A7_CODCLI+CRLF
	
	Next
	SA7->(DbSkip())
EndDo

MemoWrite( "d:\CES\SA7.txt", cProdErro )

Return 



User Function xTstSSl()
	RpcSetType(3)
	RpcSetEnv("01","01")
	TSTGetSSL()
Return

Static function TSTGetSSL()
	
	Local cURL := "https://api.sandbox.blackhawknetwork.com/productCatalogManagement/v1/productCatalogs?first=0&maximum=10&ascending=true&exactMatch=false&caseSensitive=false"
	Local nTimeOut := 120
	Local aHeadOut := {}
	Local cHeadRet := ""
	Local cRetorno := ""
	Local oJson
	Local cCertificate	:="\certs\cert.pem"
	Local cPrivKey		:="\certs\privkey.pem"
	Local cPassword		:="CNTC82SH"
	Local cPostParam
	Local oRestClient := FWRest():New(cURL)


	
	cRetorno := HTTPSGet( cURL, "\certs\cert.pem", "\certs\privkey.pem", "CNTC82SH", "", nTimeOut, aHeadOut, @cHeadRet )
	FWJsonDeserialize(cRetorno,@oJson)
	cURL:=oJson:results[1]:entityId

	oRestClient:setPath("")
	If oRestClient:Get()
		ConOut(oRestClient:GetResult())
	Else
		conout(oRestClient:GetLastError())
	Endif
	cPostParam:=""	
	//If At("https://sandbox",cUrl)>0
		//cURL:=Stuff(cURL,9,0,"api.")
	//EndIf
	//cRetorno := HTTPSGet( cURL, "\certs\cert.pem", "\certs\privkey.pem", "CNTC82SH", "", nTimeOut, aHeadOut, @cHeadRet )
	
	//cURL:='https://api.sandbox.blackhawknetwork.com/eGiftProcessing/v1/generateEGift HTTP/1.1'
	//Conout("================>Antes")
	//cPostParam:='{     "giftAmount": 15,     "productConfigurationId": "AQKNLF4MKRAA5RBPJD00QB9P4R"}'
	//cRetorno := HTTPSPost(  cURL ,  cCertificate , cPrivKey , cPassword ,"", cPostParam , nTimeOut, aHeadOut,@cHeadRet)
	//FWJsonDeserialize(cRetorno,@oJson)

	aHeadOut:={'Content-Length: 86'}
	aHeadOut:={'Content-Type: application/json'}

	cURL:='https://api.sandbox.blackhawknetwork.com/eGiftProcessing/v1/generateEGift'
	oRestClient := FWRest():New(cURL)

	oRestClient:setPath("")
	cPostParam:='{     "giftAmount": 15,     "productConfigurationId": "AQKNLF4MKRAA5RBPJD00QB9P4R"}'
	oRestClient:SetPostParams(cPostParam)
	
	If oRestClient:Post(aHeadOut)
		FWJsonDeserialize(oRestClient:cResult,@oJson)
		ConOut(oRestClient:GetResult())
	Else
		conout(oRestClient:GetLastError())
	Endif 
	
	
	Conout("Retorno:=")
	Conout(cRetorno)
	
	Conout("================>Depois")
return



User Function BHN01JOB()
	RpcSetEnv('01','03')
	u_NCGBHN01()
Return

User Function NCGBHN01()
	Local cEndPoint:=U_BHN00END()
	Local cURL := 'https://api.certification.blackhawknetwork.com/productCatalogManagement/v1/productCatalogs?first=0&maximum=10&ascending=true&exactMatch=false&caseSensitive=falsefirst=0&maximum=10&ascending=true&exactMatch=false&caseSensitive=false'
	Local nTimeOut := 120
	Local aHeadOut := {}
	Local cHeadRet := ""
	Local cRetorno := ""
	Local oJson
	Local cPostParam
	Local oRestClient := FWRest():New(cURL)

	cRetorno := HTTPSGet( cURL, "\certs\certif_cert.pem", "\certs\certif_key.pem", "XKG93V4NNHLDQ00AJQVBLYYLJW", "", nTimeOut, aHeadOut, @cHeadRet )

	oRestClient:setPath("")
	If oRestClient:Get()
		ConOut(oRestClient:GetResult())
	Else
		conout(oRestClient:GetLastError())
	Endif

Return


User Function NCGBHN00()



Return


User Function BHN00END()
	Local cEndPoint
	cURL:='https://api.certification.blackhawknetwork.com/'

Return cURL