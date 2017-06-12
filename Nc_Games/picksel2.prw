#INCLUDE "RWMAKE.CH"
#INCLUDE "TopConn.ch"
#INCLUDE "vKey.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณPICKSEL2   ณ Autor ณERICH BUTTNER         ณ Data ณ 03.09.10   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ TELA DE SELEวรO DOS PEDIDOS PARA PICK LIST                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ 		                                                        ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PICKSEL2()

Local aCpoBrw
Local aCpoTmp
Local cArq
Private CPERG := "PICK"
Private lInverte := .T.
Private cmarca   := GetMark()
Private oMark
Private cPesq     := Space(50)
Private lCheck1   := .t.
Private lCheck2   := .t.
Private lCheck3   := .t.
Private cCombo, cOrdem	:= " "
Private aOrdem	:= {"PEDIDO","ESTADO","MUNICIPIO","TRANSPORTADORA","TPAGEND","DTAGEND"}
Private cPESQUISA:= SPACE(200), oPesquisa
Private _aMarcados:={} 

VALIDPERG(CPERG)

IF !pergunte(cPerg,.T.)
	RETURN .F.
ENDIF


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Query ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤู

cQuery := " SELECT C5_MARK  OK, C5_NUM PED, C5_CLIENTE CLIENTE, C5_LOJACLI LOJA, C5_NOMCLI NOME, C5_TIPAGEN TPAGEND, C5_DTAGEND DTAGEND, "
cQuery += " C5_EMISSAO EMISSAO, C5_TPFRETE TPFRETE, C5_FRETE FRETE, C5_PESOL PESOLIQ, C5_PBRUTO PESOB, "
cQuery += " C5_VOLUME1 VOLUME, C5_TRANSP TRANSPORTADORA, A4_NOME NMTRANSP, A1_EST ESTADO, A1_BAIRRO BAIRRO, "
cQuery += " A1_MUN MUNICIPIO, C5_STAPICK "
cQuery += " FROM SC5010, SA4010, SA1010 "
cQuery += " WHERE C5_CLIENTE = A1_COD AND C5_LOJACLI = A1_LOJA AND C5_TRANSP = A4_COD "//AND C5_NOTA = '         ' " AND C5_STAPICK <> '3 ' "
cQuery += " AND C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' AND C5_EMISSAO <='"+DTOS(MV_PAR02)+ "' AND C5_LIBEROK = 'S' "
cQuery += " AND (C5_CODBL = '  ' OR (A1_RISCO = 'A'AND (A1_VENCLC >= '"+DTOS(DDATABASE)+"'OR A1_VENCLC = ' '))) 
cQuery += " AND C5_FILIAL = '"+XFILIAL("SC5")+"' AND SC5010.D_E_L_E_T_ <> '*' "
cQuery += " AND SA4010.D_E_L_E_T_ <> '*' AND SA1010.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY PED "

cQuery := ChangeQuery(cQuery)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fecha Alias se estiver em Uso ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Select("TRB") >0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

If Select("TMPWM") >0
	dbSelectArea("TMPWM")
	dbCloseArea()
Endif


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Area de Trabalho executando a Query ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
TCQUERY cQuery New Alias "TRB"
dbSelectArea("TRB")

dbGoTop()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta arquivo temporario ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aCpoTmp:={}
aAdd(aCpoTmp,{"OK"        		,"C",02,0})
aAdd(aCpoTmp,{"NumPed"      	,"C",06,0})
aAdd(aCpoTmp,{"Cliente"   		,"C",06,0})
aAdd(aCpoTmp,{"Loja"    		,"C",02,0})
aAdd(aCpoTmp,{"Nome"     		,"C",30,2})
aAdd(aCpoTmp,{"DtEmissao"	  	,"D",08,0})
aAdd(aCpoTmp,{"TpFrete"  		,"C",01,0})
aAdd(aCpoTmp,{"Frete"	  		,"N",14,2})
aAdd(aCpoTmp,{"PesoLiq"			,"N",14,2})
aAdd(aCpoTmp,{"PesoBruto"		,"N",14,2})
aAdd(aCpoTmp,{"Volume"     		,"N",14,2})
aAdd(aCpoTmp,{"Transp"		 	,"C",06,0})
aAdd(aCpoTmp,{"NomeTransp"		,"C",30,0})
aAdd(aCpoTmp,{"Estado"     		,"C",02,0})
aAdd(aCpoTmp,{"Bairro"		 	,"C",15,0})
aAdd(aCpoTmp,{"Municipio"	 	,"C",30,0})
aAdd(aCpoTmp,{"TpAgend"		 	,"C",1,0})
aAdd(aCpoTmp,{"DtAgend" 		,"D",8,0})

cArq:=Criatrab(aCpoTmp,.T.)
dbUseArea(.t.,,cArq,"TMPWM")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Alimenta arquivo temporario ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("TMPWM")

While !TRB->(EOF())
	lWMS	:= VerWMS(TRB->PED)
	If lWMS
		DbSelectArea("TMPWM")
		RecLock("TMPWM",.T.)
		TMPWM->OK			:= TRB->OK
		TMPWM->NumPed		:= TRB->PED
		TMPWM->Cliente	:= TRB->CLIENTE
		TMPWM->Loja		:= TRB->LOJA
		TMPWM->Nome		:= TRB->NOME
		TMPWM->DtEmissao	:= STOD(TRB->EMISSAO)
		TMPWM->TpFrete	:= TRB->TPFRETE
		TMPWM->Frete		:= TRB->FRETE
		TMPWM->PesoLiq	:= TRB->PESOLIQ
		TMPWM->PesoBruto	:= TRB->PESOB
		TMPWM->Volume		:= TRB->VOLUME
		TMPWM->Transp		:= TRB->TRANSPORTADORA
		TMPWM->NomeTransp	:= TRB->NMTRANSP
		TMPWM->Estado		:= TRB->ESTADO
		TMPWM->Bairro		:= TRB->BAIRRO
		TMPWM->Municipio	:= TRB->MUNICIPIO
		TMPWM->TPAGEND	:= TRB->TPAGEND
		TMPWM->DTAGEND	:= STOD(TRB->DTAGEND)

	TMPWM->(MsUnlock())
	
	EndIf
	
	DbSelectArea("TRB")
	TRB->(dbSkip())
	
End

_cArq1   := CriaTrab(NIL,.F.)
_cChave1 := "TMPWM->NUMPED"
IndRegua("TMPWM",_cArq1,_cChave1,,,"Selecionando Regs...")

_cArq2   := CriaTrab(NIL,.F.)
_cChave2 := "TMPWM->ESTADO"
IndRegua("TMPWM",_cArq2,_cChave2,,,"Selecionando Regs...")
		
_cArq3   := CriaTrab(NIL,.F.)
_cChave3 := "TMPWM->MUNICIPIO"
IndRegua("TMPWM",_cArq3,_cChave3,,,"Selecionando Regs...")

_cArq4   := CriaTrab(NIL,.F.)
_cChave4 := "TMPWM->TRANSP"
IndRegua("TMPWM",_cArq4,_cChave4,,,"Selecionando Regs...")			

_cArq5   := CriaTrab(NIL,.F.)
_cChave5 := "TMPWM->TPAGEND"
IndRegua("TMPWM",_cArq5,_cChave5,,,"Selecionando Regs...")

_cArq6   := CriaTrab(NIL,.F.)
_cChave6 := "TMPWM->DTAGEND"
IndRegua("TMPWM",_cArq6,_cChave6,,,"Selecionando Regs...")

dbClearIndex()
dbSetIndex(_cArq1+OrdBagExt())
dbSetIndex(_cArq2+OrdBagExt())
dbSetIndex(_cArq3+OrdBagExt())
dbSetIndex(_cArq4+OrdBagExt())
dbSetIndex(_cArq5+OrdBagExt())
dbSetIndex(_cArq6+OrdBagExt())

TRB->(dbCloseArea())

_aCores:={}
bped := {|| fRetLEG()}
AADD(_aCores,{'Eval(bped)==""' ,"BR_VERDE"})
AADD(_aCores,{'Eval(bped)=="1"',"BR_AMARELO"})


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com definicoes dos campos do browse ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aCpoBrw:={}
aAdd(aCpoBrw,{"OK"			,"" ,"" 				,"@!"						  })
aAdd(aCpoBrw,{"NumPed"    	,""	,"Num Ped"         	,"@!"               ,"06","0"})
aAdd(aCpoBrw,{"Cliente"    	,""	,"Cliente"         	,"@!"               ,"06","0"})
aAdd(aCpoBrw,{"Loja"    	,""	,"Loja"         	,"@!"               ,"02","0"})
aAdd(aCpoBrw,{"Nome"    	,""	,"Nome"         	,"@!"               ,"30","0"})
aAdd(aCpoBrw,{"DtEmissao"	,""	,"Dt. Emissao"     	,		            ,"08","0"})
aAdd(aCpoBrw,{"TpFrete"  	,""	,"Tp. Frete"       	,"@!"               ,"01","0"})
aAdd(aCpoBrw,{"Frete"    	,""	,"Frete"         	,"@E 9999,999.99999","14","2"})
aAdd(aCpoBrw,{"PesoLiq" 	,""	,"Peso Liq."       	,"@E 9999,999.99999","14","2"})
aAdd(aCpoBrw,{"PesoBruto"	,""	,"Peso Bruto"     	,"@E 9999,999.99999","14","2"})
aAdd(aCpoBrw,{"Volume"    	,""	,"Volume"         	,"@E 9999,999.99999","14","2"})
aAdd(aCpoBrw,{"Transp"    	,""	,"Transp."         	,"@!"               ,"06","0"})
aAdd(aCpoBrw,{"NomeTransp"	,""	,"Nome Transp"  	,"@!"               ,"30","0"})
aAdd(aCpoBrw,{"Estado"     	,""	,"Estado"          	,"@!"               ,"02","0"})
aAdd(aCpoBrw,{"Bairro"    	,""	,"Bairro"         	,"@!"               ,"15","0"})
aAdd(aCpoBrw,{"Municipio" 	,""	,"Municipio"      	,"@!"               ,"30","0"})
aAdd(aCpoBrw,{"TpAgend"    	,""	,"Tp. Agendamento" 	,"@!"               ,"01","0"})
aAdd(aCpoBrw,{"DtAgend"	,""	,"Dt. Agendamento"     	,		            ,"08","0"})

@ 000,000 TO 650,935 DIALOG oDlgLib TITLE " PEDIDOS " //850,1135

oMark:=MsSelect():New("TMPWM","OK","",aCpoBRW,@lInverte,@cMarca,{035,005,280,465},,,,,) //_aCores)//{015,005,400,630,565}
oMark:oBrowse:lHasMark := .T.
oMark:oBrowse:lCanAllMark:=.T.

@ 003,006 To 034,315 Title OemToAnsi("Pedido")
@ 016,007 Say "Ordem: "
@ 016,025 ComboBox cOrdem ITEMS aOrdem SIZE 60,50 Object oOrdem 
@ 016,085 Get    cPESQUISA			   Size 200,10 Object oPesquisa 
oOrdem:bChange := {|| FORDENA(CORDEM),oMark:oBrowse:Refresh(.T.)}

@ 016,350 Button "Pesquisar"       		Size 40,13 Action Procura(CORDEM)
//@ 300,300 Button "Legenda"      		Size 40,13 Action LEGENDA() 				 		Object oBtnRet
@ 300,340 Button "Visualizar"      		Size 40,13 Action U_VERPV2(TMPWM->NUMPED) 			Object oBtnRet
@ 300,380 Button "Clas Indicativa" 		Size 40,13 Action PREPREL(CMARCA,'1') 				Object oBtnREL
@ 300,420 Button "Sair"            		Size 40,13 Action IIF(PREPSAIR(),Close(oDlgLIb),"")	Object oBtnInv

dbSelectArea("TMPWM")
dbGoTop()
While !TMPWM->(EOF())
	RecLock("TMPWM",.f.)
	TMPWM->OK    := ThisMark()
	TMPWM->(MsUnlock())
	TMPWM->(dbSkip())
End
dbGoTop()

oMark:oBrowse:Refresh()

ACTIVATE DIALOG oDlgLib CENTERED

TMPWM->(dbCloseArea())

FERASE(cArq+OrdBagext())
FERASE(cArq)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fInverte บAutor  ณERICH BUTTNER		 บ Data ณ  03/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Inverte Selecoes do Browse                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fInverte()
dbSelectArea("TMPWM")
dbGoTop()
While !EOF()
	RecLock("TMPWM",.f.)
	TMPWM->OK := If(Marked("OK"),ThisMark(),GetMark())
	TMPWM->(MsUnlock())
	dbSkip()
End
dbGoTop()

oMark:oBrowse:Refresh()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRetLEG   บAutor  ณ ERICH BUTTNER		 บ Data ณ  03/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao que avalia os Pedido de Venda para classi- 		  บฑฑ
ฑฑบ          ณ fica-lo corretamente na legenda.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fRetLEG()

Local cRet
Local aArea  := GetArea()

If EOF()
	Return("")
Endif

dbSelectArea("SC5")
dbSetOrder(1)
dbSeek(xFilial("SC5")+TMPWM->NumPed)

If Found()
	If EMPTY(SC5->C5_STAPICK)
		cRet := ""
	ElseIf SC5->C5_STAPICK = '1 '
		cRet := "1"
	Else
		cRet := "2"
	Endif
endif

RestArea(aArea)

Return(cRet)  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVERPV		บAutor  ณ ERICH BUTTNER		 บ Data ณ  03/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUNCAO QUE VISUALIZA OS ITENS DO PEDIDO DE VENDA COM OS    บฑฑ
ฑฑบ          ณ BLOQUEIOS DE ESTOQUE				                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Function U_VERPV2(CPED)
Local aArea		:= GetArea()									// Salva a area atual
Local cCodLig	:= ""											// Codigo do atendimento
Local oDlgHist													// Tela do Historico
Local oObsMemo                                      			// Observacao do MEMO
Local oMonoAs  	:= TFont():New( "Courier New",6,0) 				// Fonte para o campo Memo
Local oGetHist													// Itens de cada atendimento
Local oBmp 		:= LoadBitmap( GetResources(), "BRANCO" )   	// Objeto BMP para exibir a cor da legenda
Local nOpcA		:= 0                                            // Opcao de OK ou CANCELA
Local lRet 		:= .T.                                          // Retorno da funcao
Private cObsMemo 	:= ""											// String com a descricao do MEMO

CursorWait()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณSeleciona todas a ligaoes desse cliente indexando por ordem de ligaao decrescenteณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aLigacoes := {}
aCC       := {}
LCOORD := .F.

DbSelectArea("SC9")
DBSETORDER(1)
DBSEEK(XFILIAL("SC9")+CPED,.T.)

While !Eof() .AND. SC9->C9_PEDIDO == CPED
	
	
	AAdd(aCC, { IF(EMPTY(SC9->C9_BLEST),"","X") , ;
	SC9->C9_ITEM , ;
	SC9->C9_PRODUTO , ;
	LEFT(GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+SC9->C9_PRODUTO,1,""),30) ,   ;
	GETADVFVAL("SC6","C6_QTDVEN",XFILIAL("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM,1,"") , ;
	SC9->C9_QTDLIB  , ;
	SC9->C9_DATALIB , ;
	GETADVFVAL("SC6","C6_TES",XFILIAL("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM,1,"") , ;
	GETADVFVAL("SC6","C6_CF", XFILIAL("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM,1,"") , ;
	SC9->C9_LOCAL })	                                            
	DbSkip()
End

aLigacoes := ASort(aCC,,,{|x,y|x[2]<y[2]})

If Len(aLigacoes) <= 0
	Help(" ",1,"SEMDADOS" )
	CursorArrow()
	Return(.F.)
Endif

DEFINE MSDIALOG oDlgHist FROM 50,001 TO 500,1000 TITLE "Itens do Pedido de Venda " + CPED  PIXEL  //"Historico" //750SC5->C5_NUM

@08,05 LISTBOX oLbx FIELDS HEADER "Blq.Est","Item","Produto","Descricao","Qt.Vendida","Qt.Liberada","Dt.Liberacao","TES","CFOP","Armazem" SIZE 470,200 OF oDlgHist PIXEL //365


oLbx:SetArray(aLigacoes)
oLbx:bLine:={||{	aLigacoes[oLbx:nAt,1],;
						aLigacoes[oLbx:nAt,2],;
						aLigacoes[oLbx:nAt,3],;
						aLigacoes[oLbx:nAt,4],;
						aLigacoes[oLbx:nAt,5],;
						aLigacoes[oLbx:nAt,6],;
						aLigacoes[oLbx:nAt,7],;
						aLigacoes[oLbx:nAt,8],;
						aLigacoes[oLbx:nAt,9],;
						aLigacoes[oLbx:nAt,10]  }}

oLbx:Refresh()
oLbx:SetFocus(.T.)



DEFINE SBUTTON FROM 210,340 TYPE 02 ENABLE OF oDlgHist PIXEL ACTION (oDlgHist:End())

ACTIVATE MSDIALOG oDlgHist CENTER ON INIT CursorArrow()

RestArea(aArea)



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAjustaSX1 บAutor  ณEdson Maricate      บ Data ณ  06/05/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PMSR150 AP7                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AjustaSX1(cPerg)

Local aHelpPor	:= {}
Local aHelpEng	:= {}
Local aHelpSpa	:= {}
Local aHelpPor1	:= {}
Local aHelpEng1	:= {}
Local aHelpSpa1	:= {}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                      ณ
//ณ mv_par01	     	  Da Nota                             ณ
//ณ mv_par02	     	  Ate a Nota                          ณ
//ณ mv_par03	     	  Serie	                              ณ
//ณ mv_par04	     	  Mascara                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1( cPerg , "01", "Da Nota Fiscal    ?", "Da Nota Fiscal   ?","Da Nota            ?","mv_ch1","C",6,0,1,"G","","","","",;
"mv_par01","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "02", "Ate a Nota       ?", "Ate a Nota        ?","Ate a Nota         ?","mv_ch2","C",6,0,1,"G","","","","",;
"mv_par02","","","","zzzzzzzzzzzzzzz","","","","","","","","","","","","",,,)

PutSx1( cPerg , "03", "Serie            ?", "Serie             ?","Serie              ?","mv_ch3","C",3,0,1,"G","","","","",;
"mv_par03","","","","zzzzzzzzzzzzzzz","","","","","","","","","","","","",,,)

PutSx1( cPerg , "04", "Mascara          ?", "Mascara           ?","Mascara            ?","mv_ch4","C",15,0,1,"G","","","","",;
"mv_par04","","","","zzzzzzzzzzzzzzz","","","","","","","","","","","","",,,)

PutSx1( cPerg , "05", "Cliente De       ?", "Cliente           ?","Cliente            ?","mv_ch5","C",06,0,1,"G","","","","",;
"mv_par05","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "06", "Cliente Ate      ?", "Cliente           ?","Cliente            ?","mv_ch6","C",06,0,1,"G","","","","",;
"mv_par06","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "07", "Nota             ?", "Nota           ?","Nota                 ?","mv_ch7","C",50,0,1,"G","","","","",;
"mv_par07","","","","","","","","","","","","","","","","",,,)

PutSx1( cPerg , "08", "Nota             ?", "Nota           ?","Nota                 ?","mv_ch8","C",50,0,1,"G","","","","",;
"mv_par08","","","","","","","","","","","","","","","","",,,)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRetLEG   บAutor  ณ ERICH BUTTNER		 บ Data ณ  03/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao que avalia os Pedido de Venda para classi- 		  บฑฑ
ฑฑบ          ณ fica-lo corretamente na legenda.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PREPREL(CMARCA, NUM)

Local cRet
Local aArea  := GetArea()
Local cOrd2	:= cOrdem

DBSELECTAREA("SC5")
DBSETORDER(1)

TMPWM->(DBGOTOP())

WHILE TMPWM->(!EOF())
   IF EMPTY(ALLTRIM(TMPWM->OK))
		DBSEEK(XFILIAL("SC5")+TMPWM->NUMPED)
    	RECLOCK("SC5")
    	SC5->C5_MARK:= CMARCA
    	SC5->(MSUNLOCK())
 	ENDIF
 	TMPWM->(DBSKIP())   
ENDDO

IF NUM = '1'
	U_PVCLASIND(CMARCA)
ELSE
//	U_NFatSC5(CMARCA)
ENDIF	

RESTAREA(AAREA)

ChkMarca(oMark,cMarca) 

oMark:oBrowse:Refresh(.T.)
cOrdem	:= cOrd2

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRetLEG   บAutor  ณ ERICH BUTTNER		 บ Data ณ  03/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao que avalia os Pedido de Venda para classi- 		  บฑฑ
ฑฑบ          ณ fica-lo corretamente na legenda.                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PREPSAIR()

Local cRet
Local aArea  := GetArea()

DBSELECTAREA("SC5")
DBSETORDER(1)

WHILE !EMPTY(SC5->C5_MARK)
	RECLOCK("SC5")
    SC5->C5_MARK:= " "
    SC5->(MSUNLOCK())
 	SC5->(DBSKIP())   
ENDDO

Return .T.         


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PROCURA 	บAutor  ณERICH BUTTNER		 บ Data ณ  09/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Pesquisa Informa็๕es no Browse de acordo com a Ordem selecionada บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 				                                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Procura(cOrdem)

If !cOrdem $ "PEDIDO,ESTADO,MUNICIPIO,TRANSPORTADORA,TPAGEND,DTAGEND"
	ALERT("Altere a ordem do pedido")
	oMark:oBrowse:Refresh(.T.)
	Return	
endIf

DbSelectArea("TMPWM")
DbSetOrder(Ascan(aOrdem,cOrdem))
DbGoTop()
DbSeek(Alltrim(cPesquisa),.T.)
oMark:oBrowse:Refresh(.T.)
Return
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fOrdena  บAutor  ณ ERICH BUTTNER		 บ Data ณ  09/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao executada na saida do campo Ordem, para ordenar o   บฑฑ
ฑฑบ          ณ browse 								                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fOrdena(cORDEM)

_nReg:=Recno()
cPesquisa:=Space(200)
oPesquisa:Refresh()

_aMarcados:={}
DbSelectArea("TMPWM")
TMPWM->(DbGoTop())

IF CORDEM == 'PEDIDO'
	While TMPWM->(!EOF())
		AADD(_aMarcados,{TMPWM->NUMPED,TMPWM->OK})
		TMPWM->(DbSkip())
	End
ELSEIF CORDEM == 'ESTADO'
	While TMPWM->(!EOF())
		AADD(_aMarcados,{TMPWM->ESTADO,TMPWM->OK})
		TMPWM->(DbSkip())
	End
ELSEIF CORDEM == 'MUNICIPIO'
	While TMPWM->(!EOF())
		AADD(_aMarcados,{TMPWM->MUNICIPIO,TMPWM->OK})
		TMPWM->(DbSkip())
	End
ELSEIF CORDEM == 'TRANSPORTADORA'
	While TMPWM->(!EOF())
		AADD(_aMarcados,{TMPWM->TRANSP,TMPWM->OK})
		TMPWM->(DbSkip())
	End
ELSEIF CORDEM == 'TPAGEND'
	While TMPWM->(!EOF())
		AADD(_aMarcados,{TMPWM->TPAGEND,TMPWM->OK})
		TMPWM->(DbSkip())
	End
ELSEIF CORDEM == 'DTAGEND'
	While TMPWM->(!EOF())
		AADD(_aMarcados,{TMPWM->DTAGEND,TMPWM->OK})
		TMPWM->(DbSkip())
	End
ENDIF         


DbSelectArea("TMPWM")
DbSetOrder(Ascan(aOrdem,cOrdem))
DbGoTo(_nReg)     //Mantendo no mesmo registro que estava posicionado anteriormente
oMark:oBrowse:Refresh(.T.)
//oMarcados:Refresh()

Return     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณVALIDPERG ณ Autor ณ ERICH BUTTNER		    ณ Data ณ 10/09/10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ Verifica as perguntas incluกndo-as caso no existam        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especifico para Clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function ValidPerg(CPERG)
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
Return         

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณLEGENDA	ณ Autor ณ ERICH BUTTNER         ณ Data ณ 10/09/10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ LEGENDA												      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especifico para Clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

STATIC Function Legenda

Local cCadastro:=OemToAnsi("PICK LIST") 
BrwLegenda(cCadastro,"Legenda",{  {"ENABLE","LIBERADO PARA EMISSAO PICK"},;
{"BR_AMARELO","PICK LIST EMITIDO"}})  

Return(.T.) 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณLEGENDA	ณ Autor ณ ERICH BUTTNER         ณ Data ณ 10/09/10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ LEGENDA												      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especifico para Clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function ChkMarca(oMark,cMarca)

DBSELECTAREA("TMPWM")

TMPWM->(DbGoTop())

WHILE TMPWM->(!Eof())
	IF Empty(TMPWM->OK)
		IF RecLock("TMPWM",.F.)
			TMPWM->OK := CMARCA
			MsUnlock()
		ENDIF
			
    	DBSELECTAREA("SC5")
    	DBSETORDER(1)
    	DBSEEK(XFILIAL("SC5")+TMPWM->NUMPED)
    	RECLOCK("SC5",.F.)
    	SC5->C5_MARK := "  "
    	MSUNLOCK()
	
	Endif 
TMPWM->(DBSKIP())	
ENDDO


oMark:oBrowse:Refresh()

TMPWM->(DbGoTop())
	
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerWMS  บAutor  ณMicrosiga           บ Data ณ  02/17/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function VerWMS(cPed)

	_cPEDWMAS := " SELECT max(DOC.SEQUENCIAINTEGRACAO) DOCINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG "
	_cPEDWMAS += " WHERE DOC.NUMERODOCUMENTO = '"+cPed+"'"
	_cPEDWMAS += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "

	_cPEDWMAS := ChangeQuery(_cPEDWMAS)
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS New Alias "TRWM"
	
	dbSelectArea("TRWM")
	
	_cPEDWMAS1 := " SELECT INTEG.TIPOINTEGRACAO TIPINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG
	_cPEDWMAS1 += " WHERE DOC.SEQUENCIAINTEGRACAO = '"+STR(TRWM->DOCINT)+"' "
	_cPEDWMAS1 += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "
	
	_cPEDWMAS1 := ChangeQuery(_cPEDWMAS1)
	
	If Select("TRWM1") >0
		dbSelectArea("TRWM1")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS1 New Alias "TRWM1"
	
	dbSelectArea("TRWM1")

	IF TRWM1->TIPINT <> 251 .AND. TRWM1->TIPINT <> 0 // .AND. VERIF <> 0 
	  //	MSGBOX("NรO ษ PERMITIDO A ALTERAวรO DO PEDIDO POIS ESTม NO WMAS."+CHR(13)+"SOLICITE O ESTORNO AO DEPARTAMENTO DE EXPEDIวรO")
		lWMS:= .T.
	ELSE
		lWMS:= .F.	
	ENDIF				
	
	If Select("TRWM") >0
		dbSelectArea("TRWM")
		dbCloseArea()
	Endif
	If Select("TRWM1") >0
		dbSelectArea("TRWM1")
		dbCloseArea()
	Endif

	
Return(lWMS)