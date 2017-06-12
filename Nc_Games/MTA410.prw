#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"

Static aSaCols		:={}
Static aSaHeader	:={}
Static aCabec		:={}
//Executado em conjunto com o PE M410ALOK

User Function MTA410()
Local llRet 	:= .T.
Local _aArea    := GetArea()
Local _lRet     := .T.
Local lPVSiteSimul	:= IsInCallStack("U_COM08SIMUL")
Local nInd:=1

If ALTERA .AND. !Empty(_clQueryC5)
	
	If TcSqlExec(_clQueryC5) >= 0
		llRet := .T.
		TcSqlExec("COMMIT")
	Else
		llRet := .F.
		Aviso("ERRO",TCSQLError() + " - " + _clQueryC5, {"Ok"})
	EndIf
	
EndIF

If INCLUI .And. lPVSiteSimul
	aSaCols		:=aClone(aCols)
	aSaHeader	:=aClone(aHeader)
	For nInd:=1 To SC5->(FCount())
		If Type("M->"+SC5->(FieldName(nInd))  )<>"U"
			AADD(aCabec,{ "M->"+SC5->(FieldName(nInd)),&("M->"+SC5->(FieldName(nInd))) } )
		EndIf
		
	Next
	llRet:=.F.
EndIf


Return(llRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTA410    �Autor  �Microsiga           � Data �  02/18/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function GetaColsaHeader(aColsAux,aHeaderAux,lReset)
Local nInd
Default lReset:=.F.

If lReset
	aSaCols		:={}
	aSaHeader	:={}
	aCabec		:={}
Else

	aColsAux		:=aSaCols
	aHeaderAux 	:=aSaHeader
	
	For nInd:=1 To Len(aCabec)
		&(aCabec[nInd,1])	:=aCabec[nInd,2]
	Next
EndIf

Return 