#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'
#define clr Chr(13)+Chr(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA040GRV  �Autor  �Hermes Ferreira     � Data �  19/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada apos gerar um titulo relacionado a um VPC  ���
���          �, faz o bloqueio do titulo e gerar al�ada de aprova��o      ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FA040GRV()
	
	Local aAreaSE1		:= SE1->(GetArea())
	Local cChaveTIT 	:= ""
	Local cPrefixoVPC	:= Alltrim(U_MyNewSX6(	"NCG_000016"							,;
										"VPC"											,;
										"C"												,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										.F. ))

	Local cTipoTIT	:= Alltrim(U_MyNewSX6(	"NCG_000018"		 						,;
										"NCC"											,;
										"C"												,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										.F. ))
	Local cVPC 		:= ""
	Local cVersao	:= ""
	Local nValorTIT	:= 0
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	If Alltrim(SE1->E1_TIPO) $ cTipoTIT .AND. Alltrim(SE1->E1_PREFIXO) == Alltrim(cPrefixoVPC)
	
		cChaveTIT := SE1->(E1_CLIENTE+ E1_LOJA + E1_PREFIXO + E1_NUM + E1_PARCELA + E1_TIPO)
		
		cVPC 		:= SE1->E1_YVPC
		cVersao		:= SE1->E1_YVERVPC
		nValorTIT	:= SE1->E1_VALOR

		If !Empty(cVPC) .and. !Empty(cVersao)
		
			lAlcada := U_GETALCAVPC(nValorTIT,"1",cPrefixoVPC,cChaveTIT,2,"SE1",cVPC,cVersao)
		
			SE1->(RecLock("SE1",.F.))
				
				//If lAlcada  // sempre devera bloquear este tipo de titulo
					
					SE1->E1_YBLQVPC	:= 'S'
					SE1->E1_YDTBLQ	:= MsDate()
				//EndIf
				
			SE1->(MsUnLock())
			
			Aviso("FA040GRV - 01", IIF(lAlcada,"Foi gerado","N�o foi gerado")+" controle de al�ada VPC/VERBA para este T�tulo.",{"Ok"},3)
						
		EndIf
	
	EndIf
	
	RestArea(aAreaSE1)
	
Return


