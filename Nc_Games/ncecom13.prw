#Include 'Protheus.ch'
#Include "rwmake.ch"
#Include "topconn.ch"

#Define CRLF Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  10/29/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Ec13JobFrt(aDados)
Default aDados := {"01","03"}

RpcSetEnv(aDados[1],aDados[2])


U_Ecom13Frt()


RpcClearEnv()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                                   NcGames 			  		                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºPrograma    ³NCECOM13 | Atualização Rastreamento Correios                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºProjeto/ID  ³                                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSolicitante ³18.11.13³                                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor       ³18.11.13³ Cleverson                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParâmetros  ³Nil                                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno     ³Nil.                                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºObservações ³                                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAlterações  ³ 99.99.99 - Consultor - Descrição da Alteração								º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function NCECOM13()
Local oBrowse
Private aRotina :=Menudef()
Private cCadastro:='Rastreamento E-Commerce'

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('ZC1')
oBrowse:SetDescription(cCadastro)
oBrowse:Activate()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  03/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±vcv±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function MenuDef()
Local aRotina := { }


AADD(aRotina, {"Pesquisar"	  			,"AxPesqui"		,0,1} )
AADD(aRotina, {"Visualizar"	     		,"AxVisual"		,0,2})
AADD(aRotina, {"Imp Dados PostalNet"    ,"U_COM13IMP"  ,0,5} )
AADD(aRotina, {"Imp Dados Novo"       	,"U_COM13New"  ,0,3} )
AADD(aRotina, {"Pedidos Sem Rastreio"   ,"U_COM13PV"  ,0,3} )

Return aRotina
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  03/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM13Imp
Local aSays		:={}
Local aButtons	:={}
Local lOk
Private cArquivo:=""

AADD( aSays, "Este processo tem como objetivo Atualizar a Base de Rastreamento E-Commerce" )
AADD( aSays, "baseado em arquivo TXT." )
AADD( aButtons, { 01, .T., {|| lOk := .T.,(cArquivo:=cGetFile("Arquivo TXT | *.txt","Selecione o arquivo ",,,.T.)) ,Iif( File(cArquivo), FechaBatch(), msgStop("Arquivo Txt: "+cArquivo+" não localizado.") ) } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
;FormBatch( "Base de Rastreamento", aSays, aButtons )

If lOk
	Processa({|| OM13Txt(  ) }, "Verificando arquivo TXT" )
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  03/25/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OM13Txt(  )
Local aDados		:= {}
Local lTemErro		:= .F.
Local cLinha		:= ""
Local nHdl			:= 0
Local nCont			:= 0
Local nTotLinha	:= 0
Local aItens		:={}
Local lFirst		:=.T.
Local nLinha
Local aCabecTxt		:={ }
Local nLenRegistro	:=AvSx3("ZC1_REGIST",5)
Local nPosRegistro
Local oDlg
Local oBrw
Local bCriaVar		:= { |cField|  IIf(cField=="Linha",0,IIf(cField=="Status",Space(10),CriaVar(cField,.T.)) )     }
Local lGravar		:= .T.
Local nPosRegistro
Local nPosObs
Local nPosNf
Local aPVNF


AADD(aCabecTxt,{"DATAX"			,"ZC1_DATAX"	})
AADD(aCabecTxt,{"DESCRI"		,"ZC1_DESCRI"	})
AADD(aCabecTxt,{"DESTINATARIO"	,"ZC1_DESTIN"	})
AADD(aCabecTxt,{"CEP"			,"ZC1_CEP"		})
AADD(aCabecTxt,{"UF"			,"ZC1_UF"		})
AADD(aCabecTxt,{"PESO"			,"ZC1_PESO"		})
AADD(aCabecTxt,{"CUBICO"		,"ZC1_CUBICO"	})
AADD(aCabecTxt,{"QTDE"			,"ZC1_QUANT"	})
AADD(aCabecTxt,{"REGISTRO"		,"ZC1_REGIST"	})
AADD(aCabecTxt,{"ADICIONAIS"	,"ZC1_ADICIO"	})
AADD(aCabecTxt,{"OBS"			,"ZC1_OBS"		})
AADD(aCabecTxt,{"CONTALOTE"		,"ZC1_CONTAL"	})
AADD(aCabecTxt,{"NF"			,"ZC1_NF"		})
AADD(aCabecTxt,{"DECLARADO"		,"ZC1_DECLAR"	})
AADD(aCabecTxt,{"UNITARIO"		,"ZC1_UNITAR"	})
AADD(aCabecTxt,{"VALOR"			,"ZC1_VALOR"	})

nPosRegistro:= Ascan(aCabecTxt,{|a| a[1]=="REGISTRO"  })
nPosObs		:= Ascan(aCabecTxt,{|a| a[1]=="OBS"  })
nPosNf		:= Ascan(aCabecTxt,{|a| a[1]=="NF"  })

Private aCols		:= {}
Private aHeader		:= {}
Private aColsAux	:= {}
Private aHeaderAux	:= {}
Private aLenDados	:= {AvSx3("C5_NUM",3),AvSx3("F2_DOC",3)}
Private aRecZC5  	:= {}

If !File(cArquivo)
	MsgAlert("Arquivo texto: "+cArquivo+" não localizado")
	Return
Endif

Aadd(aHeaderAux,{" "		,"Status"	,"@BMP" ,4,0,"","","C","","V"})
Aadd(aHeaderAux,{"Linha"  	,"Linha"	,"@9999",5,0,"","","N","","V"})

ZC1->(FillGetDados (3, "ZC1",1, xFilial("ZC1"), {|| ZC1_FILIAL}, /*bSeekFor*/ , /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .T.,  aHeaderAux,  aColsAux, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, bCriaVar, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
ZC1->(DbSetOrder(2))//ZC1_FILIAL+ZC1_REGIST+ZC1_DATAX

nUsado:=Len(aHeader)
FT_FUSE(cArquivo)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
nTotLinha:=FT_FLASTREC()

ProcRegua(nTotLinha)

FT_FGOTOP()
aCols:={}
Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	
	cBuffer := FT_FREADLN()
	
	IncProc("Linha:"+StrZero(++nCont,5)+" de "+StrZero(nTotLinha,5))
	
	If lFirst
		lFirst	:=.F.
		FT_FSKIP();Loop
	EndIf
	
	If Empty(cBuffer)
		FT_FSKIP();Loop
	EndIf
	
	cBuffer:=StrTran(cBuffer,'"','')
	aDados:=Separa(cBuffer,";")
	
	If Len(aDados)<Len(aCabecTxt)
		AADD(aCols,aColsIni)
		nLinha:=Len(aCols)
		aCols[Len(aCols),nUsado+1]:=.F.
	EndIf
	
	If Empty(aDados[nPosObs]) .And. Empty(aDados[nPosNf])
		FT_FSKIP();Loop
	EndIf
	
	cRegistro:=COM13Trans( aDados[nPosRegistro] ,"ZC1_REGIST")
	
	If ZC1->( DbSeek(xFilial("ZC1")+ cRegistro )  )
		If ZC1->ZC1_ATUZC5 == "S"
			FT_FSKIP();Loop
		Else
			ZC1->(RecLock("ZC1",.F.))
			ZC1->(dbDelete())
			ZC1->(MsUnLock())
		EndIf
	EndIf
	
	AADD(aCols,aClone(aColsAux[1]))
	nLinha:=Len(aCols)
	
	aPVNF:={.F.,"PV/NF E-commerce não encontrado."}
	If !Empty( aDados[nPosObs] )
		aPVNF:=COM13GetPV_NF(nLinha,nCont, Val( aDados[nPosObs]) ,cRegistro )
	EndIf
	
	If !aPVNF[1] .And. !Empty(aDados[nPosNf] )
		aPVNF:=COM13GetPV_NF(nLinha,nCont, Val( aDados[nPosNf])  ,cRegistro )
	EndIf
	
	GdFieldPut("Linha" ,nCont,nLinha)
	
	For nInd:=1 To Len(aCabecTxt)
		uDado:=COM13Trans( aDados[nInd] ,aCabecTxt[nInd,2])
		GdFieldPut(aCabecTxt[nInd,2],uDado,nLinha)
	Next
	
	GdFieldPut("ZC1_DTIMPO"	,MsDate()	,nLinha)
	GdFieldPut("ZC1_HIMPOR"	,Time()		,nLinha)
	GdFieldPut("ZC1_USUARI"	,cUserName	,nLinha)
	GdFieldPut("ZC1_ERRO"	,!aPVNF[1]	,nLinha)
	GdFieldPut("ZC1_CLASSI" ,aPVNF[2]	,nLinha)
	GdFieldPut("ZC1_ATUZC5" ,"S"		,nLinha)
	
	aCols[nLinha,nUsado+1]:=.F.
	FT_FSKIP()
	
	
EndDo
FT_FUSE()

oDlg	:= MSDialog():New( 115,232,716,1601,cCadastro,,,.F.,,,,,,.T.,,,.T. )
oBrw  := MsNewGetDados():New(005,004,276,672,GD_UPDATE+GD_DELETE,'AllwaysTrue()','AllwaysTrue()','',,0,9999,'AllwaysTrue()','','AllwaysTrue()',oDlg,aHeader,aCols)

Activate MsDialog oDlg Centered On Init EnchoiceBar(oDlg,{|| lGravar:=.T.,oDlg:End()},{|| lGravar:=.F.,oDlg:End()},,)

If lGravar
	aCols:=oBrw:aCols
	Processa({||  COM13Grv() })
	MsgInfo("Arquivo "+cArquivo+" processado com sucesso.")
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  03/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM13Grv()
Local cFilZC1:=xFilial("ZC1")
Local nInd
Local nYnd
Local nCont
Local nColuna
Local nAscan
Local nTotLinha	:=Len(aCols)
Local cMensagem
Local nLine	:=0

ProcRegua(nTotLinha)

For nInd:=1 To nTotLinha
	
	cMensagem:="Linha:"+StrZero(++nLine,5)+" de "+StrZero(nTotLinha,5)
	IncProc(cMensagem)
	PtInternal(1,cMensagem)
	Conout(cMensagem)
	
	If GdDeleted( nInd , aHeader ,aCols)
		Loop
	EndIf
	
	Begin Transaction
	
	ZC1->(RecLock("ZC1",.T.))
	ZC1->ZC1_FILIAL:=cFilZC1
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZC1->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZC1->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	
	
	If !ZC1->ZC1_ERRO .And. (nAscan:=Ascan(aRecZC5, { |a|a[3]==GdFieldGet("Linha",nInd,,aHeader,aCols) }  )  ) >0
		ZC5->(DbGoTo(aRecZC5[nAscan,1]))
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_RASTRE	:= ZC1->ZC1_REGIST
		ZC5->ZC5_STATUS	:= '30'
		ZC5->ZC5_ATUALI	:= "S"
		
		ZC5->(MsUnLock())
		
		ZC1->ZC1_NUMPV :=  ZC5->ZC5_NUMPV
	EndIf
	
	ZC1->(MsUnLock())
	End Transaction
Next

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  03/25/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM13Trans( uDado ,cCampo)
Local aAreaAtu:=GetArea()
Local aAreaSX3:=SX3->(GetArea())
Local nDivisor:=1

SX3->(DbSetOrder(2))

If SX3->(DbSeek(cCampo))
	If SX3->X3_TIPO=="C"
		If cCampo=="ZC1_CEP"
			uDado:=StrTran(uDado,"-","")
		EndIf
		uDado:=Padr(AllTrim(uDado),SX3->X3_TAMANHO)
	ElseIf SX3->X3_TIPO=="D"
		uDado:=ctod(uDado)
	ElseIf SX3->X3_TIPO=="N"
		uDado:=StrTran(uDado,".","")
		uDado:=StrTran(uDado,",","")
		If cCampo$"ZC1_DECLAR*ZC1_UNITAR*ZC1_VALOR "
			nDivisor:=100
		EndIf
		uDado:=Val(uDado)/nDivisor
	EndIf
EndIf

RestArea(aAreaSX3)
RestArea(aAreaAtu)
Return uDado


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  03/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM13GetPV_NF(nLinaCols,nLinTxt,nDado,cRegistro)
Local aAreaAtu:=GetArea()
Local aAreaZC5:=SC5->(GetArea())
Local cStatus:="BR_VERMELHO"
Local cDocumento
Local aReturn		:={.F.,"PV/NF não encontrado."}


If nDado>0
	ZC5->(DbSetOrder(2))//ZC5_FILIAL+ZC5_NUMPV
	cDocumento:=StrZero(nDado,aLenDados[1])
	If ZC5->(DbSeek(xFilial("ZC5")+cDocumento ))
		AADD(aRecZC5,{ZC5->(Recno()),cRegistro,nLinTxt }  )
		aReturn:={.T.,"Pedido Venda encontrado."}
		cStatus:="BR_VERDE"
	Else
		ZC5->(DbSetOrder(4))//ZC5_FILIAL+ZC5_NOTA+ZC5_SERIE+ZC5_CLIENT+ZC5_LOJA
		cDocumento:=StrZero(nDado,aLenDados[2])
		If ZC5->(DbSeek(xFilial("ZC5")+cDocumento ))
			AADD(aRecZC5,{ZC5->(Recno()),cRegistro,nLinTxt }  )
			aReturn:={.T.,"Nota Fiscal encontrada."}
			cStatus:="BR_VERDE"
		EndIf
	EndIf
EndIf

GdFieldPut("Status",cStatus,nLinaCols)
RestArea(aAreaZC5)
RestArea(aAreaAtu)
Return aReturn


CLEVER/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  06/15/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM13PV()
Local oBrowse
Local aRotiAtu:=aClone(aRotina)
Local cFilBrw :="@"
Local aCpoZC5 :={}
Local cTranspo	:= Alltrim(U_MyNewSX6(	"EC_NCG0013","864"		,"C","Codigos Transportadora","Codigos Transportadora","Codigos Transportadora",.F. ))
Local aCampos	:={}
Private aRotina:={}


AADD(aCpoZC5,"ZC5_FILIAL")
AADD(aCpoZC5,"ZC5_NUM")
AADD(aCpoZC5,"ZC5_NUMPV")
AADD(aCpoZC5,"ZC5_CLIENT")
AADD(aCpoZC5,"ZC5_LOJA")
AADD(aCpoZC5,"ZC5_NOME")
AADD(aCpoZC5,"ZC5_NOTA")
AADD(aCpoZC5,"ZC5_SERIE")

AADD(aCampos, {"Dt. de Saida",{||  Posicione("SZ1",1,xFilial("SZ1")+ZC5->(ZC5_NOTA+ZC5_SERIE+ZC5_CLIENT+ZC5_LOJA),"Z1_DTSAIDA") },"D" } )

AADD(aRotina, {"Pesquisar"	  		,"AxPesqui"		,0,1} )
AADD(aRotina, {"Visualizar"	  		,"AxVisual"		,0,2})
AADD(aRotina, {"Alterar"	  		,"U_COM13ALT"	,0,4})

cFilBrw+=" ZC5_RASTRE=' '"+CRLF
cFilBrw+=" And ZC5_ESTORN=' '"+CRLF
//cFilBrw+=" And ZC5.ZC5_YMSEXP=' '"+CRLF
cFilBrw+=" And Exists (Select 'X'"+CRLF
cFilBrw+=" From "+RetSqlName("SZ1")+" SZ1"+CRLF
cFilBrw+=" Where SZ1.Z1_FILIAL='"+xFilial("SZ1")+"'"+CRLF
cFilBrw+=" And ZC5_NUMPV=SZ1.Z1_PEDIDO "+CRLF
cFilBrw+=" And ZC5_NOTA=SZ1.Z1_DOC "+CRLF
cFilBrw+=" And ZC5_SERIE=SZ1.Z1_SERIE"+CRLF
cFilBrw+=" And SZ1.Z1_DTSAIDA<>' '"+CRLF
cFilBrw+=" And SZ1.Z1_DTSAIDA>='20140509'"+CRLF
cFilBrw+=" And ZC5_CODENT Not In "+FormatIn(cTranspo,",")+CRLF
cFilBrw+=" And SZ1.D_E_L_E_T_=' ')"+CRLF

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('ZC5')

//oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '4') "	, "BR_PRETO"	, "Pedido Recebido"  )
//oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '5') "	, "BR_VERMELHO"	, "Pedido em Analise" )
oBrowse:SetFilterDefault(cFilBrw)

oBrowse:SetOnlyFields( aCpoZC5 )
oBrowse:SetFields(aCampos )
oBrowse:SetDescription('Pedidos E-commerce Enviados sem Rastreamento')
oBrowse:Activate()


aRotina:=aClone(aRotiAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  06/15/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM13ALT(cAlias,nReg,nOpc)

Local aAreaAtu := GetArea()

Local aAcho:={}
Local aCpos:={}
Local cTudoOk:="U_COM13VAL()"

AADD(aAcho,"NOUSER")
AADD(aAcho,"ZC5_FILIAL")
If ZC5->ZC5_PLATAF == '01'
	AADD(aAcho,"ZC5_NUM")
Else
	AADD(aAcho,"ZC5_PVVTEX")
	AADD(aAcho,"ZC5_SEQUEN")
EndIf
AADD(aAcho,"ZC5_NUMPV")
AADD(aAcho,"ZC5_CLIENT")
AADD(aAcho,"ZC5_LOJA")
AADD(aAcho,"ZC5_NOME")
AADD(aAcho,"ZC5_NOTA")
AADD(aAcho,"ZC5_SERIE")
AADD(aAcho,"ZC5_RASTRE")
AADD(aAcho,"ZC5_STATUS")

AADD(aCpos,"ZC5_RASTRE")
AxAltera(cAlias,nReg,nOpc,aAcho,aCpos,/*<nColMens>*/,/*<cMensagem>*/,cTudoOk,/*<cTransact>*/,/*<cFunc>*/,/*<aButtons>*/,/*<aParam>*/,/*<aAuto>*/,/*<lVirtual>*/,/*<lMaximized>*/)

RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM13  ºAutor  ³Microsiga           º Data ³  06/15/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM13VAL()
Local lRetorno:=.T.
Local cCampo:=__ReadVar
Local cUrl
Local cUrlAux
Local cHtmlPage
Local lConecta
Local nCont

If "ZC5_RASTRE"$cCampo
	
	If MsgYesNo("O pedido foi enviado via correios?")
		cUrl:=Alltrim(U_MyNewSX6("EC_NCG0021",'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=',"C","URL Correrios","","",.F. ))
		cCodRast:=AllTrim(M->ZC5_RASTRE)
		
		If !Empty(cCodRast) .And. Right(cCodRast,2)<>"BR"
			cCodRast+="BR"
		EndIf
		
		If !Empty(cCodRast)
			cUrlAux:=cUrl+cCodRast
			lConecta:=.F.
			
			For nCont:=1 To 2
				
				Conout("URL"+cUrlAux)
				cHtmlPage := Httpget(cUrlAux)
				
				If !ValType(cHtmlPage)=="C"
					Loop
				EndIf
				
				If At(cCodRast,cHtmlPage)>0
					lConecta:=.T.
					Exit
				EndIf
				cCodRast:=AllTrim(M->ZC5_RASTRE)
				cUrlAux:=cUrl+cCodRast
			Next
		EndIf
		
		If lConecta
			M->ZC5_RASTRE:=cCodRast
		Else
			MsgStop("Não foi possivel validar o codigo de rastreio "+cCodRast+" no site dos Correios.")
			lRetorno:=.F.
		EndIf
		
	EndIf
	
EndIf

If ZC5->ZC5_STATUS $ "16|15"  //Atualização de Status.
	M->ZC5_STATUS := "30"
	M->ZC5_ATUAL := "N"
	M->ZC5_YMSEXP :=  MSDATE()
	M->ZC5_CODINT	:= "007"
EndIf

Return lRetorno
// ############################################################################################# //
// Projeto: Ecommerce B2B, Ecommerce B2C                                                         //
// Modulo :                                                                                      //
// Fonte  : ncecom13                                                                             //
// ---------+-------------------+--------------------------------------------------------------- //
// Data     | Autor             | Descricao                                                      //
// ---------+-------------------+--------------------------------------------------------------- //
// 03/09/15 | Lucas Felipe      |  Fonte responsavel pelo envio do rastreio dos pedido           //
// ---------+-------------------+--------------------------------------------------------------- //

User Function Ecom13Frt()

Local cAliasQry	:= GetNextAlias()

Local cAliasZC1	:= ZC1->(GetArea())
Local cAliasZC5	:= ZC5->(GetArea())
Local cAliasSZ1	:= SZ1->(GetArea())

Local cQry		:= ""
Local cAtuZC5	:= Alltrim(U_MyNewSX6("EC_NCG0024","N","C","Atualiza rastreio via gestão de fretes? N=Nao, S=Sim, T=Transição","","",.F. )) //inserir parametro responsavel pelo rastreio.
Local cUserName	:= UsrRetName(RetCodUsr())


cQry += " SELECT ZC5.R_E_C_N_O_ RecSZC5, "+CRLF
cQry += " 	 	ZC5.ZC5_NUM, "+CRLF
cQry += "  		ZC5.ZC5_NUMPV, "+CRLF
cQry += "  		ZC5.ZC5_PVVTEX, "+CRLF
cQry += "  		ZC5.ZC5_PLATAF, "+CRLF
cQry += "  		FRTRAS.NUM_DOCUMENTO As NumDoc, "+CRLF
cQry += " 		FRTRAS.SERIE_DOCUMENTO As SerieDoc, "+CRLF
cQry += " 		FRTRAS.ID_VOLUME As IdVolume, "+CRLF
cQry += " 		FRTRAS.NUMERO_VOLUME As NumVolume, "+CRLF
cQry += " 		FRTRAS.COD_RASTREIO As CodRastreio, "+CRLF
cQry += " 		nvl(FRTRAS.NUM_NF,'') As NumNf, "+CRLF
cQry += " 		nvl(FRTRAS.SERIE_NF,'') As SerieNf "+CRLF
cQry += "FROM "+RetSqlName("ZC5")+" ZC5, "+CRLF
cQry += "FRETES.TB_FRT_INTERF_ECT FRTRAS "+CRLF
cQry += "WHERE FRTRAS.NUMERO_VOLUME = '1' "+CRLF
cQry += "AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQry += "AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
cQry += "AND ZC5.ZC5_NUMPV = SubStr(FRTRAS.NUM_DOCUMENTO,5,6) "+CRLF
cQry += "AND ZC5.ZC5_STATUS IN ('15','16') "+CRLF
cQry := ChangeQuery(cQry)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry, .T., .F.)

ZC1->(DbSetOrder(3)) //ZC1_FILIAL+ZC1_NUMPV

Do While (cAliasQry)->(!Eof())
	
	ZC5->(DbGoTo((cAliasQry)->RecSZC5))
	
	If !(ZC1->(MsSeek(xFilial("ZC1")+ZC5->ZC5_NUMPV)))
		ZC1->(RecLock("ZC1",.T.))
		
		ZC1->ZC1_FILIAL := xFilial("ZC1")
		ZC1->ZC1_REGIST	:= (cAliasQry)->CodRastreio
		ZC1->ZC1_OBS	:= Alltrim(Str(Val((cAliasQry)->NumDoc)))
		ZC1->ZC1_NF		:= (cAliasQry)->NumNf
		ZC1->ZC1_DTIMPO := MsDate()
		ZC1->ZC1_NUMPV 	:= ZC5->ZC5_NUMPV
		ZC1->ZC1_HIMPOR := Time()
		ZC1->ZC1_USUARI := cUserName
		ZC1->ZC1_ATUZC5	:= cAtuZC5
		
		ZC1->(MsUnlock())
		
	Else
		
		ZC1->(RecLock("ZC1",.F.))
		
		ZC1->ZC1_ATUZC5	:= cAtuZC5
		
		ZC1->(MsUnlock())
		
	EndIf
	
	If ZC1->ZC1_ATUZC5 == "S"
		
		If !Empty(ZC1->ZC1_REGIST)
			SZ1->(DbSetOrder(2))
			SZ1->(MsSeek(xFilial("SZ1")+ZC5->ZC5_NUMPV))
			If !Empty(SZ1->Z1_DTSAIDA)
				ZC5->(RecLock("ZC5",.F.))
				
				ZC5->ZC5_RASTRE	:= ZC1->ZC1_REGIST
				ZC5->ZC5_STATUS := "30"
				ZC5->ZC5_ATUALI := "S"
				
				ZC5->(MsUnLock())
			EndIf
		EndIf
		
	EndIf
	
	(cAliasQry)->(DbSkip())
	
EndDo

(cAliasQry)->(DbCloseArea())

RestArea(cAliasSZ1)
RestArea(cAliasZC5)
RestArea(cAliasZC1)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} E13newTxt
// Função que irá controlar os rastreios de diversos .
//
// @author    Lucas Felipe
// @version   1.00
// @since     28/11/2015
/*/
//------------------------------------------------------------------------------------------

User Function COM13New

Local aSays		:={}
Local aButtons	:={}
Local lOk

Private cArquivo:=""

AADD( aSays, "Este processo tem como objetivo Atualizar a Base de Rastreamento E-Commerce" )
AADD( aSays, "baseado em modelo novo TXT." )
AADD( aButtons, { 01, .T., {|| lOk := .T.,(cArquivo:=cGetFile("Arquivo TXT | *.txt","Selecione o arquivo ",,,.T.)) ,Iif( File(cArquivo), FechaBatch(), msgStop("Arquivo Txt: "+cArquivo+" não localizado.") ) } } )
AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
;FormBatch( "Base de Rastreamento", aSays, aButtons )

If lOk
	Processa({|| E13Txt(  ) }, "Verificando arquivo TXT" )
EndIf

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} E13Txt
// Função tem como objetivo, realizar a validação dos pedidos a serem atualizados e
// atualiza-los
//
// @author    Lucas Felipe
// @version   1.00
// @since     28/11/2015
/*/
//------------------------------------------------------------------------------------------

Static Function E13Txt(  )

Local aDados		:= {}
Local lTemErro		:= .F.
Local cLinha		:= ""
Local aCabecTxt		:= {}
Local aItens		:= {}
Local lFirst		:= .T.
Local nLinha

Local nHdl			:= 0
Local nCont			:= 0
Local nTotLinha		:= 0

Local nLenRegistro	:= AvSx3("ZC1_REGIST",5)
Local aLenDados		:= {AvSx3("C5_NUM",3),AvSx3("F2_DOC",3)}
Local aRecZC5  		:= {}
Local cStatus		:= "BR_VERMELHO"
Local cDocumento	:= ""

Local oDlg
Local oBrw
Local bCriaVar		:= { |cField|  IIf(cField=="Linha",0,IIf(cField=="Status",Space(10),CriaVar(cField,.T.)) )     }
Local lGravar		:= .T.

Local nPosRegistro
Local nPosObs
Local nPosAdic

Local aPVNF

Local cTranspVal	:= Alltrim(U_MyNewSX6("VT_NCG0020","8004|862|863|6665|6783","C","Codigo de entrega validos para utilizar no ecommerce","","",.F. )) //inserir parametro responsavel pelo rastreio.
Private aCols		:= {}
Private aHeader		:= {}
Private aColsAux	:= {}
Private aHeaderAux	:= {}



AADD(aCabecTxt,{"PEDIDO"		,"ZC1_OBS"		})
AADD(aCabecTxt,{"CODENT"		,"ZC1_ADICIO"	})
AADD(aCabecTxt,{"RASTREIO"		,"ZC1_REGIST"	})


nPosRegistro:= Ascan(aCabecTxt,{|a| a[1]=="RASTREIO"})
nPosObs		:= Ascan(aCabecTxt,{|a| a[1]=="PEDIDO" 	})
nPosAdic	:= Ascan(aCabecTxt,{|a| a[1]=="CODENT"  })


If !File(cArquivo)
	MsgAlert("Arquivo texto: "+cArquivo+" não localizado")
	Return
Endif

Aadd(aHeaderAux,{" "		,"Status"	,"@BMP" ,4,0,"","","C","","V"})
Aadd(aHeaderAux,{"Linha"  	,"Linha"	,"@9999",5,0,"","","N","","V"})

ZC1->(FillGetDados (3, "ZC1",1, xFilial("ZC1"), {|| ZC1_FILIAL}, /*bSeekFor*/ , /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .T.,  aHeaderAux,  aColsAux, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, bCriaVar, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
ZC1->(DbSetOrder(2))//ZC1_FILIAL+ZC1_REGIST+ZC1_DATAX

nUsado:=Len(aHeader)

FT_FUSE(cArquivo)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
nTotLinha:=FT_FLASTREC()

ProcRegua(nTotLinha)

FT_FGOTOP()
aCols:={}
Do While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	
	cBuffer := FT_FREADLN()
	
	IncProc("Linha:"+StrZero(++nCont,5)+" de "+StrZero(nTotLinha,5))
	
	If lFirst
		lFirst := .F.
		FT_FSKIP();Loop
	EndIf
	
	If Empty(cBuffer)
		FT_FSKIP();Loop
	EndIf
	
	cBuffer:=StrTran(cBuffer,'"','')
	aDados:=Separa(cBuffer,";")
	
	If Len(aDados)<Len(aCabecTxt)
		AADD(aCols,aColsIni)
		nLinha:=Len(aCols)
		aCols[Len(aCols),nUsado+1]:=.F.
	EndIf
	
	If Empty(aDados[nPosObs])
		FT_FSKIP();Loop
	EndIf
	
	If !(aDados[nPosAdic] $ cTranspVal) //mudar para parametro 
	   MsgAlert("Não foi possivel importar o arquivo pois a forma de entrega indicada não foi encontrada no VT_NCG0020, na Linha: "+StrZero(nCont,5))
		Exit
	EndIf
	cRegistro:=COM13Trans( aDados[nPosRegistro] ,"ZC1_REGIST")
	
	If ZC1->( DbSeek(xFilial("ZC1")+ cRegistro )  )
		If ZC1->ZC1_ATUZC5 == "S"
			FT_FSKIP();Loop
		Else
			ZC1->(RecLock("ZC1",.F.))
			ZC1->(dbDelete())
			ZC1->(MsUnLock())
		EndIf
	EndIf
	
	AADD(aCols,aClone(aColsAux[1]))
	nLinha:=Len(aCols)
	
	If !Empty( aDados[nPosObs] )
		
		cDocumento := StrZero(Val(Alltrim(aDados[nPosObs])),aLenDados[1])
		If SC5->(MsSeek(xFilial("SC5")+cDocumento))
			ZC5->(DbSetOrder(2))
			If ZC5->(MsSeek(xFilial("ZC5")+cDocumento))
				AADD(aRecZC5,{ZC5->(Recno()),cRegistro,nCont }  )
				aReturn:={.T.,"Pedido Venda encontrado."}
				cStatus:="BR_VERDE"
				GdFieldPut("ZC1_NUMPV",cDocumento	,nLinha)
			EndIf
			
		Else
			cDocumento := StrZero(Val(Alltrim(aDados[nPosObs])),aLenDados[2])
			
			SF2->(MsSeek(xFilial("SF2")+cDocumento))
			ZC5->(DbSetOrder(4))
			If ZC5->(MsSeek(xFilial("ZC5")+cDocumento))
				AADD(aRecZC5,{ZC5->(Recno()),cRegistro,nCont }  )
				aReturn:={.T.,"Nota Fiscal encontrada."}
				cStatus:="BR_VERDE"
			EndIf
			
		EndIf
		
		GdFieldPut("Status",cStatus,nLinha)
		
	EndIf
	
	GdFieldPut("Linha" ,nCont,nLinha)
	
	For nInd:=1 To Len(aCabecTxt)
		uDado:=COM13Trans( aDados[nInd] ,aCabecTxt[nInd,2])
		GdFieldPut(aCabecTxt[nInd,2],uDado,nLinha)
	Next
	
	GdFieldPut("ZC1_DTIMPO"	,MsDate()	,nLinha)
	GdFieldPut("ZC1_HIMPOR"	,Time()		,nLinha)
	GdFieldPut("ZC1_USUARI"	,cUserName	,nLinha)
	GdFieldPut("ZC1_ATUZC5" ,"S"		,nLinha)
	
	aCols[nLinha,nUsado+1]:=.F.
	FT_FSKIP()
	
	
EndDo
FT_FUSE()

oDlg	:= MSDialog():New( 115,232,716,1601,cCadastro,,,.F.,,,,,,.T.,,,.T. )
oBrw 	:= MsNewGetDados():New(005,004,276,672,GD_UPDATE+GD_DELETE,'AllwaysTrue()','AllwaysTrue()','',,0,9999,'AllwaysTrue()','','AllwaysTrue()',oDlg,aHeader,aCols)

Activate MsDialog oDlg Centered On Init EnchoiceBar(oDlg,{|| lGravar:=.T.,oDlg:End()},{|| lGravar:=.F.,oDlg:End()},,)

If lGravar
	aCols:=oBrw:aCols
	Processa({||  COn13Grv(aRecZC5) })
	MsgInfo("Arquivo "+cArquivo+" processado com sucesso.")
EndIf


Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} COn13Grv
// Rotina de gravação de informações da interface de importação, para o sistema, essas rotinas
// atualizam as tabelas ZC1 e ZC5.
//
// @author    Lucas Felipe
// @version   1.00
// @since     03/11/2015
/*/
//------------------------------------------------------------------------------------------

Static Function COn13Grv(aRecZC5)

Local cFilZC1	:= xFilial("ZC1")
Local nInd
Local nYnd
Local nCont
Local nColuna
Local nAscan
Local nTotLinha	:= Len(aCols)
Local cMensagem
Local nLine		:= 0

ProcRegua(nTotLinha)

For nInd:=1 To nTotLinha
	
	cMensagem:="Linha:"+StrZero(++nLine,5)+" de "+StrZero(nTotLinha,5)
	IncProc(cMensagem)
	PtInternal(1,cMensagem)
	Conout(cMensagem)
	
	If GdDeleted( nInd , aHeader ,aCols)
		Loop
	EndIf
	
	Begin Transaction
	
	ZC1->(RecLock("ZC1",.T.))
	ZC1->ZC1_FILIAL:=cFilZC1
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZC1->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZC1->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	
	
	If !ZC1->ZC1_ERRO .And. (nAscan:=Ascan(aRecZC5, { |a|a[3]==GdFieldGet("Linha",nInd,,aHeader,aCols) }  )  ) >0
		ZC5->(DbGoTo(aRecZC5[nAscan,1]))
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_RASTRE	:= ZC1->ZC1_REGIST
		ZC5->ZC5_STATUS	:= '30'
		ZC5->ZC5_ATUALI	:= "S"
		If !Empty(ZC1->ZC1_ADICIO)//Cód. Entrega
			ZC5->ZC5_CODENT	:= ZC1->ZC1_ADICIO //Cód. Entrega
		EndIf
		ZC5->(MsUnLock())
		
		ZC1->ZC1_NUMPV :=  ZC5->ZC5_NUMPV
	EndIf
	
	ZC1->(MsUnLock())
	End Transaction
Next

Return
