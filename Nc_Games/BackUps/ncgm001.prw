#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/05/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001PZ1Grv(cAcao,cOrcamento,cFilOrig,cFilDest,cPVOrigem,cPVDestino,cDocSaida,;
cSerieSaida,cDocEntrada,cSerieEntrada,dDtLibWMS,dDtExpedicao, cObs, lErr,cCliOrig,cLojaOrig,cCliDest,cLojaDest,cRomaneio)
Local nRecPZ1:=0

If cAcao=="GRAVA_PEDIDO_ORIGEM"
	If !U_M001TemPV(cFilOrig,cPVOrigem+cFilDest,1,@nRecPZ1)
		PZ1->(RecLock("PZ1",.T.))
		PZ1->PZ1_FILIAL	:=xFilial("PZ1")
		PZ1->PZ1_PVORIG :=cPVOrigem
		PZ1->PZ1_CLIORI  :=cCliOrig
		PZ1->PZ1_LJORIG  :=cLojaOrig
		PZ1->PZ1_FILORI	:=cFilOrig
		PZ1->PZ1_FILDES	:=cFilDest
		PZ1->(MsUnLock())
		U_M001PZ2Grv(cPVOrigem,cFilOrig,cAcao)
		StartJob("U_NCGJ001", GetEnvServer(), .F. , {cEmpAnt, cFilAnt, "GRAVA_PEDIDO_DESTINO", .T.} )
		//StartJob("U_NCGJ001", GetEnvServer(), .F. , {cEmpAnt, cFilAnt, "GRAVA_WMS_PEDIDO", .T.} )
	EndIf
	
ElseIf  cAcao=="ESTORNA_LIBERACAO_DESTINO"
	If U_M001TemPV(PZ1->PZ1_FILORI,PZ1->PZ1_PVORIG,1,@nRecPZ1) //PZ1->(DbSeek(xFilial("PZ1")+cFilOrig+cPVOrigem+cFilDest))
		PZ1->(DbGoTo(nRecPZ1))
		PZ1->(RecLock("PZ1",.F.))
		PZ1->PZ1_EXCLUI:="S"
		PZ1->(MsUnLock())
		U_M001PZ2Grv(cPVOrigem,cFilOrig,"ESTORNA_LIBERACAO_ORIGEM")
		StartJob("U_NCGJ001", GetEnvServer(), .F. , {cEmpAnt, cFilAnt, "ESTORNA_LIBERACAO_DESTINO", .T. })
	EndIf
ElseIf cAcao=="GRAVA_NOTA_SAIDA"
	PZ1->(RecLock("PZ1",.F.))
	PZ1->PZ1_DOCSF2:=cDocSaida
	PZ1->PZ1_SERSF2:=cSerieSaida
	PZ1->(MsUnLock())
	U_M001PZ2Grv(cPVOrigem,cFilOrig,"GRAVA_NOTA_SAIDA","Tarefa Executada com Sucesso")
ElseIf cAcao=="GRAVA_NOTA_ENTRADA_ORIGEM"
	//DbSelectArea("PZ1")
	//DbSetOrder(1)
	If U_M001TemPV(cFilOrig,cPVOrigem,1,@nRecPZ1) //PZ1->(DbSeek(xFilial("PZ1") + cFilOrig + cPVOrigem))
		PZ1->(DbGoTo(nRecPZ1))
		PZ1->(RecLock("PZ1",.F.))
		PZ1->PZ1_DOCSF1:=cDocEntrada
		PZ1->PZ1_SERSF1:=cSerieEntrada
		PZ1->(MsUnLock())
		U_M001PZ2Grv(cPVOrigem,cFilOrig,"GRAVA_NOTA_ENTRADA_ORIGEM", cObs, lErr)
		
	EndIf
ElseIf cAcao=="GRAVA_NOTA_SAIDA_ORIGEM"
	//DbSelectArea("PZ1")
	//DbSetOrder(1)
	If U_M001TemPV(cFilOrig,cPVOrigem,1,@nRecPZ1) //PZ1->(DbSeek(xFilial("PZ1") + cFilOrig + cPVOrigem))
		PZ1->(DbGoTo(nRecPZ1))
		PZ1->(RecLock("PZ1",.F.))
		PZ1->PZ1_DSF2OR := cDocSaida
		PZ1->PZ1_SSF2OR := cSerieSaida
		PZ1->(MsUnLock())
		U_M001PZ2Grv(cPVOrigem,cFilOrig,"GRAVA_NOTA_SAIDA_ORIGEM", cObs, lErr)
	EndIf
ElseIf cAcao=="GRAVA_DATA_EXPEDICAO"
	PZ1->(RecLock("PZ1",.F.))
	PZ1->PZ1_DTEXPE:=dDtExpedicao
	PZ1->(MsUnLock())
	U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,cAcao)
ElseIf cAcao=="GRAVA_ROMANEIO"
	PZ1->(RecLock("PZ1",.F.))
	PZ1->PZ1_ROMAN :=cRomaneio
	PZ1->(MsUnLock())
	cObs	:= "Romaneio gravado em "+dtoc(MsDate())+" - "+time()
	U_M001PZ2Grv(PZ1->PZ1_PVORIG,PZ1->PZ1_FILORI,cAcao,cObs)
EndIf

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/05/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001PZ2Grv(cPVOrigem,cFilOrig,cAcao,cObservacao,lErro)
Local cNomeUser	:=UsrFullName( RetCodUsr())
Default lErro:=.F.
Default cObservacao:=""

If IsBlind()
	cNomeUser:="JOB"
EndIf

PZ2->(RecLock("PZ2",.T.))
PZ2->PZ2_FILIAL	:=xFilial("PZ2")
PZ2->PZ2_PVORIG :=cPVOrigem
PZ2->PZ2_FILORI	:=cFilOrig
PZ2->PZ2_ACAO	:=cAcao
PZ2->PZ2_DATA	:=MsDate()
PZ2->PZ2_HORA	:=Time()
PZ2->PZ2_USUARIO:=cNomeUser
PZ2->PZ2_OBS	:=cObservacao
If lErro
	PZ2->PZ2_ERRO  :="S"
EndIf

PZ2->(MsUnLock())

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/06/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001IsSoftware( cProduto )
Local aAreaAtu	:=GetArea()
Local aAreaSB5	:=SB5->(GetArea())
Local lSoftware	:=.F.

SB5->(DbSetOrder(1))//B5_FILIAL+B5_COD
If SB5->(DbSeek( xFilial("SB5")+ cProduto ))
	lSoftware:=(SB5->B5_YSOFTW=="1")
EndIf

RestArea(aAreaSB5)
RestArea(aAreaAtu)
Return lSoftware
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/07/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001TemPV(cFilPV,cPedido,nOrdem,nRecPZ1)
Local cChavePZ1:=xFilial("PZ1")+cFilPV+cPedido
Local nLenChave:=Len(cChavePZ1)
Local lTemPV:=.F.
Default nRecPZ1:=0

PZ1->(DbSetOrder(nOrdem))
bWhile:=&("{|| Left( PZ1->("+PZ1->(IndexKey())+"),"+Str(nLenChave,2)+")=='"+cChavePZ1+"' }")

PZ1->(DbSeek( cChavePZ1))

Do While PZ1->(!Eof()) .And. Eval(bWhile)
	If Empty(PZ1->PZ1_DTEXCL) .And. Empty(PZ1->PZ1_EXCLUI)
		lTemPV:=.T.
		nRecPZ1:=PZ1->(Recno())
		Exit
	EndIf
	PZ1->(DbSkip())
EndDo


Return lTemPV



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/07/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001TemNF(cFilNF,cNota,cSerie,cCliente,cLoja,nRecPZ1)
Local cChavePZ1:=xFilial("PZ1")+cFilNF+cNota+cSerie+cCliente+cLoja
Local nLenChave:=Len(cChavePZ1)
Local lTemNF:=.F.
Default nRecPZ1:=0

PZ1->(DbSetOrder(3))//PZ1_FILIAL+PZ1_FILDES+PZ1_DOCSF2+PZ1_SERSF2+PZ1_CLIDES+PZ1_LJDEST
bWhile:=&("{|| Left( PZ1->("+PZ1->(IndexKey())+"),"+Str(nLenChave,2)+")=='"+cChavePZ1+"' }")

PZ1->(DbSeek( cChavePZ1))
Do While PZ1->(!Eof()) .And. Eval(bWhile)
	If Empty(PZ1->PZ1_DTEXCL)
		lTemPV:=.T.
		nRecPZ1:=PZ1->(Recno())
		Exit
	EndIf
	PZ1->(DbSkip())
EndDo

Return lTemNF
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/06/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001GetSoftware( cProduto )
Local aAreaAtu	:=GetArea()
Local aAreaSB5	:=SB5->(GetArea())
Local cProdSoft	:=""

SB5->(DbSetOrder(1))//B5_FILIAL+B5_COD
If SB5->(DbSeek( xFilial("SB5")+ cProduto ))
	cProdSoft	:=SB5->B5_YCODMS
EndIf

RestArea(aAreaSB5)
RestArea(aAreaAtu)
Return cProdSoft



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  09/06/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001GetMidia( cProduto )
Local aAreaAtu	:=GetArea()
Local aAreaSB5	:=SB5->(GetArea())
Local cProdMidia	:=""

SB5->(DbSetOrder(1))//B5_FILIAL+B5_COD
If SB5->(DbSeek( xFilial("SB5")+ cProduto ))
	cProdMidia	:=SB5->B5_YCODMS
EndIf

RestArea(aAreaSB5)
RestArea(aAreaAtu)
Return cProdMidia


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  04/29/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function xAcertSA1()
RpcSetEnv("01","03")

SA1->(DbSeek(xFilial()))

Do While SA1->(!Eof())
	
	cEndereco:=Padr( U_M001END(SA1->A1_END) , 50)
	
	If !cEndereco==SA1->A1_END
		SA1->(RecLock("SA1",.F.))
		SA1->A1_END		:=cEndereco
		SA1->A1_ENDCOB	:=cEndereco
		SA1->A1_ENDENT	:=cEndereco
		SA1->(MsUnLock())
	EndIf
	
	
	SA1->(DbSkip())
EndDo



Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FISATEND  �Autor  �Microsiga           � Data �  04/11/14   ���
�������������������������������������������������������������������������͹��
���Ponto de entrada no �FisGetEnd-(Retorna a estrutura do endereco passado)���
��														�                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001END(cEndereco)
Local nVirgula
Local nEspaco

cEndereco	:=AllTrim(cEndereco)
nVirgula	:=Rat(",",cEndereco)
nEspaco		:=Rat(" ",cEndereco)


If nVirgula==0 .And. nEspaco>0	.And. Val(Right(cEndereco,1)  )  >0
	cEndereco:=Stuff(cEndereco, nEspaco,1, ", ")
EndIf



Return cEndereco

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  05/23/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001Prc(nLinha, nPrcVen,nPrecList)
Local nValVPC		:=0
Local cCampo		:=__ReadVar
Local cProduto		:=GdFieldGet( "C6_PRODUTO", nLinha)
Local nQuantidade 	:=GdFieldGet( "C6_QTDVEN" , nLinha)
Local nPercOver 	:=GdFieldGet( "C6_YPEOVER", nLinha)
Local nPercDesc 	:=GdFieldGet( "C6_DESCONT", nLinha)

If  cCampo=="M->C6_PRODUTO"
	cProduto	:=M->C6_PRODUTO
ElseIf cCampo=="M->C6_QTDVEN"
	nQuantidade	:=M->C6_QTDVEN
ElseIf cCampo=="M->C6_YPEOVER"
	nPercOver	:=M->C6_YPEOVER
ElseIf cCampo=="M->C6_DESCONT"
	nPercDesc	:=M->C6_DESCONT
EndIf

nPrcVen:=nPrecList
If nPercOver>0
	GdFieldPut("C6_YVLOVER", nPrecList *nPercOver/100 ,nLinha)
	nPrcVen:=nPrcVen*(1+GdFieldGet("C6_YPEOVER", nLinha)/100)
EndIf
nPrcVen:= nPrcVen*((100-M->C5_DESC1)/100 )
U_PR708VPCPV(nLinha,cProduto,@nValVPC)
If nValVPC>0
	nVlrVPCPV:= Round (  nPrcVen*(nValVPC/100 )  ,AvSx3('C6_YVALVPC',4))
	GdFieldPut('C6_YPERVPC', nValVPC   ,nLinha)
	GdFieldPut('C6_YVALVPC',  nVlrVPCPV*nQuantidade  ,nLinha)
	nPrcVen:=nPrcVen-nVlrVPCPV
EndIf

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  06/10/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001BORDE(cAlias,nReg,nOpcx)
FinA060(3)
Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  07/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001DuplPV(cPedido)
Local lRetorno
Processa({|| lRetorno:=VerDuplic(cPedido) },"Verificando duplicidade" )

Return lRetorno
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  07/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VerDuplic(cPedido)
Local aAreaAtu	:=GetArea()
Local aAreaSC5	:=SC5->(GetArea())
Local aAreaSC6	:=SC6->(GetArea())

Local cQuery	:=""
Local cAliasQry	:=GetNextAlias()
Local cTableSC5	:=RetSqlName("SC5")
Local cTableSC6	:=RetSqlName("SC6")
Local aStructWork:={}
Local aPV			:={}
Local dEmisOri
Local cNomeWork


Local aCpoBrw	:={}
Local aCpoTrb	:={}

Local lLibPedido:=IsIncallStack("U_MA440VLD")
Local nCol
Local oBtn1
Local oBtn2
Local oBtn3


Local oDlg
Local lGravar	:=.F.
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| lRetorno:=.T.,oDlg:End() }
Local bCancel	:={|| lRetorno:=.F.,oDlg:End() }
Local aButtons	:={}
Local aFoldCabec:={OemToAnsi('')   }
Local aFoldItens:={OemToAnsi('')}
Local nOpcy		:=0
Local oFoldCabec
Local oFoldItens
Local nInd
Local bCond     := {|| .T. }
Local bAction1  := {|| .T. }
Local bAction2  := {|| .T. }
Local cSeek     := ""
Local bWhile    := {|| }
Local nItenSC6
Local lTemPV	:=.F.
Local cNomeOri
Local aCores := {{"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ)",'ENABLE' },;		//Pedido em Aberto
{ "!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)" ,'DISABLE'},;		   	//Pedido Encerrado
{ "!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)",'BR_AMARELO'},;
{ "C5_BLQ == '1'",'BR_AZUL'},;	//Pedido Bloquedo por regra
{ "C5_BLQ == '2'",'BR_LARANJA'}}	//Pedido Bloquedo por verba

Private cMarca	:= GetMark()
Private lInverte := .F.

Default cPedido:=SC5->C5_NUM

SC5->(DbSeek(xFilial("SC5")+cPedido))

If !SC5->C5_XSTAPED=="00"
	
	AADD(aStructWork,{"C5_LIBEROK"	,AvSX3("C5_LIBEROK",2)		,AvSX3("C5_LIBEROK",3),AvSX3("C5_LIBEROK",4)		})
	AADD(aStructWork,{"C5_NOTA"	,AvSX3("C5_NOTA",2)		,AvSX3("C5_NOTA",3),AvSX3("C5_NOTA",4)		})
	AADD(aStructWork,{"C5_BLQ"	,AvSX3("C5_BLQ",2)		,AvSX3("C5_BLQ",3),AvSX3("C5_BLQ",4)		})
	
	AADD(aStructWork,{"EMISSORI"	,"D"		,8,0		})
	AADD(aStructWork,{"EMISSCOP"	,"D"		,8,0		})
	
	
	AADD(aStructWork,{"PVORI"	,AvSX3("C6_NUM",2)		,AvSX3("C6_NUM",3),AvSX3("C6_NUM",4)		})
	AADD(aStructWork,{"CLIORI"	,AvSX3("C6_CLI",2)		,AvSX3("C6_CLI",3),AvSX3("C6_CLI",4)		})
	AADD(aStructWork,{"LOJAORI"	,AvSX3("C6_LOJA",2)		,AvSX3("C6_LOJA",3),AvSX3("C6_LOJA",4)		})
	AADD(aStructWork,{"NOMEORI"	,AvSX3("C5_NOMCLI",2)	,AvSX3("C5_NOMCLI",3),AvSX3("C5_NOMCLI",4)		})
	AADD(aStructWork,{"PRODORI"	,AvSX3("C6_PRODUTO",2)	,AvSX3("C6_PRODUTO",3),AvSX3("C6_PRODUTO",4)		})
	AADD(aStructWork,{"QTDORI"	,AvSX3("C6_QTDVEN",2)	,AvSX3("C6_QTDVEN",3),AvSX3("C6_QTDVEN",4)})
	AADD(aStructWork,{"PRCORI"	,AvSX3("C6_PRCVEN",2)	,AvSX3("C6_PRCVEN",3),AvSX3("C6_PRCVEN",4)})
	AADD(aStructWork,{"VLRORI"	,AvSX3("C6_VALOR",2)		,AvSX3("C6_VALOR",3),AvSX3("C6_VALOR",4)	})
	AADD(aStructWork,{"TABORI"	,AvSX3("C6_PRCTAB",2)		,AvSX3("C6_PRCTAB",3),AvSX3("C6_PRCTAB",4)	})
	
	AADD(aStructWork,{"PVCOP"	,AvSX3("C6_NUM",2)		,AvSX3("C6_NUM",3),AvSX3("C6_NUM",4)		})
	AADD(aStructWork,{"PRODCOP"	,AvSX3("C6_PRODUTO",2)	,AvSX3("C6_PRODUTO",3),AvSX3("C6_PRODUTO",4)		})
	AADD(aStructWork,{"QTDCOP"	,AvSX3("C6_QTDVEN",2)	,AvSX3("C6_QTDVEN",3),AvSX3("C6_QTDVEN",4)})
	AADD(aStructWork,{"PRCCOP"	,AvSX3("C6_PRCVEN",2)	,AvSX3("C6_PRCVEN",3),AvSX3("C6_PRCVEN",4)})
	AADD(aStructWork,{"VLRCOP"	,AvSX3("C6_VALOR",2)		,AvSX3("C6_VALOR",3),AvSX3("C6_VALOR",4)	})
	AADD(aStructWork,{"TABCOP"	,AvSX3("C6_PRCTAB",2)		,AvSX3("C6_PRCTAB",3),AvSX3("C6_PRCTAB",4)	})
	
	If Select("WORK")>0
		WORK->(DbCloseArea())
	EndIf
	
	cNomeWork:=E_CriaTrab(,aStructWork,"WORK")
	
	cQuery+=" select * From "
	cQuery+=" (select C6_NUM PVORI ,C6_CLI CLIORI ,C6_LOJA LOJAORI,C6_PRODUTO PRODORI,C6_QTDVEN QTDORI,C6_PRCVEN PRCORI,C6_VALOR VLRORI,C6_PRCTAB TABORI"
	cQuery+=" from "+cTableSC6
	cQuery+=" where c6_filial='"+xFilial("SC6")+"'"
	cQuery+=" and c6_num='"+cPedido+"'"
	cQuery+=" and d_e_l_e_t_=' ') tabA,"
	cQuery+=" (select c6_num PVCOP ,c6_cli CLICOP ,c6_loja LOJACOP,c6_produto PRODCOP,c6_qtdven QTDCOP,C6_PRCVEN PRCCOP,C6_VALOR VLRCOP,C6_PRCTAB TABCOP"
	cQuery+=" from "+cTableSC5+" sc5 ,"+cTableSC6+" sc6
	cQuery+=" where c5_filial='"+xFilial("SC5")+"'"
	cQuery+=" and c5_num<>'"+cPedido+"'"
	cQuery+=" and c5_xstaped<>'00'"
	cQuery+=" and c5_cliente='"+SC5->C5_CLIENTE+"'"
	cQuery+=" and sc5.c5_lojacli='"+SC5->C5_LOJACLI+"'"
	cQuery+=" and c5_emissao between '"+Dtos(FirstDay(SC5->C5_EMISSAO))+"' and '"+Dtos(LastDay(SC5->C5_EMISSAO))+"'"
	cQuery+=" and sc5.d_e_l_e_t_=' '"
	cQuery+=" and sc5.c5_filial=sc6.c6_filial"
	cQuery+=" and sc5.c5_num=sc6.c6_num"
	cQuery+=" and sc6.d_e_l_e_t_=' '"
	cQuery+=" and Exists ( select 'X' from "+cTableSC6+" TabSC6 where TabSC6.c6_filial='"+xFilial("SC6")+"' and TabSC6.c6_num='"+cPedido+"' and TabSC6.d_e_l_e_t_=' ' and TabSC6.c6_produto=SC6.c6_produto)) tabB
	cQuery+=" where tabA.PRODORI=tabB.PRODCOP "
	cQuery+=" Order By 1"
	
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry  ,.F.,.T.)
	
	TcSetField(cAliasQry,"QTDORI","N",AvSX3("C6_QTDVEN",3),AvSX3("C6_QTDVEN",4))
	TcSetField(cAliasQry,"PRCORI","N",AvSX3("C6_PRCVEN",3),AvSX3("C6_PRCVEN",4))
	TcSetField(cAliasQry,"VLRORI","N",AvSX3("C6_VALOR",3),AvSX3("C6_VALOR",4))
	TcSetField(cAliasQry,"QTDCOP","N",AvSX3("C6_QTDVEN",3),AvSX3("C6_QTDVEN",4))
	TcSetField(cAliasQry,"PRCCOP","N",AvSX3("C6_PRCVEN",3),AvSX3("C6_PRCVEN",4))
	TcSetField(cAliasQry,"VLRCOP","N",AvSX3("C6_VALOR",3),AvSX3("C6_VALOR",4))
	
	
	
	If !(cAliasQry)->(Eof() .And. Bof())
		
		SC5->(MsSeek(xFilial("SC5")+cPedido ))
		
		nItenSC6:=ContItens(cPedido,cTableSC6)
		cNomeOri:=SC5->C5_NOMCLI
		dEmisOri:=SC5->C5_EMISSAO
		
		SC6->(DbSetOrder(1))
		Do While (cAliasQry)->(!Eof())
			
			If ContItens((cAliasQry)->PVCOP,cTableSC6)<>nItenSC6
				(cAliasQry)->(DbSkip());Loop
			EndIf
			
			If Ascan(aPV,(cAliasQry)->PVCOP)==0
				AADD(aPV,(cAliasQry)->PVCOP)
			EndIf
			
			SC5->(MsSeek(xFilial("SC5")+(cAliasQry)->PVCOP  ))
			
			lTemPV:=.T.
			Work->(DbAppend())
			AvReplace(cAliasQry,"Work")
			Work->NOMEORI:=cNomeOri
			Work->EMISSORI:=dEmisOri
			
			Work->C5_LIBEROK:=SC5->C5_LIBEROK
			Work->C5_NOTA:=SC5->C5_NOTA
			Work->C5_BLQ:=SC5->C5_BLQ
			Work->EMISSCOP:=SC5->C5_EMISSAO
			
			(cAliasQry)->(DbSkip())
		EndDo
		
	EndIf
	(cAliasQry)->(DbCloseArea())
	RestArea(aAreaAtu)
	
	
	
	If Len(aPV)>0
		
		aAdd( aCpoBrw, { "EMISSCOP"		,	,AvSx3("C5_EMISSAO",5)   		,		AvSx3("C5_EMISSAO",6) } )
		aAdd( aCpoBrw, { "PVCOP"		,	,"PV Encontrado"   			,		AvSx3("C5_NUM",6) } )
		aAdd( aCpoBrw, {{|| Work->(CLIORI+"-"+LOJAORI+" "+NOMEORI)  }		,	,"Cliente "   	,		AvSx3("C6_CLI",6) } )
		aAdd( aCpoBrw, { "PRODCOP"		,	,"Produto"   		,		AvSx3("C6_PRODUTO",6) } )
		aAdd( aCpoBrw, { "QTDCOP"		,	,"Quantidade"   	  		,		AvSx3("C6_QTDVEN",6) } )
		aAdd( aCpoBrw, { "TABCOP"		,	,AvSx3("C6_PRCTAB",5)   		 ,		AvSx3("C6_PRCTAB ",6) } )
		aAdd( aCpoBrw, { "PRCCOP"		,	,AvSx3("C6_PRCVEN",5)   		 ,		AvSx3("C6_PRCVEN",6) } )
		aAdd( aCpoBrw, { "VLRCOP"		,	,"Total"   	   	,		AvSx3("C6_VALOR",6) } )
		
		
		aAdd( aCpoBrw, { "EMISSORI"		,	,AvSx3("C5_EMISSAO",5)   		,		AvSx3("C5_EMISSAO",6) } )
		aAdd( aCpoBrw, { "PVORI"		,	,"PV Incluido"   			,		AvSx3("C5_NUM",6) } )
		aAdd( aCpoBrw, { "PRODORI"		,	,"Produto"   		,		AvSx3("C6_PRODUTO",6) } )
		aAdd( aCpoBrw, { "QTDORI"		,	,"Quantidade"   		,		AvSx3("C6_QTDVEN",6) } )
		aAdd( aCpoBrw, { "TABORI"		,	,AvSx3("C6_PRCTAB",5)   		 ,		AvSx3("C6_PRCTAB ",6) } )
		aAdd( aCpoBrw, { "PRCORI"		,	,AvSx3("C6_PRCVEN",5)   		,		AvSx3("C6_PRCVEN",6) } )
		aAdd( aCpoBrw, { "VLRORI"		,	,"Total"   		,		AvSx3("C6_VALOR",6) } )
		
		
		
		aAdd( aCpoBrw, { {|| "" }		,	,""   		,		"" } )
		
		aadd(aButtons,{"BUDGET",{||   A410Legend() },"Legenda PV Encontrado", "Legenda PV Encontrado" })
		
		
		DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Pedido de Venda") From 200,0 To 650,1820 of oMainWnd PIXEL
		
		Work->(DbGoTop())
		
		If Len(aPV)==1
			cMensagem:="Foi encontrado o Pedido de Venda "+aPV[1]+"  semelhante ao Pedido "+cPedido
		Else
			cMensagem:="Foram encontrados os Pedidos de Venda semelhantes ao Pedido "+cPedido
		EndIf
		
		//
		oEdit := tSimpleEditor():New(04,04, oDlg,900,030,,.T.,,,.T.)
		cHtml:='<html><p align="center"><b><font size="5" color="#FF0000">Aten��o </font></b></p><p align="center"><b><font size="5" color="#FF0000">'+cMensagem+'</font></b></p></html>'
		oEdit:Load(cHtml)
		
		Work->(DbGoTop())
		oMarkSC5 :=MsSelect():New("WORK","","  ",aCpoBrw,@lInverte,@cMarca,{040,004,200,900} ,/*cTopFun*/,/*cBotFun*/ ,oDlg,,aCores)
		
		nCol:=544
		
		If lLibPedido
			oBtn1 := tButton():New(208,nCol	,  "Confirmar"  			,oDlg,{|| oDlg:End(),lGravar:=.T.				},037,012,,,,.T.)
			nCol+=48
		EndIf
		
		
		oBtn2 := tButton():New(208,nCol	,  Iif(lLibPedido,"Cancelar Lib.","Fechar")  			,oDlg,{|| oDlg:End(),lGravar:=.F.			},037,012,,,,.T.)
		nCol+=48
		
		
		oBtn3 := tButton():New(208,nCol	,  "Legenda"  			   ,oDlg,{|| A410Legend()				},037,012,,,,.T.)
		
		
		//ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) ) Centered
		
		ACTIVATE MSDIALOG oDlg Centered
		
	Else
		lGravar:=.T.
	EndIf
	Work->(E_EraseArq(cNomeWork))
	
EndIf

RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aAreaAtu)

Return lGravar

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  07/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ContItens(cPedido,cTableSC6)
Local aAreaAtu:=GetArea()
Local nItem:=0
Local cQuery:=""
Local cAliasQry	:=GetNextAlias()

cQuery+=" Select Count(1) Contar "
cQuery+=" From "+cTableSC6+" sc6"
cQuery+=" Where sc6.c6_filial='"+xFilial("SC6")+"'"
cQuery+=" and sc6.c6_num='"+cPedido+"'"
cQuery+=" and sc6.d_e_l_e_t_=' '"
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry  ,.F.,.T.)

nItem:=(cAliasQry)->Contar
(cAliasQry)->(DbCloseArea())

RestArea(aAreaAtu)
Return nItem


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  08/19/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+"_.LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  11/05/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GDCheckKey( aCpo , nModelo , aNoEmpty , cMsgAviso , lShowAviso )

Local aAux      	:= {}
Local aLinhas   	:= {}
Local aChkNoEmpty	:= {}
Local aEmptys		:= {}

Local cString   	:= ""
Local cEmptyString	:= ""
Local cCrLf     	:= Chr(13) + Chr(10)

Local lRet		 	:= .T.
Local lDuplic		:= .F.
Local lEmpty		:= .F.

Local nLoop     	:= 0
Local nLoop2    	:= 0
Local nPosCampo 	:= 0
Local nPosAtu   	:= 0
Local nPosDelete	:=Len(aHeader)+1

DEFAULT nModelo 	:= 1
DEFAULT aNoEmpty	:= {}
DEFAULT lShowAviso	:= .T.

//������������������������������������������������������������������������Ŀ
//� Monta o array auxiliar com os campos a serem validados                 �
//��������������������������������������������������������������������������

For nLoop := 1 To Len( aCpo )
	IF ( ( nPosCampo := GDFieldPos( aCpo[ nLoop ] ) ) == 0 )
		Loop
	EndIF
	AAdd( aAux, { aCpo[ nLoop ] , nPosCampo , .F. } )
Next nLoop

For nLoop := 1 To Len( aNoEmpty )
	IF ( ( nPosCampo := GDFieldPos( aNoEmpty[ nLoop ] ) ) == 0 )
		Loop
	EndIF
	aAdd( aChkNoEmpty , { aNoEmpty[ nLoop ] , nPosCampo, .F. } )
Next nLoop

//������������������������������������������������������������������������Ŀ
//� Ordena por posicao no acols                                            �
//��������������������������������������������������������������������������
ASort( aAux, , , { |x,y| y[2] > x[2] } )
aSort( aChkNoEmpty , , , { |x,y| y[2] > x[2] } )

//������������������������������������������������������������������������Ŀ
//� Percorre o acols para verificar as linhas duplicadas                   �
//��������������������������������������������������������������������������

For nLoop := 1 To Len( aCols )

	If !GDDeleted( nLoop ) 
	
		IF ( n <> nLoop )

			For nLoop2 := 1 To Len( aAux )

				//������������������������������������������������������������������������Ŀ
				//�Marca no array caso o campo esteja duplicado 		                   �
				//��������������������������������������������������������������������������
				If !aCols[ N , nPosDelete ]
					nPosAtu := aAux[ nLoop2, 2 ]
					aAux[ nLoop2, 3 ] := ( aCols[ nLoop, nPosAtu ] == aCols[ N , nPosAtu ] )
				EndIf	

			Next nLoop2
		
		EndIF	

		For nLoop2 := 1 To Len( aChkNoEmpty )

			//������������������������������������������������������������������������Ŀ
			//�Marca no array caso o campo esteja Vazio	 		                       �
			//��������������������������������������������������������������������������
			nPosAtu := aChkNoEmpty[ nLoop2 , 2 ]
			aChkNoEmpty[ nLoop2 , 3 ] := Empty( aCols[ nLoop , nPosAtu ] )

		Next nLoop2

		//������������������������������������������������������������������������Ŀ
		//� Pesquisa algum campo que nao esteja duplicado						   �
		//��������������������������������������������������������������������������
		lDuplic := ( ( n <> nLoop ) .and. Empty( AScan( aAux, { |x| !x[3] } ) ) )

		//������������������������������������������������������������������������Ŀ
		//� Pesquisa algum campo que esteja vazio                 				   �
		//��������������������������������������������������������������������������
		lEmpty	:= !Empty( aScan( aChkNoEmpty , { |x| x[3] } ) )

		If ( ( lDuplic ) .or. ( lEmpty ) )

			lRet := .F.
			If nModelo == 4
				IF ( lDuplic )
					AAdd( aLinhas , nLoop )
				EndIF
				IF ( lEmpty )
					aAdd( aEmptys , nLoop ) 
				EndIF	
			Else 	
				Exit									
			EndIf

		EndIf

		//������������������������������������������������������������������������Ŀ
		//� Marca todos os campos como nao duplicados novamente                    �
		//��������������������������������������������������������������������������
		IF ( lDuplic )
			AEval( aAux, { |x| x[3] := .F. } )
		EndIF	
		
		//������������������������������������������������������������������������Ŀ
		//� Marca todos os campos como nao vazios novamente                    	   �
		//��������������������������������������������������������������������������
		IF ( lEmpty )
			aEval( aChkNoEmpty , { |x| x[3] := .F. } )
		EndIF	

	EndIf

Next nLoop

If !lRet .And. nModelo <> 1

	//������������������������������������������������������������������������Ŀ
	//� Monta a mensagem conforme o modelo                                     �
	//��������������������������������������������������������������������������
	IF ( lDuplic := !Empty( aLinhas ) )
		cString := "A linha "+StrZero(n,3)+" possui uma chave duplicada no browse."
	EndIF
	
	IF ( lEmpty := !Empty( aEmptys ) )
		cEmptyString := "A linha atual possui campo de Preenchimento Obrigat�rio."
	EndIF	

	If nModelo == 3 .Or. nModelo == 4
		
		IF ( lDuplic )
		
			cString += cCrLf +   "Campo(s):  "

			For nLoop := 1 To Len( aAux )
				cString += aHeader[ aAux[nLoop,2], 1 ] + ", " 		
			Next nLoop
			
			cString := Left( cString, Len( cString ) - 2 ) + "."
		
		EndIF	
		
		IF ( lEmpty )

			cEmptyString += cCrLf +  "Campo(s):  "

			For nLoop := 1 To Len( aChkNoEmpty )
				cEmptyString += aHeader[ aChkNoEmpty[ nLoop , 2 ] , 1 ] + ", "
			Next nLoop
			
			cEmptyString := Left( cEmptyString , Len( cEmptyString ) - 2 ) + "."

		EndIF

		If nModelo == 4

			IF ( lDuplic )
			
				cString += cCrLf + "Linha(s):  "

				For nLoop := 1 to Len( aLinhas )
					cString += AllTrim( Str( aLinhas[ nLoop ] ) ) + ", "
				Next nLoop

				cString := Left( cString, Len( cString ) - 2 ) + "."

			EndIF

			IF ( lEmpty )

				cEmptyString += cCrLf + "Linha(s):  " // 

				For nLoop := 1 To Len( aEmptys )
					cEmptyString += AllTrim( Str( aEmptys[ nLoop ] ) ) + ", "
				Next nLoop

				cEmptyString := Left( cEmptyString, Len( cEmptyString ) - 2 ) + "."

			EndIF
			
		EndIf

	EndIf

	//������������������������������������������������������������������������Ŀ
	//� Exibe a mensagem                                                       �
	//��������������������������������������������������������������������������
	IF ( ( lDuplic ) .and. ( lEmpty ) )
		cMsgAviso := cString
		cMsgAviso += cCrLf
		cMsgAviso += cCrLf
		cMsgAviso += cEmptyString
	ElseIF ( lDuplic )
		cMsgAviso := cString
	ElseIF ( lEmpty )
		cMsgAviso := cEmptyString
	EndIF
	IF ( lShowAviso )
		Aviso( "Atencao!", OemToAnsi( cMsgAviso ) , { "&Ok" }, 2 ) //  , 
	EndIF	

EndIf

Return( lRet )

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  12/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001LibAdm()

MATA440()

Return 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  12/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001CMG()           

Processa({|| ReproNF() })
	
Return	

Static Function ReproNF()
Local aAreaAtu	:=GetArea()
Local cPerg		:="M001CMG"
Local cQuery
Local cAliasQry	:=GetNextAlias()       
Local	dtVazio:=CTOD("  /  /  ")


PutSx1(cPerg,"01","Da Nota Fiscal                ","Da Nota Fiscal                ","Da Nota Fiscal                ","MV_CH1","C",9,0,0,"G","                                                            ","SF2   ","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Ate Nota Fiscal               ","Ate Nota Fiscal               ","Ate Nota Fiscal               ","MV_CH2","C",9,0,0,"G","                                                            ","SF2   ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"03","Da Serie                      ","Da Serie                      ","Da Serie                      ","MV_CH3","C",3,0,0,"G","                                                            ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Ate Serie                     ","Ate Serie                     ","Ate Serie                     ","MV_CH4","C",3,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"05","Da Emissao                    ","Da Emissao                    ","Da Emissao                    ","MV_CH5","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"06","Ate Emissao                   ","Ate Emissao                   ","Ate Emissao                   ","MV_CH6","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

If !Pergunte(cPerg)
	Return
EndIf


cQuery:=" Select SF2.R_E_C_N_O_ RecSF2 From "+RetSqlName("SF2")+" SF2"
cQuery+=" Where SF2.F2_FILIAL='"+xFilial("SF2")+"'"
cQuery+=" And F2_DOC BETWEEN '"+mv_par01+"' And '"+mv_par02+"'"    ///IN ('000127473')"//'000131129'
cQuery+=" And F2_SERIE BETWEEN '"+mv_par03+"' And '"+mv_par04+"'"    ///IN ('000127473')"//'000131129'
cQuery+=" And F2_EMISSAO BETWEEN '"+DTOS(mv_par05)+"' And '"+DTOS(mv_par06)+"'"
cQuery+=" And D_E_L_E_T_=' '"
cQuery+=" Order by F2_EMISSAO,F2_DOC"


DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry  ,.F.,.T.)

                  
ZF2->(DbSetOrder(1))//ZF2_FILIAL+ZF2_CLIENT+ZF2_LOJA+ZF2_DOC+ZF2_SERIE
ZD2->(DbSetOrder(1))//ZD2_FILIAL+ZD2_DOC+ZD2_SERIE+ZD2_CLIENT+ZD2_LOJA+ZD2_COD+ZD2_ITEM
Do While !(cAliasQry)->(Eof())

	SF2->(DbGoTo( (cAliasQry)->RecSF2))
	
	IncProc("Nota "+SF2->F2_DOC+" Emissao"+dtoc(SF2->F2_EMISSAO))
	
	Begin Transaction
	
	If ZF2->(DbSeek(SF2->(F2_FILIAL+F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE) ))
		ZF2->(RecLock("ZF2",.F.))
		ZF2->(DbDelete())
		ZF2->(MsUnLock())
	EndIf      
	
	ZD2->(DbSeek(SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA) ))
	Do While ZD2->(!Eof()) .And. ZD2->(ZD2_FILIAL+ZD2_DOC+ZD2_SERIE+ZD2_CLIENT+ZD2_LOJA)==SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
		ZD2->(RecLock("ZD2",.F.))
		ZD2->(DbDelete())
		ZD2->(MsUnLock())
		ZD2->(DbSkip())
	EndDo
		                     

	SF2->(RecLock("SF2",.F.))
	SF2->F2_YDTMARG:=dtVazio		  
	SF2->(MsUnLock())
   
	
	
	End Transaction
	
		
	(cAliasQry)->(DbSkip())
EndDo	


(cAliasQry)->(DbCloseArea())                          
MsgInfo("Notas processadas")
RestArea(aAreaAtu)
Return 
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  02/19/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001CPY()
Local aSays:={}
Local aButtons:={}
Local lOk:=.F.
Local cCadastro:="Copia Produto para outros sistemas"
Local cAviso	:=""

If !( SB1->B1_TIPO=="PA")
	cAviso+=IIf( !SB1->B1_TIPO=="PA","Produto n�o � Tipo 'PA'","")
	MsgStop( cAviso ,"NcGames")
Else

	AADD( aSays, "Copia Produto:"+AllTrim(SB1->B1_COD)+"-"+AllTrim(SB1->B1_DESC) )
	AADD( aSays, "")
	AADD( aSays, "para os sistemas UzGames,ProximoGames, CiaShop e WebManager." )

	AADD( aButtons, { 01, .T., {|| lOk := .T., FechaBatch() } } )
	AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
	;FormBatch( cCadastro, aSays, aButtons )
	
	If lOk
		Processa({|| GravaProd() } )
	EndIf

EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  02/22/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GravaProd()
Local cMensagem:=""
Local cAviso	:=""

cMensagem:=""
Processa( {|| U_NCVTEX01(@cMensagem)} ,"NcGames")
cAviso+="NcGames"+cMensagem+CRLF+Replicate("-",70)+CRLF

//Processa( {|| U_NCVTEX01(2,@cMensagem)} ,"ProximoGames")
//cAviso+="ProximoGames"+cMensagem+CRLF+Replicate("-",70)+CRLF

//Processa( {|| U_ECOM01PROD(@cMensagem)},"CiaShop")
//cAviso+="CiaShop"+cMensagem+CRLF+Replicate("-",70)+CRLF

Processa( {|| U_NCWEBM01(@cMensagem)},"WebManager")
cAviso+="WebManager:"+CRLF+cMensagem+CRLF+Replicate("-",70)+CRLF


Aviso("Copia Produto",cAviso,{"OK"},3)
Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGM001   �Autor  �Microsiga           � Data �  05/15/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M001VldEmis()
Return IIf(cFormul=="N".Or.IsInCallStack("U_NCIWML02"),.T.,IIf(dDEmissao<>MsDate(),(MsgStop("Data Emissao deve ser igual a "+DTOC(MsDate())),.F.),.T.))
