#include "rwmake.ch"
#include "colors.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBORDERO   บAutor  ณRogerio - Supertech บ Data ณ  05/24/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela para escolha do bordero e apresenta็ao no Browse		  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User function BORDERO()

Local aCores  		:= 	{{"E1_VALOR <> E1_SALDO .AND. E1_SALDO <> 0" , 'BR_AZUL' },;
{ "E1_SALDO > 0", 'ENABLE'         },;
{ "E1_SALDO == 0",'DISABLE'     }}

Local aArea 		:= GetArea()

Private cCadastro 	:= "Bordero"
Private aRotina 	:= 	{{"Manutencao"	,"u_Manut"     ,0,5},;
{"Legenda"  	,"u_xLegenda"  ,0,6} }
dbSelectArea("SE1")
dbSetOrder(5)
EOF()

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRetorna numero do ultimo bordero geradoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/

PUBLIC cNumBor  	:= SPACE(6) //SuperGetMV("MV_NUMBORR")
//	@ LIN,COL
@ 100,001 To 340,350 Dialog oDlg Title "Bordero"
@ 003,010 To 110,167
@ 013,014 Say OemToAnsi("Numero do Bordero")
@ 013,080 Get cNumBor Picture "@E 999999"
@ 097,130 BmpButton Type 01 Action Close(oDlg)

Activate Dialog oDlg Centered

dbSelectArea("SE1")
dbSetOrder(1)
dbGoTop()
//dbSeek(xFilial() + cNumBor)
SET FILTER TO (SE1->E1_NUMBOR ==cNumBor )     //FILTRO PARA PEGAR SOMENTE O BORDERO SELECIONADO
mBrowse( 6,1,22,75,"SE1",,,,,,aCores)

IF SE1->E1_NUMBOR ==cNumBor

MSGALERT("Bordero nao existe")

END IF

SET FILTER TO

RestArea(aArea)

Return

User Function xLegenda()

BrwLegenda(cCadastro,"Legenda",;
{ { 'BR_AZUL', 'Titulo Parcialmente Baixado'},;
{ 'ENABLE', 'Titulo em Aberto'},;
{ 'DISABLE', 'Titulo Baixado' }})

Return

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFUNCAO COM OS CALCULOS DA FACTORING   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Static function xInc()


cStr:= SPACE(48)
RecLock("SE1",.F.)

DO CASE
CASE LEN(Alltrim(cStr)) == 48
cStr := SUBSTR(cStr,5,7)+SUBSTR(cStr,13,11)+SUBSTR(cStr,25,11)+SUBSTR(cStr,37,11)

CASE LEN(Alltrim(cStr)) == 47
cStr := SUBSTR(cStr,1,4)+SUBSTR(cStr,33,15)+SUBSTR(cStr,5,5)+SUBSTR(cStr,11,10)+SUBSTR(cStr,22,10)
OTHERWISE
cStr := cStr+SPACE(48-LEN(alltrim(cStr)))
ENDCASE

SE2->E2_CODBAR:=cStr

If SE2->E2_ACRESC==0
SE2->E2_ACRESC  := _nValAcresc
End If

If SE2->E2_SDACRES==0
SE2->E2_SDACRES:= _nValAcresc
End IF

If SE2->E2_DECRESC==0
SE2->E2_DECRESC :=_nValDecresc
End If

If SE2->E2_SDDECRE==0
SE2->E2_SDDECRE :=_nValDecresc
End If

//SE2->E2_VLCRUZ    := SE2->E2_VALOR+_nValAcresc-_nValDecresc
//SE2->E2_VALOR += _nValAcresc-_nValDecresc
//SE2->E2_SALDO := SE2->E2_VALOR

IF !EMPTY(_cHist)

SE2->E2_HIST    := Alltrim(_cHist)

END IF

MsUnlock()
*/

Close(oDlg)

SET FILTER TO
RestArea(aArea)
Return ()
