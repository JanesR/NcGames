#include "protheus.ch"

User Function NFatm03

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NFATM03   ºAutor  ³Reinaldo Caldas     º Data ³  20/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Local  cMarca
Local _cQuery
Local _aArea:=GetArea()
Local aIndexSZ1 := {}
Local lInverte		:= .F.
Local aCpos:={}
PRIVATE bFiltraBrw := {|| NIL}
PRIVATE cMarca		:= GetMark()
PRIVATE cMotorista:=Space(6)

Pergunte("FATM02",.T.)

    IF mv_par03 == 3
		cCondicao := 'Z1_DOC >= "'+mv_par01+'" .and. Z1_DOC <= "'+mv_par02+'"' 
		cOper:="Cancelamento Nota Fiscal com Etiqueta" 
	EndIF
         
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o filtro utilizando a funcao FilBrowse                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
    dbSelectArea("SZ1")
	dbSetOrder(1)
        bFiltraBrw := {|| FilBrowse("SZ1",@aIndexSZ1,@cCondicao) }
	Eval(bFiltraBrw)
	
	dbGotop()
  	If Bof() .and. Eof()
  		Help(" ",1,"RECNO")
   	Else
    	DEFINE MSDIALOG oDlg1 TITLE OemToAnsi("Selecao das NFs para Entrega") FROM 9,0 To 28,80 OF oMainWnd
		oMark			:= MsSelect():New("SZ1","Z1_OK","",,@lInverte,@cMarca,{35,1,143,315} )
		oMark:oBrowse:lhasMark		:= .t.
		oMark:oBrowse:lCanAllmark	:= .t.
		oMark:oBrowse:bAllMark		:= { ||NFatM02Inverte(cMarca) }

		ACTIVATE MSDIALOG oDlg1	ON INIT EnchoiceBar(	oDlg1,{|| nOpca := 1,U_Cancela(cMarca,oDlg1,mv_par03,)},{|| nOpca := 0,ODlg1:End()} ) CENTER
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza o uso da funcao FilBrowse e retorna os indices padroes.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        EndFilBrw("SZ1",aIndexSZ1)
	
RestArea(_aArea)
RETURN


Static Function NFatM02Inverte(cMarca)

Local nReg		:= SZ1->(Recno())
Local cAlias	:= Alias()
Local lBxTit := .T. 

dbSelectArea("SZ1")

While !Eof() 
	RecLock("SZ1")
	IF Z1_OK == cMarca 
		SZ1->Z1_OK	:= "  "	
		SZ1->Z1_STATUS:="C"				
	Else
		lBxTit := .T.
		SZ1->Z1_OK	:= cMarca
		SZ1->Z1_STATUS:=" "		
	Endif
	MsUnlock()
	dbSkip()
Enddo
SZ1->(dbGoto(nReg))
Return Nil


Static Function NFatmMarca(cAlias,cMarca)
Local lBxTit := .T.

Local nRec
Local cAliasAnt := Alias()

dbSelectArea(cAlias)
nRec	:= Recno()
DbGoTop()
While !Eof()           
	lBxTit := .T.
	RecLock("SZ1")
		SZ1->Z1_OK := cMarca
	MsUnLock()
	dbSkip()
EndDo
dbGoto(nRec)
dbSelectArea(cAliasAnt)
Return

User Function Cancela(cMarca,oDlg1,mv_par03)

Local _aArea:=GetArea()
Local nReg		:= SZ1->(Recno())
Local cAlias	:= Alias()
Local lBxTit := .T. 

dbSelectArea("SZ1")

While !Eof() 
	IF mv_par03 == 3
		IF Z1_OK == cMarca 
			_cCod := SZ1->Z1_DOC
			Reclock("SZ1")
				dbDelete()
			MsUnlock()
			dbSelectArea("SZ3")
			dbSetOrder(1)
			dbSeek(xFilial()+_cCod)
			While !Eof() .and. SZ3->Z3_DOC == _cCod
				Reclock("SZ3")
					dbDelete()
				MsUnlock()
				dbSkip()
			Enddo
		EndIF	
	EndIF
	dbSelectArea("SZ1")
	dbSkip()
EndDo
SZ1->(dbGoto(nReg))
oMark:oBrowse:Refresh(.t.)
oDlg1:End()
RestArea(_aArea)
Return()
