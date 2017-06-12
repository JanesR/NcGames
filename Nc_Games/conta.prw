# include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �C.O_PCO     �Autor  �Microsiga      � Data �  12/27/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna a Conta Or�ament�ria conforme Categoria e SubGrupo ���
���          � do Produto - Cliente NC Games                              ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function conta()

Local _Cta := "0"

If SB1->B1_CATEG $ "1" .AND. SB1->B1_SBCATEG $ "11"
_Cta := "61000001"

ElseIf SB1->B1_CATEG $ "1" .AND. SB1->B1_SBCATEG $ "12"
_Cta := "61000002"

ElseIf SB1->B1_CATEG $ "1" .AND. SB1->B1_SBCATEG $ "13"
_Cta := "61000003"

ElseIf SB1->B1_CATEG $ "2" .AND. SB1->B1_SBCATEG $ "24"
_Cta := "62000001"

ElseIf SB1->B1_CATEG $ "8" .AND. SB1->B1_SBCATEG $ "80"
_Cta := "63000001"

ElseIf SB1->B1_CATEG $ "8" .AND. SB1->B1_SBCATEG $ "87"
_Cta := "63000002"

ElseIf SB1->B1_CATEG $ "8" .AND. SB1->B1_SBCATEG $ "88"
_Cta := "63000003"

ElseIf SB1->B1_CATEG $ "8" .AND. SB1->B1_SBCATEG $ "89"
_Cta := "63000004"

ElseIf SB1->B1_CATEG $ "9" .AND. SB1->B1_SBCATEG $ "97"
_Cta := "64000001"

ElseIf SB1->B1_CATEG $ "9" .AND. SB1->B1_SBCATEG $ "98"
_Cta := "64000002"

ElseIf SB1->B1_SBCATEG $ "99" //SB1->B1_CATEG $ "9" .AND. SB1->B1_SBCATEG $ "99"
_Cta := "64000003" 

Else
  _Cta := "0"
EndIf 

return (_Cta)

