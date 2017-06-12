#include "rwmake.ch"

User Function NFatm01(_cReceb)

Local _aArea      := GetArea()
Local _nPeso      := 0
Local _nValFrete  := 0
Local _cSay1      := "Peso total do pedido: "
Local nPos2QtVen  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "C6_UNSVEN"})
Local nPosCodPro  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "C6_PRODUTO"})
Local nPosQtdVen  := aScan(aHeader,{|x| Upper(alltrim(x[2])) == "C6_QTDVEN"})
Local _cPercent   := GetMV("MV_X_PPESO")
Local _cRotina    := _cReceb
Private _lRet     := .T.

_cCliente         := M->C5_CLIENTE
_cLoja            := M->C5_LOJACLI
_cTransp          := M->C5_TRANSP


IF INCLUI .OR. ALTERA
	IF Empty(_cTransp)
		MsgInfo("O campo transportadora esta sem o seu preenchimento","Atençao!")
	ElseIF !_cTransp $ "000001/000002"
		M->C5_PBRUTO :=0
		M->C5_FRETE  :=0
		MsgInfo("Frete nao calculado para transportadoras, somente Sedex","Atençao!")
	ElseIF _cTransp == "000001" //Carro proprio
		dbSelectArea("SA4")
		dbSetOrder(1)
		dbSeek(xFilial()+_cTransp)
		M->C5_FRETE := SA4->A4_X_VFRET
	ElseIF _cTransp == "000002" //Sedex
		SB1->(DbSetOrder(01))
		For _i:=1 To len(aCols)
			IF !aCols[_i,Len(aHeader) + 1]
				sb1->(DbSeek(xFilial("SB1") + Alltrim(aCols[_i,nPosCodPro])))
				IF sb1->b1_peso <= 0
					_lRet := .F.
				Else
					_nPeso +=sb1->b1_peso * aCols[_i,nPosQtdVen]
				EndIF
			EndIF
		Next _i
		
		_cPercenT := (_cPercent/100) + 1
		_nPeso    :=_nPeso * _cPercenT
		
		//***************************************************************************************************//
		// Transformar a variável em string (texto), depois tira os espacos em branco (alltrim),             //
		// depois transforma em valor numerico (val), depois pega apenas a parte INTEIRA do valor (int)      //
		//***************************************************************************************************//
		
		_nPeso3   := Int(Val(Alltrim(Str(_nPeso,6,2))))
		
		_nPeso4   := Int(Val(Alltrim(Str(_nPeso + 1,6,2)))) //A mesma coisa que a linha de cima porem soma mais 1.
		
		IF _nPeso < 2
			_nPeso  :=2
			_nPeso3 :=1
			_nPeso4 :=2
		EndIF
		
		
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial() + _cCliente + _cLoja)
		
		_cCEP    := IIF(!Empty(SA1->A1_CEPE),Substr(SA1->A1_CEPE,1,5),Substr(SA1->A1_CEP,1,5))
		_cEstado := SA1->A1_ESTE
		_cLocalz := SA1->A1_X_LOCZ
		
		If Select("SQL") > 0
			dbSelectArea("SQL")
			dbCloseArea()
		Endif
		
		_cQry:= "SELECT SZ2.Z2_VALOR VALOR "
		_cQry+= " FROM SZ2010 SZ2 "
		_cQry+= " WHERE  SZ2.Z2_ESTADO = '" + _cEstado + "' AND SZ2.Z2_LOCALIZ = '" + _cLocalz + "' AND"
		_cQry+= " SZ2.Z2_PESOATE BETWEEN  '" + Alltrim(Str(_nPeso3)) + "' AND '" + Alltrim(Str(_nPeso4)) + "' AND SZ2.D_E_L_E_T_ = ' ' "
		_cQry+= " ORDER BY SZ2.Z2_VALOR "
		
		_cQry := ChangeQuery(_cQry)
		
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry),"SQL", .F., .T.)
		
		dbGoTop()
		lContinua := .T.
		
		While !Eof() .and. lContinua
			_nValFrete := SQL->VALOR
			lContinua  := .F.
		EndDo
		dbCloseArea("SQL")
		
		IF !_lRet
			M->C5_PBRUTO :=0
			M->C5_FRETE  :=0
			_nPeso       :=0
			_nValFrete   :=0
			
			MsgAlert("Algum dos itens deste pedido nao tem cadastrado seu peso, favor verificar o campo peso no cadastro de produto!","Atencao")
			
		Else
			IF _nValFrete == 0
				
				MsgAlert("Nao foi cadastrado um valor para o sedex na faixa de peso entre " + Alltrim(Str(_nPeso3)) + " e " + Alltrim(Str(_nPeso4)) + "." ,"Atencao")
				
			Else
				
				M->C5_PBRUTO := _nPeso
				M->C5_FRETE  := _nValFrete
				
				@ 048,027 TO 150,200 DIALOG oDlg TITLE "Peso Total"
				@ 004,005 TO 36,88
				@ 038,060 BMPBUTTON TYPE 1 ACTION Close(oDlg)
				@ 013,008 SAY _cSay1
				@ 013,060 SAY _nPeso
				@ 013,075 SAY "KG"
				@ 025,008 SAY "Valor Frete: "
				@ 025,040 SAY _nValFrete Picture "@R 999.99"
				
				ACTIVATE DIALOG oDlg CENTERED
			EndIF
		EndIF
	EndIF
EndIF

RestArea(_aArea)

Return

