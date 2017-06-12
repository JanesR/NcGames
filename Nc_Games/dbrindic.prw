#INCLUDE 'PROTHEUS.CH' 
#INCLUDE "FIVEWIN.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DBRINDIC  �Autor �DBMS - Alberto S. Kibino� Data � 26/09/12 ���
�������������������������������������������������������������������������͹��
���Desc.     � T-REPORT Indicadores. Analisa vendas dos ultimos 3 meses.  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Comercial                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function DBRINDIC()

Local oReport 
	DBMCRIASX1()

	//-- Interface de impressao
	Pergunte("DBM_INDIC" ,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()

Return


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � DBMS - Alberto Kibino  � Data � 26/09/2012 ���
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

oReport := TReport():New("DBMINDIC","INDICADORES"  ,"DBM_INDIC", {|oReport| ReportPrint(oReport,oSection1)},"INDICADORES")	// "Relat�rio Gerencia
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

oSection1 := TRSection():New(oReport,"INDICADORES",{"SA1"}) //"Produto (Parte 1)"   
oSection1:SetPageBreak()
oSection1:SetTotalInLine(.F.)
//oSection1:SetTotalText(Upper(OemToAnsi("Total Pedido")))
TRCell():New(oSection1,"A1_COD"		,"SA1"	,"Cod Cliente"		/*Titulo*/	,PesqPict("SA1","A1_COD") /*Picture*/	,TamSX3('A1_COD')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A1_NREDUZ"	,""		,"Nome Cliente"		/*Titulo*/	,PesqPict("SA1","A1_NREDUZ") /*Picture*/	,TamSX3('A1_NREDUZ')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A1_YCANAL"	,""		,"Cod Canal"		/*Titulo*/	,PesqPict("SA1","A1_YCANAL") /*Picture*/	,TamSX3('A1_YCANAL')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A1_YDCANAL"	,""		,"Canal"			/*Titulo*/	,PesqPict("SA1","A1_YDCANAL") /*Picture*/	,TamSX3('A1_YDCANAL')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A3_COD"		,"SA1"	,"Cod Vendedor"		/*Titulo*/	,PesqPict("SA3","A3_COD") /*Picture*/	,TamSX3('A3_COD')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A3_NOME"	,""		,"Nome Vendedore"		/*Titulo*/	,PesqPict("SA3","A3_NOME") /*Picture*/	,TamSX3('A1_NOME')[1]/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection1,"MES01"		,""		,"MES-3"		/*Titulo*/		,"9999" /*Picture*/				,4/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"MES02"		,""		,"MES-2"		/*Titulo*/		,"9999" /*Picture*/				,4/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"MES03"		,""		,"MES-1"		/*Titulo*/		,"9999" /*Picture*/				,4/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"MES04"		,""		,"MES-BASE"		/*Titulo*/		,"9999" /*Picture*/				,4/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection1,"EROSAO"		,""		,"Eros�o"		/*Titulo*/		,"@!" /*Picture*/					,3/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"STATUS"		,""		,"Status"		/*Titulo*/		,"@!" /*Picture*/					,11/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)


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

Local nlMes	:= 0 

DbSelectArea("SA1")
DbSetOrder(1)

DbSelectArea("SA3")
DbSetOrder(1)

DbSelectArea("ACA")
DbSetOrder(1)


//Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-3,2) + "15" ))                                        

clQry := " SELECT A1_FILIAL, A1_COD," 
clQry += " SUM("
//Subquery para trazer quantidade de faturas de 3 meses anteriores a data base do par�metro.
clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlName("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-3,2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-3,2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA"
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M1,"
//Subquery para trazer quantidade de faturas de 2 meses anteriores a data base do par�metro.
clQry += " SUM("

clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlname("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-2,2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-2,2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA"
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M2,"
//Subquery para trazer quantidade de faturas do mes anterior a data base do par�metro.
clQry += " SUM("
clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlname("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-1,2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01)-1,2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA" 
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M3,"
// faturas do mes atual
clQry += " SUM("
clQry += " COALESCE("
clQry += " (SELECT COUNT(F2_DOC)"
clQry += " FROM " + RetSqlname("SF2") + " S2"
clQry += " WHERE S2.F2_EMISSAO BETWEEN '" + DtoS(Firstday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01),2) + "15" ))) + "' AND '" + DtoS(Lastday(Stod(Strzero(Year(MV_PAR01),4) + StrZero(Month(MV_PAR01),2) + "15" ))) + "' "
clQry += " AND S2.F2_CLIENTE = SA1.A1_COD"
clQry += " AND S2.F2_LOJA = SA1.A1_LOJA"
clQry += " AND S2.F2_FILIAL = '" + xFilial("SF2") + "'"
clQry += " AND S2.F2_TIPO = 'N'"
clQry += " AND S2.F2_DUPL <> '         '"
clQry += " AND S2.D_E_L_E_T_ = ' ')"
clQry += " ,0)) AS M4"


clQry += " FROM " + RetSqlName("SA1") + " SA1"

clQry += " WHERE SA1.D_E_L_E_T_ = ' '"
clQry += " AND A1_PRICOM <> '        '"
clQry += " AND A1_YCANAL BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "'"
clQry += " GROUP BY A1_FILIAL, A1_COD"
clQry += " ORDER BY A1_FILIAL, A1_COD"   


clQry := ChangeQuery(clQry)




    
  	    		
LJMsgRun("Consultando Clientes...","Aguarde...",bQuery)
	//Eval(bQuery)
	oReport:SetMeter((cAlias)->(LastRec()))
	oReport:Section(1):Init()	 
	
Do While !oReport:Cancel() .And. (cAlias)->(!Eof()) 
	If SA1->(DbSeek(xFilial("SA1") + (cAlias)->A1_COD))


		oSection1:Cell("A1_COD"):Show()
		oSection1:Cell("A1_COD"):SetValue((cAlias)->A1_COD)
		oSection1:Cell("A1_NREDUZ"):Show()
		oSection1:Cell("A1_NREDUZ"):SetValue(SA1->A1_NREDUZ)
		
		oSection1:Cell("A1_YCANAL"):Show()
		oSection1:Cell("A1_YCANAL"):SetValue(SA1->A1_YCANAL)
		oSection1:Cell("A1_YDCANAL"):Show() 
		oSection1:Cell("A1_YDCANAL"):SetValue(SA1->A1_YDCANAL) 
		If SA3->(dbSeek(xFilial("SA3") + SA1->A1_VEND))
			oSection1:Cell("A3_COD"):Show()
			oSection1:Cell("A3_COD"):SetValue(SA1->A1_VEND)
			oSection1:Cell("A3_NOME"):Show()
	   		oSection1:Cell("A3_NOME"):SetValue(SA3->A3_NOME)
		Else
			oSection1:Cell("A3_COD"):Show()
			oSection1:Cell("A3_COD"):SetValue(SA1->A1_VEND) 
			oSection1:Cell("A3_NOME"):Show()
	   		oSection1:Cell("A3_NOME"):SetValue("     ")
			
		EndIf
		
		oSection1:Cell("MES01"):Show() 
		oSection1:Cell("MES01"):SetValue((cAlias)->M1)
		oSection1:Cell("MES02"):Show() 
		oSection1:Cell("MES02"):SetValue((cAlias)->M2)
		oSection1:Cell("MES03"):Show()
		oSection1:Cell("MES03"):SetValue((cAlias)->M3)
		oSection1:Cell("MES04"):Show()
		oSection1:Cell("MES04"):SetValue((cAlias)->M4)
			
		
		If (cAlias)->M1 = 0 .and. (cAlias)->M2 = 0 .and. (cAlias)->M3 = 0
			If Month(SA1->A1_PRICOM) == Month(MV_PAR01) .And. Year(SA1->A1_PRICOM) == Year(MV_PAR01)
				oSection1:Cell("STATUS"):Show()
	   			oSection1:Cell("STATUS"):SetValue("NOVO")
	   			oSection1:Cell("EROSAO"):Show()
				oSection1:Cell("EROSAO"):SetValue("NAO")
	   		Else
	   			oSection1:Cell("EROSAO"):Show()
				oSection1:Cell("EROSAO"):SetValue("SIM")
				If (cAlias)->M4 > 0
	   				oSection1:Cell("STATUS"):Show()
		   			oSection1:Cell("STATUS"):SetValue("REATIVADO") 
		   		Else                                         
		   			oSection1:Cell("STATUS"):Show()
		   			oSection1:Cell("STATUS"):SetValue("NAO COMPROU") 
		   		EndIf
	   		EndIf                                              
	   Else 
	   		oSection1:Cell("EROSAO"):Show()
			oSection1:Cell("EROSAO"):SetValue("NAO")
	   		If (cAlias)->M4 > 0
		   		oSection1:Cell("STATUS"):Show()
	   			oSection1:Cell("STATUS"):SetValue("COMPROU")
	   		Else                                         
	   			oSection1:Cell("STATUS"):Show()
	   			oSection1:Cell("STATUS"):SetValue("NAO COMPROU")
	   		EndIf
	   EndIf	
	EndIf

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

PutSx1("DBM_INDIC","01","Data Base"	   		,"Da Base"			,"Da Base"  		,"mv_ch1","D",08,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_INDIC","02","Canal de"			,"Canal de"	   		 ,"Canal de"	    ,"mv_ch2","C",06,0,1,"G","","ACA","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_INDIC","03","Canal Ate"	    	,"Canal Ate"	   	,"Canal Ate"	    ,"mv_ch3","C",06,0,1,"G","","ACA","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})


Return  

