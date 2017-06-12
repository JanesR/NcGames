#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���PE        �APURF6OK  �Autor  �Rogerio - Supertech � Data �  08/07/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Trata guia de recolhimento (GNRE) e titulo a pagar 		  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function APURF6OK

Local cName		:= FunName()
Local aArea		:= getarea()
Local aAreaSF2	:= SF2->(getarea())
Local aAreaSE2	:= SE2->(getarea())

If Alltrim(cName) == "MATA460A"
	IF M->F6_OPERNF == "2"
	
		SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENT+F2_LOJA
		SE2->(DbSetOrder(1))//E2_FILIAL+E2_PREFIXO+E2_DOC
		
		IF SF2->(DbSeek(xFilial("SF2")+M->F6_DOC+M->F6_SERIE+M->F6_CLIFOR+M->F6_LOJA))
			SF2->(RecLock("SF2",.F.))
			
			SF2->F2_NFICMST	:= "ICM"+SF2->F2_DOC 
			
			SF2->(MsUnlock())
			
			If SE2->(MsSeek(xFilial("SE2")+"ICM"+SF2->F2_DOC))
				SE2->(RecLock("SF2",.F.))
				
				SE2->E2_PREFIXO	:= "ICM"
				SE2->E2_NUM		:= SF2->F2_DOC
				SE2->E2_HIST	:= "ICMS-ST REF. NF. "+SF2->F2_DOC
				SE2->E2_VENCTO	:= M->F6_DTARREC+2
				SE2->E2_VENCREA	:= M->F6_DTARREC+2 
				
				SE2->(MsUnlock())
			EndIf
			
			M->F6_DTVENC	:= M->F6_DTARREC+2
			M->F6_NUMERO	:= "ICM"+SF2->F2_DOC 
			
		EndIf
	EndIf
EndIf

RestArea(aAreaSE2)
RestArea(aAreaSF2)
RestArea(aArea)

Return
