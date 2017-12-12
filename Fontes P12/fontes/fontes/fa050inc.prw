#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA050INC  บ Autor ณ Rogerio Souza      บ Data ณ  08/12/2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Ponto de Entrada para validar a inclusใo de um titulo no   บฑฑ
ฑฑบ          ณ contas a pagar, somente serแ liberado a inclusao para      บฑฑ
ฑฑฐ          ณ para usuarios que estejam dentro do parametro.             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP10 R1.3 - NC GAMES - Supertech Consulting LTDA.		     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function FA050INC

Local lRet := .F.
Local aAreaSE2		:= SE2->(GetArea())
Local cChaveTIT		:= ""

Local cPrefxVerba	:= U_MyNewSX6(	"NCG_000017"	 								,;
									"VER"											,;
									"C"												,;
									"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
									"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
									"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
									.F. )
									
Local cTpTitVld	:= U_MyNewSX6(	"NCG_TP_PAG"	 								,;
									"-TX/-BOL/UNI-PA/RMB-RC"							,;
									"C"												,;
									"Prefixo+'-'+Tipo de tํtulo vแlido para lan็amento manual."		,;
									"Prefixo+'-'+Tipo de tํtulo vแlido para lan็amento manual."		,;
									"Prefixo+'-'+Tipo de tํtulo vแlido para lan็amento manual."		,;
									.F. )

									
If (ALLTRIM(UPPER(cUsername)) $ (ALLTRIM(UPPER(GETMV("MV_INC_PAG")))) .and. ALLTRIM(M->E2_PREFIXO)+"-"+ALLTRIM(M->E2_TIPO) $ cTpTitVld  ).or. IsInCallStack("u_FFRTSSE2") .or. !(Funname()=="FINA050")

	lRet := .T.
	
Else

	If !(ALLTRIM(M->E2_PREFIXO)+"-"+ALLTRIM(M->E2_TIPO) == "UNI-PA")
		lRet := .F.
		ALERT("Usuario sem acesso para incluir esse tipo de titulo, favor consultar o Administrador do sistema ")
	Else
		lRet := .T.
	EndIf
	
EndIf

If lRet

	// Caso nใo seja escolhida uma verba ou nใo tenha saldo suficiente para consumo da verba,nใo ้ permitido gerar o titulo.
	If Alltrim(M->E2_PREFIXO) == Alltrim(cPrefxVerba)

		lRet := .F.
		cChaveTIT := M->E2_FORNECE + M->E2_LOJA + M->E2_PREFIXO + M->E2_NUM + M->E2_PARCELA + M->E2_TIPO

		MSGRUN("Consultando se existe Verba aprovada para este cliente... ","Aguarde..",{|| lRet := FGetVERBA(M->E2_FORNECE, M->E2_LOJA , M->E2_EMISSAO,M->E2_VALOR,cPrefxVerba,cChaveTIT) })

	EndIf

	RestArea(aAreaSE2)

EndIf

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGetVERBA บAutor  ณHermes Ferreira     บ Data ณ  20/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFAz o relacionamento do Titulo a pagar com uma verba        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGetVERBA(cFornece, _cLoja, dDtEmissao,nValorTIT,cPrefxVerba,cChaveTIT)
	Local lRet		:= .T.
	Local clAlias	:= GetNextAlias()
	Local cQry		:= ""
	Local aVPC		:= {}
	Local cVerba	:= ""
	Local cVersao	:= ""
	Local nC		:= 0
	Local lAlcada	:= .F.

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cCliLoj:= FGetCliVPC(cFornece, _cLoja)

	cCliente := SubStr(cCliLoj,1, At("/",cCliLoj) - 1)
	cLoja := SubStr(cCliLoj, At("/",cCliLoj) + 1)

	Processa( { ||  U_SQLVPCCTS(clAlias,cCliente, cLoja, dDtEmissao,"2")} , "Consultando relacionamento de Verba" )

	(clAlias)->(dbGoTop())

	If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())

		aVPC 	:= U_GETVPCCT(clAlias,cCliente, cLoja, dDtEmissao,"2",nValorTIT)

		If Len(aVPC) > 0

			nC		:= 0

			For nC := 1 to Len (aVPC)
				M->E2_YVPC 		:= Alltrim(aVPC[nC,1])
				M->E2_YVERVPC	:= Alltrim(aVPC[nC,2])
			Next nC

			lRet := .T.

		Else

			Aviso("FA050GRV - 02","Para este prefixo informado no tํtulo, deve ser informado uma Verba aprovada." ,{"Ok"},3)
			lRet := .F.

		EndIf

	Else

		Aviso("FA050GRV - 01","Nใo hแ Verba Vigente para este fornecedor e o tํtulo nใo poderแ ser gerado.",{"Ok"},3)
		lRet := .F.

	EndIf

	IIF(Select((clAlias)) > 0,(clAlias)->(dbCloseArea()),.f.  )


Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGetCliVPCบAutor  ณHermes Ferreira     บ Data ณ  20/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca o codigo como cliente para o fornecedor informado no  บฑฑ
ฑฑบ          ณtitulo a pagar                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FGetCliVPC(cFornece, cLoja)

	Local cCGCFor	:= ""

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	cCGCFor := Alltrim(GetAdvFVal( "SA2", "A2_CGC", xFilial( "SA2" ) + cFornece+cLoja , 1, "" ) )


	cCliente:=Alltrim(GetAdvFVal( "SA1", "A1_COD" , xFilial( "SA1" ) + cCGCFor , 3, "" ) )
	cLoja 	:=Alltrim(GetAdvFVal( "SA1", "A1_LOJA", xFilial( "SA1" ) + cCGCFor , 3, "" ) )

Return cCliente+"/"+cLoja
