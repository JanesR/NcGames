#INCLUDE "RWMAKE.CH"

/*
Programa: MT450FIM - Ponto de entrada para gravar informações após a liberação de crédito
Data    : 14/05/2009
Paulo Palhares
*/

// Ponto de Entrada após a liberação de crédito

User Function MTA450I
//PARAMIXB {nOpca,dDataBase}
Local aArea		:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaSC6	:= SC6->(GetArea())
Local aAreaSC9	:= SC9->(GetArea())
Local cPedido := SC9->C9_PEDIDO

dbSelectArea("SA1")
//dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA
RECLOCK("SA1",.F.)  
SA1->A1_YLEGEND := ""  
//Alert("As informações do cliente " + SA1->A1_NOME + SA1->A1_LOJA + SA1->A1_COD + " foram alteradas para " + Legenda)
SA1->(MSUNLOCK() )
//////////////////////////////////////////////////////////////////////////////////////////////////


TCSQLEXEC("UPDATE SC9010 SET C9_ULIBCRD='"+alltrim(cUsername)+"', C9_DTLICRD=to_char(sysdate,'yyyymmdd') where c9_filial='"+xFilial("SC9")+"' and c9_pedido='"+alltrim(cPedido)+"'")

TCSQLEXEC("COMMIT")

TCSQLEXEC("UPDATE SC5010 SET C5_TRAK='LIBFIN' where c5_filial='"+xFilial("SC5")+"' and c5_num='"+alltrim(cPedido)+"'")

TCSQLEXEC("COMMIT")

U_Z7Status(xFilial("SZ7"),cPedido,"000006","LIBERADO PELO FINANCEIRO",SC9->C9_CLIENTE)

dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

aVaiWMS	:= {}
WHILE SC6->(!EOF()) .AND. SC5->C5_NUM == SC6->C6_NUM
	//Verificação se vai para o WMS
	cAtuEst	:= getadvfval("SF4","F4_ESTOQUE",xFilial("SF4")+SC6->C6_TES,1,"")
	cBlqEst	:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLEST")
	If !(SC6->C6_LOCAL $ GETMV("MV_ARMWMAS")) .or. cAtuEst <> "S"
		//		AADD(aNaoWMS,{SC6->C6_ITEM,SC6->C6_LOCAL,cAtuEst})
	Else
		If Empty(cBlqEst)
			AADD(aVaiWMS,{SC6->C6_ITEM,SC6->C6_LOCAL,cAtuEst})
		EndIf
	EndIf
	
	SC6->(DBSKIP())
ENDDO

dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

IF SC5->(DBSEEK(XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM))
	RECLOCK("SC5")
	SC5->C5_CODBL:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM,"C9_BLCRED")
	SC5->(MSUNLOCK())
	If (PARAMIXB[1]==1 .or. PARAMIXB[1]==4) .And. Empty(POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM,"C9_BLCRED"))
 		U_NCGA001( SC5->C5_NUM ,SM0->M0_CODFIL )
   	EndIf	
Endif

dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

CODARM := 0
CPED := SC5->C5_NUM

RestArea(aAreaSC9)
RestArea(aAreaSC6)
RestArea(aAreaSC5)
RestArea(aAreaSA1)
RestArea(aArea)

Return
