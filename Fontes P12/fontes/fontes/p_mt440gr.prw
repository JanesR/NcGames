#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �P_MT440GR �Autor  �Microsiga           � Data �  14/01/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para validar o desconto cedido no PV.,    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP8                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

USER FUNCTION MT440GR()

Local _aArea       	:= GetArea()
Local nOpc  		:= PARAMIXB [1]
Local _nPosProduto 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local _nPosVlrTab  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCTAB"})
Local _nPosVlrUni  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
Local _nPosQtdLib  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDLIB"})
Local _nPosQtdVen  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local _nPosUSRLB   	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_X_USRLB"})
Local _nPosTES     	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
Local _nPosPrUnit	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPValDesc 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})
Local nPDescont  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_DESCONT"})
Local nPrecoOrg := aScan(aHeader,{|x| AllTrim(x[2])=="C6_YPRCORI"})


If !U_PR107LibPermitida(.F.,SC5->C5_NUM)//Funcao encontrada no fonte NCGPR107
	Return .F.
EndIf	

If SC5->C5_TIPO == "N"

	// incluido para verifica��o da parcela m�nima
	if nOpc == 1
		lparc	:= CalcCOND1()
		if !lparc
			Return .F. 
		Endif
	endif


	// valida��o do destaque do desconto
	FOR xx:=1 TO LEN(ACOLS)		
		IF	(aCols[xx,_nPosPrUnit]	> aCols[xx,_nPosVlrUni]) .or. aCols[xx,nPValDesc] > 0 .or. aCols[xx,nPDescont] > 0 // se o pre�o unit�rio for menor que o pre�o lista, haver� destaque do desconto na NF
			//ALERT("Pedido n�o liberado! Fa�a o zeramento do destaque do desconto para proceder com a libera��o do pedido.")
			//Return .F.	
			aCols[xx,nPrecoOrg]	:=aCols[xx,_nPosPrUnit]
			aCols[xx,_nPosPrUnit]	:= aCols[xx,_nPosVlrUni] // preco sem ipi	
			aCols[xx,nPValDesc]:= 0
			aCols[xx,nPDescont]:= 0
		ENDIF	
	NEXT xx
	_cLocalz :=SA1->A1_X_LOCZ
	_cEstado :=SA1->A1_ESTE
	
	For x:=1 to Len(Acols)
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(XFilial("SB1")+ACOLS[x,_nPosProduto],.F.)
		
		DbSelectArea("SBM")
		DbSetOrder(1)
		DbSeek(XFilial("SBM")+SB1->B1_GRUPO,.F.)
		
		If SA1->A1_X_DESC <> 0
			_nVlrDesc := SA1->A1_X_DESC
		Else
			_nVlrDesc := SBM->BM_X_DESC
		EndIf
		
		_nVlrDescPed := 100 - ((ACOLS[x,_nPosVlrUni] / ACOLS[x,_nPosVlrTab]) * 100)

		If _nVlrDescPed > _nVlrDesc .AND. !UPPER(Alltrim(cUsername)) $ UPPER(GetMv("MV_NCUSRLB")) .and. _nVlrDesc <> 0 .AND. ALLTRIM(ACOLS[x,_nPosTES]) $ GetMv("MV_X_TES") 
			ACOLS[X,_nPosQtdLib] := 0
			ACOLS[X,_nPosUSRLB]  := ""   
			MsgBox("Desconto concedido no item "+StrZero(x,1)+" supera o limite permitido. Verifique.","PEDIDO BLOQUEADO","ALERT")
		ElseiF Empty(ACOLS[X,_nPosUSRLB]) .AND. ACOLS[X,_nPosQtdLib] > 0
			ACOLS[X,_nPosUSRLB]  := UPPER(Alltrim(cUsername))
		EndIf
	    	
	Next
		
		
EndIf          
                                                             
                                                                                                                                  
//MsgBox("Estado no Cadastro do Cliente:"+sa1->a1_est,"ALERT")

// GRAVA A DATA DA LIBERA��O DO PEDIDO 
SC5->(RECLOCK("SC5",.F.))
 
SC5->C5_YDATENT := DtoS(msdate())
SC5->C5_YCONDPG := SC5->C5_CONDPAG  //NcgPr124()

SC5->(MSUNLOCK()) 	
////////////////////////////////////////////////////////////////////////////////////
U_Z7Status(SC5->C5_FILIAL,SC5->C5_NUM,"000002","PEDIDO LIBERADO POR VENDAS",SC5->C5_CLIENTE)

RestArea(_aArea)

RETURN .T.


//parcela m�nima
//CALCULA O PEDIDO PARA AVALIAR CONDI��O DE PAGAMENTO E VALOR DAS PARCELAS

Static Function CalcCOND1()


Local nPLocal   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local nPTotal   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})
Local nPValDesc := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})
Local nPPrUnit  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local nPDtEntr  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ENTREG"})
Local nPProduto := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local nPTES     := aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
Local nPNfOri   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_NFORI"})
Local nPSerOri  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_SERIORI"})
Local nPItemOri := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEMORI"})
Local nPIdentB6 := aScan(aHeader,{|x| AllTrim(x[2])=="C6_IDENTB6"})
Local nPItem    := aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM"})
Local nPosDesc  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_DESCRI"})
Local nPosPrTab := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCTAB"})
Local nPQtdLib  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDLIB"})
Local nPTpOper  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_TPOPER"})
Local nPosLocal := aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local nPosYMIDP := aScan(aHeader,{|x| AllTrim(x[2])=="C6_YMIDPAI"})
Local nRecOri   := 0
Local cGerarPV	:= Alltrim(U_MyNewSX6(	"NCG_100000","S"		,"C","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz",.F. ))
Local cFilPV	:= Alltrim(U_MyNewSX6(	"NCG_100001","04;05"	,"C","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia",.F. ))
Local cFilDest	:= Alltrim(U_MyNewSX6(	"NCG_100003","03"	   ,"C","Filial Destino PV Transferencia","Filial Destino PV Transferencia","Filial Destino PV Transferencia",.F. ))
Local cFilSB2	:= xFilial("SB2")

If cGerarPV=="S"  .And. (cFilAnt$cFilPV)
	cFilSB2:=cFilDest
EndIf


_aArea	:= GetArea()

nTotPrcVen	:= 0
nTotValEst	:= 0
nTotPrTab	:= 0
nTotValIpi	:= 0
nTotPrTabR	:= 0
aDadosTMP	:= {}
cPedido		:= M->C5_NUM
cCliente	:= M->C5_CLIENTE
cLoja		:= M->C5_LOJACLI
nFrete		:= M->C5_FRETE
nSeguro		:= M->C5_SEGURO
nDespesa	:= M->C5_DESPESA
cVend1		:= M->C5_VEND1
cGrpRep 	:= GetAdvFVal("SA3","A3_GRPREP",XFILIAL("SA3")+cVend1,1,"")  
nVlMin		:= GetAdvfVal("ACA","ACA_PEDMIN",XFILIAL("ACA")+cGrpRep,1,0)
lparc		:= .T.
lIdentmsg	:= .T.

IF !M->C5_TIPO = "N" // se o pedido for diferente de normal, n�o far� a valida��o
	RETURN(lparc)
ELSE
	cFunc	:= getadvfval("SA1","A1_SATIV1",XFILIAL("SA1")+cCliente+cLoja,1,"")
	IF cFunc == "000061" //se o cliente for funcion�rio, n�o far� a valida��o da parcela
		RETURN(lparc)
	ENDIF
// se tipo de opera��o for diferente de vendas, desconsidera valida��o. Verifica��o somente no primeiro item pois s� � usado um tipo de opera��o em cada pedido
	IF aCols[1][nPTpOper] <> "01" 
		RETURN(lparc)
	ENDIF
ENDIF
//Calcula o valor da despesa por item
nC5TOTAL	:= 0
FOR I:=1 TO LEN(ACOLS)
	If !GDDeleted(I)		
			//verifica quantidade liberada sem o bloqueio de estoque
			cLocal	 := aCols[I][nPosLocal]			
			nQtdEst	 := getadvfval("SB2","B2_QATU",cFilSB2+aCols[I][nPProduto]+cLocal,1,0)
			nQtdRes	 := getadvfval("SB2","B2_RESERVA",cFilSB2+aCols[I][nPProduto]+cLocal,1,0)
			nQtdDispo := nQtdEst - nQtdRes
			if aCols[I][nPQtdLib] > nQtdDispo .and. nQtdDispo > 0
				nLibera	:= nQtdDispo						
			elseif nQtdDispo > 0
				nLibera	:= aCols[I][nPQtdLib]
			else
				nLibera	:= 0
			endif
		nC5TOTAL	+= aCols[I][nPPrcVen]*nLibera
		//Tratamento para somar o software no c�lculo da parcela m�nima na libera��o do pedido
		If substr(aCols[I][nPosYMIDP],1,2) == "MD"
			nPosSW	:= aScan(aCols,{|x| x[nPItem] == substr(aCols[I,nPosYMIDP],3,2) })
			nC5TOTAL	+= aCols[nPosSW][nPPrcVen]*nLibera
		EndIf
	EndIf
NEXT
nFtFrete	:= nFrete/nC5Total
nFtSegur	:= nSeguro/nC5Total
nFtDespe	:= nDespesa/nC5Total

//���������������������������������������������Ŀ
//�Busca referencias no SC6                     �
//�����������������������������������������������
aFisGet	:= {}
dbSelectArea("SX3")
dbSetOrder(1)
MsSeek("SC6")
While !Eof().And.X3_ARQUIVO=="SC6"
	cValid := UPPER(X3_VALID+X3_VLDUSER)
	If 'MAFISGET("'$cValid
		nPosIni 	:= AT('MAFISGET("',cValid)+10
		nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
		cReferencia := Substr(cValid,nPosIni,nLen)
		aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	If 'MAFISREF("'$cValid
		nPosIni		:= AT('MAFISREF("',cValid) + 10
		cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
		aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	dbSkip()
EndDo
aSort(aFisGet,,,{|x,y| x[3]<y[3]})

//���������������������������������������������Ŀ
//�Busca referencias no SC5                     �
//�����������������������������������������������
aFisGetSC5	:= {}
dbSelectArea("SX3")
dbSetOrder(1)
MsSeek("SC5")
While !Eof().And.X3_ARQUIVO=="SC5"
	cValid := UPPER(X3_VALID+X3_VLDUSER)
	If 'MAFISGET("'$cValid
		nPosIni 	:= AT('MAFISGET("',cValid)+10
		nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
		cReferencia := Substr(cValid,nPosIni,nLen)
		aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	If 'MAFISREF("'$cValid
		nPosIni		:= AT('MAFISREF("',cValid) + 10
		cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
		aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	dbSkip()
EndDo
aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})
//���������������������������������������������Ŀ
//�Inicializa a funcao fiscal                   �
//�����������������������������������������������
MaFisSave()
MaFisEnd()
MaFisIni(Iif(Empty(M->C5_CLIENT),M->C5_CLIENTE,M->C5_CLIENT),;// 1-Codigo Cliente/Fornecedor
M->C5_LOJAENT,;					// 2-Loja do Cliente/Fornecedor
IIf(M->C5_TIPO$'DB',"F","C"),;	// 3-C:Cliente , F:Fornecedor
M->C5_TIPO,;			   		// 4-Tipo da NF
M->C5_TIPOCLI,;			   		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA461")

//�������������������������������������������������Ŀ
//�Realiza alteracoes de referencias do SC5         �
//���������������������������������������������������
If Len(aFisGetSC5) > 0
	dbSelectArea("SC5")
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&("M->"+Alltrim(aFisGetSC5[ny][2])))
			MaFisAlt(aFisGetSC5[ny][1],&("M->"+Alltrim(aFisGetSC5[ny][2])),,.F.)
		EndIf
	Next nY
Endif
nC6TOTAL	:= 0
If nPTotal > 0 .And. nPValDesc > 0 .And. nPPrUnit > 0 .And. nPProduto > 0 .And. nPQtdVen > 0 .And. nPTes > 0

	For nX := 1 To Len(aCols)
		nC6TOTAL	:= 0
		if !GDDeleted(nX)
			cProduto := aCols[nX][nPProduto]
			If nPIdentB6 <> 0 .And. !Empty(aCols[nX][nPIdentB6])
				SD1->(dbSetOrder(4))
				If SD1->(MSSeek(xFilial("SD1")+aCols[nX][nPIdentB6]))
					nRecOri := SD1->(Recno())
				EndIf
			ElseIf nPNfOri > 0 .And. nPSerOri > 0 .And. nPItemOri > 0
				If !Empty(aCols[nX][nPNfOri]) .And. !Empty(aCols[nX][nPItemOri])
					SD1->(dbSetOrder(1))
					If SD1->(MSSeek(xFilial("SD1")+aCols[nX][nPNfOri]+aCols[nX][nPSerOri]+M->C5_CLIENTE+M->C5_LOJACLI+aCols[nX][nPProduto]+aCols[nX][nPItemOri]))
						nRecOri := SD1->(Recno())
					EndIf
				EndIf
			EndIf
			//verifica quantidade liberada sem o bloqueio de estoque
			cLocal		:= aCols[nX][nPosLocal]			
			nQtdEst	 	:= GetAdvFVal("SB2","B2_QATU",cFilSB2+aCols[nX][nPProduto]+cLocal,1,0)
			nQtdRes	 	:= GetAdvFVal("SB2","B2_RESERVA",cFilSB2+aCols[nX][nPProduto]+cLocal,1,0)
			nQtdDispo 	:= (nQtdEst - nQtdRes) 
			                       
			//nQtdReserva:=0       
			//SC0->(DbSetOrder(1))
			//If !Empty( GdFieldGet("C6_RESERVA",nX) ) .And. SC0->(DbSeek(xFilial("SC0")+M->C5_NUM+GdFieldGet("C6_PRODUTO",nX)+GdFieldGet("C6_LOCAL",nX) ))
				//nQtdReserva:=SC0->C0_QUANT
			//EndIf
			
			//nQtdDispo+=nQtdReserva
			
			if aCols[nX][nPQtdLib] > nQtdDispo .and. nQtdDispo > 0
				nLibera	:= nQtdDispo
				lIdentmsg	:= .F. // altera variavel logica para provavel mensagem de bloqueio, se houver
			elseif nQtdDispo > 0 .AND. aCols[nX][nPQtdLib] <= nQtdDispo
				nLibera	:= aCols[nX][nPQtdLib]
			else
				nLibera	:= 0
				lIdentmsg	:= .F. // altera variavel logica para provavel mensagem de bloqueio, se houver
			endif
			IF nLibera	== 0
				LOOP
			ENDIF
			nC6TOTAL	+= aCols[nx][nPPrcVen]*nLibera
			//Tratamento para somar o software no c�lculo da parcela m�nima na libera��o do pedido
			If substr(aCols[nX][nPosYMIDP],1,2) == "MD"
				nPosSW	:= aScan(aCols,{|x| x[nPItem] == substr(aCols[nx,nPosYMIDP],3,2) })
				nC6TOTAL	+= aCols[nPosSW][nPPrcVen]*nLibera
			EndIf


			//���������������������������������������������Ŀ
			//�Calcula o preco de lista                     �
			//�����������������������������������������������			
			nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],aCols[nX][nPPrcVen]*nLibera)
			nPrcLista := aCols[nX][nPPrUnit]
			If ( nPrcLista == 0 )
				nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],aCols[nX][nPPrcVen]*nLibera)
			EndIf
			nAcresFin := A410Arred(aCols[nX][nPPrcVen]*M->C5_ACRSFIN/100,"D2_PRCVEN")
			nValMerc  += A410Arred(nLibera*nAcresFin,"D2_TOTAL")
			nDesconto := a410Arred(nPrcLista*nLibera,"D2_DESCON")-nValMerc
			nDesconto := IIf(nDesconto==0,aCols[nX][nPValDesc],nDesconto)
			nDesconto := Max(0,nDesconto)
			nPrcLista += nAcresFin
			//Para os outros paises, este tratamento e feito no programas que calculam os impostos.
			If cPaisLoc=="BRA"
				nValMerc  += nDesconto
			Endif
			
			//���������������������������������������������Ŀ
			//�Agrega os itens para a funcao fiscal         �
			//�����������������������������������������������
			MaFisAdd(cProduto,;    					// 1-Codigo do Produto ( Obrigatorio )
			aCols[nX][nPTES],;	   					// 2-Codigo do TES ( Opcional )
			nLibera,;  								// 3-Quantidade ( Obrigatorio )
			round(nC6TOTAL/nLibera,2) /*nPrcLista*/,;// 4-Preco Unitario ( Obrigatorio )
			nDesconto,;    							// 5-Valor do Desconto ( Opcional )
			"",;	   								// 6-Numero da NF Original ( Devolucao/Benef )
			"",;									// 7-Serie da NF Original ( Devolucao/Benef )
			nRecOri,;			   					// 8-RecNo da NF Original no arq SD1/SD2
			(nC6TOTAL)*nFtFrete,;					// 9-Valor do Frete do Item ( Opcional )
			(nC6TOTAL)*nFtSegur,;					// 10-Valor da Despesa do item ( Opcional )
			(nC6TOTAL)*nFtDespe,;					// 11-Valor do Seguro do item ( Opcional )
			0,;										// 12-Valor do Frete Autonomo ( Opcional )
			nC6TOTAL 		/*nValMerc*/,;			// 13-Valor da Mercadoria ( Obrigatorio )
			0,;										// 14-Valor da Embalagem ( Opiconal )
			,;				 						//
			,;				  						//
			Iif(nPItem>0,aCols[nX,nPItem],""))
		endif
	Next nX
EndIf

aDupl := Condicao(MaFisRet(,"NF_BASEDUP"),M->C5_CONDPAG,MaFisRet(,"NF_VALIPI"),dDatabase,MaFisRet(,"NF_VALSOL"),,,)

//nVlMin := getmv("MV_PARCMIN") substituido para pegar o valor minimo de acordo com grupo de representantes

dbSelectarea("SE4")
dbSetOrder(1)
MsSeek(xFilial("SE4")+M->C5_CONDPAG)
lparc:= .T.
If !(SE4->E4_TIPO=="9")
	If len(aDupl) > 0
		For nx:= 1 to len(aDupl)
			If aDupl[nx,2] < nVlMin
				lparc := .F.
			Endif
		Next
	else
		lparc := .F.
	EndIf
EndIf

MaFisEnd()
MaFisRestore()

RestArea(_aArea)

If !lparc .and. !lIdentmsg
	alert("Pedido n�o ser� liberado! Valor m�nimo para parcela do pedido n�o foi atingida! H� quantidades indispon�veis em estoque ")//+ " 1a. Parcela de R$ "+transform(aDupl[1,2],"@! 999,999,999.99"))
elseif !lparc
	alert("Pedido n�o ser� liberado! Valor m�nimo para parcela do pedido n�o foi atingida!")// + " 1a. Parcela de R$ "+transform(aDupl[1,2],"@! 999,999,999.99"))
//else
//	alert("1a. Parcela ser� de R$ "+transform(aDupl[1,2],"@! 999,999,999.99"))
Endif

Return(lparc)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �P_MT440GR �Autor  �Microsiga           � Data �  03/19/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrZerDesc()

Local aAreaAtu := GetArea()
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaSC6	:= SC6->(GetArea())
Local lRet		:= .f.
local nI 

Local cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Local cUsrName	:= AllTrim(cUsername)
Local cUserLib	:= Upper(SuperGetMv("MV_NCUSRLB",,"lfelipe"))


If Upper(cUsrName) $ cUserLib
	
	SC5->(DbSetOrder(1))
	SC5->(DbSeek(xFilial("SC5")+SC5->C5_NUM))
	
	SC6->(DbSetOrder(1))
	SC6->(DbSeek(xFilial("SC5")+SC5->C5_NUM))
	
	
	For nI:=1 to Len(aCols)
		
		GdfieldPut("C6_YPRCORI",SC6->C6_PRCTAB,nI)
		GdfieldPut("C6_PRUNIT",SC6->C6_PRCVEN,nI)
		GdfieldPut("C6_DESCONT",0,nI)
		GdfieldPut("C6_VALDESC",0,nI)
		 
		GdfieldPut("C6_YZERDES","Z",nI)
		GdfieldPut("C6_X_USRLB",SubStr(UsrFullName(cUser),1,30),nI)

	Next	

	
EndIf 
   

RestArea(aAreaSC6)
RestArea(aAreaSC5)
RestArea(aAreaAtu)

Return //lRet
