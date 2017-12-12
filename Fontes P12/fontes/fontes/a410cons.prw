#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A410CONS  ºAutor  ³Rafael Augusto      º Data ³  06/16/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Adicionar botoes ao cabecalho do Pedido de Venda, onde os  º±±
±±º          ³ irao chamar funcoes restritas.                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A410CONS()
Local lPvSimul		:=IsInCallStack("U_PR107PVSIMUL")
Public _aButtons  := {}
Public _cRotina   := "A410CONS"

If IsInCallStack("a410Inclui")
	n:=1
EndIf

_lRet             := .T.

If !lPvSimul
	
	IF INCLUI == .T. .AND. M->C5_GEROFRE == "1"
		M->C5_GEROFRE   := " "
		M->C5_FRETE     := 0.00
		M->C5_SEGURO    := 0.00
		M->C5_FRETEORI  := 0.00
		M->C5_MODAL     := " "
		M->C5_MODORIG   := " "
		M->C5_MOTFRET   := " "
		M->C5_ZMOTIVO   := " "
		M->C5_ALTFRETE  := " "
	ENDIF
	
	If M->C5_VEND1 <> "VN9900"
		//  If GETADVFVAL("SA1","A1_TEMODAL",xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI,1,Space(01)) == "1"
		//        AAdd(_aButtons,{"SIMULACAO"    ,{|| U_CALCFRETE()}   ,"Calcula Preco do Frete!"})
		//    Else
		AAdd(_aButtons,{"SIMULACAO"    ,{|| U_P202CALCFRETE()}   ,"Calcula Preco do Frete!"})
		//    EndIf
	EndIf
	
	AAdd(_aButtons,{"ALTERA"       ,{|| U_MFRETE(.T.)}      ,"Visualiza Tabela de Frete/CEP"})
	
	IF ALTERA == .T.
		AAdd(_aButtons,{"CARGA"        ,{|| U_VERIFICMODAL()},"Recalcula o valor do Frete! De acordo com o Modal!"})
	ENDIF
	
	IF INCLUI
		AAdd(_aButtons,{"VENDEDOR",{|| U_IMPNFEHT()},"Importa PV Excel"})
	ENDIF
	
	AAdd(_aButtons,{"FORM",{|| U_VERDSCMD()},"Analise Desc"})
	AAdd(_aButtons,{"SIMULACA",{|| U_DBSC6PRO() },"Importa Orcamento NC"})
	
	IF INCLUI .Or. ALTERA
		AAdd(_aButtons,{"SIMULACA",{|| U_PR708Over() },"Aplicar OverPrice"})
	EndIf
Else
	AAdd(_aButtons,{"FORM",{|| U_VERDSCMD()},"Analise Desc"}) 
	AAdd(_aButtons,{"VENDEDOR",{|| U_IMPNFEHT()},"Importa PV Excel"})
	AAdd(_aButtons,{"SIMULACA",{|| U_PR107Over() },"Aplicar OverPrice"})
	AAdd(_aButtons,{"SIMULACA",{|| U_PR708sVpc() },"Simulação VPC e VE"})
Endif

//Inclui botão de consulta a NF´s enviadas para lojas
 AAdd(_aButtons,{"CONSPRDLJ",{|| u_NCCPRDLJ() },"Cons.Produto Lojas"})



//Usamos esse ponto de entrada para complementar a customização do P.E M410GET, a fim de atualizar o RODAPE para as alterações.
// Hermes - 04/03/12 - DBM - Projeto VPC/VERBA
//If !INCLUI
//	A410LinOk()
//EndIf

Return(_aButtons)

