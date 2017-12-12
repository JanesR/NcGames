#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'
#define clr Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGCD104  บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de cadastro de aprovadores e simula็ใo de al็ada     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGCD104()

Local aCores		:= {}
Private aRotina		:= MenuDef()
Private cCadastro	:= "Cadastro de Aprovadores"

aCores := {	 {"P09->P09_ATIVO == '1' "	,"BR_VERDE"   	};
,{"P09->P09_ATIVO == '2' "	,"BR_VERMELHO"	}}

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

Begin Sequence

dbSelectArea("P09")
P09->(dbSetOrder(1))


mBrowse( 6, 1,22,75,'P09',,,,,,aCores,,,,,,,,)

End Sequence

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMenuDef   บAutor  ณHermes Ferreira     บ Data ณ  03/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMenu da rotina de cadastro                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MenuDef()

Local aRotina := {}

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

AADD(aRotina,{"Pesquisar"		,"PesqBrw"		,0,1})
AADD(aRotina,{"Visualizar"		,"u_AxCad104"	,0,2})
AADD(aRotina,{"Incluir"			,"u_AxCad104"	,0,3})
AADD(aRotina,{"Alterar"			,"u_AxCad104"	,0,4})
AADD(aRotina,{"Excluir"			,"u_AxCad104"	,0,5})
AADD(aRotina,{"Legenda"			,"U_NCLeg104"	,0,6})
AADD(aRotina,{"Simula็ใo Al็."	,"U_FSIMU104"	,0,7})

Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCLeg104  บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda da rotina de cadastro de aprovadores 				  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCLeg104()

Local aCor := {}

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

aAdd(aCor,{"BR_VERDE"	,"Ativo"   		})
aAdd(aCor,{"BR_VERMELHO","Inativo"	 	})

BrwLegenda(,"Status",aCor)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAxCad104  บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de manuten็ใo de cadastro de aprovadores 			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AxCad104(clAlias,nlReg,nlOpcx)

Local oFont01   	:=TFont():New( "Courier New",,20,,.F.,,,20,,,,,,,,)
Local cTitulo		:= "Tela de cadastro Aprovadores."
Local nlResoluc		:= oMainWnd:nClientWidth
Local alCoord		:= MsAdvSize(.T.,.F.,0)
Local aButtons		:= {}
Local aCmpsUser		:= {}
Local aVerbaCmp	:= {}
Local aPLCmps		:= {}
Local alPrcPrinc	:= {0,0,0}
Local alPrc			:= {0}
Local odlgCab		:= Nil
Local odlgVerb		:= Nil
Local odlgPL		:= Nil

Local oEncCab		:= Nil
Local oEncVerb		:= Nil
Local oEncPL		:= Nil

Private aTela[0][0]
Private aGets[0]

Private opOdlg		:= Nil
Private opLayer		:= FWLayer():New()


//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If nlResoluc <= 800
	
	alPrcPrinc 		:= {040,030,030}
	alPrc			:= {100}
	
ElseIf nlResoluc > 800 .And. nlResoluc < 1024
	
	alPrcPrinc 		:= {040,030,030}
	alPrc			:= {100}
	
ElseIf nlResoluc >= 1024 .And. nlResoluc < 1280
	
	alPrcPrinc 		:= {040,030,030}
	alPrc			:= {100}
	
ElseIf nlResoluc >= 1280 .And. nlResoluc < 1300
	
	alPrcPrinc 		:= {040,030,030}
	alPrc			:= {100}
	
ElseIf 	nlResoluc >= 1300
	
	alPrcPrinc 		:= {040,030,030}
	alPrc			:= {100}
	
EndIf

// Campos que serใo exibidos a Enchoice
aCmpsUser := {}
AADD(aCmpsUser,"P09_CODIGO")
AADD(aCmpsUser,"P09_NOME")
AADD(aCmpsUser,"P09_USER")
AADD(aCmpsUser,"P09_TIPO")
AADD(aCmpsUser,"P09_ORDEM")
AADD(aCmpsUser,"P09_ATIVO")
AADD(aCmpsUser,"P09_EMAIL")
AADD(aCmpsUser,"P09_CANAL")
AADD(aCmpsUser,"NOUSER")

aVerbaCmp := {}
AADD(aVerbaCmp,"P09_VLRINF")
AADD(aVerbaCmp,"P09_VLRSUP")
AADD(aVerbaCmp,"NOUSER")

aPLCmps := {}
AADD(aPLCmps,"P09_RENINI")
AADD(aPLCmps,"P09_RENFIN")
AADD(aPLCmps,"NOUSER")



opOdlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

opLayer:Init(opOdlg,.F.)

opLayer:AddCollumn("CENTRO"	,alPrc[1],.F.)

opLayer:AddWindow("CENTRO","CABEC"					,"Informa็๕es Usuแrio"		,alPrcPrinc[1],.T.,.T.,{||},,{||})
opLayer:AddWindow("CENTRO","VERBA"					,"Verba"			   		,alPrcPrinc[2],.T.,.T.,{||},,{||})
opLayer:AddWindow("CENTRO","PL"						,"P&L"				   		,alPrcPrinc[3],.T.,.T.,{||},,{||})

odlgCab	:= opLayer:GetWinPanel("CENTRO","CABEC")
odlgVerb:= opLayer:GetWinPanel("CENTRO","VERBA")
odlgPL	:= opLayer:GetWinPanel("CENTRO","PL")

RegToMemory("P09", nlOpcx == 3,.T.,.T.)

oEncCab:= MSMGet():New("P09",,nlOpcx	,,,,aCmpsUser	,{0,0,0,0},,,,,,odlgCab	,,,,,,,,,)
oEncCab:oBox:Align := CONTROL_ALIGN_ALLCLIENT

oEncVerb:= MSMGet():New("P09",,nlOpcx	,,,,aVerbaCmp	,{0,0,0,0},,Nil,Nil,Nil,Nil,odlgVerb,.F.,.F.,Nil,Nil,Nil,.T.,Nil,Nil,Nil)
oEncVerb:oBox:Align := CONTROL_ALIGN_ALLCLIENT

oEncPL:= MSMGet():New("P09",,nlOpcx		,,,,aPLCmps		,{0,0,0,0},,Nil,Nil,Nil,Nil,odlgPL,.F.,.F.,Nil,Nil,Nil,.T.,Nil,Nil,Nil)
oEncPL:oBox:Align := CONTROL_ALIGN_ALLCLIENT

Activate Msdialog opOdlg Centered On Init EnchoiceBar(opOdlg,;
{|| IIF (Iif(nlOpcx==3 .Or. nlOpcx==4,(Obrigatorio(aGets,aTela),U_CD104Tudok() ),.T.), (  IIF( FVldExlc(nlOpcx),(FGRVCD104(nlOpcx,MsAuto2Ench("P09")),opOdlg:End()),Nil ) ),Nil)   },;
{|| IIF(nlOpcx==3,P02->(RollBackSX8()),Nil),opOdlg:End() };
,,aButtons)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFVldExlc บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo para incluir/alterar/excluir aprovador			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FVldExlc(nlOpcx)

Local lRet := .T.
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If nlOpcx == 3 .or. nlOpcx == 4
	If M->P09_VLRINF > M->P09_VLRSUP
		Aviso("NCGCD104 - 01","Valor superior de verba ้ MENOR que o valor inferior. Nใo permitido!",{"Ok"},3)
		lRet := .F.
	EndIf
	
	If M->P09_RENINI > M->P09_RENFIN
		Aviso("NCGCD104 - 02","Rentabilidade final ้ MENOR que a rentabilidade inicial. Nใo permitido!",{"Ok"},3)
		lRet := .F.
	EndIf
	
ElseIf nlOpcx == 5
	
	cSql := " SELECT "
	cSql += " P0B_APROV "
	cSql += " FROM "+RetSqlName("P0B")+" P0B "
	cSql += " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
	cSql += " AND P0B.P0B_APROV = '"+P09->P09_CODIGO+"'"
	If P09->P09_TIPO=="2"
		cSql += " AND P0B.P0B_CANAL = '"+P09->P09_CANAL+"'"
	EndIf
	
	cSql += " AND P0B.D_E_L_E_T_= ' '"
	
	Processa( { || DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.) },"","Verificando se o registro jแ foi utilizado...")
	
	(cAlias)->(dbGoTop())
	
	If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
		
		Aviso("NCGCD104 - 04","Esse aprovador jแ foi utilizado em um processa de controle de al็ada e nใo poderแ ser excluํdo.",{"Ok"},3)
		lRet := .F.
		
	EndIf
	
	(cAlias)->(dbCloseArea())
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGRVCD104บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo para gravar o cadastro do aprovador				  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGRVCD104(nOpcX,aAutoCab)
Local nA
//ErrorBlock( { |oErro| U_MySndError(oErro) } )

//Inicia Processo de Gravacao
If nOpcX == 3 .Or. nOpcX == 4
	
	DbSelectArea("P09")
	lNewRec := (nOpcX==3)
	
	If RecLock( "P09", lNewRec)
		
		For nA := 1 to Len(aAutoCab)
			If "FILIAL" $ aAutoCab[nA,1]
				
				P09->(FieldPut(FieldPos(aAutoCab[nA][1]),xFilial("P09")))
				
			Else
				
				P09->(FieldPut(FieldPos(aAutoCab[nA][1]),aAutoCab[nA][2]))
				
			EndIf
		Next nA
		
		P09->(MsUnlock())
		
		If nOpcX == 3
			P09->(ConfirmSx8())
		EndIf
		
	EndIf
	
ElseIf nOpcX == 5     //Exclusao
	
	RecLock("P09",.F.)
	P09->(DbDelete())
	MsUnlock()
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFSIMU104  บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de simula็ao de controle de al็ada					  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FSIMU104()

Local oFont01   	:=TFont():New( "Courier New",,20,,.F.,,,20,,,,,,,,)
Local cTitulo		:= "Simula็ใo de Aprovadores."
Local cComboTp		:= ""
Local nValorSim		:= 0
Local nRentab		:= 0
Local nlResoluc		:= oMainWnd:nClientWidth
Local alCoord		:= MsAdvSize(.T.,.F.,0)
Local aButtons		:= {}
Local aTipos		:= {"1=Verba","2=P&L"}
Local aCmpHeader	:= {}
Local alPrcPrinc	:= {0,0,0}
Local alPrc			:= {0}
Local odlgCab		:= Nil
Local odlgVerb		:= Nil
Local odlgPL		:= Nil

Local oEncValores	:= Nil
Local oGrid			:= Nil
Local olOdlg		:= Nil
Local oGetValor		:= Nil
Local oComboTp		:= Nil
Local oGetRent		:= Nil
Local nI

Private aTela[0][0]
Private aGets[0]
Private opLayer		:= FWLayer():New()
Private aHeadAprov	:= {}
Private aColsAprov	:= {}
Private opGridP02	:= Nil

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If nlResoluc <= 800
	
	alPrcPrinc 		:= {030,070}
	alPrc			:= {100}
	
ElseIf nlResoluc > 800 .And. nlResoluc < 1024
	
	alPrcPrinc 		:= {030,070}
	alPrc			:= {100}
	
ElseIf nlResoluc >= 1024 .And. nlResoluc < 1280
	
	alPrcPrinc 		:= {030,070}
	alPrc			:= {100}
	
ElseIf nlResoluc >= 1280 .And. nlResoluc < 1300
	
	alPrcPrinc 		:= {030,070}
	alPrc			:= {100}
	
ElseIf 	nlResoluc >= 1300
	
	alPrcPrinc 		:= {030,070}
	alPrc			:= {100}
	
EndIf

AADD(aCmpHeader,"P09_ORDEM"	)
AADD(aCmpHeader,"P09_CODIGO")
AADD(aCmpHeader,"P09_NOME"	)
AADD(aCmpHeader,"P09_EMAIL"	)


SX3->(DbSetOrder(2))
For nI := 1 to Len(aCmpHeader)
	If SX3->(DbSeek(aCmpHeader[nI]))
		Aadd(aHeadAprov,	{	Trim(X3Titulo()),SX3->X3_CAMPO,SX3->X3_PICTURE,;
		SX3->X3_TAMANHO,SX3->X3_DECIMAL,/*SX3->X3_VALID*/,;
		SX3->X3_USADO,SX3->X3_TIPO,	;
		SX3->X3_F3,SX3->X3_CONTEXT,SX3->X3_CBOX,,SX3->X3_WHEN,	;
		SX3->X3_VISUAL,SX3->X3_VLDUSER, SX3->X3_PICTVAR,SX3->X3_OBRIGAT	})
	EndIf
Next nI


olOdlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6],alCoord[5],cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

opLayer:Init(olOdlg,.F.)

opLayer:AddCollumn("CENTRO"	,alPrc[1],.F.)

opLayer:AddWindow("CENTRO","CABEC"					,"Valor"			,alPrcPrinc[1],.T.,.T.,{||},,{||})
opLayer:AddWindow("CENTRO","ITENS"					,"Aprovadores"		,alPrcPrinc[2],.T.,.T.,{||},,{||})

odlgCab	:= opLayer:GetWinPanel("CENTRO","CABEC")
odlgVerb:= opLayer:GetWinPanel("CENTRO","ITENS")


nlX1	:= odlgCab:NCLIENTWIDTH*0.1
nlX2	:= odlgCab:NCLIENTHEIGHT * 0.124

nlX3	:= odlgCab:NCLIENTWIDTH * 0.13
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.083

oSay := tSay():New(nlX4,nlX3,{||"Tipo"},odlgCab,,,,,,.T.,,,nlX1,nlX2)

nlX1	:= odlgCab:NCLIENTWIDTH * 0.076
nlX2	:= odlgCab:NCLIENTHEIGHT*0.02

nlX3	:= odlgCab:NCLIENTWIDTH * 0.17
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.08

oComboTp := TComboBox():New(nlX4,nlX3,{|u| If(PCount()>0,Eval({|x| cComboTp:=x },u),cComboTp)},aTipos,nlX1,nlX2,odlgCab,,{|| Processa({|| FLoadAprov(nValorSim,cComboTp)},"Carregando Aprovadores..") },,,,.T.,,,,,,,,,"cComboTp")


nlX1	:= odlgCab:NCLIENTWIDTH*0.1
nlX2	:= odlgCab:NCLIENTHEIGHT * 0.124

nlX3	:= odlgCab:NCLIENTWIDTH * 0.13
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.198

oSay := tSay():New(nlX4,nlX3,{||"Canal"},odlgCab,,,,,,.T.,,,nlX1,nlX2)

nlX1	:= odlgCab:NCLIENTWIDTH * 0.076
nlX2	:= odlgCab:NCLIENTHEIGHT*0.02

nlX3	:= odlgCab:NCLIENTWIDTH * 0.17
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.08

oSay := tSay():New(nlX4,nlX3,{||"Valor"},odlgCab,,,,,,.T.,,,nlX1,nlX2)

nlX1	:= odlgCab:NCLIENTWIDTH * 0.076
nlX2	:= odlgCab:NCLIENTHEIGHT * 0.07

nlX3	:= odlgCab:NCLIENTWIDTH * 0.17
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.191

oGetValor:= TGet():New(nlX4,nlX3,{|u| if(PCount()>0,nValorSim:=u,nValorSim)},odlgCab ,nlX1,nlX2,PesqPict("P09", "P09_VLRINF"),,0,,,.F.,,.T.,,.T.,{|| cComboTp == "1" },.T.,.T.,{|| FLoadAprov(nValorSim,cComboTp) },.F.,.F.,,"nValorSim",,,, )

nlX1	:= odlgCab:NCLIENTWIDTH*0.1
nlX2	:= odlgCab:NCLIENTHEIGHT * 0.124

nlX3	:= odlgCab:NCLIENTWIDTH * 0.13
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.34

oSay := tSay():New(nlX4,nlX3,{||"Rentabilidade"},odlgCab,,,,,,.T.,,,nlX1,nlX2)

nlX1	:= odlgCab:NCLIENTWIDTH * 0.076
nlX2	:= odlgCab:NCLIENTHEIGHT * 0.07

nlX3	:= odlgCab:NCLIENTWIDTH * 0.17
nlX4	:= odlgCab:NCLIENTHEIGHT * 0.31

oGetRent:= TGet():New(nlX4,nlX3,{|u| if(PCount()>0,nRentab:=u,nRentab)},odlgCab ,nlX1,nlX2,"@E 99.99%",,0,,,.F.,,.T.,,.T.,{|| cComboTp == "2"},.T.,.T.,{|| FLoadAprov(nRentab,cComboTp) },.F.,.F.,,"nValorSim",,,, )


opGridP02:= MsNewGetDados():New(000,000,000,000,1,"AllWaysTrue()","AllWaysTrue()","",,,9999,"AllWaysTrue()",,,odlgVerb,aHeadAprov,aColsAprov)
opGridP02:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
opGridP02:lInsert := .F.
opGridP02:aCols	:=	aColsAprov

Activate Msdialog olOdlg Centered On Init EnchoiceBar(olOdlg,;
{|| olOdlg:End()  },;
{|| olOdlg:End() };
,,aButtons)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFSIMU104  บAutor  ณHermes			     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega o grid para apresentar os aprovadores para o valor  บฑฑ
ฑฑบ          ณinformado                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FLoadAprov(nValor,cComboTp)

Local clAlias	:= GetNextAlias(),i

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If !Empty(cComboTp) .and. nValor > 0
	
	aColsAprov := {}
	opGridP02:aCols	:=	aColsAprov
	opGridP02:Refresh()
	
	Processa({ || U_QRYALC104(@clAlias,nValor,cComboTp)},"Carregando Aprovadores...")
	
	(clAlias)->(dbGoTop())
	
	If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
		
		While (clAlias)->(!Eof())
			
			AAdd(aColsAprov,Array(Len(aHeadAprov)+1))
			
			For i := 1 To Len(aHeadAprov)
				
				aColsAprov[Len(aColsAprov)][i] := (clAlias)->(&(aHeadAprov[i,2]))
				
			Next i
			
			aColsAprov[Len(aColsAprov)][Len(aHeadAprov)+1] := .F.
			
			(clAlias)->(dbSkip())
			
		EndDo
		
	Else
		
		Aviso("NCGCD104 - 03","Nใo foi localizada al็ada para este valor.",{"Ok"},3)
		
	EndIf
	
	(clAlias)->(dbCloseArea())
	
EndIf

opGridP02:aCols	:=	aColsAprov
opGridP02:Refresh()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGCD104  บAutor  ณMicrosiga           บ Data ณ  10/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณQuery para retorno dos aprovadores do controle de al็ada de บฑฑ
ฑฑบ          ณtitulo NCC e a pagar que foram relacionados a VPC/VERBA     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC Games                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QRYALC104(clAlias,nValor,cComboTp,cCanal)

Local cSql		:= "",i


cSql := " SELECT "
cSql += " P09_ORDEM "
cSql += " ,P09_CODIGO "
cSql += " ,P09_NOME "
cSql += " ,P09_EMAIL "
cSql += " ,P09_RENINI "
cSql += " ,P09_RENFIN "


cSql += " FROM " +RetSqlName("P09")+ " P09 "

cSql += " WHERE P09.P09_FILIAL = '"+xFilial("P09")+"'"

cSql += " AND P09.P09_TIPO = '"+cComboTp+"'"
cSql += " AND P09.P09_ATIVO = '1'"

If cComboTp == "1"
	cSql += " AND ( P09.P09_VLRSUP <=" +Alltrim(Str(nValor))+ " OR ( " +Alltrim(Str(nValor))+ " BETWEEN P09.P09_VLRINF And P09_VLRSUP))"	
ElseIf cComboTp == "2"
	If nValor>0
		cSql += " AND "+Alltrim(Str(nValor))+' BETWEEN P09_RENINI AND P09_RENFIN		
	EndIf	
	cSql += " AND P09.P09_CANAL='"+cCanal+"'"
	
EndIf

cSql += " AND P09.D_E_L_E_T_= ' '"
cSql += " ORDER BY P09_ORDEM "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),clAlias, .F., .F.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGCD104  บAutor  ณMicrosiga           บ Data ณ  01/26/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CD104VAL(cCampo)
Local lRetorno:=.T.
Default cCampo:=__ReadVar

If "P09_TIPO"$cCampo
	If !Empty(M->P09_USER)
		If M->P09_TIPO=="1"
			lRetorno:=ExistChav("P09",M->P09_TIPO+M->P09_USER,4)
		ElseIf !Empty(M->P09_CANAL)			
			lRetorno:=ExistChav("P09",M->P09_TIPO+M->P09_USER+P09_CANAL,5)			
		EndIf
	EndIf	
EndIf

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGCD104  บAutor  ณMicrosiga           บ Data ณ  01/26/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CD104Tudok()
Local lRetorno:=.T.

If M->P09_TIPO=="2" .And. Empty(M->P09_CANAL)
	lRetorno:=.F.
	MsgStop("Campo Canal de Venda Obrigat๓rio")
EndIf	

	

Return lRetorno