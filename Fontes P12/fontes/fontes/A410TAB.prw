/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A410TAB   �Autor  �Microsiga           � Data �  10/08/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �PE para considerar Tabela Preco                             ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function A410TAB()

Local aDados:=ParamIxb    //{cProduto,cTabprec,nLin,nQtde,cCliente,cLoja,cLoteCtl,cNumLote,lLote}
Local nPrcVen
Local lTemPromo:=.F.

nPrcVen:=A410Arred( MaTabPrVen(aDados[2],aDados[1],aDados[4],aDados[5],aDados[6]) ,"C6_VALOR")
U_PR707Preco(aDados[5],aDados[6],aDados[1],@nPrcVen,@lTemPromo)
GdFieldPut("C6_YPROMO",IIf(lTemPromo,"S","N"),aDados[3])   


Return nPrcVen