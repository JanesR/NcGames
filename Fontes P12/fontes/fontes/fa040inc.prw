#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"
#define clr Chr(13)+Chr(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA040INC  �Autor  �Hermes Ferreira     � Data �  03/01/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para realizar o relacionamento do titulo a ���
���          �pagar com p VPC.Caso n�o seja escolhida um VPC n�o � permi- ���
���          �tido gerar o titulo.S� poder� ser selecionado o VPC que ja  ���
���          �esteja apurado. O valor do t�tulo ser� o valor apurado para ���
���          �o cliente+ loja do t�tulo. A verifica��o � feita apenas para���
���          �titulos tipo NCC e prefixo VPC                              ���
�������������������������������������������������������������������������͹��
���Uso       � Nc Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
										"Tipo de t�tulo a considerar para o relacionamento com VPC."	,;
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FGetVPCNCC�Autor  �Hermes Ferreira     � Data �  19/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existir� relacionamento do NCC com o titulo e   ���
���          �atualiza o titulo com o VPC relacionado                     ���
�������������������������������������������������������������������������͹��
���Uso       �NC Games                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
		
			Aviso("FA040INC - 02","Para este tipo e prefixo informado no t�tulo, deve ser informado um VPC apurado." ,{"Ok"},3)
			lRet := .F.
			
		EndIf
		
	Else
	
		Aviso("FA040INC - 01","N�o h� VPC Vigente e Apurado para o cliente "+Alltrim(GetAdvFVal( "SA1", "A1_NOME", xFilial( "SA1" ) + SE1->(E1_CLIENTE+E1_LOJA), 1, "" )+" e n�o ser� poss�vel gerar o t�tulo." ),{"Ok"},3)
		lRet := .F.
		
	EndIf
	
	IIF(Select((clAlias)) > 0,(clAlias)->(dbCloseArea()),.f.  )
	
	RestArea(aAreaSA1)
	
Return lRet
	
