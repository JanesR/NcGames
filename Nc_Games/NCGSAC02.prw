#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "PROTHEUS.CH"
#include "MSGRAPHI.CH"
#include "FIVEWIN.CH"
#include "FILEIO.CH"
#INCLUDE "APWIZARD.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  01/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

USER FUNCTION NCGSAC02()
// TELA DE SENHA DE ACESSO
Private olbx,oDlgHist, lret,LALTERA, cord, ctpos, ntothr, nhralt, ltothr, creduz,cemail, ddata, ccliente, ctexto, chrini, chrfim, chrtra, chralm, ahrini , ahrtra, ahralm    , ahrfim,atpos,XTPOS,csoli, cproxhd, aproxhd, cproj, chelp,nsaldo,calmoco,cEmailCli
Private aLigacoes 		:= {}, ndutil, duthoj,oFolder


SAC02Get()

RETURN

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function SAC02Get()

Local aScreen 		:= GetScreenRes()
Local nWStage 		:= aScreen[1]-45
Local nHStage 		:= aScreen[2]-225
Local aSize     	:= MsAdvSize(.T.)
Local cRootPath:=alltrim(GetSrvProfString( "RootPath","" ))
Private cDirCham	:=AllTrim(U_MyNewSX6("SAC_DIRCHM","\SAC\Chamados\","C", "Diret๓rio dos arquivos de chamados do SAC","Diret๓rio dos arquivos de chamados do SAC","Diret๓rio dos arquivos de chamados do SAC",.F. ))

Private cPathArq		:=AllTrim(U_MyNewSX6("SAC_DIRFUL","\\192.168.0.187\totvsteste\Protheus_Data\SAC\chamados\","C", "Diret๓rio dos arquivos de chamados do SAC","Diret๓rio dos arquivos de chamados do SAC","Diret๓rio dos arquivos de chamados do SAC",.F. ))

Private aORD     		:= {}


Private aVetor   		:= {}
Private aVetor2 		:= {}
Private aVetor3  		:= {}
Private aVetor4  		:= {}
Private aVetor5  		:= {}
Private nRadio			:= 2
Private oRadio
Private oLbx     		:= Nil
Private oLbx9    		:= Nil
Private oLbx3    		:= Nil
Private oLbx4    		:= Nil
Private oLbx5    		:= Nil
Private oLbx2    		:= Nil
Private aCODCli  		:= {}
Private aCODTEC  		:= {}
Private aFIL     		:= {}
//Private aORD     		:= {}
Private aORD2    		:= {}
Private aFIL1   		:= {}
Private aFIL2    		:= {}
Private aFIL3  			:= {}
Private aHeader 		:= {}
Private aStruct			:= {}
Private aGetCpos 		:= {}
Private cTEC				:= ""
Private cTECUSR			:= ""
Private dEmissao		:= CtoD("  /  /    ")
Private dVencto			:= CtoD("  /  /    ")
Private cFIL				:= " *** TODOS *** "
Private _cORD			:= ""
Private _CORD2 			:= ""
Private cFIL1			:= ""
Private cFIL2 			:= ""
Private cFIL3			:= ""
Private nsomad 			:= 0
Private diameta			:= ddatabase
Private oFolder			:= Nil
Private aFolder 		:= { 'Agenda', 'Rela็ใo OS' }
Private aFolder2 		:= { oLbx5, oLbx2 }
Private aCpoEnchZZS	:= {}
Private nTOT_TSK 		:= 0
Private nTOT_PRJ 		:= 0
Private nTOT_HRS 		:= 0
Private OOBSMEMO                                                     // OBSERVACAO DO MEMO
Private OOBSMAIL                                                     // OBSERVACAO DO MEMO
Private OMONOAS			:= TFONT():NEW( "COURIER NEW",6,0)            	// FONTE PARA O CAMPO MEMO
Private COBSMEMO		:= ""                                           // STRING COM A DESCRICAO DO MEMO
Private cTANA			:= "1"
Private aAnalist  := {}
Private aSolicit	:= {}
Private cPesquisa:=Space(06)

DEFINE MSDIALOG oDlgSLDS TITLE OemToAnsi("SAC NC Games - login : " + capital(subs(cusuario,7,15)) ) +"    "+ dtoc(msdate()) FROM 90,15 TO 800,1250 PIXEL //FROM 90,15 TO 732,1366 PIXEL //732,1553 PIXEL

// Ativa F1 para inclusใo de nova tarefa
Set Key VK_F1 To EdList3()
// Chama fun็ใo para transferencia/classifica็ใo do chamado
Set Key VK_F2 To TRCLHD()
Set Key VK_F9 To DescnsTask()

// Monta lista de tecnicos/analistas
aPEGAANA()

// filtros possiveis
AADD(AFIL,"Em Aberto")
AADD(AFIL,"Em Andamento")
AADD(AFIL,"Concluํdas")
AADD(AFIL,"Atrasados")
AADD(AFIL,"Nใo Finalizadas")
AADD(AFIL," *** TODOS *** ")
cFIL	:= " *** TODOS *** "

// formas de ordenacao
AADD(AORD,"Entrega")
AADD(AORD,"C๓digo")
AADD(AORD,"Descri็ใo")
AADD(AORD,"Solicitante")
AADD(AORD,"Analista")
AADD(AORD,"Tipo HD")

cTANA			:= "1"
cTEC			:= " *** TODOS *** "
// fixa consultor pelo login, caso ele nao esteja cadastrado posiciona no primeiro registro
ZZV->(dbSetOrder(4))
IF ZZV->(dbSeek(XFILIAL("ZZV")+__CUSERID))
	cTecUSR		:= ZZV->ZZV_CODIGO
	cTANA		:= ZZV->ZZV_TIPO
ENDIF

IF (nPosCod 	:= aScan(aAnalist,{ |x| substr(Upper(AllTrim(x)),1,6) == cTecUSR }))>0
	cTEC		:= AANALIST[nPosCod]
ENDIF

// Monta a lista de solicitantes (com base na tabela ZZS)
aPegaSol()
cSOL				:= " *** TODOS *** "

//Tarefas

@ 005,005 Say 	OemToAnsi("Analista") 													PIXEL OF oDlgSLDS
@ 005,095 Say 	OemToAnsi("Solicitante")												PIXEL OF oDlgSLDS
@ 005,185 Say 	OemToAnsi("Filtro") 														PIXEL OF oDlgSLDS
@ 005,275 Say 	OemToAnsi("Ordem") 														PIXEL OF oDlgSLDS
@ 005,365 Say 	OemToAnsi("Total Incidentes ") 										PIXEL OF oDlgSLDS
@ 005,455 Say 	OemToAnsi("Pesquisar")			 										PIXEL OF oDlgSLDS

IF cTANA == "2"
	@ 005,410 Radio oRadio Var nRadio Items "Administrador", "Analista"	SIZE 050,009 	PIXEL OF oDlgSLDS	ON CHANGE {|| LIMPA2(cTec) }
	
	@ 010,500 BUTTON "Transf./Classf."  	     					  				SIZE 45,12 		PIXEL OF oDlgSLDS ACTION TRCLHD()
ENDIF

//Tarefas
@ 012,365 MSGET nTOT_TSK 	Picture "@E 99,999"  	When .F.  				SIZE 40,9 		PIXEL OF oDlgSLDS

IF cTANA == "2"
	@ 012,005 MSCOMBOBOX oSer1 VAR cTEC 	ITEMS aAnalist  					SIZE 080, 10 	PIXEL OF oDlgSLDS ON CHANGE LIMPA2(cTec)
ELSE
	@ 012,005 MSGET oSer1 		VAR cTEC 				When .F.					SIZE 080, 10 	PIXEL OF oDlgSLDS ON CHANGE LIMPA2(cTec)
ENDIF

@ 012,095 MSCOMBOBOX oSer1 		VAR cSol 	ITEMS aSolicit 							SIZE 080, 10 	PIXEL OF oDlgSLDS ON CHANGE LIMPA2(cTec)
@ 012,185 MSCOMBOBOX oSer1 		VAR cFIL 	ITEMS aFIL  							SIZE 080, 10 	PIXEL OF oDlgSLDS ON CHANGE LIMPA2(cTec)
@ 012,275 MSCOMBOBOX oOrder 		VAR _cORD 	ITEMS aORD  							SIZE 080, 10 	PIXEL OF oDlgSLDS ON CHANGE SAC02Ordena()
@ 012,455 MSGET cPesquisa 			Picture "@!"  		Valid SAC02Val()				  				SIZE 40,9 		PIXEL OF oDlgSLDS

@ 160,550 BUTTON "Excluir/SPAM"  	     											SIZE 045, 12 	PIXEL OF oDlgSLDS ACTION DescnsTask()
@ 175,550 BUTTON "Refresh"  	     											   	SIZE 045, 12 	PIXEL OF oDlgSLDS ACTION LIMPA2(cTec)
@ 190,550 BUTTON "Follow Up"  	    							 					SIZE 045, 12 	PIXEL OF oDlgSLDS ACTION CadZZT()
@ 205,550 BUTTON "E-Mail"  	     													SIZE 045, 12 	PIXEL OF oDlgSLDS ACTION osmail(AVETOR2, OLBX9)
@ 220,550 BUTTON "Concluir"  	 							    					   SIZE 045, 12 	PIXEL OF oDlgSLDS ACTION fEndTask()
@ 235,550 Button "Conhecimento"														Size 045, 12 	PIXEL OF oDlgSLDS Action ZZSConhec("1")
@ 250,550 Button OemToAnsi("Ajuda")  		 									Size 045, 12 	PIXEL OF oDlgSLDS Action fAjuda()
@ 265,550 Button OemToAnsi("Enviar Chamado")  								   Size 045, 12 	PIXEL OF oDlgSLDS Action U_SAC02SendMail()
@ 280,550 Button OemToAnsi("Cadastro E-mail")  								   Size 045, 12 	PIXEL OF oDlgSLDS Action U_SAC02Email()

/////////////////////////////////////////////

// lista de Tarefas Pendentes
LISTATSK()
// lista hist๓rico para cada chamado (box 'Hist๓rico')
OCORRENCIAS()

Activate Dialog oDlgSLDS Centered

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
Local aCPOZZS  := {}

dbSelectArea("ZZS")
aSalvAmb := GetArea()
dbSetOrder(1)
dbSeek(xFilial("ZZS"))

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

cQuery := " SELECT * "
cQuery += " FROM "+RetSqlName("ZZS")+" ZZS "
cQuery += " WHERE ZZS_FILIAL ='"+xFilial("ZZS")+"'"
cQuery += " And  ZZS_CODIGO 	Between '     ' And 'ZZZZZZ'"
cQuery += " AND ZZS_STATUS <> 'X'" //desconsiderar os status de chamados excluidos
cQuery += " And ZZS.D_E_L_E_T_ = ' '"

IF nRadio != 1
	IF !EMPTY(ALLTRIM(substr(cTec,1,6))) .AND. ALLTRIM(cTec) != "*** TODOS ***"
		cQuery += " AND ZZS_CODANA = '"+alltrim(substr(cTec,1,6))+"'"
	ENDIF
ENDIF
IF !EMPTY(ALLTRIM(cSol)) .AND. ALLTRIM(cSol) != "*** TODOS ***"
	cQuery += " AND ZZS_SOLICI = '"+alltrim(cSol)+"'"
ENDIF

IF !("TODOS"$cFIL)
	IF ("Autorizadas"$cFIL)
		cQuery += " AND ZZS_AUTORI = '1'"
		cQuery += " AND ZZS_STATUS != '3'"
	ELSEIF ("Nใo Aut"$cFIL)
		cQuery += " AND ZZS_AUTORI = '2'"
		cQuery += " AND ZZS_STATUS != '3'"
	ELSEIF ("Aberto"$cFIL)
		cQuery += " AND ZZS_STATUS IN ('1')"
	ELSEIF ("Andamento"$cFIL)
		cQuery += " AND ZZS_STATUS = '2'"
	ELSEIF ("Conclu"$cFIL)
		cQuery += " AND ZZS_STATUS = '3'"
	ELSEIF ("Atrasa"$cFIL)
		cQuery += " AND ZZS_STATUS = '4'"
		cQuery += " AND ZZS_STATUS != '3'"
	ENDIF
	//cQuery += " AND ZZS_STATUS = '"+cFil+"'"
ENDIF
IF ("C๓digo"$_cORD)
	cQuery += " ORDER BY ZZS_CODIGO " //, ZZS_ITERAC"
ELSEIF ("Descri็ใo"$_cORD)
	cQuery += " ORDER BY ZZS_DESCRI, ZZS_CODIGO ASC "
ELSEIF ("Solicitante"$_cORD)
	cQuery += " ORDER BY ZZS_SOLICI, ZZS_CODIGO ASC "
ELSEIF ("Entrega"$_cORD)
	cQuery += " ORDER BY ZZS_ENTREG, ZZS_HRENTR,ZZS_CODIGO DESC "
ELSEIF ("Emiss"$_cORD)
	cQuery += " ORDER BY ZZS_EMISSA DESC"
ELSEIF ("Analista"$_cORD)
	cQuery += " ORDER BY ZZS_ANALIS ASC"
ELSEIF ("Tipo"$_cORD)
	cQuery += " ORDER BY ZZS_DESCTI ASC"
ENDIF

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

DBSELECTAREA("TRB")
DBGOTOP()

WHILE !EOF()
	
	lSaldo := IF(Stod(TRB->ZZS_ENTREG) < ddatabase,"3",IF(StoD(TRB->ZZS_ENTREG) == ddatabase,"2","1"))
	//" ", "Codigo", "Tarefa", "Abertura", "Entrega", "Solicitante" , "Analista",  "Stat", "Tipo", "Baixa", "Tipo Chamado"
	
	aAdd( aVetor2, { lSaldo								, ; // 01
	" " 														, ; // 02
	TRB->ZZS_DESCRI											, ; // 03
	StoD(TRB->ZZS_ENTREG)								, ; // 04
	X3COMBO("ZZS_AUTORI", TRB->ZZS_AUTORI)			, ; // 05
	TRB->ZZS_HRSPRE										, ; // 06
	TRB->ZZS_SOLICI										, ; // 07
	UPPER(TRB->ZZS_CLIENT)								, ; // 08
	UPPER(TRB->ZZS_ANALIS)								, ; // 09
	LEFT(X3COMBO("ZZS_STATUS", TRB->ZZS_STATUS),4)	, ; // 10
	TRB->ZZS_PROJET										, ; // 11
	X3COMBO("ZZS_TIPO", TRB->ZZS_TIPO)					, ; // 12
	TRB->ZZS_INDIC											, ; // 13
	StoD(TRB->ZZS_DTBAIX)								, ; // 14
	StoD(TRB->ZZS_EMISSA)								, ; // 15
	TRB->ZZS_CODIGO 										, ; // 16
	TRB->ZZS_DESCTI										} ) // 17
	
	DBSELECTAREA("TRB")
	dbSkip()
EndDo

If Len( aVetor2 ) == 0
	aAdd( aVetor2, { "", "  " , "SEM INCIDENTES", CTOD("") , "", 0 , "", "", "","","","", "",CTOD(""), CTOD(""), "", "" } )
Endif

@ 30,05 LISTBOX oLbx9 FIELDS HEADER " ", "Codigo", "Tipo Chamado", "Incidente", "Abertura","Baixa", "Solicitante", "Analista", "Stat", "Entrega" SIZE 600,120 OF oDlgSLDS PIXEL ON DBLCLICK( EdList4())
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
Local cFilZZT:=xFilial("ZZT")

ZZS->(dbsetorder(1))
ZZT->(dbsetorder(1))
If ZZS->(dbseek(xfilial("ZZS")+aVetor2[oLbx9:nAt,16]))
	ZZT->(DbSeek(cFilZZT+ZZS->ZZS_CODIGO ))
	
	ZZT->(DbEval( {|| RecLock("ZZS",.F. ),DbDelete(),MsUnLock() },{||.T.},  ZZT_FILIAL+ZZT_CHAMADO==cFilZZT+ZZS->ZZS_CODIGO  ))
	
	ZZS->(RecLock("ZZS",.F. ))
	ZZS->(DbDelete())
	ZZS->(MsUnLock())
	
	
	
EndIf

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function EdList4()

Local aAlter			:= {}
Local cAliasE 			:= "ZZS"
Local aAlterEnch		:= {}
Local aPos				:= {000,000,400,600}
Local nModelo			:= 3
Local lF3 				:= .F.
Local lMemoria			:= .T.
Local lColumn			:= .F.
Local caTela 			:= ""
Local lNoFolder		:= .F.
Local lProperty		:= .F.
Private cCadastro 		:= "Incidentes"
Private lOk				:= .T.
Private oDlg
Private oGetD
Private oEnch
Private aTELA[0][0]
Private aGETS[0]



// SE O STATUS NรO FOR "CONCLUIDO" OU SE O ANALISTA OU O USUARIO DO SISTEMA FOREM ADMINISTRADORES
// POSSIBILITA A ALTERAวรO, CASO CONTRARIO, MANDA UMA MENSAGEM DE AVISO
nOpc 					:= 4

DBSELECTAREA(cAliasE)
dbsetorder(1)
dbseek(xfilial(cAliasE)+aVetor2[oLbx9:nAt,16],.t.)

IF ZZS->ZZS_TIPOHD	=="999999" .And. !MsgYesNo("Chamado conluido!!"+CRLF+"Deseja reabrir?")
	Return
EndIf

RegToMemory("ZZS", If(nOpc==3,.T.,.F.))

aButtons 			:= {}
AAdd(aButtons,{"Conhecimento"    			    	,{|| ZZSConhec("2") }   		,"Conhecimento"	})
AAdd(aButtons,{"Follow Up"   	 					,{|| CadZZT() }   				,"Follow Up"		})
AAdd(aButtons,{"E-Mail"  	 	 					,{|| osmail(AVETOR2, OLBX9) }	,"E-Mail"			})

IF cTANA == "2"
	AAdd(aButtons,{"Transf./Classf."  	 	 	,{|| TRCLHD() }					,"Transf./Classf."})
ENDIF

DEFINE MSDIALOG oDlg TITLE cCadastro FROM 000,000 TO 500,1100 PIXEL

Enchoice(cAliasE,RECNO(),nOpc,,,,aCpoEnchZZS,aPos,/*aAlterEnch*/,nModelo,,,,oDlg,lF3,lMemoria,lColumn,caTela,lNoFolder,lProperty)

ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{||  If( GRAVA_TSK(4),oDlg:End(),)   },{||oDlg:End()},,@aButtons))



Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function GRAVA_TSK(nOpc)


IF EMPTY(ALLTRIM(M->ZZS_SOLICI))
	ALERT("Campo Solicitante nao preechido")
	lRet := .F.
ELSEIF EMPTY(ALLTRIM(M->ZZS_TIPOHD))
	ALERT("Campo Tipo Chamado nao preechido")
	lRet := .F.
ELSE
	lRet := .T.
	
	ZZS->(dbSetOrder(1))
	
	lInclusao :=!(ZZS->(dbseek(xfilial("ZZS")+aVetor2[oLbx9:nAt,16])))
	
	If !lInclusao
		GrvZZT()
	EndIf
	
	RECLOCK("ZZS",lInclusao)
	ZZS->ZZS_FILIAL			:= xFilial("ZZS")
	ZZS->ZZS_DESCRI			:= M->ZZS_DESCRI
	ZZS->ZZS_ENTREG 			:= M->ZZS_ENTREG
	ZZS->ZZS_AUTORI 			:= M->ZZS_AUTORI
	ZZS->ZZS_HRSPRE 			:= M->ZZS_HRSPRE
	ZZS->ZZS_SOLICI 			:= M->ZZS_SOLICI
	ZZS->ZZS_CODCLI 			:= M->ZZS_CODCLI
	ZZS->ZZS_CODANA				:= M->ZZS_CODANA
	ZZS->ZZS_CLIENT 			:= M->ZZS_CLIENT
	ZZS->ZZS_ANALIS		    	:= UPPER(M->ZZS_ANALIS)
	ZZS->ZZS_STATUS				:= M->ZZS_STATUS
	ZZS->ZZS_TIPO				:= M->ZZS_TIPO
	ZZS->ZZS_INDIC				:= M->ZZS_INDIC
	IF M->ZZS_STATUS	== "3"
		ZZS->ZZS_DTBAIX 		:= DDATABASE //M->ZZS_DTBAIX
		ZZS->ZZS_ORD				:= "ENDTSK"
	ELSE
		ZZS->ZZS_DTBAIX 		:= M->ZZS_DTBAIX
	ENDIF
	ZZS->ZZS_EMISSA			:= M->ZZS_EMISSA
	ZZS->ZZS_PROJET			:= M->ZZS_PROJET
	ZZS->ZZS_OBS				:= M->ZZS_OBS
	ZZS->ZZS_TIPOHD			:= alltrim(M->ZZS_TIPOHD)
	ZZS->ZZS_DESCTI			:= M->ZZS_DESCTI
	ZZS->ZZS_HRENTR			:= M->ZZS_HRENTR
	ZZS->ZZS_CC					:= M->ZZS_CC
	
	IF lInclusao
		ZZS->ZZS_CODIGO 		:= M->ZZS_CODIGO
		CONFIRMSX8()
		ZZS->ZZS_HREMIS			:= TIME()
		
	ELSE
		ZZS->ZZS_CODIGO 		:= M->ZZS_CODIGO
	ENDIF
	MSUNLOCK()
	
	// atualiza array do objeto da tela
	IF lInclusao
		lSaldo 					:= IF(ZZS->ZZS_ENTREG < ddatabase,"3",IF(ZZS->ZZS_ENTREG == ddatabase,"2","1"))
		// 								" ", "Codigo", "Tipo Chamado", "Tarefa", "Abertura","Baixa", "Solicitante", "Analista", "Stat", "Entrega" SIZE 450,090 OF oDlgSLDS PIXEL	ON DBLCLICK( EdList4())
		// ordem dos campos no ARRAY	   , 16		 , 17			 , 03      , 15        , 14    , 07           , 09        , 10    , 04
		//aAdd( aVetor2, 	{ lSaldo, " " , ZZS_DESCTI , ZZS_DESCRI, ZZS_EMISSA, ZZS_DTBAIX, ZZS_SOLICI, UPPER(ZZS_ANALIS), LEFT(X3COMBO("ZZS_STATUS", ZZS->ZZS_STATUS),4), ZZS_ENTREG} )
		
		aAdd( aVetor2, { lSaldo							, ; // 01
		" " 													, ; // 02
		ZZS_DESCRI											, ; // 03
		ZZS_ENTREG											, ; // 04
		X3COMBO("ZZS_AUTORI", ZZS_AUTORI)			, ; // 05
		ZZS_HRSPRE											, ; // 06
		ZZS_SOLICI											, ; // 07
		UPPER(ZZS_CLIENT)									, ; // 08
		UPPER(ZZS_ANALIS)									, ; // 09
		LEFT(X3COMBO("ZZS_STATUS", ZZS_STATUS),4)	, ; // 10
		ZZS_PROJET											, ; // 11
		X3COMBO("ZZS_TIPO", ZZS_TIPO)					, ; // 12
		ZZS_INDIC												, ; // 13
		ZZS_DTBAIX											, ; // 14
		ZZS_EMISSA											, ; // 15
		ZZS_CODIGO 											, ; // 16
		ZZS_DESCTI											} ) // 17
	ELSE
		//HEADER " ", "Codigo", "Tipo Chamado", "Incidente", "Abertura","Baixa", "Solicitante", "Analista", "Stat", "Entrega"
		aVetor2[oLbx9:nAt,02]	:= M->ZZS_CODIGO
		aVetor2[oLbx9:nAt,03]	:= M->ZZS_DESCTI
		aVetor2[oLbx9:nAt,04]	:= M->ZZS_DESCRI
		aVetor2[oLbx9:nAt,05]	:= M->ZZS_EMISSA
		aVetor2[oLbx9:nAt,06]	:= M->ZZS_DTBAIX
		aVetor2[oLbx9:nAt,07]	:= LEFT(aVetor2[oLbx9:nAt,7],20)
		aVetor2[oLbx9:nAt,08]	:= UPPER(M->ZZS_ANALIS)
		aVetor2[oLbx9:nAt,09]	:= X3COMBO("ZZS_STATUS", M->ZZS_STATUS)
		aVetor2[oLbx9:nAt,10]	:= M->ZZS_ENTREG
		
	ENDIF
ENDIF
LIMPA2(cTec)

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

dbSelectArea("ZZT")
aSalvAmb 				:= GetArea()

nTOT_HRS 				:= 0

nTOT_PRJ 				:= len(aVetor3)

oFolder := TFolder():New(155,005,{'Historico','E-mail'},{'','',''},oDlgSLDS,,,,.T.,.F.,530,200)

//@ 155,005 TO 275,535 LABEL "HISTORICO" OF oDlgSLDS PIXEL

@ 01,001 GET OOBSMEMO VAR COBSMEMO OF oFolder:aDialogs[1] MEMO SIZE 523,189 PIXEL READONLY

If Empty(aVetor2[oLbx9:nAt,16])
	OOBSMAIL :=TIBrowser():New (01, 07, 523, 189, "about:blank", oFolder:aDialogs[2] )
Else
	OOBSMAIL:=TIBrowser():New (01, 07, 523, 189, cPathArq+aVetor2[oLbx9:nAt,16]+"\"+aVetor2[oLbx9:nAt,16]+".html", oFolder:aDialogs[2] )
EndIf





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
Static Function LIMPA2(cTec)

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
cQuery += " FROM "+RetSqlName("ZZS")+" ZZS "
cQuery += " WHERE ZZS.D_E_L_E_T_ != '*'"
cQuery += " AND ZZS_FILIAL = '"+cFilAnt+"'"
IF nRadio != 1
	//IF !EMPTY(ALLTRIM(substr(cTec,1,6))) .AND. ALLTRIM(cTec) != "*** TODOS ***"
	If "NรO CLASSIFICADOS" $ cTec
		cQuery += " AND ZZS_CODANA = ' '
	ElseIf alltrim(cTec) != "*** TODOS ***"
		//cQuery += " AND ZZS_ANALIS = '"+alltrim(cTec)+"'"
		cQuery += " AND ZZS_CODANA = '"+alltrim(substr(cTec,1,6))+"'"
	ENDIF
ENDIF
IF !EMPTY(ALLTRIM(cSol)) .AND. ALLTRIM(cSol) != "*** TODOS ***"
	cQuery += " AND ZZS_SOLICI = '"+alltrim(cSol)+"'"
ENDIF

IF !("TODOS"$cFIL)
	IF ("Autorizadas"$cFIL)
		cQuery += " AND ZZS_AUTORI = '1'"
		cQuery += " AND ZZS_STATUS != '3'"
	ELSEIF ("Nใo Aut"$cFIL)
		cQuery += " AND ZZS_AUTORI = '2'"
		cQuery += " AND ZZS_STATUS != '3'"
	ELSEIF ("Aberto"$cFIL)
		cQuery += " AND ZZS_STATUS IN ('1')"
	ELSEIF ("Andamento"$cFIL)
		cQuery += " AND ZZS_STATUS = '2'"
	ELSEIF ("Conclu"$cFIL)
		cQuery += " AND ZZS_STATUS = '3'"
	ELSEIF ("Atrasa"$cFIL)
		cQuery += " AND ZZS_STATUS = '4'"
		cQuery += " AND ZZS_STATUS != '3'"
	ELSEIF ("Nใo Final"$cFIL)
		cQuery += " AND ZZS_STATUS != '3'"
	ENDIF
	
ENDIF
IF ("C๓digo"$_cORD)
	cQuery += " ORDER BY ZZS_CODIGO DESC" //, ZZS_ITERAC"
ELSEIF ("Descri็ใo"$_cORD)
	cQuery += " ORDER BY ZZS_DESCRI, ZZS_CODIGO ASC "
ELSEIF ("Solicitante"$_cORD)
	cQuery += " ORDER BY ZZS_SOLICI, ZZS_CODIGO ASC "
ELSEIF ("Entrega"$_cORD)
	cQuery += " ORDER BY ZZS_ENTREG, ZZS_HRENTR, ZZS_CODIGO DESC "
ELSEIF ("Emiss"$_cORD)
	cQuery += " ORDER BY ZZS_EMISSA DESC"
ELSEIF ("Analista"$_cORD)
	cQuery += " ORDER BY ZZS_ANALIS ASC"
ELSEIF ("Tipo"$_cORD)
	cQuery += " ORDER BY ZZS_DESCTI ASC"
ENDIF
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

DBSELECTAREA("TRB")
DBGOTOP()

WHILE !EOF()
	
	lSaldo := IF(Stod(TRB->ZZS_ENTREG) < ddatabase,"3",IF(StoD(TRB->ZZS_ENTREG) == ddatabase,"2","1"))
	
	aAdd( aVetor2, { lSaldo								, ;
	" " 														, ;
	TRB->ZZS_DESCRI											, ;
	StoD(TRB->ZZS_ENTREG)								, ;
	X3COMBO("ZZS_AUTORI", TRB->ZZS_AUTORI)			, ;
	TRB->ZZS_HRSPRE										, ;
	TRB->ZZS_SOLICI										, ;
	UPPER(TRB->ZZS_CLIENT)								, ;
	UPPER(TRB->ZZS_ANALIS)								, ;
	LEFT(X3COMBO("ZZS_STATUS", TRB->ZZS_STATUS),4)	, ;
	TRB->ZZS_PROJET										, ;
	X3COMBO("ZZS_TIPO", TRB->ZZS_TIPO)					, ;
	TRB->ZZS_INDIC											, ;
	StoD(TRB->ZZS_DTBAIX)								, ;
	StoD(TRB->ZZS_EMISSA)								, ;
	TRB->ZZS_CODIGO 										, ;
	TRB->ZZS_DESCTI										} )
	
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

// Atualiza o box "hist๓rico"
REFRMEMO(OOBSMEMO, AVETOR2, OLBX9 )

Return .t.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function fAjuda()

ctx := "Teclas de Atalho:" 																+ chr(13) + chr(10)
ctx += "F1 		- Inclui Nova Tarefa"													+ chr(13) + chr(10)
ctx += "F2 		- Transferencia e classifica็ใo "									+ chr(13) + chr(10)
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

cAliasE 	:= "ZZS"
DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cAliasE)
While !Eof() .And. SX3->X3_ARQUIVO == cAliasE
	If !(SX3->X3_CAMPO $ "ZZS_FILIAL") .And. cNivel >= SX3->X3_NIVEL .And.;
		X3Uso(SX3->X3_USADO)
		AADD(aCpoEnchZZS,SX3->X3_CAMPO)
	EndIf
	DbSkip()
End
Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function fEndTask(chave,_stat,ord)

AZZS 						:= GetArea()

If !MsgYesNo("Confirma a conclusใo do chamado "+aVetor2[oLbx9:nAt,16]+"?")
	Return
EndIf


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

DBSELECTAREA("ZZS")
dbsetorder(1)
dbseek(xfilial("ZZS")+chave)


	
	RECLOCK("ZZS",.F.)
	ZZS->ZZS_STATUS 	:= _stat
	ZZS->ZZS_ORD 		:= ord
	ZZS->ZZS_DTBAIX 	:= ddatabase
	ZZS->ZZS_TIPOHD	:="999999"
	ZZS->ZZS_DESCTI	:=Posicione("ZZU",1,xFilial("ZZU")+ZZS->ZZS_TIPOHD,"ZZU_DESC")
	ZZS->(MSUNLOCK())
	
	RECLOCK("ZZT",.T.)
	ZZT->ZZT_FILIAL		:= xFilial("ZZT")
	ZZT->ZZT_OCORRE		:= "##########Chamado concluido"
	ZZT->ZZT_CHAMAD		:= AVETOR2[OLBX9:NAT][16]
	ZZT->ZZT_DATA			:= dDatabase
	ZZT->ZZT_ANALIS		:= upper(UsrFullName(__CUSERID))
	ZZT->ZZT_HRINI			:= time() //"00:00"
	ZZT->ZZT_HRFIM			:= time() //"00:00"
	ZZT->(MSUNLOCK())
	
	LIMPA2(cTec)
	




RestArea(aZZS)

LIMPA2(cTec)

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
STATIC FUNCTION REFRMEMO(OOBSMEMO,ALIGACOES,OLBX)
//aZZT			:= getarea()
COBSMEMO		:= ""
ZZT->(DBSETORDER(1))

ZZT->(DBSEEK(XFILIAL("ZZT")+ALIGACOES[OLBX:NAT,16]))
DO WHILE ZZT->(!EOF()) .AND. ALIGACOES[OLBX:NAT,16] == ZZT->ZZT_CHAMAD
	COBSMEMO += CRLF+"Data: "+DTOC(ZZT->ZZT_DATA)+" เs: "+ZZT->ZZT_HRINI+"("+AllTrim(ZZT->ZZT_ANALIS)+")"+CRLF //+" "+Replicate("-",100)+CHR(13) + CHR(10)
	COBSMEMO += ZZT->ZZT_OCORRE+CRLF+Replicate("-",150)
	ZZT->(DBSKIP())
ENDDO

OOBSMEMO:REFRESH()

If Empty(aVetor2[oLbx9:nAt,16])
	OOBSMAIL:Navigate("www.ncgames.com.br")
Else
	OOBSMAIL:Navigate(cPathArq+aVetor2[oLbx9:nAt,16]+"\"+aVetor2[oLbx9:nAt,16]+".html")
EndIf
//restarea(aZZT)
RETURN .T.

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function SAC02HIST()
AxCadastro("ZZT","HISTORICO")
Return(nil)


/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function CADZZT()

Local aArea		:= GetArea()
Local aAreaZZS	:= ZZS->(GetArea())

Private cCadastro 	:= "SAC - Hist๓rico" 				// tํtulo da tela
Private nOpca 			:= 0
Private aButtons 		:= {}
Private aParam			:= {}


	aAdd( aParam,  {|| before() 			} )				// antes da abertura
	aAdd( aParam,  {|| ZZTOK() 				} )				// ao clicar no botao ok
	aAdd( aParam,  {|| ZZTTrans() 			} )				// durante a transacao
	aAdd( aParam,  {|| ZZTFim() 			} ) 				// termino da transacao
	
	RegToMemory("ZZT",.T.)
	
	nOpca 				:= AxInclui("ZZT",ZZT->(Recno()),3,,/*U_CADZZT()*/,,,.F.,,,aParam,,,.T.,,,,,)
	
	DbSelectArea("ZZS")
	DbSetOrder(1)
	If DbSeek(xFilial("ZZS")+AVETOR2[OLBX9:NAT][16])
		reclock("ZZS",.f.)
		ZZS->ZZS_STATUS	:= "2"
		msunlock()
	EndIf
	
	RestArea(aAreaZZS)
	
	LIMPA2(cTec)
	




RestArea(aArea)

Return nOpca
//Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function BEFORE()

M->ZZT_CHAMAD	:= AVETOR2[OLBX9:NAT][16]
M->ZZT_DATA		:= dDatabase
M->ZZT_HRINI		:= time() //"00:00"
M->ZZT_HRFIM		:= time() //"00:00"

RETURN

// programas utilizados para validar o axInclui()
Static Function ZZTOK()

LIMPA2(cTec)
Return .T.

Static Function ZZTTrans()
LIMPA2(cTec)
Return .T.

Static Function ZZTFim()
LIMPA2(cTec)
Return .T.

/////////////////////////////////////////////////////////////////////////////////////////
// Verifica se o analista e administrador, se for tem permissao para alterar os campos //
// Caso contrario nao tem permissao, esta valida็ใo serแ vแlida apenas para altera็๕es //
// Impossibilitando que usuแrios comuns alterem informa็๕es importantes do chamado     //
// nOpc - 3 = Inclusใo                                                                 //
// nOpc - 4 = Altera็ใo                                                                //
// Retorna .T. ou .F.                                                                  //
/////////////////////////////////////////////////////////////////////////////////////////
User Function ZZSVLD()

Private lRet	:= .F.

IF nOPC != 3
	IF ALLTRIM(__CUSERID) == "000000"
		lRet := .T.
	ELSE
		IF GETADVFVAL("ZZV","ZZV_TIPO",XFILIAL("ZZV")+__CUSERID,4,"") == '2'				//ADMIN
			lRet := .T.
		ELSE
			IF EMPTY(M->ZZS_CODANA)
				IF GETADVFVAL("ZZV","ZZV_TIPO",XFILIAL("ZZV")+__CUSERID,4,"") == '2'		//ADMIN
					lRet	:= .T.
				ELSE
					lRet	:= .F.
				ENDIF
			ELSE
				IF GETADVFVAL("ZZV","ZZV_TIPO",XFILIAL("ZZV")+M->ZZS_CODANA,1,"") == '2'	//ADMIN
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
Static Function ZZSConhec(cProc)
Local cFile:=Iif(cProc == "1",AVETOR2[OLBX9:NAT][16],M->ZZS_CODIGO)

//APAGA ARQUIVOS TEMPORARIOS
IF FILE(GETTEMPPATH()+cFile+".eml")
	winexec("del "+GETTEMPPATH()+cFile+".eml")
ENDIF
CpyS2T(cDirCham+cFile+"\"+cFile+".eml",GETTEMPPATH(), .T.)

cFile:=GETTEMPPATH()+cFile+".eml"

IF FILE(cFile)
	
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
		//alert("nใo encontrou a pasta!")
		
		//C:\Program Files (x86)\Microsoft Office\Office14
	ENDIF
ELSE
	alert("nใo foi possํvel abrir o chamado original!")
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
aZZT		:= getarea()
cObs		:= space(200)

DEFINE MSDIALOG oDlgM FROM 150,60 TO 500,600 TITLE OemToAnsi( "Informe os dados para envio do e-mail" ) PIXEL

//	@ 165, 060 To 400, 600 Dialog oDLG Title OemToAnsi( "Informe os dados para envio do e-mail" )
//@ 010, 009 Say OemToAnsi( "Para" )             	Size 050, 008 					OF oDlgM PIXEL
//@ 010, 070 Get cCONTATO                        	Size 100, 010 					OF oDlgM PIXEL
@ 025, 009 Say OemToAnsi( "Para" ) 					Size 050, 008 					OF oDlgM PIXEL
@ 025, 070 Get cPara1                          	Size 150, 010 					OF oDlgM PIXEL
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
	
	//Adiciona nova ocorr๊ncia
	DBSELECTAREA("ZZT")
	DBSETORDER(1)
	DBSEEK(XFILIAL("ZZT")+ALIGACOES[OLBX:NAT,16]+DtoS(ALIGACOES[OLBX:NAT,15]),.T.)
	RECLOCK("ZZT",.T.)
	ZZT->ZZT_FILIAL		:= xFilial("ZZT")
	ZZT->ZZT_OCORRE	:= cOBS+chr(13)+chr(10)+"Enviado E-mail para: "+alltrim(cContato)+" <"+alltrim(cPara1)+">"+CHR(13)+CHR(10)+" Com c๓pia para: " +Alltrim(cPara2)+" "+alltrim(cPara3)
	ZZT->ZZT_CHAMAD	:= AVETOR2[OLBX9:NAT][16]
	ZZT->ZZT_ANALIS	:= upper(UsrFullName(__CUSERID))
	ZZT->ZZT_DATA	:= dDatabase
	ZZT->ZZT_HRINI	:= time() //"00:00"
	ZZT->ZZT_HRFIM	:= time() //"00:00"
	MSUNLOCK()
	
	cHtm	:= u_NCGSAC03( ALIGACOES[OLBX:NAT,16],ALIGACOES[OLBX:NAT,15] ,cOBS  )
	
	aPara:={	cPara1,cPara2,cPara3 }
	
	lSnd		:= SNDMAIL(aPara,cAssunto,cHtm,{})
	
	IF lSnd
		//Alert("E-mail enviado para: ", cPara1+IIF(!EMPTY(ALLTRIM(cPara2)),";"+cPara2,"")+IIF(!EMPTY(ALLTRIM(cPara3)),";"+cPara3,"") )
		Alert("E-Mail enviado com sucesso!")
		
		LIMPA2(cTec)
	ELSE
		Alert("Nใo foi possํvel enviar o email, verifique se os endere็os estใo corretos.")
	ENDIF
ELSE
	MSGINFO("Nenhum e-mail enviado !")
EndIf

RETURN

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
STATIC FUNCTION VLDLEG()
Local dData			:= MsDate()
Local oVerde      	:= LoadBitmap( GetResources(), "BR_VERDE" 		)
Local oVermelho    	:= LoadBitmap( GetResources(), "BR_VERMELHO" 	)
Local oAmarelo     	:= LoadBitmap( GetResources(), "BR_AMARELO" 	)
Local oAzul	      	:= LoadBitmap( GetResources(), "BR_AZUL" 		)
Local oRetorno

ZZS->(DbSetOrder(1))
ZZS->(dbseek(xfilial("ZZS")+aVetor2[oLbx9:nAt,16]))

//"Legendas INCIDENTES"
//"VERDE 		- Chamado em aberto"
//"AMARELO 		- Chamado em andamento"
//"VERMELHO		- Chamado atrasado"
//"AZUL 			- Chamado concluido"

oRetorno:=oVerde
If ZZS->ZZS_TIPOHD=="999999"
	oRetorno:=oAzul
ElseIf dData==ZZS->ZZS_ENTREG
	If ZZS->ZZS_HRENTR<Time()
		oRetorno:=oVermelho
	Else
		oRetorno:=oAmarelo
	EndIf
ElseIf dData>ZZS->ZZS_ENTREG
	If ZZS->ZZS_ENTREG<dData
		oRetorno:=oVermelho
	Else
		If ZZS->ZZS_HRENTR<Time()
			oRetorno:=oVermelho
		Else
			oRetorno:=oAmarelo
		EndIf
	EndIf
EndiF

RETURN oRetorno

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
cAna				:= Posicione("ZZS",1,xFilial("ZZS")+AVETOR2[OLBX9:NAT][16],"ZZS_CODANA")
cNAna				:= Posicione("ZZS",1,xFilial("ZZS")+AVETOR2[OLBX9:NAT][16],"ZZS_ANALIS")
cTipo				:= Posicione("ZZS",1,xFilial("ZZS")+AVETOR2[OLBX9:NAT][16],"ZZS_TIPOHD")
cDesc				:= Posicione("ZZS",1,xFilial("ZZS")+AVETOR2[OLBX9:NAT][16],"ZZS_DESCTI")
nOpca				:= 0

IF GETADVFVAL("ZZV","ZZV_TIPO",XFILIAL("ZZV")+__CUSERID,4,"") == '2' .OR. ALLTRIM(__CUSERID) == "000000"
	
	DEFINE MSDIALOG oDlgT FROM 150,60 TO 400,500 TITLE OemToAnsi( "Transfer๊ncia / Classifica็ใo do chamado" ) PIXEL
	
	@ 010, 009 Say OemToAnsi( "Chamado" )       	   		Size 050, 008 			OF oDlgT PIXEL
	@ 010, 050 MSGet cCod					WHEN .F.				Size 030, 010 			OF oDlgT PIXEL
	@ 025, 009 Say OemToAnsi( "Tipo HD" )  			   	Size 030, 008 			OF oDlgT PIXEL
	@ 032, 009 MSGET oTipo 		VAR cTipo 		F3 "ZZU" valid VldHdtp(@cTipo)		SIZE 030, 010 			OF oDlgT PIXEL
	@ 032, 050 Get cDesc                WHEN .F.				Size 150, 010 			OF oDlgT PIXEL
	@ 055, 009 Say OemToAnsi( "Analista" )  					Size 030, 008 			OF oDlgT PIXEL
	@ 062, 009 MSGET oAna 		VAR cAna 		F3 "ZZV_1"	SIZE 030, 010 			OF oDlgT PIXEL
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
			dbSelectArea("ZZS")
			dbSetOrder(1)
			dbSeek(xFilial("ZZS")+AVETOR2[OLBX9:NAT][16])
			
			IF ALLTRIM(CANA) != ALLTRIM(ZZS->ZZS_CODANA) .AND. ALLTRIM(CTIPO) != ZZS->ZZS_TIPOHD
				//Alert("Transferencia e Classifica็ใo realizada com sucesso!")
				cMens 	:= "Chamado classificado como: " + Alltrim(cDesc)+"<br> Chamado transferido para o analista "+ Alltrim(cNAna)
				cMens2 	:= "Chamado classificado como: " + Alltrim(cDesc)+". Chamado transferido para o analista "+ Alltrim(cNAna)
				cTMen		:= "1"
			ELSEIF ALLTRIM(CANA) != ALLTRIM(ZZS->ZZS_CODANA)
				cMens 	:= "Chamado transferido para o analista " + Alltrim(cNAna)
				cTMen		:= "2"
			ELSEIF ALLTRIM(CTIPO) != ZZS->ZZS_TIPOHD
				cMens 	:= "Chamado classificado como: " + Alltrim(cDesc)
				cTMen		:= "3"
			ENDIF
			If !Empty(cMens)
				RECLOCK("ZZS",.F.)
				
				IF cTIPO == ZZS->ZZS_TIPOHD
					
					//ALERT("NรO FAZ NADA")
				ELSE
					IF val(substr(alltrim(str(SomaHoras(ZZS->ZZS_HRENTR,ZZU->ZZU_SLAHR)/24)),1,1)) > 0
						nDias 					:= val(substr(alltrim(str(SomaHoras(ZZS->ZZS_HRENTR,ZZU->ZZU_SLAHR)/24)),1,1))
					ELSE
						nDIAS						:= 0
					ENDIF
					ZZS->ZZS_ENTREG			:= ZZS->ZZS_EMISSA + nDias  		// CALCULO A QUANTIDADE DE DIAS PARA ENTREGA
					ZZS->ZZS_HRENTR		:= IntToHora(somaHoras(ZZS->ZZS_HREMIS,intToHora(SomaHoras(ZZS->ZZS_HREMIS,ZZU->ZZU_SLAHR)/24-nDias)))
				ENDIF
				
				ZZS->ZZS_CODANA					:= cAna
				ZZS->ZZS_ANALIS				:= cNAna
				ZZS->ZZS_TIPOHD					:= cTipo
				ZZS->ZZS_DESCTI				:= cDesc
				
				MSUNLOCK()
				
				Alert(cMens)
				
				DBSELECTAREA("ZZT")
				DBSETORDER(1)
				DBSEEK(XFILIAL("ZZT")+AVETOR2[OLBX9:NAT][16]+DtoS(AVETOR2[OLBX9:NAT][15]),.T.)
				RECLOCK("ZZT",.T.)
				ZZT->ZZT_FILIAL		:= xFilial("ZZT")
				ZZT->ZZT_OCORRE		:= IIF(CTMEN=="1",cMens2,cMens)
				ZZT->ZZT_CHAMAD		:= AVETOR2[OLBX9:NAT][16]
				ZZT->ZZT_ANALIS		:= upper(UsrFullName(__CUSERID))
				ZZT->ZZT_DATA		:= dDatabase
				ZZT->ZZT_HRINI		:= time() //"00:00"
				ZZT->ZZT_HRFIM		:= time() //"00:00"
				MSUNLOCK()
				
				
				cPara 							:= GETADVFVAL("ZZV","ZZV_EMAIL",XFILIAL("ZZV")+cAna,1,"")
				cAssunto							:= "Chamado N๚mero: " + AVETOR2[OLBX9:NAT][16]
				cObs								:= u_NCGSAC03(AVETOR2[OLBX9:NAT][16],)//cMens
				
				lSnd								:= SNDMAIL({alltrim(cPara)},cAssunto,cObs,{})
				
				IF lSnd == .T.
					//Alert("E-mail enviado para: ", cPara1+IIF(!EMPTY(ALLTRIM(cPara2)),";"+cPara2,"")+IIF(!EMPTY(ALLTRIM(cPara3)),";"+cPara3,"") )
					//Alert("E-Mail enviado com sucesso!")
				ENDIF
				
			ENDIF
			
		EndIf
	ELSE
		//alert("cancelou")
	ENDIF
	
	LIMPA2(cTec)
	
ELSE
	
	Alert("Usuario sem permissใo para transferir ou classificar o chamado!")
	
ENDIF

Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function SAC02SLA()
Local aDados:=U_SAC01SLA(M->ZZS_TIPOHD)

M->ZZS_ENTREG			:= aDados[1]
M->ZZS_HRENTR			:= aDados[2]

Return M->ZZS_TIPOHD
/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function aPegaSol()
Local cQrySOL

If Select("SOL") > 0
	SOL->(	dbCloseArea())
Endif

cQrySOL 				:= " SELECT DISTINCT ZZS_SOLICI
cQrySOL 				+= " FROM "+RetSqlName("ZZS")+" ZZS "
cQrySOL 				+= " WHERE ZZS.D_E_L_E_T_ != '*'"
IF nRadio != 2 // SE FOR UM ANALISTA/TECNICO COMUM, Sำ MOSTRA OS SOLICITANTES DE CHAMADOS ABERTOS COM ELE
	IF !EMPTY(ALLTRIM(substr(cTec,1,6))) .AND. ALLTRIM(cTec) != "*** TODOS ***"
		//cQuery 	+= " AND ZZS_ANALIS = '"+alltrim(cTec)+"'"
		cQrySOL		+= " AND ZZS_CODANA = '"+alltrim(substr(cTec,1,6))+"'"
	ENDIF
ENDIF
cQrySOL 				+= " ORDER BY ZZS_SOLICI ASC "

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQrySOL),"SOL", .F., .T.)

DBSELECTAREA("SOL")
DBGOTOP()

aSolicit 			:= {}

aAdd(aSolicit," *** TODOS *** ")

WHILE !EOF()
	
	aAdd(aSolicit, SOL->ZZS_SOLICI)
	
	DBSELECTAREA("SOL")
	DBSKIP()
ENDDO
Return

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function aPegaAna()


If Select("ANA") > 0
	dbSelectArea("ANA")
	dbCloseArea()
Endif

cQryANA := " SELECT DISTINCT *
cQryANA += " FROM "+RetSqlName("ZZV")+" ZZV "
cQryANA += " WHERE ZZV.D_E_L_E_T_ != '*'"
cQryANA += " ORDER BY ZZV_NOME, ZZV_CODIGO ASC "

dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQryANA),"ANA", .F., .T.)

DBSELECTAREA("ANA")
DBGOTOP()

AADD(aAnalist," *** TODOS *** ")
AADD(aAnalist,"NรO CLASSIFICADOS ")

WHILE !EOF()
	
	aAdd(aAnalist, ANA->ZZV_CODIGO+"-"+alltrim(ANA->ZZV_NOME) )
	
	DBSELECTAREA("ANA")
	DBSKIP()
ENDDO

Return


Static Function VldHdtp(cTipo)

Local aAreaZZU	:= ZZU->(GetArea())
Local lHDRet	:= .T.

DbSelectArea("ZZU")
DbSetOrder(1)
DbSeek(xFilial("ZZU")+cTipo)
If ZZU->ZZU_CLASSE == "S"
	lHDRet	:= .F.
	alert("Tipo HD sint้tico nใo pode ser selecionado!")
Else
	lHDRet	:= .T.
EndIf


RestArea(aAreaZZU)

Return lHDRet

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
// Exclusใo de chamado acionado atrav้s da tecla F9                    //
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function DescnsTask()

Local aZZS	:= GetArea()
Local chave 				:= aVetor2[oLbx9:nAt,16]
Local ord   				:= "ENDTSK"

DBSELECTAREA("ZZS")
dbsetorder(1)
If !ZZS->(dbseek(xfilial("ZZS")+chave))
	MsgStop("Chamado nใo encontrado")
	Return	
EndIf	

IF ZZS->ZZS_STATUS != '3'
	
	If !msgyesno("Deseja excluir o chamado "+ZZS->ZZS_CODIGO+" ?")
		RestArea(aZZS)
		LIMPA2(cTec)
		Return
	EndIf
	RECLOCK("ZZS",.F.)
	ZZS->(dbdelete())
	ZZS->(MSUNLOCK())
	
	DBSELECTAREA("ZZT")
	DBSETORDER(1)
	DBSEEK(XFILIAL("ZZT")+aVetor2[oLbx9:nAt,16])
	While ZZT->(!eof()) .and. xfilial("ZZS")+chave == ZZT->(ZZT_FILIAL+ZZT_CHAMAD)
		RECLOCK("ZZT")
		dbdelete()
		MSUNLOCK()
		ZZT->(Dbskip())
	End
	
	LIMPA2(cTec)
	
	
	//aDirectory:= Directory ( cPathArq+aVetor2[oLbx9:nAt,16]+"\*.*" )
	//For nInd:=1 To Len(aDirectory)
		//Ferase(cPathArq+aVetor2[oLbx9:nAt,16]+"\"+aDirectory[nInd,1])
	//Next
	//DirRemove(cPathArq+aVetor2[oLbx9:nAt,16])
	
	
ELSE
	Alert("Este chamado jแ foi concluido")
ENDIF

RestArea(aZZS)

LIMPA2(cTec)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  01/26/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SAC02SendMail(cMailCli,cNumero)
Local cBody:=""
Local cHtml:="SAC\SAC.htm"
Local cNomeArq:=E_Create(,.F.)


Default cMailCli:=""
Default cNumero :=""

ZZS->(dbsetorder(1))
ZZS->(dbseek(xfilial("ZZS")+aVetor2[oLbx9:nAt,16]))

cMailCli:=ZZS->ZZS_SOLICI
cNumero :=ZZS->ZZS_CODIGO


If !MsgYesNo("Confirma envio de abertura do chamado "+cNumero+" para "+cMailCli+"?")
	Return
EndIf


If !Empty(ZZS->ZZS_OBS) .And. Aviso("SAC", AllTrim(ZZS->ZZS_OBS)+CRLF+"Reenviar?"+CRLF+CRLF,{"Sim","Nใo"},3) == 2
	Return
EndIf

oHtml	:= TWFHTML():New( cHtml )
oHtml:ValByName( "NUMERO_CHAMADO",	cNumero )

oHtml:SaveFile( cNomeArq+".htm" )
oHtml:Free()
cBody :=WFLoadFile(cNomeArq+".htm" )
If SNDMAIL({cMailCli},"NC Games Abertura Chamado "+cNumero,cBody,{})
	MsgInfo("Chamado enviado com sucesso ")
	ZZS->(RecLock("ZZS",.F.))
	ZZS->ZZS_OBS:="Chamado enviado para "+AllTrim(cMailCli)+" em "+DTOC(MsDate())+" เs "+Time()+CRLF
	ZZS->(MsUnLock())
Else
	MsgInfo("Ocorreu um erro ao enviar o e-mail")
EndIf

Return

User Function SACUSER()
AxCadastro("ZZV","ANALISTAS")
Return(nil)


/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function TPSAC()
AxCadastro("ZZU","TIPO CHAMADO")
Return(nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SAC02Email()
Local oDlg
Local aCpoEnchZZS:={"ZZS_SOLICI","ZZS_CLIENT"}
Local lF3 				:= .F.
Local lMemoria			:= .T.
Local lColumn			:= .F.
Local caTela 			:= ""
Local lNoFolder		:= .F.
Local lProperty		:= .F.
Local nModelo			:= 3
Local aPos				:= {000,000,400,600}
Local lGravar			:=.F.
Local lCpoFone       :=ZZS->(FieldPos("ZZS_FONE"))>0
Local lCpoDDD       :=ZZS->(FieldPos("ZZS_DDD"))>0

If lCpoDDD
	aadd(aCpoEnchZZS,"ZZS_DDD")
EndIf


If lCpoFone
	aadd(aCpoEnchZZS,"ZZS_FONE")
EndIf


aadd(aCpoEnchZZS,"NOUSER")

ZZS->(dbsetorder(1))
ZZS->(dbseek(xfilial("ZZS")+aVetor2[oLbx9:nAt,16]))

RegToMemory("ZZS",.F.)

DEFINE MSDIALOG oDlg TITLE "Cadastro E-mail" FROM 000,000 TO 500,1100 PIXEL

Enchoice("ZZS",ZZS->(RECNO()),4,,,,aCpoEnchZZS,aPos,/*aAlterEnch*/,nModelo,,,,oDlg,lF3,lMemoria,lColumn,caTela,lNoFolder,lProperty)

ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{|| oDlg:End() ,lGravar:=.T.},{||oDlg:End() }))

If lGravar
	ZZS->(RecLock("ZZS",.F.))
	ZZS->ZZS_SOLICI:=M->ZZS_SOLICI
	ZZS->ZZS_CLIENT:=M->ZZS_CLIENT
	If lCpoFone
		ZZS->ZZS_FONE	:=M->ZZS_FONE
	EndIf
	If lCpoDDD
		ZZS->ZZS_DDD	:=M->ZZS_DDD
	EndIf
	ZZS->(MsUnLock())
EndIf
LIMPA2(cTec)
Return(nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SNDMAIL(aPARA,cASSUNTO,_MSG,aFiles)

// ENVIA EMAIL
XSERV 		:= 	U_MyNewSX6(	"SA_SMTPSRV", ;
"ncmail", ;
"C", ;
"Servidor SMTP do SAC",;
"Servidor SMTP do SAC",;
"Servidor SMTP do SAC",;
.F. )

XCONTA 		:= 	U_MyNewSX6(	"SA_RELACNT", ;
"sac@ncgames.com.br", ;
"C", ;
"Conta a ser utilizada no envio de E-Mail do SAC",;
"Conta a ser utilizada no envio de E-Mail do SAC",;
"Conta a ser utilizada no envio de E-Mail do SAC",;
.F. )

XPASS	 		:= 	U_MyNewSX6(	"SA_ENVPSW", ;
"S4c.123", ;
"C", ;
"Senha de autentica็ใo SMTP do e-mail do SAC",;
"Senha de autentica็ใo SMTP do e-mail do SAC",;
"Senha de autentica็ใo SMTP do e-mail do SAC",;
.F. )
XCTA2 		:= XCONTA
lAutentica	:= GETMV("MV_RELAUTH")

CONNECT SMTP SERVER XSERV ACCOUNT XCONTA PASSWORD XPASS RESULT lResult

IF lAutentica .And. lResult
	lResult:=mailauth(XCTA2,XPASS)
ENDIF

aResul	:= ""

If lResult
	
	FOR i := 1 TO LEN(aPARA)
		if !empty(alltrim(aPARA[i]))
			SEND MAIL FROM XCONTA to  aPARA[i] SUBJECT cASSUNTO BODY _msg FORMAT TEXT RESULT lResult //ATTACHMENT aFiles[1]
			If !lResult
				//Erro no envio do email
				GET MAIL ERROR cError
				Help(" ",1,"ATENCAO",,"SEND MAIL" + cError,4,5)
			else
				aResul:=aResul+","+alltrim(lower(aPARA[i]))//msginfo("Mensagem enviada para " + alltrim(lower(APARA[i])) + " com sucesso")
			EndIf
		endif
		
	NEXT i
	
	DISCONNECT SMTP SERVER
	
	//msginfo("Mensagem enviada para " + alltrim(aResul) + " com sucesso")
Else
	//Erro na conexao com o SMTP Server
	GET MAIL ERROR cError
	Help(" ",1,"ATENCAO",,"SMTP" + cError,4,5)
EndIf

//restarea(XSC5)

RETURN lResult
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function SAC02Ordena()
LIMPA2(cTec)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  03/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvZZT()
Local cMensagem:="##########"
Local cStatus	:=ZZS->ZZS_TIPOHD      

If ZZS->ZZS_TIPOHD==M->ZZS_TIPOHD
	Return
EndIf

ZZT->(RecLock("ZZT",.T.))
ZZT->ZZT_FILIAL	:=xFilial("ZZT")
ZZT->ZZT_DATA		:=MsDate()
ZZT->ZZT_HRINI		:= time()
ZZT->ZZT_HRFIM		:= time()
ZZT->ZZT_CHAMAD	:=M->ZZS_CODIGO
ZZT->ZZT_TPSAC    :=ZZS->ZZS_TIPOHD
ZZT->ZZT_DESCTI   :=ZZS->ZZS_DESCTI
ZZT->ZZT_DTPREV   :=ZZS->ZZS_ENTREG
ZZT->ZZT_HRPREV   :=ZZS->ZZS_HRENTR
ZZT->ZZT_DTREAL   :=MsDate()
ZZT->ZZT_HRREAL   :=Time()

If cStatus=="999999"
	cMensagem+="Chamado reaberto"
Else
	cMensagem+="Tipo Chamado alterado de ["+ZZS->ZZS_TIPOHD+"]("+AllTrim(ZZS->ZZS_DESCTI)+") para "+M->ZZS_TIPOHD+"("+AllTrim(M->ZZS_DESCTI)+")
	cMensagem+=CRLF
	cMensagem+="Data Prevista Conclusใo:"+DTOC(ZZT->ZZT_DTPREV)+"  Hora Prevista Conclusใo:"+ZZT->ZZT_HRPREV+CRLF
	cMensagem+="Data Real Conclusใo    :"+DTOC(ZZT->ZZT_DTREAL)+"  Hora Real Conclusใo    :"+ZZT->ZZT_HRREAL

	cMensagem+=CRLF
EndIf

ZZT->ZZT_OCORRE	:= cMensagem
ZZT->ZZT_ANALIS	:= upper(UsrFullName(__CUSERID))
ZZT->(MSUNLOCK())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  03/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SAC02Val()
Local nAscan:=0

If !Empty(cPesquisa)
	If (nAscan:=Ascan(oLbx9:aArray,{|a|a[16]==cPesquisa } ))>0
		oLbx9:nAt:=nAscan
		oLbx9:Refresh()
	Else
		MsgInfo("C๓digo nใo encontrado.")
	EndIf
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC02  บAutor  ณMicrosiga           บ Data ณ  03/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SAC02ZZS()
Local cIDAdim	:=AllTrim(U_MyNewSX6("SAC_ADMIN","000000;000269","C", "Administradores do SAC","Administradores do SAC","Administradores do SAC",.F. ))

//If __CUSERID$cIDAdim
	AxCadastro("ZZS","Chamados")
//Else
	//MsgStop("Sem acesso a manuten็ใo de chamado")
//EndIf	
Return
