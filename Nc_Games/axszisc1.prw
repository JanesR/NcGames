#include "TOPCONN.CH"
#include "rwmake.ch"
#include "tbiconn.ch"
#include "tbicode.ch"
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Funcao    � AXSZISC1 � Autor � Carlos N. Puerta       � Data � Set/2012 ���
��������������������������������������������������������������������������Ĵ��
���Descricao � AXCADASTRO para o arquivo SZI - Filtransdo SCs - SC1        ���
��������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para NCGames                                     ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
// Cadastro de Aprovacoes/Rejeicoes de SCs, PCs e PVs - FILTRANDO SOMENTE SCs - SC1
User Function AXSZISC1()
Local   _cFiltro, _bFiltraBrw,_cArea
Private _aIndex	:= {}

_cFiltro := "AllTrim(ZI_ROTINA)=='SC1'"
_bFiltraBrw := {|| FilBrowse("SZI",@_aIndex,@_cFiltro) }
Eval(_bFiltraBrw)

AxCadastro("SZI","APROVACOES/REJEICOES DE SOLICITACOES DE COMPRAS - SC1",".F.",".F.")

If ( Len(_aIndex) > 0 )
	EndFilBrw("SZI",_aIndex)
EndIf

Return