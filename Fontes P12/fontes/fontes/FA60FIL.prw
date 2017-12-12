/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA60FIL   ºAutor  ³Microsiga           º Data ³  05/29/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//³ Verificar a existˆncia do filtro qdo existir o ExecBlock("FA60FIL") ³
User Function FA60FIL()  //Paramixb:={cPort060,cAgen060,cConta060,cSituacao,dVencIni,dVencFim,nLimite,nMoeda,cContrato,dEmisDe,dEmisAte,cCliDe,cCliAte}
Local cFiltro:=".T.
Local cPrefECO	:=Alltrim(U_MyNewSX6(	"EC_NCG0020","ECO","C","Prefixo titulos do ecommerce","","",.F. ))                         
Local cPrefEXP	:=GetNewPar("NC_PREFEXP")
Local cPrefCC	:=Alltrim(U_MyNewSX6(	"EC_NCG0022","CC","C","Prefixo Cartao Credito","","",.F. ))                         
Local cPrefixos
Local cPrefVtex 

Local cPreUZgames	:= AllTrim(U_MyNewSX6(	"VT_NCG0002", "EUZ", "C", "Prefixo que será utilizado nos pedidos Ecommerce UZ","","",.F.)) //Prefixo dos titulos Ecommerce Uz Games
Local cPrePGames	:=	AllTrim(U_MyNewSX6(	"VT_NCG0003", "EPG", "C", "Prefixo que será utilizado nos pedidos Ecommerce Proximo Games","","",.F.))//Prefixo dos titulos Ecommerce Proximo Grames
Local cPreMarket	:= AllTrim(U_MyNewSX6(	"VT_NCG0004", "EMP", "C", "Prefixo que será utilizado nos pedidos Ecommerce MarketPlace","","",.F.))//Prefixo dos titulos Ecommerce Marketplace

cPrefECO	:=Padr(cPrefECO,AvSx3("E1_PREFIXO",3))
cPrefEXP	:=Padr(cPrefEXP,AvSx3("E1_PREFIXO",3))
cPrefCC	:=Padr(cPrefCC ,AvSx3("E1_PREFIXO",3))
cPrefVtex:=Padr(cPreUZgames ,AvSx3("E1_PREFIXO",3)) +"*"+ Padr(cPrePGames ,AvSx3("E1_PREFIXO",3))+"*"+Padr(cPreMarket ,AvSx3("E1_PREFIXO",3))+"*"

cPrefixos:=cPrefECO+"*"+cPrefEXP+"*"+cPrefCC+"*"+cPrefVtex

cFiltro:="!( SE1->E1_PREFIXO$'"+cPrefixos+"')"
Return cFiltro
