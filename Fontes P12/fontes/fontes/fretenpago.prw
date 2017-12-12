#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FRETENPAGO() º Autor³RAFAEL AUGUSTO      º Data ³  14/06/10 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ CALCULA O MODAL PARA QUANDO O CLIENTE NAO PAGAR O FRETE,   º±±
±±º          ³ POIS E NECESSARIO A EMPRESA NC GAMES SABER QUAL E O MELHOR º±±
±±º          ³ MODAL A SER USADO NESSE MOMENTO.							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10 NC GAMES                                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FRETENPAGO()

_aArea     			:= GetArea()
_nNumPed	        := M->C5_NUM
_cCliente    		:= M->C5_CLIENTE
_cLojaCli   	  	:= M->C5_LOJACLI
_nCepCli     	    := " "
_cProduto           := " "
_cSomaTotal         := 000
_cDimenssao         := 00
_FreteSim           := "N"
_Localiz            := " "
_cFrete             := 000
_nCepCli            := "  "
_cTransp            := "  "
_cCalcFrete         := "  "
_cTemModal          := 2

PUBLIC _cDias       := " "
Public _cDimenssao  := 00
PUBLIC _modalcarro  := " "
PUBLIC _modalsedex  := "  "
PUBLIC _modaltrans  := "  "
PUBLIC  _cSomaTotal := "  "

Private cString     := "SZ4"

//---------------------------------------------------------------------------------------------//
// Array que ira buscar as informaçoes no itens do pedido de venda, para realizar os calculos  //
//---------------------------------------------------------------------------------------------//

PUBLIC _nPosProd        := " "
PUBLIC _nPosQuant       :=" "
PUBLIC _nPosPrcVen      :=" "
PUBLIC _nPosTotal       :=" "
PUBLIC _nPosPrecoUnit   :=" "
PUBLIC _nPosPercDescPr  :=" "
PUBLIC _nPosDescontProd :=" "

_nPosProd       		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"}) //Ira pegar o campo do cod de produto.
_nPosQuant       		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})  //Ira pegar o campo da quantidade vendida.
_nPosPrcVen      		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})  //Ira pegar o campo do preco unitario.
_nPosTotal       		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})   //Ira pegar o campo do valor total do item.
_nPosPrecoUnit   		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})  //Ira pegar o campo do Preco Unitario.
_nPosPercDescPr  		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_DESCONT"}) //Ira pegar o campo do percentual do desconto no item.
_nPosDescontProd 		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"}) //Ira pegar o campo do valor do desconto no item.

//---------------------------------------------------------------------------------------------//
//Ira Buscar as tabelas envolvidas para pegar variveis indispensavies no programa.             //
//---------------------------------------------------------------------------------------------//

dbSelectArea("SA1")    				            //Abre Tabela de Cadastro de Cliente.
dbSetOrder(1)						            //Ordena pelo Codigo do Cliente.
dbSeek(xFilial() + _cCliente + _cLojaCli,.T.)	//Procura nos Registro o Cliente que está em uso.

_nCepCli    	:= SA1->A1_CEP     	    //Transformar o campo em numerico e depois pega o CEP do Cliente.
_cCalcFrete 	:= SA1->A1_FRETE        //Define se o cliente paga frete antecipado ou nao.
_cTemModal      := SA1->A1_TEMODAL      //Cliente tem modal Proprio.
_cModalProprio  := SA1->A1_MODALPR      //Qual o Modal?

dbSelectArea("SZ4")                 //Abre a Tabela de Frete por CEP e MODAL.
dbSetOrder(1)                       //Ordena por Cep De.
dbGoTop()                           //Vai para o primeiro registro da tabela.

_cSomaTotal     := 0
_cFrete			:= 0
_cDimenssao     := 0

While! EOF()
	
	_nCepDe       := SZ4->Z4_CEPDE  //Ira pegar o CEP De do primeiro registro
	_nCepAte      := SZ4->Z4_CEPATE //Ira pegar o CEP De do primeiro registro
	
	IF _nCepDe <= _nCepCli .and. _nCepAte >= _nCepCli .and. SZ4->Z4_ATIVA <> "1"  //Ira verificar se o Cep do cliente está dentro da Faixa.
		
		_FreteSim   := "S"
		_cLocaliz   := SZ4->Z4_LOCALIZ
		_cEstado    := SZ4->Z4_ESTADO
		_cTransp    := SZ4->Z4_TRANSPO
		
		//Pega os Dados do Carro Proprio.
		_nIdealCarro   := SZ4->Z4_IDEALCA
		_nMinCarro     := SZ4->Z4_MINCARR
		_nSeguroCarro  := SZ4->Z4_SEGUROC
		_nDiasCarro    := SZ4->Z4_ENTCARR
		
		//Pega os Dados do Sedex.
		_nIdealSedex   := SZ4->Z4_IDEALSE
		_nMinSedex     := SZ4->Z4_MINSEDE
		_nSeguroSedex  := SZ4->Z4_SEGUROS
		_nDiasSedex    := SZ4->Z4_ENTSEDE
		
		//Pega os Dados da Transportadora.
		_nIdealTrans   := SZ4->Z4_IDEALTR
		_nMinTransp    := SZ4->Z4_MINTRAN
		_nSeguroTrans  := SZ4->Z4_SEGUROT
		_nDiasTrans    := SZ4->Z4_ENTTRAN
		
		
		For x := 1 to Len(aCols) //Ira fazer a verificacao ate o fim dos itens.
			
			_cProduto   := ACOLS[x,_nPosProd]
			_cQuantid   := ACOLS[x,_nPosQuant]
			_cPrecoUnit := ACOLS[x,_nPosPrcVen]
			_cValorTot  := ACOLS[x,_nPosTotal]
			_cPercDesc  := ACOLS[x,_nPosPercDescPr]
			_cValDesc   := ACOLS[x,_nPosDescontProd]
			
			_cSomaTotal := _cValorTot + _cSomaTotal
			
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial() + _cProduto)
			
			IF _cQuantid > SB1->B1_QUANTSE //Informa se quantidade no cadastro do Produto e maior qu a venda
				_cDimenssao := _cDimenssao + 1//"2"
			Else
				_cDimenssao := _cDimenssao
			EndIF
			
			
		Next
		
	ENDIF
	
	dbSelectArea("SZ4")
	dbSetOrder(1)
	dbSkip()
	
EndDO

IF _FreteSIM == "S"
	
	M->FRETEORI     := 0.00
	M->FRETE        := 0.00
	
	IF _cTemModal == "1"      //Verifica se o Cliente tem modal proprio.
		
		IF _cModalProprio == "1" //_cSomaTotal >= 10000 .and. _cLocaliz == "1" .and. _cEstado == "SP" .and. _cModalProprio == "1" //Ira fazer a tratativa para o Carro Proprio.
			
			M->C5_GEROFRE   := "1"
			_cFrete         := _nMinCarro
			_cSeguro        := _nSeguroCarro
			//M->C5_FRETE     := _cFrete
			//M->C5_SEGURO    := _nSeguroCarro
			M->C5_FRETEORI  := _cFrete
			M->C5_SEGUROR   := _cSeguro
			M->C5_TRANSP    := "000001"
			M->C5_MODAL     := "1"
			M->C5_MODORIG   := "1"
			M->C5_FRETETO   := M->C5_SEGURO + M->C5_FRETE
			M->C5_FREORTO   := M->C5_SEGURO + M->C5_FRETE
			
			_cDias          := _nDiasCarro
			_modalcarro     := "Carro Proprio"
			
			Alert("Vai de Carro Proprio!!!")
			
		ElseIF _cModalProprio == "2" //_cSomaTotal < 10000 .and. _cDimenssao == 0 .and. _cModalProprio == "2" //<> "2"  //Ira fazer a tratativa para o Sedex.
			
			M->C5_GEROFRE   := "1"
			_cFrete         := (_cSomaTotal * _nIdealSedex) /100
			_cSeguro        := (_cSomaTotal * _nSeguroSedex) /100
			IF _cFrete > _nMinSedex
				M->C5_FRETEORI  := _cFrete
			Else
				M->C5_FRETEORI  := _nMinSedex
			EndIF
			
			M->C5_SEGUROR   := _cSeguro
			M->C5_TRANSP    := "000002"
			M->C5_MODAL     := "2"
			M->C5_MODORIG   := "2"
			
			M->C5_FREORTO   := M->C5_FRETE  + M->C5_SEGURO
						
			_cDias          := _nDiasSedex
			_modalsedex     := "Sedex"
			
			IF TIME() > "15:00:00"
				alert("Vai por SEDEX !!  Este pedido esta fora do horario de coleta do Correiro(ATE 15:00 HRS), portanto sera enviado no proximo dia util!")
			ELSE
				Alert("Vai por SEDEX!!!")
			ENDIF
			
		ElseIF _cModalProprio == "3" //_cSomaTotal > 10000  .and. _cDimenssao == 0 .and. _cModalProprio == "3"//Ira fazer a tratativa para Transportadora.
			
			M->C5_GEROFRE   := "1"
			_cFrete         := (_cSomaTotal * _nIdealTrans) /100
			IF _cFrete > _nMinTransp
				M->C5_FRETEORI  := _cFrete
			Else
				M->C5_FRETEORI  := _nMinTransp
			EndIF
			M->C5_TRANSP    := _cTransp
			M->C5_MODAL     := "3"
			M->C5_MODORIG   := "3"
			
			_cSeguro := (_cSomaTotal * _nSeguroTrans) /100
			
			M->C5_SEGUROR   := _cSeguro
			M->C5_FREORTO   :=_cSeguro + _cFrete
			
			_cDias          := _nDiasTrans
			_modaltrans     := "Transportadora"
			Alert("Vai por Transportadora!")
		endif		
	else		
		IF _cSomaTotal >= 10000 .and. _cLocaliz == "1" .and. _cEstado == "SP"// .and. _cDimenssao >= 0 //"2" //Ira fazer a tratativa para o Carro Proprio.
			
			M->C5_GEROFRE   := "1"
			_cFrete         := _nMinCarro
			M->C5_FRETEORI  := _cFrete
			M->C5_TRANSP    := "000001"
			M->C5_MODAL     := "1"
			M->C5_MODORIG   := "1"
			M->C5_SEGUROR   := _nSeguroCarro
			M->C5_FREORTO   := _nSeguroCarro + _cFrete
			
			_cDias := _nDiasCarro
			_modalcarro     := "Carro Proprio"
			
			Alert("Vai de Carro Proprio!!!")
			
		ElseIF _cSomaTotal < 10000 .and. _cDimenssao == 0 //<> "2"  //Ira fazer a tratativa para o Sedex.
			
			M->C5_GEROFRE   := "1"
			
			M->C5_SEGUROR := _nSeguroSedex
			M->C5_FREORTO := _nSeguroSedex + _cFrete
			
			_cFrete         := (_cSomaTotal * _nIdealSedex) /100
			
			IF _cFrete > _nMinSedex
				M->C5_FRETEORI  := _cFrete
				
			Else
				M->C5_FRETEORI  := _nMinSedex
			EndIF
			
			M->C5_TRANSP    := "000002"
			M->C5_MODAL     := "2"
			M->C5_MODORIG   := "2"
			
			_cDias := _nDiasSedex
			_modalsedex     := "Sedex"
			
			IF TIME() > "14:00:00"
				alert("Vai por SEDEX!! Este pedido esta fora do hoario de coleta do correiro, portanto sera enviado no proximo dia util!")
			ELSE
				Alert("Vai por SEDEX!!!")
			ENDIF
			
		ElseIF _cSomaTotal > 10000  .and. _cDimenssao == 0 //Ira fazer a tratativa para Transportadora.
			
			M->C5_GEROFRE   := "1"
			_cFrete         := (_cSomaTotal * _nIdealTrans) /100
			IF _cFrete > _nMinTransp
				M->C5_FRETEORI  := _cFrete
			Else
				M->C5_FRETEORI  := _nMinTransp
			EndIF
			M->C5_TRANSP    := _cTransp
			M->C5_MODAL     := "3"
			M->C5_MODORIG   := "3"
			M->C5_SEGUROR   := _nSeguroTrans
			M->C5_FREORTO   := _nSeguroTrans + _cFrete
			
			_modaltrans     := "Transportadora"
			_cDias := _nDiastrans
			Alert("Vai por Transportadora!")
			
		ElseIF _cDimenssao <> 0 //Ira fazer a tratativa para Transportadora.
			
			M->C5_GEROFRE   := "1"
			_cFrete         := (_cSomaTotal * _nIdealTrans) /100
			IF _cFrete > _nMinTransp
				M->C5_FRETEORI  := _cFrete
			Else
				M->C5_FRETEORI	:= _cFrete
			EndIF
			M->C5_FRETEORI  := (_cSomaTotal * _nIdealTrans) /100
			M->C5_TRANSP    := _cTransp
			M->C5_MODAL     := "3"
			M->C5_MODORIG   := "3"
			M->C5_SEGUROR   := _nSeguroTrans
			M->C5_FREORTO   := _nSeguroTrans + _cFrete
			_cDias := _nDiastrans
			_modaltrans     := "Transportadora"
			Alert("Vai por Transportadora, pois a quantidade vendida do produtos nao sao aceitos pelo SEDEX!")
			
		ENDIF
		u_TelaResultado()
	EndIF
Else
	Alert("CEP do Cliente nao cadastrado na Tabela!!")
endif
	
	_cSomaTotal  := 000
	_cDimenssao  := 0
	_FreteSim    := "N"
	_Localiz     := " "
	_cFrete      := 000
	_cValorTot   := 000
	_cFrete      := " "
	
	RestArea(_aArea)
	Return(.T.)
