#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"

STATIC cAdmArq

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  08/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PTA00003()
Local aSays:={}
Local aButtons:={}
Local lOk
Local cNomeUser

Private aLogPrc:={}
Private cArquivo:=""



AADD( aSays, "Este processo tem como objetivo realizar o Inventario a partir do arquivo WMS" )
AADD( aSays, "baseado em arquivo Txt" )
AADD( aButtons, { 01, .T., {|| lOk := .T.,(cArquivo:=cGetFile("Arquivo TXT | *.txt","Selecione o arquivo ",,,.T.)) ,Iif( File(cArquivo), FechaBatch(), msgStop("Arquivo Txt: "+cArquivo+" nใo localizado.") ) } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
;FormBatch( "Atualiza็ใo Inventแrio", aSays, aButtons )

If lOk
	Processa({|| A00003Imp(  ) }, "Verificando arquivo TXT" )
EndIf



Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  08/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A00003Imp()
Local dDatInv		:= MsDate()
Local cDocto		:=""
Local cPerg			:="A00003Imp"

If !File(cArquivo)
	MsgAlert("Arquivo texto: "+cArquivo+" nใo localizado")
	Return
Else
	FT_FUSE( cArquivo )
	FT_FGOTOP()
	cBuffer := AllTrim( FT_FREADLN() )
	aDados:=Separa(cBuffer,";")
	dDatInv:=STOD(aDados[1])
	FT_FUSE()
Endif

PutSX1(cPerg,"01","Nome Documento Inventario"   ,""		,""		,"mv_ch1","C",09,0,1,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
Do While .T.
	
	If !Pergunte("A00003Imp")
		Return
	EndIf
	
	If Empty(mv_par01)
		MsgStop("Nome Documento obrigatorio.")
		Loop
	EndIf
	Exit
EndDo

cDocto:=Upper(mv_par01)

ChkFile( "SB7" )
If !( ChkInv( dDatInv, cDocto,.F. ) )
	
	If Aviso(	"PTA00003-03","Data Inventแrio: " + DToC( dDatInv ) + "." + CRLF +"N๚mero de Documento: " + AllTrim( cDocto ) + "." + CRLF +"Houve um processamento com as mesmas informa็๕es." + CRLF +;
		"Se continuar o inventario anterior serแ excluido" + CRLF +	"Deseja Continuar ?",{ "&Abandona", "&Continua" },3,"Duplicidade Inventario" ) <> 2
		Return( .F. )
	ElseIf !ChkInv( dDatInv, cDocto,.T. )
		Return
	EndIf
EndIf


A003File(dDatInv,cDocto)


If Len(aLogPrc)==0
	aAdd( aLogPrc, {	"UPDINFORMATION",	"","","","", "Arquivo sem erros.",""} )
Else
	A001Tela()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  08/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A003File(dDatInv,cDocto)
Local oLst
Local aDadInv		:= {}
Local lDiverg		:= .F.
Local lRetorno		:= .T.
Local lCopia		:= .F.
Local lAberto		:= .F.
Local lFechado		:= .T.
Local nTotLinha	:= 0
Local nLinha		:= 0
Local nQuant		:= 0
Local cBuffer		:= ""
Local cCodPro		:= ""
Local cLocal		:= PadR( mv_par04, TAMSX3( "B7_LOCAL" )[1] )
Local cLocaliz		:= ""
Local cNumSer		:= ""
Local cLotCtl		:= ""
Local cNumLote		:= ""
Local cCodBas		:= CriaVar( "B7_COD", .F. )
Local cFile			:= ""
Local cFileLog		:= ""
Local lSimular		:=MsgYesNo("Simular processamento do arquivo?")
Local cSimulacao  :=Iif(lSimular,"(SIMULACAO) ","")

//aAdd( aLogPrc, {	"UPDINFORMATION",	"Inํcio do Processo Arquivo "+cArquivo,	+ DToC( MsDate() ) + " เs " + Time() + ".",	} )
FT_FUSE( cArquivo )
FT_FGOTOP()
ProcRegua(nTotLinha	:= FT_FLASTREC())
FT_FGOTOP()
nLinha	:= 0

Do While !FT_FEOF()
	
	nLinha++
	IncProc( "Processando linha " +  StrZero( nLinha,6 ) +"/"+StrZero(nTotLinha,6)   )
	cBuffer := AllTrim( FT_FREADLN() )
	
	If Empty(cBuffer)
		FT_FSKIP();Loop
	EndIf
	
	aDados:=Separa(cBuffer,";")
	cCodPro	:= PadR( aDados[2], TAMSX3( "B7_COD" )[1] )
	cLocal	:= StrZero(Val(aDados[3]),2)
	nQuant	:= Val( aDados[4] )
	cLinha	:=StrZero(nLinha,5)
	
	
	If dDatInv<>STOD( aDados[1] )
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4],cSimulacao+"Data do Inventแrio "+DTOC(dDatInv)+" difere da data do arquivo"+Dtoc(STOD( aDados[1] )),""} )
		FT_FSKIP();Loop
	EndIf
	
	
	
	If !SB1->(MsSeek(xFilial("SB1")+cCodPro))
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4],cSimulacao+"Produto "+cCodPro+" nใo encontado.",""} )
		FT_FSKIP();Loop
	EndIf
	
	
	If !SX5->(MsSeek(xFilial("SX5")+"ZZ"+cLocal))
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4],cSimulacao+"Armazem nใo encontrado.",SB1->B1_TIPO} )
		FT_FSKIP();Loop
	EndIf
	
	
	If !SB2->(MsSeek(xFilial("SB2")+cCodPro+cLocal))
		CriaSB2(cCodPro,cLocal)
		aAdd( aLogPrc, {	"UPDWARNING",	cLinha,cCodPro,cLocal,aDados[4],cSimulacao+"Armaz้m "+Iif(lSimular,"serแ","")+" criado.!! Aten็ใo o custo estแ zerado para o produto.",SB1->B1_TIPO} )
	EndIf
	
	
	
	If nQuant<0
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4], "Quantidade "+AllTrim(Str(nQuant))+" invalida",SB1->B1_TIPO} )
		FT_FSKIP();Loop
	EndIf
	
	If !lSimular
		RecLock( "SB7", .T. )
		SB7->B7_FILIAL		:= xFilial( "SB7" )
		SB7->B7_COD			:= cCodPro
		SB7->B7_LOCAL		:= cLocal
		SB7->B7_TIPO		:= SB1->B1_TIPO
		SB7->B7_DOC			:= cDocto
		SB7->B7_DATA		:= dDatInv
		SB7->B7_ORIGEM		:= 'ARQUIVO'
		SB7->B7_QUANT		:= nQuant
		SB7->B7_QTSEGUM	:= ConvUM( cCodPro, nQuant, 0, 2 )
		
		SB7->(MsUnLock())
	EndIf
	FT_FSKIP()
EndDo

FT_FUSE()
aLogPrc := Asort(aLogPrc,,,{|x,y| x[1]+x[2] > y[1]+y[2]})

If IsIncallStack("A003Exec")
	U_A003LOG()
EndIf



Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  08/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ChkInv( dDatInv, cDocto, lExcluir )
Local lRetorno	:= .T.
Local aAreaAtu	:= GetArea()
Local cQry		:= ""
Local cArqQry	:= GetNextAlias()

If lExcluir
	cQry := " Delete From " +RetSqlName( "SB7" ) + " SB7"
	cQry += " Where SB7.B7_FILIAL = '" + xFilial( "SB7" ) + "'"
	cQry += " And SB7.B7_DATA = '" + DToS( dDatInv ) + "'"
	cQry += " And SB7.B7_DOC = '" + cDocto + "'"
	cQry += " And SB7.D_E_L_E_T_ = ' '"
	
	If TcSQLExec( cQry ) < 0
		Aviso(ProcName()+"-"+StrZero(ProcLine(),5),"Ocorreu um erro, limpar os dados para Reprocessamento.",{"Ok"},3)
		lRetorno	:= .F.
	Else
		TcSQLExec( "COMMIT" )
	EndIf
	
Else
	cQry := " SELECT COUNT(*) QDEINV"
	cQry += " FROM " + RetSqlName( "SB7" ) + " SB7"
	cQry += " WHERE SB7.B7_FILIAL = '" + xFilial( "SB7" ) + "'"
	cQry += " AND SB7.B7_DATA = '" + DToS( dDatInv ) + "'"
	cQry += " AND SB7.B7_DOC = '" + cDocto + "'"
	cQry += " AND SB7.D_E_L_E_T_ = ' '"
	dbUseArea( .T., __cRdd, TCGenQry(,,cQry), cArqQry, .F., .T. )
	
	If (cArqQry)->QDEINV <> 0
		lRetorno	:= .F.
	EndIf
	
	(cArqQry)->(DbCloseArea())
	
	RestArea( aAreaAtu )
	
EndIf

Return( lRetorno )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  03/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A001Tela()
Local oDlg
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Mostra a tela com o resumo do processamento                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE MSDIALOG oDlg TITLE "Resumo do Processamento" FROM 000,000 TO 400,810 OF oDlg PIXEL
DEFINE SBUTTON FROM 187,345 TYPE 1 OF oDlg ENABLE ACTION( oDlg:End() )
DEFINE SBUTTON FROM 187,375 TYPE 6 OF oDlg ENABLE ACTION( ImpRel() )
@ 005,003 LISTBOX oLst FIELDS HEADER		" ","Linha","Produto","Armazem","Tipo","Quantidade","Motivo" SIZE 400,180 OF oDlg PIXEL

oLst:SetArray( aLogPrc )
oLst:bLine := { || {	LoadBitMap( GetResources(), aLogPrc[oLst:nAt,01] ),;	// Imagem
aLogPrc[oLst:nAt,02],;
aLogPrc[oLst:nAt,03],;
aLogPrc[oLst:nAt,04],;
aLogPrc[oLst:nAt,07],;
aLogPrc[oLst:nAt,05],;
aLogPrc[oLst:nAt,06] ;											// Detalhes
} }
ACTIVATE DIALOG oDlg CENTERED


//COLSIZES	GetTextWidth( 0, "BBB" ),;
//GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBB" ),;
//GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" ),;
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  08/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpRel()
Local aCabec	:= {}
Local aItens	:= {}
Local nLoop		:= 0
Local nLine
Local cMotivo
aAdd( aCabec, { "Tipo"			,	1, 1, .F. } )
aAdd( aCabec, { "Linha"			,	1, 1, .F. } )
aAdd( aCabec, { "Produto"		,	1, 1, .F. } )
aAdd( aCabec, { "Tipo"			,	1, 1, .F. } )
aAdd( aCabec, { "Armazem"		,	1, 1, .F. } )
aAdd( aCabec, { "Quantidade"	,	1, 1, .F. } )
aAdd( aCabec, { "Observa็ใo"	,	1, 1, .F. } )


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta array com os itens da planilha                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nLoop := 1 to Len( aLogPrc )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Alimenta o array que gera o Excel                                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aAdd( aItens, Array( Len(aCabec) ) )
	nLine:=Len( aItens )
	cMotivo	:= "Sem Defini็ใo"
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava as informa็๕es do documento de origem                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If "UPDINFORMATION" $ aLogPrc[nLoop,01]
		cMotivo	:= "Informa็ใo"
	ElseIf "UPDERROR" $ aLogPrc[nLoop,01]
		cMotivo	:= "Erro"
	ElseIf "UPDWARNING" $ aLogPrc[nLoop,01]
		cMotivo	:= "Aten็ใo"
	ElseIf "QMT_OK" $ aLogPrc[nLoop,01]
		cMotivo	:= "Processo Concluํdo Com Sucesso"
	ElseIf "QMT_COND" $ aLogPrc[nLoop,01]
		cMotivo	:= "Processo Concluํdo Com Aten็ใo"
	ElseIf "QMT_NO" $ aLogPrc[nLoop,01]
		cMotivo	:= "Processo Concluํdo Com Divereg๊ncia"
		
		
	EndIf
	
	aItens[nLine,01]	:= cMotivo
	aItens[nLine,02]	:= aLogPrc[nLoop,02]
	aItens[nLine,03]	:= aLogPrc[nLoop,03]
	aItens[nLine,04]	:= aLogPrc[nLoop,07]
	aItens[nLine,05]	:= aLogPrc[nLoop,04]
	aItens[nLine,06]	:= aLogPrc[nLoop,05]
	aItens[nLine,07]	:= aLogPrc[nLoop,06]



Next nLoop
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se tem dados exporta para o Excel                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len( aItens ) > 0
	Msgrun( "Gerando Planilha Excel", "Inventario NcGames", { || FExExcel( aCabec, aItens ) } )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se nใo tem dados aviso usuแrio                                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Else
	Aviso(	cTitle,;
	"Nใo hแ registros a exportar.",;
	{"&Ok"},3,;
	"Sem Dados" )
EndIf

Return( Nil )

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออัออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบPrograma    ณFExExcelณExporta os dados para arquivo Excel                              บฑฑ
ฑฑฬออออออออออออุออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAutor       ณ14.11.13ณACPD Informแtica                                                 บฑฑ
ฑฑฬออออออออออออุออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParโmetros  ณExpC1 = Alias do grupo de perguntas                                       บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno     ณNil.                                                                      บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบObserva็๕es ณ                                                                          บฑฑ
ฑฑฬออออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAltera็๕es  ณ 99.99.99 - Consultor - Descri็ใo da Altera็ใo                            บฑฑ
ฑฑศออออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function FExExcel( aCabec,aItens )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define as variแveis da rotina                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local oExcelApp	:= Nil
Local oExcel	:= FWMSEXCEL():New()
Local lVisual	:= .T.
Local nLoop		:= 0
Local cArquivo	:= CriaTrab(,.F.) + ".xls"
Local cDirDocs	:= MsDocPath()
Local cPath		:= AllTrim(GetTempPath())
Local cWSheet	:= "Resumo do Processamento"
Local cTable	:= "Log de erros no processo de importa็ใo do inventario"
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se a esta็ใo tem o Excel instalado                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !ApOleClient('MsExcel')
	Aviso(	"FExExcel-01",;
	"MsExcel nใo instalado na esta็ใo de trabalho." + CRLF +;
	"O Arquivo serแ gerado no diretorio "+cPath+" mas nใo serแ possํvel abrir para visualiza็ใo do mesmo.",;
	{ "&Continua" },3,;
	"Arquivo: " + AllTrim( cPath ) + AllTrim( cArquivo ) )
	lVisual	:= .F.
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define as configura็๕es de cabe็alho                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oExcel:SetTitleSizeFont( 12 )
oExcel:SetTitleItalic( .T. )
oExcel:SetTitleBold( .T. )
oExcel:SetTitleFrColor( "#FFFFFF" )	//Cor de Fonte - Branco
oExcel:SetTitleBgColor( "#00009C" )	//Cor da Fundo - Azul Escuro
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria a WorkSheet                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oExcel:AddworkSheet( cWSheet )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria a Tabela                                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oExcel:AddTable( cWSheet, cTable )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria o Cabe็alho                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nLoop := 1 To Len( aCabec )
	//	cWorkSheet,	cTable,	cColumm,			nAlign,				nFormat,			lTotal
	oExcel:AddColumn(	cWSheet,	cTable, aCabec[nLoop,01],	aCabec[nLoop,2],	aCabec[nLoop,3],	aCabec[nLoop,4] )
Next nLoop
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria os Itens                                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nLoop := 1 to Len( aItens )
	oExcel:AddRow( cWSheet, cTable, aItens[nLoop] )
Next nLoop
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fez a montagem correta do objeto excel                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Empty(oExcel:aWorkSheet)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Ativa o objeto e gera o arquivo                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oExcel:Activate()
	oExcel:GetXMLFile(cDirDocs+"\"+cArquivo)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Copia para a esta็ใo de trabalho o arquivo gerado                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CpyS2T(cDirDocs+"\"+cArquivo,cPath)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Abre o arquivo no excel se existir na esta็ใo de trabalho                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lVisual
		oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open(cPath+cArquivo) // Abre uma planilha
		oExcelApp:SetVisible(.T.)
		oExcelApp:Destroy()
	EndIf
Else
	Aviso(	"FExExcel-01",;
	"Nใo foi possํvel criar a planilha com os dados selecionados." + CRLF +;
	"Verifique os parโmetros utilizados para execu็ใo da rotina.",;
	{ "&Continua" },3,;
	"Sem Dados" )
EndIf

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/05/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function A003Invent()
Local aSays:={}
Local aButtons:={}
Local lOk


AADD( aSays, "Este processo tem como objetivo ajustar o inventario adicionando os produtos nใo" )
AADD( aSays, " contados no fisico." )
AADD( aButtons, { 01, .T., {|| lOk := .T., FechaBatch() } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
;FormBatch( "Atualiza็ใo Inventแrio", aSays, aButtons )

If lOk
	Processa({|| A00003App() }, "Ajustando..." )
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  08/30/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A00003App()  //nAO CONTATADO FISICOS
Local aAreaAtu		:=GetArea()
Local dDatInv		:= MsDate()
Local cDocto		:=""
Local cQuery		:=""
Local cAliasQry	:=GetNextAlias()
Local cPerg			:="A00003Imp"
Local cArmazem:=""

PutSX1(cPerg,"01","Nome Documento Inventario"   ,""		,""		,"mv_ch1","C",09,0,1,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
Do While .T.
	
	If !Pergunte("A00003Imp")
		Return
	EndIf
	
	If Empty(mv_par01)
		MsgStop("Nome Documento obrigatorio.")
		Loop
	EndIf
	Exit
EndDo

cDocto:=Upper(mv_par01)

cQuery:=" Select Distinct SB7.B7_LOCAL From "+RetSqlName("SB7")+" SB7 "
cQuery+=" Where SB7.B7_FILIAL='"+xFilial("SB7")+"'"
cQuery+=" and sb7.b7_doc   = '"+cDocto+"'"
cQuery+=" and sb7.d_e_l_e_t_=' '"
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)

Do While (cAliasQry)->(!Eof())
	cArmazem+=(cAliasQry)->B7_LOCAL+";"

	(cAliasQry)->(DbSkip())
EndDo                       
cArmazem:=Left(cArmazem,Len(cArmazem)-1)


(cAliasQry)->(DbCloseArea())
cQuery:=" select sb2.r_e_c_n_o_ recsb2,sb1.r_e_c_n_o_ recsb1"
cQuery+=" from "+RetSqlName("SB1")+" sb1,"+RetSqlName("SB2")+" sb2"
cQuery+=" where sb1.b1_filial='"+xFilial("SB1")+"'"
cQuery+=" and sb1.b1_cod between '"+Space(Len(SB1->B1_COD))+"' and '"+Replicate('Z',Len(SB1->B1_COD))+"'"
cQuery+=" and sb1.b1_tipo='PA'"
cQuery+=" and sb1.d_e_l_e_t_=' '"
cQuery+=" and sb2.b2_filial='"+xFilial("SB2")+"'"
cQuery+=" and sb2.b2_cod=sb1.b1_cod"
cQuery+=" and sb2.b2_qatu+sb2.b2_reserva>0"
cQuery+=" and sb2.b2_local in "+FormatIn(cArmazem,";")
cQuery+=" and sb2.d_e_l_e_t_=' '"
cQuery+=" and not Exists (Select 'X' From "+RetSqlName("SB7")+" SB7 "
cQuery+=" 				  Where SB7.B7_FILIAL='"+xFilial("SB7")+"'"
cQuery+="              and sb7.b7_doc   = '"+cDocto+"'"
cQuery+=" 				  and sb7.b7_cod=sb2.b2_cod"
cQuery+=" 				  and sb7.b7_local=sb2.b2_local"
cQuery+=" 				  and sb7.d_e_l_e_t_=' ')"
cQuery+=" Order By B2_COD,B2_LOCAL"
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.T.)


ProcRegua(0)
Do While (cAliasQry)->(!Eof())
	
	IncProc("Ajustando Tabela de Inventario")
	
	SB1->(DbGoTo((cAliasQry)->recsb1))
	SB2->(DbGoTo((cAliasQry)->recsb2))
	
	RecLock( "SB7", .T. )
	SB7->B7_FILIAL		:= xFilial( "SB7" )
	SB7->B7_COD			:= SB2->B2_COD
	SB7->B7_LOCAL		:= SB2->B2_LOCAL
	SB7->B7_TIPO		:= SB1->B1_TIPO
	SB7->B7_DOC			:= cDocto
	SB7->B7_DATA		:= dDatInv
	SB7->B7_QUANT		:= 0
	SB7->B7_QTSEGUM	:= 0
	SB7->B7_ORIGEM		:= 'AJUSTE'
	(cAliasQry)->(DbSkip())
EndDo                       

If IsIncallStack("A003Exec")
	U_A003LOG()
EndIf


(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function A003ProcIn()
Local aAeraAtu:=GetArea()
Local cDiretorio	:="\ProcInvVenda\"
Local aDbfStru    :={}
Local lExistArq
Local cNomeWorkNcInv	:="P"+cFilAnt+Dtos(MsDate())
Local cNomeTrbNcInv		:="E"+cFilAnt+Dtos(MsDate())
Local cExtensao	:=GetDBExtension()
Local aProcesso	:={}
Local aFoldCabec	:={""}
Local aFoldItens	:={""}
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| oDlg:End() }
Local bCancel	:={|| oDlg:End() }
Local aButtons	:={}
Local aCores	:={}
Local oDlg
Local aCabec	:={}   
Local aItem		:={}
Local aTemps	:={} 
Local aDirectory
Local cAliasProc
Local cAliasExec         
Local nHDL

Private aCpoTrbNcInv	:={}
Private aCpoBrw	:={}
Private cMarca		:= GetMark()
Private lInverte := .F.

If !Semaforo(.T.,@nHDL,"PTA00003")
	MsgInfo("Fun็ใo sendo utilizada em outra esta็ใo")
	Return()
EndIf


If !ExistDir(cDiretorio) .And. MakeDir(Trim(cDiretorio))<>0
	Return
EndIf


aAdd(aCores,{ "Empty(WorkNcInv->USUARIO)","BR_VERMELHO"})
aAdd(aCores,{"!Empty(WorkNcInv->USUARIO)","BR_VERDE"	})

AADD(aProcesso,{'Ativar produtos'," U_A0003ATI"} )
AADD(aProcesso,{'Relat๓rio Posicao Estoque'," U_MATR260"} )
AADD(aProcesso,{'Refaz Acumulados',"MATA215"} )
AADD(aProcesso,{'Saldo Atual',"MATA300"} )
AADD(aProcesso,{'Recalculo do Custo M้dio',"MATA330"} )
AADD(aProcesso,{'Importa็ใo do arquivo de inventแrio',"U_PTA00003"} )
AADD(aProcesso,{'Relat๓rio Conferencia entre inventแrio',"U_UMATR285"} )
AADD(aProcesso,{'Processar Produtos nใo contados fisicamente',"U_A003INVENT"} )
AADD(aProcesso,{'Processar Inventario'," MATA340"} )
AADD(aProcesso,{'Recalculo do Custo M้dio',"MATA330"} )
AADD(aProcesso,{'Fechamento (Virada de Saldo)',"MATA280"} )
AADD(aProcesso,{'Inativar produtos'," U_A0003INA"} )

AADD(aDbfStru,{"PROCESSO"	,"C",50,0}  )
AADD(aDbfStru,{"DTPROC"    ,"D",08,0}  )
AADD(aDbfStru,{"HORA"    	,"C",08,0}  )
AADD(aDbfStru,{"USUARIO"	,"C",20,0}  )
AADD(aDbfStru,{"FUNCAO"		,"C",20,0}  )
AADD(aDbfStru,{"NOMEALIAS"	,"C",10,0}  )

aDbfTrbNcInv:=aClone(aDbfStru)


lExistArq:=File(cDiretorio+cNomeWorkNcInv+cExtensao)
If !lExistArq
	DbCreate( cDiretorio+cNomeWorkNcInv,aDbfStru,__LocalDrive)
	DbCreate( cDiretorio+cNomeTrbNcInv ,aDbfStru,__LocalDrive)
EndIf

If Select("WorkNcInv")>0
	WorkNcInv->(DbCloseArea())
EndIf

DbUseArea( .T., __LocalDrive , cDiretorio+cNomeWorkNcInv, 'WorkNcInv', .F. )
If Select("TrbNcInv")>0
	TrbNcInv->(DbCloseArea())
EndIf
DbUseArea( .T., __LocalDrive , cDiretorio+cNomeTrbNcInv, 'TrbNcInv', .F. )
IndRegua("TrbNcInv",cNomeTrbNcInv+OrdBagExt(),"PROCESSO", , , ,.F. )
If !lExistArq
	For nInd:=1 To Len(aProcesso)
		WorkNcInv->(DbAppend())
		WorkNcInv->Processo	:=StrZero(nInd,2)+"-"+aProcesso[nInd,1]
		WorkNcInv->Funcao	:=aProcesso[nInd,2]
	Next
EndIf

AADD(aCabec,"Processos-"+Dtoc(MsDate()))
AADD(aItem,"Execu็oes-"+Dtoc(MsDate()))


aDirectory:=Directory(cDiretorio+"P*"+cExtensao)
aSort(aDirectory,,,{|x,y| x[1]>y[1]})          
For nInd:=1 To Len(aDirectory)

   cNomeArq:=RetArq(,aDirectory[nInd,1])
 	If cNomeArq==cNomeWorkNcInv
 		Loop
 	EndIf	                                                                   
 	
	cAliasProc:=cNomeArq
	cAliasExec:="E"+SubStr(cNomeArq,2)
 	dDataTemp:=Stod(Right(cNomeArq,8))
 	
	DbUseArea( .T., __LocalDrive , cDiretorio+aDirectory[nInd,1], cAliasProc, .F. )
	If Select(cAliasProc)>0
	   AADD(aCabec,"Processos-"+Dtoc(dDataTemp))   
	EndIf   
	                                        
	cNomeExec:=cDiretorio+"E"+SubStr(aDirectory[nInd,1],2)
	If !File(cNomeExec)
		DbCreate( cNomeExec ,aDbfStru,__LocalDrive)		
	EndIf                                                             
	
	DbUseArea( .T., __LocalDrive , cNomeExec, cAliasExec, .F. )		
	If Select(cAliasExec)>0
	   AADD(aItem,"Execu็oes-"+Dtoc(dDataTemp))   
	EndIf   
   IndRegua(cAliasExec,cNomeExec+OrdBagExt(),"PROCESSO", , , ,.F. )
	AADD(aTemps, {cAliasProc ,cAliasExec }   )                   
	
Next


aAdd( aCpoBrw, { "PROCESSO",	, "Processo",					" " } )
aAdd( aCpoBrw, { "DTPROC",		, "Data"		,					" " } )
aAdd( aCpoBrw, { "HORA",		, "Hora"		,					" " } )
aAdd( aCpoBrw, { "USUARIO",	, "Usuario"	,					" " } )
aAdd( aCpoBrw, { {|| ""},	, " "	,					" " } )

aAdd( aCpoTrbNcInv, { "PROCESSO",	, "Processo",					" " } )
aAdd( aCpoTrbNcInv, { "DTPROC",		, "Data"		,					" " } )
aAdd( aCpoTrbNcInv, { "HORA",		, "Hora"		,					" " } )
aAdd( aCpoTrbNcInv, { "USUARIO",	, "Usuario"	,					" " } )
aAdd( aCpoTrbNcInv, { {|| ""},	, " "	,					" " } )

aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,   90, .T., .T. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

aadd(aButtons,{"BUDGET",{|| A003Exec()   },"Executar Processo", "Executar Processo" })


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCalcula o Size para os Foldersณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE "Inventario Venda" From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

oFoldCabec := TFolder():New(aPosObj[1,1],aPosObj[1,2],aCabec,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[1,3]-aPosObj[1,1]-15
nGd4 := aPosObj[1,4]-aPosObj[1,2]-4


nGd5 := aPosObj[2,3]-aPosObj[2,1]-15
nGd6 := aPosObj[2,4]-aPosObj[2,2]-4


WorkNcInv->(DbGoTop())
oWorkNcInv :=MsSelect():New("WorkNcInv","",,aCpoBrw,@lInverte,@cMarca,{nGd1,nGd2,nGd3,nGd4} ,/*cTopFun*/,/*cBotFun*/ ,oFoldCabec:aDialogs[1],,aCores)
oWorkNcInv:bAval:={|| A003Exec() }
oWorkNcInv:oBrowse:bChange:={|| oTrbNcInv:oBrowse:SetFilter("PROCESSO",WorkNcInv->Processo),oTrbNcInv:oBrowse:Default(),oTrbNcInv:oBrowse:Refresh()}

oFoldItens := TFolder():New(aPosObj[2,1],aPosObj[2,2],aItem,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
oTrbNcInv :=MsSelect():New("TrbNcInv",,,aCpoTrbNcInv,.F.,,{nGd1,nGd2,nGd5,nGd6} ,/*cTopFun*/,/*cBotFun*/ ,oFoldItens:aDialogs[1],,/*aCores*/)

For nInd:=1 To Len(aTemps)                 

	nFolder	:=nInd+1
	oFoldCabec:adialogs[nFolder]:cargo:=aTemps[nInd,1]	
	oFoldItens:adialogs[nFolder]:cargo:=aTemps[nInd,2]
	cObjProc	:='oBrw'+AllTrim(Str(nInd))
	cObjExec	:='oTrb'+AllTrim(Str(nInd))		           
	
	&(cObjProc+':=MsSelect():New("'+aTemps[nInd,1]+'","","",aCpoBrw,.F.,,{nGd1,nGd2,nGd3,nGd4} ,/*cTopFun*/,/*cBotFun*/ ,oFoldCabec:aDialogs['+AllTrim(Str(nFolder))+'],,)')	
	//&(cObjProc+':oBrowse:bChange:={|| A003Filtro(),Eval('+cObjExec+':oBrowse:bGoTop),'+cObjExec+':oBrowse:Refresh() }')	

	&(cObjExec+':=MsSelect():New("'+aTemps[nInd,2]+'","","",aCpoTrbNcInv,.F.,,{nGd1,nGd2,nGd5,nGd6} ,/*cTopFun*/,/*cBotFun*/ ,oFoldItens:aDialogs['+AllTrim(Str(nFolder))+'],,)')
Next


ACTIVATE MSDIALOG oDlg Centered ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons),TrbNcInv->(DbGoTop()),Eval(oTrbNcInv:oBrowse:bGoTop),	oTrbNcInv:oBrowse:Refresh(),Eval(oTrbNcInv:oBrowse:bChange) )

	//&(cObjProc+':oBrowse:bChange:={|| oTrbNcInv:oBrowse:SetFilter("PROCESSO",((oBrw'+AllTrim(Str(nInd))+':OBROWSE:CALIAS))->Processo),'+cObjExec+':oBrowse:Default(),'+cObjExec+':oBrowse:Refresh()}')	
	//

WorkNcInv->(DbCloseArea())
TrbNcInv->(DbCloseArea()) 

For nInd:=1 To Len(aTemps)
	If Select(aTemps[nInd,1])>0
		(aTemps[nInd,1])->(DbCloseArea())
	EndIf	
	
	If Select(aTemps[nInd,2])>0
		(aTemps[nInd,2])->(DbCloseArea())
	EndIf	     
	Ferase(cNomeExec+OrdBagExt())

Next

Semaforo(.F.,@nHDL,"PTA00003")
RestArea(aAeraAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A003Exec()
Local bProcesso:=&("{||"+AllTrim(WorkNcInv->FUNCAO)+"()}" )

If !MsgYesNo("Confirma Execucao "+AllTrim(WorkNcInv->PROCESSO)+"?" )
	Return
EndIf

Eval(bProcesso)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ         C                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function A003Log()
Local dDataExec:=MsDate()
Local cHoraExec:=Time()
Local cParam	:=""
Local xStr
Local FIMFIELD:=Chr(13)+Chr(10)
//Local cPerg		:=AllTrim(WorkNcInv->Pergunta)


WorkNcInv->DTPROC  :=dDataExec
WorkNcInv->HORA	  :=cHoraExec
WorkNcInv->USUARIO :=cUsername

TrbNcInv->(DbAppend())
TrbNcInv->PROCESSO:=WorkNcInv->PROCESSO
TrbNcInv->DTPROC	 :=WorkNcInv->DTPROC
TrbNcInv->HORA	 :=WorkNcInv->HORA
TrbNcInv->USUARIO :=WorkNcInv->USUARIO

TrbNcInv->(DbGoTop())
Eval(oTrbNcInv:oBrowse:bGoTop)
oTrbNcInv:oBrowse:Refresh()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+"_.LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/14/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A003Filtro()
Local cProcesso	
Local cAliasItem  

If !oFoldCabec:noption==1
	(cAliasItem)->(dbClearFilter())	                                             
	cProcesso	:=(oFoldCabec:adialogs[oFoldCabec:noption]:Cargo)->Processo 
	cAliasItem  :=AllTrim(oFoldItens:adialogs[oFoldItensc:noption]:Cargo)   
	(cAliasItem)->(DbSetFilter({||(cAliasItem)->Processo==cProcesso},'(cAliasItem)->Processo==cProcesso' ))
EndIf	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/18/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function A0003ATI()
Processa({|| A0003BLQ("A") }  )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/18/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function A0003INA()
Processa({|| A0003BLQ("I") }  )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPTA00003  บAutor  ณMicrosiga           บ Data ณ  09/18/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function A0003BLQ(cParam)
Local aAreaAtu	:=GetArea()
Local cArqQry	:= GetNextAlias()
Local nLenCod	:=AvSx3("B1_COD",3)
Local cMensagem:=AllTrim(WorkNcInv->PROCESSO)
Local lSucesso:=.F.

ProcRegua(2)   
IncProc(cMensagem)


If cParam=="A" //Ativar
	If (lSucesso:=(TcSQLExec("Update "+RetSqlName("SB1")+" Set B1_TECLA='1'  Where B1_MSBLQL='1' And  D_E_L_E_T_=' '" )==0 .And.	TcSQLExec("Update "+RetSqlName("SB1")+" Set B1_MSBLQL='2' Where B1_MSBLQL='1' And  D_E_L_E_T_=' '" )==0))
		TcSQLExec("Commit")
	EndIf	
Else // Inativar
	If (lSucesso:=(TcSQLExec("Update "+RetSqlName("SB1")+" Set B1_MSBLQL='1' Where B1_TECLA='1' And  D_E_L_E_T_=' '" )==0 .And. TcSQLExec("Update "+RetSqlName("SB1")+" Set B1_TECLA=' '  Where B1_TECLA='1' And  D_E_L_E_T_=' '" )==0))
		TcSQLExec("Commit")
	EndIf		
EndIf	            

IncProc(cMensagem)

If !lSucesso
	MsgStop("Erro ao executar " +cMensagem+Space(2)+TCSQLError())
Else	
	MsgInfo(cMensagem+" efetuado com sucesso")
ENDIF


U_A003LOG()
RestArea(aAreaAtu)
Return
