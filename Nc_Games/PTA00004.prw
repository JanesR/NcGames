#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"

STATIC cAdmArq

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  08/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PTA00004()
Local aSays:={}
Local aButtons:={}
Local lOk
Local cNomeUser

Private aLogPrc:={}
Private cArquivo:=""



AADD( aSays, "Este processo tem como objetivo realizar o Inventario" )
AADD( aSays, "baseado em arquivo Txt" )
AADD( aButtons, { 01, .T., {|| lOk := .T.,(cArquivo:=cGetFile("Arquivo TXT | *.txt","Selecione o arquivo ",,,.T.)) ,Iif( File(cArquivo), FechaBatch(), msgStop("Arquivo Txt: "+cArquivo+" n�o localizado.") ) } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
;FormBatch( "Atualiza��o Invent�rio", aSays, aButtons )

If lOk
	Processa({|| A00004Imp() }, "Verificando arquivo TXT" )
EndIf


Return


Return( Nil )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  08/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A00004Imp()
Local dDatInv		:= MsDate()
Local cDocto		:=""
Local cPerg			:="A00004Imp"

If !File(cArquivo)
	MsgAlert("Arquivo texto: "+cArquivo+" n�o localizado")
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
	
	If !Pergunte("A00004Imp")
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
	
	If Aviso(	"PTA00004-03","Data Invent�rio: " + DToC( dDatInv ) + "." + CRLF +"N�mero de Documento: " + AllTrim( cDocto ) + "." + CRLF +"Houve um processamento com as mesmas informa��es." + CRLF +;
		"Se continuar o inventario anterior ser� excluido" + CRLF +	"Deseja Continuar ?",{ "&Abandona", "&Continua" },3,"Duplicidade Inventario" ) <> 2
		Return( .F. )
	ElseIf !ChkInv( dDatInv, cDocto,.T. )
		Return
	EndIf
EndIf


A004File(dDatInv,cDocto)


If Len(aLogPrc)>0
	A001Tela()
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  08/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A004File(dDatInv,cDocto)
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



//aAdd( aLogPrc, {	"UPDINFORMATION",	"In�cio do Processo Arquivo "+cArquivo,	+ DToC( MsDate() ) + " �s " + Time() + ".",	} )
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
	cLocal	:= aDados[3]
	nQuant	:= Val( aDados[4] )
	cLinha	:=StrZero(nLinha,5)
	
	If dDatInv<>STOD( aDados[1] )
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4], 	"Data do Invent�rio "+DTOC(dDatInv)+" difere da data do arquivo"+Dtoc(STOD( aDados[1] ))} )
		FT_FSKIP();Loop
	EndIf
	
	
	
	If !SB1->(MsSeek(xFilial("SB1")+cCodPro))
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4], "Produto "+cCodPro+" n�o encontado."} )
		FT_FSKIP();Loop
	EndIf
	
	
	//If !SX5->(MsSeek(xFilial("SX5")+"ZZ"+cLocal))
		//aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4], "Armazem n�o encontrado."} )
		//FT_FSKIP();Loop
	//EndIf
	
	
	If !SB2->(MsSeek(xFilial("SB2")+cCodPro+cLocal))
		CriaSB2(cCodPro,cLocal)
		aAdd( aLogPrc, {	"UPDWARNING",	cLinha,cCodPro,cLocal,aDados[4], "Armaz�m criado.!! Aten��o o custo est� zerado para o produto."} )
	EndIf
	
	
	
	If nQuant<0
		aAdd( aLogPrc, {	"UPDERROR",	cLinha,cCodPro,cLocal,aDados[4], "Quantidade "+AllTrim(Str(nQuant))+" invalida"} )
		FT_FSKIP();Loop
	EndIf
	
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
	FT_FSKIP()
EndDo

FT_FUSE()
aLogPrc := Asort(aLogPrc,,,{|x,y| x[1]+x[2] > y[1]+y[2]})

If IsIncallStack("A004Exec")
	U_A004LOG()
EndIf



Return( Nil )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  08/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  03/19/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A001Tela()
Local oDlg
//�����������������������������������������������������������������������������������������Ŀ
//� Mostra a tela com o resumo do processamento                                             �
//�������������������������������������������������������������������������������������������
DEFINE MSDIALOG oDlg TITLE "Resumo do Processamento" FROM 000,000 TO 400,810 OF oDlg PIXEL
DEFINE SBUTTON FROM 187,345 TYPE 1 OF oDlg ENABLE ACTION( oDlg:End() )
DEFINE SBUTTON FROM 187,375 TYPE 6 OF oDlg ENABLE ACTION( ImpRel() )
@ 005,004 LISTBOX oLst FIELDS HEADER		" ","Linha","Produto","Armazem","Quantidade","Motivo" SIZE 400,180 OF oDlg PIXEL

oLst:SetArray( aLogPrc )
oLst:bLine := { || {	LoadBitMap( GetResources(), aLogPrc[oLst:nAt,01] ),;	// Imagem
aLogPrc[oLst:nAt,02],;
aLogPrc[oLst:nAt,03],;
aLogPrc[oLst:nAt,04],;
aLogPrc[oLst:nAt,05],;
aLogPrc[oLst:nAt,06] ;											// Detalhes
} }
ACTIVATE DIALOG oDlg CENTERED


//COLSIZES	GetTextWidth( 0, "BBB" ),;
//GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBB" ),;
//GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" ),;
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  08/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
aAdd( aCabec, { "Armazem"		,	1, 1, .F. } )
aAdd( aCabec, { "Quantidade"	,	1, 1, .F. } )
aAdd( aCabec, { "Observa��o"	,	1, 1, .F. } )


//������������������������������������������������������������������������������������������Ŀ
//� Monta array com os itens da planilha                                                     �
//��������������������������������������������������������������������������������������������
For nLoop := 1 to Len( aLogPrc )
	//��������������������������������������������������������������������������������������Ŀ
	//� Alimenta o array que gera o Excel                                                    �
	//����������������������������������������������������������������������������������������
	aAdd( aItens, Array( Len(aCabec) ) )
	nLine:=Len( aItens )
	cMotivo	:= "Sem Defini��o"
	//��������������������������������������������������������������������������������������Ŀ
	//� Grava as informa��es do documento de origem                                          �
	//����������������������������������������������������������������������������������������
	If "UPDINFORMATION" $ aLogPrc[nLoop,01]
		cMotivo	:= "Informa��o"
	ElseIf "UPDERROR" $ aLogPrc[nLoop,01]
		cMotivo	:= "Erro"
	ElseIf "UPDWARNING" $ aLogPrc[nLoop,01]
		cMotivo	:= "Aten��o"
	ElseIf "QMT_OK" $ aLogPrc[nLoop,01]
		cMotivo	:= "Processo Conclu�do Com Sucesso"
	ElseIf "QMT_COND" $ aLogPrc[nLoop,01]
		cMotivo	:= "Processo Conclu�do Com Aten��o"
	ElseIf "QMT_NO" $ aLogPrc[nLoop,01]
		cMotivo	:= "Processo Conclu�do Com Divereg�ncia"
		
		
	EndIf
	
	aItens[nLine,01]	:= cMotivo
	aItens[nLine,02]	:= aLogPrc[nLoop,02]
	aItens[nLine,03]	:= aLogPrc[nLoop,03]
	aItens[nLine,04]	:= aLogPrc[nLoop,04]
	aItens[nLine,05]	:= aLogPrc[nLoop,05]
	aItens[nLine,06]	:= aLogPrc[nLoop,06]
Next nLoop
//�����������������������������������������������������������������������������������������Ŀ
//� Se tem dados exporta para o Excel                                                       �
//�������������������������������������������������������������������������������������������
If Len( aItens ) > 0
	Msgrun( "Gerando Planilha Excel", "Inventario NcGames", { || FExExcel( aCabec, aItens ) } )
	//�����������������������������������������������������������������������������������������Ŀ
	//� Se n�o tem dados aviso usu�rio                                                          �
	//�������������������������������������������������������������������������������������������
Else
	Aviso(	cTitle,;
	"N�o h� registros a exportar.",;
	{"&Ok"},3,;
	"Sem Dados" )
EndIf

Return( Nil )

/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
���Programa    �FExExcel�Exporta os dados para arquivo Excel                              ���
�����������������������������������������������������������������������������������������͹��
���Autor       �14.11.13�ACPD Inform�tica                                                 ���
�����������������������������������������������������������������������������������������͹��
���Par�metros  �ExpC1 = Alias do grupo de perguntas                                       ���
�����������������������������������������������������������������������������������������͹��
���Retorno     �Nil.                                                                      ���
�����������������������������������������������������������������������������������������͹��
���Observa��es �                                                                          ���
�����������������������������������������������������������������������������������������͹��
���Altera��es  � 99.99.99 - Consultor - Descri��o da Altera��o                            ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
Static Function FExExcel( aCabec,aItens )
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local oExcelApp	:= Nil
Local oExcel	:= FWMSEXCEL():New()
Local lVisual	:= .T.
Local nLoop		:= 0
Local cArquivo	:= CriaTrab(,.F.) + ".xls"
Local cDirDocs	:= MsDocPath()
Local cPath		:= AllTrim(GetTempPath())
Local cWSheet	:= "Resumo do Processamento"
Local cTable	:= "Log de erros no processo de importa��o do inventario"
//�����������������������������������������������������������������������������������������Ŀ
//� Verifica se a esta��o tem o Excel instalado                                             �
//�������������������������������������������������������������������������������������������
If !ApOleClient('MsExcel')
	Aviso(	"FExExcel-01",;
	"MsExcel n�o instalado na esta��o de trabalho." + CRLF +;
	"O Arquivo ser� gerado no diretorio "+cPath+" mas n�o ser� poss�vel abrir para visualiza��o do mesmo.",;
	{ "&Continua" },3,;
	"Arquivo: " + AllTrim( cPath ) + AllTrim( cArquivo ) )
	lVisual	:= .F.
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Define as configura��es de cabe�alho                                                    �
//�������������������������������������������������������������������������������������������
oExcel:SetTitleSizeFont( 12 )
oExcel:SetTitleItalic( .T. )
oExcel:SetTitleBold( .T. )
oExcel:SetTitleFrColor( "#FFFFFF" )	//Cor de Fonte - Branco
oExcel:SetTitleBgColor( "#00009C" )	//Cor da Fundo - Azul Escuro
//�����������������������������������������������������������������������������������������Ŀ
//� Cria a WorkSheet                                                                        �
//�������������������������������������������������������������������������������������������
oExcel:AddworkSheet( cWSheet )
//�����������������������������������������������������������������������������������������Ŀ
//� Cria a Tabela                                                                           �
//�������������������������������������������������������������������������������������������
oExcel:AddTable( cWSheet, cTable )
//�����������������������������������������������������������������������������������������Ŀ
//� Cria o Cabe�alho                                                                        �
//�������������������������������������������������������������������������������������������
For nLoop := 1 To Len( aCabec )
	//	cWorkSheet,	cTable,	cColumm,			nAlign,				nFormat,			lTotal
	oExcel:AddColumn(	cWSheet,	cTable, aCabec[nLoop,01],	aCabec[nLoop,2],	aCabec[nLoop,3],	aCabec[nLoop,4] )
Next nLoop
//�����������������������������������������������������������������������������������������Ŀ
//� Cria os Itens                                                                           �
//�������������������������������������������������������������������������������������������
For nLoop := 1 to Len( aItens )
	oExcel:AddRow( cWSheet, cTable, aItens[nLoop] )
Next nLoop
//�����������������������������������������������������������������������������������������Ŀ
//� Fez a montagem correta do objeto excel                                                  �
//�������������������������������������������������������������������������������������������
If !Empty(oExcel:aWorkSheet)
	//�������������������������������������������������������������������������������������Ŀ
	//� Ativa o objeto e gera o arquivo                                                     �
	//���������������������������������������������������������������������������������������
	oExcel:Activate()
	oExcel:GetXMLFile(cDirDocs+"\"+cArquivo)
	//�������������������������������������������������������������������������������������Ŀ
	//� Copia para a esta��o de trabalho o arquivo gerado                                   �
	//���������������������������������������������������������������������������������������
	CpyS2T(cDirDocs+"\"+cArquivo,cPath)
	//�������������������������������������������������������������������������������������Ŀ
	//� Abre o arquivo no excel se existir na esta��o de trabalho                           �
	//���������������������������������������������������������������������������������������
	If lVisual
		oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open(cPath+cArquivo) // Abre uma planilha
		oExcelApp:SetVisible(.T.)
		oExcelApp:Destroy()
	EndIf
Else
	Aviso(	"FExExcel-01",;
	"N�o foi poss�vel criar a planilha com os dados selecionados." + CRLF +;
	"Verifique os par�metros utilizados para execu��o da rotina.",;
	{ "&Continua" },3,;
	"Sem Dados" )
EndIf

Return( Nil )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function A004Invent()
Local aSays:={}
Local aButtons:={}
Local lOk


AADD( aSays, "Este processo tem como objetivo ajustar o inventario adicionando os produtos n�o" )
AADD( aSays, " contados no fisico." )
AADD( aButtons, { 01, .T., {|| lOk := .T., FechaBatch() } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
;FormBatch( "Atualiza��o Invent�rio", aSays, aButtons )

If lOk
	Processa({|| A00004App() }, "Ajustando..." )
EndIf


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  08/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A00004App()  //nAO CONTATADO FISICOS
Local aAreaAtu		:=GetArea()
Local dDatInv		:= MsDate()
Local cDocto		:=""
Local cQuery		:=""
Local cAliasQry	:=GetNextAlias()
Local cPerg			:="A00004Imp"
Local cArmazem:=""

PutSX1(cPerg,"01","Nome Documento Inventario"   ,""		,""		,"mv_ch1","C",09,0,1,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
Do While .T.
	
	If !Pergunte("A00004Imp")
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

If IsIncallStack("A004Exec")
	U_A004LOG()
EndIf


(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function A004ProcIn()
Local aAeraAtu:=GetArea()
Local cDiretorio	:="\ProcInvNaoVenda\"
Local aDbfStru    :={}
Local lExistArq
Local cNomeWorkNcInv		:="P"+cFilAnt+Dtos(MsDate())
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

If !Semaforo(.T.,@nHDL,"PTA00004")
	MsgInfo("Fun��o sendo utilizada em outra esta��o")
	Return()
EndIf


If !ExistDir(cDiretorio) .And. MakeDir(Trim(cDiretorio))<>0
	Return
EndIf


aAdd(aCores,{ "Empty(WorkNcInv->USUARIO)","BR_VERMELHO"})
aAdd(aCores,{"!Empty(WorkNcInv->USUARIO)","BR_VERDE"	})

AADD(aProcesso,{'Relat�rio Posicao Estoque'," U_MATR260"} )
AADD(aProcesso,{'Refaz Acumulados',"MATA215"} )
AADD(aProcesso,{'Saldo Atual',"MATA300"} )
AADD(aProcesso,{'Recalculo do Custo M�dio',"MATA330"} )
AADD(aProcesso,{'Importa��o do arquivo de invent�rio',"U_PTA00004"} )
AADD(aProcesso,{'Relat�rio Conferencia entre invent�rio',"U_NCTR285"} )
//AADD(aProcesso,{'Processar Produtos n�o contados fisicamente',"U_A004INVENT"} )
AADD(aProcesso,{'Processar Inventario'," MATA340"} )
AADD(aProcesso,{'Recalculo do Custo M�dio',"MATA330"} )
//AADD(aProcesso,{'Fechamento (Virada de Saldo)',"MATA280"} )

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
AADD(aItem,"Execu�oes-"+Dtoc(MsDate()))


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
	   AADD(aItem,"Execu�oes-"+Dtoc(dDataTemp))   
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

aadd(aButtons,{"BUDGET",{|| A004Exec()   },"Executar Processo", "Executar Processo" })


//��������������������������������
//�Calcula o Size para os Folders�
//��������������������������������
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE "Inventario Nao Venda" From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

oFoldCabec := TFolder():New(aPosObj[1,1],aPosObj[1,2],aCabec,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[1,3]-aPosObj[1,1]-15
nGd4 := aPosObj[1,4]-aPosObj[1,2]-4


nGd5 := aPosObj[2,3]-aPosObj[2,1]-15
nGd6 := aPosObj[2,4]-aPosObj[2,2]-4


WorkNcInv->(DbGoTop())
oWorkNcInv :=MsSelect():New("WorkNcInv","",,aCpoBrw,@lInverte,@cMarca,{nGd1,nGd2,nGd3,nGd4} ,/*cTopFun*/,/*cBotFun*/ ,oFoldCabec:aDialogs[1],,aCores)
oWorkNcInv:bAval:={|| A004Exec() }
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
	//&(cObjProc+':oBrowse:bChange:={|| A004Filtro(),Eval('+cObjExec+':oBrowse:bGoTop),'+cObjExec+':oBrowse:Refresh() }')	

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
                

Semaforo(.F.,@nHDL,"PTA00004")

RestArea(aAeraAtu)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A004Exec()
Local bProcesso:=&("{||"+AllTrim(WorkNcInv->FUNCAO)+"()}" )

If !MsgYesNo("Confirma Execucao "+AllTrim(WorkNcInv->PROCESSO)+"?" )
	Return
EndIf

Eval(bProcesso)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �         C                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function A004Log()
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/14/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A004Filtro()
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PTA00004  �Autor  �Microsiga           � Data �  09/14/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
	#define STR0001 If( cPaisLoc $ "ANG|PTG", "Listagem Dos Itens Inventariados", "Listagem dos Itens Inventariados" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Emite uma rela��o que mostra o saldo em stock e todas as", "Emite uma relacao que mostra o saldo em estoque e todas as" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Contagens efectuadas no invent�rio. baseado nestas duas in-", "contagens efetuadas no inventario. Baseado nestas duas in-" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Forma��es ele calcula a diferen�a encontrada.", "formacoes ele calcula a diferenca encontrada." )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", " por c�digo    ", " Por Codigo    " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", " por tipo      ", " Por Tipo      " )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", " por grupo   ", " Por Grupo   " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", " por descri��o ", " Por Descricao " )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", " por armaz�m  ", " Por Armazem  " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "C�digo de barras", "Zebrado" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Administra��o", "Administracao" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Artigo(s)", "PRODUTO(S)" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "C�digo          descri��o                      lote       sub    tp grp um amz documento         quantidade         qtd na data       _____________diferen�a______________", "CODIGO          DESCRICAO                      LOTE       SUB    TP GRP UM AMZ DOCUMENTO         QUANTIDADE         QTD NA DATA       _____________DIFERENCA______________" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "                                                          Lote                                  Inventariada       Do Invent�rio         Quantidade              Valor", "                                                          LOTE                                  INVENTARIADA       DO INVENTARIO         QUANTIDADE              VALOR" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "A Seleccionar Registos...", "Selecionando Registros..." )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Cancelado Pelo Operador", "CANCELADO PELO OPERADOR" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Total .................", "TOTAL ................." )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Total do tipo ", "TOTAL DO TIPO " )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Total do grupo ", "TOTAL DO GRUPO " )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Total das diferen�as em valor .............", "TOTAL DAS DIFERENCAS EM VALOR ............." )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "C�digo          descri��o                      tp grp um amz documento         quantidade         qtd na data       _______________diferen�a_____________", "CODIGO          DESCRICAO                      TP GRP UM AMZ DOCUMENTO         QUANTIDADE         QTD NA DATA       _______________DIFERENCA_____________" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "                                                                              Inventariada       Do Invent�rio         Quantidade              Valor", "                                                                              INVENTARIADA       DO INVENTARIO         QUANTIDADE              VALOR" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "C�digo          descri��o                      lote       sub    endere�o        n�mero de s�rie      tp grp um amz documento         quantidade         qtd na data       _____________diferen�a______________", "CODIGO          DESCRICAO                      LOTE       SUB    ENDERECO        NUMERO DE SERIE      TP GRP UM AMZ DOCUMENTO         QUANTIDADE         QTD NA DATA       _____________DIFERENCA______________" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "                                                          Lote                                                                      Inventariada        Do Invent�rio         Quantidade              Valor", "                                                          LOTE                                                                      INVENTARIADA        DO INVENTARIO         QUANTIDADE              VALOR" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "C�digo          descri��o                      endere�o        n�mero de s�rie      tp grp um amz documento         quantidade         qtd na data       _______________diferen�a_____________", "CODIGO          DESCRICAO                      ENDERECO        NUMERO DE SERIE      TP GRP UM AMZ DOCUMENTO         QUANTIDADE         QTD NA DATA       _______________DIFERENCA_____________" )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "                                                                                                                   Inventariada       Do Invent�rio          Quantidade              Valor", "                                                                                                                   INVENTARIADA       DO INVENTARIO          QUANTIDADE              VALOR" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "C�digo", "CODIGO" )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Descri��o", "DESCRI��O" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Lote", "LOTE" )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Sub", "SUB" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Localiza��o", "LOCALIZA��O" )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "N�mero De S�rie", "NUMERO DE SERIE" )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Tp.", "TP" )
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Grupo", "GRUPO" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Um", "UM" )
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Amz", "AMZ" )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Documento", "DOCUMENTO" )
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Quantidade", "QUANTIDADE" )
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "Inventariada", "INVENTARIADA" )
		#define STR0040 If( cPaisLoc $ "ANG|PTG", "Qtd Na Data", "QTD NA DATA" )
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "Do Invent�rio", "DO INVENTARIO" )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Diferen�a", "DIFEREN�A" )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "Quantidade", "QUANTIDADE" )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", "Valor", "VALOR" )
		#define STR0045 "T o t a l :"
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Subtotal do tipo : ", "SubTotal do Tipo : " )
		#define STR0047 If( cPaisLoc $ "ANG|PTG", "Subtotal do grupo : ", "SubTotal do Grupo : " )
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "Subtotal do armaz�m : ", "SubTotal do Armazem : " )
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "T o t a l  g e r a l :", "T o t a l  G e r a l :" )
		#define STR0050 If( cPaisLoc $ "ANG|PTG", "Movimentos De Invent�rio", "Lan�amentos de Inventario" )
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � MATR285  � Autor � Marcos V. Ferreira    � Data � 20/06/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Listagem dos itens inventariados                           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCTR285()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//������������������������������������������������������������������������Ŀ
	//�Interface de impressao                                                  �
	//��������������������������������������������������������������������������
	oReport:= ReportDef()
	oReport:PrintDialog()
Else
	MATR285R3()
EndIf

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor �Marcos V. Ferreira     � Data �20/06/06  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
�������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR285			                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local aOrdem    := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009)}		//' Por Codigo    '###' Por Tipo      '###' Por Grupo   '###' Por Descricao '###' Por Local    '
Local cPictQFim := PesqPict("SB2",'B2_QFIM' )
Local cPictQtd  := PesqPict("SB7",'B7_QUANT')
Local cPictVFim := PesqPict("SB2",'B2_VFIM1')
Local cTamQFim  := TamSX3('B2_QFIM' )[1]
Local cTamQtd   := TamSX3('B7_QUANT')[1]
Local cTamVFim  := TamSX3('B2_VFIM1')[1]
#IFDEF TOP
	Local cAliasSB1 := GetNextAlias()    
	Local cAliasSB2 := cAliasSB1
	Local cAliasSB7 := cAliasSB1
#ELSE
	Local cAliasSB1 := "SB1"
	Local cAliasSB2 := "SB2"
	Local cAliasSB7 := "SB7"
#ENDIF
Local oSection1
//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport:= TReport():New("MATR285",STR0001,"MTR285", {|oReport| ReportPrint(oReport,aOrdem,cAliasSB1,cAliasSB2,cAliasSB7)},STR0002+" "+STR0003+" "+STR0004)
oReport:DisableOrientation()
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.

//��������������������������������������������������������������Ŀ
//� Ajusta o Grupo de Perguntas MTR285                           �
//����������������������������������������������������������������
AjustaSX1()

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Produto de                           �
//� mv_par02             // Produto ate                          �
//� mv_par03             // Data de Selecao                      �
//� mv_par04             // De  Tipo                             �
//� mv_par05             // Ate Tipo                             �
//� mv_par06             // De  Local                            �
//� mv_par07             // Ate Local                            �
//� mv_par08             // De  Grupo                            �
//� mv_par09             // Ate Grupo                            �
//� mv_par10             // Qual Moeda (1 a 5)                   �
//� mv_par11             // Imprime Lote/Sub-Lote                �
//� mv_par12             // Custo Medio Atual/Ultimo Fechamento  �
//� mv_par13             // Imprime Localizacao ?                �
//����������������������������������������������������������������
Pergunte(oReport:uParam,.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da secao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a secao.                   �
//�ExpA4 : Array com as Ordens do relatorio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//��������������������������������������������������������������������������

//��������������������������������������������������������������Ŀ
//� Criacao da Sessao 1                                          �
//����������������������������������������������������������������
oSection1:= TRSection():New(oReport,STR0050,{"SB1","SB7","SB2"},aOrdem) // "Lancamentos para Inventario"
oSection1:SetTotalInLine(.F.)
oSection1:SetNoFilter("SB7")
oSection1:SetNoFilter("SB2")

TRCell():New(oSection1,'B1_CODITE'	,cAliasSB1	,STR0027				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_COD'		,cAliasSB1	,STR0027				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_DESC'	,cAliasSB1	,STR0028				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOTECTL'	,cAliasSB7	,STR0029				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_NUMLOTE'	,cAliasSB7	,STR0030+CRLF+STR0029	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_LOCALIZ'	,cAliasSB7	,STR0031				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_NUMSERI'	,cAliasSB7	,STR0032				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_TIPO'	,cAliasSB1	,STR0033				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_GRUPO'	,cAliasSB1	,STR0034				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_UM'		,cAliasSB1	,STR0035				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B2_LOCAL'	,cAliasSB2	,STR0036				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_DOC'		,cAliasSB7	,STR0037				,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B7_QUANT'	,cAliasSB7	,STR0038+CRLF+STR0039	,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,'QUANTDATA'	,'   '		,STR0040+CRLF+STR0041	,cPictQFim	,cTamQFim	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,'DIFQUANT'	,'   '		,STR0042+CRLF+STR0043	,cPictQtd	,cTamQtd	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")
TRCell():New(oSection1,'DIFVALOR'	,'   '		,STR0042+CRLF+STR0044	,cPictVFim	,cTamVFim	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")

oSection1:SetHeaderPage()
oSection1:SetTotalText(STR0049) // "T o t a l  G e r a l :"

Return(oReport)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrint � Autor �Marcos V. Ferreira   � Data �20/06/06  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportPrint devera ser criada para todos  ���
���          �os relatorios que poderao ser agendados pelo usuario.       ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpO1: Objeto Report do Relatorio                           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR285			                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport,aOrdem,cAliasSB1,cAliasSB2,cAliasSB7)

Local oSection1	:= oReport:Section(1)
Local nOrdem   	:= oSection1:GetOrder()
Local cSeek    	:= ''
Local cCompara 	:= ''
Local cLocaliz 	:= ''
Local cNumSeri 	:= ''
Local cLoteCtl 	:= ''
Local cNumLote 	:= ''
Local cProduto 	:= ''
Local cLocal   	:= ''
Local cTipo     := ''
Local cGrupo    := ''
Local cWhere   	:= ''
Local cOrderBy 	:= ''
Local cFiltro  	:= ''
Local cNomArq	:= ''
Local cOrdem	:= ''
Local nSB7Cnt  	:= 0
Local nTotal   	:= 0
Local nX       	:= 0
Local nTotRegs  := 0
Local nCellTot	:= 11
Local aSaldo   	:= {}
Local aSalQtd  	:= {}
Local aCM      	:= {}
Local aRegInv   := {}
Local lImprime  := .T.
Local lContagem	:= (SB7->(FieldPos("B7_CONTAGE")) > 0) .And. (SB7->(FieldPos("B7_ESCOLHA")) > 0) .And. (SB7->(FieldPos("B7_OK")) > 0) .And. SuperGetMv('MV_CONTINV',.F.,.F.)
Local lVeic		:= Upper(GetMV("MV_VEICULO"))=="S"
Local oBreak
Local oBreak01
Local nContaSkips := 0
Local lPrimReg := .T.

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas qdo almoxarifado do CQ                  �
//����������������������������������������������������������������
Local   cLocCQ  := GetMV("MV_CQ")
Private	lLocCQ  :=.T.

//������������������������������������������������������������Ŀ
//� Adiciona a ordem escolhida ao titulo do relatorio          �
//��������������������������������������������������������������
oReport:SetTitle(oReport:Title()+' (' + AllTrim(aOrdem[nOrdem]) + ')')

//��������������������������������������������������������������Ŀ
//� Definicao da linha de SubTotal                               |
//����������������������������������������������������������������  
oBreak01 := TRBreak():New(oSection1,oSection1:Cell("B1_COD"),STR0045,.F.)                          
TRFunction():New(oSection1:Cell('B7_QUANT'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)  
TRFunction():New(oSection1:Cell('QUANTDATA'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
TRFunction():New(oSection1:Cell('DIFQUANT'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)  
TRFunction():New(oSection1:Cell('DIFVALOR'	),NIL,"SUM",oBreak01,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)  

If nOrdem == 2 .Or. nOrdem == 3 .Or. nOrdem == 5
	If nOrdem == 2
		//-- SubtTotal por Tipo
		oBreak := TRBreak():New(oSection1,oSection1:Cell("B1_TIPO"),STR0046,.F.) //"SubTotal do Tipo : "
	ElseIf nOrdem == 3
		//-- SubtTotal por Grupo
		oBreak := TRBreak():New(oSection1,oSection1:Cell("B1_GRUPO"),STR0047,.F.) //"SubTotal do Grupo : "
	ElseIf nOrdem == 5
		//-- SubtTotal por Armazem
		oBreak := TRBreak():New(oSection1,oSection1:Cell("B2_LOCAL"),STR0048,.F.) //"SubTotal do Armazem : "
	EndIf
	TRFunction():New(oSection1:Cell('B7_QUANT'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell('QUANTDATA'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell('DIFQUANT'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
	TRFunction():New(oSection1:Cell('DIFVALOR'	),NIL,"SUM",oBreak,/*Titulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)
EndIf

//��������������������������������������������������������������Ŀ
//� Definicao do Total Geral do Relatorio                        �
//����������������������������������������������������������������
TRFunction():New(oSection1:Cell('B7_QUANT'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection1:Cell('QUANTDATA'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection1:Cell('DIFQUANT'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)
TRFunction():New(oSection1:Cell('DIFVALOR'	),NIL,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,/*uFormula*/,.T.,.F.)

//��������������������������������������������������������������Ŀ
//� Desliga as colunas que nao serao utilizadas no relatorio     �
//����������������������������������������������������������������
If !lVeic
	oSection1:Cell('B1_CODITE'	):Disable()
Else
	oSection1:Cell('B1_COD'		):Disable()
EndIf	

If !(mv_par11 == 1)
	oSection1:Cell('B7_LOTECTL'	):Disable()
	oSection1:Cell('B7_NUMLOTE'	):Disable()
	nCellTot-= 2
EndIf

If !(mv_par13 == 1)
	oSection1:Cell('B7_LOCALIZ'	):Disable()
	oSection1:Cell('B7_NUMSERI'	):Disable()
	nCellTot-= 2
EndIf

dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB7')
dbSetOrder(1)

dbSelectArea('SB1')
dbSetOrder(1)

nTotRegs += SB2->(LastRec())
nTotRegs += SB7->(LastRec())

#IFDEF TOP

	//��������������������������������������������������������������Ŀ
	//� ORDER BY - Adicional                                         �
	//����������������������������������������������������������������
	cOrderBy := "%"
	If nOrdem == 1 //-- Por Codigo
		If lVeic
			cOrderBy += " B1_FILIAL, B1_CODITE "
		Else
			cOrderBy += " B1_FILIAL, B1_COD "
		EndIf	
	ElseIf nOrdem == 2 //-- Por Tipo
		cOrderBy += " B1_FILIAL, B1_TIPO, B1_COD " 
	ElseIf nOrdem == 3 //-- Por Grupo
		If lVeic
			cOrderBy += " B1_FILIAL, B1_GRUPO, B1_CODITE "
		Else
			cOrderBy += " B1_FILIAL, B1_GRUPO, B1_COD "
		EndIf	
		cOrderBy += ", B2_LOCAL" 
	ElseIf nOrdem == 4 //-- Por Descricao
		cOrderBy += "B1_FILIAL, B1_DESC, B1_COD"
	ElseIf nOrdem == 5 //-- Por Local
		If lVeic
			cOrderBy += " B1_FILIAL, B2_LOCAL, B1_CODITE"
		Else
			cOrderBy += " B1_FILIAL, B2_LOCAL, B1_COD"
		EndIf	
	EndIf
	cOrderBy += "%"
	
	//��������������������������������������������������������������Ŀ
	//� WHERE - Adicional                                            �
	//����������������������������������������������������������������
	cWhere := "%"
	If lVeic
		cWhere+= "SB1.B1_CODITE	>= '"+mv_par01+"' AND SB1.B1_CODITE <= '"+mv_par02+	"' AND "
	Else
		cWhere+= "SB1.B1_COD	>= '"+mv_par01+"' AND SB1.B1_COD	<= '"+mv_par02+	"' AND "
	EndIf
    If lContagem
      cWhere+= " SB7.B7_ESCOLHA = 'S' AND "
    EndIf  
	cWhere += "%"

	//������������������������������������������������������������������������Ŀ
	//�Inicio da Query do relatorio                                            �
	//��������������������������������������������������������������������������
	oSection1:BeginQuery()	

	//������������������������������������������������������������������������Ŀ
	//�Transforma parametros Range em expressao SQL                            �
	//��������������������������������������������������������������������������
	MakeSqlExpr(oReport:uParam)

	//������������������������������������������������������������������������Ŀ
	//�Inicio do Embedded SQL                                                  �
	//��������������������������������������������������������������������������
	BeginSql Alias cAliasSB1

		SELECT 	SB1.R_E_C_N_O_ SB1REC , SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_LOCPAD, SB1.B1_TIPO, 
		        SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM, SB1.B1_CODITE, SB2.R_E_C_N_O_ SB2REC,
	    	    SB2.B2_FILIAL, SB2.B2_COD, SB2.B2_LOCAL, SB2.B2_DINVENT, SB7.R_E_C_N_O_ SB7REC,
	        	SB7.B7_FILIAL, SB7.B7_COD, SB7.B7_LOCAL, SB7.B7_DATA,SB7.B7_LOCALIZ,
		        SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE, SB7.B7_DOC, SB7.B7_QUANT,
		        SB7.B7_ESCOLHA, SB7.B7_CONTAGE

		FROM %table:SB1% SB1,%table:SB2% SB2,%table:SB7% SB7

    	WHERE SB1.B1_FILIAL =  %xFilial:SB1%	AND SB1.B1_TIPO  >= %Exp:mv_par04%	AND
	    	  SB1.B1_TIPO   <= %Exp:mv_par05%	AND SB1.B1_GRUPO >= %Exp:mv_par08%	AND
    		  SB1.B1_GRUPO  <= %Exp:mv_par09%	AND SB1.%NotDel%					AND
 			  %Exp:cWhere%
			  SB2.B2_FILIAL =  %xFilial:SB2%	AND SB2.B2_COD   =  SB1.B1_COD		AND
			  SB2.B2_LOCAL  =  SB7.B7_LOCAL		AND SB2.%NotDel%					AND
			  SB7.B7_FILIAL =  %xFilial:SB7%	AND SB7.B7_COD   =  SB1.B1_COD		AND
			  SB7.B7_LOCAL  >= %Exp:mv_par06%	AND SB7.B7_LOCAL <= %Exp:mv_par07% 	AND
			  SB7.B7_DATA   =  %Exp:Dtos(mv_par03)% AND SB7.%NotDel%

		ORDER BY %Exp:cOrderBy%

	EndSql

	oSection1:EndQuery()

	//��������������������������������������������������������Ŀ
	//� Abertura do Arquivo de Trabalho                        �
	//����������������������������������������������������������
	dbSelectArea(cAliasSB1)
	oReport:SetMeter(nTotRegs)

	//��������������������������������������������������������Ŀ
	//� Processamento do Relatorio                             �
	//����������������������������������������������������������
	oSection1:Init(.F.)
	While !oReport:Cancel() .And. !Eof()
	
		oReport:IncMeter()
	
		nTotal   := 0
		nSB7Cnt  := 0
		lImprime := .T.
		aRegInv  := {}
		cSeek    := xFilial('SB7')+DTOS(mv_par03)+(cAliasSB7)->B7_COD+(cAliasSB7)->B7_LOCAL+(cAliasSB7)->B7_LOCALIZ+(cAliasSB7)->B7_NUMSERI+(cAliasSB7)->B7_LOTECTL+(cAliasSB7)->B7_NUMLOTE
		cCompara := "B7_FILIAL+DTOS(B7_DATA)+B7_COD+B7_LOCAL+B7_LOCALIZ+B7_NUMSERI+B7_LOTECTL+B7_NUMLOTE"
		cProduto := (cAliasSB2)->B2_COD
		cLocal   := (cAliasSB2)->B2_LOCAL
		cLocaliz := (cAliasSB7)->B7_LOCALIZ
		cNumSeri := (cAliasSB7)->B7_NUMSERI
		cLoteCtl := (cAliasSB7)->B7_LOTECTL
		cNumLote := (cAliasSB7)->B7_NUMLOTE
		cTipo    :=	(cAliasSB1)->B1_TIPO
		cGrupo   :=	(cAliasSB1)->B1_GRUPO

		While !oReport:Cancel() .And. !(cAliasSB7)->(Eof()) .And. cSeek == (cAliasSB7)->&(cCompara)
						
			oReport:IncMeter()

			nSB7Cnt++

			aAdd(aRegInv,{	cProduto					,; // B2_COD
							(cAliasSB1)->B1_DESC		,; // B1_DESC
							(cAliasSB7)->B7_LOTECTL		,; // B7_LOTECTL
							(cAliasSB7)->B7_NUMLOTE		,; // B7_NUMLOTE
							(cAliasSB7)->B7_LOCALIZ		,; // B7_LOCALIZ
							(cAliasSB7)->B7_NUMSERI		,; // B7_NUMSERI
							(cAliasSB1)->B1_TIPO		,; // B1_TIPO
							(cAliasSB1)->B1_GRUPO		,; // B1_GRUPO
							(cAliasSB1)->B1_UM 			,; // B1_UM
							(cAliasSB2)->B2_LOCAL		,; // B2_LOCAL
							(cAliasSB7)->B7_DOC			,; // B7_DOC
							(cAliasSB7)->B7_QUANT 		}) // B7_QUANT
			
			nTotal += (cAliasSB7)->B7_QUANT

			dbSelectArea(cAliasSB7)
			dbSkip()
			nContaSkips++
	
		EndDo
		
		dbSelectArea(cAliasSB1)
		dbGoTop()
		//posiciona o cursor para a correta exibicao dos Campos Personalizados
		// e campos de usuario adicionados no SX3
		If !lPrimReg .And. nContaSkips > nSB7Cnt
			dbSkip(nContaSkips - nSB7Cnt)
		EndIf
		
		// trata de forma diferenciada impressoes do primeiro registro do Alias de Trabalho
		If lPrimReg
			lPrimReg := .F.		
		EndIf
		
   		If nSB7Cnt > 0

			//������������������������������������������������������������������������Ŀ
			//�Verifica a Quantidade Disponivel/Custo Medio                            �
			//��������������������������������������������������������������������������
			If (Localiza(cProduto) .And. !Empty(cLocaliz+cNumSeri)) .Or. (Rastro(cProduto) .And. !Empty(cLotectl+cNumLote))
				aSalQtd   := CalcEstL(cProduto,cLocal,mv_par03+1,cLoteCtl,cNumLote,cLocaliz,cNumSeri)
				aSaldo    := CalcEst(cProduto,cLocal,mv_par03+1)
				aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
				aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
				aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
				aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
				aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
				aSaldo[7] := aSalQtd[7]
				aSaldo[1] := aSalQtd[1]
			Else
				If cLocCQ == cLocal
					aSalQtd	  := A340QtdCQ(cProduto,cLocal,mv_par03+1,"")
					aSaldo	  := CalcEst(cProduto,cLocal,mv_par03+1)
					aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
					aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
					aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
					aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
					aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
					aSaldo[7] := aSalQtd[7]
					aSaldo[1] := aSalQtd[1]
				Else
					aSaldo := CalcEst(cProduto,cLocal,mv_par03+1)
				EndIf
			EndIf
			If mv_par12 == 1
				aCM:={}
				If QtdComp(aSaldo[1]) > QtdComp(0)
					For nX:=2 to Len(aSaldo)
						aAdd(aCM,aSaldo[nX]/aSaldo[1])
					Next nX
	          	Else
					aCM := PegaCmAtu(cProduto,cLocal)
	          	EndIf
			Else
	           	aCM := PegaCMFim(cProduto,cLocal)
			EndIf
	
			//������������������������������������������������������������������Ŀ
			//� lImprime - Variavel utilizada para verificar se o usuario deseja |
			//| Listar Produto: 1-Com Diferencas / 2-Sem Diferencas / 3-Todos    |                              |
			//��������������������������������������������������������������������
			If nTotal-aSaldo[1] == 0
				If mv_par14 == 1
					lImprime := .F.
					nCellTot-= 1
				EndIf	
			Else 
			    If mv_par14 == 2
				   lImprime := .F.
   					nCellTot-= 1
				EndIf 
			EndIf
			
			//��������������������������������������������������������������Ŀ
			//� Impressao do Inventario                                      �
			//����������������������������������������������������������������
			If lImprime .Or. mv_par14 == 3
						
				For nX:=1 to Len(aRegInv)

					If nX == 1
						oSection1:Cell('B1_CODITE'	):Show()
						oSection1:Cell('B1_COD'	 	):Show()
						oSection1:Cell('B1_TIPO'	):Show()
						oSection1:Cell('B1_DESC'	):Show()
						oSection1:Cell('B1_GRUPO'	):Show()
						oSection1:Cell('B1_UM'		):Show()
						oSection1:Cell('B2_LOCAL'	):Show()
						oSection1:Cell('B7_LOTECTL'	):Show()
						oSection1:Cell('B7_NUMLOTE'	):Show()
						oSection1:Cell('B7_LOCALIZ'	):Show()
						oSection1:Cell('B7_NUMSERI'	):Show()
						oSection1:Cell('QUANTDATA'	):Hide()
						oSection1:Cell('DIFQUANT'	):Hide()
						oSection1:Cell('DIFVALOR'	):Hide()
						oSection1:Cell('QUANTDATA'	):SetValue(aSaldo[1])
						oSection1:Cell('DIFQUANT'	):SetValue(nTotal-aSaldo[1])
						oSection1:Cell('DIFVALOR'	):SetValue((nTotal-aSaldo[1])*aCM[mv_par10])
					Else	
						oSection1:Cell('B1_CODITE'	):Hide()
						oSection1:Cell('B1_COD'		):Hide()
						oSection1:Cell('B1_TIPO'  	):Hide()
						oSection1:Cell('B1_DESC'  	):Hide()
						oSection1:Cell('B1_GRUPO' 	):Hide()
						oSection1:Cell('B1_UM'    	):Hide()
						oSection1:Cell('B2_LOCAL' 	):Hide()
						oSection1:Cell('B7_LOTECTL'	):Hide()
						oSection1:Cell('B7_NUMLOTE'	):Hide()
						oSection1:Cell('B7_LOCALIZ'	):Hide()
						oSection1:Cell('B7_NUMSERI'	):Hide()
						oSection1:Cell('QUANTDATA'	):SetValue(0)
						oSection1:Cell('DIFQUANT'	):SetValue(0)
						oSection1:Cell('DIFVALOR'	):SetValue(0)
					EndIf 

					If Len(aRegInv) == 1
						oSection1:Cell('QUANTDATA'	):Show()
						oSection1:Cell('DIFQUANT'	):Show()
						oSection1:Cell('DIFVALOR'	):Show()					
					EndIf 
												
					oSection1:Cell('B1_CODITE'	):SetValue(aRegInv[nX,01])
					oSection1:Cell('B1_COD'		):SetValue(aRegInv[nX,01])
					oSection1:Cell('B1_DESC'	):SetValue(aRegInv[nX,02])
					oSection1:Cell('B7_LOTECTL'	):SetValue(aRegInv[nX,03])
					oSection1:Cell('B7_NUMLOTE'	):SetValue(aRegInv[nX,04])
					oSection1:Cell('B7_LOCALIZ'	):SetValue(aRegInv[nX,05])
					oSection1:Cell('B7_NUMSERI'	):SetValue(aRegInv[nX,06])
					oSection1:Cell('B1_TIPO'	):SetValue(aRegInv[nX,07])
					oSection1:Cell('B1_GRUPO'	):SetValue(aRegInv[nX,08])
					oSection1:Cell('B1_UM'		):SetValue(aRegInv[nX,09])
					oSection1:Cell('B2_LOCAL'	):SetValue(aRegInv[nX,10])
					oSection1:Cell('B7_DOC'		):SetValue(aRegInv[nX,11])
					oSection1:Cell('B7_QUANT'	):SetValue(aRegInv[nX,12])

					oSection1:PrintLine()
					
					dbSelectArea(cAliasSB1)
					dbSkip()
					
				Next nX 	
            EndIf
		Else
			dbSelectArea(cAliasSB2)
			dbSkip()
			Loop
		EndIf

	EndDo

	oSection1:Finish()

#ELSE	

	dbSelectArea(cAliasSB1)
    dbSetOrder(1)

	//������������������������������������������������������������������������Ŀ
	//�Transforma parametros Range em expressao SQL                            �
	//��������������������������������������������������������������������������
	MakeAdvplExpr(oReport:uParam)

	//������������������������������������������������������������������������Ŀ
	//�Montagem do Filtro                                                      �
	//��������������������������������������������������������������������������
	cFiltro += "B1_FILIAL == '" + xFilial('SB1')  + "' .AND. "
	If lVeic
		cFiltro += "B1_CODITE	>= '"	+ mv_par01 + "' .AND. "
		cFiltro += "B1_CODITE   <= '"	+ mv_par02 + "' .AND. "
	Else
		cFiltro += "B1_COD	>= '" + mv_par01 + "' .AND. "
		cFiltro += "B1_COD	<= '" + mv_par02 + "' .AND. "
	EndIf
	cFiltro += "B1_TIPO   >= '" + mv_par04	+ "' .AND. "
	cFiltro += "B1_TIPO   <= '" + mv_par05	+ "' .AND. "
	cFiltro += "B1_GRUPO  >= '" + mv_par08	+ "' .AND. "
	cFiltro += "B1_GRUPO  <= '" + mv_par09	+ "' "
	
	//������������������������������������������������������������������������Ŀ
	//�Montagem da Ordem                                                       �
	//��������������������������������������������������������������������������
	If nOrdem == 1 //-- Codigo
		If lVeic
			cOrdem := "B1_FILIAL + B1_CODITE"
		Else
			cOrdem := IndexKey(1) 
		EndIf
	ElseIf nOrdem == 2 //-- Tipo
  	   If lVeic
			cOrdem := "B1_FILIAL + B1_TIPO + B1_CODITE"
		Else	
			cOrdem := IndexKey(2) 
		EndIf	
	ElseIf nOrdem == 3 //-- Grupo
		If lVeic
			cOrdem := IndexKey(7) 
		Else
			cOrdem := IndexKey(4)
		EndIf
	ElseIf nOrdem == 4 //-- Descricao
		cOrdem := IndexKey(3) 
	ElseIf nOrdem == 5 //-- Local
		If lVeic
			cOrdem := "B1_FILIAL + B1_LOCPAD + B1_CODITE"
		Else
			cOrdem := "B1_FILIAL + B1_LOCPAD + B1_COD"
		EndIf
	EndIf

	oReport:Section(1):SetFilter(cFiltro,cOrdem)

	oReport:SetMeter(nTotRegs)

	//��������������������������������������������������������Ŀ
	//� Processamento do Relatorio                             �
	//����������������������������������������������������������
	oSection1:Init(.F.)
	While !oReport:Cancel() .And. !(cAliasSB1)->(Eof())

		oReport:IncMeter()

		(cAliasSB2)->(dbSeek(xFilial('SB2') + (cAliasSB1)->B1_COD, .T.))

		Do While !oReport:Cancel() .And. !(cAliasSB2)->(Eof()) .And. (cAliasSB2)->B2_FILIAL+(cAliasSB2)->B2_COD == xFilial('SB2')+(cAliasSB1)->B1_COD
    	
			(cAliasSB7)->(dbSeek(xFilial('SB7') + DtoS(mv_par03) + (cAliasSB2)->B2_COD + (cAliasSB2)->B2_LOCAL, .T.))

			cProduto := (cAliasSB2)->B2_COD
			cLocal   := (cAliasSB2)->B2_LOCAL
	
			Do While !oReport:Cancel() .And. !(cAliasSB7)->(Eof()) .And. (cAliasSB7)->(B7_FILIAL+DtoS(B7_DATA)+B7_COD+B7_LOCAL) == xFilial('SB7')+DtoS(mv_par03)+cProduto+cLocal
				
				oReport:IncMeter()

				//��������������������������������������������������������������Ŀ
				//� Caso utilize contagem so considera a contagem escolhida      �
				//����������������������������������������������������������������
				If lContagem .And. (cAliasSB7)->B7_ESCOLHA <> 'S'
					(cAliasSB7)->(dbSkip())
					Loop
				EndIf
				
				If (cAliasSB7)->B7_LOCAL  < mv_par06 .Or. (cAliasSB7)->B7_LOCAL > mv_par07
					(cAliasSB7)->(dbSkip())
					Loop
				EndIf
				
				nTotal   := 0
				nSB7Cnt  := 0   
				lImprime := .T.
				aRegInv  := {}
				cSeek    := xFilial('SB7')+DtoS(mv_par03)+(cAliasSB7)->B7_COD+(cAliasSB7)->B7_LOCAL+(cAliasSB7)->B7_LOCALIZ+(cAliasSB7)->B7_NUMSERI+(cAliasSB7)->B7_LOTECTL+(cAliasSB7)->B7_NUMLOTE
				cCompara := "B7_FILIAL+DTOS(B7_DATA)+B7_COD+B7_LOCAL+B7_LOCALIZ+B7_NUMSERI+B7_LOTECTL+B7_NUMLOTE"
				cLocaliz := (cAliasSB7)->B7_LOCALIZ
				cNumSeri := (cAliasSB7)->B7_NUMSERI
				cLoteCtl := (cAliasSB7)->B7_LOTECTL
				cNumLote := (cAliasSB7)->B7_NUMLOTE
				cTipo    := (cAliasSB1)->B1_TIPO
				cGrupo   := (cAliasSB1)->B1_GRUPO
				
				Do While !oReport:Cancel() .And. !(cAliasSB7)->(Eof()) .And. cSeek == (cAliasSB7)->&(cCompara)
					
					oReport:IncMeter()

					//��������������������������������������������������������������Ŀ
					//� Caso utilize contagem so considera a contagem escolhida      �
					//����������������������������������������������������������������
					If lContagem .And. (cAliasSB7)->B7_ESCOLHA <> 'S'
						(cAliasSB7)->(dbSkip())
						Loop
					EndIf
				
					If (cAliasSB7)->B7_LOCAL  < mv_par06 .Or. (cAliasSB7)->B7_LOCAL > mv_par07
						(cAliasSB7)->(dbSkip())
						Loop
					EndIf
					
					nSB7Cnt++

					aAdd(aRegInv,{	cProduto					,; // B2_COD
									(cAliasSB1)->B1_DESC		,; // B1_DESC
									(cAliasSB7)->B7_LOTECTL		,; // B7_LOTECTL
									(cAliasSB7)->B7_NUMLOTE		,; // B7_NUMLOTE
									(cAliasSB7)->B7_LOCALIZ		,; // B7_LOCALIZ
									(cAliasSB7)->B7_NUMSERI		,; // B7_NUMSERI
									(cAliasSB1)->B1_TIPO		,; // B1_TIPO
									(cAliasSB1)->B1_GRUPO		,; // B1_GRUPO
									(cAliasSB1)->B1_UM 			,; // B1_UM
									(cAliasSB2)->B2_LOCAL		,; // B2_LOCAL
									(cAliasSB7)->B7_DOC			,; // B7_DOC
									(cAliasSB7)->B7_QUANT 		}) // B7_QUANT
        	
					nTotal += (cAliasSB7)->B7_QUANT

					dbSelectArea(cAliasSB7)
					dbSkip()

				EndDo

		   		If nSB7Cnt > 0
				
					If (Localiza(cProduto) .And. !Empty(cLocaliz+cNumSeri)) .Or. (Rastro(cProduto) .And. !Empty(cLotectl+cNumLote))
						aSalQtd   := CalcEstL(cProduto,cLocal,mv_par03+1,cLoteCtl,cNumLote,cLocaliz,cNumSeri)
						aSaldo    := CalcEst(cProduto,cLocal,mv_par03+1)
						aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
						aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
						aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
						aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
						aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
						aSaldo[7] := aSalQtd[7]
						aSaldo[1] := aSalQtd[1]
					Else
						If cLocCQ == cLocal
							aSalQtd	  := A340QtdCQ(cProduto,cLocal,mv_par03+1,"")
							aSaldo	  := CalcEst(cProduto,cLocal,mv_par03+1)
							aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
							aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
							aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
							aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
							aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
							aSaldo[7] := aSalQtd[7]
							aSaldo[1] := aSalQtd[1]
						Else
							aSaldo := CalcEst(cProduto,cLocal,mv_par03+1)
						EndIf
					EndIf
					If mv_par12 == 1
						aCM:={}
						If QtdComp(aSaldo[1]) > QtdComp(0)
							For nX:=2 to Len(aSaldo)
								aAdd(aCM,aSaldo[nX]/aSaldo[1])
							Next nX
		          		Else
							aCM := PegaCmAtu(cProduto,cLocal)
	          			EndIf
					Else
	    		       	aCM := PegaCMFim(cProduto,cLocal)
					EndIf
					
					//������������������������������������������������������������������Ŀ
					//� lImprime - Variavel utilizada para verificar se o usuario deseja |
					//| Listar Produto: 1-Com Diferencas / 2-Sem Diferencas / 3-Todos    |                              |
					//��������������������������������������������������������������������
					If nTotal-aSaldo[1] == 0
						If mv_par14 == 1
							lImprime := .F.
						EndIf	
					Else 
					    If mv_par14 == 2
						   lImprime := .F.
						EndIf 
					EndIf
			
					//��������������������������������������������������������������Ŀ
					//� Impressao do Inventario                                      �
					//����������������������������������������������������������������
					If lImprime .Or. mv_par14 == 3
								
						For nX:=1 to Len(aRegInv)
		
							If nX == 1
								oSection1:Cell('B1_CODITE'	):Show()
								oSection1:Cell('B1_COD'	 	):Show()
								oSection1:Cell('B1_TIPO'	):Show()
								oSection1:Cell('B1_DESC'	):Show()
								oSection1:Cell('B1_GRUPO'	):Show()
								oSection1:Cell('B1_UM'		):Show()
								oSection1:Cell('B2_LOCAL'	):Show()
								oSection1:Cell('B7_LOTECTL'	):Show()
								oSection1:Cell('B7_NUMLOTE'	):Show()
								oSection1:Cell('B7_LOCALIZ'	):Show()
								oSection1:Cell('B7_NUMSERI'	):Show()
								oSection1:Cell('QUANTDATA'	):Hide()
								oSection1:Cell('DIFQUANT'	):Hide()
								oSection1:Cell('DIFVALOR'	):Hide()
								oSection1:Cell('QUANTDATA'	):SetValue(aSaldo[1])
								oSection1:Cell('DIFQUANT'	):SetValue(nTotal-aSaldo[1])
								oSection1:Cell('DIFVALOR'	):SetValue((nTotal-aSaldo[1])*aCM[mv_par10])
							Else	
								oSection1:Cell('B1_CODITE'	):Hide()
								oSection1:Cell('B1_COD'		):Hide()
								oSection1:Cell('B1_TIPO'  	):Hide()
								oSection1:Cell('B1_DESC'  	):Hide()
								oSection1:Cell('B1_GRUPO' 	):Hide()
								oSection1:Cell('B1_UM'    	):Hide()
								oSection1:Cell('B2_LOCAL' 	):Hide()
								oSection1:Cell('B7_LOTECTL'	):Hide()
								oSection1:Cell('B7_NUMLOTE'	):Hide()
								oSection1:Cell('B7_LOCALIZ'	):Hide()
								oSection1:Cell('B7_NUMSERI'	):Hide()
								oSection1:Cell('QUANTDATA'	):SetValue(0)
								oSection1:Cell('DIFQUANT'	):SetValue(0)
								oSection1:Cell('DIFVALOR'	):SetValue(0)
							EndIf 
		
							If Len(aRegInv) == 1
								oSection1:Cell('QUANTDATA'	):Show()
								oSection1:Cell('DIFQUANT'	):Show()
								oSection1:Cell('DIFVALOR'	):Show()					
							EndIf 
														
							oSection1:Cell('B1_CODITE'	):SetValue(aRegInv[nX,01])
							oSection1:Cell('B1_COD'		):SetValue(aRegInv[nX,01])
							oSection1:Cell('B1_DESC'	):SetValue(aRegInv[nX,02])
							oSection1:Cell('B7_LOTECTL'	):SetValue(aRegInv[nX,03])
							oSection1:Cell('B7_NUMLOTE'	):SetValue(aRegInv[nX,04])
							oSection1:Cell('B7_LOCALIZ'	):SetValue(aRegInv[nX,05])
							oSection1:Cell('B7_NUMSERI'	):SetValue(aRegInv[nX,06])
							oSection1:Cell('B1_TIPO'	):SetValue(aRegInv[nX,07])
							oSection1:Cell('B1_GRUPO'	):SetValue(aRegInv[nX,08])
							oSection1:Cell('B1_UM'		):SetValue(aRegInv[nX,09])
							oSection1:Cell('B2_LOCAL'	):SetValue(aRegInv[nX,10])
							oSection1:Cell('B7_DOC'		):SetValue(aRegInv[nX,11])
							oSection1:Cell('B7_QUANT'	):SetValue(aRegInv[nX,12])
		
							oSection1:PrintLine()
							
						Next nX
						
		            EndIf 
				Else
					dbSelectArea(cAliasSB7)
					dbSkip()
				EndIf	
				
			EndDo
			
			dbSelectArea(cAliasSB2)
			dbSkip()

		EndDo

		dbSelectArea(cAliasSB1)
		dbSkip()
	
	EndDo

	oSection1:Finish()

#ENDIF

If IsIncallStack("A004Exec")
	U_A004LOG()
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � MATR285R3� Autor � Eveli Morasco         � Data � 05/02/93 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Listagem dos itens inventariados                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Gen�rico                                                   ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���Marcelo Pim.�04/12/97�07906A�Definir a moeda a ser utilizada(mv_par10) ���
���Marcelo Pim.�09/12/97�07618A�Ajuste no posicionamento inicial do B7 p/ ���
���            �        �      �nao utilizar o Local padrao.              ���
���Fernando J. �23/09/98�06744A�Incluir informa��oes de LOTE, SUB-LOTE e  ���
���            �        �      �NUMERO DE SERIE.                          ���
���Rodrigo Sar.�17/11/98�18459A�Acerto na impressao qdo almoxarifado CQ   ���
���Cesar       �30/03/99�20706A�Imprimir Numero do Lote                   ���
���Cesar       �30/03/99�XXXXXX�Manutencao na SetPrint()                  ���
���Fernando Jol�20/09/99�19581A�Incluir pergunta "Imprime Lote/Sub-Lote?" ���
���Patricia Sal�30/12/99�XXXXXX�Acerto LayOut (Doc. 12 digitos);Troca da  ���
���            �        �      �PesqPictQt() pela PesqPict().             ���
���Marcos Hirak�12/12/03�XXXXXX�Imprimir B1_CODITO quando for gest�o de   ���
���            �        �      �Concession�rias ( MV_VEICULO = "S")       ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MATR285R3()

//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local Tamanho 
Local Titulo  := STR0001 // 'Listagem dos Itens Inventariados'
Local cDesc1  := STR0002 // 'Emite uma relacao que mostra o saldo em estoque e todas as'
Local cDesc2  := STR0003 // 'contagens efetuadas no inventario. Baseado nestas duas in-'
Local cDesc3  := STR0004 // 'formacoes ele calcula a diferenca encontrada.'
Local cString := 'SB1'
Local nTipo   := 0
Local aOrd    := {OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009)}		//' Por Codigo    '###' Por Tipo      '###' Por Grupo   '###' Por Descricao '###' Por Local    '
Local wnRel   := 'MATR285'
//��������������������������������������������������������������Ŀ
//� Variaveis tipo Local para SIGAVEI, SIGAPEC e SIGAOFI         �
//����������������������������������������������������������������
Local aArea1	:= Getarea() 
Local nTamSX1   := Len(SX1->X1_GRUPO)

//��������������������������������������������������������������Ŀ
//� Variaveis tipo Private para SIGAVEI, SIGAPEC e SIGAOFI       �
//����������������������������������������������������������������
Private lVEIC   := UPPER(GETMV("MV_VEICULO"))=="S"
Private aSB1Cod := {}
Private aSB1Ite := {}
Private nCOL1	 := 0

//��������������������������������������������������������������Ŀ
//� Variaveis tipo Private padrao de todos os relatorios         �
//����������������������������������������������������������������
Private aReturn  := {OemToAnsi(STR0010), 1,OemToAnsi(STR0011), 2, 2, 1, '',1 }   //'Zebrado'###'Administracao'
Private nLastKey := 0
Private cPerg    := 'MTR285'
//��������������������������������������������������������������Ŀ
//� Ajustar o SX2 para SIGAVEI, SIGAPEC e SIGAOFI                �
//����������������������������������������������������������������

If lVEIC
	aSB1Cod	:= TAMSX3("B1_COD")
	aSB1Ite	:= TAMSX3("B1_CODITE")
	nCOL1		:= ABS(aSB1Cod[1] - aSB1Ite[1])
	dbSelectArea("SX1")
	dbSetOrder(1)
	dbSeek(PADR(cPerg,nTamSX1))
	While SX1->X1_GRUPO == PADR(cPerg,nTamSX1) .And. !SX1->(Eof())
		If "PRODU" $ Upper(SX1->X1_PERGUNT) .And. Upper(SX1->X1_TIPO) == "C" .And. (SX1->X1_TAMANHO <> 27 .Or. Upper(SX1->X1_F3) <> "VR4")
			Reclock("SX1",.F.)
			SX1->X1_TAMANHO := 27
			SX1->X1_F3 := "VR4"
			dbCommit()
			MsUnlock()
		EndIf
		dbSkip()
	EndDo
   dbCommitAll()
   RestArea(aArea1)
Else
	dbSelectArea("SX1")
	dbSetOrder(1)
	dbSeek(PADR(cPerg,nTamSX1))
	While SX1->X1_GRUPO == PADR(cPerg,nTamSX1) .And. !SX1->(Eof())
		If "PRODU" $ Upper(SX1->X1_PERGUNT) .And. Upper(SX1->X1_TIPO) == "C" .And. (SX1->X1_TAMANHO <> 15 .Or. UPPER(SX1->X1_F3) <> "SB1")
			Reclock("SX1",.F.)
			SX1->X1_TAMANHO := 15
			SX1->X1_F3 := "SB1"
			dbCommit()
			MsUnlock()
		EndIf
		dbSkip()
	EndDo
	dbCommitAll()
	RestArea(aArea1)
EndIf

//��������������������������������������������������������������Ŀ
//� Ajusta o Grupo de Perguntas MATR285                          �
//����������������������������������������������������������������
AjustaSX1()

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Produto de                           �
//� mv_par02             // Produto ate                          �
//� mv_par03             // Data de Selecao                      �
//� mv_par04             // De  Tipo                             �
//� mv_par05             // Ate Tipo                             �
//� mv_par06             // De  Local                            �
//� mv_par07             // Ate Local                            �
//� mv_par08             // De  Grupo                            �
//� mv_par09             // Ate Grupo                            �
//� mv_par10             // Qual Moeda (1 a 5)                   �
//� mv_par11             // Imprime Lote/Sub-Lote                �
//� mv_par12             // Custo Medio Atual/Ultimo Fechamento  �
//� mv_par13             // Imprime Localizacao ?                �
//����������������������������������������������������������������
Pergunte(cPerg,.F.)

// Utiliza��o do aReturn[4] e do nTamanho
// aReturn[4] := 1=Comprimido 2=Normal
// nTamanho   := If(aReturn[4]==1,'G','P')

Tamanho := 'G'
//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey == 27
	dbClearFilter()
	Return Nil
Endif

SetDefault(aReturn,cString)
           
If nLastKey == 27
	dbClearFilter()
	Return Nil
Endif

RptStatus({|lEnd| C285Imp(aOrd,@lEnd,wnRel,cString,titulo,Tamanho)},titulo)

Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � C285IMP  � Autor � Rodrigo de A. Sartorio� Data � 12.12.95 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relatorio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR285                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function C285Imp(aOrd,lEnd,WnRel,cString,titulo,Tamanho)

//��������������������������������������������������������������Ŀ
//� Variaveis locais exclusivas deste programa                   �
//����������������������������������������������������������������
Local nSB7Cnt  := 0
Local i		   := 0
Local nTotal   := 0
Local nTotVal  := 0
Local nSubVal  := 0
Local nCntImpr := 0
Local cAnt     := '',cSeek:='',cCompara :='',cLocaliz:='',cNumSeri:='',cLoteCtl:='',cNumLote:=''
Local cRodaTxt := STR0012 // 'PRODUTO(S)'
Local aSaldo   := {}
Local aSalQtd  := {}
Local aCM      := {}
Local lQuery   := .F.
Local cQuery   := ""
Local cQueryB1 := ""
Local aStruSB1 := {}
Local aStruSB2 := {}
Local aStruSB7 := {}
Local aRegInv  := {}
Local cAliasSB1:= "SB1"
Local cAliasSB2:= "SB2"
Local cAliasSB7:= "SB7"
Local cProduto := ""
Local cLocal   := ""
Local lFirst   := .T.
Local nX       := 0
Local lImprime := .T.
Local lContagem:=(SB7->(FieldPos("B7_CONTAGE")) > 0) .And. (SB7->(FieldPos("B7_ESCOLHA")) > 0) .And. (SB7->(FieldPos("B7_OK")) > 0) .And. SuperGetMv('MV_CONTINV',.F.,.F.)

//��������������������������������������������������������������Ŀ
//� Variaveis tipo Local para SIGAVEI, SIGAPEC e SIGAOFI         �
//����������������������������������������������������������������
Local cNomArq	:= ""
Local cKey		:= ""
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas qdo almoxarifado do CQ                  �
//����������������������������������������������������������������
Local	cLocCQ	:= GetMV("MV_CQ")
Private	lLocCQ	:=.T.

//��������������������������������������������������������������Ŀ
//� Variaveis privadas exclusivas deste programa                 �
//����������������������������������������������������������������
Private cCondicao := '!Eof()'

//��������������������������������������������������������������Ŀ
//� Contadores de linha e pagina                                 �
//����������������������������������������������������������������
Private Li    := 80
Private m_Pag := 1

//�������������������������������������������������������������������Ŀ
//� Inicializa os codigos de caracter Comprimido/Normal da impressora �
//���������������������������������������������������������������������
nTipo := If(aReturn[4]==1,15,18)

//������������������������������������������������������������Ŀ
//� Adiciona a ordem escolhida ao titulo do relatorio          �
//��������������������������������������������������������������
If Type('NewHead') # 'U'
	NewHead += ' (' + AllTrim(aOrd[aReturn[8]]) + ')'
Else
	Titulo += ' (' + AllTrim(aOrd[aReturn[8]]) + ')'
EndIf

//��������������������������������������������������������������Ŀ
//� Monta os Cabecalhos                                          �
//����������������������������������������������������������������
If mv_par11 == 1
	If mv_par13 == 1
        Cabec1 := STR0023 // 'CODIGO          DESCRICAO                LOTE       SUB    LOCALIZACAO     NUMERO DE SERIE      TP GRP  UM AL DOCUMENTO            QUANTIDADE         QTD NA DATA   _____________DIFERENCA______________'
        Cabec2 := STR0024 // '                                                    LOTE                                                                         INVENTARIADA       DO INVENTARIO          QUANTIDADE              VALOR'
        //--                  123456789012345 123456789012345678901234 1234567890 123456 123456789012345 12345678901234567890 12 1234 12 12 123456789012 999.999.999.999,99  999.999.999.999,99  999.999.999.999,99 999.999.999.999,99
        //--                  0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20
        //--                  012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	Else
        Cabec1 := STR0013 // 'CODIGO          DESCRICAO                LOTE       SUB    TP GRP  UM AL DOCUMENTO            QUANTIDADE         QTD NA DATA   _____________DIFERENCA______________'
        Cabec2 := STR0014 // '                                                    LOTE                                    INVENTARIADA       DO INVENTARIO          QUANTIDADE              VALOR'
        //--                  123456789012345 123456789012345678901234 1234567890 123456 12 1234 12 12 123456789012 999.999.999.999,99  999.999.999.999,99  999.999.999.999,99 999.999.999.999,99
        //--                  0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16   
        //--                  0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	EndIf	
Else
	If mv_par13 == 1
        Cabec1 := STR0025 // 'CODIGO          DESCRICAO                LOCALIZACAO     NUMERO DE SERIE      TP GRP  UM AL DOCUMENTO            QUANTIDADE         QTD NA DATA  _______________DIFERENCA_____________'
        Cabec2 := STR0026 // '                                                                                                               INVENTARIADA       DO INVENTARIO          QUANTIDADE              VALOR'
        //--                  123456789012345 123456789012345678901234 123456789012345 12345678901234567890 12 1234 12 12 123456789012 999.999.999.999,99  999.999.999.999,99  999.999.999.999,99 999.999.999.999,99
        //--                  0         1         2         3         4         5         6         7         8         9        10        11        12        13        14       15        16        17        18
        //--                  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456780123456789012345678901234567890123456789012
	Else
        Cabec1 := STR0021 // 'CODIGO          DESCRICAO                TP GRP  UM AL DOCUMENTO            QUANTIDADE         QTD NA DATA  _______________DIFERENCA_____________'
        Cabec2 := STR0022 // '                                                                          INVENTARIADA       DO INVENTARIO          QUANTIDADE              VALOR'
        //--                  123456789012345 123456789012345678901234 12 1234 12 12 123456789012 999.999.999.999,99  999.999.999.999,99  999.999.999.999,99 999.999.999.999,99
        //--                  0         1         2         3         4         5         6         7         8         9        10        11        12        13        14
        //--                  0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678012345
	EndIf
EndIf
If lVEIC
   Cabec1 := substr(Cabec1,1,aSB1Cod[1]) + SPACE(nCOL1) + substr(Cabec1,aSB1Cod[1]+1)
   Cabec2 := substr(Cabec2,1,aSB1Cod[1]) + SPACE(nCOL1) + substr(Cabec2,aSB1Cod[1]+1)
EndIf
//��������������������������������������������������������������Ŀ
//� Inicializa os Arquivos e Ordens a serem utilizados           �
//����������������������������������������������������������������
dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB7')
dbSetOrder(1)

dbSelectArea('SB1')
SetRegua(LastRec())

#IFDEF TOP
	If aReturn[8] == 2
		dbSetOrder(2) //-- Tipo
	ElseIf aReturn[8] == 3
		If lVEIC
			dbSetOrder(7) //--  B1_FILIAL+B1_GRUPO+B1_CODITE
		Else
			dbSetOrder(4) //-- Grupo
		EndIf	
	ElseIf aReturn[8] == 4
		dbSetOrder(3) //-- Descricao
	ElseIf aReturn[8] == 5
		If lVEIC
			cKey    := ' B1_FILIAL, B1_LOCPAD, B1_CODITE'
		Else
			cKey    := ' B1_FILIAL, B1_LOCPAD, B1_COD'
		EndIf	
		cKey    := Upper(cKey)
	Else
		If lVEIC
			cKey    := ' B1_FILIAL, B1_CODITE'
			cKey    := Upper(cKey)
		Else
		dbSetOrder(1) //-- Codigo
		EndIf	
	EndIf

	lQuery 	  := .T.
	aStruSB1  := SB1->(dbStruct())
	aStruSB2  := SB2->(dbStruct())
	aStruSB7  := SB7->(dbStruct())

	cAliasSB1 := "R285IMP"
	cAliasSB2 := "R285IMP"
	cAliasSB7 := "R285IMP"

    If Empty(aReturn[7])
		cQuery    := "SELECT "
		cQuery    += "SB1.R_E_C_N_O_ SB1REC, "
		cQuery    += "SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_LOCPAD, SB1.B1_TIPO, SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM , "
		If lVEIC
			cQuery    += "SB1.B1_CODITE , "
		EndIf
    Else
		cQueryB1    += "SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_LOCPAD, SB1.B1_TIPO, SB1.B1_GRUPO, SB1.B1_DESC, SB1.B1_UM , "
		If lVEIC
			cQueryB1+= "SB1.B1_CODITE , "
		EndIf
    	cQuery	  := "SELECT "
		cQuery    += "SB1.R_E_C_N_O_ SB1REC, "
        //Adiciona os campos do filtro na Query
    	cQuery    += cQueryB1 + A285QryFil("SB1",cQueryB1,aReturn[7])
    EndIf	
	cQuery    += "SB2.R_E_C_N_O_ SB2REC, "
	cQuery    += "SB2.B2_FILIAL, SB2.B2_COD, SB2.B2_LOCAL, SB2.B2_DINVENT, "
	cQuery    += "SB7.R_E_C_N_O_ SB7REC, "
	cQuery    += "SB7.B7_FILIAL, SB7.B7_COD, SB7.B7_LOCAL, SB7.B7_DATA, SB7.B7_LOCALIZ, SB7.B7_NUMSERI, SB7.B7_LOTECTL, SB7.B7_NUMLOTE, SB7.B7_DOC, SB7.B7_QUANT "
	If lContagem
		cQuery += " ,SB7.B7_ESCOLHA ,SB7.B7_CONTAGE " 				
	EndIf
	cQuery    += "FROM "
	cQuery    += RetSqlName("SB1")+" SB1, "
	cQuery    += RetSqlName("SB2")+" SB2, "
	cQuery    += RetSqlName("SB7")+" SB7  "

	cQuery    += "WHERE "
	cQuery    += "SB1.B1_FILIAL = '"+xFilial("SB1")+"' And "

	cQuery += "SB1.B1_TIPO  >= '"+mv_par04+"' And SB1.B1_TIPO  <= '"+mv_par05+"' And "
	cQuery += "SB1.B1_GRUPO >= '"+mv_par08+"' And SB1.B1_GRUPO <= '"+mv_par09+"' And "

	If aReturn[8] == 5
		cQuery += "SB1.B1_LOCPAD>= '"+mv_par06+"' And SB1.B1_LOCPAD<= '"+mv_par07+"' And "
	EndIf

	If lVEIC
		cQuery += "SB1.B1_CODITE >= '"+mv_par01+"' And SB1.B1_CODITE <= '"+mv_par02+"' And "
	Else
		cQuery += "SB1.B1_COD    >= '"+mv_par01+"' And SB1.B1_COD   <= '"+mv_par02+"' And "
	EndIf			
	cQuery    += "SB1.D_E_L_E_T_ = ' ' And "

	cQuery    += "SB2.B2_FILIAL = '"+xFilial("SB2")+"' And "
	cQuery    += "SB2.B2_COD = SB1.B1_COD And "
	cQuery    += "SB2.B2_LOCAL = SB7.B7_LOCAL And "
	cQuery    += "SB2.D_E_L_E_T_ = ' ' And "
	cQuery    += "SB7.B7_FILIAL = '"+xFilial("SB7")+"' And "
	cQuery    += "SB7.B7_COD = SB1.B1_COD And "
	cQuery    += "SB7.B7_LOCAL >= '"+mv_par06+"' And SB7.B7_LOCAL <= '"+mv_par07+"' And "
	cQuery    += "SB7.B7_DATA   = '"+DtoS(mv_par03)+"' And "
	cQuery    += "SB7.D_E_L_E_T_ = ' ' "
	If lContagem
		cQuery += " AND SB7.B7_ESCOLHA = 'S' " 				
	EndIf

	If lVEIC
		If aReturn[8] == 1 // codite
			cQuery    += "ORDER BY " +	cKey // B1_FILIAL , B1_CODITE
		ElseIf aReturn[8] == 5 // local
			cQuery    += "ORDER BY " + cKey // B1_FILIAL, B1_LOCPAD, B1_CODITE
		Else
			cQuery    += "ORDER BY "+SqlOrder(SB1->(IndexKey()))
		EndIf	
	Else
		If aReturn[8] == 5 // local
			cQuery    += "ORDER BY " + cKey // B1_FILIAL, B1_LOCPAD, B1_COD
		Else	
			cQuery    += "ORDER BY "+SqlOrder(SB1->(IndexKey()))
		EndIf	
	EndIf			

	cQuery    := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB1,.T.,.T.)

	For nX := 1 To Len(aStruSB1)
		If ( aStruSB1[nX][2] <> "C" ) .And. FieldPos(aStruSB1[nX][1]) > 0
			TcSetField(cAliasSB1,aStruSB1[nX][1],aStruSB1[nX][2],aStruSB1[nX][3],aStruSB1[nX][4])
		EndIf
	Next nX

	For nX := 1 To Len(aStruSB2)
		If ( aStruSB2[nX][2] <> "C" ) .And. FieldPos(aStruSB2[nX][1]) > 0
			TcSetField(cAliasSB2,aStruSB2[nX][1],aStruSB2[nX][2],aStruSB2[nX][3],aStruSB2[nX][4])
		EndIf
	Next nX

	For nX := 1 To Len(aStruSB7)
		If ( aStruSB7[nX][2] <> "C" ) .And. FieldPos(aStruSB7[nX][1]) > 0
			TcSetField(cAliasSB7,aStruSB7[nX][1],aStruSB7[nX][2],aStruSB7[nX][3],aStruSB7[nX][4])
		EndIf
	Next nX
	cAnt:= ""
	If aReturn[8] == 2
		cAnt	:= (cAliasSB1)->B1_TIPO
	ElseIf aReturn[8] == 3
		cAnt	:= (cAliasSB1)->B1_GRUPO
	EndIf
#ELSE	
	cCondicao += " .And. B1_FILIAL == '" + xFilial('SB1') + "'"
	If aReturn[8] == 2
  	   If lVEIC
			cNomArq := CriaTrab('', .F.) //-- Local
			cKey    := "B1_FILIAL + B1_TIPO + B1_CODITE"
			IndRegua('SB1',cNomArq,cKey,,,STR0015) // 'Selecionando Registros...'
		Else	
			dbSetOrder(2) //-- Tipo
		EndIf	
		dbSeek(cFilial + mv_par04 + mv_par01 , .T.)
		cCondicao += " .And. B1_TIPO <= mv_par05"
		cAnt      := B1_TIPO
	ElseIf aReturn[8] == 3
		If lVEIC
			dbSetOrder(7) //--  B1_FILIAL+B1_GRUPO+B1_CODITE
		Else
			dbSetOrder(4) //-- Grupo
		EndIf
		dbSeek(cFilial + mv_par08 + mv_par01 , .T.)
		cCondicao += " .And. B1_GRUPO <= mv_par09"
		cAnt      := B1_GRUPO
	ElseIf aReturn[8] == 4
		dbSetOrder(3) //-- Descricao
		dbSeek(cFilial)
	ElseIf aReturn[8] == 5
		cNomArq := CriaTrab('', .F.) //-- Local
		If lVEIC
			cKey    := "B1_FILIAL + B1_LOCPAD + B1_CODITE"
		Else
			cKey    := "B1_FILIAL + B1_LOCPAD + B1_COD"
		EndIf
		IndRegua('SB1',cNomArq,cKey,,,STR0015) // 'Selecionando Registros...'
		dbSeek(cFilial + mv_par06 +  mv_par01, .T.)
		cCondicao += " .And. B1_LOCPAD <= mv_par07"
	Else
		If lVEIC
			cNomArq := CriaTrab('', .F.) //-- CODITE
			cKey    := "B1_FILIAL + B1_CODITE"
			IndRegua('SB1',cNomArq,cKey,,,STR0015) // 'Selecionando Registros...'
			cCondicao += " .And. (B1_CODITE <= mv_par02)"
		Else
			dbSetOrder(1) //-- Codigo
			cCondicao += " .And. B1_COD <= mv_par02"
		EndIf
		dbSeek(cFilial + mv_par01, .T.)
	EndIf
#ENDIF

nTotVal := 0
nSubVal := 0

While &cCondicao

	#IFNDEF TOP
	   If lVEIC
			If ((cAliasSB1)->B1_CODITE > mv_par02 .And. aReturn[8] == 1)  
				Exit
			ElseIf ((cAliasSB1)->B1_GRUPO < mv_par08) .Or. ((cAliasSB1)->B1_GRUPO  > mv_par09) .Or. ;
				   ((cAliasSB1)->B1_TIPO   < mv_par04) .Or. ((cAliasSB1)->B1_TIPO   > mv_par05) .Or. ;
				   ((cAliasSB1)->B1_CODITE < mv_par01) .Or. ((cAliasSB1)->B1_CODITE > mv_par02)
 				    (cAliasSB1)->(dbSkip())
			        Loop
			EndIf
	   Else
			If ((cAliasSB1)->B1_COD > mv_par02 .And. aReturn[8] == 1)
				Exit
			ElseIf ((cAliasSB1)->B1_GRUPO < mv_par08) .Or. ((cAliasSB1)->B1_GRUPO > mv_par09) .Or. ;
				   ((cAliasSB1)->B1_TIPO  < mv_par04) .Or. ((cAliasSB1)->B1_TIPO  > mv_par05) .Or. ;
				   ((cAliasSB1)->B1_COD   < mv_par01) .Or. ((cAliasSB1)->B1_COD   > mv_par02)
					(cAliasSB1)->(dbSkip())
					Loop
			EndIf
		EndIf
	#ENDIF

    If !Empty(aReturn[7]) .And. !&(aReturn[7])
       (cAliasSB1)->(dbSkip())
		Loop
	EndIf

	If lFirst  
		If aReturn[8] == 2 .and. cAnt <> (cAliasSB1)->B1_TIPO
			cAnt := (cAliasSB1)->B1_TIPO
			lFirst := .F.
		ElseIf aReturn[8] == 3 .and. cAnt <> (cAliasSB1)->B1_GRUPO
			cAnt := (cAliasSB1)->B1_GRUPO
			lFirst := .F.
		EndIf
	EndIf	
	If lEnd
		@ pRow()+1, 000 PSAY STR0016 // 'CANCELADO PELO OPERADOR'
		Exit
	EndIF
	
	IncRegua()

	#IFNDEF TOP
		(cAliasSB2)->(dbSeek(xFilial('SB2') + (cAliasSB1)->B1_COD, .T.))

		Do While !(cAliasSB2)->(Eof()) .And. (cAliasSB2)->B2_FILIAL+(cAliasSB2)->B2_COD == xFilial('SB2')+(cAliasSB1)->B1_COD

			(cAliasSB7)->(dbSeek(xFilial('SB7') + DtoS(mv_par03) + (cAliasSB2)->B2_COD + (cAliasSB2)->B2_LOCAL, .T.))
	#ENDIF

		cProduto := (cAliasSB2)->B2_COD
		cLocal   := (cAliasSB2)->B2_LOCAL

		While !(cAliasSB7)->(Eof()) .And. (cAliasSB7)->(B7_FILIAL+DtoS(B7_DATA)+B7_COD+B7_LOCAL) == xFilial('SB7')+DtoS(mv_par03)+cProduto+cLocal
			
			#IFNDEF TOP
				If ((cAliasSB7)->B7_LOCAL < mv_par06) .Or. ((cAliasSB7)->B7_LOCAL > mv_par07)
					(cAliasSB7)->(dbSkip())
					Loop
				EndIf
				//��������������������������������������������������������������Ŀ
				//� Caso utilize contagem so considera a contagem escolhida      �
				//����������������������������������������������������������������
				If lContagem .And. (cAliasSB7)->B7_ESCOLHA <> 'S'
					(cAliasSB7)->(dbSkip())
					Loop
				EndIf
			#ENDIF
			
			nTotal   := 0
			nSB7Cnt  := 0
			aRegInv  := {}
			cSeek    := xFilial('SB7')+DtoS(mv_par03)+(cAliasSB7)->B7_COD+(cAliasSB7)->B7_LOCAL+(cAliasSB7)->B7_LOCALIZ+(cAliasSB7)->B7_NUMSERI+(cAliasSB7)->B7_LOTECTL+(cAliasSB7)->B7_NUMLOTE
			cCompara := "B7_FILIAL+DTOS(B7_DATA)+B7_COD+B7_LOCAL+B7_LOCALIZ+B7_NUMSERI+B7_LOTECTL+B7_NUMLOTE"
			cLocaliz := (cAliasSB7)->B7_LOCALIZ
			cNumSeri := (cAliasSB7)->B7_NUMSERI
			cLoteCtl := (cAliasSB7)->B7_LOTECTL
			cNumLote := (cAliasSB7)->B7_NUMLOTE
			lImprime := .T.
			
			While !(cAliasSB7)->(Eof()) .And. cSeek == (cAliasSB7)->&(cCompara)
				
				#IFNDEF TOP
					If ((cAliasSB7)->B7_LOCAL < mv_par06) .Or. ((cAliasSB7)->B7_LOCAL > mv_par07)
						(cAliasSB7)->(dbSkip())
						Loop
					EndIf
					//��������������������������������������������������������������Ŀ
					//� Caso utilize contagem so considera a contagem escolhida      �
					//����������������������������������������������������������������
					If lContagem .And. (cAliasSB7)->B7_ESCOLHA <> 'S'
						(cAliasSB7)->(dbSkip())
						Loop
					EndIf
				#ENDIF

				nSB7Cnt++
				
				aAdd(aRegInv,{	Left(cProduto,15)					,; //B2_COD
								Left((cAliasSB1)->B1_DESC,30)		,; //B1_DESC
								Left((cAliasSB7)->B7_LOTECTL,10)	,; //B7_LOTECTL
								Left((cAliasSB7)->B7_NUMLOTE,06)	,; //B7_NUMLOTE
								Left((cAliasSB7)->B7_LOCALIZ,15)	,; //B7_LOCALIZ
								Left((cAliasSB7)->B7_NUMSERI,20)	,; //B7_NUMSERI
								Left((cAliasSB1)->B1_TIPO ,02)		,; //B1_TIPO
								Left((cAliasSB1)->B1_GRUPO,04)		,; //B1_GRUPO
								Left((cAliasSB1)->B1_UM   ,02)		,; //B1_UM
								Left((cAliasSB2)->B2_LOCAL,02)		,; //B2_LOCAL
								(cAliasSB7)->B7_DOC					,; //B7_DOC
								Transform((cAliasSB7)->B7_QUANT,(cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)) ) } ) //B7_QUANT

				nTotal += (cAliasSB7)->B7_QUANT
				
				(cAliasSB7)->(dbSkip())
			EndDo
			
			#IFNDEF TOP
				If nSB7Cnt == 0
					(cAliasSB2)->(dbSkip())
					Loop
				EndIf
			#ENDIF	
		
			If (Localiza(cProduto) .And. !Empty(cLocaliz+cNumSeri)) .Or. (Rastro(cProduto) .And. !Empty(cLotectl+cNumLote))
				aSalQtd   := CalcEstL(cProduto,cLocal,mv_par03+1,cLoteCtl,cNumLote,cLocaliz,cNumSeri)
				aSaldo    := CalcEst(cProduto,cLocal,mv_par03+1)
				aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
				aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
				aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
				aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
				aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
				aSaldo[7] := aSalQtd[7]
				aSaldo[1] := aSalQtd[1]
			Else
				If cLocCQ == cLocal
					aSalQtd	  := A340QtdCQ(cProduto,cLocal,mv_par03+1,"")
					aSaldo	  := CalcEst(cProduto,cLocal,mv_par03+1)
					aSaldo[2] := (aSaldo[2] / aSaldo[1]) * aSalQtd[1]
					aSaldo[3] := (aSaldo[3] / aSaldo[1]) * aSalQtd[1]
					aSaldo[4] := (aSaldo[4] / aSaldo[1]) * aSalQtd[1]
					aSaldo[5] := (aSaldo[5] / aSaldo[1]) * aSalQtd[1]
					aSaldo[6] := (aSaldo[6] / aSaldo[1]) * aSalQtd[1]
					aSaldo[7] := aSalQtd[7]
					aSaldo[1] := aSalQtd[1]
				Else
					aSaldo := CalcEst(cProduto,cLocal,mv_par03+1)
				EndIf
			EndIf
			
			//��������������������������������������������������������������Ŀ
			//� Validacao do Total da Diferenca X Saldo Disponivel           �
			//����������������������������������������������������������������
			If nTotal-aSaldo[1] == 0
				If mv_par14 == 1
					lImprime := .F.
				EndIf	
			Else 
			    If mv_par14 == 2
				   lImprime := .F.
				EndIf 
			EndIf
			
			//��������������������������������������������������������������Ŀ
			//� Impressao do Inventario                                      �
			//����������������������������������������������������������������
			If lImprime .Or. mv_par14 == 3
						
				For nX:=1 to Len(aRegInv)
					
					If Li > 55
						Cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
					EndIf
					
					If nX == 1
						@ Li, 000 PSAY aRegInv[nX,01] //B1_CODITE
						@ Li, 016 + nCOL1 PSAY aRegInv[nX,02] //B1_COD
					EndIf
	
					If mv_par11 == 1  
						@ Li, 047 + nCOL1 PSAY aRegInv[nX,03] //B7_LOTECTL
						@ Li, 058 + nCOL1 PSAY aRegInv[nX,04] //B7_NUMLOTE
						If mv_par13 == 1                            
							@ Li, 065 + nCOL1 PSAY aRegInv[nX,05] //B7_LOCALIZ
							@ Li, 081 + nCOL1 PSAY aRegInv[nX,06] //B7_NUMSERI
						EndIf
						If nX == 1
							@ Li,If(mv_par13==1,102,065) + nCOL1 PSAY aRegInv[nX,07] //B1_TIPO
							@ Li,If(mv_par13==1,105,068) + nCOL1 PSAY aRegInv[nX,08] //B1_GRUPO
							@ Li,If(mv_par13==1,109,073) + nCOL1 PSAY aRegInv[nX,09] //B1_UM
							@ Li,If(mv_par13==1,113,076) + nCOL1 PSAY aRegInv[nX,10] //B2_LOCAL 
						EndIf
						@ Li,If(mv_par13==1,116,079) + nCOL1 PSAY aRegInv[nX,11] //B7_DOC
						@ Li,If(mv_par13==1,129,092) + nCOL1 PSAY aRegInv[nX,12] //B7_QUANT
					Else
						If mv_par13 == 1
							@ Li, 047 + nCOL1 PSAY aRegInv[nX,05] //B7_LOCALIZ
							@ Li, 063 + nCOL1 PSAY aRegInv[nX,06] //B7_NUMSERI
						EndIf
						If nX == 1							
							@ Li,If(mv_par13==1,084,047) + nCOL1 PSAY aRegInv[nX,07] //B1_TIPO
							@ Li,If(mv_par13==1,087,050) + nCOL1 PSAY aRegInv[nX,08] //B1_GRUPO
							@ Li,If(mv_par13==1,092,054) + nCOL1 PSAY aRegInv[nX,09] //B1_UM
							@ Li,If(mv_par13==1,095,057) + nCOL1 PSAY aRegInv[nX,10] //B2_LOCAL 							
						EndIf
						@ Li,If(mv_par13==1,098,061) + nCOL1 PSAY aRegInv[nX,11] //B7_DOC
						@ Li,If(mv_par13==1,111,074) + nCOL1 PSAY aRegInv[nX,12] //B7_QUANT						
					EndIf
	
					Li++
			
				Next nX
					
				//�������������������������������������������������������Ŀ
				//� Adiciona 1 ao contador de registros impressos         �
				//���������������������������������������������������������
				nCntImpr++
			
				If nSB7Cnt == 1
					Li--
				ElseIf nSB7Cnt > 1
					If mv_par11 == 1
						@ Li,If(mv_par13==1,106,069) + nCOL1 PSAY STR0017 // 'TOTAL .................'
						@ Li,If(mv_par13==1,129,092) + nCOL1 PSAY Transform(nTotal, (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
					Else
						@ Li,If(mv_par13==1,088,050) + nCOL1 PSAY STR0017 // 'TOTAL .................'
						@ Li,If(mv_par13==1,111,074) + nCOL1 PSAY Transform(nTotal, (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
					EndIf
				EndIf

				If mv_par11 == 1
					@ Li,If(mv_par13==1,149,112) + nCOL1 PSAY Transform(aSaldo[1], (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
				Else
					@ Li,If(mv_par13==1,131,094) + nCOL1 PSAY Transform(aSaldo[1], (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
				EndIf
				
				If nSB7Cnt > 0
					If mv_par12 == 1
						aCM:={}
						If QtdComp(aSaldo[1]) > QtdComp(0)
							For i:=2 to Len(aSaldo)
								AADD(aCM,aSaldo[i]/aSaldo[1])
							Next i
        	    		Else
							aCm := PegaCmAtu(cProduto,cLocal)
	            		EndIf
                	Else
            	    	aCM := PegaCMFim(cProduto,cLocal)
					EndIf
		            dbSelectArea(cAliasSB7)

					If mv_par11 == 1 
						@ Li,If(mv_par13==1,169,132) + nCOL1 PSAY Transform(nTotal-aSaldo[1], (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
						@ Li,If(mv_par13==1,188,151) + nCOL1 PSAY Transform((nTotal-aSaldo[1])*aCM[mv_par10], (cAliasSB2)->(PesqPict("SB2",'B2_VFIM1', 15)))
					Else
						@ Li,If(mv_par13==1,152,114) + nCOL1 PSAY Transform(nTotal-aSaldo[1], (cAliasSB7)->(PesqPict("SB7",'B7_QUANT', 15)))
						@ Li,If(mv_par13==1,171,133) + nCOL1 PSAY Transform((nTotal-aSaldo[1])*aCM[mv_par10], (cAliasSB2)->(PesqPict("SB2",'B2_VFIM1', 15)))
					EndIf
					nTotVal += (nTotal-aSaldo[1])*aCM[mv_par10]
					nSubVal += (nTotal-aSaldo[1])*aCM[mv_par10]
				EndIf
				Li++
			Else
				#IFNDEF TOP
					(cAliasSB2)->(dbSkip())
					Loop
				#ENDIF	
			EndIf
		EndDo
		
	#IFNDEF TOP
		(cAliasSB2)->(dbSkip())
		
	EndDo

	dbSelectArea(cAliasSB1)
	dbSkip()
	#ENDIF
	
	If aReturn[8] == 2
		If cAnt # B1_TIPO .And. nSB7Cnt >= 1
			If mv_par11 == 1
				@ Li,If(mv_par13==1,158,120) + nCOL1 PSAY STR0018 + Left(cAnt,2) + ' .............' // 'TOTAL DO TIPO '
				@ Li,If(mv_par13==1,188,151) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			Else     
				@ Li,If(mv_par13==1,142,098) + nCOL1 PSAY STR0018 + Left(cAnt,2) + ' ............' // 'TOTAL DO TIPO '
				@ Li,If(mv_par13==1,171,133) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			EndIf
			cAnt    := B1_TIPO
			nSubVal := 0
			Li += 2
			nSB7Cnt := 0
		EndIf
	ElseIf aReturn[8] == 3
		If cAnt # B1_GRUPO  .And. nSB7Cnt >= 1
			If mv_par11 == 1 
				@ Li,If(mv_par13==1,155,117) + nCOL1 PSAY STR0019 + Left(cAnt,4) + ' .............' // 'TOTAL DO GRUPO '
				@ Li,If(mv_par13==1,188,151) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			Else
				@ Li,If(mv_par13==1,135,096) + nCOL1 PSAY STR0019 + Left(cAnt,4) + ' .............' // 'TOTAL DO GRUPO '
				@ Li,If(mv_par13==1,171,133) + nCOL1 PSAY Transform(nSubVal, (cAliasSB2)->(PesqPict("SB2",'B2_QFIM', 15)))
			EndIf
			cAnt    := B1_GRUPO
			nSubVal := 0
			Li += 2
			nSB7Cnt := 0
		EndIf
	EndIf
	
EndDo

If nTotVal # 0
	Li++
	If mv_par11 == 1
		@ Li,If(mv_par13==1,145,107) + nCOL1 PSAY STR0020 // 'TOTAL DAS DIFERENCAS EM VALOR .............'
		@ Li,If(mv_par13==1,188,151) + nCOL1 PSAY Transform(nTotVal, (cAliasSB2)->(PesqPict("SB2",'B2_VFIM1', 15)))
	Else
		@ Li,If(mv_par13==1,120,086) + nCOL1 PSAY STR0020 // 'TOTAL DAS DIFERENCAS EM VALOR .............'
		@ Li,If(mv_par13==1,171,133) + nCOL1 PSAY Transform(nTotVal, (cAliasSB2)->(PesqPict("SB2",'B2_VFIM1', 15)))
	EndIf
EndIf

If Li # 80
	Roda(nCntImpr, cRodaTxt, Tamanho)
EndIf

//��������������������������������������������������������������Ŀ
//� Devolve a condicao original do arquivo principal             �
//����������������������������������������������������������������
dbSelectArea(cString)
RetIndex(cString)
dbSetOrder(1)
dbClearFilter()

#IFNDEF TOP
	(cAliasSB2)->(dbSetOrder(1))
	(cAliasSB7)->(dbSetOrder(1))
	(cAliasSB1)->(dbSetOrder(1))
#ELSE	
	dbSelectArea(cAliasSB1)
	dbCloseArea()
#ENDIF
If !empty(cNomArq)
	If aReturn[8] == 5 .or. (lVEIC .And. (aReturn[8] == 1 .or. aReturn[8] == 2))
		If File(cNomArq + OrdBagExt())
			fErase(cNomArq + OrdBagExt())
		EndIf
	EndIf
EndIf

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf

MS_FLUSH()

If IsIncallStack("A004Exec")
	U_A004LOG()
EndIf


Return Nil

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �A285QryFil� Autor � Marcos V. Ferreira    � Data � 15.04.05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao utilizada para adicionar no select os campos        ���
���			 � utilizados no filtro de usuario.                           ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR285                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/

Static Function A285QryFil(cAlias,cQuery,cFilUser)
Local cQryAd	:= ""
Local cName		:= ""
Local aStruct	:= (cAlias)->(dbStruct())
Local nX		:= 0
Default cAlias  := ""
Default cQuery  := ""
Default cFilUser:= ""

//�������������������������������������������������������������������Ŀ
//�Esta rotina foi escrita para adicionar no select os campos         �
//�usados no filtro do usuario quando houver, a rotina acrecenta      �
//�somente os campos que forem adicionados ao filtro testando         �
//�se os mesmo j� existem no select ou se forem definidos novamente   �
//�pelo o usuario no filtro.                                          �
//���������������������������������������������������������������������	   	
If !Empty(cFilUser)
	For nX := 1 To (cAlias)->(FCount())
		cName := (cAlias)->(FieldName(nX))
		If AllTrim( cName ) $ cFilUser
	    	If aStruct[nX,2] <> "M"  
	      	    If !cName $ cQuery .And. !cName $ cQryAd
		    		cQryAd += cName +","
	            EndIf 	
			EndIf
		EndIf 			       	
	Next nX
EndIf    

Return cQryAd

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AjustaSX1 � Autor � Marcos V. Ferreira    � Data � 21.06.06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta o grupo de perguntas                                ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR285                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/
Static Function AjustaSX1()  
Local aAreaSX1:= SX1->(GetArea())
Local aHelpP := {'Utilizado para listar somente produtos:'	,'- Com diferen�as'		,'- Sem diferen�as'		,'- Todos os produtos'	}
Local aHelpE := {'Used for show products only:'				,'- With Differences'	,'- Without Differences','- All products'		}
Local aHelpS := {'Utilizado para muestra solo productos:'	,'- Com Diferencias'	,'- Sin Diferencias'	,'- Todos los productos'}

PutSx1(	'MTR285', '14' ,'Listar Produtos ', 'Muestra Productos ', 'Show Products ',	'mv_che', 'N', 1, 0, 3, 'C', '', '', '', '', 'mv_par14','Com Diferen�as',;
		'Com Diferencias','With Differences', '','Sem Diferen�as','Sin Diferencias','Without Differences','Todos','Todos','All','','','','','','')
		
PutSX1Help("P.MTR28514.",aHelpP,aHelpE,aHelpS)

SX1->(DbSetOrder(1))
If SX1->(DbSeek(Padr("MTR285",Len(SX1->X1_GRUPO))+"11"))
	If Alltrim(SX1->X1_DEF02) != "N�o"
		RecLock("SX1",.F.)
		SX1->X1_DEF02 := "N�o"
		MsUnlock()
	EndIf
EndIf

If SX1->(DbSeek(Padr("MTR285",Len(SX1->X1_GRUPO))+"13"))
	If Alltrim(SX1->X1_DEF02) != "N�o"
		RecLock("SX1",.F.)
		SX1->X1_DEF02 := "N�o"
		MsUnlock()
	EndIf
EndIf

RestArea(aAreaSX1)

Return
