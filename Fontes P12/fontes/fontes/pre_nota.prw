#INCLUDE "topconn.ch"
#include "protheus.ch"     
#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/06/02
#IFNDEF WINDOWS
#DEFINE PSAY SAY
#ENDIF

User Function rfatr05d()        // incluido pelo assistente de conversao do AP5 IDE em 25/06/02



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³                                
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("WNREL,TAMANHO,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("NREGISTRO,CKEY,NINDEX,CINDEX,CCONDICAO,LEND,xCF,XSOMA_CFO,XNATUREZA,XTES")
SetPrvt("CPERG,ARETURN,NOMEPROG,NLASTKEY,NBEGIN,ALINHA")
SetPrvt("LI,LIMITE,LIMITE1,LIMITE2,LRODAPE,CPICTQTD,NTOTQTD,NTOTVAL,BASEIPI,TOTIPI,BASEICM,TOTICM")
SetPrvt("NTOTMR,NTOTLB,NTOTPES,APEDCLI,CSTRING,CPEDIDO,_COBSERV,BASEICMST,TOTICMST")
SetPrvt("CHEADER,NPED,CMOEDA,CCAMPO,CCOMIS,I,USUARIO")
SetPrvt("NIPI,NVIPI,NBASEIPI,NVALBASE,LIPIBRUTO,_CTESTO")
SetPrvt("NPERRET,CESTADO,TNORTE,CESTCLI,CINSCRCLI,CCOMPAC,ADRIVER")
SetPrvt("NTOTREB,_nMOEDA2,_nMOEDA3,xEMISSAO,NTQREAL,NTQDOL,NTQPTX,TOTFAT,TOTMERC")
SetPrvt("NTVREAL,NTVDOLAR,NTVPTX,NTVDREAL,NTVPREAL,NTVGERAL,xPDESCAL,xCONTPAG,xSerie")
SetPrvt("xRNOME,xRENDER,xRBAIRRO,xRMUNIC,xRESTADO,xRCGC,xRINSCR,xRTELEF,xRCONTATO,xRBLOCK,xCBLOCK")
SetPrvt("xRLC,xRSALDUPM,xPESBRU,xNMOEDA,xC6NUMORC,xCJEMIS,xCJVALI,xCJUSER,xCKPESO,xCKPRAZO")
SetPrvt("NCCFO,NCPOS,NCMENS")


#IFNDEF WINDOWS
	// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/06/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ MATR730  ³ Autor ³ Claudinei M. Benzi    ³ Data ³ 05.11.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao da Pr‚-Nota                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MATR730(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ OBS      ³ Prog.Transf. em RDMAKE por Fabricio C.David em 07/06/97    ³±±
±±³ Adptado  ³ Adaptacao para LWS pelo Analista Flavio em 13/09/00        ³±±
±±³ Adptado  ³ Adaptacao para LWS por MAM 31/03/06                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
bEmpLAN   := {|| SM0->M0_CODIGO <> "04" .AND. SM0->M0_CODIGO <> "02".AND. SM0->M0_CODIGO <> "03" }
tamanho   := "G"
li        := 80
LIMITE    := 220
LIMITE1   := 070
LIMITE2   := 079
LIMITE3   := 200//149
LIMITE4   := 072

titulo    := "Emissao da Confirmacao do Pedido - NC GAMES"
cDesc1    := PADC("Emissao Orcamento/Pedido NC",74)
cDesc2    := PADC("",74)
cDesc3    := PADC("",74)
aReturn   := {"ESPECIAL", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog  := "RFATR05D"
cPerg     := "XMTR70"
nLastKey  := 0
wnrel     := "RFATR05D"
nRegistro := 0
cKey      := ""
nIndex    := ""
cIndex    := "" //  && Variaveis para a criacao de Indices Temp.
cCondicao := ""
lEnd      := .T.
nBegin    := 0
aLinha    := { }
lRodape   := .F.
cPictQtd  := ""
aDriver   := ReadDriver()
cCompac   := aDriver[5]
nTotQtd   := nTotVal:=0
BASEIPI   := 0
TOTIPI    := 0
BASEICM   := 0
TOTICM    := 0
BASEICMST := 0
TOTICMST  := 0
nTOTREB   := 0
nTOTMR    := 0
nTOTLB    := 0
nTOTPES   := 0
aPedCli   := {}
cString   := "SC6"
xUSUCRI   := " "
xUSUAPR   := " "
USUARIO   := UPPER(ALLTRIM(SUBSTR(CUSUARIO,7,15)))
_nMOEDA2  := 0
_nMOEDA3  := 0
xNMOEDA   := ""
xEMISSAO  := DATE()
NTQREAL   := 0
NTQDOL    := 0
NTQPTX    := 0
NTVREAL   := 0
NTVDOLAR  := 0
NTVPTX    := 0
NTVDREAL  := 0
NTVPREAL  := 0
NTVGERAL  := 0
xPDESCAL  := 0
xCONTPAG  := 0
xTABCAT   := ""
xC6NUMORC := 0
xCJEMIS   := ""
xCJVALI   := ""
xCJUSER   := ""
xCKPESO   := 0
xCKPRAZO  := ""
TOTFAT    := 0
TOTMERC   := 0
xRNOME    := ""
xRENDER   := ""
xRBAIRRO  := ""
xRMUNIC   := ""
xRESTADO  := ""
xRCGC     := ""
xRINSCR   := ""
xRTELEF   := ""
xRCONTATO := ""
xRBLOCK   := ""
xCBLOCK   := ""
xRLC      := 0
xRSALDUPM := 0
xCMOEDA   := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte("XMTR70",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ mv_par01              Do Pedido                             ³
//³ mv_par02              Ate o Pedido                          ³
//³ mv_par03              Nota Numero                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey==27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	Return
Endif

#IFDEF WINDOWS
	RptStatus({||C730Imp()}) // Substituido pelo assistente de conversao do AP5 IDE em 25/06/02 ==>     RptStatus({||Execute(C730Imp)})
	
	Return
	// Substituido pelo assistente de conversao do AP5 IDE em 25/06/02 ==>     Function C730IMP
	Static Function C730IMP()
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbselectArea ("SM2")              // Cotação da moeda no dia do Faturamento
DbSetOrder(1)

IF DBSEEK(xEmissao)
	xCOTDOL := SM2->M2_MOEDA2
	xCOTPTX := SM2->M2_MOEDA3
ELSE
	xCOTDOL := 0
	xCOTPTX := 0
Endif

pergunte("XMTR70",.F.)

CPED:= MV_PAR01																						//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
CPEDATE:= MV_PAR02																					//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 

IF EMPTY(MV_PAR01) .OR. EMPTY(MV_PAR02)																//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
	IF !EMPTY(MV_PAR03)																				//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10   
		DBSELECTAREA("SD2")																			//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		DBSETORDER(1)																				//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CPED:= POSICIONE("SD2",3,XFILIAL("SD2")+MV_PAR03,"D2_PEDIDO")								//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CPEDATE:=POSICIONE("SD2",3,XFILIAL("SD2")+MV_PAR03,"D2_PEDIDO")								//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CITEM:=	POSICIONE("SD2",3,XFILIAL("SD2")+MV_PAR03,"D2_ITEMPV")								//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
	ELSE																							//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		MSGBOX("PEDIDO E/OU NOTA EM BRANCO")														//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		RETURN .F.																					//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
	ENDIF																							//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 		
ELSE																   								//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
	IF EMPTY(MV_PAR03)																				//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CPED:= MV_PAR01																				//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CPEDATE:= MV_PAR02																			//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
 	ENDIF																							//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 	
ENDIF
		
dbSelectArea("SC5")
dbSetOrder(1)
DbSeek(xFilial("SC5") + CPED,.T.)


SetRegua(RecCount())            // Total de Elementos da regua


While !Eof() .And. xFilial("SC5") == SC5->C5_FILIAL .And. SC5->C5_NUM <= CPEDATE
	
	IF EMPTY (MV_PAR03)         		   															//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		DBSELECTAREA("SC6") 			   															//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		DBSETORDER(1)					   															//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		DBSEEK(XFILIAL("SC6")+SC5->C5_NUM) 															//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		                                               	
		IF !EMPTY(SC6->C6_NOTA)																		//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
			CNOTA:= SC6->C6_NOTA																	//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
			DBSELECTAREA("SD2")																		//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10                                         	
			DBSETORDER(1)																			//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
			CITEM:=	POSICIONE("SD2",3,XFILIAL("SD2")+CNOTA,"D2_ITEMPV")								//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		ELSE																						//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
			MSGBOX("PEDIDO SEM NOTA FISCAL VINCULADA"+CHR(13)+"NUMERO DO PEDIDO: "+SC5->C5_NUM)		//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
			DBSKIP()//RETURN .F.   																	//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		ENDIF																						//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 		
	ELSE																							//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CNOTA:= MV_PAR03																			//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		DBSELECTAREA("SD2")																			//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		DBSETORDER(1)																				//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
		CITEM:=	POSICIONE("SD2",3,XFILIAL("SD2")+CNOTA,"D2_ITEMPV")									//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10
	ENDIF																							//INCLUSO VERIFICAÇÃO POR ERICH BUTTNER 25/05/10 
			
	// Atualiza as Margens do Orçamento / Pedido ********************************************************
	
	#IFNDEF WINDOWS
		If LastKey() == 286
			lEnd := .t.
			exit
		End
	#ENDIF
	
	aPedCli   := {}
	nTotQtd   := 00
	nTotVal   := 00
	cPedido   := SC5->C5_NUM
	_cObserv  := ""
	
	dbSelectArea("SA4")  //Transportadora
	dbSeek(xFilial() + SC5->C5_TRANSP)
	
	dbSelectArea("SA3") //Contatos
	dbSeek(xFilial() + SC5->C5_VEND1)
	
	dbSelectArea("SE4") //Condicao de Pagamento
	dbSeek(xFilial() + SC5->C5_CONDPAG)
	
	dbSelectArea("SD2") //Itens do Pedido de Venda
	dbSetOrder(8) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV
	dbSeek(xFilial() + cPedido+ CITEM) // ALTERADO POR ERICH BUTTNER 25/05/10 ANTES:dbSeek(xFilial() + cPedido)
	
	cPictQtd   := PESQPICTQT("C6_QTDENT",10)
	nRegistro  := RECNO()
	
	//dbGoTo( nRegistro )
	
	While !Eof() .And. SD2->D2_PEDIDO == SC5->C5_NUM //.AND. SD2->D2_DOC == CNOTA //Numero do Pedido for igual ao numero do pedido nos itens.
		
		#IFNDEF WINDOWS
			If LastKey() == 286
				lEnd := .t.
			End
		#ENDIF
		
		IF LastKey()==27
			@Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
			Exit
		Endif
		
		If li == 80
			li := 0
			ImpCabec()
		Endif
		
		If li > 40
			
			@ li,000 PSAY Replicate("-",Limite)
			
			li := li+1
			xCONTPAG := xCONTPAG + 1
			
			@ li,208 PSAY "PAGINA :"
			@ li,216 PSAY xCONTPAG PICTURE "@E 99"
			
			li := li+1
			
			@ li,000 PSAY Replicate("-",Limite)
			
			li := 0
			ImpCabec()
			
		Endif
		
		dbSelectArea("SD2") //Itens do Pedido de Venda
		dbSetOrder(3) // (3)D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM                                                                                                     
		dbSeek(xFilial("SD2")+CNOTA) // ALTERADO POR ERICH BUTTNER 25/05/10 ANTES: dbSeek(xFilial() + MV_PAR03) 
		
		//IF SD2->D2_DOC == MV_PAR03
		While! EOF() .and. SD2->D2_DOC == CNOTA// ALTERADO POR ERICH BUTTNER 25/05/10 ANTES: SD2->D2_DOC == MV_PAR03) 
			
			xNumnf := SD2->D2_DOC
			
			ImpItem()
			
			li:=li+1
			
			dbSelectArea("SF2")
			dbSetOrder(1)   //F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL                                                                                                          
			dbseek(xfilial("SF2") + CNOTA)// ALTERADO POR ERICH BUTTNER 25/05/10 ANTES: dbSeek(xFilial() + MV_PAR03) 
			
			BASEIPI    := SF2->F2_BASEIPI
			TOTIPI     := SF2->F2_VALIPI
			BASEICM    := SF2->F2_BASEICM
			TOTICM     := SF2->F2_VALICM
			BASEICMST  := SF2->F2_BRICMS
			TOTICMST   := SF2->F2_ICMSRET
			TOTFAT     := SF2->F2_VALBRUT
			TOTMERC    := SF2->F2_VALMERC
			xSERIE     := SF2->F2_SERIE           // Serie
			xHora      := SF2->F2_HORA
			
			dbSelectArea("SD2") //Itens do Pedido de Venda
			dbSetOrder(3) // (3)D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM                                                                                                     
			dbSkip()
			
		ENDdo
		
	//	Dbselectarea("SD2")
	//	DBSETORDER(8)
		dbSkip()
	Enddo
	
	Dbselectarea("SD2")
 	DBSETORDER(8)
  	dbSkip()
	
	IF lRodape
		ImpRodape()
		lRodape:=.F.
	Endif
	
	nTotVal  := 0
	nTotLB   := 0
	nTotMR   := 0
	nTotREB  := 0
	nTotPes  := 0
	nTQREAL  := 0
	nTQDOL   := 0
	nTQPTX   := 0
	nTVREAL  := 0
	nTVDOLAR := 0
	nTVPTX   := 0
	nTVDREAL := 0
	nTVPREAL := 0
	nTVGERAL := 0
	xPDESCAL := 0
	xCONTPAG := 0
	xPESBRU  := 0
	
	
	dbSelectArea("SC5")
	dbSkip()
	
	IncRegua()
	
	
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deleta Arquivo Temporario e Restaura os Indices Nativos      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SC5")

Ferase(cIndex+OrdBagExt())

dbSelectArea("SC6")

dbSetOrder(1)
dbGoTop()
Set device to screen

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpCabec(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/06/02 ==> Function ImpCabec
Static Function ImpCabec()

tamanho := "G"
lRodape := .T.
nPed    := ""
cMoeda  := ""
cCampo  := ""
cComis  := ""
cHeader := "It Codigo          Descricao do Produto                                                                                               Class.Fiscal           Unid.   Qtd    Vl.Unit.  Vlr Total  %ICMS %IPI    Vlr IPI "//Cred.Rebate  %Reb.   %MC    %LB"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Registro na Revenda Responsável pelo Cliente do Orçamento       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//   IF SC5->C5_CLIENTE = SC5->C5_REVENDA .AND. SC5->C5_LOJACLI = SC5->C5_LOJAREV .AND. SC5->C5_REVENDA <> "      "
xRNOME    := ""
xRENDER   := ""
xRCEP     := 0
xRBAIRRO  := ""
xRMUNIC   := ""
xRESTADO  := ""
xRCGC     := 0
xRINSCR   := ""
xRTELEF   := ""
xRCONTATO := ""
xRBLOCK   := ""
xCBLOCK   := ""
xCMOEDA   := ""
xPESBRU   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Registro no Cliente do Orçamento                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SA1")

dbSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)
xRLC      := SA1->A1_LC
xRSALDUPM := SA1->A1_SALDUPM
cNomecli := SA1->A1_NOME


@ 00,001 PSAY "NC GAMES & ARCADE CIELFM LTDA"
@ 00,090 PSAY "                   ESPELHO DE NOTA FISCAL                            "

@ 01,000 PSAY "-----------------------   CLIENTE PARA FATURAMENTO   -----------------------"
@ 01,077 PSAY "+----------------------------------------------------------------------"//"+----------------------.-----   REVENDA RESPONSAVEL   ---------------------------"
@ 01,150 PSAY "+--------- ORCAMENTO ---------+----- PEDIDO DE VENDA  -----+----------------"


xCMOEDA := SC5->C5_MOEDA
xPESBRU := SC5->C5_PBRUTO

@ 02,000 PSAY ALLTRIM(cNomecli) + " - " + SA1->A1_COD + "/" + SA1->A1_LOJA
@ 02,077 PSAY "|"
@ 02,150 PSAY "|                        |                                          "

@ 03,000 PSAY SA1->A1_END
@ 03,077 PSAY "| " + xRENDER
@ 03,150 PSAY "| Numero ......:"

xC6NUMORC := LEFT(GETADVFVAL("SC6","C6_NUMORC",xFILIAL("SC6")+SC5->C5_NUM,1,""),6)

@ 03,167 PSAY xC6NUMORC PICTURE "999999"
@ 03,175 PSAY "| Numero Nota..:"
@ 03,192 PSAY ALLTRIM(CNOTA) PICTURE "999999"  //// ALTERADO POR ERICH BUTTNER 25/05/10 ANTES: ALLTRIM(MV_par03)
// A pedido do Rogerio (Comercial) troquei a impressão do numero do pedido para numero da NF
//@ 03,192 PSAY SC5->C5_NUM PICTURE "999999"



xCJEMIS := GETADVFVAL("SCJ","CJ_EMISSAO",xFILIAL("SC6")+xC6NUMORC,1,"")
xCJVALI := GETADVFVAL("SCJ","CJ_VALIDA",xFILIAL("úSC6")+xC6NUMORC,1,"")
xCJUSER := ""


@ 04,000 PSAY SA1->A1_CEP    Picture "@R 99999-999"
@ 04,010 PSAY " - " + Alltrim(SA1->A1_BAIRRO) + " - " + Alltrim(SA1->A1_MUN) + " - " + SA1->A1_EST
@ 04,077 PSAY "| "
@ 04,150 PSAY "| Data Emissao :"
@ 04,167 PSAY xCJEMIS
@ 04,175 PSAY "| Data Emissao :"
@ 04,192 PSAY SC5->C5_EMISSAO
@ 05,000 PSAY "CGC: "
@ 05,005 PSAY SA1->A1_CGC Picture "@R 99.999.999/9999-99"
@ 05,025 PSAY "IE: "  + SA1->A1_INSCR
@ 05,077 PSAY "|                                                                        |  "

dbSelectArea("SF2")
dbSetOrder(2)
dbseek(xfilial("SF2")+SC6->C6_CLI+SC6->C6_LOJA+SC6->C6_NOTA+SC6->C6_SERIE)

xHora    :=SF2->F2_HORA
xEmissao := SF2->F2_EMISSAO

DBSKIP()

@ 05,175 PSAY "| Dt Emissao NF :"
@ 05,192 PSAY xEmissao

xUSUCRI  := xCJUSER
xUSUAPR  := ""

@ 06,000 PSAY "TEL: " + SA1->A1_TEL
@ 06,021 PSAY "- Contato :"
@ 06,038 PSAY IF (Eval(bEmpLAN),"","")
@ 06,071 PSAY "|"
@ 06,171 PSAY "Hora :"
@ 06,190 PSAY xhora

dbSelectArea("SF4")
DbSetOrder(1)
dbSeek(xFilial()+ SC6->C6_TES)

xNATUREZA:= SF4->F4_TEXTO     // Natureza da Operacao

dbskip()

dbSelectArea("SD2")
dbSetOrder(8) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV                                                                                                                                   
dbseek(xfilial("SD2")+ SC5->C5_NUM)

xCF := {}
AADD(xCF       , SD2->D2_CF)
XSOMA_CFO  := {}                         // Para notas com mais de um e ate dois CFOP

dbskip()

@ 06,169 PSAY "|" //Efetivado Por:"
@ 07,000 PSAY Replicate("-",limite1)
@ 07,070 PSAY "+------+"
@ 07,078 PSAY Replicate("-",limite4)
@ 07,150 PSAY "+------------------------+----------------------------+-----------------"
@ 08, 000 PSAY "CFOP: "

If Len(xCF)>1
	If xCF[1]<>xCF[2]
		XSOMA_CFO= xCF[1]+"/"+xCF[2]
		@ 08, 007 PSAY AllTrim(XSOMA_CFO)             // Codigo da Natureza de Operacao
	Else
		@ 08, 007 PSAY xCF[1] Picture "@ER 9.999"     // Codigo da Natureza de Operacao
	EndIf
Else
	@ 08, 007 PSAY xCF[1] Picture "@ER 9.999"          // Codigo da Natureza de Operacao
EndIf

@ 08,018 PSAY xNATUREZA
@ 08,085 PSAY "Cond Pgto: " + ALLTRIM(GETADVFVAL("SE4","E4_DESCRI",xFILIAL("SE4")+SC5->C5_CONDPAG,1,""))
li:=09//li+1
@ li,000 PSAY Replicate("-",limite)
li:=li+1
@ li,000 PSAY cHeader

li:=li+1
@ li,000 PSAY Replicate("-",limite)
li:=li+1

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpItem(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/06/02 ==> Function ImpItem

Static Function ImpItem()

nIPI       := 000
nVipi      := 000
nBaseIPI   := 100
nValBase   := 000
lIpiBruto  := IIF(GETMV("MV_IPIBRUT")=="S",.T.,.F.)

dbSelectArea("SC6")
dbSetOrder(1)
dbSeek(xFilial() + cPedido)

dbSelectArea("SB1")
dbSeek(xFilial() + SD2->D2_COD)

dbSelectArea("SF4")
dbSeek(xFilial() + SD2->D2_TES)

a730VerIcm()

xPRCTAB  := SC6->C6_PRUNIT
xPRCALC  := SC6->C6_PRUNIT
xICMSORI := SB1->B1_PICM

IF SF4->F4_IPI == "S"
	nBaseIPI        := IIF(SF4->F4_BASEIPI > 0,SF4->F4_BASEIPI,100)
	nIPI            := SB1->B1_IPI
	
	nValBase        := If(lIPIBruto .And. SC6->C6_PRUNIT > 0,xPRCALC,SC6->C6_PRCVEN)*SC6->C6_QTDENT
	nVipi           := nValBase * (nIPI/100)*(nBaseIPI/100)
Endif

@li,000 PSAY SD2->D2_ITEM
@li,003 PSAY SD2->D2_COD

dbSelectArea("SB1")
dbSeek(xFilial() + SD2->D2_COD)

xDescPro := SUBSTR(SB1->B1_XDESC,1,100)
xCodbar  := ALLTRIM(SB1->B1_CODBAR)
XPOSIPI  := SB1->B1_POSIPI

@li,019 PSAY ALLTRIM(xDescPro) + "( Cod.Barra: " + ALLTRIM(xCodbar) + " )"

//sd2->(dbseek(xfilial("SD2") + SC6->C6_NUM + SC6->C6_ITEM))

@li,136 PSAY XPOSIPI
@li,158 PSAY SD2->D2_UM
@li,161 PSAY SD2->D2_QUANT Picture "@E 999,999"
@li,171 PSAY SD2->D2_PRCVEN Picture "@E 999,999.99"
@li,182 PSAY SD2->D2_TOTAL Picture "@E 999,999.99"
@li,194 PSAY SD2->D2_PICM Picture "@E 99.99"
@li,198 PSAY SD2->D2_VALIPI Picture "@E 99,999.99"

DBSKIP()
NCCFO    :={}
VALIPI:=SD2->D2_VALIPI
@li,206 PSAY VALIPI Picture "@E 999,999.99"

NCPOS := aScan(NCCFO,{|x| x[1] == SD2->D2_CF })
If NCPOS == 0
	aadd( NCCFO , {SD2->D2_CF,GETADVFVAL("SF4","F4_TEXTO",xFilial("SF4")+SD2->D2_TES,1,"  ") } )
EndIf
//END IF


xCKPESO := GETADVFVAL("SCK","CK_PESO",xFILIAL("SC6")+SC6->C6_NUMORC,1,"")
//IF Eval(bEmpLAN)
//@li,165 PSAY (SC6->C6_QTDVEN) Picture "@E 9,999.999"//(xCKPESO*SC6->C6_QTDVEN) Picture "@E 9,999.999"

xCKPRAZO := GETADVFVAL("SCK","CK_PRAZO",xFILIAL("SC6")+SC6->C6_NUMORC,1,"")
//@li,157 PSAY SUBSTR(xCKPRAZO,1,10)
//ENDIF
//@li,166 PSAY SC6->C6_ENTREG

xPDESCAL :=(((xPRCALC - SC6->C6_PRCVEN) / xPRCALC) * 100)

IF xPDESCAL <= 0
	xPDESCAL := 0
ENDIF

nTotQtd := nTotQtd + SC6->C6_QTDENT
IF Eval(bEmpLAN)
	nTotPes :=" " //nTotPes + (xCKPESO*SC6->C6_QTDVEN)
	nTotReb := nTotReb //+ //SC6->C6_VLREBAT
ENDIF

/*
nTOTMR  := nTOTMR  + (SC6->C6_MARGEM * SC6->C6_VALOR)
nTOTLB  := nTOTLB  + (SC6->C6_RESULTA * SC6->C6_VALOR)
nTotVal := nTotVal + SC6->C6_VALOR
*/
IF SM0->M0_CODIGO = "01"
	nTOTMR  := nTOTMR // + (SC6->C6_MARGEM * NoRound(SC6->C6_VALOR+nVipi))
	nTOTLB  := nTOTLB  //+ (SC6->C6_RESULTA * NoRound(SC6->C6_VALOR+nVipi))
	nTotVal := nTotVal + NoRound(SC6->C6_VALOR+nVipi)
ENDIF
nTQREAL+=IIF(ALLTRIM(xNMOEDA)=="  R$",1,0)
nTQDOL+=IIF(ALLTRIM(xNMOEDA)=="US$C",1,0)
nTQPTX+=IIF(ALLTRIM(xNMOEDA)=="PTAX",1,0)

nTVREAL:=SC6->C6_VALOR

/*
nTVREAL+=IIF(ALLTRIM(xNMOEDA)=="R$",NoRound(SC6->C6_VALOR),0)
nTVDOLAR+=IIF(ALLTRIM(xNMOEDA)=="US$C",NoRound(SC6->C6_VALOR),0)
nTVPTX+=IIF(ALLTRIM(xNMOEDA)=="PTAX",NoRound(SC6->C6_VALOR),0)
*/

nTVREAL+=IIF(ALLTRIM(xNMOEDA)=="R$",NoRound(SC6->C6_VALOR+nVIPI),0)
nTVDOLAR+=IIF(ALLTRIM(xNMOEDA)=="US$C",NoRound(SC6->C6_VALOR+nVIPI),0)
nTVPTX+=IIF(ALLTRIM(xNMOEDA)=="PTAX",NoRound(SC6->C6_VALOR+nVIPI),0)

/*
nTVREAL+=IIF(ALLTRIM(SC5->C5_MOEDA)==1,SC6->C6_VALOR,0)
nTVDOLAR+=IIF(ALLTRIM(SC5->C5_MOEDA)==2,SC6->C6_VALOR,0)
nTVPTX+=IIF(ALLTRIM(SC5->C5_MOEDA)==3,SC6->C6_VALOR,0)
*/

dbSelectArea("SC6")

Return

/*/
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpRoadpe(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
/*/

Static Function ImpRodape()

IF li > 40
	@ li,000 PSAY Replicate("-",Limite)
	li := li+1
	xCONTPAG := xCONTPAG + 1
	@ li,214 PSAY "PAGINA :"
	@ li,223 PSAY xCONTPAG PICTURE "@E 99"
	li := li+1
	@ li,000 PSAY Replicate("-",Limite)
	impCABEC()
ENDIF

//BASEIPI:=SF2->F2_BASEIPI
//TOTIPI:=SF2->F2_VALIPI
//BASEICM:=SF2->F2_BASEICM
//TOTICM:=SF2->F2_VALICM
//BASEICMST:=SF2->F2_BRICMS
//TOTICMST:=SF2->F2_ICMSRET


@ li,000 PSAY Replicate("=",limite)
li:=li+1
@ li,000 PSAY "** T O T A L I Z A Ç Ã O   D O S   I T E N S **               "
//@ li,066 PSAY nTotQtd Picture "@E 999,999"
@ li,075 PSAY "BASE ICMS:"
@ li,085 PSAY BASEICM Picture "@E 999,999.999"
@ li,98 PSAY "VLR ICMS :"
@ li,109 PSAY TOTICM Picture "@E 999,999.99" // PesqPict("SC6","C6_VLREBAT",12)
@ li,120 PSAY "BASE ICMS-ST:"
@ li,135 PSAY BASEICMST  Picture "@E 999,999.99"
@ li,147 PSAY "VLR ICMS-ST:"
@ li,160 PSAY TOTICMST  Picture "@E 999,999.99"
@ li,171 PSAY "BASE IPI:"
@ li,181 PSAY BASEIPI  Picture "@E 999,999.99"
@ li,196 PSAY "VLR IPI:"
@ li,210 PSAY TOTIPI  Picture "@E 99,999.99"

//@ li,211 PSAY NTOTLB/nTotVal  Picture "@E 999.99"

li := li+1
@ li,059 PSAY Replicate("-",limite3)

li:=li+1
@ li,059 PSAY "VALOR DO(S)"
//@ li,069 PSAY nTQREAL PICTURE "@E 99"
@ li,072 PSAY "ITEM(NS) COM PREÇOS EM REAIS ................................................................................... - R$ "
@ li,194 PSAY TOTMERC PICTURE "@E 999,999,999.99"

li := li+1
nTVDREAL := nTVDOLAR //* xCOTDOL
/*@ li,059 PSAY "VALOR DOS"
@ li,069 PSAY nTQDOL PICTURE "@E 99"
@ li,072 PSAY "ITEM(NS) COM PREÇOS EM DOLAR COMERCIAL (US$C) :"
@ li,120 PSAY nTVDOLAR PICTURE "@E 999,999,999.99"
@ li,135 PSAY "- COTAÇÃO DA MOEDA HOJE - R$"
@ li,164 PSAY xCOTDOL PICTURE "@E 99.9999"
@ li,172 PSAY "- VALOR EM REAIS - R$"
@ li,194 PSAY nTVDREAL PICTURE "@E 999,999,999.99"

li := li+1
nTVPREAL := nTVPTX //* xCOTPTX
@ li,059 PSAY "VALOR DOS"
@ li,069 PSAY nTQPTX PICTURE "@E 99"
@ li,072 PSAY "ITEM(NS) COM PREÇOS EM DOLAR PTAX (PTAX) .....:"
@ li,120 PSAY nTVPTX PICTURE "@E 999,999,999.99"
@ li,135 PSAY "- COTAÇÃO DA MOEDA HOJE - R$"
@ li,164 PSAY xCOTPTX PICTURE "@E 99.9999"
@ li,172 PSAY "- VALOR EM REAIS - R$"
@ li,194 PSAY nTVPREAL PICTURE "@E 999,999,999.99"

li := li+1
@ li,059 PSAY Replicate("-",limite3)
*/
li := li+1
nTVGERAL := nTVREAL + nTVDREAL + nTVPREAL
@ li,059 PSAY "VALOR TOTAL DO PEDIDO "
//@ li,140 PSAY DATE()
@ li,149 PSAY " ...................................... - R$"
@ li,194 PSAY TOTFAT PICTURE "@E 999,999,999.99"

IF li < 49
	li := 49
endif

xRVTGERAL = nTVGERAL / xCOTDOL

// @ li,000 PSAY li PICTURE "@E 99"
// li := li + 1
IF SM0->M0_CODIGO = "01"
	@ li,000 PSAY "OBSERVACOES : " + ""//ALLTRIM(SC5->C5_OBS1)
	li := li+1
ENDIF
@ li,000 PSAY Replicate("-",limite)
li := li+1
@ li,143 PSAY " ** TOTAL DESTE PEDIDO ** R$"
@ li,196 PSAY TOTFAT PICTURE "@E 999,999,999.99"
li := li+2
@ li,000 PSAY "Local de Cobranca........: " + AllTrim(SA1->A1_ENDCOB) + " - CEP: " + AllTrim(SA1->A1_CEPC) + " - BAIRRO : " + AllTrim(SA1->A1_BAIRROC) + " - CIDADE : " + AllTrim(SA1->A1_MUNC) + " - EST. : " + AllTrim(SA1->A1_ESTC)
li := li+1
@ li,000 PSAY "Mensagem para Nota Fiscal: " + ALLTRIM(SC5->C5_MENNOTA)
li := li+1
xNumnf:=CNOTA
@ li,000 PSAY "Num. NF: " + ALLTRIM(xNumnf)
li := li+1
If TOTICMST <> 0
	nCol:=07
	@ li, 000 PSAY "Imposto recolhido por ST conf. Art. 313-M do RICMS"
ENDIF
li := li+1

@ li, 000 PSAY "Pedido NC: " + cPedido
li := li+1
@ li, 000 PSAY "Pedido Cliente: " + SC5->C5_PEDCLI
li := li+1
@ li, 000 PSAY "Vendedor: " + SC5->C5_VEND1
li := li+1
@ li,000 PSAY Replicate("-",limite)
li := li+1
@ li,000 PSAY "***   DADOS PARA ENTREGA   -   Transportadora : " + ALLTRIM(SA4->A4_NOME) + " - " + SA4->A4_TEL
li := li+1
@ li,000 PSAY "Frete : " + IIF(SC5->C5_TPFRETE == "C","CIF","FOB")
@ li,012 PSAY "- Valor do Frete :"
@ li,031 PSAY SC5->C5_FRETE  Picture "@EZ 999,999,999.99"
@ li,047 PSAY " - Volume(s) :"
@ li,062 psay SC5->C5_VOLUME1 Picture "@EZ 999,999"
@ li,070 PSAY " - Especie :"
@ li,083 PSAY SC5->C5_ESPECI1
@ li,100 PSAY " - Seguro :"
@ li,111 PSAY SC5->C5_SEGURO Picture "@EZ 999,999,999.99"
li := li+1
cEndSA1:=Alltrim(SA1->A1_ENDENT)
cCepSA1:=Alltrim(SA1->A1_CEPE)
cBairSA1:=Alltrim(SA1->A1_BAIRROE)
cMumSA1:=Alltrim(SA1->A1_MUNE)
cEstSA1:=AllTrim(SA1->A1_ESTE)

If SC5->C5_XECOMER=="C"
	U_COM05EndEnt(SC5->C5_NUM,@cEndSA1,@cBairSA1,@cCepSA1,@cMumSA1,@cEstSA1)
EndIf

@ li,000 PSAY "Local de Entrega : " + cEndSA1 + " - CEP : " + cCepSA1 + " - BAIRRO : " + cBairSA1 + " - MUNICIPIO : " + cMumSA1 + " - EST. : " + cEstSA1
li := li+1
@ li,000 PSAY Replicate("-",limite)


//li := li+4
//@ li,014 PSAY REPLICATE("-",27)+ SPACE(5)+ REPLICATE("-",27)+ SPACE(5)+ REPLICATE("-",27)+ SPACE(5)+ REPLICATE("-",27)+ SPACE(5)+ REPLICATE("-",27)
//li := li+1
//@ li,014 PSAY "APROV. GESTOR CLIENTE"+SPACE(11)+"APROV. GESTOR PRODUTO"+SPACE(11)+"APROV. GESTOR COMERCIAL"+SPACE(9)+"APROVACAO DIRETORIA"+SPACE(13)+"APROVACAO DO CREDITO"

IF xCONTPAG > 0
	xCONTPAG := xCONTPAG + 1
	@ li,214 PSAY "PAGINA :"
	@ li,223 PSAY xCONTPAG PICTURE "@E 99"
ENDIF

li := 80

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A730verIcm³ Autor ³ Claudinei M. Benzi    ³ Data ³ 11.02.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rotina para verificar qual e o ICM do Estado               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATA460                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/06/02 ==> Function A730VerIcm
Static Function A730VerIcm()

nPerRet:=0                // Percentual de retorno
cEstado:=GetMV("mv_estado")
tNorte:=GetMV("MV_NORTE")
cEstCli:=SA1->A1_EST
cInscrCli:=SA1->A1_INSCR

If SF4->F4_ICM == "S"
	If SC5->C5_TIPOCLI == "F" .and. Empty(cInscrCli)
		nPerRet := iif(SB1->B1_PICM>0,SB1->B1_PICM,GetMV("MV_ICMPAD"))
	Elseif SC5->C5_TIPOCLI == "F" .and. ALLTRIM(UPPER(cInscrCli)) == "ISENTO"
		nPerRet := iif(SB1->B1_PICM>0,SB1->B1_PICM,GetMV("MV_ICMPAD"))
	Elseif SB1->B1_PICM > 0 .And. cEstCli == cEstado
		nPerRet := SB1->B1_PICM
	Elseif cEstCli == cEstado
		nPerRet := GetMV("MV_ICMPAD")
	Elseif cEstCli $ tNorte .And. At(cEstado,tNorte) == 0
		nPerRet := 7
	Elseif SC5->C5_TIPOCLI == "X"
		nPerRet := 13
	Else
		nPerRet := 12
	Endif
Endif
Return
