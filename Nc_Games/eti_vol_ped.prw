#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NFatr02  º Autor ³ Reinaldo Caldas    º Data ³  02/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressao de Etiquetas NC Games.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ETI_VOL ()

Local cDesc1        := "Este programa tem como objetivo imprimir Etiquetas  "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Etiquetas de Despacho"
Local cPict         := ""
Local titulo        := "Etiquetas de Despacho"
Local nLin          := 81
Local Cabec1        := "Etiquetas de despacho"
Local Cabec2        := ""
Local imprime       := .T.
Local aOrd          := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "P"
Private nomeprog    := "ETIVOL" 
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "ETIVOL" 
Private cString     := "SC5"
Private cPerg       := "ETIVOL"

ValidPerg()

Pergunte(cPerg,.F.)
dbSelectArea("SC5")
dbSetOrder(1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.T.)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
   Return
Endif
nTipo := If(aReturn[4]==1,15,18)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  02/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
dbSelectArea(cString)
dbSetOrder(1)
dbSeek(xFilial()+mv_par01)                                                   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())
MSCBPRINTER("S600","LPT1",,80,.F.,,,,)
MSCBCHKSTATUS(.F.) //.T. -- seta o controle de status do sistema com a impressora

While !eof() .and. SC5->C5_NUM == mv_par01 
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	DBSELECTAREA("SZ7")
	DBSETORDER(1)
	
	IF DBSEEK(XFILIAL("SZ7")+SC5->C5_NUM+"000011")
		IF !(MSGYESNO("ETIQUETA DO PEDIDO: "+SC5->C5_NUM+" FOI EMITIDA "+CHR(13)+"DESEJA REEMITI-LA?" ))
			dbSelectArea("SC5")
			SC5->(dbSkip())
			LOOP
		ENDIF
	ENDIF		
	
	xNUM_PED := SC5->C5_NUM				// Numero
	xEMISSAO := SC5->C5_EMISSAO		// Data de Emissao
	xCliente := SC5->C5_CLIENTE		// CODIGO DO CLIENTE
	xLOJA    := SC5->C5_LOJACLI		// Loja do Cliente
	xTRANSP	 := SC5->C5_TRANSP		// TRANSPORTADORA

    dbSelectArea("SA1")
    dbSetOrder(1)
    dbSeek(xFilial()+xCliente+xLoja)
    xEND_CLI := SA1->A1_ENDENT
    xBAIRRO  := SA1->A1_BAIRROE
    xCEP_CLI := SA1->A1_CEPE
    xNReduz  := SA1->A1_NOME
    xMunic   := SA1->A1_MUNE
    xEstado  := SA1->A1_ESTE
    If SC5->C5_XECOMER=="C" 
    	U_COM05EndEnt(SC5->C5_NUM,@xEND_CLI,@xBAIRRO,@xCEP_CLI,@xMunic,@xEstado)
    EndIf
    dbSelectArea("SC6")                   // * Itens de Venda da N.F.
    dbSetOrder(3)
    dbSeek(xFilial()+xNUM_PED)
   	cPedAtu  := SC6->C6_NUM
    cItemAtu := SC6->C6_ITEM
    dbSelectArea("SA4")
    dbSetOrder(1)
    dbSeek(xFilial()+SC5->C5_TRANSP)
    _cTransp := Alltrim(SA4->A4_NOME)
 
    For _j:=1 To mv_par02
 		MSCBBEGIN(1,6,31.5)
		MSCBBOX(06,02,99,25,02)
		MSCBLineH(06,17,99,03,"B")
   		MSCBLineH(06,25,99,03,"B")
		MSCBLineV(50,02,15,03,"B")
		MSCBSAY(07,04,"PEDIDO","N","A","015,008")
		MSCBSAY(52,04,"VOLUME","N","A","015,008")		
	    MSCBSAY(07,09,xNUM_PED+" / "+ALLTRIM(STRZERO(MV_PAR03,2)),"N","0","055,060")
		MSCBSAY(52,08,Alltrim(Strzero(_j,3))+"/"+Alltrim(Strzero(mv_par02,3)),"N","0","055,060")
		MSCBSAY(07,18,"CLIENTE","N","A","015,008")
		MSCBSAY(07,22,Alltrim(xNReduz),"N","0","025,030")
		MSCBEND() //Fim da imagem da etiqueta
		SZ3->(dbSkip())
   	Next _j	   	

	MSCBBEGIN(1,6,31.5)
	MSCBBOX(06,02,99,25,02)
	MSCBLineH(06,15,99,03,"B")
	MSCBLineH(06,25,99,03,"B")
	MSCBLineV(50,02,15,03,"B")
	MSCBSAY(07,04,"PEDIDO","N","A","015,008")
	MSCBSAY(52,04,"VOLUME","N","A","015,008")		
	MSCBSAY(07,09,xNUM_PED+" / "+ALLTRIM(STRZERO(MV_PAR03,2)),"N","0","055,060")
	MSCBSAY(52,08,Alltrim(Strzero(mv_par02,3))+"/"+Alltrim(Strzero(mv_par02,3)),"N","0","055,060")
	MSCBSAY(07,18,"CLIENTE","N","A","015,008")
	MSCBSAY(07,22,Alltrim(xNReduz),"N","0","025,030")
	MSCBEND() //Fim da imagem da etiqueta	
	
	DBSELECTAREA("SZ7")
	DBSETORDER(2)
	
	IF !SZ7->(DBSEEK(XFILIAL("SZ7")+SC5->C5_NUM+"000011"+ALLTRIM(STR(MV_PAR03))))
		RECLOCK("SZ7", .T.)
	ELSE
		RECLOCK("SZ7", .F.)
	ENDIF
	
	SZ7->Z7_FILIAL 	:= xFilial("SZ7")
  	SZ7->Z7_NUM	   	:= SC5->C5_NUM
  	SZ7->Z7_STAT   	:= "000011"
 	SZ7->Z7_STATUS 	:= "ETIQUETA DE PEDIDO EMITIDA"
  	SZ7->Z7_CODCLI 	:= SC5->C5_CLIENTE
   	SZ7->Z7_DATA   	:= DATE()
  	SZ7->Z7_HORA   	:= TIME()
  	SZ7->Z7_USUARIO	:= Upper(cUsername)
  	SZ7->Z7_SEQCAR 	:= ALLTRIM(STR(MV_PAR03))
  	SZ7->(MsUnLock())	 
	
	DBCLOSEAREA("SZ7")
	
	dbSelectArea("SC5")
	SC5->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo

MSCBCLOSEPRINTER()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif
MS_FLUSH()
Return   


Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Pedido De ?","","","mv_ch1","C",6,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SC5"})
AADD(aRegs,{cPerg,"02","Numero de Pacotes?","","","mv_ch2","N",6,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Numero da Parte?","","","mv_ch3","N",6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})

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