#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "COLORS.CH"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �Motivo    � Autor � Rafael Augusto        � Data �31/05/2010���
�������������������������������������������������������������������������Ĵ��
���Descricao �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �                                                            ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function Motivo()

// Variaveis Locais da Funcao
Public cGet1	 := Space(40)
Public oGet1     := ""
Public aComboBx1 := {"  ","Desconto Comercial","Negociacao aprovada pela Logistica"}
Public cComboBx1

// Variaveis Private da Funcao
Private oDlg				// Dialog Principal

DEFINE MSDIALOG oDlg TITLE "Motivo de nao pagar o Frete" FROM C(274),C(375) TO C(458),C(779) PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(019),C(021) Say "Motivo" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF oDlg
    @ C(035),C(021) ComboBox cComboBx1 Items aComboBx1 Size C(100),C(010) PIXEL OF oDlg
    @ 069,108 BMPBUTTON TYPE 01 ACTION u_xInc2()  
    @ 069,138 BMPBUTTON TYPE 02 ACTION U_FECHAR()//CLOSE(oDlg)
    
ACTIVATE MSDIALOG oDlg CENTERED 

RETURN(aComboBx1)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � CtrlArea � Autor �Ricardo Mansano     � Data � 18/05/2005  ���
�������������������������������������������������������������������������͹��
���Locacao   � Fab.Tradicional  �Contato � mansano@microsiga.com.br       ���
�������������������������������������������������������������������������͹��
���Descricao � Static Function auxiliar no GetArea e ResArea retornando   ���
���          � o ponteiro nos Aliases descritos na chamada da Funcao.     ���
�������������������������������������������������������������������������͹��
���Parametros� nTipo   = 1=GetArea / 2=RestArea                           ���
�������������������������������������������������������������������������͹��
���Aplicacao � Generica.                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/

USER function xInc2()

IF !EMPTY(cComboBx1)

M->C5_MOTFRET := cComboBx1
M->C5_ALTFRETE := UPPER(Alltrim(cUsername))

CLOSE(oDlg)

else

ALERT("Por favor informar o MOTIVO da alteracao!")

Return(.F.)

ENDIF

USER FUNCTION FECHAR()

ALERT("Frete recalculado, por nao informar motivo!")

//u_calcfrete()

CLOSE(oDlg)
