#Include "topconn.CH"
#Include "Colors.ch"
#Include "Protheus.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGC003   ºAutor  ³Microsiga           º Data ³  09/03/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGC003(cProduto,cArmazem)
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local oListBox
Local cListBox
Local aBotao    		:= {}
Local bCancel   		:= {||oDlgPro:End()}
Local bOk       		:= {||oDlgPro:End()}
Local nOpc				:= 0
Local aTitulo			:= { "Filial","Armazem","Pedido de Vendas em Aberto","Quantidade Empenhada","Qtd.Prevista p/Entrar","Quantidade Reservada (A)","Saldo Atual (B)","Disponível (B - A)"}
Local cTitulo			:= "Consulta Estoque Filial"
Local cReadVar			:= AllTrim(ReadVar())
Private aList			:= {}
Private cCadastro 	:= "Cadastro de Produtos"
Default  cProduto:= &__ReadVar 
Default cArmazem:=""

SB1->(dbSetOrder(1))
If SB1->(!MsSeek(xFilial('SB1')+cProduto))
	MsStop("Produto não encontrado")
	Return
EndIf

MsgRun("Consultando Estoques","Aguarde...", {|| C003Est(cProduto,cArmazem,aList)  } )

nLinha1 :=aSize[7]     
nColuna1:=0


nLinha2 :=aSize[6]*0.5
nColuna2:=aSize[5]*0.65


DEFINE MSDIALOG oDlgPro TITLE OemtoAnsi(cTitulo) From nLinha1,nColuna1 To nLinha2,nColuna2 of oMainWnd PIXEL


oListBox  :=TWBrowse():New(20,0,nColuna2-30,nLinha2-30,{|| { NOSCROLL } },aTitulo,,, ,,,,,,,,,,,.F.,,.T.,,.F.,,, )
oListBox:SetArray(aList)

oListBox:bLine:= {|| {aList[oListBox:nAt,1],aList[oListBox:nAt,2],aList[oListBox:nAt,3],aList[oListBox:nAt,4],aList[oListBox:nAt,5],aList[oListBox:nAt,6],aList[oListBox:nAt,7],aList[oListBox:nAt,8]}}

ACTIVATE MSDIALOG oDlgPro Centered ON INIT EnchoiceBar(oDlgPro,bOk,bcancel,,aBotao)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPC003  ºAutor  ³Microsiga           º Data ³  09/03/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function C003Est(cProduto,cArmazem,aList)
Local cQuery 	 :=""
Local nSizeFil := FWSizeFilial()
Local clAlias  :=GetNextAlias()
Local cFilSB2	:=""
Local	nRecSM0 	:= SM0->(RECNO())
Local cEmpAnt 	:= SM0->M0_CODIGO
Local cPicture	:="@E 999,999,999.99"             		
Local cZerado 	:=TransForm(0,cPicture)
Local aAreaAtu	:=GetArea()

cQuery:=" Select SB2.B2_FILIAL,SB2.B2_LOCAL,SB2.R_E_C_N_O_ RecSB2 "
cQuery+=" From "+RetSqlName("SB2")+" SB2 "
cQuery+=" Where SB2.B2_FILIAL Between '"+Space(nSizeFil)+" ' And '"+Replicate("Z",nSizeFil)+"'"
cQuery+=" And SB2.B2_COD='"+cProduto+"'"
If !Empty(cArmazem)
	cQuery+=" And SB2.B2_LOCAL='"+cArmazem+"'"
EndIf

cQuery+=" And SB2.D_E_L_E_T_=' '"
cQuery+=" Order By SB2.B2_FILIAL,SB2.B2_LOCAL"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)

aList	:= {}

Do While (clAlias)->(!Eof())
	cFilSB2:=(clAlias)->B2_FILIAL
	SM0->(DbSetOrder(1))
	SM0->(DbSeek(cEmpAnt+cFilSB2))
	
	Do While  (clAlias)->(!Eof()) .And. (clAlias)->B2_FILIAL==cFilSB2
		SB2->(DbGoTo( (clAlias)->RecSB2  ))
		nSaldoSB2 :=SaldoSb2(,GetNewPar("MV_QEMPV",.T.))	//³ Retorna o saldo em estoque na data atual
		SB2->( aAdd(aList,{Alltrim(SM0->M0_CODFIL+"-"+SM0->M0_FILIAL),B2_LOCAL,TransForm(B2_QPEDVEN,cPicture),TransForm(B2_QEMP,cPicture),TransForm(B2_SALPEDI,cPicture),TransForm(B2_RESERVA,cPicture),TransForm(B2_QATU,cPicture),TransForm(nSaldoSB2,cPicture)}))
		(clAlias)->(dbskip())
	EndDo
EndDo
SM0->(dbgoto(nRecSM0))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se encontrou algum registro      										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aList) == 0
	aAdd(aList,{"Estoque Indisponível","",cZerado,cZerado,cZerado,cZerado,cZerado,cZerado})
Endif
(clAlias)->(DbCloseArea())
RestArea(aAreaAtu)

Return