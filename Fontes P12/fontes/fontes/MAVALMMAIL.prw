/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MAVALMMAIL�Autor  �Microsiga           � Data �  09/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina que envia e-mail de acordo com evento pre-cadastrado ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MAVALMMAIL()  //ParamIXB={cEvento,aDados,cParUsuario,cParGrUsuario,cParEmails,lEvRH}
Local lEnviar:=.T.  


If ParamIXB[1]=="021" //�"021" - "Log de Processamento - Refaz Acumulados"
	If IsIncallStack("A003Exec")	
		U_A003LOG()
	ElseIf IsIncallStack("A004Exec")
		U_A004LOG()
	EndIf
ElseIf ParamIXB[1]=="022"//�"022" - "Log de Processamento - Saldo Atual"                            �
	If IsIncallStack("A003Exec")	
		U_A003LOG()
	ElseIf IsIncallStack("A004Exec")
		U_A004LOG()
	EndIf
ElseIf ParamIXB[1]=="023"//�"023" - "Log de Processamento - Recalculo do Custo Medio"               �	
	If IsIncallStack("A003Exec")	
		U_A003LOG()
	ElseIf IsIncallStack("A004Exec")
		U_A004LOG()
	EndIf
EndIf

	


Return lEnviar 