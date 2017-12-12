#INCLUDE "protheus.ch" 

#define CRLF CHR(13)+CHR(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MMENSZ01  �Autor  �Microsiga           � Data �  02/06/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


//***************
//Inclus�o de TES
//***************
User Function MMENSZ01

Local aDados		:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem

//***************
//Altera��o de TES
//***************
User Function MMENSZ02

Local aDados		:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem


//***************
//Inclus�o do Portador 
//***************
User Function MMENSZ03

Local aDados	:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem


//***************
//Altera��o do CLIENTE
//***************
User Function MMENSZ04

Local aDados		:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem


//***************
//INCLUS�O do PRODUTO
//***************
User Function MMENSZ05

Local aDados		:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem    


//***************
//Altera��o do Cadastro de Produtos.
//***************
User Function MMENSZ06

Local aDados		:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem


//***************
//Altera��o do Cadastro de Fornecedores
//***************
User Function MMENSZ07

Local aDados	:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem
