/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA030BUT  �Autor  �Microsiga           � Data �  05/13/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MA030BUT()      
Local aButtons:={}
Local cUserPer 	:= Alltrim(U_MyNewSX6("EC_NCG0009","000307;000086","C","Usuario Adm. produtos E-commerce","","",.F. )   )


If INCLUI .AND. __cUserId$cUserPer
	AAdd(aButtons,{"SIMULACAO"    ,{|| U_M01SIMUL() }   ,"Simular Cadastro Cliente Web"})
EndIf	

Return aButtons