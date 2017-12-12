#include "rwmake.ch"
#include "Protheus.ch"
#include "TOPCONN.CH"
#include "TbiConn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |  M460FIM ºAutor  ³Microsiga           º Data ³  14/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada depois da emissao da Nota Fiscal.    	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION M460FIM()

Local _aArea       := GetArea()
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore:=(cFilAnt$cFilStore)

/*TIAGO BIZAN*/
Local clQryCS	:= ""
Local clPed		:= SC5->C5_NUM
Local clChCros	:= SC5->C5_YCHCROS
Local clPvTran	:= SC5->C5_YTRANS
Local clFil		:= SC5->C5_FILIAL
Local clDoc		:= SF2->F2_DOC
Local clSerie	:= SF2->F2_SERIE
Local clCliForn	:= SF2->F2_CLIENTE
Local clLoja	:= SF2->F2_LOJA
Local cAlias	:= GetNextAlias()
Local cAliasCS	:= GetNextAlias()
Local llGrvCabec:= .T.
Local clArea	:= GetArea()
Local alvalores	:= {}
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,"03")
Local clUsrBD	:= U_MyNewSX6(	"NCG_000019", ;
"", ;
"C", ;
"Usuário para acessar a base do WMS",;
"Usuário para acessar a base do WMS",;
"Usuário para acessar a base do WMS",;
.F. )

Local clA4Padr	:= U_MyNewSX6(	"NCG_100010", ;
"000034",;
"C",;
"Código da transportadora padrão para o pedido de transferência",;
"Código da transportadora padrão para o pedido de transferência",;
"Código da transportadora padrão para o pedido de transferência",;
.F. )

Local clArmz	:= SuperGetMV("MV_ARMWMAS")
Local aItePed	:= {}
Local lEnvia	:= .T.
Local _aArea       := GetArea()
Local _aAreaSF2    := SF2->(GetArea())
Local _aAreaSD2    := SD2->(GetArea())
Local _aAreaSF7    := SF7->(GetArea())
Local _aAreaCDC    := CDC->(GetArea())
Local _aAreaSC9    := SC9->(GetArea())

DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+SD2->(D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA))

DbSelectArea("SZ7")
SZ7->(DbSetOrder(1))
SZ7->(RecLock("SZ7", .T.))
SZ7->Z7_FILIAL := xFilial("SZ7")
SZ7->Z7_NUM	 := SD2->D2_PEDIDO
SZ7->Z7_STAT   := "000008"
SZ7->Z7_STATUS := "NOTA FISCAL EMITIDA"
SZ7->Z7_CODCLI := SF2->F2_CLIENTE
SZ7->Z7_DOC    := SF2->F2_DOC
SZ7->Z7_DATA   := DATE()
SZ7->Z7_HORA   := TIME()
SZ7->Z7_SERIE	 := SF2->F2_SERIE
SZ7->Z7_USUARIO:= Upper(Substr(cUsuario,7,15))
SZ7->(MsUnLock())

cYCanal	:= ""

SC5->(DbSelectArea("SC5"))
SC5->(DbSetOrder(1))

SA1->(DbSelectArea("SA1"))
SA1->(DbSetOrder(1))

If SC5->(MsSeek(xfilial("SD2")+SD2->D2_PEDIDO)) .And. !Empty(SC5->C5_YCANAL)
	cYCanal := SC5->C5_YCANAL
ElseIf SA1->(MsSeek(xfilial("SA1")+SD2->(D2_CLIENTE+D2_LOJA)))
	cYCanal := SA1->A1_YCANAL
EndIf

DBSELECTAREA("CDC")
DBSETORDER(1)
IF DBSEEK(XFILIAL("CDC")+"S"+SF2->F2_DOC)
	RECLOCK("CDC",.F.)
	CDC_GUIA:="ICM"+SF2->F2_DOC
	MSUNLOCK()
ENDIF
nRecPZ1:=0
If !IsInCallStack("U_NCGJ001") .And. U_M001TemPV(xFilial("SD2"),SD2->D2_PEDIDO,2,@nRecPZ1)
	PZ1->(DbGoTo(nRecPZ1))
	U_M001PZ1Grv("GRAVA_NOTA_SAIDA",,PZ1->PZ1_FILORI,PZ1->PZ1_FILDES,PZ1->PZ1_PVORIG,PZ1->PZ1_PVDEST,SD2->D2_DOC,SD2->D2_SERIE)
EndIf

DBSELECTAREA("SC9")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SC9")+SD2->D2_PEDIDO)
	WHILE SC9->C9_PEDIDO == SD2->D2_PEDIDO
		SC9->(RecLock("SC9", .F.))
		SC9->C9_STAPICK := "3"
		SC9->C9_STAWMAS := "2"
		SC9->(MsUnLock())
		SC9->(DBSKIP())
	ENDDO
ENDIF

If SF2->(FieldPos("F2_NUMEDI")) > 0 .And. SF2->(FieldPos("F2_SEQ")) > 0
	// Realiza gravação do numero do pedido edi e sequencia na NF
	If RecLock("SF2",.F.)
		SF2->F2_NUMEDI	:= SC5->C5_NUMEDI
		SF2->F2_SEQ		:= SC5->C5_SEQ
		SF2->(MsUnlock())
	EndIf
EndIf


DBSELECTAREA("SC5")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SC5")+SD2->D2_PEDIDO)
	WHILE SC5->C5_NUM == SD2->D2_PEDIDO
		SC5->(RecLock("SC5", .F.))
		SC5->C5_STAPICK := "3"
		SC5->C5_LIBEROK := "S"
		SC5->(MsUnLock())
		SC5->(DBSKIP())
	ENDDO
ENDIF

RestArea(_aArea)

cNF  	:= SF2->F2_DOC
cPED 	:= SD2->D2_PEDIDO
cSERIE	:= SF2->F2_SERIE
cCODCLI	:= SF2->F2_CLIENTE
cLOJA 	:= SF2->F2_LOJA

//Acertar ida para a SZ1 para gerar registro na SZ1 apenas quando este for para o WMS
Processa( {|| ConfirRom() } )


DBSELECTAREA("SD2")
DBSETORDER(3)
DBSEEK(XFILIAL("SD2")+SF2->F2_DOC)
WHILE SF2->F2_DOC == SD2->D2_DOC
	SD2->(RecLock("SD2", .F.))
	SD2->D2_XLANC 	:= POSICIONE("SB1",1,XFILIAL("SB1")+SD2->D2_COD,"B1_LANC")
	SD2->D2_XCURABC	:= POSICIONE("SB1",1,XFILIAL("SB1")+SD2->D2_COD,"B1_XCURABC")
	SD2->(MsUnLock())
	SD2->(DBSKIP())
ENDDO

//ATUALIZA INFORMAÇÃO DE PESO LIQUIDO E VOLUME NA NOTA DO PROTHEUS

clQryCS := " SELECT CS_QTDE_VOLUMES VOLUME, CS_QTDE_SEPARADA QTD, CS_QTDE_SEPARADA*B1_PESO LIQUIDO, CS_QTDE_SEPARADA*B1_PESBRU BRUTO "

clQryCS += " FROM WMS.TB_WMSINTERF_CONF_SEPARACAO CS "

clQryCS += " INNER JOIN " + RetSqlName("SB1") + " SB1 "
clQryCS += " ON SB1.B1_COD = RPAD(CS.CS_COD_PRODUTO,15) "
clQryCS += " AND SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
clQryCS += " AND SB1.D_E_L_E_T_ = ' ' "

If !Empty(clChCros) .and. !(clFil == "03")
	clQryCS += " WHERE CS_COD_DEPOSITANTE = '"+SUBSTR(clChCros,2,1)+"' "
	clQryCS += " AND CS_NUM_DOCUMENTO = '"+ALLTRIM(clChCros)+"' "
ElseIf !Empty(clChCros) .and. clFil == "03"
	clQryCS += " WHERE CS_COD_DEPOSITANTE = '"+SUBSTR(clFil,2,1)+"' "
	clQryCS += " AND CS_NUM_DOCUMENTO = '"+ALLTRIM(clChCros)+"' "
Else
	clQryCS += " WHERE CS_COD_DEPOSITANTE = '"+SUBSTR(clFil,2,1)+"' "
	clQryCS += " AND CS_NUM_DOCUMENTO = '"+ALLTRIM(clPed)+"' "
EndIf
Iif(Select(cAliasCS) > 0,(cAliasCS)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQryCS),cAliasCS  ,.F.,.T.)

If (cAliasCS)->(!EOF())
	nlLiq	:= 0
	nlBrut	:= 0
	nlVol	:= (cAliasCS)->VOLUME
	While (cAliasCS)->(!EOF())
		nlLiq	+= LIQUIDO
		nlBrut	+= BRUTO
		(cAliasCS)->(DBSkip())
	EndDO
	
	If RecLock("SF2",.F.)
		SF2->F2_PLIQUI	:= nlLiq
		SF2->F2_PBRUTO	:= IIF(nlLiq > nlBrut, nlLiq, nlBrut)
		SF2->F2_VOLUME1	:= nlVol
		SF2->F2_ESPECI1	:= "VOLUME(S)"
		SF2->F2_YCANAL	:= cYCanal
		If clPvTran $ "1/S"
			SF2->F2_TRANSP	:= clA4Padr
		EndIf
		SF2->(MSUnlock())
	EndIF
	
EndIF

If RecLock("SF2",.F.)
	SF2->F2_ESPECI1	:= "VOLUME(S)"
	SF2->(MSUnlock())
EndIF


If !(SF2->F2_TIPO $ 'CIP')
	clQry := " SELECT D2_ITEM,D2_COD FROM "+RetSqlName("SF2") + " SF2 "
	
	clQry += " INNER JOIN "+RetSqlName("SD2") + " SD2	"
	clQry += " ON SD2.D2_FILIAL = SF2.F2_FILIAL "
	clQry += " AND SD2.D2_DOC = SF2.F2_DOC "
	clQry += " AND SD2.D2_SERIE = SF2.F2_SERIE "
	clQry += " AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "
	clQry += " AND SD2.D2_LOJA = SF2.F2_LOJA "
	
	clQry += " INNER JOIN "+RetSqlName("SB1") + " SB1	"
	clQry += " ON SB1.B1_COD = SD2.D2_COD "
	clQry += " AND SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	//RETIRADO EM 04/07/2013
	//	clQry += " AND SB1.B1_TIPO = 'PA' "  //SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
	clQry += " AND SB1.D_E_L_E_T_ = ' ' "
	
	clQry += " INNER JOIN "+RetSqlName("SF4") + " SF4	"
	clQry += " ON SF4.F4_CODIGO = SD2.D2_TES "
	clQry += " AND SF4.F4_FILIAL = '" + xFilial("SF4") + "'"
	clQry += " AND SF4.F4_ESTOQUE = 'S' " //SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
	clQry += " AND SF4.D_E_L_E_T_ = ' ' "
	
	clQry += " WHERE SF2.F2_FILIAL = '" + SF2->F2_FILIAL + "'"
	clQry += " AND SF2.F2_DOC = '" + SF2->F2_DOC + "'"
	clQry += " AND SF2.F2_SERIE = '" + SF2->F2_SERIE + "'"
	clQry += " AND SF2.F2_CLIENTE = '" + SF2->F2_CLIENTE + "'"
	clQry += " AND SF2.F2_LOJA = '" + SF2->F2_LOJA + "'"
	//retirado tratamento em 11/06/13 conforme nova revisão para que todas as notas fiscais, inclusive não movimentados pelo WMS sejam enviadas para o FRETES
	//	clQry += " AND SD2.D2_LOCAL IN " + FORMATIN(clArmz,"/") //SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS) DEVEM SER EXPORTADOS PARA O WMS
	clQry += " AND SD2.D_E_L_E_T_ = ' ' "
	clQry += " ORDER BY SD2.D2_ITEM "
	
	Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias,.F.,.T.)
	
	DBSelectArea("P0A")
	P0A->(DBSetOrder(1))
	
	If (cAlias)->(!EOF())
		While (cAlias)->(!EOF())
			//tratamento para não enviar produtos duplicados
			If (nPos := Ascan( aItePed, { |x| SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA+(cAlias)->D2_COD $ x[1] } ) ) == 0
				lEnvia	:= .T.
				aadd(aItePed,{SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA+(cAlias)->D2_COD,1})
			Else
				lEnvia	:= .F.
				aItePed[nPos,2] += 1
			EndIf
			If lEnvia
				If P0A->(RecLock("P0A",.T.))
					P0A->P0A_FILIAL	:= xFilial("P0A")
					P0A->P0A_CHAVE	:= SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA+(cAlias)->D2_ITEM
					P0A->P0A_TABELA	:= "SD2"
					P0A->P0A_EXPORT := '2'
					P0A->P0A_INDICE	:= 'D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_ITEM'
					P0A->P0A_TIPO	:= '1'
					P0A->(MsUnlock())
				EndIF
			EndIf
			llSF2 := .T.
			
			(cAlias)->(DBSkip())
		EndDO
	Else
		llSF2 := .F.
	EndIF
	
	If llSF2
		If P0A->(RecLock("P0A",.T.))
			P0A->P0A_FILIAL	:= xFilial("P0A")
			P0A->P0A_CHAVE	:= SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA
			P0A->P0A_TABELA	:= "SF2"
			P0A->P0A_EXPORT := '2'
			P0A->P0A_INDICE	:= 'F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA'
			P0A->P0A_TIPO	:= '1'
			P0A->(MsUnlock())
		EndIF
		If lWmsStore
			U_PR109Grv("SF2",SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA,"3")//WMAS Store
		EndIf
	EndIF
	
	P0A->(DBCloseArea())
EndIF



//Atualiza o custo medio gerencial na saida
AtuCMGB2(SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA)

//Verifica se o processo é de E-commerce e atualiza as tabelas necessarias para o controle do mesmo
U_NCECOM10(SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA,SF2->F2_TRANSP)


Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
Iif(Select(cAliasCS) > 0,(cAliasCS)->(dbCloseArea()),Nil)

RestArea(_aAreaSC9)
RestArea(_aAreaCDC)
RestArea(_aAreaSF7)
RestArea(_aAreaSD2)
RestArea(_aAreaSF2)
RestArea(_aArea)

RETURN .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ConfirRom ºAutor  ³Microsiga           º Data ³  03/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ConfirRom

Local aAreaRom	:= getarea()
Local nCodRom	:= 0

xNUM_NF  := SF2->F2_DOC			// Numero
xSERIE   := SF2->F2_SERIE		// Serie
xEMISSAO := SF2->F2_EMISSAO		// Data de Emissao
xCliente := SF2->F2_CLIENTE		// CODIGO DO CLIENTE
xLOJA    := SF2->F2_LOJA		// Loja do Cliente
xTRANSP	 := SF2->F2_TRANSP		// TRANSPORTADORA
xQtVolume:= SF2->F2_VOLUME1
dbSelectArea("SZ3")
dbSetOrder(1)

//SE JA TIVER SIDO EMITIDO A ETIQUETA, É NECESSÁRIO CANCELAR PRIMEIRO
IF dbSeek(xFilial("SZ3")+xNum_NF+xSerie)
	While SZ3->(!EOF()) .AND. xFilial("SZ3")+xNum_NF+xSerie == SZ3->(Z3_FILIAL+Z3_DOC+Z3_SERIE)
		Reclock("SZ3")
		DBDELETE()
		MsUnlock()
		SZ3->(DbSkip())
	End
	//	MSGBOX("Romaneio já confirmado!!! Cancele o registro de confirmação do romaneio para realizar a operação.","ATENÇÃO","alert")
	//	Return
EndIf

dbSelectArea("SD2")
dbSetOrder(3)
dbSeek(xFilial()+xNUM_NF+xSERIE)
cPedAtu  := SD2->D2_PEDIDO
cItemAtu := SD2->D2_ITEMPV


dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial()+xCliente+xLoja)
xEND_CLI := SA1->A1_ENDENT
xBAIRRO  := SA1->A1_BAIRROE
xCEP_CLI := SA1->A1_CEPE
xNReduz  := SA1->A1_NOME
xMunic   := SA1->A1_MUNE
xEstado  := SA1->A1_ESTE

If Posicione("SC5",1,xFilial("SC5")+SD2->D2_PEDIDO,"C5_XECOMER")=="C" 
	U_COM05EndEnt(SD2->D2_PEDIDO,@xEND_CLI,@xBAIRRO,@xCEP_CLI,@xMunic,@xEstado)
EndIf


dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xFilial()+SF2->F2_TRANSP)
_cTransp := Alltrim(SA4->A4_NOME)

dbSelectArea("SZ1")
dbSetOrder(1)
IF dbSeek(xFilial("SZ1")+xNum_NF+xSerie)
	Reclock("SZ1",.F.)
	SZ1->Z1_FILIAL  := XFILIAL("SZ1")
	SZ1->Z1_DOC     := xNum_NF
	SZ1->Z1_SERIE   := xSerie
	SZ1->Z1_CLIENTE := xCliente
	SZ1->Z1_LOJA    := xLoja
	SZ1->Z1_NOMECLI := xNReduz
	SZ1->Z1_PEDIDO  := cPedAtu
	SZ1->Z1_DTEMISS := dDatabase
	SZ1->Z1_HORAET  := TIME()   //Horario de Etiquetagem
	SZ1->Z1_QTDVOL  := xQtVolume //MV_PAR04
	SZ1->Z1_ROMANEI := nCodRom
	MsUnlock()
Else
	Reclock("SZ1",.T.)
	SZ1->Z1_FILIAL  := XFILIAL("SZ1")
	SZ1->Z1_DOC     := xNum_NF
	SZ1->Z1_SERIE   := xSerie
	SZ1->Z1_CLIENTE := xCliente
	SZ1->Z1_LOJA    := xLoja
	SZ1->Z1_NOMECLI := xNReduz
	SZ1->Z1_PEDIDO  := cPedAtu
	SZ1->Z1_DTEMISS := dDatabase
	SZ1->Z1_HORAET  := TIME()   //Horario de Etiquetagem
	SZ1->Z1_QTDVOL  := xQtVolume //MV_PAR04
	SZ1->Z1_ROMANEI := nCodRom
	MsUnlock()
EndIF

For _i:=1 To xQtVolume //mv_par04
	xCodBar:=GetMv("MV_X_CBARR")
	dbSelectArea("SX6")
	PutMv("MV_X_CBARR",Strzero(xCodBar+1,6))
	dbSelectArea("SZ3")
	dbSetOrder(1)
	IF ! dbSeek(xFilial("SZ3")+xNum_NF+xSerie+Alltrim(Strzero(_i,2)))
		RecLock("SZ3",.T.)
		SZ3->Z3_FILIAL  := XFILIAL("SZ3")
		SZ3->Z3_ITEM    := Alltrim(Strzero(_i,2))
		SZ3->Z3_DOC     := xNum_NF
		SZ3->Z3_SERIE   := xSerie
		SZ3->Z3_CLIENTE := xCliente
		SZ3->Z3_LOJA    := xLoja
		SZ3->Z3_CODPACK := Alltrim(Strzero(xCodBar,6))
		SZ3->Z3_EMISSOR := Upper(Substr(cUsuario,7,15))
		SZ3->Z3_ROMANEI := nCodRom
		MsUnlock()
	EndIF
Next


RestArea(aAreaRom)

Return


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AtuCMGB2 ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o custo gerencial de devolução			 	      ³±±
±±³			 ³ 												  			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 							                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AtuCMGB2(cDoc, cSerie, cCliForn, cLoja)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmpSd2	:= GetNextAlias()

Default cDoc		:= ""
Default cSerie		:= ""
Default cCliForn	:= ""
Default cLoja		:= ""

cQuery := " SELECT D2_COD, D2_LOCAL, R_E_C_N_O_ RECNOD2 FROM "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery += " WHERE SD2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " 	AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "	+CRLF
cQuery += " 	AND SD2.D2_DOC = '"+cDoc+"' "+CRLF
cQuery += " 	AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF
cQuery += " 	AND SD2.D2_CLIENTE = '"+cCliForn+"' "+CRLF
cQuery += " 	AND SD2.D2_LOJA = '"+cLoja+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmpSd2 , .F., .T.)

//Abre a area de saldos atuais SB2
DbSelectArea("SB2")
DbSetOrder(1)

//Abre a area de Itens da Nota Fiscal de Saida
DbSelectArea("SD2")
DbSetOrder(1)

(cArqTmpSd2)->(DbGoTop())
While (cArqTmpSd2)->(!Eof())
	
	//Posiciona no item da nota fiscal
	SD2->(DbGoTo((cArqTmpSd2)->RECNOD2))
	
	//Atualiza o total do CMG na tabela SB2
	u_GrvCMGB2(SD2->D2_COD, SD2->D2_LOCAL,0,0, .T.)
	
	
	//Verifica se existe price protectio aplicado para este produto.
	//Caso exista, então será preenchido o custo gerencial atual.
	If u_VldPP(SD2->D2_COD, SD2->D2_EMISSAO)
		
		//Grava o CMG no documento de saida
		If SB2->(DbSeek(xFilial("SB2") + SD2->D2_COD + SD2->D2_LOCAL))
			Reclock("SD2",.F.)
			
			//Percentual de diferenca
			//nPercDif	:= ROUND(((nCMGBR * 100) / nCustCTB) - 100 , TAMSX3("D3_YPERCBR")[2])
			
			SD2->D2_YCMGBR  := (SD2->D2_QUANT * SB2->B2_YCMGBR)
			SD2->D2_YCMVG 	:= (SD2->D2_QUANT * SB2->B2_YCMVG)
			
			SD2->(MsUnLock())
		EndIf
	Else
		//Grava o CMG no documento de saida
		If SB2->(DbSeek(xFilial("SB2") + SD2->D2_COD + SD2->D2_LOCAL))
			Reclock("SD2",.F.)
			
			//Percentual de diferenca
			//nPercDif	:= ROUND(((nCMGBR * 100) / nCustCTB) - 100 , TAMSX3("D3_YPERCBR")[2])
			
			SD2->D2_YCMGBR  := (SD2->D2_QUANT * SB2->B2_YCMGBR)
			
			SD2->(MsUnLock())
		EndIf
		
	EndIf
	
	
	(cArqTmpSd2)->(DbSkip())
EndDo


(cArqTmpSd2)->(DbCloseArea())

RestArea(aArea)
Return



