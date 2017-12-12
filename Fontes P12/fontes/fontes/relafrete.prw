#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RelaFrete º Autor ³ Rafael Augusto     º Data ³  21/06/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio que ira verificar as origens dos Frete calculadosº±±
±±º          ³ pelos frete cobrados.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10 - NC GAMES											  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function RelaFrete()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relação do Frete Calculo pelo Cobrado"
Local cPict          := ""
Local titulo         := "Relação do Frete Calculo pelo Cobrado"
Local nLin           := 80
Local Cabec1         := ""
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd 			 := {}
Local Emissao        := CTOD("  /  /    ")

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RELAFRETE" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RELFRETE"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RELAFRETE" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString      := ""

VALIDPERG()
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

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
Cabec1 := "                                                                                                         CALCULADO                  PRATICADO
		// 0         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        17        18        19        20        21        22
		// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
Cabec2 := "  PED.   NOTA       SERIE  DT EMISSAO  CLIENTE                  UF  VENDEDOR           VLR TOT.    |FRETE+SEG   MODAL     |FRETE+SEG            MODAL    |  TP FRETE  TRANSPORTADORA   USUARIO ALT MOTIVO ALT."


RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)




Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  21/06/10   º±±
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
Local li := 9

cQuery:= ""

IF MV_PAR07 == 1 // !EMPTY(MV_PAR03) .AND. (MV_PAR04 $ 'ZZZZ' .OR. MV_PAR04 <>'999999')

	cQuery:= " SELECT C5_NUM, C5_EMISSAO, C5_CLIENTE, SUM(C6_VALOR) VALOR_TOT, C5_VEND1, C5_TPFRETE,C5_SEGUROR, "
	cQuery+= " C5_FRETEOR, C5_FRETETO, C5_FREORTO, C5_MODORIG, C5_FRETE, C5_SEGURO, C5_MODAL, C5_ALTFRET, C5_MOTFRET "
	cQuery+= " FROM SC5010, SC6010 "
	cQuery+= " WHERE C5_NUM = C6_NUM AND C5_NUM >= '"+MV_PAR03+"' AND C5_NUM<= '"+MV_PAR04+"' AND  "
	cQuery+= " C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"'AND "
	IF MV_PAR08 == 2
		cQuery+= " C5_MODAL = '1' AND "
	ELSE
		IF MV_PAR08 == 3
			cQuery+= " C5_MODAL = '2' AND "
		ELSE
			IF MV_PAR08 == 4
				cQuery+= " C5_MODAL = '3' AND  "
			ENDIF
		ENDIF
	ENDIF							
	cQuery+= " SC5010.D_E_L_E_T_ <> '*' AND SC6010.D_E_L_E_T_ <> '*' "
	cQuery+= " GROUP BY C5_NUM, C5_EMISSAO, C5_CLIENTE,C5_VEND1, C5_TPFRETE,C5_SEGUROR, C5_FRETEOR,C5_FRETETO, " 
	cQuery+= " C5_FREORTO, C5_MODORIG, C5_FRETE, C5_SEGURO, C5_MODAL, C5_ALTFRET, C5_MOTFRET "	
	cQuery+= " ORDER BY C5_NUM "
    
    COND:= "1"
ELSE
	cQuery:= " SELECT F2_DOC, F2_EMISSAO, F2_CLIENTE,F2_VALBRUT, F2_VEND1, C5_TPFRETE, D2_PEDIDO,C5_SEGUROR, "
	cQuery+= " C5_FRETEOR, C5_FRETETO, C5_FREORTO, C5_MODORIG, C5_FRETE, C5_SEGURO, C5_MODAL, C5_ALTFRET, C5_MOTFRET "
	cQuery+= " FROM SF2010, SD2010, SC5010, SC6010 "
	cQuery+= " WHERE C5_NUM = D2_PEDIDO AND "
	cQuery+= " C6_NOTA = D2_DOC AND "
	cQuery+= " C6_NOTA = F2_DOC AND "
	cQuery+= " C5_NUM = C6_NUM AND F2_DOC >= '"+MV_PAR05+"' AND F2_DOC <= '"+MV_PAR06+"' AND "
	cQuery+= " F2_EMISSAO >= '"+DTOS(MV_PAR01)+"' AND F2_EMISSAO <= '"+DTOS(MV_PAR02)+"' AND "
	IF MV_PAR08 == 2
		cQuery+= " C5_MODAL = '1' AND "
	ELSE
		IF MV_PAR08 == 3
			cQuery+= " C5_MODAL = '2' AND "
		ELSE
			IF MV_PAR08 == 4
				cQuery+= " C5_MODAL = '3' AND  "
			ENDIF
		ENDIF
	ENDIF
	cQuery+= " SC5010.D_E_L_E_T_ <> '*' AND SC6010.D_E_L_E_T_ <> '*' AND "
	cQuery+= " SD2010.D_E_L_E_T_ <> '*' AND SF2010.D_E_L_E_T_ <> '*'"
	cQuery+= " GROUP BY F2_DOC, F2_EMISSAO, F2_CLIENTE,F2_VALBRUT, F2_VEND1, C5_TPFRETE, D2_PEDIDO, C5_SEGUROR, " 
	cQuery+= " C5_FRETEOR, C5_FRETETO, C5_FREORTO, C5_MODORIG, C5_FRETE, C5_SEGURO, C5_MODAL, C5_ALTFRET, C5_MOTFRET "
	cQuery+= " ORDER BY F2_DOC "

	COND:= "2"

ENDIF

cQuery := ChangeQuery(cQuery)
    	
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())


TRB1->(dbGoTop())

WHILE TRB1->(!EOF())
	IF  COND == "1"
   		CPED		:=	SUBSTR(ALLTRIM(TRB1->C5_NUM),1,7)
   		CNOTA   	:= 	SUBSTR(ALLTRIM(POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_NOTA")),1,6)
   		CSERIE  	:= 	SUBSTR(ALLTRIM(POSICIONE("SC6",1,XFILIAL("SC6")+TRB1->C5_NUM,"C6_SERIE")),1,3)
   		CFRETSEG	:=	ROUND(TRB1->C5_FRETE+TRB1->C5_SEGURO,2)
   		CFRETSEGOR	:=	ROUND(TRB1->C5_FRETEOR+TRB1->C5_SEGUROR,2)//TRB1->C5_FREORTO
   		CFRETEOR	:= 	TRB1->C5_FRETEOR
   		CFRETE  	:= 	TRB1->C5_FRETE   
   		CSEGURO 	:= 	TRB1->C5_SEGURO
   		CVEND		:=	SUBSTR(ALLTRIM(POSICIONE("SA3",1,XFILIAL("SA3")+TRB1->C5_VEND1,"A3_NOME")),1,13)//SUBSTR(TRB1->C5_VEND1+"-"+ALLTRIM(POSICIONE("SA3",1,XFILIAL("SA3")+TRB1->C5_VEND1,"A3_NOME")),1,20)
   		CTPFRETE	:=	IIF(TRB1->C5_TPFRETE == 'C', "CIF", "FOB")  
   		CUF			:=	SUBSTR(POSICIONE ("SA1",1, XFILIAL("SA1")+TRB1->C5_CLIENTE, "A1_EST"),1,4)
   		CMODAL  	:=	TRB1->C5_MODAL
   		CUSERALT	:=	SUBSTR(ALLTRIM(TRB1->C5_ALTFRET),1,20)
   		CMOTALT 	:=	SUBSTR(ALLTRIM(TRB1->C5_MOTFRET),1,30)
   		EMISSAO 	:=  SUBSTR(TRB1->C5_EMISSAO,7,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,5,2)+"/"+SUBSTR(TRB1->C5_EMISSAO,1,4)
        CCLIENTE	:=  SUBSTR(ALLTRIM(TRB1->C5_CLIENTE)+"-"+ALLTRIM(POSICIONE ("SA1",1, XFILIAL("SA1")+TRB1->C5_CLIENTE, "A1_NREDUZ")),1,20)
        VLR_TOT		:=	TRB1->VALOR_TOT 
        CTRANSP		:=	POSICIONE("SC5",1,XFILIAL("SC5")+TRB1->C5_NUM,"C5_TRANSP")
    	CCLI		:=	TRB1->C5_CLIENTE
    ELSE
   		CPED		:=	SUBSTR(ALLTRIM(TRB1->D2_PEDIDO),1,7)
   		CNOTA   	:= 	TRB1->F2_DOC
   		CSERIE  	:= 	SUBSTR(ALLTRIM(POSICIONE("SF2",1,XFILIAL("SF2")+TRB1->F2_DOC,"F2_SERIE")),1,3)
   		CFRETSEG	:=	ROUND(TRB1->C5_FRETE+TRB1->C5_SEGURO,2)
   		CFRETSEGOR	:=	ROUND(TRB1->C5_FRETEOR+TRB1->C5_SEGUROR,2)//TRB1->C5_FREORTO
   		CFRETEOR	:= 	TRB1->C5_FRETEOR
   		CFRETE  	:= 	TRB1->C5_FRETE   
   		CSEGURO 	:= 	TRB1->C5_SEGURO
   		CVEND		:=	SUBSTR(ALLTRIM(POSICIONE("SA3",1,XFILIAL("SA3")+TRB1->F2_VEND1,"A3_NOME")),1,13)//SUBSTR(TRB1->F2_VEND1+"-"+ALLTRIM(POSICIONE("SA3",1,XFILIAL("SA3")+TRB1->F2_VEND1,"A3_NOME")),1,20)
   		CTPFRETE	:=	IIF(TRB1->C5_TPFRETE == 'C', "CIF", "FOB")  
   		CUF			:=	SUBSTR(POSICIONE ("SA1",1, XFILIAL("SA1")+TRB1->F2_CLIENTE, "A1_EST"),1,4)
   		CMODAL  	:=	TRB1->C5_MODAL
   		CUSERALT	:=	SUBSTR(ALLTRIM(TRB1->C5_ALTFRET),1,20)
   		CMOTALT 	:=	SUBSTR(ALLTRIM(TRB1->C5_MOTFRET),1,30)
   		EMISSAO 	:=  SUBSTR(TRB1->F2_EMISSAO,7,2)+"/"+SUBSTR(TRB1->F2_EMISSAO,5,2)+"/"+SUBSTR(TRB1->F2_EMISSAO,1,4)
		CCLIENTE	:=  SUBSTR(ALLTRIM(TRB1->F2_CLIENTE)+"-"+ALLTRIM(POSICIONE ("SA1",1, XFILIAL("SA1")+TRB1->F2_CLIENTE, "A1_NREDUZ")),1,20)    	
	    VLR_TOT		:=	TRB1->F2_VALBRUT
        CTRANSP		:=	POSICIONE("SC5",1,XFILIAL("SC5")+TRB1->D2_PEDIDO,"C5_TRANSP")
		CCLI		:=	TRB1->F2_CLIENTE
	ENDIF
	
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

   If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
      LI:= 9
   Endif


		@ li, 02	Psay CPED 
        
        IF !EMPTY(CNOTA)
			@ li, 09	Psay CNOTA
		ENDIF
		
		IF !EMPTY(CSERIE)
			@ li, 20	Psay CSERIE
		ENDIF
		
		@ li, 27	Psay EMISSAO 
		@ li, 39	Psay CCLIENTE
		@ li, 64	Psay CUF
		@ li, 68	Psay CVEND
		@ li, 87	Psay VLR_TOT Picture "@E 9,999,999.99"
		
		IF !EMPTY(CFRETSEGOR)
			@ li, 99 	Psay CFRETSEGOR Picture "@E 999,999.99"
		ENDIF
		
		IF !EMPTY(TRB1->C5_MODORIG)		
			IF ALLTRIM(TRB1->C5_MODORIG) = '1'
				@ li, 112 	Psay "CARRO PROPR"
		    ELSE
		    	IF ALLTRIM(TRB1->C5_MODORIG) = '2'
		    		@ li, 112 Psay "SEDEX"
		    	ELSE
		    		@ li, 112 	Psay "TRANSPORT."
		    	ENDIF
		    ENDIF		
		ENDIF
		
		IF !EMPTY(CFRETSEG)
			@ li, 122 	Psay CFRETSEG Picture "@E 999,999.99"
		ENDIF		

		IF !EMPTY(CMODAL)		
			IF ALLTRIM(CMODAL) = '1'
				@ li, 144 	Psay "CARRO PROPR."
		    ELSE
		    	IF ALLTRIM(CMODAL) = '2'
		    		@ li, 144 Psay "SEDEX"
		    	ELSE
		    		@ li, 144 	Psay "TRANSPORT."
		    	ENDIF
		    ENDIF		
		ENDIF
		   
		@ li, 156 	Psay CTPFRETE
		
		IF !EMPTY(CTRANSP)
			@ li, 166 	Psay SUBSTR(ALLTRIM(POSICIONE("SA4",1,XFILIAL("SA4")+CTRANSP,"A4_NOME")),1,15)
		ENDIF
		
		IF !EMPTY(CUSERALT)
			@ li, 183 	Psay CUSERALT 
		ENDIF
		
		If ALLTRIM(POSICIONE ("SA1",1, XFILIAL("SA1")+CCLI, "A1_FRETE")) == '2'
			IF EMPTY(CMOTALT)
				@ li, 195 	Psay "Acordo Comerc. Nao Paga Frete"
            ELSE
				@ li, 195 	Psay CMOTALT
			Endif
		ELSE
			IF !EMPTY(CMOTALT)
				@ li, 195 	Psay CMOTALT
			ELSE
				IF CFRETSEG == CFRETSEGOR .AND. CFRETSEGOR <> 0 .AND. CFRETSEG <> 0
						@ li, 195 	Psay "Praticado o Valor Calculado"
				ENDIF		
			Endif
      	ENDIF
        
        li++       
  
  NLIN++
        
       TRB1->(DBSKIP())
EndDo


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

TRB1->(DBCLOSEAREA())

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VALIDPERG ³ Autor ³ RAIMUNDO PEREIRA      ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Pedido Venda De?","","","mv_ch3","C", 6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SC5"})
AADD(aRegs,{cPerg,"04","Pedido Venda Ate?","","","mv_ch4","C",6,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SC5"})
AADD(aRegs,{cPerg,"05","Nota Fiscal De ?","","","mv_ch5","C", 9,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SF2"})
AADD(aRegs,{cPerg,"06","Nota Fiscal Ate ?","","","mv_ch6","C",9,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","SF2"})
AADD(aRegs,{cPerg,"07","Tipo ?","","","mv_ch7","C",1,0,1,"C","","mv_par07","Por Pedido","","","","","Por Nota Fiscal","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Modal Praticado ?","","","mv_ch8","C",1,0,1,"C","","mv_par08","TODOS","","","","","Carro Proprio","","","","","Sedex","","","","","Transportadora","","","","","","","","",""})

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
                
