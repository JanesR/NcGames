#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#include "colors.ch"
#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณEXPSFT     บAutor  ณRogerio-Supertech   บ Data ณ  05/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.   ณPrograma para gerar planilha em excel da tabela SFT com 	  นฑฑ
ฑฑบcolunas customizadas													  บฑฑ
ฑฑบ        ณ                                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EXPSFT

cQuery  := " "
aDbStru := {}
CNOMEDBF := "TABFISC"
cPerg:= "EXPSFT"


AjustaSx1()

Pergunte(cPerg,.T.,"Defina os parametros necessarios")


// Estrutura do Arquivo que irแ para o Excel
AADD(aDbStru,{"FILIAL","C",02,0})
AADD(aDbStru,{"DT_ENTRADA","D",08,0})
AADD(aDbStru,{"DT_EMISSAO","D",08,0})
AADD(aDbStru,{"DOC_FISCAL","C",09,0})
AADD(aDbStru,{"ESTADO_REF","C",02,0})
AADD(aDbStru,{"COD_FISCAL","C",05,0})
AADD(aDbStru,{"ALIQ_ICMS","N",05,2})
AADD(aDbStru,{"VLR_TOT","N",14,2})
AADD(aDbStru,{"BASE_ICMS","N",14,2})
AADD(aDbStru,{"VAL_ICMS","N",14,2})
AADD(aDbStru,{"VL_IPI","N",14,2})
AADD(aDbStru,{"VL_BS_RET","N",14,2})
AADD(aDbStru,{"ICM_RET","N",14,2})
AADD(aDbStru,{"PRODUTO","C",15,0})
AADD(aDbStru,{"DESCRICAO","C",30,0})
AADD(aDbStru,{"COD_NCM","C",10,0})
AADD(aDbStru,{"QTD","N",16,2})
AADD(aDbStru,{"PRC_UNIT","N",16,2})
AADD(aDbStru,{"IVA","N",16,2})
AADD(aDbStru,{"MIDIA","N",16,2})
AADD(aDbStru,{"VL_MD","N",16,2})
AADD(aDbStru,{"VL_SW","N",16,2})
AADD(aDbStru,{"ICM_MD","N",16,2})
AADD(aDbStru,{"ICM_SW","N",16,2})
AADD(aDbStru,{"FRET_SEG","N",16,2})
AADD(aDbStru,{"BST_FR_SEG","N",16,2})
AADD(aDbStru,{"ICM_FR_SEG","N",16,2})
AADD(aDbStru,{"ST_FR_SEG","N",16,2})
AADD(aDbStru,{"BSE_ST_MD","N",16,2})
AADD(aDbStru,{"BSE_ST_SW","N",16,2})
AADD(aDbStru,{"ICM_ST_MD","N",16,2})
AADD(aDbStru,{"ALIQ_SOL","N",16,2})
AADD(aDbStru,{"ICM_ST_SW","N",16,2})


DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

cQuery  :="SELECT FT_FILIAL FILIAL,FT_ENTRADA DT_ENTRADA, FT_EMISSAO DT_EMISSAO, FT_NFISCAL DOC_FISCAL,FT_ESTADO ESTADO_REF, FT_CFOP COD_FISCAL,"
cQuery  +=" FT_ALIQICM ALIQ_ICMS, FT_TOTAL VLR_TOT, FT_BASEICM BASE_ICMS, FT_VALICM VAL_ICMS,FT_VALIPI VL_IPI, FT_BASERET VL_BS_RET,"
cQuery  +=" FT_ICMSRET ICM_RET, FT_PRODUTO PRODUTO, B1_DESC DESCRICAO, FT_POSIPI COD_NCM,FT_QUANT QTD, FT_PRCUNIT PRC_UNIT,FT_MARGEM IVA,"
cQuery  +=" CASE WHEN FT_PRCUNIT > 9.60 then 9.60"
cQuery  +=" ELSE FT_PRCUNIT/2"
cQuery  +=" END MIDIA, FT_ALIQSOL ALIQ_SOL"
cQuery  +=" FROM SFT010 SFT, SB1010 SB1"
cQuery  +=" WHERE SFT.FT_PRODUTO = SB1.B1_COD"
cQuery  +=" AND SFT.FT_ENTRADA>='"+dtos(MV_PAR01)+"' "
cQuery  +=" AND SFT.FT_ENTRADA<='"+dtos(MV_PAR02)+"' "
cQuery  +=" AND SFT.D_E_L_E_T_=' '"
cQuery  +=" AND SFT.FT_DTCANC=' '"
cQuery  +=" ORDER BY SFT.FT_ENTRADA, SFT.FT_EMISSAO, SFT.FT_NFISCAL"

cQuery 	:= ChangeQuery(cQuery)

MsAguarde({|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB1",.T.,.T.)},"Aguarde, selecionando registros...")

//LjMsgRun("Gerando Planilha Excel de...",, 	{|| RunCont() 		})

LjMsgRun("Aguarde, Gerando Planilha Excel " +  "EXPSFT"  + " - De: " + DTOC(MV_PAR01) + " Ate: " + DTOC(MV_PAR02),, {|| RunCont() })


Return

Static Function RunCont()
dbSelectArea("TRB1")

While !EOF()
	XLS->(RECLOCK("XLS",.T.))
	
	XLS->FILIAL		 	:=	TRB1->FILIAL
	XLS->DT_ENTRADA		:=	STOD(TRB1->DT_ENTRADA)
	XLS->DT_EMISSAO		:=	STOD(TRB1->DT_EMISSAO)
	XLS->DOC_FISCAL		:=	TRB1->DOC_FISCAL
	XLS->ESTADO_REF		:=	TRB1->ESTADO_REF
	XLS->COD_FISCAL		:=	TRB1->COD_FISCAL
	XLS->ALIQ_ICMS		:=	TRB1->ALIQ_ICMS
	XLS->VLR_TOT		:=	TRB1->VLR_TOT
	XLS->BASE_ICMS		:=	TRB1->BASE_ICMS
	XLS->VAL_ICMS		:=	TRB1->VAL_ICMS
	XLS->VL_IPI			:=	TRB1->VL_IPI
	XLS->VL_BS_RET		:=	TRB1->VL_BS_RET
	XLS->ICM_RET		:=	TRB1->ICM_RET
	XLS->PRODUTO		:=	TRB1->PRODUTO
	XLS->DESCRICAO		:=	TRB1->DESCRICAO
	XLS->COD_NCM		:=	TRB1->COD_NCM
	XLS->QTD			:=	TRB1->QTD
	XLS->PRC_UNIT		:=	TRB1->PRC_UNIT
	XLS->IVA			:=	TRB1->IVA
	XLS->MIDIA			:=	TRB1->MIDIA
	XLS->VL_MD  		:=	TRB1->(MIDIA*QTD)
	XLS->VL_SW			:=	TRB1->(VLR_TOT-MIDIA*QTD)
	XLS->ICM_MD			:=	TRB1->((MIDIA*QTD)*ALIQ_ICMS/100)
	XLS->ICM_SW			:=	TRB1->((VLR_TOT-(MIDIA*QTD))*ALIQ_ICMS/100)
	XLS->FRET_SEG		:=	IF(TRB1->(BASE_ICMS-VLR_TOT)<0,0,TRB1->(BASE_ICMS-VLR_TOT))
	XLS->BST_FR_SEG		:=	TRB1->((BASE_ICMS-VLR_TOT)*IVA/100)
	XLS->ICM_FR_SEG		:=	TRB1->((BASE_ICMS-VLR_TOT)*ALIQ_ICMS/100)
	XLS->ST_FR_SEG		:=	IF(TRB1->((BASE_ICMS-VLR_TOT)*IVA/100)-(ALIQ_ICMS)-TRB1->((BASE_ICMS-VLR_TOT)*ALIQ_ICMS/100)<0,0,;
	 						   TRB1->((BASE_ICMS-VLR_TOT)*IVA/100)-(ALIQ_ICMS)-TRB1->((BASE_ICMS-VLR_TOT)*ALIQ_ICMS/100))
	XLS->BSE_ST_MD		:=	IF(TRB1->IVA=0,0,TRB1->((IVA/100)+1)*(MIDIA*QTD))                      //IF(TRB1->IVA=0,0,TRB1->(((MIDIA*QTD)*IVA)/100))
	XLS->BSE_ST_SW		:=	IF(TRB1->IVA=0,0,TRB1->(((IVA/100)+1)*(VLR_TOT-(MIDIA*QTD))))    //TRB1->((VLR_TOT-MIDIA)*IVA/100)
	XLS->ICM_ST_MD		:=	IF(TRB1->IVA=0,0,TRB1->(((IVA/100)+1)*(MIDIA*QTD))*ALIQ_SOL/100)-((MIDIA*QTD)*ALIQ_ICMS/100)//IF(TRB1->IVA=0,0,TRB1->((MIDIA*QTD)*IVA/100*ALIQ_ICMS-(MIDIA*QTD)*ALIQ_ICMS/100))
	XLS->ALIQ_SOL		:=	TRB1->ALIQ_SOL                                   
	XLS->ICM_ST_SW		:=  TRB1->(((IVA/100)+1)*(VLR_TOT-(MIDIA*QTD))*(ALIQ_SOL/100)-(VLR_TOT-(MIDIA*QTD))*(ALIQ_ICMS/100))  //BASE ST SOFTWARE X ALอQUOTA ICMS - ICMS SOFTWARE
	
	TRB1->(DBSKIP())
EndDo

XLS->(DBGOTOP())
lExecOk := .F.
lExecOk :=	CpyS2T( "\SYSTEM\" + CNOMEDBF+".dbf" , "C:\RELATORIOS\" , .T. )
If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( "C:\RELATORIOS\"+CNOMEDBF+".DBF" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)
XLS->(DBCLOSEAREA())

APMSGINFO("Tabela gerada com sucesso")

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ AjustaSX1 ณ Autor ณ Rogerio STCH         ณ Data ณ05.05.2011ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Ajusta as Perguntas do SX1                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ AjustaSX1()                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ NC GAMES                                                   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function AjustaSx1()
Local aArea := GetArea()

//+--------------------------------------------------------------+
//ฆ Variaveis utilizadas para parametros                         ฆ
//ฆ mv_par01             // Data de:            		         ฆ
//ฆ mv_par02             // Data Ate:			                 ฆ
//+--------------------------------------------------------------+
PutSx1(cPerg,"01","Data de:","","","mv_ch1","D",8,0,0,"G","","","","",;
"MV_PAR01","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Data Ate:","","","mv_ch2","D",8,0,0,"G","","","","",;
"MV_PAR02","","","","","","","","","","","","","","","","")
RestArea(aArea)

Return(.T.)
