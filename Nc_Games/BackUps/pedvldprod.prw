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
Local lCliFran:=U_PR112CLIFRAN(Iif( M->C5_TIPO $ "D*B" ,Posicione("SA2",1,xFilial("SA2")+M->(C5_CLIENTE+C5_LOJACLI),"A2_CGC"),Posicione("SA1",1,xFilial("SA1")+M->(C5_CLIENTE+C5_LOJACLI),"A1_CGC")))//Cliente Franchising
Local lSoftware:=U_M001IsSoftware(M->C6_PRODUTO)
aAREA	:= GETAREA()
lRET1	:= .T.
cBLQ		:= GETADVFVAL("SB1","B1_BLQVEND",XFILIAL("SB1")+M->C6_PRODUTO,1,"")
cTabela	:= M->C5_TABELA
cFATPV	:= M->C5_FATURPV
cPRODUTO	:= M->C6_PRODUTO
cCNPJ		:= GETADVFVAL("SA1","A1_CGC",XFILIAL("SA1")+M->C5_CLIENTE,1,"")
nPosTes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
cTipo		:= GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+M->C6_PRODUTO,1,"")


IF !lSoftware .And. ALLTRIM(cTipo) == "PA" .AND. cFATPV == "1"
	IF M->C5_TIPO == "N"
		DBSELECTAREA("DA0")
		DBSETORDER(1)
		IF DBSEEK(XFILIAL("DA0")+cTabela,.T.)
			cATIVO	:= DA0->DA0_ATIVO
			dDTFIM	:= DA0->DA0_DATATE
			IF cATIVO == "1" .AND. (EMPTY(dDTFIM).OR.dDTFIM >= ddatabase)
				DBSELECTAREA("DA1")
				DBSETORDER(1)
				IF DBSEEK(XFILIAL("DA1")+cTabela+cPRODUTO,.T.)
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



USER FUNCTION PEDBLQPROD(cCampo)

/*
PROGRAMA PARA VALIDAR INCLUSรO DO PRODUTO PARA
PRODUTOS QUE ESTEJAM BLOQUEADOS PARA VENDA - B1_BLQVEND
REGRA: BLOQUEIO SERม SOMENTE PARA TES QUE GEREM DUPLICATAS
INCLUIR VALIDADOR NO CAMPO C6_TES  - U_PEDBLQPROD("C6_TES")
INCLUIR GATILHO NO CAMPO C6_OPER - U_PEDBLQPROD("C6_OPER")
*/
aAREA	:= GETAREA()
lRET	:= .T.
nPosProd	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_PRODUTO'} )
nPosTes	:= aScan(aHeader,{ |x| AllTrim(x[2]) == 'C6_TES'} )
cFATPV	:= M->C5_FATURPV
cYorig	:= M->C5_YORIGEM

If cCampo == "C6_PRODUTO"
	cProduto	:= M->C6_PRODUTO
Else
	cProduto	:= aCols[n,nPosProd]
EndIf

IF cCampo == "C6_TES"
	cTES		:= M->C6_TES
ELSE
	cTES		:= aCols[n,nPosTes]
ENDIF

cBLQ		:= Iif(Alltrim(M->C5_XECOMER) != "C", GETADVFVAL("SB1","B1_BLQVEND",XFILIAL("SB1")+cProduto,1,""),   "2")//Nใo bloqueia pedido de E-commerce 
cCNPJ		:= GETADVFVAL("SA1","A1_CGC",XFILIAL("SA1")+M->C5_CLIENTE,1,"")
cDUPLIC		:= GETADVFVAL("SF4","F4_DUPLIC",XFILIAL("SF4")+cTES,1,"")

IF cDUPLIC == "S"
	IF cBLQ	== "1" .AND. LEFT(cCNPJ,8) <> "01455929" .and. cFATPV == "1" .and. !(ALLTRIM(cYorig) == "SIMULAR")
		//ALERT("Produto encontra-se bloqueado para vendas!!!")
		Help(" ",1,"PRODBLOQ",,"Produto encontra-se bloqueado para vendas!!!",1,0)
		aCols[n,nPosTes]	:= ""
		lRET	:= .F.
		
		IF ALLTRIM(cCampo) $ "C6_OPER/C6_PRODUTO"
			RET	:= ""
		ELSE
			RET	:= lRET
		ENDIF
		RESTAREA(aAREA)
		RETURN(RET)        
	ENDIF
ENDIF
IF ALLTRIM(cCampo) $ "C6_OPER/C6_PRODUTO"
	RET	:= cTES
ELSE
	RET	:= lRET
ENDIF

RESTAREA(aAREA)
RETURN(RET)

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