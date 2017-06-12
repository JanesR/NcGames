#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Programa  � KZRELFEN		 �Autor  �                    � Data � 07/07/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � RELAT�RIO DE PESSOAL - FOLHA E ENCARGOS       	 			   ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� NENHUM                  										   ���
������������������������������������������������������������������������������͹��
���Alteracao  � SIDNEY OLIVEIRA - STCH                                         ���
������������������������������������������������������������������������������ͼ��
���Resumo     � Alterado o identificadores do cadastro de verbas campo         ���
              � RV_CODFOL, onde o tamanho do campo foi alterado de 3           ���
			  � caracteres para 4 caractes                                     ���
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

User Function KZRELFEN()
Local olReport			:= Nil
Local dlDtaAux			:= cTod("  /  /  ")
Private cpPerg			:= Padr("KZRELFEN",Len(SX1->X1_GRUPO))
Private cpAliasTmp		:= GetNextAlias()
Private cpArqTmp		:= ""

If TRepInUse(.F.) // Verifica se a ferramenta TREPORT est� dispon�vel
	
	KZ025SX1() // Cria as perguntas (SX1) para execu��o do relat�rio
	
	If Pergunte(cpPerg,.T.) // Exibe a tela de perguntas
		
		olReport := ReportDef() // Defini��o do objeto Treport
		olReport:PrintDialog() // Executa a impress�o
		
	EndIf
	
EndIf

Return()

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �ReportDef  	 �Autor  �                    � Data � 07/07/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � DEFINE O OBJETO DO TREPORT.                   	 			   ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� NENHUM                                   					   ���
������������������������������������������������������������������������������͹��
���Retorno   � OLREPORT: O - Objeto do TReport                                 ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function ReportDef()
Local olReport 		:= Nil
Local olSection1    := Nil
Local olSection2    := Nil
Local olBreak		:= Nil
Local olFunct01		:= Nil
Local olFunct02		:= Nil
Local olFunct03		:= Nil
Local olFunct04		:= Nil
Local olFunct05		:= Nil
Local olFunct06		:= Nil
Local olFunct07		:= Nil
Local olFunct08		:= Nil
Local olFunct09		:= Nil
Local olFunct10		:= Nil
Local olFunct11		:= Nil
Local olFunct12		:= Nil
Local alCampos      := {}
Local clQuebra		:= ""
Local oObj			:= Nil

AADD(alCampos,{"RA_FILIAL"		,"C",TamSx3("RA_FILIAL")[1]		,TamSx3("RA_FILIAL")[2]}	)
AADD(alCampos,{"RA_MAT"			,"C",TamSx3("RA_MAT")[1]		,TamSx3("RA_MAT")[2]}		)
AADD(alCampos,{"RA_CC"			,"C",TamSx3("RA_CC")[1]			,TamSx3("RA_CC")[2]}		)
AADD(alCampos,{"RA_NOME"		,"C",TamSx3("RA_NOME")[1]		,TamSx3("RA_NOME")[2]}		)
AADD(alCampos,{"RA_ADMISSA"		,"D",TamSx3("RA_ADMISSA")[1]	,TamSx3("RA_ADMISSA")[2]}	)
AADD(alCampos,{"X5_3DESCRI"		,"C",TamSx3("X5_DESCRI")[1]		,TamSx3("X5_DESCRI")[2]}	)
AADD(alCampos,{"RJ_DESC"		,"C",TamSx3("RJ_DESC")[1]		,TamSx3("RJ_DESC")[2]}		)
AADD(alCampos,{"RA_NASC"		,"D",TamSx3("RA_NASC")[1]		,TamSx3("RA_NASC")[2]}		)
AADD(alCampos,{"RA_XADMISS"		,"D",TamSx3("RA_ADMISSA")[1]	,TamSx3("RA_ADMISSA")[2]}	)
AADD(alCampos,{"RA_SEXO"		,"C",TamSx3("RA_SEXO")[1]		,TamSx3("RA_SEXO")[2]}		)
AADD(alCampos,{"X5_1DESCRI"		,"C",TamSx3("X5_DESCRI")[1]		,TamSx3("X5_DESCRI")[2]}	)
AADD(alCampos,{"RF_DATABAS"		,"C",TamSx3("RF_DATABAS")[1]	,TamSx3("RF_DATABAS")[2]}	)
AADD(alCampos,{"R7_DATA"		,"D",TamSx3("R7_DATA")[1]		,TamSx3("R7_DATA")[2]}		)
AADD(alCampos,{"X5_2DESCRI"		,"D",TamSx3("X5_DESCRI")[1]		,TamSx3("X5_DESCRI")[2]}	)
AADD(alCampos,{"RA_SALARIO"		,"N",TamSx3("RA_SALARIO")[1]	,TamSx3("RA_SALARIO")[2]}	)
AADD(alCampos,{"RD_VALOR"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"ALTERSAL"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTCONVMED"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTPLANODO"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTTRAEMP"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTTRAFUN"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTREFEIC"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTINSS"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTFGTS"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTPROVFER"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)
AADD(alCampos,{"TOTPROV13"		,"N",TamSx3("RD_VALOR")[1]		,TamSx3("RD_VALOR")[2]}		)

cpArqTmp  := CriaTrab(alCampos,.T.)

/*
Cria uma tabela tempor�ria para utiliza��o no Treport (Obs.: essa tabela n�o � a realmente utilizada, por�m � necess�rio fazer isso para possibilitar)
a sele��o dos campos no setup do Treport. Verifique que posteriormente haver� um DbCloseArea desta Alias, antes da execu��o da Query.
*/
DbUseArea( .T.,__LocalDriver, cpArqTmp, cpAliasTmp, .F., .T. )

/*
Utiliza um bloco de c�digo no objeto TrFunction para setar o valor da vari�vel clQuebra que ser� utilizada para imprimir o valor da filial e centro de custo na quebra do relat�rio
*/
bSetDscBreak := {|| clQuebra := "Filial: " + Alltrim((cpAliasTmp)->(RA_FILIAL)) + " - Centro de Custo: " + Alltrim((cpAliasTmp)->(RA_CC)) + " - Descri��o: " + Alltrim(FDesc("SI3",(cpAliasTmp)->RA_CC,"I3_DESC",,(cpAliasTmp)->RA_FILIAL)) }

olReport := TReport():New("KZRELFEN","Relat�rio de pessoal - Folhas e Encargos",cpPerg,{| oReport | PrintReport(olReport) },"Este relat�rio exibir� os gastos com funcion�rios.",.T.)
olReport:oPage:SetPaperSize(9)
olReport:LDISABLEORIENTATION	:= .T.

/*
Desabilita a escolha de orienta��o do usu�rio. O relat�rio sempre ser� executado na forma de paisagem.
*/

olSection1 := TRSection():New(olReport,"Folhas e Encargos",cpAliasTmp)

TRCell():New(olSection1,"RA_FILIAL"		,"SRA","Filial"						,					,10																										)
TRCell():New(olSection1,"RA_MAT"		,"SRA","Matr�cula"					,					,15																										)
TRCell():New(olSection1,"RA_NOME"		,"SRA","Nome"						,																															)
TRCell():New(olSection1,"RA_ADMISSA"	,"SRA","Admiss�o"					,																															)
TRCell():New(olSection1,"X5_3DESCRI"	,"SRA","Situa��o"					,					,30																										)
TRCell():New(olSection1,"RJ_DESC"		,"SRA","Fun��o"						,					,25																										)
oObj := TRCell():New(olSection1,"RA_NASC"		,"SRA","Idade"						,					,06,,{|| Padc(Alltrim(Str(MyGetIdade( (cpAliasTmp)->RA_NASC ))),6) }															)
oObj:SetHeaderAlign(1)

TRCell():New(olSection1,"RA_XADMISS"	,"SRA","Tempo de Servi�o"			,					,25,,{|| MyGetAdmissao((cpAliasTmp)->RA_ADMISSA) }														)
TRCell():New(olSection1,"RA_SEXO"		,"SRA","Sexo"						,					,15																										)
TRCell():New(olSection1,"X5_2DESCRI"	,"SRA","Grau de Instru��o"			,					,55																										)
TRCell():New(olSection1,"RF_DATABAS"	,"SRA","Per�odo Aquisitivo F�rias"	,					,35,,{||  dToc((cpAliasTmp)->RF_DATABAS) + " - " + dtoc(fCalcFimAq((cpAliasTmp)->RF_DATABAS,"DATA"))}	)
TRCell():New(olSection1,"R7_DATA"   	,"SRA","�ltima Altera��o"			,					,25																										)

olSection2 := TRSection():New(olSection1,"Folhas e Encargos",cpAliasTmp)
olSection2:SetParentRecno(.T.)

TRCell():New(olSection2,"X5_1DESCRI"	,"SRA","Tipo da Altera��o"			,					,35 																									)
TRCell():New(olSection2,"ALTERSAL"		,"SRA","Altera��o Salarial"			,"@E 999,999,999.99",30																										)
TRCell():New(olSection2,"RA_SALARIO"	,"SRA","Sal�rio"					,"@E 999,999,999.99",14																										)
TRCell():New(olSection2,"TOTCONVMED"	,"SRA","Conv�nio M�dico"			,"@E 999,999,999.99",25																										)
TRCell():New(olSection2,"TOTPLANODO"	,"SRA","Plano Odontol�gico"			,"@E 999,999,999.99",28																										)
TRCell():New(olSection2,"TOTTRAEMP"		,"SRA","Transporte (Empresa)"		,"@E 999,999,999.99",30																										)
TRCell():New(olSection2,"TOTTRAFUN"		,"SRA","Transporte (Funcion�rio)"	,"@E 999,999,999.99",35																										)

oObj := TRCell():New(olSection2,"TOTREFEIC"		,"SRA","Refei��o"					,"@E 999,999,999.99",20																										)
oObj:SetHeaderAlign(3)

oObj := TRCell():New(olSection2,"TOTINSS"		,"SRA","Inss"						,"@E 999,999,999.99",14																								)
oObj:SetHeaderAlign(3)

oObj := TRCell():New(olSection2,"TOTFGTS"		,"SRA","Fgts"						,"@E 999,999,999.99",14																										)
oObj:SetHeaderAlign(3)

oObj := TRCell():New(olSection2,"TOTPROVFER"	,"SRA","F�rias"						,"@E 999,999,999.99",14																										)
oObj:SetHeaderAlign(3)

oObj := TRCell():New(olSection2,"TOTPROV13"		,"SRA","13 Sal�rio"					,"@E 999,999,999.99",20																										)
oObj:SetHeaderAlign(3)

olBreak := TRBreak():New( olSection1, {|| (cpAliasTmp)->(RA_FILIAL+RA_CC) } ,"" ,.F.)

/*
Caso o usu�rio escolher a quebra de p�gina por centro de custo o m�todo do objeto TRBreak � executado.
*/

If MV_PAR10 == 1
	olBreak:SetPageBreak(.T.)
EndIf

/*
Define o valor da descri��o para ser impressa na quebra do relat�rio
*/

olBreak:SetTotalText( { ||  clQuebra + " - " + Alltrim(Str(olFunct12:GetValue()) + " funcion�rio"+Iif(olFunct12:GetValue()>1,"s","")  ) } )

olFunct01 := TRFunction():New(olSection2:Cell("RA_SALARIO")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct02 := TRFunction():New(olSection2:Cell("ALTERSAL")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct03 := TRFunction():New(olSection2:Cell("TOTCONVMED")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct04 := TRFunction():New(olSection2:Cell("TOTPLANODO")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct05 := TRFunction():New(olSection2:Cell("TOTTRAEMP")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct06 := TRFunction():New(olSection2:Cell("TOTTRAFUN")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct07 := TRFunction():New(olSection2:Cell("TOTREFEIC")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct08 := TRFunction():New(olSection2:Cell("TOTINSS")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct09 := TRFunction():New(olSection2:Cell("TOTFGTS")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct10 := TRFunction():New(olSection2:Cell("TOTPROVFER")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct11 := TRFunction():New(olSection2:Cell("TOTPROV13")		,, "SUM"	,olBreak ,,"@E 999,999,999.99",				,.T.,.T.,.F.,olSection2		)
olFunct12 := TRFunction():New(olSection2:Cell("RA_SALARIO")		,, "COUNT"	,olBreak ,,"@E 999,999,999.99",bSetDscBreak	,.F.,.F.,.F.,olSection2,,.T.)

/*
Caso o usu�rio escolher n�o exibir os totais o m�todo do objeto TrFunction � executado para esconde-los
*/

If MV_PAR11 == 2
	olFunct01:Hide()
	olFunct02:Hide()
	olFunct03:Hide()
	olFunct04:Hide()
	olFunct05:Hide()
	olFunct06:Hide()
	olFunct07:Hide()
	olFunct08:Hide()
	olFunct09:Hide()
	olFunct10:Hide()
	olFunct11:Hide()
	olFunct12:Hide()
EndIf

Return(olReport)

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �PrintReport	 �Autor  �                    � Data � 07/07/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � EFETUA SELE��O DOS DADOS DE ACORDO COM OS PAR�METROS INICIAIS E ���
���          � EXECUTA O RELAT�RIO.                                            ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� OLREPORT: O - Objeto do TReport               				   ���
������������������������������������������������������������������������������͹��
���Retorno   � NENHUM                                                          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function PrintReport(olReport)
Local olSection1	:= olReport:Section(1)
Local olSection2	:= olReport:Section(1):Section(1)
Local dlMesAnter	:= MsSomaMes(MV_PAR01,-1,.T.)
Local clDaFilial	:= Padr(MV_PAR02,TamSx3("RA_FILIAL")[1])
Local clAteFilial	:= Padr(MV_PAR03,TamSx3("RA_FILIAL")[1])
Local clDoCC		:= Padr(MV_PAR04,TamSx3("RA_CC")[1])
Local clAteCC		:= Padr(MV_PAR05,TamSx3("RA_CC")[1])
Local clDaMat		:= Padr(MV_PAR06,TamSx3("RA_MAT")[1])
Local clAteMat		:= Padr(MV_PAR07,TamSx3("RA_MAT")[1])
Local clSitIns		:= ""
Local clSitOuts		:= ""
Local clSituacs		:= ""
Local clCatIns		:= ""
Local clCatOuts		:= ""
Local clCategos		:= ""
Local clWhere		:= ""
Local clAnoMes		:= SubStr(dTos(MV_PAR01),1,4) + SubStr(dTos(MV_PAR01),5,2)

olReport:oPage:SetPaperSize(9)

If SubStr(MV_PAR08,1,1) == Space(1)
	clSitIns 	+= "@,"
ElseIf SubStr(MV_PAR08,1,1) == "*"
	clSitOuts   += "@,"
EndIf

If SubStr(MV_PAR08,2,1) == "A"
	clSitIns 	+= "A,"
ElseIf SubStr(MV_PAR08,2,1) == "*"
	clSitOuts   += "A,"
EndIf

If SubStr(MV_PAR08,3,1) == "D"
	clSitIns 	+= "D,"
ElseIf SubStr(MV_PAR08,3,1) == "*"
	clSitOuts   += "D,"
EndIf

If SubStr(MV_PAR08,4,1) == "F"
	clSitIns 	+= "F,"
ElseIf SubStr(MV_PAR08,4,1) == "*"
	clSitOuts   += "E,"
EndIf

If SubStr(MV_PAR08,5,1) == "T"
	clSitIns 	+= "T,"
ElseIf SubStr(MV_PAR08,5,1) == "*"
	clSitOuts   += "T,"
EndIf

clSitIns 	:= Left(clSitIns,Len(clSitIns)-1)

clSitOuts 	:= Left(clSitOuts,Len(clSitOuts)-1)

If SubStr(MV_PAR09,1,1) == "A"
	clCatIns += "A,"
ElseIf SubStr(MV_PAR09,1,1) == "*"
	clCatOuts += "A,"
EndIf

If SubStr(MV_PAR09,2,1) == "C"
	clCatIns += "C,"
ElseIf SubStr(MV_PAR09,2,1) == "*"
	clCatOuts += "C,"
EndIf

If SubStr(MV_PAR09,3,1) == "D"
	clCatIns += "D,"
ElseIf SubStr(MV_PAR09,3,1) == "*"
	clCatOuts += "D,"
EndIf

If SubStr(MV_PAR09,4,1) == "E"
	clCatIns += "E,"
ElseIf SubStr(MV_PAR09,4,1) == "*"
	clCatOuts += "E,"
EndIf

If SubStr(MV_PAR09,5,1) == "G"
	clCatIns += "G,"
ElseIf SubStr(MV_PAR09,5,1) == "*"
	clCatOuts += "G,"
EndIf

If SubStr(MV_PAR09,6,1) == "H"
	clCatIns += "H,"
ElseIf SubStr(MV_PAR09,6,1) == "*"
	clCatOuts += "H,"
EndIf

If SubStr(MV_PAR09,7,1) == "I"
	clCatIns += "I,"
ElseIf SubStr(MV_PAR09,7,1) == "*"
	clCatOuts += "I,"
EndIf

If SubStr(MV_PAR09,8,1) == "J"
	clCatIns += "J,"
ElseIf SubStr(MV_PAR09,8,1) == "*"
	clCatOuts += "J,"
EndIf

If SubStr(MV_PAR09,9,1) == "M"
	clCatIns += "M,"
ElseIf SubStr(MV_PAR09,9,1) == "*"
	clCatOuts += "M,"
EndIf

If SubStr(MV_PAR09,10,1) == "P"
	clCatIns += "P,"
ElseIf SubStr(MV_PAR09,10,1) == "*"
	clCatOuts += "P,"
EndIf

If SubStr(MV_PAR09,11,1) == "S"
	clCatIns += "S,"
ElseIf SubStr(MV_PAR09,11,1) == "*"
	clCatOuts += "S,"
EndIf

If SubStr(MV_PAR09,12,1) == "T"
	clCatIns += "T,"
ElseIf SubStr(MV_PAR09,12,1) == "*"
	clCatOuts += "T,"
EndIf

If SubStr(MV_PAR09,13,1) == "Z"
	clCatIns += "Z,"
ElseIf SubStr(MV_PAR09,13,1) == "*"
	clCatOuts += "Z,"
EndIf

clCatIns 	:= Left(clCatIns,Len(clCatIns)-1)

clCatOuts 	:= Left(clCatOuts,Len(clCatOuts)-1)

If !Empty(clSitIns)
	clSitIns	:= StrTran(clSitIns,"@"," ")
	clWhere		+= Iif(!Empty(clWhere),"AND","") + " RA_SITFOLH IN " + FormatIn(clSitIns,",") + " "
EndIf

If !Empty(clSitOuts)
	clSitOuts	:= StrTran(clSitOuts,"@"," ")
	clWhere		+= Iif(!Empty(clWhere),"AND","") + " RA_SITFOLH NOT IN " + FormatIn(clSitOuts,",") + " "
EndIf

If !Empty(clCatIns)
	clWhere		+= Iif(!Empty(clWhere),"AND","") + " RA_CATFUNC IN " + FormatIn(clCatIns,",") + " "
EndIf

If !Empty(clCatOuts)
	clWhere		+= Iif(!Empty(clWhere),"AND","") + " RA_CATFUNC NOT IN " + FormatIn(clCatOuts,",") + " "
EndIf

clWhere	:= "%" + clWhere + "%"

(cpAliasTmp)->(DbCloseArea())

olSection1:BeginQuery()

BeginSql Alias cpAliasTmp
	
	SELECT
	RA_FILIAL
	,RA_MAT
	,RA_NOME
	,RA_ADMISSA
	,RA_CC
	,RA_CODFUNC
	,RJ_DESC
	,RA_NASC
	,RA_SALARIO
	,RA_SEXO
	,RF_DATABAS
	,R7_DATA
	,R3_VALOR AS ALTERSAL
	,SX5_1.X5_DESCRI AS X5_1DESCRI
	,SX5_2.X5_DESCRI AS X5_2DESCRI
	,SX5_3.X5_DESCRI AS X5_3DESCRI
	,(
	SELECT
	NVL(SUM(SRD_1.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_1
	
	LEFT JOIN %table:SRV% SRV_1
	ON SRV_1.RV_FILIAL = %xFilial:SRV%
	AND SRV_1.RV_COD = SRD_1.RD_PD
	AND SRV_1.%notDel%
	
	WHERE SRD_1.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_1.RD_MAT = SRA.RA_MAT
	AND SRD_1.RD_DATARQ = %exp:clAnoMes%
	AND (  
				SRV_1.RV_CODFOL = '0049'
			OR  SRD_1.RD_PD IN ('406','606') 
		)
	AND SRD_1.%notDel%
	) AS TOTCONVMED
	,(
	SELECT
	NVL(SUM(SRD_2.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_2
	
	LEFT JOIN %table:SRV% SRV_2
	ON SRV_2.RV_FILIAL = %xFilial:SRV%
	AND SRV_2.RV_COD = SRD_2.RD_PD
	AND SRV_2.%notDel%
	
	WHERE SRD_2.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_2.RD_MAT = SRA.RA_MAT
	AND SRD_2.RD_DATARQ = %exp:clAnoMes%
	AND (  
				SRV_2.RV_CODFOL IN ('0714','0715','0716','0717','0718','0719')
			OR  SRD_2.RD_PD IN ('540') 
		)
	AND SRD_2.%notDel%
	) AS TOTPLANODO
	,(
	SELECT
	NVL(SUM(SRD_3.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_3
	
	INNER JOIN %Table:SRV% SRV_3
	ON SRV_3.RV_FILIAL = %xFilial:SRV%
	AND SRV_3.RV_COD = SRD_3.RD_PD
	AND SRV_3.RV_CODFOL IN ('0210')
	AND SRV_3.%notDel%
	
	WHERE SRD_3.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_3.RD_MAT = SRA.RA_MAT
	AND SRD_3.RD_DATARQ = %exp:clAnoMes%
	AND SRD_3.%notDel%
	) AS TOTTRAEMP
	,(
	SELECT
	NVL(SUM(SRD_3.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_3
	
	INNER JOIN %Table:SRV% SRV_3
	ON SRV_3.RV_FILIAL = %xFilial:SRV%
	AND SRV_3.RV_COD = SRD_3.RD_PD
	AND SRV_3.RV_CODFOL IN ('0051')
	AND SRV_3.%notDel%
	
	WHERE SRD_3.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_3.RD_MAT = SRA.RA_MAT
	AND SRD_3.RD_DATARQ = %exp:clAnoMes%
	AND SRD_3.%notDel%
	) AS TOTTRAFUN
	,(
	SELECT
	NVL(SUM(SRD_4.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_4
	
	INNER JOIN %Table:SRV% SRV_4
	ON SRV_4.RV_FILIAL = %xFilial:SRV%
	AND SRV_4.RV_COD = SRD_4.RD_PD
	AND SRV_4.RV_CODFOL IN ('0050','0212')
	AND SRV_4.%notDel%
	
	WHERE SRD_4.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_4.RD_MAT = SRA.RA_MAT
	AND SRD_4.RD_DATARQ = %exp:clAnoMes%
	AND SRD_4.%notDel%
	) AS TOTREFEIC
	,(
	SELECT
	NVL(SUM(SRD_5.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_5
	
	INNER JOIN %Table:SRV% SRV_5
	ON SRV_5.RV_FILIAL = %xFilial:SRV%
	AND SRV_5.RV_COD = SRD_5.RD_PD
	AND SRV_5.RV_CODFOL IN ('0148','0149','0150')
	AND SRV_5.%notDel%
	
	WHERE SRD_5.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_5.RD_MAT = SRA.RA_MAT
	AND SRD_5.RD_DATARQ = %exp:clAnoMes%
	AND SRD_5.%notDel%
	) AS TOTINSS
	,(
	SELECT
	NVL(SUM(SRD_6.RD_VALOR),0) AS TOTAL
	FROM %Table:SRD% SRD_6
	
	INNER JOIN %Table:SRV% SRV_6
	ON SRV_6.RV_FILIAL = %xFilial:SRV%
	AND SRV_6.RV_COD = SRD_6.RD_PD
	AND SRV_6.RV_CODFOL IN ('0018','0109')
	AND SRV_6.%notDel%
	
	WHERE SRD_6.RD_FILIAL = SRA.RA_FILIAL
	AND SRD_6.RD_MAT = SRA.RA_MAT
	AND SRD_6.RD_DATARQ = %exp:clAnoMes%
	AND SRD_6.%notDel%
	) AS TOTFGTS
	,(
	
	(
	SELECT
	NVL(SUM(SRT_1.RT_VALOR),0) AS TOTAL
	FROM %Table:SRT% SRT_1
	
	INNER JOIN %Table:SRV% SRV_7
	ON SRV_7.RV_FILIAL = %xFilial:SRV%
	AND SRV_7.RV_COD = SRT_1.RT_VERBA
	AND SRV_7.RV_CODFOL IN ('0130','0131','0132','0254','0255')
	AND SRV_7.%notDel%
	
	WHERE SRT_1.RT_FILIAL = SRA.RA_FILIAL
	AND SRT_1.RT_MAT = SRA.RA_MAT
	AND SRT_1.RT_DATACAL = %exp:MV_PAR01%
	AND SRT_1.%notDel%
	)
	-
	(
	SELECT
	NVL(SUM(SRT_1.RT_VALOR),0) AS TOTAL
	FROM %Table:SRT% SRT_1
	
	INNER JOIN %Table:SRV% SRV_7
	ON SRV_7.RV_FILIAL = %xFilial:SRV%
	AND SRV_7.RV_COD = SRT_1.RT_VERBA
	AND SRV_7.RV_CODFOL IN ('0130','0131','0132','0254','0255')
	AND SRV_7.%notDel%
	
	WHERE SRT_1.RT_FILIAL = SRA.RA_FILIAL
	AND SRT_1.RT_MAT = SRA.RA_MAT
	AND SRT_1.RT_DATACAL = %exp:dlMesAnter%
	AND SRT_1.%notDel%
	)
	
	) AS TOTPROVFER
	,(
	
	(
	SELECT
	NVL(SUM(SRT_2.RT_VALOR),0) AS TOTAL
	FROM %Table:SRT% SRT_2
	
	INNER JOIN %Table:SRV% SRV_7
	ON SRV_7.RV_FILIAL = %xFilial:SRV%
	AND SRV_7.RV_COD = SRT_2.RT_VERBA
	AND SRV_7.RV_CODFOL IN ('0136','0137','0138','0267')
	AND SRV_7.%notDel%
	
	WHERE SRT_2.RT_FILIAL = SRA.RA_FILIAL
	AND SRT_2.RT_MAT = SRA.RA_MAT
	AND SRT_2.RT_DATACAL = %exp:MV_PAR01%
	AND SRT_2.%notDel%
	)
	-
	(
	SELECT
	NVL(SUM(SRT_2.RT_VALOR),0) AS TOTAL
	FROM %Table:SRT% SRT_2
	
	INNER JOIN %Table:SRV% SRV_7
	ON SRV_7.RV_FILIAL = %xFilial:SRV%
	AND SRV_7.RV_COD = SRT_2.RT_VERBA
	AND SRV_7.RV_CODFOL IN ('0136','0137','0138','0267')
	AND SRV_7.%notDel%
	
	WHERE SRT_2.RT_FILIAL = SRA.RA_FILIAL
	AND SRT_2.RT_MAT = SRA.RA_MAT
	AND SRT_2.RT_DATACAL = %exp:dlMesAnter%
	AND SRT_2.%notDel%
	)
	) AS TOTPROV13
	
	FROM %Table:SRA% SRA
	
	INNER JOIN %Table:SRJ% SRJ
	ON RJ_FILIAL = %xFilial:SRJ%
	AND RJ_FUNCAO = RA_CODFUNC
	AND SRJ.%notDel%
	
	INNER JOIN %Table:SRF% SRF
	ON RF_FILIAL = RA_FILIAL
	AND RF_MAT = RA_MAT
	AND SRF.%notDel%
	
	LEFT JOIN ( SELECT 
						 T1.R7_FILIAL
						,T1.R7_MAT
						,T1.R7_TIPO
						,T1.R7_SEQ
						,T1.R7_DATA
						,T1.D_E_L_E_T_
				FROM %Table:SR7% T1
                                
				WHERE T1.R7_DATA =  ( SELECT MAX(R7_DATA) 	FROM %Table:SR7% T2 WHERE  T2.R7_FILIAL = T1.R7_FILIAL AND T2.R7_MAT = T1.R7_MAT )
				AND T1.R7_SEQ  	 =  ( SELECT MAX(R7_SEQ) 	FROM %Table:SR7% T3 WHERE  T3.R7_FILIAL = T1.R7_FILIAL AND T3.R7_MAT = T1.R7_MAT )
		
				)  SR7_1
	
	ON SR7_1.R7_FILIAL = RA_FILIAL
	AND SR7_1.R7_MAT = RA_MAT	
	AND SR7_1.%notDel%
		
	LEFT JOIN %Table:SX5% SX5_1
	ON SX5_1.X5_FILIAL = %xFilial:SX5%
	AND SX5_1.X5_TABELA = '41'
	AND SX5_1.X5_CHAVE = SR7_1.R7_TIPO
	AND SX5_1.%notDel%
	
	INNER JOIN %Table:SX5% SX5_2
	ON SX5_2.X5_FILIAL = %xFilial:SX5%
	AND SX5_2.X5_TABELA = '26'
	AND SX5_2.X5_CHAVE = SRA.RA_GRINRAI
	AND SX5_2.%notDel%
	
	INNER JOIN %Table:SX5% SX5_3
	ON SX5_3.X5_FILIAL = %xFilial:SX5%
	AND SX5_3.X5_TABELA = '31'
	AND SX5_3.X5_CHAVE = SRA.RA_SITFOLH
	AND SX5_3.%notDel%
	
	LEFT JOIN %Table:SR3% SR3_1
	ON SR3_1.R3_FILIAL = SR7_1.R7_FILIAL
	AND SR3_1.R3_MAT = SR7_1.R7_MAT
	AND SR3_1.R3_DATA = SR7_1.R7_DATA
	AND SR3_1.R3_SEQ = SR7_1.R7_SEQ
	AND SR3_1.R3_TIPO = SR7_1.R7_TIPO
	AND SR3_1.R3_TIPO NOT IN ('001','003')
	AND SR3_1.%notDel%
	
	WHERE RA_FILIAL BETWEEN %exp:clDaFilial% AND %exp:clAteFilial%
	AND RA_CC BETWEEN %exp:clDoCc% AND %exp:clAteCC%
	AND RA_MAT BETWEEN %exp:clDaMat% AND %exp:clAteMat%
	AND %exp:clWhere%
	AND RA_CC <> %exp:" "%
	AND SRA.%notDel%
	
	ORDER  BY RA_FILIAL, RA_CC, RA_NOME
	
EndSql

//Aviso("",GetLastQuery()[2],{""},3)

olSection1:EndQuery()
olSection2:SetParentQuery()

Do While !olReport:Cancel() .And. !(cpAliasTmp)->( Eof() )
	
	olReport:IncMeter()
	
	olSection1:Init()
	olSection1:lPrintHeader := .T.
	olSection1:PrintLine()
	
	olSection2:Init()
	olSection2:lPrintHeader := .T.
	olSection2:PrintLine()

	olReport:ThinLine()
	olReport:ThinLine()
	olReport:ThinLine()
	
	olReport:SkipLine()
	olReport:SkipLine()
	
	
	(cpAliasTmp)->(dbSkip())
	
EndDo

olSection1:Finish()
olSection2:Finish()

/*
Finaliza o alias utilizado e exclui o arquivo tempor�rio
*/

(cpAliasTmp)->(DbCloseArea())
FErase(cpArqTmp+GetDbExtension())

Return()

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    � KZ025SX1  	 �Autor  �                    � Data � 07/07/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � FUN��O PARA CRIA��O DE PERGUNTAS (SX1) DO RELAT�RIO             ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� NENHUM                                        				   ���
������������������������������������������������������������������������������͹��
���Retorno   � NENHUM                                                          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function KZ025SX1()
Local alAux	:= {}

aAdd( alAux, {	"01",;		  				   	// 01-Ordem da Pergunta (2)
"Data de refer�ncia ?",;			  				// 02-Descri��o em Portugues (30)
"Data de refer�ncia ?",;			  				// 03-Descri��o em Espanhol (30)
"Data de refer�ncia ?",;			  				// 04-Descri��o em Ingles (30)
"mv_ch1",;							  			// 05-Nome da Vari�vel (6)
"D",;											// 06-Tipo da Vari�vel (1)
008,;											// 07-Tamanho da Vari�vel (2)
000,;											// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"U_MyDtaVal(MV_PAR01)",;						// 11-Express�o de Valida��o da Vari�vel (60)
"",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR01",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe a data de refer�nia para a exe- ",;
"cu��o do relat�rio.                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe a data de refer�nia para a exe- ",;
"cu��o do relat�rio.                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe a data de refer�nia para a exe- ",;
"cu��o do relat�rio.                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"02",;		  				   	// 01-Ordem da Pergunta (2)
"Filial De ?",;			  						// 02-Descri��o em Portugues (30)
"Filial De ?",;			  						// 03-Descri��o em Espanhol (30)
"Filial De ?",;			  						// 04-Descri��o em Ingles (30)
"mv_ch2",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
TamSx3("RA_FILIAL")[1],;						// 07-Tamanho da Vari�vel (2)
TamSx3("RA_FILIAL")[2],;						// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"XM0",;										// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR02",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe a filial inicial para execu��o  ",;
"do relat�rio.                           ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe a filial inicial para execu��o  ",;
"do relat�rio.                           ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe a filial inicial para execu��o  ",;
"do relat�rio.                           ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"03",;		  				   	// 01-Ordem da Pergunta (2)
"Filial At� ? ",;			  					// 02-Descri��o em Portugues (30)
"Filial At� ? ",;			  					// 03-Descri��o em Espanhol (30)
"Filial At� ? ",;			  					// 04-Descri��o em Ingles (30)
"mv_ch3",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
TamSx3("RA_FILIAL")[1],;						// 07-Tamanho da Vari�vel (2)
TamSx3("RA_FILIAL")[2],;						// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"XM0",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR03",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe a filial final para execu��o do ",;
"relat�rio.                              ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe a filial final para execu��o do ",;
"relat�rio.                              ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe a filial final para execu��o do ",;
"relat�rio.                              ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"04",;		  				   	// 01-Ordem da Pergunta (2)
"Centro de Custo De ?",;			  				// 02-Descri��o em Portugues (30)
"Centro de Custo De ?",;			  				// 03-Descri��o em Espanhol (30)
"Centro de Custo De ?",;			  				// 04-Descri��o em Ingles (30)
"mv_ch4",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
TamSx3("RA_CC")[1],;							// 07-Tamanho da Vari�vel (2)
TamSx3("RA_CC")[2],;							// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"CTT",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR04",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe o centro de custo inicial para  ",;
"execu��o do relat�rio.                  ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o centro de custo inicial para  ",;
"execu��o do relat�rio.                  ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o centro de custo inicial para  ",;
"execu��o do relat�rio.                  ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"05",;		  				   	// 01-Ordem da Pergunta (2)
"Centro de Custo At� ?",;			  			// 02-Descri��o em Portugues (30)
"Centro de Custo At� ?",;			  			// 03-Descri��o em Espanhol (30)
"Centro de Custo At� ?",;			  			// 04-Descri��o em Ingles (30)
"mv_ch5",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
TamSx3("RA_CC")[1],;							// 07-Tamanho da Vari�vel (2)
TamSx3("RA_CC")[2],;							// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"CTT",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR05",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe o centro de custo final para exe",;
"cu��o do relat�rio.                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o centro de custo final para exe",;
"cu��o do relat�rio.                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o centro de custo final para exe",;
"cu��o do relat�rio.                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"06",;		  				   	// 01-Ordem da Pergunta (2)
"Matr�cula De ?",;			  					// 02-Descri��o em Portugues (30)
"Matr�cula De ?",;			  					// 03-Descri��o em Espanhol (30)
"Matr�cula De ?",;			  					// 04-Descri��o em Ingles (30)
"mv_ch6",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
TamSx3("RA_MAT")[1],;							// 07-Tamanho da Vari�vel (2)
TamSx3("RA_MAT")[2],;							// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"SRA",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR06",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe a matr�cula inicial para execu- ",;
"��o do relat�rio.                       ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe a matr�cula inicial para execu- ",;
"��o do relat�rio.                       ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe a matr�cula inicial para execu- ",;
"��o do relat�rio.                       ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"07",;		  				   	// 01-Ordem da Pergunta (2)
"Matr�cula At� ?",;			  					// 02-Descri��o em Portugues (30)
"Matr�cula At� ?",;			  					// 03-Descri��o em Espanhol (30)
"Matr�cula At� ?",;			  					// 04-Descri��o em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
TamSx3("RA_MAT")[1],;							// 07-Tamanho da Vari�vel (2)
TamSx3("RA_MAT")[2],;							// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"SRA",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe a matr�cula final para execu��o ",;
"do relat�rio.                           ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe a matr�cula final para execu��o ",;
"do relat�rio.                           ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe a matr�cula final para execu��o ",;
"do relat�rio.                           ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"08",;		  				   	// 01-Ordem da Pergunta (2)
"Situa��es a imprimir ?",;						  			// 02-Descri��o em Portugues (30)
"Situa��es a imprimir ?",;						  			// 03-Descri��o em Espanhol (30)
"Situa��es a imprimir ?",;						  			// 04-Descri��o em Ingles (30)
"mv_ch8",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
005,;											// 07-Tamanho da Vari�vel (2)
000,;											// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"fSituacao",;									// 11-Express�o de Valida��o da Vari�vel (60)
"",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR08",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;											// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe as situa��es dos funcion�rios pa",;
"ra execu��o do relat�rio.               ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe as situa��es dos funcion�rios pa",;
"ra execu��o do relat�rio.               ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe as situa��es dos funcion�rios pa",;
"ra execu��o do relat�rio.               ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"09",;		  				   	// 01-Ordem da Pergunta (2)
"Categorias a imprimir ?",;			  						// 02-Descri��o em Portugues (30)
"Categorias a imprimir ?",;			  						// 03-Descri��o em Espanhol (30)
"Categorias a imprimir ?",;			  						// 04-Descri��o em Ingles (30)
"mv_ch9",;							  			// 05-Nome da Vari�vel (6)
"C",;											// 06-Tipo da Vari�vel (1)
015,;											// 07-Tamanho da Vari�vel (2)
000,;											// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"fCategoria",;									// 11-Express�o de Valida��o da Vari�vel (60)
"",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR09",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"",;											// 20,01-1a. Defini��o em Portugues (15)
"",;											// 20,02-1a. Defini��o em Espanhol (15)
"",;											// 20,03-1a. Defini��o em Ingles (15)
"",;											// 20,04-2a. Defini��o em Portugues (15)
"",;											// 20,05-2a. Defini��o em Espanhol (15)
"",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;											// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe as categorias dos funcion�rioos ",;
"para execu��o do relat�rio.             ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe as categorias dos funcion�rioos ",;
"para execu��o do relat�rio.             ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe as categorias dos funcion�rioos ",;
"para execu��o do relat�rio.             ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"10",;		  				   	// 01-Ordem da Pergunta (2)
"C.Custo em outra pag.?",;			  			// 02-Descri��o em Portugues (30)
"C.Custo em outra pag.?",;			  			// 03-Descri��o em Espanhol (30)
"C.Custo em outra pag.?",;			  			// 04-Descri��o em Ingles (30)
"mv_chA",;							  			// 05-Nome da Vari�vel (6)
"N",;											// 06-Tipo da Vari�vel (1)
001,;											// 07-Tamanho da Vari�vel (2)
000,;											// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR10",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"Sim",;											// 20,01-1a. Defini��o em Portugues (15)
"Sim",;											// 20,02-1a. Defini��o em Espanhol (15)
"Sim",;											// 20,03-1a. Defini��o em Ingles (15)
"N�o",;											// 20,04-2a. Defini��o em Portugues (15)
"N�o",;											// 20,05-2a. Defini��o em Espanhol (15)
"N�o",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe se o relat�rio saltar� p�gina po",;
"r centro de custo ou n�o.               ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe se o relat�rio saltar� p�gina po",;
"r centro de custo ou n�o.               ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe se o relat�rio saltar� p�gina po",;
"r centro de custo ou n�o.               ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"11",;		  				   	// 01-Ordem da Pergunta (2)
"Imprime totais ?",;			  				// 02-Descri��o em Portugues (30)
"Imprime totais ?",;			  				// 03-Descri��o em Espanhol (30)
"Imprime totais ?",;			  				// 04-Descri��o em Ingles (30)
"mv_chB",;							  			// 05-Nome da Vari�vel (6)
"N",;											// 06-Tipo da Vari�vel (1)
001,;											// 07-Tamanho da Vari�vel (2)
000,;											// 08-Casas Decimais da Vari�vel (1)
0,;												// 09-Elemento pr�-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Express�o de Valida��o da Vari�vel (60)
"",;											// 12-Consulta Padr�o para a Vari�vel (6)
"",;											// 13-Identifica de a vers�o � Pyme (1)
"",;											// 14-Grupo de Configura��o do Tamanho (3)
"",;											// 15-Picture para a vari�vel (40)
"",;											// 16-Identificador de Filtro da vari�vel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR11",;									// 18-Nome da vari�vel (15)
"",;											// 19-Conte�do da Vari�vel (15)
{ ;
"Sim",;											// 20,01-1a. Defini��o em Portugues (15)
"Sim",;											// 20,02-1a. Defini��o em Espanhol (15)
"Sim",;											// 20,03-1a. Defini��o em Ingles (15)
"N�o",;											// 20,04-2a. Defini��o em Portugues (15)
"N�o",;											// 20,05-2a. Defini��o em Espanhol (15)
"N�o",;											// 20,06-2a. Defini��o em Ingles (15)
"",;											// 20,07-3a. Defini��o em Portugues (15)
"",;											// 20,08-3a. Defini��o em Espanhol (15)
"",;											// 20,09-3a. Defini��o em Ingles (15)
"",;											// 20,10-4a. Defini��o em Portugues (15)
"",;											// 20,11-4a. Defini��o em Espanhol (15)
"",;											// 20,12-4a. Defini��o em Ingles (15)
"",;											// 20,13-5a. Defini��o em Portugues (15)
"",;											// 20,14-5a. Defini��o em Espanhol (15)
"" },;									   		// 20,15-5a. Defini��o em Ingles (15)
{ { ;
"Informe se o total por centro de custo e",;
"global ser�o impresso.                  ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe se o total por centro de custo e",;
"global ser�o impresso.                  ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe se o total por centro de custo e",;
"global ser�o impresso.                  ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

SavNewX1( { cpPerg, aClone( alAux ) } )

Return()

/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������ͻ��
���Programa   �SavNewX1  � Autor � <Reaproveitada>			 �Data�08.04.2009���
����������������������������������������������������������������������������͹��
���Descricao  �Rotina para gravar, caso n�o exista, um novo grupo de         ���
���           �perguntas para uma rotina.                                    ���
����������������������������������������������������������������������������͹��
���Sintaxe    � SavNewX1()                                                  ���
����������������������������������������������������������������������������͹��
���Observa��es�											                     ���
����������������������������������������������������������������������������͹��
���Parametros �ExpA1 - Array contendo os dados a serem utilizados na inclus�o���
���           �        do novo grupo de perguntas                            ���
���           �        [1] - Nome do Grupo de Perguntas                      ���
���           �        [2] - Array com os itens da pergunta                  ���
���           �        [2,01] - Ordem da Pergunta                            ���
���           �        [2,02] - Descri��o em Portugues                       ���
���           �        [2,03] - Descri��o em Espanhol                        ���
���           �        [2,04] - Descri��o em Ingles                          ���
���           �        [2,05] - Nome da Vari�vel                             ���
���           �        [2,06] - Tipo da Vari�vel                             ���
���           �        [2,07] - Tamanho da Vari�vel                          ���
���           �        [2,08] - Casas Decimais da Vari�vel                   ���
���           �        [2,09] - Quando Choice, elemento pr�-selecionado      ���
���           �        [2,10] - Tipo de Exibi��o (C=Choice,G=Get,K=CheckBox  ���
���           �        [2,11] - Express�o de Valida��o da Vari�vel           ���
���           �        [2,12] - Consulta Padr�o para a Vari�vel              ���
���           �        [2,13] - Identifica de a vers�o � Pyme                ���
���           �        [2,14] - Grupo de Configura��o do Tamanho             ���
���           �        [2,15] - Picture para a vari�vel                      ���
���           �        [2,16] - Identificador de Filtro da vari�vel          ���
���           �        [2,17] - Nome do Help para o grupo de perguntas       ���
���           �        [2,18] - Nome da vari�vel                             ���
���           �        [2,19] - Conte�do da Vari�vel                         ���
���           �        [2,20] - Array contendo as defini��es quando Choice ou���
���           �                 ChekBox                                      ���
���           �        [2,20,01] - 1a. Defini��o em Portugues                ���
���           �        [2,20,02] - 1a. Defini��o em Espanhol                 ���
���           �        [2,20,03] - 1a. Defini��o em Ingles                   ���
���           �        [2,20,04] - 2a. Defini��o em Portugues                ���
���           �        [2,20,05] - 2a. Defini��o em Espanhol                 ���
���           �        [2,20,06] - 2a. Defini��o em Ingles                   ���
���           �        [2,20,07] - 3a. Defini��o em Portugues                ���
���           �        [2,20,08] - 3a. Defini��o em Espanhol                 ���
���           �        [2,20,09] - 3a. Defini��o em Ingles                   ���
���           �        [2,20,10] - 4a. Defini��o em Portugues                ���
���           �        [2,20,11] - 4a. Defini��o em Espanhol                 ���
���           �        [2,20,12] - 4a. Defini��o em Ingles                   ���
���           �        [2,20,13] - 5a. Defini��o em Portugues                ���
���           �        [2,20,14] - 5a. Defini��o em Espanhol                 ���
���           �        [2,20,15] - 5a. Defini��o em Ingles                   ���
���           �        [2,21] - Array contendo os helps para a vari�vel      ���
���           �        [2,21,01] - Array com os textos de help em Portugues  ���
���           �        [2,21,02] - Array com os textos de help em Espanhol   ���
���           �        [2,21,03] - Array com os textos de help em Ingles     ���
����������������������������������������������������������������������������͹��
���Retorno    �ExpA1 - Array contendo os dados desmenbrados                  ���
����������������������������������������������������������������������������͹��
���               ALTERACOES EFETUADAS APOS CONSTRUCAO INICIAL               ���
����������������������������������������������������������������������������͹��
���Analista   �                                              �Data�          ���
����������������������������������������������������������������������������͹��
���Descricao  �                                                              ���
����������������������������������������������������������������������������ͼ��
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function SavNewX1( aDados )

Local aAreaAtu	:= GetArea()
Local aItens	:= aDados[02]
Local aDefine	:= {}
Local nLoop1	:= 0
Local nLoop2	:= 0
Local cGrupo	:= PadR( aDados[01], Len( SX1->X1_GRUPO ) )
Local cKey		:= ""

For nLoop1 := 1 To Len( aItens )
	cKey  := "P." + AllTrim( cGrupo ) + StrZero( Val( aItens[nLoop1, 01] ), 2 ) + "."
	dbSelectArea( "SX1" )
	dbSetOrder( 1 )
	If !( dbSeek( cGrupo + aItens[nLoop1, 01] ) )
		Reclock( "SX1" , .T. )
		SX1->X1_GRUPO	:= cGrupo
		SX1->X1_ORDEM	:= aItens[nLoop1, 01]
		SX1->X1_PERGUNT	:= aItens[nLoop1, 02]
		SX1->X1_PERSPA	:= aItens[nLoop1, 03]
		SX1->X1_PERENG	:= aItens[nLoop1, 04]
		SX1->X1_VARIAVL	:= aItens[nLoop1, 05]
		SX1->X1_TIPO	:= aItens[nLoop1, 06]
		SX1->X1_TAMANHO	:= aItens[nLoop1, 07]
		SX1->X1_DECIMAL	:= aItens[nLoop1, 08]
		SX1->X1_PRESEL	:= aItens[nLoop1, 09]
		SX1->X1_GSC		:= aItens[nLoop1, 10]
		SX1->X1_VALID	:= aItens[nLoop1, 11]
		SX1->X1_F3		:= aItens[nLoop1, 12]
		If SX1->( FieldPos( "X1_PYME" ) ) > 0
			SX1->X1_PYME	:= aItens[nLoop1, 13]
		Endif
		SX1->X1_GRPSXG	:= aItens[nLoop1, 14]
		SX1->X1_PICTURE	:= aItens[nLoop1, 15]
		If SX1->( FieldPos( "X1_IDFIL" ) ) > 0
			SX1->X1_IDFIL	:= aItens[nLoop1, 16]
		Endif
		SX1->X1_HELP	:= aItens[nLoop1, 17]
		SX1->X1_VAR01	:= aItens[nLoop1, 18]
		SX1->X1_CNT01	:= aItens[nLoop1, 19]
		
		If SX1->X1_GSC == "K"
			SX1->X1_TIPO	:= "L"
			SX1->X1_TAMANHO	:= 10
		EndIf
		
		PutSX1Help( cKey, aClone( aItens[nLoop1, 21, 01] ), aClone( aItens[nLoop1, 21, 02] ), aClone( aItens[nLoop1, 03] ) )
		
		If aItens[nLoop1, 10] $ "CK"			// Choice (Multipla Escolha) ou K (CheckBox)
			aDefine	:= aClone( aItens[nLoop1, 20] )
			For nLoop2 := 1 To Len( aDefine )
				SX1->X1_DEF01	:= aDefine[01]
				SX1->X1_DEFSPA1	:= aDefine[02]
				SX1->X1_DEFENG1	:= aDefine[03]
				
				SX1->X1_DEF02	:= aDefine[04]
				SX1->X1_DEFSPA2	:= aDefine[05]
				SX1->X1_DEFENG2	:= aDefine[06]
				
				SX1->X1_DEF03	:= aDefine[07]
				SX1->X1_DEFSPA3	:= aDefine[08]
				SX1->X1_DEFENG3	:= aDefine[09]
				
				SX1->X1_DEF04	:= aDefine[10]
				SX1->X1_DEFSPA4	:= aDefine[11]
				SX1->X1_DEFENG4	:= aDefine[12]
				
				SX1->X1_DEF05	:= aDefine[13]
				SX1->X1_DEFSPA5	:= aDefine[14]
				SX1->X1_DEFENG5	:= aDefine[15]
			Next nLoop2
		EndIf
		MsUnlock()
	EndIf
Next nLoop

RestArea( aAreaAtu )

Return( Nil )

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �MyGetIdade  	 �Autor  �                    � Data � 22/07/12    ���
������������������������������������������������������������������������������͹��
���Desc.     � RETORNA A IDADE CONSIDERANDO N�O S� O ANO, MAS TAMB�M O M�S     ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� dlMyIdade (D) : Data de nascimento        					   ���
������������������������������������������������������������������������������͹��
���Retorno   � nlAnos(N) : Quantidade de anos do funcion�rio                   ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function MyGetIdade(dlMyIdade)
Local nlAnos 	:= 0
Local dlMyData	:= MsDate()

nlAnos := Year(dlMyData) - Year(dlMyIdade)

If  ( Month(dlMyData) - Month(dlMyIdade) ) < 0
	nlAnos--
EndIf

Return(nlAnos)

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �MyGetAdmissao  	 �Autor  �                    � Data � 22/07/12���
������������������������������������������������������������������������������͹��
���Desc.     � RETORNA A QUANTIDADE DE MESES E ANOS QUE O FUNCION�RIO EST� NA  ���
���          � EMPRESA.                                                        ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� dlMyAdmiss (D) : Data de admiss�o          					   ���
������������������������������������������������������������������������������͹��
���Retorno   � nlAnos(N) : Quantidade de anos e meses que o funcion�rio est�   ���
���          � na empresa.                                                     ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function MyGetAdmissao(dlMyAdmiss)
Local nlAnos 		:= 0
Local dlMyData		:= MsDate()
Local nlMeses		:= 0
Local clAdmissao    := ""

nlAnos := Year(dlMyData) - Year(dlMyAdmiss)

nlMeses	:= Month(dlMyData) - Month(dlMyAdmiss)

If nlMeses < 0
	
	nlAnos--
	nlMeses := 12 + nlMeses
	
EndIf

clAdmissao := StrZero(nlAnos,2) + "/" + StrZero(nlMeses,2)

Return(clAdmissao)

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �MyDtaVal       	 �Autor  �                    � Data � 22/07/12���
������������������������������������������������������������������������������͹��
���Desc.     � VERIFICA SE A DATA INFORMADA PELO USU�RIO � A �LTIMA DO M�S.    ���
������������������������������������������������������������������������������͹��
���Uso       � NC GAMES - GEST�O DE PESSOAL                                    ���
������������������������������������������������������������������������������͹��
���Parametros� dlMyDtaRef (D) : Data escolhida no par�metro inicial			   ���
������������������������������������������������������������������������������͹��
���Retorno   � nlAnos(N) : Quantidade de anos e meses que o funcion�rio est�   ���
���          � na empresa.                                                     ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

User Function MyDtaVal(dlMyDtaRef)
Local llRet		:= .T.

If dlMyDtaRef <> LastDay(dlMyDtaRef)
	
	Aviso("KZRELFEN-01";
	,"� obrigat�rio utilizar sempre o �ltimo dia do m�s para ser considerado no relat�rio !";
	,{"Ok"};
	,3)
	
	llRet := .F.
	
EndIF

Return(llRet)
