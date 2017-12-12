#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO4     บ Autor ณ AP6 IDE            บ Data ณ  04/12/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function LAYTEXLOG()

Local   cArqTRB	:= CriaTrab(,.F.)
PRIVATE cPerg	:= "TEXLOG"

cArq := "TEXLOG_"+DTOS(DDATABASE)+"-"+SUBSTR(TIME(),1,2)+"-"+SUBSTR(TIME(),4,2)+"-"+SUBSTR(TIME(),7,2)+"-"+ALLTRIM(Upper(cUsername))
cPath := "C:\RELATORIOS\"
cPath2:= "\SYSTEM\RELTRACK\"
nArq  := FCreate(cPath + cArq + ".CSV")


VALIDPERG(cPerg)

IF !pergunte(cPerg,.T.)
	RETURN .F.
ENDIF

cQuery:= ""

cQuery:= " SELECT F2_VOLUME1 VOLUME, F2_PLIQUI PESOLIQUI, F2_TPFRETE TPFRETE, D2_PEDIDO PEDIDO, A1_NOME NOMCLI, "
cQuery+= " A1_CGC CGCCLI, A1_INSCR INSCR, A1_END ENDERE, A1_BAIRRO BAIRRO, A1_MUN MUNICIPIO, A1_EST ESTADO, "
cQuery+= " A1_CEP CEP, A1_DDD DDD, A1_TEL TEL1, A1_FAX TEL2, A1_TELEX TEL3, F2_DOC NUMNF, F2_SERIE SERIE, "
cQuery+= " F2_EMISSAO EMISSAO,F2_VALBRUT VLRBRUTO, F2_VALMERC VLRMERC, F2_CHVNFE CHAVENFE, F2_HORA HORA "
cQuery+= " FROM SF2010, SD2010, SA1010 "
cQuery+= " WHERE F2_EMISSAO >='"+DTOS(MV_PAR01)+"' "
cQuery+= " AND F2_EMISSAO <='"+DTOS(MV_PAR02)+"' "
//cQuery+= " AND F2_XGERARQ = ' ' "

IF   !EMPTY(ALLTRIM(MV_PAR03))// ALTERADO CONFORME SOLICITAวรO DE EDMAR BRITO DIA 22/11/12 - NรO OBRIGATORIO O CODIGO DE TRANSPORTADORA- ALTERADO POR ERICH BUTTNER
	cQuery+= " AND F2_TRANSP = '"+ALLTRIM(MV_PAR03)+"' "
ENDIF

cQuery+= " AND F2_FILIAL = '"+XFILIAL("SF2")+"' "
cQuery+= " AND A1_FILIAL = '  ' "
cQuery+= " AND F2_CLIENTE = A1_COD "
cQuery+= " AND F2_LOJA = A1_LOJA "
cQuery+= " AND F2_FILIAL = D2_FILIAL "
cQuery+= " AND F2_DOC = D2_DOC "
cQuery+= " AND SF2010.D_E_L_E_T_ = ' ' "
cQuery+= " AND SD2010.D_E_L_E_T_ = ' ' "
cQuery+= " GROUP BY F2_VOLUME1 , F2_PLIQUI , F2_TPFRETE , D2_PEDIDO, A1_NOME ,A1_CGC, A1_INSCR, A1_END, A1_BAIRRO, "
cQuery+= " A1_MUN, A1_EST, A1_CEP, A1_DDD, A1_TEL, A1_FAX, A1_TELEX, F2_DOC, F2_SERIE, F2_EMISSAO, F2_VALBRUT, F2_VALMERC, "
cQuery+= " F2_CHVNFE, F2_HORA "
cQuery+= " ORDER BY F2_EMISSAO, F2_HORA "

cQuery := ChangeQuery(cQuery)

If Select("cArqTRB") > 0
	dbSelectArea("cArqTRB")
	dbCloseArea("cArqTRB")
Endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")
cArqTRB->(dbGoTop())

WHILE cArqTRB->(!EOF())
	
	cNumNf		:= SUBSTR(ALLTRIM(cArqTRB->NUMNF),1,9)
	cSerie		:= SUBSTR(ALLTRIM(cArqTRB->SERIE),1,3)
	cNomcli		:= SUBSTR(cArqTRB->NOMCLI,1,40)
	cEndent		:= STRTRAN(ALLTRIM(SUBSTR(cArqTRB->ENDERE,1,80)+" "+SUBSTR(ALLTRIM(cArqTRB->BAIRRO),1,40)),"	","")
	cCidade		:= SUBSTR(ALLTRIM(cArqTRB->MUNICIPIO),1,40)
	cEstado		:= SUBSTR(ALLTRIM(cArqTRB->ESTADO),1,2)
	cCep		:= SUBSTR(ALLTRIM(cArqTRB->CEP),1,8)
	nVlrBrut	:= cArqTRB->VLRBRUTO
	cVolume		:= cArqTRB->VOLUME
	cPeso		:= cArqTRB->PESOLIQUI
	cTipCarga	:= "EPP-Carga"    

	FWrite(nArq, cNumNf + ";" + cSerie+ ";" +cNomcli+";"+cEndent+";"+cCidade+";"+cEstado+";"+cCep+";";
	+STR(nVlrBrut)+";"+STR(cVolume)+";"+STR(cPeso)+";"+cTipCarga+";"+Chr(13) + Chr(10))

	cArqTRB->(dbSKIP())
	
ENDDO

FClose(nArq)


DbSelectArea("cArqTRB")
DbCloseArea()

ALERT("ARQUIVO SALVO EM C:\RELATORIOS\"+cArq)

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณVALIDPERG ณ Autor ณ RAIMUNDO PEREIRA      ณ Data ณ 01/08/02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ Verifica as perguntas incluกndo-as caso no existam        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especifico para Clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Transp.","","","mv_ch3","C",6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SA4"})


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
