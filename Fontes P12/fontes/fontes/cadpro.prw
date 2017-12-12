#include "protheus.ch"
#include "rwmake.ch"
#DEFINE CRLF Chr(13)+Chr(10)
 
User Function CADPRO()
//Local impData 
Local oReport   

ctime	:= time()

ajustasx1()                       

Pergunte("CADPRO    ",.F.)
//execução do relatório
oReport := ReportDef()
oReport:PrintDialog()
//fim do relatório
ctimeend	:= time()

cMensagem := "Tempo de execução: "+ CRLF
cMensagem += "[ Hora inicial ]  "+ctime    + CRLF
cMensagem += "[ Hora Final   ]  "+ctimeend
//+------------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos ]|
//+------------------------------------------------------------------------------+
MsgInfo(cMensagem, "Tempo de execução")

Return

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamada da função      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Static Function ReportDef()
Local 	oReport
Local 	oSection1
Local 	cAliasSB1 	:= "SB1"
Local 	cAliasSB5 	:= "SB5"
Local 	cAliasQRY 	:= "SB1QRY" 
Private	cProduto	:= ""
Private	cTitulo		:= ""
Private	cCeme		:= ""
Private	CPLATRED	:= ""
Private	CPLATEXT	:= ""
Private	cClasind	:= ""
Private	cVsint1 	:= ""
Private	cVsint2 	:= ""
Private	cVsint3 	:= ""
Private	cVsint4 	:= ""
Private	cVsint5 	:= ""
Private	cVsint6 	:= ""
Private	cVsint7 	:= ""
Private	cVsint8 	:= ""
Private	cVsint9 	:= ""
Private	cVreqsis1 	:= ""
Private	cVreqsis2 	:= ""
Private	cVreqsis3 	:= ""
Private	cVreqsis4 	:= ""
Private	cVreqsis5 	:= ""
Private	cGenero1	:= ""
Private	cGenero2	:= ""
Private	cGenero3	:= ""
Private	cGenero4	:= ""
Private	cVBUNDLE1	:= ""
Private	cVBUNDLE2	:= ""
Private	cVBUNDLE3	:= ""
Private	cSINOPSE1 	:= ""
Private	cSINOPSE2 	:= ""
Private	cSINOPSE3 	:= ""
Private	cSINOPSE4 	:= ""
Private	cSINOPSE5 	:= ""
Private	cSINOPSE6 	:= ""
Private	cSINOPSE7 	:= ""
Private	cSINOPSE8 	:= ""
Private	cSINOPSE9 	:= ""
Private	nseqstr		:= ""
Private	cLANC		:= ""  
Private	cOrigem 	:=""
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
Alteração no relatório CADPRO Prog: Janes Raulino Data: 11/06/13
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/////////////////////////////////////////////
Private dCom //Data de alteração
Private dIncl//Data de Inclusão 
Private dCompara
////////////////////////////////////////////   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
Alteração no relatório CADPRO Prog: Janes Raulino Data: 11/06/13
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

oReport := TReport():New("CADPRO","Informações para o site","CADPRO",{|oReport| PrintReport(oReport,cAliasSB1,cAliasSB5,cAliasQRY)},"Relatorio para importação para o site NC Games")
oSection1 := TRSection():New(oReport,"Produtos"		,{"SB1","SB5"})

TRCell():New(oSection1,"B1_COD","SB1")
TRCell():New(oSection1,"B1_CODBAR","SB1")
TRCell():New(oSection1,"B5_TITULO","SB5")
TRCell():New(oSection1,"CPLATRED"	,/*Tabela*/,"SiglaPlataforma"	,PesqPict("SZ5","Z5_PLATRED")	,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||cPlatred				})	// Código Plataforma
TRCell():New(oSection1,"CPLATEXT"	,/*Tabela*/,"Plataforma"		,PesqPict("SZ5","Z5_PLATEXT")	,TamSX3("Z5_PLATEXT")[1],/*lPixel*/,{||cPlatExt				})	// Plataforma Extenso
TRCell():New(oSection1,"B5_PUBLISH","SB5")
TRCell():New(oSection1,"B1_PRV1","SB1")
TRCell():New(oSection1,"B1_CONSUMI","SB1")
TRCell():New(oSection1,"B1_XDESC","SB1")
TRCell():New(oSection1,"B5_DTLAN","SB5")
TRCell():New(oSection1,"B1_ALT","SB1")
TRCell():New(oSection1,"B1_LARGURA","SB1")
TRCell():New(oSection1,"B1_PROF","SB1")
TRCell():New(oSection1,"B1_PESO","SB1")
TRCell():New(oSection1,"B1_POSIPI","SB1")
TRCell():New(oSection1,"B1_IPI","SB1")
TRCell():New(oSection1,"dCom"       ,/*Tabela*/,"Ult. Atual."       ,""                             ,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||dCom		})
TRCell():New(oSection1,"dIncl"      ,/*Tabela*/,"Data. Inclusão"       ,""                          ,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||dIncl		})
TRCell():New(oSection1,"cGenero1"	,/*Tabela*/,"Genero Principal"	,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||UPLOW(cGenero1)		})	// Genero1 do Produto
TRCell():New(oSection1,"cGenero2"	,/*Tabela*/,"Genero 1"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||UPLOW(cGenero2)		})	// Genero2 do Produto
TRCell():New(oSection1,"cGenero3"	,/*Tabela*/,"Genero 2"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||UPLOW(cGenero3)		})	// Genero3 do Produto
TRCell():New(oSection1,"cGenero4"	,/*Tabela*/,"Genero 3"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||UPLOW(cGenero4)		})	// Genero4 do Produto
TRCell():New(oSection1,"CCLASIND"	,/*Tabela*/,"Classificacao"		,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||cClasind				})	// Classificação indicativa
TRCell():New(oSection1,"B5_NUMJOG","SB5")
TRCell():New(oSection1,"B5_SINOPS","SB5")
TRCell():New(oSection1,"cSinopse"	,/*Tabela*/,"Sinopse Completa"	,""								,TamSX3("B5_SINOPSE")[1],/*lPixel*/,{||cSinopse				})	// Sinopse
TRCell():New(oSection1,"B5_PROMCON","SB5")
TRCell():New(oSection1,"B5_PROMREV","SB5")
TRCell():New(oSection1,"B5_INFCONS","SB5")
TRCell():New(oSection1,"B5_INFREV","SB5")
TRCell():New(oSection1,"cPREVENTR"	,/*Tabela*/,"PrevisaoEntrega"	,""								,15						,/*lPixel*/,{||cPREVENTR			})	// Previsão de chegada
TRCell():New(oSection1,"cOrigem"	,/*Tabela*/,"Origem"	,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||UPLOW(cArmazem)		})	// ALTERADO PARA ADICIONAR COLUNA 28/07

Return oReport

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processamento das informações     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Static Function PrintReport(oReport,cAliasSB1,cAliasSB5,cAliasQRY)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cFiltro   := ""

oReport:Section(1):Cell("CPLATRED"  ):SetBlock({|| cPlatred })
oReport:Section(1):Cell("CPLATEXT"  ):SetBlock({|| cPlatext })
oReport:Section(1):Cell("CCLASIND"  ):SetBlock({|| cClasind })
oReport:Section(1):Cell("cPREVENTR" ):SetBlock({|| cPREVENTR })
oReport:Section(1):Cell("cGenero1" ):SetBlock({|| cGenero1 })
oReport:Section(1):Cell("cGenero2" ):SetBlock({|| cGenero2 })
oReport:Section(1):Cell("cGenero3" ):SetBlock({|| cGenero3 })
oReport:Section(1):Cell("cGenero4" ):SetBlock({|| cGenero4 })
oReport:Section(1):Cell("cSinopse" ):SetBlock({|| cSinopse })
oReport:Section(1):Cell("cOrigem" ):SetBlock({|| cOrigem })

cFiltro	:= "%"
If MV_PAR07 == 2
	cFiltro	+= " B1_MSBLQL <> '1' AND "   

EndIf
If MV_PAR08 == 2
	cFiltro	+= " B1_BLQVEND <> '1' AND " 

EndIf  
 	
cFiltro	+= "%"

////////////////////////
cQRYcount	:= "TRBCNT"
BeginSql alias cQRYcount
	SELECT COUNT(*) QTD
	FROM %table:SB1% SB1,%table:SB5% SB5
	WHERE %Exp:cFiltro%
	B1_COD = B5_COD AND B1_FILIAL = %xfilial:SB1% AND
	B1_FILIAL = B5_FILIAL AND SB1.%notDel% AND
	B1_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% AND
	B1_GRUPO BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
	B1_TIPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06% AND
   	B5_YSOFTW <> %exp:'1'% // atualização feita em 27/12 em caso de problemas comentar essa linha e recompilar.
EndSql
nInc:= (cQRYcount)->QTD
dbclosearea(cQRYcount)
///////////////////////

oSection1:BeginQuery()

BeginSql alias cAliasQRY
	SELECT SB1.*
	FROM %table:SB1% SB1,%table:SB5% SB5
	WHERE %Exp:cFiltro%
	B1_COD = B5_COD AND B1_FILIAL = %xfilial:SB1% AND
	B1_FILIAL = B5_FILIAL AND SB1.%notDel% AND
	B1_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% AND
	B1_GRUPO BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
	B1_TIPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06% AND
	B5_YSOFTW <> %exp:'1'% // atualização feita em 27/12 em caso de problemas comentar essa linha e recompilar.
	ORDER BY SB5.B5_FOCO, SB5.B5_DTLAN DESC, SB1.B1_COD
EndSql

oSection1:EndQuery()
          

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Init()
//dbSelectArea(cAliasSB1)
//nInc	:= reccount()
//alert(nInc)
oReport:SetMeter(nInc)
CPLATRED:= ""
CPLATEXT:= ""
cPREVENTR	:= ""
cLANC	 	:= ""
CCLASIND	:= ""
dDatamax	:= ddatabase - 90
cGenero1	:= ""
cGenero2	:= ""
cGenero3	:= ""
cGenero4	:= ""


While !oReport:Cancel() .And. !(cAliasQRY)->(EOF()) .And. xFilial("SB1")==(cAliasQRY)->B1_FILIAL
	
	oReport:IncMeter()
	
	If oReport:Cancel()
	Exit
	EndIf
	
	DBSELECTAREA("SB1")
   	DBSETORDER(1)  
	DBSEEK(XFILIAL("SB1")+(cAliasQRY)->B1_COD)  
	
	cOrigem	:= (cAliasSB1)->B1_ORIGEM // ALTERADO PARA ADICIONAR COLUNA 28/07  
//É POSSÍVEL JOGAR AS DOAS OPÇÕES ABAIXO NA QUERY PARA QUE O PROCESSO FIQUE MAIS RÁPIDO.   	                                          
	If (cAliasSB1)->B1_TIPO < MV_PAR05 .or. (cAliasSB1)->B1_TIPO > MV_PAR06
	    dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip() 
		loop
	EndIf
        
	If (cAliasSB1)->B1_GRUPO < MV_PAR03 .or. (cAliasSB1)->B1_GRUPO > MV_PAR04
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip() 
		loop
	EndIf    
  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
Alteração no relatório CADPRO Prog: Janes Raulino Data: 11/06/13
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/     
 
	dIncl := CTOD(FWLeUserlg("B1_USERLGI", 2))
   	dCom  := CTOD(FWLeUserlg("B1_USERLGA", 2))    
 

	IF dCom > dIncl

		dCompara:= dCom

	ELSE 

		dCompara:= dIncl

	ENDIf
         

    IF !(dCompara >= MV_PAR09 .AND. dCompara <= MV_PAR10)
    	dbSelectArea(cAliasSB1)
	   	dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip() 
		loop                     
   	ENDIf	   

  
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
Alteração no relatório CADPRO Prog: Janes Raulino Data: 11/06/13
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

	If (cAliasSB1)->B1_COD < MV_PAR01 .or. (cAliasSB1)->B1_COD > MV_PAR02
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip()   
		loop
	EndIf
	
       
	cPlatred	:= getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+strzero(val((cAliasSB1)->B1_PLATAF),6),1,"")
	
	cPlatExt	:= getadvfval("SZ5","Z5_PLATEXT",xFilial("SZ5")+strzero(val((cAliasSB1)->B1_PLATAF),6),1,"")  

	cGenero1	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB1)->B1_CODGEN,1,""))
   


	If UPPER(SUBSTR((cAliasSB1)->B1_OLD,1,2)) == "LI"
		cClasind	:= "Livre"
	Else
		cClasind	:= SUBSTR((cAliasSB1)->B1_OLD,1,2)+" Anos"
	EndIf
	if empty((cAliasSB1)->B1_OLD)
		cClasind	:= ""
	EndIf	
	
	cGenero2	:= ""
	cGenero3	:= ""
	cGenero4	:= ""
	cSinopse	:= ""   
	//leitura do campo memo conteudo
	dbselectarea("SB5")
	dbsetorder(1)  
		
	If dbseek(xfilial("SB5")+(cAliasSB1)->B1_COD)
	   
		dCom := FWLeUserlg("B1_USERLGA", 2)
		dIncl := FWLeUserlg("B1_USERLGI", 2)          

		cGenero2	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB5)->B5_GENERO1,1,""))
		
		cGenero3	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB5)->B5_GENERO2,1,""))
		
		cGenero4	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB5)->B5_GENERO3,1,""))
		
		cSinopse	:= SB5->B5_SINOPSE
		   
		cLANC	:= "0"
		If SB5->B5_DTLAN > dDataMax
			cLANC	:= "1"
		EndIf
		
		nMes	:= month(SB5->B5_PREVCHE)
		cMesExt	:= ""
		If nMes == 1
			cMesExt	:= "Jan"
		ElseIf nMes == 2
			cMesExt	:= "Fev"
		ElseIf nMes == 3
			cMesExt	:= "Mar"
		ElseIf nMes == 4
			cMesExt	:= "Abr"
		ElseIf nMes == 5
			cMesExt	:= "Mai"
		ElseIf nMes == 6
			cMesExt	:= "Jun"
		ElseIf nMes == 7
			cMesExt	:= "Jul"
		ElseIf nMes == 8
			cMesExt	:= "Ago"
		ElseIf nMes == 9
			cMesExt	:= "Set"
		ElseIf nMes == 10
			cMesExt	:= "Out"
		ElseIf nMes == 11
			cMesExt	:= "Nov"
		ElseIf nMes == 12
			cMesExt	:= "Dez"
		EndIf
		cPREVENTR	:= ""
		If SB5->B5_PREVCHE > ddatabase
			IF DAY(SB5->B5_PREVCHE) == 1
				cPREVENTR := cMesExt+"/"+alltrim(STR(YEAR(SB5->B5_PREVCHE)))+" (1ªQuinz)"
			ELSEIF DAY(SB5->B5_PREVCHE) == 15
				cPREVENTR := cMesExt+"/"+alltrim(STR(YEAR(SB5->B5_PREVCHE)))+" (2ªQuinz)"
			ELSE
				cPREVENTR := SB5->B5_PREVCHE
			ENDIF
		Else
			cPREVENTR	:= ""
		EndIf
				
	Else
		dbSelectArea("SB5")
		dbCloseArea()
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip()
		loop
	EndIf
		
	oReport:Section(1):PrintLine()
	dbSelectArea("SB5")
	dbCloseArea()
	dbSelectArea(cAliasSB1)
	dbCloseArea()
	dbSelectArea(cAliasQRY)
	dbSkip()
	
END

oReport:Section(1):Finish()
oReport:Section(1):Init()
dbselectarea(cAliasQRY)
dbCloseArea()
  

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Função para converter string (frase) para que o primeiro caractere de cada palavra seja maiúsculo e o restante minúsculo³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function UPLOW(calias)

cVar	:= ""
aUPLOW	:= StrTokArr ( calias+" ", " ")
For nx := 1 to len(aUPLOW)
	If nx <> 1
		cVar	+= " "
	EndIf
	If SUBSTR(upper(substr(alltrim(aUPLOW[nx]),1,4)+"   "),1,3) $ "A   /E   /I   /O   /U   /DE  /DA  /DO  /AO  /OS  /ATÉ /ATE /NAS /NOS /EM  /UM  /UMA /QUE "
		cVar += lower(aUPLOW[nx])
	ElseIf SUBSTR(upper(substr(alltrim(aUPLOW[nx]),1,4)+"   "),1,3) $ "EA  /THQ /3D  /RPG  "
		cVar += upper(aUPLOW[nx])	
	Else
		cVar += upper(substr(aUPLOW[nx],1,1))+lower(substr(aUPLOW[nx],2,len(aUPLOW[nx])))
	EndIf
Next nx

Return(cVar)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Rodrigo Okamoto        ³ Data ³14/03/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Acerta o arquivo de perguntas                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AjustaSx1()

Local aArea := GetArea()
Local aHelpP	:= {}
Local aHelpE	:= {}
Local aHelpS	:= {}

Aadd( aHelpP, "Produto de ? " )
PutSx1("CADPRO","01","Produto de ?     "  ,"Produto de ?     ","Produto de ?     ","mv_ch1","C",15,0,0,"G","","SB1","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par01        // Data de                  		         ³

aHelpP	:= {}
Aadd( aHelpP, "Produto ate ? " )
PutSx1("CADPRO","02","Produto ate ?     "  ,"Produto ate ?     ","Produto ate ?  ","mv_ch2","C",15,0,0,"G","","SB1","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Grupo de ? " )
PutSx1("CADPRO","03","Grupo de ?     "  ,"Grupo de ?     ","Grupo de ?           ","mv_ch3","C",4,0,0,"G","","SBM","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Grupo ate ? " )
PutSx1("CADPRO","04","Grupo ate ?    "  ,"Grupo ate ?    ","Grupo ate ?          ","mv_ch4","C",4,0,0,"G","","SBM","","","mv_par04","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}                              
Aadd( aHelpP, "Tipo de ? " )
PutSx1("CADPRO","05","Tipo de ?     "  ,"Tipo de ?     ","Tipo de ?           ","mv_ch5","C",2,0,0,"G","","02","","","mv_par05","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Tipo ate ? " )
PutSx1("CADPRO","06","Tipo ate ?    "  ,"Tipo ate ?    ","Tipo ate ?          ","mv_ch6","C",2,0,0,"G","","02","","","mv_par06","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Imprime produtos inativos ? " )
PutSx1("CADPRO","07","Imprime inativos ?    "  ,"Imprime inativos ?    ","Imprime inativos ?		","mv_ch7","N",1,0,2,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Imprimir produtos bloqueados para venda ? " )
PutSx1("CADPRO","08","Imprime Blq Vendas ?    "  ,"Imprime Blq Vendas ?    ","Imprime Blq Vendas ?	","mv_ch8","N",1,0,2,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",aHelpP)
                
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
Alteração no relatório CADPRO Prog: Janes Raulino Data: 11/06/13
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
  
aHelpP	:= {}
Aadd( aHelpP, "Data inicial  " )
PutSx1("CADPRO","09","Data Inicial:    "  ,"Data Inicial    ","Data Inicial    	","mv_ch9","D",8,0,0,"G","","","","","mv_par09","","","","","","","","","","","","","","","","",aHelpP)
  

aHelpP	:= {}
Aadd( aHelpP, "Data Final   " )
PutSx1("CADPRO","10","Data Final    "  ,"Data Final    ","Data Final	        ","mv_ch10","D",8,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","",aHelpP)
             
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
Alteração no relatório CADPRO Prog: Janes Raulino Data: 11/06/13
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
aHelpP	:= {}

RestArea(aArea)

Return
