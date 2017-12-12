#INCLUDE "APWEBSRV.CH"
#INCLUDE "PROTHEUS.CH"

/*
�������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������
���������������������������������������������������������������������������������ͻ��
���M�todo    �NCGWS002          �Autor  �FELIPE V. NAMBARA   � Data �  09/24/12   ���
���������������������������������������������������������������������������������͹��
���Desc.     �WEB SERVICE PARA CONSULTA DE INFORMA��ES PARA O CAT�LOGO DE PRODUTOS ��
���������������������������������������������������������������������������������͹��
���Uso       �NC GAMES - CAT�LOGO DE PRODUTOS                                     ���
���������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������
*/

User Function NCGWS002()
Return()

WSSTRUCT tFreteInfo

	WSDATA Codigo_Transportadora  	As String
	WSDATA Percentual_Frete  		As Float
	WSDATA Valor_Minimo  			As Float
	WSDATA Percentual_Seguro  		As Float
	WSDATA Prazo_Entrega	  		As Float
	WSDATA Observacao		  		As String
	WSDATA Valor_Frete		  		As Float
	WSDATA Valor_Seguro		  		As Float
	WSDATA CalculouFrete		  	As Boolean
		
ENDWSSTRUCT

WSSTRUCT tItens
	
	WSDATA Itens 		As Array Of tEstruturaItem 
	
ENDWSSTRUCT


WSSTRUCT tEstruturaItem
	
	WSDATA Codigo_Produto  		As String
	WSDATA Quantidade_Produto  	As Float
	WSDATA Preco_Produto  		As Float
	
ENDWSSTRUCT

WSSERVICE NCGWS002 DESCRIPTION "NC GAMES - Web-Service para consulta de informa��es referente ao Cat�logo de Produtos" NAMESPACE "" 

	WSDATA Snd_FreteInfo 	As tFreteInfo
	WSDATA Snd_Filial		As String
	WSDATA Rec_Itens	 	As tItens
	WSDATA Rec_CEP		 	As String
	WSDATA Rec_Time		 	As String
	WSDATA Rec_Time2		 	As String
		
	WSMETHOD GetFreteInfo	DESCRIPTION "M�todo que retorna as informacoes referente ao frete da prospec��o"
	WSMETHOD GetTime		DESCRIPTION "M�todo que retorna o horario do servidor"
		
ENDWSSERVICE

WSMETHOD GetTime WSRECEIVE Rec_Time2 WSSEND Rec_Time WSSERVICE NCGWS002

Self:Rec_Time:=Time()

Return(.T.)

                    
/*
�������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������
���������������������������������������������������������������������������������ͻ��
���M�todo    �GetFreteInfo      �Autor  �FELIPE V. NAMBARA   � Data �  09/24/12   ���
���������������������������������������������������������������������������������͹��
���Desc.     �M�todo que retorna o valor do frete e prazo de entrega.             ���
���          �                                                                    ���
���������������������������������������������������������������������������������͹��
���Uso       �NC GAMES - F�BRICA DE SOFTWARE                                      ���
���������������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������������
�������������������������������������������������������������������������������������
*/

WSMETHOD GetFreteInfo WSRECEIVE Rec_CEP, Rec_Itens, Snd_Filial WSSEND Snd_FreteInfo WSSERVICE NCGWS002
	Local aInfoFrete 	:= {}
	Local aMyHeader		:= {{"","C6_PRODUTO"},{"","C6_QTDVEN"},{"","C6_TOTAL"}}
	Local aMyCols		:= {}
	Local nCont1		:=0

//	ErrorBlock( { |oErro| U_MySndError(oErro) } )

	Begin Sequence	
		
		For nCont1 := 1 To Len(Rec_Itens:ITENS)
			
			aAdd(aMyCols,{Rec_Itens:ITENS[nCont1]:CODIGO_PRODUTO, Rec_Itens:ITENS[nCont1]:QUANTIDADE_PRODUTO, Rec_Itens:ITENS[nCont1]:QUANTIDADE_PRODUTO * Rec_Itens:ITENS[nCont1]:PRECO_PRODUTO, .F. })
			
		Next nCont1
	
		If Empty(Self:Snd_Filial)
			Self:Snd_Filial := "03"
		EndIf
		
		RpcSetEnv(SM0->M0_CODIGO,Self:Snd_Filial)
					
		aInfoFrete := U_CalcFr(Self:Rec_CEP, aMyHeader, aMyCols )
		
		Self:Snd_FreteInfo:Codigo_Transportadora 	:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "CODIGO_TRANSPORTADORA"})][2]
		Self:Snd_FreteInfo:Percentual_Frete 		:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2]
		Self:Snd_FreteInfo:Valor_Minimo 			:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2]
		Self:Snd_FreteInfo:Percentual_Seguro		:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2]
		Self:Snd_FreteInfo:Prazo_Entrega			:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "PRAZO_ENTREGA_TRANSPORTADORA"})][2]
		Self:Snd_FreteInfo:Observacao 				:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "OBSERVACAO_FRETE"})][2]
		Self:Snd_FreteInfo:Valor_Frete 				:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "VALOR_FRETE"})][2]
		Self:Snd_FreteInfo:Valor_Seguro 			:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "VALOR_SEGURO"})][2]
		Self:Snd_FreteInfo:CalculouFrete 			:= aInfoFrete[aScan(aInfoFrete,{|x| x[1] == "CALCULOU_FRETE"})][2]
	
	End Sequence
	
Return(.T.)