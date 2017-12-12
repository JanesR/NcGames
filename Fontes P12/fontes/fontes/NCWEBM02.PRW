/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCWEBM02  ºAutor  ³Microsiga           º Data ³  04/26/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCWEBM02()
Local aArea			:= GetArea()
Local cAliasQry   := "WM"//GetNextAlias()
Local nConecAtual := 0
Local nConection  := 0
Local cConectStr
Local cServer
Local nPortConect
RpcSetEnv("40","01")

cFilSB1:=xFilial("SB1")

cConectStr	:= U_MyNewSX6("NC_NBCABWM","","C","Nome do Banco e ambiente. Exemplo:  'MSSQL7/WebManager'",	"Nome do Banco e ambiente. Exemplo:'MSSQL7/WebManager'","Nome do Banco e ambiente.Exemplo:'MSSQL7/WebManager'",.F. )
cServer		:= U_MyNewSX6("NC_IPSRVWM","","C","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.217 ","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.217 ","IP do servidor, para acesso ao banco. Exemplo: 192.168.0.217 ",.F. )
nPortConect	:= U_MyNewSX6("NC_PORTWM","","N","Porta de acesso p/ comunicação com o banco de dados. Exemplo: 7890","Porta de acesso p/ comunicação com o banco de dados. Exemplo: 7890","Porta de acesso p/ comunicação com o banco de dados. Exemplo: 7890",.F. )

nConecAtual := AdvConnection()
nConection 	:= TcLink(cConectStr ,  cServer , nPortConect  )

TcSetConn( nConection )

cQuery:="select cod_produto,Nome from uzgames.dbo.pkbproduto Where ativo=1 and cod_produto IN (18692,23864,26596,27537,27539)"
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)

SB1->(DbSetOrder(1))
Do While (cAliasQry)->(!Eof())
	If SB1->(MsSeek(cFilSB1+AllTrim(Str((cAliasQry)->cod_produto))))
		(cAliasQry)->(DbSkip());Loop
	EndIf

	SB1->(RecLock("SB1",.T.))
	SB1->B1_FILIAL	:=cFilSB1
	SB1->B1_COD		:=AllTrim(Str((cAliasQry)->cod_produto))
	//SB1->B1_CODBAR	:=(cAliasQry)->cod_barra
	SB1->B1_DESC	:=(cAliasQry)->Nome
	SB1->B1_XDESC	:=(cAliasQry)->Nome
	SB1->(MsUnLock())

	(cAliasQry)->(DbSkip())
EndDo





TCSetConn(nConecAtual) // Restaura conexao antiga
RestArea(aArea)
Return cAliasQry  
