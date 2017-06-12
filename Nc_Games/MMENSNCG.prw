#INCLUDE "protheus.ch" 

#define CRLF CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMMENSZ01  บAutor  ณMicrosiga           บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


//***************
//Inclusใo de TES
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
//Altera็ใo de TES
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
//Inclusใo do Portador 
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
//Altera็ใo do CLIENTE
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
//INCLUSรO do PRODUTO
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
//Altera็ใo do Cadastro de Produtos.
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
//Altera็ใo do Cadastro de Fornecedores
//***************
User Function MMENSZ07

Local aDados	:= PARAMIXB[1]
Local cMensagem	:= PARAMIXB[2]
Local nX		:= 0

For nX:=1 to len(aDados)
	cMensagem += aDados[nX]+CRLF
Next nX

Return cMensagem
