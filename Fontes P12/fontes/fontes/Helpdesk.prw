#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "PROTHEUS.CH"
#include "MSGRAPHI.CH"
#include "FIVEWIN.CH"
#include "FILEIO.CH"
#INCLUDE "APWIZARD.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DIGITA OS ºAutor  ³Thiago - STCH       º Data ³  08/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³APONTAMENTO DE OS, ATENDIMENTO HELP DESK                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION OS()

// TELA DE SENHA DE ACESSO
public CVERT,olbx,oDlgHist, lret,LALTERA, cord, ctpos, ntothr, nhralt, ltothr, creduz,cemail, ddata, ccliente, ctexto, chrini, chrfim, chrtra, chralm, ahrini , ahrtra, ahralm    , ahrfim,atpos,XTPOS,csoli, cproxhd, aproxhd, cproj, chelp,nsaldo,calmoco,cEmailCli
public aLigacoes 		:= {}, ndutil, duthoj

CVERT 					:= "2013-03-04"
gets2()

RETURN

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function GETS2()

Local aScreen 		:= GetScreenRes()
Local nWStage 		:= aScreen[1]-45
Local nHStage 		:= aScreen[2]-225
Local aSize     	:= MsAdvSize(.T.)

Private aORD     		:= {}

DEFINE MSDIALOG SLDS TITLE OemToAnsi("Helpdesk NC Games - login : " + capital(subs(cusuario,7,15)) ) +"    "+ dtoc(msdate()) ;
FROM 90,15 TO 650,1250 PIXEL //FROM 90,15 TO 732,1366 PIXEL //732,1553 PIXEL

Public aVetor   		:= {}
Public aVetor2 		:= {}
Public aVetor3  		:= {}
Public aVetor4  		:= {}
Public aVetor5  		:= {}
Public nRadio			:= 2
Public oRadio
Public oLbx     		:= Nil
Public oLbx9    		:= Nil
Public oLbx3    		:= Nil
Public oLbx4    		:= Nil
Public oLbx5    		:= Nil
Public oLbx2    		:= Nil
Public aCODCli  		:= {}
Public aCODTEC  		:= {}
Public aFIL     		:= {}
//Public aORD     		:= {}
Public aORD2    		:= {}
Public aFIL1   		:= {}
Public aFIL2    		:= {}
Public aFIL3  			:= {}
Public aHeader 		:= {}
Public aStruct			:= {}
Public aGetCpos 		:= {}
Public cTEC				:= ""
Public cTECUSR			:= ""
Public dEmissao		:= CtoD("  /  /    ")
Public dVencto			:= CtoD("  /  /    ")
Public cFIL				:= " *** TODOS *** "
Public _cORD			:= ""
Public _CORD2 			:= ""
Public cFIL1			:= ""
Public cFIL2 			:= ""
Public cFIL3			:= ""
Public nsomad 			:= 0
Public diameta			:= ddatabase
Public oFolder			:= Nil
Public aFolder 		:= { 'Agenda', 'Relação OS' }
Public aFolder2 		:= { oLbx5, oLbx2 }
Public aCpoEnchSZX	:= {}
Public nTOT_TSK 		:= 0
Public nTOT_PRJ 		:= 0
Public nTOT_HRS 		:= 0
Public OOBSMEMO                                                     // OBSERVACAO DO MEMO
Public OMONOAS			:= TFONT():NEW( "COURIER NEW",6,0)            	// FONTE PARA O CAMPO MEMO
Public COBSMEMO		:= ""                                           // STRING COM A DESCRICAO DO MEMO
Public cTANA			:= "1"
// Ativa F1 para inclusão de nova tarefa
Set Key VK_F1 To EdList3()
// Chama função para transferencia/classificação do chamado
Set Key VK_F2 To TRCLHD()
Set Key VK_F9 To DescnsTask()

// Monta lista de tecnicos/analistas
aPEGAANA()

// filtros possiveis
AADD(AFIL,"Em Aberto")
AADD(AFIL,"Em Andamento")
AADD(AFIL,"Concluídas")
AADD(AFIL,"Atrasados")
AADD(AFIL,"Não Finalizadas")
AADD(AFIL," *** TODOS *** ")
cFIL	:= " *** TODOS *** "

// formas de ordenacao
AADD(AORD,"Entrega")
AADD(AORD,"Código")
AADD(AORD,"Descrição")
AADD(AORD,"Solicitante")
AADD(AORD,"Analista")
AADD(AORD,"Tipo HD")

//aDIAS := aPEGADIAS()

// fixa consultor pelo login, caso ele nao esteja cadastrado posiciona no primeiro registro
dbSelectArea("SZW")
dbSetOrder(4)
IF dbSeek(XFILIAL("SZW")+__CUSERID)
	cTecUSR		:= SZW->ZW_CODIGO
	cTANA			:= SZW->ZW_TIPO
ELSE
	cTANA			:= "1"
ENDIF

// fixa consultor pelo login
nPosCod 	:= aScan(aAnalist,{ |x| substr(Upper(AllTrim(x)),1,6) == cTecUSR }) //aScan(aAnalist,{ |x| Upper(AllTrim(x[1])) == cTecUSR })

IF NPOSCOD == 0
	cTANA			:= "1"
	cTEC			:= " *** TODOS *** "
ELSE
	cTEC			:= AANALIST[nPosCod]
ENDIF

// Monta a lista de solicitantes (com base na tabela SZX)
aPegaSol()

cSOL				:= " *** TODOS *** "

//Tarefas
@ 005,365 Say 	OemToAnsi("Total Incidentes ") 										PIXEL OF SLDS
@ 005,005 Say 	OemToAnsi("Analista") 													PIXEL OF SLDS
@ 005,095 Say 	OemToAnsi("Solicitante")												PIXEL OF SLDS
@ 005,185 Say 	OemToAnsi("Filtro") 														PIXEL OF SLDS
@ 005,275 Say 	OemToAnsi("Ordem") 														PIXEL OF SLDS

IF cTANA == "2"
	@ 005,410 Radio oRadio Var nRadio Items "Administrador", "Analista"	SIZE 050,009 	PIXEL OF SLDS;
	ON CHANGE {|| u_LIMPA2(cTec) }
	
	@ 010,500 BUTTON "Transf./Classf."  	     					  				SIZE 45,12 		PIXEL OF SLDS ACTION TRCLHD()
ENDIF

//Tarefas
@ 012,365 MSGET nTOT_TSK 	Picture "@E 99,999"  	When .F.  				SIZE 40,9 		PIXEL OF SLDS
IF cTANA == "2"
	@ 012,005 MSCOMBOBOX oSer1 VAR cTEC 	ITEMS aAnalist  					SIZE 080, 10 	PIXEL OF SLDS ON CHANGE U_LIMPA2(cTec)
ELSE
	//@ 012,005 MSCOMBOBOX oSer1 VAR cTEC 				When .F.  				SIZE 080, 10 	PIXEL OF SLDS ON CHANGE U_LIMPA2(cTec)
	@ 012,005 MSGET oSer1 		VAR cTEC 				When .F.					SIZE 080, 10 	PIXEL OF SLDS ON CHANGE u_LIMPA2(cTec)
ENDIF

@ 012,095 MSCOMBOBOX oSer1 		VAR cSol 	ITEMS aSolicit 				SIZE 080, 10 	PIXEL OF SLDS ON CHANGE u_LIMPA2(cTec)
@ 012,185 MSCOMBOBOX oSer1 		VAR cFIL 	ITEMS aFIL  					SIZE 080, 10 	PIXEL OF SLDS ON CHANGE u_LIMPA2(cTec)
@ 012,275 MSCOMBOBOX oSer1 		VAR _cORD 	ITEMS aORD  					SIZE 080, 10 	PIXEL OF SLDS ON CHANGE Help_Ordena()

@ 160,550 BUTTON "Incluir"  	     													SIZE 045, 12 	PIXEL OF SLDS ACTION EdList3()
@ 175,550 BUTTON "Refresh"  	     													SIZE 045, 12 	PIXEL OF SLDS ACTION u_Limpa2(cTec)
@ 190,550 BUTTON "Follow Up"  	    							 					SIZE 045, 12 	PIXEL OF SLDS ACTION CadSZY()
@ 205,550 BUTTON "E-Mail"  	     													SIZE 045, 12 	PIXEL OF SLDS ACTION osmail(AVETOR2, OLBX9)
@ 220,550 BUTTON "Concluir"  	 							    						SIZE 045, 12 	PIXEL OF SLDS ACTION fEndTask()
@ 235,550 Button "Conhecimento"														Size 045, 12 	PIXEL OF SLDS Action SZXConhec("1")
@ 250,550 Button OemToAnsi("Ajuda")  												Size 045, 12 	PIXEL OF SLDS Action fAjuda()

/////////////////////////////////////////////

// lista de Tarefas Pendentes
LISTATSK()
// lista histórico para cada chamado (box 'Histórico')
OCORRENCIAS()

Activate Dialog Slds Centered

RETURN .t.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function LISTATSK()

Local aSalvAmb := {}
Local oDlg     := Nil
Local cTitulo  := ""
Local lSaldo   := .F.
Local oOk      := LoadBitmap( GetResources(), "BR_VERDE" )
Local oAtra    := LoadBitmap( GetResources(), "BR_VERMELHO" )
Local oQua     := LoadBitmap( GetResources(), "BR_AMARELO" )
Local oNo      := LoadBitmap( GetResources(), "BR_AZUL" )
Local aCPOSZX  := {}

dbSelectArea("SZX")
aSalvAmb := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SZX"))

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

cQuery := " SELECT * "
cQuery += " FROM "+RetSqlName("SZX")+" ZX "
cQuery += " WHERE ZX.D_E_L_E_T_ != '*'"
cQuery += " AND ZX_FILIAL = '"+cFilAnt+"'"
cQuery += " AND ZX_STATUS != 'X'" //desconsiderar os status de chamados excluidos
IF nRadio != 1
	IF !EMPTY(ALLTRIM(substr(cTec,1,6))) .AND. ALLTRIM(cTec) != "*** TODOS ***"
		cQuery += " AND ZX_CODANA = '"+alltrim(substr(cTec,1,6))+"'"
	ENDIF
ENDIF
IF !EMPTY(ALLTRIM(cSol)) .AND. ALLTRIM(cSol) != "*** TODOS ***"
	cQuery += " AND ZX_SOLICIT = '"+alltrim(cSol)+"'"
ENDIF

IF !("TODOS"$cFIL)
	IF ("Autorizadas"$cFIL)
		cQuery += " AND ZX_AUTORIZ = '1'"
		cQuery += " AND ZX_STATUS != '3'"
	ELSEIF ("Não Aut"$cFIL)
		cQuery += " AND ZX_AUTORIZ = '2'"
		cQuery += " AND ZX_STATUS != '3'"
	ELSEIF ("Aberto"$cFIL)
		cQuery += " AND ZX_STATUS IN ('1')"
	ELSEIF ("Andamento"$cFIL)
		cQuery += " AND ZX_STATUS = '2'"
	ELSEIF ("Conclu"$cFIL)
		cQuery += " AND ZX_STATUS = '3'"
	ELSEIF ("Atrasa"$cFIL)
		cQuery += " AND ZX_STATUS = '4'"
		cQuery += " AND ZX_STATUS != '3'"
	ENDIF
	//cQuery += " AND ZX_STATUS = '"+cFil+"'"
ENDIF
IF ("Código"$_cORD)
	cQuery += " ORDER BY ZX_CODIGO DESC" //, ZX_ITERAC"
ELSEIF ("Descrição"$_cORD)
	cQuery += " ORDER BY ZX_DESCRI, ZX_CODIGO ASC "
ELSEIF ("Solicitante"$_cORD)
	cQuery += " ORDER BY ZX_SOLICIT, ZX_CODIGO ASC "
ELSEIF ("Entrega"$_cORD)
	cQuery += " ORDER BY ZX_ENTREGA, ZX_HRENTRE,ZX_CODIGO DESC "
ELSEIF ("Emiss"$_cORD)
	cQuery += " ORDER BY ZX_EMISSAO DESC"
ELSEIF ("Analista"$_cORD)
	cQuery += " ORDER BY ZX_ANALIST ASC"
ELSEIF ("Tipo"$_cORD)
	cQuery += " ORDER BY ZX_DESCTIP ASC"
ENDIF

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

DBSELECTAREA("TRB")
DBGOTOP()

WHILE !EOF()
	
	lSaldo := IF(Stod(TRB->ZX_ENTREGA) < ddatabase,"3",IF(StoD(TRB->ZX_ENTREGA) == ddatabase,"2","1"))
	//" ", "Codigo", "Tarefa", "Abertura", "Entrega", "Solicitante" , "Analista",  "Stat", "Tipo", "Baixa", "Tipo Chamado"
	
	aAdd( aVetor2, { lSaldo								, ; // 01
	" " 														, ; // 02
	TRB->ZX_DESCRI											, ; // 03
	StoD(TRB->ZX_ENTREGA)								, ; // 04
	X3COMBO("ZX_AUTORIZ", TRB->ZX_AUTORIZ)			, ; // 05
	TRB->ZX_HRSPREV										, ; // 06
	TRB->ZX_SOLICIT										, ; // 07
	UPPER(TRB->ZX_CLIENTE)								, ; // 08
	UPPER(TRB->ZX_ANALIST)								, ; // 09
	LEFT(X3COMBO("ZX_STATUS", TRB->ZX_STATUS),4)	, ; // 10
	TRB->ZX_PROJETO										, ; // 11
	X3COMBO("ZX_TIPO", TRB->ZX_TIPO)					, ; // 12
	TRB->ZX_INDIC											, ; // 13
	StoD(TRB->ZX_DTBAIXA)								, ; // 14
	StoD(TRB->ZX_EMISSAO)								, ; // 15
	TRB->ZX_CODIGO 										, ; // 16
	TRB->ZX_DESCTIP										} ) // 17
	
	DBSELECTAREA("TRB")
	dbSkip()
EndDo

If Len( aVetor2 ) == 0
	aAdd( aVetor2, { "", "  " , "SEM INCIDENTES", CTOD("") , "", 0 , "", "", "","","","", "",CTOD(""), CTOD(""), "", "" } )
Endif

@ 30,05 LISTBOX oLbx9 FIELDS HEADER " ", "Codigo", "Tipo Chamado", "Incidente", "Abertura","Baixa", "Solicitante", "Analista", "Stat", "Entrega" SIZE 600,120 OF SLDS PIXEL ON DBLCLICK( EdList4())
// ordem dos campos no ARRAY		   , 16      , 17			 , 03      , 15        , 14    , 07           , 09        , 10    , 04

nTOT_TSK := len(aVetor2)

oLbx9:SetArray( aVetor2 )
oLbx9:bLine := {|| { VLDLEG() 																			,; // LEGENDA
aVetor2[oLbx9:nAt,16]																					,; // CODIGO
aVetor2[oLbx9:nAt,17]																					,; // TIPO CHAMADO
LEFT(aVetor2[oLbx9:nAt,03],55)																			,; // TAREFA/INCIDENTE
aVetor2[oLbx9:nAt,15]																					,; // DT ABERTURA
aVetor2[oLbx9:nAt,14]																					,; // DT BAIXA
LEFT(aVetor2[oLbx9:nAt,07],20)																			,; // SOLICITANTE
aVetor2[oLbx9:nAt,09]																					,; // ANALISTA
aVetor2[oLbx9:nAt,10]																					,; // STATUS
aVetor2[oLbx9:nAt,04]																					}} // DT ENTREGA

RestArea( aSalvAmb )
oLbx9:Refresh()

Return .T.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function EdList3()

Local aAlter			:= {}
Local cAliasE 			:= "SZX"
Local aAlterEnch		:= {}
Local aPos				:= {000,000,400,600}
Local nModelo			:= 3
Local lF3 				:= .F.
Local lMemoria			:= .T.
Local lColumn			:= .F.
Local caTela 			:= ""
Local lNoFolder		:= .F.
Local lProperty		:= .F.
Local oOper
Local cCodOper			:= ""
Public cCadastro 		:= "Incidentes"
Public lOk				:= .T.
Private oDlg
Private oGetD
Private oEnch
Private aTELA[0][0]
Private aGETS[0]
nOpc := 3

DBSELECTAREA(cAliasE)
dbsetorder(1)
dbseek(xfilial(cAliasE)+aVetor2[oLbx9:nAt,16],.t.)

RegToMemory("SZX", If(nOpc==3,.T.,.F.))

M->ZX_CODIGO 			:= GetSxENum("SZX","ZX_CODIGO")

aButtons 				:= {}

//aAlterEnch 			:= aClone(aCpoEnchSZX)

DEFINE MSDIALOG oDlg TITLE cCadastro FROM 000,000 TO 500,1100 PIXEL

Enchoice(cAliasE,RECNO(),nOpc,,,,aCpoEnchSZX,aPos,/*aAlterEnch*/,nModelo,,,,oDlg,lF3,lMemoria,lColumn,caTela,lNoFolder,lProperty)

//										( oDlgbOkbCancel [ lMsgDel ] [ aButtons ] [ nRecno ] [ cAlias ] )
ACTIVATE MSDIALOG oDlg CENTERED ON INIT ( fVALID() , EnchoiceBar(oDlg,{||lOk:=GRAVA_TSK(3),IIF(lOK==.F.,,oDlg:End())},{||oDlg:End()},,@aButtons))
//ACTIVATE MSDIALOG oDlg          ON INIT (            EnchoiceBar(oDlg,{||lOk:=.T.    ,oDlg:End()},{||oDlg:End()},,@aButtons))

Return

Static Function Fvalid()

//M->ZX_TIPOHD := ""

//IF EMPTY(ALLTRIM(M->ZX_TIPOHD))
//	ALERT("PREENCHA O CAMPO!")
//	SetFocus()
//EdList3()
//	Return .F.
//ENDIF
// * /

//GRAVA_TSK(3)

//ENDIF

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function EdList4()

Local aAlter			:= {}
Local cAliasE 			:= "SZX"
Local aAlterEnch		:= {}
Local aPos				:= {000,000,400,600}
Local nModelo			:= 3
Local lF3 				:= .F.
Local lMemoria			:= .T.
Local lColumn			:= .F.
Local caTela 			:= ""
Local lNoFolder		:= .F.
Local lProperty		:= .F.
Public cCadastro 		:= "Incidentes"
Public lOk				:= .T.
Private oDlg
Private oGetD
Private oEnch
Private aTELA[0][0]
Private aGETS[0]

// SE O STATUS NÃO FOR "CONCLUIDO" OU SE O ANALISTA OU O USUARIO DO SISTEMA FOREM ADMINISTRADORES
// POSSIBILITA A ALTERAÇÃO, CASO CONTRARIO, MANDA UMA MENSAGEM DE AVISO
IF !(AVETOR2[OLBX9:NAT][10] $ 'Conc') .OR. GETADVFVAL("SZW","ZW_TIPO",XFILIAL("SZW")+__CUSERID,4,"") == '2' .OR. ALLTRIM(__CUSERID) == "000000"
	
	nOpc 					:= 4
	
	DBSELECTAREA(cAliasE)
	dbsetorder(1)
	dbseek(xfilial(cAliasE)+aVetor2[oLbx9:nAt,16],.t.)
	
	RegToMemory("SZX", If(nOpc==3,.T.,.F.))
	
	aButtons 			:= {}
	AAdd(aButtons,{"Conhecimento"    				,{|| SZXConhec("2") }   		,"Conhecimento"	})
	AAdd(aButtons,{"Follow Up"   	 					,{|| CadSZY() }   				,"Follow Up"		})
	AAdd(aButtons,{"E-Mail"  	 	 					,{|| osmail(AVETOR2, OLBX9) }	,"E-Mail"			})
	
	IF cTANA == "2"
		AAdd(aButtons,{"Transf./Classf."  	 	 	,{|| TRCLHD() }					,"Transf./Classf."})
	ENDIF
		
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM 000,000 TO 500,1100 PIXEL
	
	Enchoice(cAliasE,RECNO(),nOpc,,,,aCpoEnchSZX,aPos,/*aAlterEnch*/,nModelo,,,,oDlg,lF3,lMemoria,lColumn,caTela,lNoFolder,lProperty)
	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{||lOk:=GRAVA_TSK(4),oDlg:End()},{||oDlg:End()},,@aButtons))
	
	IF lOK == .F.
		ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{||lOk:=GRAVA_TSK(4),oDlg:End()},{||oDlg:End()},,@aButtons))
	ENDIF
ELSE
	Alert("Não é possível alterar um chamado concluido. <br> Solicite a reabertura para o Administrador.")
ENDIF

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function GRAVA_TSK(nOpc)

IF nOpc == 3
	lInclusao := .T.
ELSE
	lInclusao := .F.
END

IF EMPTY(ALLTRIM(M->ZX_TIPOHD))
	ALERT("Campo Tipo HD nao preechido")
	lRet := .F.
ELSEIF EMPTY(ALLTRIM(M->ZX_SOLICIT))
	ALERT("Campo Solicitante nao preechido")
	lRet := .F.
ELSE
	lRet := .T.
	
	dbSelectArea("SZX")
	dbSetOrder(1)
	dbseek(xfilial("SZX")+aVetor2[oLbx9:nAt,16],.t.)
	
	RECLOCK("SZX",lInclusao)
	SZX->ZX_FILIAL				:= xFilial("SZX")
	SZX->ZX_DESCRI				:= M->ZX_DESCRI
	SZX->ZX_ENTREGA 			:= M->ZX_ENTREGA
	SZX->ZX_AUTORIZ 			:= M->ZX_AUTORIZ
	SZX->ZX_HRSPREV 			:= M->ZX_HRSPREV
	SZX->ZX_SOLICIT 			:= M->ZX_SOLICIT
	SZX->ZX_CODCLI 			:= M->ZX_CODCLI
	SZX->ZX_CODANA				:= M->ZX_CODANA
	SZX->ZX_CLIENTE 			:= M->ZX_CLIENTE
	SZX->ZX_ANALIST			:= UPPER(M->ZX_ANALIST)
	SZX->ZX_STATUS				:= M->ZX_STATUS
	SZX->ZX_TIPO				:= M->ZX_TIPO
	SZX->ZX_INDIC				:= M->ZX_INDIC
	IF M->ZX_STATUS	== "3"
		SZX->ZX_DTBAIXA 		:= DDATABASE //M->ZX_DTBAIXA
		SZX->ZX_ORD				:= "ENDTSK"
	ELSE
		SZX->ZX_DTBAIXA 		:= M->ZX_DTBAIXA
	ENDIF
	SZX->ZX_EMISSAO			:= M->ZX_EMISSAO
	SZX->ZX_PROJETO			:= M->ZX_PROJETO
	SZX->ZX_OBS					:= M->ZX_OBS
	SZX->ZX_TIPOHD				:= alltrim(M->ZX_TIPOHD)
	SZX->ZX_DESCTIP			:= M->ZX_DESCTIP
	SZX->ZX_HRENTRE			:= M->ZX_HRENTRE
	SZX->ZX_CC					:= M->ZX_CC
	
	IF lInclusao
		SZX->ZX_CODIGO 		:= M->ZX_CODIGO
		CONFIRMSX8()
		SZX->ZX_HREMIS			:= TIME()
		IF !EMPTY(ALLTRIM(M->ZX_SOLICIT))
			cMensagem			:= "Esta é uma mensagem automática, por favor não responda. Para melhor acompanhamento da ocorrência, anote o número do seu chamado."
			cMensagem			+= "<BR>"
			cMensagem			+= "This is an automated message, please do not answer. To better monitor the occurrence, write down the number on your ticket."
			cHtm				:= u_HD_HTML(M->ZX_CODIGO, )
			lSnd				:= u_SNDMAIL({alltrim(M->ZX_SOLICIT)},'NOVO CHAMADO - ' + M->ZX_CODIGO,cHtm,{}	) //cMensagem,{}	)
		ENDIF
		
	ELSE
		SZX->ZX_CODIGO 		:= M->ZX_CODIGO
	ENDIF
	MSUNLOCK()
	
	// atualiza array do objeto da tela
	IF lInclusao
		lSaldo 					:= IF(SZX->ZX_ENTREGA < ddatabase,"3",IF(SZX->ZX_ENTREGA == ddatabase,"2","1"))
		// 								" ", "Codigo", "Tipo Chamado", "Tarefa", "Abertura","Baixa", "Solicitante", "Analista", "Stat", "Entrega" SIZE 450,090 OF SLDS PIXEL	ON DBLCLICK( EdList4())
		// ordem dos campos no ARRAY	   , 16		 , 17			 , 03      , 15        , 14    , 07           , 09        , 10    , 04
		//aAdd( aVetor2, 	{ lSaldo, " " , ZX_DESCTIP , ZX_DESCRI, ZX_EMISSAO, ZX_DTBAIXA, ZX_SOLICIT, UPPER(ZX_ANALIST), LEFT(X3COMBO("ZX_STATUS", SZX->ZX_STATUS),4), ZX_ENTREGA} )
		
		aAdd( aVetor2, { lSaldo							, ; // 01
		" " 													, ; // 02
		ZX_DESCRI											, ; // 03
		ZX_ENTREGA											, ; // 04
		X3COMBO("ZX_AUTORIZ", ZX_AUTORIZ)			, ; // 05
		ZX_HRSPREV											, ; // 06
		ZX_SOLICIT											, ; // 07
		UPPER(ZX_CLIENTE)									, ; // 08
		UPPER(ZX_ANALIST)									, ; // 09
		LEFT(X3COMBO("ZX_STATUS", ZX_STATUS),4)	, ; // 10
		ZX_PROJETO											, ; // 11
		X3COMBO("ZX_TIPO", ZX_TIPO)					, ; // 12
		ZX_INDIC												, ; // 13
		ZX_DTBAIXA											, ; // 14
		ZX_EMISSAO											, ; // 15
		ZX_CODIGO 											, ; // 16
		ZX_DESCTIP											} ) // 17
	ELSE
		//HEADER " ", "Codigo", "Tipo Chamado", "Incidente", "Abertura","Baixa", "Solicitante", "Analista", "Stat", "Entrega"
		aVetor2[oLbx9:nAt,02]	:= M->ZX_CODIGO
		aVetor2[oLbx9:nAt,03]	:= M->ZX_DESCTIP
		aVetor2[oLbx9:nAt,04]	:= M->ZX_DESCRI
		aVetor2[oLbx9:nAt,05]	:= M->ZX_EMISSAO
		aVetor2[oLbx9:nAt,06]	:= M->ZX_DTBAIXA
		aVetor2[oLbx9:nAt,07]	:= LEFT(aVetor2[oLbx9:nAt,7],20)
		aVetor2[oLbx9:nAt,08]	:= UPPER(M->ZX_ANALIST)
		aVetor2[oLbx9:nAt,09]	:= X3COMBO("ZX_STATUS", M->ZX_STATUS)
		aVetor2[oLbx9:nAt,10]	:= M->ZX_ENTREGA
		
	ENDIF
ENDIF
u_Limpa2(cTec)

Return lRet

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function OCORRENCIAS()

Local aSalvAmb 		:= {}
Local aVetor3   		:= {}
Local oDlg     		:= Nil
Local cTitulo  		:= ""
Local lSaldo   		:= .F.
Local oOk      		:= LoadBitmap( GetResources(), "BR_VERDE" 	)
Local oAtra    		:= LoadBitmap( GetResources(), "BR_VERMELHO" )
Local oQua     		:= LoadBitmap( GetResources(), "BR_AMARELO" 	)
Local oNo      		:= LoadBitmap( GetResources(), "BR_AZUL" 		)

dbSelectArea("SZY")
aSalvAmb 				:= GetArea()

nTOT_HRS 				:= 0

nTOT_PRJ 				:= len(aVetor3)

@ 155,005 TO 275,535 LABEL "HISTORICO" OF Slds PIXEL
@ 165,007 GET OOBSMEMO VAR COBSMEMO OF Slds MEMO SIZE 525,105 PIXEL READONLY
//OOBSMEMO := TSimpleEditor():New( 165,07,Slds,525,105 )

OOBSMEMO:OFONT			:= OMONOAS
OOBSMEMO:BRCLICKED	:= {|| ALLWAYSTRUE() }
OOBSMEMO:REFRESH()
oLbx9:BCHANGE 			:= {|| REFRMEMO(OOBSMEMO, AVETOR2, OLBX9 ) }



RestArea( aSalvAmb )

//oLbx3:Refresh()

Return .T.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function LIMPA2(cTec)

Local oOk      	:= LoadBitmap( GetResources(), "BR_VERDE" 	)
Local oAtra    	:= LoadBitmap( GetResources(), "BR_VERMELHO" )
Local oQua     	:= LoadBitmap( GetResources(), "BR_AMARELO"	)
Local oNo      	:= LoadBitmap( GetResources(), "BR_AZUL" 		)

aVetor2 				:= {}
aSalvAmb 			:= GetArea()

aPegaSol()

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

cQuery := " SELECT * "
cQuery += " FROM "+RetSqlName("SZX")+" ZX "
cQuery += " WHERE ZX.D_E_L_E_T_ != '*'"
cQuery += " AND ZX_FILIAL = '"+cFilAnt+"'"
IF nRadio != 1
	//IF !EMPTY(ALLTRIM(substr(cTec,1,6))) .AND. ALLTRIM(cTec) != "*** TODOS ***"
	If "NÃO CLASSIFICADOS" $ cTec
		cQuery += " AND ZX_CODANA = ' '
	ElseIf alltrim(cTec) != "*** TODOS ***"
		//cQuery += " AND ZX_ANALIST = '"+alltrim(cTec)+"'"
		cQuery += " AND ZX_CODANA = '"+alltrim(substr(cTec,1,6))+"'"
	ENDIF
ENDIF
IF !EMPTY(ALLTRIM(cSol)) .AND. ALLTRIM(cSol) != "*** TODOS ***"
	cQuery += " AND ZX_SOLICIT = '"+alltrim(cSol)+"'"
ENDIF

IF !("TODOS"$cFIL)
	IF ("Autorizadas"$cFIL)
		cQuery += " AND ZX_AUTORIZ = '1'"
		cQuery += " AND ZX_STATUS != '3'"
	ELSEIF ("Não Aut"$cFIL)
		cQuery += " AND ZX_AUTORIZ = '2'"
		cQuery += " AND ZX_STATUS != '3'"
	ELSEIF ("Aberto"$cFIL)
		cQuery += " AND ZX_STATUS IN ('1')"
	ELSEIF ("Andamento"$cFIL)
		cQuery += " AND ZX_STATUS = '2'"
	ELSEIF ("Conclu"$cFIL)
		cQuery += " AND ZX_STATUS = '3'"
	ELSEIF ("Atrasa"$cFIL)
		cQuery += " AND ZX_STATUS = '4'"
		cQuery += " AND ZX_STATUS != '3'"
	ELSEIF ("Não Final"$cFIL)
		cQuery += " AND ZX_STATUS != '3'"
	ENDIF
	
ENDIF
IF ("Código"$_cORD)
	cQuery += " ORDER BY ZX_CODIGO DESC" //, ZX_ITERAC"
ELSEIF ("Descrição"$_cORD)
	cQuery += " ORDER BY ZX_DESCRI, ZX_CODIGO ASC "
ELSEIF ("Solicitante"$_cORD)
	cQuery += " ORDER BY ZX_SOLICIT, ZX_CODIGO ASC "
ELSEIF ("Entrega"$_cORD)
	cQuery += " ORDER BY ZX_ENTREGA, ZX_HRENTRE, ZX_CODIGO DESC "
ELSEIF ("Emiss"$_cORD)
	cQuery += " ORDER BY ZX_EMISSAO DESC"
ELSEIF ("Analista"$_cORD)
	cQuery += " ORDER BY ZX_ANALIST ASC"
ELSEIF ("Tipo"$_cORD)
	cQuery += " ORDER BY ZX_DESCTIP ASC"
ENDIF
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

DBSELECTAREA("TRB")
DBGOTOP()

WHILE !EOF()
	
	lSaldo := IF(Stod(TRB->ZX_ENTREGA) < ddatabase,"3",IF(StoD(TRB->ZX_ENTREGA) == ddatabase,"2","1"))
	
	aAdd( aVetor2, { lSaldo								, ;
	" " 														, ;
	TRB->ZX_DESCRI											, ;
	StoD(TRB->ZX_ENTREGA)								, ;
	X3COMBO("ZX_AUTORIZ", TRB->ZX_AUTORIZ)			, ;
	TRB->ZX_HRSPREV										, ;
	TRB->ZX_SOLICIT										, ;
	UPPER(TRB->ZX_CLIENTE)								, ;
	UPPER(TRB->ZX_ANALIST)								, ;
	LEFT(X3COMBO("ZX_STATUS", TRB->ZX_STATUS),4)	, ;
	TRB->ZX_PROJETO										, ;
	X3COMBO("ZX_TIPO", TRB->ZX_TIPO)					, ;
	TRB->ZX_INDIC											, ;
	StoD(TRB->ZX_DTBAIXA)								, ;
	StoD(TRB->ZX_EMISSAO)								, ;
	TRB->ZX_CODIGO 										, ;
	TRB->ZX_DESCTIP										} )
	
	DBSELECTAREA("TRB")
	dbSkip()
EndDo

If Len( aVetor2 ) == 0
	//aAdd( aVetor2, { "", "  " , "", "SEM INCIDENTES", CTOD("") , "", 0 , "", "", "","","", "",CTOD(""), CTOD("") } )
	aAdd( aVetor2, { "", "  " , "SEM INCIDENTES", CTOD("") , "", 0 , "", "", "","","","", "",CTOD(""), CTOD(""), "", "" } )
Endif

nTOT_TSK := len(aVetor2)

RestArea( aSalvAmb )

oLbx9:SetArray( aVetor2 )
oLbx9:bLine := {|| { VLDLEG() 																		,; // LEGENDA
aVetor2[oLbx9:nAt,16]																					,; // CODIGO
aVetor2[oLbx9:nAt,17]																					,; // TIPO CHAMADO
LEFT(aVetor2[oLbx9:nAt,03],55)																		,; // TAREFA/INCIDENTE
aVetor2[oLbx9:nAt,15]																					,; // DT ABERTURA
aVetor2[oLbx9:nAt,14]																					,; // DT BAIXA
LEFT(aVetor2[oLbx9:nAt,07],20)																		,; // SOLICITANTE
aVetor2[oLbx9:nAt,09]																					,; // ANALISTA
aVetor2[oLbx9:nAt,10]																					,; // STATUS
aVetor2[oLbx9:nAt,04]																					}} // DT ENTREGA

oLbx9:Refresh()

// atualiza codigo do analista
nPosCod 		:= aScan(AcodTEC,{ |x| Upper(AllTrim(x[1])) == Upper(AllTrim(substr(cTEC,1,6))) })
if nposcod <> 0
	cTECUSR 	:= ACODTEC[nPosCod][2]
else
	cTECUSR 	:= "000000"
endif

// Atualiza o box "histórico"
REFRMEMO(OOBSMEMO, AVETOR2, OLBX9 )

Return .t.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function fAjuda()

ctx := "Teclas de Atalho:" 																+ chr(13) + chr(10)
ctx += "F1 		- Inclui Nova Tarefa"													+ chr(13) + chr(10)
ctx += "F2 		- Transferencia e classificação "									+ chr(13) + chr(10)
ctx += "----------------------------------------------------" 					+ chr(13) + chr(10)
ctx += "Legendas INCIDENTES" 																+ chr(13) + chr(10)
ctx += "VERDE 		- Chamado em aberto" 												+ chr(13) + chr(10)
ctx += "AMARELO 	- Chamado em andamento" 											+ chr(13) + chr(10)
ctx += "VERMELHO	- Chamado atrasado" 													+ chr(13) + chr(10)
ctx += "AZUL 		- Chamado concluido" 												+ chr(13) + chr(10)

DEFINE MSDIALOG AJUDA TITLE OemToAnsi(" Ajuda do Painel do Analista ") FROM 0,0 TO 200,400 PIXEL

@ 05,005 GET cTx   Size 180,080  MEMO  when .t. PIXEL OF AJUDA

Activate Dialog AJUDA Centered

RETURN .t.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function fENCHOICE()

cAliasE 	:= "SZX"
DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cAliasE)
While !Eof() .And. SX3->X3_ARQUIVO == cAliasE
	If !(SX3->X3_CAMPO $ "ZX_FILIAL") .And. cNivel >= SX3->X3_NIVEL .And.;
		X3Uso(SX3->X3_USADO)
		AADD(aCpoEnchSZX,SX3->X3_CAMPO)
	EndIf
	DbSkip()
End
Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function fEndTask(chave,_stat,ord)

ASZX 						:= GetArea()

IF EMPTY(chave)
	chave 				:= aVetor2[oLbx9:nAt,16]
ENDIF

IF EMPTY(ord)
	ord   				:= "ENDTSK"
ENDIF

IF EMPTY(_stat)
	_stat   				:= "3"
ELSE
	IF "Ok!"$_stat
		_stat   			:= "3"
	ELSE
		_stat   			:= "2"
	ENDIF
ENDIF

DBSELECTAREA("SZX")
dbsetorder(1)
dbseek(xfilial("SZX")+chave,.t.)

IF SZX->ZX_STATUS != '3'
	
	RECLOCK("SZX",.F.)
	SZX->ZX_STATUS 	:= _stat
	SZX->ZX_ORD 		:= ord
	SZX->ZX_DTBAIXA 	:= ddatabase
	MSUNLOCK()
	
	DBSELECTAREA("SZY")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SZY")+aVetor2[oLbx9:nAt,16]+DtoS(aVetor2[oLbx9:nAt,15]),.T.)
	RECLOCK("SZY",.T.)
	SZY->ZY_FILIAL		:= "03"
	SZY->ZY_OCORREN		:= "Chamado concluido"
	SZY->ZY_CHAMADO		:= AVETOR2[OLBX9:NAT][16]
	SZY->ZY_DATA		:= dDatabase
	SZY->ZY_ANALIST		:= upper(UsrFullName(__CUSERID))
	SZY->ZY_HRINI		:= time() //"00:00"
	SZY->ZY_HRFIM		:= time() //"00:00"
	MSUNLOCK()
	
	u_LIMPA2(cTec)
	
ELSE
	Alert("Este chamado já foi concluido")
ENDIF

RestArea(aSZX)

u_LIMPA2(cTec)

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
STATIC FUNCTION REFRMEMO(OOBSMEMO,ALIGACOES,OLBX)
aSZY			:= getarea()
COBSMEMO		:= ""
DBSELECTAREA("SZY")
DBSETORDER(1)
//DBSEEK(XFILIAL("SZY")+ALIGACOES[OLBX:NAT,16]+DtoS(ALIGACOES[OLBX:NAT,15]),.T.)
DBSEEK(XFILIAL("SZY")+ALIGACOES[OLBX:NAT,16]+DtoS(ALIGACOES[OLBX:NAT,15]))
DO WHILE !EOF() .AND. ALIGACOES[OLBX:NAT,16] == SZY->ZY_CHAMADO //.AND. DTOS(SZY->ZY_DATA) == ALIGACOES[OLBX:NAT,15] //.AND. SZY->ZY_HORA == ALIGACOES[OLBX:NAT,3]
	T_LINHAS := MLCOUNT(SZY->ZY_OCORREN,100,3,.T.)
	COBSMEMO += "Data: "+DTOC(SZY->ZY_DATA)+" Das: "+SZY->ZY_HRINI+" Até: "+SZY->ZY_HRFIM+CHR(13) + CHR(10) //+" "+Replicate("-",100)+CHR(13) + CHR(10)
	//FOR I := 1 TO T_LINHAS
		//COBSMEMO += ALLTRIM(MEMOLINE (SZY->ZY_OCORREN,100,I,3,.T.)) + IIF(LEN(ALLTRIM(MEMOLINE (SZY->ZY_OCORREN,100,I,3,.T.))) > 0,CHR(13) + CHR(10),"")
	//NEXT            
	COBSMEMO += SZY->ZY_OCORREN
	COBSMEMO 	+= Replicate("-",150)+CHR(13) + CHR(10)
	DBSELECTAREA("SZY")
	DBSKIP()
ENDDO
//OOBSMEMO:Load(COBSMEMO)
OOBSMEMO:REFRESH()


//restarea(aSZY)
RETURN .T.

// funcoes para criar as tabelas novas
/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function HDUSER()
AxCadastro("SZW","ANALISTAS")
Return(nil)

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function HISTHD()
AxCadastro("SZY","HISTORICO")
Return(nil)

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function TPHD()
AxCadastro("SZZ","TIPO CHAMADO")
Return(nil)

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function CADSZY()

Local aArea		:= GetArea()
Local aAreaSZX	:= SZX->(GetArea())

Private cCadastro 	:= "Helpdesk - Histórico" 				// título da tela
Private nOpca 			:= 0
Private aButtons 		:= {}
Private aParam			:= {}

IF !(AVETOR2[OLBX9:NAT][10] $ 'Conc')
	aAdd( aParam,  {|| U_Before() 			} )				// antes da abertura
	aAdd( aParam,  {|| U_SZYOK() 				} )				// ao clicar no botao ok
	aAdd( aParam,  {|| U_SZYTrans() 			} )				// durante a transacao
	aAdd( aParam,  {|| U_SZYFim() 			} ) 				// termino da transacao
	
	RegToMemory("SZY",.T.)
	
	nOpca 				:= AxInclui("SZY",SZY->(Recno()),3,,/*U_CADSZY()*/,,,.F.,,,aParam,,,.T.,,,,,)

	DbSelectArea("SZX")
	DbSetOrder(1)
	If DbSeek(xFilial("SZX")+AVETOR2[OLBX9:NAT][16])
		reclock("SZX",.f.)
		SZX->ZX_STATUS	:= "2"
		msunlock()
	EndIf

	RestArea(aAreaSZX)
	
	u_LIMPA2(cTec)

ELSE
	Alert("Chamado concluido, não é possível novas interações")
ENDIF

RestArea(aArea)

Return nOpca
//Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function BEFORE()

M->ZY_CHAMADO	:= AVETOR2[OLBX9:NAT][16]
M->ZY_DATA		:= dDatabase
M->ZY_HRINI		:= time() //"00:00"
M->ZY_HRFIM		:= time() //"00:00"

RETURN

// programas utilizados para validar o axInclui()
User Function SZYOK()

u_LIMPA2(cTec)
Return .T.

User Function SZYTrans()
u_LIMPA2(cTec)
Return .T.

User Function SZYFim()
u_LIMPA2(cTec)
Return .T.

/////////////////////////////////////////////////////////////////////////////////////////
// Verifica se o analista e administrador, se for tem permissao para alterar os campos //
// Caso contrario nao tem permissao, esta validação será válida apenas para alterações //
// Impossibilitando que usuários comuns alterem informações importantes do chamado     //
// nOpc - 3 = Inclusão                                                                 //
// nOpc - 4 = Alteração                                                                //
// Retorna .T. ou .F.                                                                  //
/////////////////////////////////////////////////////////////////////////////////////////
User Function SZXVLD()

Private lRet	:= .F.

IF nOPC != 3
	IF ALLTRIM(__CUSERID) == "000000" 
		lRet := .T.
	ELSE
		IF GETADVFVAL("SZW","ZW_TIPO",XFILIAL("SZW")+__CUSERID,4,"") == '2'				//ADMIN
			lRet := .T.
		ELSE
			IF EMPTY(M->ZX_CODANA)
				IF GETADVFVAL("SZW","ZW_TIPO",XFILIAL("SZW")+__CUSERID,4,"") == '2'		//ADMIN
					lRet	:= .T.
				ELSE
					lRet	:= .F.
				ENDIF
			ELSE
				IF GETADVFVAL("SZW","ZW_TIPO",XFILIAL("SZW")+M->ZX_CODANA,1,"") == '2'	//ADMIN
					lRet	:= .T.
				ELSE
					lRet	:= .F.
				ENDIF
			ENDIF
		ENDIF
	ENDIF
Else
	lRet 	:= .T.
ENDIF

Return lRet

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function SZXConhec(cProc)

IF cProc == "1" // "BROWSE
	cFile := GETTEMPPATH()+AVETOR2[OLBX9:NAT][16]+".eml"
ELSE // INCLUI/ALTERA
	cFile := GETTEMPPATH()+M->ZX_CODIGO+".eml"
ENDIF

//APAGA ARQUIVOS TEMPORARIOS
IF FILE(cFile) == .T.
	winexec("del "+cFile)
ENDIF

IF cProc == "1" // "BROWSE
	CpyS2T("\HELPDESK\ANEXOS\"+AVETOR2[OLBX9:NAT][16]+".eml",GETTEMPPATH(), .T.)
ELSE
	CpyS2T("\HELPDESK\ANEXOS\"+M->ZX_CODIGO+".eml",GETTEMPPATH(), .T.)
ENDIF

IF FILE(cFile) == .T.
	/*
	nExec := WinExec(cFile) //"C:\Dir\App.exe")
	WinExec("C:\Program Files\Microsoft Office\Office14\OUTLOOK.EXE /eml " + cFile)
	IF nExec != 0
	fopen(cFile,FO_READ+FO_SHARED)
	ENDIF
	*/
	//alert("encontrou o arquivo")
	// WINDOWS PT-BR 32 BITS ------------------------------------------------------------------
	IF file("C:\Arquivos de programas\Microsoft Office\OFFICE11\OUTLOOK.EXE") == .T.
		Winexec("C:\Arquivos de programas\Microsoft Office\OFFICE11\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Arquivos de programas\Microsoft Office\Office12\OUTLOOK.EXE") == .T.
		Winexec("C:\Arquivos de programas\Microsoft Office\Office12\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Arquivos de programas\Microsoft Office\Office13\OUTLOOK.EXE") == .T.
		Winexec("C:\Arquivos de programas\Microsoft Office\Office13\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Arquivos de programas\Microsoft Office\OFFICE14\OUTLOOK.EXE")  == .T.
		Winexec("C:\Arquivos de programas\Microsoft Office\OFFICE14\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Arquivos de programas\Microsoft Office\OFFICE15\OUTLOOK.EXE")  == .T.
		Winexec("C:\Arquivos de programas\Microsoft Office\OFFICE15\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files\Microsoft Office 15\root\office15\OUTLOOK.EXE")  == .T.
		Winexec("C:\Program Files\Microsoft Office 15\root\office15\OUTLOOK.EXE /eml " + cFile)
		// WINDOWS INGLES 32 BITS --------------------------------------------------------------
	ELSEIF file("C:\Program Files\Microsoft Office\Office11\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files\Microsoft Office\Office11\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files\Microsoft Office\Office12\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files\Microsoft Office\Office12\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files\Microsoft Office\Office13\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files\Microsoft Office\Office13\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files\Microsoft Office\Office14\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files\Microsoft Office\Office14\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files\Microsoft Office\Office15\OUTLOOK.EXE /eml " + cFile)
		// WINDOWS 64 BITS ---------------------------------------------------------------------
	ELSEIF file("C:\Program Files (x86)\Microsoft Office\Office11\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files (x86)\Microsoft Office\Office11\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files (x86)\Microsoft Office\Office12\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files (x86)\Microsoft Office\Office12\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files (x86)\Microsoft Office\Office13\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files (x86)\Microsoft Office\Office13\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE /eml " + cFile)
	ELSEIF file("C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE") == .T.
		Winexec("C:\Program Files (x86)\Microsoft Office\Office15\OUTLOOK.EXE /eml " + cFile)
	ELSE
		//alert("não encontrou a pasta!")
		
		//C:\Program Files (x86)\Microsoft Office\Office14
	ENDIF
ELSE
	alert("não foi possível abrir o chamado original!")
ENDIF

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function OsMail(ALIGACOES,OLBX)

cCONTATO	:= space(50)
cPara1		:= LOWER(ALIGACOES[OLBX:NAT,07]) //space(50)
cPara2		:= space(50)
cPara3		:= space(50)
cAssunto	:= Space(80)
aPara		:= {}
nOpca		:= 0
aSZY		:= getarea()
cObs		:= space(200)

DEFINE MSDIALOG oDlgM FROM 150,60 TO 500,600 TITLE OemToAnsi( "Informe os dados para envio do e-mail" ) PIXEL

//	@ 165, 060 To 400, 600 Dialog oDLG Title OemToAnsi( "Informe os dados para envio do e-mail" )
@ 010, 009 Say OemToAnsi( "Para" )             	Size 050, 008 					OF oDlgM PIXEL
@ 010, 070 Get cCONTATO                        	Size 100, 010 					OF oDlgM PIXEL
@ 025, 009 Say OemToAnsi( "Endereco e-mail" )  	Size 050, 008 					OF oDlgM PIXEL
@ 025, 070 Get cPara1                        	Size 150, 010 					OF oDlgM PIXEL
@ 040, 009 Say OemToAnsi( "Com Copia para " )  	Size 050, 008 					OF oDlgM PIXEL
@ 040, 070 Get cPara2                        	Size 150, 010 					OF oDlgM PIXEL
@ 055, 009 Say OemToAnsi( "Com Copia para " )  	Size 050, 008 					OF oDlgM PIXEL
@ 055, 070 Get cPara3                        	Size 150, 010 					OF oDlgM PIXEL
@ 070, 009 SAY OemToAnsi("Assunto: ")			Size 150, 010 					OF oDlgM PIXEL 
@ 070, 070 GET cASSUNTO   						Size 150, 010 					OF oDlgM PIXEL 
@ 090, 009 Say OemToAnsi( "Observacoes" )    	Size 050, 008 					OF oDlgM PIXEL
@ 090, 070 Get cOBS								Size 150, 050 MEMO			OF oDlgM PIXEL

DEFINE SBUTTON FROM 150, 170 TYPE 1 ACTION (oDlgM:End(),nOpca:=1) ENABLE	OF oDlgM
DEFINE SBUTTON FROM 150, 220 TYPE 2 ACTION (oDlgM:End(),nOpca:=0) ENABLE	OF oDlgM

Activate Dialog oDLGM CENTERED

If nOpca == 1
	
	//Adiciona nova ocorrência 
	DBSELECTAREA("SZY")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SZY")+ALIGACOES[OLBX:NAT,16]+DtoS(ALIGACOES[OLBX:NAT,15]),.T.)
	RECLOCK("SZY",.T.)
	SZY->ZY_FILIAL		:= "03"
	SZY->ZY_OCORREN	:= cOBS+chr(13)+chr(10)+"Enviado E-mail para: "+alltrim(cContato)+" <"+alltrim(cPara1)+">"+CHR(13)+CHR(10)+" Com cópia para: " +Alltrim(cPara2)+" "+alltrim(cPara3)
	SZY->ZY_CHAMADO	:= AVETOR2[OLBX9:NAT][16]
	SZY->ZY_ANALIST	:= upper(UsrFullName(__CUSERID))
	SZY->ZY_DATA	:= dDatabase
	SZY->ZY_HRINI	:= time() //"00:00"
	SZY->ZY_HRFIM	:= time() //"00:00"
	MSUNLOCK()

	cHtm	:= u_HD_HTML(ALIGACOES[OLBX:NAT,16],ALIGACOES[OLBX:NAT,15])

	aAdd( aPara, {	cPara1+IIF(!EMPTY(ALLTRIM(cPara2)),";"+cPara2,"")+IIF(!EMPTY(ALLTRIM(cPara3)),";"+cPara3,"") })

	lSnd		:= u_SNDMAIL({alltrim(cPara1)			+;
	IIF(!EMPTY(ALLTRIM(cPara2)),";"+alltrim(cPara2),"")	+;
	IIF(!EMPTY(ALLTRIM(cPara3)),";"+alltrim(cPara3),"")},;
	cAssunto											,;
	cHtm												,;
	{}													)
	
	IF lSnd == .T.
		//Alert("E-mail enviado para: ", cPara1+IIF(!EMPTY(ALLTRIM(cPara2)),";"+cPara2,"")+IIF(!EMPTY(ALLTRIM(cPara3)),";"+cPara3,"") )
		Alert("E-Mail enviado com sucesso!")
				
		u_LIMPA2(cTec)
	ELSE
		Alert("Não foi possível enviar o email, verifique se os endereços estão corretos.")
	ENDIF
ELSE
	MSGINFO("Nenhum e-mail enviado !")
EndIf

RETURN

//////////////////////////////////////////////////////////////////////'///
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
STATIC FUNCTION VLDLEG()

Local oOk      	:= LoadBitmap( GetResources(), "BR_VERDE" 		)
Local oAtra    	:= LoadBitmap( GetResources(), "BR_VERMELHO" 	)
Local oQua     	:= LoadBitmap( GetResources(), "BR_AMARELO" 	)
Local oNo      	:= LoadBitmap( GetResources(), "BR_AZUL" 		)
Local cHora			:= Posicione("SZX",1,xFilial("SZX")+AVETOR2[OLBX9:NAT][16],"ZX_HRENTRE")

//"Legendas INCIDENTES"
//"VERDE 		- Chamado em aberto"
//"AMARELO 		- Chamado em andamento"
//"VERMELHO		- Chamado atrasado"
//"AZUL 			- Chamado concluido"

IF aVetor2[oLbx9:nAt,10] == "Conc" // Se estiver concluido, muda legenda para AZUL
	Return oNo
	// Se o chamado estiver aberto/sem classificação a mais de 5 dias, muda legenda para atrasado, caso contrario será verde
	// Para esta validação eu utilizo como base a data de abertura do chamado e não a data de entrega
ELSEIF aVetor2[oLbx9:nAt,10] == "Aber"
	IF dDatabase - aVetor2[oLbx9:nAt,15] >= 5
		Return oAtra
	ELSE
		Return oOk
	ENDIF
ELSE 														// validações para mudar a legenda em chamados em andamento
	IF aVetor2[oLbx9:nAt,04] == dDatabase 		// se a data de entrega for igual a database do sistema, eu verifico as horas

		IF cHora < TIME() 							// Se a Hora de entrega for menor que a hora do dia, muda o statos para vermelho
			Return oAtra
		ELSEIF aVetor2[oLbx9:nAt,10] == "Em A" // se a Hora de entrega for maior ou igual a hora do dia, mantém as cores atuais das legendas
			Return oQua
		ELSE
			Return oOk
		ENDIF
	ELSEIF aVetor2[oLbx9:nAt,04] < dDatabase 	// Se a data de entrega for menor que a database do sistema, muda legenda para vermelho
		Return oAtra
	ELSEIF aVetor2[oLbx9:nAt,10] == "Em A" 	// Se estiver em andamento muda legenda para amarelo
		Return oQua
	ELSE
		Return oOk
	ENDIF
ENDIF

RETURN nil

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function TRCLHD()

Local cMens		:= ""
Local cTMen		:= ""
Private oDlgT
Private oTipo
Private oAna
cCod				:= AVETOR2[OLBX9:NAT][16]
cAna				:= Posicione("SZX",1,xFilial("SZX")+AVETOR2[OLBX9:NAT][16],"ZX_CODANA")
cNAna				:= Posicione("SZX",1,xFilial("SZX")+AVETOR2[OLBX9:NAT][16],"ZX_ANALIST")
cTipo				:= Posicione("SZX",1,xFilial("SZX")+AVETOR2[OLBX9:NAT][16],"ZX_TIPOHD")
cDesc				:= Posicione("SZX",1,xFilial("SZX")+AVETOR2[OLBX9:NAT][16],"ZX_DESCTIP")
nOpca				:= 0

IF GETADVFVAL("SZW","ZW_TIPO",XFILIAL("SZW")+__CUSERID,4,"") == '2' .OR. ALLTRIM(__CUSERID) == "000000"
	
	DEFINE MSDIALOG oDlgT FROM 150,60 TO 400,500 TITLE OemToAnsi( "Transferência / Classificação do chamado" ) PIXEL
	
	@ 010, 009 Say OemToAnsi( "Chamado" )       	   		Size 050, 008 			OF oDlgT PIXEL
	@ 010, 050 MSGet cCod					WHEN .F.				Size 030, 010 			OF oDlgT PIXEL
	@ 025, 009 Say OemToAnsi( "Tipo HD" )  			   	Size 030, 008 			OF oDlgT PIXEL
	@ 032, 009 MSGET oTipo 		VAR cTipo 		F3 "SZZ" valid VldHdtp(@cTipo)		SIZE 030, 010 			OF oDlgT PIXEL
	@ 032, 050 Get cDesc                WHEN .F.				Size 150, 010 			OF oDlgT PIXEL
	@ 055, 009 Say OemToAnsi( "Analista" )  					Size 030, 008 			OF oDlgT PIXEL
	@ 062, 009 MSGET oAna 		VAR cAna 		F3 "SZWUS"	SIZE 030, 010 			OF oDlgT PIXEL
	@ 062, 050 GET cNAna   					WHEN .F.				Size 150, 010 			OF oDlgT PIXEL
	
	DEFINE SBUTTON FROM 100, 120 TYPE 1 ACTION (oDlgT:End(),nOpca:=1) ENABLE	OF oDlgT
	DEFINE SBUTTON FROM 100, 170 TYPE 2 ACTION (oDlgT:End(),nOpca:=0) ENABLE	OF oDlgT
	
	Activate Dialog oDLGT CENTERED
	
	If nOpca == 1
		
		IF EMPTY(ALLTRIM(CTIPO)) .OR. EMPTY(ALLTRIM(CANA))
			Alert("Por favor, preencha os dois campos antes de realizar a transferencia")
			TRCLHD()
		ELSE
			//alert("montou tela")
			dbSelectArea("SZX")
			dbSetOrder(1)
			dbSeek(xFilial("SZX")+AVETOR2[OLBX9:NAT][16])
			
			IF ALLTRIM(CANA) != ALLTRIM(SZX->ZX_CODANA) .AND. ALLTRIM(CTIPO) != SZX->ZX_TIPOHD
				//Alert("Transferencia e Classificação realizada com sucesso!")
				cMens 	:= "Chamado classificado como: " + Alltrim(cDesc)+"<br> Chamado transferido para o analista "+ Alltrim(cNAna)
				cMens2 	:= "Chamado classificado como: " + Alltrim(cDesc)+". Chamado transferido para o analista "+ Alltrim(cNAna)
				cTMen		:= "1"
			ELSEIF ALLTRIM(CANA) != ALLTRIM(SZX->ZX_CODANA)
				cMens 	:= "Chamado transferido para o analista " + Alltrim(cNAna)
				cTMen		:= "2"
			ELSEIF ALLTRIM(CTIPO) != SZX->ZX_TIPOHD
				cMens 	:= "Chamado classificado como: " + Alltrim(cDesc)
				cTMen		:= "3"
			ENDIF
			If !Empty(cMens)
				RECLOCK("SZX",.F.)
				
				IF cTIPO == SZX->ZX_TIPOHD
					
					//ALERT("NÃO FAZ NADA")
				ELSE
					IF val(substr(alltrim(str(SomaHoras(SZX->ZX_HRENTRE,SZZ->ZZ_SLAHR)/24)),1,1)) > 0
						nDias 					:= val(substr(alltrim(str(SomaHoras(SZX->ZX_HRENTRE,SZZ->ZZ_SLAHR)/24)),1,1))
					ELSE
						nDIAS						:= 0
					ENDIF
					SZX->ZX_ENTREGA			:= SZX->ZX_EMISSAO + nDias  		// CALCULO A QUANTIDADE DE DIAS PARA ENTREGA
					SZX->ZX_HRENTRE		:= IntToHora(somaHoras(SZX->ZX_HREMIS,intToHora(SomaHoras(SZX->ZX_HREMIS,SZZ->ZZ_SLAHR)/24-nDias)))
				ENDIF
				
				SZX->ZX_CODANA					:= cAna
				SZX->ZX_ANALIST				:= cNAna
				SZX->ZX_TIPOHD					:= cTipo
				SZX->ZX_DESCTIP				:= cDesc
				
				MSUNLOCK()
				
				Alert(cMens)
				
				DBSELECTAREA("SZY")
				DBSETORDER(1)
				DBSEEK(XFILIAL("SZY")+AVETOR2[OLBX9:NAT][16]+DtoS(AVETOR2[OLBX9:NAT][15]),.T.)
				RECLOCK("SZY",.T.)
				SZY->ZY_FILIAL		:= "03"
				SZY->ZY_OCORREN		:= IIF(CTMEN=="1",cMens2,cMens)
				SZY->ZY_CHAMADO		:= AVETOR2[OLBX9:NAT][16]
				SZY->ZY_ANALIST		:= upper(UsrFullName(__CUSERID))
				SZY->ZY_DATA		:= dDatabase
				SZY->ZY_HRINI		:= time() //"00:00"
				SZY->ZY_HRFIM		:= time() //"00:00"
				MSUNLOCK()
				
				
				cPara 							:= GETADVFVAL("SZW","ZW_EMAIL",XFILIAL("SZW")+cAna,1,"")
				cAssunto							:= "Chamado Número: " + AVETOR2[OLBX9:NAT][16]
				cObs								:= u_HD_HTML(AVETOR2[OLBX9:NAT][16],)//cMens 

				lSnd								:= u_SNDMAIL({alltrim(cPara)},cAssunto,cObs,{})
				
				IF lSnd == .T.
					//Alert("E-mail enviado para: ", cPara1+IIF(!EMPTY(ALLTRIM(cPara2)),";"+cPara2,"")+IIF(!EMPTY(ALLTRIM(cPara3)),";"+cPara3,"") )
					//Alert("E-Mail enviado com sucesso!")
				ENDIF
				
			ENDIF
			
		EndIf
	ELSE
		//alert("cancelou")
	ENDIF
	
	u_LIMPA2(cTec)
	
ELSE
	
	Alert("Usuario sem permissão para transferir ou classificar o chamado!")
	
ENDIF

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function HRSLA()

cTipoHD 					:= ZX_TIPOHD

dbSelectArea("SZZ")
dbSetOrder(1)
dbSeek(xFilial("SZZ")+cTipoHD)

IF NOPC == 3
	cTime 				:= time()
ELSE
	cTime					:= SZX->ZX_HREMIS
ENDIF

IF val(substr(alltrim(str(SomaHoras(SZX->ZX_HRENTRE,SZZ->ZZ_SLAHR)/24)),1,1)) > 0
	nDias 				:= val(substr(alltrim(str(SomaHoras(SZX->ZX_HRENTRE,SZZ->ZZ_SLAHR)/24)),1,1))
ELSE
	nDIAS					:= 0
ENDIF
M->ZX_ENTREGA			:= M->ZX_EMISSAO + nDias // CALCULO A QUANTIDADE DE DIAS PARA ENTREGA
M->ZX_HRENTRE			:= IntToHora(somaHoras(cTime,intToHora(SomaHoras(SZX->ZX_HREMIS,SZZ->ZZ_SLAHR)/24-nDias)))

Return cTipoHD

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function aPegaSol()

Public aSolicit	:= {}

If Select("SOL") > 0
	dbSelectArea("SOL")
	dbCloseArea()
Endif

cQrySOL 				:= " SELECT DISTINCT ZX_SOLICIT
cQrySOL 				+= " FROM "+RetSqlName("SZX")+" ZX "
cQrySOL 				+= " WHERE ZX.D_E_L_E_T_ != '*'"
IF nRadio != 2 // SE FOR UM ANALISTA/TECNICO COMUM, SÓ MOSTRA OS SOLICITANTES DE CHAMADOS ABERTOS COM ELE
	IF !EMPTY(ALLTRIM(substr(cTec,1,6))) .AND. ALLTRIM(cTec) != "*** TODOS ***"
		//cQuery 	+= " AND ZX_ANALIST = '"+alltrim(cTec)+"'"
		cQrySOL		+= " AND ZX_CODANA = '"+alltrim(substr(cTec,1,6))+"'"
	ENDIF
ENDIF
cQrySOL 				+= " ORDER BY ZX_SOLICIT ASC "

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQrySOL),"SOL", .F., .T.)

DBSELECTAREA("SOL")
DBGOTOP()

aSolicit 			:= {}

aAdd(aSolicit," *** TODOS *** ")

WHILE !EOF()
	
	aAdd(aSolicit, SOL->ZX_SOLICIT)
	
	DBSELECTAREA("SOL")
	DBSKIP()
ENDDO
Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function aPegaAna()

Public aAnalist  := {}

If Select("ANA") > 0
	dbSelectArea("ANA")
	dbCloseArea()
Endif

cQryANA := " SELECT DISTINCT *
cQryANA += " FROM "+RetSqlName("SZW")+" ZW "
cQryANA += " WHERE ZW.D_E_L_E_T_ != '*'"
cQryANA += " ORDER BY ZW_NOME, ZW_CODIGO ASC "

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQryANA),"ANA", .F., .T.)

DBSELECTAREA("ANA")
DBGOTOP()

AADD(aAnalist," *** TODOS *** ")
AADD(aAnalist,"NÃO CLASSIFICADOS ")

WHILE !EOF()
	
	aAdd(aAnalist, ANA->ZW_CODIGO+"-"+alltrim(ANA->ZW_NOME) )
	
	DBSELECTAREA("ANA")
	DBSKIP()
ENDDO

Return


Static Function VldHdtp(cTipo)

Local aAreaSZZ	:= SZZ->(GetArea())
Local lHDRet	:= .T.

DbSelectArea("SZZ")
DbSetOrder(1)
DbSeek(xFilial("SZZ")+cTipo)
If SZZ->ZZ_CLASSE == "S"
	lHDRet	:= .F.
	alert("Tipo HD sintético não pode ser selecionado!")
Else	
	lHDRet	:= .T.
EndIf


RestArea(aAreaSZZ)

Return lHDRet

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
// Exclusão de chamado acionado através da tecla F9                    //
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function DescnsTask()

Local aSZX	:= GetArea()
Local chave 				:= aVetor2[oLbx9:nAt,16]
Local ord   				:= "ENDTSK"

DBSELECTAREA("SZX")
dbsetorder(1)
dbseek(xfilial("SZX")+chave,.t.)

IF SZX->ZX_STATUS != '3'

	If !msgyesno("Deseja excluir o chamado "+chave+" ?")	
		RestArea(aSZX)
		u_LIMPA2(cTec)
		Return	
	EndIf
	RECLOCK("SZX",.F.)
	dbdelete()
	MSUNLOCK()
	
	DBSELECTAREA("SZY")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SZY")+aVetor2[oLbx9:nAt,16])
	While SZY->(!eof()) .and. xfilial("SZX")+chave == SZY->(ZY_FILIAL+ZY_CHAMADO)
		RECLOCK("SZY")
		dbdelete()
		MSUNLOCK()
	    SZY->(Dbskip())
	 End
	
	u_LIMPA2(cTec)
	
ELSE
	Alert("Este chamado já foi concluido")
ENDIF

RestArea(aSZX)

u_LIMPA2(cTec)

Return
