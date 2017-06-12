#Include 'Protheus.Ch'
#Include 'TopConn.Ch'
#Include 'TbiConn.Ch'
#Include 'XMLXFUN.Ch'
#Include 'TOTVS.Ch'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

User Function IMPPRENF()

SetPrvt("oDlg1","oGrp1","oBtn1","oBtn2")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlg1      := MSDialog():New( 091,232,246,504,"Amarração de Produtos",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 008,008,060,120,"Fornecedor ou Cliente?",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oBtn1      := TButton():New( 028,020,"Fornecedor",oGrp1,{||opt(1)},037,012,,,,.T.,,"",,,,.F. )
oBtn2      := TButton():New( 028,068,"Cliente",oGrp1,{||opt(2)},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

Return 


Static Function opt(tipo)

Local aArea := GetArea()
Private nOpc      	:= 0
Private cCadastro 	:= "Ler arquivo texto"
Private aSay      	:= {}
Private aButton   	:= {}

/*
Private oSay1      := TSay():New( 008,012,{||"Fornecedor"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
Private oSay2      := TSay():New( 028,012,{||"Loja:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
Private oGet1      := TGet():New( 008,048,,oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","",,)
Private oGet2      := TGet():New( 028,048,,oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
*/

Private cGet2      := Space(2)
Private cgGet1     := Space(6)

SetPrvt("oDlg1","oSay1","oSay2","oGet1","oGet2","oBtn1")

oDlg1      := MSDialog():New( 091,232,238,441,"Import",,,.F.,,,,,,.T.,,,.T. )

If tipo == 1 
oSay1      := TSay():New( 016,008,{||"Fornecedor:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 032,008,{||"Loja:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oGet1      := TGet():New( 016,044,{|u| If(PCount()>0,cgGet1:=u,cgGet1)},oDlg1,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA2","cgGet1",,)
oGet2      := TGet():New( 032,044,{|u| If(PCount()>0,cGet2:=u,cGet2)},oDlg1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGet2",,)
ElseIf tipo == 2
oSay1      := TSay():New( 016,008,{||"Cliente:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 032,008,{||"Loja:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oGet1      := TGet():New( 016,044,{|u| If(PCount()>0,cgGet1:=u,cgGet1)},oDlg1,044,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cgGet1",,)
oGet2      := TGet():New( 032,044,{|u| If(PCount()>0,cGet2:=u,cGet2)},oDlg1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cGet2",,)
EndIF


oBtn1      := TButton():New( 064,032,"Selecionar Arquivo",oDlg1,{|| Import(tipo),oDlg1:END() },048,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)


RestArea(aArea)

Return


//+-------------------------------------------
//| Função - Import()  
//+-------------------------------------------
Static Function Import(tipo)

Local aArea := GetArea()
Local cBuffer   	:= ""
Local cFileOpen 	:= ""
Local cTitulo1  	:= "Selecione o arquivo"
Local cExtens   	:= "Arquivo csv | *.csv"
Local dirPadr := "C:\notas-a-processar\"
Private aArrayItens :={}
	/***
 * _________________________________________________________
 * cGetFile(<ExpC1>,<ExpC2>,<ExpN1>,<ExpC3>,<ExpL1>,<ExpN2>)
 * ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
 * <ExpC1> - Expressão de filtro
 * <ExpC2> - Titulo da janela
 * <ExpN1> - Numero de mascara default 1 para *.Exe
 * <ExpC3> - Diretório inicial se necessário
 * <ExpL1> - .F. botão salvar - .T. botão abrir
 * <ExpN2> - Mascara de bits para escolher as opções de visualização do objeto
 * (prconst.ch)
 */
//cFileOpen := cGetFile( '*.txt' , 'NOTAS (TXT)', 1, dirPadr, .F., nOR( GETF_LOCALHARD, GETF_RETDIRECTORY,GETF_NETWORKDRIVE ),.F., .T. )
cFileOpen := cGetFile ( '*.csv|*.csv' , 'Notas (csv)', 1, dirPadr, .F., GETF_LOCALHARD + GETF_LOCALFLOPPY)



If !File(cFileOpen)
   MsgAlert("Arquivo texto: "+cFileOpen+" não localizado",cCadastro)
   Return
Endif

FT_FUSE(cFileOpen)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER

While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
   IncProc()

   // Capturar dados
   cBuffer := FT_FREADLN() //LENDO LINHA 
   
   aItens := strtokarr(cBuffer,";")
   AADD(aArrayItens, aItens)
   FT_FSKIP()   //próximo registro no arquivo txt
EndDo

FT_FUSE() //fecha o arquivo txt
	
	IF tipo == 1
   	
   		FOR ny := 1 TO LEN(aArrayItens)
			Processa({|| gravaSA5(aArrayItens[ny][2],ny)})	
		next
		
	ElseIF tipo == 2
	
		FOR ny := 1 TO LEN(aArrayItens)
			Processa({|| gravaSA7(aArrayItens[ny][2],ny)})	
		next
		
	EndIF

MsgInfo("Processo finalizada")
RestArea(aArea)
Return

static function gravaSA7()

Local a7Alias := "SA7"

Local cQrySA7 :=""
local nPConf


		If Select(a7Alias) > 0
				(a7Alias)->(DbCloseArea())
		EndIf
			
		cQrySA7 := "SELECT A7_CODCLI,A7_CLIENTE,A7_LOJA,A7_FILIAL,A7_DESCCLI,A7_PRODUTO FROM "+RetSqlName("SA7") +CRLF
		cQrySA7 += " where A7_CLIENTE = '"+cgGet1+"' "+CRLF
		cQrySA7 += " AND A7_LOJA = '"+cGet2+"' "+CRLF
		cQrySA7 += " AND A7_FILIAL = '"+xFilial("SA7")+"' "+CRLF
		cQrySA7 += " AND D_E_L_E_T_ = ' ' AND A7_CODCLI='"+ aArrayItens[ny][2] +"' or a7_produto ='"+ aArrayItens[ny][1] +"'"+CRLF
		
		cQrySA7 := ChangeQuery(cQrySA7)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQrySA7),a7Alias,.T.,.T.)
		
		nPConf := trim((a7Alias)->A7_PRODUTO)
		
		(a7Alias)->(DbCloseArea())
		
		if EMPTY(nPConf)
		
			dbSelectArea("SA7")
			dbSetOrder(1)
			
			SA7->(RECLOCK("SA7",.T.))
			SA7->A7_FILIAL  := xFilial("SA7")
			SA7->A7_CLIENTE	:= cgGet1
			SA7->A7_LOJA	:= cGet2
			SA7->A7_PRODUTO	:= aArrayItens[ny][1]//
			SA7->A7_CODCLI	:= aArrayItens[ny][2]//
			SA7->A7_DESCCLI	:= substr(aArrayItens[ny][3],1,30) //
			//SA7->A7_PRECO01	:= ""
			SA7->A7_DTREF01	:= dDataBase
			SA7->(MSUNLOCK())
			
			dbCloseArea("SA7")
			
			If Select(a7Alias) > 0
				(a7Alias)->(DbCloseArea())
			EndIf
				
		endif
				

return

static function gravaSA5()

Local a5Alias := "SA5"

Local cQrySA5 :=""
local nPConf


		If Select(a5Alias) > 0
				(a5Alias)->(DbCloseArea())
		EndIf
			
		
		cQrySA5 := "select A5_PRODUTO from" +RetSqlName("SA5") +CRLF
		cQrySA5 += " WHERE " +CRLF
  		cQrySA5 += " D_E_L_E_T_ = ' ' "+CRLF
  		cQrySA5 += " and A5_FORNECE = '"+cgGet1+"' "+CRLF 
  		cQrySA5 += " and A5_LOJA ='"+cGet2+"' "+CRLF
  		cQrySA5 += " and a5_codprf = '"+ aArrayItens[ny][2] +"' or a5_produto = '"+ aArrayItens[ny][1] +"' "+CRLF
		
		
		cQrySA5 := ChangeQuery(cQrySA5)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQrySA5),a5Alias,.T.,.T.)
		
		nPConf := trim((a5Alias)->A5_PRODUTO)
		
		(a5Alias)->(DbCloseArea())
		
		if EMPTY(nPConf)
		
			dbSelectArea("SA5")
			dbSetOrder(1)
			
			SA5->(RECLOCK("SA5",.T.))
			SA5->A5_FILIAL  := xFilial("SA5")
			SA5->A5_FORNECE	:= cgGet1
			SA5->A5_LOJA	:= cGet2
			SA5->A5_PRODUTO	:= aArrayItens[ny][1]//
			SA5->A5_CODPRF	:= aArrayItens[ny][2]//
			SA5->A5_NOMPROD	:= substr(aArrayItens[ny][3],1,30) //
			SA5->A5_DTCOM01	:= dDataBase
			SA5->(MSUNLOCK())
			
			dbCloseArea("SA5")
			
			If Select(a5Alias) > 0
				(a5Alias)->(DbCloseArea())
			EndIf
				
		endif
				

return