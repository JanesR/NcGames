#include "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
��� Prog     � F460SE1  � Autor � Rogerio-Supertech  � Data �Mon  10/05/10���
�������������������������������������������������������������������������͹��
���Descri��o � Retorna os dados do titulo gerador da liquidacao           ���
�������������������������������������������������������������������������͹��
���Uso       � Espec�fico para clientes Microsiga                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


USER FUNCTION F460SE1()

	ACOLS[N,2]:=  "NF"
	ACOLS[N,3]:=  "111"
	ACOLS[N,4]:=  "1111"
	ACOLS[N,5]:=  "111111"
	ACOLS[N,6]:=  SE1->E1_NUM
	ACOLS[N,7]:=  SE1->E1_VENCREA
	ACOLS[N,8]:=  "NC GAMES"
   //	cNum	:=	SE1->E1_NUM
//	dVcto	:=	SE1->E1_VENCREA
	
Return