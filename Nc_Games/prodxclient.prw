#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PROXCLIENTº Autor ³ ERICH BUTTNER      º Data ³  21/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ RELATORIO DE CLIENTE X PRODUTO                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PROXCLIENT()

PRIVATE cPerg	:= "PROCLIE"

cArq1 := CriaTrab(Nil, .F.)
cPath1:= "C:\RELATORIOS\"
nArq1 := FCreate(cPath1 + cArq1 + ".CSV")
cArqTRB	:= CriaTrab(,.F.)


VALIDPERG(cPerg)

IF !pergunte(cPerg,.T.)
	RETURN .F.
ENDIF

FWrite(nArq1, " ; ; ; ; ;DE; ; ; ; ;PARA; ; ; "+ Chr(13) + Chr(10))
FWrite(nArq1, "NUMERO_PEDIDO;EMISSAO;CLIENTE;LOJA;NOME_CLIENTE;CODIGO_PRODUTO_NC;DESCRIÇÃO_PRODUTO_NC;CODIGO_DE_BARRAS;PLATAFORMA;QUANTIDADE_PRODUTO;CODIGO_PRODUTO_CLIENTE;DESCRIÇÃO_PRODUTO_CLIENTE;QUANTIDADE_PARA" + Chr(13) + Chr(10))

DBSELECTAREA("SC5")
DBSETORDER(1)

cQuery:= ""

cQuery:= " SELECT C6_NUM NUMEROPEDIDO, C5_EMISSAO DTEMIS,C6_CLI CLIENTE, C6_LOJA LOJA, A1_NOME NOMECLIENTE,A7_CODCLI CODIGOCLIENTE, A7_DESCCLI DESCRICAOCLIENTE,
cQuery+= " C6_PRODUTO CODIGONCGAMES, B1_CODBAR CODBAR,B1_PLATAF PLATAFORMA,B1_XDESC DESCRICAONCGAMES, C6_QTDVEN QUANTIDADE 
cQuery+= " FROM SC6010, SB1010, SA7010, SA1010, SC5010
cQuery+= " WHERE C6_PRODUTO = B1_COD
cQuery+= " AND C6_FILIAL = '"+XFILIAL("SC6")+"'
cQuery+= " AND B1_FILIAL = '  '
cQuery+= " AND A7_PRODUTO = C6_PRODUTO
cQuery+= " AND A7_FILIAL = '  '
cQuery+= " AND A7_CLIENTE = C6_CLI
cQuery+= " AND A7_LOJA = C6_LOJA
cQuery+= " AND C6_CLI = A1_COD
cQuery+= " AND C6_LOJA = A1_LOJA
cQuery+= " AND A1_FILIAL = '  '
cQuery+= " AND C5_NUM = C6_NUM
cQuery+= " AND C5_FILIAL = '"+XFILIAL("SC5")+"'
cQuery+= " AND C5_EMISSAO >='"+DTOS(MV_PAR01)+"'
cQuery+= " AND C5_EMISSAO <='"+DTOS(MV_PAR02)+"'
cQuery+= " AND A1_COD >= '"+ALLTRIM(MV_PAR03)+"'
cQuery+= " AND A1_COD <= '"+ALLTRIM(MV_PAR05)+"'
cQuery+= " AND A1_LOJA >= '"+ALLTRIM(MV_PAR04)+"'
cQuery+= " AND A1_LOJA <= '"+ALLTRIM(MV_PAR06)+"'
cQuery+= " AND C5_NUM >= '"+MV_PAR07+"'
cQuery+= " AND C5_NUM <= '"+MV_PAR08+"'
cQuery+= " AND SC6010.D_E_L_E_T_ = ' '
cQuery+= " AND SA7010.D_E_L_E_T_ = ' '
cQuery+= " AND SB1010.D_E_L_E_T_ = ' '
cQuery+= " AND SA1010.D_E_L_E_T_ = ' '
cQuery+= " AND SC5010.D_E_L_E_T_ = ' '
cQuery+= " ORDER BY C6_NUM

If Select("cArqTRB") > 0
	dbSelectArea("cArqTRB")
	dbCloseArea("cArqTRB")
Endif

cQuery := ChangeQuery(cQuery)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqTRB",.T.,.T.)

dbSelectArea("cArqTRB")
cArqTRB->(dbGoTop())

nQtdTot := 0

WHILE cArqTRB->(!EOF())
	
	cNumPed 	:= cArqTRB->NUMEROPEDIDO
	dDtEmiss	:= SUBSTR(cArqTRB->DTEMIS,7,2)+"/"+SUBSTR(cArqTRB->DTEMIS,5,2)+"/"+SUBSTR(cArqTRB->DTEMIS,1,4)
	cClient		:= cArqTRB->CLIENTE
	cLoja		:= cArqTRB->LOJA
	cNmClient	:= cArqTRB->NOMECLIENTE
	cNCProd		:= cArqTRB->CODIGONCGAMES
	cDNCProd	:= ALLTRIM(cArqTRB->DESCRICAONCGAMES)
    cCodBar		:= cArqTRB->CODBAR
    cPlataf		:= POSICIONE("SZ5",1,XFILIAL("SZ5")+cArqTRB->PLATAFORMA, "Z5_PLATRED")
    nQtdProdNc	:= cArqTRB->QUANTIDADE
	cCliProd	:= cArqTRB->CODIGOCLIENTE
	cDCliProd	:= cArqTRB->DESCRICAOCLIENTE
	nQtdTot		+= cArqTRB->QUANTIDADE
	
	FWrite(nArq1, cNumPed+";"+dDtEmiss+ ";'" +cClient+ ";'" +cLoja+";"+cNmClient+";'"+cNCProd+";" ;
	+cDNCProd+";'"+cCodBar+";"+cPlataf+";"+STR(nQtdProdNc)+";'"+cCliProd+";"+cDCliProd)
	
	cArqTRB->(DBSKIP())
	
	IF cCliProd <> cArqTRB->CODIGOCLIENTE
		FWrite(nArq1, ";"+STR(nQtdTot)+";"+ Chr(13) + Chr(10))
		nQtdTot := 0
	ELSE
		FWrite(nArq1, ";"+Chr(13) + Chr(10))	
	ENDIF	
ENDDO

FClose(nArq1)

DbSelectArea("cArqTRB")
DbCloseArea()

ALERT("ARQUIVO GERADO NA PASTA : "+cPath1+cArq1+".CSV")

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VALIDPERG ³ Autor ³ RAIMUNDO PEREIRA      ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data De ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Ate ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Cliente De ?","","","mv_ch3","C", 6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
AADD(aRegs,{cPerg,"04","Loja De ?","","","mv_ch4","C", 2,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Cliente Ate ?","","","mv_ch5","C", 6,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SA1"})
AADD(aRegs,{cPerg,"06","Loja Ate ?","","","mv_ch6","C", 2,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Pedido De ?","","","mv_ch7","C", 6,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","SC5"})
AADD(aRegs,{cPerg,"08","Pedido Ate ?","","","mv_ch8","C", 6,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","SC5"})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
Return
