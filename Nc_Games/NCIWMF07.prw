#INCLUDE "PROTHEUS.CH "
#INCLUDE 'FWMVCDEF.CH'   

#DEFINE NMARK		1
#DEFINE FILIALAUX	2
#DEFINE NFILIAL	3
#DEFINE PREFIXO 	4
#DEFINE TITULO	5
#DEFINE PARCELA	6
#DEFINE TIPOTIT	7
#DEFINE CLIENTE 	8
#DEFINE LOJA 		9
#DEFINE NOMECLI 	10
#DEFINE EMISSAO 	11
#DEFINE VENCREA 	12
#DEFINE VALOR		13
#DEFINE CODWM		14
#DEFINE CUPOM 	15


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF07 �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Baixa e concilia��o de titulo a receber					  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF07()
Local oBrowse  

DbSelectArea('PZV')
DbSetOrder(1)

//Cria o objeto do tipo FWMBrowse
oBrowse := FWMBrowse():New()     

//Alias ta tabela a ser utilizada no browse
oBrowse:SetAlias('PZV') 

//Legenda
oBrowse:AddLegend("PZV_TPMOV == '1' "	, "BR_VERMELHO"	, "Bx.Titulo"  )
oBrowse:AddLegend("PZV_TPMOV == '2' "	, "BR_LARANJA"	, "Tx.Operadora"  )
oBrowse:AddLegend("PZV_TPMOV == '3' "	, "BR_VERDE"	, "Estorno Op."  )

//Descri��o da rotina
oBrowse:SetDescription("Baixa e Concilia��o de Titulos (Web Manager) ")

oBrowse:Activate()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCBXCONC �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para efetuar a concilia��o e baixa dos	  ���
���          �titulos										    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function MenuDef() 
Local aRotina := {} 

ADD OPTION aRotina Title "Pesquisar"  			Action 'PesqBrw'    	OPERATION 1 ACCESS 0
ADD OPTION aRotina Title "Bx. e Concilia��o"	Action 'U_NCBXCONC' 	OPERATION 3 ACCESS 0
ADD OPTION aRotina Title "Cancela Baixa"	  	Action 'U_NCWMF7CAN' 	OPERATION 5 ACCESS 0
ADD OPTION aRotina Title "Cancela Bx. p/ Lote"	Action 'U_NCWMF7CL' 	OPERATION 6 ACCESS 0
ADD OPTION aRotina Title "Exclui Baixa"	  		Action 'U_NCWMF7EXC' 	OPERATION 7 ACCESS 0
ADD OPTION aRotina Title "Exclui Bx. p/ Lote"	Action 'U_NCWMF7EL' 	OPERATION 8 ACCESS 0
ADD OPTION aRotina Title "Visualizar T�tulo"	Action 'U_NCWM7VTI' 	OPERATION 9 ACCESS 0
ADD OPTION aRotina Title "Posi��o T�tulo"		Action 'U_NCWM7POT' 	OPERATION 10 ACCESS 0


Return aRotina 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCBXCONC �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para efetuar a concilia��o e baixa dos	  ���
���          �titulos										    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCBXCONC()

Local aArea := GetArea()
Local oDlg
Local oWin01
Local oWin02
Local oFWLayer
Local oSize 		:= Nil
Local oFont 		:= TFont():New("CALIBRI",,-14,.T.)	
Local cTGetTpOp 	:= Space(TamSx3("PZS_COD")[1])
Local cTGetFilDe 	:= Space(Len(cFilAnt))
Local cTGetFilAte   := Space(Len(cFilAnt))
Local dTGetDtMovD   := CTOD('')
Local dTGetDtMvA    := CTOD('')
Local nTGetVReceb   := 0
Local cTGetBco 	    := Space(TamSx3("A6_COD")[1])
Local cTGetAgenc 	:= Space(TamSx3("A6_AGENCIA")[1])
Local cTGetCta 	    := Space(TamSx3("A6_NUMCON")[1])
Local nTGetTxOp 	:= 0
Local cTGetNatTOp	:= Space(TamSx3("ED_CODIGO")[1])
Local nTGetVEst     := 0
Local cTGetNatVEst  := Space(TamSx3("ED_CODIGO")[1])    
Local cJustEst     := Space(2000)
Local oButtRel		
Local oButtPesq
Local oButtBxTit
Local oButtSaid                  
Local oScr
Local oLst                                                                      
Local aCab			:= {" ","Filial","Nome Filial", "Prefixo","Titulo","Parcela","Tipo", "Cliente", "Loja", "Nome","Emiss�o","Vencto.Real", "Valor","Codigo WM","Cupom"}
Local oOk			:= LoadBitMap( GetResources(), "LBTIK" )
Local oNo			:= LoadBitMap( GetResources(), "LBNO" )
Local aDPesq		:= {{.F.,,,,,,,,,,,,,,}}
Local nTotRA     	:= 0
Local oTotRA		:= Nil
Local nTotBx     	:= 0
Local oTotBx		:= Nil
Local nTotSel    	:= 0
Local oTotSel		:= Nil
Local aCombConc	:= {"1=Sim","2=N�o","3=Todos"}
Local cCombConc	:= aCombConc[1]
Local oComboConc	:= Nil

//-----------------------------------------
// Cria��o de classe para defini��o da propor��o da interface
//-----------------------------------------
oSize := FWDefSize():New(.T., , nOr(WS_VISIBLE,WS_POPUP) )
oSize:AddObject("TOP", 100, 100, .T., .T.)
oSize:aMargins := {0,0,0,0}
oSize:Process()


DEFINE DIALOG oDlg TITLE "Concilia��o e Baixa de T�tulos(Contas a Receber)" FROM oSize:aWindSize[1],oSize:aWindSize[2] TO oSize:aWindSize[3],oSize:aWindSize[4]-10 PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro � para
//cria��o de um botao de fechar utilizado para Dlg sem cabe�alho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 25, .T. )
oFWLayer:AddCollumn( "Col02", 75, .T. )
                                                                                 

// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se � redimensionada em caso de minimizar outras janelas e a a��o no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Par�metros", 100, .F., .T., ,,)
oFWLayer:AddWindow( "Col02", "Win02", "Sele��o de t�tulos a serem baixados", 100, .F., .T., ,,)

oWin01 := oFWLayer:getWinPanel('Col01','Win01')
oWin02 := oFWLayer:getWinPanel('Col02','Win02')

//oFWLayer:SetColSplit("Col01"	,CONTROL_ALIGN_RIGHT,			,{||  })

//Scroll dos parametros
oScr		:= TScrollBox():New(oWin01,00,00,oWin01:NCLIENTHEIGHT*.45,oWin01:NCLIENTWIDTH*.50,.T.,.T.,.T.)
oScr:Align 	:= CONTROL_ALIGN_ALLCLIENT
                                                 

//Parametros
TSay():New(005,010,{||"*Tp.Financeiro: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 005,85,bSetGet(cTGetTpOp),oScr,060,09,"@!", {||VldTpOp(cTGetTpOp)}/*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"PZS","MV_PAR01",,,,.T.)


//Filial de:
TSay():New(020,010,{||"Filial de: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 020,85,bSetGet(cTGetFilDe),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"SM0","MV_PAR02",,,,.T.)

//Filial ate:
TSay():New(035,010,{||"*Filial ate: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 035,85,bSetGet(cTGetFilAte),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"SM0","MV_PAR03",,,,.T.)

//Data do movimento de:
TSay():New(050,010,{||"*Dt.Movimento de: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)           
TGet():New( 050,85,bSetGet(dTGetDtMovD),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR04",,,,.T.)

//Data do movimento ate:
TSay():New(065,010,{||"*Dt.Movimento ate: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 065,85,bSetGet(dTGetDtMvA),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR05",,,,.T.)

//Valor recebido
TSay():New(080,010,{||"*Valor Recebido: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 080,85,bSetGet(nTGetVReceb),oScr,060,09,X3Picture("E1_VALOR"), /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR06",,,,.T.)

//Banco
TSay():New(095,010,{||"Banco: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)         
TGet():New( 095,85,bSetGet(cTGetBco),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"SA6","MV_PAR07",,,,.T.)

//Agencia
TSay():New(110,010,{||"Ag�ncia: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 110,85,bSetGet(cTGetAgenc),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR08",,,,.T.)

//Conta
TSay():New(125,010,{||"Conta: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)                
TGet():New( 125,85,bSetGet(cTGetCta),oScr,060,09,"@!", /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR09",,,,.T.)

//Tx.Operadora
TSay():New(140,010,{||"Tx.Operadora: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 140,85,bSetGet(nTGetTxOp),oScr,060,09,X3Picture("E1_VALOR"), /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR10",,,,.T.)

//Natureza Tx.Operadora
//TSay():New(155,010,{||"Natureza Tx.Operadora: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
//TGet():New( 155,85,bSetGet(cTGetNatTOp),oScr,060,09,"@!", {|| VldNat(cTGetNatTOp)} /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"SED","MV_PAR11",,,,.T.)

//Valor Estorno
TSay():New(155,010,{||"Valor de Estorno: "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
TGet():New( 155,85,bSetGet(nTGetVEst),oScr,060,09,X3Picture("E1_VALOR"), /*&(cBlkVld)*/,,,, .T.,, .T.,, .T., /*&(cBlkWhen)*/, .F., .F.,, .F., .F. ,"","MV_PAR12",,,,.T.)


//Filtro de concilia��o
TSay():New(170,010,{||"Conciliados C.Card ? "},oScr,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,100,010)
oComboConc := TComboBox():New(170,85,{|u|if(PCount()>0,cCombConc:=u,cCombConc)},aCombConc,50,20,oScr,,{||},,,,.T.,,,,,,,,,'cCombConc')


//Total RA
TSay():New(010,005,{||"Total RA: "},oWin02,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,010)
oTotRA := TGet():New(010,035,bSetGet(nTotRA),oWin02,75,009, "@E 999,999,999,999.99",,0,,,.F.,,.T.,,.F.,{||.F.},.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )


//Total baixado
TSay():New(010,(oWin02:nClientWidth/2)-325,{||"Total Baixado: "},oWin02,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,010)
oTotBx := TGet():New(010,(oWin02:nClientWidth/2)-280,bSetGet(nTotBx),oWin02,75,009, "@E 999,999,999,999.99",,0,,,.F.,,.T.,,.F.,{||.F.},.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )


//Total selecionado
TSay():New(010,(oWin02:nClientWidth/2)-135,{||"Total Selecionado: "},oWin02,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,010)
oTotSel := TGet():New(010,(oWin02:nClientWidth/2)-80,bSetGet(nTotSel),oWin02,75,009, "@E 999,999,999,999.99",,0,,,.F.,,.T.,,.F.,{||.F.},.F.,.F.,,.F./*lReadOnly*/,.F.,,,,,, )


oLst := TWBrowse():New( 030, 005, oWin02:nClientWidth/2-10,oWin02:nClientHeight/2-45,,aCab,,oWin02,,,,,,,,,,,,.F.,,.T.,,.F.,,, ) 
oLst:aColSizes := { 10, 20, 50, 30, 30, 30, 30, 30, 30, 50, 40, 30, 30, 30, 30 }
oLst:SetArray( aDPesq )

oLst:bLine:={ || {	If(aDPesq[oLst:nAt,NMARK],oOk,oNo ),;//Flag
					aDPesq[oLst:nAt,FILIALAUX],;		//Filial 
					Alltrim(aDPesq[oLst:nAt,NFILIAL]),;			//Nome da filial 
					aDPesq[oLst:nAt,PREFIXO],;			//Prefixo 
					aDPesq[oLst:nAt,TITULO],;			//Titulo 
					aDPesq[oLst:nAt,PARCELA],;			//Parcela 
					aDPesq[oLst:nAt,TIPOTIT],;			//Tipo 
					aDPesq[oLst:nAt,CLIENTE],;			//Codigo do Cliente 
					aDPesq[oLst:nAt,LOJA],;				//Loja 
					aDPesq[oLst:nAt,NOMECLI],;			//Nome
					aDPesq[oLst:nAt,EMISSAO],;			//Emiss�o
					aDPesq[oLst:nAt,VENCREA],;			//Vencimento Real
					aDPesq[oLst:nAt,VALOR],;			//Valor
					aDPesq[oLst:nAt,CODWM],;			//Codigo Web Manager
					aDPesq[oLst:nAt,CUPOM],;			//Cupom Fiscal
					} } 

oLst:bLDblClick 	:= {|| aDPesq[oLst:nAt,NMARK] := !aDPesq[oLst:nAt,NMARK],;//Altera��o da flag
							 Iif(aDPesq[oLst:nAt,NMARK], nTotSel += ConvValor(aDPesq[oLst:nAt,VALOR]), nTotSel -= ConvValor(aDPesq[oLst:nAt,VALOR]) ),;//Atualiza��o do valor selecionado
							 oTotSel:Refresh(),;//Atualiza��o do objeto total selecionado (Tget)
							 oLst:Refresh() }//Atualiza��o do objeto Twbrowse
							 
oLst:bHeaderClick 	:= {|| InvMark(@oLst, @aDPesq, @oTotSel, @nTotSel)   } 
oLst:Refresh()



//Adiciona as barras dos bot�es                                                                                                                   
DEFINE BUTTONBAR oBarTree SIZE 10,10 3D BOTTOM OF oWin01

oButtRel 	:= thButton():New(01,01, "Relat�rio"		, oBarTree,  {|| Processa( {|| u_NCIWMF11(.T., cTGetFilDe, cTGetFilAte, cTGetTpOp, dTGetDtMovD, dTGetDtMvA, cCombConc) },"","" ) },35,20,)
oButtPesq	:= thButton():New(01,01, "Pesquisar"		, oBarTree,  {|| Processa( {|| PesqTit(cTGetFilDe, cTGetFilAte, cTGetTpOp, dTGetDtMovD, dTGetDtMvA, @oLst, @aDPesq, @oTotSel, @nTotSel,.T.,cCombConc, @oTotRA, @nTotRA, @oTotBx, @nTotBx)},"","" ) },35,20,)

oButtBxTit	:= thButton():New(01,01, "Baixar Titulos"	, oBarTree,  {|| Processa( {|| BxTiSel(cTGetTpOp, @aDPesq, @nTotSel, nTGetVReceb, nTGetTxOp, nTGetVEst, cTGetBco,;
																										 cTGetAgenc, cTGetCta, cTGetNatTOp, cTGetNatVEst,;
																										 cTGetFilDe, cTGetFilAte, cTGetTpOp, dTGetDtMovD,;
																										 dTGetDtMvA, @oLst, @oTotSel, Alltrim(cJustEst), @oTotRA, @nTotRA, @oTotBx, @nTotBx )},"","" )  },35,20,)


oButtSaid			:= thButton():New(01,01, "Sair"				, oBarTree,  {|| oDlg:End()},25,20,)

oButtSaid:Align 	:= CONTROL_ALIGN_RIGHT 
oButtBxTit:Align 	:= CONTROL_ALIGN_RIGHT
oButtPesq:Align 	:= CONTROL_ALIGN_RIGHT 
oButtRel:Align		:= CONTROL_ALIGN_RIGHT 

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return                  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �InvMark �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Inverte a marca��o										  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function InvMark(oLst, aDPesq, oTotSel, nTotSel)
Local aArea := GetArea()
Local nX	:= 0

Default oLst 	:= Nil
Default aDPesq  := {}                       
Default oTotSel	:= Nil 
Default nTotSel	:= 0

For nX := 1 To Len(aDPesq)
	If aDPesq[nX, NMARK]
		aDPesq[nX, NMARK] := .F.
		nTotSel -= ConvValor(aDPesq[nX,VALOR])
	Else
		aDPesq[nX, NMARK] := .T.     
		nTotSel += ConvValor(aDPesq[nX,VALOR])
	EndIf  	
Next

oTotSel:Refresh()
oLst:Refresh()

RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PesqTit �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para localizar os titulos a serem baixados ���
���          �de acordo com a operadora, data e filial		    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PesqTit(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, oLst, aDPesq, oTotSel, nTotSel, lMarkTodos, cOpcConc, oTotRA, nTotRA, oTotBx, nTotBx) 

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= ""
Local nCnt		:= 0
Local oOk		:= LoadBitMap( GetResources(), "LBTIK" )
Local oNo		:= LoadBitMap( GetResources(), "LBNO" )
Local lAddAux	:= .F.
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))


Default cFilAuxDe		:= "" 
Default cFilAuxAte	:= ""                         
Default cGrpTpFin		:= ""                                 
Default dDtIni		:= ctod('') 
Default dDtFin 		:= ctod('')                        
Default oLst			:= nil
Default aDPesq		:={}
Default oTotSel		:= nil 
Default nTotSel		:= 0
Default lMarkTodos	:= .T.
Default cOpcConc		:= ""
Default oTotRA		:= NIl 
Default nTotRA		:= 0

If VldPesqTit(cFilAuxAte, cGrpTpFin, dDtIni, dDtFin)//Valida��o dos parametros da pesquisa

	cArqTmp	:= GetNextAlias()                                           

	cQuery	:= " SELECT E1_FILORIG, PZP_NOMELJ, E1_PREFIXO, E1_NUM, E1_PARCELA,  E1_TIPO, E1_CLIENTE, E1_LOJA, "+CRLF
 	cQuery	+= "     E1_NOMCLI, E1_EMISSAO, E1_VALOR, E1_VENCREA, E1_YCODWM, E1_YCUPOM FROM "+RetSqlName("SE1")+" SE1 "+CRLF

	cQuery	+= "  INNER JOIN "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
	cQuery	+= "  ON PZP.PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"' "+CRLF
	cQuery	+= "  AND PZP.PZP_CODMOV = SE1.E1_YCODWM "+CRLF
	cQuery	+= "  AND PZP.PZP_PREFIX = SE1.E1_PREFIXO "+CRLF
	cQuery	+= "  AND PZP.PZP_NUM = SE1.E1_NUM "+CRLF
	cQuery	+= "  AND PZP.PZP_PARCEL = SE1.E1_PARCELA "+CRLF
	cQuery	+= "  AND PZP.PZP_TIPO = SE1.E1_TIPO "+CRLF
	cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF

	cQuery	+= "  INNER JOIN "+RetSqlName("PZT")+" PZT "+CRLF
	cQuery	+= "  ON PZT.PZT_FILIAL = '"+xFilial("PZT")+"' "+CRLF
	cQuery	+= "  AND PZT.PZT_COD = '"+cGrpTpFin+"' "+CRLF
	cQuery	+= "  AND PZT.PZT_CODFIN = PZP.PZP_CODFIN "+CRLF
	cQuery	+= "  AND PZT.D_E_L_E_T_ = ' ' "+CRLF
        
	cQuery	+= "  WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery	+= "  AND SE1.E1_TIPO NOT IN('RA','NCC') "+CRLF
	cQuery	+= "  AND SE1.E1_EMISSAO BETWEEN '"+Dtos(dDtIni)+"' AND '"+Dtos(dDtFin)+"'  "+CRLF
	cQuery	+= "  AND SE1.E1_FILORIG BETWEEN '"+cFilAuxDe+"' AND '"+cFilAuxAte+"' "+CRLF
	cQuery	+= "  AND SE1.E1_SALDO > '0' "+CRLF
	cQuery	+= "  AND SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " ORDER BY E1_FILORIG, E1_EMISSAO, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "+CRLF

	dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
	
	(cArqTmp)->( DbGoTop() )
	(cArqTmp)->( dbEval( {|| nCnt++ },,{ || !Eof() } ) )
	(cArqTmp)->( DbGoTop() )
	
	ProcRegua(nCnt)
	aDPesq		:={}
	nTotSel 	:= 0
	While (cArqTmp)->(!Eof())
		
		IncProc("Processando...")
		
		lAddAux := .F.
		
		If Alltrim(cOpcConc) $ "1|2"//1=Conciliados | 2=Nao Conciliados   
			If VldConc((cArqTmp)->E1_YCODWM, cOpcConc)
				lAddAux := .T.
			EndIf
		Else
			lAddAux := .T.
		EndIf
		
		If lAddAux	
			Aadd(aDPesq, {lMarkTodos,;
						(cArqTmp)->E1_FILORIG,;
						Alltrim((cArqTmp)->PZP_NOMELJ),;
						(cArqTmp)->E1_PREFIXO,;
						(cArqTmp)->E1_NUM,;
						(cArqTmp)->E1_PARCELA,;
						(cArqTmp)->E1_TIPO,;
						(cArqTmp)->E1_CLIENTE,;
						(cArqTmp)->E1_LOJA,;
						(cArqTmp)->E1_NOMCLI,;
						DtoC(StoD((cArqTmp)->E1_EMISSAO)),;
						DtoC(StoD((cArqTmp)->E1_VENCREA)),;
						Transform((cArqTmp)->E1_VALOR, X3Picture("E1_VALOR")),;
						(cArqTmp)->E1_YCODWM,;
						(cArqTmp)->E1_YCUPOM;
						} )
			
			If lMarkTodos			
				nTotSel += (cArqTmp)->E1_VALOR
			Else
				nTotSel := 0		
			EndIf
		EndIf
		
		(cArqTmp)->(DbSkip())
	EndDo
	
	
	If Len(aDPesq) > 0
		
		oLst:SetArray(aDPesq)
		oLst:bLine:={ || {	IIF(aDPesq[oLst:nAT,NMARK],oOk,oNo),;//Mark
							aDPesq[oLst:nAT,FILIALAUX],;//Filial
							aDPesq[oLst:nAT,NFILIAL],;	//Nome da Filial
							aDPesq[oLst:nAT,PREFIXO],;	//Prefixo
							aDPesq[oLst:nAT,TITULO],;	//Titulo
							aDPesq[oLst:nAT,PARCELA],;	//Parcela
							aDPesq[oLst:nAT,TIPOTIT],;	//Tipo
							aDPesq[oLst:nAT,CLIENTE],;	//Cliente
							aDPesq[oLst:nAT,LOJA],;		//Loja
							aDPesq[oLst:nAT,NOMECLI],;	//Nome
							aDPesq[oLst:nAT,EMISSAO],;	//Emissao
							aDPesq[oLst:nAT,VENCREA],;	//Vencimento Real
							aDPesq[oLst:nAT,VALOR],;	//Valor
							aDPesq[oLst:nAT,CODWM],;	//Codigo Web manager
							aDPesq[oLst:nAT,CUPOM];		//Cupom fiscal
							} }
							
		oLst:Refresh()
		oTotSel:Refresh()
	Else
		If lMarkTodos
			Aviso("Aten��o","Registro n�o localizado",{"Ok"},2)		
		EndIf                                                  
		
		aDPesq		:= {{.F.,,,,,,,,,,,,,,}}
		nTotSel		:= 0
		
		oLst:SetArray(aDPesq)
		oLst:bLine:={ || {IIF(aDPesq[oLst:nAT,NMARK],oOk,oNo),;//Mark
							aDPesq[oLst:nAT,FILIALAUX],;//Filial
							aDPesq[oLst:nAT,NFILIAL],;	//Nome da filial
							aDPesq[oLst:nAT,PREFIXO],;	//Prefixo
							aDPesq[oLst:nAT,TITULO],;	//Titulo
							aDPesq[oLst:nAT,PARCELA],;	//Parcela
							aDPesq[oLst:nAT,TIPOTIT],;	//Tipo
							aDPesq[oLst:nAT,CLIENTE],;	//Cliente
							aDPesq[oLst:nAT,LOJA],;		//Loja
							aDPesq[oLst:nAT,NOMECLI],;	//Nome
							aDPesq[oLst:nAT,EMISSAO],;	//Emissao
							aDPesq[oLst:nAT,VENCREA],;	//Vencimento Real
							aDPesq[oLst:nAT,VALOR],;	//Valor
							aDPesq[oLst:nAT,CODWM],;	//Codigo Web manager
							aDPesq[oLst:nAT,CUPOM]; 	//Cupom Fiscal
							} }
							
		
		oLst:Refresh()
		oTotSel:Refresh()
	EndIf
	
	
	//Atualiza o valor de RA
	nTotRA	:= 0
	AtuVlTotRA(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, @oTotRA, @nTotRA, cOpcConc)
		
		
	//Atualiza o valor dos itens baixados
	nTotBx := 0
	AtuVlTotBx(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, @oTotBx, @nTotBx, cOpcConc)	


	(cArqTmp)->(DbCloseArea())
EndIf

RestArea(aArea)
Return 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldConc	 �Autor  �Microsiga 	         � Data � 07/04/15  ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o da concilia��o com C.CARD							���
���          �   		  															���
���          �												    		  		���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldConc(cCodWM, cOpcConc)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= ""
Local lRet		:= .T.

Default cCodWM 	:= ""
Default cOpcConc	:= ""


//cQuery	:= " SELECT AUT_TX_PEDIDO, AUT_NR_PEDIDO, WM.AUT_DT_LANCAMENTO, WM.AUT_DT_BATIMENTO, AUT_NR_PARCELA, WM.AUT_FLG_BAIXADO FROM SB_CAR_CLI_AUTORIZACAO WM "

If Alltrim(cOpcConc) == "1"
	cQuery	:= " SELECT COUNT(*) CONTADOR FROM SB_CAR_CLI_AUTORIZACAO WM "+CRLF
	cQuery	+= " WHERE WM.AUT_FLG_BAIXADO = '1' "+CRLF
	cQuery	+= " AND WM.AUT_TX_PEDIDO = '"+cCodWM+"' "+CRLF
	//cQuery	+= " WHERE WM.CAR_CARTAO_ID IN('26','27') "+CRLF


Else
	cQuery	:= " SELECT COUNT(*) CONTADOR FROM SB_CAR_CLI_AUTORIZACAO WM "+CRLF
	cQuery	+= " WHERE WM.AUT_FLG_BAIXADO != '1' "+CRLF
	cQuery	+= " AND WM.AUT_TX_PEDIDO = '"+cCodWM+"' "+CRLF
	//cQuery	+= " WHERE WM.CAR_CARTAO_ID IN('26','27') "+CRLF
Endif

cArqTmp	:= u_NCCXCARD(cQuery)

If Select(cArqTmp)>0
	If (cArqTmp)->CONTADOR > 0
		lRet		:= .T.
	Else
		lRet		:= .F.
	EndIf
	
	(cArqTmp)->(DbCloseArea())
EndIf

RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldPesqTit �Autor  �Microsiga 	      � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o dos parametros da pesquisa						  ���
���          �		    		  										  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldPesqTit(cFilAuxAte, cGrpTpFin, dDtIni, dDtFin)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsg		:= "Campo(s) obrigat�rio(s) n�o preenchido(s): "+CRLF+CRLF
Local cMsgAux   := ""

Default cFilAuxAte	:= "" 
Default cGrpTpFin	:= "" 
Default dDtIni		:= CTOD('')
Default dDtFin  	:= CTOD('')

If Empty(cGrpTpFin)
	cMsgAux   += "-Tp.Financeiro; "+CRLF
	lRet := .F.
EndIf

If Empty(cFilAuxAte)
	cMsgAux   += "-Filial at�; "+CRLF
	lRet := .F.
EndIf

If Empty(dDtIni)
	cMsgAux   += "-Dt.Movimento de; "+CRLF
	lRet := .F.
EndIf

If Empty(dDtIni)
	cMsgAux   += "-Dt.Movimento ate; "+CRLF
	lRet := .F.
EndIf

If !lRet
    Aviso("Aten��o",cMsg+cMsgAux, {"Ok"}, 3 )	
EndIf

RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldTpOp �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o do tipo de opera��o								  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldTpOp(cTpOp)
Local aArea := GetArea()
Local lRet	:= .T.

Default cTpOp := ""

DbSelectArea("PZS")
DbSetOrder(1)

If !Empty(cTpOp)
	If !PZS->(MsSeek(xFilial("PZS") + cTpOp))
		Aviso("Aten��o","Registro n�o encontrado.",{"Ok"},2)	
		lRet	:= .F.
	EndIf
EndIf

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldNat �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o da natureza										  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
/*Static Function VldNat(cNat)
Local aArea := GetArea()
Local lRet	:= .T.

Default cNat := ""

DbSelectArea("SED")
DbSetOrder(1)

If !Empty(cNat)
	If !SED->(MsSeek(xFilial("SED") + cNat))
		Aviso("Aten��o","Registro n�o encontrado",{"Ok"},2)	
		lRet	:= .F.
	EndIf
EndIf

RestArea(aArea)
Return lRet*/


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ConvValor �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Converte a String em Valor numerico						  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ConvValor(cValor)

Local nRet		:= 0
Local cRetAux	:= ""

Default cValor	:= ""

cRetAux := STRTRAN(cValor,".","")
cRetAux := STRTRAN(cRetAux,",",".")
nRet	:= round(Val(cRetAux),2)

Return nRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BxTiSel �Autor  �Microsiga	    � Data � 07/04/15 		  ���
�������������������������������������������������������������������������͹��
���Desc.     �Efetua a baixa dos titulos selecionados, movimento bancario ���
���          �referente a Tx.Operadora e Estorno			    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BxTiSel(cOperadora, aDPesq, nTotSel, nTotReceb, nTotTxOp, nTotEstorn, cBanco, cAgencia, cContaBc, cNatTxOp, cNatEstorn,;
						cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, oLst, oTotSel, cJustif, oTotRA, nTotRA, oTotBx, nTotBx )
				
Local aArea 	:= GetArea()
Local nX		:= 0
Local cNumTitOp	:= ""
Local cNumTitEs	:= ""
Local cCodCtr	:= ""
Local cLogBxTit	:= ""
Local cLogTxOp	:= ""
Local cLogEst	:= ""

Default cOperadora	:= ""
Default aDPesq		:= {} 
Default nTotSel		:= 0                     
Default cBanco		:= "" 
Default cAgencia		:= "" 
Default cContaBc		:= ""                                               
Default nTotReceb		:= 0 
Default nTotTxOp		:= 0 
Default nTotEstorn	:= 0
Default cNatTxOp		:= "" 
Default cNatEstorn	:= ""
Default cFilAuxDe		:= "" 
Default cFilAuxAte	:= "" 
Default cGrpTpFin		:= "" 
Default dDtIni		:= CTOD('') 
Default dDtFin		:= CTOD('') 
Default oLst			:= Nil 
Default oTotSel		:= Nil
Default cJustif		:= ""
Default oTotRA		:= Nil  
Default nTotRA		:= 0 
Default oTotBx		:= Nil 
Default nTotBx		:= 0


ProcRegua(Len(aDPesq))

//Valida��o dos parametros antes da baixa
If VldParamBx(cBanco, cAgencia, cContaBc, nTotSel, nTotReceb, nTotTxOp, nTotEstorn, cNatTxOp, cNatEstorn)
	
	If Aviso("Aten��o","Confirma a baixa dos t�tulos selecionados?",{"Sim","N�o"},2) == 1
		//Grava os dados na tabela de controle das movimenta��es
		cCodCtr := GetSX8Num("PZV","PZV_COD")
		ConfirmSx8()
		
		//Efetua a baixa dos titulos
		For nX := 1 To Len(aDPesq)
			
			IncProc("Processando...")
			
			If aDPesq[nX][NMARK]
				
				//Executa a rotina de baixa dos titulos
				cLogBxTit := PrParamBxT(aDPesq[nX][PREFIXO],;	//Prefixo
										aDPesq[nX][TITULO],;	//Titulo
										aDPesq[nX][PARCELA],;	//Parcela
										aDPesq[nX][TIPOTIT],;	//Tipo
										ConvValor(aDPesq[nX][VALOR]),;//Valor
										0,;						//Desconto
										cBanco,; 				//Banco
										cAgencia,;				//Agencia
										cContaBc)				//Conta
										
				
				
				If Empty(cLogBxTit)

					//Efetua a concilia��o do movimento bancario
					ReconcMB(aDPesq[nX][PREFIXO], aDPesq[nX][TITULO], aDPesq[nX][PARCELA], aDPesq[nX][TIPOTIT])
					
					//GrvBxMbLg(cCodCtr, MsDate(), "1", cBanco, cAgencia, cContaBc, "", ConvValor(aDPesq[nX][VALOR]), aDPesq[nX][PREFIXO], aDPesq[nX][TITULO], aDPesq[nX][PARCELA], aDPesq[nX][TIPOTIT], /*cMoeda*/)  
				   	  GrvBxMbLg(cCodCtr, dDataBase, "1", cBanco, cAgencia, cContaBc, aDPesq[nX][PREFIXO], aDPesq[nX][TITULO], aDPesq[nX][PARCELA], aDPesq[nX][TIPOTIT])								
				Else
					Aviso("Erro encontrado",cLogBxTit, {"Ok"},3 )
				EndIf
			EndIf
		Next
		
		//Tratamento para Taxa da operadora e Estorno
		DbSelectArea("PZS")
		DbSetOrder(1)
		If PZS->(MsSeek(xFilial("PZS") + Padr(cOperadora,TAMSX3("PZS_COD")[1]) ))
						
			//Gera o titulo no contas a pagar e efetua a baixa do mesmo
			If nTotTxOp > 0
				
				//Valida��o das configura��es
				If VldCfgTxOp(PZS->PZS_PREFTX, PZS->PZS_FORNEC, PZS->PZS_LOJAFN, PZS->PZS_TPTXOP, PZS->PZS_NATOP)				
					
					cNumTitOp 	:= GetSXENum("SE2","E2_NUM")
					ConfirmSX8()
					
					cLogTxOp	:= GerTitCP(PZS->PZS_PREFTX,;//Prefixo
											cNumTitOp,;//Numero do titulo
											"1",;//Parcela
											PZS->PZS_TPTXOP,;// Tipo do titulo
											PZS->PZS_FORNEC,; //Fornecedor
											PZS->PZS_LOJAFN,; //Loja
											POSICIONE("SA2",1,XFILIAL("SA2")+PZS->PZS_FORNEC+PZS->PZS_LOJAFN,"A2_NOME"),; //Nome
											PZS->PZS_NATOP,; //Natureza
											dDataBase,; //Data de emiss�o
											dDataBase,; //Data de vencimento
											nTotTxOp,; //Taxa da operadora
											/*cHist*/,;
											cBanco,;//Banco 
											cAgencia,; //Agencia
											cContaBc)//Conta
					
					If Empty(cLogTxOp)
					
						//Efetua a concilia��o do movimento bancario
						ReconcMB(PZS->PZS_PREFTX, cNumTitOp, "1", PZS->PZS_TPTXOP)  

						//Grava os dados na tabela de controle das movimenta��es
						//GrvBxMbLg(cCodCtr, MsDate(), "2", cBanco, cAgencia, cContaBc, PZS->PZS_NATOP, nTotTxOp, PZS->PZS_PREFTX, cNumTitOp, "1", PZS->PZS_TPTXOP)
						  GrvBxMbLg(cCodCtr, dDataBase, "2", cBanco, cAgencia, cContaBc, PZS->PZS_PREFTX, cNumTitOp, "1", PZS->PZS_TPTXOP)
					EndIf
				EndIf
			EndIf
			
			
			//Efetua a movimenta��o bancaria (Pagar) referente o estorno
			If nTotEstorn > 0
			
				cNumTitEs 	:= GetSXENum("SE1","E1_NUM") 
				ConfirmSX8()
				cLogEst		:= GerTitCR(PZS->PZS_PREFES,;
										 cNumTitEs,; 
										 "1",; 
										 PZS->PZS_TPESTO,; 
										 PZS->PZS_CLIENT,; 
										 PZS->PZS_LOJACL,; 
										 POSICIONE("SA1",1,XFILIAL("SA1")+PZS->PZS_CLIENT+PZS->PZS_LOJACL,"A1_NOME"),; 
										 PZS->PZS_NATEST,; 
										 dDataBase,; 
										 dDataBase,; 
										 nTotEstorn,;
										  /*cHist*/)
			
			   	If Empty(cLogEst)
					//GrvBxMbLg(cCodCtr, MsDate(), "3", cBanco, cAgencia, cContaBc, PZS->PZS_NATEST, nTotEstorn, PZS->PZS_PREFES, cNumTitEs, "1", PZS->PZS_TPESTO)
					GrvBxMbLg(cCodCtr, dDataBase, "3", cBanco, cAgencia, cContaBc, PZS->PZS_PREFES, cNumTitEs, "1", PZS->PZS_TPESTO)
				Endif
			EndIf
			
		Else
			Aviso("Aten��o","Tp. Financeiro "+Alltrim(cOperadora)+" n�o encontrado.",{"Ok"},2 )
		EndIf
		
		
		//Atualiza a a grid ap�s a baixa
		PesqTit(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, @oLst, @aDPesq, @oTotSel, @nTotSel, .F.,, @oTotRA, @nTotRA, @oTotBx, @nTotBx)
	EndIf
EndIf

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldParamBx �Autor  �Microsiga	    � Data � 07/04/15 		  ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o dos parametros da baixa							  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldParamBx(cBanco, cAgencia, cContaBc, nTotSel, nTotReceb, nTotTxOp, nTotEstorn)

Local aArea 	:= GetArea()
Local cMsgAux	:= ""
Local lRet		:= .T.

Default cBanco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""                                                                      
Default nTotSel		:= 0 
Default nTotReceb	:= 0 
Default nTotTxOp	:= 0 
Default nTotEstorn	:= 0                                                                                     

DbSelectArea("SA6")
DbSetOrder(1)

If !Empty(cBanco) .And. !Empty(cAgencia) .And. !Empty(cContaBc)	

	If !SA6->(MsSeek(xFilial("SA6") + PadR(cBanco, TAMSX3("A6_COD")[1]) + PadR(cAgencia, TAMSX3("A6_AGENCIA")[1]) + PadR(cContaBc, TAMSX3("A6_NUMCON")[1]) ) )
		lRet := .F.
		cMsgAux += "- A chave Banco + Agencia + Conta, n�o foi encontrada;"+CRLF
	EndIf	
Else
	cMsgAux += "- Campos obrigat�rios n�o preenchidos: Banco | Agencia | Conta;"+CRLF
	lRet := .F.
EndIf

If !VldTotSel(nTotSel, nTotReceb, nTotTxOp, nTotEstorn, .F.)
	lRet := .F.
	cMsgAux += "- O valor total selecionado deve ser igual a soma (Valor Recebido + Tx. Operadora + Valor de Estorno);"+CRLF
EndIf 


If (nTotReceb + nTotTxOp + nTotEstorn) <= 0
	lRet := .F.
	cMsgAux += "- A soma (Valor Recebido + Tx. Operadora + Valor de Estorno) deve ser maior que 0;"+CRLF
EndIf

If nTotReceb < 0 
	lRet := .F.
	cMsgAux += "- O valor recebido n�o pode ser negativo;"+CRLF
EndIf


If nTotTxOp < 0 
	lRet := .F.
	cMsgAux += "- O valor da taxa da operadora n�o pode ser negativo;"+CRLF
EndIf

If nTotEstorn < 0 
	lRet := .F.
	cMsgAux += "- O valor de estorno n�o pode ser negativo;"+CRLF
EndIf

If !lRet
	Aviso("Aten��o", "Erro encontrado no preenchimento dos par�metros: "+CRLF+CRLF+cMsgAux,{"Ok"},3)
EndIf

RestArea(aArea)
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldCfgTxOp �Autor  �Microsiga	    � Data � 07/04/15 		  ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o das regras de configura��o da taxa da operadora	  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldCfgTxOp(cPrefix, cFornec, cLoja, cTipo, cNaturez)

Local aArea 	:= GetArea()
Local cMsgAux   := ""
Local lRet		:= .T.

Default cPrefix		:= "" 
Default cFornec		:= "" 
Default cLoja		:= "" 
Default cTipo		:= "" 
Default cNaturez	:= ""

If Empty(cPrefix)
	cMsgAux	+= "-Prefixo n�o configurado."+CRLF
	lRet	:= .F.
EndIf


If !Empty(cFornec) .And. !Empty(cLoja)
	DbSelectArea("SA2")
	DbSetOrder(1)
	If SA2->(!MsSeek(xFilial("SA2") + cFornec + cLoja ))
		cMsgAux	+= "-Fornecedor ("+Alltrim(cFornec)+"|"+Alltrim(cLoja)+") utilizado na configura��o n�o foi encontrado no cadastro de fornecedores."+CRLF
		lRet	:= .F.			
	EndIf
Else
	cMsgAux	+= "-Dados do fornecedor n�o configurado."+CRLF
	lRet	:= .F.	
EndIf

If !Empty(cTipo)
	DbSelectArea("SX5")
	DbSetOrder(1)
	If SX5->(!MsSeek(xFilial("SX5")+"05"+cTipo))
		cMsgAux	+= "-Tipo do t�tulo ("+Alltrim(cTipo)+") utilizado na configura��o, n�o foi encontrado no cadastro de tipo. "+CRLF
		lRet	:= .F.
	EndIf
Else
	cMsgAux	+= "-Tipo do t�tulo n�o configurado."+CRLF
	lRet	:= .F.
EndIf


If !Empty(cNaturez)
	DbSelectArea("SED")   
    DbSetOrder(1)
    If SED->(!MsSeek(xFilial("SED") + cNaturez ))
		cMsgAux	+= "-Natureza ("+Alltrim(cNaturez)+") utilizada na configura��o n�o foi encontrada no cadastro de naturezas."+CRLF
		lRet	:= .F.    
    EndIf
Else
	cMsgAux	+= "-Natureza n�o configurada."+CRLF
	lRet	:= .F.
EndIf


If !lRet
	
	Aviso("Aten��o", "N�o foi poss�vel gerar o t�tulo da Tx. Da Operadora no Contas a Receber. Verifique o cadastro de regras."+CRLF+"  Erros encontrados: "+CRLF+CRLF+cMsgAux,{"Ok"},3)
		
EndIf

RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldTotSel �Autor  �Microsiga	    � Data � 07/04/15 		  ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se o valor total selecionado � igual a soma dos	  ���
���          �parametros Valor Recebido + Tx.Operadora + Estorno   		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldTotSel(nTotSel, nTotReceb, nTotTxOp, nTotEstorn, lShowMsg)

Local aArea := GetArea()
Local lRet	:= .T.

Default nTotSel		:= 0 
Default nTotReceb	:= 0 
Default nTotTxOp	:= 0 
Default nTotEstorn	:= 0 
Default lShowMsg 	:= .T.

If ConvValor(Transform(nTotSel,"@E 999,999,999,999.99")) != (nTotReceb + nTotTxOp + nTotEstorn) 
    
	lRet := .F. 
	If lShowMsg
		Aviso("Aten��o", "O valor total selecionado deve ser igual a soma (Valor Recebido + Tx. Operadora + Valor de Estorno)",{"Ok"}, 2)
	EndIf
EndIf


RestArea(aArea)
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PrParamBxT �Autor  �Microsiga	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Preenche o array com os titulos a serem baixados			  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrParamBxT(cPrefixo, cNumTit, cParcela, cTipo, nValor, nDescont, cBco, cAgencia, cContaBc)

Local aArea 	:= GetArea()
Local aTitulo   := {}
Local cRet		:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default nValor		:= 0 
Default nDescont	:= 0
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""



AADD(aTitulo,	{"E1_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	,cTipo      		,Nil } )
AADD(aTitulo,	{"AUTMOTBX"	    	,"NOR"            	,Nil } )
AADD(aTitulo,	{"AUTBANCO"			,PADR(Alltrim(cBco)		, TAMSX3("A6_COD")[1]) 	,Nil } )
AADD(aTitulo,	{"AUTAGENCIA"		,PADR(Alltrim(cAgencia)	, TAMSX3("A6_AGENCIA")[1])	,Nil } )
AADD(aTitulo,	{"AUTCONTA"			,PADR(Alltrim(cContaBc)	, TAMSX3("A6_NUMCON")[1])	,Nil } )
AADD(aTitulo,	{"AUTDTBAIXA"	 	,dDataBase        	,Nil } )
AADD(aTitulo,	{"AUTHIST"	    	,cPrefixo+"-"+cNumTit+"-"+cParcela+"-"+cTipo		,Nil })
AADD(aTitulo,	{"AUTDESCONT"       ,nDescont			,Nil } )
AADD(aTitulo,	{"AUTVALREC"	 	,nValor			   	,Nil } )

//Chama a rotina para efetuar a baixa do titulo 
cRet := RunBxTCR(aTitulo, 3 )

RestArea(aArea)
Return cRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunBxTCR �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a rotina autom�tica para efetuar a baixa do titulo  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RunBxTCR(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Baixa

Begin Transaction
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MSExecAuto({|x,y| FINA070(x,y)},aTitulo,nOpc)
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Os dados informados est�o incorretos. Verifique o preenchimento do mesmo."
EndIf

End Transaction

RestArea(aArea)
Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvBxMbLg	 �Autor  �Microsiga 	      � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava os dados da baixa e movimenta��o bancaria			  ���
���          �na tabela de controel PZV						    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvBxMbLg(cCod, dDtMov, cTipoMov, cBanco, cAgencia, cConta, cPrefixo, cTitulo, cParcela, cTipo)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))


Default cCod		:= ""
Default dDtMov      := CTOD('')
Default cTipoMov    := ""
Default cBanco      := ""
Default cAgencia    := ""
Default cConta      := ""
Default cPrefixo    := ""
Default cTitulo     := ""
Default cParcela    := ""
Default cTipo       := ""

DbSelectArea("PZV")
DbSetOrder(1)

If Alltrim(cTipoMov) == "1"//Baixa de contas a receber
	
	cQuery := " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_NATUREZ, E1_CLIENTE, E1_LOJA, E1_NOMCLI, E1_VENCREA, E1_EMISSAO, E1_VALOR, E1_FILORIG, "+CRLF
	cQuery += "      PZP_FILORI, PZP.PZP_NOMELJ, PZP_CODFIN, PZP_DESCFI, PZP_CODMOV FROM "+RetSqlName("SE1")+" SE1 "+CRLF
	
	cQuery += " INNER JOIN "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF 
	cQuery += " ON PZP.PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"' "+CRLF
	cQuery += " AND PZP.PZP_CODMOV = SE1.E1_YCODWM "+CRLF
	cQuery += " AND PZP.PZP_PREFIX = SE1.E1_PREFIXO "+CRLF
	cQuery += " AND PZP.PZP_NUM = SE1.E1_NUM "+CRLF
	cQuery += " AND PZP.PZP_PARCEL =  SE1.E1_PARCELA "+CRLF
	cQuery += " AND PZP.PZP_TIPO = SE1.E1_TIPO "+CRLF
	cQuery += " AND PZP.D_E_L_E_T_ = ' ' "+CRLF
	
	cQuery += " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery += " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
	cQuery += " AND SE1.E1_NUM = '"+cTitulo+"' "+CRLF
	cQuery += " AND SE1.E1_PARCELA = '"+cParcela+"' "+CRLF
	cQuery += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
	cQuery += " AND SE1.D_E_L_E_T_ = ' ' "+CRLF
	
	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
	
	Reclock("PZV", .T.)
	PZV->PZV_FILIAL	:= xFilial("PZV")
	PZV->PZV_COD   	:= cCod
	PZV->PZV_DATA   := dDtMov
	PZV->PZV_TPMOV  := cTipoMov
	PZV->PZV_BANCO  := cBanco
	PZV->PZV_AGENCI := cAgencia
	PZV->PZV_CONTA  := cConta
	PZV->PZV_PREFIX := (cArqTmp)->E1_PREFIXO
	PZV->PZV_NUM    := (cArqTmp)->E1_NUM
	PZV->PZV_PARCEL := (cArqTmp)->E1_PARCELA
	PZV->PZV_TIPO   := (cArqTmp)->E1_TIPO
	PZV->PZV_NATURE := (cArqTmp)->E1_NATUREZ
	PZV->PZV_FILORI := (cArqTmp)->E1_FILORIG
	PZV->PZV_EMISSA	:= STOD((cArqTmp)->E1_EMISSAO)
	PZV->PZV_CODFIN	:= (cArqTmp)->PZP_CODFIN
	PZV->PZV_DESCFI	:= (cArqTmp)->PZP_DESCFI
	PZV->PZV_CODMOV	:= (cArqTmp)->PZP_CODMOV
	PZV->PZV_CODCLI	:= (cArqTmp)->E1_CLIENTE
	PZV->PZV_LOJA	:= (cArqTmp)->E1_LOJA
	PZV->PZV_DTVCTO	:= STOD((cArqTmp)->E1_VENCREA)
	PZV->PZV_VALOR  := (cArqTmp)->E1_VALOR
	PZV->(MsUnLock())
	
	(cArqTmp)->(DbCloseArea())

ElseIf Alltrim(cTipoMov) == "2"

	cQuery := " SELECT E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_NATUREZ, E2_FORNECE, E2_LOJA, "+CRLF
	cQuery += "          E2_VENCREA, E2_EMISSAO, E2_VALOR, E2_FILORIG FROM "+RetSqlName("SE2")+" SE2 "+CRLF
	cQuery += " WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"' "+CRLF
	cQuery += " AND SE2.E2_PREFIXO = '"+cPrefixo+"' "+CRLF
	cQuery += " AND SE2.E2_NUM = '"+cTitulo+"' "+CRLF
	cQuery += " AND SE2.E2_PARCELA = '"+cParcela+"' "+CRLF
	cQuery += " AND SE2.E2_TIPO = '"+cTipo+"' "+CRLF
	cQuery += " AND SE2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND D_E_L_E_T_ = ' ' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
	
	Reclock("PZV", .T.)
	PZV->PZV_FILIAL	:= xFilial("PZV")
	PZV->PZV_COD   	:= cCod
	PZV->PZV_DATA   := dDtMov
	PZV->PZV_TPMOV  := cTipoMov
	PZV->PZV_BANCO  := cBanco
	PZV->PZV_AGENCI := cAgencia
	PZV->PZV_CONTA  := cConta
	PZV->PZV_PREFIX := (cArqTmp)->E2_PREFIXO
	PZV->PZV_NUM    := (cArqTmp)->E2_NUM
	PZV->PZV_PARCEL := (cArqTmp)->E2_PARCELA
	PZV->PZV_TIPO   := (cArqTmp)->E2_TIPO
	PZV->PZV_NATURE := (cArqTmp)->E2_NATUREZ
	PZV->PZV_FILORI := (cArqTmp)->E2_FILORIG
	PZV->PZV_EMISSA	:= STOD((cArqTmp)->E2_EMISSAO)
	PZV->PZV_CODCLI	:= (cArqTmp)->E2_FORNECE
	PZV->PZV_LOJA	:= (cArqTmp)->E2_LOJA
	PZV->PZV_DTVCTO	:= STOD((cArqTmp)->E2_VENCREA)
	PZV->PZV_VALOR  := (cArqTmp)->E2_VALOR
	PZV->(MsUnLock())
	(cArqTmp)->(DbCloseArea())

ElseIf Alltrim(cTipoMov) == "3"
	
	cQuery := " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_NATUREZ, E1_CLIENTE, E1_LOJA, "+CRLF
    cQuery += "      E1_VENCREA, E1_EMISSAO, E1_VALOR, E1_FILORIG FROM "+RetSqlName("SE1")+" SE1 "+CRLF

	cQuery += " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery += " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
	cQuery += " AND SE1.E1_NUM = '"+cTitulo+"' "+CRLF
	cQuery += " AND SE1.E1_PARCELA = '"+cParcela+"' "+CRLF
	cQuery += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
	cQuery += " AND SE1.D_E_L_E_T_ = ' ' "+CRLF


	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
	
	Reclock("PZV", .T.)
	PZV->PZV_FILIAL	:= xFilial("PZV")
	PZV->PZV_COD   	:= cCod
	PZV->PZV_DATA   := dDtMov
	PZV->PZV_TPMOV  := cTipoMov
	PZV->PZV_BANCO  := cBanco
	PZV->PZV_AGENCI := cAgencia
	PZV->PZV_CONTA  := cConta
	PZV->PZV_PREFIX := (cArqTmp)->E1_PREFIXO
	PZV->PZV_NUM    := (cArqTmp)->E1_NUM
	PZV->PZV_PARCEL := (cArqTmp)->E1_PARCELA
	PZV->PZV_TIPO   := (cArqTmp)->E1_TIPO
	PZV->PZV_NATURE := (cArqTmp)->E1_NATUREZ
	PZV->PZV_FILORI := (cArqTmp)->E1_FILORIG
	PZV->PZV_EMISSA	:= STOD((cArqTmp)->E1_EMISSAO)
	PZV->PZV_CODCLI	:= (cArqTmp)->E1_CLIENTE
	PZV->PZV_LOJA	:= (cArqTmp)->E1_LOJA
	PZV->PZV_DTVCTO	:= STOD((cArqTmp)->E1_VENCREA)
	PZV->PZV_VALOR  := (cArqTmp)->E1_VALOR
	PZV->(MsUnLock())
	(cArqTmp)->(DbCloseArea())
	
EndIf
             

RestArea(aArea)
Return               


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GerTitCP �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Efetua a cria��o do titulo no contas a pagar			      ���
���          �	                                                   		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GerTitCP(cPrefixo, cNumTit, cParcel, cTipo, cFornece, cLoja, cNome, cNaturez, dDtEmissao, dDtVencto, nValor, cHist, cBco, cAgencia, cContaBc)

Local aArea 	:= GetArea() 
Local aTitulo   := {}    
Local cMsgRet	:= ""
                    
Default cPrefixo	:= ""	       
Default cNumTit		:= ""
Default cParcel		:= "" 
Default cTipo		:= "" 
Default cFornece	:= "" 
Default cLoja		:= "" 
Default cNome		:= "" 
Default cNaturez	:= "" 
Default dDtEmissao	:= CTOD('') 
Default dDtVencto	:= CTOD('') 
Default nValor		:= 0                                                              
Default cHist		:= ""
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""

AADD(aTitulo,	{"E2_PREFIXO"	,cPrefixo				,Nil})
AADD(aTitulo,	{"E2_NUM"		,cNumTit				,Nil})
AADD(aTitulo,	{"E2_PARCELA"	,cParcel				,Nil})
AADD(aTitulo,	{"E2_TIPO"		,cTipo					,Nil})
AADD(aTitulo,	{"E2_NATUREZ"	,cNaturez				,Nil})
AADD(aTitulo,	{"E2_FORNECE"	,cFornece				,Nil})
AADD(aTitulo,	{"E2_LOJA"	    ,cLoja					,Nil})
AADD(aTitulo,	{"E2_NOMFOR"	,cNome					,Nil})
AADD(aTitulo,	{"E2_EMISSAO" 	,dDtEmissao		 		,Nil})
AADD(aTitulo,	{"E2_VENCTO" 	,dDtVencto		  		,Nil})
AADD(aTitulo,	{"E2_VALOR"		,nValor					,Nil})
AADD(aTitulo,	{"E2_HIST"		,cHist					,Nil})
AADD(aTitulo,	{"E2_ORIGEM"	,"NCIWMF07"				,Nil})
                
//Executa a rotina automatica para cria��o do titulo no contas a pagar do modulo financeiro
cMsgRet := RunTitCP(aTitulo, 3 )

If Empty(cMsgRet)
	cMsgRet := BxTitCP(cPrefixo, cNumTit, cParcel, cTipo, nValor, cBco, cAgencia, cContaBc)
	
	If !Empty(cMsgRet)
		Aviso("Aten��o","N�o foi poss�vel realizar a baixa do t�tulo ("+cPrefixo+"|"+cNumTit+"|"+cParcel+"|"+cTipo+") no Contas a Pagar. Efetuar  a baixa manual. "+CRLF+CRLF+cMsgRet,{"Ok"},3)	 	
	EndIf
Else
	Aviso("Aten��o","N�o foi poss�vel gerar o t�tulo no Contas a Pagar. Efetuar o processo manual."+CRLF+CRLF+cMsgRet, {"Ok"},3)
EndIf	


RestArea(aArea)
Return cMsgRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunTitCP		 �Autor  �Microsiga	 � Data � 07/04/15 		  ���
�������������������������������������������������������������������������͹��
���Desc.     �	Executa a rotina automatica para gerar o titulo no contas ���
���          �	a pagar										    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/ 
Static Function RunTitCP(aTitulo, nOpc)

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclus�o

//Inicio da transa��o
Begin Transaction

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	If nOpc != 5
		//Chama a rotina automatica para gravar os dados da nota de entrada
		MsExecAuto({|x,y| Fina050(x,y)}, aTitulo, nOpc)
	Else
		MsExecAuto({|x,y,z| Fina050(x,y,z)}, aTitulo, nOpc, 5)	//Exclus�o
	EndIf

	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa��o
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados n�o informados"
EndIf

//Finalisa a transa��o
End Transaction

RestArea(aArea)
Return cRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BxTitCP �Autor  �Microsiga	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para realizar a baixa do contas a pagar	  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BxTitCP(cPrefixo, cNumTit, cParcela, cTipo, nValor, cBco, cAgencia, cContaBc)

Local aArea 	:= GetArea()
Local aTitulo   := {}
Local cRet		:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default nValor		:= 0 
Default cBco		:= "" 
Default cAgencia	:= "" 
Default cContaBc	:= ""

AADD(aTitulo,	{"E2_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E2_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E2_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E2_TIPO"	    	,cTipo      		,Nil } )
AADD(aTitulo,	{"AUTMOTBX"	    	,"DEB"            	,Nil } )
AADD(aTitulo,	{"AUTDTBAIXA"	 	,dDataBase        	,Nil } )
AADD(aTitulo,	{"AUTHIST"	    	,cPrefixo+"-"+cNumTit+"-"+cParcela+"-"+cTipo		,Nil })
AADD(aTitulo,	{"AUTBANCO"			,PADR(Alltrim(cBco)		, TAMSX3("A6_COD")[1]) 	,Nil } )
AADD(aTitulo,	{"AUTAGENCIA"		,PADR(Alltrim(cAgencia)	, TAMSX3("A6_AGENCIA")[1])	,Nil } )
AADD(aTitulo,	{"AUTCONTA"			,PADR(Alltrim(cContaBc)	, TAMSX3("A6_NUMCON")[1])	,Nil } )
AADD(aTitulo,	{"AUTJUROS"       	,0					,Nil } )
AADD(aTitulo,	{"AUTCM1"       	,0					,Nil } )
AADD(aTitulo,	{"AUTPRORATA"      	,0					,Nil } )
AADD(aTitulo,	{"AUTVALREC"      	,nValor				,Nil } )

//Chama a rotina para efetuar a baixa do titulo 
cRet := RunBxCP(aTitulo, 3 )

RestArea(aArea)
Return cRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunBxCP		 �Autor  �Microsiga	 � Data � 07/04/15 		  ���
�������������������������������������������������������������������������͹��
���Desc.     �	Executa a rotina automatica para baixar o titulo do 	  ���
���          �	contas a pagar								    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/ 
Static Function RunBxCP(aTitulo, nOpc)

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclus�o

//Inicio da transa��o
Begin Transaction

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| Fina080(x,y)}, aTitulo, nOpc)

	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa��o
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados n�o informados"
EndIf

//Finalisa a transa��o
End Transaction

RestArea(aArea)
Return cRet
                                                                                                  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GerTitCR �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gera o titulo no contas a receber						      ���
���          �	                                                   		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GerTitCR(cPrefixo, cNumTit, cParcel, cTipo, cCliente, cLoja, cNome, cNaturez, dDtEmissao, dDtVencto, nValor, cHist)

Local aArea 	:= GetArea()
Local aTitulo   := {}    
                                                              
Default cPrefixo	:= ""
Default cTipo		:= ""         
Default cParcel		:= ""
Default cCliente	:= ""
Default cLoja		:= ""
Default cNome		:= ""
Default cNaturez	:= ""
Default dDtEmissao	:= CTOD('')
Default dDtVencto	:= CTOD('')
Default nValor		:= 0
Default cHist		:= ""

AADD(aTitulo,	{"E1_PREFIXO"	,cPrefixo				,Nil})
AADD(aTitulo,	{"E1_NUM"		,cNumTit				,Nil})
AADD(aTitulo,	{"E1_PARCELA"	,cParcel				,Nil})
AADD(aTitulo,	{"E1_TIPO"		,cTipo					,Nil})
AADD(aTitulo,	{"E1_NATUREZ"	,cNaturez				,Nil})
AADD(aTitulo,	{"E1_CLIENTE"	,cCliente				,Nil})
AADD(aTitulo,	{"E1_LOJA"	    ,cLoja					,Nil})
AADD(aTitulo,	{"E1_NOMCLI"	,cNome					,Nil})
AADD(aTitulo,	{"E1_EMISSAO" 	,dDtEmissao		 		,Nil})
AADD(aTitulo,	{"E1_VENCTO" 	,dDtVencto		  		,Nil})
AADD(aTitulo,	{"E1_VALOR"		,nValor					,Nil})
AADD(aTitulo,	{"E1_HIST"		,cHist					,Nil})
AADD(aTitulo,	{"E1_ORIGEM"	,"NCIWMF07"				,Nil})

                
//Executa a rotina automatica para cria��o do titulo no contas a receber do modulo financeiro
cMsgRet := RunTitCR(aTitulo, 3 )

If !Empty(cMsgRet)
	Aviso("Aten��o","N�o foi poss�vel gerar o t�tulo ("+cPrefixo+"|"+cNumTit+"|"+cParcel+"|"+cTipo+") de estorno no contas a receber.",{"Ok"},2)	 	
EndIf	


RestArea(aArea)
Return cMsgRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunTitCR	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a gera��o de titulos							      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RunTitCR(aTitulo, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aTitulo := {} 
Default nOpc	:= 3//Inclus�o

//Inicio da transa��o
Begin Transaction

//Verifica se os dados foram informados
If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, nOpc)
	//Fina040(aTitulo,nOpc)
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		//Captura a mensagem de erro
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		
		//Rollback da transa��o
		DisarmTransaction()
		
	EndIf
	
Else
	cRet := "Dados n�o informados"
EndIf

//Finalisa a transa��o
End Transaction

RestArea(aArea)
Return cRet  


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWMF7CAN �Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cancelamento da baixa									      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWMF7CAN()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

If Aviso("Aten��o","Deseja efetuar o cancelamento da baixa ?",{"Sim","N�o"}) == 1
    
	If Alltrim(PZV->PZV_TPMOV) == '1'
		//Chama a rotina para efetuar o cancelamento da baixa do titulo
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := CancBxTCR(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO) })
	ElseIf Alltrim(PZV->PZV_TPMOV) == '2'//Exclui a taxa da operadora (Contas a Pagar)
	
		//Chama a rotina para efetuar o cancelamento da baixa do titulo
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := ExcTitCP(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO)	})	
	
	ElseIf Alltrim(PZV->PZV_TPMOV) == '3'//Exclui o estorno da operadora (Contas a Receber) 
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := ExcTitCR(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO)	})	
		
	
	EndIf
	
	//Atualiza a flag de estorno
	If Empty(cMsgAuto) .And. (Alltrim(PZV->PZV_TPMOV) $ '1|2|3')
		Reclock("PZV",.F.)
		PZV->(DbDelete())
		PZV->(MsUnLock())                                             
		Aviso("�xito","Cancelamento da baixa efetuado com sucesso.",{"Ok"},2)
	EndIf

EndIf
RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWMF7CAN �Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cancelamento da baixa									      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWMF7EXC()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

If Aviso("Aten��o","Deseja efetuar o cancelamento da baixa ?",{"Sim","N�o"}) == 1
    
	If Alltrim(PZV->PZV_TPMOV) == '1'
		//Chama a rotina para efetuar o cancelamento da baixa do titulo
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := CancBxTCR(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO, 6) })
	ElseIf Alltrim(PZV->PZV_TPMOV) == '2'//Exclui a taxa da operadora (Contas a Pagar)
	
		//Chama a rotina para efetuar o cancelamento da baixa do titulo
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := ExcTitCP(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO)	})	
	
	ElseIf Alltrim(PZV->PZV_TPMOV) == '3'//Exclui o estorno da operadora (Contas a Receber) 
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| cMsgAuto := ExcTitCR(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO)	})	
		
	
	EndIf
	
	//Atualiza a flag de estorno
	If Empty(cMsgAuto) .And. (Alltrim(PZV->PZV_TPMOV) $ '1|2|3')
		Reclock("PZV",.F.)
		PZV->(DbDelete())
		PZV->(MsUnLock())                                             
		Aviso("�xito","Cancelamento da baixa efetuado com sucesso.",{"Ok"},2)
	EndIf

EndIf
RestArea(aArea)
Return


                                                                        
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CancBxTCR	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a rotina de cancelmaneto da baixa				      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CancBxTCR(cPrefixo, cNumTit, cParcela, cTipo, nOpc)

Local aArea := GetArea()
Local aTitulo   := {}
Local cMsgAuto	:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""  
Default nOpc		:= 5                                   

//Exclui a concilia��o do movimento banc�rio.
DesconcMB(cPrefixo, cNumTit, cParcela, cTipo)

AADD(aTitulo,	{"E1_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	,cTipo      		,Nil } )

//Chama a rotina para cancelar a baixa do titulo 
cMsgAuto := RunBxTCR(aTitulo, nOpc )


If !Empty(cMsgAuto)
	Aviso("Aten��o","N�o foi poss�vel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgAuto, {"Ok"},3)			
Endif

RestArea(aArea)
Return cMsgAuto


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWMF7CL	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a rotina de cancelmaneto da baixa				      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWMF7CL()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

Processa({||  cMsgAuto := CancBxLote(5) })

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWMF7CL	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a rotina de exclus�o da baixa					      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWMF7EL()

Local aArea 	:= GetArea()
Local cMsgAuto  := ""

Processa({||  cMsgAuto := CancBxLote(6) })

RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CancBxLote�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a rotina de cancelmaneto da baixa por lote	      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CancBxLote(nOpc)

Local aArea 	:= GetArea()
Local cMsgAuto  := ""
Local aPerg		:= {}
Local cQuery	:= ""
Local cArqTmp	:= ""
Local nCnt		:= 0     

Default nOpc := 5

If Aviso("Aten��o","Deseja efetuar o cancelamento da baixa por lote ?",{"Sim","N�o"}) == 1
	
	//Pergunta para preenchimento do lote
	If NCF07CLP(@aPerg, PZV->PZV_COD)
		
		cArqTmp := GetNextAlias()
		cQuery	:= " SELECT R_E_C_N_O_ RECPZV FROM "+RetSqlName("PZV")+" PZV "+CRLF
		cQuery	+= " WHERE PZV.PZV_FILIAL = '"+xFilial("PZV")+"' "+CRLF
		cQuery	+= " AND PZV.PZV_COD = '"+aPerg[1]+"' "+CRLF
		cQuery	+= " AND PZV.D_E_L_E_T_ = ' ' "+CRLF
		
		dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
		
		(cArqTmp)->( DbGoTop() )
		(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
		(cArqTmp)->( DbGoTop() )

		
		If nCnt > 0
		    ProcRegua(nCnt)
		
			DbSelectArea("PZV")
			DbSetOrder(1)
			While (cArqTmp)->(!Eof())
				
				PZV->(DbGoTo((cArqTmp)->RECPZV))
				
				IncProc("Processando o titulo: "+PZV->PZV_NUM)
				
				If Alltrim(PZV->PZV_TPMOV) == '1'
					//Chama a rotina para efetuar o cancelamento da baixa do titulo
					cMsgAuto := CancBxTCR(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO, nOpc)
				ElseIf Alltrim(PZV->PZV_TPMOV) == '2'//Exclui a taxa da operadora (Contas a Pagar)
				
					//Chama a rotina para efetuar o cancelamento da baixa do titulo
					cMsgAuto := ExcTitCP(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO)	
				
				ElseIf Alltrim(PZV->PZV_TPMOV) == '3'//Exclui o estorno da operadora (Contas a Receber) 
					cMsgAuto := ExcTitCR(PZV->PZV_PREFIX, PZV->PZV_NUM, PZV->PZV_PARCEL, PZV->PZV_TIPO)	
					
				
				EndIf
							
				//Atualiza a flag de estorno
				If Empty(cMsgAuto) .And. (Alltrim(PZV->PZV_TPMOV) $ '1|2|3')
					Reclock("PZV",.F.)
					PZV->(DbDelete())
					PZV->(MsUnLock())
				EndIf
				
				(cArqTmp)->(DbSkip())
			EndDo
		
			If Empty(cMsgAuto)
				Aviso("Final de processamento","Processamento finalizado.",{"Ok"},2)
			EndIf
	
		Else
			Aviso("Aten��o","Nenhum item encontrado com o lote: "+aPerg[1],{"Ok"},2)
		EndIf
		(cArqTmp)->(DbCloseArea())
	EndIf                 

EndIf

RestArea(aArea)
Return cMsgAuto



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCF07CLP �Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Pergunta para informar o numero do lote	      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCF07CLP(aParams, cCodSel)

Local aParamBox := {}
Local llRet      := .T.

Default cCodSel	:= ""

AADD(aParamBox,{1,"Lote", PADR(cCodSel, TAMSX3("PZV_COD")[1]) ,"@!"	,"","","",70,.F.})

llRet := ParamBox(aParamBox, "Par�metros", aParams, , /*alButtons*/, .F., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .F., .F.)

Return llRet





/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExcTitCR	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Exclui titulo do contas a receber						      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExcTitCR(cPrefixo, cNumTit, cParcela, cTipo)

Local aArea := GetArea()
Local aTitulo   := {}
Local cMsgAuto	:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""                                     

AADD(aTitulo,	{"E1_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E1_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E1_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E1_TIPO"	    	,cTipo      		,Nil } )

//Chama a rotina para cancelar a baixa do titulo 
cMsgAuto := RunTitCR(aTitulo, 5 )


If !Empty(cMsgAuto)
	Aviso("Aten��o","N�o foi poss�vel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgAuto, {"Ok"},3)			
Endif

RestArea(aArea)
Return cMsgAuto



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExcTitCR	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Exclui titulo do contas a receber						      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExcTitCP(cPrefixo, cNumTit, cParcela, cTipo)

Local aArea 		:= GetArea()
Local aTitulo   	:= {}
Local cMsgCancBx	:= ""
Local cMsgExcTit	:= ""
Local cRet			:= ""

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""                                     

//Exclui a concilia��o do movimento banc�rio.
DesconcMB(cPrefixo, cNumTit, cParcela, cTipo)


AADD(aTitulo,	{"E2_PREFIXO"		,cPrefixo 			,Nil } )
AADD(aTitulo,	{"E2_NUM"		 	,cNumTit    		,Nil } )
AADD(aTitulo,	{"E2_PARCELA"	 	,cParcela    		,Nil } )
AADD(aTitulo,	{"E2_TIPO"	    	,cTipo      		,Nil } )

DbSelectArea("SE2")
DbSetOrder(1)
If SE2->(MsSeek(xFilial("SE2") + cPrefixo + cNumTit + cParcela + cTipo ))
	If !Empty(SE2->E2_BAIXA) .And. SE2->E2_SALDO == 0
		
		//Executa a rotina para excluir a baixa do titulo
		cMsgCancBx := RunBxCP(aTitulo, 6 )
		If !Empty(cMsgCancBx)
			Aviso("Aten��o","N�o foi poss�vel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgCancBx, {"Ok"},3)
		Else
			//Executa a rotina para excluir o titulo
			cMsgExcTit := RunTitCP(aTitulo, 5)
			If !Empty(cMsgExcTit)
				Aviso("Aten��o","N�o foi poss�vel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgExcTit, {"Ok"},3)
			Endif
		EndIf
	Else
		//Executa a rotina para excluir o titulo
		cMsgExcTit := RunTitCP(aTitulo, 5)
		If !Empty(cMsgExcTit)
			Aviso("Aten��o","N�o foi poss�vel cancelar a baixo do titulo: "+cNumTit+CRLF+CRLF+cMsgExcTit, {"Ok"},3)
		Endif
		
	Endif
Else
	Aviso("Aten��o","N�o foi poss�vel cancelar a baixo do titulo "+cNumTit+".", {"Ok"},3)
EndiF

cRet := cMsgExcTit+cMsgCancBx

RestArea(aArea)
Return cRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWM7POT	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Consulta a posi��o do titulo							      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWM7POT()
Local aArea := GetArea()

Private cCadastro := ""                      

If Alltrim(PZV->PZV_TPMOV) == "2"//Contas a pagar
	
	DbSelectArea("SE2")
	DbSetOrder(1)

	If SE2->(MsSeek(xFilial("SE2") + PADR(PZV->PZV_PREFIX, TAMSX3("E2_PREFIXO")[1]) + PADR(PZV->PZV_NUM, TAMSX3("E2_NUM")[1]) ;
				+ PADR(PZV->PZV_PARCEL,TAMSX3("E2_PARCELA")[1]) + PADR(PZV->PZV_TIPO,TAMSX3("E2_TIPO")[1]) ))
        
		cCadastro := "Contas a Pagar" 
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| Fc050Con() })//Visualiza��o do titulo Contas a pagar
	Else 
		Aviso("N�o encontrado", "Titulo n�o encontrado. Prefixo: "+PZV->PZV_PREFIX+" Titulo: "+PZV->PZV_NUM+" Parcela: "+PZV->PZV_PZRCEL+" Tipo: "+PZV->PZV_TIPO, {"Ok"},2)
    EndIf

Else//Contas a Receber

	DbSelectArea("SE1")
	DbSetOrder(1)

	If SE1->(MsSeek(xFilial("SE1") + PADR(PZV->PZV_PREFIX, TAMSX3("E1_PREFIXO")[1]) + PADR(PZV->PZV_NUM, TAMSX3("E1_NUM")[1]) ;
				+ PADR(PZV->PZV_PARCEL,TAMSX3("E1_PARCELA")[1]) + PADR(PZV->PZV_TIPO,TAMSX3("E1_TIPO")[1]) ))
				
			
		cCadastro := "Contas a Receber"
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| Fc040Con()	})//Visualiza��o do titulo Contas a receber
	Else 
		Aviso("N�o encontrado", "Titulo n�o encontrado. Prefixo: "+PZV->PZV_PREFIX+" Titulo: "+PZV->PZV_NUM+" Parcela: "+PZV->PZV_PZRCEL+" Tipo: "+PZV->PZV_TIPO, {"Ok"},2)
    EndIf
EndIf


RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCWM7VTI	�Autor  �Microsiga           � Data �  07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Visualiza��o do t�tulo								      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCWM7VTI()
Local aArea := GetArea()
                     
Private cCadastro := ""                      

DbSelectArea("SE1")
DbSetOrder(1)


If Alltrim(PZV->PZV_TPMOV) == "2"//Contas a pagar

	DbSelectArea("SE2")
	DbSetOrder(1)

	If SE2->(MsSeek(xFilial("SE2") + PADR(PZV->PZV_PREFIX, TAMSX3("E2_PREFIXO")[1]) + PADR(PZV->PZV_NUM, TAMSX3("E2_NUM")[1]) ;
				+ PADR(PZV->PZV_PARCEL,TAMSX3("E2_PARCELA")[1]) + PADR(PZV->PZV_TIPO,TAMSX3("E2_TIPO")[1]) ))
		
		cCadastro := "Contas a Pagar" 
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| AxVisual("SE2",SE2->(Recno()),2) })//Visualiza��o do titulo Contas a pagar
	Else 
		Aviso("N�o encontrado", "Titulo n�o encontrado. Prefixo: "+PZV->PZV_PREFIX+" Titulo: "+PZV->PZV_NUM+" Parcela: "+PZV->PZV_PZRCEL+" Tipo: "+PZV->PZV_TIPO, {"Ok"},2)
    EndIf

Else//Contas a Receber

	DbSelectArea("SE1")
	DbSetOrder(1)

	If SE1->(MsSeek(xFilial("SE1") + PADR(PZV->PZV_PREFIX, TAMSX3("E1_PREFIXO")[1]) + PADR(PZV->PZV_NUM, TAMSX3("E1_NUM")[1]) ;
				+ PADR(PZV->PZV_PARCEL,TAMSX3("E1_PARCELA")[1]) + PADR(PZV->PZV_TIPO,TAMSX3("E1_TIPO")[1]) ))
				
				
		cCadastro := "Contas a Receber"
		LJMsgRun("Aguarde o processamento...","Aguarde...", {|| FA280Visua("SE1",SE1->(Recno()),2)	})//Visualiza��o do titulo Contas a receber
	Else 
		Aviso("N�o encontrado", "Titulo n�o encontrado. Prefixo: "+PZV->PZV_PREFIX+" Titulo: "+PZV->PZV_NUM+" Parcela: "+PZV->PZV_PZRCEL+" Tipo: "+PZV->PZV_TIPO, {"Ok"},2)
    EndIf
EndIf


RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvBxMbLg	 �Autor  �Microsiga 	      � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava os dados da baixa e movimenta��o bancaria			  ���
���          �na tabela de controel PZV						    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIW7NCF(cTpMov, cCod, cLoja)
Local aArea := GetArea()
Local cRet	:= ""
                       
Default cTpMov	:= "" 
Default cCod	:= "" 
Default cLoja	:= ""
                 
If Alltrim(cTpMov) != "2"
	cRet	:= Posicione("SA1",1,xFilial("SA1")+ cCod + cLoja,"A1_NOME")
Else
	cRet	:= Posicione("SA2",1,xFilial("SA2")+ cCod + cLoja,"A2_NOME")
EndIf    

RestArea(aArea)
Return cRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReconcMB	 �Autor  �Microsiga 	      � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Concilia��o do movimento banc�rio							  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReconcMB(cPrefixo, cTitulo, cParcela, cTipo)

Local aArea := GetArea()

Default cPrefixo	:= "" 
Default cTitulo		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

DbSelectArea("SE5")
DbSetOrder(7)
If SE5->(MsSeek(xFilial("SE5") + Padr(cPrefixo, TAMSX3("E5_PREFIXO")[1] );
								+ Padr(cTitulo, TAMSX3("E5_NUMERO")[1])  ;
								+ Padr(cParcela, TAMSX3("E5_PARCELA")[1]) ; 
								+ Padr(cTipo, TAMSX3("E5_TIPO")[1]) ))
    
	//Grava flag de concilia��o
	Reclock("SE5",.F.)
	SE5->E5_RECONC	:= "x"
	SE5->E5_DTDISPO := dDataBase
	SE5->(MsUnLock())
		
	//Atualiza saldo bancario
	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,IIF(SE5->E5_RECPAG == "P","-","+"),.T.,.F.)

EndIf

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DesconcMB	 �Autor  �Microsiga 	      � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Concilia��o do movimento banc�rio							  ���
���          �												    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function DesconcMB(cPrefixo, cTitulo, cParcela, cTipo)

Local aArea := GetArea()

Default cPrefixo	:= "" 
Default cTitulo		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

DbSelectArea("SE5")
DbSetOrder(7)
If SE5->(MsSeek(xFilial("SE5") + Padr(cPrefixo, TAMSX3("E5_PREFIXO")[1] );
								+ Padr(cTitulo, TAMSX3("E5_NUMERO")[1])  ;
								+ Padr(cParcela, TAMSX3("E5_PARCELA")[1]) ; 
								+ Padr(cTipo, TAMSX3("E5_TIPO")[1]) ))
    
	//Grava flag de concilia��o
	Reclock("SE5",.F.)
	SE5->E5_RECONC	:= " "
	SE5->E5_DTDISPO := CTOD('')
	SE5->(MsUnLock())
		
	//Atualiza saldo bancario
	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,IIF(SE5->E5_RECPAG == "P","+","-"),.T.,.F.)

EndIf

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuVlTotRA �Autor  �Microsiga           � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o valor total de RA									���
���          �		    		  												���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuVlTotRA(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, oTotRA, nTotRA, cOpcConc) 

Local aArea 	:= GetArea()
Local cQuery  := ""
Local cArqTmp	:= ""
Local nCnt		:= 0
Local lAddAux	:= .F.
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))


Default cFilAuxDe		:= "" 
Default cFilAuxAte	:= "" 
Default cGrpTpFin		:= "" 
Default dDtIni		:= CTOD('') 
Default dDtFin		:= CTOD('') 
Default oTotRA		:= Nil 
Default nTotRA		:= 0 
Default cOpcConc		:= ""

cArqTmp	:= GetNextAlias()

cQuery	:= " SELECT E1_YCODWM, SUM(E1_VALOR) E1_VALOR FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery	+= "  INNER JOIN "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
cQuery	+= "  ON PZP.PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"' "+CRLF
cQuery	+= "  AND PZP.PZP_CODMOV = SE1.E1_YCODWM "+CRLF
cQuery	+= "  AND PZP.PZP_PREFIX = SE1.E1_PREFIXO "+CRLF
cQuery	+= "  AND PZP.PZP_NUM = SE1.E1_NUM "+CRLF
cQuery	+= "  AND PZP.PZP_PARCEL = SE1.E1_PARCELA "+CRLF
cQuery	+= "  AND PZP.PZP_TIPO = SE1.E1_TIPO "+CRLF
cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  INNER JOIN "+RetSqlName("PZT")+" PZT "+CRLF
cQuery	+= "  ON PZT.PZT_FILIAL = '"+xFilial("PZT")+"' "+CRLF
cQuery	+= "  AND PZT.PZT_COD = '"+cGrpTpFin+"' "+CRLF
cQuery	+= "  AND PZT.PZT_CODFIN = PZP.PZP_CODFIN "+CRLF
cQuery	+= "  AND PZT.D_E_L_E_T_ = ' ' "+CRLF
        
cQuery	+= "  WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery	+= "  AND SE1.E1_TIPO = 'RA' "+CRLF
cQuery	+= "  AND SE1.E1_EMISSAO BETWEEN '"+Dtos(dDtIni)+"' AND '"+Dtos(dDtFin)+"'  "+CRLF
cQuery	+= "  AND SE1.E1_FILORIG BETWEEN '"+cFilAuxDe+"' AND '"+cFilAuxAte+"' "+CRLF
cQuery	+= "  AND SE1.E1_SALDO > '0' "+CRLF
cQuery	+= "  AND SE1.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= "  GROUP BY E1_YCODWM "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
	
(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( {|| nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )
	
ProcRegua(nCnt)

nTotRa 	:= 0
While (cArqTmp)->(!Eof())
		
	IncProc("Calculando valor de RA...")
		
	lAddAux := .F.
		
	If Alltrim(cOpcConc) $ "1|2"//1=Conciliados | 2=Nao Conciliados
		If VldConc((cArqTmp)->E1_YCODWM, cOpcConc)
			lAddAux := .T.
		EndIf
	Else
		lAddAux := .T.
	EndIf
		
	If lAddAux
		nTotRA += (cArqTmp)->E1_VALOR
	EndIf
		
	(cArqTmp)->(DbSkip())
EndDo

//Atualiza o objeto
oTotRA:Refresh()

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return 


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuVlTotBx �Autor  �Microsiga           � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza o valor total de RA									���
���          �		    		  												���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuVlTotBx(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, oTotBx, nTotBx, cOpcConc) 

Local aArea 	:= GetArea()
Local cQuery  := ""
Local cArqTmp	:= ""
Local nCnt		:= 0
Local lAddAux	:= .F.
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))


Default cFilAuxDe		:= "" 
Default cFilAuxAte	:= "" 
Default cGrpTpFin		:= "" 
Default dDtIni		:= CTOD('') 
Default dDtFin		:= CTOD('') 
Default oTotBx		:= Nil 
Default nTotBx		:= 0 
Default cOpcConc		:= ""

cArqTmp	:= GetNextAlias()

cQuery	:= " SELECT E1_YCODWM, SUM(E1_VALOR) E1_VALOR FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery	+= "  INNER JOIN "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
cQuery	+= "  ON PZP.PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"' "+CRLF
cQuery	+= "  AND PZP.PZP_CODMOV = SE1.E1_YCODWM "+CRLF
cQuery	+= "  AND PZP.PZP_PREFIX = SE1.E1_PREFIXO "+CRLF
cQuery	+= "  AND PZP.PZP_NUM = SE1.E1_NUM "+CRLF
cQuery	+= "  AND PZP.PZP_PARCEL = SE1.E1_PARCELA "+CRLF
cQuery	+= "  AND PZP.PZP_TIPO = SE1.E1_TIPO "+CRLF
cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  INNER JOIN "+RetSqlName("PZT")+" PZT "+CRLF
cQuery	+= "  ON PZT.PZT_FILIAL = '"+xFilial("PZT")+"' "+CRLF
cQuery	+= "  AND PZT.PZT_COD = '"+cGrpTpFin+"' "+CRLF
cQuery	+= "  AND PZT.PZT_CODFIN = PZP.PZP_CODFIN "+CRLF
cQuery	+= "  AND PZT.D_E_L_E_T_ = ' ' "+CRLF
        
cQuery	+= "  WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery	+= "  AND SE1.E1_EMISSAO BETWEEN '"+Dtos(dDtIni)+"' AND '"+Dtos(dDtFin)+"'  "+CRLF
cQuery	+= "  AND SE1.E1_FILORIG BETWEEN '"+cFilAuxDe+"' AND '"+cFilAuxAte+"' "+CRLF
cQuery	+= "  AND SE1.E1_SALDO = '0' "+CRLF
cQuery	+= "  AND SE1.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= "  GROUP BY E1_YCODWM "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
	
(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( {|| nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )
	
ProcRegua(nCnt)

nTotBx 	:= 0
While (cArqTmp)->(!Eof())
		
	IncProc("Calculando valor baixado...")
		
	lAddAux := .F.
		
	If Alltrim(cOpcConc) $ "1|2"//1=Conciliados | 2=Nao Conciliados
		If VldConc((cArqTmp)->E1_YCODWM, cOpcConc)
			lAddAux := .T.
		EndIf
	Else
		lAddAux := .T.
	EndIf
		
	If lAddAux
		nTotBx += (cArqTmp)->E1_VALOR
	EndIf
		
	(cArqTmp)->(DbSkip())
EndDo

//Atualiza o objeto
oTotBx:Refresh()

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return 

