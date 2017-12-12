#INCLUDE "RWMAKE.CH"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function MOD3SZHJ()
Private _aArea    := GetArea()
Private _cUser    := RetCodUsr(Substr(cUsuario,1,6))
Private cCadastro := "Tabela de Preço Intermediaria"

Private aCores	  := {{"ZJ_STATUS=='1'" 	    ,"BR_VERDE"},{"ZJ_STATUS=='2'","BR_VERMELHO"},{"ZJ_STATUS=='3'","BR_PINK"},{"ZJ_STATUS=='4'","BR_PRETO"},{"ZJ_STATUS=='5'","BR_AMARELO"}}

dbSelectArea("SZJ")
dbSetOrder(1)

Private a3Rotina  := {{ "Buscar Produtos"       ,"U_INC02SZHJ()" ,0,3,0,NIL},;
			             { "Busca Lista Anterior"  ,"U_INC03SZHJ()" ,0,3,0,NIL},;
					       { "Incluir Manualmente"   ,"U_INC01SZHJ()" ,0,3,0,NIL}}


Private aRotina   := {{ "Pesquisar"             ,"AxPesqui"      , 0, 1},;
                      { "Visualizar"            ,"U_VIS01SZHJ"   , 0, 2},;
                      { "Incluir"               , a3Rotina       , 0, 3},;
	        	          { "Altera"                ,"U_ALT01SZHJ"   , 0, 4},;
                      { "Excluir"               ,"U_EXC01SZHJ"   , 0, 5},;
                      { "Legenda"               ,"U_BLegenda"    , 0, 6}}

mBrowse( 6,1,22,75,"SZJ",,,,,,aCores)

RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function BLegenda()
Private aLegenda  := {}
Private cCadastro := "Tabela de Preço Intermediaria"
AADD(aLegenda,{"BR_VERDE"     ,"Aprovada - Pendente Efetivacao" })
AADD(aLegenda,{"BR_VERMELHO"  ,"Concluida" })
AADD(aLegenda,{"BR_PINK"      ,"Parcialmente Aprovada" })
AADD(aLegenda,{"BR_PRETO"     ,"Pendente Aprovacao" })
AADD(aLegenda,{"BR_AMARELO"   ,"Rejeitada" })
BrwLegenda(cCadastro,"Legenda",aLegenda)
Return
/*/
	                  {'ZJ_STATUS="3"'	        ,'BR_AMARELO'},;
	                  {'ZJ_STATUS="4"'	        ,'BR_PRETO'  },;
	                  {'ZJ_STATUS="5"'	        ,'BR_LARANJA'},;
	                  {'ZJ_STATUS=" "'	        ,'BR_PINK'   }}


AADD(aLegenda,{"BR_PRETO"  ,"Pendente Aprovação" })
AADD(aLegenda,{"BR_LARANJA","Rejeitada" })
AADD(aLegenda,{"BR_AMARELO","Parcialmente Aprovada" })
AADD(aLegenda,{"BR_PINK"   ,"Indefinida" })
/*/