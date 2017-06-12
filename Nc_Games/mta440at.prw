#include "rwmake.ch"
#INCLUDE "topconn.ch"
#include "protheus.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �P_MTA440AC �Autor  �ERICH BUTTNER       � Data �  22/10/10  ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada ANTES DE LIBERAR		                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP10                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT440AT()
Local cBloqLib :=AllTrim(U_MyNewSX6(	"NCG_000067", "S", "C", 	"Bloquear Liberacao do PV S=Sim ou N=Nao","","",	.F. ))
Local cCanUser	:=AllTrim(U_MyNewSX6(	"NCG_000068", "", "C", 	"ID do usuario com permissao de liberacao mesmo que o paramatro NCG_000067=S(separado por ;)","","",	.F. ))
//
//   Inicio da rotina para checar Bloqueio de produto para inventario
//   Carlos N. Puerta - Jul/2011
Private _aArea  := GetArea()
Private _lBloq  := .F.
Private _lRet   := .F.

If cBloqLib=="S" .And. !__cUserID$cCanUser
	MsgStop("Processo de libera��o bloqueado.","NcGames")     
	Return .F.
EndIf

If !U_PR107LibPermitida(.F.,SC5->C5_NUM)//Funcao encontrada no fonte NCGPR107
	Return .F.
EndIf 


DBSELECTAREA("SC9")
DBSETORDER(1)

IF DBSEEK(XFILIAL("SC9")+SC5->C5_NUM)
    CUSERSZ7 := getadvfval("SZ7","Z7_USUARIO",XFILIAL("SZ7")+SC5->C5_NUM+"000002",1,"")
    DDATASZ7 := getadvfval("SZ7","Z7_DATA",XFILIAL("SZ7")+SC5->C5_NUM+"000002",1,"")
    DHORASZ7 := getadvfval("SZ7","Z7_HORA",XFILIAL("SZ7")+SC5->C5_NUM+"000002",1,"")
//	IF !(MSGNOYES("Este Pedido J� Foi Liberado Pelo"+CHR(13) +"Usu�rio: "+CUSERSZ7+CHR(13)+"Data: "+DTOS(DDATASZ7)+CHR(13)+"Hora: "+DHORASZ7+CHR(13)+"Deseja Re-Liberar o Pedido ?"))
	MSGINFO("Este Pedido J� Foi Liberado Pelo"+CHR(13) +"Usu�rio: "+CUSERSZ7+CHR(13)+"Data: "+DTOS(DDATASZ7)+CHR(13)+"Hora: "+DHORASZ7+CHR(13)+"N�o � poss�vel re-Liberar o Pedido !")
	return  .F.
ENDIF	 

dbSelectArea("SC6")
_aAreaC6 := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SC6")+SC5->C5_NUM,.T.)

Do While !Eof() .And. SC6->C6_FILIAL+SC6->C6_NUM == XFILIAL("SC6")+SC5->C5_NUM
	dbSelectArea("SB2")
	SB2->(dbSetOrder(1))
	dbSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL)
	_lBloq := IIF(EMPTY(SB2->B2_DTINV), .F. , .T.) //BLQINVENT(SC6->C6_PRODUTO,SC6->C6_LOCAL,DDATABASE)
	If _lBloq
		Exit
	EndIf
	dbSelectArea("SC6")
	dbSkip()
EndDo
RestArea(_aAreaC6)

If _lBloq
	Alert("Existe(m) produto(s) nesse pedido que esta(o) bloqueado(s) para inventario...")
	_lRet := .F.
Else
	_lRet := .T.
EndIf
//
//   Termino da rotina para checar Bloqueio de produto para inventario - Jul/2011

If _lRet
	dbSelectArea("SC5")
	_aAreaC5 := GetArea()
	dbSetOrder(1)
	dbSeek(xFilial("SC5") + SC5->C5_NUM)
	
	IF ALLTRIM(SC5->C5_STAPICK) == "1"
		MSGBOX("N�O � PERMITIDO A RELIBERA��O DO PEDIDO POIS EST� EM PROCESSO DE PICKING"+CHR(13)+"SOLICITE O ESTORNO AO DEPARTAMENTO DE EXPEDI��O")
		_lRet := .F.
	ENDIF
	IF !EMPTY(SC5->C5_NOTA).OR. ALLTRIM(SC5->C5_STAPICK) == '3'
		MSGBOX("PEDIDO DE VENDA FATURADO"+CHR(13)+"N�O PERMITIDO A RELIBERA��O")
		_lRet := .F.
	ENDIF
	
/*	_cPEDWMAS := " SELECT max(DOC.SEQUENCIAINTEGRACAO) DOCINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG "
	_cPEDWMAS += " WHERE DOC.NUMERODOCUMENTO = '"+SC5->C5_NUM+"'"
	_cPEDWMAS += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "
	
	_cPEDWMAS := ChangeQuery(_cPEDWMAS)
	
	If Select("TRB") >0
		dbSelectArea("TRB")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS New Alias "TRB"
	
	dbSelectArea("TRB")
	
	_cPEDWMAS1 := " SELECT INTEG.TIPOINTEGRACAO TIPINT FROM ORAINT.DOCUMENTO DOC, ORAINT.INTEGRACAO INTEG
	_cPEDWMAS1 += " WHERE DOC.SEQUENCIAINTEGRACAO = '"+STR(TRB->DOCINT)+"' "
	_cPEDWMAS1 += " AND DOC.SEQUENCIAINTEGRACAO = INTEG.SEQUENCIAINTEGRACAO "
	
	_cPEDWMAS1 := ChangeQuery(_cPEDWMAS1)
	
	If Select("TRB1") >0
		dbSelectArea("TRB1")
		dbCloseArea()
	Endif
	
	TCQUERY _cPEDWMAS1 New Alias "TRB1"
	
	dbSelectArea("TRB1")

	If (TRB1->TIPINT <> 251 .AND. TRB1->TIPINT <> 0)
		MSGBOX("N�O � PERMITIDO A ALTERA��O DO PEDIDO POIS EST� NO WMAS."+CHR(13)+"SOLICITE O ESTORNO AO DEPARTAMENTO DE EXPEDI��O")
		_lRet := .F.
	EndIf
  */
	RestArea(_aAreaC5)
EndIf

If Select("TRB1") >0
	dbSelectArea("TRB1")
	dbCloseArea()
Endif
If Select("TRB") >0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

RestArea(_aArea)


Return(_lRet)
