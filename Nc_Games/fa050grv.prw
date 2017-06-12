/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA050GRV  ºAutor  ³Hermes Ferreira     º Data ³  20/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada apos gerar um titulo relacionada a uma ver-º±±
±±º          ³ba, faz o bloqueio do titulo e gerar alçada de aprovação    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FA050GRV()
	
	Local aAreaSE2		:= SE2->(GetArea())
	Local cChaveTIT		:= ""
	Local cVerba		:= ""
	Local cVersao		:= ""
	Local nValorTIT		:= 0
	
	Local cPrefxVerba	:= U_MyNewSX6(	"NCG_000017"	 								,;
										"VER"											,;
										"C"												,;
										"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
										"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
										"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
										.F. )
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If Alltrim(SE2->E2_PREFIXO) == Alltrim(cPrefxVerba)

		cChaveTIT := SE2->(E2_FORNECE + E2_LOJA + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO)
	
		cVerba		:=	SE2->E2_YVPC	
		cVersao 	:= 	SE2->E2_YVERVPC	
		nValorTIT	:=	SE2->E2_VALOR

		If !Empty(cVerba) .and. !Empty(cVersao)
		
			lAlcada := U_GETALCAVPC(nValorTIT,"1",cPrefxVerba,cChaveTIT,6,"SE2",cVerba,cVersao)
	
			SE2->(RecLock("SE2",.F.))
				// Para que seja bloqueado o titulo, o parâmetro MV_CTLIPAG deve estar igual .T. e o campo em branco
				//SE2->E2_DATALIB	:= IIF( lAlcada, CtoD("  /  /  ")	, MSDate() )
				SE2->E2_DATALIB	:= CtoD("  /  /  ")	 // Sempre deve bloquear este tipo de titulo
			SE2->(MsUnLock())
			
			Aviso("FA050GRV - 02", IIF(lAlcada,"Foi gerado","Não foi gerado")+" controle de alçada VPC/VERBA para este Título.",{"Ok"},3)
			
		Else // Se não for VPC, não bloqueia o Título ou se não tiver sido relacionado a uma verba
		
			SE2->E2_DATALIB	:= MSDate()
			
		EndIf
	
		
	EndIf
	
	RestArea(aAreaSE2)
	
Return
