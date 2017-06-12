#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA070MDB  �Autor  �DBM                 � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada utilizado na valida��o do motivo da baixa  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FA070MDB()

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local lMvMult   := U_MyNewSX6(	"NC_ALTMULT", ;
									".F.", ;
									"L", ;
									"Verifica se o campo multa poder� ser alterado, na baixa do titulo a receber (FINA070).",;
									"Verifica se o campo multa poder� ser alterado, na baixa do titulo a receber (FINA070).",;
									"Verifica se o campo multa poder� ser alterado, na baixa do titulo a receber (FINA070).",;
									.F. )

Local cMotBxOk   := U_MyNewSX6(	"NC_MTBXAR", ;
									"NORMAL", ;
									"C", ;
									"Motivo de baixa que poder� ser utilizado na baixa do titulo a receber (FINA070).",;
									"Motivo de baixa que poder� ser utilizado na baixa do titulo a receber (FINA070).",;
									"Motivo de baixa que poder� ser utilizado na baixa do titulo a receber (FINA070).",;
									.F. )

//Verifica se o valor da multa foi preenchido. 
//Obs. Altera��o efetuada conforme o chamado 001243
If (nMulta != 0) .And. (!lMvMult)
	lRet := .F.
	Aviso("ERRMULTA", "O valor da multa n�o pode ser preenchido. Verificar a utiliza��o do campo com o Depto. Cont�bil."+CRLF+CRLF+; 
						"Obs. Em caso de utiliza��o do campo, o par�metro NC_ALTMULT dever� ser alterado para .T..",{"Ok"},3)
EndIf 

If !(alltrim(cMotBx) $ cMotBxOk) .and. lRet
	lRet := .F.
	Aviso("ERRMOTBX", "Motivo de baixa n�o autorizado. Verificar a utiliza��o do campo com o Depto. Cont�bil."+CRLF+CRLF+; 
						"Obs. Em caso de utiliza��o do motivo, atualizar o par�metro NC_MTBXAR.",{"Ok"},3)
EndIf

RestArea(aArea)

Return lRet