#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 12/11/01

User Function FIN150_1()        // incluido pelo assistente de conversao do AP5 IDE em 12/11/01

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
Local _aArea:=GetArea()
SetPrvt("NSEQ,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴敲굇
굇튡rograma  � FIN150_1 � Autor � WALTER C. SILVA        � Data � 15/09/99볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴묽�
굇튒escricao � Evita que seja acrescentado 2 (dois) , no sequencial da    볍�
굇�          � linha detalhe, quando mudar de t죜ulo.                     볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � CNAB Modelo 2 - Banco Finasa                               볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
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

