/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA60FIL   �Autor  �Microsiga           � Data �  05/29/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

//� Verificar a exist�ncia do filtro qdo existir o ExecBlock("FA60FIL") �
User Function FA60FIL()  //Paramixb:={cPort060,cAgen060,cConta060,cSituacao,dVencIni,dVencFim,nLimite,nMoeda,cContrato,dEmisDe,dEmisAte,cCliDe,cCliAte}
Local cFiltro:=".T.
Local cPrefixo	:= Alltrim(U_MyNewSX6(	"EC_NCG0020","ECO","C","Prefixo titulos do ecommerce","","",.F. ))                         
cPrefixo:=Padr(cPrefixo,AvSx3("E1_PREFIXO",3))
cFiltro:="SE1->E1_PREFIXO<>'"+cPrefixo+"'"
Return cFiltro
