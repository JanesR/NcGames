#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"

/*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ//
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±//
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±//
//±±º Programa ³ P202CALCFRETE º Autor º CARLOS PUERTA  º Data º Maio/2012   º±±//
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±//
//±±º Descricao³ Programa que ira fazer o calculo automatico do frete e      º±±//
//±±º          ³ escolher os possiveis tipos de transportadora a serem usadasº±±//
//±±º          ³ Tambem tratando possiveis bloqueios e liberacoes.           º±±//
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±//
//±±ºUso       ³ AP10 - NC GAMES                                             º±±//
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±//
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±//
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß//
/*/


/*

----------------------------------------------------------------------------------
!!! ATENÇÃO !!!
----------------------------------------------------------------------------------
A FUNÇÃO CALCFRETE FOI CRIADA, POIS A MESMA LÓGICA DE CÁLCULO DE FRETE E PRAZO DE
ENTREGA FOI UTILIZADO PARA SER CONSUMIDO VIA WEBSERVICE.
PORTANTO, QUALQUER ALTERAÇÃO NA ROTINA ABAIXO, P202CALCFRETE DEVE SER REFLETIDA PA
RA A FUNÇÃO CALCFRETE, CASO CONTRÁRIO O CÁLCULO DE FRETE E PRAZO DE ENTREGA DO
CATÁLOGO DE PRODUTOS NÃO SERÁ ESPELHO DO SISTEM ERP.
OBS. A FUNÇÃO P202CALCFRETE NÃO FOI REUTILIZADA, POIS O CÓDIGO NÃO ESTÁ MODULADO
E CONTÉM OBJETOS DE TELA.
----------------------------------------------------------------------------------
*/
User Function P202CALCFRETE(lShowTela)
Private _aArea           := GetArea()
Private _cPedido         := M->C5_NUM
Private _cCliente        := M->C5_CLIENTE
Private _cLojaCli        := M->C5_LOJACLI
Private _cFaturPV        := M->C5_FATURPV
Private _cC5TPFrete      := M->C5_TPFRETE
Private _cC5Modal        := M->C5_MODAL
Private _cA1TPFrete      := Space(01)
Private _cA1Transp       := Space(06)
Private _cCepCli         := Space(08)
Private _cEstCli         := Space(02)
Private _cProduto        := Space(15)
Private _nSomaTotal      := 0.00
Private _nFrete          := 0.00
Private _nSeguro          := 0.00
Private _cCalcFrete      := Space(01)
Private _cAgendam        := Space(01)
Private _cModal          := Space(01)
Private _cTransp         := Space(06)
Private _nPerTra         := 0.00
Private _nSegTra         := 0.00
Private _nMinTra         := 0.00
Private _nPrzTra         := 0
Private _nPesoTot        := 0.00

Private _nPosProd        := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})         // Ira pegar o campo do cod de produto.
Private _nPosQuant       := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})          // Ira pegar o campo da quantidade vendida.
Private _nPosPrcVen      := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})          // Ira pegar o campo do preco unitario.
Private _nPosTotal       := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})           // Ira pegar o campo do valor total do item.
Private _nPosPercDescPr  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_DESCONT"})         // Ira pegar o campo do percentual do desconto no item.
Private _nPosDescontProd := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})         // Ira pegar o campo do valor do desconto no item.
Private _nPosBlq         := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="C6_BLQ"    })  // Ira pegar a informação se foi eliminado Residuo do Item.
Private _nPosOper        := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="C6_OPER"   })  // Ira pegar o campo do tipo de operacao.
Private _nPosLocal		 := aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})		 	 // Ira pegar o campo do local. 

Private _nPosReser		 := aScan(aHeader,{|x| AllTrim(x[2])=="C6_RESERVA"})		 // Ira pegar o campo numero da reserva.
Private _nPosQtRes		 := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDRESE"})		 // Ira pegar o campo de quantidade da reserva.

Private cString          := "SZF"


lShowTela := If( lShowTela == nil, .T. , lShowTela )
Private lMostraTela:=lShowTela
//
//---------------------------------------------------------------------------------------------//
// Ira Buscar as tabelas envolvidas para pegar variveis indispensavies no programa.            //
//---------------------------------------------------------------------------------------------//
dbSelectArea("SA1")
dbSetOrder(1)
If dbSeek(xFilial("SA1")+_cCliente+_cLojaCli)
	_cCepCli    := SA1->A1_CEP
	_cEstCli    := SA1->A1_EST
	_cCalcFrete := SA1->A1_FRETE
	_cAgendam   := SA1->A1_AGEND
	_cA1TPFrete := SA1->A1_TPFRET
	_cA1Transp  := SA1->A1_TRANSP
	
EndIf

_nSomaTotal := 0.00
_nFrete		:= 0.00
_nDimenssao := 0

If _cC5Modal == "2" .Or. M->C5_XECOMER=="C"
	If lMostraTela .And. M->C5_XECOMER<>"C"  .And. AllTrim(M->C5_YORIGEM)<>"WM"
		Alert("Valor do Frete Informado Manualmente pelo Usuario Responsável...")
	EndIf
	M->C5_GEROFRE := "1"
	M->C5_MODAL   := "2"
	If INCLUI
		M->C5_MODORIG  := M->C5_MODAL
		M->C5_FRETEORI := M->C5_FRETE
		M->C5_SEGUROR  := M->C5_SEGURO
		M->C5_FREORTO  := M->C5_FRETETO
	EndIf
	If lMostraTela .And. M->C5_XECOMER<>"C" .And. AllTrim(M->C5_YORIGEM)<>"WM"
		U__fPegaJustificativa()
	EndIf
Else
	If _cC5Modal == "5"
		If lMostraTela
			Alert("Pedido com Isenção de frete. Modal = 5 - Isento por usuario....")
		EndIf
	Else
		//		If _cFaturPV == "1"                                                  // Verifica se o Pedido de Venda e de Faturamento.
		If _cCalcFrete == "1"                                            // Verifica se o cliente paga frete, registrado no cadastro do cliente.
			U_P203CALCULO()   				                             // Chama  a rotina do calculo do frete.
		Else
			If lMostraTela
				Alert("Cliente nao paga Frete! Definido por Padrao!")        // alerta avisando que o cliente nao paga frete por padrao do usuario.
			EndIf
			//		U_P203CALCULO()
			//		U_Motivo()                                                   // chama a tela para a informacao do motivo de nao pagar frete.
			//		U_FRETENPAGO()                                               // calcula o modal mesmo que o frete nao seja cobrado.
			//		_NAOPAGA := "S"
		EndIf
		//		Else
		//	U_FRETENPAGO()                                                   // calcula o modal mesmo que o frete nao seja cobrado.
		//			Alert("Nao Calcula Frete! O Pedido de Venda nao e Faturamento!") // Alerta avisando que nao sera calculado frete, pois o PV nao e faturamento.
		//		EndIf
	EndIf
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P202CALCFRETEºAutor  ³Microsiga        º Data ³  10/06/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function P203CALCULO() 
Local lLibWMS	:= IsInCallStack("U_INTPEDVEN")//Verifica se foi chamado pela integracao do WMS
Local lPvSimul	:= IsInCallStack("U_PR107PVSIMUL")//Verifica se é Orçamento ou Simulação
Local lNotFound	:= .T.  
Local cQryAlias	:= GetNextAlias()
Local cFilSb2	:= xFilial("SB2")  
Local nQtdDispo := 0
Local cReserva	:= ""
Local nQtdRes	:= 0
Local nQtdVen	:= 0

Private _lNaoCep := .F.
Private _lVlMax  := .F.
Private _cTpOper := ""
Private _cTrans7 := ""

For _nX := 1 to Len(aCols)
	If !(ACOLS[_nX,Len(aHeader) + 1])
		_cTpOper := ACOLS[_nX,_nPosOper]
		Exit
	EndIf
Next

If !Empty(_cTpOper)
	_cTrans7 := ALLTRIM(POSICIONE("SX5",1,XFILIAL("SX5")+"Z8"+ALLTRIM(_cTpOper),"X5_DESCRI"))
EndIf

dbSelectArea("SZF")
dbSetOrder(1)                           // ZF_FILIAL+ZF_CEPINI
dbSeek(xFilial("SZF"),.T.)

cQryAlias:="SZF"
Do While (cQryAlias)->(!Eof())
	
	If SZF->ZF_CEPINI <= _cCepCli .And. SZF->ZF_CEPFIM >= _cCepCli .And. SZF->ZF_ATIVA <> "2"
		_nSomaTotal := 0.00
		_nPesoTot   := 0.0000
		lNotFound:=.F.
		
		For _nX := 1 to Len(aCols)         

			If GdDeleted( _nX)
				Loop
			Endif
			
		
			If !(ACOLS[_nX,Len(aHeader) + 1])
				_cProduto   := ACOLS[_nX,_nPosProd]
				_cLocal 		:= Acols[_nX,_nPosLocal]
				cReserva	:= Acols[_nX,_nPosReser] //Pedidos com reserva - 08/10/2015
				nQtdRes		:= Acols[_nX,_nPosQtRes] //Pedidos com reserva - 08/10/2015
				nQtdVen		:= Acols[_nX,_nPosQuant] //Pedidos com reserva - 08/10/2015
				
				//Incluido tratamento em 27/02/2014 - Rodrigo - Prj Curitiba
				If xFilial("SB2") == "05"
					cFilSb2	:= "03"
				Else
					cFilSb2	:= xFilial("SB2")
				EndIf
				SB2->(DbSeek(cFilSb2+_cProduto+_cLocal))
				SC0->(DbSetOrder(2))
				If SC0->(MsSeek(xFilial("SC0")+_cProduto+_cLocal+cReserva)) 
				
					If nQtdRes > 0
				   		nQtdDispo := nQtdRes
					Else 
					
						If SC0->C0_QUANT > 0 .And. nQtdVen <= SC0->C0_QUANT
							nQtdDispo := SC0->C0_QUANT
						EndIf 
						
					EndIf
						
					_cEstoque := SB2->B2_QATU - SB2->B2_RESERVA + nQtdDispo
					
				Else
				
				 _cEstoque := SB2->(B2_QATU-B2_RESERVA) 
				 
				EndIf
				
				//_cEstoque := SaldoSB2() //alterado em 06/10/2015 para atender venda a vista
				lEstoqueZero:=(_cEstoque<=0)

				If !lLibWMS .And. ((!lEstoqueZero) .Or. lPvSimul)
					_nQtdVen    := ACOLS[_nX,_nPosQuant]
				Else
					_nQtdVen    := GdFieldGet( "C6_YQTDLIB", _nX)
				EndIf
				
				_nPrcVen    := ACOLS[_nX,_nPosPrcVen]
				
				_nC6Valor   := _nQtdVen*_nPrcVen//ACOLS[_nX,_nPosTotal]
				_nPercDesc  := ACOLS[_nX,_nPosPercDescPr]
				_nValDesc   := ACOLS[_nX,_nPosDescontProd]
				
				If AllTrim(aCols[_nX,_nPosBlq]) <> "R"
					_nSomaTotal := _nSomaTotal + _nC6Valor
					
					dbSelectArea("SB1")
					dbSetOrder(1)
					If dbSeek(xFilial("SB1")+_cProduto)
						If SB1->B1_PESBRU > 0.0000
							_nPesoTot := _nPesoTot + (SB1->B1_PESBRU * _nQtdVen)
						Else
							_nPesoTot := _nPesoTot + (SB1->B1_PESO * _nQtdVen)
						EndIf
					EndIf
				EndIf
			EndIf
		Next
		
		If _cAgendam == "1"
			_cTransp := SZF->ZF_TRANSP5
			_nPerTra := SZF->ZF_PERTR5
			_nMinTra := SZF->ZF_MINTR5
			_nSegTra := SZF->ZF_SEGTR5
			_nPrzTra := SZF->ZF_PRZTR5
			_cModal  := "Transport. com Agendamento"
		Else
			If _nPesoTot <= 1
				_cTransp := SZF->ZF_TRANSP1
				_nPerTra := SZF->ZF_PERTR1
				_nMinTra := SZF->ZF_MINTR1
				_nSegTra := SZF->ZF_SEGTR1
				_nPrzTra := SZF->ZF_PRZTR1
				_cModal  := "Transport. com Peso Ate 1 Kg."
			Else
				If _nPesoTot > 1 .And. _nPesoTot <= 2
					_cTransp := SZF->ZF_TRANSP2
					_nPerTra := SZF->ZF_PERTR2
					_nMinTra := SZF->ZF_MINTR2
					_nSegTra := SZF->ZF_SEGTR2
					_nPrzTra := SZF->ZF_PRZTR2
					_cModal  := "Transport. com Peso Entre 1 e 2 Kg."
				Else
					If _nPesoTot > 2 .And. _nPesoTot <= 3
						_cTransp := SZF->ZF_TRANSP3
						_nPerTra := SZF->ZF_PERTR3
						_nMinTra := SZF->ZF_MINTR3
						_nSegTra := SZF->ZF_SEGTR3
						_nPrzTra := SZF->ZF_PRZTR3
						_cModal  := "Transport. com Peso Entre 2 e 3 Kg."
					Else
						If _nPesoTot > 3 .And. _nPesoTot <= 4
							_cTransp := SZF->ZF_TRANSP4
							_nPerTra := SZF->ZF_PERTR4
							_nMinTra := SZF->ZF_MINTR4
							_nSegTra := SZF->ZF_SEGTR4
							_nPrzTra := SZF->ZF_PRZTR4
							_cModal  := "Transport. com Peso Entre 3 e 4 Kg."
						Else
							If _nPesoTot > 4
								_cTransp := SZF->ZF_TRANSP5
								_nPerTra := SZF->ZF_PERTR5
								_nMinTra := SZF->ZF_MINTR5
								_nSegTra := SZF->ZF_SEGTR5
								_nPrzTra := SZF->ZF_PRZTR5
								_cModal  := "Transport. com Peso Acima de 4 Kg."
							EndIF
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		
		If AllTrim(_cA1TPFrete) == "F" .Or. AllTrim(_cC5TPFrete) == "F"
			If !Empty(_cA1Transp)
				_cTransp := _cA1Transp
			EndIf
			_nPerTra := 0.00
			_nMinTra := 0.00
			_nSegTra := 0.00
			_nPrzTra := 0
			_cModal  := "FOB - Frete Pago pelo Cliente"
		Endif
		Exit
	EndIf
	
	//dbSelectArea("SZF")
	(cQryAlias)->(dbSkip())
EndDo          

//(cQryAlias)->(DbCloseArea())
DbSelectArea("SZF")
If lNotFound
	_lNaoCep := .T.
	If lMostraTela
		Alert("CEP Não Encontrado na Tabela...")
	EndIf	
EndIf

If !(_lNaoCep)
	If AllTrim(_cA1TPFrete) == "F" .Or. AllTrim(_cC5TPFrete) == "F"
		If lMostraTela
			Alert("Pedido/Cliente com Frete Tipo FOB... Portanto Frete Não Será Calculado...")
		EndIf
		M->C5_GEROFRE := "2"
		M->C5_FRETE   := 0.00
		M->C5_SEGURO  := 0.00
		M->C5_FRETETO := 0.00
		M->C5_TRANSP  := _cTransp
		M->C5_XTRANOR :=_cTransp
		M->C5_MODAL   := "3"
		M->C5_PRZTRA  := 0
		If INCLUI
			M->C5_MODORIG  := "3"
			M->C5_FRETEORI := 0.00
			M->C5_SEGUROR  := 0.00
			M->C5_FREORTO  := 0.00
		EndIf
	Else
		If !(Empty(_cTrans7))
			If lMostraTela
				Alert("Pedido com Tipo de Operacao cadastrada na Tabela Z8... Portanto Frete Não Será Calculado...")
			Endif
			M->C5_GEROFRE := "2"
			M->C5_FRETE   := 0.00
			M->C5_SEGURO  := 0.00
			M->C5_FRETETO := 0.00
			M->C5_TRANSP  := _cTrans7
			M->C5_MODAL   := "7"
			M->C5_PRZTRA  := 0
			If INCLUI
				M->C5_MODORIG  := "7"
				M->C5_FRETEORI := 0.00
				M->C5_SEGUROR  := 0.00
				M->C5_FREORTO  := 0.00
			EndIf
		Else
			If _nPesoTot > 0.0000
				If _nSomaTotal > SUPERGETMV("MV_VLMAXFR")
					_lVlMax := .T.
				EndIf
				If _cCalcFrete == "1"
					M->C5_GEROFRE := "1"
				Else
					M->C5_GEROFRE := "2"
				EndIf
				_nFrete := (_nSomaTotal * _nPerTra) / 100
				IF _nFrete > _nMinTra
					If _cCalcFrete == "1" .And. !(_lVlMax)
						M->C5_FRETE := _nFrete
					Else
						M->C5_FRETE := 0.00
					EndIf
					If INCLUI
						M->C5_FRETEORI := _nFrete
					EndIf
				Else
					If _cCalcFrete == "1" .And. !(_lVlMax)
						M->C5_FRETE := _nMinTra
					Else
						M->C5_FRETE := 0.00
					EndIf
					If INCLUI
						M->C5_FRETEORI := _nMinTra
					EndIf
				EndIF
				If _cCalcFrete == "1" .And. !(_lVlMax)
					M->C5_TRANSP  := _cTransp
					M->C5_XTRANOR := _cTransp
					M->C5_MODAL   := "1"
				Else
					M->C5_TRANSP  := _cTransp    // Space(06)
					M->C5_XTRANOR := _cTransp
					If _cCalcFrete == "2"
						M->C5_MODAL   := "4"
					Else
						If _lVlMax
							M->C5_MODAL := "6"
						EndIf
					EndIf
				EndIf
				If INCLUI
					If _cCalcFrete == "1" .And. !(_lVlMax)
						M->C5_MODORIG := "1"
					Else
						If _cCalcFrete == "2"
							M->C5_MODORIG := "4"
						Else
							If _lVlMax
								M->C5_MODORIG := "6"
							EndIf
						EndIf
					EndIf
				EndIf
				
				_nSeguro := (_nSomaTotal * _nSegTra) / 100
				If _cCalcFrete == "1" .And. !(_lVlMax)
					M->C5_SEGURO  := _nSeguro
					M->C5_FRETETO := _nSeguro + _nFrete
				Else
					M->C5_SEGURO  := 0.00
					M->C5_FRETETO := 0.00
				EndIf
				If INCLUI
					M->C5_SEGUROR := _nSeguro
					M->C5_FREORTO := _nSeguro + _nFrete
				EndIf
				M->C5_PRZTRA  := _nPrzTra
				If lMostraTela
					U_P204TelaResultado()
				EndIf
			Else
				If lMostraTela
					Alert("Peso Total do Pedido igual a ZERO Kg!!")
				EndIf
			EndIf
		EndIf
	EndIf
EndIf                 

M->C5_YPFRETE:=_nPerTra
M->C5_YPSEGUR:=_nSegTra                                     



If lLibWMS .Or. ALTERA
	M->C5_YPGFRET:=_nFrete
	M->C5_YVLRSEG:=_nSeguro
EndIf

RestArea(_aArea)
Return
//
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TelaResultado ³ Autor ³ Rafael Augusto    ³ Data ³31/05/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³ Supertech - rafael@stch.com.br							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ NC GAMES                                                   ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
//
User Function P204TelaResultado()
Private _nTotal      := 0.00
Private _nPercentual := 0.00
Private _cIsentar    := "N"

@ 150,001 TO 510,750 DIALOG oDlg1 TITLE "MODAL X FRETE"

@ 005,005 To 150,370
@ 015,010 Say "O ESTADO DO CLIENTE É: "+_cEstCli
@ 030,010 Say "O CEP DO CLIENTE É: "+Transform(_cCepCli, "@R 99999-999")
@ 045,010 Say "O MODAL USADO SERÁ: "+UPPER(ALLTRIM(_cModal))
@ 060,010 Say "VALOR DO PEDIDO: R$ "+Transform(_nSomaTotal, "@E 9,999,999.99")+"        PESO TOTAL DO PEDIDO: "+Transform(_nPesoTot,   "@E 999,999.9999")
@ 075,010 Say "O VALOR DO FRETE SERÁ: R$ "+Transform(M->C5_FRETE, "@E 9,999,999.99")
@ 090,010 Say "O VALOR DO SEGURO SERÁ: R$ "+Transform(M->C5_SEGURO, "@E 9,999,999.99")

_nTotal :=  M->C5_SEGURO + M->C5_FRETE

@ 105,010 Say "O VALOR DO SEGURO + FRETE:  R$ "+Transform(_nTotal,  "@E 9,999,999.99")

_nPercentual := ( _nTotal / _nSomaTotal) * 100

@ 120,010 Say "O PRAZO DE ENTREGA SERÁ DE: "+Transform(_nPrzTra, "@E 999")+" DIA(S) UTIL(EIS)"
@ 135,010 Say "O PERCENTUAL DO FRETE É: "+Transform(_nPercentual, "@E 999.99")+"%"

If AllTrim(RetCodUsr()) $ UPPER(GETMV("MV_USRFRIS"))
	@ 160,240 BUTTON "Isentar PV"        SIZE 40,12 ACTION U__fPegaJustificativa()
EndIf
@ 160,300 BUTTON "   Ok   "          SIZE 40,12 ACTION Close(oDlg1)
activate dialog oDlg1 centered
Return

User Function _fPegaJustificativa()
Private _cMotivo := Space(006)
Private _cJustif := Space(200)

@ 160,005 TO 310,740 DIALOG oDlg2 TITLE "MOTIVO DE ISENTAR DE FRETE O PEDIDO DE VENDA"

@ 005,010 To 070,360
@ 020,015 Say "MOTIVO "
@ 020,070 Get _cMotivo     SIZE 060,010  Picture "@!"   F3 "Z7" Valid !Empty(_cMotivo)
@ 035,015 Say "JUSTIFICATIVA"
@ 035,070 Get _cJustif     SIZE 280,010  Picture "@!S150"  Valid !Empty(_cJustif)

@ 055,280 BUTTON "    Ok    "   SIZE 40,12 ACTION U_TelaOK()
activate dialog oDlg2 centered Valid U_CancTela()
Return

User function TelaOK()
IF !Empty(_cMotivo)
	If M->C5_MODAL == "2"
		M->C5_ZMOTIVO  := _cMotivo
		M->C5_MOTFRET  := _cJustif
		M->C5_ALTFRETE := UPPER(Alltrim(cUsername))
		CLOSE(oDlg2)
	Else
		Alert("Pedido Isentado pelo Usuario "+UPPER(Alltrim(cUsername)))
		M->C5_MODORIG  := M->C5_MODAL
		M->C5_FRETEORI := M->C5_FRETE
		M->C5_SEGUROR  := M->C5_SEGURO
		M->C5_FREORTO  := M->C5_FRETETO
		
		M->C5_GEROFRE  := "2"
		M->C5_FRETE    := 0.00
		M->C5_SEGURO   := 0.00
		M->C5_FRETETO  := 0.00
		M->C5_TRANSP   := _cTransp
		M->C5_XTRANOR  := _cTransp
		M->C5_MODAL    := "5"
		M->C5_PRZTRA   := 0
		
		M->C5_ZMOTIVO  := _cMotivo
		M->C5_MOTFRET  := _cJustif
		M->C5_ALTFRETE := UPPER(Alltrim(cUsername))
		CLOSE(oDlg2)
		CLOSE(oDlg1)
	EndIf
Else
	ALERT("Por favor informar o MOTIVO da Isenção!")
	Return(.F.)
EndIf
Return

User Function CancTela()
Private _lRet := .T.
If Empty(_cMotivo)
	Alert("O Motivo deve ser Informado...")
	_lRet := .F.
EndIf
Return(_lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFUNÇÃO    ³  CALCFRETE  ºAutor  ³FELIPE V. NAMBARA   º Data ³  04/10/12º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³FUNÇÃO DE CÁLCULO DE FRETE PARA SER UTILIZADA VIA WEBSERVICEº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC GAMES - CATÁLOGO DE PRODUTOS                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CalcFr(cCep, aMyHeader, aMyCols )

Local aAreaAtu		:= GetArea()
Local cSql			:= ""
Local nFrete		:= 0
Local nValorTotal	:= 0
Local nPesoTotal	:= 0
Local lCalcula		:= .T.
Local cAliasTmp	    := ""
Local aFreteInfo	:= { {"CODIGO_TRANSPORTADORA"			,""	}	;
,{"PERCENTUAL_FRETE_TRANSPORTADORA"	,0	}	;
,{"VALOR_MINIMO_TRANSPORTADORA"		,0	}	;
,{"PERCENTUAL_SEGURO_TRANSPORTADORA",0	}	;
,{"PRAZO_ENTREGA_TRANSPORTADORA"	,0	}	;
,{"OBSERVACAO_FRETE"				,""	}	;
,{"CODIGO_OBSERVACAO_FRETE"			,""	}	;
,{"VALOR_FRETE"						,0	}	;
,{"VALOR_SEGURO"					,0	}	;
,{"CALCULOU_FRETE"					,.F.}	}

//ErrorBlock( { |olErro| U_MySndError(olErro)  } )

Begin Sequence

cAliasTmp	    := GetNextAlias()

If Len(aMyCols) > 0
	
	If !Empty(cCep)
		
		SB1->(DbSetOrder(1))
		
		cSql	:= " SELECT "
		cSql	+= " 		 ZF_TRANSP1 "
		cSql	+= " 		,ZF_TRANSP2 "
		cSql	+= " 		,ZF_TRANSP3 "
		cSql	+= " 		,ZF_TRANSP4 "
		cSql	+= " 		,ZF_TRANSP5 "
		cSql	+= " 		,ZF_PERTR1 "
		cSql	+= " 		,ZF_PERTR2 "
		cSql	+= " 		,ZF_PERTR3 "
		cSql	+= " 		,ZF_PERTR4 "
		cSql	+= " 		,ZF_PERTR5 "
		cSql	+= " 		,ZF_PERTR5 "
		cSql	+= " 		,ZF_MINTR1 "
		cSql	+= " 		,ZF_MINTR2 "
		cSql	+= " 		,ZF_MINTR3 "
		cSql	+= " 		,ZF_MINTR4 "
		cSql	+= " 		,ZF_MINTR5 "
		cSql	+= " 		,ZF_SEGTR1 "
		cSql	+= " 		,ZF_SEGTR2 "
		cSql	+= " 		,ZF_SEGTR3 "
		cSql	+= " 		,ZF_SEGTR4 "
		cSql	+= " 		,ZF_SEGTR5 "
		cSql	+= " 		,ZF_PRZTR1 "
		cSql	+= " 		,ZF_PRZTR2 "
		cSql	+= " 		,ZF_PRZTR3 "
		cSql	+= " 		,ZF_PRZTR4 "
		cSql	+= " 		,ZF_PRZTR5 "
		
		cSql	+= " FROM " + RetSqlName("SZF") + " SZF "
		
		cSql	+= " WHERE ZF_CEPINI <= '" + Alltrim(cCep) + "' AND ZF_CEPFIM >= '" + Alltrim(cCep) + "'  "	   //	cSql	+= " WHERE " + Alltrim(cCep) + " BETWEEN ZF_CEPINI AND ZF_CEPFIM "
		cSql	+= " AND ZF_ATIVA <> '2' "
		cSql	+= " AND SZF.D_E_L_E_T_ = ' ' "
		
		cSql	:= ChangeQuery(cSql)
		
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTmp,.F.,.T.)
		
		If (cAliasTmp)->( !Eof() ) .And. (cAliasTmp)->( !Bof() )
			
			For nCont1 := 1 To Len(aMyCols)
				
				If SB1->( DbSeek(xFilial("SB1") + Padr(aMyCols[nCont1][aScan(aMyHeader,{|x| Alltrim(x[2]) == "C6_PRODUTO" })],TamSx3("B1_COD")[1]) ) )
					
					If SB1->B1_PESBRU > 0
						
						nPesoTotal += SB1->B1_PESBRU * aMyCols[nCont1][aScan(aMyHeader,{|x| Alltrim(x[2]) == "C6_QTDVEN" })]
						
					Else
						
						nPesoTotal += SB1->B1_PESO * aMyCols[nCont1][aScan(aMyHeader,{|x| Alltrim(x[2]) == "C6_QTDVEN" })]
						
					EndIf
					
					nValorTotal += aMyCols[nCont1][aScan(aMyHeader,{|x| Alltrim(x[2]) == "C6_TOTAL" })]
					
				Else
					
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .F.
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 			:= "O PRODUTO " + Alltrim(aMyCols[nCont1][aScan(aMyHeader,{|x| Alltrim(x[2]) == "C6_PRODUTO" })])  + " NÃO FOI ENCONTRADO NA BASE."
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "6"
					
					lCalcula := .F.
					
					Exit
					
				EndIf
				
			Next nCont1
			
			If lCalcula
				
				If nPesoTotal > 0
					
					If nPesoTotal <= 1
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_TRANSPORTADORA"})][2] 				:= (cAliasTmp)->ZF_TRANSP1
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_PERTR1
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_MINTR1
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_SEGTR1
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PRAZO_ENTREGA_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_PRZTR1
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 	   				:= "TRANSPORTE COM PESO ATE 1 KG."
						
					Elseif nPesoTotal > 1 .And. nPesoTotal <= 2
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_TRANSPORTADORA"})][2] 				:= (cAliasTmp)->ZF_TRANSP2
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_PERTR2
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_MINTR2
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_SEGTR2
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PRAZO_ENTREGA_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_PRZTR2
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 	   		 		:= "TRANSPORTE COM PESO ENTRE 1 E 2 KGs."
						
					ElseIf nPesoTotal > 2 .And. nPesoTotal <= 3
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_TRANSPORTADORA"})][2] 				:= (cAliasTmp)->ZF_TRANSP3
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_PERTR3
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_MINTR3
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_SEGTR3
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PRAZO_ENTREGA_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_PRZTR3
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 	   	 			:= "TRANSPORTE COM PESO ENTRE 2 E 3 KGs."
						
					ElseIf nPesoTotal > 3 .And. nPesoTotal <= 4
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_TRANSPORTADORA"})][2] 				:= (cAliasTmp)->ZF_TRANSP4
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_PERTR4
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_MINTR4
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_SEGTR4
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PRAZO_ENTREGA_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_PRZTR4
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 	   		 		:= "TRANSPORTE COM PESO ENTRE 3 E 4 KGs."
					ElseIf nPesoTotal > 4
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_TRANSPORTADORA"})][2] 				:= (cAliasTmp)->ZF_TRANSP5
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_PERTR5
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_MINTR5
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2] 	:= (cAliasTmp)->ZF_SEGTR5
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PRAZO_ENTREGA_TRANSPORTADORA"})][2] 		:= (cAliasTmp)->ZF_PRZTR5
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 	   		 		:= "TRANSPORTE COM PESO ACIMA DE 4 KGs."
						
					EndIf
					
				Else
					
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .F.
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 			:= "O PESO TOTAL DOS ITENS NÃO ESTÁ ACIMA DO MÍNIMO"
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "1"
					
				EndIf
				
				If nValorTotal <= GetNewPar("MV_VLMAXFR",0)
					
					nFrete := (nValorTotal * aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_FRETE_TRANSPORTADORA"})][2]) / 100
					
					If nFrete > aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2]
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_FRETE"})][2] 			:= nFrete
						
					Else
						
						aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_FRETE"})][2] 			:= aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_MINIMO_TRANSPORTADORA"})][2]
						
					EndIf
					
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "VALOR_SEGURO"})][2] 				:= (nValorTotal * aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "PERCENTUAL_SEGURO_TRANSPORTADORA"})][2]) / 100
					
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .T.
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "0"
					
					
				Else
					
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .F.
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 			:= "O VALOR TOTAL DOS ITENS ESTÁ ISENTO DE FRETE."
					aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "2"
					
				EndIf
				
			EndIf
			
		Else
			
			aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .F.
			aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 			:= "O CEP NÃO FOI ENCONTRADO NA TABELA DE FRETE."
			aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "3"
			
		EndIf
		
		(cAliasTmp)->(DbCloseArea())
		
	Else
		
		aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .F.
		aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 			:= "É NECESSÁRIO INFORMAR UM CEP PARA O CÁLCULO DO FRETE"
		aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "4"
		
	EndIf
	
Else
	
	aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CALCULOU_FRETE"})][2]				:= .F.
	aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "OBSERVACAO_FRETE"})][2] 			:= "É NECESSÁRIO INFORMAR PELO MENOS UM ITEM PARA O CÁLCULO DO FRETE."
	aFreteInfo[aScan(aFreteInfo,{|x| x[1] == "CODIGO_OBSERVACAO_FRETE"})][2] 	:= "5"
	
EndIf

RestArea(aAreaAtu )

End Sequence

Return(aFreteInfo)
