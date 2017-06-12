#INCLUDE "PROTHEUS.CH" 
#Include "TBICONN.CH"
#INCLUDE "FILEIO.CH"    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZNCG01	     บAutor  ณRodrigo A. Tosin	  บData  ณ 17/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para gerar mBrowse da tabela ZAA					  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil						   									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 

User Function KZNCG01() 
	Local alArea 		:= GetARea() 
	Local 	clAlias     := "ZAA"
	Private cCadastro 	:= "Clientes X Tipo de Documento"
	Private aRotina  	:= {} 
	
	dbSelectArea("SX2")
		SX2->(dbSetOrder(1))
		SX2->(dbGoTop())
		
		If SX2->(dbSeek(clAlias))	
				
			AADD(aRotina,{"Pesquisar"	,"AxPesqui"		,0,1})
			AADD(aRotina,{"Visualizar"	,"U_KZNC01"		,0,2})
			AADD(aRotina,{"Incluir" 	,"U_KZNC01"		,0,3})   
			AADD(aRotina,{"Manuten็ใo" 	,"U_KZNC01"		,0,4})
			
			dbSelectArea(clAlias)
			dbSetOrder(1)
			mBrowse(,,,,clAlias) 
		Else  
			ShowHelpDlg(clAlias, {"A tabela " + clAlias + " nใo existe no Dicionแrio de Arquivos"},5,{"Execute o update U_UPDNCG01."},5)	
		EndIf
	RestArea(alArea)
Return

/*            
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZNC01		 บAutor  ณRodrigo A. Tosin    บ Data ณ 17/05/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para gerar tela com cabecalho e itens da ZAA			   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames	                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcAlias - Tabela posicionada - ZAA 							   บฑฑ
ฑฑบ  		 ณnReg   - Numero do registro posicionado   					   บฑฑ
ฑฑบ  		 ณnOpc	 - Opcao da MBrowse									       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil  							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function KZNC01(cAlias,nReg,nOpc)
 
 	Local oDlgZAA  	 	:= Nil

	Local oBtnPesq

	Local olSayCli	
	Local olGetCli  
	
	Local olSayLoj		
	Local olGetLoj
	
	Local olSayNom	 
	Local olGetNom 			

	Local aButtons 		:= {}
		
	Local oFont 		:= TFont():New('Arial',,14,.T.)  
	Local llRet			:= .F.	  
	
    Private oTcBrowse 		
	Private lRefresh 	:= .T.
	Private aHeader 	:= {}
	Private aCols 		:= {}
    Private bLine		:= {|| }

	Private cpGetCli    := Space(6)
	Private cpGetLoj    := Space(2)	 
	Private cpGetNom   	:= Space(40)
		
	Private oOk 		:= LoadBitmap( GetResources(), "LBOK")
	Private oNo 		:= LoadBitmap( GetResources(), "LBNO")
    
	oDlgZAA  		 :=	TDialog():New(000,000,600,800,'Cliente X Tipo de Documento',,,,,CLR_BLACK,CLR_WHITE,,,.T.)

 	AADD(aButtons,{"SELECTALL"	  			,	{|| SelTodos()}	   					,"Seleciona Todos"})			 	
 	AADD(aButtons,{"UNSELECTALL"	  		,	{|| DesmarTo()}	 					,"Desmarca Todos" })    
 
	MontaGrid()
    
	If nOpc <> 3
		MarcaTP()	
	EndIf

	olSayCli     		   		:= TSay():New(015,002,{|| "Cliente: "},oDlgZAA,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,090,010)
	olGetCli     		   		:= TGet():New(013,020,{|u| if(PCount()>0,cpGetCli:=u,cpGetCli)},oDlgZAA,040,007,'@!',{|| IIF(INCLUI, KZVCL01(),)},,,,,,.T.,,,,,,	{|| },,,,'cpGetCli')
	olGetCli:cF3 		   		:= "SA1"
	
	olSayLoj    				:= TSay():New(015,070,{|| "Loja: "},oDlgZAA,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,090,010)	
	olGetLoj    		   		:= TGet():New(013,088,{|u| if(PCount()>0,cpGetLoj:=u,cpGetLoj)},oDlgZAA,020,007,'@!',{||  IIF(INCLUI, KZVCL01(),)},,,,,,.T.,,,,,,	{|| },,,,'cpGetLoj')

	olSayNom     				:= TSay():New(015,118,{|| "Nome: "},oDlgZAA,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,090,010)				
	olGetNom     				:= TGet():New(013,136,{|u| if(PCount()>0,cpGetNom:=u,cpGetNom)},oDlgZAA,200,007,'@!',{||  },,,,,,.T.,,,,,,	{|| },,,,'cpGetNom') 
	olGetNom:lReadOnly 			:= .T.
	
    oTcBrowse   				:= TCBrowse():New( 030,002,400,240,,aHeader,{},oDlgZAA,,,,,{||},,,,,,,.F.,,.T.,,.F.,,,) //TCBrowse():New( 030,002,400,270,,aHeader,{},oDlgZAA,,,,,{||},,,,,,,.F.,,.T.,,.F.,,,)
    oTcBrowse:SetArray(aCols) 
    oTcBrowse:AHEADERS 	   		:= aHeader
    oTcBrowse:bLine 	   		:= {|| {IIF(aCols[oTcBrowse:nAt][1],oOK,oNo),aCols[oTcBrowse:nAt][2],aCols[oTcBrowse:nAt][3]}}
    oTcBrowse:bLDBlClick  		:= {|| aCols[oTcBrowse:nAt][1] := !aCols[oTcBrowse:nAt][1]}
	oTcBrowse:lAdjustColSize	:= .T.
	
	If nOpc <> 3
		olGetCli:lReadOnly	:=	.T.
		olGetLoj:lReadOnly	:=	.T.			
	EndIf
		
	If 		nOpc == 3
		oDlgZAA:Activate(,,,.T.,,(EnchoiceBar(oDlgZAA, {|| IIF(KZINC01(cAlias,nReg,nOpc),oDlgZAA:End(),)},{|| oDlgZAA:End()},,@aButtons)),)	
    ElseIf  nOpc == 4 
		oTcBrowse:lReadOnly :=	.F.	
   		
   		oDlgZAA:Activate(,,,.T.,,(EnchoiceBar(oDlgZAA, {|| IIF(KZALT01(cAlias,nReg,nOpc),oDlgZAA:End(),)},{|| oDlgZAA:End()},,@aButtons)),)
   	Else 
		oTcBrowse:lReadOnly :=	.T.	   	
   		oDlgZAA:Activate(,,,.T.,,(EnchoiceBar(oDlgZAA, {|| oDlgZAA:End()},{|| oDlgZAA:End()},,@aButtons)),)		   		
   	EndIf		    
Return llRet
/*            
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณSelTodos		 บAutor  ณRodrigo A. Tosin    บ Data ณ 17/05/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSeleciona todos os registros da TcBrowse de tipos de documentos. บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames	                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil  							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SelTodos()
	Local nlX := 1
	
	For nlX := 1 to Len(aCols)
		aCols[nlX][1] := .T.
	Next nlX
Return

/*            
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณDesmarTo		 บAutor  ณRodrigo A. Tosin    บ Data ณ 17/05/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDesmarca todos os registros da TcBrowse de tipos de documentos.  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames	                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil  							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DesmarTo()
	Local nlX := 1
	
	For nlX := 1 to Len(aCols)
		aCols[nlX][1] := .F.
	Next nlX
Return
/*            
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณMontaGrid		 บAutor  ณRodrigo A. Tosin    บ Data ณ 17/05/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar grid de informacoes de tipos de documentos	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames	                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil  							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MontaGrid()
    Local clQuery := ""

	aHeader := {"","Tipo De Documento","Descri็ใo"} 
			
	clQuery := "SELECT X5_CHAVE,X5_DESCRI"    			+ CRLF
	clQuery += " FROM " + RetSQLName("SX5") 			+ CRLF
	clQuery += " WHERE "								+ CRLF
	clQuery += " 		X5_CHAVE 	<> 	'ZA' "			+ CRLF
	clQuery += " 	AND X5_TABELA 	= 	'ZA' "			+ CRLF
	clQuery += " 	AND D_E_L_E_T_ 	<> 	'*'"
	
	clQuery := ChangeQuery(clQuery)

	
	If Select("SX5QRY") > 0
		SX5QRY->(dbCloseArea())
	EndIf
	                                                                 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "SX5QRY" ,.T.,.F.)
	
	If SX5QRY->(!EOF())
		While SX5QRY->(!EOF())
   			aADD(aCols,{.F.,SX5QRY->X5_CHAVE,SX5QRY->X5_DESCRI})
			SX5QRY->(dbSkip())   			
   		EndDo
   	Else
   	   aCols :=	{{.F.,'',''}}  		
   	EndIf			
Return
/*            
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณMarcaTP		 บAutor  ณRodrigo A. Tosin    บ Data ณ 17/05/2012  บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para marcar tipos de documentos do cliente				   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณVisualTop                                                        บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															   บฑฑ  
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil  							                                   บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MarcaTP() 
	Local clQuery 	:= ""
	Local nlPos 	:= 0 
	
	clQuery := "SELECT"	  								   					+ CRLF
	clQuery += "		ZAA.ZAA_CLIENT"	  									+ CRLF
	clQuery += "		,ZAA.ZAA_LOJA"	  									+ CRLF   
	clQuery += "		,SA1.A1_NOME"	  									+ CRLF	
	clQuery += "		,ZAA.ZAA_TPDOC"	  									+ CRLF
	clQuery += "		,SX5.X5_DESCRI"	  									+ CRLF
	clQuery += "FROM"	  								  					+ CRLF
	clQuery += "("	  								  	  					+ CRLF
	clQuery += "	SELECT"	  								   				+ CRLF 
	clQuery += "		ZAA_CLIENT"	  						   				+ CRLF
	clQuery += "		,ZAA_LOJA"	  						   				+ CRLF
	clQuery += "		,ZAA_TPDOC"	  										+ CRLF 
	clQuery += "	FROM " + RetSQLName("ZAA")								+ CRLF
	clQuery += "	WHERE"													+ CRLF 
	clQuery += "			ZAA_FILIAL	= '" + xFilial("ZAA") 	+ "'"		+ CRLF
	clQuery += "		AND	ZAA_CLIENT	= '" + ZAA->ZAA_CLIENT	+ "'"		+ CRLF
	clQuery += "		AND ZAA_LOJA	= '" + ZAA->ZAA_LOJA 	+ "'"		+ CRLF
	clQuery += "		AND D_E_L_E_T_	<> '*'"								+ CRLF
	clQuery += ") ZAA"	   													+ CRLF
	clQuery += "INNER JOIN"													+ CRLF
	clQuery += "("	   														+ CRLF
	clQuery += "	SELECT X5_CHAVE,X5_DESCRI"	   							+ CRLF
	clQuery += "	FROM " + RetSQLName("SX5")								+ CRLF
	clQuery += "	WHERE"													+ CRLF
	clQuery += "			X5_FILIAL	= '" + xFilial("SX5") 	+ "'"  		+ CRLF	
	clQuery += "		AND	X5_CHAVE 	<> 	'ZA'"	   						+ CRLF 
	clQuery += "		AND X5_TABELA 	= 	'ZA'"	   						+ CRLF
	clQuery += "		AND D_E_L_E_T_ 	<> 	'*'"	   						+ CRLF		
	clQuery += ") SX5"														+ CRLF
	clQuery += "ON ZAA.ZAA_TPDOC = SX5.X5_CHAVE"							+ CRLF
	clQuery += "INNER JOIN"	   					   	 						+ CRLF 
	clQuery += "("	   					   									+ CRLF
	clQuery += "	SELECT A1_COD,A1_LOJA,A1_NOME"	   						+ CRLF 
	clQuery += "	FROM " + RetSQLName("SA1")		  						+ CRLF
	clQuery += "	WHERE"												 	+ CRLF
	clQuery += "		A1_COD 			= '" + ZAA->ZAA_CLIENT	+ "'"		+ CRLF
	clQuery += "		AND A1_LOJA 	= '" + ZAA->ZAA_LOJA 	+ "'"		+ CRLF
	clQuery += "		AND D_E_L_E_T_ <> '*'"								+ CRLF
	clQuery += ") SA1"														+ CRLF
	clQuery += "ON 		SA1.A1_COD = ZAA.ZAA_CLIENT"						+ CRLF
	clQuery += 	"	AND SA1.A1_LOJA = ZAA.ZAA_LOJA" 	
	
	clQuery := ChangeQuery(clQuery)
	
	If Select("SX5QRY") > 0
		SX5QRY->(dbCloseArea())
	EndIf 
		                                                                 
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery), "SX5QRY" ,.T.,.F.)
	
	If SX5QRY->(!EOF())
		cpGetCli := SX5QRY->ZAA_CLIENT
		cpGetLoj := SX5QRY->ZAA_LOJA		
		cpGetNom := SX5QRY->A1_NOME
				
		While SX5QRY->(!EOF())
			nlPos := aScan(aCols, {|x| x[3] == SX5QRY->X5_DESCRI})
			If nlPos > 0
				aCols[nlPos][1] := .T.	
			EndIf
			SX5QRY->(dbSkip())   			
   		EndDo
   	Else
   	   aCols :=	{{.F.,'',''}}  		
   	EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZVIS01	     บAutor  ณRodrigo A. Tosin	  บData  ณ 17/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para retornar informacoes na visualizacao			  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcAlias - Tabela posicionada - ZAA 							  บฑฑ
ฑฑบ  		 ณnReg   - Numero do registro posicionado   					  บฑฑ
ฑฑบ  		 ณnOpc	 - Opcao de Visualizacao = 2							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function KZVIS01(cAlias,nReg,nOpc)
	M->ZAA_NOME  	:= POSICIONE("SA1",1,xFilial("SA1")+ZAA->ZAA_CLIENT+ZAA->ZAA_LOJA,"A1_NREDUZ")
    M->ZAA_DESC	  	:= POSICIONE("SX5",1,xFilial("SX5")+"ZA"+ZAA->ZAA_TPDOC,"X5_DESCRI")	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZINC01	     บAutor  ณRodrigo A. Tosin	  บData  ณ 17/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar inclusao da tabela ZAA				  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcAlias - Tabela posicionada - ZAA 							  บฑฑ
ฑฑบ  		 ณnReg   - Numero do registro posicionado   					  บฑฑ
ฑฑบ  		 ณnOpc	 - Opcao de Inclusao = 3								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - .T. se a inclusao foi efetuada com sucesso			  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
Static Function KZINC01(cAlias,nReg,nOpc)
	Local clFilial 	:= xFilial(cAlias)
	Local alInfo 	:= {}
	Local nlX 	 	:= 1
	Local llRet		:= .T.
	Local nlCont	:= 0
	
	For nlX := 1 to Len(aCols)
		If aCols[nlX][1]
			AADD(alInfo,{clFilial,cpGetCli,cpGetLoj,cpGetNom,aCols[nlX][2]})
			nlCont++
		EndIf
	Next nlX
	If nlCont > 0
		If Select(cAlias) == 0
			dbSelectArea(cAlias)
		EndIf
		(cAlias)->(dbSetOrder(1))
		(cAlias)->(dbGoTop())	
		 
		For nlX := 1 to Len(alInfo)
	    	If (cAlias)->(dbSeek(alInfo[nlX][1]+alInfo[nlX][2]+alInfo[nlX][3]+alInfo[nlX][5]))
				ShowHelpDlg("JaExiste",{"Jแ existe o tipo de documento " + ALLTRIM(alInfo[nlX][5]) + " cadastrado para o Cliente: " + ALLTRIM(alInfo[nlX][2]) + " e Loja: " + ALLTRIM(alInfo[nlX][3]) + "."},5,{"Cadastre outro tipo de documento ou mude o c๓digo de Cliente/Loja para efetuar a inclusใo."},5)	
				llRet := .F.
	    		Exit
	    	EndIf
	    	(cAlias)->(dbGoTop())
		Next nlX 
		

   		For nlX := 1 to Len(alInfo)	
			If RecLock(cAlias,.T.)
				(cAlias)->ZAA_FILIAL 	:= alInfo[nlX][1]
				(cAlias)->ZAA_CLIENT 	:= alInfo[nlX][2]
				(cAlias)->ZAA_LOJA 		:= alInfo[nlX][3]
				(cAlias)->ZAA_NOME 		:= alInfo[nlX][4]				
				(cAlias)->ZAA_TPDOC  	:= alInfo[nlX][5]
			EndIf
			(cAlias)->(MsUnlock())
		Next nlX
		cpGetCli := ""
		cpGetLoj := ""		
		cpGetNom := ""				
	Else
		ShowHelpDlg("SemTipo",{"Nใo foram selecionados tipos de documentos para esse cliente."},5,{"Selecione pelo menos um tipo de documento para o cliente."},5)			
		llRet := .F.		
	EndIf	
Return llRet
	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZALT01	     บAutor  ณRodrigo A. Tosin	  บData  ณ 17/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar alteracao da tabela ZAA				  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcAlias - Tabela posicionada - ZAA 							  บฑฑ
ฑฑบ  		 ณnReg   - Numero do registro posicionado   					  บฑฑ
ฑฑบ  		 ณnOpc	 - Opcao de Alteracao = 4								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - .T. se a manutencao foi concluida com sucesso			  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
Static Function KZALT01(cAlias,nReg,nOpc)
	Local clFilial 	:= xFilial(cAlias)
	Local alInfo 	:= {}
	Local nlX 	 	:= 1
	Local alInfoEx 	:= {}
    Local llRet		:= .T.
    		
	For nlX := 1 to Len(oTcBrowse:aArray)
		If oTcBrowse:aArray[nlX][1]
			AADD(alInfo,{clFilial,cpGetCli,cpGetLoj,cpGetNom,aCols[nlX][2]})
		Else
			AADD(alInfoEx,{clFilial,cpGetCli,cpGetLoj,cpGetNom,aCols[nlX][2]})			
		EndIf
	Next nlX

	If Select(cAlias) == 0
		dbSelectArea(cAlias)
	EndIf
	(cAlias)->(dbSetOrder(1))
	(cAlias)->(dbGoTop())	

   	For nlX := 1 to Len(alInfo)	
	   	If (cAlias)->(!dbSeek(alInfo[nlX][1]+alInfo[nlX][2]+alInfo[nlX][3]+alInfo[nlX][5]))
			If RecLock(cAlias,.T.)
				(cAlias)->ZAA_FILIAL 	:= alInfo[nlX][1]
				(cAlias)->ZAA_CLIENT 	:= alInfo[nlX][2]
				(cAlias)->ZAA_LOJA 		:= alInfo[nlX][3] 
				(cAlias)->ZAA_NOME 		:= alInfo[nlX][4]				
				(cAlias)->ZAA_TPDOC  	:= alInfo[nlX][5]
			EndIf
			(cAlias)->(MsUnlock())
		EndIf	
		(cAlias)->(dbGoTop())		
	Next nlX
	If Len(alInfoEx) == 15 
		If MsgYesNo("Esta a็ใo irแ excluir TODOS os tipos de documentos referentes ao Cliente: " + cpGetCli + " Loja: " + cpGetLoj + "." + CRLF + "Tem certeza?","Exclusใo")
		 	For nlX := 1 to Len(alInfoEx)
		 		If (cAlias)->(dbSeek(alInfoEx[nlX][1]+alInfoEx[nlX][2]+alInfoEx[nlX][3]+alInfoEx[nlX][5]))	
					If RecLock(cAlias,.F.)
						(cAlias)->(dbDelete())
					EndIf
				EndIf	
				(cAlias)->(MsUnlock())
				(cAlias)->(dbGoTop())
			Next nlX
		EndIf
	Else
	 	For nlX := 1 to Len(alInfoEx)
	 		If (cAlias)->(dbSeek(alInfoEx[nlX][1]+alInfoEx[nlX][2]+alInfoEx[nlX][3]+alInfoEx[nlX][5]))	
				If RecLock(cAlias,.F.)
					(cAlias)->(dbDelete())
				EndIf
			EndIf	
			(cAlias)->(MsUnlock())
			(cAlias)->(dbGoTop())
		Next nlX
	EndIf

Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ TudOK01	     บAutor  ณRodrigo A. Tosin	  บData  ณ 17/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar botao de OK na alteracao de cliente da ZAA  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - .T. se validou corretamente, .F. se nao validou		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function TudOK01()
	Local llRet 	:= .T.
	Local nlRecno	:= (cAlias)->(RecNo())
	
	(cAlias)->(dbSetOrder(1))
	(cAlias)->(dbGoTop())
	
	If (cAlias)->(dbSeek(xFilial(cAlias)+M->ZAA_CLIENT+M->ZAA_LOJA+M->ZAA_TPDOC))
		If nlRecno <> (cAlias)->(RecNo()) 
			ShowHelpDlg("JaExiste",{"Jแ existe o tipo de documento " + ALLTRIM(M->ZAA_TPDOC) + " cadastrado para o Cliente: " + ALLTRIM(M->ZAA_CLIENT) + " e Loja: " + ALLTRIM(M->ZAA_LOJA) + "."},5,{"Cadastre outro tipo de documento ou mude o c๓digo de Cliente/Loja para efetuar a inclusใo."},5)	
			llRet := .F.
		EndIf
	EndIf 
Return llRet	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZVCL01	     บAutor  ณRodrigo A. Tosin	  บData  ณ 17/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar cadastro de cliente da ZAA			  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - .T. se validou corretamente, .F. se nao validou		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
Static Function KZVCL01()
	Local alArea 	:= GetArea() 
	Local llRet 	:= .T.
    Local clAlias   := "ZAA"
    
	If 		!Empty(cpGetCli) .AND. !Empty(cpGetLoj)
		If Select("SA1") == 0
			dbSelectArea("SA1")  
		EndIf
		SA1->(dbSetOrder(1))
		SA1->(dbGoTop())		
		If SA1->(!dbSeek(xFilial("SA1")+cpGetCli+cpGetLoj))
			ShowHelpDlg("CLIENTE",{"Nใo existe registro relacionado a esse c๓digo."},5,{"Digite um c๓digo/loja de cliente vแlido."},5)
			cpGetNom 	:= ''
			llRet 		:= .F.
		Else
			cpGetNom := SA1->A1_NREDUZ 
			If llRet 
		   		If Select(clAlias) == 0		
			   		dbSelectArea(clAlias)
			   	EndIf	
				(clAlias)->(dbSetOrder(1))
				(clAlias)->(dbGoTop())
				If (clAlias)->(dbSeek(xFilial(clAlias)+cpGetCli+cpGetLoj))
					ShowHelpDlg("CLIENTE",{"Nใo ้ possํvel efetuar inclusใo para um cliente jแ cadastrado."},5,{"Altere/Exclua informa็๕es desse cliente em 'Manuten็ใo'."},5)
			  		cpGetNom 	:= ''
			  		llRet 		:= .F.
			  	EndIf	
			EndIf
		EndIf
	ElseIf !Empty(cpGetCli)
		cpGetLoj := POSICIONE('SA1',1,xFilial("SA1")+cpGetCli,"A1_LOJA")
		cpGetNom := POSICIONE('SA1',1,xFilial("SA1")+cpGetCli,"A1_NREDUZ")		
	Else	
   		cpGetNom	:= ''		
	EndIf

	RestArea(alArea)
Return llRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZVlTDoc	     บAutor  ณAdam Diniz Lima	  บData  ณ 18/07/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que permite documento para cliente + Loja		 		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGames                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclCliFat - Cliente a ser validado								  บฑฑ
ฑฑบ			 ณclLjFat - Loja do Cliente a ser validado						  บฑฑ
ฑฑบ			 ณclTpDoc - Numeracao em Caracter referente ao documento		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณllRet - .T. se Permitir										  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function KZVlTDoc(clCliFat,clLjFat,clTpDoc)
	                  
	Local alArea	:= GetArea()
	Local llRet		:= .F.
	
	DbSelectArea("ZAA")
	ZAA->(DbSetOrder(1))
	ZAA->(DbGoTop())
	
	llRet := ZAA->(DbSeek(xFilial("ZAA")+ AvKey(clCliFat,"ZAA_CLIENT") + AvKey(clLjFat,"ZAA_LOJA") + clTpDoc ))

	RestArea(alArea)    

Return llRet