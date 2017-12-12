#INCLUDE "PROTHEUS.CH"

User Function MA080VLD

Local aArea	:= GetArea()
Local lRet		:= .T.
Local cCfoSf4	:= M->F4_CF
Local cCfGrpCtb   := U_MyNewSX6(	"NC_CFGRCTB", ;
									"1949;2949;3102;5949;6949", ;
									"C", ;
									"CFOP´s que permitem a gravação do campo Grupo Contábil.",;
									"CFOP´s que permitem a gravação do campo Grupo Contábil.",;
									"CFOP´s que permitem a gravação do campo Grupo Contábil.",;
									.F. )


If !Empty(cCfoSf4) .and. alltrim(cCfoSf4) $ cCfGrpCtb .and. Empty(M->F4_GRPCONT)
	lRet := .F.
	Aviso("GRPCTB", "É obrigatório o preenchimento do campo Grupo Contábil quando o CFOP for igual a "+cCfoSf4+CRLF+CRLF+; 
						"Obs. Em caso de dúvidas, verificar a utilização do campo com o Depto. Contábil",{"Ok"},3)

ElseIf !(alltrim(cCfoSf4) $ cCfGrpCtb) .and. !Empty(M->F4_GRPCONT)
	M->F4_GRPCONT	:= ""
	Aviso("GRPCTB", "O preenchimento do campo Grupo Contábil será deixado como vazio. O CFOP não permite a digitação do campo."+CRLF+CRLF+; 
						"Obs. Em caso de dúvidas, verificar a utilização do campo com o Dpto. Contábil",{"Ok"},3)

EndIf


RestArea(aArea)

Return lRet



