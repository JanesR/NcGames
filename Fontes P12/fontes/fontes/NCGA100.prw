#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"

#Define	BMPSAIR	"FINAL.PNG"
#Define BMPRFSH "PMSRRFSH.PNG"
#DEFINE CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGA100  ºAutor  ³                     º Data ³  11/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monitor de Cancelamento de Faturas e Conhecimentos         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGA100()

Local aArea := GetArea()

Private aCores    := {;
{"ZZQ_SITUAC=='1'"	, "BR_VERDE", "Cancelamento Pendente"  },;
{"ZZQ_SITUAC=='2'"	, "BR_AMARELO", "Cancelamento Autorizado"  },;
{"ZZQ_SITUAC=='3'"	, "BR_AZUL", "Cancelamento Negado"  },;
{"ZZQ_SITUAC=='4'"	, "BR_VERMELHO", "Cancelamento Efetuado no Fretes"  };
}


Private aRotina := {;
{"Pesquisar","AxPesqui",0,1} ,;
{"Autorizar Cancelamento","u_NCGA100B",0,2},;
{"Legenda","u_NCGA100Leg",0,3};
}

Private cCadastro := "Monitor de cancelamento de Faturas"

Processa({|| NCGA100A() },"Atualizando monitor...")

dbSelectArea("ZZQ")
dbSetOrder(1)
mBrowse( 6,1,22,75,"ZZQ",,,,,,aCores)

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGA100A  ºAutor  ³Microsiga           º Data ³  11/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCGA100A

Local aArea		:= GetArea()
Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local lErro		:= .F.
Local cTransp 	:= ""
Local cFornec	:= ""
Local cLoja		:= ""
Local cMenserro	:= ""

DBSelectArea("SA4")
SA4->(DbOrderNickName("CODWMS"))

DbSelectArea("ZZQ")
ZZQ->(DbSetOrder(1))

ProcRegua(0)

cQry	:= " SELECT CODIGO_TRANSPORTADOR CODTRANSP, NUM_FATURAS, SERIE, SITUACAO, STATUS STATUSC, DATA DT_SOLICIT, HORA HR_SOLICIT, ID_ENVIO "
cQry	+= " FROM FRETES.TB_FRTFATURAS_CANCELAMENTO WHERE STATUS IN ('NP','PF') AND SITUACAO IN('1','4')" //1 e 4 são situações que o FRETES envia para o Protheus
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias  ,.F.,.T.)
While (cAlias)->(!eof())
	lErro		:= .F.
	incproc()
	
	SA4->(DBGoTop())
	SA4->(DBSeek(xFilial("SA4")+Str(val((cAlias)->CODTRANSP),TAMSX3("A4_YCODWMS")[1],0)))
	cTransp := SA4->A4_COD
	cFornec	:= SA4->A4_YFORNEC
	cLoja	:= SA4->A4_YLOJA
	
	If !ZZQ->( DbSeek(xFilial("ZZQ")+"FRE"+padr((cAlias)->NUM_FATURAS,10)+"BOL"+cFornec+cLoja) )
		reclock("ZZQ",.T.)
		ZZQ->ZZQ_FILIAL := xFilial("ZZQ")
		ZZQ->ZZQ_TRANSP := cTransp
		ZZQ->ZZQ_NOMSA4 := SA4->A4_NOME
		ZZQ->ZZQ_DTSOLI := STOD((cAlias)->DT_SOLICIT)
		ZZQ->ZZQ_HRSOLI := (cAlias)->HR_SOLICIT
		ZZQ->ZZQ_PREFIX := "FRE"
		ZZQ->ZZQ_NUM	:= SUBSTR((cAlias)->NUM_FATURAS,1,9)
		ZZQ->ZZQ_PARCEL := SUBSTR((cAlias)->NUM_FATURAS,10,1)
		ZZQ->ZZQ_TIPO	:= "BOL"
		ZZQ->ZZQ_SITUAC	:= (cAlias)->SITUACAO //(1) Solicitado / (2) Autorizado / (3) Negado / (4) Cancelamento efetuado
		ZZQ->ZZQ_FORNEC	:= cFornec
		ZZQ->ZZQ_LOJA	:= cLoja
		ZZQ->ZZQ_IDENVI	:= (cAlias)->ID_ENVIO
		ZZQ->(msunlock())
	Else
		lAchou	:= .F.
		While ZZQ->(!eof()) .and. ZZQ->ZZQ_IDENVI == (cAlias)->ID_ENVIO
			lAchou	:= .T.
			reclock("ZZQ",.F.)
			ZZQ->ZZQ_SITUAC	:= (cAlias)->SITUACAO //1) Solicitado / (2) Autorizado / (3) Negado / (4) Cancelamento efetuado
			ZZQ->(msunlock())
			
			ZZQ->(dbskip())
		End
		If !lAchou
			reclock("ZZQ",.T.)
			ZZQ->ZZQ_FILIAL := xFilial("ZZQ")
			ZZQ->ZZQ_TRANSP := cTransp
			ZZQ->ZZQ_NOMSA4 := SA4->A4_NOME
			ZZQ->ZZQ_DTSOLI := STOD((cAlias)->DT_SOLICIT)
			ZZQ->ZZQ_HRSOLI := (cAlias)->HR_SOLICIT
			ZZQ->ZZQ_PREFIX := "FRE"
			ZZQ->ZZQ_NUM	:= SUBSTR((cAlias)->NUM_FATURAS,1,9)
			ZZQ->ZZQ_PARCEL := SUBSTR((cAlias)->NUM_FATURAS,10,1)
			ZZQ->ZZQ_TIPO	:= "BOL"
			ZZQ->ZZQ_SITUAC	:= (cAlias)->SITUACAO //(1) Solicitado / (2) Autorizado / (3) Negado / (4) Cancelamento efetuado
			ZZQ->ZZQ_FORNEC	:= cFornec
			ZZQ->ZZQ_LOJA	:= cLoja
			ZZQ->ZZQ_IDENVI	:= (cAlias)->ID_ENVIO
			ZZQ->(msunlock())
		EndIf
	EndIf
	
	If lErro
		cQry := " UPDATE FRETES.TB_FRTFATURAS_CANCELAMENTO SET STATUS = 'ER', DESC_ERRO = '"+cMenserro+"' "
		cQry += " WHERE STATUS = 'NP' "
		cQry += " AND CODIGO_TRANSPORTADOR = '"+alltrim((cAlias)->CODTRANSP)+"' "
		cQry += " AND NUM_FATURAS = '"+alltrim((cAlias)->NUM_FATURAS)+"' "
		cQry += " AND SERIE = '"+alltrim((cAlias)->SERIE)+"'"
		cQry += " AND ID_ENVIO = "+alltrim(str((cAlias)->ID_ENVIO))+" "
		cQry += " AND SITUACAO = '"+alltrim((cAlias)->SITUACAO)+"' "
		cQry += " AND DATA = '"+alltrim((cAlias)->DT_SOLICIT)+"' "
		cQry += " AND HORA = '"+alltrim((cAlias)->HR_SOLICIT)+"' "
		If TcSqlExec(cQry) >= 0
			TcSqlExec("COMMIT")
		Else
			Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
		EndIf
	Else
		
		cQry := " UPDATE FRETES.TB_FRTFATURAS_CANCELAMENTO SET STATUS = 'P', DESC_ERRO = '"+cMenserro+"' "
		cQry += " WHERE STATUS = 'NP' "
		cQry += " AND CODIGO_TRANSPORTADOR = '"+alltrim((cAlias)->CODTRANSP)+"' "
		cQry += " AND NUM_FATURAS = '"+alltrim((cAlias)->NUM_FATURAS)+"' "
		cQry += " AND SERIE = '"+alltrim((cAlias)->SERIE)+"'"
		cQry += " AND ID_ENVIO = "+alltrim(str((cAlias)->ID_ENVIO))+" "
		cQry += " AND SITUACAO = '"+alltrim((cAlias)->SITUACAO)+"' "
		cQry += " AND DATA = '"+alltrim((cAlias)->DT_SOLICIT)+"' "
		cQry += " AND HORA = '"+alltrim((cAlias)->HR_SOLICIT)+"' "
		If TcSqlExec(cQry) >= 0
			TcSqlExec("COMMIT")
		Else
			Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
		EndIf
	EndIf
	
	//Marca o status das interfaces TB_FRTINTERFFATURAS_ITENS e TB_FRTINTERFFATURAS como STATUS = 'CF' para que
	//caso o registro ainda não estiver sido processado pela integração NCGPR106, desconsidere a integração aqui.
	NCGAAtuINT((cAlias)->CODTRANSP,(cAlias)->NUM_FATURAS,(cAlias)->SERIE)
	
	(cAlias)->(DbSkip())
End

RestArea(aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NCGA100Leg ºAutor  ³       	         º Data ³  01/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Legenda do browse                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGA100Leg()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  ºAutor  ³         	                 º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela utilizada para mostrar o detalhe do processo           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGA100B(cAlias, nRecno, nOpc)

Local apItens	:= {"Nota Fiscal"}
Local cpEdit1	:= space(9)
Local cpCombo	:= ""
Local aHeader	:= {}
Local aCols	:= {}

Local bFDelCTE	:= {|| IIF(msgyesno("Exclui Conhecimentos de FRETES dos registros marcados?"),FDelCTE(),Nil) }
Local bFAtuMonit	:= {|| NCGA100Col() }

Private opEdit1 := Nil
Private olMsNewGet
Private aCampos	:= {"F1_DOC","F1_SERIE","F1_ESPECIE","F1_STATUS","F1_FORNECE","F1_LOJA","F1_EMISSAO","F1_DTDIGIT"}

If !(alltrim(ZZQ->ZZQ_SITUAC)$'1/3')
	Return
EndIf

aHeader	:= criaheader(aCampos)

//Chama a rotina NCGA100Col para atualizar o aCols com os dados a serem visualizados
NCGA100Col(@aCols,.F.)

If len(aCols) = 0
	
	//alert("Não há conhecimentos de transportes pendentes de cancelamento para a fatura selecionada")
	If MsgYesNo("Não há conhecimentos de transportes pendentes de cancelamento para a fatura selecionada"+CRLF;
		+"Deseja Realizar o cancelamento do boleto a pagar do financeiro?")
		lContinua:= NCGADelSE2()
		If lContinua
			lAtualizado	:= NCGAAtuFRE()
			If lAtualizado
				reclock("ZZQ",.F.)
				ZZQ->ZZQ_SITUAC	:= "2"
				msunlock()
			EndIf
		EndIf
	EndIf
	
	Return
EndIf

oDlg := MSDialog():New(000,000,550,1150,"Cancelamento de Faturas de Transporte",,,,,CLR_BLACK,CLR_WHITE,,,.T.)

oFWLayer	:= FWLayer():New()

oFWLayer:Init(oDlg,.F.)

oFWLayer:AddCollumn("ALL"	,0100,.F.)

oFWLayer:AddWindow("ALL"	,"ACAO"	,"Fatura"				,020,.F.,.F.,,,{ || })
oFWLayer:AddWindow("ALL"	,"PED"	,"Conhecimentos de Transporte"			,080,.F.,.F.,,,{ || })

oPanelESQ3	:= oFWLayer:GetWinPanel("ALL"	,"ACAO")
oPanelESQ2	:= oFWLayer:GetWinPanel("ALL"	,"PED")

@ 05,08  SAY OemToAnsi("Número da Fatura") SIZE 50, 07 OF oPanelESQ3 PIXEL
@ 03,70  Get ZZQ->(ZZQ_PREFIXO+" - "+ZZQ_NUM+" - "+ZZQ_PARCELA)   Picture "@!"  SIZE 70,10 WHEN .F. PIXEL OF oPanelESQ3
@ 18,08  SAY OemToAnsi("Transportadora") SIZE 50, 07 OF oPanelESQ3 PIXEL
@ 16,70  Get ZZQ->(ZZQ_TRANSP+" - "+ZZQ_NOMSA4)   Picture "@!"  SIZE 150,10 WHEN .F. PIXEL OF oPanelESQ3

olCheck := TCheckBox():New(010,350,"Inverte Seleção",,oPanelESQ3,050,050,,,,,,,,.T.,,,)
olCheck:BLCLICKED	:= {|| INVERTSELL() }


TBtnBmp2():New(5,1100,30,45,"FINAL",,,,{|| oDlg:End() },oPanelESQ3,"Sair",,.T. )
TBtnBmp2():New(5,1000,30,45,"CANCEL",,,,bFDelCTE,oPanelESQ3,"Realiza Exclusão",,.T. )


//TBtnBmp2():New(5,400,30,45,"PESQUISA",,,,{|| PESQUISA(cpCombo,cpEdit1)},oPanelESQ3,"Pesquisa",,.T. )
//opCombo		:= TComboBox():New(007,001,{|u| If(PCount()>0,cpCombo:=u,cpCombo)},apItens,070,020,oPanelESQ3,,{|| Ordena(cpCombo,cpEdit1) },,,,.T.,,,,,,,,,"cpCombo")
//opEdit1		:= TGet():New(007,085,{|u| if(PCount()>0,cpEdit1:=u,cpEdit1)},oPanelESQ3,100,009,"",{||  },,,,,,.T.,,,,,,,,,,"cpEdit1")

Set Key VK_F5 to NCGA100Col()
olMsNewGet 						:= MsNewGetDados():New(000,000,000,000,001,,"AllWaysTrue()","",,,9999,"AllwaysTrue()",,,oPanelESQ2,aHeader,aCols)
olMsNewGet:oBrowse:Align 		:= CONTROL_ALIGN_ALLCLIENT
olMsNewGet:lInsert 				:= .F.
olMsNewGet:OBROWSE:BLDBLCLICK	:= {|x| SELREG()}

oDlg:Activate(,,,.T.,{|| },,{|| } )

SetKey(VK_F5,)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGA100ColºAutor  ³Microsiga           º Data ³  11/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza o aCols                                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCGA100Col(aCols,lRefresh)

Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local aItem		:= {}


Default lRefresh	:= .T.

aCols	:= {}

//{"F1_DOC","F1_SERIE","F1_ESPECIE","F1_STATUS","F1_FORNECE","F1_LOJA"}
cQry := " SELECT "
For ny:=1 to len(aCampos)
	cQry += iif(nY==1,aCampos[nY],", "+aCampos[nY])
Next
cQry += " FROM "+RetSqlName('SF1')+" WHERE D_E_L_E_T_ = ' '
cQry += " AND F1_FILIAL = '"+xFilial("SF1")+"'
cQry += " AND F1_XFATFRE = '"+xFilial("SE2")+ZZQ->(ZZQ_PREFIX+ZZQ_NUM+ZZQ_PARCEL+ZZQ_TIPO)+"'
cQry += " AND F1_XFORFRE = '"+ZZQ->(ZZQ_FORNEC+ZZQ_LOJA)+"'
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias  ,.F.,.T.)

While (cAlias)->(!EOF())
	
	aItem	:= {}
	If Empty((cAlias)->F1_STATUS)
		aadd(aItem,"LBTIK")
	Else
		aadd(aItem,"LBNO")
	EndIf
	For ny:=1 to len(aCampos)
		cCampo	:= cAlias+"->"+aCampos[nY]
		If AVSX3(aCampos[nY])[2] == "D"
			aadd(aItem,stod(&cCampo))
		Else
			aadd(aItem,&cCampo)
		EndIf
	Next
	aadd(aItem,.F.)
	
	AADD(aCols,aClone(aItem))
	
	(cAlias)->(DBSkip())
EndDO
(cAlias)->(dbCloseArea())

If lRefresh
	olMsNewGet:aCols := aCols
	olMsNewGet:ForceRefresh()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaHeaderºAutor  ³Microsiga           º Data ³  11/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaHeader(aCampos)

Local aArea		:= GetArea()
Local aRet	 	:= {}
Local nIx		:= 0

DbSelectArea( "SX3" )
DbSetOrder(2)

aAdd(aRet,{""		  		,"XLEGENDA"		,"@BMP"		,010						,0,"","","C","","" ,"",""})

For nIx := 1 To Len( aCampos )
	If SX3->( MsSeek( aCampos[ nIx ] ) )
		aAdd( aRet, {AlLTrim( X3Titulo() )	, ;	// 01 - Titulo
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

Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ INVERTSELL  ºAutor  ³ Tiago Bizan      º Data ³  16/04/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função para inverter a seleção dos registros na Getdados   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 												      		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function INVERTSELL()
For nI := 1 to len(olMsNewGet:aCols)
	If Alltrim(olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]) == "LBNO"
		olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBTIK"
	Else
		olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBNO"
	EndIF
Next nI
olMsNewGet:Refresh()
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ SELREG  ºAutor  ³ Tiago Bizan    	  º Data ³  16/04/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função para marcação dos registros na Getdados   		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 												      		  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SELREG()

If Alltrim(olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]) == "LBNO"
	olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBTIK"
Else
	olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBNO"
EndIf

olMsNewGet:Refresh()

Return(.T.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FDelCTE   ºAutor  ³Microsiga           º Data ³  01/22/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FDelCTE

Local aArea	:= GetArea()
Local nI	:= 0
Local nPFornece	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == "F1_FORNECE" })
Local nPLoja	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == "F1_LOJA" })
Local nPNumero	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == "F1_DOC" })
Local nPSerie	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == "F1_SERIE" })
Local nPLeg		:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'XLEGENDA' })
Local cNumero	:= ""
Local cSerie	:= ""
Local cFornece	:= ""
Local cLoja		:= ""
Local lContinua	:= .T.
Local aCols		:= {}

lContinua:= NCGADelSE2()
If lContinua
	For nI := 1 to len(olMsNewGet:aCols)
		
		If olMsNewGet:aCols[nI,nPLeg] == 'LBTIK'
			cNumero	:= olMsNewGet:aCols[nI,nPNumero]
			cSerie	:= olMsNewGet:aCols[nI,nPSerie]
			cFornece:= olMsNewGet:aCols[nI,nPFornece]
			cLoja	:= olMsNewGet:aCols[nI,nPLoja]
			
			NCGADelCTE(cNumero,cSerie,cFornece,cLoja)
			
		EndIf
		
	Next nI
EndIf

oDlg:End()

//Verifica se não ficou nenhum conhecimento de fretes sem estorno
NCGA100Col(@aCols,.F.)
If len(aCols) = 0
	lAtualizado	:= NCGAAtuFRE()
	If lAtualizado
		reclock("ZZQ",.F.)
		ZZQ->ZZQ_SITUAC	:= "2"
		msunlock()
	EndIf
EndIf

RestArea(aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGADelCTEºAutor  ³Microsiga           º Data ³  21/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCGADelCTE(cNumero,cSerie,cFornece,cLoja)

Local 	aArea		:= GetArea()
Local 	aDel140Cab	:= {}
Local 	aDel140Item	:= {}

Private lMSHelpAuto := .F.
Private lMsErroAuto := .F.

DbSelectArea("SF1")
DbSetOrder(1)
If DbSeek(xFilial("SF1")+cNumero+cSerie+cFornece+cLoja)
	
	aDel140Cab   :={{'F1_DOC'		,cNumero    ,NIL},;
	{'F1_SERIE'		,cSerie		,NIL},;
	{"F1_FORNECE"	,cFornece	,NIL},;
	{"F1_LOJA"		,cLoja		,NIL}}
	
	aDel140Item   :={{'D1_DOC'		,cNumero	,NIL},;
	{'D1_SERIE'		,cSerie		,NIL},;
	{"D1_FORNECE"	,cFornece	,NIL},;
	{"D1_LOJA"		,cLoja		,NIL}}
	
	If Empty(SF1->F1_STATUS )
		MSExecAuto({|x,y,z| MATA140(x,y,z)},aDel140Cab,{aDel140Item},5)
	Else
		MSExecAuto({|x,y,z| MATA103(x,y,z)},aDel140Cab,{aDel140Item},5)
	EndIf
	
	If lMsErroAuto
		MostraErro()
	EndIF
EndIf
RestArea(aArea)

Return ()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGADelSE2ºAutor  ³Microsiga           º Data ³  21/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCGADelSE2()

Local aArea	:= GetArea()
Local aAreaSE2	:= SE2->(GetArea())
Local nOpcao := 5
Local cNum 	:= ""
Local lRet	:= .F.

Private lMSHelpAuto := .F.
Private lMsErroAuto := .F.

DbSelectArea("SE2")
DbSetOrder(1)
If DbSeek(xFilial("SE2")+ZZQ->(ZZQ_PREFIX+ZZQ_NUM+ZZQ_PARCEL+ZZQ_TIPO+ZZQ_FORNEC+ZZQ_LOJA))
	If !(SE2->E2_SALDO == SE2->E2_VALOR)
		Alert("O título a pagar encontra-se baixado e não poderá ser cancelado!")
		lRet	:= .F.
	Else
		aVetor :={	{"E2_FILIAL"    ,xFilial("SE2"),Nil},;
		{"E2_PREFIXO"   ,ZZQ->ZZQ_PREFIX,Nil},;
		{"E2_NUM"       ,ZZQ->ZZQ_NUM,Nil},;
		{"E2_PARCELA"	,ZZQ->ZZQ_PARCEL,Nil} ,;
		{"E2_TIPO"      ,ZZQ->ZZQ_TIPO,Nil},;
		{"E2_FORNECE"   ,ZZQ->ZZQ_FORNEC,Nil},;
		{"E2_LOJA"      ,ZZQ->ZZQ_LOJA,Nil}}
		
		MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aVetor,,5)
		//MsgAlert(ExecTPRE(aVetor, 5 ))
		
		if lMsErroAuto
			MostraErro()
		Else
			DbSelectArea("SE2")
			DbSetOrder(1)
			If DbSeek(xFilial("SE2")+ZZQ->(ZZQ_PREFIX+ZZQ_NUM+ZZQ_PARCEL+ZZQ_TIPO+ZZQ_FORNEC+ZZQ_LOJA))
				lRet	:= .F.			
				MostraErro()
			Else
				Alert("Título excluído do módulo financeiro com sucesso!")
				lRet	:= .T.
			EndIf
		Endif
	EndIf
Else
	lRet	:= .T.
EndIf


RestArea(aAreaSE2)
RestArea(aArea)

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ExecTPRE  º Autor ³ Elton C.			 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina automatica para excluir titulo do contas a pagar	  º±±
±±º          ³					  						  				  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                                 
Static Function ExecTPRE(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclusão

Begin Transaction
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| Fina050(x,y)}, aTitulo, nOpc)
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Os dados informados estão incorretos. Verifique o preenchimento do mesmo."
EndIf

End Transaction

RestArea(aArea)
Return cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGAAtuFREºAutor  ³Microsiga           º Data ³  21/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCGAAtuFRE()

Local aArea	:= GetArea()
Local lAtualizado	:= .F.


cQry := " UPDATE FRETES.TB_FRTFATURAS_CANCELAMENTO SET STATUS = 'NP', SITUACAO = '2', DESC_ERRO = ' ' "
cQry += " WHERE STATUS = 'P' "
cQry += " AND NUM_FATURAS = '"+alltrim(ZZQ->ZZQ_NUM)+alltrim(ZZQ->ZZQ_PARCEL)+"' "
cQry += " AND ID_ENVIO = "+alltrim(str(ZZQ->ZZQ_IDENVI))+" "
If TcSqlExec(cQry) >= 0
	TcSqlExec("COMMIT")
	lAtualizado	:= .T.
Else
	Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
	lAtualizado	:= .F.
EndIf

RestArea(aArea)

Return lAtualizado



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGAAtuINTºAutor  ³Microsiga           º Data ³  21/01/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCGAAtuINT(cCodTransp,cNumFat,cSerie)

Local cQry	:= ""

//Atualiza os registros da integração de faturas para que não sejam mais processados
cQry := " UPDATE FRETES.TB_FRTINTERFFATURAS SET STATUS = 'CF' "
cQry += " WHERE CODIGO_TRANSPORTADOR = '"+alltrim(cCodTransp)+"' "
cQry += " AND NUM_FATURAS = '"+alltrim(cNumFat)+"' "
cQry += " AND SERIE = '"+alltrim(cSerie)+"'"
If TcSqlExec(cQry) >= 0
	TcSqlExec("COMMIT")
Else
	Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
EndIf
//Atualiza os registros da integração de conhecimentos de fretes para que não sejam mais processados
cQry := " UPDATE FRETES.TB_FRTINTERFFATURAS_ITENS SET STATUS = 'CF' "
cQry += " WHERE CODIGO_TRANSPORTADOR = '"+alltrim(cCodTransp)+"' "
cQry += " AND NUM_FATURAS = '"+alltrim(cNumFat)+"' "
cQry += " AND SERIE_FATURA = '"+alltrim(cSerie)+"'"
If TcSqlExec(cQry) >= 0
	TcSqlExec("COMMIT")
Else
	Aviso("ERRO",TCSQLError() + " - " + cQry, {"Ok"})
EndIf


Return
