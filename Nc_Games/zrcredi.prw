#INCLUDE "rwmake.CH"
#INCLUDE "TOTVS.CH"
#Include "topconn.Ch"
#Include "tbiconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ZRCREDI   �Autor  �Microsiga           � Data �  03/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function ZRCJob(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])//Empresa 01 Filial Barueri

Conout("Execucao ZRCJob em "+DTOC(MsDate())+" as "+Time())

U_ZRCredi()

Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ZRCREDI   �Autor  �Lucas Oliveira      � Data �  25/04/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Relat�rio desenvolvido pensando em atender a equipe do      ���
��� financeiro que necessita de um historico de todos os pedidos liberados���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ZRCredi()

Local oReport
Local lAuto := IsInCallStack("U_ZRCJob")

If !lAuto
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	ReportPrint(Nil,Nil,lAuto,2)//Envia por e-mail
EndIf
Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ZRCREDI   �Autor  �Microsiga           � Data �  03/12/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ReportDef()


Local oReport
Local oNoAtend
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario

oReport := TReport():New("ZRCredi","Aprovado e Bloqueados em Credito","ZRCredi", {|oReport| ReportPrint(oReport,oNoAtend)},"")

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
AjustaSx1()
Pergunte(oReport:uParam,.T.)

oNoAtend := TRSection():New(oReport,"ZRCredito",{"SZR","SA1","SC9","SC6"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNoAtend:SetTotalInLine(.F.)

//TRCell():New(oNoAtend,"CODPRO"		,"cArqTRB",RetTitle("ZD_CODPRO"),PesqPict("SZD","ZD_CODPRO")	,TamSx3("ZD_CODPRO")  	[1]	,/*lPixel*/,/*{|| cVend }*/	)// "Codigo do Cliente"
TRCell():New(oNoAtend,"TIPO"			,"cArqTRB","Tipo"			 		,"@!"									,9							,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"PEDIDO"		,"cArqTRB","Pedido"			 	,PesqPict("SC6","C6_NUM")		,TamSx3("C6_NUM")  		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"EMISSAO"		,"cArqTRB","Emissao"		 		,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CLIENTE"		,"cArqTRB","Cliente"		 		,PesqPict("SC6","C6_CLI")		,TamSx3("C6_CLI")  		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CPFCNPJ"  	,"cArqTRB","CPF/CNPJ"		 	,PesqPict("SA1","A1_CGC")		,TamSx3("A1_CGC")  		[1] ,/*lPixel*/,/*{|| cVend }*/ )//
TRCell():New(oNoAtend,"LOJA"			,"cArqTRB","Loja"			 		,PesqPict("SC6","C6_LOJA")		,TamSx3("C6_LOJA")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"N_FANTASIA"	,"cArqTRB","Nome_Fantasia"	 	,PesqPict("SA1","A1_NREDUZ")  ,TamSx3("A1_NREDUZ")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"CANAL"			,"cArqTRB","Canal"	 			,PesqPict("SA1","A1_YDCANAL")  ,TamSx3("A1_YDCANAL")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"YLEGEND"		,"cArqTRB","Motivo Credito"	,PesqPict("SA1","A1_YLEGEND")	,TamSx3("A1_YLEGEND")	[1] ,/*lPixel*/,/*{|| cVend }*/ ) //
TRCell():New(oNoAtend,"MOTIVO"   	,"cArqTRB","Motivo Rejei��o" 	,PesqPict("SZR","ZR_TEXTO")	,TamSx3("ZR_TEXTO")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"VALOR_MERC"	,"cArqTRB","Valor Mercadoria"	,,15							,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"Datalib"		,"cArqTRB","Data Liberacao"	,PesqPict("SC9","C9_DATALIB")	,TamSx3("C9_DATALIB")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"USUARIO"		,"cArqTRB","Usuario"		 		,PesqPict("SC9","C9_ULIBCRD")	,TamSx3("C9_ULIBCRD")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"DATACR"		,"cArqTRB","Data Credito"    	,PesqPict("SZR","ZR_DTOCORR")	,TamSx3("ZR_DTOCORR")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"HORA"			,"cArqTRB","Hora"			 		,PesqPict("SFT","FT_LOJA")		,TamSx3("FT_LOJA")		[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"COD_VEND"		,"cArqTRB","COD_VEND"    	,PesqPict("SA3","A3_COD")	,TamSx3("A3_COD")	[1] ,/*lPixel*/,/*{|| cVend }*/ )
TRCell():New(oNoAtend,"NOME_VEND"			,"cArqTRB","NOME_VEND"			 		,PesqPict("SA3","A3_NOME")		,TamSx3("A3_NOME")		[1] ,/*lPixel*/,/*{|| cVend }*/ )

// Alinhamento das colunas de valor a direita
oNoAtend:Cell("VALOR_MERC"):SetHeaderAlign("RIGHT")

Return(oReport)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrin� Autor �Marco Bianchi          � Data � 26/06/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpO1: Objeto Report do Relat�rio                           ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
��� 25/04/13 � Lucas Oliveira�Altera��o para criar relat�rio ZRCredito    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ReportPrint(oReport,oNoAtend,lAuto,nOpc)

If lAuto
	
	mv_par01 := MsDate()//StoD("20130101")
	mv_par02 := MsDate()
	//mv_par03 := nOpc retirado por Rogerio, solicitacao de Terezinha
	
EndIf

/*
If mv_par03 == 1 //retirado por Rogerio, solicitacao de Terezinha
	
	cQry := ""
	cQry += CRLF+"SELECT 'REJEITADO' AS TIPO,
	cQry += CRLF+"		 ZR_PEDIDO PEDIDO,
	cQry += CRLF+"		 ZR_CLIENTE CLIENTE,
	cQry += CRLF+"		 A1_CGC CPFCNPJ,
	cQry += CRLF+"		 ZR_LOJA LOJA,
	cQry += CRLF+"		 A1_NREDUZ N_FANTASIA,
	cQry += CRLF+"		 A1_YDCANAL CANAL,
	cQry += CRLF+"		 SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) EMISSAO,
	cQry += CRLF+"		 A1_YLEGEND YLEGEND ,
	cQry += CRLF+"		 ZR_TEXTO MOTIVO,
	cQry += CRLF+"		 sum(SC6.C6_QTDVEN * SC6.C6_PRCVEN)Valor_Merc,
	cQry += CRLF+"		 SUBSTR(C5_DTLIB,7,2)||'/'||SUBSTR(C5_DTLIB,5,2)||'/'||SUBSTR(C5_DTLIB,1,4) Datalib,
	cQry += CRLF+"		 ZR_USER Usuario,
	cQry += CRLF+"		 SUBSTR(ZR_DTOCORR,7,2)||'/'||SUBSTR(ZR_DTOCORR,5,2)||'/'||SUBSTR(ZR_DTOCORR,1,4) DATACR,
	cQry += CRLF+"		 SUBSTR(ZR_HORA,1,5) hora
	cQry += CRLF+"FROM "+RetSQLName("SZR")+" SZR
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SA1")+" SA1
	cQry += CRLF+"		ON SZR.ZR_CLIENTE = SA1.A1_COD
	cQry += CRLF+"		AND SZR.ZR_LOJA = SA1.A1_LOJA
	cQry += CRLF+"		AND SA1.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC6")+" SC6
	cQry += CRLF+"		ON SC6.C6_FILIAL = '"+xFilial("SC6")+"'
	cQry += CRLF+"		AND SZR.ZR_PEDIDO = SC6.C6_NUM
	cQry += CRLF+"		AND SZR.ZR_CLIENTE = SC6.C6_CLI
	cQry += CRLF+"		AND SZR.ZR_LOJA = SC6.C6_LOJA
	cQry += CRLF+"		AND SC6.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC5")+" SC5
	cQry += CRLF+"		ON SC5.C5_FILIAL = '"+xFilial("SC5")+"'
	cQry += CRLF+"		AND SZR.ZR_PEDIDO = SC5.C5_NUM
	cQry += CRLF+"		AND SZR.ZR_CLIENTE = SC5.C5_CLIENTE
	cQry += CRLF+"		AND SZR.ZR_LOJA = SC5.C5_LOJACLI
	cQry += CRLF+"		AND SC5.D_E_L_E_T_ = ' '
	cQry += CRLF+"WHERE SZR.ZR_DTOCORR BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'
	cQry += CRLF+"GROUP BY ZR_PEDIDO, ZR_CLIENTE,A1_CGC ,ZR_LOJA, A1_NREDUZ, A1_YDCANAL,A1_YLEGEND,ZR_TEXTO, C5_EMISSAO, ZR_DTOCORR, ZR_HORA, ZR_USER, C5_DTLIB
	cQry += CRLF+"UNION
	cQry += CRLF+"SELECT 'APROVADO' AS TIPO,
	cQry += CRLF+"			C9_PEDIDO PEDIDO,
	cQry += CRLF+"			C9_CLIENTE CLIENTE,
	cQry += CRLF+"	   	A1_CGC CPFCNPJ,
	cQry += CRLF+"			C9_LOJA LOJA,
	cQry += CRLF+"			A1_NREDUZ N_FANTASIA,
	cQry += CRLF+"		 A1_YDCANAL CANAL,
	cQry += CRLF+"			SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) EMISSAO,
	cQry += CRLF+"			A1_YLEGEND YLEGEND,
	cQry += CRLF+"		    ' ' MOTIVO,
	cQry += CRLF+"			sum(sc9.C9_QTDLIB * sc9.C9_PRCVEN) AS Valor_Merc,
	cQry += CRLF+"			SUBSTR(C9_DATALIB,7,2)||'/'||SUBSTR(C9_DATALIB,5,2)||'/'||SUBSTR(C9_DATALIB,1,4) Datalib,
	cQry += CRLF+"			MAX(CASE WHEN SC9.C9_BLCRED = '09' THEN 'REJEITADO'
	cQry += CRLF+"						WHEN C9_ULIBCRD <> ' ' THEN C9_ULIBCRD ELSE 'Automatico' END) Usuario,
	cQry += CRLF+"			MAX(CASE WHEN C9_DTLICRD <> ' ' THEN SUBSTR(C9_DTLICRD,7,2)||'/'||SUBSTR(C9_DTLICRD,5,2)||'/'||SUBSTR(C9_DTLICRD,1,4)
	cQry += CRLF+"			ELSE SUBSTR(C9_DATALIB,7,2)||'/'||SUBSTR(C9_DATALIB,5,2)||'/'||SUBSTR(C9_DATALIB,1,4) END) DATACR,
	cQry += CRLF+"			' ' HORA
	cQry += CRLF+"FROM "+RetSQLName("SC9")+" SC9
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SA1")+" SA1
	cQry += CRLF+"		ON SC9.C9_CLIENTE = SA1.A1_COD
	cQry += CRLF+"		AND SC9.C9_LOJA = SA1.A1_LOJA
	cQry += CRLF+"		AND SA1.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC5")+" SC5
	cQry += CRLF+"		ON SC5.C5_FILIAL = '"+xFilial("SC5")+"'
	cQry += CRLF+"		AND SC9.C9_PEDIDO = SC5.C5_NUM
	cQry += CRLF+"		AND SC9.C9_CLIENTE = SC5.C5_CLIENTE
	cQry += CRLF+"		AND SC9.C9_LOJA = SC5.C5_LOJACLI
	cQry += CRLF+"		AND SC5.D_E_L_E_T_ = ' '
	cQry += CRLF+"WHERE SC9.D_E_L_E_T_ = ' '
	cQry += CRLF+" 	AND SC9.C9_FILIAL = '"+xFilial("SC9")+"'
	cQry += CRLF+"		AND SC9.C9_DATALIB BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'
	cQry += CRLF+"		AND SC9.C9_DTLICRD <> ' '
	cQry += CRLF+"		AND SC9.C9_BLCRED = '10'
	//	cQry += CRLF+"		AND SC9.C9_BLCRED = '09'
	cQry += CRLF+"GROUP BY C9_PEDIDO,C9_CLIENTE, A1_CGC ,C9_LOJA, A1_NREDUZ,A1_YDCANAL, C5_EMISSAO, C9_DTLICRD, C9_DATALIB, A1_YLEGEND
	cQry += CRLF+"ORDER BY PEDIDO
*/	
//Else retirado por Rogerio, solicitacao de Terezinha, considera todos os pedidos, tanto em relatorio quanto em work flow
	cQry := ""
	cQry += CRLF+"SELECT 'REJEITADO' AS TIPO,
	cQry += CRLF+"		 ZR_PEDIDO PEDIDO,
	cQry += CRLF+"		 ZR_CLIENTE CLIENTE,
	cQry += CRLF+"		 A1_CGC CPFCNPJ,
	cQry += CRLF+"		 ZR_LOJA LOJA,
	cQry += CRLF+"		 A1_NREDUZ N_FANTASIA,
	cQry += CRLF+"		 A1_YDCANAL CANAL,
	cQry += CRLF+"		 SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) EMISSAO,
	cQry += CRLF+"		 A1_YLEGEND YLEGEND ,
	cQry += CRLF+"		 ZR_TEXTO MOTIVO,
	cQry += CRLF+"		 sum(SC6.C6_QTDVEN * SC6.C6_PRCVEN)Valor_Merc,
	cQry += CRLF+"		 SUBSTR(C5_DTLIB,7,2)||'/'||SUBSTR(C5_DTLIB,5,2)||'/'||SUBSTR(C5_DTLIB,1,4) Datalib,
	cQry += CRLF+"		 ZR_USER Usuario,
	cQry += CRLF+"		 SUBSTR(ZR_DTOCORR,7,2)||'/'||SUBSTR(ZR_DTOCORR,5,2)||'/'||SUBSTR(ZR_DTOCORR,1,4) DATACR,
	cQry += CRLF+"		 SUBSTR(ZR_HORA,1,5) hora,
	cQry += CRLF+"		 SA3.A3_COD COD_VEND,
	cQry += CRLF+"		 SA3.A3_NOME NOME_VEND
	cQry += CRLF+"FROM "+RetSQLName("SZR")+" SZR
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SA1")+" SA1
	cQry += CRLF+"		ON SZR.ZR_CLIENTE = SA1.A1_COD
	cQry += CRLF+"		AND SZR.ZR_LOJA = SA1.A1_LOJA
	cQry += CRLF+"		AND SA1.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC6")+" SC6
	cQry += CRLF+"		ON SC6.C6_FILIAL = '"+xFilial("SC6")+"'
	cQry += CRLF+"		AND SZR.ZR_PEDIDO = SC6.C6_NUM
	cQry += CRLF+"		AND SZR.ZR_CLIENTE = SC6.C6_CLI
	cQry += CRLF+"		AND SZR.ZR_LOJA = SC6.C6_LOJA
	cQry += CRLF+"		AND SC6.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC5")+" SC5
	cQry += CRLF+"		ON SC5.C5_FILIAL = '"+xFilial("SC5")+"'
	cQry += CRLF+"		AND SZR.ZR_PEDIDO = SC5.C5_NUM
	cQry += CRLF+"		AND SZR.ZR_CLIENTE = SC5.C5_CLIENTE
	cQry += CRLF+"		AND SZR.ZR_LOJA = SC5.C5_LOJACLI
	cQry += CRLF+"		AND SC5.D_E_L_E_T_ = ' '
	cQry += CRLF+"		 LEFT JOIN "+RetSQLName("SA3")+" SA3
	cQry += CRLF+"		 ON SA1.A1_VEND = SA3.A3_COD
	cQry += CRLF+"WHERE SZR.ZR_DTOCORR BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'
	cQry += CRLF+"GROUP BY ZR_PEDIDO, ZR_CLIENTE,A1_CGC ,ZR_LOJA, A1_NREDUZ, A1_YDCANAL,A1_YLEGEND,ZR_TEXTO, C5_EMISSAO, ZR_DTOCORR, ZR_HORA, ZR_USER, C5_DTLIB, SA3.A3_COD,SA3.A3_NOME
	cQry += CRLF+"UNION
	cQry += CRLF+"SELECT 'APROVADO' AS TIPO,
	cQry += CRLF+"			C9_PEDIDO PEDIDO,
	cQry += CRLF+"			C9_CLIENTE CLIENTE,
	cQry += CRLF+"	   	A1_CGC CPFCNPJ,
	cQry += CRLF+"			C9_LOJA LOJA,
	cQry += CRLF+"			A1_NREDUZ N_FANTASIA,
	cQry += CRLF+"		 A1_YDCANAL CANAL,
	cQry += CRLF+"			SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) EMISSAO,
	cQry += CRLF+"			A1_YLEGEND YLEGEND,
	cQry += CRLF+"		    ' ' MOTIVO,
	cQry += CRLF+"			sum(sc9.C9_QTDLIB * sc9.C9_PRCVEN) AS Valor_Merc,
	cQry += CRLF+"			SUBSTR(C9_DATALIB,7,2)||'/'||SUBSTR(C9_DATALIB,5,2)||'/'||SUBSTR(C9_DATALIB,1,4) Datalib,
	cQry += CRLF+"			MAX(CASE WHEN SC9.C9_BLCRED = '09' THEN 'REJEITADO'
	cQry += CRLF+"						WHEN C9_ULIBCRD <> ' ' THEN C9_ULIBCRD ELSE 'Automatico' END) Usuario,
	cQry += CRLF+"			MAX(CASE WHEN C9_DTLICRD <> ' ' THEN SUBSTR(C9_DTLICRD,7,2)||'/'||SUBSTR(C9_DTLICRD,5,2)||'/'||SUBSTR(C9_DTLICRD,1,4)
	cQry += CRLF+"			ELSE SUBSTR(C9_DATALIB,7,2)||'/'||SUBSTR(C9_DATALIB,5,2)||'/'||SUBSTR(C9_DATALIB,1,4) END) DATACR,
	cQry += CRLF+"			' ' HORA,
	cQry += CRLF+"		 	SA3.A3_COD COD_VEND,
	cQry += CRLF+"		    SA3.A3_NOME NOME_VEND
	cQry += CRLF+"FROM "+RetSQLName("SC9")+" SC9
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SA1")+" SA1
	cQry += CRLF+"		ON SC9.C9_CLIENTE = SA1.A1_COD
	cQry += CRLF+"		AND SC9.C9_LOJA = SA1.A1_LOJA
	cQry += CRLF+"		AND SA1.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC5")+" SC5
	cQry += CRLF+"		ON SC5.C5_FILIAL = '"+xFilial("SC5")+"'
	cQry += CRLF+"		AND SC9.C9_PEDIDO = SC5.C5_NUM
	cQry += CRLF+"		AND SC9.C9_CLIENTE = SC5.C5_CLIENTE
	cQry += CRLF+"		AND SC9.C9_LOJA = SC5.C5_LOJACLI
	cQry += CRLF+"		AND SC5.D_E_L_E_T_ = ' '
	cQry += CRLF+"	LEFT JOIN "+RetSQLName("SA3")+" SA3
	cQry += CRLF+"		ON SA1.A1_VEND = SA3.A3_COD
	cQry += CRLF+"WHERE SC9.D_E_L_E_T_ = ' '
	cQry += CRLF+" 	AND SC9.C9_FILIAL = '"+xFilial("SC9")+"'
	cQry += CRLF+"		AND SC9.C9_DATALIB BETWEEN '"+Dtos(mv_par01)+"' AND '"+Dtos(mv_par02)+"'
	cQry += CRLF+"		AND SC9.C9_DTLICRD <> ' '
	cQry += CRLF+"		AND SC9.C9_BLCRED = '10'
	cQry += CRLF+"GROUP BY C9_PEDIDO,C9_CLIENTE, A1_CGC ,C9_LOJA, A1_NREDUZ,A1_YDCANAL, C5_EMISSAO, C9_DTLICRD, C9_DATALIB, A1_YLEGEND, SA3.A3_COD,SA3.A3_NOME
	cQry += CRLF+"UNION	
	cQry += CRLF+"SELECT 'PARADO' AS TIPO,
	cQry += CRLF+"			C9_PEDIDO PEDIDO,
	cQry += CRLF+"			C9_CLIENTE CLIENTE,
	cQry += CRLF+"	   	A1_CGC CPFCNPJ,
	cQry += CRLF+"			C9_LOJA LOJA,
	cQry += CRLF+"			A1_NREDUZ N_FANTASIA,
	cQry += CRLF+"		 	A1_YDCANAL CANAL,
	cQry += CRLF+"			SUBSTR(C5_EMISSAO,7,2)||'/'||SUBSTR(C5_EMISSAO,5,2)||'/'||SUBSTR(C5_EMISSAO,1,4) EMISSAO,
	cQry += CRLF+"			A1_YLEGEND YLEGEND,
	cQry += CRLF+"		   ' ' MOTIVO,
	cQry += CRLF+"			sum(sc9.C9_QTDLIB * sc9.C9_PRCVEN) AS Valor_Merc,
	cQry += CRLF+"			' ' Datalib,
	cQry += CRLF+"			' ' Usuario,
	cQry += CRLF+"			' ' DATACR,
	cQry += CRLF+"			' ' HORA,
	cQry += CRLF+"		 	SA3.A3_COD COD_VEND,
	cQry += CRLF+"		    SA3.A3_NOME NOME_VEND
	cQry += CRLF+"FROM "+RetSQLName("SC9")+" SC9
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SA1")+" SA1
	cQry += CRLF+"		ON SC9.C9_CLIENTE = SA1.A1_COD
	cQry += CRLF+"		AND SC9.C9_LOJA = SA1.A1_LOJA
	cQry += CRLF+"	LEFT OUTER JOIN "+RetSQLName("SC5")+" SC5
	cQry += CRLF+"		ON SC5.C5_FILIAL = '"+xFilial("SC5")+"'
	cQry += CRLF+"		AND SC9.C9_PEDIDO = SC5.C5_NUM
	cQry += CRLF+"		AND SC9.C9_CLIENTE = SC5.C5_CLIENTE
	cQry += CRLF+"		AND SC9.C9_LOJA = SC5.C5_LOJACLI
	cQry += CRLF+"	LEFT JOIN "+RetSQLName("SA3")+" SA3
	cQry += CRLF+"		ON SA1.A1_VEND = SA3.A3_COD
	cQry += CRLF+"WHERE SC9.C9_DATALIB BETWEEN '"+DtoS(mv_par01)+"' AND '"+Dtos(mv_par02)+"'
	cQry += CRLF+"		AND C9_BLCRED <> '10'
	cQry += CRLF+"		AND C9_BLCRED <> ' '
	cQry += CRLF+"		AND C9_BLCRED <> '09'
	cQry += CRLF+"GROUP BY C9_PEDIDO,C9_CLIENTE, A1_CGC, C9_LOJA, A1_NREDUZ, A1_YDCANAL, C5_EMISSAO, C9_DTLICRD, C9_DATALIB, A1_YLEGEND, SA3.A3_COD,SA3.A3_NOME
	cQry += CRLF+"ORDER BY PEDIDO
//Endif

cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")

If !lAuto
	oReport:section(1):Init()
	oReport:SetMeter(LastRec())
	While cArqTRB->(!EOF())
		oReport:IncMeter()
		oReport:section(1):PrintLine()
		dbskip()
	EndDo
Else
	EnviaRel() //Monta arquivo Excel e envia por e-mail
EndIf

DbSelectArea("cArqTRB")

dbclosearea()

If !lAuto
	oReport:Section(1):PageBreak()
EndIf


Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �AjustaSX1 � Autor �Marco Bianchi          � Data �10/11/2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Acerta o arquivo de perguntas                               ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSx1()
Local aArea := GetArea()

PutSx1("ZRCredi","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("ZRCredi","02","Data at�" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
//PutSx1("ZRCredi","03","Aprov.Rejei/Parado","","","mv_ch3","N",1,0,1,"C","","","","","mv_par03","Aprova ou Rejeita","Aprova ou Rejeita","Aprova ou Rejeita","Parado","Parado","Parado","","","","","","","","","","")
//retirado por Rogerio, solicitacao de Terezinha

RestArea(aArea)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ZRCREDI   �Autor  �Microsiga           � Data �  03/06/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function EnviaRel()

Local cArq
Local cPath
Local nArq
Local cPara := SuperGetMV("NC_ZRCREDI", .F., "lfelipe@ncgames.com.br")
Local cMsg := "", cFile := ""
Local xRet
Local oServer, oMessage 

Local cUser 	:= GetNewPar("MV_RELACNT","")
Local cPass 	:= GetNewPar("MV_RELAPSW","")
Local cSendSrv 	:= GetNewPar("MV_RELSERV","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Local nSmtpPort := GetNewPar("MV_GCPPORT","")

If cArqTRB->(Eof())
	Return
EndIf
       
If At(":",cSendSrv) > 0
	cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
EndIf

cArq := "PEDIDOS_"+DTOS(DDATABASE)+"-"+SUBSTR(TIME(),1,2)+"-"+SUBSTR(TIME(),4,2)+"-"+SUBSTR(TIME(),7,2)
cPath:= "\SYSTEM\"
nArq  := FCreate(cPath + cArq + ".CSV")

cCabec := "TIPO;PEDIDO;EMISSAO;CLIENTE;CPFCNPJ;LOJA;N_FANTASIA;CANAL;MOTIVO;REJEICAO;VALOR_MERC;Datalib;USUARIO;DATACR;HORA;COD VEND;Nome Vend;"+CRLF
fWrite(nArq,cCabec)

dbSelectArea("cArqTRB")
dbGoTop()
While !Eof()
	cLinha := cArqTRB->TIPO+";'"+cArqTRB->PEDIDO+";"+cArqTRB->EMISSAO+";'"+cArqTRB->CLIENTE+";'"+cArqTRB->CPFCNPJ+";'"+cArqTRB->LOJA+";"+;
	cArqTRB->N_FANTASIA+";"+cArqTRB->CANAL+";"+cArqTRB->YLEGEND+";"+cArqTRB->MOTIVO+";"+AllTrim(TRANSFORM(cArqTRB->VALOR_MERC,'@E 999,999.99' ))+";"+cArqTRB->Datalib+";"+;
	cArqTRB->USUARIO+";"+cArqTRB->DATACR+";"+cArqTRB->HORA+";"+cArqTRB->COD_VEND+";"+cArqTRB->NOME_VEND+";"+CRLF
	fwrite(nArq,cLinha)
	dbSkip()
End

fClose(nArq)

cFile := cPath + cArq + ".CSV"

oMessage := TMailMessage():New()
oMessage:Clear()

oMessage:cDate := cValToChar( Date() )

oMessage:cFrom 		:= "workflow@ncgames.com.br"
oMessage:cTo 		:= cPara
oMessage:cSubject 	:= "ANALISE DE CR�DITO -- Pedidos Parados e Analisados"
oMessage:cBody 		:= "Segue rela��o de pedidos parados e analisados em " + DtoC(dDatabase) + "."
xRet := oMessage:AttachFile( cFile )
if xRet < 0
	cMsg := "Could not attach file " + cFile
	conout( cMsg )
	return
endif

oServer := tMailManager():New()
oServer:SetUseSSL( .T. )

xRet := oServer:Init( "", cSendSrv, cUser, cPass, , nSmtpPort )
if xRet != 0
	cMsg := "Could not initialize SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	return
endif

xRet := oServer:SetSMTPTimeout( 60 )
if xRet != 0
	cMsg := "Could not set timeout to " + cValToChar( nTimeout )
	conout( cMsg )
endif

xRet := oServer:SMTPConnect()
if xRet <> 0
	cMsg := "Could not connect on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	return
endif

xRet := oServer:SmtpAuth( cUser, cPass )
if xRet <> 0
	cMsg := "Could not authenticate on SMTP server: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	oServer:SMTPDisconnect()
endif

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

FERASE(cPath + cArq + ".CSV")

Return Nil
