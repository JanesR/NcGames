#Include "Protheus11.ch"
#Include "RwMake.ch"
#include "tbiconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LERPO     ºAutor  ³Microsiga           º Data ³  03/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VerMargPV()
Local cTexto1 := "Gerar Dados Pedido de Venda Status 02 "
Local cTexto2  := "Gerando Arquivo Excel..."
Local aIteExcel  := {}
Local aCabExcel  := {}

MsgRun(cTexto1,,{|| FMonta(@aIteExcel,@aCabExcel) } )
MsgRun(cTexto2,,{|| DlgToExcel({{"GETDADOS","",aCabExcel,aIteExcel}}) })

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LERPO     ºAutor  ³Microsiga           º Data ³  03/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static function FMonta(aIteExcel,aCabExcel)
Local aAreaAtu:=GetArea()
Local cQuery:=""
Local cQryAlias:=GetNextAlias()


cQuery:=" Select SC5.R_E_C_N_O_ RecSC5 "
cQuery+=" From "+RetSqlName("SC5")+" SC5"
cQuery+=" Where SC5.C5_FILIAL='"+xFilial("SC5")+"'"
cQuery+=" And SC5.C5_YSTATUS='02'"   
cQuery+=" And SC5.C5_EMISSAO>'20130401'"
cQuery+=" And SC5.D_E_L_E_T_=' '"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQryAlias, .F., .F.)


AADD(aCabExcel, {AvSx3("C5_NUM"		,5)	, "C5_NUM"   	,AvSx3("C5_NUM"		,6)	,AvSx3("C5_NUM"		,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_EMISSAO"	,5)	,"C5_EMISSAO"	,AvSx3("C5_EMISSAO"	,6)	,AvSx3("C5_EMISSAO"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_CLIENTE"	,5)	,"C5_CLIENTE"	,AvSx3("C5_CLIENTE"	,6)	,AvSx3("C5_CLIENTE"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_LOJACLI"	,5)	,"C5_LOJACLI"	,AvSx3("C5_LOJACLI"	,6)	,AvSx3("C5_LOJACLI"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_NOMCLI"	,5)	,"C5_NOMCLI"	,AvSx3("C5_NOMCLI"	,6)	,AvSx3("C5_NOMCLI"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_YCANAL"	,5)	,"C5_YCANAL"	,AvSx3("C5_YCANAL"	,6) ,AvSx3("C5_YCANAL"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_YDCANAL"	,5)	,"C5_YDCANAL"	,AvSx3("C5_YDCANAL"	,6) ,AvSx3("C5_YDCANAL"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_YTOTLIQ"	,5)	,"C5_YTOTLIQ"	,AvSx3("C5_YTOTLIQ"	,6)	,AvSx3("C5_YTOTLIQ"	,3),AvSx3("C5_YTOTLIQ"	,4),"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("C5_YPERLIQ"	,5)	,"C5_YPERLIQ"	,AvSx3("C5_YPERLIQ"	,6)	,AvSx3("C5_YPERLIQ"	,3),AvSx3("C5_YPERLIQ"	,4),"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("P09_NOME"	,5) ,"P09_NOME"		,AvSx3("P09_NOME"	,6)	,AvSx3("P09_NOME"	,3),0,"AllwaysTrue()","û","N","" })
AADD(aCabExcel, {AvSx3("P09_RENFIN"	,5)	,"P09_RENFIN"	,AvSx3("P09_RENFIN"	,6)	,AvSx3("P09_RENFIN"	,3),0,"AllwaysTrue()","û","N","" })


AADD(aCabExcel, {"",""   ,"@!",10,0,"AllwaysTrue()","û","N","" })


Do While (cQryAlias)->(!Eof())    
	SC5->(DbGoTo( (cQryAlias)->RecSC5 ) )
	U_QRYALC104("_PB9NEW",SC5->C5_YPERLIQ,"2",SC5->C5_YCANAL)	
	SC5->( AADD(aIteExcel, {C5_NUM,DTOC(C5_EMISSAO),C5_CLIENTE,C5_LOJACLI,C5_NOMCLI,C5_YCANAL,C5_YDCANAL,C5_YTOTLIQ,C5_YPERLIQ,_PB9NEW->P09_NOME,_PB9NEW->P09_RENFIN,""}))	
	_PB9NEW->(DbCloseArea())
	(cQryAlias)->(DbSkip())		
EndDo                      
(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)

Return Nil