#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGCD107  � Autor � FELIPE V. NAMBARA  � Data �  27/09/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de tecnologias de jogos                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � GHT - TECNOLOGIA DA INFORMA��OO                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function NCGCD107()

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
Private cString := "SZ9"

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

Begin Sequence

	dbSelectArea("SZ9")
	dbSetOrder(1)
		
	AxCadastro(cString,"Cadastro de tecnologias de jogos",cVldExc,cVldAlt)
	
End Sequence

Return()