#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FRETDOCENT  ºAutor  ³ Tiago Bizan      º Data ³  22/01/13  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para leitura da tabela TB_WMSINTERF_CONF_ENTRADA	  º±±
±±º          ³ e realizar a geração da tabela do fretes                   º±±
±±º          ³ TB_FRTINTERFNOTAS										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FRETDOCENT(lJob,cEmp,cFil)

Local clQuery	:= ""
Local cAlias	:= GetNextAlias()
Local cAliasSD1	:= GetNextAlias()
Local cAliasSD7	:= GetNextAlias()
Local cAliasSF1	:= GetNextAlias()
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
Local llAtuStatus:= .F.
Local clLocal	:= ""
Local lItcOK	:= .F.
Local lCbcOK	:= .F.
Local cPGL		:= ""
Local lPrimeira	:= .T.
Local cCodSY9	:= ""
Local cCodLocEmb:= ""
Local cTipoNf	:= ""

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

clUsrBD	:= "WMS" //SuperGetMV("NCG_000019")

Conout("Iniciando rotina de retorno de Documento de Entrada: Geração do Fretes")

clQuery := " SELECT DISTINCT CE_COD_DEPOSITANTE,CE_NUM_DOCUMENTO,CE_SERIE_DOCUMENTO,CE_COD_FORNECEDOR,CE_INTEGRACAO_FRETES,CE_COD_CHAVE "
clQuery += " FROM "+clUsrBD+".TB_WMSINTERF_CONF_ENTRADA CE "
clQuery += " WHERE CE.STATUS = 'NP'
clQuery += " ORDER BY CE_NUM_DOCUMENTO,CE_COD_FORNECEDOR "

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAlias  ,.F.,.T.)

While (cAlias)->(!EOF())
	
	alValChave := {}
	aadd(alValChave,ALLTRIM((cAlias)->CE_COD_CHAVE))
	
	
	If (cAlias)->CE_INTEGRACAO_FRETES == 'S'
		
		clFil		:= SUBSTR((cAlias)->CE_COD_CHAVE,1,TAMSX3("F1_FILIAL")[1])
		clDoc		:= SUBSTR((cAlias)->CE_COD_CHAVE,3,TAMSX3("F1_DOC")[1])
		clSerie		:= SUBSTR((cAlias)->CE_COD_CHAVE,12,TAMSX3("F1_SERIE")[1])
		clForn      := SUBSTR((cAlias)->CE_COD_CHAVE,15,TAMSX3("F1_FORNECE")[1])
		clLoja		:= SUBSTR((cAlias)->CE_COD_CHAVE,21,TAMSX3("F1_LOJA")[1])
		
		alCampos1	:= {}
		aadd(alCampos1,"STATUS")
		aadd(alCampos1,"DESC_ERRO")
		
		alCmpChave	:= {}
		aadd(alCmpChave,"CE_COD_CHAVE")
		
		clTabWMS := "TB_WMSINTERF_CONF_ENTRADA"
		
		clQuery	:= " SELECT SUM(D1_QUANT) D1_QUANT, D1_DOC, D1_SERIE, D1_COD, D1_FORNECE, D1_LOJA,
		clQuery	+= " SUM(D1_TOTAL+D1_VALIPI+D1_VALFRE+D1_ICMSRET+D1_SEGURO+D1_DESPESA) TOTAL,
		clQuery	+= " D1_ESPECIE, B1_XDESC, D1_FORMUL
		clQuery	+= " FROM SD1010 A, SB1010 B
		clQuery	+= " WHERE A.D_E_L_E_T_ = ' '
		clQuery	+= " AND B.D_E_L_E_T_ = ' '
		clQuery	+= " AND B.B1_FILIAL = '"+xFilial("SB1")+"'
		clQuery	+= " AND A.D1_COD = B.B1_COD
		clQuery	+= " AND D1_FILIAL = '"+SUBSTR((cAlias)->CE_COD_CHAVE,1,2)+"'
		clQuery	+= " AND D1_DOC = '"+SUBSTR((cAlias)->CE_COD_CHAVE,3,9)+"'
		clQuery	+= " AND D1_SERIE = '"+SUBSTR((cAlias)->CE_COD_CHAVE,12,3)+"'
		clQuery	+= " AND D1_FORNECE = '"+SUBSTR((cAlias)->CE_COD_CHAVE,15,6)+"'
		clQuery	+= " AND D1_LOJA = '"+SUBSTR((cAlias)->CE_COD_CHAVE,21,2)+"'
		clQuery	+= " AND D1_FORMUL = '"+SUBSTR((cAlias)->CE_COD_CHAVE,23,1)+"'
		clQuery	+= " GROUP BY D1_DOC, D1_SERIE, D1_COD, D1_FORNECE, D1_LOJA, D1_ESPECIE, B1_XDESC, D1_FORMUL
		
		Iif(Select(cAliasSD1) > 0,(cAliasSD1)->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAliasSD1  ,.F.,.T.)

		alCampos1 := U_F105RETCMP("RNVI",.T.) //busca os campos dos itens TB_FRTINTERFITENSNOTAS

		
		lPrimeira	:= .T.
		cCodLocEmb	:= ""
		cCodSY9		:= ""
		cTipoNf		:= "N"
		While (cAliasSD1)->(!eof())
			//Verificação do fornecedor para envio na interface
			If lPrimeira
				cPGL		:= Posicione("SF1",1,xFilial("SF1")+(cAliasSD1)->(D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA),"F1_HAWB")
				cTipoNf		:= Posicione("SF1",1,xFilial("SF1")+(cAliasSD1)->(D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA),"F1_TIPO")
				If !Empty(cPGL)
					cCodLocEmb	:= Posicione("SW6",1,xFilial("SW6")+cPGL,"W6_LOCAL")
					cCodSY9		:= Posicione("SY9",2,xFilial("SY9")+cCodLocEmb,"Y9_COD")
				EndIf
				lPrimeira	:= .F.

				If cTipoNf $ 'DB'
					DbSelectArea("SA1")
					DbSetOrder(1)
					DbSeek(xFilial("SA1")+(cAliasSD1)->(D1_FORNECE+D1_LOJA))
					clCEP	:= SA1->A1_CEP
					clEST	:= SA1->A1_EST
					clCGC	:= SA1->A1_CGC
					clNome	:= SA1->A1_NOME
					clINSCR := SA1->A1_INSCR
					clEnd	:= SA1->A1_END
					clBairro:= SA1->A1_BAIRRO
					clMun	:= SA1->A1_MUN
				Else
					DbSelectArea("SA2")
					DbSetOrder(1)
					DbSeek(xFilial("SA2")+(cAliasSD1)->(D1_FORNECE+D1_LOJA))
					clCEP	:= SA2->A2_CEP
					clEST	:= SA2->A2_EST
					clCGC	:= SA2->A2_CGC
					clNome	:= SA2->A2_NOME
					clINSCR := SA2->A2_INSCR
					clEnd	:= SA2->A2_END
					clBairro:= SA2->A2_BAIRRO
					clMun	:= SA2->A2_MUN

				EndIf


			EndIf
			//INCLUI OS ITENS
			alReg1		:= {}
			llGrvItem := .F.
			AADD(alReg1,1)
			AADD(alReg1,val(clFil))
			AADD(alReg1,(cAliasSD1)->D1_DOC)	//clPed
			AADD(alReg1,"")
			AADD(alReg1,"P")				//5
			AADD(alReg1,SM0->M0_CGC)
			AADD(alReg1,val(clDoc))
			AADD(alReg1,clSerie)
			AADD(alReg1,IIF(alltrim((cAliasSD1)->D1_ESPECIE) == 'SPED',"0055","1/1A"))
			AADD(alReg1,(cAliasSD1)->D1_COD )				//10
			AADD(alReg1,iif(!Empty(cCodSY9),alltrim(cCodSY9),clCGC))   //SM0->M0_CGC)	//enviar o cnpj do fornecedor 
			AADD(alReg1,(cAliasSD1)->D1_QUANT)
			AADD(alReg1,substr(ALLTRIM((cAliasSD1)->B1_XDESC),1,49) )
			AADD(alReg1,0)
			AADD(alReg1,0)			//15
			AADD(alReg1,0)
			AADD(alReg1,0)
			AADD(alReg1,(cAliasSD1)->TOTAL)
			AADD(alReg1,"NP")
			AADD(alReg1,DTOS(DATE()))					//20
			AADD(alReg1,STRTRAN(TIME(),":",""))
			AADD(alReg1," ")
			
			clTabWMS := "TB_FRTINTERFITENSNOTAS"
			
			clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS,Nil,Nil)
			
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
					llGrvItem := .T.
				EndIf
			Else
				TcSqlExec("ROLLBACK")
			EndIf
			
			(cAliasSD1)->(dbskip())
		End
		lItcOK	:= .T.
		
		If lItcOK
			clQuery	:= " SELECT F1_FILIAL, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA,
			clQuery	+= " F1_ESPECIE, F1_PBRUTO, F1_CHVNFE, F1_TIPO, F1_TRANSP, F1_EMISSAO,
			clQuery	+= " F1_VALBRUT, F1_VOLUME1, F1_TPFRETE
			clQuery	+= " FROM SF1010
			clQuery	+= " WHERE D_E_L_E_T_ = ' '
			clQuery	+= " AND F1_FILIAL = '"+SUBSTR((cAlias)->CE_COD_CHAVE,1,2)+"'
			clQuery	+= " AND F1_DOC = '"+SUBSTR((cAlias)->CE_COD_CHAVE,3,9)+"'
			clQuery	+= " AND F1_SERIE = '"+SUBSTR((cAlias)->CE_COD_CHAVE,12,3)+"'
			clQuery	+= " AND F1_FORNECE = '"+SUBSTR((cAlias)->CE_COD_CHAVE,15,6)+"'
			clQuery	+= " AND F1_LOJA = '"+SUBSTR((cAlias)->CE_COD_CHAVE,21,2)+"'
			clQuery	+= " AND F1_FORMUL = '"+SUBSTR((cAlias)->CE_COD_CHAVE,23,1)+"'
			Iif(Select(cAliasSF1) > 0,(cAliasSF1)->(dbCloseArea()),Nil)
			DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQuery),cAliasSF1  ,.F.,.T.)
			While (cAliasSF1)->(!eof())
				//ATUALIZAR O CABEÇALHO
				//GERA A TABELA DO FRETES TB_FRTINTERFNOTAS
				alCampos1	:= U_F105RETCMP("RNV",.T.)
				If (cAliasSF1)->F1_TIPO $ 'DB'
					DbSelectArea("SA1")
					DbSetOrder(1)
					DbSeek(xFilial("SA1")+(cAliasSF1)->(F1_FORNECE+F1_LOJA))
					clCEP	:= SA1->A1_CEP
					clEST	:= SA1->A1_EST
					clCGC	:= SA1->A1_CGC
					clNome	:= SA1->A1_NOME
					clINSCR := SA1->A1_INSCR
					clEnd	:= SA1->A1_END
					clBairro:= SA1->A1_BAIRRO
					clMun	:= SA1->A1_MUN
				Else
					DbSelectArea("SA2")
					DbSetOrder(1)
					DbSeek(xFilial("SA2")+(cAliasSF1)->(F1_FORNECE+F1_LOJA))
					clCEP	:= SA2->A2_CEP
					clEST	:= SA2->A2_EST
					clCGC	:= SA2->A2_CGC
					clNome	:= SA2->A2_NOME
					clINSCR := SA2->A2_INSCR
					clEnd	:= SA2->A2_END
					clBairro:= SA2->A2_BAIRRO
					clMun	:= SA2->A2_MUN

				EndIf                                              2
								
				//INCLUSAO DO CABEÇALHO DO DOCUMENTO DE SAIDA NO WMS
				alReg1 := {}
				AADD(alReg1,1)
				AADD(alReg1,val(clFil))
				AADD(alReg1,(cAliasSF1)->F1_DOC) //
				AADD(alReg1,"")   //,"PED"))
				AADD(alReg1,"P")				//5
				AADD(alReg1,SM0->M0_CGC)
				AADD(alReg1,clDoc)
				AADD(alReg1,clSerie)
				AADD(alReg1,iif(ALLTRIM((cAliasSF1)->F1_ESPECIE)=='SPED',"0055","1/1A"))
				AADD(alReg1," ")				//10
				AADD(alReg1,iif(!Empty(cCodSY9),alltrim(cCodSY9),clCGC)) //SM0->M0_CGC) alterado conforme definido com Marcos e Brito
				AADD(alReg1,alltrim(SM0->M0_CEPENT) )//clCEP)
				AADD(alReg1,alltrim(SM0->M0_ESTENT) )//clEST)
				AADD(alReg1,alltrim(SM0->M0_CGC) )//clCGC)
				AADD(alReg1,alltrim(SM0->M0_NOMECOM) ) //clNome)				//15
				AADD(alReg1,STRTRAN(STRTRAN(alltrim(SM0->M0_INSC),".",""),"-","") ) //STRTRAN(clINSCR,".",""))
				AADD(alReg1,Posicione("SA4",1,xFilial("SA4")+(cAliasSF1)->F1_TRANSP,"A4_CGC"))
				AADD(alReg1,"to_date( '"+(cAliasSF1)->F1_EMISSAO+"','YYYYMMDD')")
				AADD(alReg1,"E")
				AADD(alReg1,(cAliasSF1)->F1_VALBRUT)					//20
				AADD(alReg1,(cAliasSF1)->F1_VOLUME1)
				AADD(alReg1,IIF((cAliasSF1)->F1_TPFRETE=='C','1','2'))
				AADD(alReg1,alltrim(SM0->M0_ENDENT) )//clEnd)
				AADD(alReg1,alltrim(SM0->M0_BAIRENT) )//clBairro)
				AADD(alReg1,alltrim(SM0->M0_CIDENT) )//clMun)				//25
				AADD(alReg1," ") //(cAliasSF1)->D1_PEDIDO) //
				AADD(alReg1,(cAliasSF1)->F1_PBRUTO) //PESO
				AADD(alReg1," ")
				AADD(alReg1,0)
				AADD(alReg1," ")                                //30
				AADD(alReg1," ")
				AADD(alReg1,0)
				AADD(alReg1,0)
				AADD(alReg1," ")
				AADD(alReg1," ")                               //35
				AADD(alReg1," ")
				AADD(alReg1,(cAliasSF1)->F1_CHVNFE)
				AADD(alReg1,"NP" )
				AADD(alReg1,DTOS(DATE()))
				AADD(alReg1,STRTRAN(TIME(),":",""))				//40
				AADD(alReg1," ")
				AADD(alReg1,(cAlias)->CE_COD_CHAVE)
				AADD(alReg1,"N")
				
				clTabWMS := "TB_FRTINTERFNOTAS"
				
				clQuery := U_EXESQL105(1,alCampos1,alReg1,clTabWMS,Nil,Nil)
				
				If !Empty(clQuery)
					If TcSqlExec(clQuery) >= 0
						TcSqlExec("COMMIT")
						llGrvCab := .T.
					Else
						TcSqlExec("ROLLBACK")
						Exit
					EndIF
				Else
					TcSqlExec("ROLLBACK")
					Exit
				EndIF
				
				(cAliasSF1)->(dbskip())
			End
			lCbcOK	:= .T.
		EndIf
		(cAlias)->(dbskip())
		If lItcOK .and. lCbcOK
			//		Atualizar o status da integração
			alCampos1	:= {}
			aadd(alCampos1,"STATUS")
			aadd(alCampos1,"DESC_ERRO")
			alReg1:= {}
			aadd(alReg1,'P')
			aadd(alReg1,' ')
			clTabWMS := "TB_WMSINTERF_CONF_ENTRADA"
			clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
			If !Empty(clQuery)
				If TcSqlExec(clQuery) >= 0
					TcSqlExec("COMMIT")
				Else
					TcSqlExec("ROLLBACK")
				EndIF
			EndIF
		EndIf
		lItcOK	:= .F.
		lCbcOK	:= .F.
	Else
		//		Atualizar o status da integração
		alCampos1	:= {}
		aadd(alCampos1,"STATUS")
		aadd(alCampos1,"DESC_ERRO")
		alReg1:= {}
		aadd(alReg1,'P')
		aadd(alReg1,' ')
		clTabWMS := "TB_WMSINTERF_CONF_ENTRADA"
		clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
		If !Empty(clQuery)
			If TcSqlExec(clQuery) >= 0
				TcSqlExec("COMMIT")
			Else
				TcSqlExec("ROLLBACK")
			EndIF
		EndIF
		(cAlias)->(dbskip())
		
	EndIf
	
End

Return()

