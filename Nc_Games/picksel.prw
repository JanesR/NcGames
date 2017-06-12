#INCLUDE "RWMAKE.CH"
#INCLUDE "TopConn.ch"
#INCLUDE "vKey.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณPICKSEL   ณ Autor ณERICH BUTTNER          ณ Data ณ 03.09.10   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ TELA DE SELEวรO DOS PEDIDOS PARA PICK LIST                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ 		                                                        ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PICKSEL()

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

/*cQuery := " SELECT C5_MARK  OK, C5_NUM PED, C5_CLIENTE CLIENTE, C5_LOJACLI LOJA, C5_NOMCLI NOME, C5_TIPAGEN TPAGEND, C5_DTAGEND DTAGEND, "
cQuery += " C5_EMISSAO EMISSAO, C5_TPFRETE TPFRETE, C5_FRETE FRETE, C5_PESOL PESOLIQ, C5_PBRUTO PESOB, "
cQuery += " C5_VOLUME1 VOLUME, C5_TRANSP TRANSPORTADORA, A4_NOME NMTRANSP, A1_EST ESTADO, A1_BAIRRO BAIRRO, "
cQuery += " A1_MUN MUNICIPIO, C5_STAPICK "
cQuery += " FROM SC5010, SA4010, SA1010 "
cQuery += " WHERE C5_CLIENTE = A1_COD AND C5_LOJACLI = A1_LOJA AND C5_TRANSP = A4_COD AND C5_NOTA = '         ' AND C5_STAPICK <> '3 ' "
cQuery += " AND C5_TIPO NOT IN ('C','I','P')
cQuery += " AND C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' AND C5_EMISSAO <='"+DTOS(MV_PAR02)+ "' AND C5_LIBEROK = 'S' "
cQuery += " AND (C5_CODBL = '  ' OR (A1_RISCO = 'A'AND (A1_VENCLC >= '"+DTOS(DDATABASE)+"'OR A1_VENCLC = ' '))) AND C5_FILIAL = '"+XFILIAL("SC5")+"' AND SC5010.D_E_L_E_T_ <> '*' "
cQuery += " AND SA4010.D_E_L_E_T_ <> '*' AND SA1010.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY PED "
 */
 cQuery := " SELECT C5_MARK OK, "
cQuery += "        C5_NUM PED, "
cQuery += "        C5_CLIENTE CLIENTE, "
cQuery += "        C5_LOJACLI LOJA, "
cQuery += "        C5_NOMCLI NOME, "
cQuery += "        C5_TIPAGEN TPAGEND, "
cQuery += "        C5_DTAGEND DTAGEND, "
cQuery += "        C5_EMISSAO EMISSAO, "
cQuery += "        C5_TPFRETE TPFRETE, "
cQuery += "        C5_FRETE FRETE, "
cQuery += "        C5_PESOL PESOLIQ, "
cQuery += "        C5_PBRUTO PESOB, "
cQuery += "        C5_VOLUME1 VOLUME, "
cQuery += "        C5_TRANSP TRANSPORTADORA, "
cQuery += "        A4_NOME NMTRANSP, "
cQuery += "        A1_EST ESTADO, "
cQuery += "        A1_BAIRRO BAIRRO, "
cQuery += "        A1_MUN MUNICIPIO, "
cQuery += "        C5_STAPICK "
cQuery += " FROM "+RetSQLName("SC5")+" SC5 INNER JOIN "+RetSQLName("SA1")+" SA1 "
cQuery += " ON(SC5.C5_CLIENTE = SA1.A1_COD AND  SC5.C5_LOJACLI = SA1.A1_LOJA) "
cQuery += " INNER JOIN "+RetSQLName("SA4")+" SA4 "
cQuery += " ON(SC5.C5_TRANSP = SA4.A4_COD) "
cQuery += " WHERE  "
cQuery += "       SC5.C5_NOTA = '         ' "
cQuery += "   AND SC5.C5_STAPICK <> '3' "
cQuery += "   AND SC5.C5_TIPO NOT IN ('C','I','P') "
cQuery += "   AND SC5.C5_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+ "'  "
cQuery += "   AND SC5.C5_LIBEROK = 'S' "
cQuery += "   AND (SC5.C5_CODBL = '  ' OR (SA1.A1_RISCO = 'A'  AND (SA1.A1_VENCLC >= '"+DTOS(DDATABASE)+"'  OR SA1.A1_VENCLC = ' ')))   "
cQuery += "   AND SC5.C5_FILIAL = '"+XFILIAL("SC5")+"'   "
cQuery += "   AND SC5.D_E_L_E_T_ = ' ' "
cQuery += "   AND SA4.D_E_L_E_T_ = ' ' "
cQuery += "   AND SA1.D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY PED "

cQuery := ChangeQuery(cQuery)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fecha Alias se estiver em Uso ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Select("TRB") >0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

If Select("TMP") >0
	dbSelectArea("TMP")
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
dbUseArea(.t.,,cArq,"TMP")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Alimenta arquivo temporario ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("TMP")

While !TRB->(EOF())
	lWMS	:= VerWMS(TRB->PED)  //verifica se existe no WMS Store
	lInWMS	:= VerINOV(TRB->PED) //Verifica se existe no WMS Inovatech
	If !lWMS .and. !lInWMS
		DbSelectArea("TMP")
		RecLock("TMP",.t.)
		TMP->OK			:= TRB->OK
		TMP->NumPed		:= TRB->PED
		TMP->Cliente	:= TRB->CLIENTE
		TMP->Loja		:= TRB->LOJA
		TMP->Nome		:= TRB->NOME
		TMP->DtEmissao	:= STOD(TRB->EMISSAO)
		TMP->TpFrete	:= TRB->TPFRETE
		TMP->Frete		:= TRB->FRETE
		TMP->PesoLiq	:= TRB->PESOLIQ
		TMP->PesoBruto	:= TRB->PESOB
		TMP->Volume		:= TRB->VOLUME
		TMP->Transp		:= TRB->TRANSPORTADORA
		TMP->NomeTransp	:= TRB->NMTRANSP
		TMP->Estado		:= TRB->ESTADO
		TMP->Bairro		:= TRB->BAIRRO
		TMP->Municipio	:= TRB->MUNICIPIO
		TMP->TPAGEND	:= TRB->TPAGEND
		TMP->DTAGEND	:= STOD(TRB->DTAGEND)
		
		TMP->(MsUnlock())
		
	EndIf
	
	DbSelectArea("TRB")
	TRB->(dbSkip())
	
End

_cArq1   := CriaTrab(NIL,.F.)
_cChave1 := "TMP->NUMPED"
IndRegua("TMP",_cArq1,_cChave1,,,"Selecionando Regs...")

_cArq2   := CriaTrab(NIL,.F.)
_cChave2 := "TMP->ESTADO"
IndRegua("TMP",_cArq2,_cChave2,,,"Selecionando Regs...")

_cArq3   := CriaTrab(NIL,.F.)
_cChave3 := "TMP->MUNICIPIO"
IndRegua("TMP",_cArq3,_cChave3,,,"Selecionando Regs...")

_cArq4   := CriaTrab(NIL,.F.)
_cChave4 := "TMP->TRANSP"
IndRegua("TMP",_cArq4,_cChave4,,,"Selecionando Regs...")

_cArq5   := CriaTrab(NIL,.F.)
_cChave5 := "TMP->TPAGEND"
IndRegua("TMP",_cArq5,_cChave5,,,"Selecionando Regs...")

_cArq6   := CriaTrab(NIL,.F.)
_cChave6 := "TMP->DTAGEND"
IndRegua("TMP",_cArq6,_cChave6,,,"Selecionando Regs...")

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

@ 000,000 TO 650,935 DIALOG oDlgLib TITLE " PICK LIST DE PEDIDOS " //850,1135

oMark:=MsSelect():New("TMP","OK","",aCpoBRW,@lInverte,@cMarca,{035,005,280,465},,,,,_aCores)//{015,005,400,630,565}
oMark:oBrowse:lHasMark := .T.
oMark:oBrowse:lCanAllMark:=.T.

@ 003,006 To 034,315 Title OemToAnsi("Pedido")
@ 016,007 Say "Ordem: "
@ 016,025 ComboBox cOrdem ITEMS aOrdem SIZE 60,50 Object oOrdem
@ 016,085 Get    cPESQUISA			   Size 200,10 Object oPesquisa
oOrdem:bChange := {|| FORDENA(CORDEM),oMark:oBrowse:Refresh(.T.)}

@ 016,350 Button "Pesquisar"       		Size 40,13 Action Procura(CORDEM)
@ 300,140 Button "Legenda"      		Size 40,13 Action LEGENDA() 				 			Object oBtnRet
@ 300,180 Button "Etiqueta"      		Size 40,13 Action U_ETI_VOL() 				 			Object oBtnRet
@ 300,220 Button "Expedi็ใo"      		Size 40,13 Action U_Fat001()	 				 		Object oBtnRet
@ 300,260 Button "Visualizar"      		Size 40,13 Action U_VERPV(TMP->NUMPED) 				 	Object oBtnRet
@ 300,300 Button "Retornar"        		Size 40,13 Action U_ESTORN_PICK()		  				Object oBtnRet
@ 300,340 Button "Pick List"       		Size 40,13 Action PREPREL(CMARCA,'1') 					Object oBtnREL
@ 300,380 Button "PickList Aglut." 		Size 40,13 Action PREPREL(CMARCA,'2') 					Object oBtnTodos
@ 300,420 Button "Sair"            		Size 40,13 Action IIF(PREPSAIR(),Close(oDlgLIb),"")	Object oBtnInv

dbSelectArea("TMP")
dbGoTop()
While !TMP->(EOF())
	RecLock("TMP",.f.)
	TMP->OK    := ThisMark()
	TMP->(MsUnlock())
	TMP->(dbSkip())
End
dbGoTop()

oMark:oBrowse:Refresh()

ACTIVATE DIALOG oDlgLib CENTERED

TMP->(dbCloseArea())

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
dbSelectArea("TMP")
dbGoTop()
While !EOF()
	RecLock("TMP",.f.)
	TMP->OK := If(Marked("OK"),ThisMark(),GetMark())
	TMP->(MsUnlock())
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
dbSeek(xFilial("SC5")+TMP->NumPed)

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

Function U_VERPV(CPED)
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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑณFun…o    ณ NFatSC5  ณ Autor ณErich Buttner    		ณ Data ณ 03.09.10  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑณDescri…o ณ Pick-List aglutinado (Expedicao) NC Games (Por pedido)  	   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑณ Uso      ณ NC Games                                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NFatSC5(cMarca)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
LOCAL wnrel     := "NFatSC5"
LOCAL tamanho	:= "G"
LOCAL titulo    := OemToAnsi("Pick-List Aglutinado (Expedicao)")
LOCAL cDesc1    := OemToAnsi("Emisso de produtos a serem separados pela expedicao, para")
LOCAL cDesc2    := OemToAnsi("notas fiscais selecionadas.")
LOCAL cDesc3	:= ""
LOCAL cString	:= "SC6"
LOCAL cPerg  	:= ""

PRIVATE aReturn         := {"Zebrado", 1,"Administracao", 2, 2, 1, "",0 }
PRIVATE nomeprog	:= "NFatSC5"
PRIVATE nLastKey 	:= 0
PRIVATE nBegin		:= 0
PRIVATE aLinha		:= {}
PRIVATE li			:= 80
PRIVATE limite		:= 132
PRIVATE lRodape		:= .F.
PRIVATE m_pag       :=1
PRIVATE cMark		:= ALLTRIM(cMarca)

wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho,,.T.)

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| C775Imp(@lEnd,wnRel,cString,cPerg,tamanho,@titulo,@cDesc1,;
@cDesc2,@cDesc3)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑณFun…o    ณ C775IMP	ณ Autor ณ Rosane Luciane Chene 	ณ Data ณ 09.11.95  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑณDescri…o ณ Chamada do Relatorio                                        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑณ Uso      ณ NFATSC5			 										   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function C775Imp(lEnd,WnRel,cString,cPerg,tamanho,titulo,cDesc1,cDesc2,cDesc3)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

LOCAL cabec1     := OemToAnsi("         Codigo           Desc. do Material                                                        Cod. Barra      UM   Quantidade       Endre็o 1       Endere็o 2   Armz.")
LOCAL cabec2	 := ""
LOCAL lContinua  := .T.
LOCAL lFirst 	 := .T.
LOCAL cPedAnt	 := ""
LOCAL nI		 := 0
LOCAL aTam    	 := {}
LOCAL cMascara 	 := GetMv("MV_MASCGRD")
LOCAL nTamRef  	 := Val(Substr(cMascara,1,2))
LOCAL cbtxt      := SPACE(10)
LOCAL cbcont	 := 0
LOCAL nTotQuant	 := 0
LOCAL aStruSC6   := {}
LOCAL nSC6       := 0
LOCAL cFilter    := ""
LOCAL cAliasSC6  := "SC6"
LOCAL cIndexSC6  := ""
LOCAL cKey 	     := ""
Local _cDoc      := ""
LOCAL lQuery     := .F.
LOCAL lRet       := .T.
LOCAL cProdRef	 := ""
LOCAL lSkip		 := .F.
LOCAL cCodProd 	 := ""
LOCAL nQtdIt   	 := 0
LOCAL cDescProd	 := ""
LOCAL cGrade   	 := ""
LOCAL cUnidade 	 := ""
LOCAL cLocaliza	 := ""
LOCAL cLote	 	 := ""
LOCAL cLocal 	 := ""
LOCAL cSubLote   := ""
LOCAL dDtValid   := dDatabase
Local nPos       := 0
Local aLista     := {}
Local aLista2    := {}
Local nX         := 0
Local _cGrupo    := ""
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
li := 80
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Definicao dos cabecalhos                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
titulo := OemToAnsi("PICK-LIST AGLUTINADO")
//XXXXXXXXXXXXXXX X----------------------------X XX 999,999.99  99  XXXXXXXXXXXXXXX
//0        1         2         3         4         5         6         7         8
//012345678901234567890123456789012345678901234567890123456789012345678901234567890
#IFDEF TOP
	If TcSrvType() <> "AS/400"
		cAliasSC6:= "C775Imp"
		aStruSC6  := SC6->(dbStruct())
		lQuery    := .T.
		
		//cQuery := "SELECT SC6.R_E_C_N_O_ SC6REC,"
//		cQuery += "SC6.C6_NUM ,SC6.C6_FILIAL,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_SERIE,SC6.C6_QTDVEN,SC6.C6_PRODUTO, "
//		cQuery += "SC6.C6_LOCAL,SC6.C6_GRADE,SC6.C6_LOTECTL, SC6.C6_NUMLOTE,SC6.C6_DTVALID,SC5.C5_NUM, SC5.C5_MARK, SC6.C6_ITEM "
//		cQuery += "FROM SC6010 SC6, SC5010 SC5 "
//		cQuery += "WHERE SC6.C6_QTDVEN > 0 AND SC6.C6_NUM = SC5.C5_NUM AND  "
//		cQuery += "SC6.C6_FILIAL = SC5.C5_FILIAL AND "
//		cQuery += "SC5.C5_MARK = '"+cMark+"' AND SC6.D_E_L_E_T_ = ' '  AND SC5.D_E_L_E_T_ = ' ' "
//		cQuery += "ORDER BY SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_SERIE,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_PRODUTO,SC6.C6_LOTECTL, "
//		cQuery += "SC6.C6_NUMLOTE,SC6.C6_DTVALID"
		
		cQuery := "SELECT SC6.R_E_C_N_O_ SC6REC, "
		cQuery += "		SC6.C6_NUM ,SC6.C6_FILIAL,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_SERIE,SC6.C6_QTDVEN,SC6.C6_PRODUTO,  "
		cQuery += "		SC6.C6_LOCAL,SC6.C6_GRADE,SC6.C6_LOTECTL, SC6.C6_NUMLOTE,SC6.C6_DTVALID,SC5.C5_NUM, SC5.C5_MARK, SC6.C6_ITEM  "
		cQuery += "		FROM "+RetSQLNames("SC6")+" SC6 inner join "+RetSqlName("SC5")+" SC5  "
		cQuery += "    on(SC6.C6_FILIAL = SC5.C5_FILIAL and SC6.C6_NUM = SC5.C5_NUM) "
		cQuery += "		WHERE SC6.C6_QTDVEN > 0   "
		cQuery += "    and SC5.C5_MARK = '"+cMark+"' AND SC6.D_E_L_E_T_ = ' '  AND SC5.D_E_L_E_T_ = ' '  "
		cQuery += "		ORDER BY SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_SERIE,SC6.C6_CLI,SC6.C6_LOJA,SC6.C6_PRODUTO,SC6.C6_LOTECTL,  "
		cQuery += "		SC6.C6_NUMLOTE,SC6.C6_DTVALID "
		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)
		
		For nSC6 := 1 To Len(aStruSC6)
			If aStruSC6[nSC6][2] <> "C" .and.  FieldPos(aStruSC6[nSC6][1]) > 0
				TcSetField(cAliasSC6,aStruSC6[nSC6][1],aStruSC6[nSC6][2],aStruSC6[nSC6][3],aStruSC6[nSC6][4])
			EndIf
		Next nSC6
	Endif
#ELSE
	dbSelectArea(cString)
	cIndexSC6  := CriaTrab(nil,.f.)
	cKey :="C6_FILIAL+C6_NUM+C6_CLI+C6_LOJA+C6_PRODUTO+C6_LOTECTL+C6_NUMLOTE+DTOS(C6_DTVALID)"
	cFilter := "C6_FILIAL = '" + xFilial("SC6") + "' .And. "
	cFilter += "C6_QTDVEN > 0 .And. "
	cFilter += "C6_CLI >= '"      "' .And. "
	cFilter += "C6_CLI <= '"ZZZ"' "
	
	IndRegua(cAliasSC6,cIndexSC6,cKey,,cFilter,"Selecionando Registros...")
	#IFNDEF TOP
		DbSetIndex(cIndexSC6+OrdBagExt())
	#ENDIF
	SetRegua(RecCount())		// Total de Elementos da regua
	DbGoTop()
#ENDIF

DbGoTop()
SetRegua(RecCount())		// Total de Elementos da regua

While (cAliasSC6)->(!Eof())
	
	IncRegua()
	
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	
	IF DBSEEK(XFILIAL("SC5")+(cAliasSC6)->C5_NUM)
		SC5->(RECLOCK("SC5", .F.))
		SC5->C5_STAPICK := "1"
		SC5->C5_MARK	:= "  "
		SC5->(MSUNLOCK())
		SC5->(DBCLOSEAREA())
	ENDIF
	
	DBSELECTAREA("SC9")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC9")+(cAliasSC6)->C5_NUM)
	
	IF !EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+(cAliasSC6)->C5_NUM+(cAliasSC6)->C6_ITEM,"C9_BLEST"))
		(cAliasSC6)->(DBSKIP())
		LOOP
	ENDIF
	
	IF DBSEEK(XFILIAL("SC9")+(cAliasSC6)->C5_NUM)
		WHILE SC9->C9_PEDIDO == (cAliasSC6)->C5_NUM
			SC9->(RECLOCK("SC9", .F.))
			SC9->C9_STAPICK := "1"
			SC9->(MSUNLOCK())
			SC9->(DBCLOSEAREA())
		ENDDO
	ENDIF
	
	If lRet
		
		dbSelectArea("SB1")
		dbSeek(xFilial("SB1") + (cAliasSC6)->C6_PRODUTO)
		dbSelectArea("SBM")
		dbSetOrder(1)
		dbSeek(xFilial("SBM") + SB1->B1_GRUPO)
		dbSelectArea("SB2")
		dbSeek(xFilial("SB2") + (cAliasSC6)->C6_PRODUTO + (cAliasSC6)->C6_LOCAL )
		dbSelectArea("SA1")
		dbSeek(xFilial("SA1") + (cAliasSC6)->C6_CLI+ (cAliasSC6)->C6_LOJA)
		dbSelectArea("SC5")
		dbSetOrder(1)
		dbSeek(xFilial("SC5") +(cAliasSC6)->C6_NUM+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA)
		dbSelectArea("SA4")
		dbSetOrder(1)
		dbSeek(xFilial("SA4") + SC5->C5_TRANSP)
		
		cCodProd := (cAliasSC6)->C6_PRODUTO
		cCodBAR  := SB1->B1_CODBAR
		nQtdIt   := (cAliasSC6)->C6_QTDVEN
		cDescProd:= Subs(SB1->B1_XDESC,1,70)
		cGrade   := (cAliasSC6)->C6_GRADE
		cUnidade := SB1->B1_UM
		cLocaliza:= SB2->B2_LOCALIZ
		_cLocEnd2:= SB2->B2_LOCALI2
		cLote	 := (cAliasSC6)->C6_LOTECTL
		cLocal 	 := (cAliasSC6)->C6_LOCAL
		cSubLote := (cAliasSC6)->C6_NUMLOTE
		dDtValid := (cAliasSC6)->C6_DTVALID
		cGrupo   :=  SB1->B1_GRUPO
		cDescGrup:=  SBM->BM_DESC
		cVendedor:= GETADVFVAL("SA3","A3_NOME",xFilial("SA3")+GETADVFVAL("SC5","C5_VEND1",xFilial("SC5")+(cAliasSC6)->C6_NUM,1,""),1,"")
		
		//
		// Agrupando pelo Codigo do produto
		//
		nPos := aScan(aLista,{|x| AllTrim(x[1])==Alltrim(cCodProd)})
		
		If nPos = 0
			aadd(aLista,{cCodProd,;
			cCodBAR,;
			nQtdIt,;
			cDescProd,;
			cGrade,;
			cUnidade,;
			cLocaliza,;
			_cLocEnd2,;
			cLote,;
			cLocal,;
			cSubLote,;
			dDtValid,;
			cGrupo,;
			cDescGrup})
		Else
			aLista[nPos][3] += nQtdIt
		Endif
		
		nPos2 := aScan(aLista2,{|x| AllTrim(x[1])==(cAliasSC6)->C6_NUM})
		
		If nPos2 = 0
			aadd(aLista2,{(cAliasSC6)->C6_NUM,;
			(cAliasSC6)->C6_CLI,;
			SA1->A1_NOME,;
			SA1->A1_EST,;
			SA4->A4_NOME,;
			cVendedor})
		Endif
		
		
	EndIf
	
	dbSelectArea(cAliasSC6)
	dbSkip()
End

//
// Ordenando pelo Grupo e Descricao do Produto
//
aSort(aLista, , , {|x,y| x[13]+x[1] < y[13]+y[1]})

aSort(aLista2, , , {|x,y| x[1] < y[1]})

//
// Impressao do Documento
//
lFirst := .T.

SetRegua(len(aLista))		// Total de Elementos da regua

For nX := 1 to Len(aLista)
	
	
	cCodProd  := aLista[nX][01]
	cCodBAR   := aLista[nX][02]
	nQtdIt    := aLista[nX][03]
	cDescProd := aLista[nX][04]
	cGrade    := aLista[nX][05]
	cUnidade  := aLista[nX][06]
	cLocaliza := aLista[nX][07]
	_cLocEnd2 := aLista[nX][08]
	cLote     := aLista[nX][09]
	cLocal    := aLista[nX][10]
	cSubLote  := aLista[nX][11]
	dDtValid  := aLista[nX][12]
	cGrupo    := aLista[nX][13]
	cDescGrup := aLista[nX][14]
	
	
	IF lEnd
		@PROW()+1,001 Psay "CANCELADO PELO OPERADOR"
		lContinua := .F.
		Exit
	Endif
	
	IF li > 55 .or. lFirst
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	Endif
	
	
	If  _cGrupo <> cGrupo .or. lFirst
		lFirst  := .f.
		_cGrupo := cGrupo
		li++
		@ li, 00  Psay alltrim(cGrupo) + "  -  "+ cDescGrup Picture "@!"
		li++
		li++
	Endif
	
	//2         3         4         5         6         7         8         9        10        11        12        13         14       15
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX 999,999,999.99 XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX  XX
	@ li, 02  Psay "(   )  " + cCodProd Picture "@!"
	@ li, 26  Psay cDescProd	Picture "@!"
	@ li, 100  Psay cCodBAR
	@ li, 116  Psay cUnidade Picture "@!"
	@ li, 120 Psay IIF(cGrade=="S" .And. MV_PAR05 == 1,nTotQuant,nQtdIt) Picture "@E 999,999,999.99"
	@ li, 135 Psay cLocaliza
	@ li, 153 Psay _cLocEnd2
	@ li, 169 Psay cLocal
	li++
	
Next nX

li := 	li + 5

IF li > 55 .or. lFirst
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,50)
Endif

@ li, 02  Psay "  Lista dos Pedidos "
li++
@ li, 02  Psay "Pedido       Cliente          Nome                                            UF    Transportadora                              Vendedor"
li := li+2

For x:=1 to Len(aLista2)
	
	IF li > 55 .or. lFirst
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,50)
		@ li, 02  Psay "Pedido       Cliente          Nome                                            UF    Transportadora                              Vendedor"
		li := li+2
	Endif
	
	@ li, 02  Psay aLista2[x,1]
	@ li, 15  Psay aLista2[x,2]
	@ li, 32  Psay aLista2[x,3]
	@ li, 80  Psay aLista2[x,4]
	@ li, 85  Psay aLista2[x,5]
	@ li,130  Psay aLista2[x,6]
	li++
	
Next

IF lRodape
	roda(cbcont,cbtxt,"M")
Endif

If lQuery
	dbSelectArea(cAliasSC6)
	dbCloseArea()
	dbSelectArea("SC6")
Else
	RetIndex("SC6")
	Ferase(cIndexSC6+OrdBagExt())
	dbSelectArea("SC6")
	Set Filter to
	dbSetOrder(1)
	dbGotop()
Endif

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

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

TMP->(DBGOTOP())

WHILE TMP->(!EOF())
	IF EMPTY(ALLTRIM(TMP->OK))
		DBSEEK(XFILIAL("SC5")+TMP->NUMPED)
		RECLOCK("SC5")
		SC5->C5_MARK:= CMARCA
		SC5->(MSUNLOCK())
	ENDIF
	TMP->(DBSKIP())
ENDDO

IF NUM = '1'
	U_NFatSC5A(CMARCA)
ELSE
	U_NFatSC5(CMARCA)
ENDIF

RESTAREA(AAREA)

ChkMarca(oMark,cMarca)
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

DbSelectArea("TMP")
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
DbSelectArea("TMP")
TMP->(DbGoTop())

IF CORDEM == 'PEDIDO'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->NUMPED,TMP->OK})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'ESTADO'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->ESTADO,TMP->OK})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'MUNICIPIO'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->MUNICIPIO,TMP->OK})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'TRANSPORTADORA'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->TRANSP,TMP->OK})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'TPAGEND'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->TPAGEND,TMP->OK})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'DTAGEND'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->DTAGEND,TMP->OK})
		TMP->(DbSkip())
	End
ENDIF


DbSelectArea("TMP")
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

DBSELECTAREA("TMP")

TMP->(DbGoTop())

WHILE TMP->(!Eof())
	IF Empty(TMP->OK)
		IF RecLock("TMP",.F.)
			TMP->OK := CMARCA
			MsUnlock()
		ENDIF
		
		DBSELECTAREA("SC5")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SC5")+TMP->NUMPED)
		RECLOCK("SC5",.F.)
		SC5->C5_MARK := "  "
		MSUNLOCK()
		
	Endif
	TMP->(DBSKIP())
ENDDO


oMark:oBrowse:Refresh()

TMP->(DbGoTop())

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

IF TRWM1->TIPINT <> 0 // .AND. VERIF <> 0
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


//Verifica se hแ pedido no WMS
Static Function VerINOV(cPed)

Local lWMS	:= .F.
Local cQry	:= ""
Local cAliasWMS	:= GetNextAlias()
Local clArmz	:= SuperGetMV("MV_ARMWMAS",.F.,'01')

cQry	:= "SELECT *  FROM WMS.TB_WMSINTERF_DOC_SAIDA WHERE DPCS_COD_CHAVE = '"+xFilial("SC5")+cPed+"'
Iif(Select(cAliasWMS) > 0,(cAliasWMS)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasWMS,.F.,.T.)
While (cAliasWMS)->(!eof())
	lWMS	:= .T.
	(cAliasWMS)->(dbskip())
End
(cAliasWMS)->(dbclosearea())

//Verifica se o armaz้m ้ controlado pelo WMS - 19/08/2013
If !lWMS
	cQry	:= "SELECT DISTINCT(C9_PEDIDO) FROM "+RetSqlName("SC9")+" WHERE D_E_L_E_T_ = ' ' AND C9_FILIAL = '"+xFilial("SC9")+"' AND C9_LOCAL IN"+FORMATIN(clArmz,"/")+" AND C9_PEDIDO = '"+cPed+"'
	Iif(Select(cAliasWMS) > 0,(cAliasWMS)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasWMS,.F.,.T.)
	While (cAliasWMS)->(!eof())
		lWMS	:= .T.
		(cAliasWMS)->(dbskip())
	End
	(cAliasWMS)->(dbclosearea())
EndIf

Return(lWMS)
