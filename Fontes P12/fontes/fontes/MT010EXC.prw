#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RProdSoft  � Autor �ELTON SANTANA		    � Data � 02/09/13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna os campos da tabela de acordo com o SX3		      ���
���			 � 												  			  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                         

User Function MT010EXC()
Local aArea 	:= GetArea()
Local cAliasZC3:=ZC3->( GetArea())
Local cMostSit	:= SB1->B1_XMOSTSI

U_PR121SB1(SB1->B1_COD,cMostSit) //Exclus�o do produto na tabela ZC3 - Itens que v�o para o Site

//Chama a rotina para excluir o produto software (Projeto Software e Midia)
MsgRun("Verificando se existe produto (Software) a ser exclu�do... ","Aguarde..",{|| U_PEProdSoft(SB1->B1_COD, 5)  })


RestArea(cAliasZC3)
RestArea(aArea)
Return
