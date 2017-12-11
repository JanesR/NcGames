#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ EXENCG106   บAutor  ณ Tiago Bizan  	 บ Data ณ  17/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Execucao do job para atualizacao da base do WMS			  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function EXENCG106(alParam) // U_EXENCG106() // U_EXENCG106(.T.)
Local nHDL
//NESTE PRIMEIRO MOMENTE SOMENTE A FILIAL 03 TERA INTEGRAวรO COM WMS
Default alParam	:= {.F.,'01','03'}

If Select("SM0")>0 .And. !alParam[1]
	alParam	:= {.F.,'01',SM0->M0_CODFIL}
EndIf

If !Semaforo(.T.,@nHDL,"NCGPR106")
	Return()
EndIf

Conout("Iniciando Atualiza็ใo...")

If alParam[1]
	Conout("Emrpesa e Filial")
	RpcSetType(3)
	RpcSetEnv(alParam[2],alParam[3])
EndIF

//ATUALIZA OS DADOS COM A INFORMAวีES DA P0A
If alParam[1]
	StartJob( "U_NCGPR106()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	U_NCGPR106(alParam[1])
EndIF


//TABELA DE UNIDADE DE MEDIDAS
If alParam[1]
	StartJob( "U_E0106SAH()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	U_E0106SAH(alParam[1])
EndIF


//TABELA DE ARMAZENS
If alParam[1]
	StartJob( "U_E0106SX5()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	U_E0106SX5(alParam[1])
EndIF


//Confirma็ใo de Entrada
If alParam[1]
	StartJob( "U_FRETDOCENT()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	U_FRETDOCENT(alParam[1])
EndIF


//Troca tipo estoque
If alParam[1]
	StartJob( "u_FTROCAEST()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	u_FTROCAEST(alParam[1])
EndIF

//Retorno de baixa de saldos
If alParam[1]
	StartJob( "u_FRETBAIXA()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	u_FRETBAIXA(alParam[1])
EndIF

//Grava numero do romaneio - CrossDocking
If alParam[1]
	StartJob( "u_NCGA007()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	u_NCGA007(alParam[1])
EndIF


//baixa do canhoto
If alParam[1]
	StartJob( "u_FBAIXACNH()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	u_FBAIXACNH(alParam[1])
EndIF

//Integra็ใo faturas
If alParam[1]
	StartJob( "u_FFRTSSE2()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	u_FFRTSSE2(alParam[1])
EndIF

//Integra็ใo conhecimentos
If alParam[1]
	StartJob( "u_FFRTSISF1()", GetEnvServer(), .F., alParam[1], alParam[2],alParam[3])
Else
	u_FFRTSISF1(alParam[1])
EndIF


Semaforo(.F.,nHDL,"NCGPR106")

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCGPR106   บAutor  ณ Tiago Bizan  	 บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Executa a atualizacao dos Dados							  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function NCGPR106(lJob,cEmp,cFil)
Local clQuery	:= ""
Local cAlias	:= GetNextAlias()
Local cP0AItem	:= GetNextAlias()
Local nCnt		:= 0
Local clTab		:= ""
Local clTabWMS	:= ""
Local alCmpChave:= {}
Local alValChave:= {}
Local llFrete := .F.
Local lSemErro:=.T.
Local cPedido	:=""


Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'


If lJob
	RpcSetType(3)
	If !RpcSetEnv(cEmp,cFil)
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		Return()
	EndIf
EndIF

clQuery := " SELECT * "
clQuery += " FROM "+RetSqlName("P0A") + " P0A "
clQuery += " WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"'"
clQuery += " AND P0A.P0A_EXPORT = '2' "
clQuery += " AND P0A.P0A_TABELA<>'SC6'"
clQuery += " AND P0A.D_E_L_E_T_ = ' ' "
clQuery += " ORDER BY P0A_CHAVE "

Conout("Selecionando registros P0A")
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias,.F.,.T.)


//(cAlias)->(DBGoTop())

SC9->(DBSetOrder(1)) //C9_FILIAL, C9_PEDIDO, C9_ITEM, C9_SEQUEN, C9_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
P0A->(DBSetOrder(1))

Conout("Atualizando tabelas do WMS com registros da P0A")
Do While (cAlias)->(!EOF())
	
	If ALLTRIM((cAlias)->P0A_TABELA) $ "SB1*SAH"
		
		Conout("Tabela: "+ALLTRIM((cAlias)->P0A_TABELA))
		
		If clTab <> (cAlias)->P0A_TABELA
			
			clTab := (cAlias)->P0A_TABELA
			
			DBSelectArea(clTab)
			nlIndice := F106RETIND((cAlias)->P0A_TABELA,(cAlias)->P0A_INDICE)
			(clTab)->(DBSetOrder(nlIndice))
			
			If clTab == 'SB1'
				alCampos1 := U_F105RETCMP("B1P",.T.)
				alCampos2 := U_F105RETCMP("B1E",.T.)
			Else
				alCampos1 := U_F105RETCMP(clTab,.T.)
			EndIF
			
		EndIf
		
		If (cAlias)->P0A_TIPO $'12'
			
			If !(clTab)->(DBSeek((cAlias)->P0A_CHAVE))
				P0A->(DbGoTo((cAlias)->R_E_C_N_O_))
				P0A->(RecLock("P0A",.F.))
				P0A->P0A_EXPORT='X'
				P0A->(MsUnLock())
				(cAlias)->(DbSkip());Loop
			EndIf
			
			If clTab == 'SB1'
				alReg1	:= U_F105RETCMP("B1P",.F.,@clTabWMS,@alCmpChave,@alValChave,clTab)
				llFrete := .F.
				
				If !U_E0105EXT(clTabWMS, alCmpChave, alValChave,llFrete )
					clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS,Nil,Nil,llFrete)
				Else
					clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,llFrete)
				EndIf
				
				If !Empty(clQuery)
					GravaP0A(clQuery,(cAlias)->R_E_C_N_O_)
				EndIf
			Else
				alReg1	:= U_F105RETCMP(clTab,.F.,@clTabWMS,@alCmpChave,@alValChave,clTab)
				If (cAlias)->P0A_TIPO == '1'
					clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS)
				ElseIF (cAlias)->P0A_TIPO == '2'
					clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
				EndIF
				
				If !Empty(clQuery)
					GravaP0A(clQuery,(cAlias)->R_E_C_N_O_)
				EndIf
				
			EndIf
			
		Else
			
			If clTab == 'SB1'
				alReg1	:= U_F105RETCMP("B1P",.F.,@clTabWMS,@alCmpChave,@alValChave,cAlias,"3")
				clQuery := U_EXESQL105(3,,,clTabWMS,alCmpChave,alValChave)
				If !Empty(clQuery)
					GravaP0A(clQuery,(cAlias)->R_E_C_N_O_)
				EndIf
			EndIF
			
		EndIf
		
	ElseIf (cAlias)->P0A_TABELA=="SC5"
		
		
		clTab := ALLTRIM((cAlias)->P0A_TABELA)
		Conout("Tabela: "+clTab)
		cPedido:=Substr( AllTrim((cAlias)->P0A_CHAVE) ,3 )
		
		clQuery := " SELECT P0A.R_E_C_N_O_ RECP0A "
		clQuery += " FROM "+RetSqlName("P0A") + " P0A "
		clQuery += " WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"'"
		clQuery += " AND P0A.P0A_EXPORT = '2' "
		clQuery += " AND P0A.P0A_TABELA='SC6'"
		clQuery += " AND P0A.P0A_CHAVE Like '"+AllTrim((cAlias)->P0A_CHAVE)+"%'
		clQuery += " AND P0A.D_E_L_E_T_ = ' ' "
		clQuery += " ORDER BY  P0A_CHAVE"
		Iif(Select("P0AITEM") > 0,P0AITEM->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),"P0AITEM",.F.,.T.)
		
		lSemErro:=!P0AITEM->(Eof() .And. Bof() )
		
		//Begin Transaction
		
		Do While P0AITEM->(!Eof())
			P0A->(DbGoTo(P0AITEM->RECP0A) )
			If !PR106Grv("SC6",cAlias)
				lSemErro:=.F.
				Exit
			EndIf
			P0AITEM->(DbSkip())
		EndDo
		
		If lSemErro
			lSemErro:=PR106Grv("SC5",cAlias)
		EndIf
		
		If !lSemErro
			PR10ExcWMS(cPedido,AllTrim((cAlias)->P0A_CHAVE))
			//DisarmTransaction();Break
		EndIf
		
		//End Transaction
		
	Else
		clTab := ALLTRIM((cAlias)->P0A_TABELA)
		Conout("Tabela: "+clTab)
		alCampos1   := U_F105RETCMP(clTab,.T.)
		cChaveP0A	:= (cAlias)->P0A_CHAVE
		alAlias 		:= U_F106C5C6(clTab,cChaveP0A )
		
		If !alAlias[1]
			(cAlias)->(DbSkip());Loop
		EndIf
		
		If clTab $ "SF1*SD1*SF2*SD2" .And. ALLTRIM((alAlias[2])->ESPECIE) == 'SPED' .And. Empty((alAlias[2])->CHVNFE)
			(cAlias)->(DbSkip());Loop
		EndIF
		
		//If clTab$"SF2*SD2" .And. ALLTRIM((alAlias[2])->ESPECIE) == 'SPED' .And. !NfTransmitida(clTab,cChaveP0A)
		//(cAlias)->(DbSkip());Loop
		//EndIF
		
		
		alReg1	:= U_F105RETCMP(clTab,.F.,@clTabWMS,@alCmpChave,@alValChave,alAlias[2],,cChaveP0A)
		
		llFrete :=(clTab=="SA4")
		
		//CRIA A QUERY PARA INSERIR OU ALTERAR OS REGISTROS, ANTES ษ VERIFICADO SE O REGISTRO A SER INCLUIDO/ALTERADO EXISTE NO WMS,
		//CASO EXISTA NO WMS DEVE SER EXCLUIDO E INSERIDO NOVAMENTE, POIS, NO CASO DE PEDIDO DE VENDA O USUARIO PODE TER EXCLUIDO OU
		//INCLUIDO NOVOS PRODUTOS, SOMENTE OS ITENS SรO EXCLUIDOS O CABEวALHO CONTINUA O MESMO
		If !U_E0105EXT(clTabWMS, alCmpChave, alValChave,llFrete )
			clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS,Nil,Nil,llFrete)
		Else
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,llFrete)
		EndIf
		
		If !Empty(clQuery)
			GravaP0A(clQuery,(cAlias)->R_E_C_N_O_)
		EndIf
		
	EndIf
	
	
	(cAlias)->(DBSkip())
EndDo


ConOut("Finalizando rotina P0A!")
Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ F106C5C6  บAutor  ณ Tiago Bizan       บ Data ณ  04/24/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o alias referente a tabela e a chave passada por	  บฑฑ
ฑฑบ          ณ parametro                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function F106C5C6(cTab,cChave,alValores)
Local aAreaAtu	:=GetArea()
Local clQuery	:= ""
Local cAliasC5C6	:= "_cAliasC5C6"
Local cAliaC5NUM	:= "_cAliaC5NUM"
Local cPAlias		:= "_cPAlias"
Local clFil		:= ""
Local clNum		:= ""
Local clItem	:= ""
Local clProd	:= ""
Local clDoc		:= ""
Local clSerie	:= ""
Local clForn	:= ""
Local clCli		:= ""
Local clLoja	:= ""
Local llRet		:= .F.
Local cQryC5Num	:= ""
Local cC5Num	:= ""
Local cPProd	:= ""
Local cQry1		:= ""

Default alValores := {}

If cTab == 'SC5'
	
	clFil	:= SUBSTR(cChave,1,TAMSX3("C5_FILIAL")[1])
	clNum	:= SUBSTR(cChave,3,TAMSX3("C5_NUM")[1])
	cTipoPV:=Posicione("SC5",1,xFilial("SC5")+clNum,"C5_TIPO" )
	
	
	clQuery += "	SELECT  A4_YCODWMS,"
	clQuery += "			A4_CGC,"
	clQuery += "			A4_NOME,"
	clQuery += "			C5_FILIAL,"
	clQuery += "			C5_NUM,"
	clQuery += "			C5_XECOMER,"
	clQuery += "			C5_TIPO,"
	clQuery += "			C5_CLIENTE,"
	clQuery += "			C5_LOJACLI,"
	clQuery += "			C5_NOMCLI,"
	clQuery += "			C5_TRANSP,"
	clQuery += "			C5_YCHCROS,"
	clQuery += "			C5_CLIENT,"
	clQuery += "			C5_LOJAENT,"
	clQuery += "			C5_XOPPAC,"
	
	
	If cTipoPV$"D*B"
		clQuery += " A2_CGC 		AS A1_CGC,"
		clQuery += " A2_END 		AS A1_END,"
		clQuery += " A2_CEP 		AS A1_CEP,"
		clQuery += " A2_BAIRRO	AS	A1_BAIRRO,"
		clQuery += " A2_MUN 		AS A1_MUN,"
		clQuery += " A2_EST 		AS  A1_EST,"
		clQuery += " A2_COMPLEM AS A1_COMPLEM,"
		clQuery += " A2_INSCR	AS A1_INSCR,"
		clQuery += " A2_TEL		AS A1_TEL,"
		clQuery += " A2_CONTATO AS A1_CONTATO,"
		clQuery += " A2_NREDUZ  AS	A1_NREDUZ,"
		clQuery += " ' '	AS A1_SUFRAMA,"
		clQuery += " '2'	AS A1_AGEND,"
		clQuery += " '2'	AS A1_XSORTER,"
		clQuery += " '2'	AS A1_TEMODAL,"
		clQuery += " 0    AS A1_YCODWMS,"
	Else
		
		clQuery += "			A1_CGC,"
		clQuery += "			A1_END,"
		clQuery += "			A1_CEP,"
		clQuery += "			A1_BAIRRO,"
		clQuery += "			A1_TEMODAL,"
		clQuery += "			A1_MUN,"
		clQuery += "			A1_EST,"
		clQuery += "			A1_COMPLEM,"
		clQuery += "			A1_INSCR,"
		clQuery += "			A1_TEL,"
		clQuery += "			A1_CONTATO,"
		clQuery += "			A1_SUFRAMA,"
		clQuery += "			A1_AGEND,"
		clQuery += "			A1_XSORTER,"
		clQuery += "			A1_NREDUZ,"
		clQuery += "			A1_YCODWMS,"
	EndIf
	
	clQuery += "			SUM (C9_PRCVEN) C9_PRCVEN,"
	clQuery += "			SUM (C9_QTDLIB) C9_QTDLIB,"
	clQuery += "			SUM (C9_PRCVEN*C9_QTDLIB) C6_VALOR,"
	clQuery += "			SUM (C6_VALOR) C6_TOTAL"
	
	clQuery += "	FROM "+RetSqlName("SC6") + " SC6"
	
	clQuery += "		LEFT OUTER JOIN "+RetSqlName("SC5") + " SC5"
	clQuery += "		ON SC6.C6_FILIAL = SC5.C5_FILIAL"
	clQuery += "		AND SC6.C6_NUM = SC5.C5_NUM"
	clQuery += "		AND SC6.C6_CLI = SC5.C5_CLIENTE"
	clQuery += "		AND SC6.C6_LOJA = SC5.C5_LOJACLI"
	clQuery += "		AND SC5.D_E_L_E_T_ = ' '"
	clQuery += "			LEFT OUTER JOIN "+RetSqlName("SA4") + " SA4"
	clQuery += "			ON SA4.A4_COD = SC5.C5_TRANSP"
	clQuery += "			AND SA4.A4_FILIAL = ' '"
	clQuery += "			AND SA4.D_E_L_E_T_= ' '"
	
	
	If cTipoPV$"D*B"
		clQuery += "		INNER JOIN "+RetSqlName("SA2") + " SA2"
		clQuery += "		ON  SC5.C5_CLIENT = SA2.A2_COD"
		clQuery += "		AND SC5.C5_LOJAENT = SA2.A2_LOJA"
		clQuery += "		AND SA2.D_E_L_E_T_ = ' '"
		
	Else
		clQuery += "		INNER JOIN "+RetSqlName("SA1") + " SA1"
		clQuery += "		ON  SC5.C5_CLIENT = SA1.A1_COD"
		clQuery += "		AND SC5.C5_LOJAENT = SA1.A1_LOJA"
		clQuery += "		AND SA1.D_E_L_E_T_ = ' '"
	EndIf
	
	
	clQuery += "		INNER JOIN "+RetSqlName("SC9") + " SC9"
	clQuery += "		ON SC9.C9_PEDIDO = SC6.C6_NUM"
	clQuery += "		AND SC9.C9_FILIAL = SC6.C6_FILIAL"
	clQuery += "		AND SC9.C9_PRODUTO = SC6.C6_PRODUTO"
	clQuery += "		AND SC9.C9_ITEM = SC6.C6_ITEM"
	clQuery += "		AND SC9.C9_SEQUEN = '01'"
	clQuery += "		AND SC9.D_E_L_E_T_= ' '"
	
	clQuery += "	WHERE SC6.C6_NUM = '"+clNum+"' "
	clQuery += "	AND SC6.C6_FILIAL = '"+clFil+"' "
	clQuery += "	AND SC5.D_E_L_E_T_ = ' '"
	
	clQuery += "	GROUP BY  A4_YCODWMS,"
	clQuery += "	A4_CGC,"
	clQuery += "	A4_NOME,"
	clQuery += "	C5_FILIAL,"
	clQuery += "	C5_NUM,"
	clQuery += "	C5_XECOMER,"
	clQuery += "	C5_TIPO,"
	clQuery += "	C5_CLIENTE,"
	clQuery += "	C5_LOJACLI,"
	clQuery += "	C5_NOMCLI,"
	clQuery += "	C5_TRANSP,"
	clQuery += "	C5_YCHCROS,"
	clQuery += "	C5_CLIENT,"
	clQuery += "	C5_LOJAENT,"
	clQuery += "	C5_XOPPAC,"
	
	If cTipoPV$"D*B"
		clQuery += " A2_CGC,"
		clQuery += " A2_END,"
		clQuery += " A2_CEP,"
		clQuery += " A2_BAIRRO,"
		clQuery += " A2_MUN,"
		clQuery += " A2_EST,"
		clQuery += " A2_COMPLEM,"
		clQuery += " A2_INSCR,"
		clQuery += " A2_TEL,"
		clQuery += " A2_CONTATO,"
		clQuery += " A2_NREDUZ,"
		clQuery += " ' ',"
		clQuery += " '2',"
		clQuery += " '2',"
		clQuery += " '2',"
		clQuery += " ' '"
	Else
		clQuery += " A1_CGC,"
		clQuery += " A1_END,"
		clQuery += " A1_CEP,"
		clQuery += " A1_BAIRRO,"
		clQuery += " A1_TEMODAL,"
		clQuery += " A1_MUN,"
		clQuery += " A1_EST,"
		clQuery += " A1_COMPLEM,"
		clQuery += " A1_INSCR,"
		clQuery += " A1_TEL,"
		clQuery += " A1_CONTATO,"
		clQuery += " A1_SUFRAMA,"
		clQuery += " A1_AGEND,"
		clQuery += " A1_XSORTER,"
		clQuery += " A1_NREDUZ,"
		clQuery += " A1_YCODWMS"
	EndIf
	
ElseIF cTab == 'SC6'
	
	clFil	:= SUBSTR(cChave,1,TAMSX3("C6_FILIAL")[1])
	clNum	:= SUBSTR(cChave,3,TAMSX3("C6_NUM")[1])
	clItem	:= SUBSTR(cChave,9,TAMSX3("C6_ITEM")[1])
	clProd	:= SUBSTR(cChave,11,TAMSX3("C6_PRODUTO")[1])
	
	clQuery := " SELECT C6_FILIAL,C6_NUM,C6_PRODUTO,C6_LOCAL,B1_PESO,B1_PESBRU,B1_TIPO,SUM((C6_PRCVEN*C9_QTDLIB)/(C9_QTDLIB)) C6_PRCVEN,SUM(C9_QTDLIB) C9_QTDLIB,SUM(C6_PRCVEN*C9_QTDLIB) C6_VALOR "
	
	clQuery += " FROM "+RetSqlName("SC6") + " SC6 "
	
	clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1 "
	clQuery += " ON SB1.B1_COD = SC6.C6_PRODUTO "
	clQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
	clQuery += " AND SB1.D_E_L_E_T_= ' ' "
	
	clQuery += " INNER JOIN "+RetSqlName("SC9") + " SC9 "
	clQuery += " ON SC9.C9_PEDIDO = SC6.C6_NUM "
	clQuery += " AND SC9.C9_FILIAL = SC6.C6_FILIAL "
	clQuery += " AND SC9.C9_PRODUTO = SC6.C6_PRODUTO "
	clQuery += " AND SC9.C9_ITEM = SC6.C6_ITEM
	clQuery += " AND SC9.C9_SEQUEN = '01' " //04-09-13 - nใo enviar 2a. libera็ใo do pedido
	clQuery += " AND SC9.D_E_L_E_T_= ' ' "
	
	clQuery += " WHERE SC6.C6_NUM = '"+clNum+"' "
	clQuery += " AND SC6.C6_FILIAL = '"+clFil+"' "
	clQuery += " AND SC6.C6_PRODUTO = '"+clProd+"' "
	clQuery += " AND SC6.D_E_L_E_T_= ' ' "
	
	clQuery += " GROUP BY C6_FILIAL,C6_NUM,C6_PRODUTO,C6_LOCAL,B1_PESO,B1_PESBRU,B1_TIPO "//,C6_PRCVEN,C9_QTDLIB
	
ElseIF cTab == 'SF1'
	
	clFil	:= SUBSTR(cChave,1,TAMSX3("F1_FILIAL")[1])
	clDoc	:= SUBSTR(cChave,3,TAMSX3("F1_DOC")[1])
	clSerie	:= SUBSTR(cChave,12,TAMSX3("F1_SERIE")[1])
	clForn	:= SUBSTR(cChave,15,TAMSX3("F1_FORNECE")[1])
	clLoja	:= SUBSTR(cChave,21,TAMSX3("F1_LOJA")[1])
	clFormul:= SUBSTR(cChave,23,TAMSX3("F1_FORMUL")[1])
	
	clQuery := " SELECT A1_INSCR,F1_ESPECIE ESPECIE,F1_FORMUL,F1_FILIAL,F1_DOC,F1_SERIE,F1_TIPO,F1_EMISSAO,F1_VALBRUT,F1_VALMERC,F1_FORNECE,F1_LOJA,F1_CHVNFE CHVNFE,F1_BASEICM,F1_VALICM,A2_CGC,A1_CGC,A2_NOME,A1_NOME,A2_EST,F1_PBRUTO "
	
	clQuery += " FROM "+RetSqlName("SF1") + " SF1 "
	
	clQuery += " LEFT JOIN "+RetSqlName("SA1") + " SA1 "
	clQuery += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"
	clQuery += " AND SA1.A1_COD = SF1.F1_FORNECE "
	clQuery += " AND SA1.A1_LOJA = SF1.F1_LOJA "
	clQuery += " AND SA1.D_E_L_E_T_ = ' ' "
	
	clQuery += " LEFT JOIN "+RetSqlName("SA2") + " SA2 "
	clQuery += " ON SA2.A2_FILIAL = '"+xFilial("SA2")+"'"
	clQuery += " AND SA2.A2_COD = SF1.F1_FORNECE "
	clQuery += " AND SA2.A2_LOJA = SF1.F1_LOJA "
	clQuery += " AND SA2.D_E_L_E_T_ = ' ' "
	
	clQuery += " WHERE SF1.F1_FILIAL = '"+clFil+"' "
	clQuery += " AND SF1.F1_DOC = '"+clDoc+"' "
	clQuery += " AND SF1.F1_SERIE = '"+clSerie+"' "
	clQuery += " AND SF1.F1_FORNECE = '"+clForn+"' "
	clQuery += " AND SF1.F1_LOJA = '"+clLoja+"' "
	//If clFormul <> "S"
	//clQuery += " AND SF1.F1_FORMUL <> '"+clFormul+"' "
	//Else
	//	clQuery += " AND SF1.F1_FORMUL = '"+clFormul+"' "
	//EndIf
	clQuery += " AND SF1.D_E_L_E_T_ = ' ' "
	
	clQuery += "ORDER BY F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA "
	
ElseIF cTab == 'SD1'
	
	clFil	:= SUBSTR(cChave,1,TAMSX3("D1_FILIAL")[1])
	clDoc	:= SUBSTR(cChave,3,TAMSX3("D1_DOC")[1])
	clSerie	:= SUBSTR(cChave,12,TAMSX3("D1_SERIE")[1])
	clForn	:= SUBSTR(cChave,15,TAMSX3("D1_FORNECE")[1])
	clLoja	:= SUBSTR(cChave,21,TAMSX3("D1_LOJA")[1])
	clItem	:= SUBSTR(cChave,23,TAMSX3("D1_ITEM")[1])
	clFormul:= SUBSTR(cChave,27,TAMSX3("D1_FORMUL")[1])
	
	//busca o c๓digo do produto para envio ao WMS sem duplicar o produto / item, aglutinando as quantidades
	cQry1	:= ""
	cQry1	+= " SELECT D1_COD FROM "+RetSqlName("SD1") + " SD1 WHERE D1_FILIAL = '"+clFil+"'
	cQry1	+= " AND SD1.D1_DOC = '"+clDoc+"'
	cQry1	+= " AND SD1.D1_SERIE = '"+clSerie+"'
	cQry1	+= " AND SD1.D1_FORNECE = '"+clForn+"'
	cQry1	+= " AND SD1.D1_LOJA = '"+clLoja+"'
	cQry1	+= " AND SD1.D1_ITEM = '"+clItem+"'
	//	cQry1	+= " AND SD1.D1_FORMUL = '"+clFormul+"'
	cQry1	+= " AND SD1.D_E_L_E_T_ = ' '
	Iif(Select(cPAlias) > 0,(cPAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry1),cPAlias,.F.,.T.)
	cPProd	:= (cPAlias)->D1_COD
	(cPAlias)->(dbCloseArea())
	
	clQuery := " SELECT SUM(D1_QUANT) D1_QUANT,SUM(D1_TOTAL) D1_TOTAL,SUM(D1_VALICM) D1_VALICM, SUM(D1_TOTAL)/SUM(D1_QUANT) D1_VUNIT,SUM(D1_PICM) D1_PICM,
	clQuery += " D1_TIPO,D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,D1_EMISSAO,B1_PESO,B1_PESBRU,D1_COD,D1_LOCAL,D1_FORMUL,
	clQuery += " F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_FORMUL,ESPECIE, CHVNFE
	clQuery += " FROM (
	clQuery += " SELECT D1_TIPO,D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,D1_EMISSAO,B1_PESO,B1_PESBRU,D1_VUNIT,D1_PICM,D1_COD,D1_LOCAL,D1_FORMUL,
	clQuery += " F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_FORMUL,F1_ESPECIE ESPECIE, F1_CHVNFE CHVNFE ,D1_QUANT,D1_TOTAL,D1_VALICM
	
	clQuery += " FROM "+RetSqlName("SD1") + " SD1
	
	clQuery += " INNER JOIN "+RetSqlName("SF1") + " SF1
	clQuery += " ON SF1.F1_DOC = SD1.D1_DOC
	clQuery += " AND SF1.F1_SERIE = SD1.D1_SERIE
	clQuery += " AND SF1.F1_FILIAL = SD1.D1_FILIAL
	clQuery += " AND SF1.D_E_L_E_T_ = ' '
	clQuery += " AND SF1.F1_FORNECE = SD1.D1_FORNECE "
	clQuery += " AND SF1.F1_LOJA = SD1.D1_LOJA "
	
	clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1
	clQuery += " ON SB1.B1_COD = SD1.D1_COD
	clQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
	clQuery += " AND SB1.D_E_L_E_T_ = ' '
	
	clQuery += " WHERE SD1.D1_FILIAL = '"+clFil+"' "
	clQuery += " AND SD1.D1_DOC = '"+clDoc+"' "
	clQuery += " AND SD1.D1_SERIE = '"+clSerie+"' "
	clQuery += " AND SD1.D1_FORNECE = '"+clForn+"' "
	clQuery += " AND SD1.D1_LOJA = '"+clLoja+"' "
	clQuery += " AND SD1.D1_COD = '"+cPProd+"'
	//If clFormul <> "S"
	//clQuery += " AND SD1.D1_FORMUL <> '"+clFormul+"' "
	//Else
	//	clQuery += " AND SD1.D1_FORMUL = '"+clFormul+"' "
	//EndIf
	clQuery += " AND SD1.D_E_L_E_T_ = ' ' ) A
	clQuery += " GROUP BY D1_TIPO,D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,D1_EMISSAO,B1_PESO,B1_PESBRU,D1_COD,D1_LOCAL,D1_FORMUL,
	clQuery += " F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_FORMUL,ESPECIE, CHVNFE
	
	/*
	clQuery := " SELECT D1_TIPO,D1_ITEM,D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,D1_EMISSAO,B1_PESO,B1_PESBRU,D1_VUNIT,D1_PICM,D1_COD,D1_LOCAL,D1_QUANT,D1_TOTAL,D1_VALICM,D1_FORMUL, "
	clQuery += " F1_FILIAL,F1_DOC,F1_SERIE,F1_FORNECE,F1_LOJA,F1_FORMUL,F1_ESPECIE ESPECIE, F1_CHVNFE CHVNFE "
	
	clQuery += " FROM "+RetSqlName("SD1") + " SD1 "
	
	clQuery += " INNER JOIN "+RetSqlName("SF1") + " SF1 "
	clQuery += " ON SF1.F1_DOC = SD1.D1_DOC "
	clQuery += " AND SF1.F1_SERIE = SD1.D1_SERIE "
	clQuery += " AND SF1.F1_FILIAL = SD1.D1_FILIAL "
	clQuery += " AND SF1.D_E_L_E_T_ = ' ' "
	
	clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1 "
	clQuery += " ON SB1.B1_COD = SD1.D1_COD "
	clQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
	clQuery += " AND SB1.D_E_L_E_T_ = ' ' "
	
	clQuery += " WHERE SD1.D1_FILIAL = '"+clFil+"' "
	clQuery += " AND SD1.D1_DOC = '"+clDoc+"' "
	clQuery += " AND SD1.D1_SERIE = '"+clSerie+"' "
	clQuery += " AND SD1.D1_FORNECE = '"+clForn+"' "
	clQuery += " AND SD1.D1_LOJA = '"+clLoja+"' "
	clQuery += " AND SD1.D1_ITEM = '"+clItem+"' "
	If clFormul <> "S"
	clQuery += " AND SD1.D1_FORMUL <> '"+clFormul+"' "
	Else
	clQuery += " AND SD1.D1_FORMUL = '"+clFormul+"' "
	EndIf
	clQuery += " AND SD1.D_E_L_E_T_ = ' ' "
	*/
ElseIF cTab == 'SF2'
	
	clFil	:= SUBSTR(cChave,1,TAMSX3("F2_FILIAL")[1])
	clDoc	:= SUBSTR(cChave,3,TAMSX3("F2_DOC")[1])
	clSerie	:= SUBSTR(cChave,12,TAMSX3("F2_SERIE")[1])
	clCli	:= SUBSTR(cChave,15,TAMSX3("F2_CLIENTE")[1])
	clLoja	:= SUBSTR(cChave,21,TAMSX3("F2_LOJA")[1])
	
	//	busca numero do pedido de vendas pois nใo necessariamente estarแ no cabe็alho
	
	cQryC5Num:= " SELECT DISTINCT(D2_DOC), D2_FILIAL, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_PEDIDO
	cQryC5Num+= " FROM SD2010
	cQryC5Num+= " WHERE D2_FILIAL = '"+clFil+"'
	cQryC5Num+= " AND D_E_L_E_T_ = ' '
	cQryC5Num+= " AND D2_DOC = '"+clDoc+"' "
	cQryC5Num+= " AND D2_SERIE = '"+clSerie+"' "
	cQryC5Num+= " AND D2_CLIENTE = '"+clCli+"' "
	cQryC5Num+= " AND D2_LOJA = '"+clLoja+"' "
	
	Iif(Select(cAliaC5NUM) > 0,(cAliaC5NUM)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryC5Num),cAliaC5NUM,.F.,.T.)
	
	cC5Num	:= (cAliaC5NUM)->D2_PEDIDO
	
	(cAliaC5NUM)->(dbCloseArea())
	
	
	clQuery := " SELECT F2_TPFRETE,F2_PBRUTO,F2_VOLUME1,F2_TRANSP,A1_INSCR,C5_NUM,C5_XECOMER,F2_ESPECIE ESPECIE,F2_FORMUL,F2_FILIAL,F2_DOC,F2_SERIE,F2_TIPO,F2_EMISSAO,F2_VALBRUT,F2_VALMERC,F2_CLIENTE,
	clQuery += " F2_LOJA,F2_CHVNFE CHVNFE,F2_BASEICM,F2_VALICM,A2_CGC,A1_CGC,A2_NOME,A1_NOME,A2_EST,A1_EST,A1_CEP,A2_CEP,A1_END,A2_END,A1_BAIRRO,A2_BAIRRO,A1_MUN,A2_MUN, C5_YCHCROS, C5_YTRANS, "
	clQuery += " F2_CLIENT, F2_LOJENT,C5_XOPPAC
	
	clQuery += " FROM "+RetSqlName("SF2") + " SF2 "
	
	clQuery += " INNER JOIN "+RetSqlName("SC5") + " SC5 "
	clQuery += " ON SC5.C5_FILIAL = SF2.F2_FILIAL "
	clQuery += " AND SC5.C5_NUM = '"+cC5Num+"' "
	//	clQuery += " AND SC5.C5_NOTA = SF2.F2_DOC "
	//	clQuery += " AND SC5.C5_SERIE = SF2.F2_SERIE "
	//	clQuery += " AND SC5.C5_CLIENTE = SF2.F2_CLIENTE "
	//	clQuery += " AND SC5.C5_LOJACLI = SF2.F2_LOJA "
	clQuery += " AND SC5.D_E_L_E_T_ = ' ' "
	
	clQuery += " LEFT JOIN "+RetSqlName("SA1") + " SA1 "
	clQuery += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"
	clQuery += " AND SA1.A1_COD = SF2.F2_CLIENT "
	clQuery += " AND SA1.A1_LOJA = SF2.F2_LOJENT "
	clQuery += " AND SA1.D_E_L_E_T_ = ' ' "
	
	clQuery += " LEFT JOIN "+RetSqlName("SA2") + " SA2 "
	clQuery += " ON SA2.A2_FILIAL = '"+xFilial("SA2")+"'"
	clQuery += " AND SA2.A2_COD = SF2.F2_CLIENTE "
	clQuery += " AND SA2.A2_LOJA = SF2.F2_LOJA "
	clQuery += " AND SA2.D_E_L_E_T_ = ' ' "
	
	clQuery += " WHERE SF2.F2_FILIAL = '"+clFil+"' "
	clQuery += " AND SF2.F2_DOC = '"+clDoc+"' "
	clQuery += " AND SF2.F2_SERIE = '"+clSerie+"' "
	clQuery += " AND SF2.F2_CLIENTE = '"+clCli+"' "
	clQuery += " AND SF2.F2_LOJA = '"+clLoja+"' "
	clQuery += " AND SF2.D_E_L_E_T_ = ' ' "
ElseIf cTab == 'SD2'
	
	clFil	:= SUBSTR(cChave,1,TAMSX3("D2_FILIAL")[1])
	clDoc	:= SUBSTR(cChave,3,TAMSX3("D2_DOC")[1])
	clSerie	:= SUBSTR(cChave,12,TAMSX3("D2_SERIE")[1])
	clForn	:= SUBSTR(cChave,15,TAMSX3("D2_CLIENTE")[1])
	clLoja	:= SUBSTR(cChave,21,TAMSX3("D2_LOJA")[1])
	clItem	:= SUBSTR(cChave,23,TAMSX3("D2_ITEM")[1])
	
	//busca o c๓digo do produto para envio ao WMS sem duplicar o produto / item, aglutinando as quantidades
	cQry1	:= ""
	cQry1	+= " SELECT D2_COD FROM "+RetSqlName("SD2") + " SD2 WHERE D2_FILIAL = '"+clFil+"'
	cQry1	+= " AND SD2.D2_DOC = '"+clDoc+"'
	cQry1	+= " AND SD2.D2_SERIE = '"+clSerie+"'
	cQry1	+= " AND SD2.D2_CLIENTE = '"+clForn+"'
	cQry1	+= " AND SD2.D2_LOJA = '"+clLoja+"'
	cQry1	+= " AND SD2.D2_ITEM = '"+clItem+"'
	cQry1	+= " AND SD2.D_E_L_E_T_ = ' '
	Iif(Select(cPAlias) > 0,(cPAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry1),cPAlias,.F.,.T.)
	cPProd	:= (cPAlias)->D2_COD
	(cPAlias)->(dbCloseArea())
	
	clQuery := " SELECT SUM(D2_ICMSRET) D2_ICMSRET, SUM(D2_QUANT) D2_QUANT,SUM(D2_TOTAL) D2_TOTAL,
	clQuery += " SUM(D2_VALICM) D2_VALICM, SUM(D2_VALIPI) D2_VALIPI,
	clQuery += " SUM(D2_VALFRE) D2_VALFRE, SUM(D2_SEGURO) D2_SEGURO,SUM(D2_DESPESA) D2_DESPESA,
	clQuery += " D2_PEDIDO,D2_TIPO,D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,
	clQuery += " B1_PESO,B1_PESBRU,D2_PICM,D2_COD,D2_LOCAL,F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,
	clQuery += " F2_LOJA,F2_FORMUL,ESPECIE, CHVNFE,B1_XDESC,B1_PESBRU, F2_CLIENT, F2_LOJENT,
	clQuery += " B1_ALT,B1_LARGURA,B1_PROF
	clQuery += " FROM
	clQuery += " (SELECT D2_ICMSRET,D2_PEDIDO,D2_TIPO,D2_ITEM,D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,B1_PESO,B1_PESBRU,D2_PICM,D2_COD,D2_LOCAL,D2_QUANT,D2_TOTAL,D2_VALICM,
	clQuery += " F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_FORMUL,F2_ESPECIE ESPECIE, F2_CHVNFE CHVNFE,B1_XDESC,D2_VALIPI,D2_VALFRE,D2_SEGURO,D2_DESPESA,F2_CLIENT,F2_LOJENT,B1_ALT,B1_LARGURA,B1_PROF 
	clQuery += " FROM "+RetSqlName("SD2") + " SD2
	
	clQuery += " INNER JOIN "+RetSqlName("SF2") + " SF2
	clQuery += " ON SF2.F2_DOC = SD2.D2_DOC
	clQuery += " AND SF2.F2_SERIE = SD2.D2_SERIE
	clQuery += " AND SF2.F2_FILIAL = SD2.D2_FILIAL
	clQuery += " AND SF2.D_E_L_E_T_ = ' '
	
	clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1
	clQuery += " ON SB1.B1_COD = SD2.D2_COD
	clQuery += " AND SB1.B1_FILIAL = ' '
	clQuery += " AND SB1.D_E_L_E_T_ = ' '
	
	clQuery += " WHERE SD2.D2_FILIAL = '"+clFil+"' "
	clQuery += " AND SD2.D2_DOC = '"+clDoc+"' "
	clQuery += " AND SD2.D2_SERIE = '"+clSerie+"' "
	clQuery += " AND SD2.D2_CLIENTE = '"+clForn+"' "
	clQuery += " AND SD2.D2_LOJA = '"+clLoja+"' "
	clQuery += " AND SD2.D2_COD = '"+cPProd+"'
	clQuery += " AND SD2.D_E_L_E_T_ = ' ' ) A
	
	clQuery += " GROUP BY D2_PEDIDO,D2_TIPO,D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,
	clQuery += " B1_PESO,B1_PESBRU,D2_PICM,D2_COD,D2_LOCAL,F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,
	clQuery += " F2_LOJA,F2_FORMUL,ESPECIE,CHVNFE,B1_XDESC,B1_PESBRU,F2_CLIENT,F2_LOJENT,B1_ALT,B1_LARGURA,B1_PROF "
	
	/*
	clQuery := " SELECT D2_ICMSRET,D2_PEDIDO,D2_TIPO,D2_ITEM,D2_FILIAL,D2_DOC,D2_SERIE,D2_CLIENTE,D2_LOJA,D2_EMISSAO,B1_PESO,B1_PESBRU,D2_PICM,D2_COD,D2_LOCAL,D2_QUANT,D2_TOTAL,D2_VALICM, "
	clQuery += " F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_FORMUL,F2_ESPECIE ESPECIE, F2_CHVNFE CHVNFE,B1_XDESC,B1_PESBRU,D2_VALIPI,D2_VALFRE,D2_VALFRE,D2_VALFRE,D2_SEGURO,D2_DESPESA "
	
	clQuery += " FROM "+RetSqlName("SD2") + " SD2 "
	
	clQuery += " INNER JOIN "+RetSqlName("SF2") + " SF2 "
	clQuery += " ON SF2.F2_DOC = SD2.D2_DOC "
	clQuery += " AND SF2.F2_SERIE = SD2.D2_SERIE "
	clQuery += " AND SF2.F2_FILIAL = SD2.D2_FILIAL "
	clQuery += " AND SF2.D_E_L_E_T_ = ' ' "
	
	clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1 "
	clQuery += " ON SB1.B1_COD = SD2.D2_COD "
	clQuery += " AND SB1.B1_FILIAL = '"+xFilial("SA2")+"'"
	clQuery += " AND SB1.D_E_L_E_T_ = ' ' "
	
	clQuery += " WHERE SD2.D2_FILIAL = '"+clFil+"' "
	clQuery += " AND SD2.D2_DOC = '"+clDoc+"' "
	clQuery += " AND SD2.D2_SERIE = '"+clSerie+"' "
	clQuery += " AND SD2.D2_CLIENTE = '"+clForn+"' "
	clQuery += " AND SD2.D2_LOJA = '"+clLoja+"' "
	clQuery += " AND SD2.D2_ITEM = '"+clItem+"' "
	clQuery += " AND SD2.D_E_L_E_T_ = ' ' "
	*/
	
ElseIF cTab == 'SA4'
	clFil	:= SUBSTR(cChave,1,TAMSX3("A4_FILIAL")[1])
	clTransp:= SUBSTR(cChave,3,TAMSX3("A4_COD")[1])
	
	clQuery := " SELECT A4_YCODWMS,A4_COD,A4_NOME,A4_CGC "
	
	clQuery += " FROM "+RetSqlName("SA4") + " SA4 "
	
	clQuery += " WHERE SA4.A4_FILIAL = '"+clFil+"' "
	clQuery += " AND SA4.A4_COD = '"+clTransp+"' "
	clQuery += " AND SA4.D_E_L_E_T_ = ' ' "
	
ElseIf cTab == 'RNV'
	If alValores[1] == "E"
		clQuery := " SELECT F1_FORMUL,F1_LOJA,F1_FORNECE,F1_FILIAL,F1_DOC,F1_SERIE,F1_EMISSAO,F1_VALBRUT,F1_VOLUME1,F1_TPFRETE,F1_CHVNFE,F1_TIPO,F1_ESPECIE,F1_TRANSP, "
		clQuery += " A1_CGC,A2_CGC,A1_CEP,A2_CEP,A1_EST,A2_EST,A1_NOME,A2_NOME,A1_INSCR,A2_INSCR,A1_END,A2_END,A1_BAIRRO,A2_BAIRRO,A1_MUN,A2_MUN, F1_PBRUTO,"
		clQuery += " D1_COD,D1_QUANT,B1_XDESC,B1_PESBRU,D1_TOTAL,D1_VALIPI,D1_VALFRE,D1_ICMSRET,D1_SEGURO,D1_DESPESA,D1_PEDIDO "
		
		clQuery += " FROM "+RetSqlName("SF1") + " SF1 "
		
		clQuery += " INNER JOIN "+RetSqlName("SD1") + " SD1 "
		clQuery += " ON SD1.D1_DOC = SF1.F1_DOC "
		clQuery += " AND SD1.D1_SERIE = SF1.F1_SERIE "
		clQuery += " AND SD1.D_E_L_E_T_ = ' ' "
		clQuery += " AND SF1.F1_FORNECE = SD1.D1_FORNECE "
		clQuery += " AND SF1.F1_LOJA = SD1.D1_LOJA "
		
		clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1 "
		clQuery += " ON SB1.B1_COD = SD1.D1_COD "
		clQuery += " AND SB1.D_E_L_E_T_ = ' ' "
		clQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
		clQuery += " AND SB1.D_E_L_E_T_ = ' ' "
		
		clQuery += " LEFT JOIN "+RetSqlName("SA1") + " SA1 "
		clQuery += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"
		clQuery += " AND SA1.A1_COD = SF1.F1_FORNECE "
		clQuery += " AND SA1.A1_LOJA = SF1.F1_LOJA "
		clQuery += " AND SA1.D_E_L_E_T_ = ' ' "
		
		clQuery += " LEFT JOIN "+RetSqlName("SA2") + " SA2 "
		clQuery += " ON SA2.A2_FILIAL = '"+xFilial("SA2")+"'"
		clQuery += " AND SA2.A2_COD = SF1.F1_FORNECE "
		clQuery += " AND SA2.A2_LOJA = SF1.F1_LOJA "
		clQuery += " AND SA2.D_E_L_E_T_ = ' ' "
		
		clQuery += " WHERE SF1.D_E_L_E_T_ = ' ' "
		clQuery += " AND SF1.F1_FILIAL = '"+alValores[2]+"' "
		clQuery += " AND SF1.F1_DOC = '"+alValores[3]+"' "
		clQuery += " AND SF1.F1_SERIE = '"+alValores[4]+"' "
		clQuery += " AND SF1.F1_FORNECE = '"+alValores[5]+"' "
		clQuery += " AND SF1.F1_LOJA = '"+alValores[6]+"' "
		clQuery += " AND SD1.D1_COD = '"+alValores[7]+"' "
		
	Else
		clQuery := " SELECT A1_CGC,A2_CGC,A1_CEP,A2_CEP,A1_EST,A2_EST,A1_NOME,A2_NOME,A1_INSCR,A2_INSCR,A1_END,A2_END,A1_BAIRRO,A2_BAIRRO,A1_MUN,A2_MUN,"
		clQuery += " D2_QUANT,D2_COD,D2_TOTAL,D2_VALIPI,D2_VALFRE,D2_ICMSRET,D2_SEGURO,D2_DESPESA,B1_XDESC,B1_PESBRU "
		
		clQuery += " FROM "+RetSqlName("SF2") + " SF2 "
		
		clQuery += " INNER JOIN "+RetSqlName("SD2") + " SD2 "
		clQuery += " ON SD2.D2_DOC = SF2.F2_DOC "
		clQuery += " AND SD2.D2_SERIE = SF2.F2_SERIE "
		clQuery += " AND SD2.D_E_L_E_T_ = ' ' "
		clQuery += " AND SD2.D2_FILIAL = SF2.F2_FILIAL "
		clQuery += " AND SD2.D_E_L_E_T_ = ' ' "
		
		clQuery += " INNER JOIN "+RetSqlName("SB1") + " SB1 "
		clQuery += " ON SB1.B1_COD = SD2.D2_COD "
		clQuery += " AND SB1.D_E_L_E_T_ = ' ' "
		clQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
		clQuery += " AND SB1.D_E_L_E_T_ = ' ' "
		
		clQuery += " LEFT JOIN "+RetSqlName("SA1") + " SA1 "
		clQuery += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"
		clQuery += " AND SA1.A1_COD = SF2.F2_CLIENT "
		clQuery += " AND SA1.A1_LOJA = SF2.F2_LOJENT "
		clQuery += " AND SA1.D_E_L_E_T_ = ' ' "
		
		clQuery += " LEFT JOIN "+RetSqlName("SA2") + " SA2 "
		clQuery += " ON SA2.A2_FILIAL = '"+xFilial("SA2")+"'"
		clQuery += " AND SA2.A2_COD = SF2.F2_CLIENTE "
		clQuery += " AND SA2.A2_LOJA = SF2.F2_LOJA "
		clQuery += " AND SA2.D_E_L_E_T_ = ' ' "
		
		clQuery += " WHERE SF2.D_E_L_E_T_ = ' ' "
		clQuery += " AND SF2.F2_FILIAL = '"+alValores[2]+"' "
		clQuery += " AND SF2.F2_DOC = '"+alValores[3]+"' "
		clQuery += " AND SF2.F2_SERIE = '"+alValores[4]+"' "
		clQuery += " AND SF2.F2_CLIENTE = '"+alValores[5]+"' "
		clQuery += " AND SF2.F2_LOJA = '"+alValores[6]+"' "
		clQuery += " AND SF2.D_E_L_E_T_ = ' ' "
		
		clQuery += " ORDER BY D2_ITEM "
	EndIF
	
EndIF

Iif(Select(cAliasC5C6) > 0,(cAliasC5C6)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAliasC5C6,.F.,.T.)

If (cAliasC5C6)->(!EOF())
	llRet := .T.
EndIF





RestArea(aAreaAtu)
Return({llRet,cAliasC5C6})

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ F106RETIND   บAutor  ณ Tiago Bizan  	 บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o numero do indice da tabela passada por parametro บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function F106RETIND(cTab,cIndex)
Local nlRet	:= 0

DbSelectArea("SIX")
SIX->(dbSetOrder(1))

SIX->(dbSeek(cTab))
While SIX->(!EOF())
	If AllTrim(SIX->CHAVE) == AllTrim(cIndex)
		nlRet := val(SIX->ORDEM)
		EXIT
	EndIF
	SIX->(DBSkip())
EndDO
Return(nlRet)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0106VAL   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Transforme para caracter									  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function E0106VAL(xlVal)

Local xlRet

If ValType(xlVal) == "C"
	xlVal	:= E0106CHR(xlVal)
	xlRet	:=	"'" + Iif(Len(xlVal)==0,Space(1),xlVal)  + "'"
ElseIf ValType(xlVal) == "N"
	xlRet	:=	AllTrim(Str(xlVal))
ElseIf ValType(xlVal) == "D"
	xlRet	:=	"'" + dTos(xlVal) + "'"
EndIf

Return(xlRet)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0106CHR   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retira os caracteres especiais							  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function E0106CHR(clComChar)
Local clSemChar		:=	clComChar

clSemChar	:=	 StrTran(clSemChar,"'","")
clSemChar	:=	 StrTran(clSemChar,'"',"")
clSemChar	:=	 StrTran(clSemChar,"ด","")
clSemChar	:=	 StrTran(clSemChar,"`","")

Return(clSemChar)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0106SAH   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza a tabela de Unidade de Medidas(SAH), somente com  บฑฑ
ฑฑบ          ณ os novos registros, as altera็๕es serใo importadas atraves บฑฑ
ฑฑบ          ณ da tabela P0A							                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function E0106SAH(lJob,cEmp,cFil)
Local clQuery	:= ""
Local cAlias	:= GetNextAlias()
Local clTabWMS	:= ""
Local alCmpChave:= {}
Local alValChave:= {}
Local alCampos	:= {}

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(cEmp,cFil)
		
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		
		Return()
		
	EndIf
EndIF

clQuery := " SELECT * FROM "+RetSqlName("SAH") + " SAH "
clQuery += " WHERE D_E_L_E_T_ = ' ' "

Conout("Selecionando Unidades de Medidas")
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

If (cAlias)->(!EOF())
	
	//DELETA A TABELA DE UNIDADE DE MEDIDA PARA INSERIR OS REGISTROS NOVAMENTE
	Conout("Excluindo tabela Unidade de Medida!")
	clQuery := U_EXESQL105(4,,,"TB_WMSINTERF_UNIDADE_MEDIDA")
	
	If !Empty(clQuery)
		If TcSqlExec(clQuery) >= 0
			TcSqlExec("COMMIT")
		EndIf
	EndIf
	
	alCampos := U_F105RETCMP("SAH",.T.)
	ConOut("Inserindo registros de Unidades de Medidas.")
	While (cAlias)->(!EOF())
		
		alValInc := U_F105RETCMP("SAH",.F.,@clTabWMS,@alCmpChave,@alValChave,cAlias)
		
		If !U_E0105EXT(clTabWMS, alCmpChave, alValChave )
			clQuery := U_EXESQL105(1,alCampos,alValInc,clTabWMS)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				EndIf
			EndIf
		Else
			If (cAlias)->R_E_C_D_E_L_ > 0
				clQuery := U_EXESQL105(3,alCampos,alValInc,clTabWMS,alCmpChave,alValChave)
				
				If !Empty(clQuery)
					If TcSqlExec(clQuery) >= 0
						TcSqlExec("COMMIT")
					EndIf
				EndIf
			EndIF
			
		EndIF
		(cAlias)->(DBSkip())
	EndDO
EndIF
ConOut("Finalizando rotina de Unidades de Medidas!")

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0106SX5   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza a tabela de Armazens							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function E0106SX5(lJob,cEmp,cFil)
Local clQuery	:= ""
Local cAlias	:= GetNextAlias()
Local clTabWMS	:= ""
Local alCmpChave:= {}
Local alValChave:= {}
Local alCampos	:= {}
Local clArmz	:= ""

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(cEmp,cFil)
		
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		
		Return()
		
	EndIf
EndIF

clArmz := SuperGetMV("MV_ARMWMAS")

clQuery := " SELECT X5_CHAVE , " + CRLF
clQuery += " X5_DESCRI, " + CRLF
clQuery += " X5_TABELA " + CRLF
clQuery += " FROM "+RetSqlName("SX5") + " SX5	" + CRLF

clQuery += " WHERE SX5.D_E_L_E_T_ = ' ' " + CRLF
clQuery += " AND SX5.X5_TABELA = 'ZZ' " + CRLF
clQuery += " AND SX5.X5_CHAVE IN " + FORMATIN(clArmz,"/")
clQuery += " ORDER BY X5_CHAVE " + CRLF

Conout("Selecionando Armazens")
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

If (cAlias)->(!EOF())
	
	//DELETA A TABELA DE ARMAZENS PARA INSERIR OS REGISTROS NOVAMENTE
	Conout("Excluindo tabela de Armazens!")
	clQuery := U_EXESQL105(4,,,'TB_WMSINTERF_TIPO_ESTOQUE')
	
	If !Empty(clQuery)
		If TcSqlExec(clQuery) >= 0
			TcSqlExec("COMMIT")
		EndIf
	EndIf
	
	alCampos := U_F105RETCMP("ZZ",.T.)
	Conout("Inserindo regsitros na tabela de Armazens!")
	While (cAlias)->(!EOF())
		
		alValInc := U_F105RETCMP("ZZ",.F.,@clTabWMS,@alCmpChave,@alValChave,cAlias)
		
		clQuery := U_EXESQL105(1,alCampos,alValInc,clTabWMS)
		
		If !Empty(clQuery)
			If TcSqlExec(clQuery) >= 0
				TcSqlExec("COMMIT")
			EndIf
		EndIf
		
		(cAlias)->(DBSkip())
	EndDO
EndIF
Conout("Finalizando rotina de Armazens!")
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FTROCAEST  บAutor  ณ Tiago Bizan      บ Data ณ  22/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_WMSINTERF_TROCA_TP_ESTOQUEบฑฑ
ฑฑบ          ณ e realizar as trasnferencias ou a libera็ใo de CQ dentro doบฑฑ
ฑฑบ          ณ protheus            										  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FTROCAEST(lJob,cEmp,cFil)

Local clQuery	:= ""
Local cAlias	:= GetNextAlias()
Local cAliasSD7	:= GetNextAlias()
Local cAliasSD1	:= GetNextAlias()
Local clQrySD1	:= ""
Local clTabWMS	:= ""
Local alCmpChave:= {}
Local alValChave:= {}
Local clFil		:= ""
Local clNum		:= ""
Local clUsrBD	:= ""
Local llCnt		:= .F.
Local clQrySD7	:= ""
Local cSeqZero	:= '001'
Local nSaldo	:= 0
Local nSaldo2	:= 0
Local nSOBRA	:= 0
Local llAtuStatus:= .F.
Local clLocal	:= ""

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(cEmp,cFil)
		
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		
		Return()
		
	EndIf
EndIF

clUsrBD	:= SuperGetMV("NCG_000019")
clLocal	:= SupergetMV("MV_CQ")

Conout("Iniciando rotina para troca de estoque - WMS")


clQuery := " SELECT "
clQuery += " BDE_COD_DEPOSITO, "
clQuery += " BDE_COD_DEPOSITANTE Filial, "
clQuery += " BDE_COD_TIPO_ESTOQUE_ORIGEM Origem, "
clQuery += " BDE_COD_TIPO_ESTOQUE_DESTINO Destino, "
clQuery += " BDE_COD_PRODUTO Prod, "
clQuery += " BDE_SEQ, "
clQuery += " DPCE_COD_CHAVE, "
clQuery += " TO_CHAR(DT_ADD,'DD/MM/YYYY HH24:MI:SS') DDATA, "
clQuery += " SUM(BDE_QTDE) QUANT "

clQuery += " FROM "+clUsrBD+".TB_WMSINTERF_TROCA_TP_ESTOQUE "

clQuery += " WHERE STATUS IN ('NP') "

clQuery += " And BDE_COD_TIPO_ESTOQUE_ORIGEM<>0"

clQuery += " GROUP BY BDE_COD_DEPOSITO,BDE_COD_DEPOSITANTE,BDE_COD_TIPO_ESTOQUE_ORIGEM,BDE_COD_TIPO_ESTOQUE_DESTINO, "
clQuery += " BDE_COD_PRODUTO,DPCE_COD_CHAVE,BDE_SEQ,DT_ADD "

clQuery += " ORDER BY DT_ADD "
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

If (cAlias)->(!EOF())
	
	DBSelectArea("SF1")
	SF1->(DBSetOrder(1))
	
	DBSelectArea("SB1")
	SB1->(DBSetOrder(1))
	
	alCampos1	:= {}
	aadd(alCampos1,"STATUS")
	aadd(alCampos1,"DESC_ERRO")
	
	alCmpChave	:= {}
	aadd(alCmpChave,"BDE_COD_DEPOSITO")
	aadd(alCmpChave,"BDE_COD_DEPOSITANTE")
	aadd(alCmpChave,"BDE_COD_PRODUTO")
	aadd(alCmpChave,"BDE_COD_TIPO_ESTOQUE_ORIGEM")
	aadd(alCmpChave,"BDE_COD_TIPO_ESTOQUE_DESTINO")
	aadd(alCmpChave,"DPCE_COD_CHAVE")
	aadd(alCmpChave,"BDE_SEQ")
	aadd(alCmpChave,"DT_ADD")
	
	clTabWMS := "TB_WMSINTERF_TROCA_TP_ESTOQUE"
	
	cDocAux		:= ""
	cSerieAux	:= ""
	
	While (cAlias)->(!EOF())
		
		alValChave := {}
		aadd(alValChave,1)
		aadd(alValChave,(cAlias)->FILIAL)
		aadd(alValChave,ALLTRIM((cAlias)->PROD))
		aadd(alValChave,(cAlias)->ORIGEM)
		aadd(alValChave,(cAlias)->DESTINO)
		aadd(alValChave,ALLTRIM((cAlias)->DPCE_COD_CHAVE) )
		aadd(alValChave,(cAlias)->BDE_SEQ)
		//clData := "TO_DATE('"+(cAlias)->DDATA+"' "+",'DD/MM/YYYY HH24:MI:SS')"
		clData := "TO_DATE('"+(cAlias)->DDATA+"'	,'DD/MM/YYYY HH24:MI:SS')"
		aadd(alValChave,clData)
		
		clProd		:= PADR(ALLTRIM((cAlias)->PROD),TAMSX3("B2_COD")[1])
		clLocOrig	:= STRZERO((cAlias)->ORIGEM,2)
		clLocDest	:= STRZERO((cAlias)->DESTINO,2)
		nlQtd		:= (cAlias)->QUANT
		
		clFil		:= SUBSTR((cAlias)->DPCE_COD_CHAVE,1,TAMSX3("F1_FILIAL")[1])
		If Empty(clFil)
			clFil	:= strzero((cAlias)->FILIAL,2)
		EndIf
		clDoc		:= SUBSTR((cAlias)->DPCE_COD_CHAVE,3,TAMSX3("F1_DOC")[1])
		clSerie		:= SUBSTR((cAlias)->DPCE_COD_CHAVE,12,TAMSX3("F1_SERIE")[1])
		clForn      := SUBSTR((cAlias)->DPCE_COD_CHAVE,15,TAMSX3("F1_FORNECE")[1])
		clLoja		:= SUBSTR((cAlias)->DPCE_COD_CHAVE,21,TAMSX3("F1_LOJA")[1])
		
		If AllTrim(clLocDest) $ GETMV("MV_ARMWMAS")
			clTipo := 1
		Else
			clTipo := 2
		EndIf
		
		
		IF SF1->(MsSeek(clFil+clDoc+clSerie+clForn+clLoja) )
			IF SB1->(MsSeek( xFilial("SB1") + clProd))
				
				clTipoDoc 	:= SF1->F1_EST
				clDesc		:= ALLTRIM(SB1->B1_XDESC)
				clUn		:= SB1->B1_UM
				
				//  Verifica a existencia dos locais de origem e destino.
				//  Caso o local de destino nใo exista, a rotina cria.
				DBSelectArea("SB2")
				SB2->(DBSetOrder(1))
				
				If !SB2->(DBSeek(clFil+clProd+clLocOrig ))
					Conout("Local de Origem nใo encontrado no Protheus. A transferencia do produto: "+ALLTRIM(clProd)+" e local: "+ALLTRIM(clLocOrig)+" nใo ocorrerแ" )
					llCnt := .F.
				Else
					If !SB2->(DBSeek(clFil+clProd+clLocDest ))
						If RecLock("SB2",.T.)
							SB2->B2_FILIAL  := clFil
							SB2->B2_COD     := clProd
							SB2->B2_LOCAL   := clLocDest
							SB2->(Msunlock())
						EndIf
					EndIF
					llCnt := .T.
				EndIf
				
				If llCnt
					//SE LOCAL DE ORIGEM FOR IGUAL AO PARAMETRO "MV_CQ" DEVE GERAR A LIBERAวรO DE CQ
					IF clLocOrig == clLocal  // clTipoDoc == "EX"
						If clLocOrig <> clLocDest
							alReg1 := u_FtrocaCQ(clFil,clDoc,clSerie,clForn,clLoja,clProd,clLocal,nlQtd,clLocDest,@llAtuStatus) //Chama fun็ใo para libera็ใo do CQ
						Else
							alReg1 := {}
							aadd(alReg1,"P")
							aadd(alReg1,"")
							llAtuStatus	:= .T.
						EndIF
					Else
						//CASO OS LOCAIS DE ORIGEM E DESTINO SEJAM OS MESMOS, O REGSITRO NAO SERม PROCESSADO E O SEU STATUS SERม ALTERADO PARA "P"
						If clLocOrig <> clLocDest
							// Cabe็alho a Incluir
							aTransf := {}
							DBSelectArea("SD3")
							clDcmento := NextNumero("SD3",2,"D3_DOC",.T.)
							clDcmento := A261RetINV(clDcmento)
							
							aadd(aTransf,{clDcmento,dDataBase})
							
							aItem := {}
							// Itens a Incluir
							aadd(aItem,clProd)   				// D3_COD
							aadd(aItem,clDesc)                  // D3_DESCRI
							aadd(aItem,clUn)					// D3_UM
							aadd(aItem,clLocOrig)               // D3_LOCAL
							aadd(aItem,SPACE(15))	     	    // D3_LOCALIZ
							aadd(aItem,clProd) 	                // D3_COD
							aadd(aItem,clDesc)     			    // D3_DESCRI
							aadd(aItem,clUn)  	                // D3_UM
							aadd(aItem,clLocDest)              	// D3_LOCAL
							aadd(aItem,SPACE(15))			    // D3_LOCALIZ
							aadd(aItem,SPACE(20))          	   	// D3_NUMSERI
							aadd(aItem,SPACE(10))		 	    // D3_LOTECTL
							aadd(aItem,SPACE(06))       	    // D3_NUMLOTE
							aadd(aItem,Ctod("  /  /  "))	    // D3_DTVALID
							aadd(aItem,0.00)				    // D3_POTENCI
							aadd(aItem,nlQtd) 	                // D3_QUANT
							aadd(aItem,0.00)				    // D3_QTSEGUM
							aadd(aItem,SPACE(01)) 			    // D3_ESTORNO
							aadd(aItem,SPACE(06))     		    // D3_NUMSEQ
							aadd(aItem,SPACE(10))			    // D3_LOTECTL
							aadd(aItem,Ctod("  /  /  "))   	   	// D3_DTVALID
							aadd(aItem,space(03))           	// D3_ITEMGRD
							aadd(aTransf,aItem)
							
							lMsErroAuto := .F.
							
							MSExecAuto({|x,y| MATA261(x,y)},aTransf,3)
							
							If !lMsErroAuto
								Conout("Trasferencia incluida - Filial: "+clFil+" Doc.: "+clDoc+" Prod.: "+clProd+" Orig.: "+clLocOrig+" Dest.: "+clLocDest)
								alReg1 := {}
								aadd(alReg1,"P")
								aadd(alReg1,"")
								llAtuStatus	:= .T.
							Else
								If lJob
									Conout("Erro na Trasferencia - Filial: "+clFil+" Doc.: "+clDoc+" Prod.: "+clProd+" Orig.: "+clLocOrig+" Dest.: "+clLocDest)
									clMemo := ""
									clMemo := AllTrim(MemoRead(NomeAutoLog()))
									clMemo := StrTran(clMemo,Chr(13) + Chr(10)," ")
									
									MemoWrite(NomeAutoLog()," ")
									
									alReg1 := {}
									aadd(alReg1,"ER")
									aadd(alReg1,"ERRO:"+Left(clMemo,240))
									llAtuStatus	:= .T.
								Else
									MostraErro()
								EndIF
							EndIF
						Else
							alReg1 := {}
							aadd(alReg1,"P")
							aadd(alReg1,"")
							llAtuStatus	:= .T.
						EndIF
					Endif
				EndIF
			EndIF
		ElseIf clLocOrig <> clLocDest
			
			SB1->(DBGoTOP())
			IF SB1->(DBSeek( xFilial("SB1") + clProd))
				
				clTipoDoc 	:= SF1->F1_EST
				clDesc		:= ALLTRIM(SB1->B1_XDESC)
				clUn		:= SB1->B1_UM
				
				//  Verifica a existencia dos locais de origem e destino.
				//  Caso o local de destino nใo exista, a rotina cria.
				DBSelectArea("SB2")
				SB2->(DBSetOrder(1))
				
				If !SB2->(DBSeek(clFil+clProd+clLocOrig ))
					Conout("Local de Origem nใo encontrado no Protheus. A transferencia do produto: "+ALLTRIM(clProd)+" e local: "+ALLTRIM(clLocOrig)+" nใo ocorrerแ" )
					llCnt := .F.
				Else
					If !SB2->(DBSeek(clFil+clProd+clLocDest ))
						If RecLock("SB2",.T.)
							SB2->B2_FILIAL  := clFil
							SB2->B2_COD     := clProd
							SB2->B2_LOCAL   := clLocDest
							SB2->(Msunlock())
						EndIf
					EndIF
					llCnt := .T.
				EndIf
				If llCnt
					// Cabe็alho a Incluir
					aTransf := {}
					DBSelectArea("SD3")
					clDcmento := NextNumero("SD3",2,"D3_DOC",.T.)
					clDcmento := A261RetINV(clDcmento)
					
					aadd(aTransf,{clDcmento,dDataBase})
					
					aItem := {}
					// Itens a Incluir
					aadd(aItem,clProd)   				// D3_COD
					aadd(aItem,clDesc)                  // D3_DESCRI
					aadd(aItem,clUn)					// D3_UM
					aadd(aItem,clLocOrig)               // D3_LOCAL
					aadd(aItem,SPACE(15))	     	    // D3_LOCALIZ
					aadd(aItem,clProd) 	                // D3_COD
					aadd(aItem,clDesc)     			    // D3_DESCRI
					aadd(aItem,clUn)  	                // D3_UM
					aadd(aItem,clLocDest)              	// D3_LOCAL
					aadd(aItem,SPACE(15))			    // D3_LOCALIZ
					aadd(aItem,SPACE(20))          	   	// D3_NUMSERI
					aadd(aItem,SPACE(10))		 	    // D3_LOTECTL
					aadd(aItem,SPACE(06))       	    // D3_NUMLOTE
					aadd(aItem,Ctod("  /  /  "))	    // D3_DTVALID
					aadd(aItem,0.00)				    // D3_POTENCI
					aadd(aItem,nlQtd) 	                // D3_QUANT
					aadd(aItem,0.00)				    // D3_QTSEGUM
					aadd(aItem,SPACE(01)) 			    // D3_ESTORNO
					aadd(aItem,SPACE(06))     		    // D3_NUMSEQ
					aadd(aItem,SPACE(10))			    // D3_LOTECTL
					aadd(aItem,Ctod("  /  /  "))   	   	// D3_DTVALID
					aadd(aItem,space(03))           	// D3_ITEMGRD
					aadd(aTransf,aItem)
					
					lMsErroAuto := .F.
					
					MSExecAuto({|x,y| MATA261(x,y)},aTransf,3)
					
					If !lMsErroAuto
						Conout("Trasferencia incluida - Filial: "+clFil+" Doc.: "+clDoc+" Prod.: "+clProd+" Orig.: "+clLocOrig+" Dest.: "+clLocDest)
						alReg1 := {}
						aadd(alReg1,"P")
						aadd(alReg1,"")
						llAtuStatus	:= .T.
					Else
						If lJob
							Conout("Erro na Trasferencia - Filial: "+clFil+" Doc.: "+clDoc+" Prod.: "+clProd+" Orig.: "+clLocOrig+" Dest.: "+clLocDest)
							clMemo := ""
							clMemo := AllTrim(MemoRead(NomeAutoLog()))
							clMemo := StrTran(clMemo,Chr(13) + Chr(10)," ")
							
							MemoWrite(NomeAutoLog()," ")
							
							alReg1 := {}
							aadd(alReg1,"ER")
							aadd(alReg1,"ERRO:"+Left(clMemo,240))
							llAtuStatus	:= .T.
						Else
							MostraErro()
						EndIF
					EndIf
				EndIF
			EndIf
		Else
			alReg1 := {}
			aadd(alReg1,"ER")
			aadd(alReg1,"ERRO: Documento nใo encontrado - Filial: "+clFil+" Doc.: "+clDoc+" Serie: "+clSerie+" Forn: "+clForn)
			llAtuStatus := .T.
		EndIF
		
		If llAtuStatus
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
			If  "AND DPCE_COD_CHAVE = ' '" $ clQuery
				clQuery	:= strtran(clQuery,"AND DPCE_COD_CHAVE = ' '","AND DPCE_COD_CHAVE IS NULL")
			EndIf
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				EndIf
			EndIf
		EndIF
		(cAlias)->(DBSkip())
	EndDO
Else
	Conout("Nใo hแ Transfer๊ncias de Estoque a serem realizadas")
EndIF

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FFRTSSE2	  บAutor  ณ Tiago Bizan      บ Data ณ  12/03/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_FRTINTERFFATURAS e gera็ใoบฑฑ
ฑฑบ          ณ do Contas a Pagar - SE2							          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FFRTSSE2(lJob,cEmp,cFil) //(alParam) // U_FFRTSSE2()

Local cAlias	:= GetNextAlias()
Local clUsrBD	:= ""
Local clQuery	:= ""
Local alCabec	:= {}
Local llFretes	:= .T.
Local llAtuStatus:= .F.

Local cWMSUsrFRE:=	""
Local cNaturez	:=	""
//Default alParam := {.F.,'01','03'}

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	RpcSetType(3)
	If !RpcSetEnv(cEmp,cFil)
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		Return()
	EndIf
EndIF

clUsrBD	:= SuperGetMV("NCG_000033")
cWMSUsrFRE	:= U_MyNewSX6(	"MV_WFWMSFR", ;
"fafonso@ncgames.com.br;jisidoro@ncgames.com.br", ;
"C", ;
"E-mail de usr que recebem avisos do fretes",;
"E-mail de usr que recebem avisos do fretes",;
"E-mail de usr que recebem avisos do fretes",;
.F. )
cNaturez	:=	U_MyNewSX6(	"NCG_100011",;
"234",;
"C",;
"Natureza para ser utilizada na inclusใo do tํtulo a pagar da fatura do frete",;
"Natureza para ser utilizada na inclusใo do tํtulo a pagar da fatura do frete",;
"Natureza para ser utilizada na inclusใo do tํtulo a pagar da fatura do frete",;
.F. )


Conout("Iniciando rotina para gera็ใo de titulos a pagar - WMS")

clQuery := " SELECT * "
clQuery += " FROM "+clUsrBD+".TB_FRTINTERFFATURAS "
clQuery += " WHERE STATUS = 'NP' "

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(DBGoTop())

DBSelectArea("SA4")
SA4->(DbOrderNickName("CODWMS"))

If (cAlias)->(!EOF())
	
	alCampos1	:= {}
	//		alReg1		:= {}
	alCmpChave	:= {}
	//		alValChave	:= {}
	
	aadd(alCampos1,"STATUS")
	aadd(alCampos1,"DESC_ERRO")
	clTabWMS := "TB_FRTINTERFFATURAS"
	
	aadd(alCmpChave,"NUM_FATURAS")
	aadd(alCmpChave,"SERIE")
	aadd(alCmpChave,"CODIGO_TRANSPORTADOR")
	
	While (cAlias)->(!EOF())
		
		alValChave := {}
		aadd(alValChave,alltrim((cAlias)->NUM_FATURAS))
		aadd(alValChave,alltrim((cAlias)->SERIE))
		aadd(alValChave,alltrim((cAlias)->CODIGO_TRANSPORTADOR))
		
		SA4->(DBGoTop())
		//SA4->(DBSeek(xFilial("SA4")+STRZERO(val((cAlias)->CODIGO_TRANSPORTADOR),TAMSX3("A4_COD")[1])))
		SA4->(DBSeek(xFilial("SA4")+Str(val((cAlias)->CODIGO_TRANSPORTADOR),TAMSX3("A4_YCODWMS")[1],0)))
		//		   	Str(val((cAlias)->CODIGO_TRANSPORTADOR),TAMSX3("A4_YCODWMS")[1],0)
		cTransp := SA4->A4_COD
		
		If Empty(SA4->A4_YFORNEC) .or. Empty(SA4->A4_YFORNEC)
			Conout("[FFRTSSE2] Codigo ou Loja do fornecedor nใo estแ cadastrado na transportadora: "+cTransp)
			clErro	:= ""
			IF !U_MySndMail("[WMS INOVATECH] Revisar cadastro da transportadora "+cTransp,;
				"A integra็ใo de Fatura e conhecimento de fretes estใo solicitando o complemento do cadastro da transportadora  "+cTransp+". O c๓digo do fornecedor nใo estแ preenchido!",;
				{},;
				cWMSUsrFRE,;
				"",;
				clErro)
				Conout("Erro ao tentar enviar o e-mail.")
			Else
				Conout("Finalizando rotina para libera็ใo de PV com sucesso - WMS")
			EndIF
			
			(cAlias)->(DBSkip())
			loop
		EndIf
		
		clPrefix	:= "FRE"
		clNum		:= substr((cAlias)->NUM_FATURAS,1,9)
		clParcela	:= substr((cAlias)->NUM_FATURAS,10,1)
		clTipo		:= "BOL"
		clFornec	:= SA4->A4_YFORNEC //Posicione("SA4",1,xFilial("SA4")+cTransp,"A4_YFORNEC")
		clLoja		:= SA4->A4_YLOJA //Posicione("SA4",1,xFilial("SA4")+cTransp,"A4_YLOJA")
		clNaturez	:= alltrim(cNaturez) //"234" // Posicione("SA2",1,xFilial("SA2")+clFornec+clLoja,"A2_NATUREZ")
		nlValor		:= (cAlias)->VALOR
		nlDecresc	:= (cAlias)->DESCONTO
		nlAcresc	:= (cAlias)->ACRESCIMO
		dlVencto	:= ctod((cAlias)->VENCIMENTO )
		dlVencReal	:= DATAVALIDA(dlVencto)
		dEmissao	:= ctod((cAlias)->DATA_EMISSAO )
		
		alCabec:= {}
		AAdd( alCabec, { "E2_PREFIXO", clPrefix			, NIL 	})
		AAdd( alCabec, { "E2_NUM"    , clNum			, NIL 	})
		AADD( alCabec, { "E2_PARCELA", clParcela		, NIL	})
		AAdd( alCabec, { "E2_NATUREZ", clNaturez		, NIL 	})
		AAdd( alCabec, { "E2_TIPO"   , clTipo			, NIL 	})
		AAdd( alCabec, { "E2_FORNECE", clFornec 		, NIL 	})
		AAdd( alCabec, { "E2_LOJA"	 , clLoja			, NIL 	})
		AAdd( alCabec, { "E2_VALOR"	 , nlValor			, NIL 	})
		AAdd( alCabec, { "E2_EMISSAO", dEmissao			, NIL 	})
		AAdd( alCabec, { "E2_VENCTO" , dlVencto			, NIL 	})
		AAdd( alCabec, { "E2_VENCREA", dlVencReal		, NIL 	})
		AAdd( alCabec, { "E2_DECRESC", nlDecresc		, NIL 	})
		AAdd( alCabec, { "E2_ACRESC" , nlAcresc			, NIL 	})
		AAdd( alCabec, { "E2_LA"     , "S"				, NIL 	})
		
		lMsErroAuto := .F.
		
		MSExecAuto({|x, y| FINA050(x, y)}, alCabec, 3)
		
		If !lMsErroAuto
			Conout("Titulo incluํdo - Num: "+clNum+" Prefixo: "+clPrefix+" Parcela: "+clParcela+" Tipo: "+clTipo+" Forn.: "+clFornec)
			alReg1 := {}
			aadd(alReg1,"P")
			aadd(alReg1,"")
			llAtuStatus	:= .T.
		Else
			If lJob //alParam[1]
				Conout("Erro na Inclusใo do Titulo - Num: "+clNum+" Prefixo: "+clPrefix+" Parcela: "+clParcela+" Tipo: "+clTipo+" Forn.: "+clFornec)
				clMemo := ""
				clMemo := AllTrim(MemoRead(NomeAutoLog()))
				clMemo := StrTran(clMemo,Chr(13) + Chr(10)," ")
				
				MemoWrite(NomeAutoLog()," ")
				
				alReg1 := {}
				aadd(alReg1,"R")
				aadd(alReg1,"ERRO:"+SUBSTR(clMemo,len(clMemo)-250,250))
				llAtuStatus	:= .T.
			else
				MostraErro()
			EndIF
		EndIF
		
		If llAtuStatus
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,llFretes)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				Else
					TcSqlExec("ROLLBACK")
				EndIf
			EndIf
		EndIF
		
		(cAlias)->(DBSkip())
	EndDO
EndIF

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FTRSSC5	  บAutor  ณ Tiago Bizan      บ Data ณ  13/03/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_FRTINTERF_DOC_SAIDA_TRASNPบฑฑ
ฑฑบ          ณ e atualizar o codigo da transportadora no Pedido Venda	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FTRSSC5(cFil,cPed,cChvCros,nYCodWMSA4,cStatus,cFilEnv)

Local cAlias		:= GetNextAlias()
Local clUsrBD		:= ""
Local clQuery		:= ""
Local alCabec		:= {}
Local llAtuStatus	:= .F.
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore:=(cFilAnt$cFilStore)

Default cStatus:='FR'
Default cFilEnv:=""

clUsrBD	:= SuperGetMV("NCG_000019")

Conout("Iniciando rotina para atualiza็ใo da transportadora no Pedido de Venda - WMS")

clQuery := " SELECT TRS_COD_DEPOSITANTE,TRS_NUM_DOCUMENTO,TRS_COD_TRANSPORADOR, TRS_DOC_CROSS "+CRLF
clQuery += " FROM "+clUsrBD+".TB_FRTINTERF_DOC_SAIDA_TRANSP "+CRLF
clQuery += " WHERE TRS_NUM_DOCUMENTO = '"+cPed+"' "+CRLF
clQuery += " AND TRS_COD_DEPOSITANTE = "+alltrim(str(cFil))+CRLF

If !Empty(cFilEnv)
	clQuery += " AND Exists ( Select 'x' From "+clUsrBD+".TB_WMSINTERF_DOC_SAIDA Where DPCS_COD_CHAVE LIKE '"+cFilEnv+"%' And DPCS_NUM_DOCUMENTO = TRS_NUM_DOCUMENTO)"
EndIf
//clQuery += " AND STATUS = '"+cStatus+"'"

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(DBGoTop())

If (cAlias)->(!EOF())
	
	DBSelectArea("SC5")
	SC5->(DBSetOrder(1))
	
	DBSelectArea("SA4")
	//SA4->(DBSetOrder(1))
	SA4->(DbOrderNickName("CODWMS"))
	
	alCampos1	:= {}
	alReg1		:= {}
	alCmpChave	:= {}
	alValChave	:= {}
	
	aadd(alCampos1,"STATUS")
	aadd(alCampos1,"DESC_ERRO")
	clTabWMS := "TB_FRTINTERF_DOC_SAIDA_TRANSP"
	
	aadd(alCmpChave,"TRS_COD_DEPOSITANTE")
	aadd(alCmpChave,"TRS_NUM_DOCUMENTO")
	
	While (cAlias)->(!EOF())
		aadd(alValChave,(cAlias)->TRS_COD_DEPOSITANTE)
		aadd(alValChave,ALLTRIM((cAlias)->TRS_NUM_DOCUMENTO))
		If alltrim((cAlias)->TRS_DOC_CROSS) == "S"
			clFil := substr((cAlias)->TRS_NUM_DOCUMENTO,1,2)
			clNum := substr((cAlias)->TRS_NUM_DOCUMENTO,3,6)
		Else
			clFil := STRZERO((cAlias)->TRS_COD_DEPOSITANTE,TAMSX3("A4_FILIAL")[1])
			If !Empty(cFilEnv)
				clFil:=cFilEnv
			EndIf
			clNum := ALLTRIM((cAlias)->TRS_NUM_DOCUMENTO)
		EndIf
		
		SC5->(DBGoTop())
		If SC5->(DBSeek(clFil+clNum))
			SA4->(DBGoTop())
			//SA4->( DBSeek(xFilial("SA4")+STRZERO((cAlias)->TRS_COD_TRANSPORADOR,TAMSX3("A4_COD")[1]) ) )
			//			If SA4->( DBSeek(xFilial("SA4")+ALLTRIM(STR((cAlias)->TRS_COD_TRANSPORADOR)) ) )
			If EMPTY(nYCodWMSA4)
				If SA4->( DBSeek(xFilial("SA4")+ALLTRIM(STR((cAlias)->TRS_COD_TRANSPORADOR)) ) )
					If RecLock("SC5",.F.)
						SC5->C5_YTRANSP:=SC5->C5_TRANSP
						SC5->C5_TRANSP := SA4->A4_COD
						alReg1 := {}
						aadd(alReg1,"PR")
						aadd(alReg1,"")
						llAtuStatus := .T.
						SC5->(MSUnlock())
					EndIF
				Else
					alReg1 := {}
					aadd(alReg1,"ER")
					aadd(alReg1,"Transportadora nใo encontrada: "+STRZERO((cAlias)->TRS_COD_TRANSPORADOR,TAMSX3("A4_COD")[1]) )
					//				aadd(alReg1,"Transportadora nใo encontrada: "+STRZERO(nYCodWMSA4,TAMSX3("A4_COD")[1]) )
					llAtuStatus := .T.
				EndIF
			ELSE
				
				If SA4->( DBSeek(xFilial("SA4")+ALLTRIM(STR(nYCodWMSA4)) ) ) //alterado em 09/03/2014 - projeto PAC
					If RecLock("SC5",.F.)
						SC5->C5_YTRANSP:=SC5->C5_TRANSP
						SC5->C5_TRANSP := SA4->A4_COD
						alReg1 := {}
						aadd(alReg1,"PR")
						aadd(alReg1,"")
						llAtuStatus := .T.
						SC5->(MSUnlock())
					EndIF
				Else
					alReg1 := {}
					aadd(alReg1,"ER")
					//				aadd(alReg1,"Transportadora nใo encontrada: "+STRZERO((cAlias)->TRS_COD_TRANSPORADOR,TAMSX3("A4_COD")[1]) )
					aadd(alReg1,"Transportadora nใo encontrada: "+STRZERO(nYCodWMSA4,TAMSX3("A4_COD")[1]) )
					llAtuStatus := .T.
				EndIF
			EndIF
		Else
			Conout("Pedido de venda nใo encontrado. Filial: "+clFil+" Pedido: "+clNum)
			alReg1 := {}
			aadd(alReg1,"ER")
			aadd(alReg1,"Pedido de venda nใo encontrado. Filial: "+clFil+" Pedido: "+clNum)
			llAtuStatus := .T.
		EndIF
		
		If llAtuStatus
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				Else
					TcSqlExec("ROLLBACK")
				EndIf
			EndIf
		EndIF
		
		(cAlias)->(DBSkip())
	EndDO
EndIF
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FFRTSISF1	  บAutor  ณ Tiago Bizan    Data ณ  13/03/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_FRTINTERFFATURAS_ITENS    บฑฑ
ฑฑบ          ณ gerar as tabelas SF1 e SD1								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FFRTSISF1(lJob,cEmp,cFil) //(alParam)

Local cAlias		:= GetNextAlias()
Local cAliasEmi		:= GetNextAlias()
Local clUsrBD		:= ""
Local clQuery		:= ""
Local cQry			:= ""
Local cUFDest		:= ""
Local alCabec		:= {}
Local llAtuStatus	:= .F.
Local lVerSF1		:= .F.
Local aItens		:= {}
local aSF1			:= {}
Local aSD1			:= {}
Local lUseUFDest	:= .F.



Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	RpcSetType(3)
	If !RpcSetEnv(cEmp,cFil)
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		Return()
	EndIf
EndIF

/*Default alParam := {.F.,'01','03'}

If alParam[1]
RpcSetType(3)
If !RpcSetEnv(alParam[2],alParam[3])
ConOut("Nao foi possivel iniciar a empresa e filial !")
Return()
EndIf
EndIF
*/
clUsrBD	:= SuperGetMV("NCG_000033")
lUseUFDest	:= SuperGetMV("NCG_000000")

Conout("Iniciando rotina Nota Fiscal Entrada - Fretes")

//	clQuery := " SELECT NUM_FATURAS,SERIE_FATURA,DATA as EMISSAO,CODIGO_TRANSPORTADOR,VALOR_CONHECIMENTO,VALOR_PEDAGIO "
clQuery := " SELECT A.NUM_FATURAS, A.CONHECIMENTO,A.SERIE_CONHECIMENTO,A.DATA as DTDIGIT,A.CODIGO_TRANSPORTADOR,A.VALOR_CONHECIMENTO,A.VALOR_PEDAGIO, "
clQuery += " A.DATA as EMISSAO "
//clQuery += " CASE WHEN B.DTEMI_CONHECIMENTOEMBARCADOS IS NULL THEN '' ELSE TO_CHAR(B.DTEMI_CONHECIMENTOEMBARCADOS,'DD/MM/YYYY') END EMISSAO "
//clQuery += " B.DTEMI_CONHECIMENTOEMBARCADOS as EMISSAO "
clQuery += " FROM "+clUsrBD+".TB_FRTINTERFFATURAS_ITENS A LEFT OUTER JOIN "+clUsrBD+".TB_FRTCONHECIMENTOEMBARCADOS B "
clQuery += " ON(A.CODIGO_TRANSPORTADOR = B.COD_TRANSPORTADOR AND A.CONHECIMENTO = B.NUM_CONHECIMENTOEMBARCADOS "
clQuery += " AND A.SERIE_CONHECIMENTO = B.SERIE_CONHECIMENTOEMBARCADOS) "
clQuery += " WHERE A.STATUS = 'NP' "
clQuery:= ChangeQuery(clQuery)
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(DBGoTop())

If (cAlias)->(!EOF())
	
	alCampos1	:= {}
	alReg1		:= {}
	alCmpChave	:= {}
	
	aadd(alCampos1,"STATUS")
	aadd(alCampos1,"DESC_ERRO")
	clTabWMS := "TB_FRTINTERFFATURAS_ITENS"
	
	aadd(alCmpChave,"NUM_FATURAS") //adicionado em 3/12/13
	//	aadd(alCmpChave,"SERIE_FATURA")
	aadd(alCmpChave,"CONHECIMENTO")
	aadd(alCmpChave,"SERIE_CONHECIMENTO")
	aadd(alCmpChave,"CODIGO_TRANSPORTADOR")
	
	DBselectArea("SB1")
	SB1->(DBSetOrder(1))
	
	DBSelectArea("SA4")
	SA4->(DbOrderNickName("CODWMS"))
	
	While (cAlias)->(!EOF())
		
		alValChave	:= {}
		aSF1		:= {}
		aItens		:= {}
		aSD1		:= {}
		cUFDest	:= ""
		
		//Verifica็ใo do CNPJ Emitente	*********************************************INICIO
		cQry := " SELECT DISTINCT(CONHECIMENTO) CONHEC, SERIE_CONHECIMENTO,
		cQry += " CODIGO_TRANSPORTADOR,
		cQry += " CASE WHEN CNPJ_EMISSOR IS NULL THEN ' ' ELSE CNPJ_EMISSOR END CNPJEMI,
		cQry += " CASE WHEN UF_DESTINO IS NULL THEN ' ' ELSE UF_DESTINO END UF_DESTINO
		cQry += " FROM "+clUsrBD+".TB_FRTINTERFFATURAS_ITENS_NOTA
		cQry += " WHERE CONHECIMENTO = '"+alltrim((cAlias)->CONHECIMENTO)+"'
		cQry += " AND SERIE_CONHECIMENTO = '"+alltrim((cAlias)->SERIE_CONHECIMENTO)+"'
		cQry += " AND CODIGO_TRANSPORTADOR = '"+alltrim((cAlias)->CODIGO_TRANSPORTADOR)+"'
		cQry += " AND (CNPJ_EMISSOR = '"+Alltrim(SM0->M0_CGC)+"' OR CNPJ_EMISSOR IS NULL)
		Iif(Select(cAliasEmi) > 0,(cAliasEmi)->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasEmi  ,.F.,.T.)
		//para os conhecimentos anteriores เ cria็ใo dos campos CNPJ_EMISSOR e UF_DESTINO
		If Empty((cAliasEmi)->CNPJEMI) .and. Alltrim(SM0->M0_CGC) == "01455929000330"
			//continua
		Else
			If !(Alltrim((cAliasEmi)->CNPJEMI) == Alltrim(SM0->M0_CGC))
				//se o emitente for diferente do SM0->M0_CGC
				(cAliasEmi)->(dbCloseArea())
				
				(cAlias)->(DBSkip())
				loop
			Else
				If lUseUFDest
					cUFDest	:= (cAliasEmi)->UF_DESTINO
				EndIf
			EndIf
		EndIf
		(cAliasEmi)->(dbCloseArea())
		//Verifica็ใo do CNPJ Emitente	************************************************FIM
		
		
		aadd(alValChave,ALLTRIM((cAlias)->NUM_FATURAS)) //adicionado em 3/12/13
		//aadd(alValChave,ALLTRIM((cAlias)->SERIE_FATURA))
		aadd(alValChave,ALLTRIM((cAlias)->CONHECIMENTO))
		aadd(alValChave,ALLTRIM((cAlias)->SERIE_CONHECIMENTO))
		aadd(alValChave,ALLTRIM((cAlias)->CODIGO_TRANSPORTADOR ))
		
		SA4->(DBGoTop())
		//	SA4->(DBSeek(xFilial("SA4")+STRZERO(val((cAlias)->CODIGO_TRANSPORTADOR),TAMSX3("A4_COD")[1])))
		SA4->(DBSeek(xFilial("SA4")+Str(val((cAlias)->CODIGO_TRANSPORTADOR),TAMSX3("A4_YCODWMS")[1],0)))
		cTransp := SA4->A4_COD
		If Empty(SA4->A4_YFORNEC) .or. Empty(SA4->A4_YFORNEC)
			Conout("Codigo ou Loja do fornecedor nใo estแ cadastrado na transportadora: "+cTransp)
			(cAlias)->(DBSkip())
			loop
		EndIf
		
		cTipo		:= "N"
		cFormul		:= "N"
		cNFiscal	:= strzero(val((cAlias)->CONHECIMENTO),9)
		cSerie		:= ALLTRIM(UPPER((cAlias)->SERIE_CONHECIMENTO))
		If cSerie == "0" .or. cSerie == "00" .or. cSerie == "000"
			cSerie := ""
		EndIf
		dDEmissao	:= Stod((cAlias)->EMISSAO)
		cFornec		:= SA4->A4_YFORNEC //Posicione("SA4",1,xFilial("SA4")+cTransp,"A4_YFORNEC")
		cLoja		:= SA4->A4_YLOJA //Posicione("SA4",1,xFilial("SA4")+cTransp,"A4_YLOJA")
		cEspecie	:= "CTE"
		
		
		
		AAdd(aSF1,{"F1_TIPO"	,padr(cTipo,tamsx3("F1_TIPO")[1])			,Nil})
		AAdd(aSF1,{"F1_FORMUL"	,padr(cFormul,tamsx3("F1_FORMUL")[1])		,Nil})
		AAdd(aSF1,{"F1_DOC"		,padr(cNFiscal,tamsx3("F1_DOC")[1])		,Nil})
		AAdd(aSF1,{"F1_SERIE"	,padr(cSerie,tamsx3("F1_SERIE")[1])			,Nil})
		AAdd(aSF1,{"F1_EMISSAO"	,dDEmissao		,Nil})
		AAdd(aSF1,{"F1_FORNECE"	,padr(cFornec,tamsx3("F1_FORNECE")[1])		,Nil})
		AAdd(aSF1,{"F1_LOJA"	,padr(cLoja,tamsx3("F1_LOJA")[1])			,Nil})
		AAdd(aSF1,{"F1_ESPECIE"	,padr(cEspecie,tamsx3("F1_ESPECIE")[1])		,Nil})
		If lUseUFDest .and. !Empty(cUFDest)
			AAdd(aSF1,{"F1_EST"	,cUFDest		,Nil})
		EndIf
		
		cPrefix		:= "FRE"
		cNum		:= PADR(substr((cAlias)->NUM_FATURAS,1,9),TAMSX3("E2_NUM")[1] )
		cParcela	:= PADR(substr((cAlias)->NUM_FATURAS,10,1),TAMSX3("E2_PARCELA")[1])
		cTipo		:= "BOL"
		cXFatFre	:= xFilial("SE2")+cPrefix+cNum+cParcela+cTipo
		AAdd(aSF1,{"F1_XFATFRE"	,padr(cXFatFre,tamsx3("F1_XFATFRE")[1])		,Nil})
		AAdd(aSF1,{"F1_XFORFRE"	,padr(cFornec+cLoja,tamsx3("F1_XFORFRE")[1])	,Nil})
		
		cProd	:= ALLTRIM(SuperGetMV("NCG_000034"))
		SB1->(DBGoTop())
		SB1->(DBSeek(xFilial("SB1")+cProd ))
		
		//REALIZA A INCLUSAO DO PRODUTO DO TIPO FRETES
		cItem	:= STRZERO(1,TAMSX3("D1_ITEM")[1])
		cUnid	:= SB1->B1_UM
		nQtd	:= 1
		vValUn	:= ( (cAlias)->VALOR_CONHECIMENTO-(cAlias)->VALOR_PEDAGIO )
		nValTot	:= ( (cAlias)->VALOR_CONHECIMENTO-(cAlias)->VALOR_PEDAGIO )
		cLocal	:= SB1->B1_LOCPAD
		
		AAdd(aItens,{"D1_ITEM"		, cItem		,Nil})
		AAdd(aItens,{"D1_COD"		, cProd		,Nil})
		AAdd(aItens,{"D1_UM"		, cUnid		,Nil})
		AAdd(aItens,{"D1_QUANT"		, nQtd		,Nil})
		AAdd(aItens,{"D1_VUNIT"		, vValUn	,Nil})
		AAdd(aItens,{"D1_TOTAL"		, nValTot	,Nil})
		AAdd(aItens,{"D1_LOCAL"		, cLocal	,Nil})
		
		AAdd(aSD1,aItens)
		If (cAlias)->VALOR_PEDAGIO > 0
			aItens := {}
			//REALIZA A INCLUSAO DO PRODUTO DO TIPO PEDAGIO
			cProd	:= ALLTRIM(SuperGetMV("NCG_000035"))
			SB1->(DBGoTop())
			SB1->(DBSeek(xFilial("SB1")+cProd ))
			
			cItem	:= STRZERO(2,TAMSX3("D1_ITEM")[1])
			cUnid	:= SB1->B1_UM
			nQtd	:= 1
			vValUn	:= (cAlias)->VALOR_PEDAGIO
			nValTot	:= (cAlias)->VALOR_PEDAGIO
			cLocal	:= SB1->B1_LOCPAD
			
			AAdd(aItens,{"D1_ITEM"		, cItem		,Nil})
			AAdd(aItens,{"D1_COD"		, cProd		,Nil})
			AAdd(aItens,{"D1_UM"			, cUnid		,Nil})
			AAdd(aItens,{"D1_QUANT"		, nQtd		,Nil})
			AAdd(aItens,{"D1_VUNIT"		, vValUn	,Nil})
			AAdd(aItens,{"D1_TOTAL"		, nValTot	,Nil})
			AAdd(aItens,{"D1_LOCAL"		, cLocal	,Nil})
			
			AAdd(aSD1,aItens)
		EndIF
		
		Private lMSHelpAuto := .F.
		Private lMsErroAuto := .F.
		
		//CONSULTA A TABELA SF1 PARA VERIFICAR SE EXISTE O CONHECIMENTO LANวADO OU NรO
		lVerSF1	:= FRTSF1CONS(xFilial("SF1"),cNFiscal,cSerie,cFornec,cLoja)
		If !lVerSF1
			
			MSExecAuto({|x,y,z| MATA140(x,y,z)},aSF1,aSD1,3)
			
			If !lMsErroAuto
				Conout("Pr้-Nota incluํda - Num: "+cNFiscal+" Prefixo: "+cSerie)
				alReg1 := {}
				aadd(alReg1,"P")
				aadd(alReg1,"")
				//				llAtuStatus	:= .T.
				llAtuStatus	:= FRTSF1CONS(xFilial("SF1"),cNFiscal,cSerie,cFornec,cLoja)
				
				
			Else
				If lJob //alParam[1]
					Conout("Erro na Inclusใo de Pr้-Nota - Num: "+cNFiscal+" Prefixo: "+cSerie)
					clMemo := ""
					clMemo := AllTrim(MemoRead(NomeAutoLog()))
					clMemo := StrTran(clMemo,Chr(13) + Chr(10)," ")
					
					MemoWrite(NomeAutoLog()," ")
					
					alReg1 := {}
					aadd(alReg1,"ER")
					aadd(alReg1,"ERRO:"+SUBSTR(clMemo,len(clMemo)-250,250))
					llAtuStatus	:= .T.
				else
					MostraErro()
				EndIF
			EndIF
		Else
			If lJob //alParam[1]
				Conout("Conhecimento existente no Protheus - Num: "+cNFiscal+" Prefixo: "+cSerie)
				clMemo := ""
				alReg1 := {}
				aadd(alReg1,"ER")
				aadd(alReg1,"ERRO: Conhecimento existente no Protheus - Num: "+cNFiscal+" Prefixo: "+cSerie)
				llAtuStatus	:= .T.
			else
				//				alert("ERRO: Conhecimento existente no Protheus - Num: "+cNFiscal+" Prefixo: "+cSerie)
				alReg1 := {}
				aadd(alReg1,"ER")
				aadd(alReg1,"ERRO: Conhecimento existente no Protheus - Num: "+cNFiscal+" Prefixo: "+cSerie)
			EndIF
			
		EndIf
		If llAtuStatus
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,.T.)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				EndIf
			EndIf
		EndIF
		
		(cAlias)->(DBSkip())
	EndDO
EndIF

Return()

//Fun็ใo para consultar se a nota fiscal jแ existe no Protheus
Static Function FRTSF1CONS(cXFilial,cNFiscal,cSerie,cFornec,cLoja)

Local aArea	:= GetArea()
Local aAreaSF1	:= SF1->(GetArea())
Local lRet	:= .F.


DbSelectArea("SF1")
DbSetOrder(1)
If SF1->(DbSeek(PADR(cXFilial,tamsx3("F1_FILIAL")[1])+PADR(cNFiscal,tamsx3("F1_DOC")[1])+PADR(cSerie,tamsx3("F1_SERIE")[1])+PADR(cFornec,tamsx3("F1_FORNECE")[1])+PADR(cLoja,tamsx3("F1_LOJA")[1])))
	lRet	:= .T.
Else
	lRet	:= .F.
EndIf


RestArea(aAreaSF1)
RestArea(aArea)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FRETBAIXA  บAutor  ณ Tiago Bizan	     บ Data ณ  04/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_WMSINTERF_CONF_BAIXA e	  บฑฑ
ฑฑบ          ณ atualiza็ใo das informa็๕es de Data Saida e Hora Libera็ใo บฑฑ
ฑฑบ          ณ na tabela SZ1											  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FRETBAIXA(lJob,cEmp,cFil)
Local cAlias		:= GetNextAlias()
Local clUsrBD		:= ""
Local clQuery		:= ""

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(cEmp,cFil)
		
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		
		Return()
		
	EndIf
EndIF

clUsrBD	:= SuperGetMV("NCG_000019")

Conout("Iniciando rotina Retorno de Baixas - WMS")

clQuery := "SELECT CB_COD_DEPOSITANTE,CB_NUM_PEDIDO,CB_SERIE_PEDIDO,CB_DATA_HORA_BAIXA,CB_COD_CHAVE_TRANS
clQuery += " FROM "+clUsrBD+".TB_WMSINTERF_CONF_BAIXA"
clQuery += " WHERE STATUS = 'NP' "

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(DBGoTop())

If (cAlias)->(!EOF())
	
	DBSelectArea("SZ1")
	SZ1->(DBSetOrder(2))
	
	alCampos1	:= {}
	alCmpChave	:= {}
	
	aadd(alCampos1,"STATUS")
	aadd(alCampos1,"DESC_ERRO")
	
	clTabWMS := "TB_WMSINTERF_CONF_BAIXA"
	
	aadd(alCmpChave,"CB_COD_DEPOSITANTE")
	aadd(alCmpChave,"CB_NUM_PEDIDO")
	aadd(alCmpChave,"CB_SERIE_PEDIDO")
	
	While (cAlias)->(!EOF())
		
		clPed := SUBSTR((cAlias)->CB_NUM_PEDIDO,5,6)
		clFil := STRZERO((cAlias)->CB_COD_DEPOSITANTE,TAMSX3("C5_FILIAL")[1])
		
		alReg1		:= {}
		alValChave	:= {}
		
		aadd(alValChave,(cAlias)->CB_COD_DEPOSITANTE)
		aadd(alValChave,ALLTRIM((cAlias)->CB_NUM_PEDIDO))
		aadd(alValChave,ALLTRIM((cAlias)->CB_SERIE_PEDIDO))
		
		SZ1->(DBGoTop())
		IF SZ1->( DBSeek(clFil+clPed) )
			If RecLock("SZ1",.F.)
				SZ1->Z1_DTSAIDA	:= ctod((cAlias)->CB_DATA_HORA_BAIXA)
				If Empty(SZ1->Z1_HORALB)
					SZ1->Z1_HORALB	:= TIME()
				EndIf
				If Empty(SZ1->Z1_STATUS)
					SZ1->Z1_STATUS	:= "A"
				EndIf
				SZ1->(MSUnlock())
				
				nRecPZ1:=0
				If !IsInCallStack("U_NCGJ001") .And. U_M001TemPV(clFil,clPed,1,@nRecPZ1)
					PZ1->(DbGoTo(nRecPZ1))
					U_M001PZ1Grv("GRAVA_DATA_EXPEDICAO",,,,,,,,,,,SZ1->Z1_DTSAIDA,,,,,,)
				EndIf
				
				alReg1 := {}
				aadd(alReg1,"P")
				aadd(alReg1," ")
				llAtuStatus	:= .T.
				
			EndIF
		Else
			alReg1 := {}
			aadd(alReg1,"ER")
			aadd(alReg1,"ERRO: Registro nใo encontrado na Z1: "+"Filial: "+clFil+" Pedido: "+clPed)
			llAtuStatus	:= .T.
		EndIF
		
		If llAtuStatus
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,.F.)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				EndIf
			EndIf
		EndIF
		
		(cAlias)->(DbSkip())
	EndDO
EndIf

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FBAIXACNH  บAutor  ณ Tiago Bizan	     บ Data ณ  15/04/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para leitura da tabela TB_FRTINTERFNOTAS e	  บฑฑ
ฑฑบ          ณ atualiza็ใo das informa็๕es de Data Saida e Hora Libera็ใo บฑฑ
ฑฑบ          ณ na tabela SZ1											  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FBAIXACNH(lJob,cEmp,cFil)
Local cAlias		:= GetNextAlias()
Local clUsrBD		:= ""
Local clQuery		:= ""
Local llAtuStatus	:= .F.
Local clMsgAtu		:= ""

Default lJob	:= .F.
Default cEmp	:= '01'
Default cFil	:= '03'

If lJob
	
	RpcSetType(3)
	
	If !RpcSetEnv(cEmp,cFil)
		
		ConOut("Nao foi possivel iniciar a empresa e filial !")
		
		Return()
		
	EndIf
EndIF

clUsrBD	:= SuperGetMV("NCG_000019")

Conout("Iniciando rotina Baixa Canhoto - WMS")

clQuery := "SELECT RNV_DATA_ENTREGA,RNV_COD_CHAVE,RNV_COD_DEPOSITANTE,RNV_NUM_DOCUMENTO,RNV_SERIE_DOCUMENTO "
clQuery += " FROM "+clUsrBD+".TB_FRTINTERFNOTAS"
clQuery += " WHERE STATUS = 'PA' "

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(DBGoTop())

If (cAlias)->(!EOF())
	
	DBSelectArea("SZ1")
	SZ1->(DBSetOrder(1)) //Z1_FILIAL+Z1_DOC+Z1_SERIE+Z1_CLIENTE+Z1_LOJA
	
	alCampos1	:= {}
	alCmpChave	:= {}
	
	aadd(alCampos1,"STATUS")
	aadd(alCampos1,"DESC_ERRO")
	
	clTabWMS := "TB_FRTINTERFNOTAS"
	
	aadd(alCmpChave,"RNV_COD_DEPOSITANTE")
	aadd(alCmpChave,"RNV_NUM_DOCUMENTO")
	aadd(alCmpChave,"RNV_SERIE_DOCUMENTO")
	
	While (cAlias)->(!EOF())
		
		clFil := SUBSTR((cAlias)->RNV_COD_CHAVE,1,TAMSX3("C5_FILIAL")[1])
		clDoc := SUBSTR((cAlias)->RNV_COD_CHAVE,3,TAMSX3("F2_DOC")[1])
		clSer := SUBSTR((cAlias)->RNV_COD_CHAVE,12,TAMSX3("F2_SERIE")[1])
		clCli:= SUBSTR((cAlias)->RNV_COD_CHAVE,15,TAMSX3("F2_CLIENTE")[1])
		clLoja:= SUBSTR((cAlias)->RNV_COD_CHAVE,21,TAMSX3("F2_LOJA")[1])
		
		alReg1		:= {}
		alValChave	:= {}
		llAtuStatus := .F.
		clMsgAtu	:= ""
		
		aadd(alValChave,(cAlias)->RNV_COD_DEPOSITANTE)
		aadd(alValChave,PADR((cAlias)->RNV_NUM_DOCUMENTO,6,"") )
		aadd(alValChave,(cAlias)->RNV_SERIE_DOCUMENTO)
		
		SZ1->(DBGoTop())
		IF SZ1->( DBSeek(clFil+clDoc+clSer+clCli+clLoja) )
			If !EMPTY((cAlias)->RNV_DATA_ENTREGA)
				If RecLock("SZ1",.F.)  //DD/MM/AAAA HH:MM
					If Empty(SZ1->Z1_DTBAIXA) // somente farแ a baixa quando o canhoto ainda nใo estiver sido baixado anteriormente de forma manual
						SZ1->Z1_DTENTRE	:= ctod(SUBSTR((cAlias)->RNV_DATA_ENTREGA,1,10))
						SZ1->Z1_HORAEN	:= SUBSTR((cAlias)->RNV_DATA_ENTREGA,12,5)
						SZ1->Z1_DTBAIXA	:= dDatabase
						SZ1->Z1_STATUS	:= "B"
						SZ1->(MSUnlock())
					Else
						clMsgAtu	:= "Canhoto foi baixado de forma manual anteriormente"
					EndIf
					alReg1 := {}
					aadd(alReg1,"RP")
					aadd(alReg1,clMsgAtu)
					
					llAtuStatus	:= .T.
					
				EndIF
			EndIF
		Else
			alReg1 := {}
			aadd(alReg1,"ER")
			aadd(alReg1,"ERRO: Registro nใo encontrado na Z1: "+"Filial: "+clFil+" Pedido: "+clDoc)
			llAtuStatus	:= .T.
		EndIF
		
		If llAtuStatus
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,.F.)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				EndIf
			EndIf
		EndIF
		
		(cAlias)->(DbSkip())
	EndDO
EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FLIPEDFAT  บAutor  ณ Tiago Bizan      บ Data ณ  17/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina de libera็ใo para Faturamento dos Pedidos contidos  บฑฑ
ฑฑบ          ณ na tabela TB_WMSINTERF_CONF_SEPARACAO  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FLIPEDFAT()

Local apItens	:= {"PEDIDO","CLIENTE"}
Local cpEdit1	:= space(10)
Local cpCombo	:= ""
Local aHeader	:= {}
Local aCols		:= {}
Local cAlias	:= GetNextAlias()
Local lVazio	:=.F.
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local cNumPedSite
Local aParamBox	:={}
Local aLojas :={}
Local aParams:={}
Local aNomesLj:={}
Local cStringFiltro
Local lContinuar:=.F.
Local nHDL
Local cTipo
Local nContar
Local cNameGlbVar:='NC_GAMES_FLIPEDFAT'
Local cGlbVar := GetGlbValue(cNameGlbVar)

Private lWmsStore:=(cFilAnt$cFilStore)
Private aPvSite:={}
Private opEdit1 := Nil


If !Semaforo(.T.,@nHDL,"_FLIPEDFAT")
	MsgStop("Tela de Libera็ใo sendo usada por "+cGlbVar,"NcGames")
	Return()
EndIf

PutGlbValue(cNameGlbVar, cUserName)

/*
If FindFunction("TimeGlbValue")
If !Empty(cGlbVar) .And. TimeGlbValue( cNameGlbVar ) > 5*60
If MsgYesNo("Tela libera็ใo sendo usada por "+cGlbVar+" Deseja liberar?","NcGames")
ClearGlbValue(cNameGlbVar)
EndIf
EndIf
EndIf

If Empty(cGlbVar)
PutGlbValue(cNameGlbVar, cUserName)
cGlbVar := GetGlbValue(cNameGlbVar)
Else
MsgStop("Tela de Libera็ใo sendo usada por "+cGlbVar,"NcGames")
Return()
EndIf
*/


aAdd(aHeader,{""		  		,"XLEGENDA"		,"@BMP"	,010					,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Filial"	   		,"C5_FILIAL"	,"@!"	,TamSx3("C5_FILIAL")[1]	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"NumPed"	   		,"C5_NUM"		,"@!"	,TamSx3("C5_NUM")[1]	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Operacao"	  	,"OPERACAO"		,"@!"	,25						,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Ped.Cliente"  	,"C5_PEDCLI"	,"@!"	,TamSx3("C5_PEDCLI")[1]	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Origem"			,"ZC5_LJECOM"	,"@!"	,TamSx3("ZC5_LJECOM")[1],0,"","","C","","" ,"",""})
aAdd(aHeader,{"NumPed Site"  	,"PEDIDOECOM"	,"@!"	,006					,0,"","","C","","" ,"",""})

aAdd(aHeader,{"Emissao"  	 	,"C5_EMISSAO"	,"@D"	,008					,0,"","","D","","" ,"",""})
aAdd(aHeader,{"Dt Ecommerce" 	,"ZC5_DTVTEX"	,"@D"	,008					,0,"","","D","","" ,"",""})


aAdd(aHeader,{"Pagto Eft."  	,"STATUSECOM"	,"@!"	,010					,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Cliente"			,"C5_CLIENTE"	,"@!"	,TamSx3("C5_CLIENTE")[1],0,"","","C","","" ,"",""})
aAdd(aHeader,{"Loja"			,"C5_LOJACLI"	,"@!"	,TamSx3("C5_LOJACLI")[1],0,"","","C","","" ,"",""})
aAdd(aHeader,{"Nome"			,"A1_NOME"		,"@!"	,TamSx3("A1_NOME")[1]	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Estado"			,"A1_EST"		,"@!"	,TamSx3("A1_EST")[1]   	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Bairro"			,"A1_BAIRRO"	,"@!"	,TamSx3("A1_BAIRRO")[1]	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Municipio"		,"A1_MUN"  		,"@!"	,TamSx3("A1_MUN")[1]	,0,"","","C","","" ,"",""})
aAdd(aHeader,{"Chv CrossDocking","C5_YCHCROS"	,"@!"	,TamSx3("C5_YCHCROS")[1],0,"","","C","","" ,"",""})
aAdd(aHeader,{"Cod Transportador","A4_YCODWMS"	,""		,TamSx3("A4_YCODWMS")[1],0,"","","C","","" ,"",""})
aAdd(aHeader,{"Observacao"		,"OBSERVACAO"	,""		,100					,0,"","","C","","" ,"",""})
aAdd(aHeader,{"TIPO"			,"Tipo"			,""		,3						,0,"","","C","","" ,"",""})


cStringFiltro:=""

lContinuar	:= .F.
lVazio		:= .F.
cAlias		:= GetNextAlias()
aCols		:= {}
aParamBox	:= {}
aLojas 		:= {}
aParams		:= {}
aNomesLj	:= {}
aPvSite		:= {}


If lWmsStore
	
	clQuery := " SELECT DISTINCT C9_PEDIDO,C9_CLIENTE,C9_LOJA "
	clQuery += " FROM "+RetSqlName("SC9")+" SC9"
	clQuery += " WHERE C9_FILIAL='"+xFilial("SC9")+"'"
	clQuery += " AND C9_PEDIDO Between '      ' And 'ZZZZZZ'"
	clQuery += " AND C9_BLWMS='03'"
	clQuery += " AND C9_NFISCAL=' '"
	clQuery += " AND D_E_L_E_T_=' ' "
	clQuery += " Order by C9_PEDIDO"
	Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)
	While (cAlias)->(!EOF())
		
		SC5->(MsSeek(xFilial("SC5")+(cAlias)->C9_PEDIDO))
		SA1->(MsSeek(xFilial("SA1")+(cAlias)->(C9_CLIENTE+C9_LOJA) ))
		cMarca:="LBNO"
		cMensagem:=""
		PR106ObrPed(SA1->A1_COD,SA1->A1_LOJA,SC5->C5_PEDCLI,@cMarca,@cMensagem,(cAlias)->C9_PEDIDO)
		
		AADD(aCols,	{	cMarca	,;
		cFilAnt 	,;
		SC5->C5_NUM	   			,;
		BUSCAOPER(SC5->C5_NUM)	,;
		SC5->C5_PEDCLI	   			,;
		"",;
		"",;
		CTOD("  /  /  "),;
		CTOD("  /  /  "),;
		CTOD("  /  /  "),;
		"" ,;
		SA1->A1_COD 							,;
		SA1->A1_LOJA 				   		,;
		SA1->A1_NOME 				   		,;
		SA1->A1_EST 		   		   	,;
		SA1->A1_BAIRRO 				   	,;
		SA1->A1_MUN 				   		,;
		""		,;
		SC5->C5_TRANSP		,;
		cMensagem		,;
		"",;
		.F., 					   	   			} )
		
		lVazio:=.F.
		(cAlias)->(DBSkip())
	EndDo
	
	
Else
	
	aLojas:={}
	AADD(aLojas,"00=Todas")
	AADD(aLojas,"DI=Distribuidora")
	AADD(aLojas,"EC=E-Commerce(B2C)")
		AADD(aLojas,"WM=Franqueados")
	
	//AADD(aLojas,"02=PROXIMOGAMES")
	//AADD(aLojas,"04=MARKETPLACE PROXIMO WALMART")
	//AADD(aLojas,"05=MARKETPLACE PROXIMO MERCADO LIVRE")
	//AADD(aLojas,"06=MARKETPLACE PROXIMO B2W")
	
	AADD(aLojas,"03=UZGAMES")
	AADD(aLojas,"07=MARKETPLACE UZ WALMART")
	AADD(aLojas,"08=MARKETPLACE UZ NOVAPONTOCOM")
	AADD(aLojas,"09=MARKETPLACE UZ MERCADO LIVRE")
	//AADD(aLojas,"10=MARKETPLACE UZ RAKUTEN")
	AADD(aLojas,"11=MARKETPLACE UZ B2W")
	AADD(aLojas,"12=MARKETPLACE MEGAMAMUTE")
	AADD(aLojas,"13=MARKETPLACE SHOP FACIL")
	
	For nInd:=1 To Len(aLojas)
		AAdd(aNomesLj,{Iif(Left(aLojas[nInd],2)=="01","  ",  Left(aLojas[nInd],2))   ,SubStr(aLojas[nInd],4) }  )
	Next
	
	
	aAdd(aParamBox,{2,"Origem PV"			,"1"	, aLojas	,120,".T."					,.F.})
	aAdd(aParamBox,{1,"Quem cont๊m o produto",Space(15),"","","SB1","",0,.F.}) // Tipo caractere
	
	If !ParamBox(aParamBox, "Parโmetros Filtro", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)
		Semaforo(.F.,nHDL,"_FLIPEDFAT")
		ClearGlbValue(cNameGlbVar)
		Return
	EndIf
	
	cStringFiltro:="Origem dos Pedidos "+BuscaLj(aParams[1],aNomesLj)+Space(10)
	
	If Empty( aParams[2] )
		cStringFiltro+=" Sem Filtro  de Produtos"
	Else
		cStringFiltro+=" Somente Pedido(s) que contenha(m) produto "+AllTrim(aParams[2])+"-"+AllTrim(Posicione("SB1",1,xFilial("SB1")+aParams[2],"B1_XDESC"))
	EndIf
	
	
	clQuery := ""
	clQuery += "SELECT DISTINCT CS_NUM_DOCUMENTO, "
	clQuery += "                CS_COD_CLIENTE, "
	clQuery += "               CS_COD_DEPOSITANTE, "
	clQuery += "               CS_COD_CHAVE_TRANS, "
	clQuery += "                CS_COD_TRANSPORADOR, "
	clQuery += "                ZC5_NUM, "
	clQuery += "                ZC5_NUMPV, "
	clQuery += "                ZC5_STATUS, "
	clQuery += "                ZC5_FLAG, "
	clQuery += "                ZC5_PVVTEX, "
	clQuery += "                ZC5_LJECOM, "
	clQuery += "                ZC5_DTVTEX "
	clQuery += " FROM WMS.TB_WMSINTERF_CONF_SEPARACAO "
	//Pedido E-commerce
	clQuery += " LEFT JOIN "+RetSqlName("ZC5")+" ZC5 "
	clQuery += " 	ON ZC5.D_E_L_E_T_ = ' '
	clQuery += " 	AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "
	clQuery += " 	AND ZC5.ZC5_NUMPV = CS_NUM_DOCUMENTO "
	clQuery += " WHERE STATUS = 'NP' "
	clQuery += " And CS_COD_CHAVE Like '"+cFilAnt+"%'"
	
	If !Empty(aParams[2])
		clQuery	+=" And CS_COD_PRODUTO='"+aParams[2]+"'"
	EndIf
	
	clQuery += " ORDER BY CS_NUM_DOCUMENTO "
	
	Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)
	TcSetField(cAlias,"ZC5_DTVTEX","D")
	
	
	DBSelectArea("SA1")
	SA1->(DBSetOrder(1))
	SC5->(DBSetOrder(1))
	
	
	aPvSite:={}
	While (cAlias)->(!EOF())
		
		If (cAlias)->ZC5_FLAG == "8"
			(cAlias)->(DbSkip());Loop
		EndIf
		
		SA1->(DBSeek(xFilial("SA1")+substr((cAlias)->CS_COD_CLIENTE,2,len((cAlias)->CS_COD_CLIENTE))))
		SC5->(MsSeek(xFilial("SC5")+(cAlias)->CS_NUM_DOCUMENTO))
		
		cNumPedSite:=""
		If !Empty((cAlias)->ZC5_PVVTEX)
			cNumPedSite:=(cAlias)->ZC5_PVVTEX
		Else
			cNumPedSite:=Iif((cAlias)->ZC5_NUM != 0, Alltrim(Str((cAlias)->ZC5_NUM)),  ""  )
		EndIf
		
		
		If !aParams[1]=="00"
			If aParams[1]=="DI"
				If !Empty(cNumPedSite)
					(cAlias)->(DbSkip());Loop
				EndIf
			ElseIf aParams[1]=="EC"
				If Empty((cAlias)->ZC5_PVVTEX)
					(cAlias)->(DbSkip());Loop
				EndIf
			ElseIf (cAlias)->ZC5_LJECOM<>aParams[1]
				(cAlias)->(DbSkip());Loop
			EndIf
		EndIf
		
		cMarca		:= "LBNO"
		cMensagem	:= ""
		
		PR106ObrPed(SA1->A1_COD,SA1->A1_LOJA,SC5->C5_PEDCLI,@cMarca,@cMensagem,SC5->C5_NUM)
		
		cTipo		:= ""
		cNumPedSite	:= ""
		
		If !Empty((cAlias)->ZC5_PVVTEX)
			cTipo:="B2C"
			cNumPedSite:=(cAlias)->ZC5_PVVTEX
			AADD(aPvSite,{cNumPedSite,"B2C", Posicione("SA3",1,xFilial("SA3")+SC5->C5_VEND1,"A3_NOME")})
		Else
			If !Empty( cNumPedSite:=Iif((cAlias)->ZC5_NUM != 0, Alltrim(Str((cAlias)->ZC5_NUM)),  ""  ))
				cTipo:="B2B"
				AADD(aPvSite,{cNumPedSite,"B2B", Posicione("SA3",1,xFilial("SA3")+SC5->C5_VEND1,"A3_NOME")})
			EndIf
		EndIf
		
		AADD(aCols,	{	cMarca	,;
		STRZERO((cAlias)->CS_COD_DEPOSITANTE,TAMSX3("C5_FILIAL")[1]) 	,;
		(cAlias)->CS_NUM_DOCUMENTO	   			,;
		BUSCAOPER(SC5->C5_NUM)	,;
		SC5->C5_PEDCLI	   			,;
		BuscaLj((cAlias)->ZC5_LJECOM,aNomesLj)		,;
		cNumPedSite,;
		SC5->C5_EMISSAO,;
		(cAlias)->ZC5_DTVTEX,;
		Iif(!Empty((cAlias)->ZC5_STATUS),Iif((cAlias)->ZC5_STATUS == "10" .OR. (cAlias)->ZC5_STATUS == "08", "Sim", "Nใo"),"" ),;
		SA1->A1_COD 							,;
		SA1->A1_LOJA 				   		,;
		SA1->A1_NOME 				   		,;
		SA1->A1_EST 		   		   	,;
		SA1->A1_BAIRRO 				   	,;
		SA1->A1_MUN 				   		,;
		(cAlias)->CS_COD_CHAVE_TRANS		,;
		(cAlias)->CS_COD_TRANSPORADOR		,;
		cMensagem		,;
		cTipo,;
		.F. 					   	   		} )
		
		lVazio:=.F.
		(cAlias)->(DBSkip())
	EndDo
	
	(cAlias)->(DbCloseArea())
	
	
EndIf



If lVazio
	
	AADD(aCols,	{	"LBNO"	,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	""			,;
	"" 		,;
	CTOD("  /  /  "),;
	CTOD("  /  /  "),;
	CTOD("  /  /  "),;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	"" 		,;
	.F. 	} )
EndIF

oDlg   		:= MSDialog():New(000,000,600,1750,"Pedidos Liberados para Faturamento",,,,,CLR_BLACK,CLR_WHITE,,,.T.)

oFWLayer	:= FWLayer():New()

oFWLayer:Init(oDlg,.F.)

oFWLayer:AddCollumn("ALL"	,0100,.F.)

oFWLayer:AddWindow("ALL"	,"ACAO"	,"A็๕es"				,020,.F.,.F.,,,{ || })
oFWLayer:AddWindow("ALL"	,"PED"	,"Pedidos a faturar "+Space(40)+cStringFiltro	,080,.F.,.F.,,,{ || })

oPanelESQ3	:= oFWLayer:GetWinPanel("ALL"	,"ACAO")
oPanelESQ2	:= oFWLayer:GetWinPanel("ALL"	,"PED")

olCheck := TCheckBox():New(011,350,"Inverte Sele็ใo",,oPanelESQ3,050,050,,,,,,,,.T.,,,)
olCheck:BLCLICKED	:= {|| INVERTSELL() }

TBtnBmp2():New(5,1100,30,45,"FINAL",,,,{|| lContinuar:=.F.,oDlg:End() },oPanelESQ3,"Sair",,.T. )

TBtnBmp2():New(5,1050,30,45,"PMSRRFSH"	,,,,{|| Processa( {|| U_NCGPR140() }) },oPanelESQ3,"Retornar Pedidos",,.T. )

TBtnBmp2():New(5,1000,30,45,"PCOFXOK",,,,{|| IIF( FCONFIRMA(),(lContinuar:=.T.,oDlg:End()),Nil) },oPanelESQ3,"Confirmar",,.T. )
TBtnBmp2():New(5,950,30,45,"BMPUSER"	,,,,{|| Processa( {|| U_PR106Inf(olMsNewGet) }) },oPanelESQ3,"Pedido Cliente",,.T. )




TBtnBmp2():New(5,400,30,45,"PESQUISA",,,,{|| PESQUISA(cpCombo,cpEdit1)},oPanelESQ3,"Pesquisa",,.T. )
opCombo		:= TComboBox():New(007,001,{|u| If(PCount()>0,cpCombo:=u,cpCombo)},apItens,070,020,oPanelESQ3,,{|| Ordena(cpCombo,cpEdit1) },,,,.T.,,,,,,,,,"cpCombo")
opEdit1		:= TGet():New(007,085,{|u| if(PCount()>0,cpEdit1:=u,cpEdit1)},oPanelESQ3,100,009,"",{||  },,,,,,.T.,,,,,,,,,,"cpEdit1")

olMsNewGet 	:= MsNewGetDados():New(000,000,000,000,001,,"AllWaysTrue()","",,,9999,"AllwaysTrue()",,,oPanelESQ2,aHeader,aCols)
olMsNewGet:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
olMsNewGet:lInsert := .F.
olMsNewGet:OBROWSE:BLDBLCLICK	:= {|x| SELREG()}

oDlg:Activate(,,,.T.,{||  },,{|| } )

//If !lContinuar
//Exit
//EndIf
//EndDo


nContar:=0    
Do While ++nContar<10
	If Semaforo(.F.,nHDL,"_FLIPEDFAT")
		Exit
	EndIf		
EndDo			
If File("_FLIPEDFAT_.LCK")
	MsgInfo("Nใo foi possํvel liberar a Tela de Libera็ใo para outra esta็ใo."+CRLF+"Voc๊ deve sair do sistema liberar." )
EndIf	


ClearGlbValue(cNameGlbVar)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FCONFIRMA  บAutor  ณ Tiago Bizan      บ Data ณ  17/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo na confirama็ใo da tela de Libera็ใo de Pedido para  บฑฑ
ฑฑบ          ณ liberar o pedido para faturamneto e encaminhamento de email บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FCONFIRMA()
Local aAreaAtu:=GetArea()
Local aAreaSC6:=SC6->(GetArea())
Local aAreaSB1:=SB1->(GetArea())
Local aAreaSB2:=SB2->(GetArea())
Local aAreaSF4:=SF4->(GetArea())
Local nlIndPed	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_NUM' })
Local nlIndFil	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_FILIAL' })
Local nlIndCros	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_YCHCROS' })
Local nlYCODSA4	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'A4_YCODWMS' })
Local nlIndEcom 	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'PEDIDOECOM' })
Local nlIndStsE 	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'STATUSECOM' })
Local nTipoPVECOM 	:= ASCAN(olMsNewGet:aHeader,{|x| Upper(alltrim(x[2])) == 'TIPO' })

Local cPedEcom	 	:= ""
Local cStsPedEcom := ""
Local clChave	:= ""
Local alCSReg1	:= {'',''}
Local llAtuStatus:= .F.
Local clAssunto	:= "WMS - LIBERAวรO DE PEDIDOS DE VENDA PARA FATURAMENTO"
Local aAnexos	:= {}
Local clDest	:= SuperGetMV("MV_ENVFAT")
Local clCopia	:= ""
Local clErro	:= ""
Local nYCodWMSA4	:= 0
Local llSelecao := .F.
Local lVldEcom		:= .F.
Local cMsgEcom		:= ""
Local nAscan
Local aDadosHtml := {}
Local aPVGati:={}
Local lGATI
Local nMinGATI:=2

Local cFilSC6:=xFilial("SC6")
Local cFilSB1:=xFilial("SB1")
Local cFilSB2:=xFilial("SB2")
Local cFilSF4:=xFilial("SF4")

SB1->(DbSetOrder(1))
SB2->(DbSetOrder(1))
SF4->(DbSetOrder(1))
SC6->(DbSetOrder(1))

DBselectArea("SC9")
SC9->(DBsetOrder(1))
If !lWmsStore
	alCSCampos1	:= U_F105RETCMP("CS",.T.)
	
	clCSTabWMS := "TB_WMSINTERF_CONF_SEPARACAO"
	
	alCSCmpChave := {}
	AADD(alCSCmpChave,"CS_COD_DEPOSITANTE")
	AADD(alCSCmpChave,"CS_NUM_DOCUMENTO")
EndIf

clMen :=	'<p style="font-family: Arial; color: #5551;"></p>';
+'<table width="600"  border="1">';
+'<tr>';
+'<td ALIGN=MIDDLE colspan="3" bgcolor="#CDC5BF"><FONT COLOR="WHITE"><b>LIBERAวรO DE PEDIDOS DE VENDA PARA FATURAMENTO</b></td>';
+'</tr>';
+'</table>';
+'<br>'

//lGATI:= .F. //GATI Desabilitado     
//lGATI:=MsgYesNo("Somente pedidos e-commerce(B2C)."+CRLF+"Deseja Gerar Automaticamente Nota Fiscal Transmitir e Imprimir DANFE?","Nc Games")
lGATI:=MsgYesNo("Deseja Gerar Automaticamente Nota Fiscal Transmitir e Imprimir DANFE?","Nc Games")

If !lGATI
	lGATI:=!MsgYesNo("Tem certeza que nใo quer gerar Lote?"+CRLF+"Sim=Gerar Nota Manualmente."+CRLF+"Nใo=Serแ gerado o Lote.","Nc Games")
EndIf

For nI := 1 to len(olMsNewGet:aCols)
	
	//Valida็ใo de pedido de E-commerce
	lVldEcom	:= .F.
	If olMsNewGet:aCols[nI,ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'XLEGENDA' })] == 'LBTIK'
		IF ASCAN(aDadosHtml,{|a| a[1] == ALLTRIM(olMsNewGet:aCols[nI,nlIndFil]) .And. a[2] == ALLTRIM(olMsNewGet:aCols[nI,nlIndPed])}) == 0
			AADD(aDadosHtml,{ALLTRIM(olMsNewGet:aCols[nI,nlIndFil]),ALLTRIM(olMsNewGet:aCols[nI,nlIndPed])})
		EndIF
		If Empty(olMsNewGet:aCols[nI,nlIndStsE])
			lVldEcom	:= .T.
		Else
			If Upper(ALLTRIM(olMsNewGet:aCols[nI,nlIndStsE])) == "SIM"
				lVldEcom	:= .T.
			Else
				lVldEcom	:= .F.
				cMsgEcom += "- "+ALLTRIM(olMsNewGet:aCols[nI,nlIndPed] )+";"+CRLF
			EndIf
		EndIf
		
	EndIf
	
	If olMsNewGet:aCols[nI,ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'XLEGENDA' })] == 'LBTIK' .And. lVldEcom
		
		cFil		:= ALLTRIM(olMsNewGet:aCols[nI,nlIndFil] )
		cPed		:= ALLTRIM(olMsNewGet:aCols[nI,nlIndPed] )
		cChvCros	:= ALLTRIM(olMsNewGet:aCols[nI,nlIndCros] )
		
		//Procedimento referente o E-commerce
		cPedEcom	:= ALLTRIM(olMsNewGet:aCols[nI,nlIndEcom] )
		cStsPedEcom	:= ALLTRIM(olMsNewGet:aCols[nI,nlIndStsE] )
		nYCodWMSA4	:= ALLTRIM(olMsNewGet:aCols[nI,nlYCODSA4] )
		cTipoPVECOM	:= ALLTRIM(olMsNewGet:aCols[nI,nTipoPVECOM] )
		
		alCSValChave := {}
		AADD(alCSValChave,val(cFil))
		AADD(alCSValChave,cPed)
		If Empty(cChvCros)
			clChave := cFil+cPed
		Else
			clChave := cChvCros
		EndIf
		If SC9->(DBSeek(clChave) )
			
			If !lWmsStore
				//ATUALIZA A TRANSPORTADORA ANTES DE REALIZAR A LIBERAวรO PARA FATURAMENTO
				U_FTRSSC5(VAL(cFil),cPed,cChvCros,nYCodWMSA4,'PR')
			EndIf
			
			While clChave == SC9->C9_FILIAL+SC9->C9_PEDIDO
				If SC9->C9_SEQUEN == "01" //nใo libera a sequencia seguinte pois nใo deve haver mais que uma libera็ใo de pedido de vendas - 04/09/13
					If RecLock("SC9",.F.)
						SC9->C9_BLWMS := SPACE(TAMSX3("C9_BLWMS")[1])
						SC9->(MSUnlock())
					EndIF
					If  lGATI .And. Ascan(aPVGati,SC9->C9_PEDIDO)==0 //cTipoPVECOM=="B2C" .And.
						AADD(aPVGati,SC9->C9_PEDIDO)
					EndIF
				EndIf
				
				SC9->(DBSkip())
			EndDO
			
			If !Empty(cChvCros)
				cFil	:= Substr(cChvCros,1,2)
				cPed	:= Substr(cChvCros,3,6)
			Endif
			
			clMen +=	'<table width="600" border="1">'
			clMen +=	'<tr>'
			clMen +=	'<td colspan = "3">FILIAL: '+cFil+'</td>'
			clMen +=	'<td colspan = "3">PEDIDO: '+cPed+'</td>'
			clMen +=	'</tr>'
			//Procedimento referente o E-commerce
			If !Empty(cPedEcom) .And. !Empty(cStsPedEcom)
				clMen +=	'<tr>'
				clMen +=	'<td colspan = "3">Pedido Site: '+cPedEcom+'</td>'
				clMen +=	'<td colspan = "3">Pagto. Efetuado: '+cStsPedEcom+'</td>'
				clMen +=	'</tr>'
				
				If (nAscan:=Ascan(aPvSite,{|a| AllTrim(a[1])==AllTrim(cPedEcom) }))>0
					clMen +=	'<tr>'
					clMen +=	'<td colspan = "3">Tipo: '+aPvSite[nAscan,2]+'</td>'
					clMen +=	'<td colspan = "3">Vendedor: '+aPvSite[nAscan,3]+'</td>'
					clMen +=	'</tr>'
				EndIf
				
			EndIf
			
			//SC5->(DBGotop())
			SC5->( DBSeek(cFil+cPed) )
			
			
			If Posicione("SA1",1,xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI),"A1_AGEND"  )=="1"
				clMen +=	'<tr>'
				clMen +=	'<td colspan = "6"><font color='+IIf(Empty(SC5->C5_PEDCLI),"#FF0000","#000080")+'><b>Pedido Cliente:'+IIf(Empty(SC5->C5_PEDCLI),'Obrigatorio',SC5->C5_PEDCLI)+'</b></font></td>'
				clMen +=	'</tr>'
			EndIf
			
			
			
			clMen +=		'<tr>';
			+'<td colspan="6">Cliente: '+SC5->C5_CLIENTE+" "+SC5->C5_LOJACLI+" - "+ALLTRIM(SC5->C5_NOMCLI)+'</td>';
			+'</tr>';
			+ CompHTML(cPed);
			+'</table>';
			+'<br>'
			
			alCSReg1[1] := "P"
			alCSReg1[2] := " "
			llAtuStatus := .T.
			
			If !(llSelecao) //.AND. !EMPTY(olMsNewGet:aCols[nI,nlIndPed])
				llSelecao := .T.
			EndIF
			
		Else
			alCSReg1[1] := "ER"
			alCSReg1[2] := "Registro nใo encontrado na C9 - Filial: "+cFil+" Pedido: "+cPed
			llAtuStatus := .T.
		EndIF
		
		If !lWmsStore
			clQuery := ""
			clQuery := U_EXESQL105(2,alCSCampos1,alCSReg1,clCSTabWMS,alCSCmpChave,alCSValChave)
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				EndIf
			EndIf
		EndIf
	EndIF
Next nI

If llSelecao
	clMen += 	+'<br>';
	+'<hr />';
	+'<pre style="font-family: Arial; color: #5551;">E-mail automแtico, favor nใo responder</pre>'
	
	u_viewLibFat(aDadosHtml)
	
	IF !U_MySndMail(clAssunto, clMen, aAnexos, clDest, clCopia, clErro)
		Conout("Erro ao tentar enviar o e-mail.")
	Else
		Conout("Finalizando rotina para libera็ใo de PV com sucesso - WMS")
	EndIF
EndIF

If !Empty(cMsgEcom)
	Aviso("Pedido nใo liberado","Pedidos de E-commerce nใo liberados para faturamento. Pend๊ncia de pagamento.: "+CRLF+CRLF+cMsgEcom,{"Ok"},3 )
EndIf

If !(llSelecao)
	MSGINFO("Nenhum registro foi selecionado.","ATENวรO")
EndIF

If Len(aPvGati)>0
	
	If Len(aPvGati)>=nMinGATI
		Processa({|| PR106GATI(aPvGati) },"NcGames","Gravando Pedido no Lote" ,.T.  )
	Else
		MsgStop("Voc๊ selecionou somente "+StrZero(Len(aPvGati),2)+" PV(s) nใo serแ permitido criar lote para "+StrZero(Len(aPvGati),2)+" PV(s)","NcGames"  )
	EndIf
EndIf



RestArea(aAreaSC6)
RestArea(aAreaSB1)
RestArea(aAreaSB2)
RestArea(aAreaSF4)
RestArea(aAreaAtu)
Return(llSelecao)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma JANES RAULINO ISIDORO DE ARAUJO	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para pesquisar na Getdados o conteudo informado 	 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CompHTML(ped)

Local aArea 	:= GetArea()
Local cAliasSQL := GetNextAlias()
Local cAliasMod := GetNextAlias()
Local cHTML  	:= ""
Local cQuery 	:= ""

//cQuery += "SELECT DISTINCT CS.CS_NUM_DOCUMENTO PEDIDO,SA1.A1_MUN MUNICIPIO, SA1.A1_EST UF , ";
//+"(SELECT DISTINCT CS.CS_QTDE_VOLUMES FROM WMS.TB_WMSINTERF_CONF_SEPARACAO WHERE CS_NUM_DOCUMENTO = '"+ped+"') VOLUMES, ";
//+"DS.dpcs_peso peso, DS.DPCS_VALOR VALOR, DS.DPCS_DESC_TRANSPORTADOR TRANSPORTADORA ";
//+"FROM "+RetSqlName("SA1")+" SA1, WMS.TB_WMSINTERF_DOC_SAIDA DS, wms.TB_WMSINTERF_CONF_SEPARACAO CS ";
//+"WHERE DS.DPCS_NUM_DOCUMENTO = '"+ped+"' ";
//+"AND DS.DPCS_NUM_DOCUMENTO = CS.CS_NUM_DOCUMENTO ";
//+"AND DS.DPCS_CNPJ_CLIENTE = SA1.A1_CGC ";
//+"AND SA1.D_E_L_E_T_ =' '


cQuery += "SELECT DISTINCT SC5.C5_NUM PEDIDO,SA1.A1_MUN MUNICIPIO, SA1.A1_EST UF, ";
+"( ";
+"	CASE  ";
+"		WHEN (CS.CS_QTDE_VOLUMES  IS NOT  NULL) THEN CS.CS_QTDE_VOLUMES ";
+"		ELSE SC5.C5_VOLUME1 ";
+"	END ";
+")VOLUMES,   ";
+"DS.dpcs_peso peso, DS.DPCS_VALOR VALOR, DS.DPCS_DESC_TRANSPORTADOR TRANSPORTADORA  ";
+"FROM  ";
+"wms.tb_wmsinterf_doc_saida DS  ";
+"LEFT JOIN "+RetSqlName("SC5")+" SC5  ";
+"	ON(DPCS_COD_CHAVE = SC5.C5_FILIAL||SC5.C5_NUM)  ";
+"LEFT JOIN "+RetSqlName("SA1")+" SA1 ";
+"	ON(SA1.A1_COD||SA1.A1_LOJA =  SC5.C5_CLIENTE||SC5.C5_LOJAENT) ";
+"LEFT JOIN WMS.TB_WMSINTERF_CONF_SEPARACAO CS ";
+"	ON(SC5.C5_FILIAL||SC5.C5_NUM = CS.CS_COD_CHAVE) ";
+"WHERE  ";
+"	SC5.D_E_L_E_T_ = ' ' ";
+"AND SA1.D_E_L_E_T_ = ' ' ";
+"AND SC5.C5_FILIAL  = '"+xFilial("SC5")+"' ";
+"AND SC5.C5_NUM = '"+ped+"' ";
+"AND DS.DPCS_COD_CHAVE = '"+xFilial("SC5")+""+ped+"' "

Iif(Select(cAliasSQL) > 0,(cAliasSQL)->(dbCloseArea()),Nil)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSQL,.T.,.T.)



cQuery :=" SELECT Tab1.CODMODALIDADE_MODALIDADE,Tab2.DESC_MODALIDADE "
cQuery +=" FROM wms.TB_FRT_TRANSP_PEDIDO Tab1,fretes.TB_FRTMODALIDADE Tab2 "
cQuery +=" WHERE pedido like '%"+Ped+"%'"
//cQuery +=" WHERE pedido = '"+StrZero(Val(Ped),10)+"'"
cQuery +=" And tab1.codmodalidade_modalidade=tab2.codmodalidade_modalidade "
Iif(Select(cAliasMod) > 0,(cAliasMod)->(dbCloseArea()),Nil)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasMod,.T.,.T.)




while (cAliasSQL)->(!EOF())
	
	cHTML +=		'  <tr>'
	cHTML +=		'  	<td bgcolor="#FFFFFF"><div align="center">Cidade: '+(cAliasSQL)->MUNICIPIO+'</div></td>'
	cHTML +=		'  	<td bgcolor="#FFFFFF"><div align="center">UF: '+(cAliasSQL)->UF+'</div></td>'
	cHTML +=		' 		<td bgcolor="#FFFFFF"><div align="center">Volumes: '+CVALTOCHAR((cAliasSQL)->VOLUMES)+'</div></td>'
	cHTML +=		'  	<td bgcolor="#FFFFFF">Peso: '+CVALTOCHAR((cAliasSQL)->peso)+'</td>'
	cHTML +=		'  	<td bgcolor="#FFFFFF">Valor: R$ '+CVALTOCHAR((cAliasSQL)->VALOR)+'</td>'
	cHTML +=		'  	<td bgcolor="#FFFFFF">Transp: '+(cAliasSQL)->TRANSPORTADORA+'('+(cAliasMod)->DESC_MODALIDADE+')</td>'
	cHTML +=		'  </tr>
	
	
	(cAliasSQL)->(dBSKip())
	
EndDo

(cAliasSQL)->(dbCloseArea())
(cAliasMod)->(dbCloseArea())


RestArea(aArea)
return cHTML

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ PESQUISA  บAutor  ณ Tiago Bizan      บ Data ณ  16/04/13	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para pesquisar na Getdados o conteudo informado 	 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PESQUISA(cpCombo,cpEdit1)

If cpCombo == 'PEDIDO'
	nlInd := aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "C5_NUM" })
ElseIF cpCombo == 'CLIENTE'
	nlInd := aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "C5_CLIENTE" })
EnDIF

nlPos := ASCAN(olMsNewGet:aCols,{|x| alltrim(x[nlInd])==alltrim(cpEdit1) })

olMsNewGet:GoTo(nlPos)
olMsNewGet:Refresh(.T.)
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ INVERTSELL  บAutor  ณ Tiago Bizan      บ Data ณ  16/04/13  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para inverter a sele็ใo dos registros na Getdados   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function INVERTSELL()
Local cMarca
Local	nlPedNum	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_NUM' })
Local	nlPedCli	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_PEDCLI' })
Local	nPosMarca:=aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})
Local	nPosCli	:=aScan(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_CLIENTE' })
Local	nPosLoja	:=aScan(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_LOJACLI' })



For nI := 1 to len(olMsNewGet:aCols)
	
	If Alltrim(olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]) == "LBNO"
		olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBTIK"
	Else
		olMsNewGet:aCols[nI][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBNO"
	EndIF
	
	
	cMarca:=olMsNewGet:aCols[nI,nPosMarca]
	cMensagem:=""
	PR106ObrPed(olMsNewGet:aCols[nI,nPosCli],olMsNewGet:aCols[nI,nPosLoja],olMsNewGet:aCols[nI,nlPedCli],@cMarca,@cMensagem,olMsNewGet:aCols[nI,nlPedNum])
	olMsNewGet:aCols[nI,nPosMarca]:=cMarca
	
Next nI
olMsNewGet:Refresh()
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SELREG  บAutor  ณ Tiago Bizan    	  บ Data ณ  16/04/13  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para marca็ใo dos registros na Getdados   		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SELREG()
Local cMarca
Local	nlPedNum	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_NUM' })
Local	nlPedCli	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_PEDCLI' })
Local	nPosMarca:=aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})
Local	nPosCli	:=aScan(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_CLIENTE' })
Local	nPosLoja	:=aScan(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_LOJACLI' })
Local nI			:=olMsNewGet:nAt


If Alltrim(olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]) == "LBNO"
	olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBTIK"
Else
	olMsNewGet:aCols[olMsNewGet:nAt][aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})]	:= "LBNO"
EndIf

cMarca:=olMsNewGet:aCols[nI,nPosMarca]
cMensagem:=""
PR106ObrPed(olMsNewGet:aCols[nI,nPosCli],olMsNewGet:aCols[nI,nPosLoja],olMsNewGet:aCols[nI,nlPedCli],@cMarca,@cMensagem,olMsNewGet:aCols[nI,nlPedNum])
olMsNewGet:aCols[nI,nPosMarca]:=cMarca

olMsNewGet:Refresh()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Ordena  บAutor  ณ Tiago Bizan    	  บ Data ณ  16/04/13  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo de ordena็ใo na altera็ใo do Comobo Box   		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 												      		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ordena(cpCombo,cpEdit1)
cpEdit1 := space(10)
opEdit1:Refresh()

If cpCombo == "PEDIDO"
	clIndAux	:= AllTrim(Str(aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "C5_NUM" })))
ElseIF cpCombo == "CLIENTE"
	clIndAux	:= AllTrim(Str(aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "C5_CLIENTE" })))
EndIF

olMsNewGet:aCols := ASort (olMsNewGet:aCols,,,{|x,y| ALLTRIM(x[val(clIndAux)]) < ALLTRIM(y[val(clIndAux)]) } )
olMsNewGet:ForceRefresh()

Return()



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFtrocaCQ  บAutor  ณMicrosiga           บ Data ณ  12/20/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FtrocaCQ(cFil,cDoc,cSerie,cForn,cLoja,cProd,cLocal,nQtdWMS,cLocDest,llAtuStatus)

Local aArea			:= GetArea()
Local cQry			:= ""
Local cQrySD7		:= ""
Local cNumCQ		:= ""
Local nQLbCQ		:= 0
Local nQLbCQ2		:= 0
Local nSaldo		:= 0
Local nSaldo2		:= 0
Local aReg1			:= {}
Local aRegLibCQ	:= {}
Local cAliasSD1	:= GetNextAlias()
Local cAliasSD7	:= GetNextAlias()


cQry	:= " SELECT D1_NUMCQ, D1_QUANT
cQry	+= " FROM "+RetSqlName("SD1")
cQry	+= " WHERE D_E_L_E_T_ = ' '
cQry	+= " AND D1_FILIAL = '"+cFil+"'
cQry	+= " AND D1_DOC = '"+cDoc+"'
cQry	+= " AND D1_SERIE = '"+cSerie+"'
cQry	+= " AND D1_FORNECE = '"+cForn+"'
cQry	+= " AND D1_LOJA = '"+cLoja+"'
cQry	+= " AND D1_COD = '"+cProd+"'
cQry	+= " AND D1_LOCAL = '"+cLocal+"'
Iif(Select(cAliasSD1) > 0,(cAliasSD1)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAliasSD1  ,.F.,.T.)
While (cAliasSD1)->(!eof())
	If Empty(cNumCQ)
		cNumCQ	+= (cAliasSD1)->D1_NUMCQ
	Else
		cNumCQ	+= "/"+(cAliasSD1)->D1_NUMCQ
	EndIf
	(cAliasSD1)->(DbSkip())
End

//Busca os controles de CQ
cQrySD7	:= " SELECT VW_SD7.SEQ, VW_SD7.PRODUTO, VW_SD7.NUMERO, D7_NUMSEQ, D7_SALDO "
cQrySD7	+= "  FROM ( "
cQrySD7	+= "  SELECT MAX(D7_SEQ) SEQ, D7_PRODUTO PRODUTO, D7_NUMERO NUMERO "
cQrySD7	+= "  FROM "+RetSqlName("SD7")+" "
cQrySD7	+= "  WHERE D_E_L_E_T_ = ' ' "
cQrySD7	+= "  AND D7_FILIAL = '"+cFil+"' "
cQrySD7	+= "  AND D7_NUMERO IN "+FormatIN(cNumCQ,"/")+" "
cQrySD7	+= "  GROUP BY D7_PRODUTO, D7_NUMERO  ) VW_SD7, SD7010 "
cQrySD7	+= " WHERE D_E_L_E_T_ = ' ' AND D7_FILIAL = '"+cFil+"' "
cQrySD7	+= " AND D7_NUMERO = VW_SD7.NUMERO AND D7_SEQ = VW_SD7.SEQ "
cQrySD7	+= " ORDER BY NUMERO "
Iif(Select(cAliasSD7) > 0,(cAliasSD7)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQrySD7),cAliasSD7,.F.,.T.)

While (cAliasSD7)->(!eof())
	If (cAliasSD7)->D7_SALDO > 0
		aadd(aRegLibCQ,{(cAliasSD7)->NUMERO,(cAliasSD7)->D7_SALDO,(cAliasSD7)->D7_NUMSEQ})
	EndIf
	(cAliasSD7)->(dbskip())
End

If len(aRegLibCQ) == 0
	ConOut("Documento "+clDoc+" ja liberado totalmente...")
	alReg1 := {}
	aadd(alReg1,"ER")
	aadd(alReg1,"ERRO: LIBERACAO MAIOR QUE O SALDO "+clDoc)
Else
	
	nFator      := GETADVFVAL("SB1","B1_CONV",XFILIAL("SB1")+cProd,1,0.00)
	cTipConv    := GETADVFVAL("SB1","B1_TIPCONV",XFILIAL("SB1")+cProd,1,space(01))
	For nx:=1 to len(aRegLibCQ)
		nQLbCQ	:= 0
		nSaldo	:= 0
		nSaldo2	:= 0
		If nQtdWMS > 0
			If nQtdWMS > aRegLibCQ[nx,2]
				nQLbCQ	:= aRegLibCQ[nx,2]
				nQtdWMS	-= aRegLibCQ[nx,2]
			ElseIf nQtdWMS <= aRegLibCQ[nx,2]
				nQLbCQ	:= nQtdWMS
				nQtdWMS	:= 0
			EndIf
		End
		If nQLbCQ > 0
			nSaldo	:= aRegLibCQ[nx,2]-nQLbCQ
			If nFator > 0
				If cTipConv == "M"
					nSaldo2 := Round(nSaldo / nFator,2)
					nQLbCQ2 := Round(nQLbCQ / nFator,2)
				ElseIf cTipConv == "D"
					nSaldo2 := Round(nSaldo * nFator,2)
					nQLbCQ2 := Round(nQLbCQ * nFator,2)
				Else
					nSaldo2 := 0
					nQLbCQ2 := 0
				EndIf
				
				cLibCQ := {}
				dbSelectArea("SD7")
				dbSetOrder(3)// D7_FILIAL+D7_PRODUTO+D7_NUMSEQ+D7_NUMERO
				SD7->(dbSeek(cFil+PADR(cProd,15)+aRegLibCQ[nx,3]+aRegLibCQ[nx,1],.T.) )
				aAdd(cLibCQ,{ 	{"D7_TIPO"		,1			,Nil},;				// 1 = Libera o item do CQ / 2 = Rejeita o item do CQ.
				{"D7_DATA"		,dDataBase   	,Nil},;
				{"D7_QTDE"		,nQLbCQ			,Nil},;				// Quantidade deve vir do WMS
				{"D7_OBS"		,"Integracao WMS"	,Nil},;
				{"D7_QTSEGUM"	,nQLbCQ2			,Nil},;
				{"D7_MOTREJE"	,""				,Nil},;
				{"D7_LOCDEST"	,cLocDest	    ,Nil},;				// Armazem deve vir do WMAS
				{"D7_SALDO"	   ,nSaldo			,Nil},;
				{"D7_SALDO2"	,nSaldo2		,Nil},;
				{"D7_ESTORNO"	,Nil			,Nil} })
				Private lMsErroAuto := .F.
				MSExecAuto({|x,y| MATA175(x,y)},cLibCQ,4)
				If !lMsErroAuto
					ConOut("Libera็ใo de CQ realizada com sucesso - Filial: "+cFil+" Doc.: "+cDoc+" Prod.: "+cProd+" Dest.: "+cLocDest)
					aReg1 := {}
					aadd(aReg1,"P")
					aadd(aReg1,"")
					llAtuStatus	:= .T.
				Else
					ConOut("Erro na Libera็ใo de CQ - Filial: "+cFil+" Doc.: "+cDoc+" Prod.: "+cProd+" Dest.: "+cLocDest)
					aReg1 := {}
					aadd(aReg1,"ER")
					aadd(aReg1,"Erro na Libera็ใo de CQ - Filial: "+cFil+" Doc.: "+cDoc+" Prod.: "+cProd+" Dest.: "+cLocDest)
					llAtuStatus	:= .T.
					If !lJob
						MOstraERRO()
					EndIf
				EndIf
			Else
				ConOut("Nenhum registro de CQ encontrado - Filial: "+cFil+" Doc.: "+cDoc+" Prod.: "+cProd+" Dest.: "+cLocDest)
				aReg1 := {}
				aadd(aReg1,"ER")
				aadd(aReg1,"ERRO: Nenhum registro de CQ encontrado - Filial: "+cFil+" Doc.: "+cDoc+" Prod.: "+cProd+" Dest.: "+cLocDest)
				llAtuStatus	:= .T.
			EndIf
		EndIf
	Next nx
EndIf

RestArea(aArea)

Return aReg1


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  08/14/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GravaP0A(clQuery,nRecno)
Local lExecutou

lExecutou:=TcSqlExec(clQuery)>=0

P0A->(DBGoto(nRecno))
P0A->(RecLock("P0A",.F.))
If lExecutou
	P0A->P0A_EXPORT := '1'
	//P0A->P0A_ERRO	:= ' '
	P0A->P0A_ERRO	:= "Exportado - "+ dToC(MsDate()) + time()
Else
	P0A->P0A_ERRO := ALLTRIM(tcsqlerror())
EndIf

P0A->(MSUnlock())
TcSqlExec("COMMIT")

Return lExecutou



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  08/14/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR106Grv(clTab,cAlias)
Local cTemModal
Local lEcommerce
Local llFrete := .F.
Local nRecno
Local clTabWMS	:= ""
Local alCampos1
Local cChaveP0A
Local alAlias
Local alCmpChave:={}
Local alValChave:={}
Local lRetorno		:=.T.

If clTab=="SC5"
	nRecno:=(cAlias)->R_E_C_N_O_
Else
	nRecno:=P0AITEM->RECP0A
EndIf

P0A->(DbGoTo(nRecno))

alCampos1   := U_F105RETCMP(clTab,.T.,,,,,,,@cTemModal,@lEcommerce)
cChaveP0A	:= Trim( P0A->P0A_CHAVE )
alAlias 		:= U_F106C5C6(clTab,cChaveP0A)

If !alAlias[1]
	Return .F.
EndIf

alReg1	:= U_F105RETCMP(clTab,.F.,@clTabWMS,@alCmpChave,@alValChave,alAlias[2],,cChaveP0A,@cTemModal,@lEcommerce)


If !U_E0105EXT(clTabWMS, alCmpChave, alValChave,llFrete )
	clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS,Nil,Nil,llFrete)
Else
	If clTab <> 'SC6'
		clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave,llFrete)
	Else
		clQuery := U_EXESQL105(3,Nil,Nil,clTabWMS,alCmpChave,alValChave)
		If !Empty(clQuery)
			If TcSqlExec(clQuery) >= 0
				TcSqlExec("COMMIT")
			Else
				TcSqlExec("ROLLBACK")
			EndIf
		EndIf
		clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS,Nil,Nil,llFrete)
	EndIf
EndIf

If Empty(clQuery)
	Return .F.
EndIf


If !GravaP0A(clQuery,nRecno)
	Return .F.
EndIf

If clTab == 'SC5' .And. cTemModal == '2' .And. !lEcommerce//Verifica se o pedido ้ de e-commerce (Altera็ใo da variavel no codigo fonte NCGPR105)
	alCampos1	:= U_F105RETCMP("TRS",.T.)
	alReg1		:= U_F105RETCMP("TRS",.F.,@clTabWMS,@alCmpChave,@alValChave,alAlias[2])
	If (cAlias)->P0A_TIPO == '1'
		clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS)
	ElseIf (cAlias)->P0A_TIPO == '2'
		clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
	EndIf
	
	If Empty(clQuery)
		Return .F.
	EndIf
	
	
	If !GravaP0A(clQuery,nRecno)
		Return .F.
	EndIf
	
EndIf

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  08/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR10ExcWMS(cPedido,cChave)
Local clUsrBD := U_MyNewSX6(	"NCG_000019","",	"C","Usuแrio para acessar a base do WMS",	"Usuแrio para acessar a base do WMS",	"Usuแrio para acessar a base do WMS",	.F. )

TcSqlExec("DELETE "+clUsrBD+".tb_wmsinterf_doc_saida WHERE dpcs_num_documento = '"+cPedido+"'")
TcSqlExec("DELETE "+clUsrBD+".tb_wmsinterf_doc_saida_itens WHERE dpis_num_documento = '"+cPedido+"'")
TcSqlExec("DELETE "+clUsrBD+".tb_frtinterf_doc_saida_transp WHERE trs_num_documento = '"+cPedido+"'")
TcSqlExec("UPDATE P0A010 SET P0A_EXPORT = '2' WHERE P0A_CHAVE LIKE '"+cChave+"%'")
TcSqlExec("Commit")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  08/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+"_.LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  08/19/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR106Limpar()
Local cQuery
Local dDataIni


PR106Clear("I")
Return


RpcSetEnv("01","03")
cQuery:="SELECT P0A.R_E_C_N_O_ RECP0A,P0A_TABELA,P0A_CHAVE  FROM P0A010 P0A  WHERE P0A.P0A_FILIAL = '  ' AND P0A.P0A_EXPORT = '2'  AND P0A.P0A_TABELA In ('SC5','SF1','SF2') AND P0A.D_E_L_E_T_ = ' '  ORDER BY P0A_TABELA"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"P0ACABEC",.F.,.T.)

SC5->(DbSetOrder(1))
SF2->(DbSetOrder(1))
SF1->(DbSetOrder(1))
dDataIni:=FirstDay(MsDate())

Do While P0ACABEC->(!Eof())
	
	If P0ACABEC->P0A_TABELA=="SC5"
		If !SC5->(MsSeek(P0ACABEC->P0A_CHAVE))
			P0ACABEC->(DbSkip());Loop
		EndIf
		If SC5->C5_EMISSAO>=dDataIni
			P0ACABEC->(DbSkip());Loop
		EndIf
		cItem:="SC6"
	ElseIf P0ACABEC->P0A_TABELA=="SF1"
		If !SF1->(MsSeek(P0ACABEC->P0A_CHAVE))
			P0ACABEC->(DbSkip());Loop
		EndIf
		If SF1->F1_DTDIGIT>=dDataIni
			P0ACABEC->(DbSkip());Loop
		EndIf
		cItem:="SD1"
	ElseIf P0ACABEC->P0A_TABELA=="SF2"
		If !SF2->(MsSeek(P0ACABEC->P0A_CHAVE))
			P0ACABEC->(DbSkip());Loop
		EndIf
		If SF2->F2_EMISSAO>=dDataIni
			P0ACABEC->(DbSkip());Loop
		EndIf
		cItem:="SD2"
	EndIf
	
	clQuery := " SELECT P0A.R_E_C_N_O_ RECP0A "
	clQuery += " FROM "+RetSqlName("P0A") + " P0A "
	clQuery += " WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"'"
	clQuery += " AND P0A.P0A_EXPORT = '2' "
	clQuery += " AND P0A.P0A_TABELA='"+cItem+"'"
	clQuery += " AND P0A.P0A_CHAVE Like '"+AllTrim(P0ACABEC->P0A_CHAVE)+"%'
	clQuery += " AND P0A.D_E_L_E_T_ = ' ' "
	clQuery += " ORDER BY  P0A_CHAVE"
	Iif(Select("P0AITEM") > 0,P0AITEM->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),"P0AITEM",.F.,.T.)
	
	Do While P0AITEM->(!Eof())
		P0A->(DbGoTo(P0AITEM->RECP0A))
		P0A->(RecLock("P0A",.F.))
		P0A->P0A_EXPORT='X'
		P0A->(MsUnLock())
		P0AITEM->(DbSkip())
	EndDo
	P0A->(DbGoTo(P0ACABEC->RECP0A))
	P0A->(RecLock("P0A",.F.))
	P0A->P0A_EXPORT='X'
	P0A->(MsUnLock())
	
	
	
	P0ACABEC->(DbSkip())
	
EndDo


Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  08/21/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PR106Clear()
Local lOk:=.T.
Local cChaveP0A	:=""

RpcSetEnv("01","03")
cQuery:="SELECT P0A.R_E_C_N_O_ RECP0A,P0A_TABELA,P0A_CHAVE  FROM P0A010 P0A  WHERE P0A.P0A_FILIAL = '  ' AND P0A.P0A_EXPORT = '2'  AND P0A.P0A_TABELA In ('SC6','SD1','SD2') AND P0A.D_E_L_E_T_ = ' '  ORDER BY P0A_TABELA"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"P0AITEM",.F.,.T.)

SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
SF1->(DbSetOrder(1))//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
dDataIni:=FirstDay(MsDate())

//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_ITEM+D1_FORMUL
//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_ITEM

Do While P0AITEM->(!Eof())
	
	cChaveP0A:=P0AITEM->P0A_CHAVE
	
	If P0AITEM->P0A_TABELA=="SC6"
		cChave:=Left( P0AITEM->P0A_CHAVE,8)
		If !SC5->(MsSeek(cChave ))
			P0AITEM->(DbEval({||.T.},{||.T.},{||P0AITEM->P0A_CHAVE==cChaveP0A } ));Loop
		EndIf
		If SC5->C5_EMISSAO>=dDataIni
			P0AITEM->(DbEval({||.T.},{||.T.},{||P0AITEM->P0A_CHAVE==cChaveP0A } ));Loop
		EndIf
		cCabec:="SC5"
	ElseIf P0AITEM->P0A_TABELA=="SD1"
		cChave:=Left( P0AITEM->P0A_CHAVE,22)
		
		If !SF1->(MsSeek(cChave))
			P0AITEM->(DbEval({||.T.},{||.T.},{||P0AITEM->P0A_CHAVE==cChaveP0A } ));Loop
		EndIf
		If SF1->F1_DTDIGIT>=dDataIni
			P0AITEM->(DbEval({||.T.},{||.T.},{||P0AITEM->P0A_CHAVE==cChaveP0A } ));Loop
		EndIf
		cCabec:="SF1"
	ElseIf P0AITEM->P0A_TABELA=="SD2"
		
		cChave:=Left( P0AITEM->P0A_CHAVE,22)
		If !SF2->(MsSeek(cChave))
			P0AITEM->(DbEval({||.T.},{||.T.},{||P0AITEM->P0A_CHAVE==cChaveP0A } ));Loop
		EndIf
		
		If SF2->F2_EMISSAO>=dDataIni
			P0AITEM->(DbEval({||.T.},{||.T.},{||P0AITEM->P0A_CHAVE==cChaveP0A } ));Loop
		EndIf
		cCabec:="SF2"
	EndIf
	
	If !lOk .AND. 1=1
		Return
	EndIf
	
	clQuery := " SELECT P0A.R_E_C_N_O_ RECP0A "
	clQuery += " FROM "+RetSqlName("P0A") + " P0A "
	clQuery += " WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"'"
	//clQuery += " AND P0A.P0A_EXPORT = '2' "
	clQuery += " AND P0A.P0A_TABELA='"+cCabec+"'"
	clQuery += " AND P0A.P0A_CHAVE Like '"+AllTrim(cChave)+"%'
	clQuery += " AND P0A.D_E_L_E_T_ = ' ' "
	
	Iif(Select("P0ACABEC") > 0,P0ACABEC->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),"P0ACABEC",.F.,.T.)
	
	Do While P0ACABEC->(!Eof())
		P0A->(DbGoTo(P0ACABEC->RECP0A))
		P0A->(RecLock("P0A",.F.))
		P0A->P0A_EXPORT='X'
		P0A->(MsUnLock())
		P0ACABEC->(DbSkip())
	EndDo
	
	
	Do While P0AITEM->(!Eof()) .And. P0AITEM->P0A_CHAVE==cChaveP0A
		P0A->(DbGoTo(P0AITEM->RECP0A))
		P0A->(RecLock("P0A",.F.))
		P0A->P0A_EXPORT='X'
		P0A->(MsUnLock())
		
		
		P0AITEM->(DbSkip())
	EndDo
EndDo


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  10/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR106INF(olMsNewGet)
Local aAreaAtu	:=GetArea()
Local aAreaSC5	:=SC5->(GetArea())
Local aAcho:={}
Local aCpos:={}
Local aRotAtu:={}
Local nlIndPed	:=0
Local nlPedCli :=0
Local cPedido


If Type("olMsNewGet")=="O"
	nlIndPed	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_NUM' })
	nlPedCli	:= ASCAN(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_PEDCLI' })
	cPedido	:= ALLTRIM(olMsNewGet:aCols[olMsNewGet:NAT,nlIndPed] )
	
	nPosMarca:=aScan(olMsNewGet:aHeader,{|x| Alltrim(x[2]) == "XLEGENDA"})
	nPosCli	:=aScan(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_CLIENTE' })
	nPosLoja	:=aScan(olMsNewGet:aHeader,{|x| alltrim(x[2]) == 'C5_LOJACLI' })
	
Else
	cPedido	:=SC5->C5_NUM
EndIf

If IsInCallStack("U_PR106PV")
	aRotAtu:=aClone(aRotina)
	aRotina := {	{ OemToAnsi("Pesquisar"),"AxPesqui"		,0,1,0 ,.F.},;		//
	{ OemToAnsi("Visual"),"A410Visual"	,0,2,0 ,NIL},;		//
	{ OemToAnsi("Incluir"),"A410Inclui"	,0,3,0 ,NIL},;		//
	{ OemToAnsi("Alterar"),"A410Altera"	,0,4,20,NIL}}		//
	
	
Endif


cCadastro:="Altera็ใo Pedido Cliente"
AADD(aAcho,"NOUSER")
AADD(aAcho,"C5_NUM")
AADD(aAcho,"C5_EMISSAO")
AADD(aAcho,"C5_CLIENTE")
AADD(aAcho,"C5_LOJACLI")
AADD(aAcho,"C5_NOMCLI")
AADD(aAcho,"C5_PEDCLI")

AADD(aCpos,"C5_PEDCLI")

SC5->(DbSetOrder(1))
If SC5->(MsSeek(xFilial("SC5")+cPedido ))
	AxAltera( "SC5", SC5->(Recno()), 4, aAcho, aCpos, /*<nColMens>*/, /*<cMensagem>*/, /*<cTudoOk>*/, /*<cTransact>*/, /*<cFunc>*/, /*<aButtons>*/, /*<aParam>*/, /*<aAuto>*/, /*<lVirtual>*/, .F.)
	If nlPedCli>0
		olMsNewGet:aCols[olMsNewGet:NAT,nlPedCli]:=SC5->C5_PEDCLI
		olMsNewGet:aCols[olMsNewGet:NAT,nPosMarca]:="LBNO"
		cMarca:=olMsNewGet:aCols[olMsNewGet:NAT,nPosMarca]
		cMensagem:=""
		PR106ObrPed(olMsNewGet:aCols[olMsNewGet:NAT,nPosCli],olMsNewGet:aCols[olMsNewGet:NAT,nPosLoja],olMsNewGet:aCols[olMsNewGet:NAT,nlPedCli],@cMarca,@cMensagem,cPedido)
		olMsNewGet:aCols[olMsNewGet:NAT,nPosMarca]:=cMarca
	EndIf
EndIf

If IsInCallStack("U_PR106PV")
	aRotina:=aClone(aRotAtu)
Endif

RestArea(aAreaSC5)
RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  10/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR106PV()
Local cFiltro		:=""
Private cCadastro := "Altera็ใo Pedido Cliente"
Private aRotina 	:= { {"Pesquisar","AxPesqui",0,1} ,;
{"Alterar PedCli","u_PR106INF()",0,4} }

cFiltro:="C5_TIPO ='N'  And C5_PEDCLI=' ' "
cFiltro+=" And Exists(Select 'X' From "+RetSqlName("SA1")+" SA1 Where A1_FILIAL='"+xFilial("SA1")+"' And A1_COD=C5_CLIENTE And A1_LOJA=C5_LOJACLI And A1_AGEND='1' And SA1.D_E_L_E_T_=' ' )"
cFiltro+=" And Exists ( Select 'X' From WMS.TB_WMSINTERF_CONF_SEPARACAO Where STATUS='NP' AND C5_NUM = CS_NUM_DOCUMENTO)"
mBrowse( 6,1,22,75,"SC5",,,,,,,,,,,,,,cFiltro)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  10/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR106ObrPed(cCliente,cLoja,cPedCli,cMarca,cMensagem,cNumPV)
Local cMensa:=""

If Posicione("SA1",1,xFilial("SA1")+cCliente+cLoja,"A1_AGEND")=="1"  .And. Empty(cPedCli)
	cMarca:="BR_VERMELHO"
	cMensagem+="Cliente com Agendamento sem Nr. do Pedido "
EndIf

If (lWmsStore .And. !U_PR109ValPV(cNumPV,@cMensa) )
	cMensagem+=+Space(1)+StrTran( cMensa,CRLF,"*")
	cMarca:="BR_VERMELHO"
EndIf

Return cMarca



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  11/05/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User FUnction PR106Job()


//RpcSetEnv("01","03")
//cBanco:=AllTrim(SuperGetMV("NCG_000019"))

//cQuery:=" UPDATE "+cBanco+".TB_WMSINTERF_TROCA_TP_ESTOQUE"
//cQuery+=" SET STATUS='**'"
//cQuery+=" WHERE STATUS ='NP'"
//cQuery+=" AND BDE_COD_TIPO_ESTOQUE_ORIGEM=0"

//TcSqlExec(cQuery)
//RpcClearEnv()

Return U_FTROCAEST(.T.,"01","03")




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  11/11/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR106ExcP0A(cFilPV,cNumPV)
Local aAreaAtu	:=GetArea()
Local aAreaP0A	:=P0A->( GetArea() )
Local cQuery	:=""
Local cAliasQry	:= GetNextAlias()


cQuery:=" Select P0A.R_E_C_N_O_ RecP0A "
cQuery+=" From "+RetSqlName("P0A")+" P0A "
cQuery+=" Where P0A.P0A_FILIAL='"+xFilial("P0A")+"'"
cQuery+=" And P0A.P0A_CHAVE Like '"+cFilPV+cNumPV+"%'"
cQuery+=" And P0A.D_E_L_E_T_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

Begin Transaction

Do While (cAliasQry)->(!Eof())
	P0A->( DbGoTo( (cAliasQry)->RecP0A ) )
	P0A->(RecLock("P0A",.F.))
	P0A->( DbDelete() )
	P0A->( MsUnLock())
	(cAliasQry)->(DbSkip())
EndDo

End Transaction

RestArea(aAreaP0A)
RestArea(aAreaAtu)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  11/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BUSCAOPER(cPedido)
Local aAreaAtu:=GetArea()
Local cRetorno:=""
Local cQuery
Local cQryAlias	:= GetNextAlias()


cQuery:=" Select Distinct C6_TPOPER,SX5.X5_DESCRI"+CRLF
cQuery+=" From "+RetSqlName("SX5")+" SX5,"+RetSqlName("SC6")+" SC6"+CRLF
cQuery+=" Where  SX5.X5_FILIAL='"+xFilial("SX5")+"'"+CRLF
cQuery+=" And SX5.X5_TABELA='DJ'"+CRLF
cQuery+=" And SX5.D_E_L_E_T_=' '"+CRLF
cQuery+=" And SC6.C6_FILIAL='"+xFilial("SC6")+"'"+CRLF
cQuery+=" And SC6.C6_NUM='"+cPedido+"'"+CRLF
cQuery+=" And SC6.C6_TPOPER=SX5.X5_CHAVE"+CRLF
cQuery+=" And SC6.D_E_L_E_T_=' '"+CRLF

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cQryAlias,.F.,.T.)

Do While !(cQryAlias)->(Eof())
	cRetorno+=(cQryAlias)->( C6_TPOPER+"-"+AllTrim(X5_DESCRI) )+Space(1)
	(cQryAlias)->(DbSkip())
EndDo

(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)
Return cRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  12/09/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NfTransmitida(cTabela,cChave)
Local lRetono
Local aAreaAtu:=GetArea()
Local aAreaSF2:=SF2->(GetArea())
Local cChaveSF2:=Left(cChave,Len(SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA))

SF2->(DbSetOrder(1))
lRetono:=SF2->(MsSeek(cChaveSF2 )).And.SF2->F2_FIMP=='S'


RestArea(aAreaSF2)
RestArea(aAreaAtu)
Return lRetono
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  11/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR106GATI(aPVNF)
Local aAreaAtu:=GetArea()
Local aAreaPA7:=PA7->(GetArea())
Local cNrLote

cNrLote:=U_PR118Grv(aPVNF)

PA7->(DbSetOrder(5))
If PA7->(DbSeek(xFilial("PA7")+cNrLote))
	MsgInfo("Lote "+cNrLote+" criado.","Nc Games")
Else
	MsgInfo("Ocorreu um erro na gera็ใo do Lote.","Nc Games")
EndIf

RestArea(aAreaPA7)
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  11/13/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function BuscaLj(cCodLoja,aLoja)
Local cNome:=""
Local nAscan:=Ascan(aLoja,{|a| a[1]==cCodLoja }  )

If nAscan>0
	cNome:=aLoja[nAscan,2]
EndIf


Return cNome
