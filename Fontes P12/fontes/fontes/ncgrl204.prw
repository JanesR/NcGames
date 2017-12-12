#INCLUDE "PROTHEUS.CH"

#Define Enter Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  11/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          

User Function JOBRL204FRA(aDados)
Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])
U_NCGRL204(.T.,.T.) //Produtos Franchising
Return



User Function RL204FRA()
U_NCGRL204(.F.,.T.) //Produtos Franchising
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  11/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RL204JOB(aDados)
Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])
U_NCGRL204(.T.)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCGRL204(lJob,lProdFran)
Local aSays:={}
Local aButtons:={}
Local cPerg:="NCGRL204"
Local lOk:=.F.
Local cCadastro:="Tabela de Preços"

Default lJob:=.F.
Default lProdFran:=.F.
Private nHdl
Private cPathExcel  	:= ""
Private cExtExcel   	:= ".xls"

If !lJob	
	AADD( aSays, "Tabela de Preços Nc Games"+IIf(lProdFran,"-Produtos Franchising","") )
	AADD( aButtons, { 01, .T., {|| lOk := .T.,(cPathExcel:=cGetFile( "Defina o diretório | ",OemToAnsi("Selecione Diretorio de Gravação da Planilha"), ,"" ,.f.,GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE) ) ,Iif( !Empty(cPathExcel), FechaBatch(), msgStop("Informe o diretorio de gravaçao da planilha") ) } } )
	AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
	;FormBatch( cCadastro, aSays, aButtons )
Else
	lOk := .T.
	cPathExcel:=GetMV("NC_CGRL204",,"")
EndIf

If lOk .And. !Empty(cPathExcel)
	Processa({ || RL204Filter(lJob,lProdFran)})
EndIf                                      

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL204Filter(lJob,lProdFran)
Local cAliasQry:=GetNextAlias()
Local cQuery
Local cLine:=""
Local nContTot:=0
Local cCpoQry
Local aTotal:={}
Local nInd
Local lFundoBranco:=.T.
Local aLinha:={}     
Local cProdSIPI := Alltrim(SuperGetMv("NCG_000043",.t.,"85234990")) //NCM de produtos que devem aparecer com o IPI 0 para São Paulo

AADD(aLinha,"s108")//01                                     
AADD(aLinha,"s119")//02
AADD(aLinha,"s120")//03
AADD(aLinha,"s121")//04
AADD(aLinha,"s122")//05
AADD(aLinha,"s123")//06
AADD(aLinha,"s124")//07
AADD(aLinha,"s125")//08
AADD(aLinha,"s126")//09
AADD(aLinha,"s126")//10
AADD(aLinha,"s114")//11
AADD(aLinha,"s129")//12

//Private cMvCodTab:= GetMv("MV_NCTABPR",,"zyZ")
Private cParTab	:= Alltrim(U_MyNewSX6("NCG_000063","018;107;112","C","Tabela de preços que aparecem no relatório","","",.F. )   )
Private aCodTabs:= StrTokArr( cParTab,";")
Private nTotLinhas:=0

Private cPathArq:=StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Private cArqXls:=E_Create(,.F.)
Private aDadosPrecos	:={}
    



cQuery:=U_RL204Query("Count(1) Contar","",lProdFran)
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)
nContTot:=(cAliasQry)->Contar
(cAliasQry)->(DbCloseArea())

ProcRegua(nContTot+2)

nHdl := FCreate(cPathArq+cArqXls+cExtExcel)
RL204Cabec()


cCpoQry:="SB1.B1_XSELSIT,SB1.B1_COD,SB1.B1_CODBAR,SB1.B1_XDESC,SB1.B1_PUBLISH,SB1.B1_PLATEXT,SB1.B1_CODGEN,SB1.B1_TECNOC,SB1.B1_CONSUMI,SB1.B1_IPI,SB1.B1_POSIPI,"
cCpoQry+="DA1.DA1_CODTAB,DA1.DA1_PRCVEN"

cQuery:=U_RL204Query(cCpoQry," Order By B1_XSELSIT,B1_COD",lProdFran)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)

nContDebug:=0
Do While (cAliasQry)->(!Eof() )
	cCampanha:=(cAliasQry)->B1_XSELSIT
	
	Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->B1_XSELSIT==cCampanha		
		++nTotLinhas
		
		cLine:='<Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s105">'+Enter
		cLine+='<Cell ss:Index="2" ss:StyleID="s107"/>'+Enter
		cLine+='<Cell ss:StyleID="s108"><Data ss:Type="String">'+NoAcento(AnsiToOem(Tabela('ZU',(cAliasQry)->B1_XSELSIT,.F.)))+'</Data></Cell>'+Enter
		
		cLine+='<Cell ss:StyleID="s109"><Data ss:Type="Number">'+AllTrim((cAliasQry)->B1_COD)    +'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s109"><Data ss:Type="Number">'+AllTrim((cAliasQry)->B1_CODBAR)	+'</Data></Cell>'+Enter
		
		cLine+='<Cell ss:StyleID="s111"><Data ss:Type="String">'+NoAcento(AnsiToOem((cAliasQry)->B1_XDESC)) 	+'</Data></Cell>'+Enter
	   	cLine+='<Cell ss:StyleID="s111"><Data ss:Type="String">'+(cAliasQry)->B1_PUBLISH+'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s111"><Data ss:Type="String">'+(cAliasQry)->B1_PLATEXT+'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s111"><Data ss:Type="String">'+Tabela('Z2',(cAliasQry)->B1_CODGEN,.F.)	+'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s112"><Data ss:Type="String">'+(cAliasQry)->B1_TECNOC	+'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s113"><Data ss:Type="Number">0</Data></Cell>'+Enter
		
		aAuxPrc		:=aClone(aDadosPrecos)
		cProduto	:=(cAliasQry)->B1_COD
		nVlrConsu	:=(cAliasQry)->B1_CONSUMI
		cPosIPI		:= Alltrim((cAliasQry)->B1_POSIPI)
		
		If cPosIPI $ cProdSIPI  	//Adicionado para atender a exceção de Curitiba - Lucas Felipe - 30/09
			nVlrIPI:=0
		Else 
			nVlrIPI:=(cAliasQry)->B1_IPI //Adicionado para atender a exceção de Curitiba - Lucas Felipe - 30/09
	  	EndIf
	  	//	nVlrIPI		:=(cAliasQry)->B1_IPI //Adicionado para atender a exceção de Curitiba - Lucas Felipe - 30/09

		Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->B1_XSELSIT==cCampanha .And. (cAliasQry)->B1_COD ==cProduto		
			IncProc("Processamento....")			
			If (nAscan:=Ascan(aAuxPrc,{|a| a[1]==(cAliasQry)->DA1_CODTAB}))>0
				aAuxPrc[nAscan,2]	:=(cAliasQry)->DA1_PRCVEN
			EndIf
			(cAliasQry)->(DbSkip())
		EndDo
		nCont:=Len(aAuxPrc)
		For nInd:=1 To nCont
			cLine+='<Cell ss:StyleID="s115"><Data ss:Type="Number">'+RL204Trans(aAuxPrc[nInd,2])+'</Data></Cell>'+Enter
		Next
		                                                                                 
		cLine+='<Cell ss:StyleID="s116"><Data ss:Type="Number">'+RL204Trans(nVlrConsu)+'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s134"><Data ss:Type="Number">'+RL204Trans(nVlrIPI/100)+'</Data></Cell>'+Enter
		
		nSaldoAtu:=0
		
		SB2->(DbSetOrder(1))
		If SB2->(DbSeek(xFilial("SB2")+cProduto+"01") )
			nSaldoAtu:=SB2->(B2_QATU-B2_RESERVA)
		EndIf                         
		
		cLine+='<Cell ss:StyleID="s118"><Data ss:Type="Number">'+RL204Trans(nSaldoAtu)+'</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s119"><Data ss:Type="Number">0</Data></Cell>'+Enter
		cLine+='<Cell ss:StyleID="s120" ss:Formula="=(RC[-1]*RC[-'+AllTrim(Str(nCont+5))+'])*(1+RC[-3])"><Data  '+Enter
        cLine+='   ss:Type="Number">0</Data></Cell>'+Enter
	    cLine+='   <Cell ss:StyleID="s121"/>'+Enter
		cLine+='</Row>'
		RL204Write(cLine)

	EndDo
EndDo
RL204RodaPe()
FClose(nHdl)


FT_FUSE(cPathArq+cArqXls+cExtExcel)  //ABRIR
FT_FGOTOP()     //PONTO NO TOPO
nLastRec := FT_FLASTREC()
ProcRegua(nLastRec) //QTOS REGISTROS LER


nHdl:=FCreate(cPathArq+cArqXls+"A"+cExtExcel)
Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	cBuffer := FT_FREADLN() //LENDO LINHA
	If At("ALTERAR_TOTAL",cBuffer)>0
		cBuffer:=StrTran(cBuffer,"ALTERAR_TOTAL","R["+AllTrim(Str(nTotLinhas+3))+"]C")
	EndIf            
	RL204Write(cBuffer+Chr(13)+Chr(10))
	FT_FSKIP()
EndDo
FT_FUSE()  
FClose(nHdl)

cNomArq:="Tabela Preços Nc Games"


IncProc("Copiando planilha "+cNomArq+" para "+cPathExcel)

Ferase(cPathArq+cArqXls)	
Ferase(cPathExcel+cNomArq+cExtExcel)	

If __CopyFile(cPathArq+cArqXls+"A"+cExtExcel, cPathExcel+cArqXls+"A")
	fRename( cPathExcel+cArqXls+"A", cPathExcel+cNomArq+IIf(lProdFran,"_Produtos_Franchising","")+cExtExcel )
	If !lJob
		If !ApOleCliente( "MsExcel" )
			MsgStop( "Microsoft Excel não Instalado... Contate o Administrador do Sistema!" )
		Else
			If MsgYesNo("Abrir o Microsoft Excel?")
				oExcelApp:=MsExcel():New()
				oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
				oExcelApp:SetVisible( .T. )
				oExcelApp:Destroy()
			EndIf
		EndIf
	EndIf	
EndIf



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL204Trans(xDados)
Local xRetorno

If ValType(xDados)=="N"
	xRetorno:=AllTrim(Str(xDados))
ElseIf ValType(xDados)=="D"
	xRetorno:=StrZero(Year(xDados),4)+"-"+StrZero(Month(xDados),2)+"-"+StrZero(Day(xDados),2)+'T00:00:00.000'
EndIf


Return xRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RL204Query(cCpoQry,cOrdenar,lProdFran,lFiltraSB5)
Local cQuery:=""
Local cNCMExce := FormatIn((SuperGetMv("NCG_000042",.t.,"")),";")


Default cCpoQry:="*"
Default cOrdenar:=""
Default lFiltraSB5:=.T.


cQuery:=" Select "+cCpoQry+CRLF
cQuery+=" From "+RetSqlName("SB1")+" SB1,"+RetSqlName("DA1")+" DA1,"+CRLF
cQuery+="( Select DA1_CODTAB,DA1_CODPRO,MAX(R_E_C_N_O_)  Registro From "+RetSqlName("DA1")+" DA1x "+CRLF
cQuery+=" 	Where DA1x.DA1_FILIAL='"+xFilial("DA1")+"'  AND DA1x.DA1_ATIVO='1' And DA1x.D_E_L_E_T_=' '" +CRLF
cQuery+=" 	And DA1x.DA1_CODTAB IN "+FormatIn(cParTab,";")
cQuery+="	Group BY DA1_CODTAB,DA1_CODPRO "+CRLF
cQuery+="	) TabPreco "+CRLF


cQuery+=","+RetSqlName("SB5")+" SB5 "+CRLF


cQuery+=" Where SB1.B1_FILIAL='"+xFilial("SB1")+"'"+CRLF
cQuery+=" And SB1.D_E_L_E_T_=' '"+CRLF
cQuery+=" And SB1.B1_TIPO='PA' "+CRLF
cQuery+=" And SB1.B1_MSBLQL<>'1'"+CRLF
cQuery+=" And SB1.B1_BLQVEND<>'1'"+CRLF

If FWIsInCallStack("WM001Update")
	cQuery+=" And SB1.B1_XUSADO<>'1'"+CRLF
EndIf

cQuery+=" And SB1.B1_COD=DA1.DA1_CODPRO"+CRLF
cQuery+=" And Trim(SB1.B1_POSIPI) Not In "+ cNCMExce +" "+CRLF
cQuery+=" And DA1.R_E_C_N_O_=TabPreco.Registro"+CRLF


cQuery+=" And SB5.B5_FILIAL='"+xFilial("SB1")+"'"+CRLF
cQuery+=" And SB5.B5_COD=SB1.B1_COD"+CRLF
cQuery+=" And SB5.D_E_L_E_T_=' '"+CRLF

If lFiltraSB5
	cQuery+=" And SB5.B5_YFRANCH"+Iif(lProdFran,"=","<>")+"'S'"+CRLF
EndIf	



If !Empty(cOrdenar)
	cQuery+=cOrdenar
EndIf

Return cQuery
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RL204Write(cLine)
FWrite(nHdl,cLine,Len(cLine))
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL204Cabec()
Local cCabec:=""
Local nInd
Local nCnd
Local aCabec:={}
cCabec+='<?xml version="1.0"?>'+Enter
cCabec+='<?mso-application progid="Excel.Sheet"?>'+Enter
cCabec+='<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+Enter
cCabec+=' xmlns:o="urn:schemas-microsoft-com:office:office"'+Enter
cCabec+=' xmlns:x="urn:schemas-microsoft-com:office:excel"'+Enter
cCabec+=' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+Enter
cCabec+=' xmlns:html="http://www.w3.org/TR/REC-html40">'+Enter
cCabec+=' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+Enter
cCabec+='  <Author>rribeiro</Author>'+Enter
cCabec+='  <LastAuthor>Nc Games</LastAuthor>'+Enter
cCabec+='  <LastPrinted>2011-11-23T14:53:48Z</LastPrinted>'+Enter
cCabec+='  <Created>2010-12-10T13:06:25Z</Created>'+Enter
cCabec+='  <LastSaved>2013-01-11T11:00:54Z</LastSaved>'+Enter
cCabec+='  <Version>14.00</Version>'+Enter
cCabec+=' </DocumentProperties>'+Enter
cCabec+=' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+Enter
cCabec+='  <AllowPNG/>'+Enter
cCabec+=' </OfficeDocumentSettings>'+Enter
cCabec+=' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cCabec+='  <WindowHeight>6750</WindowHeight>'+Enter
cCabec+='  <WindowWidth>15000</WindowWidth>'+Enter
cCabec+='  <WindowTopX>360</WindowTopX>'+Enter
cCabec+='  <WindowTopY>1395</WindowTopY>'+Enter
cCabec+='  <TabRatio>514</TabRatio>'+Enter
cCabec+='  <ProtectStructure>False</ProtectStructure>'+Enter
cCabec+='  <ProtectWindows>False</ProtectWindows>'+Enter
cCabec+=' </ExcelWorkbook>'+Enter
cCabec+=' <Styles>'+Enter
cCabec+='  <Style ss:ID="Default" ss:Name="Normal">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='   <Protection/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s18" ss:Name="Moeda">'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s20" ss:Name="Porcentagem">'+Enter
cCabec+='   <NumberFormat ss:Format="0%"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="m59451624">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="16" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#002060" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="Fixed"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s62">'+Enter
cCabec+='   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s63">'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s64">'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s66" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='   <Protection/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s67">'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s69">'+Enter
cCabec+='   <Alignment ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="16" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="00000000000"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s70">'+Enter
cCabec+='   <Alignment ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="16" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s71">'+Enter
cCabec+='   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s72">'+Enter
cCabec+='   <Alignment ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s73">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s74">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="Short Date"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s75">'+Enter
cCabec+='   <Alignment ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s76">'+Enter
cCabec+='   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s77">'+Enter
cCabec+='   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s80" ss:Parent="s20">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="0%"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s81">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="00000000000"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s83">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="52" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s84">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="52" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s85">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s86">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="40" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s94">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="16" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#002060" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s95">'+Enter
cCabec+='   <Alignment ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12" ss:Color="#000000"/>'+Enter
cCabec+='   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s97">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="00000000000"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s98">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#8DB4E2" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s99">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#8DB4E2" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s100">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s101">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#FF0000" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s102">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#000000"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s103">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#8DB4E2" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s104">'+Enter
cCabec+='   <Alignment ss:Vertical="Center" ss:WrapText="1"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12" ss:Color="#000000"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s105">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12"/>'+Enter
cCabec+='   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s107">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="00000000000"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s108">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s109">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="0"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s111" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Horizontal="Left" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s112">'+Enter
cCabec+='   <Alignment ss:Horizontal="Left" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s113" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s114" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s115" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s116" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s118" ss:Parent="s20">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat ss:Format="0"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s119" ss:Parent="s20">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior ss:Color="#FFC000" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="0"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s120" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s121">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s122">'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Trebuchet MS" x:Family="Swiss"/>'+Enter
cCabec+='   <Interior ss:Color="#A6A6A6" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s124">'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Trebuchet MS" x:Family="Swiss"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s125">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#808080" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s126">'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Interior ss:Color="#808080" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s127">'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Interior ss:Color="#808080" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s128">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="2"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="16" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#808080" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_(&quot;R$ &quot;* #,##0.00_);_(&quot;R$ &quot;* \(#,##0.00\);_(&quot;R$ &quot;* &quot;-&quot;??_);_(@_)"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s129">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="18" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s130">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior ss:Color="#DDD9C4" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s131">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12"/>'+Enter
cCabec+='   <Interior ss:Color="#DDD9C4" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s132">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="20" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#002060" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s134" ss:Parent="s20">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="14"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+=' </Styles>'+Enter   
cCabec+=' <Worksheet ss:Name="NC_GAMES">'+Enter
cCabec+='  <Names>'+Enter
cCabec+='   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=NC_GAMES!#REF!"'+Enter
cCabec+='    ss:Hidden="1"/>'+Enter
cCabec+='  </Names>'+Enter
cCabec+='  <Table ss:ExpandedColumnCount="99999" ss:ExpandedRowCount="999999" x:FullColumns="1"'+Enter
cCabec+='   x:FullRows="1" ss:StyleID="s62" ss:DefaultRowHeight="15">'+Enter
cCabec+='   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="4.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="6"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="243.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="113.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="144.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="456"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="108"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="83.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="86.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="85.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="109.5" ss:Span="2"/>'+Enter
cCabec+='   <Column ss:Index="14" ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="102"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="117" ss:Span="2"/>'+Enter
cCabec+='   <Column ss:Index="18" ss:StyleID="s64" ss:Width="109.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s66" ss:AutoFitWidth="0" ss:Width="102"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="84.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="80.25"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="79.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:Width="135"/>'+Enter
cCabec+='   <Column ss:StyleID="s64" ss:AutoFitWidth="0" ss:Width="88.5"/>'+Enter
cCabec+='   <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="83.25"/>'+Enter
cCabec+='   <Row ss:AutoFitHeight="0" ss:StyleID="s67">'+Enter
cCabec+='    <Cell ss:Index="2" ss:StyleID="s63"/>     '+Enter

cCabec+='    <Cell ss:StyleID="s69"/>'+Enter
cCabec+='    <Cell ss:StyleID="s69"/>'+Enter
cCabec+='    <Cell ss:StyleID="s70"/>'+Enter
cCabec+='    <Cell ss:StyleID="s70"/>'+Enter
cCabec+='    <Cell ss:StyleID="s70"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter

For nInd:=1 To Len(aCodTabs)
	cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
Next

cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='   </Row>'+Enter                   

cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">'+Enter
cCabec+='    <Cell ss:Index="2" ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s73"><Data ss:Type="String">DATA DE EMISSÃƒO: </Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s74"><Data ss:Type="DateTime">'+RL204Trans(MsDate())+'</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s75"/>'+Enter
cCabec+='    <Cell ss:StyleID="s76"><Data ss:Type="String">PREÃ‡OS VÃLIDOS POR 2 DIAS </Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s76"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter

For nInd:=1 To Len(aCodTabs)
	cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
Next


cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='   </Row>'+Enter                   


AADD(aCabec,'PRODUTOS SUJEITOS Ã€ DISPONIBILIDADE DE ESTOQUE')
AADD(aCabec,'OS PREÃ‡OS REFLETIDOS NESTA TABELA DE PREÃ‡OS ESTÃƒO SEM ST E IPI')
AADD(aCabec,'OS PREÃ‡OS REFLETIDOS EM NOSSO E-COMMERCE ESTÃƒO COM ST E IPI')
For nCnd:=1 To Len(aCabec)

	cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="21.75" ss:StyleID="s67">'+Enter
	cCabec+='    <Cell ss:Index="2" ss:StyleID="s63"/>'+Enter
	cCabec+='    <Cell ss:MergeAcross="3" ss:StyleID="s77"><Data ss:Type="String">'+aCabec[nCnd]+'</Data></Cell>'+Enter
	cCabec+='    <Cell ss:StyleID="s77"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s80"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s80"/>'+Enter
	
	For nInd:=1 To Len(aCodTabs)
		cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
	Next
	cCabec+='    <Cell ss:StyleID="s80"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s80"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s80"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s80"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
	cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
	cCabec+='   </Row>'+Enter
	
Next
cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="23.25" ss:StyleID="s67">'+Enter
cCabec+='    <Cell ss:Index="2" ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s81"/>'+Enter
cCabec+='    <Cell ss:StyleID="s81"/>'+Enter
cCabec+='    <Cell ss:MergeAcross="9" ss:MergeDown="1" ss:StyleID="s83"><Data'+Enter
cCabec+='      ss:Type="String">         Tabela de PreÃ§os - Games &amp; AcessÃ³rios</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s84"/>'+Enter
cCabec+='    <Cell ss:StyleID="s84"/>'+Enter
cCabec+='    <Cell ss:StyleID="s85"/>'+Enter

For nInd:=1 To Len(aCodTabs)-2
	cCabec+='    <Cell ss:StyleID="s86"/>'+Enter
Next
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='   </Row>'+Enter



cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="51" ss:StyleID="s67">'+Enter
cCabec+='    <Cell ss:Index="2" ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s81"><Data ss:Type="String"></Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s81"/>'+Enter
cCabec+='    <Cell ss:Index="15" ss:StyleID="s84"/>'+Enter

For nInd:=1 To Len(aCodTabs)-4
	cCabec+='    <Cell ss:StyleID="s85"/>'+Enter
Next

cCabec+='    <Cell ss:MergeAcross="2" ss:StyleID="m59451624"><Data ss:Type="String">TOTAL PEDIDO</Data></Cell>'+Enter
cCabec+='	 <Cell ss:StyleID="s94" ss:Formula="=ALTERAR_TOTAL"><Data ss:Type="Number">1222</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='   </Row>'+Enter


cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="25.5" ss:StyleID="s67">'+Enter
cCabec+='    <Cell ss:Index="2" ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s81"/>'+Enter
cCabec+='    <Cell ss:StyleID="s81"/>'+Enter
cCabec+='    <Cell ss:StyleID="s86"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter


For nInd:=1 To Len(aCodTabs)
	cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
Next
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s72"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='    <Cell ss:StyleID="s63"/>'+Enter
cCabec+='   </Row>'+Enter



cCabec+='   <Row ss:AutoFitHeight="0" ss:Height="42" ss:StyleID="s95">'+Enter
cCabec+='    <Cell ss:Index="2" ss:StyleID="s97"/>'+Enter
cCabec+='    <Cell ss:StyleID="s98"><Data ss:Type="String">CAMPANHA</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">CÃ“DIGO NC </Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">CÃ“D. DE BARRAS </Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">DESCRIÃ‡ÃƒO </Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">PUBLISH</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">PLAT</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">GÃŠNERO</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">TECN</Data></Cell>'+Enter  
cCabec+='    <Cell ss:StyleID="s100"><Data ss:Type="String">PreÃ§o</Data></Cell>'+Enter    

For nInd:=1 To Len(aCodTabs)
	cNomeCell:= AllTrim( Str( Val(aCodTabs[nInd] ) ) )
	cDescrDA0:= Posicione("DA0",1,xFilial("DA0")+cNomeCell,"DA0_DESCRI")
	cCabec+='    <Cell ss:StyleID="s101"><Data ss:Type="String">'+cDescrDA0+'</Data></Cell>'+Enter
//	cCabec+='    <Cell ss:StyleID="s101"><Data ss:Type="String">PreÃ§o'+cNomeCell+'%</Data></Cell>'+Enter
	AADD(aDadosPrecos,{aCodTabs[nInd],0} )	
Next

cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">PreÃ§o Consumidor</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s99"><Data ss:Type="String">IPI</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s101"><Data ss:Type="String">Estoque DisponÃ­vel</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s102"><Data ss:Type="String">Quant Pedido</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s103"><Data ss:Type="String">Pedido (R$)</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s104"/>'+Enter
cCabec+='   </Row>'+Enter          

RL204Write(cCabec)

Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGRL204  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL204RodaPe()
Local cRodaPe:=""            
Local nInd

cRodaPe+='   <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s122">'+Enter
cRodaPe+='    <Cell ss:Index="2" ss:StyleID="s124"/>'+Enter
cRodaPe+='    <Cell ss:StyleID="s125"><Data ss:Type="String">SubTotal</Data></Cell>'+Enter

For nInd:=1 To Len(aCodTabs)+11
	cRodaPe+='    <Cell ss:StyleID="s126"/>'+Enter
Next

cRodaPe+='    <Cell ss:StyleID="s128" ss:Formula="=SUBTOTAL(109,R[-'+AllTrim(Str(nTotLinhas))+']C:R[-1]C)"><Data'+Enter
cRodaPe+='      ss:Type="Number">0</Data></Cell>'+Enter
cRodaPe+='    <Cell ss:StyleID="s124"/>'+Enter
cRodaPe+='   </Row>'+Enter

cRodaPe+='  <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s105">'+Enter
cRodaPe+='    <Cell ss:Index="2" ss:StyleID="s129"/>'+Enter
For nInd:=1 To Len(aCodTabs)+11
	cRodaPe+='    <Cell ss:StyleID="s130"/>'+Enter
Next
cRodaPe+='   <Cell ss:Index="25" ss:StyleID="s121"/>'

cRodaPe+='   </Row>'+Enter

cRodaPe+='   <Row ss:AutoFitHeight="0" ss:Height="33.75" ss:StyleID="s105">'+Enter
cRodaPe+='    <Cell ss:Index="2" ss:StyleID="s129"/>'+Enter
cRodaPe+='    <Cell ss:StyleID="s132"><Data ss:Type="String">Tel: (11) 4095-3100</Data></Cell>'+Enter

For nInd:=1 To Len(aCodTabs)+09
	cRodaPe+='    <Cell ss:StyleID="s132"/>'+Enter
Next

cRodaPe+='    <Cell ss:StyleID="s132" ss:HRef="http://www.ncgames.com.br/"><Data'+Enter
cRodaPe+='      ss:Type="String">www.ncgames.com.br</Data></Cell>'+Enter
cRodaPe+='    <Cell ss:StyleID="s132"/>'+Enter
cRodaPe+='    <Cell ss:StyleID="s132"/>'+Enter
cRodaPe+='	  <Cell ss:StyleID="s121"/>'+Enter
cRodaPe+='   </Row>'+Enter

cRodaPe+='   <Row ss:AutoFitHeight="0" ss:Height="21.9375" ss:StyleID="s105">'+Enter
cRodaPe+='    <Cell ss:Index="2" ss:StyleID="s129"/>'+Enter
For nInd:=1 To Len(aCodTabs)+13
	cRodaPe+='    <Cell ss:StyleID="s132"/>'+Enter
Next
cRodaPe+='	  <Cell ss:StyleID="s121"/>'+Enter
cRodaPe+='   </Row>'+Enter

For nInd:=1 To 2000
	cRodaPe+='   <Row ss:AutoFitHeight="0">'+Enter
	cRodaPe+='    <Cell ss:Index="25" ss:StyleID="s121"/>'+Enter
	cRodaPe+='   </Row>'+Enter
Next

cRodape+='</Table>'+Enter
cRodape+='<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cRodape+='<PageSetup>'+Enter
cRodape+='<Header x:Margin="0.31496062992125984"/>'+Enter
cRodape+='<Footer x:Margin="0.31496062992125984"/>'+Enter
cRodape+='<PageMargins x:Bottom="0.74803149606299213" x:Left="0.23622047244094491"'+Enter
cRodape+='x:Right="0.23622047244094491" x:Top="0.74803149606299213"/>'+Enter
cRodape+='</PageSetup>'+Enter
cRodape+='<Unsynced/>'+Enter
cRodape+='<Print>'+Enter
cRodape+='<ValidPrinterInfo/>'+Enter
cRodape+='<PaperSizeIndex>9</PaperSizeIndex>'+Enter
cRodape+='<Scale>20</Scale>'+Enter
cRodape+='<HorizontalResolution>600</HorizontalResolution>'+Enter
cRodape+='<VerticalResolution>600</VerticalResolution>'+Enter
cRodape+='</Print>'+Enter
cRodape+='<Zoom>60</Zoom>'+Enter
cRodape+='<Selected/>'+Enter
cRodape+='<DoNotDisplayGridlines/>'+Enter
cRodape+='<LeftColumnVisible>11</LeftColumnVisible>'+Enter
cRodape+='<Panes>'+Enter
cRodape+='<Pane>'+Enter
cRodape+='<Number>3</Number>'+Enter
cRodape+='<ActiveRow>7</ActiveRow>'+Enter
cRodape+='<ActiveCol>19</ActiveCol>'+Enter
cRodape+='</Pane>'+Enter
cRodape+='</Panes>'+Enter
cRodape+='<ProtectObjects>False</ProtectObjects>'+Enter
cRodape+='<ProtectScenarios>False</ProtectScenarios>'+Enter
cRodape+='<EnableSelection>UnlockedCells</EnableSelection>'+Enter
cRodape+='<AllowSort/>'+Enter
cRodape+='<AllowFilter/>'+Enter
cRodape+='<AllowUsePivotTables/>'+Enter
cRodape+='</WorksheetOptions>'+Enter
cRodape+='</Worksheet>'+Enter
cRodape+='<Worksheet ss:Name="Plan1">'+Enter
cRodape+='<Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"'+Enter
cRodape+='x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
cRodape+='<Row ss:AutoFitHeight="0"/>'+Enter
cRodape+='</Table>'+Enter
cRodape+='<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cRodape+='<PageSetup>'+Enter
cRodape+='<Header x:Margin="0.31496062000000002"/>'+Enter
cRodape+='<Footer x:Margin="0.31496062000000002"/>'+Enter
cRodape+='<PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
cRodape+='x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
cRodape+='</PageSetup>'+Enter
cRodape+='<Unsynced/>'+Enter
cRodape+='<Visible>SheetHidden</Visible>'+Enter
cRodape+='<Panes>'+Enter
cRodape+='<Pane>'+Enter
cRodape+='<Number>3</Number>'+Enter
cRodape+='<RangeSelection>R1C1:R8113C2</RangeSelection>'+Enter
cRodape+='</Pane>'+Enter
cRodape+='</Panes>'+Enter
cRodape+='<ProtectObjects>False</ProtectObjects>'+Enter
cRodape+='<ProtectScenarios>False</ProtectScenarios>'+Enter
cRodape+='</WorksheetOptions>'+Enter
cRodape+='</Worksheet>'+Enter
cRodape+='<Worksheet ss:Name="Plan2">'+Enter
cRodape+='<Table ss:ExpandedColumnCount="1" ss:ExpandedRowCount="1" x:FullColumns="1"'+Enter
cRodape+='x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
cRodape+='<Row ss:AutoFitHeight="0"/>'+Enter
cRodape+='</Table>'+Enter
cRodape+='<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cRodape+='<PageSetup>'+Enter
cRodape+='<Header x:Margin="0.31496062000000002"/>'+Enter
cRodape+='<Footer x:Margin="0.31496062000000002"/>'+Enter
cRodape+='<PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
cRodape+='x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
cRodape+='</PageSetup>'+Enter
cRodape+='<Unsynced/>'+Enter
cRodape+='<Visible>SheetHidden</Visible>'+Enter
cRodape+='<ProtectObjects>False</ProtectObjects>'+Enter
cRodape+='<ProtectScenarios>False</ProtectScenarios>'+Enter
cRodape+='</WorksheetOptions>'+Enter
cRodape+='</Worksheet>'+Enter
cRodape+='</Workbook>'+Enter


RL204Write(cRodaPe)

Return cRodaPe
