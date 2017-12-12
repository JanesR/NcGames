#include "TOPCONN.CH"
#include "rwmake.ch"
#include "tbiconn.ch"
#include "tbicode.ch"
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Funcao    � AXSZISC7 � Autor � Carlos N. Puerta       � Data � Set/2012 ���
��������������������������������������������������������������������������Ĵ��
���Descricao � AXCADASTRO para o arquivo SZI - Filtransdo PVs - SC7        ���
��������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para NCGames                                     ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
// Cadastro de Aprovacoes/Rejeicoes de SCs, PCs e PVs - FILTRANDO SOMENTE PVs - SC7
User Function AXSZISC7()
Local   _cFiltro, _bFiltraBrw,_cArea
Private _aIndex	:= {}

_cFiltro := "AllTrim(ZI_ROTINA)=='SC7'"
_bFiltraBrw := {|| FilBrowse("SZI",@_aIndex,@_cFiltro) }
Eval(_bFiltraBrw)

AxCadastro("SZI","APROVACOES/REJEICOES DE PEDIDOS DE COMPRAS - SC7",".F.",".F.")

If ( Len(_aIndex) > 0 )
	EndFilBrw("SZI",_aIndex)
EndIf

Return