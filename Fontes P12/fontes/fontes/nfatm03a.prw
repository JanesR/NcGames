#include "protheus.ch"
User Function NFatm03A(cMk)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NFATM03A   ºAutor  ³Reinaldo Caldas     º Data ³  20/11/04   º±±
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
PRIVATE cNf := ""
PRIVATE cMark := cMk

Pergunte("FATM02A",.F.)

    IF mv_par01 == 3
		cCondicao := 'Z1_MARK = cMark' 
		cOper:="Cancelamento Nota Fiscal com Etiqueta" 
	EndIF
         
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o filtro utilizando a funcao FilBrowse                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
cQry:="Z1_MARK = cMark"
dbSelectArea('SZ1')
IndRegua("SZ1",cArqInd,IndexKey(),,cQry)
nIndex := RetIndex("SZ1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
//ESPAÇO PARA REALIZAR ROTINA
  	If Bof() .and. Eof()
  		Help(" ",1,"RECNO")
   	Else   
   	While !eof()
   		cNf += SZ1->Z1_DOC + ", " 
   		dbskip()
  	EndDo     
	dbGotop()   	
        DEFINE MSDIALOG oDlg FROM 30,16 To 280, 380  TITLE OemToAnsi("Cancelamento das Etiquetas") PIXEL         
     	@ 02.0,01.0 SAY "NF's Selecionadas:                                    " SIZE 60,10 of oDlg
		@ 03.2,01.0 SAY cNf	SIZE 70,10 of oDlg 
		@ 05.5,00.6 Say "Operacao a ser realizada: " SIZE 10,40 of oDlg
  		@ 07.0,00.6 Say cOper SIZE 90,10 of oDlg
		DEFINE SBUTTON FROM 05.0,150 TYPE 1 ACTION (nOpca := 1,If(U_CancelaA(cMarca,oDlg,mv_par01),oDlg:End(),nOpca:=0)) ENABLE OF oDlg
		DEFINE SBUTTON FROM 17.9,150 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg

		ACTIVATE MSDIALOG oDlg CENTER

//		ACTIVATE MSDIALOG oDlg	ON INIT EnchoiceBar(	oDlg,{|| nOpca := 1,U_CancelaA(cMarca,oDlg,mv_par01)},{|| nOpca := 0,ODlg:End()} ) CENTER
/*    	DEFINE MSDIALOG oDlg1 TITLE OemToAnsi("Selecao das NFs para Entrega") FROM 9,0 To 28,80 OF oMainWnd
		oMark			:= MsSelect():New("SZ1","Z1_OK","",,@lInverte,@cMarca,{35,1,143,315} )
		oMark:oBrowse:lhasMark		:= .t.
		oMark:oBrowse:lCanAllmark	:= .t.
		oMark:oBrowse:bAllMark		:= { ||NFatM02AInverte(cMarca) }

		ACTIVATE MSDIALOG oDlg1	ON INIT EnchoiceBar(	oDlg1,{|| nOpca := 1,U_CancelaA(cMarca,oDlg1,mv_par01,)},{|| nOpca := 0,ODlg1:End()} ) CENTER*/
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza o uso da funcao FilBrowse e retorna os indices padroes.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//dbGoto( nRecno )
dbSelectArea("SZ1")
RetIndex("SZ1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())

//RETORNA O MARKBROWSE
IF mv_par01 == 1
	cQuery:="Z1_STATUS==' '"
ElseIf mv_par01 == 2
	cQuery:="Z1_STATUS=='A'"
ElseIf mv_par01 == 3
	cQuery:=""
ElseIf mv_par01 == 4
	cQuery:="Z1_STATUS=='A'"
EndIF

dbSelectArea("SZ1")
IndRegua("SZ1",cArqInd,IndexKey(),,cQuery)
nIndex := RetIndex("SZ1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
	
RestArea(_aArea)
RETURN


Static Function NFatM02AInverte(cMarca)

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

User Function CancelaA(cMarca,oDlg,mv_par01)

Local _aArea:=GetArea()
Local nReg		:= SZ1->(Recno())
Local cAlias	:= Alias()
Local lBxTit := .T. 

dbSelectArea("SZ1")

While !Eof()
	IF mv_par01 == 3
		IF Z1_MARK<>'  '
			_cCod := SZ1->Z1_DOC
			Reclock("SZ1")
			dbDelete()
			MsUnlock()
			DBSELECTAREA("SZ7")
	    	SZ7->(DBSETORDER(1))
	    	IF SZ7->(DBSEEK(XFILIAL("SZ7")+SZ1->Z1_PEDIDO+"000012"))
	        	RECLOCK("SZ7")
	    		DBDELETE()
	    		SZ7->(MSUNLOCK())
	    	ENDIF
			dbSelectArea("SZ3")
			dbSetOrder(1)
			dbSeek(xFilial("SZ3")+_cCod)//a ser revisado!! Verificar porque não estava sendo gravado a filial ao imprimir a etiqueta até a hoje (17/01/10)
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
RestArea(_aArea)
Return(.T.)
