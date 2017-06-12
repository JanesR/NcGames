
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ A261TOK   ºAutor  ³ Tiago Bizan       º Data ³  21/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de Entrada antes de realizar as trasnferencias de    º±±
±±º          ³ Estoque                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A261TOK()
	Local llRet		:= .F.
	Local clArmz	:= SuperGetMV("MV_ARMWMAS",.F.,'01')
	Local cFiliais	:= SuperGetMV("NCG_000030",.F.,'03')
	Local llBlQ		:= .F.
	Local llCnt		:= .T.
	Local nlCabecC5	:= 0
	Local nlCabecF1	:= 0
	Local llAtuWMS	:= .F.
	
	If IsInCallStack("U_FRETDOCENT") .OR. IsInCallStack("U_FTROCAEST")
		Return(.T.)
	Else
		If xFilial("SD3") $ FormatIN(cFiliais,"|")
			For nI := 1 to len(aCols)
			    
		 		IF len(aCols)==1
			 		If aCols[nI,4] $ clArmz .AND. aCols[nI,9] $ clArmz .AND. !aCols[nI,len(aHeader)+1]
						/**************************************************************************************************
						| Não deve ser permitido realizar transferencias entre armazens controlados pelo WMS			  |
						**************************************************************************************************/  		
						MSGINFO("Transferências entre armazéns controlados pelo sistema WMS não são aceitas."+chr(13)+chr(10)+"Armazens controlados WMS: "+clArmz+chr(13)+chr(10))
						llBlQ := .T.
					EndIF
				EndIF
							
				If !llBlQ
					IF aCols[nI,4] $ clArmz .AND. aCols[nI,9] $ clArmz .AND. !aCols[nI,len(aHeader)+1]	
						/**************************************************************************************************
						| Não deve ser permitido realizar transferencias entre armazens controlados pelo WMS			  |
						**************************************************************************************************/  		
						MSGINFO("Transferências entre armazéns controlados pelo sistema WMS não são aceitas."+chr(13)+chr(10)+"Armazens controlados WMS: "+clArmz+chr(13)+chr(10)+"O registro será desconsiderado na trasnferencia.")
						aCols[nI,len(aHeader)+1] := .T.
						oGet:Refresh()
						
					ElseIf aCols[nI,4] $ clArmz .AND. !(aCols[nI,9] $ clArmz) .AND. !aCols[nI,len(aHeader)+1]
						/**************************************************************************************************
						| Transferencias entre os armazens controlados pelo WMS para os armazens controlados pelo PRotheus|
						| deve-se gerar as tabelas TB_WMSINTERF_DOC_SAIDA e TB_WMSINTERF_DOC_SAIDA_ITENS				  |	 
						**************************************************************************************************/
			           	//
			           	If nlCabecC5 == 0
				           	alCampos	:= {}
				           	alReg		:= {}
				           	alCampos	:= U_F105RETCMP("SC5",.T.)           	
							AADD(alReg,1)
							AADD(alReg,3)
							AADD(alReg,cDocumento)
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,DDATABASE)
							AADD(alReg,0)
							AADD(alReg,0)
							AADD(alReg,0)
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,0)
							AADD(alReg,"NP")
							AADD(alReg,"")																												
							clQuery		:= U_EXESQL105(1,alCampos,alReg,"TB_WMSINTERF_DOC_SAIDA")
							
							If !Empty(clQuery)
								If TcSqlExec(clQuery) >= 0
									llAtuWMS := .T.
									nlCabecC5 := 1
								Else
									MostraERRO()
									llAtuWMS := .F.
								EndIf
							EndIf
						EndIF
						
						If llAtuWMS
							alCampos1	:= {}
							alReg1		:= {}
							alCampos1	:= U_F105RETCMP("SC6",.T.)			
							AADD(alReg1,0)
							AADD(alReg1,3)
							AADD(alReg1,cDocumento)
							AADD(alReg1,"")
							AADD(alReg1,DDATABASE)
							AADD(alReg1,0)
							AADD(alReg1,0)
							AADD(alReg1,0)
							AADD(alReg1,ALLTRIM(aCols[nI,GDFieldPos("D3_COD")]))
							AADD(alReg1,"")
							AADD(alReg1,aCols[nI,9]) //armazem de destino
							AADD(alReg1,aCols[nI,GDFieldPos("D3_QUANT")])
							AADD(alReg1,'NP')
							AADD(alReg1,"")																					
							clQuery1	:= U_EXESQL105(1,alCampos1,alReg1,"TB_WMSINTERF_DOC_SAIDA_ITENS")
							
							If !Empty(clQuery1)
								If TcSqlExec(clQuery1) >= 0
									TcSqlExec("COMMIT")
									llRet := .T.
								Else
									TcSqlExec("ROLLBACK")
									MostraERRO()
								EndIF
							EndIF
						EndIF					
							
					ElseIF !(aCols[nI,4] $ clArmz) .AND. aCols[nI,9] $ clArmz .AND. !aCols[nI,len(aHeader)+1]
						/**************************************************************************************************
						| Transferencias entre os armazens controlados pelo Protheus para os armazens controlados pelo WMS|
						| deve-se gerar as tabelas TB_WMSINTERF_DOC_ENTRADA e TB_WMSINTERF_DOC_ENTRADA_ITENS			  |	 
						**************************************************************************************************/
						If nlCabecF1 == 0
							alCampos	:= {}
				           	alReg		:= {}
				           	alCampos	:= U_F105RETCMP("SF1",.T.)           	
							AADD(alReg,1)
							AADD(alReg,3)
							AADD(alReg,cDocumento)
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,DDATABASE)
							AADD(alReg,0)
							AADD(alReg,0)
							AADD(alReg,0)
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,"NP")
							AADD(alReg,"")
							AADD(alReg,"")
							AADD(alReg,0)
							AADD(alReg,0)
							AADD(alReg,0)														
							clQuery		:= U_EXESQL105(1,alCampos,alReg,"TB_WMSINTERF_DOC_ENTRADA")
			                
			                If !Empty(clQuery)
								If TcSqlExec(clQuery) >= 0
			                    	nlCabecF1 := 1
			                    	llAtuWMS := .T.
			     				Else
			     					llAtuWMS := .F.		
			     					MostraERRO()
								EndIF						
							EndIF
						EndIF
						
						IF llAtuWMS
							alCampos1	:= {}
							alReg1		:= {}
							alCampos1	:= U_F105RETCMP("SD1",.T.)			
							AADD(alReg1,0)
							AADD(alReg1,3)
							AADD(alReg1,cDocumento)
							AADD(alReg1,"")
							AADD(alReg1,DDATABASE)
							AADD(alReg1,0)
							AADD(alReg1,0)
							AADD(alReg1,0)
							AADD(alReg1,ALLTRIM(aCols[nI,GDFieldPos("D3_COD")]))
							AADD(alReg1,"")
							AADD(alReg1,aCols[nI,9]) //armazem de destino
							AADD(alReg1,aCols[nI,GDFieldPos("D3_QUANT")])
							AADD(alReg1,'NP')
							AADD(alReg1,"")							
							AADD(alReg1,0)		
							clQuery1	:= U_EXESQL105(1,alCampos1,alReg1,"TB_WMSINTERF_DOC_ENTRADA_ITENS")
							
							If !Empty(clQuery1)
								If TcSqlExec(clQuery1) >= 0
									TcSqlExec("COMMIT")
									llRet := .T.
								Else
									TcSqlExec("ROLLBACK")
									MostraERRO()
								EndIF
							EndIF
						EndIF
						
					Else
				   		llRet := .T.				 
					EndIF
				Else
					Exit			
				EndIF
			
			Next nI
	 	
		Else
			llRet := .T.
		EndIF
	EndIF
Return(llRet)