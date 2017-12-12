#include "rwmake.ch"       

User Function CNAB3()        

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �   CNAB2  � Autor � WALTER C. SILVA        � Data � 13/09/99���
�������������������������������������������������������������������������͹��
���Descri��o � Incrementa 1 (Hum) no sequencial de linha detalhe          ���
�������������������������������������������������������������������������͹��
���Observacao� Deve ser utilizado em conjunto com o P.E. FIN150_1, para   ���
���          � que n�o seja acrescentado 2 (dois) quando mudar de t�tulo. ���
�������������������������������������������������������������������������͹��
���Uso       � Banco Brasil                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Local _aArea:=GetArea()
Local _nRet :=0
dbSelectArea("SEE")
SEE->( dbSeek(xFilial()+mv_par05+mv_par06+mv_par07+mv_par08) )
Reclock("SEE",.F.)
	SEE->EE_SEQ:=1
MsUnlock()
_nRet:=Strzero(SEE->EE_SEQ,5)
RestArea(_aArea)
Return(_nRet)