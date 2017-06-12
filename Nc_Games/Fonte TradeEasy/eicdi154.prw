
//Funcao    :EICDI154()
//Autor     :ALEX WALLAUER  01/08/2000  - (Protheus V710)       
//Descricao :Recebimento de Importacao ( Solicitacao de NFE)             
//Uso       :SIGAEIC                                                     
 
#INCLUDE "Eicdi154.ch" 
//#INCLUDE "FiveWin.ch"
#include "Average.ch"
#DEFINE  NFE_PRIMEIRA  1
#DEFINE  NFE_COMPLEMEN 2
#DEFINE  NFE_UNICA     3
#DEFINE  CUSTO_REAL    4
#DEFINE  NFE_MAE       5
#DEFINE  NFE_FILHA     6
#DEFINE  NF_TRANSFENCIA 9// AWR - 02/02/09 - NFT

*---------------------------*
Function EICDI154()
*---------------------------*
Private aFixos:={ { AVSX3("W6_HAWB"   ,5) ,"W6_HAWB"   },; //"Processo"
                  { AVSX3("W6_DI_NUM" ,5) ,"W6_DI_NUM" },; //"No. da D.I."
                  IF(GETMV("MV_TEM_DI",,.F.),;
                  { AVSX3("W6_ADICAOK",5) ,{|| IF(!SW6->W6_ADICAOK $ cSim,STR0262,STR0261)}},;
                  { AVSX3("W6_TX_US_D",5) ,"W6_TX_US_D"}),;
                  { AVSX3("W6_NF_ENT" ,5) ,"W6_NF_ENT" },; //"1a. NFE"
                  { AVSX3("W6_DT_NF"  ,5) ,"W6_DT_NF"  },; //AWR 14/7/98 //"Dt 1a. NFE"
                  { AVSX3("W6_NF_COMP",5) ,"W6_NF_COMP"},; //"1a. NFC"
                  { AVSX3("W6_DT_NFC" ,5) ,"W6_DT_NFC" },; //AWR 14/7/98 //"Dt 1a. NFC"
                  { AVSX3("W6_FOB_GER",5) ,"W6_FOB_GER"},; //SVG 13/10/08 //"Total Geral"                                
                  { AVSX3("W6_FOB_TOT",5) ,"W6_FOB_TOT"},; //"Total F.O.B."
                  { AVSX3("W6_INLAND" ,5) ,"W6_INLAND" },; //"Inland"
                  { AVSX3("W6_PACKING",5) ,"W6_PACKING"},; //"Packing"
                  { AVSX3("W6_FRETEIN",5) ,"W6_FRETEIN"},; //"Frete Intl"
                  { AVSX3("W6_DESCONT",5) ,"W6_DESCONT"} } //"Desconto"

Private lAUTPCDI := DI500AUTPCDI()	//JWJ 12/05/2006

Private PICT_CPO03 :=  ALLTRIM(X3PICTURE("B1_POSIPI")) //_PictTec
Private _PictPrUn := ALLTRIM(X3Picture("W3_PRECO")), _PictQtde := ALLTRIM(X3Picture("W3_QTDE"))
Private PICT_CPO07 := _PictQtde//"@E 999,999,999.9999"
//PRIVATE cCond:="If(Empty(SW6->W6_DI_NUM),.F.,.T.)", cLeuNota:=""
PRIVATE cLeuNota:=""

PRIVATE cCadastro := STR0013 //"Recebimento de Importa‡Æo - NF"

PRIVATE Work1File,Work1FileA,Work1FileB,Work1FileC,Work1FileD,Work1FileE,Work1FileF,Work1FileG,Work1FileH,Work1FileI,Work1FileJ,Work2File,Work2FileA, Work3File,Work3FileA,Work4File,cFileWk,cFileWkA

PRIVATE aRotina := MenuDef()
//SVG 07/01/09 - Verificação contida na função MenuDef
//IF cPaisLoc == "BRA"
   //AADD(aRotina,{"Gera I.N. 68/86","EICDI155",0,4})
//ENDIF

PRIVATE aDespesa:= {}
PRIVATE PICTICMS:=ALLTRIM(X3Picture("YD_ICMS_RE"))
PRIVATE aPos:= { 15,  1, 70, 540 }
Private lIntDraw := GetMV("MV_EIC_EDC",,.F.)//Verifica se existe a integração com o Módulo SIGAEDC
Private cAntImp  := GetMV("MV_ANT_IMP",,"1")
Private lAltNfeNum := .T. // Ricardo Dumbrovsky 08/12/04
PRIVATE nTotFreTira := 0 // LAM - 19/10/06
Private cSeek , bEIUWhile  
//** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
Private cCodTxSisc := GetMV("MV_CODTXSI",,"XXX")
Private lRatCIF    := GetMV("MV_TXSIRAT",,.F.) 


//**
/*
//PRIVATE cCond:="If(Empty(SW6->W6_DI_NUM),.F.,.T.)"
Private aColors:= {{"Empty(SW6->W6_DI_NUM)","DISABLE"},;
                   {"!Empty(SW6->W6_DI_NUM)","ENABLE"}}
*/                   
Private aColors:= {{"Empty(SW6->W6_DI_NUM) .AND. SW6->W6_CURRIER <> '1'","DISABLE"},;    //NCF - 19/10/2009 - Adicionada verificação da flag para que o sistema permita
                   {"!Empty(SW6->W6_DI_NUM) .OR. SW6->W6_CURRIER == '1' ","ENABLE"}}     //                   a geração da nota quando o desembaraço for de Currier.

Private lSegInc  := SW9->(FIELDPOS("W9_SEGINC")) # 0 .AND. SW9->(FIELDPOS("W9_SEGURO")) # 0 .AND. ;
                   SW8->(FIELDPOS("W8_SEGURO")) # 0 .AND. SW6->(FIELDPOS("W6_SEGINV")) # 0
                   //EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)
/*
Private lEstornaBtn
// EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)
Private nTxSiRatCIF := nAuxTxSiAd := 0  //NCF - 19/07/2010
PRIVATE lCposNFDesp := (SWD->(FIELDPOS("WD_B1_COD")) # 0 .And. SWD->(FIELDPOS("WD_DOC")) # 0 .And. SWD->(FIELDPOS("WD_SERIE")) # 0;                   //NCF - Campos da Nota Fiscal de Despesas
                       .And. SWD->(FIELDPOS("WD_ESPECIE")) # 0 .And. SWD->(FIELDPOS("WD_EMISSAO")) # 0 .AND. SWD->(FIELDPOS("WD_B1_QTDE")) # 0;
                       .And. SWD->(FIELDPOS("WD_TIPONFD")) # 0)  
                       
Private lCposPtICMS :=  ( SB1->(FIELDPOS("B1_VLR_ICM")) # 0 .And.  SWZ->(FIELDPOS("WZ_TPPICMS")) # 0 .And. SW8->(FIELDPOS("W8_VLICMDV")) # 0  .And. EIJ->(FIELDPOS("EIJ_VLICMD")) # 0 )        //NCF - 11/05/2011- Campos do ICMS de Pauta
*/
Private lPesoBruto := SW3->(FieldPos("W3_PESO_BR")) > 0 .And. SW5->(FieldPos("W5_PESO_BR")) > 0 .And. SW7->(FieldPos("W7_PESO_BR")) > 0 .And.;
                      SW8->(FieldPos("W8_PESO_BR")) > 0 .And. GetMv("MV_EIC0014",,.F.) //FSM - 02/09/2011 - Campo de peso bruto unitario

IF lSegInc 
   AADD( aFixos, {AVSX3("W6_SEGINV",5) ,"W6_SEGINV"} )
ENDIF

SA5->(DBSETORDER(3))
SW2->(DBSETORDER(1))
IF(ExistBlock("FI400ExisteCampos"),ExecBlock("FI400ExisteCampos",.F.,.F.,.T.),)

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"MBROWSE"),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"MBROWSE"),)
 

//AvStAction("204",.F.)//AWR 17/03/2009  
//OAP - Substituição da chamda feita no antigo EICPOCO.
IF GETMV("MV_EIC_PCO",,.F.)
   IF !GETMV("MV_PCOIMPO",,.F.)//Se for importador é .T., e Adquirente é .F.
      AADD(aRotina,{"Visualiza NFT","EICCO100(.F.,GETMV('MV_PCOIMPO',,.T.))",0,4})   
   ENDIF
ENDIF

//mBrowse(,,,,"SW6",aFixos,,,cCond)
mBrowse(,,,,"SW6",aFixos,,,,,aColors)

SA5->(DBSETORDER(1))
SWZ->(DBSETORDER(1))
SWN->(DBSETORDER(1))
SF1->(DBSETORDER(1))
SD1->(DBSETORDER(1))
SX3->(DBSETORDER(1))
SW7->(DBSETORDER(1))
SW8->(DBSETORDER(1))
SW9->(DBSETORDER(1))
SX3->(DBSETORDER(1))
If lIntDraw
   ED4->(dbSetOrder(1))
   ED0->(dbSetOrder(1))
EndIf
DBSELECTAREA("SX3")

Return .T.

/*
Funcao     : MenuDef()
Parametros : Nenhum
Retorno    : aRotina
Objetivos  : Menu Funcional
Autor      : Adriane Sayuri Kamiya
Data/Hora  : 03/02/07 - 09:13
*/
Static Function MenuDef()
Local aRotAdic := {}
Local aRotina  := {}
Private lMV_NF_MAE    := GetMV("MV_NF_MAE",,.F.) //SVG - 30/10/2009 - Tratamento NF Mae e Filha -

aAdd(aRotina,{STR0014 ,"AxPesqui", 0 , 1}) //"Pesquisar"
aAdd(aRotina,{STR0015 ,"DI154NFE", 0 , 2}) //"P&rimeira"
aAdd(aRotina,{STR0016 ,"DI154NFE", 0 , 2}) //"Complementar"
aAdd(aRotina,{STR0017 ,"DI154NFE", 0 , 2}) //"Unica"

If lMV_NF_MAE
   aAdd(aRotina,{STR0297 ,"DI154NFE", 0 , 2}) //"Nota Mãe"   //SVG - 30/10/2009 - Tratamento NF Mae e Filha -
   aAdd(aRotina,{STR0298 ,"DI154NFE", 0 , 2}) //"Nota Filha" //SVG - 30/10/2009 - Tratamento NF Mae e Filha -
EndIf

aAdd(aRotina,{STR0018 ,"DI154NFE", 0 , 2}) //"Cus&to Realiz"

IF cPaisLoc == "BRA"
   AADD(aRotina,{"Gera I.N. 68/86","EICDI155",0,4})
ENDIF             

// P.E. utilizado para adicionar itens no Menu da mBrowse
If ExistBlock("IDI154MNU")
	aRotAdic := ExecBlock("IDI154MNU",.f.,.f.)
	If ValType(aRotAdic) == "A"
		AEval(aRotAdic,{|x| AAdd(aRotina,x)})
	EndIf
EndIf

Return aRotina

*----------------------------------------------------------*
Function DI154NFE(cAlias,nReg,nOpc,xVal1,xVal2,aLocExecAuto)
*----------------------------------------------------------*
LOCAL bDDIFor:={||AT(SWD->(LEFT(SWD->WD_DESPESA,1)),"129") = 0 .AND.;
                  IF(!lGravaWorks,Empty(SWD->WD_NF_COMP),;
                     SWD->WD_NF_COMP+SWD->WD_SE_NFC=cNota) }

LOCAL bDDIWhi:={||xFILIAL("SWD")==SWD->WD_FILIAL .AND. SWD->WD_HAWB == SW6->W6_HAWB}, oButton
LOCAL oDlg, nCoL1, nCoL2, nCoL3, nCoL4 ,I ,oPanel
LOCAL nIntPeso:=AVSX3("WN_PESOL",3)//AWR - 21/06/2006
LOCAL nDecPeso:=AVSX3("WN_PESOL",4)//AWR - 21/06/2006
LOCAL cValToTPeso:=REPL("9",(nIntPeso-nDecPeso-1))+"."+REPL("9",nDecPeso)//AWR - 21/06/2006
LOCAL lNaoNFCompl:= GETMV("MV_AVG0160",.T.) .AND. GETMV("MV_AVG0160",,.F.)  //TRP-31/07/2008- Caso parâmetro seja .T., não permite que seja gerada nota complementar 
             
Local aOrdSF1                                                                                           // caso já tenha sido gerada nota única.

PRIVATE lDifCamb     :=.F.  // calcula diferenca cambial         Bete 24/11 - Trevo //RRV - 25/02/2013
Private lMV_NF_MAE    := GetMV("MV_NF_MAE",,.F.) //SVG - 30/10/2009 - Tratamento NF Mae e Filha
Private lTxSiscOK := .T.//JVR - 24/09/2009
PRIVATE nValToTPeso:=VAL(cValToTPeso)//AWR - 21/06/2006
PRIVATE lDespAuto:=.f., aDespExecAuto:={}, lCalcImpAuto := .F. // EOS
PRIVATE lSomaDifMidia := GETMV("MV_DIFMIDI",,.T.)
PRIVATE aImp_NF  := {}, aDesp_NF := {}, aDesp2_NF := {} // Bete 12/09/05 - p/ utilizacao em rdmake
// ** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
Private nTxSisc := nTxSiscCIF := 0
PRIVATE nDecimais:=AVSX3("W9_FOB_TOT",4)//Usada nas funcoes DI500IICalc() e DI500IPICalc()
PRIVATE nDecPais:=MSDECIMAIS(1)
Private lQbgOperaca:= EIJ->(FIELDPOS("EIJ_OPERAC")) # 0 .AND. SW8->(FIELDPOS("W8_OPERACA")) # 0 //AWR - 18/09/08 NFE
Private lExisteSEQ_ADI:= SW8->(FIELDPOS("W8_SEQ_ADI")) # 0 .AND.;
                         SWN->(FIELDPOS("WN_SEQ_ADI")) # 0 .AND.;
                         SW8->(FIELDPOS("W8_GRUPORT")) # 0 //AWR - 18/09/08 NFE
Private lMV_GRCPNFE:= GetMV("MV_GRCPNFE",,.F.) .AND.; //AWR - 04/11/08 - Indica se integracao vai gravar (T) ou não (F) os campos novos da NFE
        SWN->(FIELDPOS("WN_PREDICM")) # 0 .AND. SWN->(FIELDPOS("WN_DESCONI")) # 0 .AND.;
        SWN->(FIELDPOS("WN_VLRIOF"))  # 0 .AND. SWN->(FIELDPOS("WN_DESPADU")) # 0 .AND.;
        SWN->(FIELDPOS("WN_ALUIPI"))  # 0 .AND. SWN->(FIELDPOS("WN_QTUIPI"))  # 0 .AND.;
        SWN->(FIELDPOS("WN_QTUPIS"))  # 0 .AND. SWN->(FIELDPOS("WN_QTUCOF"))  # 0
Private nSemCusto:= 0
Private nPSemCusto:= 0
// **
PRIVATE lSoGravaNF  :=.F.// AWR - 02/02/09 - So Grava a NF sem Tela
PRIVATE lSoEstornaNF:=.F.// AWR - 12/02/09 - So Estorna a NF sem Tela

//TRP- 01/06/09 - Parâmetro que define se o novo Tratamento de Mídia/Software será habilitado.
Private lNewMidia:= GetMV("MV_CONSOFT",,"N") $ cSim .And. SW3->(FieldPos("W3_SOFTWAR")) # 0
Private lPCBaseICM := SWZ->(FieldPos("WZ_PC_ICMS")) # 0 

PRIVATE lDespAcrescimo:= GetMv("MV_EIC0016",,.F.)

Private lSegInc  := SW9->(FIELDPOS("W9_SEGINC")) # 0 .AND. SW9->(FIELDPOS("W9_SEGURO")) # 0 .AND. ;
                   SW8->(FIELDPOS("W8_SEGURO")) # 0 .AND. SW6->(FIELDPOS("W6_SEGINV")) # 0
                   //EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)
Private lEstornaBtn
// EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)
Private nTxSiRatCIF := nAuxTxSiAd := 0  //NCF - 19/07/2010
PRIVATE lCposNFDesp := (SWD->(FIELDPOS("WD_B1_COD")) # 0 .And. SWD->(FIELDPOS("WD_DOC")) # 0 .And. SWD->(FIELDPOS("WD_SERIE")) # 0;                   //NCF - Campos da Nota Fiscal de Despesas
                       .And. SWD->(FIELDPOS("WD_ESPECIE")) # 0 .And. SWD->(FIELDPOS("WD_EMISSAO")) # 0 .AND. SWD->(FIELDPOS("WD_B1_QTDE")) # 0;
                       .And. SWD->(FIELDPOS("WD_TIPONFD")) # 0)  
                       
Private lCposPtICMS :=  ( SB1->(FIELDPOS("B1_VLR_ICM")) # 0 .And.  SWZ->(FIELDPOS("WZ_TPPICMS")) # 0 .And. SW8->(FIELDPOS("W8_VLICMDV")) # 0  .And. EIJ->(FIELDPOS("EIJ_VLICMD")) # 0 )        //NCF - 11/05/2011- Campos do ICMS de Pauta

Private nIniTxComp := 0   //NCF - 25/05/2011 - Inicialização do valor pela tabela C5

Private lPesoBruto := SW3->(FieldPos("W3_PESO_BR")) > 0 .And. SW5->(FieldPos("W5_PESO_BR")) > 0 .And. SW7->(FieldPos("W7_PESO_BR")) > 0 .And.;
                      SW8->(FieldPos("W8_PESO_BR")) > 0 .And. GetMv("MV_EIC0014",,.F.) //FSM - 02/09/2011 - Campo de peso bruto unitario

Private lCposCofMj := SYD->(FieldPos("YD_MAJ_COF")) > 0 .And. SYT->(FieldPos("YT_MJCOF")) > 0 .And. SWN->(FieldPos("WN_VLCOFM")) > 0 .And.;                                                    //NCF - 20/07/2012 - Majoração PIS/COFINS
                      SWN->(FieldPos("WN_ALCOFM")) > 0  .And. SWZ->(FieldPos("WZ_TPCMCOF")) > 0 .And. SWZ->(FieldPos("WZ_ALCOFM")) > 0 .And.;
                      EIJ->(FieldPos("EIJ_ALCOFM")) > 0 .And. SW8->(FieldPos("W8_VLCOFM")) > 0 .And. EI2->(FieldPos("EI2_VLCOFM")) > 0 
Private lCposPisMj := SYD->(FieldPos("YD_MAJ_PIS")) > 0 .And. SYT->(FieldPos("YT_MJPIS")) > 0 .And. SWN->(FieldPos("WN_VLPISM")) > 0 .And.;                                                    //NCF - 20/07/2012 - Majoração PIS/COFINS
                      SWN->(FieldPos("WN_ALPISM")) > 0  .And. SWZ->(FieldPos("WZ_TPCMPIS")) > 0 .And. SWZ->(FieldPos("WZ_ALPISM")) > 0 .And.;
                      EIJ->(FieldPos("EIJ_ALPISM")) > 0 .And. SW8->(FieldPos("W8_VLPISM")) > 0 .And. EI2->(FieldPos("EI2_VLPISM")) > 0    //GFP - 11/06/2013 - Majoração PIS
PRIVATE nTipoNF := nOpc

IF aLocExecAuto == NIL
   lExecAuto:=.F.
   lDespAuto:=.F.
ELSE   
   IF VALTYPE(aLocExecAuto) == "L"
      lExecAuto:=aLocExecAuto
   ELSE
      lExecAuto:= aLocExecAuto[1]
      If (lDespAuto:=aLocExecAuto[2])==.T.  // indica que os calculos de despesa devem ser baseados na tabela passada como parâmetro
         aDespExecAuto:=aLocExecAuto[3]
      Endif                               
      IF Len(aLocExecAuto) > 3
         lCalcImpAuto := aLocExecAuto[4]  // EOS
      ENDIF
      IF Len(aLocExecAuto) > 4
         lSoGravaNF := aLocExecAuto[5]  // AWR - 02/02/09 - So Grava a NF
      ENDIF
   ENDIF
ENDIF

DBSELECTAREA("SW6")
IF Reccount() == 0
   Return .F.
EndIf

SX6->(DBSETORDER(1))
SX3->(DBSETORDER(2))
lMV_PIS_EIC    := GETMV("MV_PIS_EIC",,.F.) .AND. SWN->(FIELDPOS("WN_VLRPIS")) # 0 .AND. SYD->(FIELDPOS("YD_PER_PIS")) # 0 .AND. FindFunction("DI500PISCalc")
lMV_PIS_EIC    := lMV_PIS_EIC .AND. ((SW6->W6_DTREG_D >= CTOD("01/05/2004")) .OR. EMPTY(SW6->W6_DTREG_D)) // DFS - Permitir que apareça a soma dos totais (PIS e COFINS) no Recebimento de Importação, se a data de D.I estiver em branco no Desembaraço
lMV_ICMSPIS    := lMV_PIS_EIC .AND. GETMV("MV_ICMSPIS",,.F.)
lIntDraw       := GetMV("MV_EIC_EDC",,.F.) //Verifica se existe a integração com o Módulo SIGAEDC
lExistEDD      := SX3->(dbSeek("EDD_FILIAL")) // AWR - 29/06/2004
lEIB_Processa  := GETMV("MV_UTILEIB",,.F.)
lEIB_Chave     := SX3->(DBSEEK("EIB_CHAVE"))
lMV_EASYSIM    := GETMV("MV_EASY",,"N") $ cSim
lICMS_NFC      := GETMV("MV_ICMSNFC",,.F.) 
lLote          := GETMV("MV_LOTEEIC",,"N") $ cSim
lExiste_Midia  := GETMV("MV_SOFTWAR",,"N") $ cSim
lRateioCIF     := GETMV("MV_RATCIF" ,,"N") $ cSim
lIn327         := GETMV("MV_IN327" ,,.F.)    // JBS 29/10/2003
lTemDespBaseICM:= SX3->(DBSEEK("WN_DESPICM")) .AND. IF(lMV_EASYSIM,.T.,SX3->(DBSEEK("F1_DESPICM")) )
lDISimples     := GETMV("MV_TEM_DSI",,.F.) .AND. SW6->W6_DSI $ cSim
lVlUnid        := SX3->(DBSEEK("YD_UM"))  .AND. SX3->(DBSEEK("W8_QTDE_UM")) // LDR - OC - 0048/04 - OS - 0989/04

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"INICIA_VARIAVEIS_1"),)//BHF-22/05/09

//AST - 07/06/08 - acrescentado na flag lAcresDeduc, verificação se a tabela EIU existe no SX3
SX3->(dbSetOrder(1))
lAcresDeduc    := SWN->(FIELDPOS("WN_VLACRES")) # 0 .AND. SWN->(FIELDPOS("WN_VLDEDUC")) # 0 .AND. ;// Bete - 24/07/04 - Inclusao de Acrescimos e deducoes na base de impostos
                  EI2->(FIELDPOS("EI2_VACRES")) # 0 .AND. EI2->(FIELDPOS("EI2_VDEDUC")) # 0 .AND. SX3->(dbSeek("EIU"))
lICMSMidiaDupl := GETMV("MV_ICMSDUP",,.F.)//AWR - 27/06/2006
lExiste_IPIPA  := IPIPauta() //ATENCAO: SX3->(DBSETORDER(1)) DENTRO DESTA FUNCAO
lAliqEIB       := .F.
lICMS_Dif      := SWZ->( FieldPos("WZ_ICMSUSP") > 0  .And.  FieldPos("WZ_ICMSDIF") > 0  .And.  FieldPos("WZ_ICMS_CP") > 0  .And.  FieldPos("WZ_ICMS_PD") > 0  )  ;
                  .And.  SWN->( FieldPos("WN_VICM_PD") > 0  .And.  FieldPos("WN_VICMDIF") > 0  .And.  FieldPos("WN_VICM_CP") > 0 )
// EOB - 16/02/09                   
lICMS_Dif2     := SWZ->( FieldPos("WZ_PCREPRE") ) > 0 .AND. SWN->( FieldPos("WN_PICM_PD") > 0  .And.  FieldPos("WN_PICMDIF") > 0  .And.  FieldPos("WN_PICM_CP") > 0 .And. FieldPos("WN_PLIM_CP") > 0 )
//SVG - 14/08/2009 - ICMS de Pauta -
cMV_CALCICM    := GETMV("MV_CALCICM",,"0")
Private lTabSisAtu := .F.

DBSELECTAREA("EIJ")
EIJ->(DBSETORDER(1))
PRIVATE lChama554 := .F.  //LDR 09/12/03

If !lSoGravaNF .AND. !lSoEstornaNF
   IF (lDISimples .OR. GETMV("MV_TEM_DI",,.F.)) .AND. EIJ->(DBSEEK(xFilial()+SW6->W6_HAWB)) //.AND. !lExecAuto
      IF SW6->(FIELDPOS("W6_TEM_DI")) # 0 .AND. !lDISimples
         IF SW6->W6_TEM_DI = "1"
            lChama554:=.t.
         ENDIF   
      ELSE
         lChama554:=.t.
      ENDIF
   ENDIF
ENDIF

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"EXEC_554"),)  //LDR 09/12/03

IF lChama554   //LDR 09/12/03
   DI554NFE(cAlias,nReg,nOpc,aLocExecAuto)
   IF GETMV("MV_EIC_PCO",,.F.)
      RETURN .T.
   ELSE   
      RETURN .F.
   ENDIF
ENDIF

PRIVATE cCpoBsPis:=cCpoVlPis:=cCpoAlPis:=cCpoAlCof:=cCpoBsCof:=cCpoVlCof:=cTipo_AD:=""
IF lMV_PIS_EIC .AND. lMV_EASYSIM
   aRelImp  := MaFisRelImp("MT100",{ "SD1" })
   If !Empty( S:= aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_BASEPS2"} ) )
      cCpoBsPis:= aRelImp[S,2]
   EndIf
   If !Empty( S:= aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_VALPS2"} ) )
      cCpoVlPis:= aRelImp[S,2]
   EndIf
   If !Empty( S:= aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_ALIQPS2"} ) )
      cCpoAlPis:= aRelImp[S,2]
   EndIf
   If !Empty( S:= aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_ALIQCF2"} ) )
      cCpoAlCof:= aRelImp[S,2]
   EndIf
   If !Empty( S:= aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_BASECF2"} ) )
      cCpoBsCof:= aRelImp[S,2]
   EndIf 	
   If !Empty( S:= aScan(aRelImp,{|x| x[1]=="SD1" .And. x[3]=="IT_VALCF2"} ) )
      cCpoVlCof:= aRelImp[S,2]
   EndIf
   IF EMPTY(cCpoBsPis) .OR. EMPTY(cCpoVlPis) .OR. EMPTY(cCpoBsCof) .OR.;
      EMPTY(cCpoVlCof) .OR. EMPTY(cCpoAlPis) .OR. EMPTY(cCpoAlCof)
      MSGINFO(STR0420+; // STR0420 "Os campos de PIS/COFINS não estão todos definidos: "
              CHR(13)+CHR(10)+"IT_BASEPS2 ==> "+cCpoBsPis+;
              CHR(13)+CHR(10)+"IT_VALPS2  ==> "+cCpoVlPis+;
              CHR(13)+CHR(10)+"IT_ALIQPS2 ==> "+cCpoAlPis+;
              CHR(13)+CHR(10)+"IT_ALIQCF2 ==> "+cCpoAlCof+;
              CHR(13)+CHR(10)+"IT_BASECF2 ==> "+cCpoBsCof+;
              CHR(13)+CHR(10)+"IT_VALCF2  ==> "+cCpoVlCof+;
              CHR(13)+CHR(10)+STR0421) //STR0421 "Favor entrar em contato com o Suporte da Microsiga p/ atualizacao dos campos referentes a MP 135."   
      RETURN .F.
   ENDIF
EndIf

Private lGeraNota := .F.  //JWJ - 26/10/2006

IF(Existblock("EICDI154"), Execblock("EICDI154",.F.,.F.,"NFE_INICIO"),)

IF SW6->W6_TIPOFEC = "DA" .AND. !lExecAuto  .And. !lGeraNota  //JWJ - 26/10/2006: Acrescentei o lGeraNota
   Help("",1,"AVG0000812")//"Nota Fiscal não pode gerada, Processo refere-se a uma D.A."
   RETURN .F.
ENDIF

PRIVATE aDBF_Stru:={{"WKCOD_I"   ,"C",AVSX3("W7_COD_I",3),0},;
                    {"WKFLAG"    ,"C",02,0},;
                    {"WKNROLI"   ,"C",LEN(SWP->WP_REGIST) ,0},;
                    {"WKFORN"    ,"C",LEN(SW7->W7_FORN)   ,0},;
                    {"WKNOME"    ,"C",LEN(SA2->A2_NOME)   ,0},; //TRP-26/10/07
                    {"WKFABR"    ,"C",LEN(SW7->W7_FABR)   ,0},;
                    {"WKACMODAL" ,"C",IF(lIntDraw,LEN(SW8->W8_AC),13),0},;
                    {"WKTEC"     ,"C",10,0},;
                    {"WKEX_NCM"  ,"C",LEN(SB1->B1_EX_NCM),0},;
                    {"WKEX_NBM"  ,"C",LEN(SB1->B1_EX_NBM),0},;
                    {"WK_CONDPAG","C",05,0},;
                    {"WK_DIASPAG","N",03,0},;
                    {"WKSEMCOBER","L",01,0},;// AWR 27/08/2004  - SEM COBERTURA
                    {"WKMOEDA"   ,"C",03,0},;
                    {"WKINCOTER" ,"C",03,0},;
                    {"WK_CFO"    ,"C",LEN(SWZ->WZ_CFO)    ,0},;
                    {"WK_OPERACA","C",LEN(SW7->W7_OPERACA),0},;
                    {"WKPGI_NUM" ,"C",10,0},;
                    {"WKLOJA"    ,"C",AVSX3("A2_LOJA",3),0},;
                    {"WKICMS_A"  ,"N",06,2},;
                    {"WKQTDE"    ,"N",18,7},;
                    {"WKPRECO"   ,"N",18,7},;
                    {"WKDESCR"   ,"C",60,0},;
                    {"WKUNI"     ,"C",03,0},;
                    {"WKREGTRII" ,"C",01,0},;
                    {"WKREGTRIPI","C",01,0},;
                    {"WKREGEVII" ,"N",15,2},;
                    {"WKVLDEVII" ,"N",15,2},;
                    {"WKVLDEIPI" ,"N",15,2},;
                    {"WKIPIVAL"  ,"N",18,7},;
                    {"WKIIVAL"   ,"N",18,2},;
                    {"WKPRUNI"   ,"N",18,7},;
                    {"WKVALMERC" ,"N",18,7},;
                    {"WKIPITX"   ,"N",06,2},;
                    {"WKIITX"    ,"N",06,2},;
                    {"WKPR_II"   ,"N",06,2},;
                    {"WKRATEIO"  ,"N",18,16},;
                    {"WKRATPESO" ,"N",18,16},;
                    {"WKRATQTDE" ,"N",18,16},;
                    {"WKVL_ICM"  ,"N",18,7},;
                    {"WKPESOL"   ,"N",AVSX3("WN_PESOL",3),AVSX3("WN_PESOL",4)},;
                    {"WKIPIBASE" ,"N",18,7},;
                    {"WKFOB"     ,"N",18,7},;
                    {"WKFOB_R"   ,"N",18,7},;
                    {"WKFOB_ORI" ,"N",18,7},;
                    {"WKFOBR_ORI","N",18,7},;
                    {"WKSEGURO"  ,"N",18,7},;
                    {"WKCIF"     ,"N",18,7},;
                    {"WKCIF_MOE" ,"N",18,7},;
                    {"WKOUT_DESP","N",18,7},;
                    {"WKOUT_D_US","N",18,7},;
                    {"WKFRETE"   ,"N",18,7},;
                    {"WKFRETEIN" ,"N",18,7},;
                    {"WKSI_NUM"  ,"C",AVSX3("W7_SI_NUM",3),0},;  //SO.:0026 OS.:0213/02
                    {"WKPO_NUM"  ,"C",15,0},;
                    {"WKADICAO"  ,"C",03,0},;
                    {"WKPO_SIGA" ,"C",AVSX3("C7_NUM",3),0},;   // Chamado: 055632 - TRP 12/07/07                                       
                    {"WKREC_ID"  ,"N",10,0},;
                    {"WK_CC"     ,"C",AVSX3("W7_CC",3),0},; //SO.:0026 OS.:0213/02
                    {"WK_NFE"    ,"C",AVSX3("D1_DOC",3),0},;
                    {"WK_NOTA"   ,"C",AVSX3("D1_DOC",3),0},;
                    {"WK_SE_NFE" ,"C",AVSX3("D1_SERIE",3),0},;
                    {"WK_DT_NFE" ,"D",08,0},;
                    {"WKSTATUS"  ,"C",01,0},;
                    {"WKLI"      ,"C",10,0},;
                    {"WKPOSICAO" ,"C",LEN(SW3->W3_POSICAO),0},;
                    {"WKPOSSIGA" ,"C",LEN(SW3->W3_POSICAO),0},; // RA - 24/10/03 - O.S. 1075/03
                    {"WK_REG"    ,"N",AVSX3("W1_REG",3),0},;
                    {"WKDTVALID" ,"D",08,0},;
                    {"WK_LOTE"   ,"C",LEN(SWV->WV_LOTE),0},;
                    {"WK_VLMID_M","N",18,7},;
                    {"WK_VLMID_R","N",18,7},;
                    {"WK_QTMID"  ,"N",18,7},;
                    {"WKINVOICE" ,"C",LEN(SW9->W9_INVOICE),0},;
                    {"WKOUTDESP" ,"N",AVSX3("W8_OUTDESP",3),AVSX3("W8_OUTDESP",4)},; 
                    {"WKINLAND"  ,"N",AVSX3("W8_INLAND" ,3),AVSX3("W8_INLAND" ,4)},;
                    {"WKPACKING" ,"N",AVSX3("W8_PACKING",3),AVSX3("W8_PACKING",4)},;
                    {"WKDESCONT" ,"N",AVSX3("W8_DESCONT",3),AVSX3("W8_DESCONT",4)},;
                    {"WKRDIFMID" ,"N",18,7},;
                    {"WKICMS_RED","N",09,6},;
                    {"WKICMSPC"  ,"N",09,6},;
                    {"WKUDIFMID" ,"N",18,7},;
                    {"WKDESPESA" ,"C",33,0},;
                    {"WKRECSW9"  ,"N",10,0},;
                    {"WKGRUPORT" ,"C",03,0},; // EOB - 02/06/08 - grupo do regime tributário
                    {"WKBASEICMS","N",18,7},;
                    {"WKDESPCIF" ,"N",18,7},;
                    {"WKRECMAE"  ,"N",10,0},;
                    {"WKQTDEUTIL","N",18,7},;
                    {"WKSLDDISP" ,"N",18,7},;
                    {"WKQTDEFILH","N",18,7}}

If EICLoja()
   AADD(aDBF_Stru,{"WKFABLOJ"  ,"C", AvSx3("A2_LOJA", AV_TAMANHO), 0})
EndIf
    
//FSM - 02/09/2011 - Peso Bruto Unitario
lPesoBruto := Type("lPesoBruto") == "L" .And. lPesoBruto
If lPesoBruto
   aAdd(aDBF_Stru,{"WKPESOBR"  ,AvSx3("W8_PESO_BR", AV_TIPO), AvSx3("W8_PESO_BR", AV_TAMANHO), AvSx3("W8_PESO_BR", AV_DECIMAL)})
EndIf

AADD(aDBF_Stru,{"WKVLUPIS"  ,"N",AVSX3("W8_VLUPIS",3),AVSX3("W8_VLUPIS",4)})
AADD(aDBF_Stru,{"WKBASPIS"  ,"N",18,7})
AADD(aDBF_Stru,{"WKPERPIS"  ,"N",06,2})
AADD(aDBF_Stru,{"WKREDPIS"  ,"N",06,2})
AADD(aDBF_Stru,{"WKVLRPIS"  ,"N",18,7})
AADD(aDBF_Stru,{"WKVLUCOF"  ,"N",AVSX3("W8_VLUCOF",3),AVSX3("W8_VLUCOF",4)})
AADD(aDBF_Stru,{"WKBASCOF"  ,"N",18,7})
AADD(aDBF_Stru,{"WKPERCOF"  ,"N",06,2})
AADD(aDBF_Stru,{"WKREDCOF"  ,"N",06,2})
AADD(aDBF_Stru,{"WKVLRCOF"  ,"N",18,7})
AADD(aDBF_Stru,{"WKDESPICM" ,"N",If(lTemDespBaseICM,AVSX3("WN_DESPICM",3),AVSX3("W8_OUTDESP",3)),;
                                 If(lTemDespBaseICM,AVSX3("WN_DESPICM",4),AVSX3("W8_OUTDESP",4))})
IF lAUTPCDI//ASR - 21/04/2006 - INICIO
   AADD(aDBF_Stru,{"WKVLDEPIS","N",AVSX3("W8_VLDEPIS",3),AVSX3("W8_VLDEPIS",4)})
   AADD(aDBF_Stru,{"WKVLDECOF","N",AVSX3("W8_VLDECOF",3),AVSX3("W8_VLDECOF",4)})
   // ** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
   AADD(aDBF_Stru,{"WKREG_PC",AVSX3("W8_REG_PC",AV_TIPO),AVSX3("W8_REG_PC",AV_TAMANHO),AVSX3("W8_REG_PC",AV_DECIMAL)})
   AADD(aDBF_Stru,{"WKFUN_PC",AVSX3("W8_FUN_PC",AV_TIPO),AVSX3("W8_FUN_PC",AV_TAMANHO),AVSX3("W8_FUN_PC",AV_DECIMAL)})
   AADD(aDBF_Stru,{"WKFRB_PC",AVSX3("W8_FRB_PC",AV_TIPO),AVSX3("W8_FRB_PC",AV_TAMANHO),AVSX3("W8_FRB_PC",AV_DECIMAL)})
   // **
ENDIF//ASR - 21/04/2006 - FIM
                                       
IF lVlUnid // LDR
   AADD(aDBF_Stru,{"WKQTDE_UM"  ,"N",13,3})
ENDIF

// Bete - 24/07/04 - Inclusao de Acrescimos e deducoes na base de impostos                                 
AADD(aDBF_Stru,{"WKVLACRES"  ,"N",18,7})
AADD(aDBF_Stru,{"WKVLDEDUC"  ,"N",18,7})                                 
AADD(aDBF_Stru,{"WKFOBRCOB"  ,"N",18,7})

If lICMS_Dif  // PLB 14/05/07 - ICMS diferido
   AAdd( aDBF_Stru, {"WKVLICMDEV", "N", 18, 07 } )	
   AAdd( aDBF_Stru, {"WKBASE_DIF", "N", 18, 07 } )
   AAdd( aDBF_Stru, {"WKVL_ICM_D", "N", 18, 07 } )
   AAdd( aDBF_Stru, {"WKVLCREPRE", "N", 18, 07 } ) // EOB - 16/02/09
EndIf
If lICMS_Dif2 // EOB - 16/02/09
   AAdd( aDBF_Stru, {"WK_PERCDIF", "N", AVSX3("WZ_ICMSDIF",AV_TAMANHO), AVSX3("WZ_ICMSDIF",AV_DECIMAL) } ) 
   AAdd( aDBF_Stru, {"WK_CRE_PRE", "N", AVSX3("WZ_ICMS_CP",AV_TAMANHO), AVSX3("WZ_ICMS_CP",AV_DECIMAL) } ) 
   AAdd( aDBF_Stru, {"WK_PCREPRE", "N", AVSX3("WZ_PCREPRE",AV_TAMANHO), AVSX3("WZ_PCREPRE",AV_DECIMAL) } )
   AAdd( aDBF_Stru, {"WK_PAG_DES", "N", AVSX3("WZ_ICMS_PD",AV_TAMANHO), AVSX3("WZ_ICMS_PD",AV_DECIMAL) } )
EndIf

//TRP - 25/01/07 - Campos do WalkThru
AADD(aDBF_Stru,{"TRB_ALI_WT","C",03,0})
AADD(aDBF_Stru,{"TRB_REC_WT","N",10,0})
// ** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
AADD(aDBF_Stru,{"WKFUNREG",AVSX3("EIJ_FUNREG",AV_TIPO),AVSX3("EIJ_FUNREG",AV_TAMANHO),AVSX3("EIJ_FUNREG",AV_DECIMAL)})
AADD(aDBF_Stru,{"WKMOTADI",AVSX3("EIJ_MOTADI",AV_TIPO),AVSX3("EIJ_MOTADI",AV_TAMANHO),AVSX3("EIJ_MOTADI",AV_DECIMAL)})
AADD(aDBF_Stru,{"WKTACOII",AVSX3("W8_TACOII",AV_TIPO),AVSX3("W8_TACOII",AV_TAMANHO),AVSX3("W8_TACOII",AV_DECIMAL)})
AADD(aDBF_Stru,{"WKACO_II",AVSX3("W8_ACO_II",AV_TIPO),AVSX3("W8_ACO_II",AV_TAMANHO),AVSX3("W8_ACO_II",AV_DECIMAL)})
AADD(aDBF_Stru,{"WKNVE",AVSX3("W8_NVE",AV_TIPO),AVSX3("W8_NVE",AV_TAMANHO),AVSX3("W8_NVE",AV_DECIMAL)})
// **
IF lExisteSEQ_ADI// AWR - 18/09/08 - NFE
   Aadd(aDBF_Stru,{"WKSEQ_ADI","C",LEN(SW8->W8_SEQ_ADI),0})
EndIf

IF lMV_GRCPNFE//Campos novos NFE - AWR 06/11/2008
   Aadd(aDBF_Stru,{"WKDESPADU","N",AVSX3("WN_DESPADU",AV_TAMANHO),AVSX3("WN_DESPADU",AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKALUIPI" ,"N",AVSX3("WN_ALUIPI" ,AV_TAMANHO),AVSX3("WN_ALUIPI" ,AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKQTUIPI" ,"N",AVSX3("WN_QTUIPI" ,AV_TAMANHO),AVSX3("WN_QTUIPI" ,AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKQTUPIS" ,"N",AVSX3("WN_QTUPIS" ,AV_TAMANHO),AVSX3("WN_QTUPIS" ,AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKQTUCOF" ,"N",AVSX3("WN_QTUCOF" ,AV_TAMANHO),AVSX3("WN_QTUCOF" ,AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKPREDICM","N",AVSX3("WN_PREDICM",AV_TAMANHO),AVSX3("WN_PREDICM",AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKDESCONI","N",AVSX3("WN_DESCONI",AV_TAMANHO),AVSX3("WN_DESCONI",AV_DECIMAL)})
   Aadd(aDBF_Stru,{"WKVLRIOF" ,"N",AVSX3("WN_VLRIOF" ,AV_TAMANHO),AVSX3("WN_VLRIOF" ,AV_DECIMAL)})
ENDIF

//DFS - 14/02/11 - Inclusão de campos na work para tratamento de diferenciação de numeração de nota fiscal
Aadd(aDBF_Stru,{"WKNOTAOR"  ,"C",AVSX3("WN_DOC"   ,AV_TAMANHO),AVSX3("WN_DOC",AV_DECIMAL)})
Aadd(aDBF_Stru,{"WKSERIEOR" ,"C",AVSX3("WN_SERIE" ,AV_TAMANHO),AVSX3("WN_SERIE" ,AV_DECIMAL)})
   
IF lPCBaseICM
   Aadd(aDBF_Stru,{"WKPCBsICM" ,"C",AVSX3("WZ_PC_ICMS" ,AV_TAMANHO),AVSX3("WZ_PC_ICMS" ,AV_DECIMAL)})
ENDIF

IF lCposPtICMS                                                           //NCF - 11\05\2011 - Inclui o campo de ICMS devido para tratamento de ICMS de Pauta
   IF ( nPos := aScan(aDBF_Stru, {|x| x[1] == "WKVLICMDEV"}) ) == 0
      AAdd( aDBF_Stru, {"WKVLICMDEV", "N", 18, 07 } )   
   ENDIF 
ENDIF

If lCposCofMj                                                            //NCF - 20/07/2012 - Majoração COFINS
   AADD(aDBF_Stru,{"WKALCOFM"  ,"N",06,2})                                                            
   AADD(aDBF_Stru,{"WKVLCOFM"  ,"N",18,7})
EndIf

If lCposPisMj                                                            //GFP - 11/06/2013 - Majoração PIS
   AADD(aDBF_Stru,{"WKALPISM"  ,"N",06,2})                                                            
   AADD(aDBF_Stru,{"WKVLPISM"  ,"N",18,7})
EndIf

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ADD_ESTRU_WORK1"),)

PRIVATE aDBF_Stru2:={{"WKICMS_A"  ,"N",06,2},;
                     {"WKADICAO"  ,"C",03,0},;
                     {"WKCOD_AD"  ,"C",03,0},; // AWR - 31/08/2004
                     {"WKNROLI"   ,"C",LEN(SWP->WP_REGIST) ,0},;
                     {"WKFORN"    ,"C",LEN(SW7->W7_FORN)   ,0},;
                     {"WKNOME"    ,"C",LEN(SA2->A2_NOME)   ,0},; //TRP-26/10/07
                     {"WKFABR"    ,"C",LEN(SW7->W7_FABR)   ,0},;
                     {"WKTEC"     ,"C",10,0},;
                     {"WKEX_NCM"  ,"C",LEN(SB1->B1_EX_NCM) ,0},;
                     {"WKEX_NBM"  ,"C",LEN(SB1->B1_EX_NBM) ,0},;
                     {"WK_CONDPAG","C",LEN(SW9->W9_COND_PA),0},;
                     {"WK_DIASPAG","N",03,0},;
                     {"WKMOEDA"   ,"C",03,0},;
                     {"WKINCOTER" ,"C",03,0},;
                     {"WKACMODAL" ,"C",IF(lIntDraw,LEN(SW8->W8_AC),13),0},;
                     {"WK_CFO"    ,"C",LEN(SWZ->WZ_CFO)    ,0},;
                     {"WK_OPERACA","C",LEN(SW7->W7_OPERACA),0},;
                     {"WKPESOL"   ,"N",AVSX3("WN_PESOL",3),AVSX3("WN_PESOL",4)},;
                     {"WKPESOSMID","N",AVSX3("WN_PESOL",3),AVSX3("WN_PESOL",4)},;
                     {"WKFOB"     ,"N",18,7},;
                     {"WKFOB_R"   ,"N",18,7},;
                     {"WKFRETE"   ,"N",18,7},;
                     {"WKFRETESMI","N",18,7},;
                     {"WKFOB_ORI" ,"N",18,7},;
                     {"WKFOBR_ORI","N",18,7},;
                     {"WKCIF_MOE" ,"N",18,7},;
                     {"WKSEGURO"  ,"N",18,7},;
                     {"WKCIF"     ,"N",18,7},;
                     {"WKII"      ,"N",18,7},;
                     {"WKBASEIPI" ,"N",18,7},;//ISS Inclusão da coluna "Base I.P.I. (R$)"
                     {"WKIPI"     ,"N",18,7},;
                     {"WKBASEICMS","N",18,7},;//ISS Inclusão da coluna "Base I.C.M.S. (R$)"
                     {"WKICMS"    ,"N",18,7},;
                     {"WKOUTRDESP","N",18,7},;
                     {"WKOUTRD_US","N",18,7},;
                     {"WKII_A"    ,"N",06,2},;
                     {"WK_NF_COMP","C",AVSX3("D1_DOC",3),0},;
                     {"WK_SE_NFC" ,"C",AVSX3("D1_SERIE",3),0},;
                     {"WK_DT_NFC" ,"D",08,0},;
                     {"WKIPI_A"   ,"N",06,2},;
                     {"WKICMS_RED","N",09,6},;
                     {"WKICMSPC"  ,"N",09,6},;
                     {"WKRED_CTE" ,"N",09,6},;
                     {"WKRDIFMID" ,"N",18,7},;
                     {"WKQTDE"    ,"N",18,7},;
                     {"WKUDIFMID" ,"N",18,7},;
                     {"WKSOMACIF" ,"N",18,7},; //  Jonato em 23/03/2003 para corrigir diferença de centavos no valor base CIF e valor base despesa ICMS
                     {"WKSOMAICM" ,"N",18,7},; //  Jonato em 23/03/2003 para corrigir diferença de centavos no valor base CIF e valor base despesa ICMS
                     {"WKPERPIS"  ,"N",06,2},;
                     {"WKPERCOF"  ,"N",06,2},;
                     {"WKREDPIS"  ,"N",06,2},;
                     {"WKREDCOF"  ,"N",06,2},;
                     {"WKVLUPIS"  ,"N",18,7},;
                     {"WKVLUCOF"  ,"N",AVSX3("W8_VLUCOF",3),AVSX3("W8_VLUCOF",4)},;
                     {"WKBASPIS"  ,"N",18,7},;
                     {"WKBASCOF"  ,"N",18,7},;
                     {"WKVLRPIS"  ,"N",18,7},;
                     {"WKVLRCOF"  ,"N",18,7}}

If EICLoja()
   AADD(aDBF_Stru2, {"WKLOJA"  ,"C", AvSx3("A2_LOJA", AV_TAMANHO), 0})
   AADD(aDBF_Stru2, {"WKFABLOJ"  ,"C", AvSx3("A2_LOJA", AV_TAMANHO), 0})
EndIf

// Bete - 24/07/04 - Inclusao de Acrescimos e deducoes na base de impostos                                 
AADD(aDBF_Stru2,{"WKVLACRES"  ,"N",18,7})
AADD(aDBF_Stru2,{"WKVLDEDUC"  ,"N",18,7})                       
AADD(aDBF_Stru2,{"WKFOBRCOB"  ,"N",18,7})
AADD(aDBF_Stru2,{"WKVLACRFT"  ,"N",18,7})  //NCF - 23/07/2010 - Campo para ratear acrescimos de despesas de frete por peso

// TRP - 25/01/07 - Campos do WalkThru
AADD(aDBF_Stru2,{"TRB_ALI_WT","C",03,0})
AADD(aDBF_Stru2,{"TRB_REC_WT","N",10,0})
// ** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
AADD(aDBF_Stru2,{"WKFUNREG ",AVSX3("EIJ_FUNREG ",AV_TIPO),AVSX3("EIJ_FUNREG ",AV_TAMANHO),AVSX3("EIJ_FUNREG ",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKMOTADI ",AVSX3("EIJ_MOTADI ",AV_TIPO),AVSX3("EIJ_MOTADI ",AV_TAMANHO),AVSX3("EIJ_MOTADI ",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKTACOII ",AVSX3("W8_TACOII ",AV_TIPO),AVSX3("W8_TACOII ",AV_TAMANHO),AVSX3("W8_TACOII ",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKACO_II ",AVSX3("W8_ACO_II ",AV_TIPO),AVSX3("W8_ACO_II ",AV_TAMANHO),AVSX3("W8_ACO_II ",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKREGTRII",AVSX3("W8_REGTRI ",AV_TIPO),AVSX3("W8_REGTRI ",AV_TAMANHO),AVSX3("W8_REGTRI ",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKTAXASIS",AVSX3("W8_TAXASIS",AV_TIPO),AVSX3("W8_TAXASIS",AV_TAMANHO),AVSX3("W8_TAXASIS",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKNVE",AVSX3("W8_NVE",AV_TIPO),AVSX3("W8_NVE",AV_TAMANHO),AVSX3("W8_NVE",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKREG_PC",AVSX3("W8_REG_PC",AV_TIPO),AVSX3("W8_REG_PC",AV_TAMANHO),AVSX3("W8_REG_PC",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKFUN_PC",AVSX3("W8_FUN_PC",AV_TIPO),AVSX3("W8_FUN_PC",AV_TAMANHO),AVSX3("W8_FUN_PC",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKFRB_PC",AVSX3("W8_FRB_PC",AV_TIPO),AVSX3("W8_FRB_PC",AV_TAMANHO),AVSX3("W8_FRB_PC",AV_DECIMAL)})
AADD(aDBF_Stru2,{"WKREGTRIPI",AVSX3("W8_REGIPI",AV_TIPO),AVSX3("W8_REGIPI",AV_TAMANHO),AVSX3("W8_REGIPI",AV_DECIMAL)})
// **

If lCposCofMj                                                            //NCF - 20/07/2012 - Majoração COFINS
   AADD(aDBF_Stru2,{"WKALCOFM"  ,"N",06,2})                                                            
   AADD(aDBF_Stru2,{"WKVLCOFM"  ,"N",18,7})
EndIf
If lCposPisMj                                                            //GFP - 11/06/2013 - Majoração PIS
   AADD(aDBF_Stru2,{"WKALPISM"  ,"N",06,2})                                                            
   AADD(aDBF_Stru2,{"WKVLPISM"  ,"N",18,7})
EndIf
PRIVATE aDBF_Stru3:={{"WKRECNO"   ,"N",10,0},;//PRIVATE POR CAUSA DA MERCK
                     {"WKDESPESA" ,"C",33,0},;
                     {"WKVALOR"   ,"N",18,7},;
                     {"WKVALOR_US","N",18,7},;
                     {"WK_NF_COMP","C",AVSX3("D1_DOC",3),0},;
                     {"WK_SE_NFC" ,"C",AVSX3("D1_SERIE",3),0},;
                     {"WK_DT_NFC" ,"D",08,0},;
                     {"WKPO_NUM"  ,"C",15,0},;
                     {"WKPOSICAO" ,"C",LEN(SW3->W3_POSICAO),0},;
                     {"WK_LOTE"   ,"C",LEN(SWV->WV_LOTE),0},;
                     {"WKPGI_NUM" ,"C",10,0}}//PRIVATE POR CAUSA DA MERCK

TB_Campos1:={}

nOldArea:=SELECT()

PRIVATE PICT15_8:= '@E 999,999.99999999'
PRIVATE PICT15_2:= '@E 999,999,999,999.99'
PRIVATE PICT06_2:= '@E 999.99'
PRIVATE PICT1816:= '@E 9.9999999999999999'
PRIVATE PICT21_8:= _PictPrUn//'@E 999,999,999,999.9999'
PRIVATE PICTICMS:= AVSX3("YD_ICMS_RE",6)
//PRIVATE PICTPesoT:= AVSX3("WN_PESOL",6)
//PRIVATE PICTPesoI:= AVSX3("WN_PESOL",6)
PRIVATE PICTPesoT:= AVSX3("EIJ_PESOL",6)//ACB - 22/03/2011
PRIVATE PICTPesoI:= AVSX3("EIJ_PESOL",6)//ACB - 22/03/2011

PRIVATE lDisable:=.F., lGerouNFE:=.F.,TB_Campos2:={},nOpca := 0
IF TYPE("cMarca") = "U"
   PRIVATE cMarca := GetMark()
ENDIF
PRIVATE lInverte := .F., nContProc:= 0
PRIVATE nTipoNF := nOpc

If lMV_NF_MAE // TDF - 25/03/10
   If(nOpc = 7, nTipoNF:=nOpc-3,If(nOpc!=5 .And. nOpc!=6,nTipoNF:=nOpc-1,nTipoNF:=nOpc))
Else
   nTipoNF:=nOpc-1
EndIf

PRIVATE tDI_II:=0, tDI_IPI:=0, tDI_ICMS:=0, n_II:=0, n_ValM:=0, n_TotNFE:=0,;
        n_IPI :=0, n_ICMS :=0, n_CIF:=0 , n_PIS :=0, n_COFINS:=0

PRIVATE DESPESA_FRETE:=GetMV("MV_D_FRETE"),DESPESA_SEGURO:=GetMV("MV_D_SEGUR"),;
        DESPESA_II   :=GetMV("MV_D_II"),   DESPESA_IPI   :=GetMV("MV_D_IPI"),;
        DESPESA_ICMS :=GetMV("MV_D_ICMS") ,DESPESA_PIS:="204",DESPESA_COF:="205"

PRIVATE nFob:=0,nFobTot:=0,nPesoL:=0,nPesoB:=0,;
        aNBMm:={}

PRIVATE bDifere:={ |vDI,vNBM,tit| DI154MsgDif(.F.,vDI,vNBM,tit) },lComDiferenca:=.F.

PRIVATE oSayTotGe,aLista:={}

PRIVATE cDI_FOB, nFob_R:=0, n_Frete:=0, n_Seguro:=0

PRIVATE cNumNFE, cSerieNFE, dDtNFE

PRIVATE lNFAutomatica  :=ALLTRIM(GETMV("MV_NF_AUTO")) $ cSim
PRIVATE lQuebraOperacao:=ALLTRIM(GETMV("MV_QB_OPER",,"N")) $ cSim  //igor chiba  05/05/09
//PRIVATE lQuebraOperacao:=ALLTRIM(GETMV("MV_QB_OPER")) $ cSim  05/05/09

PRIVATE cQbrACModal    :=GETMV("MV_QBACMOD",,"1")
PRIVATE cFilEIJ:=xFilial("EIJ")
PRIVATE cFilSW9:=xFilial("SW9")

PRIVATE lTipoDiv     := (nTipoNF=2 .Or. nTipoNF=6)//(nopc==2) // Jonato Trevo // AWR
PRIVATE lImpostos    :=.F.  // calcula impostos (II,IPI e ICMS)  Bete 24/11 - Trevo
PRIVATE lOut_Desp    :=.F.  // inclui despesas na Nota           Bete 24/11 - Trevo
PRIVATE lICMSCompl   :=.F.  // Calcula ICMS na nota complementar Bete 24/11 - Trevo
PRIVATE lDespNProc   :=.F.  // Pega as despesas que nao foram processadas Bete 24/11 - Trevo
PRIVATE lApuraCIF    :=.F.  // Apura Fob, frete, seguro, CIF     Bete 24/11 - Trevo
//PRIVATE lDifCamb     :=.F.  // calcula diferenca cambial         Bete 24/11 - Trevo  // RRV - 25/02/2013
PRIVATE lGrvItem     :=.F.  // grava dados dos itens nos arq.de nota    Bete 24/11 - Trevo
PRIVATE lAtuSW6NFE   :=.F.  // atualiza cpos do SW6 ref. NFE     Bete 24/11 - Trevo
PRIVATE lTipoCompl   :=.F.  // trata particularidade da NF complementar Bete 24/11 - Trevo
PRIVATE cTit:=""            // JONATO 24/11 - Trevo 
PRIVATE lDIVazia     :=.F.  // Bete 26/11 - Trevo
PRIVATE Work_file           // LDR  26/11 - Trevo
PRIVATE nFob_Tot_Inv := 0   // Bete 26/11 - Trevo 
PRIVATE lGravaSWW    := .T. // Bete 09/06 - grava as despesas no SWW
PRIVATE lSoDespBase  := .F. // Bete 09/06 - grava no SWW somente as despesas que sao base de Impostos ou ICMS
PRIVATE lTemItSemCob := .F. // AWR 30/08/04 - Itens sem Cobertura
PRIVATE nTotNFC      := 0   // ACL 10/06/05
PRIVATE lDI154Rateio := .T. // TLM 15/10/07
PRIVATE cCpoInd      := "WKCOD_I"//JVR - 29/03/10 - atualizado o conteudo do index para WKCOD_I //'A'"   // TLM 24/06/08
PRIVATE aICMS_Dif    := {}  // EOB 16/02/09
Private lTemNFT             // By JPP - 24/07/2009  - 16:00
Private lFilha       := .F.
Private lRet_Ok // By JPP - 28/04/2010
Private lExitPE := .F.  // GFP - 31/01/2013 
Private aCposWork4 := {}      // GFP - 28/06/2013 - Variavel para ponto de entrada.

Private lEstornoPE := .T. //LBL - 13/06/2013
Private lAcresDeducPE := .T.//LBL - 13/06/2013   
Private lGeraINPE := .T. //LBL - 13/06/2013 
Private lAlteraAdicaoPE := .T. //LBL - 13/06/2013
Private lAlteraItemPE := .T.//LBL - 13/06/2013 
Private lBotaoPE := .T. //LBL - 13/06/2013

SYT->(DBSETORDER(1))
SYT->(dBSeek(xFilial("SYT")+SW6->W6_IMPORT))
cCpoBasICMS:="YB_ICMS_"+SYT->YT_ESTADO
lTemYB_ICM_UF:=SYB->(FIELDPOS(cCpoBasICMS)) # 0

SW7->(DbSeek(xFilial("SW7")+SW6->W6_HAWB))

lCurrier   := SW6->W6_CURRIER $ cSim
lGravaWorks:=.F.
lTemComplem:=.F.
lNaoTemComp:=.T.
lTemPauta  :=.F.
cNota      :=''
cMoeDolar  :=BuscaDolar()//GetMV("MV_SIMB2")
cMoeDolar  :=IF(EMPTY(cMoeDolar),"US$",cMoeDolar)
lRatFretePorFOB:=lRatFreQtde:=.F.//Variavel usada no rdmake para o Mercosul
SWZ->(DBSETORDER(2))
SWN->(DBSETORDER(2))
SF1->(DBSETORDER(5))
EI1->(DBSETORDER(1))
EIJ->(DBSETORDER(1))
Private lTemFilha    := SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"6"))
Private lTemPrimeira := SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"1")) .Or. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"5"))
Private cPrimNota    := SF1->(F1_DOC+F1_SERIE)
Private lTemCusto    := EI1->(DBSEEK(xFilial("EI1")+SW6->W6_HAWB))

IF nTipoNF == NFE_PRIMEIRA .Or. (lMV_NF_MAE .And. nTipoNF == NFE_MAE)
   lImpostos    := .T.
   lApuraCIF    := .T.
   lGrvItem     := .T.      
   lAtuSW6NFE   := .T.
   lSoDespBase  := .T.

ELSEIF nTipoNF == NFE_COMPLEMEN
   lOut_Desp    := .T.
   lICMSCompl   := .T.
   lDespNProc   := .T.     
   lDifCamb     := SUBSTR(GetMV("MV_EIC0025",,"SSSS"),1,1) $ cSim //RRV - 25/02/2013
   lTipoCompl   := .T.
   
ELSEIF nTipoNF == NFE_UNICA .OR. nTipoNF == CUSTO_REAL
   lImpostos    := .T.
   lOut_Desp    := .T.
   lApuraCIF    := .T.
   If nTipoNF == NFE_UNICA
      lDifCamb  := SUBSTR(GetMV("MV_EIC0025",,"SSSS"),2,1) $ cSim //RRV - 25/02/2013       		
   Else
      lDifCamb  := SUBSTR(GetMV("MV_EIC0025",,"SSSS"),3,1) $ cSim //RRV - 25/02/2013
   Endif
   lGrvItem     := .T.   
   IF nTipoNF == NFE_UNICA
      lAtuSW6NFE := .T.   
   ENDIF
ELSEIF nTipoNF = NF_TRANSFENCIA// AWR - 02/02/09 - NFT
   lImpostos    := .T.
   lOut_Desp    := .T.
   lApuraCIF    := .T.
   lDifCamb  := SUBSTR(GetMV("MV_EIC0025",,"SSSS"),4,1) $ cSim //RRV - 25/02/2013   
   lGrvItem     := .T.
   lMV_PIS_EIC  := If(GetMv("MV_EIC0027",,.F.),.T.,.F.)   // GFP - 27/03/2013   
   lMV_GRCPNFE  := .F.
   lAcresDeduc  := .F.
   lIntDraw     := .F.
ELSEIF (lMV_NF_MAE .And. nTipoNF == NFE_FILHA)
   lFilha       := .T.
   lGrvItem     := .T. 
   If GetMV("MV_NFFILHA",,"0") == "0"
      lImpostos    := .F.
   Else
      lImpostos    := .T.
   Endif
   lApuraCIF    := .T.
ENDIF
                                                                            
lLoop := .F.   // Bete 05/12 - Trevo     

aOrdSF1 := SaveOrd({"SF1"}) 

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"INICIA_VARIAVEIS"),)
lTemNFT:=.F. // By JPP - 24/07/2009 - 16:00 - Inclusão dos tratamentos para gerar nota fiscal complementar de transferência de posse. 
             // Se existir nota fiscal de transferência de posse, a variável lTemNFT passará a ser .T.
             // As alterações serão realizadas pela função AvStAction("205",.F.) que rodará a função U_EICPOCO passando como parâmetro a ação "205".

//AvStAction("205",.F.)//AWR 17/03/2009
//OAP - Substituição da chamda feita no antigo EICPOCO.
IF GETMV("MV_EIC_PCO",,.F.) //Importação por Conta e Ordem
   
   IF !lExecAuto .AND. !lSoGravaNF .AND. !GETMV("MV_PCOIMPO",,.T.) .AND. !EMPTY(SW6->W6_IMPCO)//Se for importador é .T., e Adquirente é .F.
      IF nTipoNF == NFE_PRIMEIRA .OR. nTipoNF == NFE_UNICA .OR. (lMV_NF_MAE .And. nTipoNF == NFE_MAE)
         IF SW6->W6_IMPCO == '1'
            MSGINFO(STR0422) //STR0422 "Processo Por Conta e Ordem nao pode gerar NFE."
            lLoop:=.T.
         ENDIF
      ELSE            
      // By JPP - 24/07/2009 - 16:00 - Inclusão dos tratamentos para gerar nota fiscal complementar de transferência de posse. 
         SF1->(DbSetOrder(5))
         lTemNFT:=SF1->(DbSeek(xFilial("SF1")+SW6->W6_HAWB+"9")) 
         RestOrd(aOrdSF1)
      ENDIF
   ENDIF
ENDIF

IF lLoop       // Bete 05/12 - Trevo
   RETURN .F.
ENDIF

IF SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+STR(nTipoNF,1,0))) .OR.;   // Bete 24/11 - Trevo
   (nTipoNF == CUSTO_REAL .AND. EI1->(DBSEEK(xFilial("EI1")+SW6->W6_HAWB)) .AND. EI1->EI1_TIPO_NF = "4" )

   IF (nTipoNF==NFE_PRIMEIRA .OR. nTipoNF==NFE_UNICA .Or. (lMV_NF_MAE .And. nTipoNF == NFE_MAE)) .AND.;
      SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"2"))
      lTemComplem:=.T.
   ENDIF
   
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"VER_COMPLEMENTAR"),)  // Bete 23/11 - Trevo
   
   SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+STR(nTipoNF,1,0)))   // Bete 24/11 - Trevo
   lGravaWorks:=.T.
   cNota :=SF1->F1_CTR_NFC//Nota + Serie
ELSEIF !lSoGravaNF// AWR - 02/02/09 - So Grava a NF
   IF nTipoNF==NFE_PRIMEIRA .OR. nTipoNF==NFE_UNICA .Or. (lMV_NF_MAE .And. nTipoNF == NFE_MAE)
      IF !Empty(SW6->W6_NF_ENT) 
         IF nTipoNF==NFE_PRIMEIRA .AND. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB + "3"))
            Help("",1,"AVG0000800")//"Processo possui Nota Fiscal Unica"###"Atenção"
            RETURN .F.
         ELSEIF (nTipoNF==NFE_PRIMEIRA .OR. nTipoNF==NFE_UNICA) .AND. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB + "5"))
            Alert(STR0302)
            RETURN .F.
         ELSEIF (nTipoNF==NFE_UNICA .OR. (lMV_NF_MAE .And. nTipoNF==NFE_MAE) .OR. (lMV_NF_MAE .And. nTipoNF==NFE_FILHA)) .AND. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB + "1"))
            Help("",1,"AVG0000801")//"Processo possui Primeira Nota Fiscal"###"Atenção"
            RETURN .F.
         ELSEIF ((lMV_NF_MAE .And. nTipoNF==NFE_MAE) .OR. (lMV_NF_MAE .And. nTipoNF==NFE_FILHA)) .And. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB + "3"))
            Help("",1,"AVG0000800")
            RETURN .F.
         ENDIF
      ENDIF
ELSEIF nTipoNF==NFE_COMPLEMEN
   IF !SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"1")) .AND.;// Bete 30/11 - Trevo
      !SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"3")) .AND.;
      !SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"5")) .AND. !lTemNFT
      Help(" ",1,"DI154NOTA1")//"Processo nao possui Nota Fiscal de Entrada"###"Atenção"
      RETURN .F.
   ElseIf SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"3")) .AND. lNaoNFCompl      //TRP-31/07/08
      Help(" ",1,"AVG0000800")//"Processo possui Nota Fiscal Unica"###"Atenção"
      RETURN .F.         
   ENDIF
   lNaoTemComp:=!SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"3"))
ELSEIF (lMV_NF_MAE .And. nTipoNF==NFE_FILHA)
   IF !SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"5")) .And. !SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"3")) .And. !SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+"1")) //SVG - 07/04/2011 - Nota fiscal filha a partir da nota primeira , unica ou mãe.
      MSGINFO(STR0300) //"Conhecimento não Possui Nota Mãe."
      Return .F.
   ENDIF

ENDIF 
    
   lLoop := .F.   // Bete 28/11 - Trevo      
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"VER_NOTA_SF1"),)   // Bete 23/11 - Trevo
   IF lLoop       // Bete 28/11 - Trevo
      RETURN .F.
   ENDIF
ENDIF

IF lCalcImpAuto  // EOS
   lGravaWorks := .F.
ENDIF

IF lSoGravaNF// AWR - 02/02/09 - So Grava a NF
   lGravaWorks := .T.
ENDIF

lLerNota:=GETMV("MV_LERNOTA",,.F.) .AND. nTipoNF = CUSTO_REAL .AND.;
          !lGravaWorks .AND. (SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+'1')) .Or.;
           SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+'3')) .Or.;
           SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+'5')))

IF !lGravaWorks
   IF !lDiVazia .AND. EMPTY(SW6->W6_DI_NUM) .AND. !lExecAuto .AND. !lCurrier   // Bete 26/11 - Trevo
      Help(" ",1,"DI154SEMDI")//"Processo nao possui D.I.                      // NCF - 19/10/2009 - adicionada a verificação de Currier para validação
      RETURN .F.                                                               //                    da mensagem.
   ENDIF
   // SVG - 13/05/2010 -
   If lCurrier .And. Empty(SW6->W6_DIRE) .And. (Empty(SW6->W6_DT_DESE) .Or. Empty(SW6->W6_LOCAL))//FDR - 08/08/12 - Incluso na validação campo do DIRE
      MsgInfo(STR0305)
      Return .F.
   EndIf
   
   SW8->(DBSETORDER(1))
   SW9->(DBSETORDER(3))
   IF !SW8->(DBSEEK(xFilial("SW8")+SW6->W6_HAWB)) .OR.;
      !SW9->(DBSEEK(xFilial("SW9")+SW6->W6_HAWB))
      Help("",1,"AVG0000813")//"Nota Fiscal nao pode ser gerada, Processo nao possui Invoices.",STR0022)
      RETURN .F.
   ENDIF

   SW9->(DBSETORDER(3))
   SW9->(DbSeek(cFilSW9+SW6->W6_HAWB))
   DO WHILE ! SW9->(EOF()) .AND. SW9->W9_FILIAL == cFilSW9 .AND.;
	                              SW9->W9_HAWB == SW6->W6_HAWB
//    IF EMPTY(SW9->W9_TX_FOB) .AND. !lExecAuto
      nTx_FOB := DI154TaxaFOB()
	  IF EMPTY(nTx_FOB) .AND. !lExecAuto   // Bete 26/11 - Trevo
          Help("",1,"AVG0000814")//("Existem Invoices sem Taxa FOB.",STR0022)
          RETURN .F.
      ENDIF

	  IF SW9->W9_TUDO_OK = "2"
         Help("",1,"AVG0000815")//"Os valores da Invoice nao estao corretos",AVSX3("W9_INVOICE",5)+": "+SW9->W9_INVOICE)
	     RETURN .F.
	  ENDIF

	  SW9->(DBSKIP())
   ENDDO
ENDIF

aNFsCompCtr:={}

/* Jonato Trevo
IF nTipoNF == NFE_COMPLEMEN .AND. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+STR(nTipoNF,1,0)))//!Empty(SW6->W6_NF_COMP)
*/

IF lTipoDiv  .AND. SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+STR(nTipoNF,1,0)))  // Bete 24/11 - Trevo
   lGravaWorks:=.F.
   aNFsComp   :={}
   TB_Campos  :={}
   AADD(TB_CAMPOS,{{||WorkNF->F1_DOC+" "+WorkNF->F1_SERIE},,(STR0027)}) //"N§ Nota Fiscal"
   AADD(TB_CAMPOS,{"F1_FORNECE" ,,STR0084}) //"Fornecedor"
   AADD(TB_CAMPOS,{"F1_EMISSAO" ,,STR0029}) //"Data NF"
// AADD(TB_CAMPOS,{"F1_DESPESA" ,,STR0030,AVSX3("F1_DESPESA")[6]}) //"Valor NF"

   aCampos:={"F1_DOC","F1_SERIE","F1_EMISSAO","F1_DESPESA","F1_CTR_NFC","F1_FORNECE","F1_LOJA"}
   aSemSX3:={}
   //TRP - 25/01/07 - Campos do WalkThru
   AADD(aSemSX3,{"TRB_ALI_WT","C",03,0})
   AADD(aSemSX3,{"TRB_REC_WT","N",10,0})
   
   WorkNFile:=E_CriaTrab(,aSemSX3,"WorkNF")
        
   bWhi:={||SF1->F1_TIPO_NF == STR(nTipoNF,1,0) .AND. SF1->F1_HAWB == SW6->W6_HAWB}   // Bete 24/11 - Trevo

   bFor:={||IncProc(STR0273+' '+SF1->F1_DOC),ASCAN(aNFsComp,{|N|N[1]==SF1->F1_DOC.AND.N[2]==SF1->F1_SERIE.AND.N[6]==SF1->F1_FORNECE})=0} //"Lendo Despesa: "

   bGrv:={||ProcRegua(SF1->(LASTREC())),;
   SF1->(DBEVAL({||AADD(aNFsComp,{SF1->F1_DOC,SF1->F1_SERIE,SF1->F1_EMISSAO,SF1->F1_DESPESA,SF1->F1_CTR_NFC,SF1->F1_FORNECE,SF1->F1_LOJA})},;
                bFor,bWhi))}

   SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+STR(nTipoNF,1,0)))
   SA2->(DbSeek(xFilial("SA2")+SF1->F1_FORNECE)) // RHP

   Processa(bGrv,STR0031) //"Processando..."

   FOR I:= 1 TO LEN(aNFsComp)
       WorkNF->(DBAPPEND())
       WorkNF->F1_DOC     :=aNFsComp[I][1]
       WorkNF->F1_SERIE   :=aNFsComp[I][2]
       WorkNF->F1_EMISSAO :=aNFsComp[I][3]
//     WorkNF->F1_DESPESA :=aNFsComp[I][4]
       WorkNF->F1_CTR_NFC :=aNFsComp[I][5]
       IF ASCAN(aNFsCompCtr,aNFsComp[I][5])=0
          AADD (aNFsCompCtr,aNFsComp[I][5])
       ENDIF
       WorkNF->F1_FORNECE :=aNFsComp[I][6]
       WorkNF->F1_LOJA    :=aNFsComp[I][7]
       WorkNF->TRB_ALI_WT := "SF1"
       WorkNF->TRB_REC_WT := SF1->(Recno())
       IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRV_WORKNF"),) // Ricardo Dumbrovsky 08/12/04 15:45
   NEXT

   nOpca:=0
   WorkNF->(DBGOTOP())
   
   DEFINE MSDIALOG oDlg TITLE STR0032 FROM 5,5 TO 22,55 Of oMainWnd //"Nota Fiscal"
      @ 00,00 MsPanel oPanel Prompt "" Size 60,20 of oDlg
      @4.2,24 BUTTON STR0033  SIZE 38,12 ACTION (nOpca:=2,oDlg:End()) OF oPanel Pixel //"&Inclui"

      @4.2,140 BUTTON STR0034 SIZE 38,12 ACTION (nOpca:=1,oDlg:End()) OF oPanel Pixel//"&Estorna"
      
/* SVG - 24/05/2011 - Não se trata de work especifica da tabela, o que ocasiona erros devido a campos de usuario não inseridos na work.
      //by GFP - 29/09/2010 :: 14:23 - Inclusão da função para carregar campos criados pelo usuario.
      TB_Campos := AddCpoUser(TB_Campos,"SF1","2")
*/
      oMarkNF:=MsSelect():New("WorkNF",,,TB_Campos,@lInverte,@cMarca,{33,5,(oDlg:nClientHeight-6)/2,(oDlg:nClientWidth-4)/2})
      oMarkNF:bAval:={||nOpca:=1,oDlg:End()}
	  
	  oPanel:Align:=CONTROL_ALIGN_TOP //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
	  oMarkNF:oBrowse:Align:=CONTROL_ALIGN_ALLCLIENT //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT

   ACTIVATE MSDIALOG oDlg ON INIT ;
            (EnchoiceBar(oDlg,{||nOpca:=2,oDlg:End()},;
                             {||nOpca:=0,oDlg:End()}),;
            oMarkNF:oBrowse:Refresh()) CENTERED //LRL 08/04/04 -Alinhamento MDI. //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT

   IF nOpca==1

      cNota :=WorkNF->F1_CTR_NFC//Nota + Serie
      cChave:=WorkNF->F1_DOC+WorkNF->F1_SERIE+WorkNF->F1_FORNECE+WorkNF->F1_LOJA+" (SWN) "
      If SWN->(DbSeek(xFilial("SWN")+WorkNF->F1_DOC+WorkNF->F1_SERIE+WorkNF->F1_FORNECE+WorkNF->F1_LOJA))//AWR 21/03/2001
         lGravaWorks:=.T.
      ELSE
         MSGINFO(STR0035+cChave+STR0036,STR0022) //"Nota Fiscal Complementar: "###" nao encontrada"###"Atencao"
         WorkNF->(E_EraseArq(WorkNFile))
         DBSELECTAREA("SW6")
         Return .F.
      ENDIF

   ELSEIF nOpca == 0

      WorkNF->(E_EraseArq(WorkNFile))
      DBSELECTAREA("SW6")
      Return .F.

   ELSEIF nOpca == 2

      lNaoTemComp:=.F.

   ENDIF

   WorkNF->(E_EraseArq(WorkNFile))
   DBSELECTAREA("SW6")
   aCampos:={}

ENDIF

IF !lExecAuto
	
    ICMS_NFC:= GETMV("MV_ICMSNFC",,.F.) 
//	IF nTipoNF == NFE_COMPLEMEN .AND. lICMS_NFC .AND. !lGravaWorks
    IF lICMSCompl .AND. lICMS_NFC .AND. !lGravaWorks   // Bete 24/11 - Trevo
       lICMS_NFC:=MSGYESNO(STR0321) //STR0321 "Deseja calcular I.C.M.S. para Nota Fiscal Complementar?"
    ENDIF
	
	If !SW6->(RecLock("SW6",.F.))
	   Help(" ",1,"REGNLOCK")
	   SW6->(MsUnlock())
	   Return .F.
	Endif
	If lIntDraw
	   AADD(TB_Campos1,{"WKADICAO"  ,"" ,AVSX3("W8_ADICAO",5)})
	ELSEIF cPaisLoc = "BRA"
	   AADD(TB_Campos1,{"WKADICAO","","Grupo" })
	Endif
	AADD(TB_Campos1,{"WKNROLI"   ,"" , AVSX3("WP_REGIST",5) })
	AADD(TB_Campos1,{"WKFORN"    ,"" , STR0084 }) //"Fornecedor"
	AADD(TB_Campos1,{"WKNOME"    ,"" , AVSX3("A2_NOME",5) }) //"Razao Social"  TRP-26/10/07
	AADD(TB_Campos1,{"WK_CFO"    ,"" , STR0039 }) //"C.F.O."
	AADD(TB_Campos1,{{|| Work2->WK_OPERACA+"/"+TRAN(Work2->WKTEC,PICT_CPO03)+"/"+Work2->WKEX_NCM+"/"+Work2->WKEX_NBM},,STR0040}) //"Operacao/TEC/Ex-NCM/Ex-NBM"
	AADD(TB_Campos1,{{|| Work2->WK_CONDPAG+'-'+STR(Work2->WK_DIASPAG,3,0)},,AVSX3("W9_COND_PA",5)})
	AADD(TB_Campos1,{"WKMOEDA"   ,"" , AVSX3("W9_MOE_FOB",5) })
	AADD(TB_Campos1,{"WKINCOTER" ,"" , AVSX3("W9_INCOTER",5) })
	AADD(TB_Campos1,{"WKPESOL"   ,"" , STR0144 ,PICTPesoT}) //"Peso Adiçào"
	AADD(TB_Campos1,{"WKFOB_R"   ,"" , STR0042 ,PICT15_2}) //"Vlr. Neg. (R$)"
	AADD(TB_Campos1,{"WKFRETE"   ,"" , STR0043 ,PICT15_2}) //"FRETE (R$)"
	AADD(TB_Campos1,{"WKSEGURO"  ,"" , STR0044 ,PICT15_2}) //"SEGURO (R$)"
	IF lAcresDeduc  // Bete - 24/07/04 - Inclusao de acrescimos e deducoes na base de impostos
       AADD(TB_Campos1,{"WKVLACRES","" , "Acrescimos" ,PICT15_2}) //"Acrescimos (R$)"
       AADD(TB_Campos1,{"WKVLDEDUC","" , "Deducoes"   ,PICT15_2}) //"Deducoes (R$)"
    ENDIF  

	//AADD(TB_Campos1,{{|| DITrans( Work2->WKCIF - Work2->WKVLACRES + Work2->WKVLDEDUC,2)},"" , STR0045 ,PICT15_2}) //"C.I.F. (R$)"
	AADD(TB_Campos1,{"WKCIF"     ,"" , STR0045+" (Base II)" ,PICT15_2})//"C.I.F. (R$)"
	
	AADD(TB_Campos1,{"WKII_A"    ,"" , STR0047 ,PICT06_2}) //"% I.I."
	AADD(TB_Campos1,{"WKII"      ,"" , STR0048 ,PICT15_2}) //"I.I. (R$)"
			
	//ISS Inclusão da coluna "Base I.P.I. (R$)"
	AADD(TB_Campos1,{"WKBASEIPI" ,"" , STR0308,PICT15_2})//"Base I.P.I. (R$)" 

	AADD(TB_Campos1,{"WKIPI_A"   ,"" , STR0049 ,PICT06_2}) //"% I.P.I."
	AADD(TB_Campos1,{"WKIPI"     ,"" , STR0050 ,PICT15_2}) //"I.P.I. (R$)"
	
    IF lMV_PIS_EIC
       AADD(TB_Campos1,{"WKBASPIS",,AVSX3("W8_BASPIS",5),AVSX3("W8_BASPIS",6)})
       AADD(TB_Campos1,{"WKVLRPIS",,AVSX3("W8_VLRPIS",5),AVSX3("W8_VLRPIS",6)})
       AADD(TB_Campos1,{"WKBASCOF",,AVSX3("W8_BASCOF",5),AVSX3("W8_BASCOF",6)})
       AADD(TB_Campos1,{"WKVLRCOF",,AVSX3("W8_VLRCOF",5),AVSX3("W8_VLRCOF",6)})
       
       If lCposCofMj                                                                        //NCF - 20/07/2012 - Majoração COFINS
/*
          AADD(TB_Campos2,{"WKALCOFM",,AVSX3("W8_ALCOFM",5),AVSX3("W8_ALCOFM",6)})            
          AADD(TB_Campos2,{"WKVLCOFM",,AVSX3("W8_VLCOFM",5),AVSX3("W8_VLCOFM",6)})
*/
          AADD(TB_Campos1,{"WKALCOFM",,"Alq.Maj.COF","999.99"})            
          AADD(TB_Campos1,{"WKVLCOFM",,"Vlr.Maj.COF" ,"999,999,999,999.99"})
                    
       EndIf
       If lCposPisMj                                                                        //GFP - 11/06/2013 - Majoração PIS
          AADD(TB_Campos1,{"WKALPISM",,"Alq.Maj.PIS","999.99"})            
          AADD(TB_Campos1,{"WKVLPISM",,"Vlr.Maj.PIS","999,999,999,999.99"})         
       EndIf
    ENDIF

	//ISS Inclusão da coluna "Base I.C.M.S. (R$)"
	AADD(TB_Campos1,{"WKBASEICMS","" , STR0309,PICT15_2})//"Base I.C.M.S."

	AADD(TB_Campos1,{"WKICMS_A"  ,"" , STR0051 ,PICT06_2}) //"% I.C.M.S."
	AADD(TB_Campos1,{"WKICMS"    ,"" , STR0052 ,PICT15_2}) //"I.C.M.S. (R$)"	
	
    IF nTipoNF > 1 .AND. nTipoNF <= 4   // Bete 24/11 - Trevo 
       AADD(TB_Campos1,{{||Work2->WKOUTRDESP+Work2->WKRDIFMID},"",STR0053,PICT15_2}) //"Outras Despesas"
    ENDIF
	IF lAcresDeduc .AND. nTipoNF # CUSTO_REAL .AND. !lTipoCompl// AWR - 31/08/04
       AADD(TB_Campos1,{"WKCOD_AD",,"Controle Ac. De."})
    ENDIF  
	
	IF !lGravaWorks .AND. !lNFAutomatica .AND. nTipoNF # CUSTO_REAL
	   AADD(TB_Campos2,{"WKFLAG","" ,"",})
	ENDIF
	IF nTipoNF == CUSTO_REAL
	   AADD(TB_Campos2,{"WK_NFE   " ,"" ,(STR0037),}) //"N§ Custo"
	ELSE
	   AADD(TB_Campos2,{"WK_NFE   " ,"" ,(STR0038),}) //"N§ NF"
	   AADD(TB_Campos2,{"WK_SE_NFE" ,"" ,(STR0028),}) //"S‚rie NF"
	ENDIF
	AADD(TB_Campos2,{"WKFORN"    ,"" ,STR0084      ,}) //"Forncedor"
	If EICLoja()
	   AADD(TB_Campos2,{"WKLOJA"    ,"" ,"Loja"      ,})
	EndIf
    AADD(TB_Campos2,{"WKNOME"    ,"" , AVSX3("A2_NOME",5) }) //"Razao Social"  TRP-26/10/07
	AADD(TB_Campos2,{"WK_CFO"    ,"" ,STR0039      ,}) //"C.F.O."
	If lIntDraw
	   AADD(TB_Campos2,{"WKACMODAL",,IF(cQbrACModal="1",AVSX3("W8_AC",5),AVSX3("ED0_MODAL",5)) })
	Endif
	AADD(TB_Campos2,{{|| Work1->WK_OPERACA+"/"+TRAN(Work1->WKTEC,PICT_CPO03)+"/"+Work1->WKEX_NCM+"/"+Work1->WKEX_NBM},"",STR0040,}) //"Operacao/TEC/Ex-NCM/Ex-NBM"
	AADD(TB_Campos2,{"WKCOD_I"   ,"" ,(STR0054)           ,}) //"C¢d. Item"
	AADD(TB_Campos2,{{||Left(Work1->WKDESCR,35)},,(STR0055)}) //"Descri‡Æo do Item"
	AADD(TB_Campos2,{"WKPESOL"   ,"" ,(STR0041),PICTPesoI}) //"Peso L¡quido"
    IF nTipoNF == CUSTO_REAL .OR. lTipoCompl  // Bete 06/12
       AADD(TB_Campos2,{"WKQTDE"    ,"" , STR0057          ,PICT_CPO07}) //"Quantidade"
       AADD(TB_Campos2,{"WKPRUNI"   ,"" ,(STR0056),PICT21_8 }) //"Pre‡o Unit rio(R$)"
       AADD(TB_Campos2,{"WKVALMERC" ,"" ,(STR0058),_PictPrUn}) //"Pre‡o Total(R$)"
    ENDIF
	AADD(TB_Campos2,{"WKFOB_R"   ,"" , STR0042          ,PICT15_2}) //"Vlr. Neg. (R$)"
	AADD(TB_Campos2,{"WKFRETE"   ,"" , STR0043          ,PICT15_2}) //"Frete R$"
	AADD(TB_Campos2,{"WKSEGURO"  ,"" , STR0044          ,PICT15_2}) //"Seguro R$"
//	IF !(nTipoNF == CUSTO_REAL .AND. lGravaWorks) .AND. nTipoNF # NFE_COMPLEMEN
	IF !(nTipoNF == CUSTO_REAL .AND. lGravaWorks) .AND. lApuraCIF    // Bete 24/11 - Trevo
	   AADD(TB_Campos2,{"WKDESPCIF" ,,"Desp Base CIF(R$)",PICT15_2})
	ENDIF
    IF lAcresDeduc  // Bete - 24/07/04 - Inclusao de acrescimos e deducoes na base de impostos
       AADD(TB_Campos2,{"WKVLACRES","" , "Acrescimos" ,PICT15_2}) //"Acrescimos (R$)"
       AADD(TB_Campos2,{"WKVLDEDUC","" , "Deducoes"   ,PICT15_2}) //"Deducoes (R$)"
    ENDIF  
	AADD(TB_Campos2,{"WKCIF"     ,"" , STR0045+" (Base II)",PICT15_2}) //"C.I.F. (R$)"
    
	AADD(TB_Campos2,{"WKIITX"    ,"" , STR0047          ,PICT06_2}) //"% II"
    AADD(TB_Campos2,{"WKVLDEVII" ,   , STR0048+" Devido",PICT15_2}) //"I.I. (R$)"
	AADD(TB_Campos2,{"WKPR_II"   , ,AVSX3("EIJ_PR_II",5),PICT06_2})
	AADD(TB_Campos2,{"WKIIVAL"   ,"" , STR0048          ,PICT15_2}) //"I.I. (R$)"
	IF nTipoNF # CUSTO_REAL .AND. !lTipoCompl  // Bete 06/12
       AADD(TB_Campos2,{"WKQTDE"    ,"" , STR0057          ,PICT_CPO07}) //"Quantidade"
       AADD(TB_Campos2,{"WKPRUNI"   ,"" ,(STR0056),PICT21_8 }) //"Preco Unitario(R$)"
       AADD(TB_Campos2,{"WKVALMERC" ,"" ,(STR0058),_PictPrUn}) //"Preco Total(R$)"
    ENDIF
	AADD(TB_Campos2,{"WKIPIBASE" ,"" , STR0060          ,PICT15_2}) //"Base I.P.I. (R$)"
	AADD(TB_Campos2,{"WKIPITX"   ,"" , STR0049          ,PICT06_2}) //"% I.P.I."
    AADD(TB_Campos2,{"WKVLDEIPI" ,   , STR0050+" Devido",PICT15_2}) //"I.P.I. (R$)"
	AADD(TB_Campos2,{"WKIPIVAL"  ,"" , STR0050          ,PICT15_2}) //"I.P.I. (R$)"
    IF lMV_PIS_EIC
       AADD(TB_Campos2,{"WKBASPIS",,AVSX3("W8_BASPIS",5),AVSX3("W8_BASPIS",6)})
       AADD(TB_Campos2,{"WKPERPIS",,AVSX3("W8_PERPIS",5),AVSX3("W8_PERPIS",6)})
       AADD(TB_Campos2,{"WKVLUPIS",,AVSX3("W8_VLUPIS",5),AVSX3("W8_VLUPIS",6)})
       AADD(TB_Campos2,{"WKVLRPIS",,AVSX3("W8_VLRPIS",5),AVSX3("W8_VLRPIS",6)})
       AADD(TB_Campos2,{"WKBASCOF",,AVSX3("W8_BASCOF",5),AVSX3("W8_BASCOF",6)})
       AADD(TB_Campos2,{"WKPERCOF",,AVSX3("W8_PERCOF",5),AVSX3("W8_PERCOF",6)})
       AADD(TB_Campos2,{"WKVLUCOF",,AVSX3("W8_VLUCOF",5),AVSX3("W8_VLUCOF",6)})
       AADD(TB_Campos2,{"WKVLRCOF",,AVSX3("W8_VLRCOF",5),AVSX3("W8_VLRCOF",6)})
       
       If lCposCofMj                                                                        //NCF - 20/07/2012 - Majoração COFINS
/*
          AADD(TB_Campos2,{"WKALCOFM",,AVSX3("W8_ALCOFM",5),AVSX3("W8_ALCOFM",6)})            
          AADD(TB_Campos2,{"WKVLCOFM",,AVSX3("W8_VLCOFM",5),AVSX3("W8_VLCOFM",6)})
*/
          AADD(TB_Campos2,{"WKALCOFM",,"Alq.Maj.COF","999.99"})            
          AADD(TB_Campos2,{"WKVLCOFM",,"Vlr.Maj.COF" ,"999,999,999,999.99"})
                    
       EndIf
       If lCposPisMj                                                                        //GFP - 11/06/2013 - Majoração PIS
          AADD(TB_Campos2,{"WKALPISM",,"Alq.Maj.PIS","999.99"})            
          AADD(TB_Campos2,{"WKVLPISM",,"Vlr.Maj.PIS","999,999,999,999.99"})                    
       EndIf       
    ENDIF
	IF !(nTipoNF == CUSTO_REAL .AND. lGravaWorks)//Para nao aparecer na consulta do custo
	   IF lTemDespBaseICM  .OR. !lGravaWorks//Quando na existir o campo no SWN: só mostrar na geracao
	      AADD(TB_Campos2,{"WKDESPICM" ,,"Desp Base ICMS(R$)",PICT15_2})
	   ENDIF
	   AADD(TB_Campos2,{"WKBASEICMS",, STR0062          ,PICT15_2})//"Base I.C.M.S. (R$)"
	ENDIF
	AADD(TB_Campos2,{"WKICMS_A"   ,"" , STR0051         ,PICT06_2}) //"% ICMS"

	// EOB - 16/02/09 
	IF !lTipoCompl .AND. nTipoNF # CUSTO_REAL
	
       IF lICMS_Dif 
	      AADD(TB_Campos2,{"WKVLICMDEV","" , "ICMS devido"   ,PICT15_2}) 
	   ENDIF

	   IF lICMS_Dif2 
      	  AADD(TB_Campos2,{"WK_PERCDIF","",AVSX3("WZ_ICMSDIF",5),AVSX3("WZ_ICMSDIF",6)})
       ENDIF
	
	   IF lICMS_Dif 
  		  AADD(TB_Campos2,{"WKVL_ICM_D","",AVSX3("WN_VICMDIF",5),AVSX3("WN_VICMDIF",6)}) 
       ENDIF

	   IF lICMS_Dif2 
    	  AADD(TB_Campos2,{"WK_PCREPRE","" ,AVSX3("WZ_PCREPRE",5),AVSX3("WZ_PCREPRE",6)})
   		  AADD(TB_Campos2,{"WK_CRE_PRE","" ,AVSX3("WZ_ICMS_CP",5),AVSX3("WZ_ICMS_CP",6)})
  	   ENDIF
   	
  	   IF lICMS_Dif 
		  AADD(TB_Campos2,{"WKVLCREPRE",,AVSX3("WN_VICM_CP",5),AVSX3("WN_VICM_CP",6)}) 
	   ENDIF

	   IF lICMS_Dif2 
   		  AADD(TB_Campos2,{"WK_PAG_DES","", AVSX3("WZ_ICMS_PD",5),AVSX3("WZ_ICMS_PD",6)})
   	   ENDIF
   	   
   	   IF lCposPtICMS                                                                    //NCF - 11\05\2011 - Exibe o campo de ICMS devido para tratamento de ICMS de Pauta
          IF ( nPos1 := aScan(aDBF_Stru, {|x| x[1] == "WKVLICMDEV"}) ) # 0 
             IF ( nPos2 := aScan(TB_Campos2, {|x| If(ValType(x[1])=="C",x[1] == "WKVLICMDEV",0) }) ) == 0 
                AADD(TB_Campos2,{"WKVLICMDEV","" , "ICMS devido"   ,PICT15_2}) 
             ENDIF
          ENDIF 
       ENDIF

    ENDIF

	AADD(TB_Campos2,{"WKVL_ICM"  ,"" , "ICMS a Recolher",PICT15_2})

//	IF nTipoNF # NFE_PRIMEIRA 
	IF nTipoNF > 1 .AND. nTipoNF <= 4   // Bete 24/11 - Trevo 
	   AADD(TB_Campos2,{"WKOUT_DESP",, STR0053          ,PICT15_2}) //"Outras Despesas"
	ENDIF
	AADD(TB_Campos2,{"WKPO_NUM"  ,, STR0063          ,}) //"N§ P.O."

	IF lLote 
	   AADD(TB_Campos2,{"WK_LOTE"  ,"" ,STR0064                             }) //"No. Lote"
	   AADD(TB_Campos2,{"WKDTVALID","" ,STR0065                         }) //"Dt. Validade"
	   AADD(TB_Campos2,{{||IF(SUBSTR(Work1->WKPGI_NUM,1,1)=="*","",Work1->WKPGI_NUM)},,STR0066}) //"No. PLI"
	ENDIF
	IF lGravaWorks .AND. nTipoNF # CUSTO_REAL .AND. lMV_EASYSIM
	   AADD(TB_Campos2,{ {|| IF(EMPTY(Work1->WKSTATUS),STR0289,STR0290) } ,,AVSX3("F1_STATUS",5)})// "Nao Classif."###"Classificada"
	ENDIF
    IF cPaisLoc=="BRA" .AND. !lGravaWorks
	   AADD(TB_Campos2,{"WKREGTRII" ,,"Reg Trib II" })
	   AADD(TB_Campos2,{"WKREGTRIPI",,"Reg Trib IPI"})
	ENDIF

   IF lExisteSEQ_ADI// AWR - 18/09/08 - NFE
      AADD(TB_Campos2,{"WKADICAO" ,,"Adicao"     })
      AADD(TB_Campos2,{"WKSEQ_ADI",,"Seq. Adicao"})// AWR - 11/09/08 - NF-Eletronica
	   AADD(TB_Campos2,{"WKGRUPORT",,"Grupo"      })
   ELSE
      AADD(TB_Campos2,{"WKADICAO",,"Grupo"       })
	ENDIF
   IF lMV_GRCPNFE .AND. nTipoNF # CUSTO_REAL  .AND. !lTipoCompl  //Campos novos NFE - AWR 06/11/2008
      AADD(TB_Campos2,{ "WKALUIPI" ,"",AVSX3("WN_ALUIPI" ,5),AVSX3("WN_ALUIPI" ,6) })
      AADD(TB_Campos2,{ "WKQTUIPI" ,"",AVSX3("WN_QTUIPI" ,5),AVSX3("WN_QTUIPI" ,6) })
      AADD(TB_Campos2,{ "WKQTUPIS" ,"",AVSX3("WN_QTUPIS" ,5),AVSX3("WN_QTUPIS" ,6) })
      AADD(TB_Campos2,{ "WKQTUCOF" ,"",AVSX3("WN_QTUCOF" ,5),AVSX3("WN_QTUCOF" ,6) })
      AADD(TB_Campos2,{ "WKPREDICM","",AVSX3("WN_PREDICM",5),AVSX3("WN_PREDICM",6) })
      AADD(TB_Campos2,{ "WKDESCONI","",AVSX3("WN_DESCONI",5),AVSX3("WN_DESCONI",6) })
      AADD(TB_Campos2,{ "WKVLRIOF" ,"",AVSX3("WN_VLRIOF" ,5),AVSX3("WN_VLRIOF" ,6) })
   ENDIF
   
   //FSM - 02/09/2011  - Peso Bruto Unitario
   If lPesoBruto
      aAdd(TB_Campos2,{ "WKPESOBR" ,"",AvSx3("W8_PESO_BR", 5),AvSx3("W8_PESO_BR", 6) })
   EndIf

/* SVG - 24/05/2011 - Não se trata de work especifica da tabela, o que ocasiona erros devido a campos de usuario não inseridos na work.
    //GFP 22/10/2010
    TB_Campos2 := AddCpoUser(TB_Campos2,"SWN","2")
*/	
	IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'WORK_BROWSES'),)
	IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'WORK_BROWSES'),)
	
	aCampos :={"W9_INVOICE","W9_FORN","W9_MOE_FOB","W9_FRETEIN","W9_INLAND","W9_PACKING",;
	           "W9_OUTDESP","W9_DESCONT","W9_FOB_TOT","W6_FOB_TOT"}
	If EICLoja()
	   aAdd(aCampos, "W9_FORLOJ")
	EndIf
    // EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP	           
	IF lSegInc
	   AADD( aCampos, "W9_SEGURO")
	ENDIF	           
	aSemSX3:={{"WKCODIGO","C",1,0}}
	//TRP - 25/01/07 - Campos do WalkThru
	AADD(aSemSX3,{"TRB_ALI_WT","C",03,0})
    AADD(aSemSX3,{"TRB_REC_WT","N",10,0})
	
    If Select("Work_Tot") == 0
   	   cFileWk:=E_CriaTrab(,aSemSX3,"Work_Tot")
   	Else
   	   DbSelectArea("Work_Tot")
   	   ZAP
    EndIf
    
	IF !USED()
	   SW6->(MSUnlock())
	   Help("",1,"AVG0000802")//"Nao foi possivel a abertura do Arquivo de Trabalho"###"Atenção"
	   Return .F.
	ENDIF
	
	IndRegua("Work_Tot",cFileWk+OrdBagExt(),"WKCODIGO+W9_INVOICE+W9_FORN"+IF(EICLoja(), "+W9_FORLOJ", ""))
	
	cFileWkA:=E_Create(,.F.)
	IndRegua("Work_Tot",cFileWkA+OrdBagExt(),"WKCODIGO+W9_MOE_FOB")
	
	SET INDEX TO (cFileWk+OrdBagExt()),(cFileWkA+OrdBagExt())
	
ENDIF//eh do IF !lExecAuto

//GFP 22/10/2010
aDBF_Stru := AddWkCpoUser(aDBF_Stru,"SWN")

Work1File:=E_Create(aDBF_Stru,.T.)
DBUSEAREA(.T.,,Work1File,"Work1",.F.)
IF !USED()
   E_RESET_AREA()
   Help("",1,"AVG0000802")//"Nao foi poss¡vel a abertura do Arquivo de Trabalho"###"Atenção"
   Return .F.
ENDIF

//WKADICAO+WK_CFO+WK_OPERACA+EIJ_NROLI+EIJ_FORN+EIJ_FABR+EIJ_TEC+EIJ_EX_NCM+EIJ_EX_NBM+
//EIJ_CONDPG+STR(EIJ_DIASPG,3,0)+EIJ_MOEDA+EIJ_INCOTE
//cIndice:="WKADICAO+WK_CFO+WK_OPERACA+WKNROLI+WKFORN+WKFABR+WKTEC+WKEX_NCM+WKEX_NBM+"+;
//         "WK_CONDPAG+STR(WK_DIASPAG,3,0)+WKMOEDA+WKINCOTER"

//** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
//cIndice := "WKADICAO"  Bete - controle por adição
cIndice := "WKNROLI"
cIndice += "+WKFORN"
IF EICLoja()
   cIndice += "+WKLOJA"
EndIf
cIndice += "+WKFABR"
IF EICLoja()
   cIndice += "+WKFABLOJ"
EndIf
cIndice += "+WKTEC"
cIndice += "+WKEX_NCM"
cIndice += "+WKEX_NBM"
cIndice += "+WK_CONDPAG"
cIndice += "+STR(WK_DIASPAG,3,0)"
cIndice += "+WKMOEDA"
cIndice += "+WKINCOTER"
cIndice += "+WKREGTRII"
cIndice += "+WKFUNREG"
cIndice += "+WKMOTADI"
cIndice += "+WKTACOII"
cIndice += "+WKACO_II"
cIndice += "+WKREGTRIPI"
cIndice += "+WK_OPERACA"
cIndice += "+WKNVE"
IF lAUTPCDI//JVR - 10/02/10 - Incluido validação, pois existe casos onde não ira existir estes campos.
   cIndice += "+WKREG_PC"
   cIndice += "+WKFUN_PC"
   cIndice += "+WKFRB_PC"
EndIf
//**
If (ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"INDICE"),) // BHF 22/01/09 - Ponto para personalização dos indices e da variável cIndice. 

IndRegua("Work1",Work1File +OrdBagExt(),cIndice)

Work1FileA:=E_Create(,.F.)
IndRegua("Work1",Work1FileA+OrdBagExt(),"WK_NFE+WK_SE_NFE")

Work1FileB:=E_Create(,.F.)
IndRegua("Work1",Work1FileB+OrdBagExt(),"WKPO_NUM+WKPOSICAO+WKPGI_NUM")

Work1FileC:=E_Create(,.F.)
IndRegua("Work1",Work1FileC+OrdBagExt(),"WK_NFE+WK_SE_NFE+WK_OPERACA+WKTEC+WKEX_NCM+WKEX_NBM+WKPO_NUM")

Work1FileD:=E_Create(,.F.)
IndRegua("Work1",Work1FileD+OrdBagExt(),"WKFORN" + If(EICLoja(), "+WKLOJA", "") + "+WK_CFO+WKACMODAL+WK_OPERACA+WKTEC+WKEX_NCM+WKEX_NBM+WKCOD_I+WKPOSICAO")

cIndWk1 := "WKADICAO"
IF lExisteSEQ_ADI// AWR - 18/09/08 - NFE
   cIndWk1 += "+WKSEQ_ADI"
EndIf
 
Work1FileE:=E_Create(,.F.)
IndRegua("Work1",Work1FileE+OrdBagExt(),cIndWk1)

Work1FileG:=E_Create(,.F.)
IndRegua("Work1",Work1FileG+OrdBagExt(),"WKCOD_I")
Work1FileH:=E_Create(,.F.)
IndRegua("Work1",Work1FileH+OrdBagExt(),"WKPO_NUM")

Work1FileI:=E_Create(,.F.)
IndRegua("Work1",Work1FileI+OrdBagExt(),"WKINVOICE")

//DFS - 14/02/11 - Inclusão de indice na work1 
Work1FileJ:=E_Create(,.F.)
IndRegua("Work1",Work1FileJ+OrdBagExt(),"WKNOTAOR+WKSERIEOR")

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"CRIA_INDICE"),) // TLM 24/06/08 - Ponto para personalização de indice da work1, a variavel cCpoInd deve receber a string dos campos para ordenação.

   Work1FileF:=E_Create(,.F.)
   IndRegua("Work1",Work1FileF+OrdBagExt(),cCpoInd) 
   
   WORK1->(OrdListClear())
   Work1->(dbSetIndex(Work1File +OrdBagExt()))
   Work1->(dbSetIndex(Work1FileA+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileB+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileC+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileD+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileE+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileF+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileG+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileH+OrdBagExt()))
   Work1->(dbSetIndex(Work1FileI+OrdBagExt())) 
   Work1->(dbSetIndex(Work1FileJ+OrdBagExt())) //DFS - 14/02/11  

//Work2
Work2File:=E_Create(aDBF_Stru2,.T.)
DBUSEAREA(.T.,,Work2File,"Work2",.F.)

IF !USED()
   E_RESET_AREA()
   Help("",1,"AVG0000802")//"Nao foi poss¡vel a abertura do Arquivo de Trabalho"###"Atenção"
   Return .F.
ENDIF

IndRegua("Work2",Work2File+OrdBagExt(),cIndice)

Work2FileA:=E_Create(,.F.)
IndRegua("Work2",Work2FileA+OrdBagExt(),"WKADICAO")

SET INDEX TO (Work2File+OrdBagExt()),(Work2FileA+OrdBagExt()) 
bSeekWk1:=&("{|| Work2->("+cIndice+")}")
bSeekWk2:=&("{|| Work1->("+cIndice+")}")
bWhileWk:=&("{|| Work2->("+cIndice+") == Work1->("+cIndice+")}")
//"WKADICAO+WK_CFO+WK_OPERACA+WKNROLI+WKFORN+WKFABR+WKTEC+WKEX_NCM+WKEX_NBM+"+;
//"WK_CONDPAG+STR(WK_DIASPAG,3,0)+WKMOEDA+WKINCOTER"

IF !lExecAuto .OR. lSoGravaNF// AWR - 02/02/09 - So Grava a NF
	
	IF(ExistBlock("IC023PO1"),Execblock("IC023PO1",.F.,.F.,"WORK3"),) // MERCK - ALEX
	IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"WORK3"),)
	//Work3
	Work3File:=E_Create(aDBF_Stru3,.T.)
	DBUSEAREA(.T.,,Work3File,"Work3",.F.)
	IF ! USED()
	   E_RESET_AREA()
	   Help("",1,"AVG0000802")//"Nao foi poss¡vel a abertura do Arquivo de Trabalho"###"Atenção"
	   Return .F.
	ENDIF
	
	IndRegua("Work3",Work3File+OrdBagExt(),"WKRECNO")
	
	Work3FileA:=E_Create(aDBF_Stru3,.F.)
	
	IndRegua("Work3",Work3FileA+OrdBagExt(),"WKPO_NUM+WKDESPESA")
	
	SET INDEX TO (Work3File+OrdBagExt()),(Work3FileA+OrdBagExt())
	
ENDIF////eh do IF !lExecAuto

aCampos:={}
//aHeader:={}
aCposWork4 := {{"WKDESP"   ,"C",40,0},;
              {"WKVALOR"  ,"N",18,2},;
              {"WKNOTA"   ,"C",LEN(SWD->WD_NF_COMP),0},;
              {"WKSERIE"  ,"C",03,0},;                    
              {"WKBASEICM","C",01,0},;
              {"WKICMS_UF","C",01,0},;
              {"WKBASEIMP","C",01,0},;
              {"WKICMSNFC","C",01,0},;
              {"WKBASECUS","C",01,0},;
              {"WKRATPESO","C",01,0},;
              {"TRB_ALI_WT","C",03,0},; //TRP - 25/01/07 - Campos do WalkThru
              {"TRB_REC_WT","N",10,0}}  // GFP - 28/06/2013

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"WORK4"),)  // GFP - 28/06/2013

Work4File:=E_CriaTrab(,aCposWork4,"Work4")   // GFP - 28/06/2013

IF ! USED()
   E_RESET_AREA()
   Help("",1,"AVG0000802")//"Nao foi poss¡vel a abertura do Arquivo de Trabalho"###"Atenção"
   Return .F.
ENDIF

IndRegua("Work4",Work4File+OrdBagExt(),"WKDESP")

   // Bete - 24/07/04 - Arquivo EIU referente a acrescimos e deducoes
   SX3->(dbSetOrder(1))
   IF SX3->(DBSEEK("EIU")) .AND. SELECT("Work_EIU") = 0// Select() por causa da Trevo
      PRIVATE aHeaderEIU := {}
      aCampos:=Array(EIU->(FCount()))       
      aSemSX3EIU:={{"WK_RECNO"  ,"N",10,00}}
      Work5File:=E_CriaTrab("EIU",aSemSX3EIU,"Work_EIU",aHeaderEIU)
      IF !USED()
         E_RESET_AREA()
         Help("",1,"AVG0000802")//"Nao foi poss¡vel a abertura do Arquivo de Trabalho"###"Atenção"
         Return .F.
      ENDIF
      IndRegua("Work_EIU",Work5File+OrdBagExt(),"EIU_ADICAO+EIU_TIPO+EIU_CODIGO")
   ELSE
      lAcresDeduc := .F.      
   ENDIF

   lLoop:=.F.	// Bete 26/11 - Trevo
IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'OUTROS_INDICES'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"OUTROS_INDICES"),)
	IF lLoop    // Bete 26/11 - Trevo
	   RETURN .F.
	ENDIF

lComIcms:=lGravaWorks//Para aparecer o valor do ICMS no Estorno
MDI_FOB :=MDI_FOB_R:=MDI_FRETE:=MDI_SEGURO:=MDI_CIF   := MDI_CIF_M:= MDI_CIFMOE  :=0
MDI_II  :=MDI_IPI  :=MDI_ICMS :=MDI_OUTR  :=MDI_PESO  := MDI_QTDE := TICMS:=MDI_CIFPURO:=0
nNBM_CIF:=nNBM_II  :=nNBM_IPI :=nNBM_ICMS :=nFOBRatSeg:= MDI_OU_US:= MDI_FOBR_ORI:= MDI_DespICM := 0
nNBM_PIS:=nNBM_COF :=MDI_PIS  :=MDI_COF   :=nNBM_Acres:= nNBM_Deduc:=0
nCIFNew :=nFreteNew:=nSeguro := nPesoL   :=MDespesas :=nSomaNoCIF:= nSomaBaseICMS:= nPSemCusto := nSemCusto := 0 
nPSomaNoCIF:= nPSomaBaseICMS:= MDI_OUTRP:= MDI_OU_USP := 0    //EOS
nTxSisc := 0
PRIVATE M_FOB_MID:=0 , nFobItemMidia:=0, lHaUmaMidia:=.F.
PRIVATE lAlterouAliquotas:=.F.//Variavel usada para verificar se houve alteracao nas aliquotas e peso
PRIVATE cFormPro := GETMV("MV_NF_AUTO",, "N") // TDF - 17/11/2010

SA2->(DbSeek(xFilial("SA2")+SW7->W7_FORN+EICRetLoja("SW7", "W7_FORLOJ")))
cLeuNota:=""
lLerNota:=.F.
nNFOrigem:=1
IF GETNEWPAR("MV_LERNOTA",.F.) .AND. nTipoNF = CUSTO_REAL .AND. !lGravaWorks

   SF1->(DBSETORDER(5))
   IF SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+'1')) 
      nNFOrigem:=1
      nTipoNF  :=1
      lLerNota :=.T.
      lGravaWorks:=.T.
      cNota :=SF1->F1_CTR_NFC//Nota + Serie
      cLeuNota:=STR0335  //STR0335 " - com Base na NF Primeira"
   ENDIF

   IF SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+'3')) 
      nNFOrigem:=3
      nTipoNF  :=3
      lLerNota :=.T.
      lGravaWorks:=.T.
      cNota :=SF1->F1_CTR_NFC//Nota + Serie
      cLeuNota:=STR0342 //STR0342 " - com Base na NF Unica"
   ENDIF
   IF SF1->(DBSEEK(xFilial("SF1")+SW6->W6_HAWB+'5')) 
      nNFOrigem:=5
      nTipoNF  :=5
      lLerNota :=.T.
      lGravaWorks:=.T.
      cNota :=SF1->F1_CTR_NFC//Nota + Serie
      cLeuNota:=STR0336 //STR0336 " - com Base na NF Mae"
   ENDIF

ENDIF
   //BHF - 04/05/09
If ExistBlock("EICDI154")
   ExecBlock("EICDI154",.F.,.F.,"NF_CUSTOM")
EndIf 

IF lGravaWorks
   Processa({|| DI154GrWorks(bDDIFor,BDDIWhi)},STR0068) //"Pesquisando Informacoes..."

   IF lLerNota
      nTipoNF:=4
      Processa({|| DI154GeraCusto()},STR0068) //"Pesquisando Informacoes..."             
      lGravaWorks:=.F.
      DI154MsgDif(.T.)
   ENDIF
ELSE
   lRet_Ok:=.T.
   Processa({|| lRet_Ok:=DI154Grava(bDDIFor,BDDIWhi)},STR0068) //"Pesquisando Informacoes..."

// IF nTipoNF==NFE_COMPLEMEN 
   IF lDespNProc   // Bete 24/11 - Trevo
      If Empty(MDI_OUTR) .AND. Empty(MDI_OUTRP) .AND.;//EOS
      !((lExiste_Midia .AND. lHaUmaMidia .OR. lNewMidia))  // AAF 14/11/2007 - Permite a nota complementar de mídia.
         E_RESET_AREA()
         Help(" ",1,"DI154DESP")//Nao ha  despesas p/ geracao de Nota Fiscal Complementar
         Return .F.
      Endif
      If lNewMidia .AND. Empty(MDI_OUTR) .AND. Empty(MDI_OUTRP)
          E_RESET_AREA()
         Help(" ",1,"DI154DESP")//Nao ha  despesas p/ geracao de Nota Fiscal Complementar
         Return .F.
      Endif
   ELSEIF !lExecAuto .AND. lRet_Ok
       DI154MsgDif(.T.)
   Endif

   IF !lRet_Ok  // Bete 28/11 - Trevo
      E_RESET_AREA()
      Return .F.
   ENDIF   
ENDIF

IF lSoEstornaNF// AWR - 25/03/09 - So estorna NF
   lEstornou:=.F.
   Processa({|| lEstornou:=DI154Delet() },STR0090) //"Processando Estorno..."
   E_RESET_AREA()
   RETURN lEstornou
ENDIF

IF lSoGravaNF// AWR - 25/03/09 - So Grava a NF
   lGerouNFE:=.F.
   Processa( {|| DI154GerNF(@lGerouNFE,bDDIFor,bDDIWhi)} ,STR0327 ) //STR0337 "Gravando..." 
   Return lGerouNFE
ENDIF

IF lExecAuto
   E_RESET_AREA()
   Return .T.
ENDIF

IF Work2->(BOF()) .AND. Work2->(EOF())
   IF !lGravaWorks
      E_RESET_AREA()
      Help(" ",1,"EICSEMREG")
      Return .F.
   ENDIF
ENDIF

//IF nTipoNF==NFE_COMPLEMEN
IF lDespNProc

   nFob_R  :=0
   n_Frete :=0
   n_Seguro:=0
   n_CIF   :=0
   n_II    :=0
   n_IPI   :=0
   n_ICMS  :=IF(lICMS_NFC, IF(lExiste_Midia,0, nNBM_ICMS ) ,0)
   n_PIS   :=0
   n_COFINS:=0
   n_Desp  :=0
   n_Tx_Fob:=0
   n_Vl_Fre:=0
   n_Tx_Fre:=0
   n_Vl_USS:=0
   n_Tx_Seg:=0    // Bete 26/11 - Trevo
   n_Tx_US_D:=0   // Bete 26/11 - Trevo
ELSE
   nFob_R  :=MDI_FOB_R
   n_Frete :=nFreteNew
   n_Seguro:=MDI_SEGURO
   n_CIF   :=nCIFNew
   n_II    :=nNBM_II
   n_IPI   :=nNBM_IPI
   n_ICMS  :=nNBM_ICMS
   n_PIS   :=nNBM_PIS
   n_COFINS:=nNBM_COF
   n_Desp  :=MDespesas

   n_Vl_Fre:=ValorFrete(SW6->W6_HAWB,,,2)
   n_Tx_Fre:=DI154TaxaFOB("FRETE")
   n_Vl_USS:=SW6->W6_VL_USSE
   n_Tx_Seg:=DI154TaxaFOB("SEGURO")
ENDIF
//SVG - 13/07/2011 - Acrecimos e deduções no valor total
nVlAcre:= 0
nVlDeduc:=0
Work2->(DBGOTOP())
IF EIB->(FIELDPOS("EIB_VLACRE")) # 0 .AND. EIB->(FIELDPOS("EIB_VLDEDU")) # 0 
   Work2->(DBGOTOP())
   While Work2->(!Eof())
      nVlAcre+= Work2->WKVLACRES
      nVlDeduc+= Work2->WKVLDEDUC
      Work2->(DbSkip())			
   EndDo
EndIf

cTotal  :=STR0280
n_ValM  :=DITRANS(n_CIF,2)+DITRANS(n_II,2)
n_TotNFE:=DITRANS(n_ValM,2)+DITRANS(n_IPI,2)                             //NCF - 17/08/2011
// TRP - 24/10/2012
n_VlTota:=DITRANS((n_TotNFE+nNBM_PIS+nNBM_COF+n_ICMS+MDI_OUTR+MDI_OUTRP+nVlAcre-nVlDeduc),2)   //EOS
n_VlDesp:=MDI_OUTR+MDI_OUTRP 
If lImpostos .And. !(lTemCusto .And. nTipoNF == CUSTO_REAL)
   n_VlTota+= MDI_DespICM
   n_VlDesp+= MDI_DespICM 
Endif 
// NCF - 17/08/2011 - Verificação para composição do total Geral da Nota fiscal
IF lImpostos                    
   IF nTipoNF <> CUSTO_REAL
      IF !lTemPrimeira
         n_VlTota += DITRANS(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)
      ENDIF  
   ELSE                                                          			
      IF !lTemCusto
         IF !GetMv("MV_LERNOTA",,.F.)
            n_VlTota += DITRANS( nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)                
         ENDIF
      ENDIF    
   ENDIF
ENDIF                                                                                                                                                                                              
                                                                                               
nL1:=1.4; nL2:=2.2; nL3:=3.0; nL4:=3.8; nL5:=4.6; nL6:=5.4; nL7:=6.2; nL8:=7.0
nC1:=0.7; nC2:=5.2; nC3:=13.0; nC4:=18.2; nC5:=25.7; nC6:=31.2

Work2->(DBGOTOP())
Work1->(DBGOTOP())

SA2->(DBSETORDER(1))
SW7->(DBSETORDER(1))
SW2->(DBSETORDER(1))
SYT->(DBSETORDER(1))
SW7->(DbSeek(xFilial("SW7")+SW6->W6_HAWB))
SW2->(dBSeek(xFilial("SW2")+SW7->W7_PO_NUM))
SYT->(dBSeek(xFilial("SYT")+SW2->W2_IMPORT))
SA2->(DbSeek(xFilial("SA2")+SW7->W7_FORN+EICRetLoja("SW7", "W7_FORLOJ")))

DO CASE
   CASE nTipoNF = NFE_PRIMEIRA
        cTit:=cCadastro+" ("+STR0181+")"
   CASE lMV_NF_MAE .And. nTipoNF = NFE_MAE
        cTit:=cCadastro+" ("+STR0297+")"
   CASE lMV_NF_MAE .And. nTipoNF = NFE_FILHA
        cTit:=cCadastro+" ("+STR0298+")"
   CASE nTipoNF = NFE_COMPLEMEN
        cTit:=cCadastro+" ("+STR0303+")"
   CASE nTipoNF = NFE_UNICA
        cTit:=cCadastro+" ("+STR0304+")"
   CASE nTipoNF = CUSTO_REAL
        cTit:=cCadastro+" ("+STR0182+")"+cLeuNota
ENDCASE   

Work2->(dbSetOrder(2))
Work2->(dbGotop())

// Adicionar Deduções de frete nacional automaticamente para incoterms CPT,CIP,DDU
If GetMV("MV_DEFRENA",,.F.) .And. (nTipoNF == NFE_PRIMEIRA .Or. nTipoNF == NFE_UNICA .Or. (lMV_NF_MAE .And. nTipoNF == NFE_MAE)) 
    DeduFretN()
EndIf   


DO WHILE .T.

   lGeraNF:=.T.
   nOpca:=000
   nLin :=0.1
   nCoL1:=005
   nCoL2:=050
   nCoL3:=122
   nCoL4:=172
   nCoL5:=255
   
 /* ISS - 07/04/10 - Introdução do ponto de entrada para a customizar a disponibilidade do botão "Estorno",
                  a variável lEstornaBtn serve para dizer se o botão vai ou não ser apresentado normalmente */
   lEstornaBtn := .T.
   If ExistBlock("EICDI154")
      ExecBlock("EICDI154",.F.,.F.,"GERA_MAINWND")
   EndIf 
 
   oMainWnd:ReadClientCoords()
   DEFINE MSDIALOG oDlg TITLE cTit ;
      FROM oMainWnd:nTop+060,oMainWnd:nLeft+5 TO oMainWnd:nBottom-60,oMainWnd:nRight-10;
      OF oMainWnd PIXEL  

   nSize:= 56 
   @ nLin,nLin Mspanel oPanel Prompt "" Size 260+nSize,nLin+114 of oDlg //LRL 07/04/04 - Painel para Alinhamento MDI.       
   @ nLin,nLin TO nLin+104,249       PIXEL
   @ nLin,250  TO nLin+104,260+nSize PIXEL

   nLin+=04
   @ nLin,nCoL1 SAY AVSX3("W6_HAWB",5) SIZE 58,7 OF oPanel PIXEL
   @ nLin,nCoL2 MSGET SW6->W6_HAWB     WHEN .F. SIZE 58,8 PIXEL

   @ nLin,nCoL3 SAY AVSX3("W6_DT_DESE",5) SIZE 58,7 OF oPanel PIXEL//"Dt.Desembaraço"  
   @ nLin,nCoL4 MSGET SW6->W6_DT_DESE     WHEN .F. SIZE 58,8 PIXEL

   nLin+=12
   @ nLin,nCoL1 SAY STR0084        SIZE 58,7 OF oPanel PIXEL//"Fornecedor"
   IF LEN(aLista) < 2
      @ nLin,nCoL2 MSGET SA2->A2_NOME WHEN .F. SIZE 180,8 PIXEL
   ELSE
      cForn:=aLista[1]
      @ nLin,nCoL2 LISTBOX cForn ITEMS aLista SIZE 180,10 PIXEL
   ENDIF
   nLin+=12
   @ nLin,nCoL1 SAY STR0083        SIZE 58,7 OF oPanel PIXEL//"Importador" 
   @ nLin,nCoL2 MSGET SYT->YT_NOME WHEN .F. SIZE 180,8 PIXEL

   nLin+=12
   @ nLin,nCoL1 SAY AVSX3("W6_DI_NUM",5) SIZE 58,7 OF oPanel PIXEL//"Nº D.I."
   @ nLin,nCoL2 MSGET SW6->W6_DI_NUM PICTURE AVSX3("W6_DI_NUM",AV_PICTURE)    WHEN .F. SIZE 58,8 PIXEL

   @ nLin,nCoL3 SAY AVSX3("W6_DTREG_D",5) SIZE 58,7 OF oPanel PIXEL
   @ nLin,nCoL4 MSGET SW6->W6_DTREG_D     WHEN .F. SIZE 58,8 PIXEL

   nLin+=12
   @ nLin,nCoL1 SAY STR0073+IF(!lCurrier,"("+SW6->W6_FREMOED+")","") SIZE 58,7 OF oPanel PIXEL//"Frete
   @ nLin,nCoL2 MSGET n_Vl_Fre  PICTURE PICT15_2 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL

   @ nLin,nCoL3 SAY AVSX3("W6_TX_FRET",5) SIZE 58,7 OF oPanel PIXEL
   @ nLin,nCoL4 MSGET n_Tx_Fre PICTURE PICT15_8 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL

   nLin+=12
   @ nLin,nCoL1 SAY STR0075+IF(!lCurrier,"("+SW6->W6_SEGMOEDA+")","") SIZE 58,7 OF oPanel PIXEL//"Seguro
   @ nLin,nCoL2 MSGET n_Vl_USS  PICTURE PICT15_2 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL

   @ nLin,nCoL3 SAY STR0076 SIZE 58,7 OF oPanel PIXEL//"Tx Seg "
// @ nLin,nCoL4 MSGET SW6->W6_TX_SEG PICTURE PICT15_8 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL
   @ nLin,nCoL4 MSGET n_Tx_Seg PICTURE PICT15_8 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL


   nLin+=12
   @ nLin,nCoL1 SAY STR0053 SIZE 58,7 OF oPanel PIXEL//"Outras Desp.(R$)"
   @ nLin,nCoL2 MSGET n_VlDesp  PICTURE PICT15_2 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL

   @ nLin,nCoL3 SAY STR0274 SIZE 58,7 OF oPanel PIXEL //"Total Geral (R$)"
   @ nLin,nCoL4 MSGET oSayTotGe VAR n_VlTota PICTURE PICT15_2 SIZE 58, 7 OF oDlg WHEN .F. RIGHT PIXEL
   
   nLinTela := nLin

   nLin:=05
   @ nLin,nCoL5 BUTTON STR0103 SIZE nSize,12 ACTION (nOpca:=0,oDlg:End()) OF oDlg PIXEL //"&Sair"
   nLin+=12
   @ nLin,nCoL5 BUTTON STR0085 SIZE nSize,12 ACTION ; //"&Estorno"
                               (IF(lMV_NF_MAE .And. lTemFilha .And. nTipoNF = NFE_MAE,Alert(STR0299),;
                                IF(lTemComplem,Help("",1,"AVG0000816"),;//MsgStop(STR0086,STR0022),; //"Conhecimento possui Nota Fiscal Complementar"###"Atenção"
                               IF( (ExistBlock("EICPDI01") .AND. ExecBlocK("EICPDI01",.F.,.F.,"7")==.F.) .OR.;
                                   (ExistBlock("EICDI154") .AND. ExecBlocK("EICDI154",.F.,.F.,"ESTORNO")==.F.) ,,;
                               IF(MsgYesNo(STR0087,STR0088)#.T.,,(nOpca:=1,oDlg:End())))))); //"Confirma Estorno ?"###"Estorno"
                               WHEN (lGravaWorks.OR.lGerouNFE) .AND. lEstornoPE OF oDlg PIXEL  // LBL - 13/06/2013
   IF !lGravaWorks
      nLin+=12
      @ nLin,nCoL5 BUTTON STR0089 SIZE nSize,12 ACTION ; //"&Itens"
                                  ((nOpca:=2,oDlg:End()) ) OF oDlg PIXEL
   ENDIF

   IF lMV_NF_MAE   // DFS - Alteração do tratamento para trazer os botões quando tiver o parametro ligado/desligado.
      If nTipoNF <> NFE_FILHA
         nLin+=12
         // @ nLin,nCoL5 BUTTON STR0275 SIZE nSize,12 ACTION (DI154ValTxTela()) OF oDlg PIXEL WHEN (nTipoNF # NFE_COMPLEMEN)//"&Valores/Taxas"
         @ nLin,nCoL5 BUTTON STR0275 SIZE nSize,12 ACTION (DI154ValTxTela()) OF oDlg PIXEL WHEN (lApuraCIF)//"&Valores/Taxas"   // Bete 24/11 - Trevo

         nLin+=12
         @ nLin,nCoL5 BUTTON STR0276 SIZE nSize,12 ACTION (DI154DespTela())  OF oDlg PIXEL //"&Despesas"
      EndIf
   Else
      nLin+=12
      // @ nLin,nCoL5 BUTTON STR0275 SIZE nSize,12 ACTION (DI154ValTxTela()) OF oDlg PIXEL WHEN (nTipoNF # NFE_COMPLEMEN)//"&Valores/Taxas"
      @ nLin,nCoL5 BUTTON STR0275 SIZE nSize,12 ACTION (DI154ValTxTela()) OF oDlg PIXEL WHEN (lApuraCIF)//"&Valores/Taxas"   // Bete 24/11 - Trevo

      nLin+=12
      @ nLin,nCoL5 BUTTON STR0276 SIZE nSize,12 ACTION (DI154DespTela())  OF oDlg PIXEL //"&Despesas"
   ENDIF

// IF nTipoNF # NFE_COMPLEMEN .AND. !lGravaWorks .AND. !lGerouNFE
   IF lImpostos .AND. !lGerouNFE  .AND. !lGravaWorks// Bete 24/11 - Trevo
      nLin+=12
      @ nLin,nCoL5 BUTTON STR0277 SIZE nSize,12 ACTION (DI154Altera(oMark)) OF oDlg PIXEL WHEN lAlteraAdicaoPE //"&Altera NCM"  // LBL - 13/06/2013
   ENDIF
   IF lAcresDeduc .AND. (lLerNota .OR. (lImpostos .AND. lGravaWorks))
      nLin+=12
      @ nLin,nCoL5 BUTTON STR0338 SIZE nSize,12 ACTION (DI154AcresDeduc()) OF oDlg PIXEL WHEN lAcresDeducPE //STR0338 "Acresc/Deduc."  // LBL - 13/06/2013
 
   ENDIF

   IF cPaisLoc == "BRA" .AND. nTipoNF # CUSTO_REAL
      nLin+=12
      @ nLin,nCoL5 BUTTON STR0339 SIZE nSize,12 ACTION (EICDI155(99)) WHEN (lGerouNFE .OR. lGravaWorks) OF oDlg PIXEL WHEN lGeraINPE //STR0339 "Gera I.N. 68/86"  // LBL - 13/06/2013
   ENDIF   

   IF lGravaWorks 
      nLin+=12
      @ nLin,nCoL5 BUTTON STR0100 SIZE nSize,12 ACTION (DIMostraTotais()) OF oDlg PIXEL //"&Totais"
      nLin+=12 
      @ nLin,nCoL5 BUTTON STR0278 SIZE nSize,12 ACTION (nOpca:=3,oDlg:End()) OF oDlg PIXEL //"I&mpressão"
   ENDIF
   
   //BHF - 24/07/08
   If ExistBlock("EICDI154")
      ExecBlock("EICDI154",.F.,.F.,"PRIMEIRA_NOTA")
   EndIf               
   
   //DRL - 09/03/09
   If FindFunction("U_EICDILOG")
      nLin+=12
      @ nLin,nCoL5 BUTTON "LogNf" SIZE nSize,12 ACTION (U_EICDILOG("EICDI154")) OF oDlg PIXEL
   EndIF
   //SVG - 03/05/2010 - 
   If nTipoNF = CUSTO_REAL .And. FindFunction("DI154PRETXT")
      nLin+=12 
      @ nLin,nCoL5 BUTTON STR0259 SIZE nSize,12 ACTION ((Processa({||DI154PRETXT()},STR0031),nOpca:=0)) OF oDlg PIXEL // EXPORTA
   EndIf
   IF lGravaWorks
      Work1->(DBSETORDER(5))
      Work1->(DBGOTOP())
      oMark:= MsSelect():New("Work1",,,TB_Campos2,.T.,@cMarca,{103,1,(oDlg:nClientHeight-6)/2,(oDlg:nClientWidth-4)/2})
   ELSE
      oMark:= MsSelect():New("Work2",,,TB_Campos1,.T.,@cMarca,{103,1,(oDlg:nClientHeight-6)/2,(oDlg:nClientWidth-4)/2})
   ENDIF

// IF nTipoNF # NFE_COMPLEMEN .AND. !lGravaWorks .AND. !lGerouNFE
// IF lImpostos .AND. !lGravaWorks .AND. !lGerouNFE    // Bete 24/11 - Trevo
//    oMark:bAval:={|| DI154Altera(oMark)}
// ENDIF
   IF lImpostos .AND. !lGerouNFE  // Bete 24/11 - Trevo
      IF !lGravaWorks .AND. nTipoNF <> CUSTO_REAL
         oMark:bAval:={|| DI154Altera(oMark)}
      ENDIF
   ENDIF

   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"TELA1"),)
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"TELA1"),)   
   oDlg:lMaximized:=.T.
   
   oPanel:Align:=CONTROL_ALIGN_TOP //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
   oMark:oBrowse:Align:=CONTROL_ALIGN_ALLCLIENT  //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
   
   ACTIVATE MSDIALOG oDlg ON INIT (oMark:oBrowse:Refresh()) //LRL 07/04/04 - Alinhamento MDI. //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT

   DO CASE
      CASE nOpca = 0            
           IF lEIB_Processa .AND. lAlterouAliquotas .AND. !lGerouNFE .AND. MsgYesNo(STR0260) //"Deseja Gravar as Alterações das N.C.M.'s ?"
              DI154LeEIB(.F.)  
           ENDIF
           EXIT
      CASE nOpca = 1 
           lNoErro:=.T.
           Processa({|| lNoErro:=DI154Delet() },STR0090) //"Processando Estorno..."
           /*  Nopado por GFP - 17/08/2012 - Validação impacta no ponto de entrada abaixo.
           IF !lNoErro
              E_RESET_AREA()
              //LOOP
           ENDIF
           */
           EXIT 
      CASE nOpca = 2 ; DI154Itens(bDDIFor,bDDIWhi) // Itens
      CASE nOpca = 3 ; EICDI155(nTipoNF) //Impressão
   ENDCASE

ENDDO

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"FIM_TELA1"),) // By JPP - 28/04/2010 - Criação de Ponto de Entrada.

E_RESET_AREA()

Return .T.

*------------------------------------------------*
Function DI154ValTxTela()
*------------------------------------------------*      
LOCAL oDlg, nLin, nCoL1, nCoL2, nCoL3, nCoL4, nCoL5, nCoL6, aTB_CpoTot,oMarkTot,oPanelTop, oPanelBtn
Private lSegInc  := SW9->(FIELDPOS("W9_SEGINC")) # 0 .AND. SW9->(FIELDPOS("W9_SEGURO")) # 0 .AND. ;
                   SW8->(FIELDPOS("W8_SEGURO")) # 0 .AND. SW6->(FIELDPOS("W6_SEGINV")) # 0
                   //EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)

nLin :=005
nCoL1:=005
nCoL2:=040
nCoL3:=100
nCoL4:=145
nCoL5:=205
nCoL6:=246
aTB_CpoTot:={}
AADD(aTB_CpoTot,{"W9_MOE_FOB" ,,AVSX3("W9_MOE_FOB",5),AVSX3("W9_MOE_FOB",6)})
AADD(aTB_CpoTot,{"W9_FOB_TOT" ,,AVSX3("W9_FOB_TOT",5),AVSX3("W9_FOB_TOT",6)})
AADD(aTB_CpoTot,{"W9_INLAND"  ,,AVSX3("W9_INLAND" ,5),AVSX3("W9_INLAND" ,6)})
AADD(aTB_CpoTot,{"W9_PACKING" ,,AVSX3("W9_PACKING",5),AVSX3("W9_PACKING",6)})
AADD(aTB_CpoTot,{"W9_DESCONT" ,,AVSX3("W9_DESCONT",5),AVSX3("W9_DESCONT",6)})
AADD(aTB_CpoTot,{"W9_FRETEIN" ,,AVSX3("W9_FRETEIN",5),AVSX3("W9_FRETEIN",6)})
AADD(aTB_CpoTot,{"W9_OUTDESP" ,,AVSX3("W9_OUTDESP",5),AVSX3("W9_OUTDESP",6)})
// EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP
IF lSegInc
   AADD(aTB_CpoTot,{"W9_SEGURO",,AVSX3("W9_SEGURO",5),AVSX3("W9_SEGURO",6)})
ENDIF
AADD(aTB_CpoTot,{"W6_FOB_TOT" ,,STR0341        ,AVSX3("W6_FOB_TOT",6)}) //STR0341 "Total Geral"

IF Work_Tot->(BOF()) .AND. Work_Tot->(EOF())
   Processa({|| DI154SomaTotais() },STR0340) //STR0340 "Somando totais"
ENDIF                             

nSomaCif := nSomaNoCIF + nPSomaNoCIF
   
DEFINE MSDIALOG oDlg TITLE STR0279 ; //"Visualiza Valores/Taxas"
       FROM oMainWnd:nTop+080,oMainWnd:nLeft TO oMainWnd:nBottom-60,oMainWnd:nRight-10;//420,650;
       OF oMainWnd PIXEL  
 @ 00,00 MsPanel oPanelTOP Prompt "" Size nCoL6+60,70 of oDlg //LRL 08/04/04 Painel para alinhamento MDI.
 @ nLin,nCoL1 SAY STR0042 SIZE 57,7 OF oPanelTOP PIXEL//"Vlr. Neg. (R$)"
 @ nLin,nCoL2 MSGET nFOB_R PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT  PIXEL

 @ nLin,nCoL3 SAY STR0043 SIZE 57,7 OF oPanelTOP PIXEL//"Frete R$" 
 @ nLin,nCoL4 MSGET n_FRETE PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT  PIXEL

 @ nLin,nCoL5 SAY STR0044    SIZE 57,7 OF oPanelTOP PIXEL //"Seguro R$"
 @ nLin,nCoL6 MSGET n_SEGURO PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT  PIXEL

 nLin+=12
 //@ nLin,nCoL1 SAY STR0071  SIZE 57,7  PIXEL //"Despesas"
 //@ nLin,nCoL2 MSGET n_Desp PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT  PIXEL

 @ nLin,nCoL1 SAY AVSX3("W6_TX_US_D",5) SIZE 57,7 OF oPanelTOP PIXEL
 @ nLin,nCoL2 MSGET SW6->W6_TX_US_D PICTURE PICT15_8 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL

 @ nLin,nCoL3 SAY STR0284 SIZE 57,7 OF oPanelTOP PIXEL//"Desp. Base (R$)"
 @ nLin,nCoL4 MSGET nSomaCIF PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL

 @ nLin,nCoL5 SAY STR0045  SIZE 57,7 OF oPanelTOP PIXEL//"C.I.F. (R$)"
 @ nLin,nCoL6 MSGET n_CIF  PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL//oSayCIF VAR 

 nLin+=12
 IF cPaisLoc == "BRA"
    @ nLin,nCoL1 SAY STR0048  SIZE 57,7 OF oPanelTOP PIXEL//"I.I. (R$)"
    @ nLin,nCoL2 MSGET n_II   PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL

    @ nLin,nCoL3 SAY STR0050  SIZE 57,7 OF oPanelTOP PIXEL//"I.P.I. (R$)"
    @ nLin,nCoL4 MSGET n_IPI  PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL
   
 ENDIF

// LDR - 05/11/04
 IF lMV_PIS_EIC
    @ nLin,nCoL5 SAY AVSX3("W8_VLRPIS",5)  SIZE 57,7 OF oPanelTOP PIXEL//"PIS "
    @ nLin,nCoL6 MSGET n_PIS   PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL
 EndIf

 nLin+=12

 IF lMV_PIS_EIC
    @ nLin,nCoL1 SAY AVSX3("W8_VLRCOF",5)  SIZE 57,7 OF oPanelTOP PIXEL//"COFINS"
    @ nLin,nCoL2 MSGET n_COFINS  PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL
 ENDIF

 IF cPaisLoc == "BRA"                              
                      
   IF nTipoNF <> CUSTO_REAL
      nDESPBASEICMS := DITRANS(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)
   ELSE                                                          			
      IF !lTemPrimeira                                                               		
         nDESPBASEICMS := DITRANS( nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)           
      ELSE
         IF !lTemCusto .And. GetMV("MV_LERNOTA",,.F.)                                            		
            nDESPBASEICMS := DITRANS(nSomaBaseICMS + nPSomaBaseICMS ,2)
         ELSE 
            nDESPBASEICMS := DITRANS( nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)
         ENDIF      
      ENDIF
   ENDIF
                          
    @ nLin,nCoL3 SAY STR0343  SIZE 57,7 OF oPanelTOP PIXEL //STR0343 "Desp.Base ICMS"
    @ nLin,nCoL4 MSGET nDESPBASEICMS  PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL//oSayCIF VAR 

    @ nLin,nCoL5 SAY STR0052  SIZE 57,7  OF oPanelTOP  PIXEL//"I.C.M.S. (R$)"
    @ nLin,nCoL6 MSGET n_ICMS PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL 
    
 EndIf

// LDR - 05/11/04

 nLin+=13
 @ nLin,nCoL3 SAY cTotal SIZE 150,7 OF oPanelTOP PIXEL //"Total Geral CIF + II + IPI + ICMS + Outras Desp. (R$)"
 @ nLin,nCoL6 MSGET n_VlTota PICTURE PICT15_2 SIZE 57, 7 OF oDlg WHEN .F. RIGHT PIXEL


 nLin+=14
 @ 1.3,1.5 TO nLin,nCoL6+60  PIXEL
/* SVG - 24/05/2011 - Não se trata de work especifica da tabela, o que ocasiona erros devido a campos de usuario não inseridos na work. 
 //by GFP - 29/09/2010 :: 14:34 - Inclusão da função para carregar campos criados pelo usuario.
 aTB_CpoTot := AddCpoUser(aTB_CpoTot,"SW9","2") 
*/
 oMarkTot:=MSSELECT():New("Work_Tot",,,aTB_CpoTot,lInverte,cMarca,{nLin,1,((oDlg:nClientHeight-4)/2)-20,(oDlg:nClientWidth-4)/2})
 oMarkTot:oBrowse:bWhen:={||DBSELECTAREA("Work_Tot"),.T.}
 @00,00 MsPanel oPanelBTN Prompt "" Size nCoL6+60,24 of oDlg
 DEFINE SBUTTON FROM 5,5 TYPE 01 ACTION oDlg:End() ENABLE  of oPanelBtn 
oDlg:lMaximized:=.T.
oPanelTOP:Align:=CONTROL_ALIGN_TOP
oPanelBtn:Align:=CONTROL_ALIGN_BOTTOM
oMarkTot:oBrowse:Align:=CONTROL_ALIGN_ALLCLIENT 
ACTIVATE DIALOG oDlg ;
                ON INIT (oMarkTot:oBrowse:Refresh())  //LRL 07/04/04 -Alinhament MDI.

RETURN .T.
*------------------------------------*
Function DI154SomaTotais()
*------------------------------------*
LOCAL cFilSW8:=xFilial("SW8")
LOCAL cFilSW9:=xFilial("SW9")
PRIVATE lTotaisInv:=.F.
Private lSegInc  := SW9->(FIELDPOS("W9_SEGINC")) # 0 .AND. SW9->(FIELDPOS("W9_SEGURO")) # 0 .AND. ;
                   SW8->(FIELDPOS("W8_SEGURO")) # 0 .AND. SW6->(FIELDPOS("W6_SEGINV")) # 0
                   //EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"TOTAIS_1"),)

ProcRegua(SW8->(LASTREC()))
SW8->(DBSETORDER(1))
SW9->(DBSETORDER(1))

SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))

DO While !SW8->(Eof()) .AND. ;
          SW8->W8_FILIAL == cFilSW8 .AND.;
          SW8->W8_HAWB   == SW6->W6_HAWB

   IncProc(STR0344+SW8->W8_INVOICE) //STR0344 "Somando Invoice: "

   //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
   SW9->(DBSEEK(cFilSW9+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+SW8->W8_HAWB))
   
   IF lTotaisInv
      Work_Tot->(DBSETORDER(1))
      IF !Work_Tot->(DBSEEK('1'+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")))
          Work_Tot->(DBAPPEND())
          Work_Tot->WKCODIGO  :='1'
          Work_Tot->W9_INVOICE:=SW8->W8_INVOICE
          Work_Tot->W9_FORN   :=SW8->W8_FORN
          If EICLoja()
             Work_TOT->W9_FORLOJ := SW8->W8_FORLOJ
          EndIf
          Work_Tot->W9_MOE_FOB:=SW9->W9_MOE_FOB
          Work_Tot->TRB_ALI_WT:="SW8"
          Work_Tot->TRB_REC_WT:=SW8->(Recno())
      ENDIF
      Work_Tot->W9_FOB_TOT+=(SW8->W8_PRECO*SW8->W8_QTDE)
      Work_Tot->W9_INLAND +=SW8->W8_INLAND
      Work_Tot->W9_PACKING+=SW8->W8_PACKING
      Work_Tot->W9_DESCONT+=IF(!lIn327,SW8->W8_DESCONT,0) // JBS - 29/10/2003
      Work_Tot->W9_FRETEIN+=SW8->W8_FRETEIN
      Work_Tot->W9_OUTDESP+=SW8->W8_OUTDESP
      // EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)
      IF lSegInc
         Work_Tot->W9_SEGURO+=SW8->W8_SEGURO
      ENDIF 
      Work_Tot->W6_FOB_TOT+=DI500RetVal("ITEM_INV", "TAB", .T.,, .T.) // EOB - 14/07/08 - chamada da função DI500RetVal
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"TOTAIS_2"),)
   ENDIF
   Work_Tot->(DBSETORDER(2))
   IF !Work_Tot->(DBSEEK('2'+SW9->W9_MOE_FOB))
      Work_Tot->(DBAPPEND())
      Work_Tot->WKCODIGO  :='2'
      Work_Tot->W9_INVOICE:=STR0345 //STR0345 "Total Moeda:"
      Work_Tot->W9_MOE_FOB:=SW9->W9_MOE_FOB
      Work_Tot->TRB_ALI_WT:="SW9"
      Work_Tot->TRB_REC_WT:=SW9->(Recno())
   ENDIF
   Work_Tot->W9_FOB_TOT+=(SW8->W8_PRECO*SW8->W8_QTDE)
   Work_Tot->W9_INLAND +=SW8->W8_INLAND
   Work_Tot->W9_PACKING+=SW8->W8_PACKING
   Work_Tot->W9_DESCONT+=IF(!lIn327,SW8->W8_DESCONT,0) // JBS 29/10/2003
   Work_Tot->W9_FRETEIN+=SW8->W8_FRETEIN
   Work_Tot->W9_OUTDESP+=SW8->W8_OUTDESP
   // EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)
   IF lSegInc
      Work_Tot->W9_SEGURO+=SW8->W8_SEGURO
   ENDIF 
   Work_Tot->W6_FOB_TOT+=DI500RetVal("ITEM_INV", "TAB", .T.,, .T.) // EOB - 14/07/08 - chamada da função DI500RetVal
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"TOTAIS_3"),)
   SW8->(DBSKIP())
ENDDO
Work_TOT->(DBGOTOP())
RETURN .T.

*-----------------------------------------*
Function DI154DespTela()
*-----------------------------------------*
LOCAL oDlg
Private TB_Campos:={} //BHF - 01/09/08

aAdd(TB_Campos,{"WKDESP"   ,,STR0071}) //"Despesas"
aAdd(TB_Campos,{"WKVALOR"  ,,STR0281,"@E 99,999,999,999.99"}) //"Valor (R$)"
aAdd(TB_Campos,{{||DI154SimNao(Work4->WKBASECUS,1)},,AVSX3("YB_BASECUS",5)})
aAdd(TB_Campos,{{||DI154SimNao(Work4->WKBASEIMP,2)},,AVSX3("YB_BASEIMP",5)})
aAdd(TB_Campos,{{||DI154SimNao(Work4->WKBASEICM,2)},,AVSX3("YB_BASEICM",5)})
SYT->(dBSeek(xFilial("SYT")+SW6->W6_IMPORT))
aAdd(TB_Campos,{{||DI154SimNao(Work4->WKICMS_UF,2)},,AVSX3("YB_BASEICM",5)+" - "+SYT->YT_ESTADO})
aAdd(TB_Campos,{{||DI154SimNao(Work4->WKRATPESO,2)},,AVSX3("YB_RATPESO",5)})
aAdd(TB_Campos,{"WKNOTA"   ,,AVSX3("WD_NF_COMP",5)}) 
aAdd(TB_Campos,{"WKSERIE"  ,,AVSX3("WD_SE_NFC" ,5)})
  
//AST - 25/07/08
IF ExistBlock("EICDI154")
   Execblock("EICDI154",.F.,.F.,"DESP_TELA")
ENDIF   

oMainWnd:ReadClientCoords()
DEFINE MSDIALOG oDlg TITLE STR0346; //STR0346 "Visualiza Despesas"
      FROM oMainWnd:nTop+070,oMainWnd:nLeft+5 TO oMainWnd:nBottom-70,oMainWnd:nRight-10;
      OF oMainWnd PIXEL

  Work4->(dBGoTop())                         

  oMark2:=oSend(MsSelect(),"New","Work4",,,TB_Campos,.F.,@cMarca,{002,002,(oDlg:nClientHeight-50)/2,(oDlg:nClientWidth-4)/2})
  @00,00 MsPanel oPanelBTN Prompt "" Size 60,24 of oDlg //LRL 08/04/04 - Painel para alinhamento MDI.
  DEFINE SBUTTON FROM 5,oMainWnd:nLeft+10 TYPE 01 ACTION oDlg:End() ENABLE  of oPanelBtn Pixel
  oDlg:lMaximized:=.T.
  oPanelBtn:Align:=CONTROL_ALIGN_BOTTOM //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
  oMark2:oBrowse:Align:=CONTROL_ALIGN_ALLCLIENT //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
ACTIVATE DIALOG oDlg ON INIT (oMark2:oBrowse:Refresh()) //LRL 08/04/04 -Alinhamento MDI //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT

RETURN .T.
*-----------------------------------------*
Function DI154SimNao(cCampo,nBranco)
*-----------------------------------------*
IF AT(SWD->(LEFT(Work4->WKDESP,1)),"129") =0 .AND. Work4->WKDESP <> "701"
   DO CASE 
      CASE cCampo  $ cSim ; RETURN STR0261//"1-Sim"
      CASE cCampo  $ cNao ; RETURN STR0262//"2-Não"
      CASE nBranco = 1    ; RETURN STR0261//"1-Sim"
      CASE nBranco = 2    ; RETURN STR0262//"2-Não"
   ENDCASE
ENDIF
RETURN "   "

*-----------------------------------*
Function DI154Itens(bDDIFor,bDDIWhi)
*-----------------------------------*
LOCAL lInverte := .F., oDlg, oPanel
//LOCAL cBotao:=IF(nTipoNF # CUSTO_REAL,STR0282,STR0283) //"&Gera NFE"###"&Grava"
LOCAL nCol:=IF(!lNFAutomatica.AND.nTipoNF#CUSTO_REAL,31,17)
Private cBotao:=IF(nTipoNF # CUSTO_REAL,STR0282,STR0283) //"&Gera NFE"###"&Grava"  // SVG - 16/09/08
PRIVATE nOpca := 0 // POR CAUSA DO BOTAO DO RDMAKE
DO WHILE .T.
   
   IF lExisteSEQ_ADI .AND. !lNFAutomatica
      Work1->(DBSETORDER(6))
   ELSE
      Work1->(DBSETORDER(5))
   ENDIF
   Work1->(DBGOTOP())
   nOpca:=0
   
   oMainWnd:ReadClientCoords()
   DEFINE MSDIALOG oDlg TITLE STR0097 ; //"Itens da NF's"
      FROM oMainWnd:nTop+125,oMainWnd:nLeft+5 TO oMainWnd:nBottom-60,oMainWnd:nRight-10;
      OF oMainWnd PIXEL  

  // AvStAction("210",.F.)//AWR - 03/02/2010 - Para versão M11 utilizar o ponto de entrada abaixo para customizar o Conta e Ordem.
   
   Private oDlgPrv := oDlg   
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ALTERA_INDICE"),)  // TLM 24/06/08 - Ponto para alterar a ordem do indice da work1.
   
   //GFP 22/10/2010
//   TB_Campos2 := AddCpoUser(TB_Campos2,"SWN","2")
   
   oMark:= MsSelect():New("Work1","WKFLAG",,TB_Campos2,@lInverte,@cMarca,{nCol,1,if(SetMdiChild(),(oDlg:nClientHeight-30)/2,(oDlg:nClientHeight-6)/2),(oDlg:nClientWidth-4)/2})//LRL 07/04/04 -SeTMDIChild - Se é MDI.
   IF lNFAutomatica .OR. nTipoNF == CUSTO_REAL
      oMark:bAval:={||DI154It_Alt(),oMark:oBrowse:Refresh()}
   ENDIF

   @ 00,00 MsPanel oPanel Prompt "" Size 60,30 of oDlg //LRL 08/04/04 Painel para alinhamento MDI.
   
   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"BOTAO"),)
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"BOTAO_ITENS"),)   
 
   IF cPaisLoc == "BRA"
   @ 04,095 BUTTON STR0102  SIZE 35,11 ACTION (DI154It_Alt(),oMark:oBrowse:Refresh());
                                       OF oDlg PIXEL WHEN !lGerouNFE .AND. lAlteraItemPE //"&Altera Item"  // LBL - 13/06/2013
   ENDIF
   @ 04,135 BUTTON STR0272  SIZE 35,11 ACTION (nOpca:=1,oDlg:End());
                                       OF oDlg PIXEL WHEN (nTipoNF#CUSTO_REAL.OR.lGerouNFE)//"&Impressão"

   @ 04,175 BUTTON STR0101  SIZE 30,11 ACTION (DI154Pesquisa(),oMark:oBrowse:Refresh());
                                       OF oDlg PIXEL //"&Pesquisa"

   @ 04,210 BUTTON STR0100  SIZE 30,11 ACTION (DIMostraTotais(),oMark:oBrowse:Refresh());
                                       OF oDlg PIXEL //"&Totais"
   
   @ 04,241 BUTTON cBotao   SIZE 45,11 ACTION (nOpca:=2,oDlg:End());
                                       OF oDlg PIXEL WHEN (lGeraNF.AND.!lGerouNFE)  .AND. lBotaoPE   // LBL - 13/06/2013

   @ 04,290 BUTTON STR0103  SIZE 30,11 ACTION (nOpca:=0,oDlg:End());
                                       OF oDlg PIXEL //"&Sair"

   IF !lNFAutomatica .AND. nTipoNF # CUSTO_REAL
      @ 17,210 BUTTON STR0098 SIZE 50,11 ACTION (DIMarcados(.T.),oMark:oBrowse:Refresh()) OF oDlg PIXEL WHEN !lGerouNFE .And. lAlteraItemPE//"A&ltera Marcados"

      @ 17,265 BUTTON STR0099 SIZE 55,11 ACTION (DIMarcados(.F.),oMark:oBrowse:Refresh()) OF oDlg PIXEL WHEN !lGerouNFE//"&Marca/Desm. Todos"
   ENDIF
   oDlg:lMaximized:=.T.

   
   //AvStAction("211",.F.)//AWR - 03/02/2010 - Para versão M11 utilizar o ponto de entrada abaixo para customizar o Conta e Ordem.
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ITEM_NF"),)
   oPanel:Align:=CONTROL_ALIGN_TOP //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
   oMark:oBrowse:Align:=CONTROL_ALIGN_ALLCLIENT //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT
   ACTIVATE MSDIALOG oDlg ON INIT (oMark:oBrowse:Refresh()) //LRL 08/04/04 -Alinhamento MDI //BCO 12/12/11 - Tratamento para acesso via ActiveX alterando o align para antes do INIT

   IF nOpca=1
      EICDI155(nTipoNF)
      LOOP
   ENDIF
   
   IF nOpca=2
      Processa({||DI154GerNF(@lGerouNFE,bDDIFor,bDDIWhi)},STR0104) //"Geracao de NF's"
      If !lGerouNFE ; LOOP ; ENDIF
   ENDIF

   IF nOpca=0
      EXIT
   ENDIF

ENDDO

Work2->(DBGOTOP())

RETURN .T.

*------------------------*
Function DIMarcados(lAlt)
*------------------------*
LOCAL oDlg, nOpca, nRecno:=Work1->(RECNO())
LOCAL cTit  :=IF(lAlt,(STR0105),STR0106) //"Altera‡Æo dos Itens Marcados"###"Marca / Desmarca Itens"
LOCAL bValid:=IF(lAlt,{||DI154Valid("NFE")      .AND.;
                         DI154Valid("SERIE",.F.).AND.;
                         DI154Valid("DATA")},{||.T.})
LOCAL nCo1:=0.8, nCo2:=6.3,nOrd:=Work1->(INDEXORD())
LOCAL nMarca:=1, cCFO:=Work1->WKFORN+EICRetLoja("WORK1", "WKLOJA")+Work1->WK_CFO,cMarcaNew,bWhile
Private lDesvioMsD := .F.                                            //NCF - 01/10/09 Variável criada para o ponto de entrada "DESVIO_MSDIALOG"
Private lAlterNota := lAlt                                           //      02/10/09 Variável criada para controlar a entrada no ponto
IF lAlt
   nOpca:=.T.
   Work1->( DBGOTOP() )
   Work1->( DBEVAL({|| nOpca:=!Work1->WKFLAG==cMarca },,{||nOpca}) )
   Work1->( DBGOTO(nRecno) )
   IF nOpca
      Help("",1,"AVG0000803")//"Não existe registros marcados"###"Informação"
      RETURN .F.
   Endif
Endif

cNumNFE  :=Work1->WK_NFE
cSerieNFE:=Work1->WK_SE_NFE
dDtNFE   :=dDataBase
IF !EMPTY(Work1->WK_DT_NFE)
   dDtNFE:=Work1->WK_DT_NFE
ENDIF
nOpca    :=0

If lAlt
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"DESVIO_MSDIALOG"),)  // NCF - 01/10/09 - Ponto de entrada criado para desvio da MsDialog
EndIf

If !lDesvioMsD
   DEFINE MSDIALOG oDlg TITLE cTit FROM 9,10 TO 18,48 Of oMainWnd

     IF lAlt

        @1.2,nCo1 SAY (STR0094) //"N§ da N.F."
        @2.2,nCo1 SAY (STR0095) //"S‚rie"
        @3.2,nCo1 SAY STR0096   //"Data da N.F."

        @1.2,nCo2 MSGET cNumNFE   PICTURE "@!"  SIZE 50,8 WHEN lAltNfeNum // Ricardo Dumbrovsky 08/12/04 -15:52
        @2.2,nCo2 MSGET cSerieNFE PICTURE "@!"  SIZE 15,8 WHEN lAltNfeNum // Ricardo Dumbrovsky 08/12/04 -15:52
        @3.2,nCo2 MSGET dDtNFE    PICTURE "@D"  SIZE 45,8

     ELSE

        @08,05 TO 45,70 OF oDlg PIXEL

        @18,10 RADIO nMarca ITEMS "&Por Forn. + CFO",STR0110 3D SIZE 49,12 PIXEL //###"&Todos os Itens"

     ENDIF

     @14,105 BUTTON STR0111 SIZE 25,11 ACTION (If(EVAL(bValid),(nOpca:=1,oDlg:End()),)) OF oDlg PIXEL //"&OK"

     @34,105 BUTTON STR0103 SIZE 25,11 ACTION (nOpca:=0,oDlg:End())                     OF oDlg PIXEL //"&Sair"

     IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"DLG_MARCADOS"),)                   

   ACTIVATE MSDIALOG oDlg CENTERED
   
   If nOpca = 0
      RETURN .F.
   Endif  

EndIf
cMarcaNew:=IF(Work1->WKFLAG==cMarca,"  ",cMarca)

bWhile:={||.T.}

Work1->(DBSETORDER(5))
Work1->(DBGOTOP())

IF !lAlt .AND. nMarca == 1
   bWhile:={|| cCFO == Work1->WKFORN+EICRetLoja("WORK1", "WKLOJA")+Work1->WK_CFO }
   Work1->(DBSEEK(cCFO))
ENDIF

Processa({|| DIGravaAlt(lAlt,bWhile,cMarcaNew)},STR0112) //"Alterando Itens..."

Work1->(DBSETORDER(nOrd))
Work1->(DBGOTO(nRecno))


RETURN .T.

*----------------------------------------------------------------------------*
Function DIGravaAlt(lAlt,bWhile,cMarcaNew)
*----------------------------------------------------------------------------*

ProcRegua(Work1->(LASTREC()))

DO WHILE !Work1->(EOF()) .AND. EVAL(bWhile)

   IncProc(STR0113+' '+Work1->WKCOD_I) //"Processando Item: "

   IF Work1->WKFLAG == cMarca .AND. lAlt

      Work1->WK_NFE   := cNumNFE
      Work1->WK_SE_NFE:= cSerieNFE
      Work1->WK_DT_NFE:= dDtNFE
      Work1->WKFLAG   := '  '
     
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRV_MARCADOS"),)                   

      Work3->(DBSEEK(Work1->(RECNO())))

      DO WHILE !Work3->(EOF()) .AND. Work1->(RECNO()) == Work3->WKRECNO

         Work3->WK_NF_COMP:=cNumNFE
         Work3->WK_SE_NFC :=cSerieNFE
         Work3->WK_DT_NFC :=dDtNFE
         Work3->(DBSKIP())

      ENDDO

   ELSEIF !lAlt

      Work1->WKFLAG := cMarcaNew

   ENDIF

   Work1->(DBSKIP())

ENDDO

RETURN .T.

*-----------------------*
Function DIMostraTotais()
*-----------------------*
LOCAL nCo1:=0.5, nCo2:=5, nCo3:=12.5, nCo4:=20
LOCAL nTotNFE:= nVlTota:= 0,nLinha
PRIVATE nFobR:=nFrete:=nSeguro:=nCIF:=nII:=nIPI:=nDespBaseICMS:=nDespBasCIF:=0
PRIVATE nBaseIPI:=nBaseICMS:=nICMS:=nDesp:=nDIFOB:=0,lSair:=.F.
PRIVATE nBASPIS:=nVLRPIS:=nBASCOF:=nVLRCOF:=nAcres:=nDeduc:=0
Private oGet_Esc, cGet_Esc := "" //RRV - 19/09/2012 - Tratamento para o "ESC" to teclado funcionar corretamente

IF ExistBlock("ICPADDI0")
   Execblock("ICPADDI0",.F.,.F.,'TELA_TOTAIS')
   IF lSair
      RETURN .T.
   ENDIF
ENDIF

IF ExistBlock("EICDI154")
   Execblock("EICDI154",.F.,.F.,'TELA_TOTAIS')
   IF lSair
      RETURN .T.
   ENDIF
ENDIF

Processa({|| DI154Soma()},STR0114) //"Calculando Totais"

IF EMPTY(nDespBasCIF)
   nDespBasCIF:=nSomaNoCIF + nPSomaNoCIF
ENDIF
IF EMPTY(nDespBaseICMS)
   nDespBaseICMS:=nSomaBaseICMS + nPSomaBaseICMS + nTxSisc
ENDIF

//nTotNFE:=DITRANS(nDIFOB,2)+DITRANS(nIPI,2)
//nVlTota:=DITRANS((nTotNFE+nICMS),2)
nVlTota := DITRANS(nCIF + nII + nIPI + nICMS + nVLRPIS + nVLRCOF,2)
IF nTipoNF > 1 .AND. nTipoNF <= 4
   nVlTota += DITRANS(nDesp,2)
ENDIF
IF lImpostos .And. !(lTemCusto .And. nTipoNF == CUSTO_REAL)                     //NCF - 16/08/2011
   nVlTota += DITRANS(nDespBaseICMS,2)
ENDIF

DEFINE MSDIALOG oDlg TITLE STR0115 FROM 0,10 TO 18,66 Of oMainWnd //"TOTAIS"
     
nLinha := .5
@nLinha,nCo1 SAY STR0042 //"FOB (R$)"
@nLinha,nCo2 MSGET nFobR WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1

@nLinha,nCo1 SAY STR0043 //"Frete (R$)"
@nLinha,nCo2 MSGET nFrete WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1

@nLinha,nCo1 SAY STR0044 //"Seguro (R$)"
@nLinha,nCo2 MSGET nSeguro WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1
IF !EMPTY(nDespBasCIF) .AND. !EMPTY(nCIF) //.AND. (EMPTY(nDesp) .OR. EMPTY(nBaseICMS) .OR. EMPTY(nDespBaseICMS))
   @nLinha,nCo1 SAY "Desp Base CIF (R$)"
   @nLinha,nCo2 MSGET nDespBasCIF WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF      
IF !EMPTY(nAcres) .AND. !EMPTY(nCIF) 
   @nLinha,nCo1 SAY STR0323 //STR0323 "Acréscimos"
   @nLinha,nCo2 MSGET nAcres WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF      
IF !EMPTY(nDeduc) .AND. !EMPTY(nCIF) 
   @nLinha,nCo1 SAY STR0324 //STR0324 "Deduções"
   @nLinha,nCo2 MSGET nDeduc WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF      

@nLinha,nCo1 SAY STR0348 //STR0045 //"C.I.F.(R$)" //STR0348 "C.I.F. (R$) (B.II)"
@nLinha,nCo2 MSGET nCIF WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT   
nLinha+=1

@nLinha,nCo1 SAY STR0048 //"I.I. (R$)"
@nLinha,nCo2 MSGET nII  WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1

@nLinha,nCo1 SAY STR0060 //"Base I.P.I. (R$)"
@nLinha,nCo2 MSGET nBaseIPI  WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1

@nLinha,nCo1 SAY STR0050 //"I.P.I. (R$)"
@nLinha,nCo2 MSGET nIPI  WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT

nLinha:=.5

IF lMV_PIS_EIC
   @nLinha,nCo3 SAY AVSX3("W8_BASPIS",5)
   @nLinha,nCo4 MSGET nBASPIS WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1

   @nLinha,nCo3 SAY AVSX3("W8_VLRPIS",5)
   @nLinha,nCo4 MSGET nVLRPIS WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1

   @nLinha,nCo3 SAY AVSX3("W8_BASCOF",5)
   @nLinha,nCo4 MSGET nBASCOF WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1

   @nLinha,nCo3 SAY AVSX3("W8_VLRCOF",5)
   @nLinha,nCo4 MSGET nVLRCOF WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF

IF !EMPTY(nDespBaseICMS)

   //TRP - 10/06/11 - Caso seja Nota Filha e o parâmetro MV_NFFILHA seja 0 ou 2, não mostrar cálculo das despesas base ICMS na tela de Totais.
   If lMV_NF_MAE .AND. nTipoNF == NFE_FILHA .And. GetMV("MV_NFFILHA",,"0") <> "1"
      nVlTota:= nVlTota - nDespBaseICMS
      nDespBaseICMS:= 0
   Endif
   
   @nLinha,nCo3 SAY STR0329 // STR0329 "Desp Base ICMS(R$)"
   @nLinha,nCo4 MSGET nDespBaseICMS WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF
IF !EMPTY(nBaseICMS)
   @nLinha,nCo3 SAY STR0062 //"Base I.C.M.S. (R$)"
   @nLinha,nCo4 MSGET nBaseICMS WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF
@nLinha,nCo3 SAY STR0052 //"I.C.M.S. (R$)"
@nLinha,nCo4 MSGET nICMS     WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1

IF !EMPTY(nDesp) .AND. nTipoNF > 1 .AND. nTipoNF <= 4
   @nLinha,nCo3 SAY STR0053 //"Outras Desp.(R$)"
   @nLinha,nCo4 MSGET nDesp  WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
   nLinha+=1
ENDIF
@nLinha,nCo3 SAY STR0082 //"Total Geral"
@nLinha,nCo4 MSGET nVlTota   WHEN .F. PICTURE PICT15_2 SIZE 55,8 RIGHT
nLinha+=1

@1200,1200 MsGet oGet_Esc Var cGet_Esc Of oDlg //RRV - 19/09/2012 - Tratamento para o "ESC" to teclado funcionar corretamente
oGet_Esc:SetFocus()

ACTIVATE MSDIALOG oDlg CENTERED

RETURN NIL

*----------------------*
Function DI154Soma()
*----------------------*
LOCAL nRecno:=Work1->(RECNO())

ProcRegua( Work1->(LASTREC()) )
Work1->(DBGOTOP())

DO WHILE !Work1->(EOF())
   IncProc()
   nFobR    +=Work1->WKFOB_R
   nFrete   +=Work1->WKFRETE
   nSeguro  +=Work1->WKSEGURO
   nCIF     +=Work1->WKCIF
   nII      +=Work1->WKIIVAL
   nBaseIPI +=Work1->WKIPIBASE
   nIPI     +=Work1->WKIPIVAL
   nBaseICMS+=Work1->WKBASEICMS
   nICMS    +=Work1->WKVL_ICM
   nDIFOB   +=Work1->WKVALMERC
   nDesp    +=Work1->WKOUT_DESP
   nBASPIS  +=Work1->WKBASPIS
   nVLRPIS  +=Work1->WKVLRPIS
   nBASCOF  +=Work1->WKBASCOF
   nVLRCOF  +=Work1->WKVLRCOF
   nDespBasCIF  +=Work1->WKDESPCIF
   nDespBaseICMS+=Work1->WKDESPICM
   nAcres   +=Work1->WKVLACRES
   nDeduc   +=Work1->WKVLDEDUC
  
   Work1->(DBSKIP())
ENDDO

Work1->(DBGOTO(nRecno))

RETURN .T.

*----------------------*
Function DI154It_Alt()
*----------------------*
LOCAL nCif, oDlg, nOpca:=0, nRecno:=Work1->(RECNO())
LOCAL cConfirma:=(STR0121) //"Recalcula  FOB / CIF / Frete / Seguro ?"
LOCAL cTit2    :=(STR0122) //"Valor da Mercadoria Alterado"
LOCAL cTit     :=(STR0123) //"Altera‡Æo do Item Atual"

LOCAL nFOBRS  :=Work1->WKFOB_R
LOCAL nSeguro :=Work1->WKSEGURO
LOCAL nFrete  :=Work1->WKFRETE
LOCAL nVLCIF  :=Work1->WKCIF
LOCAL nVLMERC :=Work1->WKVALMERC

LOCAL nVlII   :=Work1->WKIIVAL
LOCAL nBaseIPI:=Work1->WKIPIBASE
LOCAL nVlIPI  :=Work1->WKIPIVAL
LOCAL nVlICMS :=Work1->WKVL_ICM
LOCAL nBasICMS:=Work1->WKBASEICMS
LOCAL n_DespBICMS:=Work1->WKDESPICM // SVG - 06/09/2011 - 
LOCAL nBASPIS  :=Work1->WKBASPIS
LOCAL nVLRPIS  :=Work1->WKVLRPIS
LOCAL nBASCOF  :=Work1->WKBASCOF
LOCAL nVLRCOF  :=Work1->WKVLRCOF
LOCAL nPrecoUnit:=Work1->WKPRUNI

LOCAL nCFOBRS  :=Work1->WKFOB_R
LOCAL nCSeguro :=Work1->WKSEGURO
LOCAL nCFrete  :=Work1->WKFRETE
LOCAL nCVLCIF  :=Work1->WKCIF
LOCAL nCVLMERC :=Work1->WKVALMERC
LOCAL nCVlII   :=Work1->WKIIVAL
LOCAL nCBaseIPI:=Work1->WKIPIBASE
LOCAL nCVlIPI  :=Work1->WKIPIVAL
LOCAL nCVlICMS :=Work1->WKVL_ICM
LOCAL nCBASPIS :=Work1->WKBASPIS
LOCAL nCVLRPIS :=Work1->WKVLRPIS
LOCAL nCBASCOF :=Work1->WKBASCOF
LOCAL nCVLRCOF :=Work1->WKVLRCOF
LOCAL nCBasICMS:=Work1->WKBASEICMS

LOCAL bValid:=IF(nTipoNF # CUSTO_REAL .AND. !lNFAutomatica,;
              {|| DI154Valid("NFE")       .AND. ;
                  DI154Valid("SERIE",.F.) .AND. ;
                  DI154Valid("DATA")},{||.T.})
LOCAL nCo1:=0.8, nCo2:=6.3, nCo3:=14.0, nCo4:=19.5
// SVG - 12/08/2010 - Para customização de tamanho da tela.
Private LIN_INI:= 60 , COL_INI:= 100 , LIN_FIM:= 340 , COL_FIM:= 560

cCod     :=Work1->WK_OPERACA+Work1->WKTEC+Work1->WKEX_NCM+Work1->WKEX_NBM
cNumNFE  :=Work1->WK_NFE
cSerieNFE:=Work1->WK_SE_NFE
dDtNFE   :=dDataBase
IF !EMPTY(Work1->WK_DT_NFE)
   dDtNFE:=Work1->WK_DT_NFE
ENDIF

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'ANTES_ITEM_ALTERA'),)

DEFINE MSDIALOG oDlg TITLE cTit FROM LIN_INI,COL_INI TO LIN_FIM,COL_FIM Of oMainWnd pixel


@1.4,nCo1 SAY (STR0094) //"N§ da N.F."
@2.4,nCo1 SAY (STR0095) //"S‚rie"
@3.4,nCo1 SAY STR0096 //"Data da N.F."
@4.4,nCo1 SAY STR0119 //"Vl. Mercadoria"
@5.4,nCo1 SAY STR0124 //"Valor FOB"
@6.4,nCo1 SAY STR0125 //"Valor Seguro"
@7.4,nCo1 SAY STR0126 //"Valor Frete"
@8.4,nCo1 SAY STR0127 //"Valor CIF"
@9.4,nCo1 SAY AVSX3("WN_PRUNI",5) //"Preco Unit."

@1.4,nCo2 MSGET cNumNFE   PICTURE "@!" SIZE 55,8 WHEN nTipoNF # CUSTO_REAL .AND. !lNFAutomatica .AND. lAltNfeNum // Ricardo Dumbrovsky 08/12/04 -15:50
@2.4,nCo2 MSGET cSerieNFE PICTURE "@!" SIZE 15,8 WHEN nTipoNF # CUSTO_REAL .AND. !lNFAutomatica .AND. lAltNfeNum // Ricardo Dumbrovsky 08/12/04 -15:50
@3.4,nCo2 MSGET dDtNFE    PICTURE "@D" SIZE 40,8 WHEN nTipoNF # CUSTO_REAL
@4.4,nCo2 MSGET nVLMERC   VALID nVLMERC>=0 PICTURE PICT15_2    SIZE 55,8
@5.4,nCo2 MSGET nFOBRS    VALID nFOBRS >=0 PICTURE PICT15_2    SIZE 55,8
@6.4,nCo2 MSGET nSeguro   VALID nSeguro>=0 PICTURE PICT15_2    SIZE 55,8
@7.4,nCo2 MSGET nFrete    VALID nFrete  >=0 PICTURE PICT15_2    SIZE 55,8
@8.4,nCo2 MSGET nVLCIF    VALID nVLCIF  >=0 PICTURE PICT15_2    SIZE 55,8
@9.4,nCo2 MSGET nPrecoUnit VALID nPrecoUnit  >=0 PICTURE PICT21_8    SIZE 55,8

@1.4,nCo3 SAY STR0128 //"Valor I.I."
@2.4,nCo3 SAY STR0129 //"Valor Base IPI"
@3.4,nCo3 SAY STR0130 //"Valor I.P.I."
nLinha:=4.4
IF lMV_PIS_EIC
   @nLinha,nCo3 SAY AVSX3("W8_BASPIS",5)
   nLinha+=1

   @nLinha,nCo3 SAY AVSX3("W8_VLRPIS",5)
   nLinha+=1

   @nLinha,nCo3 SAY AVSX3("W8_BASCOF",5)
   nLinha+=1

   @nLinha,nCo3 SAY AVSX3("W8_VLRCOF",5)
   nLinha+=1
   oDlg:nHeight+=50
ENDIF
@nLinha,nCo3 SAY LEFT(STR0062,13) //"Base I.C.M.S."
nLinha+=1
@nLinha,nCo3 SAY STR0131 //"Valor ICMS"
nLinha+=1
@nLinha,nCo3 SAY STR0284//"Desp. Base (R$)"

@1.4,nCo4 MSGET nVlII     VALID nVlII   >=0 PICTURE PICT15_2    SIZE 55,8
@2.4,nCo4 MSGET nBaseIPI  VALID nBaseIPI>=0 PICTURE PICT15_2    SIZE 55,8
@3.4,nCo4 MSGET nVlIPI    VALID nVlIPI  >=0 PICTURE PICT15_2    SIZE 55,8

nLinha:=4.4
IF lMV_PIS_EIC
   @nLinha,nCo4 MSGET nBASPIS VALID nBASPIS >=0 PICTURE PICT15_2 SIZE 55,8
   nLinha+=1

   @nLinha,nCo4 MSGET nVLRPIS VALID nVLRPIS >=0 PICTURE PICT15_2 SIZE 55,8
   nLinha+=1

   @nLinha,nCo4 MSGET nBASCOF VALID nBASCOF >=0 PICTURE PICT15_2 SIZE 55,8
   nLinha+=1

   @nLinha,nCo4 MSGET nVLRCOF VALID nVLRCOF >=0 PICTURE PICT15_2 SIZE 55,8
   nLinha+=1
ENDIF

@nLinha,nCo4 MSGET nBasICMS  VALID nBasICMS>=0 PICTURE PICT15_2    SIZE 55,8
nLinha+=1
@nLinha,nCo4 MSGET nVlICMS   VALID nVlICMS >=0 PICTURE PICT15_2    SIZE 55,8
nLinha+=1
@nLinha,nCo4 MSGET n_DespBICMS VALID n_DespBICMS >=0 PICTURE PICT15_2    SIZE 55,8

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'TELA_ITEM_ALTERA'),)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,;
         {||If(EVAL(bValid),(nOpcA:=1,oDlg:End()),)},;
         {||nOpcA:=0, oDlg:End()}) CENTERED

If nOpca = 0
   Return .F.
Endif

Work2->(DBSETORDER(1))
Work1->(DBGOTO(nRecno))
Work2->(DBSEEK(EVAL(bSeekWk2)))//Work1->WKFORN+Work1->WK_CFO+Work1->WK_OPERACA+Work1->WKTEC+Work1->WKEX_NCM+Work1->WKEX_NBM+Work1->WKINCOTER))

//ISS - 10/11/10 - Tratamento para a localização da adição correta caso a adição tenha sido criada manualmente.
If Work2->(EOF())
   Work2->(DBGOTOP())
   Work2->(DBSETORDER(2))
   Work2->(DBSEEK(Work1->WKADICAO))
EndIf   

nCif   :=nVLCIF
nSeg   :=nSeguro

Work1->WK_NFE    := cNumNFE
Work1->WK_SE_NFE := cSerieNFE
Work1->WK_DT_NFE := dDtNFE
Work1->WKCIF     := nCif
Work1->WKFOB_R   := nFOBRS
Work1->WKFRETE   := nFrete
Work1->WKVALMERC := nVLMERC
Work1->WKSEGURO  := nSeg
Work1->WKIIVAL   := nVlII

//** AAF - 28/09/07
Work1->WKVLDEVII := nVlII
Work1->WKVLDEIPI := nVlIPI
//**

Work1->WKIPIBASE := nBaseIPI
Work1->WKIPIVAL  := nVlIPI  
Work1->WKBASEICMS:= nBasICMS
Work1->WKVL_ICM  := nVlICMS 
Work1->WKDESPICM := n_DespBICMS// SVG - 06/09/2011 - 
Work1->WKBASPIS  := nBASPIS
Work1->WKVLRPIS  := nVLRPIS
Work1->WKBASCOF  := nBASCOF
Work1->WKVLRCOF  := nVLRCOF
Work1->WKPRUNI   := nPrecoUnit

//IF nTipoNF == NFE_COMPLEMEN
IF lDespNProc    // Bete 24/11 - Trevo
   Work1->WKOUT_DESP:= nVLMERC
ENDIF

Work1->(DBGOTO(nRecno))
Work3->(DBSEEK(Work1->(RECNO())))

WHILE !Work3->(EOF()) .AND. Work1->(RECNO()) == Work3->WKRECNO
   Work3->WK_NF_COMP:=cNumNFE
   Work3->WK_SE_NFC :=cSerieNFE
   Work3->WK_DT_NFC :=dDtNFE
   Work3->(DBSKIP())
ENDDO
// Subtrai os valores anteriores da tela principal
n_CIF    := DITRANS((n_CIF    - nCVLCIF),2)
nFOB_R   := DITRANS((nFOB_R   - nCFOBRS),2)
n_FRETE  := DITRANS((n_FRETE  - nCFrete),2)
n_II     := DITRANS((n_II     - nCVlII),2)
n_SEGURO := DITRANS((n_SEGURO - nCSeguro ),2)
n_IPI    := DITRANS((n_IPI    - nCVlIPI),2)
n_ICMS   := DITRANS((n_ICMS   - nCVlICMS),2)
n_Pis    := DITRANS((n_Pis    - nCVLRPIS),2)
n_Cofins := DITRANS((n_Cofins - nCVLRCOF),2)

// Soma os novos valores na tela principal
n_CIF    := DITRANS((n_CIF    + nCif),2)
nFOB_R   := DITRANS((nFOB_R   + nFOBRS),2)
n_FRETE  := DITRANS((n_FRETE  + nFrete),2)
n_Vl_Fre := DITRANS((n_FRETE  / IF(EMPTY(n_Tx_Fre),1,n_Tx_Fre)),2)
n_II     := DITRANS((n_II     + nVlII),2)
n_SEGURO := DITRANS((n_SEGURO + nSeg),2)
//n_Vl_USS := DITRANS((n_SEGURO / IF(EMPTY(SW6->W6_TX_SEG),1,SW6->W6_TX_SEG)),2)
n_Vl_USS := DITRANS((n_SEGURO / IF(EMPTY(n_Tx_Seg),1,n_Tx_Seg)),2)   // Bete 26/11 - Trevo
n_IPI    := DITRANS((n_IPI    + nVlIPI),2)
n_ICMS   := DITRANS((n_ICMS   + nVlICMS),2)

n_Pis    := DITRANS((n_Pis    + nVLRPIS),2)
n_Cofins := DITRANS((n_Cofins + nVLRCOF),2)

n_ValM   := DITRANS(n_CIF,2)  + DITRANS(n_II,2)
n_TotNFE := DITRANS(n_ValM,2) + DITRANS(n_IPI,2)
n_VlTota := DITRANS((n_TotNFE + n_ICMS+nNBM_PIS+nNBM_COF+MDI_OUTR+MDI_OUTRP),2)
IF lImpostos // By JPP - 05/11/2007 - 10:30 - Neste trecho faltou acrescentar os valores dos impostos no valor total da nota.
   n_VlTota += DITRANS(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc,2)
ENDIF                                                                                

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'DEPOIS_ITEM_ALTERA'),)

//** AAF 28/09/07 - Acerta a Work2
Work2->WKCIF     += nCif - nCVLCIF
Work2->WKFOB_R   += nFOBRS - nCFOBRS
Work2->WKFRETE   += nFrete - nCFrete
Work2->WKSEGURO  += nSeg - nCSeguro
Work2->WKII      += nVlII - nCVlII 
Work2->WKIPI     += nVlIPI - nCVlIPI
Work2->WKICMS    += nVlICMS - nCVlICMS
Work2->WKBASPIS  += nBASPIS - nCBASPIS
Work2->WKVLRPIS  += nVLRPIS - nCVLRPIS
Work2->WKBASCOF  += nBASCOF - nCBASCOF
Work2->WKVLRCOF  += nVLRCOF - nCVLRCOF

//ISS - Inclusão dos campos Base do ICMS e do IPI
Work2->WKBASEIPI += nBaseIPI - nCBaseIPI
Work2->WKBASEICMS+= nBasICMS - nCBasICMS
//**

RETURN .T.

*----------------------------------------------*
Function DI154GrWorks(bDDIFor,bDDIWhi)
*----------------------------------------------*
LOCAL nCont:=0,nValor:=0, lSair:=.F.
Local cFilSA2:=xFilial("SA2")
LOCAL cFilSB1:=xFILIAL("SB1")
LOCAL cFilSW2:=xFILIAL("SW2")
LOCAL cFilSW7:=xFILIAL("SW7")
LOCAL cFilSW8:=xFILIAL("SW8")
LOCAL cFilSW9:=xFILIAL("SW9")
LOCAL cFilSWZ:=xFILIAL("SWZ")
LOCAL cFilSYD:=xFILIAL("SYD")
LOCAL cFilSWN:=xFILIAL("SWN")
LOCAL cFilSF1:=xFILIAL("SF1")
aDespesa:= {};nFob:=nFobTot:=nPesoL:=nContProc:=nSomaNoCIF:=nSomaBaseICMS:= nPSemCusto := nSemCusto := 0
nPSomaNoCIF:= nPSomaBaseICMS:=0//AWR
nTxSisc := 0

SD1->(DBSETORDER(8))//9
SYB->(DBSETORDER(1))
SW7->(DBSEEK(cFilSW7+SW6->W6_HAWB))
SA2->(DBSEEK(cFilSA2+SW7->W7_FORN+EICRetLoja("SW7", "W7_FORLOJ")))//CR

ProcRegua(50)

DI154IncProc(STR0132) //"Verificando Processo, Aguarde..."

SW9->(DBSETORDER(3))
SW9->(DbSeek(cFilSW9+SW6->W6_HAWB))
DO WHILE ! SW9->(EOF()) .AND. SW9->W9_FILIAL == cFilSW9 .AND.;
                              SW9->W9_HAWB == SW6->W6_HAWB

   MDespesas+= DITrans(DI500RetVal("TOT_INV,SEM_FOB", "TAB", .T.,, .T. )*DI154TaxaFOB(),2)  // EOB - 14/07/08 - chamada da função DI500RetVal
  
   SW9->(DBSKIP())
ENDDO

IF lExiste_Midia
   SW9->(DBSETORDER(1))
   SW8->(DBSETORDER(1))
   SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
   DO WHILE !SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB
      SW2->(DbSeek(cFilSW2+SW8->W8_PO_NUM))
      SB1->(DbSeek(cFilSB1+SW8->W8_COD_I))
      //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
      SW9->(DbSeek(cFilSW9+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+SW8->W8_HAWB))

      nRatIPD := DI500RetVal("ITEM_INV,SEM_FOB", "TAB", .T.,, .T.) // EOB - 14/07/08 - chamada da função DI500RetVal

      IF SB1->B1_MIDIA $ cSim
         lHaUmaMidia  :=.T.
         nFbMid_MRS   := DITrans(SB1->B1_QTMIDIA * SW8->W8_QTDE * SW2->W2_VLMIDIA * DI154TaxaFOB(),2)
         nFobItemMidia+= SW8->W8_PRECO_R+DITRANS(nRatIPD*DI154TaxaFOB(),2)
         M_FOB_MID    += nFbMid_MRS
      ENDIF

      SW8->(DBSKIP())
   ENDDO
ENDIF

DI154GrvDespesa()

DI154IncProc(STR0132) //"Verificando Processo, Aguarde..."
nFOB_R :=0
nSEGURO:=0

lSair:=.F.


IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ITEM_NF"),)
//AvStAction("206",.F.)//AWR 25/03/2009 - Para versão M11 utilizar o ponto de entrada acima para customizar o Conta e Ordem.
IF GETMV("MV_EIC_PCO",,.F.)
   IF lSoGravaNF// AWR - 02/02/09 - So Grava a NF
      IF EICGrvWork1()//Essa funcao esta no programa EICIMPPCO_RDM.PRW do PCO
         lSair:=.T.
      ENDIF
   ENDIF
ENDIF

IF lSair
   RETURN .T.
ENDIF

IF nTipoNF # CUSTO_REAL

   SF1->(DBSETORDER(5))
   SWN->(DBSETORDER(2))
   ProcRegua(50)

   SF1->(DBSEEK(cFilSF1+SW6->W6_HAWB+STR(nTipoNF,1,0)))

   DO WHILE SF1->(!EOF())                 .AND.;
         SF1->F1_FILIAL  == cFilSF1       .AND.;
         SF1->F1_HAWB    == SW6->W6_HAWB  .AND.;
         SF1->F1_TIPO_NF == STR(nTipoNF,1,0)

      DI154IncProc(STR0133) //"Lendo Nota Fiscal, Aguarde..."

      IF !EMPTY(cNota) .AND. cNota # SF1->F1_CTR_NFC // Nota + Serie
         SF1->(DBSKIP())
         LOOP
      ENDIF

      SWN->(DBSEEK(cFilSWN+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA))

      SA2->(DBSEEK(cFilSA2+SF1->F1_FORNECE))  //TRP-26/10/07
      DO WHILE SWN->(!EOF())                 .AND.;
            SWN->WN_FILIAL == cFilSWN        .AND.;
            SWN->WN_DOC    == SF1->F1_DOC    .AND.;
            SWN->WN_SERIE  == SF1->F1_SERIE  .AND.;
            SWN->WN_FORNECE== SF1->F1_FORNECE.AND.;
            SWN->WN_LOJA   == SF1->F1_LOJA

         IF SWN->WN_TIPO_NF # STR(nTipoNF,1,0).OR.;
            SWN->WN_HAWB    # SW6->W6_HAWB
            SWN->(DBSKIP())
            LOOP
         ENDIF
         
         DI154IncProc(STR0133) //"Lendo Nota Fiscal, Aguarde..."

         Work1->(DBAPPEND())
         Work1->WKSTATUS   := SF1->F1_STATUS 
         Work1->WK_NFE     := SWN->WN_DOC
         Work1->WK_NOTA    := SWN->WN_DOC
         Work1->WK_SE_NFE  := SWN->WN_SERIE
         Work1->WKTEC      := SWN->WN_TEC
         Work1->WKEX_NCM   := SWN->WN_EX_NCM
         Work1->WKEX_NBM   := SWN->WN_EX_NBM
         Work1->WKQTDE     := SWN->WN_QUANT   
         Work1->WKPRECO    := SWN->WN_PRECO   
         Work1->WKPO_NUM   := SWN->WN_PO_EIC
         Work1->TRB_ALI_WT := "SWN"
         Work1->TRB_REC_WT := SWN->(Recno())
         //AWR 14/04/2000
         IF !EMPTY(SWN->WN_QTSEGUM) .AND.;
            GetMV("MV_UNIDCOM",,2) == 2 .AND. lMV_EASYSIM
            Work1->WKQTDE := SWN->WN_QTSEGUM
         ENDIF
         Work1->WKCOD_I    := SWN->WN_PRODUTO
         Work1->WKVALMERC  := SWN->WN_VALOR
         Work1->WK_CFO     := SWN->WN_CFO
         Work1->WK_OPERACA := SWN->WN_OPERACA
         Work1->WKICMS_A   := SWN->WN_ICMS_A
         Work1->WKDESCR    := SWN->WN_DESCR
         Work1->WKUNI      := SWN->WN_UNI
         Work1->WKIPITX    := SWN->WN_IPITX
         Work1->WKIPIVAL   := SWN->WN_IPIVAL
         Work1->WKVLDEVII  := SWN->WN_VLDEVII
         Work1->WKVLDEIPI  := SWN->WN_VLDEIPI
         Work1->WKIITX     := SWN->WN_IITX
         Work1->WKIIVAL    := SWN->WN_IIVAL
         Work1->WKPRUNI    := SWN->WN_PRUNI
         Work1->WKVL_ICM   := SWN->WN_VL_ICM
         Work1->WKBASEICMS := SWN->WN_BASEICM
         If lICMS_Dif  // PLB 14/05/07 - Tratamento Diferimento de ICMS
            DI154Diferido(.T.)
         EndIf
         Work1->WKPESOL    := SWN->WN_PESOL
         
         //FSM - 02/09/2011 - Peso Bruto Unitario
         SW8->(DBSETORDER(1))
         If lPesoBruto .And. SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
            Work1->WKPESOBR := SW8->W8_PESO_BR
         EndIf
         
         Work1->WKSEGURO   := SWN->WN_SEGURO
         Work1->WKCIF      := SWN->WN_CIF
         Work1->WKOUT_DESP := SWN->WN_DESPESA 
         Work1->WKFRETE    := SWN->WN_FRETE
         Work1->WKOUT_D_US := SWN->WN_OUTR_US
         Work1->WKIPIBASE  := SWN->WN_IPIBASE
         Work1->WKFOB_R    := SWN->WN_FOB_R
         Work1->WK_CC      := SWN->WN_CC 
         Work1->WKSI_NUM   := SWN->WN_SI_NUM
         Work1->WKFORN     := SWN->WN_FORNECE
         Work1->WKNOME     := SA2->A2_NOME  //TRP-26/10/07
         Work1->WKLOJA     := SWN->WN_LOJA
         Work1->WKPOSICAO  := SWN->WN_ITEM    
         Work1->WKADICAO   := SWN->WN_ADICAO
         Work1->WKPGI_NUM  := SWN->WN_PGI_NUM
         Work1->WKRATEIO   := SWN->WN_RATEIO
         Work1->WKINVOICE  := SWN->WN_INVOICE
         Work1->WKOUTDESP  := SWN->WN_OUT_DES
         Work1->WKINLAND   := SWN->WN_INLAND
         Work1->WKPACKING  := SWN->WN_PACKING
         Work1->WKDESCONT  := SWN->WN_DESCONT

         // quando vem da integração com o despachante o rateio vem zerado, é preciso apurar de novo.
         // by RS 15/09/05
                  
         IF Work1->WKRATEIO == 0     
            nValor_R:=DITRANS((SW6->W6_FOB_TOT+MDespesas),2)           
            Work1->WKRATEIO  := Work1->WKFOB_R/nValor_R
         ENDIF        

         IF lAcresDeduc  // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
            Work1->WKVLACRES := SWN->WN_VLACRES
            Work1->WKVLDEDUC := SWN->WN_VLDEDUC
         ENDIF
         Work1->WKDESPCIF  := Work1->WKCIF-Work1->WKFOB_R-Work1->WKFRETE-Work1->WKSEGURO-Work1->WKVLACRES+Work1->WKVLDEDUC // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
         IF SWN->(FIELDPOS("WN_DESPICM")) # 0
         
            Work1->WKDESPICM  := SWN->WN_DESPICM
             IF lLerNota                                                               // rs 03/02/06 - Inclusao da despesas base de icms no custo realizado apos a geracao da primeira NFE
                 nSomaBaseICMS+=SWN->WN_DESPICM
             ENDIF            

         ENDIF
         IF lMV_PIS_EIC .AND. nTipoNF # 2
            Work1->WKVLUPIS  := SWN->WN_VLUPIS
            Work1->WKBASPIS  := SWN->WN_BASPIS
            Work1->WKPERPIS  := SWN->WN_PERPIS
            Work1->WKVLRPIS  := SWN->WN_VLRPIS
            Work1->WKVLUCOF  := SWN->WN_VLUCOF
            Work1->WKBASCOF  := SWN->WN_BASCOF
            Work1->WKPERCOF  := SWN->WN_PERCOF
            Work1->WKVLRCOF  := SWN->WN_VLRCOF

            If lCposCofMj                                                            //NCF - 20/07/2012 - Majoração COFINS
               Work1->WKALCOFM  := SWN->WN_ALCOFM
               Work1->WKVLCOFM  := SWN->WN_VLCOFM
            EndIf                         
            If lCposPisMj                                                            //GFP - 11/06/2013 - Majoração PIS
               Work1->WKALPISM  := SWN->WN_ALPISM
               Work1->WKVLPISM  := SWN->WN_VLPISM
            EndIf 
         ENDIF
         SA2->(DBSEEK(xFilial("SA2")+Work1->WKFORN+Work1->WKLOJA))
         IF(ASCAN(aLista,{|F|F=Work1->WKFORN})=0,AADD(aLista,Work1->WKFORN+"-"+SA2->A2_NREDUZ),)

         IF lLote
            Work1->WK_LOTE  := SWN->WN_LOTECTL
            Work1->WKDTVALID:= SWN->WN_DTVALID
         ENDIF
         IF lExisteSEQ_ADI// AWR - 18/09/08 - NFE
            Work1->WKSEQ_ADI := SWN->WN_SEQ_ADI
         ENDIF
         IF lMV_GRCPNFE//Campos novos NFE - AWR 06/11/2008
            Work1->WKPREDICM := SWN->WN_PREDICM
            Work1->WKDESCONI := SWN->WN_DESCONI
            Work1->WKVLRIOF  := SWN->WN_VLRIOF
            Work1->WKDESPADU := SWN->WN_DESPADU
            Work1->WKALUIPI  := SWN->WN_ALUIPI
            Work1->WKQTUIPI  := SWN->WN_QTUIPI
            Work1->WKQTUPIS  := SWN->WN_QTUPIS
            Work1->WKQTUCOF  := SWN->WN_QTUCOF
         ENDIF
         //** PLB 20/12/06
         If lIntDraw
            SW8->( DBSetOrder(6) )
            If SW8->( DBSeek(xFilial("SW8")+SWN->WN_HAWB+SWN->WN_INVOICE+SWN->WN_PO_EIC+SWN->WN_ITEM+SWN->WN_PGI_NUM)  .And.  !Empty(SW8->W8_AC) )
               ED4->( DBSetOrder(2) )
               If ED4->( DBSeek(xFilial()+SW8->W8_AC+SW8->W8_SEQSIS))
                  ED0->( DBSetOrder(1) )
                  If ED0->( DBSeek(xFilial()+ED4->ED4_PD))
                     If cQbrACModal = "1"
                        Work1->WKACMODAL := SW8->W8_AC
                     ElseIf cQbrACModal = "2"
                        Work1->WKACMODAL := ED0->ED0_MODAL
                     EndIf
                  EndIf
               EndIf
            EndIf
         EndIf
         //**
         nFOB_R   +=Work1->WKFOB_R
         nFreteNew+=Work1->WKFRETE
         nSEGURO  +=Work1->WKSEGURO
         nCIFNew  +=Work1->WKCIF
         MDI_OUTR +=Work1->WKOUT_DESP
         nNBM_II  +=Work1->WKIIVAL
         nNBM_IPI +=Work1->WKIPIVAL
         nNBM_ICMS+=Work1->WKVL_ICM
         nNBM_PIS +=Work1->WKVLRPIS
         nNBM_COF +=Work1->WKVLRCOF 
         
         IF SWN->(FIELDPOS("WN_DESPICM")) # 0          //NCF - 17/08/2011
            MDI_DespICM += Work1->WKDESPICM
         ENDIF
          
         IF (ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'LER_SF1_SWN'),)
         IF (ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'LER_SF1_SWN'),)

         SWN->(DBSKIP())

      ENDDO

      SF1->(DBSKIP())

   ENDDO
   
   IF lAcresDeduc                                    
      nNBM_Acres:=nNBM_Deduc:=0
      EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0))) 
      DO WHILE !EIU->(eof()) .AND. EIU->EIU_HAWB == SW6->W6_HAWB .AND. EIU->EIU_TIPONF == STR(nTipoNF,1,0) 
         Work_EIU->(DBAPPEND())
         AVREPLACE("EIU","Work_EIU")
         IF EIU->EIU_TIPO == "A"
            SJN->(DBSEEK(xFilial()+EIU->EIU_CODIGO))
            Work_EIU->EIU_DESC:=SJN->JN_DESC 
            nNBM_Acres+=EIU->EIU_VALOR
         ELSE
            SJO->(DBSEEK(xFilial()+EIU->EIU_CODIGO))
            Work_EIU->EIU_DESC:=SJO->JO_DESC
            nNBM_Deduc+=EIU->EIU_VALOR
         ENDIF            
         EIU->(dbSkip())
      ENDDO
   ENDIF

ELSE

   EI2->(DBSETORDER(1))

   ProcRegua(50)

   EI2->(DBSEEK(xFilial()+SW6->W6_HAWB))

   SA2->(DBSEEK(cFilSA2+EI2->EI2_FORNEC+If(EICLoja(), EI2->EI2_LOJA, "")))  //TRP-26/10/07
   DO WHILE ! EI2->(EOF())                     .AND.;
              EI2->EI2_FILIAL == xFilial("EI2").AND.;
              EI2->EI2_HAWB   == SW6->W6_HAWB

      DI154IncProc(STR0134) //"Lendo Custo, Aguarde..."

      IF EI2->EI2_TIPO_NF # STR( nTipoNF,1, 0 )
         EI2->(DBSKIP())
         LOOP
      ENDIF

      Work1->(DBAPPEND())
      Work1->WK_NFE    := EI2->EI2_DOC
      Work1->WK_SE_NFE := EI2->EI2_SERIE
      Work1->WKTEC     := EI2->EI2_TEC
      Work1->WKEX_NCM  := EI2->EI2_EX_NCM
      Work1->WKEX_NBM  := EI2->EI2_EX_NBM
      Work1->WKPO_NUM  := EI2->EI2_PO_NUM
      Work1->WKQTDE    := EI2->EI2_QUANT
      Work1->WKCOD_I   := EI2->EI2_PRODUTO
      Work1->WKVALMERC := EI2->EI2_VALOR
      Work1->WKVL_ICM  := EI2->EI2_VALICM
      Work1->WK_CFO    := EI2->EI2_CFO
      Work1->WK_OPERACA:= EI2->EI2_OPERACA
      Work1->WKICMS_A  := EI2->EI2_ICMS_A                                        
      Work1->WKPRECO   := EI2->EI2_PRECO
      Work1->WKDESCR   := EI2->EI2_DESCR
      Work1->WKUNI     := EI2->EI2_UNI
      Work1->WKIPITX   := EI2->EI2_IPITX
      Work1->WKVLDEVII := EI2->EI2_VLDEII
      Work1->WKVLDEIPI := EI2->EI2_VLDIPI
      Work1->WKIPIVAL  := EI2->EI2_IPIVAL
      Work1->WKIITX    := EI2->EI2_IITX
      Work1->WKIIVAL   := EI2->EI2_IIVAL
      Work1->WKPRUNI   := EI2->EI2_PRUNI
      Work1->WKVL_ICM  := EI2->EI2_VL_ICM
      Work1->WKPESOL   := EI2->EI2_PESOL
      
      //FSM - 02/09/2011 - Peso Bruto Unitario
      SW8->(DBSETORDER(1))
      If lPesoBruto .And. SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
         Work1->WKPESOBR := SW8->W8_PESO_BR
      EndIf
      
      Work1->WKSEGURO  := EI2->EI2_SEGURO
      Work1->WKCIF     := EI2->EI2_CIF
      Work1->WKOUT_DESP:= EI2->EI2_DESPES
      Work1->WKFRETE   := EI2->EI2_FRETE
      Work1->WKOUT_D_US:= EI2->EI2_OUTR_U
      Work1->WKIPIBASE := EI2->EI2_IPIBAS
      Work1->WKFORN    := EI2->EI2_FORNEC
      If EICLoja()
         Work1->WKLOJA := EI2->EI2_LOJA
      EndIf
      Work1->WKNOME    := SA2->A2_NOME  //TRP-26/10/07
      Work1->WKRATEIO  := EI2->EI2_RATEIO
      Work1->WKPGI_NUM := EI2->EI2_PGI_NU
      Work1->WKINVOICE := EI2->EI2_INVOIC
      Work1->WKOUTDESP := EI2->EI2_OUT_DE
      Work1->WKINLAND  := EI2->EI2_INLAND
      Work1->WKPACKING := EI2->EI2_PACKIN
      Work1->WKDESCONT := EI2->EI2_DESCON
      Work1->WKFOB_R   := EI2->EI2_FOB_R 
      Work1->TRB_ALI_WT := "EI2"
      Work1->TRB_REC_WT := EI2->(Recno())
     
      IF lAcresDeduc  // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
         Work1->WKVLACRES := EI2->EI2_VACRES
         Work1->WKVLDEDUC := EI2->EI2_VDEDUC
      ENDIF
      Work1->WKDESPCIF  := Work1->WKCIF-Work1->WKFOB_R-Work1->WKFRETE-Work1->WKSEGURO-Work1->WKVLACRES+Work1->WKVLDEDUC // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
      IF lMV_PIS_EIC
         Work1->WKVLUPIS  := EI2->EI2_VLUPIS
         Work1->WKBASPIS  := EI2->EI2_BASPIS
         Work1->WKPERPIS  := EI2->EI2_PERPIS
         Work1->WKVLRPIS  := EI2->EI2_VLRPIS
         Work1->WKVLUCOF  := EI2->EI2_VLUCOF
         Work1->WKBASCOF  := EI2->EI2_BASCOF
         Work1->WKPERCOF  := EI2->EI2_PERCOF
         Work1->WKVLRCOF  := EI2->EI2_VLRCOF
         
         If lCposCofMj                                                            //NCF - 20/07/2012 - Majoração COFINS 
            Work1->WKVLCOFM  := EI2->EI2_VLCOFM 
         EndIf         
         If lCposPisMj                                                            //GFP - 11/06/2013 - Majoração PIS
            Work1->WKVLPISM  := EI2->EI2_VLPISM 
         EndIf
      ENDIF
      IF lLote
         Work1->WK_LOTE  :=EI2->EI2_LOTECT
         Work1->WKDTVALID:=EI2->EI2_DTVALI
      ENDIF

      nFOB_R   +=Work1->WKFOB_R
      nFreteNew+=Work1->WKFRETE
      nSEGURO  +=Work1->WKSEGURO
      nCIFNew  +=Work1->WKCIF
      MDI_OUTR +=Work1->WKOUT_DESP
      nNBM_II  +=Work1->WKIIVAL
      nNBM_IPI +=Work1->WKIPIVAL
      nNBM_ICMS+=Work1->WKVL_ICM
      nNBM_PIS +=Work1->WKVLRPIS
      nNBM_COF +=Work1->WKVLRCOF 
      
      IF SWN->(FIELDPOS("WN_DESPICM")) # 0          //NCF - 17/08/2011
         MDI_DespICM += Work1->WKDESPICM
      ENDIF

      IF (ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'LEREI2'),)
      IF (ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'LEREI2'),)

      EI2->(DbSkip())

   ENDDO
   
   IF lAcresDeduc                                    
      nNBM_Acres:=nNBM_Deduc:=0
      EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0))) 
      DO WHILE !EIU->(eof()) .AND. EIU->EIU_HAWB == SW6->W6_HAWB .AND. EIU->EIU_TIPONF == STR(nTipoNF,1,0) 
         Work_EIU->(DBAPPEND())
         AVREPLACE("EIU","Work_EIU")
         IF EIU->EIU_TIPO == "A"
            SJN->(DBSEEK(xFilial()+EIU->EIU_CODIGO))
            Work_EIU->EIU_DESC:=SJN->JN_DESC 
            nNBM_Acres+=EIU->EIU_VALOR
         ELSE
            SJO->(DBSEEK(xFilial()+EIU->EIU_CODIGO))
            Work_EIU->EIU_DESC:=SJO->JO_DESC
            nNBM_Deduc+=EIU->EIU_VALOR
         ENDIF            
         EIU->(dbSkip())
      ENDDO
   ENDIF

ENDIF                
     
//IF nTipoNF # NFE_COMPLEMEN .OR. lComIcms .OR. lRateioCIF
IF lApuraCIF .OR. lComIcms .OR. lRateioCIF   // Bete 24/11 - Trevo
   MDI_FOB_R  := nFOB_R
   MDI_FRETE  := nFreteNew
   MDI_SEGURO := nSEGURO
   MDI_CIF    := nCIFNew
   MDI_CIFPURO:= nFOB_R+nFreteNew+nSEGURO
/*   IF lCurrier
      MDI_FRETE := MDI_SEGURO := 0 
   ENDIF
*/   
ENDIF

DI154IncProc() // 100%

DBSELECTAREA("Work1")

Work1->(DBGOTOP())

RETURN .T.
*---------------------------------------*
Function DI154ForDesp()
*---------------------------------------*
LOCAL nTaxa
PRIVATE cBaseICMS:=SPACE(1)                  

SYB->(DbSeek(xFilial("SYB")+SWD->WD_DESPESA))

IF (ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'DI154FORDESP'),)

IF !SYB->(EOF()) .AND. !(SYB->YB_BASECUS $ cNao)

/* EOS - 13/05 - permitir gravar no SWW as despesas que sao base de impostos e icms
   IF SYB->YB_BASEIMP $ cSim .OR. (SYB->YB_BASEICM $ cSim .AND. nTipoNF # 4) // rhp
      RETURN .F.
   ENDIF
*/

   IF SWD->WD_DESPESA $ "701/702/703"    // RRV - 07/03/2013
      If lDifCamb //RRV - 25/02/2013
         nDifCamb+=DI154_SWDVal()
         Di154TabDes(aDespesa)
      Endif
      RETURN .T.
   ENDIF

// EOS - 13/05 - permitir gravar no SWW na primeira nota, as despesas que sao base de impostos e icms
// AWR - OBS: nTipoNF # 2 por que pode ocorrer de entrar uma despesa base despois de gerado a primeira ou unica
   lBaseICMS:=SYB->YB_BASEICM
   IF SYB->YB_BASEICM $ cSim
      IF lTemYB_ICM_UF                 
         lBaseICMS:= SYB->(FIELDGET(FIELDPOS(cCpoBasICMS)))
      ENDIF
   ENDIF

   IF SYB->YB_BASEIMP $ cSim .OR. lBaseICMS $ cSim
      IF nTipoNF # 2  // Bete - p/ gravar no SWW as despesas base qdo nota diferente de complementar 
         //NCF - 12/07/2011 - Não considerar Adiantamento de Taxa Siscomex no custo (DI Eletronica gera a despesa automaticamente)
         //IF !(GetMv("MV_CODTXSI",,"") $ SWD->WD_DESPESA .And. SWD->WD_BASEADI $ cSim)
            DI154TabDes(aDespesa)// Grava o SWW
         //ENDIF
         RETURN .F.
      ELSEIF !lICMS_NFC  // Bete - se nota complementar, verifica se calcula ICMS, se não, ignora as despesas base 
         RETURN .F.
	  ENDIF
   ENDIF

// AWR - 18/05 - ignora as despesas que nao sao base de imposto e ICMS na primeira nota quando nao é Ler Nota (Custo)
   IF lSoDespBase //.AND. !lLernota - AWR - OBS: Agora o Ler Nota (Custo) é sempre nTipoNF = 4
      RETURN .F.
   ENDIF

   nTaxa:=BuscaTaxa(cMoeDolar,SWD->WD_DES_ADI,.T.,.F.,.T.)
   IF SYB->YB_RATPESO $ cSim      //AWR
      MDI_OUTRP += DI154_SWDVal()
      MDI_OU_USP+= DITRANS(DI154_SWDVal()/ IF(nTaxa#0,nTaxa,1),2)
   ELSE  
      MDI_OUTR  += DI154_SWDVal()
      MDI_OU_US += DITRANS(DI154_SWDVal() / IF(nTaxa#0,nTaxa,1),2)
   ENDIF
   Di154TabDes(aDespesa)

ELSE   
   RETURN .F.
ENDIF

RETURN .T.
*---------------------------------------*
Function DI154Grava(bDDIFor,bDDIWhi)
*---------------------------------------*
LOCAL bDespDiFor:={||AT(LEFT(SWD->WD_DESPESA,1),"129") = 0}
LOCAL bDespDiWhi:={||cFilSWD==SWD->WD_FILIAL .AND. SWD->WD_HAWB==SW6->W6_HAWB}
LOCAL nNBM_FOB:=0
LOCAL  nFbMid_M:=0, cFilSWD:=xFILIAL("SWD")
LOCAL nCifMaior := 0, nRecno:=1,cTam:=AVSX3("B1_VM_P",3)
LOCAL nDespCIF_NCM, nDespICMS_NCM  // Jonato em 23/03/2003 para corrigir diferença de centavos no valor base CIF e valor base despesa ICMS
//** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
Local nQtdRecWK2 := 0
Local nQtdAdicao := 0
Local nTotTxSisc := 0
Local nTotTxComp := 0   //TLM 26/10/07 - Acerto do rateio da taxa Siscomex sem DI
Local cMsgInfo   := ""

Local nItensAdi:=GetMv("MV_NR_ISUF",,78)  // Bete - controle de adições
//TRP-01/04/09
Local lFaltaAdic := .F. 
Local aItemInv := {}  
Local cMensagem := ""
Local i
Local nTotSoft:= 0  //TRP - 02/06/09 - Variável para Novo Tratamento de Mídia e Software
Local nFobIt := 0 //BHF-15/06/09
Local lSeekWk2 := .F.// SVG - 07/07/09 -
Local nRecMae := 0 //DFS - 14/08/11 - Declaração da variavel para evitar error.log na geração da nota filha 
IF nItensAdi = 0
   nItensAdi := 78
ENDIF
Private nValTxComp := 0   //TLM 26/10/07 - Acerto do rateio da taxa Siscomex sem DI
Private lMidia:=.f.
lTxSiscOK := .T.
//**
Private aContrAdicao := {}  // Bete - controle de adições
PRIVATE lTemAdicao := .F.
PRIVATE cFilSA2:=xFILIAL("SA2")
PRIVATE cFilSA5:=xFILIAL("SA5")
PRIVATE cFilSB1:=xFILIAL("SB1")
PRIVATE cFilSW2:=xFILIAL("SW2")
PRIVATE cFilSW7:=xFILIAL("SW7")
PRIVATE cFilSW8:=xFILIAL("SW8")
PRIVATE cFilSW9:=xFILIAL("SW9")
PRIVATE cFilSWZ:=xFILIAL("SWZ")
PRIVATE cFilSWX:=xFILIAL("SWX")
PRIVATE cFilSYD:=xFILIAL("SYD")
PRIVATE cFilSWP:=xFILIAL("SWP")
PRIVATE bDDIAcu   :={|| DI154ForDesp()}
PRIVATE lPesoNew := 0 // PARA RDMAKE DE PESO NO W5 - RHP
Private lSegInc  := SW9->(FIELDPOS("W9_SEGINC")) # 0 .AND. SW9->(FIELDPOS("W9_SEGURO")) # 0 .AND. ;
                   SW8->(FIELDPOS("W8_SEGURO")) # 0 .AND. SW6->(FIELDPOS("W6_SEGINV")) # 0
                   //EOB - 14/07/08 - tratamento para os incoterms que contenham seguro (CIF,CIP,DAF,DES,DEQ,DDU e DDP)

nContProc:=M_FOB_MID:= nFobItemMidia:= nDifCamb:= nSomaNoCIF:= nSomaBaseICMS:=nRatIPD:=nFbMid_MRS:= nPSemCusto := nSemCusto := 0
nPSomaNoCIF:=nPSomaBaseICMS:=0     // EOS
nTxSisc := 0
nFob_Tot_Inv := 0   // Bete 27/11 - Trevo
aDespesa := {}; nFobMoeda:=nFobTot:=nPesoL:=0;lHaUmaMidia:=.F.
aDesAcerto:={}
DI154IncProc()

SWZ->(DBSETORDER(2) )
SWX->(DBSETORDER(1) )
SYB->(DBSETORDER(1) )
SW7->(DBSETORDER(4) )

SW7->(DbSeek(xFILIAL("SW7")+SW6->W6_HAWB))
SW2->(DbSeek(xFilial()+SW7->W7_PO_NUM))
SA2->(DBSEEK(xFilial("SA2")+SW7->W7_FORN+EICRetLoja("SW7", "W7_FORLOJ")))

DI154IncProc()
nFobMoeda:= 0

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"INICIO_DI154GRAVA"),)// AWR - MIDIA - 7/5/4

lSegInv := .F.
SW8->(DBSETORDER(1))
SW9->(DBSETORDER(1))
IF lExiste_Midia
   SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
   DO WHILE !SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB
      SW2->(DbSeek(cFilSW2+SW8->W8_PO_NUM))
      SB1->(DbSeek(cFilSB1+SW8->W8_COD_I))
      //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
      SW9->(DbSeek(cFilSW9+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+SW8->W8_HAWB))
      
      // EOB - 14/07/08 - verifica se o incoterm tem seguro incluso                                 
      IF lSegInc .AND. AvRetInco(SW9->W9_INCOTER,"CONTEM_SEG").AND. /*FDR - 27/12/10*/ /*SW9->W9_INCOTER $ "CIF,CIP,DAF,DES,DEQ,DDU,DDP"*/;
         ( (!EMPTY(SW9->W9_SEGURO) .AND. !SW9->W9_SEGINC $ cSim) .OR. SW9->W9_SEGINC $ cSim )
         lSegInv := .T.
      ENDIF
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"WHILE_SW8_MIDIA"),)// AWR - MIDIA - 7/5/4

      IF SB1->B1_MIDIA $ cSim
         lHaUmaMidia  :=.T.        

         nFbMid_M  := DITrans( SB1->B1_QTMIDIA * SW8->W8_QTDE * SW2->W2_VLMIDIA, 2 )
         IF !SW9->W9_FREINC $ cSim
            nRatIPD := SW8->W8_FRETEIN
         ENDIF
         nFbMid_MRS:= DITrans( (nFbMid_M + nRatIPD) * DI154TaxaFOB(), 2 )  

         // nFobItemMidiaRS = FOB TOTAL (Vl. Software + despesas) dos itens que tem midia  // Bete - 24/02/05
         nFobItemMidiaRS+= DITrans(SW8->W8_PRECO*SW8->W8_QTDE*DI154TaxaFOB(),2)
         nFobItemMidiaRS+= DITrans(DI500RetVal("ITEM_INV,SEM_FOB", "TAB", .T.,, .T.)*DI154TaxaFOB(),2) // EOB - 14/07/08 - chamada da função DI500RetVal

         M_FOB_MID    += nFbMid_MRS
         MDI_FOB_R    += nFbMid_MRS
      ELSE
         nRatIPD := DITrans(DI500RetVal("ITEM_INV,SEM_FOB", "TAB", .T.,, .T.)*DI154TaxaFOB(),2) // EOB - 14/07/08 - chamada da função DI500RetVal
         //BHF-15/06/09                                    
         nFobIt := DITRANS(SW8->W8_PRECO*SW8->W8_QTDE,2)
         //MDI_FOB_R += DITRANS(nFobIt * DI154TaxaFOB(),2) nopado por WFS em 20/08/09
         MDI_FOB_R += nFobIt * DI154TaxaFOB()
         
         MDI_FOB_R += nRatIPD
         
         MDespesas += nRatIPD
      ENDIF
       //TRP- 01/04/09 - Caso possua os campos da nota fiscal eletrônica, verificar se algum item da Invoice não possui campo adição e/ou 
                     //sequência da adição preenchido(s).
      IF nTipoNF # CUSTO_REAL //SVG - 09/06/09 -
         If !SW6->W6_CURRIER == '1' // RRV - 04/10/2012 - se o processo for Courier, não é necessária adição. Tratado direto no Avgeral.PRW
            If lMV_GRCPNFE .AND. (Empty(SW8->W8_ADICAO) .OR. (lExisteSEQ_ADI .AND. Empty(SW8->W8_SEQ_ADI)))
               lFaltaAdic := .T.
               AADD(aItemInv, SW8->W8_COD_I) 
            Endif
         EndIf
      EndIf
      SW8->(DBSKIP())
   ENDDO
   //WFS 20/08/09
   MDI_FOB_R:= DITrans(MDI_FOB_R, 2)
   
ELSEIF lNewMidia   //TRP-01/06/09 - Novo Tratamento de Mídia e Software - Caso o item seja Software os valores do item corrente juntamente  
   SW3->(DbSetOrder(1))                                                 //com suas despesas não serão gravados na variável MDI_FOB_R
   SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
   DO WHILE !SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB
      //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
      SW9->(DbSeek(cFilSW9+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+SW8->W8_HAWB))
      
      // EOB - 14/07/08 - verifica se o incoterm tem seguro incluso                                 
      IF lSegInc .AND. AvRetInco(SW9->W9_INCOTER,"CONTEM_SEG").AND. /*FDR - 27/12/10*/ /*SW9->W9_INCOTER $ "CIF,CIP,DAF,DES,DEQ,DDU,DDP"*/;
         ( (!EMPTY(SW9->W9_SEGURO) .AND. !SW9->W9_SEGINC $ cSim) .OR. SW9->W9_SEGINC $ cSim )
         lSegInv := .T.
      ENDIF
      
      If SW3->(DbSeek(xFilial("SW3")+SW8->W8_PO_NUM+AvKey(SW8->W8_CC,"W3_CC")+SW8->W8_SI_NUM+SW8->W8_COD_I)) // TRP - 24/10/2012
         If SW3->W3_SOFTWAR == "1"
            SW8->(DbSkip())
            Loop 
         Else
            nRatIPD := DITrans(DI500RetVal("ITEM_INV,SEM_FOB", "TAB", .T.,, .T.)*DI154TaxaFOB(),2) // EOB - 14/07/08 - chamada da função DI500RetVal
            MDI_FOB_R += SW8->W8_PRECO_R+nRatIPD
            MDespesas += nRatIPD      
         Endif
      Endif
      
       //TRP- 01/04/09 - Caso possua os campos da nota fiscal eletrônica, verificar se algum item da Invoice não possui campo adição e/ou 
                     //sequência da adição preenchido(s).
      If !SW6->W6_CURRIER == '1' // RRV - 04/10/2012 - se o processo for Courier, não é necessária adição. Tratado direto no Avgeral.PRW 
         If lMV_GRCPNFE .AND. (Empty(SW8->W8_ADICAO) .OR. (lExisteSEQ_ADI .AND. Empty(SW8->W8_SEQ_ADI)))
            lFaltaAdic := .T.
            AADD(aItemInv, SW8->W8_COD_I) 
         Endif
      EndIf
      SW8->(DBSKIP())
   ENDDO
ELSE
   SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
   DO WHILE !SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB
      //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
      SW9->(DbSeek(cFilSW9+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+SW8->W8_HAWB))

      nFobItem := DITRANS(SW8->W8_PRECO*SW8->W8_QTDE,2)
      //MDI_FOB_R += DITRANS(nFobItem * DI154TaxaFOB(),2) nopado por wfs em 20/08/09
      MDI_FOB_R += nFobItem * DI154TaxaFOB()
      // SVG - 17/03/09 - 
      If !lTemAdicao .And. !Empty(SW8->W8_ADICAO)
         lTemAdicao := .T.
      EndIf
      
      //TRP- 01/04/09 - Caso possua os campos da nota fiscal eletrônica, verificar se algum item da Invoice não possui campo adição e/ou 
                     //sequência da adição preenchido(s).
      IF nTipoNF # CUSTO_REAL //SVG - 09/06/09 -
         If !SW6->W6_CURRIER == '1' // RRV - 04/10/2012 - se o processo for Courier, não é necessária adição. Tratado direto no Avgeral.PRW
            If lMV_GRCPNFE .AND. (Empty(SW8->W8_ADICAO) .OR. (lExisteSEQ_ADI .AND. Empty(SW8->W8_SEQ_ADI)))
               lFaltaAdic := .T.
               AADD(aItemInv, SW8->W8_COD_I) 
            EndIf
         Endif
      EndIf
      
      SW8->(dbSkip())
   ENDDO
   //WFS 20/08/09
   MDI_FOB_R:= DITrans(MDI_FOB_R, 2)

   SW9->(DBSETORDER(3))
   SW9->(DbSeek(cFilSW9+SW6->W6_HAWB))

   DO WHILE ! SW9->(EOF()) .AND. SW9->W9_FILIAL == cFilSW9 .AND.;
                                 SW9->W9_HAWB == SW6->W6_HAWB
      // EOB - 14/07/08 - verifica se o incoterm tem seguro incluso                                 
      IF lSegInc .AND. AvRetInco(SW9->W9_INCOTER,"CONTEM_SEG").AND. /*FDR - 27/12/10*/ /*SW9->W9_INCOTER $ "CIF,CIP,DAF,DES,DEQ,DDU,DDP"*/;
         ( (!EMPTY(SW9->W9_SEGURO) .AND. !SW9->W9_SEGINC $ cSim) .OR. SW9->W9_SEGINC $ cSim )
         lSegInv := .T.
      ENDIF

      MDespMoe := DI500RetVal("TOT_INV,SEM_FOB", "TAB", .T.,, .T.)  // EOB - 14/07/08 - chamada da função DI500RetVal
      
      MDespesas+=DITRANS(MDespMoe*DI154TaxaFOB(),2) 
   
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"WHILE_SW9"),)
   
      SW9->(DBSKIP())
   ENDDO
   MDI_FOB_R += MDespesas
ENDIF
//SVG - 09/06/09 -
IF nTipoNF # CUSTO_REAL
   //TRP- 01/04/09 - Exibe mensagem e não permite a geração da nota caso algum item da Invoice não possua os campos Adição e Sequencia Adição.
   If lFaltaAdic
      For i:= 1 to Len(aItemInv)
         If i == Len(aItemInv)
            cMensagem+= Alltrim(aItemInv[i])
         Else
            cMensagem+= Alltrim(aItemInv[i]) + ", "
         Endif
      Next 
      ///MsgInfo("Campo adição ou sequência da adição não está preenchido para os seguinte(s) item(s) da Invoice: "+ cMensagem,"Atenção!")
      VERLOG(STR0350+ cMensagem) //LCS.18/05/2009.17:17 //STR0350 "Campo adição ou sequência da adição não está preenchido para os seguinte(s) item(s) da Invoice: "
      Return .F.
      aItemInv:= {}
   Endif
EndIf

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRVWORK_1"),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK_1"),)

cDespBase:=""    // Bete - 28/09/04
DI154GrvDespesa()
lLoop:=.F.
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"POS_GRV_DESP"),)
IF lLoop
   RETURN .F.
ENDIF

DI154IncProc()

// IF nTipoNF # NFE_COMPLEMEN .OR. lComIcms .OR. lRateioCIF //AWR Rateio
IF lApuraCIF .OR. lComIcms .OR. lRateioCIF  // Bete 24/11 - Trevo
   IF lExecAuto .AND. TYPE("nW6_FOB_TOT") = "N"
      IF(nW6_FOB_TOT=0,nW6_FOB_TOT:=MDI_FOB_R,)
      MDI_FOBR_ORI:=nW6_FOB_TOT
   ELSE
      MDI_FOBR_ORI := MDI_FOB_R
   ENDIF
   nFOBRatSeg:= MDI_FOB_R
   MDI_FRETE := ValorFrete(SW6->W6_HAWB,,,1)
   MDI_SEGURO:= IF(lSegInv,0,SW6->W6_VLSEGMN)
   
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"VAL_COMPOE_CIF"),)   // Bete 26/11 - Trevo
   
   IF lExecAuto
      IF TYPE("nSeguroReal") = "N"
         MDI_SEGURO:=nSeguroReal
      ENDIF
      IF TYPE("nFreteReal") = "N"
         MDI_FRETE :=nFreteReal
      ENDIF
   ENDIF
 
   MDI_CIF:=DITrans(MDI_FOB_R + MDI_FRETE + MDI_SEGURO + nSomaNoCIF + nPSomaNoCIF,2)
   MDI_CIFPURO:= DITrans( MDI_FOB_R + MDI_FRETE + MDI_SEGURO,2)
           
   IF lImpostos
      
      //TRP - 05/11/12

      If AvFlags("AVINT_FINANCEIRO_EIC")
         tDI_II  :=MDI_II  :=AvInt_SWDVal(DESPESA_II)   
      Else
         SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+DESPESA_II))
         tDI_II  :=MDI_II  :=DI154_SWDVal()
      Endif
      
      DI154VerDespesas("I.I.",SWD->(EOF()))

      If AvFlags("AVINT_FINANCEIRO_EIC")
         tDI_IPI :=MDI_IPI :=AvInt_SWDVal(DESPESA_IPI) 
      Else
         SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+DESPESA_IPI))
         tDI_IPI :=MDI_IPI :=DI154_SWDVal()
      Endif

/*      IF lCurrier
         tDI_IPI := MDI_IPI := 0
      ENDIF
*/
      DI154VerDespesas("I.P.I.",SWD->(EOF()))

      //TRP - 05/11/12

      If AvFlags("AVINT_FINANCEIRO_EIC")
         tDI_ICMS:=MDI_ICMS:=AvInt_SWDVal(DESPESA_ICMS) 
      Else
         SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+DESPESA_ICMS))
         tDI_ICMS:=MDI_ICMS:=DI154_SWDVal()
      Endif
      
      DI154VerDespesas("I.C.M.S.",SWD->(EOF()))

      IF lMV_PIS_EIC
         
         If AvFlags("AVINT_FINANCEIRO_EIC")
            MDI_PIS:=AvInt_SWDVal(DESPESA_PIS)
         Else
            SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+DESPESA_PIS))
            MDI_PIS:=DI154_SWDVal()
         Endif
         DI154VerDespesas("PIS",SWD->(EOF()))

         If AvFlags("AVINT_FINANCEIRO_EIC")
            MDI_COF:=AvInt_SWDVal(DESPESA_COF)
         Else
            SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+DESPESA_COF))
            MDI_COF:=DI154_SWDVal()
         Endif
         DI154VerDespesas("COFINS",SWD->(EOF()))
      ENDIF
   ENDIF
ELSE
   MDI_FOBR_ORI := MDI_FOB_R
ENDIF

DI154IncProc()
//IF nTipoNF # NFE_COMPLEMEN .AND. (nTipoNF # NFE_PRIMEIRA .OR. cPaisLoc # "BRA")
IF !lDespNProc // .AND. nTipoNF <> 5  // EOS - 13/05  // SVG - 25/08/2010 - Nopado, não gravava sww
   SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB)) //AWR 13/7/98
   SWD->(DbEval(bDDIAcu,bDespDiFor,bDespDiWhi))//Le todas as despesas
ENDIF

DI154IncProc()
//IF nTipoNF = NFE_PRIMEIRA
IF !lOut_Desp    // Bete 24/11 - Trevo          EOS - 13/05 
   MDI_OUTR:=MDI_OU_US:=nDifCamb:=0
   MDI_OUTRP:=MDI_OU_USP:=0  //EOS
ENDIF

DI154IncProc()

IF nTipoNF = CUSTO_REAL
   DI154Tela(tDI_II,tDI_IPI,tDI_ICMS,MDI_PIS,MDI_COF)
ENDIF
  
//IF nTipoNF = NFE_COMPLEMEN
IF lDespNProc  // Bete 24/11 - Trevo
   MDI_OUTR:=MDI_OU_US:=nDifCamb:=0
   MDI_OUTRP:=MDI_OU_USP:=0
   aDespesa:={}
   SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB))
   SWD->(DbEval(bDDIAcu,bDDIFor,bDDIWhi))//Ignora despesas com Numero de Nota
   IF Empty(MDI_OUTR) .AND. Empty(MDI_OUTRP) .AND.;
   !((lExiste_Midia .AND. lHaUmaMidia .OR. lNewMidia)) // AAF 14/11/2007 - Permite a nota complementar de mídia.
      Return .F.
   Endif
ENDIF

ProcRegua(50)

SW7->(DbSeek(xFILIAL("SW7")+SW6->W6_HAWB))

aRecWork1:={} // Para os Rdmakes

ProcRegua(SW8->(LASTREC()))

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ANTES_WHILE_SW8"),)

If lIntDraw
   ED4->(dbSetOrder(2))
   ED0->(dbSetOrder(1))
EndIf
//AWR - 21/01/2005 - Tem que colocar o codigo (EIU_ADICAO) no EIB para dar certo
//IF lAcresDeduc .AND. lImpostos//AWR - 21/01/2005 - Deve entrar aqui na Primeira, Unica e Custo //nTipoNF = CUSTO_REAL
// nNBM_Acres:=nNBM_Deduc:=0
// EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB)) 
// DO WHILE !EIU->(eof()) .AND. EIU->EIU_HAWB == SW6->W6_HAWB  
//    Work_EIU->(DBAPPEND())
//    AVREPLACE("EIU","Work_EIU")
//    IF EIU->EIU_TIPO == "A"
//       SJN->(DBSEEK(xFilial()+EIU->EIU_CODIGO))
//       Work_EIU->EIU_DESC:=SJN->JN_DESC 
//       nNBM_Acres+=EIU->EIU_VALOR
//    ELSE
//       SJO->(DBSEEK(xFilial()+EIU->EIU_CODIGO))
//       Work_EIU->EIU_DESC:=SJO->JO_DESC
//       nNBM_Deduc+=EIU->EIU_VALOR
//    ENDIF            
//    EIU->(dbSkip())
// ENDDO
//ENDIF                   

      
Work1->(dbsetorder(3)) 

SW0->(DBSETORDER(1))
SYQ->(DBSETORDER(1))
SY1->(DBSETORDER(1))
SYD->(DBSETORDER(1))
SW9->(DBSETORDER(1))
SW8->(DBSETORDER(1))
SW8->(DBSEEK(cFilSW8+SW6->W6_HAWB))
//SVG - 17/03/09
If !lTemAdicao
   IF SELECT("TRB_ADI") > 0
	   TRB_ADI->(DbCloseArea())
   ENDIF
   DI154Ord()
   bWhile:={||!TRB_ADI->(EOF())}      
   TRB_ADI->(DbGoTop())
Else
   bWhile:={||!SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB}
EndIf

nSeqAdicao := 0 // Bete 
nTotSoft:= 0 //TRP - 01/06/09
DO WHILE  Eval(bWhile)//SVG - 17/03/09 !SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB
   //SVG - 17/03/09   
   If !lTemAdicao
      SW8->(DBGOTO(TRB_ADI->WKRECNOSW8))
   EndIf
   //**TRP - 01/06/09 - Novo Tratamento de Mídia e Software  
   If lNewMidia  
      SW3->(DbSetOrder(1))
      
      //Caso o item seja Software armazenar os valores de FOB, Inland, Packing ...
      If GetMV("MV_SOFTNFC",,"N") $ cSim  .AND. (nTipoNF==NFE_COMPLEMEN .OR. nTipoNF==NFE_UNICA)
         // TRP - 05/11/12
         If SW3->(DbSeek(xFilial("SW3")+SW8->W8_PO_NUM+AvKey(SW8->W8_CC,"W3_CC")+SW8->W8_SI_NUM+SW8->W8_COD_I))
            If SW3->W3_SOFTWAR == "1"
               nTotSoft+= (DI500RetVal("ITEM_INV", "TAB", .T.,, .T.) *DI154TaxaFOB())
            Endif
         Endif
      Endif
      
      //Caso o item seja Software não gravá-lo na Work.
      //TRP - 05/11/12
      If SW3->(DbSeek(xFilial("SW3")+SW8->W8_PO_NUM+AvKey(SW8->W8_CC,"W3_CC")+SW8->W8_SI_NUM+SW8->W8_COD_I))
         If SW3->W3_SOFTWAR == "1"
            If !lTemAdicao
               TRB_ADI->(DbSkip())
               LOOP
            Else
               SW8->(DBSKIP())
   	           LOOP
            EndIf   
         Endif    
      Endif
   
   Endif
   //**

   DI154IncProc(STR0136+' '+SW8->W8_COD_I) //"Lendo Item: "

   SB1->(DbSeek(cFilSB1+SW8->W8_COD_I))
   SW2->(DbSeek(cFilSW2+SW8->W8_PO_NUM))
   //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
   SW9->(DbSeek(cFilSW9+SW8->W8_INVOICE+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+SW8->W8_HAWB))
   
   // O While é mantido, pois nem todos possuem a alteração no índice 1 da SW9 (FILIAL+INVOICE+FORNECEDOR+HAWB)
   // A alteração do índice 1 da SW9 é disponibilizada através do update UIINVOICE
   DO WHILE !SW9->(EOF()) .AND. SW9->W9_FILIAL  == cFILSW9         .AND.;
                                SW8->W8_INVOICE == SW9->W9_INVOICE .AND.;
                                SW8->W8_FORN    == SW9->W9_FORN    .And.;
                                (!EICLoja() .Or. SW8->W8_FORLOJ == SW9->W9_FORLOJ)
      IF SW8->W8_HAWB  == SW9->W9_HAWB
         EXIT
      ENDIF
      SW9->(DBSKIP())
   ENDDO
   
   IF !SW7->(DbSeek(cFilSW7+SW8->W8_HAWB+SW8->W8_PO_NUM+SW8->W8_POSICAO+SW8->W8_PGI_NUM))
      MsgInfo(STR0293, STR0022)//"Os itens das invoices não estão de acordo com o embarque. Marque novamente as invoices e regrave o desembaraço."###"Atenção"
      //Help("",1,"AVG0000804")//"Existe Desbalanceamento no Banco de Dados, por favor saia do Sistema.","Atencao: Arquivo SW8 => SW7")
      RETURN .F.
   ENDIF
   
  

   IF(IPIPauta(),lTemPauta := .T.,)

   lMidia:=.F.
   IF lExiste_Midia .AND. SB1->B1_MIDIA $ cSim
      nFbMid_M  := DITrans( SB1->B1_QTMIDIA * SW8->W8_QTDE * SW2->W2_VLMIDIA, 2 )
      nFbMid_MRS:= DITrans( nFbMid_M * DI154TaxaFOB(), 2 )
      IF !SW9->W9_FREINC $ cSim
         nRatIPD := SW8->W8_FRETEIN
      ENDIF
      lMidia:=.T.
   ELSE
      nRatIPD := DITRANS(DI500RetVal("ITEM_INV,SEM_FOB", "TAB", .T.,, .T.),2) // EOB - 14/07/08 - chamada da função DI500RetVal
   ENDIF
   
   // EOB - Verifica se for nota complementar, tiver pelo menos um item com mídia e não tiver despesas cadastradas, não grava os itens que não 
   // tiverem mídia.                  
   IF lDespNProc .AND. lExiste_Midia .AND. lHaUmaMidia .AND. Empty(MDI_OUTR) .AND. Empty(MDI_OUTRP) .AND. !lMidia
      //SVG - 17/03/09   
      If !lTemAdicao
         TRB_ADI->(DbSkip())
         LOOP
      Else
         SW8->(DBSKIP())
   	     LOOP
      EndIf
   ENDIF

   M->WK_TEC    := SW8->W8_TEC
   M->WK_EX_NCM := SW8->W8_EX_NCM
   M->WK_EX_NBM := SW8->W8_EX_NBM
   lLoop:=.f.
   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRVWORK_1a"),)
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK_1a"),)
   If lLoop
    //SVG - 17/03/09   
      If !lTemAdicao
         TRB_ADI->(DbSkip())
         LOOP
      Else
         SW8->(DBSKIP())
   	     LOOP
      EndIf
   ENDIF

   IF lQbgOperaca//AWR - 18/09/08 - NFE
      cOperacao:=IF(EMPTY(SW8->W8_OPERACA),SW7->W7_OPERACA,SW8->W8_OPERACA)
   ELSE
      cOperacao:=SW7->W7_OPERACA
   ENDIF
   EICSFabFor(cFilSA5+SW8->W8_COD_I+SW8->W8_FABR+SW8->W8_FORN,EICRetLoja("SW8", "W8_FABLOJ"), EICRetLoja("SW8", "W8_FABLOJ"))
   SA2->(DBSEEK(cFilSA2+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")))
   SWP->(DBSEEK(cFilSWP+SW8->W8_PGI_NUM+SW8->W8_SEQ_LI))
   SWZ->(DbSeek(cFilSWZ+cOperacao))//AWR - 18/09/08 - NFE
   SWX->(DbSeek(cFilSWX+SWZ->WZ_CFO))// SVG - 04/05/2010 - Seek para a gravação do CFO da Nota Filha
   SYD->(DbSeek(cFilSYD+M->WK_TEC+M->WK_EX_NCM+M->WK_EX_NBM))

   Work1->(DBAPPEND())
   If !Empty(SW8->W8_AC)  // TLM 19/05/2008 - Caso seja integrado com drawback, o número da adição pode ser modificado, caso contrário será gerado pelo sistema.
      Work1->WKADICAO  := SW8->W8_ADICAO   
   //ELSEIF !EMPTY(SW8->W8_ADICAO)  // EOB 02/06/2008 - Caso não seja integrado com drawback, mas já vier com a adição preenchida, significa que tem regime tributário informado.
   //RMD - 10/09/08 - Verifica se realmente é regime tributário, caso contrário é uma adição informada manualmente.
   // ELSEIF !EMPTY(SW8->W8_ADICAO) .And. EIJ->(Dbseek(xFilial()+SW8->W8_ADICAO)) // EOB 02/06/2008 - Caso não seja integrado com drawback, mas já vier com a adição preenchida, significa que tem regime tributário informado.
   //ELSEIF !EMPTY(SW8->W8_ADICAO) .And. EIJ->(Dbseek(xFilial()+SW8->W8_HAWB+SW8->W8_ADICAO)) // AST - 02/10/08 - Inclusão do campo SW8->W8_HAWB no dbSeek
   ELSEIF !lExisteSEQ_ADI .And. !EMPTY(SW8->W8_ADICAO) .And. EIJ->(Dbseek(xFilial()+SW8->W8_HAWB+SW8->W8_ADICAO)) // AST - 21/11/08 - Verifica se não existe os campos para adição
      WORK1->WKGRUPORT := SW8->W8_ADICAO
   ELSEIF !EMPTY(SW8->W8_ADICAO)
      Work1->WKADICAO  := SW8->W8_ADICAO   
   EndIF
   IF lExisteSEQ_ADI//AWR - 18/09/08 NFE
      WORK1->WKGRUPORT:=SW8->W8_GRUPORT
   EndIF
   
   If lTemPrimeira
      nRegSWN := SWN->(RecNo())
      nOrdSWN := SWN->(IndexOrd())
      nRegSF1 := SF1->(RecNo())
      nOrdSF1 := SF1->(IndexOrd())
      nOrdSWV := SWV->(IndexOrd())
      nRegSWV := SWV->(Recno())
      lAchou  := .F.
      
      SWV->(dbSetOrder(2))//WV_FILIAL+WV_HAWB+WV_INVOICE+WV_PGI_NUM+WV_PO_NUM+WV_POSICAO
      SWN->(dbSetOrder(1))//WN_FILIAL+WN_DOC+WN_SERIE+WN_TEC+WN_EX_NCM+WN_EX_NBM
      
      SF1->(dbSetOrder(5)) //F1_FILIAL+F1_HAWB+F1_TIPO_NF+F1_DOC+F1_SERIE
      SF1->(dbSeek(xFilial("SF1")+SW6->W6_HAWB))
      Do While SF1->(F1_FILIAL+F1_HAWB) == xFilial("SF1")+SW6->W6_HAWB .AND. !lAchou
         //ISS - 13/12/10 - Verificação se o HAWB corrente possui alguma nota gerada, e não apenas notas de despesas (NFD)
         If lCposNFDesp .AND. !ExistHAWBNFE(SF1->F1_HAWB)
            SF1->(DbSkip())
            Loop                                                                
         EndIf
         If SWN->(dbSeek(xFilial("SWN")+SF1->(F1_DOC+F1_SERIE)+SW8->(W8_TEC+W8_EX_NCM+W8_EX_NBM)))
            Do While SWN->(WN_FILIAL+WN_DOC+WN_SERIE+WN_TEC+WN_EX_NCM+WN_EX_NBM) == xFilial("SWN")+SF1->(F1_DOC+F1_SERIE)+SW8->(W8_TEC+W8_EX_NCM+W8_EX_NBM)
               If SWN->WN_HAWB+SWN->WN_INVOICE+SWN->WN_PO_EIC+SWN->WN_ITEM+SWN->WN_PGI_NUM == SW8->(W8_HAWB+W8_INVOICE+W8_PO_NUM+W8_POSICAO+W8_PGI_NUM)
                 // If lLote .And. SWV->(dbseek(XFILIAL("SWV")+SWN->WN_HAWB+SWN->WN_INVOICE+SWN->WN_PGI_NUM+SWN->WN_PO_EIC+SWN->WN_ITEM)) 
                    // If Alltrim(SWV->WV_LOTE) == AllTrim(SWN->WN_LOTECTL)
                        Work1->WKADICAO  := SWN->WN_ADICAO
                       // Work1->WKNOTAOR  := SWN->WN_DOC //DFS - 14/02/11 - Adição de campos na verificação
                       // Work1->WKSERIEOR := SWN->WN_SERIE //DFS - 14/02/11 - Adição de campos na verificação
                        lAchou := .T.
                        EXIT         
                     //EndIf
                  /*Else
                     Work1->WKADICAO  := SWN->WN_ADICAO
                   //  Work1->WKNOTAOR  := SWN->WN_DOC //DFS - 14/02/11 - Adição de campos na verificação
                   //  Work1->WKSERIEOR := SWN->WN_SERIE //DFS - 14/02/11 - Adição de campos na verificação
                     lAchou := .T.
                     EXIT
                  EndIf*/
               EndIf
               SWN->(dbSkip())
            EndDo
         EndIf
         
         SF1->(dbSkip())
      EndDo
      
      SF1->(dbSetOrder(nOrdSF1),dbGoTo(nRegSF1))
      SWN->(dbSetOrder(nOrdSWN),dbGoTo(nRegSWN))
      SWV->(dbSetOrder(nOrdSWV),dbGoTo(nRegSWV))
   EndIf
   
   SY6->(DBSEEK(xFilial("SY6")+SW9->W9_COND_PA+STR(SW9->W9_DIAS_PA,3,0)))// AWR 27/08/2004  - SEM COBERTURA
   Work1->WKSEMCOBER:=(SY6->Y6_TIPOCOB == "4")// AWR 27/08/2004  - SEM COBERTURA
   IF Work1->WKSEMCOBER
      lTemItSemCob:=.T.
   ENDIF
   Work1->WKNROLI   := SWP->WP_REGIST
   Work1->WKFORN    := SW8->W8_FORN
   Work1->WKNOME    := SA2->A2_NOME  //TRP-26/10/07
   Work1->WKFABR    := SW8->W8_FABR
   
   If EICLoja()
      Work1->WKLOJA := SW8->W8_FORLOJ
      Work1->WKFABLOJ := SW8->W8_FABLOJ
   Else
      Work1->WKLOJA:= SA2->A2_LOJA
   EndIf

   //FSM - 02/09/2011 - Peso Bruto Unitario
   If lPesoBruto
      Work1->WKPESOBR := SW8->W8_PESO_BR
   EndIf
   
   Work1->WKTEC     := M->WK_TEC
   Work1->WKEX_NCM  := M->WK_EX_NCM
   Work1->WKEX_NBM  := M->WK_EX_NBM
   Work1->WK_CONDPAG:= SW9->W9_COND_PA
   Work1->WK_DIASPAG:= SW9->W9_DIAS_PA
   Work1->WKMOEDA   := SW9->W9_MOE_FOB
   Work1->WKINCOTER := SW9->W9_INCOTER
   Work1->WKCOD_I   := SW8->W8_COD_I
   Work1->WKPO_NUM  := SW8->W8_PO_NUM
   Work1->WKPOSICAO := SW8->W8_POSICAO
   Work1->WKPGI_NUM := SW8->W8_PGI_NUM
   //Work1->WKLOJA    := SA2->A2_LOJA
   Work1->WKQTDE    := SW8->W8_QTDE
   Work1->WKPRECO   := SW8->W8_PRECO
   Work1->WKFRETEIN := SW8->W8_FRETEIN
   Work1->WKDESCR   := MEMOLINE(MSMM(SB1->B1_DESC_P,cTam),60)
   Work1->WKUNI     := BUSCA_UM(SW7->W7_COD_I+SW7->W7_FABR +SW7->W7_FORN,SW7->W7_CC+SW7->W7_SI_NUM,EICRetLoja("SW7", "W7_FABLOJ"),EICRetLoja("SW7", "W7_FORLOJ"))
   Work1->WKREC_ID  := SW7->(RECNO())
   Work1->WKPO_SIGA := DI154_PO_SIGA() // RA - 24/10/03 - O.S. 1075/03 // Antes=>SW2->W2_PO_SIGA
   Work1->WK_CC     := SW8->W8_CC     
   Work1->WKSI_NUM  := SW8->W8_SI_NUM
   Work1->WK_CFO    := If(lMv_NF_MAE .And. nTipoNF == NFE_FILHA .And. SWX->(FieldPos("WX_CFOFILH")) # 0 , SWX->WX_CFOFILH,SWZ->WZ_CFO)// SVG - 04/05/2010 - Gravação do CFO da Nota Filha
   Work1->WK_OPERACA:= cOperacao//AWR - 18/09/08 - NFE
   Work1->WK_REG    := SW8->W8_REG //Campo para procurar o lote e Seg. UM
   Work1->WKRECSW9  := SW9->(RECNO())
   Work1->WKINVOICE := SW8->W8_INVOICE
   Work1->WKOUTDESP := SW8->W8_OUTDESP
   Work1->WKINLAND  := SW8->W8_INLAND
   Work1->WKPACKING := SW8->W8_PACKING
   Work1->WKDESCONT := IF(!lIn327,SW8->W8_DESCONT,0) // JBS - 29/10/2003
   Work1->TRB_ALI_WT := "SW8"
   Work1->TRB_REC_WT := SW8->(Recno())
   
   

   IF lExisteSEQ_ADI// AWR - 18/09/08 - NFE
      Work1->WKSEQ_ADI := SW8->W8_SEQ_ADI
   ENDIF
   IF lMV_GRCPNFE//Campos novos NFE - AWR 06/11/2008
      IF !Empty(SWZ->WZ_RED_CTE)                      //NCF - 12/11/2009 - Grava a aliquota da carga tribut. equivalente
         Work1->WKPREDICM :=SWZ->WZ_RED_CTE           //                   caso a mesma esteja pre-enchida, senão, grava
      ELSE                                            //                   a aliquota de redução da base de ICMS.
         Work1->WKPREDICM :=SWZ->WZ_RED_ICM
      ENDIF
   ENDIF
   IF lPCBaseICM
      Work1->WKPCBsICM := SWZ->WZ_PC_ICMS  
   ENDIF
   IF lVlUnid // LDR
      Work1->WKQTDE_UM:=SW8->W8_QTDE_UM
   ENDIF

   //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
   lRegTrib := .F.
   If EIJ->(DBSeek(cFilEIJ+SW6->W6_HAWB+Work1->WKGRUPORT))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
      lRegTrib := .T.
      Work1->WKFUNREG := EIJ->EIJ_FUNREG
      Work1->WKMOTADI := EIJ->EIJ_MOTADI
   EndIf
   Work1->WKTACOII := SW8->W8_TACOII
   Work1->WKACO_II := SW8->W8_ACO_II
   Work1->WKNVE := SW8->W8_NVE
   IF lAUTPCDI//JVR - 10/02/10 - Incluido validação, pois existe casos onde não ira existir estes campos.
      Work1->WKREG_PC := SW8->W8_REG_PC
      Work1->WKFUN_PC := SW8->W8_FUN_PC
      Work1->WKFRB_PC := SW8->W8_FRB_PC
   EndIf
   Work1->WKREGTRII := SW8->W8_REGTRI
   Work1->WKREGTRIPI := SW8->W8_REGIPI
   //**
   //SVG - 07/07/09 - 
   IF EMPTY(Work1->WKADICAO)
      Work2->(dbSetorder(1))
      lSeekWk2 := Work2->(DbSeek(EVAL(bSeekWk2)))
   ELSE
      Work2->(dbSetorder(2))
      lSeekWk2 := Work2->(DbSeek(Work1->WKADICAO))
   ENDIF   
   lNovaAdi := .F.
   DO WHILE .T.
      IF !lSeekWk2 .OR. lNovaAdi//Work2->(DbSeek(EVAL(bSeekWk2))) .OR. lNovaAdi
         IF !EMPTY(WORK1->WKADICAO) .AND. (nTipoNF == NFE_PRIMEIRA .OR. !lTemPrimeira)
            nOrdWK2 := Work2->(IndexOrd())
            nRegWK2 := Work2->(Recno())
            WORK2->(dbSetOrder(2))     
            IF WORK2->(dbSeek(WORK1->WKADICAO))
               cMensErro := Di154VerAdi()
               IF !Empty(cMensErro)
                  MSGINFO(STR0351 + Work1->WKADICAO + ":" + CHR(13)+CHR(10)+ cMensErro ) //STR0351 "Atencao! Não é possivel gerar a nota. Foram encontradas divergencias na adicao: "
                  RETURN .F.
               ENDIF
            ENDIF         
            Work2->(dbSetOrder(nOrdWK2))
            Work2->(dbGoto(nRegWK2))
         ENDIF
            
         Work2->(DBAPPEND())        
   
         // Bete - controle por adição
         If Val(Work1->WKADICAO) > nSeqAdicao
            nSeqAdicao := Val(Work1->WKADICAO) 
         Else
            nSeqAdicao++
         EndIf
         
         Work2->WKADICAO := If(Empty(Work1->WKADICAO),STRZERO(nSeqAdicao,LEN(SW8->W8_ADICAO)),Work1->WKADICAO)
         AADD(aContrAdicao,{If(Empty(Work1->WKADICAO),nSeqAdicao,Val(Work1->WKADICAO)),1})
         
         //
         Work2->WKNROLI   := SWP->WP_REGIST
         Work2->WKFORN    := SW8->W8_FORN
         Work2->WKNOME    := SA2->A2_NOME  //TRP-26/10/07
         Work2->WKFABR    := SW8->W8_FABR
         
         If EICLoja()
            Work2->WKLOJA := SW8->W8_FORLOJ
            Work2->WKFABLOJ := SW8->W8_FABLOJ
         EndIf
         
         Work2->WKTEC     := M->WK_TEC
         Work2->WKEX_NCM  := M->WK_EX_NCM
         Work2->WKEX_NBM  := M->WK_EX_NBM
         Work2->WK_CONDPAG:= SW9->W9_COND_PA
         Work2->WK_DIASPAG:= SW9->W9_DIAS_PA
         Work2->WKMOEDA   := SW9->W9_MOE_FOB
         Work2->WKINCOTER := SW9->W9_INCOTER
         Work2->WK_CFO    := SWZ->WZ_CFO
         Work2->WK_OPERACA:= Work1->WK_OPERACA//SW7->W7_OPERACA - //AWR - 18/09/08 - NFE
         Work2->TRB_ALI_WT := "SW9"
         Work2->TRB_REC_WT := SW9->(Recno())

//       IF nTipoNF # NFE_COMPLEMEN .OR. lICMS_NFC
         IF lImpostos .OR. lICMS_NFC      // Bete 23/11 - Trevo
            IF !SWZ->(EOF())
               Work2->WKICMS_A  := DITRANS(SWZ->WZ_AL_ICMS,2)
               Work2->WKICMS_RED:= IF(SWZ->WZ_RED_ICM#0,(100-SWZ->WZ_RED_ICM)/100,1)
               Work2->WKRED_CTE := SWZ->WZ_RED_CTE
               IF SWZ->(FIELDPOS("WZ_ICMS_PC")) # 0
                  Work2->WKICMSPC := SWZ->WZ_ICMS_PC//ASR - 10/10/2005
               ENDIF
			   // EOB 16/02/09                                   
			   IF lICMS_Dif .AND. ASCAN( aICMS_Dif, {|x| x[1] == Work1->WK_OPERACA} ) == 0
                  //                Operação           Suspensao        % diferimento    % Credito presumido                % Limite Cred.   % pg desembaraco   Aliq. do ICMS    Aliq. do ICMS S/ PIS
                  AADD( aICMS_Dif, {Work1->WK_OPERACA, SWZ->WZ_ICMSUSP, SWZ->WZ_ICMSDIF, IF( lICMS_Dif2, SWZ->WZ_PCREPRE, 0), SWZ->WZ_ICMS_CP, SWZ->WZ_ICMS_PD, SWZ->WZ_AL_ICMS, SWZ->WZ_ICMS_PC     } )
      		   ENDIF
            ELSE
               Work2->WKICMS_A  := DITRANS(SYD->YD_ICMS_RE,2)
               Work2->WKICMS_RED:= 1
               IF SYD->(FIELDPOS("YD_ICMS_PC")) # 0                                            //NCF - 10/06/2011 - Aliq. De ICMS para PIS/COFINS na N.c.m
                  Work2->WKICMSPC := SYD->YD_ICMS_PC
               ENDIF 
            ENDIF
         ENDIF
         IF lImpostos   // Bete 23/11 - Trevo
            Work2->WKII_A   := SYD->YD_PER_II
            Work2->WKIPI_A  := SYD->YD_PER_IPI
         ENDIF
         //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
         If  EIJ->(DBSeek(cFilEIJ+SW6->W6_HAWB+Work1->WKGRUPORT))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
            Work2->WKFUNREG  := EIJ->EIJ_FUNREG
            Work2->WKMOTADI  := EIJ->EIJ_MOTADI
         EndIf
         Work2->WKTACOII  := SW8->W8_TACOII
         Work2->WKACO_II  := SW8->W8_ACO_II
         Work2->WKREGTRII := SW8->W8_REGTRI
         //Work2->WKTAXASIS := SW8->W8_TAXASIS
         Work2->WKNVE := SW8->W8_NVE
         IF lAUTPCDI//JVR - 10/02/10 - Incluido validação, pois existe casos onde não ira existir estes campos.
             Work2->WKREG_PC := SW8->W8_REG_PC
             Work2->WKFUN_PC := SW8->W8_FUN_PC
             Work2->WKFRB_PC := SW8->W8_FRB_PC
         EndIf
         Work2->WKREGTRIPI := SW8->W8_REGIPI
         //**
         
         EXIT
      ELSEIF EMPTY(Work1->WKADICAO) // SVG - 07/07/09 -
         // Bete - quando temos mais de uma adição com chaves idênticas, significa que houve um estouro de itens dentro da adição. Neste caso é 
         // necessário um loop dentro da Work2 para localizar a adição disponível.
         If nTipoNF # NFE_COMPLEMEN  //CCH - 24/11/08 - Só efetua tratamento de estouro se não for Nota Complementar
         
            lAchouAdi := .F.
            DO WHILE !Work2->(EOF()) .AND. EVAL(bWhileWk)  
               // Bete - Se a adição já vier preenchida na Work1 vinda do SW8, posicioná-la na Work2                
               IF !EMPTY(Work1->WKADICAO) .AND. Work1->WKADICAO <> WORK2->WKADICAO
                  Work2->(dbSkip())
                  LOOP
               ENDIF

               //AAF - 23/06/2009 - Aceita o numero da adicao vindo do SW8. (Quando preenchido Work1->WKADICAO)               
               N:=ASCAN(aContrAdicao,{|A| A[1]==VAL(Work2->WKADICAO)})
               IF !Empty(Work1->WKADICAO) .OR.  N > 0 .AND. aContrAdicao[N,2] < nItensAdi
                  lAchouAdi := .T.
                  EXIT
               ENDIF
               Work2->(dbSkip())
            ENDDO   
            IF lAchouAdi 
               aContrAdicao[N,2]++
               EXIT
            ELSE
               lNovaAdi := .T.
               LOOP
            ENDIF  
         ELSE
            EXIT
         ENDIF   
      ELSE
         Exit
      ENDIF
   ENDDO
   Work1->WKADICAO := Work2->WKADICAO  // Bete - controle por adição

   If lIntDraw
      IF ED4->(DBSEEK(xFilial()+SW8->W8_AC+SW8->W8_SEQSIS))
         // AAF 23/11/2006 - As aliquotas não devem ser zeradas. Somente o valor dos impostos.
         //Work2->WKII_A :=0
         //Work2->WKIPI_A:=0
         IF ED0->(DBSEEK(xFilial()+ED4->ED4_PD))
            IF cQbrACModal = "1"
               Work1->WKACMODAL:=SW8->W8_AC
            ELSEIF cQbrACModal = "2"
               Work1->WKACMODAL:=ED0->ED0_MODAL
            ENDIF
            IF ED0->ED0_TIPOAC # "02" .AND. ED0->ED0_MODAL = "1"//Intermediario e suspensao
               //Work2->WKICMS_A:= 0
            ENDIF
         ENDIF
         Work2->WKACMODAL:=Work1->WKACMODAL
      ENDIF
   EndIf

   lPesoNew:=SW7->W7_PESO

   IF(ExistBlock("ICPADDI0"),ExecBlock("ICPADDI0",.F.,.F.,"PESONEW"),)
   IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"PESONEW"),)

   nPesoL    := lPesoNew * Work1->WKQTDE
   If lPesoBruto
      nPesoB  := Work1->WKQTDE* SW8->W8_PESO_BR // FSM - 02/09/2011
   EndIf   
   nFobMoeda := DITrans(Work1->WKPRECO*Work1->WKQTDE,2)
   nRatIPD_RS:= DITRANS(nRatIPD*DI154TaxaFOB(),2)
// nPrecoReal:= IF(lExecAuto, (DI154TaxaFOB()*nFobMoeda) ,SW8->W8_PRECO_R)
   nPrecoReal:= nFobMoeda * DI154TaxaFOB()    // Bete 27/11 - Trevo 

// IF lMidia .AND. nTipoNF # NFE_COMPLEMEN 
   IF lMidia //.AND. lApuraCIF //AWR Midia 5/5/04    // Bete 24/11 - Trevo 
      nFobTot  := DITrans(nFbMid_M  ,2)
      nFobRSTot:= DITrans(nFbMid_MRS,2)
      Work1->WKRATEIO  :=((nFbMid_MRS+nRatIPD_RS)/MDI_FOB_R)//TRP - 10/09/2007
   ELSE
      nFobTot  := DITrans(nFobMoeda,2)
      nFobRSTot:= DITrans(nPrecoReal,2)
      Work1->WKRATEIO  :=((nPrecoReal+nRatIPD_RS)/MDI_FOB_R)
   ENDIF

   Work1->WKICMS_RED:= Work2->WKICMS_RED
   Work1->WKICMSPC  := Work2->WKICMSPC

   IF lMidia
      Work1->WK_VLMID_M:= DITrans(nFbMid_MRS,2)
      Work1->WK_QTMID  := SB1->B1_QTMIDIA * Work1->WKQTDE
//    IF nTipoNF # NFE_PRIMEIRA .AND. lNaoTemComp
//    IF lDifCamb .AND. lNaoTemComp  // Bete 24/11 - Trevo
      IF lSomaDifMidia .AND. lNaoTemComp // AWR - MIDIA - 7/5/4
         nTaxa:=BuscaTaxa(cMoeDolar,SW6->W6_DT_DESE,.T.,.F.,.T.)
         IF(nTaxa=0,nTaxa:=1,)
         nDespDif := SW8->W8_INLAND+SW8->W8_PACKING+SW8->W8_OUTDESP-IF(!lIn327,SW8->W8_DESCONTO,0) // Bete - 24/02/05
         Work1->WKRDIFMID := DITrans( ((nFobMoeda+nDespDif) - (Work1->WK_QTMID * SW2->W2_VLMIDIA))* DI154TaxaFOB(),2 ) // Bete - 24/02/05
         Work1->WKUDIFMID := DITrans( ((nFobMoeda+nDespDif) - (Work1->WK_QTMID * SW2->W2_VLMIDIA)) * IF(SW9->W9_MOE_FOB=cMoeDolar,1,(DI154TaxaFOB()/nTaxa)) ,2 ) // Bete - 24/02/05
         Work2->WKRDIFMID += Work1->WKRDIFMID
         Work2->WKUDIFMID += Work1->WKUDIFMID
      ENDIF
   ENDIF  // AWR - MIDIA - 7/5/4
// IF nTipoNF # NFE_PRIMEIRA .AND. lNaoTemComp
   IF lDifCamb .AND. lNaoTemComp   // Bete 24/11 - Trevo
      Work1->WKRDIFMID += DITrans( nDifCamb * Work1->WKRATEIO ,2)
      Work2->WKRDIFMID += DITrans( nDifCamb * Work1->WKRATEIO ,2)// AWR - MIDIA - 7/5/4
   ENDIF  

   IF(ASCAN(aLista,{|F|F=SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")})=0,AADD(aLista,SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")+"-"+SA2->A2_NREDUZ),)

   AADD(aRecWork1,Work1->(RECNO()))
   IF nPesoL > nValToTPeso//AWR - 20/06/2006
      MSGSTOP(STR0352+ALLTRIM(Work1->WKCOD_I)+STR0353)//STR0352 "O item: " //STR0353 " esta com peso total acima do suportado pelo sistema, verifique se o peso unitario esta correto no desembaraco. Em caso de duvidas entre em contato com o Suporte."
      RETURN .F.
   ENDIF
   Work1->WKPESOL   := IF(lMV_NF_MAE .And. nTipoNF==NFE_FILHA, lPesoNew, nPesoL)
   If lPesoBruto // FSM - 02/09/2011
      Work1->WKPESOBR := IF(lMV_NF_MAE .And. nTipoNF==NFE_FILHA, SW8->W8_PESO_BR, nPesoB)//RRV - 04/01/2013
   EndIf   
   Work1->WKFOB     := DITrans(nFobTot + nRatIPD,2)
   Work1->WKFOB_R   := DITrans(nFobRSTot + nRatIPD_RS,2)
   Work1->WKFOB_ORI := Work1->WKFOB
   Work1->WKFOBR_ORI:= Work1->WKFOB_R
   
   If (lMV_NF_MAE .And. nTipoNF == NFE_FILHA .And. GetMV("MV_NFFILHA",,"0") == "2")
      Work1->WKSEGURO:= 0
   Else
      Work1->WKSEGURO  := DITrans(MDI_SEGURO*Work1->WKRATEIO ,2)
   Endif
   
   // PLB 18/01/07 - Permite gravacao das aliquotas mesmo sendo utilizado em Drawback
   IF lImpostos .AND. lMV_PIS_EIC //.AND. !(lIntDraw .AND. !Empty(SW8->W8_AC))
      If lRegTrib
         Work1->WKPERPIS := EIJ->EIJ_ALAPIS
         Work1->WKREDPIS := EIJ->EIJ_REDPIS
         Work1->WKPERCOF := EIJ->EIJ_ALACOF
         Work1->WKREDCOF := EIJ->EIJ_REDCOF
         Work1->WKVLUPIS := EIJ->EIJ_ALUPIS
         Work1->WKVLUCOF := EIJ->EIJ_ALUCOF 
         If lCposCofMj                                                             //NCF - 20/07/2012 - Majoração COFINS
            Work1->WKALCOFM := EIJ->EIJ_ALCOFM
         EndIf
         If lCposPisMj                                                             //GFP - 11/06/2013 - Majoração PIS
            Work1->WKALPISM := EIJ->EIJ_ALPISM
         EndIf          
      Else
		 Work1->WKPERPIS := SYD->YD_PER_PIS
		 Work1->WKREDPIS := SYD->YD_RED_PIS
		 Work1->WKPERCOF := SYD->YD_PER_COF
		 Work1->WKREDCOF := SYD->YD_RED_COF
         Work1->WKVLUPIS := SYD->YD_VLU_PIS
         Work1->WKVLUCOF := SYD->YD_VLU_COF
         
         If lCposCofMj                                                             //NCF - 20/07/2012 - Majoração COFINS
            Work1->WKALCOFM := EicGetPerMaj( SYD->(YD_TEC+YD_EX_NCM+YD_EX_NBM) , cOperacao ,SYT->YT_COD_IMP, "COFINS")                                                              
			Work1->WKPERCOF += Work1->WKALCOFM
         EndIf   
         If lCposPisMj                                                             //GFP - 11/06/2013 - Majoração PIS
            Work1->WKALPISM := EicGetPerMaj( SYD->(YD_TEC+YD_EX_NCM+YD_EX_NBM) , cOperacao ,SYT->YT_COD_IMP, "PIS")                                                              
			Work1->WKPERPIS += Work1->WKALPISM
         EndIf
      EndIf
      
      Work2->WKPERPIS := Work1->WKPERPIS
      Work2->WKREDPIS := Work1->WKREDPIS
      Work2->WKPERCOF := Work1->WKPERCOF
      Work2->WKREDCOF := Work1->WKREDCOF
      Work2->WKVLUPIS := Work1->WKVLUPIS
      Work2->WKVLUCOF := Work1->WKVLUCOF
                                                                      
      If lCposCofMj                                                              //NCF - 20/07/2012 - Majoração COFINS
         Work2->WKALCOFM := Work1->WKALCOFM
      EndIf 
      If lCposPisMj                                                              //GFP - 11/06/2013 - Majoração PIS
         Work2->WKALPISM := Work1->WKALPISM
      EndIf
   ENDIF

   IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"WHILE_SW8_ANTES_SOMATORIA"),)// AWR - MIDIA - 7/5/4

   IF (Work2->WKPESOL+Work1->WKPESOL) > nValToTPeso//AWR - 20/06/2006
      MSGSTOP(STR0354)//STR0354 "A somatoria dos pesos dos itens esta acima do suportado pelo sistema, verifique se os pesos unitários estão corretos no desembaraço. Em caso de duvidas entre em contato com o Suporte."
      RETURN .F.
   ENDIF
   If !(lMV_NF_MAE .And. nTipoNF == NFE_FILHA) // SVG - 27/05/2010 - 
      Work2->WKPESOL   += Work1->WKPESOL
      Work2->WKFOB     += Work1->WKFOB
      Work2->WKFOB_R   += Work1->WKFOB_R
      Work2->WKFOB_ORI += Work1->WKFOB_ORI
      Work2->WKFOBR_ORI+= Work1->WKFOBR_ORI
      Work2->WKQTDE    += Work1->WKQTDE
      Work2->WKSEGURO  += Work1->WKSEGURO
      IF !lMidia
         Work2->WKPESOSMID+=Work1->WKPESOL
      ENDIF
   EndIf
   MDI_PESO  += nPesoL
   MDI_QTDE  += Work1->WKQTDE

   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRVWORK_4"),)
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK_4"),)
    //SVG - 17/03/09   
    If !lTemAdicao
       TRB_ADI->(DbSkip())
       LOOP
    Else
       SW8->(DBSKIP())
   	   LOOP
    EndIf

ENDDO

SW8->(dbSetOrder(1))
SW8->(dbSeek(cFilSW8+SW6->W6_HAWB))
If !lTemAdicao
   IF SELECT("TRB_ADI") > 0
	   TRB_ADI->(DbCloseArea())
   ENDIF
   DI154Ord()
   bWhile:={||!TRB_ADI->(EOF())}      
   TRB_ADI->(dbGoTop())
Else
   bWhile:={||!SW8->(EOF()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB}
EndIf

IF lLote
	//Quebra os itens da NF de acordo com os lotes.
   //AWR - 21/05/2004 - MP165
   //Atencao: Essa tabela serve somente p/ campos novos que devem ser replicados (repetidos) p/ linhas dos lotes.
   aCposLote:={}
   AADD(aCposLote,"WKVLUPIS")
   AADD(aCposLote,"WKVLUCOF")
   AADD(aCposLote,"WKPERPIS")
   AADD(aCposLote,"WKPERCOF")
   AADD(aCposLote,"WKREDPIS")
   AADD(aCposLote,"WKREDCOF")
   AADD(aCposLote,"WKICMSPC")
   DBSELECTAREA("Work1")
   lExecFuncPrograma:=.F.
   ExecBlock("EICLOTE",.F.,.F.,"NF")
   IF lExecFuncPrograma
      DI154Lote()
   ENDIF
ENDIF

If (lMV_NF_MAE .And. nTipoNF == NFE_FILHA)
	//Busca informações da NF Mãe.
	Di154NfFilha()
Endif

lTemItens  := .F.
lGrvWk2    := .F.
If (lMV_NF_MAE .And. nTipoNF == NFE_FILHA) .And. (SF1->(DBSeek(xFilial("SF1")+SW6->W6_HAWB+"5")) .Or. SF1->(DBSeek(xFilial("SF1")+SW6->W6_HAWB+"3")) .Or. SF1->(DBSeek(xFilial("SF1")+SW6->W6_HAWB+"1"))) //SVG - 07/04/2011 - Nota fiscal filha a partir da nota primeira , unica ou mãe.
   Work1->(dbGoTop())
   Do While Work1->(!EOF()) .And. !lTemItens
      If Work1->WKSLDDISP > 0
         lTemItens:= .T.
      EndIf
      Work1->(dbSkip())
   EndDo
   WORK1->(DBGOTOP())
   If lTemItens 
      IF DI154FILHA()
         lGrvWk2 := .T.
      ELSE
         RETURN .F.
      ENDIF
   Else
      MsgInfo(STR0301)
      Return .F.
   EndIf
Else
   lGrvWk2 := .F.  //*******
EndIf
If lGrvWk2
      Work1->(dbGoTop())
      Do While Work1->(!EOF()) //.And. Eval(bWhile)
         
         //SW8->(dbSeek(cFilSW8+SW6->W6_HAWB+Work1->WKINVOICE+Work1->WKPO_NUM+Work1->WKPOSICAO+Work1->WKPGI_NUM))
         
         If !lTemAdicao
            SW8->(dbGoTo(TRB_ADI->WKRECNOSW8))
         EndIf
         M->WK_TEC    := SW8->W8_TEC
         M->WK_EX_NCM := SW8->W8_EX_NCM
         M->WK_EX_NBM := SW8->W8_EX_NBM
         EICSFabFor(cFilSA5+SW8->W8_COD_I+SW8->W8_FABR+SW8->W8_FORN, EICRetLoja("SW8", "W8_FABLOJ"), EICRetLoja("SW8", "W8_FORLOJ"))
         SA2->(dbSeek(cFilSA2+SW8->W8_FORN+EICRetLoja("SW8", "W8_FORLOJ")))
         SWP->(dbSeek(cFilSWP+SW8->W8_PGI_NUM+SW8->W8_SEQ_LI))
         SWZ->(dbSeek(cFilSWZ+cOperacao))//AWR - 18/09/08 - NFE
         SYD->(dbSeek(cFilSYD+M->WK_TEC+M->WK_EX_NCM+M->WK_EX_NBM))
         
         DI154GrvWK2()
         
         If !lTemAdicao
            TRB_ADI->(DbSkip())
         Else
            SW8->(dbSkip())
   	     EndIf
   	     
   	     Work1->(dbSkip())
   	  
   	  EndDo
   	  WORK1->(DBGOTOP())
EndIf  

If !lTemAdicao
   IF SELECT("TRB_ADI") > 0
      TRB_ADI->(DbCloseArea())
   Endif
EndIf

//IF nTipoNF # NFE_COMPLEMEN 
IF lImpostos   // Bete 24/11 - Trevo 
   DI154LeEIB(.T.)
ENDIF
If nTipoNf == NFE_COMPLEMEN
   DI154GrvOri()
EndIf
             
//** PLB 04/06/07 - Transferido para depois do Loop da Work2. Rateio TX SISCOMEX sem DI Eletronica.
//lGravaWK3 := .T.
//IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK_3"),)
//IF lGravaWK3
//   DI154Work3Grv()
//ENDIF
//**

IF nTipoNF = CUSTO_REAL//CR
   Work1->(DBSETORDER(3))
ENDIF

//TRP - 02/06/09 - Caso o parâmetro MV_SOFTNFC esteja ligado o valor total do software (nTotSoft) deverá ser somado à variável MDI_OUTR. 
If lNewMidia .AND. GetMV("MV_SOFTNFC",,"N") $ cSim .AND. (nTipoNF==NFE_COMPLEMEN .OR. nTipoNF==NFE_UNICA)
   SF1->(dbSetOrder(5))
   If !SF1->(dbSeek(xFilial("SF1") + SW6->W6_HAWB + "2"))
      MDI_OUTR += nTotSoft
   Endif
Endif

IF !(lMV_NF_MAE .And. nTipoNF == NFE_FILHA)
   Work2->(DBGOTOP())
   ProcRegua( Work2->( LASTREC() ) * 3 )
   nRecno:=Work2->(RECNO())
   nRecnoMidia:= nMaior      := 0
   nNBM_CIF   := nNBM_SEGURO := nNBM_IPI := 0
   nNBM_FRETE := nNBM_FOB_R  := nNBM_II  := 0
   nRDIFMID   := nOUTRDESP   := nOUTRD_US:= 0
   nDespCIF_NCM:= nDespICMS_NCM:= nNBM_ICMS:= 0

   nFreMaior:=Work2->WKFRETE
   nFreRecno:=Work2->(RECNO())
   nTotFreTira := 0 //LAM 19/10/06
   //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
   nQtdRecWK2 := Work2->( RecCount() )
   nQtdAdicao := 0
   nTotTxSisc := 0
   nTotTxComp := DI154DspSis() //30  // TLM 26/10/2007       //NCF - 24/05/2011 - Atualização dos valores da taxa siscomex na tabela SX5 conforme
   nIniTxComp := nTotTxComp
                                                             //                   Portaria No. 257 do Ministerio da Fazenda publicada em 23/05/2011 
   If(nTotTxComp == 30,DI500AtuTab("R"),DI500AtuTab("A"))                                                          
   //**
   DO WHILE  Work2->(!EOF())   
      
      IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"RATEIO_ACRESCIMO"),)  //GFP - 31/01/2013
   
      If !lExitPE .AND. lDespAcrescimo .AND. Work2->WKVLACRES == 0       // GFP - 31/01/2013
         Acrescimo()
      EndIf

      DI154IncProc(STR0137) //"Gravando impostos das NCMs"

      // IF nTipoNF # NFE_COMPLEMEN .OR. lComIcms .OR. lRateioCIF //AWR Rateio
      IF lApuraCIF .OR. lComIcms .OR. lRateioCIF  //Bete 23/11 - Trevo
         DI154Impostos(.F.,"1")//Calcula o Frete e o CIF Total sem Frete
      ENDIF          

      //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
      nQtdAdicao++
      If nTxSisc > 0
         nValTxComp := 0
         Work2->WKTAXASIS := DI154TxSisc(nQtdAdicao,nQtdRecWK2)
         nTotTxSisc += Work2->WKTAXASIS
         nTotTxComp += nValTxComp  // TLM 26/10/07 - Calcula o valor da taxa siscomex a partir do SX5.
      EndIf
      //**
      Work2->(dbSkip())
   ENDDO

   //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
   IF nTxSisc > 0 .AND. !(nTipoNF==NFE_COMPLEMEN)
      lTxSiscOK := nTxSisc == nTotTxComp  // TLM 26/10/07 - Compara o valor total da taxa siscomex calculada com a informada pelo usuário.
      If !lTxSiscOK    
         If !lRatCIF               // TLM 25/10/07 - Caso o rateio seja pelo FOB, a mensagem não deve ser mostrada.
            cMsgInfo := STR0355  //"Valor da taxa do Siscomex apurado não bate com o informado. " //STR0355 "Valor da taxa do Siscomex apurado não bate com o informado. "
            cMsgInfo += STR0356  //"O rateio da taxa será realizado pelo " //STR0356 "O rateio da taxa será realizado pelo "
            cMsgInfo += IIF(lRatCIF,"CIF","FOB")+"." + CHR(10) + CHR(13)  // "CIF" , "FOB"
            cMsgInfo += STR0357 + Alltrim(Transform(nTotTxComp,"@E 999,999,999,999.99")) + CHR(10) + CHR(13) // BHF-15/05/09 - Informando valores. //STR0357 "Taxa Siscomex: "
            cMsgInfo += STR0358 + Alltrim(Transform(nTxSisc,"@E 999,999,999,999.99")) + CHR(10) + CHR(13) + CHR(10) + CHR(13)  //STR0358 "Taxa Informada: "
            cMsgInfo += STR0359  //STR0359 "Esta taxa é cadastrada em Despesas, no Desembaraço. Verifique o parâmetro 'MV_CODTXSI'"
            MsgInfo(cMsgInfo)
         EndIf   
         nSomaBaseICMS += nTxSisc
   
         //ASK 07/08/07 - Rateio TX SISCOMEX por Valor
         Work2->(DbGoTop())
         Do While Work2->(!EOF())
            Work2->WKTAXASIS := 0
            Work2->(DbSkip())
         EndDo
         nTxSisc := 0
      EndIf
   EndIf
   //**

   Work2->(DBGOTOP())
   ProcRegua( Work2->( LASTREC() ) * 3 )
   DO WHILE  Work2->(!EOF())

      DI154IncProc(STR0137) //"Gravando impostos das NCMs"
   
      IF Work2->WKFOB_R > nMaior
         nMaior:=Work2->WKFOB_R
         nRecno:=Work2->(RECNO())
      ENDIF  

      // IF lExiste_Midia .AND. lHaUmaMidia .AND. nTipoNF # NFE_PRIMEIRA .AND. lNaoTemComp
      IF lExiste_Midia .AND. lHaUmaMidia .AND. lDifCamb .AND. lNaoTemComp   // Bete 24/11 - Trevo
         IF !EMPTY(Work2->WKRDIFMID)
            nRecnoMidia:=Work2->(RECNO())
         ENDIF  
      ENDIF
      
      Work2->WKSOMACIF:=DITRANS(nSomaNoCIF   *(Work2->WKFOB_R/MDI_FOB_R),2)
      Work2->WKSOMAICM:=DITRANS(nSomaBaseICMS*(Work2->WKFOB_R/MDI_FOB_R),2)

      IF lRateioCIF
         Work2->WKSOMACIF:=DITRANS(nSomaNoCIF   *((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),2)
         Work2->WKSOMAICM:=DITRANS(nSomaBaseICMS*((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),2)
      ENDIF
      
      Work2->WKSOMACIF+=DITRANS(nPSomaNoCIF   *(Work2->WKPESOL/MDI_PESO),2)
      Work2->WKSOMAICM+=DITRANS(nPSomaBaseICMS*(Work2->WKPESOL/MDI_PESO),2)

      nBaseICMS:= 0

      // IF nTipoNF # NFE_PRIMEIRA
      IF lOut_Desp    // Bete 23/11 - Trevo
         IF !lRateioCIF
            Work2->WKOUTRDESP:= DITRANS(MDI_OUTR *(Work2->WKFOBR_ORI/MDI_FOBR_ORI),2)
            Work2->WKOUTRD_US:= DITRANS(MDI_OU_US*(Work2->WKFOBR_ORI/MDI_FOBR_ORI),2)
         ELSE
            Work2->WKOUTRDESP:= DITRANS(MDI_OUTR *((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),2)
            Work2->WKOUTRD_US:= DITRANS(MDI_OU_US*((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),2)
         ENDIF      
         Work2->WKOUTRDESP+= DITrans(MDI_OUTRP *Work2->WKPESOL/MDI_PESO,2)
         Work2->WKOUTRD_US+= DITrans(MDI_OU_USP*Work2->WKPESOL/MDI_PESO,2)
      ENDIF

      //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
      If nTxSisc > 0  .And.  lTxSiscOK
         Work2->WKSOMAICM += Work2->WKTAXASIS
      EndIf
      //**

      // IF nTipoNF = NFE_COMPLEMEN .AND. lICMS_NFC
      // IF lICMSCompl .AND. lICMS_NFC   // Bete 24/11 - Trevo
      //    Work2->WKICMS := DI154CalcICMS( Work2->WKSOMAICM , Work2->WKICMS_RED , Work2->WKICMS_A , Work2->WKRED_CTE)
      //    Work2->WKICMS := DITrans( Work2->WKICMS * Work2->WKICMS_A/100,2)
      // ENDIF

      IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"WHILE_1_WORK2"),)// AWR - MIDIA - 7/5/4

      nDespCIF_NCM += Work2->WKSOMACIF
      nDespICMS_NCM+= Work2->WKSOMAICM
      nRDIFMID     += Work2->WKRDIFMID
      nNBM_FOB_R   += Work2->WKFOB_R
      nNBM_FRETE   += Work2->WKFRETE
      nOUTRDESP    += Work2->WKOUTRDESP
      nOUTRD_US    += Work2->WKOUTRD_US

      Work2->(DBSKIP())
   ENDDO

   Work2->(DBGOTO(nRecno))

   //IF nTipoNF # NFE_COMPLEMEN .OR. lComIcms .OR. lRateioCIF
   IF lApuraCIF .OR. lComIcms .OR. lRateioCIF   // Bete 24/11 - Trevo
      IF DiTrans( MDI_FOB_R ,2 ) # DiTrans( nNBM_FOB_R,2 )
         Work2->WKFOB_R += DiTrans( MDI_FOB_R ,2 ) - DiTrans( nNBM_FOB_R,2 )
      ENDIF
   ENDIF

   //IF nNBM_FRETE > 0 .AND. DiTrans( MDI_FRETE ,2 ) # DiTrans( nNBM_FRETE,2 ) //LAM - 19/10/06
   IF nNBM_FRETE > 0 .AND. DiTrans( MDI_FRETE ,2 ) # DiTrans( (nNBM_FRETE+nTotFreTira),2 )
      Work2->WKFRETE += DiTrans( MDI_FRETE,2 ) - DiTrans( nNBM_FRETE,2 )
   ENDIF

   //IF nTipoNF # NFE_PRIMEIRA .AND. lNaoTemComp
   IF lDifCamb .AND. lNaoTemComp   //Bete 24/11 - Trevo
      IF lExiste_Midia .AND. lHaUmaMidia .AND. lSomaDifMidia // AWR - MIDIA - 7/5/4
         IF(nRecnoMidia=0,,Work2->(DBGOTO(nRecnoMidia)))
         IF DITrans(nRDIFMID,2) # DITrans(nDifCamb+(nFobItemMidia-M_FOB_MID),2)
            Work2->WKRDIFMID   += DITrans(nDifCamb+(nFobItemMidia-M_FOB_MID),2) - DITrans(nRDIFMID,2)
         ENDIF
      ELSE
         IF DITrans(nRDIFMID,2) # DITrans(nDifCamb,2)
            Work2->WKRDIFMID += DITrans(nDifCamb,2) - DITrans(nRDIFMID,2)
         ENDIF  
      ENDIF  
   ENDIF  

   //IF nTipoNF # NFE_PRIMEIRA .AND. !lRateioCIF
   IF lOut_Desp .AND. !lRateioCIF     // Bete 23/11 - Trevo
      IF DiTrans( MDI_OUTR + MDI_OUTRP, 2 ) # DiTrans( nOUTRDESP,2 )
         Work2->WKOUTRDESP += DiTrans( MDI_OUTR + MDI_OUTRP ,2 ) - DiTrans( nOUTRDESP,2 )
      ENDIF
      IF DiTrans( MDI_OU_US + MDI_OU_USP, 2 ) # DiTrans( nOUTRD_US,2 )
         Work2->WKOUTRD_US += DiTrans( MDI_OU_US + MDI_OU_USP ,2 ) - DiTrans( nOUTRD_US,2 )
      ENDIF
   ENDIF
   Work2->(DBGOTOP())

   nNBM_CIF:=nNBM_II:=nNBM_IPI:=nNBM_ICMS:=0
   nRDIFMID := nOUTRDESP := nOUTRD_US := 0

   nCIFMaior:=Work2->WKCIF
   nSeguro:=nFreteNew:=0
   nCIFNew:=0
   nSumDespI:= 0
   lAcerta:=.T.
   nSeq_AC_DE:= 0// AWR - 31/08/2004
   DO WHILE  Work2->(!EOF())
    
      DI154IncProc(STR0137) //"Gravando impostos das NCMs"
 
      // IF nTipoNF # NFE_COMPLEMEN .OR. lComIcms .OR. lRateioCIF //AWR Rateio
      IF lApuraCif .OR. lComIcms .OR. lRateioCIF  // Bete 23/11 - Trevo
         DI154Impostos(.F.,"2")//Calcula o CIF,SEGURO,II,IPI,ICMS
      ENDIF

      IF Work2->WKCIF > nCIFMaior
         nCIFMaior:=Work2->WKCIF
         nRecno   :=Work2->(RECNO())
      ENDIF  

      nNBM_CIF   +=Work2->WKCIF  ; nNBM_II    +=Work2->WKII
      // nNBM_IPI   +=Work2->WKIPI  ; nNBM_ICMS  +=Work2->WKICMS

      // IF nTipoNF == NFE_COMPLEMEN .AND. !lRateioCIF
      IF !lApuraCIF .AND. !lRateioCIF     // Bete 04/12 - Trevo
         Work2->WKCIF    := 0
         Work2->WKFRETE  := 0
         Work2->WKSEGURO := 0
      ENDIF
      IF !lImpostos .AND. !lRateioCIF     // Bete 23/11 - Trevo
         Work2->WKII     := 0
         Work2->WKIPI    := 0
         Work2->WKII_A   := 0
         Work2->WKIPI_A  := 0
      ENDIF

      nSeguro  +=Work2->WKSEGURO
      nFreteNew+=Work2->WKFRETE
      nCIFNew  +=Work2->WKCIF

      nSeq_AC_DE++ // AWR - 31/08/2004
      Work2->WKCOD_AD:=STRZERO(nSeq_AC_DE,3)// AWR - 31/08/2004
   
      Work2->(DBSKIP())
   ENDDO 

   Work2->(DBGOTO(nRecno))

   //IF nTipoNF # NFE_COMPLEMEN .OR. lComIcms .OR. lRateioCIF //AWR Rateio
   IF lApuraCIF .OR. lComIcms .OR. lRateioCIF   //Bete 24/11 - Trevo
      IF nSeguro # MDI_SEGURO
         Work2->WKSEGURO += MDI_SEGURO-DITrans(nSeguro,2)
      ENDIF

      IF MDI_FOB_R+nFreteNew+MDI_SEGURO # (nCIFNew-(nSomaNoCIF+nPSomaNoCIF))
         Work2->WKCIF   += DiTrans( MDI_FOB_R+nFreteNew+MDI_SEGURO - (nCIFNew-(nSomaNoCIF+nPSomaNoCIF)),2 )
         nCIFNew        += DiTrans( MDI_FOB_R+nFreteNew+MDI_SEGURO - (nCIFNew-(nSomaNoCIF+nPSomaNoCIF)),2 )
      ENDIF
   ENDIF
   IF DiTrans(nSomaNoCIF + nPSomaNoCIF,2) # DiTrans(nDespCIF_NCM,2)
      Work2->WKSOMACIF += DITrans(nSomaNoCIF + nPSomaNoCIF,2)-DITrans(nDespCIF_NCM,2)
   ENDIF
   IF DiTrans(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc,2) # DiTrans(nDespICMS_NCM,2)
      Work2->WKSOMAICM += DITrans(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc,2)-DITrans(nDespICMS_NCM,2)
   ENDIF

   Work2->(DBGOTOP())
   DO WHILE  Work2->(!EOF())
      
      DI154IncProc(STR0137) //"Gravando impostos das NCMs"

      IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"ANTES_RATEIO"),) // Bete 29/09
      DI154Rateio(.F.) 
   
      IF !(lDI154Rateio)
         Return .F.
      ENDIF

      //o fob em reais deve ser zerado apos o rateio, para nf complementar
   // IF nTipoNF == NFE_COMPLEMEN
      IF !lApuraCIF   //Bete 24/11 - Trevo
         Work2->WKFOB  :=0
         Work2->WKFOB_R:=0
      ENDIF
  
   // IF nTipoNF == NFE_COMPLEMEN .AND. lRateioCIF // AWR RATEIO
      IF !lApuraCIF .AND. !lRateioCIF     // Bete 04/12 - Trevo
         Work2->WKCIF    := 0
         Work2->WKFRETE  := 0
         Work2->WKSEGURO := 0
      ENDIF
      IF !lImpostos .AND. !lRateioCIF     // Bete 23/11 - Trevo
         Work2->WKII     := 0
         Work2->WKIPI    := 0
         Work2->WKII_A   := 0
         Work2->WKIPI_A  := 0
      ENDIF

      Work2->(DBSKIP())

   ENDDO
EndIf
lGravaWK3 := .T.
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK_3"),)
IF lGravaWK3
   DI154Work3Grv()
ENDIF

DI154CustSemCobert() //AWR 27/08/2004 - SEM COBERTURA

DBSELECTAREA("Work2")
DI154IncProc()
DI154TestDI(bDifere)

Work2->(DBGOTOP())

nTaxa:=BuscaTaxa(cMoeDolar,SW6->W6_DT_DESE,.T.,.F.,.T.)//Taxa do Dolar
nTaxa:=IF(nTaxa=0,1,nTaxa)

//IF nTipoNF # NFE_PRIMEIRA .AND. nTipoNF # CUSTO_REAL
IF lOut_Desp .AND. nTipoNF # CUSTO_REAL    // Bete 23/11 - Trevo
   IF LExiste_Midia .AND. lNaoTemComp .AND. lSomaDifMidia // AWR - MIDIA - 7/5/4
      MDI_OUTR += (nFobItemMidia-M_FOB_MID)
      MDI_OU_US+=((nFobItemMidia-M_FOB_MID)/nTaxa)
   ENDIF   
   IF lNaoTemComp
      MDI_OUTR += nDifCamb
   ENDIF
ELSEIF nTipoNF == CUSTO_REAL
   IF lExiste_Midia .AND. lSomaDifMidia // AWR - MIDIA - 7/5/4
      MDI_OUTR +=(nFobItemMidia-M_FOB_MID)
      MDI_OU_US+=((nFobItemMidia-M_FOB_MID)/nTaxa)
   ENDIF   
   MDI_OUTR +=nDifCamb
ENDIF

DBSELECTAREA("SW6")

//** AAF 17/09/2008 - Despesas base de imposto SIM e base de custos NAO (Ex.: Valoracao Aduaneira)
If GetMV("MV_EICNFTO",,"1") == "2"
   Work2->(DBGOTOP())
   DO WHILE Work2->(!EOF())
      Work1->(DbSeek(EVAL(bSeekWk1)))
      
      DO WHILE !Work1->(EOF()) .AND. EVAL(bWhileWk)
         
         nTiraCusto := (nSemCusto*(Work1->WKFOB_R/MDI_FOB_R)+nPSemCusto*(Work1->WKPESOL/MDI_PESO))  // BHF/BETE 06/02/09
         
         Work1->WKCIF     -= nTiraCusto
         Work1->WKVALMERC -= nTiraCusto
         
         Work1->(DBSKIP())
      ENDDO
      
      Work2->WKCIF -= (nSemCusto+nPSemCusto)
      
      Work2->(dbSkip())
   ENDDO
EndIf
//**

lRetorno := .T.  // Bete 28/11 - Trevo
IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"FINALGRAVA"),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"FINALGRAVA"),)

RETURN lRetorno

*----------------------------------------------------------------------------*
FUNCTION DI154IncProc(cMsg)
*----------------------------------------------------------------------------*
IF nContProc > 50
   ProcRegua(50)
   nContProc:=0
ENDIF
nContProc++
IncProc(cMsg)
RETURN .T.     

*----------------------------------------------------------------------------*
FUNCTION DI154GrvDespesa()// AWR 03/08/2000
*----------------------------------------------------------------------------*
LOCAL lBaseICM:=.F.
PRIVATE bValid:={|| .T. }, lJaSomou:=.F.
PRIVATE xFilSYB:=xFilial("SYB")
SYB->(DBSETORDER(1))
SWD->(DbSeek((xFilSWD:=xFilial("SWD"))+SW6->W6_HAWB))
IF lGravaWorks                                                        
   bValid:={|| SWD->WD_NF_COMP+SWD->WD_SE_NFC=cNota .OR. nTipoNF = CUSTO_REAL }
ELSE
   bValid:={|| EMPTY(SWD->WD_NF_COMP) .OR. nTipoNF = CUSTO_REAL }
ENDIF
nSomaNoCIF:=nSomaBaseICMS:=nPSomaNoCIF:=nPSomaBaseICMS:= nPSemCusto := nSemCusto := 0//AWR
nTxSisc := 0
DO WHILE  xFilSWD == SWD->WD_FILIAL .AND. SWD->WD_HAWB==SW6->W6_HAWB .AND. !SWD->(EOF())

   DI154IncProc()
   lLoop:=.F.
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ANTES_GRAVA_WORK4"),)
   IF lLoop
      SWD->(DBSKIP())
      LOOP
   ENDIF 
   
   //NCF - 12/07/2011 - Não considerar Adiantamento de Taxa Siscomex 
   //IF GetMv("MV_CODTXSI",,"") $ SWD->WD_DESPESA .And. SWD->WD_BASEADI $ cSim 
   //   SWD->(DBSKIP())
   //   LOOP   
   //ENDIF
   
   //GCC - 21/05/2013 - Filtrar as despesas que já tem Nota Fiscal de Despesa (NFD) emitida no processo de emissão de Nota Fiscal Complementar (NFC)
   //13/07/13 - Verifica se o cliente possui os campos da Nota de Despesa antes de validar
   If nTipoNF == NFE_COMPLEMEN .And. lCposNFDesp
		If SWD->(!Empty(WD_DOC) .And. !Empty(WD_SERIE))
			SWD->( DbSkip() )
			Loop
		EndIf
   EndIf 			
      
   Work4->(DBAPPEND())

   IF SYB->(DBSEEK(xFilSYB+SWD->WD_DESPESA)) .AND.  !(LEFT(SWD->WD_DESPESA,1) $ "129")
      lJaSomou:=.F.
      Work4->WKBASEICM:=SYB->YB_BASEICM
      lBaseICM:=SYB->YB_BASEICM $ cSim 
      IF lTemYB_ICM_UF                 
         Work4->WKICMS_UF:=SYB->(FIELDGET(FIELDPOS(cCpoBasICMS)))
         lBaseICM:=lBaseICM .AND. Work4->WKICMS_UF $ cSim 
      ENDIF
      //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
      If lBaseICM .AND. lImpostos
         If SWD->WD_DESPESA == cCodTxSisc    
            nTxSiscCIF := DI154_SWDVal(.T.)   //NCF - 19/07/2010 - Carrega a variavel para utilizar no rateio da taxa Sicomex por CIF
         EndIf  
         If SWD->WD_DESPESA == cCodTxSisc  .And.  !lRatCIF
            nTxSisc := DI154_SWDVal(.T.)
         EndIf
      EndIf
      //**

      //"nTipoNF # NFE_COMPLEMEN":Na complementar nao posso somar as despesas base de ICMS que ja entraram na primeira
      //No "lLerNota" nao posso somar as despesas na base de ICMS por que a base de ICMS da Primeira ja contem as despesas 
      
//    IF lBaseICM .AND. nTipoNF # NFE_COMPLEMEN .AND. !lLerNota
      IF lBaseICM .AND. lImpostos .AND. !lLerNota    //Bete 24/11 - Trevo
         IF SYB->YB_RATPESO $ cSim  .And.  !( SWD->WD_DESPESA == cCodTxSisc )//AOM - 25/08/10
            nPSomaBaseICMS += DI154_SWDVal(.T.) 
         ELSE
            If  !( SWD->WD_DESPESA == cCodTxSisc ) .Or. lRatCIF  // PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
               nSomaBaseICMS += DI154_SWDVal(.T.)
            EndIf
         ENDIF
         lJaSomou:=.T.
	  ENDIF
      IF lICMS_NFC
         Work4->WKICMSNFC:=SYB->YB_ICMSNFC
         //FDR - 04/06/13 - Verifica UF para calcular base do ICMS da despesa
         IF SYB->YB_ICMSNFC $ cSim .AND. SYB->(FIELDGET(FIELDPOS(cCpoBasICMS))) $ cSim .AND. ((lICMSCompl .AND. EVAL(bValid)) .OR. lLerNota)  // Bete 24/11 - Trevo
            IF !lJaSomou 
               IF SYB->YB_RATPESO $ cSim// AWR
                  nPSomaBaseICMS += DI154_SWDVal(.T.)
               ELSE
                  nSomaBaseICMS  += DI154_SWDVal(.T.)
               ENDIF
            ENDIF
         ENDIF         
      ENDIF
      Work4->WKBASECUS:=SYB->YB_BASECUS
      Work4->WKBASEIMP:=SYB->YB_BASEIMP
      Work4->TRB_ALI_WT := "SYB"
      Work4->TRB_REC_WT := SYB->(Recno())
      
      IF SYB->YB_BASEIMP $ cSim
         IF SYB->YB_RATPESO $ cSim
            nPSomaNoCIF += DI154_SWDVal(.T.)
         ELSE 
            nSomaNoCIF  += DI154_SWDVal(.T.)
         ENDIF
         
         //** AAF 17/09/2008 - Despesas base de imposto SIM e base de custos NAO (Ex.: Valoracao Aduaneira)
         IF !(SYB->YB_BASECUS $ cSim) .AND. (EVAL(bValid) .OR. lLerNota)
            IF SYB->YB_RATPESO $ cSim
               nPSemCusto += DI154_SWDVal(.T.)
            ELSE 
               nSemCusto  += DI154_SWDVal(.T.)
            ENDIF
         ENDIF
         //**
      ENDIF
   ENDIF
   
   // EOS - 25/04/03
   Work4->WKRATPESO:=SYB->YB_RATPESO 
   Work4->WKDESP   :=SWD->WD_DESPESA+"-"+SYB->YB_DESCR
   Work4->WKVALOR  :=DI154_SWDVal()
   Work4->WKNOTA   :=SWD->WD_NF_COMP
   Work4->WKSERIE  :=SWD->WD_SE_NFC
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVA_WOKR4"),)
   SWD->(DBSKIP())

ENDDO                    

Return NIL

*----------------------------------------------------------------------------*
FUNCTION DI154VerDespesas(cDespesa,lFimArq)
*----------------------------------------------------------------------------*
LOCAL cMsg:=""

IF lFimArq
   cMsg:=STR0138+cDespesa+STR0139 //" Despesa "###" não cadastrada para este Processo"
ELSEIF EMPTY(DI154_SWDVal())
   cMsg:=STR0138+cDespesa+STR0140 //" Despesa "###" com valor não preenchido para este Processo"
ENDIF

IF !EMPTY(cMsg)
   DI154MsgDif(.F.,1,1,cDespesa,cMsg)
ENDIF

RETURN NIL

*----------------------------------------------------------------------------
FUNCTION DI154Impostos(lAlteracao,nFlag)
*----------------------------------------------------------------------------
LOCAL nFreteTira :=0
LOCAL nFOBRateio :=Work2->WKFOB_R/MDI_FOB_R
LOCAL nPesoRateio:=Work2->WKPESOL/MDI_PESO
LOCAL nPesRatSMid:=Work2->WKPESOSMID/MDI_PESO
Local nTotAcre:= nTotDedu:=0

PRIVATE nVlIIDevido:=nBaseII:=nValII:=nValIPI:=0

IF lAlteracao
   nNBM_CIF -=Work2->WKCIF  ; nNBM_II    -=Work2->WKII
   nNBM_IPI -=Work2->WKIPI  ; nNBM_ICMS  -=Work2->WKICMS
   nNBM_PIS -=Work2->WKVLRPIS
   nNBM_COF -=Work2->WKVLRCOF
ENDIF

//Work1->(DBSETORDER(1))  Bete - controle por adição
//Work1->(DBSEEK(EVAL(bSeekWk1)))  Bete - controle por adição
Work1->(DBSETORDER(6))
Work1->(DBSEEK(Work2->WKADICAO))
IF Work1->WKSEMCOBER .AND. EMPTY(Work2->WKFOB_R)
   Work2->WKFOB_R := Work2->WKFOBRCOB
   nFOBRateio :=Work2->WKFOB_R/MDI_FOB_R
ENDIF

nRateioFrete:=nPesoRateio
IF lRatFretePorFOB
   nRateioFrete:=nFOBRateio
ELSEIF lRatFreQTDE
   nRateioFrete:=Work2->WKQTDE/MDI_QTDE
ENDIF
nFreteTira:=DITrans(MDI_FRETE*nRateioFrete,2)                      

IF nFlag = "1"

//   IF !lCurrier
      Work2->WKFRETE := nFreteTira
      IF lHaumaMidia
         Work2->WKFRETESMI:=nFreteTira:=DITrans(MDI_FRETE*nPesRatSMid,2)
      ENDIF
      IF AvRetInco(Work2->WKINCOTER,"CONTEM_FRETE")/*FDR - 27/12/10*/ //Work2->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP"
         nFOBRatSeg -=nFreteTira
         MDI_CIF    -=nFreteTira
         MDI_CIFPURO-=nFreteTira  
         Work2->WKFRETE := 0
         nTotFreTira += nFreteTira //LAM - 19/10/06
      ENDIF
/*   ELSE
      Work2->WKFRETE := 0
   ENDIF
*/
   RETURN .T.

ENDIF
//SVG 02/08/2011 - Tratamento para pegar o total de acrescimos e deduções
nTotAcre:= 0
nTotDedu:=0
nRecWork2:= Work2->(Recno())
Work2->(DbGotop())
While Work2->(!EOF())
   nTotAcre+=Work2->WKVLACRES
   nTotDedu+=Work2->WKVLDEDUC
   Work2->(dbSkip())
EndDo
Work2->(dbGoTo(nRecWork2))


IF AvRetInco(Work2->WKINCOTER,"CONTEM_FRETE")/*FDR - 27/12/10*/ //Work2->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP"
   //nFreteTira:=Work2->WKFRETE
   IF lHaumaMidia
      nFreteTira:=Work2->WKFRETESMI
   ENDIF
   //Work2->WKSEGURO:= DITrans( (MDI_SEGURO * (Work2->WKVLACRES - Work2->WKVLDEDUC)*(Work2->WKFOB_R-nFreteTira))/nFOBRatSeg,2)// SVG - 25/05/2011 - Refazendo o calculo do seguro de acordo com o Siscomex DITrans( ((Work2->WKFOB_R-nFreteTira)/nFOBRatSeg)*MDI_SEGURO ,2)//WKFOBR_ORI   
   Work2->WKSEGURO:= DITrans( MDI_SEGURO * (Work2->WKVLACRES - Work2->WKVLDEDUC + (Work2->WKFOB_R-nFreteTira))/(nFOBRatSeg+nTotAcre - nTotDedu),2)
ELSE
   //Work2->WKSEGURO:= DITrans( ((MDI_SEGURO+ Work2->WKVLACRES - Work2->WKVLDEDUC)*Work2->WKFOB_R)/nFOBRatSeg,2) // SVG - 25/05/2011 - Refazendo o calculo do seguro de acordo com o SiscomexDITrans( ((Work2->WKFOB_R)/nFOBRatSeg) * MDI_SEGURO  ,2)//WKFOBR_ORI
   Work2->WKSEGURO := DITrans(MDI_SEGURO *( Work2->WKVLACRES - Work2->WKVLDEDUC + Work2->WKFOB_R)/(nFOBRatSeg+nTotAcre - nTotDedu),2)
ENDIF

IF EIJ->(DBSEEK(cFilEIJ+SW6->W6_HAWB+Work1->WKGRUPORT))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
   nAliqIPIUsada:=nAliqIIUsada:=nBaseII:=nVlIIDevido:=0
   nValII :=DI500IICalc( "EIJ",Work2->WKFOB_R,Work2->WKFRETE,Work2->WKSEGURO,Work2->WKINCOTER,(Work2->WKSOMACIF+Work2->WKVLACRES-Work2->WKVLDEDUC),0,@nBaseII,.F.,@nVlIIDevido,IF(lAlteracao.OR.lAliqEIB,Work2->WKII_A,NIL)) // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
// nValIPI:=DI500IPICalc("EIJ",nBaseII,nValII,.F.,nVlIIDevido,0,0,IF(lAlteracao.OR.lAliqEIB,Work2->WKIPI_A,NIL))
   Work2->WKII_A  := nAliqIIUsada
// Work2->WKIPI_A := nAliqIPIUsada
ELSE
   IF lDespAcrescimo //TDF - 09/02/2012
      IF AvRetInco(Work2->WKINCOTER,"CONTEM_FRETE")
         nBaseII:=DITrans( Work2->WKFOB_R + Work2->WKSEGURO + Work2->WKVLACRES - Work2->WKVLDEDUC,2)
      ELSE
         nBaseII:=DITrans( Work2->WKFOB_R + Work2->WKFRETE + Work2->WKSEGURO + Work2->WKVLACRES - Work2->WKVLDEDUC,2)
      ENDIF 
   Else 
      IF AvRetInco(Work2->WKINCOTER,"CONTEM_FRETE")/*FDR - 27/12/10*/ //Work2->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP"
         nBaseII:=DITrans( Work2->WKFOB_R + Work2->WKSEGURO + Work2->WKSOMACIF + Work2->WKVLACRES - Work2->WKVLDEDUC,2)  // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
      ELSE
         nBaseII:=DITrans( Work2->WKFOB_R + Work2->WKFRETE + Work2->WKSEGURO + Work2->WKSOMACIF + Work2->WKVLACRES - Work2->WKVLDEDUC,2) // Bete - 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
      ENDIF 
   EndIf

   nValII   := DITrans( nBaseII * Work2->WKII_A/100,2)
   nValIPI  := DITrans( (nBaseII + nValII) * Work2->WKIPI_A/100,2)
ENDIF

//IF Work2->WKINCOTER $ "CFR,CIF,CIP,CPT,DAF,DES,DDU"  // Esta zerando no IF do nFLAG = "1", para não dar problemas no rateio das despesas quando complementar ou unica
//   Work2->WKFRETE:=0
//ENDIF

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ALTERA_CALC_IMPOSTOS_WK2"),)
  
// AST - 17/04/09
IF nSomaNoCIF > 0 .OR. nSomaBaseICMS > 0 .OR. nPSomaNoCIF > 0 .OR. nPSomaBaseICMS > 0   
   Work2->WKSOMACIF:=DITRANS(nSomaNoCIF   *(Work2->WKFOB_R/MDI_FOB_R),2)
   Work2->WKSOMAICM:=DITRANS(nSomaBaseICMS*(Work2->WKFOB_R/MDI_FOB_R),2)

   IF lRateioCIF
      Work2->WKSOMACIF:=DITRANS(nSomaNoCIF   *((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),2)
      Work2->WKSOMAICM:=DITRANS(nSomaBaseICMS*((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),2)
   ENDIF
   
   Work2->WKSOMACIF+=DITRANS(nPSomaNoCIF   *(Work2->WKPESOL/MDI_PESO),2)
   Work2->WKSOMAICM+=DITRANS(nPSomaBaseICMS*(Work2->WKPESOL/MDI_PESO),2)            
   
   //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
   If nTxSisc > 0  .And.  lTxSiscOK
      Work2->WKSOMAICM += Work2->WKTAXASIS
   EndIf
   //**
           
ENDIF
Work2->WKCIF:= nBaseII      //DITrans(Work2->WKFOB_R + Work2->WKFRETE + Work2->WKSEGURO + Work2->WKSOMACIF + Work2->WKVLACRES - Work2->WKVLDEDUC,2)

//** AAF 28/11/2006 - Se for Drwaback, não grava o valor de I.I.
If Empty(Work2->WKACMODAL)
   Work2->WKII := nValII       //DITrans(Work2->WKCIF * Work2->WKII_A/100,2)
   //TRP - 22/07/2010 - Admissão Temporária
   IF EIJ->(FieldPos("EIJ_ALPROP")) # 0 
      IF !Empty(EIJ->EIJ_MOTADI) .AND. EIJ->EIJ_ALPROP > 0
         Work2->WKII:=  DITrans(Work2->WKII *  (EIJ->EIJ_ALPROP/100), 2)
      ENDIF
   ENDIF
EndIf
//**

// Agora o IPI e ICMS sao calculados nos itens
//IF !lTemPauta
// Work2->WKIPI   := nValIPI//DITrans((Work2->WKCIF + Work2->WKII) * Work2->WKIPI_A/100,2)
// nBaseICMS      := DITrans((Work2->WKCIF + Work2->WKII + Work2->WKIPI + Work2->WKSOMAICM ),2)
// nBaseICMS      := DI154CalcICMS( nBaseICMS , Work2->WKICMS_RED , Work2->WKICMS_A , Work2->WKRED_CTE)
// Work2->WKICMS  := DITrans( nBaseICMS * Work2->WKICMS_A/100,2)
//ENDIF

IF lAlteracao
   DI154Rateio(lAlteracao)
   nNBM_CIF +=Work2->WKCIF
   nNBM_II  +=Work2->WKII
   nNBM_IPI +=Work2->WKIPI
   nNBM_ICMS+=Work2->WKICMS
   nNBM_PIS +=Work2->WKVLRPIS
   nNBM_COF +=Work2->WKVLRCOF
   DI154TestDI(bDifere)
ENDIF

//Work1->(DBSETORDER(1))  Bete - controle por adição
//Work1->(DBSEEK(EVAL(bSeekWk1)))  Bete - controle por adição
Work1->(DBSETORDER(6))
Work1->(DBSEEK(Work2->WKADICAO))
IF Work1->WKSEMCOBER .AND. !EMPTY(Work2->WKFOBRCOB)
   Work2->WKCIF   -= Work2->WKFOB_R
   Work2->WKFOB_R := 0 
ENDIF

RETURN .T.

*----------------------------------------------------------------------------*
FUNCTION DI154Rateio(lAlteracao)
*----------------------------------------------------------------------------*
LOCAL nRec, nRecFret, nValMerc:= nDesp:= nDesp_US:= nIPIBase:= nFob:= nII:= nIPI:= nFrete:= nSeguro:= nCIF:= nICMS:= 0
LOCAL nCifMaior := 0, nFretMaior:=0, cFilSB1:=xFilial("SB1") , cFilSW7:=xFilial('SW7')
LOCAL nVlICMS:=IF(lExiste_Midia,GETMV("MV_ICMSMID"),0), lPassouIPI:=.f.//, lPassouICMS:=.f.
LOCAL nSomaCIF_NCM  :=DITRANS(nSomaNoCIF    *(Work2->WKFOB_R/MDI_FOB_R),2)
//LOCAL nSomaICMS_NCM :=DITRANS(nSomaBaseICMS *(Work2->WKFOB_R/MDI_FOB_R),2)
//LOCAL nSomaICMS_NCM :=DITRANS((nSomaBaseICMS+nTxSisc) *(Work2->WKFOB_R/MDI_FOB_R),2)  // PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
LOCAL nSomaICMS_NCM //:=DITRANS((nSomaBaseICMS *(Work2->WKFOB_R/MDI_FOB_R))+Work2->WKTAXASIS,2)  // PLB 28/06/07                                 //NCF - 04/02/2013 - Nopado - So considera rateio da adicao por faixa
LOCAL nPSomaCIF_NCM :=DITRANS(nPSomaNoCIF   *(Work2->WKPESOL/MDI_PESO ),2)//EOS
LOCAL nPSomaICMS_NCM:=DITRANS(nPSomaBaseICMS*(Work2->WKPESOL/MDI_PESO ),2)//EOS
LOCAL nAuxSomaCIF:=nAuxSomaICMS:=nAcres:=nDeduc:=nAuxAcrescimo:=0  // Bete - 25/07/04 - para acerto dos acrescimos e deducoes
Local nRedPis := nRedCof := nAliPis := nAliCof := nAluPis := nAluCof := 0, lTemReg := .F. //ASR - 21/04/2006 - PIS/COFINS
Local nAliIntPis := nAliIntCof := 0  //TRP - 23/02/2010 
LOCAL cFilSYD:=xFILIAL("SYD")
LOCAL nRat
LOCAL aOrd_EIU := {}
LOCAL aOrdSW3Soft := {}
LOCAL nVlrIPIPtAux := 0
PRIVATE nVlIIDevido:=nBaseII:=nIPIBas:=nIIVal:=nIPIVal:=nVlIPIDevido:=nValorIPIPauta:=0 // RRV - 29/08/2012 - Alteração da variavel nValorIPIPauta para Private
PRIVATE nVal_Dif := nVal_CP := nVal_ICM := 0
PRIVATE cCodRatPeso := "10/13" 
PRIVATE lRatSIdifDsp := GetMv("MV_EIC0005",,.F.)         


IF lRateioCIF//ASR - 13/10/2005 - RATEIO CIF
	nSomaCIF_NCM  :=DITRANS(nSomaNoCIF    *(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO,2)
	//nSomaICMS_NCM :=DITRANS(nSomaBaseICMS *(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO,2)
	nSomaICMS_NCM :=DITRANS((nSomaBaseICMS+nTxSisc) *(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO,2)  // PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.  //NCF - 06/02/2013 - Ativacao de Linha - O valor deve ser apurado conforme o rateio configurado nos parâmetros (MV_RATCIF, MV_TXSIRAT e MV_EIC0005)
	//nSomaICMS_NCM :=DITRANS((nSomaBaseICMS *(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO)+Work2->WKTAXASIS,2)  // PLB 28/06/07                               //NCF - 06/02/2013 - Nopado            - O valor da Tx. Sicomex por adicão sempre está por valor no campo WKTAXASIS
ELSE
   If lRatCIF
      nSomaICMS_NCM :=DITRANS((nSomaBaseICMS+nTxSisc) *(Work2->WKFOB_R/MDI_FOB_R),2)
   Else
      nSomaICMS_NCM :=DITRANS((nSomaBaseICMS *(Work2->WKFOB_R/MDI_FOB_R))+Work2->WKTAXASIS,2)  // PLB 28/06/07
   EndIf
ENDIF

//JAP - 01/08/2006 - Criação do parametro para zerar o IPI para PIS/COFINS.             
If !SX6->(dbSeek(xFilial("SX6")+"MV_ZIPIPIS"))
   SX6->(RecLock("SX6",.T.))
   SX6->X6_FIL     := xFilial("SX6")
   SX6->X6_VAR     := "MV_ZIPIPIS"
   SX6->X6_TIPO    := "C"
   SX6->X6_DESCRIC := "Leis que determinam que o IPI deve ser zerado para PIS/COFINS"
   SX6->X6_CONTEUD := "9826/10485/10637"
   SX6->X6_PROPRI  := "S"
   SX6->X6_PYME    := "S"
   SX6->(MsUnlock())
EndIf 

//Work1->(DBSETORDER(1))  Bete - controle por adição
//IF !Work1->(DbSeek(EVAL(bSeekWk1)))  Bete - controle por adição
Work1->(DBSETORDER(6))
IF !Work1->(DbSeek(Work2->WKADICAO))
   Help("",1,"AVG0000804")// Existe Desbalanceamento no Banco de Dados, por favor saia do Sistema.
   RETURN .F.
ENDIF
// ISS - 26/04/10 - Adicionado o tratamento para o acerto da diferença entre o frete calculado e o frete correto da adição
nRec       :=Work1->(RECNO())
nRecFret   :=Work1->(RECNO())
nRecDcif   :=Work1->(RECNO())
nRecDICMS  :=Work1->(RECNO())
nCifMaior  := Work1->WKCIF
nFretMaior := Work1->WKFRETE
nDESPCIFMaior := Work1->WKDESPCIF
nDESPICMSMaior := Work1->WKDESPICM

//IF SB1->(DbSeek(cFilSB1+Work1->WKCOD_I)) .AND. nTipoNF # NFE_COMPLEMEN
//IF SB1->(DbSeek(cFilSB1+Work1->WKCOD_I)) .AND. lImpostos    // Bete 24/11 - Trevo
//   IF lExiste_Midia .AND. SB1->B1_MIDIA $ cSim .AND. !EMPTY(nVlICMS)
//      nNBM_ICMS    -=Work2->WKICMS
//      Work2->WKICMS:=0
//   ENDIF
//ENDIF
//IF lRateioCIF
//   Work2->WKOUTRDESP:=0
//   Work2->WKOUTRD_US:=0
//ENDIF
Work2->WKIPI      := 0
Work2->WKICMS     := 0
Work2->WKBASPIS   := 0
Work2->WKVLRPIS   := 0
Work2->WKBASCOF   := 0
Work2->WKVLRCOF   := 0
Work2->WKBASEICMS := 0
Work2->WKBASEIPI  := 0

If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
   Work2->WKVLCOFM := 0
EndIf
If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
   Work2->WKVLPISM := 0
EndIf
lAcerta:=.T.
lAcertaIPIBase:=.T.  

//DO WHILE !Work1->(EOF()) .AND. EVAL(bWhileWk)
DO WHILE !Work1->(EOF()) .AND. Work1->WKADICAO == Work2->WKADICAO
   lTemReg := .F.//AWR - 06/2009 - Tem que iniciar essa varialvel a cada item    
  IF Work1->WKSEMCOBER .AND. EMPTY(Work1->WKFOB_R)
     Work1->WKFOB_R := Work1->WKFOBRCOB
  ENDIF

  IF !lAlteracao 
      nRat := 0 
      //nRat := ROUND(Work1->WKFOB_R/Work2->WKFOB_R,2)   // TLM 10/10/2007 - Caso o rateio seja maior que um, o desembaraço deve ser gravado novamente.
      nRat := ROUND(Work1->WKFOB_R/Work2->WKFOB_R,8) //ASK 22/11/2007 - Alterado o Round de 2 para 8.
      IF INT(nRat) > 1         
         msgstop(STR0360)//STR0360 "Há uma inconsistência no rateio, por favor grave o desembaraço novamente."
         lDI154Rateio:=.F.
         RETURN .F.
      // by CAF 21/11/2007 O rateio não pode ser arredondado para 2 casas. Problemas nos clientes: ADAMS, MAKITA --> Parou a fábrica.
      //ELSE
         //Work1->WKRATEIO := nRat
      ENDIF
      Work1->WKRATEIO :=Work1->WKFOB_R/Work2->WKFOB_R // by CAF 21/11/2007 O rateio não pode ser arredondado para 2 casas.
      IF(lRatFreQTDE,Work1->WKRATQTDE:=Work1->WKQTDE/Work2->WKQTDE,)
  ENDIF
  Work1->WKRATPESO:=Work1->WKPESOL/Work2->WKPESOL//O peso pode ser mudado na alteracao

  lMidia:=.F.
  IF lExiste_Midia .AND. SB1->(DbSeek(cFilSB1+Work1->WKCOD_I))
     lMidia:=SB1->B1_MIDIA $ cSim
  ENDIF

//IF nTipoNF # NFE_COMPLEMEN
  IF lApuraCIF   // Bete 24/11 - Trevo
  
     Work1->WKFRETE:= DITrans(Work2->WKFRETE*IF(lRatFretePorFOB,Work1->WKRATEIO,IF(lRatFreQTDE,Work1->WKRATQTDE,Work1->WKRATPESO)),2)
     If ExistBlock("EICDI154") // BHF 27/02/09 - Rateio frete
        Execblock("EICDI154",.F.,.F.,"RATEIO_FRETE")
     EndIf
     IF AvRetInco(Work2->WKINCOTER,"CONTEM_FRETE")/*FDR - 27/12/10*/ //Work2->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP" .AND. !lMidia  // Jonato Midia
        Work1->WKSEGURO:= DITrans( ( (Work1->WKFOB_R-Work1->WKFRETE)  /;//WKFOBR_ORI
                                     (Work2->WKFOB_R-Work2->WKFRETE) )*;//WKFOBR_ORI
                                      Work2->WKSEGURO ,2)
     ELSE
        Work1->WKSEGURO:= DITrans( Work1->WKRATEIO * Work2->WKSEGURO ,2)
     ENDIF

     Work1->WKDESPCIF := DITrans((nSomaCIF_NCM*Work1->WKRATEIO)+(nPSomaCIF_NCM*Work1->WKRATPESO),2)//AWR
     IF lRateioCIF//DESPESA CIF - BASE DE IMPOSTO
        nRateioCIF:=(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO)/(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)//ASR - 13/10/2005 - RATEIO CIF
        Work1->WKDESPCIF := DITrans((nSomaCIF_NCM*nRateioCIF)+(nPSomaCIF_NCM*Work1->WKRATPESO),2)
     ENDIF
     // NCF - 26/07/2010 - Ponto de entrada para manipular os códigos de acrescimos a serem rateados por peso 
     If ExistBlock("EICDI154") 
        Execblock("EICDI154",.F.,.F.,"RATEIO_ACRESCIMOS")
     EndIf
     // NCF - 26/07/2010 - Calcula os acrescimos de frete da adição separadamente para ratear por peso
     IF SELECT("Work_EIU") > 0 .And. Work_EIU->(RecCount()) > 0
        aOrd_EIU := SaveOrd({"Work_EIU"})
        Work_EIU->(DbGoTop())
        Work_EIU->(DbSeek(Work2->WKADICAO))
        Do While !Work_EIU->(EOF()) .And. Work_EIU->EIU_ADICAO == Work2->WKADICAO .And. Work_EIU->EIU_TIPO == "A" 
           If Work_EIU->EIU_CODIGO $ cCodRatPeso
              Work2->WKVLACRES -= Work_EIU->EIU_VALOR
              Work2->WKVLACRFT += Work_EIU->EIU_VALOR  
           EndIf
           Work_EIU->(DbSkip())
        EndDo
        RestOrd(aOrd_EIU)           
     ENDIF
     
     /*chamada função acrescimo
     If lDespAcrescimo .AND. Work2->WKVLACRES == 0
        Acrescimo()
     EndIf*/
          
     // Bete 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos    // NCF - 23/07/2010 - Rateio dos Acréscimos de frete por peso
     Work1->WKVLACRES := DITrans( Work2->WKVLACRES * Work1->WKRATEIO, 2) + DITRANS((Work2->WKVLACRFT*(Work1->WKPESOL/Work2->WKPESOL)),2)
     Work1->WKVLDEDUC := DITrans( Work2->WKVLDEDUC * Work1->WKRATEIO, 2)
     
     IF lRateioCIF//TDF - 25/05/2012 - ACRESCIMO RATEADO POR CIF
        nRateioCIF:=(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO)/(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)//ASR - 13/10/2005 - RATEIO CIF
        Work1->WKVLACRES := DITrans( Work2->WKVLACRES * nRateioCIF, 2) + DITRANS((Work2->WKVLACRFT*(Work1->WKPESOL/Work2->WKPESOL)),2)
     ENDIF
     
     Work2->WKVLACRES += Work2->WKVLACRFT                                        // NCF - 23/07/2010 - Restaura valores para posterior reapuração
     Work2->WKVLACRFT := 0
     
     Work1->WKIITX    := Work2->WKII_A
     Work1->WKIPITX   := Work2->WKIPI_A
     Work1->WKICMS_A  := Work2->WKICMS_A
     IF lMV_PIS_EIC .AND. (lAlteracao .OR. lAliqEIB)
        Work1->WKVLUPIS := Work2->WKVLUPIS
        Work1->WKVLUCOF := Work2->WKVLUCOF
        Work1->WKPERPIS := Work2->WKPERPIS
        Work1->WKPERCOF := Work2->WKPERCOF
        Work1->WKREDPIS := Work2->WKREDPIS
        Work1->WKREDCOF := Work2->WKREDCOF
        If lCposCofMj                                                           //NCF - 20/07/2012 - Majoração COFINS
           Work1->WKALCOFM := Work2->WKALCOFM
        EndIf
        If lCposPisMj                                                           //GFP - 11/06/2013 - Majoração PIS
           Work1->WKALPISM := Work2->WKALPISM
        EndIf        
     ENDIF

     nTX_II  := Work1->WKIITX
     nTX_IPI := Work1->WKIPITX
     IF EIJ->(DBSEEK(cFilEIJ+SW6->W6_HAWB+Work1->WKGRUPORT))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
        lTemReg := .T. //ASR - 21/04/2006 - PIS-COFINS
        nBaseII:=nVlIIDevido:=nVlIPIDevido:=0
        IF lMV_GRCPNFE//Campos novos NFE - AWR 06/11/2008
           Work1->WKALUIPI  :=EIJ->EIJ_ALUIPI
           Work1->WKQTUIPI  := (Work1->WKQTDE/EIJ->EIJ_QT_EST) * EIJ->EIJ_QTUIPI // NCF - 28/02/2010 - A quantidade Específica deve ser rateada para os itens de adições diferentes em um mesmo regime de tributação
           Work1->WKQTUPIS  :=EIJ->EIJ_QTUPIS                                    //                   (Ex: quando a qtde. informada na capa é menor que a soma das quantidades dos itens no regime de tributação 
           Work1->WKQTUCOF  :=EIJ->EIJ_QTUCOF
        ENDIF
        nIIVal :=DI500IICalc( "EIJ",Work1->WKFOB_R,Work1->WKFRETE,Work1->WKSEGURO,Work1->WKINCOTER,(Work1->WKDESPCIF+Work1->WKVLACRES-Work1->WKVLDEDUC),0,@nBaseII,.F.,@nVlIIDevido,IF(lAlteracao.OR.lAliqEIB,Work1->WKIITX,NIL)) // Bete 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
        IF !lAlteracao .AND. !lAliqEIB
           Work2->WKII_A := EIJ->EIJ_ALI_II
           Work1->WKIITX := EIJ->EIJ_ALI_II
           nTX_II := EIJ->EIJ_ALI_II
        ENDIF

        SW7->(DBSEEK(cFilSW7+SW6->W6_HAWB+Work1->WKPO_NUM+Work1->WKPOSICAO+Work1->WKPGI_NUM))
        nIPIBas:=DITrans(nBaseII+nIIVal,2)//Base do IPI 
        //SVG - 30/07/2009 - IPI de pauta por peso
        If EIJ->EIJ_TPAIPI=="2" 
           lExiste_IPIPA:=.T.
           If EIJ->(FIELDPOS("EIJ_CALIPI")) > 0 .AND. EIJ->EIJ_CALIPI == "2"
              nIPIVal:=DI500IPICalc("EIJ",nBaseII,nIIVal,.F.,nVlIIDevido,@nVlIPIDevido,@nIPIBas,NIL, Work1->WKCOD_I,Work1->WKPESOL, SW7->W7_VLR_IPI )
           Else                                                                                                                                               //NCF - 28/02/2011 - Qtde do IPI de Pauta informada no reg. trib rateada por qtde item
              nIPIVal:=DI500IPICalc("EIJ",nBaseII,nIIVal,.F.,nVlIIDevido,@nVlIPIDevido,@nIPIBas,IF(lAlteracao.OR.lAliqEIB,Work1->WKIPITX,NIL), Work1->WKCOD_I,/*Work1->WKQTDE*/((Work1->WKQTDE/EIJ->EIJ_QT_EST) * EIJ->EIJ_QTUIPI), SW7->W7_VLR_IPI )
           EndIf
        Else                                                                                                                                               //NCF - 28/02/2011 - Qtde do IPI de Pauta informada no reg. trib rateada por qtde item
           nIPIVal:=DI500IPICalc("EIJ",nBaseII,nIIVal,.F.,nVlIIDevido,@nVlIPIDevido,@nIPIBas,IF(lAlteracao.OR.lAliqEIB,Work1->WKIPITX,NIL), Work1->WKCOD_I,/*Work1->WKQTDE*/((Work1->WKQTDE/EIJ->EIJ_QT_EST) * EIJ->EIJ_QTUIPI), SW7->W7_VLR_IPI )
           lExiste_IPIPA:=.F.
        EndIf
        IF !lAlteracao .AND. !lAliqEIB
           If !Empty(EIJ->EIJ_ALRIPI) // ER - 14/05/2007
              Work2->WKIPI_A := EIJ->EIJ_ALRIPI
              Work1->WKIPITX := EIJ->EIJ_ALRIPI
              nTX_IPI := EIJ->EIJ_ALRIPI     
           Else
              Work2->WKIPI_A := EIJ->EIJ_ALAIPI
              Work1->WKIPITX := EIJ->EIJ_ALAIPI
              nTX_IPI := EIJ->EIJ_ALAIPI     
           EndIf
        ENDIF
        IF DITrans(nVlIIDevido,2) # DITrans(nIIVal,2) // Se o II Devido # do II a Recolher nao é possivel acertar IPI Base
           lAcertaIPIBase := .F.
        ENDIF
        IF lImpostos
        // Work1->WKREGTRII :=EIJ->EIJ_REGTRI
        // Work1->WKREGTRIPI:=EIJ->EIJ_REGIPI
           Work1->WKPR_II   :=EIJ->EIJ_PR_II
           
           IF EIJ->EIJ_REGTRI == '4' .and. !EMPTY(EIJ->EIJ_ALR_II)
              nTX_II:=EIJ->EIJ_ALR_II
           ELSEIF EIJ->EIJ_REGTRI == '4' .and. EIJ->EIJ_PR_II <> 0 .and. EMPTY(EIJ->EIJ_ALR_II)
              nTX_II:= Work1->WKIITX - ( Work1->WKIITX * (EIJ->EIJ_PR_II/100) )
           ElseIf EIJ->EIJ_REGTRI $ '2,3,6'  // Bete - 06/05/06 - P/ IMUNIDADE, ISENCAO ou NAO-INCIDENCIA 
              nTX_II:=0                      // de II, a aliquota é zero p/ o cálculo do PIS/COFINS
           Endif   
           IF EIJ->EIJ_REGIPI $ '1,3'         // Segundo a MP252, para ISENÇÃO E IMUNIDADE de IPI, a aliquota é zero
              nTX_IPI:=0                      // p/ calculo do PIS/COFINS
           ELSEIF EIJ->EIJ_REGIPI $ '4,5' .AND. EIJ->EIJ_TPAIPI = '2' 
              nTX_IPI:= nVlIPIDevido/nBaseII+nVLIIDevido   // Bete - 06/05/06 - P/ INTEGRAL ou SUSPENSAO e a aliq. for especifica vlr IPI/VA + II resultara na aliq. a ser utilizada p/calculo do PIS
           ELSEIF EIJ->EIJ_REGIPI $ '5'       //JAP - Zera o cálculo do IPI em caso de suspensão e o ato do IPI for = LEI
              cNroipi := GetMv("MV_ZIPIPIS",,"")                  
              cEijipi := EIJ->EIJ_NROIPI  
              cNroipi := Alltrim(STRTRAN(cNroipi, ".",""))
              cEijipi := Alltrim(STRTRAN(cEijipi, ".",""))
              IF !Empty(cNroipi) .AND. cEijipi $ cNroipi .AND. ALLTRIM(EIJ->EIJ_ATOIPI) == 'LEI'
                 nTX_IPI := 0
              ENDIF
           ELSEIF EIJ->EIJ_REGIPI $ '2'     
              nTX_IPI:=EIJ->EIJ_ALRIPI  // Bete - 06/05/06 - P/ REDUCAO, considerar a aliq. reduzida
           ENDIF                 
        ENDIF
     ELSE
        If lDespAcrescimo //TDF - 09/02/2012
           nBaseII:=DITrans(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO+Work1->WKVLACRES-Work1->WKVLDEDUC,2)//CIF   // Bete 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
        Else
           nBaseII:=DITrans(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO+Work1->WKDESPCIF+Work1->WKVLACRES-Work1->WKVLDEDUC,2)//CIF   // Bete 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
        EndIf
        nIIVal :=nVlIIDevido :=DITrans(nBaseII*Work1->WKIITX/100,2)//Valor do II
        nIPIBas:=DITrans(nBaseII+nIIVal,2)//Base do IPI
        nIPIVal:=nVlIPIDevido:=DITrans(nIPIBas * (Work2->WKIPI_A/100),2)//Valor do IPI
     ENDIF

     IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ALTERA_CALC_IMPOSTOS"),)

     Work1->WKCIF := nBaseII//DITrans(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO+Work1->WKDESPCIF+Work1->WKVLACRES-Work1->WKVLDEDUC,2)
     
     IF lImpostos
        //** AAF 28/11/2006 - Não grava o valor do II caso seja Drawback
        If Empty(Work1->WKACMODAL)
           Work1->WKIIVAL   := nIIVal //DITrans(Work1->WKCIF*Work1->WKIITX/100,2)
        EndIf
        //**
     
        Work1->WKIPIBASE := nIPIBas
        Work1->WKVLDEVII := nVlIIDevido
        Work1->WKVLDEIPI := nVlIPIDevido
 
        IF SB1->(DbSeek(cFilSB1+Work1->WKCOD_I)) .AND. IPIPauta() .And. !lTemReg //SVG - 05/08/2009 - Caso tenha Reg. Tributação considerar aliquota do Regime
           lPassouIPI:=.T.
           SW7->(DBGOTO(Work1->WKREC_ID))
           EI6->(DBSetOrder(1))
           If !Empty(SB1->B1_TAB_IPI) 
              If EI6->(DBSeek(xFilial()+SB1->B1_TAB_IPI))
                 If EI6->(FIELDPOS("EI6_CALIPI")) > 0 .AND. EI6->EI6_CALIPI == "2"
                    nValorIPIPauta  := DITrans(Work1->WKPESOL * IPIPauta(.T.),2 )
                 Else
                    nValorIPIPauta  := DITrans(Work1->WKQTDE * IPIPauta(.T.),2 )
                 EndIf
              EndIf
           EndIf
           //** AAF 28/11/2006 - Não grava o valor do IPI caso seja Drawback
           If Empty(Work1->WKACMODAL)
              Work1->WKIPIVAL := Work1->WKVLDEIPI := nValorIPIPauta //DITrans(Work1->WKIPIBASE * (Work2->WKIPI_A/100),2)
           EndIf
     
        ElseIf lTemReg .AND. EIJ->EIJ_TPAIPI=="2"
           If EIJ->(FIELDPOS("EIJ_CALIPI")) > 0 .AND. EIJ->EIJ_CALIPI == "2"
              nValorIPIPauta  := DITrans(Work1->WKPESOL * EIJ->EIJ_ALUIPI )
           Else                                                                  //NCF - 28/02/2011 - IPI de Pauta deve ser calculado para toda a adição neste caso
              //nValorIPIPauta  := DITrans(EIJ->EIJ_ALUIPI *  EIJ->EIJ_QTUIPI)   //      pois o calculo aqui replica o valor do IPI Específico para cada linha de item da adição
              nValorIPIPauta := DITRANS( (EIJ->EIJ_ALUIPI *  EIJ->EIJ_QTUIPI) *  (Work1->WKQTDE / EIJ->EIJ_QT_EST),3) 
              nVlrIPIPtAux   += nValorIPIPauta 
           EndIf 
           //** AAF 28/11/2006 - Não grava o valor do IPI caso seja Drawback
           If Empty(Work1->WKACMODAL)
              Work1->WKIPIVAL := Work1->WKVLDEIPI := nValorIPIPauta //DITrans(Work1->WKIPIBASE * (Work2->WKIPI_A/100),2)
           EndIf
        ELSE                            
           //** AAF 28/11/2006 - Não grava o valor do IPI caso seja Drawback
           If Empty(Work1->WKACMODAL)
              Work1->WKIPIVAL := Work1->WKVLDEIPI := nIPIVal //DITrans(Work1->WKIPIBASE * (Work2->WKIPI_A/100),2)
           EndIf
        ENDIF
        
        IF lRatSIdifDsp                                                                                                                   //NCF - 21/09/2010 - Possibilita o rateio da taxa siscomex por CIF (MV_TXSIRTAT->T) quando as despesas
           If lRatCIF .And. !lRateioCIF                                                                                                   //                   base de ICMS forem rateadas por FOB (MV_RATCIF->F)
              //nSomaICMS_NCM := DITRANS((nSomaBaseICMS *(Work2->WKFOB_R/MDI_FOB_R))+Work2->WKTAXASIS,3)                                  //NCF - Nopado - 06/02/2013 - O valor da Tx. Sicomex por adicão sempre está por valor no campo WKTAXASIS
              nSomaICMS_NCM :=DITRANS((nSomaBaseICMS+nTxSisc) *(Work2->WKFOB_R/MDI_FOB_R),2)                                              //NCF -          06/02/2013 - O valor deve ser apurado conforme o rateio configurado nos parâmetros (MV_RATCIF, MV_TXSIRAT e MV_EIC0005)
	          nSomaICMS_NCM -= DITRANS((nTxSiscCIF * (Work2->WKFOB_R/MDI_FOB_R)),3)                                                       //NCF - 19/07/2010 - Retira a taxa siscomex rateada das despesas base ICMS da adição rateadas por FOB  
	          nAuxTxSiAd    := DITRANS(nTxSiscCIF*((Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO),3)                        //                   Apura percentual de rateio da taxa siscomex por adição	        
	          nRateioCIF    := DITRANS((Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO)/(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO),3) //                   Apura percentual de rateio CIF do item
	          nTxSiRatCIF   := DITrans((nAuxTxSiAd*nRateioCIF),3)
	       EndIf
	    
	       If !lRatCIF .And. lRateioCIF
	          //nSomaICMS_NCM := DITRANS((nSomaBaseICMS *(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO)+Work2->WKTAXASIS,3)  //NCF - 20/07/2010 - Retira a taxa siscomex rateada das despesas base ICMS da adição rateadas por CIF
	          nSomaICMS_NCM :=DITRANS((nSomaBaseICMS+nTxSisc) *(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO,2)              //NCF - Nopado - 06/02/2013 - O valor da Tx. Sicomex por adicão sempre está por valor no campo WKTAXASIS
	          nSomaICMS_NCM -= DITRANS(nTxSiscCIF*(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)/MDI_CIFPURO,3)                           //                   Apura percentual de rateio da taxa siscomex por adição
	          nAuxTxSiAd    := DITRANS((nTxSiscCIF * (Work2->WKFOB_R/MDI_FOB_R)),3)                                                        //                   Apura percentual de rateio FOB do item
	          nRateioCIF    := DITRANS((Work1->WKFOB_R/Work2->WKFOB_R),3)
	          nTxSiRatCIF   := DITrans((nAuxTxSiAd*nRateioCIF),3)
	       EndIf       
        EndIF 
              
        Work1->WKDESPICM := DITrans((nSomaICMS_NCM*Work1->WKRATEIO)+(nPSomaICMS_NCM*Work1->WKRATPESO),2)
	    
	    IF lRateioCIF
   	       nRateioCIF:=(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO)/(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO)      //ASR - 13/10/2005 - RATEIO CIF
      	   Work1->WKDESPICM := DITrans((nSomaICMS_NCM*nRateioCIF)+(nPSomaICMS_NCM*Work1->WKRATPESO),2)
	    ENDIF
	    
	    IF lRatSIdifDsp
	       If lRatCIF .And. !lRateioCIF                                                                                        //NCF - 19/07/2010 - Somar a taxa Sisc. rateada por CIF com 
	          Work1->WKDESPICM += nTxSiRatCIF                                                                                  //                   as despesas base de ICMS rateadas
	       EndIf
	    
	       If !lRatCIF .And. lRateioCIF                                                                                        //NCF - 19/07/2010 - Somar a taxa Sisc. rateada por FOB com
	          Work1->WKDESPICM += nTxSiRatCIF                                                                                  //                   as despesas base de ICMS rateadas
	       EndIf
        EndIf
        
        Work1->WKBASEICMS:= Work1->WKDESPICM 
     
        IF EMPTY(Work2->WKRED_CTE)
           nAliqICMS:= Work1->WKICMS_A
        ELSE
           nAliqICMS:= Work2->WKRED_CTE
        ENDIF
        nNewBaseICMS := 0
        IF lMV_PIS_EIC               
           SYD->(DbSeek(cFilSYD+Work1->WKTEC+Work1->WKEX_NCM+Work1->WKEX_NBM))
           nRedPis := SYD->YD_RED_PIS
           nRedCof := SYD->YD_RED_COF
           nAliPis := Work1->WKPERPIS
           nAliCof := Work1->WKPERCOF
           nAluPis := Work1->WKVLUPIS
           nAluCof := Work1->WKVLUCOF
           nAliIntPis:=Work1->WKPERPIS
           nAliIntCof:=Work1->WKPERCOF
           
           If lCposCofMj                                                           //NCF - 20/07/2012 - Majoração COFINS
              nAliCofMaj := Work1->WKALCOFM
           EndIf
           If lCposPisMj                                                           //GFP - 11/06/2013 - Majoração PIS
              nAliPisMaj := Work1->WKALPISM
           EndIf
            
           IF lAUTPCDI .AND. lTemReg
              nRedPis := DI500Block("EIJ","EIJ_PRB_PC")
              nRedCof := DI500Block("EIJ","EIJ_PRB_PC")
              nAliPis := DI500Block("EIJ","EIJ_ALAPIS")
              nAliCof := DI500Block("EIJ","EIJ_ALACOF")
              nAluPis := DI500Block("EIJ","EIJ_ALUPIS")
              nAluCof := DI500Block("EIJ","EIJ_ALUCOF")
              
              If lCposCofMj
                 nAliCofMaj := DI500Block("EIJ","EIJ_ALCOFM")
              EndIf            
              If lCposPisMj                                                           //GFP - 11/06/2013 - Majoração PIS
                 nAliPisMaj := DI500Block("EIJ","EIJ_ALPISM")
              EndIf      
              //TRP - 23/02/2010
              nAliIntPis:= DI500Block("EIJ","EIJ_ALAPIS")
              nAliIntCof:= DI500Block("EIJ","EIJ_ALACOF")
              
              IF EIJ->EIJ_REG_PC = "4" //AWR - 17/06/2009 - Correcao: o SISCOMEX considera o Aliq. Reduzida para calcular a Base PIS/COFINS
                 
                 IF EIJ->(FieldPos("EIJ_ARDPIS")) # 0 
                    IF DI500Block("EIJ","EIJ_ARDPIS") $ cSim  //TRP - 22/02/2010 
                       nAliPis := EIJ->EIJ_REDPIS
                    ENDIF
                 ELSE 
                    IF !EMPTY(EIJ->EIJ_REDPIS)
                       nAliPis := EIJ->EIJ_REDPIS
                    ENDIF
                 ENDIF
                 
                 IF EIJ->(FieldPos("EIJ_ARDCOF")) # 0
                    IF DI500Block("EIJ","EIJ_ARDCOF") $ cSim  //TRP - 22/02/2010 
                       nAliCof := EIJ->EIJ_REDCOF
                    ENDIF
                 ELSE
                    IF !EMPTY(EIJ->EIJ_REDCOF)
                       nAliCof := EIJ->EIJ_REDCOF
                    ENDIF
                 ENDIF
              
              ENDIF
           
           ENDIF
           nQtde:=Work1->WKQTDE // LDR - OC - 0048/04 - OS - 0989/04
           IF lVlUnid .AND. !EMPTY(Work1->WKQTDE_UM) // LDR - OC - 0048/04 - OS - 0989/04
              nQtde:=Work1->WKQTDE_UM
           ENDIF
           nNewBaseICMS := DITrans(DI500PISCalc(nBaseII,Work1->WKBASEICMS,(nTX_II/100),(nTX_IPI/100),(nAliqICMS/100),(nAliPIS/100),(nAliCOF/100),0,(Work1->WKICMSPC/100),nValorIPIPauta,"EICDI154"),2)//ASR - 10/10/2005
           IF !EMPTY(nALUPIS) .OR. (lAUTPCDI .AND. lTemReg .AND. EIJ->EIJ_TPAPIS == "2")//ASR - 21/04/2006
              Work1->WKBASPIS := 0
              //** PLB 18/01/07 - Não grava o valor do PIS caso seja utilizado em Drawback
              If Empty(Work1->WKACMODAL)
                 Work1->WKVLRPIS := nALUPIS * IIF(lAUTPCDI .AND. lTemReg, EIJ->EIJ_QTUPIS, nQtde)
              EndIf
              
              IF lAUTPCDI
                 Work1->WKVLDEPIS := Work1->WKVLRPIS //NCF - 08/10/2010 - Verificado separadamente uma vez que pode não existir regime de tributação e alíquota PIS ser  
              ENDIF                                  //                   informada na NCM (chmd. 730963)
              //**
              //ASR - 21/04/2006 - INICIO
              IF lAUTPCDI .AND. lTemReg
                 Work1->WKVLUPIS  := nAluPis 
                 Work1->WKPERPIS  := 0  // Zera aliquota ad. valorem por estar tratando como especifica 
                 //Work1->WKVLDEPIS := Work1->WKVLRPIS //NCF - 08/10/2010 - (Nopado)
                 IF EIJ->EIJ_REG_PC <> "1"
                    Work1->WKVLRPIS := 0
                 ENDIF
              ENDIF
              //ASR - 21/04/2006 - FIM
           ELSE
              //TRP - 23/02/2010
              //Work1->WKBASPIS:= DITrans(DI500PISCalc(nBaseII,Work1->WKBASEICMS,(nTX_II/100),(nTX_IPI/100),(nAliqICMS/100),(nAliPIS/100),(nAliIntCof/100),(nREDPIS/100),(Work1->WKICMSPC/100),If(!lTemReg,nValorIPIPauta,nIpiVal),"EICDI154",,If(!lTemReg,IpiPauta(),If(lExiste_IPIPA,.T.,.F.)),),2)//ASR - 10/10/2005
              Work1->WKBASPIS:= DITrans(DI500PISCalc(nBaseII,Work1->WKBASEICMS,(nTX_II/100),(nTX_IPI/100),(nAliqICMS/100),(nAliPIS/100),(nAliCof/100),(nREDPIS/100),(Work1->WKICMSPC/100),If(!lTemReg,nValorIPIPauta,nIpiVal),"EICDI154",,If(!lTemReg,IpiPauta(),If(lExiste_IPIPA,.T.,.F.)),),2)//ASR - 10/10/2005
              //** PLB 18/01/07 - Não grava o valor do PIS caso seja utilizado em Drawback
              If Empty(Work1->WKACMODAL)
                 Work1->WKVLRPIS:= DITrans(Work1->WKBASPIS * (nAliPIS/100),2)
              EndIf
              IF lAUTPCDI
                 Work1->WKVLDEPIS := Work1->WKVLRPIS //NCF - 08/10/2010 - Verificado separadamente uma vez que pode não existir regime de tributação e alíquota PIS ser  
              ENDIF                                  //                   informada na NCM (chmd. 730963)
              //**
              //ASR - 21/04/2006 - INICIO
              IF lAUTPCDI .AND. lTemReg
                 Work1->WKPERPIS  := IF(EIJ->EIJ_REG_PC $ "2,6", 0, nAliPis)
                 Work1->WKVLUPIS  := 0  // Zera aliquota especifica por estar tratando como ad. valorem
                 //Work1->WKVLDEPIS := Work1->WKVLRPIS //NCF - 08/10/2010 - (Nopado)
                 IF EIJ->EIJ_REG_PC = "4" 
                    IF EIJ->(FieldPos("EIJ_ARDPIS")) # 0 
                       IF DI500Block("EIJ","EIJ_ARDPIS") $ cSim //TRP - 22/02/2010 //!EMPTY(EIJ->EIJ_REDPIS) //AAF 11/09/2008 - Conforme Siscomex
                          Work1->WKPERPIS := EIJ->EIJ_REDPIS
                          //** PLB 18/01/07 - Não grava o valor do PIS caso seja utilizado em Drawback
                          If Empty(Work1->WKACMODAL)
                             Work1->WKVLRPIS:= DITrans(Work1->WKBASPIS * (Work1->WKPERPIS/100),2)
                          EndIf
                       ENDIF
                    ELSE
                       IF !EMPTY(EIJ->EIJ_REDPIS) 
                          Work1->WKPERPIS := EIJ->EIJ_REDPIS
                          //** PLB 18/01/07 - Não grava o valor do PIS caso seja utilizado em Drawback
                          If Empty(Work1->WKACMODAL)
                             Work1->WKVLRPIS:= DITrans(Work1->WKBASPIS * (Work1->WKPERPIS/100),2)
                          EndIf
                       ENDIF
                    ENDIF
                 ENDIF
                 IF EIJ->EIJ_REG_PC $ "2,3,5,6"
                    Work1-> WKVLRPIS := 0
                 ENDIF
              ENDIF
              //ASR - 21/04/2006 - FIM
           ENDIF
           IF !EMPTY(nALUCOF) .OR. (lAUTPCDI .AND. lTemReg .AND. EIJ->EIJ_TPACOF == "2")//ASR - 21/04/2006
              Work1->WKBASCOF:= 0
              //** PLB 18/01/07 - Não grava o valor do COFINS caso seja utilizado em Drawback
              If Empty(Work1->WKACMODAL)
                 Work1->WKVLRCOF:= nALUCOF * IIF(lAUTPCDI .AND. lTemReg, EIJ->EIJ_QTUCOF, nQtde)
              EndIf
              IF lAUTPCDI
                 Work1->WKVLDECOF := Work1->WKVLRCOF //NCF - 08/10/2010 - Verificado separadamente uma vez que pode não existir regime de tributação e alíquota COF ser  
              ENDIF                                  //                   informada na NCM (chmd. 730963)
              //**
              //ASR - 21/04/2006 - INICIO
              IF lAUTPCDI .AND. lTemReg
                 Work1->WKVLUCOF  := nAluCof
                 Work1->WKPERCOF  := 0  // Zera aliquota ad. valorem por estar tratando como especifica
                 
                 If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
                    Work1->WKALCOFM := 0
                 EndIf
                 If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
                    Work1->WKALPISM := 0
                 EndIf
                 
                 //Work1->WKVLDECOF := Work1->WKVLRCOF //NCF - 08/10/2010 - (Nopado)
                 IF EIJ->EIJ_REG_PC <> "1"
                    Work1->WKVLRCOF := 0
                 ENDIF             
              ENDIF
              //ASR - 21/04/2006 - FIM
           ELSE
              //TRP - 23/02/2010
              //Work1->WKBASCOF:= DITrans(DI500PISCalc(nBaseII,Work1->WKBASEICMS,(nTX_II/100),(nTX_IPI/100),(nAliqICMS/100),(nAliIntPis/100),(nAliCOF/100),(nREDCOF/100),(Work1->WKICMSPC/100),If(!lTemReg,nValorIPIPauta,nIpiVal),"EICDI154",,If(!lTemReg,IpiPauta(),If(lExiste_IPIPA,.T.,.F.)),),2)//ASR - 10/10/2005
              Work1->WKBASCOF:= DITrans(DI500PISCalc(nBaseII,Work1->WKBASEICMS,(nTX_II/100),(nTX_IPI/100),(nAliqICMS/100),(nAliPis/100),(nAliCOF/100),(nREDCOF/100),(Work1->WKICMSPC/100),If(!lTemReg,nValorIPIPauta,nIpiVal),"EICDI154",,If(!lTemReg,IpiPauta(),If(lExiste_IPIPA,.T.,.F.)),),2)//ASR - 10/10/2005
              //** PLB 18/01/07 - Não grava o valor do COFINS caso seja utilizado em Drawback
              If Empty(Work1->WKACMODAL)
                 Work1->WKVLRCOF:= DITrans(Work1->WKBASCOF * (nAliCOF/100),2)
                 
                 If lCposCofMj                                                                        //NCF - 20/07/2012 - Majoração COFINS
                    Work1->WKVLCOFM := DITrans(Work1->WKBASCOF * (nAliCofMaj/100),2)
                    Work1->WKVLRCOF := DITrans(Work1->WKBASCOF * ((nAliCOF)/100),2)
                 EndIf 
                 If lCposPisMj                                                                        //GFP - 11/06/2013 - Majoração PIS
                    Work1->WKVLPISM := DITrans(Work1->WKBASPIS * (nAliPisMaj/100),2)
                    Work1->WKVLRPIS := DITrans(Work1->WKBASPIS * ((nAliPis)/100),2)
                 EndIf
              EndIf             
              
              IF lAUTPCDI
                 Work1->WKVLDECOF := Work1->WKVLRCOF //NCF - 08/10/2010 - Verificado separadamente uma vez que pode não existir regime de tributação e alíquota COF ser  
              ENDIF                                  //                   informada na NCM (chmd. 730963)
              //**
              //ASR - 21/04/2006 - INICIO
              IF lAUTPCDI .AND. lTemReg
                 Work1->WKPERCOF  := IF(EIJ->EIJ_REG_PC $ "2,6", 0, nAliCof)
                 Work1->WKVLUCOF  := 0  // Zera aliquota especifica por estar tratando como ad. valorem
                 //Work1->WKVLDECOF := Work1->WKVLRCOF //NCF - 08/10/2010 - (Nopado)
                 IF EIJ->EIJ_REG_PC = "4" 
                    IF EIJ->(FieldPos("EIJ_ARDCOF")) # 0
                       IF DI500Block("EIJ","EIJ_ARDCOF") $ cSim //TRP - 22/02/2010 //!EMPTY(EIJ->EIJ_REDPIS) //AAF 11/09/2008 - Conforme Siscomex
                          Work1->WKPERCOF := EIJ->EIJ_REDCOF
                          //** PLB 18/01/07 - Não grava o valor do COFINS caso seja utilizado em Drawback
                          If Empty(Work1->WKACMODAL)
                             Work1->WKVLRCOF:= DITrans(Work1->WKBASCOF * (Work1->WKPERCOF/100),2)
                          EndIf
                       ENDIF
                    ELSE
                       IF !EMPTY(EIJ->EIJ_REDCOF)
                          Work1->WKPERCOF := EIJ->EIJ_REDCOF
                          //** PLB 18/01/07 - Não grava o valor do COFINS caso seja utilizado em Drawback
                          If Empty(Work1->WKACMODAL)
                             Work1->WKVLRCOF:= DITrans(Work1->WKBASCOF * (Work1->WKPERCOF/100),2)
                          EndIf
                       ENDIF
                    ENDIF
                 ENDIF   
                 IF EIJ->EIJ_REG_PC $ "2,3,5,6"
                    Work1-> WKVLRCOF := 0
                    
                    If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
                       Work1->WKVLCOFM := 0
                    EndIf
                    If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
                       Work1->WKVLPISM := 0
                    EndIf
                 ENDIF   
              ENDIF
              //ASR - 21/04/2006 - FIM
           ENDIF
        ENDIF

        IF lMidia .AND. lICMSMidiaDupl//AWR  - 27/06/2006

           Work1->WKBASEICMS:= DITrans(Work1->WK_VLMID_M * 2 ,2)
           Work1->WKVL_ICM  := DITrans(Work1->WKBASEICMS*Work1->WKICMS_A/100,2)

        ELSEIF lMidia .AND. !EMPTY(nVlICMS)//lExiste_Midia .AND. SB1->B1_MIDIA $ cSim 
           //lPassouICMS:=.T.
           Work1->WKBASEICMS+= DITrans(Work1->WK_QTMID * nVlICMS ,2)

           //** AAF 28/11/2006 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
           If !lIntDraw .OR. DI154DrawICMS()
              Work1->WKVL_ICM  := DITrans(Work1->WKBASEICMS*Work1->WKICMS_A/100,2)
           EndIf
           //**
           
        ELSE

           IF lMV_PIS_EIC .AND. lMV_ICMSPIS
            // EOB - 16/02/09 - Incluso parâmetro cOperacao para 
            //Work1->WKBASEICMS:=DI154CalcICMS(,Work2->WKICMS_RED,Work1->(IF(WKICMS_A!=0,WKICMS_A,WKICMSPC)),Work2->WKRED_CTE,Work1->WKCIF,Work1->WKBASEICMS,nNewBaseICMS,Work1->WKIIVAL,Work1->WKIPIVAL,.T.,Work1->WKVLRPIS,                                                                            Work1->WKVLRCOF,                                                                             Work1->WK_OPERACA)//ASR - 11/10/2005 - SE WKICMS_A == 0 USAR WKICMSPC
              Work1->WKBASEICMS:=DI154CalcICMS(,Work2->WKICMS_RED,Work1->(IF(WKICMS_A!=0,WKICMS_A,WKICMSPC)),Work2->WKRED_CTE,Work1->WKCIF,Work1->WKBASEICMS,nNewBaseICMS,Work1->WKIIVAL,Work1->WKIPIVAL,.T.,IF(lPCBaseICM,if(Work1->WKPCBsICM == "1",Work1->WKVLDEPIS,Work1->WKVLRPIS),Work1->WKVLRPIS),IF(lPCBaseICM,if(Work1->WKPCBsICM == "1",Work1->WKVLDECOF,Work1->WKVLRCOF),Work1->WKVLRCOF), Work1->WK_OPERACA)// NCF - 24/11/2009 - Verifica a existencia do campo
              //** AAF 28/11/2006 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.                                                                                                                                                                                                                                                                                                    // WZ_PC_ICMS e se o mesmo esta setado como "Sim", se
              If !lIntDraw .OR. DI154DrawICMS()                                                                                                                                                                                                                                                                                                                                                                         // estiver, mesmo com o PIS e COFINS suspensos, eles
                 Work1->WKVL_ICM   := DITrans(Work1->WKBASEICMS*(Work1->WKICMS_A/100),2)                                                                                                                                                                                                                                                                                                                                // irão compor a base do ICMS (Recap)
                 // PLB 14/05/07 - Tratamento para ICMS diferido
                 If lICMS_Dif 
                    DI154Diferido(.F.)
                 EndIf
              EndIf
              //SVG - 14/08/2009 - Calculo de ICMS de Pauta -  //NCF - 10/05/2011 - Acrescentado Tratamentos para considerar pauta por Peso e/ou Quantidade e C.F.O              
              SWZ->(DbSeek(xFilial("SWZ")+Work1->WK_OPERACA))  //                   A Pauta deve ser verificada no cadastro de Produtos  
              If lCposPtICMS
                 If cMV_CALCICM == "1" 
                    If !Empty(SB1->B1_VLR_ICM);//Se o produto tiver com a vl de pauta, calcula conforme a Pauta independente do CFO
                       .and. (!lIntDraw .OR. DI154DrawICMS())//JVR - 10/03/10 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
                       If !EMPTY(SWZ->WZ_TPPICMS) .And. SWZ->WZ_TPPICMS # "3" 
                          Work1->WKVLICMDEV := Work1->WKVL_ICM  //NCF - 11/05/2011 - Recupera o valor do ICMS Devido
                          If SWZ->WZ_TPPICMS == "1" 
                             Work1->WKVL_ICM := DITrans(Work1->WKPESOL*SB1->B1_VLR_ICM,2)  //NCF - 11/05/2011 - Pauta por Peso
                          ElseIf SWZ->WZ_TPPICMS == "2" 
                             Work1->WKVL_ICM := DITrans(Work1->WKQTDE*SB1->B1_VLR_ICM,2)   //NCF - 11/05/2011 - Pauta por Quantidade
                          EndIf
                       EndIf
                    EndIf
                 ElseIf cMV_CALCICM == "3"
                    If !Empty(SB1->B1_VLR_ICM);//Se a NCM tiver com a vl de pauta, calcula conforme a Pauta independente do CFO
                       .and. (!lIntDraw .OR. DI154DrawICMS())//JVR - 10/03/10 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
                       If !EMPTY(SWZ->WZ_TPPICMS) .And. SWZ->WZ_TPPICMS # "3"
                          Work1->WKVLICMDEV := Work1->WKVL_ICM  //NCF - 11/05/2011 - Recupera o valor do ICMS Devido
                          If SWZ->WZ_TPPICMS == "1" 
                             Work1->WKVL_ICM := DITrans((Work1->WKPESOL*SB1->B1_VLR_ICM)+(Work1->WKBASEICMS*(Work1->WKICMS_A/100)),2)  //NCF - 11/05/2011 - Pauta por Peso
                          ElseIf SWZ->WZ_TPPICMS == "2" 
                             Work1->WKVL_ICM := DITrans((Work1->WKQTDE*SB1->B1_VLR_ICM)+(Work1->WKBASEICMS*(Work1->WKICMS_A/100)),2)   //NCF - 11/05/2011 - Pauta por Quantidade
                          EndIf
                       EndIf
                    EndIf                  
                 EndIf
              EndIf
              //**           
           
           ELSE
              Work1->WKBASEICMS:=DITrans(Work1->WKBASEICMS+((Work1->WKCIF+Work1->WKIIVAL+Work1->WKIPIVAL)),2)//campo Work1->WKBASEICMS ja esta com a despesa rateada
              Work1->WKBASEICMS:=DI154CalcICMS(Work1->WKBASEICMS,Work1->WKICMS_RED,Work1->(IF(WKICMS_A!=0,WKICMS_A,WKICMSPC)),Work2->WKRED_CTE, , , , , , , , ,Work1->WK_OPERACA)//ASR - 10/10/2005 - SE WKICMS_A == 0 USAR WKICMSPC

              //** AAF 28/11/2006 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
              If !lIntDraw .OR. DI154DrawICMS()
                 Work1->WKVL_ICM := DITrans(Work1->WKBASEICMS*(Work1->WKICMS_A/100),2)
				 // PLB 14/05/07 - Tratamento para ICMS diferido              
                 If lICMS_Dif
                    DI154Diferido(.F.)
                 EndIf
              EndIf
              //SVG - 14/08/2009 - Calculo de ICMS de Pauta -  //NCF - 10/05/2011 - Acrescentado Tratamentos para considerar pauta por Peso e/ou Quantidade e C.F.O              
              SWZ->(DbSeek(xFilial("SWZ")+Work1->WK_OPERACA))  //                   A Pauta deve ser verificada no cadastro de Produtos  
              If lCposPtICMS
                 If cMV_CALCICM == "1" 
                    If !Empty(SB1->B1_VLR_ICM);//Se o produto tiver com a vl de pauta, calcula conforme a Pauta independente do CFO
                       .and. (!lIntDraw .OR. DI154DrawICMS())//JVR - 10/03/10 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
                       If !EMPTY(SWZ->WZ_TPPICMS) .And. SWZ->WZ_TPPICMS # "3"
                          Work1->WKVLICMDEV := Work1->WKVL_ICM  //NCF - 11/05/2011 - Recupera o valor do ICMS Devido
                          If SWZ->WZ_TPPICMS == "1" 
                             Work1->WKVL_ICM := DITrans(Work1->WKPESOL*SB1->B1_VLR_ICM,2)  //NCF - 11/05/2011 - Pauta por Peso
                          ElseIf SWZ->WZ_TPPICMS == "2" 
                             Work1->WKVL_ICM := DITrans(Work1->WKQTDE*SB1->B1_VLR_ICM,2)   //NCF - 11/05/2011 - Pauta por Quantidade
                          EndIf
                       EndIf
                    EndIf
                 ElseIf cMV_CALCICM == "3"
                    If !Empty(SB1->B1_VLR_ICM);//Se a NCM tiver com a vl de pauta, calcula conforme a Pauta independente do CFO
                       .and. (!lIntDraw .OR. DI154DrawICMS())//JVR - 10/03/10 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
                       If !EMPTY(SWZ->WZ_TPPICMS) .And. SWZ->WZ_TPPICMS # "3"
                          Work1->WKVLICMDEV := Work1->WKVL_ICM  //NCF - 11/05/2011 - Recupera o valor do ICMS Devido
                          If SWZ->WZ_TPPICMS == "1" 
                             Work1->WKVL_ICM := DITrans((Work1->WKPESOL*SB1->B1_VLR_ICM)+(Work1->WKBASEICMS*(Work1->WKICMS_A/100)),2)  //NCF - 11/05/2011 - Pauta por Peso
                          ElseIf SWZ->WZ_TPPICMS == "2" 
                             Work1->WKVL_ICM := DITrans((Work1->WKQTDE*SB1->B1_VLR_ICM)+(Work1->WKBASEICMS*(Work1->WKICMS_A/100)),2)   //NCF - 11/05/2011 - Pauta por Quantidade
                          EndIf
                       EndIf
                    EndIf                  
                 EndIf
              EndIf
              //**
           ENDIF

        ENDIF
        
        IF EMPTY(Work1->WKVL_ICM) // LDR - 19/07/04 - Nro. Solicitacao : 0054/04   Nro. O.S.: 1036/04
           IF GETMV("MV_ZERABAS",,.T.) 
              Work1->WKBASEICMS:=0     
           ENDIF
        ENDIF
        
        //TRP- 21/07/2010 - Tratamento de Admissão Temporária
        IF EIJ->(FieldPos("EIJ_ALPROP")) # 0  
           IF !Empty(EIJ->EIJ_MOTADI) .AND. EIJ->EIJ_ALPROP > 0
              Work1->WKIIVAL:=  DITrans(Work1->WKIIVAL *  (EIJ->EIJ_ALPROP/100), 2)
              Work1->WKIPIVAL:= DITrans(Work1->WKIPIVAL * (EIJ->EIJ_ALPROP/100), 2)
              Work1->WKVL_ICM:= DITrans(Work1->WKVL_ICM * (EIJ->EIJ_ALPROP/100), 2)
              Work1->WKVLRPIS:= DITrans(Work1->WKVLRPIS * (EIJ->EIJ_ALPROP/100), 2)
              Work1->WKVLRCOF:= DITrans(Work1->WKVLRCOF * (EIJ->EIJ_ALPROP/100), 2)
              
              If cPosCofMj
                 Work1->WKVLCOFM:= DITrans(Work1->WKVLCOFM * (EIJ->EIJ_ALPROP/100), 2)
              EndIf
              
           ENDIF
        ENDIF
        // Bete - 30/06/04 
        IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ALTERA_CALC_IMPOSTOS_2"),)

     ENDIF
     
     IF AvRetInco(Work1->WKINCOTER,"CONTEM_FRETE")/*FDR - 27/12/10*/ //Work1->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP"
        Work1->WKFRETE:=0
        lAcerta:=.F.
     ENDIF
// ISS - 26/04/10 - Adicionado o tratamento para o acerto da diferença entre o frete calculado e o frete correto da adição
     IF Work1->WKCIF > nCifMaior
        nCifMaior := Work1->WKCIF
        nRec := Work1->(RECNO())
     ENDIF
	 
     IF Work1->WKDESPCIF > nDESPCIFMaior
        nDESPCIFMaior := Work1->WKDESPCIF
        nRecDcif := Work1->(RECNO())
     ENDIF
     
     IF Work1->WKDESPICM > nDESPICMSMaior
        nDESPICMSMaior := Work1->WKDESPICM
        nRecDICMS := Work1->(RECNO())
     ENDIF
	  
     IF Work1->WKFRETE > nFretMaior
        nFretMaior := Work1->WKFRETE
        nRecFret := Work1->(RECNO())
     ENDIF

//   IF nTipoNF == NFE_PRIMEIRA
     IF nTipoNF # CUSTO_REAL    // Bete 06/12 
        Work1->WKVALMERC := Work1->WKCIF+Work1->WKIIVAL
        //Work1->WKVALMERC := Work1->WKIPIBASE
     ELSE
        IF lRateioCIF
           Work1->WKVALMERC := Work1->WKCIF + Work1->WKIIVAL +;//Work1->WKIPIBASE +;    //BHF - 18/11/08                           
                               DITrans((MDI_OUTR  * ((Work1->WKCIF-Work1->WKDESPCIF-Work1->WKVLACRES+Work1->WKVLDEDUC)/MDI_CIFPURO)) +;  // Bete - 25/07/04 - Inclusao de acrescimo e deducoes para apurar o CIF puro
                                       (MDI_OUTRP * (Work1->WKPESOL/MDI_PESO)) +; //EOS
                                       Work1->WKRDIFMID,2)
        ELSE
           Work1->WKVALMERC := Work1->WKCIF + Work1->WKIIVAL +;//Work1->WKIPIBASE +;	//BHF - 18/11/08
                               DITrans((MDI_OUTR  * (Work1->WKFOBR_ORI/MDI_FOBR_ORI)) +;
                                       (MDI_OUTRP * (Work1->WKPESOL/MDI_PESO)) +; //EOS
                                       Work1->WKRDIFMID,2)
        ENDIF
     ENDIF

/*     IF lCurrier
        Work1->WKIPIBASE := 0
     ENDIF */

  ELSE

     IF lRateioCIF

        Work1->WKFRETE:= DITrans(Work2->WKFRETE*IF(lRatFretePorFOB,Work1->WKRATEIO,IF(lRatFreQTDE,Work1->WKRATQTDE,Work1->WKRATPESO)),2)
        If ExistBlock("EICDI154") // BHF 27/02/09 - Rateio frete
           Execblock("EICDI154",.F.,.F.,"RATEIO_FRETE")
        EndIf
        IF AvRetInco(Work2->WKINCOTER,"CONTEM_FRETE")/* FDR - 27/12/10*/ .AND. !lMidia //Work2->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP" 
           Work1->WKSEGURO:= DITrans( ( (Work1->WKFOB_R-Work1->WKFRETE)  /;//WKFOBR_ORI
                                        (Work2->WKFOB_R-Work2->WKFRETE) )*;//WKFOBR_ORI
                                         Work2->WKSEGURO ,2)
        ELSE
           Work1->WKSEGURO:= DITrans( Work1->WKRATEIO * Work2->WKSEGURO ,2)
        ENDIF
        IF AvRetInco(Work1->WKINCOTER,"CONTEM_FRETE")/*FDR - 27/12/10*/  //Work1->WKINCOTER $ "CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP"
           Work1->WKFRETE:=0
           lAcerta:=.F.
        ENDIF
        Work1->WKCIF    := DITrans(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO,2)
        Work1->WKVALMERC:= DITrans((MDI_OUTR  * (Work1->WKCIF/MDI_CIFPURO )) + ;
                                   (MDI_OUTRP * (Work1->WKPESOL/MDI_PESO)) + ; //EOS
                                   Work1->WKRDIFMID,2)

     ELSE
        Work1->WKVALMERC:= DITrans((MDI_OUTR *(Work1->WKFOBR_ORI/MDI_FOBR_ORI))+;
                                   (MDI_OUTRP*(Work1->WKPESOL   /MDI_PESO    ))+;//EOS
                                   Work1->WKRDIFMID,2)
     ENDIF
     
  ENDIF

//IF nTipoNF # NFE_PRIMEIRA
  IF lOut_Desp    // Bete 24/11 - Trevo
     IF lRateioCIF
        Work1->WKOUT_DESP:= DITrans( (MDI_OUTR  * (Work1->WKCIF-Work1->WKDESPCIF-Work1->WKVLACRES+Work1->WKVLDEDUC)/MDI_CIFPURO) +;  // Bete - 25/07/04 - Inclusao de acrescimo e deducoes para apurar o CIF puro
                                     (MDI_OUTRP * Work1->WKPESOL/MDI_PESO)+; //EOS
                                      Work1->WKRDIFMID ,2)
        Work1->WKOUT_D_US:= DITrans( (MDI_OU_US * (Work1->WKCIF-Work1->WKDESPCIF-Work1->WKVLACRES+Work1->WKVLDEDUC)/MDI_CIFPURO) +; // Bete - 25/07/04 - Inclusao de acrescimo e deducoes para apurar o CIF puro
                                     (MDI_OU_USP* Work1->WKPESOL/MDI_PESO)+;//EOS
                                      Work1->WKUDIFMID ,2)
//        Work2->WKOUTRDESP+= Work1->WKOUT_DESP
//        Work2->WKOUTRD_US+= Work1->WKOUT_D_US
        nSumDespI+= Work1->WKOUT_DESP
     ELSE
        Work1->WKOUT_DESP:= DITrans( (MDI_OUTR  * Work1->WKFOBR_ORI/MDI_FOBR_ORI)+;
                                     (MDI_OUTRP * Work1->WKPESOL   /MDI_PESO    )+;//EOS
                                      Work1->WKRDIFMID ,2)
        Work1->WKOUT_D_US:= DITrans( (MDI_OU_US * Work1->WKFOBR_ORI/MDI_FOBR_ORI)+;
                                     (MDI_OU_USP* Work1->WKPESOL  /MDI_PESO )+;//AWR
                                      Work1->WKUDIFMID ,2)
     ENDIF
  ENDIF


   If lNewMidia .AND. lICMSMidiaDupl
       aOrdSW3Soft := SaveOrd({"SW3"})
       SW3->(DbSetOrder(1))
       If SW3->(DbSeek(xFilial("SW3")+Work1->WKPO_NUM+Work1->WK_CC+Work1->WKSI_NUM+Work1->WKCOD_I)) 
          If SW3->W3_SOFTWAR == "2"
             Work1->WKBASEICMS:= DITrans(Work1->WKBASEICMS * 2 ,2)
             Work1->WKVL_ICM  := DITrans(Work1->WKBASEICMS*Work1->WKICMS_A/100,2)
          Endif
       Endif   
       RestOrd(aOrdSW3Soft,.T.)
   Endif


////IF nTipoNF = NFE_COMPLEMEN .AND. lICMS_NFC
  IF lICMSCompl .AND. lICMS_NFC     // Bete 24/11 - Trevo
     
     If SWZ->(DbSeek(cFilSWZ+Work1->WK_OPERACA))
        // EOB 16/02/09                                   
		IF lICMS_Dif .AND. ASCAN( aICMS_Dif, {|x| x[1] == Work1->WK_OPERACA} ) == 0
        //                Operação           Suspensao        % diferimento    % Credito presumido                % Limite Cred.   % pg desembaraco   Aliq. do ICMS    Aliq. do ICMS S/ PIS
           AADD( aICMS_Dif, {Work1->WK_OPERACA, SWZ->WZ_ICMSUSP, SWZ->WZ_ICMSDIF, IF( lICMS_Dif2, SWZ->WZ_PCREPRE, 0), SWZ->WZ_ICMS_CP, SWZ->WZ_ICMS_PD, SWZ->WZ_AL_ICMS, SWZ->WZ_ICMS_PC     } )
        ENDIF   
     Endif
     
     Work1->WKICMS_A  := Work2->WKICMS_A
     nBaseICMS        := DITRANS( (nSomaICMS_NCM * Work1->WKRATEIO) +;
                                  (nPSomaICMS_NCM* Work1->WKRATPESO),2)//AWR
	 Work1->WKDESPICM := nBaseICMS                                  
     Work1->WKBASEICMS:= DI154CalcICMS(nBaseICMS , Work1->WKICMS_RED ,Work1->(IF(WKICMS_A!=0,WKICMS_A,WKICMSPC)) , Work2->WKRED_CTE,,,,,,,,,Work1->WK_OPERACA)//ASR - 10/10/2005 - SE WKICMS_A == 0 USAR WKICMSPC
     Work1->WKVL_ICM := DITrans(Work1->WKBASEICMS*(Work1->WKICMS_A/100),2)
  
     If lICMS_Dif
        DI154Diferido(.F.)
     EndIf
  
  ENDIF

  IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"WHILE_WORK1_RATEIO"),)// AWR - MIDIA - 7/5/4

  Work1->WKPRUNI:= Work1->WKVALMERC / Work1->WKQTDE

//IF nTipoNF # NFE_COMPLEMEN
  IF lApuraCIF
     nFob    += Work1->WKFOB_R
     nFrete  += Work1->WKFRETE
     nSeguro += Work1->WKSEGURO
     nCIF    += Work1->WKCIF
     nAcres  += Work1->WKVLACRES
     nDeduc  += Work1->WKVLDEDUC
  ENDIF
  IF lImpostos   // Bete 24/11 - Trevo
     nII     += Work1->WKIIVAL
     nIPI    += Work1->WKIPIVAL
     nIPIBase+= Work1->WKIPIBASE 
  ENDIF
//IF nTipoNF # NFE_PRIMEIRA
  IF lOut_Desp   // Bete 24/11 - Trevo
     nDesp   += Work1->WKOUT_DESP
     nDesp_US+= Work1->WKOUT_D_US
  ENDIF

//IF lRateioCIF .AND.(nTipoNF = NFE_UNICA .OR. nTipoNF = CUSTO_REAL)   Bete 24/11 - Trevo
//   nValMerc+=Work1->WKIPIBASE 
//ELSE
     nValMerc+=Work1->WKVALMERC
//ENDIF

  nAuxSomaCIF += Work1->WKDESPCIF
  nAuxSomaICMS+= Work1->WKDESPICM
  nAuxAcrescimo  += Work1->WKVLACRES
//nICMS       += Work1->WKVL_ICM
     
//IF nTipoNF = NFE_COMPLEMEN
  IF !lApuraCIF .And. !lFilha    // Bete 24/11 - Trevo
     Work1->WKFOB_R := 0 
     IF lRateioCIF
        Work1->WKFOB   := 0 
        Work1->WKFRETE := 0 
        Work1->WKSEGURO:= 0 
        Work1->WKCIF   := 0 
     ENDIF
  ENDIF

  IF lMV_PIS_EIC .AND. nTipoNF # 2
     Work2->WKBASPIS  += Work1->WKBASPIS
     Work2->WKVLRPIS  += Work1->WKVLRPIS
     Work2->WKBASCOF  += Work1->WKBASCOF
     Work2->WKVLRCOF  += Work1->WKVLRCOF
     
     If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
        Work2->WKVLCOFM += Work1->WKVLCOFM
     EndIf
     If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
        Work2->WKVLPISM += Work1->WKVLPISM
     EndIf     

  ENDIF
  Work2->WKIPI += Work1->WKIPIVAL    // Bete - 10/09/04
  Work2->WKICMS+= Work1->WKVL_ICM
  
  /*ISS - 17/09/10 - Calculo das colunas base do ICMS, IPI e II, como estas colunas serão apresentadas 
                     na hora da inclusão da nota o seus valores são relacionados a base da adição */
  Work2->WKBASEICMS   += Work1->WKBASEICMS
  Work2->WKBASEIPI    += Work1->WKIPIBASE
  //Work2->WKBASEII     += Work1->WKIPIBASE - Work1->WKIIVAL
  
  IF !lAlteracao
     nNBM_IPI  += Work1->WKIPIVAL
     nNBM_ICMS += Work1->WKVL_ICM
     nNBM_PIS  += Work1->WKVLRPIS
     nNBM_COF  += Work1->WKVLRCOF
  ENDIF

  //SVG - 09/06/2009 -
  IF Work1->WKSEMCOBER .AND. !EMPTY(Work1->WKFOBRCOB)
      Work1->WKVALMERC -= Work1->WKFOB_R
      Work1->WKCIF -= Work1->WKFOB_R
      Work1->WKFOB_R := 0  
   ENDIF
  /*
  IF Work1->WKSEMCOBER .AND. !EMPTY(Work1->WKFOBRCOB)
      Work1->WKFOB_R := 0  
  ENDIF
  */
  //SVG
  
  IF(ExistBlock("EICDI154"),ExecBlock("EICDI154",.F.,.F.,"WHILE_SOMA_ACERTO"),)// AWR - MIDIA - 7/5/4
  Work1->(DBSKIP())

ENDDO

IF !lAcerta
   Work2->WKFRETE:=nFrete
//ELSE
   //NCF - 10/07/2010 - O Rateio do CIF deve ser efetuado quando incoterm não contêm frete
  // Work2->WKCIF  :=nCIF 
ENDIF

Work1->(DBGOTO(nRec)) //Posiciona no Item com maior CIF da Adicao

//IF nTipoNF # NFE_COMPLEMEN
IF lApuraCif    // Bete 24/11 - Trevo
   IF nFob   # Work2->WKFOB_R
      Work1->WKFOB_R   += Work2->WKFOB_R-DITrans(nFob,2)
   ENDIF
   IF nSeguro # Work2->WKSEGURO
      Work1->WKSEGURO += Work2->WKSEGURO-DITrans(nSeguro,2)
   ENDIF
   IF nAcres # Work2->WKVLACRES  // Bete - 25/07/04 - Acerto no valor do acrescimo
      Work1->WKVLACRES += Work2->WKVLACRES-DITrans(nAcres,2)
   ENDIF
   IF nDeduc # Work2->WKVLDEDUC  // Bete - 25/07/04 - Acerto no valor da deducao
      Work1->WKVLDEDUC += Work2->WKVLDEDUC-DITrans(nDeduc,2)
   ENDIF

   lAcertouCIF:=.F.
   IF (Work2->WKCIF-(nSomaCIF_NCM+nPSomaCIF_NCM)-Work2->WKVLACRES+Work2->WKVLDEDUC) # Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO  // Bete - 25/07/04 - Inclusao de acrescimo e deducao no acerto do CIF
      If lDespAcrescimo 
         Work1->WKCIF -= DITrans((Work2->WKCIF-Work2->WKVLACRES+Work2->WKVLDEDUC)-(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO),2)
      Else
         Work1->WKCIF -= DITrans((Work2->WKCIF-(nSomaCIF_NCM+nPSomaCIF_NCM)-Work2->WKVLACRES+Work2->WKVLDEDUC)-(Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO),2)  // Bete - 25/07/04 - Inclusao de acrescimo e deducao no acerto do CIF
      EndIf
      lAcertouCIF:=.T.
   ENDIF   

   IF lAcerta
      IF nFrete # Work2->WKFRETE
      // ISS - 26/04/10 - Adicionada o tratamento para o acerto da diferença entre o frete calculado e o frete correto da adição   
         Work1->(DBGOTO(nRecFret))
         Work1->WKFRETE  += DITrans(Work2->WKFRETE-nFrete,2)
         Work1->(DBGOTO(nRec))
     
      ENDIF
   ENDIF
   //NCF - 10/07/2010 - O Rateio do CIF deve ser efetuado quando incoterm não contêm frete
   IF nCIF-nAcres+nDeduc # Work2->WKCIF //.AND. !lAcertouCIF  // GFP - 13/06/2013
      Work1->WKCIF    += DITrans(Work2->WKCIF-nCIF,2)
   ENDIF

ENDIF
IF lImpostos
   IF nII # Work2->WKII
      Work1->WKIIVAL  += Work2->WKII-nII
   ENDIF
   // AWR - O II devido serve de base de calculo do IPI mesmo sendo o II: 3-Isento ou 5-Suspenso
   IF lAcertaIPIBase .AND. nIPIBase # (Work2->WKCIF+Work2->WKII) 
      Work1->WKIPIBASE  += (Work2->WKCIF+Work2->WKII) - nIPIBase
      Work2->WKBASEIPI  += (Work2->WKCIF+Work2->WKII) - nIPIBase
   ENDIF
//   IF nIPI # Work2->WKIPI .AND. !lPassouIPI
//      Work1->WKIPIVAL+=Work2->WKIPI - DITrans(nIPI,2)
//   ENDIF
ENDIF

//IF nTipoNF # NFE_PRIMEIRA
IF lOut_Desp   // Bete 24/11 - Trevo 
   IF nDesp # (Work2->WKOUTRDESP+Work2->WKRDIFMID)
      Work1->WKOUT_DESP += (Work2->WKOUTRDESP+Work2->WKRDIFMID)-DITrans(nDesp,2)
   ENDIF
   IF nDesp_US # Work2->WKOUTRD_US+Work2->WKUDIFMID
      Work1->WKOUT_D_US += (Work2->WKOUTRD_US+Work2->WKUDIFMID)-DITrans(nDesp_US,2)
   ENDIF
ENDIF

//IF nICMS # Work2->WKICMS .AND. !lPassouICMS .AND. !lTemPauta
//   Work1->WKVL_ICM+=Work2->WKICMS - DITrans(nICMS,2)
//ENDIF

//IF nTipoNF # NFE_COMPLEMEN
IF lApuraCIF    // Bete 24/11 - Trevo
// IF nTipoNF == NFE_PRIMEIRA
   IF nTipoNF # CUSTO_REAL    // Bete 06/12 
      IF lAcertaIPIBase .AND. nValMerc # (Work2->WKCIF + Work2->WKII)
         Work1->WKVALMERC+=(Work2->WKCIF + Work2->WKII) - nValMerc
      ENDIF
   ELSE
//    IF !lRateioCIF    Bete 24/11 - Trevo
         IF lAcertaIPIBase .AND. nValMerc # (Work2->WKCIF+Work2->WKII+Work2->WKOUTRDESP+Work2->WKRDIFMID)
            Work1->WKVALMERC+=(Work2->WKCIF+Work2->WKII+Work2->WKOUTRDESP+Work2->WKRDIFMID) - DITrans(nValMerc,2)
         ENDIF
//    ELSE     Bete 24/11 - Trevo
//       IF nValMerc # (Work2->WKCIF+Work2->WKII)
//          Work1->WKVALMERC+=(Work2->WKCIF+Work2->WKII) - DITrans(nValMerc,2)
//       ENDIF          
         IF lRateioCIF
            nRecNow:=Work2->(RECNO())
            Work2->(DBSKIP())
            IF Work2->(EOF())
               IF nSumDespI # MDI_OUTR + MDI_OUTRP + (nFobItemMidia-M_FOB_MID)
                  Work1->WKVALMERC+=  (MDI_OUTR + MDI_OUTRP + (nFobItemMidia-M_FOB_MID)) - nSumDespI 
               ENDIF
            ENDIF
            Work2->(DBGOTO(nRecNow))          
         ENDIF
//    ENDIF
   ENDIF
                                       //NCF - 19/07/2010 - Verificar o rateio da taxa Siscomex
   If nAuxSomaICMS # Work2->WKSOMAICM .And. !lRatSIdifDsp
      Work1->(DBGOTO(nRecDICMS))
      Work1->WKDESPICM+= Work2->WKSOMAICM-nAuxSomaICMS
	  Work1->(DBGOTO(nRec))
   Endif

   If nAuxSomaCIF # Work2->WKSOMACIF
      Work1->(DBGOTO(nRecDcif))
	  Work1->WKDESPCIF+= Work2->WKSOMACIF-nAuxSomaCIF
	  Work1->(DBGOTO(nRec))
   Endif 
   
   If nAuxAcrescimo # Work2->WKVLACRES
      Work1->(DBGOTO(nRecDcif))
	  Work1->WKVLACRES+= Work2->WKVLACRES-nAuxAcrescimo
	  Work1->(DBGOTO(nRec))
   Endif

ELSEIF nValMerc # (Work2->WKOUTRDESP+Work2->WKRDIFMID)
   Work1->WKVALMERC+=(Work2->WKOUTRDESP+Work2->WKRDIFMID) - DITrans(nValMerc,2)
ENDIF

IF !EMPTY(Work1->WKVALMERC)
   Work1->WKPRUNI:=Work1->WKVALMERC/Work1->WKQTDE
ENDIF

Work1->(DBSETORDER(1))

RETURN .T.

*-----------------------------------*
FUNCTION DI154Altera(oMarkRe)
*-----------------------------------*
LOCAL nOpcA:=0, OldTela,nPesol:=Work2->WKPESOL, nII_A:=Work2->WKII_A,;
      nIPI_A:=Work2->WKIPI_A, nICMS_A:=Work2->WKICMS_A, nRecord:=0

LOCAL bEqual:={|| IF(Work2->WKPESOL==nPesol .AND. Work2->WKII_A   == nII_A .AND.;
                     Work2->WKIPI_A==nIPI_A .AND. Work2->WKICMS_A == nICMS_A .AND.;
                     M->W8_VLUPIS == Work2->WKVLUPIS .AND.;
                     M->W8_VLUCOF == Work2->WKVLUCOF .AND.;
                     M->W8_PERPIS == Work2->WKPERPIS .AND.;
                     M->W8_PERCOF == Work2->WKPERCOF .AND.;
                     If (Work2->WKREG_PC = "4",Work2->WKREDPIS == nPisARed .AND. Work2->WKREDCOF == nCofARed, .T.)  .AND.;
                     IF(lAcresDeduc, M->WN_VLACRES == Work2->WKVLACRES .AND.;
                                     M->WN_VLDEDUC == Work2->WKVLDEDUC, .T.),(MSGSTOP("Nao Houve Alteracoes!"),.T.),.F.)}

LOCAL cConfirma:=(STR0141),; //"Confirma a Altera‡Æo ?"
      cTit:=(STR0142) //"Confirmacao"
LOCAL nFatorFrete:= 0

LOCAL nPisARed 
LOCAL nCofARed 


PRIVATE lAlterou:=.f. , nCo1:=.8 , nCo2:=6 , nL1:=1.4 
Private lExecF3 := .F.

M->W8_VLUPIS  := Work2->WKVLUPIS
M->W8_VLUCOF  := Work2->WKVLUCOF
M->W8_PERPIS  := Work2->WKPERPIS
M->W8_PERCOF  := Work2->WKPERCOF


//TRP - 03/03/2010 - Adição das alíquotas reduzidas do Pis e Cofins na tela Altera NCM.
IF Work2->WKREG_PC = "4"
   nPisARed:= Work2->WKREDPIS 
   nCofARed:= Work2->WKREDCOF
ENDIF

IF lAcresDeduc  // Bete - 24/07/04 - Inclusao de Acrescimos e Deducoes na base de impostos
   cAcrescimo := STR0361  //STR0361 "Tecle F3"
   M->WN_VLACRES := Work2->WKVLACRES
   cDeducoes  := STR0361 //STR0361 "Tecle F3"
   M->WN_VLDEDUC := Work2->WKVLDEDUC  
ENDIF

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'ALTERA_IMPOSTOS'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ALTERA_IMPOSTOS"),)

If lAlterou
   RETURN .F.
ENDIF

//DEFINE MSDIALOG oDlgAlt TITLE (STR0143) FROM 9,4 TO 19,50 Of oMainWnd //"Alteracao de Impostos"

DEFINE MSDIALOG oDlgAlt TITLE (STR0143) FROM 9,4 TO 24,55 Of oMainWnd //"Alteracao de Impostos"

@nL1,nCo1 SAY STR0144 //"Peso"
@nL1,nCo2 MSGET nPesol  PICTURE PICTPesoT VALID nPesol > 0  SIZE 70,7
nL1+=1

IF cPaisLoc == "BRA" .AND. EMPTY(Work2->WKACMODAL)

   @nL1,nCo1 SAY STR0047 //"% I.I."
   @nL1,nCo2 MSGET nII_A   PICTURE PICT06_2 SIZE 70,7
   nL1+=1
   @nL1,nCo1 SAY STR0049 //"% I.P.I."
   @nL1,nCo2 MSGET nIPI_A  PICTURE PICT06_2 SIZE 70,7
   nL1+=1
   @nL1,nCo1 SAY STR0051 //"% ICMS"
   @nL1,nCo2 MSGET nICMS_A PICTURE PICTICMS SIZE 70,7
   nL1+=1
   IF lMV_PIS_EIC

      IF !EMPTY(M->W8_VLUPIS) .OR. !EMPTY(M->W8_VLUCOF)
         @nL1,nCo1 SAY AVSX3("W8_VLUPIS",5)
         @nL1,nCo2 MSGET M->W8_VLUPIS PICTURE AVSX3("W8_VLUPIS",6) VALID POSITIVO(M->W8_VLUPIS) SIZE 80,07
         nL1+=1
         @nL1,nCo1 SAY AVSX3("W8_VLUCOF",5)
         @nL1,nCo2 MSGET M->W8_VLUCOF PICTURE AVSX3("W8_VLUCOF",6) VALID POSITIVO(M->W8_VLUCOF) SIZE 80,07
      ELSE
         @nL1,nCo1 SAY AVSX3("W8_PERPIS",5)
         @nL1,nCo2 MSGET M->W8_PERPIS PICTURE AVSX3("W8_PERPIS",6) VALID POSITIVO(M->W8_PERPIS) SIZE 70,07
         nL1+=1
         @nL1,nCo1 SAY AVSX3("W8_PERCOF",5)
         @nL1,nCo2 MSGET M->W8_PERCOF PICTURE AVSX3("W8_PERCOF",6) VALID POSITIVO(M->W8_PERCOF) SIZE 70,07
         
         //TRP - 03/03/2010
         IF Work2->WKREG_PC = "4"
            nL1+=1
            @nL1,nCo1 SAY AVSX3("EIJ_REDPIS",5)
            @nL1,nCo2 MSGET nPisARed PICTURE AVSX3("EIJ_REDPIS",6) VALID POSITIVO(nPisARed) SIZE 70,07
            nL1+=1
            @nL1,nCo1 SAY AVSX3("EIJ_REDCOF",5)
            @nL1,nCo2 MSGET nCofARed PICTURE AVSX3("EIJ_REDCOF",6) VALID POSITIVO(nCofARed) SIZE 70,07
         ENDIF
      ENDIF
      nL1+=1
      oDlgAlt:nHeight+=50

   ENDIF
ENDIF

IF lAcresDeduc .AND. !lLerNota// Bete - 24/07/04 - Inclusao de Acrescimos e Deducoes na base de impostos
   cTitAcres := AVSX3("WN_VLACRES",5)
   @nL1,nCo1 SAY cTitAcres
   @nL1,nCo2 MSGET cAcrescimo PICTURE "@!" F3 "EIU" 
   nL1+=1
   @nL1,nCo1 SAY cTitAcres
   @nL1,nCo2 MSGET M->WN_VLACRES PICTURE AVSX3("WN_VLACRES",6) WHEN .F. SIZE 70,07
   nL1+=1  
   cTitDeduc := AVSX3("WN_VLDEDUC",5)
   @nL1,nCo1 SAY cTitDeduc
   @nL1,nCo2 MSGET cDeducoes PICTURE "@!" F3 "EIU" 
   nL1+=1                 
   @nL1,nCo1 SAY cTitDeduc
   @nL1,nCo2 MSGET M->WN_VLDEDUC PICTURE AVSX3("WN_VLDEDUC",6) WHEN .F. SIZE 70,07
   oDlgAlt:nHeight+=100
ENDIF


IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'TELA_IMPOSTOS'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'TELA_IMPOSTOS'),)

ACTIVATE MSDIALOG oDlgAlt ON INIT EnchoiceBar(oDlgAlt,;
{|| If(Eval(bEqual),nOpcA:=0,;
       If(nPesol > 0 .And. MsgYesNo(cConfirma,cTit),(nOpcA:=1,oDlgAlt:End()),))},;
{|| nOpcA:=0, oDlgAlt:End()}) CENTERED

If nOpcA = 0
   Return
Endif   

lAlterouAliquotas:=.T.

MDI_PESO-=Work2->WKPESOL
MDI_PESO+=nPesol
nFatorFrete:= nPesol / Work2->WKPESOL
Work2->WKPESOL   := nPesol
Work2->WKPESOSMID:= 0
Work2->WKII_A    := nII_A
Work2->WKIPI_A   := nIPI_A
Work2->WKICMS_A  := nICMS_A
IF lMV_PIS_EIC .AND. nTipoNF # 2
   Work2->WKVLUPIS := M->W8_VLUPIS
   Work2->WKVLUCOF := M->W8_VLUCOF
   Work2->WKPERPIS := M->W8_PERPIS
   Work2->WKPERCOF := M->W8_PERCOF
   //TRP - 03/03/2010
   IF Work2->WKREG_PC = "4"
      Work2->WKREDPIS := nPisARed
      Work2->WKREDCOF := nCofARed
   ENDIF
ENDIF

IF lAcresDeduc  // Bete - 24/07/04 - Inclusao de Acrescimos e Deducoes na base de impostos
   /*nNBM_Acres -= Work2->WKVLACRES
   nNBM_Deduc -= Work2->WKVLDEDUC*/
   Work2->WKVLACRES := M->WN_VLACRES
   Work2->WKVLDEDUC := M->WN_VLDEDUC
   nNBM_Acres += Work2->WKVLACRES
   nNBM_Deduc += Work2->WKVLDEDUC
ENDIF

nRecord:= Work2->(RECNO())

//Work1->(DBSETORDER(1))  Bete - controle por adição
//Work1->(DBSEEK(EVAL(bSeekWk1)))  Bete - controle por adição
//DO WHILE !Work1->(EOF()) .AND. EVAL(bWhileWk)  Bete - controle por adição
Work1->(DBSETORDER(6))
Work1->(DBSEEK(Work2->WKADICAO))
DO WHILE !Work1->(EOF()) .AND. Work1->WKADICAO == Work2->WKADICAO
  Work1->WKPESOL := Work1->WKPESOL * nFatorFrete
  IF lExiste_Midia .AND. lHaumaMidia
     IF SB1->(DbSeek(xFilial()+Work1->WKCOD_I)) .AND. !(SB1->B1_MIDIA $ cSim)
        Work2->WKPESOSMID+=Work1->WKPESOL
     ENDIF
  ENDIF
  Work1->(DBSKIP())

ENDDO

Work2->(DBGOTOP())

Processa({|| DI154Recalc() },STR0147) //"Pesquisando NBMs..."

Work2->(DBGOTO(nRecord))

IF VALTYPE(oMarkRe) == "O"
   oMarkRe:oBrowse:Refresh()
ENDIF    

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'ALTEROU_IMPOSTOS'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'ALTEROU_IMPOSTOS'),)

RETURN .T.
*----------------------------------------------------------------------------
FUNCTION DI154Recalc()
*----------------------------------------------------------------------------
Local nCIFMaior := 0
Local nRecno    := 0
Local nItensCIF := 0
Local nItensICM := 0
Local nWork1Rec := 0
Local nWork1Rec2 := 0
Local lICMS := .F.
Local lCIF  := .F.                

ProcRegua(Work2->(LASTREC())*2)
Work2->(DBGOTOP())
nDespCIF_NCM := 0
nDespICMS_NCM:= 0
lAcerta:=.T.    
nFOBRatSeg:= MDI_FOB_R
MDI_CIF    := DITrans(MDI_FOB_R + MDI_FRETE + MDI_SEGURO + nSomaNoCIF + nPSomaNoCIF,2)
MDI_CIFPURO:= DITrans(MDI_FOB_R + MDI_FRETE + MDI_SEGURO,2)
DO WHILE !Work2->(EOF())
   IncProc(STR0148) //"Recalculando Impostos"
   DI154Impostos(.F.,"1")
   Work2->(DBSKIP())
ENDDO

nSumDespI:= 0

Work2->(DBGOTOP())
DO WHILE !Work2->(EOF())
   IncProc(STR0148) //"Recalculando Impostos"
   DI154Impostos(.T.,"2")     
   //JVR - 20/10/2009 - Posiciona no registro com maior valor de CIF.
   IF Work2->WKCIF > nCIFMaior
      nCIFMaior:=Work2->WKCIF
      nRecno   :=Work2->(RECNO())
   ENDIF  
   nDespCIF_NCM += Work2->WKSOMACIF
   nDespICMS_NCM+= Work2->WKSOMAICM
   Work2->(DBSKIP())
ENDDO

Work2->(DBGOTO(nRecno))//JVR - 20/10/2009

IF DiTrans(nSomaNoCIF + nPSomaNoCIF,2) # DiTrans(nDespCIF_NCM,2)
   Work2->WKSOMACIF += DITrans(nSomaNoCIF + nPSomaNoCIF,2)-DITrans(nDespCIF_NCM,2)
   lCIF := .T.
ENDIF
IF DiTrans(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc,2) # DiTrans(nDespICMS_NCM,2)
   Work2->WKSOMAICM += DITrans(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc,2)-DITrans(nDespICMS_NCM,2)
   lICMS := .T.
ENDIF       

//JVR - 20/10/2009
//Acerta valores na Work1 - Itens, caso tenha sido acertado na Work2 - Grupo.
If lCIF .or. lICMS
   nDespCIFMaior := 0
   nDespICMMaior := 0
   Work1->(DBSETORDER(6))
   IF Work1->(DbSeek(Work2->WKADICAO))
      While Work1->(!EOF()) .and.;
            Work1->WKADICAO == Work2->WKADICAO
         
         If Work1->WKDESPCIF > nDespCIFMaior
            nDespCIFMaior := Work1->WKDESPCIF
//            nWork1Rec := RecNo()
            nWork1Rec := Work1->(RecNo())//ACB - 21/02/2011 - Tratamento para que a variavel pegue o exato
                                                              //registro posicionado e não o toatal todos registros
         EndIf
		 
         If Work1->WKDESPICM > nDespICMMaior
            nDespICMMaior := Work1->WKDESPICM
//            nWork1Rec2 := RecNo()
            nWork1Rec2 := Work1->(RecNo())//ACB - 21/02/2011 - Tratamento para que a variavel pegue o exato
                                                              //registro posicionado e não o toatal todos registros
         EndIf		 
		 
         nItensCIF += Work1->WKDESPCIF
         nItensICM += Work1->WKDESPICM
         Work1->(DbSkip())
      EndDo
   EndIf           
   
   Work1->(DbGoTo(nWork1Rec))
   If lCIF
      If DiTrans(nItensCIF,2) # DITrans(Work2->WKSOMACIF,2)
         Work1->WKDESPCIF += (DiTrans(Work2->WKSOMACIF,2) - DiTrans(nItensCIF,2))
      EndIf
   EndIf  
   
   Work1->(DbGoTo(nWork1Rec2))
   If lICMS
      If DiTrans(nItensICM,2) # DITrans(Work2->WKSOMAICM,2)
         Work1->WKDESPICM += (DITrans(Work2->WKSOMAICM,2) - DiTrans(nItensICM,2))
      EndIf
   EndIf
EndIf

RETURN .T.
*----------------------------------------------------------------------------
FUNCTION DI154TestDI()
*----------------------------------------------------------------------------
LOCAL cNew_II:=cNew_IPI:=cNew_ICMS:=0 
LOCAL bDifere:={ |vDI,vNBM,tit| DI154MsgDif(.F.,vDI,vNBM,tit) }
lDifere:=.F.
IF !EMPTY(MDI_II)
   lComDiferenca:=EVAL(bDifere,MDI_II,nNBM_II,"I.I.")
ENDIF

IF !EMPTY(MDI_IPI)
   lDifere:=EVAL(bDifere,MDI_IPI,nNBM_IPI,"I.P.I.")
   If(EMPTY(lComDiferenca),lComDiferenca:=.F.,)
   If(!lComDiferenca,lComDiferenca:=lDifere,)
ENDIF

IF !EMPTY(MDI_ICMS)
   EVAL(bDifere,MDI_ICMS,nNBM_ICMS,"I.C.M.S.")
   If(EMPTY(lComDiferenca),lComDiferenca:=.F.,)
   If(!lComDiferenca,lComDiferenca:=lDifere,)
ENDIF
      
IF lMV_PIS_EIC .AND. nTipoNF # 2
   IF !EMPTY(MDI_PIS)
      EVAL(bDifere,MDI_PIS,nNBM_PIS,"PIS")
      If(EMPTY(lComDiferenca),lComDiferenca:=.F.,)
      If(!lComDiferenca,lComDiferenca:=lDifere,)
   ENDIF
   IF !EMPTY(MDI_COF)
      EVAL(bDifere,MDI_COF,nNBM_COF,"COFINS")
      If(EMPTY(lComDiferenca),lComDiferenca:=.F.,)
      If(!lComDiferenca,lComDiferenca:=lDifere,)
   ENDIF
ENDIF

cNew_II  := nNBM_II
cNew_IPI := nNBM_IPI
cNew_ICMS:= nNBM_ICMS
cNew_PIS := nNBM_PIS
cNew_Cof := nNBM_COF


DI154Tela(cNew_II,cNew_IPI,cNew_ICMS,cNEW_PIS,cNEW_COF)

RETURN
*----------------------------------------------------------------------------
FUNCTION DI154Tela(TDI_II,TDI_IPI,TDI_ICMS,TDI_PIS,TDI_COF)
*----------------------------------------------------------------------------

nFob_R   := IF(!lApuraCIF,0,MDI_FOB_R)   //nTipoNF==NFE_COMPLEMEN    Bete 24/11 - Trevo
n_Frete  := IF(!lApuraCIF,0,nFreteNew)   //MDI_FRETE)   //nTipoNF==NFE_COMPLEMEN    Bete 24/11 - Trevo
n_Seguro := IF(!lApuraCIF,0,MDI_SEGURO)  //nTipoNF==NFE_COMPLEMEN    Bete 24/11 - Trevo
n_CIF    := IF(!lApuraCIF,0,MDI_CIF)     //nTipoNF==NFE_COMPLEMEN    Bete 24/11 - Trevo
n_IPI    := IF(!lImpostos,0,TDI_IPI)     //nTipoNF==NFE_COMPLEMEN    Bete 24/11 - Trevo
n_ICMS   := IF(lImpostos .OR. lICMS_NFC,TDI_ICMS,0)     //nTipoNF# NFE_COMPLEMEN   Bete 24/11 - Trevo  
n_II     := IF(!lImpostos,0,TDI_II)      //nTipoNF==NFE_COMPLEMEN   Bete 24/11 - Trevo
n_Pis    := IF(!lImpostos,0,TDI_PIS)
n_Cofins := IF(!lImpostos,0,TDI_COF)

IF lAcresDeduc
   n_CIF += nNBM_Acres
   n_CIF -= nNBM_Deduc
ENDIF  
                                                                       
n_TotNFE := n_CIF+n_II+n_IPI
n_ValM   := n_CIF+n_II                                                      //NCF - 17/08/2011
n_VlTota := DITRANS((n_TotNFE+nNBM_PIS+nNBM_COF+n_ICMS+MDI_OUTR+MDI_OUTRP + MDI_DespICM),2) 

// NCF - 17/08/2011 - Verificação para composição do total Geral da Nota fiscal
IF lImpostos                   
   IF nTipoNF <> CUSTO_REAL
      IF !lTemPrimeira
         n_VlTota += DITRANS(nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)
      ENDIF  
   ELSE                                                          			
      IF !lTemCusto
         IF !GetMv("MV_LERNOTA",,.F.)
            n_VlTota += DITRANS( nSomaBaseICMS + nPSomaBaseICMS + nTxSisc ,2)                 
         ENDIF
      ENDIF    
   ENDIF
ENDIF                                   
			
If oSayTotGe # NIL 
   oSayTotGe:Refresh()
Endif

Return

*---------------------------------------------*
Function DI154GerNF(lGerouNFE,bDDIFor,bDDIWhi)
*---------------------------------------------*
LOCAL nRec1:=Work1->(RecNo())
LOCAL nRec2:=Work2->(RecNo())
LOCAL nRec3:=Work3->(RecNo())
LOCAL nOldArea:=Select(), nQtdeNFs:=0, nVlTotNFs:=0, nDespTotNFCs:=0, nLinha := 0
LOCAL cTec,cExNCM,cExNBM,nFob,nDespUS,nFob_R,nCIF_Moe, aAntLido:={}
LOCAL cTpNrNfs := GetMv("MV_TPNRNFS",,"1")
LOCAL cItensP0 //DRL - 15/05/09
LOCAL lItensP0 := .F. //DRL - 15/05/09
LOCAL aChaves := {}
LOCAL i

PRIVATE cOperacao,cACModal,cCFO, lSair:=.F.
PRIVATE cNumero, cSerie, nItem:= ntx_Ufesp := 0
PRIVATE nQtde    := nPesoB   := 0 ,  nEspecie := nMarca  := nNumero := SPACE(12) ,nTrans := SPACE(6)
PRIVATE cChvQuebra:= ""
PRIVATE nWK1Ordem :=5 //Variavel usada para trocar a ordem da Work no Rdmake
PRIVATE nWK2Ordem :=1 //Variavel usada para trocar a ordem da Work no Rdmake
PRIVATE cForn :="", cForLoj := ""  // GFP - 03/07/2013
PRIVATE cFilSF1:=xFILIAL("SF1")
PRIVATE lMudouNum := .F.
PRIVATE lNFEok := .T. //utilizada no ponto de entrada VALNFE
PRIVATE lValPesLiq := .T. //DRL - 15/05/09
PRIVATE lDespNFC_Z := .F.
PRIVATE lDespNFC_N := .F. //NCF - 06/10/2011
Private cNumComp, cSerieComp //DFS - 14/02/11 - Variáveis de número e série das notas complementares 
Private nRecItNFC //NCF - 06/10/2011 
Private aRecItNFCz := {}
dDtNFE:=IF(EMPTY(dDtNFE),dDataBase,dDtNFE)

cNumComp   := ""
cSerieComp := ""

//DFS - Chamado: 082672 - Alteração de validação para que não seja permitido mostrar a mesma numeração para duas Notas Fiscais  
//TDF - 17/11/2010 Revisão dos conceitos de utilização de formulário própio.
If lMV_EASYSIM .AND. nTipoNF # CUSTO_REAL .AND. !lNFAutomatica
   If MSGYESNO(STR0287,STR0032)//"Utiliza Formulario Proprio?"  
      cFormPro      := "S"
      lNFAutomatica := .T. 
   Else
      cFormPro      := "N"
      lNFAutomatica := .F.
   Endif
Endif

// AST - 06/03/09 - Ponto de entrada para qualquer validação na geração da NF
If ExistBlock("EICDI154")
   Execblock("EICDI154",.F.,.F.,'VALNFE') 
   If !lNFEok
      lGerouNFE := .F.
      return   
   EndIf
EndIf

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'DIFERE'),)  // RS 20/08/07

If lComDiferenca .AND. ;
	( (cObsII   # NIL .AND. !EMPTY(cObsII  )) .OR.;
	  (cObsIPI  # NIL .AND. !EMPTY(cObsIPI )) .OR.;
     (cObsPIS  # NIL .AND. !EMPTY(cObsPIS )) .OR.;
     (cObsCOF  # NIL .AND. !EMPTY(cObsCOF )) .OR.;
     (cObsICMS # NIL .AND. !EMPTY(cObsICMS)) )
   Help("",1,"AVG0000805")//"Atencao: Processo com diferencas !"###"Atenção"
Endif

SW7->(DBSEEK(xFilial("SW7")+SW6->W6_HAWB))
SA2->(DBSEEK(xFilial("SA2")+SW7->W7_FORN+EICRetLoja("SW7", "W7_FORLOJ")))

IF Existblock("EICPDI01")
   IF ! ExecBlock("EICPDI01",.F.,.F.,"1")
      DbSelectArea(nOldArea)
      Return .T.
   ENDIF
ENDIF

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'IniciaVariavel'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'IniciaVariavel'),)

IF lSair
   DbSelectArea(nOldArea)
   Return .T.
ENDIF

If lValPesLiq
   Do While !Work1->(EOF())
      If Empty(Work1->WKPESOL)
         cItensP0 := Alltrim(Work1->WKCOD_I) + ", "
         lItensP0 := .T.
      EndIf
      Work1->(DbSkip())
   EndDo   
EndIf
If lItensP0
   If !MsgYesNo( STR0362+ Left(cItensP0, Len(cItensP0) - 2) +STR0363,STR0022) //STR0362  "O(s) Item(s) " //STR0363 " não possui o peso liquido informado. Deseja Continuar?"  //	STR0022 := "Atenção"
      lGerouNFE := .F.
      Return .F.
   EndIf
EndIf
//NCF - 11/11/2010 - Validação para não permitir geração da NFC com itens que possuam valor zerado
IF nTipoNF == NFE_COMPLEMEN
   Work1->(DbSetOrder(11)) //DFS - 14/02/11 - Ordem referente a documento e serie da nota primeira
   Work1->(DBGOTOP())
   nRecMaior  := nVlrMaior := 0 
   aRecItNFCz := {}
   WHILE Work1->(!EOF()) 
      IF Work1->WKOUT_DESP == 0 
         lDespNFC_Z := .T. 
         aAdd( aRecItNFCz,Work1->(Recno()) )
      ELSEIF Work1->WKOUT_DESP < 0 .And.( GETMV("MV_EASY",,"N") == "S" .Or. !GETMV("MV_EIC0009",,.F.) ) //NCF - 20/05/2011 - Permitir ou não despesas negativas na NF Complementar
         lDespNFC_N := .T.
      ENDIF
      Work1->(DbSkip())
   ENDDO
   IF lDespNFC_Z
      If MsgYesNo(STR0364+STR0365) //STR0364 "Nota Fiscal Complementar não pode ser gerada pois há item(ns) com despesa zerada(as)." //STR0365 "Acerte a(s) despesa(s) do processo para que o rateio para os itens não resulte em valor menor que 0,01" 
         //NCF - 06/10/2011 - Posicionar nas despesas menores para adicionar valor mínimo abatido da maior despesa
         For i := 1 To Len(aRecItNFCz)
            Work1->(dbGoto(aRecItNFCz[i])) 
            Work1->WKOUT_DESP := 0.01 
            Work1->WKVALMERC  := 0.01
            nRecItNFC := MaiorItNFC()     //NCF - 06/10/2011 - Buscar o item que possuir maior rateio
            Work1->(dbGoto(nRecItNFC))
            If Work1->WKOUT_DESP > 0.01
               Work1->WKOUT_DESP -= 0.01
            EndIf 
            If Work1->WKVALMERC > 0.01
               Work1->WKVALMERC  -= 0.01
            EndIf
         Next i
      Else
         lGerouNFE := .F.
         Return .F. 
      EndIf
   ENDIF
   IF lDespNFC_N
      MSGALERT(STR0417+STR0418+STR0419) 
      lGerouNFE := .F.
      Return .F.
   ENDIF
ENDIF

Work1->(DBGOTOP())

IF lNFAutomatica .AND. nTipoNF # CUSTO_REAL

   ProcRegua(Work1->(LASTREC()))

   Work2->(DBSETORDER(nWK2Ordem))//1
//   IF lExisteSEQ_ADI                     // EOB - nopado, pois a quebra da nota automática deve respeitar
//      Work1->(DBSETORDER(6))             // a ordem de Fornecedor + CFO + Ato + Operação (qdo parâmetro ativado)...
//   ELSE 
   IF nTipoNF <> NFE_COMPLEMEN
      Work1->(DBSETORDER(nWK1Ordem))//5
   EndIf   
//   ENDIF
   Work1->(DBGOTOP())
   nItem:=0
   cForn:=""
   cForLoj := ""  // GFP - 03/07/2013
   cCFO :=""     
   cACModal:=""
   cOperacao :=""
   IF ExistBlock("EICPDI01")
      IF !ExecBlock("EICPDI01",.F.,.F.,"6")
        RETURN .T.
      ENDIF
   ENDIF
   

   DO WHILE !Work1->(EOF())
   
   //DFS - 14/02/11 - Guardando os valores na Work
   //TDF - 16/05/12 - Limpa as variáveis usadas na função DI154Quebrou para cada registro
   /*cNumComp   := ""
   cSerieComp := ""*/
   
      //ACB - 03/03/2011 - Tratamento de verificação do tamanho de peso.
      If !ComparaPeso (,Work1->WKPESOL,"D1_PESO",.T.,)
         Return .F.
      EndIf

      IncProc(STR0150) //"Gerando Nota Fiscal"

      IF ExistBlock("EICPNF02")
         ExecBlock("EICPNF02",.F.,.F.)
      ENDIF

      IF DI154Quebrou()
         cNumero:=WORK1->WK_NFE
         cSerie :=WORK1->WK_SE_NFE
         IF ExistBlock("EICPDI01")
            ExecBlock("EICPDI01",.F.,.F.,"5")
         ENDIF
         
         IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'QUEBRA_NF'),)
                 
         IF EMPTY(cNumero)
             
            //DFS - 082672 - Validação para que não seja permitido mostrar ao mesmo tempo tela para escolher 
            //a numeração da nota fiscal para dois usuários em simultaneo
            If cTpNrNfs <> "3"
               //BEGIN TRANSACTION
                  //If GetMv("MV_TPNRNFS",.T.)
                     //RecLock("SX6",.F.)
                  //EndIf
               
               //TDF - 28/02/11 - Alteração para que o botão "Cancelar" funcione corretamente
               DO WHILE .T.
                  IF !SX5NumNota(.F.,cTpNrNfs)
                     RETURN .F.
                  ELSE
                     EXIT
                  ENDIF
               ENDDO
                        
               cNumero := NxTSx5Nota(cSerie,.T.,cTpNrNfs)
            
               //ASR 17/02/2006 - INICIO - VALIDACAO DO NUMERO DA NOTA FISCAL - NUMERACAO AUTOMATICA
               nOrderSF1 := SF1->(IndexOrd())
               SF1->(DBSetOrder(1))        
               If GETMV("MV_NFEHAWB",,.T.)//ASR 22/02/2006
                  If SF1->(DBSeek(xFilial("SF1")+cNumero+cSerie))
                     Do While SF1->(!EOF()) .AND. SF1->F1_FILIAL == xFilial("SF1") .AND. SF1->F1_DOC == cNumero .AND. SF1->F1_SERIE == cSerie
                        If !EMPTY(SF1->F1_HAWB)
                           Do While SF1->(DBSeek(xFilial("SF1")+cNumero+cSerie))
                                cNumero := NxTSx5Nota(cSerie,.T.,cTpNrNfs)
                           EndDo
                           Exit
                        EndIf
                        SF1->(DBSKIP())
                     EndDo
                  EndIf                       
               Else//ASR 22/02/2006 - Inicio
                  If SF1->(DbSeek(xFilial("SF1")+cNumero+cSerie+Work1->WKFORN+Work1->WKLOJA))
                     Do While SF1->(DBSeek(xFilial("SF1")+cNumero+cSerie+Work1->WKFORN+Work1->WKLOJA))
                          cNumero := NxTSx5Nota(cSerie,.T.,cTpNrNfs)
                     EndDo
                  Endif
               EndIf//ASR 22/02/2006 - Fim
               SF1->(DBSetOrder(nOrderSF1))
               //ASR 17/02/2006 - FIM
                                          
                  //DFS - 082672 - Validação para que não seja permitido mostrar ao mesmo tempo tela para escolher 
                  //a numeração da nota fiscal para dois usuários em simultaneo
                 // If GetMv("MV_TPNRNFS",.T.) 
                 //    SX6->(MsUnLock())
                //  EndIf
               //END TRANSACTION

            Else //cTpNrNfs == "3"
	
               DEFINE MSDIALOG oDlg TITLE STR0366 FROM 0,0 TO 150,200 OF oMainWnd	PIXEL  //STR0366 "Série da Nota"

                  @ 10,15 TO 60,80 LABEL '' OF oDlg PIXEL
                  @ 15,19 SAY STR0367 OF oDlg PIXEL //STR0367 "Informe a Serie da Nota"
	              @ 25,19 MSGET cSerie F3 "01" VALID (!Empty(cSerie)) OF oDlg PIXEL	              
                  DEFINE SBUTTON FROM 48,35 TYPE 1 ACTION (IF(Empty(cSerie),.F.,.T.),nOpcA := 1,oDlg:End()) ENABLE OF oDlg PIXEL   
                  
               ACTIVATE MSDIALOG oDlg CENTERED
               
               //ER - 10/04/2008
               lMudouNum := .T.
               cNumero := Ma461NumNF(.T.,cSerie,cNumero)
            ENDIF
         ENDIF
              
         nItem:=0
         cForn    := Work1->WKFORN 
         If EICLoja()   
            cForLoj  := Work1->WKLOJA  // GFP - 03/07/2013
         EndIf
         cCFO     := Work1->WK_CFO
         cOperacao:= Work1->WK_OPERACA
         cACModal := Work1->WKACMODAL
      ENDIF
      nItem++

      //TDF- 22/12/2010 - VERIFICA SE JÁ ESTA PREENCHIDO ANTES DE GRAVAR A NUMERAÇÃO DA NOTA
      IF EMPTY(Work1->WK_NFE) 
         Work1->WK_NFE   :=cNumero
      ENDIF
      
      IF EMPTY(Work1->WK_SE_NFE)
         Work1->WK_SE_NFE:=cSerie
      ENDIF
      
      IF EMPTY(Work1->WK_DT_NFE)
         Work1->WK_DT_NFE:=dDtNFE
      ENDIF
      //*TDF*//


      IF Work3->(DBSEEK(Work1->(RECNO())))

         DO WHILE !Work3->(EOF()) .AND. Work1->(RECNO()) == Work3->WKRECNO

            //TRP - 14/02/12 - Alteração para que, aceite mais de uma numeração de nota fiscal no Recebimento de Importação.    
            //Só alterar o número da nota caso o mesmo não esteja preenchido para gravar corretamente o SWW
            IF EMPTY(Work3->WK_NF_COMP)
               Work3->WK_NF_COMP:=cNumero
            ENDIF
            IF EMPTY(Work3->WK_SE_NFC)
               Work3->WK_SE_NFC :=cSerie
            ENDIF
            IF EMPTY(Work3->WK_DT_NFC)
               Work3->WK_DT_NFC :=dDtNFE
            ENDIF
            
            Work3->(DBSKIP())

         ENDDO

      ENDIF

     Work1->(DBSKIP())

   ENDDO

ELSEIF !lNFAutomatica .AND. nTipoNF # CUSTO_REAL
   aNF1:={}
   aNF2:={}
   Work1->(DBSETORDER(2))
   Work1->(DBGOTOP())
   cForn := Work1->WKFORN
   DO WHILE !Work1->(EOF())
      IF EMPTY(Work1->WK_NFE)
         Help("",1,"AVG0000806")//"Existem Notas Fiscais nao informadas",0022)
         RETURN .F.
      ENDIF
      IF cPaisLoc = "BRA" .AND. ASCAN(aNF1,{|N| N[1]==Work1->WK_NFE+Work1->WK_SE_NFE .AND. N[2]==Work1->WKFORN} ) == 0
         AADD (aNF1,{ Work1->WK_NFE+Work1->WK_SE_NFE,Work1->WKFORN })
         IF ASCAN(aNF2,{|F| F[1]==aNF1[LEN(aNF1),1] }) == 0
            AADD (aNF2,{ aNF1[LEN(aNF1),1] })
         ELSE
            Help("",1,"AVG0000807")//"Existem Fornecedores com os mesmo numeros de N.F.'s.",0022)
            RETURN .F.
         ENDIF
      ENDIF
      If Work1->WKVALMERC <= 0  //ASK 21/11/2007 - Validação para item com valor zerado, casos como rateio por peso na Complementar
         MsgStop(STR0294 + Work1->WK_NFE + "." + chr(10) + chr(13) + ; //"Não foi possível gerar a Nota : " 
         STR0295 + Alltrim(Work1->WKCOD_I) + STR0296 , STR0022 )   //"Valor do Produto "  " Inválido!"
         Return .F.
      EndIf
      Work1->(DBSKIP())
   ENDDO
//** AAF 11/08/08 - Tratamento para validação da Nota Fiscal não automática.
      
   ProcRegua(Work1->(LASTREC()))

// Work2->(DBSETORDER(nWK2Ordem))//1
// Work1->(DBSETORDER(nWK1Ordem))//5 - AWR - 19/06/2009 a Ordem deve ser 2 já setada acima
   Work1->(DBGOTOP())
   cNFE      := ""
   cSerieNFE := ""
   nItem:=0
   cForn:=""
   cCFO :=""     
   cACModal:=""
   cOperacao :=""
   
   DO WHILE !Work1->(EOF())

      IncProc(STR0150) //"Gerando Nota Fiscal"
      nRecProx := 0
      
      IF Work1->(WK_NFE+WK_SE_NFE) <> cNFE+cSerieNFE
         
         cNFE      := Work1->WK_NFE
         cSerieNFE := Work1->WK_SE_NFE
         
         If cTpNrNfs == "1" .OR. cTpNrNfs == "2"
            //Não há função de validação da nota não automática na Microsiga para numeração SX5 ou SXE.
            cNumero := Work1->WK_NFE
         ElseIf cTpNrNfs == "3"
            //ER - 10/04/2008
            lMudouNum := .T.
            cNumero := Ma461NumNF(.T.,Work1->WK_SE_NFE,Work1->WK_NFE)
         ENDIF
         
      ENDIF
      
	  If Work1->WK_NFE <> cNumero
         Work1->(dbSkip())
         If Work1->(EoF())
            nRecProx := 0
         Else
    	    nRecProx := Work1->(RecNo())
         EndIf
         
	     Work1->(dbSkip(-1))
	     
	     Work1->WK_NFE := cNumero
	  EndIf
      
      If nRecProx > 0
         Work1->(dbGoTo(nRecProx))
      Else
         Work1->(DBSKIP())
      EndIf
   ENDDO
//**

ELSEIF nTipoNF = CUSTO_REAL

   ProcRegua(Work1->(LASTREC()))

   Work2->(DBSETORDER(nWK2Ordem))//1
   Work1->(DBSETORDER(nWK1Ordem))//5
   Work1->(DBGOTOP())
   nItem:=GetMV("MV_NRCUSTO")
   nItem++
   SetMV("MV_NRCUSTO",nItem)
   cNumero:=STRZERO(nItem,6,0)

   DO WHILE !Work1->(EOF())

      IncProc(STR0150) //"Gerando Nota Fiscal"

      IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'QUEBRA_CUSTO'),)
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'QUEBRA_CUSTO'),)

      Work1->WK_NFE   :=cNumero
      Work1->WK_DT_NFE:=dDtNFE

      IF Work3->(DBSEEK(Work1->(RECNO())))

         DO WHILE !Work3->(EOF()) .AND. Work1->(RECNO()) == Work3->WKRECNO

            Work3->WK_NF_COMP:=cNumero
            Work3->WK_SE_NFC :=Work1->WK_SE_NFE
            Work3->WK_DT_NFC :=dDtNFE

            Work3->(DBSKIP())

         ENDDO

      ENDIF

     Work1->(DBSKIP())

   ENDDO
ENDIF

ProcRegua(Work1->(LASTREC())+Work1->(LASTREC())+Work3->(LastRec()) )

nWK2Ordem :=1 //Variavel usada para trocar a ordem da Work no Rdmake
nWK1Ordem :=4 //Variavel usada para trocar a ordem da Work no Rdmake

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'IniciaVar2'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'IniciaVar2'),)

//AvStAction("212",.F.)//AWR - 04/02/2010 - Para versão M11 utilizar o ponto de entrada acima para customizar o Conta e Ordem.

Work2->(DBSETORDER(nWK2Ordem))
Work1->(DBSETORDER(nWK1Ordem))
Work1->(DBGOTOP())

cOperacao:=Work1->WK_OPERACA
cExNCM:=Work1->WKEX_NCM
cExNBM:=Work1->WKEX_NBM
cTec  :=Work1->WKTEC
nNFE  :=Work1->WK_NFE
nSerie:=Work1->WK_SE_NFE
dDtNFE:=Work1->WK_DT_NFE
nPesol:=nFob:=nFrete:=nSeguro:=nCIF:=nII:=nIPI:=nICMS:=nDespesa:=nDespUS:=nDespesaICM:=0
nFob_R:=nCIF_Moe:=nItem:=nBaseIPI:=nBaseICMS:=nValor:=nItem:=nContItem:=0
lGerouNFE :=.F.
cNotaGrupo:=Work1->WK_NFE+Work1->WK_SE_NFE
nNFEAux  :=""
nSerieAux:="" 
aCab  :={}//Para gravacao da Microsiga
aItens:={}//Para gravacao da Microsiga
lMSErroAuto := .F. 
lMSHelpAuto := .T. // para mostrar os erros na tela

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'IniciaVar3'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'IniciaVar3'),)

IF lMV_EASYSIM
   SC1->(DBSETORDER(1))
ENDIF

SB1->(DBSETORDER(1))
SB1->(DbSeek(xFilial("SB1")+GetMV("MV_PRODIMP")))

Begin Transaction

Begin SEQUENCE

DO WHILE If(nTipoNF # CUSTO_REAL, !Work1->(EOF()) , .T. )

   IncProc(STR0151) //"Gravando Nota Fiscal"

   If nTipoNF # CUSTO_REAL

      IF Di154CapQuebrou()//nNFE # Work1->WK_NFE  .OR. nSerie # Work1->WK_SE_NFE

         IF !DI154CapNF()
            EXIT
         ENDIF
         nQtdeNFs +=1
         aItens:={}//Limpa os itens da tabela para nao acumular para a proxima nota
         nNFE  :=Work1->WK_NFE
         nSerie:=Work1->WK_SE_NFE
         dDtNFE:=Work1->WK_DT_NFE
         nPesol:=nValor:=nFrete:=nSeguro:=nCIF:=nII:=nIPI:=nICMS:=nDespesa:=nPesoB:=0

      ENDIF
      

      // O Seek do Work2 e do SA2 esta antes do Skip do Work1 para incluir os dados, na Capa, do Registro certo do Work2 e do SA2
      Work2->(DBSEEK(EVAL(bSeekWk2)))//Work1->WKFORN+Work1->WK_CFO+Work1->WK_OPERACA+Work1->WKTEC+Work1->WKEX_NCM+Work1->WKEX_NBM+Work1->WKINCOTER))
      SA2->(DBSEEK(xFilial("SA2")+Work1->WKFORN+Work1->WKLOJA))//AWR 21/03/2001
      SB1->(DBSEEK(xFilial("SB1")+Work1->WKCOD_I))//JVR - 24/11/09 - DbSeek retirado de dentro do If.
      
      SC1->( DbSetOrder(1) ) // GCC - 23/07/2013 - Restauração do Indice, pois no MATA140 (Funçào DI154CapNF()) onde o mesmo é desposicionado. 
      
      IF lMV_EASYSIM
         cLOCAL:=SB1->B1_LOCPAD
         IF PosO1_It_Solic(Work1->WK_CC,Work1->WKSI_NUM,Work1->WKCOD_I,Work1->WK_REG,0)
            SW0->(DBSEEK(xFilial("SW0")+SW1->W1_CC+SW1->W1_SI_NUM))
            IF SC1->(DBSEEK(xFilial("SC1")+SW0->W0_C1_NUM+SW1->W1_POSICAO)) .AND.;
               !EMPTY(SC1->C1_LOCAL)
               cLOCAL := SC1->C1_LOCAL
            ENDIF
         ENDIF

         //** AAF 16/09/2008 - Buscar o local da Nota Primeira na Nota Complementar
         If nTipoNF == NFE_COMPLEMEN
            cLocSD1 := BuscaLocPNota()
            
            If !Empty(cLocSD1)
               cLOCAL := cLocSD1
            EndIf
         EndIf
         //**
         
         nQTSEGUM:=0
         nQUANT  :=Work1->WKQTDE
         cSEGUM  :=SPACE(LEN(Work1->WKUNI))
         cUNI    :=Work1->WKUNI
         aSegUM  :=AV_Seg_Uni(Work1->WK_CC,Work1->WKSI_NUM,Work1->WKCOD_I,Work1->WK_REG,Work1->WKQTDE)
         IF !EMPTY(aSegUM[2])
            If GETMV("MV_UNIDCOM",,2) == 2
               nQTSEGUM:=Work1->WKQTDE
               nQUANT  :=aSegUM[2]
            Else
               nQTSEGUM:=aSegUM[2]         
            Endif   
            If SW0->(DBSeek(xFilial("SW0")+Work1->WK_CC+Work1->WKSI_NUM))
               IF SC1->(DBSEEK(xFilial("SC1")+SW0->W0_C1_NUM+SW1->W1_POSICAO))//SW1 ja esta posicionado
                  cUNI  :=SC1->C1_UM
                  cSEGUM:=SC1->C1_SEGUM
                  // RA - 31/10/03 - O.S. 1107/03 - Inicio
                  If Empty(SC1->C1_SEGUM) .And. ( SC1->C1_QTSEGUM == 0 .Or. SC1->C1_QUANT == SC1->C1_QTSEGUM )
                     cSEGUM := SC1->C1_UM               
                  EndIf      
                  // RA - 31/10/03 - O.S. 1107/03 - Final
               Endif               
            Endif
         ENDIF 
//       If nTipoNF==NFE_COMPLEMEN         
         If !lGrvItem   // Bete 24/11 - Trevo
            nQTSEGUM:=0
            cSEGUM  :=SPACE(LEN(Work1->WKUNI))
            cUNI    :=SPACE(LEN(Work1->WKUNI))
         ENDIF
      
         Di154GrvSD1(cLOCAL,nQTSEGUM,nQUANT,cUNI,cSEGUM,Work1->WKCIF,nTipoNF)//AWR 27/08/2002

         IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRV_SD1"),)
         IF(ExistBlock('EICDI156'),Execblock('EICDI156',.F.,.F.,"GRV_SD1"),)
                                        // SVG - 08/10/2010 - Despesa base de imposto inserida também na nota mãe      
         IF nTipoNF==NFE_PRIMEIRA .Or. (lMV_NF_MAE .And. (nTipoNF == NFE_MAE .Or.  (nTipoNF == NFE_FILHA .And. GetMV("MV_NFFILHA",,"0") == "1"   ))) 
            nDespesa += Work1->WKDESPICM
         ELSEIF nTipoNF==NFE_UNICA
            nDespesa += ( Work1->WKDESPICM + Work1->WKOUT_DESP )
         ENDIF
      ELSE
         nDespesa    += Work1->WKOUT_DESP
         nDespesaICM += Work1->WKDESPICM 
      ENDIF
      
      //TRP - 12/12/12
      nPesoB  +=If(lPesoBruto, Work1->WKPESOBR ,/*Work1->WKQTDE*/If(lMV_EASYSIM,nQUANT,Work1->WKQTDE) * SB1->B1_PESBRU )// FSM - 02/09/2011 //JVR - 24/11/09 
      nPesol  +=Work1->WKPESOL
      nValor  +=Work1->WKFOB_R
      nFrete  +=Work1->WKFRETE
      nSeguro +=Work1->WKSEGURO
      nCIF    +=Work1->WKCIF
      nII     +=Work1->WKIIVAL
      nIPI    +=Work1->WKIPIVAL
      nICMS   +=Work1->WKVL_ICM

      nVlTotNFs   +=(Work1->WKIPIBASE+Work1->WKIPIVAL)
      nDespTotNFCs+=Work1->WKOUT_DESP

   ELSE

      IF nNFE   # Work1->WK_NFE  .OR. nSerie    # Work1->WK_SE_NFE .OR.;
         cTec   # Work1->WKTEC   .OR. cOperacao # Work1->WK_OPERACA.OR.;
         cExNCM # Work1->WKEX_NCM.OR. cExNBM    # Work1->WKEX_NBM

         Work1->(DbSkip(-1))//Para gravar os dados do registro anterior
         Work2->(DBSEEK(EVAL(bSeekWk2)))//Work1->WKFORN+Work1->WK_CFO+Work1->WK_OPERACA+Work1->WKTEC+Work1->WKEX_NCM+Work1->WKEX_NBM+Work1->WKINCOTER))
    
         EI3->(RecLock("EI3",.T.))
         EI3->EI3_FILIAL := xFilial("EI3")
         EI3->EI3_TIPO_N := STR(nTipoNF,1,0)
         EI3->EI3_HAWB   := SW6->W6_HAWB
         EI3->EI3_ICMS_A := Work2->WKICMS_A
         EI3->EI3_TEC    := Work2->WKTEC
         EI3->EI3_EX_NCM := Work2->WKEX_NCM
         EI3->EI3_EX_NBM := Work2->WKEX_NBM
         EI3->EI3_PESOL  := nPesol //Work2->WKPESOL
         EI3->EI3_FOB    := nFob   //Work1->WKFOB
         EI3->EI3_FOB_R  := nFob_R //Work2->WKFOB_R
         EI3->EI3_FRETE  := nFrete //Work2->WKFRETE
         EI3->EI3_CIF_MO := nCIF_Moe//Work2->WKCIF_MOE
         EI3->EI3_SEGURO := nSeguro//Work2->WKSEGURO
         EI3->EI3_CIF    := nCIF   //Work2->WKCIF
         EI3->EI3_II     := nII    //Work2->WKII
         EI3->EI3_IPI    := nIPI   //Work2->WKIPI
         EI3->EI3_ICMS   := nICMS  //Work2->WKICMS
         EI3->EI3_OUTRDE := nDespesa//Work2->WKOUTRDESP
         EI3->EI3_OUTR_U := nDespUS//Work2->WKOUTRD_US
         EI3->EI3_II_A   := Work2->WKII_A
         EI3->EI3_CFO    := Work2->WK_CFO
         EI3->EI3_OPERAC := Work2->WK_OPERACA
         EI3->EI3_NF_COM := Work1->WK_NFE
         EI3->EI3_SE_NFC := Work1->WK_SE_NFE
         EI3->EI3_DT_NFC := Work1->WK_DT_NFE
         EI3->EI3_IPI_A  := Work2->WKIPI_A
         IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRAVA_SD1_EI3"),)
         IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVA_SD1_EI3"),)
         EI3->(MsUnlock())

         Work1->(DbSkip())

         IF Work1->(Eof())
            EXIT
         ENDIF

         cOperacao:=Work1->WK_OPERACA
         cExNCM:=Work1->WKEX_NCM
         cExNBM:=Work1->WKEX_NBM
         cTec  :=Work1->WKTEC
         nNFE  :=Work1->WK_NFE
         nSerie:=Work1->WK_SE_NFE
         dDtNFE:=Work1->WK_DT_NFE
         nPesol:=nFob:=nFrete:=nSeguro:=nCIF:=nII:=nIPI:=nICMS:=nDespesa:=nDespUS:=nFob_R:=nCIF_Moe:=nBaseICMS:=nBaseIPI:=0

      ENDIF

      IF lExiste_Midia .AND. nTipoNF = CUSTO_REAL .AND. !EMPTY(Work1->WKFOBR_ORI)
         nFob  +=Work1->WKFOB_ORI
         nFob_R+=Work1->WKFOBR_ORI
      ELSE
         nFob  +=Work1->WKFOB
         nFob_R+=Work1->WKFOB_R
      ENDIF
      nPesol  +=Work1->WKPESOL
      nFrete  +=Work1->WKFRETE
      nSeguro +=Work1->WKSEGURO
      nCIF    +=Work1->WKCIF
      nII     +=Work1->WKIIVAL
      nIPI    +=Work1->WKIPIVAL
      nICMS   +=Work1->WKVL_ICM
      nDespesa+=Work1->WKOUT_DESP
      nDespUS +=Work1->WKOUT_D_US
      nBaseIPI+=Work1->WKIPIBASE
      nBaseICMS+=Work1->WKBASEICMS
   
      IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"ACUMULA_SD1_EI3"),)
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ACUMULA_SD1_EI3"),)
   
   ENDIF
   
   Work1->(DbSkip())

ENDDO

IF !lMSErroAuto .AND. nTipoNF # CUSTO_REAL
   DI154CapNF()
ENDIF

IF lMSErroAuto 
   BREAK
ENDIF

nWK1Ordem :=2 //Variavel usada para trocar a ordem da Work no Rdmake

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'IniciaVar4'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'IniciaVar4'),)

DBSELECTAREA("Work1")

//Work1->(DBSETORDER(nWK1Ordem))//2
Work1->(DBGOTOP())
nNFE  :=Work1->WK_NFE
nSerie:=Work1->WK_SE_NFE
dDtNFE:=Work1->WK_DT_NFE
nPesol:=nValor:=nFrete:=nSeguro:=nCIF:=nII:=nIPI:=nICMS:=nDespesa:=nItem:=nContItem:=0
nNFEAux  :=""
nSerieAux:="" 

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'IniciaVar5'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'IniciaVar5'),)

If lIntDraw .and. cAntImp == "1"
   SW8->(dbSetOrder(6))
   ED4->(dbSetOrder(2))
EndIf
SB1->(DBSETORDER(1))

//JWJ 18/05/2006: Controle para a numeração dos itens (WN_LINHA) POR NOTA
Private aNFLin := {}
Private nNFLin := 0

If AvFlags("WORKFLOW")
   aChaves := EasyGroupWF("NOTA FISCAL")
EndIf

DO WHILE ! Work1->(EOF())

   IncProc(STR0151) //"Gravando Nota Fiscal"

   If nTipoNF # CUSTO_REAL
      
      lLoop := .F.
      IF(EXISTBLOCK("EICDI154"),EXECBLOCK("EICDI154",.F.,.F.,"ANTES_GRAVA_SWN"),) //JWJ - 24/10/2005
      IF lLoop
      	Work1->(DBSKIP())
      	Loop
      ENDIF

      SWN->(RecLock("SWN",.T.))
      SWN->WN_FILIAL   := xFilial("SWN")
      SWN->WN_TIPO_NF  := STR(nTipoNF,1,0)
      SWN->WN_HAWB     := SW6->W6_HAWB
      SWN->WN_DOC      := Work1->WK_NFE
      SWN->WN_SERIE    := Work1->WK_SE_NFE
      SWN->WN_TEC      := Work1->WKTEC
      SWN->WN_EX_NCM   := Work1->WKEX_NCM
      SWN->WN_EX_NBM   := Work1->WKEX_NBM
      SWN->WN_PO_EIC   := Work1->WKPO_NUM
      SWN->WN_PO_NUM   := Work1->WKPO_SIGA
      SWN->WN_BASEICM  := Work1->WKBASEICMS
 //     If lICMS_Dif  // PLB 14/05/07 - Diferimento de ICMS
 //        SWN->WN_BASEICM += Work1->WKBASE_DIF
 //     EndIf
      SWN->WN_ITEM     := Work1->WKPOSICAO
      
      //TDF - 30/01/2012
      IF Work1->(fieldpos("WKPOSSIGA")) > 0 .AND. SWN->(FIELDPOS("WN_ITEM_DA")) > 0
         SWN->WN_ITEM_DA  := If(!Empty(Work1->WKPOSSIGA),Work1->WKPOSSIGA,Work1->WKPOSICAO) 
      EndIf
      
      SWN->WN_QUANT    := If(!lGrvItem,0,Work1->WKQTDE) //nTipoNF==NFE_COMPLEMEN   Bete 24/11 - Trevo
      SWN->WN_PRECO    := Work1->WKPRECO
      SWN->WN_UNI      := Work1->WKUNI
      SB1->(DBSEEK(xFilial("SB1")+ Work1->WKCOD_I))
      SWN->WN_LOCAL := SB1->B1_LOCPAD
      
      //JWJ 18/05/2006: Controle para a numeração dos itens (WN_LINHA) POR NOTA
      IF (nNFLin := ASCAN(aNFLin, {|x|x[1]==Work1->(WK_NFE+WK_SE_NFE)}) ) == 0
         SWN->WN_LINHA := 1
         AADD(aNFLin, {Work1->(WK_NFE+WK_SE_NFE), 1})
      Else
         aNFLin[nNFLin,2] += 1
         SWN->WN_LINHA := aNFLin[nNFLin,2]
      Endif
      
      IF Existblock("EICPDI01")
         ExecBlock("EICPDI01",.F.,.F.,"4")
      ENDIF

      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'GRAVA_WN'),)

      SC1->( DbSetOrder(1) ) // GCC - 04/07/2013 - Restauração do Indice, pois no MATA140 (Funçào DI154CapNF()) onde o mesmo é desposicionado. 
      
      IF lMV_EASYSIM
         IF PosO1_It_Solic(Work1->WK_CC,Work1->WKSI_NUM,Work1->WKCOD_I,Work1->WK_REG,0)
            SW0->(DBSEEK(xFilial("SW0")+SW1->W1_CC+SW1->W1_SI_NUM))
            IF SC1->(DBSEEK(xFilial("SC1")+SW0->W0_C1_NUM+SW1->W1_POSICAO)) .AND.;
               !EMPTY(SC1->C1_LOCAL)
               SWN->WN_LOCAL := SC1->C1_LOCAL
            ENDIF
         ENDIF
         SB1->(DBSEEK(xfilial()+Work1->WKCOD_I)) 
         aSegUM:=AV_Seg_Uni(Work1->WK_CC,Work1->WKSI_NUM,Work1->WKCOD_I,Work1->WK_REG,Work1->WKQTDE)
         IF !EMPTY(aSegUM[2])
            If GETMV("MV_UNIDCOM",,2) == 2            
               //SWN->WN_PRECO  :=(Work1->WKQTDE * Work1->WKPRECO) / aSegUM[2]
               SWN->WN_QTSEGUM:=If(!lGrvItem,0,Work1->WKQTDE) //nTipoNF==NFE_COMPLEMEN   Bete 24/11 - Trevo
               SWN->WN_QUANT  :=If(!lGrvItem,0,aSegUM[2])     //nTipoNF==NFE_COMPLEMEN   Bete 24/11 - Trevo
            Else
               SWN->WN_QTSEGUM:=aSegUM[2]         
            Endif   
            If SW0->(DBSeek(xFilial("SW0")+Work1->WK_CC+Work1->WKSI_NUM))
               IF SC1->(DBSEEK(xFilial("SC1")+SW0->W0_C1_NUM+SW1->W1_POSICAO))//SW1 ja esta posicionado
                  cUNI  :=SC1->C1_UM
                  cSEGUM:=SC1->C1_SEGUM
               Endif               
            Endif
         ENDIF
      ENDIF

      SWN->WN_PRODUTO  := Work1->WKCOD_I
      SWN->WN_VALOR    := Work1->WKVALMERC
      SWN->WN_VALIPI   := Work1->WKIPIVAL
      SWN->WN_VALICM   := Work1->WKVL_ICM
//      If lICMS_Dif  // PLB 14/05/07 - Diferimento ICMS
//         SWN->WN_VALICM  += Work1->WKVL_ICM_D
//      EndIf
      SWN->WN_OPERACA  := Work1->WK_OPERACA
      SWN->WN_FORNECE  := Work1->WKFORN
      SWN->WN_LOJA     := Work1->WKLOJA
      SWN->WN_ICMS_A   := Work1->WKICMS_A
      SWN->WN_DESCR    := Work1->WKDESCR
      SWN->WN_IPITX    := Work1->WKIPITX
      SWN->WN_VLDEVII  := Work1->WKVLDEVII
      SWN->WN_VLDEIPI  := Work1->WKVLDEIPI
      SWN->WN_IPIVAL   := Work1->WKIPIVAL
      SWN->WN_IITX     := Work1->WKIITX
      SWN->WN_IIVAL    := Work1->WKIIVAL
      SWN->WN_PRUNI    := Work1->WKPRUNI
      SWN->WN_RATEIO   := Work1->WKRATEIO
      SWN->WN_VL_ICM   := Work1->WKVL_ICM
//      If lICMS_Dif  // PLB 14/05/07 - Diferimento ICMS
//         SWN->WN_VL_ICM  += Work1->WKVL_ICM_D
//         SWN->WN_VICMDIF := Work1->WKVL_ICM_D
//      EndIf
      SWN->WN_PESOL    := Work1->WKPESOL                                              			
      SWN->WN_SEGURO   := Work1->WKSEGURO
      SWN->WN_CIF      := Work1->WKCIF
      SWN->WN_DESPESAS := Work1->WKOUT_DESP 
      SWN->WN_FRETE    := Work1->WKFRETE                         
      SWN->WN_SI_NUM   := Work1->WKSI_NUM
      SWN->WN_CC       := Work1->WK_CC
      SWN->WN_CFO      := Work1->WK_CFO
      SWN->WN_OUTR_US  := Work1->WKOUT_D_US
      SWN->WN_IPIBASE  := Work1->WKIPIBASE
      SWN->WN_PGI_NUM  := Work1->WKPGI_NUM
      SWN->WN_ADICAO   := Work1->WKADICAO
      SWN->WN_INVOICE  := Work1->WKINVOICE
      SWN->WN_OUT_DES  := Work1->WKOUTDESP
      SWN->WN_INLAND   := Work1->WKINLAND 
      SWN->WN_PACKING  := Work1->WKPACKING
      SWN->WN_DESCONT  := Work1->WKDESCONT
      SWN->WN_FOB_R    := Work1->WKFOB_R
      If lTemDespBaseICM
         SWN->WN_DESPICM := Work1->WKDESPICM
      ENDIF
      IF lMV_PIS_EIC .AND. nTipoNF # 2
         SWN->WN_VLUPIS := Work1->WKVLUPIS
         SWN->WN_BASPIS := Work1->WKBASPIS
         SWN->WN_PERPIS := Work1->WKPERPIS
         SWN->WN_VLRPIS := Work1->WKVLRPIS
         SWN->WN_VLUCOF := Work1->WKVLUCOF
         SWN->WN_BASCOF := Work1->WKBASCOF
         SWN->WN_PERCOF := Work1->WKPERCOF
         SWN->WN_VLRCOF := Work1->WKVLRCOF 
         
         If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
            SWN->WN_ALCOFM := Work1->WKALCOFM
            SWN->WN_VLCOFM := Work1->WKVLCOFM
         EndIf
         If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
            SWN->WN_ALPISM := Work1->WKALPISM
            SWN->WN_VLPISM := Work1->WKVLPISM
         EndIf   
                  
      ENDIF
      IF lLote
         SWN->WN_LOTECTL:= Work1->WK_LOTE
         SWN->WN_DTVALID:= Work1->WKDTVALID
      ENDIF
      IF lExisteSEQ_ADI// AWR - 18/09/08 - NFE
         SWN->WN_SEQ_ADI := Work1->WKSEQ_ADI// AWR - 11/09/08 - NF-Eletronica
      ENDIF
      IF lMV_GRCPNFE .AND. nTipoNF # 2//Campos novos NFE - AWR 06/11/2008
         SWN->WN_DESPADU := Work1->WKDESPCIF
         SWN->WN_ALUIPI  := Work1->WKALUIPI
         SWN->WN_QTUIPI  := Work1->WKQTUIPI
         SWN->WN_QTUPIS  := Work1->WKQTUPIS
         SWN->WN_QTUCOF  := Work1->WKQTUCOF
         SWN->WN_PREDICM := Work1->WKPREDICM
      ENDIF
      IF lAcresDeduc  //Bete - 25/07/04 - Gravacao dos valores de acrescimos/deducoes
         SWN->WN_VLACRES := Work1->WKVLACRES
         SWN->WN_VLDEDUC := Work1->WKVLDEDUC
      ENDIF
      If lMV_EASYSIM .AND. nTipoNF # NFE_COMPLEMEN      // Bete 24/11 - falta analisar p/ Trevo
	      MaAvalPC("SC7",10) // Edu -> Baixa o Pedido de Compra feito até a versão 6.09
      EndIF
      If lICMS_Dif  // PLB 14/05/07 - Tratamento para Diferimento de ICMS
         SWN->WN_VICMDIF := Work1->WKVL_ICM_D
         SWN->WN_VICM_CP := Work1->WKVLCREPRE
      EndIf

      If lICMS_Dif2  // EOB - 16/02/09
         SWN->WN_PICM_PD := WORK1->WK_PAG_DES
         SWN->WN_PICMDIF := WORK1->WK_PERCDIF 
         SWN->WN_PICM_CP := WORK1->WK_PCREPRE
         SWN->WN_PLIM_CP := WORK1->WK_CRE_PRE
      EndIf
      
      SWN->(MsUnlock())

      If lIntDraw .and. cAntImp == "1" .and. (nTipoNF = 1 .OR. nTipoNF = 3 .OR. nTipoNF = 5 ) .and. lExistEDD
         SW8->(dbSeek(xFilial("SW8")+SWN->WN_HAWB+SWN->WN_INVOICE+SWN->WN_PO_EIC+SWN->WN_ITEM+SWN->WN_PGI_NUM))
         If !Empty(SW8->W8_AC) .and. aScan(aAntLido,{|x| x[1]==SWN->WN_HAWB .and. x[2]==SWN->WN_INVOICE .and.;
         x[3]==SWN->WN_PO_EIC .and. x[4]==SWN->WN_ITEM .and. x[5]==SWN->WN_PGI_NUM}) = 0
            aAdd(aAntLido,{SWN->WN_HAWB,SWN->WN_INVOICE,SWN->WN_PO_EIC,SWN->WN_ITEM,SWN->WN_PGI_NUM})
            ED4->(dbSeek(xFilial("ED4")+SW8->W8_AC+SW8->W8_SEQSIS))
            DIGrvAnt(1,SWN->WN_HAWB,SWN->WN_PO_EIC,SWN->WN_INVOICE,SWN->WN_PRODUTO,SWN->WN_ITEM,SWN->WN_PGI_NUM,SW8->W8_QT_AC,dDtNFE,ED4->ED4_AC,ED4->ED4_SEQSIS,ED4->ED4_PD)
         EndIf
      EndIf

		// ACL 10/06/05 
      If lTipoCompl
         nTotNFC := nTotNFC + SWN->WN_VALOR
      EndIf

   ELSE

      IF Di154CapQuebrou()//nNFE # Work1->WK_NFE  .OR. nSerie # Work1->WK_SE_NFE
     
         DI154CapNF()
         nQtdeNFs +=1
         nNFE  :=Work1->WK_NFE
         nSerie:=Work1->WK_SE_NFE
         dDtNFE:=Work1->WK_DT_NFE
         nPesol:=nValor:=nFrete:=nSeguro:=nCIF:=nII:=nIPI:=nICMS:=nDespesa:=0

      ENDIF

      EI2->(RecLock("EI2",.T.))
      EI2->EI2_FILIAL   := xFilial("EI2")
      EI2->EI2_TIPO_N   := STR(nTipoNF,1,0)
      EI2->EI2_HAWB     := SW6->W6_HAWB
      EI2->EI2_DOC      := Work1->WK_NFE
      EI2->EI2_NOTA     := Work1->WK_NOTA
      EI2->EI2_SERIE    := Work1->WK_SE_NFE
      EI2->EI2_TEC      := Work1->WKTEC
      EI2->EI2_EX_NCM   := Work1->WKEX_NCM
      EI2->EI2_EX_NBM   := Work1->WKEX_NBM
      EI2->EI2_PO_NUM   := Work1->WKPO_NUM
      EI2->EI2_POSICA   := Work1->WKPOSICAO
      EI2->EI2_QUANT    := If(!lGrvItem,0,Work1->WKQTDE) // nTipoNF==NFE_COMPLEMEN   Bete 24/11 - Trevo
      EI2->EI2_PRODUT   := Work1->WKCOD_I
      EI2->EI2_VALOR    := Work1->WKVALMERC
      EI2->EI2_VALIPI   := Work1->WKIPIVAL
      EI2->EI2_VALICM   := Work1->WKVL_ICM
   // AWR 14/7/98
      EI2->EI2_OPERAC   := Work1->WK_OPERACA
      EI2->EI2_FORNEC   := Work1->WKFORN//AWR 21/03/2001
      EI2->EI2_LOJA     := Work1->WKLOJA//AWR 21/03/2001
      EI2->EI2_ICMS_A   := Work1->WKICMS_A
      EI2->EI2_PRECO    := Work1->WKPRECO
      EI2->EI2_DESCR    := Work1->WKDESCR
      EI2->EI2_UNI      := Work1->WKUNI
      EI2->EI2_VLDEII   := Work1->WKVLDEVII
      EI2->EI2_VLDIPI   := Work1->WKVLDEIPI
      EI2->EI2_IPITX    := Work1->WKIPITX
      EI2->EI2_IPIVAL   := Work1->WKIPIVAL
      EI2->EI2_IITX     := Work1->WKIITX
      EI2->EI2_IIVAL    := Work1->WKIIVAL
      EI2->EI2_PRUNI    := Work1->WKPRUNI
      EI2->EI2_RATEIO   := Work1->WKRATEIO
      EI2->EI2_VL_ICM   := Work1->WKVL_ICM
      EI2->EI2_PESOL    := Work1->WKPESOL
      EI2->EI2_SEGURO   := Work1->WKSEGURO
      EI2->EI2_CIF      := Work1->WKCIF
      EI2->EI2_DESPES   := Work1->WKOUT_DESP + Work1->WKDESPICM //NCF - 19/07/2011 - Considerar também despesas base de icms como despesa de custo 
      EI2->EI2_FRETE    := Work1->WKFRETE
      EI2->EI2_SI_NUM   := Work1->WKSI_NUM
      EI2->EI2_CC       := Work1->WK_CC
      EI2->EI2_CFO      := Work1->WK_CFO
      EI2->EI2_REC_ID   := Work1->WKREC_ID
      EI2->EI2_OUTR_U   := Work1->WKOUT_D_US
      EI2->EI2_IPIBAS   := Work1->WKIPIBASE
      EI2->EI2_PGI_NU   := Work1->WKPGI_NUM
      EI2->EI2_INVOIC   := Work1->WKINVOICE
      EI2->EI2_OUT_DE   := Work1->WKOUTDESP
      EI2->EI2_INLAND   := Work1->WKINLAND 
      EI2->EI2_PACKIN   := Work1->WKPACKING
      EI2->EI2_DESCON   := Work1->WKDESCONT
      EI2->EI2_FOB_R    := Work1->WKFOB_R
      IF lMV_PIS_EIC
         EI2->EI2_VLUPIS := Work1->WKVLUPIS
         EI2->EI2_BASPIS := Work1->WKBASPIS
         EI2->EI2_PERPIS := Work1->WKPERPIS
         EI2->EI2_VLRPIS := Work1->WKVLRPIS
         EI2->EI2_VLUCOF := Work1->WKVLUCOF
         EI2->EI2_BASCOF := Work1->WKBASCOF
         EI2->EI2_PERCOF := Work1->WKPERCOF
         EI2->EI2_VLRCOF := Work1->WKVLRCOF 
         
         If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
            EI2->EI2_VLCOFM += Work1->WKVLCOFM
         EndIf 
         If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
            EI2->EI2_VLPISM += Work1->WKVLPISM
         EndIf        
      ENDIF
      IF lLote
         EI2->EI2_LOTECT:= Work1->WK_LOTE
         EI2->EI2_DTVALI:= Work1->WKDTVALID
      ENDIF
      IF lAcresDeduc  //Bete - 25/07/04 - Gravacao dos valores de acrescimos/deducoes
         EI2->EI2_VACRES := Work1->WKVLACRES
         EI2->EI2_VDEDUC := Work1->WKVLDEDUC
      ENDIF

      EI2->(MsUnlock())

      nPesol  +=EI2->EI2_PESOL
      IF lExiste_Midia .AND. !EMPTY(Work1->WKFOBR_ORI)
         nValor +=Work1->WKFOBR_ORI
      ELSE
         nValor +=Work1->WKFOB_R
      ENDIF
      nFrete  +=EI2->EI2_FRETE
      nSeguro +=EI2->EI2_SEGURO
      nCIF    +=EI2->EI2_CIF
      nII     +=EI2->EI2_IIVAL
      nIPI    +=EI2->EI2_IPIVAL
      nICMS   +=EI2->EI2_VL_ICM
      nDespesa+=EI2->EI2_DESPES

   ENDIF

   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRAVA_SWN_EI2"),)
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVA_SWN_EI2"),)   

   // O Seek do Work2 e do SA2 esta antes do Skip do Work1 para incluir os dados, na Capa, do Registro certo do Work2 e do SA2
   Work2->(DBSEEK(EVAL(bSeekWk2)))
   SA2->(DBSEEK(xFilial("SA2")+Work1->WKFORN+Work1->WKLOJA))//AWR 21/03/2001

   Work1->(DbSkip())

ENDDO

// *** GFP - 28/03/2011 :: 17h05 - Tratamento de WorkFlow na geração de NF.
If AvFlags("WORKFLOW")
   EasyGroupWF("NOTA FISCAL", aChaves)
EndIf

/*
If lEasyWorkFlow
   SX2->(DbSetOrder(1))
   If SX2->(DbSeek("EJ7"))
      EJ7->(DbSetOrder(1))
      If EJ7->(DbSeek(xFilial("EJ7")+AvKey("NF","EJ7_COD"))) .AND. EJ7->EJ7_ATIVO == "1" .AND. EJ7->EJ7_OPCENV == "1"
         oWorkFlow := EasyWorkFlow():New("NF", SWN->(WN_FILIAL+WN_HAWB))
         oWorkFlow:Send()
      Endif
   Endif
Endif
*/
// *** Fim GFP
If lIntDraw .and. cAntImp == "1"
   SW8->(dbSetOrder(1))
   ED4->(dbSetOrder(1))
EndIf

If nTipoNF = CUSTO_REAL
   DI154CapNF()
ENDIF

nQtdeNFs +=1

Work1->(DbGoTop())

SW6->(RecLock("SW6",.F.))

//If nTipoNF==NFE_PRIMEIRA .OR. nTipoNF==NFE_UNICA
If lAtuSW6NFE    // Bete 24/11 - Trevo
   SW6->W6_NF_ENT  :=ALLTRIM(Work1->WK_NFE)+IF(nQtdeNFs>1," ...","")
   SW6->W6_SE_NF   :=Work1->WK_SE_NFE
   SW6->W6_DT_NF   :=Work1->WK_DT_NFE
   SW6->W6_VL_NF   :=n_VlTota //ER - 22/10/2007
   //SW6->W6_VL_NF   :=nVlTotNFs
   DI154ProcEIB(.T.)
ENDIF

//If nTipoNF==NFE_COMPLEMEN .OR. nTipoNF==NFE_UNICA
//If lTipoCompl .OR. nTipoNF==NFE_UNICA   // Bete 24/11 - Trevo
IF nTipoNF # CUSTO_REAL  // AWR - 26/05/2004
// If nTipoNF==NFE_COMPLEMEN .And. Empty(SW6->W6_NF_COMP)
   If lTipoCompl //.And. Empty(SW6->W6_NF_COMP)    // Bete 24/11 - Trevo
      SW6->W6_NF_COMP:=ALLTRIM(Work1->WK_NFE)+IF(nQtdeNFs>1," ...","")
      SW6->W6_SE_NFC :=Work1->WK_SE_NFE
      SW6->W6_DT_NFC :=Work1->WK_DT_NFE
      SW6->W6_VL_NFC +=nTotNFC       //ACL 10/06/05 - Gravar o valor da NFC
   Endif

   SWD->(DBSEEK(xFilial("SWD")+SW6->W6_HAWB))
   DO WHILE SWD->(!EOF()) .AND. EVAL(bDDIWhi)
      //NCF - 13/09/2010 - Para gravar número na nota quando é imposto integrado pelo despachante
      //TDF - 06/01/2010 - Revisão do tratamento para gravar o número da nota                        // SVG - 19/01/2011 - Gravar numero da nota nas despesas 1 2 9 , quando nao for complementar
      IF SYB->(DbSeek(xFilial("SYB")+SWD->WD_DESPESA )) .AND. (LEFT(SWD->WD_DESPESA,1) $ "12") .AND. !lTipoCompl //SWD->WD_INTEGRA
         SWD->(RecLock("SWD",.F.))
            SWD->WD_NF_COMP:=Work1->WK_NFE
            SWD->WD_SE_NFC :=Work1->WK_SE_NFE
         SWD->(MsUnlock())      
      ENDIF
      IF !SYB->(DbSeek(xFilial("SYB")+SWD->WD_DESPESA )) .OR.; //SVG - 08-12-08
         !EVAL(bDDIFor) .OR. SYB->YB_BASECUS $ cNao .AND. (GetMV("MV_EICNFTO",,"1") <> "2" .OR. SYB->YB_BASEIMP $ cNao)
         SWD->(DBSKIP())
         LOOP
      ENDIF
      lBaseICMS:=SYB->YB_BASEICM
      IF SYB->YB_BASEICM $ cSim
         IF lTemYB_ICM_UF                 
            lBaseICMS:= SYB->(FIELDGET(FIELDPOS(cCpoBasICMS)))
         ENDIF
      ENDIF
      IF (nTipoNF = NFE_PRIMEIRA .Or. (lMV_NF_MAE .And. nTipoNF == NFE_MAE) .Or. (lMV_NF_MAE .And. nTipoNF == NFE_FILHA));
       .AND. !(SYB->YB_BASEIMP $ cSim) .AND. !(lBaseICMS $ cSim)
         SWD->(DBSKIP())
         LOOP
      ENDIF 
      
      //GCC - 21/05/2013 - Filtrar as despesas que já tem Nota Fiscal de Despesa (NFD) emitida no processo de emissão de Nota Fiscal Complementar (NFC)
      //13/07/13 - Verifica se o cliente possui os campos da Nota de Despesa antes de validar
	  If nTipoNF == NFE_COMPLEMEN .And. lCposNFDesp
		 If SWD->(!Empty(WD_DOC) .And. !Empty(WD_SERIE))
			SWD->( DbSkip() )
			Loop
		 EndIf
	  EndIf
	  	  
      SWD->(RecLock("SWD",.F.))
      SWD->WD_NF_COMP:=Work1->WK_NFE
      SWD->WD_SE_NFC :=Work1->WK_SE_NFE
      SWD->WD_DT_NFC :=Work1->WK_DT_NFE
      SWD->WD_VL_NFC :=nVlTotNFs
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVA_SWD"),)
      SWD->(MsUnlock())
      SWD->(DBSKIP())
   ENDDO
ENDIF

IF Existblock("EICPDI01")
   ExecBlock("EICPDI01",.F.,.F.,"2")
ENDIF

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'GRAVAR'),)

SW6->(MsUnlock())

//If nTipoNF # NFE_PRIMEIRA
IF lGravaSWW
   Work3->(DBGOTOP())
   DO WHILE Work3->(!EOF())
      IncProc(STR0152+' '+LEFT(Work3->WKDESPESA,3))//"Gravando Despesas: "
      Work1->(DBGOTO(Work3->WKRECNO))
      SWW->(RecLock("SWW",.T.))
      SWW->WW_FILIAL  := xFilial("SWW")
      SWW->WW_DESPESA := Work3->WKDESPESA
      SWW->WW_VALOR   := Work3->WKVALOR
      SWW->WW_PO_NUM  := Work3->WKPO_NUM
      SWW->WW_NF_COMP := Work3->WK_NF_COMP
      SWW->WW_SE_NFC  := Work3->WK_SE_NFC
      SWW->WW_DT_NFC  := Work3->WK_DT_NFC
      SWW->WW_TIPO_NF := STR(nTipoNF,1,0)
      SWW->WW_FORNECE := Work1->WKFORN
      SWW->WW_LOJA    := Work1->WKLOJA
      SWW->WW_NR_CONT := Work3->WKPOSICAO
      SWW->WW_HAWB    := SW6->W6_HAWB
      SWW->WW_PGI_NUM := Work3->WKPGI_NUM
      SWW->WW_LOTECTL := Work3->WK_LOTE

      IF SWW->(FIELDPOS("WW_INVOICE")) # 0
         SWW->WW_INVOICE := WORK1->WKINVOICE
      ENDIF

      IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRAVA_SWW"),)
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVA_SWW"),)
      SWW->(MsUnlock())  
      Work3->(DBSKIP())
   ENDDO
ENDIF

//Bete - 25/07/04 - Grava os registros referente a acrescimo e deducoes no arquivo EIU
IF lAcresDeduc
   DO WHILE !Work_EIU->(eof())
      IF !EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0)))                  //NCF - 23/09/2010
         EIU->(RecLock("EIU",.T.))
         EIU->EIU_FILIAL := xFilial("EIU")
         EIU->EIU_HAWB   := SW6->W6_HAWB
         EIU->EIU_TIPONF := STR(nTipoNF,1)
         EIU->EIU_TIPO   := Work_EIU->EIU_TIPO
         EIU->EIU_ADICAO := Work_EIU->EIU_ADICAO
         EIU->EIU_CODIGO := Work_EIU->EIU_CODIGO
         EIU->EIU_VALOR  := Work_EIU->EIU_VALOR
         EIU->(MsUnlock())
       ENDIF      
       Work_EIU->(dbSkip())
   ENDDO
ENDIF

End SEQUENCE

End Transaction

Work1->(DBSETORDER(1))
Work1->(DbGoto(nRec1))
Work2->(DbGoto(nRec2))
Work3->(DbGoto(nRec3))

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"FINAL_GRAVA_NF"),)
IF(ExistBlock("EIFPNF01"),ExecBlock("EIFPNF01",.F.,.F.),)

IF !lMSErroAuto 
   cNota:=cNotaGrupo
   lGerouNFE:=.T.
   IF nTipoNF # CUSTO_REAL
      MSGINFO((STR0153),STR0108) //"Geracao de Nota Fiscal Concluida"###"Informação"
   ELSE
      MsgInfo((STR0154),STR0108) //"Gravacao de Custo Concluida"###"Informação"
   ENDIF
ENDIF

DbSelectArea(nOldArea)

Return .T.
*--------------------------------------------------------------------------------------*
//Atencao: Essa funcao eh chamada do EIDI554.PRW e do EICDI156.PRW
Function Di154GrvSD1(cLOCAL,nQTSEGUM,nQUANT,cUNI,cSEGUM,nCIF,xTipoNF,lEICDI156)
*--------------------------------------------------------------------------------------*
Local cPosicao := Work1->WKPOSICAO // RA - 24/10/03 - O.S. 1075/03
LOCAL GRV:=0
LOCAL nOrdSWN  // JBS - 13/04/2004  - OS 0024/04 - 0560/04
LOCAL cTipoNF  // JBS - 13/04/2004  - OS 0024/04 - 0560/04
LOCAL lAchouSWN
LOCAL lCpoCtCust := (GetMV("MV_EASY")$cSim) .And. SW3->(FIELDPOS("W3_CTCUSTO")) > 0 // NCF - 23/06/2010 - Flag do campo de Centro de Custo 
LOCAL aOrdTabl   := {}
Local lSeekSC7   := .F. // SVG - 29/07/2010 -
PRIVATE lSair    := .F.

IF(EXISTBLOCK("EICDI154"),EXECBLOCK("EICDI154",.F.,.F.,"ANTES_GRAVA_SD1"),)	//JWJ - 24/10/2005

IF lSair
	Return
Endif

xTipoNF:=STR(xTipoNF,1)

SC7->(DBSETORDER(1))

IF Work1->(fieldpos("WKPOSSIGA")) >0
   If !Empty(Work1->WKPOSSIGA) // DI veio de uma DA
       cPosicao := Work1->WKPOSSIGA
   EndIf
ENDIF        
If !SC7->(DbSeek(xFilial()+Work1->WKPO_SIGA+cPosicao))
    If SC7->(DbSeek(xFilial()+Work1->WKPO_SIGA+'01  '+cPosicao))
       lSeekSC7:= .T. // SVG - 29/07/2010 -
    EndIf
Else     
   lSeekSC7:= .T.// SVG - 29/07/2010 -
EndIf
// RA - 24/10/03 - O.S. 1075/03 - Final
SB1->(DbSeek(xFilial()+Work1->WKCOD_I))
aItem:={}

//AADD(aItem,{"D1_ITEM"        ,Work1->WKPOSICAO ,NIL}) //OS 1163/03   -  08/11/2003

AADD(aItem,{"D1_COD"         ,Work1->WKCOD_I   ,Nil})// codigo do produto
//SVG - 16/05/2011 - Nopado a verificação da variável lGrvItem devido a esses campos serem usados para o envio ao SEFAZ 
//If lGrvItem   // Bete 24/11 - Trevo
   //If nTipoNF != NFE_MAE
   If lSeekSC7 // SVG - 29/07/2010 -
      AADD(aItem,{"D1_PEDIDO"   ,Work1->WKPO_SIGA ,".T."})// Pedido de compra
      AADD(aItem,{"D1_ITEMPC"   ,SC7->C7_ITEM     ,".T."})// Item do Pedido de compra
   EndIf
  // EndIf
//Endif	
If !Empty(cUNI)
   AADD(aItem,{"D1_UM"       ,cUNI             ,".T."}) // unidade do produto
Endif	
If !Empty(cSEGUM)
   AADD(aItem,{"D1_SEGUM"    ,cSEGUM           ,".T."})
Endif	                  
If lTipoCompl    // Bete 24/11 - Trevo
   AADD(aItem,{"D1_VUNIT"    ,Work1->WKVALMERC ,".T."}) // valor unitario do item
ELSE
   AADD(aItem,{"D1_QUANT"    ,nQUANT           ,".T."}) // quantidade do produto
   AADD(aItem,{"D1_VUNIT"    ,Work1->WKVALMERC/nQuant,".T."}) // valor unitario do item
Endif
IF !Empty(cSEGUM)    // JBS 13/04/2004 
   AADD(aItem,{"D1_QTSEGUM"  ,nQTSEGUM         ,".T."})
ENDIF                                                                                                

AADD(aItem,{"D1_VALIPI"   ,Work1->WKIPIVAL  ,".T."})  // Vlr do IPI 
AADD(aItem,{"D1_VALICM"   ,Work1->WKVL_ICM  ,".T."})  // Vlr do ICMS

If !Empty(Work1->WK_CFO)
   AADD(aItem,{"D1_CF"       ,Work1->WK_CFO    ,".T."})  // Classificacao Fiscal                                                
ENDIF
AADD(aItem,{"D1_IPI"      ,Work1->WKIPITX   ,".T."})
AADD(aItem,{"D1_PICM"     ,Work1->WKICMS_A  ,".T."})
AADD(aItem,{"D1_PESO"        ,Work1->WKPESOL   ,".T."})  // Peso Total do Item

// 09/03/06 - Bete - Chamado 025671 
AADD(aItem,{"D1_CONTA"    ,SC1->C1_CONTA    ,".T."})    //NCF - 18/10/2010 - Gravação a partir da Solicitação de Compras e não do
AADD(aItem,{"D1_ITEMCTA"  ,SC1->C1_ITEMCTA  ,".T."})    //                   Pedido de Compras (SC7)
AADD(aItem,{"D1_CLVL"     ,SC1->C1_CLVL     ,".T."})    //ISS - 06/05/2011 - Classe Valor Contabil


If lCpoCtCust  //NCF - 23/06/2010 - Gravação do campo do Centro de Custo no SD1
   aOrdTabl := SaveOrd({"SW3"})
      SW3->(DbSetOrder(8))
      SW3->(DbSeek(xFilial() + Work1->WKPO_NUM + Work1->WKPOSICAO))
      //DFS - 29/08/12 - Para só utilizar o SW3 se o mesmo tiver preenchido, visto que, não é um campo obrigatório
      If !Empty(SW3->W3_CTCUSTO)
         AADD(aItem,{"D1_CC"       ,SW3->W3_CTCUSTO       ,".T."}) 
      Else 
         AADD(aItem,{"D1_CC"       ,SC7->C7_CC       ,".T."})
      EndIf
   RestOrd(aOrdTabl)
Else
   AADD(aItem,{"D1_CC"       ,SC7->C7_CC       ,".T."})
EndIf
//
AADD(aItem,{"D1_FORNECE"     ,Work1->WKFORN    ,".T."})
AADD(aItem,{"D1_LOJA"        ,Work1->WKLOJA    ,".T."})
AADD(aItem,{"D1_LOCAL"       ,cLOCAL           ,".T."})
AADD(aItem,{"D1_DOC"         ,Work1->WK_NFE    ,NIL})
AADD(aItem,{"D1_SERIE"       ,Work1->WK_SE_NFE ,NIL})
AADD(aItem,{"D1_EMISSAO"     ,Work1->WK_DT_NFE ,NIL})
AADD(aItem,{"D1_DTDIGIT"     ,dDataBase        ,".T."})               
AADD(aItem,{"D1_TIPO"        ,IF(lTipoCompl,"C" ,"N" ),NIL})   //nTipoNF=NFE_COMPLEMEN   Bete 24/11 - Trevo
AADD(aItem,{"D1_TIPODOC"     ,IF(lTipoCompl,"13","10"),NIL})   //nTipoNF=NFE_COMPLEMEN   Bete 24/11 - Trevo
AADD(aItem,{"D1_TP"          ,SB1->B1_TIPO     ,".T."})
AADD(aItem,{"D1_TOTAL"       ,Work1->WKVALMERC ,".T."})  // valor total do item (quantidade * preco)
AADD(aItem,{"D1_BASEICM"  ,Work1->WKBASEICMS,".T."})
AADD(aItem,{"D1_BASEIPI"  ,Work1->WKIPIBASE ,".T."})
AADD(aItem,{"D1_FORMUL"      ,cFormPro         ,".T."})
AADD(aItem,{"D1_TEC"         ,Work1->WKTEC+Work1->WKEX_NCM+Work1->WKEX_NBM+Work1->WK_OPERACA,".T."})
AADD(aItem,{"D1_CONHEC"      ,SW6->W6_HAWB     ,".T."})
AADD(aItem,{"D1_TIPO_NF"     ,xTipoNF          ,NIL}) 
//IF nTipoNF == NFE_COMPLEMEN  // Alfredo Magalhaes - Microsiga
IF lTipoCompl .Or. lFilha   // Bete 24/11 - Trevo 
   //  JBS - 13/04/2004 OS 0024/04 0560/04
   nOrdSWN := SWN->(INDEXORD())  // JBS - 13/04/2004
   SWN->(DBSETORDER(3))
   lAchouSWN := .F.
   IF SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB))
 
      DO WHILE SWN->(!EOF())                    .AND.;
               SWN->WN_FILIAL  == xFilial("SWN").AND.;
               SWN->WN_HAWB    == SW6->W6_HAWB
               
         IF (SWN->WN_INVOICE == WORK1->WKINVOICE) .AND.;
            (SWN->WN_PO_EIC  == WORK1->WKPO_NUM)  .AND.;
            (SWN->WN_PGI_NUM == WORK1->WKPGI_NUM) .AND.;
            (SWN->WN_ITEM    == WORK1->WKPOSICAO) .AND.;
            (IIf(lLote,Alltrim(SWN->WN_LOTECTL) == Alltrim(Work1->WK_LOTE),.T.)) .AND.; //ASK 09/09/2007 - Verifica quebra de lote.
            (SWN->WN_TIPO_NF $ "1,3,5")

            AADD(aItem,{"D1_NFORI"    ,SWN->WN_DOC    ,NIL})
            AADD(aItem,{"D1_SERIORI"  ,SWN->WN_SERIE  ,NIL})
//            AADD(aItem,{"D1_ITEMORI"  ,SWN->WN_ITEM   ,NIL})
            AADD(aItem,{"D1_ITEMORI"  ,STRZERO(SWN->WN_LINHA, 4)  ,.F.})//ASR 16/02/2006 
           // SVG - 25/03/2010 -
            SF1->(dbSetOrder(5))
            If !SF1->(dbSeek(xFilial("SF1") + SWN->WN_HAWB + "1"))
               If SF1->(dbSeek(xFilial("SF1") + SWN->WN_HAWB + "3"))
                  AADD(aItem,{"D1_DATORI"  ,SF1->F1_EMISSAO  ,Nil}) 
               EndIf
            Else
               AADD(aItem,{"D1_DATORI"  ,SF1->F1_EMISSAO  ,Nil}) 
            EndIf

            lAchouSWN := .T.
            
            EXIT
             
         ENDIF
         SWN->(DbSkip())
      ENDDO        
   ENDIF
   SWN->(DBSETORDER(nOrdSWN))  // JBS - 13/04/2004
/*   IF !lAchouSWN
     // Help("",1,"AVG0000804")//"Existe Desbalanceamento no Banco de Dados, por favor saia do Sistema."
     // RETURN .F.
   ENDIF*/
   // JBS - 13/04/2004 - FIM  
Endif                                    
IF cPaisLoc # "BRA"  // pedido por Eduardo Rieira em mail dia 10/07/03 -rhp
  AADD(aItem,{"D1_ESPECIE"     ,'NF',NIL})// NOTA FISCAL DE ENTRADA
ENDIF

IF lLote .AND. SD1->(FIELDPOS("D1_LOTECTL")) # 0 .AND. SD1->(FIELDPOS("D1_DTVALID")) # 0
   SB1->(DBSEEK(xFilial("SB1")+Work1->WKCOD_I))
   IF SB1->B1_RASTRO $ "SL" .AND. !EMPTY(Work1->WK_LOTE)
      AADD(aItem,{"D1_LOTECTL",Work1->WK_LOTE  ,})
       IF !EMPTY(Work1->WKDTVALID)
          AADD(aItem,{"D1_DTVALID",Work1->WKDTVALID,})
       ENDIF
   ENDIF
ENDIF
IF Work1->(FIELDPOS("WKDESPICM")) # 0//!lEICDI156 .AND. 
                                  // SVG - 08/10/2010 - Despesa base de imposto inserida também na nota mãe      
   IF nTipoNF==NFE_PRIMEIRA .Or. (lMV_NF_MAE .And. (nTipoNF == NFE_MAE .Or.  (nTipoNF == NFE_FILHA .And. GetMV("MV_NFFILHA",,"0") == "1")))
      AADD(aItem,{"D1_DESPESA",Work1->WKDESPICM,".T."})
   ELSEIF nTipoNF == 3
      AADD(aItem,{"D1_DESPESA",Work1->WKDESPICM+Work1->WKOUT_DESP,".T."})   
   ELSEIF nTipoNF == 2
      AADD(aItem,{"D1_DESPESA",0,".T."})   
   ENDIF
ENDIF

IF lMV_PIS_EIC
   AADD(aItem,{cCpoBsPis,Work1->WKBASPIS,".T."})
   AADD(aItem,{cCpoVlPis,Work1->WKVLRPIS,".T."})
   AADD(aItem,{cCpoAlPis,Work1->WKPERPIS,".T."})
   AADD(aItem,{cCpoAlCof,Work1->WKPERCOF,".T."})
   AADD(aItem,{cCpoBsCof,Work1->WKBASCOF,".T."})
   AADD(aItem,{cCpoVlCof,Work1->WKVLRCOF,".T."})
ENDIF

// EOS - 06/10/03
IF cPaisLoc # "BRA"  
   // No D1_LOCAL ja vem gravado o C1_LOCAL e no WKLOCAL ja vem o W7_LOCAL
   // Prioridade 1o. - SW7, 2o. - SC1, 3o. - SB1
   IF (nPosLoc:=ASCAN(aItem,{|A| A[1] == "D1_LOCAL"})) # 0
      IF !EMPTY(Work1->WKLOCAL)//SW7
         aItem[nPosLoc,2]:=Work1->WKLOCAL
      ELSEIF EMPTY(SWN->WN_LOCAL)//SC1
         SB1->(DbSeek(xFilial("SB1")+Work1->WKCOD_I))
         aItem[nPosLoc,2]:=SB1->B1_LOCPAD
      ENDIF
   ENDIF
ENDIF

If lICMS_Dif  // PLB 14/05/07 - Tratamento Diferimento ICMS
   Aadd( aItem, { "D1_ICMSDIF", Work1->WKVL_ICM_D, ".T." } )
EndIf

If lCposCofMj //NCF - 25/07/2012 - Majoração COFINS
   Aadd( aItem, { "D1_VALCMAJ", Work1->WKVLCOFM , ".T." } )
EndIf
If lCposPisMj //GFP - 11/06/2013 - Majoração PIS
   Aadd( aItem, { "D1_VALPMAJ", Work1->WKVLPISM , ".T." } )
EndIf
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'GRAVACAO_SD1'),)
//Chamada EICDI554 por que essa funcao eh chamada do EIDI554.PRW - AWR 31/08/2002
//IF(ExistBlock("EICDI554"),Execblock("EICDI554",.F.,.F.,'GRAVACAO_SD1'),)
//Chamada EICDI156 por que essa funcao eh chamada do EIDI156.PRW - AWR 14/11/2002
//IF(ExistBlock("EICDI156"),Execblock("EICDI156",.F.,.F.,'GRAVACAO_SD1'),)

AADD(aItens,ACLONE(aItem))

RETURN .T.

*---------------------*
Function Di154Quebrou()  // Jonato 30-01-2001  , Para que outras quebras possam ser feitas, via rdmake
*---------------------*
PRIVATE lQuebra_Espe:=.f., lQuebrou_NF:=.f.
Private lQuebraCFO := GetMV("MV_QBCFO",,.T.) //RRV - 18/01/2013 - Define se a nota será quebrada por CFOP ou não.(.T. = Quebra, .F. = Não quebra)

IF (ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'Tem_Outra_Quebra'),)
IF (ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'Tem_Outra_Quebra'),)

IF ! lQuebra_Espe

   //DFS - 14/02/11 - Caso tenha nota fiscal complementar, quebrar por numero de nota.
   If nTipoNF == NFE_COMPLEMEN
      If Work1->WKNOTAOR <> cNumComp .OR. Work1->WKSERIEOR <> cSerieComp .Or. nItem >= GetMV("MV_NUMITEN")
         cNumComp   := WORK1->WKNOTAOR
         cSerieComp := WORK1->WKSERIEOR
         Return .T.
      Else
         Return .F.
      EndIf   
   Else
      IF nItem >= GetMV("MV_NUMITEN") .OR.;
         cForn # Work1->WKFORN .OR. (EICLoja() .And. cForLoj # Work1->WKLOJA) .OR.;   // GFP - 03/07/2013 - Quebra de NF por Loja de Fornecedor.
         nItem == 0 .OR. If(lQuebraCFO, cCFO # Work1->WK_CFO,.F.) .OR.; //RRV - 18/01/2013 - Incluida flag de quebra de nota por CFOP. (.T. = Quebra, .F. = Não quebra)
         (lIntDraw .AND. Work1->WKACMODAL # cACModal) .OR.;
         (lQuebraOperacao .AND. cOperacao # Work1->WK_OPERACA)
         RETURN .t.
      ELSE
         RETURN .f.
      ENDIF
   EndIf   
ELSE
   IF (ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'Quebrou_NF'),)
   IF (ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'Quebrou_NF'),)   
   RETURN lQuebrou_NF
ENDIF

*-------------------------*
Function Di154CapQuebrou()  // Alex 11-05-2001  , Para que outras quebras possam ser feitas, via rdmake
*-------------------------*
PRIVATE lQuebra_Espe:=.F., lQuebrou_NF:=.F.

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'Outra_Quebra'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'Outra_Quebra'),)

IF ! lQuebra_Espe
   IF nNFE # Work1->WK_NFE  .OR. IF(nTipoNF <> 4, nSerie # Work1->WK_SE_NFE, .F.)
     RETURN .T.
   ELSE
     RETURN .F.
   ENDIF
ENDIF
     
RETURN lQuebrou_NF

*-----------------------*
//Atencao: Essa funcao eh chamada do EIDI554.PRW e do EICDI156.PRW
Function DI154CapNF()
*-----------------------*
LOCAL GRV,cChaveSF1
Private cMv_ESPEIC := IF(cPaisLoc='BRA' ,GetMv("MV_ESPEIC",,'NFE'),'NF') // SVG - 06/07/2010 - 
If nTipoNF # CUSTO_REAL
   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"ANTES_GRV_SF1"),) // SVG - 06/07/2010 - 
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"ANTES_GRV_SF1"),) // SVG - 06/07/2010 - 
   cChaveSF1:=nNFE+nSerie+SA2->A2_COD+SA2->A2_LOJA+IF(lTipoCompl,"C","N")  //nTipoNF=NFE_COMPLEMEN   Bete 24/11 - Trevo
   aCab := {}
// AADD(aCab,{"F1_TIPO"        ,IF(nTipoNF=NFE_COMPLEMEN,"C","N"),NIL})// TIPO DA NOTA - "N"ORMAL OU "C"OMPLEMENTAR
   AADD(aCab,{"F1_TIPO"        ,IF(lTipoCompl,"C","N"),NIL})// Bete 24/11 - Trevo
   AADD(aCab,{"F1_FORMUL"      ,cFormPro          ,NIL})   // FORMULARIO PROPRIO SIM OU NAO, CONF.OPCAO DO USUARIO
   AADD(aCab,{"F1_DOC"         ,nNFE              ,NIL})   // NUMERO DA NOTA
   AADD(aCab,{"F1_SERIE"       ,nSerie            ,NIL})   // SERIE DA NOTA
   AADD(aCab,{"F1_EMISSAO"     ,dDtNFE            ,NIL})   // DATA DA EMISSAO DA NOTA                                 
   AADD(aCab,{"F1_FORNECE"     ,SA2->A2_COD       ,NIL})   // FORNECEDOR  
   AADD(aCab,{"F1_LOJA"        ,SA2->A2_LOJA      ,NIL})   // LOJA DO FORNECEDOR 
   AADD(aCab,{"F1_ESPECIE"     ,cMv_ESPEIC        ,NIL})   // NOTA FISCAL DE ENTRADA // SVG - 06/07/2010 - 
   AADD(aCab,{"F1_DTDIGIT"     ,dDataBase         ,NIL})
//   AADD(aCab,{"F1_EST"         ,"EX"              ,NIL}) 
   AADD(aCab,{"F1_EST"         ,SA2->A2_EST       ,NIL}) // ISS - 09/05/11 
   AADD(aCab,{"F1_TIPODOC"     ,IF(lTipoCompl,"13","10"),NIL}) // nTipoNF=NFE_COMPLEMEN   Bete 24/11 - Trevo
   AADD(aCab,{"F1_TIPO_NF"     ,STR(nTipoNF,1,0)  ,NIL})
   AADD(aCab,{"F1_HAWB"        ,SW6->W6_HAWB      ,NIL})
   AADD(aCab,{"F1_PESOL"       ,nPesol            ,NIL})
   AADD(aCab,{"F1_FOB_R"       ,nValor            ,NIL})
   AADD(aCab,{"F1_FRETE"       ,nFrete            ,NIL})
   AADD(aCab,{"F1_SEGURO"      ,nSeguro           ,NIL})
   AADD(aCab,{"F1_CIF"         ,nCIF              ,NIL})
   AADD(aCab,{"F1_II"          ,nII               ,NIL})
   AADD(aCab,{"F1_IPI"         ,nIPI              ,NIL})
   AADD(aCab,{"F1_ICMS"        ,nICMS             ,NIL})
   AADD(aCab,{"F1_DESPESA"     ,nDespesa          ,NIL})
   AADD(aCab,{"F1_CTR_NFC"     ,cNotaGrupo        ,Nil})
   //JVR - 24/11/09
   AADD(aCab,{"F1_PLIQUI"     ,nPesol            ,Nil})//Peso Liquido
   AADD(aCab,{"F1_PBRUTO"     ,nPesoB            ,Nil})//Peso Bruto 
   AADD(aCab,{"F1_TRANSP"     ,SW6->W6_TRANS     ,Nil})//Transportadora
   //NCF - 22/10/2010 - Solicitado pela Microsiga
   If SA2->(FieldPos("A2_IMPIP")) <> 0 .And. SuperGetMV("MV_INTACD",.F.,"0") == "1"
       AADD(aCab,{"AUTIMPIP"     ,1     ,Nil})  // ACD
   EndIf

   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVACAO_SF1"),)
                                                 
   IF GETMV("MV_EASY",,"N")=="S"
      MSExecAuto({|x,y| MATA140(x,y)},aCab,aItens)
      IF lMSErroAuto           
         MostraErro()
         RETURN .F.
      ENDIF
      //FDR - 18/07/13
      IF GETMV("MV_TPNRNFS",,"1") == "2"
         ConfirmSX8()
      ENDIF                
      IF (nPos:=ASCAN(aCab,{ |A| A[1]="F1_EST" } )) # 0
         SF1->(DBSETORDER(1))
         IF SF1->(DBSEEK(xFilial("SF1")+cChaveSF1))
            SF1->(RecLock("SF1",.F.))
            FOR GRV := nPos TO LEN(aCab) 
                IF ( nPos:=SF1->( FIELDPOS(aCab[GRV,1]) ) ) # 0
                   SF1->( FIELDPUT(nPos,aCab[GRV,2]) )
                ENDIF
             NEXT
             IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRV_SF1"),)
             IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRV_SF1"),)
             SF1->(MsUnlock())
         ELSE         
             MSGSTOP(STR0038+": ["+cChaveSF1+"] "+STR0036,STR0022)
             lMSErroAuto:=.T.
         ENDIF
      ENDIF

   ELSE

      SF1->(RecLock("SF1",.T.))
      SF1->F1_FILIAL := xFilial("SF1")
      FOR GRV := 1 TO LEN(aCab) 
          IF ( nPos:=SF1->( FIELDPOS(aCab[GRV,1]) ) ) # 0
             SF1->( FIELDPUT(nPos,aCab[GRV,2]) )
          ENDIF
      NEXT
      // Bete - 03/04/08 
      IF SF1->(FIELDPOS("F1_CIMPORT")) # 0
         SF1->F1_CIMPORT := SW6->W6_IMPORT
      ENDIF

      If lTemDespBaseICM .AND. !lMV_EASYSIM //So grava F1_DESPICM se nao eh integrado com a Microsiga
         SF1->F1_DESPICM := nDespesaICM 
      EndIf
     
      IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRV_SF1"),)
      IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRV_SF1"),)
      SF1->(MsUnlock())
   ENDIF                  
Else
   EI1->(RecLock("EI1",.T.))
   EI1->EI1_FILIAL   := xFilial("EI1")
   EI1->EI1_CIF      := nCIF
   EI1->EI1_DOC      := nNFE
   EI1->EI1_SERIE    := nSerie    
   EI1->EI1_DTDIGI   := dDataBase
   EI1->EI1_DESPES   := nDespesa
   EI1->EI1_EMISSA   := dDtNFE
   EI1->EI1_FOB_R    := nValor
   EI1->EI1_FORNEC   := SA2->A2_COD
   EI1->EI1_FRETE    := nFrete
   EI1->EI1_HAWB     := SW6->W6_HAWB
   EI1->EI1_ICMS     := nICMS
   EI1->EI1_II       := nII
   EI1->EI1_IPI      := nIPI
   EI1->EI1_LOJA     := SA2->A2_LOJA
   EI1->EI1_PESOL    := nPesol
   EI1->EI1_SEGURO   := nSeguro
   EI1->EI1_TIPO_NF  := STR(nTipoNF,1,0)
   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRV_EI1"),)
   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRV_EI1"),)
   EI1->(MsUnlock())
Endif

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRAVA_SF1_EI1"),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRAVA_SF1_EI1"),)

RETURN .T.

*-----------------------------------------------*
Function DI154Delet()
*-----------------------------------------------*
LOCAL nCont:=0, lNFClassificada:=.F.,nOrdSF1:=SF1->(INDEXORD())
LOCAL aItem,aItens,aCab,aNotasCompDel   
//** ASK 20/08/2007 - Verifica se será possivel validar todas as notas fiscais (SIGAEIC X SIGACOM)
Local lMACanDelF1 := .T.

Local aOrdEIB:= {}
Local lTpOcor   := EDD->(FIELDPOS("EDD_CODOCO")) > 0 .And. EDD->(FIELDPOS("EDD_DESTIN")) > 0 //AOM - 22/06/2012 - Campos para gravação de Itens comprados na Anterioridade
Local dDtDigit 		:= dDataBase //TDF - 16/08/2012 - Ajuste com os novos campos de NFE

//DFS - 02/08/10 - Variáveis para novo tratamento de estorno das notas  
Local nHoras    := 0
Local nSpedExc  := GetNewPar("MV_SPEDEXC",72) 

PRIVATE cFilSF1:=xFILIAL("SF1")
PRIVATE cFilSD1:=xFILIAL("SD1")
PRIVATE lOk:=.T.

bForSWD:={|| AT(SWD->(LEFT(SWD->WD_DESPESA,1)),"129") = 0 .AND.;
             (EMPTY(cNota) .OR. cNota == SWD->WD_NF_COMP+SWD->WD_SE_NFC) }

bForNota:={ || SF1->(DBSEEK(cFilSF1+SD1->(D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA))) .AND.;
              (EMPTY(cNota) .OR. cNota == SF1->F1_CTR_NFC) }

lMV_EASYSIM:= GETMV("MV_EASY",,"N")=="S"

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'ANTES_ESTORNO_NOTA'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'ANTES_ESTORNO_NOTA'),)
IF !lOk
   RETURN .F.       
ENDIF    

lMSErroAuto := .F. 
lMSHelpAuto := .T.

IF nTipoNF # CUSTO_REAL

   ProcRegua(2)

   IncProc(STR0132) //"Verificando Processo, Aguarde..."
// SF1->(DBSETORDER(1))
// SD1->(DBSETORDER(8))
// SD1->(DBSEEK(xFilial("SD1")+SW6->W6_HAWB+STR(nTipoNF,1,0)))
// SD1->(DBEVAL({|| lNFClassificada := !EMPTY(SD1->D1_TES)} ,bForNota,;
//              {|| cFilSD1         == SD1->D1_FILIAL  .AND.;
//                  SD1->D1_CONHEC  == SW6->W6_HAWB    .AND.;
//                  SD1->D1_TIPO_NF == STR(nTipoNF,1,0).AND.;
//                  !lNFClassificada }))
// IF lNFClassificada
//    IncProc((STR0155)) //"Notas Fiscais nao pode serem estornadas"
//    Help("",1,"AVG0000808")//"Essa nota ja esta apropriada no SIGACOM"
//    RETURN .F.
// ENDIF

   If lIntDraw .and. cAntImp == "1" .AND. lExistEDD
      EDD->(dbSetOrder(2))
      If EDD->(dbSeek(xFilial("EDD")+SW6->W6_HAWB))
         Do While !EDD->(EOF()) .and. EDD->EDD_FILIAL==xFilial("EDD") .and. EDD->EDD_HAWB==SW6->W6_HAWB
            If (!Empty(EDD->EDD_PREEMB) .Or. !Empty(EDD->EDD_PEDIDO) .Or. (lTpOcor .And. !Empty(EDD->EDD_CODOCO)) ) //AOM - 23/11/2011 - Tratamento para considerar Vendas para exportadores.
               MsgInfo(STR0288)  //"Nota Fiscal não pode ser estornada pois tem itens ligados a REs de acordo com a anterioridade (Drawback)."
               EDD->(dbSetOrder(1))
               Return .F.
            EndIf
            EDD->(dbSkip())
         EndDo
      EndIf
   EndIf

   SF1->(DBSETORDER(5))
   SF1->(DBSEEK(cFilSF1+SW6->W6_HAWB+STR(nTipoNF,1,0)))
   SF1->(DBEVAL({||++nCont},,{||cFilSF1         == SF1->F1_FILIAL  .AND.;
                                SF1->F1_HAWB    == SW6->W6_HAWB    .AND.;
                                SF1->F1_TIPO_NF == STR(nTipoNF,1,0)}))

   //** ASK 20/08/2007 - Verifica se será possivel validar todas as notas fiscais (SIGAEIC X SIGACOM)
   // Só serão estornadas as notas no EIC se no SIGACOM forem estornadas todas as notas.
   If lMV_EASYSIM
      SF1->(DBSETORDER(5))
      SF1->(DBSEEK(cFilSF1+SW6->W6_HAWB+STR(nTipoNF,1,0)))
   
      Do While SF1->( !EoF()  .And. F1_FILIAL  == cFilSF1  ;
                      .And. F1_HAWB    == SW6->W6_HAWB     ;
                      .And. F1_TIPO_NF == STR(nTipoNF,1,0)    )
                      
         //*** Atenção - Manter este tratamento SEMPRE após o WHILE
         If !Empty(cNota)  .And.  cNota # SF1->F1_CTR_NFC
            SF1->( DbSkip() )
            Loop
         EndIf
         //***
         
         //TDF - 13/11/12 - Primeiro verifica se é possível estornar a nota no compras, depois faz o estorno no EIC.
         If Empty(SF1->F1_STATUS)
            lNFClassificada := .F.
         Else //Se a função MACanDelF1 retornar .T. em todas as notas, estornamos no EIC, caso contrário não estorna
            lMACanDelF1 := MACanDelF1(SF1->( RecNo() ),,,,,,.F.,,.T.)
            If !lMACanDelF1  //Se uma das notas retornar .F. não estorna nenhuma.
               Exit
             EndIf
         EndIf         
         
         //TDF - 16/08/2012 - Ajuste com os novos campos de NFE
         dDtdigit 	:= IIf(SF1->(FieldPos('F1_DTDIGIT'))>0 .And. !Empty(SF1->F1_DTDIGIT),SF1->F1_DTDIGIT,SF1->F1_EMISSAO)

         //TRP - 15/06/10 - Tratamento do estorno das notas que já foram transmitidas ao Sefaz. 
         //DFS - FNC: 000000116252010 - 02/08/10 - Ajuste no tratamento para estorno das notas
         If SF1->F1_FORMUL == "S" .And. "SPED"$ SF1->F1_ESPECIE .And. SF1->(FieldPos("F1_FIMP"))>0 .And. SF1->F1_FIMP$"TS" //verificacao apenas da especie como SPED e notas que foram transmitidas ou impressoo DANFE
            //TDF - 08/08/12 - Ajuste com os novos campos de NFE
            nHoras := SubtHoras(IIF(SF1->(FieldPos("F1_DAUTNFE"))<>0 .And. !Empty(SF1->F1_DAUTNFE),SF1->F1_DAUTNFE,dDtdigit),IIF(SF1->(FieldPos("F1_HAUTNFE"))<>0 .And. !Empty(SF1->F1_HAUTNFE),SF1->F1_HAUTNFE,SF1->F1_HORA), dDataBase, substr(Time(),1,2)+":"+substr(Time(),4,2) )
            If nHoras > nSpedExc .And. SF1->F1_STATUS<>"C"
               MsgAlert(STR0368 + Alltrim(STR(nSpedExc)) +STR0369) //STR0368 "Não foi possivel excluir a(s) nota(s), pois o prazo para o cancelamento da(s) NF-e é de " //STR0369 " horas"
	           Return .T.
            Else	
               If !MsgYesNo(STR0306)
                  Return .T.
               EndIf
            EndIf
         EndIf     
         //DFS - FNC: 000000116252010 - 02/08/10 - Fim do tratamento 

         
         SF1->( DBSkip() )
      EndDo
   EndIf
   //**

   ProcRegua(nCont+3)

   IncProc(STR0157) //"Estornando Nota Fiscal"

   SD1->(DBSETORDER(1))
   SF1->(DBSETORDER(5))

   If lMACanDelF1 //ASK 20/08/2007 - Retorno da função MACanDelF1

      Begin Transaction
		 lPerg := .F.
		 lResp := .F.
         aItens:={}
         aNotasCompDel:={}
         SF1->(DBSEEK(cFilSF1+SW6->W6_HAWB+STR(nTipoNF,1,0)))
       
         DO WHILE SF1->(!EOF())                   .AND.;
            SF1->F1_FILIAL  == cFilSF1         .AND.;
            SF1->F1_HAWB    == SW6->W6_HAWB    .AND.;
            SF1->F1_TIPO_NF == STR(nTipoNF,1,0)
    
            IncProc(STR0157) //"Estornando Nota Fiscal"

            IF !EMPTY(cNota) .AND. cNota # SF1->F1_CTR_NFC
               SF1->(DBSKIP())
            LOOP
            ENDIF

            IF EMPTY(SF1->F1_STATUS)
               lNFClassificada := .F.
            ELSE
               lNFClassificada := .T.
            ENDIF

            IF Existblock("EICPDI01")
               IF !ExecBlock("EICPDI01",.F.,.F.,"ESTORNO NA NOTA")
               LOOP
               ENDIF
            ENDIF
            lOk:=.T.
            IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'ESTORNO NA NOTA'),)
      
            IF !lOk
               LOOP
            ENDIF      
            //RHP
            SD1->(DBSEEK(xFilial("SD1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA))

            DO WHILE SD1->(!EOF())                 .AND.;
               SD1->D1_FILIAL == xFilial("SD1") .AND.;
               SD1->D1_DOC    == SF1->F1_DOC    .AND.;
               SD1->D1_SERIE  == SF1->F1_SERIE  .AND.;
               SD1->D1_FORNECE== SF1->F1_FORNECE.AND.;
               SD1->D1_LOJA   == SF1->F1_LOJA
   
               IF SD1->D1_TIPO_NF # STR(nTipoNF,1,0) .OR. SD1->D1_CONHEC  # SW6->W6_HAWB
                  SD1->(DBSKIP())
               LOOP
               ENDIF
       
               IF lMV_EASYSIM
                  aItem:={}
                  AADD(aItem,{"D1_DOC"    ,SD1->D1_DOC    ,NIL})
                  AADD(aItem,{"D1_SERIE"  ,SD1->D1_SERIE  ,NIL})
                  AADD(aItem,{"D1_FORNECE",SD1->D1_FORNECE,NIL})
                  AADD(aItem,{"D1_LOJA"   ,SD1->D1_LOJA   ,NIL})
                  AADD(aItens,ACLONE(aItem))
               ELSE    
                  SD1->(RecLock("SD1",.F.,.T.))
                  SD1->(DBDELETE())
                  SD1->(MsUnlock())
               ENDIF
               SD1->(DbSkip())
   
            ENDDO
      
            If lIntDraw .and. cAntImp == "1" .AND. lExistEDD
              EDD->(dbSetOrder(2))
            EndIf

            AADD(aNotasCompDel,SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA)

            IF lMV_EASYSIM
               aCab := {}
               AADD(aCab,{"F1_DOC"    ,SF1->F1_DOC    ,NIL})   // NUMERO DA NOTA
               AADD(aCab,{"F1_SERIE"  ,SF1->F1_SERIE  ,NIL})   // SERIE DA NOTA
               AADD(aCab,{"F1_FORNECE",SF1->F1_FORNECE,NIL})   // FORNECEDOR  
               AADD(aCab,{"F1_LOJA"   ,SF1->F1_LOJA   ,NIL})   // LOJA DO FORNECEDOR 
               AADD(aCab,{"F1_TIPO"   ,SF1->F1_TIPO   ,NIL})   // TIPO DA NF
               nRecno:=SF1->(RECNO())
               IF lNFClassificada
                  MSExecAuto({|x,y,z| MATA103(x,y,z)},aCab,aItens,20)
               ELSE
                  MSExecAuto({|x,y,z| MATA140(x,y,z)},aCab,aItens,5)
               ENDIF
               SF1->(DBGOTO(nRecno))
               IF lMSErroAuto           
                  EXIT
               ENDIF
            ELSE
               SF1->(RecLock("SF1",.F.,.T.))
               SF1->(DBDELETE())
               SF1->(MsUnlock())
            ENDIF
            
            //WFS 18/11/2008 - Tratamento para a NFe ---
            //Armazenamento da nota fiscal estornada na tabela EIX         
            If GetMv("MV_REAPNNF",,.F.)
               SWN->(DBSetOrder(1))
               SWN->(DBGoTop())
               If (SWN->(DBSeek(xFilial("SWN") + SF1->F1_DOC + SF1->F1_SERIE)) .And. SWN->(FieldPos("WN_INTDESP")) > 0)
                  If SWN->WN_INTDESP == "S"
                     IF !lPerg
						lResp := MsgYesNo(STR0370) //STR0370 "As notas deste processo foram rejeitada pela Sefaz?"
						lPerg := .T.
					 ENDIF
					 IF lResp
                        EIX->(Reclock("EIX", .T.))
                        EIX->EIX_HAWB  := SF1->F1_HAWB
                        EIX->EIX_TIPONF:= SF1->F1_TIPO_NF
                        EIX->EIX_DOC   := SF1->F1_DOC
                        EIX->EIX_SERIE := SF1->F1_SERIE
                        EIX->EIX_FORN  := SF1->F1_FORNECE
                        EIX->EIX_LOJA  := SF1->F1_LOJA
                        EIX->EIX_EMISSA:= SF1->F1_EMISSAO
                        EIX->(MsUnlock())
                     EndIf
                  EndIf
               EndIf
            EndIf
            //WFS ---
   
            SF1->(DbSkip())

         ENDDO

         IF !lMSErroAuto

            IncProc(STR0157) //"Estornando Nota Fiscal"

            nTotNFC := 0
            SWN->(DBSETORDER(3))
            IF SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB+STR(nTipoNF,1,0))) .AND. !lMSErroAuto
 	  	       DO WHILE SWN->(!EOF())                   .AND.;
		          SWN->WN_FILIAL == xFilial("SWN").AND.;
      	 	      SWN->WN_HAWB   == SW6->W6_HAWB  .AND.;
             	   SWN->WN_TIPO_NF== STR(nTipoNF,1,0)
      	           IF ASCAN(aNotasCompDel,SWN->WN_DOC+SWN->WN_SERIE+SWN->WN_FORNECE+SWN->WN_LOJA) = 0
	   	          // Bete 10/08/05 - soma os valores das demais notas complementares
			         If lTipoCompl
		   	            nTotNFC := nTotNFC + SWN->WN_VALOR
      		      	  EndIf
   
   	               SWN->(DBSKIP())
   	         	   LOOP
	   	           ENDIF

         	      If lIntDraw .and. cAntImp == "1" .and. SWN->WN_TIPO_NF $ "1/3/5" .and. lExistEDD
    	             DIGrvAnt(2,SWN->WN_HAWB,SWN->WN_PO_EIC,SWN->WN_INVOICE,SWN->WN_PRODUTO,SWN->WN_ITEM,SWN->WN_PGI_NUM)
        	      EndIf
         
   			      SWN->(RecLock("SWN",.F.,.T.))
                  If lMV_EASYSIM .AND. nTipoNF # NFE_COMPLEMEN     // Bete 24/11 falta analisar p/ Trevo
      	      	      MaAvalPC("SC7",11) // Edu -> Cancela a baixa o Pedido de Compra feito até a versão 6.09
                  EndIf
   	              SWN->(DBDELETE())
                  SWN->(MsUnlock())
                  SWN->(DbSkip())
               ENDDO        
   	           If lIntDraw .and. cAntImp == "1" .AND. lExistEDD
      	          EDD->(dbSetOrder(1))
               EndIf
   	        ENDIF   
   
            SW6->(RecLock("SW6",.F.))
      
            //If nTipoNF==NFE_PRIMEIRA .OR. nTipoNF==NFE_UNICA
            If lAtuSW6NFE     // Bete 24/11 - Trevo
               SW6->W6_NF_ENT  :=""
               SW6->W6_SE_NF   :=""
               SW6->W6_DT_NF   :=AVCTOD("")
               SW6->W6_VL_NF   :=0
               SW6->W6_DT_ENTR :=AVCTOD("")
            Endif
               
      //    IF nTipoNF==NFE_COMPLEMEN .OR. nTipoNF==NFE_UNICA
            IF nTipoNF # CUSTO_REAL  // AWR - 26/05/2004
//             If nTipoNF==NFE_COMPLEMEN
               If lTipoCompl  // Bete 24/11 - Trevo
                  SF1->(DBSETORDER(5))
                  IF SF1->(DBSEEK(cFilSF1+SW6->W6_HAWB+STR(nTipoNF,1,0)))
                     SW6->W6_NF_COMP:=SF1->F1_DOC
                     SW6->W6_SE_NFC :=SF1->F1_SERIE
                     SW6->W6_DT_NFC :=SF1->F1_EMISSAO
                     SW6->W6_VL_NFC :=nTotNFC
                  ELSE
                     SW6->W6_NF_COMP:=""
                     SW6->W6_SE_NFC :=""
                     SW6->W6_DT_NFC :=AVCTOD("")
                     SW6->W6_VL_NFC :=0
                  ENDIF
               ENDIF
          
               SWD->(DBSEEK(xFilial("SWD")+SW6->W6_HAWB))
               DO WHILE SWD->(!EOF())              .AND.;
                  SWD->WD_FILIAL==xFilial("SWD").AND.;
                  SWD->WD_HAWB  == SW6->W6_HAWB
                  //NCF - 13/09/2010 - Para apagar o número na nota quando é imposto integrado pelo despachante
                  //TDF - 06/01/2010 - Revisão do tratamento para gravar o número da nota
                  IF SYB->(DbSeek(xFilial("SYB")+SWD->WD_DESPESA )) .AND. (LEFT(SWD->WD_DESPESA,1) $ "12") .AND. !lTipoCompl//SWD->WD_INTEGRA
                     SWD->(RecLock("SWD",.F.))
                     SWD->WD_NF_COMP := ""
                     SWD->WD_SE_NFC  := ""
                     SWD->(MsUnlock())      
                  ENDIF
                  IF EVAL(bForSWD)//AT(SWD->(LEFT(SWD->WD_DESPESA,1)),"129")=0.AND.cNota = SWD->WD_NF_COMP+SWD->WD_SE_NFC
                     SWD->(RecLock("SWD",.F.))
                     SWD->WD_NF_COMP:=""
                     SWD->WD_SE_NFC :=""
                     SWD->WD_DT_NFC :=AVCTOD("")
                     SWD->WD_VL_NFC :=0
                     IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"LIMPA_SWD"),)
                     SWD->(MsUnlock())
                  ENDIF
              
                  IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"WHILE_SWD"),)

                  SWD->(DBSKIP())
               ENDDO

            ENDIF

            SW6->(MsUnlock())
   
   	        SWW->(DBSETORDER(2))
            IF SWW->(DBSEEK(Xfilial("SWW")+SW6->W6_HAWB+STR(nTipoNF,1,0))) .AND. !lMSErroAuto
      	       DO WHILE !SWW->(EOF())                    .AND.;
   	                     SWW->WW_FILIAL == xFilial("SWW").AND.;
      	                 SWW->WW_HAWB   == SW6->W6_HAWB  .AND.;
         	             SWW->WW_TIPO_NF== STR(nTipoNF,1,0)
                         
               	   IF ASCAN(aNotasCompDel,SWW->WW_NF_COMP+SWW->WW_SE_NFC+SWW->WW_FORNECE+SWW->WW_LOJA) = 0
               	      SWW->(DBSKIP())
               	      LOOP
            	   ENDIF

	              SWW->(RecLock("SWW",.F.,.T.))
    	          SWW->(DBDELETE())
                  SWW->(MsUnlock())
         	      SWW->(DbSkip())
	           ENDDO
            ENDIF
   
            //Bete - 25/07/04 - Estorna os registros referente a acrescimo e deducoes no arquivo EIU
            IF lAcresDeduc .AND. !lMSErroAuto
               IF EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0))) 
                  DO WHILE !EIU->(eof()) .AND. EIU->EIU_HAWB == SW6->W6_HAWB .AND. EIU->EIU_TIPONF == STR(nTipoNF,1,0) 
                     EIU->(RecLock("EIU",.F.,.T.))
                     EIU->(DBDELETE())
                     EIU->(MsUnlock())      
                     EIU->(dbSkip())
                  ENDDO
               ENDIF
            ENDIF
            
            IF !lMSErroAuto
               IF !lEIB_Processa//FDR - 18/08/13 
                  aOrdEIB:= SaveOrd({"EIB"})
                  EIB->(DbSetOrder(1))
                  IF EIB->(DBSEEK(xFilial("EIB")+SW6->W6_HAWB)) 
                     DO WHILE !EIB->(eof()) .AND. EIB->EIB_HAWB == SW6->W6_HAWB  
                        EIB->(RecLock("EIB",.F.,.T.))
                        EIB->(DBDELETE())
                        EIB->(MsUnlock())      
                        EIB->(dbSkip())
                     ENDDO
                  ENDIF
                  RestOrd(aOrdEIB,.T.)
               ENDIF
            ENDIF
            
            IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'APOS_ESTORNO'),)
      
         ENDIF

      End Transaction
   Else //Se lMACanDelF1 for .F. //ASK 21/08/2007
      MsgStop(STR0291,STR0292)//"Não foi possível o Estorno de uma ou mais notas no módulo de Compras.","Favor Verificar!"
   EndIf

ELSE //Se nTipoNF for CUSTO_REAL

   ProcRegua(2)

   EI1->(DBSETORDER(1))
   EI1->(DBSEEK( xFilial("EI1") + SW6->W6_HAWB ))
   
   IncProc(STR0158) //"Estornando Custo..."

   EI1->(DBEVAL({||++nCont},,{||xFilial("EI1") == EI1->EI1_FILIAL .AND.;
                                EI1->EI1_HAWB  == SW6->W6_HAWB}))

   IncProc(STR0158) //"Estornando Custo..."

   ProcRegua(nCont+3)

   EI1->(DBSEEK( xFilial("EI1") + SW6->W6_HAWB ))

Begin Transaction

   DO WHILE ! EI1->(EOF())                      .AND.;
              EI1->EI1_FILIAL == xFilial("EI1") .AND.;
              EI1->EI1_HAWB   == SW6->W6_HAWB

      IncProc(STR0158) //"Estornando Custo..."

      IF EI1->EI1_TIPO_NF # STR( nTipoNF,1, 0 )
         EI1->(DBSKIP())
         LOOP
      ENDIF

      EI1->(RecLock("EI1",.F.,.T.))
      EI1->(DBDELETE())
      EI1->(MsUnlock())
      EI1->(DbSkip())

   ENDDO

   EI2->(DBSETORDER(1))
   EI2->(DBSEEK(xFilial("EI2")+SW6->W6_HAWB))
   IncProc(STR0158) //"Estornando Custo..."

   DO WHILE ! EI2->(EOF())                      .AND.;
              EI2->EI2_FILIAL == xFilial("EI2") .AND.;
              EI2->EI2_HAWB   == SW6->W6_HAWB

      IF EI2->EI2_TIPO_NF # STR( nTipoNF,1, 0 )
         EI2->(DBSKIP())
         LOOP
      ENDIF
      EI2->(RecLock("EI2",.F.,.T.))
      EI2->(DBDELETE())
      EI2->(MsUnlock())
      EI2->(DbSkip())
   ENDDO

   EI3->(DBSETORDER(1))
   EI3->(DBSEEK( xFilial("EI3") + SW6->W6_HAWB ))
   IncProc(STR0158) //"Estornando Custo..."

   DO WHILE ! EI3->(EOF())                      .AND.;
              EI3->EI3_FILIAL == xFilial("EI3") .AND.;
              EI3->EI3_HAWB   == SW6->W6_HAWB

      IF EI3->EI3_TIPO_NF # STR( nTipoNF,1, 0 )
         EI3->(DBSKIP())
         LOOP
      ENDIF

      EI3->(RecLock("EI3",.F.,.T.))
      EI3->(DBDELETE())
      EI3->(MsUnlock())
      EI3->(DbSkip())
   ENDDO

   SWW->(DBSETORDER(2))
   IF SWW->(DBSEEK(Xfilial("SWW")+SW6->W6_HAWB+STR(nTipoNF,1,0)))
      DO WHILE !SWW->(EOF())                    .AND.;
                SWW->WW_FILIAL == xFilial("SWW").AND.;
                SWW->WW_HAWB   == SW6->W6_HAWB  .AND.;
                SWW->WW_TIPO_NF== STR(nTipoNF,1,0)

         SWW->(RecLock("SWW",.F.,.T.))
         SWW->(DBDELETE())
         SWW->(MsUnlock())
         SWW->(DbSkip())
      ENDDO
   ENDIF
   
   //Bete - 25/07/04 - Estorna os registros referente a acrescimo e deducoes no arquivo EIU
   IF lAcresDeduc
      IF EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0))) 
         DO WHILE !EIU->(eof()) .AND. EIU->EIU_HAWB == SW6->W6_HAWB .AND. EIU->EIU_TIPONF == STR(nTipoNF,1,0) 
            EIU->(RecLock("EIU",.F.,.T.))
            EIU->(DBDELETE())
            EIU->(MsUnlock())      
            EIU->(dbSkip())
         ENDDO
      ENDIF
   ENDIF
   
// ISS - 13/04/10 - Ponto de entrada criado após que o estorno foi feito. Chamado(081437)
   If ExistBlock("EICDI154")
      Execblock("EICDI154",.F.,.F.,"FIM_ESTORNO")
   EndIf

End Transaction

ENDIF

//FDR - 12/04/2013
If ExistBlock("EICDI154")
   Execblock("EICDI154",.F.,.F.,"ESTORNO_NF")
EndIf

SF1->(DBSETORDER(nOrdSF1))
SWN->(DBSETORDER(1))
SWW->(DBSETORDER(1))

IncProc() //100%

IF lMSErroAuto
   MostraErro()
   RETURN .F.
ENDIF

RETURN .T.

*-------------------------*
Function DITrans(nVal,nDec)
*-------------------------*
IF cPaisLoc # "BRA"
   Return ROUND(nVal,nDecPais)
ENDIF
Return VAL(STR(nVal,30,nDec))

*---------------------------------------------------------------------*
Function DI154LeEIB(lPergunta)
*---------------------------------------------------------------------*
LOCAL nLin:=0,oDlg
LOCAL cSimT:=STR0261,cNaoT:=STR0262      //"1-Sim"###"2-Não"
LOCAL nSNAliq:=cSimT  ,nSNPeso:=cSimT , nSNAcreDedu:=cSimT
LOCAL cFindEIB := SW6->W6_HAWB + Work2->WKADICAO + Work2->&(cIndice)

IF !lEIB_Processa 
   RETURN .F.
ENDIF   

EIB->(DBSETORDER(1))

IF lPergunta

   IF EIB->(DBSEEK(xFilial("EIB")+cFindEIB))

      DEFINE MSDIALOG oDlg FROM  0,0 TO 11,48 TITLE STR0263 OF oMainWnd //"Recuperar Alterações"

       @ 001,002 TO 080,188 LABEL "" OF oDlg PIXEL
   
       nLin:=10
       @ nLin,010 SAY STR0264  SIZE 100,8 OF oDlg PIXEL //"Recuperar alíquotas já gravadas? "
                @ nLin,150 COMBOBOX nSNAliq     ITEMS {cSimT,cNaoT}         SIZE 35,40 OF oDlg PIXEL

       nLin:=nLin+20
       @ nLin,010 SAY STR0265      SIZE 100,8 OF oDlg PIXEL //"Recuperar Pesos já gravadas? "
                @ nLin,150 COMBOBOX nSNPeso     ITEMS {cSimT,cNaoT}         SIZE 35,40 OF oDlg PIXEL      
       
       nLin:=nLin+20
       @ nLin,010 SAY STR0320      SIZE 120,8 OF oDlg PIXEL //"Recuperar Acréscimos e Deduções já gravadas?"    
                @ nLin,150 COMBOBOX nSNAcreDedu     ITEMS {cSimT,cNaoT}         SIZE 35,40 OF oDlg PIXEL
   
       DEFINE SBUTTON FROM 066,126 TYPE 1 ACTION (oDlg:End()) ENABLE    OF oDlg PIXEL
   
      ACTIVATE MSDIALOG oDlg CENTERED

      nSNAliq:=VAL(LEFT(nSNAliq,1))
      nSNPeso:=VAL(LEFT(nSNPeso,1))
      nSNAcreDedu:=VAL(LEFT(nSNAcreDedu,1))      
      IF nSNAliq == 1 .OR. nSNPeso == 1 .Or. nSNAcreDedu == 1
         Processa({||DI154ProcEIB(.F.,nSNAliq,nSNPeso,nSNAcreDedu)},STR0266) //"Lendo Valores Gravados"
      ENDIF
   ENDIF
ELSE
   Processa({||DI154ProcEIB(.T.)},STR0267) //"Gravando Valores Alterados"
ENDIF

RETURN .T.
*---------------------------------------------------------------------*
Function DI154ProcEIB(lGrava,nSNAliq,nSNPeso,nSNAcreDedu)
*---------------------------------------------------------------------*
LOCAL nCont:=0, nFatorFrete:=1,lExistiaReg:=.F.,cFil:=xFilial("EIB") 
LOCAL nRecnoWK1:= 0

IF !lEIB_Processa .OR. (lGrava .AND. !lAlterouAliquotas)  
   RETURN .F.
ENDIF   

DBSELECTAREA("EIB")
DBSETORDER(1)             
//Work1->(DBSETORDER(1))
Work1->(DBSETORDER(6))
lExistiaReg:=EIB->(DBSEEK(xFilial("EIB")+SW6->W6_HAWB))
ProcRegua(Work2->(LASTREC()))
Work2->(DBGOTOP())

BEGIN TRANSACTION

DO WHILE Work2->(!EOF())
   
   IncProc(STR0268+' '+Work2->WKTEC) //"Processando NCM: "
   
   IF lGrava
      nCont++
      IF EIB->(DBSEEK(xFilial("EIB")+SW6->W6_HAWB+Work2->WKADICAO+IF(lEIB_Chave,Work2->&(cindice),"") )) //CCH - 10/08/09 - Compatibilizado conforme versão 8.11
         EIB->(RECLOCK("EIB",.F.))
         EIB->EIB_PESO  :=Work2->WKPESOL    
         EIB->EIB_PERII :=Work2->WKII_A     
         EIB->EIB_PERIPI:=Work2->WKIPI_A    
         EIB->EIB_PERICM:=Work2->WKICMS_A
         IF EIB->(FIELDPOS("EIB_VLACRE")) # 0 .AND. EIB->(FIELDPOS("EIB_VLDEDU")) # 0  //NCF - Gravação dos valores de Acrescimos e Deduções
            EIB->EIB_VLACRE := Work2->WKVLACRES
            EIB->EIB_VLDEDU := Work2->WKVLDEDUC
         ENDIF              
         EIB->EIB_FILLER:="ALTERADO"          
         IF lEIB_Chave 
           EIB->EIB_CHAVE := SW6->W6_HAWB + Work2->WKADICAO + Work2->&(cIndice)
         ENDIF  
         IF lMV_PIS_EIC .AND. EIB->(FIELDPOS("EIB_PERPIS")) # 0
            EIB->EIB_VLUPIS:=Work2->WKVLUPIS
            EIB->EIB_VLUCOF:=Work2->WKVLUCOF
            EIB->EIB_PERPIS:=Work2->WKPERPIS
            EIB->EIB_PERCOF:=Work2->WKPERCOF
            //TRP - 03/03/2010
            IF EIB->(FIELDPOS("EIB_REDPIS")) # 0  .AND. Work2->WKREG_PC = "4"
               EIB->EIB_REDPIS:=Work2->WKREDPIS 
            ENDIF
            IF EIB->(FIELDPOS("EIB_REDCOF")) # 0  .AND. Work2->WKREG_PC = "4"
               EIB->EIB_REDCOF:=Work2->WKREDCOF
            ENDIF
         ENDIF
         EIB->(MSUNLOCK())
      ELSE                                  
         EIB->(RECLOCK("EIB",.T.))          
         EIB->EIB_FILIAL:=xFilial("EIB")    
         EIB->EIB_HAWB  :=SW6->W6_HAWB      
         EIB->EIB_POSIPI:=Work2->WKTEC      
         EIB->EIB_EX_NCM:=Work2->WKEX_NCM
         EIB->EIB_EX_NBM:=Work2->WKEX_NBM
         EIB->EIB_PESO  :=Work2->WKPESOL    
         EIB->EIB_PERII :=Work2->WKII_A     
         EIB->EIB_PERIPI:=Work2->WKIPI_A    
         EIB->EIB_PERICM:=Work2->WKICMS_A   
         EIB->EIB_CFO   :=Work2->WK_CFO      
         EIB->EIB_OPERA :=Work2->WK_OPERACA 
         IF EIB->(FIELDPOS("EIB_VLACRE")) # 0 .AND. EIB->(FIELDPOS("EIB_VLDEDU")) # 0  //NCF - Gravação dos valores de Acrescimos e Deduções
            EIB->EIB_VLACRE := Work2->WKVLACRES
            EIB->EIB_VLDEDU := Work2->WKVLDEDUC
         ENDIF                         
         IF lEIB_Chave 
            EIB->EIB_CHAVE :=SW6->W6_HAWB + Work2->WKADICAO + Work2->&(cIndice)
         ENDIF  
         IF(lExistiaReg,EIB->EIB_FILLER:="INCLUIDO",)
         IF lMV_PIS_EIC .AND. EIB->(FIELDPOS("EIB_PERPIS")) # 0
            EIB->EIB_VLUPIS:=Work2->WKVLUPIS
            EIB->EIB_VLUCOF:=Work2->WKVLUCOF
            EIB->EIB_PERPIS:=Work2->WKPERPIS
            EIB->EIB_PERCOF:=Work2->WKPERCOF
            //TRP - 03/03/2010
            IF EIB->(FIELDPOS("EIB_REDPIS")) # 0 .AND. Work2->WKREG_PC = "4"
               EIB->EIB_REDPIS:=Work2->WKREDPIS 
            ENDIF
            IF EIB->(FIELDPOS("EIB_REDCOF")) # 0 .AND. Work2->WKREG_PC = "4"
               EIB->EIB_REDCOF:=Work2->WKREDCOF
            ENDIF
         ENDIF
         EIB->(MSUNLOCK())                  
      ENDIF
      
      IF SELECT("Work_EIU") > 0 .AND. Work_EIU->(RecCount()) > 0              //NCF - 23/09/2010 - INI
         Work_EIU->(DbGoTop())
         Work_EIU->(DbSeek(Work2->WKADICAO))
         IF !EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0)+Work2->WKADICAO))
            DO WHILE !Work_EIU->(eof()) .And. Work_EIU->EIU_ADICAO == Work2->WKADICAO            
               EIU->(RecLock("EIU",.T.))
               EIU->EIU_FILIAL := xFilial("EIU")
               EIU->EIU_HAWB   := SW6->W6_HAWB
               EIU->EIU_TIPONF := STR(nTipoNF,1)
               EIU->EIU_TIPO   := Work_EIU->EIU_TIPO
               EIU->EIU_ADICAO := Work_EIU->EIU_ADICAO
               EIU->EIU_CODIGO := Work_EIU->EIU_CODIGO
               EIU->EIU_VALOR  := Work_EIU->EIU_VALOR
               EIU->(MsUnlock())              
               Work_EIU->(dbSkip())
            ENDDO 
         ENDIF         
      ENDIF                                                                   //NCF - 23/09/2010 - FIM
                                       
   ELSE                                     
      IF EIB->(DBSEEK(xFilial("EIB")+SW6->W6_HAWB + Work2->WKADICAO + IF(lEIB_Chave,Work2->&(cindice),"")))
         IF nSNAliq == 1
            Work2->WKII_A  := EIB->EIB_PERII  
            Work2->WKIPI_A := EIB->EIB_PERIPI 
            Work2->WKICMS_A:= EIB->EIB_PERICM
            IF lMV_PIS_EIC .AND. EIB->(FIELDPOS("EIB_PERPIS")) # 0
               Work2->WKVLUPIS:=EIB->EIB_VLUPIS
               Work2->WKVLUCOF:=EIB->EIB_VLUCOF 
               Work2->WKPERPIS:=EIB->EIB_PERPIS
               Work2->WKPERCOF:=EIB->EIB_PERCOF
               //TRP - 03/03/2010
               IF EIB->(FIELDPOS("EIB_REDPIS")) # 0 .AND. Work2->WKREG_PC = "4"
                  Work2->WKREDPIS:=EIB->EIB_REDPIS
               ENDIF
               IF EIB->(FIELDPOS("EIB_REDCOF")) # 0 .AND. Work2->WKREG_PC = "4"
                  Work2->WKREDCOF:=EIB->EIB_REDCOF
               ENDIF
            ENDIF
            lAliqEIB:= .T.
         ENDIF
         //SVG - 13/07/2011 - Gravação dos valores de Acrescimos e Deduções
         If nSNAcreDedu == 1
            If EIB->(FIELDPOS("EIB_VLACRE")) # 0 .AND. EIB->(FIELDPOS("EIB_VLDEDU")) # 0   //NCF - Gravação dos valores de Acrescimos e Deduções
               Work2->WKVLACRES := EIB->EIB_VLACRE
               Work2->WKVLDEDUC := EIB->EIB_VLDEDU 
            EndIf
         EndIf            
         IF nSNPeso == 1
            MDI_PESO       -= Work2->WKPESOL
            MDI_PESO       += EIB->EIB_PESO
            nFatorFrete    := EIB->EIB_PESO / Work2->WKPESOL
            Work2->WKPESOL := EIB->EIB_PESO
            //Work1->(DBSEEK(EVAL(bSeekWk1)))  Bete - controle por adição
            //DO WHILE Work1->(!EOF()) .AND. EVAL(bWhileWk)  Bete - controle por adição
            nRecnoWK1:= WORK1->(RECNO())
            Work1->(DBSEEK(Work2->WKADICAO))
            DO WHILE Work1->(!EOF()) .AND. Work1->WKADICAO == Work2->WKADICAO
               Work1->WKPESOL := Work1->WKPESOL * nFatorFrete
               Work1->(DBSKIP())
            ENDDO
            WORK1->(DBGOTO(nRecnoWK1))
         ENDIF
      ENDIF
      
      IF SELECT("Work_EIU") > 0 //.AND. Work_EIU->(RecCount()) == 0                        //NCF - 23/09/2010 - INI     
         EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0)+Work2->WKADICAO))         
         DO WHILE !EIU->(Eof()) .And. EIU->EIU_HAWB == SW6->W6_HAWB .And. EIU->EIU_TIPONF == STR(nTipoNF,1,0) .And. EIU->EIU_ADICAO == Work2->WKADICAO         
            Work_EIU->(DBAppend())
            Work_EIU->EIU_HAWB  := EIU->EIU_HAWB
            Work_EIU->EIU_TIPONF:= EIU->EIU_TIPONF
            Work_EIU->EIU_TIPO  := EIU->EIU_TIPO
            Work_EIU->EIU_ADICAO:= EIU->EIU_ADICAO
            Work_EIU->EIU_CODIGO:= EIU->EIU_CODIGO
            Work_EIU->EIU_VALOR := EIU->EIU_VALOR
            Work_EIU->EIU_DESC  := Posicione("SJN",1,xFilial("SJN")+EIU->EIU_CODIGO,"JN_DESC")                
            EIU->(dbSkip())
         ENDDO      
      ENDIF                                                                   //NCF - 23/09/2010 - FIM
      
   ENDIF
   Work2->(DBSKIP())
ENDDO
   
IF lGrava .AND. lExistiaReg
   ProcRegua(nCont)
   EIB->(DBSEEK(cFil+SW6->W6_HAWB))
   DO WHILE EIB->EIB_HAWB  ==SW6->W6_HAWB .AND. EIB->(!EOF()).AND.;
            EIB->EIB_FILIAL==cFil          
            
      EIB->(RECLOCK("EIB",.F.))
      IF !EMPTY(EIB->EIB_FILLER)
         IncProc(STR0268+' '+EIB->EIB_POSIPI) //"Processando NCM: "
         EIB->EIB_FILLER:=""
         EIB->(MSUNLOCK())                  
      ELSE
         EIB->(DBDELETE())                  
      ENDIF
      EIB->(DBSKIP())
   ENDDO
ENDIF

END TRANSACTION

RETURN .T.

*---------------------------------------------------------------------*
Function DI154MsgDif(lBox,nDI,nNBM,cTit,cMsg)
*---------------------------------------------------------------------*
LOCAL  lRet:=.F.,cObs:="",nLin:=0,oDlg, nOpc1:=0
STATIC cObsII,cObsIPI,cObsICMS,cObsPIS,cObsCOF
DEFAULT cMsg := ""
DEFAULT cTit := ""
DEFAULT nDI  := 0
DEFAULT nNBM := 0

IF !lBox

   IF VAL(STR(nDI,18,2)) # VAL(STR(nNBM,18,2))
          cObs:=cTit+STR0269+AllTrim(TRANS(nDI ,"@E 99,999,999,999,999.99"))+; //" informado (R$ "
                 STR0270+AllTrim(TRANS(nNBM,"@E 99,999,999,999,999.99"))+")" //") difere do calculado (R$ "
          lRet:=.T.
   ENDIF
          
   IF(!EMPTY(cMsg),cObs:=cMsg,)
   
   DO CASE
      CASE cTit == "I.I."     ;  cObsII   := cObs
      CASE cTit == "I.P.I."   ;  cObsIPI  := cObs
      CASE cTit == "I.C.M.S." ;  cObsICMS := cObs
      CASE cTit == "PIS"      ;  cObsPIS  := cObs
      CASE cTit == "COFINS"   ;  cObsCOF  := cObs
   ENDCASE

ELSEIF (cObsII   # NIL .AND. !EMPTY(cObsII  )) .OR.;
       (cObsIPI  # NIL .AND. !EMPTY(cObsIPI )) .OR.;
       (cObsPIS  # NIL .AND. !EMPTY(cObsPIS )) .OR.;
       (cObsCOF  # NIL .AND. !EMPTY(cObsCOF )) .OR.;
       (cObsICMS # NIL .AND. !EMPTY(cObsICMS)) 

   IF cPaisLoc # "BRA"                       
      cObsII:=cObsIPI:=cObsICMS:=cObsPIS:=cObsCOF:=""
      RETURN lRet
   ENDIF
         
   DEFINE MSDIALOG oDlg FROM  0,0 TO 11,60 TITLE STR0271 OF oMainWnd //"Visualização das Diferenças" 8

   
   nLin:=0
   nLin2:=40
   
   If !Empty(cObsII)
      nLin:=nLin+08
      @ nLin,010 SAY cObsII   SIZE 200,8 OF oDlg PIXEL
   EndIf                                 
   If !Empty(cObsIPI)                    
      nLin:=nLin+10                    
      @ nLin,010 SAY cObsIPI  SIZE 200,8 OF oDlg PIXEL
   EndIf                                 
   If !Empty(cObsICMS)                   
      nLin:=nLin+10                    
      @ nLin,010 SAY cObsICMS SIZE 200,8 OF oDlg PIXEL
   EndIf                                 

   IF lMV_PIS_EIC
      If !Empty(cObsPIS)
         nLin:=nLin+10                    
         @ nLin,010 SAY cObsPIS  SIZE 200,8 OF oDlg PIXEL
      EndIf                                 
      If !Empty(cObsCOF)
         nLin:=nLin+10                    
         @ nLin,010 SAY cObsCOF  SIZE 200,8 OF oDlg PIXEL
      EndIf
      nLin2:=60
   EndIf

   @ 002,005 TO nLin2,220 LABEL "" OF oDlg PIXEL
   
   DEFINE SBUTTON FROM 065,180 TYPE 1 ACTION (nOpc1:=1,oDlg:End()) ENABLE OF oDlg PIXEL
   
   ACTIVATE MSDIALOG oDlg CENTERED
   IF nOpc1 == 1
     cObsII:=cObsIPI:=cObsICMS:=cObsPIS:=cObsCOF:=""
   ENDIF
 ENDIF



RETURN lRet

*------------------------------*
FUNCTION Di154TabDes(aDespesa)
*------------------------------*
LOCAL nPos:= ASCAN(aDespesa,{|Desp|Desp[1]==SWD->WD_DESPESA})

lSair:=.F.
IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"TAB_DESPESAS"),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"TAB_DESPESAS"),)

IF lSair
   RETURN NIL
ENDIF

IF nPos==0
   AADD(aDespesa,{SWD->WD_DESPESA,DI154_SWDVal(),0,SWD->(RECNO()),0,0})
ELSE
   aDespesa[nPos,2]+=DI154_SWDVal()
   aDespesa[nPos,6]+=DI154_SWDVal()/ IF(BuscaTaxa(cMoeDolar,SWD->WD_DES_ADI,.T.,.F.,.T.)#0,BuscaTaxa(cMoeDolar,SWD->WD_DES_ADI,.T.,.F.,.T.),1)
ENDIF

RETURN NIL

*------------------------------*
FUNCTION DI154Valid(cQual)
*------------------------------*
Private cPE_Qual := cQual //Utilizado no Ponto de Entrada.
Private lRetValid := .T.

IF !lGeraNF .OR. cPaisLoc # "BRA"
   Return .T.
ENDIF

DO CASE
   CASE cQual = "NFE"

        If Empty(cNumNFE)
           Help("",1,"AVG0000809")//Numero da N.F. nao informado
           Return .F.
        Endif

   CASE cQual = "SERIE"
        SF1->(DBSETORDER(1))             
        If GETMV("MV_NFEHAWB",,.T.)//ASR 22/02/2006
           If SF1->(DbSeek(xFilial("SF1")+cNumNFE+cSerieNFE))//+Work1->WKFORN+Work1->WKLOJA)) - AWR 05/02/2004
              lMensagem:=.F.
              DO WHILE SF1->(!EOF()) .AND. SF1->F1_FILIAL == xFilial("SF1") .AND. SF1->F1_DOC == cNumNFE .AND. SF1->F1_SERIE == cSerieNFE
                 IF !EMPTY(SF1->F1_HAWB) 
	                // Bete 03/04/08 - Caso haja o campo de importador no SF1, permitir entrar com o mesmo numero de nota+serie desde que
		            // o importador seja diferente
                    IF !lMV_EASYSIM .AND. SF1->(FIELDPOS("F1_CIMPORT")) > 0
                       IF SF1->F1_CIMPORT == SW6->W6_IMPORT
        	              lMensagem:=.T.
        	              EXIT
        	           ENDIF
        	        ELSE
                       lMensagem:=.T.
                       EXIT
                    ENDIF
                 ENDIF
                 SF1->(DBSKIP())
              ENDDO
              IF lMensagem
                 Help("",1,"AVG0000810")//Numero da N.F. e da Serie ja cadastrados no sistema
                 Return .F.
              ENDIF   
           Endif
        Else//ASR 22/02/2006 - Inicio
           If SF1->(DbSeek(xFilial("SF1")+cNumNFE+cSerieNFE+Work1->WKFORN+Work1->WKLOJA))
              // Bete 03/04/08 - Caso haja o campo de importador no SF1, permitir entrar com o mesmo numero de nota+serie+fornecedor desde que
              // o importador seja diferente
              IF !lMV_EASYSIM  .AND. SF1->(FIELDPOS("F1_CIMPORT")) > 0
                 lMensagem:=.F.
	             DO WHILE SF1->(!EOF()) .AND. SF1->F1_FILIAL == xFilial("SF1") .AND. SF1->F1_DOC == cNumNFE .AND. SF1->F1_SERIE == cSerieNFE .AND.;
     	            SF1->F1_FORNECE+SF1->F1_LOJA == Work1->WKFORN+Work1->WKLOJA
        	        IF SF1->F1_CIMPORT == SW6->W6_IMPORT
        	           lMensagem:=.T.
        	           EXIT
        	        ENDIF
        	        SF1->(dbSkip())
        	     ENDDO
        	     IF lMensagem       	           
                    Help("",1,"AVG0000810")//Numero da N.F. e da Serie ja cadastrados no sistema
                    Return .F.
                 ENDIF
              ENDIF
           Endif
        EndIf//ASR 22/02/2006 - Fim

   CASE cQual = "DATA"

        If Empty(dDtNFE)
           Help("",1,"AVG0000811")//Data da N.F. nao Preenchida
           Return .F.
        Endif
EndCase

If ExistBlock("EICDI154")
   Execblock("EICDI154",.F.,.F.,"VALID_NFE")
EndIf

Return lRetValid

*----------------------*
Function DI154Pesquisa()
*----------------------*
LOCAL nOpca  :=0, oDlgPeq
LOCAL nRecno :=Work1->(RECNO())
LOCAL nOrder :=Work1->(INDEXORD())
LOCAL cForn  :=Work1->WKFORN
LOCAL cCFO   :=Work1->WK_CFO
LOCAL cOpera :=Work1->WK_OPERACA
LOCAL cTec   :=Work1->WKTEC
LOCAL cNcm   :=Work1->WKEX_NCM
LOCAL cNbm   :=Work1->WKEX_NBM
LOCAL cItem  :=Work1->WKCOD_I
LOCAL cChave :=cCFO+cOpera+cTec+cNcm+cNbm+cItem
LOCAL nCo1   :=04
LOCAL nCo2   :=40
LOCAL nLin   :=05

DEFINE MSDIALOG oDlgPeq TITLE STR0258 From 0,0 To 17,35 OF oMainWnd //"Pesquisa Chave"

nLin+=12
@nLin,nCo1 SAY STR0084  SIZE 30,8 PIXEL
@nLin,nCo2 MSGET cForn  SIZE 50,8 PIXEL F3 "SA2"

nLin+=12
@nLin,nCo1 SAY STR0039  SIZE 25,8 PIXEL
@nLin,nCo2 MSGET cCFO   SIZE 50,8 PIXEL

nLin+=12
@nLin,nCo1 SAY STR0372 SIZE 25,8 PIXEL //STR0372 "Operação"
@nLin,nCo2 MSGET cOpera SIZE 50,8 PIXEL F3 "SWZ"

nLin+=12
@nLin,nCo1 SAY "TEC"    SIZE 25,8 PIXEL
@nLin,nCo2 MSGET cTec   SIZE 52,8 PIXEL F3 "SYD"  PICTURE "@R 9999.99.99"

nLin+=12
@nLin,nCo1 SAY "EX-NCM" SIZE 25,8 PIXEL
@nLin,nCo2 MSGET cNcm   SIZE 50,8 PIXEL F3 "WD2"

nLin+=12
@nLin,nCo1 SAY "EX-NBM" SIZE 25,8 PIXEL
@nLin,nCo2 MSGET cNbm   SIZE 50,8 PIXEL F3 "WD3"

nLin+=12
@nLin,nCo1 SAY STR0373 SIZE 25,8 PIXEL //STR0373 "Cod. Item"
@nLin,nCo2 MSGET cItem  SIZE /*102*/50,8 PIXEL F3 "SB1"     // GFP - 15/10/2012

@ 10,100 BUTTON STR0111 SIZE 30,11 ACTION (nOpca:=1,If(DI154ValPesq(cForn,cTec,cItem),oDlgPeq:End(),)) OF oDlgPeq PIXEL //"&OK"   // GFP - 09/10/2012
@ 30,100 BUTTON STR0103 SIZE 30,11 ACTION (nOpca:=0,oDlgPeq:End()) OF oDlgPeq PIXEL //"&Sair"

ACTIVATE MSDIALOG oDlgPeq CENTERED

If nOpcA = 0
   RETURN .F.
Endif

cChave:=cForn+If(EICLOJA(),SA2->A2_LOJA,"")+cCFO+Work1->WKACMODAL+cOpera+cTec/*+"  "*/+cNcm+cNbm+cItem  // GFP - 15/10/2012
Work1->(DBSETORDER(5))//"WKFORN+WK_CFO+WKACMODAL+WK_OPERACA+WKTEC+WKEX_NCM+WKEX_NBM+WKCOD_I+WKPOSICAO"
Work1->(DBSEEK(cChave))  //Work1->(DBSEEK(RTRIM(cChave),.T.))   // GFP - 15/10/2012
IF Work1->(EOF())
   Work1->(DBGOTO(nRecno))
ENDIF
Work1->(DBSETORDER(nOrder))
RETURN .T.

*-----------------------------------------------------------------------------------------------------------------------------------*
STATIC FUNCTION E_RESET_AREA()
*-----------------------------------------------------------------------------------------------------------------------------------*
DBSELECTAREA("SW6")
IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,'DELETAWORK'),)
IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,'DELETAWORK'),)

//AvStAction("213",.F.)//AWR 04/02/2010 - Para versão M11 utilizar o ponto de entrada acima para customizar o Conta e Ordem.

SW6->(MSUnlock())
IF TYPE('lNaoDelWork')=="L" .AND. lNaoDelWork
   RETURN .T.
ENDIF
IF SELECT("Work1") # 0
   Work1->(E_EraseArq(Work1File,Work1FileA,Work1FileB))
   FErase(Work1FileC+OrdBagExt())
   FErase(Work1FileD+OrdBagExt())
   FErase(Work1FileE+OrdBagExt())
ENDIF
IF SELECT("Work2") # 0
   Work2->(E_EraseArq(Work2File, Work2FileA))
ENDIF
IF(SELECT("Work4")#0,Work4->(E_EraseArq(Work4File)),)
IF(SELECT("Work_EIU")#0,Work_EIU->(E_EraseArq(Work5File)),)
IF !lExecAuto
   IF(SELECT("Work3")#0,Work3->(E_EraseArq(Work3File,Work3FileA)),)
   IF(SELECT("Work_Tot")#0,Work_Tot->(E_EraseArq(cFileWk,cFileWkA)) ,)
ENDIF
DBSELECTAREA("SW6")
RETURN .T.
*------------------------------------------------------------------------------------------------------------------------*
//Atencao: Essa funcao é chamada no EICTP252.PRW tb
//EOB - 19/02/09 - Incluso cálculos de Diferimento e Crédito Presumido. Para ativar este tratamento, deve-se criar 
//                 as seguintes variáveis privates: aICMS_Dif, nVal_Dif, nVal_CP, nVal_ICM, onde:
//                 aICMS[1,1] = Chave para posicionamento (no caso da nota, é usado a operação do CFO)
//                 aICMS[1,2] = caracter que indica se é suspensão  
//                 aICMS[1,3] = alíquota de diferimento
//                 aICMS[1,4] = alíquota de credito presumido
//                 aICMS[1,5] = alíquota limite de crédito presumido
//                 aICMS[1,6] = alíquota minimo de ICMS a recolher
//                 aICMS[1,7] = alíquota do ICMS no CFO               //NCF - 16/09/2010 - adicionado ao array
//                 aICMS[1,8] = alíquota do ICMS S/ PIS no CFO        //NCF - 16/09/2010 - adicionado ao array
FUNCTION DI154CalcICMS(nBase,nAlqReducao,nAliquota,nAliqRedCte,nVA,nOT,nBase_PIS,nII,nIPI,lICMS_BaseNew,nPIS,nCOFINS,cAux)
*------------------------------------------------------------------------------------------------------------------------*
LOCAL nVal_CP1 := nVal_CP2 := 0
//LOCAL nAICMDIF  := GetMV("MV_AICMDIF",,0)  // GFP - 19/03/2013
DEFAULT lICMS_BaseNew := .F.
IF lICMS_BaseNew

//VA = FOB + FRETE + SEGURO
//OT = OUTRAS DESPESAS BASE
/* Jonato em 07/Junho/2004, para que o envio da base sem o valor do icms em casos de exoneracao, funcione p/ a J1B1 
   nBase := nBase_PIS + nII + nIPI + nOT
   IF nAlqReducao # 1
      nBase:=(nBase*nAlqReducao)
   ENDIF
   IF nAlqReducao # 1
      nBase:=(nBase*nAlqReducao)
   ENDIF
*/
   nBase := nVA + nII + nIPI + nOT + nPIS + nCOFINS
   IF !EMPTY(nAliqRedCte) .AND. nAlqReducao == 1
      If GetMv("MV_EIC0029",,"N") == "R"                                                         //NCF - 22/05/2013 - O valor do ICMS a integrar a própria base de cálculo para cálculo por Carga Tributária
         nBaseNew:= ( nBase / ( (100 - nAliqRedCte) /100 ) )                                  //                   Equivalente deve ser obtido conforme o parâmetro: N=Alíquota Normal; R=Alíquota Reduzida 
         nBase := DITrans( nBaseNew * (nAliqRedCte/nAliquota) ,2)
      Else
         nBaseNew:= ( nBase/(1-(nAliquota/100)) )                                             //NCF - 06/02/2013 - Correção do cálculo de Carga Tributária equivalente
         nBase := DITRANS( nBaseNew * ((nAliqRedCte/100) / (nAliquota/100)),2)
      EndIf
   ELSE
      nBase := DITrans( ( (nBase*nAlqReducao) / ( (100 - nAliquota) /100 ) ) ,2)
   ENDIF


ELSE

   IF !EMPTY(nAliqRedCte) .AND. nAlqReducao == 1
      If GetMv("MV_EIC0029",,"N") == "R"                                                         //NCF - 22/05/2013 - O valor do ICMS a integrar a própria base de cálculo para cálculo por Carga Tributária
         nBaseNew:= ( nBase / ( (100 - nAliqRedCte) /100 ) )                                  //                   Equivalente deve ser obtido conforme o parâmetro: N=Alíquota Normal; R=Alíquota Reduzida 
         nBase := DITrans( nBaseNew * (nAliqRedCte/nAliquota) ,2)
      Else
         nBaseNew:= ( nBase/(1-(nAliquota/100)) )                                             //NCF - 06/02/2013 - Correção do cálculo de Carga Tributária equivalente
         nBase := DITRANS( nBaseNew * ((nAliqRedCte/100) / (nAliquota/100)),2)
      Endif      
   ELSE
      IF GETMV("MV_ICMS_IN",,.F.) 
         nBase := DITrans( ( (nBase*nAlqReducao) / ( (100 - nAliquota) /100 ) ) ,2)
      ELSE
         nBase := DITrans( (nBase*nAlqReducao) ,2)
      ENDIF
   ENDIF

ENDIF

// EOB - 16/02/09
IF TYPE("aICMS_DIF")=="A" .AND. VALTYPE(cAux)=="C" .AND. LEN(aICMS_DIF) > 0 .AND. (nP:=ASCAN( aICMS_Dif, {|x| x[1] == cAux} )) > 0 
   nDiferimento := aICMS_Dif[nP,3]
   nCredPre     := aICMS_Dif[nP,4]
   nLimiteCP    := aICMS_Dif[nP,5]
   nPgDesemb    := aICMS_Dif[nP,6]
   nAlIcmCFO    := aICMS_Dif[nP,7]
   nAlIcmPC     := aICMS_Dif[nP,8] 
   
   //ACB - 15/02/2011 - Tratamento para que o calculo do ICMS de diferimento e o ICMS a recolher sejam calculados corretamente caso haja alteração na adições da NF para as aliquotas de ICMS
   IF Empty(nDiferimento) .and. Empty(nCredPre) .and. Empty(nLimiteCP) .and. Empty(nPgDesemb) .and. EMpty(nAlIcmPC)
      nVal_ICM := DITrans( ( nBase * (nAliquota/100) ), 2 )
   Else
      nVal_ICM := DITrans( ( nBase * (/*nAliquota*/nAlIcmCFO/100) ), 2 )  //NCF - 15/09/2010 - Quando o cálculo é de diferimento, a alíquota deve ser a somente a do ICMS.
   EndIf
                                                                                    
   IF nDiferimento > 0 //.AND. IF(nAICMDIF > 0, nAliquota == nAICMDIF, .T.)  // GFP - 19/03/2013 - Nopado para que o sistema calcule CFO com mais de uma aliquota de diferimento diferente.
      nVal_Dif := DITrans( ( nVal_ICM * ( nDiferimento / 100 ) ), 2 )
   ENDIF
   
   IF nCredPre > 0
      nVal_CP1 := DITrans( ( (nVal_ICM - nVal_Dif) * ( nCredPre / 100 ) ), 2 )
      nVal_CP  := nVal_CP1 
   ENDIF
   
   IF nLimiteCP > 0
      nVal_CP2 := DITrans(( nBase * ( nLimiteCP / 100 ) ), 2 )
      nVal_CP  := nVal_CP2
   ENDIF
   
   IF nVal_CP1 > 0 .AND. nVal_CP2 > 0
      nVal_CP  := IF(nVal_CP1 > nVal_CP2, nVal_CP2, nVal_CP1)
   ENDIF
      
   nVal_ICM1 := nVal_ICM - nVal_Dif - nVal_CP
   nVal_ICM2 := DITrans( ( nBase * ( nPgDesemb / 100 ) ), 2)
   nVal_ICM  := IF(nVal_ICM1 > nVal_ICM2, nVal_ICM1, nVal_ICM2 )
 
   //TRP - 19/02/2010
/*   cSuspensao := aICMS_Dif[nP,2]
   IF cSuspensao $ cSim
      nBase:= 0
   ENDIF
*/   
ENDIF
   
Return nBase

*----------------------------------------------------------------------------*
FUNCTION DI154Work3Grv(lCusto)
*----------------------------------------------------------------------------*
LOCAL cFilSYB :=xFilial("SYB"), Wind ,E
Local aMaiorDesp:= {}
DEFAULT lCusto:=.F.
IF SELECT("Work3")=0
   RETURN .F.
ENDIF
//IF nTipoNF # NFE_PRIMEIRA .OR. cPaisLoc # "BRA" .OR. lCusto    //Bete 24/11 - Trevo
   DBSELECTAREA("Work3")
   ZAP
   Work1->(DBGOTOP())
   WORK2->(DBSETORDER(2)) //SVG 06/10/08
   ProcRegua( Work1->(LASTREC())*LEN(aDespesa) )
   aDesAcerto:={}
   DO WHILE Work1->(!EOF())
      lAcerta:=.T.
      FOR Wind = 1 TO LEN(aDespesa)

          IncProc()
          SWD->(DBGOTO(aDespesa[Wind,4]))
          SYB->(DBSEEK(cFilSYB+aDespesa[Wind,1]))

          nTaxa:=BuscaTaxa(cMoeDolar,SWD->WD_DES_ADI,.T.,.F.,.T.)     
          IF(nTaxa=0,nTaxa:=1,)
          
          // by RS 16/09/05  

/*
          IF SYB->YB_RATPESO $ cSim
             nValor := DITRANS(aDespesa[Wind,2]*Work1->WKPESOL/MDI_PESO,2)
          ELSE
             nValor := DITRANS(aDespesa[Wind,2]*Work1->WKFOBR_ORI/MDI_FOBR_ORI,2)
          ENDIF
*/                     
          //JAP - Alteração nos calculos de rateio dos grupos e itens.
          Work2->(DBSEEK(WORK1->WKADICAO)) //Work2->(DBSEEK(EVAL(bSeekWk2))) SVG 06/10/08
          
          IF SYB->YB_RATPESO $ cSim
             //nRateio := Work1->WKPESOL/MDI_PESO
             nRateioGrupo := Work2->WKPESOL/MDI_PESO
             nRateioItem  := Work1->WKPESOL/Work2->WKPESOL 
          ELSE
             //** AAF 08/11/07 - Rateio da despesas por CIF
             If lRateioCif
                nCIFGrupo := Work2->WKFOB_R+Work2->WKFRETE+Work2->WKSEGURO
                nCIFItem  := Work1->WKCIF-Work1->WKDESPCIF-Work1->WKVLACRES+Work1->WKVLDEDUC
                
                nRateioGrupo := nCIFGrupo/MDI_CIFPURO
                nRateioItem  := nCIFItem/nCIFGrupo
             Else
                nRateioGrupo := Work2->WKFOBR_ORI/MDI_FOBR_ORI
                nRateioItem  := Work1->WKFOBR_ORI/Work2->WKFOBR_ORI          
                //nRateio:=IF(lCusto,Work1->WKRATEIO,Work1->WKFOBR_ORI/MDI_FOBR_ORI)            
             EndIf
             //**
          ENDIF
          
          //nDespGrupo := DITRANS(aDespesa[Wind,2]*nRateioGrupo,2)

          //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
          If SWD->WD_DESPESA == cCodTxSisc  .And.  lTxSiscOK .And.  !lRatCIF   // SVG - 28/09/2010 - 
             nDespGrupo := Work2->WKTAXASIS
          Else
             nDespGrupo := DITRANS(aDespesa[Wind,2]*nRateioGrupo,2)
          EndIf
          //**

                            
          nValor := nDespGrupo * nRateioItem 
          //nValor:=DITRANS(aDespesa[Wind,2]*nRateio,2)

          Work3->(DBAPPEND())
          Work3->WKRECNO   := Work1->(RECNO())
          Work3->WKDESPESA := aDespesa[Wind,1] + "-"+SUBS(SYB->YB_DESCR,1,20)
          Work3->WKVALOR   := DITRANS(nValor,2)   //  TLM 02/04/2008 
          Work3->WKVALOR_US:= DITRANS(Work3->WKVALOR/nTaxa,2)
          Work3->WKPO_NUM  := Work1->WKPO_NUM
          Work3->WKPOSICAO := Work1->WKPOSICAO
          Work3->WKPGI_NUM := Work1->WKPGI_NUM
          Work3->WK_LOTE   := Work1->WK_LOTE
          
          IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRVWORK3"),)
          IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK3"),)
          
          IF lAcerta 
             IF (nPos:=ASCAN(aDesAcerto,{|Desp|Desp[1]==Work3->WKDESPESA})) = 0
                AADD(aDesAcerto,{Work3->WKDESPESA,DITRANS(Work3->WKVALOR,2),Work3->WKVALOR_US,aDespesa[Wind,2],DITRANS(aDespesa[Wind,2]/nTaxa,2), Work3->(Recno()) })
                AAdd(aMaiorDesp, DITRANS(Work3->WKVALOR,2)) //wfs 14/01/11
             ELSE
                aDesAcerto[nPos,2] += DITRANS(Work3->WKVALOR,2)
                aDesAcerto[nPos,3] += Work3->WKVALOR_US
                If DITRANS(Work3->WKVALOR,2) > aMaiorDesp[nPos]//wfs 14/01/11
                   aDesAcerto[nPos][6]:= Work3->(Recno())
                   aMaiorDesp[nPos]:= DITRANS(Work3->WKVALOR,2)
                EndIf                
             ENDIF
          ENDIF
          IF(ExistBlock("IC023PO1"),Execblock("IC023PO1",.F.,.F.,"GRVWORK3"),) // MERCK - ALEX

      NEXT
      Work1->(dbSkip())
   ENDDO

   IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRVWORK_2"),)

   FOR E=1 TO LEN(aDesAcerto)

       Work3->(DBGOTO( aDesAcerto[E,6] ))
       IF aDesAcerto[E,2] # aDesAcerto[E,4]
          Work3->WKVALOR := Work3->WKVALOR + (aDesAcerto[E,4] - aDesAcerto[E,2])
       ENDIF
       IF aDesAcerto[E,3] # aDesAcerto[E,5]
          Work3->WKVALOR_US := Work3->WKVALOR_US + (aDesAcerto[E,5] - aDesAcerto[E,3])
       ENDIF

       IF(ExistBlock("IC023PO1"),Execblock("IC023PO1",.F.,.F.,"ACERTOWORK3"),) // MERCK - JMS

   NEXT

//ENDIF

RETURN NIL

*--------------------------------------------------------------------------------------*
FUNCTION DI154GeraCusto()// Essa opcao gera o custo Realizado em cima da Primeira ou da Unica
*--------------------------------------------------------------------------------------*
LOCAL nNBM_FOB:=0, nRatIPD:=0,nTam:=AVSX3("B1_VM_P",3)
LOCAL cFilSWD:=xFILIAL("SWD")
LOCAL nCifMaior := 0, nRecno:=1
LOCAL n1CIFMaior,n1Recno,nSumDespI,nRecnoMidia,nTotProc
//** ASK 06/08/07 - Rateio TX SISCOMEX sem DI Eletronica.
Local nQtdRecWK2 := 0
Local nQtdAdicao := 0
Local nTotTxSisc := 0 
Local nTotTxComp := 0   // TLM 26/10/07
Local cMsgInfo   := ""
Private nValTxComp := 0  // TLM 26/10/07
lTxSiscOK := .T.
//**
PRIVATE cFilSB1:=xFilial('SB1')
PRIVATE cFilSW2:=xFilial('SW2')
PRIVATE cFilSW7:=xFilial('SW7')
PRIVATE cFilSWP:=xFilial('SWP')
PRIVATE cFilSW8:=xFilial('SW8')
PRIVATE cFilSW9:=xFilial('SW9')
PRIVATE cFilSWZ:=xFILIAL("SWZ")

ProcRegua(Work1->(LASTREC())+3)

//M_FOB_MID:= nFobItemMidia:=0 // Essas variaveis nao podem ser zeradas por que ja estao com o valor certo
nContProc:=nDifCamb:=0
aDespesa := {}; nFob:=nFobTot:=nPesoL:=0
aDesAcerto:={}

IncProc()

SYB->(DBSETORDER(1))
SB1->(DBSETORDER(1)) 
SW2->(DBSETORDER(1))
SW7->(DBSETORDER(4))
SW9->(DBSETORDER(1))
SW8->(DBSETORDER(6))

nFob:=0

IncProc()

MDI_OUTR:=MDI_OU_US:=nDifCamb:=0
MDI_OUTRP:=MDI_OU_USP:=0     //EOS
SWD->(DbSeek(cFilSWD+SW6->W6_HAWB))
SWD->(DbEval( {|| DI154ForDesp()} ,;
              {|| AT(LEFT(SWD->WD_DESPESA,1),"129") = 0} ,;
              {|| cFilSWD==SWD->WD_FILIAL .AND. SWD->WD_HAWB==SW6->W6_HAWB} ))//Le todas as despesas
IncProc()

Work2->(dbsetorder(2))//SVG 06/10/08
Work1->(dbsetorder(3))
Work1->(DBGOTOP())

nTotProc:=MDI_FOB_R
MDI_FOBR_ORI := SW6->W6_FOB_TOT+DITrans(MDespesas,2)

MDI_PESO := 0
Do While Work1->(!Eof())
   MDI_PESO += Work1->WKPESOL 
   Work1->(DbSkip())
EndDo
Work1->(DbGoTop())
                      
DO WHILE  !Work1->(EOF())

   IncProc(STR0136+' '+Work1->WKCOD_I) //"Lendo Item: "

   SB1->(DbSeek(cFilSB1+Work1->WKCOD_I))
   SWZ->(DbSeek(cFilSWZ+Work1->WK_OPERACA))
   SW2->(DbSeek(cFilSW2+Work1->WKPO_NUM))
   SW7->(DBSEEK(cFilSW7+SW6->W6_HAWB+SW2->W2_PO_NUM+Work1->WKPOSICAO+Work1->WKPGI_NUM))
   SW8->(DBSEEK(cFilSW8+SW7->(W7_HAWB+Work1->WKINVOICE+W7_PO_NUM+W7_POSICAO+W7_PGI_NUM)))
   //TDF 06/12/2010 - ACRESCENTA O HAWB NA CHAVE DE BUSCA
   SW9->(DBSEEK(cFilSW9+Work1->WKINVOICE+Work1->WKFORN+EICRetLoja("Work1", "WKLOJA")+SW6->W6_HAWB))
   SWP->(DBSEEK(cFilSWP+SW7->W7_PGI_NUM+SW7->W7_SEQ_LI))

   // O While é mantido, pois nem todos possuem a alteração no índice 1 da SW9 (FILIAL+INVOICE+FORNECEDOR+HAWB)
   // A alteração do índice 1 da SW9 é disponibilizada através do update UIINVOICE   
   DO WHILE !SW9->(EOF()) .AND. SW9->W9_FILIAL   == cFilSW9         .AND.;
                                Work1->WKINVOICE == SW9->W9_INVOICE .AND.;
                                Work1->WKFORN    == SW9->W9_FORN    .And.;
                                (!EICLoja() .Or. Work1->WKLOJA == SW9->W9_FORLOJ)
      IF SW6->W6_HAWB  == SW9->W9_HAWB
         EXIT
      ENDIF
      SW9->(DBSKIP())
   ENDDO                                                                
   
   
   IF (ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRVWORK_1a"),)

   SY6->(DBSEEK(xFilial("SY6")+SW9->W9_COND_PA+STR(SW9->W9_DIAS_PA,3,0)))// AWR 27/08/2004  - SEM COBERTURA
   Work1->WKSEMCOBER:=(SY6->Y6_TIPOCOB == "4")// AWR 27/08/2004  - SEM COBERTURA
   IF Work1->WKSEMCOBER// AWR 27/08/2004  - SEM COBERTURA
      lTemItSemCob:=.T.// AWR 27/08/2004  - SEM COBERTURA
   ENDIF
   Work1->WK_NFE    := ''
   Work1->WKNROLI   := SWP->WP_REGIST
   Work1->WKFABR    := SW7->W7_FABR
   If EICLoja()
      Work1->WKFABLOJ := SW7->W7_FABLOJ
      Work1->WKLOJA := SW7->W7_FORLOJ
   EndIf
   Work1->WKMOEDA   := SW9->W9_MOE_FOB
   Work1->WK_CONDPAG:= SW9->W9_COND_PA
   Work1->WK_DIASPAG:= SW9->W9_DIAS_PA
   Work1->WKINCOTER := SW9->W9_INCOTER
   Work1->WKDESCR   := MEMOLINE(MSMM(SB1->B1_DESC_P,nTam),60)
   Work1->WKPO_SIGA := DI154_PO_SIGA() // RA - 24/10/03 - O.S. 1075/03 // Antes=>SW2->W2_PO_SIGA

   IF !Work2->(DBSEEK(Work1->WKADICAO)) //IF !Work2->(DBSEEK(EVAL(bSeekWk2))) SVG 06/10/08 
      Work2->(DBAPPEND())
      Work2->WKADICAO  := Work1->WKADICAO
      Work2->WKNROLI   := SWP->WP_REGIST
      Work2->WKFORN    := Work1->WKFORN
      Work2->WKNOME    := Work1->WKNOME  //TRP-26/10/07
      Work2->WK_OPERACA:= Work1->WK_OPERACA
      Work2->WK_CFO    := Work1->WK_CFO
      Work2->WKTEC     := Work1->WKTEC
      Work2->WKEX_NCM  := Work1->WKEX_NCM
      Work2->WKEX_NBM  := Work1->WKEX_NBM
      Work2->WKII_A    := Work1->WKIITX
      Work2->WKIPI_A   := Work1->WKIPITX
      Work2->WKICMS_A  := Work1->WKICMS_A
      Work2->WKMOEDA   := SW9->W9_MOE_FOB
      Work2->WK_CONDPAG:= SW9->W9_COND_PA
      Work2->WK_DIASPAG:= SW9->W9_DIAS_PA
      Work2->WKINCOTER := SW9->W9_INCOTER
      Work2->WKNROLI   := SWP->WP_REGIST
      Work2->WKFABR    := SW7->W7_FABR
      If EICLoja()
         Work1->WKFABLOJ := SW7->W7_FABLOJ
         Work1->WKLOJA := SW7->W7_FORLOJ
      EndIf
      Work2->TRB_ALI_WT := "SW9"
      Work2->TRB_REC_WT := SW9->(Recno())
      
      IF !SWZ->(EOF())
         Work2->WKICMS_RED:= IF(SWZ->WZ_RED_ICM#0,(100-SWZ->WZ_RED_ICM)/100,1)
         Work2->WKRED_CTE:=SWZ->WZ_RED_CTE
      ELSE
         Work2->WKICMS_RED:= 1 
      ENDIF
   ENDIF

   nFobMoeda :=DITrans(Work1->WKPRECO*Work1->WKQTDE,2)
   nRatIPD   :=DITRANS(Work1->WKINLAND+Work1->WKPACKING+Work1->WKOUTDESP-IF(!lIn327,Work1->WKDESCONT,0)+SW8->W8_FRETEIN,2) // JBS - 29/10/2003
   nPrecoReal:=(nFobMoeda+nRatIPD)*DI154TaxaFOB()

   //Work1->WKFOBR_ORI:=DITrans(nPrecoReal,2)
   Work1->WKFOBR_ORI:=Work1->WKFOB_R//AAF 29/06/2010 - Para nao haver erro com notas integradas, pois nao possuem inland, packing,... 

   Work2->WKFOBR_ORI+= Work1->WKFOBR_ORI
   Work2->WKFOB_R   += Work1->WKFOB_R
   Work2->WKFRETE   += Work1->WKFRETE
   Work2->WKSEGURO  += Work1->WKSEGURO
   
   //*** Quando a nota foi integrada, o CIF não contém as despesas por isso, elas devem ser somadas na impressão do custo
   If lLerNota .And. GETMV("MV_CIF_DES",,.F.)//JVR - 24/02/10 - GETMV, define se CIF contem Despesas base de Impostos ou nao.
      Work1->WKCIF += ((nSomaNoCIF - nSemCusto)*(Work1->WKFOB_R/MDI_FOB_R)+(nPSomaNoCIF - nPSemCusto)*(Work1->WKPESOL/MDI_PESO))
   EndIf   
   
   Work2->WKCIF     += Work1->WKCIF
   
   Work2->WKII      += Work1->WKIIVAL
   Work2->WKIPI     += Work1->WKIPIVAL
   Work2->WKICMS    += Work1->WKVL_ICM
   Work2->WKPESOL   += Work1->WKPESOL
   Work2->WKSOMACIF += Work1->WKDESPCIF
   
   // Bete - 25/07/04 - Inclusao dos acrescimos e deducoes na base de impostos
   Work2->WKVLACRES += Work1->WKVLACRES
   Work2->WKVLDEDUC += Work1->WKVLDEDUC

   //Transferido para um loop acima para poder utilizar o valor no rateio do MV_CIF_DES
   //MDI_PESO += Work1->WKPESOL 

   IF lExiste_Midia .AND. SB1->B1_MIDIA $ cSim
      nTaxa:=BuscaTaxa(cMoeDolar,SW6->W6_DT_DESE,.T.,.F.,.T.)
      IF(nTaxa=0,nTaxa:=1,)
      nFbMid_MRS:=DITrans(SB1->B1_QTMIDIA*Work1->WKQTDE*SW2->W2_VLMIDIA*DI154TaxaFOB(),2)

      Work1->WK_VLMID_M:= DITrans(nFbMid_MRS,2)
      Work1->WK_QTMID  := SB1->B1_QTMIDIA * Work1->WKQTDE
      Work1->WKRDIFMID := DITrans( ((nFobMoeda+nRatIPD) - (Work1->WK_QTMID * SW2->W2_VLMIDIA)) * DI154TaxaFOB(),2 )
      Work1->WKUDIFMID := DITrans( ((nFobMoeda+nRatIPD) - (Work1->WK_QTMID * SW2->W2_VLMIDIA)) * IF(SW9->W9_MOE_FOB=cMoeDolar,1,(DI154TaxaFOB()/nTaxa)) ,2 )
      Work1->WKRDIFMID += DITrans( nDifCamb * Work1->WKFOB_R/nTotProc ,2)
      Work2->WKRDIFMID += Work1->WKRDIFMID
      Work2->WKUDIFMID += Work1->WKUDIFMID
   ELSE
      Work1->WKRDIFMID += DITrans( nDifCamb * Work1->WKFOB_R/nTotProc ,2)
      Work2->WKRDIFMID += Work1->WKRDIFMID
   ENDIF  

   IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"GRVWORK_4"),)

   Work1->(DBSKIP())

ENDDO

//** ASK 06/08/07 - Rateio TX SISCOMEX sem DI Eletronica.
nQtdRecWK2 := Work2->( RecCount() )
nQtdAdicao := 0
nTotTxSisc := 0
nTotTxComp := DI154DspSis() //TLM 26/10/2007 //NCF - 19/07/2011 - Buscar pela funcao que retorna o valor inicial da taxa Siscomex

If nTxSisc > 0
   Work2->(DbGoTop())
   DO WHILE  Work2->(!EOF())
 
      nQtdAdicao++
      nValTxComp:=0    // TLM 26/10/2007  
      Work2->WKTAXASIS := DI154TxSisc(nQtdAdicao,nQtdRecWK2)
      nTotTxSisc += Work2->WKTAXASIS  
      nTotTxComp += nValTxComp    //TLM 26/10/2007
      
      Work2->(dbSkip())
   ENDDO
EndIf

// lTxSiscOK := nTxSisc == nTotTxSisc 
lTxSiscOK := nTxSisc == nTotTxComp   //TLM 26/10/2007  
If !lTxSiscOK
   If !(nTipoNF==NFE_COMPLEMEN)    //TLM 26/10/2007     
      If !lRatCIF                  //TLM 26/10/2007
         cMsgInfo := STR0374  //"Valor da taxa do Siscomex apurado não bate com o informado. " //STR0374 "Valor da taxa do Siscomex apurado não bate com o informado. "
         cMsgInfo += STR0375  //"O rateio da taxa será realizado pelo " //STR0375 "O rateio da taxa será realizado pelo "
         cMsgInfo += IIF(lRatCIF,"CIF","FOB")+"."  // "CIF" , "FOB"
         MsgInfo(cMsgInfo)
      EndIf 
      If !lLerNota                    //NCF - 01/08/2011 - A soma duplica o valor das Desp.Base ICMS na Tela de "Valores e Taxas" antes da geração do custo
         nSomaBaseICMS += nTxSisc     //                   com MV_LERNOTA = T
      EndIf
   EndIf
   //Rateio TX SISCOMEX por Valor
   Work2->(DbGoTop())
   Do While Work2->(!EOF())
      Work2->WKTAXASIS := 0
      Work2->(DbSkip())
   EndDo
   
   nTxSisc := 0
EndIf
//**            

DI154Work3Grv(.T.)

//Work1->(dbsetorder(1))
Work1->(dbSetOrder(6))
Work2->(dbsetorder(1))

Work1->(DBGOTOP())
Work2->(DBGOTOP())
ProcRegua( Work2->( LASTREC() ) )
nMaior    :=0
nRecno    :=Work2->(RECNO())
nSumDespI :=nRecnoMidia:=0
nRDIFMID  :=nOUTRDESP:= nOUTRD_US  := 0

DO WHILE  Work2->(!EOF())

   IncProc(STR0137) //"Gravando impostos das NCMs"

   IF lRateioCIF
      Work2->WKOUTRDESP:= DITrans(MDI_OUTR     *(Work2->WKCIF-Work2->WKSOMACIF-Work2->WKVLACRES+Work2->WKVLDEDUC)/MDI_CIFPURO,2)  // Bete - 25/07/04 - Inclusao de acrescimos e deducoes p/ apurar o CIF puro
      Work2->WKOUTRD_US:= DITrans(MDI_OU_US    *(Work2->WKCIF-Work2->WKSOMACIF-Work2->WKVLACRES+Work2->WKVLDEDUC)/MDI_CIFPURO,2)  // Bete - 25/07/04 - Inclusao de acrescimos e deducoes p/ apurar o CIF puro
   ELSE
      Work2->WKOUTRDESP:= DITRANS(MDI_OUTR     *(Work2->WKFOBR_ORI/MDI_FOBR_ORI),2)
      Work2->WKOUTRD_US:= DITRANS(MDI_OU_US    *(Work2->WKFOBR_ORI/MDI_FOBR_ORI),2)
   ENDIF

   Work2->WKOUTRDESP+= DITRANS(MDI_OUTRP     *(Work2->WKPESOL/MDI_PESO),2)
   Work2->WKOUTRD_US+= DITRANS(MDI_OU_USP    *(Work2->WKPESOL/MDI_PESO),2)
   
   IF Work2->WKOUTRDESP > nMaior
      nMaior:=Work2->WKOUTRDESP
      nRecno:=Work2->(RECNO())
   ENDIF  

   IF lExiste_Midia .AND. lHaUmaMidia
      IF !EMPTY(Work2->WKRDIFMID)
         nRecnoMidia:=Work2->(RECNO())
      ENDIF  
   ENDIF  

   nOUTRDESP   += Work2->WKOUTRDESP
   nOUTRD_US   += Work2->WKOUTRD_US
   nRDIFMID    += Work2->WKRDIFMID

   Work2->(DBSKIP())
ENDDO

Work2->(DBGOTO(nRecno))

IF DiTrans( MDI_OUTR + MDI_OUTRP,2 ) # DiTrans( nOUTRDESP,2 )
   Work2->WKOUTRDESP += DiTrans( MDI_OUTR + MDI_OUTRP,2 ) - DiTrans( nOUTRDESP,2 )
ENDIF

IF DiTrans( MDI_OU_US + MDI_OU_USP,2 ) # DiTrans( nOUTRD_US,2 )
   Work2->WKOUTRD_US += DiTrans( MDI_OU_US + MDI_OU_USP ,2 ) - DiTrans( nOUTRD_US,2 )
ENDIF

IF lExiste_Midia .AND. lHaUmaMidia
   IF(nRecnoMidia=0,,Work2->(DBGOTO(nRecnoMidia)))
   IF DITrans(nRDIFMID,2) # DITrans(nDifCamb+(nFobItemMidia-M_FOB_MID),2)
      Work2->WKRDIFMID   += DITrans(nDifCamb+(nFobItemMidia-M_FOB_MID),2) - DITrans(nRDIFMID,2)
   ENDIF
ELSE
   IF DITrans(nRDIFMID,2) # DITrans(nDifCamb,2)
      Work2->WKRDIFMID += DITrans(nDifCamb,2) - DITrans(nRDIFMID,2)
   ENDIF  
ENDIF  

nMaior:=0
nRecno:=Work1->(RECNO())
nICMSNFC:=0

Work2->(DBGOTOP())
DO WHILE  Work2->(!EOF())
   nValMerc:=nDesp:=nDesp_US:=0

// Work1->(DbSeek(EVAL(bSeekWk1)))  Bete - controle por adição
// DO WHILE !Work1->(EOF()) .AND. EVAL(bWhileWk)  Bete - controle por adição

   Work1->(DbSeek(Work2->WKADICAO))
   DO WHILE !Work1->(EOF()) .AND. Work1->WKADICAO == Work2->WKADICAO
      IF lRateioCIF
         Work1->WKOUT_DESP:= DITrans((MDI_OUTR   * (Work1->WKCIF-Work1->WKDESPCIF-Work1->WKVLACRES+Work1->WKVLDEDUC)/MDI_CIFPURO) + ;  // Bete - 25/07/04 - Inclusao de acrescimo e deducoes p/ apurar o CIF puro
                                     (MDI_OUTRP  * Work1->WKPESOL/MDI_PESO)+ Work1->WKRDIFMID ,2)
         Work1->WKOUT_D_US:= DITrans((MDI_OU_US  * (Work1->WKCIF-Work1->WKDESPCIF-Work1->WKVLACRES+Work1->WKVLDEDUC)/MDI_CIFPURO) + ;  // Bete - 25/07/04 - Inclusao de acrescimo e deducoes p/ apurar o CIF puro
                                     (MDI_OU_USP * Work1->WKPESOL/MDI_PESO)+ Work1->WKUDIFMID ,2)
      ELSE
         Work1->WKOUT_DESP:= DITrans((MDI_OUTR   * Work1->WKFOBR_ORI/MDI_FOBR_ORI)+ ;
                                     (MDI_OUTRP  * Work1->WKPESOL   /MDI_PESO)    + Work1->WKRDIFMID ,2)
         Work1->WKOUT_D_US:= DITrans((MDI_OU_US  * Work1->WKFOBR_ORI/MDI_FOBR_ORI)+ ;
                                     (MDI_OU_USP * Work1->WKPESOL   /MDI_PESO)    + Work1->WKUDIFMID ,2)
      ENDIF

      Work1->WKVALMERC := Work1->WKIPIBASE+Work1->WKOUT_DESP
      Work1->WKPRUNI   := Work1->WKVALMERC / Work1->WKQTDE

      nValMerc += Work1->WKVALMERC
      nDesp    += Work1->WKOUT_DESP
      nDesp_US += Work1->WKOUT_D_US

      IF Work1->WKOUT_DESP > nMaior
         nMaior:=Work1->WKOUT_DESP
         nRecno:=Work1->(RECNO())
      ENDIF  

      //IF lICMS_NFC .AND. nNFOrigem # NFE_UNICA And. nTipoNF # CUSTO_REAL  //By JPP - 29/10/2007 - 17:00 - Inclusão da condição nTipoNF # CUSTO_REAL. Não recalcular o ICMS. Deve Ler da nota. Esta rotina apenas é executada quando o parâmetro ler nota for True.                                   
      IF lICMS_NFC .AND. nNFOrigem # NFE_UNICA   // TLM 04/06/2008 - Acerto do ICMS no custo realizado, adicionado na WORK1 o ICMS da nota complementar para o cálculo correto do custo, MV_LERNOTA deve estar ligado ( .T. )  
         If nTipoNF # CUSTO_REAL                 // TLM 04/06/2008 - Adicionado o IF para validar caso não for custo conforme JPP 29/10/2007 acima.
            nBaseICMS        := DITRANS( nSomaBaseICMS *(Work1->WKFOBR_ORI/MDI_FOBR_ORI),2)
            nBaseICMS        += DITRANS( nPSomaBaseICMS*(Work1->WKPESOL   /MDI_PESO    ),2)   
            Work1->WKDESPICM += nBaseICMS
            nICMSNFC         += nBaseICMS
            nBaseICMS        := DI154CalcICMS(nBaseICMS,Work2->WKICMS_RED,Work1->(IF(WKICMS_A!=0,WKICMS_A,WKICMSPC)),Work2->WKRED_CTE)//ASR - 10/10/2005
            Work1->WKBASEICMS+= nBaseICMS
            If !lIntDraw .OR. DI154DrawICMS()//JVR - 10/03/10 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
               Work1->WKVL_ICM  += DITrans(nBaseICMS * Work1->WKICMS_A/100,2)
            EndIf
            Work2->WKICMS    += DITrans(nBaseICMS * Work1->WKICMS_A/100,2) 
         Else                                                              // TLM 04/06/2008 - O ICMS da nota complementar deverá fazer parte do custo realizado.
            nBaseICMS        := DITRANS( nSomaBaseICMS *(Work1->WKFOBR_ORI/MDI_FOBR_ORI),2) 
            nBaseICMS        += DITRANS( nPSomaBaseICMS*(Work1->WKPESOL   /MDI_PESO    ),2)                                                            
            Work1->WKDESPICM := ABS(nBaseICMS - Work1->WKDESPICM)          // TLM 04/06/2008 - A variável nBaseICMS totaliza todas despesas base de ICMS, necessário subtrair a Work1->WKDESPICM para que a despesa não seja duplicada. 
            nICMSNFC         += Work1->WKDESPICM
            nBaseICMS        := DI154CalcICMS(Work1->WKDESPICM,Work2->WKICMS_RED,Work1->(IF(WKICMS_A!=0,WKICMS_A,WKICMSPC)),Work2->WKRED_CTE)//ASR - 10/10/2005
            Work1->WKBASEICMS+= nBaseICMS                                  // TLM 04/06/2008 - A Work1->WKBASEICMS possui o valor da base de ICMS da nota primeira, adicionado a base de ICMS da nota complementar.
            If !lIntDraw .OR. DI154DrawICMS()//JVR - 10/03/10 - Não grava o valor do ICMS caso seja Drawback Suspensão e não seja Intermediário.
               Work1->WKVL_ICM  += DITrans(nBaseICMS * Work1->WKICMS_A/100,2) // TLM 04/06/2008 - A Work1->WKVL_ICM totaliza o ICMS da nota primeira, adicionado o ICMS da nota complementar.
            EndIf
            Work2->WKICMS    += DITrans(nBaseICMS * Work1->WKICMS_A/100,2) // TLM 04/06/2008 - A Work1->WKICMS totaliza o ICMS da nota primeira, adicionado o ICMS da nota complementar. 
         EndIf    
      ENDIF

      Work1->(DBSKIP())

   ENDDO

   Work1->(DBGOTO(nRecno))

   IF nDesp # (Work2->WKOUTRDESP+Work2->WKRDIFMID)
      Work1->WKOUT_DESP += (Work2->WKOUTRDESP+Work2->WKRDIFMID)-DITrans(nDesp,2)
   ENDIF
   IF nDesp_US # (Work2->WKOUTRD_US+Work2->WKUDIFMID)
      Work1->WKOUT_D_US += (Work2->WKOUTRD_US+Work2->WKUDIFMID)-DITrans(nDesp_US,2)
   ENDIF
   IF nValMerc # (Work2->WKCIF+Work2->WKII+Work2->WKOUTRDESP+Work2->WKRDIFMID)
      Work1->WKVALMERC+=(Work2->WKCIF+Work2->WKII+Work2->WKOUTRDESP+Work2->WKRDIFMID) - DITrans(nValMerc,2)
      Work1->WKPRUNI  := Work1->WKVALMERC / Work1->WKQTDE
   ENDIF

   Work2->(dbSkip())
ENDDO

Work1->(DBGOTO(nRecno))
IF nICMSNFC > 0 .AND. nICMSNFC # (nSomaBaseICMS + nPSomaBaseICMS)
   Work1->WKDESPICM += (nSomaBaseICMS + nPSomaBaseICMS) - nICMSNFC
ENDIF

DBSELECTAREA("Work2")
DI154IncProc()
DI154TestDI(bDifere)

DI154CustSemCobert() //AWR 27/08/2004 - SEM COBERTURA

Work2->(DBGOTOP())

IF lExiste_Midia 
   nTaxa:=BuscaTaxa(cMoeDolar,SW6->W6_DT_DESE,.T.,.F.,.T.)
   IF(nTaxa=0,nTaxa:=1,)
   MDI_OUTR += (nFobItemMidia-M_FOB_MID)
   MDI_OU_US+=((nFobItemMidia-M_FOB_MID)/nTaxa)
ENDIF   
MDI_OUTR +=nDifCamb

IF(ExistBlock("ICPADDI0"),Execblock("ICPADDI0",.F.,.F.,"FINALGRAVA"),)

RETURN NIL   
*---------------------------*
Function DI154TaxaFOB(cTipo)
*---------------------------*
PRIVATE nTaxa, cTipTx
// Bete 26/11 - Trevo
IF cTipo == NIL
   cTipo:=cTipTx:="FOB"    
ELSE
   cTipTx:=cTipo
ENDIF   
 
IF cTipTx == "FOB"
   nTaxa:=SW9->W9_TX_FOB 
   IF lExecAuto .AND. TYPE("aTabTaxas") = "A" .AND. LEN(aTabTaxas) > 0
      IF (nPos:=ASCAN(aTabTaxas,{ |M|  M[1] == SW9->W9_MOE_FOB } )) # 0
         nTaxa:=aTabTaxas[nPos,2]
      ENDIF
   ENDIF
ELSEIF cTipTx == "FRETE"
   nTaxa:=SW6->W6_TX_FRET
ELSEIF cTipTx == "SEGURO"
   nTaxa:=SW6->W6_TX_SEG
ENDIF

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"DI154TAXAS"),) // Bete 26/11 - Trevo

RETURN nTaxa

*******************************
Static Function DI154DrawICMS()
*******************************
Local lRet := .T.
Local aOrd := SaveOrd({"SW8"})

SW8->( dbSetOrder(6) )
ED4->( dbSetOrder(2) )
ED0->( dbSetOrder(1) )

If SW8->( dbSeek(xFilial("SW8")+SW6->W6_HAWB+Work1->WKINVOICE+Work1->WKPO_NUM+Work1->WKPOSICAO+Work1->WKPGI_NUM) ) .AND.;
   ED4->( dbSeek(xFilial("ED4")+SW8->W8_AC+SW8->W8_SEQSIS) ) .AND.;
   ED0->( dbSeek(xFilial("ED0")+ED4->ED4_PD) ) .AND.;
   ED0->ED0_TIPOAC # "02" .AND.;
   ED0->ED0_MODAL == "1"
   
   lRet := .F.
EndIf

RestOrd(aOrd)
Return lRet

*--------------------------*
Function DI154_SWDVal(lBase)   // Bete 09/06 - Inclusao do par. p/ identificar o momento do cálculo da base de CIF ou ICMS 
*--------------------------*
LOCAL nInd:=0
DEFAULT lBase := .F.

PRIVATE nValor := SWD->WD_VALOR_R
PRIVATE lCalcBase := lBase     // Bete 09/06 - p/ rdmake     

IF lDespAuto 
   nInd:= ASCAN( aDespExecAuto, {|desp| desp[1] == SWD->WD_DESPESA } )
   nValor:= if(nInd>0,aDespExecAuto[nInd,2],0)
ENDIF

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"DI154_SWDVAL"),) // Jonato Trevo

RETURN nValor   
      
            
// RA - 24/10/03 - O.S. 1075/03 - Inicio
*----------------------*
Function DI154_PO_SIGA()
*----------------------*
Local cPO_Siga := SW2->W2_PO_SIGA
Local nSW2Pos  := SW2->(Recno())
Local nSW3Pos  := SW3->(Recno())
Local cFilSW2  := xFilial("SW2")
Local cFilSW3  := xFilial("SW3")

SW3->(DbSetOrder(8))
If (SW3->(DbSeek(cFilSW3+SW7->W7_PO_NUM+SW7->W7_POSICAO)))
   If !Empty(SW3->W3_PO_DA) // DI veio de uma DA
      SW2->(DbSetOrder(1))
      If (SW2->(DbSeek(cFilSW2+SW3->W3_PO_DA))) // SW2 da DA
         cPO_Siga := SW2->W2_PO_SIGA
         If (SW3->(DbSeek(cFilSW3+SW3->W3_PO_DA+SW3->W3_POSI_DA))) // SW3 da DA
            Work1->WKPOSSIGA := SW3->W3_POSICAO
         EndIf
         SW2->(DbGoTo(nSW2Pos))
      EndIf
   EndIf   
EndIf
SW3->(DbSetOrder(1))
SW3->(DbGoTo(nSW3Pos))

Return(cPO_Siga)
// RA - 24/10/03 - O.S. 1075/03 - Final
*------------------------------*
FUNCTION DI154Lote()
*------------------------------*
LOCAL D,J,C,N,nPosicao,lInvoice:=.F.,nTamReg:=AVSX3("WV_REG",3)
Local nQtdeLinha, nQtdeNF
Private lContLote:=.F.,nLote:=0,nTotFilh:=0,nFilhDisp:=0

Work1->(DBGOTOP())

ProcRegua(LEN(aRecWork1))

SIX->(DBSETORDER(1))
IF SIX->(DBSEEK("SWV2")) .AND. SWV->(FIELDPOS("WV_INVOICE")) # 0
   lInvoice:=.T.
   SWV->(DBSETORDER(2))
   bSeek :={|| Work1->(WKINVOICE+WKPGI_NUM+WKPO_NUM+WKPOSICAO) }
   bWhile:={|| SWV->WV_INVOICE == Work1->WKINVOICE.And.; 
               SWV->WV_PGI_NUM == Work1->WKPGI_NUM.And.; 
               SWV->WV_PO_NUM  == Work1->WKPO_NUM .And.; 
               SWV->WV_POSICAO == Work1->WKPOSICAO}
ELSE
   SWV->(DBSETORDER(1))
   bSeek :={|| Work1->(WKPGI_NUM+WKPO_NUM+WK_CC+WKSI_NUM+WKCOD_I+STR(WK_REG,nTamReg))}
   bWhile:={|| SWV->WV_PGI_NUM == Work1->WKPGI_NUM.And.; 
               SWV->WV_PO_NUM  == Work1->WKPO_NUM .And.; 
               SWV->WV_CC      == Work1->WK_CC    .And.; 
               SWV->WV_SI_NUM  == Work1->WKSI_NUM .And.; 
               SWV->WV_COD_I   == Work1->WKCOD_I  .And.; 
               SWV->WV_REG     == Work1->WK_REG}
ENDIF

//Campos que nao podem ser rateados
aCampos:={}
AADD(aCampos,"WK_DIASPAG")
AADD(aCampos,"WKICMS_A"  )
AADD(aCampos,"WKQTDE"    )
AADD(aCampos,"WKPRECO"   )
AADD(aCampos,"WKPRUNI"   )
AADD(aCampos,"WKIPITX"   )
AADD(aCampos,"WKIITX"    )
AADD(aCampos,"WKPR_II"   )
AADD(aCampos,"WKREC_ID"  )
AADD(aCampos,"WK_REG"    )
AADD(aCampos,"WK_QTMID"  )
AADD(aCampos,"WKICMS_RED")
AADD(aCampos,"WKICMSPC"  )
AADD(aCampos,"WKRECSW9"  )
AADD(aCampos,"WKVLUPIS"  )
AADD(aCampos,"WKPERPIS"  )
AADD(aCampos,"WKREDPIS"  )
AADD(aCampos,"WKVLUCOF"  )
AADD(aCampos,"WKPERCOF"  )
AADD(aCampos,"WKREDCOF"  )
AADD(aCampos,"WKALCOFM"  )//FDR - 28/02/13

If (lMV_NF_MAE .And. nTipoNF == NFE_FILHA)
   AADD(aCampos,"WKPESOL")
EndIf

aValor:={}   
DBSELECTAREA("Work1")
FOR nPosicao := 1 TO FCOUNT()
   IF VALTYPE(FIELDGET(nPosicao)) $ "CDL" .AND. ASCAN(aCampos,FIELD(nPosicao)) = 0
      AADD(aCampos,FIELD(nPosicao))
   ELSEIF VALTYPE(FIELDGET(nPosicao)) $ "N" .AND. ASCAN(aCampos,FIELD(nPosicao)) = 0
      AADD(aValor,{0,0,0,nPosicao})
   ENDIF
NEXT
   
aDados:=ARRAY(LEN(aCampos))

SW7->(DBSETORDER(1))
FOR N := 1 TO LEN(aRecWork1)

    Work1->(dbGoTo(aRecWork1[N]))

    IncProc( STR0376 +Work1->WKCOD_I) //STR0376 "Verificando Lotes, Item: "

    // *** Controle de quantidades da linha
	// Quantidade do item na linha original (que será quebrada)
	nQtdeLinha := Work1->WKQTDE
    nQtdeNF := GetQtdeNF()
    // ***

    lAchouSWV:= .F.
    IF LEFT(Work1->WKPGI_NUM,1) == "*" .OR. lInvoice
       lAchouSWV:=SWV->(dbSeek(xFilial()+SW6->W6_HAWB+EVAL(bSeek) ))
    ELSE
       lAchouSWV:=SWV->(dbSeek(xFilial()+SPACE(LEN(SWV->WV_HAWB))+EVAL(bSeek) ))
    ENDIF

    // *** Caso tenha lote, trata a quebra da linha
    IF lAchouSWV

       // *** Faz backup de todos os valores que serão rateados
       FOR D := 1 TO LEN(aValor)
          // -> aValor[x][1] - Valor do campo ANTES da quebra (total da linha)
          // -> aValor[x][4] - Posição do campo na Work1 (ID do campo)
	      aValor[D,1] := Work1->(FieldGet( aValor[D,4] ))
       NEXT
       // ***
           
       // *** ZERA o acumulador de valor já utilizado nas quebras dos itens
       AEVAL(aValor,{|t,I|aValor[I,2]:=0})
       // ***

       /*
       A linha atual da Work1 será a linha referente ao primeiro lote do item, com isso, sua quantidade será alterada para a 
       quantidade deste lote e todos os seus valores serão rateados de acordo com a nova quantidade.
       */
       // *** Executa o rateio pelo lote
       DI154RatLote(nQtdeLinha, nQtdeNF)
       // ***
	
	   SWV->(dbSkip())
	       
	   // *** Continua o tratamento para os demais lotes do mesmo item
	   DO While !SWV->(Eof())                     .And.;
	      SWV->WV_FILIAL  == xFilial("SWV") .And.;
	      SWV->WV_HAWB    == SW6->W6_HAWB .AND. EVAL(bWhile)
	   
	      // *** Faz backup dos campos que serão apenas copiados para a nova linha
	      For j := 1 To LEN(aCampos)
	         aDados[J]:=Work1->(FieldGet(FieldPos(aCampos[j])))
	      Next
	      // ***

          //Cria a nova linha para receber o lote atual
          Work1->(DBAPPEND())

          // *** Volta o backup dos campos (que não serão alterados ou rateados - comuns para todos as quebras)
          For j := 1 To LEN(aCampos)
             IF !EMPTY(aDados[J])
	            Work1->(FieldPut(FieldPos(aCampos[j]),aDados[J]))
	         ENDIF
          Next
         // ***

         /*
         A linha atual da Work1 será a nova linha referente ao lote atual do item. Com isso, sua quantidade será alterada para a 
         quantidade deste lote e todos os seus valores serão rateados de acordo com a nova quantidade. Lembrando que a quantidade da linha referente ao lote
         anterior não se refere obrigatoriamente à quantidade do item ou da nota filha, e sim do valor do item no lote.
         */
         // *** Executa o rateio pelo lote
         DI154RatLote(nQtdeLinha, nQtdeNF)
         // ***
	
	     SWV->(dbSkip())
	   EndDo
	   // *** Final da quebra por lotes
	   
	   //Diferenca  :=Total Original - Somatoria
	   FOR D := 1 TO LEN(aValor)
	      aValor[D,3]:= aValor[D,1] - aValor[D,2]
	      nValor := Work1->(FieldGet( aValor[D,4] )) + aValor[D,3]
	      Work1->(FieldPut( aValor[D,4] , nValor ))
	   NEXT

     Endif
     // *** Final da quebra de linha
	    
NEXT
 
Return(NIL)

*-----------------------------------------*
Function DI154RatLote(nQtdeLinha, nQtdeNF)
*-----------------------------------------*
Local P,nValor

If Type("lInvoice") <> "L"
   lInvoice:= .F.
EndIf

// *** Define a quantidade do item no lote e o percentual que este se refere com relação à LINHA ANTERIOR
Work1->WKQTDE    := SWV->WV_QTDE * (nQtdeLinha / nQtdeNF) //Quantidade do item no lote
nPerc := Work1->WKQTDE / nQtdeLinha						  //Quantidade do lote sobre a quantidade total do item na nota	
// ***
	
// *** Campos específicos do lote
Work1->WK_LOTE   :=SWV->WV_LOTE
Work1->WKDTVALID :=SWV->WV_DT_VALI
// ***

IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"GRV_WORK1"),)     //TRP - 05/07/2011 - Gravar na Work1 campos customizados da tabela SWV

//Rateio
FOR P := 1 TO LEN(aValor)
   nValor := aValor[P,1] * nPerc
   Work1->(FieldPut( aValor[P,4] , nValor ))
NEXT
//Somatoria
FOR P := 1 TO LEN(aValor)
   aValor[P,2]:= aValor[P,2] + Work1->(FieldGet( aValor[P,4] ))
NEXT

Return Nil

/*
	Busca a quantidade total da linha da Work1 a ser considerada para ser considerada na quebra dos lotes.
*/
*--------------------------*
Static Function GetQtdeNF()
*--------------------------*
Local aOrd
Local nQtdeNF := 0

	If Empty(Work1->WKNOTAOR+WKSERIEOR)
		//Quando não é nota filha, a quantidade é a própria quantidade da linha na Work1
		nQtdeNF := Work1->WKQTDE
	Else
		//Quando é nota filha, busca a quantidade do item na nota mãe, considerando lotes
		aOrd := SaveOrd("SWN")
		SWN->(DbSetOrder(3))
		If SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB+'5'))
			While SWN->(!EOF()) .And. xFilial("SW8")+SW6->W6_HAWB+'5' == xFilial("SWN")+SWN->WN_HAWB+SWN->WN_TIPO_NF 
				If SWN->(WN_FILIAL+WN_HAWB+WN_INVOICE+WN_PO_EIC+WN_ITEM+WN_PGI_NUM+WN_PRODUTO) == xFilial("SWN")+SW6->W6_HAWB+Work1->(WKINVOICE+WKPO_NUM+WKPOSICAO+WKPGI_NUM+WKCOD_I)
					nQtdeNF += SWN->WN_QUANT
				EndIf
				SWN->(DBSkip())
			EndDo
		EndIf
		RestOrd(aOrd, .T.)
	EndIf

Return nQtdeNF

*------------------------------*
Static Function Di154NfFilha()
*------------------------------*
Local nQtdeMae := 0

	Work1->(DbGoTop())
	While Work1->(!Eof())
		
		SWN->(DBSetOrder(3)) 
		// *** Verifica se existe nota mãe e guarda o Recno
		If SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB+"5")) .Or. SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB+"3")) .Or. SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB+"1")) //SVG - 07/04/2011 - Nota fiscal filha a partir da nota primeira , unica ou mãe.
			lAchouMae:=.F.
			While !lAchouMae .And. SWN->(!EOF()) .And. xFilial("SW8")+SW6->W6_HAWB == xFilial("SWN")+SWN->WN_HAWB
				If SWN->WN_TIPO_NF <> "2" .And. SWN->WN_TIPO_NF <> "6"
					If SWN->(WN_FILIAL+WN_HAWB+WN_INVOICE+WN_PO_EIC+WN_ITEM+WN_PGI_NUM+WN_PRODUTO) == xFilial("SWN")+SW6->W6_HAWB+Work1->(WKINVOICE+WKPO_NUM+WKPOSICAO+WKPGI_NUM+WKCOD_I) .And. (AllTrim(SWN->WN_LOTECTL) == AllTrim(Work1->WK_LOTE))
						Work1->WKRECMAE := SWN->(RECNO())
						If GETMV("MV_UNIDCOM",,2) == 2 // TRP - 24/10/2012
						   If !Empty(SWN->WN_QTSEGUM) .Or. SWN->WN_QTSEGUM <> 0   // GCC - 10/07/2013
						      nQtdeMae := SWN->WN_QTSEGUM
						   Else
						      nQtdeMae := SWN->WN_QUANT
						   EndIf
						Endif
						lAchouMae:=.T. 
					EndIf
				EndIf
				SWN->(DBSkip())
			EndDo
		EndIf
		// ***
		
		// *** Busca a quantidade já utilizada em outras notas filhas
		If SWN->(DBSEEK(xFilial("SWN")+SW6->W6_HAWB+STR(nTipoNF,1,0)))
			While SWN->(!EOF() .And. xFilial()+SW6->W6_HAWB+STR(nTipoNF,1,0) == WN_FILIAL+WN_HAWB+WN_TIPO_NF)
				If SWN->(WN_FILIAL+WN_HAWB+WN_INVOICE+WN_PO_EIC+WN_ITEM+WN_PGI_NUM+WN_PRODUTO) == xFilial("SWN")+SW6->W6_HAWB+Work1->(WKINVOICE+WKPO_NUM+WKPOSICAO+WKPGI_NUM+WKCOD_I) .And. (AllTrim(SWN->WN_LOTECTL) == AllTrim(Work1->WK_LOTE))
				   If GETMV("MV_UNIDCOM",,2) == 2  // TRP - 24/10/2012
					   If !Empty(SWN->WN_QTSEGUM) .Or. SWN->WN_QTSEGUM <> 0   // GCC - 10/07/2013				   
					      Work1->WKQTDEUTIL += SWN->WN_QTSEGUM
					   Else
					      Work1->WKQTDEUTIL += SWN->WN_QUANT
					   EndIf
				   Endif
				EndIf
				SWN->(DBSkip())
			EndDo
		EndIf
		
		If (Work1->WKSLDDISP := nQtdeMae - Work1->WKQTDEUTIL) <= 0
			// *** VER - Remover linha da Work1
		EndIf
		
		Work1->(DbSkip())
	EndDo
	Work1->(DbGoTop())
	
	IF(ExistBlock("EICDI154"),Execblock("EICDI154",.F.,.F.,"WORK1_NFFILHA"),) //FDR - 04/07/2013 - Permitir alteração na Work1

Return Nil

*--------------------------------------------------------------------*
Function DI154BrowseEIU()//Chamado do SXB, XB_ALIAS = 'EIU'
*--------------------------------------------------------------------*
LOCAL nPos,nTam, aCpos:={} //"Manutencao de "
LOCAL bOk:={||IF(DI154EIUValid(.T.),oDlgEI:End(),)}
LOCAL bCancel:={|| oDlgEI:End() },nAlias:=SELECT(), cFileTemp
LOCAL aRotina_Old := ACLONE(aRotina), lVisualiza_AD := .F.
LOCAL bWhile:={||.T.}, bFor:={||.T.}, T
LOCAL cIndiceEIU   //TRP-24/03/08

PRIVATE cArq,bValidEI
PRIVATE cCampo:=UPPER(READVAR())

If cPaisLoc # "BRA"
   Return D1156BrwEIU()
EndIf

DO CASE
CASE "EIU_CODIGO" $ UPPER(cCampo)
     IF cTipo_AD == "A"
        lREt:=ConPad1(,,,'SJN',,,.F.)
        IF lREt
           Work_Temp->EIU_CODIGO:=M->EIU_CODIGO:=SJN->JN_CODIGO
           Work_Temp->EIU_DESC:=M->EIU_DESC := SJN->JN_DESC
        ENDIF 
     ELSE
       lREt:=ConPad1(,,,'SJO',,,.F.)
       IF lREt
          Work_Temp->EIU_CODIGO:=M->EIU_CODIGO:=SJO->JO_CODIGO
          Work_Temp->EIU_DESC:=M->EIU_DESC := SJO->JO_DESC
       ENDIF
     ENDIF
     If lRet
        lExecF3 := .T.
     EndIf     
     RETURN .T.

CASE "CACRESCIMO" $ cCampo .OR. "CDEDUCOES" $ cCampo .OR. "CVERACRES" $ cCampo .OR. "CVERDEDUC" $ cCampo
     cArq:="EIU"
     bValidEI:={|| EMPTY(EIU_CODIGO) .OR. EMPTY(EIU_VALOR)}
     IF "CACRESCIMO" $ cCampo .OR. "CVERACRES" $ cCampo
        cTitulo := "Acrescimos"
        cTipo_AD:='A'
     ELSE 
        cTitulo := "Deducoes"
        cTipo_AD:='D'
     ENDIF
     IF "CVERACRES" $ cCampo .OR. "CVERDEDUC" $ cCampo
        lVisualiza_AD := .T.
        bFor:={|| Work_EIU->EIU_TIPO==cTipo_AD}
        Work_EIU->(DBGOTOP())
     ELSE
        bWhile:={|| Work_EIU->EIU_ADICAO==Work2->WKCOD_AD .AND. Work_EIU->EIU_TIPO==cTipo_AD}
        Work_EIU->(DBSEEK(Work2->WKCOD_AD+cTipo_AD))
     ENDIF
     aCpos:={'EIU_HAWB','EIU_TIPONF','EIU_ADICAO','EIU_TIPO'}//Tabelas de Campos que nao deve aparecer no MSGETDB
ENDCASE

aHeader:=ACLONE(aHeaderEIU)
cIndiceEIU := Work_EIU->(INDEXKEY())
aStru    := Work_EIU->(DBSTRUCT())
cFileTemp:= CriaTrab(aStru,.T.)
DBUSEAREA(.T.,,cFileTemp,"Work_TEMP",.F.)
IF !USED()
   Help(" ",1,"E_NAOHAREA")
   RETURN .F.
ENDIF
IndRegua("Work_Temp",cFileTemp+OrdBagExt(),cIndiceEIU)
Work_EIU->(DBEVAL( {|| DI154GrvTemp(.T.) },bFor,bWhile))

aHeader:=ACLONE(aHeaderEIU)

nPos:=0
nTam:=LEN(aHeader)-LEN(aCpos)
FOR T := 1 TO LEN(aCpos)//Tira os Campos que nao deve aparecer no MSGETDB
    IF (nPos:=ASCAN(aHeader,{|H|H[2]==aCpos[T]})) # 0
       ADEL(aHeader,nPos)
       ASIZE(aHeader,LEN(aHeader)-1)
    ENDIF
NEXT
IF(nPos#0,ASIZE(aHeader,nTam),)

aRotina := { {STR0377  ,"", 0, 1},; //STR0377 "Pesquisa"
             {STR0378  ,"", 0, 2},; //Visualizar  //STR0378 "Visualizar"
             {STR0379  ,"", 0, 3},; //Incluir  //STR0379 "Incluir"
             {STR0380  ,"", 0, 4} } //Alterar //STR0380 "Alterar"

IF lVisualiza_AD
   nPos:=2
ELSEIF Work_Temp->(LASTREC())==0             
   nPos:=3 // Inclusao  //Verifica se a MSGETDB deve aparecer com um registro em branco ou nao e serao editavel
ELSE
   nPos:=4 // Alteracao
ENDIF


dbSelectArea("WORK_TEMP")
Work_Temp->(DBSETORDER(0))
Work_Temp->(DBGOTOP())
DEFINE MSDIALOG oDlgEI TITLE cTitulo ; 
       FROM oMainWnd:nTop   +200,oMainWnd:nLeft +15;
       TO   oMainWnd:nBottom-200,oMainWnd:nRight-50 OF oMainWnd PIXEL

  oMarkEI:=MsGetDB():New(15,1,(oDlgEI:nClientHeight-6)/2,(oDlgEI:nClientWidth-4)/2,nPos,;
                     "DI154EIUValid(.F.)","","",.T.,,,.T.,,"Work_Temp")
  oMarkEI:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT       

ACTIVATE MSDIALOG oDlgEI ON INIT (EnchoiceBar(oDlgEI,bOk,bCancel,.F.), oMarkEI:oBrowse:Refresh()) CENTERED

Work_TEMP->(E_EraseArq(cArq))
SELECT(nAlias)
aRotina := ACLONE(aRotina_Old)

Return .T.

*--------------------------------------------------*
Function DI154GrvTemp(lGravaTemp)
*--------------------------------------------------*
LOCAL nRecOld:=0
IF lGravaTemp
   Work_TEMP->(DBAPPEND())
   AVREPLACE("Work_EIU","Work_TEMP")
   WORK_TEMP->WK_RECNO:=Work_EIU->(RECNO()) 
ELSE
   nRecOld:=0
   IF EMPTY(Work_TEMP->WK_RECNO)
      Work_EIU->(DBAPPEND())
   ELSE
      Work_EIU->(DBGOTO(Work_TEMP->WK_RECNO))
      nRecOld:=Work_EIU->WK_RECNO
   ENDIF
   AVREPLACE("Work_TEMP","Work_EIU")
   WORK_EIU->EIU_ADICAO := Work2->WKCOD_AD
   WORK_EIU->EIU_TIPO   := cTipo_AD
   WORK_EIU->WK_RECNO   := nRecOld
   IF cTipo_AD == "A" 
      M->WN_VLACRES += WORK_EIU->EIU_VALOR
   ELSE
      M->WN_VLDEDUC += WORK_EIU->EIU_VALOR
   ENDIF
ENDIF
RETURN .T.

*--------------------------------------------------*
Function DI154EIUValid(lTudo,cCpoEIU)//Esta funcao eh chamada do X3_RELACAO
*--------------------------------------------------*
LOCAL nRec:=Work_TEMP->(RECNO())
                              
//JVR - 22/06/10 - Novo tratamento para localizações.
If cPaisLoc # "BRA"
   Return DI156EIUValid(cCpoEIU)
EndIf

IF !lTudo
   IF cCpoEIU <> NIL
      IF cCpoEIU == "EIU_CODIGO"
         //Quando o F3 é executado, por algum problema na LIB, o contéudo da variável de memória é perdido. Então, utiliza-se o campo da Work_TEMP, que possui o mesmo conteúdo
         If lExecF3
            M->EIU_CODIGO := Work_Temp->EIU_CODIGO
         EndIf
         lRet := .T.
         IF cTipo_AD == 'A'
            lRet := Vazio() .OR. ExistCpo("SJN",M->EIU_CODIGO)
            SJN->(DBSEEK(xFilial()+M->EIU_CODIGO))
            M->EIU_DESC:=Work_TEMP->EIU_DESC:=SJN->JN_DESC
         ELSE
            lRet := Vazio() .OR. ExistCpo("SJO",M->EIU_CODIGO)
            SJO->(DBSEEK(xFilial()+M->EIU_CODIGO))
            M->EIU_DESC:=Work_TEMP->EIU_DESC:=SJO->JO_DESC
         ENDIF      
         oMarkEI:ForceRefresh()
         lExecF3 := .F.
         RETURN lRet

      ELSEIF cCpoEIU == "EIU_DESC"
         IF cTipo_AD == 'A'
            SJN->(DBSEEK(xFilial()+Work_TEMP->EIU_CODIGO))
            RETURN SJN->JN_DESC
         ELSE
            SJO->(DBSEEK(xFilial()+Work_TEMP->EIU_CODIGO))
            RETURN SJO->JO_DESC
         ENDIF      
      ENDIF
   ENDIF
   IF Work_TEMP->DELETE
      RETURN .T.
   ENDIF
   IF Work_TEMP->(EVAL(bValidEI))
      HELP(" ",1,"OBRIGAT")
      RETURN .F.
   ENDIF

ELSEIF lTudo                              
   IF cTipo_AD == "A"
      M->WN_VLACRES := 0
   ELSE
      M->WN_VLDEDUC := 0
   ENDIF
   Work_Temp->(DBSETORDER(1))
   Work_TEMP->(DBGOTOP())
   aDados :={}
   cCampos:=Work_TEMP->(INDEXKEY())
   cCampos:="Work_TEMP->("+cCampos+")"
   DO WHILE Work_TEMP->(!EOF())
      IF !Work_TEMP->DELETE
         IF Work_TEMP->(EVAL(bValidEI))
            HELP(" ",1,"OBRIGAT")
            Work_TEMP->(DBGOTO(nRec))
            Work_Temp->(DBSETORDER(0))
            RETURN .F.
         ENDIF
         cConteudo:=&(cCampos)
         IF ASCAN(aDados,cConteudo) = 0
            AADD(aDados,cConteudo)
         ELSE
            MSGINFO(STR0381+cConteudo,STR0022) //STR0381 "Existem registros repetidos"  //STR0022 := "Atenção"
            Work_TEMP->(DBGOTO(nRec))
            Work_Temp->(DBSETORDER(0))
            RETURN .F.
         ENDIF
      ENDIF
      Work_TEMP->(DBSKIP())
   ENDDO
   DBSELECTAREA('Work_TEMP')
   Work_TEMP->(DBGOTOP())
   DO WHILE Work_TEMP->(!EOF())
      IF Work_TEMP->DELETE
         IF !EMPTY(Work_TEMP->WK_RECNO) 
            Work_EIU->(DBGOTO(Work_TEMP->WK_RECNO))
            Work_EIU->(DBDELETE())
         ENDIF                          
         Work_TEMP->(DBDELETE())
         Work_TEMP->(DBSKIP())
         LOOP
      ENDIF

      DI154GrvTemp(.F.)

      Work_TEMP->(DBSKIP())

   ENDDO
   DBSELECTAREA("Work_EIU")
   PACK
ENDIF

Work_Temp->(DBSETORDER(0))

RETURN .T.


*--------------------------------------------------*
Function DI154AcresDeduc()
*--------------------------------------------------*
LOCAL oDlg_AD
LOCAL cVerAcres:=cVerDeduc:="Tecle F3"

nCo1:=.8
nCo2:=6
nL1:=1.4 

DEFINE MSDIALOG oDlg_AD TITLE STR0382 FROM 9,4 TO 19,50 Of oMainWnd //STR0382 "Acrécimos/Deduções"

   cTitAcres := AVSX3("WN_VLACRES",5)
   @nL1,nCo1 SAY cTitAcres
   @nL1,nCo2 MSGET cVerAcres PICTURE "@!" F3 "EIU" SIZE 40,07
   nL1+=1
   @nL1,nCo1 SAY cTitAcres
   @nL1,nCo2 MSGET nNBM_Acres PICTURE AVSX3("WN_VLACRES",6) WHEN .F. SIZE 60,07
   nL1+=1  
   cTitDeduc := AVSX3("WN_VLDEDUC",5)
   @nL1,nCo1 SAY cTitDeduc
   @nL1,nCo2 MSGET cVerDeduc PICTURE "@!" F3 "EIU" 
   nL1+=1                 
   @nL1,nCo1 SAY cTitDeduc
   @nL1,nCo2 MSGET nNBM_Deduc PICTURE AVSX3("WN_VLDEDUC",6) WHEN .F. SIZE 70,07

ACTIVATE MSDIALOG oDlg_AD ON INIT EnchoiceBar(oDlg_AD,{||oDlg_AD:End()},{||oDlg_AD:End()}) CENTERED

RETURN .T.

//AWR 27/08/2004 - SEM COBERTURA \\\\\\\\\\\\\\\\\\\\////////////////////////// \\\\\\\\\\\//////////////
*--------------------------------------------------*
Function DI154CustSemCobert()
*--------------------------------------------------*
IF !lTemItSemCob
   RETURN .F.
ENDIF
IF nTipoNF == CUSTO_REAL 
// Work1->(DBSETORDER(1))  Bete - controle por adição
   Work1->(DBSETORDER(6))
   Work2->(DBGOTOP())
   DO WHILE Work2->(!EOF())

      DI154IncProc(STR0137) //"Gravando impostos das NCMs"

//    IF Work1->(DbSeek(EVAL(bSeekWk1)))  Bete - controle por adição
      IF Work1->(DbSeek(Work2->WKADICAO))
         Work2->WKFOBRCOB := Work2->WKFOB_R
         Work2->WKFOB_R:= 0          
         Work2->WKCIF  := 0
//       DO WHILE !Work1->(EOF()) .AND. EVAL(bWhileWk)  Bete - controle por adição
         DO WHILE !Work1->(EOF()) .AND. Work1->WKADICAO == Work2->WKADICAO
            IF Work1->WKSEMCOBER
               Work1->WKFOBRCOB := Work1->WKFOB_R     
               nCIFNew        -= Work1->WKFOB_R          
               Work1->WKFOB_R  := 0                   
               IF EIJ->(DBSEEK(cFilEIJ+SW6->W6_HAWB+IF(!EMPTY(Work1->WKGRUPORT),Work1->WKGRUPORT,Work1->WKADICAO)))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
                  nBaseII:=0//Calculado dentro da funcao DI500IICalc()
                  DI500IICalc( "EIJ",Work1->WKFOB_R,Work1->WKFRETE,Work1->WKSEGURO,Work1->WKINCOTER,(Work1->WKDESPCIF+Work1->WKVLACRES-Work1->WKVLDEDUC),0,@nBaseII,.F.,0) // Bete 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
               ELSE
                  nBaseII:=DITrans(Work1->WKFOB_R+Work1->WKFRETE+Work1->WKSEGURO+Work1->WKDESPCIF+Work1->WKVLACRES-Work1->WKVLDEDUC,2)//CIF   // Bete 25/07/04 - Inclusao de acrescimos e deducoes na base de impostos
               ENDIF
               nDifCIF         :=(Work1->WKCIF - nBaseII)
               Work1->WKCIF    := nBaseII
               Work1->WKVALMERC:=(Work1->WKVALMERC-nDifCIF)
               Work1->WKPRUNI  :=(Work1->WKVALMERC / Work1->WKQTDE)
            ENDIF
            Work2->WKFOB_R+= Work1->WKFOB_R
            Work2->WKCIF  += Work1->WKCIF
            Work1->(DBSKIP())
         ENDDO
      ENDIF

      Work2->(DBSKIP())

   ENDDO
ENDIF
IF (nTipoNF == CUSTO_REAL  .AND. !lGravaWorks) .OR. lLerNota
   AADD(TB_Campos2,{{|| IF(Work1->WKSEMCOBER,STR0383,STR0384) },,STR0385}) //STR0383 "SEM Cobertura" //STR0384 "COM Cobertura" //STR0385 "Cobert. Cambial"
ENDIF
RETURN .T.


//TRP- 16/02/07 - Adiciona os campos de usuário no arquivo temporário
/*Static Function AddSemSx3(aSemSx3)

   AAdd(aSemSx3, {"WK_RECNO"  ,"N",10,00})
   
Return .T.*/

//AWR 27/08/2004 - SEM COBERTURA /////////////////////\\\\\\\\\\\\\\\\\\\\\\\ ///////////\\\\\\\\\\\\\\\


/*
Funcao      : DI154Diferido()
Parametros  : NIL
Retorno     : NIL
Objetivos   : Gravar os campos da Work com os valores de diferimento e credito presumido
Obs         :                                                   

*/

*-------------------------------------------------------------------------------------------*
Function DI154Diferido(lSWN)
*-------------------------------------------------------------------------------------------*
LOCAL nP := 0
DEFAULT lSWN := .F.

IF lSWN
   WORK1->WKVL_ICM_D := SWN->WN_VICMDIF
   WORK1->WKVLCREPRE := SWN->WN_VICM_CP   
   WORK1->WKVLICMDEV := DITRANS( (SWN->WN_BASEICM * (SWN->WN_ICMS_A/100) ), 2)

   If lICMS_Dif2  // EOB - 16/02/09
      WORK1->WK_PAG_DES := SWN->WN_PICM_PD
      WORK1->WK_PERCDIF := SWN->WN_PICMDIF  
      WORK1->WK_PCREPRE := SWN->WN_PICM_CP
      WORK1->WK_CRE_PRE := SWN->WN_PLIM_CP
   EndIf
ELSE
   WORK1->WKVLICMDEV := WORK1->WKVL_ICM                        
   IF (nP:=ASCAN( aICMS_Dif, {|x| x[1] == Work1->WK_OPERACA} )) > 0 
      cSuspensao := aICMS_Dif[nP,2]
      IF lICMS_Dif2
         WORK1->WK_PERCDIF := aICMS_Dif[nP,3] 
         WORK1->WK_PCREPRE := aICMS_Dif[nP,4]
         WORK1->WK_CRE_PRE := aICMS_Dif[nP,5]
         WORK1->WK_PAG_DES := aICMS_Dif[nP,6]
      ENDIF
      WORK1->WKVL_ICM_D := nVal_Dif
      WORK1->WKVLCREPRE := nVal_CP
      WORK1->WKVL_ICM   := nVal_ICM
      IF cSuspensao $ cSim
         WORK1->WKVL_ICM   := 0
         WORK1->WKBASE_DIF := Work1->WKBASEICMS
         WORK1->WKBASEICMS := 0
      ENDIF 
   ENDIF
ENDIF
                
RETURN NIL

/*
Funcao      : DI154TxSisc(cAdicao,nTotAdicao)
Parametros  : nAdicao    - Numero da Adicao a ter a Taxa Siscomex rateada
              nTotAdicao - Total de Adicoes da Nota Fiscal
Retorno     : nValTxSisc - Valor da Taxa Siscomex proporcional à Adicao passada como parâmetro
Objetivos   : Calcular o valor rateado por Adição da Taxa Siscomex.
Autor       : Pedro Baroni
Data/Hora   : 04/06/07
Obs.        : 
*/

*-------------------------------------------------------------------------------------------*
Function DI154TxSisc(nAdicao,nTotAdicao)
*-------------------------------------------------------------------------------------------*
  
 Local cFilSX5    := ""  ,;
       cTabela    := ""  ,;
       cAdicao    := ""  ,;
       nValTxSisc := 0       
       
   If Type("lTabSisAtu") == "L" .And. !lTabSisAtu
      If nIniTxComp == 30
         DI500AtuTab("R")
      Else
         DI500AtuTab("A")
      EndIF
   EndIf
   
   cFilSX5 := xFilial("SX5")
   cTabela := "C5"
   if(nAdicao>99,nAdicao:=99,)//JVR - 27/10/09 - verificação da nAdicao para casos com 3 digitos(acima de 99)/chumba 99
   cAdicao := PadR(StrZero(nAdicao,2),AvSX3("X5_CHAVE",AV_TAMANHO)," ")

   SX5->( DBSetOrder(1) )

   If SX5->( DBSeek(cFilSX5+cTabela+"00") )
      nValTxSisc := Val(SX5->X5_DESCRI) / nTotAdicao
   EndIf
   
   SX5->( DBSeek(cFilSX5+cTabela+cAdicao,.T.) )  // SoftSeek
   If SX5->( !EoF()  .And.  X5_FILIAL+X5_TABELA == cFilSX5+cTabela )
      nValTxSisc += Val(SX5->X5_DESCRI)
      nValTxComp := Val(SX5->X5_DESCRI)
   EndIf


Return nValTxSisc


/*
Funcao      : DI154VerAdi()
Objetivos   : Verificar os itens divergentes de uma adicao
Autor       : Elizabete O. Brito
Data/Hora   : 23/04/08
Obs.        : 
*/
*-------------------------------------------------------------------------------------------*
Function DI154VerAdi()
*-------------------------------------------------------------------------------------------*
Local cMensErro := ""

IF Work1->WKNROLI <> Work2->WKNROLI
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0387 + Work1->WKNROLI + STR0388 + Work2->WKNROLI //STR0386 "Para o item " //STR0387 " o numero da LI é "  //STR0388 " e a adição foi criada com " 
ELSEIF Work1->WKFORN <> Work2->WKFORN  
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0389 + Work1->WKFORN+EICRetLoja("WORK1", "WKLOJA") + STR0388 + Work2->WKFORN+EICRetLoja("WORK2", "WKLOJA") //STR0386 "Para o item " //STR0388 " e a adição foi criada com " //STR0389 " o fornecedor é "
ELSEIF Work1->WKFABR <> Work2->WKFABR
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0390  + Work1->WKFABR + STR0388 + Work2->WKFABR//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0390 " o fabricante é "
ELSEIF Work1->(WKTEC+WKEX_NCM+WKEX_NBM) <> Work2->(WKTEC+WKEX_NCM+WKEX_NBM)
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0391 + Work1->(WKTEC+WKEX_NCM+WKEX_NBM) + STR0388 + Work2->(WKTEC+WKEX_NCM+WKEX_NBM)//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0391 " a NCM é "
ELSEIF Work1->(WK_CONDPAG+STR(WK_DIASPAG,3,0)) <> Work2->(WK_CONDPAG+STR(WK_DIASPAG,3,0))
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0392 + Work1->(WK_CONDPAG+STR(WK_DIASPAG,3,0)) + STR0388 + Work2->(WK_CONDPAG+STR(WK_DIASPAG,3,0))//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0392 " a Cond.Pagto é "
ELSEIF Work1->WKMOEDA <> Work2->WKMOEDA
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0393 + Work1->WKMOEDA + STR0388 + Work2->WKMOEDA//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0393  " a Moeda é "
ELSEIF Work1->WKINCOTER <> Work2->WKINCOTER
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0394 + Work1->WKINCOTER + STR0388 + Work2->WKINCOTER //STR0386 "Para o item "//STR0388 " e a adição foi criada com "  //STR0394 " o Incoterm é "
ELSEIF Work1->WKREGTRII <> Work2->WKREGTRII
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0395 + Work1->WKREGTRII + STR0388 + Work2->WKREGTRII //STR0386 "Para o item "//STR0388 " e a adição foi criada com "  //STR0395 " o Regime II é "
ELSEIF Work1->WKFUNREG <> Work2->WKFUNREG
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0396 + Work1->WKFUNREG + STR0388 + Work2->WKFUNREG//STR0386 "Para o item "//STR0388 " e a adição foi criada com "  //STR0396 " o Fundamento II é "
ELSEIF Work1->WKMOTADI <> Work2->WKMOTADI
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0397 + Work1->WKMOTADI + STR0388 + Work2->WKMOTADI//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0397 " o Motivo é "
ELSEIF Work1->WKTACOII <> Work2->WKTACOII
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0398 + Work1->WKTACOII + STR0388 + Work2->WKTACOII//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0398  " o Tipo Acordo II é "
ELSEIF Work1->WKACO_II <> Work2->WKACO_II
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0399 + Work1->WKACO_II + STR0388 + Work2->WKACO_II//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0399 " o Acordo II é "
ELSEIF Work1->WKREGTRIPI <> Work2->WKREGTRIPI
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0400 + Work1->WKREGTRIPI + STR0388 + Work2->WKREGTRIPI//STR0386 "Para o item " //STR0388 " e a adição foi criada com " //STR0400 " o Regime IPI é " 
// SVG - 14/05/09 - 
//ELSEIF Work1->WK_OPERACA <> Work2->WK_OPERACA
//   cMensErro += "Para o item " + WORK1->WKCOD_I + " a Operacao é " + Work1->WK_OPERACA + " e a adição foi criada com " + Work2->WK_OPERACA

ELSEIF Work1->WKNVE <> Work2->WKNVE
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0401 + Work1->WKNVE + STR0388 + Work2->WKNVE//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0401 " o NVE é "
ELSEIF lAUTPCDI .AND. Work1->WKREG_PC <> Work2->WKREG_PC
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0402  + Work1->WKREG_PC + STR0388 + Work2->WKREG_PC//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0402 " o Regime PIS/COF é "
ELSEIF lAUTPCDI .AND. Work1->WKFUN_PC <> Work1->WKFUN_PC
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0403  + Work1->WKFUN_PC + STR0388 + Work2->WKFUN_PC//STR0386 "Para o item "//STR0388 " e a adição foi criada com " //STR0403 " o Fundamento PIS/COF é "
ELSEIF lAUTPCDI .AND. Work1->WKFRB_PC <> Work1->WKFRB_PC
   cMensErro += STR0386 + WORK1->WKCOD_I + STR0404  + Work1->WKFRB_PC + STR0388 + Work2->WKFRB_PC//STR0386 "Para o item " //STR0388 " e a adição foi criada com " //STR0404 " o Fund.Red.Base PIS/COF é "
ENDIF
RETURN cMensErro
/*
Funcao..: BuscaLocPNota()
Autor...: Alessandro Alves Ferreira
Data....: 16/09/2008
Objetivo: Busca o local de entrega do item na Nota Primeira
Uso.....: Apenas para Nota Complementar considerando SW6 e Work1 posicionado
Retorno.: Local de Entrega utilizado na emissão da Primeira Nota para o Item Posicionado no Work1
*/
*******************************
Static Function BuscaLocPNota()
*******************************
Local nOrdSD1 := SD1->(IndexOrd())
Local nRegSD1 := SD1->(RecNo())
Local cFilSD1 := xFilial("SD1")
Local nOrdSWN := SWN->(IndexOrd())
Local nRegSWN := SWN->(RecNo())
Local cFilSWN := xFilial("SWN")
Local nOrdSF1 := SF1->(IndexOrd())
Local nRegSF1 := SF1->(RecNo())
Local cFilSF1 := xFilial("SF1")
Local lAchou  := .F.
Local cLoc    := ""

SF1->(dbSetOrder(5))//F1_FILIAL+F1_HAWB+F1_TIPO_NF+F1_DOC+F1_SERIE
SWN->(dbSetOrder(1))//WN_FILIAL+WN_DOC+WN_SERIE+WN_TEC+WN_EX_NCM+WN_EX_NBM
SD1->(dbSetOrder(1))

SF1->(dbSeek(cFilSF1+SW6->W6_HAWB))
//ISS - 13/12/10 - Verificação se o HAWB corrente possui alguma nota gerada, e não apenas notas de despesas (NFD)
Do While SF1->(F1_FILIAL+F1_HAWB) == cFilSF1+SW6->W6_HAWB .AND. !lAchou .AND. If(lCposNFDesp,ExistHAWBNFE(SF1->F1_HAWB),.T.)
   
   SWN->(dbSeek(cFilSWN+SF1->(F1_DOC+F1_SERIE)+Work1->(WKTEC+WKEX_NCM+WKEX_NBM)))
   Do While SWN->(WN_FILIAL+WN_DOC+WN_SERIE+WN_TEC+WN_EX_NCM+WN_EX_NBM) == cFilSWN+SF1->(F1_DOC+F1_SERIE)+Work1->(WKTEC+WKEX_NCM+WKEX_NBM) .AND. !lAchou
      
      If SWN->(WN_HAWB+WN_INVOICE+WN_PO_EIC+WN_ITEM+WN_PGI_NUM) == SW6->W6_HAWB+Work1->(WKINVOICE+WKPO_NUM+WKPOSICAO+WKPGI_NUM)
         
         SD1->(dbSeek(cFilSD1+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA))
         DO WHILE SD1->(!EOF()) .AND.;
                  SD1->D1_FILIAL == cFilSD1 .AND.;
                  SD1->D1_DOC    == SF1->F1_DOC    .AND.;
                  SD1->D1_SERIE  == SF1->F1_SERIE  .AND.;
                  SD1->D1_FORNECE== SF1->F1_FORNECE.AND.;
                  SD1->D1_LOJA   == SF1->F1_LOJA
            
            If SD1->D1_ITEM == StrZero(SWN->WN_LINHA,4)//SD1->(D1_COD+D1_PEDIDO+D1_ITEMPC+D1_CONHEC) == Work1->(WKCOD_I+WKPO_SIGA+WKPOSICAO+SW6->W6_HAWB)
               cLoc := SD1->D1_LOCAL
               lAchou := .T.
               EXIT
            EndIf
            
            SD1->(dbSkip())
         EndDo
         
      EndIf
      
      SWN->(dbSkip())
   EndDo
   
   SF1->(dbSkip())
EndDo

SF1->(dbSetOrder(nOrdSF1))
SF1->(dbGoTo(nRegSF1))

SD1->(dbSetOrder(nOrdSD1))
SD1->(dbGoTo(nRegSD1))

SD1->(dbSetOrder(nOrdSWN))
SD1->(dbGoTo(nRegSWN))

Return cLoc          

/*------------------------------------------------------------------------------------
Funcao      : DeduFretN
Parametros  : 
Retorno     : 
Objetivos   : Dedução automática do frete nacional para incoterms CPT, CIP e DDU
Autor       : Anderson Soares Toledo
Data/Hora   : 02/02/09
Revisao     :
Obs.        : 
*------------------------------------------------------------------------------------*/
Static Function DeduFretN()
   Local nFreteRat := 0 // Valor do frete rateado para as adições    
   Local nGrupoInc := 0 // nº de adições com incoterm do grupo: CPT, CIP e DDU, utilizada para verificar
                        // por quantas adições será realizado o rateio
   Local nPesoTot  := 0 //SVG - 14/07/2009 - Armazenar o Peso Total para utilização no rateio por peso
   
   If SW6->W6_VLFRETN > 0 //Verifica se existe frete nacional
      While !Work2->(EOF())   
         If AvRetInco(Work2->WKINCOTER,"CONTEM_FRETEN")/*FDR - 27/12/11*/  //Work2->WKINCOTER $ "CPT,CIP,DDU"
            nGrupoInc++      
            nPesoTot += Work2->WKPESOL //SVG - 14/07/2009
         EndIf   
         Work2->(dbSkip())
      EndDo
      If nGrupoInc > 0
         If MsgYesNo(STR0405) //STR0405 "Deseja realizar a dedução automática do frete nacional para os incoterms CPT,CIP e DDU?"      
            Work2->(dbGoTop())
            While !Work2->(EOF())   
               If Work2->WKINCOTER $ "CPT,CIP,DDU"
                  If !Work_EIU->(dbSeek(Work2->WKADICAO+"D"+"01")) 
                     nFreteRat := (SW6->W6_VLFRETN * SW6->W6_TX_FRET * Work2->WKPESOL)/nPesoTot //SVG - 14/07/2009
                     Work_EIU->(dbAppend())
                     Work_EIU->EIU_ADICAO  := Work2->WKADICAO                   
                     Work_EIU->EIU_TIPO    := "D"
                     Work_EIU->EIU_CODIGO  := "01"
                     Work_EIU->EIU_DESC    := "FRETE INTERNO - PAIS DE IMPORTACAO"                          
                     Work_EIU->EIU_VALOR   := nFreteRat
                     RecLock("Work2",.F.)
                        Work2->WKVLDEDUC += nFreteRat 
                     Work2->(MsUnlock())   
                  EndIf  
               EndIf
               Work2->(dbSkip())
            EndDo
            Processa({|| DI154Recalc() },STR0147) //"Pesquisando NBMs..."
         EndIf
      EndIf
   EndIf 
      
   Work2->(dbGoTop())  
return 


/*------------------------------------------------------------------------------------
Funcao      : GetValICMS
Parametros  : cNF        - Número da nota de entrada
              cSerie     - Série da nota de entrada
              cForn      - Fornecedor da nota de entrada
              cLoja      - Loja do fornecedor da nota de entrada
              cTipoNF    - Tipo da NF de entrada, sendo 1=Primeira, 2=Complementar e 3=Única
              cPedido    - Número do pedido 
              cItem      - Sequencial que identifica o item do pedido
Retorno     : Vetor com os valores calculados de ICMS
Autor       : Elizabete de Oliveira Brito
Data/Hora   : 19/02/2009 
Revisao     :
Obs.        :
*------------------------------------------------------------------------------------*/
Function GetValICMS(cNF,cSerie,cForn,cLoja,cTipoNF,cPedido,cItem)
Local aValICMS := {}

lICMS_Dif  := SWZ->( FieldPos("WZ_ICMSUSP") > 0  .And.  FieldPos("WZ_ICMSDIF") > 0  .And.  FieldPos("WZ_ICMS_CP") > 0  .And.  FieldPos("WZ_ICMS_PD") > 0  )  ;
              .And.  SWN->( FieldPos("WN_VICM_PD") > 0  .And.  FieldPos("WN_VICMDIF") > 0  .And.  FieldPos("WN_VICM_CP") > 0 )
        
lICMS_Dif2 := SWZ->( FieldPos("WZ_PCREPRE") ) > 0 .AND. SWN->( FieldPos("WN_PICM_PD") > 0  .And.  FieldPos("WN_PICMDIF") > 0  .And.  FieldPos("WN_PICM_CP") > 0 .And. FieldPos("WN_PLIM_CP") > 0 )


SWN->(dbSetOrder(2)) // WN_FILIAL+WN_DOC+WN_SERIE+WN_FORNECE+WN_LOJA

cNF        := alltrim(cNF)
cSerie     := alltrim(cSerie)
cForn      := alltrim(cForn)
cLoja      := alltrim(cLoja)
cTipoNF    := alltrim(cTipoNF)
cPedido    := alltrim(cPedido)
cItem      := alltrim(cItem)
                        
IF !lICMS_Dif
   Alert(STR0406) //STR0406 "Não existem os campos referente a diferimento e credito presumido de ICMS."
   Return aValICMS := {}                       
ENDIF   

//Validação dos parâmetros, caso algum esteja incorreto, retorna um vetor vazio
If cTipoNF # "1" .AND. cTipoNF #"3"
   Alert(STR0407) //STR0407 "Tipo da NF diferente de primeira ou única."
   Return aValICMS := {}                       
ENDIF

//Verifica se não existe nenhum parametro em branco.
If Empty(cNF) .Or. Empty(cSerie) .Or. Empty(cForn) .Or. Empty(cLoja).Or. Empty(cPedido).Or. Empty(cItem)
   Alert(STR0408) //STR0408 "Há parametros não informados, impossibilitando chegar ao item da NF."
   Return aValICMS := {}
EndIf

SWZ->(dbSetOrder(1))

If SWN->(dbSeek(xFilial("SWN")+AvKey(cNF,"WN_DOC")+AvKey(cSerie,"WN_SERIE")+AvKey(cForn,"WN_FORNECE")+AvKey(cLoja,"WN_LOJA")))
   While SWN->(!EOF()) .And. cNF == alltrim(SWN->WN_DOC) .And. cSerie == alltrim(SWN->WN_SERIE) .And.;
                             cForn == alltrim(SWN->WN_FORNECE) .And. cLoja == alltrim(SWN->WN_LOJA)

      If cTipoNF == alltrim(SWN->WN_TIPO_NF) .And. cPedido == alltrim(SWN->WN_PO_NUM) .And. cItem == alltrim(SWN->WN_ITEM)
         SWZ->(DbSeek(xFilial("SWZ")+SWN->WN_CFO+SWN->WN_OPERACA))
         IF SWZ->WZ_ICMSUSP $ cSim
            nRed_ICMS := IF(SWZ->WZ_RED_ICM#0,(100-SWZ->WZ_RED_ICM)/100,1)
            nBaseICMS := DI154CalcICMS(,nRed_ICMS,SWN->WN_ICMS_A,SWZ->WZ_RED_CTE,SWN->WN_CIF,IF(SWN->(FIELDPOS("WN_DESPICM"))>0,SWN->WN_DESPICM,0),,SWN->WN_IIVAL,SWN->WN_IPIVAL,.T.,SWN->WN_VLRPIS,SWN->WN_VLRCOF)            
            aAdd(aValICMS,nBaseICMS)   // base de ICMS
            aAdd(aValICMS,DITRANS( (nBaseICMS * (SWN->WN_ICMS_A/100)), 2 )) // valor do ICMS cheio
         ELSE
            aAdd(aValICMS,SWN->WN_BASEICM)   // base de ICMS
            aAdd(aValICMS,DITRANS( (SWN->WN_BASEICM * (SWN->WN_ICMS_A/100)), 2 )) // valor do ICMS cheio
         ENDIF 
         aAdd(aValICMS,IF(lICMS_Dif2, SWN->WN_PICMDIF, SWZ->WZ_ICMSDIF))       // % de diferimento
         aAdd(aValICMS,SWN->WN_VICMDIF)   // valor do diferimento
		 aAdd(aValICMS,IF(lICMS_Dif2, SWN->WN_PICM_CP, 0))   // % crédito presumido         
		 aAdd(aValICMS,IF(lICMS_Dif2, SWN->WN_PLIM_CP, SWZ->WZ_ICMS_CP))       // % max credito presumido
		 aAdd(aValICMS,SWN->WN_VICM_CP)   // valor do credito presumido
 		 aAdd(aValICMS,IF(lICMS_Dif2, SWN->WN_PICM_PD, SWZ->WZ_ICMS_PD))       // % min ICMS a recolher
		 aAdd(aValICMS,SWN->WN_VL_ICM )   // valor do ICMS a recolher
      EndIf
      SWN->(dbSkip())
   ENDDO
Else
   Alert(STR0409) //STR0409 "Nota fiscal não encontrada."
   Return aValICMS := {}
EndIf          

RETURN aValICMS   

/*------------------------------------------------------------------------------------
Funcao      : DI154Ord
Parametros  : 
Retorno     : 
Objetivos   : Ordenação da gravação da Work1 respeitando a ordem do Cindice
Autor       : Saimon Vinicius Gava
Data/Hora   : 17/03/09
Revisao     :
Obs.        : 
*------------------------------------------------------------------------------------*/
Static Function DI154Ord()
Local nGruPort
Local aOrd_Stru:={{"WKNROLI"   ,"C",LEN(SWP->WP_REGIST) ,0},;
                    {"WKFORN"    ,"C",LEN(SW7->W7_FORN)   ,0},;
                    {"WKFABR"    ,"C",LEN(SW7->W7_FABR)   ,0},;                    
                    {"WKTEC"     ,"C",10,0},;
                    {"WKEX_NCM"  ,"C",LEN(SB1->B1_EX_NCM),0},;
                    {"WKEX_NBM"  ,"C",LEN(SB1->B1_EX_NBM),0},;
                    {"WK_CONDPAG","C",05,0},;
                    {"WK_DIASPAG","N",03,0},;
                    {"WKMOEDA"   ,"C",03,0},;
                    {"WKINCOTER" ,"C",03,0},;
                    {"WKREGTRII" ,"C",01,0},;
                    {"WKFUNREG ",AVSX3("EIJ_FUNREG ",AV_TIPO),AVSX3("EIJ_FUNREG ",AV_TAMANHO),AVSX3("EIJ_FUNREG ",AV_DECIMAL)},;
                    {"WKMOTADI",AVSX3("EIJ_MOTADI",AV_TIPO),AVSX3("EIJ_MOTADI",AV_TAMANHO),AVSX3("EIJ_MOTADI",AV_DECIMAL)},;
                    {"WKTACOII",AVSX3("W8_TACOII",AV_TIPO),AVSX3("W8_TACOII",AV_TAMANHO),AVSX3("W8_TACOII",AV_DECIMAL)},;
                    {"WKACO_II",AVSX3("W8_ACO_II",AV_TIPO),AVSX3("W8_ACO_II",AV_TAMANHO),AVSX3("W8_ACO_II",AV_DECIMAL)},;
                    {"WKREGTRIPI","C",01,0},;
                    {"WK_OPERACA","C",LEN(SW7->W7_OPERACA),0},;
                    {"WKNVE",AVSX3("W8_NVE",AV_TIPO),AVSX3("W8_NVE",AV_TAMANHO),AVSX3("W8_NVE",AV_DECIMAL)},;
                    {"WKREG_PC",AVSX3("W8_REG_PC",AV_TIPO),AVSX3("W8_REG_PC",AV_TAMANHO),AVSX3("W8_REG_PC",AV_DECIMAL)},;
                    {"WKFUN_PC",AVSX3("W8_FUN_PC",AV_TIPO),AVSX3("W8_FUN_PC",AV_TAMANHO),AVSX3("W8_FUN_PC",AV_DECIMAL)},;
                    {"WKFRB_PC",AVSX3("W8_FRB_PC",AV_TIPO),AVSX3("W8_FRB_PC",AV_TAMANHO),AVSX3("W8_FRB_PC",AV_DECIMAL)},;
                    {"WKRECNOSW8","N",10,0}}
Private cFileTrb_Adi

Private aCampos := {}, aHeader := {}

If EICLoja()
   aAdd(aOrd_Stru, {"WKFABLOJ", "C", AvSx3("W7_FABLOJ", AV_TAMANHO, 0)})
   aAdd(aOrd_Stru, {"WKLOJA", "C", AvSx3("W7_FORLOJ", AV_TAMANHO, 0)})
EndIf

DbSelectArea("SW8")
cFileTrb_Adi := E_CriaTrab(,aOrd_Stru,"TRB_ADI")                 
IndRegua("TRB_ADI",cFileTrb_Adi+OrdBagExt(),cIndice)

Do While  !SW8->(Eof()) .AND. SW8->W8_FILIAL == cFilSW8 .AND. SW8->W8_HAWB == SW6->W6_HAWB

   SWP->(DBSEEK(cFilSWP+SW8->W8_PGI_NUM+SW8->W8_SEQ_LI))
   
   IF !lExisteSEQ_ADI .And. !Empty(SW8->W8_ADICAO) .And. EIJ->(DbSeek(xFilial()+SW8->W8_HAWB+SW8->W8_ADICAO))
      nGruPort := SW8->W8_ADICAO
   EndIf
   IF lExisteSEQ_ADI
      nGruPort:= SW8->W8_GRUPORT
   EndIF
   TRB_ADI->(DBAPPEND())
   TRB_ADI->WKNROLI   := SWP->WP_REGIST
   TRB_ADI->WKFORN    := SW8->W8_FORN
   TRB_ADI->WKFABR    := SW8->W8_FABR
   If EICLoja()
      TRB_ADI->WKLOJA := SW8->W8_FORLOJ
      TRB_ADI->WKFABLOJ := SW8->W8_FABLOJ
   EndIf
   TRB_ADI->WKTEC     := SW8->W8_TEC
   TRB_ADI->WKEX_NCM  := SW8->W8_EX_NCM
   TRB_ADI->WKEX_NBM  := SW8->W8_EX_NBM
   TRB_ADI->WK_CONDPAG:= SW9->W9_COND_PA
   TRB_ADI->WK_DIASPAG:= SW9->W9_DIAS_PA
   TRB_ADI->WKMOEDA   := SW9->W9_MOE_FOB
   TRB_ADI->WKINCOTER := SW9->W9_INCOTER
   TRB_ADI->WKREGTRII := SW8->W8_REGTRI
   If EIJ->(DBSeek(cFilEIJ+SW6->W6_HAWB+IF(!Empty(nGruPort),nGruPort,SW8->W8_ADICAO)))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
      TRB_ADI->WKFUNREG := EIJ->EIJ_FUNREG
      TRB_ADI->WKMOTADI := EIJ->EIJ_MOTADI
   EndIf
   TRB_ADI->WKTACOII := SW8->W8_TACOII
   TRB_ADI->WKACO_II := SW8->W8_ACO_II
   TRB_ADI->WKREGTRIPI := SW8->W8_REGIPI
   If lQbgOperaca
      cOperacao:=If(Empty(SW8->W8_OPERACA),SW7->W7_OPERACA,SW8->W8_OPERACA)
   Else
      cOperacao:=SW7->W7_OPERACA
   EndIf

   TRB_ADI->WK_OPERACA:= cOperacao
   TRB_ADI->WKNVE := SW8->W8_NVE
   TRB_ADI->WKREG_PC := SW8->W8_REG_PC
   TRB_ADI->WKFUN_PC := SW8->W8_FUN_PC
   TRB_ADI->WKFRB_PC := SW8->W8_FRB_PC
   TRB_ADI->WKRECNOSW8 := SW8->(Recno())
   
   SW8->(DbSkip())
EndDo

Return Nil

*--------------------------------------------------------------------
STATIC FUNCTION VERLOG(cP_MEMO)                                                                  // LCS.18/05/2009.17:17
LOCAL oDLG,bOK,bCANCEL,nBTOP,aBUTTONS,oMEMO,aPOS,mLOG,nA                                         // LCS.18/05/2009.17:17
*                                                                                                // LCS.18/05/2009.17:17
bOK      := {|| nBTOP := 1,oDLG:END()}                                                           // LCS.18/05/2009.17:17
bCANCEL  := {|| nBTOP := 0,oDLG:END()}                                                           // LCS.18/05/2009.17:17
aBUTTONS := {}                                                                                   // LCS.18/05/2009.17:17
nBTOP    := 0                                                                                    // LCS.18/05/2009.17:17
cP_MEMO  := IF(cP_MEMO==NIL,"",cP_MEMO)                                                          // LCS.18/05/2009.17:17
mLOG     := ""                                                                                   // LCS.18/05/2009.17:17
FOR nA := 1 TO MLCOUNT(cP_MEMO,80)                                                               // LCS.18/05/2009.17:17
    mLOG := mLOG+MEMOLINE(cP_MEMO,80,nA)+ENTER                                                   // LCS.18/05/2009.17:17
NEXT                                                                                             // LCS.18/05/2009.17:17
DEFINE MSDIALOG oDLG TITLE "Atenção!" FROM 00,00 TO 300,450 OF oMainWnd PIXEL                    // LCS.18/05/2009.17:17
   aPOS := POSDLG(oDLG)                                                                          // LCS.18/05/2009.17:17
   @ 13,01 GET oMemo VAR mLOG MEMO HSCROLL SIZE aPOS[4],aPOS[3]-10 READONLY OF oDLG UPDATE PIXEL // LCS.18/05/2009.17:17
   oMEMO:ENABLEVSCROLL(.T.)                                                                      // LCS.18/05/2009.17:17
   oMEMO:ENABLEHSCROLL(.T.)                                                                      // LCS.18/05/2009.17:17
   oMEMO:REFRESH()                                                                               // LCS.18/05/2009.17:17
ACTIVATE MSDIALOG oDLG ON INIT ENCHOICEBAR(oDLG,bOK,bCANCEL,,aBUTTONS) CENTERED                  // LCS.18/05/2009.17:17
RETURN(NIL)                                                                                      // LCS.18/05/2009.17:17
*--------------------------------------------------------------------
/*------------------------------------------------------------------------------------
Funcao      : DI154GrvWK2
Parametros  : 
Retorno     : 
Objetivos   : Gravação da Work2
Autor       : Saimon Vinicius Gava
Data/Hora   : 04/11/2009
Revisao     :
Obs.        : 
*------------------------------------------------------------------------------------*/
Function DI154GrvWK2()  

//SVG - 07/07/09 - 
IF EMPTY(Work1->WKADICAO)
   Work2->(dbSetorder(1))
   lSeekWk2 := Work2->(DbSeek(EVAL(bSeekWk2)))
ELSE
   Work2->(dbSetorder(2))
   lSeekWk2 := Work2->(DbSeek(Work1->WKADICAO))
ENDIF   
lNovaAdi := .F.
DO WHILE .T.
   IF !lSeekWk2 .OR. lNovaAdi//Work2->(DbSeek(EVAL(bSeekWk2))) .OR. lNovaAdi
      IF !EMPTY(WORK1->WKADICAO) .AND. (nTipoNF == NFE_PRIMEIRA .Or. nTipoNF == NFE_MAE .OR. !lTemPrimeira)
         nOrdWK2 := Work2->(IndexOrd())
         nRegWK2 := Work2->(Recno())
         WORK2->(dbSetOrder(2))     
         IF WORK2->(dbSeek(WORK1->WKADICAO))
            cMensErro := Di154VerAdi()
            IF !Empty(cMensErro)
               MSGINFO(STR0410 + Work1->WKADICAO + ":" + CHR(13)+CHR(10)+ cMensErro ) //STR0410 "Atencao! Não é possivel gerar a nota. Foram encontradas divergencias na adicao: "
               RETURN .F.
            ENDIF
         ENDIF         
         Work2->(dbSetOrder(nOrdWK2))
         Work2->(dbGoto(nRegWK2))
      ENDIF
            
      Work2->(DBAPPEND())        
   
      // Bete - controle por adição
      If Val(Work1->WKADICAO) > nSeqAdicao
         nSeqAdicao := Val(Work1->WKADICAO) 
      Else
         nSeqAdicao++
      EndIf
         
      Work2->WKADICAO := If(Empty(Work1->WKADICAO),STRZERO(nSeqAdicao,LEN(SW8->W8_ADICAO)),Work1->WKADICAO)
      AADD(aContrAdicao,{If(Empty(Work1->WKADICAO),nSeqAdicao,Val(Work1->WKADICAO)),1})
         
      //
      Work2->WKNROLI   := SWP->WP_REGIST
      Work2->WKFORN    := SW8->W8_FORN
      Work2->WKNOME    := SA2->A2_NOME  //TRP-26/10/07
      Work2->WKFABR    := SW8->W8_FABR
      
      If EICLoja()
         Work2->WKLOJA := SW8->W8_FORLOJ
         Work2->WKFABLOJ := SW8->W8_FABLOJ
      EndIf
      
      Work2->WKTEC     := M->WK_TEC
      Work2->WKEX_NCM  := M->WK_EX_NCM
      Work2->WKEX_NBM  := M->WK_EX_NBM
      Work2->WK_CONDPAG:= SW9->W9_COND_PA
      Work2->WK_DIASPAG:= SW9->W9_DIAS_PA
      Work2->WKMOEDA   := SW9->W9_MOE_FOB
      Work2->WKINCOTER := SW9->W9_INCOTER
      Work2->WK_CFO    := SWZ->WZ_CFO
      Work2->WK_OPERACA:= Work1->WK_OPERACA//SW7->W7_OPERACA - //AWR - 18/09/08 - NFE
      Work2->TRB_ALI_WT := "SW9"
      Work2->TRB_REC_WT := SW9->(Recno())

//    IF nTipoNF # NFE_COMPLEMEN .OR. lICMS_NFC
      IF lImpostos .OR. lICMS_NFC      // Bete 23/11 - Trevo
         IF !SWZ->(EOF())
            Work2->WKICMS_A  := DITRANS(SWZ->WZ_AL_ICMS,2)
            Work2->WKICMS_RED:= IF(SWZ->WZ_RED_ICM#0,(100-SWZ->WZ_RED_ICM)/100,1)
            Work2->WKRED_CTE := SWZ->WZ_RED_CTE
            IF SWZ->(FIELDPOS("WZ_ICMS_PC")) # 0
               Work2->WKICMSPC := SWZ->WZ_ICMS_PC//ASR - 10/10/2005
            ENDIF
			// EOB 16/02/09                                   
			IF lICMS_Dif .AND. ASCAN( aICMS_Dif, {|x| x[1] == Work1->WK_OPERACA} ) == 0
               //                Operação           Suspensao        % diferimento    % Credito presumido                % Limite Cred.   % pg desembaraco
               AADD( aICMS_Dif, {Work1->WK_OPERACA, SWZ->WZ_ICMSUSP, SWZ->WZ_ICMSDIF, IF( lICMS_Dif2, SWZ->WZ_PCREPRE, 0), SWZ->WZ_ICMS_CP, SWZ->WZ_ICMS_PD, SWZ->WZ_AL_ICMS, SWZ->WZ_ICMS_PC} )
      		ENDIF
         ELSE
            Work2->WKICMS_A  := DITRANS(SYD->YD_ICMS_RE,2)
            Work2->WKICMS_RED:= 1
            IF SYD->(FIELDPOS("YD_ICMS_PC")) # 0                                            //NCF - 10/06/2011 - Aliq. De ICMS para PIS/COFINS na N.c.m
               Work2->WKICMSPC := SYD->YD_ICMS_PC
            ENDIF  
         ENDIF
      ENDIF
      IF lImpostos   // Bete 23/11 - Trevo
         Work2->WKII_A   := SYD->YD_PER_II
         Work2->WKIPI_A  := SYD->YD_PER_IPI
      ENDIF
      //** PLB 04/06/07 - Rateio TX SISCOMEX sem DI Eletronica.
      If  EIJ->(DBSeek(cFilEIJ+SW6->W6_HAWB+Work1->WKGRUPORT))  // EOB - 02/06/08 - para considerar o regime tributário informado no desembaraço
          Work2->WKFUNREG  := EIJ->EIJ_FUNREG
          Work2->WKMOTADI  := EIJ->EIJ_MOTADI
      EndIf
      Work2->WKTACOII  := SW8->W8_TACOII
      Work2->WKACO_II  := SW8->W8_ACO_II
      Work2->WKREGTRII := SW8->W8_REGTRI
      //Work2->WKTAXASIS := SW8->W8_TAXASIS
      Work2->WKNVE := SW8->W8_NVE
      Work2->WKREG_PC := SW8->W8_REG_PC
      Work2->WKFUN_PC := SW8->W8_FUN_PC
      Work2->WKFRB_PC := SW8->W8_FRB_PC
      Work2->WKREGTRIPI := SW8->W8_REGIPI
      
      IF (lMV_NF_MAE .And. nTipoNF == NFE_FILHA)
         Work2->WKII_A   := Work1->WKIITX 
         Work2->WKIPI_A  := Work1->WKIPITX
         Work2->WKICMS_A := Work1->WKICMS_A
      ENDIF
      //**
         
      EXIT
   ELSEIF EMPTY(Work1->WKADICAO) // SVG - 07/07/09 -
      // Bete - quando temos mais de uma adição com chaves idênticas, significa que houve um estouro de itens dentro da adição. Neste caso é 
      // necessário um loop dentro da Work2 para localizar a adição disponível.
      If nTipoNF # NFE_COMPLEMEN  //CCH - 24/11/08 - Só efetua tratamento de estouro se não for Nota Complementar
        
         lAchouAdi := .F.
         DO WHILE !Work2->(EOF()) .AND. EVAL(bWhileWk)  
            // Bete - Se a adição já vier preenchida na Work1 vinda do SW8, posicioná-la na Work2                
            IF !EMPTY(Work1->WKADICAO) .AND. Work1->WKADICAO <> WORK2->WKADICAO
               Work2->(dbSkip())
               LOOP
            ENDIF

            //AAF - 23/06/2009 - Aceita o numero da adicao vindo do SW8. (Quando preenchido Work1->WKADICAO)               
            N:=ASCAN(aContrAdicao,{|A| A[1]==VAL(Work2->WKADICAO)})
            IF !Empty(Work1->WKADICAO) .OR.  N > 0 .AND. aContrAdicao[N,2] < nItensAdi
               lAchouAdi := .T.
               EXIT
            ENDIF
            Work2->(dbSkip())
         ENDDO   
         IF lAchouAdi 
            aContrAdicao[N,2]++
            EXIT
         ELSE
            lNovaAdi := .T.
            LOOP
         ENDIF  
      ELSE
         EXIT
      ENDIF   
   ELSE
      Exit
   ENDIF
ENDDO
Work1->WKADICAO := Work2->WKADICAO  // Bete - controle por adição

If lIntDraw
   IF ED4->(DBSEEK(xFilial()+SW8->W8_AC+SW8->W8_SEQSIS))
      // AAF 23/11/2006 - As aliquotas não devem ser zeradas. Somente o valor dos impostos.
      //Work2->WKII_A :=0
      //Work2->WKIPI_A:=0
      IF ED0->(DBSEEK(xFilial()+ED4->ED4_PD))
         IF cQbrACModal = "1"
            Work1->WKACMODAL:=SW8->W8_AC
         ELSEIF cQbrACModal = "2"
            Work1->WKACMODAL:=ED0->ED0_MODAL
         ENDIF
         IF ED0->ED0_TIPOAC # "02" .AND. ED0->ED0_MODAL = "1"//Intermediario e suspensao
            //Work2->WKICMS_A:= 0
         ENDIF
      ENDIF
      Work2->WKACMODAL:=Work1->WKACMODAL
   ENDIF
EndIf
   
Work1->WKICMS_RED:= Work2->WKICMS_RED
Work1->WKICMSPC  := Work2->WKICMSPC  
IF lMidia
   IF lSomaDifMidia .AND. lNaoTemComp // AWR - MIDIA - 7/5/4
      nTaxa:=BuscaTaxa(cMoeDolar,SW6->W6_DT_DESE,.T.,.F.,.T.)
      IF(nTaxa=0,nTaxa:=1,)
      Work2->WKRDIFMID += Work1->WKRDIFMID
      Work2->WKUDIFMID += Work1->WKUDIFMID
   ENDIF
ENDIF
IF lDifCamb .AND. lNaoTemComp   // Bete 24/11 - Trevo
   Work2->WKRDIFMID += DITrans( nDifCamb * Work1->WKRATEIO ,2)// AWR - MIDIA - 7/5/4
ENDIF
IF (lImpostos .OR. (lMV_NF_MAE .And. nTipoNF == NFE_FILHA)) .AND. lMV_PIS_EIC
   Work2->WKPERPIS := Work1->WKPERPIS
   Work2->WKREDPIS := Work1->WKREDPIS
   Work2->WKPERCOF := Work1->WKPERCOF
   Work2->WKREDCOF := Work1->WKREDCOF
   Work2->WKVLUPIS := Work1->WKVLUPIS
   Work2->WKVLUCOF := Work1->WKVLUCOF
EndIf
Work2->WKPESOL   += Work1->WKPESOL
Work2->WKFOB     += Work1->WKFOB
Work2->WKFOB_R   += Work1->WKFOB_R
Work2->WKFOB_ORI += Work1->WKFOB_ORI
Work2->WKFOBR_ORI+= Work1->WKFOBR_ORI
Work2->WKQTDE    += Work1->WKQTDE
Work2->WKSEGURO  += Work1->WKSEGURO
IF !lMidia
   Work2->WKPESOSMID+=Work1->WKPESOL
ENDIF
IF (Work2->WKPESOL+Work1->WKPESOL) > nValToTPeso//AWR - 20/06/2006
   MSGSTOP(STR0411+; //STR0411 "A somatoria dos pesos dos itens esta acima do suportado pelo sistema, verifique se os pesos "
           STR0412) //STR0412 "unitarios estao corretos no desembaraco. Em caso de duvidas entre em contato com o Suporte."
   RETURN .F.
ENDIF

IF (lMV_NF_MAE .And. nTipoNF == NFE_FILHA)
   Work2->WKFRETE   += Work1->WKFRETE
   Work2->WKVLACRES += Work1->WKVLACRES
   Work2->WKVLDEDUC += Work1->WKVLDEDUC
   Work2->WKCIF     += Work1->WKCIF
   Work2->WKII      += Work1->WKIIVAL 
   Work2->WKIPI     += Work1->WKIPIVAL
   Work2->WKBASPIS  += Work1->WKBASPIS
   Work2->WKVLRPIS  += Work1->WKVLRPIS
   Work2->WKBASCOF  += Work1->WKBASCOF
   Work2->WKVLRCOF  += Work1->WKVLRCOF
   Work2->WKICMS    += Work1->WKVL_ICM   
   
   If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
      Work2->WKVLCOFM += Work1->WKVLCOFM
   EndIf   
   If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
      Work2->WKVLPISM += Work1->WKVLPISM
   EndIf
   
   nFOB_R    += Work1->WKFOB_R
   nFreteNew += Work1->WKFRETE
   nSEGURO   += Work1->WKSEGURO
   nCIFNew   += Work1->WKCIF
   nNBM_II   += Work1->WKIIVAL
   nNBM_IPI  += Work1->WKIPIVAL
   nNBM_ICMS += Work1->WKVL_ICM
   nNBM_PIS  += Work1->WKVLRPIS
   nNBM_COF  += Work1->WKVLRCOF
   MDI_OUTR  += Work1->WKOUT_DESP
   
   IF SWN->(FIELDPOS("WN_DESPICM")) # 0          //NCF - 17/08/2011
      MDI_DespICM += Work1->WKDESPICM
   ENDIF

   
ENDIF

Return .F.
/*------------------------------------------------------------------------------------
Funcao      : DI154FILHA
Parametros  : 
Retorno     : 
Objetivos   : Nota Fiscal de Remessa
Autor       : Saimon Vinicius Gava
Data/Hora   : 04/11/2009
Revisao     :
Obs.        : MV_NFFILHA - indica quais valores deverão ser apresentados na nota filha, sendo:
              0 - valor da mercadoria (FOB, FRETE, SEGURO, CIF e II)- default
              1 - TUDO
*------------------------------------------------------------------------------------*/
Function DI154FILHA()  

Local oGetDB
Local cTitulo:=STR0315 //"Nota Fiscal de Remessa"
Local cSay := STR0413 //STR0413 "Percentual %"
Local nOpc:=0,lOk:=lRet:=lTemItens:=.F.
Local aButtons :={}     
Local cMV_NFFILHA := GetMV("MV_NFFILHA",,"0")
Private nPercentual := 100
Private lRefresh := .T.
Private aHeader := {}
Private aCols := {}
Private oDlgFilha
Private aRotina := {{STR0414, "Alteração", 0, 4}} // Necessário para a GETDB //STR0414 "Alteração"

Aadd(aButtons,{"S4WB011N",{||DI154Busca(),oGetDB:oBrowse:Refresh()},"Pesquisar"})   // GFC  -  "Conf D.I."


AADD(aHeader,{ AVSX3("WN_INVOICE" ,AV_TITULO),"WKINVOICE" ,AVSX3("WN_INVOICE" ,AV_PICTURE),AVSX3("WN_INVOICE" ,AV_TAMANHO),,,"",AVSX3("WN_INVOICE" ,AV_TIPO) ,"",""})
AADD(aHeader,{ AVSX3("WN_PO_EIC",AV_TITULO),"WKPO_NUM" ,AVSX3("WN_PO_EIC" ,AV_PICTURE),AVSX3("WN_PO_EIC" ,AV_TAMANHO),,,"",AVSX3("WN_INVOICE" ,AV_TIPO),"","" })
AADD(aHeader,{ AVSX3("WN_PRODUTO",AV_TITULO),"WKCOD_I" ,AVSX3("WN_PRODUTO" ,AV_PICTURE),AVSX3("WN_PRODUTO" ,AV_TAMANHO),,,"",AVSX3("WN_PRODUTO" ,AV_TIPO),"",""})
AADD(aHeader,{ STR0319 ,"WKDESCR" ,AVSX3("B1_DESC" ,AV_PICTURE),AVSX3("B1_DESC" ,AV_TAMANHO),,,"",AVSX3("B1_DESC" ,AV_TIPO),"",""})
AADD(aHeader,{ AVSX3("WN_QUANT",AV_TITULO),"WKQTDE" ,AVSX3("WN_QUANT",AV_PICTURE),AVSX3("WN_QUANT" ,AV_TAMANHO),AVSX3("WN_QUANT",AV_DECIMAL),,"",AVSX3("WN_QUANT" ,AV_TIPO),"","" })
AADD(aHeader,{ STR0316,"WKQTDEUTIL" ,AVSX3("WN_QUANT",AV_PICTURE),AVSX3("WN_QUANT" ,AV_TAMANHO),AVSX3("WN_QUANT",AV_DECIMAL),,"",AVSX3("WN_QUANT" ,AV_TIPO),"","" }) //Qtde. Utilizada
AADD(aHeader,{ STR0317,"WKSLDDISP" ,AVSX3("WN_QUANT",AV_PICTURE),AVSX3("WN_QUANT" ,AV_TAMANHO),AVSX3("WN_QUANT",AV_DECIMAL),,"",AVSX3("WN_QUANT" ,AV_TIPO),"","" }) //"Qtde. Disponivel"
AADD(aHeader,{ STR0318,"WKQTDEFILH" ,AVSX3("WN_QUANT",AV_PICTURE),AVSX3("WN_QUANT" ,AV_TAMANHO),AVSX3("WN_QUANT",AV_DECIMAL),,"",AVSX3("WN_QUANT" ,AV_TIPO),"","" })

//FDR - 05/04/12 - Inclusão do campo número do lote
If lLote
   AADD(aHeader,{ STR0064 ,"WK_LOTE" ,AVSX3("WN_LOTECTL",AV_PICTURE),AVSX3("WN_LOTECTL" ,AV_TAMANHO),AVSX3("WN_LOTECTL",AV_DECIMAL),,"",AVSX3("WN_LOTECTL" ,AV_TIPO),"","" })
Endif

DEFINE MSDIALOG oDlgFilha TITLE cTitulo FROM 5,5 TO 38,110 Of oMainWnd 

   @ 20,10 SAY cSay      SIZE 58,7  PIXEL
   @ 30,10 MSGET oGet1 VAR nPercentual PICTURE "999.99"     SIZE 58,8 PIXEL
   @ 30,60 BUTTON "&" + STR0415  SIZE 38,12 ACTION (DI154CalcPerc(nPercentual),oGetDB:oBrowse:Refresh())  Pixel //STR0415 "Calcula"
   oGetDB := MsGetDB():New(0,0,165,413,1,/*"U_LINHAOK"*/,/* "U_TUDOOK"*/,,;
   .F.,{"WKQTDEFILH"},,.F.,,"Work1","U_VALIDGET",,.F.,oDlgFilha, .T., ,/*"U_DELOK"*/,/*"U_SUPERDEL"*/)

   oGetDB:oBrowse:Align := CONTROL_ALIGN_BOTTOM
   oGetDB:oBrowse:bADD := {|| .F.}                                            
   oGetDB:ForceRefresh()  // GFP - 12/03/2013 - Força atualização e posiciona no primeiro registro   

   oDlgFilha:lCentered := .T.


ACTIVATE MSDIALOG oDlgFilha ON INIT (EnchoiceBar(oDlgFilha,{||if(Validaitens(),(lOk:=.T.,oDlgFilha:End()),)},{||oDlgFilha:End(),lOk:=.F.},,aButtons))


If lOk
   WORK1->(DBGoTop())   
   Do While WORK1->(!EOF())
      If WORK1->WKQTDEFILH  <= 0
         WORK1->(DBDelete())
      Else
         nRecSWN := SWN->(RECNO())
         SWN->(dbGoto(WORK1->WKRECMAE))
         nPercFilha := Work1->WKQTDEFILH / Work1->WKQTDE
         Work1->WKPRUNI   := SWN->WN_PRUNI         
         Work1->WKQTDE    := Work1->WKQTDEFILH
         Work1->WKVALMERC := DITrans(Work1->WKQTDEFILH*SWN->WN_PRUNI,2)
         Work1->WKPESOL   := Work1->WKPESOL * Work1->WKQTDE
         nPesoL           := lPesoNew * Work1->WKQTDE // SVG - 11/05/2011 - Ajuste do peso.
         If lPesoBruto 
            Work1->WKPESOBR  := Work1->WKQTDE * Work1->WKPESOBR //RRV - 03/01/2012 - Ajuste no peso bruto da nota filha.
         Endif
         Work1->WKFOB     := Work1->WKFOB * nPercFilha
         Work1->WKFOB_R   := DITRANS(Work1->WKFOB_R * nPercFilha,2)
         Work1->WKFOB_ORI := Work1->WKFOB
         Work1->WKFOBR_ORI:= Work1->WKFOB_R
         Work1->WKCIF     := Work1->WKFOB_R
         IF cMV_NFFILHA <> "2"
            Work1->WKFRETE  := DITrans(SWN->WN_FRETE * nPercFilha,2)
            Work1->WKSEGURO := DITrans(SWN->WN_SEGURO * nPercFilha,2)
         Endif
         IF lAcresDeduc  
            Work1->WKVLACRES := DITrans(SWN->WN_VLACRES * nPercFilha,2)
            Work1->WKVLDEDUC := DITrans(SWN->WN_VLDEDUC * nPercFilha,2)
         ENDIF
         Work1->WKDESPCIF := DITRANS(SWN->(WN_CIF-WN_FOB_R-WN_FRETE-WN_SEGURO-WN_VLACRES+WN_VLDEDUC) * nPercFilha,2)
         Work1->WKCIF     := DITRANS(SWN->WN_CIF * nPercFilha,2)
     
         If cMV_NFFILHA == "2"
            Work1->WKCIF:= Work1->WKCIF - (DITrans(SWN->WN_FRETE * nPercFilha,2) + DITrans(SWN->WN_SEGURO * nPercFilha,2) )
         Endif 
         
         IF cMV_NFFILHA == "0" .OR. cMV_NFFILHA == "1"   
            Work1->WKIITX  := SWN->WN_IITX
            Work1->WKIIVAL := DITRANS(SWN->WN_IIVAL * nPercFilha,2)  
         ENDIF   
            
         IF cMV_NFFILHA == "1"   
            Work1->WKIPIBASE := DITRANS(SWN->WN_IPIBASE * nPercFilha,2)               
            Work1->WKIPITX   := SWN->WN_IPITX
            Work1->WKIPIVAL  := DITRANS(SWN->WN_IPIVAL * nPercFilha,2)
   
            IF lMV_PIS_EIC 
               Work1->WKVLUPIS := SWN->WN_VLUPIS
               Work1->WKBASPIS := DITRANS(SWN->WN_BASPIS * nPercFilha,2)
               Work1->WKPERPIS := SWN->WN_PERPIS
               Work1->WKVLRPIS := DITRANS(SWN->WN_VLRPIS * nPercFilha,2)
               Work1->WKVLUCOF := SWN->WN_VLUCOF
               Work1->WKBASCOF := DITRANS(SWN->WN_BASCOF * nPercFilha,2)
               Work1->WKPERCOF := SWN->WN_PERCOF
               Work1->WKVLRCOF := DITRANS(SWN->WN_VLRCOF * nPercFilha,2) 
               
               If lCposCofMj                                //NCF - 20/07/2012 - Majoração COFINS
                  Work1->WKVLCOFM := DITRANS(SWN->WN_VLCOFM * nPercFilha,2)
               EndIf
               If lCposPisMj                                //GFP - 11/06/2013 - Majoração PIS
                  Work1->WKVLPISM := DITRANS(SWN->WN_VLPISM * nPercFilha,2)
               EndIf
            ENDIF
                  
            IF SWN->(FIELDPOS("WN_DESPICM")) # 0
               Work1->WKDESPICM := DITRANS(SWN->WN_DESPICM * nPercFilha,2)
            ENDIF
			Work1->WKBASEICMS := DITRANS(SWN->WN_BASEICM * nPercFilha,2)
            Work1->WKICMS_A   := SWN->WN_ICMS_A
            Work1->WKVL_ICM   := DITRANS(SWN->WN_VL_ICM * nPercFilha,2)
                  
            If lICMS_Dif  
               Work1->WKVL_ICM_D := DITRANS(SWN->WN_VICMDIF * nPercFilha,2) 
               Work1->WKVLCREPRE := DITRANS(SWN->WN_VICM_CP * nPercFilha,2)
            EndIf

            If lICMS_Dif2  
               WORK1->WK_PAG_DES := SWN->WN_PICM_PD 
               WORK1->WK_PERCDIF := SWN->WN_PICMDIF  
               WORK1->WK_PCREPRE := SWN->WN_PICM_CP 
               WORK1->WK_CRE_PRE := SWN->WN_PLIM_CP 
            EndIf
                  
            Work1->WKOUT_DESP := DITRANS(SWN->WN_DESPESA * nPercFilha,2)
         ENDIF
         SWN->(dbGoto(nRecSWN))
      EndIf
      WORK1->(DBSkip())
   EndDo
   lRet:=.T.
EndIf
WORK1->(DBGOTOP())
Return lRet


*-----------------------
User Function VALIDGET()
*-----------------------
Local lRet := .T.

//DFS - Tratamento para não permitir valores maiores que os disponíveis - Chamado: 081104
If M->WKQTDEFILH > (WORK1->WKSLDDISP)
   lRet := .F.
   MsgInfo("Valor superior a quantidade disponível!")
   //WFS - 19/01/12 - alterado de M->WKQTDEFILH <= 0 para
Elseif M->WKQTDEFILH < 0
   lRet := .F. 
   MsgInfo(STR0310) //STR0310 -> Valor Inválido.
Endif
            
Return lRet
/*------------------------------------------------------------------------------------
Funcao      : DI554CalcPerc
Parametros  : 
Retorno     : 
Objetivos   : Calcular percentual de nota filha
Autor       : Saimon Vinicius Gava
Data/Hora   : 04/11/2009
Revisao     :
Obs.        : 
*------------------------------------------------------------------------------------*/                        
Function DI154CalcPerc(nPercentual)

Work1->(DBGoTop())
While Work1->(!EOF())
   //DFS - Tratamento para não permitir valores negativos no Percentual da Nota Filha. Chamado: 081104
   If nPercentual >= 0
      If Work1->WKSLDDISP >= ((Work1->WKSLDDISP * nPercentual)/100)
         Work1->WKQTDEFILH := ((Work1->WKSLDDISP * nPercentual)/100)
      EndIf
   Else
     MsgInfo (STR0312)  // STR0312 -> "Não é permitido digitar valores negativos!"
   Endif
   Work1->(DBSkip())
EndDo
Work1->(DBGoTop())
Return

/*------------------------------------------------------------------------------------
Funcao      : DI554Busca
Parametros  : 
Retorno     : 
Objetivos   : Busca de itens da nota filha
Autor       : Saimon Vinicius Gava
Data/Hora   : 04/11/2009
Revisao     :
Obs.        : 
*------------------------------------------------------------------------------------*/
Function DI154Busca()
Local oDlg
Local cTitulo:=STR0313 //"Busca de Itens da Nota Filha"
Local cPesq:=Space(15)
Local aOpcao := {"1- Item","2- PO","3- Invoice"}
Local cCombo := aOpcao[1]

DEFINE MSDIALOG oDlg TITLE cTitulo FROM 30,50 TO 39,88 Of oDlgFilha

   @ 020,020 SAY STR0416   SIZE 100,8 OF oDlg PIXEL  //STR0416 "Opção"
   @ 30,10   COMBOBOX cCombo     ITEMS aOpcao SIZE 35,90 OF oDlg PIXEL
   @ 30,65 MSGET oGet1 VAR cPesq  PICTURE Avsx3("WN_INVOICE",AV_PICTURE) SIZE 58,8 PIXEL

ACTIVATE MSDIALOG oDlg ON INIT (EnchoiceBar(oDlg,{||lOk:=.T.,oDlg:End()},{||oDlg:End()},,))

DO CASE
   CASE cCombo == "1- Item"
      Work1->(dbSetOrder(8))
      If !Empty(cPesq)
         Work1->(dbSeek(cPesq)) 
      EndIf
   CASE cCombo == "2- PO"
      Work1->(dbSetOrder(9))
      If !Empty(cPesq)
         Work1->(dbSeek(cPesq))
      EndIf
   CASE cCombo == "3- Invoice"
      Work1->(dbSetOrder(10))   
      If !Empty(cPesq)
         Work1->(dbSeek(cPesq))
      EndIf
ENDCASE   

Return

Static Function Validaitens()
Local lTemItens := .F.

WORK1->(DBGoTop()) 
Do While WORK1->(!EOF()) .And. !lTemItens
   If WORK1->WKQTDEFILH  > 0
      lTemItens := .T.
   EndIf
   Work1->(dbSkip())
EndDo

WORK1->(DBGoTop())
If !lTemItens
   Alert(STR0314) // Não existem itens selecionados para a Nota Filha.
EndIf

return lTemItens  

/*
Funcao      : DI154DspSis
Parametros  : Nenhum
Retorno     : nValor -> Valor da Taxa Siscomex por Processo
Objetivos   : Verificar se a despesa de Taxa Siscomex foi inserida antes ou após
              Atualização dos valores da taxa siscomex na tabela SX5 conforme
              Portaria No. 257 do Ministerio da Fazenda publicada em 23/05/2011              
Autor       : Nilson Cesar
Data/Hora   : 25/05/2011 - 10:00 hs
Revisao     : 
Obs.        : 
*/
*-------------------------------*
Function DI154DspSis()
*-------------------------------*
Local aOrdSWD := SaveOrd("SWD")
Local nValor  := 185

SWD->(DbSetOrder(1))
If SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+GetMV("MV_CODTXSI",,"415"))) 
   If SWD->WD_DES_ADI >= cTOD("01/06/11")
      nValor := 185
   Else 
      nValor := 30
   EndIf
EndIf
RestOrd(aOrdSWD)

Return nValor    

/*
Funcao      : 
Parametros  : 
Retorno     : 
Objetivos   :             
Autor       : Nilson Cesar
Data/Hora   : 06/10/2011 - 10:00 hs
Revisao     : 
Obs.        : 
*/
*-------------------------------*
Function MaiorItNFC()
*-------------------------------*
Local aOrdWork1 := SaveOrd({"Work1"})
Local nRecMaior := nVlrMaior := 0

Work1->(DbGotop())

Do While Work1->(!Eof())

   IF Work1->WKOUT_DESP > nVlrMaior
      nRecMaior := Work1->(Recno())
      nVlrMaior := Work1->WKOUT_DESP
   EndIf

   Work1->(DbSkip())

EndDo

RestOrd( aOrdWork1,.T.)

Return nRecMaior   

/*
Funcao      : DI154GrvOri()
Objetivos   : Preencher corretamente os campos referentes a nota fiscal depois de ter verificado os lotes.            
Autor       : Diogo Felipe dos Santos
Data/Hora   : 19/10/2011 - 15:00 hs
Revisao     : Thiago Rinaldi
*/
*-------------------------------*
Static Function DI154GrvOri()
*-------------------------------*
Local aOrdWork1 := SaveOrd({"Work1"})

SWN->(DbSetOrder(3))
Work1->(DbGoTop())   

Do While Work1->(!Eof())
   If SWN->(dbSeek(xFilial("SWN")+SW6->W6_HAWB))
      Do While SWN->(!Eof()) .AND. xFilial("SWN") == SWN->WN_FILIAL .AND. SWN->WN_HAWB == SW6->W6_HAWB .AND. SWN->WN_TIPO_NF $ "1/3/5" 
         If Alltrim(SWN->WN_PRODUTO) == Alltrim(Work1->WKCOD_I) .AND. Alltrim(SWN->WN_ITEM) == Alltrim(Work1->WKPOSICAO) .AND. Alltrim(SWN->WN_FORNECE) == Alltrim(Work1->WKFORN) .AND.;
            Alltrim(SWN->WN_INVOICE) == Alltrim(Work1->WKINVOICE) .AND. Alltrim(SWN->WN_PGI_NUM) == Alltrim(Work1->WKPGI_NUM) .AND.; //RRV 30/11/2012 - Ajuste para buscar a nota de origem considerando a invoice e o numero da LI.
            If (lLote, Alltrim(SWN->WN_LOTECTL) == Alltrim(Work1->WK_LOTE),.T.)
            Work1->WKNOTAOR  := SWN->WN_DOC   //DFS - 14/02/11 - Adição de campos na verificação
            Work1->WKSERIEOR := SWN->WN_SERIE //DFS - 14/02/11 - Adição de campos na verificação
            Exit 
         EndIf
         SWN->(DbSkip())
      EndDo   
   EndIf
   Work1->(DbSkip())
EndDo
RestOrd(aOrdWork1,.T.)

Return Nil   

/*
Funcao      : Acrescimo()
Objetivos   : Cacular despesa base de imposto como acrescimo, rateando por adição.
Autor       : TAMIRES DAGLIO FERREIRA
Data/Hora   : 13/01/2012 - 15:00 hs
Revisao     : 
*/
*-------------------------------*
Static Function Acrescimo()
*-------------------------------*
Local nFobTot  := 0
Local aOrdWD   := {}
Local aOrdYB   := {}
Local nFrete   := 0
Local nSeguro  := 0
  

      aOrdWD := SaveOrd("SWD")
      aOrdYB := SaveOrd("SYB")  
      
      SWD->(DbSetOrder(1))
      SYB->(DbSetOrder(1))  
      
      If SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB)) 
         While SWD->(!Eof()) .And. (xFilial("SWD") == SWD->WD_FILIAL) .And. (SWD->WD_HAWB == SW6->W6_HAWB)
            If SYB->(DbSeek(xFilial("SYB") + SWD->WD_DESPESA))             
               If SWD->WD_DESPESA == "102"         
                  nFrete:= SWD->WD_VALOR_R
               EndIf
               
               If SWD->WD_DESPESA == "103"
                  nSeguro:= SWD->WD_VALOR_R
               EndIf 
               
               If SYB->YB_BASEIMP $ cSim  
                  IF lAcresDeduc
                     IF EIU->(DBSEEK(xFilial("EIU")+SW6->W6_HAWB+STR(nTipoNF,1,0)+Work2->WKADICAO)) 
                        IF EIU->EIU_CODIGO == "01"
                           EXIT
                        ENDIF
                     ELSE   
                        
                        Work_EIU->(dbAppend())
                        Work_EIU->EIU_HAWB    := SW6->W6_HAWB 
                        Work_EIU->EIU_TIPONF  := STR(nTipoNF,1)
                        Work_EIU->EIU_ADICAO  := Work2->WKADICAO 
                        Work_EIU->EIU_TIPO    := "A"                  
                        Work_EIU->EIU_CODIGO  := "01"
                        Work_EIU->EIU_DESC    := "COMISSOES E CORRETAGENS"                          
                        IF SYB->YB_RATPESO $ cSim
                           nRateioGrupo := Work2->WKPESOL/MDI_PESO
                           nRateioItem  := Work1->WKPESOL/Work2->WKPESOL 
                           Work_EIU->EIU_VALOR   := nRateioGrupo * SWD->WD_VALOR_R 
                           Work2->WKVLACRES := Work_EIU->EIU_VALOR 
                           Work1->WKVLACRES := nRateioItem * SWD->WD_VALOR_R                
                        ELSE 
                           
                           If AvRetInco(SW9->W9_INCOTER,"CONTEM_FRETE")//"CFR,CPT,CIF,CIP,DAF,DES,DEQ,DDU,DDP"
                              nFobTot:= MDI_FOB_R
                              nFrete := 0
                           Else
                              nFobTot:=MDI_FOB_R + nFrete
                              nRateioFrete:= Work2->WKPESOL/MDI_PESO 
                              nFrete:=DITrans(MDI_FRETE*nRateioFrete,2)
                           EndIf 
                           
                           Work_EIU->EIU_VALOR     := DITRANS(nSomaNoCIF   *((Work2->WKFOB_R + nFrete)/nFobTot),2)
                           Work2->WKVLACRES := Work_EIU->EIU_VALOR 
                           Work1->WKVLACRES := Work_EIU->EIU_VALOR   
                        ENDIF
                     ENDIF
                  EndIf
               EndIf   
            Endif
            SWD->(DbSkip())
         EndDo
      EndIf                                 
        
      RestOrd(aOrdWD, .T.)
      RestOrd(aOrdYB, .T.)       
      
Return .T.

/*
Funcao      : EICGetPerMaj()
Objetivos   : Retornar o percentual da alíquota de majoração
Autor       : TAMIRES DAGLIO FERREIRA
Data/Hora   : 23/07/2012 - 10:00 hs
Revisao     : Guilherme Fernandes Pilan - GFP
Data/Hora   : 11/06/2013 :: 16:20
Objetivos   : Ajuste para Majoração PIS.
*/
FUNCTION EICGetPerMaj(cNCM, cOper, cImportador, cImposto)

Local nPerc:= 0
LOCAL cFilSYT:=xFILIAL("SYT")
LOCAL cFilSYD:=xFILIAL("SYD")
LOCAL cFilSWZ:=xFILIAL("SWZ")

DO CASE

CASE cImposto $ 'COFINS' .OR. cImposto $ 'PIS'// TIPO DE IMPOSTO  

   IF EMPTY(cOper) // CASO NÃO TENHA CFO, UTILIZA O PERCENTUAL DA NCM
   
      SYT->(DBSetOrder(1))
      SYD->(DBSetOrder(1)) 
   
      SYT->(dBSeek(cFilSYT+AvKey(cImportador,"YT_COD_IMP")))
      //SYD->(dbSeek(cFilSYD+AvKey(cNCM,"YD_TEC"))) - TDF - 23/11/2012 - Não pode usar AVKEY, pois a chave cNCM tem o conteudo de 3 campos..
      SYD->(dbSeek(cFilSYD+cNCM))
   
      IF cImposto $ 'COFINS'
         IF SYT->YT_MJCOF $ cSim
            nPerc:= SYD->YD_MAJ_COF
         ELSE
            nPerc:= 0
         ENDIF
      ELSEIF cImposto $ 'PIS'
         IF SYT->YT_MJPIS $ cSim
            nPerc:= SYD->YD_MAJ_PIS
         ELSE
            nPerc:= 0
         ENDIF
      ENDIF     
      
   ELSE // CASO TENHA CFO
   
      SWZ->(DBSetOrder(2))
      SWZ->(dbSeek(cFilSWZ+AvKey(cOper,"WZ_OPERACA")))
   
      IF (SWZ->(FIELDPOS("WZ_TPCMCOF")) # 0 .AND. SWZ->WZ_TPCMCOF $ '1') .OR. (SWZ->(FIELDPOS("WZ_TPCMPIS")) # 0 .AND. SWZ->WZ_TPCMPIS $ '1')// SE FOR OPÇÃO 1 - PADRÃO, UTILIZA O PERCENTUAL DA NCM
   
         SYT->(DBSetOrder(1))
         SYD->(DBSetOrder(1))
   
         SYT->(dBSeek(cFilSYT+AvKey(cImportador,"YT_COD_IMP")))
         //SYD->(dbSeek(cFilSYD+AvKey(cNCM,"YD_TEC"))) - TDF - 23/11/2012 - Não pode usar AVKEY, pois a chave cNCM tem o conteudo de 3 campos.
         SYD->(dbSeek(cFilSYD+cNCM))
   
         IF cImposto $ 'COFINS'
            IF SYT->YT_MJCOF $ cSim
               nPerc:= SYD->YD_MAJ_COF
            ELSE
               nPerc:= 0
            ENDIF  
         ELSEIF cImposto $ 'PIS'
            IF SYT->YT_MJPIS $ cSim
               nPerc:= SYD->YD_MAJ_PIS
            ELSE
               nPerc:= 0
            ENDIF           
         ENDIF
   
      ELSEIF SWZ->WZ_TPCMCOF $ '2' .OR. SWZ->WZ_TPCMPIS $ '2'// SE FOR OPÇÃO 2 - CALCULADO, UTILIZA O PERCENTUAL DO CFO
  
         IF cImposto $ 'COFINS'
            nPerc:= SWZ->WZ_ALCOFM
         ELSEIF cImposto $ 'PIS'
            nPerc:= SWZ->WZ_ALPISM
         ENDIF

      ELSEIF SWZ->WZ_TPCMCOF $ '3' .OR. SWZ->WZ_TPCMPIS $ '3'// SE FOR OPÇÃO 3 - NÃO CALCULADO, RETORNA PERCENTUAL 0

         nPerc:= 0 
   
      ENDIF 
   
   ENDIF                  

ENDCASE

RETURN nPerc  // RETORNA O PERCENTUAL MAJORADO 

/*
Funcao      : EICGetMaj()
Objetivos   : Retornar o percentual majorado do imposto e valor correspondente à majoração na Nota Fiscal de Importação
Autor       : TAMIRES DAGLIO FERREIRA
Data/Hora   : 23/07/2012 - 15:00 hs
Revisao     : 
*/
Function EicGetMaj(cIMPOSTO, cHAWB, cTipo, cInvoice, cPO, cItem, cPGI, cLote)
Local lItemOk := .F.
Local aRet := {Nil, Nil}
Local aOrd
Default cImposto := ""

	//Caso não receba todos os parâmetros, assume que está posicionado no item desejado
	If 	ValType(cHAWB)		<> "C" .Or.;
		ValType(cTipo)		<> "C" .Or.;
		ValType(cInvoice)	<> "C" .Or.;
		ValType(cPO)		<> "C" .Or.;
		ValType(cItem)		<> "C" .Or.;
		ValType(cPGI)		<> "C" .Or.;
		ValType(cProd) 		<> "C" .Or.;
		ValType(cLote) 		<> "C"
		If SWN->(!Eof())
			lItemOk := .T.
		EndIf
	Else
		//Verifica se não está posicionado no item informado nos parâmetros
		If SWN->(!Eof() .And. WN_FILIAL+WN_HAWB+WN_TIPO_NF+WN_INVOICE+WN_PO_EIC+WN_ITEM+WN_PGI_NUM+WN_LOTECTL == ;
				xFilial()+AvKey(cHAWB, "WN_HAWB")+AvKey(cTipo, "WN_TIPO_NF")+AvKey(cInvoice, "WN_INVOICE")+AvKey(cPO, "WN_PO_EIC")+AvKey(cItem, "WN_ITEM")+AvKey(cPGI, "WN_PGI_NUM")+AvKey(cLote, "WN_LOTECTL"))
			lItemOk := .T.
		Else
			//Busca o item informado na tabela SWN
			aOrd := SaveOrd("SWN")
			SWN->(DbSetOrder(3))
			SWN->(DbSeek(xFilial()+AvKey(cHAWB, "WN_HAWB")+AvKey(cTipo, "WN_TIPO_NF")))
			While SWN->(!Eof() .And. WN_FILIAL+WN_HAWB+WN_TIPO_NF == xFilial()+AvKey(cHAWB, "WN_HAWB")+AvKey(cTipo, "WN_TIPO_NF"))
				If SWN->(WN_INVOICE+WN_PO_EIC+WN_ITEM+WN_PGI_NUM+WN_LOTECTL == AvKey(cInvoice, "WN_INVOICE")+AvKey(cPO, "WN_PO_EIC")+AvKey(cItem, "WN_ITEM")+AvKey(cPGI, "WN_PGI_NUM")+AvKey(cLote, "WN_LOTECTL"))
					lItemOk := .T.
				EndIf
				SWN->(DbSkip())
			EndDo
		EndIf
	EndIf
	
	If lItemOk
		Do Case
			Case cImposto == "COFINS"
				aRet := {WN_ALCOFM, WN_VLCOFM}
			Case cImposto == "PIS"
				aRet := {WN_ALPISM, WN_VLPISM}     // GFP - 11/06/2013 - Majoração PIS
			Otherwise
				aRet := {0, 0}
		
		EndCase
	EndIf

	If ValType(aOrd) == "A"
		RestOrd(aOrd, .T.)
	EndIf

Return aRet

/*
Funcao      : DI154ValPesq()
Parâmetros  : cForn : Código Fornecedor
              cTec  : NCM do produto
              cItem : Código do item
Retorno     : lRet  : .T./.F.
Objetivos   : Validar informações de pesquisa
Autor       : Guilherme Fernandes Pilan - GFP
Data/Hora   : 09/10/2012 : 17:12
*/
*-------------------------------------------------*
Static Function DI154ValPesq(cForn,cTec,cItem)
*-------------------------------------------------*
Local lRet := .T.

Do Case
   Case Empty(cForn)
      MsgInfo("Preencha o Fornecedor")
      lRet := .F.
   Case Empty(cTec)
      MsgInfo("Preencha a NCM")
      lRet := .F.  
   Case Empty(cItem)
      MsgInfo("Preencha o item")
      lRet := .F.  
End Case

Return lRet

/*
Funcao      : AvInt_SWDVal()
Parâmetros  : -
Retorno     : Valor total de um Imposto informado no Desembaraço.
Objetivos   : Somar o valor das despesas de impostos informadas no Desembaraço.
Observação  : Quando AvInteg é possível ter mais de uma linha de um Imposto nas despesas do Desembaraço.
Autor       : Thiago Rinaldi Pinto - TRP
Data/Hora   : 22/10/2012 : 13:00
*/
*------------------------------*
Static Function AvInt_SWDVal(cDespesa)   
*------------------------------*
LOCAL aOrdSWD:= SaveOrd({"SWD"})

PRIVATE nValorAvInt := 0
   
SWD->(DbSetOrder(1))
If SWD->(DbSeek(xFilial("SWD")+SW6->W6_HAWB+AvKey(cDespesa,"WD_DESPESA")))
   Do While SWD->(!EOF()) .AND.;
                  SWD->WD_FILIAL == xFilial("SWD").AND.;
                  SWD->WD_HAWB == SW6->W6_HAWB .AND.;
                  SWD->WD_DESPESA == AvKey(cDespesa,"WD_DESPESA")

      nValorAvInt+= SWD->WD_VALOR_R 
      SWD->(DbSkip())
   Enddo
Endif

RestOrd(aOrdSWD,.T.)

RETURN nValorAvInt   
*--------------------------------------------------------------------------------------*
*                             FIM DO PROGRAMA EICDI154.PRW                             *
*--------------------------------------------------------------------------------------*
