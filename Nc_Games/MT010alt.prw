#INCLUDE "RWMAKE.CH"
#include "Protheus.ch"
#include "TOPCONN.CH"
#include "TbiConn.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT010ALT  �Autor  �ERICH BUTTNER       � Data �  22/07/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � PONTO DE ENTRADA UTILIZADO NA ALTERACAO DE CADASTRO DE     ���
���			 � PRODUTO ONDE IRA VERIFICAR A EXISTENCIA DA AMARRACAO DE 	  ���
���			 � PRODUTO X FORNECEDOR, CASO NAO EXISTE INCLUI				  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT010ALT()

Local aArea	  := GetArea()
Local cPROD   := ALLTRIM(SB1->B1_COD)
Local CFORNEC := "000184"
Local CLOJA   := "02"
Local aDados  := {}
Local cMostSit:= SB1->B1_XMOSTSI //1="SIM AMBOS";2="NAO AMBOS";3="SO LATAM";4="SO BRASIL"


U_PR121SB1(SB1->B1_COD,cMostSit) //Altera��o do produto na tabela ZC3 - Itens que v�o para o Site


//Chama a rotina para alterar o produto software (Projeto Software e Midia)
//MsgRun("Verificando a necessidade de criar e/ou alterar o produto Software... ","Aguarde..",{|| U_PEProdSoft(SB1->B1_COD, 4)  })

//TIAGO BIZAN - INCLUS�O DO PRODUTO ALTERADO NA TABELA DE INTEGRA��O DO WMS
DBSelectArea("P0A")
P0A->(DBSetOrder(1))
If SB1->B1_TIPO == 'PA'
	
	// Incluido por Marcio A.Zechetti - 12/09/2012
	RecLock("SB1",.F.)
	SB1->B1_INTEGRA := "N"
	MsUnLock()
	//--------------------
	
	If P0A->(RecLock("P0A",.T.))
		P0A->P0A_FILIAL	:= xFilial("P0A")
		P0A->P0A_CHAVE	:= SB1->B1_FILIAL+SB1->B1_COD
		P0A->P0A_TABELA	:= "SB1"
		P0A->P0A_EXPORT := '2'
		P0A->P0A_INDICE	:= 'B1_FILIAL+B1_COD'
		P0A->P0A_TIPO	:= '2'
		P0A->(MsUnlock())
	EndIF
	SB1->( U_PR109Grv("SB1",SB1->B1_FILIAL+SB1->B1_COD,"3"))//incluir produto no WMS Store
	If SB1->B1_TIPO == 'PA'
		U_PR117Copia(.F.)
	ENDIF	
EndIF
P0A->(DBCloseArea())


DBSELECTAREA("SA5")
DBSETORDER(1)
IF !DBSEEK(XFILIAL("SA5")+CFORNEC+CLOJA+CPROD) .AND. (SB1->B1_LOCPAD == '01' .OR. SB1->B1_LOCPAD == '04')
	RECLOCK("SA5",.T.)
	SA5->A5_FILIAL := xFilial("SA5")
	SA5->A5_FORNECE	:= CFORNEC
	SA5->A5_LOJA	:= CLOJA
	SA5->A5_NOMEFOR	:= "NC GAMES & ARCADES OF AMERICA, INC"
	SA5->A5_PRODUTO	:= CPROD
	SA5->A5_TIPATU	:= "0"
	SA5->A5_NOMPROD	:= SB1->B1_DESC
	MSUNLOCK()
ENDIF

aadd(aDados,"Aviso de altera��o do Cadastro de Produtos")
aadd(aDados,"Filial: "+xFilial("SB1"))
aadd(aDados,"C�digo: "+SB1->B1_COD)
aadd(aDados,"Descri��o: "+SB1->B1_DESC)
aadd(aDados,"Conta Contabil: "+SB1->B1_CONTA)
aadd(aDados,"Alterado por: "+cUsername)
MEnviaMail("Z06",aDados)
RestArea(aArea)

Return
