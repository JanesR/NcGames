#include "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���RdMake    � TITICMST � Autor �                       � Data � 05/11/2013��
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ponto de entrada na grava��o do titulo ICMS-ST             ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe e �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Gravatit() - NcGames                                       ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������/*/

User Function TITICMST

Local aArea			:= GetArea()
Local cOrigem		:=	PARAMIXB[1]
Local cTpImp		:=	PARAMIXB[2]
Local cNumTitGNR	:= ""
Local dDtVencGNR	:= stod("")

If AllTrim(cOrigem) == 'MATA460A' //Nota fiscal de sa�da
	cNumTitGNR			:= fBusca53() // ATUALIZA N�MERO DO T�TULO 
	dDtVencGNR			:= DataValida(dDataBase,.T.) // ATUALIZA DATA DE VENCIMENTO
	SE2->E2_NUM			:= cNumTitGNR
	SE2->E2_VENCTO		:= dDtVencGNR
	SE2->E2_VENCREA	:= dDtVencGNR
	SE2->E2_HIST		:= "ICMS-ST REF. NF. "+SF2->F2_DOC
EndIf

// RETORNO DA FUN��O N�O PODE SER BRANCO, SE N�O VAI DAR ERRO DE CHAVE DUPLICADA
// ATUALIZO AS VARIaVEIS COM AS IFNORMA��ES DO T�TULO POSICIONADO
IF EMPTY(cNumTitGNR)
	cNumTitGNR := SE2->E2_NUM
	dDtVencGNR := SE2->E2_VENCREA
EnDiF

RestArea(aArea)

Return {cNumTitGNR,dDtVencGNR}



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fBusca53  �Autor  �Microsiga           � Data �  11/05/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function fBusca53

Local aArea		:= GetArea()
Local aAreaSX5	:= SX5->(GetArea())
Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local cNum53	:= ""
Local cPrefPar	:= ""
Local cPrefixo	:= ""

If !Empty( cPrefPar := &( GetNewPar( "MV_PFAPUIC", "" ) ) )
	cPrefPar := Iif(substr(cPrefPar,1,1)=='"',&(cPrefPar),cPrefPar)
	cPrefixo := cPrefPar
EndIf

cQry	:= " SELECT MAX(E2_NUM) NUMSE2
cQry	+= " FROM SE2010 
cQry	+= " WHERE D_E_L_E_T_ = ' '
cQry	+= " AND E2_PREFIXO = '"+cPrefixo+"'
cQry	+= " AND E2_FILIAL = '"+xFilial("SE2")+"'
cQry	+= " AND E2_PARCELA = ' '
cQry	+= " AND E2_TIPO = 'TX'
cQry	+= " AND E2_NATUREZ = 'ICMS'
cQry	+= " AND E2_FORNECE = 'ESTADO'
cQry	+= " AND E2_LOJA = '00'
Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),cAlias,.F.,.T.)

If !Empty((cAlias)->NUMSE2)
	cNum53	:= Soma1(Alltrim((cAlias)->NUMSE2),TamSX3("F2_DOC")[1])
Else
    cNum53	:= SF2->F2_DOC
EndIf

RestArea(aAreaSX5)
RestArea(aArea)

Return cNum53
