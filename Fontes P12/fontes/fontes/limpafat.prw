#include "rwmake.ch"

// Autor: Marcelo Paganelli Sant'Anna
// Descricao: Rotina que limpa flag do faturamento e os lancamentos contabeis
// para possibilitar nova contabilizacao
// Uso: Especifico para a JF Citrus       Data: 05/2004

User Function LimpaFat()

SetPrvt("_NAREA,_DATAI,_DATAF,X,")

_nArea := Alias()
_DataI := Date()
_DataF := Date()
_Filde := Space(02)
_Filate:= "ZZ"

@ 100,200 TO 350,600 DIALOG oDlg2 TITLE "Parametro"
@ 010,020 Say "Data de:"
@ 010,070 GET _DataI SIZE 40,15
@ 030,020 Say "Ate:"
@ 030,070 GET _DataF Valid _DataF>=_DataI SIZE 40,15
@ 050,020 Say "Filial de:"
@ 050,070 GET _Filde
@ 070,020 Say "Filial ate:"
@ 070,070 GET _Filate Valid _Filate>=_Filde
@ 090,020 BUTTON "Confirma"  SIZE 40,15 ACTION _ConfPar()
@ 090,120 BUTTON "Saida"     SIZE 40,15 ACTION _Saida2()
ACTIVATE DIALOG oDlg2 CENTERED
Return

**************************
Static Function _ConfPar()
Processa({|| RptDetail()})
Return

***************************
Static Function RptDetail()
dbSelectArea("CT2")
dbSetOrder(1)
dbSeek(xFilial("CT2")+Dtos(_DataI),.t.)
ProcRegua( Reccount())
While !Eof() .And.;
	CT2->CT2_DATA  >= _DataI .And.;
	CT2->CT2_DATA  <= _DataF
	
	If CT2->CT2_LOTE="008820" .And.;
		CT2->CT2_FILORI >= _Filde .And.;
		CT2->CT2_FILORI <= _Filate
		
		X:=Recno()
		IncProc(X)
		Reclock("CT2",.F.)
		dbDelete()
		MsUnlock()
	Endif
	dbSkip()
Enddo

dbSelectArea("CTK")
dbSetOrder(1)
ProcRegua( Reccount())
dbGoTop()
While !Eof()
	X:=Recno()
	IncProc(X)
	Reclock("CTK",.F.)
	dbDelete()
	MsUnlock()
	dbSkip()
Enddo

dbSelectArea("SF2")
dbSetOrder(1)
dbGoTop()
ProcRegua( Reccount())
While !Eof()
	If SF2->F2_EMISSAO >= _DataI .And.;
		SF2->F2_EMISSAO <= _DataF .And.;
		SF2->F2_FILIAL  >= _Filde .And.;
		SF2->F2_FILIAL  <= _Filate
		
		X:=Recno()
		IncProc(X)
		Reclock("SF2",.F.)
		SF2->F2_DTLANC := Ctod("  /  /  ")
		MsUnlock()
	Endif
	dbSkip()
Enddo
Return(nil)


*************************
Static Function _Saida2()
Close(oDlg2)
dbSelectArea(_nArea)
Return
