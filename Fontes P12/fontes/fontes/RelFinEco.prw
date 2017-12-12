#Include 'Protheus.ch'
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "TBICONN.CH"
#include "Fileio.ch"

User Function RelFinEco()
Local aArea 	:= GetArea()
Local aPergs	:= {}
Local aRet		 := {}
Private _cCab := ""
Private _DTINI
Private _DTFIM
	
	
	aadd(aPergs, {1,"Data de  :"				,CtoD("//")							,"@D"	,"","","",70,.F.})
	aadd(aPergs, {1,"Data até :"				,CtoD("//")							,"@D"	,"","","",70,.F.})
	
	If !ParamBox(aPergs,"Relatorio titulos Moip", @aRet)
		MsgAlert("Processo Cancelado!")
		RestArea(aArea)
		Return
	Else	
	
		_DTINI := aRet[1]
		_DTFIM := aRet[2]
		
		Processa({|| GeraRel() })
		MsgAlert("Processo Finalizado!")
		RestArea(aArea)
		Return
	EndIf
	
RestArea(aArea)
Return

Static Function GeraRel()
Local aArea := GetArea()
	
	_cArq  := CriaTrab(Nil, .F.)		
	_cPath := "C:\RELATORIOS\" 
	_nArq  := FCreate( _cPath + _cArq + ".CSV")

	MontCab()
	BuscaDados()
	
	If !FCLOSE(_nArq)
    	conout( "Erro ao fechar arquivo, erro numero: ", FERROR() )
  	EndIf
	

RestArea(aArea)
Return

Static Function MontCab()
Local aArea := GetArea()

	_cCab := ""
	_cCab += '"PEDIDO_ECOMMERCE";'
	_cCab += '"PEDIDO_PROTHEUS";'
	_cCab += '"CLIENTE";'
	_cCab += '"LOJA";'
	_cCab += '"NOME_DO_CLIENTE";'
	_cCab += '"NUMERO";'
	_cCab += '"PREFIXO";'
	_cCab += '"PARCELA";'
	_cCab += '"TIPO";'
	_cCab += '"DESCONTO";'
	_cCab += '"VALOR";'
	_cCab += '"HISTORICO";'
	_cCab += '"SALDO";'
	_cCab += '"EMISSAO";'
	_cCab += '"DT_BAIXA";'

	GravaLinha(_cCab)
	
RestArea(aArea)
Return


Static Function BuscaDados()
Local aArea 		:= GetArea()
Local cAlias01 	:= GetNextAlias()
Local cQuery 		:= ""
Local cLinha		:= ''

	cQuery := " SELECT  "+CRLF
	cQuery += " CASE "+CRLF
	cQuery += "     WHEN TO_CHAR( ZC5.ZC5_NUM) <> '0' THEN TO_CHAR(ZC5.ZC5_NUM) ELSE ZC5.ZC5_PVVTEX END PEDIDO_ECOMMERCE, "+CRLF
	cQuery += " ZC5.ZC5_NUMPV PEDIDO_PROTHEUS, "+CRLF
	cQuery += " E1_CLIENTE CLIENTE, "+CRLF
	cQuery += " E1_LOJA LOJA, "+CRLF
	cQuery += " A1_NREDUZ NOME_DO_CLIENTE, "+CRLF
	cQuery += " E1_PREFIXO PREFIXO, "+CRLF 
	cQuery += " E1_NUM NUMERO, "+CRLF 
	cQuery += " E1_PARCELA PARCELA, "+CRLF 
	cQuery += " E1_TIPO TIPO, "+CRLF 
	cQuery += " E1_DESCONT DESCONTO, "+CRLF
	cQuery += " E1_VALOR VALOR, "+CRLF
	cQuery += " E1_HIST HISTORICO, "+CRLF
	cQuery += " E1_SALDO, "+CRLF 
	cQuery += " CASE "+CRLF 
 	cQuery += " WHEN E1_EMISSAO <> ' ' THEN TO_DATE(E1_EMISSAO,'YYYYMMDD') END EMISSAO, "+CRLF 
	cQuery += " CASE "+CRLF 
 	cQuery += " WHEN E1_BAIXA <> ' ' THEN TO_DATE(E1_BAIXA,'YYYYMMDD') END DT_BAIXA "+CRLF
	cQuery += " FROM " + RetSqlName("SE1") + " SE1 JOIN "+ RetSqlName("ZC5")+" ZC5 "+CRLF
	cQuery += " ON SE1.E1_NUM = ZC5.ZC5_NOTA AND SE1.E1_CLIENTE = ZC5.ZC5_CLIENT AND SE1.E1_LOJA = ZC5.ZC5_LOJA "+CRLF
	cQuery += " LEFT JOIN " + RetSqlName("SA1")+" SA1 "+CRLF
	cQuery += " ON SE1.E1_CLIENTE = SA1.A1_COD AND SE1.E1_LOJA = SA1.A1_LOJA "+CRLF
	cQuery += " WHERE "+CRLF 
	cQuery += " SE1.E1_FILIAL = '"+ xFilial("SE1") +"' "+CRLF
	cQuery += " AND ZC5.ZC5_FILIAL = '"+ xFilial("ZC5") +"' "+CRLF
	cQuery += " AND SA1.A1_FILIAL = '"+ xFilial("SA1") +"' "+CRLF
	cQuery += " AND E1_PREFIXO IN( 'ECO' ,'EMP','EUZ') "+CRLF
	cQuery += " AND SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " and SE1.E1_EMISSAO BETWEEN '"+ dToS( _DTINI ) +"' AND '"+ dToS( _DTFIM ) +"' "+CRLF
	cQuery += " ORDER BY E1_NUM, E1_PARCELA "+CRLF
	
	cQuery := ChangeQuery(cQuery)
	DbUseArea( .T. , 'TOPCONN', TCGENQRY(,,cQuery),cAlias01, .T., .F. )
	
	Do While (cAlias01)->(!EOF())
	
		cLinha := ''
		cLinha += '"'+ (cAlias01)->PEDIDO_ECOMMERCE +'";'
		cLinha += '"'+ (cAlias01)->PEDIDO_PROTHEUS +'";'
		cLinha += '"'+ (cAlias01)->CLIENTE +'";'
		cLinha += '"'+ (cAlias01)->LOJA +'";'
		cLinha += '"'+ (cAlias01)->NOME_DO_CLIENTE +'";'
		cLinha += '"'+ (cAlias01)->NUMERO +'";'
		cLinha += '"'+ (cAlias01)->PREFIXO +'";'
		cLinha += '"'+ (cAlias01)->PARCELA +'";'
		cLinha += '"'+ (cAlias01)->TIPO +'";'
		cLinha += '"'+ cValToChar((cAlias01)->DESCONTO) +'";'
		cLinha += '"'+ cValToChar((cAlias01)->VALOR) +'";'
		cLinha += '"'+ (cAlias01)->HISTORICO +'";'
		cLinha += '"'+ cValToChar((cAlias01)->E1_SALDO) +'";'
		cLinha += '"'+ dToc((cAlias01)->EMISSAO) +'";'
		cLinha += '"'+ dToc((cAlias01)->DT_BAIXA )+'";'
		
		GravaLinha(cLinha)
		
		(cAlias01)->(DbSkip())
		Loop
	EndDo
	

RestArea(aArea)
Return

Static Function GravaLinha(cLinha)
Local aArea := GetArea()

FWrite( _nArq , cLinha + Chr(13) + Chr(10))

RestArea(aArea)
Return

