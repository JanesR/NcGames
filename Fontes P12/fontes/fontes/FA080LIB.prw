#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA080LIB  �Autor  �                    � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada utilizado na valida��o do motivo da baixa do contas a pagar ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA080LIB()

Local aArea 	:= GetArea()
Local lRet		:= .T.

Local cMotBxOk   := U_MyNewSX6(	"NC_MTBXAP", ;
									"DEBITO CC", ;
									"C", ;
									"Motivo de baixa que poder� ser utilizado na baixa do titulo a receber (FINA080).",;
									"Motivo de baixa que poder� ser utilizado na baixa do titulo a receber (FINA080).",;
									"Motivo de baixa que poder� ser utilizado na baixa do titulo a receber (FINA080).",;
									.F. )


If !(alltrim(cMotBx) $ cMotBxOk) .and. lRet
	lRet := .F.
	Aviso("ERRMOTBX", "Motivo de baixa n�o autorizado. Verificar a utiliza��o do campo com o Depto. Cont�bil."+CRLF+CRLF+; 
						"Obs. Em caso de utiliza��o do motivo, atualizar o par�metro NC_MTBXAP.",{"Ok"},3)
EndIf

RestArea(aArea)

Return lRet