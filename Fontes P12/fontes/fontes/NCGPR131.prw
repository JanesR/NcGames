#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


#DEFINE CODCLIENTE 	1
#DEFINE LOJACLIENTE 2
#DEFINE CODFORNECE 	3
#DEFINE LOJAFORNCE 	4
#DEFINE EMPDESTINO	5
#DEFINE FILDESTINO 	6
#DEFINE LOJADESTINO	7
                
                
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR131  ºAutor  ³Microsiga           º Data ³  01/17/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera a pre-nota de entrada na empresa e filial de destino   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                 
User Function NCGPR131()

Local aArea := GetArea()
Local cErro	:= ""

//Gera o documento de entrada
cErro := GrvPreNF()

RestArea(aArea)
Return cErro


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvPreNF  ºAutor  ³Microsiga           º Data ³  01/17/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava a pre-nota de entrada                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvPreNF()

Local aAreaAtu		:=	GetArea()
Local aAreaSF2		:=	SF2->(GetArea())
Local aAreaSD2		:=	SD2->(GetArea())
Local aAreaSA2		:=	SA2->(GetArea())
Local aAreaSA1		:=	SA1->(GetArea())
Local cEspecie		:=	'SPED'
Local cArmDest		:=	Alltrim(U_MyNewSX6("ES_PR100LO","01","C","Armazem da Pre Nota de Entrada","","",.F. ))
Local cModo			:=	""
Local cAliasSB1 	:= ""
Local aCabec		:={}
Local aItens		:={}
Local cChaveSD2   := ""
Local nItem       := 0
Local aLinha      := {}
Local oSrv        := Nil
Local aGrvNF      := {}
Local cTesClass   := ""
Local cErro			:= ""
Local nFatConv		:= 0
Local aLojDest		:= {}

SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
SA1->(DbSetOrder(1))//A1_FILIAL+A1_COD+A1_LOJA
SA2->(DbSetOrder(3))//A2_FILIAL+A2_CGC
	
//Posiciona os itens da NF
If !SD2->(MsSeek(xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA) ))
	cErro += "Nenhum item da nota fiscal encontrado."+CRLF	
EndIf

//Dados da loja de destino
aLojDest := GetLjDest(SF2->F2_CLIENTE, SF2->F2_LOJA)	
If Len(aLojDest) <= 0
	cErro += "Loja não cadastrada na tabela de/para (ZX5 tabela 00009). Entre em contato com administrador. Cliente: "+SF2->F2_CLIENTE+"/"+SF2->F2_LOJA+CRLF	
EndIf

//Abre a tabela SB1 na empresa destino	
cAliasSB1	:=GetNextAlias()
EmpOpenFile(cAliasSB1,"SB1",1,.T.,aLojDest[EMPDESTINO],@cModo)

IncProc("Processando Nota Fiscal:"+SF2->(F2_DOC+"/"+F2_SERIE))
	
//Cabecalho da nota fiscal de entrada
aCabec   := {}
aadd(aCabec,{"F1_DOC"    	,SF2->F2_DOC})
aadd(aCabec,{"F1_SERIE"  	,SF2->F2_SERIE})
aadd(aCabec,{"F1_EST"   	,SM0->M0_ESTCOB})
aadd(aCabec,{"F1_TIPO"   	,"N"})
aadd(aCabec,{"F1_FORMUL" 	,"N"})
aadd(aCabec,{"F1_EMISSAO"	,SF2->F2_EMISSAO})
aadd(aCabec,{"F1_FORNECE"	,aLojDest[CODFORNECE]})
aadd(aCabec,{"F1_LOJA"   	,aLojDest[LOJAFORNCE]})
aadd(aCabec,{"F1_ESPECIE"	,cEspecie})
aadd(aCabec,{"F1_FILORIG"  ,SF2->F2_FILIAL})
aadd(aCabec,{"F1_CLIORI"	,SF2->F2_CLIENTE})
aadd(aCabec,{"F1_LOJAORI"	,SF2->F2_LOJA})
aadd(aCabec,{"F1_CHVNFE"	,SF2->F2_CHVNFE})
aadd(aCabec,{"F1_XORIG"		,"NCGPR100"})

// Itens da nota fiscal de entrada
cChaveSD2	:= xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)

aItemSD2 :={}
aItens   :={}
nItem		:=0
	
Do While !SD2->(Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==cChaveSD2
	SD2->(AADD(aItemSD2,{Recno(),D2_ITEM} ) )
	SD2->(dbSkip())
EndDo

aSort(aItemSD2,,,{|x,y| x[2]<y[2]})
	
For nXnd	:=	1 To Len(aItemSD2)

	SD2->(DbGoTo(aItemSD2[nXnd,1]))
	
	aLinha		:={}
	aadd(aLinha	,{"D1_ITEM"		,SD2->D2_ITEM	,Nil})
	
	cProduto:=""
	
	If !cEmpAnt=="01"
		cProduto:=SD2->D2_COD
	Else
		SA7->(DbSetOrder(1)) //A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
		If SA7->(MsSeek(xFilial("SA7")+"00000001"+SD2->D2_COD))
			cProduto:=SA7->A7_CODCLI
		EndIf
	EndIf	
		
	If Empty(cProduto)
		cErro	+="Item "+SD2->D2_ITEM+" Produto "+SD2->D2_COD+" nao encontrado codigo produto WebManager"+CRLF
	ElseIf  !(cAliasSB1)->(DbSeek(xFilial("SB1")+cProduto) )
		cErro	+="Item "+SD2->D2_ITEM+" Produto "+SD2->D2_COD+" não encontrado no cadastro e produto da empresa "+aLojDest[EMPDESTINO]+CRLF
	EndIf
	
	//Fator de conversão
	nFatConv	:= 0
	If (cAliasSB1)->(DbSeek(xFilial("SB1")+cProduto) )
		nFatConv := (cAliasSB1)->B1_YFCONV
	EndIf
	
	aadd(aLinha,{"D1_COD"  		,cProduto			,Nil})
	
	If nFatConv > 0
		aadd(aLinha,{"D1_QUANT"		,SD2->D2_QUANT * nFatConv	,Nil})
		aadd(aLinha,{"D1_VUNIT"		,SD2->D2_TOTAL / (SD2->D2_QUANT * nFatConv)		,Nil})
	Else
		aadd(aLinha,{"D1_QUANT"		,SD2->D2_QUANT		,Nil})
		aadd(aLinha,{"D1_VUNIT"		,SD2->D2_PRCVEN	,Nil})
	EndIf
	
	aadd(aLinha,{"D1_TOTAL"		,SD2->D2_TOTAL		,Nil})
	aadd(aLinha,{"D1_IPI"		,SD2->D2_IPI		,Nil})
	aadd(aLinha,{"D1_PICM"		,SD2->D2_PICM		,Nil})
	aadd(aLinha,{"D1_EMISSAO"	,SD2->D2_EMISSAO	,Nil})
	aadd(aLinha,{"D1_YCODPRO"	,SD2->D2_COD		,Nil})
	aadd(aLinha,{"D1_LOCAL"		,cArmDest			,Nil})

	cTesClass:=""
	If SD2->D2_CF=="5102"
		cTesClass:="493"
	ElseIf SD2->D2_CF=="5405"
		cTesClass:="492"
	ElseIf SD2->D2_CF=="5403"
		cTesClass:="490"
	ElseIf SD2->D2_CF=="5910"
		cTesClass:="491"
	EndIf
	
	aadd(aLinha,{"D1_TESACLA",cTesClass,Nil})
	aadd(aLinha,{"D1_ICMSRET"	,SD2->D2_ICMSRET,Nil})
	aadd(aLinha,{"D1_BRICMS"	,SD2->D2_BRICMS ,Nil})
	
	// Checa se utiliza rastreabilidade
	If Rastro(SD2->D2_COD,"L")
		aadd(aLinha,{"D1_LOTECTL",SD2->D2_LOTECTL,Nil})
		aadd(aLinha,{"D1_DTVALID",SD2->D2_DTVALID,Nil})
	EndIf
	
	If Rastro(SD2->D2_COD,"S")
		aadd(aLinha,{"D1_LOTECTL",SD2->D2_LOTECTL,Nil})
		aadd(aLinha,{"D1_NUMLOTE",SD2->D2_NUMLOTE,Nil})
		aadd(aLinha,{"D1_DTVALID",SD2->D2_DTVALID,Nil})
	EndIf
	
	If Rastro(SD2->D2_COD,"L") .Or. Rastro(cProduto,"S")
		aadd(aLinha,{"D1_FCICOD",SD2->D2_FCICOD,Nil})
	Endif
	
	aadd(aItens,aLinha)
Next
	
If Len(aItens) > 0 .And. Len(aCabec) > 0

	aGrvNF	:= StartJob('U_PR100GeraNF',GetEnvServer(),.T.,aLojDest[EMPDESTINO],aLojDest[FILDESTINO],aCabec,aItens)
	
	If ValType(aGrvNF) =="U"//Erro ao tentar abrir a empresa destino
		aGrvNF:={.F.,"Erro ao abrir a empresa destino."}
	EndIf
	
	If aGrvNF[1]  //Gravado
		
		RecLock("SF2",.F.)
		SF2->F2_FILDEST:= aLojDest[FILDESTINO]
		SF2->F2_FORDES :=	aLojDest[CODFORNECE]
		SF2->F2_LOJADES:=	aLojDest[LOJAFORNCE]
		SF2->F2_FORMDES:=	"N"
		SF2->(MsUnlock())
		
		//Grava os dados na tabela ZA0
		GrvZAO(aGrvNF, aLojDest[EMPDESTINO], aLojDest[FILDESTINO], aLojDest[CODFORNECE], aLojDest[LOJAFORNCE])
	
	Else
		cErro := aGrvNF[2]
	EndIf
	
EndIf

(cAliasSB1)->(DbCloseArea())
RestArea(aAreaSF2)
RestArea(aAreaSD2)
RestArea(aAreaSA2)
RestArea(aAreaSA1)
RestArea(aAreaAtu)
Return cErro

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvZAO	  ºAutor  ³Microsiga	     º Data ³  01/18/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                         	                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvZAO(aDados, cEmpDest, cFilDest, cForneDes, cLjForDes)

Default aDados		:= {}
Default cEmpDest	:= ""
Default cFilDest  := ""
Default cForneDes := ""
Default cLjForDes := ""

ZAO->(RecLock("ZAO",.T.))
ZAO->ZAO_FILIAL	:= xFilial("ZAO")
ZAO->ZAO_EMPORI	:= cEmpAnt
ZAO->ZAO_FILORI	:= SF2->F2_FILIAL
ZAO->ZAO_NFORIG	:= SF2->F2_DOC
ZAO->ZAO_SERORI	:= SF2->F2_SERIE
ZAO->ZAO_CLIORI	:= SF2->F2_CLIENTE
ZAO->ZAO_LOJORI	:= SF2->F2_LOJA
ZAO->ZAO_EMNFOR	:= SF2->F2_EMISSAO
ZAO->ZAO_EMPDES	:= cEmpDest
ZAO->ZAO_FILDES	:= cFilDest
ZAO->ZAO_NFDEST	:= aDados[3]
ZAO->ZAO_SERDES	:= aDados[4]
ZAO->ZAO_FORDES	:= cForneDes
ZAO->ZAO_LOJDES	:= cLjForDes
ZAO->ZAO_EMNFDE	:= aDados[5]
ZAO->ZAO_ERRO  	:= IIf(aDados[1],"N","S")
ZAO->(MsUnLock())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetLjDest  ºAutor  ³Microsiga         º Data ³  01/17/15    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a loja de destino da conferencia cega			  º±±
±±º          ³ amarraçãodo no SA7 (Cliente x Produto)                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetLjDest(cCodCli, cLoja)

Local aArea 	:= GetArea()
Local aRet		:= {}
Local cArqTmp	:= GetNextAlias()
Local cTabZX5	:= Alltrim(U_MyNewSX6("NC_CGTBZX5","00009"		,"C","Tabela de De/Para Conferencia Cega ZX5","","",.F. )) 
Local cQuery	:= ""
                          
Default cCodCli	:= "" 
Default cLoja	:= ""

cQuery	:= " SELECT ZX5_DESCRI FROM "+RetSqlname("ZX5")+CRLF
cQuery	+= " WHERE ZX5_FILIAL= '"+xFilial("ZX5")+"' "+CRLF
cQuery	+= " AND ZX5_TABELA = '"+cTabZX5+"' "+CRLF
cQuery	+= " AND ZX5_DESCRI LIKE '%"+cCodCli+";"+cLoja+"%' "+CRLF
cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	aRet := SEPARA((cArqTmp)->ZX5_DESCRI, ";")
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet 