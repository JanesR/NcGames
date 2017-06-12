#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCFATVPC  º Autor ³ Rodrigo Okamoto    º Data ³  22/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatório com informações para VPC                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC GAMES                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NCFATVPC


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cArq,cInd
Local cString := "SF2"
Local aStru := {}
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Tempo Estimado/mês para geração: 15 minutos"
Local cPict          := ""
Local titulo       := "Relatório VPC"
Local nLin         := 80

Local Cabec1       := "Tp Pedido Entrega  N. Fiscal Cliente (Nome Fantasia)        UF Emis NF  Vl. Total      Vlr IPI        Vlr ST         Vlr Desp       Vlr Merc       Vlr PIS        Vlr Cofins     Vlr ICMS       Vlr s/ Imp.    Vend         "
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//--                   0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//--                   01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "NCFATVPC" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       := "FATVPC"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "NCFATVPC" // Coloque aqui o nome do arquivo usado para impressao em disco

aAdd(aStru,{"TIPO","C",11,0})
aAdd(aStru,{"PEDIDO","C",6,0})
aAdd(aStru,{"FILIAL","C",2,0})
aAdd(aStru,{"DATAAG","C",10,0})
aAdd(aStru,{"DTEMIPED","C",10,0})
aAdd(aStru,{"DOC","C",9,0})
aAdd(aStru,{"CODCLI","C",6,0})
aAdd(aStru,{"LOJACLI","C",2,0})
aAdd(aStru,{"CLIENTE","C",40,0})
aAdd(aStru,{"NREDCLI","C",30,0})
aAdd(aStru,{"UF","C",2,0})
aAdd(aStru,{"DTEMINF","C",10,0})
aAdd(aStru,{"VALBRUT","N",14,2})
aAdd(aStru,{"VALIPI","N",14,2})
aAdd(aStru,{"ICMSRET","N",14,2})
aAdd(aStru,{"OUTRDESPES","N",14,2})
aAdd(aStru,{"VALMERC","N",14,2})
aAdd(aStru,{"BASEPIS","N",14,2})
aAdd(aStru,{"BASECOF","N",14,2})
aAdd(aStru,{"BASEICM","N",14,2})
aAdd(aStru,{"VALPIS","N",14,2})
aAdd(aStru,{"VALCOF","N",14,2})
aAdd(aStru,{"VALICM","N",14,2})
aAdd(aStru,{"SEMIMPOSTO","N",14,2})
aAdd(aStru,{"CODVEND","C",6,0})
aAdd(aStru,{"VENDEDOR","C",40,0})
aAdd(aStru,{"TRANSP","C",20,0})
aAdd(aStru,{"DTENTREGA","C",10,0})
aAdd(aStru,{"NFORI","C",9,0})
aAdd(aStru,{"SERIORI","C",3,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "NCFATVPC"+DTOS(DDATABASE)+ALLTRIM(Upper(cUsername))

  	If File("C:\RELATORIOS\" + CNOMEDBF +".DBF")
		FErase("C:\RELATORIOS\" + CNOMEDBF +".DBF")
	EndIf
	
DBCREATE(CNOMEDBF,aStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)


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
//³ mv_par01        // Data de                  		         ³
//³ mv_par02        // Data ate  					       		 ³
//³ mv_par03        // Cliente de                                ³
//³ mv_par04 	    // Cliente ate                               ³
//³ mv_par05	    // Loja de                                 ³
//³ mv_par06	    // Loja ate                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SetRegua(RecCount())
ProcRegua(SF2->(Reccount()))

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

/*cQry:=" SELECT 'FATURAMENTO' TIPO, C5_NUM PEDIDO, C5_FILIAL FILIAL, F2_DATAAG DATAAG, C5_EMISSAO DTEMIPED, F2_DOC DOC,
cQry+=" 	A1_NOME CLIENTE, A1_NREDUZ NREDCLI, A1_EST UF, F2_EMISSAO DTEMINF, F2_VALBRUT VALBRUT, F2_VALIPI VALIPI, F2_ICMSRET ICMSRET,
cQry+=" 	A1_COD CODCLI, A1_LOJA LOJACLI, F2_FRETE+F2_SEGURO+F2_DESPESA OUTRDESPES, F2_VALMERC VALMERC, F2_BASIMP6 BASEPIS,
cQry+=" 	F2_BASIMP5 BASECOF,F2_BASEICM BASEICM, F2_VALIMP6 VALPIS, F2_VALIMP5 VALCOF, F2_VALICM VALICM,
cQry+=" 	F2_VALMERC-(F2_VALIMP5+F2_VALIMP6+F2_VALICM) SEMIMPOSTO,
cQry+=" 	A3_COD CODVEND, A3_NOME VENDEDOR, A4_NREDUZ TRANSP, Z1_DTENTRE DTENTREGA
cQry+=" FROM SF2010 SF2, SC5010 SC5, SA3010 SA3, SA4010 SA4, SA1010 SA1, SZ1010 SZ1,
cQry+=" 	(SELECT DISTINCT(D2_FILIAL) FILIALSD2, D2_DOC DOCSD2, D2_PEDIDO PEDIDOSD2, D2_SERIE SERIESD2
cQry+=" 		FROM SD2010 SD2, SF4010 SF4
cQry+=" 		WHERE SD2.D_E_L_E_T_ <> '*'
cQry+=" 		AND SF4.D_E_L_E_T_ <> '*'
cQry+=" 		AND SD2.D2_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'
cQry+=" 		AND SD2.D2_TES = SF4.F4_CODIGO
cQry+=" 		AND SF4.F4_DUPLIC = 'S') TMPSD2
cQry+=" 	WHERE SF2.D_E_L_E_T_ <> '*' AND SC5.D_E_L_E_T_ <> '*' AND SA4.D_E_L_E_T_ <> '*'
cQry+=" 	AND SA3.D_E_L_E_T_ <> '*' AND SA1.D_E_L_E_T_ <> '*' AND SZ1.D_E_L_E_T_ <> '*'
cQry+=" 	AND SF2.F2_DOC = TMPSD2.DOCSD2
cQry+=" 	AND SF2.F2_SERIE = TMPSD2.SERIESD2
cQry+=" 	AND SF2.F2_FILIAL = TMPSD2.FILIALSD2
cQry+=" 	AND SC5.C5_NUM = TMPSD2.PEDIDOSD2
cQry+=" 	AND SC5.C5_FILIAL = TMPSD2.FILIALSD2
cQry+=" 	AND SF2.F2_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'
cQry+=" 	AND SF2.F2_CLIENTE BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'
cQry+=" 	AND SF2.F2_LOJA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'
cQry+=" 	AND SC5.C5_VEND1 = SA3.A3_COD
cQry+=" 	AND SC5.C5_TRANSP = SA4.A4_COD
cQry+=" 	AND SA1.A1_COD = SF2.F2_CLIENTE
cQry+=" 	AND SA1.A1_LOJA = SF2.F2_LOJA
cQry+=" 	AND SZ1.Z1_DOC = SF2.F2_DOC
cQry+=" 	AND SZ1.Z1_SERIE = SF2.F2_SERIE
cQry+=" 	AND SZ1.Z1_FILIAL = SF2.F2_FILIAL
cQry+=" ORDER BY A1_COD, A1_LOJA, SF2.F2_FILIAL, SF2.F2_DOC*/
cQry:=" SELECT 'FATURAMENTO' TIPO, C5_NUM PEDIDO, C5_FILIAL FILIAL, F2_DATAAG DATAAG, C5_EMISSAO DTEMIPED, F2_DOC DOC,
cQry+=" 	A1_NOME CLIENTE, A1_NREDUZ NREDCLI, A1_EST UF, F2_EMISSAO DTEMINF, F2_VALBRUT VALBRUT, F2_VALIPI VALIPI, F2_ICMSRET ICMSRET,
cQry+=" 	A1_COD CODCLI, A1_LOJA LOJACLI, F2_FRETE+F2_SEGURO+F2_DESPESA OUTRDESPES, F2_VALMERC VALMERC, F2_BASIMP6 BASEPIS,
cQry+=" 	F2_BASIMP5 BASECOF,F2_BASEICM BASEICM, F2_VALIMP6 VALPIS, F2_VALIMP5 VALCOF, F2_VALICM VALICM,
cQry+=" 	F2_VALMERC-(F2_VALIMP5+F2_VALIMP6+F2_VALICM) SEMIMPOSTO,
cQry+=" 	A3_COD CODVEND, A3_NOME VENDEDOR, A4_NREDUZ TRANSP, Z1_DTENTRE DTENTREGA
cQry+=" FROM SF2010 SF2, SC5010 SC5, SA3010 SA3, SA4010 SA4, SA1010 SA1, SZ1010 SZ1,
cQry+=" 	(SELECT DISTINCT(D2_FILIAL) FILIALSD2, D2_DOC DOCSD2, D2_PEDIDO PEDIDOSD2, D2_SERIE SERIESD2
cQry+=" 		FROM SD2010 SD2, SF4010 SF4
cQry+=" 		WHERE SD2.D_E_L_E_T_ <> '*'
cQry+=" 		AND SF4.D_E_L_E_T_ <> '*'
cQry+=" 		AND SD2.D2_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'
cQry+=" 		AND SD2.D2_TES = SF4.F4_CODIGO
cQry+=" 		AND SF4.F4_DUPLIC = 'S') TMPSD2
cQry+=" 	WHERE SF2.D_E_L_E_T_ <> '*' AND SC5.D_E_L_E_T_ <> '*' AND SA4.D_E_L_E_T_ <> '*'
cQry+=" 	AND SA3.D_E_L_E_T_ <> '*' AND SA1.D_E_L_E_T_ <> '*' AND SZ1.D_E_L_E_T_ <> '*'
cQry+=" 	AND SF2.F2_DOC = TMPSD2.DOCSD2
cQry+=" 	AND SF2.F2_SERIE = TMPSD2.SERIESD2
cQry+=" 	AND SF2.F2_FILIAL = TMPSD2.FILIALSD2
cQry+=" 	AND SC5.C5_NUM = TMPSD2.PEDIDOSD2
cQry+=" 	AND SC5.C5_FILIAL = TMPSD2.FILIALSD2
cQry+=" 	AND SF2.F2_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'
cQry+=" 	AND SF2.F2_CLIENTE BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'
cQry+=" 	AND SF2.F2_LOJA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'
IF MV_PAR09 == 1
	cQry+=" 	AND (SZ1.Z1_DTENTRE BETWEEN '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"')
ELSEIF MV_PAR09 == 2
	cQry+=" 	AND (SZ1.Z1_DTENTRE = ' ')
ENDIF
//cQry+=" 	AND (SZ1.Z1_DTENTRE BETWEEN '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"' OR SZ1.Z1_DTENTRE = ' ')
cQry+=" 	AND SC5.C5_VEND1 = SA3.A3_COD
cQry+=" 	AND SC5.C5_TRANSP = SA4.A4_COD
cQry+=" 	AND SA1.A1_COD = SF2.F2_CLIENTE
cQry+=" 	AND SA1.A1_LOJA = SF2.F2_LOJA
cQry+=" 	AND SZ1.Z1_DOC = SF2.F2_DOC
cQry+=" 	AND SZ1.Z1_SERIE = SF2.F2_SERIE
cQry+=" 	AND SZ1.Z1_FILIAL = SF2.F2_FILIAL
cQry+=" ORDER BY A1_COD, A1_LOJA, SF2.F2_FILIAL, SF2.F2_DOC

cQry := ChangeQuery(cQry)

memowrit("ncfatvpc.sql",cQry)

MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TRB",.T.,.T.)},"Aguarde...") //"Selecionando Registros..."

DBSELECTAREA("TRB")
dbGoTop()
cChave	:= TRB->CODCLI+TRB->LOJACLI
cNomeCli:= TRB->CLIENTE

//declara os totalizadores
nTotVALBRUT	:= 0
nTotVALIPI	:= 0
nTotICMSRET	:= 0
nTotOUTRDESP:= 0
nTotVALMERC	:= 0
nTotVALPIS	:= 0
nTotVALCOF	:= 0
nTotVALICM	:= 0
nTotSEMIMP	:= 0
nFtVALBRUT	:= 0
nFtVALIPI	:= 0
nFtICMSRET	:= 0
nFtOUTRDESP	:= 0
nFtVALMERC	:= 0
nFtVALPIS	:= 0
nFtVALCOF	:= 0
nFtVALICM	:= 0
nFtSEMIMP	:= 0



While !EOF()
	
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
	// Coloque aqui a logica da impressao do seu programa...
	// Utilize PSAY para saida na impressora. Por exemplo:
	// @nLin,00 PSAY SA1->A1_COD
	
	XLS->(RECLOCK("XLS",.T.))
	FOR I:=1 TO TRB->(FCOUNT())
		IF (nPos:=XLS->(FIELDPOS(TRB->(FIELDNAME(I))))) # 0
			IF FIELDNAME(I) == "DATAAG"
				XLS->(FIELDPUT(nPos,(SUBSTR(TRB->(FIELDGET(I)),7,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),5,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),1,4))))
			ELSEIF FIELDNAME(I) == "DTEMIPED"
				XLS->(FIELDPUT(nPos,(SUBSTR(TRB->(FIELDGET(I)),7,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),5,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),1,4))))
			ELSEIF FIELDNAME(I) == "DTEMINF"
				XLS->(FIELDPUT(nPos,(SUBSTR(TRB->(FIELDGET(I)),7,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),5,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),1,4))))//XLS->(FIELDPUT(nPos,stod(TRB->(FIELDGET(I)))))
			ELSEIF FIELDNAME(I) == "DTENTREGA"
				XLS->(FIELDPUT(nPos,(SUBSTR(TRB->(FIELDGET(I)),7,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),5,2)+"/"+SUBSTR(TRB->(FIELDGET(I)),1,4))))
			ELSE
				XLS->(FIELDPUT(nPos,TRB->(FIELDGET(I))))
			ENDIF
		ENDIF
	NEXT
	IF cChave <> TRB->CODCLI+TRB->LOJACLI
		
		@nLin,000 PSAY "Total do Cliente  --->"
		@nLin,030 PSAY cNomeCli
		@nLin,072 PSAY TRANSFORM(nTotVALBRUT,"@E 999,999,999.99")
		@nLin,087 PSAY TRANSFORM(nTotVALIPI,"@E 999,999,999.99")
		@nLin,102 PSAY TRANSFORM(nTotICMSRET,"@E 999,999,999.99")
		@nLin,117 PSAY TRANSFORM(nTotOUTRDESP,"@E 999,999,999.99")
		@nLin,132 PSAY TRANSFORM(nTotVALMERC,"@E 999,999,999.99")
		@nLin,147 PSAY TRANSFORM(nTotVALPIS,"@E 999,999,999.99")
		@nLin,162 PSAY TRANSFORM(nTotVALCOF,"@E 999,999,999.99")
		@nLin,177 PSAY TRANSFORM(nTotVALICM,"@E 999,999,999.99")
		@nLin,192 PSAY TRANSFORM(nTotSEMIMP,"@E 999,999,999.99")
		
		cChave	:= TRB->CODCLI+TRB->LOJACLI
		cNomeCli:= TRB->CLIENTE
		
		// soma os totais
		nFtVALBRUT	+= nTotVALBRUT
		nFtVALIPI	+= nTotVALIPI
		nFtICMSRET	+= nTotICMSRET
		nFtOUTRDESP	+= nTotOUTRDESP
		nFtVALMERC	+= nTotVALMERC
		nFtVALPIS	+= nTotVALPIS
		nFtVALCOF	+= nTotVALCOF
		nFtVALICM	+= nTotVALICM
		nFtSEMIMP	+= nTotSEMIMP
		
		// zera os totalizadores por cliente
		nTotVALBRUT	:= 0
		nTotVALIPI	:= 0
		nTotICMSRET	:= 0
		nTotOUTRDESP:= 0
		nTotVALMERC	:= 0
		nTotVALPIS	:= 0
		nTotVALCOF	:= 0
		nTotVALICM	:= 0
		nTotSEMIMP	:= 0
		
		nLin := nLin + 2 // Avanca a linha de impressao
		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,ntipo)
			nLin := 8
		Endif

	ENDIF
	
	@nLin,000 PSAY "FT"
	@nLin,003 PSAY TRB->PEDIDO
	@nLin,010 PSAY DTOC(STOD(TRB->DTENTREGA))
	@nLin,019 PSAY TRB->DOC
	@nLin,029 PSAY TRB->NREDCLI
	@nLin,060 PSAY TRB->UF
	@nLin,063 PSAY DTOC(STOD(TRB->DTEMINF))
	@nLin,072 PSAY TRANSFORM(TRB->VALBRUT,"@E 999,999,999.99")
	@nLin,087 PSAY TRANSFORM(TRB->VALIPI,"@E 999,999,999.99")
	@nLin,102 PSAY TRANSFORM(TRB->ICMSRET,"@E 999,999,999.99")
	@nLin,117 PSAY TRANSFORM(TRB->OUTRDESPES,"@E 999,999,999.99")
	@nLin,132 PSAY TRANSFORM(TRB->VALMERC,"@E 999,999,999.99")
	@nLin,147 PSAY TRANSFORM(TRB->VALPIS,"@E 999,999,999.99")
	@nLin,162 PSAY TRANSFORM(TRB->VALCOF,"@E 999,999,999.99")
	@nLin,177 PSAY TRANSFORM(TRB->VALICM,"@E 999,999,999.99")
	@nLin,192 PSAY TRANSFORM(TRB->SEMIMPOSTO,"@E 999,999,999.99")
	@nLin,207 PSAY TRB->CODVEND
	
	//soma nos totais
	nTotVALBRUT	+= TRB->VALBRUT
	nTotVALIPI	+= TRB->VALIPI
	nTotICMSRET	+= TRB->ICMSRET
	nTotOUTRDESP+= TRB->OUTRDESPES
	nTotVALMERC	+= TRB->VALMERC
	nTotVALPIS	+= TRB->VALPIS
	nTotVALCOF	+= TRB->VALCOF
	nTotVALICM	+= TRB->VALICM
	nTotSEMIMP	+= TRB->SEMIMPOSTO
	
	nLin := nLin + 1 // Avanca a linha de impressao
	XLS->(msunlock())
	TRB->(DBSKIP()) // Avanca o ponteiro do registro no arquivo
EndDo

@nLin,000 PSAY "Total do Cliente  --->"
@nLin,030 PSAY cNomeCli
@nLin,072 PSAY TRANSFORM(nTotVALBRUT,"@E 999,999,999.99")
@nLin,087 PSAY TRANSFORM(nTotVALIPI,"@E 999,999,999.99")
@nLin,102 PSAY TRANSFORM(nTotICMSRET,"@E 999,999,999.99")
@nLin,117 PSAY TRANSFORM(nTotOUTRDESP,"@E 999,999,999.99")
@nLin,132 PSAY TRANSFORM(nTotVALMERC,"@E 999,999,999.99")
@nLin,147 PSAY TRANSFORM(nTotVALPIS,"@E 999,999,999.99")
@nLin,162 PSAY TRANSFORM(nTotVALCOF,"@E 999,999,999.99")
@nLin,177 PSAY TRANSFORM(nTotVALICM,"@E 999,999,999.99")
@nLin,192 PSAY TRANSFORM(nTotSEMIMP,"@E 999,999,999.99")
nLin := nLin + 2 // Avanca a linha de impressao


@nLin,000 PSAY "Total Faturamento  --->"
//@nLin,030 PSAY ""
@nLin,072 PSAY TRANSFORM(nFtVALBRUT,"@E 999,999,999.99")
@nLin,087 PSAY TRANSFORM(nFtVALIPI,"@E 999,999,999.99")
@nLin,102 PSAY TRANSFORM(nFtICMSRET,"@E 999,999,999.99")
@nLin,117 PSAY TRANSFORM(nFtOUTRDESP,"@E 999,999,999.99")
@nLin,132 PSAY TRANSFORM(nFtVALMERC,"@E 999,999,999.99")
@nLin,147 PSAY TRANSFORM(nFtVALPIS,"@E 999,999,999.99")
@nLin,162 PSAY TRANSFORM(nFtVALCOF,"@E 999,999,999.99")
@nLin,177 PSAY TRANSFORM(nFtVALICM,"@E 999,999,999.99")
@nLin,192 PSAY TRANSFORM(nFtSEMIMP,"@E 999,999,999.99")

//reinicia página para impressão das devoluções
Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,ntipo)
nLin := 8

If Select("TRB1") > 0
	dbSelectArea("TRB1")
	dbCloseArea()
Endif

cQry:=" SELECT 'DEVOLUCAO' TIPO, D1_FILIAL FILIAL, D1_EMISSAO DTEMINF,D1_NFORI NFORI, D1_SERIORI SERIORI, D1_DOC DOC, D1_SERIE SERIE,
cQry+=" A1_NOME CLIENTE, A1_NREDUZ NREDCLI, SUM(D1_BASEICM) BASEICM,
cQry+=" SUM(D1_VALICM) VALICM, SUM(D1_TOTAL) VALMERC, SUM(D1_ICMSRET) ICMSRET,SUM(D1_VALIMP6) VALPIS,
cQry+=" SUM(D1_VALIMP5) VALCOF, SUM(D1_BASIMP6) BASEPIS, SUM(D1_BASIMP5) BASECOF, SUM(D1_VALIPI) VALIPI,
cQry+=" F1_FORNECE CODCLI, F1_LOJA LOJACLI, A1_EST UF
cQry+=" FROM SF1010 SF1, SA1010 SA1, SD1010 SD1
cQry+=" WHERE SF1.D_E_L_E_T_ <> '*'
cQry+=" AND SA1.D_E_L_E_T_ <> '*'
cQry+=" AND SD1.D_E_L_E_T_ <> '*'
cQry+=" AND SF1.F1_TIPO = 'D'
cQry+=" AND SF1.F1_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'
cQry+=" AND SA1.A1_COD BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'
cQry+=" AND SF1.F1_LOJA BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'
cQry+=" AND SF1.F1_DUPL <> ' '
cQry+=" AND SF1.F1_DOC = SD1.D1_DOC
cQry+=" AND SF1.F1_SERIE = SD1.D1_SERIE
cQry+=" AND SF1.F1_FILIAL = SD1.D1_FILIAL
cQry+=" AND SA1.A1_COD = SF1.F1_FORNECE
cQry+=" AND SA1.A1_LOJA = SF1.F1_LOJA
cQry+=" GROUP BY D1_FILIAL,D1_EMISSAO,D1_DOC,D1_SERIE,A1_NOME,A1_NREDUZ,D1_NFORI,D1_SERIORI,F1_FORNECE,F1_LOJA, A1_EST
cQry+=" ORDER BY F1_FORNECE, F1_LOJA, D1_FILIAL,D1_EMISSAO,D1_DOC
cQry := ChangeQuery(cQry)

memowrit("ncfatvpcdev.sql",cQry)
MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TRB1",.T.,.T.)},"Aguarde...") //"Selecionando Registros..."

//PULA LINHA DO XLS
XLS->(DBSKIP())

DBSELECTAREA("TRB1")
DBGOTOP()
cChave	:= TRB1->CODCLI+TRB1->LOJACLI
cNomeCli:= TRB1->CLIENTE

//declara os totalizadores
nTotVALBRUT	:= 0
nTotVALIPI	:= 0
nTotICMSRET	:= 0
nTotOUTRDESP:= 0
nTotVALMERC	:= 0
nTotVALPIS	:= 0
nTotVALCOF	:= 0
nTotVALICM	:= 0
nTotSEMIMP	:= 0
nFtVALBRUT	:= 0
nFtVALIPI	:= 0
nFtICMSRET	:= 0
nFtOUTRDESP	:= 0
nFtVALMERC	:= 0
nFtVALPIS	:= 0
nFtVALCOF	:= 0
nFtVALICM	:= 0
nFtSEMIMP	:= 0



While TRB1->(!EOF())
	
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
	// Coloque aqui a logica da impressao do seu programa...
	// Utilize PSAY para saida na impressora. Por exemplo:
	// @nLin,00 PSAY SA1->A1_COD
	cPedOri	:= getadvfval("SD2","D2_PEDIDO",PADR(TRB1->FILIAL,2)+PADR(TRB1->NFORI,9)+PADR(TRB1->SERIORI,3)+PADR(TRB1->CODCLI,6)+PADR(TRB1->LOJACLI,2),3,"")
	cVend1	:= getadvfval("SF2","F2_VEND1",PADR(TRB1->FILIAL,2)+PADR(TRB1->NFORI,9)+PADR(TRB1->SERIORI,3)+PADR(TRB1->CODCLI,6)+PADR(TRB1->LOJACLI,2),1,"")
	cNomeVend:=getadvfval("SA3","A3_NOME",XFILIAL("SA3")+cVend1,1,"")

	IF cChave <> TRB1->CODCLI+TRB1->LOJACLI
		
		@nLin,000 PSAY "Total do Cliente  --->"
		@nLin,030 PSAY cNomeCli
		@nLin,072 PSAY TRANSFORM(nTotVALBRUT,"@E 999,999,999.99")
		@nLin,087 PSAY TRANSFORM(nTotVALIPI,"@E 999,999,999.99")
		@nLin,102 PSAY TRANSFORM(nTotICMSRET,"@E 999,999,999.99")
		@nLin,117 PSAY TRANSFORM(nTotOUTRDESP,"@E 999,999,999.99")
		@nLin,132 PSAY TRANSFORM(nTotVALMERC,"@E 999,999,999.99")
		@nLin,147 PSAY TRANSFORM(nTotVALPIS,"@E 999,999,999.99")
		@nLin,162 PSAY TRANSFORM(nTotVALCOF,"@E 999,999,999.99")
		@nLin,177 PSAY TRANSFORM(nTotVALICM,"@E 999,999,999.99")
		@nLin,192 PSAY TRANSFORM(nTotSEMIMP,"@E 999,999,999.99")
		
		cChave	:= TRB1->CODCLI+TRB1->LOJACLI
		cNomeCli:= TRB1->CLIENTE
		
		// soma os totais
		nFtVALBRUT	+= nTotVALBRUT
		nFtVALIPI	+= nTotVALIPI
		nFtICMSRET	+= nTotICMSRET
		nFtOUTRDESP	+= nTotOUTRDESP
		nFtVALMERC	+= nTotVALMERC
		nFtVALPIS	+= nTotVALPIS
		nFtVALCOF	+= nTotVALCOF
		nFtVALICM	+= nTotVALICM
		nFtSEMIMP	+= nTotSEMIMP
		
		// zera os totalizadores por cliente
		nTotVALBRUT	:= 0
		nTotVALIPI	:= 0
		nTotICMSRET	:= 0
		nTotOUTRDESP:= 0
		nTotVALMERC	:= 0
		nTotVALPIS	:= 0
		nTotVALCOF	:= 0
		nTotVALICM	:= 0
		nTotSEMIMP	:= 0
		
		nLin := nLin + 2 // Avanca a linha de impressao
		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,ntipo)
			nLin := 8
		Endif

	ENDIF

	XLS->(RECLOCK("XLS",.T.))
	
	XLS->PEDIDO		:= cPedOri
	XLS->CODVEND	:= cVend1
	XLS->VENDEDOR	:= cNomeVend
	XLS->SEMIMPOSTO	:= TRB1->VALMERC-(TRB1->VALICM+TRB1->VALPIS+TRB1->VALCOF)
	XLS->VALBRUT	:= TRB1->VALMERC+(TRB1->VALIPI+TRB1->ICMSRET)
	
	FOR I:=1 TO TRB->(FCOUNT())
		IF (nPos:=XLS->(FIELDPOS(TRB1->(FIELDNAME(I))))) # 0
			IF FIELDNAME(I) == "DTEMINF"
				XLS->(FIELDPUT(nPos,(SUBSTR(TRB1->(FIELDGET(I)),7,2)+"/"+SUBSTR(TRB1->(FIELDGET(I)),5,2)+"/"+SUBSTR(TRB1->(FIELDGET(I)),1,4))))//XLS->(FIELDPUT(nPos,stod(TRB1->(FIELDGET(I)))))
			ELSE
				XLS->(FIELDPUT(nPos,TRB1->(FIELDGET(I))))
			ENDIF
		ENDIF
	NEXT
	
	
	@nLin,00 PSAY "DV"
	@nLin,003 PSAY cPedOri
	@nLin,010 PSAY "" //DTOC(STOD(TRB->DTENTREGA))
	@nLin,019 PSAY TRB1->DOC
	@nLin,029 PSAY subs(TRB1->NREDCLI,1,20)
	@nLin,060 PSAY TRB1->UF
	@nLin,063 PSAY DTOC(STOD(TRB1->DTEMINF))
	@nLin,072 PSAY TRANSFORM(TRB1->VALMERC+(TRB1->VALIPI+TRB1->ICMSRET),"@E 999,999,999.99")
	@nLin,087 PSAY TRANSFORM(TRB1->VALIPI,"@E 999,999,999.99")
	@nLin,102 PSAY TRANSFORM(TRB1->ICMSRET,"@E 999,999,999.99")
	@nLin,117 PSAY "" //TRANSFORM(TRB1->OUTRDESPES,"@E 999,999,999.99")
	@nLin,132 PSAY TRANSFORM(TRB1->VALMERC,"@E 999,999,999.99")
	@nLin,147 PSAY TRANSFORM(TRB1->VALPIS,"@E 999,999,999.99")
	@nLin,162 PSAY TRANSFORM(TRB1->VALCOF,"@E 999,999,999.99")
	@nLin,177 PSAY TRANSFORM(TRB1->VALICM,"@E 999,999,999.99")
	@nLin,192 PSAY TRANSFORM(TRB1->VALMERC-(TRB1->VALICM+TRB1->VALPIS+TRB1->VALCOF),"@E 999,999,999.99")
	@nLin,207 PSAY cVend1

	//soma os totais
	nTotVALBRUT	+= TRB1->VALMERC+(TRB1->VALIPI+TRB1->ICMSRET)
	nTotVALIPI	+= TRB1->VALIPI
	nTotICMSRET	+= TRB1->ICMSRET
	nTotOUTRDESP+= 0
	nTotVALMERC	+= TRB1->VALMERC
	nTotVALPIS	+= TRB1->VALPIS
	nTotVALCOF	+= TRB1->VALCOF
	nTotVALICM	+= TRB1->VALICM
	nTotSEMIMP	+= TRB1->VALMERC-(TRB1->VALICM+TRB1->VALPIS+TRB1->VALCOF)
	
	nLin := nLin + 1 // Avanca a linha de impressao
	XLS->(msunlock())
	TRB1->(DBSKIP()) // Avanca o ponteiro do registro no arquivo
EndDo

@nLin,000 PSAY "Total do Cliente  --->"
@nLin,030 PSAY cNomeCli
@nLin,072 PSAY TRANSFORM(nTotVALBRUT,"@E 999,999,999.99")
@nLin,087 PSAY TRANSFORM(nTotVALIPI,"@E 999,999,999.99")
@nLin,102 PSAY TRANSFORM(nTotICMSRET,"@E 999,999,999.99")
@nLin,117 PSAY TRANSFORM(nTotOUTRDESP,"@E 999,999,999.99")
@nLin,132 PSAY TRANSFORM(nTotVALMERC,"@E 999,999,999.99")
@nLin,147 PSAY TRANSFORM(nTotVALPIS,"@E 999,999,999.99")
@nLin,162 PSAY TRANSFORM(nTotVALCOF,"@E 999,999,999.99")
@nLin,177 PSAY TRANSFORM(nTotVALICM,"@E 999,999,999.99")
@nLin,192 PSAY TRANSFORM(nTotSEMIMP,"@E 999,999,999.99")
nLin := nLin + 2 // Avanca a linha de impressao


@nLin,000 PSAY "Total Devoluções  --->"
//@nLin,030 PSAY ""
@nLin,072 PSAY TRANSFORM(nFtVALBRUT,"@E 999,999,999.99")
@nLin,087 PSAY TRANSFORM(nFtVALIPI,"@E 999,999,999.99")
@nLin,102 PSAY TRANSFORM(nFtICMSRET,"@E 999,999,999.99")
@nLin,117 PSAY TRANSFORM(nFtOUTRDESP,"@E 999,999,999.99")
@nLin,132 PSAY TRANSFORM(nFtVALMERC,"@E 999,999,999.99")
@nLin,147 PSAY TRANSFORM(nFtVALPIS,"@E 999,999,999.99")
@nLin,162 PSAY TRANSFORM(nFtVALCOF,"@E 999,999,999.99")
@nLin,177 PSAY TRANSFORM(nFtVALICM,"@E 999,999,999.99")
@nLin,192 PSAY TRANSFORM(nFtSEMIMP,"@E 999,999,999.99")

TRB1->(DBCLOSEAREA())

XLS->(DBGOTOP())

//FAZ A ABERTURA DO EXCEL
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\Relatorios\" + CNOMEDBF + ".DBF" )

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
ELSE
	DbSelectArea("TRB")
	DbCloseArea()
	
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
±±³Funcao    ³AjustaSX1 ³ Autor ³Eduardo J. Zanardo     ³ Data ³05/02/2003³±±
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

Aadd( aHelpP, "Considera Notas fiscais de ?" )
PutSx1("FATVPC","01","Data NF de ?"  ,"Data NF de ?","Data NF de ?","mv_ch1","D",8,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par01        // Data de                  		         ³
aHelpP	:= {}
Aadd( aHelpP, "Considera Notas fiscais até ?" )
PutSx1("FATVPC","02","Data NF ate ?"  ,"Data NF ate ?","Data NF ate ?","mv_ch2","D",8,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par02        // Data ate  					       		 ³

aHelpP	:= {}
Aadd( aHelpP, "Considera os clientes de ?" )
PutSx1("FATVPC","03","Cliente de ?"  ,"Cliente de ?","Cliente de ?","mv_ch3","C",6,0,0,"G","","SA1","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par03        // Cliente de                                ³

aHelpP	:= {}
Aadd( aHelpP, "Considera os clientes de ?" )
PutSx1("FATVPC","04","Cliente ate ?"  ,"Cliente ate ?","Cliente ate ?","mv_ch4","C",6,0,0,"G","","SA1","","","mv_par04","","","","","","","","","","","","","","1","","",aHelpP)
//³ mv_par04 	    // Cliente ate                               ³

aHelpP	:= {}
Aadd( aHelpP, "Considera Loja de ?" )
PutSx1("FATVPC","05","Loja de ?"  ,"Loja de ?","Loja de ?","mv_ch5","C",2,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par05	    // Loja de                                 ³

aHelpP	:= {}
Aadd( aHelpP, "Considera Loja ate ?" )
PutSx1("FATVPC","06","Loja ate ?"  ,"Loja ate ?","Loja ate ?","mv_ch6","C",2,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par06	    // Loja ate                                ³

aHelpP	:= {}
Aadd( aHelpP, "Entrega de ?" )
PutSx1("FATVPC","07","Entrega de ?"  ,"Entrega de ?","Entrega de ?","mv_ch7","D",2,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par07	    // Loja de                                 ³

aHelpP	:= {}
Aadd( aHelpP, "Entrega ate ?" )
PutSx1("FATVPC","08","Entrega ate ?"  ,"Entrega ate ?","Entrega ate ?","mv_ch8","D",2,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par08	    // Loja ate                                ³

aHelpP	:= {}
Aadd( aHelpP, "Entregues - Somente notas já entregues" )
Aadd( aHelpP, "Não Entregues - Somente notas não entregues" )
Aadd( aHelpP, "Ambos os casos - Todas as notas fiscais (entregues e não entregues)" )
//         1      2      3              4             5            6       7  8 9 10 11 12 13 14 15  16          17        18 19 20 21              22 23 24      25 26 27 28 29 30 31 32    33
PutSx1("FATVPC","09","Considera ?"  ,"Considera ?","Considera ?","mv_ch9","C",1,0,0,"C","","","","","mv_par09","Entregues","","","","Não Entregues","","","Ambos","","","","","","","","",aHelpP)
//³ mv_par09	    // Loja ate                                ³

RestArea(aArea)

Return