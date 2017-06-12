#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"

///*‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
//±±∫PROGRAMA  ≥MFRETE() ∫AUTOR≥ RAFAEL CAMARGO AUGUSTO ∫ DATA ≥  01/05/10  ∫±±
//±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
//±±∫DESC.     ≥                                                            ∫±±
//±±∫          ≥                                                            ∫±±
//±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
//±±∫USO       ≥ AP 10 - NC GAMES                                           ∫±±
//±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/

USER FUNCTION MFRETE

_CCONT  				:= 0
aItems    			:=  {"Item 1","Item 2","Item 3"}
cCombo 					:=  "   "

Public ACORES          := {}
Public CALIAS          := "SZ4"
Public CTABELAFRETE    := "  "
Public cOK	           := .T.

Public CBLOQUEADO      := "2"    			  //INICIA COMO TABELA ATIVA.
Public CDATA           := CTOD("  /  /   ")  //MASCARA DO CAMPO DATA
Public CCODIGO         := SPACE(6)           //ESPACO NO CAMPO
Public CPEDIDO         := SPACE(3)           //ESPACO NO CAMPO
Public CDATATAB        := " "
Public CDESCRICAO 	   := SPACE(50)          //ESPACO NO CAMPO
Public CCADASTRO       := "TABELA DE FRETE POR CEP E POR MODAL"
Public CTITULO		     := "TABELA DE FRETE POR CEP E POR MODAL"
Public ASIZE 	         := MSADVSIZE()
Public AROTINA         := {}
Public NOPCX           := " "

AROTINA	:= { {"VISUALIZAR" ,"U_FRETE(2)" ,0,2},;
{"INCLUIR"    ,"U_FRETE(3)" ,0,3},;
{"ALTERA"     ,"U_FRETE(4)" ,0,4},;
{"EXCLUIR"    ,"U_FRETE(5)" ,0,5},;
{"LEGENDA"    ,"OMS010LEG"  ,0,2}}

//aAdd( aRotina, {"Pesquisar"  ,"AxPesqui"    ,0,1})
//aAdd( aRotina, {"Visualizar" ,'U_FRETE',0,2})
//aAdd( aRotina, {"Incluir"    ,'U_FRETE',0,3})
//aAdd( aRotina, {"Alterar"    ,'U_FRETE',0,4})
//aAdd( aRotina, {"Excluir"    ,'U_FRETE',0,5})


DBSELECTAREA("SZ4")  // TABELA DE FRETE POR CEP E POR MODAL

//----------------------------------------------------------------------------------------------//
//Cria Indice virtual para ordenar a tabela no momento que a mesma esta no browser				//
//----------------------------------------------------------------------------------------------//

_NINDEX := INDEXORD()
_CINDEX := CRIATRAB(NIL,.F.)
_CCHAVE := "Z4_FILIAL + Z4_NUMTAB"

INDREGUA("SZ4",_CINDEX,_CCHAVE,,,"VERIFICANDO AS TABELAS")
DBGOTOP()

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥VERIFICA AS CORES DA MBROWSE                                            ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

AADD(ACORES,{"Z4_ATIVA == '2'","ENABLE"})  //ATIVA
AADD(ACORES,{"Z4_ATIVA == '1'","DISABLE"}) //DESATIVADA

MBROWSE(6,1,22,75,'SZ4',,,,,,ACORES)

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥RESTAURA A INTEGRIDADE DA ROTINA                                        ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

DBSELECTAREA("SZ4")
DBSETORDER(_NINDEX)

DBCLEARFILTER()

RETURN

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Inicia o Programa de acordo com a opcao (NOPCX)              ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

USER FUNCTION FRETE(NOPCX)

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ MONTANDO AHEADER                                             ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

PRIVATE LDELETA := .F.
//PRIVATE NFREEZE := 3

DBSELECTAREA("SX3")
DBSETORDER(1)
DBSEEK("SZ4")

NUSADO     := 00
AHEADER    := {}

WHILE !EOF() .AND. (X3_ARQUIVO == "SZ4")
	
	//=======================================================================
	//MONTA OS CAMPOS DOS ITENS DA TABELA
	//=======================================================================
	
	IF X3USO(X3_USADO) .AND. CNIVEL >= X3_NIVEL
		
		IF  "Z4_CEPDE"   == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_CEPATE"  == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_ESTADO"  == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_LOCALIZ" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_DESCCEP" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_TRANSPO" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_IDEALCA" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_MINCARR" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_SEGUROC" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_MERCCAR" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_ENTCARR" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_IDEALSE" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_MINSEDE" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_SEGUROS" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_MERCSED" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_ENTSEDE" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_IDEALTR" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_MINTRAN" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_SEGUROT" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_MERCTRA" == ALLTRIM(X3_CAMPO) .OR. ;
			"Z4_ENTTRAN" == ALLTRIM(X3_CAMPO)
			
			NUSADO := NUSADO + 1
			AADD(AHEADER,{ TRIM(X3_TITULO), ALLTRIM(X3_CAMPO), X3_PICTURE,X3_TAMANHO, X3_DECIMAL,"",X3_USADO, X3_TIPO, X3_ARQUIVO, X3_CONTEXT })
		ENDIF
	ENDIF
	DBSKIP()
END

PRIVATE ACOLS := {}

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ ARRAY COM DESCRICAO DOS CAMPOS DO CABECALHO DO MODELO 2      ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

AC  := {}

// AC[N,1] = NOME DA VARIAVEL EX.:"CCLIENTE"
// AC[N,2] = ARRAY COM COORDENADAS DO GET [X,Y], EM WINDOWS ESTAO EM PIXEL
// AC[N,3] = TITULO DO CAMPO
// AC[N,4] = PICTURE
// AC[N,5] = VALIDACAO
// AC[N,6] = F3
// AC[N,7] = SE CAMPO E' EDITAVEL .T. SE NAO .F.

/*
AADD(AC,{"CCLIENTE"   ,{15,10}  ,PICUTRE      ,"MASCARA"   ,VALIDACAO ,F3 ,.F.})*/
AADD(AC,{'CCODIGO'    ,{15,05}  ,"TABELA"     ,'@E 999999' ,          ,   ,.T.})
AADD(AC,{'CDESCRICAO' ,{15,85}  ,"DESCRICAO"  ,'@S50'      ,          ,   ,.T.})
AADD(AC,{'CDATA'      ,{15,430} ,"DATA"       ,''          ,          ,   ,.T.})
AADD(AC,{'CBLOQUEADO' ,{15,510} ,"BLOQUEADO"  ,'@!'        ,          ,   ,.T.})

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ ARRAY COM DESCRICAO DOS CAMPOS DO RODAPE DO MODELO 2         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

AR := {}

// AR[N,1] = NOME DA VARIAVEL EX.:"CCLIENTE"
// AR[N,2] = ARRAY COM COORDENADAS DO GET [X,Y], EM WINDOWS ESTAO EM PIXEL
// AR[N,3] = TITULO DO CAMPO
// AR[N,4] = PICTURE
// AR[N,5] = VALIDACAO
// AR[N,6] = F3
// AR[N,7] = SE CAMPO E' EDITAVEL .T. SE NAO .F.

// AADD(AR,{"NLINGETD" ,{120,10},"LINHA NA GETDADOS" ,"@E 999",,,.F.})

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ ARRAY COM COORDENADAS DA GETDADOS NO MODELO2                 ≥
//≥ IRA MONTAR A TELA ONDE SERAO APRESENTADO OS DADOS			 ≥
//≥ DO JEITO QUE EST·, EST· PARA TELA TODA.   					 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

ACGD    := {25,04,15,73}
ACORDW  := {ASIZE[7],0,ASIZE[6],ASIZE[5]}

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ VISUALIZAR A TABELA DO FRETE SELECIONADA                     ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

IF NOPCX == 2
	
	//------------MONTA O CABECALHO COM OS DADOS--------------------//
	
	_CFILIAL      := SZ4->Z4_FILIAL
	CCODIGO       := SZ4->Z4_NUMTAB
	CDESCRICAO    := SZ4->Z4_DESCRI
	CDATA		      := SZ4->Z4_DATA
	CBLOQUEADO    := SZ4->Z4_ATIVA
	ACOLS         := {}
	
	//------------MONTA OS ITENS COM OS DADOS-----------------------//
	
	DBSELECTAREA("SZ4")
	
	WHILE !EOF().AND.CCODIGO == SZ4->Z4_NUMTAB
		AADD(ACOLS,{SZ4->Z4_CEPDE,SZ4->Z4_CEPATE,SZ4->Z4_ESTADO,SZ4->Z4_LOCALIZ,SZ4->Z4_DESCCEP,SZ4->Z4_TRANSPO,SZ4->Z4_IDEALCA,SZ4->Z4_MINCARR,SZ4->Z4_SEGUROC,SZ4->Z4_MERCCAR,SZ4->Z4_ENTCARR,SZ4->Z4_IDEALSE,SZ4->Z4_MINSEDE,SZ4->Z4_SEGUROS,SZ4->Z4_MERCSED,SZ4->Z4_ENTSEDE,SZ4->Z4_IDEALTR,SZ4->Z4_MINTRAN,SZ4->Z4_SEGUROT,SZ4->Z4_MERCTRA,SZ4->Z4_ENTTRAN,.F.})
		DBSKIP()
	ENDDO
	
ENDIF

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ EXCLUI A TABELA DO FRETE SELECIONADA                         ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

IF NOPCX == 5 .AND. MSGNOYES("TEM CERTEZA DE QUE DESEJA EXCLUIR A TABELA DO FRETE? ") //EXCLUI A TABELA DE FRETE POR CEP
	
	CPEDIDO  		:= SZ4->Z4_NUMTAB
	CDATATAB 		:= SZ4->Z4_DATA
	
	DBSELECTAREA("SZ4")
	DBSETORDER(1)
	DBGOTOP()
	
	CCONT := 0
	
	WHILE !EOF() .AND. CPEDIDO == SZ4->Z4_NUMTAB .AND. CDATATAB == SZ4->Z4_DATA
		
		RECLOCK("SZ4",.F.)
		DBDELETE()
		MSUNLOCK()
		
		CCONT := CCONT + 1
		
		DBSELECTAREA("SZ4")
		DBSETORDER(1)
		DBSKIP()
	ENDDO
	
	IF CCONT > 0
		ALERT("TABELA DE FRETE EXCLUIDA COM SUCESSO !!")
		RETURN(.F.)
	ENDIF
	
ELSEIF NOPCX == 5
	RETURN(.F.)
ENDIF

//*************************************************************//
//FUNCAO DE ALTERAR()							               							 //
//CARREGA AS VARIVEIS PARA SER APRESENTADO NA TELA DO PROGRAMA //
//*************************************************************//
    
IF NOPCX == 4
	
//------------MONTA O CABECALHO COM OS DADOS--------------------//
	
_CFILIAL       := SZ4->Z4_FILIAL
CCODIGO        := SZ4->Z4_NUMTAB
CDESCRICAO     := SZ4->Z4_DESCRI
CDATA		       := SZ4->Z4_DATA
CBLOQUEADO     := SZ4->Z4_ATIVA
ACOLS          := {}
LLINHA	       := .T.

//------------MONTA OS ITENS COM OS DADOS-----------------------//
	
	DBSELECTAREA("SZ4")
	DBSETORDER(1)
	DBGOTOP()
	
	WHILE !EOF() //.AND. CCODIGO == SZ4->Z4_NUMTAB
		
	AADD(ACOLS,{SZ4->Z4_CEPDE,SZ4->Z4_CEPATE,SZ4->Z4_ESTADO,SZ4->Z4_LOCALIZ,SZ4->Z4_DESCCEP,SZ4->Z4_TRANSPO,SZ4->Z4_IDEALCA,SZ4->Z4_MINCARR,SZ4->Z4_SEGUROC,SZ4->Z4_MERCCAR,SZ4->Z4_ENTCARR,SZ4->Z4_IDEALSE,SZ4->Z4_MINSEDE,SZ4->Z4_SEGUROS,SZ4->Z4_MERCSED,SZ4->Z4_ENTSEDE,SZ4->Z4_IDEALTR,SZ4->Z4_MINTRAN,SZ4->Z4_SEGUROT,SZ4->Z4_MERCTRA,SZ4->Z4_ENTTRAN,.F.}) 
		
	DBSKIP()
		
	ENDDO

ENDIF

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ CHAMADA DA MODELO2                                           ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

//LRETMOD2 = .T. SE CONFIRMOU
//LRETMOD2 = .F. SE CANCELOU

//CTÌTULO - TÌTULO DA JANELA
//ACABEC - ARRAY COM OS CAMPOS DO CABEÁALHO
//ARODAPÈ - ARRAY COM OS CAMPOS DO RODAPÈ
//AGD - ARRAY COM AS POSIÁıES PARA EDIÁ„O DOS ITENS (GETDADOS)
//NOP - MODO DE OPERAÁ„O (3 OU 4 ALTERA E INCLUI ITENS, 6 ALTERA MAS N„O INCLUI ITENS, QUALQUER OUTRO N˙MERO SÛ VISUALIZA OS ITENS)
//CLOK - FUNÁ„O PARA VALIDAÁ„O DA LINHA
//CTOK - FUNÁ„O PARA VALIDAÁ„O DE TODOS OS DADOS (NA CONFIRMAÁ„O)
//AGETSGD - ARRAY GETS EDIT·VEIS (GETDADOS)DEFAULT = TODOS.
//BF4 - CODEBLOCK A SER ATRIBUÌDO A TECLA F4.DEFAULT = NENHUM.
//CINICPOS - STRING COM O NOME DOS CAMPOS QUE DEVEM SER INICIALIZADOS AO TECLAR SETA PARA BAIXO (GETDADOS).
//NMAX - LIMITA O N˙MERO DE LINHAS (GETDADOS).DEFAULT = 99.
//ACORDW - ARRAY COM QUATRO ELEMENTOS NUMÈRICOS, CORRESPONDENDO ‡S COOR-DENADAS LINHA SUPERIOR, COLUNA ESQUERDA, LINHA INTERIOR E COLUNA DIREITA, DEFININDO A ·REA DE TELA A SER USADA.DEFAULT = ¡REA DE DADOS LIVRE.
//LDELGET - DETERMINA SE AS LINHAS PODEM SER DELETADAS OU N„O (GETDADOS)DEFAULT = .T.

//          MODELO2(CTÌTULO,AC,ARODAPÈ,AGD   ,NOP  , CLOK        ,CTOK         ,[AGETSGD,BF4,CINICPOS,NMAX  ,ACORDW,LDELGET])
LRETMOD2  := MODELO2(CTITULO,AC,AR,ACGD ,NOPCX,"U_LINHAOK()","U_CTUDOOK()",       ,   ,        ,  9999999  ,ACORDW,) // FOI ALTERADO PARA VERIFICAR LINHA.
//lRetMod2:= Modelo2(cTitulo,aC,aR,aCGD ,nOpcx ,"U_LINOK()"  ,"u_TudoOk()" ,        ,   ,        ,       ,aCordw,)

//************************************************************
//USER FUNCTION INCLUIR()
//*************************************************************

IF LRETMOD2 .AND. NOPCX == 3
	
	CCODIGOTAB2  := VAL(CCODIGO)
	
	FOR _L := 1 TO LEN(ACOLS)
		IF !EMPTY(ACOLS[_L,1])
			DBSELECTAREA("SZ4")
			RECLOCK("SZ4",.T.)
			//SZ4->Z4_FILIAL  := _CFILIAL
			SZ4->Z4_NUMTAB  := CCODIGOTAB2
			SZ4->Z4_DESCRI  := CDESCRICAO   			//DESCRIC„O DA TABELA.
			SZ4->Z4_DATA    := CDATA        			//DATA DE CRIAC√O DA TABELA.
			SZ4->Z4_ATIVA   := CBLOQUEADO   			//TABELA BLOQUEADA?
			SZ4->Z4_CEPDE	:= ACOLS[_L,1]              //CEP DE
			SZ4->Z4_CEPATE	:= ACOLS[_L,2]              //CEP ATE
			SZ4->Z4_ESTADO  := ACOLS[_L,3]              //ESTADO DA FAIXA
			SZ4->Z4_LOCALIZ := ACOLS[_L,4]              //LOCALIZACAO (CAPITAL - INTERIOR)
			SZ4->Z4_DESCCEP	:= ACOLS[_L,5]              //DESCRICAO DA LINHA DO CEP
			SZ4->Z4_TRANSPO := ACOLS[_L,6]              //TRANSPORTADORA DA REGIAO
			SZ4->Z4_IDEALCA	:= ROUND(ACOLS[_L,7],2)     //% IDEAL PARA CARRO PROPRIO
			SZ4->Z4_MINCARR	:= ROUND(ACOLS[_L,8],2)     //VALOR MINIMO DO CARRO PROPRIO
			SZ4->Z4_SEGUROC	:= ROUND(ACOLS[_L,9],2)     //VALOR DO SEGURO PARA CARRO PROPRIO
			SZ4->Z4_MERCCAR	:= ROUND(ACOLS[_L,10],2)  	//VALOR DE MERCADO DO CARRO PROPRIO
			SZ4->Z4_ENTCARR := ACOLS[_L,11]				//DIAS DE ENTREGA PARA CARRO PROPRIO
			SZ4->Z4_IDEALSE	:= ROUND(ACOLS[_L,12],2)    //% IDEAL PARA O SEDEX
			SZ4->Z4_MINSEDE	:= ROUND(ACOLS[_L,13],2)    //VALOR MINIMO DO SEDEX
			SZ4->Z4_SEGUROS	:= ROUND(ACOLS[_L,14],2)    //VALOR DO SEGURO DO SEDEX
			SZ4->Z4_MERCSED	:= ROUND(ACOLS[_L,15],2)    //VALOR DE MERCADO DO SEDEX
			SZ4->Z4_ENTSEDE := ACOLS[_L,16]				//DIAS DE ENTREGA PARA SEDEX
			SZ4->Z4_IDEALTR	:= ROUND(ACOLS[_L,17],2)    //% PARA A TRANSPORTADORA
			SZ4->Z4_MINTRAN	:= ROUND(ACOLS[_L,18],2)    //VALOR MINIMO PARA A TRANSPORTADORA
			SZ4->Z4_SEGUROT	:= ROUND(ACOLS[_L,19],2)    //VALOR DO SEGURO PARA TRANSPORTADORA
			SZ4->Z4_MERCTRA := ROUND(ACOLS[_L,20],2)    //VALOR DE MERCADO DA TRANSPORTADORA
			SZ4->Z4_ENTTRAN := ACOLS[_L,21]				//DIAS DE ENTREGA PARA A TRANSPORTADORA
			MSUNLOCK()
		ENDIF
	NEXT _L
	
	CDESCRICAO  := "  "
	CDATA       := "  "
	CCODIGO     := "  "
	
ENDIF

//**************************************************************//
//FUNCAO DE ALTERAR()							                //
//IRA PEGAR AS VARIAVEIS CARRAGEDAS ANTERIOR MAIS AS ALTERAÁOES //
//MAIS REALIZADAS E REGRAVAR NA TABELA.							//
//**************************************************************//

IF LRETMOD2 .AND. NOPCX == 4
	
	CCODIGOTAB2  := CCODIGO
	CCODIGOTAB3  := CCODIGO	+ 1
	
	FOR _L := 1 TO LEN(ACOLS)
		IF !EMPTY(ACOLS[_L,1])
			DBSELECTAREA("SZ4")
			RECLOCK("SZ4",.T.)
			SZ4->Z4_FILIAL  := _CFILIAL
			SZ4->Z4_NUMTAB  := CCODIGOTAB3
			SZ4->Z4_DESCRI  := CDESCRICAO   			//DESCRIÁ„O DA TABELA.
			SZ4->Z4_DATA    := CDATA        			//DATA DE CRIAÁ„O DA TABELA.
			SZ4->Z4_ATIVA   := CBLOQUEADO				//TABELA BLOQUEADA?
			SZ4->Z4_CEPDE	  := ACOLS[_L,1]              //CEP DE
			SZ4->Z4_CEPATE	:= ACOLS[_L,2]              //CEP ATE
			SZ4->Z4_ESTADO  := ACOLS[_L,3]              //ESTADO DA FAIXA
			SZ4->Z4_LOCALIZ := ACOLS[_L,4]              //LOCALIZACAO (CAPITAL - INTERIOR)
			SZ4->Z4_DESCCEP := ACOLS[_L,5]              //DESCRICAO DA LINHA DO CEP
			SZ4->Z4_TRANSPO := ACOLS[_L,6]              //TRANSPORTADORA DA REGIAO
			SZ4->Z4_IDEALCA	:= ROUND(ACOLS[_L,7],2)     //% IDEAL PARA CARRO PROPRIO
			SZ4->Z4_MINCARR := ROUND(ACOLS[_L,8],2)     //VALOR MINIMO DO CARRO PROPRIO
			SZ4->Z4_SEGUROC	:= ROUND(ACOLS[_L,9],2)     //VALOR DO SEGURO PARA CARRO PROPRIO
			SZ4->Z4_MERCCAR	:= ROUND(ACOLS[_L,10],2)  	//VALOR DE MERCADO DO CARRO PROPRIO
			SZ4->Z4_ENTCARR := ACOLS[_L,11]				//DIAS DE ENTREGA PARA CARRO PROPRIO
			SZ4->Z4_IDEALSE	:= ROUND(ACOLS[_L,12],2)    //% IDEAL PARA O SEDEX
			SZ4->Z4_MINSEDE	:= ROUND(ACOLS[_L,13],2)    //VALOR MINIMO DO SEDEX
			SZ4->Z4_SEGUROS	:= ROUND(ACOLS[_L,14],2)    //VALOR DO SEGURO DO SEDEX
			SZ4->Z4_MERCSED	:= ROUND(ACOLS[_L,15],2)    //VALOR DE MERCADO DO SEDEX
			SZ4->Z4_ENTSEDE := ACOLS[_L,16]				//DIAS DE ENTREGA PARA SEDEX
			SZ4->Z4_IDEALTR	:= ROUND(ACOLS[_L,17],2)    //% PARA A TRANSPORTADORA
			SZ4->Z4_MINTRAN	:= ROUND(ACOLS[_L,18],2)    //VALOR MINIMO PARA A TRANSPORTADORA
			SZ4->Z4_SEGUROT	:= ROUND(ACOLS[_L,19],2)    //VALOR DO SEGURO PARA TRANSPORTADORA
			SZ4->Z4_MERCTRA := ROUND(ACOLS[_L,20],2)    //VALOR DE MERCADO DA TRANSPORTADORA
			SZ4->Z4_ENTTRAN := ACOLS[_L,21]				//DIAS DE ENTREGA PARA A TRANSPORTADORA
			MSUNLOCK()
		ENDIF
	NEXT _L
	
	dbSelectArea("SZ4")
	dbSetOrder(1)
	dbGoTop()
	
	while! eof()
		
		IF SZ4->Z4_NUMTAB == CCODIGO
			
			RECLOCK("SZ4",.F.)
			dbDelete()
			//SZ4->Z4_ATIVA := "1"
			MSUNLOCK()
			
		ENDIF
		
		dbskip()
	enddo
	
	CCODIGOTAB2 := "  "
ENDIF

//************************************************************
//VALIDAÁ„O LINHA OK                                                   Z
//*************************************************************

USER FUNCTION LINHAOK()

LLINHA	:= .T.

RETURN LLINHA

//************************************************************
//VALIDAÁ„O OK
//*************************************************************

USER FUNCTION CTUDOOK()

LLINHA	:= .T.

RETURN LLINHA
