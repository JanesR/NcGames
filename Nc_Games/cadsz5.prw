#INCLUDE "rwmake.ch"

//+-----------------------------------------------------------------------------------//
//|Empresa...: NCGAMES
//|Funcao....: U_CADSZ5()
//|Autor.....: ERICH BUTTNER
//|Data......: 20 de Janeiro de 2012
//|Uso.......: Geral
//|Versao....: Protheus 10    
//|Descricao.: Cad. Plataformas
//|Observação: 
//+-----------------------------------------------------------------------------------//

*------------------------------------*
User Function CADSZ5()
*------------------------------------*

Private cString := "SZ5"


//aadd(aRotAdic,{ "EXP. EXCEL","U_EXPSZ7", 0 , 6 })


dbSelectArea("SZ5")
SZ5->(dbSetOrder(1))


AxCadastro(cString,  "Cadastro de Plataforma")  


Return  (.T.)           