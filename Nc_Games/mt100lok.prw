#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �MT100LOK� Ponto de Entrada na troca da linha do documento de entrada para���
���             �        � recalcular o valor da base e imposto relativo ao ICMS-ST       ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �12/10/12� Almir Bandina                                                  ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  �                                                                         ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     � ExpL1 - Retorna linha Ok ou n�o                                         ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es � � passado via par�metro a situa��o de valida��o anterior                ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  � 99/99/99 - Consultor - Descri��o da altera��o                           ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
User Function MT100LOK( nLinha )
//�����������������������������������������������������������������������������������������Ŀ
//� Vari�veis utilizadas na rotina                                                          �
//�������������������������������������������������������������������������������������������
Local aAreaAtu	:= GetArea()
Local aAreaSD2	:= SD2->( GetArea() )
Local lRetorno	:= PARAMIXB[1]
Local cDocOri	:= ""
Local cSerOri	:= ""
Local cCliOri	:= cA100For
Local cLojOri	:= cLoja
Local cCodPro	:= ""
Local cIteOri	:= ""

Default nLinha	:= n
//�����������������������������������������������������������������������������������������Ŀ
//� Obtem os dados digitados no item                                                        �
//�������������������������������������������������������������������������������������������
cDocOri	:= GdFieldGet( "D1_NFORI",		nLinha,, aHeader, aCols )
cSerOri	:= GdFieldGet( "D1_SERIORI",	nLinha,, aHeader, aCols )
cCodPro	:= GdFieldGet( "D1_COD",		nLinha,, aHeader, aCols )
cIteOri	:= GdFieldGet( "D1_ITEMORI",	nLinha,, aHeader, aCols )
//�����������������������������������������������������������������������������������������Ŀ
//� S� executa se n�o tiver erro anterior da fun��o padr�o                                  �
//�������������������������������������������������������������������������������������������
If lRetorno
	//�������������������������������������������������������������������������������������Ŀ
	//� Verifica se a nota de origem existe o c�lculo do ICMS-ST diferenciado               �
	//���������������������������������������������������������������������������������������
	dbSelectArea( "SD2" )
	dbSetOrder( 3 )		//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
	If MsSeek( xFilial( "SD2" ) + cDocOri + cSerOri + cCliOri + cLojOri + cCodPro + cIteOri )
		If SD2->( FieldPos( "D2_YSPFIS" ) ) <> 0 .And. !Empty( SD2->D2_YSPFIS )
			//�����������������������������������������������������������������������������Ŀ
			//� Chama rotina que efetua os c�lculos do ICMS-ST                              �
			//�������������������������������������������������������������������������������
			lRetorno	:= U_NCGPR001( nLinha )
		EndIf
	EndIf
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Restaura as �reas originais                                                             �
//�������������������������������������������������������������������������������������������
Restarea( aAreaSD2 )
RestArea( aAreaAtu )

Return( lRetorno )
