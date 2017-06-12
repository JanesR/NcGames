#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE 'TopConn.ch'

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCGPR105   บAutor  ณ Tiago Bizan  	 บ Data ณ  09/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Chamada das fun็๕es para exporta็ใo das tabelas para o WMS บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function NCGPR105()

Processa({|| U_E105SB1() }, "Exportando  Tabela de Produtos...")
Processa({|| U_E105SX5() }, "Exportando  Tabela Gen้rica de Armaz้ns...")
Processa({|| U_E105SHA() }, "Exportando  Tabela de Unidades de Medidas...")

Return()


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E105SB1   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para exportar a tabela de produtos para o WMS		  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function E105SB1()

Local clQry			:= ""
Local cAliasProd	:= GetNextAlias()
Local alCmpProd		:= {}
Local alCmpEmb		:= {}
Local alValProd		:= {}
Local alValEmb		:= {}
Local nlConect		:= 0
Local nCnt			:= 0
Local alCmpChave	:= {}
Local alValChave	:= {}
Local clTabWMS		:= ""

clQry := " SELECT B1_COD, " + CRLF
clQry += " B1_XDESC, " + CRLF
clQry += " B1_UM, " + CRLF
clQry += " B1_PESO, " + CRLF
clQry += " B1_PESBRU, "+ CRLF
clQry += " B1_CODBAR, "+ CRLF
clQry += " B1_ALT, "+ CRLF
clQry += " B1_LARGURA, "+ CRLF
clQry += " B1_PROF, "+ CRLF
clQry += " B1_TIPO "+ CRLF
clQry += " B1_CATEG "+ CRLF

clQry += " FROM "+RetSqlName("SB1") + " SB1	" + CRLF

clQry += " WHERE SB1.D_E_L_E_T_ = ' ' " + CRLF
clQry += " AND SB1.B1_TIPO IN ('PA') " + CRLF
//clQry += " AND ROWNUM <= 10 "
clQry += " ORDER BY SB1.B1_COD,B1_TIPO " + CRLF

IIf(Select(cAliasProd) > 0,(cAliasProd)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAliasProd  ,.F.,.T.)

DBSelectArea(cAliasProd)
(cAliasProd)->(dbGotop())
(cAliasProd)->(dbEval({|| nCnt++},,{|| !EOF() } ) )

ProcRegua( nCnt )

(cAliasProd)->(dbGotop())

If (cAliasProd)->(!EOF())
	
	alCmpProd	:= U_F105RETCMP("B1P",.T.)
	alCmpEmb	:= U_F105RETCMP("B1E",.T.)
	
	While (cAliasProd)->(!EOF())
		IncProc("Produto: "+ALLTRIM((cAliasProd)->B1_COD))
		
		//INCLUSรO DOS REGISTROS NA TABELA DE PRODUTOS
		alValProd	:= U_F105RETCMP("B1P",.F.,@clTabWMS,@alCmpChave,@alValChave,cAliasProd)
		
		//CRIA A QUERY PARA INSERIR OU ALTERAR OS REGISTROS
		IF !U_E0105EXT(clTabWMS, alCmpChave, alValChave )
			clQuery := U_EXESQL105(1,alCmpProd,alValProd,clTabWMS)
		Else
			clQuery := U_EXESQL105(2,alCmpProd,alValProd,clTabWMS,alCmpChave,alValChave)
		EndIF
		
		If !Empty(clQuery)
			//Executa a query
			If TcSqlExec(clQuery) >= 0
				TcSqlExec("COMMIT")
			EndIf
		EndIf
		
		
		(cAliasProd)->(DBSkip())
	EndDO
	
	(cAliasProd)->(DBCloseArea())
	
EndIF

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E105SX5   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para exportar a tabela gen้rica de Armaz้ns para	  บฑฑ
ฑฑบ          ณ o WMS                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function E105SX5()

Local clQry			:= ""
Local cAlias		:= GetNextAlias()
Local alCampos		:= {}
Local alValInc		:= {}
Local nlConect		:= 0
Local nCnt			:= 0
Local alCmpChave	:= {}
Local alValChave	:= {}
Local clTabWMS		:= ""
Local clArmz		:= SuperGetMV("MV_ARMWMAS")

clQry := " SELECT X5_CHAVE , " + CRLF
clQry += " X5_DESCRI, " + CRLF
clQry += " X5_TABELA " + CRLF
clQry += " FROM "+RetSqlName("SX5") + " SX5	" + CRLF

clQry += " WHERE SX5.D_E_L_E_T_ = ' ' " + CRLF
clQry += " AND SX5.X5_TABELA = 'ZZ' " + CRLF
clQry += " AND SX5.X5_CHAVE IN " + FORMATIN(clArmz,"/")
clQry += " ORDER BY X5_CHAVE " + CRLF

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(dbGotop())
(cAlias)->(dbEval({|| nCnt++},,{|| !EOF() } ) )
(cAlias)->(dbGotop())

ProcRegua( nCnt )

If (cAlias)->(!EOF())
	
	alCampos	:= U_F105RETCMP("ZZ",.T.)
	
	While (cAlias)->(!EOF())
		IncProc("Armaz้m: "+ALLTRIM((cAlias)->X5_CHAVE))
		
		alValInc	:= U_F105RETCMP("ZZ",.F.,@clTabWMS,@alCmpChave,@alValChave,cAlias)
		
		// CRIA A QUERY PARA INSERIR OS REGISTROS
		IF !U_E0105EXT(clTabWMS, alCmpChave, alValChave )
			clQuery := U_EXESQL105(1,alCampos,alValInc,clTabWMS)
		Else
			clQuery := U_EXESQL105(2,alCampos,alValInc,clTabWMS,alCmpChave,alValChave)
		EndIF
		
		If !Empty(clQuery)
			If TcSqlExec(clQuery) >= 0
				TcSqlExec("COMMIT")
			EndIf
		EndIf
		
		(cAlias)->(DBSkip())
	EndDO
	(cAlias)->(DBCloseArea())
	
EndIF
Return()


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E105SHA   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para exportar a tabela de Unidade de Medida para	  บฑฑ
ฑฑบ          ณ o WMS                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function E105SHA()

Local clQry			:= ""
Local cAlias		:= GetNextAlias()
Local alCampos		:= {}
Local alValInc		:= {}
Local nlConect		:= 0
Local nCnt			:= 0
Local alCmpChave	:= {}
Local alValChave	:= {}
Local clTabWMS		:= ""

clQry := " SELECT AH_UNIMED , " + CRLF
clQry += " AH_DESCPO " + CRLF
clQry += " FROM "+RetSqlName("SAH") + " SAH	" + CRLF

clQry += " WHERE SAH.D_E_L_E_T_ = ' ' " + CRLF
clQry += " ORDER BY AH_UNIMED " + CRLF

Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)

DBSelectArea(cAlias)
(cAlias)->(dbGotop())
(cAlias)->(dbEval({|| nCnt++},,{|| !EOF() } ) )
(cAlias)->(dbGotop())

ProcRegua( nCnt )

If (cAlias)->(!EOF())
	
	alCampos	:= U_F105RETCMP("SAH",.T.)
	
	While (cAlias)->(!EOF())
		IncProc("Unidades de Medidas: "+(cAlias)->AH_UNIMED)
		
		alValInc	:= U_F105RETCMP("SAH",.F.,@clTabWMS,@alCmpChave,@alValChave,cAlias)
		
		// CRIA A QUERY PARA INSERIR OS REGISTROS
		
		IF !U_E0105EXT(clTabWMS, alCmpChave, alValChave )
			clQuery := U_EXESQL105(1,alCampos,alValInc,clTabWMS)
		Else
			clQuery := U_EXESQL105(2,alCampos,alValInc,clTabWMS,alCmpChave,alValChave)
		EndIF
		
		If !Empty(clQuery)
			If TcSqlExec(clQuery) >= 0
				TcSqlExec("COMMIT")
			EndIf
		EndIf
		
		(cAlias)->(DBSkip())
	EndDO
	(cAlias)->(DBCloseArea())
	
EndIF

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ EXESQL105   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta a query para inserir os registros no banco do WMS	  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function EXESQL105(nlOpc,aCampos,aValProd,cTabela,aCmpChave,aValChave,lFrete)

Local clUsrBD	:= 	""
Local clSql		:= ""
Local clVirgula	:= ","
Local clAnd		:= " AND "
Default lFrete	:= .F.

If lFrete
	clUsrBD := U_MyNewSX6(	"NCG_000033", ;
	"", ;
	"C", ;
	"Usuแrio para acessar a base do Fretes",;
	"Usuแrio para acessar a base do Fretes",;
	"Usuแrio para acessar a base do Fretes",;
	.F. )
Else
	clUsrBD := U_MyNewSX6(	"NCG_000019", ;
	"", ;
	"C", ;
	"Usuแrio para acessar a base do WMS",;
	"Usuแrio para acessar a base do WMS",;
	"Usuแrio para acessar a base do WMS",;
	.F. )
EndIF

If nlOpc == 1 //Insert
	
	clSql	:= " INSERT INTO " +ALLTRIM(clUsrBD)+"."+ ALLTRIM(UPPER(cTabela)) + " ( " + CRLF
	
	For nlCont1 := 1 To Len(aCampos)
		
		clSql += Iif(nlCont1 > 1 , clVirgula , "") + aCampos[nlCont1] + CRLF
		
	Next nlCont1
	
	clSql	+= ") " + CRLF
	
	clSql	+= " VALUES (" + CRLF
	
	For nlCont2 := 1 To Len(aValProd)
		clSql	+= Iif(nlCont2 > 1 , clVirgula , "") + E0105VAL(aValProd[nlCont2]) + CRLF
	Next nlCont2
	
	clSql	+= ") "
ElseIf nlOpc == 2 //Update
	
	clSql	:= " UPDATE " +ALLTRIM(clUsrBD)+"."+ALLTRIM(UPPER(cTabela)) + " SET " + CRLF
	
	If Len(aCampos)<>Len(aValProd)
		PtInternal(1,"Erro")
	EndIf
	
	
	For nlCont1 := 1 To Len(aCampos)
		
		clSql	+= 	Iif(nlCont1 > 1 , clVirgula , "") + aCampos[nlCont1] + " = " + E0105VAL(aValProd[nlCont1]) + CRLF
		
	Next nlCont1
	
	If Len(aCmpChave) > 0
		
		clSql	+=	" WHERE " + CRLF
		
		For nlCont1	:= 1 To Len(aCmpChave)
			clSql	+=	Iif(nlCont1 > 1 , clAnd , "") + aCmpChave[nlCont1] + " = " + E0105VAL(aValChave[nlCont1]) + CRLF
		Next nlCont1
		
	EndIf
	
ElseIf nlOpc == 3 //Delete
	
	clSql	:= " DELETE FROM " +ALLTRIM(clUsrBD)+"."+ALLTRIM(UPPER(cTabela)) + CRLF
	
	If Len(aCmpChave) > 0
		
		clSql	+=	" WHERE " + CRLF
		
		For nlCont1	:= 1 To Len(aCmpChave)
			clSql	+=	Iif(nlCont1 > 1 , clAnd , "") + aCmpChave[nlCont1] + " = " + E0105VAL(aValChave[nlCont1]) + CRLF
		Next nlCont1
		
	EndIf
ElseIF nlOpc == 4 //Deleta todas informa็๕es da tabela
	clSql	:= " DELETE FROM " +ALLTRIM(clUsrBD)+"."+ALLTRIM(UPPER(cTabela))
EndIf

Return(clSql)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0105VAL   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Transforme para caracter									  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function E0105VAL(xlVal)

Local xlRet

If ValType(xlVal) == "C"
	If UPPER(Substr(xlVal,1,7)) <> 'TO_DATE'
		xlVal	:= E0105CHR(xlVal)
		xlRet	:=	"'" + Iif(Len(xlVal)==0,Space(1),xlVal)  + "'"
	Else
		xlRet := xlVal
	EndIF
ElseIf ValType(xlVal) == "N"
	xlRet	:=	AllTrim(Str(xlVal))
ElseIf ValType(xlVal) == "D"
	xlRet	:=	"'" + dTos(xlVal) + "'"
EndIf

Return(xlRet)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0105CHR   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retira os caracteres especiais							  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function E0105CHR(clComChar)
Local clSemChar		:=	clComChar

clSemChar	:=	 StrTran(clSemChar,"'","")
clSemChar	:=	 StrTran(clSemChar,'"',"")
clSemChar	:=	 StrTran(clSemChar,"ด","")
clSemChar	:=	 StrTran(clSemChar,"`","")

Return(clSemChar)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ E0105EXT   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Verifica no WMS se o registro jแ existe				  บฑฑ
ฑฑบ          ณ 		                                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function E0105EXT(clTabela, alCampos, alDados,lFrete)

Local llExiste		:= .T.
Local clSql	   		:= ""
Local clAlias		:= GetNextAlias()
Local nlCont1		:= 1
Local clAnd			:= " AND "
Local clUserBd		:= ''

Default lFrete		:= .F.

If lFrete
	clUserBd := U_MyNewSX6(	"NCG_000033", ;
	"", ;
	"C", ;
	"Usuแrio para acessar a base do Fretes",;
	"Usuแrio para acessar a base do Fretes",;
	"Usuแrio para acessar a base do Fretes",;
	.F. )
Else
	clUserBd := U_MyNewSX6(	"NCG_000019", ;
	"", ;
	"C", ;
	"Usuแrio para acessar a base do WMS",;
	"Usuแrio para acessar a base do WMS",;
	"Usuแrio para acessar a base do WMS",;
	.F. )
EndIF

clSql += " SELECT * FROM " +clUserBd+"."+ UPPER(clTabela)
clSql += " WHERE "

For nlCont1 := 1 To Len(alCampos)
	
	If ValType(alDados[nlCont1]) == "C"
		If clTabela == "TB_WMSINTERF_DOC_SAIDA_ITENS" .OR. clTabela == "TB_WMSINTERF_DOC_ENTRADA_ITENS"
			clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = '" +  alDados[nlCont1] + "' "
		Else
			clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = '" +  ALLTRIM(alDados[nlCont1]) + "' "
		EndIF
	ElseIf ValType(alDados[nlCont1]) == "N"
		
		clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = " +  AllTrim(Str(alDados[nlCont1]))
		
	ElseIf ValType(alDados[nlCont1]) == "D"
		
		clSql += Iif(nlCont1>1,clAnd," ") + alCampos[nlCont1] + " = " +  dTos(alDados[nlCont1]) + "' "
		
	EndIf
	
Next nlCont1

DbUseArea(.T.,"TOPCONN",TcGenQry(,,clSql),clAlias,.F.,.T.)

DbSelectArea(clAlias)

(clAlias)->(DbGoTop())

If (clAlias)->(!Eof()) .And. (clAlias)->(!Bof())
	llExiste 	:= .T.
Else
	llExiste	:= .F.
EndIf

(clAlias)->(DbCloseArea())

Return(llExiste)



/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ F105RETCMP   บAutor  ณ Tiago Bizan  	 บ Data ณ  08/12/12	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna campos e dados para cria็ใo das querys			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 						                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function F105RETCMP(cTab,lCampo,clTabWMS,alCmpChave,alValChave,cAlias,cTipo,cChaveP0A,cTemModal,lEcommerce)
Local aAreaAtu		:=GetArea()
Local alDados	:= {}
Local clTipo	:= ""
Local cArmWMS		:= ""
Local cMVARMWMAS	:= ALLTRIM(SuperGetMV("MV_ARMWMAS",.F.,'01'))
Local cIntDireta	:= "N"
Local cAliasCros	:= GetNextAlias()
Local nVolume		:= 0
Local nVol3			:= 0
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore:=(cFilAnt$cFilStore)



Default clTabWMS	:= ''
Default alCmpChave	:= {}
Default alValChave	:= {}
Default cAlias		:= ""
Default cTipo		:= ""

Default cTemModal:=""
Default lEcommerce:=.F.

If cTipo <> "3"
	If cTab == "B1P"
		If lCampo
			AADD(alDados  ,"PROD_COD_DEPOSITO")
			AADD(alDados  ,"PROD_COD_DEPOSITANTE")
			AADD(alDados  ,"PROD_CODIGO")
			AADD(alDados  ,"PROD_CODIGO_ALTERNATIVO")
			AADD(alDados  ,"PROD_DESCRICAO")
			AADD(alDados  ,"PROD_COD_UM")
			AADD(alDados  ,"PROD_PESO_LIQ")
			AADD(alDados  ,"PROD_PESO_BRUTO")
			AADD(alDados  ,"PROD_CLASSE_ABC") //A SER CADASTRADO " WMS
			AADD(alDados  ,"PROD_COD_CLASSE_PRODUTO")
			AADD(alDados  ,"PROD_VALIDADE_DIA") //nao utilizado
			AADD(alDados  ,"STATUS") //'NP'
			AADD(alDados,"DESC_ERRO")
			//AADD(alDados,"PROD_ESTQ_MIN") a ser cadastrado no WMS
			//AADD(alDados,"PROD_ESTQ_MIN_ESTANT") a ser cadastrado no WMS
		Else
			clTabWMS	:= 'TB_WMSINTERF_PRODUTO'
			nlDep 		:= 1
			nlDeptante	:= 3
			nCategoria:=0
			If (cAlias)->B1_CATEG=="A"
				nCategoria:=1
			ElseIf (cAlias)->B1_CATEG=="A"
				nCategoria:=2
			ElseIf (cAlias)->B1_CATEG=="X"
				nCategoria:=3
			ElseIf (cAlias)->B1_CATEG=="Z"
				nCategoria:=4
			EndIf
			
			AADD(alDados,nlDep)
			AADD(alDados,nlDeptante)
			AADD(alDados,ALLTRIM((cAlias)->B1_COD))
			AADD(alDados,ALLTRIM((cAlias)->B1_COD))
			AADD(alDados,SUBSTR(ALLTRIM((cAlias)->B1_XDESC),1,50))
			AADD(alDados,ALLTRIM((cAlias)->B1_UM))
			AADD(alDados,(cAlias)->B1_PESO)
			AADD(alDados,(cAlias)->B1_PESBRU)
			AADD(alDados,"A") //CLASSE DO PRODUTO
			AADD(alDados,nCategoria)
			AADD(alDados,0)
			AADD(alDados,'NP')
			AADD(alDados,"")
			//AADD(alDados,(cAlias)->)
			//AADD(alDados,(cAlias)->)
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"PROD_COD_DEPOSITO")
			AADD(alCmpChave,"PROD_COD_DEPOSITANTE")
			AADD(alCmpChave,"PROD_CODIGO")
			
			AADD(alValChave,nlDep)
			AADD(alValChave,nlDeptante)
			AADD(alValChave,ALLTRIM((cAlias)->B1_COD))
		EndIF
	ElseIF cTab == "B1E"
		If lCampo
			AADD(alDados  ,"EMBA_COD_DEPOSITO")
			AADD(alDados  ,"EMBA_COD_DEPOSITANTE")
			AADD(alDados  ,"EMBA_COD_PRODUTO")
			AADD(alDados  ,"EMBA_COD_EMBALAGEM")
			AADD(alDados  ,"EMBA_QTDE_EMBALAGEM")
			AADD(alDados  ,"EMBA_COD_UC")
			AADD(alDados  ,"EMBA_QTDE_UC")
			AADD(alDados  ,"EMBA_COD_UA")
			AADD(alDados  ,"EMBA_EMPILHAMENTO_MAX")
			AADD(alDados  ,"EMBA_ALTURA")
			AADD(alDados  ,"EMBA_LARGURA")
			AADD(alDados  ,"EMBA_COMPRIMENTO")
			AADD(alDados  ,"EMBA_CUBAGEM")
			AADD(alDados  ,"EMBA_TIPO")
			AADD(alDados  ,"STATUS")
			//AADD(alDados  ,"DESC_ERRO")
		Else
			clTabWMS	:= 'TB_WMSINTERF_EMBALAGENS'
			nlDep 		:= 1
			nlDeptante	:= 3
			nlQtdEm		:= 1
			nlCubagem	:= (cAlias)->B1_ALT*(cAlias)->B1_LARGURA*(cAlias)->B1_PROF
			clTipo		:= '1'
			
			AADD(alDados,nlDep)
			AADD(alDados,nlDeptante)
			AADD(alDados,ALLTRIM((cAlias)->B1_COD))
			AADD(alDados,ALLTRIM((cAlias)->B1_CODBAR))
			AADD(alDados,nlQtdEm)
			AADD(alDados,"1")
			AADD(alDados,10)
			AADD(alDados,"1")
			AADD(alDados,0)
			AADD(alDados,(cAlias)->B1_ALT)
			AADD(alDados,(cAlias)->B1_LARGURA)
			AADD(alDados,(cAlias)->B1_PROF)
			AADD(alDados,nlCubagem)
			AADD(alDados,clTipo)
			AADD(alDados,'NP')
			//AADD(alDados,(cAlias)->)
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"EMBA_COD_DEPOSITO")
			AADD(alCmpChave,"EMBA_COD_DEPOSITANTE")
			AADD(alCmpChave,"EMBA_COD_PRODUTO")
			AADD(alCmpChave,"EMBA_COD_EMBALAGEM")
			
			AADD(alValChave,nlDep)
			AADD(alValChave,nlDeptante)
			AADD(alValChave,ALLTRIM((cAlias)->B1_COD))
			AADD(alValChave,ALLTRIM((cAlias)->B1_CODBAR))
		EndIF
	ElseIF cTab == 'ZZ'
		If lCampo
			AADD(alDados  ,"TE_DEPOSITO")
			AADD(alDados  ,"TE_CODIGO")
			AADD(alDados  ,"TE_DESCRICAO")
			AADD(alDados  ,"STATUS")
			AADD(alDados  ,"DESC_ERRO")
		Else
			clTabWMS	:= 'TB_WMSINTERF_TIPO_ESTOQUE'
			nlDep		:= 1
			
			AADD(alDados,nlDep)
			AADD(alDados,ALLTRIM((cAlias)->X5_CHAVE))
			AADD(alDados,SUBSTR(ALLTRIM((cAlias)->X5_CHAVE+"-"+ALLTRIM((cAlias)->X5_DESCRI)),1,49)) //ALLTRIM((cAlias)->X5_DESCRI))
			AADD(alDados,'NP')
			AADD(alDados,"")
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"TE_DEPOSITO")
			AADD(alCmpChave,"TE_CODIGO")
			
			AADD(alValChave,nlDep)
			AADD(alValChave,ALLTRIM((cAlias)->X5_CHAVE))
			
		EndIF
	ElseIF cTab == 'SAH'
		If lCampo
			AADD(alDados,"UM_COD_DEPOSITO")
			AADD(alDados,"UM_COD_DEPOSITANTE")
			AADD(alDados,"UM_UNIDADE_MEDIDA")
			AADD(alDados,"UM_DESCRICAO")
			AADD(alDados,"UM_CASA_DECIMAL")
			AADD(alDados,"STATUS")
			AADD(alDados,"DESC_ERRO")
		Else
			clTabWMS	:= "TB_WMSINTERF_UNIDADE_MEDIDA"
			nlDep 		:= 1
			nlDeptante	:= 3
			
			AADD(alDados,nlDep)
			AADD(alDados,nlDeptante)
			AADD(alDados,ALLTRIM((cAlias)->AH_UNIMED))
			AADD(alDados,ALLTRIM((cAlias)->AH_DESCPO))
			AADD(alDados,0)
			AADD(alDados,'NP')
			AADD(alDados,"")
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"UM_COD_DEPOSITO")
			AADD(alCmpChave,"UM_COD_DEPOSITANTE")
			AADD(alCmpChave,"UM_UNIDADE_MEDIDA")
			
			AADD(alValChave,nlDep)
			AADD(alValChave,nlDeptante)
			AADD(alValChave,ALLTRIM((cAlias)->AH_UNIMED))
			
		EndIF
	ElseIf cTab == 'SC5'
		If lCampo
			AADD(alDados,"DPCS_COD_DEPOSITO")				// 1
			AADD(alDados,"DPCS_COD_DEPOSITANTE")			// 2
			AADD(alDados,"DPCS_NUM_DOCUMENTO")				// 3
			AADD(alDados,"DPCS_SERIE_DOCUMENTO")			// 4
			AADD(alDados,"DPCS_TIPO_DOCUMENTO")				// 5
			AADD(alDados,"DPCS_DATA_EMISSAO")				// 6
			AADD(alDados,"DPCS_PESO")						// 7
			AADD(alDados,"DPCS_VALOR")				   		// 8
			AADD(alDados,"DPCS_COD_CLIENTE")				// 9
			AADD(alDados,"DPCS_CNPJ_CLIENTE")				// 10
			AADD(alDados,"DPCS_DESCRICAO_CLIENTE")			// 11
			AADD(alDados,"DPCS_ENDERECO_CLIENTE")			// 12
			AADD(alDados,"DPCS_CEP_CLIENTE")				// 13
			AADD(alDados,"DPCS_BAIRRO_CLIENTE")				// 14
			AADD(alDados,"DPCS_MUNICIPIO_CLIENTE")			// 15
			//AADD(alDados,"DPCS_NUMERO_CLIENTE")			// 16
			AADD(alDados,"DPCS_COMPLEMENTO_CLIENTE")		// 17
			AADD(alDados,"DPCS_IE_CLIENTE")			   		// 18
			AADD(alDados,"DPCS_FONE_CLIENTE")				// 19
			AADD(alDados,"DPCS_CONTATO_CLIENTE")			// 20
			AADD(alDados,"DPCS_IS_CLIENTE")					// 21
			AADD(alDados,"DPCS_COD_TRANSPORTADOR")			// 22
			AADD(alDados,"DPCS_DOCA_AGEND_CLIENTE")			// 23
			AADD(alDados,"DPCS_N_SORTER_CLIENTE")			// 24
			AADD(alDados,"DPCS_CNPJ_TRANSPORTADOR")			// 25
			AADD(alDados,"DPCS_DESC_TRANSPORTADOR")			// 26
			AADD(alDados,"STATUS")							// 27
			AADD(alDados,"DESC_ERRO")						// 28
			AADD(alDados,"DPCS_MOD_DOC")					// 29
			AADD(alDados,"DPCS_COD_ERP")					// 30
			AADD(alDados,"DPCS_COD_CHAVE")					// 31
			AADD(alDados,"DPCS_DOC_CROSS")					// 32
			AADD(alDados,"DPCS_DOC_TRANSFERENCIA")			// 33
			AADD(alDados,"DPCS_SERIE_TRANSFERENCIA")		// 34
			AADD(alDados,"DPCS_COD_FILIAL")					// 35
			AADD(alDados,"DPCS_COD_CHAVE_TRANS")			// 36
			AADD(alDados,"DPCS_NATUREZA_NOTAS")		 		// 37
		Else
			clTabWMS	:= "TB_WMSINTERF_DOC_SAIDA"
			
			lEcommerce	:=  Iif((cAlias)->C5_XECOMER=="C", .T., .F.  )
			nPesoWMS	:= Pesoc9((cAlias)->C5_NUM)
			If !Empty((cAlias)->C5_YCHCROS)
				                                     
				//O campo A1_YCODWMS receberแ apenas 0, devido nใo ser utilizado no WMS. Obs. caso retorne a regra, retirar o 0 da query.
				cQryCross	:= " SELECT C5_YCHCROS, 0 A1_YCODWMS,C5_XECOMER,A1_CGC,C5_NOMCLI,A1_END,A1_CEP,A1_BAIRRO,A1_EST,A1_MUN,A1_COMPLEM,C5_XECOMER, "+CRLF
				cQryCross	+= " A1_INSCR,A1_TEL,A1_CONTATO,A1_SUFRAMA,A4_YCODWMS,A4_CGC,A4_NOME,A1_AGEND,A1_XSORTER,C5_CLIENTE,C5_LOJACLI, "+CRLF
				cQryCross	+= " C5_FILIAL,C5_NUM, A1_TEMODAL, "+CRLF
				cQryCross	+= " C5_CLIENT,C5_LOJAENT, C5_XOPPAC,C5_TIPO "+CRLF
				cQryCross	+= " FROM SC5010 C5, SA1010 A1, SA4010 A4 "+CRLF
				cQryCross	+= " WHERE C5.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND A4.D_E_L_E_T_ = ' '"+CRLF
				cQryCross	+= " AND C5_FILIAL = '"+SUBSTR((cAlias)->C5_YCHCROS,1,2)+"' "+CRLF
				cQryCross	+= " AND A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
				cQryCross	+= " AND A4_FILIAL = '"+xFilial("SA4")+"' "+CRLF
				cQryCross	+= " AND C5_NUM = '"+SUBSTR((cAlias)->C5_YCHCROS,3,6)+"' "+CRLF
				cQryCross	+= " AND C5_CLIENT = A1_COD AND C5_LOJAENT = A1_LOJA "+CRLF
				cQryCross	+= " AND C5_TRANSP = A4_COD "+CRLF
				Iif(Select(cAliasCros) > 0,(cAliasCros)->(dbCloseArea()),Nil)
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryCross),cAliasCros,.F.,.T.)
				
				AADD(alDados,1)														// 1
				AADD(alDados,3)									// 2
				AADD(alDados,ALLTRIM((cAlias)->C5_YCHCROS))						// 3
				AADD(alDados,"PED")						// 4
				AADD(alDados,(cAliasCros)->C5_XECOMER)								// 5
				AADD(alDados,substr(DTOS(DATE()),7,2)+"/"+substr(DTOS(DATE()),5,2)+"/"+substr(DTOS(DATE()),1,4) ) // 6
				AADD(alDados,nPesoWMS)	   											// 7
				AADD(alDados,(cAlias)->C6_TOTAL)									// 8
				AADD(alDados,/*(cAliasCros)->A1_YCODWMS*/0)									// 9
				AADD(alDados,ALLTRIM((cAliasCros)->A1_CGC))								// 10
				AADD(alDados,SUBSTR(ALLTRIM((cAliasCros)->C5_NOMCLI),1,40) )			// 11
				AADD(alDados,SUBSTR(ALLTRIM((cAliasCros)->A1_END),1,50) )				// 12
				AADD(alDados,ALLTRIM((cAliasCros)->A1_CEP))								// 13
				AADD(alDados,SUBSTR(ALLTRIM((cAliasCros)->A1_BAIRRO),1,15) )			// 14
				AADD(alDados,SUBSTR(ALLTRIM((cAliasCros)->A1_EST)+"-"+ALLTRIM((cAliasCros)->A1_MUN),1,30))				// 15
				//AADD(alDados,ALLTRIM((cAlias)->))									// 16
				AADD(alDados,ALLTRIM((cAliasCros)->A1_COMPLEM))			   				// 17
				AADD(alDados,ALLTRIM((cAliasCros)->A1_INSCR))			   				// 18
				AADD(alDados,ALLTRIM((cAliasCros)->A1_TEL))			   					// 19
				AADD(alDados,ALLTRIM((cAliasCros)->A1_CONTATO))				   			// 20
				AADD(alDados,ALLTRIM((cAliasCros)->A1_SUFRAMA))							// 21
				
				
				
				If ( (cAliasCros)->A1_TEMODAL == '1' .And. !lEcommerce) .Or. lEcommerce
					cTemModal	:= (cAliasCros)->A1_TEMODAL
					nlForn := (cAliasCros)->A4_YCODWMS
					clCgc	:= (cAliasCros)->A4_CGC
					clNome	:= ALLTRIM((cAliasCros)->A4_NOME)
					clTipo := 'NP'
				Else
					nlForn	:= 0
					clCgc	:= " "
					clNome	:= " "
					clTipo	:= 'FR'
				EndIF
				AADD(alDados,nlForn)												// 22
				AADD(alDados,IIF(ALLTRIM((cAliasCros)->A1_AGEND)=='1','S','N'))			// 23
				AADD(alDados,IIF(ALLTRIM((cAliasCros)->A1_XSORTER)=='1','S','N'))		// 24
				AADD(alDados,clCgc)											   		// 25
				AADD(alDados,clNome)												// 26
				AADD(alDados,clTipo)			   									// 27
				AADD(alDados,"")							   						// 28
				AADD(alDados,"0055")												// 29
				AADD(alDados,'C'+ALLTRIM((cAliasCros)->C5_CLIENT)+ALLTRIM((cAliasCros)->C5_LOJAENT))	// 30
				AADD(alDados,(cAlias)->C5_FILIAL+(cAlias)->C5_NUM)					// 31
				AADD(alDados,"S")													// 32
				AADD(alDados,(cAlias)->C5_NUM)										// 33
				AADD(alDados,"PED")													// 34
				AADD(alDados,SUBSTR((cAlias)->C5_YCHCROS,1,2))						// 35
				AADD(alDados,(cAlias)->C5_FILIAL+(cAlias)->C5_NUM)					// 36
				AADD(alDados,(cAliasCros)->C5_XOPPAC)								// 37
				
				(cAliasCros)->(dbCloseArea())
				
				
			Else
				cEndSA1:=ALLTRIM((cAlias)->A1_END)
				cBairSA1:=ALLTRIM((cAlias)->A1_BAIRRO)
				cCepSA1:=ALLTRIM((cAlias)->A1_CEP)
				cMumSA1:=ALLTRIM((cAlias)->A1_MUN)
				cEstSA1:=ALLTRIM((cAlias)->A1_EST)
				cComplemSA1:=ALLTRIM((cAlias)->A1_COMPLEM)
				
				If lEcommerce 
					U_COM05EndEnt((cAlias)->C5_NUM,@cEndSA1,@cBairSA1,@cCepSA1,@cMumSA1,@cEstSA1,@cComplemSA1,.F.)
				Endif
				AADD(alDados,1)														// 1
				AADD(alDados,3)									// 2
				AADD(alDados,ALLTRIM((cAlias)->C5_NUM))								// 3
				AADD(alDados,"PED")													// 4
				AADD(alDados,(cAlias)->C5_XECOMER)									// 5
				AADD(alDados,substr(DTOS(DATE()),7,2)+"/"+substr(DTOS(DATE()),5,2)+"/"+substr(DTOS(DATE()),1,4) ) // 6
				AADD(alDados,nPesoWMS)	   											// 7
				AADD(alDados,(cAlias)->C6_TOTAL)									// 8
				AADD(alDados,/*(cAlias)->A1_YCODWMS*/ 0)									// 9
				AADD(alDados,ALLTRIM((cAlias)->A1_CGC))								// 10
				AADD(alDados,SUBSTR(ALLTRIM((cAlias)->C5_NOMCLI),1,40) )			// 11
				AADD(alDados,SUBSTR(cEndSA1,1,50) )				// 12
				AADD(alDados,ALLTRIM(cCepSA1))								// 13
				AADD(alDados,SUBSTR(cBairSA1,1,15) )			// 14
				AADD(alDados,SUBSTR(cEstSA1+"-"+cMumSA1,1,30))				// 15
				//AADD(alDados,ALLTRIM((cAlias)->))									// 16
				AADD(alDados,cComplemSA1)			   				// 17
				AADD(alDados,ALLTRIM((cAlias)->A1_INSCR))			   				// 18
				AADD(alDados,ALLTRIM((cAlias)->A1_TEL))			   					// 19
				AADD(alDados,ALLTRIM((cAlias)->A1_CONTATO))				   			// 20
				AADD(alDados,ALLTRIM((cAlias)->A1_SUFRAMA))							// 21
				
				
				
				cTemModal	:= (cAlias)->A1_TEMODAL
				
				If ( (cAlias)->A1_TEMODAL == '1'  .And. !lEcommerce ) .Or. lEcommerce
					cTemModal	:= (cAlias)->A1_TEMODAL
					nlForn	 	:= (cAlias)->A4_YCODWMS
					clCgc			:= (cAlias)->A4_CGC
					clNome		:= ALLTRIM((cAlias)->A4_NOME)
					clTipo 		:= 'NP'
				Else
					nlForn		:= 0
					clCgc			:= " "
					clNome		:= " "
					clTipo		:= 'FR'
				EndIF
				AADD(alDados,nlForn)												// 22
				AADD(alDados,IIF(ALLTRIM((cAlias)->A1_AGEND)=='1','S','N'))			// 23
				AADD(alDados,IIF(ALLTRIM((cAlias)->A1_XSORTER)=='1','S','N'))		// 24
				AADD(alDados,clCgc)											   		// 25
				AADD(alDados,clNome)												// 26
				AADD(alDados,clTipo)			   									// 27
				AADD(alDados,"")							   						// 28
				AADD(alDados,"0055")												// 29
				AADD(alDados,'C'+ALLTRIM((cAlias)->C5_CLIENT)+ALLTRIM((cAlias)->C5_LOJAENT))	// 30
				AADD(alDados,(cAlias)->C5_FILIAL+(cAlias)->C5_NUM)					// 31
				AADD(alDados,"N")													// 32
				AADD(alDados,"")													// 33
				AADD(alDados,"")													// 34
				AADD(alDados,"")													// 35
				AADD(alDados,"")													// 36
				AADD(alDados,(cAlias)->C5_XOPPAC)									// 37
			EndIf
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"DPCS_COD_CHAVE")
			AADD(alValChave,(cAlias)->C5_FILIAL+(cAlias)->C5_NUM)
			//AADD(alValChave,alDados[LEN(alDados)])
			
		EndIF
	ElseIF cTab == 'SC6'
		If lCampo
			AADD(alDados,"DPIS_COD_DEPOSITO")
			AADD(alDados,"DPIS_COD_DEPOSITANTE")
			AADD(alDados,"DPIS_NUM_DOCUMENTO")
			AADD(alDados,"DPIS_SERIE_DOCUMENTO")
			AADD(alDados,"DPIS_DATA_EMISSAO")
			AADD(alDados,"DPIS_PESO_ITEM")
			AADD(alDados,"DPIS_VALOR_ITEM")
			AADD(alDados,"DPIS_ICMS_ALIQUOTA")
			AADD(alDados,"DPIS_COD_PRODUTO")
			AADD(alDados,"DPIS_LOTE")
			AADD(alDados,"DPIS_COD_TIPO_ESTOQUE")
			AADD(alDados,"DPIS_QTDE")
			AADD(alDados,"STATUS")
			AADD(alDados,"DESC_ERRO")
			AADD(alDados,"DPIS_MOD_DOC")
			AADD(alDados,"DPIS_COD_CHAVE")
		Else
			clTabWMS	:= "TB_WMSINTERF_DOC_SAIDA_ITENS"
			
			cQryCross	:= " SELECT C5_YCHCROS FROM SC5010 WHERE D_E_L_E_T_ = ' ' AND C5_NUM = '"+(cAlias)->C6_NUM+"' AND C5_FILIAL = '"+xFilial("SC6")+"' "
			Iif(Select(cAliasCros) > 0,(cAliasCros)->(dbCloseArea()),Nil)
			DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryCross),cAliasCros,.F.,.T.)
			If !Empty((cAliasCros)->C5_YCHCROS)
				cNumPVC6	:= (cAliasCros)->C5_YCHCROS
				cSerPvC6	:= "PED" //TEM QUE SER PED DEVIDO ภ EXIGสNCIA NO WMS
			Else
				cNumPVC6	:= (cAlias)->C6_NUM
				cSerPvC6	:= "PED"
			EndIf
			(cAliasCros)->(dbCloseArea())
			
			AADD(alDados,1)
			AADD(alDados,3)
			AADD(alDados,cNumPVC6)
			AADD(alDados,cSerPvC6)
			AADD(alDados,substr(DTOS(DATE()),7,2)+"/"+substr(DTOS(DATE()),5,2)+"/"+substr(DTOS(DATE()),1,4) )
			AADD(alDados,(cAlias)->B1_PESBRU)
			AADD(alDados,(cAlias)->C6_VALOR)
			AADD(alDados,0)
			AADD(alDados,ALLTRIM((cAlias)->C6_PRODUTO))
			AADD(alDados,"")
			AADD(alDados,(cAlias)->C6_LOCAL)
			AADD(alDados,(cAlias)->C9_QTDLIB)
			AADD(alDados,'NP')
			AADD(alDados,"")
			AADD(alDados,'0055')
			AADD(alDados,alltrim(cChaveP0A))
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"DPIS_COD_CHAVE")
			
			AADD(alValChave,alDados[LEN(alDados)])
		EndIF
	ElseIF cTab == 'TRS'
		If lCampo
			AADD(alDados,"TRS_COD_DEPOSITO")			// 1
			AADD(alDados,"TRS_COD_DEPOSITANTE")			// 2
			AADD(alDados,"TRS_NUM_DOCUMENTO")			// 3
			AADD(alDados,"TRS_SERIE_DOCUMENTO")			// 4
			AADD(alDados,"TRS_TIPO_DOCUMENTO")			// 5
			AADD(alDados,"TRS_DATA_EMISSAO")			// 6
			AADD(alDados,"TRS_PESO")					// 7
			AADD(alDados,"TRS_VALOR")					// 8
			AADD(alDados,"TRS_COD_CLIENTE")		   		// 9
			AADD(alDados,"TRS_CNPJ_CLIENTE")			// 10
			AADD(alDados,"TRS_DESCRICAO_CLIENTE")		// 11
			AADD(alDados,"TRS_ENDERECO_CLIENTE")		// 12
			AADD(alDados,"TRS_CEP_CLIENTE")		   		// 13
			AADD(alDados,"TRS_COD_TRANSPORADOR")		// 14
			AADD(alDados,"TRS_CNPJ_TRANSPORTADOR")		// 15
			AADD(alDados,"TRS_DESC_TRANSPORTADOR")		// 16
			AADD(alDados,"STATUS")						// 17
			AADD(alDados,"DESC_ERRO")		   			// 18
			AADD(alDados,"TRS_DOC_CROSS")	   			// 19
			AADD(alDados,"TRS_CNPJ_EMBARCADOR")			// 20
			AADD(alDados,"TRS_CNPJ_EMISSOR")		   	// 21
			AADD(alDados,"TRS_COD_CHAVE_TRANS")			// 22
			AADD(alDados,"TRS_NATUREZA_NOTAS")			// 23
			AADD(alDados,"TRS_SIGLA_UF")				// 24
		Else
			lEcommerce	:=  Iif((cAlias)->C5_XECOMER=="C", .T., .F.  )
			clTabWMS	:= "TB_FRTINTERF_DOC_SAIDA_TRANSP"
			
			nPesoWMS	:= Pesoc9((cAlias)->C5_NUM)
			If !Empty((cAlias)->C5_YCHCROS)    

				//O campo A1_YCODWMS receberแ apenas 0, devido nใo ser utilizado no WMS. Obs. caso retorne a regra, retirar o 0 da query.
				cQryCross	:= " SELECT C5_YCHCROS, 0 A1_YCODWMS,C5_XECOMER,A1_CGC,C5_NOMCLI,A1_END,A1_CEP,A1_BAIRRO,A1_EST,A1_MUN,A1_COMPLEM, "+CRLF
				cQryCross	+= " A1_INSCR,A1_TEL,A1_CONTATO,A1_SUFRAMA,A4_YCODWMS,A4_CGC,A4_NOME,A1_AGEND,A1_XSORTER,C5_CLIENTE,C5_LOJACLI, "+CRLF
				cQryCross	+= " C5_FILIAL,C5_NUM, "+CRLF
				cQryCross	+= " C5_CLIENT,C5_LOJAENT, A1_NREDUZ, C5_XOPPAC "+CRLF
				cQryCross	+= " FROM SC5010 C5, SA1010 A1, SA4010 A4 "+CRLF
				cQryCross	+= " WHERE C5.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND A4.D_E_L_E_T_ = ' '"+CRLF
				cQryCross	+= " AND C5_FILIAL = '"+SUBSTR((cAlias)->C5_YCHCROS,1,2)+"' "+CRLF
				cQryCross	+= " AND A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
				cQryCross	+= " AND A4_FILIAL = '"+xFilial("SA4")+"' "+CRLF
				cQryCross	+= " AND C5_NUM = '"+SUBSTR((cAlias)->C5_YCHCROS,3,6)+"' "+CRLF
				cQryCross	+= " AND C5_CLIENT = A1_COD AND C5_LOJAENT = A1_LOJA "+CRLF
				cQryCross	+= " AND C5_TRANSP = A4_COD "+CRLF
				Iif(Select(cAliasCros) > 0,(cAliasCros)->(dbCloseArea()),Nil)
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryCross),cAliasCros,.F.,.T.)
				
				AADD(alDados,1)											// 1
				AADD(alDados,3)						// 2
				AADD(alDados,ALLTRIM((cAlias)->C5_YCHCROS ))			// 3
				AADD(alDados,"PED")			// 4
				AADD(alDados,(cAliasCros)->C5_XECOMER)					// 5
				AADD(alDados,substr(DTOS(DATE()),7,2)+"/"+substr(DTOS(DATE()),5,2)+"/"+substr(DTOS(DATE()),1,4) )// 6
				AADD(alDados,nPesoWMS)									// 7
				AADD(alDados,(cAlias)->C6_TOTAL)						// 8
				AADD(alDados,/*(cAliasCros)->A1_YCODWMS*/ 0)					// 9
				AADD(alDados,ALLTRIM((cAliasCros)->A1_CGC))					// 10
				AADD(alDados,SUBSTR(ALLTRIM((cAliasCros)->A1_NREDUZ),1,40) )// 11
				AADD(alDados,SUBSTR(ALLTRIM((cAliasCros)->A1_END),1,50) )	// 12
				AADD(alDados,ALLTRIM((cAliasCros)->A1_CEP))					// 13
				AADD(alDados,0)											// 14
				AADD(alDados," ")										// 15
				AADD(alDados," ")										// 16
				AADD(alDados,"NP")										// 17
				AADD(alDados," ")										// 18
				AADD(alDados,"S")				   						// 19
				cYCGC	:= U_NCGC002(SUBSTR((cAlias)->C5_YCHCROS,1,2)) //Busca o CNPJ da Filial
				AADD(alDados,cYCGC)										// 20   -- preencher com o cnpj da filial do pedido de venda
				AADD(alDados,cYCGC)										// 21 	-- preencher com o cnpj da filial do pedido de venda
				AADD(alDados,(cAlias)->C5_FILIAL+(cAlias)->C5_NUM)		// 22
				AADD(alDados,(cAliasCros)->C5_XOPPAC)					// 23
				AADD(alDados,(cAliasCros)->A1_EST)						// 24
				
				(cAliasCros)->(dbCloseArea())
				
				
			Else
				
				AADD(alDados,1)											// 1
				AADD(alDados,3)											// 2
				AADD(alDados,ALLTRIM((cAlias)->C5_NUM ))				// 3
				AADD(alDados,"PED")										// 4
				AADD(alDados,(cAlias)->C5_XECOMER)						// 5
				AADD(alDados,substr(DTOS(DATE()),7,2)+"/"+substr(DTOS(DATE()),5,2)+"/"+substr(DTOS(DATE()),1,4) )// 6
				AADD(alDados,nPesoWMS)									// 7
				AADD(alDados,(cAlias)->C6_TOTAL)						// 8
				AADD(alDados,/*(cAlias)->A1_YCODWMS*/ 0)						// 9
				AADD(alDados,ALLTRIM((cAlias)->A1_CGC))					// 10
				AADD(alDados,SUBSTR(ALLTRIM((cAlias)->A1_NREDUZ),1,40) )// 11
				AADD(alDados,SUBSTR(ALLTRIM((cAlias)->A1_END),1,50) )	// 12
				AADD(alDados,ALLTRIM((cAlias)->A1_CEP))					// 13
				AADD(alDados,0)											// 14
				AADD(alDados," ")										// 15
				AADD(alDados," ")										// 16
				AADD(alDados,"NP")										// 17
				AADD(alDados," ")										// 18
				AADD(alDados,"N")				   						// 19
				cYCGC	:= U_NCGC002(xFilial("SC5")) 					//Busca o CNPJ da Filial
				AADD(alDados,cYCGC)										// 20
				AADD(alDados,cYCGC)  									// 21
				AADD(alDados,"")										// 22
				AADD(alDados,(cAlias)->C5_XOPPAC)						// 23
				AADD(alDados,(cAlias)->A1_EST)							// 24
			EndIf
		EndIF
	ElseIF cTab == 'SF1'
		If lCampo
			AADD(alDados,"DPCE_COD_DEPOSITO")				// 1
			AADD(alDados,"DPCE_COD_DEPOSITANTE")			// 2
			AADD(alDados,"DPCE_NUM_DOCUMENTO")				// 3
			AADD(alDados,"DPCE_SERIE_DOCUMENTO")			// 4
			AADD(alDados,"DPCE_TIPO_DOCUMENTO")				// 5
			AADD(alDados,"DPCE_DATA_EMISSAO")				// 6
			AADD(alDados,"DPCE_PESO")						// 7
			AADD(alDados,"DPCE_VALOR")						// 8
			AADD(alDados,"DPCE_COD_FORNECEDOR")				// 9
			AADD(alDados,"DPCE_CNPJ_FORNECEDOR")			// 10
			AADD(alDados,"DPCE_DESCRICAO_FORNECEDOR")		// 11
			AADD(alDados,"DPCE_COD_ERP")			   		// 12
			//AADD(alDados,"DPCE_PLACA_VEICULO")			// 13
			AADD(alDados,"STATUS")			   				// 14
			AADD(alDados,"DESC_ERRO")						// 15
			AADD(alDados,"DPCE_CHAVE_ACESSO")				// 16
			AADD(alDados,"DPCE_MOD_DOC")			   		// 17
			AADD(alDados,"DPCE_CFOP")						// 18
			AADD(alDados,"DPCE_ICMS_BASE")					// 19
			AADD(alDados,"DPCE_ICMS_VALOR")					// 20
			AADD(alDados,"DPCE_COD_CHAVE")					// 21
		Else
			clTabWMS	:= "TB_WMSINTERF_DOC_ENTRADA"
			
			AADD(alDados,1)											// 1
			AADD(alDados,3)											// 2
			AADD(alDados,ALLTRIM((cAlias)->F1_DOC ))				// 3
			AADD(alDados,ALLTRIM((cAlias)->F1_SERIE ))				// 4
			
			If ALLTRIM((cAlias)->F1_TIPO) == 'N' //pertence("NDIPBC") N=NORMAL D=DEVOLUวรO B=BENEFICIAMENTO
				clTipo := 'E'
			ElseIf ALLTRIM((cAlias)->F1_TIPO) == 'B'
				clTipo := 'D'
			EndIF
			AADD(alDados,IIF(!EMPTY(clTipo),clTipo,ALLTRIM((cAlias)->F1_TIPO )))														// 5
			AADD(alDados,substr((cAlias)->F1_EMISSAO,7,2)+"/"+substr((cAlias)->F1_EMISSAO,5,2)+"/"+substr((cAlias)->F1_EMISSAO,1,4) )	// 6
			AADD(alDados,(cAlias)->F1_PBRUTO )			   			// 7
			AADD(alDados,(cAlias)->F1_VALMERC )						// 8
			
			If (cAlias)->F1_TIPO $ "D/B"
				nYA2CODWMS	:= 0//getadvfval("SA1","A1_YCODWMS",xFilial("SA1")+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA,1,0)
				AADD(alDados,nYA2CODWMS)			// 9
			Else
				nYA2CODWMS	:= getadvfval("SA2","A2_YCODWMS",xFilial("SA2")+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA,1,0)
				AADD(alDados,nYA2CODWMS)			// 9
				//					AADD(alDados,ALLTRIM((cAlias)->F1_FORNECE ))			// 9
			EndIf
			
			
			clFornLoj	:= IIF( (cAlias)->F1_TIPO $ 'DB','C','F' )
			clFornLoj	+= ALLTRIM((cAlias)->F1_FORNECE)+ALLTRIM((cAlias)->F1_LOJA)
			clCGC		:= IIF( (cAlias)->F1_TIPO $ 'DB',ALLTRIM((cAlias)->A1_CGC), ALLTRIM((cAlias)->A2_CGC ) )
			
			AADD(alDados,IIF( (cAlias)->A2_EST == 'EX',ALLTRIM((cAlias)->F1_FORNECE)+ALLTRIM((cAlias)->F1_LOJA), IIF(empty(ALLTRIM(clCGC)),ALLTRIM((cAlias)->F1_FORNECE)+ALLTRIM((cAlias)->F1_LOJA),ALLTRIM(clCGC)) ) )		// 10
			AADD(alDados,IIF( (cAlias)->F1_TIPO $ 'DB',ALLTRIM((cAlias)->A1_NOME), ALLTRIM((cAlias)->A2_NOME ) ) )						// 11
			AADD(alDados,clFornLoj )								// 12
			//AADD(alDados,ALLTRIM((cAlias)-> ))					// 13
			AADD(alDados,'NP')										// 14
			AADD(alDados," ")			   							// 15
			AADD(alDados,ALLTRIM((cAlias)->CHVNFE ))				// 16
			AADD(alDados,'0055')									// 17
			//BUSCA O CFOP PREDOMINANTE NOS ITENS
			clCFOP := FBUSCACFOP((cAlias)->F1_FILIAL,(cAlias)->F1_DOC,(cAlias)->F1_SERIE,(cAlias)->F1_FORNECE,(cAlias)->F1_LOJA)
			AADD(alDados,VAl(ALLTRIM(clCFOP)) )			   			// 18
			AADD(alDados,(cAlias)->F1_BASEICM )			   			// 19
			AADD(alDados,(cAlias)->F1_VALICM )						// 20
			AADD(alDados,(cAlias)->F1_FILIAL+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA+IIF(empty((cAlias)->F1_FORMUL),"N",(cAlias)->F1_FORMUL) )						// 21
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"DPCE_COD_CHAVE")
			
			AADD(alValChave,alDados[LEN(alDados)])
			
		EndIF
	ElseIF cTab == 'SD1'
		If lCampo
			AADD(alDados,"DPIE_COD_DEPOSITO")
			AADD(alDados,"DPIE_COD_DEPOSITANTE")
			AADD(alDados,"DPIE_NUM_DOCUMENTO")
			AADD(alDados,"DPIE_SERIE_DOCUMENTO")
			AADD(alDados,"DPIE_DATA_EMISSAO")
			AADD(alDados,"DPIE_PESO_ITEM")
			AADD(alDados,"DPIE_VALOR_ITEM")
			AADD(alDados,"DPIE_ICMS_ALIQUOTA")
			AADD(alDados,"DPIE_COD_PRODUTO")
			AADD(alDados,"DPIE_LOTE")
			AADD(alDados,"DPIE_COD_TIPO_ESTOQUE")
			AADD(alDados,"DPIE_QTDE")
			AADD(alDados,"STATUS")
			AADD(alDados,"DESC_ERRO")
			AADD(alDados,"DPIE_MOD_DOC")
			AADD(alDados,"DPIE_ICMS_VALOR")
			AADD(alDados,"DPIE_COD_CHAVE")
			AADD(alDados,"DPIE_COD_ERP")
		Else
			clTabWMS	:= "TB_WMSINTERF_DOC_ENTRADA_ITENS"
			
			AADD(alDados,1)
			AADD(alDados,3)
			AADD(alDados,ALLTRIM((cAlias)->D1_DOC ))
			AADD(alDados,ALLTRIM((cAlias)->D1_SERIE ))
			AADD(alDados,substr((cAlias)->D1_EMISSAO,7,2)+"/"+substr((cAlias)->D1_EMISSAO,5,2)+"/"+substr((cAlias)->D1_EMISSAO,1,4) )
			AADD(alDados,(cAlias)->B1_PESBRU )
			AADD(alDados,(cAlias)->D1_TOTAL/(cAlias)->D1_QUANT)
			AADD(alDados,(cAlias)->D1_PICM )
			AADD(alDados,ALLTRIM((cAlias)->D1_COD ))
			AADD(alDados,"")
			AADD(alDados,VAL(ALLTRIM((cAlias)->D1_LOCAL)) )
			AADD(alDados,(cAlias)->D1_QUANT )
			AADD(alDados,"NP")
			AADD(alDados,"")
			AADD(alDados,"0055")
			AADD(alDados,(cAlias)->D1_VALICM )
			clFormu := (cAlias)->D1_FORMUL
			//				AADD(alDados,(cAlias)->D1_FILIAL+(cAlias)->D1_DOC+(cAlias)->D1_SERIE+(cAlias)->D1_FORNECE+(cAlias)->D1_LOJA+(cAlias)->D1_ITEM+IIF(EMPTY((cAlias)->D1_FORMUL),"N",D1_FORMUL) )
			AADD(alDados,alltrim(cChaveP0A) ) //troca
			clFornLoj	:= IIF( (cAlias)->D1_TIPO $ 'DB','C','F' )
			clFornLoj	+= ALLTRIM((cAlias)->D1_FORNECE)+ALLTRIM((cAlias)->D1_LOJA)
			AADD(alDados,clFornLoj )
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"DPIE_COD_CHAVE")
			
			AADD(alValChave,alDados[len(alDados)])
			
		EndIF
	ElseIF cTab == 'SF2' .OR. cTab == 'RNV'
		If lCampo
			AADD(alDados,"RNV_COD_DEPOSITO")	//1
			AADD(alDados,"RNV_COD_DEPOSITANTE")	//2
			AADD(alDados,"RNV_NUM_DOCUMENTO")	//3
			AADD(alDados,"RNV_SERIE_DOCUMENTO")	//4
			AADD(alDados,"RNV_TIPO_DOCUMENTO") 	//5
			AADD(alDados,"RNV_CNPJ_EMBARCADOR")	//6
			AADD(alDados,"RNV_NUM_NOTA_FISCAL")	//7
			AADD(alDados,"RNV_SERIE_NOTA_FISCAL")	//8
			AADD(alDados,"RNV_MODELO")				//9
			AADD(alDados,"RNV_FLAG_CANCELAMENTO")	//10
			AADD(alDados,"RNV_CNPJ_EMISSOR")		//11
			AADD(alDados,"RNV_CEP_NOTAS")			//12
			AADD(alDados,"RNV_SIGLA_UF")			//13
			AADD(alDados,"RNV_CNPJ_CLIENTE")		//14
			AADD(alDados,"RNV_RAZAOSOCIAL_CLIENTE")	//15
			AADD(alDados,"RNV_INSCRICAO_CLIENTE")	//16
			AADD(alDados,"RNV_CNPJ_FILIAISTRANSPORTE")	//17
			AADD(alDados,"RNV_DTEMISSAO_NOTAS")	//18
			AADD(alDados,"RNV_TIPOMOV_NOTAS")	//19
			AADD(alDados,"RNV_VALNOTA_NOTAS")	//20
			AADD(alDados,"RNV_VOL_NOTAS")		//21
			AADD(alDados,"RNV_TIPOFRETE_NOTAS")	//22
			AADD(alDados,"RNV_ENDERECO_NOTAS")	//23
			AADD(alDados,"RNV_BAIRRO_NOTAS")	//24
			AADD(alDados,"RNV_MUNICIPIO_NOTAS")	//25
			AADD(alDados,"RNV_PEDIDO_NFDESPACHADAS")	//26
			AADD(alDados,"RNV_PESO_NFDESPACHADAS")	//27
			AADD(alDados,"RNV_CENTROCUSTO_NFDESPACHADAS")	//28
			AADD(alDados,"RNV_PESOCUBADO_NOTAS")	//29
			AADD(alDados,"RNV_OBSERVACAO_NOTAS")	//30
			AADD(alDados,"RNV_NATUREZA_NOTAS")	//31
			AADD(alDados,"RNV_VOL3_NOTA")		//32
			AADD(alDados,"RNV_AGRUPADOR")		//33
			AADD(alDados,"RNV_DATA_ENTREGA")	//34
			AADD(alDados,"RNV_DATA_EXPEDICAO")	//35
			AADD(alDados,"RNV_DATA_PROG_ENTREGA")	//36
			AADD(alDados,"RNV_CHAVE_ACESSO_NFE")	//37
			AADD(alDados,"STATUS")					//38
			AADD(alDados,"DATA")					//39
			AADD(alDados,"HORA")					//40
			AADD(alDados,"DESC_ERRO")				//41
			AADD(alDados,"RNV_COD_CHAVE")			//42
			AADD(alDados,"RNV_IMP_DIRETA_FRETES")	//43
			AADD(alDados,"RNV_DOC_CROSS")			//44
			AADD(alDados,"RNV_COD_CHAVE_TRANS")		//45
			AADD(alDados,"RNV_NF_TRANSF")			//46
			
		Else
			clTabWMS	:= "TB_FRTINTERFNOTAS"
			
			AADD(alDados,1)
			//depositante
			If !alltrim((cAlias)->C5_YTRANS) $ "1/S" .and. !Empty((cAlias)->C5_YCHCROS)
				AADD(alDados,SUBSTR((cAlias)->C5_YCHCROS,1,2) )
				nVolume := 0
				nVol3	:= 0
				Pr105Vol3(@nVolume,@nVol3,(cAlias)->C5_YCHCROS)
			Else
				AADD(alDados,"03" )
				nVolume	:= (cAlias)->F2_VOLUME1
				nVol3	:= 0
			EndIf
			
			If ((cAlias)->F2_FILIAL $ "03*06") //somente a filial 03 tem o codigo do pedido de venda sem o codigo da filial
				AADD(alDados,(cAlias)->C5_NUM)
			Else
				AADD(alDados,(cAlias)->F2_FILIAL+(cAlias)->C5_NUM)
			EndIf
			AADD(alDados,"PED")
			AADD(alDados,(cAlias)->C5_XECOMER)		//5
			AADD(alDados,SM0->M0_CGC)
			AADD(alDados,(cAlias)->F2_DOC)
			AADD(alDados,(cAlias)->F2_SERIE)
			AADD(alDados,IIF(alltrim((cAlias)->ESPECIE) == 'SPED',"0055","1/1A"))
			AADD(alDados," ")				//10
			AADD(alDados,SM0->M0_CGC)
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_CEP,(cAlias)->A1_CEP))
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_EST,(cAlias)->A1_EST))
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_CGC,(cAlias)->A1_CGC))
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_NOME,(cAlias)->A1_NOME))				//15
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',Posicione('SA2',1,xFilial("SA2") + (cAlias)->F2_CLIENTE + (cAlias)->F2_LOJA,'A2_INSCR') ,(cAlias)->A1_INSCR))
			AADD(alDados,Posicione("SA4",1,xFilial("SA4")+(cAlias)->F2_TRANSP,"A4_CGC"))
			AADD(alDados,"to_date( '"+(cAlias)->F2_EMISSAO+"','YYYYMMDD')")
			AADD(alDados,"S")
			AADD(alDados,(cAlias)->F2_VALBRUT)					//20
			AADD(alDados,nVolume)					//RNV_VOL_NOTAS
			AADD(alDados,IIF((cAlias)->F2_TPFRETE=='C','1','2'))
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_END,(cAlias)->A1_END))
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_BAIRRO,(cAlias)->A1_BAIRRO))
			AADD(alDados,IIF((cAlias)->F2_TIPO $ 'DB',(cAlias)->A2_MUN,(cAlias)->A1_MUN))				//25
			AADD(alDados,(cAlias)->C5_NUM)
			AADD(alDados,(cAlias)->F2_PBRUTO)
			AADD(alDados," ")
			AADD(alDados,0)
			AADD(alDados," ")                                //30
			AADD(alDados,(cAlias)->C5_XOPPAC)
			AADD(alDados,nVol3) //RNV_VOL3_NOTA
			AADD(alDados,0)
			AADD(alDados," ")
			AADD(alDados," ")                               //35
			AADD(alDados," ")
			AADD(alDados,(cAlias)->CHVNFE)
			AADD(alDados,"NP" )
			AADD(alDados,DTOS(DATE()))
			AADD(alDados,STRTRAN(TIME(),":",""))				//40
			AADD(alDados," ")
			AADD(alDados,(cAlias)->F2_FILIAL+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA)
			//tratamento para integra็ใo direta com o FRETES - nใo hแ tratamento por item de pedido pois o campo estแ no cabe็alho da NF no fretes
			cArmWMS		:= getadvfval("SD2","D2_LOCAL",xFilial("SD2")+(cAlias)->F2_DOC+(cAlias)->F2_SERIE+(cAlias)->F2_CLIENTE+(cAlias)->F2_LOJA,3,"")
			
			If ( !alltrim((cAlias)->C5_YTRANS) $ "1/S" .and. !Empty((cAlias)->C5_YCHCROS) ) .Or. lWmsStore
				cIntDireta	:= "S"
			Else
				cIntDireta	:= iif(cArmWMS $ cMVARMWMAS,"N","S")
			EndIf
			AADD(alDados,cIntDireta )
			AADD(alDados,Iif(Empty((cAlias)->C5_YCHCROS),"N","S"))		//44
			AADD(alDados,Iif(alltrim((cAlias)->C5_YTRANS)$"1/S",(cAlias)->F2_FILIAL+(cAlias)->C5_NUM,(cAlias)->C5_YCHCROS))	//45
			AADD(alDados,Iif(alltrim((cAlias)->C5_YTRANS)$"1/S","S","N"))			//46
			
			alCmpChave := {}
			aadd(alCmpChave,"RNV_COD_DEPOSITO")
			aadd(alCmpChave,"RNV_COD_DEPOSITANTE")
			aadd(alCmpChave,"RNV_NUM_DOCUMENTO")
			aadd(alCmpChave,"RNV_SERIE_DOCUMENTO")
			
			alValChave := {}
			aadd(alValChave,1)
			aadd(alValChave,VAL((cAlias)->F2_FILIAL) )
			aadd(alValChave,(cAlias)->F2_DOC)
			aadd(alValChave,(cAlias)->F2_SERIE)
			
		EndIF
	ElseIF cTab == "RNVI" .OR. cTab == "SD2"
		If lCampo
			AADD(alDados,"RNVI_COD_DEPOSITO")
			AADD(alDados,"RNVI_COD_DEPOSITANTE")
			AADD(alDados,"RNVI_NUM_DOCUMENTO")
			AADD(alDados,"RNVI_SERIE_DOCUMENTO")
			AADD(alDados,"RNVI_TIPO_DOCUMENTO")
			AADD(alDados,"RNVI_CNPJ_EMBARCADOR")
			AADD(alDados,"RNVI_NUM_NOTA_FISCAL")
			AADD(alDados,"RNVI_SERIE_NOTA_FISCAL")
			AADD(alDados,"RNVI_MODELO")
			AADD(alDados,"RNVI_COD_PROD")
			AADD(alDados,"RNVI_CNPJ_EMISSOR")
			AADD(alDados,"RNVI_QTDE_ITENSNOTA")
			AADD(alDados,"RNVI_DESC_PROD")
			AADD(alDados,"RNVI_ALTURA_PRODUTOS")
			AADD(alDados,"RNVI_LARGURA_PRODUTOS")
			AADD(alDados,"RNVI_COMPRIMENTO_PRODUTOS")
			AADD(alDados,"RNVI_PESO_PRODUTOS")
			AADD(alDados,"RNVI_VALOR")
			AADD(alDados,"STATUS")
			AADD(alDados,"DATA")
			AADD(alDados,"HORA")
			AADD(alDados,"DESC_ERRO")
		Else
			clTabWMS := "TB_FRTINTERFITENSNOTAS"
			
			AADD(alDados,1)
			AADD(alDados,(cAlias)->D2_FILIAL)
			AADD(alDados,(cAlias)->D2_PEDIDO)
			AADD(alDados,"PED")
			AADD(alDados,"P")				//5
			AADD(alDados,SM0->M0_CGC)
			AADD(alDados,ALLTRIM((cAlias)->D2_DOC))
			AADD(alDados,ALLTRIM((cAlias)->D2_SERIE))
			AADD(alDados,IIF(alltrim((cAlias)->ESPECIE) == 'SPED',"0055","1/1A"))
			AADD(alDados,ALLTRIM((cAlias)->D2_COD) )				//10
			AADD(alDados,SM0->M0_CGC)
			AADD(alDados,(cAlias)->D2_QUANT)
			AADD(alDados,SUBSTR(ALLTRIM((cAlias)->B1_XDESC),1,50) )
			AADD(alDados,(cAlias)->B1_ALT)
			AADD(alDados,(cAlias)->B1_LARGURA)			//15
			AADD(alDados,(cAlias)->B1_PROF)
			AADD(alDados,(cAlias)->B1_PESBRU)
			AADD(alDados,(cAlias)->(D2_TOTAL+D2_VALIPI+D2_VALFRE+D2_ICMSRET+D2_SEGURO+D2_DESPESA))
			AADD(alDados,"NP")
			AADD(alDados,DTOS(DATE()))					//20
			AADD(alDados,STRTRAN(TIME(),":",""))
			AADD(alDados," ")
			
			alCmpChave := {}
			AADD(alCmpChave,"RNVI_COD_DEPOSITO")
			AADD(alCmpChave,"RNVI_COD_DEPOSITANTE")
			AADD(alCmpChave,"RNVI_NUM_NOTA_FISCAL")
			AADD(alCmpChave,"RNVI_SERIE_NOTA_FISCAL")
			AADD(alCmpChave,"RNVI_MODELO")
			AADD(alCmpChave,"RNVI_COD_PROD")
			
			alValChave:= {}
			AADD(alValChave,1)
			AADD(alValChave,val((cAlias)->D2_FILIAL))
			AADD(alValChave,ALLTRIM((cAlias)->D2_DOC))
			AADD(alValChave,ALLTRIM((cAlias)->D2_SERIE))
			AADD(alValChave,ALLTRIM((cAlias)->ESPECIE))
			AADD(alValChave,ALLTRIM((cAlias)->D2_COD))
			
		EndIF
		
	ElseIF cTab == 'CS'
		If lCampo
			AADD(alDados,"STATUS")
			AADD(alDados,"DESC_ERRO")
		Else
			clTabWMS	:= "TB_WMSINTERF_CONF_SEPARACAO"
			
			AADD(alDados,'') //DENTRO DA ROTINA NCGPR106, ษ DEFINIDO O VALOR CORRETO DO CAMPO
			AADD(alDados,'')
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"CS_COD_DEPOSITANTE")
			AADD(alCmpChave,"CS_NUM_DOCUMENTO")
			AADD(alCmpChave,"CS_COD_PRODUTO")
			
			AADD(alValChave,(cAlias)->CS_COD_DEPOSITANTE)
			AADD(alValChave,ALLTRIM((cAlias)->CS_NUM_DOCUMENTO))
			AADD(alValChave,ALLTRIM((cAlias)->CS_COD_PRODUTO))
			
		EndIF
	ElseIF cTab == 'SA4'
		If lCampo
			AADD(alDados,"TR_CODIGO")
			AADD(alDados,"TR_RAZAO_SOCIAL")
			AADD(alDados,"TR_CNPJ")
			
			AADD(alDados,"STATUS")
			AADD(alDados,"DATA")
			AADD(alDados,"HORA")
			AADD(alDados,"DESC_ERRO")
		Else
			clTabWMS	:= "TB_FRTINTERF_TRANSPORTADOR"
			
			AADD(alDados,ALLTRIM(STR((cAlias)->A4_YCODWMS)) )
			AADD(alDados,ALLTRIM((cAlias)->A4_NOME))
			AADD(alDados,(cAlias)->A4_CGC)
			AADD(alDados,'NP')
			AADD(alDados,DTOS(DATE()) ) //substr(DTOS(DATE()),7,2)+"/"+substr(DTOS(DATE()),5,2)+"/"+substr(DTOS(DATE()),1,4) )
			AADD(alDados,STRTRAN(time(),':',""))
			AADD(alDados,'')
			
			alCmpChave	:= {}
			alValChave	:= {}
			
			AADD(alCmpChave,"TR_CODIGO")
			AADD(alValChave,STR((cAlias)->A4_YCODWMS) )
		EndIF
	EndIF
Else
	
	If cTab == "B1P"
		clTabWMS	:= 'TB_WMSINTERF_PRODUTO'
		
		nlDep 		:= "1"
		nlDeptante	:= "1"
		
		alCmpChave	:= {}
		alValChave	:= {}
		
		AADD(alCmpChave,"PROD_COD_DEPOSITO||PROD_COD_DEPOSITANTE||PROD_CODIGO")
		AADD(alValChave,nlDep+nlDeptante+ALLTRIM(SUBSTR((cAlias)->P0A_CHAVE,3,len((cAlias)->P0A_CHAVE))))
	EndIF
	
EndIF

Iif(Select(cAliasCros) > 0,(cAliasCros)->(dbCloseArea()),Nil)

RestArea(aAreaAtu)
Return(alDados)

Static Function FBUSCACFOP(cFil,cDoc,cSerie,cForn,cLoja)
Local aAreaAtu	:=GetArea()
Local clCFOP	:= ""
Local clQry		:= ""
Local cAliasCF	:= GetNextAlias()

clQry := " SELECT COUNT(D1_CF) TOTAL,D1_CF

clQry += " FROM "+RetSqlName("SD1") + " SD1 "

clQry += " WHERE D1_FILIAL = '"+cFil+"' "
clQry += " AND D1_DOC = '"+cDoc+"' "
clQry += " AND D1_SERIE = '"+cSerie+"' "
clQry += " AND D1_FORNECE = '"+cForn+"' "
clQry += " AND D1_LOJA = '"+cLoja+"' "

clQry += " GROUP BY D1_CF "

clQry += " ORDER BY TOTAL DESC "

Iif(Select(cAliasCF) > 0,(cAliasCF)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAliasCF,.F.,.T.)

(cAliasCF)->(DBGoTop())

If (cAliasCF)->(!EOF())
	clCFOP := (cAliasCF)->D1_CF
EndIF

Iif(Select(cAliasCF) > 0,(cAliasCF)->(dbCloseArea()),Nil)

RestArea(aAreaAtu)
Return(clCFOP)

User Function AXCADP0A()

Local cVldAlt := ".F." 			// Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".F."	//".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "P0A"

dbSelectArea("P0A")
dbSetOrder(1)

AxCadastro(cString,"Integra็ใo WMS",cVldExc,cVldAlt)

Return()



Static Function Pesoc9(cxPed)

Local aAreaC9	:= getarea()
Local nPesoWMS	:= 0
Local cAliasC9	:= GetNextAlias()

c1Qry	:= " SELECT SUM(C9.C9_QTDLIB*B1.B1_PESBRU) PESOWMS
c1Qry	+= " FROM SC9010 C9, SB1010 B1
c1Qry	+= " WHERE C9.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' '
c1Qry	+= " AND C9.C9_FILIAL = '"+xFilial("SC9")+"' AND B1.B1_FILIAL = '"+xFilial("SB1")+"'
c1Qry	+= " AND C9.C9_PRODUTO = B1.B1_COD
c1Qry	+= " AND C9_BLEST = ' ' AND C9_BLCRED = ' '
c1Qry	+= " AND C9_PEDIDO = '"+cxPed+"'

IIf(Select(cAliasC9) > 0,(cAliasC9)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,c1Qry),cAliasC9  ,.F.,.T.)

While (cAliasC9)->(!eof())
	nPesoWMS	+= (cAliasC9)->PESOWMS
	(cAliasC9)->(dbskip())
End
(cAliasC9)->(dbCloseArea())

RestArea(aAreaC9)

Return nPesoWMS


//Busca Volume e volume3 quando se tratar de nota fiscal de venda com pedido de crossdocking
Static Function Pr105Vol3(nVolume,nVol3,cChvCross)

Local cAliasVol3	:= GetNextAlias()
Local cQryV3		:= ""

cQryV3	:= " SELECT RNV_VOL_NOTAS VOLUME, RNV_VOL3_NOTA VOL3 FROM WMS.TB_FRTINTERFNOTAS
cQryV3	+= " WHERE RNV_COD_CHAVE_TRANS = '"+alltrim(cChvCross)+"' AND RNV_NF_TRANSF = 'S' "

IIf(Select(cAliasVol3) > 0,(cAliasVol3)->(dbCloseArea()),Nil)
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQryV3),cAliasVol3  ,.F.,.T.)

While (cAliasVol3)->(!Eof())
	nVolume	:= (cAliasVol3)->VOLUME
	nVol3	:= (cAliasVol3)->VOL3
	(cAliasVol3)->(dbskip())
End
(cAliasVol3)->(dbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR105  บAutor  ณMicrosiga           บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR105LogP0A()

If P0A->(FieldPos("P0A_HORA"))>0
	P0A->P0A_HORA	:=Time()
	P0A->P0A_DATA	:=MsDate()
	P0A->P0A_USER	:=Upper(cUserName)
	P0A->P0A_ROTINA:=ProcName(1)
EndIf	

Return 
