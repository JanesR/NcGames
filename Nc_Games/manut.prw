#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#include "colors.ch"
#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณMANUT     บAutor  ณRogerio-Supertech   บ Data ณ  05/24/10    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.   ณPrograma para dar manutencao ou visualizar bordero da operacaoบฑฑ
ฑฑบ        ณ                                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Manut

PUBLIC nValor	:=0
PUBLIC nCalculo :=0
PUBLIC nCont	:=0

dbSelectArea("SA6")
dbSetOrder(1)
dbSeek(xFilial()+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)

nAdValorem		:=SA6->A6_ADVALOR       //ATUALIZAR TITULOS
nDesagio		:=SA6->A6_DESAGIO
nRegTitulo		:=SA6->A6_REGTIT
nEmissTed		:=SA6->A6_EMISTED
nSci			:=SA6->A6_SCI
nTac			:=SA6->A6_TAC
nPrazoMedio     :=0

WHILE ! EOF().and.  cNumbor==SE1->E1_NUMBOR
	
	nValor			:= 	SE1->E1_SALDO+nValor // SOMA DO BORDERO
	nCalculo		:= 	SE1->E1_CALCULO+nCalculo
	nPrazoMedio     :=	nCalculo/nValor
	nCont			:=  nCont+1
	nIOF			:=  SE1->E1_PERCIOF
	nIOFAdic		:=  SE1->E1_IOFADIC
	
	
	dbSelectArea("SE1")
	
	DbSkip()
END DO

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ<0ฟ
//ณCalculos da factoring               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ<0ู
*/

nValDesagio 		:=(nValor*nDesagio/30)*nPrazoMedio/100
nValRegTitulo       :=nCont*nRegTitulo
nValSci				:=nSci
nValAdValorem		:=(nValor*nAdValorem/30)*nPrazoMedio/100
nValRegTit			:=nCont*nRegTitulo
nValTarEmissTed     :=nEmissTed
nValTac				:=nTac
nValLiq				:=nValor-nValTac-nValTarEmissTed-nValRegTit-nValAdValorem-nValSci-nValDesagio
nValIOF				:=nValor*nIOF/100
nValIOFAdic			:=nValor*nIOFAdic/100

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ<0ฟ
//ณMonta tela para escolha dos dadosณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ<0ู
*/

DEFINE MSDIALOG oDlg TITLE "TELA DE SIMULACAO FINANCEIRA" FROM C(180),C(694) TO C(516),C(1102) PIXEL

// Cria as Groups do Sistema
@ C(010),C(003) TO C(050),C(200) LABEL "" PIXEL OF oDlg
@ C(054),C(003) TO C(135),C(200) LABEL "" PIXEL OF oDlg

// Cria Componentes Padroes do Sistema

@ 003,135 		Say "BORDERO NUMERO" 	Size 059,009  		COLOR CLR_BLACK PIXEL OF oDlg
@ C(004),C(176) Say cNumBor 			Size C(045),C(011) 	COLOR CLR_BLACK PIXEL OF oDlg

@ C(014),C(004) Say "VALOR BRUTO" 		Size C(056),C(012) 	COLOR CLR_BLACK PIXEL OF oDlg
@ C(014),C(060) Say nValor 						   		   	COLOR CLR_BLACK Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(024),C(004) Say "CALCULO"     		Size C(039),C(012) 	COLOR CLR_BLACK  PIXEL OF oDlg
@ C(024),C(060) Say nCalculo    		Size C(060),C(009) 	COLOR CLR_BLACK 	Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(034),C(004) Say "QTD TITULOS"     	Size C(039),C(012) 	COLOR CLR_BLACK  PIXEL OF oDlg
@ C(034),C(060) Say nCont    			Size C(060),C(009) 	COLOR CLR_BLACK Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(044),C(004) Say "PRAZO MEDIO" 		Size C(052),C(011) 	COLOR CLR_BLACK PIXEL OF oDlg
@ C(044),C(060) Say nPrazoMedio     	Size C(060),C(009) 	COLOR CLR_BLACK Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(054),C(009) Say "DESAGIO %"     	Size C(044),C(009) 	COLOR CLR_BLACK PIXEL OF oDlg
@ C(054),C(060) Say nDesagio    		Picture "@E 999,999,999.99" PIXEL OF oDlg
@ C(054),C(135) Say nValDesagio    		Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(064),C(009) Say "AD VALOREM %"  	Size C(038),C(009) 	COLOR CLR_BLACK PIXEL OF oDlg
@ C(064),C(060) Say nAdValorem   		Picture "@E 999,999,999.99" PIXEL OF oDlg
@ C(064),C(135) Say nValAdValorem  		Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(074),C(009) Say "TAR REG TITULO"	Size C(048),C(008) 	COLOR CLR_BLACK PIXEL OF oDlg
@ C(074),C(060) Say nRegTitulo    		Picture "@E 999,999,999.99" PIXEL OF oDlg
@ C(074),C(135) Say nValRegTitulo    	Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(084),C(009) Say "TAR EMIS TED" 		Size C(048),C(008) 	COLOR CLR_BLACK PIXEL OF oDlg
@ C(084),C(060) Say nValTarEmissTed 	Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(094),C(009) Say "SCI" 				PIXEL OF oDlg
@ C(094),C(060) Say nSci 	    		Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(104),C(009) Say "TAC" 				PIXEL OF oDlg
@ C(104),C(060) Say nTac	    		Picture "@E 999,999,999.99" PIXEL OF oDlg

@ C(114),C(009) Say "IOF %"				PIXEL OF oDlg
@ C(114),C(060) Say nIOF	    		Picture "@E 999,999.99999" PIXEL OF oDlg
@ C(114),C(135) Say nValIOF    			Picture "@E 999,999.99999" PIXEL OF oDlg  

@ C(124),C(009) Say "IOF ADIC %"		PIXEL OF oDlg
@ C(124),C(060) Say nIOFAdic    		Picture "@E 999,999.99999" PIXEL OF oDlg
@ C(124),C(135) Say nValIOFAdic    		Picture "@E 999,999.99999" PIXEL OF oDlg  

@ C(134),C(009) Say "VALOR LIQUIDO" 	PIXEL OF oDlg
@ C(134),C(060) Say nValLiq	    		Picture "@E 999,999,999.99" PIXEL OF oDlg

@ 182,107 BMPBUTTON TYPE 01 ACTION U_EXPXLS()
@ 182,176 BmpButton Type 02 Action Close(oDlg)

ACTIVATE MSDIALOG oDlg CENTERED


/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPrograma para exportar para Excelณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/

Function u_EXPXLS()

IF MSGYESNO("Exporta para Excel ?")
	cQuery  := ""
	if SELECT ("TRB1") > 0
		dbSelectArea("TRB1")
		dbCloseArea("TRB1")
	endif
	
	aDbStru := {}
	
	// Estrutura do Arquivo que irแ para o Excel
	AADD(aDbStru,{"BANCO","C",20,0})
	AADD(aDbStru,{"DATABOR","D",8,0})
	AADD(aDbStru,{"NUMERO","C",6,0})
	AADD(aDbStru,{"VL_BRUTO","N",14,2})
	AADD(aDbStru,{"PRZ_MED","N",3,0})
	AADD(aDbStru,{"TX_FATOR","N",14,2})
	AADD(aDbStru,{"TX_AD_VALR","N",14,2})
	AADD(aDbStru,{"VL_FATOR","N",14,2})
	AADD(aDbStru,{"VL_ADVALOR","N",14,2})
	AADD(aDbStru,{"QTDE	","N",4,0})
	AADD(aDbStru,{"TAR_TIT	","N",14,2})
	AADD(aDbStru,{"SUBTOTAL","N",14,2})
	AADD(aDbStru,{"TAC","N",14,2})
	AADD(aDbStru,{"TAR_TED","N",14,2})
	AADD(aDbStru,{"TAR_SCI","N",14,2})
	AADD(aDbStru,{"VL_IOF","N",14,2})
	AADD(aDbStru,{"VL_LIQUIDO","N",14,2})
	
	//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
	CNOMEDBF := "BORDERO_"+cNumBor
	DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
	DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)
	
	//QUERY COM A SELECAO E OS CALCULOS PARA EXCEL
	
	cQuery  :=" SELECT A6_NOME BANCO,E1_DATABOR DATABOR, E1_NUMBOR NUMERO,SUM(E1_SALDO) VL_BRUTO,SUM(E1_CALCULO)/SUM(E1_SALDO) PRZ_MED,"
	cQuery  +="   E1_DESAGIO TX_FATOR,"
	cQuery  +="   E1_ADVALOR TX_AD_VALR,"
	cQuery  +="   SUM(E1_SALDO)*(E1_DESAGIO/30)*SUM(E1_CALCULO)/SUM(E1_SALDO)/100  VL_FATOR,"
	cQuery  +="   SUM(E1_SALDO)*(E1_ADVALOR/30)*SUM(E1_CALCULO)/SUM(E1_SALDO)/100  VL_ADVALOR,"
	cQuery  +="   COUNT(E1_NUMBOR) QTDE,"
	cQuery  +="    E1_REGTIT TAR_TIT,"
	cQuery  +="    COUNT(E1_NUMBOR)*E1_REGTIT SUBTOTAL,"
	cQuery  +="    A6_TAC TAC,"
	cQuery  +="    A6_EMISTED TAR_TED,"
	cQuery  +="    A6_SCI TAR_SCI,"
    cQuery  +="    SUM(E1_SALDO)*(SUM(E1_PERCIOF)) VL_IOF, "
	cQuery  +="    SUM(E1_SALDO)-(SUM(E1_SALDO*E1_DESAGIO/100))-(E1_REGTIT)-COUNT(E1_NUMBOR)*E1_REGTIT-A6_EMISTED-A6_SCI VL_LIQUIDO"
	cQuery  +="    FROM SE1010, SA6010 "
	cQuery  +="    WHERE E1_NUMBOR = '"+cNumBor+"' "
	cQuery  +="    AND A6_COD=E1_PORTADO "
	cQuery  +="    AND A6_AGENCIA=E1_AGEDEP"
	cQuery  +="    AND A6_NUMCON=E1_CONTA"
	cQuery  +="    GROUP BY A6_NOME,E1_DATABOR, E1_NUMBOR,E1_REGTIT,E1_EMISTED,E1_SCI ,E1_DESAGIO,E1_ADVALOR,A6_TAC,A6_EMISTED,A6_SCI"
	cQuery 	:= ChangeQuery(cQuery)
	
	
	MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)},"Aguarde...") //"Selecionando Registros..."
	
	dbSelectArea("TRB1")
	While !EOF()
		XLS->(RECLOCK("XLS",.T.))
		
		XLS->BANCO		:=	TRB1->BANCO
		XLS->DATABOR	:=	STOD(TRB1->DATABOR)
		XLS->NUMERO		:=	TRB1->NUMERO
		XLS->VL_BRUTO	:=	TRB1->VL_BRUTO
		XLS->PRZ_MED	:=	TRB1->PRZ_MED
		XLS->TX_FATOR	:=	TRB1->TX_FATOR
		XLS->TX_AD_VALR	:=	TRB1->TX_AD_VALR
		XLS->VL_FATOR	:=	TRB1->VL_FATOR
		XLS->VL_ADVALOR	:=	TRB1->VL_ADVALOR
		XLS->QTDE		:=	TRB1->QTDE
		XLS->TAR_TIT	:=	TRB1->TAR_TIT
		XLS->SUBTOTAL	:=	TRB1->SUBTOTAL
		XLS->TAC		:=	TRB1->TAC
		XLS->TAR_TED	:=	TRB1->TAR_TED
		XLS->TAR_SCI	:=	TRB1->TAR_SCI
		XLS->VL_IOF		:=	TRB1->VL_IOF
		XLS->VL_LIQUIDO	:=	TRB1->VL_LIQUIDO
		
		//FOR I:=1 TO TRB1->(FCOUNT())
		//	IF (nPos:=XLS->(FIELDPOS(TRB1->(FIELDNAME(I))))) # 0
		//	XLS->(FIELDPUT(nPos,TRB1->(FIELDGET(I))))
		//	ENDIF
		//NEXT
		TRB1->(DBSKIP())
	EndDo
	
	XLS->(DBGOTOP())
	lExecOk := .F.
	lExecOk :=	CpyS2T( "\SYSTEM\" + CNOMEDBF+".dbf" , "C:\RELATORIOS\" , .T. )
	if !lExecOK
		lExecOk := .F.
		lExecOK := CpyS2T( "\SYSTEM\" + CNOMEDBF +".dbf" , "C:\" , .T. )
		if !lExecOK
			lExecOk := .F.
			lExecOk := CpyS2T( "\SYSTEM\" + CNOMEDBF +".dbf" , "c:\windows\", .T. )  //  nao funciona, diz que diretorio Z: nao existe, ele existe e eh publico
		endif
	endif
	If ! ApOleClient( 'MsExcel' )
		MsgStop( 'MsExcel nao instalado' )
		Return
	EndIf
	
	// Abre uma planilha EXCEL
	
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "c:\RELATORIOS\" + CNOMEDBF+".DBF" ) 
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
	Return
	
ENDIF

Return()