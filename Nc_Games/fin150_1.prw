#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 12/11/01

User Function FIN150_1()        // incluido pelo assistente de conversao do AP5 IDE em 12/11/01

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������
Local _aArea:=GetArea()
SetPrvt("NSEQ,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � FIN150_1 � Autor � WALTER C. SILVA        � Data � 15/09/99���
�������������������������������������������������������������������������͹��
���Descricao � Evita que seja acrescentado 2 (dois) , no sequencial da    ���
���          � linha detalhe, quando mudar de t�tulo.                     ���
�������������������������������������������������������������������������͹��
���Uso       � CNAB Modelo 2 - Banco Finasa                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

If nSeq > 1
   nSeq := nSeq - 1
Endif

dbSelectArea("SEE")
SEE->( dbSeek(xFilial()+mv_par05+mv_par06+mv_par07+mv_par08) )
IF SEE->EE_BORATU != SE1->E1_NUMBOR .and. SEE->EE_SEQ != 0
	Reclock("SEE",.F.)
		SEE->EE_BORATU:= SE1->E1_NUMBOR
		SEE->EE_SEQ   := 0
		SEE->EE_ULTDSK:=Strzero(Val(SEE->EE_X_ULTD)+1,6)
	MsUnlock()	
EndIF
RestArea(_aArea)
Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 12/11/01

