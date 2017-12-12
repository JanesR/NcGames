#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณM450ABRW  บAutor  ณMicrosiga  	        บ Data ณ  09/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para filtro do Browse da rotina			 	  บฑฑ
ฑฑบ          ณanalise de credito de cliente MATA450A                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function M450ABRW()
	Local aArea 	:= GetArea()
	Local cRetFil	:= ""
	Local cQuery 	:= PARAMIXB[1]
	Local lPvSite	:= IsInCallStack("U_ECAnCred")
	Local cBloqLib :=AllTrim(U_MyNewSX6(	"NCG_000067", "S", "C", 	"Bloquear Liberacao do PV S=Sim ou N=Nao","","",	.F. ))
	Local cCanUser	:=AllTrim(U_MyNewSX6(	"NCG_000068", "", "C", 	"ID do usuario com permissao de liberacao mesmo que o paramatro NCG_000067=S(separado por ;)","","",	.F. ))

	Local lPedidosFat:=.F.
	Local aParamBox	:={}
	Local aRet		:={}
	Local nOpcao
	Local aOpcoes	:={"Todos","Somente Pedidos de e-commerce Faturado"}
	Local aMvs		:={mv_par01}

	aAdd(aParamBox,{2,"Selecione Filtro",1,aOpcoes,110,"",.T.})

	If !lPvSite .And. ParamBox(aParamBox,"Parametros",@aRet,,,,,,,,.F.) 

		If ValType(aRet[1])=="N"
			nOpcao:=aRet[1]
		Else
			nOpcao:= Ascan(aOpcoes, aRet[1] )
		EndIf

		lPedidosFat:=(nOpcao==2)


	EndIf	
	mv_par01:=aMvs[1]

	If cBloqLib=="S" .And. !__cUserID$cCanUser
		MsgStop("Processo de libera็ใo bloqueado.","NcGames")
		cRetFil:=" And 1=2"//Retorno uma condicao falsa para nใo aparecer nenhum resgistro no Browse
	Else	
	
		If lPvSite .Or. lPedidosFat
			cRetFil	+=" AND SC5.C5_XECOMER = 'C' "
			If lPedidosFat
				cRetFil	+=" AND SC5.C5_XCIAFAT = 'S' "
			EndIf

		Else
			cRetFil	+=" AND SC5.C5_XECOMER <> 'C' "
		EndIf

		cRetFil	+=" AND C9_FILIAL BETWEEN '  ' AND 'ZZ'"
		cRetFil	+=" AND C9_PEDIDO BETWEEN '      ' AND 'ZZZZZZ'"

	EndIf                                                       

	cRetFil := cQuery += cRetFil


	RestArea(aArea)
Return  cRetFil
