#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"
#define clr Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA040INC  ºAutor  ³Hermes Ferreira     º Data ³  03/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para realizar o relacionamento do titulo a º±±
±±º          ³pagar com p VPC.Caso não seja escolhida um VPC não é permi- º±±
±±º          ³tido gerar o titulo.Só poderá ser selecionado o VPC que ja  º±±
±±º          ³esteja apurado. O valor do título será o valor apurado para º±±
±±º          ³o cliente+ loja do título. A verificação é feita apenas paraº±±
±±º          ³titulos tipo NCC e prefixo VPC                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA040INC()
	
	Local lRet := .T.
	
	Local aAreaSE1		:= SE1->(GetArea())
	Local cChaveTIT 	:= ""
	Local cPrefixoVPC	:= Alltrim(U_MyNewSX6(	"NCG_000016"							,;
										"VPC"											,;
										"C"												,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										.F. ))

	Local cTipoTIT	:= Alltrim(U_MyNewSX6(	"NCG_000018"		 						,;
										"NCC"											,;
										"C"												,;
										"Tipo de título a considerar para o relacionamento com VPC."	,;
										"Tipo de título a considerar para o relacionamento com VPC."	,;
										"Tipo de título a considerar para o relacionamento com VPC."	,;
										.F. ))
	
If !IsInCallStack("U_R709GeraNCC")
	
	If Alltrim(M->E1_TIPO) $ cTipoTIT .AND. Alltrim(M->E1_PREFIXO) == Alltrim(cPrefixoVPC)
	
		lRet := .F.
		cChaveTIT := M->E1_CLIENTE+ M->E1_LOJA + M->E1_PREFIXO + M->E1_NUM + M->E1_PARCELA + M->E1_TIPO
		
		MSGRUN("Consultando se existe VPC Apurado para este cliente... ","Aguarde..",{|| lRet := FGetVPCNCC(M->E1_CLIENTE, M->E1_LOJA , M->E1_EMISSAO,M->E1_VALOR,cPrefixoVPC,cChaveTIT)  })
		
	EndIf
	
EndIf
	RestArea(aAreaSE1)
	
		
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FGetVPCNCCºAutor  ³Hermes Ferreira     º Data ³  19/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se existirá relacionamento do NCC com o titulo e   º±±
±±º          ³atualiza o titulo com o VPC relacionado                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FGetVPCNCC(cCliente, cLoja, dDtEmissao,nValorTIT,cPrefixoVPC,cChaveTIT)
	
	Local clAlias	:= GetNextAlias()    
	Local cQry		:= ""
	Local aVPC		:= {}
	Local cVPC		:= ""
	Local cVersao	:= ""
	Local nC		:= 0
	Local lAlcada	:= .F.
	Local lRet 		:= .F.
	Local aAreaSA1	:= SA1->(GetArea())
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )
	
	Processa( { ||  U_SQLVPCCTS(clAlias,cCliente, cLoja, dDtEmissao,"1")} , "Consultando relacionamento de VPC" ) 
	
	(clAlias)->(dbGoTop())
	
	If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
		
		aVPC 	:= U_GETVPCCT(clAlias,cCliente, cLoja, dDtEmissao,"1",nValorTIT)

		If Len(aVPC) > 0
		
			nC		:= 0
			
			For nC := 1 to Len (aVPC)
			
				M->E1_YVPC 		:= Alltrim(aVPC[nC,1])
				M->E1_YVERVPC	:= Alltrim(aVPC[nC,2])
				
				M->E1_YAPURAC 	:=  Alltrim(aVPC[nC,3])
				M->E1_VALOR 	:=  aVPC[nC,4]
				M->E1_VLCRUZ	:=  aVPC[nC,4]
				
			Next nC
			
			lRet := .T.
			
		Else
		
			Aviso("FA040INC - 02","Para este tipo e prefixo informado no título, deve ser informado um VPC apurado." ,{"Ok"},3)
			lRet := .F.
			
		EndIf
		
	Else
	
		Aviso("FA040INC - 01","Não há VPC Vigente e Apurado para o cliente "+Alltrim(GetAdvFVal( "SA1", "A1_NOME", xFilial( "SA1" ) + SE1->(E1_CLIENTE+E1_LOJA), 1, "" )+" e não será possível gerar o título." ),{"Ok"},3)
		lRet := .F.
		
	EndIf
	
	IIF(Select((clAlias)) > 0,(clAlias)->(dbCloseArea()),.f.  )
	
	RestArea(aAreaSA1)
	
Return lRet
	
