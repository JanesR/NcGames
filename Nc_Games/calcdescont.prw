

#include "rwmake.ch"

User Function CalcDescont()

Local _aArea   :=GetArea()
Local _cIOF    :=0.004167
Local _nValor  :=0

_nPrazo         :=U_FA060dgv()
_aValores      :=""

//Calculo Desagio
_nDesagio:=((nValCred*_nPrazo)*nTaxaDesc)/3000
//Calcula IOF
_nIOF    :=((0.004167*nPrazoMed)*nValCred)/100
_nValor        +=nValCred-(_nDesagio+_nIOF)

RestArea(_aArea)
Return(_nValor)

User Function Fa060dgv()

Local _aArea:=GetArea()
Local _aRet :={}
_nValCred   :=PARAMIXB[1]
AADD(_aRet,nPrazoMed)

RestArea(_aArea)
Return(_aRet)   
