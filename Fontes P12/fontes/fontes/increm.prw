#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INCREM	� Autor � Erich Buttner		 � Data �  15/07/10   ���
�������������������������������������������������������������������������͹��
���Descricao � INCREMENTA NUMERO SEQUENCIAL DO CNAB BANCO ATHENA		  ���
���          � 						                                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - NC GAMES											  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function INCREM()
                  
Public c_Ret := getmv("MV_INCREM")

c_Ret :=c_Ret+1

PutMv("MV_INCREM", c_Ret)

Return(c_Ret)      

                      
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INCREM	� Autor � Erich Buttner		 � Data �  15/07/10   ���
�������������������������������������������������������������������������͹��
���Descricao � INCREMENTA NUMERO SEQUENCIAL DO CNAB BANCO ATHENA		  ���
���          � E ZERA O PARAMETRO CRIADO	                              ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - NC GAMES											  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function INCREMMV()

Local c_Ret1 := getmv("MV_INCREM") + 1

c_Ret := 000001

PutMv("MV_INCREM", c_Ret)

Return(c_Ret1) 

