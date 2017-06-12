#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPEDVLDPRODบAutor  ณMicrosiga           บ Data ณ  04/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

USER FUNCTION PEDVLDPROD(cCampo)

Local aAREA		:= GetArea()
Local aAreaDA0	:= DA0->(GetArea())

Local lCliFran
Local lSoftware	:= U_M001IsSoftware(M->C6_PRODUTO)

Local lRET1		:= .T.
Local cBLQ		:= Posicione("SB1",1,xFilial("SB1")+M->C6_PRODUTO,"B1_BLQVEND")
Local cTabela	:= M->C5_TABELA
Local cFATPV	:= M->C5_FATURPV
Local cPRODUTO	:= M->C6_PRODUTO
Local cCNPJ		:= GETADVFVAL("SA1","A1_CGC",XFILIAL("SA1")+M->C5_CLIENTE,1,"")
Local nPosTes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
Local cTipo		:= GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+M->C6_PRODUTO,1,"")

lCliFran := U_PR112CLIFRAN(Iif( M->C5_TIPO $ "D*B" ,;
Posicione("SA2",1,xFilial("SA2")+M->(C5_CLIENTE+C5_LOJACLI),"A2_CGC"),;
Posicione("SA1",1,xFilial("SA1")+M->(C5_CLIENTE+C5_LOJACLI),"A1_CGC")))//Cliente Franchising

IF !lSoftware .And. AllTrim(cTipo) == "PA"
	IF M->C5_TIPO == "N"
		DbSelectArea("DA0")
		DbSetOrder(1)
		If DA0->(DbSeek(xFilial("DA0")+cTabela,.T.))
			cATIVO	:= DA0->DA0_ATIVO
			dDTFIM	:= DA0->DA0_DATATE
			IF cATIVO == "1" .AND. (EMPTY(dDTFIM).OR.dDTFIM >= ddatabase)
				DBSELECTAREA("DA1")
				DBSETORDER(1)
				IF DBSEEK(xFilial("DA1")+cTabela+cPRODUTO)
					cVerifica	:= ""
					While !DA1->(EOF()) .AND. cTabela+PADR(cPRODUTO,15) == DA1->(DA1_CODTAB+DA1_CODPRO)
						IF DTOS(DA1->DA1_DATVIG) > DTOS(DDATABASE) .OR. DA1->DA1_ATIVO == "2"
							cVERIFICA	+= "F"
						ELSEIF DTOS(DA1->DA1_DATVIG) <= DTOS(DDATABASE) .AND. DA1->DA1_ATIVO == "1"
							cVERIFICA	+= "S"
						ELSE
							cVERIFICA	+= "F"
						ENDIF
						DBSELECTAREA("DA1")
						DBSKIP()
					END
					IF !"S" $ cVERIFICA
						MYALERT("Verifique a validade da tabela de pre็os!"+" Produto: "+cPRODUTO+" ....")
						lRET1	:= .F.
						RESTAREA(aAREA)
						RETURN(lRET1)
					ENDIF
				ELSE
					MYALERT("Produto nใo cadastrado na tabela de pre็os!!!")
					lRET1	:= .F.
					RESTAREA(aAREA)
					RETURN(lRET1)
				ENDIF
			ELSE
				MYALERT("Tabela de pre็os inativa!!! "+cTabela)
				lRET1	:= .F.
				RESTAREA(aAREA)
				RETURN(lRET1)
			ENDIF
		ELSE
			MYALERT("Preencha o campo tabela de pre็os no cabe็alho do pedido!!! ")
			lRET1	:= .F.
			RESTAREA(aAREA)
			RETURN(lRET1)
		ENDIF
		If U_PR112PRODFRAN(M->C6_PRODUTO) .And. !lCliFran .And. ! ( IsIncallStack("U_COM08VTEX") .Or. IsIncallStack("U_COM08GRAVA") )
			MYALERT("Produto "+AllTrim(M->C6_PRODUTO)+" liberado somente para Cliente Franchising." )
			lRET1	:= .F.
			RESTAREA(aAREA)
			RETURN(lRET1)
		Endif
	ENDIF
ENDIF
RESTAREA(aAREA)

RETURN(lRET1)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPEDVLDPRODบAutor  ณMicrosiga           บ Data ณ  05/11/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ PROGRAMA PARA VALIDAR INCLUSรO DO PRODUTO PARA			  บฑฑ
ฑฑบ          ณ PRODUTOS QUE ESTEJAM BLOQUEADOS PARA VENDA - B1_BLQVEND	  บฑฑ
ฑฑบ          ณ REGRA: BLOQUEIO SERม SOMENTE PARA TES QUE GEREM DUPLICATAS บฑฑ
ฑฑบ          ณ INCLUIR VALIDADOR NO CAMPO C6_TES  - U_PEDBLQPROD("C6_TES")บฑฑ
ฑฑบ          ณ INCLUIR GATILHO NO CAMPO C6_OPER - U_PEDBLQPROD("C6_OPER") บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PedBlqProd(cCampo)

Local aArea		:= GetArea()
Local aAreaSC5	:= SC5->(GetArea())

Local lRet		:= .T.
Local nPosProd	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
Local nPosTes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )

Local cFatPv	:= M->C5_FATURPV
Local cYorig	:= M->C5_YORIGEM
Local cProduto	:= ""
Local cTes		:= ""

Local nInd		:= n

cCampo := IIf(Empty(cCampo),__ReadVar,cCampo)

cProduto:= aCols[nInd,nPosProd]
cTes	:= aCols[nInd,nPosTes]

If cCampo $ "C6_PRODUTO"
	cProduto:= M->C6_PRODUTO
ElseIf cCampo $ "C6_TES"
	cTes:= M->C6_TES
EndIf

cBLQ	:= IIf(Alltrim(M->C5_XECOMER)!= "C",Posicione("SB1",1,xFilial("SB1")+cProduto,"B1_BLQVEND"),"2")//Nใo bloqueia pedido de E-commerce
cCNPJ	:= Posicione("SA1",1,xFilial("SA1")+M->C5_CLIENTE,"A1_CGC")
cDuplic	:= Posicione("SF4",1,xFilial("SF4")+cTES,"F4_DUPLIC")

If cDuplic == "S"
	If cBLQ	== "1" .AND. Left(cCNPJ,8) <> "01455929" .and. !(AllTrim(cYorig) == "SIMULAR")
		//ALERT("Produto encontra-se bloqueado para vendas!!!")
		Help(" ",1,"ProdBlq",,"Produto encontra-se bloqueado para vendas!!!",1,0)
		//aCols[nInd,nPosTes]	:= ""
		lRet	:= .F.
		If Alltrim(cCampo) $ "C6_OPER*C6_PRODUTO"
			cRet := ""
		EndIf
	Else
		If Alltrim(cCampo) $ "C6_TES"
			cRet := lRet
		Else
			cRet := cTES
		EndIf
	EndIf
EndIf

If Alltrim(cCampo) $ "C6_OPER*C6_PRODUTO"
	cRet := cTES
Else
	cRet := lRet
EndIf

RestArea(aAreaSC5)
RestArea(aArea)

Return(cRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPEDVLDPRODบAutor  ณMicrosiga           บ Data ณ  04/30/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MyAlert(cMensagem)
HELP(" ",1,"ERRO",,cMensagem,1,) //help(cRotina,nLinha,cCampo,cNome,cMensagem,nLinha1,nColuna,lPop,hWnd,nHeight,nWidth,lGravaLog)
Return
