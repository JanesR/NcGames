#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCFATSTAR º Autor ³ Rodrigo Okamoto    º Data ³  07/03/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório com informações para STAR COMPUTER               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC GAMES                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NCFATSTAR


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cArq,cInd
Local cString := "SC5"  // Alias utilizado na Filtragem
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "para a logística completar as informações do rastreio"
Local cDesc3         := "via SEDEX.   "
Local cPict          := ""
Local titulo       := "Rastreio via SEDEX por Vendedor/Periodo"
Local nLin         := 80

                    //"Cliente                                              Endereço                                Ped Cli Dt.Ped  Pedido Val Merc Ped.  Outr. Despes   Total Pedido   NFiscal Dt NF   Val Total NF   Expedido Entregue    Cod Sedex"//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1       := "Cliente                                  Endereço                             Ped Cli  Dt.Ped  Pedido Val Merc Ped. Outr. Despes   Total Pedido   NFiscal   Dt NF    Val Total NF   Expedido Entregue Cod Sedex"
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "NCFATSTAR" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       := "FATSTA"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "NCFATSTAR" // Coloque aqui o nome do arquivo usado para impressao em disco


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta grupo de perguntas 									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSx1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        // Dt Pedido de ?              		         ³
//³ mv_par02        // Dt Pedido ate ?				       		 ³
//³ mv_par03        // Do Vendedor ?                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

titulo	+= "  - Vendedor: "+MV_PAR03+" - "+GETADVFVAL("SA3","A3_NOME",XFILIAL("SA3")+MV_PAR03,1,"")

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
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  22/02/11   º±±
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

Local aStru 	 := {}
Local aPedCli    := {}
Local aStruSC5   := {}
Local aStruSC6   := {}
Local aC5Rodape  := {}
Local aRelImp    := MaFisRelImp("MT100",{"SF2","SD2"})
Local aFisGet    := Nil
Local aFisGetSC5 := Nil

Local li         := 100 // Contador de Linhas
Local lImp       := .F. // Indica se algo foi impresso
Local lRodape    := .F.

Local cbCont     := 0   // Numero de Registros Processados
Local cbText     := ""  // Mensagem do Rodape
Local cKey 	     := ""
Local cFilter    := ""
Local cAliasSC5  := "SC5"
Local cAliasSC6  := "SC6"
Local cIndex     := CriaTrab(nil,.f.)
Local cQuery     := ""
Local cQryAd     := ""
Local cName      := ""
Local cPedido    := ""
Local cCliEnt	 := ""
Local cNfOri     := Nil
Local cSeriOri   := Nil

Local nItem      := 0
Local nTotQtd    := 0
Local nTotVal    := 0
Local nDesconto  := 0
Local nPesLiq    := 0
Local nSC5       := 0
Local nSC6       := 0
Local nX         := 0
Local nRecnoSD1  := Nil
Local nG		 := 0
Local nFrete	 := 0
Local nSeguro	 := 0
Local nFretAut	 := 0
Local nDespesa	 := 0
Local nDescCab	 := 0
Local nPDesCab	 := 0
Local nY         := 0
Local nValMerc   := 0
Local nPrcLista  := 0
Local nAcresFin  := 0

Private aItemPed := {}
Private aCabPed	 := {}

aAdd(aStru,{"PEDIDO_NC","C",TamSX3("C6_NUM")[1],TamSX3("C6_NUM")[2]})
aAdd(aStru,{"PED_CLI","C",TamSX3("C6_NUM")[1],TamSX3("C6_NUM")[2]})
aAdd(aStru,{"CODCLI","C",TamSX3("A1_COD")[1],TamSX3("A1_COD")[2]})
aAdd(aStru,{"LOJACLI","C",TamSX3("A1_LOJA")[1],TamSX3("A1_LOJA")[2]})
aAdd(aStru,{"CLIENTE","C",TamSX3("A1_NOME")[1],TamSX3("A1_NOME")[2]})
aAdd(aStru,{"ENDERECO","C",TamSX3("A1_END")[1],TamSX3("A1_END")[2]})
aAdd(aStru,{"MUNICIPIO","C",TamSX3("A1_MUN")[1],TamSX3("A1_MUN")[2]})
aAdd(aStru,{"UF","C",TamSX3("A1_EST")[1],TamSX3("A1_EST")[2]})
aAdd(aStru,{"TIPOPED","C",TamSX3("C5_TIPO")[1],TamSX3("C5_TIPO")[2]})
aAdd(aStru,{"DTEMIPED","C",8,0})
aAdd(aStru,{"TOTALPED","N",14,2})
aAdd(aStru,{"OUTRDESPES","N",14,2})
aAdd(aStru,{"TOTALMERC","N",14,2})
aAdd(aStru,{"NOTAFISCAL","C",TamSX3("F2_DOC")[1],TamSX3("F2_DOC")[2]})
aAdd(aStru,{"DTEMINF","C",8,0})
aAdd(aStru,{"TOTALNF","N",14,2})
aAdd(aStru,{"DTSAIDA","C",8,0})
aAdd(aStru,{"DTENTREGA","C",8,0})
aAdd(aStru,{"NSEDEX","C",TamSX3("F2_NSEDEX")[1],TamSX3("F2_NSEDEX")[2]})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "NCFATSTAR"

If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
EndIf

DBCREATE(CNOMEDBF,aStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

FisGetInit(@aFisGet,@aFisGetSC5)

cAliasSC5:= "C730Imp"
cAliasSC6:= "C730Imp"
lQuery    := .T.
aStruSC5  := SC5->(dbStruct())
aStruSC6  := SC6->(dbStruct())
cQuery := "SELECT SC5.R_E_C_N_O_ SC5REC,SC6.R_E_C_N_O_ SC6REC,"
cQuery += "SC5.C5_FILIAL,SC5.C5_NUM,SC5.C5_CLIENTE,SC5.C5_LOJACLI,SC5.C5_TIPO,"
cQuery += "SC5.C5_TIPOCLI,SC5.C5_TRANSP,SC5.C5_PBRUTO,SC5.C5_PESOL,SC5.C5_DESC1,"
cQuery += "SC5.C5_DESC2,SC5.C5_DESC3,SC5.C5_DESC4,SC5.C5_MENNOTA,SC5.C5_EMISSAO,"
cQuery += "SC5.C5_CONDPAG,SC5.C5_FRETE,SC5.C5_DESPESA,SC5.C5_FRETAUT,SC5.C5_TPFRETE,SC5.C5_SEGURO,SC5.C5_TABELA,"
cQuery += "SC5.C5_VOLUME1,SC5.C5_ESPECI1,SC5.C5_MOEDA,SC5.C5_REAJUST,SC5.C5_BANCO,"
cQuery += "SC5.C5_ACRSFIN,SC5.C5_VEND1,SC5.C5_VEND2,SC5.C5_VEND3,SC5.C5_VEND4,SC5.C5_VEND5,SC5.C5_PEDCLI,"
cQuery += "SC5.C5_COMIS1,SC5.C5_COMIS2,SC5.C5_COMIS3,SC5.C5_COMIS4,SC5.C5_COMIS5,SC5.C5_PDESCAB,SC5.C5_DESCONT,C5_INCISS,"
If SC5->(FieldPos("C5_CLIENT"))>0
	cQuery += "SC5.C5_CLIENT,"
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta rotina foi escrita para adicionar no select os campos         ³
//³usados no filtro do usuario quando houver, a rotina acrecenta      ³
//³somente os campos que forem adicionados ao filtro testando         ³
//³se os mesmo já existem no select ou se forem definidos novamente   ³
//³pelo o usuario no filtro                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(aReturn[7])
	For nX := 1 To SC5->(FCount())
		cName := SC5->(FieldName(nX))
		If AllTrim( cName ) $ aReturn[7]
			If aStruSC5[nX,2] <> "M"
				If !cName $ cQuery .And. !cName $ cQryAd
					cQryAd += cName +","
				Endif
			EndIf
		EndIf
	Next nX
Endif
For nY := 1 To Len(aFisGet)
	cQryAd += aFisGet[nY][2]+","
Next nY
For nY := 1 To Len(aFisGetSC5)
	cQryAd += aFisGetSC5[nY][2]+","
Next nY
cQuery += cQryAd
cQuery += "SC6.C6_FILIAL,SC6.C6_NUM,SC6.C6_PEDCLI,SC6.C6_PRODUTO,"
cQuery += "SC6.C6_TES,SC6.C6_CF,SC6.C6_QTDVEN,SC6.C6_PRUNIT,SC6.C6_VALDESC,"
cQuery += "SC6.C6_VALOR,SC6.C6_ITEM,SC6.C6_DESCRI,SC6.C6_UM, "
cQuery += "SC6.C6_PRCVEN,SC6.C6_NOTA,SC6.C6_SERIE,SC6.C6_CLI,"
cQuery += "SC6.C6_LOJA,SC6.C6_ENTREG,SC6.C6_DESCONT,SC6.C6_LOCAL,"
cQuery += "SC6.C6_QTDEMP,SC6.C6_QTDLIB,SC6.C6_QTDENT,SC6.C6_NFORI,SC6.C6_SERIORI,SC6.C6_ITEMORI "
cQuery += "FROM "
cQuery += RetSqlName("SC5") + " SC5 ,"
cQuery += RetSqlName("SC6") + " SC6 "
cQuery += "WHERE "
cQuery += "SC5.C5_FILIAL = '"+xFilial("SC5")+"' AND "
cQuery += "SC5.C5_EMISSAO >= '"+dtos(mv_par01)+"' AND "
cQuery += "SC5.C5_EMISSAO <= '"+dtos(mv_par02)+"' AND "
cQuery += "SC5.C5_VEND1 = '"+mv_par03+"' AND "
cQuery += "SC5.D_E_L_E_T_ = ' ' AND "
cQuery += "SC6.C6_FILIAL = '"+xFilial("SC6")+"' AND "
cQuery += "SC6.C6_NUM   = SC5.C5_NUM AND "
cQuery += "SC6.D_E_L_E_T_ = ' ' "
cQuery += "ORDER BY SC5.C5_NUM"

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC5,.T.,.T.)

For nSC5 := 1 To Len(aStruSC5)
	If aStruSC5[nSC5][2] <> "C" .and.  FieldPos(aStruSC5[nSC5][1]) > 0
		TcSetField(cAliasSC5,aStruSC5[nSC5][1],aStruSC5[nSC5][2],aStruSC5[nSC5][3],aStruSC5[nSC5][4])
	EndIf
Next nSC5
For nSC6 := 1 To Len(aStruSC6)
	If aStruSC6[nSC6][2] <> "C" .and. FieldPos(aStruSC6[nSC6][1]) > 0
		TcSetField(cAliasSC6,aStruSC6[nSC6][1],aStruSC6[nSC6][2],aStruSC6[nSC6][3],aStruSC6[nSC6][4])
	EndIf
Next nSC6

nTOTALPED  := 0
nOUTRDESPES:= 0
nTOTALMERC := 0
nTOTALNF   := 0

While !((cAliasSC5)->(Eof())) .and. xFilial("SC5")==(cAliasSC5)->C5_FILIAL
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa a validacao dos filtros do usuario           	     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(cAliasSC5)
	lFiltro := IIf((!Empty(aReturn[7]).And.!&(aReturn[7])),.F.,.T.)
	
	//If lFiltro
	
	cCliEnt   := IIf(!Empty((cAliasSC5)->(FieldGet(FieldPos("C5_CLIENT")))),(cAliasSC5)->C5_CLIENT,(cAliasSC5)->C5_CLIENTE)
	
	aCabPed := {}
	
	MaFisIni(cCliEnt,;							// 1-Codigo Cliente/Fornecedor
	(cAliasSC5)->C5_LOJACLI,;			// 2-Loja do Cliente/Fornecedor
	IIf((cAliasSC5)->C5_TIPO$'DB',"F","C"),;	// 3-C:Cliente , F:Fornecedor
	(cAliasSC5)->C5_TIPO,;				// 4-Tipo da NF
	(cAliasSC5)->C5_TIPOCLI,;			// 5-Tipo do Cliente/Fornecedor
	aRelImp,;							// 6-Relacao de Impostos que suportados no arquivo
	,;						   			// 7-Tipo de complemento
	,;									// 8-Permite Incluir Impostos no Rodape .T./.F.
	"SB1",;							// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
	"MATA461")							// 10-Nome da rotina que esta utilizando a funcao
	
	nFrete		:= (cAliasSC5)->C5_FRETE
	nSeguro		:= (cAliasSC5)->C5_SEGURO
	nFretAut	:= (cAliasSC5)->C5_FRETAUT
	nDespesa	:= (cAliasSC5)->C5_DESPESA
	nDescCab	:= (cAliasSC5)->C5_DESCONT
	nPDesCab	:= (cAliasSC5)->C5_PDESCAB
	
	aItemPed:= {}
	aCabPed := {	(cAliasSC5)->C5_TIPO,;
	(cAliasSC5)->C5_CLIENTE,;
	(cAliasSC5)->C5_LOJACLI,;
	(cAliasSC5)->C5_TRANSP,;
	(cAliasSC5)->C5_CONDPAG,;
	(cAliasSC5)->C5_EMISSAO,;
	(cAliasSC5)->C5_NUM,;
	(cAliasSC5)->C5_VEND1,;
	(cAliasSC5)->C5_VEND2,;
	(cAliasSC5)->C5_VEND3,;
	(cAliasSC5)->C5_VEND4,;
	(cAliasSC5)->C5_VEND5,;
	(cAliasSC5)->C5_COMIS1,;
	(cAliasSC5)->C5_COMIS2,;
	(cAliasSC5)->C5_COMIS3,;
	(cAliasSC5)->C5_COMIS4,;
	(cAliasSC5)->C5_COMIS5,;
	(cAliasSC5)->C5_FRETE,;
	(cAliasSC5)->C5_TPFRETE,;
	(cAliasSC5)->C5_SEGURO,;
	(cAliasSC5)->C5_TABELA,;
	(cAliasSC5)->C5_VOLUME1,;
	(cAliasSC5)->C5_ESPECI1,;
	(cAliasSC5)->C5_MOEDA,;
	(cAliasSC5)->C5_REAJUST,;
	(cAliasSC5)->C5_BANCO,;
	(cAliasSC5)->C5_ACRSFIN,;
	(cAliasSC5)->C5_PEDCLI;
	}
	nTotQtd:=0
	nTotVal:=0
	nPesBru:=0
	nPesLiq:=0
	aPedCli:= {}
	If !lQuery
		dbSelectArea(cAliasSC6)
		dbSetOrder(1)
		dbSeek(xFilial("SC6")+(cAliasSC5)->C5_NUM)
	EndIf
	cPedido    := (cAliasSC5)->C5_NUM
	aC5Rodape  := {}
	aadd(aC5Rodape,{(cAliasSC5)->C5_PBRUTO,(cAliasSC5)->C5_PESOL,(cAliasSC5)->C5_DESC1,(cAliasSC5)->C5_DESC2,;
	(cAliasSC5)->C5_DESC3,(cAliasSC5)->C5_DESC4,(cAliasSC5)->C5_MENNOTA})
	
	aPedCli := Mtr730Cli(cPedido)
	
	
	dbSelectArea(cAliasSC5)
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&(aFisGetSC5[ny][2]))
			If aFisGetSC5[ny][1] == "NF_SUFRAMA"
				MaFisAlt(aFisGetSC5[ny][1],Iif(&(aFisGetSC5[ny][2]) == "1",.T.,.F.),Len(aItemPed),.T.)
			Else
				MaFisAlt(aFisGetSC5[ny][1],&(aFisGetSC5[ny][2]),Len(aItemPed),.T.)
			Endif
		EndIf
	Next nY
	
	
	While !((cAliasSC6)->(Eof())) .And. xFilial("SC6")==(cAliasSC6)->C6_FILIAL .And.;
		(cAliasSC6)->C6_NUM == cPedido
		
		cNfOri     := Nil
		cSeriOri   := Nil
		nRecnoSD1  := Nil
		nDesconto  := 0
		
		If !Empty((cAliasSC6)->C6_NFORI)
			dbSelectArea("SD1")
			dbSetOrder(1)
			dbSeek(xFilial("SC6")+(cAliasSC6)->C6_NFORI+(cAliasSC6)->C6_SERIORI+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA+;
			(cAliasSC6)->C6_PRODUTO+(cAliasSC6)->C6_ITEMORI)
			cNfOri     := (cAliasSC6)->C6_NFORI
			cSeriOri   := (cAliasSC6)->C6_SERIORI
			nRecnoSD1  := SD1->(RECNO())
		EndIf
		
		dbSelectArea(cAliasSC6)
		
		If lEnd
			@ Prow()+1,001 PSAY "CANCELADO PELO OPERADOR" //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula o preco de lista                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nValMerc  := (cAliasSC6)->C6_VALOR
		nPrcLista := (cAliasSC6)->C6_PRUNIT
		If ( nPrcLista == 0 )
			nPrcLista := NoRound(nValMerc/(cAliasSC6)->C6_QTDVEN,TamSX3("C6_PRCVEN")[2])
		EndIf
		nAcresFin := A410Arred((cAliasSC6)->C6_PRCVEN*(cAliasSC5)->C5_ACRSFIN/100,"D2_PRCVEN")
		nValMerc  += A410Arred((cAliasSC6)->C6_QTDVEN*nAcresFin,"D2_TOTAL")
		nDesconto := a410Arred(nPrcLista*(cAliasSC6)->C6_QTDVEN,"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto==0,(cAliasSC6)->C6_VALDESC,nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresFin
		If cPaisLoc=="BRA"
			nValMerc  += nDesconto
		EndIf
		
		MaFisAdd((cAliasSC6)->C6_PRODUTO,; 	  // 1-Codigo do Produto ( Obrigatorio )
		(cAliasSC6)->C6_TES,;			  // 2-Codigo do TES ( Opcional )
		(cAliasSC6)->C6_QTDVEN,;		  // 3-Quantidade ( Obrigatorio )
		nPrcLista,;		  // 4-Preco Unitario ( Obrigatorio )
		nDesconto,;       // 5-Valor do Desconto ( Opcional )
		cNfOri,;		                  // 6-Numero da NF Original ( Devolucao/Benef )
		cSeriOri,;		                  // 7-Serie da NF Original ( Devolucao/Benef )
		nRecnoSD1,;			          // 8-RecNo da NF Original no arq SD1/SD2
		0,;							  // 9-Valor do Frete do Item ( Opcional )
		0,;							  // 10-Valor da Despesa do item ( Opcional )
		0,;            				  // 11-Valor do Seguro do item ( Opcional )
		0,;							  // 12-Valor do Frete Autonomo ( Opcional )
		nValMerc,;// 13-Valor da Mercadoria ( Obrigatorio )
		0,;							  // 14-Valor da Embalagem ( Opiconal )
		0,;		     				  // 15-RecNo do SB1
		0) 							  // 16-RecNo do SF4

		aadd(aItemPed,	{	(cAliasSC6)->C6_ITEM,;
		(cAliasSC6)->C6_PRODUTO,;
		(cAliasSC6)->C6_DESCRI,;
		(cAliasSC6)->C6_TES,;
		(cAliasSC6)->C6_CF,;
		(cAliasSC6)->C6_UM,;
		(cAliasSC6)->C6_QTDVEN,;
		(cAliasSC6)->C6_PRCVEN,;
		(cAliasSC6)->C6_NOTA,;
		(cAliasSC6)->C6_SERIE,;
		(cAliasSC6)->C6_CLI,;
		(cAliasSC6)->C6_LOJA,;
		(cAliasSC6)->C6_VALOR,;
		(cAliasSC6)->C6_ENTREG,;
		(cAliasSC6)->C6_DESCONT,;
		(cAliasSC6)->C6_LOCAL,;
		(cAliasSC6)->C6_QTDEMP,;
		(cAliasSC6)->C6_QTDLIB,;
		(cAliasSC6)->C6_QTDENT,;
		})
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Forca os valores de impostos que foram informados no SC6.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSC6)
		For nY := 1 to Len(aFisGet)
			If !Empty(&(aFisGet[ny][2]))
				MaFisAlt(aFisGet[ny][1],&(aFisGet[ny][2]),Len(aItemPed))
			EndIf
		Next nY
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calculo do ISS                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+(cAliasSC6)->C6_TES))
		If ( (cAliasSC5)->C5_INCISS == "N" .And. (cAliasSC5)->C5_TIPO == "N")
			If ( SF4->F4_ISS=="S" )
				nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
				nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(Len(aItemPed))/100)),"D2_PRCVEN")
				MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
				MaFisAlt("IT_VALMERC",nValMerc,Len(aItemPed))
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera peso para calcular frete              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(dbSetOrder(1))
		SB1->(MsSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))
		MaFisAlt("IT_PESO",(cAliasSC6)->C6_QTDVEN*SB1->B1_PESO,Len(aItemPed))
		MaFisAlt("IT_PRCUNI",nPrcLista,Len(aItemPed))
		MaFisAlt("IT_VALMERC",nValMerc,Len(aItemPed))
		
		If !lQuery
			dbSelectArea(cAliasSC6)
		EndIf
		
		(cAliasSC6)->(dbSkip())
	EndDo
	
	MaFisAlt("NF_FRETE"   ,nFrete)
	MaFisAlt("NF_SEGURO"  ,nSeguro)
	MaFisAlt("NF_AUTONOMO",nFretAut)
	MaFisAlt("NF_DESPESA" ,nDespesa)
	
	If nDescCab > 0
		MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nDescCab+MaFisRet(,"NF_DESCONTO")))
	EndIf
	If nPDesCab > 0
		MaFisAlt("NF_DESCONTO",A410Arred(MaFisRet(,"NF_VALMERC")*nPDesCab/100,"C6_VALOR")+MaFisRet(,"NF_DESCONTO"))
	EndIf
	
	nItem := 0
	aNFPed := {}
	cVerifica	:= ""
	For nG := 1 To Len(aItemPed)
		nItem 	+= 1
		nTotVal += aItemPed[nItem][13]				//C6_VALOR
		If !ALLTRIM(aItemPed[nItem,09]) $ ALLTRIM(cVerifica)
			cVerifica	+= ALLTRIM(aItemPed[nItem,09])+"/"
			aadd(aNFPed,{aItemPed[nItem,09],aItemPed[nItem,10],aItemPed[nItem,11],aItemPed[nItem,12]})
			//		    (cAliasSC6)->C6_NOTA,(cAliasSC6)->C6_SERIE,(cAliasSC6)->C6_CLI,(cAliasSC6)->C6_LOJA
		EndIf
	Next
	
	//Imprime detalhes
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,ntipo)
		nLin := 8
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona registro no cliente do pedido                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	IF !(aCabPed[1]$"DB")   //C5_TIPO
		dbSelectArea("SA1")
		dbSeek(xFilial("SA1")+aCabped[2]+aCabped[3])  //C5_CLIENTE + C5_LOJACLI
		cPictCgc := PesqPict("SA1","A1_CGC")
	Else
		dbSelectArea("SA2")
		dbSeek(xFilial("SA2")+aCabPed[2]+aCabPed[3])  //C5_CLIENTE + C5_LOJACLI
		cPictCgc := PesqPict("SA2","A2_CGC")
	Endif
	
	IF !(aCabPed[1]$"DB")		//C5_TIPO
		cCodCli 	:= SA1->A1_COD
		cLojaCli	:= SA1->A1_LOJA
		cNomecli	:= SA1->A1_NOME
		cCliente	:= LEFT(SA1->A1_COD+"/"+SA1->A1_LOJA+" - "+SA1->A1_NOME,52) //52
		cEnder		:= SA1->A1_END //50
		cMunic		:= SA1->A1_MUN //25
		cUF			:= SA1->A1_EST //2
	Else
		cCodCli 	:= SA2->A2_COD
		cLojaCli	:= SA2->A2_LOJA
		cNomecli	:= SA2->A2_NOME
		cCliente	:= LEFT(SA2->A2_COD+"/"+SA2->A2_LOJA+" "+SA2->A2_NOME,52) //52
		cEnder		:= SA2->A2_END //40
		cMunic		:= SA2->A2_MUN //15
		cUF			:= SA2->A2_EST //2
	Endif
	
	XLS->(RECLOCK("XLS",.T.))
	
	XLS->PEDIDO_NC	:= aCabPed[7]
	XLS->PED_CLI	:= aCabPed[28]
	XLS->CODCLI		:= cCodCli
	XLS->LOJACLI	:= cLojaCli
	XLS->CLIENTE	:= cNomecli
	XLS->ENDERECO	:= cEnder
	XLS->MUNICIPIO	:= cMunic
	XLS->UF			:= cUF
	XLS->TIPOPED	:= aCabPed[1]
	XLS->DTEMIPED	:= dtoc(aCabPed[6])
	XLS->TOTALPED	:= MaFisRet(,"NF_TOTAL")
	XLS->OUTRDESPES	:= aCabPed[18]+aCabPed[20]+nDespesa
	XLS->TOTALMERC	:= nTotVal

	@nLin,000 psay SUBSTR(cCliente,1,40)
	@nLin,042 psay SUBSTR(cEnder,1,35)
	@nLin,079 psay aCabPed[28]
	
	@nLin,088 psay aCabPed[6] //C5_EMISSAO
	@nLin,097 psay alltrim(aCabPed[7]) //C5_NUM
	cTOTVAL	:= Transform(nTotVal,PesqPict("SF2","F2_VALBRUT"))
	@nLin,104 psay substring(cTOTVAL,3,len(cTOTVAL))
//	@nLin,102 PSay Transform(nTotVal,PesqPict("SF2","F2_VALBRUT"))
	
	@nLin,117 psay aCabPed[18]+aCabPed[20]+nDespesa Picture "@EZ 999,999,999.99"		//C5_FRETE+C5_SEGURO+C5_DESPESA
	@nLin,132 PSay Transform(MaFisRet(,"NF_TOTAL"),PesqPict("SF2","F2_VALBRUT"))
	nTOTALPED  += MaFisRet(,"NF_TOTAL")
	nOUTRDESPES+= aCabPed[18]+aCabPed[20]+nDespesa
	nTOTALMERC += nTotVal
	
	lItemNF := .F.
	lFirst	:= .T.
	FOR XX:= 1 TO LEN(aNFPed)
		// 		aadd{aNFPed,(aItemPed[nItem][09],aItemPed[nItem][10]  ,aItemPed[nItem][11],aItemPed[nItem][12])}
		//		    (cAliasSC6)->C6_NOTA,(cAliasSC6)->C6_SERIE,(cAliasSC6)->C6_CLI,(cAliasSC6)->C6_LOJA
		cF2Doc  := aNFPed[XX,1] //GETADVFVAL("SF2","F2_DOC",XFILIAL("SF2")+PADR(aNFPed[XX,1],TAMSX3("F2_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("F2_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("F2_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("F2_LOJA")[1]),1,"")
		dF2Emis := GETADVFVAL("SF2","F2_EMISSAO",XFILIAL("SF2")+PADR(aNFPed[XX,1],TAMSX3("F2_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("F2_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("F2_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("F2_LOJA")[1]),1,"")
		nF2Valbr:= GETADVFVAL("SF2","F2_VALBRUT",XFILIAL("SF2")+PADR(aNFPed[XX,1],TAMSX3("F2_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("F2_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("F2_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("F2_LOJA")[1]),1,0)
		cSedex  := GETADVFVAL("SF2","F2_NSEDEX",XFILIAL("SF2")+PADR(aNFPed[XX,1],TAMSX3("F2_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("F2_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("F2_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("F2_LOJA")[1]),1,"")
		nTOTALNF   += nF2Valbr
		if !empty(cF2Doc)
			IF !lFirst
				XLS->(MSUNLOCK())
				XLS->(RECLOCK("XLS",.T.))
				
				@nLin,096 psay aCabPed[7] //C5_NUM
				@nLin,147 PSay cF2Doc
				@nLin,157 PSay DTOC(dF2Emis)
				@nLin,166 PSay Transform(nF2Valbr ,PesqPict("SF2","F2_VALBRUT"))
				dZ1Emis 	:= GETADVFVAL("SZ1","Z1_DTEMISS",XFILIAL("SZ1")+PADR(aNFPed[XX,1],TAMSX3("Z1_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("Z1_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("Z1_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("Z1_LOJA")[1]),1,"")
				dZ1Entreg	:= GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+PADR(aNFPed[XX,1],TAMSX3("Z1_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("Z1_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("Z1_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("Z1_LOJA")[1]),1,"")
				@nLin,181 PSay DTOC(dZ1Emis)
				@nLin,190 PSay DTOC(dZ1Entreg)
				@nLin,199 PSay cSedex
//  "Cliente                                  Endereço                             Ped Cli  Dt.Ped  Pedido Val Merc Ped. Outr. Despes   Total Pedido   NFiscal   Dt NF    Val Total NF   Expedido Entregue Cod Sedex"
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
				
				XLS->PEDIDO_NC	:= aCabPed[7]
				XLS->PED_CLI	:= aCabPed[28]
				XLS->NOTAFISCAL := cF2Doc
				XLS->DTEMINF	:= dtoc(dF2Emis)
				XLS->TOTALNF	:= nF2Valbr
				XLS->DTSAIDA	:= dtoc(dZ1Emis)
				XLS->DTENTREGA	:= dtoc(dZ1Entreg)
				XLS->NSEDEX		:=  cSedex
			ELSE
				@nLin,147 PSay cF2Doc
				@nLin,157 PSay DTOC(dF2Emis)
				@nLin,166 PSay Transform(nF2Valbr ,PesqPict("SF2","F2_VALBRUT"))
				dZ1Emis 	:= GETADVFVAL("SZ1","Z1_DTEMISS",XFILIAL("SZ1")+PADR(aNFPed[XX,1],TAMSX3("Z1_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("Z1_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("Z1_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("Z1_LOJA")[1]),1,"")
				dZ1Entreg	:= GETADVFVAL("SZ1","Z1_DTENTRE",XFILIAL("SZ1")+PADR(aNFPed[XX,1],TAMSX3("Z1_DOC")[1])+PADR(aNFPed[XX,2],TAMSX3("Z1_SERIE")[1])+PADR(aNFPed[XX,3],TAMSX3("Z1_CLIENTE")[1])+PADR(aNFPed[XX,4],TAMSX3("Z1_LOJA")[1]),1,"")
				@nLin,181 PSay DTOC(dZ1Emis)
				@nLin,190 PSay DTOC(dZ1Entreg)
				@nLin,199 PSay cSedex

				XLS->NOTAFISCAL:= cF2Doc
				XLS->DTEMINF	:= dtoc(dF2Emis)
				XLS->TOTALNF	:= nF2Valbr
				XLS->DTSAIDA	:= dtoc(dZ1Emis)
				XLS->DTENTREGA	:= dtoc(dZ1Entreg)
				XLS->NSEDEX		:=  cSedex
				lFirst	:= .F.
			ENDIF
			nLin := nLin + 1 // Avanca a linha de impressao
			lItemNF := .T.
		EndIf
	NEXT XX

	XLS->(MSUNLOCK())
	
	IF !lItemNF
		nLin := nLin + 1 // Avanca a linha de impressao
	ENDIF
	
	MaFisEnd()

//	dbSelectArea(cAliasSC5)
//	dbSkip()
	
EndDo


@ @nLin,000 psay Replicate("-",limite)

nLin := nLin + 1 // Avanca a linha de impressao

//Imprime Totalizador
@nLin,010 PSay "T O T A I S   ----->"
@nLin,101 PSay Transform(nTOTALMERC,PesqPict("SF2","F2_VALBRUT"))	
@nLin,117 PSay Transform(nOUTRDESPES,PesqPict("SF2","F2_VALBRUT"))
@nLin,131 PSay Transform(nTOTALPED  ,PesqPict("SF2","F2_VALBRUT"))
@nLin,165 PSay Transform(nTOTALNF ,PesqPict("SF2","F2_VALBRUT"))



If lQuery
	dbSelectArea(cAliasSC5)
	dbCloseArea()
Endif

RetIndex("SC5")
dbSelectArea("SC5")
dbClearFilter()

Ferase(cIndex+OrdBagExt())

XLS->(DBGOTOP())

//FAZ A ABERTURA DO EXCEL
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\Relatorios\" + CNOMEDBF + ".DBF" )

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	XLS->(DBCLOSEAREA())
ELSE	
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
EndIf

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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Mtr730Cli ³ Autor ³ Henry Fila            ³ Data ³ 26.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Função que retorna os pedidos do cliente                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Mtr730Cli(cPedido)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1: Numero do pedido                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Matr730                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Mtr730Cli(cPedido)

Local aPedidos := {}
Local aArea    := GetArea()
Local aAreaSC6 := SC6->(GetArea())

SC6->(dbSetOrder(1))
SC6->(MsSeek(xFilial("SC6")+cPedido))

While !(SC6->(Eof())) .And. xFilial("SC6")==SC6->C6_FILIAL .And.;
		SC6->C6_NUM == cPedido

	If !Empty(SC6->C6_PEDCLI) .and. Ascan(aPedidos,SC6->C6_PEDCLI) = 0
		Aadd(aPedidos, SC6->C6_PEDCLI )
	Endif		

	SC6->(dbSkip())
Enddo

RestArea(aAreaSC6)
RestArea(aArea)

Return(aPedidos)




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³FisGetInit³ Autor ³Eduardo Riera          ³ Data ³17.11.2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Inicializa as variaveis utilizadas no Programa              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FisGetInit(aFisGet,aFisGetSC5)

Local cValid      := ""
Local cReferencia := ""
Local nPosIni     := 0
Local nLen        := 0

If aFisGet == Nil
	aFisGet	:= {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SC6")
	While !Eof().And.X3_ARQUIVO=="SC6"
		cValid := UPPER(X3_VALID+X3_VLDUSER)
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		dbSkip()
	EndDo
	aSort(aFisGet,,,{|x,y| x[3]<y[3]})
EndIf

If aFisGetSC5 == Nil
	aFisGetSC5	:= {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SC5")
	While !Eof().And.X3_ARQUIVO=="SC5"
		cValid := UPPER(X3_VALID+X3_VLDUSER)
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		dbSkip()
	EndDo
	aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})
EndIf
MaFisEnd()
Return(.T.)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Rodrigo Okamoto        ³ Data ³07/03/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Acerta o arquivo de perguntas                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSx1()

Local aArea := GetArea()
Local aHelpP	:= {}
Local aHelpE	:= {}
Local aHelpS	:= {}

Aadd( aHelpP, "Considera Data de Emissão dos Pedidos de ?" )
PutSx1("FATSTA","01","Dt Pedido de ?"  ,"Dt Pedido ate ?","Dt Pedido ate ?","mv_ch1","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par01        // Data de                  		         ³
aHelpP	:= {}
Aadd( aHelpP, "Considera Data de Emissão dos Pedidos ate ?" )
PutSx1("FATSTA","02","Dt Pedido ate ?"  ,"Dt Pedido ate ?","Dt Pedido ate ?","mv_ch2","D",8,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par02        // Data ate  					       		 ³

aHelpP	:= {}
Aadd( aHelpP, "Lista os Pedidos do Vendedor ?" )
PutSx1("FATSTA","03","Vendedor ?"  ,"Vendedor ?","Vendedor ?","mv_ch3","C",6,0,0,"G","","SA3","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par03        // Cliente de                                ³

RestArea(aArea)

Return



