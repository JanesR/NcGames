#include "rwmake.ch"
#include "topconn.ch"

// Autor: Marcelo Paganelli Sant'Anna
// Descricao: Rotina que limpa flag do financeiro e os lancamentos contabeis
// para possibilitar nova contabilizacao
// Uso: Especifico para a JF Citrus       Data: 05/2004

User Function LimpaFin()

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
@ 030,070 GET _DataF Valid _DataF >= _DataI SIZE 40,15
@ 050,020 Say "Filial de:"
@ 050,070 GET _Filde
@ 070,020 Say "Filial ate:"
@ 070,070 GET _Filate Valid _Filate >= _Filde
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
	
	If CT2->CT2_LOTE="008850" .And.;
		!SUBSTR(CT2->CT2_ORIGEM,1,3)$"535/594" .And.;
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

dbSelectArea("SE1")
dbSetOrder(6)
dbSeek("01"+Dtos(_DataI),.t.)
ProcRegua( Reccount())
While !Eof()
	If SE1->E1_EMISSAO >= _DataI .And.;
		SE1->E1_EMISSAO <= _DataF .And.;
		!Rtrim(SE1->E1_ORIGEM)$"MATA460/MATA100" .And.;
		SE1->E1_FILIAL  >= _Filde .And.;
		SE1->E1_FILIAL  <= _Filate
		
		X:=Recno()
		IncProc(X)
		Reclock("SE1",.F.)
		SE1->E1_LA := Space(01)
		MsUnlock()
	Endif
	dbSkip()
Enddo

dbSelectArea("SE2")
dbSetOrder(5)
dbSeek("01"+Dtos(_DataI),.t.)
ProcRegua( Reccount())
While !Eof()
	If SE2->E2_EMISSAO >= _DataI .And.;
		SE2->E2_EMISSAO <= _DataF .And.;
		!Rtrim(SE2->E2_ORIGEM)$"FINA290/MATA460/MATA100" .And.;
		SE2->E2_FILIAL  >= _Filde .And.;
		SE2->E2_FILIAL  <= _Filate
		
		X:=Recno()
		IncProc(X)
		Reclock("SE2",.F.)
		SE2->E2_LA := Space(01)
		MsUnlock()
	Endif
	dbSkip()
Enddo

dbSelectArea("SEF")
dbSetOrder(1)
ProcRegua( Reccount())
dbGoTop()
While !Eof()
	If SEF->EF_DATA   >= _DataI .And.;
		SEF->EF_DATA   <= _DataF .And.;
		SEF->EF_FILIAL >= _Filde .And.;
		SEF->EF_FILIAL <= _Filate
		
		X:=Recno()
		IncProc(X)
		Reclock("SEF",.F.)
		SEF->EF_LA := Space(01)
		MsUnlock()
	Endif
	dbSkip()
Enddo

dbSelectArea("SE5")
dbSetOrder(1)
dbSeek("01"+Dtos(_DataI),.t.)
ProcRegua( Reccount())
While !Eof()
	If SE5->E5_DATA >= _DataI    .And.;
		SE5->E5_DATA <= _DataF    .And.;
		!Rtrim(SE5->E5_MOTBX)$"CEC/FAT/LIQ" .And.;
		SE5->E5_FILIAL  >= _Filde .And.;
		SE5->E5_FILIAL  <= _Filate
		
		X:=Recno()
		IncProc(X)
		Reclock("SE5",.F.)
		SE5->E5_LA := Space(01)
		MsUnlock()
	Endif
	dbSkip()
Enddo
Return

*************************
Static Function _Saida2()
Close(oDlg2)
dbSelectArea(_nArea)
Return

