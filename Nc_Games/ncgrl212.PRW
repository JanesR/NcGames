#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "FIVEWIN.ch"
#INCLUDE "TBICONN.CH"

#Define Enter Chr(13)+Chr(10)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRL212  �Autor  �Microsiga           � Data �  05/18/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RL212Job(aDados)

Default aDados:={"01","03"}   

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])

Rl212Ped()
Rl212Item()
Rl212Est()
        
RpcClearEnv()
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRL212  �Autor  �Microsiga           � Data �  05/18/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Rl212Ped()

Local cPara		:= Alltrim(U_MyNewSX6("NCG_000079","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail para envio de arquivo CSV enext","","",.F. ))
Local cAssunto  := "Nc_Pedido_"+DtoC(MsDate())
Local cBody     := "Email gerado automaticamente"
Local cAttach   := ""

Local cQryPed 	:= ""
Local cAreaQry	:= GetNextAlias()

Local nTotLinhas:= 0
Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Local cArq 		:= "Nc_Ped_"+DtoS(MsDate())
Local cExtExcel	:= ".CSV"
Local dDtlimite := DtoS(MsDate()-30)
Local nArq

//Pedido-N�;Pedido-Data Captura;Pedido-Status;Pedido-Forma de pagto.;Pedido-Qtde.;Frete;Pedido-Frete;Desconto;Pedido-Total com frete;Cliente-E-Mail
Local cCabec	:= "Pedido;Data_pedido;Status_pedido;Forma_de_pagto;Qtde_pedido;Vlr_Frete;Vlr_pedido;Vlr_Desconto;Vlr_Total;Email"

Local nPedido	:= 0
Local dDataped	:= ""
Local cStatus	:= ""
Local cFormPag	:= ""
Local nQtdPed	:= 0
Local nVlrFrete	:= 0
Local nVlrPed	:= 0
Local nVlrDesc	:= 0
Local nVlrTotal	:= 0
Local cEmail	:= ""
Local cTexto	:= ""


nArq  := FCreate(cPathArq + cArq + cExtExcel)
FWrite(nArq,cCabec+ Enter)


cQryPed += " SELECT ZC5_NUM, "+CRLF
cQryPed += " 		SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) C5_EMISSAO, "+CRLF
cQryPed += "    		CASE "+CRLF
cQryPed += " 		  	WHEN ZC5_STATUS='10' THEN 'Pagamento Aprovado' "+CRLF
cQryPed += " 		 	WHEN ZC5_STATUS='4'  THEN 'Aguardando pagamento' "+CRLF
cQryPed += " 			WHEN ZC5_STATUS='16' THEN 'Faturado,Aguardando o envio' "+CRLF
cQryPed += " 		 	WHEN ZC5_STATUS='15' THEN 'Pedido Enviado' "+CRLF
cQryPed += " 			WHEN ZC5_STATUS='30' THEN 'Rastreamento enviado' "+CRLF
cQryPed += " 		 	WHEN ZC5_STATUS='90' THEN 'Cancelado' ELSE ZC5_STATUS END ZC5_STATUS, "+CRLF
cQryPed += " 		CASE "+CRLF
cQryPed += " 			WHEN ZC5_COND='BOL' THEN 'Boleto Banc�rio' "+CRLF
cQryPed += " 			WHEN ZC5_COND='CC' 	THEN 'Cart�o de Cr�dito' "+CRLF
cQryPed += " 			ELSE ZC5_COND END ZC5_COND, "+CRLF
cQryPed += " 		1 QTD_PED, "+CRLF
cQryPed += " 		ZC5_FRETE AS FRETE, "+CRLF
cQryPed += " 		ZC5_TOTAL-ZC5_FRETE AS PED_FRETE, "+CRLF
cQryPed += " 		ZC5_VDESCO AS DESCONTO, "+CRLF
cQryPed += " 		ZC5_TOTAL AS TOTAL, "+CRLF
cQryPed += " 		UPPER(A1_EMAIL) AS EMAIL "+CRLF
cQryPed += " FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQryPed += " 	INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQryPed += " 		ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQryPed += " 		AND SA1.A1_FILIAL = '"+ xFilial("SA1") +"' "+CRLF
cQryPed += " 		AND SA1.A1_COD = ZC5.ZC5_CLIENT "+CRLF
cQryPed += " 		AND SA1.A1_LOJA = ZC5.ZC5_LOJA "+CRLF
cQryPed += " 	INNER JOIN "+RetSqlName("SC5")+" SC5 "+CRLF
cQryPed += " 		ON SC5.C5_FILIAL = '"+ xFilial("SC5") +"' "+CRLF
cQryPed += " 		AND SC5.D_E_L_E_T_ = ' ' "+CRLF
cQryPed += " 		AND SC5.C5_NUM = ZC5.ZC5_NUMPV "+CRLF
cQryPed += " WHERE ZC5.ZC5_FILIAL = '"+ xFilial("ZC5") +"' "+CRLF
cQryPed += " AND ZC5.D_E_L_E_T_ =' ' "+CRLF
cQryPed += " AND ZC5.ZC5_ESTORN = ' ' "+CRLF
cQryPed += " AND ZC5.ZC5_STATUS NOT IN ('91','92') "+CRLF
cQryPed += " AND ZC5.ZC5_NUM <> 0 "+CRLF
cQryPed += " AND ZC5.ZC5_NUM > 1000 "+CRLF
cQryPed += " AND SC5.C5_EMISSAO >= '"+dDtlimite+"' "+CRLF

cQryPed := ChangeQuery(cQryPed)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryPed),cAreaQry, .F., .F.)

While !(cAreaQry)->(EOF())
	++ nTotLinhas
	
	nPedido		:= STR((cAreaQry)->ZC5_NUM)
	dDataped	:= (cAreaQry)->C5_EMISSAO
	cStatus		:= (cAreaQry)->ZC5_STATUS
	cFormPag	:= (cAreaQry)->ZC5_COND
	nQtdPed		:= STR((cAreaQry)->QTD_PED)
	nVlrFrete	:= STR((cAreaQry)->FRETE)
	nVlrPed		:= STR((cAreaQry)->PED_FRETE)
	nVlrDesc	:= STR((cAreaQry)->DESCONTO)
	nVlrTotal	:= STR((cAreaQry)->TOTAL)
	cEmail		:= (cAreaQry)->EMAIL
	
	cTexto	:= nPedido+";"+dDataped+";"+cStatus+";"+cFormPag+";"+nQtdPed+";"+nVlrFrete+";"+nVlrPed+";"+nVlrDesc+";"+nVlrTotal+";"+cEmail
	
	FWrite(nArq, cTexto +Enter)
	
	(cAreaQry)->(DbSkip())
	
EndDo

FClose(nArq)
cAttach:=cPathArq+cArq+cExtExcel

Rl212Send(,cPara,cAssunto,cBody,cAttach)

Ferase(cPathArq+cArq+cExtExcel)

(cAreaQry)->(DbCloseArea())

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRL212  �Autor  �Microsiga           � Data �  05/18/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Rl212Item()

Local cPara		:= Alltrim(U_MyNewSX6("NCG_000079","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail para envio de arquivo CSV enext","","",.F. ))
Local cAssunto  := "Nc_Itens_"+DtoC(MsDate())
Local cBody     := "Email gerado automaticamente"
Local cAttach   := ""

Local cQryI 	:= ""
Local cAreaQry	:= GetNextAlias()

Local nTotLinhas:= 0
Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Local cArq 		:= "Nc_Itens_"+DtoS(MsDate())
Local cExtExcel	:= ".CSV"
Local dDtlimite := DtoS(MsDate()-30)
Local nArq

//Departamento;Qtde_Pedida;Pre�o;Marca;Categoria;Cliente;Email;Cod_Prod_Pai;Nome_Prod_Pai
Local cCabec	:= "Pedido;DataPedido;Status;CodProdFilho;NomeProdFilho;Departamento;QtdePedida;Pre�o;Marca;Categoria;Cliente;Email;CodProdPai;NomeProdPai"

Local nPedido 	:= 0
Local dDataped	:= ""
Local cStatus	:= ""
Local cDepart	:= ""
Local nQtdPed 	:= 0
Local nPrcVen 	:= 0
Local cMarca	:= ""
Local cCateg	:= ""
Local cClient	:= ""
Local cEmail	:= ""
Local cCodPai	:= ""
Local cDescPai	:= ""

cAttach := cPathArq + cArq + cExtExcel

nArq  := FCreate(cPathArq + cArq + cExtExcel)
FWrite(nArq,cCabec+ Enter)

cQryI := ""
cQryI += " SELECT ZC5_NUM, "+CRLF
cQryI += " 		SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) C5_EMISSAO, "+CRLF
cQryI += "    		CASE "+CRLF
cQryI += " 		  	WHEN ZC5_STATUS='10' THEN 'Pagamento Aprovado' "+CRLF
cQryI += " 		 	WHEN ZC5_STATUS='4'  THEN 'Aguardando pagamento' "+CRLF
cQryI += " 			WHEN ZC5_STATUS='16' THEN 'Faturado,Aguardando o envio' "+CRLF
cQryI += "		 	WHEN ZC5_STATUS='15' THEN 'Pedido Enviado' "+CRLF
cQryI += "			WHEN ZC5_STATUS='30' THEN 'Rastreamento enviado' "+CRLF
cQryI += "		 	WHEN ZC5_STATUS='90' THEN 'Cancelado' ELSE ZC5_STATUS END ZC5_STATUS, "+CRLF
cQryI += "		SC6.C6_PRODUTO AS PRODUTO, "+CRLF
cQryI += "		SC6.C6_DESCRI AS DESCRICAO, "+CRLF
cQryI += "		ZC6.ZC6_QTDVEN QTDVEN, "+CRLF
cQryI += "		ZC6.ZC6_VLRUNI VLRUNI, "+CRLF
cQryI += "		SB1.B1_PLATEXT AS DEPARTAMENTO, "+CRLF
cQryI += "		SB1.B1_PUBLISH AS MARCA, "+CRLF
cQryI += "		SA1.A1_NREDUZ AS NOMECLI, "+CRLF
cQryI += "		UPPER(A1_EMAIL) AS EMAIL "+CRLF
cQryI += " FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
cQryI += " 	INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQryI += "		ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQryI += "		AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQryI += "		AND SA1.A1_COD = ZC5.ZC5_CLIENT "+CRLF
cQryI += "		AND SA1.A1_LOJA = ZC5.ZC5_LOJA "+CRLF
cQryI += "	INNER JOIN "+RetSqlName("SC5")+" SC5 "+CRLF
cQryI += "		ON SC5.C5_FILIAL = '"+ xFilial("SC5") +"' "+CRLF
cQryI += "		AND SC5.D_E_L_E_T_ = ' ' "+CRLF
cQryI += "		AND SC5.C5_NUM = ZC5.ZC5_NUMPV "+CRLF
cQryI += "	LEFT OUTER JOIN "+RetSqlName("SC6")+" SC6 "+CRLF
cQryI += "		ON SC6.C6_FILIAL = '"+ xFilial("SC6") +"' "+CRLF
cQryI += "		AND SC6.D_E_L_E_T_ = ' ' "+CRLF
cQryI += "		AND SC6.C6_NUM = ZC5.ZC5_NUMPV "+CRLF
cQryI += "	LEFT OUTER JOIN "+RetSqlName("ZC6")+" ZC6 "+CRLF
cQryI += "		ON ZC6.ZC6_FILIAL = '"+ xFilial("ZC6") +"' "+CRLF
cQryI += "		AND ZC6.ZC6_NUM = ZC5.ZC5_NUM "+CRLF
cQryI += "		AND ZC6.ZC6_PRODUT = SC6.C6_PRODUTO "+CRLF
cQryI += "	LEFT OUTER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQryI += "		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQryI += "		AND SB1.B1_COD = SC6.C6_PRODUTO "+CRLF
cQryI += "		AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
cQryI += " WHERE ZC5.ZC5_FILIAL = '"+ xFilial("ZC5") +"' "+CRLF
cQryI += " AND ZC5.D_E_L_E_T_ = ' ' "+CRLF
cQryI += " AND ZC5.ZC5_ESTORN = ' ' "+CRLF
cQryI += " AND ZC5.ZC5_STATUS NOT IN ('91','92') "+CRLF
cQryI += " AND ZC5.ZC5_NUM <> 0 "+CRLF
cQryI += " AND ZC5.ZC5_NUM > 1000 "+CRLF
cQryI += " AND SC5.C5_EMISSAO >= '"+dDtlimite+"' "+CRLF

cQryI := ChangeQuery(cQryI)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryI),cAreaQry, .F., .F.)

While !(cAreaQry)->(EOF())
	++ nTotLinhas
	
	nPedido 	:= STR((cAreaQry)->ZC5_NUM)
	dDataped	:= (cAreaQry)->C5_EMISSAO
	cStatus		:= (cAreaQry)->ZC5_STATUS
	cCodProd	:= (cAreaQry)->PRODUTO
	cDescProd	:= (cAreaQry)->DESCRICAO
	cDepart		:= (cAreaQry)->DEPARTAMENTO
	nQtdPed 	:= STR((cAreaQry)->QTDVEN)
	nPrcVen 	:= STR((cAreaQry)->VLRUNI)
	cMarca		:= (cAreaQry)->MARCA
	cCateg		:= (cAreaQry)->DEPARTAMENTO
	cClient		:= (cAreaQry)->NOMECLI
	cEmail		:= (cAreaQry)->EMAIL
	
	//Pedido;DataPedido;Status;CodProdFilho;NomeProdFilho;Departamento;QtdePedida;Pre�o;Marca;Categoria;Cliente;Email;CodProdPai;NomeProdPai
	cTexto	:= nPedido+";"+dDataped+";"+cStatus+";"+cCodProd+";"+cDescProd+";"+cDepart+";"+nQtdPed+";"+nPrcVen+";"+cMarca+";"+cCateg+";"+cClient+";"+cEmail+";"+cCodProd+";"+cDescProd
	
	FWrite(nArq, cTexto +Enter)
	
	(cAreaQry)->(DbSkip())
	
EndDo

FClose(nArq)

Rl212Send(,cPara,cAssunto,cBody,cAttach)

Ferase(cPathArq+cArq+cExtExcel)

(cAreaQry)->(DbCloseArea())

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRL212  �Autor  �Microsiga           � Data �  05/18/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Rl212Est()

Local cPara		:= Alltrim(U_MyNewSX6("NCG_000079","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail para envio de arquivo CSV enext","","",.F. ))
Local cAssunto  := "Nc_Estoque_"+DtoC(MsDate())
Local cBody     := "Email gerado automaticamente"
Local cAttach   := ""

Local cQryE 	:= ""
Local cAreaQry	:= GetNextAlias()

Local nTotLinhas:= 0
Local cPathArq	:= StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Local cArq 		:= "Nc_Estoque_"+DtoS(MsDate())
Local cExtExcel	:= ".CSV"
Local nArq

//CodProdFilho;NomeProdFilho;Marca;Departamento;Categoria;QtdeDispPrven;Custototal;CodProdPai;NomeProdPai
Local cCabec	:= "CodProdFilho;NomeProdFilho;Marca;Departamento;Categoria;QtdeDisp;Prven;CustoTotal;CodProdPai;NomeProdPai"

Local cCodProd	:= ""
Local cDescProd	:= ""
Local cDepart	:= ""
Local cMarca	:= ""
Local cCateg	:= ""
Local nQtdDisp 	:= 0
Local nPrcVen 	:= 0
Local nCmvTot	:= 0

Local cArmPad	:= SuperGetMv("MV_CIAESTO",,"01")

cAttach := cPathArq + cArq + cExtExcel

nArq  := FCreate(cPathArq + cArq + cExtExcel)
FWrite(nArq,cCabec+ Enter)

cQryE := ""
cQryE +=" SELECT SB1.B1_COD PRODUTO, "+CRLF 
cQryE +="  		SB1.B1_XDESC DESCRICAO, "+CRLF
cQryE +=" 		SB1.B1_PLATEXT AS DEPARTAMENTO, "+CRLF
cQryE +="		SB1.B1_PUBLISH AS MARCA, "+CRLF
cQryE +=" 		B2_QATU-B2_RESERVA-B2_QEMP AS SALDO,  "+CRLF
cQryE +=" 		SB1.B1_CONSUMI VLRUNI, "+CRLF 
cQryE +=" 		ZC3.ZC3_STATUS, "+CRLF
cQryE +=" 		SB1.B1_MSBLQL, "+CRLF
cQryE +=" 		SB2.B2_VATU1 AS CMVTOTAL  "+CRLF
cQryE +=" FROM "+RetSqlName("ZC3")+" ZC3 "+CRLF
cQryE +=" 		LEFT OUTER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQryE +=" 		ON SB1.B1_COD = ZC3.ZC3_CODPRO "+CRLF
cQryE +=" 		AND SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQryE +="	 	AND SB1.D_E_L_E_T_ = ' ' "+CRLF
cQryE +=" 	LEFT OUTER JOIN "+RetSqlName("SB2")+" SB2 "+CRLF
cQryE +=" 		ON SB2.B2_COD = ZC3.ZC3_CODPRO "+CRLF
cQryE +=" 		AND SB2.B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
cQryE +=" 		AND SB2.B2_LOCAL = '"+ cArmPad +"' "+CRLF
cQryE +=" 		AND SB2.D_E_L_E_T_ = ' ' "+CRLF
cQryE +=" WHERE ZC3.D_E_L_E_T_ = ' ' "+CRLF

cQryE := ChangeQuery(cQryE)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryE),cAreaQry, .F., .F.)

While !(cAreaQry)->(EOF())
	++ nTotLinhas
	
	cCodProd	:= (cAreaQry)->PRODUTO
	cDescProd	:= (cAreaQry)->DESCRICAO
	cDepart		:= (cAreaQry)->DEPARTAMENTO
	cMarca		:= (cAreaQry)->MARCA
	cCateg		:= (cAreaQry)->DEPARTAMENTO
	nQtdDisp 	:= STR(Iif((cAreaQry)->B1_MSBLQL=="2",Iif((cAreaQry)->ZC3_STATUS!="02",(cAreaQry)->SALDO,0),0))
	nPrcVen 	:= STR((cAreaQry)->VLRUNI)
	nCmvTot		:= STR((cAreaQry)->CMVTOTAL)
	
	//CodProdFilho;NomeProdFilho;Marca;Departamento;Categoria;QtdeDisp;Prven;CustoTotal;CodProdPai;NomeProdPaii
	cTexto	:= cCodProd+";"+cDescProd+";"+cMarca+";"+cDepart+";"+cCateg+";"+nQtdDisp+";"+nPrcVen+";"+nCmvTot+";"+cCodProd+";"+cDescProd
	
	FWrite(nArq, cTexto +Enter)
	
	(cAreaQry)->(DbSkip())
	
EndDo

FClose(nArq)

Rl212Send(,cPara,cAssunto,cBody,cAttach)

Ferase(cPathArq+cArq+cExtExcel)

(cAreaQry)->(DbCloseArea())

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRL212  �Autor  �Microsiga           � Data �  05/18/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Rl212Send(cFrom,cPara,cAssunto,cBody,cAttach)

Local cUser 	:= GetNewPar("MV_RELACNT","")
Local cPass 	:= GetNewPar("MV_RELAPSW","")
Local cSendSrv 	:= GetNewPar("MV_RELSERV","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Local nSmtpPort := GetNewPar("MV_GCPPORT","")
Local nPopPort
Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)

Local xRet
Local oServer, oMessage

Local cFrom1 	:= "Workflow@ncgames.com.br"

Default cPara 	:= "lfelipe@ncgames.com.br"
Default cAssunto:= ""
Default cBody 	:= ""

If At(":",cSendSrv) > 0
	cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
EndIf

cFrom := IIf(Empty(cFrom),cFrom1,cFrom)

oServer := TMailManager():New()
oServer:SetUseSSL( lSSL ) //ADD 26/05/2015 -- configura��o de gmail
oServer:SetUseTLS(lTLS ) //ADD 23/06/2016 -- configura��o de gmail
oServer:Init( "", cSendSrv, cUser, cPass, /*nPopPort*/, nSmtpPort )

// estabilish the connection with the SMTP server
xRet := oServer:SMTPConnect()
if xRet <> 0
	cMsg := "Could not connect on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	return
endif

// authenticate on the SMTP server (if needed)
xRet := oServer:SmtpAuth( cUser, cPass )
if xRet <> 0
	cMsg := "Could not authenticate on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	oServer:SMTPDisconnect()
	return
endif

oMessage := TMailMessage():New()
oMessage:Clear()

//oMessage:cDate := cValToChar( Date() )
oMessage:cFrom		:= cFrom
oMessage:cTo		:= cPara
oMessage:cSubject	:= cAssunto
oMessage:cBody		:= cBody
If !Empty(cAttach)
	oMessage:AttachFile( cAttach ) // Adiciona um anexo.
EndIf

xRet := oMessage:Send( oServer )
if xRet <> 0
	cMsg := "Could not send message: " + oServer:GetErrorString( xRet )
	conout( cMsg )
endif

xRet := oServer:SMTPDisconnect()
if xRet <> 0
	cMsg := "Could not disconnect from SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
endif

return
