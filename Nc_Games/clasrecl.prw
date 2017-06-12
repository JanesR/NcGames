# include "protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Classe_PCO     �Autor  �Microsiga      � Data �  12/27/11   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna Classe Or�ament�ria da Receita Liquida.            ���
���          � conforme SubGrupo do Produto Cliente NC Games              ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function Clas_recl()

Local _Classe := "0"
 
If SB1->B1_SBCATEG $ "11"
  _Classe := "500001"

ElseIf SB1->B1_SBCATEG $ "12"
  _Classe := "500002"

ElseIf SB1->B1_SBCATEG $ "13"
  _Classe := "500003"                                                         

ElseIf SB1->B1_SBCATEG $ "24"
  _Classe := "500010"

ElseIf SB1->B1_SBCATEG $ "80"
  _Classe := "500020"                                                         

ElseIf SB1->B1_SBCATEG $ "87"
  _Classe := "500021"                                                         

ElseIf SB1->B1_SBCATEG $ "88"
  _Classe := "500022"                                                         

ElseIf SB1->B1_SBCATEG $ "89"
  _Classe := "500023"                                                         

ElseIf SB1->B1_SBCATEG $ "97"
 _Classe := "500030"

ElseIf SB1->B1_SBCATEG $ "98"
 _Classe := "500031"

ElseIf SB1->B1_SBCATEG $ "99"
 _Classe := "500032" 
  
Else
  _Classe := "0"   

EndIf 

return (_Classe)