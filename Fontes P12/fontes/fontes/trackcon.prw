#INCLUDE "RWMAKE.CH"
#INCLUDE "TopConn.ch"
#INCLUDE "vKey.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³PICKSEL   ³ Autor ³ERICH BUTTNER          ³ Data ³ 21.09.12   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ TELA DE TRACKING DOS PEDIDOS 				                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ 		                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TRACKCON()

Local aCpoBrw
Local aCpoTmp
Local cArq
Private CPERG := "TTRACK"
Private lInverte := .T.
Private cmarca   := GetMark()
Private oMark
Private cPesq     := Space(50)
Private lCheck1   := .t.
Private lCheck2   := .t.
Private lCheck3   := .t.
Private cCombo, cOrdem	:= " "
Private aOrdem	:= {"PEDIDO","VENDEDOR","CLIENTE","CANAL"}
Private cPESQUISA:= SPACE(200), oPesquisa
Private _aMarcados:={}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Query ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery := " SELECT ZQ_NUMPED PED, ZQ_CLIENT CLIENTE, ZQ_LOJA LOJA, ZQ_NMCLI NOME, ZQ_VEND CODVEN, ZQ_NMVEND NOMVEN, "
cQuery += " ZQ_EMIPED EMISSAO, ZQ_CANAL CANAL, ZQ_DCANAL DESCCANAL "
cQuery += " FROM SZQ010 "
cQuery += " WHERE ZQ_FILIAL = '03' "
cQuery += " AND ZQ_EMIPED >= '"+DTOS(dDataBase-90)+"' "
cQuery += " AND ZQ_EMIPED <= '"+DTOS(dDataBase)+ "' "
cQuery += " AND D_E_L_E_T_ = ' ' "

cQuery := ChangeQuery(cQuery)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha Alias se estiver em Uso ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("TRB") >0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

If Select("TMP") >0
	dbSelectArea("TMP")
	dbCloseArea()
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Area de Trabalho executando a Query ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TCQUERY cQuery New Alias "TRB"
dbSelectArea("TRB")

dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta arquivo temporario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCpoTmp:={}
aAdd(aCpoTmp,{"NumPed"      	,"C",06,0})
aAdd(aCpoTmp,{"Cliente"   		,"C",06,0})
aAdd(aCpoTmp,{"Loja"    		,"C",02,0})
aAdd(aCpoTmp,{"Nome"     		,"C",30,2})
aAdd(aCpoTmp,{"Vendedor"  		,"C",06,0})
aAdd(aCpoTmp,{"NmVend"		  	,"C",30,0})
aAdd(aCpoTmp,{"DtEmissao"	  	,"D",08,0})
aAdd(aCpoTmp,{"Canal"			,"C",06,0})
aAdd(aCpoTmp,{"DescCanal"		,"C",30,0})

cArq:=Criatrab(aCpoTmp,.T.)
dbUseArea(.t.,,cArq,"TMP")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alimenta arquivo temporario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TMP")

While !TRB->(EOF())
	DbSelectArea("TMP")
	RecLock("TMP",.t.)
	TMP->NumPed		:= TRB->PED
	TMP->Cliente	:= TRB->CLIENTE
	TMP->Loja		:= TRB->LOJA
	TMP->Nome		:= TRB->NOME
	TMP->Vendedor	:= TRB->CODVEN
	TMP->NmVend		:= TRB->NOMVEN
	TMP->DtEmissao	:= STOD(TRB->EMISSAO)
	TMP->Canal		:= TRB->CANAL
	TMP->DescCanal	:= TRB->DESCCANAL
	
	TMP->(MsUnlock())
	
	DbSelectArea("TRB")
	TRB->(dbSkip())
	
End

_cArq1   := CriaTrab(NIL,.F.)
_cChave1 := "TMP->NUMPED"
IndRegua("TMP",_cArq1,_cChave1,,,"Selecionando Regs...")

_cArq2   := CriaTrab(NIL,.F.)
_cChave2 := "TMP->VENDEDOR"
IndRegua("TMP",_cArq2,_cChave2,,,"Selecionando Regs...")

_cArq3   := CriaTrab(NIL,.F.)
_cChave3 := "TMP->CLIENTE"
IndRegua("TMP",_cArq3,_cChave3,,,"Selecionando Regs...")

_cArq4   := CriaTrab(NIL,.F.)
_cChave4 := "TMP->CANAL"
IndRegua("TMP",_cArq4,_cChave4,,,"Selecionando Regs...")

dbClearIndex()
dbSetIndex(_cArq1+OrdBagExt())
dbSetIndex(_cArq2+OrdBagExt())
dbSetIndex(_cArq3+OrdBagExt())
dbSetIndex(_cArq4+OrdBagExt())

TRB->(dbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com definicoes dos campos do browse ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCpoBrw:={}
aAdd(aCpoBrw,{"NumPed"    	,""	,"Num Ped"         	,"@!"   ,"06","0"})
aAdd(aCpoBrw,{"Cliente"    	,""	,"Cliente"         	,"@!"   ,"06","0"})
aAdd(aCpoBrw,{"Loja"    	,""	,"Loja"         	,"@!"   ,"02","0"})
aAdd(aCpoBrw,{"Nome"    	,""	,"Nome"         	,"@!"   ,"30","0"})
aAdd(aCpoBrw,{"Vendedor"  	,""	,"Vendedor"       	,"@!"   ,"06","0"})
aAdd(aCpoBrw,{"NmVend"    	,""	,"Nome Vendedor"   	,"@!"	,"30","0"})
aAdd(aCpoBrw,{"DtEmissao"	,""	,"Dt. Emissao"     	,		,"08","0"})
aAdd(aCpoBrw,{"Canal"    	,""	,"Canal"         	,"@!"	,"06","0"})
aAdd(aCpoBrw,{"DescCanal" 	,""	,"Descr. Canal"    	,"@!"	,"30","0"})

@ 000,000 TO 650,935 DIALOG oDlgLib TITLE " TRACKING DE PEDIDOS " //850,1135

oMark:=MsSelect():New("TMP","OK","",aCpoBRW,@lInverte,@cMarca,{035,005,280,465},,,,,)//{015,005,400,630,565}
oMark:oBrowse:lHasMark := .T.
oMark:oBrowse:lCanAllMark:=.T.

@ 003,006 To 034,315 Title OemToAnsi("Pedido")
@ 016,007 Say "Ordem: "
@ 016,025 ComboBox cOrdem ITEMS aOrdem SIZE 60,50 Object oOrdem
@ 016,085 Get    cPESQUISA			   Size 200,10 Object oPesquisa
oOrdem:bChange := {|| FORDENA(CORDEM),oMark:oBrowse:Refresh(.T.)}

@ 016,350 Button "Pesquisar"       		Size 50,13 Action Procura(CORDEM)
@ 300,260 Button "Visualizar Itens" 	Size 50,13 Action VERPVTC(TMP->NUMPED) 				 	Object oBtnRet
@ 300,310 Button "Visualizar Detalhes"	Size 50,13 Action VERTRCK(TMP->NUMPED)	  				Object oBtnRet
@ 300,360 Button "Rel. Track"      		Size 50,13 Action U_TRACK_PICK() 	   					Object oBtnREL
@ 300,410 Button "Sair"            		Size 50,13 Action IIF(PREPSAIR(),Close(oDlgLIb),"")	Object oBtnInv

dbSelectArea("TMP")
dbGoTop()

oMark:oBrowse:Refresh()

ACTIVATE DIALOG oDlgLib CENTERED

TMP->(dbCloseArea())

FERASE(cArq+OrdBagext())
FERASE(cArq)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VERPVTC	ºAutor  ³ ERICH BUTTNER		 º Data ³  21/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ FUNCAO QUE VISUALIZA OS ITENS DO PEDIDO DE VENDA			  º±±
±±º          ³ 									                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function VERPVTC(CPED)
Local aArea		:= GetArea()									// Salva a area atual
Local cCodLig	:= ""											// Codigo do atendimento
Local oDlgHist													// Tela do Historico
Local oObsMemo                                      			// Observacao do MEMO
Local oMonoAs  	:= TFont():New( "Courier New",6,0) 			// Fonte para o campo Memo
Local oGetHist													// Itens de cada atendimento
Local oBmp 		:= LoadBitmap( GetResources(), "BRANCO" )   	// Objeto BMP para exibir a cor da legenda
Local nOpcA		:= 0                                            // Opcao de OK ou CANCELA
Local lRet 		:= .T.                                          // Retorno da funcao
Private cObsMemo 	:= ""										// String com a descricao do MEMO

CursorWait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona todas a liga‡oes desse cliente indexando por ordem de liga‡ao decrescente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aLigacoes := {}
aCC       := {}
LCOORD := .F.

DbSelectArea("SC6")
DBSETORDER(1)
DBSEEK(XFILIAL("SC6")+CPED,.T.)

While !Eof() .AND. SC6->C6_NUM == CPED
	DbSelectArea("SC9")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SC9")+SC6->C6_NUM+SC6->C6_ITEM,.T.)
		cBlest := SC9->C9_BLEST
	ELSE
		cBlest := "NÃO LIBERADO"
	ENDIF
	
	AAdd(aCC, { IF(EMPTY(cBlest),"",IF(ALLTRIM(cBlest) == "NÃO LIBERADO",ALLTRIM(cBlest),IF(ALLTRIM(cBlest) == "10","FATURADO","X"))) , ;
	SC6->C6_ITEM , ;
	SC6->C6_PRODUTO , ;
	LEFT(GETADVFVAL("SB1","B1_XDESC",XFILIAL("SB1")+SC6->C6_PRODUTO,1,""),30) ,   ;
	GETADVFVAL("SC6","C6_QTDVEN",XFILIAL("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM,1,"") , ;
	SC9->C9_QTDLIB  , ;
	SC9->C9_DATALIB , ;
	GETADVFVAL("SC6","C6_TES",XFILIAL("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM,1,"") , ;
	GETADVFVAL("SC6","C6_CF", XFILIAL("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM,1,"") , ;
	SC9->C9_LOCAL })
	SC6->(DbSkip())
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VERTRCK	ºAutor  ³ ERICH BUTTNER		 º Data ³  21/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ FUNCAO QUE VISUALIZA OS DETALHES DO PEDIDO DE VENDA		  º±±
±±º          ³ 									                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function VERTRCK(CPED)
Local aArea		:= GetArea()									// Salva a area atual
Local cCodLig	:= ""											// Codigo do atendimento
Local oDlgHist													// Tela do Historico
Local oObsMemo                                      			// Observacao do MEMO
Local oMonoAs  	:= TFont():New( "Courier New",6,0) 				// Fonte para o campo Memo
Local oGetHist													// Itens de cada atendimento
Local oBmp 		:= LoadBitmap( GetResources(), "BRANCO" )   	// Objeto BMP para exibir a cor da legenda
Local nOpcA		:= 0                                            // Opcao de OK ou CANCELA
Local lRet 		:= .T.                                          // Retorno da funcao
Local NVLRTOT   := 0
Local nLin		:= 1
Local NSEQ		:= 1
Local CBLQCRED  := ""
Local CCANAL	:= ""
Local CSTATUS	:= ""
Local CINFOBS	:= ""
Private cObsMemo 	:= ""											// String com a descricao do MEMO

CursorWait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona todas a liga‡oes desse cliente indexando por ordem de liga‡ao decrescente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aLigacoes := {}
aCC       := {}
LCOORD := .F.

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT ZQ_FILIAL FILIAL, ZQ_NUMPED NUMPED, ZQ_EMIPED EMISPED, ZQ_DTLBPD DTLIB, ZQ_DTLBCD DTLIBCRED, ZQ_DTISEP DTSEP,
cQuery+= " ZQ_DTICOF DTCONF, ZQ_DTEMNF DTEMISNF, ZQ_DTSAID DTSAIDA, ZQ_DTENTR DTENTREGA, ZQ_TRANSP TRANSPORT, ZQ_NMTRAN NMTRANSP,
cQuery+= " ZQ_VEND VENDEDOR, ZQ_NMVEND NOMEVEND, ZQ_CLIENT CLIENT,	ZQ_LOJA LOJACLI, ZQ_NMCLI NOMECLIENT, ZQ_DTPREV DTPREVISAO,
cQuery+= " ZQ_CLIAGE AGENCLI, ZQ_AGEND DTAGEND, ZQ_NUMNF NUMNF, ZQ_SERIE SERIENF, ZQ_VLRTOT VLRTOT, ZQ_CANAL CANAL, ZQ_DCANAL DESCRCANAL,
cQuery+= " ZQ_BLCRED BLQCRED, ZQ_TPOPER TPOPER,  ZQ_HRSEP HRSEP, ZQ_HRFAT HRFAT, ZQ_HRCONF HRCONF,"
cQuery+= " ZQ_HRLBCRD HRCRED, ZQ_YDLIMIT DTFIN "
cQuery+= " FROM SZQ010
cQuery+= " WHERE ZQ_NUMPED = '"+ALLTRIM(CPED)+"' "
cQuery+= " AND ZQ_FILIAL = '"+XFILIAL("SC5")+"' AND D_E_L_E_T_ = ' ' "




If Select("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea("TRB1")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)

dbSelectArea("TRB1")
TRB1->(dbGoTop())
cEstWMS	:= ""

WHILE TRB1->(!EOF())
	
	CNUMPED		:= TRB1->NUMPED
	DDTPED		:= SUBSTR(TRB1->EMISPED,7,2)+"/"+SUBSTR(TRB1->EMISPED,5,2)+"/"+SUBSTR(TRB1->EMISPED,3,2)
	DDTLIB		:= SUBSTR(TRB1->DTLIB,7,2)+"/"+SUBSTR(TRB1->DTLIB,5,2)+"/"+SUBSTR(TRB1->DTLIB,3,2)
	DDTLIBCRED	:= SUBSTR(TRB1->DTLIBCRED,7,2)+"/"+SUBSTR(TRB1->DTLIBCRED,5,2)+"/"+SUBSTR(TRB1->DTLIBCRED,3,2)+" - "+TRB1->HRCRED
    DDTFIN		:= SUBSTR(TRB1->DTFIN,7,2)+"/"+SUBSTR(TRB1->DTFIN,5,2)+"/"+SUBSTR(TRB1->DTFIN,3,2)
    
    CINFOBS := POSICIONE("SZQ",1,XFILIAL("SZQ")+CNUMPED,"ZQ_YFINOBS")
    nlinvsint := mlcount(CINFOBS)
	clinvsint := ""
	For nx := 1 to nlinvsint
		clinvsint += if(right(MemoLine(CINFOBS,,nx ),1) == " ",alltrim(MemoLine(CINFOBS,,nx ))+" ",alltrim(MemoLine(CINFOBS,,nx )))
	Next nx
	
	DDTEMISNF	:= SUBSTR(TRB1->DTEMISNF,7,2)+"/"+SUBSTR(TRB1->DTEMISNF,5,2)+"/"+SUBSTR(TRB1->DTEMISNF,3,2)+" - "+TRB1->HRFAT
	DDTSAIDA	:= SUBSTR(TRB1->DTSAIDA,7,2)+"/"+SUBSTR(TRB1->DTSAIDA,5,2)+"/"+SUBSTR(TRB1->DTSAIDA,3,2)
	DDTENTR		:= SUBSTR(TRB1->DTENTREGA,7,2)+"/"+SUBSTR(TRB1->DTENTREGA,5,2)+"/"+SUBSTR(TRB1->DTENTREGA,3,2)
	CTRANSP		:= SUBSTR(ALLTRIM(TRB1->NMTRANSP),1,30)
	DDTPREVENTR	:= SUBSTR(TRB1->DTPREVISAO,7,2)+"/"+SUBSTR(TRB1->DTPREVISAO,5,2)+"/"+SUBSTR(TRB1->DTPREVISAO,3,2)
	AGEND		:= IIF(ALLTRIM(TRB1->AGENCLI) == "S", "SIM", "NAO")
	DDTAGEN		:= TRB1->DTAGEND
	CCLIENTE	:= SUBSTR(TRB1->NOMECLIENT,1,15)
	CNUMNF		:= TRB1->NUMNF+"/"+TRB1->SERIENF
	NVLRTOT  	:= TRB1->VLRTOT
	CBLQCRED 	:= TRB1->BLQCRED
	CCANAL		:= CANAL+" - "+DESCRCANAL
	CTPOPER		:= TRB1->TPOPER
	
	
	IF EMPTY(TRB1->DTSEP) .AND. EMPTY(TRB1->DTCONF) .AND. CTPOPER <> '01' .AND. CTPOPER <> '02'
		CSTATUS := "PEDIDO SEGUE OUTRO PROCESSO DE SEPARAÇÃO "
	ENDIF
	
	IF 	DDTLIB == "  /  /  "
		CSTATUS+= "/ PEDIDO NÃO LIBERADO"
	ELSEIF CBLQCRED == '09'
		CSTATUS+= "/ PEDIDO REJEITADO POR CREDITO"
	ELSEIF CBLQCRED == '01' .OR. CBLQCRED == '04'
		CSTATUS+= "/ PEDIDO EM ANALISE DE CREDITO"
    ELSEIF CBLQCRED == '  '
		CSTATUS+= "/ PEDIDO APROVADO POR CREDITO"
	ELSEIF TRB1->DTSEP == "  /  /  "
		CSTATUS += "/ PEDIDO EM SEPARAÇÃO"
	ELSEIF TRB1->DTCONF == "  /  /  "
		CSTATUS += "/ PEDIDO EM CONFERENCIA"
    ELSEIF DDTEMISNF == "  /  /  "
		CSTATUS+= "/ AGUARDANDO EMISSÃO DE NOTA FISCAL"
	ELSEIF DDTEMISNF <> "  /  /  " .AND. DDTSAIDA == "  /  /  " .AND. DDTENTR == "  /  /  "
		CSTATUS+= "/ NOTA FISCAL EMITIDA"
	ELSEIF DDTSAIDA <> "  /  /  " .AND. DDTENTR == "  /  /  "
		CSTATUS+= "/ PEDIDO EXPEDIDO"	
	ELSEIF DDTENTR <> "  /  /  "
		CSTATUS+= "/ PEDIDO ENTREGUE"	
	ENDIF
			
	AAdd(aCC, {"Status: ",CSTATUS})
	AAdd(aCC, {"Pedido: ",CNUMPED})
	AAdd(aCC, {"Cliente/Loja: ",TRB1->CLIENT+"/"+TRB1->LOJACLI})
	AAdd(aCC, {"Razão Social: ",CCLIENTE})
	AAdd(aCC, {"Vendedor: ",TRB1->VENDEDOR+" - "+NOMEVEND})
	AAdd(aCC, {"Canal: ",ALLTRIM(CCANAL)})
	AAdd(aCC, {"Data Emissão: ",DDTPED})
	AAdd(aCC, {"Data Liberação Comercial: ",DDTLIB})
	AAdd(aCC, {"Bloqueio Credito: ",IIF(EMPTY(CBLQCRED),"NÃO",IF(CBLQCRED <> "10","SIM"," " ))})
	AAdd(aCC, {"Motivo Bloqueio : ",clinvsint})	
	AAdd(aCC, {"Data Limite Resposta Financeiro: ",DDTFIN})	
	AAdd(aCC, {"Data Liberação Credito: ",DDTLIBCRED})
	AAdd(aCC, {"Data Separação: ",TRB1->DTSEP+" - "+TRB1->HRSEP})
	AAdd(aCC, {"Data Conferencia: ",TRB1->DTCONF+" - "+TRB1->HRCONF})
	AAdd(aCC, {"Data Previsão Entrega: ",DDTPREVENTR})
	AAdd(aCC, {"Tem Agendamento? ",IIF(AGEND == "S", "SIM", "NAO")})
	AAdd(aCC, {"Data Agendamento: ",DDTAGEN})
	AAdd(aCC, {"Data Emissão Nota Fiscal: ",DDTEMISNF})
	AAdd(aCC, {"Data Saida: ",DDTSAIDA})
	AAdd(aCC, {"Data Entrega: ",DDTENTR})
	AAdd(aCC, {"Transportadora: ",CTRANSP})
	AAdd(aCC, {"Nota Fiscal: ",CNUMNF})
	AAdd(aCC, {"Valor Total: ",STR(NVLRTOT)})
	
	TRB1->(DBSKIP())
	NVLRTOT := 0
ENDDO

aLigacoes := aCC


DEFINE MSDIALOG oDlgHist FROM 50,001 TO 500,1000 TITLE "Itens do Tracking de Pedido de Venda " + CPED  PIXEL

@08,05 LISTBOX oLbx FIELDS HEADER "                   ","Dados" SIZE 470,200 OF oDlgHist PIXEL //365


oLbx:SetArray(aLigacoes)
oLbx:bLine:={||{	aLigacoes[oLbx:nAt,1],;
aLigacoes[oLbx:nAt,2]}}

oLbx:Refresh()
oLbx:SetFocus(.T.)

DEFINE SBUTTON FROM 210,340 TYPE 02 ENABLE OF oDlgHist PIXEL ACTION (oDlgHist:End())

ACTIVATE MSDIALOG oDlgHist CENTER ON INIT CursorArrow()

RestArea(aArea)



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PREPSAIR  ºAutor  ³ ERICH BUTTNER		 º Data ³  21/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que Prepara o Mark Browser para Sair      		  º±±
±±º          ³ 									                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ PROCURA 	ºAutor  ³ERICH BUTTNER		 º Data ³  21/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Pesquisa Informações no Browse de acordo com a 			  º±±
±±º			 ³	Ordem selecionada 										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 				                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ fOrdena  ºAutor  ³ ERICH BUTTNER		 º Data ³  21/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao executada na saida do campo Ordem, para ordenar o   º±±
±±º          ³ browse 								                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 		                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
		AADD(_aMarcados,{TMP->NUMPED})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'VENDEDOR'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->VENDEDOR})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'CLIENTE'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->CLIENTE})
		TMP->(DbSkip())
	End
ELSEIF CORDEM == 'CANAL'
	While TMP->(!EOF())
		AADD(_aMarcados,{TMP->CANAL})
		TMP->(DbSkip())
	End
ENDIF


DbSelectArea("TMP")
DbSetOrder(Ascan(aOrdem,cOrdem))
DbGoTo(_nReg)     //Mantendo no mesmo registro que estava posicionado anteriormente
oMark:oBrowse:Refresh(.T.)

Return
