#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SC5DIGI   �Autor  �Lucas di Oliveira   � Data �  10/31/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Relat�rio desenvolvido, para ADM ter o controle de lan�a   ���
���          � mento dos pedidos                                          ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function SC5Digi()

Local oReport 


oReport := ReportDef()
oReport:PrintDialog()

Return


Static Function ReportDef()

Local oReport
Local oNoAtend
Local aFiles := {}
Local cEmailTrack
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario


oReport := TReport():New("C5digit","Usu�rio de digita��o de pedidos","C5digit", {|oReport| ReportPrint(oReport,oNoAtend)},"")

oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
AjustaSx1()
Pergunte(oReport:uParam,.F.)

oNoAtend := TRSection():New(oReport,"DigitaPed",{"SC6","SC5","SA1"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oNoAtend:SetTotalInLine(.F.)

//TRCell():New(oNoAtend,"CODPRO"		,"cArqTRB",RetTitle("ZD_CODPRO"),PesqPict("SZD","ZD_CODPRO")	,TamSx3("ZD_CODPRO")  	[1]	,/*lPixel*/,/*{|| cVend }*/	)// "Codigo do Cliente"
TRCell():New(oNoAtend,"PEDIDO"		 	,"cArqTRB","Pedido"		 		,PesqPict("SC6","C6_NUM")		,TamSx3("C6_NUM")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"EMISSAO"	   	 	,"cArqTRB","Emiss�o"			,PesqPict("SC5","C5_EMISSAO")	,TamSx3("C5_EMISSAO")	[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"CODCLI" 	   	 	,"cArqTRB","C�digo"				,PesqPict("SC6","C6_CLI")		,TamSx3("C6_CLI")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"LOJA"   	     	,"cArqTRB","Loja"	 			,PesqPict("SC6","C6_LOJA")		,TamSx3("C6_LOJA")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"RAZAOSOCIAL"		,"cArqTRB","Raz�o Social"		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"UF"			 	,"cArqTRB","UF"	  				,PesqPict("SA1","A1_EST")		,TamSx3("A1_EST")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"cLInc"			,	   	  ,"Log Inclus�o"		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)
TRCell():New(oNoAtend,"cLAlt"			,		  ,"Log Altera��o"		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cVend }*/	)



cEmailTrack:= "ebuttner@ncgames.com.br;lfelipe@ncgames.com.br"
U_ENVIAEMAIL(cEmailTrack, ,,"RELATORIO DE ALTERA��O PEDIDO","FOI GERADO O RELATORIO."+DTOS(DDATABASE)+"-"+TIME()+"-"+ALLTRIM(Upper(cUsername)), aFiles)

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
��� 31/10/12 � Lucas Oliveira�Altera��o para criar relat�rio de log SC5   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportPrint(oReport,oNoAtend)

Local cLogInc := 0
Local cLogAlt:= 0
Local cLInc := ""
Local cLAlt := ""

//oReport:Section(1):Cell("cLInc" ):SetBlock({|| cLInc })
//oReport:Section(1):Cell("cLAlt" ):SetBlock({|| cLAlt })

cQry := ""
cQry += CRLF+"SELECT C5_NUM PEDIDO, SUBSTR(C5_EMISSAO,7,2)||'/'||substr(C5_EMISSAO,5,2)||'/'||substr(C5_EMISSAO,1,4) EMISSAO,
cQry += CRLF+"C5_CLIENTE CODCLI, C5_LOJAENT LOJA, A1_NOME RAZAOSOCIAL, A1_EST UF, C5_USERLGI LOGINCLUI, C5_USERLGA LOGALTER
cQry += CRLF+"FROM SC5010 SC5, SA1010 SA1
cQry += CRLF+"WHERE SC5.D_E_L_E_T_ = ' ' AND SA1.D_E_L_E_T_ = ' '
cQry += CRLF+"AND SC5.C5_CLIENTE = SA1.A1_COD
cQry += CRLF+"AND SC5.C5_LOJAENT = SA1.A1_LOJA
cQry += CRLF+"AND SC5.C5_EMISSAO BETWEEN '"+DtoS(mv_par01)+"' AND '"+DtoS(mv_par02)+"'

cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")
oReport:Section(1):Cell("cLInc" ):SetBlock({|| cLInc })
oReport:Section(1):Cell("cLAlt" ):SetBlock({|| cLAlt })
oReport:section(1):Init()
oReport:SetMeter(LastRec())

While cArqTRB->(!EOF())
	oReport:IncMeter()
	cLogInc := Subs(Embaralha( LOGINCLUI, 1), 1, 15)
	cLInc 	:= AllTrim(UsrFullName(SubStr(cLogInc,3,6)))
	cLogAlt := Subs(Embaralha( LOGALTER, 1), 1, 15)
	cLAlt 	:= AllTrim(UsrFullName(SubStr(cLogAlt,3,6)))
	
	oReport:section(1):PrintLine()
	dbskip()
EndDo
DbSelectArea("cArqTRB")

dbclosearea()
oReport:Section(1):PageBreak()


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

PutSx1("C5digit","01","Data de" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1("C5digit","02","Data at�" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")

RestArea(aArea)

Return

