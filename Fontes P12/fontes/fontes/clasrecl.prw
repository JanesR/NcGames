# include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Classe_PCO     ºAutor  ³Microsiga      º Data ³  12/27/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna Classe Orçamentária da Receita Liquida.            º±±
±±º          ³ conforme SubGrupo do Produto Cliente NC Games              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function Clas_recl()

Local _Classe := "0"
 
If SB1->B1_SBCATEG $ "11"
  _Classe := "500001"

ElseIf SB1->B1_SBCATEG $ "12"
  _Classe := "500002"

ElseIf SB1->B1_SBCATEG $ "13"
  _Classe := "500003"                                                         

ElseIf SB1->B1_SBCATEG $ "24"
  _Classe := "500010"

ElseIf SB1->B1_SBCATEG $ "80"
  _Classe := "500020"                                                         

ElseIf SB1->B1_SBCATEG $ "87"
  _Classe := "500021"                                                         

ElseIf SB1->B1_SBCATEG $ "88"
  _Classe := "500022"                                                         

ElseIf SB1->B1_SBCATEG $ "89"
  _Classe := "500023"                                                         

ElseIf SB1->B1_SBCATEG $ "97"
 _Classe := "500030"

ElseIf SB1->B1_SBCATEG $ "98"
 _Classe := "500031"

ElseIf SB1->B1_SBCATEG $ "99"
 _Classe := "500032" 
  
Else
  _Classe := "0"   

EndIf 

return (_Classe)