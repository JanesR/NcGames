#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"
//
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  02/05/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCVTEX06()
Local aAreaAtu	   :=GetArea()
Local cPerg  		:= 'NCVTEX06'
Local cTmpAlias 	:= GetNextAlias()
Local oReport
Local cNomeTmp

PutSX1(cPerg, "01", "Do E-commerce", "", "", "mv_ch1", "N", 1, 0, 3, "C", "", "", "", "", "mv_par01", "ProximoGames", "", "", "", "UzGames", "","", "","", "", "","","","","","",,,, )
Pergunte(cPerg, .F.)

oReport := ReportDef(cTmpAlias, cPerg,@cNomeTmp)
oReport:SetLandscape()
oReport:PrintDialog()


If Select(cTmpAlias)>0
	(cTmpAlias)->(E_EraseArq(cNomeTmp))
EndIf
RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/11/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(cTmpAlias, cPerg,cNomeTmp)
Local cTitle  := "Relatório Produtos do E-commerce X  Produtos ERP-Protheus"
Local cHelp   :="Lista todos os produtos ativos no e-commerce versus cadastrados no ERP-Protheus( A pesquisa é feita pelo codigo de barras do produto)"
Local oReport
Local oSection1
Local aOrdem    := {}

oReport := TReport():New('NCVTEX06',cTitle,cPerg,{|oReport| ReportPrint(oReport,@cTmpAlias,aOrdem)},cHelp)

oSection1 := TRSection():New(oReport,"Produtos",{cTmpAlias},aOrdem)

TRCell():New(oSection1,"B1_COD"    ,"","Codigo ERP"		,,15,,{|| (cTmpAlias)->ID_ERP})
TRCell():New(oSection1,"B1_DESC"   ,"","Desc. NcGames"	,,,,{|| Posicione("SB1",1,xFilial("SB1")+(cTmpAlias)->ID_ERP,"B1_XDESC")  })
TRCell():New(oSection1,"B1_DESC"   ,"","Cod Bar"			,,,,{|| Posicione("SB1",1,xFilial("SB1")+(cTmpAlias)->ID_ERP,"B1_CODBAR")  })
TRCell():New(oSection1,"B1_COD"    ,"","Codigo Site"		,,15,,{|| (cTmpAlias)->ID_SITE})
TRCell():New(oSection1,"B1_DESC"   ,"","Descricao Site"	,,,,{|| (cTmpAlias)->DESC_SITE})
TRCell():New(oSection1,"B1_CODBAR" ,"","EAN"					,,,,{|| (cTmpAlias)->EAN	})
TRCell():New(oSection1,"B1_CODBAR" ,"","EAN 2"				,,,,{|| (cTmpAlias)->EAN2	})
TRCell():New(oSection1,"B1_PESO" 	,"","Peso"				,"@E 999,999.99",,,{|| (cTmpAlias)->PESO_SITE	})
TRCell():New(oSection1,"B1_ALT"    ,"","Altura"				,"@E 999,999.99",,,{|| (cTmpAlias)->ALT_SITE	})
TRCell():New(oSection1,"B1_LARGURA" ,"","Largura"			,"@E 999,999.99",,,{|| (cTmpAlias)->LAR_SITE	})
TRCell():New(oSection1,"B1_PROF"   ,"","Compr."				,"@E 999,999.99",,,{|| (cTmpAlias)->COM_SITE	})
TRCell():New(oSection1,"DT_ULTA"   ,"","Ult Altera"		,,15,,{|| (cTmpAlias)->DT_ULTA		})
TRCell():New(oSection1,"B2_QATU"  ,"","Estoque Site"		,,,,{|| (cTmpAlias)->ESTOQ_SITE		})
TRCell():New(oSection1,"ZC4_PRCCIA" ,"","Preco Site De"			,,,,{|| (cTmpAlias)->PRECODE		})
TRCell():New(oSection1,"ZC4_PRCCIA" ,"","Preco Site Por"			,,,,{|| (cTmpAlias)->PRECOPOR		})


TRCell():New(oSection1,"B2_QATU" ,"","Estoque 01"			,,30,,{|| (cTmpAlias)->ESTOQUE_01		})
TRCell():New(oSection1,"B2_QATU" ,"","Estoque 51"			,,30,,{|| (cTmpAlias)->ESTOQUE_51		})





Return(oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/11/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,cTmpAlias,aOrdem)
Local oSecao1 		:= oReport:Section(1)
Local cSistema		:=Iif(mv_par01==1,"ProximoGames","UzGames")
Local cNomeTmp

oReport:SetTitle(oReport:Title()+' (' + cSistema+ ')')

Processa( {||  GravaTmp(cSistema,cTmpAlias,@cNomeTmp) } )

(cTmpAlias)->(DbGoTop())
Do While (cTmpAlias)->(!Eof())
	oReport:IncMeter()
	oSecao1:Init()
	oSecao1:PrintLine()
	(cTmpAlias)->(DbSkip())
EndDo
//oReport:EndPage()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  02/22/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaTmp(cSistema,cTmpAlias,cNomeTmp)
Local cPathReport	:="\XML_Vtex\Report"
Local aReport		:={cPathReport+"\NcGames-Produtos-ProximoGames-0-OK.txt",cPathReport+"\NcGames-Produtos-uzgames-0-OK.txt"}
Local cPathRoot	:=AllTrim(GetSrvProfString( "RootPath" , "" ) )
Local cFilSB1		:=xFilial("SB1")
Local nLenEAN		:=AvSx3("B1_CODBAR",3)
Local aStruct 		:={ }
Local aPostUrl		:={}
Local nOpcao
Local cUser
Local cPassword
Local nWebService
Local cSoap
Local oWSVtex
Local aCodBar
Local aEans
Local nMaior:=0
Local nAux:=0
Local nLinha:=0
Local oSite
Local cLoja
Local aCabec:={{"QUANTITY","N"},{"SALESCHANNEL","C"}}
Local aIds:={}
Local cCodCli:="000000"
Local cTotal

If "PROXIMO"$Upper(cSistema)
	nOpcao:=1
	nWebService:=2
	cLoja:="02"
Else
	nOpcao:=2
	nWebService:=3
	cLoja:="03"
EndIf
oSite:=ApiVtex():New(cSistema)

AADD(aStruct, {"ID_ERP"			,"C",15,0} )
AADD(aStruct, {"ID_SITE"		,"C",15,0} )
AADD(aStruct, {"ATIVO_SITE"	,"C",03,0} )
AADD(aStruct, {"DESC_SITE"	,"C",50,0} )
AADD(aStruct, {"ESTOQ_SITE"	,"N",08,3} )
AADD(aStruct, {"PRECODE"	,"N",15,4} )
AADD(aStruct, {"PRECOPOR"	,"N",15,4} )
AADD(aStruct, {"PESO_SITE"	,"N",15,3} )
AADD(aStruct, {"ALT_SITE"	,"N",15,3} )
AADD(aStruct, {"LAR_SITE"	,"N",15,3} )
AADD(aStruct, {"COM_SITE"	,"N",15,3} )
AADD(aStruct, {"DT_ULTA"	,"D",08,0} )


AADD(aStruct, {"ESTOQUE_01"	,"N",15,3} )
AADD(aStruct, {"ESTOQUE_51"	,"N",15,3} )

AADD(aStruct, {"EAN"  ,"C",15,0} )
AADD(aStruct, {"EAN2" ,"C",15,0} )

cNomeTmp 	:= CriaTrab(aStruct,.T.)
dbUseArea( .T.,, cNomeTmp,cTmpAlias, .T. , .F. )
IndRegua(cTmpAlias,cNomeTmp,"ID_SITE")

/*
ProcRegua(2)
IncProc("Buscando Produtos do e-commerce "+cSistema)
Ferase(aReport[nOpcao])
WaitRunSrv("D:\SmartBear\SoapUI-5.0.0\bin\testrunner.bat -sNcGames -cProdutos -a -f"+cPathRoot+cPathReport+" -I -S "+cPathRoot+"\XML_Vtex\"+cSistema+".xml",.T.,'D:\SmartBear\SoapUI-5.0.0\bin\')


If !File(aReport[nOpcao])
MsgStop("Nao foi possivel gerar arquivo de produtos do e-commerce "+cSistema)
Return
EndIf
*/
U_VTEX01Param(@cUser,@cPassword,nWebService,aPostUrl)

oWSVtex:=WSVtex():New
oWSVtex:cUrlWS:=aPostUrl[1,2]

FT_FUSE(aReport[nOpcao]) //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua((nTotLinhas:=FT_FLASTREC() )) //QTOS REGISTROS LER

cLinhaTotal:=StrZero(nTotLinhas,8)
SA7->(DbSetOrder(3))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_CODCLI
SB1->(DbSetOrder(5))//B1_FILIAL+B1_CODBAR

Do While !FT_FEOF() //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	
	cMensagem:="Processando Linha:"+StrZero(++nLinha,8)+"/"+cLinhaTotal
	PtInternal(1,"Processando ID:"+cMensagem)
	IncProc(cMensagem )
	
	cBuffer := AllTrim(FT_FREADLN()) //LENDO LINHA
	
	If AT('<a:Id>',cBuffer)==0 .And. AT('<a:IsActive>',cBuffer)==0
		FT_FSKIP();Loop
	EndIf
	
	lIsID:=AT('<a:Id>',cBuffer)>0
	
	cBuffer:=StrTran(cBuffer,'<a:Id>','')
	cBuffer:=StrTran(cBuffer,'</a:Id>','')
	
	cBuffer:=StrTran(cBuffer,'<a:IsActive>','')
	cBuffer:=StrTran(cBuffer,'</a:IsActive>','')
	
	cBuffer:=AllTrim(cBuffer)
	
	If Empty(cBuffer)
		FT_FSKIP();Loop
	EndIf
	
	If lIsID
		cID:=cBuffer
	ElseIf Upper(AllTrim(cBuffer))=="TRUE"
		AADD(aIds,{cID,Upper(cBuffer)})		
	EndIf                             
	FT_FSKIP() //próximo registro no arquivo txt
	
EndDo
aSort(aIds,,,{|x,y| x[1]<y[1]})
FT_FUSE(aReport[nOpcao]) //Fechar
ProcRegua(Len(aIds))
IncProc("" )
cTotal:="- "+StrZero(Len(aIds),4)+" Produto(s) Ativo(s)."
For nYnd:=1 To Len(aIds)
	
	cMensagem:="Processando ID:"+aIds[nYnd,1]+cTotal
	PtInternal(1,cMensagem)
	IncProc(cMensagem )
	
	If aIds[nYnd,2]<>"TRUE"
		Loop
	EndIf
	
	cBuffer:=aIds[nYnd,1]
	
	HttpSetPass(cUser,cPassword)
	oWSVtex:nIdProduct:=Val(aIds[nYnd,1])
	oWSVtex:StockKeepingUnitGetAllByProduct()//oWSVtex:oWSStockKeepingUnitGetResult:OWSSTOCKKEEPINGUNITEANS
	
	For nXnd:=1 To Len(oWSVtex:oWSStockKeepingUnitGetAllByProductResult:OWSSTOCKKEEPINGUNITDTO)
		
		oSku:=oWSVtex:oWSStockKeepingUnitGetAllByProductResult:OWSSTOCKKEEPINGUNITDTO[nXnd]
		
		If !oSku:lIsactive
			Loop
		EndIf
		
		aEans:=oSku:OWSSTOCKKEEPINGUNITEANS:OWSSTOCKKEEPINGUNITEANDTO
		
		If ValType(aEans)<>"A"
			Loop
		EndIf
		
		cSB1COD:=""
		If SA7->(MsSeek(xFilial("SA7")+cCodCli+cLoja+AllTrim(Str(oSku:nId))))
			cSB1COD:=SA7->A7_PRODUTO
		EndIf
		
		
		aCodBar:={}
		For nInd:=1 To Len(aEans)
			If Len(AllTrim(aEans[nInd]:cEAN))<=10
				Loop
			Endif
			AADD(aCodBar,aEans[nInd]:cEAN)
			If !Empty(cSB1COD).And.SB1->(MsSeek(cFilSB1+Padr( aEans[nInd]:cEAN,nLenEAN )))
				cSB1COD:=SB1->B1_COD
			EndIf
		Next
		
		(cTmpAlias)->(DbAppend())
		(cTmpAlias)->ID_ERP		:=cSB1COD
		(cTmpAlias)->ID_SITE		:=AllTrim(Str(oSku:nId))
		(cTmpAlias)->DESC_SITE	:=oSku:CNAME
		(cTmpAlias)->PESO_SITE	:=oSku:NWEIGHTKG
		(cTmpAlias)->ALT_SITE	:=oSku:NHEIGHT
		(cTmpAlias)->LAR_SITE	:=oSku:NWIDTH
		(cTmpAlias)->COM_SITE	:=oSku:NLENGTH
		(cTmpAlias)->DT_ULTA		:=Stod(Left( StrTran( oSku:CDATEUPDATED,"-",""),8))

		
		If !Empty((cTmpAlias)->ID_ERP)
			If SB2->(MsSeek(xFilial("SB2")+(cTmpAlias)->ID_ERP+"01" ))
				(cTmpAlias)->ESTOQUE_01:=SB2->(B2_QATU-B2_RESERVA)
			EndIf
			
			If SB2->(MsSeek(xFilial("SB2")+(cTmpAlias)->ID_ERP+"51" ))
				(cTmpAlias)->ESTOQUE_51:=SB2->(B2_QATU-B2_RESERVA)
			EndIf
		EndIf
		
		
		aCabec:={{"QUANTITY","N"},{"SALESCHANNEL","C"}}
		oSite:cBody:='[{"id":"'+AllTrim((cTmpAlias)->ID_SITE)	+'"}] '
		oSite:GetEstoque()
		(cTmpAlias)->ESTOQ_SITE:=U_VTEX05GetDet(aCabec,oSite:cResponse)[1]
		
		oSite:cIdSKU:=AllTrim((cTmpAlias)->ID_SITE)
		oSite:GetPreco()
		aCabec:={{"PRICE","N"},{"LISTPRICE","N"}}		
		(cTmpAlias)->PRECODE		:=U_VTEX05GetDet(aCabec,oSite:cResponse)[2]
		(cTmpAlias)->PRECOPOR	:=U_VTEX05GetDet(aCabec,oSite:cResponse)[1]

		
		
		For nInd:=1 To Len(aCodBar)
			If nInd==1
				(cTmpAlias)->EAN:=aCodBar[nInd]
			ElseIf nInd==2
				(cTmpAlias)->EAN2:=aCodBar[nInd]
			EndIf
		Next
	Next
Next


oWSVtex:=Nil
oSite:=Nil
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xLeWM()
Local aPostUrl		:={}
Local nOpcao
Local cUser
Local cPassword
Local oWSVtex


RpcSetEnv("01","03")
SB1->(DbSetOrder(5))//B1_FILIAL+B1_CODBAR

DbUseArea(.T.,"DBFCDXADS","\_Lucas\produtoswms_ces.dbf","Work",.F.,.F.)
//dbUseArea(.T.,"DBFCDX","SXE.DBF","SXE",.T.,.F.)

U_VTEX01Param(@cUser,@cPassword,aPostUrl)

Work->(DbGoTop())

Do While Work->(!Eof())
	
	
	PtInternal(1,"01-"+StrZero(Work->CODWM,5))
	
	For nYnd:=1 To 4
		
		bValor:=&("{|| Work->Cod_Bar"+AllTrim(Str(nYnd))+"}")
		
		If Empty(cCodBar:=Eval(bValor) )
			Loop
		EndIf
		
		cCodBar:=AllTrim(cCodBar)
		
		If Empty(Work->CODPROTHEU) .And. SB1->(DbSeek(xFilial("SB1")+cCodBar ))
			Work->CODPROTHEU	:=SB1->B1_COD
			Work->DESC_NC		:=SB1->B1_XDESC
			Work->EAN_NC		:=SB1->B1_CODBAR
			Work->ATIVO			:=Iif(SB1->B1_MSBLQL=="1","Nao","Sim")
			Work->BLOQ_VEND	:=Iif(SB1->B1_BLQVEND=="1","Sim","Nao")
		EndIf
		
		For nInd:=1 To 2
			
			If nInd==1 .And. !Empty(Work->CODPROXIMO)
				Loop
			EndIf
			
			If nInd==2 .And. !Empty(Work->CODUZGAMES)
				Loop
			EndIf
			
			
			oWSVtex:=Nil
			oWSVtex:=WSVtex():New
			oWSVtex:cUrlWS:=aPostUrl[nInd,2]
			HttpSetPass(cUser,cPassword)
			oWSVtex:StockKeepingUnitGetByEan(cCodBar)
			oWSVtex:oWSStockKeepingUnitGetByEanResult
			nResult:=oWSVtex:oWSStockKeepingUnitGetByEanResult:NID
			
			If ValType(nResult)<>"N"
				Loop
			EndIf
			cCodProduto:=AllTrim(Str(nResult))
			
			If !Empty(cCodProduto)
				If nInd==1
					Work->CODPROXIMO:=cCodProduto
				EndIf
				
				If nInd==2
					Work->CODUZGAMES:=cCodProduto
				EndIf
				
				
			EndIf
			
			
		Next
		
		If !Empty(Work->CODPROTHEU) .And. !Empty(Work->CODPROXIMO) .And. !Empty(Work->CODUZGAMES)
			Exit
		EndIf
	Next
	Work->(DbSkip())
	
EndDo

u_xLeWM2()
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/17/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xLeWM2()
Local aPostUrl		:={}
Local nOpcao
Local cUser
Local cPassword



RpcSetEnv("01","03")
SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD

DbUseArea(.T.,"DBFCDXADS","\_Lucas\produtoswms_ces.dbf","Work",.F.,.F.)

Work->(DbGoTop())

Do While Work->(!Eof())
	
	
	PtInternal(1,"02-"+StrZero(Work->CODWM,5))
	
	If Empty(Work->CODPROTHEU) .Or. !SB1->(DbSeek(xFilial("SB1")+AllTrim(Work->CODPROTHEU) ))
		Work->(DbSkip());Loop
	EndIf
	
	U_NCGRAVASA7("000000","01",AllTrim(Str(Work->CODWM)),SB1->B1_DESC,SB1->B1_COD)
	
	If !Empty(Work->CODPROXIMO)
		U_NCGRAVASA7("000000","02",Work->CODPROXIMO,SB1->B1_DESC,SB1->B1_COD)
	EndIf
	
	If !Empty(Work->CODUZGAMES)
		U_NCGRAVASA7("000000","03",Work->CODUZGAMES,SB1->B1_DESC,SB1->B1_COD)
	EndIf
	
	Work->(DbSkip())
	
EndDo


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/17/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xLeWM3()
Local nColuna
Local cArm	:= "51"

RpcSetEnv("01","03")

DbUseArea(.T.,"DBFCDXADS","\_Lucas\criasb251.dbf","Work",.F.,.F.)

Work->(DbGoTop())

nLenSB2:=Len(SB2->B2_COD)
SB2->(dbSetOrder(1))
Do While Work->(!Eof())
	cCodProd:=Padr(Work->B2COD,nLenSB2)
	
	PtInternal(1,cCodProd)
	
	If !SB2->(DbSeek(xFilial("SB2")+cCodProd+cArm))
		CriaSB2(cCodProd,cArm)
	EndIf
	SB2->(RecLock("SB2",.F.))
	SB2->B2_QATU 	:=Work->B2QTD
	SB2->B2_LOCAL 	:=cArm
	SB2->B2_RESERVA:=0
	
	SB2->(MsUnlock())
	Work->(DbSkip())
EndDo


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/23/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xLeWM4()
Local cQryAlias:=GetNextAlias()

RpcSetEnv("01","03")
cFilSB1:=xFilial("SB1")

DbUseArea(.T.,"DBFCDXADS","\_Lucas\produtoswms_ces.dbf","Work",.F.,.F.)

Work->(DbGoTop())
Do While Work->(!Eof())
	
	
	If !Empty(Work->CODPROTHEU)
		Work->(DbSkip());Loop
	EndIf
	
	PtInternal(1,"04-"+StrZero(Work->CODWM,5))
	
	For nYnd:=1 To 4
		
		bValor:=&("{|| Work->Cod_Bar"+AllTrim(Str(nYnd))+"}")
		
		If Empty(cCodBar:=Eval(bValor) )
			Loop
		EndIf
		
		cCodBar:=AllTrim(cCodBar)
		cQuery:=" Select SB1.R_E_C_N_O_ RecSB1,B1_COD From "+RetSqlName("SB1")+" SB1 "
		cQuery+=" Where SB1.B1_FILIAL='"+cFilSB1+"'"
		cQuery+=" And SB1.B1_COD Between '         ' And '999999999999'
		cQuery+=" And SB1.B1_CODBAR Like '%"+cCodBar+"%'
		cQuery+=" Order By B1_COD"
		
		If Select(cQryAlias)>0
			(cQryAlias)->(DbCloseArea())
		EndIf
		
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias  ,.F.,.T.)
		If (cQryAlias)->RecSB1>0
			SB1->(DbGoTo((cQryAlias)->RecSB1))
			Work->CODPROTHEU	:=SB1->B1_COD
			Work->DESC_NC		:=SB1->B1_XDESC
			Work->EAN_2       :=SB1->B1_CODBAR
			Work->ATIVO			:=Iif(SB1->B1_MSBLQL=="1","Nao","Sim")
			Work->BLOQ_VEND	:=Iif(SB1->B1_BLQVEND=="1","Sim","Nao")
			Exit
		EndIf
		
	Next
	Work->(DbSkip())
EndDo


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCVTEX06  ºAutor  ³Microsiga           º Data ³  04/30/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xLeWM5()

RpcSetEnv("01","03")

DbUseArea(.T.,"DBFCDXADS","\_Lucas\Produtos.dbf","Work",.F.,.F.)

Work->(DbGoTop())
ChkFile("SB1")
ChkFile("SB2")
Do While Work->(!Eof())
	
	/*
	PtInternal(1,"01-"+Work->CODPROTHEU)
	
	
	If Empty(Work->CODPROTHEU) .Or. !SB1->(DbSeek(xFilial("SB1")+AllTrim(Work->CODPROTHEU) ))
	Work->(DbSkip());Loop
	EndIf
	
	If !Empty(Work->CODPROXIMO)
	U_NCGRAVASA7("000000","02",AllTrim(Work->CODPROXIMO),SB1->B1_DESC,SB1->B1_COD)
	EndIf
	
	If !Empty(Work->CODUZGAMES)
	U_NCGRAVASA7("000000","03",AllTrim(Work->CODUZGAMES),SB1->B1_DESC,SB1->B1_COD)
	EndIf
	*/
	
	cProduto:=AllTrim(Work->Protheus)
	
	If !SB1->(MsSeek(xFilial("SB1")+cProduto )) 	.And. !SB1->(MsSeek(xFilial("SB1")+"0"+cProduto ))
		Work->OBS:="Nao encontrado."
		Work->(DbSkip());Loop
	EndIf
	
	If SB2->(MsSeek(xFilial("SB2")+SB1->B1_COD+"01" ))
		WORK->ESTOQUE01:=SB2->(B2_QATU)
		WORK->SALDO01:=SB2->(B2_QATU-B2_RESERVA)
	EndIf
	
	If SB2->(MsSeek(xFilial("SB2")+SB1->B1_COD+"51" ))
		WORK->ESTOQUE51:=SB2->(B2_QATU)
		WORK->SALDO51:=SB2->(B2_QATU-B2_RESERVA)
	EndIf
	
	Work->(DbSkip())
	
	
EndDo


Return
