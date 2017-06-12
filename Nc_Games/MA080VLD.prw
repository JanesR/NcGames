#INCLUDE "PROTHEUS.CH"

User Function MA080VLD

Local aArea	:= GetArea()
Local lRet		:= .T.
Local cCfoSf4	:= M->F4_CF
Local cCfGrpCtb   := U_MyNewSX6(	"NC_CFGRCTB", ;
									"1949;2949;3102;5949;6949", ;
									"C", ;
									"CFOP�s que permitem a grava��o do campo Grupo Cont�bil.",;
									"CFOP�s que permitem a grava��o do campo Grupo Cont�bil.",;
									"CFOP�s que permitem a grava��o do campo Grupo Cont�bil.",;
									.F. )


If !Empty(cCfoSf4) .and. alltrim(cCfoSf4) $ cCfGrpCtb .and. Empty(M->F4_GRPCONT)
	lRet := .F.
	Aviso("GRPCTB", "� obrigat�rio o preenchimento do campo Grupo Cont�bil quando o CFOP for igual a "+cCfoSf4+CRLF+CRLF+; 
						"Obs. Em caso de d�vidas, verificar a utiliza��o do campo com o Depto. Cont�bil",{"Ok"},3)

ElseIf !(alltrim(cCfoSf4) $ cCfGrpCtb) .and. !Empty(M->F4_GRPCONT)
	M->F4_GRPCONT	:= ""
	Aviso("GRPCTB", "O preenchimento do campo Grupo Cont�bil ser� deixado como vazio. O CFOP n�o permite a digita��o do campo."+CRLF+CRLF+; 
						"Obs. Em caso de d�vidas, verificar a utiliza��o do campo com o Dpto. Cont�bil",{"Ok"},3)

EndIf


RestArea(aArea)

Return lRet



