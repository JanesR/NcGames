
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NcgFatG1     �Autor  �Lucas Felipe     � Data �  10/10/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NcgFatG1()

Local cAliasAtu	:= GetArea()
Local cVend1	:= M->C5_VEND1
Local cTransp	:= Alltrim(U_MyNewSX6("NCG_000070","000122","C","Transp. padr�o Ped. Ret. Conserto ","","",.F. ))
Local cVendP	:= Alltrim(U_MyNewSX6("NCG_000071","VN0014","C","Vendedor Ped. Ret. Conserto ","","",.F. ))

If cVend1 == cVendP
	M->C5_TRANSP := cTransp
	MsgAlert("A transportadora foi alterada para "+cTransp,"WOS-B1cH4")
	M->C5_NOMCLI := Posicione("SA1",1,xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,"A1_NREDUZ")                           
Else
	M->C5_TRANSP := Posicione("SA1",1,xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,"A1_TRANSP")
EndIf

Return cVend1
