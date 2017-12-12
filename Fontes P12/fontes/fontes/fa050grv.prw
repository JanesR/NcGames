/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA050GRV  �Autor  �Hermes Ferreira     � Data �  20/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada apos gerar um titulo relacionada a uma ver-���
���          �ba, faz o bloqueio do titulo e gerar al�ada de aprova��o    ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
				// Para que seja bloqueado o titulo, o par�metro MV_CTLIPAG deve estar igual .T. e o campo em branco
				//SE2->E2_DATALIB	:= IIF( lAlcada, CtoD("  /  /  ")	, MSDate() )
				SE2->E2_DATALIB	:= CtoD("  /  /  ")	 // Sempre deve bloquear este tipo de titulo
			SE2->(MsUnLock())
			
			Aviso("FA050GRV - 02", IIF(lAlcada,"Foi gerado","N�o foi gerado")+" controle de al�ada VPC/VERBA para este T�tulo.",{"Ok"},3)
			
		Else // Se n�o for VPC, n�o bloqueia o T�tulo ou se n�o tiver sido relacionado a uma verba
		
			SE2->E2_DATALIB	:= MSDate()
			
		EndIf
	
		
	EndIf
	
	RestArea(aAreaSE2)
	
Return
