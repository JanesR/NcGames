#INCLUDE 'PROTHEUS.CH' 
#INCLUDE "FIVEWIN.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBRINDIC  ºAutor ³DBMS - Alberto S. Kibinoº Data ³ 26/09/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ T-REPORT Indicadores. Analisa vendas dos ultimos 3 meses.  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Comercial                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function DBRINDIC()

Local oReport 
	DBMCRIASX1()

	//-- Interface de impressao
	Pergunte("DBM_INDIC" ,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()

Return


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ DBMS - Alberto Kibino  ³ Data ³ 26/09/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oSection1 
Local oBreak





//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

oReport := TReport():New("DBMINDIC","INDICADORES"  ,"DBM_INDIC", {|oReport| ReportPrint(oReport,oSection1)},"INDICADORES")	// "Relatório Gerencia
oReport:SetTotalInLine(.F.)
       

Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³

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

TRCell():New(oSection1,"EROSAO"		,""		,"Erosão"		/*Titulo*/		,"@!" /*Picture*/					,3/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"STATUS"		,""		,"Status"		/*Titulo*/		,"@!" /*Picture*/					,11/*Tamanho*/	,/*lPixel*/,/*{|| code-block de impressao }*/)


Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 12/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
//Subquery para trazer quantidade de faturas de 3 meses anteriores a data base do parâmetro.
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
//Subquery para trazer quantidade de faturas de 2 meses anteriores a data base do parâmetro.
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
//Subquery para trazer quantidade de faturas do mes anterior a data base do parâmetro.
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBMCRIASX1 ºAutor ³ DBMS- Alberto     º Data ³  27/02/2012  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Static Function para criacao de perguntas                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function DBMCRIASX1()

PutSx1("DBM_INDIC","01","Data Base"	   		,"Da Base"			,"Da Base"  		,"mv_ch1","D",08,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_INDIC","02","Canal de"			,"Canal de"	   		 ,"Canal de"	    ,"mv_ch2","C",06,0,1,"G","","ACA","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_INDIC","03","Canal Ate"	    	,"Canal Ate"	   	,"Canal Ate"	    ,"mv_ch3","C",06,0,1,"G","","ACA","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})


Return  

