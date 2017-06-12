#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
/*�������������������������������������������������������������������������������������������
���������������������������������������������������������������������������������������������
�����������������������������������������������������������������������������������������ͻ��
��� Programa    �M410SOLI� Ponto de entrada na planilha financeira para execu��o do       ���
���             �        � tratamento espec�fico do ICMS-ST                               ���
�����������������������������������������������������������������������������������������͹��
��� Autor       �06/10/12� Almir Bandina                                                  ���
�����������������������������������������������������������������������������������������͹��
��� Par�metros  � ExpA1 - Atrav�s da PARAMIXB recebe array contendo o n�mero do item      ���
���             �         posicionado.                                                    ���
�����������������������������������������������������������������������������������������͹��
��� Retorno     � ExpA2 - Array contendo 2 elementos                                      ���
���             �         [1] = Valor da Base de C�lculo ICMS Solid�rio                   ���
���             �         [2] = Valor da ICMS Solid�rio                                   ���
�����������������������������������������������������������������������������������������͹��
��� Observa��es � O calculo ser� realizado pelo programa espec�fico                       ���
�����������������������������������������������������������������������������������������͹��
��� Altera��es  � 99/99/99 - Consultor - Descri��o da altera��o                           ���
�����������������������������������������������������������������������������������������ͼ��
���������������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������������*/
User Function M410SOLI()
//�����������������������������������������������������������������������������������������Ŀ
//� Define as vari�veis da rotina                                                           �
//�������������������������������������������������������������������������������������������
Local aRetorno	:= { 0, 0 }
Local nItePed	:= PARAMIXB[1]
Local nPTpOper	:= aScan( aHeader, { |x| AllTrim( x[2] ) == "C6_TPOPER" } )
Local cTpOper	:= CriaVar( "C6_TPOPER", .F. )
//�����������������������������������������������������������������������������������������Ŀ
//� Obtem o Tipo de Opera��o do item                                                        �
//�������������������������������������������������������������������������������������������
If nPTpOper <> 0
	cTpOper	:= aCols[nItePed, nPTpOper]
EndIf
//�����������������������������������������������������������������������������������������Ŀ
//� Executa a Chamada da fun��o que efetua o tratamento esp�c�fico para o ICMS-ST           �
//�������������������������������������������������������������������������������������������
aRetorno	:= U_NCGPR001( nItePed, cTpOper )
//�����������������������������������������������������������������������������������������Ŀ
//� Efetua o retorno da rotina                                                              �
//�������������������������������������������������������������������������������������������
Return( aRetorno )


//ICMSITEM    := MaFisRet(nItePed,"IT_VALICM")		// variavel para ponto de entrada
//QUANTITEM   := MaFisRet(nItePed,"IT_QUANT")		// variavel para ponto de entrada
//BASEICMRET  := MaFisRet(nItePed,"IT_BASESOL")	    // criado apenas para o ponto de entrada
//MARGEMLUCR  := MaFisRet(nItePed,"IT_MARGEM")		// criado apenas para o ponto de entrada
