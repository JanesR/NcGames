#INCLUDE 'PROTHEUS.CH' 
#INCLUDE "FIVEWIN.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DBRORCAM  �Autor �DBMS - Alberto S. Kibino� Data � 09/24/12 ���
�������������������������������������������������������������������������͹��
���Desc.     � T-REPORT Orcamentos                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Gerencia                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function DBRORCAM()

Local oReport 

	//-- Interface de impressao
	//Pergunte("DBM_ORCAM" ,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()

Return


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � DBMS - Alberto Kibino  � Data � 27/02/2012 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �ExpO1: Objeto do relat�rio                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                      ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local oReport
Local oSection1 
Local oBreak



//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//�������������������������������������������������������������������������� 

oReport := TReport():New("DBM_ORCAM","ORCAMENTO - " + ZZ1->ZZ1_NUMORC + " CLIENTE: " + ZZ1->ZZ1_NPROSP  ,"", {|oReport| ReportPrint(oReport,oSection1)},"ORCAMENTO - " + ZZ1->ZZ1_NUMORC + " ")	// "Relat�rio Gerencia
oReport:SetTotalInLine(.F.)
       

Pergunte(oReport:uParam,.F.)
//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �

oSection1 := TRSection():New(oReport,"Orcamento",{"ZZ2"}) //"Produto (Parte 1)"   
oSection1:SetPageBreak()
oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(Upper(OemToAnsi("Total Orcamento")))
 
//TRCell():New(oSection1,"ZZ1_NUMORC"	,"ZZ1","Numero Orcamento"/*Titulo*/	,PesqPict("ZZ1","ZZ1_NUMORC")/*Picture*/	,TamSX3('ZZ1_NUMORC')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)

//TRCell():New(oSection1,"ZZ1_PROSPC"	,"ZZ1","Cod Prospect"/*Titulo*/	,PesqPict("ZZ1","ZZ1_PROSPC")/*Picture*/	,TamSX3('ZZ1_PROSPC')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
//TRCell():New(oSection1,"ZZ1_LJPROS"	,"ZZ1","Lj Prospect"/*Titulo*/	,PesqPict("ZZ1","ZZ1_LJPROS")/*Picture*/	,TamSX3('ZZ1_LJPROS')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
//TRCell():New(oSection1,"ZZ1_NPROSP"	,"ZZ1","Nome"	/*Titulo*/	,PesqPict("ZZ1","ZZ1_NPROSP")/*Picture*/	,TamSX3('ZZ1_NPROSP')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
//TRCell():New(oSection1,"ZZ1_NVEND1"	,"ZZ1","Vendedor"		/*Titulo*/	,PesqPict("ZZ1","ZZ1_NVEND1") /*Picture*/	,TamSX3('ZZ1_NVEND1')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_ITEM"	,"ZZ2","Item"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_ITEM") /*Picture*/	,TamSX3('ZZ2_ITEM')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_CODPRO"	,"ZZ2","Cod Produto"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_CODPRO") /*Picture*/	,TamSX3('ZZ2_CODPRO')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_EAN"	,"ZZ2","EAN"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_EAN") /*Picture*/	,TamSX3('ZZ2_EAN')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_DESCRI"	,"ZZ2","Descricao"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_DESCRI") /*Picture*/	,TamSX3('ZZ2_DESCRI')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_PLATF"	,"ZZ2","Plataforma"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_PLATF") /*Picture*/	,TamSX3('ZZ2_PLATF')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_PUBLIS"	,"ZZ2","Publisher"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_PUBLIS") /*Picture*/	,TamSX3('ZZ2_PUBLIS')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_GENERO"	,"ZZ2","Genero"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_GENERO") /*Picture*/	,TamSX3('ZZ2_GENERO')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection1,"ZZ2_QUANT"	,"ZZ2","Quant."		/*Titulo*/	,PesqPict("ZZ2","ZZ2_QUANT") /*Picture*/	,TamSX3('ZZ2_QUANT')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_PRVACR"	,"ZZ2","Preco"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_PRVACR") /*Picture*/	,TamSX3('ZZ2_PRVACR')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"ZZ2_TOTAL"	,"ZZ2","Total"		/*Titulo*/	,PesqPict("ZZ2","ZZ2_TOTAL") /*Picture*/	,TamSX3('ZZ2_TOTAL')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)

TRFunction():New(oSection1:Cell("ZZ2_ITEM"),NIL,"COUNT",,,PesqPict("ZZ2","ZZ2_ITEM") 	,/*{|| oSection1:Cell("VLRUSEMIMP"):GetValue(.T.)}*/,.T.,.F.) 
TRFunction():New(oSection1:Cell("ZZ2_QUANT"),NIL,"SUM",,,"@E 999,999,999,999.99"	,/*{|| oSection1:Cell("VLRUSEMIMP"):GetValue(.T.)}*/,.T.,.F.) 
//TRFunction():New(oSection1:Cell("ZZ2_PRVACR"),NIL,"SUM",,,"@E 999,999,999,999.99"	,/*{|| oSection1:Cell("VLRUSEMIMP"):GetValue(.T.)}*/,.T.,.F.) 
TRFunction():New(oSection1:Cell("ZZ2_TOTAL"),NIL,"SUM",,,"@E 999,999,999,999.99"	,/*{|| oSection1:Cell("VLRUSEMIMP"):GetValue(.T.)}*/,.T.,.F.) 

Return(oReport)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrin� Autor � Marco Bianchi         � Data � 12/07/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpO1: Objeto Report do Relat�rio                           ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport,oSection1)

Local clQry	:= "" 
Local cAlias := GetNextAlias()

Local nTotReg  := 0 
Local llFirst := .T.

Local bQuery		:= {|| Iif(Select(calias) > 0, (calias)->(dbCloseArea()), Nil), dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),calias,.F.,.T.) , dbSelectArea(calias), (calias)->(dbGoTop()), nTotReg := 0, (calias)->(dbEval({|| nTotReg++ })), (calias)->(dbGoTop())}
                                        

    clQry := " SELECT ZZ1_NUMORC,ZZ1_TOTAL,ZZ1_QTDTOT, ZZ1_PROSPC, ZZ1_LJPROS, ZZ1_NPROSP, ZZ1_NVEND1, ZZ2_ITEM, ZZ2_CODPRO, ZZ2_EAN, ZZ2_DESCRI,ZZ2_PLATF, ZZ2_PUBLIS,ZZ2_GENERO, ZZ2_QUANT, ZZ2_PRVACR, ZZ2_TOTAL"
    clQry += " FROM " + RetSqlName("ZZ1") + "  ZZ1"
    clQry += " JOIN " + RetSqlName("ZZ2") + "  ZZ2"
    clQry += " ON ZZ2_NUMORC = ZZ1_NUMORC"
    clQry += " AND ZZ2_FILIAL = ZZ1_FILIAL"
    clQry += " AND ZZ2.D_E_L_E_T_ = ' '"
    clQry += " WHERE ZZ1_NUMORC = '" + ZZ1->ZZ1_NUMORC + "' 
    clQry += " AND ZZ1_FILIAL = '" + xFilial("ZZ1") + "' "
    clQry += " AND ZZ1.D_E_L_E_T_ = '  ' " 
    clQry += " ORDER BY ZZ2_FILIAL, ZZ2_NUMORC, ZZ2_ITEM"
    
  	    		
	LJMsgRun("Consultando Itens...","Aguarde...",bQuery)
	//Eval(bQuery)
	oReport:SetMeter((cAlias)->(LastRec()))
	oReport:Section(1):Init()
	oReport:PrintText("   Sugest�o or�amento   " + " Cliente: " + (cAlias)->ZZ1_PROSPC + "/" + (cAlias)->ZZ1_LJPROS + " - " + (cAlias)->ZZ1_NPROSP)
	oReport:PrintText("  Quant.: " + AllTrim(Str((cAlias)->ZZ1_QTDTOT)))
	oReport:PrintText("  Valor total sem IPI : " + Transform((cAlias)->ZZ1_TOTAL,"@E 999,999,999.99"))
	oReport:PrintText("  Vendedor: " + (cAlias)->ZZ1_NVEND1) 
	oReport:Skipline()
	oReport:PrintText("  * Valores e quantidades est�o sujeitos a altera��es e disponibilidade de estoque.")  
	oReport:PrintText("  * Os Valores de frete, seguro e impostos n�o est�o embutidos neste or�amento.")  
	 
	
	
Do While !oReport:Cancel() .And. (cAlias)->(!Eof())
	
	If !llFirst	 
		//oSection1:Cell("ZZ1_PROSPC"):Hide()
		//oSection1:Cell("ZZ1_PROSPC"):SetValue((cAlias)->ZZ1_PROSPC)
		//oSection1:Cell("ZZ1_LJPROS"):Hide() 
		//oSection1:Cell("ZZ1_LJPROS"):SetValue((cAlias)->ZZ1_LJPROS) 
		//oSection1:Cell("ZZ1_NPROSP"):Hide()
		//oSection1:Cell("ZZ1_NPROSP"):SetValue((cAlias)->ZZ1_NPROSP)
	    //oSection1:Cell("ZZ1_NVEND1"):Hide()
	    //
	    //oSection1:Cell("ZZ1_NVEND1"):SetValue((cAlias)->ZZ1_NVEND1)
	    
	 Else
	 	//oSection1:Cell("ZZ1_PROSPC"):Show()
		//oSection1:Cell("ZZ1_PROSPC"):SetValue((cAlias)->ZZ1_PROSPC)
		//oSection1:Cell("ZZ1_LJPROS"):Hide() 
		//oSection1:Cell("ZZ1_LJPROS"):SetValue((cAlias)->ZZ1_LJPROS) 
		//oSection1:Cell("ZZ1_NPROSP"):Show()
		//oSection1:Cell("ZZ1_NPROSP"):SetValue((cAlias)->ZZ1_NPROSP)
	    //oSection1:Cell("ZZ1_NVEND1"):Show()
	    //oSection1:Cell("ZZ1_NVEND1"):SetValue((cAlias)->ZZ1_NVEND1) 
	    llFirst := .F.
	 EndIf
	oSection1:Cell("ZZ2_ITEM"):Show()
	oSection1:Cell("ZZ2_ITEM"):SetValue((cAlias)->ZZ2_ITEM)
	oSection1:Cell("ZZ2_CODPRO"):Show()
	oSection1:Cell("ZZ2_CODPRO"):SetValue((cAlias)->ZZ2_CODPRO)
	oSection1:Cell("ZZ2_EAN"):Show()
	oSection1:Cell("ZZ2_EAN"):SetValue((cAlias)->ZZ2_EAN)
	oSection1:Cell("ZZ2_DESCRI"):Show()
	oSection1:Cell("ZZ2_DESCRI"):SetValue((cAlias)->ZZ2_DESCRI)
	oSection1:Cell("ZZ2_PLATF"):Show()
	oSection1:Cell("ZZ2_PLATF"):SetValue((cAlias)->ZZ2_PLATF)
	oSection1:Cell("ZZ2_PUBLIS"):Show()
	oSection1:Cell("ZZ2_PUBLIS"):SetValue((cAlias)->ZZ2_PUBLIS)
	oSection1:Cell("ZZ2_GENERO"):Show()
	oSection1:Cell("ZZ2_GENERO"):SetValue((cAlias)->ZZ2_GENERO) 
	oSection1:Cell("ZZ2_QUANT"):Show()
	oSection1:Cell("ZZ2_QUANT"):SetValue((cAlias)->ZZ2_QUANT) 
	oSection1:Cell("ZZ2_PRVACR"):Show()
	oSection1:Cell("ZZ2_PRVACR"):SetValue((cAlias)->ZZ2_PRVACR) 
	oSection1:Cell("ZZ2_TOTAL"):Show()
	oSection1:Cell("ZZ2_TOTAL"):SetValue((cAlias)->ZZ2_TOTAL) 

	oReport:IncMeter()
	oReport:Section(1):PrintLine()
	(cAlias)->(dbSkip())
End

	
	
	
	

oReport:Section(1):Finish()


Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DBMCRIASX1 �Autor � DBMS- Alberto     � Data �  27/02/2012  ���
�������������������������������������������������������������������������͹��
���Desc.     � Static Function para criacao de perguntas                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function DBMCRIASX1()

PutSx1("DBM_FINSD","01","Filial"			,"Filial"			,"Filial"	   		,"mv_ch1","C",20,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_FINSD","02","Data Base"	   		,"Da Base"			,"Da Base"  		,"mv_ch2","D",08,0,1,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_FINSD","03","Cliente de"	    ,"Cliente de"	    ,"Cliente de"	    ,"mv_ch3","C",06,0,1,"G","","SA1","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_FINSD","04","Cliente de"	    ,"Cliente de"	    ,"Cliente de"	    ,"mv_ch4","C",06,0,1,"G","","SA1","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_FINSD","05","Valor Bruto ou Liquido","Valor Bruto ou Liquido","Valor Bruto ou Liquido","mv_ch5","N",01,0,1,"C","","","","","mv_par05","Bruto","Bruto","Bruto","","Liquido","Liquido","Liquido","","","","","","","","","",{},{},{})

//PutSx1("DBM_FINSD","04","Cod. Produto ate"	,"Cod. Produto ate"	,"Cod. Produto ate" ,"mv_ch4","C",30,0,1,"G","","SB1","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_FINSD","05","Tipo ASUS de"		,"Tipo ASUS de"		,"Tipo ASUS de"		,"mv_ch5","C",80,0,1,"G","","SXB003","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_RLCM","06","Local de"			,"Local de"			,"Local de"			,"mv_ch6","C",02,0,1,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_RLCM","07","Local Ate"			,"Local Ate"		,"Local Ate"		,"mv_ch7","C",02,0,1,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_RAGIN","08","Imprimir zerados?"	,"Imprimir Zerados?","Print empty? "	,"mv_ch8","N",01,0,1,"C","","","","","mv_par08","Sim","Si","Yes","","Nao","No","No","","","","","","","","","",{},{},{})

//PutSx1("DBM_RAGIN","05","Tipo ASUS Ate"		,"Tipo ASUS Ate"	,"Tipo ASUS Ate"	,"mv_ch5","C",10,0,1,"G","","SZ1","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_RAGIN","06","Ate a Emissao"	,"Ate a Emissao"	,"Ate a Emissao"	,"mv_chB","D",08,0,1,"G","","","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_RFATGM","11","Tes de"			,"Tes de"			,"Tes de"			,"mv_chB","C",03,0,1,"G","","SF4","","","mv_par11","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_RFATGM","12","Tes Ate"			,"Tes Ate"			,"Tes Ate"			,"mv_chC","C",03,0,1,"G","","SF4","","","mv_par12","","","","","","","","","","","","","","","","",{},{},{})


Return  

