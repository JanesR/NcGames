#include "RWMAKE.CH"

USER FUNCTION CADKPI()

Local cAlias 		:= "SZT"

Private cCadastro 	:= "KPI"
Private aRotina 	:= {}
Private cDelFunc 	:= ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

AADD(aRotina,{"Pesquisar"	,"AxPesqui"  ,0,1})
AADD(aRotina,{"Visualizar"	,"U_KPI2Vis" ,0,2})
AADD(aRotina,{"Incluir"		,"U_KPI2Inc" ,0,3})
AADD(aRotina,{"Alterar"		,"U_KPI2Alt" ,0,4})
AADD(aRotina,{"Excluir"		,"U_KPI2Exc" ,0,5})

dbSelectArea(cAlias)
dbSetOrder(1)
mBrowse( 6,1,22,75,cAlias)

Return

USER FUNCTION KPI2VIS(cAlias,nReg,nOpc)

//Local nUsado	:= 0
Local cTitulo	:= "Visualizacao de itens - KPI"
Local aCab		:= {} // Array com descricao dos campos do Cabecalho do Modelo 2
Local aRoda		:= {} // Array com descricao dos campos do Rodape do Modelo 2
Local aGrid		:= {80,005,050,300}  //Array com coordenadas da GetDados no modelo2 - Padrao: {44,5,118,315}               
				// Linha Inicial - Coluna Inicial - +Qts Linhas - +Qts Colunas : {080,005,050,300}
Local cLinhaOk	:= "AllwaysTrue()" // Validacoes na linha da GetDados da Modelo 2
Local cTudoOk	:= "AllwaysTrue()" // Validacao geral da GetDados da Modelo 2
Local lRetMod2  := .F. // Retorno da função Modelo2 - .T. Confirmou / .F. Cancelou
Local nLinha	:= 0
Local nColuna	:= 0

// Variaveis para GetDados()
Private aCols	:= {}
Private aHeader	:= {}

// Variaveis para campos da Enchoice()
Private cCodigo := SZT->ZT_CODIGO
Private cCAno := SZT->ZT_ANO

// Montagem do array de cabeçalho
// AADD(aCab,{"Variável"	,{L,C} ,"Título","Picture","Valid","F3",lEnable})
AADD(aCab,{"cCodigo"	,{015,010} ,"Codigo","@!",,,.F.})
AADD(aCab,{"cCAno"		,{015,080} ,"Ano","@!",,,.T.})

// Montagem do aHeader
AADD(aHeader,{"Item"		  	,"ZT_ITEM" 		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Indicadores"	  	,"ZT_INDIC"		,"@!",150,0,"AllwaysTrue()", "","C","","R"}) 
AADD(aHeader,{"Responsável"	  	,"ZT_RESP" 		,"@!",50,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Unid."  		  	,"ZT_UNID" 		,"@!",20,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Form. Calc."	   	,"ZT_FORCALC"	,"@!",150,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Meta"   			,"ZT_META" 		,"@!",25,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Peso (%)"	   	,"ZT_PESO"		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acum Jan" 	,"ZT_ACUJAN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Fev"	,"ZT_ACUFEV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mar" 	,"ZT_ACUMAR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Abr"	,"ZT_ACUABR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mai"   	,"ZT_ACUMAI"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jun"	,"ZT_ACUJUN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jul"  	,"ZT_ACUJUL"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Ago"	,"ZT_ACUAGO"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Set"   	,"ZT_ACUSET"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Out"	,"ZT_ACUOUT"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Nov"  	,"ZT_ACUNOV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Dez"	,"ZT_ACUDEZ"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})

// Montagem do aCols
While SZT->(!Eof()) .AND. SZT->ZT_CODIGO == cCodigo

	AADD(aCols,Array(Len(aHeader)+1))
	nLinha++

	For nColuna := 1 to Len(aHeader)
    	aCols[nLinha][nColuna] := &(aHeader[nColuna][2])
	Next nColuna

	aCols[nLinha][Len(aHeader)+1] := .F. // Linha não deletada
	
	SZT->(dbSkip())
End

lRetMod2 := Modelo2(cTitulo,aCab,aRoda,aGrid,nOpc,cLinhaOk,cTudoOk)

IF lRetMod2
	MsgInfo("Você confirmou a operação","KPI")
ELSE
	MsgAlert("Você cancelou a operação","KPI")
ENDIF

Return

USER FUNCTION KPI2INC(cAlias,nReg,nOpc)

//Local nUsado	:= 0
Local cTitulo	:= "Inclusao de itens - KPI"
Local aCab		:= {} // Array com descricao dos campos do Cabecalho do Modelo 2
Local aRoda		:= {} // Array com descricao dos campos do Rodape do Modelo 2
Local aGrid		:= {80,005,050,300}  //Array com coordenadas da GetDados no modelo2 - Padrao: {44,5,118,315}               
				// Linha Inicial - Coluna Inicial - +Qts Linhas - +Qts Colunas : {080,005,050,300}
Local cLinhaOk	:= "AllwaysTrue()" // Validacoes na linha da GetDados da Modelo 2
Local cTudoOk	:= "AllwaysTrue()" // Validacao geral da GetDados da Modelo 2
Local lRetMod2  := .F. // Retorno da função Modelo2 - .T. Confirmou / .F. Cancelou
Local nLinha	:= 0
Local nColuna	:= 0

// Variaveis para GetDados()
Private aCols	:= {}
Private aHeader	:= {}

// Variaveis para campos da Enchoice()
Private cCodigo := SZT->ZT_CODIGO
Private cCAno := SZT->ZT_ANO

// Montagem do array de cabeçalho
// AADD(aCab,{"Variável"	,{L,C} ,"Título","Picture","Valid","F3",lEnable})
AADD(aCab,{"cCodigo"	,{015,010} ,"Codigo","@!",,,.F.})
AADD(aCab,{"cCAno"	,{015,080} ,"Ano","@!",,,.T.})

// Montagem do aHeader
AADD(aHeader,{"Item"		  	,"ZT_ITEM" 		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Indicadores"	  	,"ZT_INDIC"		,"@!",150,0,"AllwaysTrue()", "","C","","R"}) 
AADD(aHeader,{"Responsável"	  	,"ZT_RESP" 		,"@!",50,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Unid."  		  	,"ZT_UNID" 		,"@!",20,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Form. Calc."	   	,"ZT_FORCALC"	,"@!",150,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Meta"   			,"ZT_META" 		,"@!",25,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Peso (%)"	   	,"ZT_PESO"		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acum Jan" 	,"ZT_ACUJAN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Fev"	,"ZT_ACUFEV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mar" 	,"ZT_ACUMAR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Abr"	,"ZT_ACUABR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mai"   	,"ZT_ACUMAI"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jun"	,"ZT_ACUJUN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jul"  	,"ZT_ACUJUL"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Ago"	,"ZT_ACUAGO"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Set"   	,"ZT_ACUSET"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Out"	,"ZT_ACUOUT"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Nov"  	,"ZT_ACUNOV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Dez"	,"ZT_ACUDEZ"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})


// Montagem do aCols
aCols := Array(1,Len(aHeader)+1)

// Inicialização do aCols
For nColuna := 1 to Len(aHeader)

	If aHeader[nColuna][8] == "C"
		aCols[1][nColuna] := SPACE(aHeader[nColuna][4])
	ElseIf aHeader[nColuna][8] == "N"
		aCols[1][nColuna] := 0
	ElseIf aHeader[nColuna][8] == "D"
		aCols[1][nColuna] := CTOD("")
	ElseIf aHeader[nColuna][8] == "L"
		aCols[1][nColuna] := .F.
	ElseIf aHeader[nColuna][8] == "M"
		aCols[1][nColuna] := ""
	Endif
		
Next nColuna

aCols[1][Len(aHeader)+1] := .F. // Linha não deletada

lRetMod2 := Modelo2(cTitulo,aCab,aRoda,aGrid,nOpc,cLinhaOk,cTudoOk)

IF lRetMod2
	//MsgInfo("Você confirmou a operação","MBRW2SX5")
	For nLinha := 1 to len(aCols)
		// Campos de Cabeçalho
		Reclock("SZT",.T.)
		SZT->ZT_CODIGO := cCodigo
		SZT->ZT_ANO := cCAno
		// Campos do aCols
		//SX5->X5_CHAVE  := aCols[nLinha][1]
		//SX5->X5_DESCRI := aCols[nLinha][2]		
		For nColuna := 1 to Len(aHeader)
			SZT->&(aHeader[nColuna][2]) := aCols[nLinha][nColuna]		
		Next nColuna
		MsUnLock()
	Next nLinha
ELSE
	MsgAlert("Você cancelou a operação","KPI")
ENDIF

Return


USER FUNCTION KPI2ALT(cAlias,nReg,nOpc)

//Local nUsado	:= 0
Local cTitulo	:= "Alteracao de itens - KPI"
Local aCab		:= {} // Array com descricao dos campos do Cabecalho do Modelo 2
Local aRoda		:= {} // Array com descricao dos campos do Rodape do Modelo 2
Local aGrid		:= {80,005,050,300}  //Array com coordenadas da GetDados no modelo2 - Padrao: {44,5,118,315}               
				// Linha Inicial - Coluna Inicial - +Qts Linhas - +Qts Colunas : {080,005,050,300}
Local cLinhaOk	:= "AllwaysTrue()" // Validacoes na linha da GetDados da Modelo 2
Local cTudoOk	:= "AllwaysTrue()" // Validacao geral da GetDados da Modelo 2
Local lRetMod2  := .F. // Retorno da função Modelo2 - .T. Confirmou / .F. Cancelou
Local nLinha	:= 0
Local nColuna	:= 0

// Variaveis para GetDados()
Private aCols	:= {}
Private aHeader	:= {}

// Variaveis para campos da Enchoice()
Private cCodigo := SZT->ZT_CODIGO
Private cCAno := SZT->ZT_ANO

// Montagem do array de cabeçalho
// AADD(aCab,{"Variável"	,{L,C} ,"Título","Picture","Valid","F3",lEnable})
AADD(aCab,{"cCodigo"	,{015,010} ,"Codigo","@!",,,.F.})
AADD(aCab,{"cCAno"	,{015,080} ,"Ano","@!",,,.T.})

// Montagem do aHeader
AADD(aHeader,{"Item"		  	,"ZT_ITEM" 		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Indicadores"	  	,"ZT_INDIC"		,"@!",150,0,"AllwaysTrue()", "","C","","R"}) 
AADD(aHeader,{"Responsável"	  	,"ZT_RESP" 		,"@!",50,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Unid."  		  	,"ZT_UNID" 		,"@!",20,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Form. Calc."	   	,"ZT_FORCALC"	,"@!",150,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Meta"   			,"ZT_META" 		,"@!",25,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Peso (%)"	   	,"ZT_PESO"		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acum Jan" 	,"ZT_ACUJAN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Fev"	,"ZT_ACUFEV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mar" 	,"ZT_ACUMAR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Abr"	,"ZT_ACUABR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mai"   	,"ZT_ACUMAI"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jun"	,"ZT_ACUJUN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jul"  	,"ZT_ACUJUL"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Ago"	,"ZT_ACUAGO"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Set"   	,"ZT_ACUSET"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Out"	,"ZT_ACUOUT"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Nov"  	,"ZT_ACUNOV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Dez"	,"ZT_ACUDEZ"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})

// Montagem do aCols
While SZT->(!Eof()) .AND. SZT->ZT_CODIGO == cCodigo

	AADD(aCols,Array(Len(aHeader)+1))
	nLinha++

	For nColuna := 1 to Len(aHeader)
    	aCols[nLinha][nColuna] := &(aHeader[nColuna][2])
	Next nColuna

	aCols[nLinha][Len(aHeader)+1] := .F. // Linha não deletada
	
	SZT->(dbSkip())
End

lRetMod2 := Modelo2(cTitulo,aCab,aRoda,aGrid,nOpc,cLinhaOk,cTudoOk)

SZT->(dbSetOrder(1))

IF lRetMod2

	For nLinha := 1 to len(aCols)
		
		IF SZT->(dbSeek(cCodigo+cCAno+aCols[nLinha][1])) .AND. !aCols[nLinha][Len(aHeader)+1]
			
			Reclock("SZT",.F.)
			For nColuna := 1 to Len(aHeader)
				SZT->&(aHeader[nColuna][2]) := aCols[nLinha][nColuna]		
			Next nColuna
			MsUnLock()
		
		ELSEIF SZT->(dbSeek(cCodigo+cCAno+aCols[nLinha][1])) .AND. aCols[nLinha][Len(aHeader)+1]

			Reclock("SZT",.F.)
			dbDelete()
			MsUnLock()		

		ELSEIF !SZT->(dbSeek(cCodigo+cCAno+aCols[nLinha][1])) .AND. !aCols[nLinha][Len(aHeader)+1]
		
			Reclock("SZT",.T.)
			SZT->ZT_CODIGO := cCodigo
			SZT->ZT_ANO := cCAno
			// Campos do aCols
			//SX5->X5_CHAVE  := aCols[nLinha][1]
			//SX5->X5_DESCRI := aCols[nLinha][2]		
			For nColuna := 1 to Len(aHeader)
				SZT->&(aHeader[nColuna][2]) := aCols[nLinha][nColuna]		
			Next nColuna
			MsUnLock()

		ENDIF

	Next nLinha

ELSE
	MsgAlert("Você cancelou a operação","KPI")
ENDIF

Return

USER FUNCTION KPI2Exc(cAlias,nReg,nOpc)

//Local nUsado	:= 0
Local cTitulo	:= "Exclusao de itens - KPI"
Local aCab		:= {} // Array com descricao dos campos do Cabecalho do Modelo 2
Local aRoda		:= {} // Array com descricao dos campos do Rodape do Modelo 2
Local aGrid		:= {80,005,050,300}  //Array com coordenadas da GetDados no modelo2 - Padrao: {44,5,118,315}               
				// Linha Inicial - Coluna Inicial - +Qts Linhas - +Qts Colunas : {080,005,050,300}
Local cLinhaOk	:= "AllwaysTrue()" // Validacoes na linha da GetDados da Modelo 2
Local cTudoOk	:= "AllwaysTrue()" // Validacao geral da GetDados da Modelo 2
Local lRetMod2  := .F. // Retorno da função Modelo2 - .T. Confirmou / .F. Cancelou
Local nLinha	:= 0
Local nColuna	:= 0

// Variaveis para GetDados()
Private aCols	:= {}
Private aHeader	:= {}

// Variaveis para campos da Enchoice()
Private cCodigo := SZT->ZT_CODIGO
Private cCAno := SZT->ZT_ANO

// Montagem do array de cabeçalho
// AADD(aCab,{"Variável"	,{L,C} ,"Título","Picture","Valid","F3",lEnable})
AADD(aCab,{"cCodigo"	,{015,010} ,"Codigo","@!",,,.F.})
AADD(aCab,{"cCAno"	,{015,080} ,"Ano","@!",,,.T.})

// Montagem do aHeader
AADD(aHeader,{"Item"		  	,"ZT_ITEM" 		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Indicadores"	  	,"ZT_INDIC"		,"@!",150,0,"AllwaysTrue()", "","C","","R"}) 
AADD(aHeader,{"Responsável"	  	,"ZT_RESP" 		,"@!",50,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Unid."  		  	,"ZT_UNID" 		,"@!",20,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Form. Calc."	   	,"ZT_FORCALC"	,"@!",150,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Meta"   			,"ZT_META" 		,"@!",25,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Peso (%)"	   	,"ZT_PESO"		,"@!",10,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acum Jan" 	,"ZT_ACUJAN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Fev"	,"ZT_ACUFEV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mar" 	,"ZT_ACUMAR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Abr"	,"ZT_ACUABR"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Mai"   	,"ZT_ACUMAI"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jun"	,"ZT_ACUJUN"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Jul"  	,"ZT_ACUJUL"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Ago"	,"ZT_ACUAGO"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Set"   	,"ZT_ACUSET"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Out"	,"ZT_ACUOUT"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Nov"  	,"ZT_ACUNOV"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})
AADD(aHeader,{"Real Acu Dez"	,"ZT_ACUDEZ"	,"@!",15,0,"AllwaysTrue()", "","C","","R"})

// Montagem do aCols
While SZT->(!Eof()) .AND. SZT->ZT_CODIGO == cCodigo

	AADD(aCols,Array(Len(aHeader)+1))
	nLinha++

	For nColuna := 1 to Len(aHeader)
    	aCols[nLinha][nColuna] := &(aHeader[nColuna][2])
	Next nColuna

	aCols[nLinha][Len(aHeader)+1] := .F. // Linha não deletada
	
	SZT->(dbSkip())
End

lRetMod2 := Modelo2(cTitulo,aCab,aRoda,aGrid,nOpc,cLinhaOk,cTudoOk)

IF lRetMod2

	For nLinha := 1 to len(aCols)
		
		IF SZT->(dbSeek(cCodigo+cCAno+aCols[nLinha][1]))

			Reclock("SZT",.F.)
			dbDelete()
			MsUnLock()		

		ENDIF

	Next nLinha

ELSE
	MsgAlert("Você cancelou a operação","KPI")
ENDIF

Return