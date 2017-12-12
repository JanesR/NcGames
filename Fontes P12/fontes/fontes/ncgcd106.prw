#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGCD106  � Autor � FELIPE V. NAMBARA  � Data �  27/09/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de plataformas de jogos                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � GHT - TECNOLOGIA DA INFORMA��OO                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function NCGCD106()

Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.
Private cString := "SZ5"

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

Begin Sequence

	dbSelectArea("SZ5")
	dbSetOrder(1)
		
	AxCadastro(cString,"Cadastro de plataformas de jogos",cVldExc,cVldAlt)
	
End Sequence

Return()