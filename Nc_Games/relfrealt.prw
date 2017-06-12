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
User Function RELFREALT()

PRIVATE cPerg	:= "RELFRET"

cArq  := CriaTrab(Nil, .F.)
cPath := "C:\RELATORIOS\" 
nArq  := FCreate(cPath + cArq + ".CSV")
cArqTRB	:= CriaTrab(,.F.)
cArqTRB1:= CriaTrab(,.F.)

VALIDPERG(cPerg)

IF !pergunte(cPerg,.T.)
	RETURN .F.
ENDIF


FWrite(nArq, "EMISSAO;NUMERO_PEDIDO;CLIENTE;LOJA;NOME_CLIENTE;VALOR_PEDIDO;FRETE_CALCULADO;FRETE_ALTERADO;MODAL_DEFINIDO;MODAL_ALTERADO;USUARIO;MOTIVO;NOTA_FISCAL;VALOR_FRETE_NF;TRANSP_NOTA_FISCAL;STATUS" + Chr(13) + Chr(10))

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT C5_EMISSAO EMISSAO,C5_NUM NUMPED, C5_CLIENTE CODCLI, C5_LOJACLI LOJACLI,C5_NOMCLI NOMECLI, SUM(C6_VALOR) VLRPED, C5_FRETEOR FRETECALC, "
cQuery+= " C5_FRETE FRETEALT, C5_XTRANOR TRANSPDEF, C5_TRANSP TRANSALT, C5_ALTFRET USUARALT, C5_MOTFRET MOTIVOALT, "
cQuery+= " D2_DOC NUMNF, F2_FRETE VLRNF, F2_TRANSP TRANSPNF, C5_MODAL MODAL "
cQuery+= " FROM SA1010, SD2010, SF2010, SC5010, SC6010 "
cQuery+= " WHERE A1_FILIAL = ' ' "
cQuery+= " AND A1_COD = C5_CLIENTE "
cQuery+= " AND A1_LOJA = C5_LOJACLI "
cQuery+= " AND C5_FILIAL = '"+XFILIAL("SC5")+"' "
cQuery+= " AND C5_NUM = D2_PEDIDO "
cQuery+= " AND C6_FILIAL = '"+XFILIAL("SC6")+"' "
cQuery+= " AND C6_NUM = C5_NUM "
cQuery+= " AND D2_FILIAL = '"+XFILIAL("SD2")+"' "
cQuery+= " AND F2_DOC = D2_DOC "
cQuery+= " AND F2_FILIAL = '"+XFILIAL("SF2")+"' "
cQuery+= " AND C5_MOTFRET <> ' ' "
cQuery+= " AND C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' "
cQuery+= " AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"' "
cQuery+= " AND SA1010.D_E_L_E_T_ = ' ' "
cQuery+= " AND SF2010.D_E_L_E_T_ = ' ' "
cQuery+= " AND SD2010.D_E_L_E_T_ = ' ' "
cQuery+= " AND SC5010.D_E_L_E_T_ = ' ' "
cQuery+= " AND SC6010.D_E_L_E_T_ = ' ' "
cQuery+= " GROUP BY C5_EMISSAO, C5_NUM, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, C5_FRETEOR,C5_FRETE, C5_XTRANOR, C5_TRANSP, C5_ALTFRET, C5_MOTFRET, "
cQuery+= " D2_DOC, F2_FRETE, F2_TRANSP, C5_MODAL"

If Select("cArqTRB") > 0
	dbSelectArea("cArqTRB")
	dbCloseArea("cArqTRB")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqTRB",.T.,.T.)

dbSelectArea("cArqTRB")
cArqTRB->(dbGoTop())

WHILE cArqTRB->(!EOF())
	
    cEmiss		:= SUBSTR(cArqTRB->EMISSAO,7,2)+"/"+SUBSTR(cArqTRB->EMISSAO,5,2)+"/"+SUBSTR(cArqTRB->EMISSAO,1,4)	
	cNumped		:= cArqTRB->NUMPED
	cCodcli		:= cArqTRB->CODCLI
	cLojacli	:= cArqTRB->LOJACLI
	cNomCli		:= cArqTRB->NOMECLI
	nVlrped		:= cArqTRB->VLRPED
	nVlrfrcalc	:= cArqTRB->FRETECALC
	nVlrfralt	:= cArqTRB->FRETEALT
	cTransDef	:= POSICIONE("SA4",1,XFILIAL("SA4")+cArqTRB->TRANSPDEF,"A4_NOME")
	cTransalt	:= POSICIONE("SA4",1,XFILIAL("SA4")+cArqTRB->TRANSALT,"A4_NOME")
	cUsualt		:= cArqTRB->USUARALT
	cMotalt		:= cArqTRB->MOTIVOALT
	cNumNF		:= cArqTRB->NUMNF
	nVlrFret	:= cArqTRB->VLRNF
	cTransNF	:= POSICIONE("SA4",1,XFILIAL("SA4")+cArqTRB->TRANSPNF,"A4_NOME")
    cStatus		:= IIF(cArqTRB->MODAL = "2", "TRANSPORTADORA ALTERADA",IIF(cArqTRB->MODAL = "5","ISENวรO DE FRETE",""))
	
	FWrite(nArq, cEmiss+";"+cNumped + ";'" + cCodcli+ ";'" + cLojacli+";"+cNomCli+";"+TRANSFORM(nVlrped, "@E 999,999,999.99")+";" ;
	+TRANSFORM(nVlrfrcalc, "@E 999,999,999.99")+";"+TRANSFORM(nVlrfralt, "@E 999,999,999.99")+";"+cTransDef+";" ;
	+cTransalt+";"+cUsualt+";"+cMotalt+";'"+cNumNF+";"+TRANSFORM(nVlrFret, "@E 999,999,999.99")+";"+cTransNF+";" ;
	+cStatus+ Chr(13) + Chr(10))
	
	cArqTRB->(DBSKIP())
ENDDO

cQuery1:= " SELECT C5_EMISSAO EMISSAO,C5_NUM NUMPED, C5_CLIENTE CODCLI, C5_LOJACLI LOJACLI, C5_NOMCLI NOMECLI, SUM(C6_VALOR) VLRPED, C5_FRETEOR FRETECALC, "
cQuery1+= " C5_FRETE FRETEALT, C5_XTRANOR TRANSPDEF, C5_TRANSP TRANSALT, C5_ALTFRET USUARALT, C5_MOTFRET MOTIVOALT, "
cQuery1+= " D2_DOC NUMNF, F2_FRETE VLRNF, F2_TRANSP TRANSPNF, C5_MODAL MODAL "
cQuery1+= " FROM SA1010, SD2010, SF2010, SC5010, SC6010 "
cQuery1+= " WHERE A1_FILIAL = ' ' "
cQuery1+= " AND A1_COD = C5_CLIENTE "
cQuery1+= " AND A1_LOJA = C5_LOJACLI "
cQuery1+= " AND C5_FILIAL = '"+XFILIAL("SC5")+"' "
cQuery1+= " AND C5_NUM = D2_PEDIDO "
cQuery1+= " AND C6_FILIAL = '"+XFILIAL("SC6")+"' "
cQuery1+= " AND C6_NUM = C5_NUM "
cQuery1+= " AND D2_FILIAL = '"+XFILIAL("SD2")+"' "
cQuery1+= " AND F2_DOC = D2_DOC "
cQuery1+= " AND F2_FILIAL = '"+XFILIAL("SF2")+"' "
cQuery1+= " AND C5_TRANSP <> F2_TRANSP "
cQuery1+= " AND C5_EMISSAO >= '"+DTOS(MV_PAR01)+"' "
cQuery1+= " AND C5_EMISSAO <= '"+DTOS(MV_PAR02)+"' "
cQuery1+= " AND C5_MOTFRET = ' '"
cQuery1+= " AND SA1010.D_E_L_E_T_ = ' ' "
cQuery1+= " AND SF2010.D_E_L_E_T_ = ' ' "
cQuery1+= " AND SD2010.D_E_L_E_T_ = ' ' "
cQuery1+= " AND SC5010.D_E_L_E_T_ = ' ' "
cQuery1+= " AND SC6010.D_E_L_E_T_ = ' ' "
cQuery1+= " GROUP BY C5_EMISSAO,C5_NUM, C5_CLIENTE, C5_LOJACLI, C5_NOMCLI, C5_FRETEOR,C5_FRETE, C5_XTRANOR, C5_TRANSP, C5_ALTFRET, C5_MOTFRET, "
cQuery1+= " D2_DOC, F2_FRETE, F2_TRANSP, C5_MODAL"

If Select("cArqTRB1") > 0
	dbSelectArea("cArqTRB1")
	dbCloseArea("cArqTRB1")
Endif

cQuery1 := ChangeQuery(cQuery1)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1),"cArqTRB1",.T.,.T.)

dbSelectArea("cArqTRB1")
cArqTRB1->(dbGoTop())

WHILE cArqTRB1->(!EOF())

    cEmiss1		:= SUBSTR(cArqTRB1->EMISSAO,7,2)+"/"+SUBSTR(cArqTRB1->EMISSAO,5,2)+"/"+SUBSTR(cArqTRB1->EMISSAO,1,4)	
	cNumped1	:= cArqTRB1->NUMPED
	cCodcli1	:= cArqTRB1->CODCLI
	cLojacli1	:= cArqTRB1->LOJACLI
	cNomCli1	:= cArqTRB1->NOMECLI
	nVlrped1	:= cArqTRB1->VLRPED
	nVlrfrcalc1	:= cArqTRB1->FRETECALC
	nVlrfralt1	:= cArqTRB1->FRETEALT
	cTransDef1	:= POSICIONE("SA4",1,XFILIAL("SA4")+cArqTRB1->TRANSPDEF,"A4_NOME")
	cTransalt1	:= " "//cArqTRB1->TRANSALT
	cUsualt1	:= " "//cArqTRB1->USUARALT
	cMotalt1	:= " "//cArqTRB1->MOTIVOALT
	cNumNF1		:= cArqTRB1->NUMNF
	nVlrFret1	:= cArqTRB1->VLRNF
	cTransNF1	:= POSICIONE("SA4",1,XFILIAL("SA4")+cArqTRB1->TRANSPNF,"A4_NOME")
    cStatus1	:= "TRANSPORTADORA ALTERADA NA NOTA FISCAL"
	
	
	FWrite(nArq, cEmiss1+";"+cNumped1 + ";'" + cCodcli1+ ";'" + cLojacli1+";"+cNomCli1+";"+TRANSFORM(nVlrped1, "@E 999,999,999.99")+";" ;
	+TRANSFORM(nVlrfrcalc1, "@E 999,999,999.99")+";"+TRANSFORM(nVlrfralt1, "@E 999,999,999.99")+";'"+cTransDef1+";" ;
	+cTransalt1+";"+cUsualt1+";"+cMotalt1+";'"+cNumNF1+";"+TRANSFORM(nVlrFret1, "@E 999,999,999.99")+";"+cTransNF1+";" ;
	+cStatus1+ Chr(13) + Chr(10))
	
	cArqTRB1->(DBSKIP())
ENDDO

FClose(nArq)

DbSelectArea("cArqTRB")
DbCloseArea()

DbSelectArea("cArqTRB1")
DbCloseArea()

aFiles:= {"\SYSTEM\RELTRACK\"+ cArq + ".CSV"}

ALERT("RELATORIO SALVO EM C:\RELATORIOS\"+cArq+".CSV")

//cEmailTrack:= "ebuttner@ncgames.com.br" //ALLTRIM(GETMV("NC_ETRACK"))
//U_ENVIAEMAIL(cEmailTrack, ,,"RELATORIO DE FRETES","SEGUE ARQUIVO DE RELAวรO DE FRETES.", aFiles) //"ebuttner@ncgames.com.br;rciambarella@ncgames.com.br"

//FErase(cPath + cArq + ".CSV")

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
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})

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