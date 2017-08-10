
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ MT100AG   ºAutor  ³ Tiago Bizan       º Data ³  15/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Após realizar a classificação do Documento o mesmo         º±±
±±º          ³ deve ser enviado ao WMS					                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function MT100AG()
Local clArea	:= GetArea()

GravarInterface()

RestArea(clArea)
Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT100AG   ºAutor  ³Microsiga           º Data ³  05/14/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravarInterface()
Local clArea		:= GetArea()
Local cFilStore	:= Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local clArmz		:= SuperGetMV("MV_ARMWMAS") //
Local clArmzCQ		:= SuperGetMV("MV_CQ") //
Local clDoc			:= PADR(cNFiscal,TAMSX3("F1_DOC")[1])
Local clSerie		:= PADR(cSerie,TAMSX3("F1_SERIE")[1])
Local cFiliais		:= SuperGetMV("NCG_000030",.F.,"03")
Local cArmWmas 	:= GETMV("MV_ARMWMAS")
Local clFil			:= xFilial("SF1")
Local clForn		:= cA100For
Local clLoja		:= cLoja
Local clFormul		:= cFormul
Local clTipoNF		:= cTipo
Local aItePed		:= {}
Local lWmsStore	:=(cFilAnt$cFilStore)
Local lGravarNFE	:=.F.
Local llSF1			:= .F.
Local nI

/************************************************************************************************************
| Só deve realizar as validações caso este ponto de entrada seja chamado pela 								|
| rotina de Classificação de Documento ou Inclusão de documento, que esta dentro do Documento de entrada	|
************************************************************************************************************/
If (clTipoNF $ 'CIP') //  C/I/P
	Return
EndIf

If !( IsIncallStack("MATA103") .AND. !IsIncallStack("A140ESTCLA") .AND. ( INCLUI .OR. ALTERA )) // NA EXCLUSÃO NÃO DEVE GERAR A P0A, A ALTERAÇÃO É A
	Return
EndIf

// CLASSIFICAÇÃO DA NOTA, A INCLUSÃO É A GERAÇÃO DO
// DOC.ENTRADA SEM A GERAÇÃO DA PRÉ-NOTA
If clFil $ FormatIN(cFiliais,"|")
	
	Begin Transaction
	
	P0A->(DBSetOrder(1))
	
	For nI := 1 to len(aCols)
		
		If GDDeleted(nI)  //SOMENTE OS ITENS NÃO DELETADOS
			Loop
		EndIf
		
		If !Posicione("SB1",1,xFilial("SB1")+aCols[nI,GDFieldPos("D1_COD")],"B1_TIPO") == "PA"//SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
			Loop
		EndIf
		//SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
		If !Posicione("SF4",1,xFilial("SF4")+aCols[nI,GDFieldPos("D1_TES")],"F4_ESTOQUE") == "S"
			Loop
		EndIf
		//SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS)
		If ! ( aCols[nI,GDFieldPos("D1_LOCAL")] $ FORMATIN(clArmz,"/") .OR. aCols[nI,GDFieldPos("D1_LOCAL")] $ FORMATIN(clArmzCQ,"/") )
			Loop
		EndIf
		
		If aCols[nI,GDFieldPos("D1_QUANT")]==0
			Loop
		EndIf
		//tratamento para não enviar produtos duplicados
		If (nPos := Ascan( aItePed, { |x| clFil+clDoc+clSerie+clForn+clLoja+aCols[nI,GDFieldPos("D1_COD")]+clFormul $ x[1] } ) ) == 0
			aadd(aItePed,{clFil+clDoc+clSerie+clForn+clLoja+aCols[nI,GDFieldPos("D1_COD")]+clFormul,1})
			P0A->(RecLock("P0A",.T.))
			P0A->P0A_FILIAL	:= xFilial("P0A")
			P0A->P0A_CHAVE		:= clFil+clDoc+clSerie+clForn+clLoja+aCols[nI,GDFieldPos("D1_ITEM")]+clFormul
			P0A->P0A_TABELA	:= "SD1"
			P0A->P0A_EXPORT 	:= '2'
			P0A->P0A_INDICE	:= 'D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_ITEM+D1_FORMUL'
			P0A->P0A_TIPO		:= '1'
			P0A->(MsUnlock())
			llSF1:=.T.			
		Else			
			aItePed[nPos,2] += 1
		EndIf
		
		U_NCVTEX03(aCols[nI,GDFieldPos("D1_COD")])
		//JR
		u_sndPrdUnic(aCols[nI,GDFieldPos("D1_COD")],aCols[nI,GDFieldPos("D1_LOCAL")])
		
	Next nI
	
	If llSF1
		P0A->(RecLock("P0A",.T.))
		P0A->P0A_FILIAL	:= xFilial("P0A")
		P0A->P0A_CHAVE		:= clFil+clDoc+clSerie+clForn+clLoja+clFormul
		P0A->P0A_TABELA	:= "SF1"
		P0A->P0A_EXPORT 	:= '2'
		P0A->P0A_INDICE	:= 'F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_FORMUL'
		P0A->P0A_TIPO		:= '1'
		P0A->(MsUnlock())
	EndIf
	
	End Transaction
	
	
ElseIf lWmsStore
	
	
	For nI := 1 to len(aCols)
		
		If aCols[nI,len(aHeader)+1]
			Loop
		EndIf
		
		If !Posicione("SB1",1,xFilial("SB1")+aCols[nI,GDFieldPos("D1_COD")],"B1_TIPO") == "PA"//SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
			Loop
		EndIf
		
		If !Posicione("SF4",1,xFilial("SF4")+aCols[nI,GDFieldPos("D1_TES")],"F4_ESTOQUE") == "S" 		//SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
			Loop
		EndIf
		
		If ! ( aCols[nI,GDFieldPos("D1_LOCAL")] $ FORMATIN(cArmWmas,"/") .OR. aCols[nI,GDFieldPos("D1_LOCAL")] $ FORMATIN(clArmzCQ,"/") )//SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS)
			Loop
		EndIf
		
		If aCols[nI,GDFieldPos("D1_QUANT")]==0
			Loop
		EndIf
		
		lGravarNFE:=.T.
		Exit
	Next
	
	If lGravarNFE
		U_PR109Grv("SF1",clFil+clDoc+clSerie+clForn+clLoja+cTipo,"3")
	EndIf
	
EndIf

RestArea(clArea)
Return
