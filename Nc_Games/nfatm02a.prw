#include "protheus.ch"         
#INCLUDE "rwmake.ch"
User Function NFatm02A(cMk)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NFATM02A   ºAutor  ³Reinaldo Caldas     º Data ³  20/11/04   º±±
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
Pergunte("FATM02A",.F.)
PRIVATE cQry := ""
PRIVATE cMark := cMk
Private DData	 := STOD("")

    IF mv_par01 == 1
    	cCondicao := 'Z1_STATUS == " " .and. Z1_MARK = cMark' 
    	cOper:="Liberacao para Entrega"
    Else
		cCondicao := 'Z1_STATUS == "A" .and. Z1_MARK = cMark' 
		cOper:="Baixa(Mercadoria Entregue)
	EndIF
         
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicializa o filtro                                                    ³
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
	
	DDATA:= DDATABASE
	   	
        DEFINE MSDIALOG oDlg FROM 30,16 To 280, 380  TITLE OemToAnsi("Selecao dos Entregadores") PIXEL         
		@ 01.0,01.0 SAY "Entregador :" SIZE 60,10 of oDlg
		@ 01.0,07.0 MSGET cMotorista F3 "DA4" Valid ExistChav("DA4",cMotorista) SIZE 37,10 of oDlg 
 		@ 02.0,01.0 SAY "Data :" SIZE 60,10 of oDlg
		@ 02.0,07.0 MSGET DDATA VALID U_VLDDATA(Ddata) SIZE 37,10 of oDlg 
     	@ 03.0,01.0 SAY "Seleção das NF's:                                    " SIZE 60,10 of oDlg
		@ 04.2,01.0 SAY cNf	SIZE 70,10 of oDlg 
//		@ 03.2,12.2 MSGET mv_par02 SIZE 70,10 of oDlg WHEN .F.
//		@ 04.2,12.2 MSGET mv_par04 SIZE 70,10 of oDlg WHEN .F.		
		@ 05.5,00.6 Say "Operacao a ser realizada: " SIZE 10,40 of oDlg
  		@ 07.0,00.6 Say cOper SIZE 90,10 of oDlg
		DEFINE SBUTTON FROM 05.0,150 TYPE 1 ACTION (nOpca := 1,If(ValidaTela(cMotorista,mv_par01),oDlg:End(),nOpca:=0)) ENABLE OF oDlg
		DEFINE SBUTTON FROM 17.9,150 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
		ACTIVATE MSDIALOG oDlg CENTER
	//U_LibBaixa(mv_par01,cMotorista)	
	EndIf
// FIM DO ESPAÇO PARA ROTINA
//dbGoto( nRecno )
dbSelectArea("SZ1")
RetIndex("SZ1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())


//DESMARCA TODOS OS REGISTROS ANTES RETORNAR A MARKBROWSE
cQry:="Z1_MARK = cMark"
dbSelectArea('SZ1')
IndRegua("SZ1",cArqInd,IndexKey(),,cQry)
nIndex := RetIndex("SZ1")
#IFNDEF TOP
	dbSetIndex(cArqInd+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
While !Eof()
	RecLock('SZ1',.F.)
	REPLACE SZ1->Z1_MARK WITH SPACE(2)
	MsUnLock()
	dbSkip()
End
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



Static Function ValidaTela(cMotorista,mv_par01)
Local _aArea:=GetArea()
Local _lRet:=.T.
IF mv_par01 == 1
	dbSelectArea("DA4")
	dbSetOrder(1)
	IF dbSeek(xFilial()+cMotorista)
		_lRet:=.T.
		U_LibBaixa(mv_par01,cMotorista)
	Else
		MsgAlert("Motorista nao cadastrado!!!","Alerta")
		_lRet:=.F.
	EndIF
ElseIf mv_par01 == 2
	U_LibBaixa(mv_par01,cMotorista)
EndIF

RestArea(_aArea)

Return(_lRet)


Static Function NFatM02AInverte(cMarca)

Local nReg		:= SZ1->(Recno())
Local cAlias	:= Alias()
Local lBxTit := .T.

dbSelectArea("SZ1")

While !Eof()
	RecLock("SZ1")
	IF Z1_OK == cMarca
		SZ1->Z1_OK	:= "  "
		SZ1->Z1_STATUS:="A"
	Else
		lBxTit := .T.
		SZ1->Z1_OK	:= cMarca
		SZ1->Z1_STATUS:=" "
	Endif
	MsUnlock()
	dbSkip()
Enddo
SZ1->(dbGoto(nReg))
//oMark:oBrowse:Refresh(.t.)
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

User Function LibBaixa(mv_par01,cMotorista)

Local _aArea:=GetArea()
Local nReg		:= SZ1->(Recno())
Local cAlias	:= Alias()
Local lBxTit := .T.

dbSelectArea("SZ1")

While !Eof()
	IF mv_par01 == 1
		IF Z1_MARK == cMark
			Reclock("SZ1")
			SZ1->Z1_STATUS :="A"
			SZ1->Z1_DTSAIDA:=DDATA
			SZ1->Z1_HORALB :=TIME()
			MsUnlock()
			dbSelectArea("SZ3")
			dbSetOrder(1)
			dbSeek(xFilial()+SZ1->Z1_DOC)
			While !Eof() .and. SZ3->Z3_DOC == SZ1->Z1_DOC
				Reclock("SZ3")
				SZ3->Z3_EMISSOR:= Upper(Substr(cUsuario,7,15))
				SZ3->Z3_CODMOTO:= cMotorista
				SZ3->Z3_MOTORIS:= POSICIONE("DA4",1,XFILIAL("DA4")+cMotorista,"DA4_NREDUZ")
				MsUnlock()
				dbSkip()
			Enddo
		Else
			IF SZ1->Z1_STATUS <> "B"
				lBxTit := .T.
				Reclock("SZ1")
				SZ1->Z1_OK	:= cMarca
				SZ1->Z1_STATUS:=" "
				MsUnlock()
			EndIF
		Endif
	Else
		IF Z1_MARK == cMark 
			If SZ1->Z1_DTSAIDA <= DDATA
				Reclock("SZ1")
				SZ1->Z1_DTENTRE:=ddata
				//SZ1->Z1_BAIXAPO:=Upper(Substr(cUsuario,7,15))
				SZ1->Z1_HORAEN :=TIME()
				SZ1->Z1_STATUS :="B"
				SZ1->Z1_DTBAIXA:=DDATA
				MsUnlock()
			Else
				alert("O canhoto não poderá ser baixado com data inferior a data da saída da NF: "+SZ1->Z1_DOC+"/"+SZ1->Z1_SERIE)
			EndIf
		Endif
		
	EndIF
	dbSelectArea("SZ1")
	dbSkip()
EndDo
SZ1->(dbGoto(nReg))
RestArea(_aArea)
Return()
        

User Function VLDDATA(Cdata)

IF EMPTY(Cdata)
	MSGBOX("INFORME A DATA!!!!")
	Return .F.
ENDIF	

Return