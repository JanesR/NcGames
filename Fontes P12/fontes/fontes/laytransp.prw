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
User Function LAYTRANS()

Local   cArqTRB	:= CriaTrab(,.F.)
PRIVATE cPerg	:= "TOTEXP"

cArq := "TOTAL_EXPRESS_"+DTOS(DDATABASE)+"-"+SUBSTR(TIME(),1,2)+"-"+SUBSTR(TIME(),4,2)+"-"+SUBSTR(TIME(),7,2)+"-"+ALLTRIM(Upper(cUsername))
cPath := "C:\RELATORIOS\"
cPath2:= "\SYSTEM\RELTRACK\"
nArq  := FCreate(cPath + cArq + ".CSV")
nArq1 := FCreate(cPath2+ cArq + ".CSV")


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

IF   !EMPTY(ALLTRIM(MV_PAR05))// ALTERADO CONFORME SOLICITAวรO DE EDMAR BRITO DIA 22/11/12 - NรO OBRIGATORIO O CODIGO DE TRANSPORTADORA- ALTERADO POR ERICH BUTTNER
	cQuery+= " AND F2_TRANSP = '"+ALLTRIM(MV_PAR05)+"' "
ENDIF

cQuery+= " AND F2_FILIAL = '"+XFILIAL("SF2")+"' "
cQuery+= " AND A1_FILIAL = '  ' "
cQuery+= " AND F2_CLIENTE = A1_COD "
cQuery+= " AND F2_LOJA = A1_LOJA "
cQuery+= " AND F2_FILIAL = D2_FILIAL "
cQuery+= " AND F2_DOC = D2_DOC "
cQuery+= " AND SF2010.D_E_L_E_T_ = ' ' "
cQuery+= " AND SD2010.D_E_L_E_T_ = ' ' " 
cQuery+= " AND SA1010.D_E_L_E_T_ = ' ' "
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
	
	//IF cArqTRB->EMISSAO+ALLTRIM(cArqTRB->HORA) <= DTOS(MV_PAR02)+ALLTRIM(MV_PAR04)
	// ALTERADO CONFORME SOLICITAวรO DE EDMAR BRITO DIA 22/11/12 - NรO Hม NECESSIDADE DE GERAR O ARQUIVO POR HORA DE / ATE - ALTERADO POR ERICH BUTTNER
	cLayout 	:= "TOTAL20"
	cCnpjnc		:= SM0->M0_CGC
	cCodServ	:= ""
	cTpserver	:= 1
	cTpentr		:= 0
	cPeso		:= cArqTRB->PESOLIQUI
	cVolume		:= cArqTRB->VOLUME
	cTpfrete	:= IIF(ALLTRIM(cArqTRB->TPFRETE) =="C", "CIF","FOB")
	cPedido		:= cArqTRB->PEDIDO
	cIdCli		:= ""
	cNatureza	:= "JOGOS E ACESS. P/ GAMES"
	cTpvol		:= ""
	cIsencao	:= 0
	cInfocol	:= ""
	cNomcli		:= SUBSTR(cArqTRB->NOMCLI,1,40)
	cCgccli		:= SUBSTR(cArqTRB->CGCCLI,1,14)
	cInscri		:= SUBSTR(cArqTRB->INSCR,1,14)
	cEndent		:= STRTRAN(ALLTRIM(SUBSTR(cArqTRB->ENDERE,1,80)),"	","")
	cNumEnd		:= "0"
	cCompl		:= ""
	cRefer		:= ""
	cBairro		:= SUBSTR(ALLTRIM(cArqTRB->BAIRRO),1,40)
	cCidade		:= SUBSTR(ALLTRIM(cArqTRB->MUNICIPIO),1,40)
	cEstado		:= SUBSTR(ALLTRIM(cArqTRB->ESTADO),1,2)
	cPais		:= ""
	cCep		:= SUBSTR(ALLTRIM(cArqTRB->CEP),1,8)
	cEmail		:= ""
	cDdd		:= SUBSTR(ALLTRIM(cArqTRB->DDD),1,3)
	cTel1		:= STRTRAN(SUBSTR(ALLTRIM(cArqTRB->TEL1),1,12),"-","")
	cTel2       := STRTRAN(SUBSTR(ALLTRIM(cArqTRB->TEL2),1,12),"-","")
	cTel3		:= STRTRAN(SUBSTR(ALLTRIM(cArqTRB->TEL3),1,12),"-","")
	cCod		:= "0"
	cCodfpagto	:= ""
	cCodparc	:= ""
	cCodvlr		:= ""
	dDtagen		:= ""
	cPerEnt1	:= ""
	cPerEnt2	:= ""
	cNumNf		:= SUBSTR(ALLTRIM(cArqTRB->NUMNF),1,9)
	cSerie		:= SUBSTR(ALLTRIM(cArqTRB->SERIE),1,3)
	dDtEmis		:= SUBSTR(cArqTRB->EMISSAO,7,2)+"/"+SUBSTR(cArqTRB->EMISSAO,5,2)+"/"+SUBSTR(cArqTRB->EMISSAO,1,4)
	nVlrBrut	:= cArqTRB->VLRBRUTO
	nVlrMerc	:= cArqTRB->VLRMERC
	cCfop		:= SUBSTR(ALLTRIM(cArqTRB->NUMNF),1,4)
	cNfechave	:= SUBSTR(ALLTRIM(cArqTRB->CHAVENFE),1,44)
	
	FWrite(nArq, cLayout + ";" + cCnpjnc+ ";" +cCodServ+";"+STR(cTpserver)+";"+STR(cTpentr)+";"+STR(cPeso)+";"+STR(cVolume)+";";
	+cTpfrete+";"+cPedido+";"+cIdCli+";"+cNatureza+";"+cTpvol+";"+STR(cIsencao)+";"+cInfocol+ ";" ;
	+cNomcli+";"+cCgccli+";"+cInscri+";"+cEndent+";"+cNumEnd+";"+cCompl+";"+cRefer+";"+cBairro+";"+cCidade+";";
	+cEstado+";"+cPais+";"+cCep+";"+cEmail+";"+cDdd+";"+cTel1+";"+cTel2+";"+cTel3+";"+cCod+";"+cCodfpagto+";";
	+cCodparc+";"+cCodvlr+";"+dDtagen+";"+cPerEnt1+";"+cPerEnt2+";"+cNumNf+";"+cSerie+";"+dDtEmis+";";
	+STR(nVlrBrut)+";"+STR(nVlrMerc)+";"+cCfop+";"+cNfechave+Chr(13) + Chr(10))
	
	FWrite(nArq1, cLayout + ";" + cCnpjnc+ ";" +cCodServ+";"+STR(cTpserver)+";"+STR(cTpentr)+";"+STR(cPeso)+";"+STR(cVolume)+";";
	+cTpfrete+";"+cPedido+";"+cIdCli+";"+cNatureza+";"+cTpvol+";"+STR(cIsencao)+";"+cInfocol+ ";" ;
	+cNomcli+";"+cCgccli+";"+cInscri+";"+cEndent+";"+cNumEnd+";"+cCompl+";"+cRefer+";"+cBairro+";"+cCidade+";";
	+cEstado+";"+cPais+";"+cCep+";"+cEmail+";"+cDdd+";"+cTel1+";"+cTel2+";"+cTel3+";"+cCod+";"+cCodfpagto+";";
	+cCodparc+";"+cCodvlr+";"+dDtagen+";"+cPerEnt1+";"+cPerEnt2+";"+cNumNf+";"+cSerie+";"+dDtEmis+";";
	+STR(nVlrBrut)+";"+STR(nVlrMerc)+";"+cCfop+";"+cNfechave+Chr(13) + Chr(10))
	
	//DBSELECTAREA("SF2")
	//DBSETORDER(1)
	//DBSEEK(XFILIAL("SF2")+cNumNf)
	//RECLOCK("SF2",.F.)
	//SF2->F2_XGERARQ := "1"
	//SF2->(MSUNLOCK())  // ALTERADO CONFORME SOLICITAวรO DE EDMAR BRITO DIA 22/11/12 - DEVE-SE GERAR O ARQUIVO QUANTAS VEZES NECESSมRIO- ALTERADO POR ERICH BUTTNER
	//ENDIF
	cArqTRB->(dbSKIP())
	
ENDDO

FClose(nArq)
FClose(nArq1)

DbSelectArea("cArqTRB")
DbCloseArea()

//aFiles:= {"\SYSTEM\RELTRACK\"+cArq+".CSV"}
//cEmailTrack:= "ebuttner@ncgames.com.br" //cEmailTrack:= ALLTRIM(GETMV("NC_LAYTRAN"))+";"+ALLTRIM(GETMV("NC_LAYTRA1"))+";"+ALLTRIM(GETMV("NC_LAYTRA2"))
//U_ENVIAEMAIL(cEmailTrack, ,,"ARQUIVO DE TRANSPORTADORA","SEGUE ARQUIVO DA TRANSPORTADORA.", aFiles)

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
AADD(aRegs,{cPerg,"03","Hora De?","","","mv_ch3","C",5,0,1,"C","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Hora Ate?","","","mv_ch4","C",5,0,1,"C","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Transp.","","","mv_ch5","C",6,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SA4"})


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
