#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  02/17/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGWM002()
Local aArea			:= GetArea()
Local aCpoZC5		:= {}
Local cFilBrw		:= ""
Local aParams		:= {}

Private aRotina 	:= MenuDef()
Private cCadastro := "Monitor - Pedido Venda WebManager"
Private oBrowse

ZC5->(dbSetOrder(1))


If !PergFil(@aParams)
	Return
EndIf

cFilBrw 	+= "@ ZC5_PLATAF='WM'"
cFilBrw  	+= WM002Fil(aParams[2],aParams)//Filtro da Mbrwse


AADD(aCpoZC5,"ZC5_NUM")
AADD(aCpoZC5,"ZC5_DTVTEX")
AADD(aCpoZC5,"ZC5_NUMPV")
AADD(aCpoZC5,"ZC5_PREVEN")
AADD(aCpoZC5,"ZC5_CLIENT")
AADD(aCpoZC5,"ZC5_LOJA")
AADD(aCpoZC5,"ZC5_NOME")
AADD(aCpoZC5,"ZC5_NFANTA")
AADD(aCpoZC5,"ZC5_QTDPAR")
AADD(aCpoZC5,"ZC5_STATUS")
AADD(aCpoZC5,"ZC5_DTWMS")
AADD(aCpoZC5,"ZC5_NOTA")
AADD(aCpoZC5,"ZC5_SERIE")
AADD(aCpoZC5,"ZC5_EMISNF")
AADD(aCpoZC5,"ZC5_HRNFE")
AADD(aCpoZC5,"ZC5_CHVNFE")
AADD(aCpoZC5,"ZC5_DTSAID")
AADD(aCpoZC5,"ZC5_DTENTR")
AADD(aCpoZC5,"ZC5_RASTRE")
AADD(aCpoZC5,"ZC5_TOTAL")
AADD(aCpoZC5,"ZC5_FRETE ")
AADD(aCpoZC5,"ZC5_DOCDEV")
AADD(aCpoZC5,"ZC5_SERDEV")
AADD(aCpoZC5,"ZC5_CODENT")
AADD(aCpoZC5,"ZC5_VDESCO")
AADD(aCpoZC5,"ZC5_PDESCO")
AADD(aCpoZC5,"ZC5_MSEXP")

oBrowse := FWMBrowse():New()
oBrowse:SetOnlyFields( aCpoZC5)

oBrowse:SetAlias("ZC5")

oBrowse:AddLegend("(Alltrim(ZC5->ZC5_FLAG) == '4') "	, "BR_VIOLETA"	, "Erro no cadastro de cliente"  )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_FLAG) == '5') "	, "ANALITIC"	, "Pedido com produto nใo encontrado"  ) 

oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '4') "	, "BR_PRETO"	, "Pedido Recebido"  )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '5') "	, "BR_VERMELHO"	, "Pedido em Analise" )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '10') "	, "BR_AMARELO" 	, "Credito Aprovado" )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '15') "	, "BR_LARANJA" 	, "Expedi็ใo"  )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '16') "	, "BR_MARROM"  	, "Nota Fiscal Emitida"  )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '30') "	, "BR_VERDE" 	, "Pedido Enviado"   )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '90') "	, "BR_BRANCO"  	, "Pedido Cancelado" )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '96') "	, "BR_AZUL"   	, "Pedido Cancelado por Credito"  )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '91') "	, "BR_PINK"   	, "Pedido Devolvido" )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '92') "	, "BR_CANCEL"  	, "Aguard.Reimporta็ใo\Cancelamento"  )
oBrowse:AddLegend("(Alltrim(ZC5->ZC5_STATUS) == '93') "	, "BR_CANCEL"  	, "Estornado"  )

oBrowse:SetFilterDefault(cFilBrw)
oBrowse:SetDescription(cCadastro)
oBrowse:Activate()

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  02/17/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WM002Leg()
Local aLegenda 	:= {}
Local aCores	:= {}


Aadd(aCores, {" (ZC5_FLAG == '4') "		, "BR_VIOLETA"	, "Erro no cadastro de cliente"  })
Aadd(aCores, {" (ZC5_FLAG == '5') "		, "ANALITIC"	, "Produto nใo encontrado no ERP"  })
Aadd(aCores, {" (ZC5_FLAG == '6') "		, "BR_CINZA"	, "Erro de Grava็ao de PV"  })      

Aadd(aCores, {"(ZC5_STATUS == '4') "	, "BR_PRETO"	, "Pedido Recebido"  })
Aadd(aCores, {"(ZC5_STATUS == '5') "	, "BR_VERMELHO"	, "Pedido em Analise"  })
Aadd(aCores, {"(ZC5_STATUS == '10') "	, "BR_AMARELO" 	, "Credito Aprovado"  } )
Aadd(aCores, {"(ZC5_STATUS == '16') "	, "BR_LARANJA" 	, "Expedi็ใo"  })
Aadd(aCores, {"(ZC5_STATUS == '15') "	, "BR_MARROM"  	, "Nota Fiscal Emitida"  } )
Aadd(aCores, {"(ZC5_STATUS == '30') "	, "BR_VERDE" 	, "Pedido Enviado"  } )
Aadd(aCores, {"(ZC5_STATUS == '90') "	, "BR_BRANCO" 	, "Pedido Cancelado"  })
Aadd(aCores, {"(ZC5_STATUS == '96') "	, "BR_AZUL"   	, "Pedido Cancelado por Credito"  })
Aadd(aCores, {"(ZC5_STATUS == '91') "	, "BR_PINK"   	, "Pedido Devolvido"  })
Aadd(aCores, {"(ZC5_STATUS == '92') "	, "BR_CANCEL"  	, "Aguard.Reimporta็ใo\Cancelamento"   })
Aadd(aCores, {"(ZC5_STATUS == '93') "	, "BR_CANCEL"   , "Estornado"  })

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  02/17/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WM002Mon(cAlias, nRecno, nOpc)
Local aArea 	:= GetArea()
Local oDlg
Local oWin01
Local oWin02
Local oFWLayer
Local oFont
Local oButAtuCR
Local oButLibWMS
Local oButPed
Local oButSair
Local oButHisRa
Local oButNfs
Local aHeader		:= {}
Local aCols			:= {}
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= aScreen[1]-45
Local nHStage 		:= aScreen[2]-225
Local nX		  		:= 0
Local aButton		:= {}
Local aSize     	:= MsAdvSize(.T.)
Local oBarBtn
Local bSair			:= {|| oDlg:End() }//Sair
Local bAtu			:= {|| RefrMonitor()}//Atualiza o monitor
Local oButton
Local oTimer

Private aCamposZC5	:= {"ZC5_ESTORN","ZC5_STATUS","ZC5_NUM","ZC5_NUMPV","ZC5_CLIENT","ZC5_LOJA","A1_NOME","ZC5_COND","ZC5_NOTA","ZC5_SERIE", "ZC5_TOTAL", "ZC5_QTDPAR","ZC5_DOCDEV", "ZC5_SERDEV"}
Private aCamposZC7	:= {"ZC7_ACAO","ZC7_DATA","ZC7_HORA","ZC7_USUARI","ZC7_ERRO","ZC7_STATPV","ZC7_OBS"}

Private aHeaderZC5  := {}
Private aHeaderZC7  := {}
Private aColsZC5 	:= {}
Private aColsZC7 	:= {}
Private oGetDZC5
Private oGetDZC7
Private oTMultiget
Private cGet		:= ""
Private aSize		:= MsAdvSize(.T.)

//Preenche o aheader e o acols da tabela ZC5
aHeaderZC5 	:= CriaHeader(aCamposZC5)//Cria o aheader da tabela ZC7
aColsZC5 	:= CriaAcZC5( ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX )//Cria o acols da tabela ZC7

//Preenche o aheader e o acols da tabela ZC7
aHeaderZC7 	:= CriaHeader(aCamposZC7)//Cria o aheader da tabela ZC7
aColsZC7 	:= CriaAcZC7( ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX )//Cria o acols da tabela ZC7


//Montagem da tela
DEFINE DIALOG oDlg TITLE cCadastro SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro ้ para
//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )


// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Processo", 25, .F., .T., ,,)
oFWLayer:AddWindow( "Col01", "Win02", "Detalhe", 75 , .F., .T., {|| .T. },,)


oWin01 := oFWLayer:getWinPanel('Col01','Win01')
oWin02 := oFWLayer:getWinPanel('Col01','Win02')

oTMultiget := TMultiGet():New( 005,005, {|u| if( Pcount()>0, cGet:= u, cGet) },oWin02,200,oWin02:nClientHeight - (oWin02:nClientHeight * 56.45)/100 ,,.T.,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,.T.)

//Cria a getdados da tabela ZC5
oGetDZC5 := MsNewGetDados():New(005,005,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderZC5,aColsZC5)


//Cria a getdados da tabela ZC7
oGetDZC7 := MsNewGetDados():New(005,210,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin02,aHeaderZC7,aColsZC7, {||RefresDet(GdFieldGet("ZC7_OBS")) })


oTimer:= TTimer():New(10000,{|| RefrMonitor() },oDlg) // Ativa timer
oTimer:Activate()

//Adiciona a barra dos bot๕es

If !Empty(ZC5->ZC5_NUMPV) .And. !(ZC5->ZC5_FLAG == "1") //Pedidos gravados.
	
	oButAtuCR	:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-272, "Atualiza Reserva",oWin02,{ ||LJMsgRun("Aguarde o processamento...","Aguarde...",{|| AtuReserva(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV, ZC5->ZC5_STATUS,ZC5->ZC5_PVVTEX) })}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButLibWMS	:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-219, "Enviar WMS",oWin02,{ ||LJMsgRun("Aguarde o processamento...","Aguarde...",{|| EnvPvWms(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV, ZC5->ZC5_STATUS) })}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButCli		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-166, "Cliente",oWin02,{ ||ManClient(ZC5->ZC5_CLIENT, ZC5->ZC5_LOJA)}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButPed 		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-113, "Pedido",oWin02,{ || VisDetPed(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButSair		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60,  "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
ElseIf !Empty(ZC5->ZC5_NUMPV) .And. ZC5->ZC5_FLAG == "1"   // Pedido parado no Credito
	
	oButCli		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-166, "Cliente",oWin02,{ ||ManClient(ZC5->ZC5_CLIENT, ZC5->ZC5_LOJA)}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButPed 		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-113, "Pedido",oWin02,{ || VisDetPed(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButSair		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60,  "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
ElseIf !Empty(ZC5->ZC5_NUMPV) .And. !Empty(ZC5->ZC5_NOTA)  // pedido com nota emitida
	
	oButNfs 		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-166, "Danfe",oWin02,{ ||LJMsgRun("Aguarde o processamento...","Aguarde...",{|| Ec11Danfe(ZC5->ZC5_NOTA, ZC5->ZC5_SERIE, ZC5->ZC5_CLIENT, ZC5->ZC5_LOJA)})}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButPed 		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-113, "Pedido",oWin02,{ || VisDetPed(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButSair		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60, "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
Else
	
	oButCli		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-166, "Cliente",oWin02,{ ||ManClient(ZC5->ZC5_CLIENT, ZC5->ZC5_LOJA)}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButPed 		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-113, "Pedido",oWin02,{ || VisDetPed(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButSair		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60,  "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
EndIf

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRefrMonitorบAutor  ณElton C.	         บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de atualiza็ใo do monitro							  			บฑฑ
ฑฑบ          ณ			                                                  		บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RefrMonitor()

Local aArea := GetArea()

aColsZC5 := CriaAcZC5( ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX )//Cria o acols da tabela ZC7
aColsZC7 := CriaAcZC7( ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,ZC5->ZC5_PVVTEX )//Cria o acols da tabela ZC7

oGetDZC5:Acols := aColsZC5
oGetDZC5:Refresh()

oGetDZC7:Acols := aColsZC7
oGetDZC7:Refresh()


RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRefresDetบAutor  ณElton C.	           บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o campo de detalhe do monitor, na mudan็a de linha บฑฑ
ฑฑบ          ณdo acols                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RefresDet(cObs)

Local aArea 	:= GetArea()

Default cObs	:= ""

cGet := cObs
oTMultiget:Refresh()

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeaderบAutor  ณElton C.	           บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o aHeader						                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaHeader(aCampos)
Local aArea		:= GetArea()
Local aRet	 	:= {}
Local nIx		:= 0
Local lDif		:= .F.

Default aCampos := {}

DbSelectArea( "SX3" )
DbSetOrder(2)

For nIx := 1 To Len( aCampos )
	
	If aCampos[ nIx ]=="ESTOQUE"
		Aadd(aRet,	{"","ESTOQUE","@BMP",20,00,,,"C",,"V" } )
	ElseIf SX3->( MsSeek( aCampos[ nIx ] ) )
		
		If Alltrim(SX3->X3_CAMPO) == "C0_QTDPED".And. !lDif
			cDescCpo	:= "Qtd.Reserv."
			lDif		:= .T.
		ElseIf	(Alltrim(SX3->X3_CAMPO) == "C0_QTDPED" ) .And. lDif//Tratamento para alterar o titulo (Itens do pedido)
			cDescCpo	:= "Dif.Qtd.Pv. x Reserva"
			lDif		:= .F.
		ElseIf Alltrim(SX3->X3_CAMPO) == "B2_QATU"
			cDescCpo := "Qtd.Disponํvel"
		ElseIf Alltrim(SX3->X3_CAMPO) == "ZC5_NUM"
			cDescCpo :="Pedido WebManager"
		Else
			cDescCpo := X3Titulo()
		EndIf
		
		aAdd( aRet, {AlLTrim( cDescCpo)	, ;	// 01 - Titulo
		SX3->X3_CAMPO	, ;	// 02 - Campo
		SX3->X3_Picture	, ;	// 03 - Picture
		SX3->X3_TAMANHO	, ;	// 04 - Tamanho
		SX3->X3_DECIMAL	, ;	// 05 - Decimal
		SX3->X3_Valid  	, ;	// 06 - Valid
		SX3->X3_USADO  	, ;	// 07 - Usado
		SX3->X3_TIPO   	, ;	// 08 - Tipo
		SX3->X3_F3		, ;	// 09 - F3
		SX3->X3_CONTEXT	, ;	// 10 - Contexto
		SX3->X3_CBOX	, ; // 11 - ComboBox
		SX3->X3_RELACAO	} )	// 12 - Relacao
	Endif
Next

RestArea( aArea )

Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAcolsZC7บAutor  ณElton C.          บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcZC7( nPedSite, cPedProt,cPvVtex )
Local aArea    	:= GetArea()
Local aStruct	 	:= {}
Local nX				:= 0
Local aRet			:= {}
Local cAliasTmp	:= ""
Local cQuery		:= ""

Default nPedSite 	:= 0
Default cPedProt 	:= ""

cAliasTmp := GetNextAlias()

cQuery := "SELECT utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(ZC7_OBS,2000,1)) ZC7_OBS, "+CRLF
cQuery += " ZC7_ACAO,  ZC7_DATA, ZC7_HORA, ZC7_USUARI, ZC7_ERRO, ZC7_STATPV, R_E_C_N_O_ RECNOZC7 FROM "+RetSqlName("ZC7")+" ZC7 "+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND ZC7_FILIAL = '"+xFilial("ZC7")+"' "

If !Empty(cPvVtex)
	cQuery += " AND ZC7_PVVTEX = '"+cPvVtex+"' "+CRLF
Else
	cQuery += " AND ZC7_PVECOM = '"+Alltrim(Str(nPedSite))+"' "+CRLF
	cQuery += " AND ZC7_NUM = '"+cPedProt+"' "+CRLF
Endif

cQuery += " ORDER BY R_E_C_N_O_ DESC "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := ZC7->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX

aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	aAdd(aRet,{(cAliasTmp)->ZC7_ACAO,;
	(cAliasTmp)->ZC7_DATA,;
	(cAliasTmp)->ZC7_HORA  ,;
	(cAliasTmp)->ZC7_USUARI  ,;
	Iif((cAliasTmp)->ZC7_ERRO == "S","Sim","Nใo")  ,;
	(cAliasTmp)->ZC7_STATPV,;
	Alltrim((cAliasTmp)->ZC7_OBS)   ,;
	,.F.})
	
	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	aAdd(aRet,{"",;
	"",;
	"",;
	"",;
	"",;
	"",;
	"",;
	,.F.})
	
EndIf

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAcolsZC5บAutor  ณElton C.          บ Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcZC5( nPedSite, cPedProt,cPvVtex )
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX				:= 0
Local aRet			:= {}
Local aAux
Local cAliasTmp	:= ""
Local cQuery		:= ""
Local cDescSts		:= ""


Default nPedSite	:=  0
Default cPedProt	:= ""

cAliasTmp := GetNextAlias()

cQuery := "SELECT * FROM "+RetSqlName("ZC5")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND ZC5_FILIAL = '"+xFilial("ZC5")+"' "

If !Empty(cPvVtex)
	cQuery += " AND ZC5_PVVTEX = '"+cPvVtex+"' "
Else
	cQuery += " AND ZC5_NUM = '"+Alltrim(Str(nPedSite))+"' "
	cQuery += " AND ZC5_NUMPV = '"+cPedProt+"' "
EndIf

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := ZC5->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX

aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	cDescSts := ""
	cDescSts := GetStsPd((cAliasTmp)->ZC5_STATUS)
	
	aAdd(aRet,{})
	aAux:=aRet[Len(aRet)]
	
	AADD(aAux,(cAliasTmp)->ZC5_ESTORN )
	AADD(aAux,cDescSts)
	AADD(aAux,IIf(!Empty(cPvVtex),AllTrim((cAliasTmp)->ZC5_PVVTEX)+"("+AllTrim((cAliasTmp)->ZC5_SEQUEN)+")",(cAliasTmp)->ZC5_NUM))
	If !Empty(cPvVtex)
		AADD(aAux,(cAliasTmp)->ZC5_NOECOM)
	EndIf
	
	AADD(aAux,(cAliasTmp)->ZC5_NUMPV)
	
	AADD(aAux,(cAliasTmp)->ZC5_CLIENT)
	AADD(aAux,(cAliasTmp)->ZC5_LOJA)
	AADD(aAux,Posicione("SA1",1,xFilial("SA1")+(cAliasTmp)->ZC5_CLIENT+(cAliasTmp)->ZC5_LOJA,"A1_NOME"))
	
	If !Empty(cPvVtex)
		AADD(aAux,(cAliasTmp)->ZC5_TPPGTO)
	Else
		AADD(aAux,(cAliasTmp)->ZC5_COND)
	EndIf
	AADD(aAux,(cAliasTmp)->ZC5_NOTA)
	AADD(aAux,(cAliasTmp)->ZC5_SERIE)
	AADD(aAux,(cAliasTmp)->ZC5_TOTAL)
	AADD(aAux,(cAliasTmp)->ZC5_QTDPAR)
	AADD(aAux,(cAliasTmp)->ZC5_DOCDEV)
	AADD(aAux,(cAliasTmp)->ZC5_SERDEV)
	AADD(aAux,.F.)
	
	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVisPedidoบAutor  ณElton C.	           บ Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVisualiza pedido de vendas			                     	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VisPedido(cPedido)

Local aArea := GetArea()

Default cPedido := ""

DbSelectArea("SC5")
DbSetOrder(1)

If !Empty(cPedido)
	
	If SC5->(DbSeek(xFilial("SC5") + cPedido))
		
		VISUAL := .T.
		
		//Chama a rotina para visualizar o pedido de venda
		A410Visual("SC5",SC5->(Recno()),1)
		
		VISUAL := .F.
	Else
		Aviso("Nใo encontrado", "Pedido nใo encontrado "+cPedido, {"Ok"},2)
		
	EndIf
	
Else
	Aviso("Nใo encontrado", "Pedido nใo encontrado e\ou nใo incluํdo no sistema Protheus... "+cPedido, {"Ok"},2)
	
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVisDetPedบAutor  ณElton C.	           บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDetalhe do pedido de venda				                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VisDetPed(nPedSite, cNumPedProt,cPvVtex)
Local aArea 		:= GetArea()
Local aCpoCabPV   := {"C5_CONDPAG", "E4_DESCRI", "C5_TABELA", "C5_VEND1", "A3_NOME", "C5_DESPESA", "C5_TPFRETE", "C5_FRETE", "C5_YCANAL", "C5_YDCANAL"}
Local aCpoItPV   	:= {"ESTOQUE","ZC5_NUM", "ZC5_NUMPV", "C6_PRODUTO","ZC6_IDPROD", "C6_DESCRI", "C6_QTDVEN", "C0_QTDPED", "C0_QTDPED","C6_PRCVEN", "C6_VALOR", "C6_PRCTAB", "C6_TES", "ZC5_VDESCO", "ZC5_PDESCO","C6_YPERVPC","C6_YVALVPC"}
Local aCpoItPVSt	:= {"ZC6_NUM", "ZC6_ITEM", "ZC6_PRODUT", "B1_XDESC","ZC6_QTDVEN", "B2_QATU", "ZC6_VLRUNI", "ZC6_VLRTOT", "B1_MSBLQL", "B1_BLQVEND","ZC6_IDPROD" }
Local aScreen 		:= GetScreenRes()
Local nWStage 		:= 800
Local nHStage 		:= 500
Local oDlg
Local oFWLayer
Local oWin01
Local oButReimp
Local oButCanc
Local oFolder
Local aTitles		:= {}//Titulos do folder
Local aPages		:= {}
Local oGetDPV
Local oGetDItPV
Local oGetDItSt
Local aAcolsCbPV	:= {}
Local aAcolsCbPV 	:= {}
Local aHeadItPV	:= {}
Local aAcolsItPV 	:= {}
Local cArmPad		:= SuperGetMv("MV_CIAESTO",,"01")

Default nPedSite		:= 0
Default cNumPedProt 	:= ""


//Preenchimento da dcescri็ใo do folder
If !Empty(cNumPedProt)
	aTitles	:= {"Resumo Cab.PV","Resumo Itens PV"}
Else
	aTitles	:= {"Itens Pedido WM"}
EndIf


aHeadCbPV	 	:= CriaHeader(aCpoCabPV)
aAcolsCbPV  	:= CriaACbPed(cNumPedProt,cPvVtex)//Cabe็alho do pedido no Protheus

aHeadItPV	 	:= CriaHeader(aCpoItPV)
aAcolsItPV  	:= CriaAItPed(cNumPedProt,cPvVtex)//Itens do pedido no Portheus

aHeadPVSt	 	:= CriaHeader(aCpoItPVSt)
aAcolsPVSt  	:= CriaAItSt(nPedSite, cArmPad,cPvVtex)//Itens do site


//Verifica se existe dados no acols
If (	Len(aAcolsCbPV) > 0)  .Or. (Len(aAcolsPVSt) > 0)
	
	//Montagem da tela
	DEFINE DIALOG oDlg TITLE "Detalhe do pedido " SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)
	
	//Cria instancia do fwlayer
	oFWLayer := FWLayer():New()
	
	//Inicializa componente passa a Dialog criada,o segundo parametro ้ para
	//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho
	oFWLayer:Init( oDlg, .T. )
	
	// Efetua a montagem das colunas das telas
	oFWLayer:AddCollumn( "Col01", 100, .T. )
	
	
	// Cria windows passando, nome da coluna onde sera criada, nome da window
	// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
	// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split
	oFWLayer:AddWindow( "Col01", "Win01", "Detalhe do pedido", 100, .F., .T., ,,)
	
	
	oWin01 := oFWLayer:getWinPanel('Col01','Win01')
	
	oFolder := TFolder():New(005,001,aTitles,aPages,oWin01,,,,.T.,.F.,390,190)
	
	
	If !Empty(cNumPedProt)//Resumo do pedido no Protheus
		
		//Cria a getdados com resumo do cabe็alho
		oGetDPV 	:= MsNewGetDados():New(005,005,175,385 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oFolder:aDialogs[1],aHeadCbPV,aAcolsCbPV, {||	})
		
		//Cria a getdados com resumo dos itens
		oGetDItPV	:= MsNewGetDados():New(005,005,175,385 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oFolder:aDialogs[2],aHeadItPV,aAcolsItPV, {||	})
		
	Else//Resumo dos itens do pedido no site
		
		//Cria getdados dos produtos importados do site
		oGetDItSt 	:= MsNewGetDados():New(005,005,175,385 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oFolder:aDialogs[1],aHeadPVSt,aAcolsPVSt, {||	})
	EndIf
	
	If ZC5->ZC5_STATUS == '92'
		oButCanc	:= TButton():New( 200, 201, "Cancelar Pedido",oWin01,{ || EnvStsCan(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV, ZC5->ZC5_NOTA,ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
		oButReimp	:= TButton():New( 200, 254, "Reimporta็ใo"   ,oWin01,{ || ReimpPed(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV, ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )  
	Else   
		oButCanc	:= TButton():New( 200, 254, "Cancelar Pedido",oWin01,{ || EnvStsCan(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV, ZC5->ZC5_NOTA,ZC5->ZC5_PVVTEX) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. ) 
	EndIf 
	
	oButPed	:= TButton():New( 200, 307, "Vis.Pedido",oWin01,{ || LJMsgRun("Aguarde o processamento...","Aguarde...",;
	{|| VisPedido(cNumPedProt)});
	}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	oButSair	:= TButton():New( 200, 360, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
	
	
Else
	Aviso("NOEXISTE","Nenhum pedido encontrado.",{"Ok"},2)
EndIf


RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvStsCan	บAutor  ณElton C.		     บ Data ณ  02/2014    	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para enviar status de cancelamento 		  	บฑฑ
ฑฑบ          ณpara o site	                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvStsCan(nPVSite,cNumPVP, cNota,cPVVtex)

Local aArea 		:= GetArea()
Local cMsgJustif	:= ""

Default nPVSite	:= 0
Default cNumPVP	:= ""
Default cNota 		:= ""

//Verifica se existe NF gerada para o pedido, se nใo existir o usuแrio deverแ decidir sobre o cancelamento do mesmo.
If Empty(cNota)
	
	If Alltrim(ZC5->ZC5_STATUS) != "90"
		
		If VldCancel(nPVSite, cNumPVP)//Valida็ใo do cancelamento
			
			If Aviso("Cancelamento","Nใo existe nota fiscal para este pedido "+IIf(!Empty(cPVVtex),cPVVtex,Alltrim(Str(nPVSite)))+". Deseja realmente cancelar ? ",{"Sim","Nใo"},2 ) == 1
				
				//Tela para justificativa
				cMsgJustif := u_NCGetJust()
				U_PR106ExcP0A(xFilial("ZC5"),cNumPVP)
				
				If !Empty(cMsgJustif)
					
					If Ec11Canc(cNumPVP)
						
						ZC5->(Reclock("ZC5",.F.))
						
						ZC5->ZC5_STATUS 	:= "90"
						ZC5->ZC5_FLAG		:= ""
						ZC5->ZC5_ATUALIZA	:= "S"
						
						ZC5->(MsUnLock())
						
						U_NcEcom07(cNumPVP) //Atualiza o status do pedido no Site
						U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Cancelamento de Pedido","Justificativa "+CRLF+cMsgJustif,"",.T.,,,ZC5->ZC5_PVVTEX)	//Log de processamento
						
						U_WM01GrvCan(cMsgJustif) //Enviar Log de cancelamento
						
					Else
						Aviso("Nใo Cancelado","Problemas no processo de cancelamento.",{"Ok"},2)
					EndIf
				Else
					
					Aviso("Nใo Cancelado","Justificativa nใo preenchida, o pedido nใo serแ cancelado.",{"Ok"},2)
					
				EndIf
			EndIf
		EndIf
		
	Else
		Aviso("NOEXISTE","Pedido jแ faturado e nใo pode ser cancelado",{"Ok"},2)
	EndIf
	
	
Else
	If VldCancel(nPVSite, cNumPVP)//Valida็ใo do cancelamento
		//Chama a rotina para confirmar o cancelamento do pedido
		StsCan(nPVSite,cNumPVP)
	EndIf
EndIf

RestArea(aArea)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCancel		บAutor  ณElton C.		 	บData   ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o pedido estแ no WMS	     						บฑฑ
ฑฑบ          ณ	                                            			  	บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldCancel(nPedSite, cNumProth)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux  := "Nใo ้ possํvel cancelar o pedido pelo(s) motivo(s) abaixo:"+CRLF+CRLF
Local cMsg		:= ""

Default nPedSite	:= 0
Default cNumProth	:= ""

If !VldPedWMS(cNumProth)
	cMsg	+= "- Aguardando cancelamento do WMS. "+CRLF
	lRet	:= .F.
EndIf

If !lRet
	Aviso("Aten็ใo",cMsgAux+cMsg,{"Ok"},3)
EndIf

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldPedWMS		บAutor  ณElton C.		 	  บData ณ  02/2014   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o pedido estแ no WMS	     					  	บฑฑ
ฑฑบ          ณ	                                           				บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldPedWMS(cNumPVP)

Local aArea		:= GetArea()
Local aAreaP0A	:= P0A->(GetArea())
Local cArqTmp		:= GetNextAlias()
Local cAliasQry	:= GetNextAlias()

Local cQuery   	:= ""
Local cChave   	:= ""

Local lRet			:= .T.
Local cUsrBD 		:= U_MyNewSX6("NCG_000019","","C","Usuแrio para acessar a base do WMS","","",.F.)

Default cNumPVP	:= ""

If !Empty(cNumPVP)
	
	cChave := xFilial("P0A")+AllTrim(cNumPVP)
	
	BeginSql Alias cAliasQry
		
		Select P0A.R_E_C_N_O_ P0ARec From %Table:P0A% P0A
		Where P0A.P0A_FILIAL = %xfilial:P0A%
		And P0A.%NotDel%
		And P0A.P0A_CHAVE = %exp:cChave%
		
	EndSql
	
	If (cAliasQry)->(!Eof())
		
		P0A->(DbGoTo((cAliasQry)->P0ARec))
		If P0A->P0A_EXPORT == "2"
			lRet := .F.
		Else
			cQuery	:= " SELECT CES_COD_CHAVE "
			cQuery	+= " FROM "+cUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
			cQuery	+= " WHERE CES_NUM_DOCUMENTO = '"+cNumPVP+"' "
			cQuery	+= " AND NOT EXISTS"
			cQuery	+= " (SELECT 'X' FROM "+cUsrBD+".TB_WMSINTERF_DOC_SAIDA"
			cQuery	+= " WHERE DPCS_NUM_DOCUMENTO = CES_NUM_DOCUMENTO )"
			
			dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
			
			If (cArqTmp)->(!Eof())
				If Empty((cArqTmp)->CES_COD_CHAVE)
					lRet := .F.
				EndIf
			Else
				lRet := .F.
			EndIf
			
			(cArqTmp)->(DbCloseArea())
		EndIf
	EndIf
	
EndIf

RestArea(aAreaP0A)
RestArea(aArea)

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณStsCan 		บAutor  ณElton C.		  บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAltera para Status cancelado (90), o pedido com NF canceladaบฑฑ
ฑฑบ          ณ	                                              				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function StsCan(nPVSite,cNumPVP)

Local aArea 		:= GetArea()
Local cQuery   	:= ""
Local cArqTmp		:= GetNextAlias()
Local cMsgJustif	:= ""

Default nPVSite	:= 0
Default cNumPVP	:= ""

cQuery   := " SELECT ZC5.R_E_C_N_O_ RECNOZC5, ZC5_NUM, ZC5_NUMPV  FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQuery   += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPVSite))+"' "+CRLF
cQuery   += " AND ZC5.ZC5_NUMPV = '"+cNumPVP+"' "+CRLF
cQuery   += " AND ZC5.ZC5_STATUS != '90'
cQuery   += " AND ZC5.ZC5_ESTORN = 'S' "+CRLF
cQuery   += " AND NOT EXISTS( SELECT * FROM "+RetSqlName("ZC5")+" ZC52 "+CRLF
cQuery   += "                 WHERE ZC52.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += "                 AND ZC52.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += "                 AND ZC52.ZC5_NUM = ZC5.ZC5_NUM "+CRLF
cQuery   += "                 AND ZC52.ZC5_PVVTEX = ZC5.ZC5_PVVTEX "+CRLF
cQuery   += "                 AND ZC52.ZC5_ESTORN != 'S' "+CRLF
cQuery   += "                 ) "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	
	If Aviso("Cancelamento","Deseja realmente cancelar o pedido "+Alltrim(Str((cArqTmp)->ZC5_NUM))+" ? ",{"Sim","Nใo"},2 ) == 1
		
		cMsgJustif := u_NCGetJust()
		
		If !Empty(cMsgJustif)
			DbSelectArea("ZC5")
			DbSetOrder(1)
			ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
			
			Reclock("ZC5",.F.)
			ZC5->ZC5_STATUS 	:= "90"
			ZC5->ZC5_ATUALIZA	:= "S"
			ZC5->(MsUnLock())
			
			//Log de processamento
			U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Cancelamento de Pedido","Justificativa "+CRLF+cMsgJustif,"",.T.,,,ZC5->ZC5_PVVTEX)
			
			Aviso("Cancelado","Pedido cancelado",{"Ok"},2)
		Else
			Aviso("Nใo Cancelado","Justificativa nใo preenchida, o pedido nใo serแ cancelado.",{"Ok"},2)
		EndIf
	EndIf
Else
	
	Aviso("NOEXISTE","Nใo existe pedido a ser cancelado",{"Ok"},2)
	
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReimpPed	บAutor  ณElton C.	      บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de reimporta็ใo de pedido							  บฑฑ
ฑฑบ          ณ				                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReimpPed(nPVSite, cNumPVP)

Local aArea 	:= GetArea()
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()
Local nRecRet	:= 0
Local lReimp	:= .F.

Default nPVSite	:= 0
Default cNumPVP	:= ""

//Guarda o recno inicial para ser restaurado posteriormente
nRecRet := ZC5->(Recno())

cQuery   := " SELECT * FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQuery   += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPVSite))+"' "+CRLF
cQuery   += " AND ZC5.ZC5_NUMPV = '"+cNumPVP+"' "+CRLF
cQuery   += " AND ZC5.ZC5_STATUS != '90'
cQuery   += " AND ZC5.ZC5_ESTORN = 'S' "+CRLF
cQuery   += " AND NOT EXISTS( SELECT * FROM "+RetSqlName("ZC5")+" ZC52 "+CRLF
cQuery   += "                 WHERE ZC52.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += "                 AND ZC52.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += "                 AND ZC52.ZC5_NUM = ZC5.ZC5_NUM "+CRLF
cQuery   += "                 AND ZC52.ZC5_PVVTEX = ZC5.ZC5_PVVTEX "+CRLF
cQuery   += "                 AND ZC52.ZC5_ESTORN != 'S' "+CRLF
cQuery   += "                 ) "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	
	If Aviso("Reimporta็ใo","Deseja reimportar o pedido "+Alltrim(Str((cArqTmp)->ZC5_NUM))+" ? ",{"Sim","Nใo"},2 ) == 1
		
		DbSelectArea("ZC5")
		DbSetOrder(1)
		Reclock("ZC5",.T.)   
		
		ZC5->ZC5_FILIAL := xFilial("ZC5")
		ZC5->ZC5_NUM 	:= (cArqTmp)->ZC5_NUM
		ZC5->ZC5_CLIENT := (cArqTmp)->ZC5_CLIENT
		ZC5->ZC5_LOJA 	:= (cArqTmp)->ZC5_LOJA
		ZC5->ZC5_STATUS := "4"//Pedido recebido
		ZC5->ZC5_TOTAL 	:= (cArqTmp)->ZC5_TOTAL
		ZC5->ZC5_QTDPAR := (cArqTmp)->ZC5_QTDPAR
		ZC5->ZC5_FRETE	:= (cArqTmp)->ZC5_FRETE
		ZC5->ZC5_CODENT	:= (cArqTmp)->ZC5_CODENT
		ZC5->ZC5_VDESCO	:= (cArqTmp)->ZC5_VDESCO
		ZC5->ZC5_PDESCO := (cArqTmp)->ZC5_PDESCO
		ZC5->ZC5_PREVEN := (cArqTmp)->ZC5_PREVEN
		ZC5->ZC5_ENDENT := (cArqTmp)->ZC5_ENDENT
		ZC5->ZC5_BAIROE := (cArqTmp)->ZC5_BAIROE
		ZC5->ZC5_CEPE 	:= (cArqTmp)->ZC5_CEPE
		ZC5->ZC5_MUNE 	:= (cArqTmp)->ZC5_MUNE
		ZC5->ZC5_CODMUE := (cArqTmp)->ZC5_CODMUE
		ZC5->ZC5_ESTE 	:= (cArqTmp)->ZC5_ESTE
		ZC5->ZC5_DTVTEX := (cArqTmp)->ZC5_DTVTEX
		ZC5->ZC5_PLATAF := (cArqTmp)->ZC5_PLATAF
		ZC5->ZC5_ORIGEM := (cArqTmp)->ZC5_ORIGEM
		ZC5->ZC5_CONDPG := (cArqTmp)->ZC5_CONDPG
		ZC5->ZC5_LJECOM := (cArqTmp)->ZC5_LJECOM
		ZC5->ZC5_EMAIL 	:= (cArqTmp)->ZC5_EMAIL
		
		ZC5->(MsUnLock())
		
		Aviso("Reimporta็ใo","Solicita็ใo de reimporta็ใo efetuada com sucesso. ",{"Ok"},2)
		lReimp	:= .T.
	EndIf
Else
	
	Aviso("NOEXISTE","Nใo existe pedido a ser reimportado",{"Ok"},2)
	
EndIf

//Restaura a posi็ใo anterior
ZC5->(DbGoTo(nRecRet))
If lReimp
	Reclock("ZC5",.F.)
	ZC5->ZC5_STATUS := "93"//Estornado
	ZC5->(MsUnLock())
EndIf


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaACbPedบAutor  ณElton C.	           บ	   Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณResumo do cabe็alho do pedido										  บฑฑ
ฑฑบ          ณ					                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaACbPed(cNumPedProt,cPvVtex)

Local aArea 	:= GetArea()
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()
Local aAcolsRt := {}

Default cNumPedProt := ""

cQuery   := " SELECT C5_CONDPAG, E4_DESCRI, C5_TABELA, C5_VEND1, "
cQuery   += "           A3_NOME, C5_DESPESA, C5_TPFRETE, C5_FRETE, C5_YCANAL, C5_YDCANAL FROM "+RetSqlName("SC5")+" SC5 "

cQuery   += "  INNER JOIN "+RetSqlName("SE4")+" SE4 "
cQuery   += "   ON SE4.D_E_L_E_T_ = ' ' "
cQuery   += "   AND SE4.E4_FILIAL = '"+xFilial("SE4")+"' "
cQuery   += "   AND SE4.E4_CODIGO = SC5.C5_CONDPAG "

cQuery   += "   INNER JOIN "+RetSqlName("SA3")+" SA3 "
cQuery   += "   ON SA3.D_E_L_E_T_ = ' ' "
cQuery   += "   AND SA3.A3_FILIAL = '"+xFilial("SA3")+"' "
cQuery   += "   AND SA3.A3_COD = SC5.C5_VEND1 "

cQuery   += "  WHERE SC5.D_E_L_E_T_ = ' ' "
cQuery   += "  AND SC5.C5_FILIAL = '"+xFilial("SC5")+"' "
cQuery   += "  AND SC5.C5_NUM = '"+cNumPedProt+"' "


cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

//Preenchimento do Acols
(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
	
	//Preenche o acols pv
	aAdd(aAcolsRt,;
	{(cArqTmp)->C5_CONDPAG,;
	(cArqTmp)->E4_DESCRI,;
	(cArqTmp)->C5_TABELA,;
	(cArqTmp)->C5_VEND1,;
	(cArqTmp)->A3_NOME,;
	(cArqTmp)->C5_DESPESA,;
	(cArqTmp)->C5_TPFRETE,;
	(cArqTmp)->C5_FRETE,;
	(cArqTmp)->C5_YCANAL,;
	(cArqTmp)->C5_YDCANAL;
	,.F.})
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aAcolsRt


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAItPedบAutor  ณElton C.	      บ	   Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณResumo dos itens do pedido											  บฑฑ
ฑฑบ          ณ				                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAItPed(cNumPedProt,cPvVtex)
Local aArea 	:= GetArea()
Local aAreaSC9 	:= SC9->(GetArea())
Local cArqTmp	:= GetNextAlias()
Local cQuery   	:= ""
Local aAcolsRt 	:= {}
Local cCor

Default cNumPedProt := ""

cQuery   := " SELECT ZC5_NUM, ZC5_NUMPV, C6_PRODUTO, C6_DESCRI, C6_QTDVEN, C6_PRCVEN,C6_ITEM,C6_VALOR, C6_PRCTAB, C6_TES, C0_QTDPED, ZC5_VDESCO, ZC5_PDESCO,C6_QTDRESE,ZC5_PVVTEX,ZC5_SEQUEN,ZC6_IDPROD ,C6_YPERVPC,C6_YVALVPC "
cQuery   += "  FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

cQuery   += "  INNER JOIN "+RetSqlName("SC6")+" SC6 "+CRLF
cQuery   += "  ON SC6.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += "  AND SC6.C6_FILIAL = ZC5.ZC5_FILIAL "+CRLF
cQuery   += "  AND SC6.C6_NUM = ZC5.ZC5_NUMPV "+CRLF

cQuery   += "  INNER JOIN "+RetSqlName("ZC6")+" ZC6 "+CRLF
cQuery   += "  ON ZC6.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += "  AND ZC6.ZC6_FILIAL = ZC5.ZC5_FILIAL "+CRLF
cQuery   += "  AND ZC6.ZC6_NUM = ZC5.ZC5_NUM "+CRLF
cQuery   += "  AND ZC6.ZC6_PLATAF = 'WM'"+CRLF
cQuery   += "  AND ZC6.ZC6_PRODUT = SC6.C6_PRODUTO "+CRLF


cQuery   += "  LEFT JOIN "+RetSqlName("SC0")+" SC0 "+CRLF
cQuery   += "  ON SC0.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += "  AND SC0.C0_FILIAL = SC6.C6_FILIAL  "+CRLF
cQuery   += "  AND SC0.C0_NUM = SC6.C6_NUM "+CRLF
cQuery   += "  AND SC0.C0_PRODUTO = SC6.C6_PRODUTO "+CRLF

cQuery   += "  WHERE ZC5.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += "  AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
cQuery   += "  AND ZC5.ZC5_NUMPV = '"+cNumPedProt+"' "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)


SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO


//Preenchimento do Acols
(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
	
	nQtdReserva:=(cArqTmp)->C6_QTDRESE
	If SC9->(MsSeek(xFilial("SC9")+(cArqTmp)->ZC5_NUMPV+(cArqTmp)->C6_ITEM))
		nQtdReserva:=SC9->C9_QTDRESE
	EndIf
	
	If nQtdReserva==0
		cCor:="BR_VERMELHO"
	ElseIf 	(cArqTmp)->C6_QTDVEN-nQtdReserva==0
		cCor:="BR_VERDE"
	Else
		cCor:="BR_AMARELO"
	EndIf
	
	//Preenche o acols pv
	aAdd(aAcolsRt,{;
	cCor,;
	Iif(!Empty((cArqTmp)->ZC5_PVVTEX),AllTrim((cArqTmp)->ZC5_PVVTEX)+"("+AllTrim((cArqTmp)->ZC5_SEQUEN)+")",(cArqTmp)->ZC5_NUM) ,;
	(cArqTmp)->ZC5_NUMPV,;
	(cArqTmp)->C6_PRODUTO,;
	(cArqTmp)->ZC6_IDPROD,;
	(cArqTmp)->C6_DESCRI,;
	(cArqTmp)->C6_QTDVEN,;
	nQtdReserva,;
	(cArqTmp)->C6_QTDVEN-nQtdReserva,;
	(cArqTmp)->C6_PRCVEN,;
	(cArqTmp)->C6_PRCVEN*nQtdReserva,;
	(cArqTmp)->C6_PRCTAB,;
	(cArqTmp)->C6_TES,;
	(cArqTmp)->ZC5_VDESCO,;
	(cArqTmp)->ZC5_PDESCO,;
	(cArqTmp)->C6_YPERVPC,;
	(cArqTmp)->C6_YVALVPC,;
	.F.})
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aAreaSC9)
RestArea(aArea)
Return aAcolsRt


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAItStบAutor  ณElton C.	      บ		 Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o acols com os itens solicitados no site				  บฑฑ
ฑฑบ          ณTabela ZC6                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAItSt(nPvSite, cArmPad,cPvVtex)
Local aArea 	:= GetArea()
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()
Local aAcolsRt 	:= {}

Default nPvSite := 0
Default cArmPad	:= ""


If !Empty(cPvVtex)
	cQuery   := " SELECT ZC6_NUM, ZC6_ITEM, ZC6_IDPROD,ZC6_PRODUT,ZC6_DESCRI, B1_XDESC, ZC6_QTDVEN, ZC6_VLRUNI, ZC6_VLRTOT, B1_XDESC, B1_MSBLQL, "
	cQuery   += "         B1_BLQVEND, (B2_QATU - B2_RESERVA - B2_QEMP) AS SALDO FROM "+RetSqlName("ZC6")+" ZC6 "
	cQuery   += " Left JOIN "+RetSqlName("SB1")+" SB1 "
	cQuery   += " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "
	cQuery   += " AND SB1.B1_COD = ZC6.ZC6_PRODUT "
	cQuery   += " AND SB1.D_E_L_E_T_ = ' ' "
	cQuery   += " Left JOIN "+RetSqlName("SB2")+" SB2 "
	cQuery   += " ON SB2.B2_FILIAL = '"+xFilial("SB2")+"' "
	cQuery   += " AND SB2.B2_COD =  ZC6.ZC6_PRODUT "
	cQuery   += " AND SB2.B2_LOCAL = '"+cArmPad+"' "
	cQuery   += " AND SB2.D_E_L_E_T_ = ' ' "
	cQuery   += " WHERE ZC6.ZC6_FILIAL = '"+xFilial("ZC6")+"' "
	cQuery   += " AND ZC6.ZC6_PVVTEX = '"+cPvVtex+"' "
	cQuery   += " AND ZC6.D_E_L_E_T_ = ' ' "
Else
	
	cQuery   := " SELECT ZC6_NUM, ZC6_ITEM, ZC6_PRODUT, B1_XDESC, ZC6_QTDVEN, ZC6_VLRUNI, ZC6_VLRTOT, B1_XDESC, B1_MSBLQL, "
	cQuery   += "         B1_BLQVEND, (B2_QATU - B2_RESERVA - B2_QEMP) AS SALDO FROM "+RetSqlName("ZC6")+" ZC6 "
	
	cQuery   += " INNER JOIN "+RetSqlName("SB1")+" SB1 "
	cQuery   += " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "
	cQuery   += " AND SB1.B1_COD = ZC6.ZC6_PRODUT "
	cQuery   += " AND SB1.D_E_L_E_T_ = ' ' "
	
	cQuery   += " INNER JOIN "+RetSqlName("SB2")+" SB2 "
	cQuery   += " ON SB2.B2_FILIAL = '"+xFilial("SB2")+"' "
	cQuery   += " AND SB2.B2_COD =  ZC6.ZC6_PRODUT "
	cQuery   += " AND SB2.B2_LOCAL = '"+cArmPad+"' "
	cQuery   += " AND SB2.D_E_L_E_T_ = ' ' "
	
	cQuery   += " WHERE ZC6.ZC6_FILIAL = '"+xFilial("ZC6")+"' "
	
	cQuery   += " AND ZC6.ZC6_NUM = '"+Alltrim(Str(nPvSite))+"' "
	cQuery   += " AND ZC6.ZC6_PLATAF = 'WM' "
	cQuery   += " AND ZC6.D_E_L_E_T_ = ' ' "
EndIf
cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

//Preenchimento do Acols
(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
	
	//Preenche o acols pv
	aAdd(aAcolsRt,{})
	aAux:=aAcolsRt[Len(aAcolsRt)]
	AADD(aAux,(cArqTmp)->ZC6_NUM)
	AADD(aAux,(cArqTmp)->ZC6_ITEM)
	AADD(aAux,(cArqTmp)->ZC6_PRODUT)
	AADD(aAux,(cArqTmp)->B1_XDESC)
	If !Empty(cPvVtex)
		AADD(aAux,(cArqTmp)->ZC6_IDPROD)
		AADD(aAux,(cArqTmp)->ZC6_DESCRI)
	EndIf
	AADD(aAux,(cArqTmp)->ZC6_QTDVEN)
	AADD(aAux,(cArqTmp)->SALDO)
	AADD(aAux,(cArqTmp)->ZC6_VLRUNI)
	AADD(aAux,(cArqTmp)->ZC6_VLRTOT)
	AADD(aAux,(cArqTmp)->B1_MSBLQL)
	AADD(aAux,(cArqTmp)->B1_BLQVEND)
	AADD(aAux,.F.)
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aAcolsRt


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVisNfDevบAutor  ณElton C.	       บ	   Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVisualiza nota fiscal de devolu็ใo	                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VisNfDev(cDoc, cSerie, cClient, cLoja)
Local aArea := GetArea()

Default cDoc	:= ""
Default cSerie	:= ""
Default cClient	:= ""
Default cLoja	:= ""

DbSelectArea("SF1")
DbSetOrder(1)

If !Empty(cDoc) .And. !Empty(cSerie)
	If SF1->(DbSeek(xFilial("SF1") + PADR(cDoc,TAMSX3("F1_DOC")[1]) + PADR(cSerie, TAMSX3("F1_SERIE")[1]);
		+ PADR(cClient,TAMSX3("F1_FORNECE")[1]) + PADR(cLoja,TAMSX3("F1_LOJA")[1]) ))
		
		//Chama a rotina para visualizar a Nota Fiscal de Saida
		A103NFiscal("SF1",SF1->(Recno()),2)
	Else
		Aviso("Nใo encontrado", "Nota fiscal nใo encontrada "+cDoc+"/"+cSerie, {"Ok"},2)
	EndIf
	
Else
	Aviso("Nใo encontrado", "Nใo existe nota fiscal de devolu็ใo", {"Ok"},2)
EndIf

RestArea(aArea)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVisNfsบAutor  ณElton C.	         บ	   Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVisualiza nota fiscal de vendas		                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VisNfs(cDoc, cSerie, cClient, cLoja)
Local aArea := GetArea()

Default cDoc	:= ""
Default cSerie	:= ""
Default cClient	:= ""
Default cLoja	:= ""

DbSelectArea("SF2")
DbSetOrder(1)

If !Empty(cDoc) .And. !Empty(cSerie)
	If SF2->(DbSeek(xFilial("SF2") + PADR(cDoc,TAMSX3("F2_DOC")[1]) + PADR(cSerie, TAMSX3("F2_SERIE")[1]);
		+ PADR(cClient,TAMSX3("F2_CLIENTE")[1]) + PADR(cLoja,TAMSX3("F2_LOJA")[1]) ))
		
		//Chama a rotina para visualizar a Nota Fiscal de Saida
		Mc090Visual("SF2",SF2->(Recno()),2)
	Else
		Aviso("Nใo encontrado", "Nota fiscal nใo encontrada "+cDoc+"/"+cSerie, {"Ok"},2)
	EndIf
	
Else
	Aviso("Nใo encontrado", "Nใo existe nota fiscal gerada", {"Ok"},2)
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetStsPd	  บAutor  ณElton C.		  บ Data ณ  28/01/14   	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descri็ใo do Status										  บฑฑ
ฑฑบ			 ณ    			     														  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStsPd(cStatus)

Local aArea := GetArea()
Local cRet	:= ""

Default cStatus := ""

DbSelectArea("SX5")
DbSetOrder(1)
If SX5->(DbSeek(xFilial("SX5") + "_Z" + cStatus ) )
	cRet	:= Alltrim(cStatus) +"-"+Alltrim(SX5->X5_DESCRI)
EndIf

RestArea(aArea)
Return cRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณMenuDef   ณ Autor ณ Microsiga             ณ Data ณ00/00/0000ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Utilizacao de menu Funcional                               ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณArray com opcoes da rotina.                                 ณฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function MenuDef()
Local aBtnFil	:= {}
Local aRotina := {}


AAdd(aRotina, {"&Pesquisar"		,"AxPesqui"  	,0,1})
AAdd(aRotina, {"&Monitor"		, "U_WM002Mon"	,0,2})
AAdd(aRotina, {"&Legenda"		, "U_WM002Leg"	,0,8})
AAdd(aRotina, {"&Gravar PV"		, "U_M08WMCOM(ZC5->ZC5_NUM) "	,0	,8})
AAdd(aRotina, {"&Tracking Vendedor"		, "U_NCGPR138(ZC5_NUMPV)"	,0	,8})

Return(aRotina)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณManClientบAutor  ณElton C.         บ	   Data ณ  02/2014    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณChama a rotina para manuten็ใo do cliente                	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ManClient(cCodCli, cLoja)

Local aArea	:= GetArea()
Local nOpc	:= 1
Local aButtons  := {{"POSCLI",{|| a450F4Con()},/*STR0017*/ }}
Local aRotAtual	:=aClone(aRotina)
Local aAreaAtu	:=GetArea()

Private cCadastro := "Clientes"
Private aRotAuto	:= {}

Default cCodCli 	:= ""
Default cLoja 		:= ""

_SetOwnerPrvt("aRotAuto")
_SetOwnerPrvt("CCADASTRO","Cadastro de Cliente")

aRotina := { 	{"Pesquisar","PesqBrw"    , 0 , 1,0 ,.F.},;
{"Visualizar", "A030Visual" , 0 , 2,0   , NIL},;
{"Incluir", "A030Inclui" , 0 , 3,81  , NIL},;
{"Alterar", "AxAltera" , 0 , 4,143 , NIL},;
{"Excluir", "A030Deleta" , 0 , 5,144 , NIL}}


If !Empty(cCodCli) .And. !Empty(cLoja)
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	If SA1->(DbSeek(xFilial("SA1") + cCodCli + cLoja ))
		
		nOpc := Aviso("Cadastro de Cliente","O que deseja fazer no cadastro de cliente ? ",;
		{"Visualizar","Alterar","Sair"})
		
		If nOpc == 1//Visualizar
			INCLUI:=.F.
			ALTERA:=.F.
			LJMsgRun("Aguarde o processamento...","Aguarde...",{|| A030Visual("SA1",SA1->(Recno()),2) })
			
		ElseIf nOpc == 2//Alterar
			INCLUI := .F.
			ALTERA := .T.
			LJMsgRun("Aguarde o processamento...","Aguarde...",{|| AxAltera("SA1",SA1->(Recno()),4) })
		EndIf
		
	Else
		Aviso("Cliente nใo encontrado","Cliente nใo encontrado para o c๓digo \ loja: "+cCodCli+"\"+cLoja, {"Ok"},2)
	EndIf
Else
	Aviso("Campo obrigat๓rio","C๓digo do Cliente ou Loja, nใo preenchido ", {"Ok"},2)
EndIf



aRotina:=aClone(aRotAtual)
RestArea(aAreaAtu)
RestArea(aArea)

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณEnvPvWms ณ Autor ณ Microsiga             ณ Data ณ00/00/0000ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Rotina utilizada para enviar pedido para o WMS             ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณArray com opcoes da rotina.                                 ณฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function EnvPvWms(nPedSite, cNumPed, cStatus)
Local aArea := GetArea()
Local nHDL
Local cArqSemaforo:="EnvPvWms_"+cNumPed

Default nPedSite	:= 0
Default cNumPed 	:= ""
Default cStatus	:= ""

Conout(ProcName(0)+"-Linha:"+StrZero(ProcLine(),5 )  )


If !Empty(cNumPed)
	
	If !VeriEnvWMS(cNumPed)
		
		Conout(ProcName(0)+"-Linha:"+StrZero(ProcLine(),5 )  )
		
		If Aviso("Alerta","Deseja enviar o pedido para o WMS ?", {"Sim","Nใo"}) == 1
			
			AtualizaZC6(nPedSite)
			
			If !U_Semaforo(.T.,@nHdl,cArqSemaforo)
				Return
			EndIf
			
			Conout(ProcName(0)+"-Linha:"+StrZero(ProcLine(),5 )  )
			EnvWMS(cNumPed)
			
			If VeriEnvWMS(cNumPed)
				Aviso("Envio para WMS","Pedido enviado para o WMS. ",{"Ok"},2)				//Chama a rotina de atualiza็ใo de log do monitor
				Conout(ProcName(0)+"-Linha:"+StrZero(ProcLine(),5 )  )
				U_NCECOM09(nPedSite, cNumPed,"Envio para WMS","Pedido enviado para o WMS com sucesso.","",.T.,,,ZC5->ZC5_PVVTEX)
			Else
				Aviso("Erro no enviao WMS","Nใo foi possํvel enviar o pedido para o WMS. Verifique se o mesmo estแ apto a ser enviado.",{"Ok"},2)
			EndIf
			
			U_Semaforo(.F.,nHdl,cArqSemaforo)
			
		EndIf
		
	Else
		Aviso("Pedido existente","Pedido existente no WMS.",{"Ok"},2)
	EndIf
	
Else
	Aviso("Envio para WMS","Nใo foi possํvel enviar o pedido para o WMS. "+CRLF;
	+"Verifique se o pedido foi gerado no sistema Protheus e\ou estแ com o cr้dito aprovado (Status = 10)",{"Ok"},2)
EndIf




RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvWMS			บAutor  ณElton C.		  บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia o pedido para o WMS							  				  บฑฑ
ฑฑบ          ณ	                                           					  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function EnvWMS(cNumPv)
Local aArea 	:= GetArea()
Local aAreaSC5 := SC5->(GetArea())

Local cBody		:= ""
Local cToLoja	:= ""
Local cAssunto := ""
Local cErro		:= ""

Default cNumPv := ""

U_COM08GRAVA("VERIFICA_PAGAMENTO")//Efetua a libera็ใo do pedido

If !VerifSC9(cNumPv,.F.,.F.)
	MsgStop("Nใo foi possํvel realizar a libera็ใo do Pedido de Venda.")
ElseIf VerifSC9(cNumPv,.T.,.F.)
	U_WM001PcLog(,ZC5->ZC5_NUM,"F","Pedido em analise do cr้dito")
	U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido em analise de Cr้dito.","",ZC5->ZC5_STATUS,.f.,,,ZC5->ZC5_PVVTEX)
	
	If ZC5->ZC5_PLATAF == "WM"
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_FLAG := '1'
		ZC5->(MsUnLock())
		
		cBody 	:= U_ECOMHTMI(ZC5->(Recno()),.t.)
		cToLoja	:= 'lfelipe@ncgames.com.br' //inserir MV - Alltrim(U_MyNewSX6("VT_000007","rciambarella@ncgames.com.br","C","E-mail do responsav้l financeiro Vtex","","",.F. ))
		cAssunto	:= "Pedido de loja aguardando anแlise de cr้dito."
		If !U_COM08SEND(cAssunto, cBody, , cToLoja,, @cErro)
			U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,'Erro ao enviar e-mail para '+ cToLoja,cErro,ZC5->ZC5_STATUS,.T.)
		EndIf
	EndIf
	
Else
	SC5->(DbSetOrder(1))
	SC5->(MsSeek(xFilial("SC5")+cNumPv ))
	U_WM001StatPV(ZC5->ZC5_NUMPV,ZC5->ZC5_NUM,.T.,.F.)
	ConfEnvWMS()//Envia para o WMS
EndIf




RestArea(aAreaSC5)
RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerifSC9บAutor  ณElton C.			  บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o pedido jแ foi liberado							 บฑฑ
ฑฑบ          ณ	                                        					 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VerifSC9(cNumPv,lBlqCred,lBlqEst)
Local aArea 	:= GetArea()
Local lRet		:= .F.
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cNumPv := ""
Default lBlqCred:=.F.
Default lBlqEst:=.F.

cQuery	:= " SELECT COUNT(*) CONTPED FROM "+RetSqlName("SC9")+CRLF
cQuery	+= " WHERE C9_FILIAL = '"+xFilial("SC9")+"' "+CRLF
cQuery	+= " AND C9_PEDIDO = '"+cNumPv+"' "+CRLF

If lBlqCred
	cQuery	+= " AND C9_BLCRED in ('01','02','04','06') "+CRLF  //01–Bloq p/cr้d,02-MV_BLQCRED = t, 04-Lim de Cr้d Vencido, 05-Bloq Cr้d por Estorno, 06–por risco, 09-Rejeitado
EndIf


If lBlqEst
	cQuery	+= " AND C9_BLEST='02' "+CRLF
EndIf

cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	If (cArqTmp)->CONTPED > 0
		lRet := .T.
	EndIf
EndIf

(cArqTmp)->(DbCloseArea())


RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVeriEnvWMSบAutor  ณElton C.		  บ   Data ณ  02/2014     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o pedido foi enviado para o WMS  				  บฑฑ
ฑฑบ          ณ	                                           				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VeriEnvWMS(cNumPVP)

Local aArea 		:= GetArea()
Local cQuery   	:= ""
Local cArqTmp		:= GetNextAlias()
Local lRet			:= .F.

Default cNumPVP	:= ""

cQuery   := " SELECT COUNT(*) CONTPED FROM "+RetSqlName("P0A")+" P0A  "+CRLF
cQuery   += " WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"' "+CRLF
cQuery   += " AND P0A.P0A_CHAVE = '"+xFilial("ZC5")+Alltrim(cNumPVP)+"' "+CRLF
cQuery   += " AND P0A.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	If (cArqTmp)->CONTPED > 0
		lRet := .T.
	EndIf
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuReservaบAutor  ณElton C.		  บ   Data ณ  02/2014  	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para atualiza็ใo da reserva do pedido	  บฑฑ
ฑฑบ          ณ	                                           				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑlogฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuReserva(nPedSite, cNumPed, cStatus,cPvVtex)

Local aArea 		:= GetArea()
Local cMsgLog  	:= ""
Local aStatus		:= {}
Local lReservTd   := .F.

Default nPedSite	:= 0
Default cNumPed	:= ""
Default cStatus	:= ""

If !Empty(cNumPed) .And. (Alltrim(cStatus) $ "4|5|10" ) .And. (!VeriEnvWMS(cNumPed))
	
	DbSelectArea("SC5")
	DbSetOrder(1)
	If SC5->(DbSeek(xFilial("SC5") + cNumPed  ))
		
		If Aviso("Alerta","Deseja atualizar a reserva ?", {"Sim","Nใo"}) == 1
			//Chama a rotina para atualizar a reserva.
			//Essa rotina efetua o cancelamento da reserva e gera novamente com o saldo disponivel atualmente do produto
			U_NC110MTA410()
			AtualizaZC6(ZC5->ZC5_NUM)
			
			//Verifica se a reserva foi efetuada ap๓s a atualiza็ใo
			aStatus 		:= GetStReserv(cNumPed)//Chama a rotina para verificar os itens reservados
			cMsgLog 		:= aStatus[1]//Log de processamento
			lReservTd   := aStatus[2]//Verifica se a reserva foi efetuada parcialemnte ou reserva total do pedido
			
			If !Empty( SC5->C5_BLQ )//Verifica se o pedido esta bloqueado por regra
				
				If lReservTd//Verifica se o pedido foi reservado totalmente para efetuar a libera็ใo de regra
					
					//Chama a rotina para efetuar a lilibera็ใo de regra
					MaAvalSC5( 'SC5', 9 )
					
					If Empty( SC5->C5_BLQ )
						//Chama a rotina de atualiza็ใo de log do monitor
						U_NCECOM09(nPedSite, cNumPed,"Libera็ใo de regra","Libera็ใo de regra efetuada com sucesso. "+CRLF+"O pedido estแ completo (Todos os itens reservados) para envio ao WMS. ","",.T.,,,cPvVtex)
						U_NCEC10CI(nPedSite, "014",ZC5->ZC5_PVVTEX)//Libera็ใo de regra
					Else
						//Chama a rotina de atualiza็ใo de log do monitor
						U_NCECOM09(nPedSite, cNumPed,"Erro na Libera็ใo de regra","Erro ao efetuar a libera็ใo de regra ","",.T.,,,cPvVtex)
					EndIf
					Aviso("Log de processamento", cMsgLog, {"Ok"},3)
				Else
					
					If Aviso("Libera็ใo de regra","O estoque ้ insuficiente para atender o pedido, deseja efetuar a libera็ใo parcial do pedido ? (Libera็ใo de regra) "+CRLF+CRLF+cMsgLog,{"Sim","Nใo"},3) == 1
						
						If Aviso("Aten็ใo","O pedido serแ liberado para faturamento apenas com os produtos disponํveis em estoque.  Deseja continuar ?",{"Sim","Nใo"},2) == 1
							//Chama a rotina para efetuar a lilibera็ใo de regra
							MaAvalSC5( 'SC5', 9 )
							//Chama a rotina de atualiza็ใo de log do monitor
							U_NCECOM09(nPedSite, cNumPed,"Libera็ใo de regra","Libera็ใo de regra efetuada com sucesso. (Pedido atendido parcialmente) "+CRLF+cMsgLog,"",.T.)
						EndIf
						
					EndIf
				EndIf
				
			EndIf
			//Chama a rotina de atualiza็ใo de log do monitor
			U_NCECOM09(nPedSite, cNumPed,"Atualiza็ใo de reserva"," Log da atualiza็ใo: "+CRLF+cMsgLog,"",.T.)
			
		EndIf
	EndIf
	
Else
	Aviso("Atualiza็ใo de reserva ","Nใo existe reserva para atualizar. ",{"Ok"},2)
EndIf

RestArea(aArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetStReservบAutor  ณElton C.	  บ   Data ณ  02/2014  		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para atualiza็ใo da reserva do pedido		  บฑฑ
ฑฑบ          ณ	                                           				  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStReserv(cNumPV)

Local aArea 	:= GetArea()
Local cMsg		:= ""
Local aRet		:= {"",""}
Local cMsgAux	:= "Segue os produtos com estoque insuficiente: "+CRLF+CRLF
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()

Default  cNumPV := ""

cQuery   := " SELECT C6_NUM, C0_NUM, C6_PRODUTO, C0_PRODUTO, C6_QTDVEN, C0_QTDPED,C0_QTDPED FROM "+RetSqlName("SC6")+" SC6 "+CRLF

cQuery   += " LEFT JOIN "+RetSqlName("SC0")+" SC0 "+CRLF
cQuery   += " ON SC0.C0_FILIAL = SC6.C6_FILIAL "+CRLF
cQuery   += " AND SC0.C0_NUM = SC6.C6_NUM "+CRLF
cQuery   += " AND SC0.C0_PRODUTO = SC6.C6_PRODUTO "+CRLF
cQuery   += " AND SC0.D_E_L_E_T_ = ' ' "+CRLF


cQuery   += " WHERE  SC6.C6_FILIAL = '"+xFilial("SC6")+"' "+CRLF
cQuery   += " AND SC6.C6_NUM = '"+cNumPV+"' "+CRLF
cQuery   += " AND SC6.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

While (cArqTmp)->(!Eof())
	
	//Verifica se a reserva esta diferente do pedido
	If (cArqTmp)->C6_QTDVEN != (cArqTmp)->C0_QTDPED
		cMsg += (cArqTmp)->C6_PRODUTO+" - Qtd. Pedido: "+Alltrim(Str((cArqTmp)->C6_QTDVEN))+" - Qtd. Reservada: "+Alltrim(Str((cArqTmp)->C0_QTDPED))+CRLF
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo


If !Empty(cMsg)
	
	cMsg := cMsgAux + cMsg +CRLF+CRLF+"Usuแrio: "+UsrFullName( RetCodUsr())+CRLF+"Data: "+DTOC(MsDate())+CRLF+"Hora: "+Time()
	aRet := {cMsg,.F.}
Else
	cMsg := "Reserva efetuada com sucesso. "+CRLF+CRLF+"Usuแrio: "+UsrFullName( RetCodUsr())+CRLF+"Data: "+DTOC(MsDate())+CRLF+"Hora: "+Time()
	aRet := {cMsg,.T.}
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return aRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณConfEnvWMS  บAutor  ณMicrosiga         บ Data ณ  03/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina efetuiva o Envio para o WMS                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                               	                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ConfEnvWMS()

U_Z7Status(SC5->C5_FILIAL,SC5->C5_NUM,"000002","PEDIDO LIBERADO POR VENDAS",SC5->C5_CLIENTE)
U_MT450FIM(SC5->C5_NUM)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCECFL11  บAutor  ณMicrosiga         บ Data ณ  03/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina efetuiva o Envio para o WMS                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                               	                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function WM002Fil(cOpc,aParametros)

Local aArea 		:= GetArea()
Local cFiltro  	:= ""
Local cFilAux		:= ""

Local nDias			:= U_MyNewSX6(	"EC_NCG0012","2","N","Numeros de dias de antecedencia para envio de WF de expira็ใo data de entrega","","N",.F. )

If !empty(aParametros[1])
	If aParametros[1] == '01'
		cFiltro  	+= " AND ZC5_CLIENT IN ('009137','005003')"
	ElseIf aParametros[1] == '02'
		cFiltro  	+= " AND ZC5_CLIENT IN ('000090')"
	EndIf
EndIf


If cOpc == "1"	//Todos
	cFiltro  	+= " "
	
ElseIf cOpc == "2"// Pedido aguardando aprova็ใo de credito
	cFiltro  	+= " AND ZC5_FLAG = '1' AND ZC5_STATUS NOT IN('30','90','91','93','96') "
	
ElseIf cOpc == "3"// Pedido liberado s/ nota fiscal
	cFiltro  	+= " AND ZC5_STATUS >= '10' AND ZC5_NOTA = ' ' AND ZC5_STATUS NOT IN('30','90','91','93','96') "
	
ElseIf cOpc == "4" //Estoque insuficiente
	cFiltro  	+= " AND ZC5_CODINT = '003' AND ZC5_STATUS NOT IN('10','15','16','30','90','91','93','96')"
	
ElseIf cOpc == "5" //Pre Venda
	cFiltro  	+= " AND ZC5_PREVEN = 'S' AND ZC5_STATUS NOT IN('30','90','91','93','96') "
	
ElseIf cOpc == "6" //Pv.Exp. Aguardando Envio
	cFiltro  	+= " AND ZC5_STATUS = '15' "
	
ElseIf cOpc == "7" //PV Cancelado
	cFiltro  	+= " AND ZC5_STATUS = '90' "
	
ElseIf cOpc == "8"// Pedido reprovado no credito
	cFiltro  	+= " AND ZC5_STATUS = '96' "
	
ElseIf cOpc == "9" //PV Entregue
	cFiltro  	+= " AND ZC5_STATUS = '30' "
	
EndIf


RestArea(aArea)
Return cFiltro


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  02/17/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFil(aParams)

Local llRet			:= .T.
Local aParamBox	:= {}
Local aFilt			:= {}
Local aLojas		:= {}


AADD(aLojas,"00=Todos")
AADD(aLojas,"01=Pr๓prias")
AADD(aLojas,"02=Franquias")

aAdd(aParamBox,{2,"Loja"			,"1"	, aLojas	,80,".T."					,.F.})

AADD(aFilt,"1=Todos")
AADD(aFilt,"2=PV aguardando aprova็ใo de credito")
AADD(aFilt,"3=PV liberado s/ nota fiscal")
AADD(aFilt,"4=Estoque insuficiente")
AADD(aFilt,"5=PV Pre Venda")
AADD(aFilt,"6=Pv.Exp.Aguardando Envio")
AADD(aFilt,"7=PV Cancelado")
AADD(aFilt,"8=PV reprovado no credito")
AADD(aFilt,"9=PV Entregue")

aAdd(aParamBox,{2,"Filtro"			,"1"	, aFilt	, 120,".T."					,.F.})


llRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/,.T.,.T.)

Return llRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  02/17/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function WM002WMS()
Local dData:=Ctod("  /  /    ")
Local cQuery:=""

If Empty(clUserBd)
	clUserBd := U_MyNewSX6(	"NCG_000019",	"", "C", 	"Usuแrio para acessar a base do WMS",	"Usuแrio para acessar a base do WMS",	"Usuแrio para acessar a base do WMS",	.F. )
EndIf


If !Empty(ZC5->ZC5_NUMPV)
	cQuery:=" select to_char(dt_add, 'YYYYMMDD') DataADD"
	cQuery+=" from "+clUserBd+".tb_wmsinterf_doc_saida"
	cQuery+=" where dpcs_num_documento='"+ZC5->ZC5_NUMPV+"'"
	cQuery+=" and dpcs_cod_chave='"+xFilial("ZC5")+ZC5->ZC5_NUMPV+"'"
	cQuery+=" and dpcs_serie_documento='PED'"
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"Data_WMS", .F., .F.)
	dData:=stod(Data_WMS->DataADD)
	Data_WMS->(DbCloseArea())
EndIf

DbSelectArea("ZC5")
Return dData

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  02/17/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DelZC6(cPvVtex)
Local aAreaAtu	:=GetArea()
Local aAreaZC6	:=ZC6->(GetArea())
Local cChaveZC6:=xFilial("ZC6")+cPvVtex

ZC6->(DbSetOrder(3))//ZC6_FILIAL+ZC6_PVVTEX
ZC6->(DbSeek(cChaveZC6))
Do While ZC6->(!Eof()) .And. ZC6->(ZC6_FILIAL+ZC6_PVVTEX)==cChaveZC6
	ZC6->(RecLock("ZC6",.F.))
	ZC6->(DbDelete())
	ZC6->(MsUnLock())
	ZC6->(DbSkip())
EndDo

RestArea(aAreaZC6)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWM002  บAutor  ณMicrosiga           บ Data ณ  03/18/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtualizaZC6(nPedWM)
Local aAreaAtu:=GetArea()
Local aAreaZC6:=ZC6->(GetArea())
Local aAreaSC0:=SC0->(GetArea())
Local cChaveZC6:=xFilial("ZC6")+AllTrim(Str(nPedWM))
Local nTotal   :=0
Local cUpdate
Local oConectDB	:= U_DBWebManager() //Funcao encontrada no NCIWMF02      
Local lConectou	:=oConectDB:OpenConnection()

SC0->(DbSetOrder(1))//C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
ZC6->(DbSetOrder(1))//ZC6_FILIAL+ZC6_NUM+ZC6_ITEM
ZC6->(MsSeek( cChaveZC6 ))

Do While ZC6->(!Eof()) .And. ZC6->(ZC6_FILIAL+AllTrim(Str(ZC6_NUM)))==cChaveZC6
	
	ZC6->(RecLock("ZC6",.F.))
	ZC6->ZC6_QTDRES:=0
	If SC6->( DbSeek(xFilial("SC6")+SC5->C5_NUM+ZC6->(ZC6_ITEM+ZC6_PRODUTO)   ) ) .And.   SC0->( DbSeek( xFilial("SC0") +SC6->(C6_RESERVA+C6_PRODUTO+C6_LOCAL)   )   )
		ZC6->ZC6_QTDRES:=SC0->C0_QTDPED
		ZC6->ZC6_VLRUNI:=SC6->C6_PRCVEN
	EndIf
	
	If lConectou
		cUpdate:=" UPDATE 	[dbo].[Pedido_hex]"+CRLF
		cUpdate+=" SET 		[Qtde_atendida] = "+AllTrim(Str(ZC6->ZC6_QTDRES))+CRLF
		cUpdate+="  	   ,[Valor_atendido] = "+AllTrim(Str(ZC6->(ZC6_VLRUNI*ZC6_QTDRES)))+CRLF
		cUpdate+=" WHERE	[Cod_pedido] = "+AllTrim(Str(nPedWM))+CRLF
		cUpdate+=" And		[Cod_produto] = "+AllTrim(ZC6->ZC6_IDPROD)+CRLF
		U_WM001Exec(cUpdate,oConectDB)
	EndIf
	nTotal+=ZC6->(ZC6_VLRUNI*ZC6_QTDRES)
	ZC6->(MsUnLock())
	
	ZC6->(DbSkip())
EndDo

If lConectou
	cUpdate:="UPDATE [dbo].[Pedido]"+CRLF
	cUpdate+="   SET [Total_atendido] = "+AllTrim(Str(nTotal))+CRLF
	cUpdate+=" WHERE [Cod_pedido] = "+AllTrim(Str(nPedWM))+CRLF
EndIf
U_WM001Exec(cUpdate,oConectDB)

oConectDB:CloseConnection()
oConectDB:Finish()

RestArea(aAreaZC6)
RestArea(aAreaSC0)
RestArea(aAreaAtu)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Ec11Danfe
// Fun็ใo que irแ imprimir a Danfe dos pedidos Ecommerce diretamente no monitor Ticket#4148
//
// @author    Lucas Felipe
// @version   1.00
// @since     12/02/2015
/*/
//------------------------------------------------------------------------------------------
Static Function Ec11Danfe(cNota,cSerieNf,cCliente,cCliLoja)

Local aAreatu		:= GetArea()
Local aAreaSF2	:= SF2->(GetArea())

Local nTentativa	:= 3

Local cDirDanfe	:= "C:\relatorios" //Alltrim(U_MyNewSX6("NCG_000081","C:\relatorios","C","Diretorio onde a Danfe serแ salva","","",.F. ))
Local cPathPDF	:= cDirDanfe+"\"
Local cEndArq		:= "DANFE\"
Local cDirSystem	:= GetTempPath()

Local lOKWebService
Local cModalidade
Local cVersao
Local cVersaoDpec

Local lAdjustToLegacy
Local lDisableSetup

Local oPrinter
Local oWS

Private cIdEnt
Private cUrl	:= AllTrim(PadR(GetNewPar("MV_SPEDURL","http://"),250))

If !Empty(cNota)
	
	If !IsReady()
		Return
	EndIf
	
	If Right(cDirSystem,1) <> "\"
		cDirSystem += "\"
	EndIf
	
	MakeDir(cDirSystem + cEndArq)
	MakeDir(cPathPDF)
	
	If Empty( cIdEnt:=GetIdEnt() )
		Return
	EndIf
	
	If !Empty(cIdEnt)
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem o ambiente de execucao do Totvs Services SPED                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		oWS := WsSpedCfgNFe():New()
		oWS:cUSERTOKEN 		:= "TOTVS"
		oWS:cID_ENT    		:= cIdEnt
		oWS:nAmbiente  		:= 0
		oWS:_URL       		:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
		lOKWebService 		:= oWS:CFGAMBIENTE()
		cAmbiente 				:= oWS:cCfgAmbienteResult
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem a modalidade de execucao do Totvs Services SPED                   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:nModalidade	:= 0
			oWS:cModelo	   	:= "55"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService 	:= oWS:CFGModalidade()
			cModalidade    	:= oWS:cCfgModalidadeResult
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem a versao de trabalho da NFe do Totvs Services SPED                ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:cVersao    	:= "0.00"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService  	:= oWS:CFGVersao()
			cVersao        	:= oWS:cCfgVersaoResult
		EndIf
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:cVersao    	:= "0.00"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService		:= oWS:CFGVersaoDpec()
			cVersaoDpec	   	:= oWS:cCfgVersaoDpecResult
		EndIf
		
	Endif
	
	SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	If SF2->(MsSeek(xFilial("SF2")+cNota+cSerieNf+cCliente+cCliLoja))
		
		oWS:= WSNFeSBRA():New()
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:_URL       := AllTrim(cURL)+"/NFeSBRA.apw"
		
		If lOKWebService
			
			lPrinter	:= .F.
			nContar	:= 1
			
			IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
			
			oWS:cIdInicial := SF2->F2_SERIE+SF2->F2_DOC
			oWS:cIdFinal   := SF2->F2_SERIE+SF2->F2_DOC
			
			Do While ++nContar<nTentativa
				IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
				
				lOk 		:= oWS:MONITORFAIXA()
				oRetorno 	:= oWS:oWsMonitorFaixaResult
				cStatus		:= GetStatus(oRetorno)
				
				If Left(cStatus,3)=="001"
					lPrinter:=.T.;Exit
				ElseIf Left(cStatus,3)=="014" //014 - NFe nใo autorizada
					lPrinter:=.F.;MsgAlert(cStatus);Exit
				ElseIf "029 - Falha no Schema do XML"$cStatus
					lPrinter:=.F.;MsgAlert(cStatus);Exit
				ElseIf Left(cStatus,4)=="ERRO"
					lPrinter:=.F.;Exit
				EndIf
				
				Sleep(3000)
			EndDo
			
			If lPrinter
				
				IncProc("Imprimindo DANFE Nota  "+SF2->F2_DOC)
				
				cNameArq := 	SM0->(Alltrim(M0_CODIGO)+Alltrim(M0_CODFIL))+SF2->F2_DOC+SF2->F2_SERIE;
				+	Alltrim(Str(Randomize(00,10)));
				+	Alltrim(Str(Randomize(11,20)));
				+	Alltrim(Str(Randomize(21,30)));
				+	Alltrim(Str(Randomize(31,40)));
				+	Alltrim(Str(Randomize(41,50)));
				+	Alltrim(Str(Randomize(51,60)));
				+ ".REL"
				
				lAdjustToLegacy := .F.
				lDisableSetup  := .T.
				
				//oPrinter := FWMsPrinter():New(cNameArq,IMP_PDF,.F.,,.F.,.F.,Nil,,.T.,.F.,.F.,.T.,001)
				oPrinter 	:= FWMSPrinter():New(cNameArq,IMP_PDF,lAdjustToLegacy, ,lDisableSetup)
				
				oPrinter:SetResolution(78)
				oPrinter:SetPortrait()
				oPrinter:SetPaperSize(DMPAPER_A4)
				oPrinter:SetMargin(60,60,60,60)
				oPrinter:cPathPDF := cDirSystem + cEndArq
				
				Pergunte(Padr("NFSIGW",Len(SX1->X1_GRUPO)),.F.)
				
				MV_PAR01 := SF2->F2_DOC
				MV_PAR02 := SF2->F2_DOC
				MV_PAR03 := SF2->F2_SERIE
				MV_PAR04 := 2// Nota de Saida
				MV_PAR05 := 2//Danfe Simplificado ?
				MV_PAR06 := 2//Imprime no verso?
				
				U_PrtNfeSef(cIdEnt,/*cVal1*/,/*cVal2*/,oPrinter,/*oSetup*/,cNameArq)
				oPrinter:=Nil
				
				
			EndIf
		EndIf
	EndIf
Else
	
	MsgAlert("Nใo existe nota fiscal")
	
EndIf


RestArea(aAreaSF2)
RestArea(aAreatu)

Return .T.

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} IsReady
// Fun็ใo que irแ conectar com Sped para a confirma็ใo que o servi็o estแ ativo
//
// Fun็ใo utilizada no programa NcgPr118(GATI)
//
// @author    Lucas Felipe
// @version   1.00
// @since     12/02/2015
/*/
//------------------------------------------------------------------------------------------

Static Function IsReady(cURL,nTipo,lHelp)

Local nX       := 0
Local cHelp    := ""
Local oWS
Local lRetorno := .F.

Default nTipo := 1
Default lHelp := .F.

If !Empty(cURL) .And. !PutMV("MV_SPEDURL",cURL)
	RecLock("SX6",.T.)
	SX6->X6_FIL     := xFilial( "SX6" )
	SX6->X6_VAR     := "MV_SPEDURL"
	SX6->X6_TIPO    := "C"
	SX6->X6_DESCRIC := "URL SPED NFe"
	MsUnLock()
	PutMV("MV_SPEDURL",cURL)
EndIf

SuperGetMv() //Limpa o cache de parametros - nao retirar

Default cURL      := PadR(GetNewPar("MV_SPEDURL","http://"),250)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o servidor da Totvs esta no ar                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWs := WsSpedCfgNFe():New()
oWs:cUserToken := "TOTVS"
oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"

If oWs:CFGCONNECT()
	lRetorno := .T.
Else
	If lHelp
		//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
	EndIf
	lRetorno := .F.
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o certificado digital ja foi transferido                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipo <> 1 .And. lRetorno
	oWs:cUserToken := "TOTVS"
	oWs:cID_ENT    := GetIdEnt()
	oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWs:CFGReady()
		lRetorno := .T.
	Else
		If nTipo == 3
			cHelp := IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3))
			If lHelp .And. !"003" $ cHelp
				//Aviso("SPED",cHelp,{"Ok"},3)
				lRetorno := .F.
			EndIf
		Else
			lRetorno := .F.
		EndIf
	EndIf
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o certificado digital ja foi transferido                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipo == 2 .And. lRetorno
	oWs:cUserToken := "TOTVS"
	oWs:cID_ENT    := GetIdEnt()
	oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWs:CFGStatusCertificate()
		If Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE) > 0
			For nX := 1 To Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE)
				If oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nx]:DVALIDTO-30 <= Date()
					
					//Aviso("SPED","O certificado digital irแ vencer em: "+Dtoc(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nX]:DVALIDTO),{"Ok"},3) //"O certificado digital irแ vencer em: "
					
				EndIf
			Next nX
		EndIf
	EndIf
EndIf

Return(lRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  02/12/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetIdEnt(lHelp)
Local aArea  := GetArea()
Local cIdEnt := ""
Local oWs
Default lHelp:=.F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem o codigo da entidade                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""
oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
ElseIf lHelp
	//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
EndIf

RestArea(aArea)
Return(cIdEnt)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  02/12/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStatus(oRetorno)
Local cRecomendacao:="ERRO. Nใo foi possivel identificar o erro. Verifque via Monitor NFE"

For nX := 1 To Len(oRetorno:oWSMONITORNFE)
	oXml := oRetorno:oWSMONITORNFE[nX]
	cRecomendacao:=oXml:CRECOMENDACAO
Next nX

Return cRecomendacao

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  03/03/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ec11Canc(cNumPV)

Local aAreaAtu	:= GetArea()
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaSC9 := SC9->(GetArea())
Local aAreaSC6 := SC6->(GetArea())
Local aAreaSB2 := SB2->(GetArea())
Local aAreaSA1 := SA1->(GetArea())

Local lRet 		:= .T.

SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SB2->(dbSetOrder(1))
SA1->(dbSetOrder(1))

If SC5->(MsSeek(xFilial("SC5")+cNumPV))
	
	If Empty(SC5->C5_NOTA)
		
		If SC9->(MsSeek(xFilial("SC9")+SC5->C5_NUM ))
			Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==xFilial("SC9")+SC5->C5_NUM
				SC9->(a460Estorna(.T.))
				lRet := .T.
				SC9->(DbSkip())
			EndDo
		EndIf
		
		If lRet
			
			U_NC110Del(cNumPV)
			
			If SC6->( MsSeek(xFilial("SC6")+SC5->C5_NUM  ))
				
				Do While SC6->(!Eof() ) .And. SC6->( C6_FILIAL+C6_NUM==xFilial("SC6")+ SC5->C5_NUM )
					
					SB2->(MsSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL))
					
					SB2->(RecLock("SB2",.F.))
					SB2->B2_QPEDVEN -= Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0)
					SB2->B2_QPEDVE2 -= ConvUM(SB2->B2_COD, Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0), 0, 2)
					If ( SC6->C6_OP$"01#03#05" )
						SB2->B2_QEMPN  -= SC6->C6_QTDVEN
						SB2->B2_QEMPN2 -= ConvUM(SB2->B2_COD, SC6->C6_QTDVEN, 0, 2)
					Endif
					
					SB2->(MsUnLock())
					
					If !SC5->C5_TIPO$'DB'
						SA1->(MsSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA))
						SA1->(RecLock("SA1",.F.))
						nMCusto		:= If(SA1->A1_MOEDALC > 0, SA1->A1_MOEDALC, Val(GetMv("MV_MCUSTO")))
						SA1->A1_SALPED -= xMoeda(Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0)*SC6->C6_PRCVEN,SC5->C5_MOEDA,nMCusto,SC5->C5_EMISSAO)
						SA1->(MsUnLock())
					EndIf
					
					SC6->(RecLock("SC6",.F.))
					
					SC6->C6_BLQ := "R"
					
					SC6->(MsUnLock())
					
					SC6->(DbSkip())
					
				EndDo
			EndIf
			
			lret :=	MaLiberOk({SC5->C5_NUM}, .T.)
			
		EndIf
	EndIf
EndIf

RestArea(aAreaSA1)
RestArea(aAreaSB2)
RestArea(aAreaSC6)
RestArea(aAreaSC9)
RestArea(aAreaSC5)
RestArea(aAreaAtu)

Return lret

