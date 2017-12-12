#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"

Static cFiltro := ""
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Hermes Ferreira     � Data �  10/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina manual de aprova��o/reprova��o de al�ada de t�tulo do���
���          �tipo NCC e a pagar que estejam relacionado a um VPC/VERBA   ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NCGWF103()

Local aCores		:= {}
Local aAreaX3		:= SX3->(GetArea())
Local nInterval	:= 60*1000//Em milisegundos

Private aRotina	:= MenuDef()
Private cCadastro	:= "Aprova��o de Al�adas"
Private cUserLog	:= Alltrim(__cUserId)
Private aFixes		:= {}
Private cMark		:= GetMark()
Private lInverte  := .F.
Private alCampos  := {}

//ErrorBlock( { |oErro| MySndError(oErro) } )



dbSelectArea("SX3")
dbSetOrder(2)

aCores := {	 {"P0B->P0B_STATUS == '01' "	,"BR_AMARELO"   };
,{"P0B->P0B_STATUS == '02' "	,"BR_LARANJA"	};
,{"P0B->P0B_STATUS == '03' "	,"BR_AZUL"		};
,{"P0B->P0B_STATUS == '04' "	,"BR_VERDE"		};
,{"P0B->P0B_STATUS == '05' "	,"BR_VERMELHO"	}}



dbSelectArea("P0B")
P0B->(dbSetOrder(1))

//If SX3->(dbSeek( "P0B_FILIAL" ))
//	AADD(aFixes, {SX3->X3_TITULO,"P0B_FILIAL"})
//EndIf

If SX3->(dbSeek( "P0B_PEDIDO" ))
	AADD(aFixes, {"Pedido","P0B_PEDIDO"   })
EndIf

If SX3->(dbSeek( "P0B_STATUS" ))
	AADD(aFixes, {"Status"+Space(20), {|| P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""))) ) )  }  })
EndIf

If SX3->(dbSeek( "P0B_CODCLI" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CODCLI" })
EndIf

If SX3->(dbSeek( "P0B_LOJA" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_LOJA" })
EndIf

If SX3->(dbSeek( "P0B_NOMECL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMECL" })
EndIf


If SX3->(dbSeek( "P0B_CODVEN" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CODVEN" })
EndIf

If SX3->(dbSeek( "P0B_NOVEND" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOVEND" })
EndIf

If SX3->(dbSeek( "P0B_CANAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CANAL" })
EndIf

If SX3->(dbSeek( "P0B_DCANAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DCANAL" })
EndIf


If SX3->(dbSeek( "P0B_EMIPED" ))
	AADD(aFixes, {"Emissao PV","P0B_EMIPED" })
EndIf

If SX3->(dbSeek( "P0B_EMISSA" ))
	AADD(aFixes, {"Inicio Aprov","P0B_EMISSA" })
EndIf

If SX3->(dbSeek( "P0B_USER" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_USER"  })
EndIf

If SX3->(dbSeek( "P0B_NOMAPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMAPR"})
EndIf
If SX3->(dbSeek( "P0B_DTLIB" ))
	AADD(aFixes, {"Dt. Aprovacao","P0B_DTLIB" })
EndIf

If SX3->(dbSeek( "P0B_DTREPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DTREPR"  })
EndIf

If SX3->(dbSeek( "C5_YTOTLIQ" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YTOTLIQ"  ),AvSx3("C5_YTOTLIQ",6) )  }   })
EndIf

If SX3->(dbSeek( "C5_YPERLIQ" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERLIQ"  ),AvSx3("C5_YPERLIQ",6) )  }   })
EndIf


If SX3->(dbSeek( "C5_YLUCRBR" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YLUCRBR"  ),AvSx3("C5_YLUCRBR",6) )  }   })
EndIf


If SX3->(dbSeek( "C5_YPERRBR" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERRBR"  ),AvSx3("C5_YPERRBR",6) )  }   })
EndIf


If SX3->(dbSeek( "C5_YACORDO" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YACORDO"  ),AvSx3("C5_YACORDO",6) )  }   })
EndIf

If SX3->(dbSeek( "C5_DESC2" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_DESC2"  ),AvSx3("C5_DESC2",6) )  }   })
EndIf



//Cria o array com os campos que ser�o apresentados na markbrowse1

AADD(alCampos,{"P0B_OK"		,Nil,"Sele��o",""})
AADD(alCampos,{"P0B_PEDIDO",Nil,"Pedido",""})
If SX3->(dbSeek( "P0B_STATUS" ))
	AADD(alCampos,{{|| IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""))))) },Nil,"Status"+Space(20)})
EndIf
AADD(alCampos,{"P0B_CODCLI",Nil,"Cliente",""})
AADD(alCampos,{"P0B_LOJA"	,Nil,"Loja",""})
AADD(alCampos,{"P0B_NOMECL",Nil,"Nome Cliente",""})
AADD(alCampos,{"P0B_CODVEN",Nil,"C�d. Vendedor",""})
AADD(alCampos,{"P0B_NOVEND",Nil,"Nome Vendedor",""})
AADD(alCampos,{"P0B_CANAL"	,Nil,"Canal",""})
AADD(alCampos,{"P0B_DCANAL",Nil,"Desc. Canal",""})
AADD(alCampos,{"P0B_EMIPED",Nil,"Emissao PV",""})
AADD(alCampos,{"P0B_EMISSA",Nil,"Inicio Aprov",""})
AADD(alCampos,{"P0B_NOMAPR",Nil,"Aprovador",""})
AADD(alCampos,{"P0B_DTLIB"	,Nil,"Dt. Aprovacao",""})
AADD(alCampos,{"P0B_DTREPR",Nil,"Dt. Reprov.",""})

If SX3->(dbSeek( "C5_YTOTLIQ" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YTOTLIQ"),AvSx3("C5_YTOTLIQ",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YPERLIQ" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERLIQ"),AvSx3("C5_YPERLIQ",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YLUCRBR" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YLUCRBR"),AvSx3("C5_YLUCRBR",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YPERRBR" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERRBR"),AvSx3("C5_YPERRBR",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YACORDO" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YACORDO"),AvSx3("C5_YACORDO",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_DESC2" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_DESC2" ),AvSx3("C5_DESC2",6))},Nil,SX3->X3_TITULO })
EndIf

U_F103Filtro()


MarkBrow( 'P0B',"P0B_OK",,alCampos,lInverte,cMark,,,,,,,cFiltro,,aCores)
//mBrowse( 6, 1,22,75,'P0B',aFixes,,,,, aCores,,,,,,,,cFiltro, nInterval,{|| U_WF103Timer()  }) Substituida pelo MarkBrow


SX3->(RestArea(aAreaX3))


Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MenuDef   �Autor  �Hermes Ferreira     � Data �  03/10/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Menu da rotina de cadastro                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MenuDef()

Local alRotina := { {"Pesquisar"	,"AxPesqui"			,0,1} ,;
{"Visualizar"						,"U_WF103ATU()"	,0,2} ,;
{"Analisar"							,"U_WF103ATU(1)"	,0,4} ,;
{"Observa��o"						,"U_WF103OBS()"	,0,4} ,;
{"Marcar Todos"						,"U_W103MAll(cMark,'M')"	,0,7} ,;
{"Desmarcar Todos"					,"U_W103MAll(cMark,'D')"	,0,7} ,;
{"Aprovar"							,"U_WF103Apr(1)"	,0,4} ,;
{"Reprovar"							,"U_WF103Apr(2)"	,0,4} ,;
{"Aprova��o em Massa"				,"U_wf103ApMas('A')"	,0,4} ,;
{"Reprova��o em Massa"				,"U_wf103ApMas('R')"	,0,4} ,;
{"Analise Margem Liquida"			,"U_WF103PV(1)"	,0,2} ,;
{"Observa��es sobre a Aprova��o"	,"U_WF103PV(2)"	,0,2} ,;
{"Legenda"							,"U_WF103LEG()"	,0,2} }

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

Return alRotina

User Function WF103OBS()
Local cMemoObs := ""

If !Empty(P0B->P0B_CODOBS)
	cMemoObs := Msmm(P0B->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, ) //+ CRLF + (cAlias)->(MEMO)
	Aviso("NCGCD102 - 15",@cMemoObs,{"Ok"},3,"Observa��o",,,.T.)
Else
	MsgAlert("N�o h� observa��es para esta al�ada.")
EndIf
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF103ATU  �Autor  �Hermes		         � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o processo de al�ada. Aprova ou reprova uma al�ada ���
���          �de VPC / VERBA                                              ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WF103ATU(nOpc)

Local aAreaP0b 		:= P0B->(GetArea())
Local nRet			:= 2
Default	nOpc		:= 0

//ErrorBlock( { |oErro| U_MySndError(oErro) } )


If !P0B->P0B_USER == Alltrim(cUserLog)
	Aviso("NCGWF103 - 02","S� permitido analise pelo aprovador "+UsrFullName(P0B->P0B_USER)+".",{"Ok"},3)
	Return
EndIf

If nOpc > 0
	
	If P0B->P0B_STATUS == '01'
		If AllTrim(P0B->P0B_TABORI) == "SC5"
			nRet := MkTelaWF2(nOpc)
		Else
			nRet := MnTelaWF2(nOpc)
		EndIf
	Else
		Aviso("NCGWF103 - 01","S� permitido aprovar/reprovar caso esteja aguardando alguma a��o para seu usu�rio.",{"Ok"},3)
	EndIf
	
Else
	MkTelaWF2(nOpc)
EndIf

RestArea(aAreaP0b)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MkTelaWF2 �Autor  �Alberto Kibino      � Data �  03/01/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Tela de aprova��o/Reprova��o de uma al�ada de P&L     	  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MkTelaWF2(nOpc)

Local oFont01   	:=TFont():New( "Courier New",,20,,.F.,,,20,,,,,,,,)
Local cTitulo		:= "Tela para "+IIf(nOpc == 1, "Aprovar",(IIF(nOpc == 2,"Reprovar","")))+" Al�ada."
Local alPosCab		:= {}
Local alPosTot		:= {}
Local nlResoluc		:= oMainWnd:nClientWidth
Local alCoord		:= MsAdvSize(.T.,.F.,0)
Local aButtons		:= {}
Local aCamposV		:= {}
Local aCamposTot	:= {}
Local alCmpAlt		:= {}
Local alPrc			:= {}
Local odlgCab		:= Nil
Local odlgPed		:= Nil
Local oEncCab		:= Nil
Local olOdlg		:= Nil
Local olGridPed
Local nRet			:= 2
Local cTabOrig		:= P0B->P0B_TABORI
Local cPreCampo		:= Right(cTabOrig,2)
Local _CodVPC		:= ""
Local _VERVPC		:= ""
Local aVlrPedido	:= {}

Private aTela[0][0]
Private aGets[0]
Private aHeadPed := {}
Private aColsPed := {}


Private opLayer		:= FWLayer():New()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

dbSelectArea(cTabOrig)
&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))

If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
	_CodVPC  := ""
	_VERVPC  := ""
	
	
	
	alPrc			:= {40,45,15}
	
	
	
	// Campos que ser�o exibidos a Enchoice
	/*
	AADD(aCamposV,"P0B_NOMAPR"	)
	AADD(aCamposV,"P0B_PEDIDO"	)
	AADD(aCamposV,"P0B_CODCLI"	)
	AADD(aCamposV,"P0B_LOJA"	)
	AADD(aCamposV,"P0B_NOMECL"	)
	AADD(aCamposV,"P0B_NREDUZ"	)
	AADD(aCamposV,"P0B_CONDPAG"	)
	AADD(aCamposV,"P0B_DESPAG"	)
	AADD(aCamposV,"P0B_VEND1"	)
	AADD(aCamposV,"P0B_NVEND1"	)
	AADD(aCamposV,"P0B_CONDPAG"	)
	AADD(aCamposV,"P0B_DESPAG"	)
	AADD(aCamposV,"P0B_CANAL"	)
	AADD(aCamposV,"P0B_DCANAL"	)
	AADD(aCamposV,"P0B_VLRLIQ"	)
	AADD(aCamposV,"P0B_MRGLIQ"	)
	AADD(aCamposV,"P0B_TOTPED"	)
	AADD(aCamposV,"P0B_TOTDES"	)
	AADD(aCamposV,"P0B_VLRPED"	)
	
	
	AADD(aCamposV,"NOUSER"		)
	*/
	RegToMemory("SC5", .F.)
	
	/*
	M->P0B_NOMAPR	:= Posicione("P09",1,xFilial("P09")+P0B->P0B_APROV,"P09_NOME")
	M->P0B_PEDIDO	:= SC5->C5_NUM
	M->P0B_CODCLI	:= SC5->C5_CLIENTE
	M->P0B_LOJA		:= SC5->C5_LOJACLI
	DbSelectarea("SA1")
	DbSetOrder(1)
	If SA1->(DbSeek(xFilial("SA1") + SC5->C5_CLIENTE + SC5->C5_LOJACLI))
	M->P0B_NOMECL	:= SA1->A1_NOME
	M->P0B_NREDUZ	:= SA1->A1_NREDUZ
	EndIf
	M->P0B_VEND1	:= SC5->C5_VEND1
	M->P0B_NVEND1	:= Posicione("SA3",1,xFilial("SA3")+SC5->C5_VEND1,"A3_NOME")
	M->P0B_CONDPAG	:= SC5->C5_CONDPAG
	M->P0B_DESPAG	:= Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_DESCRI")
	M->P0B_CANAL	:= SC5->C5_YCANAL
	M->P0B_DCANAL	:= SC5->C5_YDCANAL
	M->P0B_VLRLIQ	:= SC5->C5_YVLRLIQ
	M->P0B_MRGLIQ	:= SC5->C5_YTOTLIQ
	*/
	
	olOdlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)
	
	opLayer:Init(olOdlg,.F.)
	
	opLayer:AddCollumn("CENTRO"	,100,.F.)
	
	opLayer:AddWindow("CENTRO","CABEC"					,"Analise"	,alPrc[1],.T.,.T.,{||},,{||})
	odlgCab	:= opLayer:GetWinPanel("CENTRO","CABEC")
	
	alPosCab	:= {0,0,0,0}
	
	//oEncCab:= MSMGet():New("P0B",,IIF(nOpc >0 ,4 ,2 ),,,,aCamposV,alPosCab,,,,,,odlgCab,,,,,,,,,,,,.T.)
	oEncCab:= MSMGet():New("SC5",,    2                  ,,,,,/*alPosCab*/,,,,,,odlgCab,,,.f.         ,         ,             ,             ,          ,           ,           ,                 ,           ,.F.)
	//	MsmGet():          New (00s],, < nOpc>           ,,,,, [ aPos],,,,,,oWnd   ,,, [ lColumn], [ caTela], [ lNoFolder], [ lProperty], [ aField], [ aFolder], [ lCreate], [ lNoMDIStretch], [ uPar25] ) -->
	
	oEncCab:oBox:Align := CONTROL_ALIGN_ALLCLIENT
	//oEncCab:SetFocus ("M->C5_YACORDO")
	
	If Alltrim(P0B->P0B_TIPO) == "PAL"
		
		opLayer:AddWindow("CENTRO","PEDIDOS"			,"Itens Pedido"													,alPrc[2],.T.,.T.,{||},,{||})
		odlgPed	:= opLayer:GetWinPanel("CENTRO","PEDIDOS")
		
		aVlrPedido := FHeadPedv2(SC5->C5_NUM)
		//M->P0B_TOTPED	:= aVlrPedido[1]
		//M->P0B_TOTDES	:= aVlrPedido[2]
		//M->P0B_VLRPED	:= aVlrPedido[1] - aVlrPedido[2]
		
		
		olGridPed:= MsNewGetDados():New(0,0,0,0,1,"AllWaysTrue()","AllWaysTrue()","",,,9999,"AllWaysTrue()",,,odlgPed,aHeadPed,aColsPed)
		olGridPed:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
		olGridPed:lInsert := .F.
		
		If Len(aColsPed) == 0
			olGridPed:aCols:= aColsPed
		EndIf
		
	EndIf
	
	opLayer:AddWindow("CENTRO","BOTOES"			,"BOTOES"													,alPrc[3],.T.,.T.,{||},,{||})
	odlgBut	:= opLayer:GetWinPanel("CENTRO","BOTOES")
	
	nButoCol:=0
	If nOpc==1
		oButton2	:= tButton():New(0000, nButoCol, "Aprovar"  , oDlgBut, {|| /*FGRVWF2(nOpc,MsAuto2Ench("SC5")),*/u_NCGATPED("A"), olOdlg:End() }, 0040, 0015, , , , .T.)
		nButoCol+=60
		oButton3	:= tButton():New(0000, 0060, "Reprovar" , oDlgBut, {|| /*FGRVWF2(nOpc,MsAuto2Ench("SC5")),*/u_NCGATPED("R"), olOdlg:End() }, 0040, 0015, , , , .T.)
		nButoCol+=60
	EndIf
	oButton4	:= tButton():New(0000, nButoCol, "Sair"  	, oDlgBut, {|| /*FGRVWF2(nOpc,MsAuto2Ench("SC5")),*/ olOdlg:End() }, 0040, 0015, , , , .T.)
	
	//tButton():New(0000, 0000, "Confirmar", oDlg6  , {|| _RM_TRANSPO := oGrid:aCols[oGrid:nAt][ aScan( oGrid:aHeader,{|x| Alltrim(x[2]) == "TRA_CODI"} ) ], oGetTransp:Refresh(), oDlg8:End() }, 0000, 0000, , , , .T.)
	//oButton2:Align 		:= CONTROL_ALIGN_ALLCLIENT
	@ 00000,200 	SAY "Valor Bruto " + AllTrim(Transform (aVlrPedido[1], "@E 999,999,999.99")) OF oDlgBut PIXEL SIZE 100,09 SHADED
	@ 00000,350 	SAY "Valor Desconto " + AllTrim(Transform (aVlrPedido[2], "@E 999,999,999.99")) OF oDlgBut PIXEL SIZE 100,09 SHADED
	@ 00000,500 	SAY "Valor Valor Liquido " + AllTrim(Transform (aVlrPedido[1]-aVlrPedido[2], "@E 999,999,999.99")) OF oDlgBut PIXEL SIZE 100,09 SHADED
	//M->P0B_TOTPED	:= aVlrPedido[1]
	//M->P0B_TOTDES	:= aVlrPedido[2]
	//M->P0B_VLRPED	:= aVlrPedido[1] - aVlrPedido[2]
	//oMySLayer:AddCollumn("RODAPE"	,0020,.F.)
	//oMySLayer:AddWindow("RODAPE","BOTAO","Cancelar"	,100,.T.,.T.,{||},,{||})
	
	Activate Msdialog olOdlg Centered /*On Init EnchoiceBar(olOdlg,;
	{|| IIF (Iif(nOpc > 0,Obrigatorio(aGets,aTela),.T.),  (FGRVWF2(nOpc,MsAuto2Ench("P0B")),olOdlg:End(), nRet := 1 )    ,Nil)   },;
	{|| olOdlg:End(),nRet := 2 };
	,,aButtons) 	*/
	
Else
	
	Aviso("NCGWF103 - 02","N�o foi localizado o pedido deste processo de al�ada. Verifique se o pedido n�o foi exclu�do.",{"Ok"},3)
	
EndIf

Return nRet


User Function NCGATPED(cChose,lShow,cObservacao)
Local cMemoObs		:= ""
Local llNextNivel := .F.
Local llMesmoNivel:= .F.
Local aAreaAux 	:= {}
Local cTipoAlc		:= P0B->P0B_TIPO
Local cNumDoc		:= P0B->P0B_NUM
Local cNivel		:= P0B->P0B_NIVEL
Local cTabOrig		:= P0B->P0B_TABORI
Local cCodUser		:= P0B->P0B_USEORI
Local cNomeUser   := UsrFullName(P0B->P0B_USER)
Local lIncMemo		:= .F.
Local nRecno		:= P0B->(Recno())


Local alArea := P0B->(GetArea())
//ErrorBlock( { |oErro| U_MySndError(oErro) } )


Default lShow:=.T.
Default cObservacao:=""

If P0B->P0B_STATUS<>'01'      
	If lShow
		MsgStop(UsrFullName(P0B->P0B_USER)+"-Pedido "+P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""	 ))))))
	EndIf	
	Return
EndIf
If lShow
	
	If !Empty(P0B->P0B_CODOBS)
		cMemoObs := Msmm(P0B->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, ) //+ CRLF + (cAlias)->(MEMO)
	EndIf
	
	If Aviso("NCGWF103 - 15",@cMemoObs,{"Sim","N�o"},3,"Confirma "+IIf(cChose == "R","Reprova��o","Aprova��o")+" do Pedido "+P0B->P0B_PEDIDO,,,.T.) == 1
		lIncMemo := .T.
	Else
		lIncMemo := .F.
	EndIf
Else
	cMemoObs :=cObservacao
	lIncMemo := .T.
EndIf

If !lIncMemo
	P0B->(RestArea(alArea))
	Return
EndiF


If cChose == "R"
	P0B->(RecLock("P0B",.F.))
	P0B->P0B_STATU1 := 'R'         //adicionado para atender a solicita��o de rastreabilidade do Nelson
	P0B->P0B_DTLIB1 := MSDate()
	P0B->P0B_HRLIB  := Time()
	P0B->(MsUnLock())
	DbSelectArea("P0B")
	DbSetOrder(1) //	P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
	If dbSeek(xfilial("P0B") + cTipoAlc + cNumDoc)
		While AllTrim(cNumDoc) == AllTrim(P0B->P0B_NUM) .And. !P0B->(EOF())
			
			P0B->(RecLock("P0B",.F.))
			
			P0B->P0B_STATUS := '05'
			P0B->P0B_DTREPR	:= MsDate()
			
			P0B->(MsUnLock())
			If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
				If Empty(P0B->P0B_CODOBS)
					P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
				Else
					MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
				EndIf
			EndIf
			
			P0B->(dbSkip())
		EndDo
		
		
		P0B->(MsUnlock())
		
		P0B->(DbGoTo(nRecno))
		
		dbSelectArea(cTabOrig)
		&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))
		If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
			
			If &(cTabOrig)->(RecLock(cTabOrig,.F.))
				
				If cTabOrig == "SE1"
					
					SE1->E1_YBLQVPC	:= 'N'
					
				ElseIf cTabOrig == "SE2"
					
					SE2->E2_DATALIB	:= MSDate()
				ElseIf cTabOrig == "SC5"
					SC5->C5_YBLQPAL := "R"
					SC5->C5_YSTATUS := "07"
					SC5->C5_YAPROV	:="Pedido com Margem Reprovada "//cNomeUser
					P0B->(EnvMailStatus(Posicione("P09",1,xFilial("P09")+P0B_APROV,"P09_EMAIL"),"Retorno da aprova��o da Margem do Pedido de venda: "+ P0B_NUM,"Reprovado",P0B_PEDIDO))
					If lShow
						MsgAlert("Pedido Reprovado","Pedido")
					EndIf
				EndIf
				
				&(cTabOrig)->(MsUnLock())
				
			EndIf
			
		EndIf
		
	EndIf
Else
	
	llMesmoNivel := ExstMemNiv(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
	
	If llMesmoNivel // Agurada aprova��o mesmo nivel
		
		P0B->(RecLock("P0B",.F.))
		
		P0B->P0B_STATUS := '02'
		If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
			If Empty(P0B->P0B_CODOBS)
				P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
			Else
				MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
			EndIf
		EndIf
		
		P0B->(MsUnLock())
		
	Else // Proximo Nivel
		
		llNextNivel := GetNextNivel(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
		
		If llNextNivel
			
			aAreaAux := P0B->(GetArea())
			
			P0B->(RecLock("P0B",.F.))
			
			P0B->P0B_STATUS := '03'
			P0B->P0B_STATU1 := 'A'
			P0B->P0B_DTLIB1 := MSDate()
			P0B->P0B_HRLIB  := Time()
			
			P0B->(MsUnLock())
			// Atualiza todos os status no mesmo n�vel
			P0B->(dbSetOrder(1))
			P0B->(dbGoTop())
			P0B->(dbSeek(xFilial("P0B")+cTipoAlc+cNumDoc+cNivel))
			
			While P0B->(!Eof()) .AND. cTipoAlc+cNumDoc+cNivel == P0B->(P0B_TIPO+P0B_NUM+P0B_NIVEL)
				
				P0B->(RecLock("P0B",.F.))
				P0B->P0B_STATUS := '03'
				
				If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
					If Empty(P0B->P0B_CODOBS)
						P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
					Else
						MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
					EndIf
				EndIf
				P0B->(MsUnLock())
				P0B->(dbSkip())
				
			EndDo
			
			RestArea(aAreaAux)
			
			
		Else // N�o tem mais n�veis
			
			aAreaAux := P0B->(GetArea())
			
			P0B->(dbGoTop())
			P0B->(dbSetOrder(1))
			
			If P0B->(dbSeek(xFilial("P0B")+ cTipoAlc +cNumDoc))
				
				While P0B->(!Eof()) .AND. cNumDoc == P0B->P0B_NUM
					
					P0B->(RecLock("P0B",.F.))
					
					P0B->P0B_STATUS := '04'
					P0B->P0B_DTLIB	 := dDataBase
					P0B->P0B_STATU1 := 'A'
					P0B->P0B_DTLIB1 := MSDate()
					P0B->P0B_HRLIB  := Time()
					If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
						If Empty(P0B->P0B_CODOBS)
							P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
						Else
							MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
						EndIf
					EndIf
					
					P0B->(MsUnLock())
					
					P0B->(dbSkip())
					
				EndDo
				
			EndIf
			
			RestArea(aAreaAux)
			
			// Libera o Pedido
			
			P0B->(DbGoTo(nRecno))
			
			dbSelectArea(cTabOrig)
			
			&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))
			If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
				
				If &(cTabOrig)->(RecLock(cTabOrig,.F.))
					
					If cTabOrig == "SE1"
						
						SE1->E1_YBLQVPC	:= 'N'
						
					ElseIf cTabOrig == "SE2"
						
						SE2->E2_DATALIB	:= MSDate()
					ElseIf cTabOrig == "SC5"
						SC5->C5_YBLQPAL := "A"
						SC5->C5_YSTATUS := "06"
						SC5->C5_YAPROV	:=cNomeUser
						SC5->C5_YULTMAR := Round(SC5->C5_YPERLIQ,2)
						//SC5->C5_YULTMAR :=SC5->C5_YMAPROV
					EndIf
					
					&(cTabOrig)->(MsUnLock())
					
				EndIf
				
			EndIf
			
		EndIf
		
	EndIf
	If lShow
		MsgAlert("Pedido Aprovado", "Pedido")
	EndIf
	
EndIf


P0B->(RestArea(alArea))

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FHeadPedv2�Autor  �Alberto Kibino      � Data �  03/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta o Header dos pedidos de vendas                        ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FHeadPedv2(cPedido)

Local aCmpHeader	:= {}
Local cAlias		:= GetNextAlias()
Local cSql			:= ""
Local aRetorno		:= {}
Local lQuery		:= .F.
Local cQuery		:= ""
Local cSeek  := ""
Local bWhile := {}
Local bCond     := {|| .T. }
Local cArqQry  := "SC6"
Local nTotPed  := 0
Local nTotDes	:= 0
Local lGrade   := MaGrade()
Local bAction1  := {|| Mta410Vis(cArqQry,@nTotPed,@nTotDes,lGrade) }
Local bAction2  := {|| .T. }
Local aNoFields := {"C6_NUM","C6_QTDEMP","C6_QTDENT","C6_QTDEMP2","C6_QTDENT2"}		// Campos que nao devem entrar no aHeader e aCols

Private aCols	:= {}
Private aHeader := {}

//������������������������������������������������������Ŀ
//� Cria Ambiente/Objeto para tratamento de grade        �
//��������������������������������������������������������
If FindFunction("MsMatGrade") .And. IsAtNewGrd()
	PRIVATE oGrade	  := MsMatGrade():New('oGrade',,"C6_QTDVEN",,"a410GValid()",;
	{ 	{VK_F4,{|| A440Saldo(.T.,oGrade:aColsAux[oGrade:nPosLinO][aScan(oGrade:aHeadAux,{|x| AllTrim(x[2])=="C6_LOCAL"})])}} },;
	{ 	{"C6_QTDVEN",NIL,NIL},;
	{"C6_QTDLIB",NIL,NIL},;
	{"C6_QTDENT",NIL,NIL},;
	{"C6_ITEM"	,NIL,NIL},;
	{"C6_UNSVEN",NIL,NIL},;
	{"C6_OPC",NIL,NIL},;
	{"C6_BLQ",NIL,NIL}})
	
	//-- Inicializa grade multicampo
	A410InGrdM()
Else
	PRIVATE aColsGrade:= {}
	PRIVATE aHeadGrade:= {}
EndIf

//ErrorBlock( { |oErro| U_MySndError(oErro) } )
DbSelectArea("SC6")
DbSetORder(1)

If SC6->(FieldPos("C6_CODLAN"))>0 .and. !SuperGetMV("MV_CAT8309",,.F.)
	aAdd(aNoFields,"C6_CODLAN")
EndIf
#IFDEF TOP
	lQuery  := .T.
	cQuery := "SELECT * "
	cQuery += "FROM "+RetSqlName("SC6")+" SC6 "
	cQuery += "WHERE SC6.C6_FILIAL='"+xFilial("SC6")+"' AND "
	cQuery += "SC6.C6_NUM='"+cPedido+"' AND "
	cQuery += "SC6.D_E_L_E_T_<>'*' "
	cQuery += "ORDER BY "+SqlOrder(SC6->(IndexKey()))
	
	dbSelectArea("SC6")
	dbCloseArea()
#ENDIF
cSeek  := xFilial("SC6")+SC5->C5_NUM
bWhile := {|| C6_FILIAL+C6_NUM }



//�������������������������������������������������������Ŀ
//� Montagem do aHeader e aCols                           �
//���������������������������������������������������������
//������������������������������������������������������������������������������������������������������������Ŀ
//�FillGetDados( nOpcx, cAlias, nOrder, cSeekKey, bSeekWhile, uSeekFor, aNoFields, aYesFields, lOnlyYes,       �
//�				  cQuery, bMountFile, lInclui )                                                                �
//�nOpcx			- Opcao (inclusao, exclusao, etc).                                                         �
//�cAlias		- Alias da tabela referente aos itens                                                          �
//�nOrder		- Ordem do SINDEX                                                                              �
//�cSeekKey		- Chave de pesquisa                                                                            �
//�bSeekWhile	- Loop na tabela cAlias                                                                        �
//�uSeekFor		- Valida cada registro da tabela cAlias (retornar .T. para considerar e .F. para desconsiderar �
//�				  o registro)                                                                                  �
//�aNoFields	- Array com nome dos campos que serao excluidos na montagem do aHeader                         �
//�aYesFields	- Array com nome dos campos que serao incluidos na montagem do aHeader                         �
//�lOnlyYes		- Flag indicando se considera somente os campos declarados no aYesFields + campos do usuario   �
//�cQuery		- Query para filtro da tabela cAlias (se for TOP e cQuery estiver preenchido, desconsidera     �
//�	           parametros cSeekKey e bSeekWhiele)                                                              �
//�bMountFile	- Preenchimento do aCols pelo usuario (aHeader e aCols ja estarao criados)                     �
//�lInclui		- Se inclusao passar .T. para qua aCols seja incializada com 1 linha em branco                 �
//�aHeaderAux	-                                                                                              �
//�aColsAux		-                                                                                              �
//�bAfterCols	- Bloco executado apos inclusao de cada linha no aCols                                         �
//�bBeforeCols	- Bloco executado antes da inclusao de cada linha no aCols                                     �
//�bAfterHeader -                                                                                              �
//�cAliasQry	- Alias para a Query                                                                           �
//��������������������������������������������������������������������������������������������������������������
FillGetDados(2,"SC6",1,cSeek,bWhile,{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,cQuery,/*bMontCols*/,.F.,/*aHeaderAux*/,/*aColsAux*/,{|| AfterCols(cArqQry) },/*bBeforeCols*/,/*bAfterHeader*/,"SC6")

If FindFunction("MATGRADE_V") .And. MATGRADE_V() >= 20110425 .And. "MATA410" $ SuperGetMV("MV_GRDMULT",.F.,"") .And. lGrade
	aCols := aColsGrade(oGrade,aCols,aHeader,"C6_PRODUTO","C6_ITEM","C6_ITEMGRD",aScan(aHeader,{|x| AllTrim(x[2]) == "C6_DESCRI"}))
EndIf

aHeadPed := aClone(aHeader)
aColsPed := aClone(aCols)
aRetorno := {nTotPed,nTotDes}
Return aRetorno


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExstMemNiv�Autor  �Hermes		         � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe outro aprovador no mesmo nivel p/  atuali���
���          �zar a legenda da tela do usu�rio aprovador                  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExstMemNiv(cNumAlc,cNivel)

Local llRet 	:= .F.
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cSql	:= " SELECT "
cSql	+= " P0B_USER "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL = '"+cNivel+"'"
cSql	+= " AND P0B.P0B_USER <> '"+Alltrim(cUserLog)+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	llRet := .T.
EndIf

(cAlias)->(dbCloseArea())

Return llRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetNextNivel�Autor  �Hermes   	     � Data �  15/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe outro aprovador no nivel superior para   ���
���          �atualizar a legenda da tela do usu�rio aprovador            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetNextNivel(cNumAlc,cNivel)

Local llRet 	:= .F.
Local cSql 		:= ""
Local cTabOrig	:= ""
Local _VERVPC	:= ""
Local _CodVPC	:= ""
Local cPreCampo	:= ""
Local cAlias	:= GetNextAlias()
Local aAreaP0B	:= P0B->(GetArea())

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cSql	:= " SELECT "
cSql	+= " P0B_NUM "
cSql	+= " ,P0B_TIPO "
cSql	+= " ,P0B_USER "
cSql	+= " ,P0B_NIVEL "
cSql	+= " ,P0B_WF "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL > '"+cNivel+"'" // Proximo Nivel
cSql	+= " AND P0B.D_E_L_E_T_= ' ' "
cSql	+= " ORDER BY P0B_NIVEL "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	
	llRet := .T.
	
	//P0B->(dbSetOrder(1)) // P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
	P0B->(dbSetOrder(2)) //P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_USER
	
	cNextNivel := Alltrim((cAlias)->P0B_NIVEL)
	
	While (cAlias)->(!Eof())
		
		If Alltrim(cNextNivel) == Alltrim((cAlias)->P0B_NIVEL)
			If P0B->(dbSeek(xFilial("P0B")+ (cAlias)->(P0B_TIPO+P0B_NUM+P0B_USER )))
				
				If P0B->(RecLock("P0B",.F.))
					P0B->P0B_STATUS := '01'
					P0B->(MsUnLock())
				EndIf
				
				// Fazer Tratamento para enviar WF para a Proxima Fase
				If (cAlias)->P0B_WF == "1"
					
					cMailDest := Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_EMAIL" )
					cNomeAprov:= Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_NOME")
					
					cTabOrig	:= P0B->P0B_TABORI
					cPreCampo	:= Right(cTabOrig,2)
					
					dbSelectArea(cTabOrig)
					
					&(cTabOrig)->(dbSetOrder(P0B->P0B_INDCHO))
					If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ P0B->P0B_CHVIND ))
						If AllTrim(cTabOrig) == "SC5"
							_CodVPC := ""
							_VERVPC := ""
							If !U_ENVWF103(P0B->P0B_NUM,P0B->P0B_TIPO,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO)
								llRet:=.F.
							EndIf
						Else
							_CodVPC := (cTabOrig)->&(cPreCampo+"_YVPC")
							_VERVPC := (cTabOrig)->&(cPreCampo+"_YVERVPC")
							
							U_ENVWF102(P0B->P0B_NUM,P0B->P0B_TIPO,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO,_CodVPC, _VERVPC)
						EndIf
						
					EndIf
					
				EndIf
				
			EndIf
		Else
			Exit
		EndIf
		(cAlias)->(dbSkip())
		
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())

RestArea(aAreaP0B)

Return llRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF103LEG  �Autor  �Hermes Ferreira      � Data �  10/12/12  ���
�������������������������������������������������������������������������͹��
���Desc.     �Legenda do Browse                                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF103LEG()

Local aCor := {}

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

aAdd(aCor,{"BR_AMARELO"	,"Aguardando sua aprova��o"   						}) 	// 01
aAdd(aCor,{"BR_LARANJA"	,"Aguar. demais aprov. no mesmo n�vel" 				})	// 02
aAdd(aCor,{"BR_AZUL"	,"Aguardando aprova��o n�vel superior"				}) 	// 03
aAdd(aCor,{"BR_VERDE"	,"Aprovado"											}) 	// 04
aAdd(aCor,{"BR_VERMELHO","Reprovado" 										})	// 05

BrwLegenda(,"Status",aCor)


Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ENVWF103  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta o WF com as informa��es para a solicita��o de libera- ���
���          ���o de pagamento do VPC / VERBA   						  ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ENVWF103(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,cTabOrig,ChaveInd,nInd,_CodVPC, _VERVPC )

Local lReturn			:= .T.
Local clCodProces		:= ""//Nome do Processo de WorkFlow
Local clHtmlMod 		:= "" //Nome do arquivo html que ser� gerado para envio ao setor financeiro
Local clAssunto 		:= ""
Local clMailID			:= ""
Local clUserWF			:= "Administrador"
Local cPreCampo		:= Right(cTabOrig,2)
Local cAliasTMP		:= GetNextAlias()
Local aAreaP09			:= P09->(GetArea())
Local aAreaP0B			:= P0B->(GetArea())
Local cChaveSC6		:= ""
Local nValMerc			:= 0
Local nTotValMerc		:= 0
Local nTotValDesc		:= 0
Local cImagem			:= ""
Local nValBrut			:= 0
Local nValDesc			:= 0
Local nTotImposto 	:= 0
Local nTotVPCDesc		:= 0
Local	cPictVlrUnit	:= "@E 99,999,999.99"
Local	cPictVlrTota	:= "@E 999,999,999.99"
Local	cPictQuantid	:= "@E 999999999"
Local aAreaAtu			:= GetArea()
Local aAreaP0B			:= P0B->(GetArea())
Local aAprovadores	:= {}
Local lTemPromo
Local cAprvGhost		:= AllTrim(U_MyNewSx6("NCG_000075","000254","C","Usu�rio que n�o ser�o visualizados na aprova��o.","","",.F.))
Local cDirHtml			:= Alltrim(U_MyNewSX6(	"NCG_000022",;
"",;
"C",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
.F. )   )

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If cTpDocAlc == "PAL"
	
	clHtmlMod := cDirHtml+IIf(Right(clHtmlMod,1) <> "\", "\","")+ "ANALISEWF.htm"
	
EndIf

P0B->(DbSetOrder(1))//P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
P0B->(DbSeek(xFilial("P0B")+cTpDocAlc+cNumAlc))
Do While P0B->(  !Eof() .And. P0B_FILIAL+P0B_TIPO+P0B_NUM==xFilial("P0B")+cTpDocAlc+cNumAlc )   

	If !(cAprvGhost $ P0B->P0B_USER)
		P0B->( AADD(aAprovadores,{UsrFullName(P0B_USER),P0B_RENFIN,P0B_USER}) ) 
	EndIf   
	
	P0B->(DbSkip())
EndDo
RestArea(aAreaP0B)

DbSelectarea("SC6")
DbSetOrder(1)

dbSelectArea(cTabOrig)
&(cTabOrig)->(dbSetOrder(nInd))

If &(cTabOrig)->(dbSeek(xFilial(cTabOrig)+ ChaveInd ))
	
	clAssunto := "Aprova��o do Pedido de Venda:"+SC5->C5_NUM+" Cliente:"+AllTrim(SC5->C5_NOMCLI)+" com margem de "+TranSform(SC5->C5_YPERLIQ,AvSx3("C5_YPERLIQ",6))
	
	If U_PR107TemPromo(SC5->C5_NUM)
		clHtmlMod := cDirHtml+IIf(Right(clHtmlMod,1) <> "\", "\","")+ "ANALISEWF_PROMO.htm"
	EndIf
	If File(clHtmlMod)
		olProcess := TWFProcess():New(clAssunto, clAssunto) //Instancia objeto da classe TWFProcess para inicializar WF
		olProcess:NewTask(clAssunto, clHtmlMod)//Inicializa a tarefa
		olProcess:cSubject := clAssunto
		olProcess:cTo := cMailDest
		olProcess:bReturn := "U_WF103RET()"
		
		oHtml    := olProcess:oHtml
		//*****************************************
		
		U_PR107Contru(oHtml,SC5->C5_NUM)
		For nInd:=1 To Len(aAprovadores)
			AAdd( oHtml:ValByName("it1.nomeaprovador"),aAprovadores[nInd,1])
			AAdd( oHtml:ValByName("it1.percentaprovador"), TransForm( aAprovadores[nInd,2],"@E 9999.99")		)
		Next
		
		RestArea(aAreaP0B)
		oHtml:ValByName( "P0B_NUM"			, cNumAlc      		)
		oHtml:ValByName( "P0B_APROV"		, P0B->P0B_APROV  	)
		oHtml:ValByName( "P0B_NIVEL"		, P0B->P0B_NIVEL  	)
		oHtml:ValByName( "P0B_TIPO"		, P0B->P0B_TIPO   	)
		
				
		cOldTo  := olProcess:cTo
		cOldCC  := olProcess:cCC
		cOldBCC := olProcess:cBCC
		
		//Uso um endereco invalido, apenas para criar o processo de workflow, mas sem envia-lo
		olProcess:cTo  := P0B->P0B_APROV
		olProcess:cCC  := NIL
		olProcess:cBCC := NIL
		clMailID := olProcess:Start()
		
		
		If Empty(MyWFLink(clMailID,cOldTo,cOldCC,cOldBCC, olProcess:cSubject, clAssunto, Alltrim(cNomeAprov), olProcess,P0B->P0B_APROV,cNumAlc,SC5->C5_NUM,SC5->(C5_CLIENTE+"-"+C5_LOJACLI+" "+C5_NOMCLI)  ))
			lReturn:=.F.
		EndIf
		
	Else
		Aviso("NCGWF103 - 04","N�o foi localizado o modelo HTML para envio do Workflow. Solicite ao Dpto. de Tecnologia da Informa��o para verificar os modelos HTML do Workflow do Analise de Margem Liquida.",{"Ok"},3)
		lReturn:=.F.
	EndIf
	
	
EndIf

RestArea(aAreaP09)
RestArea(aAreaP0B)

Return lReturn

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MyWFLink  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia o WF com o LIck para acessar o WF com as informa��es  ���
���          �da solicita��o de libera��o de pagamento do VPC / VERBA     ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MyWFLink(cHtmlFile, cOldTo, cOldCC, cOldBCC, cSubject          , clAssunto, cNomeAprov          , oObjWf   , cUserWF    ,cNumAlc,cNumPedido,cCliente )

Local cSrvHttpIn 	:= U_MyNewSX6("NCG_000020",;
"",;
"C",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o interno (a clausula 'http://' � necess�ria ) ",;
.F. )
Local cSrvHttpEx 	:=  U_MyNewSX6(	"NCG_000021",;
"",;
"C",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
"Server HTTP do Protheus: utilizado para WORKFLOW - Endere�o externo (a clausula 'http://' � necess�ria )",;
.F. )

Local cEndHtml 		:=  U_MyNewSX6(	"NCG_000022",;
"",;
"C",;
"Diretorio do Html do Workflow",;
"Diretorio do Html do Workflow",;
"Diretorio do Html do Workflow Link  wflink.htm",;
.F.)

Local cEndArqWf		:=  U_MyNewSX6(	"NCG_000023",;
"",;
"C",;
"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
"Endere�o dos arquivos de workflow para acesso via browser do Protheus (n�o incluir a pasta com o c�digo da empresa, pois a rotina preencher� automaticamente )",;
.F. )


Local cLinkInt 		:= ""
Local cLinkExt		:= ""
Local cIdWf			:= ""

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cEndHtml := cEndHtml+IIf(Right(cEndHtml,1) <> "\", "\","")+ "wflink_pv.htm"

If Right(cSrvHttpIn,1) == "/"
	cSrvHttpIn := Left(cSrvHttpIn,Len(cSrvHttpIn)-1)
EndIf

If Right(cSrvHttpEx,1) == "/"
	cSrvHttpEx := Left(cSrvHttpEx,Len(cSrvHttpEx)-1)
EndIf

If Right(cEndArqWf,1) == "/"
	cEndArqWf := Left(cEndArqWf,Len(cEndArqWf)-1)
EndIf

If File(cEndHtml)
	
	cLinkInt 		:= cSrvHttpIn +  cEndArqWf +cEmpAnt + "/" + cUserWF + "/" + cHtmlFile + ".htm"
	
	cLinkExt 		:= cSrvHttpEx +  cEndArqWf +cEmpAnt + "/" + cUserWF + "/" + cHtmlFile + ".htm"
	
	oObjWf:NewTask("Link de Processos De Workflow", cEndHtml)
	
	oObjWf:ohtml:ValByName("titulo"			,clAssunto	)
	oObjWf:ohtml:ValByName("nomeaprovador"	,cNomeAprov )
	oObjWf:ohtml:ValByName("proc_link"		,cLinkInt	)
	oObjWf:ohtml:ValByName("docalc"			,cNumAlc	)
	oObjWf:ohtml:ValByName("proc_link2"		,cLinkExt	)
	
	
	oObjWf:ohtml:ValByName("cPedido"		,cNumPedido)
	oObjWf:ohtml:ValByName("cCliente"		,cCliente	)
	
	
	oObjWf:cTo  := cOldTo
	oObjWf:cCC  := cOldCC
	oObjWf:cBCC := cOldBCC
	oObjWf:csubject := cSubject
	
	cIdWf := oObjWf:start()
	
Else
	
	Aviso("NCGWF103 - 05","N�o foi localizado o modelo HTML para envio do link Workflow. Solicite ao Dpto. de Tecnologia da Informa��o para verificar os modelos HTML do Workflow do VPC/VEBA.",{"Ok"},3)
	
EndIf

Return(cIdWf)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WF103RET  �Autor  �Hermes Ferreira    � Data �   20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorno do WF de libera��o de Verba                         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function WF103RET(oProcRet)

Local cTipoAlc		:= "PAL"
Local cDocAlc 		:= ""
Local cNivel 		:= ""
Local cAprovad		:= ""
Local _cObsWF		:= ""
Local cAprRepr		:= ""
Local _cStatus		:= ""
Local cEndHtml		:= ""
Local _MailDest	:= ""
Local cNumPV		:= ""

Private cUserLog := ""

ChkFile("P09")
ChkFile("P0B")

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If oProcRet <> Nil
	
	
	cDocAlc 	:= oProcRet:oHtml:RetByName("P0B_NUM")
	cNivel 		:= oProcRet:oHtml:RetByName("P0B_NIVEL")
	cAprovad	:= oProcRet:oHtml:RetByName("P0B_APROV")
	_cObsWF		:= oProcRet:oHtml:RetByName("OBS")
	cAprRepr	:= oProcRet:oHtml:RetByName("APROVAR")
	
	_cUser	:= Posicione("P09",1,xFilial("P09")+cAprovad,"P09_USER")
	
	dbSelectArea("P0B")
	P0B->(dbSetOrder(2))
	If P0B->(dbSeek(xFilial("P0B")+cTipoAlc+cDocAlc+_cUser ))
		
		cUserLog := P0B->P0B_USER
		cNumPV:=P0B->P0B_PEDIDO
		
		If P0B->P0B_STATUS == "01"
			
			If RecLock( "P0B", .F.)
				
				If cAprRepr == "S"
					
					P0B->P0B_DTLIB := MsDate()
					P0B->P0B_STATU1 := 'A'         //adicionado para atender a solicita��o de rastreabilidade do Nelson
					P0B->P0B_DTLIB1 := MSDate()
					P0B->P0B_HRLIB  := Time()
					
				Else
					
					P0B->P0B_DTREPR:= MsDate()
					P0B->P0B_STATU1 := 'R'         //adicionado para atender a solicita��o de rastreabilidade do Nelson
					P0B->P0B_DTLIB1 := MSDate()
					P0B->P0B_HRLIB  := Time()
					
				EndIf
				
				P0B->(MSMM(,,, _cObsWF ,1,,,"P0B","P0B_CODOBS","SYP"))
				
				P0B->(MsUnlock())
				
			EndIf
			
			If cAprRepr == "S"
				u_NCGATPED("A")
			Else
				u_NCGATPED("R")
			EndIf
			
		Else
			
			
			If P0B->P0B_STATUS == '02'
				_cStatus := "Aguar. demais aprov. no mesmo n�vel"
			ElseIf P0B->P0B_STATUS == '03'
				_cStatus := "Aguardando aprova��o n�vel superior"
			ElseIf P0B->P0B_STATUS == '04'
				_cStatus := "Aprovado"
			ElseIf P0B->P0B_STATUS == '05'
				_cStatus := "Reprovado"
			EndIf
			
			_MailDest	:= Posicione("P09",1,xFilial("P09")+cAprovad,"P09_EMAIL")
			
			EnvMailStatus(_MailDest,"Retorno da aprova��o da Margem do Pedido de venda: "+ cDocAlc,_cStatus,cNumPV)
			
		EndIf
		
	EndIf
	
	oProcRet:Finish()
	
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EnvMailStatus�Autor�Hermes Ferreira    � Data �  21/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Envia um retorno do sttus do WF, para os casos que n�o �    ���
���          �mais permitido altera��o via WF                             ���
�������������������������������������������������������������������������͹��
���Uso       �NC games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/



Static Function EnvMailStatus(cEmailTo,cAssunto,_cStatus,cNumPV)

Local clHtmlMod		:=  Alltrim(U_MyNewSX6(	"NCG_000022",;
"",;
"C",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
"Diretorio dos Html do Workflow ",;
.F. )   )

clHtmlMod := clHtmlMod+IIf(Right(clHtmlMod,1) <> "\", "\","")+ "statusPVnaoaprova.html"


If file(clHtmlMod)
	olProcess := TWFProcess():New(cAssunto, cAssunto)
	olProcess:NewTask(cAssunto, clHtmlMod)
	olProcess:cSubject := cAssunto
	olProcess:cTo := cEmailTo
	
	oHtml    := olProcess:oHtml
	
	oHtml:ValByName( "STATUS"	, _cStatus	)
	oHtml:ValByName( "cPedido"	, cNumPV	)
	olProcess:Start()
	
EndIf
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �Mta410Vis � Autor � Marco Bianchi         � Data � 01/12/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao executada a partir da FillGetdados para validar cada ���
���          �registro da tabela. Se retornar .T. FILLGETDADOS considera  ���
���          �o registro, se .F. despreza o registro.                     ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �MColsVis()                                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametro �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � MATA410                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


Static Function Mta410Vis(cArqQry,nTotPed,nTotDes,lGrade)

Local lRet      := .T.
Local nTamaCols := Len(aCols)
Local nPosItem  := GDFieldPos("C6_ITEM")
Local nPosQtd   := GDFieldPos("C6_QTDVEN")
Local nPosQtd2  := GDFieldPos("C6_UNSVEN")
Local nPosVlr   := GDFieldPos("C6_VALOR")
Local nPosSld   := GDFieldPos("C6_SLDALIB")
Local nPosDesc  := GDFieldPos("C6_VALDESC")
Local lCriaCols := .F.		// Nao permitir que a funcao A410Grade crie o aCols
Local lGrdMult  := FindFunction("MATGRADE_V") .And. MATGRADE_V() >= 20110425 .And. "MATA410" $ SuperGetMV("MV_GRDMULT",.F.,"")

//������������������������������������������������������Ŀ
//� Verifica se este item foi digitada atraves de uma    �
//� grade, se for junta todos os itens da grade em uma   �
//� referencia , abrindo os itens so quando teclar enter �
//� na quantidade                                        �
//��������������������������������������������������������
If !lGrdMult .And. (cArqQry)->C6_GRADE == "S" .And. lGrade
	a410Grade(.F.,,cArqQry,.T.,lCriaCols)
	If ( nTamAcols==0 .Or. aCols[nTamAcols][nPosItem] <> (cArqQry)->C6_ITEM )
		lRet := .T.
	Else
		lRet := .F.
		aCols[nTamAcols][nPosQtd]  += (cArqQry)->C6_QTDVEN
		aCols[nTamAcols][nPosQtd2] += (cArqQry)->C6_UNSVEN
		If ( nPosDesc > 0 )
			aCols[nTamAcols][nPosDesc] += (cArqQry)->C6_VALDESC
		Endif
		If ( nPosSld > 0 )
			aCols[nTamAcols][nPosSld] += Ma440SaLib()
		EndIf
		aCols[nTamAcols][nPosVlr] += (cArqQry)->C6_VALOR
	EndIf
EndIf
//������������������������������������������������������������������������Ŀ
//�Efetua a Somatoria do Rodape                                            �
//��������������������������������������������������������������������������
nTotPed	+= (cArqQry)->C6_VALOR
If ( (cArqQry)->C6_PRUNIT = 0 )
	nTotDes	+= (cArqQry)->C6_VALDESC
Else
	nTotDes += A410Arred(((cArqQry)->C6_PRUNIT*(cArqQry)->C6_QTDVEN),"C6_VALOR")-A410Arred(((cArqQry)->C6_PRCVEN*(cArqQry)->C6_QTDVEN),"C6_VALOR")
EndIf


Return(lRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AfterCols � Autor � Marco Bianchi         � Data � 24/01/07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao executada apos inclusao de nova linha no aCols pela  ���
���          �FillgetDados.                                               ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   �AfterCols()                                                 ���
�������������������������������������������������������������������������Ĵ��
���Parametro �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � MATA410                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AfterCols(cArqQry,cTipoDat,dCopia,dOrig,lCopia)

Local nPosProd  := GDFieldPos("C6_PRODUTO")
Local nPosGrade := GDFieldPos("C6_GRADE")
Local nPIdentB6 := GDFieldPos("C6_IDENTB6")
Local nPEntreg  := GDFieldPos("C6_ENTREG")
Local nPPedCli  := GDFieldPos("C6_PEDCLI")
Local nQtdLib   := GDFieldPos("C6_QTDLIB")
Local nAux      := 0
Local aLiberado := {}
Local cCampo    := ""
Local lGrdMult  := FindFunction("MATGRADE_V") .And. MATGRADE_V() >= 20110425 .And. "MATA410" $ SuperGetMV("MV_GRDMULT",.F.,"")

DEFAULT lCopia  := .F.

If !lGrdMUlt
	If nPosGrade > 0 .And. aCols[Len(aCols)][nPosGrade] == "S"
		cProdRef := (cArqQry)->C6_PRODUTO
		MatGrdPrRf(@cProdRef,.T.)
		aCols[Len(aCols)][nPosProd] := cProdRef
	Else
		//��������������������������������������������������������������Ŀ
		//� Mesmo nao sendo um item digitado atraves de grade e' necessa-�
		//� rio criar o Array referente a este item para controle da     �
		//� grade                                                        �
		//����������������������������������������������������������������
		If FindFunction("MsMatGrade") .And. IsAtNewGrd()
			oGrade:MontaGrade(Len(aCols))
		Else
			MatGrdMont(Len(aCols))
		EndIf
	EndIf
EndIf

If Altera
	If ( SC5->C5_TIPO <> "D" )
		nAux := aScan(aLiberado,{|x| x[2] == aCols[Len(aCols)][nPIdentB6]})
		If ( nAux == 0 )
			aadd(aLiberado,{ (cArqQry)->C6_ITEM , aCols[Len(aCols)][nPIdentB6] , (cArqQry)->C6_QTDEMP, (cArqQry)->C6_QTDENT })
		Else
			aLiberado[nAux][3] += (cArqQry)->C6_QTDEMP
			aLiberado[nAux][4] += (cArqQry)->C6_QTDENT
		EndIf
	Else
		nAux := aScan(aLiberado,{|x| x[1] == (cArqQry)->C6_SERIORI .And.;
		x[2] == (cArqQry)->C6_NFORI   .And.;
		x[3] == (cArqQry)->C6_ITEMORI })
		If ( nAux == 0 )
			aadd(aLiberado,{ (cArqQry)->C6_SERIORI , (cArqQry)->C6_NFORI , (cArqQry)->C6_ITEMORI , (cArqQry)->C6_QTDEMP })
		Else
			aLiberado[nAux][4] += (cArqQry)->C6_QTDEMP
		EndIf
	EndIf
	// Necessario para disparar inicializador padrao
	aCols[Len(aCols)][nQtdLib] := CriaVar("C6_QTDLIB")
EndIf

If lCopia
	cCampo := Alltrim(aHeader[nPEntreg,2])
	Do Case
		Case cTipoDat == "1"
			aCols[Len(aCols)][nPEntreg] := FieldGet(FieldPos(cCampo))
		Case cTipoDat == "2"
			aCols[Len(aCols)][nPEntreg] := If(FieldGet(FieldPos(cCampo)) < dCopia,dCopia,FieldGet(FieldPos(cCampo)) )
		Case cTipoDat == "3"
			aCols[Len(aCols)][nPEntreg] := dCopia + (FieldGet(FieldPos(cCampo)) - dOrig )
	EndCase
	
	If SubStr(aCols[Len(aCols)][nPPedCli],1,3)=="TMK"
		cCampo := Alltrim(aHeader[nPPedCli,2])
		aCols[Len(aCols)][nPPedCli] := CriaVar(cCampo)
	EndIf
	
	//������������������������������������������������������Ŀ
	//� Estes campos nao podem ser copiados                  �
	//��������������������������������������������������������
	GDFieldPut("C6_QTDLIB"  ,CriaVar("C6_QTDLIB"  ),Len(aCols))
	GDFieldPut("C6_RESERVA" ,CriaVar("C6_RESERVA" ),Len(aCols))
	GDFieldPut("C6_CONTRAT" ,CriaVar("C6_CONTRAT" ),Len(aCols))
	GDFieldPut("C6_ITEMCON" ,CriaVar("C6_ITEMCON" ),Len(aCols))
	GDFieldPut("C6_PROJPMS" ,CriaVar("C6_PROJPMS" ),Len(aCols))
	GDFieldPut("C6_EDTPMS"  ,CriaVar("C6_EDTPMS"  ),Len(aCols))
	GDFieldPut("C6_TASKPMS" ,CriaVar("C6_TASKPMS" ),Len(aCols))
	GDFieldPut("C6_LICITA"  ,CriaVar("C6_LICITA"  ),Len(aCols))
	GDFieldPut("C6_PROJET"  ,CriaVar("C6_PROJET"  ),Len(aCols))
	GDFieldPut("C6_ITPROJ"  ,CriaVar("C6_ITPROJ"  ),Len(aCols))
	GDFieldPut("C6_CONTRT"  ,CriaVar("C6_CONTRT"  ),Len(aCols))
	GDFieldPut("C6_TPCONTR" ,CriaVar("C6_TPCONTR" ),Len(aCols))
	GDFieldPut("C6_ITCONTR" ,CriaVar("C6_ITCONTR" ),Len(aCols))
	GDFieldPut("C6_NUMOS"   ,CriaVar("C6_NUMOS"   ),Len(aCols))
	GDFieldPut("C6_NUMOSFAT",CriaVar("C6_NUMOSFAT"),Len(aCols))
	GDFieldPut("C6_OP"      ,CriaVar("C6_OP"      ),Len(aCols))
	GDFieldPut("C6_NUMOP"   ,CriaVar("C6_NUMOP"   ),Len(aCols))
	GDFieldPut("C6_ITEMOP"  ,CriaVar("C6_ITEMOP"  ),Len(aCols))
	GDFieldPut("C6_NUMSC"   ,CriaVar("C6_NUMSC"   ),Len(aCols))
	GDFieldPut("C6_ITEMSC"  ,CriaVar("C6_ITEMSC"  ),Len(aCols))
	GDFieldPut("C6_NUMORC"  ,CriaVar("C6_NUMORC"  ),Len(aCols))
	GDFieldPut("C6_BLQ"     ,CriaVar("C6_BLQ"     ),Len(aCols))
	GDFieldPut("C6_NOTA"    ,CriaVar("C6_NOTA"    ),Len(aCols))
	GDFieldPut("C6_SERIE"   ,CriaVar("C6_SERIE"   ),Len(aCols))
	If SC6->(FieldPos('C6_CODINF')) > 0
		GDFieldPut("C6_INFAD"   ,CriaVar("C6_INFAD"   ),Len(aCols))
	EndIf
EndIf

Return(.T.)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A410InGrdM�Autor  �Andre Anjos		 � Data �  21/01/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Funcao para inicialiar a grade multicampo				  ���
�������������������������������������������������������������������������͹��
���Uso       � MATA410                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function A410InGrdM(lEdit)
Local nPQTDVEN := 0
Local nPPRCVEN := 0
Local lGrdMult  := FindFunction("MATGRADE_V") .And. MATGRADE_V() >= 20110425 .And. "MATA410" $ SuperGetMV("MV_GRDMULT",.F.,"")

Default lEdit := .F.

If lGrdMult
	aAdd(oGrade:aCposCtrlGrd,{"C6_PRCVEN",.F.,{},{},.T.})
	aAdd(oGrade:aCposCtrlGrd,{"C6_VALOR",.F.,{},{},.F.})
	aAdd(oGrade:aCposCtrlGrd,{"C6_VALDESC",.F.,{},{},.F.})
	aAdd(oGrade:aCposCtrlGrd,{"C6_DESCRI",.F.,{},{},.F.})
	aAdd(oGrade:aCposCtrlGrd,{"C6_PRUNIT",.F.,{},{},.F.})
	
	If lEdit
		nPQTDVEN := aScan(oGrade:aCposCtrlGrd, {|x| x[1] == "C6_QTDVEN"})
		nPPRCVEN := aScan(oGrade:aCposCtrlGrd, {|x| x[1] == "C6_PRCVEN"})
		
		If Len(oGrade:aCposCtrlGrd[nPQTDVEN]) == 3
			aAdd(oGrade:aCposCtrlGrd[nPQTDVEN],{ }) //Array de gatilhos
			aAdd(oGrade:aCposCtrlGrd[nPQTDVEN],.T.) //Flag de obrigatoriedade
		EndIf
		
		//-- Campos a atualizar ao confirmar a tela da grade
		aAdd(oGrade:aCposCtrlGrd[nPQTDVEN,3],{"C6_DESCRI",{|| Posicione("SB1",1,xFilial("SB1")+oGrade:GetNameProd(,nLinha,nColuna),"B1_DESC")}})
		
		//-- Campos a atualizar na grade multicampo
		aAdd(oGrade:aCposCtrlGrd[nPQTDVEN,4],{"C6_PRCVEN",{|| A410GrInPr(nLinha,nColuna) }})
		aAdd(oGrade:aCposCtrlGrd[nPQTDVEN,4],{"C6_VALDESC",{|| (((&(ReadVar()) * 100) / oGrade:aColsFieldByName("C6_QTDVEN",,nLinha,nColuna)) / 100) * oGrade:aColsFieldByName("C6_VALDESC",,nLinha,nColuna) }})
		aAdd(oGrade:aCposCtrlGrd[nPQTDVEN,4],{"C6_VALOR",{|| A410Arred(&(ReadVar()) * oGrade:GetFieldMC("C6_PRCVEN"),"C6_VALOR")}})
		aAdd(oGrade:aCposCtrlGrd[nPPRCVEN,4],{"C6_VALOR",{|| A410Arred(&(ReadVar()) * oGrade:GetFieldMC("C6_QTDVEN"),"C6_VALOR")}})
	EndIf
EndIf

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR107  �Autor  �Microsiga           � Data �  01/05/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PR107GetPer(nTotal,nValor)
Return TransForm(  nValor/nTotal*100,"@E 99.99" )


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INBRWF02 �Autor  �Hermes Ferreira      � Data �  20/12/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o do inicializador do browse do campo P0B_NUMTIT       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function INBRWF04(nCampo)
Local aArea 	:= P0B->(GetArea())
Local cTabOrig	:= P0B->P0B_TABORI



If nCampo == 1
	cRet := Posicione((cTabOrig),P0B->P0B_INDCHO,xFilial(cTabOrig)+ P0B->P0B_CHVIND,"C5_NOMCLI" )
Else
	DbSelectArea(cTabOrig)
	DbSetOrder(P0B->P0B_INDCHO)
	If &(cTabOrig)->(DbSeek(xFilial(cTabOrig)+P0B->P0B_CHVIND))
		DbSelectarea("SA1")
		dbSetOrder(1)
		SA1->(DbSeek(xFilial("SA1") + SC5->C5_CLIENTE + SC5->C5_LOJACLI))
		cRet := SA1->A1_NOME
	EndIf
	
EndIf

RestArea(aArea)
Return cRet


/*
�����������������������������������������������������������������������������
����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  01/29/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function MySndError(oErro)

Local cMensagem		:= ""
Local cMyAux		:= ""
Local cMyPilha		:= ""
Local nPilha		:= 0
Local oHtmlModel    := Nil
Local cDirLog		:= U_MyNewSX6("NCG_000004"			,;
""														,;
"C"														,;
"Define o diret�rio para grava��o dos logs de erro das rotinas customizadas."	,;
"Define o diret�rio para grava��o dos logs de erro das rotinas customizadas."	,;
"Define o diret�rio para grava��o dos logs de erro das rotinas customizadas."	,;
.F. )
Local cDirSystem	:= Alltrim(GetSrvProfString("STARTPATH",""))
Local nHandle		:= -1
Local cError		:= ""

If Right(cDirSystem,1) <> "\"
	cDirSystem += "\"
EndIf

If Right(cDirLog,1) <> "\"
	cDirLog += "\"
EndIf

MakeDir(cDirSystem + cDirLog)

While !Empty(cMyAux:=ProcName(nPilha))
	
	cMyPilha 	+= cMyAux + Chr(13) + Chr(10)
	cMyAux		:= ""
	nPilha++
	
EndDo



If File("\Workflow\Error.html")
	
	oHtmlModel := TWFHTML():New("\Workflow\Error.html")
	
	oHtmlModel:ValByName( "EMPRESA"		, SM0->(Alltrim(M0_NOME) + " - (" + Alltrim(M0_CODIGO) ) + ")" 		)
	oHtmlModel:ValByName( "FILIAL"		, SM0->(Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODFIL) ) + ")" 	)
	oHtmlModel:ValByName( "SERVIDOR"	,  GetServerIp() 													)
	oHtmlModel:ValByName( "AMBIENTE"	,  GetEnvServer() 													)
	oHtmlModel:ValByName( "USUARIO"		,  GetWebJob()	 													)
	oHtmlModel:ValByName( "PILHA"		,  cMyPilha		 													)
	oHtmlModel:ValByName( "DATAHORA"	,  Dtoc(MsDate())+ " - " + Time() 									)
	oHtmlModel:ValByName( "ERRO"		,  oErro:ERRORSTACK													)
	
	cMensagem := oHtmlModel:HtmlCode()
	
Else
	
	cMensagem := "Sr(a) administrador(a),"
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "Ocorreu o seguinte erro no ambiente do ERP Protheus: "
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "<table border='1'> "
	cMensagem += "	<tr> "
	cMensagem += "		<th>Empresa</th> "
	cMensagem += "		<th>Filial</th> "
	cMensagem += "		<th>Servidor</th> "
	cMensagem += "		<th>Ambiente</th> "
	cMensagem += "		<th>Usu�rio</th> "
	cMensagem += "		<th>Pilha de chamada</th> "
	cMensagem += "		<th>Data/hora</th> "
	cMensagem += "		<th>Erro</th> "
	cMensagem += "	</tr>"
	cMensagem += "	<tr>"
	cMensagem += "		<td>" + SM0->(Alltrim(M0_NOME) + " - (" + Alltrim(M0_CODIGO) ) + ")" + "</td>"
	cMensagem += "		<td>" + SM0->(Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODFIL) ) + ")" + "</td>"
	cMensagem += "		<td>" + GetServerIp() + "</td>"
	cMensagem += "		<td>" + GetEnvServer() + "</td>"
	cMensagem += "		<td>" + GetWebJob() + "</td>"
	cMensagem += "		<td>" + cMyPilha + "</td>"
	cMensagem += "		<td>" + Dtoc(MsDate())+ " - " + Time() + "</td>"
	cMensagem += "		<td>" + oErro:ERRORSTACK + "</td>"
	cMensagem += "	</tr> "
	cMensagem += " </table> "
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "Departamento de Tecnologia Da Informacao"
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "At."
	
EndIf

U_MySndMail("ERRO PROTHEUS - " + SM0->(Alltrim(M0_NOME) + " - " + Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODIGO) + Alltrim(M0_CODFIL)) + ")", cMensagem, Nil, Nil, Nil, Nil)

nHandle := FCreate(cDirSystem + cDirLog  + "error_" + dTos(MsDate()) + StrTran(Time(),":","") + ".log")

cError := "------------------------------------------------------------------------------------------" + Chr(13) + Chr(10)
cError += "EMPRESA - " + SM0->(Alltrim(M0_NOME) + " - (" + Alltrim(M0_CODIGO) ) + ")"  + Chr(13) + Chr(10)
cError += "FILIAL - " + SM0->(Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODFIL) ) + ")"  + Chr(13) + Chr(10)
cError += "SERVIDOR - " + GetServerIp()  + Chr(13) + Chr(10)
cError += "AMBIENTE - " + GetEnvServer()  + Chr(13) + Chr(10)
cError += "USUARIO - " + GetWebJob()  + Chr(13) + Chr(10)
cError += "PILHA DE CHAMADA - " + cMyPilha  + Chr(13) + Chr(10)
cError += "DATA/HORA - " + Dtoc(MsDate())+ " - " + Time()  + Chr(13) + Chr(10)
cError += "ERRO - " + oErro:ERRORSTACK + " - " + Time()  + Chr(13) + Chr(10)
cError += "------------------------------------------------------------------------------------------" + Chr(13) + Chr(10)

FWrite(nHandle,cError)

FClose(nHandle)

Aviso(" TRATAMENTO DE ERRO",oErro:ERRORSTACK,{"Ok"},3)

Final(" FINALIZA��O DO SISTEMA",,.T.)

Break

Return()


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  03/26/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F103Filtro(lSetFilter)
Local cPerg			:="NCGWF103"
Local cMasterUser	:= Alltrim(U_MyNewSX6(	"NCG_000700"							,;
"lfelipe*rciambarella*dbmsystem"											,;
"C"												,;
"Usuarios com direito a Filtro na Aprova��o da Margem"	,;
"Usuarios com direito a Filtro na Aprova��o da Margem"	,;
"Usuarios com direito a Filtro na Aprova��o da Margem"	,;
.F. ))



Default lSetFilter:=.F.

cFiltro:="P0B_FILIAL = '"+xFilial("P0B")+"' AND P0B_TIPO = 'PAL' "

If  !Upper(cUserName)$Upper(cMasterUser)
	cFiltro+=" AND P0B_USER = '"+Alltrim(cUserLog)+"' And P0B_STATUS<>' '"
EndIf

PutSX1(cPerg, "01", "Somente Pedidos", "", "", "mv_ch1", "N", 1, 0, 3, "C", "", "", "", "", "mv_par01", "Aprovado", "Aprovado", "Aprovado", "", "Reprovado", "Reprovado", "Reprovado", "Em Aprova��o","Em Aprova��o", "Em Aprova��o", "Sem Filtro", "Sem Filtro", "Sem Filtro", "", "","",,,, )
If  !Pergunte(cPerg)
	Return
EndIF

If mv_par01==1//Aprovado
	cFiltro+=" AND P0B_STATUS ='04'"
ElseIf mv_par01==2//Reprovado
	cFiltro+=" AND P0B_STATUS ='05'"
ElseIf mv_par01==3//Em Aprovacao
	cFiltro+=" AND P0B_STATUS Not In('04','05') "
EndIf

//If lSetFilter
//	oBrowse:SetFilterDefault(cFiltro)
//EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  03/29/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF103Timer()
MsgRun("Atualizando dados", "Status Pedido Pronta Entrega", { || WF103TBrw() } )
Return

Static Function WF103TBrw()
Local oObjBrow:=GetObjBrow()
oObjBrow:ResetLen()
oObjBrow:GoTop()
oObjBrow:Refresh()
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  04/14/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF103PV(nChamada)
Local aAreaAtu:=GetArea()
Local aAreaP0B:=P0B->(GetArea())
Local aAreaSC5:=SC5->(GetArea())
Local nRecno	:= P0B->(Recno())

SC5->(DbSetOrder(1))
If !SC5->(DbSeek(xFilial("SC5")+P0B->P0B_PEDIDO ))
	MsgStop("Pedido de venda "+P0B->P0B_PEDIDO+" n�o encontrado")
ElseIf 	nChamada==1
	U_PR107Margem()
ElseIf 	nChamada==2
	U_NCGPROBS(P0B->P0B_NUM)
EndIf

RestArea(aAreaSC5)
RestArea(aAreaP0B)
RestArea(aAreaAtu)
GetDRefresh()

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  04/25/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF103Apr(nTipo)


If !P0B->P0B_USER == Alltrim(cUserLog)
	Aviso("NCGWF103 - WF103Apr","S� permitido analise pelo aprovador "+UsrFullName(P0B->P0B_USER)+".",{"Ok"},3)
	Return
EndIf


If nTipo==1
	u_NCGATPED("A")
Else
	u_NCGATPED("R")
EndIf
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  09/24/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function wf103ApMas(cTipo)
Local dLote			:= Msdate()
Local dTLote		:= Time()
Local aAreaAtu		:= GetArea()
Local lShow	  		:= .F.
Local cObservacao	:= ""
Local lMarcado := .f.

If cTipo=="A"
	cObservacao	:= "Pedidos com Aprova��o em Lote "
ElseIf cTipo=="R"	
	cObservacao	:= "Pedidos com Reprova��o em Lote "
EndIf	

cSql	:= " SELECT "
cSql	+= "  R_E_C_N_O_ as RecP0B "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_OK = '"+cMark+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),"TRB1", .F., .F.)


While !TRB1->(EOF())                           
	lMarcado := .t.
	
	P0B->(DbGoTo(TRB1->RecP0B))
	P0B->(RecLock("P0B",.F.))
	P0B->P0B_OK := ""
	P0B->(MsUnlock())
	
	U_NCGATPED(cTipo,lShow,cObservacao)	
	
	TRB1->(DbSkip())
EndDo

If !lMarcado
	MsgAlert("N�o h� Pedido de Venda apto para processamento.")
Else                                                  
	MsgAlert(cObservacao+" processado com sucesso.")	
EndIf

TRB1->(DbCloseArea())

RestArea(aAreaAtu)
Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  09/25/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function 103AprPos()

Local aAreaAtu := GetArea()
Local aAreaSC5 := SC5->(GetArea())
Local cPedido	:= SC5->C5_NUM

cSql	:= " SELECT "
cSql	+= " P0B.R_E_C_N_O_ as RecP0B "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B, "
cSql	+= "      " +RetSqlName("SC5")+ " SC5 "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND SC5.C5_FILIAL = '"+xFilial("SC5")+"'"
cSql	+= " AND P0B.P0B_PEDIDO = '"+cPedido+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"
cSql	+= " AND SC5.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),"TRB1", .F., .F.)

P0B->(DbGoTo(TRB1->RecP0B))

U_NCGATPED("A")

TRB1->(DbCloseArea())
RestArea(aAreaAtu)
RestArea(aAreaSC5)
GetDRefresh()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  12/13/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F103Auto()
Local cFiltro		:=""
Local aCores		:= {}
Local aAreaX3		:= SX3->(GetArea())
Local nInterval		:= 60*1000//Em milisegundos

Private aRotina		:= MenuDef()
Private cCadastro	:= "Aprova��o de Al�adas"
Private cUserLog	:= Alltrim(__cUserId)
Private aFixes		:= {}
Private cMark		:= GetMark()
Private lInverte  	:= .F.
Private alCampos  	:= {}
Private cUsr		:= Alltrim(U_MyNewSX6("NCG_APAUT","000307;000384;000411;000086","C","Usu�rios autorizados a aprovar automaticamente as al�adas","","",.F. ))

Private aRotina := { {"Pesquisar"	,"AxPesqui"			,0,1} ,;
					 {"Visualizar"			,"U_WF103ATU()"	,0,2} ,;
					 {"Aprova��o Automatica","U_WF103AUT()"	,0,4}}


aCores := {	 {"P0B->P0B_STATUS == '01' "	,"BR_AMARELO"   };
			,{"P0B->P0B_STATUS == '02' "	,"BR_LARANJA"	};
			,{"P0B->P0B_STATUS == '03' "	,"BR_AZUL"		};
			,{"P0B->P0B_STATUS == '04' "	,"BR_VERDE"		};
			,{"P0B->P0B_STATUS == '05' "	,"BR_VERMELHO"	}}


If !__cUserId$cUsr
	MsgStop("Usu�rio sem autoriza��o para utilizar a rotina")
	Return
EndIf




dbSelectArea("P0B")
P0B->(dbSetOrder(1))

SX3->(dbSetOrder(2))


If SX3->(dbSeek( "P0B_PEDIDO" ))
	AADD(aFixes, {"Pedido","P0B_PEDIDO"   })
EndIf

If SX3->(dbSeek( "P0B_STATUS" ))
	AADD(aFixes, {"Status"+Space(20), {|| P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""))) ) )  }  })
EndIf

If SX3->(dbSeek( "P0B_CODCLI" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CODCLI" })
EndIf

If SX3->(dbSeek( "P0B_LOJA" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_LOJA" })
EndIf

If SX3->(dbSeek( "P0B_NOMECL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMECL" })
EndIf


If SX3->(dbSeek( "P0B_CODVEN" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CODVEN" })
EndIf

If SX3->(dbSeek( "P0B_NOVEND" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOVEND" })
EndIf

If SX3->(dbSeek( "P0B_CANAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CANAL" })
EndIf

If SX3->(dbSeek( "P0B_DCANAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DCANAL" })
EndIf


If SX3->(dbSeek( "P0B_EMIPED" ))
	AADD(aFixes, {"Emissao PV","P0B_EMIPED" })
EndIf

If SX3->(dbSeek( "P0B_EMISSA" ))
	AADD(aFixes, {"Inicio Aprov","P0B_EMISSA" })
EndIf

If SX3->(dbSeek( "P0B_USER" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_USER"  })
EndIf

If SX3->(dbSeek( "P0B_NOMAPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMAPR"})
EndIf
If SX3->(dbSeek( "P0B_DTLIB" ))
	AADD(aFixes, {"Dt. Aprovacao","P0B_DTLIB" })
EndIf

If SX3->(dbSeek( "P0B_DTREPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DTREPR"  })
EndIf

If SX3->(dbSeek( "C5_YTOTLIQ" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YTOTLIQ"  ),AvSx3("C5_YTOTLIQ",6) )  }   })
EndIf

If SX3->(dbSeek( "C5_YPERLIQ" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERLIQ"  ),AvSx3("C5_YPERLIQ",6) )  }   })
EndIf


If SX3->(dbSeek( "C5_YLUCRBR" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YLUCRBR"  ),AvSx3("C5_YLUCRBR",6) )  }   })
EndIf


If SX3->(dbSeek( "C5_YPERRBR" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERRBR"  ),AvSx3("C5_YPERRBR",6) )  }   })
EndIf


If SX3->(dbSeek( "C5_YACORDO" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YACORDO"  ),AvSx3("C5_YACORDO",6) )  }   })
EndIf

If SX3->(dbSeek( "C5_DESC2" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_DESC2"  ),AvSx3("C5_DESC2",6) )  }   })
EndIf



//Cria o array com os campos que ser�o apresentados na markbrowse1

AADD(alCampos,{"P0B_OK"		,Nil,"Sele��o",""})
AADD(alCampos,{"P0B_PEDIDO",Nil,"Pedido",""})
If SX3->(dbSeek( "P0B_STATUS" ))
	AADD(alCampos,{{|| IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova��o", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo n�vel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova��o n�vel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""))))) },Nil,"Status"+Space(20)})
EndIf
AADD(alCampos,{"P0B_CODCLI",Nil,"Cliente",""})
AADD(alCampos,{"P0B_LOJA"	,Nil,"Loja",""})
AADD(alCampos,{"P0B_NOMECL",Nil,"Nome Cliente",""})
AADD(alCampos,{"P0B_CODVEN",Nil,"C�d. Vendedor",""})
AADD(alCampos,{"P0B_NOVEND",Nil,"Nome Vendedor",""})
AADD(alCampos,{"P0B_CANAL"	,Nil,"Canal",""})
AADD(alCampos,{"P0B_DCANAL",Nil,"Desc. Canal",""})
AADD(alCampos,{"P0B_EMIPED",Nil,"Emissao PV",""})
AADD(alCampos,{"P0B_EMISSA",Nil,"Inicio Aprov",""})
AADD(alCampos,{"P0B_NOMAPR",Nil,"Aprovador",""})
AADD(alCampos,{"P0B_DTLIB"	,Nil,"Dt. Aprovacao",""})
AADD(alCampos,{"P0B_DTREPR",Nil,"Dt. Reprov.",""})

If SX3->(dbSeek( "C5_YTOTLIQ" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YTOTLIQ"),AvSx3("C5_YTOTLIQ",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YPERLIQ" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERLIQ"),AvSx3("C5_YPERLIQ",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YLUCRBR" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YLUCRBR"),AvSx3("C5_YLUCRBR",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YPERRBR" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YPERRBR"),AvSx3("C5_YPERRBR",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_YACORDO" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_YACORDO"),AvSx3("C5_YACORDO",6))},Nil,SX3->X3_TITULO})
EndIf
If SX3->(dbSeek( "C5_DESC2" ))
	AADD(alCampos,{{|| TransForm( Posicione("SC5",1,xFilial("SC5")+P0B->P0B_PEDIDO ,"C5_DESC2" ),AvSx3("C5_DESC2",6))},Nil,SX3->X3_TITULO })
EndIf


cFiltro:="P0B_FILIAL = '"+xFilial("P0B")+"' AND P0B_TIPO = 'PAL' And P0B_STATUS IN ('01',' ') "
P0B->(dbSetOrder(3))
MarkBrow( 'P0B',"P0B_OK",,alCampos,lInverte,cMark,,,,,,,cFiltro,,aCores)


SX3->(RestArea(aAreaX3))


Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  12/13/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function WF103AUT()
Local aAreaAtu	:=GetArea()
Local aAreaP0B	:=P0B->(GetArea())
Local cChaveP0B    
Local lShow:=.F.
Local cObservacao:="Aprova��o Automatica"

If !P0B->P0B_STATUS=="01"
	MsgStop("Posicione no status Aguardando sua aprova��o")
	Return 
EndIf 

cChaveP0B	:=P0B->(P0B_FILIAL+P0B_PEDIDO+P0B_NUM)
nRecP0B		:=P0B->(Recno())
P0B->(DbSetOrder(3))//P0B_FILIAL+P0B_PEDIDO+P0B_NUM
P0B->(DbGoTo(nRecP0B))

Do While P0B->(!Eof()) .And. P0B->(P0B_FILIAL+P0B_PEDIDO+P0B_NUM)==cChaveP0B
	P0B->(RecLock("P0B",.F.))
	P0B->P0B_USER 	:= __cUserId
	P0B->P0B_STATUS := '03'
	P0B->(MsUnLock())	
	nRecP0B:=P0B->(Recno())
	P0B->(DbSkip())
EndDo
P0B->(DbGoTo(nRecP0B))
P0B->(RecLock("P0B",.F.))
P0B->P0B_STATUS := '01'
P0B->(MsUnLock())	
cUserLog:=P0B->P0B_USER
U_NCGATPED("A",lShow,cObservacao)         


RestArea(aAreaP0B)
RestArea(aAreaAtu)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGWF103  �Autor  �Microsiga           � Data �  08/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function W103MAll(cMark,cOpcao)

Local aButtons 	:= {}
Local oMArkBrow	:= GetMarkBrow()
Local cMarca
Local cAliasQry := GetNextAlias()

Default cMark := GetMark()
Default cMarca := "D" //Desmarca

cMarca :=  IIF( cOpcao == "M",cMark,Space(Len(cMark)) )

cQry := " Select R_E_C_N_O_ P0bRec
cQry += " From "+RetSqlName("P0B") +" P0B "
cQry += " Where "+ cFiltro +" "

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry, .T., .T.)

DbSelectArea(cAliasQry)

While (cAliasQry)->(!Eof())
	
	P0B->(DbGoto((cAliasQry)->P0bRec))
	
	P0B->(RecLock("P0B",.F.))
	
	P0B->P0B_OK:= cMarca
	
	P0B->(MsUnlock())
	
	(cAliasQry)->(DbSkip())
	
EndDo

oMArkBrow:oBrowse:Refresh()

Return
