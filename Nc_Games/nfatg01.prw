#include "rwmake.ch"
User Function NFatg01

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NFATG01   ºAutor  ³Microsiga           º Data ³  24/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna percentual de IPI                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Local _aArea:=GetArea()
Local _nIPI := M->B1_IPI

IF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $ "03/06/07/09"
	_nIPI:=0  //_nIPI:=30
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $"05/02/01/04/10" .or. Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO =="MD"
	_nIPI:=0 //_nIPI:=15
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2)=="08" .or. Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2)$ "03/06/11"
	_nIPI:=20
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "CB"
	_nIPI:=5
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "FT"
	_nIPI:=10
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "07/10"
	_nIPI:=40
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "01/04/02/05/08"
	_nIPI:=25
ElseIF Substr(M->B1_COD,1,2) =="05" 
	_nIPI:=10
EndIF
RestArea(_aArea)
Return(_nIPI)