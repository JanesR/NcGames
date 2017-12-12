#INCLUDE "MATR580.CH" 
#Include "FIVEWIN.Ch"

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � NC_MATR580� Autor � Marco Bianchi        � Data � 26/06/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Estatistica de Venda por Ordem de Vendedor                 ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT - R4 - ESPECIFICO NC GAMES                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function NC_MATR580()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Marco Bianchi         � Data � 26/06/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
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
Local oFatVend

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
oReport := TReport():New("NC_MATR580",STR0015,"MTR580", {|oReport| ReportPrint(oReport,oFatVend)},STR0016 + " " + STR0017 + " " + STR0018)
//oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)
                            
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
AjustaSx1()
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
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
//�                                                                        �
//�TRCell():New                                                            �
//�ExpO1 : Objeto TSection que a secao pertence                            �
//�ExpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//�ExpC3 : Nome da tabela de referencia da celula                          �
//�ExpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//�ExpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//�ExpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//�ExpL7 : ITforme se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//�ExpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
oFatVend := TRSection():New(oReport,STR0026,{"SA3"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oFatVend:SetTotalInLine(.F.)
TRCell():New(oFatVend,"CVEND"		,		,RetTitle("A3_COD")			,PesqPict("SA3","A3_COD")		,TamSx3("A3_COD")		[1]	,/*lPixel*/,/*{|| cVend }*/						)		// "Codigo do Vendedor"
TRCell():New(oFatVend,"CNOME"		,		,RetTitle("A3_NOME")		,PesqPict("SA3","A3_NOME")		,TamSx3("A3_NOME")		[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Vendedor"

If cPaisLoc=="BRA"
	TRCell():New(oFatVend,"TB_VALOR1"	,"TRB"	,STR0019					,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)		// "Faturamento S/ ICM/IPI"
Else
	TRCell():New(oFatVend,"TB_VALOR1"	,"TRB"	,STR0029					,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)		// "Faturamento sem Impostos
EndIf

TRCell():New(oFatVend,"TB_VALOR2"	,"TRB"	,STR0020					,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor da Mercadoria"
TRCell():New(oFatVend,"TB_VALOR3"	,"TRB"	,STR0021					,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor Total"
TRCell():New(oFatVend,"NRANK"		,		,STR0022					,"@E 9999"						,4							,/*lPixel*/,/*{|| nRank }*/						)       // "Ranking"

//novo campo qtd vendida
TRCell():New(oFatVend,"TB_VALOR4"	,"TRB"	,"Quantidade Vendida"		,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"
TRCell():New(oFatVend,"TB_VALOR5"	,"TRB","Pre�o M�dio"				,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| TRB->(TB_VALOR3/TB_VALOR4) }*/	)		// "Pre�o M�dio"
// Totalizadores
TRFunction():New(oFatVend:Cell("TB_VALOR1"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR2"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR3"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
//novo campo qtd vendida
TRFunction():New(oFatVend:Cell("TB_VALOR4"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
//TRFunction():New(oFatVend:Cell("TB_VALOR5"),/* cID */,"AVERAGE",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

// Alinhamento das colunas de valor a direita
oFatVend:Cell("TB_VALOR1"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR2"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR3"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR4"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR5"):SetHeaderAlign("RIGHT")


// Esta Secao serve apenas para receber as Querys, pois como o relatorio e baseado na tabela TRB, as Querys 
// sao fechadas, estes Alias nao sao reconhecidos pelo objeto oFatVend pois nao esta no array de tabelas
//oTemp := TRSection():New(oReport,STR0027,{"SD2","SF2","SF4","SD1","SF1","TRB"},,/*Campos do SX3*/,/*Campos do SIX*/)	
oTemp1 := TRSection():New(oReport,STR0027,{"SF2","SD2","SF4"},,/*Campos do SX3*/,/*Campos do SIX*/)	
oTemp1:SetTotalInLine(.F.)

oTemp2 := TRSection():New(oReport,STR0028,{"SF1","SD1"},,/*Campos do SX3*/,/*Campos do SIX*/)	
oTemp2:SetTotalInLine(.F.)
                          
oReport:Section(2):SeteditCell(.F.)
oReport:Section(3):SeteditCell(.F.)


Return(oReport)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrin� Autor �Marco Bianchi          � Data � 26/06/06 ���
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
Static Function ReportPrint(oReport,oFatVend)

//��������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                      �
//����������������������������������������������������������������
Local cEstoq 	:= If( (MV_PAR09 == 1),"S",If( (MV_PAR09 == 2),"N","SN" ) )
Local cDupli 	:= If( (MV_PAR08 == 1),"S",If( (MV_PAR08 == 2),"N","SN" ) )
Local aCampos 	:= {}
Local aTam	 	:= {}
Local nAg1		:= 0,nAg2:=0,nAg3:=0
Local nMoeda	:= ""
Local cMoeda	:= "" 
Local nContador,nTOTAL,nVALICM,nVALIPI,QtdVend,NMEDIA
Local nVendedor	:= Fa440CntVen()
Local cVendedor	:= ""
Local aVend    	:= {}
Local aImpostos	:= {}
Local nImpos	:= 0.00
Local lContinua	:= .F.
Local nMoedNF	:=	1
Local nTaxa		:=	0
Local cAddField	:=	""
Local cName     :=  ""
Local nCampo	:=	0
Local cCampo	:=	""
Local cSD2Old	:=	""
Local cSD1Old	:=	""
Local aStru		:=	{}
Local nY        := 	0
Local lFiltro   := .T.
Local lMR580FIL := ExistBlock("MR580FIL")
Local dtMoedaDev:= CtoD("")
Local nRank	 	:= 0
Local cVend    	:= ""
Local cNome    	:= ""
Local cFilSA3   := ""
Local nAdic     := 0

#IFDEF TOP
	Local nX := 0
#ENDIF

Private cCampImp
Private aTamVal:= { 16, 2 }
Private nDecs:=msdecimais(mv_par06)

If lMR580FIL
	aFilUsrSF1 := ExecBlock("MR580FIL",.F.,.F.,aReturn[7])
EndIf

//��������������������������������������������������������������Ŀ
//� SetBlock: faz com que as variaveis locais possam ser         �
//� utilizadas em outras funcoes nao precisando declara-las      �
//� como private											  	 �
//����������������������������������������������������������������
oReport:Section(1):Cell("CVEND" ):SetBlock({|| cVend })
oReport:Section(1):Cell("CNOME" ):SetBlock({|| cNome })
oReport:Section(1):Cell("NRANK" ):SetBlock({|| nRank })

//��������������������������������������������������������������Ŀ
//� Altera o Titulo do Relatorio de acordo com Moeda escolhida 	 �
//����������������������������������������������������������������
oReport:SetTitle(oReport:Title() + " " + IIF(mv_par05 == 1,STR0023,STR0024) + " - "  + GetMv("MV_MOEDA"+STR(mv_par06,1)) )		// "Faturamento por Vendedor"###"(Ordem Decrescente por Vendedor)"###"(Por Ranking)"

//��������������������������������������������������������������Ŀ
//� Cria array para gerar arquivo de trabalho                    �
//����������������������������������������������������������������
aTam:=TamSX3("F2_VEND1")
AADD(aCampos,{ "TB_VEND"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_EMISSAO")
AADD(aCampos,{ "TB_EMISSAO","D",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR1 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR2 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR3 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR4 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR5 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_DOC")
AADD(aCampos,{ "TB_DOC    ","C",aTam[1],aTam[2] } )
//��������������������������������������������������������������Ŀ
//� Cria arquivo de trabalho                                     �
//����������������������������������������������������������������
cNomArq 	:= CriaTrab(aCampos,.T.)
//Alterado - Sidney Oliveira - 11/05/2012
If Select("TRB") > 0
dbSelectArea("TRB")
dbCloseArea()
Endif
dbUseArea( .T.,, cNomArq,"TRB", .T. , .F. )
cNomArq1 := Subs(cNomArq,1,7)+"A"
IndRegua("TRB",cNomArq1,"TB_VEND",,,STR0011)		//"Selecionando Registros..."
aTamVal 	:= TamSX3("F2_VALFAT")
cNomArq2 := Subs(cNomArq,1,7)+"B"
IndRegua("TRB",cNomArq2,"(STRZERO(TB_VALOR3,aTamVal[1],aTamVal[2]))",,,STR0011)		//"Selecionando Registros..."
dbClearIndex()
dbSetIndex(cNomArq1+OrdBagExt())
dbSetIndex(cNomArq2+OrdBagExt())

//������������������������������������������������������������������������Ŀ
//� Geracao do Arquivo para Impressao                                      �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//� Transforma parametros Range em expressao SQL                           �
//��������������������������������������������������������������������������
MakeSqlExpr(oReport:uParam)
//������������������������������������������������������������������������Ŀ
//� Filtragem do relat�rio                                                 �
//��������������������������������������������������������������������������
#IFDEF TOP

	//������������������������������������������������������������������������Ŀ
	//� Abre tabelas e indices a serem utilizados                              �
	//��������������������������������������������������������������������������
	dbSelectArea("SD2")			// Itens de Venda da NF
	dbSetOrder(5)				// Filial,Emissao,NumSeq
	dbSelectArea("SD1")			// Itens da Nota de Entrada
	dbSetOrder(6)				// Filial,Data de Digitacao,NumSeq

	cAliasSD2	:=	GetNextAlias()
	cWhereAux 	:= ""
	cVendedor 	:= "1"
	cAddField   := "%"
	For nCampo 	:= 1 To nVendedor
		cCampo	:= "F2_VEND"+cVendedor
		If SF2->(FieldPos(cCampo)) > 0
			cWhereAux += "(" + cCampo + " between '" + mv_par03 + "' and '" + mv_par04 + "') or "
			cAddField += ", " + cCampo
		EndIf
		cVendedor := Soma1(cVendedor,1)
	Next nCampo
	cAddField += "%"	
	If Empty(cWhereAux)
		cWhere += "% NOT ("+IsRemito(2,"D2_TIPODOC")+")%"
	Else
		cWhereAux := Left(cWhereAux,Len(cWhereAux)-4)
		cWhere := "%(" + cWhereAux + " ) AND NOT ("+IsRemito(2,"D2_TIPODOC")+")%"	
	EndIf

	oReport:Section(2):BeginQuery()
	BeginSql Alias cAliasSD2
	SELECT  SD2.*, F2_EMISSAO, F2_TIPO, F2_DOC, F2_FRETE, F2_SEGURO, F2_DESPESA, F2_FRETAUT, F2_ICMSRET,
			F2_TXMOEDA, F2_MOEDA %Exp:cAddField%
	FROM %Table:SD2% SD2, %Table:SF4% SF4, %Table:SF2% SF2
	WHERE D2_FILIAL  = %xFilial:SD2%
		AND D2_EMISSAO between %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)%
		AND D2_TIPO NOT IN ('D', 'B')
		AND F2_FILIAL  = %xFilial:SF2%
		AND D2_DOC     = F2_DOC
		AND D2_SERIE   = F2_SERIE
		AND D2_CLIENTE = F2_CLIENTE
		AND D2_LOJA    = F2_LOJA
		AND F4_FILIAL  = %xFilial:SF4%
		AND F4_CODIGO  = D2_TES
		AND SD2.%notdel%
		AND SF2.%notdel%
		AND SF4.%notdel%
		AND %Exp:cWhere%
	ORDER BY D2_FILIAL,D2_EMISSAO,D2_DOC,D2_NUMSEQ
	EndSql
	oReport:Section(2):EndQuery()
	
	oReport:SetMeter( (cAliasSD2)->(LastRec() ))
	//������������������������������������������������������������������������Ŀ
	//�Processa Faturamento                                                    �
	//��������������������������������������������������������������������������
	While !Eof()
	
	    oReport:IncMeter()
		nTOTAL  :=0
		nVALICM :=0
		nVALIPI :=0
		nQtdVend:= 0
		NMEDIA	:= 0

		nTaxa	:=	IIf((cAliasSD2)->(FieldPos("F2_TXMOEDA"))>0,(cAliasSD2)->F2_TXMOEDA,0)		
		nMoedNF	:=	IIf((cAliasSD2)->(FieldPos("F2_MOEDA"))>0,(cAliasSD2)->F2_MOEDA,0)
		cVend 	:= (cAliasSD2)->F2_VEND1

		If AvalTes((cAliasSD2)->D2_TES,cEstoq,cDupli)
			If cPaisLoc	==	"BRA"
				nVALICM += xMoeda((cAliasSD2)->D2_VALICM,1,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
				nVALIPI += xMoeda((cAliasSD2)->D2_VALIPI,1,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
			Endif
			nTotal	+=	xMoeda((cAliasSD2)->D2_TOTAL,nMoedNF,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1,nTaxa)
			nQtdVend+= (cAliasSD2)->D2_QUANT
		
			If ( nTotal <> 0 )
				cVendedor := "1"
				For nContador := 1 To nVendedor
					dbSelectArea("TRB")
					dbSetOrder(1)
					cVend := (cAliasSD2)->(FieldGet(FieldPos("F2_VEND"+cVendedor)))
					cVendedor := Soma1(cVendedor,1)
					If cVend >= mv_par03 .And. cVend <= mv_par04
						//�����������������������������������������������������Ŀ
						//�Se vendedor em branco, considera apenas 1 vez        �
						//�������������������������������������������������������
						If Empty(cVend) .and. nContador > 1
							Loop
						Endif
						
						If ( aScan(aVend,cVend)==0 )
							Aadd(aVend,cVend)
						EndIf
						If (dbSeek( cVend ))
							RecLock("TRB",.F.)
						Else
							RecLock("TRB",.T.)
						EndIF
						Replace TB_VEND    With cVend
						Replace TB_EMISSAO With (cAliasSD2)->F2_EMISSAO
						Replace TB_VALOR2  With TB_VALOR2+IIF((cAliasSD2)->F2_TIPO == "P",0,nTOTAL)
						If ( cPaisLoc=="BRA" )
							Replace TB_VALOR1  With TB_VALOR1+(nTOTAL-nVALICM)
							Replace TB_VALOR3  With TB_VALOR3+IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)+nVALIPI
							Replace TB_VALOR4  With TB_VALOR4+nQtdVend
							Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
						Else
							Replace TB_VALOR1  With TB_VALOR1+nTOTAL
							Replace TB_VALOR3  With TB_VALOR3+IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)
							Replace TB_VALOR4  With TB_VALOR4+nQtdVend
							Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
							//��������������������������������������������������������������Ŀ
							//� Pesquiso pelas caracteristicas de cada imposto               �
							//����������������������������������������������������������������
							aImpostos:=TesImpInf((cAliasSD2)->D2_TES)
							For nY:=1 to Len(aImpostos)
								cCampImp:=(cAliasSD2)+"->"+(aImpostos[nY][2])
								nImpos	:=	xMoeda(&cCampImp.,nMoedNF,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1,nTaxa)
								If ( aImpostos[nY][3]=="1" )
									Replace TB_VALOR3  With TB_VALOR3 + nImpos
									Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
								ElseIf ( aImpostos[nY][3]=="2" )
									Replace TB_VALOR1  With TB_VALOR1 - nImpos
								EndIf
							Next
						EndIf
						Replace TB_DOC	    With (cAliasSD2)->F2_DOC
						MsUnlock()
					Endif
				Next nContador
			EndIf
		EndIf

		dbSelectArea(cAliasSD2)
		cSD2Old	:= (cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA		
		
		// Considera Adicionais
		nAdic := 0
		If mv_par11 == 2
			nAdic := xMoeda((cAliasSD2)->F2_FRETE+(cAliasSD2)->F2_SEGURO+(cAliasSD2)->F2_DESPESA,nMoedNF,mv_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)		
		EndIf	
		nValor3  := xMoeda((cAliasSD2)->F2_FRETAUT+(cAliasSD2)->F2_ICMSRET,nMoedNF,mv_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)		

		cVend 	:= (cAliasSD2)->F2_VEND1
		
		dbSkip()
		If Eof() .Or. ( (cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA!= cSD2Old )
//			For nContador := 1 To Len(aVend)
				dbSelectArea("TRB")
				dbSetOrder(1)
				If dbSeek(cVend)
					RecLock("TRB",.F.)
					TRB->TB_VALOR3	+= nValor3+nAdic
					TB_VALOR5  		:= TB_VALOR3/TB_VALOR4
					MsUnLock()
				Elseif nValor3+nAdic > 0
					RecLock("TRB",.T.)
					Replace TB_VEND    With cVend
					Replace TB_EMISSAO With (cAliasSD2)->F2_EMISSAO
					TRB->TB_VALOR3	+= nValor3+nAdic
					TB_VALOR5  		:= TB_VALOR3/TB_VALOR4
					MsUnLock()
				EndIf
//			Next nContador
			aVend := {}
		EndIf
		dbSelectArea(cAliasSD2)
	EndDo
	dbCloseArea()
	
	//������������������������������������������������������������������������Ŀ
	//�Processa Devolucao                                                      �
	//��������������������������������������������������������������������������
	If ( MV_PAR07 == 1 )

		cAliasSD1:= GetNextAlias()
		
		cWhereAux 	:= ""
		cVendedor 	:= "1"

		cWhere += "%"
		cAddField := "%"
		If cPaisLoc == "BRA"
			For nCampo := 1 To nVendedor
				cCampo := "F2_VEND"+cVendedor
				If SF2->(FieldPos(cCampo)) > 0
					cWhereAux += "(" + cCampo + " between '" + mv_par03 + "' and '" + mv_par04 + "') or "
					cAddField += ", "  + cCampo
				EndIf
				cVendedor := Soma1(cVendedor,1)
			Next nCampo
		Else
			For nCampo := 1 To 35
				cCampo := "F1_VEND"+cVendedor
				If SF1->(FieldPos(cCampo)) > 0
					cWhereAux += "(" + cCampo + " between '" + mv_par03 + "' and '" + mv_par04 + "') or "
					cAddField += ", "  + cCampo
				EndIf
				cVendedor := Soma1(cVendedor,1)
			Next nCampo
		EndIf
		
		If Empty(cWhereAux)
			cWhere += "% NOT ("+IsRemito(2,"D1_TIPODOC")+")%"
		Else
			cWhereAux := Left(cWhereAux,Len(cWhereAux)-4)
			cWhere := "%(" + cWhereAux + " ) AND NOT ("+IsRemito(2,"D1_TIPODOC")+")%"	
		EndIf

		
		If SF1->(FieldPos("F1_FRETINC")) > 0
			cAddField += ", F1_FRETINC"
		EndIf
	    //���������������������������������������������������������������������������Ŀ
	    //�Esta Rotina adiciona a cQuery os campos retornados na string de filtro do  |
	    //�ponto de entrada MR580FIL.                                                 |
	    //�����������������������������������������������������������������������������	   	
		If lMR580FIL
			aStru := SF1->(dbStruct())	
		    If !Empty(aFilUsrSF1[1])
		       For nX := 1 To SF1->(FCount())
		           cName := SF1->(FieldName(nX))
		           If AllTrim( cName ) $ aFilUsrSF1[1]
			           If aStru[nX,2] <> "M"  
			      		  If !cName $ cAddField
				        	cAddField += ","+cName
				          Endif 	
				       EndIf
		           EndIf 			       	
		       Next nX
		    Endif         
		EndIf
		cAddField += "%"

		oReport:Section(3):BeginQuery()
		BeginSql Alias cAliasSD1
		
		SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET,
			 F1_DTDIGIT, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F1_TXMOEDA, F1_MOEDA %Exp:cAddField%
		FROM %Table:SD1% SD1, %Table:SF4% SF4, %Table:SF2% SF2, %Table:SF1% SF1
		WHERE D1_FILIAL  = %xFilial:SD1%
			AND D1_DTDIGIT between %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)%
			AND D1_TIPO = 'D'
			AND F4_FILIAL  = %xFilial:SF4%
			AND F4_CODIGO  = D1_TES
			AND F2_FILIAL  = %xFilial:SF2%
			AND F2_DOC     = D1_NFORI 
			AND F2_SERIE   = D1_SERIORI
			AND F2_LOJA    = D1_LOJA
			AND F1_FILIAL  = %xFilial:SF1%
			AND F1_DOC     = D1_DOC 
			AND F1_SERIE   = D1_SERIE
			AND F1_FORNECE = D1_FORNECE
			AND F1_LOJA    = D1_LOJA
			AND SD1.%notdel%
			AND SF4.%notdel%
			AND SF2.%notdel%
			AND SF1.%notdel%
			AND %Exp:cWhere%			
  		 ORDER BY D1_FILIAL,D1_FORNECE,D1_LOJA,D1_DTDIGIT,D1_DOC,D1_SERIE,D1_NUMSEQ
		 EndSql
		 oReport:Section(3):EndQuery()
		
	
		While !Eof()
			oReport:IncMeter()
			nTOTAL :=0
			nVALICM:=0
			nVALIPI:=0
			nQtdVend:= 0
			nmedia	:= 0
			cVend := (cAliasSD1)->F2_VEND1


			//������������������������������������������������������������������������Ŀ
			//�Se a origem for loja, ignora o filtro e mostra o registro               �
			//��������������������������������������������������������������������������
			If (cAliasSD1)->D1_ORIGLAN <> "LO"
				If (cAliasSD1)->F2_CLIENTE <> (cAliasSD1)->D1_FORNECE .And. (cAliasSD1)->F2_LOJA <> (cAliasSD1)->D1_LOJA
					(cAliasSD1)->(DbSkip())
					Loop
				EndIf
			EndIf

			//������������������������������������������������������������������������Ŀ
			//�Processa o ponto de entrada com o filtro do usuario para devolucoes.    �
			//��������������������������������������������������������������������������
			If lMR580FIL
     			lFiltro := .T.
				dbSelectArea("SF1")
				dbSetOrder(1)
				MsSeek(xFilial("SF1")+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA)
				If !Empty(aFilUsrSF1[1]).And.!&(aFilUsrSF1[1]) 
					dbSelectArea(cAliasSD1)
                    lFiltro := .F.
				Endif    
            EndIf

            If lFiltro             			
				If MV_PAR10 == 1 .Or. Empty((cAliasSD1)->F2_EMISSAO)           
					DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
				Else
					DtMoedaDev  := (cAliasSD1)->F2_EMISSAO
				EndIf  
            
				If cPaisLoc == "BRA"
					If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)
	
						nVALICM := xMoeda((cAliasSD1)->D1_VALICM,1,mv_par06,DtMoedaDev,nDecs+1)
						nVALIPI := xMoeda((cAliasSD1)->D1_VALIPI,1,mv_par06,DtMoedaDev ,nDecs+1)
						nTOTAL  := xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),1,mv_par06,DtMoedaDev,nDecs+1)
						nQtdVend:= (cAliasSD1)->D1_QUANT

						cVendedor := "1"
//						For nContador := 1 TO nVendedor
							dbSelectArea("TRB")
							dbSetOrder(1)
							cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F2_VEND"+cVendedor))))
							cVendedor := Soma1(cVendedor,1)
							If cVend >= MV_PAR03 .And. cVend <= MV_PAR04
								If Empty(cVend) .and. nContador > 1
									Loop
								EndIf
								If ( aScan(aVend,cVend) == 0 )
									AADD(aVend,cVend)
								EndIf
								If nTOTAL > 0
									If (dbSeek( cVend ))
										RecLock("TRB",.F.)
									Else
										RecLock("TRB",.T.)
									EndIf
									Replace TB_VEND    With cVend
									Replace TB_EMISSAO With (cAliasSD1)->F1_EMISSAO
									Replace TB_VALOR2  With TB_VALOR2-nTOTAL
									Replace TB_VALOR1  With TB_VALOR1-(nTOTAL-nVALICM)
									Replace TB_VALOR3  With TB_VALOR3-nTOTAL-nVALIPI
									Replace TB_VALOR4  With TB_VALOR4-nQtdvend
									Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
									Replace TB_DOC	    With (cAliasSD1)->F1_DOC
									MsUnlock()
								EndIf
							Endif
//						Next nContador
					EndIf
				Else
					If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)
						nTaxa	:=	IIf((cAliasSD1)->(FieldPos("F1_TXMOEDA"))>0,(cAliasSD1)->F1_TXMOEDA,0)
						nMoedNF	:=	IIF((cAliasSD1)->(FieldPos("F1_MOEDA"))>0,(cAliasSD1)->F1_MOEDA,1)
	 					nTOTAL	:= xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),nMoedNF,mv_par06,DtMoedaDev,nDecs+1,nTaxa)
						nQtdVend:= (cAliasSD1)->D1_QUANT
						cVendedor := "1"
						For nContador := 1 TO 1
							dbSelectArea("TRB")
							dbSetOrder(1)
							cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F1_VEND"+cVendedor))))
							cVendedor := Soma1(cVendedor,1)
							If cVend >= MV_PAR03 .And. cVend <= MV_PAR04
								If Empty(cVend) .and. nContador > 1
									Loop
								EndIf
								If ( aScan(aVend,cVend) == 0 )
									AADD(aVend,cVend)
								EndIf
								If nTOTAL > 0
									If (dbSeek( cVend ))
										RecLock("TRB",.F.)
									Else
										RecLock("TRB",.T.)
									EndIf
									Replace TB_VEND    With cVend
									Replace TB_EMISSAO With (cAliasSD1)->F1_EMISSAO
									Replace TB_VALOR2  With TB_VALOR2-nTOTAL
									Replace TB_VALOR1  With TB_VALOR1-nTOTAL
									Replace TB_VALOR3  With TB_VALOR3-nTotal
									Replace TB_VALOR4  With TB_VALOR4-nQtdvend
									Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
									//��������������������������������������������������������������Ŀ
									//� Pesquiso pelas caracteristicas de cada imposto               �
									//����������������������������������������������������������������
									aImpostos:=TesImpInf((cAliasSD1)->D1_TES)
									For nY:=1 to Len(aImpostos)
										cCampImp:= (cAliasSD1)+"->"+(aImpostos[nY][2])
										nImpos	:=	xMoeda(&cCampImp.,nMoedNF,mv_par06,DtMoedaDev,nDecs+1,nTaxa)
										If ( aImpostos[nY][3]=="1" )
 											Replace TB_VALOR3  With TB_VALOR3 - nImpos
											Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
										ElseIf ( aImpostos[nY][3]=="2" )
											Replace TB_VALOR1  With TB_VALOR1 + nImpos
										EndIf
									Next nY
									Replace TB_DOC	    With (cAliasSD1)->F1_DOC
								Endif							
								MsUnlock()
							EndIf
						Next nContador
					Endif
				Endif
				dbSelectArea(cAliasSD1)
				cSD1Old := (cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA
				If ( cPaisLoc=="BRA")
					// Considera Adicionais
//					If mv_par11 == 2
//						nAdic := xMoeda((cAliasSD1)->F1_FRETE+(cAliasSD1)->F1_DESPESA+(cAliasSD1)->F1_SEGURO,1,mv_par06,DtMoedaDev,nDecs+1)
//					EndIf	
					nValor3	:= xMoeda((cAliasSD1)->F1_ICMSRET,1,mv_par06,DtMoedaDev,nDecs+1)
				Else
					nValor3	:= xMoeda(IIf((cAliasSD1)->(FieldPos("F1_FRETINC"))>0.And.(cAliasSD1)->F1_FRETINC<> "S",;
							(cAliasSD1)->F1_FRETE,0);
							+(cAliasSD1)->F1_DESPESA,nMoedNF,mv_par06,DtMoedaDev,nDecs+1,nTaxa)
				EndIf                  
			EndIf
			
			dbSelectArea(cAliasSD1)
			dbSkip()
			
			If lFiltro				
				If Eof() .Or. ( (cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA != cSD1Old)
					FOR nContador := 1 TO 1
						dbSelectArea("TRB")
						dbSetOrder(1)
//						cVend := aVend[nContador]
						If dbSeek( cVend )
							RecLock("TRB",.F.)
							Replace TB_VALOR3  With TB_VALOR3-nValor3
							Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
							nValor3	:= 0
							MsUnlock()
						Elseif nValor3 > 0
							RecLock("TRB",.T.)
							Replace TB_VEND    With cVend
							Replace TB_VALOR3  With TB_VALOR3-nValor3
							Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
							nValor3	:= 0										
							MsUnlock()
						EndIf
					Next nContador
					aVend:={}
				EndIf				
			EndIf			
			dbSelectArea(cAliasSD1)
		EndDo
		dbCloseArea()
	EndIf
	
#ELSE

/*	dbSelectArea("SD2")
	dbSetOrder(5)
	dbSeek(xFilial("SD2")+Dtos(MV_PAR01),.T.)
	oReport:SetMeter(SD2->(LastRec())+SD1->(LastRec()))
	
	//������������������������������������������������������������������������Ŀ
	//�Processa Faturamento                                                    �
	//��������������������������������������������������������������������������
	While ( !Eof() .And. xFilial("SD2")  == SD2->D2_FILIAL .And.;
		SD2->D2_EMISSAO <= MV_PAR02 )
		
		oReport:IncMeter()
		
		nTOTAL :=0
		nVALICM:=0
		nVALIPI:=0
		nQtdvend:= 0
		nmedia:=0

		
		If IsRemito(1,'SD2->D2_TIPODOC')
			dBSkip()
			Loop
		Endif	
		
		If ( !SD2->D2_TIPO $ "DB" )
			dbSelectArea("SF2")
			dbSetOrder(1)
			lContinua := dbSeek(xFilial("SF2")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA)
			
			dbSelectArea("SF4")
			dbSetOrder(1)
			dbSeek(xFilial("SF2")+SD2->D2_TES)
			nTaxa		:=	IIf(Type("SF2->F2_TXMOEDA")=="U",0,SF2->F2_TXMOEDA)
			nMoedNF	:=	IIF(Type("SF2->F2_MOEDA")  =="U",1,SF2->F2_MOEDA)
			dbSelectArea("SD2")
			If lContinua .And. AvalTes(D2_TES,cEstoq,cDupli)
				
				If cPaisLoc	==	"BRA"
				   nVALICM += xMoeda(SD2->D2_VALICM,1,mv_par06,SD2->D2_EMISSAO,nDecs+1)
				   nVALIPI += xMoeda(SD2->D2_VALIPI,1,mv_par06,SD2->D2_EMISSAO,nDecs+1)
				Endif
				nTotal	+=	xMoeda(SD2->D2_TOTAL,nMoedNF,mv_par06,SD2->D2_EMISSAO,nDecs+1,nTaxa)
				nQtdvend+= SD2->D2_QUANT

			
				If ( nTotal <> 0 )
					cVendedor := "1"
					For nContador := 1 To nVendedor
						dbSelectArea("TRB")
						dbSetOrder(1)
						cVend := SF2->(FieldGet( FieldPos("F2_VEND"+cVendedor)))
						cVendedor := Soma1(cVendedor,1)
						If cVend >= mv_par03 .And. cVend <= mv_par04
							//�����������������������������������������������������Ŀ
							//�Se vendedor em branco, considera apenas 1 vez        �
							//�������������������������������������������������������
							If Empty(cVend) .and. nContador > 1
								Loop
							Endif
							
							If ( aScan(aVend,cVend)==0 )
								Aadd(aVend,cVend)
							EndIf
							If (dbSeek( cVend ))
								RecLock("TRB",.F.)
							Else
								RecLock("TRB",.T.)
							EndIF
							Replace TB_VEND    With cVend
							Replace TB_EMISSAO With SF2->F2_EMISSAO
							Replace TB_VALOR2  With TB_VALOR2+IIF(SF2->F2_TIPO == "P",0,nTOTAL)
							If ( cPaisLoc=="BRA" )
								Replace TB_VALOR1  With TB_VALOR1+(nTOTAL-nVALICM)
								Replace TB_VALOR3  With TB_VALOR3+IIF(SF2->F2_TIPO == "P",0,nTotal)+nVALIPI
								Replace TB_VALOR4  With TB_VALOR4+NQTDVEND
								Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
							Else
								Replace TB_VALOR1  With TB_VALOR1+nTOTAL
								Replace TB_VALOR3  With TB_VALOR3+IIF(SF2->F2_TIPO == "P",0,nTotal)
								Replace TB_VALOR4  With TB_VALOR4+NQTDVEND
								Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
								//��������������������������������������������������������������Ŀ
								//� Pesquiso pelas caracteristicas de cada imposto               �
								//����������������������������������������������������������������
								aImpostos:=TesImpInf(SD2->D2_TES)
								For nY:=1 to Len(aImpostos)
									cCampImp:="SD2->"+(aImpostos[nY][2])
									nImpos	:=	xMoeda(&cCampImp.,nMoedNF,mv_par06,SD2->D2_EMISSAO,nDecs+1,nTaxa)
									If ( aImpostos[nY][3]=="1" )
										Replace TB_VALOR3  With TB_VALOR3 + nImpos
										Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
									ElseIf ( aImpostos[nY][3]=="2" )
										Replace TB_VALOR1  With TB_VALOR1 - nImpos
									EndIf
								Next
							EndIf
							Replace TB_DOC	    With SF2->F2_DOC
							MsUnlock()
						Endif
					Next nContador
				EndIf
			EndIf
		EndIf
		dbSelectArea("SD2")
		dbSkip()
		If lContinua .And. ( xFilial("SF2")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA!=;
			SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA )
			For nContador := 1 To Len(aVend)
				dbSelectArea("TRB")
				dbSetOrder(1)
				dbSeek(aVend[nContador])
				RecLock("TRB",.F.)
				
				// Considera Adicionais
				If mv_par11 == 2
					TRB->TB_VALOR3 += xMoeda(SF2->F2_FRETE+SF2->F2_SEGURO+SF2->F2_DESPESA+SF2->F2_FRETAUT+SF2->F2_ICMSRET,nMoedNF,mv_par06,SF2->F2_EMISSAO,nDecs+1,nTaxa)
					TRB->TB_VALOR5  := TRB->(TB_VALOR3/TB_VALOR4)
				Else	// Desconsidera Adiconais
					TRB->TB_VALOR3 += xMoeda(SF2->F2_FRETAUT+SF2->F2_ICMSRET,nMoedNF,mv_par06,SF2->F2_EMISSAO,nDecs+1,nTaxa)					
					TRB->TB_VALOR5  := TRB->(TB_VALOR3/TB_VALOR4)
				EndIf
				
				MsUnLock()
			Next nContador
			aVend := {}
		EndIf
		dbSelectArea("SD2")
	EndDo
	//������������������������������������������������������������������������Ŀ
	//�Processa Devolucao                                                      �
	//��������������������������������������������������������������������������
	If ( MV_PAR07 == 1 )
		dbSelectArea("SD1")
		dbSetOrder(6)
		dbSeek(xFilial("SD1")+Dtos(MV_PAR01),.T.)
		While ( !Eof() .And. xFilial("SD1")  == SD1->D1_FILIAL .And.;
			SD1->D1_DTDIGIT <= MV_PAR02 )
			oReport:IncMeter()
			nTOTAL :=0
			nVALICM:=0
			nVALIPI:=0
			NQTDVEND:= 0
	
			If IsRemito(1,'SD1->D1_TIPODOC')
				dBSkip()
				Loop
			Endif			
			
			dbSelectArea("SF4")
			dbSetOrder(1)
			dbSeek(xFilial("SF4")+SD1->D1_TES)

			//������������������������������������������������������������������������Ŀ
			//�Processa o ponto de entrada com o filtro do usuario para devolucoes.    �
			//��������������������������������������������������������������������������
			If lMR580FIL
				lFiltro := .T. 
				dbSelectArea("SF1")
				dbSetOrder(1)
				MsSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)
				If !Empty(aFilUsrSF1[1]).And.!&(aFilUsrSF1[1]) 
					dbSelectArea("SD1")
                    lFiltro := .F.
				Endif    
            EndIf
            
            If lFiltro             		
				If cPaisLoc == "BRA"
					dbSelectArea("SD1")
					If AvalTes(D1_TES,cEstoq,cDupli)
						If ( SD1->D1_TIPO $ "D" )
							dbSelectArea("SF1")
							dbSetOrder(1)
							dbSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)
	
							cVendedor := "1"
							dbSelectArea("SF2")
							dbSetOrder(1)
							If ( dbSeek(xFilial()+SD1->D1_NFORI+SD1->D1_SERIORI) )
	                            
	                            DtMoedaDev := IIF(MV_PAR10 == 1,SD1->D1_DTDIGIT,SF2->F2_EMISSAO)
							    nVALICM    := xMoeda(SD1->D1_VALICM,1,mv_par06,DtMoedaDev,nDecs+1)
							    nVALIPI    := xMoeda(SD1->D1_VALIPI,1,mv_par06,DtMoedaDev,nDecs+1)
							    nTOTAL     := xMoeda((SD1->D1_TOTAL - SD1->D1_VALDESC),1,mv_par06,DtMoedaDev,nDecs+1)
								NQTDVEND   := SD1->D1_QUANT
	
								For nContador := 1 TO nVendedor
									dbSelectArea("TRB")
									dbSetOrder(1)
									cVend := SF2->(FieldGet(FieldPos("F2_VEND"+cVendedor)))
									cVendedor := Soma1(cVendedor,1)
									If cVend >= MV_PAR03 .And. cVend <= MV_PAR04
										If Empty(cVend) .and. nContador > 1
											Loop
										EndIf
										If ( aScan(aVend,cVend) == 0 )
											AADD(aVend,cVend)
										EndIf
										If nTOTAL > 0
											If (dbSeek( cVend ))
												RecLock("TRB",.F.)
											Else
												RecLock("TRB",.T.)
											EndIf
											Replace TB_VEND    With cVend
											Replace TB_EMISSAO With SF1->F1_EMISSAO
											Replace TB_VALOR2  With TB_VALOR2-nTOTAL
											Replace TB_VALOR1  With TB_VALOR1-(nTOTAL-nVALICM)
											Replace TB_VALOR3  With TB_VALOR3-nTOTAL-nVALIPI
											Replace TB_VALOR4  With TB_VALOR4-NQTDVEND
											Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4

											Replace TB_DOC	    With SF1->F1_DOC
											MsUnlock()
										EndIf
									Endif
								Next nContador
							EndIf
						EndIf
					EndIf
				Else
					If AvalTes(SD1->D1_TES,cEstoq,cDupli)
						If ( SD1->D1_TIPO $ "D" )
							dbSelectArea("SF1")
							dbSetOrder(1)
							dbSeek(xFilial("SF1")+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)
							nTaxa		:=	IIf(Type("SF1->F1_TXMOEDA")=="U",0,SF1->F1_TXMOEDA)
							nMoedNF	:=	IIF(Type("SF1->F1_MOEDA")  =="U",1,SF1->F1_MOEDA)
	
							If MV_PAR10 == 2
				               //���������������������������������������������������������������������������������������������������������Ŀ
				               //�Verifica se existe a N.F original de Saida , se existir usa a data de emissao da NF de saida             �
				               //�conforme o parametro MV_PAR10 se n�o encontrar usa o campo F1_DTDIGIT para converter a moeda da devolucao�
				               //�����������������������������������������������������������������������������������������������������������
					           dbSelectArea("SF2")
					           dbSetOrder(1)
					           If MsSeek(xFilial()+SD1->D1_NFORI+SD1->D1_SERIORI+SD1->D1_FORNECE+SD1->D1_LOJA)
				                  DtMoedaDev  := SF2->F2_EMISSAO
				               Else
				                  DtMoedaDev  := SF1->F1_DTDIGIT
				               EndIf
				            Else    
				               DtMoedaDev  := SF1->F1_DTDIGIT            
				            EndIf
				                  
						    dbSelectArea("SD1")
							
							nTOTAL  := xMoeda((SD1->D1_TOTAL - SD1->D1_VALDESC),nMoedNF,mv_par06,DtMoedaDev,nDecs+1,nTaxa)    
							NQTDVEND:= SD1->D1_QUANT

							cVendedor := "1"
							For nContador := 1 TO 1
								dbSelectArea("TRB")
								dbSetOrder(1)
								cVend := SF1->(FieldGet(FieldPos("F1_VEND"+cVendedor)))
								cVendedor := Soma1(cVendedor,1)
								If cVend >= MV_PAR03 .And. cVend <= MV_PAR04
									If Empty(cVend) .and. nContador > 1
										Loop
									EndIf
									If ( aScan(aVend,cVend) == 0 )
										AADD(aVend,cVend)
									EndIf
									If nTOTAL > 0
										If (dbSeek( cVend ))
											RecLock("TRB",.F.)
										Else
											RecLock("TRB",.T.)
										EndIf
										Replace TB_VEND    With cVend
										Replace TB_EMISSAO With SF1->F1_EMISSAO
										Replace TB_VALOR2  With TB_VALOR2-nTOTAL
										Replace TB_VALOR1  With TB_VALOR1-nTOTAL
										Replace TB_VALOR3  With TB_VALOR3-nTotal
										Replace TB_VALOR4  With TB_VALOR4-NQTDVEND
										Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
										
										//��������������������������������������������������������������Ŀ
										//� Pesquiso pelas caracteristicas de cada imposto               �
										//����������������������������������������������������������������
										aImpostos:=TesImpInf(SD1->D1_TES)
										For nY:=1 to Len(aImpostos)
											cCampImp:="SD1->"+(aImpostos[nY][2])
											nImpos	:=	xMoeda(&cCampImp.,nMoedNF,mv_par06,DtMoedaDev,nDecs+1,nTaxa)
											If ( aImpostos[nY][3]=="1" )
												Replace TB_VALOR3  With TB_VALOR3 - nImpos
												Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
											ElseIf ( aImpostos[nY][3]=="2" )
												Replace TB_VALOR1  With TB_VALOR1 + nImpos
											EndIf
										Next nY
										Replace TB_DOC	    With SF1->F1_DOC
									Endif							
									MsUnlock()
								EndIf
							Next nContador
						EndIf
					Endif
				Endif			
            EndIf  

			dbSelectArea("SD1")
			dbSkip() 
			
	        If lFiltro 			
				If ( SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA !=;
					xFilial("SF1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA )
					FOR nContador := 1 TO Len(aVend)
						dbSelectArea("TRB")
						dbSetOrder(1)
						cVend := aVend[nContador]
						dbSeek( cVend )
						RecLock("TRB",.F.)
						If ( cPaisLoc=="BRA")
							// Considera Adicionais 
							If mv_par11 == 2
								Replace TB_VALOR3  With TB_VALOR3-xMoeda(SF1->F1_FRETE+SF1->F1_DESPESA+SF1->F1_SEGURO+SF1->F1_ICMSRET,1,mv_par06,DtMoedaDev,nDecs+1)
								Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
							Else // Desconsidera Adiconais
								Replace TB_VALOR3  With TB_VALOR3-xMoeda(SF1->F1_ICMSRET,1,mv_par06,DtMoedaDev,nDecs+1)
								Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4
							EndIf
							Replace TB_VALOR4  With TB_VALOR4-NQTDVEND
						Else
							Replace TB_VALOR3  With TB_VALOR3-xMoeda(IIf(Type("SF1->F1_FRETINC")#"U".And.SF1->F1_FRETINC<> "S",;
							Replace TB_VALOR4  With TB_VALOR4-NQTDVEND
							Replace TB_VALOR5  With TB_VALOR3/TB_VALOR4

							SF1->F1_FRETE,0);
							+SF1->F1_DESPESA,nMoedNF,mv_par06,DtMoedaDev,nDecs+1,nTaxa)
						EndIf
						MsUnlock()
					Next nContador
					aVend:={}
				EndIf				
			EndIf			
			dbSelectArea("SD1")
		EndDo
	EndIf*/
#ENDIF

//������������������������������������������������������������������������Ŀ
//� Impressao do Relatorio                                                 �
//��������������������������������������������������������������������������
dbSelectArea("TRB")

If ( MV_PAR05 = 2 )
	dbSetOrder(2)
Else
	dbSetOrder(1)
EndIF


If len(oReport:Section(1):GetAdvplExp("SA3")) > 0
	cFilSA3 := oReport:Section(1):GetAdvplExp("SA3")
EndIf

dbGoBottom()
cNFiscal := TRB->TB_DOC
oReport:section(1):Init()
oReport:SetMeter(LastRec())
While !Bof()
	
	oReport:IncMeter()
	cVend := TRB->TB_VEND
	
	//��������������������������������������������������������������Ŀ
	//� Verifica filtro de usuario                                   �
	//����������������������������������������������������������������
	dbSelectArea("SA3")
	dbSeek(xFilial()+cVend)
	If !Empty(cFilSA3) .And. !(&cFilSA3)
			dbSelectArea("TRB")	
			dbSkip(-1)
			Loop
	EndIf	
	
	//��������������������������������������������������������������Ŀ
	//� Verifica se � venda sem vendedor                             �
	//����������������������������������������������������������������
	If !Empty( cVend )
		cNome := SA3->A3_NOME
	Else
		cVend :=  "******"
		cNome :=  STR0025			// "Vendas sem Vendedor"
	EndIf

	dbSelectArea("TRB")	
	
	If mv_par05 == 2
		nRank++
		oReport:Section(1):Cell("NRANK"):Show()
	Else	
		oReport:Section(1):Cell("NRANK"):Hide()
	EndIf
	
	oReport:section(1):PrintLine()
	
	nAg1 := nAg1 + TRB->TB_VALOR1
	nAg2 := nAg2 + TRB->TB_VALOR2
	nAg3 := nAg3 + TRB->TB_VALOR3
	
	cNFiscal := TRB->TB_DOC
	dbSkip(-1)
EndDo

oReport:Section(1):PageBreak()

dbSelectArea( "TRB" )
dbCloseArea()
fErase(cNomArq+GetDBExtension())
fErase(cNomArq1+OrdBagExt())
fErase(cNomArq2+OrdBagExt())

//��������������������������������������������������������������Ŀ
//� Restaura a integridade dos dados                             �
//����������������������������������������������������������������
dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)


Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �AjustaSX1 � Autor �Marco Bianchi          � Data �10/11/2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Acerta o arquivo de perguntas                               ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSx1()
Local aArea := GetArea()
Local aHelpP11	:= {}
Local aHelpE11	:= {}
Local aHelpS11	:= {}

Aadd( aHelpP11, "Desconsidera os valores de frete, seguro" )
Aadd( aHelpP11, "e despesa no valor total.       " )

Aadd( aHelpE11, "Do not consider the freight, insurance  " )
Aadd( aHelpE11, " and expenses value on the total val.   " )

Aadd( aHelpS11, "No considera los valores de flete,seguro" )
Aadd( aHelpS11, " y gastos en el valor total."  )

PutSx1("MTR580","11","Desconsidera Adicionais ?"  ,"No considera Adicionales?    ","Do not consider Additional?","mv_che","N",1,0,2,"C","","","","","mv_par11","Sim"            ,"Si"             ,"Yes"          ,"","Nao"            ,"No"                  ,"No"                         ,"","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
PutSX1Help("P.MTR58011.",aHelpP11,aHelpE11,aHelpS11)

RestArea(aArea)

Return
